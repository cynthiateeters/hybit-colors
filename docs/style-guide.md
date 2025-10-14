# HAP's Learning Lab style guide

**Version:** 1.4 (Phase 1-4 production alignment - COMPLETE)
**Last updated:** October 13, 2025

## Purpose

This style guide documents coding standards, patterns, and conventions for HAP's Learning Labs to ensure consistency across all future labs built with 11ty.

## HTML standards

### Document structure

**DOCTYPE and language:**
```html
<!DOCTYPE html>
<html lang="en">
```

**Required meta tags (in order):**
```html
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>[Page Title] | HAP's Learning Lab</title>
```

### Semantic HTML

**Use semantic elements:**
- `<header>` - Page header (not `<div class="header">`)
- `<nav>` - Navigation sections
- `<main>` - Main content (one per page)
- `<article>` - Station content
- `<section>` - Content sections
- `<footer>` - Page footer
- `<aside>` - Supplementary content (if needed)

**Heading hierarchy:**
- `<h1>` - Page title (one per page)
- `<h2>` - Section headings
- `<h3>` - Subsection headings
- Sequential order (no skipping levels)

### Accessibility requirements

**Skip link (first element in body):**
```html
<body>
    <a href="#main-content" class="skip-link">Skip to main content</a>
    <!-- ... rest of content -->
</body>
```

**Main content ID:**
```html
<main id="main-content">
```

**ARIA labels:**
```html
<nav aria-label="Page navigation">
```

**Image alt text:**
- Always descriptive
- Describes image content/purpose
- Not "image of" or "picture of"
- Decorative images: `alt=""` (empty, not omitted)

### Image standards

**Cloudinary images:**
```html
<img src="https://res.cloudinary.com/cynthia-teeters/image/upload/f_auto,q_auto,w_[size]/[image-id].jpg"
     alt="[Descriptive text]"
     width="[width]"
     height="[height]"
     decoding="async"
     [loading="lazy"]
     [fetchpriority="high"]>
```

**Required attributes:**
- `src` - Image URL with Cloudinary transforms
- `alt` - Descriptive alt text
- `width` - Intrinsic width (prevents layout shift)
- `height` - Intrinsic height

**Loading optimization:**
- `decoding="async"` - Most images
- `loading="lazy"` - Below-fold images only
- `fetchpriority="high"` - LCP image only (HAP avatar)

**Responsive srcset:**
```html
<img src="[base-url]/w_240/[image].jpg"
     srcset="[base-url]/w_120/[image].jpg 1x,
             [base-url]/w_240/[image].jpg 2x"
     alt="[description]"
     width="120"
     height="120">
```

## CSS standards

### Naming conventions

**BEM-inspired patterns:**
- `.component` - Block (card, header, footer)
- `.component-element` - Element (card-title, header-content)
- `.component--modifier` - Modifier (card--featured)

**Utility classes:**
- `.mt-1` through `.mt-4` - Margin-top
- `.mb-1` through `.mb-4` - Margin-bottom
- `.p-1` through `.p-4` - Padding
- Descriptive names (`.read-length`, not `.rl`)

**State classes:**
- `.is-active` - Active state
- `.is-hidden` - Hidden state
- `.has-nav` - Conditional state

### CSS custom properties

**Use variables for:**
- Colors: `var(--warm-orange)`
- Spacing: `var(--radius)`
- Typography: `var(--readable-width)`

**Define in :root:**
```css
:root {
    --warm-orange: #E8A557;
    --dark-brown: #3D2817;
    --readable-width: 75ch;
}
```

### Responsive design

**Official breakpoints:**

Production HAP Labs use these breakpoint values consistently:

```css
/* Small mobile devices (iPhone SE, small Android phones) */
@media (max-width: 480px) {
    /* Smallest screens */
}

/* Tablets and larger mobile devices */
@media (max-width: 768px) {
    /* Stack layouts, adjust navigation */
}

/* Desktop enhancement */
@media (min-width: 769px) {
    /* Side-by-side layouts, full navigation */
}
```

**Mobile-first approach:**

Always write base styles for mobile, then enhance for larger screens:

```css
/* Base styles for mobile */
.element {
    width: 100%;
}

/* Desktop enhancement */
@media (min-width: 769px) {
    .element {
        width: 50%;
    }
}
```

**Fluid typography with clamp():**

```css
/* Scales smoothly between min and max based on viewport */
font-size: clamp(1.5rem, 3vw, 2.5rem);
```

**Flexible spacing with clamp():**

```css
/* Responsive padding without media queries */
padding: clamp(1rem, 4vw, 2rem);
```

**Common responsive patterns:**

Stack to side-by-side:
```css
.flex-container {
    display: flex;
    flex-direction: column; /* Mobile: stacked */
}

@media (min-width: 769px) {
    .flex-container {
        flex-direction: row; /* Desktop: side-by-side */
    }
}
```

Grid responsiveness:
```css
.grid {
    display: grid;
    grid-template-columns: 1fr; /* Mobile: single column */
    gap: 1rem;
}

@media (min-width: 769px) {
    .grid {
        grid-template-columns: repeat(2, 1fr); /* Desktop: 2 columns */
    }
}
```

### Color usage

**Complete color palette:**

Primary brand colors:
```css
--warm-orange: #E8A557;        /* HAP's primary orange */
--soft-orange: #F4C584;         /* Lighter orange variant */
--peach-background: #F4E8D8;    /* Page background */
--cream-white: #FFF8F0;         /* Content background */
--dark-brown: #3D2817;          /* Primary text */
--medium-brown: #6B5444;        /* Secondary text */
--light-brown: #9B8474;         /* Tertiary text */
```

Accent colors:
```css
--hybit-gray: #8B92A0;          /* HAP avatar background */
--teal-accent: #5BA69C;         /* Interactive elements */
--success-green: #6BBF59;       /* Success states */
--warning-red: #E85D75;         /* Warning/error states */
```

WCAG AA accessible variants (for text on light backgrounds):
```css
/* Use these for text to ensure readability */
--teal-darker: #3A7A70;         /* 4.5:1 contrast - normal text */
--orange-darker: #C17D2E;        /* 3.1:1 contrast - large bold text */
--orange-darkest: #8B5A1F;      /* 4.5:1 contrast - normal text on peach */
--success-darker: #16a34a;      /* 4.5:1 contrast - success text */
--success-green-accessible: #4A9D3F;  /* 3.1:1 - large bold success */
--error-darker: #dc2626;        /* 4.5:1 contrast - error text */
```

Light background variants (for examples and callouts):
```css
--success-bg-light: #f0fdf4;    /* Success example backgrounds */
--error-bg-light: #fef2f2;      /* Error example backgrounds */
--teal-bg-light: #d1f2eb;       /* Info example backgrounds */
--warning-bg-light: #fff3cd;    /* Warning backgrounds */
--warning-border: #ffc107;      /* Warning borders */
```

Code block theme (dark mode within light theme):
```css
--code-bg-dark: #2d2d2d;        /* Code block backgrounds */
--code-bg-darker: #1e293b;      /* Special code blocks */
--code-text-light: #f8f8f2;     /* Code text color */
--code-text-lighter: #e2e8f0;   /* Special code text */
```

UI neutrals:
```css
--ui-border-light: #ddd;        /* Light borders, slider tracks */
--text-muted: #666;             /* Muted text (check WCAG in context!) */
--teal-hover: #2d6b61;          /* Hover states for teal elements */
```

Layout utilities:
```css
--shadow-sm: 0 4px 6px rgba(61, 40, 23, 0.06);
--shadow-md: 0 8px 12px rgba(61, 40, 23, 0.08);
--radius: 16px;
--radius-lg: 24px;
--readable-width: 75ch;
--readable-width-narrow: 65ch;
--readable-width-wide: 85ch;
```

**WCAG compliance requirements:**

- Normal text (< 18px): 4.5:1 contrast minimum
- Large text (≥18px or ≥14px bold): 3:1 contrast minimum
- Always use accessible variants for text on light backgrounds
- Test color combinations with browser DevTools accessibility panel

**Usage guidelines:**

Text colors on cream/peach backgrounds:
- Normal body text: `--dark-brown` (9.5:1 contrast)
- Secondary text: `--medium-brown` (5.3:1 contrast)
- Normal links/interactive: `--teal-darker` (4.5:1 contrast)
- Large bold orange: `--orange-darker` (3.1:1 contrast)
- Normal orange text: `--orange-darkest` (4.5:1 contrast)

Background combinations:
- Success examples: `--success-bg-light` + `--success-darker` text
- Error examples: `--error-bg-light` + `--error-darker` text
- Info callouts: `--teal-bg-light` + `--teal-darker` text
- Warning boxes: `--warning-bg-light` + `--dark-brown` text

**Color naming conventions:**

- Base colors: Named by appearance (e.g., `warm-orange`, `dark-brown`)
- Accessible variants: Add `-darker` or `-darkest` suffix
- Background variants: Add `-bg-light` suffix
- Hover states: Add `-hover` suffix

