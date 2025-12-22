;(c)1992 ALEXANDER PYSZNY
;ul. Szpitalna 2/8
;44-280 Rydultowy
; * * D R A G O N * *
       dat         #0
tu     mov  #10     3
       mov  -2    <-2
       djn   -1    1
       dat         #10 
cel    dat         #0
       mov  cel   <cel
       djn  -1     1
       dat         #10
start  spl  radar  #-50
petla  mov  <co   <gdzie
       djn  petla  licz
ile    spl  @gdzie  #50
       add  #3    co
       sub  #27   gdzie
       mov  #3    licz
licz   jmp  petla  #3
co     dat         #-8
gdzie  dat         #-41
radar  mov  echo   @start
       sub  #30    start
       djn  radar  ile
echo   jmp  tu
