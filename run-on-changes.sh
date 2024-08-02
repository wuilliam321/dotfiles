#!/bin/bash
if [ $# -lt 3 ]; then
  echo "Usage: $0 <path-to-directory> <file-type> <command-to-execute>"
  exit 1
fi

DIRECTORY=$1
FILE_TYPE=$2
COMMAND=$3
LOCKFILE="/tmp/command_lock.tmp"
echo "Listening for changes in $DIRECTORY with file type $FILE_TYPE"

fswatch -e ".*" -i "\\.$FILE_TYPE$" $DIRECTORY | while read file
do
  if [ ! -f $LOCKFILE ]; then
    touch $LOCKFILE
    clear
    echo "$COMMAND"
    ($COMMAND; rm $LOCKFILE) &
  fi
done
