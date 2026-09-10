---
title: "AgentOps Value Based Delivery Workshop"
subtitle: "Evaluate, Ship, Observe, and Operate Microsoft Foundry agents"
duration: "6h hands-on; 4h demo"
structure: "Select one mode before delivery"
difficulty: "300: Advanced"
delivery: "Remote or onsite"
---

# Workshop

## Description

Apply Evaluate, Ship, Observe, and Operate to Microsoft Foundry agents through
one preselected mode: participant hands-on labs or instructor-led
demonstrations. Intended for teams that govern, build, release, and operate AI
agents.

## Outcomes

- Explain the four AgentOps practices and how they connect.
- Recognize evaluation evidence and release readiness controls.
- Interpret runtime signals and operational responses.
- Relate the practices to guided Microsoft Foundry scenarios.

## Methodology

- **Learn:** presentations, demos, and discussion.
- **Apply:** guided labs or instructor walkthroughs in Microsoft Foundry.
- **Reinforce:** review results and connect the four practices.

## Scope

- **Evaluate:** define criteria and interpret evaluation evidence.
- **Ship:** establish versioning, release gates, and readiness.
- **Observe:** interpret runtime traces, metrics, logs, and usage.
- **Operate:** respond, maintain, manage change, and improve.

Observe and Operate remain distinct practices in one shared module.

## Prerequisites

- **Hands-on:** complete [participant pre-work](https://github.com/placerda/AzureAIGovernance/blob/main/agentops/workshop/pre-work/README.md).
- **Instructor/admin:** accept the pre-work readiness gate and prepare evidence.
  Demo attendees need no Azure access. Setup is outside workshop time.

## Evaluate facilitation

After the 60-minute presentation, select the 60-minute lab or 20-minute demo.

### Hands-on allocation

| Minutes | Participant activity and evidence |
| --- | --- |
| 0-5 | Tool roles, handoff and workspace context |
| 5-13 | Tools, eight cases, mappings and thresholds |
| 13-25 | One CLI run, progress and baseline report |
| 25-35 | Rows, completeness and tool/source failures |
| 35-44 | Domain rubric calibration and native safety |
| 44-51 | Conversation scope and red-team coverage |
| 51-60 | Decision and evidence handoff to Ship |

### Selected 20-minute demo

Allow **3m** for azd/Accelerator roles, target, dataset and config; **3m** to
start the CLI run and open a matching rehearsal bundle; **5m** for report,
raw rows, baseline and both defects; **5m** for native rubric, safety,
conversation and red-team evidence; **4m** for the decision, gaps and handoff.

Cloud completion is not guaranteed. Label pre-completed results **instructor
evidence review**, never the in-progress run. Follow lab failure handling;
do not resubmit blindly or present missing evidence as a pass.

## Agenda

| Module | Duration | Learning artifact |
| --- | --- | --- |
| Evaluate | 2h hands-on<br/>1h 20m demo | Sample evaluation criteria |
| Ship | 2h hands-on<br/>1h 20m demo | Sample release checklist |
| Observe and Operate | 2h hands-on<br/>1h 20m demo | Sample runtime signal review |

## Delivery options

- **Hands-on (preferred):** 60m presentation and 60m participant lab per module.
- **Demo (fallback):** 60m presentation and 20m instructor demo per module.
- **Advanced extension (optional):** two hours hands-on or one hour demo at
  difficulty 400, producing a tested runbook, regression case, and updated gate.

Choose the mode before delivery. Do not provision environments during the
workshop.

## Preparation and delivery

1. Confirm participants, selected modules, and outcomes.
2. Rehearse the selected mode; use labelled evidence discussion if readiness is incomplete.
3. Capture questions, takeaways, and follow-up learning resources.

## Reference implementation

Evaluate uses the released [AgentOps Accelerator](https://aka.ms/agentops-accelerator)
public CLI. Native Microsoft Foundry activities supplement its gate without
requiring internal Accelerator APIs.