## CSS components library

This section documents reusable CSS components found in production HAP Learning Labs. Use these patterns to maintain visual consistency across all stations.

### HAP note callout

**Purpose:** Highlight important information or tips from HAP in his apprentice voice.

**Use cases:**
- HAP's personal insights or discoveries
- Important reminders or tips
- Side notes that add personality

**HTML structure:**
```html
<div class="hap-note-callout">
    <img src="[cloudinary-url]/hap-laptop_xiewar.jpg"
         alt="HAP at his laptop"
         width="100"
         height="100"
         class="hap-note-image">
    <div class="hap-note-content">
        <h3>🟠 HAP's Tip</h3>
        <p>When I first learned about this, Prof. Teeters showed me...</p>
    </div>
</div>
```

**CSS reference:**
```css
.hap-note-callout {
    background: linear-gradient(135deg, var(--cream-white) 0%, var(--peach-background) 100%);
    border-radius: var(--radius);
    padding: 1.5rem;
    margin: 2rem auto;
    border: 2px solid var(--warm-orange);
    display: flex;
    gap: 1.5rem;
    align-items: center;
    justify-content: center;
    max-width: 900px;
}

.hap-note-image {
    flex-shrink: 0;
    border-radius: var(--radius);
    box-shadow: var(--shadow-sm);
}

.hap-note-content {
    flex: 1;
}
```

**Responsive behavior:**
- Desktop (≥769px): Image on left, content on right
- Mobile (≤768px): Stacked layout, image above content, centered text

**Accessibility:**
- Image must have descriptive alt text
- Heading provides structure for screen readers
- Sufficient color contrast for text

---

### Insight card

**Purpose:** Display key concepts, tips, or learning points in a grid layout.

**Use cases:**
- Overview sections with multiple key points
- Station hub pages showing what you'll learn
- Quick reference cards

**HTML structure:**
```html
<div class="overview-grid">
    <div class="insight-card">
        <h3><span class="insight-icon">🎯</span> Heading</h3>
        <p>Description of the insight or concept...</p>
    </div>
    <!-- More cards... -->
</div>
```

**CSS reference:**
```css
.overview-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(min(300px, 100%), 1fr));
    gap: 2rem;
    margin: 2rem 0;
}

.insight-card {
    background: var(--cream-white);
    border-radius: var(--radius);
    padding: 2rem;
    box-shadow: var(--shadow-md);
    transition: all 0.3s ease;
    border: 2px solid transparent;
}

.insight-card:hover {
    box-shadow: var(--shadow-md);
    border-color: var(--soft-orange);
    transform: translateY(-4px);
}

.insight-card h3 {
    color: var(--dark-brown);
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}
```

**Responsive behavior:**
- Auto-fits columns based on available space
- Minimum 300px per card
- Single column on mobile (< 300px container width)

**Accessibility:**
- Heading provides card structure
- Hover effect visible but not required for interaction
- Cards are keyboard-focusable if they contain links

---

### Analysis grid

**Purpose:** Present multiple analysis points or comparisons in a structured grid.

**Use cases:**
- Breaking down complex topics into digestible points
- Comparing different approaches or techniques
- Highlighting multiple aspects of a concept

**HTML structure:**
```html
<div class="analysis-grid">
    <div class="analysis-point">
        <h3>Point Title</h3>
        <p>Detailed explanation of this analysis point...</p>
    </div>
    <!-- More points... -->
</div>
```

**CSS reference:**
```css
.analysis-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(min(250px, 100%), 1fr));
    gap: 1.5rem;
    margin: 2rem 0;
}

.analysis-point {
    background: var(--peach-background);
    border-radius: var(--radius);
    padding: 1.5rem;
    border-left: 4px solid var(--warm-orange);
}

.analysis-point h3 {
    color: var(--dark-brown);
    margin-bottom: 0.5rem;
}
```

**Responsive behavior:**
- Minimum 250px per card
- Automatically adjusts columns based on container width
- Single column on very narrow screens

**Accessibility:**
- Left border provides visual distinction
- Heading hierarchy maintained
- Background color has sufficient contrast

---

### HAP info grid

**Purpose:** Structured information display with headings and lists.

**Use cases:**
- Detailed explanations with multiple subsections
- Lists of tips or guidelines
- Structured educational content

**HTML structure:**
```html
<div class="hap-info-grid">
    <h4>Section Title</h4>
    <p>Introduction paragraph...</p>
    <ul>
        <li>Point one</li>
        <li>Point two</li>
    </ul>
    <h4>Another Section</h4>
    <p>More content...</p>
</div>
```

**CSS reference:**
```css
.hap-info-grid {
    background: linear-gradient(135deg, var(--cream-white) 0%, var(--peach-background) 100%);
    border-radius: var(--radius);
    padding: 1.5rem;
    margin: 2rem auto;
    border: 2px solid var(--warm-orange);
    max-width: 900px;
}

.hap-info-grid h4 {
    color: var(--dark-brown);
    margin-top: 1.5rem;
    margin-bottom: 0.75rem;
}

.hap-info-grid h4:first-child {
    margin-top: 0;
}

.hap-info-grid ul {
    list-style-position: outside;
    padding-left: 1.5rem;
    margin: 0.5rem 0;
}

.hap-info-grid li {
    margin-bottom: 0.5rem;
    line-height: 1.6;
}
```

**Responsive behavior:**
- Max-width constrains on large screens (900px)
- Full width on smaller screens
- Padding adjusts for mobile readability

**Accessibility:**
- Proper heading hierarchy (h4 for subsections)
- List semantics for screen readers
- Sufficient padding for touch targets

---

### Navigation patterns

**Purpose:** Consistent navigation between stations and back to hub.

**Top navigation (station pages):**
```html
<nav aria-label="Page navigation" class="page-navigation top-nav">
    <a href="../index.html" class="nav-link hub-link">🏠 Back to Hub</a>
    <div class="page-position">Station 3 of 6</div>
</nav>
```

**Bottom navigation (station pages):**
```html
<nav aria-label="Page navigation" class="page-navigation bottom-nav">
    <a href="station-2.html" class="nav-link">← Previous Station</a>
    <a href="../index.html" class="nav-link hub-link">🏠 Hub</a>
    <a href="station-4.html" class="nav-link">Next Station →</a>
</nav>
```

**CSS reference:**
```css
.page-navigation {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 1rem;
    flex-wrap: wrap;
}

.page-navigation.top-nav {
    margin-top: 1rem;
    margin-bottom: 1rem;
}

.page-navigation.bottom-nav {
    margin-top: 3rem;
    margin-bottom: 2rem;
    padding-top: 2rem;
    border-top: 2px solid var(--soft-orange);
}

.nav-link {
    padding: 0.75rem 1.5rem;
    background: var(--cream-white);
    color: var(--dark-brown);
    text-decoration: none;
    border: 2px solid var(--soft-orange);
    border-radius: var(--radius);
    font-weight: 600;
    transition: all 0.3s ease;
}

.nav-link:hover {
    background: var(--soft-orange);
    transform: translateY(-2px);
    box-shadow: var(--shadow-sm);
}

.nav-link.hub-link {
    background: var(--warm-orange);
    border-color: var(--warm-orange);
}

.page-position {
    color: var(--medium-brown);
    font-weight: 600;
}
```

**Responsive behavior:**
- Desktop: Horizontal layout with space-between
- Mobile (≤768px): Stacks vertically, full-width buttons, centered text
- Bottom nav maintains visual separation with top border

**Accessibility:**
- ARIA label distinguishes navigation landmark
- Clear link text with directional indicators (← →)
- Hub link visually distinct with emoji and color

---

### Footer pattern

**Purpose:** Consistent copyright and legal information on all pages.

**HTML structure:**
```html
<footer class="footer">
    <div class="footer-copyright">
        <img src="[cloudinary-url]/hap-avatar.jpg"
             alt="HAP avatar"
             width="80"
             height="80"
             class="footer-hybit">
        <div>
            <p>HAP™ Educational Content © 2025 Cynthia Teeters. All rights reserved.</p>
            <p>HyBit A. ProtoBot™ (HAP™) character and the apprentice learning methodology
               are proprietary educational innovations.</p>
            <p>Character concept, teaching methodology, and all written content created by
               Prof. Cynthia Teeters. Visual elements created with AI assistance.</p>
        </div>
    </div>
</footer>
```

**CSS reference:**
```css
.footer {
    background: var(--cream-white);
    border-radius: var(--radius-lg) var(--radius-lg) 0 0;
    padding: 2rem;
    margin-top: 4rem;
    text-align: center;
    box-shadow: var(--shadow-md);
}

.footer-copyright {
    display: flex;
    align-items: flex-start;
    gap: 1rem;
    margin-top: 1.5rem;
    padding-top: 1.5rem;
    border-top: 2px solid var(--peach-background);
    text-align: left;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
}

.footer-hybit {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    flex-shrink: 0;
    box-shadow: var(--shadow-sm);
}

.footer-copyright p {
    color: var(--medium-brown);
    font-size: clamp(0.85rem, 1.5vw, 0.9rem);
    margin: 0.25rem 0;
    line-height: 1.5;
}
```

