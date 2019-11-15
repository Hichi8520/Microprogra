.386
.model flat, stdcall
option casemap:none
 ; Includes
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\masm32rt.inc 
; librerias
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

;segemento de datos
.DATA
mensaje1 DB "Ingresar un numero: ",0
mensaje2 DB "El factorial es: ",0
num DB ?, 0
res DB ?, 0
unidad DB ?, 0
decena DB ?, 0
centena DB ?, 0
div100 DB 100d, 0
div10 DB 10d, 0
.CODE
programa2:
	INVOKE StdOut, addr mensaje1	; imprimir cadena
	INVOKE StdIn, addr num,16	; leer numero
	SUB num,30h
	CMP num,0
	JE FactorialCero ; si ingresa un cero
	JMP Factorial

	Factorial:
	MOV AL,num
	MOV res,AL
	SUB num,AL
	ADD num,1h
	ciclo:
	XOR AX,AX
	MOV AL,num
	MOV BL,res
	MUL BL
	MOV num, AL ; guarda el resultado
	SUB res,1h
	CMP res,0
	JE Imprimir
	JMP ciclo

	Imprimir:
	XOR AX,AX
	MOV AL,num
	DIV div100
	MOV decena,AH
	MOV centena,AL
	XOR AX,AX
	MOV AL,decena
	DIV div10
	MOV unidad,AH
	MOV decena,AL
	ADD unidad,30h
	ADD decena,30h
	ADD centena,30h
	INVOKE StdOut, addr mensaje2
	INVOKE StdOut, addr centena
	INVOKE StdOut, addr decena
	INVOKE StdOut, addr unidad
	JMP Finalizar


	FactorialCero:
	; imprimir cadena
	INVOKE StdOut, addr mensaje2
	ADD num,31h ; se imprime el numero 1
	INVOKE StdOut, addr num


	Finalizar:
	; finalizar
	INVOKE ExitProcess,0

END programa2