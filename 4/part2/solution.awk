#!/usr/bin/awk -f
BEGIN { RS = ""; valid = 0 }

! (/byr:/ && /iyr:/ && /eyr:/ && /hgt:/ && /hcl:/ && /ecl:/ && /pid:/) { next }

function checkyear(value, low, high)
{
    return value ~ /^[0-9]{4}$/ && value >= low && value <= high
}

{
    for (i = 1; i <= NF; i++)
    {
        field = substr($i, 1, 3)
        value = substr($i, 5)

        if (field == "byr" && ! checkyear(value, 1920, 2002))
            next

        if (field == "iyr" && ! checkyear(value, 2010, 2020))
            next

        if (field == "eyr" && ! checkyear(value, 2020, 2030))
            next

        if (field == "hgt" && ! ( \
                ( value ~ /^[0-9]+cm$/ && value+0 >= 150 && value+0 <= 193 ) || \
                ( value ~ /^[0-9]+in$/ && value+0 >= 59  && value+0 <= 76 ) \
            ) )
            next

        if (field == "hcl" && ! (value ~ /^#[0-9a-f]{6}$/))
            next

        if (field == "ecl" && ! (value ~ /^(amb|blu|brn|gry|grn|hzl|oth)$/))
            next

        if (field == "pid" && ! (value ~ /^[0-9]{9}$/))
            next

    }
    valid ++
}

END { print valid }
