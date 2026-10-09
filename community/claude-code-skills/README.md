# Recallium Skill for Claude Code

This skill teaches Claude Code how to effectively use Recallium MCP tools for persistent memory management.

## What It Does

Once installed, Claude Code will automatically:

- Call `recallium()` at the start of every session
- Follow all global rules loaded from your Recallium instance
- Store memories proactively (decisions, learnings, code changes)
- Use the correct memory types for different content
- Search effectively using semantic and keyword modes
- Use `projects` for formal docs, `store_memory` for working context

## Installation

### Mac / Linux

```bash
cd claude-code-skills
chmod +x install.sh
./install.sh
```

### Windows

```cmd
cd claude-code-skills
install.bat
```

## What Gets Installed

| File | Location |
|------|----------|
| `SKILL.md` | `~/.claude/skills/recallium-guidance/SKILL.md` |
| Reference | Added to `~/.claude/CLAUDE.md` |

**Why "recallium-guidance"?** The MCP tool is named `recallium`. This skill is named `recallium-guidance` to avoid confusion - the MCP tool loads context, this skill provides usage guidance.

## Verify Installation

Start a new Claude Code session. Claude should:

1. Know all Recallium tools and best practices
2. Automatically call `recallium(project_name="...")` at session start
3. Follow global rules without being reminded

## Uninstall

### Mac / Linux

```bash
rm -rf ~/.claude/skills/recallium-guidance
# Remove the @~/.claude/skills/recallium-guidance/SKILL.md line from ~/.claude/CLAUDE.md
```

### Windows

```cmd
rmdir /s /q "%USERPROFILE%\.claude\skills\recallium-guidance"
REM Manually edit %USERPROFILE%\.claude\CLAUDE.md to remove the skill line
```

## Skill Contents

The skill covers:

- **Session startup** - Always invoke `recallium()` first
- **Global rules** - Must follow rules loaded from Recallium
- **Memory storage** - When, what, and how to store
- **Memory types** - Decision tree for choosing the right type
- **Search** - Semantic vs keyword, targets, filters
- **Insights** - 7 analysis types, topic filtering
- **Projects** - Briefs, PRDs, plans
- **Tasks** - Lifecycle management
- **Thinking sequences** - Structured reasoning
- **Rules** - Getting and storing guidelines

## Requirements

- [Claude Code](https://claude.ai/code) CLI installed
- [Recallium](https://github.com/anthropics/recallium) MCP server running

## License

MIT - See main repository LICENSE file.
