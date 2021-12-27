#!/bin/bash

# ずれる...
function trimID()
{
  name=$1
  id=`xinput|grep "${name}"|awk -d '{split($7,a,"="); print a[2]}'`
  echo $id
}

usage_exit() {
  echo "Usage: $0 [-a] [-d dir] item ..." 1>&2
  exit 1
}

while getopts :kth OPT
do
  case $OPT in
    k) kbd_id=`xinput|grep Translated|awk -d '{split($7,a,"="); print a[2]}'`
      xinput disable "${kbd_id}"
      echo "keyboard"
      ;;
    t) touchpad_id=`xinput|grep Touchpad|awk -d '{split($6,a,"="); print a[2]}'`
      xinput disable "${touchpad_id}"
      echo "touchpad"
      ;;
    h)  usage_exit
      ;;
  esac
done