**Responsive behavior:**
- Desktop: HAP avatar on left, text on right
- Mobile (≤768px): Stacks vertically, centered layout

**Accessibility:**
- Avatar has descriptive alt text
- Legal text is readable with proper contrast
- Font size remains readable on all screen sizes

---

### Component usage guidelines

**When to use each component:**

| Component | Best for | Avoid when |
|-----------|----------|------------|
| HAP note callout | Personal insights, tips | Formal instructions |
| Insight card | Overview concepts, key points | Long-form content |
| Analysis grid | Multiple related points | Single concept |
| HAP info grid | Structured lists, details | Short single points |
| Navigation | Station pages only | Hub page |
| Footer | Every page | Never omit |

**Combining components:**

Common patterns in production:
- Hero section → HAP note callout → Analysis grid → Navigation
- Overview grid (insight cards) → HAP info grid → Footer
- Content section → HAP note callout → Bottom navigation

**Spacing between components:**

Use consistent vertical spacing:
```css
.component + .component {
    margin-top: 3rem; /* Standard spacing */
}
```

**Maximum widths:**

Content components should constrain width for readability:
- HAP note callout: 900px
- HAP info grid: 900px
- Insight cards: Auto-fit within container
- Navigation: 1200px
- Footer: 800px for copyright text

## Interactive demo patterns

For interactive educational demonstrations (calculators, playgrounds, visualizers).

### Demo container

**Purpose:** Standard wrapper for interactive demonstrations.

**HTML structure:**
```html
<div class="demo-container">
    <h3>Demo Title</h3>
    <div class="demo-controls">
        <!-- Controls here -->
    </div>
    <div class="demo-preview">
        <!-- Preview/output here -->
    </div>
    <div class="css-output-box">
        <button class="copy-btn">Copy CSS</button>
        <pre><code>/* Generated CSS */</code></pre>
    </div>
</div>
```

**CSS reference:**
```css
.demo-container {
    background: var(--cream-white);
    border-radius: var(--radius-lg);
    padding: 2rem;
    margin: 2rem auto;
    max-width: 900px;
    box-shadow: var(--shadow-md);
}

.demo-controls {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.demo-preview {
    background: var(--peach-background);
    border-radius: var(--radius);
    padding: 2rem;
    margin-bottom: 2rem;
    border: 2px solid var(--soft-orange);
    min-height: 150px;
    display: flex;
    align-items: center;
    justify-content: center;
}
```

**Use cases:**
- Type scale calculators
- Variable font playgrounds
- Contrast ratio checkers
- Any interactive educational tool

---

### Slider controls

**Purpose:** Interactive sliders for adjusting demo parameters.

**HTML structure:**
```html
<div class="slider-group">
    <label class="slider-label">
        <span>Weight</span>
        <span class="slider-value">400</span>
    </label>
    <input type="range"
           class="slider"
           min="100"
           max="900"
           value="400"
           id="weight-slider">
</div>
```

**CSS reference:**
```css
.slider-group {
    display: flex;
    flex-direction: column;
}

.slider-label {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
    font-weight: 600;
    color: var(--teal-darker);
}

.slider-value {
    font-family: monospace;
    color: var(--orange-darkest);
    font-size: 0.875rem;
}

.slider {
    -webkit-appearance: none;
    appearance: none;
    width: 100%;
    height: 12px;
    background: linear-gradient(
        to right,
        var(--warm-orange) 0%,
        var(--warm-orange) 50%,  /* Fill percentage */
        var(--ui-border-light) 50%,
        var(--ui-border-light) 100%
    );
    border-radius: 6px;
    outline: none;
    transition: all 0.2s ease;
}

.slider:focus {
    box-shadow: 0 0 0 3px rgba(232, 165, 87, 0.2);
}

.slider::-webkit-slider-thumb {
    -webkit-appearance: none;
    appearance: none;
    width: 28px;
    height: 28px;
    background: var(--warm-orange);
    border: 3px solid white;
    border-radius: 50%;
    cursor: pointer;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
    transition: all 0.2s ease;
}

.slider::-webkit-slider-thumb:hover {
    transform: scale(1.15);
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.3);
}

.slider::-moz-range-thumb {
    width: 28px;
    height: 28px;
    background: var(--warm-orange);
    border: 3px solid white;
    border-radius: 50%;
    cursor: pointer;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
    transition: all 0.2s ease;
}

.slider::-moz-range-thumb:hover {
    transform: scale(1.15);
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.3);
}
```

**JavaScript pattern:**
```javascript
const slider = document.getElementById('weight-slider');
const valueDisplay = slider.parentElement.querySelector('.slider-value');

slider.addEventListener('input', (e) => {
    const value = e.target.value;
    valueDisplay.textContent = value;

    // Update fill gradient
    const percentage = ((value - slider.min) / (slider.max - slider.min)) * 100;
    slider.style.background = `linear-gradient(
        to right,
        var(--warm-orange) 0%,
        var(--warm-orange) ${percentage}%,
        var(--ui-border-light) ${percentage}%,
        var(--ui-border-light) 100%
    )`;

    // Apply to demo preview
    updatePreview(value);
});
```

**Accessibility:**
- Label associated with slider
- Current value displayed visually
- Keyboard navigation supported (arrow keys)
- Focus styles visible

---

### Color picker controls

**Purpose:** Color input with hex display for contrast calculators.

**HTML structure:**
```html
<div class="color-input-group">
    <label>Text Color</label>
    <div class="color-picker-wrapper">
        <input type="color"
               value="#3D2817"
               id="text-color">
        <input type="text"
               value="#3D2817"
               pattern="^#[0-9A-Fa-f]{6}$"
               id="text-hex">
    </div>
</div>
```

**CSS reference:**
```css
.color-input-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

.color-input-group label {
    font-weight: 600;
    color: var(--dark-brown);
}

.color-picker-wrapper {
    display: flex;
    gap: 0.75rem;
    align-items: center;
}

.color-picker-wrapper input[type="color"] {
    width: 60px;
    height: 50px;
    border: 2px solid var(--soft-orange);
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.color-picker-wrapper input[type="color"]:hover {
    border-color: var(--warm-orange);
    transform: scale(1.05);
}

.color-picker-wrapper input[type="text"] {
    flex: 1;
    padding: 0.75rem;
    border: 2px solid var(--soft-orange);
    border-radius: 8px;
    font-family: 'Source Code Pro', monospace;
    font-size: 1rem;
    color: var(--dark-brown);
    background: var(--peach-background);
    text-transform: uppercase;
}

.color-picker-wrapper input[type="text"]:focus {
    outline: none;
    border-color: var(--warm-orange);
    box-shadow: 0 0 0 3px rgba(232, 165, 87, 0.2);
}
```

**JavaScript pattern:**
```javascript
const colorInput = document.getElementById('text-color');
const hexInput = document.getElementById('text-hex');

// Sync color picker to hex input
colorInput.addEventListener('input', (e) => {
    hexInput.value = e.target.value.toUpperCase();
    updateDemo();
});

// Sync hex input to color picker
hexInput.addEventListener('input', (e) => {
    const hex = e.target.value;
    if (/^#[0-9A-Fa-f]{6}$/.test(hex)) {
        colorInput.value = hex;
        updateDemo();
    }
});
```

---

### Copy button

**Purpose:** Copy generated CSS code to clipboard.

**HTML structure:**
```html
<div class="css-output-box">
    <button class="copy-btn" onclick="copyCode(this)">Copy CSS</button>
    <pre><code id="css-output">/* Generated CSS */
.element {
    font-size: 1.5rem;
}</code></pre>
</div>
```

**CSS reference:**
```css
.css-output-box {
    background: var(--code-bg-dark);
    color: var(--code-text-light);
    padding: 1rem;
    border-radius: 4px;
    font-family: 'Courier New', monospace;
    font-size: 0.875rem;
    overflow-x: auto;
    margin-top: 1rem;
    position: relative;
}

.copy-btn {
    position: absolute;
    top: 10px;
    right: 1rem;
    background: var(--teal-darker);
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.2s ease;
    z-index: 10;
}

.copy-btn:hover {
    background: var(--teal-hover);
    transform: translateY(-1px);
}

.copy-btn:active {
    transform: translateY(0);
}
```

**JavaScript pattern:**
```javascript
function copyCode(button) {
    const codeBlock = button.nextElementSibling.querySelector('code');
    const code = codeBlock.textContent;

    navigator.clipboard.writeText(code).then(() => {
        // Success feedback
        const originalText = button.textContent;
        button.textContent = '✓ Copied!';
        button.style.background = 'var(--success-darker)';

        setTimeout(() => {
            button.textContent = originalText;
            button.style.background = 'var(--teal-darker)';
        }, 2000);
    }).catch(err => {
        console.error('Failed to copy:', err);
        button.textContent = '✗ Failed';
        setTimeout(() => {
            button.textContent = 'Copy CSS';
        }, 2000);
    });
}
```

