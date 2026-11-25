#!/usr/bin/env bash
# Módulo: bat (cat com syntax highlighting)
set -euo pipefail

install_bat() {
  if command -v bat >/dev/null; then
    echo "[bat] já instalado: $(bat --version)"
  else
    sudo dnf install -y bat
  fi
}

link_bat_config() {
  link_file "$DOTFILES/config/bat/config" "$HOME/.config/bat/config"
}
