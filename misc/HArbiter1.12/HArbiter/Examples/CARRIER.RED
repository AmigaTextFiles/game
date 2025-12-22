;CARRIER
;Standard CWS'88 i WA'91
;Autor : Pawel Chodowiec
;ul. Gwardii Ludowej 11 m 1
;09-400 PLOCK

ILOSC     DAT 0
START     MOV #2        ILOSC
          MOV #17       DLUGOSC1
          ADD #683      CEL
          MOV @DLUGOSC1 <CEL
          DJN -1        DLUGOSC1
          SPL @CEL
          DJN -5        ILOSC
DLUGOSC1  JMP 1
STAT      MOV #11       DLUGOSC
          ADD #-700     CEL
          MOV @DLUGOSC  <CEL
          DJN -1        DLUGOSC
          SPL @CEL
DLUGOSC   JMP STAT
          ADD #-52      DLUGOSC
          MOV BOMBA     @DLUGOSC
          ADD #4        DLUGOSC
          JMN -2        DLUGOSC
          MOV #11       DLUGOSC
          ADD #-378     BOMBA
          MOV @DLUGOSC  <BOMBA
          DJN -1        DLUGOSC
CEL       SPL @BOMBA
          JMP -9
BOMBA     DAT           0

