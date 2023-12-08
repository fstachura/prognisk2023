#include <iostream>

// kopiuje n liczb typu int z zrodla do celu 
void kopiuj(unsigned int * cel, unsigned int * zrodlo, unsigned int n);

// zeruje tablice liczb typu int o rozmiarze n
void zeruj(unsigned int * tablica, unsigned int n);

int main() {
  unsigned int test[] = {1, 123124, 1231090, 120309408, 12385, 4324, 234};
  unsigned int test2[sizeof(test)];
  kopiuj(test2, test, sizeof(test));
  for(int i=0; i != sizeof(test); i++) {
    if(test[i] != test2[i]) {
      std::cout<<"fail: "<<i<<" "<<test[i]<<" != "<<test2[i]<<std::endl;
    }
  }
  zeruj(test2, sizeof(test));
  for(int i=0; i != sizeof(test); i++) {
    if(test2[i] != 0) {
      std::cout<<"fail: "<<i<<" "<<test2[i]<<" != "<<0<<std::endl;
    }
  }
}
