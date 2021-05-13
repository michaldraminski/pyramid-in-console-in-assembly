;   PROGRAM  "piramida.asm"

dane SEGMENT 	;segment danych
tabela db 128 dup (?)

dane ENDS

rozkazy SEGMENT 'CODE' use16 	;segment zawieraj¹cy rozkazy programu
		ASSUME cs:rozkazy, ds:dane
wystartuj:
		mov ax, SEG dane
		mov ds, ax		
PART1:
		mov         dl,7 
		mov         dh,7 
		mov         cl,0 
PART2:
		cmp         cl,8 
		jnb         PART17 
		mov         bx,0 
PART3:
		cmp         bl,dh
		ja          PART11 
PART4:
		mov         byte ptr tabela[bx],' ' 
		cmp         cl,7 
		jne         PART5 
		mov         byte ptr tabela[bx],'7'
PART5:
		cmp         bl,dl
		jne         PART7 
PART6:
		mov         al,cl 
		add         al,'0' 
		mov         byte ptr tabela[bx],al 
PART7:
		cmp         bl,dh 
		jne         PART10 
PART8:
		mov         al,cl 
		add         al,'0'
		mov         byte ptr tabela[bx],al 
PART10:
		inc         bx 
		jmp         PART3 
PART11:
		dec         dl 
		inc         dh 
		mov         bl,dh
		xor         bh,bh 
		mov         byte ptr tabela[bx],'$' 
		mov			bx, 0
		push		dx
PART12:
		cmp         byte ptr tabela[bx],'$'
		je          PART15 
PART13:
		mov         dl,byte ptr tabela[bx] 
		mov         ah,2 
		int         21h 
PART14:
		inc         bx
		jmp         PART12 
PART15:
		mov         ah,2 
		mov         dl,13
		int         21h
		mov         ah,2 
		mov         dl,10 
		int         21h 
		pop			dx
PART16:
		inc         cl 
		jmp         PART2 
PART17:		

		mov al, 0 	;kod powrotu programu (przekazywany przez
				;rejestr AL) stanowi syntetyczny opis programu
				;przekazywany do systemu operacyjnego
				;(zazwyczaj kod 0 oznacza, ¿e program zosta³
				;wykonany poprawnie)

		mov ah, 4CH 	;zakoñczenie programu – przekazanie sterowania
				;do systemu, za pomoc¹ funkcji 4CH DOS
		int 21H
		
		

rozkazy ENDS

nasz_stos SEGMENT stack 	;segment stosu
dw 128 dup (?)
nasz_stos ENDS

END wystartuj 			;wykonanie programu zacznie siê od rozkazu
				;opatrzonego etykiet¹ wystartuj