global main
extern printf,scanf
main:push a+4
push a
push s
call scanf
mov eax,[a]
mov ebx,[a+4]
dd 0xf799d231
db 0xfb
mov word[s+2],0x000a
push eax
push s
call printf
dd 0xb814c483,0
ret
section .data
s db '%d %d',0
a dq 0
