#!/usr/bin/env bash
set -euo pipefail

# Links all skills in the repository to ~/.claude/skills, so that
# they can be used by the local Claude CLI.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$HOME/.claude/skills"

# Portable replacement for `readlink -f` (which is GNU-only; BSD readlink on
# macOS has no `-f` flag and exits silently). Resolves a path one symlink hop
# at a time and returns its absolute canonical form, or empty if missing.
resolve_path() {
  local target="$1"
  # If the target doesn't exist at all, return empty (matches GNU readlink -f
  # behavior closely enough for the safety check below).
  [ -e "$target" ] || [ -L "$target" ] || { echo ""; return 0; }

  local dir base
  # Walk symlinks. Cap iterations so a cycle can't lock us up.
  local i=0
  while [ -L "$target" ] && [ "$i" -lt 40 ]; do
    local link
    link="$(readlink "$target")"
    case "$link" in
      /*) target="$link" ;;
      *)  target="$(dirname "$target")/$link" ;;
    esac
    i=$((i + 1))
  done

  dir="$(dirname "$target")"
  base="$(basename "$target")"
  # `cd ... && pwd -P` canonicalizes the parent directory portably.
  if cd "$dir" >/dev/null 2>&1; then
    printf '%s/%s\n' "$(pwd -P)" "$base"
  else
    echo ""
  fi
}

# If ~/.claude/skills is a symlink that resolves into this repo, we'd end up
# writing the per-skill symlinks back into the repo's own skills/ tree. Detect
# and bail out instead of polluting the working copy.
if [ -L "$DEST" ]; then
  resolved="$(resolve_path "$DEST")"
  case "$resolved" in
    "$REPO"|"$REPO"/*)
      echo "error: $DEST is a symlink into this repo ($resolved)." >&2
      echo "Remove it (rm \"$DEST\") and re-run; the script will recreate it as a real dir." >&2
      exit 1
      ;;
  esac
fi

mkdir -p "$DEST"

find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0 |
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  name="$(basename "$src")"
  target="$DEST/$name"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    rm -rf "$target"
  fi

  ln -sfn "$src" "$target"
  echo "linked $name -> $src"
done
