CastVert

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

        ; Problem:  how to ignore this enemy if it is hidden by a wall detected
        ; in the other half of the raycasting.

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
.yfindloop
        adda.l  #4,a2
        tst.l   (a2)+
        bne     .yfindloop
        move.l  scr2,-4(a2)
        and.l   #31,scr0
        move.l  scr0,(a2)
        bra     .yintloop

.ynotenemy

        move.l  xi,scr1
        and.l   #$ff,scr1       ;Texture column.

        btst    #5,scr0         ;Is this cell a door?
        beq     .yinodoor

        tst.l   doorframe(a3)
        beq     .yinodoor

        move.l  lxcell(a4),scr2
        cmp.l   doorx(a3),scr2
        bne     .yinodoor

        move.l  lycell(a4),scr2
        cmp.l   doory(a3),scr2
        bne     .yinodoor

        move.l  doorframe(a3),scr2
        asl.l   #3,scr2
        sub.l   scr2,scr1
        bpl     .yinodoor
        bra     .yintloop       ; Map is treated as clear if ray has missed an
                                ; opening door.

.yinodoor

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

        btst    #4,scr0
        beq     .yidontanimate
        btst    #0,scr0
        bne     .yidontanimate
        add.l   animframe(a3),scr0
.yidontanimate

        tst.l   scr2
        beq     .yidontaddtolist

        and.l   #32767,scr2
        move.l  scr0,scr4
        subq    #1,scr4
        lsl.l   #8,scr4
        move.b  scr1,scr4
        swap.w  scr4
        move.w  scr2,scr4
        move.l  scr4,(listptr)+

.yidontaddtolist
        btst    #6,scr0
        bne     .yintloop

.skipyintercepts
        clr.l   (listptr)+

