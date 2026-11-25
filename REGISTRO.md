# Registro de personalizações do terminal

Sistema base: Fedora 44 Workstation (dnf).
Cada passo abaixo vira um módulo em `modules/` usado pelo `install.sh`.

## 1. Fish shell
- Instalação: `sudo dnf install -y fish`
- Módulo: `modules/fish.sh`
- Config: `config/fish/config.fish` → symlink em `~/.config/fish/config.fish` (via `lib/link.sh`, com backup)
- Shell padrão: `sudo chsh -s /usr/bin/fish $USER` (decidido: fish como padrão)
- Observação: no Fedora 44 o `chsh` já vem no sistema (não precisa do pacote util-linux-user).
- Status: ✅ concluído em 2026-11-25 (fish 4.6.0)

## 2. Nerd Font (pré-requisito do Starship)
- Fonte: JetBrainsMono Nerd Font, instalada por usuário em `~/.local/share/fonts` (sem sudo)
- Origem: release `JetBrainsMono.tar.xz` do github.com/ryanoasis/nerd-fonts + `fc-cache`
- Terminal: Ptyxis com `JetBrainsMonoNL Nerd Font Mono 10` (gsettings `org.gnome.Ptyxis`)
- Módulo: `modules/nerd-font.sh` (`install_nerd_font`, `configure_ptyxis_font`)
- Status: ✅ já estava instalada nesta máquina; módulo criado para reinstalações

## 3. Starship (prompt)
- Instalação: script oficial `curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin` (sem sudo; rodar de novo atualiza)
- Fish: `fish_add_path -g ~/.local/bin` + `starship init fish | source` no `config.fish`
- Módulo: `modules/starship.sh`
- Decisão: script oficial em vez do COPR atim/starship (recomendação do projeto, não precisa de sudo)
- Status: ✅ concluído em 2026-11-25 (starship 1.27.0)

## 4. bat (cat com syntax highlighting)
- Instalação: `sudo dnf install -y bat` (já vinha instalado nesta máquina: bat 0.26.1)
- Config: `config/bat/config` → symlink em `~/.config/bat/config`
- Decisões:
  - Tema: automático (segue claro/escuro do terminal), sem `--theme` fixo
  - `cat` original mantido (sem alias)
  - Man pages coloridas: `set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"` no `config.fish`
- Módulo: `modules/bat.sh` (`install_bat`, `link_bat_config`)
- Status: ✅ concluído em 2026-11-25

## 5. zoxide (cd inteligente)
- Instalação: script oficial `curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh`
  (binário em `~/.local/bin`, man em `~/.local/share/man`, sem sudo). Decisão: script em vez de `dnf` (recomendado pelo projeto; dnf tinha 0.9.8)
- Fish: `zoxide init fish --cmd cd | source` no fim do bloco interativo do `config.fish`
  - `cd` passa a ser o zoxide (aprende diretórios; `cd proj` pula para o mais usado)
  - `cdi` = busca interativa (requer `fzf`)
- Módulo: `modules/zoxide.sh`
- Status: ✅ concluído em 2026-11-25 (zoxide 0.10.0)
