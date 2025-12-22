;ZOMBI
;Jaroslaw Chudziak
;ul. Egejska 1/13
;Warszawa
ognia    dat   0
oj       dat   660
obrona   jmp   obrona   <-2 
start    spl   obrona
atak1    mov   ognia    <ognia
         djn   atak1    oj
switch   mov   #660     oj
         mov   skoczek  switch
         mov   #0       ognia
         jmp   atak1      
skoczek  mov   0        1
         end   start
