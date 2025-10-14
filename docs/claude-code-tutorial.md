# Using Claude Code to customize your HAP Learning Lab

This tutorial shows how to use Claude Code as your AI assistant to transform this template into a complete, customized learning lab. Claude Code will handle the majority of the technical work while you provide the educational content and creative direction.

## Prerequisites

- Claude Code installed and configured
- This HAP template repository cloned locally
- Your learning lab topic defined (6 stations planned)
- Educational content prepared (or ready to develop with Claude)

## Philosophy: AI as your technical assistant

This tutorial embraces AI-enhanced development where:

- **You provide**: Educational vision, content expertise, learning objectives
- **Claude Code handles**: File editing, placeholder replacement, consistency checks, testing
- **Result**: You focus on teaching, Claude handles the technical implementation

## Step 1: Project setup and planning

### Define your learning lab

Before starting customization, prepare a brief document describing your 6 stations. This helps Claude Code understand your vision.

**Example planning document:**

```markdown
# My Learning Lab: Modern CSS Layout

## Theme
Advanced CSS layout techniques for responsive web design

## Stations
1. Flexbox fundamentals - Building flexible layouts
2. Grid systems - Two-dimensional layout control
3. Subgrid - Nested grid alignment
4. Container queries - Component-aware design
5. Logical properties - Internationalization-friendly CSS
6. Modern spacing - Gap, aspect-ratio, and new units

## Target audience
Intermediate web developers who know basic CSS
```

### Copy template to new project

```bash
# Copy template to new project directory
cp -r hap-template/ my-css-layout-lab/
cd my-css-layout-lab/

# Initialize git (optional but recommended)
git init
git add .
git commit -m "Initial commit from HAP template"
```

## Step 2: Launch Claude Code and provide context

### Open project in Claude Code

```bash
# From your new project directory
claude-code .
```

### Give Claude Code your planning document

**Prompt example:**

```
I'm using the HAP Learning Lab template to create an educational website
about modern CSS layout techniques. I have 6 stations planned:

1. Flexbox fundamentals
2. Grid systems
3. Subgrid
4. Container queries
5. Logical properties
6. Modern spacing

I want you to help me customize this template by replacing all placeholders
with content specific to my CSS layout theme. Let's start by updating the
index.html hub page.
```

## Step 3: Customize the hub page (index.html)

### Strategy: Systematic placeholder replacement

Claude Code excels at systematic find-and-replace operations across files.

**Prompt:**

```
Please update index.html with my CSS layout theme:

1. Replace "[YOUR THEME]" with "Modern CSS Layout"
2. Replace "[YOUR TOPICS]" with "flexbox, grid, subgrid, container queries,
   logical properties, and modern spacing techniques"
3. Update all 6 station cards with:
   - Station 1: Flexbox Fundamentals - Building flexible layouts
   - Station 2: Grid Systems - Two-dimensional layout control
   - Station 3: Subgrid - Nested grid alignment
   - Station 4: Container Queries - Component-aware design
   - Station 5: Logical Properties - Internationalization-friendly CSS
   - Station 6: Modern Spacing - Gap, aspect-ratio, and new units
4. Update HAP's intro text to reference learning CSS layout techniques
```

**Expected result:** Claude Code will read index.html, identify all placeholders, and make precise replacements while preserving HTML structure and HAP's apprentice voice.

### Review Claude's changes

```
Please show me a summary of what you changed in index.html.
```

Claude Code will list the specific edits made. Review to ensure accuracy.

## Step 4: Customize station files

### Approach: One station at a time

Rather than overwhelming Claude with all 6 stations at once, work iteratively.

### Station 1: Detailed content

**Prompt:**

```
Let's customize stations/station1.html for Flexbox Fundamentals.

Replace all placeholders with this content:

STATION_TITLE: Flexbox Fundamentals
SUBTITLE: Building Flexible One-Dimensional Layouts
BRIEF_DESCRIPTION: Master flexbox for powerful, flexible layouts that adapt to content

For the introduction, write in HAP's apprentice voice (first person,
learning from Prof. Teeters) about discovering flexbox. Include:
- What HAP found confusing at first (the difference between flex container
  and flex items)
- The "aha moment" when it clicked
- 2-3 key insights HAP learned

For the main content sections, include:
- Section 1: Flex container properties (display: flex, flex-direction,
  justify-content, align-items)
- Section 2: Flex item properties (flex-grow, flex-shrink, flex-basis,
  shorthand)
- Section 3: Common patterns (navigation bars, card layouts, centering)

Add 3 code examples with explanations.
Add 3 practical tips in HAP's voice for the Quick Reference section.
```

