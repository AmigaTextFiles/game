
        ; This file is to record the positions of all objects and enemies in the
        ; player's line of sight.

DCRCastHoriz

        move.l  xp(a3),xi
        and.l   #modulusmask,xi

        tst.w   trig
        beq     .skipxintercepts
        bpl     .cosgreater
        add.l   #255,xi
.cosgreater

.xintloop
        tst.w   trig
        bmi     .cosless
        add.l   #512,xi
.cosless
        sub.l   #256,xi

        move.l  xp(a3),yi
        sub.l   xi,yi
        beq     .xintloop
        swap.w  trig            ;sine
        muls    trig,yi
;        tst.l   yi
;        bmi     .yineg
;        add.l   #16384,yi
;.yineg
;        sub.l   #8192,yi
        swap.w  trig            ;cosine
        divs    trig,yi
        bvs     .skipxintercepts
        ext.l   yi
        add.l   yp(a3),yi

        ; At this point we have the x and y coordinate of the intercept
        ; with a vertical (north to south) line.

        move.l  xi,scr0
        asr.l   #8,scr0
        tst.l   scr0
        bmi     .skipxintercepts
        cmp.l   #127,scr0
        bge     .skipxintercepts
        move.l  scr0,lxcell(a4)
        move.l  yi,scr1
        asr.l   #8,scr1
        tst.l   scr1
        bmi     .skipxintercepts
        cmp.l   #127,scr1
        bge     .skipxintercepts
        move.l  scr1,lycell(a4)
        asl.l   #7,scr1
        add.l   scr0,scr1
        ; Scr1 now contains an offset into the map data for the current cell.

        move.w  (mapptr,scr1*2),scr0
        ; and now scr0 contains the contents of that cell.

        tst.l   scr0
        beq     .xintloop

        btst    #8,scr0         ; Does this cell contain an enemy?
        beq     .notenemy

        btst    #5,scr0
        beq     .xintloop

.notenemy
        btst    #15,scr0
        beq     .xnotdoor
        bset    #6,scr0
.xnotdoor
        move.l  yi,scr1
        and.l   #$ff,scr1       ;Texture column.

        btst    #7,scr0         ; Does this cell contain an object?
        beq     .xinotfacingplayer

        move.l  xi,scr2
        and.l   #modulusmask,scr2
        add.l   #$80,scr2
        move.l  yi,scr1
        and.l   #modulusmask,scr1
        add.l   #$80,scr1
                                ; scr3 and 4 now contain the coordinates of
                                ; this cell's centre.
        sub.l   xp(a3),scr2
        sub.l   yp(a3),scr1
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
        bmi     .xintloop
        cmp.l   #$f0,scr1
        bge     .xintloop
        addq    #8,scr1
        bra     .xiddone

.xinotfacingplayer
        move.w  trig,scr4
        bpl     .xidontnegcos
        neg.w   scr4
.xidontnegcos
        cmp.w   #4096,scr4
        bgt     .xiusecos

        move.l  yi,scr2
        sub.l   yp(a3),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        swap.w  trig
        divs    trig,scr2       ; sine
        swap.w  trig
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; y difference and sine.
        bra     .xiddone
.xiusecos
        move.l  xi,scr2
        sub.l   xp(a3),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        divs    trig,scr2       ; cosine
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; x difference and cosine.
.xiddone
        tst.l   scr0
        beq     .xintloop

        tst.l   scr2
        bpl     .xidontnegd

        neg.l   scr2

.xidontnegd

        btst    #4,scr0
        beq     .xidontanimate
        btst    #0,scr0
        bne     .xidontanimate
        add.l   animframe(a3),scr0
.xidontanimate

        tst.l   scr2
        beq     .xidontaddtolist
        and.l   #32767,scr2
        bfextu  xi{16:8},scr4
        bfins   scr4,scr2{0:8}
        bfextu  yi{16:8},scr4
        bfins   scr4,scr2{8:8}
        bclr    #23,scr2
        btst    #6,scr0
        beq     .xidontsetzbuf
        bset    #31,scr2
.xidontsetzbuf
        btst    #8,scr0
        beq     .xidontsetzbuf2
        bset    #31,scr2

.xidontsetzbuf2

        move.l  scr2,(listptr)+

.xidontaddtolist
        btst    #6,scr0
        bne     .xintloop

        btst    #8,scr0
        bne     .xintloop

.skipxintercepts
        clr.l   (listptr)+

DCRCastVert

        move.l  list2(a3),listptr
        swap    trig            ; Sine
        move.l  yp(a3),yi
        and.l   #modulusmask,yi

        tst.w   trig
        beq     .skipyintercepts
        bmi     .sinless
        add.l   #255,yi
.sinless

.yintloop
        tst.w   trig
        bpl     .sinlessagain
        add.l   #512,yi
.sinlessagain
        sub.l   #256,yi

        move.l  yp(a3),xi
        sub.l   yi,xi
        beq     .yintloop
        swap.w  trig            ; cosine
        muls    trig,xi
