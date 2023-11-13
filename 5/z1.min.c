#include <stdio.h>

extern double wartosc(double a, double b, double c, double d, double x);

int main() {
    printf("%f %f\n", wartosc(2, 3, 4, 5, 6), 2.0*(6.0*6.0*6.0)+3.0*(6.0*6.0)+4.0*6.0+5.0);
    printf("%f %f\n", wartosc(0.6, 10.1, 2.1, 1.2, 3), 0.6*(3.0*3.0*3.0)+10.1*(3.0*3.0)+2.1*3.0+1.2);
}
