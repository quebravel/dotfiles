#!/bin/bash

opcao=$1

mounta(){
    picom & select=`lsblk | grep  "─sd" | cut -c 7-10,22-29 | rofi -dmenu -p "Selecionar"` && dispositivo=`echo $select | cut -c 1-4` && echo -e "Montar\n" | rofi -dmenu -password -p "Digite a senha" | sudo -S mount -t auto /dev/$dispositivo /mnt && dunstify -u normal -t 2000 "Montando" "/mnt" ; pkill picom
}

Desmounta(){
    picom & echo -e "Digite a senha\n" | rofi -dmenu -password -p "Desmontando" | sudo -S umount -Rf /mnt ; dunstify -u normal -t 1500 "Desmontado" "/mnt" ; pkill picom
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
