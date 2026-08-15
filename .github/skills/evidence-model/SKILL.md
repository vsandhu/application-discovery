---
name: evidence-model
description: Maintains the canonical machine-readable discovery model that connects repository evidence, findings, entities, relationships, confidence, unknowns, and conflicts across discovery phases.
---

# Evidence Model

## Objective

`discovery/discovery-model.yaml` is the canonical intermediate representation for application discovery.

Markdown documents are rendered views. They are not the source of truth.

## Canonical identity model

Use stable IDs for all reusable entities and findings.

Recommended ID format:

- `application:<name>`
- `domain:<name>`
- `capability:<name>`
- `rule:<name>`
- `workflow:<name>`
- `component:<name>`
- `technology:<name>`
- `database:<name>`
- `schema:<name>`
- `table:<name>`
- `api:<name>`
- `event:<name>`
- `integration:<name>`
- `nfr:<name>`

Use lowercase kebab-case after the prefix.

Do not create duplicate entities when a later phase discovers another reference to the same real-world or technical entity. Reuse the existing ID.

## Entity record

```yaml
entities:
  - id: component:customer-service
    type: component
    name: Customer Service
    description: Handles customer lifecycle operations.
    evidence: [E001, E002]
```

Allowed entity types:

- application
- actor
- business-domain
- capability
- business-rule
- workflow
- component
- technology
- database
- schema
- table
- api
- event
- integration
- nfr

## Evidence record

Every significant discovery must be traceable to evidence.

```yaml
evidence:
  - id: E001
    category: source
    path: src/example/File.java
    artifact: ExampleService
    location: ExampleService.processCustomer
    description: Implements customer processing behavior.
```

Allowed categories:

- source
- config
- schema
- api
- test
- infrastructure
- dependency
- documentation
- runtime

Evidence should identify the smallest useful repository artifact. Never copy secrets or secret values.

## Finding record

Use findings for claims or conclusions that need classification and confidence.

```yaml
findings:
  - id: F001
    type: business-capability
    name: Customer Onboarding
    description: The application supports customer onboarding.
    classification: observed
    confidence: high
    evidence: [E001, E004]
    relationships: []
    rationale: ""
    open_questions: []
```

Allowed finding types:

- application
- business-domain
- business-capability
- business-rule
- workflow
- architecture
- component
- technology
- nfr
- database
- integration
- api
- event

## Classification

### observed
Directly established by repository evidence.

### inferred
Supported by multiple correlated artifacts but not explicitly stated.

### unknown
Insufficient evidence to make a defensible conclusion.

### conflicting
Evidence exists but materially disagrees.

## Confidence

- `high`: directly established or supported by multiple independent artifacts.
- `medium`: strong inference from correlated artifacts.
- `low`: plausible interpretation with limited evidence.
- `unknown`: insufficient evidence.

When `classification: inferred`, `rationale` is required.
When `classification: unknown`, `open_questions` should explain what is missing.
When `classification: conflicting`, a conflict record should identify the disagreement.

## Relationships

Relationships are first-class and connect the discovery graph.

```yaml
relationships:
  - id: R001
    source: capability:customer-onboarding
    type: implemented-by
    target: component:customer-service
    evidence: [E010]
    confidence: high
```

Common relationship types:

- contains
- part-of
- implements
- implemented-by
- realizes
- persists-to
- reads-from
- writes-to
- calls
- called-by
- publishes
- consumes
- depends-on
- uses
- exposes
- invokes
- secured-by
- configured-by
- deployed-on
- communicates-with
- related-to

Only add a relationship when repository evidence supports it. The relationship itself should have evidence and confidence.

## Open questions

Unknowns are first-class discoveries.

```yaml
open_questions:
  - id: Q001
    question: What is the business owner for this workflow?
    related_findings: [F007]
    priority: medium
```

Allowed priority values:

- high
- medium
- low

## Conflicts

Record contradictions instead of silently selecting one interpretation.

```yaml
conflicts:
  - id: C001
    description: Configuration references Service A, but no runtime usage was found.
    evidence: [E021, E034]
    affected_entities: [integration:service-a]
    resolution: unresolved
```

Allowed resolution values:

- unresolved
- resolved-by-evidence
- accepted-as-inference

## Phase rules

Every discovery skill must:

1. Read the current model before analysis.
2. Preserve existing evidence IDs.
3. Reuse existing entity IDs.
4. Add new evidence rather than replacing old evidence.
5. Add or refine findings.
6. Add evidence-backed relationships.
7. Record unknowns and conflicts.
8. Never silently delete an earlier finding.

If new evidence changes an earlier conclusion, retain the original evidence and update the finding with the new classification/rationale.

## Cross-domain linking

The following links are especially valuable:

```text
business capability
    -> implemented-by -> component
component
    -> persists-to -> table
component
    -> calls -> integration
component
    -> uses -> technology
workflow
    -> invokes -> api
business rule
    -> applies-to -> capability
component
    -> communicates-with -> component
```

These relationships are what allow later modernization agents to reason from business behavior through legacy implementation and technical dependencies.

## Rendering rule

Documentation generation must read the model and render Markdown from it.

A Markdown claim that has no corresponding model finding/evidence must not be presented as an established discovery fact.
