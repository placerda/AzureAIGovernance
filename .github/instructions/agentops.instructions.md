---
applyTo: "agentops/**"
---

# AgentOps development instructions

## Position in the AI Governance VBD

AgentOps VBD is a submodule of the AI Governance VBD. Treat AgentOps as part of
the broader AI Governance workshop, not as a separate workshop or standalone
offering.

AgentOps VBD contains three practice-based submodules:

1. **Evaluate**: the practice of evaluating agent quality, safety, behavior, and
   outcomes before release and on an ongoing basis.
2. **Ship**: the practice of releasing agents through controlled, repeatable,
   and governed delivery processes.
3. **Observe and operate**: the practice of monitoring, troubleshooting, and
   operating agents after deployment.

Each submodule must remain connected to its AgentOps practice. Avoid mixing the
implementation guidance for one practice into another submodule.

## Content architecture

Organize the AgentOps VBD into two complementary content groups:

### Workshop contents

Workshop contents teach the AgentOps concepts and let participants apply them
during the AI Governance workshop. They consist of:

- **Deck**: presents the concepts, decisions, workflow, and expected outcomes.
- **Labs**: provide hands-on activities that reinforce the deck and produce
  practical workshop outcomes.
- **Workshop one-pager**: summarizes the module, its practices, audience,
  prerequisites, agenda, and outcomes.

The deck, labs, and one-pager together represent the workshop experience. Keep
their terminology, sequence, examples, and expected outcomes aligned across all
three AgentOps submodules.

### Delivery guidance

Provide separate delivery guidance for **Evaluate**, **Ship**, and **Observe and
operate**. These guides explain how to implement each practice in a real
environment after or alongside the workshop.

Delivery guidance must:

- translate each practice into a clear implementation workflow;
- describe the decisions, activities, artifacts, and expected outputs;
- connect workshop concepts to concrete Microsoft platform capabilities;
- remain practical and reusable rather than customer-specific;
- distinguish Microsoft Foundry and Microsoft Copilot Studio implementation
  paths where their capabilities differ;
- avoid duplicating the deck or turning the workshop into a detailed product
  runbook.

## Relationship between the materials

Use this hierarchy when creating or reviewing AgentOps content:

```text
AI Governance VBD
└── AgentOps VBD
    ├── Evaluate practice
    │   ├── Workshop content
    │   └── Evaluate delivery guidance
    ├── Ship practice
    │   ├── Workshop content
    │   └── Ship delivery guidance
    └── Observe and operate practice
        ├── Workshop content
        └── Observe and operate delivery guidance
```

Workshop content explains and exercises the practices. Delivery guidance
explains how to implement them. Every AgentOps artifact must clearly support one
of these purposes and fit within this hierarchy.
