# Application Discovery Repository Instructions

This repository uses GitHub Copilot for evidence-backed application discovery.

## Safety

- Do not modify application source code during discovery.
- Do not modify application configuration.
- Do not modify infrastructure definitions.
- Do not modify database schemas.
- Do not modify tests.
- Never copy credentials, tokens, passwords, private keys, certificates, or secrets into discovery documents.
- Treat external services as unknown unless repository evidence supports their existence.

## Evidence

Use repository-relative paths.

Classify significant findings as:
- Observed
- Inferred
- Unknown
- Conflicting

Assign confidence:
- High
- Medium
- Low
- Unknown

Prefer direct repository evidence over assumptions.

## Discovery output

All generated discovery documentation belongs under `discovery/`.

Required artifacts:
- 00-manifest.md
- 01-application-overview.md
- 02-business-domains.md
- 03-architecture.md
- 04-technology-stack.md
- 05-non-functional-characteristics.md
- 06-database.md
- 07-external-integrations.md
- 08-evidence-index.md
