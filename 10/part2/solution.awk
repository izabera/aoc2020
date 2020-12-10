#!/usr/bin/awk -Mf

function recurse(n) {
    if (n in memo) return memo[n]
    if (!(n in a)) return memo[n] = 0

    return memo[n] = recurse(n + 1) + recurse(n + 2) + recurse(n + 3)
}

{ a[$0] }
win < $0 { win = $0 }

END {
    a[0]
    memo[win] = 1
    print recurse(0)
}
