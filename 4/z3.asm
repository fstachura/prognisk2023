global sortuj
sortuj:mov eax, [esp+4]
mov ecx, [esp+8]
mov edx, [esp+12]
mov eax, [eax]
mov ecx, [ecx]
mov edx, [edx]
cmp edx, eax
jle a
xchg edx, eax
a:cmp ecx, eax
jle b
xchg ecx, eax
b:cmp edx, ecx
jle c
xchg edx, ecx
c:push ebx
mov ebx, [esp+8]
mov [ebx], eax
mov ebx, [esp+12]
mov [ebx], ecx
mov ebx, [esp+16]
mov [ebx], edx
pop ebx
ret
