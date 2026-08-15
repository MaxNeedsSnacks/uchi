function disable_starship --wraps='set STARSHIP_CONFIG ""' --description 'alias disable_starship set STARSHIP_CONFIG ""'
    set STARSHIP_CONFIG "" $argv
end
