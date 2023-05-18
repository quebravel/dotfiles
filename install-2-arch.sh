#!/bin/bash

_so="sudo pacman -S --needed"
_s="sudo"
_yay"yay -S"

sudo pacman -Syu

playermusica(){

 clear
 echo -e "instalando e configurando ncmpcpp . mpd . mpc \n ... \n .. \n ."
 sleep 1


$_so \
ncmpcpp \
mpd \
mpc

if [ ! -d ~/Músicas ]; then 
 mkdir -p ~/Músicas
else
 echo "pasta Músicas já existe"
fi
if [ ! -d ~/.config/ncmpcpp ]; then
 mkdir --parents ~/.config/ncmpcpp/;
 cp ./.config/ncmpcpp/* ~/.config/ncmpcpp/;
else
 cp ./.config/ncmpcpp/* ~/.config/ncmpcpp/;
fi
if [ ! -d ~/.config/mpd ]; then
 mkdir --parents ~/.config/mpd/;
 cp ./.config/mpd/mpd.conf ~/.config/mpd/;
else
 cp ./.config/mpd/mpd.conf ~/.config/mpd/;
fi

$_s systemctl --user enable mpd.service

$_s systemctl --user start mpd.service

touch ~/.config/mpd/socket

sed -i 's/\# export MPD_HOST\=\$HOME\/.config\/mpd\/socket/export MPD_HOST\=\$HOME\/.config\/mpd\/socket/g' $HOME/.xinitrc

sed -i 's/# mpd --kill; mpd \&/mpd --kill; mpd \&/g' $HOME/.xinitrc

export MPD_HOST=$HOME/.config/mpd/socket

echo 'mpd . mpc . ncmpcpp ... instalados'

echo 'reinicie o systema ... reboot'

}

rangerfm(){

 clear
 echo -e "instalando ranger . ueberzug . ffmpegthumbnailer \n ... \n .. \n ."
 sleep 1

$_so \
ranger \
ueberzug \
ffmpegthumbnailer

if [ ! -d ~/.config/ranger/ ]; then
 mkdir --parents ~/.config/ranger/;
else
 echo "pasta ranger ... [ok]"
fi
if [ -f ~/.config/ranger/rc.conf ]; then
 echo "arquivo rc.conf ... [ok]"
else
 ranger --copy-config=rc
fi
if [ -f ~/.config/ranger/scope.sh ]; then
 echo "arquivo scope.sh ... [ok]"
else
 ranger --copy-config=scope
fi
if [ -f ~/.config/ranger/rifle.conf ]; then
 echo "arquivo rifle.conf ... [ok]"
else
 ranger --copy-config=rifle
fi

sed -i 's/set preview_images false/set preview_images true/g' $HOME/.config/ranger/rc.conf

sed -i 's/set draw_borders none/set draw_borders both/g' $HOME/.config/ranger/rc.conf

sed -i 's/set preview_images_method w3m/set preview_images_method ueberzug/g' $HOME/.config/ranger/rc.conf

# sed -i 's/set sort natural/set sort ctime/g' ~/.config/ranger/rc.conf

sed -i 's/mime ^audio|ogg$, terminal, has mplayer  = mplayer -- "$@"/mime ^audio|ogg$, terminal, has moc      = ncmpcpp -- "$@"/g' $HOME/.config/ranger/rifle.conf
sleep 1

sed -i '/label wallpaper, number 15, mime ^image, has feh, X = wal -i "$1"/d' $HOME/.config/ranger/rifle.conf
sleep 1

sed -i 's/label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"/label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"\nlabel wallpaper, number 15, mime ^image, has feh, X = wal -i "$1"/g' $HOME/.config/ranger/rifle.conf
sleep 1

sed -i '113,116s/#//' $HOME/.config/ranger/scope.sh

sed -i '157,160s/#//' $HOME/.config/ranger/scope.sh

sed -i 's/#set preview_script ~\/.config\/ranger\/scope.sh/set preview_script ~\/.config\/ranger\/scope.sh/g' $HOME/.config/ranger/rc.conf

ranger --version

}

audio_config(){

 clear
 echo -e "instalando alsa-utils . pulseauido \n ... \n .. \n ."
 sleep 1

echo "qual controlador de audio?"
read -r -p "[1] pulseauido  [2] pipewire  [enter/*] pular ... (default pipewire) ... " aud

case "$aud" in
 1) 
  echo "pulseauido" 
  $_so \
  alsa-utils \
  pulseaudio \
  # gst-plugins-{base,good,bad,ugly} \
  # gst-libav
  echo "pulseaudio ... instalado"
  ;;
 2) echo "pipewire"
  $_so \
  pipewire \
  pipewire-alsa \
  pipewire-audio \
  pipewire-pulse \
  helvum \
  # gst-plugin-pipewire
  echo "pipewire* ... instalado"
  ;;
 *) echo pular
  $_so \
  pipewire \
  pipewire-alsa \
  pipewire-audio \
  pipewire-pulse \
  helvum \
  # gst-plugin-pipewire
  echo "pipewire* ... instalado"
  ;;
esac

}

zshconfig(){

 clear
 echo -e "instalando zsh . zsh-completions  \n ... \n .. \n ."
 sleep 1

$_so \
zsh \
zsh-completions 

echo "zsh ... instalado"

}

fontes-emoji-nipo(){

 clear
 echo -e "instalando fontes  \n ... \n .. \n ."
 sleep 1

$_so \
ttf-dejavu \
noto-fonts-emoji \
gnu-free-fonts \
noto-fonts-cjk

echo "fontes ... instaladas"

}

drive_video_amdgpu(){

 clear
 echo -e "instalando xorg  \n ... \n .. \n ."
 sleep 1

$_so \
xorg-{server,xinit} \
xf86-video-amdgpu \
vulkan-radeon # driver open-source

echo "amdgpu ... instalado"

}

navegador(){

 clear
 echo -e "instalando browser  \n ... \n .. \n ."
 sleep 1

echo "Qual navegador preferido?"
read -r -p "[q]utebrowser  [f]irefox  [enter/*] pular  ... " browser

case "$browser" in
 q|1) 
   $_so qutebrowser
   echo "Adicionando dicionário"
   /usr/share/qutebrowser/scripts/dictcli.py install pt-BR
   echo "qutebrowser ... instalado"
 ;;
 f|2)
   $_so firefox firefox firefox-i18n-pt-br
   echo "firefox ... instalado"
 ;;
 *) echo "pular"
 ;;
esac

}

github_config(){


git clone https://github.com/quebravel/dotfiles-conf ~/dotfiles-conf
cp -r ~/dotfiles-conf/.config ~/

echo "configurações ... baixadas"

}

copilador_config(){

 clear
 echo -e "configurando copilador  \n ... \n .. \n ."
 sleep 1

# processador 
echo "congirurando makeflags para  4 processadores ativos durante a compilação ..."
$_s sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j4\"/g" /etc/makepkg.conf

#lscpu | grep '^CPU(s):' | cut -d ' ' -f29
lscpu | grep '^CPU(s):'

echo "copilador configurado para [4] processadores"

}

pastas_config(){

 clear
 echo -e "criando pastas padrao  \n ... \n .. \n ."
 sleep 1

xdg-user-dirs-update

}

temas(){

 clear
 echo -e "configurando temas gruvbox-dark para GTK  \n ... \n .. \n ."
 sleep 1

# gruvbox tema
mkdir -p ~/themes ~/icons
git clone https://github.com/jmattheis/gruvbox-dark-gtk ~/.themes/gruvbox-dark-gtk

sleep 1
git clone https://github.com/jmattheis/gruvbox-dark-icons-gtk ~/.icons/gruvbox-dark-icons-gtk

if [ -d ~/.config/gtk-3.0 ]; then
 cp ./.config/gtk-3.0/* ~/.config/;
else
 mkdir -p ~/.config/gtk-3.0/;
 cp ./.config/gtk-3.0/* ~/.config/;
fi

echo "temas gruvbox GTK ... instalados"

}

ohmyzsh(){

 clear
 echo -e "instalando oh-my-zsh  \n ... \n .. \n ."
 sleep 1

 sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
 echo "oh-my-zsh ... instalado"

}

alias_autopair(){

 clear
 echo -e "configurando zsh  \n ... \n .. \n ."
 sleep 1

# zsh alias, autopair
echo "arquivo alias"
wget https://raw.githubusercontent.com/quebravel/dotfiles-conf/master/.aliaszshrc -P ~/

echo "arquivo de plugins"
wget https://raw.githubusercontent.com/quebravel/dotfiles-conf/master/.vizshrc -P ~/

sleep 1
echo -e "\nexport\tEDITOR='nvim'\nexport\tTERMINAL='alacritty'\nexport\tBROWSER='qutebrowser'\nexport\tREADER='zathura'\nexport\tSHELL='zsh'\nexport\tXDG_CURRENT_DESKTOP='bspwm'\n\n[[ ! -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\n[[ ! -f ~/.aliaszshrc ]] || source ~/.aliaszshrc\n[[ ! -f ~/.vizshrc ]] || source ~/.vizshrc\n\n# autopair zsh\nif [[ ! -d ~/.zsh-autopair ]]; then\n\tgit clone https://github.com/hlissner/zsh-autopair ~/.zsh-autopair\nfi\n\nsource ~/.zsh-autopair/autopair.zsh\nautopair-init" >> $HOME/.zshrc

echo "zsh configurado"

}


zshconfig
fontes-emoji-nipo
# drive_video_amdgpu
navegador
# github_config
copilador_config
temas
autoscript_git
# audio_pulseaudio
audio_pipewire
ohmyzsh
rangerfm
playermusica
alias_autopair
ly_config
