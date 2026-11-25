#!/usr/bin/env bash
# Módulo: Starship prompt (script oficial, instalado em ~/.local/bin sem sudo)
set -euo pipefail

install_starship() {
  # O script oficial instala ou atualiza para a última versão
  mkdir -p "$HOME/.local/bin"
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
}

link_starship_config() {
  link_file "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"
}
