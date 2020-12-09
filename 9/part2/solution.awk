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

END {
    i = 1
    j = 2
    sum = a[i] + a[j]
    while (sum != target || i == j) {
        if (sum > target)
        {
            sum -= a[i]
            i++
        }
        else
        {
            j++
            sum += a[j]
        }
    }
    low = hi = a[i]
    for (q = i; q <= j; q++) {
        if (low > a[q])
            low = a[q]
        if (hi < a[q])
            hi = a[q]
    }
    print low + hi
}
