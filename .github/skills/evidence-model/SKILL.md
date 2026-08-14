---
name: evidence-model
description: Maintains the canonical machine-readable discovery model that connects repository evidence, findings, classifications, confidence, relationships, unknowns, and conflicts across discovery phases.
---

# Evidence Model

## Objective

The evidence model is the canonical intermediate representation for application discovery.

Markdown documents are rendered views of the model. Do not treat the Markdown documents as the primary source of truth.

The model lives at:

`discovery/discovery-model.yaml`

## Core rule

Every significant discovery finding must be traceable to one or more evidence records.

Use stable IDs:

- `E001`
- `E002`
- `E003`

Do not reuse an evidence ID for a materially different artifact or claim.

## Evidence record

Use this conceptual shape:

```yaml
- id: E001
  category: source|config|schema|api|test|infrastructure|dependency|documentation|runtime
  path: src/example/File.java
  artifact: ExampleService
  description: Short description of what the artifact demonstrates.
```

## Finding record

Significant findings should contain:

```yaml
- id: F001
  type: business-capability|architecture|technology|nfr|database|integration|application
  name: Example finding
  description: Evidence-backed description.
  classification: observed|inferred|unknown|conflicting
  confidence: high|medium|low|unknown
  evidence: [E001, E004]
  relationships: []
  rationale: "Required when inferred."
  open_questions: []
```

## Classification rules

### observed
Use when repository artifacts directly establish the finding.

### inferred
Use when multiple pieces of evidence support a conclusion that is not explicitly stated.

### unknown
Use when the repository does not provide enough evidence.

### conflicting
Use when artifacts disagree.

## Confidence rules

### high
Directly observed or supported by multiple independent artifacts.

### medium
Strong inference from correlated artifacts.

### low
Plausible interpretation with limited evidence.

### unknown
No defensible confidence can be assigned.

## Relationships

Use relationships to connect findings across domains.

Examples:

```yaml
relationships:
  - type: implemented-by
    target: component:customer-service
  - type: persists-to
    target: table:customer
  - type: calls
    target: integration:crm
```

Prefer stable semantic IDs over filenames when connecting model entities.

## Unknowns

Unknowns are first-class discoveries. Do not silently omit them.

Example:

```yaml
open_questions:
  - id: Q001
    question: "What is the business owner for this workflow?"
    related_findings: [F007]
```

## Conflicts

Record contradictory evidence explicitly:

```yaml
conflicts:
  - id: C001
    description: "Configuration references Service A, but no runtime usage was found."
    evidence: [E021, E034]
    resolution: "Unresolved"
```

## Workflow

Each discovery skill should:

1. Read the existing model.
2. Add or refine evidence.
3. Add findings.
4. Link findings to evidence.
5. Add relationships.
6. Record unknowns and conflicts.
7. Preserve prior findings unless new evidence invalidates them.

Do not allow later phases to overwrite earlier evidence merely because a different interpretation is more convenient.

## Markdown rendering

The documentation-generation skill should render Markdown from the model.

If a Markdown statement cannot be traced back to the model, it should not be presented as a discovery fact.
