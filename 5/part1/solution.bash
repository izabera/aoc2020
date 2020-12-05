while read; do
    REPLY=${REPLY//[BR]/1} REPLY=${REPLY//[FL]/0}
    echo $((2#$REPLY))
done | sort -n | tail -1
