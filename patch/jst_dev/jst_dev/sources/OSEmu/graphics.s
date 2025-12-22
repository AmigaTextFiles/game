* $Id: graphics.s 1.1 1999/02/03 04:10:07 jotd Exp jotd $
**************************************************************************
*	GRAPHICS LIBRARY
**************************************************************************
**************************************************************************
*	INITIALIZATION
**************************************************************************

GFXINIT		move.l	_gfxbase,d0
		beq	.init
		rts

.init		move.l	#1056,d0	;-_LVOWriteChunkyPixels,d0
		move.l	#$220,d1
		lea	_gfxname,a0
		bsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_gfxbase
		
		patch	_LVOOwnBlitter(a0),MYRTS(PC)
		patch	_LVODisownBlitter(a0),MYRTS(PC)
		patch	_LVOInitView(a0),_InitView(PC)
		patch	_LVOInitVPort(a0),_InitVPort(PC)
		patch	_LVOFreeVPortCopLists(a0),_FreeVPortCopLists(PC)
		patch	_LVOInitBitMap(a0),_InitBitMap(PC)
		patch	_LVOInitRastPort(a0),_InitRastPort(PC)
		patch	_LVOMakeVPort(a0),_MakeVPort(PC)
		patch	_LVOMrgCop(a0),_MrgCop(PC)
		patch	_LVOCWait(a0),_CWait(PC)	; added by JOTD
		patch	_LVOCMove(a0),_CMove(PC)	; added by JOTD
		patch	_LVOCBump(a0),_CBump(PC)	; added by JOTD
		patch	_LVOLoadView(a0),_LoadView(PC)
		patch	_LVOLoadRGB4(a0),_LoadRGB4(PC)
		patch	_LVOSetRGB4(a0),_SetRGB4(PC)
		patch	_LVOFreeSprite(a0),_FreeSprite(PC)
		patch	_LVOGetSprite(a0),_GetSprite(PC)
		patch	_LVOChangeSprite(a0),_ChangeSprite(PC)
		patch	_LVOMoveSprite(a0),_MoveSprite(PC)
		patch	_LVOWaitBlit(a0),_WaitBlit(PC)
		patch	_LVOBltBitMap(a0),_BltBitMap(PC)
		patch	_LVOVBeamPos(a0),_VBeamPos(PC)
		patch	_LVODraw(a0),MYRTS(PC)
		patch	_LVOMove(a0),_SETMOVE(PC)
		patch	_LVOSetAPen(a0),_SETAPEN(PC)
		patch	_LVOSetBPen(a0),_SETBPEN(PC)
		patch	_LVOSetDrMd(a0),_SETDRAWMODE(PC)
		patch	_LVOWaitTOF(a0),_WaitTOF(PC)
;;		patch	_LVOWaitBOVP(a0),_WaitBOVP(PC)		; -- added by JOTD
		patch	_LVORectFill(a0),_RectFill(PC)		; -- added by JOTD
		patch	_LVOSetRast(a0),_SetRast(PC)		; -- added by JOTD
		patch	_LVOInitTmpRas(a0),_InitTmpRas(PC)	; -- added by JOTD
		patch	_LVOInitArea(a0),_InitArea(PC)		; -- added by JOTD
		patch	_LVOReadPixel(a0),_ReadPixel(PC)
		patch	_LVOWritePixel(a0),_WritePixel(PC)
		patch	_LVOBltTemplate(a0),_BltTemplate(PC)
		patch	_LVOAllocRaster(A0),_ALLOCRASTER(PC)
		patch	_LVOFreeRaster(A0),_FREERASTER(PC)
		patch	_LVOBltClear(A0),_BLTCLEAR(PC)
		patch	_LVOGetColorMap(A0),_GETCOLORMAP(PC)
		patch	_LVOFreeColorMap(A0),_FREECOLORMAP(PC)
	;;	patch	_LVOUCopperListInit(a0),_UCOPPERLISTINIT(PC) ; -- added by JOTD

		patch	_LVOOpenFont(A0),_OPENFONT(PC)
		patch	_LVOSetFont(A0),_SETFONT(PC)
		patch	_LVOText(A0),_PRINTTEXT(PC)

		MOVE.L	#MYVIEW,gb_ActiView(A0)
		lea	STDCOPPER(PC),a1
		MOVE.L	a1,(gb_LOFlist,A0)
		MOVE.L	a1,(gb_SHFlist,A0)
		MOVE.L	a1,(_custom+cop2lc)
		lea	CPJMP2,a1
		move.l	a1,(gb_copinit,a0)
		MOVE.L	a1,(_custom+cop1lc)
		lea.l   _TOPAZ8FONT(PC),a1		; added by Harry
		move.l  a1,(gb_DefaultFont,a0)		; added by Harry

		moveq	#4,d0				;pal
		cmp.l	#PAL_MONITOR_ID,_monitor
		beq	.1
		moveq	#1,d0				;ntsc
