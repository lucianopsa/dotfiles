# Configurações migradas do ~/.bashrc — opcional no instalador (gerenciado por ~/dotfiles)

# ~/bin no PATH (o bash do Fedora adiciona por padrão)
test -d ~/bin; and fish_add_path -g ~/bin

# fnm (gerenciador de versões do Node)
set -l fnm_path ~/.local/share/fnm
if test -d $fnm_path
    fish_add_path -g $fnm_path
    fnm env --shell fish | source
end

# pnpm
set -gx PNPM_HOME ~/.local/share/pnpm
test -d $PNPM_HOME/bin; and fish_add_path -g $PNPM_HOME/bin

# Ctrl+Backspace apaga a palavra anterior (equivalente ao `stty werase ^H` do bash;
# o Ptyxis envia ^H no Ctrl+Backspace)
if status is-interactive
    bind ctrl-h backward-kill-word
end
