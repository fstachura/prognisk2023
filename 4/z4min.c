// copied from https://tomasz-kapela.github.io/prognisk/exercises/cdecl.html#zadanie-4
#include <stdio.h>

typedef struct{
    int min;
    int max;
} MinMax;

MinMax minmax(int N, ...);

int main(){
   MinMax wynik = minmax(7, 1, -2, 4 , 90, 4, -11, 101); // -11 101
   printf("min = %d, max = %d \n", wynik.min, wynik.max); 

   wynik = minmax(5, 1, -2, 4 , 90, 4, -11, 101);        // -2 90
   printf("min = %d, max = %d \n", wynik.min, wynik.max); 

   wynik = minmax(1, 0);                                 // 0 0
   printf("min = %d, max = %d \n", wynik.min, wynik.max);

   wynik = minmax(1, 1, -2, 4 , 90, 4, -11, 101); // 1 1
   printf("min = %d, max = %d \n", wynik.min, wynik.max); 

   wynik = minmax(2, 1, -2, 4 , 90, 4, -11, 101); // -2 1
   printf("min = %d, max = %d \n", wynik.min, wynik.max); 

   wynik = minmax(3, 1, -2, 4 , 90, 4, -11, 101); // -2 4
   printf("min = %d, max = %d \n", wynik.min, wynik.max); 

   wynik = minmax(4, 1, -2, 4 , 90, 4, -11, 101); // -2 90
   printf("min = %d, max = %d \n", wynik.min, wynik.max); 

   wynik = minmax(6, 1, -2, 4 , 90, 4, -11, 101); // -11 90
   printf("min = %d, max = %d \n", wynik.min, wynik.max); 

   return 0;
}
