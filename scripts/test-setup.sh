#!/bin/bash
#
# Script Name: test-setup.sh
# Description: Run all validation checks (placeholders, customization, lighthouse) in one command
# Author: HAP Learning Lab Template
# Date: 2025-10-14
# Version: 1.0.0
#
# Usage: ./test-setup.sh [OPTIONS] [DIRECTORY]
#
# Options:
#   --skip-lighthouse    Skip Lighthouse tests (faster)
#   --verbose            Show detailed output from all checks
#   --help               Display this help message
#
# Examples:
#   ./test-setup.sh
#   ./test-setup.sh --skip-lighthouse
#   ./test-setup.sh --verbose /path/to/project
#
# Dependencies:
#   - scripts/validate-placeholders.sh
#   - scripts/check-customization.sh
#   - npm (for lighthouse tests)
#
# Quick test plan:
# 1) Run on uncustomized template - should fail multiple checks
# 2) Run on fully customized project - should pass all checks
# 3) Run with --skip-lighthouse - should skip npm tests
# 4) Run without npm installed - should skip lighthouse gracefully
# 5) Run with --verbose - should show detailed output

# Safer shell defaults
set -Eeuo pipefail
IFS=$'\n\t'

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Options
SKIP_LIGHTHOUSE=false
VERBOSE=false
TARGET_DIR="."

# Track overall results
TOTAL_SUITES=0
PASSED_SUITES=0
FAILED_SUITES=0

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
Usage: test-setup.sh [OPTIONS] [DIRECTORY]

Run all validation checks (placeholders, customization, lighthouse) in one command

OPTIONS:
    --skip-lighthouse   Skip Lighthouse tests (faster, useful during development)
    --verbose           Show detailed output from all checks
    -h, --help          Display this help message

ARGUMENTS:
    DIRECTORY           Directory to check (default: current directory)

EXAMPLES:
    ./test-setup.sh
    ./test-setup.sh --skip-lighthouse
    ./test-setup.sh --verbose /path/to/project

TEST SUITES RUN:
    1. Placeholder validation (scripts/validate-placeholders.sh)
    2. Customization checklist (scripts/check-customization.sh --auto)
    3. Lighthouse CI tests (npm run lh:ci)

EXIT CODES:
    0   All test suites passed
    1   One or more test suites failed or error occurred

For more information, see docs/claude-code-tutorial.md
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-lighthouse)
            SKIP_LIGHTHOUSE=true
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

# Get script directory to find other scripts
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Print header
print_color "${MAGENTA}╔══════════════════════════════════════════════════════════════╗${NC}\n"
print_color "${MAGENTA}║              HAP Learning Lab Test Suite Runner              ║${NC}\n"
print_color "${MAGENTA}╚══════════════════════════════════════════════════════════════╝${NC}\n"
print_color "\n"

print_info "Target directory: $TARGET_DIR"
print_info "Script directory: $SCRIPT_DIR"
print_color "\n"

# Change to target directory
cd "$TARGET_DIR"

# Helper function to run a test suite
# Usage: run_suite "Suite name" "command to run"
run_suite() {
    local suite_name="$1"
    local suite_command="$2"

    TOTAL_SUITES=$((TOTAL_SUITES + 1))

    print_color "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"
    print_color "${CYAN}  Test Suite $TOTAL_SUITES: $suite_name${NC}\n"
    print_color "${CYAN}═══════════════════════════════════════════════════════════════${NC}\n"
    print_color "\n"

    # Track timing
    local start_ts end_ts elapsed
    start_ts=$(date +%s)

    # Run the suite command
    local exit_code=0

    # Safe use of bash -lc instead of eval: commands are hardcoded in this script, never from user input
    if [ "$VERBOSE" = true ]; then
        # Show full output in verbose mode
        if bash -lc "$suite_command"; then
            exit_code=0
        else
            exit_code=$?
        fi
    else
        # Capture output and only show on failure using temp file to preserve formatting
        local tmpfile
        tmpfile="$(mktemp)"
        if bash -lc "$suite_command" > "$tmpfile" 2>&1; then
            exit_code=0
            # Success - discard output
            rm -f "$tmpfile"
        else
            exit_code=$?
            # Failure - show output
            cat "$tmpfile"
            rm -f "$tmpfile"
        fi
    fi

    # Calculate elapsed time
    end_ts=$(date +%s)
    elapsed=$((end_ts - start_ts))

    print_color "\n"

    if [ $exit_code -eq 0 ]; then
        print_success "✓ $suite_name: PASSED"
        PASSED_SUITES=$((PASSED_SUITES + 1))
        print_info "Time: ${elapsed}s"
        print_color "\n"
        return 0
    else
        print_error "✗ $suite_name: FAILED (exit code: $exit_code)"
        FAILED_SUITES=$((FAILED_SUITES + 1))
        print_info "Time: ${elapsed}s"
        print_color "\n"
        return 1
    fi
}

