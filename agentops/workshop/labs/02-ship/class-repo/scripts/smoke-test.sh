#!/usr/bin/env bash
# Sends one VPN request to the deployed agent and checks that the ticket went
# to Network Support. Fails when the reply names another team.
# Usage: bash scripts/smoke-test.sh helpdesk-alias
set -euo pipefail

service="$1"
version=$(bash "$(dirname "$0")/agent-version.sh" "$service")
echo "Testing $service version $version"

reply=$(azd ai agent invoke "$service" --version "$version" \
  --protocol responses --new-conversation \
  'VPN reconnect and sign-in failed. Check service status and create a VPN ticket.')
echo "$reply"

if ! grep -qi 'network support' <<<"$reply"; then
  echo "Smoke test failed: the VPN ticket did not go to Network Support." >&2
  exit 1
fi
echo "Smoke test passed."
