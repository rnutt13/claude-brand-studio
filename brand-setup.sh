#!/usr/bin/env bash
set -euo pipefail

TOOL_VERSION=$(cat "$(dirname "$0")/VERSION" 2>/dev/null || echo "unknown")
UPSTREAM="https://raw.githubusercontent.com/rnutt13/claude-brand-studio/main"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

usage() {
  cat <<EOF
Claude Brand Studio v${TOOL_VERSION}

USAGE
  ./brand-setup.sh                          Set up a new brand (interactive)
  ./brand-setup.sh --publish <slug>         Publish a brand to a new GitHub repo
  ./brand-setup.sh --install <github-url>   Install a brand from a GitHub repo
  ./brand-setup.sh --update                 Update tool files (leaves your brands untouched)
  ./brand-setup.sh --version                Print version

EXAMPLES
  ./brand-setup.sh
  ./brand-setup.sh --publish stripe
  ./brand-setup.sh --install https://github.com/jane/claude-wd-stripe
  ./brand-setup.sh --update
EOF
}

cmd_version() {
  echo "Claude Brand Studio v${TOOL_VERSION}"
}

cmd_update() {
  echo "Checking for updates from upstream..."

  TOOL_FILES=(
    "brand-setup.sh"
    "VERSION"
    "CLAUDE.md"
    "AGENTS.md"
    "components/library.html"
    ".claude/commands/brand-setup.md"
    ".claude/commands/brand-refine.md"
    "docs/reference/dark-brand-example.md"
  )

  updated=0
  for f in "${TOOL_FILES[@]}"; do
    encoded="${f// /%20}"
    tmp=$(mktemp)
    if curl -fsSL "${UPSTREAM}/${encoded}" -o "$tmp" 2>/dev/null; then
      mkdir -p "${SCRIPT_DIR}/$(dirname "$f")"
      if ! cmp -s "$tmp" "${SCRIPT_DIR}/${f}" 2>/dev/null; then
        cp "$tmp" "${SCRIPT_DIR}/${f}"
        echo "  Updated: ${f}"
        updated=$((updated + 1))
      fi
    fi
    rm -f "$tmp"
  done
  chmod +x "${SCRIPT_DIR}/brand-setup.sh"

  if [ "$updated" -eq 0 ]; then
    echo "  Already up to date."
  else
    echo "  ${updated} file(s) updated."
  fi
  echo ""
  echo "Your brand directories and presentations were not touched."
}

