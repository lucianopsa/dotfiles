# ~/.config/fish/config.fish — gerenciado por ~/dotfiles

# Binários do usuário (starship e outros instalados sem sudo)
fish_add_path -g ~/.local/bin

# Man pages coloridas com bat
type -q bat; and set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

if status is-interactive
    # Prompt
    type -q starship; and starship init fish | source

    # zoxide substituindo o cd (cd = z, cdi = zi). Deve ficar no fim do arquivo.
    type -q zoxide; and zoxide init fish --cmd cd | source
end
