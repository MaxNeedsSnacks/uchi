if command --query bat
    function cat --wraps=bat --description 'alias cat=bat'
        bat $argv
    end
end
