#!/bin/bash

opcao=$1

mounta(){
    select=`lsblk | grep  "─sd" | cut -c 7-10,22-29 | dmenu -h 45 -y 20 -nb "#0087ff" -nf "#000000" -sb "#fe8019" -sf "#000000" -fn "monaco-10" -p "Selecionar Pendrive"` && dispositivo=`echo $select | cut -c 1-4` && echo -e "Montar\n" | dmenu -mask -noinput -h 45 -y 20 -nb "#0087ff" -nf "#000000" -sb "#fe8019" -sf "#000000" -fn "monaco-10" -p "Montando | Senha" | sudo -S mount -t auto /dev/$dispositivo /mnt && dunstify -u normal -t 2000 "Montando" "/mnt"
}

Desmounta(){
    picom & echo -e "Digite a senha\n" | dmenu -mask -noinput -h 45 -y 20 -nb "#0087ff" -nf "#000000" -sb "#fe8019" -sf "#000000" -fn "monaco-10" -p "Desmontando | Senha" | sudo -S umount -Rf /mnt && dunstify -u normal -t 1500 "Desmontado" "/mnt" ; pkill picom
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
