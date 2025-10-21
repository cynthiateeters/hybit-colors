# HAP's Learning Lab: Web Colors

**A 6-Station Interactive Course on Modern Web Color Theory**

Learn modern web color techniques through HAP (HyBit A. ProtoBot™), Prof. Teeters' apprentice, as he shares his journey from hex codes to HSL mastery. Explore color formats, design systems, harmony theory, accessibility, modern CSS features, and AI-assisted color design through hands-on examples and interactive demos.

## Overview

This educational website teaches web color theory and implementation through 6 progressive learning stations. Each station combines HAP's friendly first-person narrative with interactive demos, real code examples, and accessibility-focused best practices. Students learn by following HAP's apprentice journey from confusion to mastery.

## What you'll learn

### Station 1: Beyond hex codes

- Understanding hex shorthand (#RGB vs #RRGGBB)
- Why HSL is superior for systematic color work
- How RGB relates to how screens actually work
- Converting between color formats

### Station 2: Building color systems

- Semantic naming (--primary vs --blue)
- Creating systematic gray scales
- The 60-30-10 distribution rule
- Organizing colors with CSS custom properties

### Station 3: Color harmony and meaning

- The color wheel as degrees (0-360°)
- Complementary colors (180° apart)
- Analogous harmony (neighbors on wheel)
- Color psychology and temperature

### Station 4: Accessibility and contrast

- WCAG 2.2 Level AA requirements (4.5:1 ratio)
- Understanding relative luminance
- Testing for color-vision deficiency
- Never using color alone as an indicator

### Station 5: Modern CSS features

- CSS gradients vs image files
- color-mix() for perfect hover states
- Automatic dark mode with prefers-color-scheme
- CSS custom properties best practices

### Station 6: AI-assisted color design

- Avoiding "vibe coding" pitfalls
- Managing AI drift in long sessions
- Correct terminology (custom properties not "variables")
- Prompt engineering for color palettes

## Quick start

### Running locally

This is a static HTML site with no build process required.

**Using live-server (recommended)**:

```bash
# If installed globally
live-server --port=5500

# Or using npx
npx live-server --port=5500
```

**Using Python**:

```bash
python3 -m http.server 5500
```

**Using Node.js**:

```bash
npx http-server -p 5500
```

Then open `http://localhost:5500` in your browser.

**Important**: A local server is required for the easter egg feature to load JSON data (file:// protocol has CORS restrictions).

### Interactive demos

The project includes 6 interactive demos in the `demos/` directory:

1. **Color Alone Fix** - Accessibility demonstration
2. **Contrast Fixer** - WCAG contrast ratio calculator
3. **Dark Mode Demo** - Automatic dark mode implementation
4. **Filter Effects** - CSS filter demonstrations
5. **Gradient Builder** - Interactive gradient generator
6. **Status Color Builder** - Accessible status colors (error, success, warning, info)

Visit demos directly: `http://localhost:5500/demos/dark-mode-demo.html`

## Project structure

```
hybit-colors/
├── index.html                    # Hub page linking to 6 stations
├── stations/
│   ├── _template-station.html    # Template for future stations
│   ├── station1.html             # Beyond Hex (completed)
│   ├── station2.html             # Building Color Systems (completed)
│   ├── station3.html             # Color Harmony & Meaning (completed)
│   ├── station4.html             # Accessibility (in progress)
│   ├── station5.html             # Modern CSS (in progress)
│   └── station6.html             # AI Assistance (in progress)
├── demos/
│   ├── color-alone-fix.html      # Accessibility demonstration
│   ├── contrast-fixer.html       # Contrast ratio calculator
│   ├── dark-mode-demo.html       # Dark mode implementation
│   ├── filter-effects.html       # CSS filter examples
│   ├── gradient-builder.html    # Interactive gradient tool
│   └── status-color-builder.html # Accessible status colors
├── css/
│   ├── style.css                 # HAP design system (~2900 lines)
│   └── prism-hap-theme.css       # Syntax highlighting theme
├── js/
│   └── easter-egg.js             # HAP Insights easter egg system
├── data/
│   ├── hybit-insights.json       # Easter egg content (22 insights)
│   └── README.md                 # Easter egg documentation
├── docs/
│   ├── style-guide.md            # Complete HAP style guide (v1.4)
│   ├── quick-start.md            # Getting started guide
│   ├── lighthouse-tutorial.md   # Performance testing
│   ├── claude-code-tutorial.md  # AI development workflow
│   ├── hap-design.md             # Color design decisions
│   ├── javascript-security-audit.md  # Security analysis
│   └── easter-egg-test-checklist.md  # Easter egg testing
├── reports/                      # Generated reports (gitignored)
├── CONTENT-PLAN.md               # 6-station curriculum design
├── package.json                  # Lighthouse testing only
├── lighthouserc.json             # Lighthouse CI config
└── LICENSE                       # MIT License (code)
```

## HAP Insights easter egg

The site includes an educational easter egg system that provides contextual learning tips when students add URL parameters.

### How to use

Add `?hybit` to any page URL:

```
stations/station3.html?hybit                    # Shows page-specific suggestions
stations/station3.html?hybit=color-wheel        # Shows color wheel insight
stations/station1.html?hybit=hsl-advantage      # Shows HSL benefits
index.html?hybit=detail                         # Shows Lighthouse score
```

### Available insights (22 total)

**General**:

- `detail` - Lighthouse performance score
- `stations` - Learning lab overview

**Station 1: Beyond Hex**:

- `hex-shorthand` - #RGB vs #RRGGBB explanation
- `hsl-advantage` - Why HSL is superior
- `rgb-screens` - How screens work with RGB

**Station 2: Building Color Systems**:

- `semantic-naming` - --primary vs --blue
- `60-30-10` - Distribution rule
- `gray-scales` - Creating systematic grays

**Station 3: Color Harmony**:

- `color-wheel` - The color wheel as degrees
- `complementary` - 180° apart colors
- `analogous` - Neighbor harmony

**Station 4: Accessibility**:

- `wcag-aa` - Level AA requirements
- `contrast-ratio` - Understanding 4.5:1
- `cvd-testing` - Color-vision deficiency testing

**Station 5: Modern CSS**:

- `gradients` - CSS vs images
- `color-mix` - Perfect hover colors
- `dark-mode` - Automatic dark mode

**Station 6: AI Assistance**:

- `vibe-coding` - Why it fails
- `drift` - AI context loss
- `terminology` - Custom properties vs "variables"
- `verify` - Trust but verify AI claims
- `prompt-formula` - Context + mood + constraints

For complete documentation, see `data/README.md`.

## Technologies used

- **Pure HTML/CSS/JavaScript** - Zero frameworks, zero build process
- **Native `<dialog>` element** - Modern modal UI
- **Cloudinary CDN** - Optimized image delivery
- **CSS Custom Properties** - Systematic color management
- **HSL Color Format** - All colors use HSL for easy manipulation
- **Prism.js** - Syntax highlighting for code examples

## Key features

### Performance optimized

- ✅ Lighthouse scores: 99-100/100 (all categories)
- ✅ Cloudinary auto-optimization (WebP/AVIF)
- ✅ Lazy loading for below-fold images
- ✅ Deferred script loading
- ✅ ~13KB JSON data file
- ✅ Minimal JavaScript (~177 lines)

### Accessibility

- ✅ WCAG 2.2 Level AA compliant
- ✅ All text meets 4.5:1 contrast ratio
- ✅ Semantic HTML landmarks
- ✅ Skip to main content link
- ✅ ARIA labels on interactive elements
- ✅ Keyboard navigation support
- ✅ Screen reader tested

### Educational design

- ✅ Apprentice narrative (HAP's friendly first-person voice)
- ✅ Real-world examples with actual metrics
- ✅ Interactive demos for hands-on learning
- ✅ Copy-paste ready code snippets
- ✅ Contextual learning with easter egg insights
- ✅ Before/after comparisons
- ✅ HAP's mistakes demonstrate common pitfalls

## HAP's apprentice voice

HAP speaks in first-person, sharing his learning journey:

✅ **Good**: "I used to pick colors by guessing — pure red with pure green — and wondered why it felt like a warning sign."

❌ **Wrong**: "You should avoid using pure colors together."

✅ **Good**: "Prof. Teeters showed me the color wheel and my mind exploded!"

❌ **Wrong**: "This tutorial will teach you about the color wheel."

HAP is enthusiastic but humble, references Prof. Teeters as his mentor, and shares his mistakes to make learning relatable.

## Color design principles

This learning lab follows strict color accessibility standards:

### All colors use HSL format

```css
:root {
  /* Brand colors */
  --warm-orange: hsl(32, 62%, 47%);      /* HAP's primary */
  --peach-background: hsl(33, 51%, 90%); /* Page background */
  --cream-white: hsl(39, 100%, 97%);     /* Content cards */

  /* Text colors (WCAG AA compliant) */
  --dark-brown: hsl(30, 38%, 16%);       /* Primary text */
  --teal-darker: hsl(171, 35%, 34%);     /* Links (4.5:1) */
  --orange-darkest: hsl(32, 65%, 33%);   /* Stats (4.5:1) */
}
```

### Why HSL everywhere?

- Systematic color variations (keep H and S, adjust L)
- Easy to calculate complementary colors (±180°)
- Predictable darkening/lightening
- Better for teaching color theory
- Easier to maintain and modify

For complete design decisions, see `docs/hap-design.md`.

## Testing

### Lighthouse CI

```bash
npm install
npm run lh:ci
```

Tests all 6 stations + hub page for:

- Performance (target: 99+)
- Accessibility (target: 100)
- Best Practices (target: 100)
- SEO (target: 100)

### Manual testing

```bash
# Start local server
live-server --port=5500

# In browser DevTools:
# 1. Lighthouse tab → Run audit
# 2. Console → Check for errors
# 3. Network → Verify JSON loads (200 OK)
```

See `docs/easter-egg-test-checklist.md` for comprehensive test procedures.

## Browser support

- ✅ Chrome 90+
- ✅ Firefox 90+
- ✅ Safari 15.4+
- ✅ Edge 90+

**Coverage**: 95%+ of users (as of 2024)

**Required features**:

- Native `<dialog>` element
- CSS custom properties
- Fetch API
- ES6 JavaScript

## Security

### Easter egg security (recently improved)

- ✅ Native JSON parsing (no regex vulnerabilities)
- ✅ Whitelist parameter validation
- ✅ Pre-defined messages only (no user input in HTML)
- ✅ Safe HTML tags only (`<code>`, `<strong>`, `<em>`)
- ✅ No `<script>` tags or event handlers in content

**Recent fix** (Oct 2025): Converted JSONC → JSON to eliminate regex-based comment stripping vulnerability. See `docs/javascript-security-audit.md` for full analysis.

### Content security

- No external scripts except Prism.js (syntax highlighting)
- All images from trusted Cloudinary account
- No user data collection
- No cookies or localStorage
- No form submissions

## Documentation

### For students

- **Each station page**: Inline explanations from HAP
- **HAP Insights**: Contextual tips via `?hybit` parameters
- **Code examples**: Copy-paste ready snippets
- **Interactive demos**: Hands-on color tools

### For instructors

- `CONTENT-PLAN.md` - Complete 6-station curriculum
- `docs/style-guide.md` - HAP design system (v1.4)
- `data/README.md` - Easter egg system
- `docs/hap-design.md` - Color design decisions
- Inline HTML comments explain structure

### For developers

- `docs/claude-code-tutorial.md` - AI development workflow
- `docs/javascript-security-audit.md` - Security analysis
- `CLAUDE.md` - Project guidelines for AI assistants
- CSS comments document design patterns

## Development workflow

This project uses Claude Code for AI-assisted development with checkpoint-based workflow:

1. **Checkpoint branches** for safe experimentation
2. **User review** before merging to main
3. **Lighthouse testing** ensures quality
4. **No AI attribution** in commit messages (per project policy)

See `docs/claude-code-tutorial.md` for complete workflow.

## Performance metrics

Current Lighthouse scores (as of Oct 2025):

- **Performance**: 99-100/100
- **Accessibility**: 100/100
- **Best Practices**: 100/100
- **SEO**: 100/100

Optimization techniques:

- Cloudinary CDN with auto-optimization
- Lazy loading for below-fold images
- Preconnect to CDN origin
- Deferred script loading
- Minimal JavaScript (only easter egg)

## License

This project uses a **multi-license approach**:

| Component | License | File |
|-----------|---------|------|
| **Code & Technical Implementation** | MIT License | [LICENSE](./LICENSE) |
| **HAP™ Character & Brand** | Proprietary | [TRADEMARK.md](./TRADEMARK.md) |
| **Educational Content & Methodology** | Proprietary | [CONTENT-LICENSE.md](./CONTENT-LICENSE.md) |

### Quick reference

#### ✅ You CAN

- Use the code to build your own educational tools
- Fork and modify the technical implementation
- Reference HAP™ when discussing or citing this project
- Study the methodology for academic research
- Use concepts in your classroom with attribution

#### ❌ You CANNOT

- Create your own "HAP" character or derivatives
- Use HAP's visual design or personality
- Repackage the educational content commercially
- Claim the teaching methodology as your own
- Remove attribution or copyright notices

### Attribution

When referencing this project:

```
HAP™ (HyBit A. ProtoBot™) by Cynthia Teeters
Apprentice-Based AI Teaching Methodology
```

## Contributing

### Content improvements

1. Edit relevant HTML/CSS/JS files
2. Follow HAP's apprentice voice (first-person, humble)
3. Test on multiple screen sizes
4. Verify accessibility (4.5:1 contrast minimum)
5. Run Lighthouse CI tests

### Easter egg additions

1. See `data/README.md` for instructions
2. Edit `data/hybit-insights.json`
3. Add parameter to `allowedParams` array
4. Create message with `title` and `content`
5. Test with `?hybit=newparam`

### Code style

- **HTML**: Semantic, accessible, well-indented
- **CSS**: BEM-inspired naming, mobile-first, commented
- **JavaScript**: Pure vanilla JS, clear names, documented
- **JSON**: Valid syntax, no comments (use README instead)

## Credits

### Created by

**Cynthia Teeters** - Instructor, Web Developer
Part of AI-Enhanced Teaching Methods curriculum

### Technologies

- **Cloudinary** - Image optimization and CDN
- **Google Fonts** - Nunito typeface
- **Prism.js** - Syntax highlighting
- **Claude Code** - AI assistant for development

### HAP Character

**HyBit A. ProtoBot™ (HAP™)** character concept, personality, and teaching methodology created by Prof. Cynthia Teeters. Visual elements created with AI assistance.

## Roadmap

### Completed

- ✅ Station 1: Beyond Hex
- ✅ Station 2: Building Color Systems
- ✅ Station 3: Color Harmony & Meaning
- ✅ Hub page with color theme
- ✅ 6 interactive demos
- ✅ Easter egg system (22 insights)
- ✅ Security audit and fix (JSONC → JSON)

### In Progress

- 🔄 Station 4: Accessibility & Contrast
- 🔄 Station 5: Modern CSS Features
- 🔄 Station 6: AI-Assisted Color Design

### Future Enhancements

- [ ] Add DOMPurify for extra HTML sanitization
- [ ] Add SRI hashes to all CDN scripts
- [ ] Add Content Security Policy headers
- [ ] Create video tutorials for each station
- [ ] Add more interactive demos

## Contact

For questions or to report issues:

- **Easter egg questions**: See `data/README.md`
- **Technical questions**: Check inline comments in code
- **Security issues**: See `docs/javascript-security-audit.md`
- **Curriculum questions**: See `CONTENT-PLAN.md`

## Acknowledgments

This project demonstrates how:

- AI-assisted development (Claude Code) accelerates educational content creation
- Modern web standards (CSS custom properties, native dialog) simplify implementation
- Accessibility-first design creates better experiences for everyone
- Apprentice-based learning makes complex topics approachable

---

**Built with 🟠 for education and exploration**

*HAP™ and HyBit A. ProtoBot™ are trademarks of Cynthia Teeters. The apprentice learning methodology and educational content are proprietary innovations protected by copyright.*
