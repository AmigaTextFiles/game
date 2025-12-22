
        move.l  (a3),d7
        move.l  4(a3),a1
        move.l  8(a3),a0

12to16
        subq    #1,d7
.loop1
        moveq   #0,d0
        move.w  (a0)+,d0
        move.l  d0,d1
        lsr.l   #4,d0
        move.w  d0,(a1)+
        lsl.l   #8,d1
        move.b  (a0)+,d1
        and.l   #$fff,d1
        move.w  d1,(a1)+
        subq    #1,d7
        dbf     d7,.loop1
        rts