.1		MOVE.W	d0,(gb_DisplayFlags,A0)

		clr.b	(gb_SpriteReserved,a0)

		clr.l	-(a7)				;TAG_DONE
		pea	RESTORECOPPER2(pc)
		move.l	#WHDLTAG_CBSWITCH_SET,-(a7)
		move.l	a7,a0
		move.l	_RESLOAD(pc),a1
		jsr	(resload_Control,a1)
		lea	(12,a7),a7                      ;restore sp
		
		tst.w	(_custom+copjmp1)
		move.w	#DMAF_SETCLR!DMAF_MASTER!DMAF_COPPER!DMAF_BLITTER,(_custom+dmacon)
 
		rts

RESTORECOPPER2	move.l	a1,.save
		move.l	_gfxbase,a1
		move.l	(gb_LOFlist,a1),(_custom+cop2lc)
		move.l	.save,a1
		jmp	(A0)

	CNOP 0,4
.save		dc.l	0
CPJMP2		dc.l	$0201fffe	;wait 0,2
		DC.L	$008A0000
STDCOPPER	DC.L	$FFFFFFFE

MYVIEW
	DC.L	_INITVIEWPORT
	DC.L	STDCOPPER
	DC.L	STDCOPPER
	DC.W	0
	DC.W	0
	DC.W	0

_INITVIEWPORT
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	0
	DC.W	0
	DC.W	0
	DC.W	0
	DC.W	0
	DC.W	0
	DC.B	0,0
	DC.L	_INITRASINFO

_INITRASINFO
	DC.L	0
	DC.L	$EEEEEEEE
	DC.W	0
	DC.W	0

_FONTTABLE
	DC.L	_TOPAZNAME,_TOPAZ8FONT
	DC.L	0

_TOPAZNAME
	DC.B	'topaz.font',0
	EVEN

_TOPAZ8FONT
	DC.L	0,0,0,0,0		;EMPTY MESSAGEPORT
	DC.W	8			;YSIZE
	DC.B	0			;NO SPECIAL STYLE
	DC.B	$41			;FONTFLAGS:DESIGNED,ROMFONT
	DC.W	8			;XSIZE
	DC.W	6			;BASELINE
	DC.W	1			;FETT: 1 PIXEL VERSETZT
	DC.W	1			;1 TASK BENUTZT FONT (DUMMY)
	DC.B	$20			;LOWEST CHAR IS SPACE
	DC.B	$FF			;HIGHEST CHAR IS "y
	DC.L	_TOPAZ8DATA		;FONTIMAGES
	DC.W	$C0			;MODULO
	DC.L	_TOPAZ8OFFSETS		;OFFSETTABLES
	DC.L	0			;NON PROPORTIONAL FONT
	DC.L	0			;NO KERNING

_TOPAZ8DATA
	INCBIN	REPLFONT_DATA

_TOPAZ8OFFSETS
	INCBIN	REPLFONT_BITS

**************************************************************************
*	GRAPHICS LIBRARY FUNCTIONS
**************************************************************************

_UCOPPERLISTINIT:
	cmp.l	#0,a0
	bne.b	.nz
	moveq.l	#0,D0
	bra.b	.exit	; error, returns NULL
.nz
	; ok, we can continue

	mulu	#3,D0	; n*4*3 bytes to initialize
	subq.l	#1,D0
.loop	
	
	move.l	a0,D0
.exit:
	rts

_FreeVPortCopLists:
	move.l	A2,-(A7)
	move.l	A0,A2
	move.l	#200,D1
	move.l	(vp_DspIns,a2),A1
	move.l	(4),A6
	jsr	(_LVOFreeMem,A6)

	clr.l	(vp_DspIns,a2)

	; nothing allocated for the 3 of them below

	clr.l	(vp_SprIns,a2)
	clr.l	(vp_ClrIns,a2)
	clr.l	(vp_UCopIns,a2)

	move.l	(a7)+,A2
	rts

_InitTmpRas:
	move.l	A1,(A0)
	move.l	D0,4(A0)
	move.l	A0,D0
	rts

_InitArea:
	MOVE.L	A1,4(A0)
	MOVE.L	A1,(A0)
	MOVE	D0,18(A0)
	ASL.L	#2,D0
	ADDA	D0,A1
	MOVE.L	A1,12(A0)
	MOVE.L	A1,8(A0)
	CLR	16(A0)
	RTS
	
_InitView
	movem.l	D0/A0,-(A7)
	move.w	#$8,D0
.zero
	clr.w	(A0)+
	dbf	D0,.zero
	movem.l	(A7)+,D0/A0
	rts

_InitVPort	
	movem.l	D0/A0,-(A7)
	move.w	#9,D0
