---
applyTo: "agentops/**"
---

# AgentOps development instructions

## Position in the AI Governance VBD

AgentOps VBD is a submodule of the AI Governance VBD. Treat AgentOps as part of
the broader AI Governance workshop, not as a separate workshop or standalone
offering.

AgentOps VBD contains three practice-based submodules:

1. **Evaluate**: evaluate agent quality, safety, behavior, and outcomes before
   release and on an ongoing basis.
2. **Ship**: release agents through controlled, repeatable, and governed
   delivery processes.
3. **Observe and operate**: monitor, troubleshoot, and operate agents after
   deployment.

Keep each submodule connected to its AgentOps practice. Do not mix the
implementation guidance for one practice into another submodule.

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

### Workshop contents

Workshop contents teach AgentOps concepts and let participants apply them during
the AI Governance workshop. They consist of:

- **One workshop one-pager PDF** for the complete AgentOps VBD. It summarizes
  the module, its practices, audience, prerequisites, agenda, outcomes, and the
  instructions for preparing and delivering the workshop.
- **Three decks**, one for each practice: Evaluate, Ship, and Observe and
  operate. Each deck presents the concepts, decisions, workflow, and expected
  outcomes for its practice.
- **Three labs**, one for each practice. Each lab provides hands-on activities
  that reinforce its corresponding deck and produce practical workshop
  outcomes.

The deck, labs, and one-pager together represent the workshop experience. Keep
their terminology, sequence, examples, and expected outcomes aligned across the
three AgentOps practices.

### Implementation guidance

Provide three implementation guides, one each for **Evaluate**, **Ship**, and
**Observe and operate**. These guides explain how to implement each practice in
a real environment after or alongside the workshop.

Implementation guidance must:

- translate each practice into a clear implementation workflow;
- describe the decisions, activities, artifacts, and expected outputs;
- connect workshop concepts to concrete Microsoft Foundry capabilities;
- remain practical, concise, technically grounded, and reusable;
- avoid customer-specific secrets, tenant identifiers, and production data;
- avoid duplicating the deck or becoming a detailed product runbook; and
- avoid Statement of Work, commercial-scope, Definition of Use, or unrelated
  delivery-framework language.

## Artifact locations

- Keep AgentOps working files under two root content directories:
  `agentops/workshop/` and `agentops/implementation-guidance/`.
- Keep labs and their executable supporting assets in GitHub under
  `agentops/workshop/labs/`.
- Store the three workshop decks, workshop one-pager PDF, and published
  implementation guides in the
  [AgentOps SharePoint folder](https://microsoft.sharepoint.com/teams/FY26AIWPLUS/Shared%20Documents/Forms/AllItems.aspx?id=%2Fteams%2FFY26AIWPLUS%2FShared%20Documents%2FSolution%20Accelerator%20%2D%20Azure%20AI%20Governance%2FSolution%20Accelerator%20release%2FSA%20%2D%20Azure%20AI%20Governance%2FModule%203%2E4%20AgentOps).
- Treat SharePoint as the system of record for published workshop and
  implementation artifacts.
- Markdown implementation-guidance drafts under
  `agentops/implementation-guidance/` may be used as working source during
  section-by-section review. Do not treat them as the published deliverables.

## Relationship between the materials

Use this hierarchy when creating or reviewing AgentOps content:

```text
AI Governance VBD
└── AgentOps VBD
    ├── Evaluate practice
    │   ├── Workshop content
    │   └── Evaluate implementation guidance
    ├── Ship practice
    │   ├── Workshop content
    │   └── Ship implementation guidance
    └── Observe and operate practice
        ├── Workshop content
        └── Observe and operate implementation guidance
```

Workshop content explains and exercises the practices. Implementation guidance
explains how to implement them. Every AgentOps artifact must clearly support one
of these purposes and fit within this hierarchy.
