---
name: documentation-generation
description: Converts validated application discovery findings and evidence into consistent Markdown discovery artifacts without inventing unsupported information.
---

# Documentation Generation

## Objective

Render validated discovery findings into the required Markdown documents.

## Required files

- `discovery/00-manifest.md`
- `discovery/01-application-overview.md`
- `discovery/02-business-domains.md`
- `discovery/03-architecture.md`
- `discovery/04-technology-stack.md`
- `discovery/05-non-functional-characteristics.md`
- `discovery/06-database.md`
- `discovery/07-external-integrations.md`
- `discovery/08-evidence-index.md`

## Document rules

Each document should contain:
- clear scope
- concise findings
- evidence
- classification
- confidence
- open questions where relevant

Do not duplicate detailed content unnecessarily.

Use cross-references between documents.

## Evidence format

Use stable IDs:

`[E001]`, `[E002]`, etc.

Example:

```markdown
The application exposes REST endpoints for customer management. [E014]

**Classification:** Observed  
**Confidence:** High
```

## Unknowns

Use:

`Not determinable from repository evidence.`

Do not replace unknowns with assumptions.

## Mermaid

Use Mermaid diagrams in architecture documentation where they improve understanding.

Ensure diagrams contain only supported components and relationships.