;        tst.l   xi
;        bmi     .xineg
;        add.l   #16384,xi
;.xineg
;        sub.l   #8192,xi
        swap.w  trig            ; sine
        divs    trig,xi
        bvs     .skipyintercepts
        ext.l   xi
        add.l   xp(a3),xi

        ; At this point we have the x and y coordinate of the intercept
        ; with a horizontal (east to west) line.

        move.l  xi,scr0
        asr.l   #8,scr0
        tst.l   scr0
        bmi     .skipyintercepts
        cmp.l   #127,scr0
        bge     .skipyintercepts
        move.l  scr0,lxcell(a4)
        move.l  yi,scr1
        asr.l   #8,scr1
        tst.l   scr1
        bmi     .skipyintercepts
        cmp.l   #127,scr1
        bge     .skipyintercepts
        move.l  scr1,lycell(a4)
        asl.l   #7,scr1
        add.l   scr0,scr1
        ; Scr1 now contains an offset into the map data for the current cell.

        move.w  (mapptr,scr1*2),scr0
        ; and now scr0 it contains the contents of that cell.

        tst.l   scr0
        beq     .yintloop

        btst    #8,scr0         ; Does this cell contain an enemy?
        beq     .ynotenemy

        btst    #5,scr0
        beq     .yintloop

.ynotenemy
        btst    #15,scr0
        beq     .ynotdoor
        bset    #6,scr0
.ynotdoor
        move.l  xi,scr1
        and.l   #$ff,scr1       ;Texture column.

        clr.l   scr2            ; scr2 will be used for the distance to point of
                                ; intersection.

        btst    #7,scr0         ; Does this cell contain an object?
        beq     .yinotfacingplayer

        move.l  xi,scr2
        and.l   #modulusmask,scr2
        add.l   #$80,scr2
        move.l  yi,scr1
        and.l   #modulusmask,scr1
        add.l   #$80,scr1
                                ; scr3 and 4 now contain the coordinates of
                                ; this cell's centre.
        sub.l   xp(a3),scr2
        sub.l   yp(a3),scr1
        swap.w  trig
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
        sub.l   scr3,scr1
        asr.l   #8,scr1
        asr.l   #5,scr1
        asr.l   #8,scr2
        asr.l   #6,scr2
        add.l   #$78,scr1
                                ; Scr2 now contains distance, and scr1 contains
                                ; the texture column.
        tst.l   scr1
        bmi     .yintloop
        cmp.l   #$f0,scr1
        bge     .yintloop
        addq    #8,scr1
        bra     .yiddone

.yinotfacingplayer
        move.w  trig,scr4
        bpl     .yidontnegsin
        neg.w   scr4
.yidontnegsin
        cmp.w   #4096,scr4
        blt     .yiusecos

        move.l  yi,scr2
        sub.l   yp(a3),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        divs    trig,scr2       ; sine
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; y difference and sine.
        bra     .yiddone
.yiusecos
        move.l  xi,scr2
        sub.l   xp(a3),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        swap.w  trig
        divs    trig,scr2       ; cosine
        swap.w  trig
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; x difference and cosine.
.yiddone
        tst.l   scr0
        beq     .yintloop

        tst.l   scr2
        bpl     .yidontnegd

        neg.l   scr2

.yidontnegd

        tst.l   scr2
        beq     .yidontaddtolist

        and.l   #32767,scr2
        bfextu  xi{16:8},scr4
        bfins   scr4,scr2{0:8}
        bfextu  yi{16:8},scr4
        bfins   scr4,scr2{8:8}
        bclr    #23,scr2
        btst    #6,scr0
        beq     .yidontsetzbuf
        bset    #31,scr2
.yidontsetzbuf
        btst    #8,scr0
        beq     .yidontsetzbuf2
        bset    #31,scr2
.yidontsetzbuf2
        move.l  scr2,(listptr)+

.yidontaddtolist
        btst    #6,scr0
        bne     .yintloop

        btst    #8,scr0
        bne     .yintloop

.skipyintercepts
        clr.l   (listptr)+

DCRMergeLists

        move.l  destlist(a3),a2
        move.l  list1(a3),a1
        move.l  list2(a3),a0
        move.l  (a0)+,d0
        move.l  (a1)+,d1
.loop

        cmp.w   d0,d1
        beq     .same
        blt     .d1less
.d0less
        tst.w   d0
        beq     .d1less
        move.l  d0,(a2)+
        btst    #31,d0
        beq     .done
        move.l  (a0)+,d0
        bra     .loop

.d1less
        tst.w   d1
        beq     .d0less
        move.l  d1,(a2)+
        btst    #31,d1
        beq     .done
        move.l  (a1)+,d1
        bra     .loop

.same
        move.l  d0,(a2)+
        tst.w   d0
        beq     .done
        btst    #31,d0
        beq     .done
        move.l  d1,(a2)+
        btst    #31,d1
        beq     .done
        move.l  (a0)+,d0
        move.l  (a1)+,d1
        bra     .loop
.done
        clr.l   (a2)+

DCRTestForEnemies

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
                ; Scr2 now contains distance, and scr1 contains the texture
                ; column.
        tst.l   scr1
        bmi     .enemydone
        cmp.l   #$f0,scr1
        bge     .enemydone

                ; We want the enemy record to hold the enemy number in bits 22-16
                ; and bit 23 set to show that this is an enemy.
        move.l  a0,scr1
        subq    #4,scr1
        sub.l   enemylist(a3),scr1
        lsr.l   #2,scr1

        tst.l   scr2
        bmi     .enemydone
        beq     .enemydone
        cmp.l   #16,scr2
        ble     .enemydone

        bfins   scr1,scr2{8:8}
        bset    #23,scr2
        bset    #31,scr2

        move.l  destlist(a3),a1
.insertloop
        move.l  (a1)+,scr1
        beq     .enemydone

        cmp.w   scr2,scr1
        bge     .foundposition

        btst    #31,scr1
        beq     .enemydone
        bra     .insertloop

.foundposition
        ; Simply moving the enemy record into the sorted list will let AMOSPro
        ; access it.

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
        adda.l  #12,a0
        dbf     scr0,.enemyloop


