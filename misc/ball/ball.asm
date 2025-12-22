;
;            BALL         by Ed Mackey
;                            440 Louella Ave.
;                            Wayne, PA 19087

;  Here is the source code, assembled with Assempro by Abacus.
;  This is Public Domain.  Please don't change the credits, though.

       Include 'includes:IncludeMe'
       Include 'includes:intuition.offsets'
       Include 'includes:graphics.offsets'
       Include 'includes:diskfont.offsets'
       Include 'includes:dos.offsets'
       Include 'includes:iff.offsets'
       Include 'includes:exec/types.i'
       Include 'includes:exec/lists.i'
       Include 'includes:devices/audio.i'
       Include 'includes:MemVars'

       ILABEL 'Includes:Amiga.L'

       INIT_AMIGA

       bsr     run

       EXIT_AMIGA

run:
       move.l  EBase,a6
;       move.l  #Whole_Thing,d0
;       clr.l   d1
;       jsr     _LVOAllocMem(a6)  ;Some old code I got rid of
;       tst.l   d0
;       beq     MemKicked
       move.l  #MyMem,d0   ;Now in BSS segment!
       move.l  d0,MemPtr
       move.l  d0,a1
       lea     Board1,a0
       move.l  #Whole_Thing,d0
       jsr     _LVOCopyMem(a6)
       sub.l   a1,a1
       jsr     _LVOFindTask(a6)
       move.l  d0,readreply+$10
       lea     MyTask,a2
       move.l  #7,d2
PMT:   move.l  d0,(a2)
       add.l   #64,a2
       dbra    d2,PMT
       move.l  d0,a1
       move.l  #4,d0
       jsr     _LVOSetTaskPri(a6) ;Runs smoother at pri +4
       lea     readreply,a1
       jsr     _LVOAddPort(a6)
       lea     devio,a1
       move.l  #1,d0    ;timer.
       clr.l   d1
       move.l  #readreply,port
       move.w  #32,Tm_Length
       move.w  #0,io
       lea     timename,a0
       jsr     _LVOOpenDevice(a6) ;get timer.device
       tst.l   d0
       bne     TimeKicked
       bsr     openint      ;open intuition.library
       beq     IntKicked    ;uh-oh.  Where's intuition?!?!
       bsr     opendos
       beq     DosKicked    ;dos.library and graphics.library
       bsr     opengfx
       beq     GfxKicked
       move.l  EBase,a6
       lea     MsgSig,a2    ;4 signals needed for 4 voices.
       move.l  #3,d2
ASP:   move.l  #-1,d0     ;Another Signal Please!
       jsr     _LVOAllocSignal(a6)
       move.b  d0,(a2)
       add.l   #64,a2
       cmp.b   #-1,d0
       beq     SigKicked
       dbra    d2,ASP
       lea     Message,a1
       move.l  #1,d0
       clr.l   d1
       move.l  #combops,AData
       move.l  #1,Aud_Length
       move.w  #0,AllocKey
       move.l  #0,Unit
       move.w  #ADCMD_ALLOCATE,Aud_Cmd
       lea     audname,a0
       jsr     _LVOOpenDevice(a6) ;open audio.device
       tst.l   d0
       bne     AudioKickedM
       move    #-1,d0       ;init audio.device
       bsr     playme       ;with opening sound effect
       bsr     LoadScores
       clr.l   Font
       bsr     opendiskfont
       beq     DiskFontKicked
       move.l  fontbase,a6      ;look for font
       lea     TextAttr,a0
       jsr     _LVOOpenDiskFont(a6)
       move.l  d0,Font
       bsr     closediskfont
DiskFontKicked:
       bsr     openiff        ;get iff.library
       beq     IffKicked
       bsr     openscreen
       beq     Screen3Kicked  ;allocate screens for graphics & game
       move.l  d0,screen3hd
       add.l   #184,d0
       move.l  d0,bit3map
       bsr     openscreen
       beq     Screen2Kicked
       move.l  d0,screen2hd
       add.l   #184,d0
       move.l  d0,bit2map
       bsr     openscreen
       beq     ScreenKicked
       move.l  d0,screenhd
       add.l   #184,d0
       move.l  d0,bit1map
       bsr     windopen     ;make my window.
       beq     WindKicked
       move.w  #0,PaddleX
       move.l  windowhd,a0
       move.l  50(a0),a0
       move.l  a0,Rast
       move.l  screenhd,a0
       clr.l   d0
       jsr     _LVOShowTitle(a6)  ;hide title bar
       move.l  Rast,a1
       move.l  #1,d0
       move.l  gfxbase,a6
       jsr     _LVOSetAPen(a6)
       tst.l   Font
       beq     OopsNoFont
       move.l  Font,a0           ;install font, if it was there
       move.l  Rast,a1
       jsr     _LVOSetFont(a6)
OopsNoFont:
       lea     picname,a0     ;Some leftover code from the
       bsr     OpenPic        ;"old days" when the IFFs were
       beq     SpriteKicked   ;separate files on disk.
       move.l  screen2hd,d0
       bsr     pic2plane
       beq     PicKicked
       bsr     ClosePic
       lea     pic2name,a0
       bsr     OpenPic
       beq     SpriteKicked
       move.l  screen3hd,d0
       bsr     pic2plane
       beq     PicKicked
       bsr     ClosePic
       move.l  intbase,a6
       move.l  windowhd,a0
       lea     blkptr,a1
       move.l  #1,d0
       move.l  d0,d1
       clr.l   d2
       clr.l   d3
       jsr     _LVOSetPointer(a6)  ;Get rid of that mouse pointer!
       move.l  windowhd,a0
       jsr     _LVOViewPortAddress(a6)  ;Why did I do this?
       move.l  d0,ViewPort
       move.l  d0,a0
       move.l  gfxbase,a6
       move.l  #32,d0
       lea     ftable,a1
       move.l  a1,a3
ZZZ:   move    #0,(a3)+        ;Start black, then call FadeIn later.
       cmp.l   #ftable+32,a3
       bne     ZZZ
       jsr     _LVOLoadRGB4(a6)
       move.l  #5,d0
       lea     ballsprite,a0
       jsr     _LVOGetSprite(a6)  ;Let's get some sprites!
       cmp.w   #-1,d0
       bne     spOK
       move.l  #-1,d0
       lea     ballsprite,a0
       jsr     _LVOGetSprite(a6)
       cmp.w   #-1,d0
       beq     SpriteKickedM
spOK:  move.l  #-1,d0
       lea     Las1Sprite,a0
       jsr     _LVOGetSprite(a6)
       cmp.w   #-1,d0
       beq     Las1KickedM
       move.l  #-1,d0
       lea     Las2Sprite,a0
       jsr     _LVOGetSprite(a6)
       cmp.w   #-1,d0
       beq     Las2KickedM
       lea     devio,a1    ;first timer message.
       move.w  #$9,Tm_Cmd
       move.l  #0,secs
       move.l  #16000,msecs
       move.l  #readreply,port
       move.w  #40,Tm_Length
       move.w  #0,io
       move.l  EBase,a6
       jsr     _LVOSendIO(a6)
       clr     d7
NewGame:                       ;Main title screen
       move    d7,-(sp)
       bsr     clrscr
       move.l  MemPtr,a0
       lea     Board1,a1
       move.l  #Whole_Thing,d0
       move.l  EBase,a6
       jsr     _LVOCopyMem(a6)  ;restore boards that were
       move.l  MemPtr,a0        ;destroyed during previous game
       lea     Pl2Boards,a1
       move.l  #Whole_Thing,d0
       jsr     _LVOCopyMem(a6)  ;and for player 2's boards
       move.l  Rast,a1
       clr.l   d0
       move.l  #29,d1
       move.l  gfxbase,a6
       jsr     _LVOMove(a6)
       move.l  #end_title2 - title2,d0
       lea     title2,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)
       move.l  Rast,a1
       clr.l   d0
       move.l  #76,d1           ;put up a bunch of titles
       jsr     _LVOMove(a6)
       move.l  #end_instr - instr,d0
       lea     instr,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)
       move.l  Rast,a1
       clr.l   d0
       move.l  #86,d1
       jsr     _LVOMove(a6)
       move.l  #end_instr2 - instr2,d0
       lea     instr2,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)
       move.l  Rast,a1
       clr.l   d0
       move.l  #56,d1
       jsr     _LVOMove(a6)
       move.l  #end_Al - Al,d0
       lea     Al,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)
       move.l  #18,d2
       move.l  #10,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       move.l  #173,d0
       move.l  #152,d1
       move.l  #143,d4
       move.l  #31,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)  ;get that logo on there
       clr     dx
       move.w  #104,dy
       move.l  #BonusCoords+4,a5
NextBonus:
       clr.l   d0
       clr.l   d1
       clr.l   d2
       clr.l   d3
       move.w  dx,d2
       move.w  dy,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       move.w  (a5)+,d0
       move.w  (a5)+,d1
       move.l  #16,d4
       move.l  #14,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       jsr     _LVOBltBitMap(a6)  ;show the bonuses
       tst.w   dx
       bne     Ych
       move.w  #160,dx
       bra     Zch
Ych:   clr.w   dx
       add.w   #15,dy
Zch:   cmp.l   #end_BonusCoords,a5
       bne     NextBonus
       move.l  intbase,a6
       move.l  Rast,a0
       lea     BonusDescribe,a1
       move.l  #20,d0
       move.l  #107,d1
       jsr     _LVOPrintIText(a6) ;show the names of the bonuses
       bsr     FadeIn
       clr     You_Cheated
       clr     You_Cheated2       ;clear some flags
       bsr     DumpMsgs
       move    (sp)+,d7
       cmp.b   #'2',d7
       beq     Auto2
       clr.l   d7
TryMsgAgain:
       move.l  windowhd,a0
       move.l  86(a0),a0
       move.l  EBase,a6
       jsr     _LVOWaitPort(a6)    ;wait for message.
GetMsgAgain:
       move.l  windowhd,a0
       move.l  86(a0),a0
       move.l  EBase,a6
       jsr     _LVOGetMsg(a6)    ;read in the message.
       tst.l   d0
       beq     PlayGame
       move.l  d0,a5
       move.l  20(a5),d6
       move.l  d6,d0
       and.l   #$200000,d0   ;User press a key?    (TITLE SCREEN)
       cmp.l   #0,d0
       beq     NotKey
       move.b  25(a5),d0
       cmp.b   #'Q',d0       ;Was it, 'Q'?
       bne     NotQu
       move    #-1,d7
       bra     Rep2
NotQu: cmp.b   #'2',d0       ;Was it, '2' for 2-Player game?
       bne     NotKey
       moveq   #2,d7
       move    #2,PlayerUp
       bra     Rep2
NotKey:
       move.l  d6,d0
       and.l   #$8,d0
       cmp.l   #0,d0
       beq     Rep2
       addq    #1,d7
       clr     PlayerUp
Rep2:  move.l  a5,a1
       move.l  EBase,a6
       jsr     _LVOReplyMsg(a6)
       bra     GetMsgAgain
Auto2:
       moveq   #2,d7
       move    #2,PlayerUp
