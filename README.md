# nightfall-vscode-workspace

Workspace/meta repository for the Nightfall development environment.

This repository stores editor and agent configuration only. Runtime code lives in sibling repositories:

- ../nightfall-scripts
- ../nightfall-mcp
- ../nightfall-photo-ingress

## First-time setup

Run the bootstrap script to ensure sibling repositories exist:

```bash
./scripts/bootstrap-repos.sh
```

Then open the workspace file:

```bash
code nightfall.code-workspace
```

## Update all sibling repositories

```bash
./scripts/update-repos.sh
```
