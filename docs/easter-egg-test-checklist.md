# Easter egg test checklist

**Test Date**: October 21, 2025
**Testing**: Security fix (JSONC → JSON conversion)
**Live Server**: http://localhost:5500

## Pre-test setup

- [ ] Live-server is running on port 5500
- [ ] Browser DevTools open (F12 or Cmd+Option+I)
- [ ] Console tab visible (to check for errors)

## Test 1: Basic easter egg (empty parameter)

**URL**: http://localhost:5500/stations/station3.html?hybit

**Expected behavior**:
- [ ] HAP's avatar spins for 2 seconds
- [ ] Dialog appears after animation
- [ ] Dialog shows title: "🎡 HAP here!"
- [ ] Dialog shows intro text about color wheel
- [ ] Dialog shows 3 suggestions:
  - [ ] `?hybit=color-wheel` - The color wheel as degrees
  - [ ] `?hybit=complementary` - How to find opposites (add 180°)
  - [ ] `?hybit=analogous` - How neighbors harmonize
- [ ] Close button (×) works
- [ ] Clicking backdrop closes dialog
- [ ] No errors in Console

**Result**: ☐ PASS / ☐ FAIL

---

## Test 2: Specific insight (color-wheel)

**URL**: http://localhost:5500/stations/station3.html?hybit=color-wheel

**Expected behavior**:
- [ ] HAP's avatar spins for 2 seconds
- [ ] Dialog appears after animation
- [ ] Dialog shows title: "🎨 The Color Wheel as Degrees"
- [ ] Content mentions HSL hue as numbers (0-360°)
- [ ] Content includes code examples with `<code>` tags
- [ ] Close button works
- [ ] No errors in Console

**Result**: ☐ PASS / ☐ FAIL

---

## Test 3: Unknown parameter (fallback message)

**URL**: http://localhost:5500/stations/station3.html?hybit=testing123

**Expected behavior**:
- [ ] HAP's avatar spins for 2 seconds
- [ ] Dialog appears after animation
- [ ] Dialog shows title: "🎯 You discovered HAP's insights!"
- [ ] Content shows generic discovery message
- [ ] Close button works
- [ ] No errors in Console

**Result**: ☐ PASS / ☐ FAIL

---

## Test 4: Different station (station1)

**URL**: http://localhost:5500/stations/station1.html?hybit

**Expected behavior**:
- [ ] HAP's avatar spins
- [ ] Dialog shows title: "🎨 HAP here!"
- [ ] Dialog shows station1-specific suggestions:
  - [ ] `?hybit=hex-shorthand`
  - [ ] `?hybit=hsl-advantage`
  - [ ] `?hybit=rgb-screens`
- [ ] Close button works
- [ ] No errors in Console

**Result**: ☐ PASS / ☐ FAIL

---

## Test 5: Specific message from station1

**URL**: http://localhost:5500/stations/station1.html?hybit=hsl-advantage

**Expected behavior**:
- [ ] HAP's avatar spins
- [ ] Dialog shows title: "🎯 Why HSL Changed Everything"
- [ ] Content mentions "HSL is like having a color remote control"
- [ ] Content includes HSL code examples
- [ ] Close button works
- [ ] No errors in Console

**Result**: ☐ PASS / ☐ FAIL

---

## Test 6: Hub page

**URL**: http://localhost:5500/index.html?hybit

**Expected behavior**:
- [ ] HAP's avatar spins
- [ ] Dialog shows title: "🔬 HAP's insights available!"
- [ ] Dialog shows hub-specific suggestions:
  - [ ] `?hybit=stations` - Overview of learning stations
  - [ ] `?hybit=detail` - Performance metrics
- [ ] Close button works
- [ ] No errors in Console

**Result**: ☐ PASS / ☐ FAIL

---

## Test 7: Network tab verification

**URL**: http://localhost:5500/stations/station3.html?hybit=color-wheel

**Steps**:
1. Open DevTools → Network tab
2. Reload page
3. Filter for "hybit"

**Expected behavior**:
- [ ] Request to `hybit-insights.json` appears
- [ ] Status code: 200 OK
- [ ] Content-Type: application/json
- [ ] Response shows valid JSON (not text with comments)
- [ ] No request to `hybit-insights.jsonc`

