# Ticket layer

## Pick the ticket

The **frontier** is every open ticket whose status is `ready-for-agent` and whose `Blocked by` tickets are all closed. Take the lowest-numbered frontier ticket in the current milestone's feature folder. The work happens on the milestone branch; if the user is on `<default>`, switch first.

## Run it

Clear context first, then:

```text
/implement .scratch/<slug>/issues/<NN>-<name>.md
The spec is .scratch/<slug>/spec.md; test seams are in its Testing Decisions, already confirmed by me.
```

The second line is required: after a clear, `implement` sees only what it is given.

The `## Working habits` block sets the order inside: Base-Commit-SHA, `tdd` at the agreed seams, a commit before review, `code-review`, fixes, close. If `tdd` asks about seams again, answer "per the spec". The review has a **Standards** axis (`CODING_STANDARDS.md` plus the smell baseline) and a **Spec** axis, and no dedicated bug-hunting axis; tests and the Spec axis catch logic errors.

Done when the agent's final report shows the tests it ran with their output, the review findings and fixes, and the close commit.

## Stop and ask

- The ticket is unclear: stop and ask the Owner. Many questions mean the area goes back to the milestone grill.
- An extension ticket needs the locked contract changed: stop; the change is its own ticket with an ADR.
- The change touches key calculations, permissions, important data, a destructive migration, or a cross-system restructure: see [ESCALATION.md](ESCALATION.md).

## Alternative: implement-spec

```text
/implement-spec .scratch/<slug>/spec.md
Use <slug> as the integration branch.
```

It builds the whole spec on the integration branch, one fresh subagent per ready ticket in its own worktree, a merger subagent, and one `code-review` at the end. Use it when spec and tickets are clear and the Owner wants to hand the build off. Preconditions: spec and tickets are committed (worktrees see only tracked files), and seams are written in the spec (background subagents cannot ask). Skip it for small tasks, for M0-A (the Owner needs to try it midway), and on first use in a project (try a small spec first and check the worktrees are cleaned up).

## Wrap-up

When every ticket in the milestone is closed:

| Milestone | The Owner |
|---|---|
| M0-A | clicks through every main page and control; gives feedback; approves before M0-B starts |
| M0-B | runs the core flow end to end, **restarts the app**, and confirms the data persisted |
| M1+ | tries the new features and spot-checks old ones |

Then:

```text
In docs/ROADMAP.md, tick <milestone> as done and commit it. Then merge <slug> into <default>, run the test suite, and show me the merge result and test output.
```

Then, in the session where the build happened if possible: `/retro`. A placement or rule mistake that keeps recurring becomes an automated check (for example a pre-commit check of new files against `docs/FILE_CONVENTIONS.md`) or a line in `CODING_STANDARDS.md`.

Done when the milestone is ticked, merged, and tests pass on `<default>`. Next milestone: back to [MILESTONE.md](MILESTONE.md).
