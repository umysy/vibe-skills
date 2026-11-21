# Packaging and escalation

## Packaging for the Owner's own use

When the build is for the Owner alone, paste:

```text
Build an installable package from the default branch. Check it contains no secrets, tokens, personal data, debug switches, or test files. Install it and run the core flow. Give me a summary: version, source commit, included features, remaining risks.
```

## Switch to the full SOP

Any of the following moves the affected part to the full SOP (start from `F:\ChatGPT\VibeCodingSOP\CURRENT_SOP.md`):

- **Others will use it**: a public repo, an installer handed to others, or a live service. Owner-only packaging does not count.
- Real data belonging to users or other people.
- More than one person or session writing the same working tree. `implement-spec`'s own worktrees do not count.
- A change that is costly or hard to undo: key calculations (money, scores, stock), permissions or login, important data, complex state, a destructive migration, a cross-system restructure. The full SOP calls these L2/L3; they get an independent review there.
- A leaked secret, lost data, or a production incident.
- Turning on auto-merge or CI gates.

Tell the Owner which item matched and which section of the full SOP applies.
