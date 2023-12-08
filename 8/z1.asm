global _Z6rotateji, _Z6rotatehi

_Z6rotateji:
    ; rdi - x
    ; rsi - n
    mov ecx, esi
    and ecx, 0x1f
    rol edi, cl
    mov eax, edi
    ret

_Z6rotatehi:
    ; rdi - x
    ; rsi - n
    mov eax, 0

    and edi, 0xff

    mov ecx, esi
    and ecx, 0x1f

    mov edx, edi
    rol dl, cl

    mov al, dl
    ret
