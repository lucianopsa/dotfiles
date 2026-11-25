#!/usr/bin/env bash
# Cria symlink de um arquivo do repo para o destino, fazendo backup se já existir.
link_file() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
    echo "[link] ok: $dest"; return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak.$(date +%Y%m%d%H%M%S)"
    echo "[link] backup de $dest criado"
  fi
  ln -s "$src" "$dest"
  echo "[link] $dest -> $src"
}
