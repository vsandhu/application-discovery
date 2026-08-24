# Application Discovery Agent for GitHub Copilot

A reusable GitHub Copilot custom-agent framework for reverse engineering an existing application and producing an evidence-backed discovery package. It is designed as the first stage of a larger application modernization pipeline.

## What it produces

1. Application overview and scope
2. Core business domains and capabilities
3. High-level and runtime architecture
4. Technology stack
5. Key non-functional characteristics
6. Database structures and relationships
7. External integrations
8. Text-file layouts and field-level data lineage
9. Evidence index and open questions

The generated Markdown is a **view of the canonical discovery model**, not an independent source of truth.

## Architecture

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
    +---------------------------+
    |                           |
    v                           v
Markdown Views              Future Agents
                            requirements / architecture /
                            modernization / code generation
```

The canonical model is `discovery/discovery-model.yaml`. It captures stable entities, evidence, findings, relationships, confidence, unknowns, conflicts, file layouts, and field-level lineage.

## Evidence principles

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

The agent must never invent undocumented business behavior, integrations, database relationships, technology versions, file layouts, field lineage, or NFR guarantees.

## Repository structure

```text
.github/
├── agents/application-discovery.agent.md
├── skills/
│   ├── repository-exploration/
│   ├── evidence-model/
│   ├── business-domain-discovery/
│   ├── architecture-discovery/
│   ├── technology-discovery/
│   ├── database-discovery/
│   ├── integration-discovery/
│   ├── file-layout-discovery/
│   ├── nfr-discovery/
│   └── documentation-generation/
├── hooks/discovery-validation.json
└── copilot-instructions.md

discovery/
├── 00-manifest.md
├── 01-application-overview.md
├── 02-business-domains.md
├── 03-architecture.md
├── 04-technology-stack.md
├── 05-non-functional-characteristics.md
├── 06-database.md
├── 07-external-integrations.md
├── 08-evidence-index.md
├── 09-file-layouts.md
├── discovery-model.yaml
└── discovery-model.schema.json

scripts/
└── validate-discovery.ps1
```

## Installation

Copy the `.github`, `discovery`, and `scripts` directories into the target application repository, or install this framework directly into the repository being analyzed.

### Windows 11 / PowerShell

The supported execution path is **Windows 11 with PowerShell**. Validation does not require Bash or Unix utilities.

The validation hook invokes:

```powershell
powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -File scripts/validate-discovery.ps1
```

You do not need `chmod`, Bash, `grep`, `sed`, `awk`, or other Unix commands to install or validate the framework.

The `-ExecutionPolicy Bypass` option applies only to this validation process; it does not permanently change the machine execution policy.

## Validation

Validation is implemented in `scripts/validate-discovery.ps1` and configured in `.github/hooks/discovery-validation.json`.

Validation is phase-aware: intermediate sessions validate the canonical model without requiring every final Markdown document; completed discovery additionally validates the required documents, file-layout artifacts, and evidence references.

## First invocation

In GitHub Copilot, invoke the `application-discovery` agent and start with Phase 1 only:

```text
Use the application-discovery agent.

Perform Phase 1 only.

Analyze this repository and create a repository map.

Do not create the final discovery documentation yet.

Before analysis, read discovery/discovery-model.yaml and preserve existing evidence.

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
- text files and file-processing code

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
5. text-file candidates identified
6. high-value artifacts
7. areas requiring deeper analysis
8. unknowns
9. conflicting evidence
```

## Discovery workflow

```text
1. Repository reconnaissance
2. Application boundary
3. Business domain discovery
4. Architecture discovery
5. Technology discovery
6. Database discovery
7. External integration discovery
8. Text-file layout and field lineage discovery
9. NFR discovery
10. Evidence consolidation
11. Markdown generation
12. Validation
```

Each phase contributes to the same canonical model. Later phases refine earlier findings rather than silently replacing them.

## Text-file layout and field lineage

The `file-layout-discovery` skill identifies:

- CSV
- TSV
- pipe- or other delimited files
- fixed-width/fixed-length files
- positional flat files
- batch input/output files
- text-based integration files

For each file, the agent attempts to establish **field-level lineage**.

Example:

```text
CUSTOMER.CUSTOMER_ID
        |
        v
Customer entity
        |
        v
CustomerExportMapper
        |
        v
customer_export.csv:CUSTOMER_ID
```

Calculated example:

```text
CUSTOMER.FIRST_NAME ----+
                        +--> FULL_NAME
CUSTOMER.LAST_NAME -----+
```

Each field is classified as:

- **Database**
- **Calculated**
- **Constant**
- **Configuration**
- **External**
- **Unknown**

For fixed-width files, start/end position, length, padding, alignment, and zero-based/one-based convention are recorded when supported by evidence.

The rendered output is `discovery/09-file-layouts.md`; the canonical representation remains `discovery/discovery-model.yaml`.

A source field is never guessed. If lineage cannot be established, it is explicitly recorded as unknown and may generate an open question.

## Discovery outputs

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
└── 09-file-layouts.md
```

The canonical machine-readable state is `discovery/discovery-model.yaml`; its schema is `discovery/discovery-model.schema.json`.

## Safety rules

The discovery agent must not modify application source code, application configuration, infrastructure definitions, database schema, or tests.

It must never copy passwords, API keys, access tokens, private keys, certificates, or connection secrets into discovery artifacts.

## Current status

The repository currently contains the canonical evidence model, stable entities/findings/relationships, Windows PowerShell validation, and text-file field-lineage discovery. The next validation step is to execute the workflow against a real application repository and evaluate evidence quality, database lineage, file lineage, and relationship accuracy.

## Roadmap

### Discovery foundation

- [x] Custom application-discovery agent
- [x] Repository exploration skill
- [x] Evidence model skill
- [x] Canonical machine-readable discovery model
- [x] Stable entities, findings, and relationships
- [x] Evidence classification and confidence
- [x] Windows PowerShell validation
- [x] Text-file layout discovery
- [x] Field-level lineage model
- [ ] Full schema validation
- [ ] End-to-end Phase 1 test against a real application

### Discovery intelligence

- [ ] Business-domain discovery refinement
- [ ] Architecture relationship inference
- [ ] Database-to-business correlation
- [ ] Database-to-file field lineage correlation
- [ ] Integration correlation
- [ ] NFR evidence analysis
- [ ] Automated Markdown rendering from the model
- [ ] Evidence consistency validation

### Modernization pipeline

- [ ] Business requirements extraction
- [ ] Target-state architecture
- [ ] Target data model
- [ ] API and event contract generation
- [ ] Legacy file-to-target API/event mapping
- [ ] Modernization strategy
- [ ] Reimagined application generation
- [ ] Traceability from legacy evidence to target implementation

## Modernization vision

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

The discovery model is intentionally designed to become the traceability layer connecting the legacy implementation, database structures, file layouts, business capabilities, and future application.
