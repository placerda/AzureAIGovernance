---
title: "AgentOps Value Based Delivery Workshop"
subtitle: "Evaluate, Ship, Observe, and Operate Microsoft Foundry agents"
duration: "6 hours with prerequisites met"
structure: "3 modules, 2 hours each"
difficulty: "300: Advanced"
delivery: "Remote or onsite"
---

# Workshop

## Description

AgentOps is the discipline of evaluating, releasing, observing, and operating AI
agents through repeatable practices. This workshop applies those practices to
Microsoft Foundry agents across the agent lifecycle.

## Objectives

- Understand the four AgentOps practices: Evaluate, Ship, Observe, and Operate.
- Identify lifecycle evidence and controls.
- Apply the practices through Microsoft Foundry demonstrations and labs.

## Outcomes

- Shared AgentOps terminology and lifecycle understanding.
- Evaluation criteria and release readiness controls.
- Observability and operations priorities.
- Documented gaps, decisions, and next actions.

## Methodology

- **Learn:** presentations, demos, and discussion.
- **Apply:** guided labs using Microsoft Foundry.
- **Act:** documented outputs for the implementation guidance.

## Scope

- **Evaluate:** define criteria and interpret evaluation evidence.
- **Ship:** establish versioning, release gates, and readiness.
- **Observe:** interpret runtime traces, metrics, logs, and usage.
- **Operate:** respond, maintain, manage change, and improve.

> Observe and Operate are distinct practices delivered together in one content
> module because their workflows and evidence are closely connected.

## Audience

Teams responsible for governing, building, releasing, and operating AI agents.

## Prerequisites

- An Azure subscription with sufficient model quota in a supported region.
- Permissions to create Microsoft Foundry resources and projects and deploy the
  required models.

## Pre-workshop provisioning

> Module timing assumes a ready environment. Provisioning and troubleshooting
> are outside workshop time.

- Create and test the Foundry project, model deployment, and lab agent.
- Grant participants access and validate evaluation and tracing permissions.
- Validate lab data, tools, connections, telemetry, and agent responses.

See [Foundry environment setup](https://learn.microsoft.com/azure/foundry/agents/environment-setup)
and [agent tracing](https://learn.microsoft.com/azure/foundry/observability/concepts/trace-agent-concept).

## Agenda

| Module | Duration | Practical output |
| --- | --- | --- |
| Evaluate | 2 hours | Evaluation requirements |
| Ship | 2 hours | Release controls |
| Observe and Operate | 2 hours | Operational priorities |

## Delivery options

Deliver all three modules in one day or schedule them separately across multiple
days. Preserve one hour for presentation and one hour for the lab per module.

## Preparation and delivery

1. Confirm participants, selected modules, and outcomes.
2. Rehearse demonstrations and labs before the session.
3. Capture decisions, gaps, owners, and next actions.

## Reference implementation

[AgentOps Accelerator](https://aka.ms/agentops-accelerator) is an open-source
jumpstart used alongside native Microsoft Foundry capabilities.
