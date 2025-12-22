;gemini
;standard WA'91
;
zrodlo  dat         0
start   mov #6      zrodlo
        mov #100    cel
kopia   mov @zrodlo <cel
        djn kopia   zrodlo
        jmp 95
cel     dat         0
        end
