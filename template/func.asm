
global llamadora
global invocada
global cesar1
global cesar2

section .text

llamadora:
   push rbp
   mov rbp,rsp
   push rdi
   call invocada
   ;0x00005555555551ca
   mov r8, $
   add r8, rdi
   pop rdi
   pop rbp
   ret

invocada:
   push rbp
   mov rbp, rsp

   ;rbp0, rdi, eip0, rbp1, 
   mov rax, [rbp + 0x08]
   add rax, [rbp + 0x10]
   
   pop rbp
   ret

cesar1:


cesar2:
   push rbp
   mov rbp, rsp
   ;rdi es el char*, rsi es x
   mov ah,[rsi]
   mov rax, msg
   mov r8, msg

loopstart:
   mov al,[rdi]
   cmp al, 0
   JE fin
   add al, ah
   mov [r8], al
   inc rdi
   inc r8
   jmp loopstart

fin:
   pop rbp
   ret    


section .data
    msg db 0xa
    len equ $ - msg
