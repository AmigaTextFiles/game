*
* $VER: Klotz.asm  2.10 (18.2.98)   - Need for speed
*		   2.8	(27.12.97)  - Hard-Coded Randgrößen rausgeschmissen
*		   2.6	(1.1.97)    - Hier spielt die Musik
*		   2.4	(2.4.96)    - Keyboard ohne Lowlevel
*		   2.3	(23.12.95)  - Pausenende
*		   2.2	(29.8.95)   - Keyboard mit Lowlevellib
*		   2.0	(23.8.95)   - Lowlevel-Support
*		   1.90 (25.7.95)   - mehr Farben
*		   1.88 (27.2.95)   - "Dynamische Klötze"
*		   1.86 (7.2.95)
*		   1.84 (27.12.94)  - Keine hüpfende Fenster mehr
*		   1.70 (16.10.94)
*    __ 	   1.46 (21.10.93)
*   //_)
*  //__) WARE  Game
*
; lowlevel.library benutzen ?
USELL	equ	1
; Soundeffekte ?
USESFX	equ	1
; BltBitMap Aufrufe ?
NEEDFORSPEED equ 0
    include "exec/types.i"
    include "exec/interrupts.i"
    include "exec/tasks.i"
    include "exec/memory.i"
    include "dos/dos.i"
    include "dos/dosextens.i"
    include "dos/var.i"
    include "graphics/rastport.i"
    include "graphics/displayinfo.i"
    include "workbench/startup.i"
    include "workbench/workbench.i"
    include "mymacros.i"
GZZ macro
    add.w   TSize(a4),d1
    add.w   BSize(a4),d0
    endm
GZZ2 macro
    add.w   TSize(a4),d3
    add.w   BSize(a4),d2
    endm

    locinit
*    include "protos.i"   ; debugging
    include "EntryExit.asm"
*   Offsets für globale Datenstruktur
 loc.l DOSBase
 loc.l IntBase
 loc.l GfxBase
 loc.l UtlBase
 ifne USELL
 loc.l	 LowLevelBase
 endc
 loc.b	 KeyMovL
 loc.b	 KeyMovR
 loc.b	 KeyMovD
 loc.b	 KeyRotL
 loc.b	 KeyRotR
 loc.b	 KeyPause
 loc.w CLine
 loc.w CPos
 loc.w CLineOld
 loc.w CPosOld
 loc.b IsDrawn
 loc.b CSpin
 loc.b CSpinOld
 loc.b CNXStein
 loc.b SmallFlag
 loc.b IsPause
 loc.b IsOver
 loc.b IsBW		; 2 Farben
 loc.b IsImage
 loc.b NewHi
 loc.w DropLine
 loc.l CStein
 loc.l CImage		; Bitmap
 loc.b IsHigh
 loc.b IsSetup
 loc.b IsLace
 loc.b IsColor
 loc.b IsColor7
 loc.b CKey	    ; pad-byte (für lowlevel.lib)
 loc.l Colormap
 loc.l Level
 loc.l Lines
 loc.l Score
 loc.l HiScore
 loc.l SelLevel
 loc.l Kisten
 loc.w SteinWidth
 loc.w SteinHeight
 bloc  Pens,7*3+1     ; Vorsicht Offset <125 !
 loc.l ArgPubScreen
 loc.l ArgKeys
 loc.l ArgLaceOn
 loc.l ArgLaceOff
 loc.l ArgUseKeys
 loc.l ArgMono
 loc.l ArgNoSound
 loc.l ArgsGB
 ifne USESFX

smp_Data    equ 0  ; l
smp_Length  equ 4  ; l
smp_Period  equ 8  ; w
smp_LEN     equ 10

 bloc  smp_bumm,smp_LEN
 bloc  smp_boing,smp_LEN
 bloc  smp_bili,smp_LEN
 bloc  smp_uettel,smp_LEN
 bloc  smp_bang,smp_LEN
 endc
VersionID
    dc.b    "$VER: Klotz 2.10 (18.2.98) by Bware",10,0
    cnop    0,4
    include "ArgumUtils.asm"
 ifne	USESFX
    include "AudioUtils.asm"
 endc
    include "RandUtils.asm"
    include "MathUtils.asm"
    include "Effects.asm"
    include "TimerUtils.asm"
 ifne	USELL
    include "JoyUtilsLL.asm"
 endc
 ifeq	USELL
    include "JoyUtils.asm"
 endc
*    include "DebugUtils.asm"
    include "GfxUtils.asm"
    include "Colors.asm"
    include "Image.asm"
    include "Stein.asm"
main
    lea     DOSName(pc),a1          ; Libs öffnen
    moveq   #37,d0
    CSYS    OpenLibrary
    reloc.l d0,DOSBase
    beq     CleanExitNDOS
    lea     IntName(pc),a1
    moveq   #37,d0
    CALL    OpenLibrary
    reloc.l d0,IntBase
    beq     CleanExitNInt
    lea     GfxName(pc),a1
    moveq   #37,d0
    CALL    OpenLibrary
    reloc.l d0,GfxBase
    beq     CleanExitNGfx
    lea     UtlName(pc),a1
    moveq   #37,d0
    CALL    OpenLibrary
    reloc.l d0,UtlBase
    beq     CleanExitNUtl

    copy.l  WBenchMsg,d0
    lea     ArgTemplate(pc),a0
    move.l  a0,d1
    lea     ArgPubScreen(a4),a0
    move.l  a0,d2
    bsr     Argum		    CLI & WB - Parsing

 ifne USELL
    bsr     InitJoy
    tst.l   d0
    beq     .continue
    pea     ERKlotzOk(pc)
    pea     ERLLibLauft(pc)
    pea     ERKlotzTitel(pc)
    pea     0
    pea     20	; es_SIZEOF
    move.l  sp,a1
    clra.l  a0
    clra.l  a2
    clra.l  a3
    CINT    EasyRequestArgs
    lea     20(sp),sp

    bra     CleanExitNTimer
 endc
.continue
    copy.l  ArgKeys,d0		    ; neue Tasten setzen
    beq.b   DefaultKeys
    move.l  d0,a0
    bsr     StrLen
    cmpi.w  #17,d0
    bne.b   DefaultKeys
    lea     KeyMovL(a4),a1
    moveq   #5,d2
