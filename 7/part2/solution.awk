#!/usr/bin/awk -f
{
    gsub(/bags?|contain|[.,]/, "", $0)
    $0 = $0

    outer = $1 $2
    for (i = 3; i <= NF; i += 3) {
        n = $i
        inner = $(i+1) $(i+2)

        containedby[inner][outer]
        if (n != "no")
            contains[outer][inner] = n
        else
            count[outer] = 1
    }
}

function recurse(x, total, i) {
    if (count[x])
        return
    total = 1
    for (i in contains[x]) {
        recurse(i)
        total += contains[x][i] * count[i]
    }
    count[x] = total
}

END {
    recurse("shinygold")
    print count["shinygold"] - 1
}
