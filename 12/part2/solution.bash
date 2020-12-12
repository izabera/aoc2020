#!/bin/bash

wN=1 wS=0 wE=10 wW=0 # waypoint
sN=0 sS=0 sE=0  sW=0 # ship

while read; do
    cmd=${REPLY::1} val=${REPLY:1}

    case $cmd in
        [NSEW]) (( w$cmd += val )) ;;

        F) (( sN += wN * val, 
              sE += wE * val, 
              sS += wS * val, 
              sW += wW * val  )) ;;

        R) for (( i = 0; i < val/90; i++ )) do
               tmp=$wN wN=$wW wW=$wS wS=$wE wE=$tmp
           done ;;
        L) for (( i = 0; i < val/90; i++ )) do
               tmp=$wN wN=$wE wE=$wS wS=$wW wW=$tmp
           done ;;
    esac
done

sns=$((sN - sS)) sns=${sns#-}
sew=$((sE - sW)) sew=${sew#-}
echo $(( sns + sew ))
