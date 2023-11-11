// copied from https://tomasz-kapela.github.io/prognisk/exercises/cdecl.html#zadanie-3
#include <stdio.h>

void sortuj(int* a, int* b, int* c);

int main() {
    int x=5, y=3, z=4;
    sortuj(&x, &y, &z);
    if(x == 5 && y == 4 && z == 3) {
        printf("OK\n");
    } else {
        printf("NOK\n");
    }
}
