
# HAP's Color Learning Lab - Design Rules Guide

## 1. **HTML Structure & Patterns**

### Core HTML Template

- **DOCTYPE**: HTML5 with `lang="en"`
- **Head Elements Order**:
  1. Meta charset and viewport
  2. Title with consistent pattern: "HAP's Color Learning Lab - [Station Name/Description]"
  3. Meta descriptions (educational SEO)
  4. Open Graph meta tags with HAP laptop image
  5. Favicon links (4 sizes using Cloudinary HAP favicon)
  6. Preconnect to Cloudinary
  7. Stylesheet link to `css/style.css`

### Page Architecture

- **Skip link** for accessibility (first element in body)
- **Header** with HAP avatar and intro box
- **Navigation**: Inter-page navigation with position indicators
- **Main content** with `id="main-content"`
- **Footer** with consistent copyright and HAP trademark info

### Header Structure Pattern

```html
<header class="header">
    <div class="header-content">
        <div class="hybit-welcome">
            <div class="hybit-avatar">
                <img src="[HAP-LAPTOP-IMAGE]" alt="HAP (HyBit A. ProtoBot) studying on his laptop"
                     width="200" height="200" decoding="async" fetchpriority="high">
            </div>
            <div>
                <h1>HAP's Learning Lab: [Station Title]</h1>
                <p class="subtitle">[Brief subtitle]</p>
            </div>
        </div>
        <div class="intro-box">
            <p><strong>Welcome to Station X!</strong> [Single paragraph intro with HAP's story and struggle] 🟠</p>
        </div>
    </div>
</header>
```

**CRITICAL**: The `.intro-box` uses `display: flex` in CSS. You MUST use only ONE `<p>` tag inside it, never multiple paragraphs. Multiple paragraphs will display as columns due to flexbox!

## 2. **HAP Character Integration**

### Visual Elements

- **HAP Avatar**: 200x200px in header using Cloudinary images
- **HAP Images**: Multiple contextual images (waving, confused, learning)
- **Image Specifications**:
  - Always use Cloudinary URLs with optimization parameters
  - Include width/height attributes
  - Add `decoding="async"` and appropriate `fetchpriority`/`loading` attributes

### HAP's Voice & Personality

