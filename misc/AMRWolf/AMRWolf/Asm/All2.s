*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: CastRay.s                               /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0200                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 20.02.1996 *   Handles the number crunching required to cast rays into the  *
*            * world, and detect hits with walls and static objects.          *
*            *   Problem with static objects:  Calculation of centre of block *
*            * doesn't take into account which side we are looking at!        *
*            *   - now fixed.                                                 *
*            *                                                                *
* 21.02.1996 *   Further bug in the object code:  Columns occasionally vanish *
*            * behind the objects.  This turned out to be a bug in the zbuffer*
*            * merging routine, which couldn't cope with two transparent      *
*            * sections at the same distance.  Now fixed!                     *
*            *                                                                *
* 07.03.1996 *   Enemy rendering code added.  Every enemy in the list has to  *
*            * be checked on every column of the display.  If the enemy is    *
*            * visible, its details are inserted into the z-buffer, and it is *
*            * then rendered with everything else.  Casting is now done for   *
*            * all 128 columns in one invocation of this routine, and         *
*            * parameters are now passed in an array, rather than on a stack  *
*            *                                                                *
* 04.04.1996 *   Rare glitches removed which occured when the player had his  *
*            * back to a wall one cell away, and was standing exactly on a    *
*            * cell boundary.                                                 *
*            *                                                                *
* 06.04.1996 *   Door routines altered to allow only one door at a time.      *
*            * The routine used to apply the opening animation to *ALL* doors *
*            * not just the one being opened.                                 *
*            *                                                                *
* 12.04.1996 *   The player can no longer `see' through the south east corner *
*            * of the blocks.                                                 *
*            *                                                                *
****************************************************************-RevisionTail-*

;        machine 68020
;        opt     d+

modulusmask     =       $ffffff00

iscale          equ     0
itexture        equ     4
iback           equ     8
iscreen         equ     12
destlist        equ     16
irecord         equ     16
list1           equ     24
list2           equ     20
map             equ     28
animframe       equ     32
doorframe       equ     36
rayangles       equ     40
triglist        equ     44
yp              equ     48
xp              equ     52
playerangle     equ     56
enemylist       equ     60
depthcue        equ     64
objectbank      equ     68
doorx           equ     72
doory           equ     76

trig        equr    d7
xi      equr    d6
yi      equr    d5
scr0    equr    d4
scr1    equr    d3
scr2    equr    d2
scr3    equr    d1
scr4    equr    d0

mapptr  equr    a0
listptr equr    a1

_limit =        85
_texturesize =  64
_texturesizeb=  6
_bytesperrow=536

source  equr    a0
screen  equr    a1
b       equr    d7
column  equr    d7
c       equr    d6
xpos    equr    d6
spt     equr    d5
so      equr    d4
st      equr    d3
pix     equr    d2
depth   equr    d1
scr     equr    d0

fbc     equr    d7
fby     equr    d6
fbbank  equr    d5
fbcol   equr    d4
fbxpos  equr    d3
fbdir   equr    d2
fboffset equr    d1
fbscr   equr    d0
fbdest  equr    a0
fbsource equr    a1

localdatasize=16

lscale=-4
lray=-8
lxcell=-12
lycell=-16

Stub
;        illegal
;        move.l  a3,-(a7)
        move.l  (a3),a3
        link    a4,#-localdatasize
        move.l  #1,lray(a4)

ClearCopScreen

        move.l  iscreen(a3),fbdest
        adda.l  #100,fbdest
        move.l  iback(a3),fbsource
        move.l  #359,fbxpos
        sub.l   playerangle(a3),fbxpos
        mulu    #918,fbxpos
        divu    #360,fbxpos
        ext.l   fbxpos

        moveq   #0,fboffset
        moveq   #127,d7
        lea     TempData(pc),a2
        move.w  fbxpos,fboffset
        moveq   #2,fbdir

        cmp.w   #458,fbxpos
        ble     .ignore
        move.w  #918,fboffset
        sub.w   fbxpos,fboffset
        moveq   #-2,fbdir

.ignore
        add.w   fboffset,fboffset
.precloop

        add.w   fbdir,fboffset

        tst.w   fboffset
        bgt     .notzero
        moveq   #2,fbdir
        add.w   fbdir,fboffset
.notzero
        cmp.w   #918,fboffset
        bne     .notover
        moveq   #-2,fbdir
        add.w   fbdir,fboffset
.notover
        move.w  fboffset,(a2)+
        dbf     d7,.precloop

        moveq   #38,d6

.mainloop
        lea     TempData(pc),a2
        lea     12(fbdest),fbdest

        swap    d6
        move.w  #3,d6
        moveq   #30,d7
.bankloop
        addq.l  #4,fbdest
.xloop
        addq.l  #2,fbdest

        move.w  (a2)+,fboffset
        move.w  (fbsource,fboffset.w),(fbdest)+

        dbf     d7,.xloop
        moveq   #31,d7
        dbf     d6,.bankloop

        swap    d6

        lea     920(fbsource),fbsource
        dbf     d6,.mainloop


MainLoop

        move.l  rayangles(a3),a0
        move.l  lray(a4),d0

        move.l  iscale(a3),a1
        move.l  (a1,d0*4),lscale(a4)

        move.l  (a0,d0*4),d1
        move.l  playerangle(a3),d0
        lsl.l   #3,d0
        add.l   d0,d1
        cmp.l   #2880,d1
        blt     .dontsub
        sub.l   #2880,d1
.dontsub
        tst.l   d1
        bpl     .dontadd
        add.l   #2880,d1
.dontadd
        move.l  triglist(a3),a0
        move.l  0(a0,d1*4),trig

        move.l  map(a3),mapptr
        move.l  list1(a3),listptr

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

MergeLists
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
        btst    #30,d0
        beq     .done
        move.l  (a0)+,d0
        bra     .loop

.d1less
        tst.w   d1
        beq     .d0less
        move.l  d1,(a2)+
        btst    #30,d1
        beq     .done
        move.l  (a1)+,d1
        bra     .loop

.same
        move.l  d0,(a2)+
        tst.w   d0
        beq     .done
        btst    #30,d0
        beq     .done
        move.l  d1,(a2)+
        btst    #30,d1
        beq     .done
        move.l  (a0)+,d0
        move.l  (a1)+,d1
        bra     .loop
.done

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

Render
        tst.l   depthcue(a3)
        beq     RenderNoDC
        bra     .mainloop
.done
        move.l  lray(a4),d0
        addq    #1,d0
        move.l  d0,lray(a4)
        cmp.l   #127,d0
        ble     MainLoop

        unlk    a4

;        move.l  (a7)+,a3

        rts

.mainloop
        move.l  -(a2),d0
        beq     .done

        move.l  lscale(a4),st
        divu    d0,st
        ext.l   st

        move.l  #_texturesize,so
        move.l  itexture(a3),source

        btst    #31,d0
        beq     .wall
        move.l  objectbank(a3),source
.wall

        swap.w  d0
        moveq   #0,column
        move.b  d0,column
        lsr.b   #2,column

        and.l   #$1f00,d0
        lsl.l   #5,d0
        add.l   d0,source

        move.l  lray(a4),xpos
        move.l  iscreen(a3),screen

        asl.l   #_texturesizeb+1,column
        add.l   column,source

        move.l  xpos,scr
        lsr.w   #5,scr
        lsl.w   #2,scr
        lsl.w   #2,xpos
        adda.l  xpos,screen
        adda.l  scr,screen
        adda.l  #114,screen

        cmp.l   #$fff,st
        bgt     .done

        bsr     Scale

        bra     .mainloop

Scale
        moveq   #64,depth
        sub.w   st,depth
        bmi     ScaleNoDC
        lsr.l   #3,depth
        move.l  depth,-(a7)
        moveq   #$40,so
        lsl.l   #8,so
        lsl.l   #2,so
        divu    st,so    ; ad=16384*(s-1)/d
        ext.l   so
        lsl.l   #4,so
        move.l  #8192,b
        move.l  st,c
        sub.l   #85,c
        bmi     .skipc
        move.l  #$40,b
        lsl.l   #8,b
        mulu    c,b
        divu    st,b
        ext.l   b
        lsl.l   #4,b
        add.l   #8192,b
        moveq   #84,st
        bra     .scaleloop
.skipc
        moveq   #85,c
        sub.b   st,c
        lsr.b   #2,c
        muls    #_bytesperrow,c
        adda.l  c,screen
        subq    #1,st
.scaleloop
        move.l  b,c
        lsr.l   #8,c
        lsr.l   #6,c
        move.w  (source,c*2),pix
        beq     .dontplot

        move.l  (a7),depth
        move.b  pix,scr
        and.b   #$f,scr
        and.b   #$f0,pix
        sub.b   depth,scr
        bmi     .skipblue
        or.b    scr,pix
.skipblue
        lsl.b   #4,depth

        move.b  pix,scr
        and.w   #$f0,scr
        and.b   #$f,pix
        sub.w   depth,scr
        bmi     .skipgreen
        or.b    scr,pix
.skipgreen
        lsl.w   #4,depth

        move.w  pix,scr
        and.w   #$ff,pix
        and.w   #$f00,scr

        sub.w   depth,scr
        bmi     .skipred
        or.w    scr,pix
.skipred
.setpix
        move.w  pix,(screen)
.dontplot
        lea     _bytesperrow(screen),screen
        add.l   so,b
        dbf     st,.scaleloop
        addq    #4,a7
        rts


RenderNoDC
        bra     .mainloop
.done
        move.l  lray(a4),d0
        addq    #1,d0
        move.l  d0,lray(a4)
        cmp.l   #127,d0
        ble     MainLoop

        unlk    a4

        rts

.mainloop
        move.l  -(a2),d0
        beq     .done

        move.l  lscale(a4),st
        divu    d0,st
        ext.l   st

        move.l  itexture(a3),source

        btst    #31,d0
        beq     .wall
        move.l  objectbank(a3),source
.wall

        swap.w  d0
        moveq   #0,column
        move.b  d0,column
        lsr.b   #2,column

        and.l   #$1f00,d0
        lsl.l   #5,d0
        add.l   d0,source

        move.l  lray(a4),xpos
        move.l  iscreen(a3),screen

        asl.l   #_texturesizeb+1,column
        add.l   column,source

        move.l  xpos,scr
        lsr.w   #5,scr
        lsl.w   #2,scr
        lsl.w   #2,xpos
        adda.l  xpos,screen
        adda.l  scr,screen
        adda.l  #114,screen

        cmp.l   #$3fff,st
        bgt     .done

        bsr     ScaleNoDC

        bra     .mainloop

ScaleNoDC
        moveq   #$40,so
        lsl.l   #8,so
        lsl.l   #2,so
        divu    st,so    ; ad=16384*(s-1)/d
        ext.l   so
        lsl.l   #4,so
        move.l  #8192,b
        move.l  st,c
        sub.l   #85,c
        bmi     .skipc
        move.l  #$40,b
        lsl.l   #8,b
        mulu    c,b
        divu    st,b
        ext.l   b
        lsl.l   #4,b
        add.l   #8192,b
        moveq   #84,st
        bra     .scaleloop
.skipc
        moveq   #85,c
        sub.b   st,c
        lsr.b   #2,c
        muls    #_bytesperrow,c
        adda.l  c,screen
        subq    #1,st
.scaleloop
        move.l  b,c
        lsr.l   #8,c
        lsr.l   #6,c
        move.w  (source,c*2),pix
        beq     .dontplot
        move.w  pix,(screen)
.dontplot
        lea     _bytesperrow(screen),screen
        add.l   so,b
        dbf     st,.scaleloop
        rts

TempData
        dcb.b   256,0

