# AgentOps instructor preparation

![Set the stage. Let the learning happen. Prepare the essentials so the group can focus on the agent.](../assets/banners/instructor.png)

**First class or no environment yet?** Follow the preparation route below.
It includes creating the Foundry environment and deploying the agent, not just
installing the evaluation tool.

Participants follow [participant pre-work](README.md), not this guide.
Timing and facilitation belong in the [one-pager](../one-pager/agentops-vbd-one-pager.md).

| Order | Action | You finish with |
| --- | --- | --- |
| 1 | [Get the files and tools](#1-prepare-the-instructor-machine) | Workshop source and a prepared computer |
| 2 | [Create or reuse the Foundry environment](foundry-environment.md) | Project, models, monitoring connection and access |
| 3 | [Deploy the help desk agent](../labs/shared/helpdesk-agent/README.md) | Working baseline and candidate versions |
| 4 | [Prepare Evaluate](#evaluate) | Evaluation settings and real comparison results |
| 5 | [Package the files](#instructoradmin-package-and-rehearse-the-learner-bundle) | Participant ZIP |
| 6 | [Rehearse and distribute](#publish-the-workshop-files-and-invitation) | A participant-tested invitation and files |

**Returning class with unchanged material?** Reuse the project, deployed
versions and packages. Start with [access and rehearsal](#instructoradmin-shared-environment-and-permissions).
Do not redeploy agents or recreate evaluation settings just to teach again.

For standalone Ship, Observe and Operate, or Advanced, use that module's
package section below. Their current activities review saved results;
provisioning an environment does not supply the unfinished pipeline or incident exercises.

Here, the **material author** creates the examples and scripts. The
**instructor** prepares and teaches a class. The **Azure administrator** manages
the project's permissions; the **project owner** approves its use and spending.
One person may cover more than one role.

## Common preparation

Complete this section before creating a new environment or changing the agent.
Azure resources and model calls can incur charges; obtain the project owner's
approval before the cloud steps.

### 1. Prepare the instructor machine

#### A. Download the workshop source and open PowerShell

**Why this download:** this ZIP contains the lab instructions, test data and
agent code. Use it to rehearse, then give Evaluate participants the same copy.
It is separate from the ZIP of prepared settings and results you create later.

1. Download [AzureAIGovernance main ZIP](https://github.com/placerda/AzureAIGovernance/archive/refs/heads/main.zip).
2. Rename it `agentops-workshop-source.zip`.
3. Extract it to **Documents > AgentOps-workshop**.
4. Open `AzureAIGovernance-main` and copy its path from File Explorer.
5. Open PowerShell and run this block, supplying that path.

**Why start here:** deployment will use the help desk code in this download;
evaluation will use its test requests. Select that source folder once so later
commands use the same course files.

This block only locates the files. It does not install software, create Azure
resources, deploy the agent or run an evaluation.

```powershell
$ErrorActionPreference = 'Stop'
$RepoRoot = (Resolve-Path (Read-Host 'Repository folder path')).Path
$EvaluateRoot = Join-Path $RepoRoot 'agentops\workshop\labs\evaluate'
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

**Check the output:** compare `Repository` with the path in File Explorer's
address bar. They must match. `Evaluate lab` must end in
`agentops\workshop\labs\evaluate`; `Local work` adds `.local` to that path.

Keep this PowerShell window open. If you close it, run this block again to
define the variables in the new window.

Keep the original ZIP to give to participants. If you edit a local copy,
publish those changes to the repository before distributing a new download.
Maintainers may use their existing checkout while editing; that does not make
the changes available in the `main` download. A missing-file error must be
resolved before provisioning or distributing the course.

#### B. Install only the tools your role needs

1. Follow [Python 3.11 and Azure CLI installation](README.md#use-a-prepared-machine-or-install-only-missing-tools).
2. Run `azd version`. If it is not recognized, run `winget install microsoft.azd`.
3. After installation, reopen PowerShell and repeat step A's folder block.
4. Run the following commands to enable Foundry deployment:

```powershell
azd version
if ($LASTEXITCODE -ne 0) { throw 'Azure Developer CLI is unavailable. Contact the software administrator.' }
azd extension install microsoft.foundry
if ($LASTEXITCODE -ne 0) { throw 'Foundry extension installation failed. Contact the software administrator.' }
azd ai agent init --help
if ($LASTEXITCODE -ne 0) { throw 'Foundry agent commands are unavailable.' }
```

**Expected:** help lists `--project-id`, `--deploy-mode` and `--runtime`.
This installs deployment tooling, not an agent.
See the [Windows azd installer](https://learn.microsoft.com/azure/developer/azure-developer-cli/install-azd?pivots=os-windows)
if `winget` is unavailable.

Use any text editor; VS Code is optional.

**No VS Code extension is required.** Running the agent on your own computer
is optional. The normal workshop uses the agent already running in Foundry.

#### Prepare and check the evaluation tools

Use the same PowerShell window as step A.
Do this before creating Azure resources so a missing package cannot block you
only after you have provisioned the environment.

**Why this tool:** submit test requests to Foundry and download their scores.
Installing it on your computer does not create the environment or deploy the agent.

First, define the local paths on both new and prepared machines:

```powershell
$EvalPython = Join-Path $EvaluateRoot '.venv\Scripts\python.exe'
$AgentOps = Join-Path $EvaluateRoot '.venv\Scripts\agentops.exe'
New-Item -ItemType Directory -Force $LocalRoot | Out-Null
```

**New machine:** run the installation block. **Prepared machine:** skip to the
two checks after it.

```powershell
if (-not (Test-Path $EvalPython)) {
    py -3.11 -m venv (Join-Path $EvaluateRoot '.venv')
    if ($LASTEXITCODE -ne 0) { throw 'Python environment creation failed.' }
}
& $EvalPython -m pip install -r (Join-Path $EvaluateRoot 'requirements.txt')
if ($LASTEXITCODE -ne 0) { throw 'Evaluation packages unavailable. See the installation failure guidance below.' }
```

On either machine, run these checks:

```powershell
& $EvalPython -m pip check
if ($LASTEXITCODE -ne 0) { throw 'Evaluation dependencies conflict. Contact the package administrator.' }
& $AgentOps --version
if ($LASTEXITCODE -ne 0) { throw 'Evaluation CLI unavailable.' }
```

**Expected:** `pip check` reports no broken requirements, then the CLI prints its version.

**Installation failure:** give the software administrator the failing package
name and `requirements.txt`. Ask them to make those exact releases available
through the approved package source, or provide a prepared machine.
Do not substitute an older release, change package indexes or give participants
a source-build task. Finish these checks before proceeding.

<a id="c-obtain-approved-values-and-authenticate"></a>

#### C. Prepare the Foundry environment

Open [Foundry environment setup](foundry-environment.md).
It gives the steps to create a project, deploy its models and arrange access,
or reuse an approved project from the AI Governance VBD.

Finish that guide before deploying the agent. You need a real project and
model deployments; installing azd or the evaluation CLI does not create them.

<a id="instructoradmin-prepare-the-shared-help-desk-agent"></a>

### 2. Deploy the two help desk agent versions

The **baseline** is the earlier version used for comparison. The **candidate**
is the version participants will test.

**Already deployed and reviewed?** Keep both versions' URLs and the code and
settings used to deploy them. No new deployment is needed.

**No versions yet?** Follow [help desk deployment, steps 1-6](../labs/shared/helpdesk-agent/README.md).
That guide uploads the supplied Python code, lets Foundry install its packages,
deploys both versions and sends test requests.

Continue below only after both versions answer and their tool results are
visible. A successful local installation is not a deployed agent.

## Evaluate

**Start here after environment setup and agent deployment.** The remaining
steps prepare how to test that agent and what learners will receive.
If the versions, requests and scoring rules are unchanged, reuse the completed
package and go to [class rehearsal](#try-one-evaluation-with-participant-permissions).

### INSTRUCTOR/ADMIN: prepare the evaluation workspace

**First-time setup, or a changed assignment only.**
Use the project, scoring-model and versioned agent references from
[the end of agent deployment](../labs/shared/helpdesk-agent/README.md#6-keep-the-two-versioned-references).
This creates the **workspace**, a folder with the settings and requests used
by `agentops`, so participants test the same candidate with the same scoring rules.
A versioned agent URL includes `/agents/NAME/versions/VERSION`;
it must identify the exact version, not a moving "latest" version.

```powershell
$AgentOps = Join-Path $EvaluateRoot '.venv\Scripts\agentops.exe'
$Workspace = Join-Path $LocalRoot 'workspace'
if (Test-Path $Workspace) { throw 'Workspace already exists. Review the existing assignment rather than overwrite it.' }
New-Item -ItemType Directory -Path $Workspace | Out-Null
Copy-Item (Join-Path $EvaluateRoot 'assets\turns.jsonl') $Workspace
& $AgentOps init --dir $Workspace --no-prompt `
  --project-endpoint $ProjectEndpoint --agent $CandidateEndpoint --dataset turns.jsonl
if ($LASTEXITCODE -ne 0) { throw 'Workspace initialization failed.' }
Copy-Item (Join-Path $EvaluateRoot 'assets\agentops.yaml') $Workspace
$Workspace
```

Open the printed folder in your editor:

1. In `agentops.yaml`, replace `agent:` with the candidate URL supplied above.
2. In `.agentops\.env`, keep the two lines below. Replace the placeholders with
   the project URL and scoring-model deployment name you copied.
3. Save both files. Keep the supplied dataset, cloud mode, evaluators and thresholds unchanged.

```dotenv
AZURE_AI_FOUNDRY_PROJECT_ENDPOINT=YOUR_PROJECT_ENDPOINT
AZURE_OPENAI_DEPLOYMENT=YOUR_SCORING_MODEL_DEPLOYMENT
```

The candidate URL must belong to that project. Keep secrets, `.azure` and a
root `.env` out of this workspace; they are not part of the learner package.

Run the local check:

```powershell
Set-Location $Workspace
'AGENTOPS_AGENT','AZURE_AI_FOUNDRY_PROJECT_ENDPOINT','AZURE_OPENAI_DEPLOYMENT','AZURE_AI_MODEL_DEPLOYMENT_NAME' |
    ForEach-Object { Remove-Item "Env:$_" -ErrorAction SilentlyContinue }
& $AgentOps init show
if ($LASTEXITCODE -ne 0) { throw 'Cannot read workspace settings.' }
& $AgentOps eval analyze --dir . --format text
if ($LASTEXITCODE -ne 0) { throw 'Local configuration analysis failed.' }
```

**Check these values before submitting:**

1. In the `init show` output, compare the project endpoint's `value` with `$ProjectEndpoint`.
2. Compare `agent:` with `$CandidateEndpoint`; `dataset:` must be `turns.jsonl`.
3. Open `.agentops\.env`. The value after `AZURE_OPENAI_DEPLOYMENT=` must match the scoring-model name you entered.

You can print a variable's value by entering its name, such as `$ProjectEndpoint`,
in the same PowerShell window. These are local checks, not proof of Azure access.

<a id="3-instructoradmin-rehearse-the-public-cli-and-retain-the-baseline"></a>

### 3. Run both evaluations and save the results

![Ready to press Run? One run is enough to start. Cloud runs cost money; check the results before trying again.](../assets/banners/ready-to-run.png)

**Billable.** Complete the workspace above and obtain the owner's approval first.

**Why two runs:** the baseline gives you a reference for judging the candidate.
Using the same requests and scoring rules makes the comparison meaningful.

Run the baseline once:

```powershell
$Rehearsal = Join-Path $LocalRoot ('rehearsals\' + [guid]::NewGuid().ToString('N'))
$BaselineRun = Join-Path $Rehearsal 'baseline'
$CandidateRun = Join-Path $Rehearsal 'candidate'
New-Item -ItemType Directory -Path $Rehearsal | Out-Null
Set-Location $Workspace
Start-Transcript -Path (Join-Path $Rehearsal 'baseline-terminal.txt') | Out-Null
& $AgentOps eval run --config agentops.yaml --agent $BaselineEndpoint --output $BaselineRun
$baselineExit = $LASTEXITCODE
Stop-Transcript | Out-Null
if ($baselineExit -notin @(0,2)) { throw 'Baseline error. Inspect the existing Foundry run before retrying.' }
```

Then run the candidate with the same dataset, configuration and scoring model:

```powershell
Start-Transcript -Path (Join-Path $Rehearsal 'candidate-terminal.txt') | Out-Null
& $AgentOps eval run --config agentops.yaml --output $CandidateRun `
  --baseline (Join-Path $BaselineRun 'results.json')
$candidateExit = $LASTEXITCODE
Stop-Transcript | Out-Null
if ($candidateExit -notin @(0,2)) { throw 'Candidate error. Inspect the existing Foundry run before retrying.' }
& $AgentOps report generate --in (Join-Path $CandidateRun 'results.json') `
  --out (Join-Path $CandidateRun 'review-report.md')
if ($LASTEXITCODE -ne 0) { throw 'Report rendering failed. Keep original results and error.' }
```

Review both runs using [lab step 4](../labs/evaluate/lab.md#4-inspect-the-report-and-actual-interactions):
eight different requests, both scores for every request, errors and the actual
tool results. Review every request marked `critical: yes` individually.
Exit `2` means a score missed its required minimum; keep that result for discussion.

#### Save the tool records learners will inspect

**Why keep these separately:** the score report does not prove which tool
ran. This evidence is required for the main lab, not an optional safety supplement.

1. Run `$BaselineRun`, then `$CandidateRun`, to display the two results folders.
2. For each run, open its `cloud_evaluation.json` and follow `report_url`.
3. Find `password-basic` and `vpn-ticket` by their request text.
4. Open each request's trace using [the trace lookup procedure](../labs/shared/helpdesk-agent/README.md#find-the-tool-results).
5. Save a `tool-traces.md` file beside that run's `report.md`, using the fields below.

| Record for each request | Copy from |
| --- | --- |
| Request text and agent version | The selected evaluation result |
| Trace link, Trace ID and UTC time range | The matching trace |
| Tool name, arguments and returned source/queue | The tool operation's details |

Use these evaluation requests, not the earlier deployment smoke tests.
If no matching trace or stored tool output is available, record the gap.
Do not invent a link or replace actual output with `tools.py` or a model's claim.
Resolve the missing evidence before delivering the tool-inspection activity.

Keep the original reports, files returned by Foundry, agent version numbers,
code, settings and test requests together. Include the model and evaluator
versions actually used. Passing averages alone do not approve a release.

**Timeout or error:** open the existing run in Foundry and check its status
before submitting again. The CLI has no command to resume it or download a
previous run later.

<a id="4-instructoradmin-prepare-native-foundry-supplementary-evidence"></a>

### 4. Gather the additional Foundry results

Reuse the course's reviewed results for rubric calibration, safety, conversations
and adversarial tests. These are extra reviews; they do not change the CLI's pass/fail result.

If a supplement has not been built, the material author follows
[the guide to additional Foundry checks](native-evidence.md). This is not routine instructor
pre-work. Label missing results **Not assessed** and say what is missing.

### INSTRUCTOR/ADMIN: package and rehearse the learner bundle

**Only when publishing or updating the course package.**

**Why this package:** it gives participants ready-to-use project settings, a
baseline to compare against and saved candidate results if their run cannot
finish. They copy it into `.local`; they do not configure the project themselves.

1. In File Explorer, open `agentops\workshop\labs\evaluate\.local`.
2. Create `staging`, then create `evaluate` inside it.
3. Inside `evaluate`, create `workspace` and `instructor`.
4. Copy the entries below into those folders.

If `staging\evaluate` already exists, move that earlier package to the course's
retained files first. Do not merge old and new results.

| Copy from | Destination under `staging\evaluate` |
| --- | --- |
| `.local\workspace`: `agentops.yaml`, `turns.jsonl`, `.agentops\.env` | `workspace`, preserving the same layout |
| Rehearsal folders printed by `$BaselineRun` and `$CandidateRun` | `instructor\baseline` and `instructor\candidate` |
| `.local\instructor`: `calibration`, `domain-safety`, `conversation`, `redteam` | `instructor`, retaining those folder names |

Each baseline/candidate folder includes `tool-traces.md` from the preceding step.
For an unfinished supplement, create its folder and a `review.md` saying
**Not assessed**, what is missing and who will prepare it. No result JSON is
required or permitted for a check that did not run.

1. Create `README.md` in `staging\evaluate` using the labels below.
2. Select `README.md`, `workspace` and `instructor`; right-click **Compress to ZIP file**.
3. Name it `agentops-evaluate-workspace.zip`.
4. Extract a fresh copy and follow [participant pre-work](README.md#evaluate)
   through startup; open the supplied baseline and candidate reports.

| README label | Value from the rehearsal |
| --- | --- |
| Foundry project | Browser link copied from the project page |
| Project name | Name displayed on that page |
| Project endpoint | The project URL entered during evaluation workspace setup |
| Candidate name and version | Name and immutable version used in the candidate evaluation |
| Scoring-model deployment | Deployment name used to score both runs |
| Baseline compatibility | Whether both runs used the same requests, scoring model, evaluator versions and rules |
| Evidence gaps | Missing results or checks that could not be completed |
| Baseline report / Candidate fallback report | `instructor/baseline/report.md` and `instructor/candidate/report.md` links |
| Tool records | Links to `instructor/baseline/tool-traces.md` and `instructor/candidate/tool-traces.md` |
| Help | Reply to the workshop organizer |

**Package check:** opening the ZIP must immediately show `README.md`, `workspace`
and `instructor`. Exclude `.venv`, `.azure`, passwords, keys and private records.
Keep the two non-secret `.agentops\.env` values. Remove sensitive content from
exports without inventing or improving results.

### Publish the workshop files and invitation

Publish only completed packages. The session folder is created by the instructor;
it is not an existing public download.

**Why one folder:** the invitation becomes the single place to get the correct
course files, project links and sign-in details without searching chat history.

1. Open [Microsoft 365](https://www.microsoft365.com), then **OneDrive > My files > New > Folder**.
   Name it `AgentOps workshop YYYY-MM-DD` with the session date.
2. Use **Upload > Files** to add selected modules' packages and, for Evaluate hands-on, the source ZIP.
3. Select **Share > Link settings > Specific people**, give attendees **Can view** access,
   and copy the link.
4. In Outlook **Calendar > New event**, draft **AgentOps workshop** with the fields below.
5. Give one attendee the draft details and files for [the rehearsal below](#instructoradmin-shared-environment-and-permissions).
6. Send the class invitation only after those checks succeed.

| Invitation field | Include |
| --- | --- |
| Your module and mode | Modules and whether attendees run the lab, watch a demo or review saved results |
| Workshop files | The restricted folder link |
| Foundry project | Project browser link |
| Project name | Name displayed on the project page |
| Sign-in account | Account attendees are permitted to use |
| Tenant ID | Organization ID from environment setup, for Evaluate CLI users |
| Subscription ID | Approved subscription from environment setup, for Evaluate CLI users |
| Local workshop folder | Repository path, only for prepared machines |
| Network access | VPN application and connection instructions, if needed |
| Ship track | GitHub Actions or Azure Pipelines, when selected |
| Keep files until | Retention date |

The organizer is the support contact. If OneDrive sharing is blocked, resolve
it with the organization's file-sharing administrator before distributing the
invitation. Do not publish private evidence to GitHub.

<a id="instructoradmin-shared-environment-and-permissions"></a>

### Rehearse with participant access

Use the prepared files and draft invitation above.
The administrator has already assigned access during [environment setup](foundry-environment.md#4-give-people-access).
Now test whether the participant can actually do the selected activity.

Before the rehearsal, agree the number of simultaneous runs and spending limit
with the project owner. One successful run does not establish classroom capacity.

#### Open the project and files with one participant

These actions open existing pages and files; they do not submit evaluations.

1. Ask the participant to open **Foundry project** with the listed **Sign-in account**.
2. Compare the displayed project name with **Project name** in the draft invitation.
3. Ask them to download the module ZIP from **Workshop files** and select **Extract All**.
4. Open its `README.md`, then the entries below.

| Module | Open | Access works when |
| --- | --- | --- |
| Evaluate | `instructor\baseline\report.md`, `instructor\candidate\report.md` and both `tool-traces.md` files | Reports and their trace links open |
| Ship | **Blocked run**, **Accepted run** and their job-log links | Run pages and logs open |
| Observe and Operate | **Trace**, **Alert** and **Dashboard** | Trace details, alert and chart are visible |
| Advanced | `runbook.md`, **Trace**, **Blocked run** and **Recovered run** | Procedure and saved records open |

For Evaluate, also open `instructor\baseline\cloud_evaluation.json`.
Use **Ctrl+F** to find `report_url`; paste its value without quotation marks
into the signed-in browser. The evaluation page must show that run's results.

If `report_url` is missing, give its `eval_id` and `run_id` to the author for
the matching link. If a trace opens as a list, use
[the trace lookup steps](../labs/observe-operate/lab.md#find-the-supplied-trace).
Do not choose an unrelated run to make the check pass.

#### Try one evaluation with participant permissions

**Evaluate only. This is a billable rehearsal, not participant homework.**
Use the invitation's **Network access** instructions first if a VPN is required.

1. Have the participant complete [Evaluate pre-work](README.md#evaluate) on their actual or prepared machine.
2. Run [Evaluate step 3](../labs/evaluate/lab.md#3-run-the-supported-public-command) once.
3. Review the report and Foundry page using [lab step 4](../labs/evaluate/lab.md#4-inspect-the-report-and-actual-interactions).
4. Find all eight requests, with actual answers, both scores and no agent-call or scoring errors.

**Expected:** the participant can submit and read results; the agent can answer.
Exit `2` means a quality threshold failed, not that authentication failed.
Do not require the deliberately faulty candidate to pass before teaching.

If the run times out, use the lab's recovery procedure instead of resubmitting.
For access denied, give the administrator the failing action, account or agent,
and error. Do not grant broad access or disable network restrictions.

### Evaluate readiness checks

- [ ] A person with participant permissions can start the lab and complete an evaluation.
- [ ] Both runs use the versions named in the README; all eight requests were reviewed.
- [ ] The tool results and extra checks are available; any missing checks are listed.
- [ ] Rehearsal fits the lab time and approved spending limit, with enough model capacity for the planned class.
- [ ] Participants can download the course ZIPs and open their report links.

## Ship

For each class, choose GitHub Actions or Azure Pipelines. Check that participants
can open the saved blocked and accepted runs. Give them the Evaluate reports
even if they did not attend that module.

### Authoring requirements (not an executable pipeline setup)

The repository does not yet supply runnable track YAML. Authors must complete
evaluation, human approval, `azd deploy`, test requests after deployment and recovery
in the chosen track before teaching live pipeline practice.

Starting references: [GitHub workload identity](https://learn.microsoft.com/azure/developer/github/connect-from-azure-openid-connect),
[azd GitHub pipeline](https://learn.microsoft.com/azure/developer/azure-developer-cli/pipeline-github-actions),
[Azure Pipelines workload identity](https://learn.microsoft.com/azure/devops/pipelines/release/configure-workload-identity?view=azure-devops)
and [approvals](https://learn.microsoft.com/azure/devops/pipelines/process/approvals?view=azure-devops).
Do not provision unrelated tutorial resources.

### Package the read-only Ship review

**Used for:** comparing a release that was blocked with one that was approved,
without starting another pipeline.

Create `.local\staging\ship` under Evaluate's folder, with these contents:

| Entry | Content |
| --- | --- |
| `blocked`, `accepted` | Real `report.md` and `results.json` from each corresponding pipeline run |
| `deployment` | Reviewed `azure.yaml` and the code folders named in it |
| `README.md` | **Blocked run**, **Accepted run**, direct job-log links, **Deployment source**, **Evaluated source revision**, **Deployed agent version**, **Approval**, **Smoke-test evidence**, **Recovery instructions** |

In the README's **Pipeline steps** section, write the actual evaluation,
review/approval and deployment job/step names shown in those runs. Identify
the check or review that stopped the blocked run. Learners use these names
to find the logs and determine whether deployment ran.

Download artifacts from GitHub **Actions > run > Artifacts** or Azure Pipelines
**Pipelines > run > Summary > published artifacts**. The track author names the
actual artifact; there is no configured pipeline artifact here yet.

Zip the contents, without the `ship` wrapper, as `agentops-ship-review.zip`.
Remove secrets, `.azure` and virtual environments before distribution.

**Smoke-test evidence** means the responses to a few test requests after
deployment. **Recovery instructions** explain how to restore the previous
working version if those requests fail.

## Observe and Operate

For each class, open the supplied trace and alert and check that they refer to
the same request and time. Participants only read the results; they do not
configure monitoring or respond to a live incident.

### Authoring requirements (not an executable monitoring setup)

Authors must run a fictional test request and save its real execution trace,
the alert it caused and a response procedure they have tested.
Use [Foundry tracing](https://learn.microsoft.com/azure/foundry/observability/how-to/trace-agent-setup)
and [log alert guidance](https://learn.microsoft.com/azure/azure-monitor/alerts/alerts-create-log-alert-rule)
with the workshop's Application Insights/Log Analytics resource. Send test
notifications only to people who agreed to receive them.

### Package the read-only Observe and Operate review

**Used for:** following one real test request from trace to alert and choosing
an allowed response, without changing the running service.

Under `agentops\workshop\labs\evaluate`, create `.local\staging\observe` with:

| Entry | Content |
| --- | --- |
| `README.md` | **Trace**, **UTC time range**, **Trace ID**, **Agent version**, **Alert**, **Dashboard** and any recurring-evaluation result |
| `response-notes.md` | What went wrong, what action is allowed, who acts, who to call for help, when to stop and what to retest |

Copy the trace URL from Foundry **Agents > Traces** and fired-alert URL from
Azure portal **Monitor > Alerts**. Include the trace ID/time range if its URL
opens only the list. If no automatic or scheduled evaluation ran, mark that
part **Not assessed**.

Remove sensitive information and zip the files as `agentops-observe-review.zip`, without
an `observe` wrapper.

## Advanced (optional)

For each class, read the incident procedure and check who is allowed to run it.
The scripts for causing a test failure and the complete release pipeline are
not supplied here yet.

### Authoring requirements (not an executable incident procedure)

Authors must cause a reversible failure on a separate test agent, restore its
previous working version, and add a test that catches the same bug.
Verify that failing this test stops release. Record who may act, the time and
spending limits, and when to stop.
Do not use production data or disrupt other workloads.

### Package the read-only advanced review

**Used for:** comparing the incident before and after recovery, then seeing
which new test prevents the same bug from returning.

Under `agentops\workshop\labs\evaluate`, create `.local\staging\advanced` with:

| Entry | Content |
| --- | --- |
| `before`, `after` | Each run's actual `turns.jsonl`, `agentops.yaml`, `report.md` and `results.json` |
| `runbook.md` | Test agent, person allowed to act, exact failure command, when to stop, who to contact and tested recovery steps |
| `README.md` | **Trace**, **Trace ID**, **UTC time range**, **Blocked run**, **Recovered run**, **Source revisions**, **Review process**, links to both reports |

Add **Regression request** with the request text or a link to its dataset row.
In `runbook.md`, state the expected response after recovery so learners can
compare it with the saved result.

Zip the contents as `agentops-advanced-review.zip`, without the `advanced` wrapper.
For standalone delivery, create missing staging folders; running Evaluate is
not required just to package evidence.

## Readiness gate

Approve each selected module separately. Unfinished packages or missing real
evidence cannot be presented as validated hands-on exercises.
If the required files are missing, explain that the session is a design discussion,
not a completed hands-on lab.

See [TOOLING](../labs/evaluate/TOOLING.md#authoring-validation-status) for scripts
and service checks still missing. Completing them is the author's job, not participant pre-work.

## Retention and cleanup

Keep the versioned agents and approved evidence through the selected modules.
Participants do not delete cloud resources.

**PROJECT OWNER, after the retention date:**

1. Save the required reports and tool records outside any Azure resources being removed.
2. In [Azure portal](https://portal.azure.com), open **Resource groups** and select the group used in environment setup.
3. Review its resource list. Continue only if every listed resource was created solely for this workshop and deletion is approved.
4. Select **Delete resource group**, enter its exact name and confirm deletion.

This permanently removes the resources and their data in that group; see
[resource-group deletion](https://learn.microsoft.com/azure/azure-resource-manager/management/delete-resource-group).
If the class reused an existing project, **do not delete its resource group**.
Give its owner the retained workshop agent versions, model deployments and
access assignments so they can remove only the items approved for removal.
