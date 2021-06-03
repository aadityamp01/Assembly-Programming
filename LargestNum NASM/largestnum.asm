%macro write 2
mov rax, 1
mov rdi, 1    
mov rsi, %1
mov rdx, %2
syscall
%endmacro

section .data
array db 11h,55h,33h,66h,44h


section .bss
cnt resb 1
result resb 16

section .text
global _start

_start: 

mov byte[cnt],05
mov rsi, array

mov al, 0
lp: cmp al,[rsi]
Jg skip1

Xchg al,[rsi]

skip1: inc rsi
dec byte[cnt]
Jnz lp

; Display al              
  call display

mov rax,60
syscall



display: mov rbx,rax  
mov rdi, result 
 mov cx,16

up1:
rol rbx,04  
mov al,bl  
and al,0fh
  cmp al,09h 
 jg add_37 
 add al,30h  
jmp skip
add_37: add al,37h 

skip: mov [rdi],al
inc rdi
dec cx
jnz up1
write result,16
ret


