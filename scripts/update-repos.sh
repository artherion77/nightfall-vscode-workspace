#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASE_DIR="${ROOT_DIR}/.."

update_repo() {
  local name="$1"
  local branch="$2"
  local path="$3"
  local target="${BASE_DIR}/${path}"

  if [[ ! -d "${target}/.git" ]]; then
    echo "[SKIP] ${name} missing at ${target}"
    return 0
  fi

  echo "[UPDATE] ${name}"
  git -C "${target}" fetch origin
  git -C "${target}" checkout "${branch}"
  git -C "${target}" pull --ff-only origin "${branch}"
}

update_repo "nightfall-scripts" "main" "nightfall-scripts"
update_repo "nightfall-mcp" "main" "nightfall-mcp"
update_repo "nightfall-photo-ingress" "main" "nightfall-photo-ingress"

echo "Update complete."
