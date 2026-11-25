# Registro de personalizações do terminal

Sistema base: Fedora 44 Workstation (dnf).
Cada passo abaixo vira um módulo em `modules/` usado pelo `install.sh`.

## 1. Fish shell
- Instalação: `sudo dnf install -y fish`
- Módulo: `modules/fish.sh`
- Shell padrão: `sudo chsh -s /usr/bin/fish $USER` (decidido: fish como padrão)
- Observação: no Fedora 44 o `chsh` já vem no sistema (não precisa do pacote util-linux-user).
- Status: ✅ concluído em 2026-11-25 (fish 4.6.0)
