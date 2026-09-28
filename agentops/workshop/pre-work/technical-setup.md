# AgentOps workshop: instructor technical setup

![Set the stage. Let the learning happen. Prepare the essentials so the group can focus on the agent.](../assets/banners/instructor.png)

**For the instructor only.** You prepare the environment, deploy the agent
versions, run the evaluations yourself and invite the class.
Participants do not use this page; they follow [participant pre-work](README.md).
How to teach each module is in the [instructor guide](../instructor-guide/README.md).

**On this page**

1. [Get the files and tools](#1-get-the-files-and-tools): clone the course repository and prepare your computer
2. [Create or reuse the Foundry environment](#2-create-or-reuse-the-foundry-environment): project, models, monitoring and access
3. [Deploy the help desk agent](#3-deploy-the-help-desk-agent): working baseline and candidate versions
4. [Prepare your module](#4-prepare-your-module): the results and files each module needs
5. [Invite and rehearse](#5-invite-and-rehearse): a participant-tested invitation
6. [Final check before the workshop](#final-check-before-the-workshop): decide whether each module runs as a lab or a demo
7. [Retention and cleanup](#retention-and-cleanup): remove workshop resources after the retention date

**Project and agent already deployed for an earlier workshop?** Reuse them. Start with [access and rehearsal](#instructoradmin-shared-environment-and-permissions).
Do not redeploy agents just to teach again.

Two other people may be involved: the **Azure administrator** grants project
permissions, and the **workshop organizer** approves the use and spending.
You may cover these roles yourself.

<a id="common-preparation"></a>

Do steps 1 to 3 **once for the whole workshop**: every module uses the same
files, Foundry project and agent versions. Then do step 4 once for each module
you teach, and step 5 once. This also applies when you teach only Ship, Observe
and Operate, or Advanced.
Azure resources and model calls can incur charges; obtain the workshop organizer's
approval before the cloud steps.

<a id="1-prepare-the-instructor-machine"></a>

## 1. Get the files and tools

<a id="a-download-the-workshop-source-and-open-powershell"></a>

### A. Get the course files and open PowerShell

You rehearse with the same repository that participants clone.

**What this block does:** downloads the course files to Documents\AgentOps-workshop and prints their path.

```powershell
$Root = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'AgentOps-workshop'
New-Item -ItemType Directory -Force $Root | Out-Null
git clone https://github.com/placerda/AzureAIGovernance.git (Join-Path $Root 'AzureAIGovernance')
Join-Path $Root 'AzureAIGovernance'
```

If the folder already exists, run `git -C <path> pull` instead.

**What this block does:** asks for that path, checks the course files and sets it for the next commands.

```powershell
$ErrorActionPreference = 'Stop'
$RepoRoot = (Resolve-Path (Read-Host 'Repository folder path')).Path
$EvaluateRoot = Join-Path $RepoRoot 'agentops\workshop\labs\01-evaluate'
$LocalRoot = Join-Path $EvaluateRoot '.local'
foreach ($file in @(
    'requirements.txt', 'assets\agentops.yaml', 'assets\turns.jsonl',
    '..\shared\helpdesk-agent\main.py', '..\..\pre-work\foundry-environment.md'
)) {
    if (-not (Test-Path (Join-Path $EvaluateRoot $file))) {
        throw "Course file missing: $file. Ask the maintainer to publish the complete source before proceeding."
    }
}
Set-Location $RepoRoot
"Repository: $RepoRoot"
"Evaluate lab: $EvaluateRoot"
"Local work: $LocalRoot"
```

If it stops with `Course file missing`, paste the clone path, not a subfolder.
Keep this window open; if you close it, run the block again.

If you change course files, push them to `main` before the class.

<a id="b-install-only-the-tools-your-role-needs"></a>

### B. Install the deployment tools

1. Follow [Python 3.11 and Azure CLI installation](README.md#use-a-prepared-machine-or-install-only-missing-tools).
2. Run `azd version`. If it is not recognized, run `winget install microsoft.azd`
   (without `winget`, use the [Windows azd installer](https://learn.microsoft.com/azure/developer/azure-developer-cli/install-azd?pivots=os-windows)).
3. After installation, reopen PowerShell and repeat step A's folder block.
4. Run the following commands to enable Foundry deployment:

**What this block does:** adds the Foundry agent extension to the Azure Developer CLI.

```powershell
azd version
if ($LASTEXITCODE -ne 0) { throw 'Azure Developer CLI is unavailable. Contact the software administrator.' }
azd extension install microsoft.foundry
if ($LASTEXITCODE -ne 0) { throw 'Foundry extension installation failed. Contact the software administrator.' }
azd ai agent init --help
if ($LASTEXITCODE -ne 0) { throw 'Foundry agent commands are unavailable.' }
```

The tools are ready when the block ends without an error and shows the help
for `azd ai agent init`.

You don't need VS Code or any extension: any text editor works, and the
workshop uses the agent running in Foundry, not a copy on your computer.

<a id="prepare-and-check-the-evaluation-tools"></a>

### C. Install and check the AgentOps Accelerator CLI

The [AgentOps Accelerator](https://aka.ms/agentops-accelerator) CLI (`agentops`)
sends the test requests to Foundry and brings back the scores. Install it now,
before creating anything in Azure, so that a package problem shows up early.
Keep using the PowerShell window from step A.

Start by setting the tool paths. Run this on every machine:

**What this block does:** lets you type `agentops` in this PowerShell window and creates your `.local` work folder.

```powershell
$EvalPython = Join-Path $EvaluateRoot '.venv\Scripts\python.exe'
$env:Path = (Join-Path $EvaluateRoot '.venv\Scripts') + ';' + $env:Path
New-Item -ItemType Directory -Force $LocalRoot | Out-Null
```

On a new machine, install the tool. On a prepared machine, skip this block.

**What this block does:** installs the AgentOps Accelerator CLI in its own Python environment.

```powershell
if (-not (Test-Path $EvalPython)) {
    py -3.11 -m venv (Join-Path $EvaluateRoot '.venv')
    if ($LASTEXITCODE -ne 0) { throw 'Python environment creation failed.' }
}
& $EvalPython -m pip install -r (Join-Path $EvaluateRoot 'requirements.txt')
if ($LASTEXITCODE -ne 0) { throw 'Evaluation packages unavailable. See the installation failure guidance below.' }
```

Then, on any machine, confirm that the installation works:

**What this block does:** checks that the AgentOps Accelerator CLI is installed correctly.

```powershell
& $EvalPython -m pip check
if ($LASTEXITCODE -ne 0) { throw 'Evaluation dependencies conflict. Contact the package administrator.' }
agentops --version
if ($LASTEXITCODE -ne 0) { throw 'AgentOps Accelerator CLI unavailable.' }
```

The installation works when the block ends by printing the CLI version.

If a package fails to install, send the package name and `requirements.txt` to
your software administrator. Ask them to publish those exact versions in your
approved package source, or to give you a prepared machine. Don't switch to
older versions or another package source, because participants must use the
same versions.

<a id="c-obtain-approved-values-and-authenticate"></a>

## 2. Create or reuse the Foundry environment

The help desk agent needs a Foundry project with two model deployments. Follow
[Foundry environment setup](foundry-environment.md) to create them, or to reuse
a project your organization already approved.

Finish that page before step 3. The tools from step 1 do not create any Azure
resources.

<a id="instructoradmin-prepare-the-shared-help-desk-agent"></a>

## 3. Deploy the help desk agent

The **baseline** is the earlier version used for comparison. The **candidate**
is the version participants will test.

**Agent not deployed yet?** Follow [help desk deployment, steps 1-6](../labs/shared/helpdesk-agent/README.md).
That guide uploads the supplied Python code, lets Foundry install its packages,
deploys the baseline and the candidate, and sends test requests.

**Agent already deployed for an earlier workshop?** Skip the deployment. Keep
the URLs of both versions and the code and settings used to deploy them.

Continue below only after both versions answer and their tool results are
visible. A successful local installation is not a deployed agent.

## 4. Prepare your module

Do this for each module you will teach, a few days before class.

### Evaluate

<a id="instructoradmin-prepare-the-evaluation-workspace"></a>
<a id="3-instructoradmin-rehearse-the-public-cli-and-retain-the-baseline"></a>
<a id="3-run-both-evaluations-and-save-the-results"></a>
<a id="plan-model-capacity-for-simultaneous-runs"></a>

Run the lab yourself once, exactly as participants will. This proves that
the environment, the CLI and tracing work together, and your results are the
fallback you show if a participant's run fails.

1. **Run lab steps 1 to 4.** Use the four values saved at
   [the end of agent deployment](../labs/shared/helpdesk-agent/README.md#6-keep-the-two-versioned-references)
   and follow [the Evaluate lab](../labs/01-evaluate/lab.md) from step 1 to 4.
   At the end, all eight requests must have an answer and both scores, and the traces for `password-basic` and `vpn-ticket`
   must open.
2. **Optional: prepare the lab supplements.** Only if you will show lab steps
   5 and 6, follow [additional Foundry checks](native-evidence.md) once and keep
   the links.
3. **Large classes: check model capacity.** Multiply the tokens your run used
   by the number of people running at once. If that exceeds the model quota,
   ask the Azure administrator to raise it or start runs in groups.

Keep your results folder until class. If a run times out, follow the lab's
[recovery section](../labs/01-evaluate/lab.md#recovery-after-timeout-or-failure)
instead of running it again.

### Ship

Participants compare two saved pipeline runs: a release that was blocked and
one that was approved. The course does not include a runnable pipeline yet, so
you create these runs yourself.

1. **Choose the track:** GitHub Actions or Azure Pipelines.
2. **Run the pipeline twice** for the help desk agent: once so that evaluation
   or approval stops the release, and once so that it deploys and the test
   requests after deployment succeed.
3. **Package the results** as `agentops-ship-review.zip`, with the contents below.
   Remove secrets, `.azure` folders and virtual environments first.

<details>
<summary>What the Ship ZIP must contain</summary>

Zip the files themselves, not a folder that contains them.

- `blocked\` and `accepted\`: the `report.md` and `results.json` from each run.
  Download them from GitHub **Actions > run > Artifacts** or Azure Pipelines
  **Pipelines > run > Summary**.
- `deployment\`: the `azure.yaml` used and the code folders it names.
- `README.md` with these fields: **Blocked run**, **Accepted run** and links to
  their job logs; **Pipeline steps**, naming the actual evaluation, approval and
  deployment steps; **Deployment source**, **Evaluated source revision**,
  **Deployed agent version** and **Approval**; **Smoke-test evidence**, the
  responses to the test requests after deployment; and **Recovery
  instructions**, how to restore the previous version if those requests fail.

</details>

<details>
<summary>References for building the pipeline</summary>

[GitHub workload identity](https://learn.microsoft.com/azure/developer/github/connect-from-azure-openid-connect),
[azd GitHub pipeline](https://learn.microsoft.com/azure/developer/azure-developer-cli/pipeline-github-actions),
[Azure Pipelines workload identity](https://learn.microsoft.com/azure/devops/pipelines/release/configure-workload-identity?view=azure-devops)
and [approvals](https://learn.microsoft.com/azure/devops/pipelines/process/approvals?view=azure-devops).

</details>

### Observe and Operate

Participants follow one saved request from its trace to the alert it caused,
then choose a response. They do not configure monitoring or change the service.

1. **Send a fictional test request** to the help desk agent that triggers an alert.
   Use [Foundry tracing](https://learn.microsoft.com/azure/foundry/observability/how-to/trace-agent-setup)
   and a [log alert](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-create-log-alert-rule)
   on the workshop's Application Insights resource. Send notifications only to
   people who agreed to receive them.
2. **Check that the trace and the alert** refer to the same request and time.
3. **Package the results** as `agentops-observe-review.zip`, with the contents below.
   Remove sensitive information first.

<details>
<summary>What the Observe and Operate ZIP must contain</summary>

Zip the files themselves, not a folder that contains them.

- `README.md` with **Trace** (from Foundry **Agents > Traces**), **Trace ID**,
  **UTC time range**, **Agent version**, **Alert** (from Azure portal
  **Monitor > Alerts**) and **Dashboard**. Mark any scheduled evaluation you
  did not run as **Not assessed**.
- `response-notes.md`: what went wrong, what action is allowed, who acts, who
  to call for help, when to stop and what to retest.

</details>

### Advanced (optional)

Participants review a saved incident: the failure, its recovery and the test
added so the same bug cannot be released again.

1. **Cause a reversible failure** on a separate test agent, never on the shared
   agent or production data.
2. **Restore the previous working version** and add a test that catches the
   same bug. Check that this test stops the faulty version from being released.
3. **Package the results** as `agentops-advanced-review.zip`, with the contents below.

<details>
<summary>What the Advanced ZIP must contain</summary>

Zip the files themselves, not a folder that contains them.

- `before\` and `after\`: each run's `turns.jsonl`, `agentops.yaml`,
  `report.md` and `results.json`.
- `runbook.md`: the test agent, who may act, how the failure was caused, when
  to stop, who to contact, the recovery steps and the expected response after
  recovery.
- `README.md` with **Trace**, **Trace ID**, **UTC time range**, **Blocked run**,
  **Recovered run**, **Source revisions**, **Review process**, **Regression
  request** and links to both reports.

</details>

## 5. Invite and rehearse

Do this step once for the whole workshop, after step 4 is done for every module
you will teach. One rehearsal covers all those modules, and one invitation
reaches the participants.

### Publish the workshop files and invitation

Participants find everything they need in one calendar invitation: the links,
the account to sign in with and the values the labs ask for. Prepare it in
three steps.

**1. Share the module files.** Skip this if you teach only Evaluate:
participants get its files by cloning the course repository.

1. In [OneDrive](https://www.microsoft365.com/onedrive), create a folder named
   `AgentOps workshop YYYY-MM-DD` with the session date.
2. Upload the review ZIPs of the modules you teach.
3. Select **Share**, add the participants and the test account you will use in
   the rehearsal, choose **Can view**, and copy the link.

**2. Draft the invitation.** In Outlook, select **Calendar > New event**, name
it **AgentOps workshop** and add the participants. Paste the message below into
the body. Delete every line that does not apply to your session, and any
heading left empty, then replace the remaining `<...>` placeholders.
Under **Your module and mode**, list only the modules participants will run;
leave out modules you will only demonstrate. Keep the
label wording unchanged: the participant pages refer to each label by name.

**3. Test it before sending.** Keep the event as a draft and use it yourself in
[the rehearsal below](#instructoradmin-shared-environment-and-permissions).
Send it only after the rehearsal works.

<details open>
<summary>Invitation message to copy</summary>

```text
Hi everyone,

You are invited to the AgentOps workshop on <date>, <start time> to <end time> (<time zone>).

Your module and mode
- Evaluate: run the lab
- Ship: review saved results
- Observe and Operate: review saved results
- Advanced (optional): review saved results

Before the session, complete the pre-work for the modules listed above:
https://github.com/Azure/AzureAIGovernance/blob/main/agentops/workshop/pre-work/README.md

Access
- Foundry project: <project link>
- Project name: <name shown on the project page>
- Sign-in account: <account you must use>
- Network access: <VPN instructions, or "Not needed">
- Tenant ID: <tenant ID> (Evaluate only)

Evaluate settings (Evaluate hands-on only)
- Project endpoint: <https://RESOURCE.services.ai.azure.com/api/projects/PROJECT>
- Baseline agent: <PROJECT ENDPOINT/agents/NAME/versions/NUMBER>
- Candidate agent: <PROJECT ENDPOINT/agents/NAME/versions/NUMBER>
- Scoring-model deployment: <deployment name, normally agentops-eval>

Other modules
- Workshop files: <OneDrive folder link> (Ship, Observe and Operate, Advanced)
- Ship track: <GitHub Actions | Azure Pipelines>, <link to that track's page>

Keep files until: <retention date>
Please do not share these links outside the class. If a link or sign-in does
not work, reply to this invitation before the session.

<your name>
```

</details>

**Where to find each value**

- **Foundry project, Project name** and **Project endpoint:** the project's
  **Home** page, as in [environment setup step 5](foundry-environment.md#5-copy-the-project-values-and-sign-in).
- **Tenant ID:** the same step 5.
- **Baseline agent** and **Candidate agent:** `versions.txt`, saved in
  [agent deployment step 6](../labs/shared/helpdesk-agent/README.md#6-keep-the-two-versioned-references).
- **Scoring-model deployment:** **Build > Models** in the Foundry project.
- **Sign-in account** and **Network access:** ask the Azure administrator.
- **Workshop files:** the link you copied in step 1 above.
- **Ship track:** the track page under [the Ship lab](../labs/02-ship/lab.md) on GitHub.
- **Keep files until:** the date agreed with the workshop organizer.

The workshop organizer is the support contact. If OneDrive blocks sharing, ask
the organization's file-sharing administrator before you send the invitation.
Do not publish private results to GitHub.

<a id="instructoradmin-shared-environment-and-permissions"></a>

### Rehearse with participant access

Use the draft invitation above.
The administrator has already assigned access during [environment setup](foundry-environment.md#4-give-people-access).
Now sign in with the test account the administrator created for you, which has
exactly the participant roles, and check that the selected activity works with
those permissions. Do not use your own instructor account: it has broader
permissions and can hide access problems.

Before the rehearsal, get the workshop organizer's approval for the spending
limit. Remember that the rehearsal shows the lab works for one person; whether
the quota supports the whole class running at once comes from the
[capacity plan](#plan-model-capacity-for-simultaneous-runs).

#### Open the project and files with the test account

These actions open existing pages and files; they do not submit evaluations.

1. Open **Foundry project** with the test account.
2. Compare the displayed project name with **Project name** in the draft invitation.
3. For Ship, Observe and Operate, or Advanced, download the module ZIP
   from **Workshop files**, select **Extract All**, and open its `README.md`, then the entries below.

| Module | Open | Access works when |
| --- | --- | --- |
| Ship | **Blocked run**, **Accepted run** and their job-log links | Run pages and logs open |
| Observe and Operate | **Trace**, **Alert** and **Dashboard** | Trace details, alert and chart are visible |
| Advanced | `runbook.md`, **Trace**, **Blocked run** and **Recovered run** | Procedure and saved records open |

If a trace opens as a list, use
[the trace lookup steps](../labs/03-observe-operate/lab.md#find-the-supplied-trace).

#### Try one evaluation with participant permissions

**Evaluate only. This is a billable rehearsal, not participant homework.**
Use the invitation's **Network access** instructions first if a VPN is required.

1. Complete [Evaluate pre-work](README.md#evaluate) with the test account, on a machine like the ones participants will use.
2. Run [Evaluate step 3](../labs/01-evaluate/lab.md#3-run-the-supported-public-command) once: baseline, then candidate.
3. Review the report and Foundry page using [lab step 4](../labs/01-evaluate/lab.md#4-inspect-the-report-and-actual-interactions).
4. Find all eight requests, with actual answers, both scores and no agent-call or scoring errors.

**Expected:** the test account can submit and read results; the agent can answer.
Exit `2` means a quality threshold failed, not that authentication failed.
Do not require the deliberately faulty candidate to pass before teaching.

If the run times out, use the lab's recovery procedure instead of resubmitting.
For access denied, give the administrator the failing action, account or agent,
and error. Do not grant broad access or disable network restrictions.

### Evaluate readiness checks

- [ ] A person with participant permissions can start the lab and complete an evaluation.
- [ ] Both runs use the versions named in the invitation; all eight requests were reviewed.
- [ ] Your rehearsal results, tool traces and extra checks are ready to demonstrate; any missing checks are listed.
- [ ] Rehearsal fits the lab time and approved spending limit, with a capacity plan for simultaneous runs.
- [ ] With the test account, you can clone the repository and open your own report links.

<a id="readiness-gate"></a>

## Final check before the workshop

Before the workshop day, decide for **each module you will teach** how you
will run it:

- **As a hands-on lab**, if you completed that module's checklist in
  [step 4](#4-prepare-your-module) and ran the lab yourself from start to finish.
- **As a demo**, if anything in that checklist is missing, such as lab
  files, agent versions or results you produced. Present the module with the
  slides and explain the steps, but do not ask participants to run it.

Tell participants which format each module will use, in the invitation or in a
follow-up message, so nobody prepares for a lab that will not run.

## Retention and cleanup

Keep the versioned agents and approved evidence through the selected modules.
Participants do not delete cloud resources.

**WORKSHOP ORGANIZER, after the retention date:**

1. Save the required reports and tool records outside any Azure resources being removed.
2. In [Azure portal](https://portal.azure.com), open **Resource groups** and select the group used in environment setup.
3. Review its resource list. Continue only if every listed resource was created solely for this workshop and deletion is approved.
4. Select **Delete resource group**, enter its exact name and confirm deletion.

This permanently removes the resources and their data in that group; see
[resource-group deletion](https://learn.microsoft.com/azure/azure-resource-manager/management/delete-resource-group).
If the class reused an existing project, **do not delete its resource group**.
Give its owner the retained workshop agent versions, model deployments and
access assignments so they can remove only the items approved for removal.
