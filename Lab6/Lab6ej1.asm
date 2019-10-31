.model small
.stack 64
.data
  strcadena db 0ah,0dh, 'Ingresar cadena: ', '$'
  vec db 50 dup(' '), '$'  ;Vector
.code 
programa:
  mov ax,@data
  mov ds,ax
  mov ah,09
  mov dx,offset strcadena  ;Mensaje para pedir la cadena
  int 21h
 
  lea si,vec  ;Cargamos en el registro si al primer vector
pedir1:
  mov ah,01h  ;Pedimos un caracter
  int 21h
  mov [si],al  ;Se guarda en el registro indexado al vector
  inc si
  cmp al,0dh  ;Se cicla hasta que se presione Enter
  ja pedir1
  jb pedir1

  
  mov cx,50
  mov AX,DS
  mov ES,AX

      
  lea si,vec  ;Cargamos en el registro si al primer vector
imprimir:
  mov al,[si]
  mov dl,20h
  sub al,dl    ;se restan 20h para obtener la letra MAYUS
  
  mov ah, 02h ; funcion para imprimir un caracter
  mov dl, al
  int 21h ; ejecuta la funcion
  
  inc si  
  loop imprimir 

  
; finalizar programa
MOV AH, 4Ch ; finalizar proceso
INT 21h     ; ejecuta interrupcion
end programa