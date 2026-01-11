.model small
.stack 100h
.data
total db 0
arr db 10 dup(10)
crg db 0ah,0dh,'$'
fnd db 'Found$'
nfnd db 'Not Found$'
e_arr db 'Enter the input array : $'
s_arr db 'The Sorted array : $'
var db 0
sr db 0
i dw 0
.code


mov dx,@data
mov ds,dx


mov ah,9h
lea dx,e_arr
int 21h
call newline

mov cx,5h
mov si,0h
arr_in:    call dec_inp
           mov al,total
           mov [arr+si],al
           call newline
           inc si
           loop arr_in

call newline
mov cx,4h
mov si,0h
arr_sort:   mov al,[arr+si]
            mov i,si
            inc i
            mov di,i
            push cx
            mov cx,5d
            sub cx,i
            inner:     mov al,[arr+si]
                       mov bl,[arr+di]
                       cmp al,bl
                       jg swap
                again:
                       inc di
                       loop inner
            
            pop cx
            inc si
            loop arr_sort
            
            
            mov ah,9h
            lea dx,s_arr
            int 21h
            call newline
            
            
            mov cx,5h
            mov si,0h
            arr_output:
             mov al,[arr+si]
             mov total,al
             call dec_outp
             call newline
             inc si
             loop arr_output
             
            mov ah,4ch
            int 21h
            
            swap:   mov [arr+di],al
                    mov [arr+si],bl
                    mov var,al
                    mov al,bl
                    mov bl,var
                    jmp again 

newline proc
                push dx
                mov ah,09h
                lea dx,crg
                int 21h
                pop dx
                ret
newline endp

dec_inp proc

                push bx
                push cx
                mov bx,0h
                mov total,0h
        Lab:    mov ah,1h
                int 21h
                cmp al,0dh
                je lab_end
                sub al,'0'
                mov bl,al
                mov al,10
                mul total
                add al,bl
                mov total,al
                jmp Lab
                
        lab_end:    pop cx
                    pop bx
                    ret
    
dec_inp endp


dec_outp proc
                push bx
                push cx
                push dx
                mov bx,0h
                mov cx,0h
                mov al,total


        lab1:   
                mov bl,10d
                mov ah,0h
                div bl
                mov dl,ah
                mov dh,0h
                push dx
                inc cx
                cmp al,0
                je lab1_end
                jmp lab1

        lab1_end:  pop dx
                   add dl,'0'
                   mov ah,2h
                   int 21h
                   loop lab1_end
        
        pop dx
        pop cx
        pop bx
        ret

dec_outp endp