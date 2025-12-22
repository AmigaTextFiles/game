; nazwa wojownika: SHARK
;
; namiar na autora: Adam Ryba
;                   Os. XXX-lecia 6/2
;                   47-303 KRAPKOWICE

start   MOV #5 cel
        MOV #397 licznik
petla   MOV cel @cel
        MOV gdzie <cel
        ADD #6 cel
        DJN petla licznik
        DJN start bomba
init    MOV #1987 licznik
        MOV #-12 gdzie
rzucaj  MOV bomba <gdzie
        DJN rzucaj licznik
licznik JMP init #397

gdzie   SPL 0
cel     JMP -1 #5
bomba   DAT 3

        END
