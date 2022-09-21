section .data
    array:    times 16 dd 1
    length        equ         $-array        ;error aca
global _start

section .text
_start:
    xor rsi, rsi        ;acá va el resultado
    mov rdi, array      ;puntero a array
    mov ecx, length     ;para el Loop
    shr ecx, 2          ;div4 porque lo tengo en bytes, y quiero en 32
.cycle:
    add esi, [rdi]      ;sumo elemento
    add rdi, 4          ;salto al sig elemento, 4 bytes/32bits
    loop .cycle    
    ;resultado en esi
    
_fin:             
    mov rax, 1          ;funcion 1, salir de llamada
    mov rbx, rsi        ;codigo de error, puse esto para ver si me sumba 16,  lo cumple.
    int 0x80

            ;intenté x/16dd arreglo pero también me tira error  "no single arreglo in current context", 
    ;Reading symbols from ejercicio1...         El "done" nunca aparece
    ;>>> b ejercicio1.asm:15
    ;No line 15 in file "ejercicio1.asm".

;ULTIMAS PREGUNTAS
    ;--cuanto lugar me ocupa? Tengo entendido que 200, ya que son 512 bits, pero haciendo  nmejercicio 1 me da 2000
    ;--no me poner breakpoints en gdb, pongo b holamundo.asm:15 pero no encuentra la linea








;Teórica 
;Un brach es la peor situación en pérdida de performance
;Un branch es una discontinuidad 
;Pipeline
;Enlace producto consumidor, es el tad?/tac?
;"Esto es pregunta de examen" Qué parte?xd Slide:"Ejemplo de algoritmo-Ciclo2"

;SIempre comentar alineaciones