**Accessibility:**
- Button has clear label
- Visual feedback on click
- Keyboard accessible
- Works with screen readers

---

### Preview box patterns

**Purpose:** Display live preview of demo output.

**Text preview:**
```html
<div class="demo-preview">
    <p class="preview-text" style="font-size: 2rem; font-weight: 700;">
        The quick brown fox jumps over the lazy dog
    </p>
</div>
```

**Color contrast preview:**
```html
<div class="demo-preview">
    <div class="preview-text-sample">
        <p class="preview-normal" style="color: #3D2817; background: #FFF8F0;">
            Normal text (16px)
        </p>
        <p class="preview-large" style="color: #3D2817; background: #FFF8F0;">
            Large text (24px)
        </p>
    </div>
</div>
```

**CSS reference:**
```css
.preview-text-sample {
    width: 100%;
    text-align: center;
}

.preview-normal {
    font-size: 1rem;
    font-weight: 400;
    padding: 1rem;
    border-radius: 4px;
    margin-bottom: 0.75rem;
}

.preview-large {
    font-size: 1.5rem;
    font-weight: 400;
    padding: 1rem;
    border-radius: 4px;
}
```

**Responsive:**
- Preview boxes scale to container
- Text remains readable at all sizes
- Min-height prevents collapse

## Utility classes reference

Complete reference of utility classes used in HAP Learning Labs.

### Spacing utilities

**Margin top:**
```css
.mt-0-5 { margin-top: 0.5rem; }
.mt-1   { margin-top: 1rem; }
.mt-1-5 { margin-top: 1.5rem; }
.mt-2   { margin-top: 2rem; }
.mt-3   { margin-top: 3rem; }
```

**Margin bottom:**
```css
.mb-0-5 { margin-bottom: 0.5rem; }
.mb-1   { margin-bottom: 1rem; }
.mb-1-5 { margin-bottom: 1.5rem; }
.mb-2   { margin-bottom: 2rem; }
```

**Padding:**
```css
.p-1 { padding: 1rem; }
.p-2 { padding: 2rem; }
.p-3 { padding: 3rem; }
```

### Typography utilities

**Font weights and styles:**
```css
.text-bold {
    font-weight: 700;
    font-size: 1.01em; /* Slight increase for visual compensation */
}

.text-left {
    text-align: left;
}
```

**Readable width constraints:**
```css
.read-length {
    max-width: var(--readable-width);
    margin-inline: auto;
}
```

### Color utilities

**Stat colors (large numbers/metrics):**
```css
.stat-large {
    font-size: clamp(1.2rem, 2.5vw + 0.5rem, 1.5rem);
    font-weight: 700;
    color: var(--orange-darker); /* 3.1:1 for large bold */
    margin: 0.5rem 0;
}

.stat-success {
    font-size: clamp(1.5rem, 3.5vw + 0.5rem, 2rem);
    font-weight: 800;
    color: var(--success-green-accessible); /* 3.1:1 for large bold */
    margin: 1rem 0;
}

.stat-orange {
    color: var(--orange-darker); /* 3.1:1 for large bold */
}

.stat-teal {
    color: var(--teal-darker); /* 4.5:1 for normal text */
}

.stat-brown {
    color: var(--medium-brown);
}
```

**Text colors:**
```css
.text-success {
    color: var(--success-darker); /* 4.5:1 contrast */
}

.text-error {
    color: var(--error-darker); /* 4.5:1 contrast */
}
```

### Layout utilities

**Content boxes:**
```css
.content-box {
    padding: 1.5rem;
    background: white;
    border-radius: 16px;
}
```

**List utilities:**
```css
.list-inside {
    list-style-position: inside;
}
```

### Usage examples

**Combining utilities:**
```html
<div class="content-box mt-2 mb-2">
    <p class="text-bold">Important information</p>
    <p class="stat-large stat-teal">99/100</p>
</div>
```

**Readable paragraphs:**
```html
<section class="read-length">
    <p class="mt-1 mb-1">This paragraph will be constrained to 75ch for optimal readability...</p>
</section>
```

**Stats display:**
```html
<div class="hap-info-grid">
    <p class="stat-success">100/100</p>
    <p>Perfect accessibility score!</p>
</div>
```

### Guidelines

**When to use utilities:**
- Simple spacing adjustments (margins/padding)
- Text alignment and font weights
- Color variations for stats and metrics
- Readable width constraints

**When NOT to use utilities:**
- Complex layouts (use components)
- Multiple properties (create a component class)
- Repeated patterns (extract to component)

**Naming convention:**
- Property abbreviation + value
- Kebab-case for multi-word values
- Use increment scale (0.5, 1, 1.5, 2, 3)

## JavaScript standards

### Code style

**Use modern JavaScript:**
```javascript
// Arrow functions
const greet = (name) => `Hello, ${name}!`;

// const/let (not var)
const MAX_ITEMS = 10;
let count = 0;

// Template literals
const message = `Station ${stationNumber} of ${totalStations}`;
```

**Event listeners:**
```javascript
// Use addEventListener (not onclick attributes)
element.addEventListener('click', handleClick);
```

**Async operations:**
```javascript
// Use async/await
const data = await fetch(url).then(res => res.json());

// Or promises
fetch(url)
    .then(res => res.json())
    .then(data => console.log(data));
```

### Easter egg system

**Security patterns:**
- Whitelist validation (allowedParams)
- No user input in HTML
- Pre-defined messages only
- Safe HTML tags: `<code>`, `<strong>`, `<em>`, `<br>`

**Dialog usage:**
```javascript
// Use native dialog element
const dialog = document.querySelector('dialog');
dialog.showModal();  // Shows with backdrop
dialog.close();      // Closes dialog
```

## Content standards

### HAP's voice guidelines

**Apprentice perspective (always):**
- ✅ "I learned from Prof. Teeters that..."
- ✅ "When I was practicing..."
- ❌ "You should..."
- ❌ "This tutorial teaches..."

**References Prof. Teeters:**
- ✅ "Prof. Teeters explained it like this..."
- ✅ "Prof. Teeters showed me..."
- ❌ Generic statements without attribution

**Humble and relatable:**
- ✅ "This was tricky for me too"
- ✅ "Some concepts can seem confusing"
- ❌ "This is simple to understand"
- ❌ "Obviously, the answer is..."

**See full voice guide:** `reports/phase1/hap-voice-guide.md`

### Writing style

**Heading capitalization:**

HTML files use **title case** (educational content for students):
- ✅ "The Resolution Problem"
- ✅ "Why Typography Matters"
- ✅ "What You'll Learn"

Markdown files use **sentence case** (technical documentation):
- ✅ "The resolution problem"
- ✅ "Why typography matters"
- ✅ "What you'll learn"

**Title case rules (HTML):**
- Capitalize first and last words
- Capitalize all major words (nouns, verbs, adjectives, adverbs)
- Lowercase articles (a, an, the), conjunctions (and, but, or), short prepositions (in, on, at, to, for)

**Sentence case rules (markdown):**
- Capitalize only the first word
- Capitalize proper nouns (HAP, Prof. Teeters, Station 1, etc.)
- Lowercase everything else

**Rationale:** HTML content is user-facing educational material following traditional publishing standards (title case), while markdown files are technical documentation following modern web conventions (sentence case).

**Active voice preferred:**
- ✅ "Prof. Teeters taught me about responsive images"
- ❌ "Responsive images were taught to me"

**Concrete examples:**
- Use real file sizes, real measurements
- Show actual code snippets
- Include visual comparisons

### Emoji usage

**IMPORTANT: Never use robot emoji 🤖** - We have actual HAP character images for visual representation.

**HAP's primary emoji:**
- 🟠 Orange circle - Tips, insights, key points, important notes

**Approved emoji with good visibility on cream/brown background:**
- 🔬 Microscope - Science, research, lab context
- 📊 Chart - Data, metrics, statistics
- 🎯 Target - Goals, objectives, targets
- 🎨 Palette - Design, visuals, colors
- 📸 Camera - Photography, images
- 🚀 Rocket - Performance, speed, optimization
- 🌐 Globe - Web, browsers, internet
- 📦 Package - File sizes, compression, bundles
- 🤔 Reflective - Thinking, consideration

**Subject-specific emoji:**

Typography labs:
- 🔤 Letters - Font concepts
- 📝 Memo - Writing, text
- 📐 Ruler - Measurements, spacing

Image labs:
- 🖼️ Frame - Picture elements
- 📱 Mobile - Responsive design
- 💾 Disk - File formats, storage

**Explicitly avoid - poor visibility on cream background:**
- ❌ 💡 Light bulb (yellow)
- ❌ ⚡ Lightning bolt (yellow)
- ❌ ⭐ Star (yellow)
- ❌ ✨ Sparkles (yellow)
- ❌ 🤖 Robot (use HAP images instead)

