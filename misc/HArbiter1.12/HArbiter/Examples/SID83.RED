;Sid83
;(C) 1998 by Ryszard Nowakowski, Amigos Computer Brotherhood
D	ADD #-700 A
	MOV C <A
	MOV B <A
	SPL @A
	JMP D
A	DAT 0
B	MOV -2 <-2
C	JMP -1 <-3
	END