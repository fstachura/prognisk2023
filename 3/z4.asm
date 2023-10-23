section .text
global _start

%include "../common.asm"

encrypt_find_char:
    ; (out) rax (al) - replacement char
    ; rdi - cipher address
    ; rdx (dl) - character

    ; clear rax to avoid issues later
    mov rax, 0 
encrypt_find_char.loop:
    ; get pair of chars
    mov ax, [rdi]

    ; if ax is zero, end of the cipher - exit
    cmp ax, 0
    je encrypt_find_char.exit_fail

    ; if first char from pair matches, return second char
    cmp ah, dl
    je encrypt_find_char.return_second

    ; if second char from pair matches, return first char
    cmp al, dl
    je encrypt_find_char.return_first

    ; update cipher address, continue
    add rdi, 2
    jmp encrypt_find_char.loop

encrypt_find_char.return_first:
    ; second char matches - move first half of ax to al (result)
    mov al, ah

encrypt_find_char.return_second:
    ; second or first char matches - zero out first half of ax and exit
    xor ah, ah
    jmp encrypt_find_char.exit

encrypt_find_char.exit_fail:
    ; no chars from cipher match - return the searched char
    mov al, dl

encrypt_find_char.exit:
    ret


encrypt:
    ; rdi - text address
    ; rdx - cipher address
    ; save regs to avoid stack
    mov r12, rdi
    mov r13, rdx
    ; clear rdx just to be sure
    xor rdx, rdx
encrypt.loop:
    ; read char, if zero then exit
    mov r14b, [r12]
    cmp r14b, 0
    je encrypt.exit

    ; find replacement char   
    mov dl, r14b
    mov rdi, r13
    call encrypt_find_char

    ; if no replacement char was found, continue
    cmp al, r14b
    je encrypt.loop_continue

    ; else, replace char
    mov byte [r12], al

encrypt.loop_continue:
    ; continue loop
    inc r12
    jmp encrypt.loop

encrypt.exit:
    ret


_start:
_start.loop:
    ; read input
    mov rsi, buffer
    mov rdx, buffer_len
    call read_input 

    mov byte [rsi+rax], 0

    ; if no bytes were read - eof, exit
    cmp rax, 0
    jz _start.exit

    ; save rax
    push rax

    ; encrypt input
    mov rdi, buffer
    mov rdx, cipher
    call encrypt

    ; restore rax
    pop rax

    ; write result
    mov rsi, buffer
    mov rdx, rax
    call write_output

    jmp _start.loop

_start.exit:
    jmp exit 
    
section .data
    cipher db "ga","de","ry","po","lu","ki", " -", 0, 0
    cipher_len equ $ - cipher
    buffer times 64 db 0
    buffer_len equ $ - buffer
    buffer_zero db 0

