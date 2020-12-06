#!/usr/bin/awk -f
BEGIN { for (i = 97; i < 97+26; i++) letters[sprintf("%c", i)] = 1; RS = "" }
{
    delete set
    for (i = 1; i <= NF; i++)
        for (l in letters)
            set[l] += $i ~ l

    for (i in set)
        sum += set[i] == NF
}
END { print sum }
