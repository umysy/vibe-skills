# Milestone layer

Once per milestone, or per large feature when a milestone is too big for one grill session. Steps 3 to 5 run in **one unbroken session**; clear context only after the tickets are committed.

The **milestone slug** (for example `m0-a`) names the branch and the `.scratch/<slug>/` folder. A large feature within the milestone uses `.scratch/<slug>-<feature>/` on the same branch.

## 1. Branch

`implement` commits to the current branch and creates none, so the branch comes first. Paste in a fresh session:

```text
Create a branch <slug> from <default>, switch to it, and show me git status.
```

Done when `git branch --show-current` prints the slug.

## 2. Second instance?

If this milestone adds a **second instance** of an existing kind, read [OPEN-CLOSED.md](OPEN-CLOSED.md) now: it adds a line to each of steps 3, 4, and 5.

## 3. Grill

```text
/grill-with-docs We are doing <milestone> from docs/ROADMAP.md. Read docs/ROADMAP.md, GLOSSARY.md, and the related ADRs first, and ask only what is still open for this milestone.
Also settle, following CODING_STANDARDS.md: how each page behaves when loading, empty, failing, submitting, double-submitted, and left (only where it differs from the shared strategy); what the user sees on errors and how they recover; whether this milestone adds an external service (Adapter), a module or cross-module interface (public interface, authoritative definition, folder), a config entry, or a new kind of file (update docs/FILE_CONVENTIONS.md). Record new decisions as ADRs.
```

When this milestone first keeps real data or gives the Owner a copy to use day to day (usually M0-B), add: `Settle the stable environment in the environments ADR: its data location, config, port, and accounts, kept apart from development and test, and how the stable copy is updated, backed up, and restored. One ticket proves a development run cannot reach stable data.`

When the project used wayfinder, add: `Also read .scratch/plan-<project>/map.md "Decisions so far" and the resolved decision tickets related to this milestone.` The grill reads `GLOSSARY.md` and ADRs by itself; it reads the map only when told.

Done when the grill has no open questions for this milestone and its new ADRs are written.

## 4. Spec

Same session:

```text
/to-spec Write it to .scratch/<slug>/spec.md. List every confirmed test seam in Testing Decisions. In Implementation Decisions, state the modules and public interfaces touched, the Adapters to build or change, new config entries, the authoritative definition of each interface, and each page's states and error handling.
```

`to-spec` synthesises; it asks once, to confirm the test seams. The add-on puts the grill's decisions into the spec because `implement` sees only the ticket and the spec. The spec names modules and roles; exact file paths stay in ADRs and `docs/FILE_CONVENTIONS.md`.

Done when the Owner confirms: user stories cover what they want; Out of Scope holds nothing they want; Testing Decisions lists seams; Implementation Decisions covers the items above.

## 5. Tickets

Same session:

```text
/to-tickets Publish them to .scratch/<slug>/issues/.
```

`to-tickets` proposes a numbered breakdown and quizzes the Owner on granularity and blocking edges before writing `.scratch/<slug>/issues/NN-<name>.md`. Each ticket is a **tracer bullet** sized to one fresh context window.

- **M0-A**: add: `This is M0-A. Slice each ticket by page or flow: UI + Mock data source + tests, demoable on its own. Acceptance: the page opens, navigation works, Mock is visibly marked, no fake save success. No real data.`
- **A ticket that is too big** ("the whole settings page"): ask to split it. If it will not split, that area was not grilled enough: treat it as its own feature and return to step 3.
- **Lost context**: `/to-tickets .scratch/<slug>/spec.md` works from the file.

Done when the Owner approves the breakdown and the ticket files exist.

## 6. Commit and clear

```text
Commit .scratch/<slug>/ on its own as "docs: spec and tickets for <slug>", then show me git status.
```

Committing first keeps the spec and tickets out of the first ticket's diff, and makes them visible to `implement-spec` worktrees. Then clear context and continue in [TICKET.md](TICKET.md).

Done when `git status --short` shows nothing under `.scratch/<slug>/`.
