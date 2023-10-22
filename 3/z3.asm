section .text
global _start

%include "../common.asm"

str_to_int_zero:
    ; (in) rdi - input buffer
    ; (out) rax - converted number
    mov rax, 0
    ; minus flag
    mov rcx, 0

    ; get first byte
    mov bl, [rdi]
    ; check if the char is minus, it means that we are at the beginning of the number. update minus flag
    cmp bl, '-'
    jne str_to_int_zero.loop
    mov rcx, 1
    ; update rdi
    inc rdi
str_to_int_zero.loop:
    ; get byte
    mov rbx, 0
    mov bl, [rdi]

    ; check if character is in ascii digit range
    cmp bl, '0'
    jl str_to_int_zero.exit
    cmp bl, '9'
    jg str_to_int_zero.exit

    ; substract 0 to get binary digit
    sub bl, '0'

    ; multiply current rax by 10
    imul rax, 10

    ; add digit to rax
    add rax, rbx

    ; inc rdi to get the next digit
    inc rdi

    ; continue loop
    jge str_to_int_zero.loop

str_to_int_zero.exit:
    ; if last char before exit was - negate rax
    cmp rcx, 1
    jne str_to_int_zero.ret
    neg rax

str_to_int_zero.ret:
    ret


int_to_str_zero:
    ; (in) rdi - number
    ; (in) rsi - result buffer
    ; (in) rdx - buffer length
    ; (out) rax - pointer to start of the number
    ; (out) rdx - number of digits
    mov r10, rdx        ; buffer left
    mov r9, rdx         ; used to calculate length of the number
    add rsi, rdx        ; address of zero
    dec rsi
    dec r10
    mov byte [rsi], 0   ; place a zero at the end

    ; ? xd
    mov rcx, 10

    ; save rdi in rax
    mov rax, rdi

    ; check sign, negate and save sign if number is negative
    mov r8, 0
    cmp rax, 0
    jge int_to_str_zero.loop
    neg rax
    mov r8, 1
int_to_str_zero.loop:
    ; buffer is filled from the end - decrease buffer address to find 
    ; address of the next digit
    dec rsi
    dec r10
    cmp r10, 0
    jl int_to_str_zero.exit

    ; extract the least significant digit into rdx
    xor rdx, rdx
    div rcx

    ; convert least significant digit to ascii, write into bufffer
    add dl, '0'
    mov [rsi], dl

    ; if floor(rax/rsi) = 0, exit
    cmp rax, 0
    jz int_to_str_zero.exit

    jmp int_to_str_zero.loop
int_to_str_zero.exit:
    ; calculate starting address - r9 = number of digits
    sub r9, r10
    mov rax, r9

    ; if there is still space in the buffer, and sign bit is 1
    cmp r10, 0
    jle int_to_str_zero.ret
    cmp r8, 0
    je int_to_str_zero.ret

    ; then write minus into the buffer and recalculate start address
    mov byte [rsi-1], '-'
    inc rdx
    dec rsi
    inc r9
    inc rax

int_to_str_zero.ret:
    ; rsi - pointer to start of the number (result)
    mov rax, rsi
    ; rdx - number of digits
    mov rdx, r9
    ret


; przekazywanie przez stos - możliwe 
; zwrot stringa przez stos - na początku pop adresu zwrotnego do jakiegoś rejestru, później pushowane kolejne znaki liczby, później pushowana ilość cyfr, później push rejetru i ret
; przyjęcie stringa przez stos - normalnie zapushowany string i wielkość na koniec

_start:
    ; read number
    mov rsi, number
    mov rdx, number_len
    call read_input

    ; change newline to zero
    mov byte [number + rax], 0

    ; convert string to number
    mov rdi, number
    call str_to_int_zero

    inc rax

    ; convert number to string
    mov rdi, rax
    mov rsi, number
    mov rdx, number_len
    call int_to_str_zero

    ; print to output
    mov rsi, rax
    inc rdx
    call write_output
    
    jmp exit

section .data
    number times 22 db 0
    number_len equ $ - number
    newline db 0ah

