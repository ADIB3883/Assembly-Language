.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX          ; Initialize data segment
    MOV CX,1
    PRINT:
    MOV BX,1
    PR:
    MOV AH,2
    MOV DX,02AH
    INT 21H
    INC BX
    CMP BX,3d
    JLE PR 
     MOV AH,2
    MOV DL,0AH         ; Line Feed
    INT 21H
    MOV DL,0DH         ; Carriage Return
    INT 21H
    INC CX
    CMP CX,3
    JLE PRINT
    
    ; Exit program
    MOV AX,4C00H
    INT 21H

MAIN ENDP
END MAIN
