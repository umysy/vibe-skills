---
name: setup-vibe
description: Write the vibe working environment into a repo (coding standards, file conventions, working habits). Run once per repo, after setup-matt-pocock-skills.
disable-model-invocation: true
---

# Setup Vibe

Write the **working environment** that the Matt engineering skills already read: `CODING_STANDARDS.md` (read by `code-review`), `docs/FILE_CONVENTIONS.md` (read before creating files), and a `## Working habits` block in `AGENTS.md` / `CLAUDE.md` (loaded every session). Once written, these files are the single source of truth; the user edits them directly afterwards.

This is a prompt-driven skill: explore, present, confirm, then write. Stage and commit only the files this skill writes.

## 0. Precondition

`docs/agents/issue-tracker.md` exists and describes the **local markdown** tracker (issues under `.scratch/`). If the file is missing, tell the user to run `/setup-matt-pocock-skills` first and stop. If it describes GitHub, GitLab, or another tracker, tell the user this flow assumes the local tracker and stop.

## 1. Explore

Read the repo's current state; assume nothing. Record a finding for each item:

- **Git repo**: `git rev-parse --is-inside-work-tree`. When it fails, the folder is not a repo yet: record that, and skip the remaining Git checks until step 4 initialises it.
- **First commit and default branch**: `git rev-parse HEAD` (is there a commit?) and the default branch (`main` if it exists, else `master`, else the current branch). Note uncommitted user changes from `git status --short`.
- **Git identity**: `git config user.name` and `git config user.email` both return a value.
- **Agent file**: which of `AGENTS.md` / `CLAUDE.md` exists; which one holds Matt's `## Agent skills` block; whether either already has `## Working habits`; whether `CLAUDE.md` imports `@AGENTS.md`.
- **Existing environment**: whether `CODING_STANDARDS.md` or `docs/FILE_CONVENTIONS.md` exists, and whether `docs/agents/issue-tracker.md` already contains `## Closing implementation issues`.
- **Scratch tracking** (inside a repo only): `git check-ignore -q .scratch/x`. Exit code 0 means `.gitignore` swallows `.scratch/`; exit code 1 means it is tracked.
- **Test layout signals**: an existing `tests/` folder, colocated `*.test.*` / `__tests__` files, or a framework that mandates one layout.
- **tdd skill**: read the `description` of the installed `tdd` skill. It should start with "Test-driven development" (Matt's red-green loop). Anything else (for example a bug-fix-only variant from another skill pack) means `implement` will skip its test loop.

Done when every item above has a recorded finding.

## 2. Present findings and ask

Summarise the findings. Then ask the sections below in order, **one question per message**, leading with the recommended answer so the user can accept it in a word. Skip a section when exploration already settled it.

- **A. Test layout**: centralised `tests/` or colocated with source? Recommend whatever the framework or existing code already uses; otherwise `tests/`.
- **B. Agent file**: the habits go in `AGENTS.md` whenever it exists, so Codex reads them.
  - Neither file exists: ask which to create (recommend `AGENTS.md` when the user runs both Codex and Claude Code).
  - `AGENTS.md` only: confirm creating `CLAUDE.md` containing just `@AGENTS.md` (recommended: yes), so Claude Code loads the same file.
  - Both exist and `CLAUDE.md` lacks `@AGENTS.md`: confirm adding `@AGENTS.md` as its first line (recommended: yes). If Matt's `## Agent skills` block sits in `CLAUDE.md`, offer to move it into `AGENTS.md`.
- **C. Git identity**: only when missing. Ask the user for the name and email to set for this repo; this skill does not invent them.
- **D. tdd mismatch**: only when the `tdd` check failed. Recommend reinstalling Matt's `tdd` before the first ticket; this skill does not change installed skills.
- **E. Existing files**: only when `CODING_STANDARDS.md` or `docs/FILE_CONVENTIONS.md` already exists. Recommend merging the templates' sections into the existing file, keeping the user's rules.
- **F. Full process**: is there a fuller process document (a team SOP, a release checklist) to follow when work outgrows this flow? Recommend "none" unless the user names one. If they give a path or URL, it fills the **Full process** line of the working habits; with none, that line is left out. `ask-vibe` reads it when escalating.

Done when every section that applies has an answer.

## 3. Confirm

Show the user a draft of every change before writing:

- `CODING_STANDARDS.md`, from [coding-standards.md](coding-standards.md), with the test layout filled into section 8.
- `docs/FILE_CONVENTIONS.md`, from [file-conventions.md](file-conventions.md), with the test layout applied to the tree.
- The `## Working habits` block, from [working-habits.md](working-habits.md), with the **Full process** line filled from section F or removed.
- The addendum to `docs/agents/issue-tracker.md`, from [issue-tracker-closing.md](issue-tracker-closing.md).
- The lines to add to `.gitignore`, from [gitignore.md](gitignore.md).
- Whether `git init -b main` and a first commit will run.

Done when the user approves the drafts, with any edits applied.

## 4. Write

- **Git**: if the folder is not a repo, run `git init -b main`. If the user gave an identity in section C, set it with `git config` for this repo.
- **Agent file**: write `## Working habits` into the file chosen in section B. If the block exists, update it in place; otherwise append it after `## Agent skills`. Keep the user's surrounding sections untouched. Apply the approved `CLAUDE.md` change.
- **Standards and conventions**: write the two files (or merge, per section E).
- **Issue tracker addendum**: append only when `## Closing implementation issues` is absent.
- **`.gitignore`**: add each listed line only when absent, including the hidden-file exceptions when a `.*` rule is present.

Done when every approved change is on disk.

## 5. Commit and verify

1. Stage by explicit path only the files this skill wrote or edited. When this skill ran `git init`, also stage the files `/setup-matt-pocock-skills` wrote (`docs/agents/`, and its block in the agent file), so a fresh repo's first commit is complete.
2. If anything is staged, commit with `chore: set up vibe working environment`. If nothing is staged (a re-run with no changes), skip the commit.
3. Verify all three, and show the user the output:
   - `git rev-parse HEAD` prints a SHA.
   - `git check-ignore -q .scratch/x` exits with code 1.
   - `git status --short` lists none of the files this skill wrote.

Done when all three checks pass.

## 6. Done

Tell the user:

- `code-review` now reads `CODING_STANDARDS.md`; every session loads `## Working habits`; agents place files by `docs/FILE_CONVENTIONS.md`.
- `docs/FILE_CONVENTIONS.md` is a draft until the stack is chosen; `/ask-vibe` prompts for finalising it in the project layer.
- Edit these files directly later. Re-running this skill merges the current templates into the existing files; it is only needed to pick up template changes.
- If `/setup-matt-pocock-skills` is re-run later, it edits `CLAUDE.md` when that file exists, so its `## Agent skills` block may land in the one-line `CLAUDE.md`. Move it back into `AGENTS.md`.
- Next: run `/ask-vibe`.