KeyLoop
    bsr.b   ConvHex
    move.b  d0,(a1)+
    bmi.b   DefaultKeys
    adda.w  #1,a0
    dbra    d2,KeyLoop
    bra.b   EndKeys
ConvHex
* => a0: Zeichenkette in Hex z.b '4e'
* <= d0: Wert (oder -1)
*    a0: a0+2
    moveq   #0,d1
    bsr.b   ConvNibble
    move.b  d0,d1
    bmi.b   nogood
    lsl.b   #4,d1
ConvNibble
    move.b  (a0)+,d0
    subi.b  #'0',d0
    bmi.b   nogood
    cmpi.b  #9,d0
    bls.b   .ok
    subi.b  #'A'-'0'-10,d0
    bmi.b   nogood
    cmpi.b  #15,d0
    bls.b   .ok
    subi.b  #'a'-'A',d0
    bmi.b   nogood
    cmpi.b  #15,d0
    bgt.b   nogood
.ok
    add.b   d1,d0
    rts
nogood
    moveq   #-1,d0
    rts
DefaultKeys
    reloc.l #$4f4e4d40,KeyMovL
    reloc.w #$4619,KeyRotR
EndKeys
* endc
 ifne USESFX
    bsr     InitAudio
    tst.l   d0
    bne     .noaudio
    tst.l   ArgNoSound(a4)
    bne     .noaudio
    lea     .sfxdir(pc),a0
    move.l  a0,d1
    move.l  #ACCESS_READ,d2
    CDOS    Lock
    move.l  d0,d1
    beq     .noaudio
    CALL    CurrentDir
    move.l  d0,d2
    lea     LoadSample(pc),a5
    lea     smp_bumm(a4),a1
    lea     .bumm(pc),a0
    jsr     (a5)                ;bsr     LoadSample
    lea     smp_boing(a4),a1
    lea     .boing(pc),a0
    jsr     (a5)                ;bsr     LoadSample
    lea     smp_bili(a4),a1
    lea     .bili(pc),a0
    jsr     (a5)                ;bsr     LoadSample
    lea     smp_uettel(a4),a1
    lea     .uettel(pc),a0
    jsr     (a5)                ;bsr     LoadSample
    lea     smp_bang(a4),a1
    lea     .bang(pc),a0
    jsr     (a5)                ;bsr     LoadSample
    move.l  d2,d1
    CALL    CurrentDir
    move.l  d0,d1
    CALL    UnLock
    bra     .noaudio
.sfxdir dc.b 'PROGDIR:sfx',0
.bumm	dc.b 'Drop',0
.boing	dc.b 'OneLine',0
.bili	dc.b 'GameOver',0
.uettel dc.b 'SpeedUp',0
.bang	dc.b 'FourLines',0
    even
.noaudio
 endc
    bsr     InitTimer
    bne     CleanExitNTimer
    bsr     WindowOpen
    bsr     InitFeld

    copy.l  WBenchMsg,d0
    bsr     ArgumFree
    bsr     GetHi
    copy.l  CRastPort,a1
    bsr     ScoresOut

    bsr     Randomize
    moveq   #6,d0			; Ersten Stein
    bsr     RangeRand
*    moveq   #0,d0
    reloc.b d0,CNXStein

    move.l  #10000,d0			; Timer an
    bsr     StartTimer

    bsr     DrawSetUp
    on.b    IsPause
    on.b    IsSetup

waitloop
    copy.l  CWindow,a2
    move.l  wd_UserPort(a2),a0
    moveq   #0,d1
    move.b  MP_SIGBIT(a0),d1
    moveq   #1,d0
    lsl.l   d1,d0
 ifne	USESFX
    copy.l  AudioPort,a0		; auf Sound-Ende warten
    move.b  MP_SIGBIT(a0),d1
    moveq   #1,d2
    lsl.l   d1,d2
    or.l    d2,d0
 endc
    or.l    WUMsk(a4),d0                ; auf UserPort- & meine Signale warten
    or.l    #SIGBREAKF_CTRL_C,d0	; und auf Break

    CSYS    Wait
 ifne	USESFX
    and.l   d0,d2			; Sound ist am Ende
    beq.s   .skip
    bsr     FreeAudio
.skip
 endc
    btst    #SIGBREAKB_CTRL_C,d0	; CTRL-C bearbeiten
    bne     cleanup

    move.l  d0,d4
    move.l  wd_UserPort(a2),a0
    CALL    GetMsg
    tst.l   d0				; Signal
    beq.s   waitchain1			; ist von mir
    move.l  d0,a1
    pea     waitloop(pc)
    bra     ProcessIDCMP		; Intui-message abarbeiten

waitchain1
    tst.b   IsPause(a4)
    bne     pausedGame

    move.l  d4,d0
    and.l   WUMoveMsk(a4),d0
    beq.s   waitchain3

    copy.b  QDrop,d0			; Schneller Fall ?
    beq.s   .NoDrop
    tst.w   DropLine(a4)
    bne.s   .DropWeiter
    copy.w  CLine,DropLine(a4)          ; Dann aktuelle Zeile speichern
.DropWeiter
    bra.s    DropDown			 ; und plumps ...
.NoDrop
    moveq   #0,d5
    off.w   DropLine			; Sonst Zusatzpunkte löschen
    copy.w  StickX,d5			; Bewegung ist ...
    tst.w   d5
    beq.s   waitchain3
    add.w   CPos(a4),d5
    move.w  d5,d0
    copy.l  CStein,a0
    copy.w  CLine,d1
    copy.b  CSpin,d2
    bsr     CheckPosMove
    tst.b   d0
    bmi.s   .outofBounds

    bsr     DeleteStein 		; ... möglich, Stein löschen
    reloc.w d5,CPos			; Neue Position setzen
*    bsr     DrawStein			 ; und Stein zeichnen (erst später)

.outofBounds
;    bra     waitchain3 		 ; Auf Drehung überprüfen
waitchain3
    move.l  d4,d0
    and.l   WUSpinMsk(a4),d0
    beq.s   waitchain2

    on.b    FirePressed 		Flag für Interrupt

    copy.w  Fire,d3
    tst.w   d3
;    beq     waitback
    beq.s   waitchain2			Wenn Feuer ...
    off.w   DropLine
    copy.b  CSpin,d2
    add.w   d3,d2			Stein drehen
    moveq   #3,d3
    and.b   d3,d2
    move.b  d2,d5
    copy.l  CStein,a0
    copy.w  CLine,d1
    copy.w  CPos,d0
    bsr     CheckPosMove		Paßt noch ?
    bmi.s   .outofBounds
    bsr     DeleteStein
    reloc.b d5,CSpin
