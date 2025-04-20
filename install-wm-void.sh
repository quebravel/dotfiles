#!/bin/env bash

# fork script of https://github.com/Axarva/dotfiles-2.0/tree/main
# fork script of https://github.com/SolDoesTech/HyprV4/blob/2cf439c27475a32fd00e816a1fde82a5804efe2a/set-hypr

# cores letras de seleçao
LETRA="\e[1;32m"
RESETLETRA="\e[0m"

# cores
CNT="[\e[1;36mNOTA\e[0m]"    #azul -cnt
COK="[\e[1;32mOK\e[0m]"      #verde -cok
CER="[\e[1;31mERRO\e[0m]"    #vermelhor claro -cer
CAT="[\e[1;37mATENCAO\e[0m]" #branco -cat
CWR="[\e[1;35mALERTA\e[0m]"  #roxo claro -cwr
CAC="[\e[1;33mACAO\e[0m]"    #amarelo -cac
INSTLOG="$HOME/install.log"
FIN_INST="&>> $INSTLOG & show_progress $!"
ESPEPACMAN="[\e[1;37mEXECUTANDO\e[0m"
CONFIGANDO="[\e[1;37mCONFIGURANDO\e[0m"

# barra de progresso
show_progress() {
  while ps | grep $1 &>/dev/null; do
    echo -n "."
    sleep 2
  done
  echo -en "\e[1;32mPRONTO!\e[0m]\n"
  sleep 2
}

install_software_xbps() {
  # instala pacotes com xbps-install
  # echo -en "$ESPEPACMAN - ATUALIZAÇAO DO SISTEMA."
  for PKGS in ${1}; do
    sudo xbps-install -Sy "${PKGS}" &>>$INSTLOG & show_progress $!
  done
}

# porte 1
inicio() {
  set -e

  clear

  #toilet -f ./3d -t "install-on-void" | lolcat -g 00cc00:00cc00

 cat <<EOL

        ██                    ██              ██  ██                                         ██      ██
░       ░                    ░██             ░██ ░██                                        ░░      ░██
        ██ ███████   ██████ ██████  ██████   ░██ ░██    ██████  ███████    ██    ██  ██████  ██     ░██
░       ██░░██░░░██ ██░░░░ ░░░██░  ░░░░░░██  ░██ ░██   ██░░░░██░░██░░░██  ░██   ░██ ██░░░░██░██  ██████
░       ██ ░██  ░██░░█████   ░██    ███████  ░██ ░██  ░██   ░██ ░██  ░██  ░░██ ░██ ░██   ░██░██ ██░░░██
░       ██ ░██  ░██ ░░░░░██  ░██   ██░░░░██  ░██ ░██  ░██   ░██ ░██  ░██   ░░████  ░██   ░██░██░██  ░██
░       ██ ███  ░██ ██████   ░░██ ░░████████ ███ ███  ░░██████  ███  ░██    ░░██   ░░██████ ░██░░██████
░       ░ ░░░   ░░ ░░░░░░     ░░   ░░░░░░░░ ░░░ ░░░    ░░░░░░  ░░░   ░░      ░░     ░░░░░░  ░░  ░░░░░░

                            Bem vindo!......................................
                            Este instalador e configurador foi feito como um
                            projeto pessoal para fazer uma instalação rapida
                            e  precisa  das  minhas configurações prediletas
                            dos principais programas que utilizo em meu void
                            linux.
        
                            Por  favor  sinta-se  a  vontade para utilizar e
                            modificar  de  acordo  com  suas preferencias de
                            configuração.
        
                            Para utilizar este  script você deve esta logado 
                            como  um usuario não  root  para que  as  pastas  
                            sejas  enviadas  para o  local  correto.........

EOL
  sleep 0.2

  read -rep "$(echo -e $CAC) - Esta pronto para continuar? - (s,n) ... " CONTINUAR
  case "$CONTINUAR" in
  s | j)
    echo ""
    ;;
  n | N)
    exit 1
    ;;
  *)
    inicio
    ;;
  esac

  # Default past github dotfiles
  # GITFILES="dotfiles-conf"

  # does full system update
  echo -e "$CAC - FAZENDO UMA ATUALIZAÇÃO DO SISTEMA, PODE ACONTECER QUE AS COISAS QUEBREM SE NÃO FOR A VERSÃO MAIS RECENTE."
  echo -e $ESPEPACMAN
  if ! sudo  xbps-install -Sy; then
    echo -e "$CER - ERRO NA ATUALIZAÇAO."
  fi

  # install base-devel if not installed
  echo -en "$ESPEPACMAN"
  install_software_xbps "base-devel wget git void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree" &>>$INSTLOG & show_progress $!

} ### fim inicio