**Guidelines:**
- 1-2 emoji per section maximum
- Use for personality and clarity, not decoration
- Consistent meanings across labs
- Test visibility on cream/peach backgrounds
- Prefer 🟠 (orange circle) for HAP's tips and insights

## Common content patterns

This section documents repeatable content patterns found across HAP Learning Labs, ensuring consistency in how educational material is structured and presented.

### Station introduction pattern

**Purpose:** Establish HAP's apprentice voice and set learning expectations.

**HTML structure:**
```html
<header class="header">
    <div class="header-content">
        <div class="hybit-welcome">
            <div class="hybit-avatar">
                <img src="[cloudinary-url]/hap-laptop_xiewar.jpg"
                     alt="HAP at his laptop"
                     width="150"
                     height="150"
                     fetchpriority="high">
            </div>
            <div>
                <h1>[Station Title]</h1>
                <p class="subtitle">Station X of 6: [Subtitle]</p>
            </div>
        </div>
        <div class="intro-box">
            <p><strong>Welcome to Station X!</strong> I'm HAP, and [HAP's apprentice voice introduction explaining what Prof. Teeters taught them about this topic]...</p>
        </div>
    </div>
</header>
```

**Content guidelines:**

Station introductions should:
- Start with "Welcome to Station X!" greeting
- Include HAP's personal learning experience
- Reference Prof. Teeters as mentor/teacher
- Explain what students will learn and why it matters
- Use first-person perspective ("I learned", "Prof. Teeters showed me")
- Set enthusiastic but humble tone

**Example opening:**
> Welcome to Station 3! I'm HAP, and when Prof. Teeters first showed me variable fonts, my mind was BLOWN 🔬 One font file that can be 12 different fonts? That seemed like magic! But it's real, and it's one of the coolest typography advances in years.

---

### Real metrics pattern

**Purpose:** Ground educational content in concrete measurements.

**Use cases:**
- File size comparisons
- Performance metrics
- Lighthouse scores
- Percentages and statistics
- Time measurements

**HTML structure:**
```html
<div class="hap-info-grid">
    <p class="stat-success">99/100</p>
    <p>Perfect Lighthouse performance score!</p>

    <p class="stat-large stat-orange">245 KB → 89 KB</p>
    <p>WebP format reduced file size by 64%</p>

    <p class="stat-large stat-teal">3.4 KB</p>
    <p>Total JavaScript for entire lab</p>
</div>
```

**Guidelines:**

Real metrics should:
- Use actual measurements, not estimates
- Include units (KB, px, ms, %)
- Show before/after comparisons when relevant
- Use stat utility classes for visual emphasis
- Provide context for what the numbers mean

---

### Before/after comparison pattern

**Purpose:** Visually demonstrate impact of techniques taught.

**Image comparison:**
```html
<div class="analysis-grid">
    <div class="analysis-point">
        <h3>❌ Before: Random Sizing</h3>
        <img src="[cloudinary-url]/before-example.jpg"
             alt="Inconsistent font sizes"
             width="400"
             height="300"
             loading="lazy">
        <p><strong>Problem:</strong> Sizes chosen randomly: 18px, 22px, 31px, 43px...</p>
    </div>

    <div class="analysis-point">
        <h3>✅ After: Modular Scale</h3>
        <img src="[cloudinary-url]/after-example.jpg"
             alt="Systematic font scale"
             width="400"
             height="300"
             loading="lazy">
        <p><strong>Solution:</strong> Perfect fourth scale (1.333): 16px, 21px, 28px, 37px...</p>
    </div>
</div>
```

**Code comparison:**
```html
<div class="hap-info-grid">
    <h4>❌ Before: Hardcoded values</h4>
    <pre><code class="language-css">h1 { font-size: 43px; }
h2 { font-size: 31px; }
h3 { font-size: 22px; }</code></pre>

    <h4>✅ After: Custom properties</h4>
    <pre><code class="language-css">:root {
    --scale-5: 2.369rem;
    --scale-4: 1.777rem;
    --scale-3: 1.333rem;
}

h1 { font-size: var(--scale-5); }
h2 { font-size: var(--scale-4); }
h3 { font-size: var(--scale-3); }</code></pre>
</div>
```

**Guidelines:**

Before/after comparisons should:
- Use ❌ and ✅ for visual clarity
- Label "Before" and "After" explicitly
- Explain the problem and solution
- Show equal-sized examples for fair comparison
- Place side-by-side on desktop, stack on mobile

---

### "What I learned" sections

**Purpose:** HAP reflects on key takeaways in apprentice voice.

**HTML structure:**
```html
<section class="content-section">
    <h2>🟠 What I Learned</h2>

    <div class="hap-note-callout">
        <img src="[cloudinary-url]/hap-laptop_xiewar.jpg"
             alt="HAP at his laptop"
             width="100"
             height="100"
             class="hap-note-image">
        <div class="hap-note-content">
            <h3>HAP's Key Takeaways</h3>
            <ul>
                <li><strong>[Topic 1]:</strong> Prof. Teeters taught me that [insight in HAP's voice]...</li>
                <li><strong>[Topic 2]:</strong> I discovered [personal learning moment]...</li>
                <li><strong>[Topic 3]:</strong> The biggest surprise was [revelation]...</li>
            </ul>
        </div>
    </div>
</section>
```

**Content guidelines:**

Reflection sections should:
- Use first-person perspective throughout
- Reference specific learning moments
- Mention Prof. Teeters as source of wisdom
- Include personal reactions ("This surprised me", "I was confused at first")
- Connect to broader web development context
- End with encouragement or next steps

**Example:**
> Prof. Teeters taught me that variable fonts aren't just about file size—they open up creative possibilities that weren't possible before. I can animate font weight! I can make text respond to user actions! That's when typography becomes truly interactive.

---

### Code snippet pattern

**Purpose:** Provide copy-paste ready code with syntax highlighting.

**With copy button:**
```html
<div class="css-output-box">
    <button class="copy-btn" onclick="copyCode(this)">Copy CSS</button>
    <pre><code class="language-css">/* Generated type scale */
:root {
    --base-size: 1rem;
    --scale-ratio: 1.333;
    --scale-0: var(--base-size);
    --scale-1: calc(var(--scale-0) * var(--scale-ratio));
}</code></pre>
</div>
```

**Without copy button (explanatory):**
```html
<pre><code class="language-html">&lt;picture&gt;
    &lt;source srcset="image.avif" type="image/avif"&gt;
    &lt;source srcset="image.webp" type="image/webp"&gt;
    &lt;img src="image.jpg" alt="Fallback"&gt;
&lt;/picture&gt;</code></pre>
```

**Guidelines:**

Code snippets should:
- Always specify language: `class="language-html"`, `class="language-css"`, `class="language-javascript"`
- Use proper HTML entity encoding (`&lt;` not `<`)
- Include comments explaining key lines
- Show complete, working examples
- Provide copy button for generated/reusable code
- Maintain consistent indentation (2 or 4 spaces)

---

### HAP callout variations

**Tip callout:**
```html
<div class="hap-note-callout">
    <img src="[cloudinary-url]/hap-laptop_xiewar.jpg" ... >
    <div class="hap-note-content">
        <h3>🟠 HAP's Tip</h3>
        <p>Prof. Teeters taught me this shortcut: [practical tip]...</p>
    </div>
</div>
```

**Warning callout:**
```html
<div class="hap-note-callout" style="border-color: var(--warning-border); background: var(--warning-bg-light);">
    <img src="[cloudinary-url]/hap-thinking.jpg" ... >
    <div class="hap-note-content">
        <h3>⚠️ Common Mistake</h3>
        <p>When I first tried this, I made a mistake that Prof. Teeters helped me fix: [mistake and solution]...</p>
    </div>
</div>
```

**Success callout:**
```html
<div class="hap-note-callout" style="border-color: var(--success-darker); background: var(--success-bg-light);">
    <img src="[cloudinary-url]/hap-celebrating.jpg" ... >
    <div class="hap-note-content">
        <h3>✅ Success!</h3>
        <p>After applying what Prof. Teeters taught me, [achievement]...</p>
    </div>
</div>
```

---

### Overview section pattern

**Purpose:** Summarize key learning points at station start.

**HTML structure:**
```html
<section class="intro-section">
    <h2>What You'll Learn</h2>

    <div class="overview-grid">
        <div class="insight-card">
            <h3><span class="insight-icon">🎯</span> [Topic 1]</h3>
            <p>Brief description of first learning objective...</p>
        </div>

        <div class="insight-card">
            <h3><span class="insight-icon">🔬</span> [Topic 2]</h3>
            <p>Brief description of second learning objective...</p>
        </div>

        <div class="insight-card">
            <h3><span class="insight-icon">📊</span> [Topic 3]</h3>
            <p>Brief description of third learning objective...</p>
        </div>
    </div>
</section>
```

**Guidelines:**

Overview sections should:
- Use 3-6 insight cards (not too many)
- Include relevant emoji icon for each topic
- Keep descriptions brief (2-3 sentences max)
- Focus on what students will be able to do
- Match card order to content sequence
- Use action-oriented language

