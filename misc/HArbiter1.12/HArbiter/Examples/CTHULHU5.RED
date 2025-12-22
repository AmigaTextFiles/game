; Cthulhu1
; Autor: Dominik Kozaczko kl 3b.
.WA91

source:         DAT     15
target:         DAT     800
split:          DAT     200
loop:           DAT     4
                MOV     #15     source
                MOV     #800    target
                MOV     #200    split
                MOV     #5      loop
start:          SPL     @split
                ADD     #100            split
                DJN     -2              loop
clone:          MOV     <source         <target
                JMN     clone           source
                ADD     #4      target
wow:            JMP     @target
                END     START

