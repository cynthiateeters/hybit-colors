# HAP's Learning Lab Template

**Create Your Own 6-Station Educational Website**

This is a customizable template for creating HAP Learning Lab educational websites. Build your own interactive learning experience with 6 stations covering any web development topic. HAP (HyBit A. ProtoBot™), Prof. Teeters' apprentice, will guide students through your stations with his friendly first-person narrative.

## Overview

This template provides a complete foundation for building HAP Learning Labs - collections of 6 interactive learning stations that teach web development concepts through hands-on examples. The template includes:

- 6 pre-built station HTML files (`station1.html` through `station6.html`) with placeholder content
- Complete HAP branding and character integration
- Easter egg system for contextual learning tips
- Production-tested CSS, JavaScript, and configuration files
- Lighthouse testing infrastructure
- Zero dependencies - pure HTML/CSS/JavaScript

Simply customize the placeholder content with your educational material, and you'll have a professional learning lab ready to deploy.

## Quick start

### Running locally

This is a static HTML site with no build process required.

**Option 1: Using a local server (recommended)**

```bash
# Using Python 3
python3 -m http.server 8000

# Using Node.js
npx http-server

# Using PHP
php -S localhost:8000
```

Then open `http://localhost:8000` in your browser.

**Option 2: Direct file opening**

Open `index.html` directly in your browser. Note: Some features (like JSON loading) may not work with `file://` protocol.

### Project structure

```
hap-template/
├── index.html              # Hub page (customize with your stations)
├── stations/
│   ├── station1.html       # Template for Station 1
│   ├── station2.html       # Template for Station 2
│   ├── station3.html       # Template for Station 3
│   ├── station4.html       # Template for Station 4
│   ├── station5.html       # Template for Station 5
│   └── station6.html       # Template for Station 6
├── css/
│   ├── style.css           # Production-tested HAP styles
│   └── prism-hap-theme.css # Syntax highlighting theme
├── js/
│   └── easter-egg.js       # HAP Insights easter egg system
├── data/
│   ├── hybit-insights.jsonc  # Easter egg content (customize)
│   └── README.md           # Easter egg documentation
├── docs/
│   ├── style-guide.md      # HAP style guide
│   └── lighthouse-tutorial.md  # Testing guide
├── reports/                # Generated Lighthouse reports
├── package.json            # Lighthouse testing scripts
├── lighthouserc.json       # Lighthouse CI configuration
├── LICENSE                 # MIT License (code)
├── TRADEMARK.md            # HAP™ character rights
└── CONTENT-LICENSE.md      # Educational content license
```

## Customizing your learning lab

### Step 1: Define your 6 stations

Decide what 6 web development topics you want to teach. Each station should focus on a specific concept with hands-on examples.

**Example topics:**
- Web fonts and typography
- CSS Grid layouts
- JavaScript APIs
- Accessibility testing
- Performance optimization
- Modern CSS features

### Step 2: Customize station files

Each `station1.html` through `station6.html` file contains placeholders like:

- `[STATION_TITLE]` - Your station's title
- `[SUBTITLE]` - Brief description
- `[BRIEF_DESCRIPTION]` - For meta description
- `[HAP's apprentice voice introduction]` - HAP's first-person narrative
- `[SECTION_HEADING]` - Main section titles
- `[Content sections]` - Your educational content

**Search and replace these placeholders** with your content while maintaining HAP's apprentice voice.

### Step 3: Update the hub page

Edit `index.html` to:
- Update the hub introduction with your learning lab's theme
- Add descriptions for your 6 stations
- Update navigation links if you rename station files

### Step 4: Customize HAP Insights

Edit `data/hybit-insights.jsonc` to add contextual learning tips for your topics. See `data/README.md` for detailed instructions.

### Step 5: Test with Lighthouse

```bash
npm install
npm run lh:ci
```

This runs automated testing on all 6 stations plus the hub page.

## Easter egg feature