driveVideo() {
  # choose video driver
  sleep 0.2

  cat <<DRIVERDESENHO
      ██        ██                                     ██      ██
     ░██       ░░                                     ░░      ░██
     ░██ ██████ ██ ██    ██  █████  ██████    ██    ██ ██     ░██  █████   ██████
  ██████░░██░░█░██░██   ░██ ██░░░██░░██░░█   ░██   ░██░██  ██████ ██░░░██ ██░░░░██
 ██░░░██ ░██ ░ ░██░░██ ░██ ░███████ ░██ ░    ░░██ ░██ ░██ ██░░░██░███████░██   ░██
░██  ░██ ░██   ░██ ░░████  ░██░░░░  ░██       ░░████  ░██░██  ░██░██░░░░ ░██   ░██
░░██████░███   ░██  ░░██   ░░██████░███        ░░██   ░██░░██████░░██████░░██████
 ░░░░░░ ░░░    ░░    ░░     ░░░░░░ ░░░          ░░    ░░  ░░░░░░  ░░░░░░  ░░░░░░
DRIVERDESENHO

  echo ""
  read -rep "$(echo -e $CAC) - Driver da sua placa de vídeo: $(echo -e $LETRA)I$(echo -e $RESETLETRA)NTEL, $(echo -e $LETRA)A$(echo -e $RESETLETRA)MDGPU, $(echo -e $LETRA)N$(echo -e $RESETLETRA)VIDIA ou $(echo -e $LETRA)M$(echo -e $RESETLETRA)aquinaVirtual - (i,a,n,m) ... " VIDEO

  case $VIDEO in
  i | I)
    DRI='xf86-video-intel'
    ;;

  a | A)
    DRI='xf86-video-amdgpu'
    ;;

  n | N)
    DRI='xf86-video-nvidia'
    ;;

  m | M)
    DRI="NAO"
    echo -e "$CAT - VOCE ESTA USANDO UMA MAQUINA VITUAL."
    ;;
  *)
    driveVideo

    ;;
  esac


  # complemetos para os drivers
  if [ $DRI == "xf86-video-amdgpu" ]; then
    echo -en "$ESPEPACMAN - AMDGPU."
    install_software_xbps "xf86-video-amdgpu mesa mesa-32bit mesa-vdpau libvdpau-va-gl mesa-vulkan-radeon mesa-vulkan-radeon-32bit" &>>$INSTLOG & show_progress $! # driver open-source (melhor)
    sudo cp ./xorg_conf/40-amdgpu.conf /usr/share/X11/xorg.conf.d/
  fi
  if [ $DRI == "xf86-video-intel" ]; then
    echo -en "$ESPEPACMAN - INTEL."
    install_software_xbps "mesa-libgallium mesa-libgallium-32bit libvdpau-va-gl mesa mesa-vulkan-intel mesa-32bit mesa-vulkan-intel-32bit" &>>$INSTLOG & show_progress $! # driver open-source (melhor)
    sudo cp ./xorg_conf/20-intel.conf /usr/share/X11/xorg.conf.d/
  fi
  if [ $DRI == "xf86-video-nvidia" ]; then
    echo -en "$ESPEPACMAN - NVIDIA."
    install_software_xbps "nvidia" &>>$INSTLOG & show_progress $! # tem que testa para ver ser funciona
    # nvidia-xconfig --add-argb-glx-visuals --allow-glx-with-composite --composite --render-accel -o /usr/share/X11/xorg.conf.d/20-nvidia.conf
  fi


} ### fim driveVideo

