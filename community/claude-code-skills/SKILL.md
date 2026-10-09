---
name: recallium-guidance
description: Use when you have access to Recallium MCP tools. Provides guidance on memory storage, search, and knowledge management. CRITICAL - invoke the MCP tool `recallium` at session start, store memories after EVERY substantive interaction, and honor global rules.
---

# Recallium Usage Guide

## Session Startup (NON-NEGOTIABLE)

At session start, BEFORE any other action, invoke the **MCP tool** `recallium(project_name="<current-project>")`.

- Use the MCP tool, **not** `Skill(skill="recallium")` (that just loads this guide).
- It returns: global rules, project rules, recent activity, pending tasks, project briefs.
- After it returns, **follow the loaded rules**. They are not suggestions.

## Core Philosophy

You are the user's memory system. Context not stored is permanently lost. Store proactively — the user will not ask. Store ~10x more than feels necessary.

**Memories** = your work (decisions, code, designs, debugging, learnings).
**Documents** = user-uploaded files (PDFs, specs) — never store these via `store_memory`.

## When to Store (Triggers → Memory Type)

Store **immediately** after each of these:

| Trigger | `memory_type` |
|---------|---------------|
| Completed feature/capability | `feature` |
| Wrote focused code/utility | `code-snippet` |
| Fixed bug / investigated issue | `debug` |
| Designed architecture/APIs | `design` |
| Made choice with rationale | `decision` |
| Discovered insight | `learning` |
| Gathered external info | `research` |
| Meeting/conversation | `discussion` |
| Hit milestone/checkpoint | `progress` |
| Created TODO/action item | `task` |
| None of the above | `working-notes` |

`rule` is **not** in this list — see Rules section.

## What to Include

**Always:** `content` (detailed: problem, solution, reasoning), `project_name` (kebab-case), `related_files` (every file touched).
**When relevant:** `tags`, `importance_score` (0.9 critical, 0.7 important, 0.5 normal, 0.3 minor).

### Good memory shape

```python
store_memory(
    content="""
    ## Fixed: <short title>
    **Problem:** <what was broken / why>
    **Solution:** <what changed and why this approach>
    **Files:** <key files + what changed in each>
    **Testing:** <how verified>
    """,
    project_name="my-api",
    memory_type="debug",
    related_files=["src/auth/token-manager.ts", "src/api/client.ts"],
    tags=["authentication", "race-condition"],
    importance_score=0.8
)
```

Avoid: vague content, missing `related_files`, wrong `memory_type` (a decision is not `working-notes`).

## Searching

| Mode | Use When |
|------|----------|
| `semantic` (default) | Concepts, fuzzy matching |
| `keyword` | Exact terms, function names, error codes |

| Target | Use When |
|--------|----------|
| `memories` (default) | Your notes |
| `documents` | User-uploaded files |
| `all` | Everything |

```python
search_memories(query="how do we handle auth errors")               # conceptual
search_memories(query="handleAuthCallback", search_mode="keyword")  # exact
search_memories(query="auth", file_path="%auth.ts%")                # by file
search_memories(query="token refresh", recent_only=True)            # recent
```

After searching, use `expand_memories(memory_ids=[...])` for full content.

## Insights

```python
get_insights(analysis_type="comprehensive", topic="authentication")
```

Analysis types: `comprehensive`, `patterns`, `quality`, `technical_debt`, `learning`, `productivity`, `progress`.

## Projects vs Memories

| Content | Use |
|---------|-----|
| Goals, scope, stakeholders | `projects` (BRIEF) |
| Requirements, user stories | `projects` (PRD) |
| Roadmap, phases | `projects` (PLAN) |
| Day-to-day decisions, learnings, code | `store_memory` |

```python
projects(action="list_all")
projects(action="create", project_name="x", doc_type="prd", content="...")
projects(action="get", project_name="x")
```

## Tasks

Only create tasks when the user explicitly requests them.

```python
tasks(action="create",   project_name="x", task_description="...")
tasks(action="get",      project_name="x")
tasks(action="complete", project_name="x", task_ids=["123"])
tasks(action="link_memories", project_name="x", task_ids="123", memory_ids=[100, 101])
```

## Thinking Sequences (for complex decisions)

```python
r = start_thinking(goal="Design auth for mobile app", project_name="x")
add_thought(sequence_id=r.sequence_id, thought="...", thought_type="hypothesis")
add_thought(sequence_id=r.sequence_id, thought="...", thought_type="reasoning")
add_thought(sequence_id=r.sequence_id, thought="...", thought_type="conclusion")
# `conclusion` auto-stores as a decision memory
```

## Rules (special — read carefully)

1. **Never store rules proactively.** Rules require an explicit user request ("remember this rule", "always do X from now on", "add a rule that…").
2. **Never re-store rules returned by `recallium` or `get_rules`** — they already exist.
3. Before storing a new rule, call `get_rules(project_name="...")` to avoid duplicates.

```python
get_rules(project_name="my-project")   # project + global
get_rules(project_name="__global__")   # global only

# Only when user explicitly asks:
store_memory(
    content="Always use uv instead of pip",
    project_name="__global__",
    memory_type="rule",
    importance_score=0.9
)
```

## Quick Reference

| Goal | Tool |
|------|------|
| Start session | `recallium(project_name="x")` |
| Save context | `store_memory(...)` |
| Find past work | `search_memories(query="...")` |
| View full memory | `expand_memories(memory_ids=[...])` |
| Analyze patterns | `get_insights(analysis_type="...")` |
| Project docs | `projects(action="...")` |
| Tasks | `tasks(action="...")` |
| Complex reasoning | `start_thinking()` + `add_thought()` |
| Get rules | `get_rules(project_name="...")` |
| Session summary | `session_recap()` |
