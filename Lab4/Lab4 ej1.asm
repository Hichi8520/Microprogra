.MODEL small
.STACK
.DATA
    num DB ?
    espar DB 'el numero es par$'
    noespar DB 'el numreo es impar$'
    residuo DB ?

.CODE
programa:
    MOV AX, @DATA
    MOV DS,AX

    ;Leer num
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV num, AL
    SUB num, 30h
    
    ;comparar si es par
    XOR AX, AX
    MOV AL, num
    MOV CL, 2
    DIV CL
    ;residuo en ah
    MOV residuo, AH
    
    ;comparar
    CMP residuo, 0
    JZ imprimirespar
    JNZ imprimiresimpar

    imprimiresimpar:
    MOV DX, Offset noespar
    MOV AH, 09h
    INT 21h
    JMP finalizar

    imprimirespar:
    MOV DX, Offset espar
    MOV AH, 09h
    INT 21h

    finalizar:
    ;finalizar
    MOV AH, 4Ch
    INT 21h
    
end programa