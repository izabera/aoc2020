#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    fseek(stdin, 0L, SEEK_END);
    long size = ftell(stdin);
    fseek(stdin, 0L, SEEK_SET);

    char *file = malloc(size);
    fread(file, 1, size, stdin);

    int w = strcspn(file, "\n");
    int h = size / (w + 1);

    w += 2;
    h += 2;

    char (*   grid)[w] = malloc(w * h),
         (*tmpgrid)[w] = malloc(w * h);

    // border
    for (int i = 0; i < h; i++) {
        for (int j = 0; j < w; j++) {
            if (i == 0 || j == 0 || i == w - 1 || j == h - 1)
                grid[i][j] = '.';
            else
                grid[i][j] = file[(i-1) * (w-1) + (j-1)];
        }
    }

    memcpy(tmpgrid, grid, w * h);

    char avail[] = { '#', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L' };
    char taken[] = { '#', '#', '#', '#', 'L', 'L', 'L', 'L', 'L' };

    while (1) {
        for (int i = 1; i <= h; i++) {
            for (int j = 1; j <= w; j++) {
                int occupied = 0;
                occupied += grid[i-1][j-1] == '#';
                occupied += grid[i-1][j  ] == '#';
                occupied += grid[i-1][j+1] == '#';
                occupied += grid[i  ][j-1] == '#';
              //occupied += grid[i  ][j  ] == '#';
                occupied += grid[i  ][j+1] == '#';
                occupied += grid[i+1][j-1] == '#';
                occupied += grid[i+1][j  ] == '#';
                occupied += grid[i+1][j+1] == '#';

                switch (grid[i][j]) {
                    case 'L': tmpgrid[i][j] = avail[occupied]; break;
                    case '#': tmpgrid[i][j] = taken[occupied]; break;
                }
            }
        }

        if (!memcmp(grid, tmpgrid, w * h))
            break;

        void *tmp = grid;
        grid = tmpgrid;
        tmpgrid = tmp;
    }

    int occupied = 0;
    for (int i = 0; i < h; i++)
        for (int j = 1; j <= w; j++)
            occupied += grid[i][j] == '#';
    printf("%d\n", occupied);
}
