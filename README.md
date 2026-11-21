# Vibe Skills

Two user-invoked skills that sit on top of [Matt Pocock's skills](https://github.com/mattpocock/skills). They compose his flow with an Owner's product rhythm (M0-A, M0-B) and a working environment of coding standards, file conventions, and working habits. Matt's skills read that environment; these skills write it and route through it.

## User-invoked

- [setup-vibe](setup-vibe/SKILL.md): write `CODING_STANDARDS.md`, `docs/FILE_CONVENTIONS.md`, and the `## Working habits` block into a repo. Once per repo, after `/setup-matt-pocock-skills`.
- [ask-vibe](ask-vibe/SKILL.md): find where you are in the flow and get the exact next command to paste.

## What the rules cover

- **Code** (`CODING_STANDARDS.md`, checked by `code-review`): open-closed extension, Adapters for external services, module boundaries, configuration and environments (development, test, and the Owner's stable copy kept apart), one definition per interface, page states, error handling, tests that clean up after themselves, file placement.
- **Agent behaviour** (`## Working habits`, loaded every session): base commit and commit before review, file placement, fix-on-fix stop, clean commits, dependencies, environments (work only in development and test; the stable copy is updated only on request, after a backup), processes (stop every process and port you start), disk (empty temporary folders before closing a ticket), evidence.
- **Flow** (`ask-vibe`): when each decision is made, from the architecture ADRs to the stable environment before the first real data.

## Prerequisites

- Matt's skills installed: `ask-matt`, `setup-matt-pocock-skills`, `grill-me`, `grill-with-docs`, `grilling`, `domain-modeling`, `wayfinder`, `prototype`, `research`, `handoff`, `to-spec`, `to-tickets`, `implement`, `implement-spec`, `tdd`, `code-review`, `codebase-design`, `retro`, `diagnosing-bugs`, `triage`. See his README for install options.
- The repo uses Matt's **local markdown** issue tracker (`.scratch/`); `/setup-vibe` stops on any other tracker.
- The installed `tdd` is Matt's (its description starts with "Test-driven development"). Another skill pack's `tdd` with the same name replaces it on install.

## Install

Everything the two skills need is in this repo. Clone it anywhere, then link it:

```bash
git clone https://github.com/umysy/vibe-skills.git
```

- **Windows**: `powershell -File vibe-skills/scripts/link-skills.ps1` (directory junctions, no admin rights needed).
- **macOS / Linux**: `bash vibe-skills/scripts/link-skills.sh` (symlinks).

Both scripts link each skill folder from wherever you cloned it into `~/.agents/skills` (Codex) and the Claude Code skills folder (`$CLAUDE_CONFIG_DIR/skills`, else `~/.claude/skills`). An existing real folder with the same name is skipped, never overwritten. Restart the tools afterwards. Since they are links, `git pull` updates the installed skills.

Each project can name its own fuller process document (a team SOP, a release checklist): `/setup-vibe` asks for it and writes it into the project's working habits, and `ask-vibe` points there when work outgrows this flow.

## Docs

Human-facing pages, in Chinese: [docs/setup-vibe.md](docs/setup-vibe.md), [docs/ask-vibe.md](docs/ask-vibe.md).

## License

[MIT](LICENSE)
