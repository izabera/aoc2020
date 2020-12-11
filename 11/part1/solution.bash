#!/bin/bash

#   L.LL.LL.LL
#   LLLLLLL.LL
#   L.L.L..L..
#   LLLL.LL.LL
#   L.LL.LL.LL
#   L.LLLLL.LL
#   ..L.L.....
#   LLLLLLLLLL
#   L.LLLLLL.L
#   L.LLLLL.LL

mapfile -t grid

w=${#grid} h=${#grid[@]}

grid=("${grid[@]/#/.}")
grid=("${grid[@]/%/.}")
border=${grid//?/.}
grid=("$border" "${grid[@]}" "$border")
tmpgrid=("$border" [h+1]="$border")

freestep=( \# L  L  L  L L L L L)
takenstep=(\# \# \# \# L L L L L)

while :; do
    #for (( i = 1; i <= h; i++ )) do
    for ((i=1;i<=h;i++)) do
        tmpgrid[i]=.
        #for (( j = 1; j <= w; j++ )) do
        for ((j=1;j<=w;j++)) do
        #   occupied=0
        #   [[ ${grid[i-1]:j-1:1} != \# ]]; (( occupied += $? ))
        #   [[ ${grid[i-1]:j  :1} != \# ]]; (( occupied += $? ))
        #   [[ ${grid[i-1]:j+1:1} != \# ]]; (( occupied += $? ))
        #   [[ ${grid[i  ]:j-1:1} != \# ]]; (( occupied += $? ))
        #  #[[ ${grid[i  ]:j  :1} != \# ]]; (( occupied += $? ))
        #   [[ ${grid[i  ]:j+1:1} != \# ]]; (( occupied += $? ))
        #   [[ ${grid[i+1]:j-1:1} != \# ]]; (( occupied += $? ))
        #   [[ ${grid[i+1]:j  :1} != \# ]]; (( occupied += $? ))
        #   [[ ${grid[i+1]:j+1:1} != \# ]]; (( occupied += $? ))
            o=0
            [[ ${grid[i-1]:j-1:1} != \# ]]; ((o+=$?))
            [[ ${grid[i-1]:j:1}   != \# ]]; ((o+=$?))
            [[ ${grid[i-1]:j+1:1} != \# ]]; ((o+=$?))
            [[ ${grid[i]:j-1:1}   != \# ]]; ((o+=$?))
           #[[ ${grid[i]:j:1}     != \# ]]; ((o+=$?))
            [[ ${grid[i]:j+1:1}   != \# ]]; ((o+=$?))
            [[ ${grid[i+1]:j-1:1} != \# ]]; ((o+=$?))
            [[ ${grid[i+1]:j:1}   != \# ]]; ((o+=$?))
            [[ ${grid[i+1]:j+1:1} != \# ]]; ((o+=$?))
            case ${grid[i]:j:1} in
                .) tmpgrid[i]+=. ;;
                L) tmpgrid[i]+=${freestep[o]} ;;
               \#) tmpgrid[i]+=${takenstep[o]} ;;
            esac
        done
        tmpgrid[i]+=.
    done

    [[ ${grid[*]} == ${tmpgrid[*]} ]] && break

    grid=("${tmpgrid[@]}")
done

occupied=${grid[*]} occupied=${occupied//[!#]}
echo ${#occupied}
