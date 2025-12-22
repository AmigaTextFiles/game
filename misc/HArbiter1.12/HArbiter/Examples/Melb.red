;Melb
; autor: Dominik Kozaczko
.wa91
ping:    dat      0
b1:      dat      ping
b2:      dat      1000
b3:      dat      500
b4:      dat      250
b5:      dat      125
pocisk:   dat      0
start:   mov      pocisk    <b1
         mov      pocisk    <b2
         mov      pocisk    <b3
         mov      pocisk    <b4
         mov      pocisk    <b5
         spl      start
one:     mov      pocisk    <b1
         mov      pocisk    <b1
         mov      pocisk    <b1
         mov      pocisk    <b1
         mov      pocisk    <b1
         spl      one
two:     mov      pocisk    <b2
         mov      pocisk    <b2
         mov      pocisk    <b2
         mov      pocisk    <b2
         mov      pocisk    <b2
         mov      pocisk    <b2
         spl      two
three:   mov      pocisk    <b3
         mov      pocisk    <b3
         mov      pocisk    <b3
         mov      pocisk    <b3
         mov      pocisk    <b3
         mov      pocisk    <b3
         spl      three
four:    mov      pocisk    <b4
         mov      pocisk    <b4
         mov      pocisk    <b4
         mov      pocisk    <b4
         mov      pocisk    <b4
         spl      four
five:    mov      pocisk    <b5
         mov      pocisk    <b5
         mov      pocisk    <b5
         mov      pocisk    <b5
         mov      pocisk    <b5
         end      start
