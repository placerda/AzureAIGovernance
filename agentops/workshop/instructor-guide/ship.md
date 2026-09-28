# Teaching Ship

[Back to the instructor guide](README.md)

**Participant entry:** [02-ship](../labs/02-ship/lab.md). It follows Evaluate
in the full workshop; the lab's scenario is enough for participants who did not
attend Evaluate.

## Learning focus

Connect an evaluation decision to a controlled release. Participants build the
pipeline themselves, so they should leave understanding why a release stops,
what allows it to proceed, and how to prove that the released version is the
one they tested.

## Before the session

Read the [Ship deck and speaker notes](../decks/ship/agentops-ship-workshop.pptx)
and the [lab](../labs/02-ship/lab.md). Choose
[GitHub Actions](../labs/02-ship/github-actions/README.md) or
[Azure Pipelines](../labs/02-ship/azure-pipelines/README.md): both pipeline tools teach
the same release process. They are alternatives, not two labs to complete.

All the technical preparation is in [Ship preparation](../pre-work/technical-setup.md#ship).
You prepare one class repository for the whole class, once. Participants then
create their own pipeline inside it, on their own branch.

When you finish, you should have:

- The class repository with the help desk agent, its Azure sign-in, settings
  and the `dev` and `production` approval environments.
- Your own `rehearsal` branch with one rejected run and one released run, to
  show on screen and to compare against participants' runs.
- The invitation sent, with the **Ship settings** you tested.

## Present the module

Allow 60 minutes for the presentation. Connect versioning, automated checks,
approvals, deployment and recovery. Ask what would stop a release in the
participants' own projects, beyond passing average evaluation scores.

## Hands-on lab (60 minutes)

- Steps 1 to 3: participants clone, generate the starting pipeline and adapt
  it. Walk the room while they read the generated file; most questions are
  about what each job does.
- Step 4: while the first run takes 10 to 15 minutes, ask each participant to
  find the evaluation report and decide whether to approve. The candidate
  should be rejected.
- Steps 5 and 6: they fix the routing, release the version they tested and
  record the release. Close by comparing a rejected and a released run.

Participants approve their own runs in the class repository. That keeps the
lab moving; in their own projects the approver should be someone else.

## Instructor demo (20 minutes)

Show the pipeline file on your `rehearsal` branch, then its rejected and
released runs. Point out where the evaluation stopped the release, where the
approval was recorded and where the smoke test checked the released version.
If a live run fails, read its log with the group instead of starting new runs
to fill the time.

## Close and connect to Observe and Operate

Participants keep their pipeline file and the two runs. Ask what the team would
monitor after release and who would respond if the agent behaved differently in
use. That introduces the next module.