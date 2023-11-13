global prostopadloscian
prostopadloscian:fldz
fld dword [esp+4]
fld dword [esp+8]
fmulp
fadd st1, st0
fld dword [esp+12]
fmulp 
mov ecx, [esp+16]
fst dword [ecx]
fld1
fld1
fadd
fxch st1
fld st1
fld st3
fmulp
fld dword [esp+8]
fld dword [esp+12]
fld st4
fmulp
fmulp
faddp
fld dword [esp+4]
fld dword [esp+12]
fld st4
fmulp
fmulp
faddp
mov ecx, [esp+20]
fst dword [ecx]
finit
ret
