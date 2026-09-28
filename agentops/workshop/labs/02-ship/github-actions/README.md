# Ship with GitHub Actions

[Lab sequence](../../README.md) | [Ship lab, step 3](../lab.md#3-adapt-the-pipeline-to-your-release-process)

You generated `.github\workflows\agentops-deploy-dev.yml` in
[step 2](../lab.md#2-generate-the-pipeline-and-read-what-it-does). Make the six
edits below in that file, then return to the lab. The instructor has already
created the Azure sign-in, the repository variables and the `production`
environment that asks for approval.

**On this page**

- [1. Run on your branch](#1-run-on-your-branch)
- [2. Pass the class settings to every job](#2-pass-the-class-settings-to-every-job)
- [3. Deploy the test agent](#3-deploy-the-test-agent)
- [4. Evaluate the version you just deployed](#4-evaluate-the-version-you-just-deployed)
- [5. Release after approval and smoke-test](#5-release-after-approval-and-smoke-test)
- [6. Put in your alias](#6-put-in-your-alias)
- [Check your file](#check-your-file)
- [Approve, reject and roll back on GitHub](#approve-reject-and-roll-back-on-github)

## 1. Run on your branch

The generated file runs on pushes to `develop` and asks for inputs you do not
need. Replace everything from `name:` down to the line before `permissions:`.

**What this block does:** names the workflow after you and runs it on every push to your branch, or on demand from the **Actions** tab.

```yaml
name: Ship ALIAS

on:
  push:
    branches:
      - ship/ALIAS
  workflow_dispatch:
```

## 2. Pass the class settings to every job

The deploy script needs the class Foundry project details. They are repository
variables the instructor created. Add this block right after the
`concurrency:` block, before `jobs:`.

**What this block does:** makes the class settings available to every step of every job.

```yaml
env:
  AZURE_TENANT_ID: ${{ vars.AZURE_TENANT_ID }}
  AZURE_SUBSCRIPTION_ID: ${{ vars.AZURE_SUBSCRIPTION_ID }}
  AZURE_LOCATION: ${{ vars.AZURE_LOCATION }}
  AZURE_RESOURCE_GROUP: ${{ vars.AZURE_RESOURCE_GROUP }}
  AZURE_AI_PROJECT_ID: ${{ vars.AZURE_AI_PROJECT_ID }}
  FOUNDRY_PROJECT_ENDPOINT: ${{ vars.FOUNDRY_PROJECT_ENDPOINT }}
  AZURE_AI_MODEL_DEPLOYMENT_NAME: ${{ vars.AZURE_AI_MODEL_DEPLOYMENT_NAME }}
```

## 3. Deploy the test agent

The `provision` job would create Azure resources. Turn it into the job that
deploys your test agent and hands its version number to the evaluation.

1. Replace the job's first lines, from `provision:` down to `steps:`:

   **What this block does:** renames the job and declares the version number as its output.

   ```yaml
     test-deploy:
       name: Deploy test agent
       runs-on: ubuntu-latest
       environment: dev
       timeout-minutes: 45
       outputs:
         version: ${{ steps.deploy.outputs.version }}
       steps:
   ```

2. Keep the steps up to and including **azd auth login (OIDC)**.
3. Replace the two steps **Prepare azd environment** and **Run azd provision** with:

   **What this block does:** deploys `helpdesk-ALIAS-test` and saves the version number Foundry assigned to it.

   ```yaml
         - name: Deploy helpdesk-ALIAS-test
           id: deploy
           run: |
             version=$(bash scripts/deploy-agent.sh helpdesk-ALIAS-test)
             echo "Deployed helpdesk-ALIAS-test version $version"
             echo "version=$version" >> "$GITHUB_OUTPUT"
   ```

## 4. Evaluate the version you just deployed

In the `eval` job, change two lines. Everything else stays as generated.

1. Change `needs: provision` to `needs: test-deploy`.
2. In the **Run AgentOps eval** step, change the `AGENTOPS_AGENT` line to:

   **What this block does:** tells the AgentOps Accelerator CLI to evaluate the version the previous job deployed, instead of version `1`.

   ```yaml
             AGENTOPS_AGENT: ${{ needs.test-deploy.outputs.version }}
   ```

## 5. Release after approval and smoke-test

1. Replace the `deploy` job's first lines, from `deploy:` down to `environment: dev`:

   **What this block does:** runs this job in the `production` environment, so GitHub waits for a reviewer to approve before it starts.

   ```yaml
     release:
       name: Release (production)
       needs: eval
       runs-on: ubuntu-latest
       environment: production
   ```

2. Keep the steps up to and including **azd auth login (OIDC)**.
3. Replace the last step, **Run azd deploy**, with:

   **What this block does:** deploys only `helpdesk-ALIAS`, then sends it the VPN request and fails unless the ticket goes to Network Support.

   ```yaml
         - name: Deploy helpdesk-ALIAS
           run: bash scripts/deploy-agent.sh helpdesk-ALIAS

         - name: Smoke test
           run: bash scripts/smoke-test.sh helpdesk-ALIAS
   ```

## 6. Put in your alias

Press **Ctrl+H** in the editor and replace every `ALIAS` with your alias,
exactly as you typed it in step 1 of the lab. Save the file.

**Expected result:** the file names `ship/<your alias>`,
`helpdesk-<your alias>-test` and `helpdesk-<your alias>`, and has three
jobs: `test-deploy`, `eval` and `release`.

## Check your file

Compare your file with the finished version below if a run fails to start or a
job behaves unexpectedly. Your file has your alias instead of `ALIAS`.

<details>
<summary>Finished workflow</summary>

**What this block does:** deploys and evaluates the test agent, waits for approval, then releases and smoke-tests the released agent.

```yaml
name: Ship ALIAS

on:
  push:
    branches:
      - ship/ALIAS
  workflow_dispatch:

permissions:
  contents: read
  id-token: write
  packages: write

concurrency:
  group: agentops-deploy-dev-${{ github.ref }}
  cancel-in-progress: false

env:
  AZURE_TENANT_ID: ${{ vars.AZURE_TENANT_ID }}
  AZURE_SUBSCRIPTION_ID: ${{ vars.AZURE_SUBSCRIPTION_ID }}
  AZURE_LOCATION: ${{ vars.AZURE_LOCATION }}
  AZURE_RESOURCE_GROUP: ${{ vars.AZURE_RESOURCE_GROUP }}
  AZURE_AI_PROJECT_ID: ${{ vars.AZURE_AI_PROJECT_ID }}
  FOUNDRY_PROJECT_ENDPOINT: ${{ vars.FOUNDRY_PROJECT_ENDPOINT }}
  AZURE_AI_MODEL_DEPLOYMENT_NAME: ${{ vars.AZURE_AI_MODEL_DEPLOYMENT_NAME }}

jobs:
  test-deploy:
    name: Deploy test agent
    runs-on: ubuntu-latest
    environment: dev
    timeout-minutes: 45
    outputs:
      version: ${{ steps.deploy.outputs.version }}
    steps:
      - name: Checkout
        uses: actions/checkout@v6

      - name: Set up azd
        uses: Azure/setup-azd@v2

      - name: Azure login (OIDC)
        uses: azure/login@v3
        with:
          client-id: ${{ vars.AZURE_CLIENT_ID }}
          tenant-id: ${{ vars.AZURE_TENANT_ID }}
          subscription-id: ${{ vars.AZURE_SUBSCRIPTION_ID }}

      - name: Install pinned azd AI agents extension
        env:
          AGENTOPS_AZD_AI_AGENTS_EXTENSION_VERSION: "1.0.0-beta.9"
        run: |
          azd extension install azure.ai.agents --version "$AGENTOPS_AZD_AI_AGENTS_EXTENSION_VERSION"

      - name: azd auth login (OIDC)
        env:
          AZURE_CLIENT_ID: ${{ vars.AZURE_CLIENT_ID }}
          AZURE_TENANT_ID: ${{ vars.AZURE_TENANT_ID }}
        run: |
          azd auth login \
            --client-id "$AZURE_CLIENT_ID" \
            --tenant-id "$AZURE_TENANT_ID" \
            --federated-credential-provider github

      - name: Deploy helpdesk-ALIAS-test
        id: deploy
        run: |
          version=$(bash scripts/deploy-agent.sh helpdesk-ALIAS-test)
          echo "Deployed helpdesk-ALIAS-test version $version"
          echo "version=$version" >> "$GITHUB_OUTPUT"

  eval:
    name: Eval (gate)
    needs: test-deploy
    runs-on: ubuntu-latest
    environment: dev
    timeout-minutes: 30
    steps:
      - name: Checkout
        uses: actions/checkout@v6

      - name: Azure login (OIDC)
        uses: azure/login@v3
        with:
          client-id: ${{ vars.AZURE_CLIENT_ID }}
          tenant-id: ${{ vars.AZURE_TENANT_ID }}
          subscription-id: ${{ vars.AZURE_SUBSCRIPTION_ID }}

      - name: Set up Python
        uses: actions/setup-python@v6
        with:
          python-version: "3.11"

      - name: Install uv
        uses: astral-sh/setup-uv@v7
        with:
          enable-cache: false

      - name: Install AgentOps Toolkit
        run: |
          uv pip install --system "agentops-accelerator==0.15.0"

      - name: Run AgentOps eval
        id: eval
        env:
          AZURE_AI_FOUNDRY_PROJECT_ENDPOINT: ${{ vars.AZURE_AI_FOUNDRY_PROJECT_ENDPOINT }}
          AZURE_OPENAI_ENDPOINT: ${{ vars.AZURE_OPENAI_ENDPOINT }}
          AZURE_OPENAI_DEPLOYMENT: ${{ vars.AZURE_OPENAI_DEPLOYMENT }}
          AZURE_OPENAI_MODEL_NAME: ${{ vars.AZURE_OPENAI_MODEL_NAME }}
          APPLICATIONINSIGHTS_CONNECTION_STRING: ${{ secrets.APPLICATIONINSIGHTS_CONNECTION_STRING || vars.APPLICATIONINSIGHTS_CONNECTION_STRING }}
          AGENTOPS_AGENT: ${{ needs.test-deploy.outputs.version }}
        run: |
          set +e
          agentops eval run --config "agentops.yaml"
          ec=$?
          echo "exit_code=$ec" >> "$GITHUB_OUTPUT"
          if [ $ec -eq 0 ]; then
            echo "result=pass" >> "$GITHUB_OUTPUT"
          elif [ $ec -eq 2 ]; then
            echo "result=threshold_failed" >> "$GITHUB_OUTPUT"
          else
            echo "result=error" >> "$GITHUB_OUTPUT"
          fi
          exit $ec

      - name: Detect AgentOps governance gates
        id: governance
        env:
          AGENTOPS_CONFIG: "agentops.yaml"
        run: |
          python - <<'PY'
          import os
          from pathlib import Path
          from agentops.utils.yaml import load_yaml

          config = Path(os.environ["AGENTOPS_CONFIG"])
          data = load_yaml(config) if config.exists() else {}
          has_assert = isinstance(data, dict) and "assert" in data
          has_redteam = isinstance(data, dict) and "redteam" in data
          with Path(os.environ["GITHUB_ENV"]).open("a", encoding="utf-8") as env_file:
              env_file.write(f"AGENTOPS_HAS_ASSERT={str(has_assert).lower()}\n")
              env_file.write(f"AGENTOPS_HAS_REDTEAM={str(has_redteam).lower()}\n")
          print(f"ASSERT gate: {has_assert}")
          print(f"Red Team gate: {has_redteam}")
          PY

      - name: Install AgentOps governance dependencies
        if: env.AGENTOPS_HAS_ASSERT == 'true' || env.AGENTOPS_HAS_REDTEAM == 'true'
        run: |
          if [ "$AGENTOPS_HAS_ASSERT" = "true" ]; then
            uv pip install --system assert-ai
          fi
          if [ "$AGENTOPS_HAS_REDTEAM" = "true" ]; then
            uv pip install --system "azure-ai-evaluation[redteam]"
          fi

      - name: Run ASSERT gate
        if: env.AGENTOPS_HAS_ASSERT == 'true'
        run: |
          agentops assert run --config "agentops.yaml"

      - name: Run Red Team gate
        if: env.AGENTOPS_HAS_REDTEAM == 'true'
        env:
          AZURE_AI_FOUNDRY_PROJECT_ENDPOINT: ${{ vars.AZURE_AI_FOUNDRY_PROJECT_ENDPOINT }}
          AZURE_OPENAI_ENDPOINT: ${{ vars.AZURE_OPENAI_ENDPOINT }}
          AZURE_OPENAI_DEPLOYMENT: ${{ vars.AZURE_OPENAI_DEPLOYMENT }}
          AZURE_OPENAI_MODEL_NAME: ${{ vars.AZURE_OPENAI_MODEL_NAME }}
          APPLICATIONINSIGHTS_CONNECTION_STRING: ${{ secrets.APPLICATIONINSIGHTS_CONNECTION_STRING || vars.APPLICATIONINSIGHTS_CONNECTION_STRING }}
        run: |
          agentops redteam run --config "agentops.yaml"

      - name: Upload AgentOps results
        if: always()
        uses: actions/upload-artifact@v7
        with:
          name: agentops-dev-results
          path: |
            .agentops/results/latest/results.json
            .agentops/results/latest/report.md
            .agentops/results/latest/cloud_evaluation.json
            .agentops/results/latest/cloud_output_items.json
            .agentops/assert/latest.json
            .agentops/redteam/latest.json
            .agentops/redteam/raw_summary.json
          if-no-files-found: warn

  release:
    name: Release (production)
    needs: eval
    runs-on: ubuntu-latest
    environment: production
    timeout-minutes: 45
    steps:
      - name: Checkout
        uses: actions/checkout@v6

      - name: Set up azd
        uses: Azure/setup-azd@v2

      - name: Azure login (OIDC)
        uses: azure/login@v3
        with:
          client-id: ${{ vars.AZURE_CLIENT_ID }}
          tenant-id: ${{ vars.AZURE_TENANT_ID }}
          subscription-id: ${{ vars.AZURE_SUBSCRIPTION_ID }}

      - name: Install pinned azd AI agents extension
        env:
          AGENTOPS_AZD_AI_AGENTS_EXTENSION_VERSION: "1.0.0-beta.9"
        run: |
          azd extension install azure.ai.agents --version "$AGENTOPS_AZD_AI_AGENTS_EXTENSION_VERSION"

      - name: azd auth login (OIDC)
        env:
          AZURE_CLIENT_ID: ${{ vars.AZURE_CLIENT_ID }}
          AZURE_TENANT_ID: ${{ vars.AZURE_TENANT_ID }}
        run: |
          azd auth login \
            --client-id "$AZURE_CLIENT_ID" \
            --tenant-id "$AZURE_TENANT_ID" \
            --federated-credential-provider github

      - name: Deploy helpdesk-ALIAS
        run: bash scripts/deploy-agent.sh helpdesk-ALIAS

      - name: Smoke test
        run: bash scripts/smoke-test.sh helpdesk-ALIAS
```

</details>

## Approve, reject and roll back on GitHub

- **See the run:** open the repository's **Actions** tab and select your run, named **Ship** plus your alias.
- **Download the results:** at the bottom of the run's summary page, under
  **Artifacts**, download `agentops-dev-results`.
- **Approve or reject:** when the run pauses, select **Review deployments**,
  tick **production**, write a short comment, then select **Approve and deploy**
  or **Reject**.
- **Roll back:** open the last good run, select the **Release (production)** job
  and select **Re-run this job**. It asks for approval again, redeploys that
  run's commit and repeats the smoke test.

Return to [step 4 of the lab](../lab.md#4-run-the-candidate-and-decide).
