.MODEL SMALL
.STACK 100H
.DATA
    mssg db "Negative input detected,making absolute.$"
    var db ?
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DX,AX
    
    MOV AH,1
    INT 21H
    
    MOV VAR,AL
    CMP AX,0
    JGE COMMON
    NEG AX
    LEA DX,mssg
    MOV AH,9
    INT 21H
    JMP COMMON
    COMMON:
    MOV DL,VAR
    MOV AH,2
    INT 21H
  MAIN ENDP
END MAIN
