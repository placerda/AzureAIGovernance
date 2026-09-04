# Advanced AgentOps workshop lab

## Lab definition

**Objective:** Execute a closed-loop assurance scenario from operational alert
through runbook execution, regression evaluation, and release-gate update.

**Duration:** 120 minutes hands-on. A 60-minute instructor demonstration may
cover a selected subset.

**Difficulty:** 400: Expert

**Expected artifact:** Tested incident runbook, versioned regression case, and
updated evaluation gate.

## Topics covered

- Alert rules and severity criteria
- Incident ownership, escalation, and communication
- Runbook structure: triage, containment, recovery, and closure
- Controlled runtime failure and evidence collection
- Trace and version correlation
- Guardrail, stop, rollback, and other containment options
- AI red teaming findings as operational evidence
- End-user feedback and incident evidence
- Trace-to-dataset workflow
- Versioned regression dataset and evaluator update
- Release-gate update and verification
- Post-incident learning and evidence retention

## Outline

1. Review the alert, severity model, and incident runbook.
2. Trigger a controlled runtime failure.
3. Correlate the alert with its trace, version, and deployment.
4. Execute triage, containment, escalation, and recovery steps.
5. Capture evidence and close the simulated incident.
6. Convert the representative trace into a versioned regression case.
7. Update the evaluation criteria and release gate.
8. Run the evaluation and verify that the regression is blocked.
9. Record the runbook test results and post-incident learning.
