# Teaching Ship

[Back to the instructor guide](README.md)

**Participant entry:** [02-ship](../labs/02-ship/lab.md). It follows Evaluate
in the full workshop, or uses supplied Evaluate results for standalone delivery.

## Learning focus

Connect an evaluation decision to a controlled release. Participants should
understand why a release stops, what allows it to proceed, and how to know
that the deployed version is the one they intended to release.

## Before the session

Read the [Ship deck and speaker notes](../decks/ship/agentops-ship-workshop.pptx)
and the [current lab](../labs/02-ship/lab.md).
Choose either [GitHub Actions](../labs/02-ship/github-actions/README.md)
or [Azure Pipelines](../labs/02-ship/azure-pipelines/README.md) before the
session. Both tracks teach the same concepts and produce the same release
checklist. They are alternatives within the module, not two labs to complete.
Link the selected track in the invitation and use matching pipeline results.

Use [Ship preparation](../pre-work/instructor-setup.md#ship) for the saved
blocked and accepted pipeline runs, evaluation reports, approval and
post-deployment test results. For standalone delivery, supply the earlier
Evaluate reports and the same help desk scenario rather than requiring
participants to attend Evaluate first.

**Current boundary:** the available activity reviews supplied runs without
deploying anything. The full hands-on pipeline tracks are still being developed.
Do not teach the outline as an executable deployment procedure.

## Present and discuss

Use the 60-minute presentation to connect versioning, automated checks,
approvals, deployment and recovery. Ask what would stop a release in the
participants' own projects, beyond passing average evaluation scores.

For the current guided review, follow the lab with the group:

- Start with the blocked release. Ask which finding stopped it and where
  the run shows that deployment did not happen.
- Compare the accepted release. Connect the evaluation, approval and
  post-deployment test responses.
- Discuss what should happen if the code or settings change, or if the
  new version fails after deployment.

For a 20-minute demo, show one blocked and one accepted run, leaving room
for the group to explain the difference. These are prepared results, not
a deployment performed during the session.

The planned hands-on lab is 60 minutes. Its live execution guidance will
be added as the pipeline tracks are completed.

## Close and connect to Observe and Operate

Keep the release checklist and the links that support the decision.
Ask what the team would monitor after release and who would respond if
the agent behaved differently in use. That introduces the next module.
