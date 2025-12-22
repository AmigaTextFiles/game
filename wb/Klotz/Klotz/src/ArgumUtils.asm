*
* $VER: Argum.asm 0.1 (8.10.94)
*
*   Argument-passing für Shell/WB
s_Entry     equ 0
s_Type	    equ 4
s_Num	    equ 5   ; für Zukunft
s_CopyBuf   equ 6   ;	"
s_LEN	    equ 10   ;	(falls überhaupt)
    loc.l   IconBase
    loc.l   ArgBuffer
    loc.l   ArgCLIReadArgs
    bloc    ArgSearchlist,10*s_LEN
    bloc    ArgStringBuffer,12*120
IconName
    dc.b  'icon.library',0
    cnop  0,4
Argum
*   template nur mit /K  /S für WBStart
* ( /M (Dateinamen von Multiselect-Icons) in Vorbereitung )
* - auch eine Möglichkeit, sich herauszureden ...
*
*   => d0: WBenchMsg
*      d1: ReadArg template
*      d2: array

*   CLI - parsing ok
    push    all
    tst.l   d0
    beq     .fromcli			; keine WBStartupMsg -> Parse CLI
    reloc.l d2,ArgBuffer
    lea     ArgStringBuffer(a4),a5
    move.l  d0,a0
    move.l  sm_NumArgs(a0),d3
    move.l  sm_ArgList(a0),a3
    bsr     CmdLine
    move.l  d0,d5

    lea     IconName(pc),a1
    moveq   #37,d0
    CSYS    OpenLibrary
    tst.l   d0
    beq     .default
    reloc.l  d0,IconBase

.toolloop
    tst.l   d3
    beq     .endloop
    move.l  (a3)+,d1            Lock
    CDOS    CurrentDir
    move.l  d0,d2
    move.l  (a3)+,a0            Name

    copy.l  IconBase,a6
    CALL    GetDiskObject
    tst.l   d0
    beq.s   .nextdobj
    move.l  d0,a2
    move.l  a3,-(sp)            wb_arglist abspeichern
    lea     ArgSearchlist(a4),a3
    moveq   #0,d6
.argloop
    move.l  do_ToolTypes(a2),a0
    move.l  s_Entry(a3),a1

    copy.l  IconBase,a6
    CALL    FindToolType
    move.l  d0,d4
    beq.s   .nocopy

    move.l  d6,d7
    add.l   d6,d7
    add.l   d7,d7
    copy.l  ArgBuffer,a0
    cmpi.b  #'S',s_Type(a3)
    bne.s   .isKeyword
    moveq   #-1,d1
    move.l  d1,0(a0,d7)              Switch aktivieren
    bra.s   .nocopy
.isKeyword
    move.l  a5,0(a0,d7)              ^Name  speichern
    move.l  a5,a1		    und kopieren
    move.l  d0,a0
    bsr     StrLen
    lea     1(a5,d0),a5             NULL-Byte überspringen
.copyloop
    move.b  (a0)+,(a1)+
    dbra    d0,.copyloop
*    CSYS    CopyMem
*    push    a5
*    bsr     LongOut
*    lea     120(a5),a5
.nocopy
    lea     s_LEN(a3),a3
    addq.b  #1,d6
    cmp.b   d5,d6
    blt.s   .argloop

    move.l  (sp)+,a3
    copy.l  IconBase,a6
    move.l  a2,a0
    CALL    FreeDiskObject
.nextdobj
    move.l  d2,d1
    CDOS    CurrentDir
    subq.w  #1,d3
    bpl     .toolloop
.endloop
    copy.l  IconBase,a1
    CSYS    CloseLibrary
.ende
.default
    pop     all
    rts
.fromcli
    moveq   #0,d3
    CDOS    ReadArgs
    reloc.l d0,ArgCLIReadArgs
    bra.s   .ende
ArgumFree
* => d0 : WBenchMsg
    tst.l   d0
    beq.s   .nixzutun
    push    a6
    copy.l  ArgCLIReadArgs,d1
    CDOS    FreeArgs
    pop     a6
.nixzutun
    rts
CmdLine
* template aufbereiten
* max. 10 Einträge, sonst ...
* nur Argumente mit einem Modifier
*   => d1  template
*   <= d0 "argc"
    push    d1-d2/a0-a1
    move.l  d1,a0
    moveq   #0,d2		"argc" Anzahl der Argumente
    lea     ArgSearchlist(a4),a1
.findloop
    move.l  a0,s_Entry(a1)
    addq.w  #1,d2
    moveq   #'/',d0
    bsr.s   InStr
    beq.s    .endloop
    clr.b   (a0)+
    move.b  (a0),s_Type(a1)
    moveq   #',',d0
    bsr.s   InStr
    beq.s   .endloop
    addq.w  #1,a0
    lea     s_LEN(a1),a1
    bra.s   .findloop
.endloop
    move.l  d2,d0
    pop     d1-d2/a0-a1
    rts
InStr
*   Suche d0 in Zeichenkette (a0)
*   =>	d0.b Zeichen
*	a0   Zeichenkette
*   <=	d0.b 0 für Fehler sonst
*	a0   Adresse von Zeichen
*
    push    d1
.loop
    move.b  (a0)+,d1
    beq.s   .ende
    cmp.b   d1,d0
    beq.s   .ende
    bra.s   .loop
.ende
    pop     d1
    move.b  -(a0),d0    un-read last char
    rts

