#!/usr/bin/env bash
# Módulo: zoxide (cd inteligente) — script oficial, instala em ~/.local/bin sem sudo
set -euo pipefail

install_zoxide() {
  if command -v zoxide >/dev/null; then
    echo "[zoxide] já instalado: $(zoxide --version)"
  else
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  fi
}
