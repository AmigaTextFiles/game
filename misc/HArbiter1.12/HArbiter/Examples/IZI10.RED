;IZI 10;
;Krzysztof Izdebski;
;Rapackiego 17b/4;
;59-400 Jawor;


      dat 25
      add #-1    1
start mov <-2    1000
      djn -2     #16
      spl @-2
      add #1015  -3
      add #16    -3
      mov #25    -7
      djn -6     #7
      add #5     1
      jmz 4      10
      mov 13     @-1
      add #1     -2
      jmp -3
      add #-5    1
      jmz 4      -2
      mov 8      @-1
      add #-1    -2
      jmp -3
      djn -10    #190
      mov #10    -10
      mov #-2    -6
      add #190   -3
      jmp -14
      dat 0

       
