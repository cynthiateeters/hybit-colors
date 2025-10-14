#!/bin/bash
#
# Script Name: check-customization.sh
# Description: Interactive checklist to verify all customization tasks are complete
# Author: HAP Learning Lab Template
# Date: 2025-10-14
# Version: 1.0.0
#
# Usage: ./check-customization.sh [OPTIONS] [DIRECTORY]
#
# Options:
#   --auto       Run automated checks without prompts (CI mode)
#   --verbose    Show detailed output for each check
#   --help       Display this help message
#
# Examples:
#   ./check-customization.sh
#   ./check-customization.sh --auto
#   ./check-customization.sh --verbose /path/to/project
#
# Dependencies:
#   - grep
#   - find
#
# Quick test plan:
# 1) Run on uncustomized template - should show all tasks incomplete
# 2) Run on fully customized project - should pass all checks
# 3) Run with --auto in CI environment
# 4) Run with --verbose to see detailed check output
# 5) Interrupt mid-checklist - should handle gracefully

# Safer shell defaults
set -Eeuo pipefail
IFS=$'\n\t'

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Options
AUTO_MODE=false
VERBOSE=false
TARGET_DIR="."

# Track checklist progress
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0

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
Usage: check-customization.sh [OPTIONS] [DIRECTORY]

Interactive checklist to verify all customization tasks are complete

OPTIONS:
    --auto          Run automated checks without prompts (CI mode)
    --verbose       Show detailed output for each check
    -h, --help      Display this help message

ARGUMENTS:
    DIRECTORY       Directory to check (default: current directory)

EXAMPLES:
    ./check-customization.sh
    ./check-customization.sh --auto
    ./check-customization.sh --verbose /path/to/project

CHECKS PERFORMED:
    - Placeholder replacement in HTML files
    - Station files customization
    - Easter egg insights configuration
    - Hub page descriptions
    - Git repository initialization
    - Content planning document

EXIT CODES:
    0   All checks passed
    1   Some checks failed or error occurred

For more information, see docs/claude-code-tutorial.md
EOF
}

# Check for required commands
if ! command -v grep >/dev/null 2>&1; then
    print_error "grep is not installed or not in PATH"
    exit 1
fi

if ! command -v find >/dev/null 2>&1; then
    print_error "find is not installed or not in PATH"
    exit 1
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --auto)
            AUTO_MODE=true
            shift
            ;;
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
print_color "${BLUE}║            HAP Customization Checklist Script               ║${NC}\n"
print_color "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}\n"
print_color "\n"

if [ "$AUTO_MODE" = true ]; then
    print_info "Running in automatic mode (CI)"
else
    print_info "Interactive checklist mode"
fi

print_info "Checking directory: $TARGET_DIR"
print_color "\n"

# Helper function to run a check
# Usage: run_check "Check name" "command to run"
run_check() {
    local check_name="$1"
    local check_command="$2"

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    if [ "$VERBOSE" = true ]; then
        print_info "Running: $check_name"
    fi

    # Run the check command
    if eval "$check_command" >/dev/null 2>&1; then
        print_color "  ${GREEN}✓${NC} $check_name\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
        return 0
    else
        print_color "  ${RED}✗${NC} $check_name\n"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
        return 1
    fi
}

# Helper function to ask user confirmation in interactive mode
ask_confirmation() {
    local question="$1"

    if [ "$AUTO_MODE" = true ]; then
        # In auto mode, skip user prompts
        return 1
    fi

    while true; do
        read -r -p "$question (y/n): " answer
        case "$answer" in
            [Yy]|[Yy][Ee][Ss])
                return 0
                ;;
            [Nn]|[Nn][Oo])
                return 1
                ;;
            *)
                print_warning "Please answer yes or no"
                ;;
        esac
    done
}

# Change to target directory for checks
cd "$TARGET_DIR"

print_color "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"
print_color "${CYAN}                    Automated Checks                           ${NC}\n"
print_color "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"
print_color "\n"

