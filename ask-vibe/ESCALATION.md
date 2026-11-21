# Packaging and escalation

## Packaging for the Owner's own use

The installed package is the **stable** copy the Owner uses day to day (`CODING_STANDARDS.md` section 4). Building or updating it is always a separate request from the Owner, never part of a ticket. When the build is for the Owner alone, paste:

```text
Build an installable package of the stable environment from the default branch, following the environments ADR. Confirm tests pass on that commit. Check the package contains no secrets, tokens, personal data, debug switches, test files, or development config. Back up the stable data first, then install. Open it once and confirm it shows no development marker and reads the stable data location; leave the core flow to me. Give me a summary: version, source commit, included features, backup location, the restore step, remaining risks.
```

The Owner then runs the core flow in the stable copy. The development build and the stable copy can stay installed side by side.

## Leaving the light flow

Any of the following takes the affected part beyond what this flow guarantees:

- **Others will use it**: a public repo, an installer handed to others, or a live service. Owner-only packaging does not count.
- Real data belonging to users or other people.
- More than one person or session writing the same working tree. `implement-spec`'s own worktrees do not count.
- A change that is costly or hard to undo: key calculations (money, scores, stock), permissions or login, important data, complex state, a destructive migration, a cross-system restructure.
- A leaked secret, lost data, or a production incident.
- Turning on auto-merge or CI gates.

## Where to go

Read the `## Working habits` block for a **Full process** line.

- **Present**: open the document it names, tell the Owner which item matched, and point to the section of that document that covers it.
- **Absent**: tell the Owner which item matched and what it needs before going further: an independent review of the change (beyond `code-review`'s two axes), a written release or migration plan with a tested rollback, and, for others' data, a privacy check. The Owner can add a **Full process** line by re-running `/setup-vibe` or editing the block.
