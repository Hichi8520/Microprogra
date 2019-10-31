.model small
.stack 64
.data
  strcadena db 0ah,0dh, 'Ingresar cadena: ', '$'
  vec1 db 50 dup(' '), '$'  ;Vector 1
  vec2 db 50 dup(' '), '$'  ;Vector 2
  striguales db 0ah,0dh, 'Son iguales ', '$'
  strdiferentes db 0ah,0dh, 'Son diferentes ', '$'
  longitud db 0
  char db ?
  posvec2 db ?
.code 
programa:
  mov ax,@data
  mov ds,ax
  mov ah,09
  mov dx,offset strcadena  ;Mensaje para pedir la cadena
  int 21h
 
  lea si,vec1  ;Cargamos en el registro si al primer vector
pedir1:
  mov ah,01h  ;Pedimos un caracter
  int 21h
  mov [si],al  ;Se guarda en el registro indexado al vector
  inc si
  inc longitud
  cmp al,0dh  ;Se cicla hasta que se presione Enter
  ja pedir1
  jb pedir1

  dec longitud
  ;mov al,longitud ;restar 1 a longitud para obtener el valor real
  ;sub al,1
  ;mov longitud,al
  
  mov cl,longitud ;veces a repetir el loop
  mov AX,DS
  mov ES,AX

  lea si,vec2
  mov posvec2,si ;obtener la posicion incical del vector 2
      
  lea si,vec1  ;Cargamos en el registro si al primer vector
voltear:
  mov al,[si]   ;obtener lo que hay en la posicion si
  mov char,al
  
  mov al,posvec2
  add al,longitud ;posicion a insertar al reves
  ;mov si,al
  
  mov [al],char
  
  inc si
  dec longitud
  loop voltear 


  
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