PlayGame:
       cmp     #-1,d7
       beq     ende
       cmp     #2,d7
       bne     TryMsgAgain
       bsr     FadeOut        ;OK!  Let's play this thing
       clr     You_Looped
       clr     You_Looped2
       clr.w   CurrentBoard
       clr.w   CurrentBoard2
       clr.l   P2Offset
       move.w  #3,LivesLeft    ;have some lives, why don't you
       move.w  #3,LivesLeft2
       tst     PlayerUp
       bne     NP2U4
       move    #-1,LivesLeft2  ;(unless you're not playing, P2!)
NP2U4: clr.l   Score
       clr.l   Score2
       move.l  screenhd,a4
       move.w  $12(a4),d2
       mulu    #279,d2
       divu    #319,d2
       cmp.w   #2,d2
       bge     w1ok
       move.l  #2,d2
w1ok:  cmp.w   #275,d2
       ble     w2ok
       move.l  #275,d2
w2ok:  sub.w   #2,d2
       move.w  d2,PaddleX
       subq.w  #4,CurrentBoard
       subq.w  #4,CurrentBoard2
DrawBoard:
       clr     cylx        ;draw a nice board
       clr     cyly
       clr     cyln
       bsr     clrscr
       tst     PlayerUp
       ble     OnePGame
       clr.l   d1
       move    PlayerUp,d1
       cmp     #-1,LivesLeft2
       beq     OPL                ;switch players?
       move    CurrentBoard,d0
       move    CurrentBoard2,CurrentBoard
       move    d0,CurrentBoard2
       move    You_Cheated,d0
       move    You_Cheated2,You_Cheated
       move    d0,You_Cheated2
       move    You_Looped,d0
       move    You_Looped2,You_Looped
       move    d0,You_Looped2
       move    LivesLeft,d0
       move    LivesLeft2,LivesLeft
       move    d0,LivesLeft2
       move.l  Score,d0
       move.l  Score2,Score
       move.l  d0,Score2
       move.l  #Pl2Boards,d0
       sub.l   #Board1,d0
       move.l  d0,P2Offset
       cmp     #2,PlayerUp
       bne     P2U1
       clr.l   P2Offset
P2U1:  move.l  #3,d1
       sub     PlayerUp,d1
       move    d1,PlayerUp
OPL:   mulu    #29,d1
       sub     #28,d1
       move.l  #220,d0      ; D1: #1 = Player 1, #30 = Player 2
       move.l  #116,d2
       move.l  #86,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       move.l  #88,d4
       move.l  #28,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       jsr     _LVOBltBitMap(a6)  ;Tell user: Player 1 or 2??
       bsr     DumpMsgs
       bsr     FadeIn
       clr     d7
       bsr     tloop             ;Wait for mouse button
       bsr     FadeOut
       move.l  gfxbase,a6
       clr.l   d0
       move.l  Rast,a1
       jsr     _LVOSetRast(a6)
OnePGame:
       and     #$7fff,PlayerUp
       addq.w  #4,CurrentBoard
       lea     BoardList,a5
       clr.l   d0
       move.w  CurrentBoard,d0
       move.l  (a5,d0),a5
       cmp.l   #0,a5
       bne     DBok
       move.l  MemPtr,a0
       lea     Board1,a1
       cmp     #2,PlayerUp
       bne     NP2U1
       lea     Pl2Boards,a1
NP2U1: move.l  #Whole_Thing,d0
       move.l  EBase,a6
       jsr     _LVOCopyMem(a6)  ;If player loops all the way
       addq    #1,You_Looped    ;around, restore his boards,
       clr.w   CurrentBoard     ;place on board 1, and
       lea     Board1,a5        ;start handing out the funny <?>s!
DBok:  move.l  a5,d0
       add.l   P2Offset,d0
       move.l  d0,a5
       add.l   #420,d0
       move.l  d0,End_Board
       move    CurrentBoard,DeathRecover
       subq    #4,DeathRecover
       clr.l   d0
       clr.l   d1
       clr.l   d2
       clr.l   d3
       clr.l   d5
       move.w  #0,BlocksLeft
       move.l  gfxbase,a6
       move.w  #0,dx
       move.w  #8,dy
NextBlock:
       clr.l   d4
       move.b  (a5)+,d4
       tst.b   d4
       beq     NoBlk
       cmp.b   #6,d4
       blt     BC1
       addq.w  #2,BlocksLeft
BC1:   cmp.b   #5,d4
       bge     BC2
       addq.w  #1,BlocksLeft
BC2:   mulu    #4,d4
       lea     BlockCoords,a0
       move.w  0(a0,d4),d0
       move.w  2(a0,d4),d1
       move.w  dx,d2
       move.w  dy,d3
       move.l  bit2map,a0
       move.l  bit1map,a1
       move.w  #16,d4
       move.w  #7,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       jsr     _LVOBltBitMap(a6)  ;get them blocks on there
NoBlk: move.w  dx,d2
       add.w   #16,d2
       cmp.w   #320,d2
       blt     NBdxOK
       clr.w   d2
       addq.w  #7,dy
NBdxOK:move.w  d2,dx
       cmp.l   End_Board,a5
       bne     NextBlock
WarpIn:
       move    #3,d0
       bsr     playme
       bsr     showscore      ;make a cool sound and fade in the
       bsr     FadeIn         ;cool board.
       lea     WarpInList,a5
       clr     Got_Catch
       clr     Got_Laser
       clr     Got_Brick
       clr     Got_Grav
       clr     Got_Expand
       move.w  #41,Paddle_Size
       move.w  #19,Stuck
       move.w  #1,dx
       move.w  #-1,dy
       move.w  #4,spx
       move.w  #5,spy
       move.w  #1,cx
       move.w  #1,cy
       move.w  #0,SCount
       move.l  #7,BallSpeed
WarpInCont:
       lea     devio,a1
       move.l  EBase,a6
       jsr     _LVOWaitIO(a6)
       lea     devio,a1
       move.w  #$9,Tm_Cmd
       move.l  #0,secs
       move.l  #66668,msecs     ;Warp-in speed.
       move.l  #readreply,port
       move.w  #40,Tm_Length
       move.w  #0,io
       move.l  EBase,a6
       jsr     _LVOSendIO(a6)
       move.l  #187,d3
       clr.l   d2
       move.w  PaddleX,d2
       move.l  bit2map,a0
       move.l  bit1map,a1
       move.l  #17,d0
       move.l  #34,d1
       move.l  #44,d4
       move.l  #12,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)  ;do the "cool" warp-in thingie
       move.l  Rast,a0
       move.l  screenhd,a4
       move.w  $12(a4),d2
       mulu    #279,d2
       divu    #319,d2
       cmp.w   #2,d2
       bge     w3ok
       move.l  #2,d2
w3ok:  cmp.w   #275,d2
       ble     w4ok
       move.l  #275,d2
w4ok:  sub.w   #2,d2
       move.w  d2,PaddleX
       move.l  #187,d3
       move.l  bit2map,a0
       move.l  bit1map,a1
       clr.l   d0
       clr.l   d1
       move.w  (a5)+,d0
       move.w  (a5)+,d1
       move.l  #44,d4
       move.l  #12,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6) ;erase your tracks
       cmp.l   #end_list,a5
       bne     WarpInCont
       move.l  EBase,a6
ExMsg: move.l  windowhd,a0
       move.l  86(a0),a0
       jsr     _LVOGetMsg(a6)    ;dump any leftover messages.
       tst.l   d0
       beq     fixpaddle   ;prepare the paddle.  branches to "loop"
       move.l  d0,a1
       jsr     _LVOReplyMsg(a6)
       bra     ExMsg
loop:
       cmp     #-5,Lasy1
       ble     NoML1
       clr.l   d0
       clr.l   d1
       move    Lasx1,d0
       move    Lasy1,d1
       subq    #7,d1
       move.l  d0,d2
       move.l  d1,d3
       addq    #1,d2
       bsr     FB2
       beq     NoHL1
       move.w  #-5,d1
NoHL1: move.l  ViewPort,a0
       lea     Las1Sprite,a1
       move.l  gfxbase,a6
       jsr     _LVOMoveSprite(a6)   ;move those lasers
NoML1  cmp     #-5,Lasy2
       ble     NoML2
       clr.l   d0
       clr.l   d1
       move    Lasx2,d0
       move    Lasy2,d1
       subq    #7,d1
       move.l  d0,d2
       move.l  d1,d3
       addq    #1,d2
       bsr     FB2
       beq     NoHL2
       move.w  #-5,d1
NoHL2: move.l  ViewPort,a0
       lea     Las2Sprite,a1
       move.l  gfxbase,a6
       jsr     _LVOMoveSprite(a6)  ;both of them
NoML2: tst.b   cyln
       beq     NoC
       cmp.w   #184,cyly
       bge     KilCyl
       addq.w  #1,cyly
       bsr     DrawCyl          ;Bonuses are also called
       cmp.w   #176,cyly        ;"cylenders" because that's
       blt     NoC              ;what they looked like
       move.w  cylx,d0          ;in Arkanoid.
       move.w  PaddleX,d1
       add.w   #15,d0
       cmp.w   d0,d1
       bgt     NoC
       sub.w   #15,d0
       sub.w   Paddle_Size,d0
       cmp.w   d0,d1
       blt     NoC
       clr.l   d3
       move.b  cyln,d3    ;BINGO!!!  Caught a cylender!
       add.l   #10,Score
       movem.l d0-a6,-(sp)
       bsr     ShowScore  ;show your new & improved score
       move    #6,d0
       bsr     playme
       movem.l (sp)+,d0-a6
       mulu    #4,d3
       lea     CodeTable,a3  ;find out what the cyl does
       move.l  (a3,d3),a2
       jmp     (a2)
CodeTable:
       dc.l    Cyl_Null,Cyl_Slow,Cyl_Kill,Cyl_Break,Cyl_Life,Cyl_Laser
       dc.l    Cyl_Expand,Cyl_Grav,Cyl_Brick,Cyl_Catch,Cyl_RemInde
Cyl_Slow:
       clr     Got_Grav
       cmp.l   #5,BallSpeed
       ble     KilCyl
       sub.l   #4,BallSpeed
       bra     KilCyl
Cyl_Kill:
       bra     YourDead    ;Simple enough!
Cyl_Break:
       add.l   #40,Score
       or      #$8000,PlayerUp
       bsr     FadeOut
       bra     DrawBoard
Cyl_Life:
       addq.w  #1,LivesLeft
       bsr     ShowScore
       clr     Got_Catch
       clr     Got_Brick
       clr     Got_Laser
       cmp     #-1,Stuck
       beq     NStk2
       move    d0,-(sp)
       move    #8,d0
       bsr     playme
       move    (sp)+,d0
       move.w  #-1,Stuck
NStk2: clr     Got_Grav
       bra     KilCyl
Cyl_Laser:
       move    #1,Got_Laser
       bra     KilCyl
Cyl_Expand:
       cmp.w   #2,Got_Expand
       bge     KilCyl
       addq.w  #1,Got_Expand
       move.w  Paddle_Size,d0
       mulu    #2,d0
       move.w  d0,Paddle_Size
       cmp     #-1,Stuck
       beq     KilCyl
       move    d0,-(sp)
       move    #8,d0
       bsr     playme
       move    (sp)+,d0
       move.w  #-1,Stuck
       bra     KilCyl
Cyl_Grav:
       move    #1,Got_Grav
       bra     KilCyl
