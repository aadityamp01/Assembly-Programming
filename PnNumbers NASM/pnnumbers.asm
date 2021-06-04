section .data
msg db 10, 'Count of positive and negative numbers in an array', 10
msg_len equ $-msg

pmsg db 10, 'Count of positive numbers', 10
pmsg_len equ $-pmsg

nmsg db 10, 'Count of negative numbers', 10
nmsg_len equ $-nmsg

nwline db 10

pcnt db 0                    
ncnt db 0

array dq 9000000000000000h,8000000000000000h,90h,20h 
arrcnt equ 4


section .bss
result resb 2


%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .text
global _start
_start:

print msg,msg_len
mov rsi,array
mov rcx,arrcnt   
up1:   bt qword[rsi],63
       jnc pnxt	
       inc byte[ncnt]  
       jmp pskip           

pnxt:  inc byte[pcnt] 
pskip: inc rsi
       inc rsi
	inc rsi
        inc rsi

       loop up1   

       print pmsg, pmsg_len
       mov bl,[pcnt]
       call disp8num
       print nmsg, nmsg_len
       mov bl,[ncnt]
       call disp8num
       print nwline,1

exit: mov rax,60
	syscall


disp8num: mov rcx,2
          mov rdi,result

dupl: rol bl,04
      mov al,bl
      and al,0fh
      cmp al,09
      jbe dskip
      add al,07h

dskip:
         add al,30h
         mov [rdi],al
         inc rdi
         loop dupl


         print result, 2
         ret

