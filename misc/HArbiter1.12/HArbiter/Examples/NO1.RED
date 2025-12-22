;  autor  Ireneusz Blonar
;  ul.Kalskiego 17/321 
;      01-489 Warszawa
start   spl  8
        mov #1815    6
        mov @3      <5
        mov @2      <4
        djn -2       3
        jmp -4      <1
        dat  0       1
        spl  0      
        mov  0       1
        end