*    bsr     DrawStein
.outofBounds
* mehr Signale gibt es (noch) nicht
;waitchain4
;    bra     waitloop
;    bra     waitback

waitchain2
    move.l  d4,d0
    and.l   WUTimeMsk(a4),d0
    beq     waitndraw		       ; Zeit abgelaufen ?

    off.w   DropLine
DropDown
    copy.w  CLine,d1			; Schauen, ob Stein noch paßt.
    subq.w  #1,d1
    copy.w  CPos,d0
    copy.l  CStein,a0
    copy.b  CSpin,d2
    bsr     CheckPosDrop
    tst.b   d0
    bmi.s   xBottom			; Wenn nicht, dann verzweigen.

    bsr     DeleteStein 		; Stein löschen

    subq.w  #1,CLine(a4)                ; und tiefer setzen
waitndraw
    tst.b   IsDrawn(a4)
*    bne.s   .skip
    bsr     DrawStein
*.skip
    bra     waitloop			; zurück zum Wait
xBottom
    bsr     DrawStein			; Zeichnen, da Feld möglicherweise schon besetzt ( für letzten Stein)

 ifne USESFX
    lea     smp_bumm(a4),a0
    bsr     PlayAudio
 endc
    copy.w  CLine,d1			; Wenn's nicht weiter geht
    copy.w  CPos,d0
    copy.l  CStein,a0
    copy.b  CSpin,d2
    bsr     SetFeld			; Stein ins Merkfeld eintragen
    bsr     CheckLines			; Gibt's 'ne volle Linie ?
    tst.b   d0
    bpl.s   .cont			; negativ => Stein in Zeile 19

    bsr     GameOver
    bra     waitloop
.cont
 ifne USESFX
    tst.b   d0
    beq.s   .cont3
    push    d0-d1/a0-a1
    subq.w  #4,d0
    beq.s   .tetris
    lea     smp_boing(a4),a0
    bra.s   .cont2
.tetris
    lea     smp_bang(a4),a0
.cont2
    bsr     PlayAudio
    pop     d0-d1/a0-a1
.cont3
 endc
    push    a1/d1
    copy.w  DropLine,d1
    bsr     CalcScores			; Neue Punktzahl
    copy.l  CRastPort,a1
    bsr     ScoresOut
    off.w   DropLine
    pop     a1/d1
    tst.b   d0				; Keine Linie ?
    beq.s   Bottom2

    bsr     HiLiteLines 		; Volle Zeile aufblinken lassen
    push    d0-d1/a0-a1
    moveq   #8,d1
    CDOS    Delay
    pop     d0-d1/a0-a1
    bsr     HiLiteLines
    push    d0-d1/a0-a1
    moveq   #8,d1
    CDOS    Delay
    pop     d0-d1/a0-a1
    bsr     HiLiteLines
    push    d0-d1/a0-a1
    moveq   #8,d1
    CDOS    Delay
    pop     d0-d1/a0-a1
    bsr     HiLiteLines
Bottom3 				; Einsprung mit Löschen
    bsr     AufbauFeld			; Spielfeld neu zeichnen
Bottom2 				; Einsprung für neues Spiel
*    off.b   IsDrawn			 ; Neuen Stein vorbereiten
    off.w   DropLine
    reloc.w #19,CLine
    reloc.w #4,CPos
    clr.b   CSpin(a4)
    moveq   #6,d0
    bsr     RangeRand
*    moveq   #0,d0

    copy.b  CNXStein,d1
    reloc.b d0,CNXStein
*    cmp.b   d1,d0			 ; Wenn nächster Stein genauso
*    bne     .nonewseed
*    bsr     Randomize			 ; dann mal neuen Zufall
*.nonewseed
    copy.b  SmallFlag,d4
    bne.s   .issmall

    bsr     GetSteinAdr 		; Next zeichnen bei großem Fenster
    bsr     SetNXStein
.issmall
    off.b   IsImage
    move.b  d1,d0
    bsr     GetSteinAdr
    reloc.l d0,CStein
    addq.l  #4,Kisten(a4)
    moveq   #5,d0			; Schaun'mer'mal ob GameOver
    moveq   #18,d1
    bsr     GetFeld
    beq.s   waitback

    bsr     GameOver
waitback
    bra     waitloop
DrawStein
*
*
    tst.b   IsDrawn(a4)
    bne.s   .skip
    CGFX    WaitTOF			; Synchonisieren
    copy.w  CLineOld,d1
    copy.w  CPosOld,d0
    copy.b  CSpinOld,d2
    copy.l  CStein,a0
    bsr     ClearStein
.skip
    copy.w  CLine,d1
    copy.w  CPos,d0
    copy.b  CSpin,d2
    copy.l  CStein,a0
    bsr     SetStein
    on.b    IsDrawn
    rts
DeleteStein
*
*
    tst.b   IsDrawn(a4)
    beq     .noimg
*    copy.w  CLine,d1
*    copy.w  CPos,d0
*    copy.b  CSpin,d2
    copy.l  CStein,a0
*    bsr     ClearStein
    copy.w   CLine,CLineOld(a4)
    copy.w   CPos,CPosOld(a4)
    copy.b   CSpin,CSpinOld(a4)
    off.b   IsDrawn
.noimg
    rts
pausedGame
*
*   =>	   d4  :   SigMask
*

    tst.b   IsSetup(a4)
    bne     DoSetUp			Ins Setup-Menü verzweigen

    tst.b   IsOver(a4)
    bne.s   .skipthis
    push    a0-a2/a6/d0/d1
    copy.l  CWindow,a0
    lea     KlotzPaused(pc),a1
    moveq   #-1,d0
    move.l  d0,a2
    CINT    SetWindowTitles
    pop     a0-a2/a6/d0/d1
.skipthis
    move.l  d4,d0
    and.l   WUSpinMsk(a4),d0
    beq.s   .ende

    on.b    FirePressed

    copy.w  Fire,d0
    beq.s   .ende
    tst.b   IsOver(a4)                  Feuer und GameOver:
    beq.s   .pauseende
    moveq   #1,d0
    moveq   #1,d1
    bsr     GetFeld
    moveq   #94,d0	; 19 * 10/2 -1