.zero
	clr.l	(A0)+
	dbf	D0,.zero
	movem.l	(A7)+,D0/A0	
	rts

_InitRastPort
	MOVE.L	#$EEEEEEEE,(A1)
	MOVE.L	#0,rp_BitMap(A1)
	MOVE.L	#$EEEEEEEE,rp_AreaPtrn(A1)
	MOVE.L	#$EEEEEEEE,rp_TmpRas(A1)
	MOVE.L	#$EEEEEEEE,rp_AreaInfo(A1)
	MOVE.L	#0,rp_GelsInfo(A1)
	MOVE.L	#$FF0000FF,rp_Mask(A1)	
	MOVE.L	#$01000000,rp_DrawMode(A1)
	CLR.L	rp_Flags(A1)
	CLR.L	rp_cp_x(A1)
	CLR.L	rp_minterms(A1)
	CLR.L	rp_minterms+4(A1)
	CLR.L	rp_PenWidth(A1)
	MOVE.L	#_TOPAZ8FONT,rp_Font(A1)
	CLR.W	rp_AlgoStyle(A1)
	MOVE.L	#$00080008,rp_TxHeight(A1)
	MOVE.L	#$00060008,rp_TxBaseline(A1)
	CLR.L	rp_RP_User(A1)
	RTS

_SETAPEN
	MOVE.B	D0,rp_FgPen(A1)
	RTS

_SETBPEN
	MOVE.B	D0,rp_BgPen(A1)
	RTS

_SETDRAWMODE
	MOVE.B	D0,rp_DrawMode(A1)
	RTS

_SETMOVE
	MOVE.W	D0,rp_cp_x(A1)
	MOVE.W	D1,rp_cp_y(A1)
	RTS

_BLTCLEAR	AND.W	#2,D1
	BNE.S	.FAIL
	LSR.W	#1,D0
	SUBQ.W	#1,D0
.1	CLR.W	(A1)+
	DBF	D0,.1
	RTS

.FAIL		pea	_LVOBltClear
		pea	_gfxname
		bra	_emufail

_ALLOCRASTER
	ADD.W	#$F,D0
	LSR.W	#3,D0
	AND.W	#$FFFE,D0
	MULU	D1,D0
	MOVEQ.L	#MEMF_CHIP!MEMF_PUBLIC,D1
	BSR.W	ALLOCM
	RTS

_FREERASTER
	ADD.W	#$F,D0
	LSR.W	#3,D0
	AND.W	#$FFFE,D0
	MULU	D1,D0
	MOVE.L	A0,A1
	BSR.W	FREEM
	RTS

_GETCOLORMAP
	MOVE.L	D0,-(A7)
	ADD.L	D0,D0
	ADDQ.L	#8,D0
	MOVE.L	#MEMF_CLEAR,D1
	BSR.W	ALLOCM
	TST.L	D0
	BEQ.S	.FAIL
	MOVE.L	D0,A0
	MOVE.L	(A7)+,D1
	MOVE.W	D1,cm_Count(A0)
	LEA.L	8(A0),A1
	MOVE.L	A1,cm_ColorTable(A0)
	CMP.W	#$20,D1
	BLS.S	.1
	MOVEQ.L	#$20,D1
.1	LEA.L	.COLORTAB(PC),A0
.2	MOVE.W	(A0)+,(A1)+
	SUBQ.W	#1,D1
	BNE.S	.2

.FAIL	RTS

.COLORTAB
	DC.B	$00,$00,$0F,$00,$00,$F0,$0F,$F0
	DC.B	$00,$0F,$0F,$0F,$00,$FF,$0F,$FF
	DC.B	$06,$20,$0E,$50,$09,$F1,$0E,$B0
	DC.B	$05,$5F,$09,$2F,$00,$F8,$0C,$CC
	DC.B	$00,$00,$01,$11,$02,$22,$03,$33
	DC.B	$04,$44,$05,$55,$06,$66,$07,$77
	DC.B	$08,$88,$09,$99,$0A,$AA,$0B,$BB
	DC.B	$0C,$CC,$0D,$DD,$0E,$EE,$0F,$FF

_FREECOLORMAP	;A0-*COLORMAP
	MOVE.L	(A2),-(A7)
	MOVE.L	A0,A2
	MOVE.L	cm_ColorTable(A2),A1
	MOVEQ.L	#0,D0
	MOVE.W	cm_Count(A2),D0
	ADD.L	D0,D0
	ADDQ.L	#7,D0
	AND.L	#$FFFFFFF8,D0
	BSR.W	FREEM

	MOVE.L	A2,A1
	MOVEQ.L	#8,D0
	BSR.W	FREEM
	MOVE.L	(A7)+,A2
	RTS

_OPENFONT	
		move.l	a2,-(a7)
;		CMP.W	#8,4(A0)
;		BNE.S	.ERR
		MOVE.L	(A0),A1

		lea	_FONTTABLE(PC),a2
