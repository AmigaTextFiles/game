;IZI 11;
;Krzysztof Izdebski;
;Rapackiego 17b/4;
;59-400 Jawor;


start add #-5    1
      jmz 4      2
      mov 9      @-1
      add #-1    -2
      jmp -3
      add #5     1
      jmz 4      1
      mov 4      @-1
      add #1     -2
      jmp -3
      jmp -10
      dat 0
      
