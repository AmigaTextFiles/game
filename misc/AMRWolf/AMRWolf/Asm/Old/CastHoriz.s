CastHoriz

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

        ; Problem:  how to ignore this enemy if it is hidden by a wall detected
        ; in the other half of the raycasting.  Possible solution, which would
        ; also solve potential problem if an enemy was `left behind' would be to
        ; stamp an enemy into a cell and remove it from the active list, if it
        ; became too far away from the player.

        move.w  #0,(mapptr,scr1*2)
        move.l  xi,scr1
        and.w   #$ff00,scr1
        move.l  yi,scr2
        and.w   #$ff00,scr2
        add.l   #$80,scr1
        add.l   #$80,scr2
        swap    scr2
        move.w  scr1,scr2
        move.l  enemylist(a3),a2
        suba.l  #4,a2
.findloop
        adda.l  #4,a2
        tst.l   (a2)+
        bne     .findloop
        move.l  scr2,-4(a2)
        and.l   #31,scr0
        move.l  scr0,(a2)
        bra     .xintloop

.notenemy
        move.l  yi,scr1
        and.l   #$ff,scr1       ;Texture column.

        btst    #5,scr0         ;Is this cell a door?
        beq     .xinodoor

        tst.l   doorframe(a3)
        beq     .xinodoor

        move.l  lxcell(a4),scr2
        cmp.l   doorx(a3),scr2
        bne     .xinodoor

        move.l  lycell(a4),scr2
        cmp.l   doory(a3),scr2
        bne     .xinodoor

        move.l  doorframe(a3),scr2
        asl.l   #3,scr2
        sub.l   scr2,scr1
        bpl     .xinodoor
        bra     .xintloop       ; Map is treated as clear if ray has missed an
                                ; opening door.

.xinodoor

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
        move.l  scr0,scr4
        subq    #1,scr4
        lsl.l   #8,scr4
        move.b  scr1,scr4
        swap.w  scr4
        move.w  scr2,scr4
        move.l  scr4,(listptr)+

.xidontaddtolist
        btst    #6,scr0
        bne     .xintloop

.skipxintercepts
        clr.l   (listptr)+

