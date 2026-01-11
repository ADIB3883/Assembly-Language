.model small
.stack 100h
.data
    inp     db "Enter n = $"
    delim   db 0dh,0ah,"$"
    n       db ?
    space   db ?
    stn     db ?
.code
main proc
    mov ax,@data
    mov ds,ax

    ; Prompt
    mov ah,09h
    lea dx,inp
    int 21h

    ; Input 1 digit
    mov ah,01h
    int 21h
    sub al,'0'
    mov n,al 
    mov space,al

    ; newline
    mov ah,09h
    lea dx,delim
    int 21h

    ; -------- Top half --------
    mov bl,1        ; row counter
    dec space
    mov ch,1        ; starting bit
outer:
    cmp bl,n
    jg bottom_start

    mov cl,1
space_loop:
    cmp cl,space
    jg row_print
    mov ah,02h
    mov dl,' '
    int 21h
    inc cl
    jmp space_loop

row_print:
    mov cl,1
    mov al,n
    sub al,space
    mov stn,al
print_loop:
    cmp cl,stn
    jg row_done
    mov dl,ch
    add dl,'0'
    mov ah,02h
    int 21h
    inc cl
    xor ch,1
    jmp print_loop

row_done:
    inc bl
    dec space
    mov ah,09h
    lea dx,delim
    int 21h
    jmp outer

; -------- Bottom half --------
bottom_start:
    dec n
    mov space,1
    mov bl,n
outer2:
    cmp bl,1
    jl program_end

    mov cl,1
space_loop2:
    cmp cl,space
    jg row_print2
    mov ah,02h
    mov dl,' '
    int 21h
    inc cl
    jmp space_loop2

row_print2:
    mov cl,1
print2:
    cmp cl,bl
    jg row_done2
    mov dl,ch
    add dl,'0'
    mov ah,02h
    int 21h
    inc cl
    xor ch,1
    jmp print2

row_done2:
    mov ah,09h
    lea dx,delim
    int 21h
    dec bl
    inc space
    jmp outer2

program_end:
    mov ah,4ch
    int 21h
main endp
end main
