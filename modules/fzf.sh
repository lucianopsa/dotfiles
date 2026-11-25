#!/usr/bin/env bash
# Módulo: fzf (fuzzy finder)
set -euo pipefail

install_fzf() {
  if command -v fzf >/dev/null; then
    echo "[fzf] já instalado: $(fzf --version)"
  else
    sudo dnf install -y fzf
  fi
}
