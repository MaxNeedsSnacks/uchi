if command --query yt-dlp
    function ytdl --wraps=yt-dlp --description 'alias ytdl yt-dlp'
        yt-dlp $argv
    end
else if command --query youtube-dl
    function ytdl --wraps=youtube-dl --description 'alias ytdl youtube-dl'
        youtube-dl $argv
    end
else
    set_color red and echo "youtube downloader not found!"
    exit 127
end
