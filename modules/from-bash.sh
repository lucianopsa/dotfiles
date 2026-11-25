#!/usr/bin/env bash
# Módulo OPCIONAL: configurações migradas do ~/.bashrc para o fish
# (~/bin, fnm, pnpm, Ctrl+Backspace apaga palavra). Só é aplicado se o usuário escolher.
set -euo pipefail

link_from_bash_config() {
  link_file "$DOTFILES/config/fish/conf.d/from-bash.fish" "$HOME/.config/fish/conf.d/from-bash.fish"
}
