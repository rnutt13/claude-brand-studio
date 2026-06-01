# Claude Brand Studio — Project Rules

These rules apply to every HTML file created in this project.

## Non-negotiable rules
- **No emojis anywhere.** Not in copy, not as icons, not as placeholders. Use real logos or CSS shapes.
- **No em-dashes or en-dashes in copy.** Use a period, comma, colon, or rephrase. Em-dashes are an AI-writing tell.
- **No eyebrow labels by default.** No 12px uppercase tracked-out labels above section titles. Lead with the headline. Only add a small label if the brand explicitly calls for one.
- **No Bootstrap, Tailwind, or any CSS framework.** Pure CSS with custom properties only.
- **No Lorem Ipsum.** All copy must be real, contextually appropriate content for the brand.
- **No external JS libraries.** Vanilla JS only.
- **No generic AI-looking UI.** No "three cards with three bullet points and a blue gradient on every page" layouts.
- **Single self-contained HTML files.** No imports, no bundlers, no server required. Open directly in browser.
- Google Fonts `@import` is allowed (it's a stylesheet link, not a framework). Local fonts loaded via `@font-face` from `assets/fonts/` are also allowed but rarely needed.

## Purpose
These HTML files replace PowerPoint and Google Slides for customer presentations. Each file is a branded experience for a specific company or pitch. Describe what you need and Claude picks components that match whether it's more slide-like (16:9 deck) or content-heavy (scrolling page).

A brand generates three files for review: a light scrolling site (`brand-demo.html`), a bold scrolling site (`brand-demo-bold.html`), and a 16:9 slide deck (`brand-slides.html`).

## Motion is part of the brand
Every brand should be animated. The encouraged baseline: a hero with floating blurred color orbs and a headline that rises in line-by-line, count-up numerals on stats, ring-draw animations on radial charts, and staggered section entrances. The brand CLAUDE.md documents which animations are on by default and any brand-specific tweaks.

## How brands work
Each brand lives in its own directory under `brands/`:
```
brands/stripe/
brands/acme/
```

Each brand directory contains a `CLAUDE.md` with brand tokens, personality description, and design rules. Claude Code automatically loads both this root `CLAUDE.md` (global rules) and the brand `CLAUDE.md` (brand tokens) when you launch from inside a brand directory — no skill loading needed.

**To work on a brand:**
```bash
cd brands/stripe
claude
```

**To create a new brand:** Run `./brand-setup.sh` from the repo root.

## File naming and location
Save all presentation files inside the brand directory:
```
brands/stripe/q3-roadmap.html
brands/acme/partnership-pitch.html
brands/salesforce/q2-business-review.html
```

## Asset locations
Generic tech logos are in `assets/logos/` (relative to repo root):
```
assets/logos/salesforce/Salesforce.png   — Salesforce cloud wordmark
assets/logos/aws.png                      — AWS
assets/logos/Slack.png                    — Slack
assets/logos/mulesoft.png                 — MuleSoft
assets/logos/claude.svg                   — Claude / Anthropic
assets/logos/ChatGPT.png                  — ChatGPT / OpenAI
assets/logos/GCP small.avif               — Google Cloud
```

Your company logo path will be documented in your brand's `CLAUDE.md` after running `/brand-setup`.

Asset paths from inside `brands/[company]/` use `../../assets/logos/...` (two levels up to reach repo root).

### Logo CSS treatments
- Black logo on dark background: `filter: brightness(0) invert(1)`
- White-background logo on dark background: `mix-blend-mode: screen`
- Colored-background logo on dark background: `mix-blend-mode: screen` or `mix-blend-mode: lighten`

## Component library
Reference file: `components/library.html` (repo root) — open in a browser to see all available components.

Available components (use these as building blocks):
- **ValueAccordion** — collapsed rows that expand on click to show detail
- **FeatureRevealCard** — card shows headline; click opens a detail drawer below with stats
- **StepTimeline** — numbered steps, click to expand each
- **ScrollCardRow** — horizontal scroll rail with arrow buttons, scroll-snap
- **TabbedContent** — tab bar switches between content panels
- **StatTicker** — large animated number with label
- **SplitValuePanel** — two-column text + visual panel
- **ComparisonTable** — side-by-side comparison rows
- **IconFeatureGrid** — grid of feature cards with logo/icon + copy
- **HeroSlide** — full-viewport opening section
- **PullQuote** — large blockquote with attribution
- **CTABand** — full-width call-to-action strip

## Brand commands (run from repo root)
- `/brand-setup` — generate a new brand directory and demos from a company URL
- `/brand-refine` — iterate on the current brand's CLAUDE.md and demo files (run from inside a brand directory)
