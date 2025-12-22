		opt	o+,ow-,ow6+

		; Llama Release #3
		; © 1993-94 David Kinder
		; Replacement loader for Llamatron

		include	devices/audio.i

LLAMACODE	equ	$1827C
LLAMASIZE	equ	$50596

CALLSYS		macro
		jsr	_LVO\1(a6)
		endm

		section	code,code

		suba.l	a1,a1
		CALLEXEC FindTask
		move.l	d0,a4

		tst.l	pr_CLI(a4)
		bne.s	AllRun

		lea	pr_MsgPort(a4),a0
		CALLSYS	WaitPort
		lea	pr_MsgPort(a4),a0
		CALLSYS	GetMsg
		move.l	d0,ReturnMsg

AllRun		move.l	#$FF000,a5
AllocLoop	move.l	a5,a1
		suba.l	#$1000,a5
		move.l	#MainCodeEnd-MainCode+4,d0
		CALLSYS	AllocAbs
		move.l	d0,d7
		beq.s	AllocLoop

		lea	MainCode,a0
		move.l	d7,a1
CopyMLoop	move.l	(a0)+,(a1)+
		cmpa.l	#MainCodeEnd,a0
		ble	CopyMLoop

		lea	AudioReq,a1
		lea	AudioPort,a2
		lea	MP_MSGLIST(a2),a3
		NEWLIST	a3
		move.l	a2,MN_REPLYPORT(a1)
		move	#ioa_SIZEOF,MN_SIZE(a1)
		move.b	#NT_MESSAGE,LN_TYPE(a1)

		lea	AudioName,a0
		moveq	#0,d0
		moveq	#0,d1
		CALLSYS	OpenDevice

		lea	AudioReq,a1
		move	#CMD_RESET,IO_COMMAND(a1)
		BEGINIO

		lea	AudioReq,a1
		CALLSYS	CloseDevice

		move.l	#LLAMASIZE,d0
		moveq	#0,d1
		CALLSYS	AllocMem
		move.l	d0,d5
		beq.s	Error

		moveq	#0,d0
		lea	DOSName,a1
		CALLSYS	OpenLibrary
		move.l	d0,a6

		move.l	ReturnMsg,a0
		cmpa.l	#0,a0
		beq.s	NoWB
		move.l	sm_ArgList(a0),a0
		move.l	wa_Lock(a0),d1
		CALLSYS	CurrentDir

NoWB		lea	LlamaName,a0
		move.l	a0,d1
		move.l	#MODE_OLDFILE,d2
		CALLSYS	Open
		move.l	d0,d6
		beq.s	Error

		move.l	d6,d1
		move.l	d5,d2
		move.l	#LLAMASIZE,d3
		CALLSYS	Read

		move.l	d6,d1
		CALLSYS	Close

		moveq	#0,d0
		lea	GfxName,a1
		CALLEXEC OpenLibrary
		move.l	d0,a6

		suba.l	a1,a1
		CALLSYS	LoadView

		CALLSYS	WaitTOF
		CALLSYS	WaitTOF

		move.l	d7,a0
		jmp	(a0)

Error		rts

MainCode	lea	RunCode(pc),a5
		CALLEXEC Supervisor

RunCode		move.l	d5,a0
		move.l	#LLAMACODE,a1
		moveq	#0,d0
CopyLoop	move.l	(a0,d0.l),(a1,d0.l)
		addq.l	#4,d0
		cmpi.l	#LLAMASIZE,d0
		ble.s	CopyLoop

		move.l	#LLAMACODE,a0
		jmp	(a0)
MainCodeEnd

		section	data,data

AudioPort	ds.b	MP_SIZE
AudioReq	ds.b	ioa_SIZEOF
ReturnMsg	ds.l	1

DOSName		dc.b	"dos.library",0
GfxName		dc.b	"graphics.library",0
LlamaName	dc.b	"Tron1Meg",0
AudioName	dc.b	"audio.device",0
