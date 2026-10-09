![Recallium: institutional engineering memory for humans and AI coding agents](images/recallium-banner.png)

# Recallium

**Institutional engineering memory for humans and AI agents.**

Your code remembers what changed. Recallium remembers why.

[![Website](https://img.shields.io/badge/recallium.ai-website-0a7cff)](https://recallium.ai)
[![Docs](https://img.shields.io/badge/docs.recallium.ai-documentation-0a7cff)](https://docs.recallium.ai)
[![npm](https://img.shields.io/npm/v/recallium?label=npx%20recallium)](https://www.npmjs.com/package/recallium)
[![MCP](https://img.shields.io/badge/MCP-server-purple)](https://modelcontextprotocol.io)
[![LongMemEval-S](https://img.shields.io/badge/LongMemEval--S-99.8%25%20hit%4010-2ea44f)](https://recallium.ai/benchmarks)
[![License](https://img.shields.io/badge/community%20edition-ELv2-orange)](LICENSE)

---

Recallium is memory for the agents that do software development, such as Claude Code, Codex, Cursor, GitHub Copilot, Devin and Cline, and for the engineers who work beside them. It is served over the Model Context Protocol (MCP), so every coding tool on the team is a client of the same memory.

While an agent designs, decides, builds, debugs and ships, Recallium keeps the record it produces: the decision and the options rejected, the root cause and the fix, the constraint that drove a change, the rules the team follows, and where an effort stands. When a later session, another tool or a teammate's agent touches the same code, Recallium finds what the team already settled and feeds it to the agent before it starts. When one decision replaces another, agents follow the current one.

Teams also call this memory for development agents, developer agents, AI coding assistants or AI software engineering agents. All of those mean the agents that do the development work. Recallium is **not** a memory API for the end users of the product you ship; it is memory for the team that ships it.

## Get started

Recallium Cloud is the managed service. One command connects every coding agent on the machine:

```bash
npx -y recallium install
```

It needs Node.js 22 or later. It detects the installed agents, signs you in once, shows its plan and writes nothing until you confirm. In every client the MCP server is named `recallium`, and the project name is derived from the Git repository.

```bash
npx -y recallium status           # check the connection
npx -y recallium doctor           # fix one
npx -y recallium uninstall        # remove it from one client
npx -y recallium uninstall --all  # remove it from every client
```

Then open a Git repository in your coding agent and ask, for example: *"What decisions and open tasks should I know about before I change the authentication flow?"*

Recallium Cloud is in a closed pilot. Join the waitlist at [recallium.ai/waitlist](https://recallium.ai/waitlist); pilot code holders join at [app.recallium.ai/pilot/join](https://app.recallium.ai/pilot/join). Quickstart and per-client guides: [docs.recallium.ai](https://docs.recallium.ai/quickstart).

## Memory across the software lifecycle

| Stage | What Recallium keeps | How agents use it |
|---|---|---|
| Plan and design | The approach the team chose and why | An agent proposing a change sees what was already decided and why |
| Build | What the team learned about the code, linked to the files it is about | Before an edit, search by topic and by file path |
| Review | Team rules | Rules load into every agent session, in every connected tool |
| Debug and incidents | The root cause, the fix, and the steps that worked | The next agent that hits the symptom finds the cause on the first search |
| Commit | `Recallium-Memory:` commit trailers | A commit links to the memories that explain it |
| Handoff | Workstreams, working state, session recap, tasks | A new session, agent or teammate resumes where the last one stopped |
| Reference | Uploaded documents | Specs and other files are searched alongside memories |

## What your agent can do

Every capability is an MCP tool the agent calls on its own, following the guidance the installer ships.

![The recallium MCP server's tools listed in Claude Desktop's connector settings: Get Insights, Expand Memories, Get Workstream, Search Memories, Get Rules, Session Recap and more](images/recallium-tools-in-claude-desktop.jpg)
*The same tools in every client: here, the `recallium` connector in Claude Desktop.*

**Start a session informed.** `recallium` loads the project in one call: session recap, working state, rules, active workstreams and open tasks. `session_recap` alone gives recent activity.

**Keep the record as the work lands.** `store_memory` saves a design before the first edit it plans, a decision when it is made, a root cause before the fix, a finished state after a commit. Each memory carries the files it is about and its relationships: what it relates to, what it constrains, what it replaces. `modify_memory` corrects or retires one without deleting history.

**Search before re-deriving.** `search_memories` finds by intent, by file path, by tag and by exact identifier such as a commit SHA; `expand_memories` opens only the results the agent needs, so it reads a few precise results instead of whole files.

**Carry an effort across sessions.** `create_workstream` and `get_workstream` group the memories of one feature or branch and show its journey: constraints and decisions first, then designs, learnings and progress. `set_working_state` and `get_working_state` hold where the work stands between sessions.

**Track work.** `create_task`, `update_task`, `list_tasks` and `get_task` keep tasks tied to the memories that close them.

**Follow the team's rules.** `store_rule` and `get_rules` serve standing rules, global or per project, into every agent session in every tool.

**Judge and reason.** `store_verdict` records one agent's judgment of another's output. `start_thinking` and `add_thought` keep a structured reasoning sequence whose conclusion becomes a decision.

**Bring documents in.** Upload specs and other files and search them with the same tools.

**See patterns.** On Recallium Cloud, `get_insights` surfaces recurring approaches, recurring bugs with their causes and fixes, technical debt and how an effort moved over time.

**Work across repositories and teams.** `link_projects` connects related projects; teams, projects and role-based access are managed on Recallium Cloud, with `list_team_members` and `team_recap` on enterprise plans.

Full tool reference: [docs.recallium.ai](https://docs.recallium.ai).

## How it works

1. **Work normally.** Agents capture memories as the work lands: a design before the first edit it plans, a decision when it is made, a root cause before the fix.
2. **Memories are linked to the work.** Each one carries the files it is about, its workstream, and what it relates to, including which earlier call it replaces.
3. **Search before re-deriving.** Agents search by intent and by file path, then expand only the results they need.
4. **Share by repository.** On Cloud Pro, the memory of a repository your team connects is read and written by every teammate's agent; a repository only you connect stays yours. On Cloud Free nothing is shared.
5. **Resume anywhere.** Workstreams, working state and session recap carry an effort across sessions, tools and people.

## Where it helps

- **The incident at 2am.** The root cause and the fix from the last time this symptom appeared are the first search result, not a Slack archaeology dig.
- **Handing off a half-finished migration.** The workstream carries the constraints, the decisions and the working state to whoever picks it up, in whichever tool they use.
- **The decision that was already replaced.** Agents follow the current decision, not the one in a stale comment, because the new one supersedes the old one in memory.
- **Onboarding a new engineer.** Their agent starts from what the team knows about the codebase on day one.
- **When a senior engineer leaves.** What they worked out stays with the project.
- **Three tools, one memory.** Research in Claude Desktop, build in Cursor, review in Claude Code, with one record across all three.
- **Conventions that hold without reminders.** Team rules are loaded into every session, so reviewers stop repeating themselves.
- **The security review.** Every decision has a date, an author, its files and its reasons.

More on each: [recallium.ai/use-cases](https://recallium.ai/use-cases) and [how we build Recallium with Recallium](https://recallium.ai/how-we-build-recallium).

## Supported coding agents and IDEs

The installer connects, depending on the operating system: Claude Code, Codex CLI and Codex Work, Cursor, GitHub Copilot, VS Code, Claude Desktop, Devin Desktop, Cline, Zed, OpenCode, Kilo Code, Qwen Code, Droid (Factory), Antigravity, Hermes Agent and DeepSeek dsh. Continue.dev connects by manual setup. Any other MCP client can connect to the same endpoint; 60+ MCP clients are supported. Per-client guides: [docs.recallium.ai/guides/supported-clients](https://docs.recallium.ai/guides/supported-clients).

## Rules files and Recallium

CLAUDE.md, AGENTS.md, Cursor Rules and Copilot instructions hold standing instructions that one tool loads at the start of a session. They are the right place for those. Recallium holds what the team has learned since: the record agents produce while they work, searched on demand and shared across every tool and teammate. Keep both.

## Retrieval

On LongMemEval-S, all 500 questions including abstention, Recallium finds the right memory for 499 (99.8% hit@10) and returns 98.6% of relevant sessions, from 3.8 results per question on average. Answer accuracy is 98.4% with a Claude Opus 5.5 reader and 90.2% with the official GPT-4o reader, under the official GPT-4o judge. Reader, judge, depth and dates are published at [recallium.ai/benchmarks](https://recallium.ai/benchmarks). Other vendors' reports use different readers, judges and depths, so they are not a controlled head-to-head ranking.

## Privacy and security

Recallium does not train AI models on customer memories and does not sell customer data. Tenants are isolated by row-level security; data is encrypted in transit and at rest on Google Cloud. Sharing follows the repository: a repository only you connect stays yours. A Data Processing Addendum and an availability policy are published. Details: [recallium.ai/security](https://recallium.ai/security), [privacy policy](https://recallium.ai/privacy), [DPA](https://recallium.ai/dpa).

## Pricing

Cloud Free: 500 memories a month until December 2026, nothing to run. Cloud Pro: shared team memory, 5,000 memories a month, priced per engineer. [recallium.ai/pricing](https://recallium.ai/pricing).

## FAQ

### What is Recallium?
Institutional engineering memory for humans and AI agents. Decisions, root causes, fixes, constraints and rules captured in one session, in Claude Code, Codex, Cursor, GitHub Copilot or another MCP client, are recalled by every agent and teammate on the project in the next.

### How do I add memory to Claude Code, Codex or Cursor?
Run `npx -y recallium install`. It detects the agents on your machine, signs you in once and connects each one.

### How is Recallium different from CLAUDE.md or Cursor Rules?
Rules files are instructions one tool loads at the start of a session. Recallium is the record agents produce while they work, searched on demand and shared across tools and teammates. Most teams keep both.

### How is Recallium different from Mem0 or Supermemory?
Mem0 and Supermemory are memory APIs you build into an AI product so it remembers its users; both also ship Claude Code and Cursor plugins. Recallium is memory for the team building the product: it follows how engineering teams work, from design and decisions through debugging and shipping, with workstreams for handoffs, team rules in every session, commits linked to the memories behind them, and teams and role-based access on Recallium Cloud. The long form: [Serving Memory vs. Engineering Memory](https://recallium.ai/blog/serving-memory-vs-engineering-memory).

### What is an MCP memory server?
The Model Context Protocol is an open standard for connecting AI agents to tools and data. Recallium is an MCP server for team memory: one endpoint every connected agent reads and writes.

### Can my team see my personal projects?
No. Sharing follows the repository. A repository your team connects on Cloud Pro is shared with the team; a repository only you connect stays yours. On Cloud Free nothing is shared.

### Is there a self-hosted version?
Yes. The community edition in [`community/`](community/) runs on Docker on your own machine or network, free under the Elastic License v2.

### Is Recallium the same as MiniMe MCP?
Yes. Recallium was called MiniMe MCP (also written MiniMe-MCP) from August 2025 until it was renamed.

## Self-hosted community edition

The [`community/`](community/) directory holds the self-hosted community edition: a Docker deployment, its [installation guide](community/install/README.md), the Claude Code skill and the Claude Desktop extension. It is free under the [Elastic License v2](LICENSE) and runs on your own machine or network. Recallium Cloud is the managed service and carries the team features above.

## Links

| | |
|---|---|
| Website | [recallium.ai](https://recallium.ai) |
| Why Recallium | [recallium.ai/why-recallium](https://recallium.ai/why-recallium) |
| Memory for coding agents | [recallium.ai/memory-for-coding-agents](https://recallium.ai/memory-for-coding-agents) |
| Docs | [docs.recallium.ai](https://docs.recallium.ai) |
| Pricing | [recallium.ai/pricing](https://recallium.ai/pricing) |
| Changelog | [recallium.ai/changelog](https://recallium.ai/changelog) |
| Community | [Discord](https://discord.gg/sbc2SFBfzd) · [r/recallium](https://www.reddit.com/r/recallium/) · [X](https://x.com/recallium) |
| Issues | [GitHub Issues](https://github.com/recallium-ai/recallium/issues) |
| Support | support@recallium.ai |

## License

The community edition in `community/` is licensed under the [Elastic License v2](LICENSE): free to use and self-host; you may not offer it as a hosted service to third parties. Recallium Cloud is provided under its [terms of service](https://recallium.ai/terms).
