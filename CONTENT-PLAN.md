# Content plan for HAP's Color Learning Lab

This file helps you organize your learning lab content before customization. Fill in all sections below, then use this as a reference when working with Claude Code to customize your learning lab.

## Learning lab overview

### Theme

**Your learning lab theme**:

```
Web Colors: From Hex Chaos to Color Confidence
```

### Brief description

**One sentence describing what students will learn**:

```
Join HAP's journey from messy hex codes to mastering color systems, accessibility, harmony, and modern CSS color features through hands-on interactive demos and relatable mistakes.
```

### Topics covered

**List the main topics** (this appears on the hub page):

```
Color formats beyond hex, building reusable color systems with CSS custom properties, color harmony and meaning, accessibility and contrast ratios, modern CSS color features, and AI assistance for color design
```

### Target audience

**Who is this learning lab for?**

```
Beginning web development students who currently only use hex codes and need to learn proper color implementation, accessibility standards, and systematic approaches to color in CSS
```

### Learning objectives

**What will students be able to do after completing this learning lab?**

1. Convert between hex, RGB, and HSL formats and know when to use each
2. Build organized color systems using CSS custom properties instead of scattered hex codes
3. Create harmonious color combinations using basic color theory principles
4. Ensure WCAG compliance with proper contrast ratios and testing tools
5. Implement modern CSS features like gradients, color-mix(), and automatic dark mode
6. Use AI effectively to generate palettes and check accessibility

---

## Station 1: Beyond Hex - Color Formats on the Web

### Station title

```
Beyond Hex - Color Formats on the Web
```

### Subtitle

```
Understanding different ways to write colors and why they matter
```

### HAP's introduction

```
I used to think hex codes were the ONLY way to write colors. I'd seen rgb() in other people's code, but I just converted everything back to hex because that's all I knew! Sometimes I'd use 'red' or 'blue' because it was easier than looking up hex codes, but then I'd wonder why 'darkgray' was actually lighter than 'gray'. So confusing! Let me show you what Prof. Teeters taught me about color formats - it changed everything!
```

### HAP's specific struggles

```
- Mixed #fff, #FFF, and #ffffff for the same color
- Didn't understand why rgb() existed when we had hex
- Confused by 'darkgray' being lighter than 'gray'
- Copy-pasted hex codes without understanding them
- Never knew about transparency options
```

### Key insights (3 cards)

**Insight 1:**

- Title: Why hex isn't enough
- Content: Hex is great for copying from design tools, but terrible for modifications
- HAP's take: I couldn't make colors lighter/darker with hex - had to guess new codes!

**Insight 2:**

- Title: RGB makes sense for screens
- Content: It's literally Red, Green, Blue light amounts (0-255)
- HAP's take: Once Prof. Teeters explained screens emit light, RGB clicked!

**Insight 3:**

- Title: HSL is the game-changer
- Content: Hue, Saturation, Lightness - adjust colors like a human thinks
- HAP's take: Make it darker? Just lower the L value! Why didn't anyone tell me sooner?

### Main content sections

**Section 1: HAP's Hex Chaos**

```
My old CSS files were a disaster of hex codes. I had #336699, #3366cc, #369, and #3366CC scattered everywhere - some were the same color, some weren't, and I couldn't tell which was which! Prof. Teeters showed me my first problem: I didn't even know that #RGB was shorthand for #RRGGBB. So #369 actually meant #336699! Mind. Blown. 🤯
```

**Section 2: The RGB Revelation**

```
RGB made no sense until Prof. Teeters explained it's based on how screens work - mixing red, green, and blue light. Each value (0-255) is how bright that color channel is. rgb(255, 0, 0) = full red, no green, no blue = pure red! And rgba() adds transparency without affecting child elements like opacity does. Game changer for overlays!
```

**Section 3: HSL Changed Everything**

