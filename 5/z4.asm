global tablicuj
tablicuj:
    push ebp
    mov ebp,esp
    push ebx
    sub esp,16

    ; st0=xmax
    fld qword [ebp+48]
    ; st0=xmin; st0=xmin
    fld qword [ebp+40]
    ; st0=xmax-xmin
    fsubp
    ; st0=k; st1=xmax-xmin
    fild dword [ebp+56]
    ; st0=1; st1=k; st2=xmax-xmin
    fld1
    ; st0=k-1; st1=xmax-xmin
    fsubp st1
    ; st0=(xmax-xmin)/(k-1)
    fdivp st1

    ; n
    mov dword [esp],0
    ; tmp
    mov dword [esp+4],0
    mov dword [esp+8],0

    ; wartosci
    mov edx, dword [ebp+60]

    ; a
    fld qword [ebp+8]
    ; P
    fld qword [ebp+24]
    ; Q
    fld qword [ebp+32]
    fld1
    fld1
    faddp

    ; st0=2; st1=Q; st2=P; st3=a; st4=(xmax-xmin)/(k-1)
.loop:
    ; st0=n; st1=...
    fild dword [esp]
    ; st0=(xmax-xmin)/(k-1); st1=n; st2=2; st3=...
    fld st5
    ; st0=n*(xmax-xmin)/(k-1); st1=2; st2=...
    fmulp
    ; st0=xmin
    fld QWORD [ebp+40]
    ; st0=x
    faddp
    ; st0=xmax; st0=x
    fcomp QWORD [ebp+48]
    ; if x > xmax, ret
    fcomip st1
    jb .ret

    ; st0=2; st1=x; st2=2; st3=Q; st4=P; st5=a; st6=(xmax-xmin)/(k-1); st7=x
    fld
    ; st0=2*x
    fmulp
    ; st0=pi; st1=2*x
    fldpi
    ; st0=2*x*pi
    fmulp

    ; st0=2*x*pi; st1=2; st2=Q; st3=P; st4=a; st5=(xmax-xmin)/(k-1); st6=2*x*pi
    fst st6

    ; st0=P; st1=2*x*pi
    fld st3
    ; st0=P*2*x*pi
    fmulp
    ; st0=sin(P*2*x*pi)
    fsin
    ; st0=sin(P*2*x*pi); st1=sin(...)
    fld st0
    ; st0=sin(P*2*x*pi)^2
    fmulp
    ; st0=a; st1=sin(P*2*x*pi)^2
    fld st4
    ; st0=a*sin(P*2*x*pi)^2
    fmulp
    ; save result
    fstp qword [esp+4]

    ; st0=2*x*pi
    fld st5
    fld st2
    fmulp
    fsin
    fld st0
    fmulp
    fld qword [ebp+16]
    fmulp
    fld qword [esp+4]
    faddp
    fstp qword [edx]

    ; wartosci+=1
    add edx,8
    ; update n
    mov eax,dword[esp]
    inc eax
    mov dword[esp],eax
    jmp .loop

.ret:
    add    esp,16
    pop    ebx
    pop    ebp
    finit
    ret
