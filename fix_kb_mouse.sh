#!/bin/bash
# fix the keyboard
# xmodmap /home/wuilliam/.Xmodmap

# fix the scroll
mouse=$(xinput list | grep 'Wheel Mouse')
echo $mouse
mouseId=$(echo $mouse | grep 'Wheel Mouse' | grep -o 'id=[0-9]*' | sed 's/id=//')
echo $mouseId
naturalScroll=$(xinput list-props $mouseId | grep 'Natural Scrolling Enabled (' )
echo $naturalScroll
propId=$(echo $naturalScroll | grep -o '[0-9]*' | head -1)

echo "xinput set-prop $mouseId $propId 1"
xinput set-prop $mouseId $propId 1
