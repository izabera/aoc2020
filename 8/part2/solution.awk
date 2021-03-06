#!/usr/bin/awk -f

{ code[NR-1] = $1; arg[NR-1] = $2 }

END {
    swap["nop"] = "jmp"
    swap["jmp"] = "nop"

    for (fix = 0; fix < length(code); fix++) {
        if (code[fix] in swap)
            code[fix] = swap[code[fix]]
        else
            continue

        acc = 0
        ip = 0
        while (!(ip >= length(code) || ip < 0 || executed[ip] == fix)) {
            executed[ip] = fix
            switch (code[ip]) {
                case /jmp/: ip += arg[ip]; break
                case /acc/: acc += arg[ip]
                case /nop/: ip ++
            }
        }

        code[fix] = swap[code[fix]]
        if (ip == length(code)) {
            print acc
            break
        }
    }
}