**Why this works:** You provide the educational content structure, Claude Code handles the HTML formatting, placeholder replacement, and maintains consistency with the template's patterns.

### Station 2-6: Iterate and refine

**For stations 2-6, use a similar prompt pattern:**

```
Now let's customize stations/station2.html for Grid Systems.

[Provide similar detailed content outline]

Use the same structure and voice as station1.html for consistency.
```

**Pro tip:** After station 1, you can reference it as a model:

```
Customize station3.html following the same structure and voice as
station1.html, but for Subgrid. Here's the content...
```

## Step 5: Customize easter egg insights

### Update data/hybit-insights.jsonc

**Prompt:**

```
Update data/hybit-insights.jsonc for my CSS layout learning lab:

1. Replace example1-example6 parameters with:
   - flexbox (Flexbox fundamentals)
   - grid (Grid system basics)
   - subgrid (Subgrid alignment)
   - container (Container queries)
   - logical (Logical properties)
   - spacing (Modern spacing techniques)

2. For each parameter, write a short educational insight (2-3 sentences) in
   HAP's apprentice voice about what makes that technique powerful

3. Update the pageHelp section to reference these new parameters for each
   station

Keep the security structure intact - only update the content.
```

**What Claude Code will do:**
- Read the JSONC file structure
- Replace parameter names systematically
- Generate HAP-voiced content for each insight
- Update pageHelp mappings
- Preserve comments and security whitelist structure

## Step 6: Update meta descriptions and README

### SEO and documentation

**Prompt:**

```
Please update:

1. All meta descriptions in station1.html through station6.html to include
   specific SEO keywords for CSS layout techniques

2. README.md - replace the "Web Images" example content in the Quick Start
   section with CSS layout examples. Keep the structure but make it relevant
   to my theme.

3. Update the lighthouse-tutorial.md references from "images" to "CSS layouts"
   where appropriate
```

## Step 7: Testing and validation

### Let Claude Code run the tests

**Prompt:**

```
Now let's test the customized learning lab:

1. First, show me the current git status to see what files changed
2. Run npm install to set up Lighthouse testing
3. Start a local server (python3 -m http.server 8000)
4. In a separate process, run Lighthouse CI tests
5. Report any issues found

If there are broken links or navigation issues, fix them.
```

**What Claude Code will do:**
- Check git status and show modified files
- Install dependencies
- Start local server in background
- Run Lighthouse CI tests
- Parse test results and fix any issues found
- Report final scores

### Fix issues iteratively

If tests reveal problems:

```
The Lighthouse test found that station3.html has a broken navigation link.
Please fix it and re-run the tests.
```

Claude Code will identify the issue, fix it, and verify the correction.

## Step 8: Content refinement

### Ask Claude to review consistency

**Prompt:**

```
Please review all 6 station files for:

1. Consistent use of HAP's apprentice voice (first person, learning from
   Prof. Teeters)
2. Navigation links all work correctly
3. Station numbers and titles match between index.html and station files
4. All placeholders have been replaced
5. Code examples are properly formatted with Prism.js classes

Create a checklist report of what you found.
```

**Why this matters:** Claude Code can systematically check consistency across files faster and more reliably than manual review.

## Step 9: Generate documentation

### Create a content guide

**Prompt:**

```
Based on the customized content, create a new file docs/content-guide.md
that documents:

1. The learning objectives for each station
2. Prerequisites students should have
3. Estimated time to complete each station
4. Key concepts covered in each station
5. Suggested teaching notes for instructors

Format it in markdown following the style guide.
```

## Step 10: Final review and deployment preparation

### Create deployment checklist

**Prompt:**

```
Create a deployment checklist in docs/deployment-checklist.md that includes:

1. Pre-deployment tasks (test all links, run Lighthouse, validate HTML)
2. Deployment steps for common hosting platforms (Netlify, Vercel, GitHub Pages)
3. Post-deployment verification (test live site, check analytics)
4. Maintenance schedule (when to update content, review student feedback)

Include specific commands I should run.
```

## Advanced techniques

### Batch operations with Claude Code

Once you're comfortable, you can give Claude Code larger batches:

**Prompt:**

```
I have revised content for stations 4, 5, and 6. Let me give you the
content outlines, then you update all three station files in parallel.

[Provide content for all three stations]

After updating, create a summary showing:
- What changed in each file
- Any issues encountered
- Consistency check results
```

### Content generation assistance

Claude Code can help draft content:

**Prompt:**

