#\n!/bin/env bash

# fork script of https://github.com/Axarva/dotfiles-2.0/tree/main

inicio(){
set -e

echo "Bem vindo!" && sleep 1

# Default vars
HELPER="yay"

# Default past github dotfiles
GITFILES="dotfiles-conf"

# does full system update
echo "Fazendo uma atualização do sistema, pode acontecer que coisas quebrem se não for a versão mais recente..."
sudo pacman --noconfirm -Syu

echo "###########################################################################"
echo "Vamos, prepare-se"
echo "###########################################################################"

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel wget git

} ### inicio

driveVideo(){
# choose video driver
    clear
    echo -e "driver de video \n ... \n .. \n ."
    sleep 1

echo "[1] xf86-video-intel 	[2] xf86-video-amdgpu    [3] nvidia   [4] Pular"
read -r -p "Escolha o driver da sua placa de vídeo (default 1) (não será reinstalado): ... " vid

case $vid in 
[1])
	DRI='xf86-video-intel'
	;;

[2])
	DRI='xf86-video-amdgpu'
	;;

[3])
    DRI='nvidia nvidia-settings nvidia-utils'
    ;;

[4])
	DRI=""
	echo "Pulou instalação do driver de video" | tee -a ~/Notas.txt
	;;
[*])
	DRI=""
	echo "Pulou instalação do driver de video" | tee -a ~/Notas.txt	
	;;
esac

# install xorg if not installed
sudo pacman -S --noconfirm --needed feh xorg xorg-xinit xorg-xinput $DRI

} ### driveVideo

windowManger(){
    clear
    echo -e "windows manager \n ... \n .. \n ."
    sleep 1

echo " [1] bspwm    [2] xmonad    [3] Pular"
read -r -p "Qual gerenciador de janelas (window manager) vai ser desta vez... (default é bspwm) ... " wme

case $wme in 
[1])
	WMs='bspwm'
	WMx='sxhkd'
	WMb='polybar'
	;;

[2])
	WMs='xmonad'
	WMx='xmonad-contrib'
	WMb='xmobar'
	;;

[3])
	WMs=""
	WMx=""
	WMb=""
	;;

[*])
	WMs='bspwm'
	WMx='sxhkd'
	WMb='polybar'
    echo "Instalando bspwm e sxhkd" | tee -a ~/Notas.txt
	;;
esac

# teste para saber se a variavel esta vazia
if [ -z $WMs ]; then
    echo ""
    echo "Pulou a instação do gerenciador de janelas." | tee -a ~/Notas.txt
else
    # insalando window manger
    sudo pacman -S --noconfirm --needed $WMs $WMx $WMb
