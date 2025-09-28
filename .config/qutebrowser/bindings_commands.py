# keys
c.bindings.commands = {
        'normal': {
            #  '<tab>': 'nop',
              'gR': 'spawn urxvt -e ranger /home/jonatas/Downloads'
            , 'xx': 'config-cycle statusbar.show never always ;; config-cycle tabs.show switching always'
            , 'xi': 'set downloads.location.directory ~/Imagens ;; hint images download'
            , ',m': 'hint links spawn mpv --ytdl-format="(bestvideo[height<=720]+bestaudio)[ext=webm]/bestvideo[height<=720]+bestaudio/best[height<=720]/bestvideo+bestaudio/best" --window-scale=1.0 {hint-url}'
            , ',M': 'spawn mpv --ytdl-format="(bestvideo[height<=720]+bestaudio)[ext=webm]/bestvideo[height<=720]+bestaudio/best[height<=720]/bestvideo+bestaudio/best" --window-scale=1.0 {url}'
            , ',a': 'hint links userscript youtube_mp3_downloader.sh'
            , ',A': 'spawn --userscript youtube_mp3_downloader.sh'
            , ',v': 'hint links userscript youtube_downloader.sh'
            , ',V': 'spawn --userscript youtube_downloader.sh'
            , '<': 'fake-key <Shift-\\,>'
            , '>': 'fake-key <Shift-\\.>'
            , 'tt': 'hint links userscript translate.sh'
            , 'tT': 'spawn --userscript translate.sh'
            , '<Ctrl+Shift+T>': 'spawn --userscript translate.sh --text'
            , ',r': 'hint links userscript transmission.sh' 
            , ',d': 'config-cycle colors.webpage.darkmode.enabled False True' 
            }
        }