```
I'm struggling to write the "HAP's Confession" section for station4.html
about container queries.

Generate 2-3 options for HAP's apprentice voice describing:
- Initial confusion about the difference between media queries and container
  queries
- The moment it clicked when Prof. Teeters showed a practical example
- Why this makes component-based design easier

Keep it under 100 words, conversational, and relatable.
```

### Iterative refinement

**Prompt:**

```
The HAP intro in station2.html feels too technical. Can you rewrite it to be:
- More conversational and less formal
- Include a specific example HAP tried that didn't work at first
- Emphasize the learning journey, not just the facts
- Keep it under 80 words
```

## Best practices

### Do's

- **Be specific with content** - Claude needs your educational expertise
- **Work iteratively** - One station at a time for complex changes
- **Review Claude's work** - You're the content expert, Claude is the implementer
- **Use git commits** - Commit after each major change so you can revert if needed
- **Reference previous work** - "Use the same style as station1.html"
- **Ask for summaries** - "Show me what you changed"

### Don'ts

- **Don't assume Claude knows your domain** - Provide specific learning objectives
- **Don't skip testing** - Always run Lighthouse and test navigation
- **Don't edit files manually mid-process** - Let Claude finish a task before manual edits
- **Don't provide vague directions** - "Make it better" won't work well
- **Don't forget HAP's voice** - Remind Claude to maintain apprentice perspective

## Example: Complete workflow

Here's a real example of customizing the entire template:

```
USER: I want to create a learning lab about JavaScript async patterns.
      Here are my 6 stations: [provides list]

CLAUDE: I'll help customize the template. Let's start with index.html...
        [makes changes]

USER: Great! Now station1.html about callbacks and promises.
      [provides detailed content outline]

CLAUDE: I've updated station1.html with your content. Here's what changed...
        [shows diff summary]

USER: The HAP intro feels too formal. Make it more conversational.

CLAUDE: I've revised it to be more conversational: [shows new version]

USER: Perfect! Let's continue with station2.html...
      [continues through all 6 stations]

USER: Now update the easter egg insights for JavaScript concepts

CLAUDE: I've updated hybit-insights.jsonc with async/await parameters...

USER: Run the tests

CLAUDE: Running npm install... Starting server... Running Lighthouse CI...
        Results: All stations passed! Scores: 99/100/100/100

USER: Create a deployment checklist

CLAUDE: I've created docs/deployment-checklist.md with steps for...

USER: Commit everything with a descriptive message

CLAUDE: Committed all changes: "Complete JavaScript async patterns
        learning lab customization"
```

## Troubleshooting

### Issue: Claude replaces content inconsistently

**Solution:** Be more specific about which sections to change:

```
In station3.html, only update:
- Lines 37-38: The h1 title and subtitle
- Lines 55-88: The main content section
- Lines 135-160: The tips section

Leave navigation and footer unchanged.
```

### Issue: HAP's voice doesn't sound right

**Solution:** Provide example text in HAP's voice:

```
Here's an example of HAP's voice: "When Prof. Teeters first showed me
flexbox, I was confused about why items wouldn't line up the way I expected.
Turns out, I forgot that the container needs display: flex, not the items!
Once that clicked, everything made sense."

Rewrite the station2.html intro in this same style.
```

### Issue: Code examples aren't properly formatted

**Solution:** Specify the format explicitly:

```
Format all code examples with:
- Prism.js class: language-css or language-javascript
- Proper indentation (2 spaces)
- Inline comments explaining key lines
- A paragraph after each example explaining what it does
```

## Time savings estimate

**Manual customization of template:** 8-12 hours
- Find/replace all placeholders: 2 hours
- Write and format content: 4-6 hours
- Ensure consistency: 1-2 hours
- Testing and fixes: 1-2 hours

**With Claude Code:** 2-4 hours
- Content planning: 1 hour
- Directing Claude: 30-60 minutes
- Review and refinement: 30-60 minutes
- Testing: 30 minutes

**You save 6-8 hours and reduce human error in find/replace operations.**

## Conclusion

Using Claude Code to customize this template transforms the process from tedious technical work into collaborative content development. You focus on what you do best (educational content and teaching strategy) while Claude handles what it does best (systematic file editing, consistency checking, and testing).

The key to success is clear communication: provide specific content, check Claude's work, and iterate until it matches your vision. The result is a professional, consistent, and thoroughly tested learning lab in a fraction of the time.

## Next steps

1. Review `docs/style-guide.md` for HAP voice guidelines
2. Check `data/README.md` for easter egg customization details
3. Read `docs/lighthouse-tutorial.md` for performance testing
4. Start customizing with the prompts in this tutorial!

---

**Pro tip:** Save your best prompts! As you refine your communication with Claude Code, document the prompts that worked well for reuse in future learning labs.
