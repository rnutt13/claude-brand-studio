You are setting up a new brand for the Claude Web Design system. Follow these steps exactly.

## Arguments
Parse from the invocation string:
- `url="..."` — required, company website URL
- `vibe="..."` — optional, one adjective the user provided
- `logo="..."` — optional, local path to logo file

## Step 1 — Fetch brand data
Use WebFetch on the provided URL. Extract:
- Dominant colors (background, primary accent, secondary accent, text)
- Whether the overall style is light or dark
- Font families referenced in CSS or Google Fonts links
- Overall visual approach (sharp/angular, rounded/friendly, minimal, bold, etc.)

If the homepage is primarily an app login or marketing splash with little visual signal, also fetch the /about or /brand page.

## Step 2 — Determine template direction
- If the brand is dark or technical: read `docs/reference/dark-brand-example.md` for structural guidance
- If the brand is light or enterprise: read `.claude/commands/salesforce-brand.md` for structural guidance

Use these files for **structure only** — token names, motif patterns, button CSS shape. Do NOT copy color values.

## Step 3 — Derive company slug
Lowercase the company name, replace spaces with hyphens, remove special characters. Example: "Stripe" → "stripe", "Home Depot" → "home-depot".

## Step 4 — Write the brand file
Create `.claude/commands/[slug]-brand.md` with this structure:

```
You are creating an HTML presentation file in [Company]'s brand style. Read CLAUDE.md first for global rules, then apply everything below.

## Brand personality
[2–3 sentences describing the company's personality, visual tone, and what the presentation should feel like. Derive this from the website content and user-provided vibe if given.]

## Design tokens
[CSS :root block with all custom properties, derived from the real brand colors]

## Typography
[Font choice and weight specification]

## Key visual motifs
[Bullet list of 4–6 brand-specific design patterns]

## Logo
[HTML snippet using the logo path if provided, or a CSS text placeholder if not]

## Buttons
[Primary and ghost button CSS]

## Common mistakes to avoid
[3–4 brand-specific pitfalls]
```

## Step 5 — Generate demo HTML
Create `projects/[slug]/brand-demo.html` — a single self-contained HTML file that:
- Uses all 12 components from the component library (ValueAccordion, FeatureRevealCard, StepTimeline, ScrollCardRow, TabbedContent, StatTicker, SplitValuePanel, ComparisonTable, IconFeatureGrid, HeroSlide, PullQuote, CTABand)
- Applies the new brand tokens throughout
- Uses real content derived from the company's website — actual product names, real value propositions, real market positioning. No Lorem Ipsum, no generic filler.
- Uses this layout structure: sticky nav at top → full-width hero section → StatTicker bar → SplitValuePanel → FeatureRevealCard grid → TabbedContent → StepTimeline → ComparisonTable → IconFeatureGrid → ScrollCardRow → ValueAccordion → PullQuote → CTABand at bottom. Each section has a generous heading, eyebrow label, and real copy before the component.
- Is fully self-contained: no external CSS/JS imports except Google Fonts

## Step 6 — Output summary
Print:
```
Brand setup complete.

Brand file:  .claude/commands/[slug]-brand.md
Demo file:   projects/[slug]/brand-demo.html

Open the demo in your browser to review the brand.
To refine it, stay in Claude Code and describe what to change — or run /brand-refine.
To build a real presentation: tell Claude what you need, mentioning the [slug]-brand style.
Commit [slug]-brand.md to share the brand with your team.
```

## Rules
- All colors, fonts, and motifs must come from the fetched URL and user inputs — never from the reference examples
- No emojis, no CSS frameworks, no external JS libraries, no Lorem Ipsum
- The demo HTML must be a single self-contained file that opens directly in a browser
