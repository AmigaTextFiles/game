;Ojczym
;Jaroslaw Chudziak
;ul. Egejska 1/13
;WARSZAWA
ognia    dat   0
skocz    spl   skocz
         jmp   skocz
obrona   jmp   obrona   <-3 
start    spl   obrona
atak1    mov   tu       <ognia
         djn   atak1    oj
         mov   oj       skocz
         mov   0        1
oj       dat   660
tu       jmp   3
         end   start
