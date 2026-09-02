# AgentOps Shipping Guide

## Purpose and intended audience

This guide helps Microsoft field teams establish a controlled, repeatable release
path for AI agents. It is intended for architects, agent engineers, Copilot
Studio makers, platform engineers, release managers, security teams, testers,
operations teams, and delivery leads working with:

- Microsoft Foundry agents
- Microsoft Copilot Studio agents

Use it to discover the release topology and controls, select supported platform
and automation tools, prepare source and environments, execute release gates and
promotion, operationalize releases, and transfer ownership.

This is practical execution guidance. It is not a Statement of Work, a
commercial scope, a Definition of Use, or a step-by-step product runbook.

## Supported platforms and boundaries

| Area | Microsoft Foundry | Microsoft Copilot Studio |
| --- | --- | --- |
| Release unit | Identified agent source/configuration, infrastructure definition, agent version, model/tool dependencies, and evaluation evidence | Power Platform solution containing the agent and dependent components, plus environment-specific configuration and post-deployment settings |
| Environment model | Separate Foundry projects/resources or governed environments for development, test, and production | Power Platform development, test, and production environments with Dataverse and solution-based ALM |
| Deployment automation | Azure Developer CLI, GitHub Actions, Azure Pipelines, or customer-standard Azure deployment tooling as supported by the agent type | Power Platform pipelines, Power Platform Build Tools for Azure DevOps, GitHub Actions for Power Platform, or controlled solution import/export |
| Quality gate | Foundry evaluation and smoke checks; optional repo-side release evidence | Copilot Studio test sets, solution checks, connector/configuration validation, and customer approval |
| AgentOps Accelerator | Foundry-specific reference for repository-side evaluation gates, readiness checks, and release evidence | Not a Copilot Studio ALM implementation; use Copilot Studio and Power Platform release mechanisms |

Do not force the same artifact or deployment mechanism across platforms. A
Foundry agent version is not a Copilot Studio solution version, and an AgentOps
Accelerator evidence pack is not a replacement for Power Platform solution and
pipeline records.

## Engagement outcomes

By the end of the workstream, the customer should have:

1. An approved release topology and environment promotion path.
2. A defined release unit, version identity, and source-of-truth strategy.
3. Customer-owned automation identities, permissions, and secrets management.
4. A pipeline or controlled release procedure with explicit quality, safety,
   security, and approval gates.
5. Evidence that the evaluated candidate is the candidate promoted.
6. A rollback, hotfix, and post-release verification approach.
7. Release operations ownership, documentation, and knowledge transfer.

## Delivery outline

| Phase | Delivery question | Expected evidence |
| --- | --- | --- |
| 1. Discover topology and controls | What is released, through which environments, under which controls? | Release topology, control matrix, release-unit definition |
| 2. Select tools and platform path | Which supported tools fit the agent type, customer engineering model, and governance needs? | Tooling decision record, architecture, prerequisites |
| 3. Prepare source, versioning, and environments | Can the candidate and its dependencies be reproduced and promoted safely? | Source baseline, version contract, environment readiness report |
| 4. Execute pipeline and gates | Did the identified candidate pass required checks and reach the intended target? | Pipeline record, gate evidence, approval, deployment verification |
| 5. Operationalize releases | Can the customer detect, reverse, and learn from release outcomes? | Runbook outline, rollback test, release metrics and ownership |
| 6. End the project and transfer knowledge | Can customer teams operate the release path independently? | Handoff pack, rehearsal, owner acceptance |

## Phase 1 - Discover release topology and controls

### Objective

Define the release system before selecting pipeline tools. Make the release unit,
environments, evidence, approvals, and failure behavior explicit.

### Discovery questions

#### Release unit and dependencies

- Is the target a Foundry prompt agent, Foundry hosted agent, Copilot Studio
  conversational agent, event-triggered agent, or a combination?
- Which artifacts can change independently: instructions, code, topics,
  knowledge, tools, actions, connectors, child agents, models, policies, or
  infrastructure?
- Where is the source of truth for each artifact?
- Which dependencies are versioned, externally managed, or configured after
  deployment?
- How will a release identify the exact agent configuration and commit or
  solution version that was evaluated?

#### Environments and promotion

- Which development, integration, test, preproduction, and production
  environments exist?
- Are environments isolated by subscription, resource group, Foundry project,
  Power Platform environment, tenant, region, or network?
- Is promotion immutable, rebuilt from source, or manually reconfigured?
- Which knowledge sources, connections, endpoints, environment variables, and
  policies differ by environment?
- Which channels or user rings receive a release first?

#### Controls and decisions

