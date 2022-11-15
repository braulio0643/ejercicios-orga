


;uint32_t virt
;uint32_t phy
;uint16_t task_sel

%define OFFSET_task_sel 8
%define OFFSET_phy 4
%define OFFSET_virt 0
 
;CODIGO EN ASM
global gdt_desc
global tareaActual

section .data
gdt_desc: dd 0 0


section .text
cargar_gdt:
sgdt gdt_desc
ret

tareaActual:
mov r8, [esp + 4] ;en ESP esta el EIP y arriba debería estar el parámetro supuestamente. entonces r8= virt
mov [esp + 8 + OFFSET_EIP], r8
mov [esp + 8 + OFFSET_ESP], ebp

ret

