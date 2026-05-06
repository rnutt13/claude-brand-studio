> **Reference file for Claude — structural template only.**
> This shows how to structure a dark, technical brand. Do NOT copy these color values into a new brand.
> All colors, fonts, and motifs must be derived from the target company's website and user inputs.

---

## Brand personality (example — replace entirely)
Sharp, technical, performance-obsessed. This is a company that makes the hardware the world runs AI on. The aesthetic should feel like a GPU datasheet crossed with a concept car reveal — precision and power, nothing decorative that doesn't earn its place.

## Design tokens (structure to follow — values are examples only)
```css
:root {
  --accent: #76b900;             /* primary accent — derive from brand */
  --accent-dim: rgba(118, 185, 0, 0.15);
  --accent-glow: rgba(118, 185, 0, 0.4);
  --bg: #0a0a0a;                 /* near-black background */
  --bg-alt: #111111;
  --bg-card: #141414;
  --text: #ffffff;
  --text-dim: #b0b0b0;
  --text-muted: #555555;
  --border: #222222;
  --border-accent: #333333;
  --font: 'Inter', -apple-system, sans-serif;
  --radius: 0px;                 /* sharp corners — adjust to match brand */
}
```

## Typography pattern
- Google Font: derive from brand website (Inter is common for technical brands)
- Headlines: weight 800–900, tight letter-spacing (-0.02em to -0.03em)
- Body: weight 400, color `var(--text-dim)`
- Labels/eyebrows: weight 700, letter-spacing 0.15–0.2em, uppercase, color `var(--accent)`

## Key visual motifs (dark/technical pattern)
- **Sharp corners** — `border-radius: 0` on cards, buttons, inputs (or a small 2–4px if the brand uses it)
- **Accent lines** — 2–3px `border-top` or `border-left` in `var(--accent)` to mark active/featured elements
- **Accent glow** — `box-shadow: 0 0 24px var(--accent-glow)` on hover states and highlighted stats
- **Geometric clip-paths** — triangular cuts on section dividers: `clip-path: polygon(0 0, 100% 0, 100% 85%, 0 100%)`
- **Technical grid texture** — subtle `background-image: linear-gradient(var(--border) 1px, transparent 1px), linear-gradient(90deg, var(--border) 1px, transparent 1px)` at low opacity
- **Accent left-border rule** on active/featured cards: `border-left: 3px solid var(--accent)`

## Buttons
```css
.btn-primary {
  background: var(--accent);
  color: #000000;
  font-weight: 700;
  font-size: 13px;
  letter-spacing: 0.06em;
  padding: 12px 28px;
  border: none;
  border-radius: var(--radius);
  cursor: pointer;
  text-transform: uppercase;
}
.btn-ghost {
  background: none;
  color: var(--text-dim);
  border: 1px solid var(--border-accent);
  border-radius: var(--radius);
  padding: 12px 28px;
  font-weight: 600;
  font-size: 13px;
  letter-spacing: 0.04em;
}
.btn-ghost:hover { border-color: var(--accent); color: var(--text); }
```

## Slide/section structure (for full-viewport sections)
```css
.slide {
  width: 100vw;
  height: 100vh;
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
```

## Navigation JS (slide-mode files)
```js
const slides = document.querySelectorAll('.slide');
let current = 0;
function goTo(n) {
  slides[current].classList.remove('active');
  slides[current].classList.add('exit-left');
  setTimeout(() => slides[current].classList.remove('exit-left'), 350);
  current = n;
  slides[current].classList.add('active');
  document.getElementById('counter').textContent = `${current+1} / ${slides.length}`;
  document.getElementById('progress').style.width = `${((current+1)/slides.length)*100}%`;
  document.getElementById('prevBtn').disabled = current === 0;
  document.getElementById('nextBtn').disabled = current === slides.length - 1;
}
function navigate(dir) { const n = current+dir; if (n>=0 && n<slides.length) goTo(n); }
document.addEventListener('keydown', e => {
  if (e.key==='ArrowRight'||e.key==='ArrowDown') navigate(1);
  if (e.key==='ArrowLeft'||e.key==='ArrowUp') navigate(-1);
});
```

## Common mistakes to avoid (dark brands)
- No emojis — use real logos, CSS shapes, or SVG icons only
- Don't default to generic blue — derive the accent from the real brand
- No soft gradient backgrounds — use dark bg with geometric or textural elements
- Logo treatment: if logo has a white/light background, use `mix-blend-mode: screen` on dark bg
