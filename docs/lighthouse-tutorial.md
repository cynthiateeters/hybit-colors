# Lighthouse Tutorial

## Overview

**Lighthouse** is an open-source, automated tool from Google that helps you improve the quality of web pages. It audits for **performance**, **accessibility**, **best practices**, **SEO**, and **Progressive Web App (PWA)** compliance. You can run it in Chrome DevTools, from the command line, or as part of automated workflows.

When you run Lighthouse, it performs a series of tests on a given URL and generates a report showing where your site succeeds and where it can be improved.

### Why Use Lighthouse?

- Identify performance bottlenecks such as large images, render-blocking scripts, or inefficient layouts.
- Measure accessibility and adherence to web standards.
- Monitor improvement over time using automated reports.
- Integrate into continuous integration (CI) pipelines for consistency and accountability.

---

## Using Lighthouse at the Command Line

Lighthouse provides a Node-based CLI (Command Line Interface) that lets you automate audits for any live or local site. It’s installed as part of this project via:

```bash
npm install --save-dev lighthouse
```

Once installed, you can run Lighthouse directly:

```bash
npx lighthouse https://example.com --view
```

This command:

- Runs the audit on the specified URL.
- Opens the report automatically in your browser.

---

## Project Scripts

Your `package.json` includes several helpful scripts for running Lighthouse:

| Command | Description |
|----------|-------------|
| `npm run lh -- https://example.com` | Runs Lighthouse with default settings and opens the report. |
| `npm run lh:desktop -- https://example.com` | Runs the desktop preset. |
| `npm run lh:mobile -- https://example.com` | Runs the mobile preset. |
| `npm run lh:html -- https://example.com` | Saves an HTML report in `reports/lh-report.html`. |
| `npm run lh:json -- https://example.com` | Saves a JSON report for data analysis. |
| `npm run lh:csv -- https://example.com` | Saves a CSV report. |

These scripts allow you to test different scenarios and export results in multiple formats.

---

## Moving to Lighthouse CI (LHCI)

When you need to run Lighthouse automatically in a build or grading environment, use the **Lighthouse CI CLI** package:

```bash
npm install --save-dev @lhci/cli
```

### What LHCI Does

`@lhci/cli` provides automation tools that let you:

- Run Lighthouse against multiple URLs.
- Set performance and accessibility score thresholds.
- Store and compare reports between runs.
- Fail builds if scores fall below expectations.

### Example Configuration

Create a `lighthouserc.json` file in your project root:

```json
{
  "ci": {
    "collect": {
      "url": ["https://hap-images.netlify.app/"],
      "numberOfRuns": 3
    },
    "assert": {
      "assertions": {
        "categories:performance": ["error", {"minScore": 0.9}],
        "categories:accessibility": ["warn", {"minScore": 0.9}]
      }
    },
    "upload": {
      "target": "temporary-public-storage"
    }
  }
}
```

Then run:

```bash
npm run lh:ci
```

This runs the audits, saves the reports in `.lighthouseci/`, and uploads them to temporary public storage so you can review them easily.

---

## Next Steps

- Add multiple URLs to your `lighthouserc.json` for class projects or student sites.
- Create a `reports/` folder to store local report artifacts.
- Use the JSON or CSV reports to analyze trends over time.

**Lighthouse and LHCI** together give you both hands-on and automated insight into how well your sites perform—and how they can improve.
