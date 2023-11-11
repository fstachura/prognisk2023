global main
extern printf,scanf
main:push b
push a
push s
call scanf
mov eax,[a]
mov ebx,[b]
xor edx,edx
cdq
idiv ebx
mov word[s+2],0x000a
push eax
push s
call printf
add esp,20
mov eax,0
ret
section .data
s db '%d %d',0
a dd 0
b dd 0
