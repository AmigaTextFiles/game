;Wojownik   FILUT
;autor :    Norbert Kilen
;adres :    ul.Lukowska 9/157
;           04-133   Warszawa
;tel.  :    13-85-76
;
bomba    dat                0
skoczek  mov    0           1
start    mov    skoczek     -1003
         spl    -1004
         mov    skoczek     100   
         spl    99
         spl    98
         spl    97
         spl    move
         spl    drugi
pierwszy mov    bomba       @tyl
         sub    #6          tyl
         jmp    pierwszy
tyl      dat                -200
przod    dat                200
drugi    mov    bomba       @przod
         add    #6          przod
         jmp    drugi
line     dat                9
target   dat                509
move     mov    @line       <target
         djn    move        line
         add    #1          target
         mov    #109        <target
         mov    #9          <target
         add    #2          target
         jmp    @target
         end

