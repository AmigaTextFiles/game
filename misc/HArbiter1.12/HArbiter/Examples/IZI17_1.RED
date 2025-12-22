;IZI17_1;
;Krzysztof Izdebski;
;Rapackiego 17b/4;
;59-400 Jawor;

      
      dat 0
      add #20  2
      add #-20 4
start cmp #0   18
      jmp 9
      cmp #0   -5
      jmp -11
      add #400 1
      mov 13   0
      spl @-1
      djn -9   #4
      mov 11   -4
      jmp -11
      mov -13  @-10
      add #1   -11
      djn -12  #20
      jmp -10
      mov -17  @-12
      add #-1  -13
      djn -16  #20
      jmp -10
      jmp 0
      

