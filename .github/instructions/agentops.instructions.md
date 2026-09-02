---
applyTo: "agentops/**"
---

# AgentOps development instructions

## Position in the AI Governance VBD

AgentOps is the discipline of evaluating, releasing, observing, and operating AI
agents through repeatable practices across the agent lifecycle.

AgentOps VBD is part of the AI Governance VBD. It translates the AgentOps
discipline into a delivery package with two complementary components: the
workshop and implementation guidance. Treat it as part of the broader AI
Governance offering, not as a separate workshop or standalone offering.

AgentOps VBD contains four connected practices:

1. **Evaluate**: evaluate agent quality, safety, behavior, and outcomes before
   release and on an ongoing basis.
2. **Ship**: release agents through controlled, repeatable, and governed
   delivery processes.
3. **Observe**: collect and interpret runtime evidence about agent behavior,
   quality, reliability, performance, and usage.
4. **Operate**: respond to issues, maintain the service, manage operational
   change, and improve the agent after deployment.

For content delivery, organize the four practices into three modules:
**Evaluate**, **Ship**, and **Observe and Operate**. Observe and Operate remain
distinct practices, but share one deck, one lab, and one implementation guide
because their workflows are closely connected.

Keep every module connected to its covered practices. Do not merge the concepts
of Observe and Operate or move implementation guidance from one module into
another.

## Platform scope

Microsoft Foundry is the sole implementation path for the current AgentOps VBD
materials.

- Use current Microsoft Foundry evaluation, observability, tracing, deployment,
  and agent lifecycle capabilities.
- Ground product claims in current first-party Microsoft documentation and link
  the relevant sources.
- Treat the AgentOps Accelerator as a Foundry-specific reference
  implementation. Do not present it as the product contract or a replacement
  for native Foundry capabilities.
- Do not introduce alternative agent-building platform paths or position future
  platform support in the current materials.

## Content architecture

Organize the AgentOps VBD into two complementary content groups.

The root `agentops/README.md` is the primary navigation and delivery reference
for Microsoft field teams, workshop facilitators, implementation teams, and VBD
delivery leads. It is not an authoring guide. Keep detailed workshop preparation
and facilitation instructions in the workshop one-pager.

## Writing style

- Do not use em dashes or en dashes for emphasis or as title separators.
- Use a colon, period, or parentheses when separating a title from a qualifier.
- Keep headings descriptive and direct.

### Workshop contents

Workshop contents teach AgentOps concepts and let participants apply them during
the AI Governance workshop. They consist of:

- **One workshop one-pager PDF** for the complete AgentOps VBD. It summarizes
  the four practices, three content modules, audience, prerequisites, agenda,
  outcomes, and the instructions for preparing and delivering the workshop.
- **Three decks**, one for each content module: Evaluate, Ship, and Observe and
  Operate. The combined Observe and Operate deck must preserve the distinction
  between the two practices. Store decks as PowerPoint `.pptx` files.
- **Three labs**, one for each content module. Each lab provides hands-on
  activities that reinforce its corresponding deck and produce practical
  workshop outcomes. Store each lab as a Markdown `.md` file.

The decks, labs, and one-pager together represent the workshop experience. Keep
their terminology, sequence, examples, and expected outcomes aligned across the
three content modules and four AgentOps practices.

### Implementation guidance

Provide three implementation guides, one each for **Evaluate**, **Ship**, and
**Observe and Operate**. The combined guide must explain Observe and Operate as
distinct but connected practices. These guides explain how to implement the
covered practices in a real environment after or alongside the workshop.

Implementation guidance must:

- translate each covered practice into a clear implementation workflow;
- describe the decisions, activities, artifacts, and expected outputs;
- connect workshop concepts to concrete Microsoft Foundry capabilities;
- remain practical, concise, technically grounded, and reusable;
- remain organization-agnostic and reusable across delivery contexts;
- avoid organization-specific secrets, tenant identifiers, and production data;
- avoid duplicating the deck or becoming a detailed product runbook; and
- avoid Statement of Work, commercial-scope, Definition of Use, or unrelated
  delivery-framework language.

## Artifact locations

- Keep AgentOps working files under two root content directories:
  `agentops/workshop/` and `agentops/implementation-guidance/`.
- Maintain all workshop and implementation artifacts in GitHub during the
  current development phase.
- Keep the one-pager, decks, labs, and supporting workshop assets under
  `agentops/workshop/`.
- Keep implementation guides and their supporting assets under
  `agentops/implementation-guidance/`.

## Relationship between the materials

Use this hierarchy when creating or reviewing AgentOps content:

```text
AI Governance VBD
└── AgentOps VBD
    ├── Evaluate module
    │   ├── Evaluate practice
    │   ├── Workshop content
    │   └── Evaluate implementation guidance
    ├── Ship module
    │   ├── Ship practice
    │   ├── Workshop content
    │   └── Ship implementation guidance
    └── Observe and Operate module
        ├── Observe practice
        ├── Operate practice
        ├── Workshop content
        └── Observe and Operate implementation guidance
```

Workshop content explains and exercises the practices. Implementation guidance
explains how to implement them. Every AgentOps artifact must clearly support one
of these purposes and fit within this hierarchy.