**Result**: ☐ PASS / ☐ FAIL

---

## Test 8: Console error check

**URL**: http://localhost:5500/stations/station3.html?hybit=color-wheel

**Expected behavior**:
- [ ] No "Failed to load insights data" errors
- [ ] No JSON parsing errors
- [ ] No 404 errors for hybit-insights.jsonc
- [ ] No CORS errors
- [ ] No JavaScript errors

**Result**: ☐ PASS / ☐ FAIL

---

## Test 9: Multiple parameters (edge case)

**URL**: http://localhost:5500/stations/station3.html?hybit=color-wheel&other=test

**Expected behavior**:
- [ ] Easter egg still works (ignores other parameters)
- [ ] Shows color-wheel message correctly
- [ ] No errors in Console

**Result**: ☐ PASS / ☐ FAIL

---

## Test 10: Empty string parameter

**URL**: http://localhost:5500/stations/station3.html?hybit=

**Expected behavior**:
- [ ] Same as Test 1 (treats empty string as bare parameter)
- [ ] Shows page-specific suggestions for station3
- [ ] No errors in Console

**Result**: ☐ PASS / ☐ FAIL

---

## Security verification checklist

After all functional tests pass, verify security improvements:

### Code review
- [ ] `js/easter-egg.js` no longer uses regex comment stripping
- [ ] `js/easter-egg.js` uses `response.json()` not `response.text()`
- [ ] File path changed from `.jsonc` to `.json`
- [ ] `data/hybit-insights.json` exists and is valid JSON
- [ ] `data/README.md` updated to reference `.json` file

### Security improvements verified
- [ ] No regex processing of user-influenced content
- [ ] Native JSON parsing (more secure)
- [ ] No comment-stripping bypass vulnerability
- [ ] Whitelist validation still in place (line 77 in easter-egg.js)
- [ ] No user input in innerHTML

---

## Browser compatibility testing

Test in multiple browsers (if available):

### Chrome/Edge
- [ ] All tests pass
- [ ] No console errors

### Firefox
- [ ] All tests pass
- [ ] No console errors

### Safari
- [ ] All tests pass
- [ ] No console errors

---

## Performance check

**URL**: http://localhost:5500/stations/station3.html?hybit=color-wheel

**Measure**:
- [ ] Page loads in < 2 seconds
- [ ] Easter egg animation smooth (no jank)
- [ ] Dialog appears exactly 2 seconds after page load
- [ ] JSON file size reasonable (should be ~13KB)

**Result**: ☐ PASS / ☐ FAIL

---

## Cleanup checklist

After all tests pass:

- [ ] Delete old `data/hybit-insights.jsonc` file
- [ ] Commit changes with message: "Security fix: Convert JSONC to JSON for easter egg data"
- [ ] Update security audit report to mark Priority 1 as complete
- [ ] Deploy changes to production (if applicable)

---

## Test summary

**Total Tests**: 10 functional + security verification
**Passed**: _____ / 10
**Failed**: _____ / 10

**Critical Issues Found**: _______________________

**Minor Issues Found**: _______________________

**Overall Status**: ☐ READY FOR DEPLOYMENT / ☐ NEEDS FIXES

---

## Notes

Use this section to document any unexpected behavior, browser-specific issues, or additional testing needed:

```
[Add notes here]
```

---

**Tested by**: _______________________
**Date**: October 21, 2025
**Browser(s)**: _______________________
**OS**: _______________________

---

## Quick reference: All test URLs

Copy/paste these for quick testing:

```
http://localhost:5500/stations/station3.html?hybit
http://localhost:5500/stations/station3.html?hybit=color-wheel
http://localhost:5500/stations/station3.html?hybit=testing123
http://localhost:5500/stations/station1.html?hybit
http://localhost:5500/stations/station1.html?hybit=hsl-advantage
http://localhost:5500/index.html?hybit
http://localhost:5500/stations/station3.html?hybit=color-wheel&other=test
http://localhost:5500/stations/station3.html?hybit=
```
