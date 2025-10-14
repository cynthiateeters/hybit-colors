#!/bin/bash
#
# Script Name: validate-placeholders.sh
# Description: Check for any remaining [PLACEHOLDER] text in HTML files
# Author: HAP Learning Lab Template
# Date: 2025-10-14
# Version: 1.0.0
#
# Usage: ./validate-placeholders.sh [OPTIONS] [DIRECTORY]
#
# Options:
#   --verbose    Show all files checked, not just failures
#   --help       Display this help message
#
# Examples:
#   ./validate-placeholders.sh
#   ./validate-placeholders.sh --verbose
#   ./validate-placeholders.sh /path/to/project
#
# Dependencies:
#   - grep
#   - find
#
# Quick test plan:
# 1) Run on template with placeholders - should find them
# 2) Run on fully customized project - should pass
# 3) Run with --verbose - should show all files checked
# 4) Run on missing directory - should error gracefully
# 5) Run without grep - should error with helpful message

# Safer shell defaults
set -Eeuo pipefail
IFS=$'\n\t'

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Options
VERBOSE=false
TARGET_DIR="."

# Helper function for safe printing (portable across BSD/GNU)
print_color() {
    printf "%b" "$1"
}

print_error() {
    printf "${RED}Error: %s${NC}\n" "$1" >&2
}

print_success() {
    printf "${GREEN}%s${NC}\n" "$1"
}

print_warning() {
    printf "${YELLOW}Warning: %s${NC}\n" "$1" >&2
}

print_info() {
    printf "${BLUE}%s${NC}\n" "$1"
}

# Show help text
show_help() {
    cat << 'EOF'
Usage: validate-placeholders.sh [OPTIONS] [DIRECTORY]

Check for any remaining [PLACEHOLDER] text in HTML files

OPTIONS:
    --verbose       Show all files checked, not just failures
    -h, --help      Display this help message

ARGUMENTS:
    DIRECTORY       Directory to check (default: current directory)

EXAMPLES:
    ./validate-placeholders.sh
    ./validate-placeholders.sh --verbose
    ./validate-placeholders.sh /path/to/project

PLACEHOLDERS CHECKED:
    - [YOUR THEME]
    - [YOUR TOPICS]
    - [STATION TITLE]
    - [STATION DESCRIPTION]
    - Any other text in square brackets matching [A-Z ]

EXIT CODES:
    0   No placeholders found
    1   Placeholders found or error occurred

For more information, see docs/claude-code-tutorial.md
EOF
}

# Check for required commands
if ! command -v grep >/dev/null 2>&1; then
    print_error "grep is not installed or not in PATH"
    print_info "grep should be available on all Unix systems"
    exit 1
fi

if ! command -v find >/dev/null 2>&1; then
    print_error "find is not installed or not in PATH"
    print_info "find should be available on all Unix systems"
    exit 1
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            print_error "Unknown option: $1"
            print_info "Use --help for usage information"
            exit 1
            ;;
        *)
            # Assume it's the target directory
            TARGET_DIR="$1"
            shift
            ;;
    esac
done

# Validate target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    print_error "Directory does not exist: $TARGET_DIR"
    exit 1
fi

# Get absolute path
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

# Print header
print_color "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}\n"
print_color "${BLUE}║              HAP Placeholder Validation Script              ║${NC}\n"
print_color "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}\n"
print_color "\n"

print_info "Checking directory: $TARGET_DIR"
print_color "\n"

# Combined placeholder pattern to avoid double-counting
# Matches: [YOUR THEME], [YOUR TOPICS], [STATION ...], [YOUR ...], or generic [UPPERCASE ...]
COMBINED_PATTERN='\[(YOUR THEME|YOUR TOPICS|STATION [A-Z ]+|YOUR [A-Z ]+|[A-Z][A-Z ]+)\]'

# Track results
TOTAL_FILES=0
FILES_WITH_PLACEHOLDERS=0
TOTAL_PLACEHOLDERS=0

# Store results for detailed reporting
declare -a PLACEHOLDER_FILES
declare -a PLACEHOLDER_DETAILS

# Find all HTML files
print_info "Searching for HTML files..."

# Use while loop with process substitution for safe file handling
# Skip common build/dependency directories
while IFS= read -r file; do
    TOTAL_FILES=$((TOTAL_FILES + 1))

    if [ "$VERBOSE" = true ]; then
        print_info "Checking: $file"
    fi

    # Check for placeholders using combined pattern
    if grep_result=$(grep -nHE "$COMBINED_PATTERN" "$file" 2>/dev/null); then
        FILES_WITH_PLACEHOLDERS=$((FILES_WITH_PLACEHOLDERS + 1))
        PLACEHOLDER_FILES+=("$file")

        # Count unique placeholders (avoid counting same line multiple times)
        placeholder_count=$(printf '%s\n' "$grep_result" | wc -l | xargs)
        TOTAL_PLACEHOLDERS=$((TOTAL_PLACEHOLDERS + placeholder_count))

        # Store details for reporting
        PLACEHOLDER_DETAILS+=("$grep_result")
    fi

done < <(find "$TARGET_DIR" -type f \( -iname "*.html" -o -iname "*.htm" \) \
         -not -path "*/node_modules/*" \
         -not -path "*/dist/*" \
         -not -path "*/coverage/*")

# Print results
print_color "\n"
print_color "${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
print_color "${BLUE}                          Results                              ${NC}\n"
print_color "${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
print_color "\n"

print_info "Files checked: $TOTAL_FILES"
print_color "\n"

if [ $FILES_WITH_PLACEHOLDERS -eq 0 ]; then
    # Success - no placeholders found
    print_success "✓ No placeholders found!"
    print_color "\n"
    print_success "All HTML files have been customized."
    print_color "\n"
    exit 0
else
    # Failure - placeholders found
    print_warning "✗ Found $TOTAL_PLACEHOLDERS placeholder(s) in $FILES_WITH_PLACEHOLDERS file(s)"
    print_color "\n"

    # Show detailed results
    print_color "${YELLOW}Files with placeholders:${NC}\n"
    print_color "\n"

    for detail in "${PLACEHOLDER_DETAILS[@]}"; do
        # Parse grep output: filename:line:content
        while IFS= read -r line; do
            # Extract filename (everything before first colon)
            file_path="${line%%:*}"
            # Get relative path from target directory
            rel_path="${file_path#$TARGET_DIR/}"
            # Extract line number and content
            rest="${line#*:}"
            line_num="${rest%%:*}"
            content="${rest#*:}"

            # Print formatted result
            print_color "  ${RED}✗${NC} ${BLUE}$rel_path${NC}:${YELLOW}$line_num${NC}\n"
            print_color "    ${content}\n"
            print_color "\n"
        done <<< "$detail"
    done

    # Provide helpful next steps
    print_color "${YELLOW}Next steps:${NC}\n"
    print_color "\n"
    print_color "  1. Review the files listed above\n"
    print_color "  2. Replace placeholders with your content\n"
    print_color "  3. Run this script again to verify\n"
    print_color "\n"
    print_info "Tip: Use Claude Code to batch-replace placeholders efficiently"
    print_info "See: docs/claude-code-tutorial.md"
    print_color "\n"

    exit 1
fi
