# Quick start guide

Get your HAP Learning Lab customized and deployed in under 30 minutes using Claude Code as your AI assistant.

## Prerequisites

- Git installed
- Node.js and npm installed (for lighthouse testing)
- Text editor or IDE
- Claude Code access

## Step 1: Clone the template and create your new repository

```bash
# Clone the template
git clone https://github.com/yourusername/hap-template.git my-learning-lab
cd my-learning-lab

# Remove the template's git history
rm -rf .git

# Initialize a fresh repository for your project
git init -b main
```

## Step 2: Install dependencies

```bash
npm install
```

## Step 3: Plan your content

Open `CONTENT-PLAN.md` and fill in:

- Your learning lab theme (e.g., "Modern CSS Layouts")
- Your 6 station topics
- Target audience and learning objectives
- Resource links and examples

## Step 4: Use Claude Code to customize

Copy and paste these prompts to Claude Code, one at a time:

### Prompt 1: Update hub page

```
Please update index.html with my learning lab theme:
1. Replace "[YOUR THEME]" with "Modern CSS Layouts"
2. Replace "[YOUR TOPICS]" with "flexbox, grid, subgrid, container queries, logical properties, and modern layout patterns"
3. Update all 6 station cards with my station titles from CONTENT-PLAN.md
4. Update the meta description
```

### Prompt 2: Customize station 1

```
Please customize stations/station1.html for my first station about [TOPIC]:
1. Replace all [PLACEHOLDERS] with content from CONTENT-PLAN.md
2. Write HAP's apprentice voice introduction
3. Add 3 key insights with real statistics
4. Include code examples with proper syntax highlighting
5. Add HAP's confession callout about learning this topic
```

### Prompt 3: Repeat for stations 2-6

Repeat the station customization prompt for each of the remaining 5 stations, adjusting the topic and content each time.

### Prompt 4: Update easter egg

```
Please update data/hybit-insights.jsonc:
1. Add page-specific help for each of my 6 stations
2. Add 3 custom insight messages related to my theme
3. Update the allowedParams array
4. Keep HAP's friendly voice throughout
```

### Prompt 5: Validate and test

```
Please run the validation scripts:
1. bash scripts/validate-placeholders.sh
2. bash scripts/check-customization.sh
3. bash scripts/test-setup.sh

Fix any issues found.
```

## Step 5: Test locally

```bash
python3 -m http.server 8000
```

Open `http://localhost:8000` and verify:

- All 6 stations display correctly
- Navigation works
- Images load
- Easter egg works (try `?hybit`)
- Code syntax highlighting works

## Step 6: Create your first commit

```bash
git add .
git commit -m "Initial customization of HAP Learning Lab for [YOUR THEME]"
```

## Step 7: Deploy

Choose your hosting platform:

### GitHub Pages (recommended)

```bash
# 1. Create a NEW repository on GitHub (do not initialize with README)
# 2. Connect your local repository to GitHub:
git remote add origin https://github.com/yourusername/your-new-repo.git
git push -u origin main

# 3. Enable GitHub Pages in repository settings:
#    Settings → Pages → Source: Deploy from branch (main)
```

### Netlify

```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy
netlify deploy --prod
```

### Other platforms

- **Vercel**: Connect your GitHub repo at vercel.com
- **Cloudflare Pages**: Connect your GitHub repo at pages.cloudflare.com
- **Custom server**: Upload contents to your web server's public directory

## Troubleshooting

### Placeholders still visible

Run `bash scripts/validate-placeholders.sh` to find remaining placeholders.

### Images not loading

- Check that all Cloudinary URLs are correct
- Verify images exist at the URLs
- Check browser console for errors

### Easter egg not working

- Verify `data/hybit-insights.jsonc` is valid JSON (comments are stripped by JavaScript)
- Check browser console for parsing errors
- Ensure `js/easter-egg.js` is loaded

### Lighthouse scores low

Run `npm run lh:ci` to get detailed performance recommendations.

## Next steps

- Review the full tutorial at `docs/claude-code-tutorial.md`
- Read `docs/bash-script-hardening-guide.md` for script security best practices
- Check `CLAUDE.md` for project architecture details
- Review `README.md` for complete documentation

## Time savings

**Manual customization**: 6-8 hours
**With Claude Code**: 20-30 minutes

## Support

- Template issues: Open issue on GitHub
- Claude Code help: See `docs/claude-code-tutorial.md`
- HAP character questions: See `TRADEMARK.md`

## License reminder

- **Code (HTML/CSS/JS)**: MIT License - use freely
- **HAP character and branding**: Proprietary - see `TRADEMARK.md`
- **Educational content and methodology**: Proprietary - see `CONTENT-LICENSE.md`

Always maintain attribution and respect the multi-license structure.