The site includes an educational easter egg system called "HAP Insights" that provides contextual learning tips when students add URL parameters. HAP shares additional insights he learned from Prof. Teeters in his friendly apprentice voice.

### How to use

Add `?hybit` to any page URL:

```
index.html?hybit              # Shows page-specific suggestions
index.html?hybit=detail       # Shows Lighthouse score
responsive-images.html?hybit=srcset  # Shows srcset explanation
```

### Available parameters (customize these!)

The template includes example parameters you should customize for your learning lab:

| Parameter | Shows | Example Use |
|-----------|-------|-------------|
| `detail` | Lighthouse Score: 99% | Any page |
| `stations` | Learning stations overview | Hub |
| `example1` | Your topic 1 insight | Station 1 |
| `example2` | Your topic 2 insight | Station 2 |

**To customize:** Edit `data/hybit-insights.jsonc` and replace example parameters with ones relevant to your stations.

### For instructors

See `data/README.md` for complete documentation on adding new insights and customizing messages.

## Technologies used

- **Pure HTML/CSS/JavaScript** - No frameworks or build tools
- **Native `<dialog>` element** - Modern modal UI
- **Cloudinary CDN** - Image optimization and delivery
- **JSONC data format** - Separated content from code
- **Responsive design** - Mobile-first approach
- **Semantic HTML** - Accessibility-focused markup

## Key features

### Performance optimized

- ✅ Lighthouse score: 99%
- ✅ Optimized image delivery via Cloudinary
- ✅ Lazy loading for images
- ✅ Deferred script loading
- ✅ Minimal CSS and JavaScript

### Accessibility

- ✅ Semantic HTML landmarks
- ✅ Skip to main content link
- ✅ ARIA labels on interactive elements
- ✅ Keyboard navigation support
- ✅ Screen reader tested

### Educational design

- ✅ Apprentice narrative with HAP's friendly voice
- ✅ Real-world examples with actual file sizes
- ✅ Visual comparisons and demos
- ✅ Copy-paste ready code snippets
- ✅ Contextual learning with HAP Insights
- ✅ Hands-on exploration encouraged

## Content guidelines

### Images

All images are served through Cloudinary with automatic optimization:

```html
<img src="https://res.cloudinary.com/cynthia-teeters/image/upload/f_auto,q_auto,w_600/image.jpg"
     alt="Descriptive text">
```

Parameters used:

- `f_auto` - Automatic format (WebP/AVIF when supported)
- `q_auto` - Automatic quality optimization
- `w_600` - Width constraint (responsive)

### Renaming station files (optional)

You can keep the numbered naming (`station1.html`) or rename to descriptive names:

**Option A: Keep numbered** (recommended for easier template updates)
```
station1.html, station2.html, etc.
```

**Option B: Rename to descriptive**
```bash
mv stations/station1.html stations/web-fonts.html
mv stations/station2.html stations/css-grid.html
# etc.
```

If you rename, also update:
- Navigation links in each station file
- URLs in `lighthouserc.json`
- Links in `index.html`

## File organization

### CSS architecture

- **Single stylesheet** (`css/style.css`)
- **CSS custom properties** for colors and sizing
- **Utility classes** for spacing (`mt-1`, `mb-2`, etc.)
- **Component classes** for reusable patterns
- **Responsive design** with mobile-first breakpoints

### JavaScript organization

- **Minimal JavaScript** - Only for easter egg feature
- **No dependencies** - Pure vanilla JS
- **Event-driven** - Uses `DOMContentLoaded`
- **Error handling** - Graceful fallbacks

### Data organization

- **Separated content** - JSONC files for easter egg data
- **Documented structure** - Inline comments explain purpose
- **Easy to maintain** - Non-developers can edit content

## Browser support

Tested and working in:

- ✅ Chrome 90+
- ✅ Firefox 90+
- ✅ Safari 15.4+
- ✅ Edge 90+

Note: Native `<dialog>` element requires modern browsers (95%+ coverage as of 2024).

## Security considerations

### Content security policy

Basic CSP is included in HTML:

```html
<meta http-equiv="Content-Security-Policy" content="...">
```

Allows:

- Self-hosted scripts and styles
- Cloudinary images
- Inline styles (for utility classes)

### XSS prevention

Easter egg system uses:

- Whitelist validation for parameters
- Pre-defined messages only
- No user input in HTML
- Safe HTML tags only (`<code>`, `<strong>`, `<em>`)

## Performance metrics

Current Lighthouse scores:

- **Performance:** 99
- **Accessibility:** 100
- **Best Practices:** 100
- **SEO:** 100

Optimization techniques:

- Cloudinary CDN for global delivery
- Lazy loading for below-fold images
- Deferred script loading
- Preconnect to CDN origin
- Optimized critical rendering path

## Contributing

This project is part of Prof. Teeters' AI-Enhanced Teaching Methods.

### Content contributions

To add or modify educational content:

1. Edit the relevant HTML file
2. Follow existing patterns for consistency
3. Test on multiple screen sizes
4. Verify accessibility (screen reader, keyboard nav)
5. Update this README if adding new stations

### Easter egg contributions

To add new HAP Insights:

1. See `data/README.md` for detailed instructions
2. Edit `data/hybit-insights.jsonc`
3. Add parameter to whitelist
4. Create message with title and content (use HAP's voice!)
5. Test with `?hybit=newparam`

### Code style

- **HTML:** Semantic, accessible, well-indented
- **CSS:** BEM-like naming, mobile-first, commented sections
- **JavaScript:** Pure vanilla JS, clear function names, commented logic
- **JSONC:** Inline comments explaining each section

## Documentation

### For students

- Each station page includes inline explanations from HAP
- HAP Insights provide contextual learning tips
- Code examples are copy-paste ready
- Real metrics shown (file sizes, percentages)
- Apprentice narrative makes complex topics approachable

### For instructors

- `data/README.md` - Easter egg system documentation
- Inline HTML comments explain structure
- CSS comments document design decisions
- HAP's apprentice voice demonstrates relatable learning

## 📜 License

This project uses a **multi-license approach** to balance open source collaboration with intellectual property protection:

### License structure

| Component | License | File |
|-----------|---------|------|
| **Code & Technical Implementation** | MIT License | [LICENSE](./LICENSE) |
| **HAP™ Character & Brand** | Proprietary | [TRADEMARK.md](./TRADEMARK.md) |
| **Educational Content & Methodology** | Proprietary | [CONTENT-LICENSE.md](./CONTENT-LICENSE.md) |

### Quick reference guide

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

### Why multiple licenses?

- **Code (MIT)**: Encourages community contribution and technical innovation
- **Character (Proprietary)**: Maintains brand identity and prevents confusion
- **Content (Proprietary)**: Protects educational innovation while allowing academic use

### Attribution

When using or referencing this project:

```
HAP™ (HyBit A. ProtoBot™) by Cynthia Teeters
Apprentice-Based AI Teaching Methodology
```

### Questions?

- **For character licensing**: See [TRADEMARK.md](./TRADEMARK.md)
- **For educational content**: See [CONTENT-LICENSE.md](./CONTENT-LICENSE.md)
- **For other inquiries**: Open an issue or contact @cynthiateeters

---

*HAP™ and HyBit A. ProtoBot™ are trademarks of Cynthia Teeters. The apprentice learning methodology and educational content are proprietary innovations protected by copyright.*

## Credits

### Created by

**Cynthia Teeters** - Instructor, Web Developer
Part of AI-Enhanced Teaching Methods curriculum

### Technologies

- **Cloudinary** - Image optimization and CDN
- **Google Fonts** - Nunito typeface
- **Claude Code** - AI assistant for development

### Inspiration

This project demonstrates how AI image generation, web performance, and responsive design intersect in modern web development.

## Contact

For questions about this educational resource or to report issues:

- Review `data/README.md` for easter egg questions
- Consult inline HTML/CSS/JS comments

---

**Built with 🟠 for education and exploration**