Cyl_Brick:
       move    #1,Got_Brick
       bra     KilCyl
Cyl_Catch:
       move    #1,Got_Catch
       bra     KilCyl
Cyl_RemInde:
       clr     ddx       ;this one is actually a bit complicated!
       clr     ddy
CRI2:  move.w  ddx,d2
       move.w  ddy,d3
       mulu    #20,d3
       add.l   d3,d2
       move.l  #BoardList,d3
       add.w   CurrentBoard,d3
       move.l  d3,a3
       move.l  (a3),d3
       add.l   P2Offset,d3
       move.l  d3,a3
       clr.l   d3
       move.b  (a3,d2),d3
       cmp.b   #5,d3
       blt     CRInxt
       cmp.b   #5,d3
       bne     CRI3
       clr.b   d3
       bra     CRI4
CRI3:  move.b  #3,d3
       subq.w  #1,BlocksLeft
CRI4:  move.b  d3,(a3,d2)
       mulu    #4,d3
       lea     BlockCoords,a0
       move.w  0(a0,d3),d0
       move.w  2(a0,d3),d1
       move.w  ddx,d2
       mulu    #16,d2
       move.w  ddy,d3
       mulu    #7,d3
       add.w   #8,d3
       move.l  bit2map,a0
       move.l  bit1map,a1
       move.w  #16,d4
       move.w  #7,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)  ;fix those inde blocks
CRInxt:addq.w  #1,ddx
       cmp.w   #20,ddx
       blt     CRI5
       clr     ddx
       addq.w  #1,ddy
CRI5:  cmp.w   #21,ddy
       blt     CRI2
Cyl_Null:
KilCyl:bsr     EraseCyl  ;erase the cyl you just caught
       clr     cyly
       clr     cylx
       clr     cyln
       bra     fixpaddle  ;and patch you up
NoC:   cmp.w   #-1,Stuck
       bne     NoAcelBall
       move.l  BallSpeed,d7
       addq.w  #1,SCount
       cmp.w   #400,SCount      ;Ball Accelleration.
       blt     NoSped
       clr.w   SCount
       addq.l  #1,BallSpeed
NoSped:move.l  #0,d6
BalLop:bsr     MoveBall
       cmp     #0,d6
       bne     YourDead     ;oops...  you dropped it!
       dbra    d7,BalLop
       bsr     UpDateBall
       tst.w   BlocksLeft
       ble     NewBoard
       cmp.w   #-1,Stuck
       bne     fixpaddle
NoAcelBall:
       lea     devio,a1
       move.l  EBase,a6
       jsr     _LVOWaitIO(a6)
       lea     devio,a1
       move.w  #$9,Tm_Cmd
       move.l  #0,secs
       move.l  #16667,msecs
       move.l  #readreply,port
       move.w  #40,Tm_Length
       move.w  #0,io
       move.l  EBase,a6
       jsr     _LVOSendIO(a6)    ;wonderful timing doohickie
       move.l  #0,d7
loop2:
       move.l  windowhd,a0
       move.l  86(a0),a0
       jsr     _LVOGetMsg(a6)    ;read in the message.
       tst.l   d0
       bne     ReadMsg
       cmp     #0,d7
       beq     loop
       btst    #1,d7
       bne     AbortGame
       btst    #3,d7
       bne     Pause
       btst    #4,d7
       bne     SelfDest   ;Thank you for pressing
       btst    #2,d7      ;the Self-Destruct Button!
       bne     fixpaddle
       bra     loop
ende:
       bsr     FadeOut    ;Fun Finish For Fade Fans! (FFFFF)
       lea     devio,a1
       move.l  EBase,a6         ;we're leaving the whole prog here
       jsr     _LVOWaitIO(a6)
       clr.l   d0
       move.w  SpL2n,d0
       move.l  gfxbase,a6
       jsr     _LVOFreeSprite(a6)  ;return all allocated resources
Las2Kicked:
       move.w  SpL1n,d0
       move.l  gfxbase,a6
       jsr     _LVOFreeSprite(a6)  ;in the opposite order
Las1Kicked:
       move.w  spnum,d0
       move.l  gfxbase,a6
       jsr     _LVOFreeSprite(a6)  ;that they were allocated in.
SpriteKicked:
       bsr     windclose
WindKicked:
       move.l  screenhd,a0
       bsr     closescreen
ScreenKicked:
       move.l  screen2hd,a0
       bsr     closescreen
Screen2Kicked:
       move.l  screen3hd,a0
       bsr     closescreen
Screen3Kicked:
       bsr     closeiff      ;get rid of all this stuff
IffKicked:
       tst.l   Font
       beq     FontKicked
       move.l  gfxbase,a6    ;we don't need this font anymore
       move.l  Font,a1
       jsr     _LVOCloseFont(a6)
FontKicked:
       move.l  EBase,a6
       move.l  #3,d2
Ab:    move    d2,d0
       mulu    #68,d0
       lea     othermessages,a2
       add.l   d0,a2
       move.l  a2,a1
       jsr     _LVOAbortIO(a6)   ;get rid of our audio.device
       move.l  a2,a1
       jsr     _LVOWaitIO(a6)
       dbra    d2,Ab
       move.l  #15,Unit
       lea     Message,a1
       jsr     _LVOCloseDevice(a6)
AudioKicked:
       move    #-1,d2
SigKicked:
       cmp     #3,d2
       beq     SigsFree
       addq    #1,d2
       move    #3,d0
       sub     d2,d0       ;free up these signals
       mulu    #64,d0
       lea     MsgSig,a0
       add.l   d0,a0
       clr.l   d0
       move.b  (a0),d0
       move.l  EBase,a6
       jsr     _LVOFreeSignal(a6)
       bra     SigKicked
SigsFree:
       bsr     closegfx
GfxKicked:
       tst.l   ErrPtr
       beq     NoErr
       bsr     ErrWindOpen     ;tell user if error occoured
       beq     NoErr
       move.l  windowhd,a0
       move.l  86(a0),a0
       move.l  EBase,a6
       jsr     _LVOWaitPort(a6)    ;wait for message.
NextMsg:
       move.l  windowhd,a0
       move.l  86(a0),a0
       jsr     _LVOGetMsg(a6)    ;read in the message.
       tst.l   d0
       beq     NMMsgs
       move.l  d0,a1
       jsr     _LVOReplyMsg(a6)
       bra     NextMsg
NMMsgs:
       bsr     WindClose
NoErr: bsr     closedos
DosKicked:
       bsr     closeint
IntKicked:
       move.l  EBase,a6
       lea     devio,a1
       jsr     _LVOCloseDevice(a6)  ;close timer.device
       lea     readreply,a1
       jsr     _LVORemPort(a6)
TimeKicked:
;       move.l  MemPtr,a1
;       move.l  #Whole_Thing,d0
;       move.l  EBase,a6
;       jsr     _LVOFreeMem(a6)     ;more old code
MemKicked:
       rts   ;that's all folks!  We're outta here!
PicKicked:
       bsr     ClosePic
       bra     SpriteKicked
SpriteKickedM:
       move.l  #no_sprites,ErrPtr
       bra     SpriteKicked
Las1KickedM:
       move.l  #no_sprites,ErrPtr   ;some little patches
       bra     Las1Kicked
Las2KickedM:
       move.l  #no_sprites,ErrPtr   ;for telling the user about errors
       bra     Las2Kicked
AudioKickedM:
       move.l  #no_audio,ErrPtr
       bra     AudioKicked
NewBoard:
       add.l   #100,Score     ;a little patch for a new board
       bsr     FadeOut
       or      #$8000,PlayerUp
       bra     DrawBoard
clrscr:                     ;Clear the screen!
       clr.l   d0           ;Affects d0,d1,a0,a1,a6 only.
       clr.l   d1
       move.w  #-4,d0
       move.w  #-4,d1
       move.l  gfxbase,a6
       move.l  ViewPort,a0
       lea     ballsprite,a1
       jsr     _LVOMoveSprite(a6)  ;Yank ball off screen
       clr.l   d0
       move.l  Rast,a1
       jsr     _LVOSetRast(a6)     ;Clear bitmap
       clr.l   d0
       clr.l   d1
       move.w  #-5,d1
       move.l  gfxbase,a6
       move.l  ViewPort,a0
       lea     Las1Sprite,a1
       jsr     _LVOMoveSprite(a6)  ;Yank laser off screen
       clr.l   d0
       clr.l   d1
       move.w  #-5,d1
       move.l  ViewPort,a0
       lea     Las2Sprite,a1
       jsr     _LVOMoveSprite(a6)  ;Yank other laser off screen
       rts
EOGmessage:                  ;End-Of-Game messages for user
       bsr     clrscr
       cmp     #2,PlayerUp
       bne     NoFixP
       move    You_Cheated,d0
       move    You_Cheated2,You_Cheated
       move    d0,You_Cheated2
       move.l  Score,d0
       move.l  Score2,Score
       move.l  d0,Score2
NoFixP:lea     end_ScoreList,a5
       tst     You_Cheated
       beq     NCH1
       clr.l   Score
NCH1:  tst     You_Cheated2
       beq     NCH2
       clr.l   Score2
NCH2:  clr.l   d0
       clr     Mark1
       clr     Mark2
       move.w  -(a5),d0
       move.l  Score,d6
       move.l  #0,d7
       cmp.l   d6,d0
       blt     HighScore
       move.l  Score2,d6
       move    #1,d7
       cmp.l   d6,d0
       blt     HighScore
       move.l  #6,d0
       move.l  #169,d1
       move.l  #95,d2
       move.l  #20,d3
       move.l  bit2map,a0
       move.l  bit1map,a1
       move.l  #129,d4
       move.l  #28,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)  ;"Final Scores" message.
       move.l  #220,d0
       move.l  #1,d1
       move    #71,d2
       move    #72,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       move    #88,d4
       move    #57,d5
       jsr     _LVOBltBitMap(a6)  ;PLAYER 1 & 2
       move    #28,d5
       move.l  Score,d0
       lea     TexBuf,a5
       bsr     PrtNum
       move.l  Rast,a1
       move.l  a5,d3
       sub.l   #TexBuf,d3
       move.l  #187,d0
       move.l  #89,d1
       jsr     _LVOMove(a6)
       move.l  d3,d0
       lea     TexBuf,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)
       tst     PlayerUp
       beq     NoS2
       move.l  Score2,d0
       lea     TexBuf,a5
       bsr     PrtNum
       move.l  Rast,a1
       move.l  a5,d3
       sub.l   #TexBuf,d3
       move.l  #187,d0
       move.l  #118,d1
       jsr     _LVOMove(a6)
       move.l  d3,d0
       lea     TexBuf,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)
NoS2:  tst     You_Cheated
       beq     NoP1C
       move.l  #220,d0
       move.l  #59,d1
       move    #161,d2
       move    #72,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       jsr     _LVOBltBitMap(a6)  ;Tell Player 1: CHEATER!!
NoP1C: tst     You_Cheated2
       beq     NoP2C
       move.l  #220,d0
       move.l  #59,d1
       move    #161,d2
       move    #101,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       jsr     _LVOBltBitMap(a6)  ;Tell Player 2: CHEATER!!
