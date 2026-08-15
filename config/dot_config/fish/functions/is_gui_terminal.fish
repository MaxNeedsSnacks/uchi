function is_gui_terminal --description "Returns 0 if running in a GUI"
    if set -q TERM_PROGRAM
        return 0
    end

    if set -q DISPLAY
        return 0
    end

    if set -q WAYLAND_DISPLAY
        return 0
    end

    if set -q WT_SESSION
        return 0
    end

    if set -q KONSOLE_VERSION
        return 0
    end

    return 1
end
