.MODEL SMALL
.STACK 100H
.DATA
    str db "Enter N: $"
    N dw ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ; PROMPT USER
    MOV AH,9
    LEA DX,str
    INT 21H 
    
    ; INPUT ONE DIGIT
    MOV AH,1
    INT 21H
    
    SUB AL,'0'        ; Convert ASCII to number
    MOV AH,0
    MOV N,AX          ; Store N
    
    ; Newline
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    
    ; OUTER LOOP (rows)
    MOV CX,N
PRINT_LOOP:
    MOV BX,CX         ; BX = current row max
    
NEXT_CHAR:
    MOV DL,'0'
    ADD DL,BL         ; DL = ASCII of BL
    MOV AH,2
    INT 21H
    DEC BL
    JNZ NEXT_CHAR     ; Print until BL=0
    
    ; Newline after row
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    
    LOOP PRINT_LOOP
    
    ; Exit
    MOV AX,4C00H
    INT 21H
    
MAIN ENDP
END MAIN
