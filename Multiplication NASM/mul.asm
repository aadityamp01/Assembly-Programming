section .data
	msg db 10,"Menu"
		db 10,"1.Succesive addition"      
		db 10,'2.Add and Shift Addition'
		db 10,"3.Exit"
		db 10,"Enter your choice: "
	len equ $-msg

	msg1 db 10,"Enter 1st two digit number:"
	len1 equ $-msg1
	msg2 db 10,"Enter 2nd two digit number:"
	len2 equ $-msg2
	msg3 db 10,"Result:"
	len3 equ $-msg

section .bss
	numascii resb 05
	num1 resb 05
	num2 resb 05
	dispbuff resb 05

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
	call proc
	jmp _start

case2:
	cmp byte[numascii],'2'
	jne exit
	call multi
	jmp _start

exit:
	mov rax,60
	syscall


;successive addition method

proc:                         
	print msg1,len1     ;enter 1st number
	accept numascii,3
	call packnum
	mov [num1],bl            ;num1= 02

	print msg2,len2      ;enter 2nd number
	accept numascii,3
	call packnum          ; bl = 03

	mov ax,0	      ; ax=0 
up:
	add ax,[num1]        ; ax= ax+[num1] = 04 + 02 = 06

	dec bl               ; bl=0
	jnz up
	mov bx,ax            ; bx=06
	call dispnum
ret
 


; Add & Shift method
multi:
	print msg1,len1
	accept numascii,3
	call packnum
	mov [num1],bl      ; num1=02

	print msg2,len2
	accept numascii,3
	call packnum
	mov [num2],bl      ; num2=03

	mov ax,00h
	mov dx,00h
	mov al,[num1]        ; al= 02         0000 0010
	mov bl,[num2]        ; bl = 03        0000 0011
	mov cx,00h	;result
	mov dl,08h	;counter
l2:	
	shr bl,01h        ; bl= 0000 0000  , shr = 0000 0000  0 
	jnc l1
	add cx,ax         ; cx=cx+ax= 02+04 = 06 
l1: shl al,01             ;al= 0000 1000, shl= 0001 0000  
	dec dl            ; dl=05
	jnz l2            
	mov rbx,rcx
	call dispnum
ret

dispnum:
	mov rcx,04
	mov edi,dispbuff
up2:
	rol bx,04
	mov al,bl
	and al,0fh
	cmp al,09h
	jbe skip
	add al,07h
skip:
	add al,30h
	mov [edi],al
	inc edi
	loop up2
	print dispbuff,4
ret

packnum:
	mov bx,0
	mov rcx,02
	mov esi,numascii
up1:rol bl,04
	mov al,[esi]
	cmp al,39h
	jbe skip1
	sub al,07h
skip1:
	sub al,30h
	add bl,al
	inc esi
	loop up1
ret