- Which tests, evaluations, safety checks, static checks, and smoke tests block
  promotion?
- Which controls require human approval or separation of duties?
- Who can deploy, approve, roll back, or accept an exception?
- What evidence is required for audit, change management, and incident response?
- What must happen when a metric is missing, an evaluation fails to complete, or
  a dependency is unavailable?
- What are the rollback time objective and maximum acceptable release impact?

### Activities

1. Map source change through build, evaluation, approval, deployment,
   verification, and rollback.
2. Define the release unit and immutable identity carried through every stage.
3. Identify all environment-specific values and post-deployment actions.
4. Create a control matrix with required evidence, gate behavior, owner, and
   exception authority.
5. Identify compliance, network, data residency, identity, and change-management
   constraints.
6. Define the minimum viable release path before adding advanced rings,
   schedules, or orchestration.

### Expected outputs and evidence

- Release topology diagram
- Release-unit and version identity definition
- Environment and dependency inventory
- Promotion and approval model
- Release control matrix
- Failure, exception, rollback, and hotfix principles

## Phase 2 - Select tools and the platform path

### Objective

Select supported release mechanisms that align with the target platform,
customer skills, source-control system, and governance model.

### Cross-platform selection criteria

- Agent type and supported deployment mechanism
- Customer source-control and pipeline standards
- Required environment isolation and approval workflows
- Identity model and secretless authentication options
- Infrastructure-as-code requirements
- Evaluation and safety integration
- Audit evidence and retention
- Rollback and deployment-ring support
- Preview feature tolerance and operational support model

### Microsoft Foundry implementation path

1. Use the deployment and versioning mechanism supported by the agent type.
   Hosted-agent projects can use Azure Developer CLI and generated CI/CD
   integration; other Foundry agent types may use portal, SDK, or customer
   automation patterns documented for that type.
2. Use federated workload identity or another customer-approved secretless
   pattern for pipelines. Grant least privilege at the correct Foundry and Azure
   scopes.
3. Store environment configuration outside source when it contains secrets.
   Keep non-secret deployment configuration versioned and reviewable.
