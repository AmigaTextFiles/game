*
*	$VER: EntryExit.asm 1.1 (4.10.94) mymacros2.2
*			    1.0 (17.7.93)
*			    MedRes Team
StartUp
    move.l  ExecBase,a6
    cmpi.w  #37,LIB_VERSION(a6)     Man sollte mind. WB 2.0 haben
    blt.s    .NOVersion
* globale Daten in allokierten Puffer
    move.l  #LOCLEN,d0
    move.l  #MEMF_PUBLIC!MEMF_CLEAR,d1
    CALL    AllocVec
    tst.l   d0
    bne     .AllocOK
.NOVersion
    moveq   #20,d0
    rts
.AllocOK
    move.l  d0,a4
    reloc.l a6,SysBase
    clra.l  a1
    CALL    FindTask
    move.l  d0,a3
    reloc.l a3,OwnTask
    move.l  a4,TC_Userdata(a3)   TaskUserData zeigt auf globale Daten
    move.l  pr_CLI(a3),d0
    bne     .notFromWB

.fromWB
    lea     pr_MsgPort(a3),a0
    CALL    WaitPort
    lea     pr_MsgPort(a3),a0
    CALL    GetMsg
    reloc.l d0,WBenchMsg
.notFromWB
    bsr     main
    moveq   #RETURN_OK,d0
exit
    bsr.s   getA4
    move.l  d0,d2
    copy.l  OwnTask,a3
    move.l  pr_ReturnAddr(a3),a5
    subq.l  #4,a5
    move.l  a5,sp

    copy.l  SysBase,a6

    copy.l  WBenchMsg,d0
    beq     .noWBExit

    CALL    Forbid
    move.l  d0,a1
    CALL    ReplyMsg
.noWBExit
    move.l  a4,a1
    CALL    FreeVec		Aua - das hat gefehlt !
    move.l  d2,d0
    rts
getA4
* <= a4 : Globale Datenstruktur
    push    a0-a1/a6/d0-d1
    move.l  ExecBase,a6
    clra.l  a1
    CALL    FindTask
    move.l  d0,a0
    move.l  TC_Userdata(a0),a4
    pop     a0-a1/a6/d0-d1
    rts
* Daten
    loc.l   SysBase
    loc.l   OwnTask
    loc.l   WBenchMsg

