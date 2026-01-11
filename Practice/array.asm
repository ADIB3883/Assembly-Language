;PREDETERMINED SIZE ARRAY INPUT OUTPUT
.MODEL SMALL
.STACK 100H
.DATA 

    ARR DB 10 DUP(0)
    TOTAL DB 0
    COUNT DB 0

.CODE

MAIN PROC

    MOV AX,@DATA
    MOV DS,AX 
    
    ;ENTER ARRAY ELEMENTS
    
    MOV BX,OFFSET ARR
    MOV SI,0
    
    
    MOV CX,10 ; ASSUMING 10 ELEMENTS
    LL:
        CALL DEC_INP
        MOV DX,0
        MOV DL,TOTAL
        MOV [BX+SI],DX
        ADD SI,1
        CALL NEW_LINE
    LOOP LL
    
    
    
    ;PRINTING ARRAY ELEMENTS
    
    MOV BX,OFFSET ARR
    MOV SI,0 
    MOV CX,10 ; ASSUMING 10 ELEMENTS
    
    LL1:  
        MOV DL,[BX+SI]
        MOV TOTAL,DL
        CALL DEC_OUT
        ADD SI,1
        CALL NEW_LINE
        LOOP LL1
    
    
    JMP FIN_EXIT
    
MAIN ENDP





NEW_LINE PROC 
    PUSH DX
    MOV DX,0AH
    MOV AH,02H
    INT 21H
    MOV DX,0DH
    INT 21H
    POP DX
    RET
    
    NEW_LINE ENDP


DEC_OUT PROC
    PUSH BX 
    PUSH CX
    PUSH DX
    MOV COUNT,0
    MOV DX,0
    MOV AX,0
    MOV AL,TOTAL
    
    LAB2:
        MOV BL,10
        MOV AH,0
        DIV BL
        
        MOV DL,AH
        PUSH DX
        INC COUNT
        
        CMP AL,0
        JNE LAB2
        
        
        MOV CX,0
        MOV DX,0
        MOV CL,COUNT
        
        L:
            POP DX
            ADD DL,'0'
            MOV AH,02H
            INT 21H
            LOOP L
            
        
        POP DX
        POP CX
        POP BX
        RET
    
    DEC_OUT ENDP



DEC_INP PROC 
       PUSH BX
       MOV BX,0
       MOV TOTAL,0
       MOV AH,01
       INT 21H
       
       LAB:
            CMP AL,0DH
            JE EXIT
            SUB AL,'0'
            MOV BL,AL
            MOV AL,10
            MUL TOTAL
            ADD AL,BL
            MOV TOTAL,AL
            
            
            MOV AH,01H
            INT 21H
            JMP LAB
            
       EXIT: 
       
       POP BX
       RET
    
    DEC_INP ENDP

FIN_EXIT:

END MAIN
    