---

### Demo scaffolding pattern

**Purpose:** Consistent structure for all interactive educational tools.

**Complete demo structure:**
```html
<section class="content-section">
    <h2>[Demo Name]</h2>

    <div class="demo-container">
        <h3>Try It Yourself</h3>

        <!-- Controls -->
        <div class="demo-controls">
            [Sliders, inputs, color pickers]
        </div>

        <!-- Live preview -->
        <div class="demo-preview">
            [Preview element that updates in real-time]
        </div>

        <!-- Generated code output -->
        <div class="css-output-box">
            <button class="copy-btn" onclick="copyCode(this)">Copy CSS</button>
            <pre><code id="output">[Generated CSS code]</code></pre>
        </div>
    </div>
</section>
```

**JavaScript pattern:**
```javascript
// Update preview and code output
function updateDemo() {
    const value = document.getElementById('control').value;

    // Update preview
    const preview = document.querySelector('.demo-preview');
    preview.style.property = value;

    // Update code output
    const output = document.getElementById('output');
    output.textContent = `/* Generated CSS */
.element {
    property: ${value};
}`;
}

// Initialize demo
document.getElementById('control').addEventListener('input', updateDemo);
updateDemo(); // Set initial state
```

**Guidelines:**

Interactive demos should:
- Start with "Try It Yourself" or similar encouragement
- Show real-time preview as user adjusts controls
- Generate valid, copy-paste ready code
- Provide copy button for convenience
- Initialize with sensible default values
- Include HAP's guidance on how to use the demo

---

## Image attribution standards

When using third-party images (Unsplash, other sources), proper attribution is required.

### Unsplash attribution format

**In visible page content:**

```html
<p class="image-credit">Photo by
    <a href="https://unsplash.com/@[username]?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">[Photographer Name]</a>
    on
    <a href="https://unsplash.com/photos/[photo-description]-[photo-id]?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
</p>
```

**CSS for image credits:**
```css
.image-credit {
    font-size: 0.85rem;
    color: var(--medium-brown);
    text-align: center;
    margin-top: 0.5rem;
}

.image-credit a {
    color: var(--teal-darker);
    text-decoration: underline;
}
```

**Example:**
```html
<img src="https://res.cloudinary.com/cynthia-teeters/image/upload/v1759357191/david-lartey-AQc8CF54rVM-unsplash_f53zgz.jpg"
     alt="A lone tree in a field at sunset"
     width="800"
     height="600"
     loading="lazy">

<p class="image-credit">Photo by
    <a href="https://unsplash.com/@dbilovd?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">David Lartey</a>
    on
    <a href="https://unsplash.com/photos/a-lone-tree-in-the-middle-of-a-field-AQc8CF54rVM?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
</p>
```

### Cloudinary image attribution

**For HAP character images:**

No attribution required—these are proprietary to Prof. Cynthia Teeters. Include trademark notice in footer as usual.

**For third-party images hosted on Cloudinary:**

Maintain original attribution even when served via Cloudinary CDN:

```html
<!-- Image from Unsplash, hosted on Cloudinary -->
<img src="https://res.cloudinary.com/cynthia-teeters/image/upload/f_auto,q_auto,w_800/unsplash-photo-id.jpg"
     alt="Description"
     width="800"
     height="600">

<!-- Still include Unsplash attribution -->
<p class="image-credit">Photo by [Photographer] on <a href="...">Unsplash</a></p>
```

### Attribution placement

**Single image:**
- Place attribution immediately below image
- Use `.image-credit` class for consistent styling

**Image gallery:**
- Group attributions at end of gallery section
- List each image with its credit

**Background images:**
- Attribution in footer or dedicated credits section
- Link "Image Credits" from page footer

### Required attribution elements

For all third-party images:
- Photographer/creator name (linked to their profile)
- Source platform name (linked to photo page)
- UTM parameters for Unsplash (required by their license)
- Clear visual association with the attributed image

### When attribution is not required

- HAP™ character images (proprietary)
- Original screenshots of demos/interfaces
- Custom-created graphics and diagrams
- Icons from icon fonts (Font Awesome, etc., check license)
- Public domain images (still recommended to note "Public Domain")

---

## File organization

### Naming conventions

**Files:**
- Lowercase with hyphens: `responsive-images.html`
- Descriptive names: `easter-egg.js` (not `ee.js`)
- Consistent extensions: `.html`, `.css`, `.js`

**Directories:**
- Lowercase: `stations/`, `css/`, `js/`
- Plural for collections: `stations/` (not `station/`)

### Directory structure

```
hap-template/
├── index.html              # Hub page
├── stations/               # Learning stations
│   └── [station-name].html
├── css/
│   ├── style.css          # Main styles
│   └── prism-hap-theme.css
├── js/
│   └── easter-egg.js
├── data/
│   └── hybit-insights.jsonc
└── docs/
    └── style-guide.md     # This file
```

## Performance standards

### Loading optimization

**Critical rendering path:**
1. Preconnect to external domains
2. Load critical CSS inline or early
3. Defer non-critical JavaScript
4. Lazy load below-fold images

**Target metrics:**
- Lighthouse Performance: ≥99/100
- Lighthouse Accessibility: 100/100
- Lighthouse Best Practices: 100/100
- Lighthouse SEO: 100/100

### Image optimization

**Always use Cloudinary:**
- `f_auto` - Automatic format (WebP/AVIF)
- `q_auto` - Automatic quality
- Width constraints: `w_[size]`
- Crop strategies: `c_limit`, `c_fill`, `c_scale`

**Loading priority:**
- LCP image: `fetchpriority="high"`, no lazy loading
- Above-fold: No lazy loading
- Below-fold: `loading="lazy"`

## Lighthouse CI (optional automated testing)

Lighthouse CI provides automated performance audits for all HAP Learning Lab pages, ensuring consistent high scores across stations.

### What is Lighthouse CI?

**Purpose:** Automated performance testing for continuous quality assurance

**Benefits:**
- Consistent 95+ Lighthouse scores across all pages
- Early detection of performance regressions
- HTML reports showing metrics over time
- Automated checks for accessibility and SEO

**Status:** Optional development tool (site works perfectly without it)

### Installation

**Install npm dependencies:**

```bash
npm install --save-dev @lhci/cli
```

**Configuration files:**

- `package.json` - npm scripts for running audits
- `lighthouserc.json` - Lighthouse CI settings

### Usage

**Run audits on individual pages:**

```bash
npm run lh:ci:hub       # Hub page only
npm run lh:ci:station1  # Station 1 only
npm run lh:ci:station2  # Station 2 only
```

**Run audits on all pages:**

```bash
npm run lh:ci:all       # All pages sequentially
```

**Output:**

Reports are generated in `reports/` directory (gitignored) with HTML visualizations of:
- Performance scores
- Accessibility checks
- Best practices adherence
- SEO optimization

### Configuration example

**lighthouserc.json:**

```json
{
  "ci": {
    "collect": {
      "staticDistDir": "./",
      "url": [
        "http://localhost:8000/index.html",
        "http://localhost:8000/stations/station-1.html",
        "http://localhost:8000/stations/station-2.html"
      ]
    },
    "assert": {
      "assertions": {
        "categories:performance": ["error", {"minScore": 0.95}],
        "categories:accessibility": ["error", {"minScore": 1.0}],
        "categories:best-practices": ["error", {"minScore": 1.0}],
        "categories:seo": ["error", {"minScore": 1.0}]
      }
    },
    "upload": {
      "target": "filesystem",
      "outputDir": "./reports"
    }
  }
}
```

**package.json scripts:**

```json
{
  "scripts": {
    "lh:ci:hub": "lhci autorun --config=lighthouserc-hub.json",
    "lh:ci:station1": "lhci autorun --config=lighthouserc-station1.json",
    "lh:ci:all": "lhci autorun --config=lighthouserc-all.json"
  },
  "devDependencies": {
    "@lhci/cli": "^0.14.0"
  }
}
```

### Workflow integration

**Development workflow:**

1. Make changes to HTML/CSS/JS
2. Run `python3 -m http.server 8000` in separate terminal
3. Run `npm run lh:ci:all` to test all pages
4. Review reports in `reports/` directory
5. Fix any regressions before committing

**Pre-commit checks:**

Optional: Add Lighthouse CI to git pre-commit hooks to ensure quality standards are met before committing changes.

### Performance targets

**Minimum acceptable scores:**

- Performance: 95/100 (allows 5-point margin for variability)
- Accessibility: 100/100 (strict requirement)
- Best Practices: 100/100 (strict requirement)
- SEO: 100/100 (strict requirement)

**Common issues and fixes:**

| Issue | Solution |
|-------|----------|
| Images without width/height | Add explicit dimensions |
| Scripts blocking render | Add `defer` attribute |
| Below-fold images not lazy | Add `loading="lazy"` |
| Missing alt text | Add descriptive alt text |
| Poor contrast ratios | Use accessible color variants |

### When to use Lighthouse CI

