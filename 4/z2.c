#include <stdio.h>

int iloczyn(int n, int* tab);

int main() {
    int tab[] = {4,2,-1,8, -2};
    printf("%d\n", iloczyn(sizeof(tab)/sizeof(int), tab));
}
