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
and the [lab](../labs/03-observe-operate/lab.md). The technical preparation is
in [module preparation](../pre-work/technical-setup.md#observe-and-operate).

When you finish, you should have:

- Traces from your own agent visible in Foundry and Application Insights.
- A decision on who creates the alert in lab step 6: each participant, with
  Monitoring Contributor, or you, on screen.
- The invitation sent, with the **Observe settings** you tested.

Participants who did Ship observe their own released agent. Participants who
skipped it observe the baseline agent named in the invitation.

## Present the module

Allow 60 minutes for the presentation. Connect tracing, quality and performance
monitoring, continuous evaluation and operational response. Explain how
runtime findings become tests for the next version.

## Hands-on lab (60 minutes)

- Steps 1 and 2: participants send the complaint's requests and read their
  traces. Ask them to find the tool call that never happened.
- Steps 3 to 5: they measure the problem with a query and run the health check.
  Discuss what the data supports and what still needs investigation.
- Steps 6 and 7: they set the alert and decide the response: who owns it, what
  action is allowed and which request becomes a test.

Keep Observe and Operate distinct: finding a problem does not by itself
resolve it. Participants do not change the agent in this lab.

## Instructor demo (20 minutes)

Send one request to your agent, open its trace, run the query and show the
alert rule. Finish with the response notes: owner, allowed action and the test
to add.

## Close the cycle

Participants keep their query, alert and response notes. Ask how the team would
evaluate the proposed improvement before releasing it. This returns the
discussion to Evaluate and Ship, and leads into the optional Advanced lab.