NoP2C: bsr     DumpMsgs
       bsr     FadeIn
       clr     d7
       bsr     tloop             ;Wait for mouse button / key
       move    d7,-(sp)
       bsr     FadeOut
       move    (sp)+,d7
       cmp.b   #'2',d7
       beq     NewGame
HiScr: bsr     clrscr
       move.l  #136,d0
       move.l  #169,d1
       move.l  #95,d2
       move.l  #10,d3
       move.l  bit2map,a0
       move.l  bit1map,a1
       move.l  #129,d4
       move.l  #28,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)  ;"High Scores" message.
       tst     Mark2
       beq     NFM
       move    Mark1,d0
       cmp     Mark2,d0
       blt     NFM
       addq    #1,Mark1
       cmp     #15,Mark1
       ble     NFM
       clr     Mark1
NFM:   tst     Mark1
       beq     NHi1
       move.l  #87,d0
       move.l  #176,d1
       move    #235,d2
       move    Mark1,d3
       mulu    #10,d3
       add     #38,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       move    #42,d4
       move    #11,d5
       jsr     _LVOBltBitMap(a6)  ;Highlight Player 1's score
NHi1:  tst     Mark2
       beq     NHi2
       move.l  #87,d0
       move.l  #188,d1
       move    #235,d2
       move    Mark2,d3
       mulu    #10,d3
       add     #38,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       move    #42,d4
       move    #11,d5
       jsr     _LVOBltBitMap(a6)  ;Highlight Player 2's score
NHi2:  move.l  Rast,a1
       clr.l   d0
       jsr     _LVOSetDrMd(a6)
       lea     ScoreList,a4
       move.l  #14,d6
       move.l  #56,d7
NexNam:lea     texbuf,a5
       move.l  #19,d3
NexLet:move.b  (a4)+,(a5)+
       dbra    d3,NexLet
       move.l  #'    ',(a5)+
       clr.l   d0
       move.w  (a4)+,d0
       bsr     PrtNum
       move.l  a5,d3
       sub.l   #TexBuf,d3
       move.l  Rast,a1
       move.l  #44,d0
       move.l  d7,d1
       add.l   #10,d7
       jsr     _LVOMove(a6)
       move.l  d3,d0
       lea     TexBuf,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)
       dbra    d6,NexNam
       move.l  Rast,a1
       move.l  #1,d0
       jsr     _LVOSetDrMd(a6)
       bsr     DumpMsgs
       bsr     FadeIn
       clr     d7
       bsr     tloop             ;Wait for mouse button / key
       move    d7,-(sp)
       bsr     FadeOut
       move    (sp)+,d7
       bra     NewGame
HighScore:   ;d6 = Score, d7 = Player (0=1, 1=2), a5 = pointer
       lea     Mark1,a0
       tst     d7
       beq     HS1a
       lea     Mark2,a0
HS1a:  and.l   #$ffff,d6
       move    #15,(a0)
       sub.l   #20,a5
       lea     end_ScoreList,a4
HS1:   move.w  -(a5),d0
       cmp.l   d6,d0
       bge     HS3
       subq    #1,(a0)
       move    d0,-(a4)
       move.l  #9,d5
HS2:   move    -(a5),-(a4)
       dbra    d5,HS2
       bra     HS1
HS3:   move    d6,-(a4)
       addq.l  #2,a5
       clr     Cpos
       move.l  d7,-(sp)
       move.l  a5,-(sp)
       mulu    #29,d7
       addq    #1,d7
       move.l  d7,d1
       move.l  #220,d0
       move.l  #116,d2
       move.l  #20,d3
       move.l  bit3map,a0
       move.l  bit1map,a1
       move.l  #88,d4
       move.l  #28,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)
       move.l  Rast,a1
       clr.l   d0
       move.l  #65,d1
       jsr     _LVOMove(a6)
       move.l  #end_ScrMsg-ScrMsg,d0
       lea     ScrMsg,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)
       clr.l   d0
       move.l  #75,d1
       move.l  Rast,a1
       jsr     _LVOMove(a6)
       move    #'>_',TexBuf
       move.l  Rast,a1
       move.l  #2,d0
       lea     TexBuf,a0
       jsr     _LVOText(a6)
       bsr     FadeIn
       bsr     DumpMsgs
       move.l  (sp)+,a5
GetL:  clr     d7          ;Enter your name!
       bsr     tloop       ;You're on the list!
       cmp.b   #8,d7
       bne     NotD
       tst     Cpos
       beq     NotD
       subq    #1,Cpos
       move.l  Rast,a1
       move.l  #75,d1
       move    Cpos,d0
       mulu    #8,d0
       addq    #8,d0
       move.l  gfxbase,a6
       jsr     _LVOMove(a6)
       lea     texbuf,a0
       move.l  #2,d0
       move.l  Rast,a1
       move    #'_ ',(a0)
       jsr     _LVOText(a6)
       subq.l  #1,a5
       bra     GetL
NotD:  cmp.b   #13,d7
       beq     DoneName
       cmp.b   #10,d7
       beq     DoneName
       cmp     #32,d7
       blt     GetL
       cmp     #127,d7
       blt     HS4
       cmp     #160,d7
       blt     GetL
HS4:   cmp     #20,Cpos   ;Not enough room
       bge     GetL
       move.l  gfxbase,a6
       move.l  Rast,a1
       move.l  #75,d1
       move    Cpos,d0
       mulu    #8,d0
       addq    #8,d0
       jsr     _LVOMove(a6)
       move.l  #2,d0
       lea     texbuf,a0
       move.l  Rast,a1
       move.b  #'_',1(a0)
       move.b  d7,(a5)+
       move.b  d7,(a0)
       jsr     _LVOText(a6)
       addq    #1,Cpos
       bra     GetL
DoneName:
       cmp     #20,Cpos
       bge     Dok
       addq    #1,Cpos
       move.b  #32,(a5)+
       bra     DoneName
Dok:   bsr     FadeOut
       bsr     SaveScores
       bsr     clrscr
       move.l  (sp)+,d7
       tst     d7
       bne     HiScr
       lea     end_ScoreList,a5
       move.w  -(a5),d0
       move.l  Score2,d6
       move    #1,d7
       cmp.l   d6,d0
       blt     HighScore  ;Enter your name
       bra     HiScr      ;Show HighScore list
DumpMsgs:
       move.l  windowhd,a0
       move.l  86(a0),a0
       move.l  EBase,a6
       jsr     _LVOGetMsg(a6)    ;check for leftover messages.
       tst.l   d0
       beq     _rts           ;No more leftovers, look for real ones.
       move.l  d0,a1
       jsr     _LVOReplyMsg(a6)
       bra     DumpMsgs
Pause:
       move.l  windowhd,a0
       move.l  intbase,a6
       jsr     _LVOClearPointer(a6)  ;put back mouse pointer
       bsr     FadeOutGrey
       clr     d7
ploop:
       move.l  windowhd,a0
       move.l  86(a0),a0
       move.l  EBase,a6
       jsr     _LVOWaitPort(a6)    ;wait for message.
ploop2:
       move.l  windowhd,a0
       move.l  86(a0),a0
       jsr     _LVOGetMsg(a6)    ;read in the message.
       tst.l   d0
       bne     pReadMsg
       tst     d7
       beq     ploop
       bsr     FadeInGrey
       lea     ctable,a1
       move.l  #32,d0
       move.l  ViewPort,a0
       move.l  gfxbase,a6
       jsr     _LVOLoadRGB4(a6)
       move.l  windowhd,a0
       lea     blkptr,a1
       move.l  #1,d0
       move.l  d0,d1
       clr.l   d2
       clr.l   d3
       move.l  intbase,a6
       jsr     _LVOSetPointer(a6)  ;get rid of mouse pointer, again
       bsr     DumpMsgs
       bra     FixPaddle
pReadMsg:
       move.l  d0,a5
       move.l  20(a5),d6
       move.l  d6,d0
       and.l   #$200008,d0    ;User press a key?  (PAUSE MODE)
       cmp.l   #0,d0
       beq     pReply
       moveq   #1,d7
pReply:move.l  a5,a1
       jsr     _LVOReplyMsg(a6)
       bra     ploop2
tloop:
       move.l  windowhd,a0
       move.l  86(a0),a0
       move.l  EBase,a6
       jsr     _LVOWaitPort(a6)    ;wait for message.
tloop2:
       move.l  windowhd,a0
       move.l  86(a0),a0
       jsr     _LVOGetMsg(a6)    ;read in the message.
       tst.l   d0
       bne     tReadMsg
       tst     d7
       beq     tloop
       rts
tReadMsg:
       move.l  d0,a1
       move.l  20(a1),d0
       and.l   #$8,d0         ;User press a MB?  (PLAYER 1/2 SCREEN)
       tst.l   d0             ;                  (SCORES SCREEN)
       beq     tKey
       moveq   #1,d7
       bra     tReply
tKey:  move.l  20(a1),d0
       and.l   #$200000,d0    ;or a key?
       tst.l   d0
       beq     tReply
       move.b  25(a1),d7
tReply:jsr     _LVOReplyMsg(a6)
       bra     tloop2
ReadMsg:
       move.l  d0,a5
       move.l  20(a5),d6
       move.l  d6,d0
       and.l   #$200000,d0    ;User press a key?  (DURING GAME)
       cmp.l   #0,d0
       beq     NotClose
       move.b  25(a5),d0
       cmp.b   #'Q',d0        ;Was it, 'Q'?
       bne     NotQ
       bset    #1,d7
       bra     Reply
NotQ:  cmp.b   #$A9,d0        ;Was it the cheat key?   ;->
       bne     NotC1                     ;(shhh!)
       clr.l   Score
       move    #1,You_Cheated
       move    PaddleX,cylx
       add     #12,cylx
       move    #175,cyly
       move.b  #3,cyln
       bra     Reply
NotC1: cmp.b   #$B6,d0        ;Was it the OTHER cheat key??
       bne     NotC2                       ; 8->    (!!)
       clr.l   Score
       move    #1,You_Cheated
       move    #1,Got_Laser
       move    #1,Got_Brick
       move    #1,Got_Catch
       clr     Got_Grav
       move    PaddleX,cylx
       add     #12,cylx
       move    #175,cyly
       move.b  #10,cyln
       bra     Reply
NotC2: cmp.b   #27,d0         ;Was it ESC?
       bne     NotC3
       bset    #3,d7
       bra     Reply
NotC3: cmp.b   #$7f,d0        ;Was it DEL?
       bne     NotC4
       bset    #4,d7
       bra     Reply
NotC4: or.b    #'a'-'A',d0    ;Was it 'p' or 'P'?
       cmp.b   #'p',d0
       bne     NotClose
       bset    #3,d7
       bra     Reply
NotClose:
       move.l  d6,d0
       and.l   #$80000,d0
       tst.l   d0
       beq     NotInAct
       bset    #3,d7
NotInAct:
       move.l  d6,d0
       and.l   #$100010,d0
       tst.l   d0
       beq     NotFix
       bset    #2,d7
NotFix:
       move.l  d6,d0
       and.l   #$8,d0
       tst.l   d0
       beq     NotLetGo
       cmp.w   #-1,Stuck
       beq     NotStk
       move    d0,-(sp)
       move    #8,d0
       bsr     playme      ;release the ball from paddle
       move    (sp)+,d0
       move.w  #-1,Stuck
