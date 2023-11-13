#include <stdio.h>

extern void prostopadloscian( float a, float b, float c, float * objetosc, float * pole);

int main() {
    float objetosc;
    float pole;
    prostopadloscian(2, 3, 4, &objetosc, &pole);
    printf("%f %f\n%f %f\n", objetosc, pole, 2.0*3*4, 2.0*2*3+2*2*4+2*3*4);
    prostopadloscian(0.3, 0.12, 2.32, &objetosc, &pole);
    printf("%f %f\n%f %f\n", objetosc, pole, 0.3*0.12*2.32, 2*0.3*0.12+2*0.3*2.32+2*0.12*2.32);
}
