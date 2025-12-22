;Jumper_supersprint_short
;Autor Grzegorz Przybylski
	DAT #7
start:	MOV #7 -1
	MOV @-2 <2 
        DJN -1 -3
        SPL @0 #43
        ADD #199 -1
        JMP -5 