**Recommended for:**
- Multi-station labs (3+ pages)
- When teaching performance optimization
- Team development (consistent standards)
- Long-term maintenance (detect regressions)

**Skip for:**
- Single-page prototypes
- Quick experimental demos
- Simple static pages
- When unfamiliar with Node/npm

### Troubleshooting

**"Port already in use" error:**

Stop other servers on port 8000 before running Lighthouse CI, or configure different port in lighthouserc.json.

**Inconsistent performance scores:**

Lighthouse performance scores can vary by ±5 points due to system load. Run multiple times and average results.

**Reports not generating:**

Ensure `reports/` directory exists and has write permissions, or Lighthouse CI will silently fail to save reports.

---

## Subject-specific patterns

Patterns unique to specific learning lab subject areas (typography, images, etc.).

### Typography-specific patterns

For typography learning labs (like hap-fonts).

#### Font specimen display

**Purpose:** Show font characteristics at various weights/sizes.

**HTML structure:**

```html
<div class="font-specimen">
    <h3 style="font-family: 'Inter Variable'; font-weight: 400;">
        The quick brown fox jumps over the lazy dog
    </h3>
    <h3 style="font-family: 'Inter Variable'; font-weight: 700;">
        The quick brown fox jumps over the lazy dog
    </h3>
    <h3 style="font-family: 'Inter Variable'; font-weight: 900;">
        The quick brown fox jumps over the lazy dog
    </h3>
</div>
```

**CSS reference:**

```css
.font-specimen {
    background: var(--cream-white);
    border-radius: var(--radius);
    padding: 2rem;
    margin: 2rem 0;
}

.font-specimen h3 {
    margin: 1rem 0;
    font-size: clamp(1.5rem, 3vw, 2rem);
}
```

#### Type scale comparison

**Purpose:** Visually compare different modular scale ratios.

**HTML structure:**

```html
<div class="comparison-grid">
    <div class="comparison-column">
        <h4>Scale 1.25 (Major Third)</h4>
        <p style="font-size: 1rem;">1rem</p>
        <p style="font-size: 1.25rem;">1.25rem</p>
        <p style="font-size: 1.563rem;">1.563rem</p>
        <p style="font-size: 1.953rem;">1.953rem</p>
    </div>

    <div class="comparison-column">
        <h4>Scale 1.333 (Perfect Fourth)</h4>
        <p style="font-size: 1rem;">1rem</p>
        <p style="font-size: 1.333rem;">1.333rem</p>
        <p style="font-size: 1.777rem;">1.777rem</p>
        <p style="font-size: 2.369rem;">2.369rem</p>
    </div>
</div>
```

#### Font pairing examples

**Purpose:** Demonstrate good and bad font combinations.

**HTML structure:**

```html
<div class="pairing-gallery">
    <div class="pairing-example good-pairing">
        <h3 style="font-family: 'Playfair Display', serif;">Elegant Serif Heading</h3>
        <p style="font-family: 'Source Sans Pro', sans-serif;">Readable sans-serif body text that complements the heading without competing.</p>
        <span class="pairing-label">✅ Good Pairing</span>
    </div>

    <div class="pairing-example bad-pairing">
        <h3 style="font-family: 'Comic Sans MS', cursive;">Comic Sans Heading</h3>
        <p style="font-family: 'Comic Sans MS', cursive;">Using the same casual font for everything lacks hierarchy and looks unprofessional.</p>
        <span class="pairing-label">❌ Bad Pairing</span>
    </div>
</div>
```

**CSS reference:**

```css
.pairing-example.good-pairing {
    border-color: var(--success-darker);
    background: var(--success-bg-light);
}

.pairing-example.bad-pairing {
    border-color: var(--error-darker);
    background: var(--error-bg-light);
}

.pairing-label {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border-radius: 4px;
    font-size: 0.875rem;
    font-weight: 600;
    margin-top: 1rem;
}
```

---

### Image-specific patterns

For image optimization learning labs (like poem-images).

#### Device frame comparison

**Purpose:** Show responsive image delivery across devices.

**HTML structure:**

```html
<div class="device-comparison">
    <div class="device-frame mobile">
        <div class="device-screen">
            <img src="[cloudinary-url]/w_360/image.jpg"
                 alt="Mobile view"
                 width="360"
                 height="640">
        </div>
        <p class="device-label">📱 Mobile: 360×640 (89 KB)</p>
    </div>

    <div class="device-frame tablet">
        <div class="device-screen">
            <img src="[cloudinary-url]/w_768/image.jpg"
                 alt="Tablet view"
                 width="768"
                 height="1024">
        </div>
        <p class="device-label">📱 Tablet: 768×1024 (156 KB)</p>
    </div>

    <div class="device-frame desktop">
        <div class="device-screen">
            <img src="[cloudinary-url]/w_1920/image.jpg"
                 alt="Desktop view"
                 width="1920"
                 height="1080">
        </div>
        <p class="device-label">🖥️ Desktop: 1920×1080 (245 KB)</p>
    </div>
</div>
```

**CSS reference:**

```css
.device-comparison {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    margin: 2rem 0;
}

.device-frame {
    background: var(--ui-border-light);
    border-radius: var(--radius);
    padding: 1rem;
}

.device-screen {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    margin-bottom: 0.5rem;
}

.device-screen img {
    width: 100%;
    height: auto;
    display: block;
}
```

#### Image format comparison table

**Purpose:** Compare file sizes and browser support across formats.

**HTML structure:**

```html
<div class="hap-info-grid">
    <h4>Format Comparison</h4>

    <table class="format-table">
        <thead>
            <tr>
                <th>Format</th>
                <th>File Size</th>
                <th>Savings</th>
                <th>Browser Support</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong>JPEG (baseline)</strong></td>
                <td class="stat-large">245 KB</td>
                <td>—</td>
                <td>✅ 100%</td>
            </tr>
            <tr>
                <td><strong>WebP</strong></td>
                <td class="stat-large stat-teal">89 KB</td>
                <td class="stat-success">64% smaller</td>
                <td>✅ 97%</td>
            </tr>
            <tr>
                <td><strong>AVIF</strong></td>
                <td class="stat-large stat-teal">56 KB</td>
                <td class="stat-success">77% smaller</td>
                <td>⚠️ 85%</td>
            </tr>
        </tbody>
    </table>
</div>
```

**CSS reference:**

```css
.format-table {
    width: 100%;
    border-collapse: collapse;
    margin: 1rem 0;
}

.format-table th {
    background: var(--peach-background);
    padding: 0.75rem;
    text-align: left;
    font-weight: 700;
    border-bottom: 2px solid var(--warm-orange);
}

.format-table td {
    padding: 0.75rem;
    border-bottom: 1px solid var(--ui-border-light);
}

.format-table tr:last-child td {
    border-bottom: none;
}
```

#### Resolution demonstration

**Purpose:** Show pixelation issues with low-resolution images.

**HTML structure:**

```html
<div class="resolution-demo">
    <div class="resolution-example">
        <h4>❌ Low Resolution (150×150)</h4>
        <img src="[cloudinary-url]/w_150,h_150,c_fill/image.jpg"
             alt="Low resolution example"
             width="300"
             height="300"
             style="image-rendering: auto;">
        <p>Stretched from 150px to 300px - notice pixelation</p>
    </div>

    <div class="resolution-example">
        <h4>✅ High Resolution (600×600)</h4>
        <img src="[cloudinary-url]/w_600,h_600,c_fill/image.jpg"
             alt="High resolution example"
             width="300"
             height="300">
        <p>Scaled down from 600px to 300px - crisp and clear</p>
    </div>
</div>
```

#### Art direction example

**Purpose:** Demonstrate `<picture>` element for art direction.

**HTML structure:**

```html
<div class="art-direction-demo">
    <h4>Art Direction with &lt;picture&gt;</h4>

    <picture>
        <!-- Mobile: Portrait crop showing subject's face -->
        <source media="(max-width: 768px)"
                srcset="[cloudinary-url]/w_400,h_600,c_fill,g_face/portrait.jpg">

        <!-- Desktop: Landscape crop showing full scene -->
        <source media="(min-width: 769px)"
                srcset="[cloudinary-url]/w_1200,h_600,c_fill/landscape.jpg">

        <!-- Fallback -->
        <img src="[cloudinary-url]/w_800,h_600/landscape.jpg"
             alt="Responsive art direction example"
             width="1200"
             height="600">
    </picture>

    <p><strong>Try resizing your browser!</strong> The image crops differently on mobile vs desktop to maintain subject focus at all viewport sizes.</p>
</div>
```

---

## Code syntax highlighting

HAP Learning Labs use Prism.js for syntax highlighting of code examples.

### Prism.js implementation

**CDN approach (recommended):**

```html
<!-- In <head> section -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/themes/prism.min.css"
      integrity="sha384-[SRI-hash]" crossorigin="anonymous">
<link rel="stylesheet" href="css/prism-hap-theme.css">

<!-- Before closing </body> tag -->
<script src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/prism.min.js"
        integrity="sha384-[SRI-hash]" crossorigin="anonymous" defer></script>
<script src="https://cdn.jsdelivr.net/npm/prismjs@1.29.0/components/prism-markup.min.js"
        integrity="sha384-[SRI-hash]" crossorigin="anonymous" defer></script>
```

