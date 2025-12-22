;Zaraza
;standard CWS'88 i WA'91
;
cel     dat 0
start   add #100    cel
        mov skoczek @cel
        spl @cel
        jmp start
skoczek mov 0       1
        end
