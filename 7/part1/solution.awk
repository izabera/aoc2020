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

function recurse(x) {
    if (ok[x])
        return
    if (!length(containedby[x]))
        return
    for (i in containedby[x])
        recurse(i)
    ok[x]
}

END {
    recurse("shinygold")
    print length(ok) - 1
}
