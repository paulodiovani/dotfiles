#!/bin/bash
prefix="$HOME/Imagens/Screenshots/"
date="$(date -Is)"
type='png'
quality='90'
#wnd='-window root'
wnd=''
 
function help(){
    cat << EOF
        Usage: `basename $0` [options] [filename]
        Options:
        -f fullscreen shot 
        -r region shot (region)
        -w single window shot
EOF
        exit 1
}
 
while getopts fwr opt; do
case "$opt" in
    f) wnd='-window root' ;;
    w) wnd="-window $(xwininfo | awk '/Window\ id:/{print $4}')" ;;
    r) wnd='' ;;
    ?) help ;;
esac
done
 
shift  $((OPTIND-1))
 
if [ "x$1" == "x" ]
then
    i=0
    name=${prefix}$date.$type
    while [ -f "$name" ]; do
        i=$(($i+1))
        name=${prefix}${date}_$i.$type
    done
else
    name=$1
fi
 
import $wnd -quality $quality $name
