# Ship workshop lab

## Lab definition

**Objective:** Use evaluation evidence to configure and exercise a controlled
release gate for a Microsoft Foundry agent candidate.

**Duration:** 60 minutes hands-on for the selected track. A 20-minute instructor
demonstration may cover a selected subset.

**Difficulty:** 300: Advanced

**Expected artifact:** Sample release readiness checklist supported by pipeline
evidence.

**Delivery tracks:**

- **Track A:** GitHub and GitHub Actions
- **Track B:** Azure Repos and Azure Pipelines

Select one track before the workshop. Both tracks teach the same concepts and
produce the same learning artifact.

## Topics covered

### Common topics

- Versioned release manifest: commit, agent, model, dataset, and criteria
- Pipeline identity, workload identity federation, and least privilege
- Microsoft Foundry cloud evaluation as a release gate
- Baseline and threshold enforcement
- Failed-gate investigation
- Pipeline summary and evidence artifact with provenance
- Auditable approval and exception handling
- Immutable agent version and post-deployment smoke test
- Runtime identity, role-based access control, and guardrail verification
- Rollback to the previous approved version
- AgentOps Accelerator workflow and readiness evidence as a reference
  implementation

### Track A: GitHub Actions

- GitHub repository and Actions workflow
- Environments, variables, status checks, and required reviewers
- Azure authentication with workload identity federation
- Workflow summary and retained artifacts

### Track B: Azure Pipelines

- Azure Repos and Azure Pipelines YAML
- Azure Resource Manager service connection with workload identity federation
- Pipeline variables, environments, approvals, and checks
- Pipeline summary and retained artifacts

## Outline

1. Select the GitHub Actions or Azure Pipelines track.
2. Review the release candidate, manifest, and available evaluation evidence.
3. Validate pipeline identity, variables, environment, and release gate.
4. Run a candidate that fails the evaluation gate.
5. Inspect the failure, pipeline summary, and evidence artifact.
6. Run the accepted candidate and complete the approval.
7. Verify the deployed version, runtime access, and smoke test.
8. Record the rollback criterion and complete the release readiness checklist.
