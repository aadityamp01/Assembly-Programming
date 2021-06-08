           ; overlapped-block transfer-with string


%macro print 2
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro

section .bss
  disbuff resb 01

section .data

array1 db 11h,22h,33h,44h,55h


msg1 db 0Ah,"Source Block contents are:",0Ah
len1 equ $-msg1

msg2 db 0Ah,"Overlapped Destination Block contents are:",0Ah
len2 equ $-msg2

msg3 db " "
len3 equ $-msg3

shift equ 02

section .text
  global _start
    _start:

         ; display source array
   print msg1,len1
   mov esi,array1
   mov ecx,05h
   l1:
      push rcx
      mov bl,[esi]
      call dispnum
      print msg3,len3
      inc esi
      pop rcx
   loop l1
    
        ; overlapp the block array1
      dec esi 
      mov edi,esi
      mov eax,shift
      add edi,eax                   ;so it will point 2 locations ahead
      mov ecx,05h                    ; refill array count

      

     

     
     ; actual overlapping 

   l2: 
       mov al,[esi]
       mov[edi],al
       dec esi
       dec edi
   loop l2

 ; std   ;for string instructions only 2 lines  
 ; rep movsb

   ; to display destination block 
   ; increment ecx by shift loca(2)
   
    
    print msg2,len2
    mov ecx,07h
    mov esi,array1
  l3:
     push rcx
     mov bl,[esi]
     call dispnum
     print msg3,len3
     inc esi
     pop rcx
  loop l3 

mov eax,01
mov ebx,00
int 80h

dispnum :
mov ecx, 2
mov edi, disbuff

up1 :
rol bl, 4
mov al,bl
and al,0Fh
cmp al,09h
jbe skip
sub al,07h
skip :
add al,30h
mov [edi],al
inc edi
loop up1
print disbuff,2
ret


