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

> Observe and Operate are distinct practices delivered together in one content
> module because their workflows and evidence are closely connected.

## Prerequisites

- **Hands-on:** [lab access](https://github.com/placerda/AzureAIGovernance/tree/main/agentops/workshop/labs),
  Foundry project, model quota, and the selected Ship CI/CD track.
- **Demo:** a validated instructor environment; no participant Azure access.

## Pre-workshop provisioning

> For hands-on delivery, assign every Participant access entry to each
> participant before the session. Setup and troubleshooting are outside workshop
> time.

### Environment readiness

| Area | Ready when |
| --- | --- |
| Foundry project | One assigned project per participant |
| Model capacity | Quota and unique name assigned; participant creates the deployment in the lab |
| Observability | Application Insights connected; test trace confirmed |
| Tooling | [AgentOps Accelerator installation](https://azure.github.io/agentops/) completed |

### Access assignments

| Identity | Scope | Role or access |
| --- | --- | --- |
| Participant | Lab delivery | [Lab repository access](https://github.com/placerda/AzureAIGovernance/tree/main/agentops/workshop/labs); selected Ship CI/CD track |
| Participant | Foundry project | Foundry User |
| Participant | Foundry resource | Reader |
| Participant | Model deployment | Cognitive Services Contributor on the Foundry account |
| Participant | Application Insights | Log Analytics Reader |
| Participant | Evaluator model | Cognitive Services OpenAI User on its AI Services resource |
| Project managed identity | Foundry resource | Foundry User |

See [Foundry RBAC](https://learn.microsoft.com/azure/foundry/concepts/rbac-foundry),
[deployment permissions](https://learn.microsoft.com/azure/foundry/concepts/rbac-foundry#deployment-type-specific-permissions),
and [tracing setup](https://learn.microsoft.com/azure/foundry/observability/how-to/trace-agent-setup).

## Agenda

| Module | Duration | Learning artifact |
| --- | --- | --- |
| Evaluate | 2h hands-on<br/>1h 20m demo | Sample evaluation criteria |
| Ship | 2h hands-on<br/>1h 20m demo | Sample release checklist |
| Observe and Operate | 2h hands-on<br/>1h 20m demo | Sample runtime signal review |

## Delivery options

- **Hands-on (preferred):** participants execute the lab. Allow one hour for
  presentation and one hour for the lab.
- **Demo (fallback):** the instructor executes the lab. Allow one hour for
  presentation and 20 minutes for the demo.
- **Advanced extension (optional):** two hours hands-on or one hour demo at
  difficulty 400, producing a tested runbook, regression case, and updated gate.

Choose the mode before delivery. Do not provision environments during the
workshop.

## Preparation and delivery

1. Confirm participants, selected modules, and outcomes.
2. Rehearse demonstrations and labs before the session.
3. Capture questions, takeaways, and follow-up learning resources.

## Reference implementation

Labs use [AgentOps Accelerator](https://aka.ms/agentops-accelerator) as a
practical reference implementation alongside native Microsoft Foundry
capabilities.