.next		move.l	(a2)+,a0
		move.l	a0,d0
		beq	.ERR
		bsr	_strcmp
		beq	.found
		addq.l	#4,a2
		bra	.next

.found		MOVE.L	(A2),D0
		move.l	(a7)+,a2
		rts

.ERR		pea	_LVOOpenFont
		pea	_gfxname
		bra	_emufail

_SETFONT	MOVE.L	A0,rp_Font(A1)
		CLR.W	rp_AlgoStyle(A1)
		MOVE.W	tf_YSize(A0),rp_TxHeight(A1)
		MOVE.W	tf_XSize(A0),rp_TxWidth(A1)
		MOVE.W	tf_Baseline(A0),rp_TxBaseline(A1)
		MOVE.W	tf_XSize(A0),rp_TxSpacing(A1)
		RTS


_PRINTTEXT	;A0-*STRING, A1-*RASTPORT, D0-CHARCOUNT
		MOVEM.L	D2-D7/A2-A6,-(A7)
		MOVE.L	A0,A2			;keep stringpointer
		MOVE.L	D0,D2
		MOVE.L	rp_Font(A1),A3		;get font
		MOVE.L	tf_CharLoc(A3),A4	;get chardescriptionpointer
.NXPRINT	MOVE.L	D2,-(A7)
		MOVE.L	tf_CharData(A3),A5	;get chardatapointer
		MOVEQ.L	#0,D3
		MOVE.B	(A2)+,D3		;get char
		CMP.B	tf_HiChar(A3),D3
		BHI.S	.SPACEPRINT
		CMP.B	tf_LoChar(A3),D3
		BHS.S	.OKPRINT
.SPACEPRINT	MOVE.B	tf_LoChar(A3),D3
.OKPRINT	SUB.B	tf_LoChar(A3),D3
		LSL.W	#2,D3
		MOVE.W	(A4,D3.W),D4	;get charposition on font - bitoffset
		MOVE.W	2(A4,D3.W),D2		;bitwidth of char
		MOVE.W	D4,D3
		AND.W	#$F,D4			;bitshift
		AND.W	#$FFF0,D3
		LSR.W	#3,D3			;byteoffset of char
		MOVE.W	rp_cp_x(A1),D6		;x-printposition
		MOVE.W	D6,D5
		AND.W	#$F,D6			;x-bitshift
		AND.W	#$FFF0,D5
		LSR.W	#3,D5
		EXT.L	D5
		MOVE.W	rp_cp_y(A1),D7		;y-printposition
		SUB.W	tf_Baseline(A3),D7
		MOVE.L	rp_BitMap(A1),A0
		MULU	(A0),D7		;memoryoffset of the line by * bytesperrow
		ADD.L	D5,D7		;memoffset of printposition w/o shift

		MOVEQ.L	#0,D1			;print char
.NXLINE		MOVE.L	(A5,D3.W),D5		;get charline from charsetdata
		LSL.L	D4,D5
		MOVEQ.L	#-1,D0			;mask rest out
		LSR.L	D2,D0
		NOT.L	D0
		AND.L	D0,D5		;chardata in D5, beginning with bit 31
		LSR.L	D6,D5
		LSR.L	D6,D0		;contain now a 'window' of set bits at printpos
		MOVEM.L	D1/D3/D4/D6,-(A7)
		BTST	#0,rp_AlgoStyle(A1)
		BEQ.S	.NOUNDERLINE
		MOVE.W	tf_YSize(A3),D3
		SUBQ.W	#1,D3
		CMP.W	D3,D1
		BNE.S	.NOUNDERLINE
		MOVE.L	D0,D5
.NOUNDERLINE	MOVE.L	D0,D3
		NOT.L	D3
		MOVEQ.L	#0,D6
.NXPLANE	MOVE.L	D6,D1
		LSL.L	#2,D1
		MOVE.L	bm_Planes(A0,D1.W),A6	;planepointertable in a6
		MOVE.L	(A6,D7.L),D1		;screendata
		BTST	#0,rp_DrawMode(A1)	;test if JAM2
		BNE.S	.JAM2
		OR.L	D5,D1
		BTST	D6,rp_FgPen(A1)
		BNE.S	.MOVETOPLANE
		EOR.L	D5,D1
		BRA.S	.MOVETOPLANE
						;now check colors
.JAM2		BTST	D6,rp_BgPen(A1)
		BNE.S	.BGSET
		AND.L	D3,D1			;clear bits
		BTST	D6,rp_FgPen(A1)
		BEQ.S	.KEEPFG1
		OR.L	D5,D1			;set bits
.KEEPFG1	BRA.S	.MOVETOPLANE

.BGSET		OR.L	D0,D1
		BTST	D6,rp_FgPen(A1)
		BNE.S	.KEEPFG2
		EOR.L	D5,D1
