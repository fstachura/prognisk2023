global prostopadloscian
prostopadloscian:
    %define a ebp+8
    %define b ebp+12
    %define c ebp+16
    %define objetosc ebp+20 ; (2*a*b+2*a*c+2*c*b)
    %define pole ebp+24     ; (a*b*c)

    push ebp
    mov ebp, esp

    ; load a
    fld dword [a]
    ; load b
    fld dword [b]
    ; load c
    fld dword [c]
    ; st1 = c*b; pop 
    fmulp 
    ; st1 = a*c*b; pop 
    fmulp 

    mov ecx, dword [objetosc]
    fst dword [ecx]

    ; create 2
    fld1
    fld1
    fadd
    ; st3 = 2
    fxch st3
    
    ; load a; st4 = 2
    fld dword [a]
    ; load b; st5 = 2
    fld dword [b]
    ; load 2; st6 = 2
    fld st5
    ; st1 = 2*b; pop; st5 = 2
    fmulp
    ; st1 = 2*a*b; pop; st4 = 2
    fmulp

    ; load b; st5 = 2
    fld dword [b]
    ; load c; st6 = 2
    fld dword [c]
    ; load 2; st7 = 2
    fld st6
    ; st1 = 2*c; pop; st6 = 2
    fmulp
    ; st1 = 2*b*c; pop; st5 = 2
    fmulp
    ; st1 = 2*a*b+2*b*c; pop; st4 = 2
    faddp

    ; load a; st5 = 2
    fld dword [a]
    ; load b; st6 = 2
    fld dword [c]
    ; load 2; st7 = 2
    fld st6
    ; st1 = 2*c; pop; st6 = 2
    fmulp
    ; st1 = 2*a*c; pop; st5 = 2
    fmulp
    ; st1 = 2*a*c+2*a*b+2*b*c; pop; st4 = 2
    faddp

    mov ecx, dword [pole]
    fst dword [ecx]

    finit
    pop ebp
    ret 
