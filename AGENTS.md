# Claude Brand Studio — Project Rules

These rules apply to every HTML file created in this project.

## Non-negotiable rules
- **No emojis anywhere** — not in copy, not as icons, not as placeholders. Use real logos or CSS shapes.
- **No Bootstrap, Tailwind, or any CSS framework** — pure CSS with custom properties only.
- **No Lorem Ipsum** — all copy must be real, contextually appropriate content for the brand.
- **No external JS libraries** — vanilla JS only.
- **No generic AI-looking UI** — no cards with three bullet points and a blue gradient on every page.
- **Single self-contained HTML files** — no imports, no bundlers, no server required. Open directly in browser.
- Google Fonts `@import` is allowed (it's a stylesheet link, not a framework).

## Purpose
These HTML files replace PowerPoint/slide decks for customer presentations. Each file is a branded experience for a specific company or pitch. Describe what you need; Claude picks components that match whether it's more slide-like (full-viewport sections) or content-heavy (scrolling page).

## How brands work
Each brand lives in its own directory under `brands/`:
```
brands/stripe/
brands/acme/
```

Each brand directory contains a `CLAUDE.md` with brand tokens, personality description, and design rules. Claude Code automatically loads both this root `CLAUDE.md` (global rules) and the brand `CLAUDE.md` (brand tokens) when you launch from inside a brand directory.

**To work on a brand:**
```bash
cd brands/stripe
claude
```

## File naming and location
Save all presentation files inside the brand directory:
```
brands/stripe/q3-roadmap.html
brands/acme/partnership-pitch.html
brands/salesforce/q2-business-review.html
```

## Asset locations
All assets are relative to the repo root.

### Logos
```
../../assets/logos/salesforce/Salesforce.png   — Salesforce cloud wordmark (works as-is)
../../assets/logos/aws.png         — AWS
../../assets/logos/Slack.png       — Slack
../../assets/logos/mulesoft.png    — MuleSoft
../../assets/logos/claude.svg      — Claude / Anthropic
../../assets/logos/ChatGPT.png     — ChatGPT / OpenAI
../../assets/logos/GCP small.avif  — Google Cloud
```

(Paths shown are relative from inside a `brands/[company]/` directory.)

### Logo CSS treatments
- Black logo on dark background: `filter: brightness(0) invert(1)`
- White-background logo on dark background: `mix-blend-mode: screen`
- Colored-background logo on dark background: `mix-blend-mode: screen` or `mix-blend-mode: lighten`

## Component library
Reference file: `../../components/library.html`

Available components:
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
- `/brand-refine` — iterate on the current brand (run from inside a brand directory)
