;Wojownik  :  " CYBORG 3d"
;charakter :  ofensywny
;Autor     :
;             Tomasz Dzikuc
;            IV Liceum Ogolnoksztalcace
;            Ul.Kisielinska  18
;            65-247 Zielona Gora

dana00  DAT 0
dana01  DJN -3  #4
pocz    JMP -2
        MOV -2  @-2
        ADD #5  -1
        DAT 0
dana0   DAT 1800
dana1   DAT -5
start   MOV dana0  dana00
        MOV @-2  <-3
        ADD #1   -3
        DJN -3  #4
        MOV -5  dana1
        MOV dana01  $-2
        SUB #100  dana0
        ADD #6  dana00
        SPL @dana00
        DJN start  #17
