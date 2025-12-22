*
* $VER: AudioUtils.asm	0.2 (4.1.97) BeginIO mit Quick-Flag
*			0.1 (1.1.97)
*			0.0 (30.12.96)
*
*
* introducing AUDIO PRO SFX to your AMIGA system
*
 include "exec/errors.i"
* include "exec/execbase.i"
ex_EClockFrequency  equ 568
 include "devices/audio.i"
 loc.l AudioPort
 loc.l AudioIO
 loc.l AudioClock
 loc.l AudioPool


*Notes	   dc.b "ABHC1D2EF3G4abhc5d6ef7g8",0
AudioName dc.b "audio.device",0
    even
InitAudio
	push	a6
	CSYS	CreateMsgPort
	tst.l	d0
	beq	.whatthefk

	reloc.l d0,AudioPort
	move.l	d0,a0
	moveq	#ioa_SIZEOF,d0
	CALL	CreateIORequest
	tst.l	d0
	beq	.whatthefk
	reloc.l  d0,AudioIO
	move.l	d0,a1
*	 move.b  #NT_UNKNOWN,LN_TYPE(a1)
	lea	AudioName(pc),a0
	moveq	#0,d0
	move.l	d0,d1
	CALL	OpenDevice
	tst.l	d0
	beq	.ok
	cmpi.l	#IOERR_OPENFAIL,d0
	beq	.whatthefk
.ok
	move.l	ex_EClockFrequency(a6),d0
	move.l	d0,d1
	add.l	d0,d0
	add.l	d0,d0
	add.l	d1,d0
*	 addq.l  #1,d0
*	 lsr.l	 #1,d0
	reloc.l d0,AudioClock		    ; Fünffache des EClock-Takts ( Hälfte des System-Takts)
*	 move.l  d0,-(sp)
*	 bsr	 LongOut
; Init memory pool for samples
	moveq	#MEMF_CHIP!MEMF_PUBLIC,d0
	move.l	#8000,d1
	move.l	d1,d2
	CALL	CreatePool
	tst.l	d0
	beq	.whatthefk
	reloc.l d0,AudioPool
	moveq	#0,d0
.exit
	pop	a6
	rts
.whatthefk
	moveq	#-1,d0
	bra	.exit

ExitAudio
	push	a2/a6
	copy.l	AudioPool,d0
	beq	.freeio
	move.l	d0,a0
	CSYS	DeletePool
.freeio
	copy.l	AudioIO,a2
	move.l	a2,d0
	beq	.freeport
*	 move.l  a2,a1		Fatal, wenn nicht benutzt
*	 CSYS	 CheckIO
*	 tst.l	 d0
*	 bne	 .ok
*	 move.l  a2,a1
*	 CALL	 AbortIO
*	 move.l  a2,a1
*	 CALL	 WaitIO
*.loop	 copy.l  AudioPort,a0
*	 CALL	 GetMsg
*	 tst.l	 d0
*	 beq	 .ok
*	 move.l  d0,a1
*	 CALL	 ReplyMsg
*	 bra	 .loop
.ok
	move.l	a2,a1
	CALL	CloseDevice
	move.l	a2,a0
	CALL	DeleteIORequest
.freeport
	copy.l	AudioPort,a0
	CSYS	DeleteMsgPort
	pop	a2/a6
	rts
LoadSample:
; => a0 : Name
;    a1 : ^ struct smp
; 8-bit signed roh-Daten
	push	d2-d4/a2/a3/a6
	move.l	a1,a3
	move.l	a0,d1
	move.l	#MODE_OLDFILE,d2
	CDOS	Open
	tst.l	d0
	beq	.nofile
	move.l	d0,d4
; Länge bestimmen
	move.l	d0,d1
	moveq	#0,d2
	move.l	#OFFSET_END,d3
	CALL	Seek
	move.l	d4,d1
	move.l	#OFFSET_BEGINNING,d3
	CALL	Seek
	move.l	d0,smp_Length(a3)
	move.l	d0,d3
	copy.l	AudioPool,a0
	CSYS	AllocPooled
	tst.l	d0
	beq	.nomem
	move.l	d0,smp_Data(a3)
	move.w	#$100,smp_Period(a3)
	move.l	d0,d2
	move.l	d4,d1
	CDOS	Read
	bsr	.CheckIFF
.nomem
	move.l	d4,d1
	CDOS	Close
.nofile
	CALL	IoErr
	pop	d2-d4/a2/a3/a6
	rts
.CheckIFF
; => a3: ^ struct smp
    move.l  smp_Data(a3),a0
    move.l  smp_Length(a3),d3
    cmpi.l  #'VHDR',12(a0)
    bne     .fertig
    cmpi.w  #$0100,34(a0)           ; one octave, no compression
    bne     .searchbody
    moveq   #0,d1
    move.l  20(a0),d0               ; OneShotHiSamples
    bne     .ok
    move.l  24(a0),d0               ; repeatHiSamples ( falls mit Loop )
