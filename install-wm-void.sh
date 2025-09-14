#!/bin/env bash
# fork script of https://github.com/Axarva/dotfiles-2.0/tree/main 
# fork script of https://github.com/SolDoesTech/HyprV4/blob/2cf439c27475a32fd00e816a1fde82a5804efe2a/set-hypr 

# #ADD setar variaveis do wayland 

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


# spinner.sh - Mostra um spinner com mensagem enquanto um comando roda
spinner() {
    local pid=$1
    local msg="$2"
    local delay=0.1
    local spinstr='|/-\'
    tput civis  # esconde o cursor
    while ps -p $pid > /dev/null 2>&1; do
        for i in $(seq 0 3); do
            printf "\r%s [%c] " "$msg" "${spinstr:$i:1}"
            sleep $delay
        done
    done
    wait $pid
    local exit_status=$?
    if [ $exit_status -eq 0 ]; then
        printf "\r%s [ok]\n" "$msg"
    else
        printf "\r%s [er]\n" "$msg"
    fi
    tput cnorm  # mostra o cursor
    return $exit_status
}

run_with_spinner() {
    local msg="$1"
    shift
    "$@" > /dev/null 2>&1 &
    local cmd_pid=$!
    spinner $cmd_pid "$msg"
    wait $cmd_pid
    return $?
}

