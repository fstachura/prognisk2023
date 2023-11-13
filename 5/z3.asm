global iloczyn_skalarny
iloczyn_skalarny:
    push ebp
    mov ebp, esp
    push ebx

    ; n = element after the last element
    mov eax, [ebp+8]
    imul eax, 12
    
    ; x
    mov ecx, [ebp+12]
    ; y
    mov edx, [ebp+16]
    
    ; load zero to fpu stack
    fldz

.loop:
    ; decrease element index
    sub eax, 12
    ; load elements
    fld tword [ecx+eax]
    fld tword [edx+eax]
    ; st0 = x[i]*y[i]
    fmulp
    ; st0 = ... + x[i]*y[i]
    faddp

    ; if eax=0, exit
    cmp eax, 0
    jnz .loop

    pop ebx
    pop ebp
    ret
