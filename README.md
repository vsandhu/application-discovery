# Application Discovery Agent for GitHub Copilot

A reusable GitHub Copilot custom-agent framework for reverse engineering an existing application and producing an evidence-backed discovery package.

The project is designed to be used as the first stage of a larger application modernization pipeline.

## What it produces

The discovery agent analyzes an existing repository and produces:

1. Application overview and scope
2. Core business domains and capabilities
3. High-level and runtime architecture
4. Technology stack
5. Key non-functional characteristics
6. Database structures and relationships
7. External integrations
8. Evidence index and open questions

The generated Markdown is a **view of the canonical discovery model**, rather than an independent source of truth.

## Architecture

The discovery workflow follows:

```text
Repository
    |
    v
Repository Exploration
    |
    v
Evidence
    |
    v
Entities + Findings + Relationships
    |
    v
Canonical discovery-model.yaml
    |
    +-------------------+
    |                   |
    v                   v
Markdown Views      Future Agents
                    (requirements,
                     architecture,
                     modernization,
                     code generation)
```

The canonical model is:

```text
discovery/discovery-model.yaml
```

The model captures stable entities, evidence, findings, relationships, confidence, unknowns, and conflicts across discovery phases.

## Evidence principles

The agent distinguishes:

### Classification

- **Observed** — directly supported by repository artifacts
- **Inferred** — strongly supported by multiple pieces of evidence
- **Unknown** — insufficient repository evidence
- **Conflicting** — repository artifacts disagree

### Confidence

- **High** — directly observed or strongly corroborated
- **Medium** — strong inference from correlated evidence
- **Low** — plausible interpretation with limited evidence
- **Unknown** — no defensible confidence can be assigned

The agent must never invent undocumented business behavior, integrations, database relationships, technology versions, or NFR guarantees.

## Repository structure

```text
.github/
├── agents/
│   └── application-discovery.agent.md
├── skills/
│   ├── repository-exploration/
│   ├── evidence-model/
│   ├── business-domain-discovery/
│   ├── architecture-discovery/
│   ├── technology-discovery/
│   ├── database-discovery/
│   ├── integration-discovery/
│   ├── nfr-discovery/
│   └── documentation-generation/
├── hooks/
│   └── discovery-validation.json
└── copilot-instructions.md

discovery/
├── 00-manifest.md
├── discovery-model.yaml
└── ... generated discovery documents ...

scripts/
└── validate-discovery.ps1
```

## Installation

Copy the `.github`, `discovery`, and `scripts` directories into the target application repository, or install this framework directly into the repository where the application is being analyzed.

### Windows 11 / PowerShell

This project is designed for Windows 11 and uses **PowerShell**, not Unix shell scripts, for deterministic validation.

The validation hook invokes:

```powershell
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File scripts/validate-discovery.ps1
```

You do **not** need to run `chmod`, Bash, `grep`, `sed`, `awk`, or other Unix commands to install or validate the framework.

If PowerShell execution policy is restricted on your machine, the hook uses `-ExecutionPolicy Bypass` for the individual validation process; it does not permanently change your machine's execution policy.

### Other environments

The current supported execution path is Windows PowerShell. If cross-platform execution is required later, the validation logic should be implemented in a platform-neutral way rather than reintroducing Unix-specific assumptions into the agent workflow.

## Validation

Validation is implemented in:

```text
scripts/validate-discovery.ps1
```

The hook is configured in:

```text
.github/hooks/discovery-validation.json
```

Validation is intentionally **phase-aware**.

During intermediate discovery sessions it validates the canonical model without requiring the final Markdown package. Once discovery is marked complete, it additionally validates the required Markdown artifacts and evidence references.

## First invocation

In GitHub Copilot, invoke the `application-discovery` agent and start with Phase 1 only.

Use this prompt:

```text
Use the application-discovery agent.

Perform Phase 1 only.

Analyze this repository and create a repository map.

Do not create the final discovery documentation yet.

Before analysis, read the existing discovery/discovery-model.yaml and preserve any existing evidence.

Identify:
- applications
- deployable services
- modules
- languages
- frameworks
- build systems
- databases
- messaging
- APIs
- external integrations
- deployment/infrastructure
- important configuration
- important tests
- important documentation

For every major finding:
- create or reuse a stable entity where appropriate
- create a unique evidence ID
- use a repository-relative path
- classify the finding as observed, inferred, unknown, or conflicting
- assign confidence
- record relationships where supported

Do not infer business capabilities yet.

Do not modify application source code, configuration, infrastructure, database definitions, or tests.

At the end, report:
1. repository map
2. evidence added
3. entities identified
4. relationships identified
5. high-value artifacts
6. areas requiring deeper analysis
7. unknowns
8. conflicting evidence
```

## Discovery workflow

The agent executes discovery in phases:

```text
1. Repository reconnaissance
2. Application boundary
3. Business domain discovery
4. Architecture discovery
5. Technology discovery
6. Database discovery
7. External integration discovery
8. NFR discovery
9. Evidence consolidation
10. Markdown generation
11. Validation
```

Each phase contributes to the same canonical model.

Later phases must refine earlier findings rather than silently replacing them.

## Discovery outputs

The final discovery package contains:

```text
discovery/
├── 00-manifest.md
├── 01-application-overview.md
├── 02-business-domains.md
├── 03-architecture.md
├── 04-technology-stack.md
├── 05-non-functional-characteristics.md
├── 06-database.md
├── 07-external-integrations.md
└── 08-evidence-index.md
```

The canonical machine-readable state is:

```text
discovery/discovery-model.yaml
```

## Safety rules

The discovery agent must not modify:

- application source code
- application configuration
- infrastructure definitions
- database schema
- tests

It must also never copy:

- passwords
- API keys
- access tokens
- private keys
- certificates
- connection secrets

into discovery artifacts.

## Current status

This repository is being developed incrementally. The current branch introduces the canonical evidence model and Windows-compatible validation. The next major validation step is to execute Phase 1 against a real application repository and evaluate the quality of the generated evidence and relationships.

## Roadmap

### Phase 1 — Discovery foundation

- [x] Custom application-discovery agent
- [x] Repository exploration skill
- [x] Evidence model skill
- [x] Canonical machine-readable discovery model
- [x] Stable entities, findings, and relationships
- [x] Evidence classification and confidence
- [x] Windows PowerShell validation
- [ ] Full schema validation
- [ ] End-to-end Phase 1 test against a real application

### Phase 2 — Discovery intelligence

- [ ] Business-domain discovery refinement
- [ ] Architecture relationship inference
- [ ] Database-to-business correlation
- [ ] Integration correlation
- [ ] NFR evidence analysis
- [ ] Automated Markdown rendering from the model
- [ ] Evidence consistency validation

### Phase 3 — Modernization pipeline

- [ ] Business requirements extraction
- [ ] Target-state architecture
- [ ] Target data model
- [ ] API and event contract generation
- [ ] Modernization strategy
- [ ] Reimagined application generation
- [ ] Traceability from legacy evidence to target implementation

## Modernization vision

The long-term pipeline is:

```text
Legacy Application
        |
        v
Application Discovery
        |
        v
Evidence / Knowledge Model
        |
        +----------------------+
        |                      |
        v                      v
Business Requirements    Current Architecture
        |                      |
        +----------+-----------+
                   |
                   v
             Target Architecture
                   |
                   v
             Target Data Model
                   |
                   v
          APIs / Events / Contracts
                   |
                   v
          Reimagined Application
```

The discovery model is intentionally designed to become the traceability layer connecting the legacy implementation to the future application.
