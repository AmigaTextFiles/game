TestForEnemies

        swap.w  trig
        move.l  enemylist(a3),a0
        moveq   #9,scr0
.enemyloop
        move.l  (a0)+,scr1
        beq     .enemydone
        move.w  scr1,scr2       ; Lower 16 bits contain xpos
        swap    scr1
        ext.l   scr1
        sub.l   yp(a3),scr1
        ext.l   scr2
        sub.l   xp(a3),scr2
        move.l  scr2,-(a7)
        muls    trig,scr2       ; cosine
        move.l  (a7)+,scr3
        move.l  scr1,-(a7)
        muls    trig,scr1       ; cosine
        neg.l   scr1
        move.l  (a7)+,scr4

        swap.w  trig
        muls    trig,scr4       ; sine
        sub.l   scr4,scr2
        muls    trig,scr3
        swap.w  trig
        sub.l   scr3,scr1
        asr.l   #8,scr1
        asr.l   #5,scr1
        asr.l   #8,scr2
        asr.l   #6,scr2
        add.l   #$78,scr1
                                ; Scr2 now contains distance, and scr1 contains
                                ; the texture column.
        tst.l   scr1
        bmi     .enemydone
        cmp.l   #$f0,scr1
        bge     .enemydone
        addq    #8,scr1

        tst.l   scr2
        bmi     .enemydone
        beq     .enemydone
        cmp.l   #16,scr2
        ble     .enemydone

        move.l  (a0),scr3
        bfins   scr3,scr2{0:8}
        bfins   scr1,scr2{8:8}
        bset    #30,scr2
        bset    #31,scr2

        move.l  destlist(a3),a1
.insertloop
        move.l  (a1)+,scr1
        beq     .enemydone

        cmp.w   scr2,scr1
        bge     .foundposition

        btst    #30,scr1
        beq     .enemydone
        bra     .insertloop

.foundposition

        ; set a flag in the enemy record to show that the enemy is visible
        ; to the player, and can thus shoot him.

        suba.l  #4,a1
        adda.l  #4,a2
.insertloop2
        move.l  scr2,(a1)+
        move.l  scr1,scr2
        move.l  (a1),scr1
        beq     .insertdone
        bra     .insertloop2

.insertdone
        move.l  scr2,(a1)+
        move.l  #0,(a1)+

.enemydone
        adda.l  #4,a0
        dbf     scr0,.enemyloop

