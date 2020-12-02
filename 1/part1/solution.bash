#!/bin/bash

a=( $(sort -n ../input) )

i=0 j=1

while :; do
    if (( (q = a[i] + a[-j]) < 2020 )); then
        ((i++))
    elif (( q > 2020 )); then
        ((j++))
    else
        echo "${a[i]} ${a[-j]} $(( a[i] * a[-j] ))"
        break
    fi
done
