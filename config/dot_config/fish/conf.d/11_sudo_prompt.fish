#!/usr/bin/env fish
if is_gui_terminal
    set -xg SUDO_PROMPT '[1;38;2;252;185;91m  [1;31mpass for[1;36m %p[0m [1;31m[1;33m[1;32m[0m '
else
    set -xg SUDO_PROMPT '[1;33m[!] [1;31mpass for[1;36m %p[0m [1;31m>[1;33m>[1;32m>[0m '
end
