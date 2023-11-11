#include <stdio.h>

extern double wartosc(double a, double b, double c, double d, double x);

int main() {
    printf("%f %f\n", wartosc(2, 3, 4, 5, 6), 2.0*(6.0*6.0*6.0)+3.0*(6.0*6.0)+4.0*6.0+5.0);
}
