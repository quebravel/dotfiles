#\n!/bin/env bash

# fork script of https://github.com/Axarva/dotfiles-2.0/tree/main

# porte 1
inicio(){
set -e

clear

cat <<EOL
                    Bem vindo!......................................
                    Este instalador e configurador foi feito como um
                    projeto pessoal para fazer uma instalação rapida
                    e  precisa  das  minhas configurações prediletas
                    dos principais programas que utilizo em meu arch
                    linux.

                    Por  favor  sinta-se  a  vontade para utilizar e
                    modificar  de  acordo  com  suas preferencias de
                    configuração.

                    Para utilizar este  script você deve esta logado 
                    como  um usuario não  root  para que  as  pastas  
                    sejas  enviadas  para o  local  correto.........
EOL

sleep 1.2

echo "Esta pronto para continuar?"
read -r -p "1)_Sim    2)_Nao ... " CONTINUAR
case "$CONTINUAR" in
    1) echo "Vamos lá ... "
    ;;
    2) exit 1
    ;;
    *) inicio
    ;;
esac

# Default vars
HELPER="paru"

# Default past github dotfiles
# GITFILES="dotfiles-conf"

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
    sleep 0.2

cat <<DRIVERDESENHO
.__________________________________.
| .________.                    |O||
| |        |..............,     |O||
| |        | PLACA VIDEO  |     |00|
| |________|..............|     |U0|
|_______________________________|__|


DRIVERDESENHO

echo " 1)_xf86-video-intel    2)_xf86-video-amdgpu    3)_nvidia    P)_Pular"
echo -e " \033[44;1;37m Escolha o driver da sua placa de vídeo. \033[0m "
read -r -p "-> ... " vid

case $vid in 
1)
	DRI='xf86-video-intel'
	;;

2)
	DRI='xf86-video-amdgpu'
	;;

3)
    DRI='xf86-video-nvidia'
    ;;

P|p)
	DRI=""
	echo "Pulou instalação do driver de video arriégua!" | tee -a ~/Notas.txt
	;;
*) driveVideo

	;;
esac

# install xorg if not installed
sudo pacman -S --noconfirm --needed xorg-server xorg-xinit xorg-xinput $DRI

# complemetos para os drivers
if [ $DRI = "xf86-video-amdgpu" ]; then
    sudo pacman -S --noconfirm --needed mesa-libgl mesa-vdpau libvdpau-va-gl vulkan-radeon # driver open-source (melhor)
    sudo cp ./xorg_conf/40-amdgpu.conf /usr/share/X11/xorg.conf.d/
fi
if [ $DRI = "xf86-video-intel" ]; then
    sudo pacman -S --noconfirm --needed mesa-libgl libvdpau-va-gl vulkan-intel # driver open-source (melhor)
    sudo cp ./xorg_conf/20-intel.conf /usr/share/X11/xorg.conf.d/
fi
if [ $DRI = "xf86-video-nvidia" ]; then
    sudo pacman -S --noconfirm --needed nvidia-utils libglvnd nvidia-settings lib32-nvidia-utils nvidia-dkms
    nvidia-xconfig --add-argb-glx-visuals --allow-glx-with-composite --composite --render-accel -o /usr/share/X11/xorg.conf.d/20-nvidia.conf
fi

# adicionando modulos
# if [ "$(ls /boot | grep hardened -c)" -gt "0" ]; then
# 	mkinitcpio -p linux-hardened
# elif [ "$(ls /boot | grep lts -c)" -gt "0" ]; then
# 	mkinitcpio -p linux-lts
# elif [ "$(ls /boot | grep zen -c)" -gt "0" ]; then
# 	mkinitcpio -p linux-zen
# else
# 	mkinitcpio -p linux
# fi


} ### driveVideo

windowManger(){
    clear
    echo -e "... windows manager \n ... \n .. \n ."
    sleep 0.2

echo "
 +---------------------+
 |           |         |      bspwm
 |           |    2    |        ou
 |     1     |         |      xmonad
 |           |---------|      ...
 |           |    3    |
 +---------------------+
"

echo " 1)_Bspwm    2)_Xmonad    P)_Pular"
echo -e " \033[44;1;37m Qual gerenciador de janelas (window manager) vai ser desta vez \033[0m "
echo " (Padrao: bspwm)"
read -r -p "-> ... " wme

case $wme in 
1)
	WMs='bspwm'
	WMx='sxhkd'
	WMb='polybar'
	;;

