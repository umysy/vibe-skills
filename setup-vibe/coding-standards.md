# Coding Standards

The **Standards** axis of `code-review` reads this file. These rules take precedence over the review's built-in smell baseline. Each rule is a check to apply at review time. Fill each `<placeholder>` the first time it applies, and record the decision in `docs/adr/`.

## 1. Open-closed principle: activates at the second instance

- **One instance, no abstraction.** With a single instance, write it directly: no extension interface, registry, or plugin mechanism. Abstraction ahead of need is **speculative generality**; send it back.
- **Trigger.** Activate only when the known spec contains a **second instance** of the same kind, or the Owner explicitly asks for an extensible structure. Then:
  - **Locked contract.** Once settled, the core interfaces, abstract bases, and core dispatch code are read-only. A new instance that differs only in parameters gets a new config entry; one that needs its own behaviour gets a new module under `<plugin-dir>` implementing the contract.
  - **Registry line.** Register a new instance by appending one entry to `<registry-file>`. Existing entries and the registration mechanism stay as they are. (Projects using auto-discovery skip this step.)
  - **Flat dispatch.** Core dispatch code gains no new `if` / `switch` branch per instance. Exhaustive matching inside an implementation module, or required by the language, is fine.
  - **Isolation.** Implementation modules depend only on the contract and on dependencies injected through it or provided by an Adapter. They do not reference each other or share undeclared mutable state.
  - **Contract change.** When the contract itself must change, stop the current ticket, open a separate ticket, and record an ADR.
- **How to review.** Run `git diff --name-status <Base>...HEAD` first. If the change is exactly "new implementation file(s) + one registry line + tests + this ticket's file", review the new implementation normally and skip re-reading sibling implementations. Any edit to the locked contract, a sibling implementation, or an existing registry entry is **architecture drift**: send it back.

## 2. External services go through an Adapter

- Every external service and heavy third-party SDK enters the core through a project-owned `Adapter` / `Gateway`.
- The Adapter owns protocol translation, mapping vendor objects to internal domain types, timeouts, and error mapping. Core business code sees only internal types; vendor types, SDK calls, and retry details stay inside the Adapter.
- A small pure-protocol library with no replacement or isolation value may be used directly, with a one-line reason in `docs/adr/`.

## 3. Module boundaries

- Modules interact only through their public interfaces.
- Dependencies are acyclic. Shared database tables and message events count as dependencies.
- `shared/` holds only general utilities that belong to no business module.

## 4. Configuration and environments

- Machine paths, URLs, ports, credentials, and business options that may vary by environment or over time live in configuration or platform APIs.
- Stable domain constants may live in code.
- The app runs in one of three **environments**: **development**, **test**, and **stable** (the copy the Owner actually uses). Configuration names the environment at startup; code never guesses it from the machine.
- Each environment has its own data location (folder or database), config, port, and external-service accounts or keys. A desktop app's development build also uses its own app ID and install or output folder, so it never replaces, locks, or shares settings with the installed stable copy.
- Code derives these from the environment name. No stable path, port, or credential appears in code, tests, or development config. When the environment is missing or unknown, the app refuses to start rather than fall back to stable.
- A non-stable run is visibly marked (window title, banner, or log prefix), so the Owner never mistakes it for the copy they use.
- Stable data reaches development only as a copy the Owner asked for, de-identified when it holds other people's data. A schema or data migration runs on such a copy before it runs on stable data.

## 5. One authoritative definition per interface

- Each cross-module, frontend-backend, or external interface has exactly one authoritative definition (types, schema, or OpenAPI).
- Generated files are regenerated from the source definition, never hand-edited.
- Hand-maintained consumer types are backed by contract tests or runtime boundary validation.

## 6. Every page handles more than success

Handle the states that match what the page actually does:

| Page capability | States to handle |
| :--- | :--- |
| Loads data | loading, success, empty, failure |
| Submits or saves | submitting, success, failure, cancel, duplicate-submit guard, unknown outcome |
| Login, network, external service | unauthorised, session expired, offline, timeout |
| Requests, subscriptions, timers | cancel and release on leave; warn on leave with unsaved changes |

- A late response from a stale request leaves the current state untouched.
- Each business rule lives in one place, not repeated per page.

## 7. Error handling

- Classify external and low-level errors at the system boundary; use stable error semantics inside.
- Keep user-facing messages separate from developer diagnostics. Show field errors next to the field.
- Distinguish **failure** from **unknown outcome**: a save that timed out may have been written. Confirm with an idempotency key, a re-read, or a status query before asking the user to retry.
- Retries produce no duplicate side effects. Permission errors reveal nothing about whether the object exists.
- Logs, error responses, and exports carry no secrets, tokens, personal data, or other users' data.
- Every caught error is handled or re-raised; an empty `catch` that turns a test green is a failure.

## 8. Tests

- Tests prove real behaviour: they exercise externally observable behaviour through public seams, and the core logic under test runs for real rather than being mocked.
- Tests live in `<test-layout>` (centralised `tests/` or colocated with source; one layout per project). There is one test location; no `test2/` or `temp_tests/`.
- A test that starts a server, browser, worker, or other process stops it in its own teardown, and the default test command exits on its own (no watch mode). A suite that leaves a process or port behind is a failure.
- Tests write their scratch files under `test-results/` or `.tmp/` and leave nothing elsewhere.
- Tests run in the **test** environment (section 4) with data the suite creates and removes itself; they never read or write development or stable data.
- Valid tests stay in the repo. Release packages exclude them through build configuration.
- When a test and the implementation disagree, fix the implementation; existing assertions keep their strength.

## 9. File placement

- The placement rules live in `docs/FILE_CONVENTIONS.md` (tree, placement order, clean-tree rules, Git). Review against them.
- At review, list this ticket's new files with `git diff --name-status --diff-filter=A <Base>...HEAD` and check each one; check renamed and deleted files the same way.
- A file in a location the conventions do not list is drift, unless this ticket also updated `docs/FILE_CONVENTIONS.md` with a reason.
