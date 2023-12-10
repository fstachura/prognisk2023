global _ZN6BigInt5dodajEj, _ZN6BigInt6pomnozEj, _ZN6BigInt14podzielZResztaEj, _ZN6BigInt14podzielZResztaEj, _ZplRK6BigIntS1_, _ZmiRK6BigIntS1_, _ZlsRSoRK6BigInt

extern _ZNSolsEj, _ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc, _ZN6BigIntC2ERKS_, _ZN6BigIntC2Ej

%include "z2.asm"

; dodaj(unsigned int)
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


; pomnoz(unsigned int)
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


; podzielZReszta(unsigned int)
_ZN6BigInt14podzielZResztaEj:
    ; rdi - this
    ; esi - n
    ; [rdi] - rozmiar
    ; [rdi+8] - dane

    ; find the first non zero number from the end
    ; if there is only one number left, special case - divide, save, return rdx
    ; if dane[rozmiar-1] > n, rdx=0, rax=dane[rozmiar-1]
    ; else rdx=dane[rozmiar-1], rax=dane[rozmiar-2]
    ; while i >= 0
    ; divide rdx:dane[i] by n
    ; dane[i] = rax
     
    ; r10 - dane
    mov r10, [rdi+8]
    ; rcx - rozmiar
    mov dword ecx, [rdi]

    ; find the first non-zero number
.find_first_nonzero:
    sub rcx, 1
    cmp rcx, 0
    jl .return_n

    ; if dane[rcx] != 0 continue
    mov eax, [r10+4*rcx]
    cmp eax, 0
    je .find_first_nonzero

    ; else
    ; if last number, special case
    cmp ecx, 0
    je .return_divide_single
    
    ; check if dane[rcx] > n
    cmp eax, esi
    jb .first_less_than_n

    ; if yes, rdx=0, rax=dane[rcx]
    mov rdx, 0
    jmp .divide_loop

    ; else, rdx=dane[rcx], rax=dane[rcx-1]
.first_less_than_n:
    mov rdx, rax
    mov dword [r10+4*rcx], 0
    sub rcx, 1
    mov eax, [r10+4*rcx]
    jmp .divide_loop

.divide_loop_preparation:
    sub rcx, 1
    cmp rcx, 0
    jl .return_rdx
    mov eax, [r10+4*rcx]

.divide_loop:
    div esi
    mov [r10+4*rcx], eax
    jmp .divide_loop_preparation


.return_rdx:
    mov rax, rdx
    ret

    ; special case for a single non-zero "digit"
.return_divide_single:
    mov edx, 0
    div esi
    mov dword [r10], eax
    mov eax, edx
    ret

    ; special case for all-zero numbers
.return_n:
    mov eax, 0
    ret


; std::ostream& operator<< (std::ostream& str, const BigInt& x)
_ZlsRSoRK6BigInt:
    ; rdi - str
    ; rsi - x
    ; [rsi] - rozmiar
    ; [rsi+8] - dane

    ; rozmiar
    mov ecx, [rsi]
    ; dane
    mov rdx, [rsi+8]

    ; just a space
    push 0x00000020
    ; save pointer to the space in r10
    mov r10, rsp

.loop:
    ; update counter (start from the end)
    sub ecx, 1
    cmp ecx, 0
    jl .ret

    ; rsi = dane[i]
    mov rsi, [rdx+4*rcx]

    ; call ostream << unsigned int int
    push rdi
    push rcx
    push rdx
    push r10

    call _ZNSolsEj 

    ; rdi = returned ostream
    mov rdi, rax
    ; rsi = address of the space
    mov rsi, [rsp]
    ; call ostream << const char *
    call _ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc

    pop r10
    pop rdx
    pop rcx
    pop rdi

    jmp .loop

.ret:
    ; pop space
    pop rax
    ; return last returned ostream
    mov rax, rdi
    ret


; friend BigInt operator+ (const BigInt& a, const BigInt& b)
_ZplRK6BigIntS1_:
    ; rdi - BigInt result space
    ; rsi - BigInt& a
    ; rdx - BigInt& b

    ; allocate stack space for saved registers
    sub rsp, 3*8

    ; compare a.rozmiar and b.rozmiar
    mov eax, [rsi]
    cmp eax, [rdx]
    ; make sure that a (rsi) is the larger integer
    ja .adjust_for_most_significant_digit

    ; rsi - larger integer, will be copied
    ; rdx - smaller integer, will be added

    xchg rsi, rdx

.adjust_for_most_significant_digit:
    ; save args before call
    mov [rsp], rdi
    mov [rsp+8], rsi
    mov [rsp+16], rdx

    ; check if last digit == 0
    ; dane
    mov rax, [rsi+8]
    ; rozmiar
    mov ecx, [rsi]
    ; rax = last digit
    mov rax, [rax+4*rcx-4]
    ; rsi = construct size
    mov esi, [rsi]
    cmp rax, 0
    je .construct_and_copy

    ; if last digit != 0, add 1 to rsi
    add esi, 1

.construct_and_copy:
    ; construct bignum with size of the larger number + 1
    ; BigInt(unsigned int)
    call _ZN6BigIntC2Ej

    ; rdi - cel (result.dane)
    mov rdi, [rsp]
    mov rdi, [rdi+8]

.copy:
    ; rsi - zrodlo (larger_register.dane)
    mov rsi, [rsp+8]
    ; n - n (larger_register.rozmiar)
    mov edx, [rsi]
    ; rsi - zrodlo
    mov rsi, [rsi+8]

    ; copy data
    call _Z6kopiujPjS_j