.loop
    clr.w   (a0)+                       Spielfeld löschen
    dbra    d0,.loop
    off.b   IsOver
    off.b   IsHigh
    on.b    IsSetup
    bsr     DrawSetUp			Setup-Menü aufbauen
.weiter
    bra     Bottom2
.pauseende
    push    a0-a2/a6/d0/d1
    copy.l  CWindow,a0
    lea     Klotz(pc),a1
    moveq   #-1,d0
    move.l  d0,a2
    CINT    SetWindowTitles
    pop     a0-a2/a6/d0/d1

    off.b   IsPause
    tst.b   IsHigh(a4)     Feld ist vielleicht HiLighted ?
    beq.s   .nofx
    bsr.s   .dofx
    off.b   IsHigh
    bra.s   .nofx
.ende
    tst.b   IsOver(a4)          ; Blinken nur bei GameOver ._  ab Level 9 wird's
    beq.s   .nofx		;			   /   sonst zu schnell
    and.l   WUTimeMsk(a4),d4
    beq.s   .nofx
    tst.b   IsHigh(a4)
    seq     IsHigh(a4)
    bsr.s   .dofx
.nofx
    bra     waitback
.dofx
*   Kleiner Effekt - Invertiert gesamte Spielfläche
    moveq   #8,d1
    swap    d1
    subq.l  #2,d1	Bit 1 bis 18 setzen
    bra     HiLiteLines

ADDLACE     equ 68	; Text-Offset für Interlace
GameOver
*	Text anzeigen ( vielleicht Effekte ?)
*
 ifne USESFX
    lea     smp_bili(a4),a0
    bsr     PlayAudio
 endc
    on.b    IsPause
    on.b    IsOver
    off.l   Level
    off.l   Lines
    off.l   Score
    off.l   Kisten		; Steine draußen
    subq.l  #4,Kisten(a4)       ; Next bleibt erhalten ? Pfusch!
    copy.l  CRastPort,a1
    moveq   #GrauBlauKLOTZ,d2
    bsr     DoRNDFX

    move.l  a1,a2		; Game Over Text
    moveq   #RP_JAM1,d0 	; mit Schatten
    CGFX    SetDrMd
    moveq   #0,d0
    move.l  a2,a1
    CALL    SetAPen
    move.l  a2,a1
    moveq   #51,d0
    moveq   #74,d1
*    add.l   TSize(a4),d1
    GZZ
    tst.b   IsLace(a4)
    beq.s   .nolace3
    addi.w  #ADDLACE,d1
.nolace3
    CALL    Move
    lea     GOTxt1(pc),a0
    bsr     StrLen
    move.l  a2,a1
    CALL    Text
    move.l  a2,a1
    moveq   #27,d0
    moveq   #90,d1
*    add.l   TSize(a4),d1
    GZZ
    tst.b   IsLace(a4)
    beq.s   .nolace4
    addi.w  #ADDLACE,d1
.nolace4
    CALL    Move
    lea     GOTxt2(pc),a0
    bsr     StrLen
    move.l  a2,a1
    CALL    Text
    move.l  a2,a1
    moveq   #47,d0
    moveq   #74,d1
*    add.l   TSize(a4),d1
    GZZ
    tst.b   IsLace(a4)
    beq.s   .nolace5
    addi.w  #ADDLACE,d1
.nolace5
    CALL    Move
    lea     GOTxt1(pc),a0
    bsr     StrLen
    move.l  a2,a1
    CALL    Text
    move.l  a2,a1

    moveq   #23,d0
    moveq   #90,d1
*    add.l   TSize(a4),d1
    GZZ
    tst.b   IsLace(a4)
    beq.s   .nolace6
    addi.w  #ADDLACE,d1
.nolace6
    CALL    Move
    lea     GOTxt2(pc),a0
    bsr     StrLen
    move.l  a2,a1
    CALL    Text

    moveq   #2,d0
    move.l  a2,a1
    CALL    SetAPen
    move.l  a2,a1
    moveq   #49,d0
    moveq   #74,d1
*    add.l   TSize(a4),d1
    GZZ
    tst.b   IsLace(a4)
    beq.s   .nolace
    addi.w  #ADDLACE,d1
.nolace
    CALL    Move
    lea     GOTxt1(pc),a0
    bsr     StrLen
    move.l  a2,a1
    CALL    Text
    move.l  a2,a1
    moveq   #25,d0
    moveq   #90,d1
*    add.l   TSize(a4),d1
    GZZ
    tst.b   IsLace(a4)
    beq.s   .nolace2
    addi.w  #ADDLACE,d1
.nolace2
    CALL    Move
    lea     GOTxt2(pc),a0
    bsr     StrLen
    move.l  a2,a1
    CALL    Text

    move.l  a2,a1
    moveq   #RP_JAM2,d0
    CALL    SetDrMd
    rts
DrawSetUp
*
*   Zeichne Select-Level
*
    push    all
    copy.l  CRastPort,a2
    moveq   #10,d0
    moveq   #4,d1
    moveq   #85,d2
    add.w   d2,d2
    subq.w  #1,d2
    moveq   #70,d3
    add.w   d3,d3
    addq.w  #7,d3
    moveq   #2,d4
*    copy.l  TSize,d5
*    add.l   d5,d1
    moveq   #0,d5
    GZZ
    GZZ2
    tst.b   IsLace(a4)
    beq.s   .nolace
    addi.w  #144,d5
.nolace
    add.l   d5,d3
    move.l  a2,a1
    bsr     PunkteMuster
    moveq   #74,d0
    moveq   #36,d1
    moveq   #105,d2
    moveq   #115,d3
    moveq   #BOX_HILIGHT,d4
*    add.l   TSize(a4),d1
*    add.l   TSize(a4),d3
    GZZ
    GZZ2
    move.l  a2,a1
    bsr     OSzweinullBorder
    moveq   #0,d0
*    copy.l  TSize,d1
    moveq   #0,d1
    GZZ
    move.l  d1,d2
    andi.l  #1,d2		; Imagepunktemuster soll
    add.l   d2,d1		; mit Hintergrundmuster übereinstimmen
    move.l  a2,a0
    lea     LogoImage(pc),a1
    CINT    DrawImage
    moveq   #42,d0
    moveq   #24,d1
