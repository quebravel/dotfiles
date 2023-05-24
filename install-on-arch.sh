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

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel wget git

} ### inicio

driveVideo(){
# choose video driver
    clear
    echo -e "... driver de video \n ... \n .. \n ."
    sleep 1

echo "1) xf86-video-intel 	  2) xf86-video-amdgpu    3) nvidia    *) pular    c) cancelar"
read -r -p "Escolha o driver da sua placa de vídeo (default intel) ... " vid

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

[*])
	DRI=""
	echo "Pulou instalação do driver de video arriégua!" | tee -a ~/Notas.txt
	;;
[c])
	DRI=""
	echo "Pulou instalação do driver de video aperiado!" | tee -a ~/Notas.txt	
	;;
esac

# install xorg if not installed
sudo pacman -S --noconfirm --needed feh xorg xorg-xinit xorg-xinput $DRI

if [ $DRI = "xf86-video-amdgpu" ]; then
    sudo pacman -S --noconfirm --needed vulkan-radeon # driver open-source (melhor)
    sudo cp ./xorg_conf/40-amdgpu.conf /usr/share/X11/xorg.conf.d/
elif [ $DRI = "xf86-video-intel" ]; then
    sudo pacman -S --noconfirm --needed vulkan-intel # driver open-source (melhor)
    sudo cp ./xorg_conf/20-intel.conf /usr/share/X11/xorg.conf.d/
fi

} ### driveVideo

windowManger(){
    clear
    echo -e "... windows manager \n ... \n .. \n ."
    sleep 1

echo "
 +---------------------+
 |           |         |      bspwm
 |           |    2    |        ou
 |     1     |         |      xmonad
 |           |---------|      ...
 |           |    3    |
 +---------------------+
"

    echo " 1) bspwm    2) xmonad    3) cancelar   *) pular"
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
    echo "... bspwm e sxhkd" | tee -a ~/Notas.txt
	;;
esac

# teste para saber se a variavel esta vazia
if [ -z $WMs ]; then
    echo ""
    echo "Pulou a instação do gerenciador de janelas, arrudia!." | tee -a ~/Notas.txt
else
    # insalando window manger
    sudo pacman -S --noconfirm --needed $WMs $WMx $WMb
fi


    if [ -z $WMs ]; then
        echo ""
    elif [ -d ~/.config/$WMs ]; then
        echo "$WMs configuração detectada, backup..."
        rm --recursive --force ~/.config/$WMs
        cp -r ./.config/$WMs ~/.config/
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
        echo "... Abirobado!"
    fi
    if [ $WMs = "bspwm" ]; then
        echo -e '#!/bin/bash\n\nuserresources=$HOME/.Xresources\nsysresources=/etc/X11/xinit/.Xresources\n\n# merge in defaults\n\nif [ -f $sysresources ]; then\n    xrdb -merge $sysresources\nfi\n\nif [ -f "$userresources" ]; then\n    xrdb -merge "$userresources"\nfi\n\n[ -f ~/.Xdefaults ] && xrdb -merge ~/.Xdefaults\n\nxsetroot -cursor_name left_ptr &\n\n# feh --bg-tile ~/Imagens/wallpaperz.png\n$HOME/.fehbg\n# $HOME/trigger_custom_refresh.sh &\n# wal -R\n\n# export MPD_HOST=$HOME/.config/mpd/socket\n# mpd --kill; mpd &\nunclutter --timeout 7 &\n\n# Set up an icon tray\n# trayer --edge top --align right --SetDockType true --SetPartialStrut true \ \n# --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &\n\nif [ "$(command -v xset)" >/dev/null 2>&1 ];\nthen\n    #xset s off      	        #Disable screen saver blanking\n    #xset s 3600 3600 	        #Change blank time to 1 hour\n    #xset -dpms 	            #Turn off DPMS\n    xset s off -dpms 	        #Disable DPMS and prevent screen from blanking\n    #xset dpms force off 	    #Turn off screen immediately\n    #xset dpms force standby 	#Standby screen\n    #xset dpms force suspend 	#Suspend screen\nfi\n\n# numlockx &\n# pulseaudio -k\n# pulseaudio &\n\nsxhkd &\nexec bspwm\n\n# exec xmonad\n\n#vim:ft=sh' > ~/.xinitrc
    elif [ $WMs = "xmonad" ]; then 
        echo -e '#!/bin/bash\n\nuserresources=$HOME/.Xresources\nsysresources=/etc/X11/xinit/.Xresources\n\n# merge in defaults\n\nif [ -f $sysresources ]; then\n    xrdb -merge $sysresources\nfi\n\nif [ -f "$userresources" ]; then\n    xrdb -merge "$userresources"\nfi\n\n[ -f ~/.Xdefaults ] && xrdb -merge ~/.Xdefaults\n\nxsetroot -cursor_name left_ptr &\n\n# feh --bg-tile ~/Imagens/wallpaperz.png\n$HOME/.fehbg\n# $HOME/trigger_custom_refresh.sh &\n# wal -R\n\n# export MPD_HOST=$HOME/.config/mpd/socket\n# mpd --kill; mpd &\nunclutter --timeout 7 &\n\n# Set up an icon tray\n# trayer --edge top --align right --SetDockType true --SetPartialStrut true \ \n# --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &\n\nif [ "$(command -v xset)" >/dev/null 2>&1 ];\nthen\n    #xset s off      	        #Disable screen saver blanking\n    #xset s 3600 3600 	        #Change blank time to 1 hour\n    #xset -dpms 	            #Turn off DPMS\n    xset s off -dpms 	        #Disable DPMS and prevent screen from blanking\n    #xset dpms force off 	    #Turn off screen immediately\n    #xset dpms force standby 	#Standby screen\n    #xset dpms force suspend 	#Suspend screen\nfi\n\n# numlockx &\n# pulseaudio -k\n# pulseaudio &\n\n# sxhkd &\n# exec bspwm\n\nexec xmonad\n\n#vim:ft=sh' > ~/.xinitrc
    else
        echo "window manager não definido cabra!"
    fi


} ### windowManger

