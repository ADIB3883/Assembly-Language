.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC 

mov bx,0
MOV AH,01H
INT 21H  
input:

CMP AL,'r'
JE l2
JNE Label

l2:
MOV AH,01H
INT 21H
CMP AL,'i'
JE l3 
jne label

l3:
MOV AH,01H
INT 21H
CMP AL,'z'
JE l4
jne label

l4:
MOV AH,01H
INT 21H
CMP AL,'v'
JE l5
jne label

l5:
mov ah,01h
int 21h
cmp al,'e'
je l6
jmp label
l6:
mov ah,01h
int 21h
cmp al,'e'
je ll
jne label
ll:
add bx,1
jmp label

label:
cmp al,'r'
je l2 
cmp al,0dh 
je exit

mov ah,01h
int 21h
jmp input



    exit:
    mov ah,02h
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h 
    
   mov cx,16d
   print:
   rol bx,1
   jc one
   jnc zero
   next:loop print
   jmp exitt
   one:
   mov ah,02h
   mov dl,'1'
   int 21h
   jmp next
   zero:
   mov ah,02h
   mov dl,'0' 
   int 21h
   jmp next
   

    exitt:
    end main
    main endp