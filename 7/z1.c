#include <stdio.h>
extern int suma (int n, int * tab);

int main() {
    int tab[] ={1, 2, 3, 4};
    printf("%d\n", suma(4, tab));
}
