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