NotStk:bset    #2,d7
       tst     Got_Laser
       beq     NotLetGo
       movem.l d0-a6,-(sp)
       clr     d7
       tst     Lasy1
       bge     NoL1
       clr.l   d0
       move    #7,d7
       move.w  PaddleX,d0
       subq.w  #1,d0
       move.l  #181,d1
       move.l  gfxbase,a6
       move.l  ViewPort,a0
       lea     Las1Sprite,a1
       jsr     _LVOMoveSprite(a6)  ;shoot that laser!
NoL1:  tst     Lasy2
       bge     NoL2
       clr.l   d0
       move    #7,d7
       move.w  PaddleX,d0
       add.w   Paddle_Size,d0
       subq.w  #4,d0
       move.l  #181,d1
       move.l  gfxbase,a6
       move.l  ViewPort,a0
       lea     Las2Sprite,a1
       jsr     _LVOMoveSprite(a6)  ;shoot that other laser!
NoL2:  tst     d7
       beq     NoL12
       tst     Got_Brick
       bne     Hefty      ;Sound effect for laser depends on
       move    #10,d7     ;Brickthrough or not
Hefty: move    d7,d0          ;Hefty Hefty Hefty! Wimpy Wimpy Wimpy!!
       bsr     playme
NoL12: movem.l (sp)+,d0-a6
NotLetGo:
       bra     Reply
MoveBall:
       cmp.w   #-1,Stuck
       bne     ok5
       clr.l   d0
       clr.l   d1
       move.w  sx,d0
       move.w  sy,d1
       move.w  cx,d2
       subq.w  #1,d2
       move.w  d2,cx
       tst.w   d2
       bne     ok2
       add.w   dx,d0
       move.w  spx,cx
       clr.l   d4
       bsr     CheckBlock  ;did I hit something?  Duh...
       bne     Nok3
       cmp.w   #0,d0
       bgt     ok1
       move.w  #1,dx
       move    d0,-(sp)
       move    #9,d0
       bsr     playme
       move    (sp)+,d0
ok1:   cmp.w   #315,d0
       blt     ok2
       move    d0,-(sp)
       move    #9,d0
       bsr     playme
       move    (sp)+,d0
       move.w  #-1,dx
       bra     ok2
Nok3:  move.w  sx,d0
       neg.w   dx
ok2:   move.w  cy,d2
       subq.w  #1,d2
       move.w  d2,cy
       tst.w   d2
       bne     ok4
       add.w   dy,d1
       tst     Got_Grav
       beq     NoGrv
       movem.l d0-d1,-(sp)   ;silly gravity math
       move.w  #15,d0
       muls    #14,d1        ;(needs a lot of work, probably)
       divs    #200,d1
       sub     d1,d0         ;(follows no laws of physics!)
       move    d0,cy
       movem.l (sp)+,d0-d1
       bra     Grv
NoGrv: move.w  spy,cy
Grv:   clr.l   d4
       addq    #1,d4
       bsr     CheckBlock
       bne     Nok4
       cmp.w   #0,d1
       bgt     ok3
       move    d0,-(sp)
       move    #9,d0
       bsr     playme
       move    (sp)+,d0
       move.w  #1,dy
       bra     ok3
Nok4:  move.w  sy,d1
       neg.w   dy
ok3:   cmp.w   #186,d1
       bge     chkx
ok3b:  cmp.w   #196,d1
       blt     ok4
       move.w  #-1,dy
       move.l  #1,d6
ok4:   move.w  d0,sx
       move.w  d1,sy
ok5:   rts
UpDateBall:
       clr.l   d0
       clr.l   d1
       move.w  sx,d0
       move.w  sy,d1
       move.l  gfxbase,a6
       move.l  ViewPort,a0
       lea     ballsprite,a1
       jsr     _LVOMoveSprite(a6)  ;show ball's new position
       rts
Reply:
       move.l  a5,a1
       move.l  EBase,a6
       jsr     _LVOReplyMsg(a6)
       bra     Loop2
chkx:
       cmp.w   PaddleX,d0
       blt     ok3b
       clr.l   d2
       move.w  PaddleX,d2
       add.w   Paddle_Size,d2
       subq.w  #1,d2
       cmp.w   d2,d0
       bgt     ok3b
       move.w  dy,d2
       tst     d2
       ble     ok3b    ;Paddle: Don't bounce ball down!
       neg.w   dy
       move.w  d0,d2
       sub.w   PaddleX,d2
       tst     Got_Catch
       beq     NoCat
       move.l  d0,-(sp)
       clr     d0
       bsr     playme
       move.l  (sp)+,d0
       move.w  d2,Stuck       ;Catch feature.  Play the catch sound!
       bra     NoCatb
NoCat: move.l  d0,-(sp)
       move    #8,d0
       bsr     playme         ;Play the "Bonk" sound if you
       move.l  (sp)+,d0       ;can't catch the ball.
NoCatb:clr.l   d3
       move.w  Paddle_size,d3
       divu    #2,d3
       sub.w   d3,d2
       tst     d2
       bge     NoExt
       swap    d2
       move    #$ffff,d2
       swap    d2
NoExt: cmp     #1,Got_Expand
       bne     NoE3
       divs    #2,d2
NoE3:  cmp     #2,Got_Expand
       bne     NoE4
       divs    #4,d2
NoE4:  move.w  #1,dx
       tst.w   d2
       bge     NoAbs
       neg.w   d2
       neg.w   dx
NoAbs: and.l   #$ffff,d2
       clr.l   d3
       mulu    #3,d2
       divu    #5,d2
       move.w  #12,d3
       sub.w   d2,d3
       cmp.w   #3,d2
       bge     Notd20
       move.w  #3,d2
Notd20:move.w  d2,spy
       cmp.w   #2,d3
       bge     Notd30
       move.w  #2,d3
Notd30:move.w  d3,spx
       bra     ok4
CheckBlock:           ;Check if ball or laser hit something.
       clr.l   d2
       clr.l   d3
       move.w  d0,d2
       move.w  d1,d3
       tst     d4
       bne     FB1
       cmp.w   #1,dx
       bne     FB2
       addq.w  #3,d2
       bra     FB2
FB1:   cmp.w   #1,dy
       bne     FB2
       addq.w  #3,d3
FB2:   cmp.w   #155,d3  ;Laser hit starts here.
       bge     ok8
       cmp.w   #8,d3
       blt     ok8
       divu    #16,d2
       move.w  d2,ddx
       subq.w  #8,d3
       divu    #7,d3
       move.w  d3,ddy
       mulu    #20,d3
       add.l   d3,d2
       move.l  #BoardList,d3
       add.w   CurrentBoard,d3
       move.l  d3,a3
       move.l  (a3),d3
       add.l   P2Offset,d3
       move.l  d3,a3
       move.l  #BonusList,d3
       add.w   CurrentBoard,d3
       move.l  d3,a4
       move.l  (a4),a4
       clr.l   d3
       move.b  (a3,d2),d3
       tst.b   d3
       beq     _rts    ;Nothing here!  Just get to an RTS, any RTS.
       move.l  d0,-(sp)     ;<\
       move    #4,d0        ;  \
       cmp.b   #5,d3        ;   \
       bge     NB1b         ;    \
       clr.b   d3           ;     \
       move    #1,d0        ;      Stack Stuff!  Keep Together!!
       bra     NB1          ;     /
NB1b:  tst     Got_Brick    ;    /     (playing a sound)
       bne     NB1a         ;   /
NB1:   bsr     playme       ;  /
NB1a:  move.l  (sp)+,d0     ;</
       cmp.b   #5,d3
       ble     NB2
       move.b  #3,d3
NB2:   move.b  d3,(a3,d2)
       cmp.b   #5,d3
       beq     ok88
       move.l  d2,-(sp)
       move.l  BallSpeed,d2
       add.l   d2,Score
       move.l  (sp)+,d2
       subq.w  #1,BlocksLeft
       tst.b   d3      ;Multi-hit blocks don't release cyl's.
       bne     NB3
       tst.b   cyln
       bne     NB3
       move.b  (a4,d2),cyln
       move.w  ddx,d2
       mulu    #16,d2
       move.w  d2,cylx
       move.w  ddy,d2
       mulu    #7,d2
       add.w   #8,d2
       move.w  d2,cyly
NB3:   movem.l d0-d7/a0-a6,-(sp)
       mulu    #4,d3
       lea     BlockCoords,a0
       move.w  0(a0,d3),d0
       move.w  2(a0,d3),d1
       move.w  ddx,d2
       mulu    #16,d2
       move.w  ddy,d3
       mulu    #7,d3
       add.w   #8,d3
       move.l  bit2map,a0
       move.l  bit1map,a1
       move.w  #16,d4
       move.w  #7,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)  ;erase block, or put new one in place
       bsr     ShowScore          ;show new score
       movem.l (sp)+,d0-d7/a0-a6
ok88:  clr.l   d3
       move    Got_Brick,d3  ;Should we tell main prog we hit a
       xor     #1,d3         ;block?  Not if we have Brickthrough!!
       tst     d3
       rts
ok8:   move    #0,d3
       tst     d3
       rts
PrtNum:            ;PRTNUM -> ;Convert word integer to printable ASCII.
       move.l  #10000,d1      ;d0 = word to convert
Prt2:  divu    d1,d0          ;a5 = pointer to ASCII text buffer
       add     #$30,d0                        ;(i.e. TexBuf)
       move.b  d0,(a5)+
       clr     d0             ;d1 will be erased and used as scratch
       swap    d0
       divu    #10,d1         ;Leading zeros will be output:
       tst     d1             ; so $00A0 becomes 00160, etc.
       bne     Prt2
       rts                    ;End of PrtNum!  Now that didn't hurt,
ShowScore:                    ;did it?
       move.l  Score,d0
       lea     TexBuf,a5
       move.l  #' Sco',(a5)+  ;It says, " Score: ".
       move.l  #'re: ',(a5)+  ;Isn't this CUTE????
       bsr     PrtNum
       move.b  #' ',(a5)+
       move.l  #' Liv',(a5)+  ;Guess what it says now!
       move.l  #'es: ',(a5)+
       clr.l   d0
       move.w  LivesLeft,d0
       move.l  #10,d1
       bsr     Prt2
       move.l  Rast,a1
       clr.l   d0
       move.l  #7,d1
       move.l  gfxbase,a6
       jsr     _LVOMove(a6)
       move.l  #24,d0
       lea     TexBuf,a0
       move.l  Rast,a1
       jsr     _LVOText(a6)    ;show the dude his score.
       rts
DrawCyl:
       movem.l d0-d7/a0-a6,-(sp)
       clr.l   d0
       clr.l   d1       ;show one of these bonus thingies.
       clr.l   d2
       clr.l   d3
       clr.l   d4
       move.w  cylx,d2
       move.w  cyly,d3
       subq.w  #1,d3
       move.b  cyln,d4
       lea     BonusCoords,a5
       mulu    #4,d4
       move.w  (a5,d4),d0
       move.w  2(a5,d4),d1
       subq.w  #1,d1
       tst     You_Looped
       beq     NoQues
       cmp     #1,You_Looped
       bgt     Ques
       cmp     #155,cyly
       bgt     NoQues
Ques:  move    #243,d0     ;silly goofy <?> cyl.
       move    #131,d1
