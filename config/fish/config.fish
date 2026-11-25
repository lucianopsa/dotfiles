# ~/.config/fish/config.fish — gerenciado por ~/dotfiles

# Binários do usuário (starship e outros instalados sem sudo)
fish_add_path -g ~/.local/bin

# Man pages coloridas com bat
type -q bat; and set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

if status is-interactive
    # Prompt
    type -q starship; and starship init fish | source

    # fzf: Ctrl+R (histórico), Ctrl+T (arquivos), Alt+C (diretórios)
    type -q fzf; and fzf --fish | source
    # Ctrl+T com preview: bat para arquivos, ls para diretórios; Ctrl+/ alterna o preview
    set -gx FZF_CTRL_T_OPTS "
      --walker-skip .git,node_modules,target
      --preview 'test -d {} && ls -la --color=always {} || bat -n --color=always {}'
      --bind 'ctrl-/:change-preview-window(down|hidden|)'"

    # zoxide substituindo o cd (cd = z, cdi = zi). Deve ficar no fim do arquivo.
    type -q zoxide; and zoxide init fish --cmd cd | source
end
