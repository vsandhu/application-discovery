#!/usr/bin/env bash
set -euo pipefail

DISCOVERY_DIR="discovery"

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

if [[ ! -d "$DISCOVERY_DIR" ]]; then
  echo "Discovery directory does not exist; validation skipped."
  exit 0
fi

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

# Check that evidence references have a corresponding Evidence Index.
if grep -RhoE '\[E[0-9]{3,}\]' "$DISCOVERY_DIR"/*.md 2>/dev/null \
  | sort -u > /tmp/discovery-refs.txt; then
  true
fi

if [[ -f "$DISCOVERY_DIR/08-evidence-index.md" ]]; then
  while read -r ref; do
    [[ -z "$ref" ]] && continue
    if ! grep -q "$ref" "$DISCOVERY_DIR/08-evidence-index.md"; then
      echo "ERROR: Evidence reference $ref is not present in evidence index."
      failed=1
    fi
  done < /tmp/discovery-refs.txt
fi

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi

echo "Discovery validation passed."
