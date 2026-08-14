#!/usr/bin/env bash
set -euo pipefail

DISCOVERY_DIR="discovery"
MODEL="$DISCOVERY_DIR/discovery-model.yaml"
MANIFEST="$DISCOVERY_DIR/00-manifest.md"

if [[ ! -d "$DISCOVERY_DIR" ]]; then
  echo "Discovery directory does not exist; validation skipped."
  exit 0
fi

# The agent is intentionally incremental. Do not fail an agent session merely
# because the final Markdown package has not been generated yet.
if [[ ! -f "$MODEL" ]]; then
  echo "WARNING: discovery/discovery-model.yaml is missing."
  exit 0
fi

# Basic YAML sanity checks that do not require third-party tooling.
if ! grep -q '^version:' "$MODEL"; then
  echo "ERROR: discovery model is missing version."
  exit 1
fi

if ! grep -q '^evidence:' "$MODEL"; then
  echo "ERROR: discovery model is missing the evidence section."
  exit 1
fi

# If discovery has not been marked complete, validate only the model and exit.
if [[ ! -f "$MANIFEST" ]] || ! grep -qi 'Status:.*complete' "$MANIFEST"; then
  echo "Discovery validation: intermediate state is valid; final-document checks deferred."
  exit 0
fi

required=(
  "00-manifest.md"
  "01-application-overview.md"
  "02-business-domains.md"
  "03-architecture.md"
  "04-technology-stack.md"
  "05-non-functional-characteristics.md"
  "06-database.md"
  "07-external-integrations.md"
  "08-evidence-index.md"
)

failed=0

for file in "${required[@]}"; do
  if [[ ! -f "$DISCOVERY_DIR/$file" ]]; then
    echo "ERROR: Missing $DISCOVERY_DIR/$file"
    failed=1
  fi
done

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi

# Check that Markdown evidence references have a corresponding Evidence Index.
refs_file="$(mktemp)"
trap 'rm -f "$refs_file"' EXIT

grep -RhoE '\[E[0-9]{3,}\]' "$DISCOVERY_DIR"/*.md 2>/dev/null \
  | sort -u > "$refs_file" || true

while read -r ref; do
  [[ -z "$ref" ]] && continue
  if ! grep -q "$ref" "$DISCOVERY_DIR/08-evidence-index.md"; then
    echo "ERROR: Evidence reference $ref is not present in evidence index."
    failed=1
  fi
done < "$refs_file"

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi

echo "Discovery validation passed."