# Test Suite 1: Placeholder validation
if [ -f "$SCRIPT_DIR/validate-placeholders.sh" ]; then
    run_suite "Placeholder Validation" "bash '$SCRIPT_DIR/validate-placeholders.sh' '$TARGET_DIR'"
else
    print_warning "Skipping placeholder validation - script not found: $SCRIPT_DIR/validate-placeholders.sh"
    print_color "\n"
fi

# Test Suite 2: Customization checklist (auto mode)
if [ -f "$SCRIPT_DIR/check-customization.sh" ]; then
    run_suite "Customization Checklist" "bash '$SCRIPT_DIR/check-customization.sh' --auto '$TARGET_DIR'"
else
    print_warning "Skipping customization checklist - script not found: $SCRIPT_DIR/check-customization.sh"
    print_color "\n"
fi

# Test Suite 3: Lighthouse CI tests
if [ "$SKIP_LIGHTHOUSE" = false ]; then
    if [ -f "package.json" ]; then
        # Check if npm is available
        if command -v npm >/dev/null 2>&1; then
            # Check if lighthouse script exists in package.json (tighter regex to avoid false positives)
            if grep -Eq '"scripts"[[:space:]]*:[[:space:]]*\{[^}]*"lh:ci"[[:space:]]*:' package.json 2>/dev/null; then
                run_suite "Lighthouse CI Tests" "npm run lh:ci"
            else
                print_warning "Skipping Lighthouse tests - no 'lh:ci' script in package.json"
                print_info "Add to package.json: \"lh:ci\": \"lighthouse-ci autorun\""
                print_color "\n"
            fi
        else
            print_warning "Skipping Lighthouse tests - npm not installed"
            print_info "Install Node.js to enable Lighthouse testing: https://nodejs.org/"
            print_color "\n"
        fi
    else
        print_warning "Skipping Lighthouse tests - no package.json found"
        print_color "\n"
    fi
else
    print_info "Skipping Lighthouse tests (--skip-lighthouse flag)"
    print_color "\n"
fi

# Print final results
print_color "${MAGENTA}═══════════════════════════════════════════════════════════════${NC}\n"
print_color "${MAGENTA}                       Final Results                           ${NC}\n"
print_color "${MAGENTA}═══════════════════════════════════════════════════════════════${NC}\n"
print_color "\n"

print_info "Total test suites: $TOTAL_SUITES"
print_success "Passed: $PASSED_SUITES"
print_error "Failed: $FAILED_SUITES"
print_color "\n"

# Calculate percentage if we ran any tests
if [ "$TOTAL_SUITES" -gt 0 ]; then
    percentage=$((PASSED_SUITES * 100 / TOTAL_SUITES))
    print_info "Success rate: ${percentage}%"
    print_color "\n"
fi

# Final verdict
if [ "$FAILED_SUITES" -eq 0 ] && [ "$TOTAL_SUITES" -gt 0 ]; then
    print_color "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}\n"
    print_color "${GREEN}║          ✓ All test suites passed! Great work!               ║${NC}\n"
    print_color "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}\n"
    print_color "\n"

    print_info "Working directory: $(pwd)"
    print_color "\n"
    print_info "Your learning lab is ready for:"
    print_color "\n"
    print_color "  • ${BLUE}Local testing${NC} - python3 -m http.server 8000\n"
    print_color "  • ${BLUE}Deployment${NC} - Follow your hosting platform's instructions\n"
    print_color "  • ${BLUE}Sharing${NC} - Push to GitHub and enable GitHub Pages\n"
    print_color "\n"

    exit 0
elif [ "$TOTAL_SUITES" -eq 0 ]; then
    print_color "${YELLOW}╔══════════════════════════════════════════════════════════════╗${NC}\n"
    print_color "${YELLOW}║          ⚠ No test suites were run                           ║${NC}\n"
    print_color "${YELLOW}╚══════════════════════════════════════════════════════════════╝${NC}\n"
    print_color "\n"

    print_info "Possible reasons:"
    print_color "\n"
    print_color "  • Missing test scripts in ${BLUE}$SCRIPT_DIR${NC}\n"
    print_color "  • All tests were skipped\n"
    print_color "\n"

    exit 1
else
    print_color "${YELLOW}╔══════════════════════════════════════════════════════════════╗${NC}\n"
    print_color "${YELLOW}║       ⚠ Some test suites failed. Review the output.         ║${NC}\n"
    print_color "${YELLOW}╚══════════════════════════════════════════════════════════════╝${NC}\n"
    print_color "\n"

    print_info "Suggested next steps:"
    print_color "\n"
    print_color "  1. Review failed test output above\n"
    print_color "  2. Run individual test scripts for more details:\n"
    print_color "     • ${BLUE}scripts/validate-placeholders.sh${NC}\n"
    print_color "     • ${BLUE}scripts/check-customization.sh${NC}\n"
    print_color "  3. Fix issues and run this script again\n"
    print_color "  4. Use ${BLUE}--verbose${NC} flag to see detailed output\n"
    print_color "\n"

    exit 1
fi
