#!/bin/env bash

# fork script of https://github.com/Axarva/dotfiles-2.0/tree/main
# fork script of https://github.com/SolDoesTech/HyprV4/blob/2cf439c27475a32fd00e816a1fde82a5804efe2a/set-hypr

# cores letras de seleçao
LETRA="\e[1;36m"
RESETLETRA="\e[0m"

# cores
AZUL="[\e[1;36mNOTA\e[0m]"    #azul -cnt
VERD="[\e[1;32mOK\e[0m]"      #verde -cok
VERM="[\e[1;31mERRO\e[0m]"    #vermelhor claro -cer
BRAN="[\e[1;37mATENCAO\e[0m]" #branco -cat
ROXO="[\e[1;35mALERTA\e[0m]"  #roxo claro -cwr
AMAR="[\e[1;33mACAO\e[0m]"    #amarelo -cac
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

# install_software() {
#   # First lets see if the package is there
#   if $HELPER -Q $1 &>>/dev/null; then
#     echo -e "$AZUL - $1 JÁ ESTÁ INSTALADO."
#   else
#     # no package found so installing
#     echo -en "$VERD - INSTALANDO AGORA $1 ."
#     $HELPER -S --noconfirm $1 &>>$INSTLOG & show_progress $!
#     # test to make sure package installed
#     if $HELPER -Q $1 &>>/dev/null; then
#       echo -e "\e[1A\e[K$AZUL - $1 FOI INSTALADO."
#     else
#       # if this is hit then a package is missing, exit to review log
#       echo -e "\e[1A\e[K$VERM - $1 INSTALAÇAO FALHOU VEJA O ARQUIVO DE LOG EM $HOME/install.log"
#       exit
#     fi
#   fi
# }
install_software_xbps-install() {
  # instala pacotes com pacman
  # echo -en "$ESPEPACMAN - ATUALIZAÇAO DO SISTEMA."
  for PKGS in ${1}; do
    sudo xbps-install -Sy "${PKGS}" &>>$INSTLOG & show_progress $!
  done
}

# porte 1
inicio() {
  set -e

  clear

  toilet -f ./3d -F metal -t "install on void"

  cat <<EOL



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

  read -rep "$(echo -e $AMAR) - Esta pronto para continuar? - (s,n) ... " CONTINUAR
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
  echo -e "$AMAR - FAZENDO UMA ATUALIZAÇÃO DO SISTEMA, PODE ACONTECER QUE AS COISAS QUEBREM SE NÃO FOR A VERSÃO MAIS RECENTE."
  echo -e $ESPEPACMAN
  if ! sudo pacman --noconfirm -Syu; then
    echo -e "$VERM - ERRO NA ATUALIZAÇAO."
  fi

  # install base-devel if not installed
  echo -en "$ESPEPACMAN"
  install_software_xbps-install "base-devel wget git" &>>$INSTLOG & show_progress $!

} ### inicio
