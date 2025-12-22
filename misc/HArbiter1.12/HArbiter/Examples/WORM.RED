; Worm by William R. Buckley
;standard WA'91
;
start         mov     #3          src
              mov     #-7         dest
              mov     #9          count
move          mov     <src        <dest
              djn     move        count
              jmp     -14
src           dat                 0
dest          dat                 0
count         dat                 0
              end
