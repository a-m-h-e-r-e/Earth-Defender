
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

;----------------------------------------
;              MACROS
;----------------------------------------
org 100h    
mov al, 13h
mov ah, 0
int 10h
              
macro p a
    mov dx, offset a
    mov ah, 09
    int 21h         
endm

mov     ah, 1       
mov     ch, 2bh     
mov     cl, 0bh     
int     10h         

macro dele
    mov al, 0 
    mov ah, 0eh
    int 10h    
    mov al, 0     
    mov ah, 0eh
    int 10h  
    mov al, 0  
    mov ah, 0eh
    int 10h
endm                                      

macro ship 
    mov al, '_'
    mov ah, 0eh
    int 10h
    mov al, '^'
    int 10h
    mov al, '_'
    int 10h
endm
 
macro move  
    mov dh, 23
    mov bh, 0
    mov ah, 2
    int 10h
endm  

macro pos
    mov bh, 0
    mov ah, 2
    int 10h
endm


macro star
    mov al, '>'
    mov ah, 0eh
    int 10h
endm

macro delete
    mov al, 0
    mov ah, 0eh
    int 10h
endm    

macro bul
    mov al, '|'
    mov ah, 0eh
    int 10h
endm



;-----------------------------------------


;-----------------------------------------
;               VARIABLES
;-----------------------------------------
jmp start

theShip db "_^_$"
left    equ     4bh        
right   equ     4dh        
up      equ     48h        
down    equ     50h     

dir db 0      

enemy   dw 20 dup(0)     
bullet  dw 20 dup(0)  
temp    dw 20 dup(0)
shipPos dw 2  dup(0)  
score   dw 1  dup(0)         

start:
;------------------------------------------
              
mov shipPos[0], 5888
mov dx, shipPos[0]
move
ship  
   
mov dl, 0
mov dh, 0   

p msg5  
  
inc dh
pos

p msg6    
inc dh
pos
     
mov ah, 0
int 16h

mov cx, 7
mov bx, 0  
mov enemy[4], 257  
mov dx, enemy[4]
pos
star      

mov enemy[2], 5632
mov dx, enemy[2]
pos
star

mov dl, 0
mov dh, 20           
mov enemy[0], dx
mov dl, 0
mov dh, 0

mov dx, enemy[0]
mov bl, 0
mov ah, 2
int 10h
star
        
game:
    mov ah, 1
    int 16h 
    jz noCommand
    mov ah, 0
    int 16h
    mov dir, ah
    jmp check_dir

noCommand:   ;----------------------------------------------------------------

     
all:

mov cx, 3
mov bx, 0  
mov si, 0

checkFire:
    cmp enemy[bx], 0
    je incr         
    mov dx, enemy[bx]
    cmp dl, 25;---------------------------boarder--------------
    jae gameOver
    mov temp[0], cx
    jmp checkBlasted 
    retPoint:      
    mov cx, temp[0]
    mov dx, enemy[bx] 
    pos
    delete
    star   
    inc dx
    mov enemy[bx], dx  
    add bl, 2
    skip: 
    loop checkFire

     
bulletMove:
    cmp bullet[0], 0
    je increase  
    mov dx, bullet[0]
    pos
    delete
    dec dh
    pos
    bul      
    mov bullet[0], dx
    increase: 
   
    
jmp game

incr:
    add bl, 2  
    dec cx
    jmp skip

checkBlasted:
                     
mov ax, enemy[bx]  
mov cx, bullet[0]
   
check:
    cmp ax, bullet[0]
    je hit
    jmp retPoint

hit:
    mov dx, bullet[0]
    pos
    dele
    mov enemy[bx], 0   
    mov bullet[0], 0
    mov ax, score[0]
    add ax, 1
    mov score[0], ax
    jmp retPoint
                      

check_dir:       
    cmp dir, 4bh
    je toLeft
    cmp dir, 4dh
    je toRight    
    cmp dir, 48h
    je fire
    jmp game
    
toLeft:            
    dele
    mov dx, shipPos[0]
    pos  
    dele     
    sub dl, 3         
    mov shipPos[0], dx
    move
    ship
    jmp game
            
toRight:  
    mov dx, shipPos[0]
    pos
    dele    
    add dl, 3     
    mov shipPos[0], dx
    move
    ship
    jmp game
              
fire:
    mov dx, shipPos[0]
    inc dl
    dec dh
    mov bx, dx            
    and bx, 11111111b
    mov bullet[0], dx
    pos
    bul
    jmp game

    
gameOver: 
mov dl, 0
mov dh, 20
mov bh, 0
mov ah, 02
int 10h

mov dx, offset msg
mov ah, 09
int 21h   
            
or al, 33h            
mov ah, 0eh
int 10h

ret                              


msg db "Game Over your score is: $"
msg1 db "|\______________________$"
msg2 db "|                       \$"
msg3 db "| ______________________//$"
msg4 db "|/                        $"
msg5 db "    EARTH DEFENDER!$"
msg6 db "PRESS ENTER TO START THE GAME!$" 



