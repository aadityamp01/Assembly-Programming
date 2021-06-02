%macro write 2
mov rax, 1
mov rdi, 1    
mov rsi, %1
mov rdx, %2
syscall
%endmacro


section .data
msg db 'Enter a string: ',10
msglen equ $-msg

section .bss
   string resb 200  ;input
result resb 16      ;length


section .text
global _start
_start:

 mov rax,1
mov rdi,1
mov rsi,msg
mov rdx,msglen
syscall

;When we accept string, length automatically returns in RAX register

mov rax, 0
mov rdi, 0    
mov rsi, string
mov rdx, 200
syscall

dec rax                    ;decrement rax by 1 for enter key to get exact length
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






