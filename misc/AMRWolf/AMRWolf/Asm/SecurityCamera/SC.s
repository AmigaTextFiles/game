*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: All.s                                   /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0224                                                   © - 1995 *
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
* 25.04.1996 *   The constituent routines in this file have been separated    *
*            * into several files, in preparation for the addition of code to *
*            * sense what has been hit by the player's bullets.               *
*            *                                                                *
* 17.04.1996 *   The centre ray routines are now in place, and work by filling*
*            * The ray lists with information in a different format for the   *
*            * centre ray, after all the others have been rendered.           *
*            *   This means that the contents of the centre ray can be read   *
*            * back in AMOSPro.                                               *
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
doorlist        equ     72
doory           equ     76
framecount      equ     80
objxoffset      equ     84
objyoffset      equ     88
dosky           equ     92
enemytypes      equ     96
explosionqueue  equ     100
shadetable      equ     104
nmeimagebank    equ     108

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

        move.l  enemylist(a3),a0
.enemyloop
        move.l  (a0),d0
        beq.s   .enemiesdone
        bclr    #28,4(a0)       ; Clear visible flag
        lea     16(a0),a0
        bra.s   .enemyloop
.enemiesdone

        tst.l   dosky(a3)
        beq     MainLoop

        include "SCFillBackground.s"

MainLoop
        move.l  rayangles(a3),a0
        move.l  lray(a4),d0

        move.l  iscale(a3),a1
        move.l  (a1,d0*4),lscale(a4)

        move.l  (a0,d0*4),d1
        move.l  playerangle(a3),d0
        and.w   #$fffc,d0
        add.l   d0,d0
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

        include "SCCasting.s"

        include "SCRender.s"

RenderingDone

        move.l  #63,lray(a4)
        move.l  rayangles(a3),a0
        move.l  lray(a4),d0

        move.l  iscale(a3),a1
        move.l  (a1,d0*4),lscale(a4)

        move.l  (a0,d0*4),d1
        move.l  playerangle(a3),d0
        and.w   #$fffc,d0
        add.l   d0,d0
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

        include "SCDoCentreRay.s"

        include "SCTiming.s"

        unlk    a4

        rts

TempData
        dcb.b   256,0

