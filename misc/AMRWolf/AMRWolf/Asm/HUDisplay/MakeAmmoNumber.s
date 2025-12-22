main
        move.l  (a3),a0
        move.l  a0,a1
        lea     3358(a0),a2
        move.l  4(a3),d0
        divu    #10,d0
        move.w  d0,d1
        swap.l  d0
        ext.l   d0      ; d0 contains units, d1 contains 10's

        mulu    #20,d0
        mulu    #20,d1

        adda.l  d0,a1
        adda.l  d1,a0

        moveq   #14,d7
.yloop
        moveq   #9,d6
.xloop
        move.w  (a0)+,(a2)+
        dbf     d6,.xloop
        moveq   #9,d6
.xloop2
        move.w  (a1)+,(a2)+
        dbf     d6,.xloop2
        lea     180(a0),a0
        lea     180(a1),a1
        lea     18(a2),a2
        dbf     d7,.yloop

        rts

