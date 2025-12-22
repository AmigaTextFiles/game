;    *** Pluton ***
;   Robert Grzymowicz
; os.Wyzwolenia 8 m 13
;     62-700 TUREK  

zkad    DAT 0
start   MOV #160    dokad
        MOV #5      cel  
skok3   MOV #14     zkad
        MOV #20     ileb
skok1   MOV bomba   @cel
        ADD #7      cel
ileb    DJN skok1   #0
skok2   MOV @zkad   <dokad
        DJN skok2   zkad
dokad   SPL @dokad
        ADD dokad   dokad
        ADD dokad   cel
        ADD dokad   dokad
        JMZ skok3   zkad
bomba   DAT 0       0
        MOV #-6     cel
skok4   MOV bomba   <cel
        MOV sznur   <cel 
        JMP skok4   <cel
sznur   SPL 0
cel     DAT 0        
        end
