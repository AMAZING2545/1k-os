org 0x7c00
bits 16
section .cache:
dd 0
section .text:
;set stack 
mov bp, 0x7f00
mov sp, bp


jmp $
times 510-($-$$) db 0
dw 0xaa55
