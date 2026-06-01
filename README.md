# Claude Brand Studio

A branded HTML presentation generator for [Claude Code](https://claude.ai/code). Point it at any company website and it derives brand tokens, builds a full component demo, and gives you a design system for creating polished customer presentations.

Output: self-contained single-file HTML decks that open directly in a browser. No build tools, no frameworks, no server.

---

## Get started

**1. Create your repo from this template**

Click the green **Use this template** button on GitHub, name it anything you want (e.g. `stripe-brand-studio`), and create it under your account.

**2. Clone it**

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME
cd YOUR_REPO_NAME
```

**3. Run the setup script**

```bash
chmod +x brand-setup.sh
./brand-setup.sh
```

Enter your company URL when prompted. Claude Code opens, fetches the site, derives brand colors and fonts, and builds three demo files inside `brands/[company]/`.

Open the demos in your browser to review. Describe any changes in Claude Code and they update instantly.

---

## Building presentations

Go to your brand directory, open Claude Code, and describe what you need.

```bash
cd brands/stripe
claude
```

The brand context loads automatically. Just tell Claude what to build:

```
Create a slide deck for our Q3 roadmap.
Include a hero, three feature sections, and a CTA.
```

```
Build a scrolling partnership pitch.
Lead with our integration story, then show three customer outcomes with stats.
```

Every file is self-contained HTML — open it directly in a browser, share it as a single file, or push the whole repo and let teammates clone it.

---

## CLI reference

The setup script handles everything — creating brands, sharing them, and keeping the tool current. The default workflow is one repo per brand, but you can run `./brand-setup.sh` multiple times in the same repo to manage several brands in one place.

```
./brand-setup.sh                          Set up a new brand (interactive)
./brand-setup.sh --publish <slug>         Export a brand to its own GitHub repo
./brand-setup.sh --install <github-url>   Install a brand from a GitHub repo
./brand-setup.sh --update                 Update tool files (leaves your brands untouched)
./brand-setup.sh --version                Print version
```

**Publishing a brand** creates a standalone repo teammates can install with one command:

```bash
./brand-setup.sh --publish stripe
# → creates github.com/YOU/claude-wd-stripe

# Teammates install it with:
./brand-setup.sh --install https://github.com/you/claude-wd-stripe
# → creates brands/stripe/ and merges any brand-specific assets
```

**Updating** pulls the latest tool files from upstream without touching your brands or presentations:

```bash
./brand-setup.sh --update
```

---

## Component library

Open `components/library.html` in a browser to see all 12 available components:

| Component | What it does |
|---|---|
| HeroSlide | Full-viewport opening section |
| StatTicker | Large animated stat numbers |
| SplitValuePanel | Two-column text + metric grid |
| ValueAccordion | Collapsed rows that expand on click |
| FeatureRevealCard | Card headline — click to open detail drawer |
| StepTimeline | Numbered steps, expandable |
| ComparisonTable | Side-by-side comparison rows |
| IconFeatureGrid | Icon + headline + copy grid |
| ScrollCardRow | Horizontal scroll rail with arrows |
| TabbedContent | Tab bar + content panels |
| PullQuote | Large blockquote with attribution |
| CTABand | Full-width call-to-action strip |

---

## Design rules

- No emojis. Real logos or CSS shapes only.
- No em-dashes or en-dashes in copy.
- No eyebrow labels by default. Lead with the headline.
- No CSS frameworks. Pure CSS with custom properties.
- No external JS libraries. Vanilla JS only.
- No Lorem Ipsum. All copy is real and brand-appropriate.
- Single self-contained files. Open directly in a browser.
- Google Fonts imports are allowed.

---

## File layout

```
brand-setup.sh              — CLI for setup, publish, install, update
CLAUDE.md                   — design rules (loaded automatically by Claude Code)
components/library.html     — interactive component reference
assets/logos/               — generic tech logos
docs/reference/             — structural templates Claude reads internally
.claude/commands/           — brand-setup and brand-refine slash commands
brands/                     — one directory per brand (created by brand-setup.sh)
VERSION                     — current tool version
```
