#!/bin/bash
# TODO concluido 

_so="sudo pacman -S --needed"
_s="sudo"

sudo pacman -Syu

playermusica(){

 clear
 echo -e "... configurando ncmpcpp . mpd . mpc \n ... \n .. \n ."
 sleep 1

 echo "1) Sim  ou  2) Não *) Pular"
read -r -p "Quer instalar o player de música? ... " plmc
case "$plmc" in
 1) 
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

 ;;
 *) echo "Oxente!!!"
 ;;
esac

}

rangerfm(){

 clear
 echo -e "... ranger . ueberzug . ffmpegthumbnailer \n ... \n .. \n ."
 sleep 1

 echo "1) ranger   2) Não   *) Pular"
read -r -p "Quer uma gerenciador de arquivos para terminal? ... " rag

case "$rag" in
 1)
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
 sleep 1
 sed -i 's/set preview_images false/set preview_images true/g' $HOME/.config/ranger/rc.conf
 sleep 1
 sed -i 's/set draw_borders none/set draw_borders both/g' $HOME/.config/ranger/rc.conf
 sleep 1
 sed -i 's/set preview_images_method w3m/set preview_images_method ueberzug/g' $HOME/.config/ranger/rc.conf
 sleep 1
 sed -i 's/#set preview_script ~\/.config\/ranger\/scope.sh/set preview_script ~\/.config\/ranger\/scope.sh/g' $HOME/.config/ranger/rc.conf
 # sed -i 's/set sort natural/set sort ctime/g' ~/.config/ranger/rc.conf
fi
if [ -f ~/.config/ranger/scope.sh ]; then
 echo "arquivo scope.sh ... [ok]"
else
 ranger --copy-config=scope
 sleep 1
 sed -i '113,116s/#//' $HOME/.config/ranger/scope.sh
 sleep 1
 sed -i '157,160s/#//' $HOME/.config/ranger/scope.sh
fi
if [ -f ~/.config/ranger/rifle.conf ]; then
 echo "arquivo rifle.conf ... [ok]"
else
 ranger --copy-config=rifle
 sed -i 's/mime ^audio|ogg$, terminal, has mplayer  = mplayer -- "$@"/mime ^audio|ogg$, terminal, has moc      = ncmpcpp -- "$@"/g' $HOME/.config/ranger/rifle.conf
 sleep 1
 sed -i '/label wallpaper, number 15, mime ^image, has feh, X = wal -i "$1"/d' $HOME/.config/ranger/rifle.conf
 sleep 1
 sed -i 's/label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"/label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"\nlabel wallpaper, number 15, mime ^image, has feh, X = wal -i "$1"/g' $HOME/.config/ranger/rifle.conf
fi

ranger --version
 ;;
 2) echo "Beleza"
 ;;
 *) echo "Ei mar!!!"
 ;;
esac


}

audio_config(){

 clear
 echo -e "... controlador audio \n ... \n .. \n ."
 sleep 1

 echo "1) pulseauido  2) pipewire  *) pular ... (default pipewire)"
read -r -p "qual controlador de audio? ... " aud

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
 2|*) echo "Ta bom!"
  $_so \
  pipewire \
  pipewire-alsa \
  pipewire-audio \
  pipewire-pulse \
  helvum \
  # gst-plugin-pipewire
  echo "pipewire* ... instalado"
  echo -e "use <wpctl status> para detectar en Sinks: o númeor ID da saída de áudío \nexemplo: \nwpctl status \n
 Sinks: \n
 33. Áudio interno Estéreo analógico  [vol: 1.20] \n
 53. Ellesmere HDMI Audio [Radeon RX 470/480 / 570/580/590] Digital Stereo (HDMI 6) \n
 wpctl set-default 53" >> notas.txt
  ;;
esac

}

zshinstall(){

 clear
 echo -e "instalando zsh . zsh-completions  \n ... \n .. \n ."
 sleep 1

$_so \
zsh \
zsh-completions 

echo "zsh ... instalado"

}

fontes_doSistema(){

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

navegador(){

 clear
 echo -e "... browser  \n ... \n .. \n ."
 sleep 1

 echo "1) qutebrowser  2) firefox  *) pular"
read -r -p "Qual navegador preferido?  ... " browser

case "$browser" in
 1) 
   BROW="qutebrowser"
 ;;
 2)
   BROW="firefox"
 ;;
 *) echo "Canelau"
 ;;
esac

