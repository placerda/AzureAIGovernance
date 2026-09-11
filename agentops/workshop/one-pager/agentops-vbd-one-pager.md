---
title: "AgentOps Value Based Delivery Workshop"
subtitle: "Evaluate, Ship, Observe, and Operate Microsoft Foundry agents"
duration: "6h hands-on; 4h demo"
structure: "Three modules"
difficulty: "300: Advanced"
delivery: "Remote or onsite"
---

# Workshop

## Description

Learn how to apply AgentOps to your Microsoft Foundry projects, from evaluating
an agent to releasing, monitoring, and improving it. Part of the AI Governance
Value Based Delivery, this workshop combines practical examples, discussion,
and guided activities.

## Audience

Developers, architects, platform engineers, and governance teams working with
AI agents. Familiarity with Azure and agent development is recommended.

## Outcomes

- Apply AgentOps practices to your own project.
- Choose evaluation metrics and acceptance criteria.
- Configure tracing to capture agent behavior.
- Evaluate agent responses and actions.
- Automate evaluation and deployment.
- Monitor agent quality and performance.
- Set up continuous evaluation.
- Respond to failures and improve the agent.

## Methodology

- **Learn:** practical presentations and discussion.
- **Apply:** guided labs or demos in Microsoft Foundry.
- **Reinforce:** review results and connect the four practices.

## Scope

- **Evaluate:** compare two versions of a help desk agent using scores,
  responses, and tool actions. Discuss a simple scoring rubric and prepared
  red-teaming results.
- **Ship:** follow evaluation, release approval, deployment, and
  post-deployment checks through one pipeline example. See why a release
  is blocked or allowed.
- **Observe and Operate:** follow a notification to a trace, investigate the
  issue, and decide who should act. Connect monitoring and continuous
  evaluation to agent improvement.

Observe and Operate are distinct practices taught together.

## Prerequisites

- **Hands-on:** a computer with the tools and access described in
  [participant pre-work](https://github.com/placerda/AzureAIGovernance/blob/main/agentops/workshop/pre-work/README.md).
- **Demo:** no participant Azure access is needed.

The learning environment and participant setup are prepared before the session.

## Agenda

| Module | Duration | Learning artifact |
| --- | --- | --- |
| Evaluate | 2h hands-on<br/>1h 20m demo | Sample evaluation criteria |
| Ship | 2h hands-on<br/>1h 20m demo | Sample release checklist |
| Observe<br/>and Operate | 2h hands-on<br/>1h 20m demo | Sample runtime<br/>signal review |

## Format

- **Hands-on:** 60m presentation and 60m lab per module.
- **Demo:** 60m presentation and 20m instructor demonstration per module.

Take all three modules or select those relevant to your team.
Modules and format are agreed before the workshop.

## Workshop materials

- Presentation materials for the selected modules.
- Guided lab instructions and sample scenarios.
- Examples of evaluation criteria, release checks, and operational findings.

The workshop uses sample scenarios, not your production environment.
Separate implementation guidance helps your team apply these practices
to its own projects.

## Optional advanced module

**Additional 2h hands-on (level 400).** Explore one behavior requirement,
one failure, and one control.

- Use ASSERT for requirement-based evaluations.
- Apply an Agent Control Specification (ACS) runtime control and compare
  results, including legitimate requests that should still succeed.
- Add a regression test to stop the same failure from reaching the next release.

A prepared agent, test cases, and pipeline keep the focus on evaluating
behavior and applying controls.
