# Second instance: open-closed

The rule lives in `CODING_STANDARDS.md` section 1. This file covers the process: when it activates and what each step adds.

## When

- **One instance**: write it directly. A kind that will clearly have more instances gets a one-line "candidate extension point" ADR and nothing else.
- **Second instance** in the known spec, or the Owner explicitly asks for an extensible structure: activate.

## The structure

| Part | Is | Changes by |
|---|---|---|
| **Locked contract** | core interface, abstract base, core dispatch | its own ticket with an ADR, only |
| **Plugin dir** | one module per instance | adding a new module; an instance that differs only in parameters gets a config entry |
| **Registry** | where instances are listed | appending one **registry line**; none with auto-discovery |

## What each step adds

- **Milestone grill** (MILESTONE.md step 3), add: `This is a second instance of <kind>. Following CODING_STANDARDS.md section 1, settle the locked contract, the plugin dir, and the registry file; record them as an ADR and fill the placeholders in CODING_STANDARDS.md.`
- **Spec** (step 4), add: `In Implementation Decisions, name the locked contract, the plugin location, the registry, and which instances are config versus modules, by role; the exact paths stay in the ADR.`
- **Tickets** (step 5), add: `Ticket 01 extracts the contract: turn the existing instance into the first module implementing it, with behaviour unchanged and all tests green. Then one ticket per new instance: a new file in the plugin dir, one registry line, and tests.` This is the prefactor `to-tickets` already puts first.
- **Implement**: an extension ticket changes only those three things. A needed contract change stops the ticket.
- **Review**: the Standards axis checks the file list per section 1; a premature abstraction with a single instance is flagged as speculative generality.

## Example

M1 imports bank A's CSV: one instance, written directly. M2 adds bank B: activate. The grill settles "importer contract + `importers/` + `importers/registry`" as an ADR. Ticket 01 turns bank A into the first importer; ticket 02 adds bank B. Later, bank C is one ticket: one file under `importers/`, one registry line, its tests.
