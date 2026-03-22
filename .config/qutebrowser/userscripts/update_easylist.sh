#!/bin/bash

# URL do arquivo
URL="https://easylist.to/easylist/easylist.txt"

# Diretório de destino
DIR="$HOME/.config/qutebrowser"

# Nome do arquivo final
FILE="$DIR/blockedHosts"

# Arquivo temporário
TMP_FILE="${FILE}.tmp"

# Garante que o diretório existe
mkdir -p "$DIR"

echo "Baixando lista..."
notify-send "Baixando lista..."

# Baixa o arquivo para temporário
curl -fsSL "$URL" -o "$TMP_FILE"

# Verifica erro no download
if [ $? -ne 0 ]; then
    echo "Erro ao baixar o arquivo."
    notify-send "Erro ao baixar o arquivo."
    rm -f "$TMP_FILE"
    exit 1
fi

# Se não existir ainda, salva direto
if [ ! -f "$FILE" ]; then
    mv "$TMP_FILE" "$FILE"
    echo "Arquivo salvo pela primeira vez em $FILE"
    notify-send "Arquivo salvo pela primeira vez"
    exit 0
fi

# Compara arquivos
if cmp -s "$TMP_FILE" "$FILE"; then
    echo "Nenhuma atualização encontrada."
    notify-send "Nenhuma atualização encontrada."
    rm -f "$TMP_FILE"
else
    mv "$TMP_FILE" "$FILE"
    echo "Arquivo atualizado com sucesso em $FILE"
    notify-send "Arquivo atualizado com sucesso"
fi
