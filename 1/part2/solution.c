#include <stdio.h>
#include <stdlib.h>

void load(const char *file, int **p, size_t *s) {
    FILE *input = fopen(file, "r");
    size_t size = 1;
    *p = malloc(sizeof(**p));
    *s = 0;
    while (fscanf(input, "%d", *p + *s) == 1)
        if (++*s == size)
            *p = realloc(*p, sizeof **p * (size *= 2));
    fclose(input);
}

int cmp(const void *a, const void *b) {
    const int *pa = a, *pb = b;
    return *pa - *pb;
}

void work(int *array, size_t size);

int main() {
    int *array;
    size_t size;
    load("../input", &array, &size);
    work(array, size);
    free(array);
}

void work(int *array, size_t size) {
    qsort(array, size, sizeof *array, cmp);

    size_t size2 = size * size;
    struct {
        int sum;
        int a, b;
    } *sums = malloc(sizeof *sums * size2);
    for (int i = 0; i < size; i++)
    {
        for (int j = 0; j < size; j++)
        {
            sums[i*size+j].a = array[i];
            sums[i*size+j].b = array[j];
            sums[i*size+j].sum = array[i] + array[j];
        }
    }
    qsort(sums, size2, sizeof *sums, cmp);

    int i = 0, j = size2 - 1;
    while (1) {
        int sum = array[i] + sums[j].sum;
        if (sum < 2020)
            i++;
        else if (sum > 2020)
            j--;
        else
        {

            printf("%d %d %d %d\n", array[i], sums[j].a, sums[j].b, array[i] * sums[j].a * sums[j].b);
            break;
        }
    }
}
