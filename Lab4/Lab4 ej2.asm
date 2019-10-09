.MODEL small
.STACK
.DATA
    num1 DB ?
    num2 DB ?
    strnum1 DB 'Ingrese el numero 1: $'
    strnum2 DB 'Ingrese el numero 2: $'
    iguales DB 'Los numeros son iguales$'
    amayorb DB 'Num1 > Num2$'
    amenorb DB 'Num1 < Num2$'
    resultado DB ?

.CODE
programa:
    MOV AX, @DATA
    MOV DS,AX

    ;Leer num1
    MOV DX, Offset strnum1
    MOV AH, 09h
    INT 21h
    
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV num1, AL
    SUB num1, 30h
    
    ;salto de linea
    MOV DL,10
    MOV AH,02h
    INT 21h
    
    ;Leer num2
    MOV DX, Offset strnum2
    MOV AH, 09h
    INT 21h
    
    XOR AX, AX
    MOV AH, 01h
    INT 21h
    MOV num2, AL
    SUB num2, 30h
    
    ;salto de linea
    MOV DL,10
    MOV AH,02h
    INT 21h
    
    ;operar resta
    MOV AL, num1
    SUB AL, num2
    MOV resultado, AL
    
    ;comparar
    CMP resultado, 0
    JZ soniguales
    JG primeromayor
    
    JL primeromenor

    soniguales:
    MOV DX, Offset iguales
    MOV AH, 09h
    INT 21h
    JMP finalizar

    primeromayor:
    MOV DX, Offset amayorb
    MOV AH, 09h
    INT 21h
    JMP finalizar

    primeromenor:
    MOV DX, Offset amenorb
    MOV AH, 09h
    INT 21h
    
    finalizar:
    ;finalizar
    MOV AH, 4Ch
    INT 21h
    
end programa