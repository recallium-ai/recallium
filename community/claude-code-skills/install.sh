#!/bin/bash
# Recallium Skill Installer for Claude Code (Mac/Linux)
# This script installs the Recallium usage skill globally

set -e

SKILL_DIR="$HOME/.claude/skills/recallium-guidance"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
SKILL_LINE='@~/.claude/skills/recallium-guidance/SKILL.md'
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Recallium skill for Claude Code..."

# Create skills directory
mkdir -p "$SKILL_DIR"

# Copy skill file
cp "$SCRIPT_DIR/SKILL.md" "$SKILL_DIR/SKILL.md"
echo "✓ Skill copied to $SKILL_DIR"

# Create CLAUDE.md if it doesn't exist
touch "$CLAUDE_MD"

# Add skill reference if not already present
if grep -qxF "$SKILL_LINE" "$CLAUDE_MD" 2>/dev/null; then
    echo "✓ Skill already registered in $CLAUDE_MD"
else
    echo "$SKILL_LINE" >> "$CLAUDE_MD"
    echo "✓ Skill registered in $CLAUDE_MD"
fi

echo ""
echo "Installation complete!"
echo "The Recallium skill will now load automatically in all Claude Code sessions."
echo ""
echo "To verify, start a new Claude Code session - it should:"
echo "  1. Know all Recallium tools and best practices"
echo "  2. Call recallium() at session start"
echo "  3. Follow global rules automatically"
