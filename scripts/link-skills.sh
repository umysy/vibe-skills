#!/usr/bin/env bash
# Links every skill folder in this repo into the harness skill directories (macOS / Linux).
# Re-run after adding, removing, or renaming a skill.
# An existing real folder with the same name is left alone and reported, never overwritten.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
targets=("$HOME/.agents/skills" "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills")

for target in "${targets[@]}"; do
  mkdir -p "$target"
  for skill in "$root"/*/; do
    skill="${skill%/}"
    [ -f "$skill/SKILL.md" ] || continue
    link="$target/$(basename "$skill")"
    if [ -e "$link" ] && [ ! -L "$link" ]; then
      echo "warning: skipped $link: a real folder already exists there." >&2
      continue
    fi
    if [ -L "$link" ]; then
      if [ "$(cd "$link" 2>/dev/null && pwd -P)" = "$(cd "$skill" && pwd -P)" ]; then
        echo "Already linked $link"
        continue
      fi
      echo "warning: replacing $link (was -> $(readlink "$link"))" >&2
      rm "$link"
    fi
    ln -s "$skill" "$link"
    echo "Linked $link -> $skill"
  done
done
