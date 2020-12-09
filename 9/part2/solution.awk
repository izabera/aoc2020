#!/usr/bin/awk -f

BEGIN { nelems = 25 }
{ a[NR] = $0 }
NR <= nelems { next }

{
    for (i = NR - nelems; i < NR; i++)
        for (j = NR - nelems; j < NR; j++)
            if (i != j && a[i] + a[j] == $0)
                next
    target = $0
    exit
}

function sum(i, j) {
    res = 0
    for (q = 0; q <= j; q++)
        res += a[i+q]
    return res
}

END {
    i = 1
    j = 1
    while (1) {
        res = sum(i, j)
        if (res == target) {
            low = hi = a[i]
            for (q = 0; q <= j; q++) {
                if (low > a[i+q])
                    low = a[i+q]
                if (hi < a[i+q])
                    hi = a[i+q]
            }
            print low + hi
            break
        }
        if (res > target)
        {
            i++
            j = 1
        }
        else {
            j++
        }
    }
}
