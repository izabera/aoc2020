#!/bin/bash

declare -A pairs=() containedby=() contains=() count=()
shopt -s extglob

IFS+=.,

no=0
while read -a arr; do
    arr=(${arr[@]//@(bag?(s)|contain)})

    out=${arr[0]}${arr[1]}
    for (( i = 2; i < ${#arr[@]}; i+=3 )) do
        n=${arr[i]}
        in=${arr[i+1]}${arr[i+2]}

        containedby[$in]+=,$out
        if (( n )); then
            contains[$out]+=,$in
            pairs[$out,$in]=$n
        else
            count[$out]=1
        fi
    done
done

declare -A ok
recurse () {
    for i do
        [[ ${ok[$i]} ]] && continue
        ok[$i]=x
        recurse ${containedby[$i]#,}
    done
}

recurse shinygold

echo $((${#ok[@]}-1))
