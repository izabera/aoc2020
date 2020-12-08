#!/bin/bash

mapfile -t code
executed=()

acc=0 ip=0
until [[ ${executed[ip]} ]]; do
    executed[ip]=x
    ins=(${code[ip]})
    case $ins in
        jmp) (( ip += ins[1] )) ;;
        acc) (( acc += ins[1] )) ;&
        nop) (( ip ++ ))
    esac
done

echo $acc