NoQues:move.l  bit3map,a0
       move.l  bit1map,a1
       move.l  #16,d4
       move.l  #15,d5   ;Cyl must be drawn at cyly - 1.
       move.l  #$c0,d6    ;(so it can erase its tracks!)
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6) ;draw it.
       clr.l   d2
       clr.l   d3
       move.w  cyly,d3
       sub.w   #16,d3  ;8 above: 7 for block, 1 for erase line.
       divu    #7,d3
       swap    d3
       tst     d3
       bne     NoRedr
       swap    d3
       cmp     #21,d3
       bgt     NoRedr
       mulu    #20,d3       ;If cyl passes over a block, we
       move.w  cylx,d2      ;must find out what was there
       divu    #16,d2       ;and put it back.
       and.l   #$ffff,d2
       add.l   d3,d2
       move.l  #BoardList,d3
       add.w   CurrentBoard,d3
       move.l  d3,a3
       move.l  (a3),d3
       add.l   P2Offset,d3
       move.l  d3,a3
       clr.l   d3
       move.b  (a3,d2),d3
       tst.b   d3
       beq     NoRedr
       mulu    #4,d3
       lea     BlockCoords,a0
       move.w  (a0,d3),d0
       move.w  2(a0,d3),d1
       move.w  cylx,d2
       move.w  cyly,d3
       subq.w  #8,d3
       move.l  bit2map,a0
       move.l  bit1map,a1
       move.w  #16,d4
       move.w  #7,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       jsr     _LVOBltBitMap(a6)  ;we found out, now draw it!
NoRedr:movem.l (sp)+,d0-d7/a0-a6
       rts
EraseCyl:
       movem.l d0-d7/a0-a6,-(sp)
       clr.l   d2
       clr.l   d3
       move.w  cylx,d2         ;get rid of an un-needed cyl
       move.w  cyly,d3         ;from screen.
       move.l  #142,d0
       move.l  #154,d1
       move.l  bit3map,a0
       move.l  bit1map,a1
       move.l  #16,d4
       move.l  #14,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)
       movem.l (sp)+,d0-d7/a0-a6
       rts
AbortGame:
       clr     LivesLeft
SelfDest:
       move    #5,d0
       bsr     Playme  ;Boy, do I love this sound effect!
       bra     YDNS
YourDead:
       move    #2,d0
       bsr     playme
YDNS:  move.l  #183,d3
       clr.l   d2
       clr.l   d4
       move.w  PaddleX,d2
       move.w  #320,d1
       sub.w   Paddle_Size,d1
       cmp.w   d1,d2
       ble     Yup2
       move.w  d1,d2
Yup2:  move.l  bit2map,a0
       move.l  bit1map,a1
       move.l  #17,d0
       move.l  #34,d1
       move.w  Paddle_Size,d4
       move.l  #15,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6) ;erase you!
       move.l  #183,d3
       move.l  Rast,a0
       move.l  screenhd,a5
       move.w  $12(a5),d2
       mulu    #279,d2
       divu    #319,d2
       move.w  d2,PaddleX
       bsr     WarpOut
       cmp.w   #0,LivesLeft
       beq     GameOver
       subq.w  #1,LivesLeft
       move.w  DeathRecover,CurrentBoard
       subq    #1,d1
       subq    #2,d3
       addq    #2,d5
BlowEmUpRealGood:     ;He blew up.  Yeah, he blew up good.  Yeah, he
       addq    #1,d3  ;blew up REAL GOOD!!!!
       subq    #1,d5
       movem.l d0-d7,-(sp)
       lea     devio,a1
       move.l  EBase,a6
       jsr     _LVOWaitIO(a6)
       lea     devio,a1
       move.w  #$9,Tm_Cmd
       move.l  #0,secs
       move.l  #16667,msecs
       move.l  #readreply,port
       move.w  #40,Tm_Length
       move.w  #0,io
       jsr     _LVOSendIO(a6)
       move.l  bit3map,a0
       move.l  bit1map,a1
       move.l  gfxbase,a6
       move.l  a7,a5          ;Check this move out.  I peek at
       movem.l (a5)+,d0-d7    ;what's on the stack without touching it!
       jsr     _LVOBltBitMap(a6)   ;<=- and now I'm blowing you up!
       movem.l (sp)+,d0-d7
       cmp     #1,d5
       bgt     BlowEmUpRealGood
       bsr     FadeOut
       jmp     DrawBoard
GameOver:                  ;You be dead.
       lea     devio,a1
       move.l  EBase,a6
       jsr     _LVOWaitIO(a6)
       lea     devio,a1
       move.w  #$9,Tm_Cmd
       move.l  #2,secs      ;Ending seconds.
       move.l  #0,msecs
       move.l  #readreply,port
       move.w  #40,Tm_Length
       move.w  #0,io
       move.l  EBase,a6
       jsr     _LVOSendIO(a6)
       lea     devio,a1
       move.l  EBase,a6
       jsr     _LVOWaitIO(a6)  ;wait for 'em.
       lea     devio,a1
       move.w  #$9,Tm_Cmd
       move.l  #0,secs      ;reset timer.
       move.l  #16667,msecs
       move.l  #readreply,port
       move.w  #40,Tm_Length
       move.w  #0,io
       move.l  EBase,a6
       jsr     _LVOSendIO(a6)
       bsr     FadeOut
       subq    #1,LivesLeft
       tst     LivesLeft2
       bge     DrawBoard
       bra     EOGmessage
WarpOut:                 ;WarpOut, i.e. BOOM!
       lea     WarpOutList,a5
WarpOutLoop:
       lea     devio,a1
       move.l  EBase,a6
       jsr     _LVOWaitIO(a6)
       lea     devio,a1
       move.w  #$9,Tm_Cmd
       move.l  #0,secs
       move.l  #66668,msecs     ;Warp-out speed.
       move.l  #readreply,port
       move.w  #40,Tm_Length
       move.w  #0,io
       move.l  EBase,a6
       jsr     _LVOSendIO(a6)
       clr.l   d2
       move.w  PaddleX,d2
       move.l  bit3map,a0
       move.l  bit1map,a1
       clr.l   d0
       clr.l   d1
       clr.l   d4
       clr.l   d5
       move.w  (a5)+,d0  ;src x
       move.w  (a5)+,d1  ;src y
       move.w  (a5)+,d4  ;size x
       move.w  (a5)+,d5  ;size y
       move.l  d4,d6
       sub.w   #40,d6
       divu    #2,d6
       move.l  #198,d3
       sub.w   d5,d3
       sub.w   d6,d2
       btst    #15,d2
       beq     Out2ok
       clr.l   d2
Out2ok:move.l  #320,d7
       sub.w   d4,d7
       cmp.w   d7,d2
       blt     Out1ok
       move.l  d7,d2
Out1ok:move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       movem.l d0-d7,-(sp)
       jsr     _LVOBltBitMap(a6)  ;some nice flames on the screen
       move.l  a5,d0
       clr.l   d1
       move    LivesLeft,d1
       cmp     #4,d1
       ble     ZipZip
       move    #6,d1
ZipZip:mulu    #8,d1
       add.l   d1,d0
       move.l  d0,a4
       movem.l (sp)+,d0-d7
       cmp.l   #end_out_list,a4
       bne     WarpOutLoop
       rts
fixpaddle:                ;move and redraw paddle
       move.l  #183,d3
       clr.l   d2
       clr.l   d4
       move.w  PaddleX,d2
       move.w  #320,d1
       sub.w   Paddle_Size,d1
       cmp.w   d1,d2
       ble     Yup
       move.w  d1,d2
Yup:   move.l  bit2map,a0
       move.l  bit1map,a1
       move.l  #17,d0
       move.l  #34,d1
       move.w  Paddle_Size,d4
       move.l  #15,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       move.l  gfxbase,a6
       jsr     _LVOBltBitMap(a6)  ;erase old paddle
       move.l  #183,d3
       move.l  Rast,a0
       move.l  screenhd,a5
       move.w  $12(a5),d2
       move.w  #320,d1
       sub.w   Paddle_Size,d1
       mulu    d1,d2
       divu    #319,d2
       move.w  d2,PaddleX
       move.l  bit2map,a0
       move.l  bit1map,a1
       clr.l   d4                 ;computing new position
       move.l  #269,d0
       move.l  #88,d1
       cmp.w   #1,Got_Expand
       bne     NoE1
       move.w  #182,d0
NoE1:  cmp.w   #2,Got_Expand
       bne     NoE2
       move.w  #10,d0
NoE2:  tst     Got_Laser
       beq     NoLas
       move.w  #138,d1
NoLas: cmp.w   #-1,Stuck
       beq     NoCach
       sub.w   #16,d1
NoCach:move.w  Paddle_Size,d4
       move.l  #15,d5
       move.l  #$c0,d6
       move.l  #$ff,d7
       jsr     _LVOBltBitMap(a6)  ;draw new paddle
       cmp.w   #-1,Stuck
       beq     loop
       move.l  ViewPort,a0
       lea     ballsprite,a1
       clr.l   d0
       move.w  PaddleX,d0
       add.w   Stuck,d0
       move.l  #186,d1
       jsr     _LVOMoveSprite(a6)  ;move ball, if stuck to paddle
       bra     loop
FadeInGrey:
       move.l  #$0,d7      ;Now:  some fading routines!
       move.l  #1,d6
       move    #$333,d5
       move    #$d,a5
       bra     FO1
FadeOutGrey:
       move.l  #$c,d7
       move.l  #-1,d6
       move    #$333,d5
       move.l  #-1,a5
       bra     FO1
FadeIn:
       move.l  #$0,d7
       move.l  #1,d6
       clr     d5
       move    #$10,a5
       bra     FO1
FadeOut:
       move.l  #$f,d7
       move.l  #-1,d6
       clr     d5
       move.l  #-1,a5
FO1:   lea     ctable,a3
       lea     ftable,a4
       move    (a3)+,(a4)+  ;Leave color 0 alone.
FO2:   move    (a3)+,d2
       move    d2,d1
       move    d1,d0
       and     #$00f,d0
       and     #$0f0,d1
       and     #$f00,d2
       mulu    d7,d0
       divu    #$f,d0
       mulu    d7,d1
       divu    #$f,d1
       mulu    d7,d2
       divu    #$f,d2
       and     #$00f,d0
       and     #$0f0,d1
       and     #$f00,d2
       or      d0,d1
       or      d1,d2
       add     d5,d2
       move    d2,(a4)+
       cmp.l   #ftable+64,a4
       bne     FO2
       move.l  gfxbase,a6
       move.l  #32,d0
       move.l  ViewPort,a0
       lea     ftable,a1
       jsr     _LVOLoadRGB4(a6)  ;Fade away!
       lea     devio,a1
       move.l  EBase,a6
       jsr     _LVOWaitIO(a6)
       lea     devio,a1
       move.w  #$9,Tm_Cmd
       move.l  #0,secs
       move.l  #50001,msecs     ;Fade in/out speed.
       move.l  #readreply,port
       move.w  #40,Tm_Length
       move.w  #0,io
       move.l  EBase,a6
       jsr     _LVOSendIO(a6)
       add     d6,d7
       cmp     d7,a5
       bne     FO1
       rts
