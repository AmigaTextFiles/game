****************************************************************************
*  Programme : turboMCP.asm                                                *
*  Usage     : turboMCP                                                    *
*  Version   : V0.009
*  Date      : 09.-11.09.1990 and 08.12.1990 - 02.04.1991                  *
*  Author    : Jörg Sixt                                                   *
*  Purpose   : TRON-implementation ; file under "games"                    *
*  Language  : A68K V2.41, Blink     (all PD! Isn't it wonderful?)         *
*  NOTE      : This listing isn't meant to be an example of good           *
*              programming. Shortness und speed of the code could only     *
*              be reached at the cost of clarity. Sorry!                   *
****************************************************************************

             SECTION MAIN,CODE
* ntsc/pal
WIDTH:       EQU      320
HGTNTSC:     EQU      200
HGTPAL:      EQU      256
JMPMAX:      EQU      4      ; max. pixels that can be jumped
DELMAX:      EQU      10     ; max. speed (25/50 secs betw.)
* exec
EXECBASE:    EQU      $4
ALLOCMEM:    EQU     -$C6
FREEMEM:     EQU     -$D2
OPENLIBRARY: EQU     -$228
CLOSELIBRARY: EQU    -$19E
WAITPORT:    EQU     -$180
GETMSG:      EQU     -$174
REPLYMSG:    EQU     -$17A
* dos
OPEN:        EQU     -$1E
CLOSE:       EQU     -$24
DELAY:       EQU     -$C6
MODE_OLD:    EQU      1005
* graphics
CLEAREOL:    EQU     -$2A
CLEARSCREEN: EQU     -$30
TEXT:        EQU     -$3C
SETSOFTSTYLE: EQU    -$5A
DRAWELLIPSE: EQU     -$B4
LOADRGB4:    EQU     -$C0
MOVE:        EQU     -$F0
DRAW:        EQU     -$F6
SETRGB4:     EQU     -$120
RECTFILL:    EQU     -$132
READPIXEL:   EQU     -$13E
WRITEPIXEL:  EQU     -$144
SETAPEN:     EQU     -$156
SETBPEN:     EQU     -$15C
SETDRMD:     EQU     -$162
CBUMP:       EQU     -$16E
CMOVE:       EQU     -$174
CWAIT:       EQU     -$17A
VBEAMPOS:    EQU     -$180
SCROLLRASTER: EQU    -$18C
FREEVPORTCOPLISTS: EQU -$21C
SCROLLVPORT: EQU     -$24C
UCOPPERLISTINIT: EQU -$252
* intuition
CLOSESCREEN: EQU     -$42
DISPLAYBEEP: EQU     -$60
DRAWIMAGE:   EQU     -$72
OPENSCREEN:  EQU     -$C6
RETHINKDISPLAY: EQU  -$186
* key codes
DEL:         EQU      $73
HELP:        EQU      $41
ENTER:       EQU      $79
CTRL:        EQU      $39
ESC:         EQU      $75
N8:          EQU      $83
N2:          EQU      $C3
N6:          EQU      $A1
N4:          EQU      $A5
UP:          EQU      $67
DOWN:        EQU      $65
RIGHT:       EQU      $63
LEFT:        EQU      $61
E:           EQU      $DB
X:           EQU      $9B
D:           EQU      $BB
S:           EQU      $BD
SPACE:       EQU      $7F
* register
CIA_KEY:     EQU      $BFEC01
CIA_JFIRE:   EQU      $BFE001
CIA_JOY1D:   EQU      $DFF00A
CIA_JOY2D:   EQU      $DFF00C

* OPENLIB    LibName,LibBase,Errorlabel
OPENLIB:     MACRO
             lea      \1,a1
             moveq    #0,d0
             jsr      OPENLIBRARY(a6)
             move.l   d0,\2
             beq      \3
             ENDM
* CLOSELIB   LibBase
CLOSELIB:    MACRO
             move.l   \1,a1
             jsr      CLOSELIBRARY(a6)
             ENDM
* DELSEC     1/50 secs
DELSEC:      MACRO
             move.l   Dosbase,a6
             move.l   \1,d1
             jsr      DELAY(a6)
             ENDM

* ------------------------------------------------------------------
* --                      Open Libraries                          --
* ------------------------------------------------------------------
             move.l   sp,SPbackup       ; proper WB/CLI-start
             move.l   EXECBASE,a6
             move.l   $114(a6),a1       ; Execbase->thisTask = my task
             tst.l    $AC(a1)           ; started from CLI ?
             bne      FromCLI
             lea      $5C(a1),a2        ; ptr to MsgPort
             move.l   a2,a0
             jsr      WAITPORT(a6)      ; wait and...
             move.l   a2,a0
             jsr      GETMSG(a6)        ; ...got the message
             move.l   d0,WBmsg          ; let's save the ptr

FromCLI:     OPENLIB  Dosname,Dosbase,ClosePrg
             OPENLIB  Gfxname,Gfxbase,CloseDos
             OPENLIB  Intname,Intbase,CloseInt  ; a couple of libs

             move.l   Dosbase,a6
             move.l   #Rawname,d1
             move.l   #MODE_OLD,d2
             jsr      OPEN(a6)          ; where all the chars will go to
             move.l   d0,Rawhandle
             beq      CloseLibs

* ------------------------------------------------------------------
* --                         The Menu Screen                      --
* ------------------------------------------------------------------
MainMenu:    bsr      OpenScreen
* --------------- Gadget Boxes ------------------
             move.l   Gfxbase,a6
             move.l   #47,d7
             lea      GBoxXYTab,a5   ; all the coordinates
GBLoop:      move.l   Rastport,a1
             move.w   (a5)+,d0
             jsr      SETAPEN(a6)
             move.l   Rastport,a1
             move.w   (a5)+,d0
             move.w   (a5)+,d1
             move.w   (a5)+,d2
             move.w   (a5)+,d3
             jsr      RECTFILL(a6)
             dbf      d7,GBLoop
* ---------------- Gadget Titles ----------------
             lea      GadTxtTab,a3
             move.l   #0,d4
             move.l   #3,d7
TLoop1:      move.b   #3,d0           ; titles for first row
             sub.b    d7,d0
             move.b   d0,Gadnr
             move.b   (a3)+,d4        ; get real colour
             move.l   #0,d0
             move.l   #19,d2
             move.l   #9,d3
             bsr      GTxt
             sub.w    #11,a3          ; need the same text=same ptr
             move.w   d4,d0           ; for shadow
             move.l   #18,d2
             move.l   #8,d3
             bsr      GTxt
             dbf      d7,TLoop1

             move.l   #8,d3           ; row 2-4
             move.l   #8,d7
TLoop2:      move.b   #12,d0
             sub.b    d7,d0
             move.b   d0,Gadnr
             move.l   #13,d0
             bsr      GTxt
             dbf      d7,TLoop2

             move.l   Rastport,a1
             move.l   #2,d0
             move.l   d0,d1
             jsr      SETSOFTSTYLE(a6) ; bold
             move.l   #35,d2           ; row 5
             move.l   #2,d7
TLoop3:      move.b   #15,d0
             sub.b    d7,d0
             move.b   d0,Gadnr
             move.l   #12,d0
             bsr      GTxt
             dbf      d7,TLoop3
* -------------------  Put Cursor  --------------
             move.l   Intbase,a6
             move.l   Rastport,a0
             lea      ArrowIStr,a1
             move.l   #6,d0
             move.l   #69,d1
             jsr      DRAWIMAGE(a6)
* ------------  Put Prefs to Screen  ------------
             move.w   #12,d7
PLoop:       move.b   d7,Gadnr
             bsr      PutVal2Scr
             dbf      d7,PLoop
* ------------ Write 'SCROLL' Text --------------
             lea      ScrollTxt,a5
             move.b   #0,Gadnr
TxtLoop:     move.l   Gfxbase,a6
             move.l   Rastport,a1    ; SetSoftStyle(BOLD)
             move.l   #2,d0
             move.l   d0,d1
             jsr      SETSOFTSTYLE(a6)
             move.l   Rastport,a1    ; SetAPen(1)
             move.l   #1,d0
             jsr      SETAPEN(a6)
             move.l   Rastport,a1    ; Move (80,95)
             move.w   #80,d0
             move.w   #95,d1
             jsr      MOVE(a6)
             move.l   Rastport,a1    ; Clear text line
             jsr      CLEAREOL(a6)
             move.l   Rastport,a1    ; Text(a5=Textptr,60)
             move.l   a5,a0
             move.w   #60,d0
             jsr      TEXT(a6)
             add.l    #60,a5         ; increase ptr to text
             move.l   #30,d7         ; 30x Waitloop
             tst.b    (a5)           ; end of text?
             bne      WaitLoop       ; no -> continue now
             lea      ScrollTxt,a5   ; yes-> go on with the beginning
* ---------------  Boring, Boring,... -----------
WaitLoop:    DELSEC   #6             ; ATTENTION multitasking freaks !!
             bsr      Ask            ; Don't look at this routine!
             cmp.b    #1,d0          ; (They gonna kill me..ughs..!)
             bgt      Action         ; You want to move the Cursor ?
             dbra     d7,WaitLoop
             bra      TxtLoop        ; next piece of message
* ---------- Newton: Action and Reaction  -------
Action:      tst.b    d3             ; Fire ?
             beq      MoveCursor     ; no  -> MoveCursor
             move.l   #0,d0          ; yes -> you want to change the
             move.b   Gadnr,d0       ;        prefs
             lea      PrefsTab,a0
             cmp.b    #3,d0          ; all "on/off"-Gadgets are
             bgt      1$             ; handled with this
             bchg.b   d0,(a0)
             bra      4$
1$           cmp.b    #8,d0
             bgt      2$
             sub.b    #4,d0
             bchg.b   d0,1(a0)
             bra      4$
2$           cmp.b    #12,d0         ; Here are the "Value-Gaddies"
             bgt      5$             ; e.g. speed, boxes, etc.
             lea      LimitTab,a1    ; (Is "value" the right word ?
             sub.b    #7,d0          ; How can a dictonairy be so cruel?)
             add.w    d0,a0
             sub.b    #2,d0
             lsl.b    #1,d0
             add.w    d0,a1
             move.b   (a0),d0
             add.b    #1,d0
             cmp.b    (a1),d0        ; too big ?
             ble      3$
             move.b   1(a1),d0       ; begin at 0 respect. 1
3$           move.b   d0,(a0)
4$           bsr      PutVal2Scr
             bra      WaitLoop
5$           cmp.b    #14,d0         ; last Row
             bne      7$
             lea      Bonus,a0       ; CLEAR
             move.l   #20,d0
6$           move.b   #0,(a0)+
             dbf      d0,6$
             bra      WaitLoop
7$:          jsr      CloseScr       ; CloseScreen and...
             cmp.b    #14,Gadnr
             blt      Game           ; ...play
             bgt      CloseRaw       ; ...or quit (never tested)

MoveCursor:  move.b   d2,-(sp)
             move.b   d1,-(sp)
             move.l   Gfxbase,a6       ; SetAPen for a successful Rectfill
             move.l   Rastport,a1      ; to clear Cursor
             move.b   Gadnr,d1
             move.l   #10,d0
             cmp.b    #3,d1
             ble      1$
             move.l   #7,d0
             cmp.b    #12,d1
             ble      1$
             move.l   #4,d0

1$           jsr      SETAPEN(a6)
             bsr      GetXY            ; RectFill clears old cursor
             move.w   d0,d2
             add.w    #16,d2
             move.w   d1,d3
             add.w    #11,d3
             move.l   Rastport,a1
             jsr      RECTFILL(a6)

             move.l   #0,d0            ; Calculate new Gadnr
             move.l   #0,d1
             move.b   Gadnr,d0
             lsl.b    #2,d0            ; d0=(Gadnr)*4+
             move.b   (sp)+,d1
             beq      2$
             bpl      Draw
             add.b    #1,d0
             bra      Draw
2$           add      #2,d0
             move.b   (sp)+,d1
             bpl      Draw
             add.b    #1,d0

Draw:        lea      GadDirTab,a0
             add.l    d0,a0
             move.b   (a0),Gadnr       ; Gadnr=(a0+d0)
             bsr      GetXY            ; Fetch new X/Y
             move.l   Intbase,a6       ; DrawImage(Gadnr,Arrow)
             move.l   Rastport,a0
             lea      ArrowIStr,a1
             jsr      DRAWIMAGE(a6)
             bra      WaitLoop

*------------------------------------------------
*--              local sub-routines            --
*------------------------------------------------
* -----------  Prefs-Werte -> Screen  -----------
PutVal2Scr:  bsr      GetXY           ; Gadnr -> (X/Y)
             move.l   Intbase,a6      ; And now we bring all the prefs
             move.l   Rastport,a0     ; to the screen
             lea      PrefsTab,a1     ; (don't ask me how this works,
             move.l   #0,d2        ; Thank God THAT it works)
             move.b   Gadnr,d2
             cmp.b    #3,d2          ; 0 - 3
             bgt      1$
             add.w    #110,d0
             btst.b   d2,(a1)
             bra      2$
1$           add.w    #165,d0
             cmp.b    #8,d2          ; 4 - 8
             bgt      5$
             sub.b    #4,d2
             btst.b   d2,1(a1)
2$           beq      3$
             lea      LEDonIStr,a1
             bra      4$
3$           lea      LEDoffIStr,a1
4$           jsr      DRAWIMAGE(a6)
             rts
5$           move.w   d0,-(sp)      ; 9 - 12  (save x-&y-offset)
             move.w   d1,-(sp)
             lea      BackgrIStr,a1
             jsr      DRAWIMAGE(a6) ; DrawImage(Backgr. for number-display)
             move.l   Gfxbase,a6
             move.l   Rastport,a1
             move.w   (sp)+,d1
             add.w    #8,d1
             move.w   (sp)+,d0
             jsr      MOVE(a6)     ; Move(d0,d1)
             move.l   Rastport,a1
             move.l   #13,d0
             jsr      SETAPEN(a6)  ; SetAPen(13)
             move.l   Rastport,a1
             move.l   #0,d0
             jsr      SETSOFTSTYLE(a6)
             move.l   #0,d0        ; get the decimal string
             lea      PrefsTab,a1
             move.b   -7(a1,d2.l),d0
             lea      DecTxt,a0
             bsr      ToDec
             sub.w    #2,a0
             move.l   Rastport,a1
             move.l   #2,d0
             jsr      TEXT(a6)     ; Text(decstring,2)
             rts
* -----------  Write Text on Gadgets  -----------
; a3=Txtptr   d3=delta-y   d2=delta-x   d0=colour
GTxt:        move.l   Rastport,a1
             jsr      SETAPEN(a6)
             move.l   Rastport,a1
             bsr      GetXY
             add.w    d2,d0
             add.w    d3,d1
             jsr      MOVE(a6)
             move.l   Rastport,a1
             move.l   #11,d0
             move.l   a3,a0
             jsr      TEXT(a6)
             add.w    #11,a3
             rts
* -----------  Gadnr -> Cursor-(x/y) ------------
GetXY:       move.l   #0,d0
             move.b   Gadnr,d0
             add.b    d0,d0         ; (Gadnr)*2 +
             lea      GadXYTab,a0   ; GadXYTab
             add.l    d0,a0         ; =a0
             move.b   (a0),d0
             add.w    d0,d0         ; width  = d0 = (a0)*2
             move.w   #0,d1
             move.b   1(a0),d1      ; height = d0 = 1(a0)
             rts


* ------------------------------------------------------------------
* --                      The real Game                           --
* ------------------------------------------------------------------
Game:        bsr      OpenScreen
             lea      Score,a0
             bsr      Sort         ; Sort the scores

             move.l   #0,d0        ; set round no.
             move.b   Round,d0
             lea      DecTxt,a0
             bsr      ToDec
             move.b   #32,-4(a0)
             lea      ScoreScr,a1
             move.l   -4(a0),90(a1)

             move.l   Gfxbase,a6
             lea      ScoreScr,a5
             move.l   #6,d7
1$:          move.l   Rastport,a1  ; The 3D-frames consits of
             move.w   (a5)+,d0     ; rectangles whose coordinates
             jsr      SETAPEN(a6)  ; can be found under "ScoreScr:"
             move.l   Rastport,a1
             move.w   (a5)+,d0
             move.w   (a5)+,d1
             move.w   (a5)+,d2
             move.w   (a5)+,d3
             jsr      RECTFILL(a6)
             dbf      d7,1$

             move.l   #3,d7
2$:          move.l   Rastport,a1  ; some text
             move.w   (a5)+,d0
             jsr      SETAPEN(a6)
             move.l   Rastport,a1
             move.w   (a5)+,d0
             move.w   (a5)+,d1
             jsr      MOVE(a6)
             move.l   Rastport,a1
             move.w   (a5)+,d0
             move.l   a5,a0
             add.w    d0,a5
             jsr      TEXT(a6)
             dbf      d7,2$

             lea      SortNr,a2
             lea      GadTxtTab,a3 ; this loop writes the scores
             move.l   #88,d3
             move.l   #0,d2
             move.l   #3,d7
3$:          move.w   (a2)+,d2
             move.l   #0,d0
             move.b   d2,d0
             add.b    d2,d0
             add.b    d2,d0
             add.b    d0,d0
             lea      0(a3,d0.w),a5
             move.l   Rastport,a1
             move.b   (a5)+,d0
             jsr      SETAPEN(a6)  ; Set the accurate colour
             move.l   Rastport,a1
             move.l   #96,d0
             add.l    #9,d3
             move.l   d3,d1
             jsr      MOVE(a6)     ; Everythging must be in rank & file
             lea      PlayerTxt,a4
             move.b   #'0'+4,(a4)  ; the player's no. -> PlayerTxt
             sub.b    d7,(a4)
             add.w    #4,a4
             move.l   #10,d1
4$:          move.b   (a5)+,(a4)+  ; player's name=device -> PlayerTxt
             dbf      d1,4$
             lea      13(a4),a0
             lea      Bonus,a5
             move.l   #0,d0
             move.w   0(a5,d2.w),d0
             bsr      ToDec        ; Bonus -> PlayerTxt
             lea      23(a4),a0
             lea      Score,a5
             move.l   #0,d0
             move.w   0(a5,d2.w),d0
             bsr      ToDec        ; Score -> PlayerTxt
             lsr.w    #1,d2
             lea      34(a4),a0
             lea      Victory,a5
             move.l   #0,d0
             move.b   0(a5,d2.w),d0
             bsr      ToDec        ; Victories -> PlayerTxt
             move.l   Rastport,a1
             lea      PlayerTxt,a0
             move.l   #54,d0
             jsr      TEXT(a6)     ; Write PlayerTxt
             dbf      d7,3$
             move.b   PrefsTab,SavPMask ; initialize SavPMask
SWaitLoop:   DELSEC   #6                ; Wait
             bsr      Ask               ; (I know this is bad style,
             tst.b    d3                ; but have YOU ever tried to
             bne      BuildScr          ; programme devices?)
             cmp.b    #ESC,CIA_KEY
             bne      SWaitLoop
             jsr      CloseScr
             bra      MainMenu

BuildScr:    jsr      CloseScr          ; Close prevous Screen
             lea      GameScrStr,a0     ; and open the game screen
             lea      PrefsTab,a5
             move.w   #0,12(a0)
             move.w   #WIDTH,4(a0) ; WIDTH
             btst.b   #3,1(a5)     ; Hires ?
             beq      1$
             lsl.w    4(a0)
             bset.b   #7,12(a0)    ; = bset.w #15,12(a0) = Viewmodes
1$:          move.w   #HGTNTSC,6(a0) ; HEIGHT
             btst.b   #1,1(a5)       ; PAL/NTSC ?
             beq      2$
             move.w   #HGTPAL,6(a0)
2$:          btst.b   #4,1(a5)       ; Interlace ?
             beq      3$
             lsl.w    6(a0)
             bset.b   #2,13(a0)    ; = bset.w #02,12(a0) = Viewmodes
3$:          jsr      OPENSCREEN(a6)
             move.l   d0,Screen
             beq      Game
             add.l    #44,d0
             move.l   d0,Viewport
             add.l    #40,d0
             move.l   d0,Rastport
             move.l   Gfxbase,a6
             move.l   Rastport,a1
             jsr      CLEARSCREEN(a6)
             move.l   Viewport,a0
             lea      GameColTab,a1
             move.l   #8,d0
             jsr      LOADRGB4(a6)

             move.l   Rastport,a1
             move.w   #5,d0
             jsr      SETAPEN(a6)
             lea      GameScrStr,a4
             move.w   4(a4),d5
             move.w   6(a4),d6      ; How many stars?
             move.w   d5,d7
             mulu.w   d6,d7
             lsr.l    #8,d7
             lsr.l    #6,d7
             move.l   #0,d0
             move.b   4(a5),d0
             mulu.w   d0,d7
             beq      Boxes
StarsLoop:   move.l   Rastport,a1   ; draw them
             move.w   d6,d0
             bsr      Rnd
             move.w   d0,d1
             move.w   d5,d0
             bsr      Rnd
             jsr      WRITEPIXEL(a6)
             dbf      d7,StarsLoop

Boxes:       move.l   Intbase,a6
             sub.w    #8,d5
             sub.w    #8,d6
             move.l   #0,d7         ; How many boxes?
             move.b   3(a5),d7
             beq      SavPod
BoxLoop:     move.l   Rastport,a0   ; draw them
             lea      BoxIStr,a1
             move.w   d6,d0
             bsr      Rnd
             and.b    #%11111000,d0 ; this prevents the boxes
             move.w   d0,d1         ; from overlaying
             move.w   d5,d0
             bsr      Rnd
             and.b    #%11111000,d0
             jsr      DRAWIMAGE(a6)
             dbf      d7,BoxLoop

SavPod:      move.l   #0,d7
             move.b   5(a5),d7      ; Draw the Savety Pods
             beq      CyclSect
PodLoop:     move.l   Rastport,a0
             lea      PodIStr,a1
             move.w   d6,d0
             bsr      Rnd
             and.b    #%11111000,d0
             move.w   d0,d1
             move.w   d5,d0
             bsr      Rnd
             and.b    #%11111000,d0
             jsr      DRAWIMAGE(a6)
             dbf      d7,PodLoop

CyclSect:    add.w    #7,d5          ; every cycle gets some blank
             add.w    #7,d6          ; space around his starting
             move.l   Gfxbase,a6     ; point.
             move.l   Rastport,a1
             move.l   #0,d0
             jsr      SETAPEN(a6)
             lea      CyclSecTab,a4
             move.w   d5,d0
             sub.w    #8,d0
             move.w   d0,4(a4)
             move.w   d0,20(a4)
             sub.w    #24,d0
             move.w   d0,(a4)
             move.w   d0,16(a4)
             move.w   d6,d0
             sub.w    #8,d0
             move.w   d0,6(a4)
             move.w   d0,14(a4)
             sub.w    #24,d0
             move.w   d0,2(a4)
             move.w   d0,10(a4)
             move.l   #3,d7
1$:          move.l   Rastport,a1
             move.w   (a4)+,d0
             move.w   (a4)+,d1
             move.w   (a4)+,d2
             move.w   (a4)+,d3
             btst.b   d7,(a5)
             beq      2$
             jsr      RECTFILL(a6)
2$:          dbf      d7,1$
             add.w    #1,d5
             add.w    #1,d6

PlayLoop:    lea      XY,a0       ; init. x,y,vx,vy of cycles
             lea      XYInit,a1
             move.w   d5,d0
             sub.w    #16,d0
             move.w   d0,(a1)
             move.w   d0,16(a1)
             move.w   d6,d0
             sub.w    #16,d0
             move.w   d0,2(a1)
             move.w   d0,10(a1)
             move.l   #7,d7
1$:          move.l   (a1)+,(a0)+
             dbf      d7,1$

             DELSEC   #50          ; Countdown
             move.l   Intbase,a6
             sub.l    a0,a0
             jsr      DISPLAYBEEP(a6)

             lea      Bonus,a3   ; delete Bonus (=points/round)
             clr.l    (a3)
             clr.l    4(a3)
             clr.b    cAnz
             move.b   (a5),PlayerMask   ; who's playing?
             move.w   #255*8+1,Points

GLoop1:      sub.w    #1,Points
             bpl      1$
             move.w   #255*8,Points
1$:          move.w   #3,d7
             move.l   Gfxbase,a6
             lea      XY,a2

GLoop2:      btst.b   d7,PlayerMask ; Does No. d7 play ?
             beq      1$
             bsr      Ask
             btst.b   d7,d0         ; input from no. d7
             beq      2$
             move.w   d1,d0
             add.w    d2,d0
             beq      204$     ; d1=d2=0? -> Firecheck
             move.w   d1,d0
             add.w    4(a2),d0      ; this prevents the cycles from
             beq      202$          ; having a "backwards crash"
             move.w   d1,4(a2)
202$:        move.w   d2,d0
             add.w    6(a2),d0
             beq      204$
             move.w   d2,6(a2)
204$:        tst.b    d3        ; Fire
             beq      2$
             move.l   #JMPMAX,d0
             bsr      Rnd
             add.w    #1,d0
             move.w   d0,d3      ;d0=d3=random number
             muls.w   4(a2),d3
             add.w    d3,(a2)    ; X = X + dX*Rnd(JMPMAX)
             muls.w   6(a2),d0
             add.w    d0,2(a2)   ; Y = Y + dY*Rnd(JMPMAX)
2$:          move.w   4(a2),d1
             add.w    d1,(a2)
             move.w   6(a2),d2
             add.w    d2,2(a2)

             cmp.w    #0,(a2)    ; cycle touches border ?
             bge      13$        ; no -> next border check
             btst.b   #0,1(a5)   ; yes -> crash ?
             beq      11$        ;        yes -> go to crash routine
             add.w    d5,(a2)    ;        no  -> other side
13$:         cmp.w    #0,2(a2)
             bge      14$
             btst.b   #0,1(a5)
             beq      11$
             add.w    d6,2(a2)
14$:         cmp.w    (a2),d5
             bgt      15$
             btst.b   #0,1(a5)
             beq      11$
             sub.w    d5,(a2)
15$:         cmp.w    2(a2),d6
             bgt      16$
             btst.b   #0,1(a5)
             beq      11$
             sub.w    d6,2(a2)

16$:         move.l   Rastport,a1
             move.w   d7,d0
             add.w    #1,d0
             jsr      SETAPEN(a6) ; SetAPen(d7+1)
             move.l   Rastport,a1
             move.w   (a2),d0
             move.w   2(a2),d1
             jsr      READPIXEL(a6) ; ReadPixel((a2),2(a2))
             cmp.l    #7,d0         ; Savety Pod-colour?
             beq      10$
             tst.l    d0
             bne      11$           ; colour <>0 -> Crash
             move.l   Rastport,a1
             move.w   (a2),d0
             move.w   2(a2),d1
             jsr      WRITEPIXEL(a6) ; write trace
1$:          add.w    #8,a2
             dbf      d7,GLoop2

             cmp.b    #ESC,CIA_KEY   ; ESC ?
             bne      5$
             jsr      CloseScr       ; -> back to SCORE-Screen
             bra      Game
5$:          cmp.b    #CTRL,CIA_KEY  ; CTRL ?
             bne      6$             ; -> CLEARSCREEN
             move.l   Rastport,a1
             move.l   #0,d0
             move.l   #0,d1
             jsr      MOVE(a6)
             move.l   Rastport,a1
             jsr      CLEARSCREEN(a6)
6$:          cmp.b    #HELP,CIA_KEY  ; HELP ?
             bne      7$
             bsr      Wait           ; -> Wait
7$:          move.l   #DELMAX,d1     ; speed means delay
             sub.b    2(a5),d1
             DELSEC   d1
             bra      GLoop1

10$:         btst.b   d7,SavPMask ; Savety Pod
             beq      11$
             bclr.b   d7,SavPMask
             move.l   d7,-(sp)
             move.w   d6,d7
             sub.w    #1,d7
103$:        move.l   Gfxbase,a6   ; animation
             move.l   Rastport,a1
             move.w   (a2),d0
             move.w   2(a2),d1
             jsr      MOVE(a6)
             move.l   Rastport,a1
             move.w   d5,d0
             sub.w    #1,d0
             move.w   d6,d1
             sub.w    #1,d1
             sub.w    d7,d1
             jsr      DRAW(a6)
             dbf      d7,103$
             move.w   d5,d7
             sub.w    #1,d7
102$:        move.l   Gfxbase,a6
             move.l   Rastport,a1
             move.w   (a2),d0
             move.w   2(a2),d1
             jsr      MOVE(a6)
             move.l   Rastport,a1
             move.w   d7,d0
             move.w   d6,d1
             sub.w    #1,d1
             jsr      DRAW(a6)
             dbf      d7,102$
             move.w   d6,d7
             sub.w    #1,d7
101$:        move.l   Gfxbase,a6
             move.l   Rastport,a1
             move.w   (a2),d0
             move.w   2(a2),d1
             jsr      MOVE(a6)
             move.l   Rastport,a1
             clr.w    d0
             move.w   d7,d1
             jsr      DRAW(a6)
             dbf      d7,101$
             move.w   d5,d7
             sub.w    #1,d7
104$:        move.l   Gfxbase,a6
             move.l   Rastport,a1
             move.w   (a2),d0
             move.w   2(a2),d1
             jsr      MOVE(a6)
             move.l   Rastport,a1
             move.w   d5,d0
             sub.w    #1,d0
             sub.w    d7,d0
             clr.w    d1
             jsr      DRAW(a6)
             dbf      d7,104$
             move.l   Gfxbase,a6     ; Write "Player x hit the s.pod"
             move.l   (sp)+,d7
             move.l   Rastport,a1
             move.l   #1,d0
             add.w    d7,d0
             jsr      SETBPEN(a6)
             move.l   Rastport,a1
             move.l   #3,d0
             add.w    d7,d0
             jsr      SETAPEN(a6)
             move.l   Rastport,a1
             move.w   d5,d0
             lsr.w    #1,d0
             sub.w    #29*8/2,d0
             move.w   d6,d1
             lsr.w    #1,d1
             jsr      MOVE(a6)
             move.l   Rastport,a1
             lea      SavPodTxt,a0
             add.b    d7,7(a0)
             move.l   #29,d0
             jsr      TEXT(a6)
             bsr      Wait
             bra      BuildScr


11$:         btst.b   #2,1(a5)  ; Crash
             beq      115$      ; Explosion ?
             move.l   #14,d3
111$         move.l   Gfxbase,a6
             move.l   Rastport,a1
             move.w   d3,d0
             add.w    #1,d0
             jsr      SETAPEN(a6)
             move.l   Rastport,a1
             move.w   (a2),d0
             move.w   2(a2),d1
             move.l   #15,d2
             sub.w    d3,d2
             move.w   d3,-(sp)
             move.w   d2,d3
             jsr      DRAWELLIPSE(a6) ; Draw explosion
             move.w   (sp)+,d3
             DELSEC   #5
             dbf      d3,111$
             move.l   Gfxbase,a6
             lea      XY,a4
             move.l   #3,d7          ; check all cycles
112$         btst.b   d7,PlayerMask
             beq      113$
             move.l   Rastport,a1
             move.w   (a4),d0
             add.w    4(a4),d0
             move.w   2(a4),d1
             add.w    6(a4),d1
             jsr      READPIXEL(a6)
             tst.l    d0
             beq      113$
             bclr.b   d7,PlayerMask
             add.b    #1,cAnz
             bsr      TraceFlicker
113$         add.w    #8,a4
             dbf      d7,112$
             move.l   Rastport,a1
             move.l   #0,d0
             jsr      SETAPEN(a6)
             move.l   #15,d3         ; fire's over
114$         move.l   Gfxbase,a6
             move.l   Rastport,a1
             move.w   (a2),d0
             move.w   2(a2),d1
             move.w   d3,d2
             move.w   d3,-(sp)
             jsr      DRAWELLIPSE(a6)
             move.w   (sp)+,d3
             DELSEC   #5
             dbf      d3,114$
             bra      116$

115$         bclr.b   d7,PlayerMask  ; no explosion
             bsr      TraceFlicker
             add.b    #1,cAnz

116$         lea      Bonus,a4
             lea      6(a4),a4
             clr.b    d0
             move.l   #3,d3
117$         btst.b   d3,PlayerMask
             beq      118$
             add.b    #1,d0
             move.w   Points,d1      ; add Points
             add.w    d1,(a4)
118$         sub.w    #2,a4
             dbf      d3,117$
             move.w   #255*8,Points  ; initialize Points
             cmp.b    #2,d0          ; 2 cycles left?
             blt      EndOfRound     ; no! fewer -> End of this Round
             bra      GLoop1         ; >=2 -> continue race


EndOfRound:  lea      Victory,a0
             lea      Bonus,a1
             lea      Score,a2
             clr.w    d0
             move.b   cAnz,d0
             move.l   #3,d7
1$:          move.l   #0,d1         ; calculate Bonus, Scores
             move.w   (a1),d1       ; Victories
             lsr.w    #3,d1
             divs.w   d0,d1
             move.w   d1,(a1)+
             add.w    d1,(a2)+
             btst.b   d7,PlayerMask
             beq      2$
             add.b    #1,0(a0,d7.w)
2$:          dbf      d7,1$
             bsr      Wait
             jsr      CloseScr
             add.b    #1,Round
             bra      Game
*------------------------------------------------
*--             local sub-routines             --
*------------------------------------------------
* --------------- wait for input ----------------
Wait:        DELSEC   #6           ; a wait routine
             bsr      Ask
             cmp.b    #1,d3
             bne      Wait
             rts
* --------------- let trace flicker -------------
TraceFlicker: move.l  d3,-(sp)     ; cycle a cycle's colour (a pun!)
              move.l  #10,d4       ; after crashing
1$:           DELSEC  #3
              move.l  Gfxbase,a6
              move.l  Viewport,a0
              move.w  d7,d0
              add.w   #1,d0
              move.l  #7,d1
              move.w  d1,d2
              move.w  d1,d3
              jsr     SETRGB4(a6)
              DELSEC  #3
              move.l  Gfxbase,a6
              move.l  Viewport,a0
              lea     GameColTab,a1
              move.l  #5,d0
              jsr     LOADRGB4(a6)
              dbf     d4,1$
              move.l  (sp)+,d3
              rts
* ------------------ sort scores ----------------
* a0->ptr to scores
Sort:        move.l   #0,d1        ; sort scores
             move.l   #0,d2
1$:          lea      SortNr,a1
             move.l   #2,d4
             move.l   #0,d0
2$:          move.w   (a1),d1
             move.w   0(a0,d1.w),d2
             move.w   2(a1),d1
             move.w   0(a0,d1.w),d3
             cmp.w    d2,d3
             ble      3$
             move.l   #1,d0
             move.w   (a1),2(a1)
             move.w   d1,(a1)
3$:          add.w    #2,a1
             dbf      d4,2$
             tst.b    d0
             bne      1$
             rts
* ----- compute random number [0 to d0-1] ------
* d0->Range
Rnd:         add.w    $DFF006,d3   ; I worked on that for about
             lea      EXECBASE,a3  ; 2 weeks !!
             add.w    $11e(a3),d3
             add.w    d3,d3
             eor.w    #$1D872B41,d3
             mulu.w   d3,d0
             clr.w    d0
             swap.w   d0
             bclr.l   #15,d0
             rts


* ------------------------------------------------------------------
* --                       Quit Routines                          --
* ------------------------------------------------------------------
CloseRaw:    move.l   Dosbase,a6
             move.l   Rawhandle,d1
             jsr      CLOSE(a6)
CloseLibs:   move.l   EXECBASE,a6
CloseGfx:    CLOSELIB Gfxbase
CloseInt:    CLOSELIB Intbase
CloseDos:    CLOSELIB Dosbase
ClosePrg:
             move.l   SPbackup,sp
             move.l   WBmsg,d1
             beq      Exit         ; WBmsg=0 -> started from CLI
             move.l   d1,a1
             jsr      REPLYMSG(a6)
Exit:        move.l   #0,d0
             rts


* ------------------------------------------------------------------
* --                    global sub-routrine                       --
* ------------------------------------------------------------------
* -------------  d0 -> decimal string  ----------
* a0=ptr to txt d0.l=number
ToDec:       move.l   #4,d1
             lea      DecTab,a1
DLoop:       divu     (a1)+,d0
             add.b    #'0',d0
             move.b   d0,(a0)+
             clr.w    d0
             swap     d0
             dbf      d1,DLoop
             rts
* --------------- Check the Input ---------------
Ask:         move.l   #0,d0 ; nix=0 Joy1=1 Joy2=2 Keyb=4 Nump=8
             move.l   #0,d1 ; <- ->
             move.l   #0,d2 ; /\  \/
             move.l   #0,d3 ; Fire
             move.b   CIA_KEY,d4
             cmp.b    #D,d4
             bne      Kleft
             move.b   #1,d1
             move.b   #4,d0
             rts
Kleft:       cmp.b    #S,d4
             bne      Kdown
             move.l   #-1,d1
             move.l   #4,d0
             rts
Kdown:       cmp.b    #X,d4
             bne      Kup
             move.l   #1,d2
             move.l   #4,d0
             rts
Kup:         cmp.b    #E,d4
             bne      Kfire
             move.l   #-1,d2
             move.l   #4,d0
             rts
Kfire:       cmp.b    #SPACE,d4
             bne      Nright
             move.l   #1,d3
             move.l   #4,d0
             rts
Nright:      cmp.b    #N6,d4
             bne      Nleft
             move.l   #1,d1
             move.l   #8,d0
             rts
Nleft:       cmp.b    #N4,d4
             bne      Ndown
             move.l   #-1,d1
             move.l   #8,d0
             rts
Ndown:       cmp.b    #N2,d4
             bne      Nup
             move.l   #1,d2
             move.l   #8,d0
             rts
Nup:         cmp.b    #N8,d4
             bne      Nfire
             move.l   #-1,d2
             move.l   #8,d0
             rts
Nfire:       cmp.b    #ENTER,d4
             bne      Joy2Dir
             move.l   #1,d3
             move.l   #8,d0
             rts
Joy2Dir:     move.w   CIA_JOY2D,d4
             btst.l   #1,d4
             beq      J2left
             move.l   #1,d1
             move.l   #2,d0
             rts
J2left:      btst.l   #9,d4
             beq      J2down
             move.l   #-1,d1
             move.l   #2,d0
             rts
J2down:      move.w   d4,d2
             lsr.w    #1,d2
             eor.w    d4,d2
             btst.l   #0,d2
             beq      J2up
             move.l   #1,d2
             move.l   #2,d0
             rts
J2up:        btst.l   #8,d2
             beq      Joy1Dir
             move.l   #-1,d2
             move.l   #2,d0
             rts
Joy1Dir:     move.w   CIA_JOY1D,d4
             move.l   #0,d2
             btst.l   #1,d4
             beq      J1left
             move.l   #1,d1
             move.l   #1,d0
             rts
J1left:      btst.l   #9,d4
             beq      J1down
             move.l   #-1,d1
             move.l   #1,d0
             rts
J1down:      move.w   d4,d2
             lsr.w    #1,d2
             eor.w    d4,d2
             btst.l   #0,d2
             beq      J1up
             move.l   #1,d2
             move.l   #1,d0
             rts
J1up:        btst.l   #8,d2
             beq      J2Fire
             move.l   #-1,d2
             move.l   #1,d0
             rts
J2Fire:      move.b   CIA_JFIRE,d4
             move.l   #0,d2
             btst.l   #7,d4
             bne      J1Fire
             move.l   #1,d3
             move.l   #2,d0
             rts
J1Fire:      btst.l   #6,d4
             bne      Nomove
             move.l   #1,d3
             move.l   #1,d0
Nomove:      rts
* -----------------  Close Screen ---------------
* closes a screen / removes coperlist
CloseScr:    move.l   Gfxbase,a6
             move.l   Viewport,a0
             jsr      FREEVPORTCOPLISTS(a6)
             move.l   Intbase,a6
             move.l   Screen,a0
             jsr      CLOSESCREEN(a6)
             rts

* -----------------  Open Screen  ---------------
* opens 640x200x4-screen
OpenScreen:  move.l   Intbase,a6
             lea      MenScrStr,a0
             jsr      OPENSCREEN(a6)
             move.l   d0,Screen
             beq      CloseRaw
             add.l    #44,d0
             move.l   d0,Viewport
             add.l    #40,d0
             move.l   d0,Rastport
* Set Copper -----------------
             move.l   EXECBASE,a6
             move.l   #16,d0
             move.l   #$10003,d1
             jsr      ALLOCMEM(a6)
             move.l   d0,CopMem
             beq      PutPic

             move.l   Gfxbase,a6       ; set colours 0 and 2-15 via gfx...
             move.l   Viewport,a0
             lea      ColourTab,a1
             move.l   #16,d0
             jsr      LOADRGB4(a6)

             move.l   Rastport,a1      ; (ok, this command doesn't belong to
             move.l   #0,d0            ; the whole copper thing, but it
             jsr      SETDRMD(a6)      ; saves a Gfxbase-move!)
             move.l   CopMem,a0        ; ...and no. 1 becomes a rainbow
             move.l   #401,d0
             jsr      UCOPPERLISTINIT(a6)

             lea.l    CopperTab,a4
             move.l   #199,d3          ; Zeilen = 200   -> d3
CopLoop:     move.l   CopMem,a1
             move.w   #199,d0
             sub.w    d3,d0
             move.l   #0,d1
             jsr      CWAIT(a6)
             move.l   CopMem,a1
             jsr      CBUMP(a6)        ; CWait(CopMem,199-d3,0)
             move.l   CopMem,a1
             move.l   #$182,d0
             move.w   (a4)+,d1
             jsr      CMOVE(a6)
             move.l   CopMem,a1
             jsr      CBUMP(a6)        ; CMove(CopMem,Color00,(CopperTab)+)
             tst.w    (a4)             ; No Entry in ColCopTable?
             bne      Jump
             lea      CopperTab,a4     ; from the beginning
Jump:        dbra     d3,CopLoop

             move.l   CopMem,a1
             move.l   #10000,d0
             move.l   #255,d1
             jsr      CWAIT(a6)
             move.l   CopMem,a1
             jsr      CBUMP(a6)        ; CEND
             move.l   Intbase,a6
             move.l   Viewport,a5
             move.l   CopMem,20(a5)    ; ViewPort.UCopIns=CoppLstPtr
             jsr      RETHINKDISPLAY(a6)
* Put Title Picture -----------
PutPic:      move.l   Intbase,a6
             move.l   Rastport,a0
             lea      TitleIStr,a1
             clr.w    d0
             clr.w    d1
             jsr      DRAWIMAGE(a6)
             rts


             SECTION  VARS,BSS
             even
Dosbase:     ds.l     1  ; all the lib-bases
Gfxbase:     ds.l     1
Intbase:     ds.l     1
Rawhandle:   ds.l     1  ; the RAW:-ptr
Screen:      ds.l     1  ; the screenptr
Rastport:    ds.l     1
Viewport:    ds.l     1
WBmsg:       ds.l     1  ; ptr -> WBmsg
BlackTab:    ds.w     16 ; everything's dark
CopMem:      ds.l     1  ; ptr to Ucopperlist
SPbackup:    ds.l     1
Gadnr:       ds.b     1  ; Menu: activated gadgetnr.(0-15)
DecTxt:      ds.b     5  ; Decimal string for ToDec-routine
Points:      ds.w     1  ; needed to calculate bonus
XY:          ds.w     4*4 ; Nr. 4 - 1: X,Y,dX,dY
Bonus:       ds.w     4
Score:       ds.w     4
Victory:     ds.b     4
Round:       ds.b     1
PlayerMask:  ds.b     1  ; who's still in the race ?
SavPMask:    ds.b     1  ; who's allowed to drive into the pod?
cAnz:        ds.b     1  ; number of crashes


             SECTION  CONST,DATA
             even
XYInit:      dc.w     $FF,$AA,0,-1,16,$AA,0,-1
             dc.w     $FF,16,0,1,16,16,0,1
SortNr:      dc.w     0,2,4,6
Num:         dc.b     '      ',10
             even
CyclSecTab:  dc.w     8,8,32,32,8,8,32,32
             dc.w     8,8,32,32,8,8,32,32
ScoreScr:    dc.w     8,60,75,580,130
             dc.w     9,62,76,578,129
             dc.w     10,64,77,576,128
             dc.w     8,66,78,574,127
             dc.w     2,60,155,580,199
             dc.w     3,62,156,578,198
             dc.w     4,64,157,576,197
             dc.w     1,96,85,56
             dc.b     "Résumé after 000 Rounds:    Bonus     Score    Victories"
             dc.w     7,104,170,54
             dc.b     "PRESS  FIRE  TO  CONTINUE   -   ESC  FOR  MAINMENU !!!"
             dc.w     6,160,179,40
             dc.b     "During the game press:  <HELP> for pause"
             dc.w     5,144,188,44
             dc.b     "<CTRL for cleanning the screen <ESC> to stop"
PlayerTxt:   dc.b     " . (           )                                      "
Rawname:     dc.b     "RAW:20/10/200/60/turboMCP",0
LimitTab:    dc.b     DELMAX,0,99,0,99,0,9,0
PrefsTab:    dc.b     %1110,%00001,DELMAX-2,0,0,0
             even
DecTab:      dc.w     10000,1000,100,10,1 ; powers of 10
GBoxXYTab:   dc.w     8,0,62,144,62+24
             dc.w     8,165,62,309,62+24
             dc.w     8,330,62,474,62+24
             dc.w     8,495,62,639,62+24
             dc.w     9,2,63,142,63+22
             dc.w     9,167,63,307,63+22
             dc.w     9,332,63,472,63+22
             dc.w     9,497,63,637,63+22
             dc.w     10,4,64,140,64+20
             dc.w     10,169,64,305,64+20
             dc.w     10,334,64,470,64+20
             dc.w     10,499,64,635,64+20
             dc.w     5,0,97,199,97+24
             dc.w     5,220,97,419,97+24
             dc.w     5,440,97,639,97+24
             dc.w     6,2,98,197,98+22
             dc.w     6,222,98,417,98+22
             dc.w     6,442,98,637,98+22
             dc.w     7,4,99,195,99+20
             dc.w     7,224,99,415,99+20
             dc.w     7,444,99,635,99+20
             dc.w     5,0,123,199,123+24
             dc.w     5,220,123,419,123+24
             dc.w     5,440,123,639,123+24
             dc.w     6,2,124,197,124+22
             dc.w     6,222,124,417,124+22
             dc.w     6,442,124,637,124+22
             dc.w     7,4,125,195,125+20
             dc.w     7,224,125,415,125+20
             dc.w     7,444,125,635,125+20
             dc.w     5,0,149,199,149+24
             dc.w     5,220,149,419,149+24
             dc.w     5,440,149,639,149+24
             dc.w     6,2,150,197,150+22
             dc.w     6,222,150,417,150+22
             dc.w     6,442,150,637,150+22
             dc.w     7,4,151,195,151+20
             dc.w     7,224,151,415,151+20
             dc.w     7,444,151,635,151+20
             dc.w     2,0,175,199,175+24
             dc.w     2,220,175,419,175+24
             dc.w     2,440,175,639,175+24
             dc.w     3,2,176,197,176+22
             dc.w     3,222,176,417,176+22
             dc.w     3,442,176,637,176+22
             dc.w     4,4,177,195,177+20
             dc.w     4,224,177,415,177+20
             dc.w     4,444,177,635,177+20
GadDirTab:   dc.b     1,3,4,13    ;0  >,<,\/,/\
             dc.b     2,0,5,14    ;1
             dc.b     3,1,5,14    ;2
             dc.b     0,2,6,15    ;3
             dc.b     5,6,7,0     ;4
             dc.b     6,4,8,1     ;5
             dc.b     4,5,9,3     ;6
             dc.b     8,9,10,4    ;7
             dc.b     9,7,11,5    ;8
             dc.b     7,8,12,6    ;9
             dc.b     11,12,13,7  ;10
             dc.b     12,10,14,8  ;11
             dc.b     10,11,15,9  ;12
             dc.b     14,15,0,10  ;13
             dc.b     15,13,2,11  ;14
             dc.b     13,14,3,12  ;15
GadXYTab:    dc.b     3,69        ;0  x/2,y
             dc.b     85,69       ;1  coordinates of the cursor
             dc.b     168,69      ;2
             dc.b     250,69      ;3
             dc.b     3,104       ;4
             dc.b     113,104     ;5
             dc.b     223,104     ;6
             dc.b     3,130       ;7
             dc.b     113,130     ;8
             dc.b     223,130     ;9
             dc.b     3,156       ;10
             dc.b     113,156     ;11
             dc.b     223,156     ;12
             dc.b     16,182      ;13
             dc.b     126,182     ;14
             dc.b     236,182     ;15
ColourTab:   dc.w     $000,$000,$060,$0A0,$0F0,$036,$05A,$07F
             dc.w     $666,$AAA,$FFF,$FB0,$F00,$FFF,$800,$352
GameColTab:  dc.w     $000,$F00,$07F,$0F0,$FB0,$E09,$39D,$FF9
CopperTab:   dc.w     $DF0,$BF0,$9F0,$7F0,$5F0
             dc.w     $3F0,$1F0
             dc.w     $0F2,$0F4,$0F6,$0F8,$0FA
             dc.w     $0FC,$0FE
             dc.w     $0DF,$0BF,$09F,$07F,$05F
             dc.w     $03F,$01F
             dc.w     $20F,$40F,$60F,$80F,$A0F
             dc.w     $C0F,$E0F
             dc.w     $F0D,$F0B,$F09,$F07,$F05
             dc.w     $F03,$F01
             dc.w     $F20,$F40,$F60,$F80,$FA0
             dc.w     $FC0,$FE0,0,0
Topaz8:      dc.l     Topaz8name
             dc.w     8
             dc.b     0,1
MenScrStr:   dc.w     0,0,640,200,4
             dc.b     0,0
             dc.w     $8000,$F
             dc.l     Topaz8,0,0,0
GameScrStr:  dc.w     0,0,0,0,3
             dc.b     0,0
             dc.w     0,$F
             dc.l     Topaz8,0,0,0
Topaz8name:  dc.b     'topaz.font',0
Dosname:     dc.b     'dos.library',0
Gfxname:     dc.b     'graphics.library',0
Intname:     dc.b     'intuition.library',0
GadTxtTab:   dc.b     12,'Joystick 1 '
             dc.b      7,'Joystick 2 '
             dc.b      4,'Keyboard   '
             dc.b     11,'Number Pad '
             dc.b     'No Border  '
             dc.b     'PAL Screen '
             dc.b     'Explosion  '
             dc.b     'HighRes    '
             dc.b     'Interlace  '
             dc.b     'Speed      '
             dc.b     'Boxes      '
             dc.b     'Stars      '
             dc.b     'Savety Pods'
             dc.b     'P L A Y    '
             dc.b     ' CLEAR     '
             dc.b     'Q U I T    '
SavPodTxt:   dc.b     'Player 0 hit the savety pod!!'
ScrollTxt:   dc.b     '         sick amiga software unfortunetly presents:         '
             dc.b     '                a new implementation of TRON                '
             dc.b     '                t u r b o    M C P   V13.47                 '
             dc.b     '       written by Jörg Sixt in 100% assembly language       '
             dc.b     '            between December 1990 and April 1991            '
             dc.b     '         ....I know...I`m a lazy, lazy programmer...        '
             dc.b     '       IMPORTANT - ATTENTION - IMPORTANAT - ATTENTION       '
             dc.b     '               This programme is FREEWARE!!!                '
             dc.b     '            Use and copy   turbo MCP   for free!            '
             dc.b     '   But do not try to sell it nor to include it in any sort  '
             dc.b     '    of commercial product without my explicit permisson!!   '
             dc.b     '    However a small copy fee seems tolerable as far as it   '
             dc.b     ' doesn`t exceed the 5$/6DM-limit. Any kind of distribution  '
             dc.b     '      with higher output prices requires my agreement.      '
             dc.b     '           (c) by Jörg Sixt. All Rights reserved.           '
             dc.b     '   If you want such a permission or if you feel generous    '
             dc.b     '           enough to send a small donation to the           '
             dc.b     '          "a C-compiler for Jörg Sixt"-foundation,          '
             dc.b     '     or if you just want to contact me for fun`s sake       '
             dc.b     '                  here`s my address:                        '
             dc.b     ' Jörg Sixt   *   Tulpenstr. 2   *   W-8424 Saal  *   F.R.G. '
             dc.b     '            And now the obligatory greeting list:           '
             dc.b     ' Thanks to Charlie Gibbs,the man behind the incredible a68k '
             dc.b     '       *   Teijo Kinunnen (med)   *   Fred Fish   *         '
             dc.b     '     Alan Turing   *   Amiga Power Club Regensburg, etc.    '
             dc.b     ' Special mega hyper thanks to the `Amiga Special`-Magazine! '
             dc.b     '           Ok, that`s all for now! Happy playin`!           '
             dc.b     '                  Don`t forget to write!!                   '
             dc.b     0


             SECTION  GRAPHICS,DATA,CHIP
             even
ArrowIDat:   dc.w     $ff9f,$ff0f,$ff07,$0003,$0001,$0000
             dc.w     $0001,$0003,$ff07,$ff0f,$ff9f
             dc.w     0,0,0,0,0,0,0,0,0,0,0
             dc.w     0,0,0,0,0,0,0,0,0,0,0
             dc.w     0,0,0,0,0,0,0,0,0,0,0
ArrowIStr:   dc.w     0,0,16,11,4
             dc.l     ArrowIDat
             dc.b     15,0
             dc.l     0
LEDonIDat:   dc.w     0,0,0,$01c0,$00e0,$0020,$0020,0,0,0
             dc.w     0,0,0,0,0,0,0,0,0,0,0,0,0,$0380,$0fe0
             dc.w     $1ff0,$3ff8,$3ff8,$3ff8,$1ff0,$0fe0
             dc.w     $0380,0,$ffff,$ffff,$ffff,$ffff,$ffff
             dc.w     $ffff,$ffff,$ffff,$ffff,$ffff,$ffff
LEDonIStr:   dc.w     0,0,16,11,4
             dc.l     LEDonIDat
             dc.b     15,0
             dc.l     0
LEDoffIDat:  dc.w     0,0,0,$0080,$0040,0,0,0,0,0,0,0,$0380
             dc.w     $0fe0,$1f70,$3fb8,$3ff8,$3ff8,$1ff0
             dc.w     $0fe0,$0380,0,0,$0380,$0fe0,$1ff0,$3ff8
             dc.w     $3ff8,$3ff8,$1ff0,$0fe0,$0380,0,$ffff
             dc.w     $ffff,$ffff,$ffff,$ffff,$ffff,$ffff
             dc.w     $ffff,$ffff,$ffff,$ffff
LEDoffIStr:  dc.w     0,0,16,11,4
             dc.l     LEDoffIDat
             dc.b     15,0
             dc.l     0
BackgrIDat:  dc.w     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
             dc.w     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
             dc.w     $ffff,$ffff,$ffff,$ffff,$ffff
             dc.w     $ffff,$ffff,$ffff,$ffff,$ffff,$ffff
BackgrIStr:  dc.w     0,0,16,11,4
             dc.l     BackgrIDat
             dc.b     15,0
             dc.l     0
PodIDat:     dc.w     $3c00,$6600,$cb00,$9f00,$8100,$fb00,$6600,$3c00
             dc.w     $3c00,$7e00,$ff00,$ff00,$ff00,$ff00,$7e00,$3c00
             dc.w     $3c00,$7e00,$ff00,$ff00,$ff00,$ff00,$7e00,$3c00
PodIStr:     dc.w     0,0,8,8,3
             dc.l     PodIDat
             dc.b     7,0
             dc.l     0
BoxIDat:     dc.w     $cc00,$6600,$3300,$9900,$cc00,$6600,$3300,$9900
             dc.w     $3300,$9900,$cc00,$6600,$3300,$9900,$cc00,$6600
             dc.w     $ff00,$ff00,$ff00,$ff00,$ff00,$ff00,$ff00,$ff00
BoxIStr:     dc.w     0,0,8,8,3
             dc.l     BoxIDat
             dc.b     7,0
             dc.l     0
TitleIStr:   dc.w     0,0,640,60,4
             dc.l     TitleIDat
             dc.b     15,0
             dc.l     0
TitleIDat:
             INCLUDE  "MCP.im"
             END
