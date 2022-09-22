;x1[rdi], x2[rsi], x3[rdx], x4[rcx]
global sumarArreglo
sumarArreglo:
    mov ecx, 0x10
    mov eax, 0x0
    ciclo:
        add eax, [rdi]
        add rdi, 4
    loop ciclo
ret