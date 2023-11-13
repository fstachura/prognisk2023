global iloczyn_skalarny
iloczyn_skalarny:push ebx
mov eax, [esp+8]
imul eax, 12
mov ecx, [esp+12]
mov edx, [esp+16]
fldz
l:sub eax, 12
fld tword [ecx+eax]
fld tword [edx+eax]
fmulp
faddp
cmp eax, 0
jnz l
pop ebx
ret