```
This is where everything clicked! HSL is how humans think about color. Hue is the color wheel position (0-360°), Saturation is how vivid (0-100%), and Lightness is... well, lightness (0-100%). Want a darker version? Keep H and S, just lower L! Prof. Teeters said "HSL is like having a color remote control" and she was SO right!
```

### Interactive demos

1. **Color Format Converter**: Input any format, see all conversions instantly
2. **"Same Color, Different Formats" Demo**: Shows how #369, #336699, rgb(51, 102, 153), and hsl(210, 50%, 40%) are identical
3. **Transparency Playground**: Compare rgba() vs opacity with interactive sliders

### Code examples

```css
/* HAP's Old Way (Hex Chaos) */
.header { background: #336699; }
.button { background: #369; /* Wait, is this the same? */ }
.footer { background: #3366CC; /* Or is THIS the same? */ }
.link { color: darkblue; /* Close enough? */ }

/* What I Learned */
:root {
  --brand-blue: hsl(210, 50%, 40%);
  --brand-blue-dark: hsl(210, 50%, 30%); /* Just changed L! */
  --brand-blue-light: hsl(210, 50%, 50%); /* So easy! */
}
```

### Resources

- MDN Color Values: <https://developer.mozilla.org/en-US/docs/Web/CSS/color_value>
- Color format converter tool
- Browser DevTools color picker guide

---

## Station 2: Building Color Systems

### Station title

```
Building Color Systems
```

### Subtitle

```
Creating organized, reusable color palettes
```

### HAP's introduction

```
My old stylesheets were basically hex code soup. I'd have #3366cc in my header, #3367cc in my footer (yes, they're different!), and couldn't remember which was which. Copy-paste was my strategy - find a color I used before, copy it, hope it was the right shade! Then Prof. Teeters introduced me to CSS custom properties and systematic color naming. Now I change colors in ONE place! Let me show you this sanity-saving system!
```

### HAP's specific struggles

```
- Same color written 5 different ways
- 47 different shades of blue (not joking!)
- Copy-paste archaeology to find colors
- No naming system ("blue-3" everywhere)
- Changed mind about a color = find/replace nightmare
```

### Key insights (3 cards)

**Insight 1:**

- Title: custom properties save sanity
- Content: Define once, use everywhere, change in one place
- HAP's take: I went from 50 hex codes to 8 custom properties. EIGHT!

**Insight 2:**

- Title: Semantic naming
- Content: --primary-color beats --blue-500 every time
- HAP's take: When the "blue" became purple, I didn't have to rename everything!

**Insight 3:**

- Title: The 60-30-10 rule
- Content: 60% dominant, 30% secondary, 10% accent
- HAP's take: This formula instantly made my sites look professional!

### Main content sections

**Section 1: The Hex Soup Problem**

```
Prof. Teeters asked me to count my colors once. I had 73 different color values in one CSS file! Many were almost identical (#3366cc vs #3366cb). Some were the same color written differently (#fff, white, #FFFFFF). I was drowning in hex codes with no system, no organization, just chaos.
```

**Section 2: CSS Custom Properties Revolution**

```
Then she showed me CSS custom properties (custom properties). Instead of #3366cc everywhere, I now had --brand-primary. Want to change it? Update ONE line! But the real magic was creating a system: --gray-100 through --gray-900 for consistent grays. It's like having a design system built into your CSS!
```

**Section 3: Semantic Color Names**

```
The final piece was semantic naming. Instead of --blue or --red, Prof. Teeters taught me to use --primary, --secondary, --success, --warning, --error. Why? Because when the client says "make the blue purple," you just change --primary and you're done. No lying custom property names!
```

### Interactive demos

1. **Palette Builder Tool**: Start with one color, generate tints and shades
2. **"HAP's Hex Chaos Refactor"**: Interactive refactoring showing 50 colors becoming 8 custom properties
3. **60-30-10 Rule Visualizer**: Adjust percentages and see the visual impact

### Code examples

