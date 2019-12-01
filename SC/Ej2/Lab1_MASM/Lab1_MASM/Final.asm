
.686                                      ; Enable 80686+ instruction set
.model flat, stdcall                ; Flat, 32-bit memory model (not used in 64-bit)
option casemap: none         ; Case sensitive syntax

; Includes
include \masm32\include\masm32.inc
include Irvine32.inc

; librerias
includelib \masm32\lib\masm32.lib

RGB macro red,green,blue
	xor eax,eax
	mov ah,blue
	shl eax,0
	mov ah,green
	mov al,red
endm

.data

openError DB "Error	Creando archvio", 0
fileName DB "C:\Users\hichi\Documents\prueba.txt", 0
errorCaption DB "Error", 0
successCaption DB "Éxito", 0
errorRead DB "Unable to Read from File", 0
msgPalabra DB "Ingrese la/s palabra/s a buscar: ", 0
space DD " ", 0

.data?

fhandle DD ?
bytesRead DD ?
bytesBuffer BYTE 500 DUP(?)
buffPalabra DB 100 DUP(?)

temp1 DD ?
temp2 DD ?
posicion1 DD ?
posicion2 DD ?

.const

.code



start:

     ; CreateFile Function, Fails if no FIle Exists
     Push 0
     Push FILE_ATTRIBUTE_NORMAL
     Push OPEN_EXISTING
     Push 0
     Push 0
     Push GENERIC_READ
     Push Offset fileName
     Call CreateFile

     Mov fhandle, Eax
     Cmp Eax, 0FFFFFFFFh

     Jnz file_opened

     ; If Error Previous Jump Ignored and Now We Declare Error With a MessageBox
     Push MB_OK
     Push Offset errorCaption
     Push Offset openError
     Push 0
     Call MessageBox

     Jmp end_

file_opened:

     ; Read from file
     Push 0
     Lea Eax, bytesRead
     Push Eax
     Push SIZEOF bytesBuffer
     Lea Eax, bytesBuffer
     Push Eax
     Push fhandle
     Call ReadFile

     Cmp bytesRead, 0
     Jnz bytes_have_been_read

     ; Error Reading from File
     Push MB_OK
     Push Offset errorCaption
     Push Offset errorRead
     Push 0
     Call MessageBox

     Jmp buscar_palabra

bytes_have_been_read:

     Push MB_OK
     Push Offset successCaption
     Push Offset bytesBuffer
     Push 0
     Call MessageBox

     ; Close file
     Push fhandle
     Call CloseHandle


buscar_palabra:

	;RGB 100,200,200
	;MOV EAX,200
	;CALL SetTextColor
	INVOKE StdOut, addr msgPalabra
	INVOKE StdIn, addr buffPalabra,100

	;INVOKE StdOut, addr bytesBuffer

	MOV ECX,500
	LEA EDI,bytesBuffer
	LEA ESI,buffPalabra

L1:
	MOVZX EAX, BYTE PTR [EDI]
	MOV temp1, EAX

	MOVZX EAX, BYTE PTR [ESI]
	MOV temp2, EAX

	CMP temp1,EAX ;si la primer letra es igual
	JZ comparar_palabras


	MOV EDX,OFFSET temp1
	CALL WriteString
	INC EDI
	LOOP L1

comparar_palabras:
	MOV posicion1,EDI
	MOV posicion2,ESI

	ciclo_comparar:
	MOVZX EAX, BYTE PTR [ESI]
	MOV temp2, EAX

	MOVZX EAX, BYTE PTR [EDI]
	MOV temp1, EAX

	CMP temp2,EAX
	JZ ciclo_comparar
	CMP eax,space
	JZ coincide_palabra
	JMP no_coincide_palabra

coincide_palabra:
	MOV EAX,5
	CALL SetTextColor ;se cambia el color
	MOV EDI,posicion1
	MOV ESI,posicion2
	JMP L1

no_coincide_palabra:
	MOV EDI,posicion1
	MOV ESI,posicion2
	JMP L1

end_:
     ; Exit App
     Push 0
     Call ExitProcess

end start