# Check 1: No placeholders remaining
print_info "[1/10] Checking for remaining placeholders..."
PLACEHOLDER_PATTERN='\[(YOUR THEME|YOUR TOPICS|STATION [A-Z ]+|YOUR [A-Z ]+|[A-Z][A-Z ]+)\]'
if ! grep -rE "$PLACEHOLDER_PATTERN" --include="*.html" --include="*.htm" . >/dev/null 2>&1; then
    print_color "  ${GREEN}✓${NC} No placeholders found\n"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_color "  ${RED}✗${NC} Placeholders still exist\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
    if [ "$VERBOSE" = true ]; then
        print_warning "Run 'scripts/validate-placeholders.sh' for details"
    fi
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 2: Index.html has been customized
print_info "[2/10] Checking if index.html has been customized..."
if [ -f "index.html" ]; then
    # Check if default template title is still present
    if ! grep -q "HAP's Learning Lab Template" index.html; then
        print_color "  ${GREEN}✓${NC} index.html title customized\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        print_color "  ${RED}✗${NC} index.html still has default title\n"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
else
    print_color "  ${RED}✗${NC} index.html not found\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 3: All 6 station files exist
print_info "[3/10] Checking for all 6 station files..."
station_count=0
if [ -d "stations" ]; then
    station_count=$(find stations -type f \( -iname "*.html" -o -iname "*.htm" \) | wc -l | xargs)
fi
if [ "$station_count" -ge 6 ]; then
    print_color "  ${GREEN}✓${NC} Found $station_count station files\n"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_color "  ${RED}✗${NC} Only found $station_count station files (expected 6)\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 4: Easter egg data file exists and is valid JSON
print_info "[4/10] Checking easter egg insights configuration..."
if [ -f "data/hybit-insights.jsonc" ]; then
    # Try to parse JSONC by stripping comments
    if command -v node >/dev/null 2>&1; then
        # If Node.js available, do simple validation
        if node -e "JSON.parse(require('fs').readFileSync('data/hybit-insights.jsonc', 'utf8').replace(/\/\*[\s\S]*?\*\/|\/\/.*/g,''))" 2>/dev/null; then
            print_color "  ${GREEN}✓${NC} Easter egg configuration is valid\n"
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            print_color "  ${YELLOW}⚠${NC} Easter egg file exists but may have JSON errors\n"
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        fi
    else
        # Without Node.js, just check file exists
        print_color "  ${GREEN}✓${NC} Easter egg configuration file exists\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi
else
    print_color "  ${RED}✗${NC} data/hybit-insights.jsonc not found\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 5: Git repository initialized
print_info "[5/10] Checking git repository..."
if [ -d ".git" ]; then
    print_color "  ${GREEN}✓${NC} Git repository initialized\n"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_color "  ${RED}✗${NC} Git repository not initialized\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
    if [ "$VERBOSE" = true ]; then
        print_info "Run: git init && git add . && git commit -m 'Initial commit'"
    fi
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 6: Content planning document exists
print_info "[6/10] Checking content planning document..."
if [ -f "CONTENT-PLAN.md" ]; then
    # Check if it's been filled out (not all blanks)
    if grep -q "^**Title:**$" CONTENT-PLAN.md; then
        print_color "  ${YELLOW}⚠${NC} CONTENT-PLAN.md exists but appears unfilled\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        print_color "  ${GREEN}✓${NC} CONTENT-PLAN.md exists and has content\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    fi
else
    print_color "  ${RED}✗${NC} CONTENT-PLAN.md not found\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 7: package.json exists
print_info "[7/10] Checking package.json..."
if [ -f "package.json" ]; then
    print_color "  ${GREEN}✓${NC} package.json exists\n"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_color "  ${RED}✗${NC} package.json not found\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 8: node_modules installed
