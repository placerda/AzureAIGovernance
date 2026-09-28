# Teaching Evaluate

[Back to the instructor guide](README.md)

**Participant entry:** [01-evaluate](../labs/01-evaluate/lab.md), after
[Evaluate pre-work](../pre-work/README.md#evaluate). The instructor/admin
prepares the agent beforehand; there is no participant agent-building module
before Evaluate.

## Learning focus

Help participants decide whether an agent is good enough by looking at both
its responses and its actions. A helpful-sounding answer can hide a wrong tool
result; an average score is not the whole release decision.

## Before the session

### Understand the story

Read the [Evaluate deck and speaker notes](../decks/evaluate/agentops-evaluate-workshop.pptx),
then the [participant lab](../labs/01-evaluate/lab.md), without running commands.
The help desk scenario uses fictional support articles and simulated tickets,
not employee data.

The **baseline** is the earlier version used for comparison. The **candidate**
is the version under review. The candidate deliberately loses the password
article's source reference and routes a VPN ticket to the wrong support team.
These examples let participants see why scores and tool results must be
reviewed together.

The lab also discusses scoring rules, safety, conversations and adversarial
tests as concepts in the deck; the lab does not run those checks.

You are ready to move on when you can explain why the candidate might sound
helpful but still be unsuitable for release, and how the class will
investigate it.

### Prepare the environment and rehearse

All the technical preparation is in the
[Instructor technical setup](../pre-work/technical-setup.md). Follow it from
start to finish; the Evaluate section of step 4 is the part specific to this
module. You do not need to come back here until it is done.

When you finish, you should have:

- A Foundry project with the baseline and candidate versions deployed, whose
  tool records show the source-reference and ticket-routing differences.
- Your own comparison reports and matching tool traces to show on screen, with
  any unassessed checks marked **Not assessed**.
- A rehearsal with the test account that worked within the selected time: 60
  minutes for hands-on or 20 minutes for the demo, after the presentation.
- The invitation sent, with the **Evaluate settings** you tested.

The candidate does not need passing scores; its defects are part of the lesson.

Participants need no files from you. In the lab, each participant creates an
evaluation workspace: a local folder on their own computer with their settings
and test requests. Everyone uses the same shared Foundry project, so all
evaluation results and traces are stored there, not separated by participant.

## Present the module

Allow 60 minutes for the presentation and discussion. Introduce the AgentOps
foundation when needed, then connect evaluation metrics and acceptance criteria
to the help desk scenario. Explain Microsoft Foundry's role before introducing
the supporting AgentOps Accelerator CLI.

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

Show how to start an evaluation, then walk through results from your
own rehearsal run. Explain that these are earlier results, so
the group can follow the full example without waiting for the live run.

Compare the two agent versions using their scores, responses, and tool
actions. Invite the group to identify failures and decide what should
change before release. If a result is missing, explain what still needs
to be evaluated.

If a live run fails, use the lab's failure guidance. Do not repeatedly submit
paid runs to fill the demonstration time or present your rehearsal results as the failed
run's output.

## Close and connect to Ship

Ask which findings would block release even if average scores passed.
Participants should retain their evaluation criteria, results and decision,
including anything not assessed.

Use the lab's [closing discussion](../labs/01-evaluate/lab.md#5-decide-and-hand-off-to-ship)
to connect that decision to Ship: which checks should be automated, and which
still need a person to review them?
