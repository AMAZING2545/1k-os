org 0x7c00
bits 16
section .cache:
;basically virtual memory
dd 0
section .text:
;set stack 
mov bp, 0x7f00
mov sp, bp
;set registers
xor ax, ax


jmp $
times 510-($-$$) db 0
dw 0xaa55
