#!/usr/bin/env bash
# Módulo: JetBrainsMono Nerd Font (instalação por usuário, sem sudo)
set -euo pipefail

install_nerd_font() {
  local font="JetBrainsMono"
  local dest="$HOME/.local/share/fonts/${font}NerdFont"
  # Captura antes do grep: `fc-list | grep -q` falha com pipefail (SIGPIPE)
  local installed; installed="$(fc-list : family)"
  if grep -qi "${font} Nerd Font" <<<"$installed"; then
    echo "[nerd-font] ${font} Nerd Font já instalada"
    return
  fi
  local tmp; tmp="$(mktemp -d)"
  curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.tar.xz" -o "$tmp/${font}.tar.xz"
  mkdir -p "$dest"
  tar -xJf "$tmp/${font}.tar.xz" -C "$dest"
  rm -rf "$tmp"
  fc-cache -f "$dest"
  echo "[nerd-font] ${font} Nerd Font instalada em $dest"
}

configure_ptyxis_font() {
  command -v ptyxis >/dev/null || { echo "[nerd-font] ptyxis não encontrado, pulando"; return; }
  gsettings set org.gnome.Ptyxis use-system-font false
  gsettings set org.gnome.Ptyxis font-name 'JetBrainsMonoNL Nerd Font Mono 10'
  echo "[nerd-font] Ptyxis configurado com JetBrainsMonoNL Nerd Font Mono 10"
}