2)
	WMs='xmonad'
	WMx='xmonad-contrib'
	WMb='xmobar'
	;;

P|p)
	WMs='bspwm'
	WMx='sxhkd'
	WMb='polybar'
	;;

*) windowManger
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
    sleep 0.2

    echo " Precisamos de um ajudante AUR. É essencial. 1)_Paru    2)_Yay    *)_Padrao"
    echo -e " \033[44;1;37m Qual é o ajudante AUR de sua escolha? \033[0m "
    echo " (Padrao: paru)"
    read -r -p "-> ... " num

case $num in
    1)
        HELPER="paru"
        ;;
    2)
        HELPER="yay"
        ;;
    *)
        HELPER="paru"
        ;;
esac

if [[ -e "/sbin/$HELPER" ]]; then 
    echo "Ajudante AUR já instalado"
elif [ -d ~/.srcs/$HELPER ]; then
    echo "Parece que você não tem um gerenciador AUR instalado, Vou instalar o $HELPER para você antes de continuar."
	(cd ~/.srcs/$HELPER/ && makepkg -si )
else
    echo "Parece que você não tem um gerenciador AUR instalado, Vou instalar o $HELPER para você antes de continuar."
	git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
	(cd ~/.srcs/$HELPER/ && makepkg -si )
fi

if [[ $HELPER = "paru" ]]; then
    sudo sed -i 's/#BottomUp/BottomUp/g' /etc/paru.conf
fi

$HELPER -S --needed --noconfirm \
alacritty \
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
ntfs-3g \
xorg-{xsetroot,xset,xrdb} \
xf86-input-{evdev,libinput} \
zathura-pdf-poppler \
adwaita-icon-theme \
xcursor-vanilla-dmz-aa \
cmake \
libxinerama \
libxft \
sxiv \
xdg-user-dirs \
ffmpeg \
redshift \
unclutter \
polkit \
# nodejs \
# herbe-git \
# python-pip \
# bpytop \
# curl \
# the_silver_searcher \

if [ ! -f /bin/picom ]; then
$HELPER -S --needed --noconfirm \
picom-jonaburg-git 
fi

}

notebook_ger(){

    clear
    echo -e "... para notebooks \n ... \n .. \n ."
    sleep 0.2

echo "
__________
|         |      caso seja um notebook (laptop)
| laptop  |      sera instalado acpi acpid e iwd
| ________|      ...
 \:::::::::\ 
  \= _____;=\\
"

echo " 1)_Sim    2)_Nao"
echo -e " \033[44;1;37m Este computador é um notebook? \033[0m "
read -r -p "-> ... " notebook

case $notebook in
    1)
        $HELPER -S --needed --noconfirm acpi acpid
        sudo systemctl enable acpid.service
        ;;
    2)
        echo "Miolo de pote!"
        ;;
    *) notebook_ger
        ;;
esac

clear
}

lancadorProgramas(){

    clear
    echo -e "lancador de programas Dmenu2 \n ... \n .. \n ."
    sleep 0.2

cat << DMENUDESENHO
   .____________________________________________________________________.
   |_dmenu2_[_________________]_[_2to3_2to3-3.11_411toppm_4channels_a2x_|
DMENUDESENHO

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
        (tar zxf ~/.srcs/dmenu2/dmenu2-0.2.1.tar.gz -C ~/.srcs/dmenu2  && cd ~/.srcs/dmenu2/dmenu2-0.2.1/ && sudo make clean install)
        echo "dmenu2 [ok]"
    else
        mkdir -p ~/.srcs
        echo ""
        echo " 1)_Installar    2)_Remover"
        echo -e " \033[44;1;37m Instalar ou remover dmenu2? \033[0m "
        read -r -p "-> ... " dm2
    
        case $dm2 in
          1)
              if [ -d ~/.srcs/dmenu2-1 ]; then
                echo "Detectado pasta para compilar dmenu2, instalando..."
                echo "[ok]"
                (tar zxf ~/.srcs/dmenu2-1/dmenu2-0.2.1.tar.gz -C ~/.srcs/dmenu2-1/ && cd ~/.srcs/dmenu2-1/dmenu2-0.2.1/ && sudo make clean install)
              else 
                echo "Clonando dmenu2..."
                git -C ~/.srcs clone https://github.com/quebravel/dmenu2-1.git
                echo -e "Instalando dmenu2..."
                (tar zxf ~/.srcs/dmenu2-1/dmenu2-0.2.1.tar.gz -C ~/.srcs/dmenu2-1/  && cd ~/.srcs/dmenu2-1/dmenu2-0.2.1/ && sudo make clean install)
                echo "[ok]"
              fi
              echo "dmenu2 instalado [ok]"
              ;;
          2)
              echo "Removendo dmenu2..."
              (cd ~/.srcs/dmenu2-1/dmenu2-0.2.1 && sudo make uninstall && sudo make clean)
              echo "dmenu2 removido [ok]"
              ;;
          *) lancadorProgramas
              echo "sem dmenu"
        esac
        echo "dmenu2 [ok]"
    fi

}

