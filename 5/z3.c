#include <stdio.h>

extern long double iloczyn_skalarny(int n, long double * x, long double * y);

int main() {
    long double x[] = {1.0,2.2,3.1};
    long double y[] = {3.4,2.1,5.3};
    printf("%Lf %Lf\n", iloczyn_skalarny(3, x, y), x[0]*y[0]+x[1]*y[1]+x[2]*y[2]);
    printf("%Lf %Lf\n", iloczyn_skalarny(1, x, y), x[0]*y[0]);

    long double x2[] = {0,2.2,0};
    long double y2[] = {3.4,0,5.3};
    printf("%Lf %Lf\n", iloczyn_skalarny(3, x2, y2), x2[0]*y2[0]+x2[1]*y2[1]+x2[2]*y2[2]);

    long double x3[] = {-1,2.2,-3};
    long double y3[] = {3.4,-6,5.3};
    printf("%Lf %Lf\n", iloczyn_skalarny(3, x3, y3), x3[0]*y3[0]+x3[1]*y3[1]+x3[2]*y3[2]);
}
