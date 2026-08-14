---
name: business-domain-discovery
description: Identifies business domains, capabilities, workflows, rules, entities, and domain relationships from an existing application using evidence from code, data, APIs, events, and tests.
---

# Business Domain Discovery

## Objective

Determine what the application does from observable business behavior.

## Evidence sources

Prioritize:
1. business rules
2. service methods
3. workflows
4. domain objects
5. APIs
6. database entities
7. events
8. validations
9. tests
10. business terminology

Package and class names alone are insufficient.

## Identify

For each business domain:
- domain name
- purpose
- capabilities
- actors
- workflows
- important business entities
- business rules
- state transitions
- APIs
- events
- related data

## Capability test

A capability should represent meaningful business behavior, not merely a technical operation.

Weak:
- `saveCustomer()`

Better:
- Customer Profile Maintenance

## Business rules

Look for:
- conditional rules
- eligibility
- validation
- calculations
- state transitions
- thresholds
- approval logic
- sequencing
- exception handling

## Output finding

Use:

```text
Capability:
Description:
Classification:
Confidence:
Evidence:
Business rules:
Related entities:
Related APIs/events:
Open questions:
```

Explicitly distinguish observed behavior from inferred business meaning.
