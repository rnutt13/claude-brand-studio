# Claude Web Design — Project Rules

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
