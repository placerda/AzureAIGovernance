# Teaching Observe and Operate

[Back to the instructor guide](README.md)

**Participant entry:** [03-observe-operate](../labs/03-observe-operate/lab.md).
It closes the core workshop sequence; [04-advanced](../labs/04-advanced/lab.md)
is an optional extension, not a required fourth module.

## Learning focus

Help participants connect runtime information to a useful response.
**Observe** means understanding what happened. **Operate** means deciding
and carrying out the response, then improving the agent.

## Before the session

Read the [Observe and Operate deck and speaker notes](../decks/observe-operate/agentops-observe-operate-workshop.pptx)
and the [current lab](../labs/03-observe-operate/lab.md).
Use [module preparation](../pre-work/instructor-setup.md#observe-and-operate)
to supply a trace, related alert, dashboard and response notes with working
links and a clear time range.

For standalone delivery, introduce the agent and deployed version in the
prepared example. Participants do not need to have completed Ship.

**Current boundary:** the available activity reviews a saved example without
changing the service. The full hands-on monitoring and incident-response
exercise is still being developed.

## Present and discuss

Use the 60-minute presentation to connect tracing, quality and performance
monitoring, continuous evaluation and operational response. Explain how
runtime findings can become tests for the next version.

For the current guided review:

- Open the supplied trace and explore the failed or slow operation together.
  A trace records the operations that handled one request.
- Compare the alert and dashboard with the example. Discuss what the data
  supports and what still needs investigation.
- Use the response notes to discuss the next action and who is allowed to
  take it. Ask which request would make a useful future test.

For a 20-minute demo, follow one example from trace to response and
improvement. Keep Observe and Operate distinct: finding a problem does not
by itself resolve it.

The planned hands-on lab is 60 minutes. Configuration and live response
steps will be added as the exercise is completed. Do not create failures
or change the service to compensate for missing example files.

## Close the cycle

Keep notes linking the runtime problem to a response, a responsible person
and a test that could catch the same issue. Ask how the team would evaluate
the proposed improvement before releasing it. This returns the discussion
to Evaluate and Ship.
