# Project layer

Once per project. The goal is two outputs: a short `docs/ROADMAP.md` and the architecture ADRs. Implementation waits for the milestone layer.

## Pick the entry

- **`/grill-with-docs`**: the project fits in one session's conversation. Most projects.
- **`/wayfinder`**: the project is too big for one session and the way is still foggy.
- **`/grill-me`**: there is no repo yet and the user only wants to think it through. It writes nothing; once clear, create the repo, run the setups, and come back here.

## The roadmap

`docs/ROADMAP.md` lists milestones in order as checkboxes, each with its slug and a completion bar. Wrap-up ticks a milestone when it is merged; `ask-vibe` reads the ticks.

```markdown
- [ ] M0-A (`m0-a`): the app opens and every main page and control is clickable; anything not wired up is visibly marked Mock.
- [ ] M0-B (`m0-b`): the first core flow works for real, and its data survives a restart.
- [ ] M1 (`m1`): further features, ordered by value and dependency.
```

## The architecture ADRs

Settle each item, recording it as an ADR. An item that cannot be settled yet gets an ADR saying "provisional, revisit at <milestone>".

- Stack.
- Modules and each module's public interface.
- External services, and where each one's Adapter lives.
- Where configuration lives, and how local secrets are obtained.
- For each cross-module, frontend-backend, or external interface: its one authoritative definition, plus the generation command if code is generated.
- The shared page-state strategy (loading, empty, failure) and the error taxonomy (user messages versus diagnostics).
- Storage, when the project persists data:
  1. Versioned migrations from the first table onwards.
  2. Open formats or a mainstream open-source database; any special format has a lossless export to an open one.
  3. Breaking changes are deprecated first, with a migration path, and removed after verification.
- **Candidate extension points**: a kind that will clearly have several instances later gets one line, "candidate, not abstracted until the second instance". See [OPEN-CLOSED.md](OPEN-CLOSED.md).
- **File conventions**: finalise `docs/FILE_CONVENTIONS.md` for the chosen stack (framework paths, test layout, module folders) and fill its section 6.

### Add-on for the grill

```text
/grill-with-docs <the idea, in the Owner's words>. Walk me through the architecture ADR list one item at a time, following CODING_STANDARDS.md, and record each decision as an ADR. When done, write docs/ROADMAP.md as checkboxes with slugs (M0-A, M0-B, M1+) and finalise docs/FILE_CONVENTIONS.md for the stack.
```

## Wayfinder

First run (chart the map):

```text
/wayfinder <the idea, in the Owner's words>. Use .scratch/plan-<project>/ for the map. The destination is docs/ROADMAP.md plus the architecture ADR list.
```

The `plan-` prefix keeps decision tickets apart from feature tickets under `.scratch/`. Charting is one session: it names the destination, maps the frontier, creates the map and the tickets it can already state, and fires research subagents. Research lands on `research/<name>` branches; those stay unmerged and undeleted, since tickets link to them.

Later runs (work the map), one decision ticket per session, clearing context between:

```text
/wayfinder .scratch/plan-<project>/map.md
```

Ticket types: **grilling** and **prototype** need the Owner present (the Owner picks the prototype; the agent does not pick and close it), **research** runs alone, **task** varies.

Wayfinder tickets are **decisions**, never work. "Build the UI" is milestone work; "sidebar or top tabs for navigation?" is a wayfinder prototype ticket.

**Exit.** The map is done when only doing remains and nothing is left to decide. Then write `docs/ROADMAP.md` and move to the milestone layer, whose grill reads the map (see [MILESTONE.md](MILESTONE.md)). If the whole project turned out to be a single milestone, go straight to `/to-spec .scratch/plan-<project>/map.md` in a fresh session instead.

## Check

- `docs/ROADMAP.md` exists as checkboxes with slugs and M0-A / M0-B completion bars.
- Every item in the ADR list has an ADR, settled or marked provisional.
- `docs/FILE_CONVENTIONS.md` is no longer marked draft.
- All of it is committed.