if [ $BROW = "qutebrowser" ]; then
 $_so qutebrowser python-adblock
 echo "Adicionando dicionário"
 /usr/share/qutebrowser/scripts/dictcli.py install pt-BR
 echo "qutebrowser ... instalado"
 mkdir -p ~/.config/qutebrowser/;
 cp -r ./.config/qutebrowser/* ~/.config/qutebrowser/;
 chmod +x ~/.config/qutebrowser/greasemonkey/*
 echo "$BROW configurado"
elif [ $BROW = "firefox" ]; then
 $_so firefox firefox firefox-i18n-pt-br
 echo "$BROW ... instalado"
fi

}

copilador_config(){

 clear
 echo -e "configurando copilador  \n ... \n .. \n ."
 sleep 1

# processador 
ncore=`lscpu | grep "^CPU(s)" | head -n 1 | cut -d: -f2 | tr -d " "`

echo "congirurando makeflags para  $ncore processadores ativos durante a compilação ..."
echo "coloque a senha ... "
$_s sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$ncore\"/g" /etc/makepkg.conf


echo "copilador configurado para [$ncore] processadores"

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
if [ ! -d ~/.themes ]; then
git clone https://github.com/jmattheis/gruvbox-dark-gtk ~/.themes/gruvbox-dark-gtk
else
 echo "voce ja tem o tema"
fi
sleep 1
if [ ! -d ~/.icons ]; then
git clone https://github.com/jmattheis/gruvbox-dark-icons-gtk ~/.icons/gruvbox-dark-icons-gtk
else
 echo "voce ja tem o tema"
fi
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

if [ ! -d ~/.oh-my-zsh ]; then
 sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
 echo "oh-my-zsh ... instalado"
else
 echo "já existe oh-my-zsh"
fi

echo -e "parte 2 feito \n ... \n .. \n . \n =)"

}

alias_autopair(){

 clear
 echo -e "configurando zsh  \n ... \n .. \n ."
 sleep 1

# zsh alias, autopair
echo "arquivo alias"
if [ ! -f ~/.config/zsh/alias.zsh ]; then
 mkdir --parents ~/.config/zsh/;
 cp ./.config/zsh/alias.zsh ~/.config/zsh/;
fi

echo "arquivo de plugins"
if [ ! -f ~/.config/zsh/vim-mode.zsh ]; then
 mkdir --parents  ~/.config/zsh/;
 cp ./.config/zsh/vim-mode.zsh ~/.config/zsh/;
fi

sleep 1

if [ -f ~/.zshrc ]; then
echo -e "\nexport	EDITOR='nvim'\nexport	TERMINAL='alacritty'\nexport	BROWSER='qutebrowser'\nexport	READER='zathura'\nexport	SHELL='zsh'\nexport	XDG_CURRENT_DESKTOP='bspwm'\n\n[[ ! -f ~/.config/zsh/alias.zsh ]] || source ~/.config/zsh/alias.zsh\n[[ ! -f ~/.config/zsh/vim-mode.zsh ]] || source ~/.config/zsh/vim-mode.zsh\n\n# autopair zsh\nif [[ ! -d ~/.config/zsh/zsh-autopair ]]; then\n\tgit clone https://github.com/hlissner/zsh-autopair ~/.config/zsh/zsh-autopair\nfi\n\nsource ~/.zsh-autopair/autopair.zsh\nautopair-init" >> $HOME/.zshrc

sed -i s'/plugins+=(git)/plugins+=(git extract universalarchive)/' $HOME/.zshrc
fi

sleep 1
echo "zsh configurado"

}

editordeTexto(){

 clear
 echo -e "configurando instalando e astrovim  \n ... \n .. \n ."
 sleep 1

 $_so neovim \
 python-pynvim

 if [ ! -d ~/.config/nvim ]; then
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  git clone https://github.com/quebravel/astronvim_config.git ~/.config/nvim/lua/user
  nvim  --headless -c 'quitall'
 else
  echo "existe um diretorio nvim"
  echo "Deseja re/instalar astronvim?"
  read -r -p "1) Sim   2) Não *) Pular ... " astronv
  case "$astronv" in
   1)
    rm -rf ~/.config/nvim/;
    git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
    git clone https://github.com/quebravel/astronvim_config.git ~/.config/nvim/lua/user
    nvim  --headless -c 'quitall'
   ;;
   2|*) echo "Simbora! ..."
   ;;
  esac 
 fi

}


zshinstall
fontes_doSistema
navegador
copilador_config
temas
audio_config
rangerfm
playermusica
ohmyzsh
alias_autopair
editordeTexto
