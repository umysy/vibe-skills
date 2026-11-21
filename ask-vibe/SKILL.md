---
name: ask-vibe
description: Find where you are in the vibe flow and get the exact next command to run.
disable-model-invocation: true
---

# Ask Vibe

A router over the vibe flow: the Matt engineering skills plus the Owner's product rhythm (M0-A, M0-B) and the repo's working environment (`CODING_STANDARDS.md`, `docs/FILE_CONVENTIONS.md`, `## Working habits`).

This skill **locates** the user, then **hands them the next command** as a block they paste themselves. It runs nothing on their behalf. The next steps are user-invoked skills (`to-spec`, `to-tickets`, `implement`, `wayfinder`, `grill-with-docs`) that no agent can fire, and each one is also a checkpoint: the Owner confirms the previous step's output and often clears context before starting the next.

## Conventions this skill relies on

- **Default branch**: `main` if it exists, else `master`. Written `<default>` below and in the layer files.
- **Milestone slug**: one per milestone (for example `m0-a`). The milestone branch, its spec folder `.scratch/<slug>/`, and its tickets share it. A milestone split into features uses `.scratch/<slug>-<feature>/`.
- **Feature folders**: `.scratch/<name>/` with a `spec.md` or an `issues/` folder. `.scratch/plan-*/` is a wayfinder map, never a feature.
- **Ticket status**: read the `Status:` line in either form (`Status: x` or `**Status:** x`). **Closed** is `done`, `resolved`, or `wontfix`; anything else is **open**.
- **Roadmap**: `docs/ROADMAP.md` lists milestones as checkboxes; `- [x]` is finished.

## 1. Locate

Read the repo state, then walk this list top to bottom; the **first** match is the user's position.

1. **No Matt setup**: `docs/agents/issue-tracker.md` is missing. Next: `/setup-matt-pocock-skills`.
2. **No vibe setup**: `CODING_STANDARDS.md`, `docs/FILE_CONVENTIONS.md`, or the `## Working habits` block is missing, or there is no commit. Next: `/setup-vibe`.
3. **Ticket layer**: some feature folder has an open ticket. Prefer the feature whose folder starts with the current branch name. If the user is on `<default>`, the first command switches to that milestone's branch. Read [TICKET.md](TICKET.md).
4. **Tickets pending**: a feature folder has `spec.md` but no `issues/`. Next: step 5 of [MILESTONE.md](MILESTONE.md).
5. **Milestone wrap-up**: the current branch is not `<default>`, is not merged into it (`git merge-base --is-ancestor HEAD <default>` fails), and has at least one feature folder starting with the branch name whose `issues/` exists with every ticket closed. Read the wrap-up section of [TICKET.md](TICKET.md).
6. **Project layer**: `docs/ROADMAP.md` is missing, or some `.scratch/plan-*/issues/` ticket is not `resolved` (a ticket with no `Status:` line is unclaimed, so open). Read [PROJECT.md](PROJECT.md).
7. **Milestone in progress**: on a branch other than `<default>` with no feature folder for it yet. The grill is under way or about to start. Read [MILESTONE.md](MILESTONE.md), step 3.
8. **Next milestone**: on `<default>`, everything merged, and the roadmap has an unchecked milestone. Read [MILESTONE.md](MILESTONE.md) from the top.
9. **Roadmap complete**: every roadmap milestone is checked. Read [ESCALATION.md](ESCALATION.md) if the user is packaging, updating their stable copy, or shipping; otherwise suggest `/retro` and adding the next milestones to the roadmap.

When open tickets exist but none is `ready-for-agent` (for example `needs-info` or `ready-for-human`), say so: the Owner acts on those before `/implement` can continue.

Done when you can state the position and the evidence for it (the files, statuses, and branch facts that matched).

## 2. Map

The flow has three layers. Each layer has its own kind of ticket.

- **Project layer** (once per project): settle direction, the roadmap, and the architecture ADRs. `/grill-with-docs` for a project one session can hold; `/wayfinder` for a large, foggy one, whose tickets are **decisions**, not work. See [PROJECT.md](PROJECT.md).
- **Milestone layer** (once per milestone or large feature): branch, then `/grill-with-docs` → `/to-spec` → `/to-tickets` in one unbroken session. Tickets are **tracer bullets**. See [MILESTONE.md](MILESTONE.md).
- **Ticket layer** (once per ticket): fresh context, `/implement <ticket>` with the spec pointer. Under the `## Working habits` block it runs `tdd`, commits, runs `code-review`, stops its own processes, empties the temporary folders, and closes the ticket. See [TICKET.md](TICKET.md).

Branches that only some runs reach:

- **Second instance of an existing kind** (second importer, data source, payment method, window type, scoring rule) appears in a milestone → read [OPEN-CLOSED.md](OPEN-CLOSED.md).
- **Packaging, updating the Owner's stable copy, shipping to others, or a high-risk change** (key calculations, permissions, important data, destructive migration, cross-system restructure) → read [ESCALATION.md](ESCALATION.md).
- **Small task** one session can finish → `/grill-with-docs` briefly if unclear, then `/implement` in the same session; skip `to-spec` and `to-tickets`.
- **Hard bug** → `/diagnosing-bugs`. **Incoming reports and requests** → `/triage`. **No repo yet** → `/grill-me`.

## 3. Context

| Moment | Context |
|---|---|
| Between wayfinder decision tickets | clear |
| `grill-with-docs` → `to-spec` → `to-tickets` | keep: one unbroken session |
| After tickets are committed | clear |
| Before each `/implement` | clear |
| `/retro` | run in the session it reviews, before clearing |
| Window filling before tickets exist | compact at the nearest step boundary |
| New tool, new folder, or a colleague | `/handoff` |

## 4. Hand over

Reply with:

1. **Position**: the layer and step, and the evidence.
2. **Next command**: a fenced block the user pastes, with real paths, the slug, `<default>`, and the add-on text from the layer file filled in. When the block needs something only the user knows (the project idea, a milestone choice), ask for it in one sentence first, then fill it in. Prefix it with "run `/clear` first" when the context table says clear.
3. **Why it is yours to run**: one line, for example "`to-spec` is user-invoked, and you confirm the grill's outcome before it is written up."
4. **What to check afterwards**: the layer file's check for that step.

Done when the user has a command they can paste unchanged.
