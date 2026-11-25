# Registro de personalizações do terminal

Sistema base: Fedora 44 Workstation (dnf).
Cada passo abaixo vira um módulo em `modules/` usado pelo `install.sh`.
Escopo: só o terminal (shell, prompt, fontes, ferramentas de linha de comando e suas configs). Ferramentas de desenvolvimento como fnm/pnpm ficam fora.

## Como usar o instalador
```bash
# Um comando só (como o Starship): baixa em ~/dotfiles e instala
curl -fsSL https://raw.githubusercontent.com/lucianopsa/dotfiles/master/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/lucianopsa/dotfiles/master/install.sh | bash -s -- -y --no-from-bash

# Ou clonando manualmente
git clone git@github.com:lucianopsa/dotfiles.git ~/dotfiles && cd ~/dotfiles
./install.sh                 # interativo (pergunta se migra as configs do bash)
./install.sh -y              # sem perguntas, padrões (inclui from-bash)
./install.sh --no-from-bash  # sem a migração do bash
./install.sh --shell fish    # por enquanto só fish
```
- Pode rodar várias vezes: pula o que já está instalado e só cria os symlinks que faltam (com backup do que existir).
- Configs ficam neste repo e são ligadas por symlink em `~/.config` — editar lá é editar aqui.
- Testado em container Fedora 44 limpo (2026-11-25).

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

## 6. fzf (fuzzy finder)
- Instalação: `sudo dnf install -y fzf` (fzf 0.75.0)
  - Decisão: dnf (oficial para Fedora e atualizado) em vez de `~/.fzf/install`, que edita os arquivos do shell sozinho
- Fish: `fzf --fish | source` no bloco interativo do `config.fish`
  - Ctrl+R histórico · Ctrl+T arquivos · Alt+C diretórios · ativa o `cdi` do zoxide
- Preview no Ctrl+T (`FZF_CTRL_T_OPTS`): `bat -n` para arquivos, `ls -la` para diretórios; ignora .git/node_modules/target; Ctrl+/ alterna o preview
- Módulo: `modules/fzf.sh`
- Status: ✅ concluído em 2026-11-25

## 7. Fish sem mensagem de boas-vindas
- `set -g fish_greeting` (vazio) no bloco interativo do `config.fish`
- Status: ✅ concluído em 2026-11-25

## 8. Starship: módulo Google Cloud desativado
- Config: `config/starship.toml` → symlink em `~/.config/starship.toml` (`link_starship_config` em `modules/starship.sh`)
- `[gcloud] disabled = true` (o e-mail da conta ocupava muito espaço no prompt)
- Alternativas consideradas: mostrar só o projeto, usuário + projeto, só o ícone
- Status: ✅ concluído em 2026-11-25

## 9. Starship: ícone do Node.js
- `[nodejs] symbol = '󰎙 '` (U+F0399, nf-md-nodejs) no `config/starship.toml`
- Motivo: o padrão U+E718 (nf-dev-nodejs_small) aparece como um hexágono pequeno na JetBrainsMonoNL Nerd Font Mono
- Status: ✅ concluído em 2026-11-25

## 10. Migração das configurações do bash para o fish (OPCIONAL no instalador)
- Origem: `~/.bashrc` (o `~/.bashrc.d` não existe; `.bash_profile` só carrega o `.bashrc`)
- Arquivo: `config/fish/conf.d/from-bash.fish` → symlink em `~/.config/fish/conf.d/` (carregado automaticamente pelo fish)
- Migrado:
  | bash | fish |
  |---|---|
  | PATH `~/.local/bin` | já no `config.fish` (`fish_add_path`) |
  | PATH `~/bin` | `fish_add_path` só se o diretório existir |
  | fnm (`fnm env --shell bash`) | `fnm env --shell fish \| source` + PATH do fnm |
  | pnpm (`PNPM_HOME`, `$PNPM_HOME/bin`) | `set -gx PNPM_HOME` + `fish_add_path` |
  | `stty werase ^H` (Ctrl+Backspace) | `bind ctrl-h backward-kill-word` |
- Cada item só é ativado se a ferramenta/diretório existir (não quebra num sistema sem fnm/pnpm)
- Módulo: `modules/from-bash.sh` (`link_from_bash_config`) — opcional
- Observação: o instalador não instala fnm nem pnpm (só configura o fish para usá-los)
- Status: ✅ concluído em 2026-11-25 (testado em ambiente limpo: node v24.22.1, pnpm, fnm ok)

## 11. Instalador (`install.sh`)
- Junta os módulos na ordem: dependências → fish → nerd font → starship → bat → fzf → zoxide → symlinks → shell padrão
- Opções: `-y`, `--from-bash` / `--no-from-bash`, `--shell fish` (base para oferecer zsh no futuro)
- Só Fedora (aborta em outra distro)
- Correção: `fc-list | grep -q` com `pipefail` dava falso negativo (SIGPIPE) e baixava a fonte de novo; agora captura a saída antes
- Status: ✅ testado nesta máquina (idempotente) e num container Fedora 44 limpo

## 12. Instalação via curl (repositório público)
- Repositório tornado público (só configs de terminal, nada sensível) para o `curl | bash` funcionar sem token
- `install.sh` detecta que está rodando sozinho (sem `modules/` ao lado) e baixa o repo em `~/dotfiles` (ou `$DOTFILES_DIR`):
  - com git: `git clone` via https (push configurado para ssh), ou `git pull` se já existir
  - sem git: `tar.gz` de `github.com/lucianopsa/dotfiles/archive/refs/heads/master.tar.gz`
- Reexecuta a partir do repo com stdin em `/dev/tty`, para as perguntas funcionarem no `curl | bash`
- Decisão: sem GitHub Pages (raw.githubusercontent.com já serve o script)
- Status: ✅ concluído em 2026-11-25