.KEEPFG2
.MOVETOPLANE	MOVE.L	D1,(A6,D7.L)
		ADDQ.L	#1,D6
		CMP.B	bm_Depth(A0),D6		;for each bitplane
		BLO.S	.NXPLANE
		MOVEM.L	(A7)+,D1/D3/D4/D6

		ADD.W	tf_Modulo(A3),A5
		MOVE.L	D7,A6
		ADD.W	bm_BytesPerRow(A0),A6
		MOVE.L	A6,D7
		ADDQ.L	#1,D1
		CMP.W	tf_YSize(A3),D1		;all lines
		BLO.W	.NXLINE
		ADD.W	D2,rp_cp_x(A1)		;rp_position moved
		MOVE.L	(A7)+,D2
		SUBQ.L	#1,D2			;until string is exhausted
		BNE.W	.NXPRINT
		MOVEM.L	(A7)+,D2-D7/A2-A6
		RTS

_InitBitMap	;a0=bm d0=depth d1=width d2=height
		addq.w	#7,d1
		lsr.w	#3,d1
		AND.W	#$FFFE,D1			;LORDS OF WAR
		move.w	d1,(bm_BytesPerRow,a0)
		move.w	d2,(bm_Rows,a0)
		clr.b	(bm_Flags,a0)
		move.b	d0,(bm_Depth,a0)
		clr.w	(bm_Pad,a0)
		move.l	#$bbbbbbbb,d1
;		clr.l	d1
		move.l	d1,(bm_Planes,a0)
		move.l	d1,(bm_Planes+4,a0)
		move.l	d1,(bm_Planes+8,a0)
		move.l	d1,(bm_Planes+12,a0)
		move.l	d1,(bm_Planes+16,a0)
		move.l	d1,(bm_Planes+20,a0)
		move.l	d1,(bm_Planes+24,a0)
		move.l	d1,(bm_Planes+28,a0)
		rts

_MakeVPort	;a0=view a1=viewport
		move.l	a2,-(a7)
		movem.l	a0-a1/a6,-(a7)
		move.l	#200,d0
		move.l	#MEMF_CHIP,d1
		move.l	(4),a6
		jsr	(_LVOAllocMem,a6)
		movem.l	(a7)+,a0-a1/a6
		tst.l	d0
		trapeq
		BEQ.W	.ERR
		move.l	d0,a2				;A2 = coplist
		move.l	a2,(vp_DspIns,a1)
		move.l	(vp_RasInfo,a1),a0
		move.l	(ri_BitMap,a0),a0
		move.w	#diwstrt,(a2)+
		move.w	#$2981,d0
		move.w	d0,(a2)+
		move.w	#diwstop,(a2)+
		move.w	(bm_BytesPerRow,a0),d1
		lsl.w	#3,d1				;bytes -> pixel
		add.b	d1,d0
		move.w	(bm_Rows,a0),d1
		lsl.w	#8,d1
		add.w	d1,d0
		move.w	d0,(a2)+
		move.l	#ddfstrt<<16+$0038,(a2)+
		move.l	#ddfstop<<16+$00d0,(a2)+
		move.l	#bplcon1<<16,(a2)+
		move.l	#bpl1mod<<16,(a2)+
		move.l	#bpl2mod<<16,(a2)+
		move.w	#bplcon0,(a2)+
		moveq	#0,d0
		move.b	(bm_Depth,a0),d0
		ror.w	#4,d0
		or.w	#$200,d0
		move.w	d0,(a2)+
		move.b	(bm_Depth,a0),d0
		lea	(bm_Planes,a0),a0
		move.w	#bplpt,d1
.lp		move.w	d1,(a2)+
		addq.w	#2,d1
		move.w	(a0)+,(a2)+
		move.w	d1,(a2)+
		addq.w	#2,d1
		move.w	(a0)+,(a2)+
		subq.b	#1,d0
		bne	.lp
		move.l	#dmacon<<16+DMAF_SETCLR+DMAF_RASTER,(a2)+
		moveq	#-2,d0
		move.l	d0,(a2)+
		move.l	(a7)+,a2
		rts

.ERR		pea	_LVOMakeVPort
		pea	_gfxname
		bra	_emufail

_CMove:
	move.w	D0,copper_instruction
	move.w	D1,copper_instruction+2
	rts

_CWait:
	move.b	D0,copper_instruction
	move.b	D1,copper_instruction+1
	move.w	#$FFFE,copper_instruction+2
	rts

_CBump:
	move.l	A0,-(A7)
	move.l	copper_pointer,A0
	move.l	copper_instruction(pc),(A0)+
	move.l	A0,copper_pointer
	move.l	#$FFFFFFFE,(A0)
	move.l	(A7)+,A0
	rts

copper_instruction:
	dc.l	0
