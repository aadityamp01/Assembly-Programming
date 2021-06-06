section .bss
dispbuff resb 08
CR0_data resd 1
id resd 1
gdt resd 1
resw 1
ldt resw 1
idt resd 1
resw 1
tr resw 1

%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .data
msg db 10,"System is working in: "
len equ $-msg
msg1 db 10,"Protected Mode"
len1 equ $-msg1
msg2 db 10,"Real Mode"
len2 equ $-msg2
msg3 db 10,"Contents of GDTR: "
len3 equ $-msg3
msg4 db 10,"Contents of LDTR: "
len4 equ $-msg4
msg5 db 10,"Contents of IDTR: "
len5 equ $-msg5
msg6 db 10,"Contents of TR: "
len6 equ $-msg6
msg7 db 10,"Contents of MSW: "
len7 equ $-msg7
msg8 db 10,"CPU identification: "
len8 equ $-msg8

section .text
global _start:
_start:
print msg,len
SMSW eax
mov [CR0_data],eax
bt eax,0
jnc rmode
print msg1,len1

SGDT [gdt]
SLDT [ldt]
SIDT [idt]
STR [tr]

print msg3,len3
mov bx,[gdt+4]
call dispnum
mov bx,[gdt+2]
call dispnum
mov bx,[gdt]
call dispnum

print msg4,len4
mov bx,[ldt]
call dispnum

print msg5,len5
mov bx,[idt+4]
call dispnum
mov bx,[idt+2]
call dispnum
mov bx,[idt]
call dispnum

print msg6,len6
mov bx,[tr]
call dispnum

print msg7,len7
mov bx,[CR0_data+2]
call dispnum
mov bx,[CR0_data]
call dispnum

print msg8,len8
mov eax,0
cpuid
mov [id], eax
mov bx,[id+2]
call dispnum
mov bx,[id]
call dispnum


jmp exit

rmode:
print msg2,len2

exit: mov rax,60
syscall

dispnum: ;dispnum for 4 digit hex to ascii
mov ecx,4
mov edi,dispbuff

up4: rol bx,4
mov al,bl
and al,0fh
cmp al,09h
jbe skip
add al,07h
skip: add al,30h
mov [edi],al
inc edi
loop up4
print dispbuff,4
ret


