global iloczyn
iloczyn:mov ecx,[esp+4]
mov eax,1
l:mov edx,[esp+8]
imul dword[edx+4*ecx-4]
dec ecx
jnz l
ret