.setup_loop:
    ; rsi = result.dane
    mov rsi, [rsp]
    mov rsi, [rsi+8]

    ; rax = smaller_register.dane
    mov rax, [rsp+16]
    ; r8 = smaller_register.rozmiar
    mov r8d, [rax]
    mov rax, [rax+8]

    ; r9 - result.rozmiar
    mov r9, [rsp]
    mov r9d, [r9]

    ; carry flag
    mov rdx, 0
    ; counter
    mov rcx, 0

.add_loop:
    ; check if rcx >= rozmiar, if yes, exit
    cmp ecx, r8d
    jge .carry_check

    ; result.dane[i] += dane[i] + carry
    mov dword r10d, [rax+4*rcx]
    add dword [rsi+4*rcx], edx
    mov edx, 0
    jnc .cont_add
    mov edx, 1

.cont_add:
    add dword [rsi+4*rcx], r10d

    jnc .cont_loop
    mov edx, 1

.cont_loop:
    add ecx, 1
    jmp .add_loop

    ; if carry is up after the last digit
.carry_loop:
    add ecx, 1
    cmp ecx, r9d
    jge .ret

.carry_check:
    add [rsi+4*rcx], edx
    jc .carry_loop

.ret:
    add rsp, 3*8
    ret


count_nonzero:
    ; rdi - BigInt
    ; eax - len with omitted zeros
    mov eax, [rdi]
    mov rdi, [rdi+8]

.loop:
    cmp dword [rdi+4*rax-4], 0
    jne .ret

    sub eax, 1
    cmp eax, 0xffffffff
    jne .loop

    jne .ret
    mov eax, 0
    
.ret:
    ret


; friend BigInt operator- (const BigInt& a, const BigInt& b)
_ZmiRK6BigIntS1_:
    ; rdi - BigInt result space
    ; rsi - BigInt& a
    ; rdx - BigInt& b
    sub rsp, 32
    mov [rsp], rdi
    mov [rsp+8], rsi
    mov [rsp+16], rdx

    ; count nonzero digits for a 
    mov rdi, rsi
    call count_nonzero
    mov [rsp+28], eax

    ; count nonzero digits for b
    mov rdi, [rsp+16]
    call count_nonzero
    mov [rsp+24], eax

    ; check which is bigger
    cmp eax, [rsp+28]
    jb .construct_and_copy
    jne .swap_a_b

.compare_loop_init:
    mov rsi, [rsp+8]
    mov r8, [rsi+8]
    mov rdx, [rsp+16]
    mov r9, [rdx+8]
    cmp rax, 0
    je .construct_and_copy
    sub rax, 1

.compare_loop:
    mov r10, [r8+rax*4]
    cmp r10, [r9+rax*4]
    jb .swap_a_b
    ja .construct_and_copy
    cmp eax, 0
    je .construct_and_copy
    sub eax, 1
    jmp .compare_loop

    jmp .construct_and_copy

.swap_a_b:
    ; restore a and b
    mov rsi, [rsp+8]
    mov rdx, [rsp+16]

    ; exchange a and b if a.rozmiar < b.rozmiar
    xchg rsi, rdx
    mov [rsp+8], rsi
    mov [rsp+16], rdx
    mov eax, [rsp+28]
    mov [rsp+24], eax

.construct_and_copy:
    ; construct bignum with size of the larger number + 1
    ; BigInt(const BigInt&)
    mov rdi, [rsp]
    mov rsi, [rsp+8]
    call _ZN6BigIntC2ERKS_

.setup_loop:
    ; rdi - result
    mov rdi, [rsp]
    mov r11, [rdi]
    mov rdi, [rdi+8]

    ; rsi - what to sub
    mov rsi, [rsp+16]
    mov rsi, [rsi+8]

    ; edx - smaller count
    mov edx, [rsp+24]
    ; ecx - count
    mov rcx, 0
    ; eax - borrow
    mov rax, 0

    mov r9, 0
    mov r8, 0

.sub_loop:
    cmp ecx, edx
    jge .borrow_check

    mov r9d, [rdi+4*rcx]
    mov r8d, [rsi+4*rcx]

    ; if result[i] == 0
    cmp r9d, 0
    jne .non_zero

    ; if c[i] == 0, skip
    cmp r8d, 0
    jne .a_zero

    sub dword [rdi+4*rcx], eax
    jmp .cont_loop_skip_sub

.a_zero:
    ; substract c[i] from the largest digit
    mov r9, 0x100000000
    sub r9, rax
    sub r9, r8
    mov [rdi+4*rcx], r9d
    ;sub r8d, 1
    mov rax, 1
    jmp .cont_loop_skip_sub

.non_zero:
    ; since result[i] is non_zero, carry won't underflow
    sub r9d, eax
    mov eax, 0

    ; if r9d > r8d, just sub
    cmp r9d, r8d
    jb .underflow

    jmp .cont_loop

.underflow:
    ; else, add carry and sub
    mov eax, 1 
    ;mov r10, 0x100000000
    ;or r9, r10
    sub r9d, r8d
    mov [rdi+4*rcx], r9d
    jmp .cont_loop_skip_sub

.cont_loop:
    sub r9d, r8d
    mov [rdi+4*rcx], r9d

.cont_loop_skip_sub:
    add ecx, 1
    jmp .sub_loop

.borrow_check_loop:
    add rcx, 1

.borrow_check:
    cmp rcx, r11
    jge .ret
    sub dword [rdi+4*rcx], eax
    cmp dword [rdi+4*rcx], 0xffffffff
    je .borrow_check_loop

.ret:
    mov rax, [rsp]
    add rsp, 32
    ret

