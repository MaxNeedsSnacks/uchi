status is-login; and begin
    # remote connections should not try to use pinentry-touchid
    if set -q SSH_CONNECTION
        set -gx PINENTRY_USER_DATA "USE_CURSES=1"
    end
end

# export GPG_TTY
status is-interactive; and begin
    set -gx GPG_TTY (tty)
end
