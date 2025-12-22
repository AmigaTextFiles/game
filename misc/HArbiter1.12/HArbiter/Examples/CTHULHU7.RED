; Cthulhu1
; Autor: Dominik Kozaczko kl 3b.
.WA91

                dat     1
                dat     2
                dat     3
                dat     4
                dat     5
                dat     6
                dat     7
                dat     8
                dat     9
                dat     10
                dat     11
                dat     12
                dat     13
                dat     14
                dat     15
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
                JMP     @target
                dat             15
                dat             14
                dat             13
                dat             12
                dat             11
                dat             10
                dat              9
                dat              8
                dat              7
                dat              6
                dat              5
                dat              4
                dat              3
                dat              2
                dat              1
                END     START

