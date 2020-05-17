#!/bin/bash


#variavel valor


t1='sleep 0.5'

opcao=$1

mounta(){
    select=`lsblk | grep  "─sd" | cut -c 7-10,22-29 | rofi -dmenu`
        echo $select
    dispositivo=`echo $select | cut -c 1-4`
        echo $dispositivo

        urxvt -e sudo mount -t auto /dev/$dispositivo /mnt
}

Desmounta(){
        urxvt -e sudo umount -Rf /mnt
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
