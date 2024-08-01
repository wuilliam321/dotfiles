#!/bin/bash
# Comprueba que se ha proporcionado el directorio y el comando
if [ $# -lt 3 ]; then
  echo "Usage: $0 <path-to-directory> <file-type> <command-to-execute>"
  exit 1
fi

DIRECTORY=$1
FILE_TYPE=$2
COMMAND=$3

echo "listening for changes in $DIRECTORY with file type $FILE_TYPE"

# Usa fswatch para monitorear los archivos `.go` y ejecutar un comando proporcionado
# fswatch -o $DIRECTORY | grep "\.$FILE_TYPE$" | while read file
# fswatch -o $DIRECTORY | grep "\.go$" | while read file
fswatch -e ".*" -i "\\.$FILE_TYPE$" $DIRECTORY | while read file
do
  echo "Changed: $file\n runnnig $COMMAND"
  $COMMAND
  echo "done"
done
