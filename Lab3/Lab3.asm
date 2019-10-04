.MODEL small
.STACK
.DATA
    num1 DB ?
    num2 DB ?
    
    suma DB ?
    resta DB ?
    mult DB ?
    cociente DB ?
    residuo DB ?
    
    strnum1 DB 'Ingrese el numero 1: $'
    strnum2 DB 'Ingrese el numero 2: $'
    
    Rtotal DB 'Total: $'
    Rdiferencia DB 'Diferencia: $'
    Rproducto DB 'Producto: $'
    Rcociente DB 'Cociente: $'
    Rresiduo DB 'Residuo: $'
    
    rem DB 0
    
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
    
    ;operar suma
    MOV AL, num1
    MOV CL, num2
    ADD AL, CL
    MOV suma, AL
    
    ;operar resta
    MOV AL, num1
    MOV CL, num2
    SUB AL, CL
    MOV CL, 30h
    ADD AL, CL
    MOV resta, AL
    
    ;operar multiplicacion
    MOV AL, num1
    MOV CL, num2
    MUL CL
    MOV mult, AL
    
    ;operar division
    MOV AL, num1
    MOV CL, num2
    DIV CL
    MOV CL, 30h
    ADD AL, CL
    MOV cociente, AL
    ;residuo en ah
    MOV CL, 30h
    ADD AH, CL
    MOV residuo, AH
    
    ;imprimir suma
    MOV DX, Offset Rtotal
    MOV AH, 09h
    INT 21h

    ;limpiar AH para usar como reminder
    MOV AH,00
    ;mover la suma a AL
    MOV AL,suma
    ;bl=10
    MOV BL,10
    ;al/bl --> numero de dos digitos/10 = valor decimal
    DIV BL
    ;mover reminder a rem
    MOV rem,AH
    ;para imprimir (AL) se mueve todo a DL
    MOV DL,AL
    ADD DL,48
    MOV AH,02h
    INT 21h
    ;se imprimer el reminder
    MOV DL,rem
    ADD DL,48
    MOV AH,02h
    INT 21h
    
    ;salto de linea
    MOV DL,10
    MOV AH,02h
    INT 21h
    
    ;imprimir resta
    MOV DX, Offset Rdiferencia
    MOV AH, 09h
    INT 21h
    MOV DL, resta
    MOV AH, 02h
    INT 21h
    
    ;salto de linea
    MOV DL,10
    MOV AH,02h
    INT 21h
    
    ;imprimir multiplicaion
    MOV DX, Offset Rproducto
    MOV AH, 09h
    INT 21h
    MOV DL, mult
    MOV AH, 02h
    INT 21h
    
    ;limpiar AH para usar como reminder
    MOV AH,00
    ;mover la suma a AL
    MOV AL,mult
    ;bl=10
    MOV BL,10
    ;al/bl --> numero de dos digitos/10 = valor decimal
    DIV BL
    ;mover reminder a rem
    MOV rem,AH
    ;para imprimir (AL) se mueve todo a DL
    MOV DL,AL
    ADD DL,48
    MOV AH,02h
    INT 21h
    ;se imprimer el reminder
    MOV DL,rem
    ADD DL,48
    MOV AH,02h
    INT 21h
    
    ;salto de linea
    MOV DL,10
    MOV AH,02h
    INT 21h
    
    ;imprimir cociente
    MOV DX, Offset Rcociente
    MOV AH, 09h
    INT 21h
    MOV DL, cociente
    MOV AH, 02h
    INT 21h
    
    ;salto de linea
    MOV DL,10
    MOV AH,02h
    INT 21h
    
    ;imprimir residuo
    MOV DX, Offset Rresiduo
    MOV AH, 09h
    INT 21h
    MOV DL, residuo
    MOV AH, 02h
    INT 21h

    ;finalizar
    MOV AH, 4Ch
    INT 21h
    
end programa