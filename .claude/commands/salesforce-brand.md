You are creating an HTML presentation file in Salesforce's brand style. Read CLAUDE.md first for global rules, then apply everything below.

## Brand personality
Enterprise software company with a trust-first, optimistic tone. Not a startup, not a bank — somewhere between the two. Light mode, generous whitespace, confident blue. The aesthetic should communicate reliability, scale, and ROI. Content is usually about business outcomes: pipeline, revenue, customer success, AI productivity. This is the brand for pitching C-suite buyers.

## Design tokens
```css
:root {
  --blue: #0176d3;
  --blue-bright: #1b96ff;
  --blue-dark: #014486;
  --blue-light: #e8f4fd;
  --bg: #ffffff;
  --bg-alt: #f3f6fb;
  --bg-card: #ffffff;
  --text: #181818;
  --text-dim: #444444;
  --text-muted: #888888;
  --border: #dde2ed;
  --border-light: #eef1f8;
  --font: 'Inter', -apple-system, 'Segoe UI', sans-serif;
  --radius: 4px;      /* Salesforce uses very small radius — enterprise precision */
}
```

## Typography
- Google Font: `Inter` (weights 400, 500, 600, 700, 800)
- Headlines: weight 700–800, tight letter-spacing (-0.02em)
- Body: weight 400, color `var(--text-dim)`, line-height 1.65
- Labels/eyebrows: weight 700, letter-spacing 0.16–0.2em, uppercase, color `var(--blue)`

## Key visual motifs
- **Cloud SVG accent** — Salesforce's cloud shape as a decorative background element at low opacity:
  ```html
  <svg viewBox="0 0 480 340" fill="none" xmlns="http://www.w3.org/2000/svg" style="opacity:0.06;">
    <path d="M180 260C110 260 55 205 55 135C55 83 88 40 135 22C135 22 150 0 190 0C218 0 242 18 255 44C265 38 277 35 290 35C328 35 360 67 360 105C360 109 359 113 358 117C388 128 410 157 410 190C410 230 378 260 340 260H180Z" fill="#0176d3"/>
  </svg>
  ```
- **Blue top-rule on cards** — 3px `border-top: 3px solid var(--blue)` marks featured/active cards
- **Generous whitespace** — section padding 80–100px vertical, card padding 28–32px
- **Clean card grid** — flat white cards with 1px border, no heavy shadows except on hover
- **Stats as bold numbers** — large weight-800 numerals in `var(--blue)` followed by a muted label
- **Progress bar** — `height: 3px; background: var(--blue)` at bottom of viewport for slide navigation
- **Blue gradient CTA sections** — `background: linear-gradient(145deg, #0063b8 0%, #0176d3 40%, #1b96ff 100%)` for closing/CTA slides or bands
- **Check mark bullets** — CSS-only checkmarks in list items:
  ```css
  .check { width:18px; height:18px; border-radius:50%; background:var(--blue-light); border:1.5px solid var(--blue); display:flex; align-items:center; justify-content:center; flex-shrink:0; }
  .check::after { content:''; width:6px; height:4px; border-left:1.5px solid var(--blue); border-bottom:1.5px solid var(--blue); transform:rotate(-45deg) translateY(-1px); }
  ```

## Logo
```html
<img src="../../assets/logos/salesforce/Salesforce.png" alt="Salesforce" style="height:30px; width:auto;">
```
No CSS treatment needed — the logo works on white backgrounds directly.

## Buttons
```css
.btn-primary {
  background: var(--blue);
  color: #ffffff;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 0.04em;
  padding: 13px 28px;
  border: none;
  border-radius: var(--radius);
  cursor: pointer;
  transition: background 0.2s;
}
.btn-primary:hover { background: var(--blue-dark); }
.btn-ghost {
  background: none;
  color: var(--text-dim);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 13px 24px;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
}
.btn-ghost:hover { border-color: var(--blue); color: var(--blue); }

/* For use on dark/blue backgrounds: */
.btn-white {
  background: #ffffff;
  color: var(--blue-dark);
  font-size: 13px;
  font-weight: 700;
  padding: 13px 28px;
  border: none;
  border-radius: var(--radius);
  cursor: pointer;
}
.btn-outline-white {
  background: none;
  color: rgba(255,255,255,0.85);
  font-size: 13px;
  font-weight: 600;
  padding: 13px 24px;
  border: 1.5px solid rgba(255,255,255,0.35);
  border-radius: var(--radius);
  cursor: pointer;
}
```

## Slide/section structure (for full-viewport sections)
```css
.slide {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  padding: 80px;
  background: var(--bg);
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 0.3s ease, transform 0.3s ease;
  pointer-events: none;
}
.slide.active { opacity: 1; transform: translateY(0); pointer-events: all; }
.slide.exit-left { opacity: 0; transform: translateY(-20px); }

/* Decorative top rule on every slide */
.slide::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--blue) 0%, var(--blue-bright) 50%, transparent 100%);
  opacity: 0.2;
}
```

## Salesforce product suite colors (for product pills/dots)
```
Sales Cloud:      #0176d3
Service Cloud:    #00a1e0
Marketing Cloud:  #ff9a3c
Data Cloud:       #00b5cc
Agentforce:       #7c3aed
Commerce Cloud:   #1db954
Health Cloud:     #e44c65
MuleSoft:         #ffa500
```

## Common mistakes to avoid
- No emojis — use real logos, CSS shapes, or SVG icons only
- No dark backgrounds — light mode only, enterprise credibility requires it
- No rounded pill buttons — `border-radius: 4px` is the Salesforce standard, not rounded
- No playful gradients on body text or headlines — clean, flat type only
- No over-engineered visual effects — clean, trustworthy, and spacious is the goal
