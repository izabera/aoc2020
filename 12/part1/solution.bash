#!/bin/bash

N=0 S=0 E=0 W=0

dir=E
R=(N E S W) L=(N W S E)
RN=0 RE=1 RS=2 RW=3
LN=0 LW=1 LS=2 LE=3

while read; do
    cmd=${REPLY::1} val=${REPLY:1}

    case $cmd in
        [NSEW]) (( $cmd += val )) ;;

        F) (( $dir += val )) ;;

        R) dir=${R[(R$dir+val/90)%4]} ;;
        L) dir=${L[(L$dir+val/90)%4]} ;;
    esac
done

ns=$((N - S)) ns=${ns#-}
ew=$((E - W)) ew=${ew#-}
echo $(( ns + ew ))
