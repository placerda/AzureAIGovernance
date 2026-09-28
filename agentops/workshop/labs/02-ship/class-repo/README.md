# Ship class repository seed

This folder is the starting point of the repository in which participants build
their release pipeline during [Ship](../lab.md). The instructor assembles it
once, as described in
[technical setup](../../../pre-work/technical-setup.md#ship), and pushes it to
the class GitHub repository or Azure Repos repository. Participants never edit
this seed directly.

## Contents after assembly

| Path | Purpose |
| --- | --- |
| `azure.yaml` | Tells azd which agent code to deploy. It defines two agents per participant: `helpdesk-ALIAS-test` is evaluated first, `helpdesk-ALIAS` is the released agent. |
| `src/helpdesk/` | The [help desk agent](../../shared/helpdesk-agent/README.md) code, copied by the instructor. `.agentignore` keeps local files out of uploads. |
| `agentops.yaml` | The Evaluate settings. The pipeline replaces the version `1` with the version it just deployed. |
| `turns.jsonl` | The eight Evaluate test requests, copied by the instructor. |
| `scripts/deploy-agent.sh` | Deploys one agent to the existing class Foundry project and prints its new version number. Creates no Azure resources. |
| `scripts/smoke-test.sh` | Sends a VPN request to a deployed agent and fails unless the ticket goes to Network Support. |
| `scripts/agent-version.sh` | Prints the version number azd just deployed for one agent. Used by the other two scripts. |

Participants replace `ALIAS` with their alias on their own branch. The
instructor replaces `FOUNDRY_ENDPOINT` in `agentops.yaml` once, during assembly.
The pipeline itself is not part of the seed: each participant generates it with
the AgentOps Accelerator CLI and adapts it during the lab.
