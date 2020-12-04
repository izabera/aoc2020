#!/bin/bash

mapfile -t map # < ../input

width=${#map}
height=${#map[@]}

slopes=(
    1,1
    3,1
    5,1
    7,1
    1,2
)

for slope in ${slopes[@]}; do
    for (( trees = i = j = 0; i < height; j += ${slope%,*}, i += ${slope#*,} )) do
        [[ ${map[i]:j%width:1} == . ]]
        (( trees += $? ))
    done
    echo $trees
    results+=($trees)
done

IFS=*
echo $((${results[*]}))