*    add.l   TSize(a4),d1
    GZZ
    move.l  a2,a1
    CGFX    Move
    moveq   #1,d0
    move.l  a2,a1
    CALL    SetAPen
    moveq   #RP_JAM1,d0
    move.l  a2,a1
    CALL    SetDrMd
    lea     SelectTxt(pc),a0
    bsr     StrLen
    move.l  a2,a1
    CALL    Text

    moveq   #0,d4
.textloop
    moveq   #86,d0
    moveq   #42,d1
    move.w  d4,d2
    lsl.w   #3,d2
    add.w   d2,d1
*    add.l   TSize(a4),d1
    GZZ
    move.l  a2,a1
    CALL    Move
    lea     Buffer(a4),a0
    move.w  d4,d2
    addi.b  #'0',d2                 Levelnummer
    move.b  d2,(a0)
    moveq   #1,d0
    move.l  a2,a1
    CALL    Text
    addq.b  #1,d4
    cmpi.b  #10,d4
    blt.s   .textloop
    moveq   #RP_JAM2,d0
    move.l  a2,a1
    CALL    SetDrMd
    bsr     Light
    on.b    IsHigh
    pop     all
    rts
DoSetUp
*   Levelauswahl
*
*   =>	 d4  : SigMask

    push    a0-a2/a6/d0/d1
    copy.l  CWindow,a0
    lea     Klotz(pc),a1
    moveq   #-1,d0
    move.l  d0,a2
    CINT    SetWindowTitles
    pop     a0-a2/a6/d0/d1

    move.l  d4,d0
    and.l   WUSpinMsk(a4),d0
    beq     .keinFeuer
    tst.b   IsHigh(a4)
    beq     .normal
    bsr     Light
    off.b   IsHigh
.normal
    reloc.l SelLevel(a4),Level
    bsr     AufbauFeld
    off.b   IsSetup
    off.b   IsPause
    tst.b   SmallFlag(a4)
    bne     .weiter
    copy.l  CRastPort,a1
    move.l  a1,a2
    moveq   #-1,d0
    bsr     ReDraw
    move.l  a2,a1
    bsr     ScoresOut
.weiter
    bra     Bottom3	    ; Feld löschen
.keinFeuer
    move.l  d4,d0
    and.l   WUMoveMsk(a4),d0
    beq     .keinDrop
    copy.b  QDrop,d0
    beq     .keinDrop
    tst.b   IsHigh(a4)
    beq     .normal2
    bsr     Light
    off.b   IsHigh
.normal2
    copy.l  SelLevel,d0
    addq.b  #1,d0
    cmpi.b  #10,d0	    ; Nach Level 9 wieder Level 0
    blt     .inordnung
    moveq   #0,d0
.inordnung
    reloc.l d0,SelLevel
    bsr     Light
    on.b    IsHigh
.keinDrop
.zurueck
    bra     waitloop
    xref    LogoData
Light
*   Invertieren
    moveq   #74,d0
    copy.l  SelLevel,d1
    lsl.w   #3,d1
    addi.b  #36,d1
*    add.l   TSize(a4),d1
    GZZ
    move.w  d0,d2
    addi.b  #31,d2
    move.w  d1,d3
    addi.b  #7,d3
    copy.l  CRastPort,a1
    bra     InvertBox

cleanup
    bsr     StopTimer
 ifne USELL
    bsr     ExitJoy
 endc
    bsr     WindowClose
 ifne USESFX
    bsr     ExitAudio
 endc
*    bsr     CleanUpFeld
CleanExit
    bsr     ExitTimer
CleanExitNTimer
    copy.l  UtlBase,a1
    CSYS    CloseLibrary
CleanExitNUtl
    copy.l  GfxBase,a1
    CSYS    CloseLibrary
CleanExitNGfx
    copy.l  IntBase,a1
    CSYS    CloseLibrary
CleanExitNInt
    copy.l  DOSBase,a1
    CSYS    CloseLibrary
CleanExitNDOS
    moveq   #0,d0
    bra     exit

ProcessIDCMP
*  Nachrichten- Auswertung
*  => a1 : IntuiMessage
*  => a2 : Window
*  => a6 : ExecBase

    move.l  im_Class(a1),d3
    move.w  im_Code(a1),d4
    CALL    ReplyMsg
* ifeq USELL
*    cmpi.l  #IDCMP_RAWKEY,d3
*    bne     .skipthis
*    reloc.b d4,CKey
*.skipthis
* endc
    cmpi.l  #IDCMP_CLOSEWINDOW,d3
    beq     cleanup
    cmpi.l  #IDCMP_ACTIVEWINDOW,d3
    bne     .continue
 IFEQ	USELL
    on.b    IsPause   ; Pause bei Aktivierung des Fensters
 ENDC
    rts
.continue
    cmpi.l  #IDCMP_CHANGEWINDOW,d3
    bne     .noredraw2		    ; und tschüß
*    büschen rumfensterln - von wegen Zoom und so ...
    cmpi.w  #245,wd_Width(a2)
    bls     .noredraw
    copy.b  SmallFlag,d0
    beq     .noredraw2
    off.b   SmallFlag
    move.l  wd_RPort(a2),a1
    move.l  a1,a2
    moveq   #-1,d0
    bsr     ReDraw
    move.l  a2,a1
    bsr     ScoresOut
    bra     .noredraw2
.noredraw
    on.b    SmallFlag
.noredraw2
    rts

WindowOpen
*
*   Öffne Spielfeldfenster
*
*   <=	 d0 : Window
*
    push    a5-a6

    bsr     FetchPubScreen
    tst.l   d0
    beq     CleanExit
    move.l  d0,a0
    move.w  sc_Height(a0),d1
    cmpi.w  #300,d1		Ist Bildschirm groß genug ?
    bge.s   .big
    off.b   IsLace
    bra.s   .endif
.big
    copy.l  ArgLaceOn,d1
    beq.s   .checknolace
    on.b    IsLace
    bra.s   .endif
.checknolace
    copy.l  ArgLaceOff,d1
    beq.s   .autosense
    off.b    IsLace
    bra.s   .endif
.autosense
    bsr     FetchLace		Ist Bildschirm mit Zeilensprung ?
.endif
    move.l  d0,a5
    move.l  sc_Font(a5),a0
    moveq   #0,d0
    move.w  ta_YSize(a0),d0
    add.b   sc_WBorTop(a5),d0
    add.b   sc_WBorBottom(a5),d0
