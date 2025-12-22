****************************************************************************
*
* vertbserver.asm. Interrupt server for vertical blank
*
*-------------------------------------------------------------------------
* Authors: Casper Gripenberg  (casper@alpha.hut.fi)
*          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
*

    INCLUDE "exec/types.i"
    INCLUDE "hardware/custom.i"
    INCLUDE "hardware/intbits.i"

        XDEF    _VertBServer
        XDEF    @VertBServer

JSRLIB MACRO
        XREF _LVO\1
        JSR  _LVO\1(a6)
        ENDM

        STRUCTURE VERTBDATA,0
          APTR  VBD_maintask
          ULONG VBD_mainsig
          UWORD VBD_sigframe
          APTR  VBD_nframes
        LABEL VERTBDATA_SIZEOF
 

* Entered with:       A0 == scratch (execpt for highest pri vertb server)
*  D0 == scratch      A1 == is_Data
*  D1 == scratch      A5 == vector to interrupt code (scratch)
*                     A6 == scratch
*
    section code

_VertBServer:
@VertBServer:
         MOVE.L  VBD_nframes(a1),a0  ; get pointer to framcounts
         ADDI.W  #1,(a0)             ; increments framecounts
         MOVE.W  VBD_sigframe(a1),d0 ; get framenumber for signal
         CMP.W   (a0),d0             ; see if the specified amount of frames has been reached
         BGT.S   OuttaHere           ; exit if not
         MOVE.L  VBD_mainsig(a1),d0  ; get signal allocated by main
         MOVE.L  VBD_maintask(a1),a1 ; and pointer to main task
         MOVE.L  4,a6                ; execbase
         JSRLIB  Signal              ; tell main it's time for a screenchange
OuttaHere:
	 MOVEQ.L #0,d0               ; set Z flag to continue to process other vb-servers
         MOVE.L  #$dff000,a0         ; custom chip address
         RTS                         ; return to exec
         END
