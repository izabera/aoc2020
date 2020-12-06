#!/usr/bin/awk -f
BEGIN { for (i = 97; i < 97+26; i++) letters[sprintf("%c", i)] = 1; RS = "" }
{ for (l in letters) sum += $0 ~ l }
END { print sum }
