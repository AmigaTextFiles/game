**
** Tenablaster(tm) Protection code (c)1997 Copyright Peter Bakota
**

DoProt	st	MotorFlag(a5)
	move.l	PlaneA(a5),d0
	move.l	CopperListA(a5),a0
	bsr	MakeCList42
	move.l	CopperListA(a5),a0
	bsr	SetCopperList
	bsr	ClearAllPlanes
	lea	ProtText(pc),a0
	sub.l	a1,a1
	moveq	#17,d1
	bsr	PrintTextLinesA
	moveq	#4,d0
	moveq	#4,d1
	moveq	#34,d2
	moveq	#17,d3
	moveq	#8,d4
	bsr	DrawBoxA
	lea	DefaultPaletta(pc),a1
	move.w	#$828,(a1)
	bsr	SetCopPaletta
	moveq	#3-1,d7
.CkLoop	moveq	#10,d0
	bsr	Random
	move.w	d0,d6
	moveq	#10,d0
	bsr	Random
	move.w	d0,d5
	movem.w	d5/d6,-(sp)
	lea	78*42*5+16,a1
	moveq	#9,d1
	move.w	d6,d0
	bsr	PrintDECNum
	lea	78*42*5+28,a1
	moveq	#9,d1
	move.w	d5,d0
	bsr	PrintDECNum
	lea	PasBuf(pc),a0
	lea	96*42*5+22,a1
	moveq	#0,d3
	moveq	#4,d5
	bsr	EnterString
	movem.w	(sp)+,d0/d1
	move.l	PasBuf(pc),d2
	eor.l	#"ABCD",d2
	bsr	CkPass
	bne	.BadPass
	bset	#bitPASSOK,SysFlags+1(a5)
	bra	.Exit
.BadPass
	lea	PasBuf(pc),a0
	move.l	#$20202020,(a0)
	lea	96*42*5+22,a1
	moveq	#1,d0
	bsr	PrintTextLinesA
	dbf	d7,.CkLoop
.Exit	bsr	ClearCopPaletta
	rts

ProtText
	dc.b	"u10;60;P R O T E C T I O N :"
	dc.b	"u10;78;p10;LINE :    COLUMN :"
	dc.b	"u10;96;ENTER WORD :",0
	even
* wx=d0, wy=d1, word=d2
CkPass	lea	PassCodes(pc),a0
	mulu.w	#10*4,d1
	lsl.w	#2,d0
	add.w	d1,d0
	cmp.l	(a0,d0.w),d2
	rts
PassCodes
	dc.l	"YEVJ"^"ABCD","CKCD"^"ABCD","DIJU"^"ABCD","HEKA"^"ABCD","YGFC"^"ABCD","HHRJ"^"ABCD","XTSF"^"ABCD","NQJS"^"ABCD","EEHL"^"ABCD","THQO"^"ABCD"
	dc.l	"DTUX"^"ABCD","PBWW"^"ABCD","PEAX"^"ABCD","EWHU"^"ABCD","PYKR"^"ABCD","HGGY"^"ABCD","TDEQ"^"ABCD","EBWA"^"ABCD","UQEC"^"ABCD","YSND"^"ABCD"
	dc.l	"AVEO"^"ABCD","BVGR"^"ABCD","YXLK"^"ABCD","URLK"^"ABCD","PQFI"^"ABCD","WTCG"^"ABCD","CPHS"^"ABCD","UENO"^"ABCD","GUII"^"ABCD","KHUU"^"ABCD"
	dc.l	"YGNT"^"ABCD","OACA"^"ABCD","RGDU"^"ABCD","HNMF"^"ABCD","AEUC"^"ABCD","OQEA"^"ABCD","FSEP"^"ABCD","TICB"^"ABCD","OMLB"^"ABCD","AIMO"^"ABCD"
	dc.l	"APQL"^"ABCD","WKHS"^"ABCD","OAMQ"^"ABCD","UCQJ"^"ABCD","XDNS"^"ABCD","MBKH"^"ABCD","THVQ"^"ABCD","PSVX"^"ABCD","NGMP"^"ABCD","DNRQ"^"ABCD"
	dc.l	"QSAP"^"ABCD","XRDL"^"ABCD","GRAA"^"ABCD","DPAI"^"ABCD","MGLV"^"ABCD","WHHX"^"ABCD","EVIO"^"ABCD","NYYT"^"ABCD","GUDJ"^"ABCD","KNXB"^"ABCD"
	dc.l	"FYJT"^"ABCD","DAAA"^"ABCD","SXAA"^"ABCD","FDEK"^"ABCD","AXXT"^"ABCD","MVFA"^"ABCD","JYOH"^"ABCD","SRDC"^"ABCD","VMJK"^"ABCD","YJQF"^"ABCD"
	dc.l	"LXFN"^"ABCD","DIPF"^"ABCD","XCYL"^"ABCD","NFUC"^"ABCD","YRAS"^"ABCD","JFCK"^"ABCD","AXRG"^"ABCD","BUET"^"ABCD","QVUS"^"ABCD","CAWF"^"ABCD"
	dc.l	"WYEA"^"ABCD","CFWA"^"ABCD","AREA"^"ABCD","THAU"^"ABCD","UVAQ"^"ABCD","AJUL"^"ABCD","FGMW"^"ABCD","OGEF"^"ABCD","WCIV"^"ABCD","RXQM"^"ABCD"
	dc.l	"KLUK"^"ABCD","KYAD"^"ABCD","BWDY"^"ABCD","CETE"^"ABCD","FUAK"^"ABCD","ADSC"^"ABCD","XCCE"^"ABCD","TJIK"^"ABCD","EPPK"^"ABCD","UHJH"^"ABCD"
PasBuf	ds.l	1
	ds.w	1