```css
/* HAP's Old Way (Hex Soup - 50+ colors!) */
.header { background: #3366cc; color: hsl(0, 0%, 100%) ; }
.nav { background: #3367cc; color: #ffffff; }
.button { background: #3366CC; color: #FFF; }
.card { border: 1px solid #3366cd; }
/* ... and 46 more slight variations ... */

/* What I Learned (8 custom properties!) */
:root {
  --primary: hsl(210, 50%, 50%);
  --primary-dark: hsl(210, 50%, 40%);
  --primary-light: hsl(210, 50%, 60%);
  --text-on-primary: hsl(0, 0%, 100%);
  --gray-100: hsl(0, 0%, 95%);
  --gray-500: hsl(0, 0%, 50%);
  --gray-900: hsl(0, 0%, 10%);
  --background: var(--gray-100);
}
```

### Resources

- CSS Custom Properties guide
- Design token best practices
- Color system generators

---

## Station 3: Color Harmony & Meaning

### Station title

```
Color Harmony & Meaning
```

### Subtitle

```
Making colors that work well together
```

### HAP's introduction

```
Picking colors? I used to just guess! I'd think 'this green looks nice' (#00ff00) and 'this red works' (#ff0000), then wonder why they looked so harsh together. Prof. Teeters called it 'skittles syndrome' - my sites looked like a bag of candy exploded! Then she taught me about the color wheel and basic harmony rules. Suddenly, professional color combinations weren't magic anymore - they were math!
```

### HAP's specific struggles

```
- Used pure red (#ff0000) with pure green (#00ff00)
- "Skittles syndrome" - every color was max brightness
- No understanding of color temperature
- Picked colors randomly with no relationship
- Didn't know why some colors clashed
```

### Key insights (3 cards)

**Insight 1:**

- Title: The color wheel works
- Content: Relationships on the wheel = harmony in design
- HAP's take: Complementary colors are just 180° apart in HSL. It's literally math!

**Insight 2:**

- Title: Temperature matters
- Content: Warm colors advance, cool colors recede
- HAP's take: I was mixing warm and cool randomly - no wonder it looked chaotic!

**Insight 3:**

- Title: Less is more
- Content: 2-3 colors maximum for beginners
- HAP's take: I was using 10+ colors! Restraint made everything better!

### Main content sections

**Section 1: The Skittles Syndrome**

```
My first website was... colorful. Pure red buttons, electric blue headers, neon green highlights. Prof. Teeters gently said it looked like "a bag of skittles exploded." She was right! I was using colors at maximum saturation with no relationship to each other. Every element screamed for attention!
```

**Section 2: Color Wheel Relationships**

```
Prof. Teeters drew a simple color wheel and my mind exploded. Complementary colors (opposites) create energy! Analogous colors (neighbors) feel calm! Triadic colors (triangle) stay balanced! In HSL, it's just math: complementary = add 180° to hue. I could finally create harmonious palettes on purpose, not by accident!
```

**Section 3: Meaning and Psychology**

```
Then came the psychology lesson. Red doesn't just mean "stop" - it triggers urgency, passion, energy. Blue creates trust and calm. Green suggests growth and money. Prof. Teeters showed me how banks use blue (trust), restaurants use red/orange (appetite), and eco-brands use green (nature). My random color choices were sending mixed messages!
```

### Interactive demos

1. **Color Wheel Relationships**: Click a color, see its complementary, analogous, and triadic matches
2. **"Fix HAP's Clashing Colors"**: Interactive game fixing bad color combinations
3. **Mood Board Generator**: Select a mood, get appropriate color suggestions

### Code examples

```css
/* HAP's Old Way (Skittles Syndrome) */
.header { background: #ff0000; }     /* PURE RED! */
.button { background: #00ff00; }     /* NEON GREEN! */
.sidebar { background: #0000ff; }    /* ELECTRIC BLUE! */
.alert { background: #ffff00; }      /* BLAZING YELLOW! */
/* My eyes! The goggles do nothing! */

/* What I Learned (Harmonious Palette) */
:root {
  /* Analogous harmony: blue family */
  --primary: hsl(210, 70%, 50%);      /* Blue */
  --secondary: hsl(190, 60%, 45%);    /* Blue-green */
  --accent: hsl(230, 65%, 55%);       /* Blue-purple */

  /* Neutrals for balance */
  --text: hsl(0, 0%, 20%);
  --background: hsl(0, 0%, 98%);
}
```

