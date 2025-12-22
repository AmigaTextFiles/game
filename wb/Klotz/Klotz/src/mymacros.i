*
* $VER: MyMacros.i  2.3 (6.10.94)
*		    2.1 (6.3.94)
*

MYMVERSION   equ    23

* Macros für Libraryaufrufe (small.lib)
*	     Reentrantfähige Programme
*
ExecBase     equ    4

CALL MACRO
     xref    _LVO\1
     jsr     _LVO\1(a6)
     ENDM

CSYS MACRO
     copy.l SysBase,a6
     CALL    \1
     ENDM

CGFX MACRO
     copy.l GfxBase,a6
     CALL    \1
     ENDM

CINT MACRO
     copy.l IntBase,a6
     CALL    \1
     ENDM

CDOS MACRO
     copy.l DOSBase,a6
     CALL    \1
     ENDM

*
* Stackmanagement
*
push MACRO
     IFC     '\1','all'
     movem.l D0-D7/A0-A6,-(SP)
     ENDC
     IFNC    '\1','all'
     movem.l \1,-(SP)
     ENDC
     ENDM
pop  MACRO
     IFC     '\1','all'
     movem.l (SP)+,D0-D7/A0-A6
     ENDC
     IFNC    '\1','all'
     movem.l (SP)+,\1
     ENDC
     ENDM
*
* Globale Variablenspeicherung
*
reloc MACRO
     move.\0 \1,\2(a4)
     ENDM

copy MACRO
     move.\0  \1(a4),\2
     ENDM

on   MACRO
     IFC    '\0','B'
     st     \1(a4)
     ENDC
     IFNC    '\0','B'
     move.\0 #-1,\1(a4)
     ENDC
     ENDM

off  MACRO
     IFC    '\0','B'
     sf     \1(a4)
     ENDC
     IFNC    '\0','B'
     clr.\0  \1(a4)
     ENDC
     ENDM

loc  MACRO
\1   equ    LOCATIONCOUNT
     IFC    '\0','L'
LOCATIONCOUNT	set	LOCATIONCOUNT+4
     ENDC
     IFC   '\0','W'
LOCATIONCOUNT	set	LOCATIONCOUNT+2
     ENDC
     IFC   '\0','B'
LOCATIONCOUNT	set	LOCATIONCOUNT+1
     ENDC
     ENDM
bloc MACRO
\1   equ    LOCATIONCOUNT
LOCATIONCOUNT	set	LOCATIONCOUNT+\2
     ENDM
locinit MACRO
LOCATIONCOUNT	set	0
    ENDM

locend	MACRO
LOCLEN	equ LOCATIONCOUNT
    ENDM

*
*  Ministartup
*  [ ohne CLI-Parse oder WBStartupMsg ]
*
MINISTART   macro
    locinit
    loc.l   SysBase
Start
    move.l  ExecBase,a6
    move.l  #LOCLEN,d0
    moveq   #1,d1
    swap    d1
    addq.b  #1,d1
    CALL    AllocVec
    tst.l   d0
    bne     .ok
    moveq   #20,d0
    rts
.ok
    move.l  d0,a4
    reloc.l a6,SysBase
    bsr     .main
    move.l  a4,a1
    CSYS    FreeVec
    moveq   #0,d0
    rts
.main
    ENDM

PRGSTART    macro
    MINISTART
    endm

PRGEND	    macro
    locend

    ENDM

* Anderes
*
clra MACRO
     suba.\0 \1,\1
     ENDM

