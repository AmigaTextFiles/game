* Mathtest
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
    include "DebugUtils.asm"
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

    moveq   #2,d0
    bsr     ToFixed
    push    d0
    bsr     LongOut
    move.l  d0,d2
    moveq   #1,d0
    bsr     ToFixed
    push    d0
    bsr     LongOut
    move.l  d2,d0
    bsr     FixedInv
    push    d0
    bsr     LongOut
    move.l  #44,d0
    bsr     ToFixed
    push    d0
    bsr     LongOut
    move.l  d0,d3
    bsr     FixedInv
    push    d0
    bsr     LongOut

    move.l  d2,d0
    move.l  d2,d1
    bsr     FixedMul
    push    d0
    bsr     LongOut
    move.l  d0,d1
    move.l  d3,d0
    bsr     FixedDiv
    push    d0
    bsr     LongOut
    move.l  #$18000,d0
    move.l  #$A4000,d1
    bsr     FixedMul

    push    d0
    bsr     LongOut

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
 loc.l DOSBase
 loc.l IntBase
 loc.l GfxBase
 loc.l UtlBase
DOSName     dc.b 'dos.library',0
IntName     dc.b 'intuition.library',0
GfxName     dc.b 'graphics.library',0
UtlName     dc.b 'utility.library',0
 locend
 end
