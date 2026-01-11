.model small
.stack 100h
.data
total db 0
arr db 10 dup(10)
crg db 0ah,0dh,'$'
fnd db 'Found$'
nfnd db 'Not Found$'
e_arr db 'Enter the sorted array : $'
e_fnd db 'Enter the Searched element : $'
var db 0
sr db 0
i db 0
.code
main proc


mov dx,@data
mov ds,dx

mov ah,9h
lea dx,e_arr
int 21h
call newline

mov cx,5d
mov si,0h
arr_in:    call dec_inp
           mov al,total
           mov [arr+si],al
           call newline
           inc si
           loop arr_in
mov cx,5d
mov si,0h

; arr_output:
;              mov al,[arr+si]
;              mov total,al
;              call dec_outp
;              call newline
;              inc si
;              loop arr_output

mov ah,9h
lea dx,e_fnd
int 21h
call newline
call dec_inp
mov al,total
mov sr,al
mov si,0h
mov di,5h
mov bh,0h
arr_bs:    xor bx,bx
           mov ax,si
           add ax,di
           mov var,2h
           div var
           mov bl,al
           mov al,[arr+bx]
           cmp sr,al
           je found
           jg up_si
           jl up_di
       rt: cmp si,di
           jg bs_end
           jmp arr_bs
    
    up_si:  inc bx
            mov si,bx
            ;inc si
            jmp rt
            
    up_di:  dec bx
            mov di,bx
            ;dec di
            jmp rt
    
    found:  call newline
            mov ah,9h
            lea dx,fnd
            int 21h
            mov ah,4ch
            int 21h

bs_end:     call newline
            mov ah,9h
            lea dx,nfnd
            int 21h
            mov ah,4ch
            int 21h

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

                
                
