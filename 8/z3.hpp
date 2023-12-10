#include <iostream>

class BigInt{  
public:  
  unsigned int rozmiar;   
  unsigned int * dane;      

  explicit BigInt(unsigned int rozmiar);
  BigInt(const BigInt & x);
  BigInt & operator=(const BigInt & x);
  ~BigInt();
  int dodaj(unsigned int n);  
  unsigned int pomnoz(unsigned int n);  
  int podzielZReszta(unsigned int n);    
  BigInt & operator=(const char * liczba);  

  friend std::ostream & operator << (std::ostream & str, const BigInt & x);
  
  friend BigInt operator+ (const BigInt & a, const BigInt & b);  
  friend BigInt operator- (const BigInt & a, const BigInt & b);
}; 
