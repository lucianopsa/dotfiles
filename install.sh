#!/usr/bin/env bash
# Instalador do meu terminal — veja REGISTRO.md para o histórico de cada passo.
#
# Uso:
#   ./install.sh                 # interativo (pergunta as opções)
#   ./install.sh -y              # sem perguntas, usa os padrões
#   ./install.sh --from-bash     # inclui a migração das configs do bash
#   ./install.sh --no-from-bash  # não inclui a migração
#   ./install.sh --shell fish    # shell a configurar (por enquanto só fish)
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES
export PATH="$HOME/.local/bin:$PATH"   # starship/zoxide são instalados aqui

# ---------- opções ----------
ASSUME_YES=false
SHELL_CHOICE="fish"
FROM_BASH=""          # vazio = perguntar

usage() { sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'; }

while [ $# -gt 0 ]; do
  case "$1" in
    -y|--yes)       ASSUME_YES=true ;;
    --shell)        SHELL_CHOICE="${2:?--shell requer um valor}"; shift ;;
    --shell=*)      SHELL_CHOICE="${1#*=}" ;;
    --from-bash)    FROM_BASH=true ;;
    --no-from-bash) FROM_BASH=false ;;
    -h|--help)      usage; exit 0 ;;
    *) echo "Opção desconhecida: $1"; usage; exit 1 ;;
  esac
  shift
done

ask() { # ask "pergunta" padrão(s/n)
  local q="$1" def="$2" ans
  if $ASSUME_YES || [ ! -t 0 ]; then [ "$def" = s ]; return; fi
  read -r -p "$q [$( [ "$def" = s ] && echo S/n || echo s/N )] " ans
  ans="${ans:-$def}"
  [[ "$ans" =~ ^[sSyY] ]]
}

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

# ---------- verificações ----------
. /etc/os-release
if [ "${ID:-}" != "fedora" ]; then
  echo "Este instalador suporta apenas Fedora (detectado: ${PRETTY_NAME:-desconhecido})."
  exit 1
fi

case "$SHELL_CHOICE" in
  fish) ;;
  *) echo "Shell '$SHELL_CHOICE' ainda não suportado. Opções: fish"; exit 1 ;;
esac

if [ -z "$FROM_BASH" ]; then
  if ask "Migrar configurações do bash para o fish (~/bin, fnm, pnpm, Ctrl+Backspace)?" s; then
    FROM_BASH=true
  else
    FROM_BASH=false
  fi
fi

# ---------- módulos ----------
. "$DOTFILES/lib/link.sh"
for m in "$DOTFILES"/modules/*.sh; do . "$m"; done

step "Dependências básicas"
deps=(curl tar xz fontconfig)
missing=()
for p in "${deps[@]}"; do rpm -q "$p" >/dev/null 2>&1 || missing+=("$p"); done
if [ ${#missing[@]} -gt 0 ]; then sudo dnf install -y "${missing[@]}"; else echo "[deps] ok"; fi

step "Fish";        install_fish
step "Nerd Font";   install_nerd_font; configure_ptyxis_font
step "Starship";    install_starship
step "bat";         install_bat
step "fzf";         install_fzf
step "zoxide";      install_zoxide

step "Configurações (symlinks)"
link_fish_config
link_starship_config
link_bat_config
if $FROM_BASH; then
  link_from_bash_config
else
  echo "[from-bash] pulado"
fi

step "Shell padrão"
set_fish_default

step "Pronto!"
echo "Abra um terminal novo (ou faça logout/login se o shell padrão mudou)."
