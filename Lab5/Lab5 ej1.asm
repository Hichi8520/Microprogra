.MODEL small
.STACK
.DATA
    num1 db ?
    num2 db ?
    cont db 0
    cont2 db 0
    res db ?
    resd db ?
    resta db ?
    numdece db ?
    residuo db ?
    mproducto db 'Producto: $'
    mcociente db 'Cociente: $'
    mresiduo db 'Residuo: $'
.CODE
programa:
    MOV AX,@DATA
    MOV DS,AX
    XOR AX, AX          ; limpiar los registros
    MOV AL,5
    MOV BL,2
    MUL BL ;AL = AL * BL
    MOV numdece, AL ;obtenemos valor 10
    ;leer num1
    XOR AX,AX
    MOv AH, 01h ;queda guardado en AL
    INT 21h
    MOV num1,AL
    SUB num1,30h ;valor real
    ;leer num2 
    XOR AX,AX
    MOV AH, 01h ;queda guardado en AL
    INT 21h
    MOV num2,AL
    SUB num2,30h ;valor real
    ; imprimir un salto de linea antes de mostrar un resultado
    MOV DL, 10
    MOV AH, 02
    INT 21h
    MOV DL, 13
    INT 21H   

    ;proceso multiplicacion
    bucle:
    XOR AX, AX          ; se hace la sumna
    MOV AL,num1
    ADD AL,res
    MOV res, AL 
    XOR AX, AX          ; cont++
    MOV AL,cont
    ADD AL,1
    MOV cont, AL 
    XOR AX, AX          ; resta
    MOV AL,num2
    SUB AL,cont

    ; Guardar los valores en variables antes de imprimir
    MOV resta, AL  
    ;comparar
    CMP resta,0
    JE  imprimirprod
    JMP bucle

    imprimirprod:
    ; Hacer una division
    XOR AX, AX          ; limpiar los registros
    MOV AL, res
    DIV numdece
    ; Guardar los valores en variables antes de imprimir
    MOV resd, al 
    MOV res, ah
    ADD res,30h
    ADD resd,30h
    ;imprimir cadena
    XOR AX, AX
    MOV AH, 09
    LEA DX, mproducto
    INT 21h
    ; Imprimir  decena
    XOR AX, AX
    MOV AH, 02
    MOV DL, resd
    INT 21h
    ; Imprimir unidad
    XOR AX, AX
    MOV AH, 02
    MOV DL, res
    INT 21h

end programa