### Resources

- Adobe Color wheel tool
- Color psychology in web design
- Coolors.co palette generator

---

## Station 4: Accessibility & Contrast

### Station title

```
Accessibility & Contrast
```

### Subtitle

```
Making sure everyone can read your content
```

### HAP's introduction

```
I thought if I could read it, everyone could. I'd use light gray text (#cccccc) on white backgrounds because it looked 'modern.' Then Prof. Teeters had me try reading my own site with sunlight on my screen... invisible! She taught me about the 4.5:1 contrast ratio and showed me that 1 in 12 men have some form of color blindness. Now I test everything! Let me show you how to make colors work for everyone.
```

### HAP's specific struggles

```
- Light gray on white looked "modern" but was unreadable
- Never heard of contrast ratios
- Didn't know color blindness was so common
- Used color as the only indicator (red = error, green = success)
- Never tested with accessibility tools
```

### Key insights (3 cards)

**Insight 1:**

- Title: The 4.5:1 rule
- Content: Minimum contrast ratio for normal text per WCAG
- HAP's take: My "modern" gray text had 2:1 ratio. No wonder people complained!

**Insight 2:**

- Title: Color blindness is common
- Content: Affects 1 in 12 men, 1 in 200 women
- HAP's take: 8% of my users couldn't see my red/green indicators!

**Insight 3:**

- Title: Never rely on color alone
- Content: Always pair with icons, text, or patterns
- HAP's take: Now my errors have ✕ icons too, not just red color!

### Main content sections

**Section 1: The Invisible Text Disaster**

```
My "modern, minimal" design had light gray text (#cccccc) on white. Contrast ratio? 1.6:1! Prof. Teeters showed me the WCAG guidelines: 4.5:1 for normal text, 3:1 for large text. She had me test my site on different screens, in bright light, with reduced vision simulators. It was unreadable! What I thought was elegant was actually inaccessible.
```

**Section 2: Color Blindness Reality Check**

```
Then came the color blindness bombshell. Prof. Teeters showed me my site through simulators. My red error messages on green success backgrounds? Completely invisible to red-green colorblind users! That's 8% of men! I was literally excluding millions of people with my color choices.
```

**Section 3: Testing and Fixing**

```
Prof. Teeters taught me to use Chrome DevTools' contrast checker, WebAIM's tool, and color blindness simulators. But the best lesson? "Never use color as the only indicator." Now my errors have icons AND color. My links are underlined AND colored. Everyone gets the message, regardless of how they see color!
```

### Interactive demos

1. **Contrast Checker Tool**: Input colors, see WCAG pass/fail instantly
2. **Color Blindness Simulator**: See your colors through different types of color blindness
3. **"Color Alone" Bad Examples**: Interactive fixes for color-only indicators

### Code examples

```css
/* HAP's Old Way (Inaccessible) */
.text { color: #cccccc; }           /* 1.6:1 on white - FAIL! */
.error { color: red; }               /* Only color indicator */
.success { color: green; }           /* Invisible to colorblind */
.link { color: #7799bb; }            /* 3.2:1 - FAIL! */

/* What I Learned (Accessible) */
:root {
  --text: hsl(0, 0%, 20%);          /* 13:1 on white - PASS! */
  --text-muted: hsl(0, 0%, 35%);    /* 7.5:1 - Still passes! */
  --error: hsl(0, 65%, 45%);        /* 5.4:1 - PASS! */
  --success: hsl(120, 40%, 35%);    /* 5.9:1 - PASS! */
}

.error::before { content: "✕ "; }   /* Icon + color */
.success::before { content: "✓ "; } /* Never color alone! */
```

