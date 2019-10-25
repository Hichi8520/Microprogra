.MODEL small

.DATA
; variable que contiene el texto que queremos mostrar
cadena1 DB 'X$' ; $ significa el final de la cadena

.STACK
.CODE

Programa: ; etiqueta de inicio de programa
; inicializar programa
MOV AX, @Data ; guardando direccion de inicio de segmento de datos
MOV DS, AX	

imprimir:
MOV DX, 0000H
MOV DX, OFFSET cadena1 ; asignando a DX la variable cadena
MOV AH, 09h 	      ; decimos que se imprimirá una cadena
INT 21h		      ; ejecuta la interrupcion, imprimirá

XOR AX,AX
MOV AH,01h
INT 21h
CMP AL,0Dh
JNZ imprimir

MOV AH, 4Ch ; finalizar proceso
INT 21h	    ; ejecuta interrupcion
END Programa