*    reloc.l d0,TSize
    lea     WindowTags,a1
    tst.b   IsLace(a4)
    beq     .nolace
    addi.w  #144,d0		Für LACE darfs noch etwas mehr sein
    addi.l  #144,28(a1)           ; Titelleistenhöhe
.nolace
    lea     ZoomPos,a0	    ; Alternate position
    add.w   d0,6(a0)
    moveq   #0,d0
    move.b  sc_WBorLeft(a5),d0
    add.b   sc_WBorLeft(a5),d0
    add.w   d0,4(a0)

* Fenster zentrieren
    move.w  sc_Width(a5),d0
    subi.w  #254,d0
    asr.l   #1,d0
    bmi.s   .ohnonegx
    move.l  d0,4(a1)            ; Left
.ohnonegx
    move.w  sc_Height(a5),d0
    sub.l   28(a1),d0
    asr.l   #1,d0
    bmi.s   .ohnonegy
    move.l  d0,12(a1)            ; Right
.ohnonegy
    tst.l   ArgUseKeys(a4)       ; Falls Tasteneingabe, Fenster aktivieren
    beq.s   .noactwin
    ori.l   #WFLG_ACTIVATE,60(a1)
.noactwin
    clra.l  a0
    move.l  a5,68(a1)           ; PubScreen
    CINT    OpenWindowTagList
    reloc.l d0,CWindow
    beq     CleanExit
.isok
    move.l  d0,a1
    moveq   #0,d1
    move.b  wd_BorderTop(a1),d1
    subq.w  #1,d1
    reloc.w d1,TSize
    move.b  wd_BorderLeft(a1),d1
    subq.w  #4,d1
    reloc.w d1,BSize

    reloc.w #16,SteinWidth
    tst.b   IsLace(a4)
    beq.s   .nolace3
    reloc.w #16,SteinHeight
    bra.s   .endiff
.nolace3
    reloc.w #8,SteinHeight
.endiff
    off.b   IsColor
    tst.l   ArgMono(a4)
    bne.s   .skip
    move.l  a5,a1
    bsr     GetPens
.skip
    clra.l  a0
    move.l  a5,a1
    CALL    UnlockPubScreen
    copy.l  CWindow,a5
    move.l  wd_RPort(a5),a1
    reloc.l a1,CRastPort
    move.l  rp_BitMap(a1),a0
    cmp.b   #1,bm_Depth(a0)     Test auf 2-Farben Screen
    seq     IsBW(a4)
    ifne    NEEDFORSPEED
    moveq   #32,d0		; Blit - Bitmap initialisieren
    moveq   #32,d1
    moveq   #8,d2
    moveq   #0,d3
    CGFX    AllocBitMap
    reloc.l d0,CImage
    copy.l  CRastPort,a1
    endc
    reloc.l rp_Font(a1),OFont
    lea     TxAttr(pc),a0
    CGFX    OpenFont
    reloc.l d0,CFont
    move.l  d0,a0
    copy.l  CRastPort,a1
    CALL    SetFont
    tst.b   IsLace(a4)
    beq.s   .nolace2
    lea     Borders,a0
    addi.w  #144,6(a0)
    lea     NXBorders,a0
    addi.w  #32,6(a0)
.nolace2
    moveq   #0,d0
    copy.l  CRastPort,a1
    bsr     ReDraw
    move.l  a5,d0
    pop     a5/a6
    rts
ReDraw
*   Zeichnet Boxen und Texte
*
*   =>	 a1  : RastPort
*	 d0  : NoFullRedrawFlag
    push    a2-a3/d2-d6
    move.l  a1,a2
    tst.l   d0
    bne     .nofullredraw
    st	    d5
    moveq   #4,d0
    bra     .redrawweiter
.nofullredraw
    sf	    d5
    moveq   #88,d0
    add.l   d0,d0
.redrawweiter
    moveq   #1,d1
    moveq   #124,d2
    add.l   d2,d2
    addq.l  #1,d2
    moveq   #75,d3
    add.l   d3,d3
    moveq   #2,d4
*    copy.l  TSize,d6
*    add.l   d6,d1
    moveq   #0,d6
    GZZ
    GZZ2
    tst.b   IsLace(a4)
    beq     .nolace
    addi.w  #144,d6
.nolace
    add.l   d6,d3
    bsr     PunkteMuster
    lea     Borders,a3
    tst.b   d5
    bne     .borderloop
    lea     8(a3),a3
.borderloop
    move.w  (a3)+,d0
    bmi     .unloop
    move.w  (a3)+,d1
    move.w  (a3)+,d2
    move.w  (a3)+,d3
    moveq   #BOX_HILIGHT,d4
    move.l  a2,a1
*    add.l   TSize(a4),d1
*    add.l   TSize(a4),d3
    GZZ
    GZZ2
    bsr     OSzweinullBorder
    bra     .borderloop
.unloop
    moveq   #1,d0
    move.l  a2,a1
    CGFX    SetAPen
    moveq   #RP_JAM1,d0
    move.l  a2,a1
    CALL    SetDrMd
    lea     Texte(pc),a3
.textloop
    move.w  (a3)+,d0
    bmi     .exitloop
    move.w  (a3)+,d1
    move.l  a2,a1
*    add.l   TSize(a4),d1
    GZZ
    CALL    Move
    move.l  a3,a0
    bsr     StrLen
    move.l  a2,a1
    CALL    Text
    lea     8(a3),a3
    bra     .textloop
.exitloop
    moveq   #RP_JAM2,d0
    move.l  a2,a1
    CALL    SetDrMd
.exit
    pop     a2-a3/d2-d6
    rts
StrLen
*  Zeichenkettenlänge
*   =>	 a0: Zeichenkette
*   <=	 a0:   "
*  d0: Länge
    moveq   #-1,d0
.loop
    addq.l  #1,d0
    cmpi.b  #0,0(a0,d0.l)
    bne     .loop
    rts
 loc.l CWindow
 loc.l CRastPort
 loc.l CFont
 loc.l OFont
 loc.w TSize
 loc.w BSize
WindowClose
*
*   schließt Fenster
*
    push    all
*   Neuer HiScore ?
    tst.b   NewHi(a4)
    beq.s   .nohi
    bsr     SaveHi
.nohi
    copy.l  CWindow,d2
    beq.s   .noWin
    move.l  d2,a2
    move.l  wd_UserPort(a2),a2
    copy.l  SysBase,a6
