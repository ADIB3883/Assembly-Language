.MODEL SMALL 
.STACK 100H
.DATA 
    
.CODE

MAIN PROC
        
    MOV AX, @DATA
    MOV DS, AX 
             
             
    MOV BX,0
    MOV CL,0DH
    
    MOV AH, 1
    INT 21H 
    
    BIN_INPUT:
        SUB AL, '0'
        
        SHL BX, 1  
        OR BL, AL
        
        
        MOV AH, 1
        INT 21H 
        
        CMP AL, CL
        JNE BIN_INPUT
    
    MOV CX, 16D    
    BIN_OUTPUT:
        
        ROL BX, 1
        JC PRINT_ONE
        JNC PRINT_ZERO
        BACK: 
        LOOP BIN_OUTPUT
        
    JMP EXIT   
        
    PRINT_ONE:
        MOV AH, 2
        MOV DX, '1'
        INT 21H
        JMP BACK
        
    PRINT_ZERO:
        MOV AH, 2
        MOV DX, '0'
        INT 21H
        JMP BACK
            
    EXIT: 
    MAIN ENDP
END MAIN