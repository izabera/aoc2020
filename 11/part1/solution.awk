#!/usr/bin/awk -f

BEGIN { FS = "" }

{ for (i = 1; i <= NF; i++ ) grid[NR][i] = $i }

END {
    w = length(grid[1])
    h = NR

    split("#LLLLLLLL", avail, //)
    split("####LLLLL", taken, //)

    while (1) {
        for ( i = 1; i <= h; i++ ) {
            for ( j = 1; j <= w; j++ ) {
                occupied = 1
                occupied += grid[i-1][j-1] == "#"
                occupied += grid[i-1][j  ] == "#"
                occupied += grid[i-1][j+1] == "#"
                occupied += grid[i  ][j-1] == "#"
               #occupied += grid[i  ][j  ] == "#"
                occupied += grid[i  ][j+1] == "#"
                occupied += grid[i+1][j-1] == "#"
                occupied += grid[i+1][j  ] == "#"
                occupied += grid[i+1][j+1] == "#"
                switch (grid[i][j]) {
                    case /L/: tmpgrid[i][j] = avail[occupied]; break
                    case /#/: tmpgrid[i][j] = taken[occupied]; break
                    default : tmpgrid[i][j] = 0
                }
            }
        }

        same = 1
        for ( i = 1; i <= h; i++ ) {
            for ( j = 1; j <= w; j++ ) {
                if (tmpgrid[i][j] != grid[i][j]) {
                    same = 0
                    grid[i][j] = tmpgrid[i][j]
                }
            }
        }
        if (same)
            break
    }


    occupied = 0
    for ( i = 1; i <= h; i++ )
        for ( j = 1; j <= w; j++ )
            occupied += grid[i][j] == "#"
    print occupied
}
