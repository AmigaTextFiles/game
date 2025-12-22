;commando
        mov #0      -3
        jmp -1
start   spl -2
        mov imp     115
        spl 114
        mov #12     -7
        mov #100    5
kopia   mov @-9     <4
        djn kopia   -10
        jmp 93
imp     mov 0       1
        end
