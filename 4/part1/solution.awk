#!/usr/bin/awk -f
BEGIN { RS = "" }
/byr:/ && /iyr:/ && /eyr:/ && /hgt:/ && /hcl:/ && /ecl:/ && /pid:/ { valid ++ }
END { print valid }
