#!/usr/bin/awk -f

BEGIN { nelems = 25 }
{ a[NR] = $0 }
NR <= nelems { next }

{
    for (i = NR - nelems; i < NR; i++)
        for (j = NR - nelems; j < NR; j++)
            if (i != j && a[i] + a[j] == $0)
                next
    print $0
}
