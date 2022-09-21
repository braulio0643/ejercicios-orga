;TIP-VER CLASE PRACTICA NUM3- Convención C, etc
;TOma como base el ejercicio1??
;guardar los 16 hace que deba guardar en el stack. Eso significa que debo tener ret y lo de int0x80, cómo lo organizo?
;b. Es necesario preservar registros? Sumo primero los volátiles, luego accedo al stack para guardarlos en 
    ;un registro cuyo valor ya sumé, con eso estaría y no debería preservar ningún registro, o sí?

section .data
    array:    times 16 dd 1
    ;long        equ         $-arreglo        ;error aca
global _start

section .text
_start:
;uso los registros volatiles, luego pusheo los no volatiles para usarlos(al final los popeo)
;   pero acá ya debo respetar convención C? Sino puedo usar todos los registros(14, sin contar rsp y rpb),
;   y algunos me quedan en la stack(2)
;Respetando la convención me quedan bastantes más en la stack
;Luego sumo todos los regs, despues los que están en el stack, y al final popeo.
;
;epílogo y guardo reg no volatiles
    push rbp
    mov rbp,rsp     

    push rbx    
    push r12    ;--convención C
    push r13
    push r14
    push r15    ;quedaría desalineada.
    sub rsp, 8  ;alineada a 16 bytes

;guardo los primeros 6 elementos en reg-volatiles
    mov edi, [array]
    mov esi, [array + 4]
    mov edx, [array + 8]
    mov ecx, [array + 12]
    mov r8d, [array + 16]
    mov r9d, [array + 20]

;guardo otros 5 elem en reg-no-volatiles; el rbp no lo toco
    mov ebx, [array + 24]
    mov r12d, [array + 28]
    mov r13d, [array + 32]
    mov r14d, [array + 36]
;SE PUEDEN USAR REGISTROS R9 Y R11? Ya que convención C no dice nara
;me da fiaca hacer un loop
    mov r15d, [array + 40]
    push r15

    mov r15d, [array + 44]
    push r15
    
    mov r15d, [array + 48]
    push r15

    mov r15d, [array + 52]
    push r15

    mov r15d, [array + 56]
    push r15

    mov r15d, [array + 60]
    push r15
;hasta acá ya puse en lugares distintos los elementos, ahora sumo.

    add rdi, rsi
    add rdi, rdx
    add rdi, rcx
    add rdi, r8
    add rdi, r9
    add rdi, rbx
    add rdi, r12
    add rdi, r13
    add rdi, r14

    add rdi, [rbp - 56]
    add rdi, [rbp - 64]
    add rdi, [rbp - 72]
    add rdi, [rbp - 80]
    add rdi, [rbp - 88]
    add rdi, [rbp - 96]


;respuesta en rdi
    pop r15
    pop r15;lo hago porque no quiero dejar nada ahí, pero no debería haber problema si no lo hago, no? 
    pop r15
    pop r15
    pop r15

;epilogo
    add rsp, 8
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx

    ;mov rax, rip   ;pa verlo con 

    pop rbp
    ;ret

    mov rax, 1          ;funcion 1, salir de la llamada
    mov rbx, rdi        ;codigo de error, lo uso pa ver el res.
    int 0x80
;CÓMO DEBE TERMINAR ESTO xd, con ret o int 0x80
    ;ret
