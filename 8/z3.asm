global _ZN6BigInt5dodajEj, _ZN6BigInt6pomnozEj, _ZN6BigInt14podzielZResztaEj, _ZN6BigInt14podzielZResztaEj, _ZplRK6BigIntS1_, _ZmiRK6BigIntS1_

%include "z2.asm"

_ZN6BigInt5dodajEj:
    ; rdi - this
    ; esi - n
    ; [rdi] - rozmiar
    ; [rdi+8] - dane

    ; intial check for overflow
    mov ecx, [rdi]
    cmp rcx, 0
    je .overflow

    ; add number, exit if not overflow
    mov rax, 0
    mov rdx, [rdi+8]
    add dword [rdx], esi
    jnc .ret  

    ; propagate overflow
.loop:
    ; if previous iteration was the last, there is overflow
    sub rcx, 1
    cmp rcx, 1
    je .last_iteration

    ; move to the next number
    add rdx, 4
    add dword [rdx], 1

    ; if didn't overflow, return
    jnc .ret
    ; if did overflow, continue
    jmp .loop

    ; last iteration, actual overflow danger
.last_iteration:
    add dword [rdx+4], 1
    jnc .ret

.overflow:
    mov rax, 1

.ret:
    ret


_ZN6BigInt6pomnozEj:
    ; rdi - this
    ; esi - n
    ; [rdi] - rozmiar
    ; [rdi+8] - dane

    ; intial check for overflow
    mov dword r9d, [rdi]
    cmp r9d, 0
    jne .ok
    mov eax, esi
    jmp .ret

.ok:
    ; dane
    mov r10, [rdi+8]
    ; counter
    mov ecx, 0
    ; carry
    mov edx, 0
    ; tmp carry
    mov r8d, 0

.loop:
    mov r8d, edx
    mov edx, 0
    mov eax, [r10+4*rcx]
    mul esi
    add eax, r8d
    jnc .cont
    add edx, 1

.cont:
    mov [r10+4*rcx], eax

    add ecx, 1
    cmp ecx, r9d
    jne .loop

    mov eax, edx

.ret:
    ret


_ZN6BigInt14podzielZResztaEj:
    ret

_ZplRK6BigIntS1_:
    ret

_ZmiRK6BigIntS1_:
    ret
