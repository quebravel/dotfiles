#!/bin/env bash
# fork script of https://github.com/Axarva/dotfiles-2.0/tree/main fork script of https://github.com/SolDoesTech/HyprV4/blob/2cf439c27475a32fd00e816a1fde82a5804efe2a/set-hypr #ADD setar variaveis do wayland # https://docs.voidlinux.org/config/graphical-session/wayland.html#wayland <- # cores letras de seleçao LETRA="\e[1;32m" RESETLETRA="\e[0m" # cores CNT="[\e[1;36mNOTA\e[0m]"    #azul -cnt COK="[\e[1;32mOK\e[0m]"      #verde -cok CER="[\e[1;31mERRO\e[0m]"    #vermelhor claro -cer CAT="[\e[1;37mATENCAO\e[0m]" #branco -cat CWR="[\e[1;35mALERTA\e[0m]"  #roxo claro -cwr CAC="[\e[1;33mACAO\e[0m]"    #amarelo -cac INSTLOG="$HOME/install.log" FIN_INST="&>> $INSTLOG & show_progress $!" ESPEPACMAN="[\e[1;37mEXECUTANDO\e[0m" CONFIGANDO="[\e[1;37mCONFIGURANDO\e[0m" # barra de progresso show_progress() { while ps | grep $1 &>/dev/null; do echo -n "." sleep 2 done echo -en "\e[1;32mPRONTO!\e[0m]\n" sleep 2 }
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
     ░░                    ░██             ░██ ░██                                        ░░      ░██
      ██ ███████   ██████ ██████  ██████   ░██ ░██    ██████  ███████    ██    ██  ██████  ██     ░██
     ░██░░██░░░██ ██░░░░ ░░░██░  ░░░░░░██  ░██ ░██   ██░░░░██░░██░░░██  ░██   ░██ ██░░░░██░██  ██████
     ░██ ░██  ░██░░█████   ░██    ███████  ░██ ░██  ░██   ░██ ░██  ░██  ░░██ ░██ ░██   ░██░██ ██░░░██
     ░██ ░██  ░██ ░░░░░██  ░██   ██░░░░██  ░██ ░██  ░██   ░██ ░██  ░██   ░░████  ░██   ░██░██░██  ░██
     ░██ ███  ░██ ██████   ░░██ ░░████████ ███ ███  ░░██████  ███  ░██    ░░██   ░░██████ ░██░░██████
     ░░ ░░░   ░░ ░░░░░░     ░░   ░░░░░░░░ ░░░ ░░░    ░░░░░░  ░░░   ░░      ░░     ░░░░░░  ░░  ░░░░░░

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
  s | S)
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
  # GITFILES="dotfiles"

  # atualizar repositório e pacotes.
  echo -e "$CAC - FAZENDO UMA ATUALIZAÇÃO DO SISTEMA, PODE ACONTECER QUE AS COISAS QUEBREM SE NÃO FOR A VERSÃO MAIS RECENTE."
  echo -e $ESPEPACMAN
  if ! sudo xbps-install -Syu; then
    echo -e "$CER - ERRO NA ATUALIZAÇAO."
  fi

  # instalar base-devel.
  echo -en "$ESPEPACMAN"
  install_software_xbps "base-devel wget curl git void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree" #&>>$INSTLOG & show_progress $!
  # atualizar repositório nonfree, multilib e multilib-nonfree.
  sudo xbps-install -Syu
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
    # drivers 64bits
    install_software_xbps "linux-firmware-amd mesa-dri vulkan-loader amdvlk xf86-video-amdgpu mesa-vaapi mesa-vdpau libvdpau-va-gl" #&>>$INSTLOG & show_progress $! # para placas AMD mais antigas intalar xf86-video-radeon, mesa-vulkan-radeon

    # drivers 32bits 
    install_software_xbps "mesa-dri-32bit vulkan-loader-32bit amdvlk-32bit mesa-vaapi-32bit mesa-vdpau-32bit libvdpau-va-gl-32bit" #&>>$INSTLOG & show_progress $! # para placas AMD mais antigas intalar xf86-video-radeon-32bit, mesa-vulkan-radeon-32bit

    # sudo cp ./xorg_conf/40-amdgpu.conf /usr/share/X11/xorg.conf.d/
  fi
  if [ $DRI == "xf86-video-intel" ]; then
    echo -en "$ESPEPACMAN - INTEL."
    # drivers 64bits
    install_software_xbps "linux-firmware-intel mesa-dri vulkan-loader xf86-video-intel mesa-vulkan-intel intel-video-accel libvdpau-va-gl" #&>>$INSTLOG & show_progress $! # cpu mais antigas instalar mesa-libgallium
    # drivers 32bits 
    install_software_xbps "mesa-dri-32bit vulkan-loader-32bit mesa-vulkan-intel-32bit libvdpau-va-gl-32bit" #&>>$INSTLOG & show_progress $!
    # sudo cp ./xorg_conf/20-intel.conf /usr/share/X11/xorg.conf.d/
    echo -en "$CWR - obs: VERIFIQUE SE SEU CPU É BROADWELL OU  COFFEE LAKE para outras configurações."
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
  read -rep "$(echo -e $CAC) - Qual gerenciador de janelas (window manager) vai ser desta vez? 
  $(echo -e $LETRA)N$(echo -e $RESETLETRA)IRI,
  $(echo -e $LETRA)P$(echo -e $RESETLETRA)ular - (n,p) ... " WME

  case $WME in
  n | N)
    WM="niri"
    WMB="Waybar"
    WAYLAND_ONOFF="on"
    ;;

  p | P)
    echo ""
    ;;

  *)
    windowManger
    ;;
  esac

  if [[ $WAYLAND_ONOFF == "on" ]]; then
      # variaveis wayland
      for VARIAVES_SISTEMA in "\n" QT_QPA_PLATFORM=\'wayland\' ELM_DISPLAY=\'wl\' SDL_VIDEODRIVER=\'wayland\' MOZ_ENABLE_WAYLAND=\'1\'; do
        sudo echo -e $VARIAVES_SISTEMA >> /etc/environment
  done

  # niri
  if [[ $WM == "niri" ]]; then
    # instalando window manger xmonad
    echo -en "$ESPEPACMAN - INSTALAÇAO DO $WM."

    install_software_xbps "niri Waybar wl-clipboard elogind imv yazi alacritty fuzzel polkit" #&>>$INSTLOG & show_progress $!
    # pacotes wayland
    install_software_xbps "wayland xorg-server-xwayland qt6-wayland"

    echo -e "$COK - $WM INSTALADO."
  else
    echo ""
  fi

  # para notebook
  if ! cat /sys/class/power_supply/BAT0/capacity &>> /dev/null ; then
    echo "NÃO É UM NOTEBOOK!"
  else
    echo "É UM NOTEBOOK!"
    install_software_xbps "acpi"
    sudo ln -sfv /etc/sv/acpid /var/service
  fi

  # configurações wm
  if [[ -z $WM ]]; then
    echo ""
  elif [[ -d ~/.config/$WM ]]; then
    rm --recursive --force ~/.config/$WM
    cp -r ./.config/$WM ~/.config/
    echo -e "$COK - CONFIGURAÇÃO $WM DETECTADA, BACKUP."
  else
    mkdir -p ~/.config/$WM
    cp -r ./.config/$WM/* ~/.config/$WM/
    echo -e "$COK - CONFIGURAÇÃO DO $WM."
  fi
  if [[ $WMB = "Waybar" ]]; then
    rm --recursive --force ~/.config/waybar
    mkdir -p ~/.config/waybar/
    cp --recursive ./.config/waybar/* ~/.config/waybar/
    echo -e "$COK - CONFIGURAÇÃO DO POLYBAR CONCLUIDA."
  fi

  # adicionando serviços no runit
  services_runit(){
  for SERVICE in dbus polkit; do
    sudo ln -sfv /etc/sv/$SERVICE /var/service
  done
}

} ### windowManger

# arquivos de programas padrão ->
arquivosdeConfiguracao() {
  sleep 0.2

  if [[ ! -d ~/.config/alacritty ]]; then
    mkdir -p ~/.config/alacritty/
    cp --recursive --force ./.config/alacritty ~/.config/
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
  else
    rm --recursive --force ~/.config/alacritty/
    cp --recursive --force ./.config/alacritty ~/.config/
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
  fi
  if [ -d ~/wallpapers ]; then
      echo "Adicionando wallpaper para ~/wallpapers..."
      cp ./wallpapers/* ~/wallpapers/;
  else
      echo "git clone wallpaper..."
      # mkdir ~/wallpapers && cp -r ./wallpapers/* ~/wallpapers/;
      git clone https://github.com/quebravel/wallpapers ~/wallpapers
  fi
  if [[ ! -d ~/.config/mpv ]]; then
    mkdir --parents ~/.config/mpv
    cp ./.config/mpv/* ~/.config/mpv/
  else
    rm --recursive --force ~/.config/mpv/*
    cp --recursive --force ./.config/mpv/* ~/.config/mpv/
  fi

  if [[ ! -d ~/.config/zathura ]]; then
    mkdir --parents ~/.config/zathura/
    cp ./.config/zathura/zathurarc ~/.config/zathura/
  else
    rm --force ~/.config/zathura/zathurarc
    cp ./.config/zathura/zathurarc ~/.config/zathura/
  fi

  if [[ ! -d ~/.config/gammastep ]]; then
    mkdir --parents ~/.config/gammastep/
    cp --recursive --force ./.config/gammastep/* ~/.config/gammastep/
  else
    rm --recursive --force ~/.config/gammastep/
    cp --recursive --force ./.config/gammastep/ ~/.config/
  fi

  if [[ ! -d ~/.config/git ]]; then
    mkdir --parents ~/.config/git/
    cp ./.config/git/config ~/.config/git/
  else
    rm --recursive --force ~/.config/git/
    cp --recursive --force ./.config/git/ ~/.config/
  fi

  echo -e "$COK - CONFIGURAÇOES DIVERSAS."

} ### arquivosdeConfiguracao <-

# gerenciador de login ->
displayManager(){

  sleep 0.2
  cat <<LOGINLY
      ██ ██                  ██
     ░██░░          ██████  ░██            ██   ██                                             █████
     ░██ ██  ██████░██░░░██ ░██  ██████   ░░██ ██    ██████████   ██████   ███████   ██████   ██░░░██  █████  ██████
  ██████░██ ██░░░░ ░██  ░██ ░██ ░░░░░░██   ░░███    ░░██░░██░░██ ░░░░░░██ ░░██░░░██ ░░░░░░██ ░██  ░██ ██░░░██░░██░░█
 ██░░░██░██░░█████ ░██████  ░██  ███████    ░██      ░██ ░██ ░██  ███████  ░██  ░██  ███████ ░░██████░███████ ░██ ░
░██  ░██░██ ░░░░░██░██░░░   ░██ ██░░░░██    ██       ░██ ░██ ░██ ██░░░░██  ░██  ░██ ██░░░░██  ░░░░░██░██░░░░  ░██
░░██████░██ ██████ ░██      ███░░████████  ██        ███ ░██ ░██░░████████ ███  ░██░░████████  █████ ░░██████░███
 ░░░░░░ ░░ ░░░░░░  ░░      ░░░  ░░░░░░░░  ░░        ░░░  ░░  ░░  ░░░░░░░░ ░░░   ░░  ░░░░░░░░  ░░░░░   ░░░░░░ ░░░
LOGINLY
  echo ""
  read -rep "$(echo -e $CAC) - Deseja instalar um Display Manager $(echo -e $LETRA)T$(echo -e $RESETLETRA)BSM ou $(echo -e $LETRA)G$(echo -e $RESETLETRA)REETD? - (t,g,n) ... " DMGR

  case "$DMGR" in
  t | T)
    echo -en "$ESPEPACMAN - INSTALAÇAO DO TBSM."
    install_software_xbps "tbsm" #&>>$INSTLOG & show_progress $!
    echo "[[ $XDG_VTNR -le 2 ]] && tbsm" >~/.zlogin
    cp -r ./.config/tbsm/ ~/.config/
    echo -e "$COK - TBSM INSTALADO."
    ;;
  g | G)
    echo -en "$ESPEPACMAN - INSTALAÇAO DO GREETD."
    install_software_xbps "greetd tuigreet" #&>>$INSTLOG & show_progress $!
    # install_software_xbps "greetd tuigreet" &>>$INSTLOG & show_progress $!
    sudo sed -i '0,/command/s//\# command/' /etc/greetd/config.toml

    sudo ln -s /etc/sv/greetd /var/service/ #&>>$INSTLOG

    echo -e "$COK - GREETD INSTALADO."
    ;;
  n | N)
    echo -e "$CNT - NAO TERÁ DISPLAY MANAGER."
    ;;
  *)
    displayManager
    ;;
  esac

  if [[ -f ~/.xinitrc ]]; then
    chmod +x ~/.xinitrc
  fi
} #gerenciador de login <-

# zsh ->
zshinstall() {
  sleep 0.2

  echo -en "$ESPEPACMAN - INSTALAÇAO DO ZSH."
  install_software_xbps "zsh zsh-completions" #&>>$INSTLOG & show_progress $!

  echo -e "$COK - ZSH INSTALADO."

} # zsh <-


# fonts ->
fontes_doSistema() {
  sleep 0.2

  # wqy-microhei (koreano), cjk (japones)
  echo -en "$ESPEPACMAN - INSTALAÇAO DAS FONTES DO SISTEMA."
  install_software_xbps "dejavu-fonts-ttf noto-fonts-emoji noto-fonts-cjk wqy-microhei xorg-fonts encodings" #&>>$INSTLOG & show_progress $!

} # fonts <-


### inicializadores de funcao
inicio
driveVideo
windowManger
services_runit
arquivosdeConfiguracao
displayManager
zshinstall
fontes_doSistema