playme:                            ;Sound # in d0
       movem.l d0/d1/a0-a2/a6,-(sp)
       cmp     #-1,d0
       beq     FirstAudio        ;Main sound-playing routine
       move    d0,-(sp)
       mulu    #2,d0
       lea     sVoiceTable,a0           ;find out which voice for sound
       move    (a0,d0),d0
       mulu    #68,d0
       lea     othermessages,a2
       add.l   d0,a2
       move.l  EBase,a6
       tst     Self_Sound
       bne     WSS
       move.l  a2,a1
       jsr     _LVOAbortIO(a6)
WSS:   move.l  a2,a1
       jsr     _LVOWaitIO(a6)
       move    (sp)+,d0
       bra     AudOK
FirstAudio:
       move.l  #68,d0   ;68*4/4=68
       lea     othermessages,a2
Fab:   clr.l   (a2)+
       dbra    d0,Fab;ulous
       lea     Message,a2
       move    #3,d0
AudOK: move.w  #CMD_WRITE,Aud_Cmd-Message(a2)
       move.b  #ADIOF_PERVOL,Aud_Flags-Message(a2)
       clr     Self_Sound
       cmp     #5,d0
       bne     NSSS
       move    #1,Self_Sound
NSSS:  mulu    #4,d0
       lea     saddrTable,a0            ;find sound's address
       move.l  (a0,d0),34(a2)    ;AData
       lea     slenTable,a0             ;find sound's length
       move.l  (a0,d0),d1
       bclr    #0,d1                    ;(fix length if odd!)
       move.l  d1,38(a2)         ;Aud_Length
       lea     sperTable,a0             ;find sound's period
       lsr     #1,d0
       move.w  (a0,d0),42(a2)    ;Period
       lea     Message,a0
       cmp.l   a0,a2
       beq     All4
       move.l  a2,a1
       move.l  Device,a6
       jsr     -30(a6)    ;DEV_BEGINIO     Play it!
PD:    movem.l (sp)+,d0/d1/a0-a2/a6
       rts
All4:  move.l  d2,-(sp)
       move.l  #3,d2
All4b: move    d2,d0
       move.l  #1,d1
       lsl     d0,d1
       move.l  d1,Unit
       move    d0,d1
       mulu    #68,d0
       lea     othermessages,a2
       add.l   d0,a2
       mulu    #64,d1
       lea     MsgPort,a0
       add.l   d1,a0          ;initial sound needs more init stuff
       move.l  a0,14(a2)
       add.l   #256,a0
       move.l  a0,-(sp)
       lea     Message,a0
       move.l  a2,a1
       add.l   #20,a0
       add.l   #20,a1
       move.l  #48,d0
       move.l  EBase,a6
       jsr     _LVOCopyMem(a6)
       move.l  (sp)+,a0
       move.l  a0,62(a2)
       move.l  a2,a1
       move.l  Device,a6
       jsr     -30(a6)    ;DEV_BEGINIO
       dbra    d2,All4b
       move.l  (sp)+,d2
       bra     PD
opendos:
       move.l  EBase,a6
       lea     dosname,a1
       move.l  #0,d0
       jsr     _LVOopenlibrary(a6)  ;open dos.library
       move.l  d0,dosbase
       tst.l   d0
       rts
closedos:
       move.l  EBase,a6
       move.l  dosbase,a1
       jsr     _LVOcloselibrary(a6) ;close dos.library
       rts
openint:
       move.l  EBase,a6
       lea     intname,a1
       move.l  #0,d0
       jsr     _LVOopenlibrary(a6)  ;open intuition.library
       move.l  d0,intbase
       tst.l   d0
       rts
closeint:
       move.l  EBase,a6
       move.l  intbase,a1
       jsr     _LVOcloselibrary(a6) ;close intuition.library
       rts
opengfx:
       move.l  EBase,a6
       lea     gfxname,a1
       move.l  #0,d0
       jsr     _LVOopenlibrary(a6)  ;open graphics.library
       move.l  d0,gfxbase
       tst.l   d0
       rts
closegfx:
       move.l  EBase,a6
       move.l  gfxbase,a1
       jsr     _LVOcloselibrary(a6) ;close graphics.library
       rts
opendiskfont:
       move.l  EBase,a6
       lea     DiskFontName,a1
       move.l  #0,d0
       jsr     _LVOopenlibrary(a6)  ;open diskfont.library
       move.l  d0,fontbase
       tst.l   d0
       rts
closediskfont:
       move.l  EBase,a6
       move.l  fontbase,a1
       jsr     _LVOcloselibrary(a6) ;close diskfont.library
       rts
openiff:
       move.l  EBase,a6
       lea     iffname,a1
       move.l  #0,d0
       jsr     _LVOopenlibrary(a6)  ;open iff.library
       move.l  d0,iffbase
       tst.l   d0
       bne     _rts
       move.l  #no_iff,ErrPtr
       tst.l   d0
_rts:  rts
closeiff:
       move.l  EBase,a6
       move.l  iffbase,a1
       jsr     _LVOcloselibrary(a6) ;close iff.library
       rts
LoadScores:
       move.l  dosbase,a6
       move.l  #ScoreName,d1
       move.l  #MODE_OLD,d2
       jsr     _LVOOpen(a6)
       move.l  d0,scorehd
       tst.l   d0
       beq     _rts
       move.l  #end_ScoreList-ScoreList,d3
       move.l  #ScoreList,d2
       move.l  d0,d1
       jsr     _LVORead(a6)      ;Load high score list, if available
       move.l  scorehd,d1
       jsr     _LVOClose(a6)
       rts
SaveScores:
       move.l  dosbase,a6
       move.l  #ScoreName,d1
       move.l  #MODE_NEW,d2
       jsr     _LVOOpen(a6)
       move.l  d0,scorehd
       tst.l   d0
       beq     _rts
       move.l  #end_ScoreList-ScoreList,d3
       move.l  #ScoreList,d2
       move.l  d0,d1
       jsr     _LVOWrite(a6)   ;try to save high score list
       move.l  scorehd,d1
       jsr     _LVOClose(a6)
       rts
openpic:                  ;pic name must be in a0!
       move.l  iffbase,a6
       move.l  #pic,d0
       move.l  d0,pichd
       cmp.l   #pic2name,a0
       bne     GetCol
       move.l  #pic2,d0
       move.l  d0,pichd
;       jsr     _LVOOpenIFF(a6)    ;Old stuff from when
;       move.l  d0,pichd           ;the two IFFs were separate
;       tst.l   d0                 ;files on the disk
;       bne     GetCol
;       move.l  #no_pic,ErrPtr
;       bra     IffError
GetCol:lea     ctable,a0
       move.l  d0,a1
       jsr     _LVOGetColorTab(a6)
       tst.l   d0
       bne     _rts
       move.l  #no_color,ErrPtr
       bra     IffError
closepic:
;       move.l  pichd,a1           ;more of the same
;       move.l  iffbase,a6
;       jsr     _LVOCloseIFF(a6)
       rts
pic2plane:                ;screenhd must be in d0!
       move.l  pichd,a1
       add.l   #184,d0
       move.l  d0,a0
       move.l  iffbase,a6
       jsr     _LVODecodePic(a6)
       tst.l   d0
       bne     _rts
       move.l  #no_decode,ErrPtr
       bra     IffError
IFFerror:
       move.l  iffbase,a6
       jsr     _LVOIffError(a6)
sorrybud:
       move.l  #0,d1
       tst.l   d1
       rts
openscreen:                 ;handle returned in d0.
       move.l  intbase,a6
       lea     screendef,a0
       jsr     _LVOOpenScreen(a6)
       tst.l   d0
       bne     _rts
       move.l  #no_screen,ErrPtr
       tst.l   d0
       rts
closescreen:                ;put handle in a0.
       move.l  intbase,a6
       jsr     _LVOCloseScreen(a6)
       rts
Errwindopen:
       move.l  intbase,a6
       lea     Errwinddef,a0
       jsr     _LVOopenwindow(a6)   ;make my error window.
       move.l  d0,windowhd
       tst.l   d0
       rts
windopen:
       move.l  intbase,a6
       lea     windowdef,a0
       jsr     _LVOopenwindow(a6)   ;make my window.
       move.l  d0,windowhd
       tst.l   d0
       bne     _rts
       move.l  #no_window,ErrPtr
       tst.l   d0
       rts
windclose:
       move.l  intbase,a6
       move.l  windowhd,a0
       jsr     _LVOclosewindow(a6)  ;close it.
       rts

       ;DATA section!!    (Still part of code hunk, because
       ;                   the data hunk goes in CHIP RAM!!)
timename:
       dc.b    'timer.device',0
       align
audname:
       dc.b    'audio.device',0
       align
Event:
       dc.b    0
       align
devio:
       dc.l    devio,devio
       dc.b    $20,0
       dc.l    0
port:
       dc.l    0
Tm_Length:
       dc.w    0
       dc.l    0,0  ;device,unit
Tm_Cmd:
       dc.w    0
io:
       dc.b    0,0
secs:
       dc.l    0
msecs:
       dc.l    0
readreply:
       blk.l   16,0
saddrTable:
       dc.l    s_Catch,s_Brick1,s_Exp1,s_WarpIn,s_Dink,s_ShiftQ
       dc.l    s_CylCatch1,s_Piew2,s_Bonk,s_Dink,s_Piew
slenTable:
       dc.l    ends_Catch-s_Catch,ends_Brick1-s_Brick1,ends_Exp1-s_Exp1
       dc.l    ends_WarpIn-s_WarpIn,ends_Dink-s_Dink
       dc.l    ends_ShiftQ-s_ShiftQ,ends_CylCatch1-s_CylCatch1
       dc.l    ends_Piew2-s_Piew2,ends_Bonk-s_Bonk,ends_Dink-s_Dink
       dc.l    ends_Piew-s_Piew
sperTable:   ;3579546/Saples_per_sec
       dc.w    167,334,428,428,428,390,214,600,334,284,214
sVoiceTable:
       dc.w    3,0,2,2,0,2,1,3,3,0,3    ;Voice Choice Table
CombOps:
       dc.b    15,0
Signal:
       dc.l    0
MsgPort:
       blk.b   15,0
MsgSig:
       dc.b    0
MyTask:
       blk.b   48,0
otherports:
       blk.b   64*7,0
Message:
       dc.l    0,0
       dc.b    $20,0
       dc.l    0
       dc.l    MsgPort
MsgLn: dc.w    68       ;Length
Device:
       dc.l    0
Unit:
       dc.l    0
Aud_Cmd:
       dc.w    0
Aud_Flags:
       dc.b    0
Aud_Error:
       dc.b    0
AllocKey:
       dc.w    0
AData:
       dc.l    0  ;body of sound
Aud_Length:
       dc.l    0  ;length of sound in bytes
Period:
       dc.w    0  ;period of sound
Volume:
       dc.w    64
Cycles:
       dc.w    1
WriteMsg:
       dc.l    0,0
       dc.b    0,0
       dc.l    0
       dc.l    otherports+192
       dc.w    20
screendef:
       dc.w    0,0,320,200,5
       dc.b    3,2
       dc.w    $2,15
       dc.l    0,title,0,0
windowdef:
       dc.w    0,0,320,200
       dc.b    0,1
       dc.l    $780018,$4031B40,0,0,0  ;Flag $40 = SIMPLE_REFRESH.