copper_pointer:
	dc.l	copper_buffer
copper_buffer:
	dc.l	$FFFFFFFE
	blk.l	$1000,0

_MrgCop		;a1=view
		move.l	(v_ViewPort,a1),a0
		cmp.l	#$FFFFFFFE,copper_buffer
		bne	.nouser
		move.l	#copper_buffer,(v_LOFCprList,a1)
		rts

.nouser
		move.l	(vp_DspIns,a0),(v_LOFCprList,a1)
		rts

_MrgCop_old		;a1=view
		move.l	(v_ViewPort,a1),a0
		move.l	(vp_DspIns,a0),(v_LOFCprList,a1)
		rts

_LoadView	;a1=view
		move.l	a1,d0
		beq	.noview
		move.l	(v_LOFCprList,a1),d0
		beq	.fail
		move.l	d0,(gb_LOFlist,a6)
		move.l	d0,(_custom+cop2lc)
		rts

.noview		CLR.L	(gb_ActiView,a6)
		MOVE.L	#STDCOPPER,(gb_LOFlist,a6)
		move.l	(v_SHFCprList,a1),(gb_SHFlist,a6)
		rts
		
.fail		GFXFAIL	_LVOLoadView

_LoadRGB4	;a0=viewport a1=colors d0=count
		bsr	_waitvb
		lea	(_custom+color),a0
.cpy		move.w	(a1)+,(a0)+
		subq.w	#1,d0
		bne	.cpy
		rts

_SetRGB4	;a0=viewport d0=pen d1=red d2=green d3=blue
	;	bsr	_waitvb
		lea	(_custom+color),a0
		ext.w	d0
		add.w	d0,a0
		add.w	d0,a0
		lsl.w	#4,d1
		or.w	d2,d1
		lsl.w	#4,d1
		or.w	d3,d1
		move.w	d1,(a0)
		rts

_VBeamPos	move.l	(_custom+vposr),d0
		lsr.l	#8,d0
		and.l	#$1ff,d0
		rts

_WaitTOF	BSR.w	_waitvb
		rts

_WaitBOVP:
		bsr.w	_waitvb		; -- added by JOTD
		rts			; -- I know this is not the accurate function

_ReadPixel	;d0=x d1=y a1=rastport
		move.l	(rp_BitMap,a1),a0
		ext.l	d0
		ror.l	#3,d0
		cmp.w	(bm_BytesPerRow,a0),d0
		bhs	.bad
		cmp.w	(bm_Rows,a0),d1
		bhs	.bad
		mulu	(bm_BytesPerRow,a0),d1
		add.w	d0,d1			;byte offset
		rol.l	#3,d0			;bit offset
		
		movem.l	d2-d4,-(a7)
		moveq	#0,d2
		moveq	#0,d3
		move.b	(bm_Depth,a0),d4
		lea	(bm_Planes,a0),a0
		
.next		move.l	(a0)+,a1
		btst	d0,(a1,d1.l)
		beq	.1
		bset	d2,d3
.1		addq.l	#1,d2
		cmp.b	d2,d4
		bhi	.next
		
		move.l	d3,d0
		movem.l	(a7)+,d2-d4
		rts

.bad		moveq	#-1,d0
		rts

_WritePixel	;d0=x d1=y a1=rastport
		move.l	(rp_BitMap,a1),a0
		ext.l	d0
		ror.l	#3,d0
		cmp.w	(bm_BytesPerRow,a0),d0
		bhs	.bad
		cmp.w	(bm_Rows,a0),d1
		bhs	.bad
		mulu	(bm_BytesPerRow,a0),d1
		add.w	d0,d1			;byte offset
		rol.l	#3,d0			;bit offset
		
		movem.l	d2-d4,-(a7)
		moveq	#0,d2
		move.b	(rp_FgPen,a1),d3
		move.b	(bm_Depth,a0),d4
		lea	(bm_Planes,a0),a0
		
.next		move.l	(a0)+,a1
		btst	d2,d3
		beq	.clear
.set		bset	d0,(a1,d1.w)
		bra	.1
.clear		bclr	d0,(a1,d1.w)
.1		addq.l	#1,d2
		cmp.b	d2,d4
		bhi	.next
		
		move.l	d3,d0
		movem.l	(a7)+,d2-d4
		rts

.bad		moveq	#-1,d0
		rts

; added by JOTD. Untested

_SetRast:
	movem.l	D2-D7/A2-A6,-(A7)
;;	move.l	rp_BitMap(A1),A0	; pointer on bitmap
;;	move.w	(bm_BytesPerRow)
	bsr	_SETAPEN
	moveq.l	#0,D0	; xmin
	moveq.l	#0,D1	; ymin
	move.l	#320,D2	; xmax
	move.l	#200,D3 ; ymax
	bsr	_RectFill
	movem.l	(A7)+,D2-D7/A2-A6
	rts

