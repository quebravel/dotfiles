### luke smith vi mode

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
# HISTFILE=~/.cache/zsh/history

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char

# History search
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search

bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Yank to the system clipboard
# function vi-yank-xclip {
#     zle vi-yank
#    # echo "$CUTBUFFER" | xclip -selection "clipboard"
#    echo "$CUTBUFFER" | wl-copy
# }
#
# zle -N vi-yank-xclip
# bindkey -M vicmd 'y' vi-yank-xclip
# End Yank

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# copy or paste wayland version
function x11-clip-wrap-widgets() {
    # NB: Assume we are the first wrapper and that we only wrap native widgets
    # See zsh-autosuggestions.zsh for a more generic and more robust wrapper
    local copy_or_paste=$1
    shift

    for widget in $@; do
        # Ugh, zsh doesn't have closures
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function _x11-clip-wrapped-$widget() {
                zle .$widget
                wl-copy <<<\$CUTBUFFER
            }
            "
        else
            eval "
            function _x11-clip-wrapped-$widget() {
                CUTBUFFER=\$(wl-paste)
                zle .$widget
            }
            "
        fi

        zle -N $widget _x11-clip-wrapped-$widget
    done
}

# copy or paste xorg version
# function x11-clip-wrap-widgets() {
#     # NB: Assume we are the first wrapper and that we only wrap native widgets
#     # See zsh-autosuggestions.zsh for a more generic and more robust wrapper
#     local copy_or_paste=$1
#     shift
#
#     for widget in $@; do
#         # Ugh, zsh doesn't have closures
#         if [[ $copy_or_paste == "copy" ]]; then
#             eval "
#             function _x11-clip-wrapped-$widget() {
#                 zle .$widget
#                 xclip -in -selection clipboard <<<\$CUTBUFFER
#             }
#             "
#         else
#             eval "
#             function _x11-clip-wrapped-$widget() {
#                 CUTBUFFER=\$(xclip -out -selection clipboard)
#                 zle .$widget
#             }
#             "
#         fi
#
#         zle -N $widget _x11-clip-wrapped-$widget
#     done
# }

local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)

# NB: can atm. only wrap native widgets
x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets
