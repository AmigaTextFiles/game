* Audiotest
    include "exec/types.i"
    include "exec/tasks.i"
    include "exec/memory.i"
    include "dos/dos.i"
    include "dos/dosextens.i"
    include "workbench/startup.i"
    include "workbench/workbench.i"

    include "mymacros.i"
    locinit
    include "EntryExit.asm"
    include "MathUtils.asm"
    include "AudioUtils.asm"
    include "DebugUtils.asm"

hilfe	macro
    pea     \1(pc)
    bsr     StringOut
    push    \2
    bsr     LongOut
    endm

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

    bsr     ToTest

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
StrLen
*  Zeichenkettenlänge
*   =>	 a0: Zeichenkette
*   <=	 a0:   "
*  d0: Länge
    moveq   #-1,d0
.xloop
    addq.l  #1,d0
    cmpi.b  #0,0(a0,d0.l)
    bne     .xloop
    rts

 loc.l DOSBase
 loc.l IntBase
 loc.l GfxBase
 loc.l UtlBase
DOSName     dc.b 'dos.library',0
IntName     dc.b 'intuition.library',0
GfxName     dc.b 'graphics.library',0
UtlName     dc.b 'utility.library',0
NoAudio     dc.b 'Keine Musik (open failed)??',0
Piep	    dc.b ' Piep ',0
SmpName     dc.b 'hd4:buntes/mission2',0
    even
 loc.l	smp
 loc.l	smplen
ToTest
    bsr     InitAudio
    tst.l   d0
    beq     .weiter
    pea     NoAudio
    bsr     StringOut
    rts
.weiter
    lea     SmpName(pc),a0
    lea     smp(a4),a1
    bsr     LoadSample

    lea     per(pc),a2
.loop
*    lea     musi,a0
    copy.l  smp,a0
    copy.l  smplen,d0
    move.w  (a2)+,d1
    beq     .ende
    swap    d1
    move.w  #28,d1
    bsr     PlayAudio
    pea     Piep(pc)
    bsr     StringOut
    bra     .loop
.ende
    bsr     ExitAudio
    rts
per:
    dc.w 160,240,480,960,0
 locend

* section "sound",data,chip
*
*musi:
* dc.b 0,39,75,103,121,127,121,103,75,39,0
* dc.b -39,-75,-103,-121,-127,-121,-103,-75,-39
* dc.b 0,90,127,90,0,-90,-127,-90
 end

