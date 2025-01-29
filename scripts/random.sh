#!/bin/bash
# Leer los textos de phrases.txt
texto=$(cat /home/wuilliam/dotfiles/scripts/phrases.txt| shuf -n 1)
echo $texto
