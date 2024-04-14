export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='qutebrowser'
export READER='zathura'
export SHELL='zsh'
# export	XDG_CURRENT_DESKTOP='hyprland'
# export  XDG_PICTURES_DIR='/home/jonatas/Imagens/'

[[ ! -f ~/.config/zsh/alias.zsh ]] || source ~/.config/zsh/alias.zsh 
[[ ! -f ~/.config/zsh/vim-mode.zsh ]] || source ~/.config/zsh/vim-mode.zsh
# [[ ! -f $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh ]] || source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Instala autopair se não haver.
if [[ ! -d ~/.config/zsh/zsh-autopair ]]; then
	git clone https://github.com/hlissner/zsh-autopair ~/.config/zsh/zsh-autopair
fi

# Carregar autopair.
source ~/.config/zsh/zsh-autopair/autopair.zsh
autopair-init

# if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#     dbus-run-session Hyprland
# fi

# source ~/.config/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Carregar configuração starshitp prompt. 
# eval "$(starship init zsh)"

# qutebrowser ser aberto por links no terminal
# xdg-mime default org.qutebrowser.qutebrowser.desktop x-scheme-handler/https x-scheme-handler/http
