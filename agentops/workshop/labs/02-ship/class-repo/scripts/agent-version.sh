#!/usr/bin/env bash
# Prints the version number of an agent service that azd has deployed.
# Usage: bash scripts/agent-version.sh helpdesk-alias-test
set -euo pipefail

service="$1"
key=$(echo "$service" | tr 'a-z-' 'A-Z_')
version=$(azd env get-value "AGENT_${key}_VERSION" 2>/dev/null || true)

if [ -z "$version" ]; then
  version=$(azd ai agent show "$service" --output json \
    | jq -r '[.. | objects | .version? | select(. != null)][0] // empty')
fi

if [ -z "$version" ]; then
  echo "Cannot read the deployed version of $service" >&2
  exit 1
fi
echo "$version"