.msgloop
    move.l  a2,a0
    CALL    GetMsg
    tst.l   d0
    beq.s   .endloop
    move.l  d0,a1
    CALL    ReplyMsg
    bra.s   .msgloop
.endloop
    tst.b   IsColor(a4)
    beq.s   .noColor
    moveq   #7*3,d0
    bsr     FreePens
.noColor
    copy.l  CRastPort,a1
    copy.l  OFont,a0
    CGFX    SetFont
    move.l  d2,a0
    CINT    CloseWindow
    moveq   #0,d0
    reloc.l d0,CWindow
    reloc.l d0,CRastPort
.noWin
    copy.l  CFont,d0
    beq.s  .noFont
    move.l  d0,a1
    CGFX    CloseFont
.noFont
    ifne    NEEDFORSPEED
    copy.l  CImage,a0
    CGFX    FreeBitMap
    endc
    pop     all
    rts

CalcScores
*
*  Berechne Punktezahl
*   =>	d0  :	Volle Zeilenanzahl
*	[d1  :	 DropLine]
*
    push    all
    ext.l   d0
    ext.l   d1
    move.l  d0,d4
    mulu    #10,d4
    lea     Level(a4),a2
    add.l   d0,Lines(a4)
    subq.w  #1,d0
    bmi     .keineLinie
    move.l  d0,d2
    add.l   d2,d2
    move.w  KnackPunkte(pc,d2),d0
    sub.l   d4,Kisten(a4)

*    copy.l  Kisten,-(sp)
*    bsr     LongOut

    tst.l   Kisten(a4)
    bne     .nobonus
    addi.w  #10000,d0		    Bonus für 'leeres' Spielfeld
.nobonus
    copy.l  Level,d2
    addq.w  #1,d2
    mulu    d2,d0
    bra     .Linie
.keineLinie
    moveq   #0,d0
.Linie
    add.l   d1,d0
    add.l   d0,Score(a4)
    copy.l  Score,d0
    cmp.l   HiScore(a4),d0
    bls     .weiter
    reloc.l d0,HiScore
*    bsr     SaveHi
    on.b    NewHi
.weiter
    copy.l  Lines,d0
    moveq   #10,d2
    divu    d2,d0
    swap    d0
    clr.w   d0
    swap    d0
    cmp.l   Level(a4),d0
    bls     .weiter2
    reloc.l d0,Level
 ifne USESFX
    lea     smp_uettel(a4),a0
    bsr     PlayAudio
 endc
.weiter2
    pop     all
    rts
KnackPunkte
    dc.w    40
    dc.w    100
    dc.w    300
    dc.w    1200
ScoresOut
*
*   =>	 a1  : RastPort
    push    all
    move.l  a1,a2
    moveq   #1,d0
    CGFX    SetAPen
    moveq   #0,d1
    lea     TextBorders,a3
    copy.l  Level,d0
    move.w  2(a3),d1
    bsr     PutPunkte
    copy.l  Lines,d0
    move.w  10(a3),d1
    bsr     PutPunkte
    copy.l  Score,d0
    move.w  18(a3),d1
    bsr     PutPunkte
    copy.l  HiScore,d0
    move.w  26(a3),d1
    bsr     PutPunkte
    pop     all
    rts
PutPunkte
*
*   Punkte ausgeben
*   =>	a2  : RastPort
*	d0  : Punkte
*	d1  : YPosition
    push    d3/a3
    move.l  d1,d3
    addq.l  #7,d3
    bsr     ToAscii
    move.l  d0,a0
    move.l  d0,a3
    bsr     StrLen
    move.l  d0,d2
    move.l  a2,a1
    CGFX    TextLength
    asr.l   #1,d0
    moveq   #106,d1
    add.l   d1,d1
    sub.l   d0,d1
    move.l  d1,d0
    move.l  d3,d1
    move.l  a2,a1
*    add.l   TSize(a4),d1
    GZZ
    CALL    Move
    move.l  a3,a0
    move.l  d2,d0
    move.l  a2,a1
    CALL    Text
    pop     d3/a3
    rts
ToAscii
*   Konvertierung
*   =>	 d0  : Nummer
*   <=	 a0,d0 : String
    push    a1-a2/d1-d2/a6
    copy.l  UtlBase,a6
    lea     Buffer+16(a4),a2
    moveq   #'0',d2
    clr.b   -(a2)        Endekennung
.loop
    moveq   #10,d1
    CALL    UDivMod32	Durch 10
    add.w   d2,d1	Rest ( 0..9 ) plus ASCII '0'
    move.b  d1,-(a2)    Speichern
    tst.l   d0		Wenn Divisionsergebnis nicht NULL ...
    bne     .loop	... nochmal
    move.l  a2,a0
    move.l  a2,d0
    pop     a1-a2/d1-d2/a6
    rts
*   eine ULONG-Zahl hat max. 9 Stellen (lg 2^32)
 bloc	Buffer,32
 ifne USELL
OpenNV
*    <= a6: NVBase
*	d0: error
    lea     NVName(pc),a1
    moveq   #40,d0
    CSYS    OpenLibrary
    move.l  d0,a6
    tst.l   d0
    rts
GetHi
    push    d0-d4/a0-a2/a6
    bsr     OpenNV
    beq     GetHiOld
    lea     Klotz(pc),a0
    lea     VarName(pc),a1
    moveq   #0,d1
    CALL    GetCopyNV
    move.l  d0,d1
    beq     .nohi
    move.l  a6,-(sp)
    move.l  d0,d3
    lea     HiScore(a4),a0
    move.l  a0,d2
    CDOS    StrToLong
    move.l  (sp)+,a6
    move.l  d3,a0
    CALL    FreeNVData
    move.l  a6,a1
    CSYS    CloseLibrary
.nohi
    pop     d0-d4/a0-a2/a6
    rts
SaveHi
    push    d0-d4/a0-a2/a6
    bsr     OpenNV
    beq     SaveHiOld
    copy.l  HiScore,d0
    bsr     ToAscii
    move.l  d0,a2
    bsr     StrLen
    lea     Klotz(pc),a0
    lea     VarName(pc),a1
    moveq   #0,d1
    CALL    StoreNV
    move.l  a6,a1
    CSYS    CloseLibrary
    pop     d0-d4/a0-a2/a6
    rts
 endc
 ifeq USELL
GetHi

