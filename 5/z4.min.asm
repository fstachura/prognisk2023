global tablicuj
tablicuj:sub esp,16
%define v(n) qword[esp+n]
fld v(60)
fld v(52)
fsubp
fild dword[esp+68]
fld1
fsubp
fdivp
mov dword[esp],0
fldz
fstp v(4)
mov edx,[esp+72]
fld v(20)
fld v(36)
fld v(44)
fld1
fld1
faddp
l:fild dword[esp]
fld st5
fmulp
fld v(52)
faddp
fld v(60)
fcomip
jb r
fld
fmulp
fldpi
fmulp
fst st6
fld st3
fmulp
fsin
fld st0
fmulp
fld st4
fmulp
fstp v(4)
fld st5
fld st2
fmulp
fsin
fld st0
fmulp
fld v(28)
fmulp
fld v(4)
faddp
fstp qword[edx]
add edx,8
mov eax,[esp]
inc eax
mov[esp],eax
jmp l
r:add esp,16
finit
ret
