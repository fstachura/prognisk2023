global wartosc
wartosc:
    push ebp
    mov ebp, esp

    ; a - ebp+8
    ; b - ebp+16
    ; c - ebp+24
    ; d - ebp+32
    ; x - ebp+40
    ; y = ax^3+bx^2+cx+d
    ; y = x(a*x^2+b*x+c)+d
    ; y = x(x(a*x+b)+c)+d

    ; load x
    fild qword [ebp+40]
    ; load a
    fild qword [ebp+8]
    ; st1 = a*x; pop (st0 = a*x)
    fmulp 

    ; load b
    fild qword [ebp+16]
    ; st1 = a*x+b; pop (st0 = a*x+b)
    faddp

    ; load x
    fild qword [ebp+40]
    ; st1 = x(a*x+b); pop (st0 = x(a*x+b))
    fmulp

    ; load c
    fild qword [ebp+24]
    ; st1 = x(a*x+b)+c; pop (st0 = x(a*x+b)+c)
    faddp

    ; load x
    fild qword [ebp+40]
    ; st1 = x(x(a*x+b)+c); pop (st0 = x(x(a*x+b)+c))
    fmulp

    ; load d
    fild qword [ebp+32]
    ; st1 = x(x(a*x+b)+c)+d; pop (st0 = x(x(a*x+b)+c)+d)
    faddp

    pop ebp 
    ret
