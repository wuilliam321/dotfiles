#!/bin/bash

# Array de frases o textos aleatorios
textos=("Frase 1" "Frase 2" "Texto Inspirador" "Otra Frase")

# Obtener un índice aleatorio
random_index=$((RANDOM % ${#textos[@]}))

# Mostrar el texto aleatorio
echo "${textos[$random_index]}"
