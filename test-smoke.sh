#!/bin/bash

# HAP Learning Lab - Smoke Test Script
# Tests all pages return HTTP 200 OK
# Usage: ./test-smoke.sh

echo "🔬 HAP Learning Lab Smoke Test"
echo "================================"
echo ""

# Base URL
BASE_URL="http://localhost:5500"

# All pages to test
pages=(
  "$BASE_URL"
  "$BASE_URL/stations/station1.html"
  "$BASE_URL/stations/station2.html"
  "$BASE_URL/stations/station3.html"
  "$BASE_URL/stations/station4.html"
  "$BASE_URL/stations/station5.html"
  "$BASE_URL/stations/station6.html"
  "$BASE_URL/demos/gradient-builder.html"
  "$BASE_URL/demos/dark-mode-demo.html"
  "$BASE_URL/demos/contrast-fixer.html"
  "$BASE_URL/demos/filter-effects.html"
  "$BASE_URL/demos/status-color-builder.html"
  "$BASE_URL/demos/color-alone-fix.html"
)

failed=0
passed=0

# Test each page
for page in "${pages[@]}"; do
  # Extract page name for display
  page_name=$(echo "$page" | sed "s|$BASE_URL||" | sed 's|^/||')
  if [ -z "$page_name" ]; then
    page_name="hub (index.html)"
  fi

  # Make request and check status
  status=$(curl -s -o /dev/null -w "%{http_code}" "$page")

  if [ "$status" -eq 200 ]; then
    echo "✅ $page_name"
    passed=$((passed + 1))
  else
    echo "❌ $page_name (HTTP $status)"
    failed=$((failed + 1))
  fi
done

echo ""
echo "================================"
echo "Passed: $passed"
echo "Failed: $failed"
echo "================================"

if [ $failed -eq 0 ]; then
  echo "✅ All pages responding correctly!"
  exit 0
else
  echo "❌ $failed page(s) failed - check your local server"
  exit 1
fi