arquivosdeConfiguracao(){
    clear
    echo -e "Configurando programas \n ... \n .. \n ."
    sleep 0.2

    if [ ! -d ~/.config/picom ]; then
        mkdir --parents ~/.config/picom/;
        cp --force ./.config/picom/* ~/.config/picom/;
    else
        rm --recursive --force ~/.config/picom/;
        mkdir --parents ~/.config/picom/;
        cp --force ./.config/picom/* ~/.config/picom/;
    fi

    if [ ! -d ~/.config/alacritty ]; then
        mkdir -p ~/.config/alacritty/;
        cp --recursive --force ./.config/alacritty ~/.config/;
    else
        rm --recursive --force ~/.config/alacritty/;
        cp --recursive --force ./.config/alacritty ~/.config/;
    fi
    # if [ -d ~/wallpapers ]; then
    #     echo "Adicionando wallpaper para ~/wallpapers..."
    #     cp ./wallpapers/* ~/wallpapers/;
    # else
    #     echo "Installing wallpaper..."
    #     mkdir ~/wallpapers && cp -r ./wallpapers/* ~/wallpapers/;
    # fi
    if [ ! -d ~/.config/mpv ]; then
        mkdir --parents ~/.config/mpv;
        cp ./.config/mpv/* ~/.config/mpv/;
    else
        rm --recursive --force ~/.config/mpv/*
        cp --recursive --force ./.config/mpv/* ~/.config/mpv/;
    fi

    if [ ! -d ~/.config/zathura ]; then
        mkdir --parents ~/.config/zathura/;
        cp ./.config/zathura/zathurarc ~/.config/zathura/;
    else
        rm --force ~/.config/zathura/zathurarc;
        cp ./.config/zathura/zathurarc ~/.config/zathura/;
    fi

    if [ ! -d ~/.config/sxiv ]; then
        mkdir --parents ~/.config/sxiv/;
        cp --recursive --force ./.config/sxiv/* ~/.config/sxiv/;
    else
        rm --recursive --force  ~/.config/sxiv/;
        cp --recursive --force ./.config/sxiv/* ~/.config/;
    fi

    if [ ! -d ~/.config/redshift ]; then
        mkdir --parents ~/.config/redshift/;
        cp --recursive --force ./.config/redshift/* ~/.config/redshift/;
    else
        rm --recursive --force  ~/.config/redshift/;
        cp --recursive --force ./.config/redshift/ ~/.config/;
    fi
        
    
} ### arquivosdeConfiguracao

ly_config(){

 clear
 echo -e "... ly  \n ... \n .. \n ."
 sleep 0.2

echo "
+----------------------+
|                      |
|        _______       |  ly (display)
|       | login |      |     (manager)    
|       +-------+      |     ...
|                      |
+----------------------+
"

 echo " 1)_Sim    2)_Nao" 
 echo -e " \033[44;1;37m Deseja instalar um <Display Manager> (Ly)? \033[0m "
 read -r -p "-> ... " dmgr 

    case "$dmgr" in
    1)
    $HELPER -S --needed --noconfirm ly-git cmatrix
    # cominho do arquivo de configuração
    arquivo="/etc/ly/config.ini"

    if [ -f $arquivo ]; then
        # abilitando opções 
        sudo sed -i 's/#animate = false/animate = true/g' $arquivo
        sudo sed -i 's/#animation = 0/animation = 1/g' $arquivo
        sudo sed -i 's/#xinitrc \= \~\/.xinitrc/xinitrc \= \~\/.xinitrc/g' $arquivo
        # transformando arquivo xinitrc em executavel bash
        chmod +x ~/.xinitrc
        sudo systemctl enable ly.service
        sleep 0.2
        echo -e "\n\t .... feito."
    else
        echo "não existe o arquivo de configuracao"
    fi
    ;;
    2) echo "Diabeisso!"
    ;;
    *) ly_config
    ;;
    esac


} ### ly_config

# parte 2
_so="sudo pacman -S --needed --noconfirm"
_s="sudo"

playermusica(){

 clear
 echo -e "... configurando ncmpcpp . mpd . mpc \n ... \n .. \n ."
 sleep 0.2

 echo " 1)_Ncmpcpp    2)_Nao"
echo -e " \033[44;1;37m Quer instalar o player de música? \033[0m "
read -r -p "-> ... " plmc
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

$_s systemctl enable mpd.service

$_s systemctl start mpd.service

touch ~/.config/mpd/socket

sed -i 's/\# export MPD_HOST\=\$HOME\/.config\/mpd\/socket/export MPD_HOST\=\$HOME\/.config\/mpd\/socket/g' $HOME/.xinitrc

sed -i 's/# mpd --kill; mpd \&/mpd --kill; mpd \&/g' $HOME/.xinitrc

export MPD_HOST=$HOME/.config/mpd/socket

echo 'mpd . mpc . ncmpcpp ... instalados'

echo 'reinicie o systema ... reboot'

 ;;
 2) echo "Oxente!!!"
 ;;
 *) playermusica
 ;;
esac

}

rangerfm(){

 clear
 echo -e "... ranger . ueberzug . ffmpegthumbnailer \n ... \n .. \n ."
 sleep 0.2

echo " 1)_Ranger    2)_Nao"
echo -e " \033[44;1;37m Quer uma gerenciador de arquivos para terminal? \033[0m "
read -r -p "-> ... " rag

case "$rag" in
 1) FILEMANAGER='RANGER'
 ;;
 2) echo "Beleza"
 ;;
 *) rangerfm
 ;;
esac

if [ $FILEMANAGER = RANGER ]; then

 $_so \
 ranger \
 ueberzug \
 ffmpegthumbnailer

    if [ ! -d ~/.config/ranger/ ]; then
     mkdir --parents ~/.config/ranger/;
    fi
    if [ -f ~/.config/ranger/rc.conf ]; then
     echo "arquivo rc.conf ... [ok]"
    else
     ranger --copy-config=rc
     sleep 0.2
     sed -i 's/set preview_images false/set preview_images true/g' $HOME/.config/ranger/rc.conf
     sleep 0.2
     sed -i 's/set draw_borders none/set draw_borders both/g' $HOME/.config/ranger/rc.conf
     sleep 0.2
     sed -i 's/set preview_images_method w3m/set preview_images_method ueberzug/g' $HOME/.config/ranger/rc.conf
     sleep 0.2
     sed -i 's/#set preview_script ~\/.config\/ranger\/scope.sh/set preview_script ~\/.config\/ranger\/scope.sh/g' $HOME/.config/ranger/rc.conf
     # sed -i 's/set sort natural/set sort ctime/g' ~/.config/ranger/rc.conf
    fi
    if [ -f ~/.config/ranger/scope.sh ]; then
     echo "arquivo scope.sh ... [ok]"
    else
     ranger --copy-config=scope
     sleep 0.2
     sed -i '113,116s/#//' $HOME/.config/ranger/scope.sh
     sleep 0.2
     sed -i '157,160s/#//' $HOME/.config/ranger/scope.sh
    fi
    if [ -f ~/.config/ranger/rifle.conf ]; then
     echo "arquivo rifle.conf ... [ok]"
    else
     ranger --copy-config=rifle
     sed -i 's/mime ^audio|ogg$, terminal, has mplayer  = mplayer -- "$@"/mime ^audio|ogg$, terminal, has moc      = ncmpcpp -- "$@"/g' $HOME/.config/ranger/rifle.conf
     sleep 0.2
     sed -i '/label wallpaper, number 15, mime ^image, has feh, X = wal -i "$1"/d' $HOME/.config/ranger/rifle.conf
     sleep 0.2
     sed -i 's/label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"/label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"\nlabel wallpaper, number 15, mime ^image, has feh, X = wal -i "$1"/g' $HOME/.config/ranger/rifle.conf
    fi

    ranger --version

fi

}

audio_config(){

 clear
 echo -e "... controlador audio \n ... \n .. \n ."
 sleep 0.2

 echo " 1)_Pipewire    2)_Pulseaudio"
 echo -e " \033[44;1;37m qual controlador de audio? \033[0m "
 echo " (Padrao: pipewire)"
 read -r -p "-> ... " aud

case "$aud" in
 1) AUDIOD='PIPEWIRE'
  ;;
 2) AUDIOD='PULSEAUDIO'
  ;;
 *) audio_config
  ;;
esac

if [ $AUDIOD = PIPEWIRE ]; then
  $_so \
  pipewire \
  pipewire-alsa \
  pipewire-audio \
  pipewire-pulse \
  wireplumber \
  # gst-plugin-pipewire
  # helvum \
  echo -e "use <wpctl status> para detectar en Sinks: o númeor ID da saída de áudío\nexemplo:\nwpctl status\nSinks:\n33. Áudio interno Estéreo analógico  [vol: 1.20]\n53. Ellesmere HDMI Audio [Radeon RX 470/480 / 570/580/590] Digital Stereo (HDMI 6)\nwpctl set-default 53" >> notas.txt
elif [ $AUDIOD = PULSEAUDIO ]; then
  $_so \
  alsa-utils \
  pulseaudio \
  # gst-plugins-{base,good,bad,ugly} \
  # gst-libav
fi

}

zshinstall(){

 clear
 echo -e "instalando zsh . zsh-completions  \n ... \n .. \n ."
 sleep 0.2

$_so \
zsh \
zsh-completions

echo "zsh ... instalado"

}

fontes_doSistema(){

 clear
 echo -e "instalando fontes  \n ... \n .. \n ."
 sleep 0.2

# wqy-microhei (koreano), cjk (japones)
$_so \
ttf-dejavu \
noto-fonts-emoji \
gnu-free-fonts \
wqy-microhei \
noto-fonts-cjk \
xorg-fonts-{75dpi,100dpi,encodings} \
ttf-jetbrains-mono-nerd 

if [ ! -f /usr/share/fonts/misc/siji.bdf ]; then
$HELPER -S --needed --noconfirm siji-git 
fi

echo "fontes ... instaladas"

}

navegador(){

 clear
 echo -e "... browser  \n ... \n .. \n ."
 sleep 0.2

echo " 1)_Qutebrowser    2)_Firefox    P)_Pular"
echo -e " \033[44;1;37m Qual navegador preferido? \033[0m "
read -r -p "-> ... " browser

case "$browser" in
 1) BROW="qutebrowser"
 ;;
 2) BROW="firefox"
 ;;
 P|p) echo "Canelau"
 ;;
 *) navegador
 ;;
esac

if [ $BROW = "qutebrowser" ]; then
 $_so qutebrowser \
python-adblock

/usr/share/qutebrowser/scripts/dictcli.py install pt-BR

 mkdir -p ~/.config/qutebrowser/;
 cp -r ./.config/qutebrowser/* ~/.config/qutebrowser/;
 chmod +x ~/.config/qutebrowser/greasemonkey/*

elif [ $BROW = "firefox" ]; then
 $_so firefox \
firefox-i18n-pt-br

 echo "$BROW ... instalado"
fi

}

copilador_config(){

 clear
 echo -e "configurando copilador  \n ... \n .. \n ."
 sleep 0.2

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
 sleep 0.2

if [[ -f /usr/bin/xdg-user-dirs-update ]]; then
xdg-user-dirs-update
fi
}

temas(){

 clear
 echo -e "configurando temas gruvbox-dark para GTK  \n ... \n .. \n ."
 sleep 0.2

# gruvbox tema
if [ ! -d ~/.themes ]; then
git clone https://github.com/jmattheis/gruvbox-dark-gtk ~/.themes/gruvbox-dark-gtk
else
 echo "voce ja tem o tema"
fi
sleep 0.2
if [ ! -d ~/.icons ]; then
git clone https://github.com/jmattheis/gruvbox-dark-icons-gtk ~/.icons/gruvbox-dark-icons-gtk
else
 echo "voce ja tem o tema"
fi
if [ -d ~/.config/gtk-3.0 ]; then
 cp ./.config/gtk-3.0/* ~/.config/gtk-3.0/;
else
 mkdir -p ~/.config/gtk-3.0/;
 cp ./.config/gtk-3.0/* ~/.config/gtk-3.0/;
fi

echo "temas gruvbox GTK ... instalados"

}

ohmyzsh(){

 clear
 echo -e "instalando oh-my-zsh  \n ... \n .. \n ."
 sleep 0.2

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
 sleep 0.2

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

sleep 0.2

if [ -f ~/.zshrc ]; then
echo -e "\nexport	EDITOR='nvim'\nexport	TERMINAL='alacritty'\nexport	BROWSER='qutebrowser'\nexport	READER='zathura'\nexport	SHELL='zsh'\nexport	XDG_CURRENT_DESKTOP='bspwm'\n\n[[ ! -f ~/.config/zsh/alias.zsh ]] || source ~/.config/zsh/alias.zsh\n[[ ! -f ~/.config/zsh/vim-mode.zsh ]] || source ~/.config/zsh/vim-mode.zsh\n\n# autopair zsh\nif [[ ! -d ~/.config/zsh/zsh-autopair ]]; then\n\tgit clone https://github.com/hlissner/zsh-autopair ~/.config/zsh/zsh-autopair\nfi\n\nsource ~/.config/zsh/zsh-autopair/autopair.zsh\nautopair-init" >> $HOME/.zshrc

sed -i '/(git)/s/git/git extract universalarchive/' $HOME/.zshrc
fi

sleep 0.2
echo "zsh configurado"

}

editordeTexto(){

 clear
 echo -e "configurando instalando e astrovim  \n ... \n .. \n ."
 sleep 0.2

echo "
 +--------------------+
 |                    |      neovim
 |       .ASTRO       |        +
 |        NVIM.       |      astro
 |        ....        |      ...
 |         ..         |
 +--------------------+
"

 $_so neovim \
 python-pynvim

 if [ ! -d ~/.config/nvim ]; then
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  git clone https://github.com/quebravel/astronvim_config.git ~/.config/nvim/lua/user
  (nvim  --headless -c 'quitall')
 else
  echo " 1)_Sim    2)_Nao"
  echo " Existe um diretorio nvim"
  echo -e " \033[44;1;37m Deseja re/instalar astronvim? \033[0m "
  read -r -p "-> ... " astronv

  case "$astronv" in
   1)
    rm -rf ~/.config/nvim/;
    git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
    git clone https://github.com/quebravel/astronvim_config.git ~/.config/nvim/lua/user
    (nvim  --headless -c 'quitall')
   ;;
   2) echo "Simbora! ..."
   ;;
   *) editordeTexto
   ;;
  esac 
 fi

 echo -e " .... Script finalizado \n ... \n .. \n ."

}

layout_teclado(){
    echo " 1)_abnt2    2)_us-intl"
    echo " Qual o layout do seu teclado?"
    read -r -p "-> ... " LAYOUTTECLADO 

    case "$LAYOUTTECLADO" in
        1)
            sudo cp ./xorg_conf/31-keyboard-abnt2.conf /usr/share/X11/xorg.conf.d/
        ;;
        2) 
            sudo cp ./xorg_conf/30-keyboard-us-intl.conf /usr/share/X11/xorg.conf.d/
        ;;
        *) layout_teclado
        ;;
    esac
}

# chamar funções parte 1
inicio
driveVideo
windowManger
gerenciardorAUR
notebook_ger
lancadorProgramas
arquivosdeConfiguracao
ly_config

# chamar funções parte 2
zshinstall
fontes_doSistema
navegador
copilador_config
temas
pastas_config
audio_config
rangerfm
playermusica
ohmyzsh
alias_autopair
editordeTexto
layout_teclado
