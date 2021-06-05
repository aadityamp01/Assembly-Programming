section .data
msg db 10,'MENU:',10
    db '1.Hex to BCD conversion',10
    db '2.BCD to Hex conversion',10
    db '3.Exit',10
    db 'Enter your choice',10
len equ $ -msg

msg1 db 'Enter the 4 digit HEX number',10
len1 equ $ -msg1

msg2 db 'Its BCD equivalent is',10
len2 equ $ -msg2

msg3 db 'Enter the 5 digit BCD number',10
len3 equ $ -msg3

msg4 db 'Its HEX equivalent is',10
len4 equ $ -msg4

msg5 db 'Invalid choice',10
len5 equ $ -msg5

section .bss
numascii resb 06
opbuff resb 05
dnumbuff resb 08

%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro accept 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .text
global _start
_start:

print msg,len
accept numascii,2

case1:
cmp byte[numascii],'1'
jne case2
call h2b
jmp _start

case2:
cmp byte[numascii],'2'
jne case3
call bcd2hex
jmp _start

case3:
cmp byte[numascii],'3'
je exit
print msg5,len5
jmp _start

exit:
mov rax,60
syscall


h2b:
print msg1,len1
accept numascii,6
call packnum
mov rcx,0
mov ax,bx
mov bx,10

up1:
mov dx,0
div bx
push rdx
inc rcx
cmp ax,0
jne up1
mov rdi,opbuff

up2:
pop rdx
add dl,30h
mov [edi],dl
inc rdi
loop up2

print msg2,len2
print opbuff,5
ret

bcd2hex:
print msg3,len3
accept numascii,6
print msg4,len4

mov rsi,numascii
mov rcx,05
mov rax,0
mov ebx,0ah

l1:
mov edx,0
mul ebx
mov dl,[esi]
sub dl,30h
add eax,edx
inc esi
loop l1
mov ebx,eax
call disp
ret

packnum:
mov bx,0
mov ecx,04
mov esi,numascii

up:
rol bx,04
mov al,[esi]
cmp al,39h
jbe skip1
sub al,07h
 
skip1:
sub al,30h
add bl,al
inc esi
loop up
ret

disp:
mov edi,dnumbuff
mov ecx,08

dispup:
rol ebx ,4
mov dl,bl
and dl,0fh
add dl,30h
cmp dl,39h
jbe dispskip1
add dl,07h

dispskip1:
mov [edi],dl
inc edi ;
loop dispup
print dnumbuff+3,5
ret

