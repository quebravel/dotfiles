#!/bin/bash

if [ -d "~/Pendrive" ]
then
   echo "ok"
else
   mkdir -p ~/Pendrive
fi

opcao=$1

mounta(){
    select=`lsblk | grep  "─sd" | grep " 1 " | cut -c 7-10,22-29 | rofi -dmenu -p "Selecionar"` && dispositivo=`echo $select | cut -c 1-4` && echo -e "Montar\n" | rofi -dmenu -password -p "Digite a senha" | sudo -S mount -t auto /dev/$dispositivo ~/Pendrive && dunstify -u normal -t 2000 "Montando" "~/Pendrive"
}

Desmounta(){
    echo -e "Digite a senha\n" | rofi -dmenu -password -p "Desmontando" | sudo -S umount -Rl ~/Pendrive && dunstify -u normal -t 1500 "Desmontado" "~/Pendrive"
}

escolha(){
echo $opcao
case $opcao in
   "-m") mounta ;;
   "--mount") mounta ;;
   "-d") Desmounta ;;
   "--desmount") Desmounta ;;
   *) echo "Opção inválida! Use uma das seguintes opcoes:
       -m,--mount                  Monta dispositivo.
       -d,--desmount               Desmounta dispositivo."
      exit 1 ;;
esac
}

escolha