; added by JOTD. Not optimized and not tested AT ALL

	;d0=xmin d1=ymin d2=xmax d3=ymax a1=rastport
_RectFill:
	movem.l	a2/d2-d7,-(A7)

	move.l	d0,d7
.loopx
.loopy
	move.l	d0,d5
	move.l	d1,d6
	move.l	a1,a2
	bsr	_WritePixel
	move.l	a2,a1
	move.l	d5,d0
	move.l	d6,d1
	addq.l	#1,d0
	cmp.l	d0,d2
	bcc.b	.loopx	
	move.l	d7,d0
	addq.l	#1,d1
	cmp.l	d1,d3
	bcc.b	.loopy

	movem.l	(A7)+,a2/d2-d7
	rts


**************************************************************************
*	SPRITES
**************************************************************************

_FreeSprite	;d0=pick
		bclr	d0,(gb_SpriteReserved,a6)
		rts

_GetSprite	;a0=sprite d0=pick
		tst.w	d0
		bmi	.any
		bset	d0,(gb_SpriteReserved,a6)
		bne	.error
.end		move.b	d0,(ss_num,a0)
		ext.l	d0
		rts

.error		moveq	#-1,d0
		rts

.any		cmp.b	(gb_SpriteReserved,a6),d0
		beq	.error
.next		addq.w	#1,d0
		bset	d0,(gb_SpriteReserved,a6)
		bne	.next
		bra	.end

_ChangeSprite	;a0=viewport a1=simplesprite a2=data
		moveq	#0,d0
		move.b	(ss_num,a1),d0
		lsl.w	#2,d0
		lea	(_sprites),a0
		move.l	a2,(a0,d0.w)
		move.w	#DMAF_SETCLR!DMAF_SPRITE,(_custom+dmacon)
		rts

_MoveSprite	;a0=viewport a1=simplesprite d0=x d1=y
		;129,41 top,left
		move.l	d2,-(a7)
		moveq	#0,d2
		move.b	(ss_num,a1),d2
		lsl.w	#2,d2
		lea	(_sprites),a0
		move.l	(a0,d2.w),a0
		add.w	#129,d0			;d0 hor
		add.w	#41,d1			;d1 top
		move.w	d1,d2
		add.w	(ss_height,a1),d2	;d2 bottom
		move.b	d1,(a0)+		;top7..top0
		ror.w	#1,d0
		move.b	d0,(a0)+		;hor8..hor1
		move.b	d2,(a0)+		;bot7..bot0
		lsr.w	#8,d1
		lsl.w	#7,d2
		addx.w	d2,d2
		addx.w	d1,d1
		addx.w	d0,d0
		addx.w	d1,d1
		move.b	d1,(a0)+
		move.l	(a7)+,d2
		rts

**************************************************************************
*	BLITTER
**************************************************************************

_WaitBlit
.wait		tst.b	(_ciaa)
		tst.b	(_ciaa)
		btst	#DMAB_BLTDONE-8,(_custom+dmaconr)
		bne.b	.wait
		tst.b	(_ciaa)
		rts

_BltBitMap	;a0=sbitmap d0=sx d1=sy
		;a1=dbitmap d2=dx d3=dy
		;d4=width d5=height d6=minterm d7=mask a2=buffer

		movem.l	d2-d7/a2-a3,-(a7)
		lea	(_custom),a3

		mulu	(bm_BytesPerRow,a0),d1
		ext.l	d0
		ror.l	#4,d0
		add.w	d0,d1
		add.w	d0,d1			;d1 = byte offset src

		mulu	(bm_BytesPerRow,a1),d3
		ext.l	d2
		ror.l	#4,d2
		add.w	d2,d3
		add.w	d2,d3			;d3 = byte offset dest

		lsl.w	#6,d5			;height
		
		and.w	#$00f0,d6
		or.w	#$070a,d6
		bsr	_WaitBlit
		move.w	d6,(bltcon0,a3)
		
		moveq	#-1,d6
		move.w	d6,(bltadat,a3)
		clr.w	d2
		rol.l	#4,d2			;d2 = amount of pixels to skip in the first word in dest
		lsr.w	d2,d6			;d6.w = afwm
		swap	d6
		addq.w	#1,d5			;d5 = width++ (the first word)
		sub.w	#16,d4
		add.w	d2,d4			;d4 = pixels left to copy
		ext.l	d4
		ror.l	#4,d4
		add.w	d4,d5			;d5.w = size
		clr.w	d4
		rol.l	#4,d4			;d4 = pixels left to copy (0..15)
		beq	.1
		addq.w	#1,d5			;d5 = width++ (the last word)
		lsr.w	d4,d6			;d6.w = ~(alwm)
		not.w	d6
