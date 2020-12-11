#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main() {
    fseek(stdin, 0L, SEEK_END);
    long size = ftell(stdin);
    fseek(stdin, 0L, SEEK_SET);

    char *file = malloc(size);
    fread(file, 1, size, stdin);

    int w = strcspn(file, "\n");
    int h = size / (w + 1);

    char *ptr = malloc(2 * w * h);
    char (*   grid)[w] = (void *)ptr,
         (*tmpgrid)[w] = (void *)(ptr + w * h);

    for (int i = 0; i < h; i++)
        for (int j = 0; j < w; j++)
                grid[i][j] = file[i * (w+1) + j];

    memcpy(tmpgrid, grid, w * h);

    char avail[] = { '#', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L' };
    char taken[] = { '#', '#', '#', '#', '#', 'L', 'L', 'L', 'L' };

    while (1) {
        for (int i = 0; i < h; i++) {
            for (int j = 0; j < w; j++) {
                int occupied = 0;

                struct {
                    int di, dj;
                } delta[] = {
                    { -1, -1 }, { -1,  0 }, { -1,  1 },
                    {  0, -1 },             {  0,  1 },
                    {  1, -1 }, {  1,  0 }, {  1,  1 },
                };

                for (int d = 0; d < sizeof delta/sizeof *delta; d++) {
                    for (int tmpi = i + delta[d].di, tmpj = j + delta[d].dj;
                         tmpi >= 0 && tmpj >= 0 && tmpi < h && tmpj < w;
                         tmpi += delta[d].di, tmpj += delta[d].dj) {

                        occupied += grid[tmpi][tmpj] == '#';

                        if (grid[tmpi][tmpj] != '.')
                            break;
                    }
                }

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
        for (int j = 0; j < w; j++)
            occupied += grid[i][j] == '#';
    printf("%d\n", occupied);
}
