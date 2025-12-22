;Jumper
;Autor: Grzegorz Przybylski
;V LO Bielsko-Biala

        DAT #9
        DAT #43
start   MOV #9 -2
        MOV @-3 <-2 
        DJN -1 -4
        ADD #1 -4
        SPL @-5
        ADD #199 -6
        JMP start

