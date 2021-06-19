#!/bin/bash

opcao=$1

mounta(){
    select=`lsblk | grep  "─sd" | grep " 1 " | cut -c 7-10,22-29 | dmenu -h 18 -nb "#3c3836" -nf "#fbf1c7" -sb "#bdae93" -sf "#1d2021" -fn "Source Code Pro-8" -p "Selecionar Pendrive"` && dispositivo=`echo $select | cut -c 1-4` && echo -e "Montar\n" | dmenu -mask -noinput -h 18 -nb "#3c3836" -nf "#fbf1c7" -sb "#bdae93" -sf "#1d2021" -fn "Source Code Pro-8" -p "Montando | Senha" | sudo -S mount -t auto /dev/$dispositivo /mnt && dunstify -u normal -t 2000 "Montando" "/mnt"
}

Desmounta(){
    echo -e "Digite a senha\n" | dmenu -mask -noinput -h 18 -nb "#3c3836" -nf "#fbf1c7" -sb "#bdae93" -sf "#1d2021" -fn "Source Code Pro-8" -p "Desmontando | Senha" | sudo -S umount -Rf /mnt && dunstify -u normal -t 1500 "Desmontado" "/mnt"
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