windowManger() {
  sleep 0.2

  cat <<WINDOWMANAGER
            ██               ██
           ░░               ░██                                                                 █████
 ███     ██ ██ ███████      ░██  ██████  ███     ██   ██████████   ██████   ███████   ██████   ██░░░██  █████  ██████
░░██  █ ░██░██░░██░░░██  ██████ ██░░░░██░░██  █ ░██  ░░██░░██░░██ ░░░░░░██ ░░██░░░██ ░░░░░░██ ░██  ░██ ██░░░██░░██░░█
 ░██ ███░██░██ ░██  ░██ ██░░░██░██   ░██ ░██ ███░██   ░██ ░██ ░██  ███████  ░██  ░██  ███████ ░░██████░███████ ░██ ░
 ░████░████░██ ░██  ░██░██  ░██░██   ░██ ░████░████   ░██ ░██ ░██ ██░░░░██  ░██  ░██ ██░░░░██  ░░░░░██░██░░░░  ░██
 ███░ ░░░██░██ ███  ░██░░██████░░██████  ███░ ░░░██   ███ ░██ ░██░░████████ ███  ░██░░████████  █████ ░░██████░███
░░░    ░░░ ░░ ░░░   ░░  ░░░░░░  ░░░░░░  ░░░    ░░░   ░░░  ░░  ░░  ░░░░░░░░ ░░░   ░░  ░░░░░░░░  ░░░░░   ░░░░░░ ░░░
WINDOWMANAGER

  echo ""
  read -rep "$(echo -e $CAC) - Qual gerenciador de janelas (window manager) vai ser desta vez? $(echo -e $LETRA)A$(echo -e $RESETLETRA)WESOME, $(echo -e $LETRA)B$(echo -e $RESETLETRA)SPWM, $(echo -e $LETRA)X$(echo -e $RESETLETRA)MONAD, $(echo -e $LETRA)P$(echo -e $RESETLETRA)ular - (b,x,h,p) ... " WME

  case $WME in
  a | A)
    WMawesome="awesome"
    ;;

  b | B)
    WMs="bspwm"
    WMx="sxhkd"
    WMb="polybar"
    ;;

  x | X)
    WMs="xmonad"
    WMx="xmonad-contrib"
    WMb="xmobar"

    ;;

  p | P)
    echo ""
    ;;

  *)
    windowManger
    ;;
  esac

  if [[ -z $WMawesome ]]; then
    echo ""
  else
    # instalando window manger awesome
    echo -en "$ESPEPACMAN - INSTALAÇAO DO $WMawesome."
    install_software_xbps "$WMawesome" &>>$INSTLOG & show_progress $!
    echo -en "$ESPEPACMAN - INSTALAÇAO DO XORG."
    install_software_xbps "picom pasystray alsa-utils xclip xdo mtools xdotool xsel feh xorg-xsetroot xorg-xset xorg-xrdb xorg-minimal libxinerama libxft nsxiv unclutter maim" &>>$INSTLOG & show_progress $!

    # config network
    install_software_xbps "gammastep-indicator network-manager-applet" &>>$INSTLOG & show_progress $!

    # config icon/widget
    (git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/arc-icon-theme && cd ~/arc-icon-theme && ./autogen.sh --prefix=/usr sudo make install && rm -rf ~/arc-icon-theme)

    wget https://raw.githubusercontent.com/rxi/json.lua/refs/heads/master/json.lua -P ~/.config/awesome/

    # &>> $INSTLOG & show_progress $!
    echo -e "$COK - $WMs INSTALADO."
  fi

  # xmonad
  if [[ $WMs == "xmonad" ]]; then
    # instalando window manger xmonad
    echo -en "$ESPEPACMAN - INSTALAÇAO DO $WMs."
    install_software_xbps "libX11-devel libXScrnSaver-devel libXft-devel libXinerama-devel libXrandr-devel cabal-install xmobar" &>>$INSTLOG & show_progress $!

    cabal install --lib xmonad xmonad-contrib X11
    cabal install xmonad 

    echo -en "$ESPEPACMAN - INSTALAÇAO DO XORG."
    install_software_xbps "alsa-utils xclip xdo mtools xdotool xsel feh xorg-xsetroot xorg-xset xorg-xrdb xorg-minimal libxinerama libxft nsxiv unclutter maim" &>>$INSTLOG & show_progress $!

    # &>> $INSTLOG & show_progress $!
    echo -e "$COK - $WMs INSTALADO."
  else
    echo ""
  fi

  if [[ $WMs = "bspwm" ]]; then
    # instalando window manger
    echo -en "$ESPEPACMAN - INSTALAÇAO DO $WMs."
    install_software_pacman "bspwm sxhkd polybar" &>>$INSTLOG & show_progress $!
    echo -en "$ESPEPACMAN - INSTALAÇAO DO XORG."
    install_software_pacman "alsa-utils xclip xdo mtools xdotool xsel feh xorg-xsetroot xorg-xset xorg-xrdb xorg-minimal libxinerama libxft nsxiv unclutter maim" &>>$INSTLOG & show_progress $!

    # &>> $INSTLOG & show_progress $!
    echo -e "$COK - $WMs INSTALADO."
  else
    echo ""
  fi

  if [[ -z $WMs ]]; then
    echo ""
  elif [[ -d ~/.config/$WMs ]]; then
    rm --recursive --force ~/.config/$WMs
    cp -r ./.config/$WMs ~/.config/
    echo -e "$COK - CONFIGURAÇÃO $WMs DETECTADA, BACKUP."
  else
    mkdir -p ~/.config/$WMs
    cp -r ./.config/$WMs/* ~/.config/$WMs/
    echo -e "$COK - CONFIGURAÇÃO DO $WMs."
  fi
  if [[ $WMx = "sxhkd" ]]; then
    rm --recursive --force ~/.config/sxhkd/
    mkdir -p ~/.config/sxhkd/
    cp --recursive ./.config/sxhkd/* ~/.config/sxhkd
    echo -e "$COK - CONFIGURAÇÃO KEYBINDS DO BSPWM."
  fi
  if [[ $WMb = "polybar" ]]; then
    rm --recursive --force ~/.config/polybar
    mkdir -p ~/.config/polybar/
    cp --recursive ./.config/polybar/* ~/.config/polybar/
    echo -e "$COK - CONFIGURAÇÃO DO POLYBAR CONCLUIDA."
  fi

  if [[ $WMawesome = "awesome" ]]; then
    rm --recursive --force ~/.config/awesome/
    git clone --recurse-submodules -j8 https://github.com/quebravel/awesome.git ~/.config/awesome/
    git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/arc-icon-theme/
    (cd ~/arc-icon-theme && ./autogen.sh --prefix=/usr && sudo make install)
    (rm --recursive --force ~/arc-icon-theme/)
    wget https://raw.githubusercontent.com/rxi/json.lua/refs/heads/master/json.lua -P ~/.config/awesome/
    cp ./.Xresources ~/
    cp --recursive ./.config/picom/ ~/.config/
  fi
  
  if [[ $WMawesome = "awesome" ]]; then
    echo -e '#!/bin/bash\n\n[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources\n\nxsetroot -cursor_name left_ptr &\n\n# feh --bg-tile ~/Imagens/wallpaperz.png\n# $HOME/.fehbg\n# $HOME/trigger_custom_refresh.sh &\n# wal -R\n\n# export MPD_HOST=$HOME/.config/mpd/socket\n# mpd --kill; mpd &\n# unclutter --timeout 7 &\n\n# Set up an icon tray\n# trayer --edge top --align right --SetDockType true --SetPartialStrut true \ \n# --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &\n\nif [ "$(command -v xset)" >/dev/null 2>&1 ];\nthen\n    #xset s off      	        #Disable screen saver blanking\n    #xset s 3600 3600 	        #Change blank time to 1 hour\n    #xset -dpms 	            #Turn off DPMS\n    xset s off -dpms 	        #Disable DPMS and prevent screen from blanking\n    #xset dpms force off 	    #Turn off screen immediately\n    #xset dpms force standby 	#Standby screen\n    #xset dpms force suspend 	#Suspend screen\nfi\n\n# numlockx &\n# pulseaudio -k\n# pulseaudio &\n\nexec awesome\n\n#vim:ft=sh' > ~/.xinitrc
  fi

  if [[ $WMs = "bspwm" ]]; then
    echo -e '#!/bin/bash\n\nxsetroot -cursor_name left_ptr &\n\n# feh --bg-tile ~/Imagens/wallpaperz.png\n$HOME/.fehbg\n# $HOME/trigger_custom_refresh.sh &\n# wal -R\n\n# export MPD_HOST=$HOME/.config/mpd/socket\n# mpd --kill; mpd &\nunclutter --timeout 7 &\n\n# Set up an icon tray\n# trayer --edge top --align right --SetDockType true --SetPartialStrut true \ \n# --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &\n\nif [ "$(command -v xset)" >/dev/null 2>&1 ];\nthen\n    #xset s off      	        #Disable screen saver blanking\n    #xset s 3600 3600 	        #Change blank time to 1 hour\n    #xset -dpms 	            #Turn off DPMS\n    xset s off -dpms 	        #Disable DPMS and prevent screen from blanking\n    #xset dpms force off 	    #Turn off screen immediately\n    #xset dpms force standby 	#Standby screen\n    #xset dpms force suspend 	#Suspend screen\nfi\n\n# numlockx &\n# pulseaudio -k\n# pulseaudio &\n\nsxhkd &\nexec bspwm\n\n\n#vim:ft=sh' > ~/.xinitrc
  fi

  if [[ $WMs = "xmonad" ]]; then
    echo -e '#!/bin/bash\n\nxsetroot -cursor_name left_ptr &\n\n# feh --bg-tile ~/Imagens/wallpaperz.png\n$HOME/.fehbg\n# $HOME/trigger_custom_refresh.sh &\n# wal -R\n\n# export MPD_HOST=$HOME/.config/mpd/socket\n# mpd --kill; mpd &\nunclutter --timeout 7 &\n\n# Set up an icon tray\n# trayer --edge top --align right --SetDockType true --SetPartialStrut true \ \n# --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &\n\nif [ "$(command -v xset)" >/dev/null 2>&1 ];\nthen\n    #xset s off      	        #Disable screen saver blanking\n    #xset s 3600 3600 	        #Change blank time to 1 hour\n    #xset -dpms 	            #Turn off DPMS\n    xset s off -dpms 	        #Disable DPMS and prevent screen from blanking\n    #xset dpms force off 	    #Turn off screen immediately\n    #xset dpms force standby 	#Standby screen\n    #xset dpms force suspend 	#Suspend screen\nfi\n\n# numlockx &\n# pulseaudio -k\n# pulseaudio &\n\nexec xmonad\n\n#vim:ft=sh' > ~/.xinitrc
  fi

  if [[ -f ~/.xinitrc ]]; then
    chmod +x ~/.xinitrc
  fi

} ### windowManger



### inicializadores de funcao
# inicio
# driveVideo
windowManger
