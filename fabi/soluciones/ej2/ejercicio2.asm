;a. Usé rdi y en cada loop le sumo 4 para avanzar en el array
;es de 64

;b.no entendi la parte de sumarlo en 64, osea usar todo el registro sin importar lo que tengo en los 32 más significativos?

;c. No marearme con los nombres? xd No entiendo

;d. Si están completos con 1 y los muevo, la parte más significativa me deja en 1s, lo demas me los pisa
    ;no veo mucho cuál sería el problema, mover en 32 y sumar en 64 me afectaría los flags como overflow?
    ;Sé que si sumo en 64 los bits más significativos con 1s también se sumarían
    ;Otra cosa también es que podría afectarme los flows de manera incorrecta.
section .data
    array:    times 16 dd 10
    length       equ         $-arreglo        ;error aca
global _start

section .text
_start:
    xor rsi, rsi        ;acá limpio los unos en teoría, sería lo del punto d?
    mov rdi, array   
    mov ecx, length
.cycle:
    mov r8d, [rdi]      ;guardo en 32?
    add rsi, r8         ;sumo en 64? problema con unos: me modifica flags?
    add rdi, 4          ;siguiente elemento
    loop .cycle 
    ;res en rsi
    mov rax, 1          ;funcion 1, salir de la llamada
    mov rbx, rsi        ;codigo de error, lo uso pa ver el res.
    int 0x80

    ;ret
