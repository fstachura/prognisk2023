#include <iostream>
// Funkcje z zadania 2
// kopiuje n liczb typu int z zrodla do celu 
void kopiuj(unsigned int * cel, unsigned int * zrodlo, unsigned int n);
// zeruje tablice liczb typu int o rozmiarze n
void zeruj(unsigned int * tablica, unsigned int n);

class BigInt{  
public:  
  unsigned int rozmiar;   
  unsigned int * dane;      

  explicit BigInt(unsigned int rozmiar) 
  : rozmiar(rozmiar), dane( new unsigned[rozmiar] ){
    zeruj(dane, rozmiar);  
  }  
  BigInt(const BigInt & x)   
  :  rozmiar(x.rozmiar),       dane(new unsigned[x.rozmiar]){     
    kopiuj(dane, x.dane, x.rozmiar);  
  }    
  BigInt & operator=(const BigInt & x) {    
    if(rozmiar != x.rozmiar){      
      unsigned * tmp = new unsigned[x.rozmiar];      
      delete[] dane;       
      rozmiar = x.rozmiar;      
      dane = tmp;    
    }    
    kopiuj(dane, x.dane, x.rozmiar);    
    return *this;  
  }  
  ~BigInt(){		    
    delete[] dane;  
  }
  // do zaimplementowania w zadaniu 3  
  int dodaj(unsigned int n);  
  unsigned int pomnoz(unsigned int n);  
  int podzielZReszta(unsigned int n);    
  BigInt & operator=(const char * liczba);  
  friend std::ostream & operator << (std::ostream & str, const BigInt & x);
  
  // do zaimplementowania w zadaniu 4  
  friend BigInt operator+ (const BigInt & a, const BigInt & b);  
  friend BigInt operator- (const BigInt & a, const BigInt & b);
}; 

std::ostream& operator<< (std::ostream& str, const BigInt& x) {
  for(int i=0; i != x.rozmiar; i++) {
    str << x.dane[x.rozmiar-1-i] << " ";
  }
  str<<std::endl;
  return str;
}

int main() {
  BigInt a(3);
  a.dane[0] = 0xffffffff;
  a.dane[1] = 0xffffffff;
  a.dane[2] = 0xffffffff;
  std::cout << a.dodaj(0xffffffff) << std::endl;
  std::cout << a;

  BigInt b(2);
  b.dane[0] = 0xffffffff;
  b.dane[1] = 0xffffffff;
  std::cout << std::hex << b.pomnoz(0xffffffff) << std::endl;
  std::cout << b;

  BigInt c(2);
  c.dane[0] = 0xffffffff;
  c.dane[1] = 0x3434;
  std::cout << std::hex << c.pomnoz(2) << std::endl;
  std::cout << c;
  //auto test = a+b;
  //auto test2 = a-b;
}