### Resources

- WebAIM Contrast Checker
- WCAG color guidelines
- Color blindness simulators

---

## Station 5: Modern CSS Color Features

### Station title

```
Modern CSS Color Features
```

### Subtitle

```
Cool new things you can do with color in CSS
```

### HAP's introduction

```
When Prof. Teeters showed me gradients, my mind exploded! I thought gradients were image files, but CSS can create them with code! Then she showed me CSS filters, color-mix(), and automatic dark mode with prefers-color-scheme. These aren't future features - they work TODAY! Let me show you the color magic that's available right now in modern browsers!
```

### HAP's specific struggles

```
- Thought gradients were only possible with images
- Didn't know CSS could blend colors
- Manual dark mode with duplicate styles
- No idea about CSS filters
- Missing out on modern features that work today
```

### Key insights (3 cards)

**Insight 1:**

- Title: Gradients are just CSS
- Content: No images needed, infinite variations possible
- HAP's take: One line of CSS replaced my 20KB gradient image!

**Insight 2:**

- Title: color-mix() is magic
- Content: Blend colors like paint, right in CSS
- HAP's take: Perfect hover states without guessing hex codes!

**Insight 3:**

- Title: Automatic dark mode
- Content: prefers-color-scheme adapts to user preference
- HAP's take: No JavaScript, no toggle button - it just works!

### Main content sections

**Section 1: Gradient Revolution**

```
I was downloading gradient images from generators - header-gradient.png, button-gradient.jpg. Prof. Teeters showed me linear-gradient() and my jaw dropped. One line of CSS! No HTTP request! Infinite customization! Then radial-gradient() for spotlights, conic-gradient() for pie charts. File sizes went from 20KB images to 100 bytes of CSS!
```

**Section 2: Filters and Blend Modes**

```
CSS filters blew my mind! hue-rotate() changes colors dynamically, brightness() for hover states, contrast() for accessibility adjustments. Prof. Teeters showed me backdrop-filter for glassmorphism effects. No Photoshop needed! And mix-blend-mode makes colors interact like real paint!
```

**Section 3: color-mix() and Dark Mode**

```
The game-changer was color-mix(). Instead of guessing hover colors, I use color-mix(in srgb, var(--primary) 80%, white) for perfect lightening! And prefers-color-scheme automatically switches to dark mode based on system settings. No JavaScript, no cookies, just CSS magic that respects user preferences!
```

### Interactive demos

1. **Gradient Builder**: Visual tool creating linear, radial, and conic gradients
2. **Filter Effects Playground**: Apply and combine CSS filters in real-time
3. **Dark Mode Toggle Demo**: Automatic theme switching with CSS only

### Code examples

```css
/* HAP's Old Way (So Much Work!) */
.header {
  background-image: url('gradient.png'); /* 20KB image */
}
.button:hover {
  background: #4477aa; /* Guessed a lighter blue */
}
/* Dark mode? That's a whole separate stylesheet! */

/* What I Learned (CSS Magic!) */
.header {
  background: linear-gradient(135deg, var(--primary), var(--secondary));
}
.button:hover {
  background: color-mix(in srgb, var(--primary) 80%, white);
}

@media (prefers-color-scheme: dark) {
  :root {
    --background: hsl(0, 0%, 10%);
    --text: hsl(0, 0%, 90%);
    /* Automatic dark mode! */
  }
}
```

### Resources

- CSS Gradient generators
- MDN Filter effects guide
- color-mix() browser support

---

## Station 6: AI Assistance for Color Design

### Station title

```
AI Assistance for Color Design
```

### Subtitle

```
Using AI to speed up your color workflow
```

### HAP's introduction

```
Prof. Teeters said AI is like having a color consultant on speed dial! At first, my prompts were disasters - "make it pretty" got me random rainbows. She taught me to write specific prompts, verify accessibility claims, and use AI for inspiration, not final answers. The day I learned to say "create a color palette for a financial app, serious but approachable, must pass WCAG AA" - everything changed! Let me share what works!
```

