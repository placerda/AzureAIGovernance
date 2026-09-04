# Observe and Operate workshop lab

## Lab definition

**Objective:** Use Microsoft Foundry observability to interpret runtime
behavior, investigate an alert, select an operational response, and connect
runtime evidence to continuous improvement.

**Duration:** 60 minutes hands-on. A 20-minute instructor demonstration may
cover a selected subset.

**Difficulty:** 300: Advanced

**Expected artifact:** Sample runtime signal review with an associated
operational response and evaluation follow-up.

## Topics covered

- Application Insights access and Microsoft Foundry server-side tracing
- OpenTelemetry traces, spans, model calls, tool calls, retries, and errors
- Trace, conversation, response, session, agent version, and deployment
  correlation
- Agent Monitoring Dashboard
- Run success rate, latency, token usage, estimated cost, and evaluation signals
- Continuous and scheduled evaluation
- Alert investigation and trace correlation
- End-user feedback correlated with a trace
- Operational containment: stop, rollback, guardrail, or escalation
- Telemetry redaction, access, retention, and cost
- Promotion of a representative trace into a versioned regression dataset
- Signal-to-action and evaluation feedback loop

## Outline

1. Connect to the assigned Foundry project and generate agent activity.
2. Inspect the trace and correlate it with the affected agent version.
3. Review dashboard, operational, and recurring evaluation signals.
4. Investigate an alert and any correlated end-user feedback.
5. Identify the likely cause and select an operational response.
6. Review telemetry privacy and access implications.
7. Record the runtime signal review and evaluation follow-up.
8. Select a representative trace for the regression dataset.