fi


    if [ -z $WMs ]; then
        echo ""
    elif [ -d ~/.config/$WMs ]; then
        echo "$WMs configuração detectada, backup..."
        rm --recursive --force ~/.config/$WMs
        cp -r ./.config/$WMs/ ~/.config/
    else
        echo "Instalado configuração $WMs ..."
        mkdir -p ~/.config/$WMs
        cp -r ./.config/$WMs/* ~/.config/$WMs/
    fi
    if [ $WMx = "sxhkd" ]; then
        rm --recursive --force ~/.config/sxhkd/;
        mkdir -p ~/.config/sxhkd/;
        cp --recursive ./.config/sxhkd/* ~/.config/sxhkd;
        echo "Configuração keybinds do bspwm concluido."
    else 
        echo ""
    fi
    # if [ -d ~/.config/polybar ]; then
    #     rm --recursive --force ~/.config/polybar;
    #     cp --recursive ./.config/polybar ~/.config/polybar;
    # else
    #     cp --recursive ./.config/polybar ~/.config/polybar;
    #     echo "[ok]"
    # fi
    if [ $WMb = "polybar" ]; then
        echo "Configurando polybar..."
        rm --recursive --force ~/.config/polybar;
        mkdir -p ~/.config/polybar/;
        cp --recursive ./.config/polybar/* ~/.config/polybar/;
        echo "Configuração do polybar concluida"
    else
        echo "... [ok]"
    fi
    if [ $WMs = "bspwm" ]; then
        echo -e '#!/bin/bash\n\nuserresources=$HOME/.Xresources\nsysresources=/etc/X11/xinit/.Xresources\n\n# merge in defaults\n\nif [ -f $sysresources ]; then\n    xrdb -merge $sysresources\nfi\n\nif [ -f "$userresources" ]; then\n    xrdb -merge "$userresources"\nfi\n\n[ -f ~/.Xdefaults ] && xrdb -merge ~/.Xdefaults\n\nxsetroot -cursor_name left_ptr &\n\n# feh --bg-tile ~/Imagens/wallpaperz.png\n$HOME/.fehbg\n# $HOME/trigger_custom_refresh.sh &\n# wal -R\n\n# export MPD_HOST=$HOME/.config/mpd/socket\n# mpd --kill; mpd &\nunclutter --timeout 7 &\n\n# Set up an icon tray\n# trayer --edge top --align right --SetDockType true --SetPartialStrut true \ \n# --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &\n\nif [ "$(command -v xset)" >/dev/null 2>&1 ];\nthen\n    #xset s off      	        #Disable screen saver blanking\n    #xset s 3600 3600 	        #Change blank time to 1 hour\n    #xset -dpms 	            #Turn off DPMS\n    xset s off -dpms 	        #Disable DPMS and prevent screen from blanking\n    #xset dpms force off 	    #Turn off screen immediately\n    #xset dpms force standby 	#Standby screen\n    #xset dpms force suspend 	#Suspend screen\nfi\n\n# numlockx &\n# pulseaudio -k\n# pulseaudio &\n\nsxhkd &\nexec bspwm\n\n# exec xmonad\n\n#vim:ft=sh' > ~/.xinitrc
    elif [ $WMs = "xmonad" ]; then 
        echo -e '#!/bin/bash\n\nuserresources=$HOME/.Xresources\nsysresources=/etc/X11/xinit/.Xresources\n\n# merge in defaults\n\nif [ -f $sysresources ]; then\n    xrdb -merge $sysresources\nfi\n\nif [ -f "$userresources" ]; then\n    xrdb -merge "$userresources"\nfi\n\n[ -f ~/.Xdefaults ] && xrdb -merge ~/.Xdefaults\n\nxsetroot -cursor_name left_ptr &\n\n# feh --bg-tile ~/Imagens/wallpaperz.png\n$HOME/.fehbg\n# $HOME/trigger_custom_refresh.sh &\n# wal -R\n\n# export MPD_HOST=$HOME/.config/mpd/socket\n# mpd --kill; mpd &\nunclutter --timeout 7 &\n\n# Set up an icon tray\n# trayer --edge top --align right --SetDockType true --SetPartialStrut true \ \n# --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &\n\nif [ "$(command -v xset)" >/dev/null 2>&1 ];\nthen\n    #xset s off      	        #Disable screen saver blanking\n    #xset s 3600 3600 	        #Change blank time to 1 hour\n    #xset -dpms 	            #Turn off DPMS\n    xset s off -dpms 	        #Disable DPMS and prevent screen from blanking\n    #xset dpms force off 	    #Turn off screen immediately\n    #xset dpms force standby 	#Standby screen\n    #xset dpms force suspend 	#Suspend screen\nfi\n\n# numlockx &\n# pulseaudio -k\n# pulseaudio &\n\n# sxhkd &\n# exec bspwm\n\nexec xmonad\n\n#vim:ft=sh' > ~/.xinitrc
    else
        echo "window manager não definido"
    fi


} ### windowManger

gerenciardorAUR(){

    clear 
    echo -e "gerenciador AUR \n ... \n .. \n ."
    sleep 1

echo "Precisamos de um ajudante AUR. É essencial. [1] yay [2] paru"
read -r -p "Qual é o ajudante AUR de sua escolha? (default é yay): ... " num

case $num in
    [1])
        HELPER="yay"
        ;;
    [2])
        HELPER="paru"
        ;;
    [*])
        HELPER="yay"
        ;;
esac

# if ! command -v $HELPER &> /dev/null
if [[ -e "/sbin/yay" || -e "/sbin/paru" ]]; then
    echo "Ajudante AUR já instalado"
elif [ -d ~/.srcs/$HELPER ]; then
    echo "Parece que você não tem um gerenciador AUR instalado, Vou instalar o $HELPER para você antes de continuar."
	(cd ~/.srcs/$HELPER/ && makepkg -si )
else
    echo "Parece que você não tem um gerenciador AUR instalado, Vou instalar o $HELPER para você antes de continuar."
	git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
	(cd ~/.srcs/$HELPER/ && makepkg -si )
fi


$HELPER -S --needed \
picom-jonaburg-git \
alacritty \
herbe-git \
xclip \
maim \
xdo \
mtools \
xdotool \
exa \
mpv \
feh \
xsel \
python-pynvim \
yt-dlp \
the_silver_searcher \
ntfs-3g \
xorg-{xsetroot,xset,xrdb} \
xf86-input-{evdev,libinput} \
curl \
zathura-pdf-poppler \
adwaita-icon-theme \
bpytop \
xcursor-vanilla-dmz-aa \
nodejs \
go \
cmake \
libxinerama \
libxft \
python-pip \
sxiv \
xdg-user-dirs \
ffmpeg \
redshift \
unclutter \
ttf-jetbrains-mono-nerd \
siji-git                              

clear

echo "[s]im ou [n]ão"
read -r -p "Este computador é um notebook? ... " notebook

case $notebook in
    [s])
        $HELPER -S acpi acpid iwd
        ;;
     [n])
        echo "[ok]"
        ;;
    [*])
        echo "[ok]"
        ;;
esac

clear
}

lancadorProgramas(){

    clear
    echo -e "lancador de programas \n ... \n .. \n ."
    sleep 1

mkdir -p ~/.config/

if [ -d ~/.srcs ]; then
    echo "pasta .srcs ... [ok]"
else
    echo "Criando pasta .srcs ... "
    mkdir -p ~/.srcs
    echo "pasta .srcs ... [ok]";
fi

if [ -e "/usr/local/bin/dmenu_run" ]; then 
    echo "... dmenu já instalado."
    elif [ -d ~/.srcs/dmenu2 ]; then
        echo "Detectar pasta para compilar dmenu2, deletar..."
        echo "ok"
        tar zxf ~/.srcs/dmenu2/dmenu2-0.2.1.tar.gz -C ~/.srcs/dmenu2  && cd ~/.srcs/dmenu2/dmenu2-0.2.1/ && sudo make clean install && cd
        echo "dmenu2 [ok]"
    else
        echo "Baixando fonte do dmenu2... e instalando"
        sh -c "$(wget -O- https://raw.githubusercontent.com/quebravel/myscripts/master/script_dmenu2.sh)"
        echo "dmenu2 [ok]"
    fi

}

arquivosdeConfiguracao(){
    clear
    echo -e "Configurando programas \n ... \n .. \n ."
    sleep 1

    if [ -d ~/.config/picom ]; then
        echo "Picom configuração detectada, backup..."
        rm --recursive --force ~/.config/picom/;
        echo "Installing picom configs..."
        cp -r ./.config/picom/ ~/.config/;
    else
        echo "Installing picom configs..."
        cp -r ./.config/picom/ ~/.config/;
    fi
    if [ -d ~/.config/alacritty ]; then
        echo "Alacritty configuração detectada, [ok] ..."
    else
        echo "Installando alacritty configurações..."
        mkdir -p ~/.config/alacritty/ && cp --recursive ./.config/alacritty/ ~/.config/alacritty/;
    fi
    if [ -d ~/wallpapers ]; then
        echo "Adicionando wallpaper para ~/wallpapers..."
        cp ./wallpapers/* ~/wallpapers/;
    else
        echo "Installing wallpaper..."
        mkdir ~/wallpapers && cp -r ./wallpapers/* ~/wallpapers/;
    fi
    

# feito 

sleep 1

echo -e "\n\t .... feito."

} ### arquivosdeConfiguracao


# chamar funções
inicio
driveVideo
windowManger
gerenciardorAUR
lancadorProgramas
arquivosdeConfiguracao
