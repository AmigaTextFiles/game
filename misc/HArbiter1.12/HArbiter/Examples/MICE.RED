;MICE
;Chip Wendell
;standard WA'91
;
ptr     dat                0
start   mov     #12        ptr
loop    mov     @ptr       <dest
        djn     loop       ptr
        spl     @dest
        add     #653       dest
        jmz      start     ptr
dest    dat                833
        end