**Custom HAP theme:**

All HAP Labs use `css/prism-hap-theme.css` with warm orange/teal color scheme:
- HTML tags: `#E8A557` (warm orange)
- Attributes: `#5BA69C` (teal)
- Values: `#F4C584` (soft orange)
- Comments: `#9B8474` (light brown)

### HTML structure for code blocks

**Basic code block:**

```html
<pre><code class="language-html">&lt;div class="example"&gt;
    &lt;p&gt;Content here&lt;/p&gt;
&lt;/div&gt;</code></pre>
```

**With line highlighting (if enabled):**

```html
<pre data-line="2,4-6"><code class="language-css">.selector {
    color: var(--warm-orange);  /* Highlighted */
    font-size: 1rem;
    padding: 1rem;              /* Highlighted */
    margin: 0;                  /* Highlighted */
    border-radius: 8px;         /* Highlighted */
}</code></pre>
```

### Language support

**Commonly used languages in HAP Labs:**
- `language-html` - HTML/markup (most common)
- `language-css` - CSS stylesheets
- `language-javascript` - JavaScript code
- `language-bash` - Terminal commands
- `language-json` - JSON data

### Performance considerations

**Bundle size:**
- Prism core: ~2KB gzipped
- HTML language: ~0.4KB gzipped
- Custom HAP theme: ~1KB gzipped
- Total: ~3.4KB

**Impact:**
- Minimal LCP impact: +5-10ms
- Defer loading for below-fold code
- Use only needed language modules

### Accessibility

**Required patterns:**
- Semantic `<pre><code>` structure
- Language class on `<code>` element: `class="language-html"`
- Proper HTML entity encoding: `&lt;` not `<`
- Readable color contrast in custom theme (tested against dark backgrounds)

### Updating Prism version

When updating Prism.js version:

1. Update CDN URLs with new version number
2. Generate new SRI hashes: `https://www.srihash.org/`
3. Test with all language modules used
4. Verify custom HAP theme still applies correctly
5. Check performance impact with Lighthouse
6. Update this documentation with new version number

## Legal and licensing

### Copyright notice

**Footer (all pages):**
```html
<p>HAP™ Educational Content © 2025 Cynthia Teeters. All rights reserved.</p>
<p>HyBit A. ProtoBot™ (HAP™) character and the apprentice learning methodology are proprietary educational innovations.</p>
<p>Character concept, teaching methodology, and all written content created by Prof. Cynthia Teeters. Visual elements created with AI assistance.</p>
```

**HTML comment (end of file):**
```html
<!--
HAP™ Educational Content © 2025 Cynthia Teeters. All rights reserved.
HyBit A. ProtoBot™ (HAP™) character and the apprentice learning methodology are proprietary educational innovations.
Character concept, teaching methodology, and all written content created by Prof. Cynthia Teeters.
Visual elements created with AI assistance.
-->
```

### Trademark usage

**Always use proper marks:**
- HAP™ (with trademark symbol)
- HyBit A. ProtoBot™ (with trademark symbol)
- Prof. Cynthia Teeters (no special marks)

## Code comments

### HTML comments

**Section markers:**
```html
<!-- Header with HyBit -->
<header>...</header>

<!-- Main Content Container -->
<main>...</main>

<!-- Performance Easter Egg -->
<script src="js/easter-egg.js"></script>
```

**Template markers (for 11ty):**
```html
<!-- EXTRACT THIS → header.njk -->
<header>...</header>
```

### CSS comments

**Section headers:**
```css
/* ==========================================================================
   Header with HyBit
   ========================================================================== */

.header {
    /* styles */
}
```

**Inline explanations:**
```css
/* WCAG AA accessible darker variants for text on cream background */
--teal-darker: #3A7A70;  /* 4.5:1 contrast ratio - for normal text */
```

### JavaScript comments

**Function documentation:**
```javascript
/**
 * Loads and parses JSONC file for easter egg insights
 * @returns {Object} Parsed insights data
 */
async function loadInsights() {
    // Implementation
}
```

**Inline comments:**
```javascript
// Strip JSONC comments before parsing
const cleanJson = json.replace(/\/\/.*$/gm, '');
```

## Git commit standards

### Commit message format

**Structure:**
```
<type>: <subject>

<body>

<footer>
```

**Types:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation only
- `style:` - Code style (formatting, no logic change)
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

**Examples:**
```
feat: Add container queries station

Implement Station 6 with container query examples and HAP's voice
content explaining component-based responsive design.

Closes #42
```

```
fix: Correct easter egg parameter validation

Fix whitelist check to properly validate 'svg' parameter.
Previously returned unknown message incorrectly.
```

## Browser compatibility

### Minimum supported browsers

**Required support:**
- Chrome 90+
- Firefox 90+
- Safari 15.4+
- Edge 90+

**Coverage:** 95%+ of users

### Feature requirements

**Modern features in use:**
- Native `<dialog>` element
- CSS custom properties
- CSS Grid
- Flexbox
- Fetch API
- URLSearchParams

**No polyfills required** for target browsers

## Validation requirements

### Before any commit

- [ ] HTML validates (W3C validator)
- [ ] CSS validates (no critical errors)
- [ ] JavaScript has no console errors
- [ ] All links work (no 404s)
- [ ] All images load (check Network tab)
- [ ] Lighthouse scores ≥ baseline
- [ ] Accessibility: 0 WCAG violations
- [ ] HAP's voice authentic (review content)

### Before any deployment

- [ ] Full test suite passes
- [ ] Visual regression tests pass
- [ ] Cross-browser testing complete
- [ ] Performance budget met
- [ ] Legal text present and correct

## Quality checklist

### For every new lab/station

- [ ] Uses base layout template
- [ ] HAP's apprentice voice throughout
- [ ] Prof. Teeters credited appropriately
- [ ] Semantic HTML structure
- [ ] Accessibility features complete
- [ ] Images optimized via Cloudinary
- [ ] Easter egg parameter added (if applicable)
- [ ] Lighthouse scores ≥99/100/100/100
- [ ] Legal notices present
- [ ] Documentation updated

## Reference materials

**Phase 1 reports:** `reports/phase1/`
- `architecture-audit.md` - Patterns and structure
- `hap-voice-guide.md` - Voice and tone
- `component-inventory.md` - Reusable components
- `component-mapping.md` - Template mapping
- `quality-criteria.md` - Validation standards
- `data-extraction.md` - Centralized data

**Additional docs:**
- `README.md` - Project overview
- `CLAUDE.md` - Claude Code instructions
- `TRADEMARK.md` - Trademark usage
- `CONTENT-LICENSE.md` - Content licensing

## Updates to this guide

**Process:**
1. Propose change in GitHub issue
2. Discuss with team
3. Update style guide
4. Apply to all existing labs
5. Document in CHANGELOG.md

**Version history:**

- v1.4 (2025-10-13): Phase 4 - Content patterns and optional tooling (COMPLETE)
  - Documented common content patterns (station intro, real metrics, before/after, "what I learned")
  - Added code snippet patterns with copy buttons
  - Documented HAP callout variations (tip, warning, success)
  - Added overview section and demo scaffolding patterns
  - Documented image attribution standards (Unsplash, Cloudinary)
  - Added Lighthouse CI optional automated testing section
  - Documented typography-specific patterns (font specimens, type scales, font pairing)
  - Documented image-specific patterns (device frames, format tables, resolution demos, art direction)
- v1.3 (2025-10-13): Phase 3 - Interactive demo patterns and utilities
  - Documented interactive demo container pattern with HTML/CSS structure
  - Added slider controls with full CSS and JavaScript implementation
  - Added color picker controls with hex input synchronization
  - Added copy button implementation with clipboard API
  - Documented preview box patterns for text and color contrast demos
  - Completed utility classes reference (spacing, typography, color, layout)
  - Added utility usage guidelines and examples
- v1.2 (2025-10-13): Phase 2 - CSS components library
  - Documented HAP note callout component with HTML/CSS/responsive behavior
  - Documented insight card component with grid layout patterns
  - Documented analysis grid component for structured content
  - Documented HAP info grid component for detailed explanations
  - Documented navigation patterns (top-nav and bottom-nav)
  - Documented footer pattern with copyright layout
  - Added component usage guidelines table
  - Added component combination patterns and spacing rules
- v1.1 (2025-10-13): Phase 1 - Critical production alignment
  - Fixed heading capitalization (HTML title case, markdown sentence case)
  - Expanded emoji guidelines (approved list, banned emojis, visibility rules)
  - Documented official breakpoints (480px, 768px, 769px)
  - Added Prism.js syntax highlighting documentation
  - Expanded color palette with all WCAG variants and usage guidelines
- v1.0 (2025-10-06): Initial version from baseline v1.0-baseline