# barra de progresso
# show_progress() {
#   while ps | grep $1 &>/dev/null; do
#     echo -n "."
#     sleep 2
#   done
#   echo -en "\e[1;32mPRONTO!\e[0m]\n"
#   sleep 2
# }

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
      sudo xbps-install -Sy
  if ! run_with_spinner "Atualizando sistema" sudo xbps-install -Syu; then
    echo -e "$CER - ERRO NA ATUALIZAÇAO."
  fi

  # instalar base-devel.
  echo -en "$ESPEPACMAN"
   run_with_spinner "Instalando base-devel" sudo xbps-install -y base-devel wget curl git void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree #&>>$INSTLOG & show_progress $!
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
    run_with_spinner "Instalando amd" sudo xbps-install -y linux-firmware-amd mesa-dri vulkan-loader amdvlk xf86-video-amdgpu mesa-vaapi mesa-vdpau libvdpau-va-gl #&>>$INSTLOG & show_progress $! # para placas AMD mais antigas intalar xf86-video-radeon, mesa-vulkan-radeon

    # drivers 32bits 
    run_with_spinner "Instalando amd 32bit" sudo xbps-install -y mesa-dri-32bit vulkan-loader-32bit amdvlk-32bit mesa-vaapi-32bit mesa-vdpau-32bit libvdpau-va-gl-32bit #&>>$INSTLOG & show_progress $! # para placas AMD mais antigas intalar xf86-video-radeon-32bit, mesa-vulkan-radeon-32bit

    # sudo cp ./xorg_conf/40-amdgpu.conf /usr/share/X11/xorg.conf.d/
  fi
  if [ $DRI == "xf86-video-intel" ]; then
    echo -en "$ESPEPACMAN - INTEL."
    # drivers 64bits
    run_with_spinner "Instalando intel" sudo xbps-install -y linux-firmware-intel mesa-dri vulkan-loader xf86-video-intel mesa-vulkan-intel intel-video-accel libvdpau-va-gl intel-ucode #&>>$INSTLOG & show_progress $! # cpu mais antigas instalar mesa-libgallium
    # drivers 32bits 
    run_with_spinner "Instalando intel-32bit" sudo xbps-install -y mesa-dri-32bit vulkan-loader-32bit mesa-vulkan-intel-32bit libvdpau-va-gl-32bit #&>>$INSTLOG & show_progress $!
    # sudo cp ./xorg_conf/20-intel.conf /usr/share/X11/xorg.conf.d/
    echo -en "$CWR - obs: VERIFIQUE SE SEU CPU É BROADWELL OU  COFFEE LAKE para outras configurações."
  fi
  if [ $DRI == "xf86-video-nvidia" ]; then
    echo -en "$ESPEPACMAN - NVIDIA."
    run_with_spinner "Instalando nvidia" sudo xbps-install -y nvidia #&>>$INSTLOG & show_progress $! # tem que testa para ver ser funciona
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
  $(echo -e $LETRA)N$(echo -e $RESETLETRA)IRI, $(echo -e $LETRA)P$(echo -e $RESETLETRA)ular - (n,p) ... " WME

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
        sudo echo -e $VARIAVES_SISTEMA | sudo tee /etc/environment
      done
      sleep 0.2
      # pacotes wayland
      run_with_spinner "Instalando wayland" sudo xbps-install -y wayland xorg-server-xwayland qt6-wayland xdg-user-dirs
      sleep 0.2

      if [[ -f /usr/bin/xdg-user-dirs-update ]]; then
        xdg-user-dirs-update
      fi
  fi

  # niri
  if [[ $WM == "niri" ]]; then
    # instalando window manger xmonad
    echo -en "$ESPEPACMAN - INSTALAÇAO DO $WM."

    run_with_spinner "Instalando niri" sudo xbps-install -y niri Waybar wl-clipboard elogind imv yazi alacritty fuzzel polkit #&>>$INSTLOG & show_progress $!

    echo -e "$COK - $WM INSTALADO."
  else
    echo ""
  fi

  # para notebook
  if ! cat /sys/class/power_supply/BAT0/capacity &>> /dev/null ; then
    echo "NÃO É UM NOTEBOOK!"
  else
    echo "É UM NOTEBOOK!"
    run_with_spinner "Instalando acpi" sudo xbps-install -y acpi tlp
    sudo ln -sfv /etc/sv/acpid /var/service
    sudo ln -sfv /etc/sv/tlp /var/service
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
    echo -e "$COK - CONFIGURAÇÃO DO WAYBAR CONCLUIDA."
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

  if [ -d ~/wallpapers ]; then
      echo "Já adicionando wallpaper para ~/wallpapers..."
  else
      echo "git clone wallpaper..."
      # mkdir ~/wallpapers && cp -r ./wallpapers/* ~/wallpapers/;
      git clone https://github.com/quebravel/wallpapers ~/wallpapers
  fi
  
  for CONF_FILES in alacritty mpv zathura gammastep git; do
    if [[ ! -d ~/.config/$CONF_FILES ]]; then
      mkdir --parents ~/.config/$CONF_FILES
      cp ./.config/$CONF_FILES/* ~/.config/$CONF_FILES/
    else
      rm --recursive --force ~/.config/$CONF_FILES/*
      cp --recursive --force ./.config/$CONF_FILES/* ~/.config/$CONF_FILES/
    fi
  done

  if [[ ! -d ~/.config/alacritty ]]; then
    echo "CONFIGURAÇÃO DO ALACRITTY NÃO INSTALADAS."
  else
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
  fi

  echo -e "$COK - CONFIGURAÇÕES PADRÃO."

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
    run_with_spinner "Instalando tbsm" sudo xbps-install -y tbsm #&>>$INSTLOG & show_progress $!
    echo "[[ $XDG_VTNR -le 2 ]] && tbsm" >~/.zlogin
    cp -r ./.config/tbsm/ ~/.config/
    echo -e "$COK - TBSM INSTALADO."
    ;;
  g | G)
    echo -en "$ESPEPACMAN - INSTALAÇAO DO GREETD."
    run_with_spinner "Instalando greetd" sudo xbps-install -y greetd tuigreet #&>>$INSTLOG & show_progress $!

    sudo sed -i '0,/command/s//\# command/' /etc/greetd/config.toml

    if [[ $WM == "niri" ]]; then
      sudo sed -i '/# command/i\command \= \"tuigreet \-\-cmd niri\"' /etc/greetd/config.toml
    fi


    # sudo ln -s /etc/sv/greetd /var/service/ #&>>$INSTLOG # na hora que adiciona ele se ativa

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
  run_with_spinner "Instalando zsh" sudo xbps-install -y zsh zsh-completions eza #&>>$INSTLOG & show_progress $!

  echo -e "$COK - ZSH INSTALADO."

} # zsh <-


# fonts ->
fontes_doSistema() {
  sleep 0.2

  # wqy-microhei (koreano), cjk (japones)
  echo -en "$ESPEPACMAN - INSTALAÇAO DAS FONTES DO SISTEMA."
  run_with_spinner "Instalando fontes" sudo xbps-install -y dejavu-fonts-ttf noto-fonts-emoji noto-fonts-cjk wqy-microhei xorg-fonts encodings #&>>$INSTLOG & show_progress $!

} # fonts <-

# navegador ->
navegador() {
  sleep 0.2

  cat <<NAVEGADOR-DESENHO
 ██
░██
░██      ██████  ██████  ███     ██  ██████  █████  ██████
░██████ ░░██░░█ ██░░░░██░░██  █ ░██ ██░░░░  ██░░░██░░██░░█
░██░░░██ ░██ ░ ░██   ░██ ░██ ███░██░░█████ ░███████ ░██ ░
░██  ░██ ░██   ░██   ░██ ░████░████ ░░░░░██░██░░░░  ░██
░██████ ░███   ░░██████  ███░ ░░░██ ██████ ░░██████░███
░░░░░   ░░░     ░░░░░░  ░░░    ░░░ ░░░░░░   ░░░░░░ ░░░
NAVEGADOR-DESENHO

  echo ""
  read -rep "$(echo -e $CAC) - Qual navegador preferido? - $(echo -e $LETRA)Q$(echo -e $RESETLETRA)UTEBROWSER, $(echo -e $LETRA)F$(echo -e $RESETLETRA)IREFOX, $(echo -e $LETRA)A$(echo -e $RESETLETRA)mbos ou $(echo -e $LETRA)P$(echo -e $RESETLETRA)ular - (q,f,a,p) ... " BROWSER

  case "$BROWSER" in
  q | Q)
    BROWq="qutebrowser"
    ;;
  f | F)
    BROWf="firefox"
    ;;
  a | A)
    BROWq="qutebrowser"
    BROWf="firefox"
    ;;
  p | P)
    echo -e "$CNT - NAO SERÁ INSTALADO NENHUM NAVEGADOR."
    ;;
  *)
    navegador
    ;;
  esac

  if [[ $BROWq = "qutebrowser" ]]; then
    echo -en "$ESPEPACMAN"
    run_with_spinner "Instalando qutebrowser" sudo xbps-install -y qutebrowser python3-adblock #&>>$INSTLOG & show_progress $!
    echo -en "$CONFIGANDO"
    sudo /usr/share/qutebrowser/scripts/dictcli.py install pt-BR #&>>$INSTLOG & show_progress $!

    mkdir -p ~/.config/qutebrowser/
    cp -r ./.config/qutebrowser/* ~/.config/qutebrowser/
    chmod +x ~/.config/qutebrowser/greasemonkey/*

    echo -e "$COK - $BROWq INSTALADO."
  fi

  if [[ $BROWf = "firefox" ]]; then
    echo -en "$ESPEPACMAN - INSTALAÇAO DO FIREFOX."
    run_with_spinner "Instalando firefox" sudo xbps-install -y firefox firefox-i18n-pt-BR #&>>$INSTLOG & show_progress $!

    echo -e "$COK - $BROWf INSTALADO."
  fi

} # navegador <-

# tema gtk ->
temas() {
  sleep 0.2

  # gruvbox tema
  if [ ! -d ~/.themes ]; then
    echo -en "$CONFIGANDO - TEMA GRUVBOX."
    git clone https://github.com/jmattheis/gruvbox-dark-gtk ~/.themes/gruvbox-dark-gtk #&>>$INSTLOG & show_progress $!
  # (git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git) && (./Gruvbox-GTK-Theme/themes/install.sh) &>> $INSTLOG & show_progress $!
  # (mkdir -p ~/.config/gtk-3.0/)
  # (cp -r ~/.themes/Gruvbox-Dark/gtk-3.0/* ~/.config/gtk-3.0/)
  else
    echo -e "$CWR - VOCÊ JÁ TEM O TEMA GRUVBOX-DARK-GTK."
  fi
  sleep 0.2
  if [ ! -d ~/.icons ]; then
    echo -en "$CONFIGANDO - TEMA DOS ICONES EM GRUVBOX."
    git clone https://github.com/jmattheis/gruvbox-dark-icons-gtk ~/.icons/gruvbox-dark-icons-gtk #&>>$INSTLOG & show_progress $!
  else
    echo -e "$CWR - VOCÊ JÁ TEM O TEMA GRUVBOX-DARK-ICONS-GTK."
  fi
  if [ -d ~/.config/gtk-3.0 ]; then
    cp ./.config/gtk-3.0/* ~/.config/gtk-3.0/
  else
    mkdir -p ~/.config/gtk-3.0/
    cp ./.config/gtk-3.0/* ~/.config/gtk-3.0/
  fi
  if [[ ! -d ~/.local/share/icons/Grubox-Plus-Dark ]]; then
    rm -rf ~/.local/share/icons/Grubox-Plus-Dark
    git clone https://github.com/SylEleuth/gruvbox-plus-icon-pack.git ~/.local/share/icons/Grubox-Plus-Dark
  else
    echo "" &>>/dev/null
  fi
  echo -e "$COK - TEMAS GRUVBOX GTK."

} # tema gtk <-

# audio ->
audio_config() {
  sleep 0.2

  cat <<AUDIOCONF
                        ██ ██
                       ░██░░
  ██████   ██   ██     ░██ ██  ██████
 ░░░░░░██ ░██  ░██  ██████░██ ██░░░░██
  ███████ ░██  ░██ ██░░░██░██░██   ░██
 ██░░░░██ ░██  ░██░██  ░██░██░██   ░██
░░████████░░██████░░██████░██░░██████
 ░░░░░░░░  ░░░░░░  ░░░░░░ ░░  ░░░░░░
AUDIOCONF
  echo ""
  read -rep "$(echo -e $CAC) - Qual controlador de audio?  PIPE$(echo -e $LETRA)W$(echo -e $RESETLETRA)IRE ou $(echo -e $LETRA)P$(echo -e $RESETLETRA)ULSEAUDIO - (w,p) ... " AUD

  case "$AUD" in
  w | W)
    AUDIOD='PIPEWIRE'
    ;;
  p | P)
    AUDIOD='PULSEAUDIO'
    ;;
  *)
    audio_config
    ;;
  esac

  if [ $AUDIOD = PIPEWIRE ]; then
    echo -en "$ESPEPACMAN"
    run_with_spinner "Instalando pipewire" sudo xbps-install -y pipewire pipewire-devel alsa-pipewire wireplumber #&>>$INSTLOG & show_progress $!

    sudo mkdir -p /etc/alsa/conf.d
    sudo ln -sf /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
    sudo ln -sf /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

    echo -e "$COK - $AUDIOD INSTALADO."
    echo -e "$CAT - Use <wpctl status> para detectar en Sinks: o númeor ID da saída de áudío\nexemplo:\nwpctl status\nSinks:\n33. Áudio interno Estéreo analógico  [vol: 1.20]\n53. Ellesmere HDMI Audio [Radeon RX 470/480 / 570/580/590] Digital Stereo (HDMI 6)\nwpctl set-default 53" >>notas.txt
  elif [ $AUDIOD = PULSEAUDIO ]; then
    echo -en "$ESPEPACMAN"
    run_with_spinner "Instalando pulseaudio" sudo xbps-install -y alsa-utils pulseaudio #&>>$INSTLOG & show_progress $!
    # gst-plugins-{base,good,bad,ugly} \
    # gst-libav
    echo -e "$COK - $AUDIOD INSTALADO."
  fi

} # audio <-

# filemanager ->
rangerfm() {
  sleep 0.2

  cat <<RANGER-DESENHO
   ████ ██  ██
  ░██░ ░░  ░██                                                     █████
 ██████ ██ ░██  █████    ██████████   ██████   ███████   ██████   ██░░░██  █████  ██████
░░░██░ ░██ ░██ ██░░░██  ░░██░░██░░██ ░░░░░░██ ░░██░░░██ ░░░░░░██ ░██  ░██ ██░░░██░░██░░█
  ░██  ░██ ░██░███████   ░██ ░██ ░██  ███████  ░██  ░██  ███████ ░░██████░███████ ░██ ░
  ░██  ░██ ░██░██░░░░    ░██ ░██ ░██ ██░░░░██  ░██  ░██ ██░░░░██  ░░░░░██░██░░░░  ░██
  ░██  ░██ ███░░██████   ███ ░██ ░██░░████████ ███  ░██░░████████  █████ ░░██████░███
  ░░   ░░ ░░░  ░░░░░░   ░░░  ░░  ░░  ░░░░░░░░ ░░░   ░░  ░░░░░░░░  ░░░░░   ░░░░░░ ░░░
RANGER-DESENHO

  echo ""
  read -rep "$(echo -e $CAC) - Qual gerenciador de arquivos para terminal? $(echo -e $LETRA)R$(echo -e $RESETLETRA)ANGER, $(echo -e $LETRA)Y$(echo -e $RESETLETRA)AZI - (r,y,n) ... " RAG

  case "$RAG" in
  s | S)
    FILEMANAGER='RANGER'
    ;;
  y | Y)
    FILEMANAGER='YAZI'
    ;;
  n | N)
    echo -e "$CNT - RANGER NAO SERÁ INSTALADO."
    ;;
  *)
    rangerfm
    ;;
  esac

  if [[ $FILEMANAGER = RANGER ]]; then

    echo -en "$ESPEPACMAN"
    run_with_spinner "Instalando ranger" sudo xbps-install -y ranger ueberzug ffmpegthumbnailer #&>>$INSTLOG & show_progress $!

    if [ ! -d ~/.config/ranger/ ]; then
      mkdir --parents ~/.config/ranger/
    fi
    if [ -f ~/.config/ranger/rc.conf ]; then
      echo -e "$COK - ARQUIVO RC.CONF."
    else
      echo -en "$CONFIGANDO - RC."
      ranger --copy-config=rc #&>>$INSTLOG & show_progress $!
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
      echo -e "$COK - ARQUIVO SCOPE.SH."
    else
      echo -en "$CONFIGANDO - SCOPE."
      ranger --copy-config=scope #&>>$INSTLOG & show_progress $!
      sleep 0.2
      sed -i '113,116s/#//' $HOME/.config/ranger/scope.sh
      sleep 0.2
      sed -i '157,160s/#//' $HOME/.config/ranger/scope.sh
    fi
    if [ -f ~/.config/ranger/rifle.conf ]; then
      echo -e "$COK - ARQUIVO RIFLE.CONF."
    else
      echo -en "$CONFIGANDO - RIFLE."
      ranger --copy-config=rifle #&>>$INSTLOG & show_progress $!
      sed -i 's/mime ^audio|ogg$, terminal, has mplayer  = mplayer -- "$@"/mime ^audio|ogg$, terminal, has moc      = ncmpcpp -- "$@"/g' $HOME/.config/ranger/rifle.conf
      sleep 0.2
      sed -i '/label wallpaper, number 15, mime ^image, has feh, X = wal -i "$1"/d' $HOME/.config/ranger/rifle.conf
      sleep 0.2
      sed -i 's/label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"/label wallpaper, number 14, mime ^image, has feh, X = feh --bg-fill "$1"\nlabel wallpaper, number 15, mime ^image, has feh, X = wal -i "$1"/g' $HOME/.config/ranger/rifle.conf
    fi

    # ranger --version
    ranger_versao=$(ranger --version | grep ranger | cut -d: -f2 | sed s/^" "//g | tr a-z A-Z)
    echo -e "$COK - $ranger_versao INSTALADO."

  fi
if [[ $FILEMANAGER = YAZI ]]; then
  run_with_spinner "Instalando yazi" sudo xbps-install -y yazi ffmpeg 7zip jq poppler fd ripgrep zoxide ImageMagick #&>>$INSTLOG & show_progress $!
  cp --recursive --force ./.config/yazi ~/.config/
else
  echo ""
fi

} # filemanager <-


# ncmpcpp ->
playermusica() {
  sleep 0.2
  cat <<PLAYMSC
                              ██████          ██████  ██████
 ███████   █████  ██████████ ░██░░░██  █████ ░██░░░██░██░░░██
░░██░░░██ ██░░░██░░██░░██░░██░██  ░██ ██░░░██░██  ░██░██  ░██
 ░██  ░██░██  ░░  ░██ ░██ ░██░██████ ░██  ░░ ░██████ ░██████
 ░██  ░██░██   ██ ░██ ░██ ░██░██░░░  ░██   ██░██░░░  ░██░░░
 ███  ░██░░█████  ███ ░██ ░██░██     ░░█████ ░██     ░██
░░░   ░░  ░░░░░  ░░░  ░░  ░░ ░░       ░░░░░  ░░      ░░
PLAYMSC
  echo ""
  read -rep "$(echo -e $CAC) - Quer instalar o player de música? - (s,n) ... " PLMC
  case "$PLMC" in
  s | S)
    echo -en "$ESPEPACMAN"
    run_with_spinner "Instalando ncmpcpp" sudo xbps-install -y ncmpcpp mpd mpc #&>>$INSTLOG & show_progress $!
    # sudo systemctl --user enable --now mpd.service &>>$INSTLOG

    if [ ! -d ~/Músicas ]; then
      mkdir -p ~/Músicas
    fi

    sudo rm -f /etc/mpd.conf

    mkdir -p ~/.config/mpd
    # cp /usr/share/doc/mpd/mpdconf.example ~/.config/mpd/mpd.conf
    curl https://raw.githubusercontent.com/MusicPlayerDaemon/MPD/refs/heads/master/doc/mpdconf.example -o ~/.config/mpd/mpd.conf
    #music_directory    "~/music"
    sed -i '0,/#music_directory/s//music_directory/' ~/.config/mpd/mpd.conf
    sed -i 's/~\/music/~\/Músicas/g' ~/.config/mpd/mpd.conf
    #playlist_directory   "~/.mpd/playlists"
    sed -i 's/#playlist_directory/playlist_directory/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/playlists/~\/.config\/mpd\/playlists/g' ~/.config/mpd/mpd.conf
    #db_file      "~/.mpd/database"
    sed -i 's/#db_file/db_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/database/~\/.config\/mpd\/database/g' ~/.config/mpd/mpd.conf
    #log_file     "~/.mpd/log"
    sed -i 's/#log_file/log_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/log/~\/.config\/mpd\/log/g' ~/.config/mpd/mpd.conf
    #pid_file     "~/.mpd/pid"
    sed -i 's/#pid_file/pid_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/pid/~\/.config\/mpd\/pid/g' ~/.config/mpd/mpd.conf
    #state_file     "~/.mpd/state"
    sed -i 's/#state_file/state_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/state/~\/.config\/mpd\/state/g' ~/.config/mpd/mpd.conf
    #sticker_file     "~/.mpd/sticker.sql"
    sed -i 's/#sticker_file/sticker_file/g' ~/.config/mpd/mpd.conf
    sed -i 's/~\/.mpd\/sticker/~\/.config\/mpd\/sticker/g' ~/.config/mpd/mpd.conf
    #bind_to_address    "any"
    sed -i 's/#bind_to_address/bind_to_address/g' ~/.config/mpd/mpd.conf
    sed -i 's/"any"/"127.0.0.1"/g' ~/.config/mpd/mpd.conf
    #port       "6600"
    sed -i 's/#port/port/g' ~/.config/mpd/mpd.conf
    #auto_update  "yes"
    sed -i 's/#auto_update/auto_update/g' ~/.config/mpd/mpd.conf
    #follow_inside_symlinks   "yes"
    sed -i 's/#follow_inside_symlinks/follow_inside_symlinks/g' ~/.config/mpd/mpd.conf
    # socket
    sed -i 's/~\/.mpd\/socket/~\/.config\/mpd\/socket/g' ~/.config/mpd/mpd.conf
    #filesystem_charset   "UTF-8"
    sed -i 's/#filesystem_charset/filesystem_charset/g' ~/.config/mpd/mpd.conf

    echo 'audio_output {
          type  "pulse"
          name  "pulseaudio"
    }

    audio_output {
    type               "fifo"
    name               "Visualizer"
    path               "/tmp/mpd.fifo"
    format             "44100:16:2"
    }' >> ~/.config/mpd/mpd.conf


    mkdir -p ~/.config/mpd/playlists

    sudo ln -s /etc/sv/mpd /var/service


##############################################################################


    # more info @ https://wiki.archlinux.org/index.php/ncmpcpp

    sudo xbps-install ncmpcpp

    mkdir -p ~/.config/ncmpcpp
    cp /usr/share/doc/ncmpcpp/config ~/.config/ncmpcpp/config
    sed -i 's/#ncmpcpp_directory/ncmpcpp_directory/g' ~/.config/ncmpcpp/config
    sed -i 's/#lyrics_directory/lyrics_directory/g' ~/.config/ncmpcpp/config
    sed -i 's/#mpd_host/mpd_host/g' ~/.config/ncmpcpp/config
    sed -i 's/#mpd_port/mpd_port/g' ~/.config/ncmpcpp/config
    sed -i 's/#mpd_connection_timeout/mpd_connection_timeout/g' ~/.config/ncmpcpp/config
    sed -i 's/#mpd_music_dir = ~\/music/mpd_music_dir = ~\/Músicas/g' ~/.config/ncmpcpp/config
    sed -i 's/#mpd_crossfade_time/mpd_crossfade_time/g' ~/.config/ncmpcpp/config
    cp /usr/share/doc/ncmpcpp/bindings ~/.config/ncmpcpp/bindings
    echo -en "$CONFIGANDO"
    sudo rm -f /etc/mpd.conf
    echo -e "$COK - MPD MPC NCMPCPP."
    echo -e "$CAT - REINICIE O SYSTEMA PARA DAR INICIO AO MPD."

    ;;
  n | N)
    echo -e "$CNT - NCMPCPP NAO SERÁ INSTALADO."
    ;;
  *)
    playermusica
    ;;
  esac

} # ncmpcpp <-


# instalação ohmyzsh ->
ohmyzsh() {
  sleep 0.2

  if [[ ! -d ~/.oh-my-zsh ]]; then
    # sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    sleep 0.2
    chsh -s $(which zsh)
    echo -e "$COK - OH-MY-ZSH."
  else
    echo -e "$CAT - JÁ EXISTE OH-MY-ZSH NO SISTEMA."
  fi

} # instalação ohmyzsh <-


# configurações extras zsh ->
alias_autopair() {
  sleep 0.2

  # zsh alias, autopair
  if [[ ! -f ~/.config/zsh/alias.zsh ]]; then
    mkdir --parents ~/.config/zsh/
    cp ./.config/zsh/alias.zsh ~/.config/zsh/
    echo -e "$COK - ZSH ALIAS."
  fi

  if [[ ! -f ~/.config/zsh/vim-mode.zsh ]]; then
    mkdir --parents ~/.config/zsh/
    cp ./.config/zsh/vim-mode.zsh ~/.config/zsh/
    echo -e "$COK - PLUGIN ZSH VI-MODE."
  fi

  if [[ ! -f ~/.config/zsh/custom_extra_config.zsh ]]; then
    mkdir --parents ~/.config/zsh/
    cp ./.config/zsh/custom_extra_config.zsh ~/.config/zsh/
    echo -e "$COK - PLUGIN ZSH EXTRAS."
  fi

  sleep 0.2

  if [[ -f ~/.zshrc ]]; then
    sed -i '/^\[\[ \!/d' $HOME/.zshrc
    echo "[[ ! -f ~/.config/zsh/custom_extra_config.zsh ]] || source ~/.config/zsh/custom_extra_config.zsh" >>$HOME/.zshrc
    sed -i '/(git)/s/git/git extract universalarchive systemd/' $HOME/.zshrc
  fi

  sleep 0.2
  echo -e "$COK - ZSH COM CONFIGURACAO EXTRA."

} # configurações extras zsh <-


# distribuiçãp astronvim ->
editordeTexto() {
  sleep 0.2

  cat <<ASTRONVIM-DESENHO
                     ██                                       ██
                    ░██                                      ░░
  ██████    ██████ ██████ ██████  ██████    ███████  ██    ██ ██ ██████████
 ░░░░░░██  ██░░░░ ░░░██░ ░░██░░█ ██░░░░██  ░░██░░░██░██   ░██░██░░██░░██░░██
  ███████ ░░█████   ░██   ░██ ░ ░██   ░██   ░██  ░██░░██ ░██ ░██ ░██ ░██ ░██
 ██░░░░██  ░░░░░██  ░██   ░██   ░██   ░██   ░██  ░██ ░░████  ░██ ░██ ░██ ░██
░░████████ ██████   ░░██ ░███   ░░██████    ███  ░██  ░░██   ░██ ███ ░██ ░██
 ░░░░░░░░ ░░░░░░     ░░  ░░░     ░░░░░░    ░░░   ░░    ░░    ░░ ░░░  ░░  ░░
ASTRONVIM-DESENHO

  echo ""
  echo -en "$ESPEPACMAN"
  run_with_spinner "Instalando neovim" sudo xbps-install -y neovim python3-neovim #&>>$INSTLOG & show_progress $!

  if [[ ! -d ~/.config/nvim ]]; then
    echo -en "$CONFIGANDO - ESTADO ORIGINAL."
    git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim #&>>$INSTLOG & show_progress $!
    rm -rf ~/.config/nvim/.git
    #(nvim --headless -c 'quitall')
  else
    read -rep "$(echo -e $CAC) - Já existe um diretório nvim, você deseja reinstalar astronvim? - (s,n) ... " ASTRONV

    case "$ASTRONV" in
    s | S)
      rm -rf ~/.config/nvim/
      echo -en "$CONFIGANDO"
      git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim #&>>$INSTLOG & show_progress $!
      rm -rf ~/.config/nvim/.git
      #(nvim --headless -c 'quitall')
      ;;
    n | N)
      echo -e "$CNT - ASTRONVIM NAO SERÁ REINSTALADO."
      ;;
    *)
      editordeTexto
      ;;
    esac
  fi
    echo -en "$CONFIGANDO - PERSONALIZAÇAO."
    sleep 1 # keybinds
    curl https://raw.githubusercontent.com/quebravel/astronvim_config/refs/heads/main/mappings.lua -o ~/.config/nvim/lua/plugins/mappings.lua
    sleep 1 # options
    curl https://raw.githubusercontent.com/quebravel/astronvim_config/refs/heads/main/options.lua -o ~/.config/nvim/lua/plugins/options.lua

  echo -e "$COK - ASTRONVIM INSTALADO."

} # distribuiçãp astronvim <-


# tema para grub ->
dedsec() {
  if ! git clone --depth 1 https://github.com/VandalByte/dedsec-grub2-theme.git ~/dedsec-grub2-theme ; then
    (cd ~/dedsec-grub2-theme && sudo python3 dedsec-theme.py --uninstall)
    (cd ~/dedsec-grub2-theme && sudo python3 dedsec-theme.py --install)
  else
    rm -rf ~/dedsec-grub2-theme/
    git clone --depth 1 https://github.com/VandalByte/dedsec-grub2-theme.git ~/dedsec-grub2-theme
    (cd ~/dedsec-grub2-theme && sudo python3 dedsec-theme.py --install)
  fi

} # tema para grub <-


finalizado() {
  cat <<TERMINADO
   ████ ██                     ██ ██                       ██
  ░██░ ░░                     ░██░░                       ░██
 ██████ ██ ███████   ██████   ░██ ██ ██████  ██████       ░██  ██████
░░░██░ ░██░░██░░░██ ░░░░░░██  ░██░██░░░░██  ░░░░░░██   ██████ ██░░░░██
  ░██  ░██ ░██  ░██  ███████  ░██░██   ██    ███████  ██░░░██░██   ░██
  ░██  ░██ ░██  ░██ ██░░░░██  ░██░██  ██    ██░░░░██ ░██  ░██░██   ░██
  ░██  ░██ ███  ░██░░████████ ███░██ ██████░░████████░░██████░░██████
  ░░   ░░ ░░░   ░░  ░░░░░░░░ ░░░ ░░ ░░░░░░  ░░░░░░░░  ░░░░░░  ░░░░░░
TERMINADO

sudo ln -s /etc/sv/greetd /var/service/
}


### inicializadores de funcao
inicio
driveVideo
windowManger
services_runit
arquivosdeConfiguracao
displayManager
zshinstall
fontes_doSistema
navegador
temas
audio_config
rangerfm
playermusica
ohmyzsh
alias_autopair
editordeTexto
dedsec

finalizado
