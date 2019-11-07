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
; Segmento de Datos
.DATA  
texto1 DB "Ingrese el primer numero: ",0
texto2 DB "Ingrese el segundo numero: ",0
texto3 DB "Suma: ",0
texto4 DB "Resta: ",0
amayorb DB " Num1 > Num2",0
bmayora DB " Num1 < Num2",0
iguales DB " Son iguales",0

num DB 0,0
.DATA?
num1 DB ?
num2 DB ?
suma DB ?
resta DB ?
; codigo
.CODE 
 
programa:
main PROC
	; imprimir cadena 1
	INVOKE StdOut, addr texto1
	; leer numero 1
	INVOKE StdIn, addr num1,16

	; imprimir cadena 2
	INVOKE StdOut, addr texto2
	; leer numero 2
	INVOKE StdIn, addr num2,16

	; Proceso suma
	MOV al, num1
	MOV bl, num2
	ADD al, bl
	MOV suma, al
	SUB suma, 30h
	INVOKE StdOut, addr texto3
	INVOKE StdOut, addr suma

	; Proceso resta
	MOV al, num1
	MOV bl, num2
	SUB al, bl
	MOV resta, al
	ADD resta, 30h
	INVOKE StdOut, addr texto4
	INVOKE StdOut, addr resta
	
	; Proceso mayor igual
	MOV al, num1
	MOV bl, num2
	CMP al,bl
	JA primeromayor
	JB primeromenor
	JE soniguales
	

soniguales:
	INVOKE StdOut, addr iguales
	JMP finalizar

primeromayor:
	INVOKE StdOut, addr amayorb
	JMP finalizar

primeromenor:
	INVOKE StdOut, addr bmayora

finalizar:
	INVOKE ExitProcess,0
	main ENDP
END programa