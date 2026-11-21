# Maintaining

Rules for changing the skills in this folder.

- **One source per meaning.** Rules (open-closed, Adapters, file placement, ...) live only in `setup-vibe/coding-standards.md`, `setup-vibe/file-conventions.md`, and `setup-vibe/working-habits.md`. Process (when to do what, which add-on to paste) lives only in `ask-vibe/`. `ask-vibe` points at a rule's section rather than restating it.
- **Both invocation flags.** Each skill is user-invoked in both harnesses: `disable-model-invocation: true` in `SKILL.md` and `policy.allow_implicit_invocation: false` in `agents/openai.yaml`. Change them together or not at all.
- **Re-sync on change.** When a rule or a skill's behaviour changes, update in the same change every place that describes the same step. Search by concept, not only by the rule's name. The places that restate the flow:
  - Rules: `setup-vibe/coding-standards.md`, `file-conventions.md`, `working-habits.md`, `issue-tracker-closing.md` (Matt's `implement` closes tickets by it), `gitignore.md`.
  - Flow: `ask-vibe/SKILL.md` routing, `PROJECT.md`, `MILESTONE.md`, `TICKET.md`, `ESCALATION.md`.
  - Docs: `README.md` "What the rules cover", `docs/setup-vibe.md` and `docs/ask-vibe.md` (what it does, FAQ, how to tell it works), and any manual kept outside this repo (the author keeps a Chinese manual alongside a private SOP).
- **Portable paths.** Skill files reference only their own folder and the project they run in. A user-specific location (such as a fuller process document) is asked for by `setup-vibe` and stored in the project, never written into the skills.
- **Matt upstream.** When Matt's skills update, re-read the ones `ask-vibe` routes to (`to-spec`, `to-tickets`, `implement`, `implement-spec`, `code-review`, `wayfinder`, `setup-matt-pocock-skills`) and check the claims here still hold: which skills are user-invoked, where `to-spec` writes, `implement`'s review-before-commit order, the local tracker layout.
- **Existing projects.** Templates in `setup-vibe/` seed new repos only. A project that already ran `/setup-vibe` keeps its own copies; carry a rule change over by hand, or re-run `/setup-vibe`, which merges into existing files.
- **Known interaction.** Re-running `/setup-matt-pocock-skills` in a repo where `setup-vibe` created a one-line `CLAUDE.md` puts its `## Agent skills` block into `CLAUDE.md`. Move it back to `AGENTS.md`.
- **Style.** English, positive phrasing, no em-dashes, leading words used consistently (*tracer bullet*, *frontier*, *seam*, *locked contract*, *registry line*, *second instance*). Every step ends on a completion criterion.
- **Releases.** Each pushed change is a commit here; the author also records frozen states with SHA-256 per file in a private SOP folder outside this repo.
