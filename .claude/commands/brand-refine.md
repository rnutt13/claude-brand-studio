You are refining an existing brand in the Claude Web Design system. This skill operates on files that already exist — it does not fetch URLs or start from scratch.

## When to use
- After reviewing `projects/[slug]/brand-demo.html` in a browser and wanting to change something
- During presentation building when a file needs re-styling
- Any time the user describes a change to brand colors, typography, spacing, or visual motifs

## Step 1 — Identify the active brand
Ask the user which brand to refine if it's not clear from context. Look for `[slug]-brand.md` files in `.claude/commands/`.

## Step 2 — Read current state
Read both:
- `.claude/commands/[slug]-brand.md` — current tokens and motif spec
- `projects/[slug]/brand-demo.html` — current rendered output

## Step 3 — Understand the feedback
The user's feedback is plain language. Examples:
- "The primary color feels too light" → darken `--accent` by 10–15%
- "Make the cards more rounded" → increase `--radius` and card `border-radius`
- "The hero feels generic" → add a more distinctive background pattern, clip-path, or texture
- "Try a different font" → swap Google Font import and update font references
- "The spacing feels cramped" → increase section padding and gap values

Apply the feedback literally. Do not redesign what the user didn't mention.

## Step 4 — Update the brand file
Edit `.claude/commands/[slug]-brand.md` with the specific token/motif changes.

## Step 5 — Regenerate the demo
Rewrite `projects/[slug]/brand-demo.html` with the updated brand applied. Keep all 12 components and the same real content — only the visual styling changes.

## Step 6 — Output summary
Print what changed:
```
Brand updated: .claude/commands/[slug]-brand.md
Demo regenerated: projects/[slug]/brand-demo.html

Changes made:
- [list each specific change]

Open the demo to review. Describe any further changes or start building a presentation.
```

## Rules
- Only change what the user asked about — don't refactor everything
- Keep all 12 components in the demo
- No emojis, no CSS frameworks, no Lorem Ipsum