screenhd:dc.l  0,0
       dc.w    0,0,0,0,15     ;rest of windowdef
Errwinddef:
       dc.w    50,90,500,10
       dc.b    3,2
       dc.l    $200,$100e,0,0
ErrPtr:dc.l    0,0,0
       dc.w    0,0,0,0,1   ;rest of Errwinddef
no_iff:
       dc.b    "Error: Can't find LIBS:iff.library",0
no_pic:
       dc.b    "Error: Can't load BALL1.IFF & BALL2.IFF",0
no_sprites:
       dc.b    "Error: Can't allocate three sprites.",0
no_decode:
       dc.b    'Error: DecodePic() failed, IFF is invalid.',0
no_color:
       dc.b    'Error: GetColorTab() failed, IFF is invalid.',0
no_audio:
       dc.b    "Error: Can't open audio.device",0
no_screen:
       dc.b    "Error: Can't open custom screen",0
no_window:
       dc.b    "Error: Can't open main window",0
ScrMsg:
       dc.b    'WOW!  What a score!!  Type your name:'
end_ScrMsg:
       align
title:
       dc.b    '  >> BALL <<  by Ed Mackey',0
       align
title2:
       dc.b    '                     by Ed Mackey'
end_title2:
       align
instr:
       dc.b    ' Press mousebutton for one player,'
end_instr:
       align
instr2:
       dc.b    ' "2" for two, or SHIFT-Q to exit.'
end_instr2:
       align
Al:
       dc.b    '   Graphics by Al Mackey.'
end_Al:
       align
BonusDescribe:
       dc.b    12,0,1,0
       dc.w    0,0
       dc.l    0,asc1,tex2
asc1:
       dc.b    'Slow ball',0
       align
tex2:
       dc.b    9,0,1,0
       dc.w    160,0
       dc.l    0,asc2,tex3
asc2:
       dc.b    'Kill (you)',0
       align
tex3:
       dc.b    12,0,1,0
       dc.w    0,15
       dc.l    0,asc3,tex4
asc3:
       dc.b    'Next board',0
       align
tex4:
       dc.b    12,0,1,0
       dc.w    160,15
       dc.l    0,asc4,tex5
asc4:
       dc.b    'Free life',0
       align
tex5:
       dc.b    12,0,1,0
       dc.w    0,30
       dc.l    0,asc5,tex6
asc5:
       dc.b    'Lasers',0
       align
tex6:
       dc.b    26,0,1,0
       dc.w    160,30
       dc.l    0,asc6,tex7
asc6:
       dc.b    'Expand paddle',0
       align
tex7:
       dc.b    9,0,1,0
       dc.w    0,45
       dc.l    0,asc7,tex8
asc7:
       dc.b    'Gravity ball',0
       align
tex8:
       dc.b    12,0,1,0
       dc.w    160,45
       dc.l    0,asc8,tex9
asc8:
       dc.b    'Brickthrough',0
       align
tex9:
       dc.b    12,0,1,0
       dc.w    0,60
       dc.l    0,asc9,tex10
asc9:
       dc.b    'Catch ball',0
       align
tex10:
       dc.b    12,0,1,0
       dc.w    160,60
       dc.l    0,asc10,0
asc10:
       dc.b    'Remove Indestruct',0
       align
NameLength = 20     ;Use Cpos for Cursor Position when entering name.
       dc.w    -1 ;Marks top-of-scorelist.
ScoreList:
       dc.b    'BALL                ',0,200
       dc.b    'BALL    By          ',0,150
       dc.b    'BALL     Ed         ',0,100
       dc.b    'BALL      Mackey    ',0,50
       dc.b    'BALL                ',0,25
       dc.b    'BALL  Graphics      ',0,0
       dc.b    'BALL    By          ',0,0
       dc.b    'BALL     Al         ',0,0
       dc.b    'BALL      Mackey    ',0,0
       dc.b    'BALL                ',0,0
       dc.b    "BALL    Isn't       ",0,0
       dc.b    'BALL     that       ',0,0
       dc.b    'BALL      nice?     ',0,0
       dc.b    'BALL                ',0,0
       dc.b    'BALL                ',0,0
end_ScoreList:
WarpInList:
       dc.w    8,58, 57,58, 106,58, 154,58, 201,58, 248,58
       dc.w    8,107, 58,107, 106,107, 157,107, 203,107, 248,107
       dc.w    11,154, 59,154, 117,154, 179,154, 237,154, 17,34
end_list:
WarpOutList:   ;srcX, srcY, sizeX, sizeY
       dc.w    11,3,41,9, 59,3,41,9, 103,3,41,9, 147,3,41,9
       dc.w    9,22,56,47, 76,21,137,67, 16,100,137,67
end_out_list:
BlockCoords:
       dc.w    17,34, 206,11, 222,11, 206,18, 222,18
       dc.w    206,25, 222,25, 17,34
BonusCoords:
       dc.w    142,154, 297,102, 297,117, 297,132, 279,102, 279,117
       dc.w    279,132, 261,102, 261,117, 261,132, 243,117
end_BonusCoords:
       dc.w    0    ;Make sure label works.

       INCLUDE "Boards.include"

TextAttr:
       dc.l    FontName
       dc.w    8
       dc.b    0,0
FontName:
       dc.b    'ball.font',0
       align
ScoreName:
       dc.b    'Ball.scores',0
       align
DiskFontName:
       dc.b    'diskfont.library',0
       align
gfxname:
       dc.b    'graphics.library',0
       align
intname:
       dc.b    'intuition.library',0
       align
dosname:
       dc.b    'dos.library',0
       align
iffname:
       dc.b    'iff.library',0
       align
picname:
       dc.b    'BALL1.IFF',0
       align
pic2name:
       dc.b    'BALL2.IFF',0
       align
pic:
       IBYTES  'BALL1.IFF'
       align
pic2:
       IBYTES  'BALL2.IFF'
       align

       DATA    ;This part is all CHIP RAM stuff!!!!
blkptr:
       dc.l    0,0
ballsprite:
       dc.l    balldat
       dc.w    4
sx:    dc.w    0
sy:    dc.w    0
spnum: dc.w    -1
balldat:
       dc.w    0,0
       dc.w    %0110000000000000 , %0000000000000000
       dc.w    %1000000000000000 , %0111000000000000
       dc.w    %0011000000000000 , %1111000000000000
       dc.w    %0110000000000000 , %0110000000000000
       dc.w    0,0,0,0,0,0
Las1Sprite:
       dc.l    Las1Dat
       dc.w    5
Lasx1: dc.w    0
Lasy1: dc.w    0
SpL1n: dc.w    -1
Las1Dat:
       dc.w    0,0
       dc.w    %0100000000000000 , %0100000000000000
       dc.w    %1010000000000000 , %1110000000000000
       dc.w    %0100000000000000 , %1010000000000000
       dc.w    %1010000000000000 , %1110000000000000
       dc.w    %0100000000000000 , %0100000000000000
       dc.w    0,0,0,0,0,0
Las2Sprite:
       dc.l    Las2Dat
       dc.w    5
Lasx2: dc.w    0
Lasy2: dc.w    0
SpL2n: dc.w    -1
Las2Dat:
       dc.w    0,0
       dc.w    %0100000000000000 , %0100000000000000
       dc.w    %1010000000000000 , %1110000000000000
       dc.w    %0100000000000000 , %1010000000000000
       dc.w    %1010000000000000 , %1110000000000000
       dc.w    %0100000000000000 , %0100000000000000
       dc.w    0,0,0,0,0,0
s_Catch:
       IBYTES  'sys:audio/ballsounds/Catch.dump'
ends_catch:
       align
s_Brick1:
       IBYTES  'sys:audio/ballsounds/Brick1.dump'
ends_Brick1:
       align
s_Exp1:
       IBYTES  'sys:audio/ballsounds/Exp1.dump'
ends_Exp1:
       align
s_WarpIn:
       IBYTES  'sys:audio/ballsounds/WarpIn.dump'
ends_WarpIn:
       align
s_Dink:
       IBYTES  'sys:audio/ballsounds/Dink.dump'
ends_Dink:
       align
s_ShiftQ:
       IBYTES  'sys:audio/ballsounds/ShiftQ.dump'
ends_ShiftQ:
       align
s_CylCatch1:
       IBYTES  'sys:audio/ballsounds/CylCatch2.dump'
ends_CylCatch1:
       align
s_Piew2:
       IBYTES  'sys:audio/ballsounds/Laz-1.dump'
ends_Piew2:
       align
s_Bonk:
       IBYTES  'sys:audio/ballsounds/Bonk.dump'
ends_Bonk:
       align
s_Piew:
       IBYTES  'sys:audio/ballsounds/ES2.sd3.dump'
ends_Piew:
       align

       BSS     ;Danger: Uninitialized variable zone!
ctable:
       ds.w    64  ;More than required space, just to be sure!
ftable:
       ds.w    64
TexBuf:
       ds.b    80
Cpos:
       ds.w    1
P2Offset:
       ds.l    1
PaddleX:
       ds.w    1
CurrentBoard:
       ds.w    1
CurrentBoard2:
       ds.w    1
DeathRecover:
       ds.w    1
PlayerUp:
       ds.w    1  ;1 = Player 1, 2 = Player 2, 0 = One-Player game.
Stuck:
       ds.w    1
LivesLeft:
       ds.w    1
LivesLeft2:
       ds.w    1
Score:
       ds.l    1
Score2:
       ds.l    1
StickCounter:
       ds.w    1
BlocksLeft:
       ds.w    1
MemBlocksLeft:
       ds.w    1
You_Cheated:
       ds.w    1
You_Cheated2:
       ds.w    1
You_Looped:
       ds.w    1
You_Looped2:
       ds.w    1
Got_Catch:
       ds.w    1
Got_Laser:
       ds.w    1
Got_Brick:
       ds.w    1
Got_Grav:
       ds.w    1
Got_Expand:
       ds.w    1
Paddle_Size:
       ds.w    1
Mark1:
       ds.w    1
Mark2:
       ds.w    1
Self_Sound:
       ds.w    1
dx:
       ds.w    1
dy:
       ds.w    1
ddx:
       ds.w    1
ddy:
       ds.w    1
spx:
       ds.w    1
spy:
       ds.w    1
cx:
       ds.w    1
cy:
       ds.w    1
cylx:
       ds.w    1
cyly:
       ds.w    1
cyln:
       ds.w    1   ;Use as byte!
SCount:
       ds.w    1
BallSpeed:
       ds.l    1
Rast:
       ds.l    1
Font:
       ds.l    1
intbase:
       ds.l    1
fontbase:
       ds.l    1
dosbase:
       ds.l    1
iffbase:
       ds.l    1
pichd:
       ds.l    1
screen2hd:
       ds.l    1
screen3hd:
       ds.l    1
Scorehd:
       ds.l    1
MemPtr:
       ds.l    1
End_Board:
       ds.l    1
bit1map:
       ds.l    1
bit2map:
       ds.l    1
bit3map:
       ds.l    1
windowhd:
       ds.l    1
gfxbase:
       ds.l    1
ViewPort:
       ds.l    1
otherMessages:
       ds.b    68 * 4
Pl2Boards:
       ds.b    Whole_Thing
MyMem:
       ds.b    Whole_Thing
       END
