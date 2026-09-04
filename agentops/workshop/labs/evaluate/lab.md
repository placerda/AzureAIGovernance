# Evaluate workshop lab

## Lab definition

**Objective:** Use Microsoft Foundry and AgentOps Accelerator to define
evaluation criteria, execute a cloud evaluation, interpret evidence, and assess
release readiness.

**Duration:** 60 minutes hands-on. A 20-minute instructor demonstration may
cover a selected subset.

**Difficulty:** 300: Advanced

**Expected artifact:** Sample evaluation criteria with reviewed evaluation
results.

## Topics covered

- Versioned evaluation candidate: agent, model, dataset, and evaluators
- [Microsoft Foundry cloud evaluation](https://learn.microsoft.com/azure/foundry/observability/how-to/cloud-evaluation)
  with the Evaluation SDK
- Evaluation dataset schema and field mapping
- Turn-level and
  [conversation-level evaluation](https://learn.microsoft.com/azure/foundry/observability/how-to/cloud-evaluation-conversations)
- System outcomes and process behavior, including tool use
- [Agent evaluators](https://learn.microsoft.com/azure/foundry/concepts/evaluation-evaluators/agent-evaluators)
- [Rubric evaluators](https://learn.microsoft.com/azure/foundry/concepts/evaluation-evaluators/rubric-evaluators)
  and human calibration
- Quality and safety evaluation
- Pass, fail, execution error, and row-level evidence
- Baselines, thresholds, and release decisions
- Review of previously generated
  [AI red teaming](https://learn.microsoft.com/azure/foundry/how-to/develop/run-ai-red-teaming-cloud)
  evidence
- AgentOps Accelerator evaluation report as a reference implementation

## Outline

1. Open the lab repository and initialize the AgentOps workspace.
2. Review the versioned candidate and evaluation dataset.
3. Configure one rubric, one agent evaluator, and one safety evaluator.
4. Run the cloud evaluation and inspect aggregate and row-level results.
5. Distinguish failed criteria from execution errors.
6. Compare results with the baseline and review red teaming evidence.
7. Record the sample evaluation criteria and release decision.
