# HAP insights data documentation

**Last updated:** October 3, 2025

## Overview

This directory contains the data files for HAP's educational easter egg system. The easter egg displays contextual learning insights from HAP (HyBit A. ProtoBot) when students add URL parameters like `?hybit=detail` to any page. HAP shares what he learned from Prof. Teeters in his friendly apprentice voice.

## Files in this directory

### `hybit-insights.json`

Main data file containing all insight messages, page-specific help, and configuration.

**Format:** JSON
**Encoding:** UTF-8
**Used by:** `js/easter-egg.js`

## File structure

The JSON file has four main sections:

### 1. `allowedParams` (array)

Whitelist of valid parameter values. Only these trigger specific messages.

**Example:**

```json
"allowedParams": [
  "detail",
  "srcset",
  "lazy"
]
```

**Security:** Any parameter NOT in this list shows the generic "unknown" message. User input is never directly inserted into HTML.

### 2. `messages` (object)

Full insight messages displayed when a valid parameter is used.

**Structure:**

```json
"messages": {
  "paramName": {
    "title": "🚀 Title with emoji",
    "content": "Educational content. Can include <code>HTML tags</code>."
  }
}
```

**Allowed HTML in content:**

- `<code>` - Inline code snippets
- `<strong>` - Bold text
- `<em>` - Italic text
- `<br>` - Line breaks (use sparingly)

**Do NOT use:**

- `<script>` tags
- Event handlers (`onclick`, etc.)
- External links without proper escaping

### 3. `pageHelp` (object)

Page-specific suggestions shown when user visits with bare `?hybit` parameter.

**Structure:**

```json
"pageHelp": {
  "page-name.html": {
    "title": "🔬 HAP here!",
    "intro": "I learned so much on this page! Try:",
    "suggestions": [
      {
        "param": "paramName",
        "label": "Description of what this parameter shows"
      }
    ]
  }
}
```

**Example usage:**

- User visits: `responsive-images.html?hybit`
- Sees: "Prof. Teeters taught me about responsive images! Check out: ?hybit=srcset - Responsive image syntax"
- Then visits: `responsive-images.html?hybit=srcset`
- Sees: Full srcset message

**Voice guidelines:** Use HAP's apprentice voice in intro text - first person, humble, references Prof. Teeters

### 4. `defaults` (object)

Fallback messages for unknown parameters or pages without specific help.

**Structure:**

```json
"defaults": {
  "unknown": {
    "title": "...",
    "content": "..."
  },
  "emptyFallback": {
    "title": "...",
    "content": "..."
  }
}
```

## How to add a new insight

### Step 1: Add to whitelist

Add your parameter name to `allowedParams`:

```json
"allowedParams": [
  "detail",
  "srcset",
  "newparam"
]
```

### Step 2: Create the message

Add your message to `messages`:

```json
"messages": {
  "newparam": {
    "title": "🎯 Your Insight Title",
    "content": "Educational content explaining the concept. Use <code>code tags</code> for syntax."
  }
}
```

### Step 3: Add page-specific help (optional)

If this insight is most relevant to a specific page, add it to `pageHelp`:

```json
"pageHelp": {
  "your-page.html": {
    "title": "🔬 HAP here!",
    "intro": "I learned about [topic] on this page! Try:",
    "suggestions": [
      {
        "param": "newparam",
        "label": "Your new insight description"
      }
    ]
  }
}
```

**Remember:** Use HAP's voice in the intro - first person, enthusiastic, references learning

### Step 4: Test

1. Save the JSONC file
2. Refresh any page
3. Add `?hybit=newparam` to the URL
4. Verify the dialog appears with your message

## Emoji guidelines

**Use emojis in titles to create visual interest:**

