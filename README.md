# Claude Brand Studio

A branded HTML presentation generator for [Claude Code](https://claude.ai/code). Point it at any company website and it derives brand tokens, builds a full component demo, and gives you a design system you can use to create polished customer presentations.

Output: self-contained single-file HTML decks that open directly in a browser — no build tools, no frameworks, no server.

---

## Requirements

- [Claude Code](https://claude.ai/code) CLI installed and authenticated
- A web browser

---

## Quickstart

**1. Use this template**

Click **Use this template** on GitHub to create your own copy, then clone it:

```bash
git clone https://github.com/YOUR_USERNAME/claude-brand-studio
cd claude-brand-studio
```

**2. Set up your brand**

```bash
./brand-setup.sh
```

The script asks for your company URL (and optionally a one-word vibe and logo path), then opens Claude Code with setup pre-loaded.

Claude will:
1. Fetch your company's website to extract colors, fonts, and visual style
2. Generate a brand token file at `.claude/commands/[company]-brand.md`
3. Build a full demo at `projects/[company]/brand-demo.html` showcasing all 12 components

Open the demo in your browser. If anything looks off, stay in Claude Code and describe the change — Claude uses `/brand-refine` to update the tokens and regenerate the demo.

**3. Build a presentation**

Once your brand is ready, describe what you need in Claude Code:

```
Create a slide deck for our Q3 roadmap review using the stripe-brand style.
Include a hero, three feature sections, and a CTA.
```

Or a scrolling landing page:

```
Build a partnership pitch for Acme Corp using the acme-brand style.
Lead with our integration story, then show three customer outcomes with stats.
```

---

## CLI reference

```
./brand-setup.sh                          Set up a new brand (interactive)
./brand-setup.sh --publish <slug>         Publish your brand to a new GitHub repo
./brand-setup.sh --install <github-url>   Install a brand from a GitHub repo
./brand-setup.sh --update                 Update tool files (leaves your brands untouched)
./brand-setup.sh --version                Print version
```

### Sharing a brand with your team

Once your brand looks right, publish it to its own GitHub repo:

```bash
./brand-setup.sh --publish stripe
# → creates github.com/YOU/claude-wd-stripe
```

Teammates install it into their own copy:

```bash
./brand-setup.sh --install https://github.com/you/claude-wd-stripe
# → drops stripe-brand.md into .claude/commands/
# → use /stripe-brand in Claude Code
```

### Updating the tool

Pull the latest tool files without touching your brand files or projects:

```bash
./brand-setup.sh --update
```

---

## Salesforce internal presentations

For internal decks (QBRs, business reviews, team presentations), skip brand setup and use the built-in Salesforce style:

Open Claude Code in this directory, then:

```
/salesforce-brand
Create a Q2 business review deck with a hero, executive summary, pipeline metrics, and next steps.
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

Claude follows these on every file it creates:

- No emojis — real logos or CSS shapes only
- No CSS frameworks (Bootstrap, Tailwind, etc.) — pure CSS with custom properties
- No external JS libraries — vanilla JS only
- No Lorem Ipsum — all copy is real and brand-appropriate
- Single self-contained files — open directly in a browser, no server needed
- Google Fonts imports are allowed

---

## File layout

```
brand-setup.sh              — CLI for setup, publish, install, update
CLAUDE.md                   — rules Claude follows (read automatically)
components/library.html     — interactive component reference
assets/logos/               — generic tech logos (Salesforce, AWS, Slack, etc.)
docs/reference/             — structural templates Claude reads internally
.claude/commands/           — brand skill files (brand-setup, brand-refine, salesforce, yours)
projects/                   — your generated HTML presentations go here
VERSION                     — current tool version
```
