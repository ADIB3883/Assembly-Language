.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX          ; Initialize data segment

    MOV DL,'A'         ; Start from ASCII 'A'
    MOV CX,26          ; 26 letters

PRINT_LOOP:
    MOV AH,2           ; DOS function: print character
    INT 21H
    INC DL             ; Move to next letter
    LOOP PRINT_LOOP

    ; Exit program
    MOV AX,4C00H
    INT 21H

MAIN ENDP
END MAIN
