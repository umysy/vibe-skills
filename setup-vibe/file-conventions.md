# File conventions

Place every new file by this document before creating it. When no location below fits, stop and ask the Owner; once a location is agreed, update this file first, then create the file.

Status: **draft** until the stack is chosen in the project layer. Finalise section 1 for the framework and fill section 6.

## 1. Tree

```text
<repo>/
├─ src/                    # business source (use the framework's mandated path instead, if it has one)
│  ├─ <module>/            # one folder per business module; module list lives in the architecture ADR
│  └─ shared/              # only utilities that belong to no business module
├─ tests/                  # <test-layout>: centralised here, or colocated *.test.* beside source (one layout)
│  ├─ unit/
│  ├─ integration/
│  ├─ e2e/
│  └─ fixtures/            # test data with no real secrets or personal data
├─ assets/                 # runtime resources: images, fonts
├─ config/                 # non-secret configuration and templates
├─ scripts/                # dev, build, and check scripts
├─ docs/
│  ├─ ROADMAP.md
│  ├─ FILE_CONVENTIONS.md  # this file
│  ├─ adr/                 # architecture decisions (grill-with-docs writes these)
│  └─ agents/              # Matt skills configuration (setup-matt-pocock-skills writes these)
├─ .scratch/               # specs and tickets; tracked in Git
│  ├─ <feature>/spec.md
│  ├─ <feature>/issues/NN-<slug>.md
│  └─ plan-<project>/      # wayfinder map and decision tickets
├─ .tmp/                   # temporary files; ignored
├─ test-results/  coverage/  dist/   # test output, coverage, build artifacts; ignored
├─ GLOSSARY.md             # domain terms (grill-with-docs writes this)
├─ CODING_STANDARDS.md
├─ AGENTS.md / CLAUDE.md
├─ README.md
├─ .gitignore  .env.example
└─ (root files the framework or package manager requires, e.g. package.json and its lockfile: list them here)
```

## 2. Where a new file goes, in order

1. **Framework-mandated location**: use it.
2. **Owning business module**: put it in that module's folder; inside the module, split source, tests, and contracts.
3. **No business owner**: `shared/`.
4. **Tests**: the single layout chosen in section 1.
5. **One-off investigation scripts, drafts, logs, screenshots**: `.tmp/`. A repro script with lasting regression value becomes a real test under the test layout.
6. **Nothing fits**: ask the Owner, update this file, then create the file.

## 3. Keep the tree clean

- The repo root holds only what section 1 lists.
- One copy of everything: no `_v2`, `_new`, `_old`, `_backup`, `copy`, or `.bak` files. History lives in Git.
- One place per thing: a utility, a config, or a test folder exists once.
- Temporary files, logs, screenshots, test output, build artifacts, and `.env.local` stay out of Git.
- Bulk deletes and moves happen only after the Owner approves a listed plan. Moves use `git mv`, committed on their own.

## 4. Git

| Tracked | Ignored (`.gitignore`) |
|---|---|
| `src/`, `tests/`, `assets/`, `config/`, `scripts/`, `docs/`, `.scratch/`, root files listed above, lockfiles | `.tmp/`, `test-results/`, `coverage/`, `dist/`, build caches, `.env.local`, anything holding secrets |

## 5. Checks

```bash
# files this ticket added (lines starting with A); check each against sections 1 and 2
git diff --name-status --diff-filter=A <Base>...HEAD

# untracked, unignored files in the working tree
git status --short --untracked-files=all
```

## 6. Project decisions

<!-- Filled in the project layer once the stack is chosen: framework-mandated paths, test layout, module folders, extra root files. Afterwards, one line per change: date and reason. -->
