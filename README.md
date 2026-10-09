# Recallium

**Institutional engineering memory for humans and AI agents.**

Your code remembers what changed. Recallium remembers why.

[![Website](https://img.shields.io/badge/recallium.ai-website-0a7cff)](https://recallium.ai)
[![Docs](https://img.shields.io/badge/docs.recallium.ai-documentation-0a7cff)](https://docs.recallium.ai)
[![npm](https://img.shields.io/npm/v/recallium?label=npx%20recallium)](https://www.npmjs.com/package/recallium)
[![MCP](https://img.shields.io/badge/MCP-server-purple)](https://modelcontextprotocol.io)
[![License](https://img.shields.io/badge/community%20edition-ELv2-orange)](LICENSE)

---

Recallium is memory for the agents that do software development, such as Claude Code, Codex, Cursor, GitHub Copilot, Devin and Cline, and for the engineers who work beside them. It is served over the Model Context Protocol, so every coding tool is a client of the same memory.

While an agent designs, decides, builds, debugs and ships, Recallium keeps the record it produces: the decision and the options rejected, the root cause and the fix, the constraint that drove a change, the rules the team follows, and where an effort stands. When a later session, another tool or a teammate's agent touches the same code, Recallium finds what the team already settled and feeds it to the agent before it starts. When one decision replaces another, agents follow the current one.

Teams also call this memory for development agents, developer agents, AI coding assistants or AI software engineering agents. All of those mean the agents that do the development work. Recallium is **not** a memory API for the end users of the product you ship; it is memory for the team that ships it.

## Get started

Recallium Cloud is the managed service. One command connects every coding agent on the machine:

```bash
npx -y recallium install
```

It needs Node.js 22 or later. It detects the installed agents, signs you in once, shows its plan and writes nothing until you confirm. In every client the MCP server is named `recallium`, and the project name is derived from the Git repository.

```bash
npx -y recallium status     # check the connection
npx -y recallium doctor     # fix one
npx -y recallium uninstall  # remove it (--all for every client)
```

Recallium Cloud is in a closed pilot. Join the waitlist at [recallium.ai/waitlist](https://recallium.ai/waitlist); pilot code holders join at [app.recallium.ai/pilot/join](https://app.recallium.ai/pilot/join). Quickstart and client guides: [docs.recallium.ai](https://docs.recallium.ai/quickstart).

## What it does

- **Memory shaped like engineering work.** The approach, the decision and why, the root cause and the fix, and which earlier call each one replaces, each linked to the files it is about.
- **Workstreams and handoffs.** Workstreams group the memories of one effort. Working state and session recap let a new session, agent or teammate resume where the last one stopped.
- **Team rules in every session.** Standing rules are served into every connected agent, in every tool.
- **Commits linked to their reasons.** A `Recallium-Memory:` trailer ties a commit to the memories that explain it.
- **Documents alongside memories.** Upload specs and other files and search them with the same tools.
- **Teams and access.** Teams, projects and role-based access on Recallium Cloud. Tenants are isolated. Recallium does not train models on customer content and does not sell customer data. [Security and trust](https://recallium.ai/security).

## Rules files and Recallium

CLAUDE.md, AGENTS.md, Cursor Rules and Copilot instructions hold standing instructions that one tool loads at the start of a session. Recallium holds what the team has learned since, searched on demand and shared across every tool and teammate. Keep both: rules files for instructions, Recallium for what the team works out.

## Retrieval

On LongMemEval-S, Recallium finds the right memory for 499 of 500 questions (99.8% hit@10) from 3.8 results per question on average. Reader, judge, depth and abstention handling are published at [recallium.ai/benchmarks](https://recallium.ai/benchmarks).

## Self-hosted community edition

The [`community/`](community/) directory holds the self-hosted community edition: a Docker deployment, its [installation guide](community/install/README.md), the Claude Code skill and the Claude Desktop extension. It is free under the [Elastic License v2](LICENSE) and runs on your own machine or network. Recallium Cloud is the managed service and carries the team features above.

## Links

| | |
|---|---|
| Website | [recallium.ai](https://recallium.ai) |
| Why Recallium | [recallium.ai/why-recallium](https://recallium.ai/why-recallium) |
| Docs | [docs.recallium.ai](https://docs.recallium.ai) |
| Pricing | [recallium.ai/pricing](https://recallium.ai/pricing) |
| Changelog | [recallium.ai/changelog](https://recallium.ai/changelog) |
| Community | [Discord](https://discord.gg/sbc2SFBfzd) · [r/recallium](https://www.reddit.com/r/recallium/) · [X](https://x.com/recallium) |
| Issues | [GitHub Issues](https://github.com/recallium-ai/recallium/issues) |
| Support | support@recallium.ai |

## License

The community edition in `community/` is licensed under the [Elastic License v2](LICENSE): free to use and self-host; you may not offer it as a hosted service to third parties. Recallium Cloud is provided under its [terms of service](https://recallium.ai/terms).

Recallium was called MiniMe MCP until it was renamed.
