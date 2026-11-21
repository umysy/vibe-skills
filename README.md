# Vibe Skills

Two user-invoked skills that sit on top of [Matt Pocock's skills](https://github.com/mattpocock/skills). They compose his flow with the Owner's product rhythm (M0-A, M0-B) and a working environment of coding standards, file conventions, and working habits. Matt's skills read that environment; these skills write it and route through it.

## User-invoked

- [setup-vibe](setup-vibe/SKILL.md): write `CODING_STANDARDS.md`, `docs/FILE_CONVENTIONS.md`, and the `## Working habits` block into a repo. Once per repo, after `/setup-matt-pocock-skills`.
- [ask-vibe](ask-vibe/SKILL.md): find where you are in the flow and get the exact next command to paste.

## Prerequisites

- Matt's skills installed: `ask-matt`, `setup-matt-pocock-skills`, `grill-me`, `grill-with-docs`, `grilling`, `domain-modeling`, `wayfinder`, `prototype`, `research`, `handoff`, `to-spec`, `to-tickets`, `implement`, `implement-spec`, `tdd`, `code-review`, `codebase-design`, `retro`, `diagnosing-bugs`, `triage`.
- The repo uses Matt's **local markdown** issue tracker (`.scratch/`); `/setup-vibe` stops on any other tracker.
- The installed `tdd` is Matt's (its description starts with "Test-driven development"). Another skill pack's `tdd` with the same name replaces it on install.

## Install

Run `scripts/link-skills.ps1`. It links each skill folder into `~/.agents/skills` (Codex) and the Claude Code skills folder, so edits here take effect immediately.

## Docs

Human-facing pages, in Chinese: [docs/setup-vibe.md](docs/setup-vibe.md), [docs/ask-vibe.md](docs/ask-vibe.md). The full Chinese manual is `极简流程/Matt极简流程.md` in the SOP folder.
