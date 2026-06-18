#!/bin/bash
# sync.sh — Push all changes in the MAP folder to GitHub
# Usage: ./sync.sh "optional commit message"

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

# Check for changes
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  echo "✓ Nothing to sync — working tree is clean."
  exit 0
fi

# Stage all changes
git add -A

# Commit with message (default: timestamp)
MSG="${1:-Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')}"
git commit -m "$MSG"

# Push
git push origin master

echo "✓ Synced to https://github.com/VentureDock/MAP.git"
