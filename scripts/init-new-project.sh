#!/bin/bash
#
# HAP Learning Lab Template Initializer
# This script helps you create a new learning lab from the template
#
# Quick test plan:
# 1) Fresh run on macOS: create a new project, confirm placeholders replaced and git main branch set
# 2) Run again with same name: should error that directory exists
# 3) Run with theme/topics containing slashes and quotes: replacements still succeed
# 4) Temporarily remove package.json: script skips npm step with a friendly note
# 5) Simulate missing git/npm by unshimming PATH: script fails early with helpful message

# Safer shell defaults
set -Eeuo pipefail
IFS=$'\n\t'

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Track whether cleanup is needed
CLEANUP_NEEDED=false
NEW_PROJECT_DIR=""

# Cleanup function for error handling
cleanup() {
    if [ "$CLEANUP_NEEDED" = true ] && [ -n "$NEW_PROJECT_DIR" ] && [ -d "$NEW_PROJECT_DIR" ]; then
        printf "${YELLOW}Cleaning up partially created project...${NC}\n"
        rm -rf "$NEW_PROJECT_DIR"
        printf "${RED}Initialization failed. Cleaned up partial project directory.${NC}\n"
    fi
}

# Set trap to cleanup on error
trap cleanup EXIT ERR INT TERM

# Helper function for safe printing (portable across BSD/GNU)
print_color() {
    printf "%b" "$1"
}

# Check for required tools
if ! command -v git >/dev/null 2>&1; then
    print_color "${RED}Error: git is not installed or not in PATH.${NC}\n"
    print_color "Please install git and try again.\n"
    exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
    print_color "${RED}Error: npm is not installed or not in PATH.${NC}\n"
    print_color "Please install Node.js (which includes npm) and try again.\n"
    exit 1
fi

# Check for rsync (should be standard on macOS and most Linux)
if ! command -v rsync >/dev/null 2>&1; then
    print_color "${RED}Error: rsync is not installed or not in PATH.${NC}\n"
    print_color "Please install rsync and try again.\n"
    exit 1
fi

# Escape function for sed replacement strings
escape_sed() {
    printf '%s' "$1" | sed -e 's/[\/&\\]/\\&/g'
}

print_color "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}\n"
print_color "${BLUE}║       HAP Learning Lab Template Initialization Script       ║${NC}\n"
print_color "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}\n"
print_color "\n"

# Get project details
print_color "${GREEN}Let's set up your new learning lab!${NC}\n"
print_color "\n"

# Project name
read -r -p "Enter project directory name (e.g., 'my-css-lab'): " PROJECT_NAME

# Trim leading/trailing whitespace
PROJECT_NAME="$(echo "$PROJECT_NAME" | xargs)"

if [ -z "$PROJECT_NAME" ]; then
    print_color "${RED}Error: Project name cannot be empty${NC}\n"
    exit 1
fi

# Reject problematic names
if [[ "$PROJECT_NAME" == "." || "$PROJECT_NAME" == ".." ]]; then
    print_color "${RED}Error: Project name cannot be '.' or '..'${NC}\n"
    exit 1
fi

# Check if directory exists
if [ -d "$PROJECT_NAME" ]; then
    print_color "${RED}Error: Directory '$PROJECT_NAME' already exists${NC}\n"
    exit 1
fi

# Learning lab theme
read -r -p "Enter your learning lab theme (e.g., 'Modern CSS Layouts'): " LAB_THEME
LAB_THEME="$(echo "$LAB_THEME" | xargs)"
if [ -z "$LAB_THEME" ]; then
    LAB_THEME="[YOUR THEME]"
fi

# Topic description
read -r -p "Enter topics covered (e.g., 'flexbox, grid, container queries'): " LAB_TOPICS
LAB_TOPICS="$(echo "$LAB_TOPICS" | xargs)"
if [ -z "$LAB_TOPICS" ]; then
    LAB_TOPICS="[YOUR TOPICS]"
fi

print_color "\n"
print_color "${YELLOW}Creating project: $PROJECT_NAME${NC}\n"
print_color "${YELLOW}Theme: $LAB_THEME${NC}\n"
print_color "${YELLOW}Topics: $LAB_TOPICS${NC}\n"
print_color "\n"

# Get current script directory (template root)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

# Copy template to new directory using rsync with excludes
print_color "${BLUE}→ Copying template files...${NC}\n"
rsync -a \
    --exclude '.git' \
    --exclude 'node_modules' \
    --exclude 'dist' \
    --exclude 'coverage' \
    --exclude '.DS_Store' \
    --exclude '*.log' \
    --exclude 'scripts' \
    "$TEMPLATE_DIR/" "$PROJECT_NAME/"

# Verify the new directory exists and is non-empty
if [ ! -d "$PROJECT_NAME" ]; then
    print_color "${RED}Error: Failed to create project directory${NC}\n"
    exit 1
fi

if [ -z "$(ls -A "$PROJECT_NAME" 2>/dev/null)" ]; then
    print_color "${RED}Error: Project directory is empty after copy${NC}\n"
    exit 1
fi

# Enable cleanup trap now that directory exists
NEW_PROJECT_DIR="$PROJECT_NAME"
CLEANUP_NEEDED=true

