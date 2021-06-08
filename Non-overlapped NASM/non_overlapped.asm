	; non overlapped- wihtout string inst- block transfer

section .bss
disbuff resb 01


%macro print 2 ; this is macro
MOV eax,4
MOV ebx,1
MOV ecx,%1
MOV edx,%2
int 80h
%endmacro


section .data
  arr1 db 11h,22h,33h,44h,55h
  arr1cnt equ 5

 arr2 db 00h,00h,00h,00h,00h
 arr2cnt equ 5

msg1 db 0Ah,"Block 1 contents are :"
len1 equ $-msg1

msg2 db 0Ah,"Block 2 contents are :"
len2 equ $-msg2

msg3 db 0Ah," "
len3 equ $-msg3

section .text
   global _start
  _start:

 mov esi,arr1
 mov ecx,arr1cnt
 mov edi,arr2
       
 ;  loop for moving the array1 contents to array2
l1:
  mov al,[esi]
  mov [edi],al
  inc esi
  inc edi
loop l1

print msg1,len1
     
mov rcx,05h
mov esi,arr1
 l2:
  push rcx
  mov bl,[esi]
  call dispnum
  print msg3,len3
  inc esi
  pop rcx
  loop l2

print msg2,len2      ;loop for display of array2 using array
mov rcx,05h
mov esi,arr2
 l3:
  push rcx
  mov bl,[esi]
  call dispnum
  print msg3,len3
  inc esi
  pop rcx
 loop l3

 

print msg3,len3

mov rax,60
syscall

dispnum:
  
  MOV ecx,2
  MOV edi,disbuff
 up1:
  ROL bl,4
  MOV al,bl
  AND al,0Fh
  CMP al,09h
  JBE skip
  AND al,07h
 skip:
  ADD al,30h
  MOV [edi],al
  INC edi
  LOOP up1
print disbuff,2
ret




