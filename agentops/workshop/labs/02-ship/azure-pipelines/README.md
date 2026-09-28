# Ship with Azure Pipelines

[Lab sequence](../../README.md) | [Ship lab, step 3](../lab.md#3-adapt-the-pipeline-to-your-release-process)

You generated `.azuredevops\pipelines\agentops-deploy-dev.yml` in
[step 2](../lab.md#2-generate-the-pipeline-and-read-what-it-does). Make the six
edits below, then return to the lab. The instructor has already created the
`agentops-azure` service connection, the `agentops` variable group and the
`production` environment that asks for approval.

**On this page**

- [1. Give the file your own name](#1-give-the-file-your-own-name)
- [2. Run on your branch](#2-run-on-your-branch)
- [3. Deploy the test agent](#3-deploy-the-test-agent)
- [4. Evaluate the version you just deployed](#4-evaluate-the-version-you-just-deployed)
- [5. Release after approval and smoke-test](#5-release-after-approval-and-smoke-test)
- [6. Put in your alias](#6-put-in-your-alias)
- [Check your file](#check-your-file)
- [Create the pipeline](#create-the-pipeline)
- [Approve, reject and roll back on Azure Pipelines](#approve-reject-and-roll-back-on-azure-pipelines)

## 1. Give the file your own name

Azure Pipelines reads the pipeline file from the branch that was pushed. If
everyone kept the same file name, every participant's pipeline would start on
every push. A file named after you keeps your pipeline to your branch.

**What this block does:** renames the generated file to `ship-<your alias>.yml`. Run it in the PowerShell window from step 1 of the lab. Local only.

```powershell
Rename-Item .azuredevops\pipelines\agentops-deploy-dev.yml "ship-$Alias.yml"
```

Open `.azuredevops\pipelines\ship-<your alias>.yml` in any editor for the next edits.

## 2. Run on your branch

1. Under `trigger:`, change `develop` to `ship/ALIAS`.
2. Under `variables:`, delete the two lines for `RUN_AZD_PROVISION`. Nothing
   in your pipeline creates Azure resources.

## 3. Deploy the test agent

The `provision` stage would create Azure resources. Replace the whole stage,
from `- stage: provision` down to the line before `- stage: eval`, with the
block below.

**What this block does:** installs azd, deploys `helpdesk-ALIAS-test` and saves the version number Foundry assigned to it for the next stage.

```yaml
  - stage: test_deploy
    displayName: Deploy test agent
    jobs:
      - job: deploy_test_agent
        steps:
          - checkout: self
          - task: AzureCLI@2
            name: deploy
            displayName: Deploy helpdesk-ALIAS-test
            inputs:
              azureSubscription: $(AZURE_SERVICE_CONNECTION)
              scriptType: bash
              scriptLocation: inlineScript
              inlineScript: |
                set -euo pipefail
                curl -fsSL https://aka.ms/install-azd.sh | bash
                azd extension install azure.ai.agents --version "1.0.0-beta.9"
                azd config set auth.useAzCliAuth "true"
                version=$(bash scripts/deploy-agent.sh helpdesk-ALIAS-test)
                echo "Deployed helpdesk-ALIAS-test version $version"
                echo "##vso[task.setvariable variable=AGENT_VERSION;isOutput=true]$version"
```

## 4. Evaluate the version you just deployed

In the `eval` stage:

1. Change `dependsOn: provision` to `dependsOn: test_deploy`.
2. Add a `variables:` block right under `- job: eval_gate`, at the same
   indentation as `steps:`:

   **What this block does:** reads the version number from the previous stage, so the AgentOps Accelerator CLI evaluates that version instead of version `1`.

   ```yaml
           variables:
             AGENTOPS_AGENT: $[ stageDependencies.test_deploy.deploy_test_agent.outputs['deploy.AGENT_VERSION'] ]
   ```

Everything else in the stage stays as generated.

## 5. Release after approval and smoke-test

Replace the whole `deploy` stage, from `- stage: deploy` to the end of the
file, with the block below.

**What this block does:** runs in the `production` environment, so Azure Pipelines waits for approval. Then it deploys only `helpdesk-ALIAS`, sends it the VPN request and fails unless the ticket goes to Network Support.

```yaml
  - stage: release
    displayName: Release (production)
    dependsOn: eval
    jobs:
      - deployment: release
        environment: production
        strategy:
          runOnce:
            deploy:
              steps:
                - checkout: self
                - task: AzureCLI@2
                  displayName: Deploy helpdesk-ALIAS and smoke test
                  inputs:
                    azureSubscription: $(AZURE_SERVICE_CONNECTION)
                    scriptType: bash
                    scriptLocation: inlineScript
                    inlineScript: |
                      set -euo pipefail
                      curl -fsSL https://aka.ms/install-azd.sh | bash
                      azd extension install azure.ai.agents --version "1.0.0-beta.9"
                      azd config set auth.useAzCliAuth "true"
                      bash scripts/deploy-agent.sh helpdesk-ALIAS
                      bash scripts/smoke-test.sh helpdesk-ALIAS
```

## 6. Put in your alias

Press **Ctrl+H** in the editor and replace every `ALIAS` with your alias,
exactly as you typed it in step 1 of the lab. Save the file.

**Expected result:** the file names `ship/<your alias>`,
`helpdesk-<your alias>-test` and `helpdesk-<your alias>`, and has three
stages: `test_deploy`, `eval` and `release`.

## Check your file

Compare your file with the finished version below if the pipeline fails to
start or a stage behaves unexpectedly. Your file has your alias instead of
`ALIAS`.

<details>
<summary>Finished pipeline</summary>

**What this block does:** deploys and evaluates the test agent, waits for approval, then releases and smoke-tests the released agent.

```yaml
trigger:
  branches:
    include:
      - ship/ALIAS

pr: none

pool:
  vmImage: ubuntu-latest

variables:
  - group: agentops
  - name: AZURE_SERVICE_CONNECTION
    value: agentops-azure
  - name: AGENTOPS_CONFIG
    value: agentops.yaml
  - name: AZURE_ENV_NAME
    value: dev

stages:
  - stage: test_deploy
    displayName: Deploy test agent
    jobs:
      - job: deploy_test_agent
        steps:
          - checkout: self
          - task: AzureCLI@2
            name: deploy
            displayName: Deploy helpdesk-ALIAS-test
            inputs:
              azureSubscription: $(AZURE_SERVICE_CONNECTION)
              scriptType: bash
              scriptLocation: inlineScript
              inlineScript: |
                set -euo pipefail
                curl -fsSL https://aka.ms/install-azd.sh | bash
                azd extension install azure.ai.agents --version "1.0.0-beta.9"
                azd config set auth.useAzCliAuth "true"
                version=$(bash scripts/deploy-agent.sh helpdesk-ALIAS-test)
                echo "Deployed helpdesk-ALIAS-test version $version"
                echo "##vso[task.setvariable variable=AGENT_VERSION;isOutput=true]$version"

  - stage: eval
    displayName: AgentOps eval (pre-deploy)
    dependsOn: test_deploy
    jobs:
      - job: eval_gate
        variables:
          AGENTOPS_AGENT: $[ stageDependencies.test_deploy.deploy_test_agent.outputs['deploy.AGENT_VERSION'] ]
        steps:
          - checkout: self
          - task: UsePythonVersion@0
            inputs:
              versionSpec: "3.11"
          - bash: |
              python -m pip install --upgrade pip
              python -m pip install "agentops-accelerator==0.15.0"
            displayName: Install AgentOps Toolkit

          - task: AzureCLI@2
            displayName: Run AgentOps eval
            inputs:
              azureSubscription: $(AZURE_SERVICE_CONNECTION)
              scriptType: bash
              scriptLocation: inlineScript
              inlineScript: |
                set +e
                agentops eval run --config "$(AGENTOPS_CONFIG)"
                code=$?
                echo "##vso[task.setvariable variable=AGENTOPS_EVAL_EXIT_CODE]$code"
                exit $code
            env:
              AZURE_AI_FOUNDRY_PROJECT_ENDPOINT: $(AZURE_AI_FOUNDRY_PROJECT_ENDPOINT)
              AZURE_OPENAI_ENDPOINT: $(AZURE_OPENAI_ENDPOINT)
              AZURE_OPENAI_DEPLOYMENT: $(AZURE_OPENAI_DEPLOYMENT)
              AZURE_OPENAI_MODEL_NAME: $(AZURE_OPENAI_MODEL_NAME)
              APPLICATIONINSIGHTS_CONNECTION_STRING: $(APPLICATIONINSIGHTS_CONNECTION_STRING)
              AGENTOPS_AGENT: $(AGENTOPS_AGENT)
          - task: PublishPipelineArtifact@1
            condition: always()
            inputs:
              targetPath: .agentops/results/latest
              artifact: agentops-deploy-dev-results
              publishLocation: pipeline

  - stage: release
    displayName: Release (production)
    dependsOn: eval
    jobs:
      - deployment: release
        environment: production
        strategy:
          runOnce:
            deploy:
              steps:
                - checkout: self
                - task: AzureCLI@2
                  displayName: Deploy helpdesk-ALIAS and smoke test
                  inputs:
                    azureSubscription: $(AZURE_SERVICE_CONNECTION)
                    scriptType: bash
                    scriptLocation: inlineScript
                    inlineScript: |
                      set -euo pipefail
                      curl -fsSL https://aka.ms/install-azd.sh | bash
                      azd extension install azure.ai.agents --version "1.0.0-beta.9"
                      azd config set auth.useAzCliAuth "true"
                      bash scripts/deploy-agent.sh helpdesk-ALIAS
                      bash scripts/smoke-test.sh helpdesk-ALIAS
```

</details>

## Create the pipeline

Do this once, after you push your branch in
[step 4 of the lab](../lab.md#4-run-the-candidate-and-decide). Later pushes
start the pipeline on their own.

1. In the class Azure DevOps project, open **Pipelines** and select **New pipeline**.
2. Select **Azure Repos Git**, then the class repository.
3. Select **Existing Azure Pipelines YAML file**.
4. Select the branch `ship/<your alias>` and the path
   `/.azuredevops/pipelines/ship-<your alias>.yml`, then select **Continue**.
5. Select **Run**. The first run starts.
6. Open the pipeline's menu, select **Rename/move** and name it `ship-<your alias>`,
   so you can find it among the other participants' pipelines.

**Expected result:** the run starts with the **Deploy test agent** stage.

## Approve, reject and roll back on Azure Pipelines

- **See the run:** open **Pipelines**, select `ship-<your alias>` and select the run.
- **Download the results:** on the run's summary page, select the published
  artifact and download `agentops-deploy-dev-results`.
- **Approve or reject:** when the run pauses, select **Review** on the
  **Release (production)** stage, write a short comment, then select
  **Approve** or **Reject**.
- **Roll back:** open the last good run and select **Rerun stage** on
  **Release (production)**. It asks for approval again, redeploys that run's
  commit and repeats the smoke test. If **Rerun stage** is not offered, run
  `git revert HEAD` and `git push`: the new run evaluates and releases the
  previous code.

Return to [step 4 of the lab](../lab.md#4-run-the-candidate-and-decide).