### HAP's specific struggles

```
- Vague prompts like "nice colors please"
- Trusted AI accessibility claims without checking
- Copy-pasted AI palettes without understanding them
- Didn't know how to iterate on AI suggestions
- Expected AI to read my mind
```

### Key insights (3 cards)

**Insight 1:**

- Title: Specific prompts win
- Content: Details about mood, use case, and requirements
- HAP's take: "Professional palette" got meh results. "Law firm, trustworthy, navy-based" got gold!

**Insight 2:**

- Title: Always verify claims
- Content: AI might say colors are accessible when they're not
- HAP's take: AI said my colors passed WCAG. They didn't. Always double-check!

**Insight 3:**

- Title: AI for ideas, not answers
- Content: Use AI as starting point, then refine
- HAP's take: AI suggests, I decide. It's my assistant, not my designer!

### Main content sections

**Section 1: Learning to Prompt**

```
My first AI color prompts were embarrassing. "Give me good colors" got me a rainbow. "Make it pop" got neon everything. Prof. Teeters taught me the formula: context + mood + constraints. "E-commerce site for outdoor gear, earthy and trustworthy, need 5 colors including success/error states, must pass WCAG AA" - NOW we're talking!
```

**Section 2: The Verification Habit**

```
AI told me my pale yellow text on white was "perfectly accessible." Prof. Teeters had me check - 1.9:1 ratio, massive fail! She taught me AI is great for suggestions but terrible at math. Now I use AI to generate palettes, then manually verify every contrast ratio. Trust, but verify!
```

**Section 3: AI as Assistant, Not Designer**

```
The breakthrough was treating AI as my assistant, not my designer. I describe the brand personality, AI suggests palettes. I pick one, AI creates variations. Something feels off? I ask for specific adjustments. It's a conversation, not a one-shot answer. And I always make the final decision - AI doesn't know my users like I do!
```

### Interactive demos

1. **Palette Prompt Tester**: See how different prompts affect AI palette suggestions
2. **AI Accessibility Fixer**: Input failing colors, get AI-suggested accessible alternatives
3. **"Human vs AI" Palette Challenge**: Guess which palettes are AI-generated

### Code examples

```css
/* HAP's Bad AI Prompt Result */
/* Prompt: "nice website colors" */
:root {
  --color1: #ff6b6b;  /* Random red? */
  --color2: #4ecdc4;  /* Random teal? */
  --color3: #45b7d1;  /* Another blue? */
  --color4: #96e6a1;  /* Random green? */
  /* No system, no purpose, just... colors */
}

/* Good AI Prompt Result */
/* Prompt: "SaaS dashboard, professional, blue-based,
   need primary/secondary/success/warning/error,
   must pass WCAG AA, include hover states" */
:root {
  --primary: hsl(211, 100%, 50%);
  --primary-hover: hsl(211, 100%, 40%);
  --secondary: hsl(211, 25%, 50%);
  --success: hsl(134, 61%, 41%);
  --warning: hsl(45, 100%, 51%);
  --error: hsl(0, 65%, 51%);
  /* Systematic, purposeful, accessible! */
}
```

### Resources

- Effective prompts for color palettes
- AI color tools comparison
- Verification workflow guide

---

## Easter egg customization

### Page-specific help messages

**Hub page help:**

```
Welcome to my color journey! I started with hex chaos and now I actually understand color systems! Try ?hybit=journey to see my complete transformation story!
```

**Station 1 help:**

```
This is where I learned there's more than hex! Try ?hybit=formats to see my quick conversion cheat sheet!
```

**Station 2 help:**

```
CSS custom properties saved my sanity! Check out ?hybit=custom properties to see how I went from 73 colors to 8!
```

**Station 3 help:**

```
Color harmony isn't magic, it's math! Try ?hybit=wheel to see the relationships I use every day!
```

