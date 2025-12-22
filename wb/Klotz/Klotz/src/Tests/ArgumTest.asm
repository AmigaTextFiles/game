* Argumtest
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
    include "ArgumUtils.asm"
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
.loop
    addq.l  #1,d0
    cmpi.b  #0,0(a0,d0.l)
    bne     .loop
    rts

 loc.l DOSBase
 loc.l IntBase
 loc.l GfxBase
 loc.l UtlBase
DOSName     dc.b 'dos.library',0
IntName     dc.b 'intuition.library',0
GfxName     dc.b 'graphics.library',0
UtlName     dc.b 'utility.library',0
DefHallo    dc.b 'Mo-oin',0
Beide	    dc.b 'Kleine Racker',0
W	    dc.b 'Schnuddelschäuzchen',0
B	    dc.b 'Griffester',0
Nix	    dc.b 'Ihr da alle',0
HW	    dc.b ' Hallo, Welt !-]',0
Template    dc.b 'Hallo/K,Wauzi/S,Bechie/S',0
    cnop    0,4
    loc.l   ArgHallo
    loc.l   ArgWauzi
    loc.l   ArgBechie
ToTest
    bsr     CreateOut
    copy.l  WBenchMsg,d0
    lea     Template(pc),a0
    move.l  a0,d1
    lea     ArgHallo(a4),a0
    move.l  a0,d2
    bsr     Argum
    copy.l  ArgHallo,d0
    bne     \nodef
    lea     DefHallo(pc),a0
    push    a0
    bra     \endif
\nodef
    push    d0
    bsr     LongOut
    push    d0
\endif
    bsr     StringOut
    copy.l  ArgWauzi,d0
    copy.l  ArgBechie,d1
    tst.l   d0
    beq     \now
    tst.l   d1
    beq     \onlyw
    pea     Beide(pc)
    bra     \ausg
\onlyw
    pea     W(pc)
    bra     \ausg
\now
    tst.l   d1
    beq     \keiner
    pea     B(pc)
    bra     \ausg
\keiner
    pea     Nix(pc)
\ausg
    bsr     StringOut
    copy.l  WBenchMsg,d0
    bsr     ArgumFree
    rts
 locend
 end