- **First-person narrative** throughout
- **Relatable mistakes**: Share specific color failures (hex chaos, #bada55 joke)
- **Prof. Teeters references**: Credit learning moments
- **Casual tone**: Contractions, occasional emojis (sparingly)
- **Encouragement**: Celebrate small wins, normalize mistakes

## 3. **Content Sections**

### Station Pages Structure

1. **Header with intro box**: HAP's personal color struggle story (single `<p>` tag to avoid flexbox column layout)
2. **Overview/learning objectives**: "What You'll Learn at This Station" section with 3 insight cards
3. **HAP Note Callouts** with contextual advice and HAP images
4. **Main content sections**: 2-4 topic sections with examples and explanations
5. **Code examples** with "HAP's Old Way" vs "What I Learned" pattern
6. **Interactive demos**: "Try This" exercises with practical instructions
7. **Quick reference**: Numbered tip cards with best practices
8. **Bottom navigation** to hub, previous station, and next station

### Content Components

- **`intro-box`**: HAP's introduction at top of page (MUST use single `<p>` tag, not multiple paragraphs)
- **`overview-grid`**: Contains 3 insight cards for "What You'll Learn" section
- **`insight-card`**: Key learning points with icon, stat, and description
- **`hap-note-callout`**: HAP's personal insights with image (150x150) and content
- **`analysis-grid`**: Multiple related points, code comparisons, or explanations
- **`analysis-point`**: Individual point within an analysis-grid
- **`warning-box`**: Important discoveries, advanced techniques, or emphasis
- **`prompt-box`**: Code examples with `.prompt-label` for context
- **`interactive-demo`**: "Try This" exercises with step-by-step instructions
- **`tips-container`**: Wrapper for quick reference section
- **`tip-card`**: Individual numbered tips with `.tip-number` and content

### "What You'll Learn" Pattern (Every Station)

```html
<section class="content-section">
    <h2 class="section-heading-centered">What You'll Learn at This Station</h2>

    <div class="overview-grid mt-2">
        <div class="insight-card">
            <h3><span class="insight-icon">🎨</span> [Learning Point 1]</h3>
            <p class="stat-large">[Key Metric or Stat]</p>
            <p><strong>[Bold emphasis line]</strong></p>
            <p>[HAP's explanation in first person]</p>
        </div>
        <!-- Repeat for cards 2 and 3 -->
    </div>

    <div class="hap-note-callout">
        <img src="[HAP-IMAGE]" alt="[Description]" width="150" height="150"
             class="hap-note-image" decoding="async" loading="lazy">
        <div class="hap-note-content">
            <h3>HAP's Confession:</h3>
            <p>[HAP shares his relatable mistakes and struggles]</p>
        </div>
    </div>
</section>
```

**Always exactly 3 insight cards** - Consistent across all stations. The stat can use color classes: `stat-large`, `stat-teal`, or `stat-brown` for variation.

## 4. **Interactive Elements in Practice**

### What We've Actually Implemented

Stations 1 and 2 use **text-based interactive demos** rather than live JavaScript tools:

- **Station 1**: "Try This: RGB to Hex Mental Conversion" with bullet list examples
- **Station 2**: "Try This: Refactor Your Hex Chaos" with numbered step-by-step instructions
- **Station 2**: "Try This: Audit Your Color Usage" with numbered analysis steps

These use the `.interactive-demo` class and focus on **teaching thinking** rather than providing tools.

### Interactive Demo Pattern

```html
<div class="interactive-demo mt-2">
    <h3>🔬 Try This: [Activity Name]</h3>
    <p>Brief explanation of what to do</p>
    <ol class="mt-1">
        <li>Step-by-step instructions</li>
        <li>That students can follow</li>
        <li>In their own projects or DevTools</li>
    </ol>
    <p class="mt-1">HAP's comment on the learning value!</p>
</div>
```

### Future Interactive Features

Future stations may include:

- **Color format converter** (Station 1 extension)
- **Contrast checker** with live preview (Station 4: Accessibility)
- **Palette builder** with export (Station 3: Color Harmony)
- **Color harmony visualizer** (Station 3)
- **CSS variables generator** (Station 2 extension)
- **Dark mode toggle demo** (Station 5: Modern CSS)

## 5. **CSS Design System**

### Color Palette (from existing HAP sites)

Colors are found in the `css/style.css` file.

```css
--warm-orange: hsla(32, 76%, 63%, 1.00)
--soft-orange: hsla(35, 84%, 74%, 1.00)
--peach-background: hsla(34, 56%, 90%, 1.00)
--cream-white: hsla(32, 100%, 97%, 1.00)
--dark-brown: hsla(27, 45%, 17%, 1.00)
--medium-brown: hsla(25, 22%, 34%, 1.00)
--teal-accent: hsla(172, 30%, 50%, 1.00)
--success-green: hsla(109, 44%, 55%, 1.00)
--warning-red: hsla(350, 75%, 64%, 1.00)
```

### Typography

- **Location**: fonts are self-hosted in the fonts directory
- **Font**: 'Nunito' for body text
- **Code**: 'Source Code Pro'
- **Sizes**: Use `clamp()` for responsive sizing
- **Line length**: `max-width: 75ch` for readability

### Layout Patterns

- **Max-width**: 1200px for content containers
- **Grid layouts**: `repeat(auto-fit, minmax())` for responsive grids
- **Border radius**: `--radius: 16px` and `--radius-lg: 24px`
- **Spacing**: Consistent margin/padding using utility classes

## 6. **Code Examples**

### Actual Pattern Used in Stations 1 & 2

We use **multiple variations** of code examples depending on context:

#### Before/After Pattern (Station 1 & 2)

```html
<div class="warning-box mt-2">
    <h3>🟠 HAP's Old Way vs. What I Learned</h3>
    <p><strong class="text-error">❌ WRONG: Hex Chaos</strong></p>
    <pre><code class="language-css">/* Bad code example */</code></pre>
    <p><strong class="text-success">✅ RIGHT: What I Learned</strong></p>
    <pre><code class="language-css">/* Good code example */</code></pre>
    <p class="mt-1">Explanation of why the second way is better!</p>
</div>
```

#### Code with Label Pattern

```html
<div class="prompt-box mt-2">
    <div class="prompt-label">Descriptive Label Here:</div>
    <pre><code class="language-css">/* CSS code */</code></pre>
    <p class="code-comment mt-1">HAP's explanation or context about the code!</p>
</div>
```

#### Inline Code in Analysis Grid

```html
<div class="analysis-grid">
    <div class="analysis-point">
        <h3>Concept Title</h3>
        <p><strong>Explanation:</strong></p>
        <pre><code class="language-css">/* Short code snippet */</code></pre>
    </div>
</div>
```

### Code Features

- **Prism.js** for syntax highlighting (`language-css` class)
- **Copy buttons** added via JavaScript to all `.prompt-box pre` elements
- **HAP's comments** (`<p class="code-comment">`) explain the code's significance
- **Labels** (`<div class="prompt-label">`) provide context

## 7. **Navigation System**

### Inter-Station Navigation (Implemented in Stations 1 & 2)

#### Top Navigation

```html
<nav aria-label="Page navigation" class="page-navigation top-nav">
    <a href="../index.html" class="nav-link hub-link">🏠 Back to Hub</a>
    <div class="page-position" data-page="1">Station 1 of 6</div>
</nav>
```

- **Hub link** on left: Returns to main hub page
- **Position indicator** on right: Shows current station number
- Uses `aria-label` for accessibility

#### Bottom Navigation

```html
<nav aria-label="Station pagination" class="page-navigation bottom-nav">
    <a href="station1.html" class="nav-link prev-link">← Previous: Station 1 - Beyond Hex</a>
    <a href="../index.html" class="nav-link hub-link">🏠 Hub</a>
    <a href="station3.html" class="nav-link next-link">Next: Station 3 - Color Harmony →</a>
</nav>
```

- **Previous station link** (if not station 1)
- **Hub link** in center
- **Next station link** (if not station 6)
- Station 1 omits previous link, Station 6 will omit next link

### Tab System

**Not implemented** in Stations 1 & 2. These use direct content sections instead of tabs. May be added in future stations if needed for complex multi-topic content.

## 8. **Easter Egg System**

### Implementation

- Include `easter-egg.js` script
- URL parameter pattern: `?hybit` or `?hybit=keyword`
- Dialog with HAP insights
- Color-specific parameters (hex, contrast, variables, etc.)

## 9. **Performance & Accessibility**

### Performance Requirements

- **Lighthouse target**: 95+ score
- **Image optimization**: Cloudinary with `f_auto,q_auto`
- **Lazy loading**: For non-critical images
- **Preconnect**: To Cloudinary CDN

### Accessibility Must-Haves

- **Skip links**
- **Semantic HTML** landmarks
- **ARIA labels** on interactive elements
- **Keyboard navigation** for all demos
- **Focus indicators** visible
- **Alt text** on all images

## 10. **File Organization**

### Actual Directory Structure

```
hybit-colors/
├── index.html                      # Hub with 6 station cards
├── stations/
│   ├── station1.html               # Station 1: Beyond Hex (COMPLETE)
│   ├── station2.html               # Station 2: Building Color Systems (COMPLETE)
│   ├── station3.html               # Station 3: Color Harmony (template)
│   ├── station4.html               # Station 4: Accessibility (template)
│   ├── station5.html               # Station 5: Modern CSS (template)
│   └── station6.html               # Station 6: AI Assistance (template)
├── css/
│   ├── style.css                   # Main HAP styles (~2900 lines)
│   └── prism-hap-theme.css         # Syntax highlighting theme
├── js/
│   └── easter-egg.js               # HAP Insights system
├── data/
│   ├── hybit-insights.jsonc        # Easter egg content
│   └── README.md                   # Easter egg documentation
├── reports/
│   ├── hap-design.md               # This file - design guide
│   ├── station1-content-draft.md   # Station 1 approved content
│   └── station2-content-draft-v2.md # Station 2 approved content
└── CONTENT-PLAN.md                 # 6-station curriculum plan
```

### Naming Convention Note

**Stations use `station1.html` format** (not descriptive names like `color-formats.html`). This keeps URLs simple and makes the progression clear.

## 11. **Footer Standards**

### Implemented Footer Pattern (Stations 1 & 2)

```html
<footer class="footer">
    <p><strong>HAP's Learning Lab</strong> | An AI-Enhanced Educational Experience by Prof. Cynthia Teeters</p>
    <p class="footer-reminder">
        [Station-specific HAP takeaway message] 🟠 — HAP
    </p>
    <div class="footer-copyright">
        <img src="https://res.cloudinary.com/cynthia-teeters/image/upload/f_auto,q_auto,w_80,c_limit/v1759497938/HAP-learner_dvehmt.jpg"
            alt="HAP the apprentice learner with his study book and tools" class="footer-hybit" width="80"
            height="80" decoding="async" loading="lazy">
        <div>
            <p>HAP&trade; Educational Content &copy; 2025 Cynthia Teeters. All rights reserved.</p>
            <p>HyBit A. ProtoBot&trade; (HAP&trade;) character and the apprentice learning methodology are
                proprietary educational innovations.</p>
            <p>Character concept, teaching methodology, and all written content created by Prof. Cynthia Teeters.
                Visual elements created with AI assistance.</p>
        </div>
    </div>
</footer>
```

### Station-Specific Footer Messages

- **Station 1**: "Hex for copying, RGB for understanding screens, HSL for creating systems. That's my color format mantra now! 🟠 — HAP"
- **Station 2**: "Define once, name semantically, use the 60-30-10 rule. That's my color system mantra now! No more hex soup! 🟠 — HAP"

Each station should have a unique takeaway message that reinforces key learning!

## 12. **Responsive Breakpoints**

### Mobile First Approach

- **Base**: Mobile styles
- **768px**: Tablet adjustments
- **480px**: Small mobile specific fixes
- **Grid stacking**: Auto-stack on mobile
- **Touch targets**: Minimum 44x44px

## 13. **Color-Specific Requirements**

### Must Include

- **Hex code examples** showing student problems
- **Before/after** transformations
- **Live color previews** (not just code)
- **Accessibility warnings** with contrast
- **Real metrics** (file sizes, contrast ratios)
- **Interactive not static** demos

### HAP's Color Journey Arc

1. **Station 1**: Started with only hex codes, discovered RGB and HSL formats
2. **Station 2**: Had 47 different color values, discovered CSS custom properties and semantic naming
3. **Station 3**: Will learn color harmony and the color wheel
4. **Station 4**: Will discover contrast and accessibility (the "invisible text disaster")
5. **Station 5**: Will learn modern CSS color features
6. **Station 6**: Will explore AI assistance for color decisions

### Critical Implementation Details Learned

1. **Intro-box MUST use single `<p>` tag** - Multiple paragraphs create unwanted flexbox column layout
2. **Always include station-specific footer messages** - Reinforces key takeaways
3. **Copy buttons added via JavaScript** - Targets all `.prompt-box pre` elements
4. **"What You'll Learn" uses 3 insight cards** - Consistent pattern across all stations
5. **HAP images are 150x150 in callouts** - 80x80 in footer, 200x200 in header
6. **Interactive demos are text-based exercises** - Not live JavaScript tools (at least in Stations 1 & 2)
7. **Quick Reference section uses numbered tip cards** - Wrapped in `.tips-container`

This design system ensures consistency with existing HAP labs while being specifically tailored for teaching color concepts through HAP's relatable learning journey.
