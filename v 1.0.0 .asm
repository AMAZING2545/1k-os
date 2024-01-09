[org 0x7c00]
bits 16

jmp short start
nop
hlt

;disk header 
oem: db "1k-os "  ;6 bytes
bytes_sector:  dw 512
reserved: db 1 ; the boot sector
sectors:  dw 0
heads:   db 0
sectors_per_cylinder: db 0
cylinders: db 0
drive_num: db 80h ;harddisk 1
ascii: db 0
lba:
dw 1
buffer:resb 6
sectorsread: db 0
;;services



printservice:
;;inputs : base address es:bx
;;length: cx
  mov ah, 0x0e
  mov al, [bx]
  cmp cx, 0
  je .end1
  int 10h
  dec cx 
  inc bx
  jmp printservice
  .end1: ret
  
  
  
convnumservice:

  mov bx, buffer
  add bx, 5
  mov cx, 10
  .convert:
  xor dx, dx
  div cx
  add dl, '0'
  dec bx
  mov [bx],dl
  test ax, ax
  jnz .convert
  mov bx, buffer
  mov cx, 5
  xor di, di
  call printservice
texttonumservice:
    
  
lbatchs:
mov cx, [lba]
xor ax, ax
xor dx, dx
mov bx,[heads]
div bx
mov ch, dl

xor ax, ax
mov bx,[heads]
div bx
mov dl, dh
inc cl
mov dl,0
ret

diskreadservice:
call lbatchs
mov ah,0x02
mov al, 1 
mov dl, [drive_num]
mov bx, 0x8000
int 13h
jc x
add bx, 0x0c
mov al,[bx]
mov ah,0x02
mov dl, [drive_num]
mov bx, 0x8000
int 13h
jc x  
ret  
  
  
start:
mov bp, 0x7bff
mov sp, bp
call getdiskparams
getdiskparams:
clc
mov ah, 8
mov dl, [drive_num]
xor di,di
int 13h
mov [heads], dh
mov [sectors_per_cylinder], cl
mov [cylinders], ch
ret

x:
  mov ah, 0x0e
  mov al, '1'
  int 10h
  hlt

end2:
nop
times 510-($-$$) db 0
dw 0xaa55  
;hi.txt
db "hi      .txt",1,"this is 1k os"  
times 1024-($-$$) db ' '
  
  
  
  
  
  
  
  