*
*   Lade ENV: Variable
*
* <= HiScore enthält letzten gesicherten Wert
    push    d0-d4/a0-a2/a6
 endc
GetHiOld
    lea     VarName(pc),a0
    move.l  a0,d1
    lea     Buffer(a4),a0
    move.l  a0,d2
    moveq   #31,d3
    moveq   #0,d4
    CDOS    GetVar
    tst.l   d0
    bmi     .nichtda
    lea     Buffer(a4),a0
    move.l  a0,d1
    lea     HiScore(a4),a0
    move.l  a0,d2
    CALL    StrToLong
.nichtda
    pop     d0-d4/a0-a2/a6
    rts
 ifeq USELL
SaveHi
*
*  Setze ENV: Variable
*
*  Vorsicht! quelque chose in die Hose
    push    d0-d4/a0-a2/a6
 endc
SaveHiOld
    copy.l  HiScore,d0
    bsr     ToAscii
    move.l  d0,d2
    moveq   #-1,d3
    lea     VarName(pc),a0
    move.l  a0,d1
    move.l  #GVF_GLOBAL_ONLY!LV_VAR,d4
    CDOS    SetVar
    pop     d0-d4/a0-a2/a6
    rts
FetchPubScreen
*
*   PublicScreen locken
*
*	=> d0 : ScreenLock
*
    push    a6
    copy.l  ArgPubScreen,a0		  ; NameBuffer für Lock
    bra     .lock
.default
    clra.l  a0			; Lock auf Default Public Screen
.lock
    CINT    LockPubScreen
    tst.l   d0
    beq     .default
    pop     a6
    rts
    bloc    DisInfo,dis_SIZEOF
FetchLace
*
*   Ist Bildschirm im INTERLACE - Modus ?
*   => a0 : Screen
*   <= IsLace entsprechend gesetzt
    push    a0-a2/d0-d2/a6
    move.l  a0,a2
    lea     sc_ViewPort(a0),a0
    CGFX    GetVPModeID
*    cmpi.l  #INVALID_ID,d0
*    bne.s   .IDOk
*.Error
*    move.l  a2,a0
*    CINT    DisplayBeep
*    bra.s   .nolace
*.IDOk
    CALL    FindDisplayInfo
*    tst.l   d0
*    beq     .Error
    move.l  d0,a0
    moveq   #0,d2
    move.l  #DTAG_DISP,d1
    moveq   #dis_SIZEOF,d0
    lea     DisInfo(a4),a1
    CALL    GetDisplayInfoData
*    tst.l   d0
*    beq     .Error
*    copy.l  DisInfo+dis_PropertyFlags,d0   Interlace geht nicht
*    andi.l  #DIPF_IS_LACE,d0
*    beq     .nolace
    copy.w  DisInfo+dis_Resolution+tpt_x,d0	Aber Pixel-Aspect
    bsr     ToFixed				Dumme Festpunkt-Zahlen
    move.l  d0,d1
    copy.w  DisInfo+dis_Resolution+tpt_y,d0
    bsr     ToFixed
    bsr     FixedDiv
    cmpi.l  #$00014000,d0   1.25 = 1+4/16
    bgt.s   .nolace
    on.b    IsLace
    bra.s   .endif
.nolace
    off.b   IsLace
.endif
    pop     a0-a2/d0-d2/a6
    rts
LogoImage
    dc.w 74,122,$20,$18,2
    dc.l LogoData
    dc.b $3,$0
    dc.l 0
 section "data",data
* Reihenfolge NICHT ändern !!
WindowTags
    dc.l    WA_Left,10
    dc.l    WA_Top,10
*    dc.l    WA_Width,254
*    dc.l    WA_Height,153
    dc.l    WA_InnerWidth,246
    dc.l    WA_InnerHeight,150
    dc.l    WA_IDCMP,IDCMP_CLOSEWINDOW!IDCMP_CHANGEWINDOW!IDCMP_ACTIVEWINDOW   ;!IDCMP_RAWKEY
    dc.l    WA_Title,Klotz
    dc.l    WA_Zoom,ZoomPos
    dc.l    WA_Flags,WFLG_DRAGBAR!WFLG_CLOSEGADGET!WFLG_DEPTHGADGET!WFLG_RMBTRAP
*    dc.l    WA_DragBar,-1
*    dc.l    WA_CloseGadget,-1
*    dc.l    WA_DepthGadget,-1
*    dc.l    WA_RMBTrap,-1
    dc.l    WA_PubScreen,0
    dc.l    TAG_DONE
ZoomPos
    dc.w    -1,-1,172,151
Borders
    dc.w    10,4,169,147
TextBorders
    dc.w    180,15,243,24
    dc.w    180,40,243,49
    dc.w    180,65,243,74
    dc.w    180,90,243,99
NXBorders
    dc.w    180,116,243,147
    dc.w    -1
 section "",code
Texte
    dc.w    192,10
    dc.b    "Level",0,0,0
    dc.w    192,35
    dc.b    "Lines",0,0,0
    dc.w    192,60
    dc.b    "Score",0,0,0
    dc.w    184,85
    dc.b    "HiScore",0
    dc.w    198,111
    dc.b    "Next",0,0,0,0
    dc.w    -1
TxAttr
    dc.l    FontName
    dc.w    8
    dc.b    FS_NORMAL
    dc.b    FPF_ROMFONT!FPF_DESIGNED
DOSName     dc.b 'dos.library',0
IntName     dc.b 'intuition.library',0
GfxName     dc.b 'graphics.library',0
UtlName     dc.b 'utility.library',0
 ifne USELL
NVName	    dc.b 'nonvolatile.library',0
LowLevelName dc.b 'lowlevel.library',0
ERLLibLauft dc.b 'Lowlevel.library not',10
	    dc.b 'found or JoyPort in use.',0
 endc
GOTxt1	    dc.b 'Game Over!',0
GOTxt2	    dc.b 'Please Try Again.',0
SelectTxt   dc.b 'Select Level',0
VarName     dc.b 'KlotzHiScore',0
ArgTemplate dc.b 'PUBSCREEN/K,KEYS/K,LACE/S,NOLACE/S,USEKEYS/S,MONO/S,NOSOUND/S,GBMODE/S',0
Klotz	    dc.b 'Klotz',0
KlotzPaused dc.b 'Klotz - Game Paused',0
FontName    dc.b 'topaz.font',0
    cnop    0,4
    locend
 END
