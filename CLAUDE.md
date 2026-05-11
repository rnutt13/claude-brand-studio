# Claude Web Design — Project Rules

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

A brand generates three files for review: a light scrolling site (`brand-demo.html`), a bold scrolling site (`brand-demo-bold.html`), and a 16:9 slide deck (`brand-slides.html`). The brand file decides which surface is the default and which is the punctuation.

## Motion is part of the brand
Every brand should be animated. The encouraged baseline: a hero with floating blurred color orbs and a headline that rises in line-by-line, count-up numerals on stats, ring-draw animations on radial charts, and staggered section entrances. The brand file documents which animations are on by default and any brand-specific tweaks.

## Setting up a brand
Before building any presentation, a brand file must exist for the target company.

- **New brand:** Run `./brand-setup.sh` from the repo root, or invoke `/brand-setup url="https://yourcompany.com"` directly in Claude Code. This fetches the company website, derives brand tokens, and generates a demo HTML file to review.
- **Salesforce internal presentations:** Use `/salesforce-brand` directly — no setup needed.
- **Refining a brand:** After reviewing the demo, describe changes in Claude Code or invoke `/brand-refine`.

## File naming and location
Save all presentation files inside `projects/`:
```
projects/stripe/q3-roadmap.html
projects/acme/partnership-pitch.html
projects/internal/q2-business-review.html
```

## Asset locations
Generic tech logos are in `assets/logos/`:
```
assets/logos/salesforce/Salesforce.png   — Salesforce cloud wordmark
assets/logos/aws.png                      — AWS
assets/logos/Slack.png                    — Slack
assets/logos/mulesoft.png                 — MuleSoft
assets/logos/claude.svg                   — Claude / Anthropic
assets/logos/ChatGPT.png                  — ChatGPT / OpenAI
assets/logos/GCP small.avif               — Google Cloud
```

Your company logo path will be documented in your brand file after running `/brand-setup`.

Asset paths from inside `projects/[company]/` use `../../assets/logos/...` (two levels up).

### Logo CSS treatments
- Black logo on dark background: `filter: brightness(0) invert(1)`
- White-background logo on dark background: `mix-blend-mode: screen`
- Colored-background logo on dark background: `mix-blend-mode: screen` or `mix-blend-mode: lighten`

## Component library
Reference file: `components/library.html` — open in a browser to see all available components.

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

## Brand commands
- `/brand-setup` — generate brand tokens + demo from a company URL
- `/brand-refine` — iterate on an existing brand file and demo
- `/salesforce-brand` — apply Salesforce's built-in brand for internal presentations
