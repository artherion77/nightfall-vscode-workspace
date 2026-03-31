#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASE_DIR="${ROOT_DIR}/.."

ensure_repo() {
  local name="$1"
  local url="$2"
  local branch="$3"
  local path="$4"
  local target="${BASE_DIR}/${path}"

  if [[ -d "${target}/.git" ]]; then
    echo "[OK] ${name} exists at ${target}"
    return 0
  fi

  echo "[CLONE] ${name} -> ${target}"
  git clone --branch "${branch}" --single-branch "${url}" "${target}"
}

ensure_repo "nightfall-scripts" "git@github.com:artherion77/nightfall-scripts.git" "main" "nightfall-scripts"
ensure_repo "nightfall-mcp" "git@github.com:artherion77/nightfall-mcp.git" "main" "nightfall-mcp"
ensure_repo "nightfall-photo-ingress" "git@github.com:artherion77/nightfall-photo-ingress.git" "main" "nightfall-photo-ingress"

echo "Bootstrap complete."
