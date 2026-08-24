---
name: documentation-generation
description: Renders consistent Markdown discovery documentation from the canonical discovery model without inventing unsupported information.
---

# Documentation Generation

## Objective

Render `discovery/discovery-model.yaml` into Markdown views. The model is the source of truth; Markdown is a presentation layer.

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

## Rendering rules

1. Read the complete canonical model before writing documents.
2. Render only facts represented by entities, findings, relationships, and evidence.
3. Preserve classification and confidence for significant findings.
4. Put evidence IDs next to material claims.
5. Cross-reference related documents instead of duplicating large sections.
6. Render unknowns and conflicts explicitly.
7. Never invent missing values.
8. Never copy secret values from configuration evidence.

## Required sections

### 01 Application Overview
- Purpose
- Scope
- Actors
- Application Boundaries
- Major Capabilities
- Major Workflows
- Key Findings
- Evidence
- Open Questions

### 02 Business Domains
- Domain Landscape
- Domains
- Capabilities
- Business Rules
- Workflows
- Domain Relationships
- Evidence
- Open Questions

### 03 Architecture
- Architecture Overview
- Architectural Style
- Major Components
- Component Responsibilities
- Runtime Interactions
- Data Flow
- Deployment Architecture
- Architecture Characteristics
- Mermaid Diagrams
- Evidence
- Open Questions

### 04 Technology Stack
- Languages
- Frameworks
- Libraries
- Databases
- Messaging
- APIs
- Infrastructure
- Build and Delivery
- Observability
- Evidence
- Unknowns

### 05 Non-Functional Characteristics
- Scalability
- Availability
- Resilience
- Performance
- Security
- Reliability
- Observability
- Maintainability
- Recoverability
- Evidence
- Unknowns

### 06 Database
- Database Technologies
- Schemas
- Tables
- Important Entities
- Relationships
- Indexes
- Views
- Procedures
- Triggers
- Application Usage
- Evidence
- Open Questions

### 07 External Integrations
- Integration Landscape
- APIs
- Messaging
- File Integrations
- External Platforms
- Authentication
- Data Exchange
- Integration Patterns
- Evidence
- Open Questions

### 08 Evidence Index
Include every evidence record with:
- evidence ID
- category
- path
- artifact
- location when available
- description

Also include findings summary, unresolved conflicts, and open questions.

## Evidence format

```markdown
The application exposes customer-management REST endpoints. [E014]

**Classification:** Observed  
**Confidence:** High
```

Never cite an evidence ID that does not exist in the model.

## Mermaid rules

Architecture diagrams must be derived from model entities and relationships. Do not introduce unsupported components, systems, databases, or integrations.

## Final check

Before declaring documentation complete:

- all required files exist
- every material claim has model support
- every evidence reference resolves
- classification/confidence are preserved
- unknowns are visible
- conflicts are visible
