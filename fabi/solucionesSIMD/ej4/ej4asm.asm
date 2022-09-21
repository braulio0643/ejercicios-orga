section .data
    mask: DQ 0x00080109020A030B
    mask2: DQ 0x040C050D060E070F

extern malloc
global intercalar

section .text
intercalar:
    push rbp    
    mov rbp,rsp

    ;rdi puntero a A
    ;rsi puntero a B
    ;rdx puntero a res
    ;rcx n

    ;codigo
    ;guardo valores
    mov r12, rdi
    mov r13, rsi
    mov r14, rdx
    mov r15, rcx

    ;muevo n a rdi para malloc
    mov rdi, r15
    call malloc
    ;en rax el resultad

    movq xmm0, QWORD [mask]  ;pongo mitad mascara en 0
    movq xmm1, QWORD [mask2]    ;pongo mitad mascara en 1
    movlhps xmm1, xmm0  ;unifico máscara con esta funcion en xmm1

    movdqu xmm0, xmm1   ;muevo de 1 a 0 y ahí queda máscara
    ;
    movdqu xmm1, [r12]  ;en xmm1 pongo 128 bits r12
    movdqu xmm2, [r13]  ;en xmm2 pongo 128 bits r13
    movdqu xmm2, xmm1

    ;epilogo
    pop rbp
ret

;problema:
    