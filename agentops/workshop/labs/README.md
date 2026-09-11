# AgentOps workshop labs

![Build confidence. One agent step at a time. Evaluate, Ship, Observe and Operate with Microsoft Foundry.](../assets/banners/welcome.png)

**Start with [participant pre-work](../pre-work/README.md), then open the lab
selected in your invitation.** Teaching the workshop? Start with the
[instructor guide](../instructor-guide/README.md) instead.

## Follow the workshop sequence

| Order | Open this lab | What you will work on |
| --- | --- | --- |
| 1 | [Evaluate](01-evaluate/lab.md) | Compare agent versions using responses, tool actions and evaluation results |
| 2 | [Ship](02-ship/lab.md) | Connect evaluation findings to a release decision and deployment evidence |
| 3 | [Observe and Operate](03-observe-operate/lab.md) | Connect a runtime problem to its trace, an appropriate response and future tests |
| Optional | [Advanced](04-advanced/lab.md) | Explore a cross-module exercise beyond the three core modules |

The folder numbers show the sequence for the full workshop. You can also
attend a single module: complete only its pre-work, and use the earlier
results supplied by the instructor.

**Choose one Ship path:** [GitHub Actions](02-ship/github-actions/README.md)
or [Azure Pipelines](02-ship/azure-pipelines/README.md). They are alternatives
within module 2, not two consecutive labs.

Each lab identifies the activity available today. Ship, Observe and Operate,
and Advanced currently review instructor-supplied results; their full
hands-on outlines are not instructions to execute.

## Where is the agent built?

The instructor/admin prepares or reuses the Foundry environment and deploys
the help desk agent **before the workshop**. Participants do not create a
separate environment or deploy an agent to begin Evaluate.
The [technical preparation guide](../pre-work/instructor-setup.md) links to
environment setup and agent deployment.

The unnumbered [`shared`](shared/) folder holds reusable code and files.
Its [help desk agent](shared/helpdesk-agent/README.md) supports the labs;
it is not a preliminary participant lab.

## Find the other workshop materials

Use the [folder map](../../README.md#folder-map) to find the customer
one-pager, decks, instructor guidance and implementation guidance.
Preparation stays in pre-work; the numbered labs explain what to do
during the selected activity.
