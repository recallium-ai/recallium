---
name: recallium-guidance
description: Use when you have access to Recallium MCP tools. Provides guidance on memory storage, search, and knowledge management. CRITICAL - invoke the MCP tool `recallium` at session start, store memories after EVERY substantive interaction, and honor global rules.
---

# Recallium Usage Guide

## MANDATORY: Session Startup

**ALWAYS start EVERY session by invoking the Recallium MCP tool `recallium`:**

```
Invoke the MCP tool: recallium(project_name="current-project")
```

**IMPORTANT:**
- Call the **MCP tool** named `recallium`, NOT the Skill tool
- Do NOT use `Skill(skill="recallium")` - that loads this guide
- The MCP tool actually loads your project context, rules, and recent work

This is NON-NEGOTIABLE. Do this BEFORE any other action. It loads:
- Global rules (you MUST follow these)
- Project-specific rules
- Recent activity and context
- Pending tasks
- Project briefs/PRDs

## MANDATORY: Honor Global Rules

**After loading rules, you MUST follow them. No exceptions.**

Global rules include critical behaviors like:
- **Always fix root cause first** - never patch data without fixing code
- **Proactively store memories** - don't wait for user to ask
- **Confirm destructive operations** - always ask before deleting/force-pushing
- **Never implement fallbacks without asking** - if requested approach fails, STOP and ask
- **Use projects tool for formal docs** - briefs, PRDs, plans go in projects, not memories

**Violating global rules is a critical failure.** Read them. Follow them.

## Core Philosophy

**You are the user's memory system. Context not stored is permanently lost.**

Recallium gives you persistent memory across sessions. Every decision, learning, code change, and conversation insight should be captured. Store 10x more than you think necessary.

## The Golden Rules

```
1. ALWAYS INVOKE THE RECALLIUM MCP TOOL AT SESSION START (not the Skill)
2. ALWAYS FOLLOW LOADED RULES
3. STORE MEMORIES, NOT DOCUMENTS
4. STORE CONSTANTLY - DON'T WAIT TO BE ASKED
```

**Memories** = Your observations, decisions, learnings, implementations, designs, artifacts
**Documents** = User-uploaded PDFs, specs, reference files (NOT for agent storage)

### What Goes in Memories (ALWAYS)

| Content | Memory Type |
|---------|-------------|
| Implementation details | `feature`, `code-snippet` |
| Design decisions & architecture | `design`, `decision` |
| Artifacts you create | `design`, `feature` |
| Debugging & fixes | `debug` |
| Learnings & research | `learning`, `research` |
| Progress & milestones | `progress` |

**⚠️ RULES ARE SPECIAL** - See "Rules" section below. Never store rules proactively.

### What NEVER Goes in store_memory

| Content | Use Instead |
|---------|-------------|
| User-uploaded PDFs | Document upload |
| External specs/references | Document upload |
| Large reference files | Document upload |

**You store YOUR work. User uploads THEIR files.**

## Memory Storage (CRITICAL)

### When to Store (Triggers)

Store memory **immediately** after:

| Trigger | Memory Type |
|---------|-------------|
| Completed feature/capability | `feature` |
| Wrote focused code/utility | `code-snippet` |
| Fixed bug/investigated issue | `debug` |
| Designed architecture/APIs | `design` |
| Made choice with rationale | `decision` |
| Discovered insight/aha moment | `learning` |
| Gathered external info | `research` |
| Had meeting/conversation | `discussion` |
| Hit milestone/checkpoint | `progress` |
| Created TODO/action item | `task` |

**⚠️ Note:** `rule` is NOT in this list. Rules require explicit user request.

### Memory Types Decision Tree

```
Is it shippable, release-note worthy? → feature
Fixed a bug? → debug
Wrote focused code? → code-snippet
Made a choice with reasoning? → decision
Learned something new? → learning
None of above → working-notes
```

**Note:** `rule` is NOT in this tree. Only store rules when user explicitly asks.

### What to Include

**ALWAYS include:**
- `content`: What happened, decided, learned (detailed)
- `project_name`: Lowercase kebab-case
- `related_files`: Files you read/edited (CRITICAL for code work)

**Include when relevant:**
- `tags`: Custom tags for discoverability
- `importance_score`: 0.9 critical, 0.7 important, 0.5 normal, 0.3 minor

### Example: Good Memory

