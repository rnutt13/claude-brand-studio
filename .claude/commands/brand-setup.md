You are setting up a new brand for Claude Brand Studio. Follow these steps exactly.

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
- If the brand is light or enterprise: read `brands/salesforce/CLAUDE.md` for structural guidance

Use these files for **structure only** — token names, motif patterns, button CSS shape. Do NOT copy color values.

## Step 3 — Derive company slug
Lowercase the company name, replace spaces with hyphens, remove special characters. Example: "Stripe" → "stripe", "Home Depot" → "home-depot".

## Step 4 — Create the brand directory and CLAUDE.md
Create `brands/[slug]/` and write `brands/[slug]/CLAUDE.md` with this structure:

```
You are creating HTML presentation files in [Company]'s brand style. The root CLAUDE.md has already been read — apply everything below on top of those global rules.

## Brand personality
[2 to 3 sentences describing the company's personality, visual tone, and what the presentation should feel like. Derive this from the website content and the user-provided vibe if given.]

## Design tokens
[CSS :root block with all custom properties, derived from the real brand colors]

## Typography
[Font choice and weight specification]

## Surface strategy
[Which of the three deliverables is the default surface and which is the punctuation. For example: "Light scrolling site is default. Bold scrolling site uses the deep brand color as the dominant canvas. The slide deck mixes both, with deep slides reserved for title, segue, and CTA moments."]

## Animations
[Which motion patterns are on by default for this brand. For example: floating orb hero, line-by-line headline rise on load, count-up numerals on stats, ring-draw on radial charts, staggered section entrances. Include any brand-specific tweaks like the orb colors, the gradient used for animated text, or the easing curve.]

## Key visual motifs
[Bullet list of 4 to 6 brand-specific design patterns]

## Logo
[HTML snippet using the logo path. Asset path must be relative from inside brands/[slug]/ — use ../../assets/logos/... for shared logos, or ../../assets/logos/[slug]/filename for a brand-specific logo.]

## Buttons
[Primary and ghost button CSS. Default to pill-shaped (border-radius: 999px) unless the brand is known for square buttons.]

## Common mistakes to avoid
[3 to 4 brand-specific pitfalls]
```

## Step 5 — Generate three demo files
Build the brand across all three deliverable formats. Each file is self-contained, uses real content from the company's website (no Lorem Ipsum, no generic filler), and applies the new brand tokens throughout.

All asset paths must be relative from inside `brands/[slug]/` — use `../../assets/logos/...` to reach shared logos.

**`brands/[slug]/brand-demo.html`** (light scrolling site):
Sticky nav at top, full-width hero, then StatTicker bar, SplitValuePanel, FeatureRevealCard grid, TabbedContent, StepTimeline, ComparisonTable, IconFeatureGrid, ScrollCardRow, ValueAccordion, PullQuote, and CTABand at the bottom. Each section gets a generous heading and real copy before the component. No eyebrow labels.

**`brands/[slug]/brand-demo-bold.html`** (bold scrolling site):
Same structure as the light version but the dominant canvas is the brand's deep color. Light interrupt sections (white or near-white backgrounds) for the comparison table and one or two stat moments to give the eye a rest.

**`brands/[slug]/brand-slides.html`** (16:9 slide deck):
Centered 16:9 stage with arrow-key navigation (left, right, space, Home, End). Brand logo top-right of every slide, slide counter bottom-right, prev/next buttons bottom-left, a thin progress bar on the very bottom edge. Mix surfaces deliberately: alternate light and deep slides. Roughly 10 to 12 slides covering the same story arc as the scrolling sites.

All three include the brand's animation system. No external CSS or JS imports beyond Google Fonts (or local `@font-face` from `assets/fonts/` if the brand requires it).

## Step 6 — Output summary
Print:
```
Brand setup complete.

Brand file:    brands/[slug]/CLAUDE.md
Light site:    brands/[slug]/brand-demo.html
Bold site:     brands/[slug]/brand-demo-bold.html
Slide deck:    brands/[slug]/brand-slides.html

Open each file in your browser to review the brand.

To build presentations or refine the brand:
  cd brands/[slug]
  claude

The brand context loads automatically — no slash command needed.
```

## Rules
- All colors, fonts, and motifs must come from the fetched URL and user inputs. Never copy from the reference examples.
- No emojis, no CSS frameworks, no external JS libraries, no Lorem Ipsum.
- No em-dashes or en-dashes in copy. Use a period, comma, colon, or rephrase.
- No eyebrow labels by default. Lead with the headline.
- Every demo file must be self-contained and open directly in a browser.
- All asset paths are relative from inside `brands/[slug]/` — use `../../assets/logos/...`.