**Station 4 help:**

```
Accessibility matters to millions! Use ?hybit=contrast for my quick reference guide!
```

**Station 5 help:**

```
Modern CSS is amazing! Try ?hybit=gradients to see my favorite gradient techniques!
```

**Station 6 help:**

```
AI helps, but verify everything! Check ?hybit=prompts for my prompt templates!
```

### Custom insight messages

**Custom insight 1:**

- Parameter: journey
- Title: 🎨 HAP's Color Evolution
- Content: Started: 73 different hex codes, no system, copy-paste chaos. Now: 8 CSS custom properties, semantic naming, accessible contrasts, systematic scales. The journey from #bada55 jokes to professional color systems was wild but SO worth it!

**Custom insight 2:**

- Parameter: custom properties
- Title: 🔄 From Chaos to Order
- Content: My transformation: 73 hex values → 8 CSS custom properties. Secret? Start with --primary, --secondary, --text, --background. Generate shades systematically. Use semantic names. Change once, update everywhere. Prof. Teeters called it "the sanity saver"!

**Custom insight 3:**

- Parameter: wheel
- Title: 🎡 Color Wheel Magic
- Content: Complementary = hue + 180°. Analogous = hue ± 30°. Triadic = hue + 120° and hue + 240°. Split-complementary = hue + 150° and hue + 210°. It's literally just math with HSL! No more guessing!

---

## Station implementation workflow

### Step 1: Content draft (markdown)

**Request format**:

```
Draft Station [N] content in markdown using CONTENT-PLAN.md
```

**Claude creates**: `reports/station-[N]-draft.md` containing:

- All section content written in HAP's voice
- Code examples (Old Way vs What I Learned)
- Component suggestions (which HAP components to use where)
- Interactive demo descriptions
- Any questions or clarifications needed

**Draft should include**:

