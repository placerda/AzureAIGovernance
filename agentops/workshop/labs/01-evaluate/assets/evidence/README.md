# Guide to the instructor's result files

![Every score has a story. Keep the right evidence. Open the files that show what was tested and what happened.](../../../../assets/banners/evidence.png)

Use this guide to find the right report and understand where its results came
from. The repository supplies the instructions and test inputs, not evaluation
results: every result comes from a run in the shared Foundry project.
Authors track unfinished work in [TOOLING.md](../../TOOLING.md#validation-evidence).

## Who produces which results

All paths below are relative to `agentops\workshop\labs\01-evaluate`.

| Results | Produced by | Where |
| --- | --- | --- |
| Baseline and candidate evaluations | Each participant, in [lab step 3](../../lab.md#3-run-the-supported-public-command) | `.local\runs\<timestamp>\baseline` and `candidate` |
| Tool traces for `password-basic` and `vpn-ticket` | Each participant, from their own run in lab step 4 | Foundry **Traces** |
| The same evaluations and traces, as a fallback | The instructor, in [rehearsal](../../../../pre-work/technical-setup.md#3-instructoradmin-rehearse-the-public-cli-and-retain-the-baseline) | Shown on screen, labelled **instructor demonstration** |

Each run folder contains the CLI's `results.json`, `report.md`,
`cloud_evaluation.json` and `cloud_output_items.json`.

If a report link is unavailable, ask the instructor for the missing
permission. Do not replace it with `scripts/fixtures/offline-results.json`;
that fixture only tests report rendering and is not a workshop result.

## Main evaluation results

**INSTRUCTOR:** in rehearsal, run [both evaluations](../../../../pre-work/technical-setup.md#3-instructoradmin-rehearse-the-public-cli-and-retain-the-baseline)
and keep the **unmodified** CLI output. Confirm that the traces for
`password-basic` and `vpn-ticket` open from those evaluations in Foundry.
Keep these results on your computer; remove sensitive information before
showing them and never include passwords or keys.

**PARTICIPANT:** your own runs are the results you review. When the instructor
shows theirs instead, label them **instructor demonstration**, not your result.

Check all eight requests have two valid scores each. A good average or exit
code `0` does not prove that every result is present.
The instructor checks that both runs use the same requests and scoring rules.
Participants report differences rather than edit settings to make them match.
`--baseline` shows score changes; it does not block a release because a score got worse.

If evidence is unavailable, mark it **not assessed** in the decision and name
the person who will provide it. Missing results are not a pass.
Remove sensitive information before showing results; do not commit
tenant-specific output or production data.
