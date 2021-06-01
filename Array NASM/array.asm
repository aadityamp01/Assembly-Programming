section .data
msg db 'Enter five numbers: ',10
msglen equ $-msg

section .bss
array resb 200
cnt resb 2



section .text
global _start
_start:
  
 mov rax,1
mov rdi,1
mov rsi,msg
mov rdx,msglen
syscall


mov r8,array
mov byte[cnt],5
lp:
mov rax,0
mov rdi,0
mov rsi,r8             ;Pointer to store accepted numbers
mov rdx,17
syscall


add r8,17
dec byte[cnt]
jnz lp


mov rax,1
mov rdi,1
mov rsi,array
mov rdx,200
syscall


mov rax,60
mov rdi,0
syscall


