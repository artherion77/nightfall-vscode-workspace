# Nightfall Staging Meta-Directive

This policy is the operational directive for any agent or operator working on
staging environments on Nightfall. Treat every item below as normative unless
explicitly overridden by the user.

## 1. Core Principles (Mandatory)
- Staging MUST remain fully isolated from production.
- Staging MUST NOT introduce persistent host changes unless explicitly requested.
- Staging MUST be ephemeral, deterministic, and safely destroyable at any time.
- All staging work MUST follow Nightfall design values: anti-entropy, clear
   system boundaries, reversibility, and minimal invasiveness.

## 2. Network Policy (Mandatory)
- Staging containers MUST NEVER run on VLAN20 ("Citadel").
- Staging networking MUST use the dedicated Netplan bridge `br-staging`.
- `br-staging` MUST be untagged and use native VLAN1.
- The host MUST have no IP address assigned on `br-staging`.
- Containers SHOULD receive DHCP leases directly from the VLAN1 gateway.
- The bridge MUST be defined through Netplan, not created dynamically by LXD.
- LXD containers MUST attach via NIC device with `parent=br-staging`.

## 3. Storage Policy (Mandatory)
- Supported modes:
   1. **Persistent mode (default):**
       Evidence/log paths on host:
       `/mnt/ssd/staging/photo-ingress/evidence`
       `/mnt/ssd/staging/photo-ingress/logs`
   2. **Volatile mode:**
       Evidence/log paths in tmpfs:
       `/run/staging-photo-ingress/evidence`
       `/run/staging-photo-ingress/logs`
- Container hot-write paths (`/tmp`, `/var/tmp`) SHOULD be tmpfs.
- Container root filesystem reset MUST be performed through LXD snapshots only.

## 4. Lifecycle Contract (stagingctl)
- `create` MUST provision: container + venv + systemd + snapshot `clean`.
- `install` MUST deploy: wheel + staging config.
- `reset` MUST restore snapshot `clean`.
- `uninstall` MUST remove the staging container.
- `uninstall --purge` MUST additionally remove evidence/log host paths.
- Staging lifecycle actions MUST NOT modify host Python, host systemd, or host
   package state.

## 5. Evidence Requirements
- Evidence MUST be machine-readable, auditable, and complete.
- Secret scanning MUST be mandatory for every smoke/staging run.
- Evidence MUST NOT contain real secrets.
- Evidence format SHOULD be stable and versioned.

## 6. Code Boundary Rules
- All staging implementation code MUST live under `staging/`.
- Production code MUST NOT import staging modules.
- Staging tests MUST live under `tests/staging/` and remain optional to run.

## 7. Agent Execution Rules
- Prefer the least-invasive approach first.
- Make reversible changes and preserve deterministic rollback points.
- Do not couple staging behavior to host-global state.
- If a requested action conflicts with this policy, stop and ask for explicit
   override approval before proceeding.
