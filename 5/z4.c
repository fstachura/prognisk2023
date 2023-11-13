#include <stdlib.h>
#include <stdio.h>
#include <math.h>

extern void tablicuj(double a, double b, double P, double Q, double xmin, double xmax, int k,  double * wartosci);

void tablicuj2(double a, double b, double P, double Q, double xmin, double xmax, int k,  double * wartosci) {
    double x = xmin;
    int i = 0;
    double offset = (xmax-xmin)/(k-1);

    while(x <= xmax) {
        double q = sin(P*2*M_PI*x);
        double w = sin(Q*2*M_PI*x);
        wartosci[i] = a*q*q + b*w*w;
        i++;
        x += offset;
    }
}

void print(double* tab, int n) {
    for(int i=0; i != n; i++) {
        printf("%f ", tab[i]);
    }
    printf("\n");
}

int main() {
    int n=11;
    double* wartosci = malloc(sizeof(double)*n);
    tablicuj(-1.1, 3.1123, 0.2, -5.123, 2, 12, n, wartosci);
    print(wartosci, n);
    tablicuj2(-1.1, 3.1123, 0.2, -5.123, 2, 12, n, wartosci);
    print(wartosci, n);
    tablicuj(-1.1, 3.1123, 0.2, -5.123, 2, 12, n, wartosci);
    print(wartosci, n);
}
