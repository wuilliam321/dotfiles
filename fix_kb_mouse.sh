#!/bin/bash
# fix the keyboard
xmodmap /home/wuilliam/personal/xmodmap

# fix the scroll
mouse=$(xinput list | grep 'Wheel Mouse')
echo $mouse
mouseId=$(echo $mouse | grep 'Wheel Mouse' | awk '{match($0, /id=([0-9]+)/, arr); print arr[1]}')
echo $mouseId
naturalScroll=$(xinput list-props $mouseId | grep 'Natural Scrolling Enabled (' )
echo $naturalScroll
propId=$(echo $naturalScroll | awk '{match($0, /([0-9]+)/, arr); print arr[1]}')

echo "xinput set-prop $mouseId $propId 1"
xinput set-prop $mouseId $propId 1
