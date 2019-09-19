.MODEL small

.DATA
; variable que contiene el texto que queremos mostrar
cadena1 DB 'Luis Roberto Roldan Guzman $' ; $ significa el final de la cadena
cadena2 DB '1071317 $'
cadena3 DB 'El simbolo escogido es: $'

.STACK
.CODE

Programa: ; etiqueta de inicio de programa
; inicializar programa
MOV AX, @Data ; guardando direccion de inicio de segmento de datos
MOV DS, AX

; imprimir cadena1
MOV DX, 0000H
MOV DX, OFFSET cadena1 ; asignando a DX la variable cadena
MOV AH, 09h 	      ; decimos que se imprimirá una cadena
INT 21h		      ; ejecuta la interrupcion, imprimirá

; imprimir cadena2
MOV DX, 0000H
MOV DX, OFFSET cadena2 ; asignando a DX la variable cadena
MOV AH, 09h 	      ; decimos que se imprimirá una cadena
INT 21h		      ; ejecuta la interrupcion, imprimirá

; imprimir cadena3
MOV DX, 0000H
MOV DX, OFFSET cadena3 ; asignando a DX la variable cadena
MOV AH, 09h 	      ; decimos que se imprimirá una cadena
INT 21h		      ; ejecuta la interrupcion, imprimirá

Mov AX,@DATA
Mov DS,AX
Mov AX,0000h
Mov AL,26h
Mov DL,AL
Mov AH,02
Int 21h

; finalizar programa
MOV AH, 4Ch ; finalizar proceso
INT 21h	    ; ejecuta interrupcion
END Programa