gerenciardorAUR(){

    clear 
    echo -e "... gerenciador AUR \n ... \n .. \n ."
    sleep 1

    echo "Precisamos de um ajudante AUR. É essencial. 1) paru 2) yay *) default"
    read -r -p "Qual é o ajudante AUR de sua escolha? (default é paru): ... " num

case $num in
    [1])
        HELPER="paru"
        ;;
    [2])
        HELPER="yay"
        ;;
    [*])
        HELPER="paru"
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
siji-git \
ly-git \
cmatrix

}

notebook_ger(){

    clear
    echo -e "... para notebooks \n ... \n .. \n ."
    sleep 1

echo "
__________
|         |      caso seja um notebook (laptop)
| laptop  |      sera instalado acpi acpid e iwd
| ________|      ...
 \:::::::::\ 
  \= _____;=\\
"

echo "1) sim    2) não *) pular"
read -r -p "Este computador é um notebook? ... " notebook

case $notebook in
    [1])
        $HELPER -S acpi acpid iwd
        sudo systemctl enable iwd.service
        sudo systemctl enable acpid.service
        ;;
    [2])
        echo "Miolo de pote!"
        ;;
    [*])
        echo "Nem fresque não!"
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
        mkdir -p ~/.srcs
        echo ""
        echo "1) installar    2) remover    *) pular"
        read -r -p "Instalar ou remover dmenu2? ... " dm2
    
        case $dm2 in
          [1])
              if [ -d ~/.srcs/dmenu2-1 ]; then
                echo "Detectado pasta para compilar dmenu2, instalando..."
                echo "[ok]"
                tar zxf ~/.srcs/dmenu2-1/dmenu2-0.2.1.tar.gz -C ~/.srcs/dmenu2-1/ && cd ~/.srcs/dmenu2-1/dmenu2-0.2.1/ && sudo make clean install
              else 
                echo "Clonando dmenu2..."
                git -C ~/.srcs clone https://github.com/quebravel/dmenu2-1.git
                echo -e "Instalando dmenu2..."
                tar zxf ~/.srcs/dmenu2-1/dmenu2-0.2.1.tar.gz -C ~/.srcs/dmenu2-1/  && cd ~/.srcs/dmenu2-1/dmenu2-0.2.1/ && sudo make clean install
                echo "[ok]"
              fi
    
              cd ~/
              echo "dmenu2 instalado [ok]"
              ;;
          [2])
              echo "Removendo dmenu2..."
              cd ~/.srcs/dmenu2-1/dmenu2-0.2.1
              sudo make uninstall
              sudo make clean
              cd ~/
              echo "dmenu2 removido [ok]"
              ;;
          [*])
              echo "sem dmenu"
        esac
        echo "dmenu2 [ok]"
    fi

}

arquivosdeConfiguracao(){
    clear
    echo -e "Configurando programas \n ... \n .. \n ."
    sleep 1

    if [ -d ~/.config/picom ]; then
        echo "Picom configuração detectada..."
        rm --recursive --force ~/.config/picom/;
        echo "Installing picom configs..."
        cp -r ./.config/picom ~/.config/;
    else
        echo "Installing picom configs..."
        cp -r ./.config/picom ~/.config/;
    fi
    if [ -d ~/.config/alacritty ]; then
        echo "Alacritty configuração detectada, [ok] ..."
    else
        echo "Installando alacritty configurações..."
        mkdir -p ~/.config/alacritty/;
        cp --recursive ./.config/alacritty ~/.config/;
    fi
    # if [ -d ~/wallpapers ]; then
    #     echo "Adicionando wallpaper para ~/wallpapers..."
    #     cp ./wallpapers/* ~/wallpapers/;
    # else
    #     echo "Installing wallpaper..."
    #     mkdir ~/wallpapers && cp -r ./wallpapers/* ~/wallpapers/;
    # fi
    
} ### arquivosdeConfiguracao

ly_config(){

 clear
 echo -e "... ly  \n ... \n .. \n ."
 sleep 1

echo "
+----------------------+
|                      |
|        _______       |  ly (display)
|       | login |      |     (manager)    
|       +-------+      |     ...
|                      |
+----------------------+
"

 echo "1) sim    2) nao    *) pular ... " 
 read -r -p "Deseja instalar um <Display Manager> (Ly)? ... " dmgr 

    case "$dmgr" in
    1)
    # cominho do arquivo de configuração
    arquivo="/etc/ly/config.ini"
    sd="sudo"

    if [ -f $arquivo ]; then
        # abilitando opções 
        $sd sed -i 's/#animate = false/animate = true/g' $arquivo
        $sd sed -i 's/#animation = 0/animation = 1/g' $arquivo
        $sd sed -i 's/#xinitrc \= \~\/.xinitrc/xinitrc \= \~\/.xinitrc/g' $arquivo
        # transformando arquivo xinitrc em executavel bash
        chmod +x ~/.xinitrc
        $sd systemctl enable ly.service
        sleep 1
        echo -e "\n\t .... feito."
    else
        echo "não existe o arquivo de configuracao"
    fi
    ;;
    2|*) echo "Diabeisso!"
    ;;
    esac


} ### ly_config


# chamar funções
inicio
driveVideo
windowManger
gerenciardorAUR
notebook_ger
lancadorProgramas
arquivosdeConfiguracao
ly_config

# acha outro arquivo
chmod +x ./install-2-arch.sh
sh ./install-2-arch.sh
