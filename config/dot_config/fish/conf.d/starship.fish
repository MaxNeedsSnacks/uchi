status is-interactive; and begin
    if not set -q DISABLE_STARSHIP
        starship init fish | source
        enable_transience
    else
        echo "starship prompt disabled!"
    end
end
