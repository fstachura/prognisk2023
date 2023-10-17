# 1

zroumieć komputer profesjonalne programowanie cz. 1 i 2

## rejestry

* ax - 16 bitów, ah/al - 8 bitów
* ax = ah << 0xff | al 
* w 8086 tylko 16 bitów ale 1 mb adresowalnej
* cs:dx - koduje adres, pokrywają się więc mimo że łącznie mają 32 bity, to adresują tylko 1MB (20 bitów)
* cs - code segment, ds - data segment
* eax - 32 bity
* eax = eax & 0xffff | ah << 0xff | al
* rax - 64 bity
* jeżeli działamy na rejestrach 16 bitowych, górne części rax (i eax) nie są naruszane
* jeżeli działamy na 32/64 bitowych, mov nawet do dolnych części zeruje górę
* movsx - move sign extended - jeżeli najstarszy bit źródła jest równa 1, to starsze bity celu też będą równe 1, źródło 2x mniejsze niż cel raczej
* movzs - move zero extended - jw tylko rozdziela zerami
* magistrala danych w większości komputerów 64-bitowych ma 40 bitów szerokości, w niektórych serwerowych ma 48 bitów szerokości

* ax - accumulator
* bx - base (często index tablicy)
* cx - loop counter (przeważnie do przechowywania ile razy powtórzyć pętlę)
* dx - data 
* si - source index
* di - destination index
* sp - stack pointer (szczyt stosu)
* bp - base pointer (spód stosu)
* flag - carry, overflow, sign, zero, interrupt, parity, direction
* r8-r15 in x64

* div - rdx:rax
 
# 2

* linker tłumaczy etykiety na adresy
* jmp jest relatywny (near call - zakres jednego bajta)
* lokalne etykiety dobrze jest rozpoczynać kropką
* skalowany tryb adresowania
    * adres = baza + index * skala + przesunięcie
    * baza i indeks w rejestrach
    * skala = 1,2,4,8
    * przesunięcie jest częścią instrukcji 
* `mov [rel et], ebx ` - rel oznacza żeby wziąć relatywny adres etykiety (dla pic)
* `lea rbx, [rel et]` - załaduj policzony adres et (mimo dereferencji)
* `lea rbx, [rax + rcx + 5]`

# 3 

* `enter N, X` - `push rbp; mov rbp, rsp; sub rsp N;` (X - poziom zagłębień przy funkcjach rekurencyjnych)
* `leave` - `mov rsp, rbp; pop rbp;`
* `ret N` - `pop rip; add rsp, n;`
* `popf/pushf` - ściąga/odkłada rejestr flag
* `popa/pusha` - ściąga/odkłada wszystkie rejestry
* `%define c [rbp-24]` - można w kodzie
* `%undef c`

