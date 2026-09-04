# AgentOps contributor guidance

## Scope

These instructions apply to all files under `agentops/`.

This file is the canonical source of contribution instructions for AgentOps
content. Tool-specific instruction files should reference this file instead of
duplicating its rules.

## AgentOps Value Based Delivery

AgentOps is the discipline of evaluating, releasing, observing, and operating AI
agents through repeatable activities across the agent lifecycle.

AgentOps Value Based Delivery is part of the AI Governance Value Based Delivery.
It has two complementary components:

- **Workshop:** teaches AgentOps concepts and provides guided practice.
- **Implementation guidance:** explains how teams can establish AgentOps in an
  organization.

AgentOps covers Evaluate, Ship, Observe, and Operate. For content delivery,
organize them into three modules:

1. Evaluate
2. Ship
3. Observe and Operate

Observe and Operate remain distinct even though they share one deck, lab, and
implementation guide.

## Platform scope

Microsoft Foundry is the implementation platform for the current AgentOps VBD
materials.

- Use current Microsoft Foundry terminology and capabilities.
- Ground product claims in current first-party Microsoft documentation.
- Use descriptive links that identify their destination.
- Present AgentOps Accelerator as a practical reference implementation alongside
  native Microsoft Foundry capabilities.
- Do not present AgentOps Accelerator as the Microsoft Foundry product contract
  or as a replacement for native capabilities.
- Do not introduce alternative agent-building platforms or future platform
  plans.

## Content architecture

### Workshop

Workshop content consists of:

- one workshop one-pager;
- three decks; and
- three GitHub-based labs.

Maintain one deck and one lab for each content module.

Workshop content must:

- focus on learning and guided practice;
- keep terminology and examples aligned across the one-pager, decks, and labs;
- name the learning artifact produced by each module; and
- avoid becoming an implementation plan or detailed product runbook.

The workshop supports two delivery modes:

- **Hands-on:** 60 minutes of presentation followed by a 60-minute participant
  lab.
- **Demo:** 60 minutes of presentation followed by a 20-minute instructor
  demonstration.

Select the delivery mode before the session. Provisioning and troubleshooting
are not part of workshop time.

### Modular delivery

Each deck contains the shared AgentOps foundation slides so the module can be
delivered independently. This repetition is intentional.

Instructor notes must explain that:

- the foundation section supports standalone module delivery;
- facilitators may use it as a recap when delivering multiple modules; and
- familiar foundation slides may be skipped according to participant needs.

### Implementation guidance

Provide one implementation guide for each content module:

- Evaluate
- Ship
- Observe and Operate

Implementation guidance must:

- translate the covered content into a clear implementation workflow;
- describe decisions, activities, evidence, and expected outputs;
- connect the content to Microsoft Foundry capabilities;
- remain concise, practical, technically grounded, and reusable;
- remain organization-agnostic;
- avoid becoming a Statement of Work, commercial scope, or product runbook; and
- avoid duplicating workshop content.

## Artifact locations

Store files under:

```text
agentops/
├── workshop/
│   ├── one-pager/
│   ├── decks/
│   └── labs/
└── implementation-guidance/
```

Additional rules:

- Keep labs in Markdown.
- Keep decks in PowerPoint.
- Keep the one-pager Markdown source beside its generated PDF.
- Keep supporting assets with their corresponding content group.
- Update `agentops/README.md` whenever an artifact is added, renamed, moved, or
  removed.
- Ensure every link in `agentops/README.md` resolves to the intended artifact.

## Deck standards

Decks must:

- use instructor notes for timing, delivery mode, modular delivery, and lab
  transitions;
- identify whether an activity is a participant lab, instructor demo, or
  optional deep dive;
- use substantial filled card headers with white title text and lightly tinted
  card bodies;
- avoid thin colored bars above otherwise empty cards;
- use descriptive hyperlink labels rather than generic labels;
- expand uncommon acronyms on first use; and
- avoid text overflow, awkward wrapping, low contrast, and inconsistent spacing.

## Writing standards

- Keep content practical, concise, clear, and professional.
- Keep headings descriptive and direct.
- Use organization-neutral language.
- Do not include secrets, tenant identifiers, or production data.
- Do not use em dashes or en dashes as title or emphasis separators.
- Use a colon, period, or parentheses instead.
- Keep terminology consistent across all AgentOps artifacts.

## Validation

Before completing a change:

1. Confirm alignment between the one-pager, deck, lab, and implementation guide.
2. Verify the four-part and three-module structure.
3. Verify all documentation and artifact links.
4. Check for obsolete, inconsistent, or organization-specific terminology.
5. Open every modified PowerPoint file successfully.
6. Render every modified slide and inspect it visually.
7. Check for clipping, overlap, poor contrast, awkward wrapping, and
   inconsistent card styles.
8. Confirm that the README still links to every artifact.
9. Remove temporary Office lock files and generated QA artifacts.
