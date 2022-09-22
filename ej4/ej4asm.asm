section .data
    ;mask: DQ 0x00, 0x80, 0x01, 0x80, 0x02, 0x80, 0x03, 0x80, 0x04, 0x80, 0x05, 0x80, 0x06, 0x80, 0x07, 0x80
    mask1: DQ 0x8003800280018000
    mask2: DQ 0x8007800680058004
    
    mask3: DQ 0x0780068005800480 
    mask4: DQ 0x0380028001800080
    ;mask2: DQ 0x80, 0x00, 0x80, 0x01, 0x80, 0x02, 0x80, 0x03, 0x80, 0x04, 0x80, 0x05, 0x80, 0x06, 0x80, 0x07

extern malloc
global intercalar

section .text
intercalar:
    push rbp    
    mov rbp,rsp
    movdqu xmm2, [mask1]
    movdqu xmm3, [mask2]
    movlhps xmm2, xmm3
    movdqu xmm3,[mask3]
    movdqu xmm4, [mask4] 
    movlhps xmm3, xmm4
    shr rcx, 4
    pxor xmm0, xmm0
    

    
    ;movlp

    loopstart:
    movq  xmm0,  [rdi]
    movq  xmm1,  [rsi]
    
    pshufb xmm0, xmm2
    pshufb xmm1, xmm3
    paddb xmm0, xmm1
    movdqu [rdx], xmm0
    
    add rdi, 8
    add rsi, 8
    add rdx, 16
    loop loopstart


    pop rbp
    ret