status is-interactive; and begin
    # Abbreviations
    abbr --add -- vi nvim
    abbr --add -- vim nvim

    # Aliases
    alias eza 'eza --icons auto --group --group-directories-first --header'
    alias la 'eza -a'
    alias ll 'eza -l'
    alias lla 'eza -la'
    alias ls eza
    alias lt 'eza --tree'
    alias vi nvim
    alias vim nvim
    alias vimdiff 'nvim -d'
end
