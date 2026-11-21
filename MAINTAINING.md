# Maintaining

Rules for changing the skills in this folder.

- **One source per meaning.** Rules (open-closed, Adapters, file placement, ...) live only in `setup-vibe/coding-standards.md`, `setup-vibe/file-conventions.md`, and `setup-vibe/working-habits.md`. Process (when to do what, which add-on to paste) lives only in `ask-vibe/`. `ask-vibe` points at a rule's section rather than restating it.
- **Both invocation flags.** Each skill is user-invoked in both harnesses: `disable-model-invocation: true` in `SKILL.md` and `policy.allow_implicit_invocation: false` in `agents/openai.yaml`. Change them together or not at all.
- **Re-sync on change.** When a skill's behaviour changes, update in the same change: its docs page under `docs/`, the routing in `ask-vibe/SKILL.md` if the flow changed, and the Chinese manual `极简流程/Matt极简流程.md` in the SOP folder.
- **Matt upstream.** When Matt's skills update, re-read the ones `ask-vibe` routes to (`to-spec`, `to-tickets`, `implement`, `implement-spec`, `code-review`, `wayfinder`, `setup-matt-pocock-skills`) and check the claims here still hold: which skills are user-invoked, where `to-spec` writes, `implement`'s review-before-commit order, the local tracker layout.
- **Existing projects.** Templates in `setup-vibe/` seed new repos only. A project that already ran `/setup-vibe` keeps its own copies; carry a rule change over by hand, or re-run `/setup-vibe`, which merges into existing files.
- **Known interaction.** Re-running `/setup-matt-pocock-skills` in a repo where `setup-vibe` created a one-line `CLAUDE.md` puts its `## Agent skills` block into `CLAUDE.md`. Move it back to `AGENTS.md`.
- **Style.** English, positive phrasing, no em-dashes, leading words used consistently (*tracer bullet*, *frontier*, *seam*, *locked contract*, *registry line*, *second instance*). Every step ends on a completion criterion.
- **Freeze.** A released state is recorded in the SOP folder's `CHANGELOG.md` and a freeze record with SHA-256 for each file here.
