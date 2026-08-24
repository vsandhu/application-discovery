# Text File Layouts and Field Lineage

> Generated from `discovery/discovery-model.yaml`. The canonical source of truth is the machine-readable discovery model.

## Scope

This document catalogs text-based files used by the application, including CSV, delimited, fixed-width, positional, flat-file, batch, and text-based integration formats.

## File Inventory

| File / Pattern | Purpose | Direction | Format | Record Length | Evidence | Confidence |
|---|---|---|---|---:|---|---|
| No files discovered yet | — | — | — | — | — | — |

## Field-Level Lineage

No file layouts have been discovered yet.

For each discovered file, the final document should provide a field-level mapping similar to:

| # | Column | Position | Length | Source Type | Source Field / Calculation | Evidence | Confidence |
|---|---|---:|---:|---|---|---|---|
| 1 | CUSTOMER_ID | 1 | 10 | Database | CUSTOMER.CUSTOMER_ID | E101 | High |
| 2 | FULL_NAME | 11 | 60 | Calculated | CUSTOMER.FIRST_NAME + ' ' + CUSTOMER.LAST_NAME | E102 | High |

For CSV/delimited files, position means ordinal field position and length is omitted unless explicitly known.

## Source Type Definitions

- **Database** — value is sourced from a database table/column.
- **Calculated** — value is derived by application logic from one or more sources.
- **Constant** — value is a literal or fixed business value.
- **Configuration** — value comes from application configuration.
- **External** — value originates from another application, API, message, or file.
- **Unknown** — repository evidence is insufficient to determine the source.

## Fixed-Width Conventions

For fixed-width files, positions must explicitly state whether they are one-based or zero-based. The agent must derive this from the implementation and must not silently convert positions.

## Unresolved Lineage

Any field whose source cannot be established must be recorded as:

`Source: Not determinable from repository evidence.`

Such fields should also be linked to an open question when resolving the lineage is important to application understanding or modernization.
