#include <stdio.h>

extern double wartosc (double a, double b, double x, int n);

int main() {
    printf("%f\n", wartosc(4.0, 3.0, 2.0, -2));
    printf("%f\n", wartosc(4.0, 3.0, 2.0, -1));
    printf("%f\n", wartosc(4.0, 3.0, 2.0, 0));
    printf("%f\n", wartosc(4.0, 3.0, 2.0, 1));
    printf("%f\n", wartosc(4.0, 3.0, 2.0, 2));
    printf("%f\n", wartosc(4.0, 3.0, 2.0, 3));
    printf("%f\n", wartosc(4.0, 3.0, 2.0, 4));
    printf("%f\n", wartosc(4.0, 3.0, 2.0, 5));
}
