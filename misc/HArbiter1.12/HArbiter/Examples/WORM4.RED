;Worm 4
;standard WA'91
ptr           dat                 0
begin         djn      begin      -2
              dat      0
start         spl      begin
              mov      imp        80
              spl      79
              mov      #3         src
              mov      #255       dest
              mov      #17        count
move          mov      <src       <dest
              djn      move       count
              jmp      245
imp           mov      imp        1
src           dat                 0
dest          dat                 0
count         dat                 0
              end
