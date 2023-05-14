#!/bin/env bash

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
    echo "driver de video .... \n ... \n .. \n ."
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
    echo "windows manager .... \n ... \n .. \n ."
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
    echo "Pulou a instação do gerenciador de janelas." | tee -a ~/Notas.txt
	;;

[*])
	WMs='bspwm'
	WMx='sxhkd'
	WMb='polybar'
    echo "Instalando bspwm e sxhkd" | tee -a ~/Notas.txt
	;;
esac

# insalando window manger
sudo pacman -S --noconfirm --needed $WMs $WMx $WMb


    if [ -d ~/.config/$WMs ]; then
        echo "$WMs configuração detectada, backup..."
        rm --recursive --force ~/.config/$WMs/*;
        cp -r ./.config/$WMs/* ~/.config/$WMs;
    else
        echo "Instalado configuração $WMs ..."
        mkdir --parents ~/.config/$WMs && cp -r ./config/$WMs/* ~/.config/$WMs;
    fi
    if [ $WMx = "sxhkd" ]; then
        rm --recursive --force ~/.config/sxhkd/;
        mkdir -p ~/.config/sxhkd/;
        cp --recursive ./.config/sxhkd/* ~/.config/sxhkd;
        echo "Configuração keybinds do bspwm concluido."
    else 
        xmonad --recompile;
        echo "Concluido"
    fi
    if [ -d ~/.config/polybar ]; then
        rm --recursive --force ~/.config/polybar;
    else
        echo "[ok]"
    fi
    if [ $WMb = "polybar" ]; then
        echo "Configurando polybar..."
        mkdir -p ~/.config/polybar/;
        cp --recursive ./.config/polybar/* ~/.config/polybar/;
        echo "Configuração do polybar concluida"
    else
        echo "Polybar... [ok]"
    fi


} ### windowManger

gerenciardorAUR(){

    clear 
    echo "gerenciador AUR .... \n ... \n .. \n ."
    sleep 1

echo "Precisamos de um ajudante AUR. É essencial. [1] yay [2] paru"
read -r -p "Qual é o ajudante AUR de sua escolha? (default é yay): ... " num

if [ $num -eq 2 ]
then
    HELPER="paru"
fi

if ! command -v $HELPER &> /dev/null
then
    echo "Parece que você não tem $HELPER instalado, Vou instalá-lo para você antes de continuar."
	git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
	(cd ~/.srcs/$HELPER/ && makepkg -si )
fi


$HELPER -S --needed picom-jonaburg-git alacritty herbe-git xclip maim xdo mtools xdotool exa mpv feh xsel python-pynvim yt-dlp the_silver_searcher ntfs-3g xorg-{xsetroot,xset,xrdb} xf86-input-{evdev,libinput} curl zathura-pdf-poppler adwaita-icon-theme bpytop xcursor-vanilla-dmz-aa nodejs go cmake libxinerama libxft python-pip sxiv xdg-user-dirs ffmpeg redshift unclutter                               

echo "[s]im ou [n]ão"
read -r -p "Este computador é um notebook? ... " notebook

case $notebook in
    [s])
        $HELPER -S acpi iwd
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
    echo "lancador de programas .... \n ... \n .. \n ."
    sleep 1

mkdir -p ~/.config/

if [ -d ~/.srcs ]; then
    echo "pasta .srcs ... [ok]"
else
    echo "Criando pasta .srcs ... "
    mkdir -p ~/.srcs
    echo "pasta .srcs ... [ok]";
fi

    if [ -d ~/.srcs/dmenu2 ]; then
        echo "Detectar pasta para compilar dmenu2, deletar..."
        echo "ok"
        tar zxf ~/.srcs/dmenu2/dmenu2-0.2.1.tar.gz -C ~/.srcs/dmenu2  && cd ~/.srcs/dmenu2/dmenu2-0.2.1/ && sudo make clean install
        echo "dmenu2 [ok]"
    else
        echo "Baixando fonte do dmenu2... e instalando"
        sh -c "$(wget -O- https://raw.githubusercontent.com/quebravel/myscripts/master/script_dmenu2.sh)"
        echo "dmenu2 [ok]"
    fi
}

arquivosdeConfiguracao(){
    clear
    echo "Configurando programas ... \n ... \n .. \n ."
    sleep 1

    if [ -d ~/.config/picom ]; then
        echo "Picom configuração detectada, backup..."
        mkdir -p ~/.config/picom.old && cp ~/.config/picom/* ~/.config/picom.old/;
        cp ./.config/picom/* ~/.config/picom/;
    else
        echo "Installing picom configs..."
        mkdir -p ~/.config/picom/;
        cp ./.config/picom/* ~/.config/picom/;
    fi
    if [ -d ~/.config/alacritty ]; then
        echo "Alacritty configuração detectada, [ok] ..."
    else
        echo "Installando alacritty configurações..."
        mkdir -p ~/.config/alacritty/ && cp ./.config/alacritty/ ~/.config/alacritty/;
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

echo "\n\t .... feito."

} ### arquivosdeConfiguracao


# chamar funções
inicio
driveVideo
windowManger
gerenciardorAUR
lancadorProgramas
arquivosdeConfiguracao