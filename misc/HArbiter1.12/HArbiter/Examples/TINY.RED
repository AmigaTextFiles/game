;Tiny - the smallest non-Imp worm
;William R. Buckley, AMRAN
;
start    add    #2          dest
loop     mov    @ptr        <dest
         cmp    #-5         ptr
         jmp    loop        <ptr
dest     jmp    $5          9
ptr      dat                0
         end