```python
store_memory(
    content="""
    ## Fixed: Authentication Token Refresh Race Condition

    **Problem:** Multiple concurrent API calls triggered simultaneous token refreshes,
    causing 401 errors when the first refresh invalidated tokens used by in-flight requests.

    **Solution:** Implemented token refresh mutex with request queuing. Pending requests
    wait for refresh completion rather than triggering their own refresh.

    **Files changed:**
    - src/auth/token-manager.ts: Added refreshMutex and pendingRefresh promise
    - src/api/client.ts: Modified interceptor to await pending refresh

    **Testing:** Added concurrent request test, verified single refresh per cycle.
    """,
    project_name="my-api",
    memory_type="debug",
    related_files=["src/auth/token-manager.ts", "src/api/client.ts"],
    tags=["authentication", "race-condition", "token-refresh"],
    importance_score=0.8
)
```

### Anti-Pattern: Bad Memory

```python
# ❌ TOO VAGUE
store_memory(content="Fixed auth bug", project_name="my-api")

# ❌ NO RELATED FILES
store_memory(content="Updated token refresh logic", project_name="my-api")

# ❌ WRONG TYPE - this is a decision, not working-notes
store_memory(content="Decided to use Redis for session storage because...",
             memory_type="working-notes")
```

## Searching Memories

### Search Modes

| Mode | Use When |
|------|----------|
| `semantic` (default) | Concepts, questions, fuzzy matching |
| `keyword` | Exact terms, function names, error codes |

### Search Targets

| Target | Use When |
|--------|----------|
| `memories` (default) | Your notes, decisions, learnings |
| `documents` | Uploaded PDFs, specs |
| `all` | Search everything |

### Effective Searches

```python
# Conceptual search
search_memories(query="how do we handle authentication errors")

# Exact term search
search_memories(query="handleAuthCallback", search_mode="keyword")

# File-based search (find all context about a file)
search_memories(query="authentication", file_path="%auth.ts%")

# Recent only
search_memories(query="token refresh", recent_only=True)
```

### After Searching

Use `expand_memories(memory_ids=[...])` to get full content of relevant results.

## Getting Insights

### Analysis Types

| Type | Use For |
|------|---------|
| `comprehensive` | Full overview, topic exploration |
| `patterns` | Recurring approaches, technologies |
| `quality` | Bug patterns, root causes |
| `technical_debt` | Cleanup candidates, refactoring needs |
| `learning` | Knowledge evolution, growth |
| `productivity` | Activity trends, focus areas |
| `progress` | Milestones, project momentum |

### Topic Filtering

```python
# Find clusters related to a topic
get_insights(analysis_type="comprehensive", topic="authentication")

# Quality issues in a specific project
get_insights(analysis_type="quality", project_name="my-api")
```

## Projects

### When to Use Projects Tool

| Action | Command |
|--------|---------|
| List all projects | `projects(action="list_all")` |
| Create project brief | `projects(action="create", project_name="x", content="...")` |
| Create PRD | `projects(action="create", project_name="x", doc_type="prd", content="...")` |
| Create implementation plan | `projects(action="create", project_name="x", doc_type="plan", content="...")` |
| Get project docs | `projects(action="get", project_name="x")` |

### Project Briefs vs Memories

| Content | Use |
|---------|-----|
| High-level goals, scope, stakeholders | Project brief |
| Detailed requirements, user stories | PRD |
| Implementation roadmap, phases | Plan |
| Day-to-day decisions, learnings | `store_memory` |

## Tasks

### Task Lifecycle

```python
# Create task
tasks(action="create", project_name="x", task_description="Implement user auth")

# List pending tasks
tasks(action="get", project_name="x")

# Complete task(s)
tasks(action="complete", project_name="x", task_ids=["123", "456"])

# Link memories to task
tasks(action="link_memories", project_name="x", task_ids="123", memory_ids=[100, 101])
```

**Only create tasks when user explicitly requests them.** Don't proactively create tasks.

## Thinking Sequences

For complex decisions requiring structured reasoning:

```python
# Start thinking
result = start_thinking(goal="Design auth system for mobile app", project_name="x")
sequence_id = result.sequence_id

# Add thoughts
add_thought(sequence_id=sequence_id, thought="Option 1: JWT with refresh tokens...", thought_type="hypothesis")
add_thought(sequence_id=sequence_id, thought="JWT better for stateless APIs...", thought_type="reasoning")
add_thought(sequence_id=sequence_id, thought="Choosing JWT with 15min access, 7d refresh", thought_type="conclusion")
# conclusion auto-stores as decision memory
```

## Rules

**⚠️ RULES ARE DIFFERENT FROM OTHER MEMORIES**

### The Rule About Rules

