*
*   $VER:   TimerUtils.asm 0.14 (1.9.93)
*			    0.13 (13.8.93)   oh Freitag, der 13te
*
InitTimer
*
* SetUp: OpenDevice AllocMem AllocSignals ...
*   <=	 d0  : Fail if <0
    push    a0-a6/d1-d7
*   Gibt's mich schon ?
    CSYS    Forbid
    lea     KlotzName(pc),a1
    CALL    FindPort
    CALL    Permit
    tst.l   d0
    beq.s   .weiter
    pea     ERKlotzOk(pc)
    pea     ERKlotzLauft(pc)
    pea     ERKlotzTitel(pc)
    pea     0
    pea     20	; es_SIZEOF
    move.l  sp,a1
    clra.l  a0
    clra.l  a2
    clra.l  a3
    CINT    EasyRequestArgs
    lea     20(sp),sp
    bra.s   .ErrorExit2
.weiter
    moveq   #-1,d0
    reloc.w d0,WakeUpTime
    reloc.w d0,WakeUpMove
    reloc.w d0,WakeUpSpin

    move.l  #MEMF_PUBLIC!MEMF_CLEAR,d1
    moveq   #MP_SIZE,d0
    CSYS    AllocVec
    reloc.l d0,TPort
    bne.s   .TPortOk
.ErrorExit
    bsr     ExitTimer
.ErrorExit2
    moveq   #-1,d0
    bra     .Exit
.TPortOk
    move.l  d0,a0
    move.b  #NT_MSGPORT,LN_TYPE(a0)
    lea     KlotzName(pc),a1
    move.l  a1,LN_NAME(a0)
    move.b  #PA_SOFTINT,MP_FLAGS(a0)
    lea     InterruptStruct,a1
    move.l  a4,IS_DATA(a1)          ; Globale Daten
    move.l  a1,MP_SOFTINT(A0)
    move.l  a0,a2
    move.l  a0,a1
    CALL    AddPort
    move.l  a2,a0    ;<- Da war er (der die Rev-Nr. hochtreibt)
    moveq   #IOTV_SIZE,d0
    CALL    CreateIORequest
    reloc.l d0,TReq
    beq.s   .ErrorExit
    move.l  d0,a1
    lea     TimerName(pc),a0
    moveq   #UNIT_MICROHZ,d0
    moveq   #0,d1
    CALL    OpenDevice
    tst.l   d0
    bne.s   .ErrorExit

    moveq   #-1,d0
    CALL    AllocSignal
    reloc.w d0,WakeUpTime
    bmi.s   .ErrorExit
    moveq   #1,d2
    lsl.l   d0,d2
    reloc.l d2,WUTimeMsk
    moveq   #-1,d0
    CALL    AllocSignal
    reloc.w d0,WakeUpMove
    bmi.s   .ErrorExit
    moveq   #1,d3
    lsl.l   d0,d3
    reloc.l d3,WUMoveMsk
    moveq   #-1,d0
    CALL    AllocSignal
    reloc.w d0,WakeUpSpin
    bmi     .ErrorExit
    moveq   #1,d4
    lsl.l   d0,d4
    reloc.l d4,WUSpinMsk

    moveq   #0,d1
    or.l    d4,d1
    or.l    d3,d1
    or.l    d2,d1
    reloc.l d1,WUMsk
    moveq   #0,d0
.Exit
    pop     a0-a6/d1-d7
    rts

ExitTimer
*
*   CleanUp
*
    push    d0-d3/a0-a1/a6
    bsr.s   StopTimer
    moveq   #25,d1
    CDOS    Delay
    copy.w  WakeUpSpin,d0
    bmi.s   .NoSpin
    CSYS    FreeSignal
.NoSpin
    copy.w  WakeUpMove,d0
    bmi.s   .NoMove
    CSYS    FreeSignal
.NoMove
    copy.w  WakeUpTime,d0
    bmi.s   .NoTime
    CSYS    FreeSignal
.NoTime
    copy.l  TReq,d3
    beq.s   .noReq
    move.l  d3,a1
    CSYS    CloseDevice
    move.l  d3,a0
    CALL    DeleteIORequest
.noReq
    copy.l  TPort,d3
    beq.s   .noPort
    move.l  d3,a1
    CSYS    RemPort
    move.l  d3,a1
    CALL    FreeVec
