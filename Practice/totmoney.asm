;Enter decimal input for the amount of each of the notes
;Multiply those values with the note value and find the total money

.model small
.stack 100h

.data
    total dw 0    
    input dw 0   

    msg1 db 0Ah, 0Dh, 'Enter number of 1000 taka notes: $'
    msg2 db 0Ah, 0Dh, 'Enter number of 500 taka notes: $'
    msg3 db 0Ah, 0Dh, 'Enter number of 200 taka notes: $'
    msg4 db 0Ah, 0Dh, 'Enter number of 100 taka notes: $'
    msg5 db 0Ah, 0Dh, 'Enter number of 50 taka notes: $'
    msg6 db 0Ah, 0Dh, 'Enter number of 20 taka notes: $'
    msg7 db 0Ah, 0Dh, 'Enter number of 10 taka notes: $'
    msg8 db 0Ah, 0Dh, 'Enter number of 2 taka notes: $'
    msg9 db 0Ah, 0Dh, 'Enter number of 50 paisa coins: $'
    msg10 db 0Ah, 0Dh, 'Enter number of 25 paisa coins: $'

    final_msg db 0Ah, 0Dh, 'Total Money: $'

.code

MAIN PROC
    mov ax, @data
    mov ds, ax

    lea dx, msg1
    call print_str
    call deci
    mov ax, input
    mov bx, 1000
    mul bx
    add total, ax


    lea dx, msg2
    call print_str
    call deci
    mov ax, input
    mov bx, 500
    mul bx
    add total, ax


    lea dx, msg3
    call print_str
    call deci
    mov ax, input
    mov bx, 200
    mul bx
    add total, ax


    lea dx, msg4
    call print_str
    call deci
    mov ax, input
    mov bx, 100
    mul bx
    add total, ax


    lea dx, msg5
    call print_str
    call deci
    mov ax, input
    mov bx, 50
    mul bx
    add total, ax


    lea dx, msg6
    call print_str
    call deci
    mov ax, input
    mov bx, 20
    mul bx
    add total, ax


    lea dx, msg7
    call print_str
    call deci
    mov ax, input
    mov bx, 10
    mul bx
    add total, ax


    lea dx, msg8
    call print_str
    call deci
    mov ax, input
    mov bx, 2
    mul bx
    add total, ax

 
    lea dx, msg9
    call print_str
    call deci
    mov ax, input
    shr ax, 1    
    add total, ax


    lea dx, msg10
    call print_str
    call deci
    mov ax, input
    shr ax, 2  
    add total, ax


    lea dx, final_msg
    call print_str
    call newline
    call output

    ; Exit
    mov ah, 4Ch
    int 21h
MAIN ENDP


deci proc
    mov ax, 0          
    mov input, ax       

    mov ah, 01h
    int 21h             

repeat:
    cmp al, 0Dh         
    je done

    sub al, '0'        
    cbw                 
    mov bx, ax          

    mov ax, input     
    mov cx, 10
    mul cx               
    add ax, bx          
    mov input, ax       

    mov ah, 01h
    int 21h
    jmp repeat

done:
    ret
deci ENDP


output proc
    mov ax, total     
    mov bx, 10           
    xor cx, cx           

convert_loop:
    xor dx, dx         
    div bx               
    push dx             
    inc cx      
    cmp ax, 0
    jne convert_loop

print_digits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_digits

    ret
output ENDP

print_str proc
    mov ah, 09h
    int 21h
    ret
print_str ENDP


newline proc
    mov ah, 02h
    mov dl, 0Ah
    int 21h
    mov dl, 0Dh
    int 21h
    ret
newline ENDP

END MAIN
