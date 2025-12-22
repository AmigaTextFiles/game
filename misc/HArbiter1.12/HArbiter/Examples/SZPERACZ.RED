;===========
; SZPERACZ |
;===========
;Tomasz Kolodziejczyk
;80-352 Gdansk-Oliwa
;ul. Piastowska 90 D/5

        add #109    -1
        mov -2      @-2
        jmp -2
start   spl -3
        mov #95     5
        mov #10     2
        mov <4      <3
        djn -1      #0
        add #3      1
        jmp @0
end
