extern malloc
global filtro

;########### SECCION DE DATOS
section .data
maskpar: DB 0x00,0x01,0xF0,0xF0,0x04,0x05 ,0xF0 ,0xF0 ,0x08 ,0x09 ,0xF0 ,0xF0 ,0x0C ,0x0D ,0xF0 ,0xF0
maskimpar: DB 0xF0, 0xF0, 0x02, 0x03, 0xF0, 0xF0, 0x06, 0x07, 0xF0, 0xF0, 0x0A, 0x0B, 0xF0, 0xF0, 0x0E, 0x0F

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;int16_t* filtro (const int16_t* entrada, unsigned size)
filtro:
    ;rdi    puntero 8 bytes
    ;rsi    4 bytes

    ;r1    i
    
    ;prologo
    push rbp
    mov rbp, rsp
    push r15
    push r14
    push r13
    push r12
    push rbx
    sub rsp, 8
    
;CODIGO
    ;hacer call malloc
    mov r15, rdi
    mov r14, rsi
    sub r14, 3
    ;int16_t* salida = (int16_t*) malloc((size*4)-(3*4));           ;por qué 4 y no 2???????????????
    shl rsi, 2   ;size * 4
    sub rsi, 12
    mov rdi, rsi
    call malloc ;en rax puntero a salida
    mov r13, rax

    xor r12,r12  ;r12 = i

    ;-------------------FOR--------------------
    
    ;aplicar mascara para R y guardar en la res                 ;pshufb es buena, pshfw es una poronga
    ;aplicar mas para L y guardar en la res
.cycle:    
    movdqu xmm0, [r15]
    movdqu xmm1, [r15]
    movdqu xmm2, [r15]

    movdqu xmm3, [maskpar]    
    pshufb xmm2, xmm3          ;si no funca pasar a un xmm

    movdqu xmm3, [maskimpar]    
    pshufb xmm1, xmm3        ;si no funca pasar a un xmm
    
    phaddw xmm2, xmm2
    phaddw xmm2, xmm2
    phaddw xmm2, xmm2               ;tal vez sean 3 phaddw

    xor rbx, rbx
    movd ebx, xmm2
    shr ebx, 2
    mov [r13], bx
    add r13, 2
    
    phaddw xmm1, xmm1
    phaddw xmm1, xmm1
    phaddw xmm1, xmm1               ;tal vez sean 3 phaddw
    
    xor rbx, rbx
    movd ebx, xmm1
    shr bx, 2
    mov [r13], bx
    add r13, 2
    
    inc r12
    cmp r12, r14
    jle .cycle


    ;epilogo
    add rsp, 8
    pop rbx
    pop r12
    pop r13
    pop r14
    pop r15
    pop rbp

    ret
    