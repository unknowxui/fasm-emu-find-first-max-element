#fasm# 
xor ax,ax
mov bl,-127
mov ax,len
xor si,si
whileLoopFs:
 mov dl,[vector + si]
 cmp dl,[vector + si + 1]
 jg maxBl
 jl maxRigh 
 je eqEl
maxBl:   ; if bl  >
mov bl,[vector + si]
mov di,si
jmp preEnd

maxRigh: ; if bl <
inc si
mov bl,[vector + si]
mov di,si
jmp preEnd

eqEl: ; bl ==
 cmp bl,-127
 jne finish
 
 mov bl,[vector + si]
 mov di,si

preEnd:
 cmp bl,-127
 je  whileLoopFsEnd
 push si
 xor si,si   
 whileLoopTw:
   cmp bl,[vector + si]
   jg whileLoopTwEnd
   jl twMaxRig
   je whileLoopTwEnd
   jmp whileLoopTwEnd
   twMaxRig:
    mov bl,[vector + si]
    mov di,si
   
 whileLoopTwEnd:
 inc si
 cmp si,ax
 jne whileLoopTw
 pop si
 jmp finish 

whileLoopFsEnd:
inc si
cmp ax,si
jne whileLoopFs

finish:
cmp bl,111
je pEnd
mov ah,09h
mov dx,StringMaxValue
int 21h

or bl,bl
js negNumber
 jmp printStrings
negNumber:
not bl
add bl,1b 
mov ah,09h
mov dx,NegString
int 21h
 
printStrings: 
mov cx,bx
mov bx,String
lea ax,[StringEnd - 1]
call to_str
mov dx,ax
mov ah,09h
int 21h 
   
mov ah,09h
mov dx,StringMaxValuePos
int 21h
inc di
mov bx,StringPosition
lea ax,[StringPositionEnd-1]
mov cx,di
call to_str 
mov dx,ax
mov ah,09h
int 21h
pEnd:
ret       
        
to_str:
  push di
  std                   
  mov	di,ax
  mov	ax,cx     

  mov	cx,10          
  Repeata:
  xor	dx,dx         
  div	cx            
                                      
  xchg	ax,dx         
  add	al,'0'         
  stosb                 
  xchg	ax,dx      
  or	ax,ax        
  jne	Repeata
		
  mov ax,bx

  pop di
  ret        
 
  NegString db '-','$'
 
 StringMaxValue    db 'Max Value: ','$'
 StringMaxValuePos db ' Max Value Pos: ','$'
 
 String		db	5 dup (?),'$'  
 StringEnd	=	$-1
 
 StringPosition db 5 dup(?),'$'
 StringPositionEnd = $ - 1

 vector  db 1, 1, 1, 1, -1, 1, 1
 len = $ -  vector
 
 vectorB db -127,-127,-127,-127,-127,-127,-127
 lenB = $ - vectorB