;TAKE AN N SIZE ARRAY AS INPUT. THE VALUE OF N CAN BE AT MOST 10.
;EACH OF THE ARRAY ELEMENTS ARE 99 MAXIMUM. 
;NOW, IF THERE ARE MORE ODD ELEMENTS THAN EVEN ELEMENTS, IT IS AN ODD ARRAY
;ELSE IT IS AN EVEN ARRAY 



.MODEL SMALL
.STACK 100H
.DATA 

    ARR DB 10 DUP(0)
    TOTAL DB 0                                
    COUNT DB 0
    M1 DB 'ENTER THE SIZE OF THE ARRAY: $'
    SIZE DB ?
    ODD_TOTAL DB 0
    EVEN_TOTAL DB 0
    ODD DB 'THIS IS AN ODD ARRAY$'
    EVEN DB 'THIS IS AN EVEN ARRAY$'

.CODE

MAIN PROC

    MOV AX,@DATA
    MOV DS,AX 
    
    CALL INP_ARRAY
    CALL COUNTER
    
    MOV BL,ODD_TOTAL
    CMP BL,EVEN_TOTAL
    JG PRINT_ODD
    
        MOV AH,9
        LEA DX,EVEN
        INT 21H
        JMP FIN_EXIT 
        
    PRINT_ODD:
        MOV AH,9
        LEA DX,ODD
        INT 21H
        JMP FIN_EXIT

MAIN ENDP



;FUNCTION TO PRINT NEWLINE
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



;FUNCTION FOR DECIMAL INPUT
DEC_INP PROC 
       PUSH BX
       PUSH AX  
       
       MOV BX,0
       MOV TOTAL,0
       MOV AH,1
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
       
       POP AX
       POP BX
       RET    
DEC_INP ENDP
  
  
  
; ARRAY INPUT FUNCTION
INP_ARRAY PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV AH,9
    LEA DX,M1
    INT 21H      
    MOV AH,1
    INT 21H
    SUB AL,'0'
    MOV SIZE,AL
    CALL NEW_LINE
    MOV BX,OFFSET ARR
    MOV SI,0
    MOV CL,SIZE
    MOV CH,0
    L1:    
        CALL DEC_INP
        MOV DL,TOTAL
        MOV DH,0
        MOV [BX+SI],DL
        INC SI
        CALL NEW_LINE
    LOOP L1
    
    POP DX
    POP CX
    POP BX
    POP AX
RET    
INP_ARRAY ENDP
    
    
;ODD_EVEN COUNTER FUNCION    
COUNTER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    MOV BX,OFFSET ARR
    MOV SI,0
    LABEL: 
        MOV DL,[BX+SI]
        TEST DL,1
        JZ E_INC 
        
        INC ODD_TOTAL
        JMP FINN
        
        E_INC:
            INC EVEN_TOTAL
        
        FINN: 
        
        INC SI           ; CANNOT DO INC SI --> CMP SI,SIZE.  SINCE SI IS 16 BIT, AND SIZE IS 8 BIT 
        MOV DX,SI
        MOV DH,0
        CMP DL,SIZE
    JL LABEL
        
    POP DX
    POP CX
    POP BX
    POP AX
RET
COUNTER ENDP


FIN_EXIT:

END MAIN
    
