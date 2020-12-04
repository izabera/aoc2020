#!/bin/bash

mapfile -t map # < ../input

width=${#map}
height=${#map[@]}

for (( i = j = 0; i < height; j += 3, i++ )) do
    [[ ${map[i]:j%width:1} == . ]]
    (( trees += $? ))
done
echo $trees
