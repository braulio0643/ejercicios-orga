;Preguntar por todo xd
;
section .data
    array:    times 16 dd 1
    ;long        equ         $-arreglo        ;error aca
global _start

section .text
_start:
;epílogo y guardo reg no volatiles
    push rbp
    mov rbp,rsp     

    mov rcx, 16
    mov rsi, array
.cycle:
    mov edi, [rsi]
    push rdi
    add rsi, 4
    loop .cycle

    mov rcx,16
    xor rdx, rdx

.sumas:
    add rsi, [rsp - rdx]    ;falta ver como hacer esto nomas creo.
    add rdx, 8
    loop .sumas


    ;ret

    mov rax, 1          ;funcion 1, salir de la llamada
    mov rbx, rsi        ;codigo de error, lo uso pa ver el res.
    int 0x80
;CÓMO DEBE TERMINAR ESTO xd, con ret o int 0x80
    ;ret

