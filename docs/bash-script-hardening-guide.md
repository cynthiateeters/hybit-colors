# Bash script hardening guide

A comprehensive reference for writing secure, robust, and maintainable bash scripts.

**Audience:** Developers and AI assistants writing bash scripts

**Last updated:** 2025-10-14

## Table of contents

- [Shell defaults and error handling](#shell-defaults-and-error-handling)
- [Input validation and sanitization](#input-validation-and-sanitization)
- [Command injection prevention](#command-injection-prevention)
- [Path handling and file operations](#path-handling-and-file-operations)
- [Error handling and cleanup](#error-handling-and-cleanup)
- [Tool and dependency checking](#tool-and-dependency-checking)
- [Output and logging](#output-and-logging)
- [Portability considerations](#portability-considerations)
- [Testing and validation](#testing-and-validation)
- [Documentation requirements](#documentation-requirements)
- [Security checklist](#security-checklist)
- [Common vulnerabilities](#common-vulnerabilities)

## Shell defaults and error handling

### Set strict error handling

**Always include at the top of every script:**

```bash
#!/bin/bash
set -Eeuo pipefail
IFS=$'\n\t'
```

**What each flag does:**

- `set -e` - Exit immediately if any command exits with non-zero status
- `set -E` - Ensure ERR trap is inherited by shell functions
- `set -u` - Exit if script references undefined variables
- `set -o pipefail` - Pipeline fails if any command in it fails (not just the last)
- `IFS=$'\n\t'` - Set Internal Field Separator to newline and tab only (prevents word splitting on spaces)

**Why this matters:**

```bash
# WITHOUT set -e
rm -rf /important/data  # Fails silently
echo "Data deleted successfully!"  # Still runs, misleading user

# WITH set -e
rm -rf /important/data  # Script exits immediately on error
echo "Data deleted successfully!"  # Never runs
```

### Use errexit-safe patterns

Some commands naturally return non-zero exit codes. Handle them explicitly:

```bash
# WRONG - script exits if grep finds nothing
if grep "pattern" file.txt; then
    echo "Found"
fi

# RIGHT - explicitly handle both cases
if grep "pattern" file.txt; then
    echo "Found"
else
    echo "Not found"
fi

# RIGHT - disable errexit temporarily if needed
set +e
grep "pattern" file.txt
exit_code=$?
set -e
if [ $exit_code -eq 0 ]; then
    echo "Found"
fi
```

## Input validation and sanitization

### Always validate user input

**Never trust user input. Always validate:**

```bash
# Get input
read -r -p "Enter project name: " PROJECT_NAME

# Trim whitespace
PROJECT_NAME="$(echo "$PROJECT_NAME" | xargs)"

# Validate non-empty
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: Project name cannot be empty"
    exit 1
fi

# Validate character set (alphanumeric, hyphens, underscores only)
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Error: Project name can only contain letters, numbers, hyphens, and underscores"
    exit 1
fi

# Validate length
if [ ${#PROJECT_NAME} -gt 50 ]; then
    echo "Error: Project name too long (max 50 characters)"
    exit 1
fi

# Reject dangerous patterns
if [[ "$PROJECT_NAME" =~ ^[.-] ]]; then
    echo "Error: Project name cannot start with '.' or '-'"
    exit 1
fi

# Reject path traversal attempts
if [[ "$PROJECT_NAME" == "." || "$PROJECT_NAME" == ".." ]]; then
    echo "Error: Project name cannot be '.' or '..'"
    exit 1
fi
```

### Use read -r for all user input

**Always use `read -r` to prevent backslash interpretation:**

```bash
# WRONG - backslashes are interpreted as escape sequences
read -p "Enter path: " USER_PATH

# RIGHT - backslashes are treated literally
read -r -p "Enter path: " USER_PATH
```

## Command injection prevention

### Escape special characters for sed/awk

**Problem:** User input containing `/`, `&`, or other special characters breaks sed:

```bash
# VULNERABLE
LAB_THEME="My Theme / Tutorial"
sed -i "s/PLACEHOLDER/$LAB_THEME/g" file.html  # BREAKS on slash

# VULNERABLE TO INJECTION
LAB_THEME='"; rm -rf /; echo "'
sed -i "s/PLACEHOLDER/$LAB_THEME/g" file.html  # Could execute malicious code
```

**Solution 1: Use alternate delimiter**

```bash
# Use | instead of / as delimiter
sed "s|PLACEHOLDER|$LAB_THEME|g" file.html
```

**Solution 2: Escape special characters**

```bash
# Escape function
escape_sed() {
    printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'
}

LAB_THEME_ESCAPED="$(escape_sed "$LAB_THEME")"
sed "s|PLACEHOLDER|${LAB_THEME_ESCAPED}|g" file.html
```

**Solution 3: Use temp file (most portable)**

```bash
escape_sed() {
    printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'
}

LAB_THEME_ESCAPED="$(escape_sed "$LAB_THEME")"
tmpfile="$(mktemp)"
sed "s|PLACEHOLDER|${LAB_THEME_ESCAPED}|g" input.html > "$tmpfile" && mv "$tmpfile" input.html
```

### Quote all variable expansions

**Always quote variables to prevent word splitting and globbing:**

```bash
# WRONG - vulnerable to word splitting
cp $SOURCE_FILE $DEST_DIR

# RIGHT - safely handles spaces and special characters
cp "$SOURCE_FILE" "$DEST_DIR"

# WRONG - vulnerable in command substitution
FILES=$(ls *.txt)
for file in $FILES; do
    echo $file
done

# RIGHT - preserve spaces in filenames
while IFS= read -r file; do
    echo "$file"
done < <(find . -name "*.txt")
```

### Escape variables in git commit messages

```bash
# WRONG - quotes in theme break command
git commit -m "Initial commit: $LAB_THEME"

# RIGHT - escape quotes
THEME_ESCAPED="${LAB_THEME//\"/\\\"}"
git commit -m "Initial commit: ${THEME_ESCAPED}"
```

## Path handling and file operations

### Always use absolute paths

```bash
# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get parent directory
TEMPLATE_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

# Use absolute paths for all operations
rsync -a "$TEMPLATE_DIR/" "$PROJECT_NAME/"
```

### Validate paths before destructive operations

```bash
# WRONG - dangerous if variable is empty or wrong
rm -rf $PROJECT_DIR

# RIGHT - validate before removing
if [ -z "$PROJECT_DIR" ]; then
    echo "Error: PROJECT_DIR is not set"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: $PROJECT_DIR is not a directory"
    exit 1
fi

# Additional safety: ensure it's in expected location
if [[ "$PROJECT_DIR" != "$HOME/projects/"* ]]; then
    echo "Error: PROJECT_DIR is not in expected location"
    exit 1
fi

rm -rf "$PROJECT_DIR"
```

### Check file/directory existence before operations

```bash
# Before reading
if [ ! -f "config.json" ]; then
    echo "Error: config.json not found"
    exit 1
fi

# Before writing
if [ -f "output.txt" ]; then
    echo "Warning: output.txt already exists"
    read -r -p "Overwrite? (y/n): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# Before directory operations
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist"
    exit 1
fi
```

### Use rsync instead of cp for complex copies

```bash
# WRONG - copies everything including unwanted files
cp -r "$TEMPLATE_DIR" "$PROJECT_NAME"

# RIGHT - exclude unwanted files
rsync -a \
    --exclude '.git' \
    --exclude 'node_modules' \
    --exclude 'dist' \
    --exclude 'coverage' \
    --exclude '.DS_Store' \
    --exclude '*.log' \
    "$TEMPLATE_DIR/" "$PROJECT_NAME/"
```

### Verify operations succeeded

```bash
# After copy, verify directory exists and is non-empty
if [ ! -d "$PROJECT_NAME" ]; then
    echo "Error: Failed to create project directory"
    exit 1
fi

if [ -z "$(ls -A "$PROJECT_NAME" 2>/dev/null)" ]; then
    echo "Error: Project directory is empty after copy"
    exit 1
fi
```

## Error handling and cleanup

### Use trap for cleanup

**Always clean up partial work on error:**

```bash
# Track whether cleanup is needed
CLEANUP_NEEDED=false
TEMP_DIR=""

# Cleanup function
cleanup() {
    if [ "$CLEANUP_NEEDED" = true ] && [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
        echo "Cleaning up..."
        rm -rf "$TEMP_DIR"
    fi
}

# Set trap to run cleanup on exit, error, interrupt, or termination
trap cleanup EXIT ERR INT TERM

# Your script logic
TEMP_DIR="$(mktemp -d)"
CLEANUP_NEEDED=true

# ... do work ...

# Disable cleanup on success
CLEANUP_NEEDED=false
```

### Handle failures gracefully

```bash
# For non-critical operations, catch failures
if ! npm install; then
    echo "Warning: npm install failed. You can run it manually later."
    # Continue script execution
fi

# For critical operations, exit immediately
if ! git init; then
    echo "Error: Failed to initialize git repository"
    exit 1
fi
```

### Provide helpful error messages

```bash
# WRONG - cryptic error
command not found: xyz

# RIGHT - explain what went wrong and how to fix it
echo "Error: Required command 'xyz' not found"
echo "Please install xyz with: brew install xyz"
exit 1
```

## Tool and dependency checking

### Check for required commands

**Check before using any external command:**

```bash
# Check for required tools
if ! command -v git >/dev/null 2>&1; then
    echo "Error: git is not installed or not in PATH"
    echo "Please install git: https://git-scm.com/downloads"
    exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
    echo "Error: npm is not installed or not in PATH"
    echo "Please install Node.js (includes npm): https://nodejs.org/"
    exit 1
fi

if ! command -v rsync >/dev/null 2>&1; then
    echo "Error: rsync is not installed or not in PATH"
    echo "Install with: brew install rsync (macOS) or apt-get install rsync (Ubuntu)"
    exit 1
fi
```

### Check for optional tools with fallbacks

```bash
# Prefer modern tool, fallback to standard tool
if command -v rg >/dev/null 2>&1; then
    SEARCH_CMD="rg"
elif command -v ag >/dev/null 2>&1; then
    SEARCH_CMD="ag"
elif command -v grep >/dev/null 2>&1; then
    SEARCH_CMD="grep"
else
    echo "Error: No search tool available"
    exit 1
fi
```

### Validate tool versions if needed

```bash
# Check git version for features
GIT_VERSION=$(git --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
REQUIRED_VERSION="2.28.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$GIT_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "Warning: git version $GIT_VERSION is older than recommended $REQUIRED_VERSION"
    echo "Some features may not work correctly"
fi
```

## Output and logging

### Use consistent output formatting

```bash
# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Use printf for portability (not echo -e)
print_error() {
    printf "${RED}Error: %s${NC}\n" "$1" >&2
}

print_success() {
    printf "${GREEN}Success: %s${NC}\n" "$1"
}

print_warning() {
    printf "${YELLOW}Warning: %s${NC}\n" "$1" >&2
}

print_info() {
    printf "${BLUE}Info: %s${NC}\n" "$1"
}

# Usage
print_error "File not found"
print_success "Project created"
print_warning "npm install failed"
print_info "Starting initialization"
```

### Send errors to stderr

```bash
# WRONG - errors go to stdout
echo "Error: Something went wrong"

# RIGHT - errors go to stderr
echo "Error: Something went wrong" >&2

# Or use helper function
print_error() {
    printf "${RED}Error: %s${NC}\n" "$1" >&2
}
```

### Add verbose/debug modes

```bash
# Parse flags
VERBOSE=false
DEBUG=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -d|--debug)
            DEBUG=true
            VERBOSE=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Conditional logging
log_verbose() {
    if [ "$VERBOSE" = true ]; then
        echo "$1"
    fi
}

log_debug() {
    if [ "$DEBUG" = true ]; then
        echo "[DEBUG] $1"
    fi
}

# Usage
log_verbose "Copying template files..."
log_debug "Source: $TEMPLATE_DIR, Dest: $PROJECT_NAME"
```

## Portability considerations

### Detect platform differences

```bash
# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    SED_FLAGS="-i ''"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    SED_FLAGS="-i"
else
    echo "Warning: Unsupported OS: $OSTYPE"
fi
```

### Use portable sed patterns

```bash
# WRONG - platform-specific inline editing
sed -i '' "s/old/new/g" file.txt  # macOS only
sed -i "s/old/new/g" file.txt     # Linux only

# RIGHT - use temp file (works everywhere)
tmpfile="$(mktemp)"
sed "s/old/new/g" file.txt > "$tmpfile" && mv "$tmpfile" file.txt
```

### Avoid bashisms in sh scripts

If your shebang is `#!/bin/sh`, avoid bash-specific features:

```bash
# WRONG in sh - bash-specific
if [[ "$VAR" =~ ^[0-9]+$ ]]; then
    echo "Is number"
fi

# RIGHT in sh - POSIX-compatible
if echo "$VAR" | grep -qE '^[0-9]+$'; then
    echo "Is number"
fi

# Or just use bash explicitly
#!/bin/bash
```

## Testing and validation

### Add test plan as comments

```bash
#!/bin/bash
#
# Script description
#
# Quick test plan:
# 1) Happy path: Run with valid inputs, confirm success
# 2) Edge case: Run with empty input, should error
# 3) Security: Run with malicious input (slashes, quotes), should handle safely
# 4) Missing deps: Unset PATH, should fail with helpful message
# 5) Partial failure: Interrupt mid-execution, should clean up
```

### Add dry-run mode

```bash
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            echo "DRY RUN MODE - No changes will be made"
            shift
            ;;
    esac
done

# Wrap destructive operations
if [ "$DRY_RUN" = false ]; then
    rm -rf "$TARGET_DIR"
else
    echo "[DRY RUN] Would remove: $TARGET_DIR"
fi
```

### Test with shellcheck

```bash
# Install shellcheck
brew install shellcheck  # macOS
apt-get install shellcheck  # Ubuntu

# Run shellcheck
shellcheck script.sh

# Address all warnings before deploying
```

## Documentation requirements

### Script header

```bash
#!/bin/bash
#
# Script Name: init-new-project.sh
# Description: Initialize a new learning lab from the HAP template
# Author: Your Name
# Date: 2025-10-14
# Version: 1.0.0
#
# Usage: ./init-new-project.sh [OPTIONS]
#
# Options:
#   --dry-run    Show what would be done without making changes
#   --verbose    Show detailed output
#   --help       Display this help message
#
# Examples:
#   ./init-new-project.sh
#   ./init-new-project.sh --dry-run
#
# Dependencies:
#   - git (>= 2.28)
#   - npm (>= 8.0)
#   - rsync
#
# Quick test plan:
# 1) Fresh run with valid inputs
# 2) Run with existing directory name
# 3) Run with special characters in input
# 4) Run without required tools
# 5) Interrupt mid-execution
```

### Add help text

```bash
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Initialize a new learning lab from the HAP template

OPTIONS:
    --dry-run       Show what would be done without making changes
    --verbose       Show detailed output
    -h, --help      Display this help message

EXAMPLES:
    $0
    $0 --dry-run
    $0 --verbose

REQUIREMENTS:
    - git (version 2.28 or higher)
    - npm (version 8.0 or higher)
    - rsync

For more information, see docs/claude-code-tutorial.md
EOF
}

# Parse help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi
```

## Security checklist

Before deploying any bash script, verify:

- [ ] Uses `set -Eeuo pipefail` and `IFS=$'\n\t'`
- [ ] All user input is validated and sanitized
- [ ] All variables are quoted: `"$VAR"` not `$VAR`
- [ ] Uses `read -r` for all user input
- [ ] Escapes special characters for sed/awk/git
- [ ] Uses absolute paths for all file operations
- [ ] Validates paths before destructive operations (rm, mv)
- [ ] Checks for required commands with `command -v`
- [ ] Has trap for cleanup on error
- [ ] Sends errors to stderr
- [ ] Provides helpful error messages
- [ ] Has test plan documented
- [ ] Tested with shellcheck
- [ ] Has help text
- [ ] Exits with appropriate exit codes (0 success, 1 error)

## Common vulnerabilities

### Command injection via unsanitized input

**Vulnerable:**

```bash
read -p "Enter filename: " FILENAME
cat $FILENAME  # User enters: "; rm -rf /; echo "
```

**Fixed:**

```bash
read -r -p "Enter filename: " FILENAME
if [[ ! "$FILENAME" =~ ^[a-zA-Z0-9._-]+$ ]]; then
    echo "Error: Invalid filename"
    exit 1
fi
cat "$FILENAME"
```

### Path traversal via user input

**Vulnerable:**

```bash
read -p "Enter directory: " DIR
cd "$DIR"  # User enters: ../../../etc
```

**Fixed:**

```bash
read -r -p "Enter directory: " DIR
# Validate no path traversal
if [[ "$DIR" =~ \.\. ]]; then
    echo "Error: Path traversal not allowed"
    exit 1
fi
# Ensure it's within expected location
if [[ "$DIR" != "$HOME/projects/"* ]]; then
    echo "Error: Directory must be in $HOME/projects/"
    exit 1
fi
cd "$DIR"
```

### Race conditions with temp files

**Vulnerable:**

```bash
TMPFILE="/tmp/myapp_$$"
echo "data" > "$TMPFILE"  # Another process could create this first
```

**Fixed:**

```bash
TMPFILE="$(mktemp)"  # Creates unique file atomically
echo "data" > "$TMPFILE"
```

### Dangerous default values

**Vulnerable:**

```bash
TARGET_DIR=${1:-/}  # Defaults to root!
rm -rf "$TARGET_DIR"/*
```

**Fixed:**

```bash
if [ -z "$1" ]; then
    echo "Error: TARGET_DIR required"
    exit 1
fi
TARGET_DIR="$1"
# Validate before destructive operation
if [[ "$TARGET_DIR" != "$HOME/projects/"* ]]; then
    echo "Error: TARGET_DIR must be in $HOME/projects/"
    exit 1
fi
rm -rf "$TARGET_DIR"/*
```

### Unquoted variable in tests

**Vulnerable:**

```bash
if [ $USER_INPUT = "admin" ]; then  # Fails if USER_INPUT is empty
    echo "Admin access granted"
fi
```

**Fixed:**

```bash
if [ "$USER_INPUT" = "admin" ]; then  # Safe even if empty
    echo "Admin access granted"
fi
```

## Additional resources

- [ShellCheck](https://www.shellcheck.net/) - Static analysis tool for shell scripts
- [Bash Pitfalls](https://mywiki.wooledge.org/BashPitfalls) - Common bash mistakes
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Defensive BASH Programming](https://kfirlavi.herokuapp.com/blog/2012/11/14/defensive-bash-programming/)

## Quick reference card

### Essential patterns to always use

```bash
#!/bin/bash
set -Eeuo pipefail
IFS=$'\n\t'

# Cleanup trap
cleanup() {
    # cleanup code
}
trap cleanup EXIT ERR INT TERM

# Check dependencies
if ! command -v git >/dev/null 2>&1; then
    echo "Error: git not found" >&2
    exit 1
fi

# Validate user input
read -r -p "Enter name: " NAME
NAME="$(echo "$NAME" | xargs)"
if [ -z "$NAME" ]; then
    echo "Error: Name cannot be empty" >&2
    exit 1
fi
if [[ ! "$NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Error: Invalid characters in name" >&2
    exit 1
fi

# Escape for sed
escape_sed() {
    printf '%s' "$1" | sed -e 's/[\/&]/\\&/g'
}
NAME_ESCAPED="$(escape_sed "$NAME")"

# Safe sed with temp file
tmpfile="$(mktemp)"
sed "s|PLACEHOLDER|${NAME_ESCAPED}|g" input.txt > "$tmpfile" && mv "$tmpfile" input.txt

# Quote all variables
cp "$SOURCE" "$DEST"

# Exit with appropriate code
exit 0
```
