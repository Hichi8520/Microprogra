.model small
.stack 64
.data
  strcadena1 db 0ah,0dh, 'Ingresar cadena 1: ', '$'
  strcadena2 db 0ah,0dh, 'Ingresar cadena 2: ', '$'
  striguales db 0ah,0dh, 'Son iguales ', '$'
  strdiferentes db 0ah,0dh, 'Son diferentes ', '$'
  vec1 db 50 dup(' '), '$'  ;Vector 1
  vec2 db 50 dup(' '), '$'  ;Vector 2
.code 
programa:
  mov ax,@data
  mov ds,ax
  mov ah,09
  mov dx,offset strcadena1  ;Mensaje para pedir la cadena 1
  int 21h
 
  lea si,vec1  ;Cargamos en el registro si al primer vector
pedir1:
  mov ah,01h  ;Pedimos un caracter
  int 21h
  mov [si],al  ;Se guarda en el registro indexado al vector
  inc si
  cmp al,0dh  ;Se cicla hasta que se presione Enter
  ja pedir1
  jb pedir1

  mov ax,@data
  mov ds,ax
  mov ah,09
  mov dx,offset strcadena2  ;Mensaje para pedir cadena 2
  int 21h
  lea si,vec2  ; Se carga en SI el vector2

pedir2:    ;Mismo procedimiento que pedir1
  mov ah,01h
  int 21h
  mov [si],al
  inc si
  cmp al,0dh
  ja pedir2
  jb pedir2
  
  mov cx,50   ;Determinamos la cantidad de datos a leer/comparar
  mov AX,DS  ;mueve el segmento datos a AX
  mov ES,AX  ;mueve los datos al segmento extra

compara: 
  lea si,vec1  ;cargamos en si la cadena que contiene vec
  lea di,vec2 ;cargamos en di la cadena que contiene vec2
  repe cmpsb  ;compara las dos cadenas
  Jne diferente ;si son diferentes
  je iguales    ;si son iguales
 
iguales:
  mov ax,@data
  mov ds,ax
  mov ah,09
  mov dx,offset striguales ;Imprime que son iguales
  int 21h
  mov ah,04ch
  int 21h

diferente:
  mov ax,@data
  mov ds,ax
  mov ah,09
  mov dx,offset strdiferentes  ; Imprime que son diferentes
  int 21h
  mov ah,04ch
  int 21h

  
; finalizar programa
MOV AH, 4Ch ; finalizar proceso
INT 21h     ; ejecuta interrupcion
end programa