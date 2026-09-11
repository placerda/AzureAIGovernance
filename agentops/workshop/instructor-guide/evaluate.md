# Teaching Evaluate

[Back to the instructor guide](README.md)

## Learning focus

Help participants decide whether an agent is good enough by looking at both
its responses and its actions. A helpful-sounding answer can hide a wrong tool
result; an average score is not the whole release decision.

## First time teaching Evaluate? Follow this route

### 1. Understand the story

Read the [Evaluate deck and speaker notes](../decks/evaluate/agentops-evaluate-workshop.pptx),
then the [participant lab](../labs/evaluate/lab.md), without running commands.
The help desk scenario uses
fictional support articles and simulated tickets, not employee data.

The **baseline** is the earlier version used for comparison. The **candidate**
is the version under review. The candidate deliberately loses the password
article's source reference and routes a VPN ticket to the wrong support team.
These examples let participants see why scores and tool results must be
reviewed together.

The lab also discusses scoring rules, safety, conversations and adversarial
tests. Use the prepared supplementary results where available and identify
any areas not yet assessed.

**Ready to continue:** you can explain why the candidate might sound helpful
but still be unsuitable for release, and how the class will investigate it.

### 2. Find what you can reuse

Ask the workshop organizer for the shared Foundry project, the two deployed
agent versions and `agentops-evaluate-workspace.zip`. Use the package's
README to compare the assigned versions, requests and scoring settings with
the lab. Reuse a package only when it matches the activity.

If a complete matching package exists, go to [rehearsal](#5-rehearse-as-a-participant).
Otherwise, prepare only the missing parts in the next two stages.
For a new computer, follow [files and tools](../pre-work/instructor-setup.md#1-prepare-the-instructor-machine)
before the technical steps.

**Initial material preparation:** real evaluation results, tool traces and the
first participant ZIP still need to be produced for the first class.
The source files are not that package. Agree this work with the material
author; a new instructor should not have to recreate it for every delivery.
See [tooling status](../labs/evaluate/TOOLING.md#authoring-validation-status)
for the current technical readiness.

### 3. Prepare or reuse the environment and agent

Follow [Foundry environment setup](../pre-work/foundry-environment.md) with
the administrator. You finish with one project shared by the class, an agent
model, a scoring model, monitoring and the required permissions.
Participants use their own accounts, but results and traces stay in the shared
project rather than being isolated by participant.

If the baseline and candidate are not ready, follow
[help desk deployment](../labs/shared/helpdesk-agent/README.md).
Keep their versioned references and send the supplied test questions.

**Ready to continue:** both versions answer, and their tool records show the
source-reference and ticket-routing differences. Installing the tools alone
does not reach this point. Return here to prepare the evaluation files.

### 4. Prepare the evaluation and participant package

Follow [Evaluate preparation](../pre-work/instructor-setup.md#evaluate)
to create the settings, evaluate the baseline and candidate, and save their
reports and actual evaluation traces. Deployment test records do not replace
the tool records from these evaluation runs.

Then follow [package preparation](../pre-work/instructor-setup.md#instructoradmin-package-and-rehearse-the-learner-bundle).
Include the baseline for comparison and the saved candidate results for
demonstration or contingency. The [evidence guide](../labs/evaluate/assets/evidence/README.md)
defines what to retain. Mark unfinished supplementary checks **Not assessed**.

**Ready to continue:** the ZIP contains the assignment, prepared settings,
comparison reports and matching tool records. Any unassessed checks are
identified, not presented as successful results.

### 5. Rehearse as a participant

Extract a fresh copy of the source and participant package. Follow
[Evaluate pre-work](../pre-work/README.md#evaluate), then the lab, with an account
that has participant permissions. Use the
[participant-access rehearsal](../pre-work/instructor-setup.md#instructoradmin-shared-environment-and-permissions)
for the access and evaluation steps.

Practise the discussion and the transition to saved results if a live run
does not finish. Allow 60 minutes for hands-on or 20 minutes for the demo,
after the presentation.

**Ready to teach:** participant access works, the required reports and traces
open, and you can guide the activity and explain its results within the
selected time. The candidate does not need passing scores; its defects
are part of the lesson.

### 6. Distribute the files and receive the class

Follow [file distribution and invitation](../pre-work/instructor-setup.md#publish-the-workshop-files-and-invitation).
Include the source ZIP for hands-on participants and the prepared workspace
package, with the account, project and download instructions tested during
rehearsal. Ask participants to finish pre-work before the class.

On the day, use the teaching flow below: presentation, lab or demo, and the
decision discussion. Environment setup and agent deployment are already done.

## Present the module

Allow 60 minutes for the presentation and discussion. Introduce the AgentOps
foundation when needed, then connect evaluation metrics and acceptance criteria
to the help desk scenario. Explain Microsoft Foundry's role before introducing
the supporting evaluation CLI.

After the presentation, use the format chosen for your session.

## Hands-on lab (60 minutes)

- Introduce the help desk agent and discuss what a good response or action
  looks like.
- Guide participants through the evaluation and comparison of the two agent
  versions. Help them connect scores with actual responses and tool use.
- Close with a discussion: is the candidate ready to move forward? What
  needs fixing or further evaluation?

Adapt the pace to the group. Leave room for questions and for participants
to explain their decisions. Use the lab for commands and troubleshooting
rather than recreating those steps in your teaching notes.

## Instructor demo (20 minutes)

Show how to start an evaluation, then walk through results from a run
prepared before the session. Explain that these are earlier results, so
the group can follow the full example without waiting for the live run.

Compare the two agent versions using their scores, responses, and tool
actions. Invite the group to identify failures and decide what should
change before release. If a result is missing, explain what still needs
to be evaluated.

If a live run fails, use the lab's failure guidance. Do not repeatedly submit
paid runs to fill the demonstration time or present saved results as the failed
run's output.

## Close and connect to Ship

Ask which findings would block release even if average scores passed.
Participants should retain their evaluation criteria, results and decision,
including anything not assessed.

Use the lab's [closing discussion](../labs/evaluate/lab.md#7-decide-and-hand-off-to-ship)
to connect that decision to Ship: which checks should be automated, and which
still need a person to review them?
