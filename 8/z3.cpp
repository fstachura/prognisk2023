#include <iostream>
#include "z3.hpp"
// Funkcje z zadania 2
// kopiuje n liczb typu int z zrodla do celu 
void kopiuj(unsigned int * cel, unsigned int * zrodlo, unsigned int n);
// zeruje tablice liczb typu int o rozmiarze n
void zeruj(unsigned int * tablica, unsigned int n);

BigInt::BigInt(unsigned int rozmiar) 
: rozmiar(rozmiar), dane( new unsigned[rozmiar] ){
  zeruj(dane, rozmiar);  
}  
BigInt::BigInt(const BigInt & x)   
:  rozmiar(x.rozmiar),       dane(new unsigned[x.rozmiar]){     
  kopiuj(dane, x.dane, x.rozmiar);  
}    
BigInt & BigInt::operator=(const BigInt & x) {    
  if(rozmiar != x.rozmiar){      
    unsigned * tmp = new unsigned[x.rozmiar];      
    delete[] dane;       
    rozmiar = x.rozmiar;      
    dane = tmp;    
  }    
  kopiuj(dane, x.dane, x.rozmiar);    
  return *this;  
}  

BigInt::~BigInt(){		    
  delete[] dane;  
}

BigInt& BigInt::operator=(const char * liczba) {
  zeruj(dane, rozmiar);
  while(*liczba) {
    BigInt a(1);
    a.dodaj(*liczba - '0');
    pomnoz(10);
    *this = *this + a;
    liczba++;
  }
  return *this;
}

std::ostream& operator<<(std::ostream& str, const BigInt& x) {
  BigInt tmp(x);
  std::string result;
  result.reserve(10*tmp.rozmiar);
  int leadingZeros = 0;

  for(int i=0; i != tmp.rozmiar*10; i++) {
    int mod = tmp.podzielZReszta(10);
    if(mod == 0) {
      leadingZeros++;
    } else {
      result = std::to_string(mod) + std::string(leadingZeros, '0') + result;
      leadingZeros = 0;
    }
  }

  str << result;
  return str;
}

std::ostream& operator<< (std::ostream& str, const BigInt& x);
//  for(int i=0; i != x.rozmiar; i++) {
//    str << x.dane[x.rozmiar-1-i] << " ";
//  }
//  return str;
//}

void test(std::ostream& str) {
  const char* a = "asdasd";
  str << a;
}

void divTest() {
  unsigned int len;
  std::cin >> len; 
  BigInt num(len);
  for(int i=0; i != len; i++) {
    std::cin >> num.dane[len-1-i];
  }

  unsigned int div;
  std::cin >> div;
  std::cout << std::hex << num.podzielZReszta(div) << std::endl;
  std::cout << std::hex << num << std::endl;
}

void addTest() {
  unsigned int a_len;
  std::cin >> a_len;
  BigInt a(a_len);
  for(int i=0; i != a_len; i++) {
    std::cin >> a.dane[a_len-1-i];
  }

  unsigned int b_len;
  std::cin >> b_len;
  BigInt b(b_len);
  for(int i=0; i != b_len; i++) {
    std::cin >> b.dane[b_len-1-i];
  }

  std::cout << std::hex << a + b << std::endl;
}

void addTest2() {
  std::string a, b;
  std::cin >> a >> b;
  BigInt ba(0), bb(0);
  ba = a.c_str();
  bb = b.c_str();
  std::cout << ba + bb << std::endl;
}

void subTest2() {
  std::string a, b;
  std::cin >> a >> b;
  BigInt ba(0), bb(0);
  ba = a.c_str();
  bb = b.c_str();
  std::cout << ba - bb << std::endl;
}

void subTest() {
  unsigned int a_len;
  std::cin >> a_len;
  BigInt a(a_len);
  for(int i=0; i != a_len; i++) {
    std::cin >> a.dane[a_len-1-i];
  }

  unsigned int b_len;
  std::cin >> b_len;
  BigInt b(b_len);
  for(int i=0; i != b_len; i++) {
    std::cin >> b.dane[b_len-1-i];
  }

  std::cout << std::hex << a - b << std::endl;
}

int main() {
  //divTest();
  //addTest();
  //subTest();
  //addTest2();
  subTest2();

  //BigInt a(3);
  //a.dane[0] = 0x1;
  //a.dane[1] = 0x2;
  //a.dane[2] = 0x3;
  //BigInt b(2);
  //b.dane[0] = 0x4;
  //b.dane[1] = 0x5;
  //std::cout << a-b << std::endl;

  //BigInt a(3);
  //a.dane[0] = 0xffffffff;
  //a.dane[1] = 0xffffffff;
  //a.dane[2] = 0xffffffff;
  //std::cout << a.dodaj(0xffffffff) << std::endl;
  //std::cout << a;

  //BigInt b(2);
  //b.dane[0] = 0xffffffff;
  //b.dane[1] = 0xffffffff;
  //std::cout << std::hex << b.pomnoz(0xffffffff) << std::endl;
  //std::cout << b;

  //BigInt c(2);
  //c.dane[0] = 0xffffffff;
  //c.dane[1] = 0x3434;
  //std::cout << std::hex << c.pomnoz(2) << std::endl;
  //std::cout << c;
  //auto test = a+b;
  //auto test2 = a-b;

  //BigInt a(1);
  //a.dane[0] = 4;
  //std::cout << a.podzielZReszta(2) << std::endl;
  //std::cout << a << std::endl;

  //BigInt b(2);
  //b.dane[0] = 4;
  //std::cout << b.podzielZReszta(2) << std::endl;
  //std::cout << b << std::endl;

  //BigInt c(2);
  //c.dane[0] = 4;
  //c.dane[1] = 16;
  //std::cout << c.podzielZReszta(8) << std::endl;
  //std::cout << c << std::endl;

  //BigInt d(3);
  //d.dane[0] = 4;
  //d.dane[1] = 16;
  //d.dane[2] = 32;
  //std::cout << d.podzielZReszta(8) << std::endl;
  //std::cout << d << std::endl;


  //BigInt e(3);
  //e.dane[0] = 3;
  //e.dane[1] = 3;
  //e.dane[2] = 3;
  //std::cout << e.podzielZReszta(3) << std::endl;
  //std::cout << e << std::endl;

  //test(std::cout);

  //std::cout << num + a << std::endl;
}
