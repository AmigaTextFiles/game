;FIN14DSS
;Jaroslaw Chudziak
;ul. Egejska 1/13
;Warszawa
obr      jmp   obr      <-2
ognia    dat   -4
skocz    mov   0        1
start    spl   obr
         mov   #-4      ognia
         mov   #595    oj
atak1    mov   ognia    @ognia
         sub   #5       ognia
         djn   atak1    oj
         mov   skocz    3
         spl   2
oj       dat   595
         end   start