# Navigate to new project
cd "$PROJECT_NAME"

# Remove accidental .git directory if it exists
if [ -d .git ]; then
    rm -rf .git
fi

# Verify index.html exists before attempting replacements
if [ ! -f "index.html" ]; then
    print_color "${RED}Error: index.html not found in template. Template may be corrupted.${NC}\n"
    exit 1
fi

# Update index.html with provided theme/topics
print_color "${BLUE}→ Updating index.html with your theme...${NC}\n"

# Escape user inputs for safe sed replacement
LAB_THEME_ESCAPED="$(escape_sed "$LAB_THEME")"
LAB_TOPICS_ESCAPED="$(escape_sed "$LAB_TOPICS")"

# Use temp file approach for portable sed (works on both macOS and Linux)
tmpfile="$(mktemp "${TMPDIR:-/tmp}/init.XXXXXX")"
sed "s|\[YOUR THEME\]|${LAB_THEME_ESCAPED}|g; s|\[YOUR TOPICS\]|${LAB_TOPICS_ESCAPED}|g" index.html > "$tmpfile" && mv "$tmpfile" index.html

# Initialize git repository with main branch
print_color "${BLUE}→ Initializing git repository...${NC}\n"

# Try git init with -b flag (Git 2.28+), fallback to checkout if not supported
if git init -b main >/dev/null 2>&1; then
    # Successfully initialized with main branch
    :
else
    # Fallback for older git versions
    git init
    git checkout -b main
fi

git add .

# Safely escape theme for commit message
COMMIT_THEME_ESCAPED="${LAB_THEME//\"/\\\"}"
git commit -m "Initial commit: ${COMMIT_THEME_ESCAPED} learning lab from HAP template"

# Install dependencies conditionally
print_color "${BLUE}→ Checking for dependencies...${NC}\n"

if [ -f "package.json" ]; then
    if [ -f "package-lock.json" ]; then
        print_color "${BLUE}→ Running npm ci (using lockfile)...${NC}\n"
        if ! npm ci; then
            print_color "${YELLOW}Note: npm ci failed. You can run 'npm install' manually later.${NC}\n"
        fi
    else
        print_color "${BLUE}→ Running npm install...${NC}\n"
        if ! npm install; then
            print_color "${YELLOW}Note: npm install failed. You can run it manually later.${NC}\n"
        fi
    fi
else
    print_color "${YELLOW}Note: No package.json found. Skipping npm install.${NC}\n"
fi

# Create content planning file
print_color "${BLUE}→ Creating content planning document...${NC}\n"
cat > CONTENT-PLAN.md << 'EOF'
# Content Planning

Use this document to plan your 6 learning stations before customizing the template.

## Station 1
**Title:**
**Subtitle:**
**Focus:**
**Key concepts:**
**Code examples needed:**

## Station 2
**Title:**
**Subtitle:**
**Focus:**
**Key concepts:**
**Code examples needed:**

## Station 3
**Title:**
**Subtitle:**
**Focus:**
**Key concepts:**
**Code examples needed:**

## Station 4
**Title:**
**Subtitle:**
**Focus:**
**Key concepts:**
**Code examples needed:**

## Station 5
**Title:**
**Subtitle:**
**Focus:**
**Key concepts:**
**Code examples needed:**

## Station 6
**Title:**
**Subtitle:**
**Focus:**
**Key concepts:**
**Code examples needed:**

## Easter egg parameters
What parameters do you want for HAP Insights? (e.g., flexbox, grid, responsive)

1. example1 → _______________
2. example2 → _______________
3. example3 → _______________
4. example4 → _______________
5. example5 → _______________
6. example6 → _______________
EOF

# Disable cleanup since we succeeded
CLEANUP_NEEDED=false

# Print success message
print_color "\n"
print_color "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}\n"
print_color "${GREEN}║                   Success! Setup complete.                   ║${NC}\n"
print_color "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}\n"
print_color "\n"
print_color "Created at: ${BLUE}$(pwd)${NC}\n"
print_color "\n"
print_color "${YELLOW}Next steps:${NC}\n"
print_color "\n"
print_color "  1. ${BLUE}cd $PROJECT_NAME${NC}\n"
print_color "  2. ${BLUE}Fill out CONTENT-PLAN.md with your station details${NC}\n"
print_color "  3. ${BLUE}Review docs/claude-code-tutorial.md for AI-assisted customization${NC}\n"
print_color "  4. ${BLUE}Start local server: python3 -m http.server 8000${NC}\n"
print_color "  5. ${BLUE}Open http://localhost:8000 to see your lab${NC}\n"
print_color "\n"
print_color "${YELLOW}Customization checklist:${NC}\n"
print_color "  ☐ Update station files (stations/station1-6.html)\n"
print_color "  ☐ Customize easter egg insights (data/hybit-insights.jsonc)\n"
print_color "  ☐ Update hub page station descriptions (index.html)\n"
print_color "  ☐ Run Lighthouse tests: ${BLUE}npm run lh:ci${NC}\n"
print_color "  ☐ Validate placeholders: ${BLUE}npm run validate:placeholders${NC}\n"
print_color "\n"
print_color "${GREEN}Happy teaching! 🔬  HAP${NC}\n"
print_color "\n"

# Exit successfully
exit 0
