.model small
.stack 100h
.data
total db 0
arr db 10 dup(10)
frq db 10 dup(0)
crg db 0ah,0dh,'$'
fnd db 'Found$'
nfnd db 'Not Found$'
e_arr db 'Enter the input array : $'
s_arr db 'The Sorted array : $'
arw   db ' ---> $'
var db 0
sr db 0
i db 0
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
mov cx,5h
mov si,0h

freq_cnt:   mov al,[arr+si]
            mov bl,al
            mov bh,0h
            mov al,[frq+bx]
            inc al
            mov [frq+bx],al
            inc si
            loop freq_cnt         
            
            
            
            
            call newline
            mov cx,10d
            mov si,0h
            mov i,0h
            
arr_output:
             mov al,[frq+si]
             cmp al,0
             je baad
             mov bl,i
             mov total,bl
             mov bl,al
             call dec_outp
             call arw_print
             mov total,bl
             call dec_outp
             call newline
             baad:
             inc si
             inc i
             loop arr_output
             
            mov ah,4ch
            int 21h
            


arw_print proc
               push ax
               mov ah,9h
               lea dx,arw
               int 21h
               pop ax
               ret
arw_print endp

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