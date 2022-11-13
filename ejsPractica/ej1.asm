
extern malloc
extern free
extern sizeof
extern strlen

global borrarTerminadasEn
global agrupar
global ordena12bit

%define OFFSET_NEXT  0
%define OFFSET_PREV  8
%define OFFSET_STRING 16

%define OFFSET_TEXT 0
%define OFFSET_TEXT_LEN 8
%define OFFSET_TAG 16


section .data
vector1: DB 0x00, 0x00, 0x01, 0x00, 0x20, 0x03, 0x00, 0x40, 0x05, 0x00, 0x60, 0x07, 0x00, 0x80, 0x09, 0x00, 0xA0, 0x0B, 0x00, 0xC0, 0x0D, 0x00, 0xE0, 0x0F, 0x01, 0x00, 0x11, 0x01, 0x20, 0x13, 0x01, 0x40, 0x15, 0x01, 0x60, 0x17
vector2: DW 0X98E0, 0X3259, 0X0768, 0X71CC
vector3: DW 0xA164, 0xDEDA, 0xF145, 0x3892


mask1: DB 0xFF, 0xF0, 0x00, 0xFF, 0xF0, 0x00, 0xFF, 0xF0, 0x00, 0xFF, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00
mask2: DB 0x00, 0x0F, 0xFF, 0x00, 0x0F, 0xFF, 0x00, 0x0F, 0xFF, 0x00, 0x0F, 0xFF, 0x00, 0x00, 0x00, 0x00
shuffle: DB 0x00, 0x01, 0x03, 0x04, 0x06, 0x07, 0x09, 0x0A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0
shuffle2: DB 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0x00, 0x01, 0x03, 0x04, 0x06, 0x07, 0x09, 0x0A 

section .text


agrupar:
push rbp
mov rbp, rsp
pop rbp
ret


ordena12bit:
push rbp
mov rbp, rsp


movdqu xmm2, [mask1]
movdqu xmm3, [shuffle]
movdqu xmm4, [shuffle2]
movdqu xmm0, [vector1]
movdqu xmm1, [vector1]
shl xmm1, 3

pand xmm0, xmm2
pand xmm1, xmm2

pshufb xmm0, xmm3
pshufb xmm1, xmm4

movlhps

pop rbp
ret






borrarTerminadasEn:

    push rbp   
    mov rbp,rsp
    push r12
    push r13
    push r14
    push r15 
    push rbx
    sub rsp,8
    
    ;void borrarTerminadasEn(node** l, char c){
    ;for (int i = 0; i < sizeof(l); i++){
    ;    char* palabra = l[i]->string;
    ;    char ultimaLetra = palabra[sizeof(palabra)-1];
    ;    if(ultimaLetra == c){
    ;        if(&(l[i]) == l){
    ;            l = &(l[i]->next);
    ;            free(l[i]);
    ;        } else{
    ;            node* anterior = l[i]->prev;
    ;            anterior->next = l[i]->next;
    ;            free(l[i]);
    ;        }
    ;    }
    ;}
    ;rdi = node** l
    ;rsi = char c
    
    xor r12, r12  ;r12 = i
    mov r13, rdi  ;r13 = l (iterador)
    mov r14, rsi  ;r14 = c
    mov r15, rdx
    mov rbx, r13  ;rbx = l (pos inicial)
    
    ;falta caso del primer nodo
    loopstart:
    CMP r12, r15
    JZ fin
    mov rdi, [r13 + OFFSET_STRING]
    call strlen
    add rdi, rax
    dec rdi
    CMP byte [rdi], r14b
    JNZ loopstart
    

    ;me fijo si es el primero
    CMP r13, rbx
    JNZ borrado
    mov rbx, [r13 + OFFSET_NEXT]

    
    ;arreglo los punteros
    punteros:
    mov r8, [r13 + OFFSET_PREV]
    mov r9, [r13 + OFFSET_NEXT]
    mov [r8 + OFFSET_NEXT], r9

    borrado:
    ;borro next
    mov rdi, r13
    call free
    add r13, 8
    ;borro prev
    mov rdi, r13
    call free
    add r13, 8
    ;borro string
    mov rdi, r13
    call free
    add r13, 8
    ;quedo en el siguiente nodo, ya esta
    inc r12
    jmp loopstart

    
    
    

    fin:
    
    mov rdi, rbx
    ;epilogo
    add rsp,8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

;problema:
    