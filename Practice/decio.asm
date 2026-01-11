;DECIMAL INPUT OUTPUT
.model small
.stack 100h
.data 

    ans     dw 0 
    digit   dw 0 
    ten     dw 10 
    delim   db 0dh,0ah,"$"

.code 
main proc 
input:  
    mov dx , @data
    mov ds , dx
    
    mov ah , 01h 
    int 21h
    cmp al , 0dh
    je ending 
    
    sub al , '0'
    mov ah , 0 
    mov bx , ax
    
    mov ax , ans
    mov cx , 10
    mul cx 
    
    add ax , bx
    mov ans , ax 
    inc digit
    jmp input  
    
    
ending: 

    mov ah , 09h
    lea dx , delim
    int 21h
    
    mov cx , 1
move:
    cmp cx , digit
    jg  label1
    
    mov dx , 0
    mov ax , ans
    div ten
    push dx
    mov ans ,ax
    
    inc cx 
    jmp move
    
    
label1: 
    mov cx , 1
print:
    cmp cx , digit
    jg  label2
    
    mov ah , 02h
    pop dx 
    add dx , '0'
    int 21h
    
    inc cx
    jmp print
label2:     
      
    main endp
end main