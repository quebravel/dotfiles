#!/bin/sh


# fork script of https://github.com/Axarva/dotfiles-2.0/tree/main
# fork script of https://github.com/SolDoesTech/HyprV4/blob/2cf439c27475a32fd00e816a1fde82a5804efe2a/set-hypr

# cores letras de seleçao
LETRA="\e[1;36m"
RESETLETRA="\e[0m"

# cores
CNT="[\e[1;36mNOTA\e[0m]" #azul
COK="[\e[1;32mOK\e[0m]" #verde
CER="[\e[1;31mERRO\e[0m]" #vermelhor claro
CAT="[\e[1;37mATENCAO\e[0m]" #branco
CWR="[\e[1;35mALERTA\e[0m]" #roxo claro
CAC="[\e[1;33mACAO\e[0m]" #amarelo
INSTLOG="$HOME/install.log"
FIN_INST="&>> $INSTLOG & show_progress $!"
ESPEPACMAN="[\e[1;37mEXECUTANDO\e[0m"
CONFIGANDO="[\e[1;37mCONFIGURANDO\e[0m"

install_software_pkg() {
    # instala pacotes com pkg
    for PKGS in ${1}; do
    pkg install -y "${PKGS}" #&>> $INSTLOG & show_progress $!
    done
}

# parte 1
inicio(){
    set -e

    clear

cat <<EOL

                Script de preparacao para usar um wm no freebsd.

EOL

    sleep 0.2

    read -rep "$(echo -e $CAC) - Esta pronto para continuar? - (s,n) ... " CONTINUAR
    case "$CONTINUAR" in
        s|S) echo ""
        ;;
        n|N) exit 1
        ;;
        *) inicio
        ;;
    esac
    pkg upgrade

    sleep 0.2

    install_software_pkg "sudo neovim zsh zsh-completions"
}
config_zsh(){
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

}
inicio
config_zsh

