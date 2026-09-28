# Evaluate workshop lab

![A good answer is a start. Check what the agent did. Test the help desk agent, inspect the results, and compare versions.](../../assets/banners/evaluate.png)

[Lab sequence](../README.md) | **Module 1 of 3**

## Lab definition

**Objective:** Use Microsoft Foundry evaluation and its evaluators to assess a
specific version of a help desk agent and decide whether its answers and actions
are good enough to release.

**Duration:** 60 minutes hands-on after the 60-minute presentation.

**Difficulty:** 300: Advanced.

**What you will keep:** Evaluation settings, the results for each request,
and reports showing what passed, failed or still needs investigation.

**Prerequisite:** Complete [participant pre-work](../../pre-work/README.md)
and have the invitation's **Evaluate settings** at hand.
Installation, authentication, permissions and deployment are outside this lab.
The instructor completes [environment setup](../../pre-work/foundry-environment.md)
and [agent deployment](../shared/helpdesk-agent/README.md) before you start.

**On this page**

- [Scenario](#scenario)
- [Tool roles](#tool-roles)
- [1. Create your workspace and confirm the agent versions](#1-create-your-workspace-and-confirm-the-agent-versions)
- [2. Review the dataset and criteria](#2-review-the-dataset-and-criteria)
- [3. Evaluate the baseline and the candidate](#3-evaluate-the-baseline-and-the-candidate)
- [4. Inspect the report and actual interactions](#4-inspect-the-report-and-actual-interactions)
- [5. Supplement: domain rubric and safety](#5-supplement-domain-rubric-and-safety)
- [6. Supplement: conversation and red teaming](#6-supplement-conversation-and-red-teaming)
- [7. Decide and hand off to Ship](#7-decide-and-hand-off-to-ship)

## Scenario

The [help desk agent](../shared/helpdesk-agent/README.md) looks up fictional
support articles, checks simulated VPN status and creates simulated tickets.
No real tickets or private employee records are involved.

| Version | Password article reference | Team receiving a VPN ticket |
| --- | --- | --- |
| Baseline | Preserved | Network Support |
| Candidate | Removed | Software Support |

These are deliberate bugs in the agent's tools. Can a helpful-sounding answer
hide a wrong action? Inspect what the tools actually returned to find out.

Use Microsoft Foundry evaluation to test the deployed help desk agent with the
lab dataset. Foundry evaluators assess whether its responses are coherent and
how closely they match the expected answers.

Review these scores alongside the
actual tool calls and results to decide whether the candidate is ready to
release. The AgentOps Accelerator CLI supports this workflow by submitting the
evaluation and generating reports.

## Tool roles

A **candidate** is the agent version under review. The **baseline** is the
earlier version used for comparison. A **CLI** is a program you run by typing
commands in PowerShell.

An **evaluator** checks one aspect of an answer. The two evaluators here use
a **scoring model**, also called a **judge**, to assign scores.

| Tool | Role in the workshop |
| --- | --- |
| Microsoft Foundry Agent Service | Runs the selected agent version, including its model and tool calls |
| Microsoft Foundry Evaluation and evaluators | Runs requests, scores answers and retains per-case results |
| AgentOps Accelerator (`agentops`) | Submits evaluations, downloads results and checks scores against the configured minimums; it does not deploy agents |

Use any text editor. The steps illustrate VS Code; no extension is needed.

<a id="1-start-the-workspace-and-confirm-the-exact-candidate"></a>

## 1. Create your workspace and confirm the agent versions

**Why this step:** the AgentOps Accelerator CLI needs to know which Foundry project to
use, which two agent versions to compare and which model scores the answers.
You enter those four values once; the block below writes them into your
**workspace**, a local folder with your settings and test requests.

The invitation's **Evaluate settings** section lists the four values:

| Invitation value | What it identifies |
| --- | --- |
| Project endpoint | The shared Foundry project, as a URL ending in `/api/projects/NAME` |
| Baseline agent | The earlier agent version, as a URL ending in `/agents/NAME/versions/NUMBER` |
| Candidate agent | The version under review, in the same format |
| Scoring-model deployment | The model deployment that scores the answers |

### Start PowerShell and create the workspace

1. In File Explorer, open `agentops\workshop\labs\01-evaluate` inside the repository.
2. Type `powershell` in the address bar and press Enter.
3. Paste and run the entire block below. Paste each value from the invitation when prompted.

**What this block does:** creates your evaluation workspace from the invitation values. Local only.

```powershell
$ErrorActionPreference = 'Stop'
$EvaluateRoot = (Get-Location).Path
$LocalRoot = Join-Path $EvaluateRoot '.local'
$Workspace = Join-Path $LocalRoot 'workspace'
$AgentOps = Join-Path $EvaluateRoot '.venv\Scripts\agentops.exe'
$ProjectEndpoint = (Read-Host 'Project endpoint').Trim()
$BaselineAgent = (Read-Host 'Baseline agent').Trim()
$CandidateAgent = (Read-Host 'Candidate agent').Trim()
$ScoringModel = (Read-Host 'Scoring-model deployment').Trim()
'AGENTOPS_AGENT','AZURE_AI_FOUNDRY_PROJECT_ENDPOINT','AZURE_OPENAI_DEPLOYMENT','AZURE_AI_MODEL_DEPLOYMENT_NAME' |
    ForEach-Object { Remove-Item "Env:$_" -ErrorAction SilentlyContinue }
if (-not (Test-Path $Workspace)) {
    New-Item -ItemType Directory -Force $Workspace | Out-Null
    Copy-Item (Join-Path $EvaluateRoot 'assets\turns.jsonl') $Workspace
    & $AgentOps init --dir $Workspace --no-prompt `
      --project-endpoint $ProjectEndpoint --agent $CandidateAgent --dataset turns.jsonl
    if ($LASTEXITCODE -ne 0) { throw 'Workspace creation failed. Check the four values, then ask the instructor.' }
    (Get-Content (Join-Path $EvaluateRoot 'assets\agentops.yaml')) -replace '^agent: .*', "agent: $CandidateAgent" |
        Set-Content (Join-Path $Workspace 'agentops.yaml')
    New-Item -ItemType Directory -Force (Join-Path $Workspace '.agentops') | Out-Null
    Set-Content (Join-Path $Workspace '.agentops\.env') @(
        "AZURE_AI_FOUNDRY_PROJECT_ENDPOINT=$ProjectEndpoint",
        "AZURE_OPENAI_DEPLOYMENT=$ScoringModel"
    )
}
Set-Location $Workspace
& $AgentOps init show
if ($LASTEXITCODE -ne 0) { throw 'Cannot read the workspace settings. Ask the instructor.' }
Select-String -Path '.agentops\.env' -Pattern '^AZURE_OPENAI_DEPLOYMENT='
```

The block creates `.local\workspace` the first time you run it: it copies the
test requests and settings from `assets`, then fills in your four values.
If the folder already exists, it keeps it and only displays its settings.
Nothing is deployed or submitted, and no cost is incurred.

The reset lines remove old project or model choices from this PowerShell
window. They do not delete saved sign-ins or change your computer's settings.

#### Check the displayed values

Keep the invitation open beside PowerShell:

1. Find `AZURE_AI_FOUNDRY_PROJECT_ENDPOINT` in the output. Its `value` must match **Project endpoint**.
2. Find `agent:`. It must match **Candidate agent**, including the number after `/versions/`.
3. The final `AZURE_OPENAI_DEPLOYMENT=` line must match **Scoring-model deployment**.

**A value is wrong?** Delete the `.local\workspace` folder and run the block
again with the correct values. Do not edit the settings to point at another project.

`no azd environment found` and an unset `APPLICATIONINSIGHTS_CONNECTION_STRING`
are expected in this lab's CLI workspace. They refer to optional features;
do not install or configure them to remove those messages.

Keep this window open. If you close it, run the block again with the same values:
the later steps use the variables it defines.

## 2. Review the dataset and criteria

![Before testing everything, decide what good looks like. Choose the outcomes, risks, metrics, and tests that matter.](../../assets/banners/criteria.png)

The **dataset** is the collection of test requests. First, see what the agent
will be asked and how its answers will be scored.

1. In VS Code's repository tree, expand `agentops\workshop\labs\01-evaluate\.local\workspace`.
2. Open `turns.jsonl`: eight employee requests, one per line.
3. Open `agentops.yaml`: the selected agent and scoring rules.

Do not edit either file.

| Dataset field | Meaning |
| --- | --- |
| `input` | Employee request sent to the agent |
| `expected` | Reference answer used by the similarity judge |
| `critical` | Case needing particular attention from the human reviewer |
| `expected_behavior` | Behavior the human reviewer should check |

No row contains a prerecorded answer. `critical` and `expected_behavior` guide
your review; the CLI does not automatically check them.
A **gate** is an automated pass/fail check, not permission to release the agent.

**Expected result:** eight lines and the two configured judges below. If the
files differ from the lab's `assets` folder, delete `.local\workspace` and rerun step 1.

The [Foundry evaluators](https://learn.microsoft.com/azure/foundry/concepts/built-in-evaluators)
selected in the [configuration](assets/agentops.yaml) check **coherence**
(whether the answer makes sense) and **similarity** to the reference answer.

The input column shows which text each evaluator receives. These connections
are already configured.

| Name in the settings | Foundry evaluator | Text it receives | CLI pass rule |
| --- | --- | --- | --- |
| `CoherenceEvaluator` | `builtin.coherence` | Request (`item.input`) and agent answer (`sample.output_text`) | Average `coherence >= 3` |
| `SimilarityEvaluator` | `builtin.similarity` | Same request and answer, plus the reference answer (`item.expected`) | Average `similarity >= 3` |

Both scores normally use a 1-5 scale. A **threshold** is the minimum required
score: here, 3 for each average. These are workshop settings, not a release
policy suitable for every agent.

**Different scale:** ask the instructor what the returned values mean.
Do not interpret pass/fail or 0/1 fields as 1-5 quality scores.

Only `input` goes to the agent; it does not see the expected answer or scoring
rules. Similarity can flag an answer that differs from the reference. It does
**not** prove that a ticket was created, the right tool inputs were used, or the
user's problem was solved safely.

Predict how the two bugs might affect the scores. Then find `private-ticket`
or `privileged-request`: could a good average prove that the agent handled
that request safely?

<a id="3-run-the-supported-public-command"></a>

## 3. Evaluate the baseline and the candidate

![Ready to press Run? One run is enough to start. Cloud runs cost money; check the results before trying again.](../../assets/banners/ready-to-run.png)

**This uses paid Azure services:** the agent, model calls and evaluations can incur charges.
Wait for the instructor's go-ahead.

**Why two evaluations:** this is how a team checks a change in practice. First
evaluate the version already in use, the **baseline**, to get the reference
scores. Then evaluate the new version, the **candidate**, with the same
requests and scoring rules, and compare the two.

Other participants run their evaluations against the same agent versions at the
same time. Each run is separate in Foundry and saves its results in your own
`.local\runs` folder, so they do not overwrite each other.

### Evaluate the baseline

Run this block **once**, in the PowerShell window from step 1:

**What this block does:** evaluates the baseline version in Foundry and saves its scores. Uses model calls and takes a few minutes.

```powershell
$RunsRoot = Join-Path $LocalRoot ('runs\' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
$BaselineRun = Join-Path $RunsRoot 'baseline'
$RunRoot = Join-Path $RunsRoot 'candidate'
New-Item -ItemType Directory -Path $RunsRoot | Out-Null
Set-Location $Workspace
Start-Transcript -Path (Join-Path $RunsRoot 'baseline-terminal.txt') | Out-Null
& $AgentOps eval run --config agentops.yaml --agent $BaselineAgent --output $BaselineRun
$baselineExit = $LASTEXITCODE
Stop-Transcript | Out-Null
$baselineExit
if ($baselineExit -notin @(0,2)) { throw 'Run error, not a quality verdict. Follow the recovery paragraph before proceeding.' }
$BaselineRun
```

`--agent` sends the requests to the baseline version instead of the candidate
named in `agentops.yaml`. Everything else stays the same.

**Expected result:** the last line prints the baseline results folder.

### Evaluate the candidate and compare

Run this block **once**, after the baseline finishes:

**What this block does:** evaluates the candidate the same way and compares it with the baseline. Uses model calls.

```powershell
Start-Transcript -Path (Join-Path $RunsRoot 'candidate-terminal.txt') | Out-Null
& $AgentOps eval run --config agentops.yaml --output $RunRoot `
  --baseline (Join-Path $BaselineRun 'results.json')
$evalExit = $LASTEXITCODE
Stop-Transcript | Out-Null
$evalExit
if ($evalExit -notin @(0,2)) { throw 'Run error, not a quality verdict. Follow the recovery paragraph before proceeding.' }
$RunRoot
```

`--baseline` compares the candidate's scores with the baseline results you just
saved and adds the differences to the candidate report.

Each [Foundry evaluation](https://learn.microsoft.com/azure/foundry/observability/how-to/cloud-evaluation-targets)
runs eight requests against the selected agent version. Foundry keeps responses,
scores, reasons and errors in the project.

The CLI downloads those results and compares the average scores with the
configured minimums. Passing does not approve a release.

Foundry saves the evaluation settings and each run's results. The commands do
not create new infrastructure or register a reusable dataset.

**Expected result:** the last line prints the candidate results folder.
Keep both folders for step 4. Running a block again submits another paid run,
even with the same requests, and uses a new folder. Keep the terminal logs
private; remove sensitive information before sharing them.

### Recovery after timeout or failure

The CLI checks for completion for approximately ten minutes. Foundry may still
be working when that wait ends. **Do not run the command again just because it timed out.**

1. With the instructor, locate the existing Foundry run using the printed identifiers.
2. Follow the rest of the lab on the instructor's screen, using the instructor's
   own evaluation of the same versions. Label your notes **instructor demonstration**,
   not your own completed evaluation.

The CLI has no command to resume a run or download it later.
Creating a report requires a complete local `results.json`.

Both commands return an exit code:

| Exit code | Meaning |
| --- | --- |
| `0` | The configured averages passed; you still need to review individual cases |
| `2` | Results are available, but at least one average missed its minimum |
| `1` | Settings or execution failed; this does not tell you whether the agent is good |

A failed gate still has findings to inspect. Exit `2` is a reason to read the
report, not to discard it or rerun until the score turns green.

**Expected result:** A completed run produces `report.md`, `results.json`,
`cloud_evaluation.json` and `cloud_output_items.json`. An error or incomplete
run is not a passing or failing quality assessment.

## 4. Inspect the report and actual interactions

**Why use both views:** the local report summarizes scores and baseline
differences; Foundry lets you inspect the answers and execution details behind
them. They must describe the same run.

The CLI saves the downloaded results in `results.json` and builds `report.md`
from that file.

### Open the local report

1. Run `$RunRoot` in PowerShell to display the results folder, including when using fallback.
2. In VS Code **File > Open File**, paste that path, press Enter and select `report.md`.
3. Press **Ctrl+Shift+V**.

| Report section | Inspect |
| --- | --- |
| Metrics / Thresholds | Averages and pass/fail checks |
| Rows / Row Details | Individual answers, scores and reasons |
| Comparison vs Baseline, when present | Deltas: differences from the baseline |

### Open the same run in Foundry

1. Open `cloud_evaluation.json` from the same results folder.
2. Press **Ctrl+F** and find `report_url`.
3. Copy its value, without quotation marks, into your browser.

**URL absent:** give the instructor that file's `eval_id` and `run_id` and request
the matching direct link. Do not substitute another run.

**Expected result:** the report and Foundry page describe the same candidate and
eight requests. If a file or link does not open, ask the instructor to fix it
before continuing that part of the review. Do not choose another run just because it opens.

<details>
<summary>Where to look in the JSON files when a score needs a closer look</summary>

These are saved JSON files, not forms to fill in. `rows[]` means “each entry in
the rows list”; it is not a literal field name to search for.

| What to find | Exact saved field |
| --- | --- |
| Target and protocol | `results.json`: `target.raw`, `target.protocol` |
| Run status and Foundry link | `cloud_evaluation.json`: `status`, `eval_id`, `run_id`, `report_url` |
| Actual answer and invocation error | `results.json`: `rows[].input`, `response`, `error` |
| Score and explanation | Each row's `metrics[].name`, `value`, `reason`, `error` |
| Raw service score and original input ID | `cloud_output_items.json`: each item's `datasource_item.id`, `datasource_item.input`, `results[]` (usually `score`, `reason`, `label`; inspect nested errors too) |
| Baseline difference | `results.json`: `comparison.metrics[].metric`, `baseline`, `current`, `delta`, `direction` |

In `results.json`, use **Ctrl+F** to find a request's `input` text.
Read that entry's `response`, `metrics` and `error`.

</details>

Match each result to the request's ID or text, not its position in the file.
Baseline and candidate results can appear in different orders.

In the **Foundry evaluation page**:

1. Confirm the run completed for the selected version and all eight different requests.
2. Check that every request has both scores, within the expected scale, and no
   agent-call or scoring errors. Investigate blank scores or `NaN` instead of counting them as passes.
3. Read the score explanations for two cases. Was the answer poor, or did the evaluator fail to score it?
4. Inspect the actual tool results for `password-basic` and `vpn-ticket`, using the steps below.
5. Check `private-ticket` and `privileged-request` even if the averages passed.
6. Compare baseline scores. Identify any lower score or worse behavior that needs investigation.

**Before approving a release:** an average can look good when missing or failed
results were left out. A percentage shown in the CLI report does not establish
that the separate support-quality rubric passed.

| Finding, even if the CLI passed | Decision |
| --- | --- |
| Missing scores, invalid scores or no record of tool execution | Insufficient evidence: do not approve yet |
| Confirmed serious bug, such as private-data disclosure | No-ship: do not release this version |

`--baseline` shows score differences. It does not decide how much deterioration
is acceptable or check that both runs used the same requests and scoring rules.

### Inspect executed tools

A **tool** is a function the agent calls, such as looking up an article or
creating a ticket. A **trace** records those calls and the model's steps.

**Why inspect them:** saying "I created the ticket" does not prove that the
right tool ran or sent it to the correct team.

1. In the Foundry evaluation page, select the `password-basic` result by its request text.
2. Open its trace. If only an ID is shown, open **Agents > Traces**, set the run's time range and search for that ID.
3. Select the `execute_tool lookup_article` operation and read its returned `source`, or note its absence.
4. Repeat for `vpn-ticket`: select `execute_tool create_ticket` and read its `category` argument and returned `queue`.

If the details panel shows raw fields, arguments are under
`gen_ai.tool.call.arguments` and output under `gen_ai.tool.call.result`.

**No trace available from your result?** Follow the instructor, who opens the
same two traces from their own evaluation of these versions. Label this
**instructor demonstration**: the traces are not from your run.

**Use actual execution records:** a `tool_calls` field in `results.json` can
contain copied test data, not executed calls. This dataset does not supply that
field. Without a trace or stored tool result, the action is **not verified**.

**Optional local action:** regenerate a report from the same saved results
without another cloud run. Skip this if you only need to read the existing
report. Use the same PowerShell window:

**What this block does:** rebuilds the report from saved results, without calling Foundry.

```powershell
$ReviewReport = Join-Path $RunRoot ('review-' + [guid]::NewGuid().ToString('N') + '.md')
& $AgentOps report generate --in (Join-Path $RunRoot 'results.json') --out $ReviewReport
if ($LASTEXITCODE -ne 0) { throw 'Saved-report generation failed. Retain the original results and error.' }
Get-Content $ReviewReport
```

This creates a report from saved results. It does not download missing results
or apply new thresholds you edited into `agentops.yaml`.

## 5. Supplement: domain rubric and safety

Steps 5 and 6 cover checks beyond coherent wording and similar answers. They
do not change the CLI's pass/fail result. You read the test material in
`assets`; the instructor then shows the matching Foundry results on screen,
from evaluations they ran in the same project.

If the instructor says a check was not run, note it as **Not assessed** and
agree who owns it. Missing results are never a pass.

### Compare the rubric with human judgment

A **rubric** describes what earns a low or high score. **Calibration** compares
the evaluator's scores with human ratings to see whether it applies those rules well.

**Why this comparison:** before trusting automated scores, check whether the
evaluator recognizes the same good and bad behavior a human reviewer sees.

1. Read [the rubric](assets/rubric.json) and [three calibration examples](assets/calibration.json).
2. Decide whether you agree with each `human_support_outcome` rating.
3. Follow the instructor's demonstration of the calibration evaluation in Foundry.
4. Compare the real Foundry scores with the human ratings for the wrong queue,
   unsupported guarantee and missing source.

**Check:** these three answers were written for teaching, not generated by
your candidate. Compare the 1-5 `support_outcome` scores; do not confuse them
with an overall score reported on a different scale.

Discuss disagreements, rubric changes and retest needs. Do not change a
registered evaluator during this comparison.

### Inspect candidate safety evidence

1. Follow the instructor's demonstration of the safety evaluation for the candidate.
2. Read which evaluator scored which candidate responses, what its scores mean,
   and whether any response failed to receive a score.

**Limit:** a violence check cannot tell you whether the agent protected private
data, refused unauthorized actions or resisted instructions meant to bypass its rules.

Missing evidence means **not assessed**, not a pass.

## 6. Supplement: conversation and red teaming

### Review the conversation

**Why review the whole exchange:** a good last answer can hide repeated advice
that did not solve the user's problem.

1. Read the [authored repeated-reset conversation](assets/conversations.jsonl).
2. Follow the instructor's demonstration of the conversation evaluation.
3. Compare the last answer with the whole journey and the conversation-level scores.

**Check:** this is one four-message teaching example, not a conversation with
your candidate or the eight separate test requests. Did the final answer
actually help the user, or just sound polite?

### Review the red-team scan

**Red teaming** tests adversarial attempts to make the agent behave unsafely.

1. Follow the instructor's demonstration of the red-team scan for this candidate
   version, not the project's most recent scan.
2. Read what the attacks tried to make the agent do and which attempts succeeded or failed to run.
3. Before quoting a success percentage, check how many attempts Foundry actually counted.
4. Discuss fixes and risks the scan did not test.

**Check:** the scan identifies this candidate version. Another version's scan
does not certify it.

The [results guide](assets/evidence/README.md) explains which results you
generate yourself and which the instructor demonstrates.

## 7. Decide and hand off to Ship

![Green is a clue, not a release decision. Check missing scores, failed cases and tool results before approval.](../../assets/banners/release-decision.png)

Use the reports you have already reviewed for a short closing discussion.
There is no separate worksheet to complete.

1. What did the results show? Point to an actual answer or tool result.
2. What prevents release? Include confirmed defects and missing evidence;
   passing average scores alone do not establish readiness.
3. What needs fixing or evaluating again before Ship, and who will follow up?

Keep your workspace and `.local\runs` folder together for Ship.
Use the existing workshop notes to record what blocks release and who will
follow up. You do not need to copy reports into a new document.

Do not deploy during Evaluate. Ship uses the same agent source and decision.
**No-ship** and **insufficient evidence** remain blocking.

Source, configuration or model changes require reevaluation.
Deployment may create a new version number. Before approving it for use,
check that it was built from the code and settings you evaluated.

**Expected result:** Reviewed reports and the supporting files for
[Ship](../02-ship/lab.md), with blocking findings and retest needs identified.
Keep these files through the selected modules and follow
[owner-approved cleanup](../../pre-work/README.md#retention-and-cleanup).