- 🚀 - Performance, speed
- 🔬 - Learning, research, HAP's insights
- 📱 - Mobile, responsive
- 📸 - Images, photos
- ☁️ - Cloud, CDN
- 🎯 - Precision, targeting
- 📊 - Data, analytics
- 🎨 - Design, creativity
- 🔒 - Security
- 🟠 - Tips, important notes (HAP's signature emoji)

**Keep it professional:**

- One emoji per title maximum
- Place at the beginning or end
- Ensure emoji is relevant to content

## Content guidelines

### Writing effective titles

**Good titles:**

- ✅ "🚀 Lighthouse Score: 98%-100%!" (specific metric)
- ✅ "📱 Perfect image for every screen" (clear benefit)
- ✅ "🎯 Deferred scripts = faster page loads!" (shows cause/effect)

**Avoid:**

- ❌ "Performance" (too vague)
- ❌ "This is about images and stuff" (unprofessional)
- ❌ "AMAZING OPTIMIZATION TECHNIQUES!!!" (too hype)

**Voice:** Titles can be technical and generic. Save HAP's apprentice voice for page help intros.

### Writing effective content

**Best practices:**

- Keep it concise (1-3 sentences)
- Focus on benefits, not just features
- Include specific numbers when possible ("80% reduction")
- Use `<code>` tags for technical terms
- Explain WHY, not just WHAT

**Example - Good:**

```
"Container queries let components respond to their container size,
not just viewport size. No more duplicate CSS versions!"
```

**Example - Too technical:**

```
"Use @container queries with container-type: inline-size to enable
CQ containment on parent elements."
```

**Example - Too vague:**

```
"Container queries are a new CSS feature that helps with responsive design."
```

## Current insights catalog

| Parameter | Title | Station | Added |
|-----------|-------|---------|-------|
| `detail` | Lighthouse Score: 98%-100%! | All | Initial |
| `stations` | Learning Stations | Hub | Initial |
| `srcset` | Perfect image for every screen | 2 | Initial |
| `picture` | The &lt;picture&gt; element | 3 | Initial |
| `cloudinary` | Using f_auto,q_auto | 4 | Initial |
| `defer` | Deferred scripts = faster page loads! | 5 | Initial |
| `lazy` | Lazy loading (80% reduction) | 5 | Initial |
| `container` | Components that adapt | 6 | Initial |
| `context` | Context-aware components | 6 | Initial |
| `prompt` | AI prompt engineering matters! | 1 | Oct 2025 |

## Security considerations

### XSS prevention

The system is designed to be XSS-safe:

1. **Whitelist validation** - Only predefined parameters work
2. **No user input in HTML** - Parameter values never appear in messages
3. **Pre-defined content** - All HTML is written by developers
4. **Sanitized rendering** - Content goes through controlled templating

### Safe HTML tags

**Allowed:**

- `<code>`, `<strong>`, `<em>` - Semantic formatting
- `&lt;`, `&gt;`, `&amp;` - Escaped HTML entities

**Never use:**

- `<script>` - Can execute code
- `onclick=""` - Event handlers
- `<iframe>` - Can load external content
- `javascript:` URLs

### Content validation

Before adding content, ask:

1. Does it come from a trusted source (you)?
2. Does it contain only safe HTML tags?
3. Is it educational and appropriate?

## Localization (future)

To add support for multiple languages:

1. Create `hybit-insights-es.json` (Spanish)
2. Create `hybit-insights-fr.json` (French)
3. Update `easter-egg.js` to detect language and load appropriate file
4. Keep structure identical across all language files

## Troubleshooting

### Message doesn't appear

**Check:**

1. Is parameter in `allowedParams` array?
2. Is parameter spelled correctly in URL?
3. Does message exist in `messages` object?
4. Are there JSON syntax errors? (check browser console)

### Comments cause errors

**Issue:** JSONC comments not being stripped properly

**Fix:** Check `easter-egg.js` comment-stripping regex:

```javascript
.replace(/\/\*[\s\S]*?\*\//g, '')  // Multi-line
.replace(/\/\/.*/g, '')            // Single-line
```

### HTML not rendering

**Issue:** HTML tags showing as plain text

**Cause:** Using unsupported tags or improper escaping

**Fix:** Use only allowed tags (`<code>`, `<strong>`, `<em>`)

## Version history

- **v3.0** (Oct 3, 2025) - Updated all page help to HAP's apprentice voice
- **v2.0** (Oct 2, 2025) - Converted to JSONC with comments
- **v1.1** (Oct 2, 2025) - Added `prompt` parameter for Station 1
- **v1.0** (Oct 2, 2025) - Initial JSON-based system with 9 parameters

## Contributing

When adding new insights:

1. **Document your changes** - Add inline comments explaining purpose
2. **Test thoroughly** - Verify on all relevant pages
3. **Follow conventions** - Match existing emoji and writing style
4. **Use HAP's voice** - Page help intros should be first person, enthusiastic
5. **Keep it educational** - Focus on learning value, not just facts
6. **Maintain security** - Never add user-controlled content

## Questions?

For questions about this data structure or adding new insights, consult:

- `reports/hybit-trigger-implementation-plan.md` - Overall architecture
- `js/easter-egg.js` - Implementation details
- `reports/easter-egg-analysis.md` - Feature evolution history
