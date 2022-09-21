;Mov. de datos: movd, movq, movdqu
;Aritméticas: paddb, paddw, paddd, paddq, psubb, psubw, psubd, psubq

;a) void SumarVectores(char *A, char *B, char *Resultado, int dimension)
section .data
extern malloc
global sumarVectores

section .text
sumarVectores:
    ;rdi: char* a
    ;rsi: char* b
    ;rdx: char* res
    ;rcx: int dimension
    push rbp
    mov rbp, rsp

    push r12
    push r13
    push r14
    push rbx
    
    ;guardo reg
    mov r12, rdi
    mov r13, rsi
    mov r14, rdx
    mov rbx, rcx


    ;calculo len que toma lo de rdi
    ;cuántos loops, divido por 16
    mov rdi, rcx
    mov r8, malloc
    call r8
    ;puntero en rax
    mov rdx, rax        ;por las dudas, ya que res está en rdx
    
    ;divido por 16
    ;suma vertical
    ;r12: char *a
    ;r13: char *b
    ;14: char *res
    ;rbx: int dimension
    shr rbx, 4
    mov ecx, ebx
    ;dec ecx
.cycle:
    movdqu xmm0, [r12]        ;tal vez QWRD[] 
    movdqu xmm1, [r13]
    paddsb xmm0, xmm1
    
    movdqu [rax], xmm0
    ;salto a lo proximo a sumar
    add r12, 16 ;a
    add r13, 16 ;b
    add rax, 16 ;res
    loop .cycle
    
    
    ;p (char*)$r12
    pop rbx
    pop r14
    pop r13
    pop r12
    pop rbp
    ret