.ok
    move.l  d0,smp_Length(a3)
    move.w  32(a0),d1               ; SamplesPerSec
    copy.l  AudioClock,d0
    bsr     LDiv
    move.w  d0,smp_Period(a3)
.searchbody			    ; man könnte Chunk-Struktur ausnutzen
    move.l  smp_Data(a3),a0
    lea     40(a0),a0
    lsr.l   #1,d3
.loop
    cmpi.w  #'BO',(a0)+
    beq     .maybe
    dbra    d3,.loop
    bra     .fertig
.maybe
    cmpi.w  #'DY',(a0)+
    bne     .loop
    lea     4(a0),a0
    move.l  a0,smp_Data(a3)
.fertig
    rts
 ifne 0
FreqDurToPerCyc
 rts
NoteToPer
; =>	d0 : Note
;	d1 : SampleLänge
; braucht FixedMath
	lea	Notes(pc),a0
	moveq	#-1,d7
.loop
	addq.w	#1,d7
	move.b	(a0)+,d1
	beq	.nomatch
	cmp.b	d1,d0
	bne	.loop
.nomatch
.weiter
	move.l	d7,d1
	moveq	#110,d2
	add.w	d2,d2
	add.w	d2,d2
	add.w	d2,d2
	cmpi.w	#12,d1
	blt	.lower
	add.w	d2,d2
	subi.w	#12,d1
.lower
	move.l	#$00010f39,d0 ; 12te Wurzel aus Zwo
	bsr	FixedPow
	move.l	d2,d1
	swap	d1
	bsr	FixedMul      ; Frequenz
; Period=Clock/(samplesize*frequency)
;  ...
 endc
channelsR dc.b 2,4,1,8
*channelsL dc.b 1,8,2,4

; DOES NOT SAVE A6 !!!( 3 hs of debugging ... )
BEGIN_IO macro
	move.l	IO_DEVICE(a1),a6
	jsr	-30(a6)
	endm
ClearIO
; => a2 : IORequest
; <= a6 : SysBase
	push	d2
	move.l	a2,a1
	CSYS	CheckIO 	    Ton noch an ?
	bne	.ok
	move.l	a2,a1
	CALL	AbortIO
	move.l	a2,a1
	CALL	WaitIO
	moveq	#0,d0
	moveq	#0,d1
	CALL	SetSignal	    ; ist Audiosignal noch gesetzt ?
	copy.l	AudioPort,a0
	move.b	MP_SIGBIT(a0),d1
	moveq	#1,d2
	lsl.l	d1,d2
	or.l	d2,d0
	beq	.ok		    ; Signal löschen
	move.l	d2,d0
	CALL	Wait
	copy.l	AudioPort,a0
	CALL	GetMsg
.ok
	pop	d2
	rts
PlayAudio
; => a0 : ^struct Smp
;
	tst.l	smp_Length(a0)
	beq	.goodbye

	push	a2/a3/a6
	link	a5,#0
	move.l	a0,a3
;	Sound Kanal kriegen ...
	lea	channelsR(pc),a0
*jump_in
	copy.l	AudioIO,a2
	tst.l	IO_UNIT(a2)
	bne	.sound

	move.l	a2,a1
	move.w	#ADCMD_ALLOCATE,IO_COMMAND(a1)
	move.b	#ADIOF_NOWAIT!IOF_QUICK,IO_FLAGS(a1)
	move.b	#30,LN_PRI(a1)
	moveq	#4,d0
	move.l	a0,ioa_Data(a1)
	move.l	d0,ioa_Length(a1)
	BEGIN_IO
	move.l	a2,a1
	CSYS	WaitIO
	tst.l	IO_UNIT(a2)
	bne	.sound
.bye
	unlk	a5
	pop	a2/a3/a6
.goodbye
	rts
.sound
	bsr	ClearIO
	move.l	a2,a1
	move.w	#CMD_WRITE,IO_COMMAND(a1)
	move.b	#ADIOF_PERVOL,IO_FLAGS(a1)
	move.l	smp_Data(a3),ioa_Data(a1)
	move.l	smp_Length(a3),ioa_Length(a1)
	moveq	#32,d0
	move.w	d0,ioa_Volume(a1)
	moveq	#1,d0
	move.w	d0,ioa_Cycles(a1)
	move.w	smp_Period(a3),ioa_Period(a1)
	BEGIN_IO
*	 move.l  a2,a1
*	 CSYS	 WaitIO
	bra	.bye
FreeAudio
	push	a0-a2/d0-d1/a6
	copy.l	AudioIO,a2
	tst.l	IO_UNIT(a2)
	beq	.exit
*	 copy.l  AudioPort,a0
*	 CSYS	 WaitPort
	bsr	ClearIO
	copy.l	AudioPort,a0
	CALL	GetMsg

	move.l	a2,a1
	move.w	#ADCMD_FREE,IO_COMMAND(a1)
*	 BEGIN_IO
*	 move.l  a2,a1
*	 CSYS	 WaitIO
	CALL	DoIO
.exit
	pop    a0-a2/d0-d1/a6
	rts
