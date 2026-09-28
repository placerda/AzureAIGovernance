#!/usr/bin/env bash
# Deploys one help desk agent to the existing class Foundry project and prints
# the version number Foundry assigned to it. Creates no Azure resources.
# Usage: bash scripts/deploy-agent.sh helpdesk-alias-test
set -euo pipefail

service="$1"
: "${AZURE_ENV_NAME:=dev}"

for name in AZURE_TENANT_ID AZURE_SUBSCRIPTION_ID AZURE_LOCATION \
            AZURE_RESOURCE_GROUP AZURE_AI_PROJECT_ID FOUNDRY_PROJECT_ENDPOINT \
            AZURE_AI_MODEL_DEPLOYMENT_NAME; do
  if [ -z "${!name:-}" ]; then
    echo "Missing pipeline variable: $name" >&2
    exit 1
  fi
done

# The project resource ID ends in .../accounts/ACCOUNT/projects/PROJECT.
account_name=$(echo "$AZURE_AI_PROJECT_ID" | sed -E 's#.*/accounts/([^/]+)/projects/.*#\1#')
project_name=$(echo "$AZURE_AI_PROJECT_ID" | sed -E 's#.*/projects/([^/]+)$#\1#')

# azd progress goes to the log; only the version number goes to the output.
{
  azd env new "$AZURE_ENV_NAME" --no-prompt \
    --subscription "$AZURE_SUBSCRIPTION_ID" --location "$AZURE_LOCATION" \
    || azd env select "$AZURE_ENV_NAME"
  azd env set AZURE_TENANT_ID "$AZURE_TENANT_ID"
  azd env set AZURE_SUBSCRIPTION_ID "$AZURE_SUBSCRIPTION_ID"
  azd env set AZURE_LOCATION "$AZURE_LOCATION"
  azd env set AZURE_RESOURCE_GROUP "$AZURE_RESOURCE_GROUP"
  azd env set AZURE_AI_PROJECT_ID "$AZURE_AI_PROJECT_ID"
  azd env set AZURE_AI_ACCOUNT_NAME "$account_name"
  azd env set AZURE_AI_PROJECT_NAME "$project_name"
  azd env set AZURE_AI_PROJECT_ENDPOINT "$FOUNDRY_PROJECT_ENDPOINT"
  azd env set FOUNDRY_PROJECT_ENDPOINT "$FOUNDRY_PROJECT_ENDPOINT"
  azd env set AZURE_AI_MODEL_DEPLOYMENT_NAME "$AZURE_AI_MODEL_DEPLOYMENT_NAME"
  azd deploy "$service" --no-prompt
} >&2

bash "$(dirname "$0")/agent-version.sh" "$service"
