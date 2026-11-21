# Packaging and escalation

## Packaging for the Owner's own use

When the build is for the Owner alone, paste:

```text
Build an installable package from the default branch. Check it contains no secrets, tokens, personal data, debug switches, or test files. Install it and run the core flow. Give me a summary: version, source commit, included features, remaining risks.
```

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
