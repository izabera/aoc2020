#!/bin/bash -f

mapfile -t code

declare -A swap=([jmp]=nop [nop]=jmp)

for (( fix = 0; fix < ${#code[@]}; fix++ )) do
    ins=(${code[fix]})
    if [[ ${swap[$ins]} ]]; then
        code[fix]="${swap[$ins]} ${ins[1]}"
    else
        continue
    fi

    acc=0 ip=0
    executed=()
    until (( executed[ip]++ || ip == ${#code[@]} )); do
        ins=(${code[ip]})
        case $ins in
            jmp) (( ip += ins[1] )) ;;
            acc) (( acc += ins[1] )) ;&
            nop) (( ip ++ ))
        esac
    done

    ins=(${code[fix]})
    code[fix]="${swap[$ins]} ${ins[1]}"

    if (( ip == ${#code[@]} )); then
        echo $acc
        break
    fi
done
