---
name: file-layout-discovery
description: Discovers delimited CSV and fixed-length text file layouts, maps output fields to database sources or calculated logic, and records evidence for each field. Use when the application reads or writes CSV, delimited, positional, fixed-width, flat-file, batch, or text-based data files.
---

# Text File Layout Discovery

## Objective

Identify text-based data files used by the application and reconstruct their logical layouts and field lineage.

Supported patterns include:

- CSV
- TSV
- pipe-delimited and other delimited files
- fixed-length / fixed-width files
- positional flat files
- batch input/output files
- application-generated text reports where fields can be identified

Do not assume a file is CSV solely from its `.csv` extension. Inspect parsing/writing code and configuration.

## Identify files

Search for:

- `.csv`, `.tsv`, `.txt`, `.dat`, `.flat`, `.fixed` and similar extensions
- delimiter configuration
- record-length configuration
- parser/writer classes
- FlatFileItemReader / FlatFileItemWriter
- CSV readers/writers
- OpenCSV and equivalent libraries
- String split/join operations
- substring operations
- byte/character offset logic
- batch jobs
- SFTP/file transfer configuration
- file naming patterns
- input/output directories
- schemas or documentation describing flat files

Also inspect tests and sample files when available.

## Determine file layout

For each discovered file format determine:

- file name/pattern
- purpose
- direction: input, output, or both
- record type
- delimiter, if any
- encoding if determinable
- header presence
- trailer presence
- fixed record length, if applicable
- field count
- field order

For delimited files record:

- ordinal position
- column name
- source field
- data type where determinable
- transformation/calculation
- nullable/optional status where determinable

For fixed-length files record:

- ordinal position
- column name
- start position
- end position
- length
- source field
- data type where determinable
- transformation/calculation
- padding/alignment where determinable

Positions should use the convention established by the source implementation. If the implementation is one-based, document one-based positions. If it is zero-based, document zero-based positions. Never silently convert without stating the convention.

## Field lineage

The most important output is field-level lineage.

For every output field determine whether it is:

### Database sourced

The value comes directly from a database column.

Example:

```text
Output field: CUSTOMER_ID
Source: CUSTOMER.CUSTOMER_ID
Type: database
```

### Calculated

The value is derived from one or more sources using application logic.

Example:

```text
Output field: FULL_NAME
Source: CUSTOMER.FIRST_NAME + ' ' + CUSTOMER.LAST_NAME
Type: calculated
```

### Constant

The application writes a literal or configured constant.

### Configuration sourced

The value comes from application configuration rather than database data.

### External sourced

The value originates from an API, message, external file, or other external system.

### Unknown

The source cannot be established from repository evidence.

## Calculation discovery

When a field is calculated, capture the calculation or transformation in business-readable language where possible.

Look for:

- arithmetic
- concatenation
- formatting
- date conversion
- code/value mapping
- conditional expressions
- aggregation
- lookup/reference data
- default values
- truncation/padding
- masking
- sorting/grouping

Do not simplify a complex calculation into a misleading description.

## Database lineage

Trace field values through:

```text
file field
   -> writer/mapper
   -> application object
   -> service/query/repository
   -> SQL/ORM
   -> database table.column
```

For SQL, prefer the actual selected column and expression.

For ORM code, trace the entity property back to its mapped table and column.

If multiple database columns contribute to a field, list all sources.

## Fixed-length special rules

Fixed-length files require particular care.

Determine:

- exact offset
- field length
- padding character
- left/right alignment
- numeric formatting
- implied decimal handling if evidenced
- record type discriminator if present

If the implementation uses `substring`, verify whether positions are zero-based before documenting them.

## Evidence requirements

Every file and every significant field mapping should have evidence.

Example:

```text
File: outbound/customer.dat
Field: CUSTOMER_NAME
Position: 21-60
Source type: calculated
Source: customer.firstName + customer.lastName
Evidence:
- src/batch/CustomerFileWriter.java
- src/customer/Customer.java
- src/customer/CustomerRepository.java
Classification: Observed
Confidence: High
```

If lineage is inferred rather than directly established, say so.

## Required output

Produce a file-layout section in the discovery model for each discovered text file.

Recommended Markdown representation:

| # | Column | Position | Length | Source Type | Source Field / Calculation | Evidence | Confidence |
|---|---|---:|---:|---|---|---|---|
| 1 | CUSTOMER_ID | 1 | 10 | Database | CUSTOMER.CUSTOMER_ID | E101 | High |
| 2 | FULL_NAME | 11 | 60 | Calculated | FIRST_NAME + ' ' + LAST_NAME | E102 | High |

For CSV/delimited files, omit Position/Length where they do not apply and include delimiter and ordinal position.

## Unknown lineage

Never invent a source field.

Use:

`Source: Not determinable from repository evidence.`

Then add an open question if the lineage matters to understanding the application.
