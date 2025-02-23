# Alias

# shutdown
alias shutdown="sudo shutdown"

# system
alias ipa="ip -s -c -h a"
alias s="sxiv -ftq *"
alias f="sxiv -frqto * | xargs feh --bg-scale"
alias n="nvim"
alias tmux='TERM=xterm-256color tmux'
alias mkfs.ntfs='mkfs.ntfs --fast'
alias lynx='lynx -cfg=~/lynx.cfg'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias limpar='sudo pacman -Rs $(pacman -Qdtq)'
alias i='imv -r .'
alias m="man -P less"

# atalhos
alias nzshrc="nvim ~/.zshrc && source ~/.zshrc"
alias npolybar="nvim ~/.config/polybar/config.ini"
alias nbspwm="nvim ~/.config/bspwm/bspwmrc"
alias nsxhkd="nvim ~/.config/sxhkd/sxhkdrc"
alias nqute="nvim ~/.config/qutebrowser/config.py"
alias nxmonad="nvim ~/.config/xmonad/xmonad.hs"
alias nalacri="nvim ~/.config/alacritty/alacritty.toml"
alias nwaybar='nvim ~/.config/waybar/config'
alias nhypr="nvim ~/.config/hypr/hyprland.conf"

# xbps
# alias xi="sudo xbps-install -S"
# alias xiu="sudo xbps-install -Su"
# alias xr="sudo xbps-remove -R"
# alias xq="xbps-query -Rs"
# alias xo="sudo xbps-remove -Oo"
# alias vkp="sudo vkpurge rm all"

# yay
# alias y="yay"
# alias ys="yay -S"
# alias yr="yay -Rs"
# alias yss="yay -Ss"

# paru
# alias p="paru"
# alias pi="paru -S"
# alias prs="paru -Rs"
# alias pss="paru -Ss"

# Changing "ls" to "exa"
alias la='exa -la --color-scale --color=always --group-directories-first --icons --git --header' # my preferred listing
alias lau='exa -la --color-scale --color=always --group-directories-first --sort=modified --icons --git --header' # my preferred listing
alias ls='exa -a --color-scale --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color-scale --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color-scale --color=always --group-directories-first --icons' # tree listing
alias l.='exa -a --color-scale | egrep "^\."'

# youtube-dl
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "
