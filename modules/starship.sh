#!/usr/bin/env bash
# Módulo: Starship prompt (script oficial, instalado em ~/.local/bin sem sudo)
set -euo pipefail

install_starship() {
  if command -v starship >/dev/null; then
    echo "[starship] já instalado: $(starship --version | head -1)"
    return
  fi
  # Script oficial (rodar de novo atualiza para a última versão)
  mkdir -p "$HOME/.local/bin"
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
}

link_starship_config() {
  link_file "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"
}
