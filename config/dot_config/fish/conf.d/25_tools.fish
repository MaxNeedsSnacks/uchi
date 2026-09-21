if not status is-interactive;
    return
end

# zoxide
zoxide init fish --cmd cd | source

# direnv
direnv hook fish | source

# mise
mise activate fish | source