4. Integrate evaluation after the candidate is available and before promotion.
5. Optionally use the
   [AgentOps Accelerator](https://aka.ms/agentops-accelerator) as a
   **Foundry-specific** reference for repository-side gates and evidence. Confirm
   that its branch and environment assumptions fit the customer rather than
   adopting them unchanged.

### Microsoft Copilot Studio implementation path

1. Use custom Power Platform solutions as the carrier for agents and dependent
   solution-aware components.
2. Establish development, test, and production Power Platform environments with
   Dataverse and appropriate security groups.
3. Choose among Power Platform pipelines, Power Platform Build Tools for Azure
   DevOps, GitHub Actions for Power Platform, or controlled solution operations.
4. Use environment variables and connection references for values that change
   across environments.
5. Track Copilot Studio settings that are not solution-aware and require
   downstream configuration, including items identified by current Microsoft
   ALM guidance such as Application Insights, authentication, channel security,
   deployed channels, and sharing.
6. Use Copilot Studio test sets and, where needed, the Power Platform API for
   automated release validation.

### Expected outputs and evidence

- Tooling decision record
- Platform-specific release architecture
- Pipeline identity and permission model
- Source control and artifact retention decision
- Preview, licensing, region, and support constraints

## Phase 3 - Prepare source, versioning, and environments

### Objective

Make releases reproducible and ensure target environments are ready before the
first pipeline execution.

### Source and version preparation

1. Inventory all source-controlled and externally managed agent components.
2. Define the canonical version identity:
   - repository commit and agent version for Foundry;
   - solution unique name, publisher, semantic version, source commit, and
     exported artifact identity for Copilot Studio.
3. Protect main and release branches according to customer policy.
4. Require review for instructions, prompts, tools, knowledge configuration,
   safety controls, and infrastructure changes.
5. Keep evaluation data, gate configuration, and release evidence versioned or
   linked to an immutable storage record.
6. Define dependency pinning and provenance for packages, images, models, custom
   connectors, and external APIs where supported.

### Environment preparation

1. Verify development, test, and production ownership and access boundaries.
2. Configure customer-managed pipeline identities and least-privilege roles.
3. Configure approved secret and certificate storage.
4. Establish environment-specific configuration and connection mappings.
5. Validate network paths, private access, DNS, firewalls, and service
   availability from the pipeline runner.
6. Seed representative nonproduction knowledge and test identities without
   copying unapproved production data.
7. Configure telemetry before production so deployment verification has signal.
8. Confirm quotas, capacity, licenses, connectors, policies, and regional
   support.

### Platform-specific readiness

| Microsoft Foundry | Microsoft Copilot Studio |
| --- | --- |
| Project and agent type identified; deployment context resolved; model/tool connections available; evaluation target and trace destination configured; Azure and Foundry roles verified | Custom solution and publisher established; dependencies included; solution version set; target environments and Dataverse ready; environment variables and connection references mapped; non-solution-aware settings checklist created |

### Expected outputs and evidence

- Repository and artifact baseline
- Version and traceability contract
- Environment readiness checklist
- Identity and role-assignment record
- Configuration and dependency manifest
- Rollback candidate or prior known-good version identified

## Phase 4 - Execute the pipeline and release gates

### Objective

Prove that the identified candidate meets release controls and is the same
candidate promoted to the target environment.

### Recommended gate sequence

1. **Source and policy validation**
   - required review and branch policy;
   - artifact integrity and dependency checks;
   - configuration and secret scanning;
   - solution or infrastructure validation.
2. **Build or package**
   - create an immutable candidate;
   - record source, dependency, and configuration identity.
3. **Deploy or stage in a controlled environment**
   - deploy to the intended nonproduction target;
   - capture deployment logs and target identity.
4. **Functional and integration checks**
   - invoke critical paths;
   - validate tools, connectors, permissions, knowledge, and channels.
5. **Evaluation and safety gates**
   - run the approved smoke and regression sets;
   - execute required safety and Responsible AI checks;
   - fail closed when required evidence is missing.
6. **Approval**
   - present evidence and known exceptions to the authorized approver;
   - record the decision and any expiry-bound waiver.
7. **Production promotion**
   - promote the approved artifact or rebuild reproducibly from the approved
     source;
   - prevent unreviewed manual customization.
8. **Post-deployment verification**
   - verify agent identity/version, critical journeys, telemetry, access,
     channel availability, and rollback readiness.

### Microsoft Foundry considerations

- Hosted-agent CI/CD can use Azure Developer CLI with GitHub Actions or Azure
  DevOps as documented by Microsoft.
- Keep separate environment values and roles for each Foundry target.
- Tie evaluation records and traces to the deployed agent version and source
  commit.
- Preserve prior versions or a redeployable known-good artifact according to the
  supported agent lifecycle.
- If the AgentOps Accelerator is used, its gate and evidence output supplements
  the Foundry and pipeline records; it does not replace customer approval,
  compliance, or platform deployment evidence.

### Microsoft Copilot Studio considerations

- Export or build the solution from development and deploy managed solutions to
  downstream environments unless the customer has an approved alternative.
- Run solution checks and validate dependencies before import.
- Apply environment-variable and connection-reference values in the target.
- Complete and evidence the non-solution-aware post-deployment steps.
- Publish the agent and validate intended channels, sharing, authentication, and
  connector access.
- Run the approved Copilot Studio evaluation set and smoke tests against the
  target configuration.

### Expected outputs and evidence

- Successful pipeline or controlled release record
- Immutable candidate and target version identities
- Gate results and evaluation evidence
- Approval and exception record
- Deployment and post-deployment verification evidence
- Rollback point and decision log

## Phase 5 - Operationalize release management after execution

### Objective

Make release outcomes visible, reversible, and continuously improvable.

### Activities

1. Define release health indicators and observation windows for errors, latency,
   task outcomes, quality, safety, adoption, and dependency health.
2. Establish a release calendar, freeze rules, maintenance windows, and
   emergency-change process.
3. Document rollback and roll-forward triggers, authority, communications, and
   evidence requirements.
4. Exercise rollback or redeployment of a known-good version in a nonproduction
   environment.
5. Record release metadata in the customer's change and incident systems.
6. Correlate production incidents and regressions with the release identity.
7. Feed reviewed production failures into evaluation and future release gates.
8. Review identity, permissions, secrets, certificates, dependencies, and
   platform deprecations on a defined cadence.

### Expected outputs and evidence

- Release operations outline
- Post-release monitoring and decision window
- Tested rollback or recovery procedure
- Hotfix and exception workflow
- Release metrics and review cadence
- Production-to-evaluation feedback process

## Phase 6 - Project ending and knowledge transfer

### Objective

Ensure customer teams can operate, troubleshoot, and evolve the release path.

### Knowledge transfer activities

1. Walk through the topology, release unit, version identity, and control matrix.
2. Demonstrate one release from approved source to post-deployment verification.
3. Run a failure rehearsal, including a blocked gate and rollback decision.
4. Have customer operators perform a nonproduction release using customer-owned
   identities.
5. Review platform-specific maintenance:
   - Foundry agent, deployment, evaluation, and tracing lifecycle;
   - Copilot Studio solution versioning, dependencies, pipelines, and
     non-solution-aware settings.
6. Transfer pipeline, environment, and evidence access to customer-managed
   groups.
7. Record owners, escalation paths, support boundaries, and the next control
   review.

## Roles and responsibilities

| Role | Primary responsibilities |
| --- | --- |
| Customer product owner | Approves release outcomes, user impact, and business acceptance |
| Agent engineer or Copilot Studio maker | Maintains agent artifacts, dependencies, tests, and release fixes |
| Platform engineer or administrator | Owns Foundry/Azure or Power Platform environments, identities, policies, and capacity |
| Release manager | Owns promotion workflow, approvals, change records, schedules, and exceptions |
| Evaluation and Responsible AI leads | Define and review quality, safety, and regression gates |
| Security and compliance | Approve identity, secrets, supply-chain, data, audit, and policy controls |
| Operations or service owner | Owns post-release verification, incidents, rollback, and release health |
| Microsoft field delivery team | Facilitates design, demonstrates supported implementation paths, and transfers knowledge |

The customer retains authority for production approval, policy exceptions, and
risk acceptance.

## Completion criteria

The Ship workstream is complete when:

- The release unit, source of truth, version identity, and environment path are
  documented.
- The Foundry and Copilot Studio boundaries are explicit and the selected path
  uses supported platform mechanisms.
- Customer-owned identities and least-privilege permissions are in place.
- Environment configuration and dependencies are reproducible or have explicit,
  controlled post-deployment steps.
- Required quality, safety, security, functional, and approval gates are
  implemented and evidenced.
- The approved candidate can be traced to the production deployment.
- Post-deployment checks and rollback have been exercised.
- Customer teams have completed a release rehearsal and accepted ownership.

## Knowledge transfer and handoff checklist

- [ ] Release topology and control matrix transferred
- [ ] Release-unit and version identity rules documented
- [ ] Repository, artifact, and environment ownership transferred
- [ ] Pipeline identities and permissions are customer-managed
- [ ] Environment variables, connection references, and secrets documented
- [ ] Quality, safety, security, and approval gates explained
- [ ] Foundry-specific and Copilot Studio-specific paths clearly separated
- [ ] Copilot Studio non-solution-aware settings checklist transferred
- [ ] Post-deployment verification and observation window rehearsed
- [ ] Rollback, hotfix, and exception procedures rehearsed
- [ ] Release evidence location and retention documented
- [ ] Open risks, waivers, and backlog accepted by named owners

## References

### AgentOps references

- [AgentOps Accelerator](https://aka.ms/agentops-accelerator) - Foundry-specific
  reference implementation
- [AgentOps Accelerator: Ship](https://azure.github.io/agentops/ship/)
- [AgentOps Accelerator: Operate](https://azure.github.io/agentops/operate/)
- [AgentOps Workshop](https://aka.ms/agentops-workshop) - Foundry-based workshop
  that demonstrates the complete operating loop

### Microsoft Foundry

- [Set up CI/CD for hosted agents with Azure Developer CLI](https://learn.microsoft.com/azure/foundry/agents/how-to/set-up-ci-cd-cli)
- [Deploy a hosted agent](https://learn.microsoft.com/azure/foundry/agents/how-to/deploy-hosted-agent)
- [Foundry agent development lifecycle](https://learn.microsoft.com/azure/foundry/agents/concepts/development-lifecycle)
- [Run cloud evaluations with the Microsoft Foundry SDK](https://learn.microsoft.com/azure/foundry/how-to/develop/cloud-evaluation)
- [Set up tracing in Microsoft Foundry](https://learn.microsoft.com/azure/foundry/observability/how-to/trace-agent-setup)

### Microsoft Copilot Studio and Power Platform

- [Establish a Copilot Studio ALM strategy](https://learn.microsoft.com/microsoft-copilot-studio/guidance/alm)
- [Create and manage solutions in Copilot Studio](https://learn.microsoft.com/microsoft-copilot-studio/authoring-solutions-overview)
- [Power Platform ALM overview](https://learn.microsoft.com/power-platform/alm/overview-alm)
- [Set up pipelines in Power Platform](https://learn.microsoft.com/power-platform/alm/set-up-pipelines)
- [Power Platform Build Tools for Azure DevOps](https://learn.microsoft.com/power-platform/alm/devops-build-tools)
- [GitHub Actions for Power Platform](https://learn.microsoft.com/power-platform/alm/devops-github-actions)
- [Automate Copilot Studio evaluations with Power Platform API](https://learn.microsoft.com/microsoft-copilot-studio/analytics-agent-evaluation-rest-api)
