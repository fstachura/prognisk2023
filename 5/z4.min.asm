global tablicuj
tablicuj:sub esp,16
fld qword[esp+60]
fld qword[esp+52]
fsubp
fild dword[esp+68]
fld1
fsubp
fdivp
mov dword[esp],0
fldz
fstp qword[esp+4]
mov edx,[esp+72]
fld qword[esp+20]
fld qword[esp+36]
fld qword[esp+44]
fld1
fld1
faddp
.l:fild dword[esp]
fld st5
fmulp
fld qword[esp+52]
faddp
fld qword[esp+60]
fcomip
jb .r
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
fstp qword[esp+4]
fld st5
fld st2
fmulp
fsin
fld st0
fmulp
fld qword[esp+28]
fmulp
fld qword[esp+4]
faddp
fstp qword[edx]
add edx,8
mov eax,[esp]
inc eax
mov[esp],eax
jmp .l
.r:add esp,16
finit
ret
