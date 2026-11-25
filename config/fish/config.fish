# ~/.config/fish/config.fish — gerenciado por ~/dotfiles

# Binários do usuário (starship e outros instalados sem sudo)
fish_add_path -g ~/.local/bin

if status is-interactive
    # Prompt
    type -q starship; and starship init fish | source
end
