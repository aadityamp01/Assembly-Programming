;Prepared by Aaditya Paithane 
;ALP to find the factorial of a given integer number on a command line by  using recursion. Explicit stack manipulation is expected in the code.

%macro scall 4   ;macro for read/write system call
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro
;--------------- DATA SECTION -----------------------
Section .data
title:db "------ Factorial Program ------",0x0A
      db "Enter Number : ",0x0A
title_len: equ $-title
factMsg: db "Factorial is :", 0x0A
factMsg_len: equ $-factMsg
cnt: db 00H
cnt2:db 02H
num_cnt: db 00H
;--------------- BSS SECTION -------------------------
Section .bss
number:resb 2
factorial:resb 8 
;--------------- TEXT SECTION -------------------------
Section .text
global _start
_start:
scall 1,1,title,title_len
scall 0,0,number,2

mov rsi,number  ;convert no.from ascii to hex
call AtoH  ;converted number is stored in "bl"

mov byte[num_cnt],bl
dec byte[num_cnt]   ;decrement count by 1 for stack top

mov rax,00H
mov al,bl
TOP:
push rax ;push every 0<value<number to stack
dec rax
cmp rax,01H
jnbe TOP
 
mov al,01H
FACTLOOP:
pop rbx
mul bx ;ax=ax*bx
dec byte[num_cnt]
jnz FACTLOOP

mov bx,ax ;copy result from ax to bx for HEX to ASCII Conversion
mov rdi,factorial
call HtoA_value

scall 1,1,factMsg,factMsg_len ;Print msg and factorial
scall 1,1,factorial,8

;Exit System call
mov rax,60
mov rdi,0
syscall

;------------- ASCII to HEX Conversion Procedure ---------------------
AtoH:  ;result hex no is in bl
mov byte[cnt],02H
mov bx,00H
hup:
rol bl,04
mov al,byte[rsi]
cmp al,39H
JBE HNEXT
SUB al,07H
HNEXT:
sub al,30H
add bl,al
INC rsi
DEC byte[cnt]
JNZ hup
ret

;------HEX TO ASCII CONVERSION METHOD FOR VALUE(2 DIGIT) ----------------
HtoA_value: ;hex_no to be converted is in ebx //result is stored in rdi/user defined variable
mov byte[cnt2],08H
aup1:
rol ebx,04
mov cl,bl
and cl,0FH
CMP CL,09H
jbe ANEXT1
ADD cl,07H
ANEXT1: 
add cl, 30H
mov byte[rdi],cl
INC rdi
dec byte[cnt2]
JNZ aup1
ret