cmd_publish() {
  local slug="${1:-}"
  if [ -z "$slug" ]; then
    echo "Error: provide a brand slug. Example: ./brand-setup.sh --publish stripe"
    exit 1
  fi

  local brand_file="${SCRIPT_DIR}/brands/${slug}/CLAUDE.md"
  local demo_file="${SCRIPT_DIR}/brands/${slug}/brand-demo.html"

  if [ ! -f "$brand_file" ]; then
    echo "Error: brand file not found at ${brand_file}"
    echo "Run ./brand-setup.sh first to create the ${slug} brand."
    exit 1
  fi

  local repo_name="claude-wd-${slug}"
  echo "Publishing brand '${slug}' to GitHub repo '${repo_name}'..."

  tmp_dir=$(mktemp -d)
  trap 'rm -rf "$tmp_dir"' EXIT

  git -C "$tmp_dir" init -q
  git -C "$tmp_dir" checkout -q -b main

  mkdir -p "${tmp_dir}/brands/${slug}"
  cp "$brand_file" "${tmp_dir}/brands/${slug}/CLAUDE.md"

  if [ -f "$demo_file" ]; then
    cp "$demo_file" "${tmp_dir}/brands/${slug}/brand-demo.html"
  fi

  cat > "${tmp_dir}/README.md" <<INNER
# claude-wd-${slug}

A brand profile for [Claude Brand Studio](https://github.com/rnutt13/claude-brand-studio).

## Install

From inside your Claude Brand Studio directory:

\`\`\`bash
./brand-setup.sh --install https://github.com/$(gh api user --jq .login 2>/dev/null || echo "YOUR_USERNAME")/${repo_name}
\`\`\`

This drops the brand directory into \`brands/${slug}/\` so you can use it by running \`cd brands/${slug} && claude\`.
INNER

  git -C "$tmp_dir" add -A
  git -C "$tmp_dir" commit -q -m "add ${slug} brand"

  if gh repo create "${repo_name}" --public --source="$tmp_dir" --remote=origin --push 2>&1; then
    echo ""
    echo "Published: https://github.com/$(gh api user --jq .login 2>/dev/null || echo "YOUR_USERNAME")/${repo_name}"
    echo ""
    echo "Teammates can install it with:"
    echo "  ./brand-setup.sh --install https://github.com/$(gh api user --jq .login 2>/dev/null || echo "YOUR_USERNAME")/${repo_name}"
  else
    echo "Error: could not create GitHub repo. Make sure the GitHub CLI is authenticated."
    exit 1
  fi
}

cmd_install() {
  local url="${1:-}"
  if [ -z "$url" ]; then
    echo "Error: provide a GitHub repo URL. Example: ./brand-setup.sh --install https://github.com/jane/claude-wd-stripe"
    exit 1
  fi

  echo "Fetching brand from ${url}..."

  tmp_dir=$(mktemp -d)
  trap 'rm -rf "$tmp_dir"' EXIT

  if ! git clone --quiet --depth 1 "$url" "$tmp_dir" 2>/dev/null; then
    echo "Error: could not clone ${url}"
    echo "Check the URL and ensure the repo is public."
    exit 1
  fi

  installed=0
  # Find brand directories: subdirectories of brands/ that contain a CLAUDE.md
  while IFS= read -r -d '' brand_dir; do
    slug=$(basename "$brand_dir")
    dest="${SCRIPT_DIR}/brands/${slug}"

    if [ -d "$dest" ]; then
      echo "  Skipped: brands/${slug} (already exists — delete it first to reinstall)"
    else
      mkdir -p "${SCRIPT_DIR}/brands"
      cp -r "$brand_dir" "$dest"
      echo "  Installed: brands/${slug}"
      installed=$((installed + 1))
    fi
  done < <(find "${tmp_dir}/brands" -maxdepth 1 -mindepth 1 -type d -print0 2>/dev/null)

  # Merge assets (fonts, brand-specific logos) without overwriting existing files
  if [ -d "${tmp_dir}/assets" ]; then
    cp -rn "${tmp_dir}/assets/." "${SCRIPT_DIR}/assets/"
    echo "  Merged: assets/"
  fi

  if [ "$installed" -eq 0 ]; then
    echo "  No new brand directories found."
  else
    echo ""
    slug=$(find "${tmp_dir}/brands" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | head -1 | xargs basename)
    echo "Brand ready. To start building:"
    echo "  cd brands/${slug}"
    echo "  claude"
  fi
}

cmd_setup() {
  echo ""
  echo "=== Claude Brand Studio v${TOOL_VERSION} — New Brand Setup ==="
  echo ""
  read -r -p "Company URL (e.g. https://stripe.com): " URL

  if [ -z "$URL" ]; then
    echo "Error: a company URL is required."
    exit 1
  fi

  read -r -p "One adjective for your brand vibe — press Enter to skip: " VIBE
  read -r -p "Path to your logo file — press Enter to skip: " LOGO

  PROMPT="/brand-setup url=\"${URL}\""
  [ -n "$VIBE" ] && PROMPT="${PROMPT} vibe=\"${VIBE}\""
  [ -n "$LOGO" ] && PROMPT="${PROMPT} logo=\"${LOGO}\""

  echo ""
  echo "Opening Claude Code to set up your brand."
  echo "After setup completes, Claude will tell you which directory to work from."
  echo ""

  claude "${PROMPT}"
}

# ── Router ─────────────────────────────────────────────────────────────────────
case "${1:-}" in
  --version|-v)     cmd_version ;;
  --update)         cmd_update ;;
  --publish)        cmd_publish "${2:-}" ;;
  --install)        cmd_install "${2:-}" ;;
  --help|-h)        usage ;;
  "")               cmd_setup ;;
  *)                echo "Unknown option: ${1}"; echo ""; usage; exit 1 ;;
esac
