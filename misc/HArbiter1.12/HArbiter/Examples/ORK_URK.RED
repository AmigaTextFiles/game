;(c)1992 JAROSLAW PYSZNY
;ul. Szpitalna 2/8
;44-280 Rydultowy
;	ORK_URK
        DAT 0       0
START   SPL KOPIA   19
        SPL ST1     
        SPL ST2
        DAT 0       0
CEL     DAT 0       #5      
ST1     MOV CEL     @CEL    
        ADD #5      CEL
CEL1    JMP ST1     #-5
        DAT 0       0
CEL2    DAT 0       0
ST2     MOV CEL2    @CEL1
        SUB #5      CEL1
ADR     JMP ST2     1003
        DAT 0       0
        DAT 0       0
KOPIA   MOV @START  <ADR
        DJN KOPIA   START  
        JMP @ADR
        DAT 0       0
        DAT 0       0
