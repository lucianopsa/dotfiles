#!/usr/bin/env bash
# Módulo: fish shell
set -euo pipefail

install_fish() {
  if command -v fish >/dev/null; then
    echo "[fish] já instalado: $(fish --version)"
  else
    sudo dnf install -y fish
  fi
}

set_fish_default() {
  local fish_path
  fish_path="$(command -v fish)"
  grep -qx "$fish_path" /etc/shells || echo "$fish_path" | sudo tee -a /etc/shells >/dev/null
  if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$fish_path" ]; then
    sudo chsh -s "$fish_path" "$USER"
    echo "[fish] definido como shell padrão (vale a partir do próximo login)"
  else
    echo "[fish] já é o shell padrão"
  fi
}