.1		move.l	d6,(bltafwm,a3)
		
		clr.w	d0
		rol.l	#4,d0			;pixel offset src
		sub.w	d0,d2
	;	spl	d4			;d4 = 0 if first src word must be preloaded (dma-b)
		bpl	.2
	;this works only if the destination is word aligned !!!!!!
	;(in deuteros it is...) normally a second blit is neccessary in this case
		addq.w	#1,d5			;bltsize++
		subq.w	#2,d3			;dst-2
		move.w	#0,(bltafwm,a3)
		add.w	#16,d2
.2		ror.w	#4,d2
		move.w	d2,(bltcon1,a3)
		
		move.w	d5,d0
		and.w	#$003f,d0
		add.w	d0,d0
		move.w	(bm_BytesPerRow,a0),d2
		sub.w	d0,d2
		move.w	d2,(bltbmod,a3)
		move.w	(bm_BytesPerRow,a1),d2
		sub.w	d0,d2
		move.w	d2,(bltcmod,a3)
		move.w	d2,(bltdmod,a3)

		moveq	#0,d6
.do		btst	d6,d7			;mask ?
		beq	.next

		lsl.w	#2,d6
		move.l	(bm_Planes,a0,d6.w),a2
		add.l	d1,a2
		move.l	(bm_Planes,a1,d6.w),d0
		add.l	d3,d0
		bsr	_WaitBlit
		movem.l	d0/a2,(bltcpt,a3)
		move.l	d0,(bltdpt,a3)
		move.w	d5,(bltsize,a3)
		lsr.w	#2,d6

.next		addq.w	#1,d6
		cmp.b	(bm_Depth,a0),d6
		beq	.end
		cmp.b	(bm_Depth,a1),d6
		bne	.do
.end
		movem.l	(a7)+,d2-d7/a2-a3
		rts

_BltTemplate	;a0=src d0=bitoffset d1=modulo
		;a1=rp d2=x d3=y d4=width d5=height

		movem.l	d2-d7/a2-a3,-(a7)
		lea	(_custom),a3

		ext.l	d0
		ror.l	#4,d0
		add.w	d0,a0
		add.w	d0,a0			;a0 = src ptr

		move.l	(rp_BitMap,a1),a2
		mulu	(bm_BytesPerRow,a2),d3
		ext.l	d2
		ror.l	#4,d2
		add.w	d2,d3
		add.w	d2,d3			;d3 = byte offset dest

		lsl.w	#6,d5			;height
		
		bsr	_WaitBlit
		move.w	#$07aa,(bltcon0,a3)
		
		moveq	#-1,d6
		move.w	d6,(bltadat,a3)
		clr.w	d2
		rol.l	#4,d2			;d2 = amount of pixels to skip in the first word in dest
		lsr.w	d2,d6			;d6.w = afwm
		swap	d6
		addq.w	#1,d5			;d5 = width++ (the first word)
		sub.w	#16,d4
		add.w	d2,d4			;d4 = pixels left to copy
		ext.l	d4
		ror.l	#4,d4
		add.w	d4,d5			;d5.w = size
		clr.w	d4
		rol.l	#4,d4			;d4 = pixels left to copy (0..15)
		beq	.1
		addq.w	#1,d5			;d5 = width++ (the last word)
		lsr.w	d4,d6			;d6.w = ~(alwm)
		not.w	d6
.1		move.l	d6,(bltafwm,a3)
		
		clr.w	d0
		rol.l	#4,d0			;pixel offset src
		sub.w	d0,d2
	;	spl	d4			;d4 = 0 if first src word must be preloaded (dma-b)
		bpl	.2
	;this works only if the destination is word aligned !!!!!!
	;(in deuteros it is...) normally a second blit is neccessary in this case
		addq.w	#1,d5			;bltsize++
		subq.w	#2,d3			;dst-2
		move.w	#0,(bltafwm,a3)
		add.w	#16,d2
.2		ror.w	#4,d2
		move.w	d2,(bltcon1,a3)
		
		move.w	d5,d0
		and.w	#$003f,d0
		add.w	d0,d0
		move.w	d1,d2
		sub.w	d0,d2
		move.w	d2,(bltbmod,a3)
		move.w	(bm_BytesPerRow,a2),d2
		sub.w	d0,d2
		move.w	d2,(bltcmod,a3)
		move.w	d2,(bltdmod,a3)

		moveq	#0,d6
.do		lsl.w	#2,d6
		move.l	(bm_Planes,a2,d6.w),d0
		add.l	d3,d0
		bsr	_WaitBlit
		movem.l	d0/a0,(bltcpt,a3)
		move.l	d0,(bltdpt,a3)
		move.w	d5,(bltsize,a3)
		lsr.w	#2,d6

.next		addq.w	#1,d6
		cmp.b	(bm_Depth,a2),d6
		bne	.do

		movem.l	(a7)+,d2-d7/a2-a3
		rts

