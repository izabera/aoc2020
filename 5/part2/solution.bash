while read; do
    REPLY=${REPLY//[BR]/1} REPLY=${REPLY//[FL]/0}
    echo $((2#$REPLY))
done | sort -n | awk 'NR == 1 { a = $0; next } $0 != a+1 { print a+1 } { a = $0 }'