.noPort
    pop     d0-d3/a0-a1/a6
    rts
 loc.l TReq  ;dc.l 0
 loc.l TPort ;dc.l 0
 loc.w TCount ;  dc.w 0
 loc.w TCount2 ;dc.w 0
 loc.l WUTimeMsk ;  dc.l 0
 loc.l WUMoveMsk ;  dc.l 0
 loc.l WUSpinMsk ;  dc.l 0
 loc.l WUMsk	;  dc.l 0
 loc.w WakeUpTime ; dc.w -1
 loc.w WakeUpMove ; dc.w -1
 loc.w WakeUpSpin ; dc.w -1
*    cnop    0,4
 section "data",data
InterruptStruct
    dc.l    0,0
    dc.b    NT_UNKNOWN,16 ;NT_INTERRUPT,0 wegen Cause() ?
    dc.l    KlotzName
    dc.l    0
    dc.l    TimerInterrupt
 section "",code
 loc.b Timer ; dc.b  0
 loc.b pad4017
 even
StopTimer
*
*   Halt-Flag setzen
*
    copy.l  TPort,d0	    TPort überhaupt initialisiert ?
    beq.s   .Ende
    move.l  d0,a0
    move.b  #PA_IGNORE,MP_FLAGS(a0)
    sf	    Timer(a4)
.Ende
    rts

StartTimer
*
*   ( was soll man dazu sagen ? )
*
*   =>	 d0  : TimeOut in µs
BeginIO     equ  -30
    lea     Timer(a4),a0
    st	    (a0)
    push    a6
    bsr.s   StartTimerInterrupt
    pop     a6
    rts
StartTimerInterrupt
    copy.l  TReq,a1
    move.w  #TR_ADDREQUEST,IO_COMMAND(a1)
    clr.l   IOTV_TIME+TV_SECS(a1)
    move.l  d0,IOTV_TIME+TV_MICRO(a1)
    move.l  IO_DEVICE(a1),a6
    jmp     BeginIO(a6)
TimerWait		; Levelabhängige Wartezeit etwa altes Level * 85%
    dc.b 80,68,57,48,40,34,28,23,19,16,13,11,9,8,7,6,5,4,3,2,1,0
    even

TimerInterrupt
    push    a3/a4/a6
    move.l  a1,a4
    copy.l  TPort,a0
    CSYS    GetMsg
    tst.l   d0
    beq.s   .exitinter
    copy.b  Timer,d0
    beq.s   .exitinter

    lea     TCount(a4),a3
    copy.l  Level,d0

    move.b  TimerWait(pc,d0),d1
    ext.w   d1

    move.w  (a3),d0
    cmp.w   d1,d0
    blt.s   .noTimeOut
    copy.l  OwnTask,a1
    copy.l  WUTimeMsk,d0
    CALL    Signal
    clr.w   (a3)
    bra.s   .StartTimer
.noTimeOut
    addq.w  #1,(a3)

*   ...still under development...
    bsr     TestFire
    beq.s   .noFire
    copy.l  OwnTask,a1
    copy.l  WUSpinMsk,d0
    CALL    Signal
    bra.s   .StartTimer
.noFire
    lea     TCount2(a4),a3
    bsr     TestJoy
    bmi.s   .noTimeOutTest
    beq.s   .StartTimer
    move.w  (a3),d0
    cmpi.w  #10,d0		Millisec TimeOut für Movement
    bge.s   .limiterreicht
    addq.w  #1,d0
    move.w  d0,(a3)
    bra.s   .StartTimer
.noTimeOutTest
.limiterreicht
    clr.w   (a3)
    copy.l  OwnTask,a1
    copy.l  WUMoveMsk,d0
    CALL    Signal
*   ...
.StartTimer
    move.l  #10000,d0
    bsr     StartTimerInterrupt
.exitinter
    pop     a3/a4/a6
    moveq   #0,d0
    rts
KlotzName   dc.b 'KlotzTimer',0
TimerName   dc.b 'timer.device',0
ERKlotzTitel dc.b 'Information',0
ERKlotzLauft dc.b 'Klotz is already running.',0
ERKlotzOk    dc.b 'OK',0
 even
