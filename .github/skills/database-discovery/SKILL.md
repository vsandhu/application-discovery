---
name: database-discovery
description: Discovers database technologies, schemas, tables, columns, keys, indexes, views, procedures, triggers, relationships, and business data meaning from database artifacts and application usage.
---

# Database Discovery

## Identify

- database technology
- schemas
- tables
- columns
- primary keys
- foreign keys
- indexes
- views
- stored procedures
- triggers
- sequences
- migrations

## Correlate with application code

Look for:
- repositories
- DAOs
- ORM entities
- SQL queries
- stored procedure calls
- transaction boundaries

## Relationship rules

Prefer explicit:
- foreign keys
- ORM relationships
- joins
- repository queries

Do not infer a relationship from similarly named columns alone.

## Business interpretation

For each important table determine, when evidence allows:
- likely business entity
- purpose
- transactional/reference/audit role
- important attributes
- relationships
- application usage

Clearly separate physical schema facts from business interpretation.

## Table output

```text
Table:
Purpose:
Schema:
Key:
Important columns:
Relationships:
Application usage:
Classification:
Confidence:
Evidence:
Open questions:
```
