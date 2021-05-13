;   PROGRAM  "tekst.asm"

dane SEGMENT 	;segment danych

tablica1 db '11223344$'
tablica2 db '55667788$'
tablica3 db '11112222$'
tablica4 db '33334444$'
tablica5 db 65 dup(?)
koniec_tablicy5 db ?

dane ENDS

rozkazy SEGMENT 'CODE' use16 	;segment zawieraj�cy rozkazy programu
		ASSUME cs:rozkazy, ds:dane

kopiuj_tablice:
		add bx, cx      
ptl:
		mov al, [bx]
		mov [tablica5+si], al
		dec bx
		inc si
		loop ptl
		ret
		
wyswietl_nowa_linia:
		mov dl,13
		mov ah,2
		int 21h		
		mov dl,10
		mov ah,2
		int 21h		
		ret		
		
wyswietl:
		mov dl, [bx]
		cmp dl, '$'
		je koniec_wyswietl
		mov ah,2
		int 21h
		inc bx
		jmp wyswietl
koniec_wyswietl:
		call wyswietl_nowa_linia
		call wyswietl_nowa_linia
		ret 		
		
wystartuj:
        mov ax, SEG dane
        mov ds, ax
		
		mov si, 0  
		mov cx, LENGTHOF tablica1 - 1
        mov bx, OFFSET tablica1 - 1
		call kopiuj_tablice
		
		mov cx, LENGTHOF tablica2 - 1
        mov bx, OFFSET tablica2 - 1
		call kopiuj_tablice

		mov cx, LENGTHOF tablica3 - 1
        mov bx, OFFSET tablica3 - 1
		call kopiuj_tablice

		mov cx, LENGTHOF tablica4 - 1
        mov bx, OFFSET tablica4 - 1
		call kopiuj_tablice
		
		mov [tablica5+si], '$'
		
		mov bx, offset tablica1
		call wyswietl
		
		mov bx, offset tablica2
		call wyswietl
		
		mov bx, offset tablica3
		call wyswietl

		mov bx, offset tablica4
		call wyswietl

		mov bx, offset tablica5
		call wyswietl
		
        ; koniec programu
        mov al, 0 
		mov ah, 4CH 
        int 21H

		
rozkazy ENDS

END wystartuj 