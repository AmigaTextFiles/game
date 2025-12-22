   ; program  bojowy  MICHA
   ;     listopad 1992r

   ;   Miroslaw  Chaja
   ; ul. 1000-lecia 47/15
   ;  40 -875  Katowice    

cel1      dat 1700
dlug1     dat 15
zero1     djn 0 <2
          djn 0 @1
kontra1   jmp -2 -21
cd1       mov #15 dlug1
          mov #1700 cel1
sam       mov @dlug1 <cel1
          djn sam dlug1
          spl 1679
          slt kontra kontra1
          jmp start2 
          spl zero1
gnom1     add #17 dlug1
          mov strzal @dlug1
          jmp gnom1
strzal    spl 0
cel       dat 1100
dlug      dat 14
zero      djn 0 <2
          djn 0 @1
kontra    jmp -2 -21
cd        mov #14 dlug
          mov #1100 cel
start2    mov @dlug <cel
          djn start2 dlug
          spl 1080
          spl zero
gnom      add #37 dlug
          mov skoczek @dlug
          spl @dlug
          jmp gnom
skoczek   mov 0 1
start     spl skoczek
          jmp sam
          end 
