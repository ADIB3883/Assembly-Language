;TAKE MULTI-DIGIT NUMERIC INPUT OF ARRAY A  AND ARRAY B
;A[i]+B[i] AND STORE RESULT IN NEW ARRAY C[i]
;PRINT RESULTANT C ARRAY     

;CONSTRAINTS: ARRAYS A,B,C ARE DATA BYTES, ASSUME SIZE OF ARRAYS ARE 10

.MODEL SMALL
.STACK 100H
.DATA 
    ARR DB 10 DUP(0)
    BRR DB 10 DUP(0)
    CRR DB 10 DUP(0)
    TOTAL DB 0
    COUNT   DB 0
    MSG1   DB "ENTER ARR ELEMENT: $",0  
    MSG2   DB "ENTER BRR ELEMENT: $",0
    MSG3   DB "SUM OF ARR AND BRR GIVES CRR ELEMENTS: $",0
    INP1   DB 0 
    INP2    DB 0

.CODE

MAIN PROC

    MOV AX,@DATA
    MOV DS,AX                                                                                                    
    
    MOV AH,09H
    LEA DX,MSG1
    INT 21H
    CALL NEW_LINE
    
    MOV BX,OFFSET ARR
    MOV SI,0
    
    LL2: 
    CALL DEC_INP
    MOV DL,TOTAL
    MOV [BX+SI],DL
    CALL NEW_LINE
    INC SI
    CMP SI,10
    JL LL2  
    
    ;-----------ARR INPUT ENDS HERE
    
    MOV AH,09H
    LEA DX,MSG2
    INT 21H
    CALL NEW_LINE
    
    MOV BX,OFFSET BRR
    MOV SI,0
    
    LL3: 
    CALL DEC_INP
    MOV DL,TOTAL
    MOV [BX+SI],DL
    CALL NEW_LINE
    INC SI
    CMP SI,10
    JL LL3  
    
    ;---------------BRR INPUT ENDS HERE
    
    
    MOV AH,09H
    LEA DX,MSG3
    INT 21H
    CALL NEW_LINE
    
    
    MOV BP,OFFSET CRR
    TRY:      
    MOV SI,0
    LL:
    
    MOV BX,OFFSET ARR
    MOV DL,[BX+SI]
    MOV INP1,DL  
    
    MOV BX,OFFSET BRR
    MOV DL,[BX+SI]
    MOV INP2,DL
    
    MOV AL,INP1
    ADD AL,INP2
    
    MOV [BP+SI],AL
    
    MOV TOTAL,AL
    
    CALL DEC_OUT
    CALL NEW_LINE
    
    INC SI
    CMP SI,10
    JL LL


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


;FUNCTION FOR DECIMAL OUTPUT
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


;FUNCTION FOR DECIMAL INPUT

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
    