- Header introduction (HAP's first-person narrative)
- All main content sections
- Code examples with comments
- Educational notes and tips
- Accessibility reminders
- Navigation text

### Step 2: Content review and approval

**You review the markdown draft and provide**:

- Approval: "Looks good, implement it"
- Specific changes: "Change [section] to say [this]"
- Major revision: "Revise the draft with these changes..."

**Do not proceed to HTML until content is approved!**

### Step 3: HTML implementation

**Request format** (after approval):

```
Implement Station [N] using the approved draft
```

**Claude will**:

- Read the approved draft from `reports/station-[N]-draft.md`
- Implement in `stations/station[N].html`
- Apply all best practices (accessibility, components, voice)
- Test locally if you provide server info
- Report completion

### Step 4: Technical testing and refinement

- Test on live-server
- Run Lighthouse audits
- Check accessibility
- Request specific fixes if needed

---

## Best practices from Station 3 implementation

### Accessibility requirements

**ARIA and screen readers**:

- Include `aria-live="polite"` regions for dynamic announcements (copy buttons, form feedback)
- Use `.sr-only` class for visually hidden screen reader content
- Add descriptive `aria-label` attributes to interactive elements
- Place aria-live regions near relevant interactive elements

**HAP image alt text**:

- ALWAYS start with "Illustration of HAP" to clarify it's not a photograph
- Be descriptive about HAP's activity or expression
- Examples:
  - ✅ "Illustration of HAP looking confused while studying"
  - ✅ "Illustration of HAP studying on his laptop"
  - ❌ "HAP looking confused" (missing "Illustration of" prefix)

**WCAG contrast standards**:

- Always include specific ratios: "≥ 4.5:1 for body text (≥ 3:1 for large text)"
- Add warning boxes when discussing color choices that could fail contrast
- Remind students to recheck contrast when modifying colors
- Place accessibility reminders contextually near relevant code examples

### Component usage patterns

**Warning boxes** (`.warning-box`):

- Use for critical accessibility reminders
- Place immediately after code examples that could go wrong
- Include specific guidance on what to check
- Example: Contrast ratio warnings when swapping color temperatures

**HAP note callouts** (`.hap-note-callout`):

- For HAP's personal tips and insights
- Keep them conversational and first-person
- Reference Prof. Teeters or HAP's mistakes
- Place near related content sections

**Code examples**:

- Always structure as "Old Way" vs "What I Learned"
- Include helpful CSS comments explaining the logic
- Add educational notes after code blocks (using `.code-comment`)
- Show the math behind calculations (hue + 180° for complementary)
- Include modulo wrap explanations where relevant

**Interactive elements**:

- Copy buttons with screen reader announcements
- Clear aria-labels for demo links
- Descriptive button text ("Copy" → "Copied" transition)
- Error handling with screen reader feedback

### Code structure standards

**CSS code examples**:

```css
/* HAP's Old Way (Descriptive Problem) */
/* Show actual problematic code */
/* Include comments about what's wrong */

/* What I Learned (Solution) */
/* Show improved code */
/* Include helpful comments explaining why it works */
```

**Educational comments**:

- Use `<p class="code-comment">` after code blocks
- Explain the "why" not just the "what"
- Reference HAP's learning moments
- Include mathematical explanations where applicable

### HAP's voice consistency

**First-person narrative**:

- "I used to..." not "You might..."
- "Prof. Teeters taught me..." not "Experts recommend..."
- "This was confusing for me too!" not "This is confusing!"

**Specific struggles**:

- Reference actual mistakes from CONTENT-PLAN.md
- Show vulnerability and learning
- Make it relatable to student experience

**Enthusiasm balanced with humility**:

- Excited about discoveries but acknowledges difficulty
- Credits Prof. Teeters for teaching
- Shares "aha moments" genuinely

### Navigation standards

**Top navigation** (`.page-navigation`):

- Previous station link (left)
- Station title and number (center)
- Next station link (right)
- Use semantic markup with `<nav>` element

**Bottom navigation**:

- Clear "Next up" indicator
- Link to next station with descriptive text
- Encouraging message from HAP
- Always include footer with copyright

### Image optimization

**HAP images**:

- Use Cloudinary CDN with optimization parameters
- Header avatar: `fetchpriority="high"` (LCP image)
- Below-fold images: `loading="lazy"`
- Always include explicit `width` and `height`
- Use `decoding="async"` for better performance

**Alt text formula**:

```html
<img src="[cloudinary-url]"
     alt="Illustration of HAP [doing activity/showing emotion]"
     width="[width]"
     height="[height]"
     fetchpriority="high" OR loading="lazy"
     decoding="async">
```

### Technical review checklist

Before considering a station complete:

- [ ] All HAP images use "Illustration of HAP" alt text prefix
- [ ] ARIA live regions included for dynamic content
- [ ] WCAG contrast ratios specified with exact numbers (4.5:1, 3:1)
- [ ] Warning boxes placed near code that could fail accessibility
- [ ] Code examples follow "Old Way" vs "What I Learned" structure
- [ ] Educational comments explain the math/logic
- [ ] Top and bottom navigation work correctly
- [ ] All interactive elements have proper aria-labels
- [ ] Copy buttons provide screen reader feedback
- [ ] HAP's voice is first-person throughout
- [ ] Specific struggles from CONTENT-PLAN.md are referenced
- [ ] Images optimized with correct loading strategy
- [ ] Test locally with live-server before review
- [ ] Run Lighthouse audit (target: 99+ performance, 100 accessibility)

---

## Checklist before starting customization

- [x] All 6 station titles match design document
- [x] HAP's hex chaos journey is consistent
- [x] Learning objectives align with student problems
- [x] Interactive demos specified for each station
- [x] Code shows "Old Way" vs "What I Learned"
- [x] Easter eggs reference HAP's specific mistakes
- [x] Resources are practical and current
- [x] Voice maintains HAP's enthusiasm and humility
- [x] Best practices documented from Station 3 implementation

**Ready to build with Claude Code using this plan and the design rules from hap-design.md!**