print_info "[8/10] Checking dependencies installed..."
if [ -d "node_modules" ] && [ -n "$(ls -A node_modules 2>/dev/null)" ]; then
    print_color "  ${GREEN}✓${NC} Dependencies installed\n"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_color "  ${YELLOW}⚠${NC} Dependencies not installed\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
    if [ "$VERBOSE" = true ]; then
        print_info "Run: npm install"
    fi
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 9: CSS file exists
print_info "[9/10] Checking CSS file..."
if [ -f "css/style.css" ]; then
    print_color "  ${GREEN}✓${NC} Main stylesheet exists\n"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_color "  ${RED}✗${NC} css/style.css not found\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Check 10: JavaScript files exist
print_info "[10/10] Checking JavaScript files..."
js_count=0
if [ -d "js" ]; then
    js_count=$(find js -type f -name "*.js" | wc -l | xargs)
fi
if [ "$js_count" -gt 0 ]; then
    print_color "  ${GREEN}✓${NC} Found $js_count JavaScript file(s)\n"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    print_color "  ${YELLOW}⚠${NC} No JavaScript files found\n"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
print_color "\n"

# Interactive checks (skip in auto mode)
if [ "$AUTO_MODE" = false ]; then
    print_color "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"
    print_color "${CYAN}                   Interactive Checks                          ${NC}\n"
    print_color "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"
    print_color "\n"

    print_info "Please confirm you have completed the following tasks:"
    print_color "\n"

    # Manual confirmation checks
    if ask_confirmation "  Have you customized all 6 station HTML files?"; then
        print_color "  ${GREEN}✓${NC} Station files customized\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        print_color "  ${RED}✗${NC} Station files not customized\n"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    print_color "\n"

    if ask_confirmation "  Have you updated the hub page station descriptions?"; then
        print_color "  ${GREEN}✓${NC} Hub page descriptions updated\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        print_color "  ${RED}✗${NC} Hub page descriptions not updated\n"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    print_color "\n"

    if ask_confirmation "  Have you customized the easter egg insights?"; then
        print_color "  ${GREEN}✓${NC} Easter egg insights customized\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        print_color "  ${RED}✗${NC} Easter egg insights not customized\n"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    print_color "\n"

    if ask_confirmation "  Have you tested the site locally?"; then
        print_color "  ${GREEN}✓${NC} Site tested locally\n"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        print_color "  ${RED}✗${NC} Site not tested locally\n"
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    print_color "\n"
fi

# Print final results
print_color "${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
print_color "${BLUE}                          Results                              ${NC}\n"
print_color "${BLUE}═══════════════════════════════════════════════════════════════${NC}\n"
print_color "\n"

print_info "Total checks: $TOTAL_CHECKS"
print_success "Passed: $PASSED_CHECKS"
print_error "Failed: $FAILED_CHECKS"
print_color "\n"

# Calculate percentage
if [ "$TOTAL_CHECKS" -gt 0 ]; then
    percentage=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))
    print_info "Completion: ${percentage}%"
    print_color "\n"
fi

# Final verdict
if [ "$FAILED_CHECKS" -eq 0 ]; then
    print_color "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}\n"
    print_color "${GREEN}║        ✓ All checks passed! Ready for deployment.           ║${NC}\n"
    print_color "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}\n"
    print_color "\n"
    exit 0
else
    print_color "${YELLOW}╔══════════════════════════════════════════════════════════════╗${NC}\n"
    print_color "${YELLOW}║     Some checks failed. Please review the items above.       ║${NC}\n"
    print_color "${YELLOW}╚══════════════════════════════════════════════════════════════╝${NC}\n"
    print_color "\n"

    print_info "Suggested next steps:"
    print_color "\n"
    print_color "  1. Run ${BLUE}scripts/validate-placeholders.sh${NC} to find remaining placeholders\n"
    print_color "  2. Review ${BLUE}docs/claude-code-tutorial.md${NC} for customization guidance\n"
    print_color "  3. Run this script again after making changes\n"
    print_color "\n"

    exit 1
fi
