.MODEL small

.DATA
num DW ?
un DB ?
de DB ?
ce DB ?
unmi DB ?
demi DB ?
strnum DB 'Ingrese el numero: $'
strnuminv DB 'El numero invertido es: $'
strcero DB 'ERROR no se ingreso un numero$'

numinv DW 0
residuo DW ?
;cociente DW ?

.STACK
.CODE
Programa: ; etiqueta de inicio de programa
; inicializar programa
MOV AX, @Data ; guardando direccion de inicio de segmento de datos
MOV DS, AX


leernumero:
    MOV DX,Offset strnum
    MOV AH,09h
    INT 21h
    
    ;leer unidad
    XOR AX,AX
    MOV AH,01h
    INT 21h
    CMP AL,0Dh ;compara si se presiono enter
    JZ errorcero
    MOV demi,AL
    SUB demi,30h
    
    ;leer decena
    XOR AX,AX
    MOV AH,01h
    INT 21h
    CMP AL,0Dh ;compara si se presiono enter
    JZ unificarnumero
    MOV unmi,AL
    SUB unmi,30h
    
    ;leer centena
    XOR AX,AX
    MOV AH,01h
    INT 21h
    CMP AL,0Dh ;compara si se presiono enter
    JZ unificarnumero
    MOV ce,AL
    SUB ce,30h
    
    ;leer unidad de millar
    XOR AX,AX
    MOV AH,01h
    INT 21h
    CMP AL,0Dh ;compara si se presiono enter
    JZ unificarnumero
    MOV de,AL
    SUB de,30h
    
    ;leer decena de millar
    XOR AX,AX
    MOV AH,01h
    INT 21h
    CMP AL,0Dh ;compara si se presiono enter
    JZ unificarnumero
    MOV un,AL
    SUB un,30h
    JMP unificarnumero
    
errorcero:
    MOV DX,Offset strcero
    MOV AH,09h
    INT 21h
    
    ;salto de linea
    MOV DL,10
    MOV AH,02h
    INT 21h  
    JMP leernumero
    
unificarnumero:
    ;decena de millar
    XOR AX,AX
    MOV AL,demi
    MOV BX,10000d
    MUL BX
    MOV num,AX
    
    ;unidad de millar
    XOR AX,AX
    MOV AL,unmi
    MOV BX,1000d
    MUL BX
    ADD num,AX
    
    ;centena
    XOR AX,AX
    XOR BX,BX
    MOV AL,ce
    MOV BL,100d
    MUL BL
    ADD num,AX
    
    ;decena
    XOR AX,AX
    XOR BX,BX
    MOV AL,de
    MOV BL,10d
    MUL BL
    ADD num,AX
    
    ;unidad
    XOR AX,AX
    MOV AL,un
    ADD num,AX
    
    ;salto de linea
    MOV DL,10
    MOV AH,02h
    INT 21h  
    
    
invertirnumero:
    MOV DX,Offset strnuminv
    MOV AH,09h
    INT 21h

ciclo:
    ;se divide el numero entre 10
    XOR AX,AX
    XOR DX,DX
    XOR BX,BX
    MOV AX,num
    MOV BL,10
    DIV BX
    ADD DL,30h
    MOV residuo,DX
    MOV num,AX
    
    MOV AH, 02h
    INT 21h
    
    ;multiplicar por 10 el numero invertido
    ;XOR BX,BX
    ;MOV AX,numinv
    ;MOV BL,10
    ;MUL BX
    ;ADD AX,residuo ;sumar al resultado de la multiplicacion (AX) el residuo
    
    CMP num,0
    JZ finalizar ;si el cociente llega a ser cero
    JMP ciclo ;sino se continua el ciclo
    
imprimirnumero:
    MOV AX,num
    AAM
    MOV BX,AX
    MOV AH,02h
    MOV DL,BH
    ADD DL,30h
    INT 21h
    
    MOV AH,02h
    MOV DL,BL
    ADD DL,30h
    INT 21h
    
finalizar:
MOV AH, 4Ch ; finalizar proceso
INT 21h     ; ejecuta interrupcion
END Programa