1. **NEVER store rules proactively** - unlike other memory types
2. **NEVER re-store rules you just loaded** - they already exist!
3. **ONLY store rules when user EXPLICITLY asks:**
   - "Remember this rule"
   - "Always do X from now on"
   - "Add a rule that..."
   - "Store this as a guideline"

### Getting Rules

```python
# Get project + global rules
get_rules(project_name="my-project")

# Global rules only
get_rules(project_name="__global__")
```

**After loading rules:** Follow them. Do NOT re-store them.

### Storing Rules (ONLY when user asks)

```python
# ONLY do this when user explicitly requests a new rule
store_memory(
    content="Always use uv instead of pip for Python dependency management",
    project_name="__global__",  # or specific project
    memory_type="rule",
    importance_score=0.9
)
```

**Before storing:** Check existing rules! `get_rules(project_name="your-project")` returns both project AND global rules.

## Quick Reference

| Goal | Tool |
|------|------|
| Start session | MCP tool: `recallium(project_name="x")` |
| Save context | `store_memory(...)` |
| Find past work | `search_memories(query="...")` |
| View full memory | `expand_memories(memory_ids=[...])` |
| Analyze patterns | `get_insights(analysis_type="...")` |
| Manage project docs | `projects(action="...")` |
| Track tasks | `tasks(action="...")` |
| Complex reasoning | `start_thinking()` + `add_thought()` |
| Get guidelines | `get_rules(project_name="...")` |
| Session summary | `session_recap()` |

## Red Flags - STOP When You Think This

These thoughts mean you're rationalizing. STOP and follow the skill.

| Thought | Reality |
|---------|---------|
| "Let me answer this question first" | Invoke recallium BEFORE any response. No exceptions. |
| "I'll store a memory later" | Store NOW. Later never comes. Context is lost. |
| "This isn't worth storing" | Store it. You're not the judge of future value. |
| "The user said 'document this'" | Store a memory, NOT a file. User means "remember this". |
| "I should create a README" | NO. Store a memory. Only create files if explicitly requested. |
| "This is just a small change" | Small changes need memories too. Include related_files. |
| "I already explained it in chat" | Chat disappears. Store the memory. |
| "The code is self-documenting" | Code doesn't capture decisions, alternatives, or rationale. Store it. |
| "I'll remember this next session" | You won't. You have no memory without store_memory. |
| "This rule doesn't apply here" | It does. Rules are NON-NEGOTIABLE. Follow them. |
| "I'm being efficient by skipping storage" | You're being destructive. Future sessions will suffer. |
| "The user didn't ask me to store" | Users don't ask. YOU store proactively. That's your job. |
| "I should store this rule I just read" | NO! Rules from recallium/get_rules ALREADY EXIST. Never re-store. |
| "This seems like a good rule to add" | Rules are NOT proactive. Only store when user explicitly asks. |

**If you catch yourself thinking any of these: STOP. Follow the rules.**

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Skipping the MCP tool at start | ALWAYS invoke MCP tool `recallium` first - loads rules and context |
| Ignoring loaded rules | Rules are NON-NEGOTIABLE - follow them |
| Not storing memories | Store after EVERY substantive interaction |
| Vague content | Include problem, solution, files, reasoning |
| Missing related_files | Always include files you touched |
| Wrong memory_type | Use decision tree above |
| Storing docs as memories | Use document upload for PDFs/specs |
| Not checking existing rules | Call get_rules() before storing new rules (avoid duplicates) |
| **Re-storing loaded rules** | **Rules from recallium/get_rules ALREADY EXIST - never re-store!** |
| **Proactively storing rules** | **Rules require EXPLICIT user request - don't auto-create them** |

## The Iron Law

**Violating the letter of the rules IS violating the spirit of the rules.**

Don't rationalize. Don't find loopholes. Don't make exceptions.

The rules exist because past agents failed in predictable ways. You are not special. You will fail the same ways unless you follow the rules exactly.

## The Bottom Line

1. **Start every session** by invoking the MCP tool `recallium` - NO EXCEPTIONS
2. **Follow all loaded rules** - global rules are NON-NEGOTIABLE
3. **Store memories constantly** - after every decision, learning, code change
4. **Include related_files** for all code work
5. **Never store documents** - use document upload for user files
6. **Use memories for your artifacts** - implementations, designs, decisions
7. **Projects for formal docs** - briefs, PRDs, plans
8. **NEVER re-store rules you loaded** - they already exist!
9. **ONLY store rules when user explicitly asks** - rules are not proactive
