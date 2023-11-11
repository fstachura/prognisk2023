global wartosc
wartosc:
    push ebp
    mov ebp, esp

    ; a - ebp+10
    ; b - ebp+20
    ; c - ebp+30
    ; d - ebp+40
    ; x - ebp+50
    ; y = ax^3+bx^2+cx+d
    ; y = x(a*x^2+b*x+c)+d
    ; y = x(x(a*x+b)+c)+d

    ; load x
    fild tword [ebp+50]
    ; load a
    fild tword [ebp+10]
    ; st1 = a*x; pop (st0 = a*x)
    fmulp 

    ; load b
    fild tword [ebp+20]
    ; st1 = a*x+b; pop (st0 = a*x+b)
    faddp

    ; load x
    fild tword [ebp+50]
    ; st1 = x(a*x+b); pop (st0 = x(a*x+b))
    fmulp

    ; load c
    fild tword [ebp+30]
    ; st1 = x(a*x+b)+c; pop (st0 = x(a*x+b)+c)
    faddp

    ; load x
    fild qword [ebp+50]
    ; st1 = x(x(a*x+b)+c); pop (st0 = x(x(a*x+b)+c))
    fmulp

    ; load d
    fild tword [ebp+40]
    ; st1 = x(x(a*x+b)+c)+d; pop (st0 = x(x(a*x+b)+c)+d)
    faddp

    pop ebp 
    ret
