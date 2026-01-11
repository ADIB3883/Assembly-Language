.MODEL SMALL
.STACK 100H

.DATA
    mssg db "Enter the value of X: $"
    mssg_num db "Given input is a number.$"
    mssg_vowel db "Given input is a vowel.$"
    mssg_conso db "Given input is a consonent.$"
    mssg_invalid db "Invalid input.$"
    mssg_repeat db "Do you want to give another input?(Y/N):$"
    vowelList db "AEIOU$"
 
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
REPEAT_INPUT:
    ;ENTER VALUE MSSG
    LEA DX,mssg
    MOV AH,9
    INT 21H
    ;VALUE SCAN
    MOV AH,1
    INT 21H
    MOV BL,AL
    ;NL,CR
    MOV DL,0AH
    MOV AH,2
    INT 21H
    MOV DL,0DH
    MOV AH,2
    INT 21H
    
    ;CHECK IF DIGIT
    ; IF BELOW 0 
    CMP BL,'0'
    JB CHECK
    ; IF ABOVE 9
    CMP BL,'9'
    JA CHECK
    ;IF BETWEEN -0 TO 9
    LEA DX,mssg_num
    MOV AH,9
    INT 21H
    JMP ASK_REPEAT
    
CHECK:
    ;CHECK IF A-Z
    ;IF BELOW A  
    CMP BL,'A'
    JB INVALID 
    ;IF ABOVE Z
    CMP BL,'Z'
    JA INVALID
    ;CHECK IF VOWEL
    LEA SI,vowelList
    
CHECK_VOWEL:
    MOV AL,[SI]
    INC SI
    CMP AL,'$'
    JE NOT_VOWEL
    CMP BL,AL
    JE IS_VOWEL
    JMP CHECK_VOWEL
    
IS_VOWEL:
    LEA DX,mssg_vowel
    MOV AH,9
    INT 21H
    JMP ASK_REPEAT
    
NOT_VOWEL:
    LEA DX,mssg_conso
    MOV AH,9
    INT 21H
    JMP ASK_REPEAT
    
INVALID:
    LEA DX,mssg_invalid
    MOV AH,9
    INT 21H
    
ASK_REPEAT:
    ;NL+CR
    MOV DL,0AH
    MOV AH,2
    INT 21H
    MOV DL,0DH
    MOV AH,2
    INT 21H
    
    LEA DX,mssg_repeat
    MOV AH,9
    INT 21H
    
    ;take Y/N
    MOV AH,1
    INT 21H
    CMP AL,'Y'
    JE NEWLINE_REPEAT
    CMP AL,'N'
    JE EXIT
    
NEWLINE_REPEAT:
    ;NL+CR 
    MOV DL,0AH
    MOV AH,2
    INT 21H
    MOV DL,0DH
    MOV AH,2
    INT 21H
    JMP REPEAT_INPUT
    
EXIT:
    MOV AH,4CH
    INT 21H
           
   MAIN ENDP
  END MAIN