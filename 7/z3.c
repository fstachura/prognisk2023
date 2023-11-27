#include <stdio.h>
extern int iloczyn (int n, ...);

int main() {
    printf("%d = %d\n", iloczyn(4, 1, 2, 3, 4), 24);
    printf("%d = %d\n", iloczyn(10, 1, 2, 3, 4, 1, 1, 1, 1, 1, 10), 240);
}
