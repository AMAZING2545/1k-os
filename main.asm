[org 0x7c00]
bits 16 ;this is for the original 8086 or 8088
section _data:
;nothing for now
section _text:
start:
  call phase1
phase1:
  ;initializing stack
  mov bp, 0x8000
  mov sp, bp
  ; testing stack
  mov ax, 0xee50
  push ax ;i could use pusha but we are working on a 8086
  xor ax, ax ;zeroing ax
  pop ax  ;i could use popa but we are working on a 8086
  cmp ax, 0xee50 ;testing if it is ok
  mov ah, 0x0e
  je success
  jmp error
success:
  mov al,'0'
  int 0x10
  jmp end
error:
  mov al,'1'
  int 0x10
  jmp end
end:
jmp $

times 510-($-$$) db 0
dw 0xaa55
