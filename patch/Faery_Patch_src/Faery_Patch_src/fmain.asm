;
; This file is part of Faery Tale Adventure Patch.
; Copyright (C) 1997 Peter McGavin
;
; Faery Tale Adventure Patch is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; Faery Tale Adventure Patch is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with Faery Tale Adventure Patch.  If not, see <http://www.gnu.org/licenses/>.
;
	debug	on,lattice4,code,data
	multipass
	mc68000

	xdef	_PROGSTART
	xref	_trackdisk_read
	xref	_wbmessage
	xref	_save_map
	xref	_topaz8font

;AFLINE	macro
;	dc.w	\1
;	endm
def	macro
	ifd	\1
	ifne	(\1-\2)
	fail	"\1 \2"
	endc
	else
\1	equ	\2
	endc
	endm

	def	strncpy_maxlength,$C
	def	AbsExecBase,$4
	def	_LVOLoadRGB4,-$C0
	def	IO_DATA,$28
	def	IS_DATA,$E
	def	_LVOCreateUpfrontLayer,-$24
	def	LN_NAME,$A
	def	_LVOSendIO,-$1CE
	def	ie_Code,$6
	def	ac_vol,$8
	def	_LVOOpenDevice,-$1BC
	def	_LVOSetFont,-$42
	def	pr_Task,$0
	def	LN_TYPE,$8
	def	IECLASS_NULL,$0
	def	_LVOInitBitMap,-$186
	def	pr_CLI,$AC
	def	strncat_source,$8
	def	MEMF_CLEAR,$10000
	def	DMAF_MASTER,$200
	def	IECLASS_DISKINSERTED,$10
	def	_LVOMakeVPort,-$D8
	def	AG_OpenLib,$30000
	def	pr_COS,$A0
	def	strncpy_dest,$4
	def	_LVOSetRGB4,-$120
	def	_LVOLoadView,-$DE
	def	_LVOInitArea,-$11A
	def	_custom,$DFF000
	def	IO_OFFSET,$2C
	def	LH_TAIL,$4
	def	pr_WindowPtr,$B8
	def	DeleteStdIO_iop,$8
	def	BC0F_DEST,$100
	def	_LVODisownBlitter,-$1CE
	def	bltcon0,$40
	def	_LVOForbid,-$84
	def	_LVOUnLoadSeg,-$9C
	def	sm_ArgList,$24
	def	bltcon1,$42
	def	ac_per,$6
	def	intreq,$9C
	def	_LVOFreeRaster,-$1F2
	def	_LVOMrgCop,-$D2
	def	_LVOScrollRaster,-$18C
	def	_LVOOpen,-$1E
	def	_LVOWaitPort,-$180
	def	pr_CIS,$9C
	def	_LVOInitRastPort,-$C6
	def	INTB_AUD1,$8
	def	INTF_AUD1,$100
	def	_LVOAddPort,-$162
	def	MN_SIZE,$14
	def	TC_SPLOWER,$3A
	def	_LVORead,-$2A
	def	_LVOGetMsg,-$174
	def	AT_Recovery,$0
	def	_LVOFreeMem,-$D2
	def	aud2,$C0
	def	aud3,$D0
	def	LN_SUCC,$0
	def	_LVOCloseLibrary,-$19E
	def	aud0,$A0
	def	aud1,$B0
	def	IS_CODE,$12
	def	IO_COMMAND,$1C
	def	_LVOChangeSprite,-$1A4
	def	LN_PRED,$4
	def	dmaconr,$2
	def	MEMF_PUBLIC,$1
	def	_LVOSeek,-$42
	def	bltdpt,$54
;;;;	def	SYSBASESIZE,$278
;;;;	def	gb_SIZE,$1F1
	def	_LVOSetRast,-$EA
	def	_LVOCurrentDir,-$7E
	def	_LVOInitVPort,-$CC
	def	bltcpt,$48
	def	_LVOText,-$3C
	def	_LVOAllocRaster,-$1EC
	def	_LVOWaitIO,-$1DA
	def	MODE_NEWFILE,$3EE
	def	_LVOUnLock,-$5A
	def	bltbpt,$4C
	def	_LVOWaitBlit,-$E4
	def	v_ViewPort,$0
	def	bltapt,$50
	def	strncat_maxlength,$C
	def	_LVODisposeLayerInfo,-$96
	def	_LVOexecPrivate3,-$30
	def	_LVOFreeVPortCopLists,-$21C
	def	_LVOInput,-$36
	def	_LVOSetDrMd,-$162
	def	_LVOOwnBlitter,-$1C8
	def	_LVOLoadSeg,-$96
	def	intena,$9A
	def	_LVODoIO,-$1C8
	def	ie_Class,$4
	def	INTF_SETCLR,$8000
	def	bltafwm,$44
	def	_LVOFreeColorMap,-$240
	def	_LVOBltBitMap,-$1E
	def	_LVOSetAPen,-$156
	def	bm_Planes,$8
	def	BC0F_SRCB,$400
	def	SIH_QUEUES,$5
	def	bltcmod,$60
	def	_LVOFreeCprList,-$234
	def	_LVOOutput,-$3C
	def	ETask_SIZEOF,$56
	def	_LVOWrite,-$30
	def	gb_ActiView,$22
	def	bltbmod,$62
	def	joy1dat,$C
	def	CMD_READ,$2
	def	_LVOAllocSignal,-$14A
	def	_LVORectFill,-$132
	def	IOSTD_SIZE,$30
	def	_LVOInitTmpRas,-$1D4
	def	MN,$0
	def	_LVORemPort,-$168
	def	AO_DOSLib,$8007
	def	bltamod,$64
	def	_LVOSumLibrary,-$1AA
	def	BIDTAG_GreenBits,$8000000D
	def	ie_NextEvent,$0
	def	_LVOInitView,-$168
	def	pr_MsgPort,$5C
	def	_LVOMove,-$F0
	def	_LVOSetBPen,-$15C
	def	_LVODraw,-$F6
	def	_LVOOpenLibrary,-$228
	def	_LVOAvailMem,-$D8
	def	DMAB_BLITTER,$6
	def	_LVODelay,-$C6
	def	_LVOAllocMem,-$C6
	def	INTB_VERTB,$5
	def	MODE_OLDFILE,$3ED
	def	_LVOWaitBOVP,-$192
	def	_LVOFreeSprite,-$19E
	def	IND_ADDHANDLER,$9
	def	IECLASS_RAWKEY,$1
	def	TD_MOTOR,$9
	def	_LVOFreeSignal,-$150
	def	DMAF_SETCLR,$8000
	def	ie_Qualifier,$8
	def	_LVODeleteLayer,-$5A
	def	DMAF_AUD0,$1
	def	_ciaa,$BFE001
	def	_LVOIoErr,-$84
	def	DMAF_AUD1,$2
	def	DMAF_AUD2,$4
	def	DMAF_AUD3,$8
	def	bltalwm,$46
	def	IO_LENGTH,$24
	def	ri_BitMap,$4
	def	LH_TAILPRED,$8
	def	_LVOClose,-$24
	def	dmacon,$96
	def	IECLASS_RAWMOUSE,$2
	def	vp_RasInfo,$24
	def	CreateStdIO_mp,$8
	def	DMAF_AUDIO,$F
	def	_LVOGetSprite,-$198
	def	_LVOReplyMsg,-$17A
	def	_LVOExit,-$90
	def	_LVOFindTask,-$126
	def	_LVOCloseDevice,-$1C2
	def	_LVOAreaMove,-$FC
	def	_LVOAreaDraw,-$102
	def	_LVOLock,-$54
	def	TC_TRAPCODE,$32
	def	wa_SIZEOF,$8
	def	_LVONewLayerInfo,-$90
	def	_LVORemIntServer,-$AE
	def	exit_code,$8
	def	sm_SIZEOF,$28
	def	_LVOCheckIO,-$1D4
	def	ac_len,$4
	def	strncat_dest,$4
	def	_LVOAlert,-$6C
	def	_LVOGetColorMap,-$23A
	def	MEMF_CHIP,$2
	def	_LVOAreaEnd,-$108
	def	_LVOAddIntServer,-$A8
	def	_LVOSetIntVector,-$A2
	def	sm_ToolWindow,$20
	def	pr_ConsoleTask,$A4
	def	dskdatr,$8
	def	bltsize,$58
	def	LH_HEAD,$0
	def	bltdmod,$66
	def	pr_SIZEOF,$E4
****************************************************************************
;	exeobj
;	errfile	'ram:assem.output'
;	objfile	'fmain'
;_[]
	SECTION	fmainrs000000,CODE,CHIP
;;;;	SECTION	fmainrs000000,CODE
ProgStart
_PROGSTART	JMP	(ProgramStart).L

Dirk.MSG	db	'Dirk',0
Mace.MSG	db	'Mace',0
Sword.MSG	db	'Sword',0
Bow.MSG	db	'Bow',0
MagicWand.MSG	db	'Magic Wand',0
GoldenLasso.MSG	db	'Golden Lasso',0
SeaShell.MSG	db	'Sea Shell',0
SunStone.MSG	db	'Sun Stone',0
Arrows.MSG	db	'Arrows',0
BlueStone.MSG	db	'Blue Stone',0
GreenJewel.MSG	db	'Green Jewel',0
GlassVial.MSG	db	'Glass Vial',0
CrystalOrb.MSG	db	'Crystal Orb',0
BirdTotem.MSG	db	'Bird Totem',0
GoldRing.MSG	db	'Gold Ring',0
JadeSkull.MSG	db	'Jade Skull',0
GoldKey.MSG	db	'Gold Key',0
GreenKey.MSG	db	'Green Key',0
BlueKey.MSG	db	'Blue Key',0
RedKey.MSG	db	'Red Key',0
GreyKey.MSG	db	'Grey Key',0
WhiteKey.MSG	db	'White Key',0
Talisman.MSG	db	'Talisman',0
Rose.MSG	db	'Rose',0
Fruit.MSG	db	'Fruit',0
GoldStatue.MSG	db	'Gold Statue',0
Book.MSG	db	'Book',0
Herb.MSG	db	'Herb',0
Writ.MSG	db	'Writ',0
Bone.MSG	db	'Bone',0
Shard.MSG	db	'Shard',0
GoldPieces.MSG	db	'2 Gold Pieces',0
GoldPieces.MSG0	db	'5 Gold Pieces',0
GoldPieces.MSG1	db	'10 Gold Pieces',0
GoldPieces.MSG2	db	'100 Gold Pieces',0
quiverofarrow.MSG	db	'quiver of arrows',0
Julian.MSG	db	'Julian',0
Phillip.MSG	db	'Phillip',0
Kevin.MSG	db	'Kevin',0,0

open_everything	LINK.W	A5,#-4
	MOVE.L	D4,-(SP)
	CLR.W	(some_more_flags-DT,A4)
	CLR.L	-(SP)
	PEA	(GraphicsName,PC)
	JSR	(_OpenLibrary-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(_GfxBase-DT,A4)
	BNE.B	lbC000192
	MOVEQ	#2,D0
return_now	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

lbC000192	CLR.L	-(SP)
	PEA	(layerslibrary.MSG,PC)
	JSR	(_OpenLibrary-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(LayersBase-DT,A4)
	BNE.B	lbC0001A8
	MOVEQ	#2,D0
	BRA.B	return_now

lbC0001A8	BSET	#1,(some_flags-DT,A4)
	MOVEA.L	(_GfxBase-DT,A4),A0
	MOVE.L	(gb_ActiView,A0),(actiview-DT,A4)
	JSR	(_NewLayerInfo-DT,A4)
	MOVE.L	D0,(layerinfo-DT,A4)

	PEA	(rp1-DT,A4)
	JSR	(_InitRastPort-DT,A4)
	ADDQ.W	#4,SP

	move.l	(_topaz8font),-(sp)
	pea	(rp1-DT,A4)
	jsr	(_SetFont-DT,a4)
	addq.w	#8,sp

	PEA	(active_rp-DT,A4)
	JSR	(_InitRastPort-DT,A4)
	ADDQ.W	#4,SP

	move.l	(_topaz8font),-(sp)
	pea	(active_rp-DT,A4)
	jsr	(_SetFont-DT,a4)
	addq.w	#8,sp

	PEA	(rp640x57x4-DT,A4)
	JSR	(_InitRastPort-DT,A4)
	ADDQ.W	#4,SP

	move.l	(_topaz8font),-(sp)
	pea	(rp640x57x4-DT,A4)
	jsr	(_SetFont-DT,a4)
	addq.w	#8,sp

	LEA	(active_rp-DT,A4),A0
	MOVE.L	A0,(active_rp_ptr-DT,A4)
	MOVEA.L	(actiview-DT,A4),A0
	MOVEA.L	(v_ViewPort,A0),A1
	MOVEA.L	(vp_RasInfo,A1),A6
	MOVE.L	(ri_BitMap,A6),(active_bitmap_ptr-DT,A4)
	MOVE.L	(active_bitmap_ptr-DT,A4),(active_rp_bitmap_ptr-DT,A4)
	CLR.L	-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetBPen-DT,A4)	;!******************
	ADDQ.W	#8,SP
	PEA	(1).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetDrMd-DT,A4)	;!*****************
	ADDQ.W	#8,SP
	CLR.L	-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetRast-DT,A4)	;!****************
	ADDQ.W	#8,SP
	PEA	((MEMF_CHIP|MEMF_CLEAR)).L
	PEA	(200).W
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(bitmap_array_ptr-DT,A4)
	BNE.B	lbC00023E
	MOVEQ	#1,D0
	bra	return_now

lbC00023E	BSET	#0,(some_flags-DT,A4)
;	CLR.L	-(SP)
;	CLR.L	-(SP)
;	JSR	(_CreateMsgPort-DT,A4)
;	ADDQ.W	#8,SP
;	MOVE.L	D0,(trackdisk_mp-DT,A4)
;	BNE.B	lbC00025A
;	MOVEQ	#$1E,D0
;	bra	return_now

lbC00025A	BSET	#3,(some_more_flags-DT,A4)
;	PEA	(56).W
;	MOVE.L	(trackdisk_mp-DT,A4),-(SP)
;	JSR	(_CreateStdIO2-DT,A4)
;	ADDQ.W	#8,SP
;	MOVE.L	D0,(trackdisk_io-DT,A4)
;	BNE.B	lbC00027A
;	MOVEQ	#$1F,D0
;	bra	return_now

lbC00027A	BSET	#4,(some_more_flags-DT,A4)
;	CLR.L	-(SP)
;	MOVE.L	(trackdisk_io-DT,A4),-(SP)
;	CLR.L	-(SP)
;	PEA	(TrackdiskName,PC)
;	JSR	(_OpenDevice-DT,A4)
;	LEA	($10,SP),SP
;	TST.L	D0
;	BEQ.B	lbC00029E
;	MOVEQ	#$20,D0
;	bra	return_now

lbC00029E	BSET	#5,(some_more_flags-DT,A4)
;	MOVEQ	#0,D4
;; allocate trackdisk_io_array loop
;lbC0002A6	MOVEQ	#$38,D1
;	MOVE.L	D4,D0
;	JSR	(__mulu-DT,A4)
;	MOVEA.L	D0,A0
;	LEA	(trackdisk_io_array-DT,A4),A1
;	ADDA.L	A1,A0
;	MOVEA.L	(trackdisk_io-DT,A4),A6
;	MOVEQ	#13,D2
;lbC0002BC	MOVE.L	(A6)+,(A0)+
;	DBRA	D2,lbC0002BC
;	ADDQ.L	#1,D4
;	CMP.L	#9,D4
;	BLT.B	lbC0002A6
;; end allocate trackdisk_io_array loop
	PEA	(FONTSAmber9.MSG,PC)
	JSR	(_LoadSeg-DT,A4)	;!***************
	ADDQ.W	#4,SP
	MOVE.L	D0,(fontseg_bptr-DT,A4)
	BNE.B	lbC0002E2
	MOVEQ	#15,D0
	bra	return_now

lbC0002E2	MOVE.L	(fontseg_bptr-DT,A4),D0
	ASL.L	#2,D0
	ADDQ.L	#8,D0
	MOVE.L	D0,(fontseg_ptr-DT,A4)
	BSET	#1,(some_more_flags-DT,A4)
	MOVE.L	(lbL011F02-DT,A4),(lbL011A4C-DT,A4)
	MOVE.L	(fontseg_ptr-DT,A4),D0
	ADD.L	#$36,D0
	MOVE.L	D0,(font_ptr-DT,A4)
	MOVE.W	#320,(lbW01210E-DT,A4)
	MOVE.W	#320,(lbW01210C-DT,A4)
	MOVE.L	(_GfxBase-DT,A4),(_GfxBase2-DT,A4)
	CLR.L	(lbL01211A-DT,A4)
	JSR	(install_input_handler,PC)
	TST.L	D0
	BNE.B	lbC00032C
	MOVEQ	#4,D0
	bra	return_now

lbC00032C	CLR.L	-(SP)
	JSR	(_FindTask-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	D0,(my_task-DT,A4)
	MOVEA.L	(my_task-DT,A4),A0
	MOVE.L	#$FFFFFFFF,(pr_WindowPtr,A0)	;!**************
	LEA	(_my_trap_code-DT,A4),A0
	MOVEA.L	(my_task-DT,A4),A1
;;;;	MOVE.L	A0,(pr_Task+TC_TRAPCODE,A1)	;!***************
	BSET	#2,(some_flags-DT,A4)
;;;;	CLR.L	-(SP)
;;;;	JSR	(_FreeSprite-DT,A4)	;!**************
;;;;	ADDQ.W	#4,SP
;;;;	CLR.L	-(SP)
	pea	(1).w
	PEA	(simplesprite-DT,A4)
	JSR	(_GetSprite-DT,A4)	;!**************
	ADDQ.W	#8,SP
	PEA	(view-DT,A4)
	JSR	(_InitView-DT,A4)
	ADDQ.W	#4,SP
	PEA	(viewport1-DT,A4)
	JSR	(_InitVPort-DT,A4)
	ADDQ.W	#4,SP
	PEA	(viewport2-DT,A4)
	JSR	(_InitVPort-DT,A4)
	ADDQ.W	#4,SP
	LEA	(viewport2-DT,A4),A0
	MOVE.L	A0,(view-DT,A4)
	LEA	(viewport1-DT,A4),A0
	MOVE.L	A0,(viewport2-DT,A4)
	CLR.L	(viewport1-DT,A4)
	MOVE.W	#288,(viewport1_dwidth-DT,A4)
	MOVE.W	#640,(viewport2_dwidth-DT,A4)
	MOVE.W	#16,(viewport1_dxoffset-DT,A4)
	CLR.W	(viewport2_dxoffset-DT,A4)
	CLR.W	(viewport1_dyoffset-DT,A4)
	MOVE.W	#140,(viewport1_dheight-DT,A4)
	MOVE.W	#143,(viewport2_dyoffset-DT,A4)
	MOVE.W	#57,(viewport2_dheight-DT,A4)
; HiRes is $8000
	MOVE.W	#$E000,(viewport2_modes-DT,A4)	;!*****************
	MOVE.L	(bitmap_array_ptr-DT,A4),D0
	ADD.L	#40,D0
	MOVE.L	D0,(bitmap320x200x5_ptr-DT,A4)
	MOVE.L	(bitmap_array_ptr-DT,A4),D0
	ADD.L	#80,D0
	MOVE.L	D0,(bitmap640x57x4_ptr-DT,A4)
	MOVE.L	(bitmap_array_ptr-DT,A4),D0
	ADD.L	#120,D0
	MOVE.L	D0,(bitmap64x24x3_ptr-DT,A4)
	MOVE.L	(bitmap_array_ptr-DT,A4),D0
	ADD.L	#$A0,D0
	MOVE.L	D0,(bitmap320x200x1_ptr-DT,A4)
	PEA	(200).W
	PEA	(320).W
	PEA	(5).W
	MOVE.L	(bitmap_array_ptr-DT,A4),-(SP)
	JSR	(_InitBitMap-DT,A4)
	LEA	(16,SP),SP
	PEA	(200).W
	PEA	(320).W
	PEA	(5).W
	MOVE.L	(bitmap320x200x5_ptr-DT,A4),-(SP)
	JSR	(_InitBitMap-DT,A4)
	LEA	(16,SP),SP
	PEA	(57).W
	PEA	(640).W
	PEA	(4).W
	MOVE.L	(bitmap640x57x4_ptr-DT,A4),-(SP)
	JSR	(_InitBitMap-DT,A4)
	LEA	(16,SP),SP
	PEA	(200).W
	PEA	(320).W
	PEA	(1).W
	MOVE.L	(bitmap320x200x1_ptr-DT,A4),-(SP)
	JSR	(_InitBitMap-DT,A4)
	LEA	($10,SP),SP
	PEA	(200).W
	PEA	(320).W
	PEA	(5).W
	PEA	(bitmap320x200x5-DT,A4)
	JSR	(_InitBitMap-DT,A4)
	LEA	($10,SP),SP
	PEA	(200).W
	PEA	(320).W
	PEA	(5).W
	PEA	(bitmap320x200x5_2-DT,A4)
	JSR	(_InitBitMap-DT,A4)
	LEA	($10,SP),SP
	PEA	(57).W
	PEA	(640).W
	PEA	(1).W
	PEA	(bitmap640x57x1-DT,A4)
	JSR	(_InitBitMap-DT,A4)
	LEA	($10,SP),SP
	PEA	(24).W
	PEA	(64).W
	PEA	(3).W
	MOVE.L	(bitmap64x24x3_ptr-DT,A4),-(SP)
	JSR	(_InitBitMap-DT,A4)
	LEA	($10,SP),SP
	MOVE.L	(bitmap640x57x4_ptr-DT,A4),(rp640x57x4_bitmap_ptr-DT,A4)
	MOVE.L	(bitmap_array_ptr-DT,A4),(rasinfo1_bitmap_ptr-DT,A4)
	MOVE.L	(bitmap320x200x5_ptr-DT,A4),(rasinfo3_bitmap_ptr-DT,A4)
	CLR.W	(rasinfo3_ryoffset-DT,A4)
	CLR.W	(rasinfo1_ryoffset-DT,A4)
	CLR.W	(rasinfo3_rxoffset-DT,A4)
	CLR.W	(rasinfo1_rxoffset-DT,A4)
	CLR.L	(rasinfo3-DT,A4)
	CLR.L	(viewport1_rasinfo-DT,A4)
	MOVE.L	(bitmap640x57x4_ptr-DT,A4),(rasinfo2_bitmap_ptr-DT,A4)
	CLR.W	(rasinfo2_ryoffset-DT,A4)
	CLR.W	(rasinfo2_rxoffset-DT,A4)
	CLR.L	(viewport2_rasinfo-DT,A4)	;ptr to next rasinfo
	CLR.L	(lbL011CB4-DT,A4)
	CLR.L	(lbL011C8E-DT,A4)
	LEA	(viewport1_rasinfo-DT,A4),A0
	MOVE.L	A0,(lbL011C8A-DT,A4)
	LEA	(viewport1_rasinfo-DT,A4),A0
	MOVE.L	A0,(rasinfo3_ptr-DT,A4)
	LEA	(lbL011C8A-DT,A4),A0
	MOVE.L	A0,(lbL011A04-DT,A4)
	LEA	(rasinfo3_ptr-DT,A4),A0
	MOVE.L	A0,(lbL011A08-DT,A4)
	PEA	(32).W
	JSR	(_GetColorMap-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	D0,(viewport1_colormap-DT,A4)
	PEA	(20).W
	JSR	(_GetColorMap-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	D0,(viewport2_colormap-DT,A4)
	MOVEQ	#0,D4
lbC000548	MOVE.L	D4,D0
	ASL.L	#2,D0
	MOVEA.L	D0,A0
	ADDA.L	(bitmap320x200x5_ptr-DT,A4),A0
	CLR.L	(8,A0)
	MOVE.L	D4,D0
	ASL.L	#2,D0
	MOVEA.L	D0,A1
	ADDA.L	(bitmap_array_ptr-DT,A4),A1
	CLR.L	(8,A1)
	ADDQ.L	#1,D4
	CMP.L	#5,D4
	BLT.B	lbC000548
	MOVEQ	#0,D4
; -----------------------------------------------------------------------
lbC000570	PEA	(200).W
	PEA	(320).W
	JSR	(_AllocRaster-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D4,D1
	ASL.L	#2,D1
	MOVEA.L	D1,A0
	ADDA.L	(bitmap_array_ptr-DT,A4),A0
	MOVE.L	D0,(bm_Planes,A0)
	MOVE.L	D4,D0
	ASL.L	#2,D0
	MOVEA.L	D0,A0
	ADDA.L	(bitmap_array_ptr-DT,A4),A0
	TST.L	(bm_Planes,A0)
	BNE.B	lbC0005A2
	MOVEQ	#4,D0
	bra	return_now

lbC0005A2	PEA	(200).W
	PEA	(320).W
	JSR	(_AllocRaster-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D4,D1
	ASL.L	#2,D1
	MOVEA.L	D1,A0
	ADDA.L	(bitmap320x200x5_ptr-DT,A4),A0
	MOVE.L	D0,(bm_Planes,A0)
	MOVE.L	D4,D0
	ASL.L	#2,D0
	MOVEA.L	D0,A0
	ADDA.L	(bitmap320x200x5_ptr-DT,A4),A0
	TST.L	(bm_Planes,A0)
	BNE.B	lbC0005D4
	MOVEQ	#5,D0
	bra	return_now

lbC0005D4	ADDQ.L	#1,D4
	CMP.L	#5,D4
	BLT.B	lbC000570
; -----------------------------------------------------
	MOVEA.L	(active_bitmap_ptr-DT,A4),A0
	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A1
	MOVE.L	(bm_Planes,A0),(bm_Planes,A1)
; ----
	MOVEA.L	(active_bitmap_ptr-DT,A4),A0
	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A1
	MOVE.L	(bm_Planes+4,A0),(bm_Planes+4,A1)
; ----
	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A0
	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A1
	MOVE.L	(bm_Planes,A1),D0
	ADD.L	#4560,D0
	MOVE.L	D0,(bm_Planes+8,A0)
; ----
	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A0
	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A1
	MOVE.L	(bm_Planes+4,A1),D0
	ADD.L	#4560,D0
	MOVE.L	D0,(bm_Planes+12,A0)
; ----
	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A0
	MOVE.L	(bm_Planes+8,A0),D0
	ADD.L	#4560,D0
	MOVE.L	D0,(lbL011A6C-DT,A4)
; ----
	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A0
	MOVE.L	(bm_Planes+12,A0),D0
	ADD.L	#4560,D0
	MOVE.L	D0,(lbL011A68-DT,A4)
; ----
	MOVE.L	(lbL011A6C-DT,A4),D0
	ADD.L	#962,D0
	MOVE.L	D0,(lbL011CA0-DT,A4)
; ----
	MOVE.L	(lbL011A68-DT,A4),D0
	ADD.L	#962,D0
	MOVE.L	D0,(lbL011CC6-DT,A4)
; ----
	MOVE.L	(lbL011A6C-DT,A4),(lbL011C9C-DT,A4)
	MOVE.L	(lbL011A6C-DT,A4),D0
	ADD.L	#300,D0
	MOVE.L	D0,(lbL011CC2-DT,A4)
; ----
	LEA	(viewport2_rasinfo-DT,A4),A0
	MOVE.L	A0,(viewport2_rasinfo_ptr-DT,A4)
	PEA	(viewport2-DT,A4)
	PEA	(view-DT,A4)
	JSR	(_MakeVPort-DT,A4)
	ADDQ.W	#8,SP
	PEA	(MEMF_CHIP).W
	PEA	(3584).W
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(v6_buffer_ptr-DT,A4)
	BNE.B	lbC0006AA
	MOVEQ	#$10,D0
	bra	return_now

lbC0006AA	CLR.L	-(SP)
	PEA	($170C).W
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011A94-DT,A4)
	BNE.B	lbC0006C2
	MOVEQ	#$11,D0
	bra	return_now

lbC0006C2	MOVE.L	(v6_buffer_ptr-DT,A4),D0
	ADD.L	#$400,D0
	MOVE.L	D0,(v6_buffer2_ptr-DT,A4)
	MOVE.L	(v6_buffer2_ptr-DT,A4),-(SP)
	MOVE.L	(v6_buffer_ptr-DT,A4),-(SP)
	PEA	(audio_something-DT,A4)
	JSR	(_install_aud_handlers-DT,A4)
	LEA	(12,SP),SP
	BSET	#3,(some_flags-DT,A4)
	PEA	(MEMF_CHIP).W
	PEA	(81920).L
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011A54-DT,A4)
	BNE.B	lbC000706
	MOVEQ	#6,D0
	bra	return_now

lbC000706	BSET	#4,(some_flags-DT,A4)
	PEA	(MEMF_CHIP).W
	PEA	(36864).L
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(buffer_36864-DT,A4)
	BNE.B	lbC000728
	MOVEQ	#7,D0
	bra	return_now

lbC000728	MOVE.L	(buffer_36864-DT,A4),D0
	ADD.L	#32768,D0
	MOVE.L	D0,(mid_buffer_36864-DT,A4)
	BSET	#5,(some_flags-DT,A4)
	PEA	(MEMF_CHIP).W
	PEA	(78000).L
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(buffer_78000-DT,A4)
	BNE.B	lbC000758
	MOVEQ	#8,D0
	bra	return_now

lbC000758	BSET	#7,(some_flags-DT,A4)
	PEA	(MEMF_CHIP).W
	PEA	(12288).W
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(buffer_12288-DT,A4)
	BNE.B	lbC000778
	MOVEQ	#10,D0
	bra	return_now

lbC000778	BSET	#0,(some_more_flags-DT,A4)
	PEA	(MEMF_CHIP).W
	PEA	(5632).W
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(buffer_5632-DT,A4)
	BNE.B	lbC000798
	MOVEQ	#11,D0
	bra	return_now

lbC000798	BSET	#2,(some_more_flags-DT,A4)
	PEA	(MEMF_CHIP).W
	PEA	(1024).W
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(buffer_1024-DT,A4)
	BNE.B	lbC0007B8
	MOVEQ	#$22,D0
	bra	return_now

lbC0007B8	BSET	#6,(some_more_flags-DT,A4)
	PEA	(MODE_OLDFILE).W
	PEA	(v6.MSG,PC)
	JSR	(_Open-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(-4,A5)
	BEQ.B	lbC000816
	PEA	(1024).W
	MOVE.L	(v6_buffer_ptr-DT,A4),-(SP)
	MOVE.L	(-4,A5),-(SP)
	JSR	(_Read-DT,A4)
	LEA	(12,SP),SP
	CLR.L	-(SP)
	PEA	(1024).W
	MOVE.L	(-4,A5),-(SP)
	JSR	(_Seek-DT,A4)
	LEA	(12,SP),SP
	PEA	(2560).W
	MOVE.L	(v6_buffer2_ptr-DT,A4),-(SP)
	MOVE.L	(-4,A5),-(SP)
	JSR	(_Read-DT,A4)
	LEA	(12,SP),SP
	MOVE.L	(-4,A5),-(SP)
	JSR	(_Close-DT,A4)
	ADDQ.W	#4,SP
lbC000816	MOVEA.L	(bitmap640x57x4_ptr-DT,A4),A0
	MOVE.L	(bm_Planes,A0),(bitmap640x57x1_planes-DT,A4)
	PEA	(88).W
	PEA	(lbL00E964-DT,A4)
	JSR	(_malloc_maybe-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(spritedata_ptr-DT,A4)
	MOVE.L	(spritedata_ptr-DT,A4),-(SP)
	PEA	(simplesprite-DT,A4)
	PEA	(viewport2-DT,A4)
	JSR	(_ChangeSprite-DT,A4)	;!*************
	LEA	(12,SP),SP
	LEA	(viewport2-DT,A4),A0
	MOVE.L	A0,(viewport2_ptr-DT,A4)
	PEA	(256).W
	PEA	(lbL00EF18-DT,A4)
	JSR	(_malloc_maybe-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011A38-DT,A4)
	PEA	(256).W
	PEA	(lbL00EFE0-DT,A4)
	JSR	(_malloc_maybe-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011A3C-DT,A4)
	MOVEQ	#0,D0
	bra	return_now

GraphicsName	db	'graphics.library',0
layerslibrary.MSG	db	'layers.library',0
;TrackdiskName	db	'trackdisk.device',0
;FONTSAmber9.MSG	db	'FONTS:Amber/9',0
FONTSAmber9.MSG	db	'progdir:FONTS/Amber/9',0
v6.MSG	db	'progdir:v6',0

	even
cleanup	LINK.W	A5,#0
	MOVE.L	D4,-(SP)
	BTST	#6,(some_more_flags-DT,A4)
	BEQ.B	lbC0008D6
	PEA	($400).W
	MOVE.L	(buffer_1024-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC0008D6	BTST	#2,(some_more_flags-DT,A4)
	BEQ.B	lbC0008EC
	PEA	($1600).W
	MOVE.L	(buffer_5632-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC0008EC	BTST	#0,(some_more_flags-DT,A4)
	BEQ.B	lbC000902
	PEA	($3000).W
	MOVE.L	(buffer_12288-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC000902	BTST	#7,(some_flags-DT,A4)
	BEQ.B	lbC00091A
	PEA	($130B0).L
	MOVE.L	(buffer_78000-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC00091A	BTST	#5,(some_flags-DT,A4)
	BEQ.B	lbC000932
	PEA	($9000).L
	MOVE.L	(buffer_36864-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC000932	BTST	#4,(some_flags-DT,A4)
	BEQ.B	lbC00094A
	PEA	($14000).L
	MOVE.L	(lbL011A54-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC00094A
	BTST	#3,(some_flags-DT,A4)
	BEQ.B	lbC000972
	JSR	(_remove_aud_handlers-DT,A4)
	PEA	($E00).W
	MOVE.L	(v6_buffer_ptr-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
	PEA	($170C).W
	MOVE.L	(lbL011A94-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC000972	LEA	(lbL00E964-DT,A4),A0
	MOVEA.L	(spritedata_ptr-DT,A4),A1
	CMPA.L	A0,A1
	BEQ.B	lbC00098C
	PEA	($58).W
	MOVE.L	(spritedata_ptr-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC00098C	LEA	(lbL00EF18-DT,A4),A0
	MOVEA.L	(lbL011A38-DT,A4),A1
	CMPA.L	A0,A1
	BEQ.B	lbC0009A6
	PEA	($100).W
	MOVE.L	(lbL011A38-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC0009A6	LEA	(lbL00EFE0-DT,A4),A0
	MOVEA.L	(lbL011A3C-DT,A4),A1
	CMPA.L	A0,A1
	BEQ.B	lbC0009C0
	PEA	($100).W
	MOVE.L	(lbL011A3C-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC0009C0	MOVE.L	(actiview-DT,A4),-(SP)
	JSR	(_LoadView-DT,A4)
	ADDQ.W	#4,SP
	PEA	(viewport1-DT,A4)
	JSR	(_FreeVPortCopLists-DT,A4)
	ADDQ.W	#4,SP
	PEA	(viewport2-DT,A4)
	JSR	(_FreeVPortCopLists-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(lbL011C8E-DT,A4),-(SP)
	JSR	(_FreeCprList-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(lbL011CB4-DT,A4),-(SP)
	JSR	(_FreeCprList-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(view_shfcprlist-DT,A4),-(SP)
	JSR	(_FreeCprList-DT,A4)
	ADDQ.W	#4,SP
	TST.L	(viewport1_colormap-DT,A4)
	BEQ.B	lbC000A0C
	MOVE.L	(viewport1_colormap-DT,A4),-(SP)
	JSR	(_FreeColorMap-DT,A4)
	ADDQ.W	#4,SP
lbC000A0C
;;;;	TST.L	(viewport2_colormap-DT,A4)
;;;;	BEQ.B	lbC000A1C
;;;;	MOVE.L	(viewport2_colormap-DT,A4),-(SP)
;;;;	JSR	(_FreeColorMap-DT,A4)
;;;;	ADDQ.W	#4,SP
;;;;lbC000A1C
	MOVEQ	#0,D4
lbC000A1E	MOVE.L	D4,D0
	ASL.L	#2,D0
	MOVEA.L	D0,A0
	ADDA.L	(bitmap_array_ptr-DT,A4),A0
	TST.L	(8,A0)
	BEQ.B	lbC000A4C
	PEA	($C8).W
	PEA	($140).W
	MOVE.L	D4,D0
	ASL.L	#2,D0
	MOVEA.L	D0,A0
	ADDA.L	(bitmap_array_ptr-DT,A4),A0
	MOVE.L	(8,A0),-(SP)
	JSR	(_FreeRaster-DT,A4)
	LEA	(12,SP),SP
lbC000A4C	ADDQ.L	#1,D4
	CMP.L	#5,D4
	BLT.B	lbC000A1E
	MOVEQ	#0,D4
lbC000A58	MOVE.L	D4,D0
	ASL.L	#2,D0
	MOVEA.L	D0,A0
	ADDA.L	(bitmap320x200x5_ptr-DT,A4),A0
	TST.L	(8,A0)
	BEQ.B	lbC000A86
	PEA	($C8).W
	PEA	($140).W
	MOVE.L	D4,D0
	ASL.L	#2,D0
	MOVEA.L	D0,A0
	ADDA.L	(bitmap320x200x5_ptr-DT,A4),A0
	MOVE.L	(8,A0),-(SP)
	JSR	(_FreeRaster-DT,A4)
	LEA	(12,SP),SP
lbC000A86	ADDQ.L	#1,D4
	CMP.L	#5,D4
	BLT.B	lbC000A58
	BTST	#2,(some_flags-DT,A4)
	BEQ.B	lbC000A9C
	JSR	(remove_input_handler,PC)
lbC000A9C	BTST	#1,(some_more_flags-DT,A4)
	BEQ.B	lbC000AAE
	MOVE.L	(fontseg_bptr-DT,A4),-(SP)
	JSR	(_UnLoadSeg-DT,A4)
	ADDQ.W	#4,SP
lbC000AAE
;	BTST	#5,(some_more_flags-DT,A4)
;	BEQ.B	lbC000AC0
;	MOVE.L	(trackdisk_io-DT,A4),-(SP)
;	JSR	(_CloseDevice-DT,A4)
;	ADDQ.W	#4,SP
lbC000AC0
;	BTST	#4,(some_more_flags-DT,A4)
;	BEQ.B	lbC000AD6
;	PEA	($38).W
;	MOVE.L	(trackdisk_io-DT,A4),-(SP)
;	JSR	(_DeleteStdIO2-DT,A4)
;	ADDQ.W	#8,SP
lbC000AD6
;	BTST	#3,(some_more_flags-DT,A4)
;	BEQ.B	lbC000AE8
;	MOVE.L	(trackdisk_mp-DT,A4),-(SP)
;	JSR	(_DeleteMsgPort-DT,A4)
;	ADDQ.W	#4,SP
lbC000AE8
	BTST	#0,(some_flags-DT,A4)
	BEQ.B	lbC000B1A
;;;;	PEA	($A0).W
	PEA	(200).W
	MOVE.L	(bitmap_array_ptr-DT,A4),-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
lbC000B1A
	BTST	#1,(some_flags-DT,A4)
	BEQ.B	lbC000B04

	MOVE.L	(layerinfo-DT,A4),-(SP)
	JSR	(_DisposeLayerInfo-DT,A4)
	ADDQ.W	#4,SP
;;;;	CLR.L	-(SP)
	pea	(1).w
	JSR	(_FreeSprite-DT,A4)
	ADDQ.W	#4,SP
	CLR.W	(some_more_flags-DT,A4)
	MOVE.L	(SP)+,D4

	MOVE.L	(_GfxBase-DT,A4),-(SP)
	JSR	(_CloseLibrary-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(LayersBase-DT,A4),-(SP)
	JSR	(_CloseLibrary-DT,A4)
	ADDQ.W	#4,SP
lbC000B04

	UNLK	A5
	RTS

lbC000B36	LINK.W	A5,#-4
	MOVEM.L	D4-D6/A2/A3,-(SP)
	MOVEQ	#0,D6
	MOVE.L	D6,D5
	PEA	(8).W	;trackdisk_io index
	MOVE.L	(buffer_5632-DT,A4),-(SP)	;buffer address
	PEA	(11).W	;number of sectors
	PEA	(920).W	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
;	PEA	(trackdisk_io_8-DT,A4)
;	JSR	(_WaitIO-DT,A4)	;!***************
;	ADDQ.W	#4,SP
	CLR.W	(lbW01269E-DT,A4)
	MOVEA.L	(buffer_5632-DT,A4),A3
	MOVEQ	#0,D4
lbC000B6E	LEA	(-4,A5),A0
	MOVEA.L	A0,A2
	MOVEA.L	A3,A0
	ADDQ.L	#1,A3
	MOVEA.L	A2,A1
	ADDQ.L	#1,A2
	MOVE.B	(A0),(A1)
	MOVEA.L	A3,A0
	ADDQ.L	#1,A3
	MOVEA.L	A2,A1
	ADDQ.L	#1,A2
	MOVE.B	(A0),(A1)
	MOVEA.L	A3,A0
	ADDQ.L	#1,A3
	MOVEA.L	A2,A1
	ADDQ.L	#1,A2
	MOVE.B	(A0),(A1)
	MOVEA.L	A3,A0
	ADDQ.L	#1,A3
	MOVEA.L	A2,A1
	ADDQ.L	#1,A2
	MOVE.B	(A0),(A1)
	MOVE.L	D4,D0
	ASL.L	#2,D0
	LEA	(lbL011BB8-DT,A4),A0
	MOVE.L	A3,(A0,D0.L)
	MOVE.L	D4,D0
	ASL.L	#2,D0
	LEA	(lbL011BD0-DT,A4),A0
	MOVE.L	(-4,A5),(A0,D0.L)
	ADDA.L	(-4,A5),A3
	ADDQ.L	#1,D4
	CMP.L	#6,D4
	BLT.B	lbC000B6E
	MOVEM.L	(SP)+,D4-D6/A2/A3
	UNLK	A5
	RTS

lbC000BCC	LINK.W	A5,#-8
	MOVEM.L	D4-D7,-(SP)
	MOVE.W	(10,A5),D4
	MOVE.W	(14,A5),D5
	MOVE.L	($10,A5),D6
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#15,D0
	BEQ.B	lbC000C3C
	ADDQ.W	#4,D4
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#15,D0
	BEQ.B	lbC000C3C
	SUBQ.W	#8,D4
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#15,D0
	BEQ.B	lbC000C3C
	MOVEQ	#0,D0
lbC000C34	MOVEM.L	(SP)+,D4-D7
	UNLK	A5
	RTS

lbC000C3C	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVEA.L	D1,A0
	PEA	(-$10,A0)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#15,D0
	BNE.B	lbC000C5E
	SUB.W	#$10,D4
lbC000C5E	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVEA.L	D1,A0
	PEA	(-$10,A0)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#15,D0
	BNE.B	lbC000C80
	SUB.W	#$10,D4
lbC000C80	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVEA.L	D0,A0
	PEA	($20,A0)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#15,D0
	BNE.B	lbC000CA2
	ADD.W	#$20,D5
lbC000CA2	LSR.W	#4,D4
	LSR.W	#5,D5
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVE.B	(A0),(-1,A5)
	MOVEQ	#0,D0
	MOVE.B	(-1,A5),D0
	LSR.L	#6,D0
	ASL.L	#1,D0
	LEA	(lbL00ED04-DT,A4),A0
	MOVE.W	(A0,D0.L),(-4,A5)
	CLR.W	(-6,A5)
	bra	lbC000EAC

lbC000CDA	MOVE.W	(-6,A5),D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbW00EE00-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	MOVE.W	(-4,A5),D2
	EXT.L	D2
	CMP.L	D2,D1
	bne	lbC000EA8
	MOVE.W	(-6,A5),D3
	EXT.L	D3
	ASL.L	#3,D3
	LEA	(lbW00EDFE-DT,A4),A1
	MOVE.B	(A1,D3.L),D2
	CMP.B	(-1,A5),D2
	bne	lbC000EA8
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbB00EE05-DT,A4),A0
	TST.B	(A0,D0.L)
	BEQ.B	lbC000D3A
	MOVE.W	(-6,A5),D1
	EXT.L	D1
	ASL.L	#3,D1
	LEA	(lbB00EE05-DT,A4),A1
	MOVEQ	#0,D2
	MOVE.B	(A1,D1.L),D2
	CMP.L	D6,D2
	bne	lbC000EA8
lbC000D3A	MOVE.W	(-6,A5),D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbB00EE02-DT,A4),A0
	MOVE.L	D0,-(SP)
	MOVE.L	A0,-(SP)
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVEA.L	(SP)+,A1
	MOVE.L	(SP)+,D0
	MOVE.B	(A1,D0.L),(A0)
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbB00EE03-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.W	D1,(-8,A5)
	TST.W	(-8,A5)
	beq	lbC000E8E
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbB00EE04-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,D7
	CMP.L	#1,D7
	BNE.B	lbC000DBE
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	SUBQ.L	#1,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVE.B	(-7,A5),(A0)
	bra	lbC000E8E

lbC000DBE	CMP.L	#3,D7
	BNE.B	lbC000DE4
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	SUBQ.L	#1,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVE.B	(-7,A5),(A0)
	bra	lbC000E8E

lbC000DE4	CMP.L	#4,D7
	BNE.B	lbC000E3E
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	SUBQ.L	#1,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVE.B	#$57,(A0)
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	ADDQ.L	#1,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVE.B	#$56,(A0)
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	SUBQ.L	#1,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	ADDQ.L	#1,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVE.B	#$58,(A0)
	BRA.B	lbC000E8E

lbC000E3E	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	ADDQ.L	#1,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVE.B	(-7,A5),(A0)
	CMP.L	#2,D7
	BEQ.B	lbC000E8E
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbB00EE04-DT,A4),A0
	MOVE.L	D0,-(SP)
	MOVE.L	A0,-(SP)
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D4,D1
	ADDQ.L	#2,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVEA.L	(SP)+,A1
	MOVE.L	(SP)+,D0
	MOVE.B	(A1,D0.L),(A0)
lbC000E8E	MOVE.B	#$63,(lbB011939-DT,A4)
	CLR.W	(lbW00EDEC-DT,A4)
	PEA	(Itopened.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#1,D0
	bra	lbC000C34

lbC000EA8	ADDQ.W	#1,(-6,A5)
lbC000EAC	CMPI.W	#$11,(-6,A5)
	blt	lbC000CDA
	TST.B	(lbB011949-DT,A4)
	BNE.B	lbC000ECA
	TST.L	D6
	BNE.B	lbC000ECA
	PEA	(Itslocked.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
lbC000ECA	MOVE.B	#1,(lbB011949-DT,A4)
	MOVEQ	#0,D0
	bra	lbC000C34

Itopened.MSG	db	'It opened.',0
Itslocked.MSG	db	'It''s locked.',0

main	LINK.W	A5,#-$46
	MOVE.L	D4,-(SP)
	CLR.W	(lbW011998-DT,A4)
	JSR	(open_everything,PC)	;Open gfx and everything
	MOVE.L	D0,D4
	TST.L	D4
	BEQ.B	lbC000F0E
	MOVE.L	D4,-(SP)
	JSR	(lbC00DE2C-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC00572A

lbC000F0E	JSR	(_silence_audio-DT,A4)
	MOVE.L	(font_ptr-DT,A4),-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetFont-DT,A4)
	ADDQ.W	#8,SP
	PEA	(TTheFaeryTale.MSG-DT,A4)
	JSR	(lbC00DDDE-DT,A4)
	ADDQ.W	#4,SP
	LEA	(bitmap640x57x1-DT,A4),A0
	MOVE.L	A0,(active_rp_bitmap_ptr-DT,A4)
	MOVE.L	(font_ptr-DT,A4),-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetFont-DT,A4)
	ADDQ.W	#8,SP
	PEA	(10).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	PEA	(11).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetBPen-DT,A4)
	ADDQ.W	#8,SP
	JSR	(_read_songs_file-DT,A4)
	JSR	(lbC000B36,PC)
	PEA	($32).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	LEA	(viewport1-DT,A4),A0
	MOVE.L	A0,(lbL0119F4-DT,A4)
	LEA	(viewport1_rasinfo-DT,A4),A0
	MOVE.L	A0,(viewport1_rasinfo_ptr-DT,A4)
	MOVEQ	#0,D4
lbC000F80	MOVE.L	D4,D0
	ASL.L	#2,D0
	LEA	(bitmap320x200x5_plane0-DT,A4),A0
	MOVE.L	D4,D1
	ASL.L	#2,D1
	LEA	(bitmap320x200x5_2_planes-DT,A4),A1
	MOVE.L	D1,-(SP)
	MOVE.L	#$1F40,D1
	MOVE.L	D0,-(SP)
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	MOVE.L	(SP)+,D2
	MOVE.L	(SP)+,D3
	ADD.L	(lbL011A54-DT,A4),D0
	MOVE.L	D0,(A1,D3.L)
	ADD.L	#$9C40,D0
	MOVE.L	D0,(A0,D2.L)
	ADDQ.L	#1,D4
	CMP.L	#5,D4
	BLT.B	lbC000F80
	MOVEA.L	(bitmap320x200x1_ptr-DT,A4),A0
	MOVE.L	(buffer_36864-DT,A4),(8,A0)
	MOVE.L	(tune_4-DT,A4),-(SP)
	MOVE.L	(tune_3-DT,A4),-(SP)
	MOVE.L	(tune_2-DT,A4),-(SP)
	MOVE.L	(tune_1-DT,A4),-(SP)
	JSR	(_init_aud_2-DT,A4)
	LEA	($10,SP),SP
	PEA	($20).W
	PEA	(colormap2-DT,A4)
	PEA	(viewport2-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	LEA	(rasinfo3-DT,A4),A0
	MOVE.L	A0,(rasinfo3_ptr-DT,A4)
	CLR.L	-(SP)
	JSR	(make_display_2,PC)
	ADDQ.W	#4,SP
	JSR	(make_display,PC)
	JSR	(make_display,PC)
	JSR	(lbC00DF22-DT,A4)
	TST.L	D0
	bne	lbC001120
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	(bitmap320x200x5_2-DT,A4)
	PEA	(page0.MSG,PC)
	JSR	(lbC00DF88-DT,A4)
	LEA	($10,SP),SP
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	PEA	($C8).W
	PEA	($140).W
	CLR.L	-(SP)
	CLR.L	-(SP)
	MOVE.L	(bitmap_array_ptr-DT,A4),-(SP)
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	(bitmap320x200x5_2-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	PEA	($C8).W
	PEA	($140).W
	CLR.L	-(SP)
	CLR.L	-(SP)
	MOVE.L	(bitmap320x200x5_ptr-DT,A4),-(SP)
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	(bitmap320x200x5_2-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	LEA	(viewport1_rasinfo-DT,A4),A0
	MOVE.L	A0,(rasinfo3_ptr-DT,A4)
	MOVEQ	#0,D4
lbC00108A	MOVE.L	D4,-(SP)
	JSR	(make_display_2,PC)
	ADDQ.W	#4,SP
	ADDQ.L	#4,D4
	CMP.L	#$A0,D4
	BLE.B	lbC00108A
	LEA	(rasinfo3-DT,A4),A0
	MOVE.L	A0,(rasinfo3_ptr-DT,A4)
	JSR	(lbC00DF22-DT,A4)
	TST.L	D0
	BNE.B	lbC001104
	PEA	(29).W
	PEA	(21).W
	PEA	(p1b.MSG,PC)
	PEA	(p1a.MSG,PC)
	JSR	(_display_brother-DT,A4)
	LEA	($10,SP),SP
	PEA	(29).W
	PEA	(20).W
	PEA	(p2b.MSG,PC)
	PEA	(lbC005754,PC)
	JSR	(_display_brother-DT,A4)
	LEA	($10,SP),SP
	PEA	(33).W
	PEA	(20).W
	PEA	(p3b.MSG,PC)
	PEA	(p3a.MSG,PC)
	JSR	(_display_brother-DT,A4)
	LEA	($10,SP),SP
	TST.B	(lbB011818-DT,A4)
	BNE.B	lbC001104
	PEA	($BE).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
lbC001104	LEA	(viewport1_rasinfo-DT,A4),A0
	MOVE.L	A0,(rasinfo3_ptr-DT,A4)
	MOVE.L	#156,D4
lbC001112	MOVE.L	D4,-(SP)
	JSR	(make_display_2,PC)
	ADDQ.W	#4,SP
	SUBQ.L	#4,D4
	TST.L	D4
	BGE.B	lbC001112
lbC001120	JSR	(lbC00DF04-DT,A4)
	LEA	(rasinfo3-DT,A4),A0
	MOVE.L	A0,(rasinfo3_ptr-DT,A4)
	MOVEA.L	(lbL011A08-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(rp1_bitmap_ptr-DT,A4)
	CLR.L	-(SP)
	PEA	(rp1-DT,A4)
	JSR	(_SetRast-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(rp1_bitmap_ptr-DT,A4)
	CLR.L	-(SP)
	PEA	(rp1-DT,A4)
	JSR	(_SetRast-DT,A4)
	ADDQ.W	#8,SP
	PEA	($20).W
	PEA	(colormap2-DT,A4)
	PEA	(viewport2-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	PEA	($9C).W
	JSR	(make_display_2,PC)
	ADDQ.W	#4,SP
	PEA	(3).W
	CLR.L	-(SP)
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	(viewport1-DT,A4)
	JSR	(_SetRGB4-DT,A4)
	LEA	($14,SP),SP
	CLR.L	-(SP)	;trackdisk_io index
	MOVE.L	(buffer_12288-DT,A4),-(SP)	;buffer address
	PEA	(24).W	;number of sectors
	PEA	(896).W	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
;	MOVE.L	(trackdisk_io_ptr-DT,A4),-(SP)
;	JSR	(_WaitIO-DT,A4)
;	ADDQ.W	#4,SP
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	CLR.W	(IO_COMMAND,A0)	;!*****************
	PEA	(6).W
	CLR.L	-(SP)
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	(viewport1-DT,A4)
	JSR	(_SetRGB4-DT,A4)
	LEA	($14,SP),SP
	CLR.L	-(SP)
	CLR.L	-(SP)
	MOVE.L	(bitmap640x57x4_ptr-DT,A4),-(SP)
	PEA	(hiscreen.MSG,PC)
	JSR	(lbC00DF88-DT,A4)
	LEA	($10,SP),SP
	PEA	(15).W
	PEA	(15).W
	PEA	(15).W
	PEA	(1).W
	PEA	(viewport1-DT,A4)
	JSR	(_SetRGB4-DT,A4)
	LEA	($14,SP),SP
	LEA	(rp1-DT,A4),A0
	MOVE.L	A0,(active_rp_ptr-DT,A4)
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(rp1_bitmap_ptr-DT,A4)
	JSR	(lbC00DEE6-DT,A4)
	PEA	(1).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	PEA	($13).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	CLR.B	(lbB012113-DT,A4)
	CLR.B	(lbB012112-DT,A4)
	MOVE.W	#1,(-4,A5)
	JSR	(lbC00DF46-DT,A4)
	TST.L	D0
	beq	lbC00572A
	PEA	($14).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	CLR.W	(rasinfo3_ryoffset-DT,A4)
	CLR.W	(rasinfo1_ryoffset-DT,A4)
	CLR.W	(rasinfo3_rxoffset-DT,A4)
	CLR.W	(rasinfo1_rxoffset-DT,A4)
	JSR	(_silence_audio-DT,A4)
	PEA	(1).W
	JSR	(lbC005F98,PC)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(rp1_bitmap_ptr-DT,A4)
	MOVE.W	#143,(viewport2_dyoffset-DT,A4)
	MOVE.W	#57,(viewport2_dheight-DT,A4)
	MOVE.W	#140,(viewport1_dheight-DT,A4)
	MOVE.W	#16,(viewport1_dxoffset-DT,A4)
	MOVE.W	#288,(viewport1_dwidth-DT,A4)
	CLR.W	(viewport1_dyoffset-DT,A4)
	PEA	(viewport2-DT,A4)
	PEA	(view-DT,A4)
	JSR	(_MakeVPort-DT,A4)
	ADDQ.W	#8,SP
	PEA	(20).W
	PEA	(lbL00E9B4-DT,A4)
	PEA	(viewport2-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	LEA	(simplesprite-DT,A4),A0
	MOVE.L	A0,(lbL01211A-DT,A4)
	CLR.W	(lbW011CC0-DT,A4)
	CLR.W	(lbW011C9A-DT,A4)
	CLR.W	(lbW011CD4-DT,A4)
	CLR.W	(lbW011CAE-DT,A4)
	MOVE.B	#$63,(lbB011939-DT,A4)
	CLR.W	(lbW01199C-DT,A4)
	JSR	(lbC0067BC,PC)
	MOVEQ	#0,D0
	MOVE.B	D0,(lbB011940-DT,A4)
	EXT.W	D0
	MOVE.W	D0,(lbW011968-DT,A4)
lbC0012F0	TST.B	(lbB011940-DT,A4)
	bne	lbC005726
	MOVE.L	#_ciaa,(-$26,A5)
	ADDQ.W	#1,(-$1C,A5)
	ADDQ.B	#1,(lbB01193A-DT,A4)
	JSR	(_get_key_perhaps-DT,A4)

	cmpi.b	#$11,d0
	bne.b	1$
	tst.w	(lbW011968-DT,a4)
	beq.b	1$
	movem.l	d0/d1/a0/a1,-(sp)
	lea	(view-DT,a4),a0
	jsr	(_save_map)
	tst.l	d0
	beq	2$
	pea	(errorsaving.MSG,pc)
	bra	3$
2$	pea	(savedok.MSG,pc)
3$	jsr	(_log_message-DT,a4)
	addq.w	#4,sp
	movem.l	(sp)+,d0/d1/a0/a1
	moveq	#0,d0
1$
	MOVE.B	D0,(-5,A5)
	BTST	#0,(lbB00EC01-DT,A4)
	BNE.B	lbC001320
	MOVE.W	#1,(-$22,A5)
	BRA.B	lbC001324

lbC001320	CLR.W	(-$22,A5)
lbC001324	TST.B	(-5,A5)
	beq	lbC001892
	TST.B	(lbB011939-DT,A4)
	BEQ.B	lbC001350
	TST.W	(-$22,A5)
	BEQ.B	lbC001350
	MOVE.B	(-5,A5),D0
	EXT.W	D0
	EXT.L	D0
	BTST	#7,D0
	BNE.B	lbC00134C
	MOVE.B	#$63,(lbB011939-DT,A4)
lbC00134C	bra	lbC001892

lbC001350	CMPI.B	#15,(lbB01231A-DT,A4)
	BNE.B	lbC00135C
	bra	lbC001892

lbC00135C	CMPI.B	#$14,(-5,A5)
	BLT.B	lbC00137A
	CMPI.B	#$1D,(-5,A5)
	BGT.B	lbC00137A
	MOVE.B	(-5,A5),D0
	EXT.W	D0
	MOVE.W	D0,(lbW00EDEC-DT,A4)
	bra	lbC001892

lbC00137A	MOVE.B	(-5,A5),D0
	EXT.W	D0
	EXT.L	D0
	AND.L	#$7F,D0
	MOVE.W	(lbW00EDEC-DT,A4),D1
	EXT.L	D1
	CMP.L	D1,D0
	BNE.B	lbC00139A
	CLR.W	(lbW00EDEC-DT,A4)
	bra	lbC001892

lbC00139A	CMPI.B	#$30,(-5,A5)
	BNE.B	lbC0013AC
	MOVE.W	#1,(lbW0119D8-DT,A4)
	bra	lbC001892

lbC0013AC	MOVE.B	(-5,A5),D0
	EXT.W	D0
	EXT.L	D0
	AND.L	#$7F,D0
	CMP.L	#$30,D0
	BNE.B	lbC0013CA
	CLR.W	(lbW0119D8-DT,A4)
	bra	lbC001892

lbC0013CA	CMPI.B	#$42,(-5,A5)
	BNE.B	lbC00141A
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC00141A
	CMPI.W	#11,(lbW011990-DT,A4)
	BNE.B	lbC0013EA
	MOVEA.L	(lbL0119FC-DT,A4),A0
	MOVE.B	#1,(5,A0)
lbC0013EA	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVEA.L	D0,A0
	PEA	($14,A0)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVEA.L	D1,A1
	PEA	($14,A1)
	CLR.L	-(SP)
	JSR	(lbC00DF58-DT,A4)
	LEA	(12,SP),SP
	PEA	(11).W
	JSR	(lbC005EBA,PC)
	ADDQ.W	#4,SP
	bra	lbC001892

lbC00141A	CMPI.B	#$2E,(-5,A5)
	BNE.B	lbC00144A
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC00144A
	PEA	($1F).W
	JSR	(lbC00DDCC-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDA.L	D0,A0
	ADDQ.B	#3,(A0)
	JSR	(lbC007F3A,PC)
	MOVEA.L	(lbL0119FC-DT,A4),A0
	CLR.B	($16,A0)
	bra	lbC001892

lbC00144A	MOVE.B	(-5,A5),D0
	EXT.W	D0
	EXT.L	D0
	AND.L	#$7F,D0
	CMP.L	#$61,D0
	blt	lbC00167E
	CMPI.W	#11,(-$20,A5)
	BLE.B	lbC001470
	MOVE.W	#11,(-$20,A5)
lbC001470	TST.W	(-$20,A5)
	BGE.B	lbC00147A
	CLR.W	(-$20,A5)
lbC00147A	MOVE.B	(-5,A5),D0
	EXT.W	D0
	EXT.L	D0
	AND.L	#$7F,D0
	SUB.L	#$61,D0
	MOVE.W	D0,(-$20,A5)
	MOVE.W	(-$20,A5),D0
	LEA	(lbL011B5A-DT,A4),A0
	MOVE.B	(A0,D0.W),(lbB011938-DT,A4)
	MOVE.B	(-5,A5),D0
	EXT.W	D0
	EXT.L	D0
	BTST	#7,D0
	BEQ.B	lbC0014DE
	TST.B	(lbB011938-DT,A4)
	BLT.B	lbC0014DA
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	LEA	(ascii.MSG11-DT,A4),A0
	MOVE.B	(lbB011938-DT,A4),D1
	CMP.B	(A0,D0.L),D1
	BGE.B	lbC0014DA
	CLR.L	-(SP)
	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC0068DA,PC)
	ADDQ.W	#8,SP
lbC0014DA	bra	lbC00167A

lbC0014DE	MOVE.B	#1,(lbB011937-DT,A4)
	TST.B	(lbB011938-DT,A4)
	blt	lbC00167A
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	LEA	(ascii.MSG11-DT,A4),A0
	MOVE.B	(lbB011938-DT,A4),D1
	CMP.B	(A0,D0.L),D1
	bge	lbC00167A
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.B	(lbB011938-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	EXT.L	D2
	AND.L	#$FC,D2
	MOVE.W	D2,(-$1E,A5)
	CMPI.W	#8,(-$1E,A5)
	BEQ.B	lbC001538
	CLR.B	(lbB012115-DT,A4)
lbC001538	CMPI.W	#4,(-$1E,A5)
	BNE.B	lbC0015A4
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.B	(lbB011938-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	ADDA.L	D0,A0
	BCHG	#0,(A0)
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.B	(lbB011938-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	EXT.L	D2
	AND.L	#1,D2
	MOVE.L	D2,-(SP)
	MOVE.W	(-$20,A5),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	JSR	(lbC0068DA,PC)
	ADDQ.W	#8,SP
	MOVE.B	(lbB011938-DT,A4),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC006A76,PC)
	ADDQ.W	#4,SP
	bra	lbC00167A

lbC0015A4	CMPI.W	#8,(-$1E,A5)
	BNE.B	lbC0015D2
	PEA	(1).W
	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC0068DA,PC)
	ADDQ.W	#8,SP
	MOVE.B	(lbB011938-DT,A4),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC006A76,PC)
	ADDQ.W	#4,SP
	bra	lbC00167A

lbC0015D2	CMPI.W	#12,(-$1E,A5)
	BNE.B	lbC00161A
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.B	(lbB011938-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	ADDA.L	D0,A0
	BSET	#0,(A0)
	PEA	(1).W
	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC0068DA,PC)
	ADDQ.W	#8,SP
	MOVE.B	(lbB011938-DT,A4),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC006A76,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC00167A

lbC00161A	TST.W	(-$22,A5)
	BNE.B	lbC001622
	BRA.B	lbC00167A

lbC001622	TST.W	(-$1E,A5)
	BNE.B	lbC001646
	CMPI.B	#5,(lbB011938-DT,A4)
	BGE.B	lbC001646
	MOVE.B	(lbB011938-DT,A4),D0
	EXT.W	D0
	MOVE.W	D0,(lbW01199C-DT,A4)
	PEA	(5).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC00167A

lbC001646	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.B	(lbB011938-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	EXT.L	D2
	AND.L	#1,D2
	MOVE.L	D2,-(SP)
	MOVE.W	(-$20,A5),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	JSR	(lbC0068DA,PC)
	ADDQ.W	#8,SP
lbC00167A	bra	lbC001892

lbC00167E	CMPI.B	#$52,(-5,A5)
	BNE.B	lbC001694
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC001694
	JSR	(lbC00DF5E-DT,A4)
	bra	lbC001892

lbC001694	CMPI.B	#$3D,(-5,A5)
	BNE.B	lbC0016B0
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC0016B0
	PEA	(2).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC001892

lbC0016B0
	CMPI.B	#$13,(-5,A5)
	BNE.B	lbC0016CC
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC0016CC
	PEA	(3).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC001892

lbC0016CC
	CMPI.B	#$12,(-5,A5)
	BNE.B	lbC0016E4
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC0016E4
	ADDI.W	#$3E8,(lbW011988-DT,A4)
	bra	lbC001892

lbC0016E4
	CMPI.B	#1,(-5,A5)
	BNE.B	lbC001702
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC001702
	SUBI.W	#$96,(lbW01230C-DT,A4)
	SUBI.W	#$96,(lbW011958-DT,A4)
	bra	lbC001892

lbC001702	CMPI.B	#2,(-5,A5)
	BNE.B	lbC001720
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC001720
	ADDI.W	#$96,(lbW01230C-DT,A4)
	ADDI.W	#$96,(lbW011958-DT,A4)
	bra	lbC001892

lbC001720	CMPI.B	#3,(-5,A5)
	BNE.B	lbC00173E
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC00173E
	ADDI.W	#$118,(lbW01230A-DT,A4)
	ADDI.W	#$118,(lbW011956-DT,A4)
	bra	lbC001892

lbC00173E	CMPI.B	#4,(-5,A5)
	BNE.B	lbC00175C
	TST.W	(lbW011968-DT,A4)
	BEQ.B	lbC00175C
	SUBI.W	#$118,(lbW01230A-DT,A4)
	SUBI.W	#$118,(lbW011956-DT,A4)
	bra	lbC001892

lbC00175C	CMPI.W	#6,(lbW01199C-DT,A4)
	BNE.B	lbC0017A4
	MOVE.B	(-5,A5),D0
	EXT.W	D0
	EXT.L	D0
	BTST	#7,D0
	BNE.B	lbC0017A4
	CMPI.B	#$31,(-5,A5)
	BLT.B	lbC001798
	CMPI.B	#$36,(-5,A5)
	BGT.B	lbC001798
	MOVE.B	(-5,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVEA.L	D0,A0
	PEA	(-$2C,A0)
	JSR	(lbC006A76,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC0017A0

lbC001798	CLR.L	-(SP)
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
lbC0017A0	bra	lbC001892

lbC0017A4	CMPI.B	#$20,(-5,A5)
	BEQ.B	lbC0017B4
	TST.W	(-$22,A5)
	beq	lbC001892
lbC0017B4	MOVEQ	#0,D4
lbC0017B6	MOVE.L	D4,D0
	ASL.L	#2,D0
	LEA	(I.MSG-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	CMP.B	(-5,A5),D1
	bne	lbC001886
	MOVE.L	D4,D0
	ASL.L	#2,D0
	LEA	(lbB00EC63-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	MOVE.W	D1,(-$2E,A5)
	CMPI.W	#5,(-$2E,A5)
	BNE.B	lbC0017EE
	CMPI.W	#5,(lbW01199C-DT,A4)
	bne	lbC001892
lbC0017EE	MOVE.W	(-$2E,A5),(lbW01199C-DT,A4)
	MOVE.L	D4,D0
	ASL.L	#2,D0
	LEA	(lbL00EC64-DT,A4),A0
	MOVE.B	(A0,D0.L),(lbB011938-DT,A4)
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.B	(lbB011938-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	AND.B	#2,D2
	MOVE.B	D2,(lbB011937-DT,A4)
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.B	(lbB011938-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	EXT.L	D2
	AND.L	#$FC,D2
	MOVE.W	D2,(-$1E,A5)
	CMPI.W	#4,(-$1E,A5)
	BNE.B	lbC001870
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.B	(lbB011938-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	ADDA.L	D0,A0
	BCHG	#0,(A0)
lbC001870	MOVE.B	(lbB011938-DT,A4),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC006A76,PC)
	ADDQ.W	#4,SP
	JSR	(lbC0067BC,PC)
	BRA.B	lbC001892

lbC001886	ADDQ.L	#1,D4
	CMP.L	#$26,D4
	blt	lbC0017B6
lbC001892	CMPI.B	#2,(lbB011939-DT,A4)
	BNE.B	lbC0018AC
	PEA	($C8).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	#$63,(lbB011939-DT,A4)
	BRA.B	lbC001908

lbC0018AC	CMPI.B	#1,(lbB011939-DT,A4)
	BEQ.B	lbC0018BC
	CMPI.B	#4,(lbB011939-DT,A4)
	BNE.B	lbC001908
lbC0018BC	BTST	#4,(lbB01193A-DT,A4)
	BEQ.B	lbC0018EA
	CMPI.B	#1,(lbB011939-DT,A4)
	BNE.B	lbC0018EA
	PEA	(15).W
	PEA	(15).W
	PEA	(15).W
	PEA	($1F).W
	PEA	(viewport1-DT,A4)
	JSR	(_SetRGB4-DT,A4)
	LEA	($14,SP),SP
	BRA.B	lbC001900

lbC0018EA	CLR.L	-(SP)
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	(viewport1-DT,A4)
	JSR	(_SetRGB4-DT,A4)
	LEA	($14,SP),SP
lbC001900	JSR	(lbC00DE92-DT,A4)
	bra	lbC0012F0

lbC001908	JSR	(lbC00DE32-DT,A4)
	BTST	#0,(lbB00EC01-DT,A4)
	BEQ.B	lbC001922
	PEA	(1).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC0012F0

lbC001922	TST.W	(lbW011998-DT,A4)
	BEQ.B	lbC00192C
	SUBQ.W	#1,(lbW011998-DT,A4)
lbC00192C	TST.W	(lbW011996-DT,A4)
	BEQ.B	lbC001936
	SUBQ.W	#1,(lbW011996-DT,A4)
lbC001936	TST.W	(lbW01199A-DT,A4)
	BEQ.B	lbC001940
	SUBQ.W	#1,(lbW01199A-DT,A4)
lbC001940	CMPI.W	#$2262,(lbW011956-DT,A4)
	BLS.B	lbC001964
	CMPI.W	#$34FA,(lbW011956-DT,A4)
	BCC.B	lbC001964
	CMPI.W	#$60A8,(lbW011958-DT,A4)
	BLS.B	lbC001964
	CMPI.W	#$7368,(lbW011958-DT,A4)
	BCC.B	lbC001964
	MOVEQ	#1,D0
	BRA.B	lbC001966

lbC001964	MOVEQ	#0,D0
lbC001966	MOVE.B	D0,(lbB011936-DT,A4)
	MOVE.B	(lbB01231A-DT,A4),D0
	EXT.W	D0
	MOVE.W	D0,(-$20,A5)
	CMPI.W	#15,(-$20,A5)
	BEQ.B	lbC001986
	CMPI.W	#$16,(-$20,A5)
	bne	lbC001A96
lbC001986	CMPI.B	#1,(lbB011943-DT,A4)
	BNE.B	lbC0019A0
	CLR.L	-(SP)
	JSR	(lbC005F98,PC)
	ADDQ.W	#4,SP
	MOVE.W	#13,(-$20,A5)
	bra	lbC001A92

lbC0019A0	SUBQ.B	#1,(lbB011943-DT,A4)
	CMPI.B	#$14,(lbB011943-DT,A4)
	BCC.B	lbC0019B0
	bra	lbC001A92

lbC0019B0	CMPI.W	#1,(lbW011976-DT,A4)
	BGE.B	lbC0019DA
	MOVEQ	#0,D0
	MOVE.B	(lbB011943-DT,A4),D0
	CMP.L	#$C8,D0
	BCC.B	lbC0019DA
	PEA	(1).W
	JSR	(lbC005F98,PC)
	ADDQ.W	#4,SP
	MOVE.W	#13,(-$20,A5)
	bra	lbC001A92

lbC0019DA	CMPI.B	#$16,(lbB01231A-DT,A4)
	BNE.B	lbC001A02
	MOVEQ	#0,D0
	MOVE.B	(lbB011943-DT,A4),D0
	CMP.L	#$C8,D0
	BCC.B	lbC001A02
	CLR.L	-(SP)
	JSR	(lbC005F98,PC)
	ADDQ.W	#4,SP
	MOVE.W	#13,(-$20,A5)
	bra	lbC001A92

lbC001A02	CMPI.B	#$78,(lbB011943-DT,A4)
	BCC.W	lbC001A92
	LEA	(lbW01234C-DT,A4),A0
	MOVE.L	A0,(-$1A,A5)
	MOVE.W	#4,(lbW01194A-DT,A4)
	MOVEQ	#0,D0
	MOVE.B	(lbB011943-DT,A4),D0
	ASL.L	#1,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	ADD.L	D1,D0
	SUB.L	#$14,D0
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	D0,(A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(lbW01195C-DT,A4),(2,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#1,(8,A0)
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	AND.L	#1,D0
	ADD.L	#$64,D0
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	D0,(10,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
	MOVEA.L	(-$1A,A5),A0
	CLR.B	(13,A0)
	MOVEA.L	(-$1A,A5),A1
	CLR.B	(12,A1)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#$FF,(9,A0)
	MOVE.B	#1,(lbB01193B-DT,A4)
	CLR.B	(lbB01193E-DT,A4)
lbC001A92	bra	lbC001C90

lbC001A96	CMPI.W	#14,(-$20,A5)
	BEQ.B	lbC001AAE
	CMPI.W	#$10,(-$20,A5)
	BEQ.B	lbC001AAE
	CMPI.W	#$17,(-$20,A5)
	BNE.B	lbC001AB2
lbC001AAE	bra	lbC001C90

lbC001AB2	BTST	#5,(lbB012110-DT,A4)
	BNE.B	lbC001AD2
	TST.W	(lbW0119D8-DT,A4)
	BNE.B	lbC001AD2
	MOVEA.L	(-$26,A5),A0
	MOVE.B	(A0),D0
	EXT.W	D0
	EXT.L	D0
	BTST	#7,D0
	bne	lbC001C16
lbC001AD2	MOVE.B	(lbB01231E-DT,A4),D0
	EXT.W	D0
	MOVE.W	D0,(-8,A5)
	MOVE.B	(lbB01231F-DT,A4),D0
	EXT.W	D0
	MOVE.W	D0,(-10,A5)
	CMPI.W	#$50,(lbW011992-DT,A4)
	BLS.B	lbC001B2C
	CMPI.W	#$18,(-$20,A5)
	BEQ.B	lbC001B08
	CMPI.W	#$51,(lbW011992-DT,A4)
	BNE.B	lbC001B08
	PEA	(15).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC001B08	CMPI.W	#$18,(-$20,A5)
	BEQ.B	lbC001B22
	CMPI.W	#$52,(lbW011992-DT,A4)
	BNE.B	lbC001B22
	PEA	($10).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC001B22	MOVE.W	#$18,(-$20,A5)
	bra	lbC001C14

lbC001B2C	CMPI.W	#11,(lbW01196A-DT,A4)
	bne	lbC001BD2
	TST.B	(lbB011936-DT,A4)
	BEQ.B	lbC001B4A
	PEA	($20).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC001BD0

lbC001B4A	CMPI.W	#$FFF1,(-8,A5)
	BLE.B	lbC001BC6
	CMPI.W	#15,(-8,A5)
	BGE.B	lbC001BC6
	CMPI.W	#$FFF1,(-10,A5)
	BLE.B	lbC001BC6
	CMPI.W	#15,(-10,A5)
	BGE.B	lbC001BC6
	MOVEQ	#0,D0
	MOVE.W	(lbW01230C-DT,A4),D0
	SUB.L	#14,D0
	MOVE.W	D0,(-$16,A5)
	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01230A-DT,A4),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE74-DT,A4)
	LEA	(12,SP),SP
	TST.L	D0
	BNE.B	lbC001BC4
	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVEA.L	D0,A0
	PEA	(10,A0)
	MOVEQ	#0,D1
	MOVE.W	(lbW01230A-DT,A4),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE74-DT,A4)
	LEA	(12,SP),SP
	TST.L	D0
	BNE.B	lbC001BC4
	CLR.W	(lbW01196A-DT,A4)
	MOVE.W	(-$16,A5),(lbW01230C-DT,A4)
lbC001BC4	BRA.B	lbC001BD0

lbC001BC6	PEA	($21).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC001BD0	BRA.B	lbC001C14

lbC001BD2	CMPI.W	#9,(lbW00EDEA-DT,A4)
	BGE.B	lbC001BE0
	MOVE.B	(lbB00EDEB-DT,A4),(lbB01231B-DT,A4)
lbC001BE0	CMPI.W	#12,(-$20,A5)
	BLT.B	lbC001C14
	CMPI.B	#4,(lbB012316-DT,A4)
	BNE.B	lbC001BF8
	MOVE.W	#$18,(-$20,A5)
	BRA.B	lbC001C14

lbC001BF8	CMPI.B	#5,(lbB012316-DT,A4)
	BNE.B	lbC001C10
	CMPI.W	#$18,(-$20,A5)
	BGE.B	lbC001C0E
	MOVE.W	#$18,(-$20,A5)
lbC001C0E	BRA.B	lbC001C14

lbC001C10	CLR.W	(-$20,A5)
lbC001C14	BRA.B	lbC001C90

lbC001C16	CMPI.W	#$18,(-$20,A5)
	BNE.B	lbC001C26
	MOVE.W	#$19,(-$20,A5)
	BRA.B	lbC001C90

lbC001C26	CMPI.W	#9,(lbW00EDEA-DT,A4)
	BGE.B	lbC001C8A
	CMPI.W	#$78,(lbW01197C-DT,A4)
	BLE.B	lbC001C6E
	JSR	(lbC00DDB4-DT,A4)
	TST.L	D0
	BNE.B	lbC001C6E
	JSR	(lbC00DDA2-DT,A4)
	BTST	#0,D0
	BEQ.B	lbC001C5C
	MOVE.W	(lbW00EDEA-DT,A4),D0
	EXT.L	D0
	ADDQ.L	#1,D0
	AND.L	#7,D0
	MOVE.W	D0,(lbW00EDEA-DT,A4)
	BRA.B	lbC001C6E

lbC001C5C	MOVE.W	(lbW00EDEA-DT,A4),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	AND.L	#7,D0
	MOVE.W	D0,(lbW00EDEA-DT,A4)
lbC001C6E	MOVE.B	(lbB00EDEB-DT,A4),(lbB01231B-DT,A4)
	BTST	#6,(lbB012110-DT,A4)
	BNE.B	lbC001C82
	TST.W	(lbW00EDEC-DT,A4)
	BEQ.B	lbC001C88
lbC001C82	MOVE.W	#12,(-$20,A5)
lbC001C88	BRA.B	lbC001C90

lbC001C8A	MOVE.W	#13,(-$20,A5)
lbC001C90	MOVE.B	(-$1F,A5),(lbB01231A-DT,A4)
	CLR.W	(lbW011970-DT,A4)
	CLR.W	(lbW011972-DT,A4)
	TST.W	(lbW011990-DT,A4)
	BEQ.B	lbC001CAC
	MOVE.W	#3,(lbW01196E-DT,A4)
	BRA.B	lbC001CB2

lbC001CAC	MOVE.W	#1,(lbW01196E-DT,A4)
lbC001CB2	MOVEQ	#0,D0
	MOVE.W	(lbW01230A-DT,A4),D0
	MOVE.W	(lbW01196E-DT,A4),D1
	MULS.W	#$16,D1
	LEA	(lbW01230A-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D1.L),D2
	SUB.L	D2,D0
	SUBQ.L	#4,D0
	MOVE.W	D0,(-12,A5)
	MOVEQ	#0,D0
	MOVE.W	(lbW01230C-DT,A4),D0
	MOVE.W	(lbW01196E-DT,A4),D1
	MULS.W	#$16,D1
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D1.L),D2
	SUB.L	D2,D0
	SUBQ.L	#4,D0
	MOVE.W	D0,(-14,A5)
	CMPI.W	#$10,(-12,A5)
	BGE.B	lbC001D18
	CMPI.W	#$FFF0,(-12,A5)
	BLE.B	lbC001D18
	CMPI.W	#$10,(-14,A5)
	BGE.B	lbC001D18
	CMPI.W	#$FFF0,(-14,A5)
	BLE.B	lbC001D18
	MOVE.W	#1,(lbW011972-DT,A4)
lbC001D18	CMPI.W	#9,(-12,A5)
	BGE.B	lbC001D3E
	CMPI.W	#$FFF7,(-12,A5)
	BLE.B	lbC001D3E
	CMPI.W	#9,(-14,A5)
	BGE.B	lbC001D3E
	CMPI.W	#$FFF7,(-14,A5)
	BLE.B	lbC001D3E
	MOVE.W	#2,(lbW011972-DT,A4)
lbC001D3E	CMPI.W	#11,(lbW01196A-DT,A4)
	BNE.B	lbC001D4C
	MOVE.B	#$FE,(lbB012317-DT,A4)
lbC001D4C	MOVEQ	#0,D4
	bra	lbC0032A4

lbC001D52	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$1A,A5)
	TST.W	(lbW01199A-DT,A4)
	BEQ.B	lbC001D70
	TST.L	D4
	bgt	lbC003188
lbC001D70	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(13,A0),(-$41,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($11,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$2E,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($10,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$32,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(10,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$34,A5)
	MOVE.W	(-$2E,A5),D0
	LEA	(lbL00EDEE-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	MOVE.W	D1,(-$20,A5)
	MOVE.W	(lbW01194E-DT,A4),D0
	MULS.W	#10,D0
	LEA	(lbL011DEE-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$40,A5)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#1,(8,A0)
	BNE.B	lbC001DDC
	CLR.W	(-2,A5)
	bra	lbC002EF2

lbC001DDC	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#6,(8,A0)
	BNE.B	lbC001E60
	CLR.W	(-$34,A5)
	CMPI.W	#14,(-$32,A5)
	BNE.B	lbC001DFC
	MOVE.W	#3,(-$34,A5)
	BRA.B	lbC001E58

lbC001DFC	CMPI.W	#15,(-$32,A5)
	BNE.B	lbC001E0C
	MOVE.W	#4,(-$34,A5)
	BRA.B	lbC001E58

lbC001E0C	JSR	(lbC00DDB4-DT,A4)
	TST.L	D0
	BNE.B	lbC001E58
	MOVEA.L	(-$40,A5),A0
	MOVE.B	#5,(6,A0)
	ADDQ.W	#1,(lbW01194E-DT,A4)
	JSR	(lbC00DDAE-DT,A4)
	ADDQ.L	#1,D0
	MOVE.W	D0,(-$34,A5)
	JSR	(lbC00DDC6-DT,A4)
	MOVEA.L	D0,A0
	PEA	($708,A0)
	PEA	(5).W
	JSR	(lbC00827A,PC)
	ADDQ.W	#8,SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#5,($11,A0)
	MOVEA.L	(-$40,A5),A0
	MOVE.B	#2,(4,A0)
	bra	lbC0029DC

lbC001E58	CLR.W	(-$34,A5)
	bra	lbC002CB6

lbC001E60	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#5,(8,A0)
	bne	lbC00216A
	CLR.W	(-2,A5)
	CLR.B	(-$41,A5)
	CMPI.W	#11,(lbW01198C-DT,A4)
	BNE.B	lbC001EE4
	TST.W	(lbW011972-DT,A4)
	BEQ.B	lbC001EC4
	CMPI.W	#3,(lbW01196E-DT,A4)
	BNE.B	lbC001EC4
	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	(5,A0)
	BEQ.B	lbC001EC4
	MOVE.B	(lbB01231B-DT,A4),D0
	EXT.W	D0
	MOVE.W	D0,(-$2E,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(lbW01230A-DT,A4),(A0)
	MOVE.W	(A0),(-$14,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(lbW01230C-DT,A4),(2,A0)
	MOVE.W	(2,A0),(-$16,A5)
	MOVE.W	#11,(lbW01196A-DT,A4)
	BRA.B	lbC001ED6

lbC001EC4	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(A0),(-$14,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(2,A0),(-$16,A5)
lbC001ED6	MOVE.W	(-$2E,A5),(-$34,A5)
	CLR.W	(-$30,A5)
	bra	lbC002146

lbC001EE4	TST.W	(lbW011972-DT,A4)
	BEQ.B	lbC001F3C
	CMPI.W	#3,(lbW01196E-DT,A4)
	BNE.B	lbC001F3C
	MOVE.B	(lbB01231B-DT,A4),D0
	EXT.W	D0
	MOVE.W	D0,(-$2E,A5)
	MOVE.W	(lbW01230A-DT,A4),(-$14,A5)
	MOVE.W	(lbW01230C-DT,A4),(-$16,A5)
	MOVE.W	#5,(lbW01196A-DT,A4)
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.W	(-$2E,A5),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-$34,A5)
	CMPI.B	#12,(lbB01231A-DT,A4)
	BNE.B	lbC001F38
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	AND.L	#1,D0
	ADD.W	D0,(-$34,A5)
lbC001F38	bra	lbC00210C

lbC001F3C	PEA	(3).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(A0),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$14,A5)
	PEA	(3).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(2,A0),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$16,A5)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#5,D0
	beq	lbC0020E8
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	ADDQ.L	#1,D0
	AND.L	#7,D0
	MOVE.W	D0,(-$2E,A5)
	PEA	(3).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(A0),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$14,A5)
	PEA	(3).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(2,A0),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$16,A5)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#5,D0
	beq	lbC0020E8
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	SUBQ.L	#2,D0
	AND.L	#7,D0
	MOVE.W	D0,(-$2E,A5)
	PEA	(3).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(A0),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$14,A5)
	PEA	(3).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(2,A0),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$16,A5)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#5,D0
	BEQ.B	lbC0020E8
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	AND.L	#7,D0
	MOVE.W	D0,(-$2E,A5)
	PEA	(3).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(A0),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$14,A5)
	PEA	(3).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(2,A0),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$16,A5)
lbC0020E8	CLR.W	(lbW01196A-DT,A4)
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	AND.L	#1,D0
	MOVE.W	(-$2E,A5),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	(-$2E,A5),D2
	EXT.L	D2
	ADD.L	D2,D0
	MOVE.W	D0,(-$34,A5)
lbC00210C	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	D0,(-2,A5)
	CMPI.W	#5,(-2,A5)
	BNE.B	lbC002140
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(-$14,A5),(A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(-$16,A5),(2,A0)
lbC002140	MOVE.W	#1,(-$30,A5)
lbC002146	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	MOVE.W	(-$30,A5),D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DF58-DT,A4)
	LEA	(12,SP),SP
	bra	lbC002EF2

lbC00216A	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#4,(8,A0)
	bne	lbC002254
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.B	(9,A0),D0
	AND.L	#$7F,D0
	MOVE.W	D0,(-2,A5)
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB00E129-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	MOVE.W	D1,(-$34,A5)
	CMPI.W	#14,(-$32,A5)
	BNE.B	lbC0021BE
	ADDQ.W	#2,(-$34,A5)
	CMPI.W	#9,(-2,A5)
	BNE.B	lbC0021BA
	ADDQ.W	#2,(-$34,A5)
lbC0021BA	bra	lbC002248

lbC0021BE	CMPI.W	#15,(-$32,A5)
	BNE.B	lbC0021D8
	ADDQ.W	#3,(-$34,A5)
	CMPI.W	#9,(-2,A5)
	BNE.B	lbC0021D6
	ADDQ.W	#2,(-$34,A5)
lbC0021D6	BRA.B	lbC002248

lbC0021D8	CMPI.W	#9,(-2,A5)
	BNE.B	lbC00221A
	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DE62-DT,A4)
	LEA	($10,SP),SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($11,A0),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#2,D1
	JSR	(__divs-DT,A4)
	MOVE.W	D0,(-$34,A5)
	MOVE.B	#1,(lbB011941-DT,A4)
	BRA.B	lbC002248

lbC00221A	CMPI.W	#$13,(-$32,A5)
	BNE.B	lbC002244
	JSR	(lbC00DDAE-DT,A4)
	ADD.W	D0,(-$34,A5)
	MOVEA.L	(-$1A,A5),A0
	SUBQ.B	#1,(15,A0)
	TST.B	(15,A0)
	BNE.B	lbC002242
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
lbC002242	BRA.B	lbC002248

lbC002244	bra	lbC003188

lbC002248	CLR.W	(-2,A5)
	CLR.B	(-$41,A5)
	bra	lbC002CB6

lbC002254	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#3,(8,A0)
	BNE.B	lbC0022CE
	CLR.W	(lbW01196A-DT,A4)
	CMPI.W	#1,(lbW01196E-DT,A4)
	bne	lbC003188
	CMPI.W	#2,(lbW011972-DT,A4)
	bne	lbC003188
	MOVE.W	(lbW01230A-DT,A4),(-$14,A5)
	MOVE.W	(lbW01230C-DT,A4),(-$16,A5)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	D0,(-2,A5)
	CMPI.W	#3,(-2,A5)
	blt	lbC003188
	CMPI.W	#5,(-2,A5)
	bgt	lbC003188
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(-$14,A5),(A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(-$16,A5),(2,A0)
	MOVE.W	#1,(lbW01196A-DT,A4)
	bra	lbC003188

lbC0022CE	CMPI.W	#$10,(-$32,A5)
	BNE.B	lbC0022EE
	MOVEA.L	(-$1A,A5),A0
	TST.W	($12,A0)
	BLE.B	lbC0022E6
	MOVE.W	#$53,(-$34,A5)
lbC0022E6	CLR.B	(lbB01193F-DT,A4)
	bra	lbC002C5C

lbC0022EE	CMPI.W	#12,(-$32,A5)
	bne	lbC0027D8
	CMPI.B	#$FE,(-$41,A5)
	bne	lbC002472
	CMPI.W	#11,(lbW01196A-DT,A4)
	BNE.B	lbC002312
	MOVE.W	#$28,(-$30,A5)
	BRA.B	lbC002318

lbC002312	MOVE.W	#$2A,(-$30,A5)
lbC002318	PEA	(2).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	PEA	($14).W
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($14,A0),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	SUB.L	#$14,D0
	MOVE.W	D0,(-$36,A5)
	MOVE.W	D0,(-$3A,A5)
	PEA	(2).W
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	PEA	($14).W
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($15,A0),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	SUB.L	#$14,D0
	MOVE.W	D0,(-$38,A5)
	MOVE.W	D0,(-$3C,A5)
	TST.W	(-$3A,A5)
	BGE.B	lbC002390
	MOVE.W	(-$36,A5),D0
	NEG.W	D0
	MOVE.W	D0,(-$3A,A5)
lbC002390	TST.W	(-$3C,A5)
	BGE.B	lbC0023A0
	MOVE.W	(-$38,A5),D0
	NEG.W	D0
	MOVE.W	D0,(-$3C,A5)
lbC0023A0	MOVE.W	(-$3A,A5),D0
	EXT.L	D0
	MOVE.W	(-$30,A5),D1
	EXT.L	D1
	SUBQ.L	#8,D1
	CMP.L	D1,D0
	BGE.B	lbC0023BC
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(-$35,A5),($14,A0)
lbC0023BC	MOVE.W	(-$3C,A5),D0
	CMP.W	(-$30,A5),D0
	BGE.B	lbC0023D0
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(-$37,A5),($15,A0)
lbC0023D0	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($14,A0),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	MOVEA.L	(-$1A,A5),A1
	MOVEQ	#0,D2
	MOVE.W	(A1),D2
	ADD.L	D2,D0
	MOVE.W	D0,(-$14,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($15,A0),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	MOVEA.L	(-$1A,A5),A1
	MOVEQ	#0,D2
	MOVE.W	(2,A1),D2
	ADD.L	D2,D0
	MOVE.W	D0,(-$16,A5)
	CMPI.W	#11,(lbW01196A-DT,A4)
	BNE.B	lbC00244E
	PEA	(6).W
	MOVE.W	(-$38,A5),D0
	NEG.W	D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$36,A5),D1
	NEG.W	D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	CLR.L	-(SP)
	JSR	(lbC00DE62-DT,A4)
	LEA	($10,SP),SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($11,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$2E,A5)
	bra	lbC00267C

lbC00244E	MOVE.L	D4,-(SP)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE74-DT,A4)
	LEA	(12,SP),SP
	TST.L	D0
	beq	lbC00267C
	CLR.B	(-$41,A5)
lbC002472	TST.L	D4
	BNE.B	lbC002486
	CMPI.W	#5,(lbW01196A-DT,A4)
	BNE.B	lbC002486
	MOVE.W	#3,(-$30,A5)
	BRA.B	lbC0024C4

lbC002486	CMPI.B	#$FD,(-$41,A5)
	BNE.B	lbC002496
	MOVE.W	#$FFFE,(-$30,A5)
	BRA.B	lbC0024C4

lbC002496	CMPI.B	#$FF,(-$41,A5)
	BNE.B	lbC0024A6
	MOVE.W	#4,(-$30,A5)
	BRA.B	lbC0024C4

lbC0024A6	CMPI.B	#2,(-$41,A5)
	BEQ.B	lbC0024B6
	CMPI.B	#6,(-$41,A5)
	BLE.B	lbC0024BE
lbC0024B6	MOVE.W	#1,(-$30,A5)
	BRA.B	lbC0024C4

lbC0024BE	MOVE.W	#2,(-$30,A5)
lbC0024C4	MOVE.W	(-$30,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$2E,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D2
	MOVE.W	(A0),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$14,A5)
	MOVE.W	(-$30,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$2E,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D2
	MOVE.W	(2,A0),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$16,A5)
	MOVE.L	D4,-(SP)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE74-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-2,A5)
	TST.L	D4
	BNE.B	lbC002570
	CMPI.W	#15,(-2,A5)
	BNE.B	lbC002558
	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC000BCC,PC)
	LEA	(12,SP),SP
	BRA.B	lbC00255C

lbC002558	CLR.B	(lbB011949-DT,A4)
lbC00255C	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	($1E,A0)
	BEQ.B	lbC002570
	CMPI.W	#12,(-2,A5)
	beq	lbC00267C
lbC002570	TST.W	(-2,A5)
	BNE.B	lbC00257A
	bra	lbC00267C

lbC00257A	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	ADDQ.L	#1,D0
	AND.L	#7,D0
	MOVE.W	D0,(-$2E,A5)
	MOVE.W	(-$30,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$2E,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D2
	MOVE.W	(A0),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$14,A5)
	MOVE.W	(-$30,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$2E,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D2
	MOVE.W	(2,A0),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$16,A5)
	MOVE.L	D4,-(SP)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE74-DT,A4)
	LEA	(12,SP),SP
	TST.L	D0
	BNE.B	lbC0025FC
	bra	lbC00267C

lbC0025FC	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	SUBQ.L	#2,D0
	AND.L	#7,D0
	MOVE.W	D0,(-$2E,A5)
	MOVE.W	(-$30,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$2E,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D2
	MOVE.W	(A0),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$14,A5)
	MOVE.W	(-$30,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$2E,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D2
	MOVE.W	(2,A0),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-$16,A5)
	MOVE.L	D4,-(SP)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE74-DT,A4)
	LEA	(12,SP),SP
	TST.L	D0
	bne	lbC0027E4
lbC00267C	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(-$2D,A5),($11,A0)
	MOVE.W	(-$2E,A5),D0
	LEA	(lbL00EDEE-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	MOVE.W	D1,(-$20,A5)
	MOVE.W	(-$20,A5),(-$34,A5)
	TST.W	(lbW01196A-DT,A4)
	BEQ.B	lbC0026A8
	TST.L	D4
	BEQ.B	lbC0026C6
lbC0026A8	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,(9,A0)
	BEQ.B	lbC0026C6
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	ADD.L	D4,D0
	AND.L	#7,D0
	ADD.W	D0,(-$34,A5)
lbC0026C6	CMPI.B	#$FE,(-$41,A5)
	beq	lbC002C5C
	CMPI.B	#$FD,(-$41,A5)
	BNE.B	lbC0026DE
	EORI.W	#7,(-$34,A5)
lbC0026DE	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	D0,(-2,A5)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,(9,A0)
	BEQ.B	lbC002710
	MOVEA.L	(-$1A,A5),A1
	CMPI.B	#4,(9,A1)
	BNE.B	lbC002714
lbC002710	CLR.W	(-2,A5)
lbC002714	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#4,(9,A0)
	BNE.B	lbC002746
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	AND.L	#$FE,D0
	ASL.L	#2,D0
	MOVE.W	(-$1C,A5),D1
	EXT.L	D1
	AND.L	#2,D1
	ADD.L	D1,D0
	ADD.L	#$24,D0
	MOVE.W	D0,(-$34,A5)
lbC002746	CMPI.B	#2,(-$41,A5)
	BLE.B	lbC002784
	TST.W	(-2,A5)
	BEQ.B	lbC002774
	CMPI.W	#3,(-2,A5)
	BNE.B	lbC002764
	CMPI.B	#5,(-$41,A5)
	BGT.B	lbC002774
lbC002764	CMPI.W	#4,(-2,A5)
	BNE.B	lbC002784
	CMPI.B	#10,(-$41,A5)
	BLE.B	lbC002784
lbC002774	CMPI.W	#$B5,(lbW011984-DT,A4)
	BEQ.B	lbC002780
	SUBQ.B	#1,(-$41,A5)
lbC002780	bra	lbC002EF2

lbC002784	MOVEQ	#0,D0
	MOVE.W	(-$14,A5),D0
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(A0),D1
	SUB.L	D1,D0
	EXT.L	D0
	ASL.L	#2,D0
	MOVEA.L	(-$1A,A5),A1
	MOVE.B	D0,($14,A1)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(2,A0),D1
	SUB.L	D1,D0
	EXT.L	D0
	ASL.L	#2,D0
	MOVEA.L	(-$1A,A5),A1
	MOVE.B	D0,($15,A1)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(-$14,A5),(A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(-$16,A5),(2,A0)
	CLR.B	(lbB01193F-DT,A4)
	bra	lbC002CB6

lbC0027D8	CMPI.W	#13,(-$32,A5)
	bne	lbC002862
	BRA.B	lbC002828

lbC0027E4	TST.L	D4
	BNE.B	lbC002820
	ADDQ.B	#1,(lbB01193F-DT,A4)
	CMPI.B	#$28,(lbB01193F-DT,A4)
	BLE.B	lbC0027FC
	MOVE.W	#$28,(-$34,A5)
	BRA.B	lbC00281C

lbC0027FC	CMPI.B	#$14,(lbB01193F-DT,A4)
	BLE.B	lbC00281C
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	ASR.L	#1,D0
	AND.L	#1,D0
	ADD.L	#$54,D0
	MOVE.W	D0,(-$34,A5)
lbC00281C	bra	lbC002C5C

lbC002820	MOVEA.L	(-$1A,A5),A0
	CLR.B	(15,A0)
lbC002828	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	ADDQ.L	#1,D0
	MOVE.W	D0,(-$34,A5)
	CMPI.B	#$FE,(-$41,A5)
	beq	lbC002C5C
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A1
	MOVEQ	#0,D1
	MOVE.W	(A1),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	D0,(-2,A5)
	bra	lbC002CB6

lbC002862	CMPI.W	#$18,(-$32,A5)
	blt	lbC002A76
	CMPI.B	#15,(-$41,A5)
	bgt	lbC002C5C
	CMPI.W	#$50,(lbW011992-DT,A4)
	BHI.W	lbC002C5C
	CMPI.W	#$19,(-$32,A5)
	bne	lbC00290E
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#5,(12,A0)
	BNE.B	lbC0028AC
	MOVE.W	(-$2E,A5),D0
	LEA	(lbW00EDF6-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	MOVE.W	D1,(-$34,A5)
	bra	lbC002C5C

lbC0028AC	MOVE.W	(-$2E,A5),D0
	LEA	(lbW00EDF6-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	#11,D1
	MOVE.W	D1,(-$34,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
	TST.L	D4
	BNE.B	lbC0028E8
	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	(8,A0)
	beq	lbC002C5C
	MOVEA.L	(lbL0119FC-DT,A4),A0
	SUBQ.B	#1,(8,A0)
lbC0028E8	MOVEA.L	(-$40,A5),A0
	MOVE.B	#3,(6,A0)
	ADDQ.W	#1,(lbW01194E-DT,A4)
	JSR	(lbC00DDC6-DT,A4)
	MOVEA.L	D0,A0
	PEA	($190,A0)
	PEA	(4).W
	JSR	(lbC00827A,PC)
	ADDQ.W	#8,SP
	bra	lbC0029CA

lbC00290E	CMPI.W	#$18,(-$32,A5)
	bne	lbC0029CA
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,(8,A0)
	BNE.B	lbC002940
	MOVE.W	(-$2E,A5),D0
	LEA	(lbW00EDF6-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	#11,D1
	MOVE.W	D1,(-$34,A5)
	BRA.B	lbC00295A

lbC002940	MOVE.W	(-$2E,A5),D0
	LEA	(lbW00EDF6-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	#10,D1
	MOVE.W	D1,(-$34,A5)
lbC00295A	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#5,(12,A0)
	BNE.B	lbC0029A6
	MOVEA.L	(-$40,A5),A0
	MOVE.B	#5,(6,A0)
	ADDQ.W	#1,(lbW01194E-DT,A4)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#$19,($10,A0)
	MOVE.W	(-$2E,A5),D0
	LEA	(lbW00EDF6-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	MOVE.W	D1,(-$34,A5)
	JSR	(lbC00DDC6-DT,A4)
	MOVEA.L	D0,A0
	PEA	($708,A0)
	PEA	(5).W
	JSR	(lbC00827A,PC)
	ADDQ.W	#8,SP
	BRA.B	lbC0029CA

lbC0029A6	TST.L	D4
	BNE.B	lbC0029C2
	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	(8,A0)
	BNE.B	lbC0029C2
	PEA	(NoArrows.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC002C5C

lbC0029C2	MOVEA.L	(-$40,A5),A0
	CLR.B	(6,A0)
lbC0029CA	MOVEA.L	(-$40,A5),A0
	MOVEA.L	(-$1A,A5),A1
	MOVE.B	(12,A1),D0
	SUBQ.B	#3,D0
	MOVE.B	D0,(4,A0)
lbC0029DC	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	MOVE.W	(-$2E,A5),D1
	LEA	(lbL010F52-DT,A4),A1
	MOVE.B	(A1,D1.W),D2
	EXT.W	D2
	EXT.L	D2
	ADD.L	D2,D0
	MOVEA.L	(-$40,A5),A6
	MOVE.W	D0,(A6)
	MOVEA.L	(-$1A,A5),A0
	MOVEA.L	(-$40,A5),A1
	MOVE.W	(2,A0),(2,A1)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#4,(12,A0)
	BNE.B	lbC002A2E
	MOVEA.L	(-$40,A5),A0
	MOVE.W	(-$2E,A5),D0
	LEA	(lbL010F5A-DT,A4),A1
	MOVE.B	(A1,D0.W),D1
	EXT.W	D1
	ADD.W	D1,(2,A0)
	BRA.B	lbC002A44

lbC002A2E	MOVEA.L	(-$40,A5),A0
	MOVE.W	(-$2E,A5),D0
	LEA	(lbL010F62-DT,A4),A1
	MOVE.B	(A1,D0.W),D1
	EXT.W	D1
	ADD.W	D1,(2,A0)
lbC002A44	MOVEA.L	(-$40,A5),A0
	CLR.B	(5,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVEA.L	(-$40,A5),A1
	MOVE.B	($11,A0),(7,A1)
	MOVEA.L	(-$40,A5),A0
	MOVE.B	D4,(8,A0)
	CMPI.W	#5,(lbW01194E-DT,A4)
	BLE.B	lbC002A6E
	CLR.W	(lbW01194E-DT,A4)
lbC002A6E	CLR.B	(lbB01193F-DT,A4)
	bra	lbC002C5C

lbC002A76	CMPI.W	#9,(-$32,A5)
	BGE.B	lbC002AF0
	MOVE.W	(-$2E,A5),D0
	LEA	(lbW00EDF6-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	MOVE.W	D1,(-$20,A5)
	MOVE.W	(-$32,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDB4-DT,A4)
	MOVE.L	(SP)+,D1
	ADD.L	D0,D1
	LEA	(lbL00E1A2-DT,A4),A0
	MOVEA.L	(-$1A,A5),A1
	MOVE.B	(A0,D1.L),D0
	MOVE.B	D0,($10,A1)
	EXT.W	D0
	MOVE.W	D0,(-$32,A5)
	CMP.L	#2,D4
	BLE.B	lbC002AC8
	CMPI.W	#6,(-$32,A5)
	BEQ.B	lbC002AD0
lbC002AC8	CMPI.W	#7,(-$32,A5)
	BNE.B	lbC002AD6
lbC002AD0	MOVE.W	#8,(-$32,A5)
lbC002AD6	MOVE.W	(-$32,A5),D0
	EXT.L	D0
	MOVE.W	(-$20,A5),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-$34,A5)
	CLR.B	(lbB01193F-DT,A4)
	bra	lbC002C5C

lbC002AF0	CMPI.W	#14,(-$32,A5)
	BNE.B	lbC002B62
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#4,(15,A0)
	BLE.B	lbC002B22
	TST.W	(-$2E,A5)
	BEQ.B	lbC002B12
	CMPI.W	#4,(-$2E,A5)
	BLE.B	lbC002B1A
lbC002B12	MOVE.W	#$50,(-$34,A5)
	BRA.B	lbC002B20

lbC002B1A	MOVE.W	#$51,(-$34,A5)
lbC002B20	BRA.B	lbC002B5A

lbC002B22	MOVEA.L	(-$1A,A5),A0
	TST.B	(15,A0)
	BLE.B	lbC002B4A
	TST.W	(-$2E,A5)
	BEQ.B	lbC002B3A
	CMPI.W	#4,(-$2E,A5)
	BLE.B	lbC002B42
lbC002B3A	MOVE.W	#$51,(-$34,A5)
	BRA.B	lbC002B48

lbC002B42	MOVE.W	#$50,(-$34,A5)
lbC002B48	BRA.B	lbC002B5A

lbC002B4A	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#15,($10,A0)
	MOVE.W	#$52,(-$34,A5)
lbC002B5A	CLR.B	(lbB01193F-DT,A4)
	bra	lbC002C5C

lbC002B62	CMPI.W	#15,(-$32,A5)
	BNE.B	lbC002B74
	MOVE.W	#$52,(-$34,A5)
	bra	lbC002C5C

lbC002B74	CMPI.W	#$14,(-$32,A5)
	BNE.B	lbC002B86
	MOVE.W	#$52,(-$34,A5)
	bra	lbC002C5C

lbC002B86	CMPI.W	#$11,(-$32,A5)
	BNE.B	lbC002BA8
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	AND.L	#1,D0
	ADD.L	#$54,D0
	MOVE.W	D0,(-$34,A5)
	bra	lbC002C5C

lbC002BA8	CMPI.W	#$12,(-$32,A5)
	BNE.B	lbC002BBA
	MOVE.W	#$54,(-$34,A5)
	bra	lbC002C5C

lbC002BBA	CMPI.W	#$17,(-$32,A5)
	BNE.B	lbC002BCC
	MOVE.W	#$56,(-$34,A5)
	bra	lbC002C5C

lbC002BCC	CMPI.W	#$16,(-$32,A5)
	bne	lbC002C5C
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$1E,(15,A0)
	BGE.B	lbC002C5C
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(15,A0),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#5,D1
	JSR	(__divs-DT,A4)
	MOVE.W	(lbW011980-DT,A4),D2
	MULS.W	#6,D2
	ADD.L	D2,D0
	MOVE.W	D0,(-2,A5)
	MOVE.W	(-2,A5),D0
	LEA	(lbL010EFA-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.W),D1
	MOVE.W	D1,(-$34,A5)
	MOVEA.L	(-$1A,A5),A0
	ADDQ.B	#1,(15,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($14,A0),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#3,D1
	JSR	(__mulu-DT,A4)
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	MOVEA.L	(-$1A,A5),A1
	MOVE.B	D0,($14,A1)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($15,A0),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#3,D1
	JSR	(__mulu-DT,A4)
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	MOVEA.L	(-$1A,A5),A1
	MOVE.B	D0,($15,A1)
lbC002C5C	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A1
	MOVEQ	#0,D1
	MOVE.W	(A1),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	D0,(-2,A5)
	CMPI.B	#$FE,(-$41,A5)
	BNE.B	lbC002CB6
	MOVEA.L	(-$1A,A5),A0
	MOVEA.L	(-$1A,A5),A1
	MOVE.B	($14,A1),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	ADD.W	D0,(A0)
	MOVEA.L	(-$1A,A5),A0
	MOVEA.L	(-$1A,A5),A1
	MOVE.B	($15,A1),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	ADD.W	D0,(2,A0)
lbC002CB6	CMPI.W	#14,(-$32,A5)
	BNE.B	lbC002D32
	MOVEA.L	(-$1A,A5),A0
	SUBQ.B	#1,(15,A0)
	TST.B	(15,A0)
	BNE.B	lbC002D32
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#15,($10,A0)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#9,(9,A0)
	BNE.B	lbC002D14
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#10,(9,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	#10,($12,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
	MOVEA.L	(-$1A,A5),A0
	CLR.B	(12,A0)
	PEA	($8B).W
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF3A-DT,A4)
	ADDQ.W	#8,SP
lbC002D14	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.B	(9,A0),D0
	CMP.L	#$89,D0
	BNE.B	lbC002D32
	PEA	($1B).W
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF3A-DT,A4)
	ADDQ.W	#8,SP
lbC002D32	TST.L	D4
	BNE.B	lbC002D44
	TST.W	(lbW011972-DT,A4)
	BEQ.B	lbC002D44
	CLR.B	(-$41,A5)
	bra	lbC002EDA

lbC002D44	TST.W	(-2,A5)
	BNE.B	lbC002D52
	CLR.B	(-$41,A5)
	bra	lbC002EDA

lbC002D52	CMPI.W	#6,(-2,A5)
	BNE.B	lbC002D64
	MOVE.B	#$FF,(-$41,A5)
	bra	lbC002EDA

lbC002D64	CMPI.W	#7,(-2,A5)
	BNE.B	lbC002D76
	MOVE.B	#$FE,(-$41,A5)
	bra	lbC002EDA

lbC002D76	CMPI.W	#8,(-2,A5)
	BNE.B	lbC002D88
	MOVE.B	#$FD,(-$41,A5)
	bra	lbC002EDA

lbC002D88	CMPI.W	#9,(-2,A5)
	BNE.B	lbC002DE8
	TST.L	D4
	BNE.B	lbC002DE8
	CMPI.W	#$34,(lbW011992-DT,A4)
	BNE.B	lbC002DE8
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$16,($10,A0)
	BEQ.B	lbC002DDE
	MOVE.W	(lbW011980-DT,A4),D0
	MULS.W	#6,D0
	LEA	(lbL010EFA-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.W	D1,(-$34,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#$16,($10,A0)
	MOVEA.L	(-$1A,A5),A0
	CLR.B	(15,A0)
	SUBQ.W	#2,(lbW011976-DT,A4)
	PEA	(1).W
	JSR	(lbC00643C,PC)
	ADDQ.W	#4,SP
lbC002DDE	MOVE.B	#$FE,(-$41,A5)
	bra	lbC002EDA

lbC002DE8	CMPI.W	#2,(-2,A5)
	BNE.B	lbC002DFA
	MOVE.B	#2,(-$41,A5)
	bra	lbC002EDA

lbC002DFA	CMPI.W	#3,(-2,A5)
	BNE.B	lbC002E0C
	MOVE.B	#5,(-$41,A5)
	bra	lbC002EDA

lbC002E0C	CMPI.W	#4,(-2,A5)
	BEQ.B	lbC002E1E
	CMPI.W	#5,(-2,A5)
	bne	lbC002EDA
lbC002E1E	CMPI.W	#4,(-2,A5)
	BNE.B	lbC002E2E
	MOVE.W	#10,(-$30,A5)
	BRA.B	lbC002E34

lbC002E2E	MOVE.W	#$1E,(-$30,A5)
lbC002E34	MOVE.B	(-$41,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	(-$30,A5),D1
	EXT.L	D1
	CMP.L	D1,D0
	BLE.B	lbC002E4E
	SUBQ.B	#1,(-$41,A5)
	bra	lbC002EDA

lbC002E4E	MOVE.B	(-$41,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	(-$30,A5),D1
	EXT.L	D1
	CMP.L	D1,D0
	BGE.B	lbC002EDA
	ADDQ.B	#1,(-$41,A5)
	CMPI.W	#14,(-$32,A5)
	BEQ.B	lbC002E74
	CMPI.W	#15,(-$32,A5)
	BNE.B	lbC002E76
lbC002E74	BRA.B	lbC002EDA

lbC002E76	CMPI.B	#$1E,(-$41,A5)
	BNE.B	lbC002EC8
	CMPI.W	#$B5,(lbW011984-DT,A4)
	BNE.B	lbC002EBC
	TST.L	D4
	BNE.B	lbC002EB4
	CLR.B	(-$41,A5)
	MOVE.W	#9,(lbW0119C6-DT,A4)
	CLR.L	-(SP)
	PEA	($8886).L
	PEA	($1080).W
	JSR	(lbC005778,PC)
	LEA	(12,SP),SP
	PEA	(1).W
	JSR	(lbC00585C,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC002EBC

lbC002EB4	MOVEA.L	(-$1A,A5),A0
	CLR.W	($12,A0)
lbC002EBC	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
	BRA.B	lbC002EDA

lbC002EC8	CMPI.B	#15,(-$41,A5)
	BLE.B	lbC002EDA
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#$10,($10,A0)
lbC002EDA	TST.B	(-$41,A5)
	BNE.B	lbC002EF2
	CMPI.W	#$10,(-$32,A5)
	BNE.B	lbC002EF2
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
lbC002EF2	CMPI.W	#10,(lbW0119C6-DT,A4)
	BCS.B	lbC002F04
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(-$41,A5),(13,A0)
lbC002F04	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(9,A0),(-$41,A5)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,(8,A0)
	bne	lbC003036
	CMPI.B	#4,(-$41,A5)
	BNE.B	lbC002F56
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#12,($10,A0)
	BGE.B	lbC002F56
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	AND.L	#1,D0
	MOVE.W	(-$2E,A5),D1
	LEA	(lbL00EDEE-DT,A4),A0
	MOVE.B	(A0,D1.W),D2
	EXT.W	D2
	EXT.L	D2
	ADD.L	D2,D0
	MOVE.W	D0,(-$34,A5)
	bra	lbC003036

lbC002F56	CMPI.B	#4,(-$41,A5)
	BNE.B	lbC002F96
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#14,($10,A0)
	BGE.B	lbC002F96
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	MOVEQ	#2,D1
	JSR	(__divs-DT,A4)
	AND.L	#1,D0
	MOVE.W	(-$2E,A5),D2
	LEA	(lbL00EDEE-DT,A4),A0
	MOVE.B	(A0,D2.W),D3
	EXT.W	D3
	EXT.L	D3
	ADD.L	D3,D0
	MOVE.W	D0,(-$34,A5)
	bra	lbC003036

lbC002F96	CMPI.B	#8,(-$41,A5)
	BNE.B	lbC003014
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#15,($10,A0)
	BNE.B	lbC002FB2
	MOVEA.L	(-$1A,A5),A0
	CLR.W	(A0)
	BRA.B	lbC003012

lbC002FB2	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#14,($10,A0)
	BNE.B	lbC002FC6
	MOVE.W	#$3F,(-$34,A5)
	BRA.B	lbC003012

lbC002FC6	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	AND.L	#3,D0
	ASL.L	#1,D0
	MOVE.W	D0,(-$34,A5)
	CMPI.W	#4,(-$34,A5)
	BLE.B	lbC002FE4
	SUBQ.W	#1,(-$34,A5)
lbC002FE4	MOVEQ	#3,D1
	MOVE.L	D4,D0
	JSR	(__mods-DT,A4)
	BRA.B	lbC003006

lbC002FEE	MOVE.W	#$25,(-$34,A5)
	BRA.B	lbC003012

lbC002FF6	ADDI.W	#$28,(-$34,A5)
	BRA.B	lbC003012

lbC002FFE	ADDI.W	#$30,(-$34,A5)
	BRA.B	lbC003012

lbC003006	TST.L	D0
	BEQ.B	lbC002FEE
	SUBQ.L	#1,D0
	BEQ.B	lbC002FF6
	SUBQ.L	#1,D0
	BEQ.B	lbC002FFE
lbC003012	BRA.B	lbC003036

lbC003014	CMPI.B	#7,(-$41,A5)
	BNE.B	lbC003036
	MOVEA.L	(-$1A,A5),A0
	TST.W	($12,A0)
	BNE.B	lbC003036
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#13,($10,A0)
	MOVE.W	#1,(-$34,A5)
lbC003036	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(-$33,A5),(10,A0)
	TST.L	D4
	bne	lbC0030EE
	CMPI.W	#8,(lbW00ED02-DT,A4)
	BCC.B	lbC0030C2
	MOVEA.L	(-$1A,A5),A0
	CMPI.W	#$12C,(A0)
	BCC.B	lbC003062
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	#$7F35,(A0)
	BRA.B	lbC0030A8

lbC003062	MOVEA.L	(-$1A,A5),A0
	CMPI.W	#$7F35,(A0)
	BLS.B	lbC003076
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	#$12C,(A0)
	BRA.B	lbC0030A8

lbC003076	MOVEA.L	(-$1A,A5),A0
	CMPI.W	#$12C,(2,A0)
	BCC.B	lbC00308E
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	#$7F35,(2,A0)
	BRA.B	lbC0030A8

lbC00308E	MOVEA.L	(-$1A,A5),A0
	CMPI.W	#$7F35,(2,A0)
	BLS.B	lbC0030A6
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	#$12C,(2,A0)
	BRA.B	lbC0030A8

lbC0030A6	BRA.B	lbC0030C2

lbC0030A8	CMPI.W	#1,(lbW01196A-DT,A4)
	BLE.B	lbC0030C2
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(A0),(lbW01234C-DT,A4)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(2,A0),(lbW01234E-DT,A4)
lbC0030C2	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(2,A0),(lbW01195C-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$1A,A5),A1
	MOVE.W	(A1),(lbW01195A-DT,A4)
	MOVEQ	#0,D1
	MOVE.W	(A1),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE26-DT,A4)
	ADDQ.W	#8,SP
	MOVE.B	(-1,A5),(lbB01193D-DT,A4)
lbC0030EE	MOVEA.L	(-$1A,A5),A0
	TST.W	($12,A0)
	beq	lbC003188
	TST.B	(lbB011936-DT,A4)
	BEQ.B	lbC00314E
	TST.L	D4
	BNE.B	lbC003118
	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	($17,A0)
	BEQ.B	lbC003118
	MOVEA.L	(-$1A,A5),A0
	CLR.B	(13,A0)
	BRA.B	lbC003142

lbC003118	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#15,(13,A0)
	BLE.B	lbC00312E
	MOVEA.L	(-$1A,A5),A0
	CLR.W	($12,A0)
	BRA.B	lbC003142

lbC00312E	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,(13,A0)
	BLE.B	lbC003142
	MOVEA.L	(-$1A,A5),A0
	SUBQ.W	#1,($12,A0)
lbC003142	PEA	($1B).W
	MOVE.L	D4,-(SP)
	JSR	(lbC005DF0,PC)
	ADDQ.W	#8,SP
lbC00314E	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$1E,(13,A0)
	BNE.B	lbC003188
	MOVE.W	(-$1C,A5),D0
	AND.W	#7,D0
	BNE.B	lbC003188
	CMPI.B	#2,(-$41,A5)
	BEQ.B	lbC003188
	CMPI.B	#3,(-$41,A5)
	BEQ.B	lbC003188
	MOVEA.L	(-$1A,A5),A0
	SUBQ.W	#1,($12,A0)
	PEA	(6).W
	MOVE.L	D4,-(SP)
	JSR	(lbC005DF0,PC)
	ADDQ.W	#8,SP
lbC003188	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#5,(8,A0)
	BNE.B	lbC0031EA
	CMPI.W	#11,(lbW01196A-DT,A4)
	BNE.B	lbC0031EA
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	MOVEA.L	D0,A1
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	SUBA.L	D1,A1
	PEA	(-$20,A1)
	JSR	(lbC00DE20-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	D0,(4,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVEA.L	D0,A1
	MOVEQ	#0,D1
	MOVE.W	(lbW011958-DT,A4),D1
	SUBA.L	D1,A1
	PEA	(-$28,A1)
	JSR	(lbC00DE20-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	D0,(6,A0)
	bra	lbC0032A2

lbC0031EA	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#3,(8,A0)
	BEQ.B	lbC00320E
	MOVEA.L	(-$1A,A5),A1
	CMPI.B	#5,(8,A1)
	BEQ.B	lbC00320E
	MOVEA.L	(-$1A,A5),A6
	CMPI.B	#6,(8,A6)
	BNE.B	lbC00325A
lbC00320E	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	MOVEA.L	D0,A1
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	SUBA.L	D1,A1
	PEA	(-$10,A1)
	JSR	(lbC00DE20-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	D0,(4,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVEA.L	D0,A1
	MOVEQ	#0,D1
	MOVE.W	(lbW011958-DT,A4),D1
	SUBA.L	D1,A1
	PEA	(-$10,A1)
	JSR	(lbC00DE20-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	D0,(6,A0)
	BRA.B	lbC0032A2

lbC00325A	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	SUB.L	D1,D0
	SUBQ.L	#8,D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DE20-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	D0,(4,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVEA.L	D0,A1
	MOVEQ	#0,D1
	MOVE.W	(lbW011958-DT,A4),D1
	SUBA.L	D1,A1
	PEA	(-$1A,A1)
	JSR	(lbC00DE20-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	D0,(6,A0)
lbC0032A2	ADDQ.L	#1,D4
lbC0032A4	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D4
	blt	lbC001D52
	CMPI.B	#13,(lbB01231A-DT,A4)
	BEQ.B	lbC0032BC
	CLR.W	(lbW0119B8-DT,A4)
lbC0032BC	MOVE.W	(lbW01230A-DT,A4),(lbW01195A-DT,A4)
	MOVE.W	(lbW01230C-DT,A4),(lbW01195C-DT,A4)
	CMPI.W	#8,(lbW00ED02-DT,A4)
	bne	lbC003356
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	LSR.L	#5,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	LSR.L	#4,D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE08-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A0
	MOVEQ	#0,D0
	MOVE.B	(A0),D0
	MOVE.L	D0,D4
	CMP.L	#$A1,D4
	BEQ.B	lbC003314
	CMP.L	#$34,D4
	BEQ.B	lbC003314
	CMP.L	#$A2,D4
	BEQ.B	lbC003314
	CMP.L	#$35,D4
	BNE.B	lbC003352
lbC003314	ADDQ.W	#1,(lbW0119B8-DT,A4)
	CMPI.W	#$1E,(lbW0119B8-DT,A4)
	BNE.B	lbC003350
	CMPI.W	#$32,(lbW01197E-DT,A4)
	BGE.B	lbC003334
	PEA	($19).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC003350

lbC003334	PEA	($1A).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	ORI.W	#$1F,(lbW01230C-DT,A4)
	MOVE.W	(lbW01230C-DT,A4),(lbW01195C-DT,A4)
	MOVE.B	#$17,(lbB01231A-DT,A4)
lbC003350	BRA.B	lbC003356

lbC003352	CLR.W	(lbW0119B8-DT,A4)
lbC003356	MOVEQ	#0,D4
	MOVE.W	#$55,(-4,A5)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	AND.L	#$FFF0,D0
	MOVE.W	D0,(-$14,A5)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	AND.L	#$FFE0,D0
	MOVE.W	D0,(-$16,A5)
	TST.W	(lbW01196A-DT,A4)
	bne	lbC0036F0
	CMPI.W	#8,(lbW00ED02-DT,A4)
	BCC.W	lbC0035A2
lbC003390	MOVE.W	(-4,A5),D0
	EXT.L	D0
	CMP.L	D4,D0
	blt	lbC00359E
	MOVE.W	(-4,A5),D0
	EXT.L	D0
	ADD.L	D4,D0
	MOVEQ	#2,D1
	JSR	(__divs-DT,A4)
	MOVE.W	D0,(-2,A5)
	MOVE.W	(-2,A5),D0
	MULS.W	#10,D0
	LEA	(lbL00E322-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$30,A5)
	MOVEA.L	(-$30,A5),A0
	MOVE.W	(A0),D0
	CMP.W	(-$14,A5),D0
	BLS.B	lbC0033DC
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	MOVE.W	D0,(-4,A5)
	bra	lbC00358C

lbC0033DC	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	ADD.L	#$10,D0
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	CMP.L	D1,D0
	BCC.B	lbC003402
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	MOVE.L	D0,D4
	ADDQ.L	#1,D4
	bra	lbC00358C

lbC003402	MOVEA.L	(-$30,A5),A0
	MOVE.W	(A0),D0
	CMP.W	(-$14,A5),D0
	BCC.B	lbC003428
	MOVEA.L	(-$30,A5),A1
	BTST	#0,(8,A1)
	BNE.B	lbC003428
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	MOVE.L	D0,D4
	ADDQ.L	#1,D4
	bra	lbC00358C

lbC003428	MOVEA.L	(-$30,A5),A0
	MOVE.W	(2,A0),D0
	CMP.W	(-$16,A5),D0
	BLS.B	lbC003446
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	MOVE.W	D0,(-4,A5)
	bra	lbC00358C

lbC003446	MOVEA.L	(-$30,A5),A0
	MOVE.W	(2,A0),D0
	CMP.W	(-$16,A5),D0
	BCC.B	lbC003462
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	MOVE.L	D0,D4
	ADDQ.L	#1,D4
	bra	lbC00358C

lbC003462	MOVEA.L	(-$30,A5),A0
	BTST	#0,(8,A0)
	BEQ.B	lbC00347A
	BTST	#4,(lbB01195D-DT,A4)
	bne	lbC00358A
	BRA.B	lbC003490

lbC00347A	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	AND.L	#15,D0
	CMP.L	#6,D0
	BHI.W	lbC00358A
lbC003490	MOVEA.L	(-$30,A5),A0
	CMPI.B	#$11,(8,A0)
	BNE.B	lbC0034AA
	MOVEA.L	(lbL0119FC-DT,A4),A1
	CMPI.B	#5,($19,A1)
	BCS.W	lbC00359E
lbC0034AA	MOVEA.L	(-$30,A5),A0
	CMPI.B	#$12,(8,A0)
	BNE.B	lbC0034E0
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(4,A0),D0
	ADD.L	#$18,D0
	MOVE.W	D0,(-$14,A5)
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(6,A0),D0
	ADD.L	#$10,D0
	MOVE.W	D0,(-$16,A5)
	BRA.B	lbC003530

lbC0034E0	MOVEA.L	(-$30,A5),A0
	BTST	#0,(8,A0)
	BEQ.B	lbC00350C
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(4,A0),D0
	ADD.L	#$10,D0
	MOVE.W	D0,(-$14,A5)
	MOVEA.L	(-$30,A5),A0
	MOVE.W	(6,A0),(-$16,A5)
	BRA.B	lbC003530

lbC00350C	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(4,A0),D0
	SUBQ.L	#1,D0
	MOVE.W	D0,(-$14,A5)
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(6,A0),D0
	ADD.L	#$10,D0
	MOVE.W	D0,(-$16,A5)
lbC003530	MOVEA.L	(-$30,A5),A0
	CMPI.B	#1,(9,A0)
	BNE.B	lbC003544
	MOVE.W	#8,(lbW0119C6-DT,A4)
	BRA.B	lbC00354A

lbC003544	MOVE.W	#9,(lbW0119C6-DT,A4)
lbC00354A	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC005778,PC)
	LEA	(12,SP),SP
	PEA	(2).W
	JSR	(lbC00585C,PC)
	ADDQ.W	#4,SP
	PEA	(lbL010D8E-DT,A4)
	PEA	(1).W
	PEA	($64).W
	PEA	($64).W
	PEA	($64).W
	JSR	(lbC00DE86-DT,A4)
	LEA	($14,SP),SP
lbC00358A	BRA.B	lbC00359E

lbC00358C	CMP.L	#$56,D4
	BGE.B	lbC00359E
	TST.W	(-4,A5)
	BLT.B	lbC00359E
	bra	lbC003390

lbC00359E	bra	lbC0036F0

lbC0035A2	CLR.W	(-2,A5)
	bra	lbC0036E6

lbC0035AA	MOVE.W	(-2,A5),D0
	MULS.W	#10,D0
	LEA	(lbL00E322-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$30,A5)
	MOVEA.L	(-$30,A5),A0
	MOVE.W	(6,A0),D0
	CMP.W	(-$16,A5),D0
	bne	lbC0036E2
	MOVEA.L	(-$30,A5),A1
	MOVE.W	(4,A1),D1
	CMP.W	(-$14,A5),D1
	BEQ.B	lbC003604
	MOVEQ	#0,D2
	MOVE.W	(-$14,A5),D2
	SUB.L	#$10,D2
	MOVEA.L	(-$30,A5),A6
	MOVEQ	#0,D3
	MOVE.W	(4,A6),D3
	CMP.L	D3,D2
	bne	lbC0036E2
	MOVEA.L	(-$30,A5),A6
	BTST	#0,(8,A6)
	beq	lbC0036E2
lbC003604	MOVEA.L	(-$30,A5),A0
	BTST	#0,(8,A0)
	BEQ.B	lbC00361C
	BTST	#4,(lbB01195D-DT,A4)
	beq	lbC0036E0
	BRA.B	lbC003632

lbC00361C	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	AND.L	#15,D0
	CMP.L	#2,D0
	BCS.W	lbC0036E0
lbC003632	MOVEA.L	(-$30,A5),A0
	CMPI.B	#$12,(8,A0)
	BNE.B	lbC003662
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	SUBQ.L	#4,D0
	MOVE.W	D0,(-$14,A5)
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	ADD.L	#$10,D0
	MOVE.W	D0,(-$16,A5)
	BRA.B	lbC0036BC

lbC003662	MOVEA.L	(-$30,A5),A0
	BTST	#0,(8,A0)
	BEQ.B	lbC003696
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	ADD.L	#$10,D0
	MOVE.W	D0,(-$14,A5)
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	ADD.L	#$22,D0
	MOVE.W	D0,(-$16,A5)
	BRA.B	lbC0036BC

lbC003696	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	ADD.L	#$14,D0
	MOVE.W	D0,(-$14,A5)
	MOVEA.L	(-$30,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	ADD.L	#$10,D0
	MOVE.W	D0,(-$16,A5)
lbC0036BC	PEA	(1).W
	MOVEQ	#0,D0
	MOVE.W	(-$16,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-$14,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC005778,PC)
	LEA	(12,SP),SP
	CLR.L	-(SP)
	JSR	(lbC00585C,PC)
	ADDQ.W	#4,SP
lbC0036E0	BRA.B	lbC0036F0

lbC0036E2	ADDQ.W	#1,(-2,A5)
lbC0036E6	CMPI.W	#$56,(-2,A5)
	blt	lbC0035AA
lbC0036F0	MOVE.W	(lbW01230A-DT,A4),(lbW01195A-DT,A4)
	MOVE.W	(lbW01230C-DT,A4),(lbW01195C-DT,A4)
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(lbL011A1C-DT,A4)
	MOVE.L	(lbL011A1C-DT,A4),D0
	ADDQ.L	#8,D0
	MOVE.L	D0,(lbL011A98-DT,A4)
	JSR	(_OwnBlitter-DT,A4)
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.W	($10,A0),D0
	EXT.L	D0
	MOVE.L	D0,D4
	BRA.B	lbC003748

lbC003724	MOVE.L	D4,D0
	SUBQ.L	#1,D0
	MOVEQ	#12,D1
	JSR	(__mulu-DT,A4)
	MOVEA.L	(lbL011A04-DT,A4),A0
	ADD.L	($12,A0),D0
	MOVE.L	D0,(lbL011A00-DT,A4)
	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.L	(A0),-(SP)
	JSR	(_do_blit-DT,A4)
	ADDQ.W	#4,SP
	SUBQ.L	#1,D4
lbC003748	TST.L	D4
	BGT.B	lbC003724
	JSR	(_DisownBlitter-DT,A4)
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(rp1_bitmap_ptr-DT,A4)
	MOVEA.L	(lbL011A04-DT,A4),A0
	TST.W	($24,A0)
	BEQ.B	lbC003770
	MOVE.L	(lbL011A04-DT,A4),-(SP)
	JSR	(lbC00DF2E-DT,A4)
	ADDQ.W	#4,SP
lbC003770	MOVEQ	#0,D0
	MOVE.W	(lbW011956-DT,A4),D0
	LSR.L	#4,D0
	MOVE.W	D0,(lbW011964-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW011958-DT,A4),D0
	LSR.L	#5,D0
	MOVE.W	D0,(lbW011966-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW011964-DT,A4),D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	SUB.L	(8,A0),D0
	MOVE.W	D0,(-8,A5)
	MOVEQ	#0,D0
	MOVE.W	(lbW011966-DT,A4),D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	SUB.L	(12,A0),D0
	MOVE.W	D0,(-10,A5)
	BTST	#1,(-8,A5)
	BEQ.B	lbC0037BC
	ORI.W	#$FC00,(-8,A5)
	BRA.B	lbC0037C2

lbC0037BC	ANDI.W	#$3FF,(-8,A5)
lbC0037C2	CMPI.W	#10,(lbW0119C6-DT,A4)
	BCC.B	lbC0037CE
	JSR	(_check_for_trackdisk_and_read_tracks-DT,A4)
lbC0037CE	CMPI.B	#$63,(lbB011939-DT,A4)
	BEQ.B	lbC0037E6
	CMPI.B	#$62,(lbB011939-DT,A4)
	BEQ.B	lbC0037E6
	CMPI.B	#3,(lbB011939-DT,A4)
	BNE.B	lbC003816
lbC0037E6	JSR	(lbC006544,PC)
	JSR	(lbC00DDEA-DT,A4)
	CLR.W	(-10,A5)
	CLR.W	(-8,A5)
	CMPI.B	#$63,(lbB011939-DT,A4)
	BNE.B	lbC003806
	MOVE.B	#$62,(lbB011939-DT,A4)
	BRA.B	lbC003812

lbC003806	CMPI.B	#$62,(lbB011939-DT,A4)
	BNE.B	lbC003812
	CLR.B	(lbB011939-DT,A4)
lbC003812	bra	lbC0038B8

lbC003816	TST.W	(-8,A5)
	BNE.B	lbC003822
	TST.W	(-10,A5)
	BEQ.B	lbC003826
lbC003822	JSR	(lbC006544,PC)
lbC003826	CMPI.W	#1,(-8,A5)
	BNE.B	lbC003878
	CMPI.W	#1,(-10,A5)
	BNE.B	lbC003842
	PEA	(5).W
	JSR	(_do_blit_1-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC003874

lbC003842	TST.W	(-10,A5)
	BNE.B	lbC003854
	PEA	(4).W
	JSR	(_do_blit_1-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC003874

lbC003854	CMPI.W	#$FFFF,(-10,A5)
	BNE.B	lbC003868
	PEA	(3).W
	JSR	(_do_blit_1-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC003874

lbC003868	CLR.W	(-10,A5)
	CLR.W	(-8,A5)
	JSR	(lbC00DDEA-DT,A4)
lbC003874	bra	lbC00429A

lbC003878	TST.W	(-8,A5)
	bne	lbC004240
	CMPI.W	#1,(-10,A5)
	BNE.B	lbC003896
	PEA	(6).W
	JSR	(_do_blit_1-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC00423E

lbC003896	CMPI.W	#$FFFF,(-10,A5)
	BNE.B	lbC0038AC
	PEA	(2).W
	JSR	(_do_blit_1-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC00423E

lbC0038AC	TST.W	(-10,A5)
	bne	lbC004232
	JSR	(lbC00DE92-DT,A4)
lbC0038B8	CMPI.B	#$17,(lbB01231A-DT,A4)
	BNE.B	lbC00390E
	ADDI.W	#$3F,(lbW011988-DT,A4)
	TST.W	(lbW01197E-DT,A4)
	BEQ.B	lbC0038D0
	SUBQ.W	#1,(lbW01197E-DT,A4)
lbC0038D0	TST.W	(lbW01197E-DT,A4)
	BEQ.B	lbC0038FC
	CMPI.W	#$1E,(lbW01197E-DT,A4)
	BGE.B	lbC0038EE
	CMPI.W	#$2328,(lbW011988-DT,A4)
	BLS.B	lbC0038EE
	CMPI.W	#$2710,(lbW011988-DT,A4)
	BCS.B	lbC0038FC
lbC0038EE	TST.B	(lbB01193E-DT,A4)
	BEQ.B	lbC00390E
	JSR	(lbC00DDC0-DT,A4)
	TST.L	D0
	BNE.B	lbC00390E
lbC0038FC	MOVE.B	#13,(lbB01231A-DT,A4)
	ANDI.W	#$FFE0,(lbW01230C-DT,A4)
	MOVE.W	(lbW01230C-DT,A4),(lbW01195C-DT,A4)
lbC00390E	TST.W	(lbW01199A-DT,A4)
	BNE.B	lbC003926
	MOVE.W	(lbW011988-DT,A4),D0
	ADDQ.W	#1,(lbW011988-DT,A4)
	CMP.W	#$5DC0,D0
	BCS.B	lbC003926
	CLR.W	(lbW011988-DT,A4)
lbC003926	MOVE.W	(lbW011988-DT,A4),D0
	SWAP	D0
	CLR.W	D0
	SWAP	D0
	DIVU.W	#$28,D0
	MOVE.W	D0,(lbW01198A-DT,A4)
	CMPI.W	#$12C,(lbW01198A-DT,A4)
	BCS.B	lbC003952
	MOVEQ	#0,D0
	MOVE.W	(lbW01198A-DT,A4),D0
	MOVE.L	#$258,D1
	SUB.L	D0,D1
	MOVE.W	D1,(lbW01198A-DT,A4)
lbC003952	CMPI.W	#$28,(lbW01198A-DT,A4)
	BCC.B	lbC003962
	MOVE.B	#3,(lbB0110DD-DT,A4)
	BRA.B	lbC003968

lbC003962	MOVE.B	#2,(lbB0110DD-DT,A4)
lbC003968	MOVEQ	#0,D0
	MOVE.W	(lbW011988-DT,A4),D0
	MOVE.L	#$7D0,D1
	JSR	(__divu-DT,A4)
	MOVE.L	D0,D4
	MOVE.W	(lbW0119B6-DT,A4),D0
	EXT.L	D0
	CMP.L	D4,D0
	BEQ.B	lbC0039CE
	MOVE.W	D4,D0
	MOVE.W	D0,(lbW0119B6-DT,A4)
	EXT.L	D0
	BRA.B	lbC0039BE

lbC00398E	PEA	($1C).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0039CE

lbC00399A	PEA	($1D).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0039CE

lbC0039A6	PEA	($1E).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0039CE

lbC0039B2	PEA	($1F).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0039CE

lbC0039BE	TST.L	D0
	BEQ.B	lbC00398E
	SUBQ.L	#4,D0
	BEQ.B	lbC00399A
	SUBQ.L	#2,D0
	BEQ.B	lbC0039A6
	SUBQ.L	#3,D0
	BEQ.B	lbC0039B2
lbC0039CE	JSR	(lbC00DF70-DT,A4)
	MOVE.W	(lbW011988-DT,A4),D0
	AND.W	#$3FF,D0
	BNE.B	lbC003A12
	MOVE.W	(lbW01231C-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(lbW011974-DT,A4),D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	ADD.L	#15,D0
	MOVE.L	(SP)+,D2
	CMP.L	D0,D2
	BGE.B	lbC003A12
	CMPI.B	#15,(lbB01231A-DT,A4)
	BEQ.B	lbC003A12
	ADDQ.W	#1,(lbW01231C-DT,A4)
	PEA	(4).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
lbC003A12	TST.W	(lbW01199A-DT,A4)
	bne	lbC004230
	PEA	(2).W
	JSR	(lbC00585C,PC)
	ADDQ.W	#4,SP
	CMPI.B	#1,(lbB01193C-DT,A4)
	BNE.B	lbC003A52
;	PEA	(trackdisk_io_8-DT,A4)
;	JSR	(_CheckIO-DT,A4)	;!*************
;	ADDQ.W	#4,SP
;	TST.L	D0
;	BEQ.B	lbC003A52
	PEA	(2).W
	JSR	(_wait_for_trackdisk_8-DT,A4)
	ADDQ.W	#4,SP
;	JSR	(_trackdisk_motor_off-DT,A4)
	CLR.B	(lbB01193C-DT,A4)
	MOVE.W	#3,(lbW01194A-DT,A4)
lbC003A52	MOVE.W	(lbW011988-DT,A4),D0
	AND.W	#15,D0
	bne	lbC003B5E
	TST.B	(lbB011945-DT,A4)
	beq	lbC003B5E
	TST.B	(lbB01193C-DT,A4)
	bne	lbC003B5E
	JSR	(lbC00DDA2-DT,A4)
	MOVE.W	D0,(lbW0119BE-DT,A4)
	CMPI.W	#$31,(lbW011992-DT,A4)
	BLS.B	lbC003A82
	CLR.W	(lbW0119BE-DT,A4)
lbC003A82	JSR	(lbC00DDB4-DT,A4)
	MOVE.W	D0,(lbW0119C0-DT,A4)
	MOVE.W	(lbW011992-DT,A4),D0
	AND.W	#3,D0
	BNE.B	lbC003A98
	CLR.W	(lbW0119BE-DT,A4)
lbC003A98	MOVE.W	#1,(-4,A5)
	bra	lbC003B54

lbC003AA2	JSR	(lbC00DF82-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW0119BC-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW0119BA-DT,A4),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	TST.L	D0
	bne	lbC003B50
lbC003AC2	TST.B	(lbB011945-DT,A4)
	BEQ.B	lbC003AF0
	CMPI.W	#7,(lbW01194A-DT,A4)
	BGE.B	lbC003AF0
	PEA	($3F).W
	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC005C00,PC)
	ADDQ.W	#8,SP
	TST.L	D0
	BEQ.B	lbC003AEA
	ADDQ.W	#1,(lbW01194A-DT,A4)
lbC003AEA	SUBQ.B	#1,(lbB011945-DT,A4)
	BRA.B	lbC003AC2

lbC003AF0	MOVEQ	#3,D4
	BRA.B	lbC003B40

lbC003AF4	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB01231A-DT,A4),A0
	CMPI.B	#15,(A0,D0.L)
	BNE.B	lbC003B3E
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012315-DT,A4),A1
	TST.B	(A1,D0.L)
	BEQ.B	lbC003B2E
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012313-DT,A4),A6
	CMPI.B	#2,(A6,D0.L)
	BNE.B	lbC003B3E
lbC003B2E	PEA	($3F).W
	MOVE.L	D4,-(SP)
	JSR	(lbC005C00,PC)
	ADDQ.W	#8,SP
	SUBQ.B	#1,(lbB011945-DT,A4)
lbC003B3E	ADDQ.L	#1,D4
lbC003B40	CMP.L	#7,D4
	BGE.B	lbC003B4E
	TST.B	(lbB011945-DT,A4)
	BNE.B	lbC003AF4
lbC003B4E	BRA.B	lbC003B5E

lbC003B50	ADDQ.W	#1,(-4,A5)
lbC003B54	CMPI.W	#10,(-4,A5)
	blt	lbC003AA2
lbC003B5E	MOVE.W	(lbW011988-DT,A4),D0
	AND.W	#$1F,D0
	bne	lbC003BFE
	TST.B	(lbB01193B-DT,A4)
	bne	lbC003BFE
	TST.B	(lbB01193C-DT,A4)
	bne	lbC003BFE
	TST.W	(lbW011990-DT,A4)
	BNE.B	lbC003BFE
	CMPI.W	#$32,(lbW011992-DT,A4)
	BCC.B	lbC003BFE
	CMPI.W	#7,(lbW00ED02-DT,A4)
	BLS.B	lbC003B9E
	MOVEQ	#0,D0
	MOVE.W	(lbW011992-DT,A4),D0
	ADDQ.L	#5,D0
	MOVE.B	D0,(lbB011946-DT,A4)
	BRA.B	lbC003BAA

lbC003B9E	MOVEQ	#0,D0
	MOVE.W	(lbW011992-DT,A4),D0
	ADDQ.L	#2,D0
	MOVE.B	D0,(lbB011946-DT,A4)
lbC003BAA	JSR	(lbC00DDC0-DT,A4)
	MOVEQ	#0,D1
	MOVE.B	(lbB011946-DT,A4),D1
	CMP.L	D1,D0
	BHI.B	lbC003BFE
	JSR	(lbC00DDB4-DT,A4)
	MOVE.W	D0,(lbW01199E-DT,A4)
	CMPI.W	#7,(lbW011992-DT,A4)
	BNE.B	lbC003BD6
	CMPI.W	#2,(lbW01199E-DT,A4)
	BNE.B	lbC003BD6
	MOVE.W	#4,(lbW01199E-DT,A4)
lbC003BD6	CMPI.W	#8,(lbW011992-DT,A4)
	BNE.B	lbC003BE8
	MOVE.W	#6,(lbW01199E-DT,A4)
	CLR.W	(lbW0119BE-DT,A4)
lbC003BE8	CMPI.W	#$31,(lbW011992-DT,A4)
	BNE.B	lbC003BFA
	MOVE.W	#2,(lbW01199E-DT,A4)
	CLR.W	(lbW0119BE-DT,A4)
lbC003BFA	JSR	(lbC005B7E,PC)
lbC003BFE	MOVE.W	(lbW0119B0-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012313-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.W	D1,(-4,A5)
	TST.W	(lbW0119B0-DT,A4)
	BEQ.B	lbC003C8C
	MOVE.W	(-4,A5),D0
	CMP.W	(lbW0119B4-DT,A4),D0
	BEQ.B	lbC003C8C
	MOVE.W	(-4,A5),D0
	EXT.L	D0
	BRA.B	lbC003C6E

lbC003C2C	PEA	($17).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC003C86

lbC003C38	PEA	($2E).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC003C86

lbC003C44	TST.B	(lbB0113D1-DT,A4)
	BEQ.B	lbC003C54
	PEA	($10).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC003C54	BRA.B	lbC003C86

lbC003C56	PEA	($2B).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC003C86

lbC003C62	PEA	($29).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC003C86

lbC003C6E	SUBQ.L	#7,D0
	BEQ.B	lbC003C62
	SUBQ.L	#2,D0
	BEQ.B	lbC003C56
	SUB.L	#$7B,D0
	BEQ.B	lbC003C44
	SUBQ.L	#5,D0
	BEQ.B	lbC003C38
	SUBQ.L	#4,D0
	BEQ.B	lbC003C2C
lbC003C86	MOVE.W	(-4,A5),(lbW0119B4-DT,A4)
lbC003C8C	CLR.B	(lbB01193B-DT,A4)
	CLR.W	(lbW011994-DT,A4)
	MOVE.B	(lbB01193E-DT,A4),(-$2C,A5)
	CLR.B	(lbB01193E-DT,A4)
	MOVEQ	#2,D4
	bra	lbC004076

lbC003CA4	TST.B	(lbB011943-DT,A4)
	BEQ.B	lbC003CB4
	CMPI.B	#$78,(lbB011943-DT,A4)
	BCS.W	lbC004082
lbC003CB4	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$1A,A5)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#5,(8,A0)
	BNE.B	lbC003CFE
	MOVE.W	(lbW011988-DT,A4),D0
	AND.W	#15,D0
	BNE.B	lbC003CFA
	PEA	(5).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DE62-DT,A4)
	LEA	($10,SP),SP
lbC003CFA	bra	lbC004074

lbC003CFE	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#4,(8,A0)
	beq	lbC004074
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(14,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$32,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(15,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$34,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$2E,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW01195C-DT,A4),D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$30,A5)
	TST.W	(-$2E,A5)
	BGE.B	lbC003D5C
	NEG.W	(-$2E,A5)
lbC003D5C	TST.W	(-$30,A5)
	BGE.B	lbC003D66
	NEG.W	(-$30,A5)
lbC003D66	CMPI.W	#$12C,(-$2E,A5)
	BGE.B	lbC003DA8
	CMPI.W	#$12C,(-$30,A5)
	BGE.B	lbC003DA8
	MOVE.B	#1,(lbB01193B-DT,A4)
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01231C-DT,A4),A0
	CMPI.W	#1,(A0,D0.L)
	blt	lbC004074
	MOVEA.L	(-$1A,A5),A0
	TST.B	(11,A0)
	BNE.B	lbC003DA2
	TST.B	(-$2C,A5)
	BEQ.B	lbC003DA8
lbC003DA2	MOVE.B	#1,(lbB01193E-DT,A4)
lbC003DA8	PEA	(15).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	TST.L	D0
	BNE.B	lbC003DBE
	MOVE.W	#1,(-$36,A5)
	BRA.B	lbC003DC2

lbC003DBE	CLR.W	(-$36,A5)
lbC003DC2	CMPI.B	#15,(lbB01231A-DT,A4)
	BEQ.B	lbC003DD2
	CMPI.B	#$16,(lbB01231A-DT,A4)
	BNE.B	lbC003DE8
lbC003DD2	TST.W	(lbW011994-DT,A4)
	BNE.B	lbC003DE0
	MOVE.W	#5,(-$32,A5)
	BRA.B	lbC003DE6

lbC003DE0	MOVE.W	#9,(-$32,A5)
lbC003DE6	BRA.B	lbC003E14

lbC003DE8	MOVEA.L	(-$1A,A5),A0
	CMPI.W	#2,($12,A0)
	BLT.B	lbC003E0E
	CMPI.W	#$3B,(lbW011992-DT,A4)
	BLS.B	lbC003E14
	MOVEA.L	(-$1A,A5),A1
	MOVEA.L	(lbL0119F8-DT,A4),A6
	MOVE.B	(9,A1),D0
	CMP.B	(11,A6),D0
	BEQ.B	lbC003E14
lbC003E0E	MOVE.W	#5,(-$32,A5)
lbC003E14	TST.W	(-$34,A5)
	BEQ.B	lbC003E22
	CMPI.W	#9,(-$34,A5)
	BNE.B	lbC003E54
lbC003E22	MOVEA.L	(-$1A,A5),A0
	BTST	#2,(12,A0)
	BEQ.B	lbC003E40
	JSR	(lbC00DDB4-DT,A4)
	ADDQ.L	#2,D0
	MOVE.L	D0,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF76-DT,A4)
	ADDQ.W	#8,SP
	BRA.B	lbC003E50

lbC003E40	JSR	(lbC00DDAE-DT,A4)
	ADDQ.L	#3,D0
	MOVE.L	D0,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF76-DT,A4)
	ADDQ.W	#8,SP
lbC003E50	bra	lbC004060

lbC003E54	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$18,($10,A0)
	BNE.B	lbC003E6E
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#$19,($10,A0)
	bra	lbC004060

lbC003E6E	CMPI.W	#4,(-$32,A5)
	bgt	lbC003FF2
	BTST	#1,(-$31,A5)
	BNE.B	lbC003E94
	JSR	(lbC00DDB4-DT,A4)
	TST.L	D0
	BNE.B	lbC003E90
	MOVE.W	#1,(-$36,A5)
	BRA.B	lbC003E94

lbC003E90	CLR.W	(-$36,A5)
lbC003E94	TST.W	(-$36,A5)
	beq	lbC003F32
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#4,(9,A0)
	BNE.B	lbC003EB6
	TST.B	(lbB011819-DT,A4)
	BEQ.B	lbC003EB6
	MOVE.W	#10,(-$34,A5)
	BRA.B	lbC003F32

lbC003EB6	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#1,(12,A0)
	BGE.B	lbC003ED0
	MOVE.W	#10,(-$32,A5)
	MOVE.W	#4,(-$34,A5)
	BRA.B	lbC003F32

lbC003ED0	MOVEA.L	(-$1A,A5),A0
	CMPI.W	#6,($12,A0)
	BGE.B	lbC003EEC
	JSR	(lbC00DDAE-DT,A4)
	TST.L	D0
	BEQ.B	lbC003EEC
	MOVE.W	#6,(-$34,A5)
	BRA.B	lbC003F32

lbC003EEC	CMPI.W	#3,(-$32,A5)
	BLT.B	lbC003F2C
	CMPI.W	#$28,(-$2E,A5)
	BGE.B	lbC003F0C
	CMPI.W	#$1E,(-$30,A5)
	BGE.B	lbC003F0C
	MOVE.W	#5,(-$34,A5)
	BRA.B	lbC003F2A

lbC003F0C	CMPI.W	#$46,(-$2E,A5)
	BGE.B	lbC003F24
	CMPI.W	#$46,(-$30,A5)
	BGE.B	lbC003F24
	MOVE.W	#8,(-$34,A5)
	BRA.B	lbC003F2A

lbC003F24	MOVE.W	#1,(-$34,A5)
lbC003F2A	BRA.B	lbC003F32

lbC003F2C	MOVE.W	#1,(-$34,A5)
lbC003F32	MOVE.W	(-$32,A5),D0
	EXT.L	D0
	MOVEQ	#14,D1
	SUB.L	D0,D1
	MOVE.B	D1,(-$37,A5)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#7,(9,A0)
	BNE.B	lbC003F52
	MOVE.B	#$10,(-$37,A5)
lbC003F52	MOVEA.L	(-$1A,A5),A0
	BTST	#2,(12,A0)
	BNE.B	lbC003FB4
	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVE.B	(-$37,A5),D1
	EXT.W	D1
	EXT.L	D1
	CMP.L	D1,D0
	BGE.B	lbC003FB4
	MOVE.W	(-$30,A5),D2
	EXT.L	D2
	MOVE.B	(-$37,A5),D3
	EXT.W	D3
	EXT.L	D3
	CMP.L	D3,D2
	BGE.B	lbC003FB4
	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DE62-DT,A4)
	LEA	($10,SP),SP
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#12,($10,A0)
	BLT.B	lbC003FB2
	MOVEA.L	(-$1A,A5),A0
	CLR.B	($10,A0)
lbC003FB2	BRA.B	lbC003FF0

lbC003FB4	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#7,(9,A0)
	BNE.B	lbC003FE0
	MOVEA.L	(-$1A,A5),A1
	TST.W	($12,A1)
	BEQ.B	lbC003FE0
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#5,($11,A0)
	BRA.B	lbC003FF0

lbC003FE0	MOVE.W	(-$34,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF76-DT,A4)
	ADDQ.W	#8,SP
lbC003FF0	BRA.B	lbC004060

lbC003FF2	CMPI.W	#5,(-$32,A5)
	BNE.B	lbC004008
	PEA	(5).W
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF76-DT,A4)
	ADDQ.W	#8,SP
	BRA.B	lbC004060

lbC004008	CMPI.W	#9,(-$32,A5)
	BNE.B	lbC00401E
	PEA	(2).W
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF76-DT,A4)
	ADDQ.W	#8,SP
	BRA.B	lbC004060

lbC00401E	CMPI.W	#6,(-$32,A5)
	BNE.B	lbC00404E
	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DE62-DT,A4)
	LEA	($10,SP),SP
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
	BRA.B	lbC004060

lbC00404E	CMPI.W	#8,(-$32,A5)
	BNE.B	lbC004060
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#13,($10,A0)
lbC004060	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(-$31,A5),(14,A0)
	TST.W	(lbW011994-DT,A4)
	BNE.B	lbC004074
	MOVE.W	D4,(lbW011994-DT,A4)
lbC004074	ADDQ.L	#1,D4
lbC004076	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D4
	blt	lbC003CA4
lbC004082	TST.B	(-$2C,A5)
	BNE.B	lbC004098
	TST.B	(lbB01193E-DT,A4)
	BEQ.B	lbC004098
	PEA	(1).W
	JSR	(lbC00643C,PC)
	ADDQ.W	#4,SP
lbC004098	TST.B	(lbB01193E-DT,A4)
	BNE.B	lbC0040BC
	TST.B	(-$2C,A5)
	BEQ.B	lbC0040BC
	PEA	(7).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	PEA	(4).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00DE6E-DT,A4)
lbC0040BC	MOVE.W	(lbW011988-DT,A4),D0
	AND.W	#$7F,D0
	BNE.B	lbC004128
	TST.B	(lbB01193B-DT,A4)
	BNE.B	lbC004128
	TST.B	(lbB01193C-DT,A4)
	BNE.B	lbC004128
	TST.B	(lbB011941-DT,A4)
	BNE.B	lbC004128
	TST.B	(lbB012317-DT,A4)
	BNE.B	lbC004128
	TST.B	(lbB01193D-DT,A4)
	BNE.B	lbC004128
	CMPI.B	#15,(lbB01231A-DT,A4)
	BEQ.B	lbC004128
	MOVE.W	(lbW00ED02-DT,A4),(lbW011962-DT,A4)
	MOVE.W	(lbW01195A-DT,A4),(lbW01195E-DT,A4)
	MOVE.W	(lbW01195C-DT,A4),(lbW011960-DT,A4)
	CMPI.W	#$1E,(lbW01197C-DT,A4)
	BLE.B	lbC004128
	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	($18,A0)
	BEQ.B	lbC004128
	MOVEA.L	(lbL0119FC-DT,A4),A0
	SUBQ.B	#1,($18,A0)
	SUBI.W	#$1E,(lbW01197C-DT,A4)
	PEA	($25).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC004128	MOVE.W	(lbW011988-DT,A4),D0
	AND.W	#7,D0
	BNE.B	lbC004140
	TST.B	(lbB01193E-DT,A4)
	BNE.B	lbC004140
	CLR.L	-(SP)
	JSR	(lbC00643C,PC)
	ADDQ.W	#4,SP
lbC004140	MOVE.W	(lbW011988-DT,A4),D0
	AND.W	#$7F,D0
	bne	lbC004230
	TST.W	(lbW01231C-DT,A4)
	beq	lbC004230
	CMPI.B	#$17,(lbB01231A-DT,A4)
	beq	lbC004230
	ADDQ.W	#1,(lbW01197C-DT,A4)
	ADDQ.W	#1,(lbW01197E-DT,A4)
	CMPI.W	#$23,(lbW01197C-DT,A4)
	BNE.B	lbC00417A
	CLR.L	-(SP)
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC00420A

lbC00417A	CMPI.W	#$3C,(lbW01197C-DT,A4)
	BNE.B	lbC00418E
	PEA	(1).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC00420A

lbC00418E	MOVE.W	(lbW01197C-DT,A4),D0
	AND.W	#7,D0
	BNE.B	lbC00420A
	CMPI.W	#5,(lbW01231C-DT,A4)
	BLE.B	lbC0041D2
	CMPI.W	#$64,(lbW01197C-DT,A4)
	BGT.B	lbC0041B0
	CMPI.W	#$A0,(lbW01197E-DT,A4)
	BLE.B	lbC0041BE
lbC0041B0	SUBQ.W	#2,(lbW01231C-DT,A4)
	PEA	(4).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
lbC0041BE	CMPI.W	#$5A,(lbW01197C-DT,A4)
	BLE.B	lbC0041D0
	PEA	(2).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC0041D0	BRA.B	lbC00420A

lbC0041D2	CMPI.W	#$AA,(lbW01197E-DT,A4)
	BLE.B	lbC0041EC
	PEA	(12).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	#$17,(lbB01231A-DT,A4)
	BRA.B	lbC00420A

lbC0041EC	CMPI.W	#$8C,(lbW01197C-DT,A4)
	BLE.B	lbC00420A
	PEA	($18).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	MOVE.W	#$82,(lbW01197C-DT,A4)
	MOVE.B	#$17,(lbB01231A-DT,A4)
lbC00420A	CMPI.W	#$46,(lbW01197E-DT,A4)
	BNE.B	lbC00421E
	PEA	(3).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC004230

lbC00421E	CMPI.W	#$5A,(lbW01197C-DT,A4)
	BNE.B	lbC004230
	PEA	(4).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC004230	BRA.B	lbC00423E

lbC004232	CLR.W	(-10,A5)
	CLR.W	(-8,A5)
	JSR	(lbC00DDEA-DT,A4)
lbC00423E	BRA.B	lbC00429A

lbC004240	CMPI.W	#$FFFF,(-8,A5)
	BNE.B	lbC00428E
	CMPI.W	#1,(-10,A5)
	BNE.B	lbC00425C
	PEA	(7).W
	JSR	(_do_blit_1-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC00428C

lbC00425C	TST.W	(-10,A5)
	BNE.B	lbC00426C
	CLR.L	-(SP)
	JSR	(_do_blit_1-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC00428C

lbC00426C	CMPI.W	#$FFFF,(-10,A5)
	BNE.B	lbC004280
	PEA	(1).W
	JSR	(_do_blit_1-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC00428C

lbC004280	CLR.W	(-10,A5)
	CLR.W	(-8,A5)
	JSR	(lbC00DDEA-DT,A4)
lbC00428C	BRA.B	lbC00429A

lbC00428E	CLR.W	(-10,A5)
	CLR.W	(-8,A5)
	JSR	(lbC00DDEA-DT,A4)
lbC00429A	MOVEQ	#0,D0
	MOVE.W	(lbW011964-DT,A4),D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.L	D0,(8,A0)
	MOVEQ	#0,D0
	MOVE.W	(lbW011966-DT,A4),D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.L	D0,(12,A0)
	PEA	($1F).W
	PEA	(rp1-DT,A4)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	MOVEQ	#0,D4
	bra	lbC004530

lbC0042CA	TST.L	D4
	BLE.B	lbC0042D6
	TST.W	(lbW01199A-DT,A4)
	bne	lbC00453C
lbC0042D6	CMP.L	#1,D4
	beq	lbC00452E
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB01231A-DT,A4),A0
	CMPI.B	#12,(A0,D0.L)
	bge	lbC00452E
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012316-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	MOVE.W	D2,(-$32,A5)
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB01231B-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	MOVE.W	D2,(-$34,A5)
	BTST	#2,(-$31,A5)
	bne	lbC00452E
	CMPI.W	#8,(-$32,A5)
	BLT.B	lbC00433A
	MOVE.W	#5,(-$32,A5)
lbC00433A	PEA	(2).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	ADD.W	D0,(-$32,A5)
	MOVE.W	(-$32,A5),D0
	EXT.L	D0
	MOVE.W	(-$32,A5),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$34,A5),D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	MOVEQ	#0,D3
	MOVE.W	(A0,D0.L),D3
	MOVE.L	D3,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	(SP)+,D1
	ADD.L	D0,D1
	SUBQ.L	#3,D1
	MOVE.W	D1,(-$2E,A5)
	MOVE.W	(-$32,A5),D0
	EXT.L	D0
	MOVE.W	(-$32,A5),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$34,A5),D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D3
	MOVE.W	(A0,D0.L),D3
	MOVE.L	D3,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	(SP)+,D1
	ADD.L	D0,D1
	SUBQ.L	#3,D1
	MOVE.W	D1,(-$30,A5)
	TST.L	D4
	BNE.B	lbC0043E8
	MOVE.W	(lbW011974-DT,A4),D0
	EXT.L	D0
	MOVEQ	#$14,D1
	JSR	(__divs-DT,A4)
	ADDQ.L	#5,D0
	MOVE.W	D0,(-$36,A5)
	BRA.B	lbC0043F2

lbC0043E8	JSR	(lbC00DDB4-DT,A4)
	ADDQ.L	#2,D0
	MOVE.W	D0,(-$36,A5)
lbC0043F2	CMPI.W	#14,(-$36,A5)
	BLE.B	lbC004400
	MOVE.W	#15,(-$36,A5)
lbC004400	CLR.W	(-2,A5)
	bra	lbC004522

lbC004408	CMPI.W	#1,(-2,A5)
	beq	lbC00451E
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	CMP.L	D4,D0
	beq	lbC00451E
	MOVE.W	(-2,A5),D1
	MULS.W	#$16,D1
	LEA	(lbB01231A-DT,A4),A0
	CMPI.B	#15,(A0,D1.L)
	beq	lbC00451E
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012312-DT,A4),A1
	CMPI.B	#5,(A1,D0.L)
	beq	lbC00451E
	MOVE.W	(-2,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	MOVE.W	(-$2E,A5),D2
	EXT.L	D2
	SUB.L	D2,D1
	MOVE.W	D1,(-$38,A5)
	MOVE.W	(-2,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	MOVE.W	(-$30,A5),D2
	EXT.L	D2
	SUB.L	D2,D1
	MOVE.W	D1,(-$3A,A5)
	TST.W	(-$38,A5)
	BGE.B	lbC004490
	NEG.W	(-$38,A5)
lbC004490	TST.W	(-$3A,A5)
	BGE.B	lbC00449A
	NEG.W	(-$3A,A5)
lbC00449A	MOVE.W	(-$38,A5),D0
	CMP.W	(-$3A,A5),D0
	BLE.B	lbC0044AA
	MOVE.W	(-$38,A5),(-$3A,A5)
lbC0044AA	TST.L	D4
	BEQ.B	lbC0044BC
	JSR	(lbC00DDC6-DT,A4)
	MOVE.W	(lbW011974-DT,A4),D1
	EXT.L	D1
	CMP.L	D1,D0
	BLE.B	lbC0044F0
lbC0044BC	MOVE.W	(-$3A,A5),D0
	CMP.W	(-$36,A5),D0
	BGE.B	lbC0044F0
	TST.W	(lbW01199A-DT,A4)
	BNE.B	lbC0044F0
	MOVE.W	(-$32,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$34,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.W	(-2,A5),D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DE68-DT,A4)
	LEA	($10,SP),SP
	BRA.B	lbC00452E

lbC0044F0	MOVE.W	(-$3A,A5),D0
	EXT.L	D0
	MOVE.W	(-$36,A5),D1
	EXT.L	D1
	ADDQ.L	#2,D1
	CMP.L	D1,D0
	BGE.B	lbC00451E
	CMPI.W	#5,(-$32,A5)
	BEQ.B	lbC00451E
	JSR	(lbC00DDC6-DT,A4)
	MOVEA.L	D0,A0
	PEA	($96,A0)
	PEA	(1).W
	JSR	(lbC00827A,PC)
	ADDQ.W	#8,SP
lbC00451E	ADDQ.W	#1,(-2,A5)
lbC004522	MOVE.W	(-2,A5),D0
	CMP.W	(lbW01194A-DT,A4),D0
	blt	lbC004408
lbC00452E	ADDQ.L	#1,D4
lbC004530	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D4
	blt	lbC0042CA
lbC00453C	TST.W	(lbW01199A-DT,A4)
	bne	lbC0047E2
	MOVEQ	#0,D4
lbC004546	MOVEQ	#10,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL011DEE-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$40,A5)
	MOVEA.L	(-$40,A5),A0
	MOVE.B	(6,A0),D0
	EXT.W	D0
	EXT.L	D0
	ASL.L	#1,D0
	MOVE.W	D0,(-$3C,A5)
	MOVEA.L	(-$40,A5),A0
	TST.B	(4,A0)
	BEQ.B	lbC004598
	MOVEA.L	(-$40,A5),A1
	CMPI.B	#3,(4,A1)
	BEQ.B	lbC004598
	TST.W	(-$3C,A5)
	BEQ.B	lbC004598
	MOVEA.L	(-$40,A5),A6
	MOVE.B	(5,A6),D0
	ADDQ.B	#1,(5,A6)
	CMP.B	#$28,D0
	BLE.B	lbC0045A4
lbC004598	MOVEA.L	(-$40,A5),A0
	CLR.B	(4,A0)
	bra	lbC0047D6

lbC0045A4	MOVEA.L	(-$40,A5),A0
	MOVE.W	(2,A0),D0
	MOVE.W	D0,(-$30,A5)
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(-$40,A5),A1
	MOVE.W	(A1),D1
	MOVE.W	D1,(-$2E,A5)
	EXT.L	D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	D0,(-2,A5)
	CMPI.W	#1,(-2,A5)
	BEQ.B	lbC0045DC
	CMPI.W	#15,(-2,A5)
	BNE.B	lbC0045E8
lbC0045DC	MOVEA.L	(-$40,A5),A0
	CLR.B	(4,A0)
	CLR.W	(-$3C,A5)
lbC0045E8	MOVEA.L	(-$40,A5),A0
	MOVE.B	(7,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$32,A5)
	MOVE.W	#6,(-$38,A5)
	MOVEA.L	(-$40,A5),A0
	CMPI.B	#2,(4,A0)
	BNE.B	lbC00460E
	MOVE.W	#9,(-$38,A5)
lbC00460E	CLR.W	(-2,A5)
	bra	lbC004776

lbC004616	TST.W	(-2,A5)
	BNE.B	lbC004624
	MOVE.W	(lbW011974-DT,A4),(-$3A,A5)
	BRA.B	lbC00462A

lbC004624	MOVE.W	#$14,(-$3A,A5)
lbC00462A	CMPI.W	#1,(-2,A5)
	beq	lbC004772
	MOVEA.L	(-$40,A5),A0
	MOVE.B	(8,A0),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	(-2,A5),D1
	EXT.L	D1
	CMP.L	D1,D0
	beq	lbC004772
	MOVE.W	(-2,A5),D2
	MULS.W	#$16,D2
	LEA	(lbB01231A-DT,A4),A1
	CMPI.B	#15,(A1,D2.L)
	beq	lbC004772
	MOVE.W	(-2,A5),D3
	MULS.W	#$16,D3
	LEA	(lbB012312-DT,A4),A6
	CMPI.B	#5,(A6,D3.L)
	beq	lbC004772
	MOVE.W	(-2,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	MOVE.W	(-$2E,A5),D2
	EXT.L	D2
	SUB.L	D2,D1
	MOVE.W	D1,(-$34,A5)
	MOVE.W	(-2,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	MOVE.W	(-$30,A5),D2
	EXT.L	D2
	SUB.L	D2,D1
	MOVE.W	D1,(-$36,A5)
	TST.W	(-$34,A5)
	BGE.B	lbC0046BE
	NEG.W	(-$34,A5)
lbC0046BE	TST.W	(-$36,A5)
	BGE.B	lbC0046C8
	NEG.W	(-$36,A5)
lbC0046C8	MOVE.W	(-$34,A5),D0
	CMP.W	(-$36,A5),D0
	BLE.B	lbC0046D8
	MOVE.W	(-$34,A5),(-$36,A5)
lbC0046D8	TST.L	D4
	BNE.B	lbC0046F2
	PEA	($200).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	MOVE.W	(-$3A,A5),D1
	EXT.L	D1
	CMP.L	D1,D0
	ble	lbC004772
lbC0046F2	MOVE.W	(-$36,A5),D0
	CMP.W	(-$38,A5),D0
	BGE.B	lbC004772
	MOVEA.L	(-$40,A5),A0
	CMPI.B	#2,(4,A0)
	BNE.B	lbC00472E
	JSR	(lbC00DDBA-DT,A4)
	ADDQ.L	#4,D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$32,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.W	(-2,A5),D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	PEA	(-2).W
	JSR	(lbC00DE68-DT,A4)
	LEA	($10,SP),SP
	BRA.B	lbC004752

lbC00472E	JSR	(lbC00DDBA-DT,A4)
	ADDQ.L	#4,D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$32,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.W	(-2,A5),D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	PEA	(-1).W
	JSR	(lbC00DE68-DT,A4)
	LEA	($10,SP),SP
lbC004752	MOVEA.L	(-$40,A5),A0
	CLR.B	(6,A0)
	MOVEA.L	(-$40,A5),A0
	CMPI.B	#2,(4,A0)
	BNE.B	lbC004770
	MOVEA.L	(-$40,A5),A0
	MOVE.B	#3,(4,A0)
lbC004770	BRA.B	lbC004782

lbC004772	ADDQ.W	#1,(-2,A5)
lbC004776	MOVE.W	(-2,A5),D0
	CMP.W	(lbW01194A-DT,A4),D0
	blt	lbC004616
lbC004782	MOVE.W	(-$3C,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$32,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEA.L	(-$40,A5),A0
	MOVEQ	#0,D2
	MOVE.W	(A0),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVEA.L	(-$40,A5),A0
	MOVE.W	D0,(A0)
	MOVE.W	(-$3C,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$32,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEA.L	(-$40,A5),A0
	MOVEQ	#0,D2
	MOVE.W	(2,A0),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVEA.L	(-$40,A5),A0
	MOVE.W	D0,(2,A0)
lbC0047D6	ADDQ.L	#1,D4
	CMP.L	#6,D4
	blt	lbC004546
lbC0047E2	MOVE.W	(lbW01194A-DT,A4),(lbW01194C-DT,A4)
	JSR	(lbC00DF34-DT,A4)
	MOVEQ	#0,D4
lbC0047EE	MOVEQ	#10,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL011DEE-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$36,A5)
	MOVEA.L	(-$36,A5),A0
	MOVE.B	(4,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$2E,A5)
	beq	lbC00490A
	MOVEA.L	(-$36,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	SUB.L	D1,D0
	SUB.L	#9,D0
	MOVE.W	D0,(-12,A5)
	MOVEA.L	(-$36,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011958-DT,A4),D1
	SUB.L	D1,D0
	SUB.L	#$1A,D0
	MOVE.W	D0,(-14,A5)
	CMPI.W	#$FFEC,(-12,A5)
	ble	lbC00490A
	CMPI.W	#$154,(-12,A5)
	bge	lbC00490A
	CMPI.W	#$FFEC,(-14,A5)
	ble	lbC00490A
	CMPI.W	#$BE,(-14,A5)
	bge	lbC00490A
	MOVE.W	(lbW01194C-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$32,A5)
	MOVEA.L	(-$36,A5),A0
	MOVEA.L	(-$32,A5),A1
	MOVE.W	(A0),(A1)
	MOVEA.L	(-$36,A5),A0
	MOVEA.L	(-$32,A5),A1
	MOVE.W	(2,A0),(2,A1)
	MOVEA.L	(-$32,A5),A0
	MOVE.W	(-12,A5),(4,A0)
	MOVEA.L	(-$32,A5),A0
	MOVE.W	(-14,A5),(6,A0)
	MOVEA.L	(-$32,A5),A0
	MOVE.B	#1,(8,A0)
	MOVEA.L	(-$32,A5),A0
	CLR.B	(12,A0)
	MOVEA.L	(-$36,A5),A0
	MOVEA.L	(-$32,A5),A1
	MOVE.B	(7,A0),(10,A1)
	MOVEA.L	(-$32,A5),A0
	MOVE.B	#$FF,(9,A0)
	CMPI.W	#3,(-$2E,A5)
	BNE.B	lbC0048EC
	MOVEA.L	(-$32,A5),A0
	MOVE.B	#$58,(10,A0)
	BRA.B	lbC0048FE

lbC0048EC	CMPI.W	#2,(-$2E,A5)
	BNE.B	lbC0048FE
	MOVEA.L	(-$32,A5),A0
	ADDI.B	#$59,(10,A0)
lbC0048FE	ADDQ.W	#1,(lbW01194C-DT,A4)
	CMPI.W	#$14,(lbW01194C-DT,A4)
	BGE.B	lbC004916
lbC00490A	ADDQ.L	#1,D4
	CMP.L	#6,D4
	blt	lbC0047EE
lbC004916	CLR.W	(lbW0119B0-DT,A4)
	MOVE.W	#$32,(lbW0119B2-DT,A4)
	MOVEQ	#0,D4
	BRA.B	lbC00492E

lbC004924	LEA	(lbL011B78-DT,A4),A0
	MOVE.B	D4,(A0,D4.L)
	ADDQ.L	#1,D4
lbC00492E	MOVE.W	(lbW01194C-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D4
	BLT.B	lbC004924
	MOVEQ	#0,D4
	bra	lbC004AB0

lbC00493E	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$1A,A5)
	TST.L	D4
	BEQ.B	lbC004996
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#1,(8,A0)
	BEQ.B	lbC004996
	MOVEA.L	(-$1A,A5),A1
	CMPI.B	#15,($10,A1)
	BEQ.B	lbC004996
	CMPI.W	#11,(lbW01196A-DT,A4)
	BEQ.B	lbC004996
	CLR.L	-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DE80-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	D0,(-2,A5)
	MOVE.W	(-2,A5),D0
	CMP.W	(lbW0119B2-DT,A4),D0
	BGE.B	lbC004996
	MOVE.W	(-2,A5),(lbW0119B2-DT,A4)
	MOVE.W	D4,(lbW0119B0-DT,A4)
lbC004996	MOVE.W	#1,(-2,A5)
	bra	lbC004AA2

lbC0049A0	MOVE.W	(-2,A5),D0
	LEA	(view_modes_lowbyte-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.W),D1
	MOVE.W	D1,(-$2E,A5)
	MOVE.W	(-2,A5),D0
	LEA	(lbL011B78-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.W),D1
	MOVE.W	D1,(-$30,A5)
	MOVE.W	(-$2E,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230C-DT,A4),A0
	MOVE.W	(A0,D0.L),(-$32,A5)
	MOVE.W	(-$30,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230C-DT,A4),A0
	MOVE.W	(A0,D0.L),(-$34,A5)
	MOVE.W	(-$2E,A5),D0
	MULS.W	#$16,D0
	LEA	(lbB01231A-DT,A4),A0
	CMPI.B	#15,(A0,D0.L)
	BEQ.B	lbC004A10
	TST.W	(-$30,A5)
	BNE.B	lbC004A08
	TST.W	(lbW01196A-DT,A4)
	BNE.B	lbC004A10
lbC004A08	CMPI.W	#1,(-$2E,A5)
	BNE.B	lbC004A16
lbC004A10	SUBI.W	#$20,(-$32,A5)
lbC004A16	MOVE.W	(-$30,A5),D0
	MULS.W	#$16,D0
	LEA	(lbB01231A-DT,A4),A0
	CMPI.B	#15,(A0,D0.L)
	BEQ.B	lbC004A3E
	TST.W	(-$2E,A5)
	BNE.B	lbC004A36
	TST.W	(lbW01196A-DT,A4)
	BNE.B	lbC004A3E
lbC004A36	CMPI.W	#1,(-$30,A5)
	BNE.B	lbC004A44
lbC004A3E	SUBI.W	#$20,(-$34,A5)
lbC004A44	MOVE.W	(-$2E,A5),D0
	MULS.W	#$16,D0
	LEA	(lbB012317-DT,A4),A0
	CMPI.B	#$19,(A0,D0.L)
	BLE.B	lbC004A5E
	ADDI.W	#$20,(-$32,A5)
lbC004A5E	MOVE.W	(-$30,A5),D0
	MULS.W	#$16,D0
	LEA	(lbB012317-DT,A4),A0
	CMPI.B	#$19,(A0,D0.L)
	BLE.B	lbC004A78
	ADDI.W	#$20,(-$34,A5)
lbC004A78	MOVE.W	(-$34,A5),D0
	CMP.W	(-$32,A5),D0
	BGE.B	lbC004A9E
	MOVE.W	(-2,A5),D0
	LEA	(view_modes_lowbyte-DT,A4),A0
	MOVE.B	(-$2F,A5),(A0,D0.W)
	MOVE.W	(-2,A5),D0
	LEA	(lbL011B78-DT,A4),A0
	MOVE.B	(-$2D,A5),(A0,D0.W)
lbC004A9E	ADDQ.W	#1,(-2,A5)
lbC004AA2	MOVE.W	(-2,A5),D0
	CMP.W	(lbW01194C-DT,A4),D0
	blt	lbC0049A0
	ADDQ.L	#1,D4
lbC004AB0	MOVE.W	(lbW01194C-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D4
	blt	lbC00493E
	CMPI.W	#1,(-8,A5)
	BNE.B	lbC004AD0
	PEA	($24).W
	JSR	(lbC00DDF0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC004AE0

lbC004AD0	CMPI.W	#$FFFF,(-8,A5)
	BNE.B	lbC004AE0
	CLR.L	-(SP)
	JSR	(lbC00DDF0-DT,A4)
	ADDQ.W	#4,SP
lbC004AE0	CMPI.W	#1,(-10,A5)
	BNE.B	lbC004AF4
	PEA	(10).W
	JSR	(lbC00DDF6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC004B04

lbC004AF4	CMPI.W	#$FFFF,(-10,A5)
	BNE.B	lbC004B04
	CLR.L	-(SP)
	JSR	(lbC00DDF6-DT,A4)
	ADDQ.W	#4,SP
lbC004B04	MOVEQ	#0,D0
	MOVE.W	(lbW012336-DT,A4),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	AND.L	#$FFF0,D1
	SUB.L	D1,D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.W	D0,($1E,A0)
	MOVEQ	#0,D0
	MOVE.W	(lbW012338-DT,A4),D0
	SUB.L	#15,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011958-DT,A4),D1
	AND.L	#$FFE0,D1
	SUB.L	D1,D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.W	D0,($20,A0)
	JSR	(lbC00DDB4-DT,A4)
	TST.L	D0
	BNE.B	lbC004B5E
	TST.W	(lbW01181A-DT,A4)
	BLE.B	lbC004B58
	MOVE.B	#1,(lbB011942-DT,A4)
	BRA.B	lbC004B5E

lbC004B58	MOVE.B	#$FF,(lbB011942-DT,A4)
lbC004B5E	MOVE.B	(lbB011942-DT,A4),D0
	ADD.B	D0,(lbB011944-DT,A4)
	MOVEQ	#0,D1
	MOVE.B	(lbB011944-DT,A4),D1
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.W	D1,($22,A0)
	MOVE.B	(lbB011941-DT,A4),D0
	EXT.W	D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.W	D0,($24,A0)
	TST.B	(lbB011941-DT,A4)
	BEQ.B	lbC004BD2
	MOVE.L	(lbL011A04-DT,A4),-(SP)
	JSR	(lbC00DF2E-DT,A4)
	ADDQ.W	#4,SP
	TST.W	(lbW01181A-DT,A4)
	BLE.B	lbC004BD2
	TST.W	(lbW01181C-DT,A4)
	BGE.B	lbC004BD2
	CLR.L	-(SP)
	PEA	(2).W
	JSR	(lbC00DE80-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#$64,D0
	BGE.B	lbC004BD2
	JSR	(lbC00DDAE-DT,A4)
	ADDQ.L	#1,D0
	MOVE.L	D0,-(SP)
	MOVE.B	(lbB012347-DT,A4),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	CLR.L	-(SP)
	PEA	(-1).W
	JSR	(lbC00DE68-DT,A4)
	LEA	($10,SP),SP
lbC004BD2	MOVEA.L	(lbL011A04-DT,A4),A0
	CLR.L	($1A,A0)
	CLR.B	(-$2B,A5)
	MOVEQ	#0,D0
	MOVEQ	#0,D0
	MOVEA.L	(lbL011A04-DT,A4),A1
	MOVE.W	D0,($10,A1)
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.L	($16,A0),(-$2A,A5)
	CLR.W	(-2,A5)
	bra	lbC0056D2

lbC004BFC	CLR.B	(lbB011947-DT,A4)
	CLR.B	(lbB011948-DT,A4)
	MOVE.W	(-2,A5),D0
	LEA	(lbL011B78-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.W),D1
	MOVE.L	D1,D4
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-$1A,A5)
	MOVEA.L	(-$1A,A5),A0
	CLR.B	(11,A0)
lbC004C2E	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(10,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$20,A5)
	MOVEA.L	(-$1A,A5),A0
	TST.B	(12,A0)
	ble	lbC004CDA
	MOVEA.L	(-$1A,A5),A1
	CMPI.B	#8,(12,A1)
	bge	lbC004CDA
	MOVEA.L	(-$1A,A5),A6
	CMPI.B	#15,($10,A6)
	BLT.B	lbC004C76
	MOVEA.L	(-$1A,A5),A6
	CMPI.B	#$18,($10,A6)
	BGE.B	lbC004C76
	CMPI.W	#$50,(lbW011992-DT,A4)
	BLS.B	lbC004CDA
lbC004C76	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($11,A0),D0
	EXT.W	D0
	EXT.L	D0
	SUBQ.L	#2,D0
	BTST	#2,D0
	BEQ.B	lbC004C98
	MOVE.B	(lbB011947-DT,A4),D0
	BCHG	#0,D0
	MOVE.B	D0,(lbB011948-DT,A4)
	BRA.B	lbC004C9E

lbC004C98	MOVE.B	(lbB011947-DT,A4),(lbB011948-DT,A4)
lbC004C9E	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#4,(12,A0)
	BNE.B	lbC004CD6
	MOVEA.L	(-$1A,A5),A1
	CMPI.B	#$18,($10,A1)
	BGE.B	lbC004CD6
	MOVEA.L	(-$1A,A5),A0
	BTST	#2,($11,A0)
	BNE.B	lbC004CD0
	MOVE.B	(lbB011947-DT,A4),D0
	BCHG	#0,D0
	MOVE.B	D0,(lbB011948-DT,A4)
	BRA.B	lbC004CD6

lbC004CD0	MOVE.B	(lbB011947-DT,A4),(lbB011948-DT,A4)
lbC004CD6	ADDQ.B	#1,(lbB011947-DT,A4)
lbC004CDA	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(4,A0),(-12,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.W	(6,A0),(-14,A5)
	MOVE.W	(-14,A5),D0
	EXT.L	D0
	ADD.L	#$20,D0
	MOVE.W	D0,(-$2E,A5)
	JSR	(_OwnBlitter-DT,A4)
	JSR	(_WaitBlit-DT,A4)
	PEA	($1805).W
	MOVE.L	(lbL011A68-DT,A4),-(SP)
	JSR	(lbC00DE3E-DT,A4)
	ADDQ.W	#8,SP
	JSR	(_DisownBlitter-DT,A4)
	TST.B	(lbB011948-DT,A4)
	beq	lbC004E6E
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(12,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-4,A5)
	CMPI.W	#4,(-4,A5)
	BNE.B	lbC004D64
	CMPI.W	#$20,(-$20,A5)
	BGE.B	lbC004D64
	MOVE.W	(-$20,A5),D0
	LEA	(lbL010F12-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	ADD.W	D1,(-12,A5)
	MOVE.W	(-$20,A5),D0
	LEA	(lbL010F32-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	ADD.W	D1,(-14,A5)
	BRA.B	lbC004D90

lbC004D64	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB00E1C8-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	ADD.W	D1,(-12,A5)
	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB00E1C9-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	ADD.W	D1,(-14,A5)
lbC004D90	CMPI.W	#4,(-4,A5)
	BNE.B	lbC004DD8
	CMPI.W	#$20,(-$20,A5)
	BGE.B	lbC004DD8
	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	DIVS.W	#8,D0
	MOVE.W	D0,(-$20,A5)
	BTST	#0,(-$1F,A5)
	BEQ.B	lbC004DBE
	MOVE.W	#$1E,(-$20,A5)
	BRA.B	lbC004DD4

lbC004DBE	BTST	#1,(-$1F,A5)
	BEQ.B	lbC004DCE
	MOVE.W	#$53,(-$20,A5)
	BRA.B	lbC004DD4

lbC004DCE	MOVE.W	#$51,(-$20,A5)
lbC004DD4	bra	lbC004E64

lbC004DD8	CMPI.W	#5,(-4,A5)
	BNE.B	lbC004E08
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	($11,A0),D0
	EXT.W	D0
	EXT.L	D0
	ADD.L	#$67,D0
	MOVE.W	D0,(-$20,A5)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,($11,A0)
	BNE.B	lbC004E06
	SUBQ.W	#6,(-14,A5)
lbC004E06	BRA.B	lbC004E64

lbC004E08	CMPI.W	#2,(-4,A5)
	BNE.B	lbC004E18
	MOVE.W	#$20,(-4,A5)
	BRA.B	lbC004E44

lbC004E18	CMPI.W	#3,(-4,A5)
	BNE.B	lbC004E28
	MOVE.W	#$30,(-4,A5)
	BRA.B	lbC004E44

lbC004E28	CMPI.W	#1,(-4,A5)
	BNE.B	lbC004E38
	MOVE.W	#$40,(-4,A5)
	BRA.B	lbC004E44

lbC004E38	CMPI.W	#4,(-4,A5)
	BNE.B	lbC004E44
	CLR.W	(-4,A5)
lbC004E44	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB00E1C7-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.W	(-4,A5),D2
	EXT.L	D2
	ADD.L	D2,D1
	MOVE.W	D1,(-$20,A5)
lbC004E64	MOVE.W	#1,(-$1E,A5)
	bra	lbC004F86

lbC004E6E	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(8,A0),D0
	EXT.W	D0
	MOVE.W	D0,(-$1E,A5)
	CMPI.W	#2,(-$1E,A5)
	BNE.B	lbC004E90
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#8,(9,A0)
	BNE.B	lbC004E98
lbC004E90	TST.W	(-$1E,A5)
	bne	lbC004F50
lbC004E98	TST.B	(lbB011936-DT,A4)
	BEQ.B	lbC004ED4
	MOVEA.L	(-$1A,A5),A0
	TST.B	(13,A0)
	BLE.B	lbC004ED4
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#15,($10,A0)
	beq	lbC0056C4
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#14,($10,A0)
	BNE.B	lbC004ED2
	MOVE.W	#1,(-$1E,A5)
	MOVE.W	#$58,(-$20,A5)
	bra	lbC004F86

lbC004ED2	BRA.B	lbC004F12

lbC004ED4	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$16,($10,A0)
	BNE.B	lbC004EFC
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$10,(15,A0)
	BGE.B	lbC004EF4
	MOVE.W	#2,(-$1E,A5)
	BRA.B	lbC004EFA

lbC004EF4	MOVE.W	#1,(-$1E,A5)
lbC004EFA	BRA.B	lbC004F12

lbC004EFC	MOVE.W	(-$20,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB00E1C6-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	MOVE.W	D1,(-$20,A5)
lbC004F12	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#4,(9,A0)
	BNE.B	lbC004F32
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#14,($10,A0)
	BGE.B	lbC004F30
	ADDI.W	#$24,(-$20,A5)
lbC004F30	BRA.B	lbC004F50

lbC004F32	TST.L	D4
	BLE.B	lbC004F50
	MOVEA.L	(-$1A,A5),A0
	BTST	#0,(9,A0)
	BEQ.B	lbC004F4A
	BSET	#0,(-$1F,A5)
	BRA.B	lbC004F50

lbC004F4A	BCLR	#0,(-$1F,A5)
lbC004F50	CMPI.W	#1,(-$1E,A5)
	BNE.B	lbC004F64
	MOVEA.L	(-$1A,A5),A0
	TST.B	(9,A0)
	beq	lbC0056C4
lbC004F64	CMPI.W	#5,(-$1E,A5)
	BNE.B	lbC004F86
	TST.W	(lbW01196A-DT,A4)
	BNE.B	lbC004F86
	CMPI.W	#11,(lbW01198C-DT,A4)
	BNE.B	lbC004F86
	MOVE.W	#3,(-$1E,A5)
	MOVE.W	#1,(-$20,A5)
lbC004F86	MOVEQ	#0,D0
	MOVE.W	(lbW011956-DT,A4),D0
	AND.L	#15,D0
	ADD.W	D0,(-12,A5)
	MOVEQ	#0,D0
	MOVE.W	(lbW011958-DT,A4),D0
	AND.L	#$1F,D0
	ADD.W	D0,(-14,A5)
	MOVEQ	#0,D0
	MOVE.W	(lbW011958-DT,A4),D0
	AND.L	#$1F,D0
	ADD.W	D0,(-$2E,A5)
	MOVE.W	(-$1E,A5),D0
	MULS.W	#$12,D0
	LEA	(lbW01200E-DT,A4),A0
	MOVE.W	(A0,D0.L),D1
	EXT.L	D1
	ASL.L	#4,D1
	MOVE.B	D1,(-$31,A5)
	MOVE.W	(-$1E,A5),D0
	MULS.W	#$12,D0
	LEA	(lbW012010-DT,A4),A0
	MOVE.B	(1,A0,D0.L),(-$32,A5)
	CMPI.W	#1,(-$1E,A5)
	BNE.B	lbC00502E
	CMPI.W	#$1B,(-$20,A5)
	BEQ.B	lbC005028
	CMPI.W	#8,(-$20,A5)
	BLT.B	lbC005000
	CMPI.W	#12,(-$20,A5)
	BLE.B	lbC005028
lbC005000	CMPI.W	#$19,(-$20,A5)
	BEQ.B	lbC005028
	CMPI.W	#$1A,(-$20,A5)
	BEQ.B	lbC005028
	CMPI.W	#$10,(-$20,A5)
	BLE.B	lbC005020
	CMPI.W	#$18,(-$20,A5)
	BLT.B	lbC005028
lbC005020	BTST	#7,(-$1F,A5)
	BEQ.B	lbC00502E
lbC005028	MOVE.B	#8,(-$32,A5)
lbC00502E	MOVE.B	(-$31,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#8,D1
	JSR	(__divs-DT,A4)
	MOVE.B	D0,(-$39,A5)
	MOVE.W	(-12,A5),D0
	EXT.L	D0
	MOVE.B	(-$31,A5),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	SUBQ.L	#1,D0
	MOVE.W	D0,(-$10,A5)
	MOVE.W	(-14,A5),D0
	EXT.L	D0
	MOVE.B	(-$32,A5),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	SUBQ.L	#1,D0
	MOVE.W	D0,(-$12,A5)
	TST.B	(lbB011948-DT,A4)
	bne	lbC00510E
	CMPI.W	#1,(-$1E,A5)
	beq	lbC00510E
	TST.L	D4
	BNE.B	lbC005092
	CMPI.W	#11,(lbW01196A-DT,A4)
	BNE.B	lbC005092
	SUBI.W	#$10,(-$12,A5)
	BRA.B	lbC00510C

lbC005092	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,(13,A0)
	BNE.B	lbC0050A6
	SUBI.W	#10,(-$12,A5)
	BRA.B	lbC00510C

lbC0050A6	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$1D,(13,A0)
	BLE.B	lbC0050F2
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#15,($10,A0)
	beq	lbC0056C4
	ADDI.W	#$1B,(-14,A5)
	MOVE.W	(-14,A5),D0
	EXT.L	D0
	ADDQ.L	#7,D0
	MOVE.W	D0,(-$12,A5)
	MOVE.W	#1,(-$1E,A5)
	MOVE.W	(-$1C,A5),D0
	EXT.L	D0
	ADD.L	D4,D0
	AND.L	#1,D0
	ADD.L	#$61,D0
	MOVE.W	D0,(-$20,A5)
	BRA.B	lbC00510C

lbC0050F2	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,(13,A0)
	BLE.B	lbC00510C
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(13,A0),D0
	EXT.W	D0
	ADD.W	D0,(-14,A5)
lbC00510C	BRA.B	lbC00516E

lbC00510E	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$1D,(13,A0)
	bgt	lbC0056C4
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#2,(13,A0)
	BLE.B	lbC00516E
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(13,A0),D0
	EXT.W	D0
	ADD.W	D0,(-14,A5)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(13,A0),D0
	EXT.W	D0
	ADD.W	D0,(-$12,A5)
	MOVE.W	(-$12,A5),D0
	CMP.W	(-$2E,A5),D0
	BLE.B	lbC005154
	MOVE.W	(-$2E,A5),(-$12,A5)
lbC005154	MOVE.W	(-14,A5),D0
	CMP.W	(-$2E,A5),D0
	bge	lbC0056C4
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	(13,A0),D0
	EXT.W	D0
	ADD.W	D0,(-$2E,A5)
lbC00516E	CMPI.W	#$13F,(-12,A5)
	bgt	lbC0056C4
	CMPI.W	#$AD,(-14,A5)
	bgt	lbC0056C4
	TST.W	(-$10,A5)
	blt	lbC0056C4
	TST.W	(-$12,A5)
	blt	lbC0056C4
	MOVE.W	(-12,A5),(-$40,A5)
	TST.W	(-12,A5)
	BGE.B	lbC0051A2
	CLR.W	(-$40,A5)
lbC0051A2	MOVE.W	(-14,A5),(-$42,A5)
	TST.W	(-14,A5)
	BGE.B	lbC0051B2
	CLR.W	(-$42,A5)
lbC0051B2	MOVE.W	(-$10,A5),(-$44,A5)
	CMPI.W	#$13F,(-$10,A5)
	BLE.B	lbC0051C6
	MOVE.W	#$13F,(-$44,A5)
lbC0051C6	MOVE.W	(-$12,A5),(-$46,A5)
	CMPI.W	#$AD,(-$12,A5)
	BLE.B	lbC0051DA
	MOVE.W	#$AD,(-$46,A5)
lbC0051DA	MOVE.W	(-$40,A5),D0
	EXT.L	D0
	MOVE.W	(-12,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.B	D0,(-$35,A5)
	MOVE.W	(-$42,A5),D0
	EXT.L	D0
	MOVE.W	(-14,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.B	D0,(-$36,A5)
	CMPI.W	#1,(-$1E,A5)
	BNE.B	lbC005218
	BTST	#7,(-$1F,A5)
	BEQ.B	lbC005218
	ANDI.W	#$7F,(-$20,A5)
	ADDQ.B	#8,(-$36,A5)
lbC005218	MOVE.W	(-$40,A5),D0
	EXT.L	D0
	ASR.L	#4,D0
	MOVE.B	D0,(-$33,A5)
	MOVE.W	(-$44,A5),D0
	EXT.L	D0
	ASR.L	#4,D0
	MOVE.B	D0,(-$34,A5)
	MOVE.B	(-$34,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.B	(-$33,A5),D1
	EXT.W	D1
	EXT.L	D1
	SUB.L	D1,D0
	ADDQ.L	#1,D0
	MOVE.B	D0,(-$38,A5)
	MOVE.W	(-$46,A5),D0
	EXT.L	D0
	MOVE.W	(-$42,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	ADDQ.L	#1,D0
	MOVE.B	D0,(-$37,A5)
	MOVE.B	(-$35,A5),D0
	AND.B	#15,D0
	BEQ.B	lbC00526A
	ADDQ.B	#1,(-$38,A5)
lbC00526A	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVE.W	($10,A0),D0
	MULS.W	#12,D0
	MOVEA.L	(lbL011A04-DT,A4),A1
	ADD.L	($12,A1),D0
	MOVE.L	D0,(lbL011A00-DT,A4)
	MOVE.W	(-$1E,A5),D0
	MULS.W	#$12,D0
	LEA	(lbL01201C-DT,A4),A0
	MOVE.W	(A0,D0.L),(lbW0119D4-DT,A4)
	MOVE.B	(-$38,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.B	(-$37,A5),D1
	EXT.W	D1
	EXT.L	D1
	JSR	(__mulu-DT,A4)
	ASL.L	#1,D0
	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.W	D0,(4,A0)
	MOVE.B	(-$37,A5),D0
	EXT.W	D0
	EXT.L	D0
	ASL.L	#6,D0
	MOVE.B	(-$38,A5),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.W	D0,(6,A0)
	MOVE.W	(lbW0119D4-DT,A4),D0
	MULS.W	(-$20,A5),D0
	MOVEQ	#5,D1
	JSR	(__mulu-DT,A4)
	MOVE.W	(-$1E,A5),D2
	MULS.W	#$12,D2
	LEA	(lbL012014-DT,A4),A0
	ADD.L	(A0,D2.L),D0
	MOVE.L	D0,(lbL011AA0-DT,A4)
	MOVE.W	(-$1E,A5),D0
	MULS.W	#$12,D0
	LEA	(lbL012018-DT,A4),A0
	MOVE.W	(lbW0119D4-DT,A4),D1
	MULS.W	(-$20,A5),D1
	MOVE.L	(A0,D0.L),D2
	ADD.L	D1,D2
	MOVE.L	D2,(lbL011A9C-DT,A4)
	MOVEA.L	(lbL011A00-DT,A4),A0
	CMPI.W	#$40,(4,A0)
	BGE.B	lbC005346
	CMPI.B	#5,(-$2B,A5)
	BCC.B	lbC005346
	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.B	(-$2B,A5),D0
	ADDQ.B	#1,(-$2B,A5)
	MOVEQ	#0,D1
	MOVE.B	D0,D1
	ASL.L	#2,D1
	MOVEA.L	(lbL011A98-DT,A4),A1
	MOVE.L	(A1,D1.L),D2
	ADD.L	#$1E00,D2
	MOVE.L	D2,(A0)
	BRA.B	lbC005382

lbC005346	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.L	(-$2A,A5),(A0)
	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.W	(4,A0),D0
	MULS.W	#5,D0
	ADD.L	D0,(-$2A,A5)
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(lbL011A00-DT,A4),A1
	MOVE.W	(4,A1),D0
	MULS.W	#5,D0
	ADD.L	D0,($1A,A0)
	MOVEA.L	(lbL011A04-DT,A4),A0
	CMPI.L	#$1720,($1A,A0)
	bge	lbC0056DE
lbC005382	MOVE.W	(-$42,A5),D0
	EXT.L	D0
	AND.L	#$1F,D0
	MOVE.B	(-$38,A5),D1
	EXT.W	D1
	EXT.L	D1
	JSR	(__mulu-DT,A4)
	ASL.L	#1,D0
	MOVE.W	D0,(lbW0119CE-DT,A4)
	MOVE.B	(-$35,A5),D0
	EXT.W	D0
	EXT.L	D0
	ASR.L	#4,D0
	ASL.L	#1,D0
	MOVE.L	D0,-(SP)
	MOVE.B	(-$39,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.B	(-$36,A5),D1
	EXT.W	D1
	EXT.L	D1
	JSR	(__mulu-DT,A4)
	MOVE.L	(SP)+,D2
	ADD.L	D0,D2
	MOVE.W	D2,(lbW0119D0-DT,A4)
	MOVE.B	(-$33,A5),D0
	EXT.W	D0
	EXT.L	D0
	ASL.L	#1,D0
	MOVE.W	(-$42,A5),D1
	MULS.W	#$28,D1
	ADD.L	D1,D0
	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.W	D0,(8,A0)
	MOVE.W	(-12,A5),D0
	EXT.L	D0
	AND.L	#15,D0
	MOVE.W	D0,(lbW0119CC-DT,A4)
	MOVE.B	(-$35,A5),D0
	AND.B	#15,D0
	BEQ.B	lbC00540E
	MOVEA.L	(lbL011A00-DT,A4),A0
	SUBQ.W	#2,(8,A0)
	CLR.W	(lbW0119D6-DT,A4)
	BRA.B	lbC005414

lbC00540E	MOVE.W	#$FFFF,(lbW0119D6-DT,A4)
lbC005414	MOVE.B	(-$39,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.B	(-$38,A5),D1
	EXT.W	D1
	EXT.L	D1
	ASL.L	#1,D1
	SUB.L	D1,D0
	MOVE.W	D0,(lbW0119D2-DT,A4)
	MOVE.B	(-$38,A5),D0
	EXT.W	D0
	EXT.L	D0
	ASL.L	#1,D0
	MOVEQ	#$28,D1
	SUB.L	D0,D1
	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.W	D1,(10,A0)
	JSR	(_OwnBlitter-DT,A4)
	MOVEA.L	(lbL011A00-DT,A4),A0
	MOVE.L	(A0),-(SP)
	JSR	(_do_blit_4-DT,A4)
	ADDQ.W	#4,SP
	CMPI.W	#5,(-$1E,A5)
	beq	lbC0056A6
	TST.L	D4
	BNE.B	lbC005496
	CMPI.W	#11,(lbW01196A-DT,A4)
	beq	lbC0056A6
	CMPI.W	#$54,(lbW011992-DT,A4)
	beq	lbC0056A6
	CMPI.W	#$5931,(lbW01195A-DT,A4)
	BLS.B	lbC005496
	CMPI.W	#$673C,(lbW01195A-DT,A4)
	BCC.B	lbC005496
	CMPI.W	#$6739,(lbW01195C-DT,A4)
	BLS.B	lbC005496
	CMPI.W	#$679F,(lbW01195C-DT,A4)
	BCS.W	lbC0056A6
lbC005496	CMPI.W	#1,(-$1E,A5)
	BNE.B	lbC0054B0
	CMPI.W	#$63,(-$20,A5)
	BLE.B	lbC0054B0
	CMPI.W	#$66,(-$20,A5)
	blt	lbC0056A6
lbC0054B0	MOVEA.L	(-$1A,A5),A0
	MOVEQ	#0,D0
	MOVE.B	(9,A0),D0
	CMP.L	#$85,D0
	beq	lbC0056A6
	MOVEA.L	(-$1A,A5),A1
	MOVEQ	#0,D1
	MOVE.B	(9,A1),D1
	CMP.L	#$87,D1
	beq	lbC0056A6
	CMPI.W	#1,(-$1E,A5)
	BNE.B	lbC0054E8
	CMPI.W	#8,(-$20,A5)
	BLT.B	lbC0054EE
lbC0054E8	TST.B	(lbB011948-DT,A4)
	BEQ.B	lbC0054F4
lbC0054EE	MOVE.B	#$20,(-$37,A5)
lbC0054F4	MOVE.W	(-$42,A5),D0
	EXT.L	D0
	ASR.L	#5,D0
	MOVE.B	D0,(-$3C,A5)
	MOVE.W	(-$46,A5),D0
	EXT.L	D0
	ASR.L	#5,D0
	MOVEQ	#0,D1
	MOVE.B	(-$3C,A5),D1
	SUB.L	D1,D0
	MOVE.B	D0,(-$3D,A5)
	CLR.B	(-$3A,A5)
	bra	lbC005692

lbC00551C	CLR.B	(-$3B,A5)
	bra	lbC005682

lbC005524	MOVE.W	(-$2E,A5),D0
	EXT.L	D0
	MOVEQ	#0,D1
	MOVE.B	(-$3B,A5),D1
	MOVEQ	#0,D2
	MOVE.B	(-$3C,A5),D2
	ADD.L	D2,D1
	ASL.L	#5,D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$12,A5)
	MOVEQ	#0,D0
	MOVE.B	(-$3A,A5),D0
	MOVE.B	(-$33,A5),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVEQ	#6,D1
	JSR	(__mulu-DT,A4)
	MOVEQ	#0,D2
	MOVE.B	(-$3B,A5),D2
	ADD.L	D2,D0
	MOVEQ	#0,D3
	MOVE.B	(-$3C,A5),D3
	ADD.L	D3,D0
	MOVE.W	D0,(-$30,A5)
	MOVE.W	(-$30,A5),D0
	EXT.L	D0
	ASL.L	#1,D0
	LEA	(lbL01181E-DT,A4),A0
	MOVE.W	(A0,D0.L),D1
	EXT.L	D1
	ASL.L	#2,D1
	MOVE.W	D1,(-$30,A5)
	MOVE.W	(-$30,A5),D0
	EXT.L	D0
	MOVEA.L	D0,A0
	ADDA.L	(buffer_1024-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(1,A0),D1
	AND.L	#15,D1
	MOVE.W	D1,(-4,A5)
	MOVEA.L	(-$1A,A5),A0
	CMPI.B	#$16,($10,A0)
	BNE.B	lbC0055BA
	CMPI.W	#$370,(-$30,A5)
	ble	lbC00567E
	MOVE.W	#3,(-4,A5)
lbC0055BA	MOVE.W	(-4,A5),D0
	EXT.L	D0
	BRA.B	lbC00563A

lbC0055C2	bra	lbC00567E

lbC0055C6	TST.B	(-$3A,A5)
	beq	lbC00567E
	BRA.B	lbC00564C

lbC0055D0	CMPI.W	#$23,(-$12,A5)
	bgt	lbC00567E
	BRA.B	lbC00564C

lbC0055DC	CMPI.W	#$30,(lbW011984-DT,A4)
	BNE.B	lbC0055EE
	CMP.L	#1,D4
	bne	lbC00567E
lbC0055EE	BRA.B	lbC00564C

lbC0055F0	TST.B	(-$3A,A5)
	beq	lbC00567E
	CMPI.W	#$23,(-$12,A5)
	BGT.B	lbC00567E
	BRA.B	lbC00564C

lbC005602	TST.B	(-$3A,A5)
	BNE.B	lbC005610
	CMPI.W	#$23,(-$12,A5)
	BGT.B	lbC00567E
lbC005610	BRA.B	lbC00564C

lbC005612	TST.B	(-$3B,A5)
	BEQ.B	lbC00561E
	MOVE.W	#$100,(-$30,A5)
lbC00561E	BRA.B	lbC00564C

lbC005620	CMPI.W	#$14,(-$12,A5)
	BGT.B	lbC00567E
	BRA.B	lbC00564C

lbW00562A	dw	lbC0055C2-lbC00564A
	dw	lbC0055C6-lbC00564A
	dw	lbC0055D0-lbC00564A
	dw	lbC0055DC-lbC00564A
	dw	lbC0055F0-lbC00564A
	dw	lbC005602-lbC00564A
	dw	lbC005612-lbC00564A
	dw	lbC005620-lbC00564A

lbC00563A	CMP.L	#8,D0
	BCC.B	lbC00564C
	ASL.L	#1,D0
	MOVE.W	(lbW00562A,PC,D0.W),D0
	JMP	(lbC00564A,PC,D0.W)
lbC00564A	EQU	*-2

lbC00564C	MOVE.W	(-$30,A5),D0
	MOVEA.L	(buffer_1024-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.W),D1
	MOVE.L	D1,-(SP)
	MOVE.B	(-$38,A5),D2
	EXT.W	D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	MOVEQ	#0,D3
	MOVE.B	(-$3B,A5),D3
	MOVE.L	D3,-(SP)
	MOVEQ	#0,D3
	MOVE.B	(-$3A,A5),D3
	MOVE.L	D3,-(SP)
	JSR	(lbC00DE02-DT,A4)
	LEA	($10,SP),SP
lbC00567E	ADDQ.B	#1,(-$3B,A5)
lbC005682	MOVE.B	(-$3B,A5),D0
	CMP.B	(-$3D,A5),D0
	BLS.W	lbC005524
	ADDQ.B	#1,(-$3A,A5)
lbC005692	MOVEQ	#0,D0
	MOVE.B	(-$3A,A5),D0
	MOVE.B	(-$38,A5),D1
	EXT.W	D1
	EXT.L	D1
	CMP.L	D1,D0
	BCS.W	lbC00551C
lbC0056A6	JSR	(_do_blit_3-DT,A4)
	JSR	(_do_blit_2-DT,A4)
	MOVEA.L	(-$1A,A5),A0
	MOVE.B	#1,(11,A0)
	JSR	(_DisownBlitter-DT,A4)
	MOVEA.L	(lbL011A04-DT,A4),A0
	ADDQ.W	#1,($10,A0)
lbC0056C4	CMPI.B	#1,(lbB011947-DT,A4)
	beq	lbC004C2E
	ADDQ.W	#1,(-2,A5)
lbC0056D2	MOVE.W	(-2,A5),D0
	CMP.W	(lbW01194C-DT,A4),D0
	blt	lbC004BFC
lbC0056DE	JSR	(_WaitBlit-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW011956-DT,A4),D0
	AND.L	#15,D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.W	D0,(8,A1)
	MOVEQ	#0,D0
	MOVE.W	(lbW011958-DT,A4),D0
	AND.L	#$1F,D0
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.W	D0,(10,A1)
	JSR	(make_display,PC)
	CMPI.B	#3,(lbB011939-DT,A4)
	BNE.B	lbC005722
	JSR	(lbC00DEE0-DT,A4)
	CLR.B	(lbB011939-DT,A4)
lbC005722	bra	lbC0012F0

lbC005726	JSR	(_silence_audio-DT,A4)
lbC00572A	MOVE.L	(active_bitmap_ptr-DT,A4),(active_rp_bitmap_ptr-DT,A4)
	CLR.L	-(SP)
	PEA	(active_rp-DT,A4)
	JSR	(_SetRast-DT,A4)
	ADDQ.W	#8,SP
	JSR	(cleanup,PC)
	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

page0.MSG	db	'progdir:page0',0
p1a.MSG	db	'progdir:p1a',0
p1b.MSG	db	'progdir:p1b',0

lbC005754	MOVEQ	#$32,D0
	dw	$6100
p2b.MSG	db	'progdir:p2b',0
p3a.MSG	db	'progdir:p3a',0
p3b.MSG	db	'progdir:p3b',0
hiscreen.MSG	db	'progdir:hiscreen',0
NoArrows.MSG	db	'No Arrows!',0

errorsaving.MSG	db	'Error saving IFF file!',0
savedok.MSG	db	'Saved IFF file OK',0

	even

lbC005778	LINK.W	A5,#0
	MOVEM.L	D4-D6,-(SP)
	MOVE.W	(10,A5),D4
	MOVE.W	(14,A5),D5
	MOVE.W	($12,A5),D6
	MOVEQ	#0,D0
	MOVE.W	D4,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	SUB.L	D1,D0
	ADD.W	D0,(lbW011956-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW01195C-DT,A4),D1
	SUB.L	D1,D0
	ADD.W	D0,(lbW011958-DT,A4)
	MOVE.W	D4,(lbW01230A-DT,A4)
	MOVE.W	D4,(lbW01195A-DT,A4)
	MOVE.W	D5,(lbW01230C-DT,A4)
	MOVE.W	D5,(lbW01195C-DT,A4)
	CLR.B	(lbB011945-DT,A4)
	TST.W	D6
	BEQ.B	lbC005814
	MOVEQ	#0,D0
	MOVE.W	(lbW011956-DT,A4),D0
	ADD.L	#$97,D0
	LSR.L	#8,D0
	MOVE.W	D0,D4
	MOVEQ	#0,D0
	MOVE.W	(lbW011958-DT,A4),D0
	ADD.L	#$40,D0
	LSR.L	#8,D0
	MOVE.W	D0,D5
	MOVEQ	#0,D0
	MOVE.W	D4,D0
	LSR.L	#6,D0
	AND.L	#1,D0
	MOVE.W	D0,D4
	MOVEQ	#0,D0
	MOVE.W	D5,D0
	LSR.L	#5,D0
	AND.L	#7,D0
	MOVE.W	D0,D5
	MOVEQ	#0,D0
	MOVE.W	D4,D0
	MOVEQ	#0,D1
	MOVE.W	D5,D1
	ADD.L	D1,D0
	MOVEQ	#0,D2
	MOVE.W	D5,D2
	ADD.L	D2,D0
	MOVE.W	D0,(lbW0119C6-DT,A4)
lbC005814	CLR.W	(lbW00EDEC-DT,A4)
	JSR	(lbC007FE8,PC)
	JSR	(lbC006544,PC)
	MOVE.B	#$63,(lbB011939-DT,A4)
	PEA	(1).W
	JSR	(lbC00643C,PC)
	ADDQ.W	#4,SP
lbC005830	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE74-DT,A4)
	LEA	(12,SP),SP
	TST.L	D0
	BEQ.B	lbC005854
	ADDQ.W	#1,(lbW01195C-DT,A4)
	BRA.B	lbC005830

lbC005854	MOVEM.L	(SP)+,D4-D6
	UNLK	A5
	RTS

lbC00585C	LINK.W	A5,#-4
	MOVEM.L	D4/A2,-(SP)
lbC005864	MOVE.W	(lbW011984-DT,A4),D0
	EXT.L	D0
	AND.L	#$FF,D0
	MOVE.W	D0,(lbW011984-DT,A4)
	MOVE.W	D0,(lbW011950-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	LSR.L	#8,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW0119C2-DT,A4),D1
	SUB.L	D1,D0
	AND.L	#$40,D0
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	LSR.L	#8,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW0119C4-DT,A4),D1
	SUB.L	D1,D0
	AND.L	#$20,D0
	CMPI.W	#7,(lbW00ED02-DT,A4)
	BLS.B	lbC0058C2
	LEA	(lbL00F5C2-DT,A4),A0
	MOVEA.L	A0,A2
	LEA	(ascii.MSG22-DT,A4),A0
	MOVE.L	A0,(-4,A5)
	ADDI.W	#$100,(lbW011984-DT,A4)
	BRA.B	lbC0058D0

lbC0058C2	LEA	(lbB00F56B-DT,A4),A0
	MOVEA.L	A0,A2
	LEA	(ascii.MSG21-DT,A4),A0
	MOVE.L	A0,(-4,A5)
lbC0058D0	MOVEQ	#0,D4
lbC0058D2	MOVE.W	(lbW011950-DT,A4),D0
	EXT.L	D0
	MOVEQ	#0,D1
	MOVE.B	(A2),D1
	CMP.L	D1,D0
	BCS.B	lbC0058F0
	MOVE.W	(lbW011950-DT,A4),D2
	EXT.L	D2
	MOVEQ	#0,D3
	MOVE.B	(1,A2),D3
	CMP.L	D3,D2
	BLS.B	lbC0058FC
lbC0058F0	ADDQ.L	#3,A2
	ADDQ.L	#1,D4
	CMP.L	#$100,D4
	BLT.B	lbC0058D2
lbC0058FC	MOVEQ	#0,D0
	MOVE.B	(2,A2),D0
	MOVE.L	D0,D4
	CMP.L	#4,D4
	BNE.B	lbC00592C
	CMPI.W	#7,(lbW00ED02-DT,A4)
	BLS.B	lbC005916
	BRA.B	lbC00592C

lbC005916	BTST	#0,(lbB00ED03-DT,A4)
	BEQ.B	lbC005922
	MOVEQ	#0,D4
	BRA.B	lbC00592C

lbC005922	CMPI.W	#3,(lbW00ED02-DT,A4)
	BLS.B	lbC00592C
	MOVEQ	#5,D4
lbC00592C	CMPI.W	#10,(lbW0119C6-DT,A4)
	BCS.B	lbC005960
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	LSR.L	#8,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW0119C2-DT,A4),D1
	SUB.L	D1,D0
	BTST	#6,D0
	BNE.B	lbC005960
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	LSR.L	#8,D0
	MOVEQ	#0,D2
	MOVE.W	(lbW0119C4-DT,A4),D2
	SUB.L	D2,D0
	BTST	#5,D0
	BEQ.B	lbC005962
lbC005960	MOVEQ	#0,D4
lbC005962	TST.L	D4
	BEQ.B	lbC005986
	MOVEQ	#0,D0
	MOVE.W	(lbW011986-DT,A4),D0
	CMP.L	D4,D0
	BEQ.B	lbC005986
	MOVE.W	D4,(lbW011986-DT,A4)
	TST.W	(10,A5)
	BEQ.B	lbC005986
	MOVE.L	D4,-(SP)
	MOVE.L	(-4,A5),-(SP)
	JSR	(lbC00DEBC-DT,A4)
	ADDQ.W	#8,SP
lbC005986	LEA	(lbW00E67E-DT,A4),A0
	MOVE.L	A0,(lbL0119F8-DT,A4)
	MOVEQ	#0,D4
lbC005990	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVE.W	(lbW01195A-DT,A4),D0
	CMP.W	(A0),D0
	BLS.B	lbC0059C6
	MOVEA.L	(lbL0119F8-DT,A4),A1
	MOVE.W	(lbW01195A-DT,A4),D1
	CMP.W	(4,A1),D1
	BCC.B	lbC0059C6
	MOVEA.L	(lbL0119F8-DT,A4),A6
	MOVE.W	(lbW01195C-DT,A4),D2
	CMP.W	(2,A6),D2
	BLS.B	lbC0059C6
	MOVEA.L	(lbL0119F8-DT,A4),A6
	MOVE.W	(lbW01195C-DT,A4),D3
	CMP.W	(6,A6),D3
	BCS.B	lbC0059D8
lbC0059C6	ADDI.L	#12,(lbL0119F8-DT,A4)
	ADDQ.L	#1,D4
	CMP.L	#$16,D4
	BLT.B	lbC005990
lbC0059D8	MOVEQ	#0,D0
	MOVE.W	(lbW011992-DT,A4),D0
	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(8,A0),D1
	CMP.L	D1,D0
	beq	lbC005B2E
	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.B	(8,A0),D0
	MOVE.W	D0,(lbW011992-DT,A4)
	CMPI.W	#$53,(lbW011992-DT,A4)
	BNE.B	lbC005A16
	TST.B	(lbB0113D1-DT,A4)
	BEQ.B	lbC005A16
	JSR	(lbC00DF5E-DT,A4)
	CLR.W	(10,A5)
	bra	lbC005864

lbC005A16	CMPI.W	#$3C,(lbW011992-DT,A4)
	BCS.B	lbC005A80
	CMPI.W	#$3C,(lbW011992-DT,A4)
	BEQ.B	lbC005A2E
	CMPI.W	#$3D,(lbW011992-DT,A4)
	BNE.B	lbC005A7C
lbC005A2E	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVE.B	(lbB012355-DT,A4),D0
	CMP.B	(11,A0),D0
	BNE.B	lbC005A44
	CMPI.W	#4,(lbW01194A-DT,A4)
	BGE.B	lbC005A7C
lbC005A44	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	MOVEA.L	(lbL0119F8-DT,A4),A1
	MOVEQ	#0,D1
	MOVE.W	(4,A1),D1
	ADD.L	D1,D0
	LSR.L	#1,D0
	MOVE.W	D0,(lbW0119BA-DT,A4)
	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVEA.L	(lbL0119F8-DT,A4),A1
	MOVEQ	#0,D1
	MOVE.W	(6,A1),D1
	ADD.L	D1,D0
	LSR.L	#1,D0
	MOVE.W	D0,(lbW0119BC-DT,A4)
	BRA.B	lbC005AC4

lbC005A7C	bra	lbC005B2E

lbC005A80	CMPI.W	#$34,(lbW011992-DT,A4)
	BNE.B	lbC005AA8
	MOVE.W	#8,(lbW01199E-DT,A4)
	JSR	(lbC005B7E,PC)
	PEA	(2).W
	JSR	(_wait_for_trackdisk_8-DT,A4)
	ADDQ.W	#4,SP
;	JSR	(_trackdisk_motor_off-DT,A4)
	CLR.B	(lbB01193C-DT,A4)
	bra	lbC005B2E

lbC005AA8	CMPI.W	#$32,(lbW011992-DT,A4)
	BCS.B	lbC005B2E
	CMPI.W	#1,(10,A5)
	BNE.B	lbC005B2E
	MOVE.W	(lbW01195A-DT,A4),(lbW0119BA-DT,A4)
	MOVE.W	(lbW01195C-DT,A4),(lbW0119BC-DT,A4)
lbC005AC4	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.B	(11,A0),D0
	MOVE.W	D0,(lbW01199E-DT,A4)
	CLR.W	(lbW0119C0-DT,A4)
	CLR.W	(lbW0119BE-DT,A4)
	JSR	(lbC005B7E,PC)
	PEA	(2).W
	JSR	(_wait_for_trackdisk_8-DT,A4)
	ADDQ.W	#4,SP
;	JSR	(_trackdisk_motor_off-DT,A4)
	CLR.B	(lbB01193C-DT,A4)
	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVE.B	(9,A0),(lbB011945-DT,A4)
	MOVE.W	#3,(lbW01194A-DT,A4)
lbC005B00	TST.B	(lbB011945-DT,A4)
	BEQ.B	lbC005B2E
	CMPI.W	#7,(lbW01194A-DT,A4)
	BGE.B	lbC005B2E
	PEA	($3F).W
	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC005C00,PC)
	ADDQ.W	#8,SP
	TST.L	D0
	BEQ.B	lbC005B28
	ADDQ.W	#1,(lbW01194A-DT,A4)
lbC005B28	SUBQ.B	#1,(lbB011945-DT,A4)
	BRA.B	lbC005B00

lbC005B2E	CMPI.W	#$46,(lbW011992-DT,A4)
	BCC.B	lbC005B3C
	CLR.W	(lbW011990-DT,A4)
	BRA.B	lbC005B76

lbC005B3C	CMPI.W	#$46,(lbW011992-DT,A4)
	BNE.B	lbC005B76
	TST.W	(lbW011990-DT,A4)
	BEQ.B	lbC005B64
	TST.W	(lbW01196A-DT,A4)
	BNE.B	lbC005B76
	MOVE.W	(lbW01198C-DT,A4),D0
	EXT.L	D0
	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(11,A0),D1
	CMP.L	D1,D0
	BEQ.B	lbC005B76
lbC005B64	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.B	(11,A0),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC005EBA,PC)
	ADDQ.W	#4,SP
lbC005B76	MOVEM.L	(SP)+,D4/A2
	UNLK	A5
	RTS

lbC005B7E	LINK.W	A5,#0
	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.B	(10,A0),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDCC-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL0119F8-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(9,A0),D1
	ADD.L	D1,D0
	MOVE.B	D0,(lbB011945-DT,A4)
	MOVE.W	(lbW01198C-DT,A4),D0
	EXT.L	D0
	MOVE.W	(lbW01199E-DT,A4),D1
	MULU.W	#6,D1
	LEA	(lbB00E165-DT,A4),A0
	MOVE.B	(A0,D1.L),D2
	EXT.W	D2
	EXT.L	D2
	CMP.L	D2,D0
	BEQ.B	lbC005BFC
	MOVE.W	(lbW01199E-DT,A4),D0
	MULU.W	#6,D0
	LEA	(lbB00E165-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	MOVE.W	D1,(lbW01198C-DT,A4)
	MOVE.W	#3,(lbW01194A-DT,A4)
	MOVE.L	(lbL012038-DT,A4),(trackdisk_buffer_ptr-DT,A4)
	MOVE.W	(lbW01198C-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(_trackdisk_read_2-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	#1,(lbB01193C-DT,A4)
	CLR.W	(lbW011990-DT,A4)
lbC005BFC	UNLK	A5
	RTS

lbC005C00	LINK.W	A5,#-4
	MOVEM.L	D4-D6/A2,-(SP)
	MOVE.W	(10,A5),D0
	MULU.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	MOVEA.L	(lbL0119F8-DT,A4),A0
	CMPI.B	#7,(11,A0)
	BNE.B	lbC005C34
	MOVE.W	#$5483,(-2,A5)
	MOVE.W	#$64A2,(-4,A5)
	bra	lbC005CD4

lbC005C34	MOVEQ	#0,D6
lbC005C36	MOVEQ	#0,D0
	MOVE.W	(14,A5),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#0,D1
	MOVE.W	(lbW0119BA-DT,A4),D1
	ADD.L	D1,D0
	MOVEQ	#0,D2
	MOVE.W	(14,A5),D2
	LSR.L	#1,D2
	SUB.L	D2,D0
	MOVE.W	D0,(-2,A5)
	MOVEQ	#0,D0
	MOVE.W	(14,A5),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#0,D1
	MOVE.W	(lbW0119BC-DT,A4),D1
	ADD.L	D1,D0
	MOVEQ	#0,D2
	MOVE.W	(14,A5),D2
	LSR.L	#1,D2
	SUB.L	D2,D0
	MOVE.W	D0,(-4,A5)
	MOVEQ	#0,D0
	MOVE.W	(10,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-4,A5),D1
	MOVE.L	D1,-(SP)
	MOVEQ	#0,D2
	MOVE.W	(-2,A5),D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DE74-DT,A4)
	LEA	(12,SP),SP
	TST.L	D0
	BEQ.B	lbC005CD4
	CMPI.W	#$34,(lbW011992-DT,A4)
	BNE.B	lbC005CC8
	MOVEQ	#0,D0
	MOVE.W	(-4,A5),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-2,A5),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#7,D0
	BEQ.B	lbC005CD4
lbC005CC8	ADDQ.L	#1,D6
	CMP.L	#15,D6
	blt	lbC005C36
lbC005CD4	CMP.L	#15,D6
	BNE.B	lbC005CE6
	MOVEQ	#0,D0
lbC005CDE	MOVEM.L	(SP)+,D4-D6/A2
	UNLK	A5
	RTS

lbC005CE6	MOVE.W	(-2,A5),(A2)
	MOVE.W	(-4,A5),(2,A2)
	MOVE.B	#2,(8,A2)
	BTST	#1,(lbB0119BF-DT,A4)
	BEQ.B	lbC005D20
	CMPI.W	#4,(lbW01199E-DT,A4)
	BEQ.B	lbC005D20
	MOVEQ	#0,D0
	MOVE.W	(lbW01199E-DT,A4),D0
	AND.L	#$FFFE,D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDAE-DT,A4)
	MOVE.L	(SP)+,D1
	MOVE.L	D1,D4
	ADD.L	D0,D4
	BRA.B	lbC005D28

lbC005D20	MOVEQ	#0,D0
	MOVE.W	(lbW01199E-DT,A4),D0
	MOVE.L	D0,D4
lbC005D28	MOVE.B	D4,(9,A2)
	BTST	#2,(lbB0119BF-DT,A4)
	BEQ.B	lbC005D3C
	JSR	(lbC00DDB4-DT,A4)
	MOVE.W	D0,(lbW0119C0-DT,A4)
lbC005D3C	MOVEQ	#6,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E162-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	EXT.L	D2
	ASL.L	#2,D2
	MOVE.W	(lbW0119C0-DT,A4),D3
	EXT.L	D3
	MOVE.L	D2,D5
	ADD.L	D3,D5
	LEA	(lbL010EDA-DT,A4),A0
	MOVE.B	(A0,D5.L),(12,A2)
	MOVE.B	#13,($10,A2)
	CLR.B	($11,A2)
	CLR.B	(13,A2)
	BTST	#2,(12,A2)
	BEQ.B	lbC005D94
	MOVEQ	#6,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E163-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	ADDQ.B	#3,D2
	MOVE.B	D2,(14,A2)
	BRA.B	lbC005DAA

lbC005D94	MOVEQ	#6,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E163-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	ADDQ.B	#1,D2
	MOVE.B	D2,(14,A2)
lbC005DAA	MOVEQ	#6,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW00E160-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	MOVE.W	D2,($12,A2)
	MOVEQ	#0,D0
	MOVE.W	(A2),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	SUB.L	D1,D0
	SUBQ.L	#8,D0
	MOVE.W	D0,(4,A2)
	MOVEQ	#0,D0
	MOVE.W	(2,A2),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011958-DT,A4),D1
	SUB.L	D1,D0
	SUB.L	#$1A,D0
	MOVE.W	D0,(6,A2)
	MOVEQ	#1,D0
	bra	lbC005CDE

lbC005DF0	LINK.W	A5,#0
	MOVEM.L	D4/D5/A2,-(SP)
	MOVE.L	(8,A5),D4
	MOVE.L	(12,A5),D5
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	CMPI.W	#1,($12,A2)
	bge	lbC005EA4
	CMPI.B	#14,($10,A2)
	beq	lbC005EA4
	CMPI.B	#15,($10,A2)
	BEQ.B	lbC005EA4
	CLR.W	($12,A2)
	MOVE.B	#7,(15,A2)
	MOVE.B	#7,(14,A2)
	MOVE.B	#14,($10,A2)
	CMPI.B	#7,(9,A2)
	BNE.B	lbC005E56
	PEA	($2A).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC005E70

lbC005E56	CMPI.B	#4,(8,A2)
	BNE.B	lbC005E70
	MOVEQ	#0,D0
	MOVE.B	(9,A2),D0
	CMP.L	#$89,D0
	BEQ.B	lbC005E70
	SUBQ.W	#3,(lbW011978-DT,A4)
lbC005E70	TST.L	D4
	BEQ.B	lbC005E7A
	ADDQ.W	#1,(lbW011974-DT,A4)
	BRA.B	lbC005E90

lbC005E7A	MOVE.L	D5,-(SP)
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	SUBQ.W	#5,(lbW011976-DT,A4)
	PEA	(1).W
	JSR	(lbC00643C,PC)
	ADDQ.W	#4,SP
lbC005E90	TST.W	(lbW011978-DT,A4)
	BGE.B	lbC005E9A
	CLR.W	(lbW011978-DT,A4)
lbC005E9A	PEA	(7).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
lbC005EA4	TST.L	D4
	BNE.B	lbC005EB2
	PEA	(4).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
lbC005EB2	MOVEM.L	(SP)+,D4/D5/A2
	UNLK	A5
	RTS

lbC005EBA	LINK.W	A5,#0
	MOVEM.L	D4/A2,-(SP)
	LEA	(lbW01234C-DT,A4),A0
	MOVEA.L	A0,A2
	CMPI.W	#10,(10,A5)
	BNE.B	lbC005ED8
	MOVE.B	#6,(8,A2)
	BRA.B	lbC005EDE

lbC005ED8	MOVE.B	#5,(8,A2)
lbC005EDE	CMPI.W	#10,(10,A5)
	BNE.B	lbC005EEA
	MOVEQ	#2,D4
	BRA.B	lbC005EF8

lbC005EEA	CMPI.W	#5,(10,A5)
	BNE.B	lbC005EF6
	MOVEQ	#1,D4
	BRA.B	lbC005EF8

lbC005EF6	MOVEQ	#0,D4
lbC005EF8	MOVE.W	(lbW01198C-DT,A4),D0
	CMP.W	(10,A5),D0
	BEQ.B	lbC005F2A
	MOVE.L	(lbL012038-DT,A4),(trackdisk_buffer_ptr-DT,A4)
	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(_trackdisk_read_2-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	(8,A2),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(_wait_for_trackdisk_8-DT,A4)
	ADDQ.W	#4,SP
;	JSR	(_trackdisk_motor_off-DT,A4)
lbC005F2A	MOVEQ	#12,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW00E67E-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D0.L),D2
	ADD.L	#$FA,D2
	MOVE.W	D2,(A2)
	MOVEQ	#12,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E680-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D0.L),D2
	ADD.L	#$C8,D2
	MOVE.W	D2,(2,A2)
	CLR.B	(13,A2)
	CLR.B	(12,A2)
	CLR.B	(10,A2)
	MOVE.B	#13,($10,A2)
	MOVE.W	#$32,($12,A2)
	MOVE.W	#4,(lbW01194A-DT,A4)
	MOVE.W	(10,A5),(lbW011990-DT,A4)
	MOVE.W	(10,A5),(lbW01198C-DT,A4)
	MOVE.B	(11,A5),(9,A2)
	MOVEM.L	(SP)+,D4/A2
	UNLK	A5
	RTS

lbC005F98	LINK.W	A5,#0
	MOVEM.L	A2/A3,-(SP)
	LEA	(lbL012320-DT,A4),A0
	MOVEA.L	A0,A3
	MOVE.B	#3,(8,A3)
	MOVE.W	#$3564,(A3)
	MOVE.W	#$3886,(2,A3)
	CLR.B	(13,A3)
	CLR.B	(12,A3)
	CLR.B	(10,A3)
	LEA	(lbW012336-DT,A4),A0
	MOVEA.L	A0,A3
	MOVE.B	#4,(8,A3)
	MOVE.W	#$3564,(A3)
	MOVE.W	#$3A98,(2,A3)
	CLR.B	(12,A3)
	CLR.B	(10,A3)
	LEA	(lbW01230A-DT,A4),A0
	MOVEA.L	A0,A3
	CLR.B	(8,A3)
	CLR.B	(14,A3)
	CLR.B	(lbB012113-DT,A4)
	CLR.B	(lbB012112-DT,A4)
	CLR.W	(lbW01194E-DT,A4)
	CLR.B	(lbB011943-DT,A4)
	CLR.B	(lbB01193E-DT,A4)
	TST.W	(10,A5)
	beq	lbC0062C0
	JSR	(_silence_audio-DT,A4)
	TST.W	(lbW011980-DT,A4)
	BLE.B	lbC00606A
	CMPI.W	#3,(lbW011980-DT,A4)
	BGE.B	lbC00606A
	MOVE.W	(lbW011980-DT,A4),D0
	MULS.W	#6,D0
	LEA	(lbW0110BA-DT,A4),A0
	MOVE.W	(lbW01195A-DT,A4),(A0,D0.L)
	MOVE.W	(lbW011980-DT,A4),D0
	MULS.W	#6,D0
	LEA	(lbW0110BC-DT,A4),A0
	MOVE.W	(lbW01195C-DT,A4),(A0,D0.L)
	MOVE.W	(lbW011980-DT,A4),D0
	MULS.W	#6,D0
	LEA	(lbB0110BF-DT,A4),A0
	MOVE.B	#1,(A0,D0.L)
	MOVE.W	(lbW011980-DT,A4),D0
	EXT.L	D0
	ADDQ.L	#2,D0
	MOVEQ	#6,D1
	JSR	(__mulu-DT,A4)
	LEA	(lbB0110BF-DT,A4),A0
	MOVE.B	#3,(A0,D0.L)
lbC00606A	MOVE.B	#3,(lbB0113D1-DT,A4)
	MOVE.W	(lbW011980-DT,A4),D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbL00EE86-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	MOVE.B	(A2),D0
	EXT.W	D0
	MOVE.W	D0,(lbW011974-DT,A4)
	MOVE.B	(1,A2),D0
	EXT.W	D0
	MOVE.W	D0,(lbW011976-DT,A4)
	MOVE.B	(2,A2),D0
	EXT.W	D0
	MOVE.W	D0,(lbW011978-DT,A4)
	MOVE.B	(3,A2),D0
	EXT.W	D0
	MOVE.W	D0,(lbW01197A-DT,A4)
	MOVE.L	(4,A2),(lbL0119FC-DT,A4)
	ADDQ.W	#1,(lbW011980-DT,A4)
	CLR.L	(lbL011A2C-DT,A4)
lbC0060B4	MOVE.L	(lbL011A2C-DT,A4),D0
	MOVEA.L	(lbL0119FC-DT,A4),A0
	CLR.B	(A0,D0.L)
	ADDQ.L	#1,(lbL011A2C-DT,A4)
	CMPI.L	#$1F,(lbL011A2C-DT,A4)
	BLT.B	lbC0060B4
	MOVE.B	#1,(12,A3)
	MOVEA.L	(lbL0119FC-DT,A4),A0
	MOVE.B	#1,(A0)
	CLR.W	(lbW01199A-DT,A4)
	CLR.W	(lbW011998-DT,A4)
	CLR.W	(lbW011996-DT,A4)
	MOVE.W	#$4A5C,(lbW01195E-DT,A4)
	MOVE.W	#$3D8B,(lbW011960-DT,A4)
	MOVE.W	#3,(lbW011962-DT,A4)
	MOVE.W	#3,(lbW00ED02-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW011960-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195E-DT,A4),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE26-DT,A4)
	ADDQ.W	#8,SP
	MOVE.B	#$63,(lbB011939-DT,A4)
	MOVE.B	#1,(lbB01193B-DT,A4)
	CLR.B	(lbB01193C-DT,A4)
	JSR	(lbC00DECE-DT,A4)
	MOVE.L	(font_ptr-DT,A4),-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetFont-DT,A4)
	ADDQ.W	#8,SP
	CMPI.W	#1,(lbW011980-DT,A4)
	BNE.B	lbC00616E
	CLR.L	-(SP)
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(rp1_bitmap_ptr-DT,A4)
	CLR.L	-(SP)
	PEA	(rp1-DT,A4)
	JSR	(_SetRast-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	(lbL011A08-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(rp1_bitmap_ptr-DT,A4)
	BRA.B	lbC0061A0

lbC00616E	CMPI.W	#2,(lbW011980-DT,A4)
	BNE.B	lbC006182
	PEA	(1).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0061A0

lbC006182	CMPI.W	#3,(lbW011980-DT,A4)
	BNE.B	lbC006196
	PEA	(3).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0061A0

lbC006196	PEA	(5).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
lbC0061A0	JSR	(lbC00DDD8-DT,A4)
	PEA	($78).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	CMPI.W	#3,(lbW011980-DT,A4)
	BLE.B	lbC0061C8
	MOVE.B	#1,(lbB011940-DT,A4)
	PEA	($1F4).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC006242

lbC0061C8	CMPI.W	#1,(lbW011980-DT,A4)
	BLE.B	lbC006242
	PEA	($50).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	CLR.L	-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	PEA	($6B).W
	PEA	($10F).W
	PEA	(13).W
	PEA	(13).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_RectFill-DT,A4)
	LEA	($14,SP),SP
	PEA	(10).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	PEA	($18).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	CMPI.W	#2,(lbW011980-DT,A4)
	BNE.B	lbC00622E
	PEA	(2).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC006238

lbC00622E	PEA	(4).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
lbC006238	PEA	($78).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
lbC006242	MOVE.L	(lbL011A4C-DT,A4),-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetFont-DT,A4)
	ADDQ.W	#8,SP
	LEA	(active_rp-DT,A4),A0
	MOVE.L	A0,(active_rp_ptr-DT,A4)
	MOVE.W	#6,(lbW01198C-DT,A4)
	MOVE.W	#13,(lbW01198E-DT,A4)
	JSR	(_trackdisk_read_3-DT,A4)
	CMPI.W	#4,(lbW011980-DT,A4)
	BGE.B	lbC0062BE
	JSR	(lbC00DED4-DT,A4)
	MOVE.W	#2,(lbW011986-DT,A4)
	PEA	(9).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	CMPI.W	#1,(lbW011980-DT,A4)
	BNE.B	lbC006298
	PEA	(ascii.MSG,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0062BE

lbC006298	CMPI.W	#2,(lbW011980-DT,A4)
	BNE.B	lbC0062AC
	PEA	(10).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0062BE

lbC0062AC	CMPI.W	#3,(lbW011980-DT,A4)
	BNE.B	lbC0062BE
	PEA	(11).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC0062BE	BRA.B	lbC0062C4

lbC0062C0	JSR	(lbC00DEDA-DT,A4)
lbC0062C4	MOVE.W	(lbW01195E-DT,A4),(A3)
	MOVE.W	(A3),(lbW01195A-DT,A4)
	MOVE.W	(lbW011960-DT,A4),(2,A3)
	MOVE.W	(2,A3),(lbW01195C-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	SUB.L	#$90,D0
	MOVE.W	D0,(lbW011956-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	SUB.L	#$5A,D0
	MOVE.W	D0,(lbW011958-DT,A4)
	MOVE.W	(lbW011962-DT,A4),(lbW0119C6-DT,A4)
	JSR	(lbC007FE8,PC)
	MOVE.W	(lbW011974-DT,A4),D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	ADD.L	#15,D0
	MOVE.W	D0,($12,A3)
	CLR.B	(13,A3)
	MOVE.B	#13,($10,A3)
	MOVE.B	#$FF,(9,A3)
	MOVE.W	#$1F40,(lbW011988-DT,A4)
	MOVE.W	#$12C,(lbW01198A-DT,A4)
	CLR.W	(lbW01197E-DT,A4)
	CLR.W	(lbW01197C-DT,A4)
	MOVE.W	#3,(lbW01194A-DT,A4)
	JSR	(lbC007F3A,PC)
	PEA	(7).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	PEA	(4).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	CMPI.W	#3,(lbW011980-DT,A4)
	BLE.B	lbC00636A
	MOVE.B	#2,(lbB011939-DT,A4)
	BRA.B	lbC00637A

lbC00636A	MOVE.B	#3,(lbB011939-DT,A4)
	PEA	(1).W
	JSR	(lbC00643C,PC)
	ADDQ.W	#4,SP
lbC00637A	CLR.W	(lbW011992-DT,A4)
	CLR.B	(lbB011936-DT,A4)
	MOVEM.L	(SP)+,A2/A3
	UNLK	A5
	RTS

ascii.MSG	db	'.',0

make_display_2	LINK.W	A5,#0
	MOVEM.L	D4/D5,-(SP)
	MOVE.L	(8,A5),D4
	MOVEQ	#5,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	MOVEQ	#8,D1
	JSR	(__divs-DT,A4)
	MOVE.L	D0,D5
	PEA	(1).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	#160,D0
	SUB.L	D4,D0
	MOVE.W	D0,(viewport1_dxoffset-DT,A4)
	MOVE.W	D0,(rasinfo1_rxoffset-DT,A4)
	MOVE.W	D0,(rasinfo3_rxoffset-DT,A4)
	MOVE.L	D4,D0
	ADD.L	D4,D0
	MOVE.W	D0,(viewport1_dwidth-DT,A4)
	MOVEQ	#100,D0
	SUB.L	D5,D0
	MOVE.W	D0,(viewport1_dyoffset-DT,A4)
	MOVE.W	D0,(rasinfo1_ryoffset-DT,A4)
	MOVE.W	D0,(rasinfo3_ryoffset-DT,A4)
	MOVE.L	D5,D0
	ADD.L	D5,D0
	MOVE.W	D0,(viewport1_dheight-DT,A4)
	CLR.W	(viewport2_dyoffset-DT,A4)
	CLR.W	(viewport2_dxoffset-DT,A4)
	MOVEQ	#95,D0
	SUB.L	D5,D0
	MOVE.W	D0,(viewport2_dheight-DT,A4)
	PEA	(lbL00EA1C-DT,A4)
	CLR.L	-(SP)
	MOVE.L	D5,D0
	ASL.L	#1,D0
	MOVEA.L	D0,A0
	PEA	(-$64,A0)
	MOVE.L	D5,D0
	ASL.L	#1,D0
	MOVEA.L	D0,A1
	PEA	(-$46,A1)
	MOVE.L	D5,D0
	ASL.L	#1,D0
	MOVEA.L	D0,A6
	PEA	(-$28,A6)
	JSR	(lbC00DE86-DT,A4)
	LEA	($14,SP),SP
	PEA	(viewport2-DT,A4)
	PEA	(view-DT,A4)
	JSR	(_MakeVPort-DT,A4)
	ADDQ.W	#8,SP
	JSR	(make_display,PC)
	MOVEM.L	(SP)+,D4/D5
	UNLK	A5
	RTS

lbC00643C	LINK.W	A5,#0
	MOVE.L	D4,-(SP)
	TST.W	(lbW01231C-DT,A4)
	BNE.B	lbC00644C
	MOVEQ	#$18,D4
	BRA.B	lbC0064AA

lbC00644C	CMPI.W	#$2400,(lbW01195A-DT,A4)
	BLS.B	lbC006470
	CMPI.W	#$3100,(lbW01195A-DT,A4)
	BCC.B	lbC006470
	CMPI.W	#$8200,(lbW01195C-DT,A4)
	BLS.B	lbC006470
	CMPI.W	#$8A00,(lbW01195C-DT,A4)
	BCC.B	lbC006470
	MOVEQ	#$10,D4
	BRA.B	lbC0064AA

lbC006470	TST.B	(lbB01193E-DT,A4)
	BEQ.B	lbC00647A
	MOVEQ	#4,D4
	BRA.B	lbC0064AA

lbC00647A	CMPI.W	#7,(lbW00ED02-DT,A4)
	BLS.B	lbC00649C
	MOVEQ	#$14,D4
	CMPI.W	#9,(lbW00ED02-DT,A4)
	BNE.B	lbC006494
	MOVE.W	#$307,(lbW00EDDE-DT,A4)
	BRA.B	lbC00649A

lbC006494	MOVE.W	#$100,(lbW00EDDE-DT,A4)
lbC00649A	BRA.B	lbC0064AA

lbC00649C	CMPI.W	#$78,(lbW01198A-DT,A4)
	BLS.B	lbC0064A8
	MOVEQ	#0,D4
	BRA.B	lbC0064AA

lbC0064A8	MOVEQ	#8,D4
lbC0064AA	BTST	#0,(lbB00EC02-DT,A4)
	beq	lbC00653A
	TST.B	(11,A5)
	BEQ.B	lbC0064FA
	MOVE.L	D4,D0
	ADDQ.L	#3,D0
	ASL.L	#2,D0
	LEA	(lbL01208C-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	MOVE.L	D4,D1
	ADDQ.L	#2,D1
	ASL.L	#2,D1
	LEA	(lbL01208C-DT,A4),A1
	MOVE.L	(A1,D1.L),-(SP)
	MOVE.L	D4,D2
	ADDQ.L	#1,D2
	ASL.L	#2,D2
	LEA	(lbL01208C-DT,A4),A6
	MOVE.L	(A6,D2.L),-(SP)
	MOVE.L	D4,D3
	ASL.L	#2,D3
	LEA	(lbL01208C-DT,A4),A6
	MOVE.L	(A6,D3.L),-(SP)
	JSR	(_init_aud_2-DT,A4)
	LEA	($10,SP),SP
	BRA.B	lbC006538

lbC0064FA	MOVE.L	D4,D0
	ADDQ.L	#3,D0
	ASL.L	#2,D0
	LEA	(lbL01208C-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	MOVE.L	D4,D1
	ADDQ.L	#2,D1
	ASL.L	#2,D1
	LEA	(lbL01208C-DT,A4),A1
	MOVE.L	(A1,D1.L),-(SP)
	MOVE.L	D4,D2
	ADDQ.L	#1,D2
	ASL.L	#2,D2
	LEA	(lbL01208C-DT,A4),A6
	MOVE.L	(A6,D2.L),-(SP)
	MOVE.L	D4,D3
	ASL.L	#2,D3
	LEA	(lbL01208C-DT,A4),A6
	MOVE.L	(A6,D3.L),-(SP)
	JSR	(lbC00DF94-DT,A4)
	LEA	($10,SP),SP
lbC006538	BRA.B	lbC00653E

lbC00653A	JSR	(_silence_audio-DT,A4)
lbC00653E	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

lbC006544	LINK.W	A5,#0
	MOVEM.L	D4-D7,-(SP)
	CMPI.W	#8,(lbW00ED02-DT,A4)
	BCC.W	lbC0065F6
	CMPI.W	#10,(lbW0119C6-DT,A4)
	BCC.B	lbC00659E
	MOVEQ	#0,D0
	MOVE.W	(lbW011956-DT,A4),D0
	MOVE.L	D0,D6
	AND.L	#$3FFF,D6
	MOVEQ	#0,D0
	MOVE.W	(lbW011958-DT,A4),D0
	MOVE.L	D0,D7
	AND.L	#$1FFF,D7
	CMP.L	#$6D,D7
	BLE.B	lbC00659E
	CMP.L	#$1F00,D7
	BGE.B	lbC00659E
	CMP.L	#$3F1C,D6
	BGT.B	lbC00659A
	CMP.L	#$3F00,D6
	BGE.B	lbC00659E
lbC00659A	JSR	(lbC007FE8,PC)
lbC00659E	MOVEQ	#0,D0
	MOVE.W	(lbW011956-DT,A4),D0
	ADD.L	#$97,D0
	MOVE.L	D0,D6
	LSR.L	#8,D6
	MOVEQ	#0,D0
	MOVE.W	(lbW011958-DT,A4),D0
	ADD.L	#$40,D0
	MOVE.L	D0,D7
	LSR.L	#8,D7
	MOVE.L	D6,D0
	ASR.L	#6,D0
	MOVE.L	D0,D4
	AND.L	#1,D4
	MOVE.L	D7,D0
	ASR.L	#5,D0
	MOVE.L	D0,D5
	AND.L	#3,D5
	MOVE.L	D4,D0
	ADD.L	D5,D0
	ADD.L	D5,D0
	MOVE.W	D0,(lbW0119C8-DT,A4)
	MOVE.W	(lbW0119C8-DT,A4),D0
	CMP.W	(lbW00ED02-DT,A4),D0
	BEQ.B	lbC0065F4
	MOVE.W	(lbW0119C8-DT,A4),(lbW0119C6-DT,A4)
	JSR	(lbC007FE8,PC)
lbC0065F4	BRA.B	lbC0065FC

lbC0065F6	MOVE.W	(lbW00ED02-DT,A4),(lbW0119C8-DT,A4)
lbC0065FC
;	PEA	(trackdisk_io_2-DT,A4)
;	JSR	(_CheckIO-DT,A4)	;!****************
;	ADDQ.W	#4,SP
;	TST.L	D0
;	BEQ.B	lbC006618
;	PEA	(trackdisk_io_array-DT,A4)
;	JSR	(_CheckIO-DT,A4)	;!*****************
;	ADDQ.W	#4,SP
;	TST.L	D0
;	BNE.B	lbC006620
;lbC006618	CMPI.W	#10,(lbW0119C6-DT,A4)
;	BCS.B	lbC006652
lbC006620	MOVEQ	#0,D0
	MOVE.W	(lbW0119C8-DT,A4),D0
	MOVE.L	D0,D5
	LSR.L	#1,D5
	MOVEQ	#0,D0
	MOVE.W	(lbW0119C8-DT,A4),D0
	MOVE.L	D0,D4
	AND.L	#1,D4
	CMPI.W	#7,(lbW0119C8-DT,A4)
	BLS.B	lbC006642
	MOVEQ	#0,D4
lbC006642	MOVE.L	D4,D0
	ASL.L	#6,D0
	MOVE.W	D0,(lbW0119C2-DT,A4)
	MOVE.L	D5,D0
	ASL.L	#5,D0
	MOVE.W	D0,(lbW0119C4-DT,A4)
lbC006652	MOVEQ	#0,D0
	MOVE.W	(lbW011966-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW011964-DT,A4),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DE0E-DT,A4)
	ADDQ.W	#8,SP
	MOVEM.L	(SP)+,D4-D7
	UNLK	A5
	RTS

make_display	LINK.W	A5,#0
	MOVE.L	A2,-(SP)
	MOVEA.L	(lbL011A04-DT,A4),A2
	MOVE.L	(lbL011A08-DT,A4),(lbL011A04-DT,A4)
	MOVE.L	A2,(lbL011A08-DT,A4)
	MOVE.L	(A2),(viewport1_rasinfo_ptr-DT,A4)
	MOVE.L	(4,A2),(view_lofcprlist-DT,A4)
	PEA	(viewport1-DT,A4)
	PEA	(view-DT,A4)
	JSR	(_MakeVPort-DT,A4)
	ADDQ.W	#8,SP
	PEA	(view-DT,A4)
	JSR	(_MrgCop-DT,A4)
	ADDQ.W	#4,SP
	PEA	(view-DT,A4)
	JSR	(_LoadView-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(view_lofcprlist-DT,A4),(4,A2)
	PEA	(viewport2-DT,A4)
	JSR	(_WaitBOVP-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(SP)+,A2
	UNLK	A5
	RTS

install_input_handler
	LINK.W	A5,#-2
	CLR.B	(lbB012113-DT,A4)
	CLR.B	(lbB012112-DT,A4)
	CLR.L	-(SP)
	CLR.L	-(SP)
	JSR	(_CreateMsgPort-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(input_mp-DT,A4)
	BNE.B	lbC0066E8
	MOVEQ	#0,D0
lbC0066E4	UNLK	A5
	RTS

lbC0066E8	MOVE.L	(input_mp-DT,A4),-(SP)
	JSR	(__CreateStdIO-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	D0,(input_io-DT,A4)
	TST.L	(input_io-DT,A4)
	BNE.B	lbC00670A
	MOVE.L	(input_mp-DT,A4),-(SP)
	JSR	(_DeleteMsgPort-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#0,D0
	BRA.B	lbC0066E4

lbC00670A	LEA	(lbW01210C-DT,A4),A0
	MOVE.L	A0,(lbL011B9A-DT,A4)
	LEA	(_input_handler-DT,A4),A0
	MOVE.L	A0,(input_handler_ptr-DT,A4)
;;;;	MOVE.B	#51,(input_handler_priority-DT,A4)
	move.b	#127,(input_handler_priority-DT,a4)
	CLR.L	-(SP)
	MOVE.L	(input_io-DT,A4),-(SP)
	CLR.L	-(SP)
	PEA	(inputdevice.MSG,PC)
	JSR	(_OpenDevice-DT,A4)
	LEA	($10,SP),SP
	MOVE.W	D0,(-2,A5)
	TST.W	(-2,A5)
	BEQ.B	lbC006742
	MOVEQ	#0,D0
	BRA.B	lbC0066E4

lbC006742	MOVEA.L	(input_io-DT,A4),A0
	MOVE.W	#IND_ADDHANDLER,($1C,A0)
	LEA	(input_interrupt-DT,A4),A0
	MOVEA.L	(input_io-DT,A4),A1
	MOVE.L	A0,($28,A1)
	MOVE.L	(input_io-DT,A4),-(SP)
	JSR	(_DoIO-DT,A4)	;install intput handler
	ADDQ.W	#4,SP
	MOVEQ	#1,D0
	bra	lbC0066E4

inputdevice.MSG	db	'input.device',0,0

remove_input_handler
	LINK.W	A5,#0
	MOVEA.L	(input_io-DT,A4),A0
	MOVE.W	#10,($1C,A0)
	LEA	(input_interrupt-DT,A4),A0
	MOVEA.L	(input_io-DT,A4),A1
	MOVE.L	A0,($28,A1)
	MOVE.L	(input_io-DT,A4),-(SP)
	JSR	(_DoIO-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(input_io-DT,A4),-(SP)
	JSR	(_CloseDevice-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(input_io-DT,A4),-(SP)
	JSR	(__DeleteStdIO-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(input_mp-DT,A4),-(SP)
	JSR	(_DeleteMsgPort-DT,A4)
	ADDQ.W	#4,SP
	UNLK	A5
	RTS

lbC0067BC	LINK.W	A5,#-8
	CLR.W	(-4,A5)
	CLR.W	(-2,A5)
	BRA.B	lbC00682A

lbC0067CA	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	MOVE.W	(-2,A5),D1
	EXT.L	D1
	ADD.L	D1,D0
	LEA	(lbL00EBB4-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	MOVE.W	D2,(-6,A5)
	BTST	#1,(-5,A5)
	BEQ.B	lbC006826
	MOVE.W	(-4,A5),D0
	LEA	(lbL011B5A-DT,A4),A0
	MOVE.B	(-1,A5),(A0,D0.W)
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	AND.L	#1,D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-4,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	JSR	(lbC0068DA,PC)
	ADDQ.W	#8,SP
	ADDQ.W	#1,(-4,A5)
	CMPI.W	#11,(-4,A5)
	BGT.B	lbC006848
lbC006826	ADDQ.W	#1,(-2,A5)
lbC00682A	MOVE.W	(-2,A5),D0
	EXT.L	D0
	MOVE.W	(lbW01199C-DT,A4),D1
	MULS.W	#$12,D1
	LEA	(ascii.MSG11-DT,A4),A0
	MOVE.B	(A0,D1.L),D2
	EXT.W	D2
	EXT.L	D2
	CMP.L	D2,D0
	BLT.B	lbC0067CA
lbC006848	CLR.L	-(SP)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_SetBPen-DT,A4)
	ADDQ.W	#8,SP
	BRA.B	lbC0068C6

lbC006856	BTST	#0,(-3,A5)
	BEQ.B	lbC006866
	MOVE.W	#$1E2,(-6,A5)
	BRA.B	lbC00686C

lbC006866	MOVE.W	#$1AE,(-6,A5)
lbC00686C	MOVE.W	(-4,A5),D0
	EXT.L	D0
	MOVEQ	#2,D1
	JSR	(__divs-DT,A4)
	MOVEQ	#9,D1
	JSR	(__mulu-DT,A4)
	ADDQ.L	#8,D0
	MOVE.W	D0,(-8,A5)
	MOVE.W	(-8,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-6,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_Move-DT,A4)
	LEA	(12,SP),SP
	PEA	(6).W
	PEA	(ascii.MSG2,PC)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_Text-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	(-4,A5),D0
	LEA	(lbL011B5A-DT,A4),A0
	MOVE.B	#$FF,(A0,D0.W)
	ADDQ.W	#1,(-4,A5)
lbC0068C6	CMPI.W	#12,(-4,A5)
	BLT.B	lbC006856
	UNLK	A5
	RTS

ascii.MSG2	db	'      ',0,0

lbC0068DA	LINK.W	A5,#0
	MOVEM.L	D4-D7,-(SP)
	MOVE.W	(10,A5),D0
	LEA	(lbL011B5A-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D6
	CMPI.W	#8,(lbW01199C-DT,A4)
	BNE.B	lbC006900
	MOVEQ	#14,D7
	BRA.B	lbC006952

lbC006900	CMPI.W	#9,(lbW01199C-DT,A4)
	BNE.B	lbC00690C
	MOVEQ	#13,D7
	BRA.B	lbC006952

lbC00690C	CMP.L	#5,D6
	BGE.B	lbC006918
	MOVEQ	#4,D7
	BRA.B	lbC006952

lbC006918	CMPI.W	#6,(lbW01199C-DT,A4)
	BNE.B	lbC006930
	LEA	(H.MSG-DT,A4),A0
	MOVE.B	(A0,D6.L),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.L	D0,D7
	BRA.B	lbC006952

lbC006930	CMPI.W	#5,(lbW01199C-DT,A4)
	BNE.B	lbC00693C
	MOVE.L	D6,D7
	BRA.B	lbC006952

lbC00693C	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	LEA	(lbB00EBB3-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D7
lbC006952	MOVE.W	(14,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D7,-(SP)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_SetBPen-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	(10,A5),D0
	LEA	(lbL011B5A-DT,A4),A0
	MOVE.W	D0,D1
	MOVE.B	(A0,D1.W),D0
	EXT.W	D0
	EXT.L	D0
	MOVEQ	#5,D1
	JSR	(__mulu-DT,A4)
	MOVE.L	D0,D6
	BTST	#0,(11,A5)
	BEQ.B	lbC00699A
	MOVE.L	#$1E2,D4
	BRA.B	lbC0069A0

lbC00699A	MOVE.L	#$1AE,D4
lbC0069A0	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVEQ	#2,D1
	JSR	(__divs-DT,A4)
	MOVEQ	#9,D1
	JSR	(__mulu-DT,A4)
	MOVE.L	D0,D5
	ADDQ.L	#8,D5
	MOVE.L	D5,-(SP)
	MOVE.L	D4,-(SP)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_Move-DT,A4)
	LEA	(12,SP),SP
	PEA	(6).W
	PEA	(ascii.MSG0,PC)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_Text-DT,A4)
	LEA	(12,SP),SP
	MOVE.L	D5,-(SP)
	MOVE.L	D4,D0
	ADDQ.L	#4,D0
	MOVE.L	D0,-(SP)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_Move-DT,A4)
	LEA	(12,SP),SP
	CMPI.W	#8,(lbW01199C-DT,A4)
	BLT.B	lbC006A1C
	PEA	(5).W
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	LEA	(lbL00EBAE-DT,A4),A0
	MOVEA.L	(A0,D0.L),A1
	ADDA.L	D6,A1
	MOVE.L	A1,-(SP)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_Text-DT,A4)
	LEA	(12,SP),SP
	BRA.B	lbC006A66

lbC006A1C	CMP.L	#$19,D6
	BGE.B	lbC006A40
	PEA	(5).W
	LEA	(ItemsMagicTal.MSG-DT,A4),A0
	MOVEA.L	D6,A1
	ADDA.L	A0,A1
	MOVE.L	A1,-(SP)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_Text-DT,A4)
	LEA	(12,SP),SP
	BRA.B	lbC006A66

lbC006A40	PEA	(5).W
	MOVE.W	(lbW01199C-DT,A4),D0
	MULS.W	#$12,D0
	LEA	(lbL00EBAE-DT,A4),A0
	MOVEA.L	(A0,D0.L),A1
	ADDA.L	D6,A1
	PEA	(-$19,A1)
	PEA	(rp640x57x4-DT,A4)
	JSR	(_Text-DT,A4)
	LEA	(12,SP),SP
lbC006A66	MOVEM.L	(SP)+,D4-D7
	UNLK	A5
	RTS

ascii.MSG0	db	'      ',0,0

lbC006A76	LINK.W	A5,#-14
	MOVEM.L	D4-D7/A2/A3,-(SP)
	MOVE.W	(lbW01199C-DT,A4),D0
	EXT.L	D0
	bra	lbC007D62

lbC006A88	CMPI.W	#8,(10,A5)
	BNE.B	lbC006A9E
	PEA	(8).W
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
	bra	lbC0072FE

lbC006A9E	CMPI.W	#5,(10,A5)
	bne	lbC006C8C
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVEA.L	(4,A1),A3
	MOVE.L	A3,(rp1_bitmap_ptr-DT,A4)
	CLR.L	-(SP)
	PEA	(rp1-DT,A4)
	JSR	(_SetRast-DT,A4)
	ADDQ.W	#8,SP
	PEA	(8000).W
	PEA	(16).W
	PEA	(5).W
	PEA	(bitmap320x200x5-DT,A4)
	JSR	(_InitBitMap-DT,A4)
	LEA	($10,SP),SP
	MOVE.L	(lbL012026-DT,A4),(-14,A5)
	MOVE.L	(-14,A5),(bitmap320x200x5_plane0-DT,A4)
	MOVE.L	(-14,A5),D0
	ADD.L	#$20,D0
	MOVE.L	D0,(bitmap320x200x5_plane1-DT,A4)
	MOVE.L	(-14,A5),D0
	ADD.L	#$40,D0
	MOVE.L	D0,(bitmap320x200x5_plane2-DT,A4)
	MOVE.L	(-14,A5),D0
	ADD.L	#$60,D0
	MOVE.L	D0,(bitmap320x200x5_plane3-DT,A4)
	MOVE.L	(-14,A5),D0
	ADD.L	#$80,D0
	MOVE.L	D0,(bitmap320x200x5_plane4-DT,A4)
	MOVEQ	#0,D5
lbC006B20	MOVEA.L	(lbL0119FC-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.B	(A0,D5.L),D0
	MOVE.W	D0,(-8,A5)
	MOVE.W	(-8,A5),D0
	EXT.L	D0
	MOVEQ	#12,D1
	MOVE.L	D0,-(SP)
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW00E7AE-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.B	(A0,D0.L),D2
	MOVE.L	(SP)+,D3
	CMP.L	D2,D3
	BLS.B	lbC006B64
	MOVEQ	#12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW00E7AE-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.B	(A0,D0.L),D2
	MOVE.W	D2,(-8,A5)
lbC006B64	MOVEQ	#12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E7A9-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.B	(A0,D0.L),D2
	MOVE.L	D2,D6
	ADD.L	#$14,D6
	MOVEQ	#12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E7AA-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.B	(A0,D0.L),D2
	MOVE.W	D2,(-4,A5)
	MOVEQ	#12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(ascii.MSG12-DT,A4),A0
	MOVE.L	D0,D2
	MOVEQ	#0,D0
	MOVE.B	(A0,D2.L),D0
	MOVEQ	#$50,D1
	JSR	(__mulu-DT,A4)
	MOVEQ	#12,D1
	MOVE.L	D0,-(SP)
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E7AC-DT,A4),A1
	MOVEQ	#0,D3
	MOVE.B	(A1,D0.L),D3
	MOVEA.L	(SP)+,A6
	ADDA.L	D3,A6
	MOVE.W	A6,(-6,A5)
	MOVEQ	#12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E7AD-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.B	(A0,D0.L),D2
	MOVE.W	D2,(-10,A5)
	MOVEQ	#0,D4
	BRA.B	lbC006C34

lbC006BE4	CLR.L	-(SP)
	PEA	($FF).W
	PEA	($C0).W
	MOVE.W	(-10,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	PEA	($10).W
	MOVEQ	#0,D1
	MOVE.W	(-4,A5),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D6,-(SP)
	MOVE.L	A3,-(SP)
	MOVE.W	(-6,A5),D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	CLR.L	-(SP)
	PEA	(bitmap320x200x5-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	MOVEQ	#12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E7AB-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.B	(A0,D0.L),D2
	ADD.W	D2,(-4,A5)
	ADDQ.L	#1,D4
lbC006C34	MOVE.W	(-8,A5),D0
	EXT.L	D0
	CMP.L	D0,D4
	BCS.B	lbC006BE4
	ADDQ.L	#1,D5
	CMP.L	#$1F,D5
	BCS.W	lbC006B20
	CLR.L	-(SP)
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	(viewport1-DT,A4)
	JSR	(_SetRGB4-DT,A4)
	LEA	($14,SP),SP
	JSR	(lbC00DEE6-DT,A4)
	PEA	(31).W
	PEA	(lbL010D8E-DT,A4)
	PEA	(viewport1-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	MOVE.B	#4,(lbB011939-DT,A4)
	PEA	(5).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC0072FE

lbC006C8C	CMPI.W	#6,(10,A5)
	bne	lbC007270
	PEA	(7).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	PEA	($1E).W
	CLR.L	-(SP)
	JSR	(lbC00DE7A-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	(lbL0119FC-DT,A4),A0
	CLR.B	($23,A0)
	TST.W	(lbW0119AE-DT,A4)
	beq	lbC007262
	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012312-DT,A4),A0
	CMPI.B	#1,(A0,D0.L)
	bne	lbC007084
	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012314-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D5
	AND.L	#$FF,D5
	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbW01231C-DT,A4),A0
	MOVE.W	(A0,D0.L),D1
	EXT.L	D1
	MOVE.L	D1,D6
	AND.L	#$7F,D6
	CMP.L	#13,D5
	BNE.B	lbC006D24
	PEA	(goldpieces.MSG,PC)
	JSR	(lbC00DEC8-DT,A4)
	ADDQ.W	#4,SP
	ADDI.W	#$32,(lbW01197A-DT,A4)
	bra	lbC00702A

lbC006D24	CMP.L	#$14,D5
	BNE.B	lbC006D58
	PEA	($11).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	CMPI.W	#7,(lbW00ED02-DT,A4)
	BLS.B	lbC006D4A
	PEA	($13).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC006D54

lbC006D4A	PEA	($12).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC006D54	bra	lbC00702A

lbC006D58	CMP.L	#$94,D5
	BNE.B	lbC006D8A
	CMPI.W	#15,(lbW01197C-DT,A4)
	BGE.B	lbC006D7C
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDQ.B	#1,($18,A0)
	PEA	($24).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC006D86

lbC006D7C	PEA	($1E).W
	JSR	(lbC00DF7C-DT,A4)
	ADDQ.W	#4,SP
lbC006D86	bra	lbC00702A

lbC006D8A	CMP.L	#$66,D5
	beq	lbC007D74
	CMP.L	#$1C,D5
	BNE.B	lbC006DE8
	PEA	(hisbrothersbo.MSG,PC)
	JSR	(lbC00DEC8-DT,A4)
	ADDQ.W	#4,SP
	CLR.B	(lbB0110D7-DT,A4)
	CLR.B	(lbB0110D1-DT,A4)
	MOVEQ	#0,D7
lbC006DB0	CMP.L	#1,D6
	BNE.B	lbC006DCA
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDA.L	D7,A0
	LEA	(lbL011C20-DT,A4),A1
	MOVE.B	(A1,D7.L),D0
	ADD.B	D0,(A0)
	BRA.B	lbC006DDA

lbC006DCA	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDA.L	D7,A0
	LEA	(lbB011C43-DT,A4),A1
	MOVE.B	(A1,D7.L),D0
	ADD.B	D0,(A0)
lbC006DDA	ADDQ.L	#1,D7
	CMP.L	#$1F,D7
	BCS.B	lbC006DB0
	bra	lbC00702A

lbC006DE8	CMP.L	#15,D5
	BNE.B	lbC006DFE
	PEA	(achest.MSG,PC)
	JSR	(lbC00DEC2-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC006EA0

lbC006DFE	CMP.L	#14,D5
	BNE.B	lbC006E14
	PEA	(abrassurn.MSG,PC)
	JSR	(lbC00DEC2-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC006EA0

lbC006E14	CMP.L	#$10,D5
	BNE.B	lbC006E28
	PEA	(somesacks.MSG,PC)
	JSR	(lbC00DEC2-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC006EA0

lbC006E28	CMP.L	#$1D,D5
	beq	lbC007D74
	CMP.L	#$1F,D5
	beq	lbC007D74
	MOVEQ	#0,D7
	BRA.B	lbC006E92

lbC006E40	LEA	(ascii.MSG24-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.B	(A0,D7.L),D0
	CMP.L	D5,D0
	BNE.B	lbC006E90
	LEA	(ascii.MSG25-DT,A4),A0
	MOVEQ	#0,D0
	MOVE.B	(A0,D7.L),D0
	MOVE.L	D0,D4
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDQ.B	#1,(A0,D4.L)
	PEA	(a.MSG3,PC)
	JSR	(lbC00DEC8-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#12,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	PEA	(ascii.MSG7,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC00702A

lbC006E90	ADDQ.L	#2,D7
lbC006E92	LEA	(ascii.MSG24-DT,A4),A0
	TST.B	(A0,D7.L)
	BNE.B	lbC006E40
	bra	lbC007D74

lbC006EA0	JSR	(lbC00DDB4-DT,A4)
	MOVE.L	D0,D7
	TST.L	D7
	BNE.B	lbC006EB8
	PEA	(nothing.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC00702A

lbC006EB8	CMP.L	#1,D7
	BNE.B	lbC006F08
	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	D0,D4
	ADDQ.L	#8,D4
	CMP.L	#8,D4
	BNE.B	lbC006ED2
	MOVEQ	#$23,D4
lbC006ED2	PEA	(a.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#12,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	PEA	(ascii.MSG3,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDQ.B	#1,(A0,D4.L)
	bra	lbC00702A

lbC006F08	CMP.L	#2,D7
	bne	lbC006F9E
	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	D0,D4
	ADDQ.L	#8,D4
	CMP.L	#8,D4
	BNE.B	lbC006F2C
	MOVEQ	#$22,D4
	ADDI.W	#$64,(lbW01197A-DT,A4)
	BRA.B	lbC006F36

lbC006F2C	PEA	(a.MSG0,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
lbC006F36	MOVEQ	#12,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
	PEA	(anda.MSG,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
lbC006F56	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	D0,D7
	ADDQ.L	#8,D7
	CMP.L	D4,D7
	BEQ.B	lbC006F56
	CMP.L	#8,D7
	BNE.B	lbC006F6C
	MOVEQ	#$23,D7
lbC006F6C	MOVEQ	#12,D1
	MOVE.L	D7,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	CMP.L	#$1F,D4
	BCC.B	lbC006F92
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDQ.B	#1,(A0,D4.L)
lbC006F92	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDQ.B	#1,(A0,D7.L)
	bra	lbC00702A

lbC006F9E	CMP.L	#3,D7
	bne	lbC00702A
	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	D0,D4
	ADDQ.L	#8,D4
	CMP.L	#8,D4
	BNE.B	lbC006FF8
	PEA	(keys.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#0,D7
lbC006FC4	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	D0,D4
	ADD.L	#$10,D4
	CMP.L	#$16,D4
	BNE.B	lbC006FDA
	MOVEQ	#$10,D4
lbC006FDA	CMP.L	#$17,D4
	BNE.B	lbC006FE4
	MOVEQ	#$14,D4
lbC006FE4	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDQ.B	#1,(A0,D4.L)
	ADDQ.L	#1,D7
	CMP.L	#3,D7
	BCS.B	lbC006FC4
	BRA.B	lbC00702A

lbC006FF8	PEA	(ascii.MSG4,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#12,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	PEA	(s.MSG,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDA.L	D4,A0
	ADDQ.B	#3,(A0)
lbC00702A	PEA	(2).W
	MOVE.W	(lbW0119AE-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DF40-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	(lbL0119FC-DT,A4),A0
	MOVEA.L	(lbL0119FC-DT,A4),A1
	MOVEQ	#0,D0
	MOVE.B	($23,A1),D0
	MOVEQ	#10,D1
	JSR	(__mulu-DT,A4)
	ADD.B	D0,(8,A0)
	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	($16,A0)
	BEQ.B	lbC007080
	MOVE.B	#1,(lbB011940-DT,A4)
	MOVE.B	#2,(lbB011939-DT,A4)
	JSR	(lbC00DECE-DT,A4)
	MOVE.L	(font_ptr-DT,A4),-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetFont-DT,A4)
	ADDQ.W	#8,SP
	JSR	(lbC00DF64-DT,A4)
lbC007080	bra	lbC007260

lbC007084	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012316-DT,A4),A0
	TST.B	(A0,D0.L)
	BGE.B	lbC00709A
	bra	lbC007260

lbC00709A	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbW01231C-DT,A4),A0
	TST.W	(A0,D0.L)
	BEQ.B	lbC0070B4
	TST.W	(lbW01199A-DT,A4)
	beq	lbC007256
lbC0070B4	PEA	(searchedthebo.MSG,PC)
	JSR	(lbC00DEAA-DT,A4)
	ADDQ.W	#4,SP
	PEA	(lbB007E09,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012316-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D4
	CMP.L	#5,D4
	BLS.B	lbC0070E8
	MOVEQ	#0,D4
lbC0070E8	TST.L	D4
	beq	lbC007178
	PEA	(a.MSG1,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	D4,D0
	SUBQ.L	#1,D0
	MOVEQ	#12,D1
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDA.L	D4,A0
	ADDQ.B	#1,(-1,A0)
	MOVE.B	(lbB012316-DT,A4),D0
	EXT.W	D0
	EXT.L	D0
	CMP.L	D0,D4
	BLS.B	lbC00712A
	MOVE.B	D4,(lbB012316-DT,A4)
lbC00712A	CMP.L	#4,D4
	BNE.B	lbC007178
	PEA	(and.MSG,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	D0,D5
	ADDQ.L	#2,D5
	PEA	(1).W
	MOVE.L	D5,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	(Arrows.MSG0,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADD.B	D5,(8,A0)
	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012316-DT,A4),A0
	MOVE.B	#$FF,(A0,D0.L)
	bra	lbC007D74

lbC007178	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012316-DT,A4),A0
	MOVE.B	#$FF,(A0,D0.L)
	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012313-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,D5
	BTST	#7,D5
	BEQ.B	lbC0071A8
	MOVEQ	#0,D5
	BRA.B	lbC0071D8

lbC0071A8	MOVEQ	#6,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB00E164-DT,A4),A0
	MOVE.B	(A0,D0.L),D2
	EXT.W	D2
	EXT.L	D2
	ASL.L	#3,D2
	MOVE.L	D2,-(SP)
	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	(SP)+,D1
	MOVE.L	D1,D5
	ADD.L	D0,D5
	LEA	(lbL010EB2-DT,A4),A0
	MOVE.B	(A0,D5.L),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.L	D0,D5
lbC0071D8	TST.L	D5
	BEQ.B	lbC00723C
	TST.L	D4
	BEQ.B	lbC0071EA
	PEA	(and.MSG0,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
lbC0071EA	CMP.L	#$1F,D5
	BCC.B	lbC0071FC
	PEA	(a.MSG2,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
lbC0071FC	MOVEQ	#12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	CMP.L	#$1F,D5
	BCS.B	lbC007232
	MOVEQ	#12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW00E7AE-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.B	(A0,D0.L),D2
	ADD.W	D2,(lbW01197A-DT,A4)
	BRA.B	lbC00723A

lbC007232	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDQ.B	#1,(A0,D5.L)
lbC00723A	BRA.B	lbC00724A

lbC00723C	TST.L	D4
	BNE.B	lbC00724A
	PEA	(nothing.MSG0,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
lbC00724A	PEA	(ascii.MSG5,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007260

lbC007256	PEA	($23).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC007260	BRA.B	lbC00726C

lbC007262	PEA	(10).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
lbC00726C	bra	lbC0072FE

lbC007270	CMPI.W	#7,(10,A5)
	BNE.B	lbC0072EC
	CLR.L	(-8,A5)
	LEA	(lbW01230A-DT,A4),A0
	MOVEA.L	A0,A2
	MOVEQ	#0,D4
	BRA.B	lbC0072C4

lbC007286	CMPI.B	#1,(8,A2)
	BNE.B	lbC0072BC
	TST.B	(9,A2)
	BNE.B	lbC0072BC
	CLR.L	-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DE80-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#$28,D0
	BGE.B	lbC0072BC
	MOVE.L	#1,(-8,A5)
	MOVE.L	#1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF40-DT,A4)
	ADDQ.W	#8,SP
lbC0072BC	ADDA.L	#$16,A2
	ADDQ.L	#1,D4
lbC0072C4	MOVE.W	(lbW01194C-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D4
	BCS.B	lbC007286
	TST.L	(-8,A5)
	BEQ.B	lbC0072E0
	PEA	($26).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0072EA

lbC0072E0	PEA	($14).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC0072EA	BRA.B	lbC0072FE

lbC0072EC	CMPI.W	#9,(10,A5)
	BNE.B	lbC0072FE
	PEA	(7).W
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
lbC0072FE	bra	lbC007D74

lbC007302	CMPI.W	#5,(10,A5)
	BLT.B	lbC00731C
	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVEA.L	D0,A0
	ADDA.L	(lbL0119FC-DT,A4),A0
	TST.B	(4,A0)
	BNE.B	lbC00732A
lbC00731C	PEA	($15).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC007D74

lbC00732A	MOVEA.L	(lbL0119F8-DT,A4),A0
	CMPI.B	#9,(11,A0)
	BNE.B	lbC007344
	PEA	($3B).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC007D74

lbC007344	MOVE.W	(10,A5),D0
	EXT.L	D0
	bra	lbC007658

lbC00734E	ADDI.W	#$2F8,(lbW011998-DT,A4)
	bra	lbC00766C

lbC007358	ADDI.W	#$168,(lbW011996-DT,A4)
	bra	lbC00766C

lbC007362	CMPI.W	#1,(lbW01196A-DT,A4)
	BLE.B	lbC007372
lbC00736A	MOVEM.L	(SP)+,D4-D7/A2/A3
	UNLK	A5
	RTS

lbC007372	ADDI.W	#$64,(lbW01199A-DT,A4)
	bra	lbC00766C

lbC00737C	TST.W	(lbW011968-DT,A4)
	BNE.B	lbC00738C
	CMPI.W	#7,(lbW00ED02-DT,A4)
	BLS.B	lbC00738C
	BRA.B	lbC00736A

lbC00738C	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(lbL011A1C-DT,A4)
	MOVE.L	(lbL011A1C-DT,A4),D0
	ADDQ.L	#8,D0
	MOVE.L	D0,(lbL011A98-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW011958-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDFC-DT,A4)
	ADDQ.W	#8,SP
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	LSR.L	#4,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW0119C2-DT,A4),D1
	ADD.L	(lbL011AB8-DT,A4),D1
	ASL.L	#4,D1
	SUB.L	D1,D0
	MOVE.L	D0,D4
	SUBQ.L	#4,D4
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	LSR.L	#4,D0
	MOVEQ	#0,D1
	MOVE.W	(lbW0119C4-DT,A4),D1
	ADD.L	(lbL011ABC-DT,A4),D1
	ASL.L	#4,D1
	SUB.L	D1,D0
	MOVE.L	D0,D5
	ADDQ.L	#3,D5
	MOVE.L	(lbL011A1C-DT,A4),(rp1_bitmap_ptr-DT,A4)
	CLR.L	-(SP)
	PEA	(rp1-DT,A4)
	JSR	(_SetDrMd-DT,A4)
	ADDQ.W	#8,SP
	PEA	($1F).W
	PEA	(rp1-DT,A4)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	TST.L	D4
	BLS.B	lbC007448
	CMP.L	#$140,D4
	BCC.B	lbC007448
	TST.L	D5
	BLS.B	lbC007448
	CMP.L	#$8F,D5
	BCC.B	lbC007448
	MOVE.L	D5,-(SP)
	MOVE.L	D4,-(SP)
	PEA	(rp1-DT,A4)
	JSR	(_Move-DT,A4)
	LEA	(12,SP),SP
	PEA	(1).W
	PEA	(ascii.MSG8,PC)
	PEA	(rp1-DT,A4)
	JSR	(_Text-DT,A4)
	LEA	(12,SP),SP
lbC007448	MOVE.B	#1,(lbB011939-DT,A4)
	JSR	(lbC00DEE6-DT,A4)
	PEA	(5).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC00766C

lbC007460	CMPI.W	#$90,(lbW011984-DT,A4)
	bne	lbC00759A
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	AND.L	#$FF,D0
	MOVEQ	#$55,D1
	JSR	(__divu-DT,A4)
	CMP.L	#1,D0
	bne	lbC007594
	MOVEQ	#0,D2
	MOVE.W	(lbW01195C-DT,A4),D2
	AND.L	#$FF,D2
	LSR.L	#6,D2
	CMP.L	#1,D2
	bne	lbC007594
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	MOVE.L	D0,D6
	LSR.L	#8,D6
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	LSR.L	#8,D0
	MOVE.W	D0,(-4,A5)
	MOVEQ	#0,D4
lbC0074B6	MOVE.L	D4,D0
	ADD.L	D4,D0
	LEA	(lbB00E792-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	CMP.L	D6,D1
	bne	lbC007586
	MOVE.L	D4,D2
	ADD.L	D4,D2
	LEA	(lbB00E793-DT,A4),A1
	MOVEQ	#0,D3
	MOVE.B	(A1,D2.L),D3
	MOVEQ	#0,D2
	MOVE.W	(-4,A5),D2
	CMP.L	D2,D3
	bne	lbC007586
	MOVE.B	(lbB01231B-DT,A4),D0
	EXT.W	D0
	EXT.L	D0
	ADDQ.L	#1,D0
	ADD.L	D0,D4
	CMP.L	#10,D4
	BLS.B	lbC0074FE
	SUB.L	#11,D4
lbC0074FE	MOVE.L	D4,D0
	ADD.L	D4,D0
	LEA	(lbB00E792-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	ASL.L	#8,D1
	MOVEQ	#0,D2
	MOVE.W	(lbW01195A-DT,A4),D2
	AND.L	#$FF,D2
	MOVE.L	D1,D6
	ADD.L	D2,D6
	MOVE.L	D4,D0
	ADD.L	D4,D0
	LEA	(lbB00E793-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	ASL.L	#8,D1
	MOVEQ	#0,D2
	MOVE.W	(lbW01195C-DT,A4),D2
	AND.L	#$FF,D2
	ADD.L	D2,D1
	MOVE.W	D1,(-4,A5)
	JSR	(lbC00DE8C-DT,A4)
	PEA	(1).W
	MOVEQ	#0,D0
	MOVE.W	(-4,A5),D0
	MOVE.L	D0,-(SP)
	MOVE.L	D6,-(SP)
	JSR	(lbC005778,PC)
	LEA	(12,SP),SP
	TST.W	(lbW01196A-DT,A4)
	BEQ.B	lbC007584
	MOVE.W	(lbW01196E-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	MOVE.W	(lbW01230A-DT,A4),(A0,D0.L)
	MOVE.W	(lbW01196E-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbW01230C-DT,A4),A0
	MOVE.W	(lbW01230C-DT,A4),(A0,D0.L)
lbC007584	BRA.B	lbC007592

lbC007586	ADDQ.L	#1,D4
	CMP.L	#11,D4
	BCS.W	lbC0074B6
lbC007592	BRA.B	lbC007598

lbC007594	bra	lbC00736A

lbC007598	BRA.B	lbC00759E

lbC00759A	bra	lbC00736A

lbC00759E	JSR	(lbC00DDBA-DT,A4)
	ADDQ.L	#4,D0
	ADD.W	D0,(lbW01231C-DT,A4)
	MOVE.W	(lbW01231C-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(lbW011974-DT,A4),D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	ADD.L	#15,D0
	MOVE.L	(SP)+,D2
	CMP.L	D0,D2
	BLE.B	lbC0075E0
	MOVE.W	(lbW011974-DT,A4),D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	ADD.L	#15,D0
	MOVE.W	D0,(lbW01231C-DT,A4)
	BRA.B	lbC0075EA

lbC0075E0	PEA	(Thatfeelsalot.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
lbC0075EA	PEA	(4).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC00766C

lbC0075F6	LEA	(lbL012320-DT,A4),A0
	MOVEA.L	A0,A2
	MOVEQ	#1,D4
	BRA.B	lbC00762E

lbC007600	TST.W	($12,A2)
	BEQ.B	lbC007626
	CMPI.B	#2,(8,A2)
	BNE.B	lbC007626
	CMPI.B	#7,(9,A2)
	BCC.B	lbC007626
	CLR.W	($12,A2)
	MOVE.L	D4,-(SP)
	JSR	(lbC005DF0,PC)
	ADDQ.W	#4,SP
	SUBQ.W	#1,(lbW011974-DT,A4)
lbC007626	ADDA.L	#$16,A2
	ADDQ.L	#1,D4
lbC00762E	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D4
	BCS.B	lbC007600
	TST.B	(lbB01193E-DT,A4)
	BEQ.B	lbC007648
	PEA	($22).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
lbC007648	BRA.B	lbC00766C

lbW00764A	dw	lbC007460-lbC00766A
	dw	lbC00734E-lbC00766A
	dw	lbC00759E-lbC00766A
	dw	lbC007358-lbC00766A
	dw	lbC00737C-lbC00766A
	dw	lbC007362-lbC00766A
	dw	lbC0075F6-lbC00766A

lbC007658	SUBQ.L	#5,D0
	CMP.L	#7,D0
	BCC.B	lbC00766C
	ASL.L	#1,D0
	MOVE.W	(lbW00764A,PC,D0.W),D0
	JMP	(lbC00766A,PC,D0.W)
lbC00766A	EQU	*-2

lbC00766C	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVEA.L	D0,A0
	ADDA.L	(lbL0119FC-DT,A4),A0
	SUBQ.B	#1,(4,A0)
	TST.B	(4,A0)
	BNE.B	lbC007686
	JSR	(lbC007F3A,PC)
lbC007686	bra	lbC007D74

lbC00768A	CMPI.W	#5,(10,A5)
	BNE.B	lbC0076A4
	PEA	($64).W
	PEA	(1).W
	JSR	(lbC00DE7A-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,D5
	BRA.B	lbC0076B4

lbC0076A4	PEA	($32).W
	PEA	(1).W
	JSR	(lbC00DE7A-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,D5
lbC0076B4	TST.W	(lbW0119AE-DT,A4)
	beq	lbC007D74
	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	CMPI.B	#15,($10,A2)
	beq	lbC007D74
	CMPI.B	#4,(8,A2)
	bne	lbC007916
	CMPI.W	#5,(10,A5)
	BNE.B	lbC0076FE
	CMP.L	#$23,D5
	BCC.B	lbC0076FE
	PEA	(8).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC007D74

lbC0076FE	MOVEQ	#0,D0
	MOVE.B	(9,A2),D0
	MOVE.L	D0,D7
	AND.L	#$7F,D7
	MOVE.L	D7,D0
	ASL.L	#2,D0
	LEA	(lbL00E12A-DT,A4),A0
	TST.B	(A0,D0.L)
	BEQ.B	lbC007726
	MOVE.B	#$13,($10,A2)
	MOVE.B	#15,(15,A2)
lbC007726	MOVE.L	D7,D0
	bra	lbC007902

lbC00772C	CMPI.W	#10,(lbW011978-DT,A4)
	BGE.B	lbC007740
	PEA	($23).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007754

lbC007740	MOVE.B	(14,A2),D0
	EXT.W	D0
	EXT.L	D0
	MOVEA.L	D0,A0
	PEA	($1B,A0)
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC007754	bra	lbC007914

lbC007758	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	($1C,A0)
	BEQ.B	lbC007786
	TST.B	(lbB0110FB-DT,A4)
	BNE.B	lbC00777A
	PEA	($27).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	#1,(lbB0110FB-DT,A4)
	BRA.B	lbC007784

lbC00777A	PEA	($13).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC007784	BRA.B	lbC0077D2

lbC007786	CMPI.W	#10,(lbW011978-DT,A4)
	BGE.B	lbC00779A
	PEA	($28).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0077D2

lbC00779A	MOVEQ	#0,D0
	MOVE.W	(lbW011988-DT,A4),D0
	MOVEQ	#3,D1
	JSR	(__modu-DT,A4)
	MOVEA.L	D0,A0
	PEA	($24,A0)
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	MOVE.W	(lbW011974-DT,A4),D0
	EXT.L	D0
	MOVEQ	#4,D1
	JSR	(__divs-DT,A4)
	ADD.L	#15,D0
	MOVE.W	D0,(lbW01231C-DT,A4)
	PEA	(4).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
lbC0077D2	bra	lbC007914

lbC0077D6	PEA	(15).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC007914

lbC0077E4	TST.B	(lbB0113D1-DT,A4)
	BEQ.B	lbC0077F4
	PEA	($10).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC0077F4	bra	lbC007914

lbC0077F8	TST.B	(lbB0113D1-DT,A4)
	BEQ.B	lbC007808
	PEA	($11).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC007808	bra	lbC007914

lbC00780C	PEA	($14).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC007914

lbC00781A	TST.B	(lbB0110F5-DT,A4)
	BEQ.B	lbC007838
	MOVE.W	(lbW011976-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDC0-DT,A4)
	MOVE.L	(SP)+,D1
	CMP.L	D0,D1
	BGE.B	lbC007836
	ADDQ.W	#5,(lbW011976-DT,A4)
lbC007836	BRA.B	lbC007848

lbC007838	PEA	($2D).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	#1,(lbB0110F5-DT,A4)
lbC007848	PEA	(7).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC007914

lbC007856	CMPI.W	#5,(lbW01197E-DT,A4)
	BGE.B	lbC00786A
	PEA	(13).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007888

lbC00786A	CMPI.W	#7,(lbW0119B6-DT,A4)
	BLE.B	lbC00787E
	PEA	(12).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007888

lbC00787E	PEA	(14).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC007888	bra	lbC007914

lbC00788C	PEA	($2E).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007914

lbC007898	PEA	($2F).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007914

lbC0078A4	PEA	($31).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007914

lbC0078B0	CMPI.W	#2,(lbW00ED02-DT,A4)
	BNE.B	lbC0078C4
	PEA	($16).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC0078D8

lbC0078C4	MOVE.B	(14,A2),D0
	EXT.W	D0
	EXT.L	D0
	MOVEA.L	D0,A0
	PEA	($35,A0)
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC0078D8	BRA.B	lbC007914

lbC0078DA	PEA	($17).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007914

lbW0078E6	dw	lbC00772C-lbC007912
	dw	lbC007758-lbC007912
	dw	lbC0077D6-lbC007912
	dw	lbC0077D6-lbC007912
	dw	lbC0077E4-lbC007912
	dw	lbC0077F8-lbC007912
	dw	lbC00780C-lbC007912
	dw	lbC00781A-lbC007912
	dw	lbC007856-lbC007912
	dw	lbC00788C-lbC007912
	dw	lbC007898-lbC007912
	dw	lbC0078A4-lbC007912
	dw	lbC0078B0-lbC007912
	dw	lbC0078DA-lbC007912

lbC007902	CMP.L	#14,D0
	BCC.B	lbC007914
	ASL.L	#1,D0
	MOVE.W	(lbW0078E6,PC,D0.W),D0
	JMP	(lbC007912,PC,D0.W)
lbC007912	EQU	*-2

lbC007914	BRA.B	lbC007968

lbC007916	CMPI.B	#5,(8,A2)
	BNE.B	lbC007952
	CMPI.W	#5,(lbW011990-DT,A4)
	BNE.B	lbC007952
	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	(6,A0)
	BEQ.B	lbC00793C
	PEA	($39).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007950

lbC00793C	MOVEA.L	(lbL0119FC-DT,A4),A0
	MOVE.B	#1,(6,A0)
	PEA	($38).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC007950	BRA.B	lbC007968

lbC007952	CMPI.B	#2,(8,A2)
	BNE.B	lbC007968
	MOVEQ	#0,D0
	MOVE.B	(9,A2),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC007968	bra	lbC007D74

lbC00796C	MOVE.W	(lbW0119B0-DT,A4),(lbW0119AE-DT,A4)
	beq	lbC007D74
	MOVE.W	(lbW0119AE-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012313-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	CMP.L	#$88,D1
	bne	lbC007A62
	CMPI.W	#11,(10,A5)
	BLE.B	lbC00799E
	bra	lbC00736A

lbC00799E	MOVE.W	(10,A5),D0
	EXT.L	D0
	SUBQ.L	#5,D0
	ASL.L	#1,D0
	MOVE.W	D0,(10,A5)
	MOVE.W	(10,A5),D0
	ADDQ.W	#1,(10,A5)
	LEA	(lbL010EA4-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D4
	MOVE.W	(10,A5),D0
	LEA	(lbL010EA4-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D5
	MOVE.W	(lbW01197A-DT,A4),D0
	EXT.L	D0
	CMP.L	D5,D0
	BLS.B	lbC007A58
	SUB.W	D5,(lbW01197A-DT,A4)
	PEA	(7).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	TST.L	D4
	BNE.B	lbC007A06
	PEA	($16).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	PEA	($32).W
	JSR	(lbC00DF7C-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007A56

lbC007A06	CMP.L	#8,D4
	BNE.B	lbC007A24
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDA.L	D4,A0
	ADDI.B	#10,(A0)
	PEA	($17).W
	JSR	(lbC00DEB0-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007A56

lbC007A24	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDQ.B	#1,(A0,D4.L)
	PEA	(boughta.MSG,PC)
	JSR	(lbC00DEAA-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#12,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	PEA	(ascii.MSG6,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
lbC007A56	BRA.B	lbC007A62

lbC007A58	PEA	(Notenoughmone.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
lbC007A62	bra	lbC007D74

lbC007A66	CMPI.W	#6,(10,A5)
	BNE.B	lbC007A78
	PEA	(1).W
	JSR	(lbC00643C,PC)
	ADDQ.W	#4,SP
lbC007A78	CMPI.W	#8,(10,A5)
	BNE.B	lbC007A8A
	PEA	(5).W
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
lbC007A8A	CMPI.W	#9,(10,A5)
	BNE.B	lbC007AA0
	CLR.B	(lbB01190E-DT,A4)
	PEA	(9).W
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
lbC007AA0	bra	lbC007D74

lbC007AA4	CMPI.W	#7,(10,A5)
	BNE.B	lbC007ACC
	TST.B	(lbB011937-DT,A4)
	BEQ.B	lbC007ABE
	PEA	(6).W
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC007AC8

lbC007ABE	PEA	(hasnokeys.MSG,PC)
	JSR	(lbC00DEAA-DT,A4)
	ADDQ.W	#4,SP
lbC007AC8	bra	lbC00736A

lbC007ACC	CMPI.W	#5,(10,A5)
	BGE.B	lbC007AF2
	TST.B	(lbB011937-DT,A4)
	BEQ.B	lbC007AE8
	MOVE.W	(10,A5),D0
	EXT.L	D0
	ADDQ.L	#1,D0
	MOVE.B	D0,(lbB012316-DT,A4)
	BRA.B	lbC007AF2

lbC007AE8	PEA	(doesnthaveone.MSG,PC)
	JSR	(lbC00DEAA-DT,A4)
	ADDQ.W	#4,SP
lbC007AF2	CMPI.W	#6,(10,A5)
	BNE.B	lbC007B26
	TST.B	(lbB011937-DT,A4)
	BEQ.B	lbC007B26
	CMPI.W	#$537D,(lbW01195A-DT,A4)
	BCC.B	lbC007B22
	CMPI.W	#$2BBA,(lbW01195A-DT,A4)
	BLS.B	lbC007B22
	CMPI.W	#$3F50,(lbW01195C-DT,A4)
	BCC.B	lbC007B22
	CMPI.W	#$27DD,(lbW01195C-DT,A4)
	BHI.W	lbC007D74
lbC007B22	JSR	(lbC007EAC,PC)
lbC007B26	CMPI.W	#8,(10,A5)
	BNE.B	lbC007B3E
	TST.B	(lbB011941-DT,A4)
	BEQ.B	lbC007B3E
	PEA	($3C).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC007B3E	CLR.L	-(SP)
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
	bra	lbC007D74

lbC007B4A	CMPI.W	#6,(10,A5)
	BNE.B	lbC007B58
	MOVE.B	#1,(lbB011940-DT,A4)
lbC007B58	CMPI.W	#5,(10,A5)
	BNE.B	lbC007B70
	MOVE.B	#1,(lbB01190E-DT,A4)
	PEA	(9).W
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
lbC007B70	bra	lbC007D74

lbC007B74	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DF4C-DT,A4)
	ADDQ.W	#4,SP
	PEA	(4).W
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
	bra	lbC007D74

lbC007B90	SUBQ.W	#5,(10,A5)
	CLR.B	(lbB011949-DT,A4)
	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVEA.L	D0,A0
	ADDA.L	(lbL0119FC-DT,A4),A0
	TST.B	($10,A0)
	beq	lbC007C62
	MOVEQ	#0,D4
lbC007BAE	PEA	($10).W
	MOVE.L	D4,-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.L	D0,D6
	PEA	($10).W
	MOVE.L	D4,-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-4,A5)
	MOVE.W	(10,A5),D0
	EXT.L	D0
	ADDQ.L	#1,D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(-4,A5),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D6,-(SP)
	JSR	(lbC000BCC,PC)
	LEA	(12,SP),SP
	TST.L	D0
	BEQ.B	lbC007C12
	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVEA.L	D0,A0
	ADDA.L	(lbL0119FC-DT,A4),A0
	SUBQ.B	#1,($10,A0)
	BRA.B	lbC007C1C

lbC007C12	ADDQ.L	#1,D4
	CMP.L	#9,D4
	BCS.B	lbC007BAE
lbC007C1C	CMP.L	#8,D4
	BLS.B	lbC007C62
	PEA	(trieda.MSG,PC)
	JSR	(lbC00DEAA-DT,A4)
	ADDQ.W	#4,SP
	MOVE.W	(10,A5),D0
	EXT.L	D0
	ADD.L	#$10,D0
	MOVEQ	#12,D1
	JSR	(__mulu-DT,A4)
	LEA	(lbL00E7B0-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	PEA	(butitdidnt.MSG,PC)
	JSR	(lbC00DEA4-DT,A4)
	ADDQ.W	#4,SP
	PEA	(fit.MSG,PC)
	JSR	(_log_message-DT,A4)
	ADDQ.W	#4,SP
lbC007C62	CLR.L	-(SP)
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
	bra	lbC007D74

lbC007C6E	TST.W	(lbW0119B0-DT,A4)
	beq	lbC007D74
	MOVE.W	(lbW0119B0-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbB012313-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,D7
	CMPI.W	#5,(10,A5)
	BNE.B	lbC007CFA
	CMPI.W	#2,(lbW01197A-DT,A4)
	BLE.B	lbC007CFA
	SUBQ.W	#2,(lbW01197A-DT,A4)
	JSR	(lbC00DDC0-DT,A4)
	MOVE.W	(lbW011978-DT,A4),D1
	EXT.L	D1
	CMP.L	D1,D0
	BLE.B	lbC007CB0
	ADDQ.W	#1,(lbW011978-DT,A4)
lbC007CB0	PEA	(4).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	PEA	(7).W
	JSR	(lbC00DE98-DT,A4)
	ADDQ.W	#4,SP
	CMP.L	#$8D,D7
	BNE.B	lbC007CEE
	MOVE.W	(lbW0119B0-DT,A4),D0
	MULS.W	#$16,D0
	LEA	(lbW012318-DT,A4),A0
	MOVE.B	(A0,D0.L),D1
	EXT.W	D1
	EXT.L	D1
	MOVEA.L	D1,A1
	PEA	($18,A1)
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007CF8

lbC007CEE	PEA	($32).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
lbC007CF8	BRA.B	lbC007D44

lbC007CFA	CMPI.W	#8,(10,A5)
	BNE.B	lbC007D44
	MOVEA.L	(lbL0119FC-DT,A4),A0
	TST.B	($1D,A0)
	BEQ.B	lbC007D44
	CMP.L	#$8A,D7
	BEQ.B	lbC007D20
	PEA	($15).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC007D44

lbC007D20	PEA	($30).W
	JSR	(lbC00DEB6-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL0119FC-DT,A4),A0
	CLR.B	($1D,A0)
	PEA	($8C).W
	MOVE.W	(lbW0119B0-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DF3A-DT,A4)
	ADDQ.W	#8,SP
lbC007D44	CLR.L	-(SP)
	JSR	(lbC007F1A,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC007D74

lbW007D4E	dw	lbC006A88-lbC007D72
	dw	lbC007302-lbC007D72
	dw	lbC00768A-lbC007D72
	dw	lbC00796C-lbC007D72
	dw	lbC007A66-lbC007D72
	dw	lbC007B4A-lbC007D72
	dw	lbC007B90-lbC007D72
	dw	lbC007C6E-lbC007D72
	dw	lbC007AA4-lbC007D72
	dw	lbC007B74-lbC007D72

lbC007D62	CMP.L	#10,D0
	BCC.B	lbC007D74
	ASL.L	#1,D0
	MOVE.W	(lbW007D4E,PC,D0.W),D0
	JMP	(lbC007D72,PC,D0.W)
lbC007D72	EQU	*-2

lbC007D74	JSR	(lbC007F3A,PC)
	bra	lbC00736A

goldpieces.MSG	db	'50 gold pieces',0
hisbrothersbo.MSG	db	'his brother''s bones.',0
achest.MSG	db	'a chest',0
abrassurn.MSG	db	'a brass urn',0
somesacks.MSG	db	'some sacks',0
a.MSG3	db	'a ',0
ascii.MSG7	db	'.',0
nothing.MSG	db	'nothing.',0
a.MSG	db	'a ',0
ascii.MSG3	db	'.',0
a.MSG0	db	' a',0
anda.MSG	db	' and a ',0
keys.MSG	db	'3 keys.',0
ascii.MSG4	db	'3 ',0
s.MSG	db	's.',0
searchedthebo.MSG	db	'% searched the body and found',0
lbB007E09	db	0
a.MSG1	db	'a ',0
and.MSG	db	' and ',0
Arrows.MSG0	db	' Arrows.',0
and.MSG0	db	' and ',0
a.MSG2	db	'a ',0
nothing.MSG0	db	'nothing',0
ascii.MSG5	db	'.',0
ascii.MSG8	db	'+',0
Thatfeelsalot.MSG	db	'That feels a lot better!',0
boughta.MSG	db	'% bought a ',0
ascii.MSG6	db	'.',0
Notenoughmone.MSG	db	'Not enough money!',0
hasnokeys.MSG	db	'% has no keys!',0
doesnthaveone.MSG	db	'% doesn''t have one.',0
trieda.MSG	db	'% tried a ',0
butitdidnt.MSG	db	' but it didn''t',0
fit.MSG	db	'fit.',0

lbC007EAC	LINK.W	A5,#0
	CLR.L	(lbL011A2C-DT,A4)
lbC007EB4	JSR	(lbC00DF82-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW0119BC-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW0119BA-DT,A4),D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	CMP.L	#5,D0
	BEQ.B	lbC007EE4
	ADDQ.L	#1,(lbL011A2C-DT,A4)
	CMPI.L	#$19,(lbL011A2C-DT,A4)
	BLT.B	lbC007EB4
lbC007EE4	CMPI.L	#$19,(lbL011A2C-DT,A4)
	BNE.B	lbC007EF2
lbC007EEE	UNLK	A5
	RTS

lbC007EF2	MOVEQ	#0,D0
	MOVE.W	(lbW0119BC-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW0119BA-DT,A4),D1
	MOVE.L	D1,-(SP)
	PEA	(1).W
	JSR	(lbC00DF58-DT,A4)
	LEA	(12,SP),SP
	PEA	(5).W
	JSR	(lbC005EBA,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC007EEE

lbC007F1A	LINK.W	A5,#0
	BTST	#0,(lbB00EC01-DT,A4)
	BEQ.B	lbC007F2A
lbC007F26	UNLK	A5
	RTS

lbC007F2A	MOVE.W	(10,A5),(lbW01199C-DT,A4)
	CLR.B	(lbB012115-DT,A4)
	JSR	(lbC0067BC,PC)
	BRA.B	lbC007F26

lbC007F3A	LINK.W	A5,#0
	MOVEM.L	D4/D5,-(SP)
	MOVEQ	#0,D4
lbC007F44	MOVEA.L	D4,A0
	PEA	(9,A0)
	JSR	(lbC00DF6A-DT,A4)
	ADDQ.W	#4,SP
	LEA	(ascii.MSG18-DT,A4),A0
	MOVE.B	D0,(A0,D4.L)
	MOVE.L	D4,-(SP)
	JSR	(lbC00DF6A-DT,A4)
	ADDQ.W	#4,SP
	LEA	(ascii.MSG13-DT,A4),A0
	MOVE.B	D0,(A0,D4.L)
	ADDQ.L	#1,D4
	CMP.L	#7,D4
	BLT.B	lbC007F44
	MOVEQ	#8,D5
	MOVEQ	#0,D4
lbC007F76	MOVEA.L	D4,A0
	PEA	($10,A0)
	JSR	(lbC00DF6A-DT,A4)
	ADDQ.W	#4,SP
	LEA	(ascii.MSG14-DT,A4),A0
	MOVE.B	D0,(A0,D4.L)
	CMP.B	#10,D0
	BNE.B	lbC007F92
	MOVEQ	#10,D5
lbC007F92	ADDQ.L	#1,D4
	CMP.L	#6,D4
	BLT.B	lbC007F76
	MOVE.B	D5,(lbB00EC4B-DT,A4)
	PEA	(7).W
	JSR	(lbC00DF6A-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	D0,(lbB00EC4C-DT,A4)
	MOVEQ	#8,D5
	CMPI.W	#2,(lbW01197A-DT,A4)
	BLE.B	lbC007FBA
	MOVEQ	#10,D5
lbC007FBA	MOVE.B	D5,(lbB00EC37-DT,A4)
	MOVE.B	#8,(lbB00EC38-DT,A4)
	PEA	($1C).W
	JSR	(lbC00DF6A-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	D0,(lbB00EC39-DT,A4)
	PEA	($1D).W
	JSR	(lbC00DF6A-DT,A4)
	ADDQ.W	#4,SP
	MOVE.B	D0,(lbB00EC3A-DT,A4)
	MOVEM.L	(SP)+,D4/D5
	UNLK	A5
	RTS

lbC007FE8	LINK.W	A5,#0
lbC007FEC	CMPI.W	#10,(lbW0119C6-DT,A4)
	BCC.B	lbC007FF8
	BSR.B	read_tracks
	BRA.B	lbC007FEC

lbC007FF8	UNLK	A5
	RTS

read_tracks	LINK.W	A5,#0
	MOVEM.L	D4/A2/A3,-(SP)
	CMPI.W	#10,(lbW0119C6-DT,A4)
	BCS.B	lbC008014
lbC00800C	MOVEM.L	(SP)+,D4/A2/A3
	UNLK	A5
	RTS

lbC008014	MOVE.W	(lbW0119C6-DT,A4),D0
	MULU.W	#$12,D0
	LEA	(lbL00ED16-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	MOVE.W	(12,A2),D0
	CMP.W	(lbW00ED10-DT,A4),D0
	BEQ.B	lbC00804E
	CLR.L	-(SP)	;trackdisk_io index
	MOVE.L	(buffer_36864-DT,A4),-(SP)	;buffer address
	PEA	(64).W	;number of sectors
	MOVEQ	#0,D0
	MOVE.W	(12,A2),D0
	MOVE.L	D0,-(SP)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	MOVE.W	(12,A2),(lbW00ED10-DT,A4)
lbC00804E	MOVE.W	(14,A2),D0
	CMP.W	(lbW00ED12-DT,A4),D0
	BEQ.B	lbC008078
	CLR.L	-(SP)	;trackdisk_io index
	MOVE.L	(mid_buffer_36864-DT,A4),-(SP)	;buffer address
	PEA	(8).W	;number of sectors
	MOVEQ	#0,D0
	MOVE.W	(14,A2),D0
	MOVE.L	D0,-(SP)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	MOVE.W	(14,A2),(lbW00ED12-DT,A4)
lbC008078	MOVE.W	(8,A2),D0
	CMP.W	(lbW00ED0C-DT,A4),D0
	BEQ.B	lbC0080A8
	PEA	(1).W	;trackdisk_io index
	MOVE.L	(buffer_1024-DT,A4),-(SP)	;buffer address
	PEA	(1).W	;number of sectors
	MOVEQ	#0,D0
	MOVE.W	(8,A2),D0
	MOVEA.L	D0,A0
	PEA	($95,A0)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	MOVE.W	(8,A2),(lbW00ED0C-DT,A4)
lbC0080A8	MOVE.W	(10,A2),D0
	CMP.W	(lbW00ED0E-DT,A4),D0
	BEQ.B	lbC0080DC
	PEA	(2).W	;trackdisk_io index
	MOVEA.L	(buffer_1024-DT,A4),A0
	PEA	($200,A0)	;buffer address
	PEA	(1).W	;number of sectors
	MOVEQ	#0,D0
	MOVE.W	(10,A2),D0
	MOVEA.L	D0,A1
	PEA	($95,A1)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	MOVE.W	(10,A2),(lbW00ED0E-DT,A4)
lbC0080DC	MOVEQ	#0,D4
lbC0080DE	MOVE.L	D4,D0
	ASL.L	#1,D0
	MOVE.L	D4,D1
	ASL.L	#1,D1
	LEA	(lbL00ED04-DT,A4),A0
	MOVE.W	(A2,D0.L),D2
	CMP.W	(A0,D1.L),D2
	beq	lbC0081D6
	MOVE.L	D4,D0
	MOVEQ	#12,D1
	ASL.L	D1,D0
	MOVEA.L	D0,A3
	ADDA.L	(lbL011A54-DT,A4),A3
	PEA	(3).W	;trackdisk_io index
	MOVE.L	A3,-(SP)	;buffer address
	PEA	(8).W	;number of sectors
	MOVE.L	D4,D0
	ASL.L	#1,D0
	MOVEQ	#0,D1
	MOVE.W	(A2,D0.L),D1
	MOVE.L	D1,-(SP)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	PEA	(4).W	;trackdisk_io index
	PEA	($4000,A3)	;starting address
	PEA	(8).W	;number of sectors
	MOVE.L	D4,D0
	ASL.L	#1,D0
	MOVEQ	#0,D1
	MOVE.W	(A2,D0.L),D1
	ADDQ.L	#8,D1
	MOVE.L	D1,-(SP)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	PEA	(5).W	;trackdisk_io_index
	MOVEA.L	A3,A0
	ADDA.L	#$8000,A0
	MOVE.L	A0,-(SP)	;buffer address
	PEA	(8).W	;number of sectors
	MOVE.L	D4,D0
	ASL.L	#1,D0
	MOVEQ	#0,D1
	MOVE.W	(A2,D0.L),D1
	MOVEA.L	D1,A1
	PEA	($10,A1)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	PEA	(6).W	;trackdisk_io index
	MOVEA.L	A3,A0
	ADDA.L	#$C000,A0
	MOVE.L	A0,-(SP)	;buffer address
	PEA	(8).W	;number of sectors
	MOVE.L	D4,D0
	ASL.L	#1,D0
	MOVEQ	#0,D1
	MOVE.W	(A2,D0.L),D1
	MOVEA.L	D1,A1
	PEA	($18,A1)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	PEA	(7).W	;trackdisk_io index
	MOVEA.L	A3,A0
	ADDA.L	#$10000,A0
	MOVE.L	A0,-(SP)	;buffer address
	PEA	(8).W	;number of sectors
	MOVE.L	D4,D0
	ASL.L	#1,D0
	MOVEQ	#0,D1
	MOVE.W	(A2,D0.L),D1
	MOVEA.L	D1,A1
	PEA	($20,A1)	;starting sector
;	JSR	(_trackdisk_read-DT,A4)
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	MOVE.L	D4,D0
	ASL.L	#1,D0
	MOVE.L	D4,D1
	ASL.L	#1,D1
	LEA	(lbL00ED04-DT,A4),A0
	MOVE.W	(A2,D0.L),(A0,D1.L)
	bra	lbC00800C

lbC0081D6	ADDQ.L	#1,D4
	CMP.L	#4,D4
	blt	lbC0080DE
	CMPI.W	#4,(lbW0119C6-DT,A4)
	BNE.B	lbC00822A
	MOVEA.L	(lbL0119FC-DT,A4),A0
	CMPI.B	#5,($19,A0)
	BCC.B	lbC00822A
	MOVE.L	#$59A,D4
	MOVEA.L	(mid_buffer_36864-DT,A4),A0
	ADDA.L	D4,A0
	MOVE.B	#$FE,($81,A0)
	MOVEA.L	(mid_buffer_36864-DT,A4),A1
	ADDA.L	D4,A1
	MOVE.B	#$FE,($80,A1)
	MOVEA.L	(mid_buffer_36864-DT,A4),A6
	ADDA.L	D4,A6
	MOVE.B	#$FE,(1,A6)
	MOVEA.L	(mid_buffer_36864-DT,A4),A6
	MOVE.B	#$FE,(A6,D4.L)
lbC00822A
;	MOVEQ	#0,D4
;lbC00822C
;	MOVEQ	#$38,D1
;	MOVE.L	D4,D0
;	JSR	(__mulu-DT,A4)
;	LEA	(trackdisk_io_array-DT,A4),A0
;	ADD.L	A0,D0
;	MOVE.L	D0,(trackdisk_io_ptr-DT,A4)
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	CMPI.W	#CMD_READ,(IO_COMMAND,A0)	;!***************
;	BNE.B	lbC008254
;	MOVE.L	(trackdisk_io_ptr-DT,A4),-(SP)
;	JSR	(_WaitIO-DT,A4)	;!****************
;	ADDQ.W	#4,SP
;lbC008254
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	CLR.W	(IO_COMMAND,A0)	;!*******************
;	ADDQ.L	#1,D4
;	CMP.L	#7,D4
;	BLT.B	lbC00822C
;	JSR	(_trackdisk_motor_off-DT,A4)

	MOVE.W	(lbW0119C6-DT,A4),(lbW00ED02-DT,A4)
	MOVE.W	#10,(lbW0119C6-DT,A4)
	bra	lbC00800C

lbC00827A	LINK.W	A5,#0
	BTST	#0,(lbB00EC03-DT,A4)
	BEQ.B	lbC0082B6
	MOVE.L	(12,A5),-(SP)
	MOVE.W	(10,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbL011BD0-DT,A4),A0
	MOVE.L	(A0,D0.L),D1
	LSR.L	#1,D1
	MOVE.L	D1,-(SP)
	MOVE.W	(10,A5),D2
	EXT.L	D2
	ASL.L	#2,D2
	LEA	(lbL011BB8-DT,A4),A1
	MOVE.L	(A1,D2.L),-(SP)
	JSR	(_start_note-DT,A4)
	LEA	(12,SP),SP
lbC0082B6	UNLK	A5
	RTS

lbC0082BA	LINK.W	A5,#0
	PEA	($23).W
	PEA	(lbL011C20-DT,A4)
	JSR	(lbC00DF52-DT,A4)
	ADDQ.W	#8,SP
	PEA	($23).W
	PEA	(lbB011C43-DT,A4)
	JSR	(lbC00DF52-DT,A4)
	ADDQ.W	#8,SP
	PEA	($23).W
	PEA	(lbL011C66-DT,A4)
	JSR	(lbC00DF52-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	(lbW011980-DT,A4),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	ASL.L	#3,D0
	LEA	(lbL00EE8A-DT,A4),A0
	MOVE.L	(A0,D0.L),(lbL0119FC-DT,A4)
	PEA	($3C).W
	PEA	(lbL011DEE-DT,A4)
	JSR	(lbC00DF52-DT,A4)
	ADDQ.W	#8,SP
	UNLK	A5
	RTS

	super
my_trap_code	MOVE.L	(SP)+,(4,A1)
	RTE

input_handler	MOVEM.L	D1/D2/A1-A3,-(SP)
	MOVEA.L	A0,A2
	LEA	(keymap,PC),A3
lbC00831E	MOVE.B	(ie_Class,A0),D0
	CMP.B	#IECLASS_RAWKEY,D0
	BNE.B	lbC00836A
	MOVE.W	(ie_Code,A0),D0
	MOVE.B	D0,D1
	AND.B	#$7F,D0
	CMP.B	#$5A,D0
	BHI.W	lbC0083E8
	MOVE.W	#IECLASS_NULL,(ie_Class,A0)
	MOVE.B	(A3,D0.W),D0
	AND.B	#$80,D1
	OR.B	D1,D0
	CLR.W	D1
	MOVE.B	(6,A1),D1
	MOVE.B	D0,($16,A1,D1.W)
	ADDQ.B	#1,D1
	AND.B	#$7F,D1
	CMP.B	(7,A1),D1
	beq	lbC008454
	MOVE.B	D1,(6,A1)
	bra	lbC008454

lbC00836A	CMP.B	#IECLASS_RAWMOUSE,D0
	BNE.B	lbC0083E8
	MOVE.W	(ie_Qualifier,A0),D1
	MOVE.W	(4,A1),D0
	EOR.W	D1,D0
	AND.W	#$4000,D0
	BEQ.B	lbC0083E2
	AND.W	#$4000,D1
	BNE.B	lbC008396
	MOVE.B	(9,A1),D1
	BEQ.B	lbC0083E2
	OR.B	#$80,D1
	CLR.B	(9,A1)
	BRA.B	lbC0083C2

lbC008396	CLR.L	D1
	MOVE.W	(A1),D0
	MOVE.W	(2,A1),D1
	CMP.W	#$D7,D0
	BCS.B	lbC0083E2
	CMP.W	#$109,D0
	BHI.B	lbC0083E2
	SUB.W	#$90,D1
	BMI.B	lbC0083E2
	DIVU.W	#9,D1
	ADD.W	D1,D1
	ADD.W	#$61,D1
	CMP.W	#$F0,D0
	BCS.B	lbC0083C2
	ADDQ.W	#1,D1
lbC0083C2	MOVE.W	D1,D0
	CLR.W	D1
	MOVE.B	(6,A1),D1
	MOVE.B	D0,($16,A1,D1.W)
	ADDQ.B	#1,D1
	AND.B	#$7F,D1
	CMP.B	(7,A1),D1
	BEQ.B	lbC0083E2
	MOVE.B	D1,(6,A1)
	MOVE.B	D0,(9,A1)
lbC0083E2	MOVE.W	(ie_Qualifier,A0),(4,A1)
lbC0083E8	CMP.B	#IECLASS_DISKINSERTED,D0
	BNE.B	lbC0083F4
	MOVE.B	#1,(8,A1)
lbC0083F4	MOVE.W	(A1),D0
	MOVE.W	(2,A1),D1
	ADD.W	(10,A0),D0
	ADD.W	(12,A0),D1
	CMP.W	#$13B,D0
	BLT.B	lbC00840C
	MOVE.W	#$13B,D0
lbC00840C	CMP.W	#5,D0
	BGT.B	lbC008416
	MOVE.W	#5,D0
lbC008416	CMP.W	#$C3,D1
	BLT.B	lbC008420
	MOVE.W	#$C3,D1
lbC008420	CMP.W	#$93,D1
	BGT.B	lbC00842A
	MOVE.W	#$93,D1
lbC00842A	MOVE.W	D0,(A1)
	MOVE.W	D1,(2,A1)
	TST.L	(14,A1)
	BEQ.B	lbC008454
	MOVEM.L	A0/A1/A6,-(SP)
	ADD.W	D0,D0
	SUB.W	#$8F,D1
	MOVEA.L	(10,A1),A6
	MOVEA.L	($12,A1),A0
	MOVEA.L	(14,A1),A1
	JSR	(-$1AA,A6)
	MOVEM.L	(SP)+,A0/A1/A6
lbC008454	MOVEA.L	(ie_NextEvent,A0),A0
	MOVE.L	A0,D0
	bne	lbC00831E
	CLR.L	D0
	MOVEM.L	(SP)+,D1/D2/A1-A3
	RTS

keymap	dl	$60313233
	dl	$34353637
	dl	$3839302D
	dl	$3D5C3F30
	dl	$51574552
	dl	$54595549
	dl	$4F507B7D
	dl	$3F1A1918
	dl	$41534446
	dl	$47484A4B
	dl	$4C3A3F3F
	dl	$3F1B1D17
	dl	$3F5A5843
	dl	$56424E4D
	dl	$2C2E3F3F
	dl	$2E141516
	dl	$2008090D
	dl	$D1B7F00
	dl	$2D00
	dl	$1020304
	dl	$A0B0C0D
	dl	$E0F1011
	dl	$12130000
	dl	0

get_key_perhaps	MOVEM.L	D1/A1,-(SP)
	LEA	(lbW01210C-DT,A4),A1
	CLR.L	D0
	CLR.W	D1
	MOVE.B	(7,A1),D1
	CMP.B	(6,A1),D1
	BEQ.B	lbC0084E8
	MOVE.B	($16,A1,D1.W),D0
	ADDQ.W	#1,D1
	AND.B	#$7F,D1
	MOVE.B	D1,(7,A1)
lbC0084E8	MOVEM.L	(SP)+,D1/A1
	RTS

lbC0084EE	MOVE.L	(lbL00EDE2-DT,A4),D0
	MULU.W	#45821,D0
	ADDQ.L	#1,D0
	MOVE.L	D0,(lbL00EDE2-DT,A4)
	ROR.L	#6,D0
	AND.L	#$7FFFFFFF,D0
	RTS

lbC008506	BSR.B	lbC0084EE
	AND.L	(4,SP),D0
	RTS

lbC00850E	BSR.B	lbC0084EE
	AND.L	#1,D0
	RTS

lbC008518	BSR.B	lbC0084EE
	AND.L	#3,D0
	RTS

lbC008522	BSR.B	lbC0084EE
	AND.L	#7,D0
	RTS

lbC00852C	BSR.B	lbC0084EE
	AND.L	#$3F,D0
	RTS

lbC008536	BSR.B	lbC0084EE
	AND.L	#$FF,D0
	RTS

lbC008540	BSR.B	lbC0084EE
	MOVE.L	(4,SP),D1
	AND.L	#$FFFF,D0
	DIVU.W	D1,D0
	CLR.W	D0
	SWAP	D0
	RTS

lbC008554	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVE.L	($40,SP),D0
	BSR.B	lbC008580
	ADDA.W	#10,A0
	MOVE.L	($44,SP),D0
	SUBA.W	D0,A0
	ADDQ.W	#1,D0
	MOVEA.L	(active_rp_ptr-DT,A4),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOText,A6)
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

	MOVE.L	(4,SP),D0
lbC008580	LEA	(lbL00EA5C-DT,A4),A0
	MOVEQ	#9,D1
	BRA.B	lbC00858C

lbC008588	TST.W	D0
	BEQ.B	lbC0085A4
lbC00858C	DIVU.W	#10,D0
	SWAP	D0
	ADD.B	#$30,D0
	MOVE.B	D0,(A0,D1.W)
	CLR.W	D0
	SWAP	D0
	DBRA	D1,lbC008588
	RTS

lbC0085A4	MOVE.B	#$20,(A0,D1.W)
	DBRA	D1,lbC0085A4
	RTS

lbL0085B0	dl	$FCFCFC00
	dl	$404
	dl	$FC0004
	dl	$4000000
	dl	4
	dl	$4040000
	dl	$FC00FC00
	dl	$40404

lbC0085D0	MOVEM.L	D0-D7/A0-A6,-(SP)
	LEA	(rp1-DT,A4),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	MOVEQ	#12,D6
	MOVEQ	#0,D7
	MOVEQ	#$10,D4
lbC0085E2	MOVE.L	D4,-(SP)
	MOVEQ	#15,D5
	LEA	(lbL0085B0,PC),A2
lbC0085EA	CLR.L	D0
	MOVE.L	D7,D3
	MOVE.B	($10,A2),D0
	EXT.W	D0
	EXT.L	D0
	ADD.W	D0,D3
	MOVE.L	D6,D2
	MOVE.B	(A2)+,D0
	EXT.W	D0
	EXT.L	D0
	ADD.W	D0,D2
	MOVEQ	#4,D4
lbC008604	MOVEQ	#1,D0
	TST.W	D4
	BNE.B	lbC00860E
	ADD.W	#$17,D0
lbC00860E	JSR	(_LVOSetAPen,A6)
	MOVE.L	(SP),D0
	CMP.L	#9,D0
	BLS.B	lbC00864C
	MOVE.L	D6,D0
	MOVE.L	D7,D1
	JSR	(_LVOMove,A6)
	MOVE.L	D2,D0
	MOVE.L	D3,D1
	JSR	(_LVODraw,A6)
	MOVE.W	#$11C,D0
	SUB.L	D6,D0
	MOVE.W	#$7C,D1
	SUB.L	D7,D1
	JSR	(_LVOMove,A6)
	MOVE.W	#$11C,D0
	SUB.L	D2,D0
	MOVE.W	#$7C,D1
	SUB.L	D3,D1
	JSR	(_LVODraw,A6)
lbC00864C	MOVEQ	#$10,D0
	ADD.L	D7,D0
	MOVEQ	#12,D1
	SUB.L	D6,D1
	JSR	(_LVOMove,A6)
	MOVEQ	#$10,D0
	ADD.L	D3,D0
	MOVEQ	#12,D1
	SUB.L	D2,D1
	JSR	(_LVODraw,A6)
	MOVE.W	#$10C,D0
	SUB.L	D7,D0
	MOVEQ	#$70,D1
	ADD.L	D6,D1
	JSR	(_LVOMove,A6)
	MOVE.W	#$10C,D0
	SUB.L	D3,D0
	MOVEQ	#$70,D1
	ADD.L	D2,D1
	JSR	(_LVODraw,A6)
	DBRA	D4,lbC008604
	MOVE.L	D2,D6
	MOVE.L	D3,D7
	DBRA	D5,lbC0085EA
	MOVE.L	(SP)+,D4
	DBRA	D4,lbC0085E2
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

lbC008698	MOVEM.L	D0/D1/A0-A2,-(SP)
	MOVE.L	($18,SP),D0
	MOVE.L	($1C,SP),D1
	MOVEA.L	(active_rp_ptr-DT,A4),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOMove,A6)
	MOVEM.L	(SP)+,D0/D1/A0-A2
	RTS

lbC0086B6	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVEA.L	($40,SP),A0
	MOVE.L	($44,SP),D0
	MOVEA.L	(active_rp_ptr-DT,A4),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOText,A6)
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

lbC0086D4	MOVEA.L	(4,SP),A0
	MOVEM.L	D0/D1/A0-A2,-(SP)
	MOVEA.L	(active_rp_ptr-DT,A4),A1
lbC0086E0	MOVEA.L	A0,A2
	MOVE.B	(A0)+,D0
	BEQ.B	lbC008722
	CMP.B	#$80,D0
	BEQ.B	lbC00870E
	MOVEA.L	A2,A0
	CLR.L	D0
lbC0086F0	TST.B	(A2)+
	BEQ.B	lbC0086FA
	BMI.B	lbC0086FA
	ADDQ.W	#1,D0
	BRA.B	lbC0086F0

lbC0086FA	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOText,A6)
	MOVEM.L	(SP)+,D0-D7/A0-A6
	ADDA.W	D0,A0
	BRA.B	lbC0086E0

lbC00870E	CLR.L	D0
	CLR.L	D1
	MOVE.B	(A0)+,D0
	MOVE.B	(A0)+,D1
	ADD.W	D0,D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOMove,A6)
	BRA.B	lbC0086E0

lbC008722	MOVEM.L	(SP)+,D0/D1/A0-A2
	RTS

lbC008728	MOVE.L	(4,SP),D0
	MOVE.L	(8,SP),D1
lbC008730	MOVEM.L	D2-D4/A1,-(SP)
	MOVE.B	#$80,D4
	BTST	#3,D0
	BEQ.B	lbC008740
	LSR.B	#4,D4
lbC008740	BTST	#3,D1
	BEQ.B	lbC008748
	LSR.B	#1,D4
lbC008748	BTST	#4,D1
	BEQ.B	lbC008750
	LSR.B	#2,D4
lbC008750	LSR.W	#4,D0
	LSR.W	#5,D1
	MOVE.W	D0,D2
	LSR.W	#4,D2
	SUB.W	(lbW0119C2-DT,A4),D2
	BTST	#6,D2
	BEQ.B	lbC00876C
	BTST	#5,D2
	SEQ	D2
	AND.W	#$3F,D2
lbC00876C	MOVE.W	D1,D3
	LSR.W	#3,D3
	SUB.W	(lbW0119C4-DT,A4),D3
	BPL.B	lbC008778
	CLR.W	D3
lbC008778	CMP.W	#$20,D3
	BLT.B	lbC008780
	MOVEQ	#$1F,D3
lbC008780	LSL.W	#7,D3
	ADD.W	D2,D3
	ADD.W	(lbW0119C2-DT,A4),D3
	MOVEA.L	(mid_buffer_36864-DT,A4),A0
	MOVEA.L	(buffer_36864-DT,A4),A1
	CLR.W	D2
	MOVE.B	(A0,D3.W),D2
	AND.W	#15,D0
	AND.W	#7,D1
	LSL.W	#7,D2
	LSL.W	#4,D1
	OR.W	D1,D2
	OR.W	D0,D2
	CLR.W	D1
	MOVE.B	(A1,D2.W),D1
	CLR.L	D0
	ADD.W	D1,D1
	ADD.W	D1,D1
	MOVEA.L	(buffer_1024-DT,A4),A1
	AND.B	(2,A1,D1.W),D4
	BEQ.B	lbC0087C2
	MOVE.B	(1,A1,D1.W),D0
	LSR.B	#4,D0
lbC0087C2	MOVEM.L	(SP)+,D2-D4/A1
	RTS

lbC0087C8	MOVEM.L	D1-D3/A0/A1,-(SP)
	MOVEA.L	(DosBase-DT,A4),A6
	MOVE.L	(lbL011918-DT,A4),D1
	MOVE.L	#lbL011920,D2
	MOVEQ	#4,D3
	JSR	(_LVORead,A6)
	SUBQ.L	#4,(lbL011910-DT,A4)
	MOVEM.L	(SP)+,D1-D3/A0/A1
	RTS

lbC0087EA	MOVEM.L	D1-D3/A0/A1,-(SP)
	MOVEA.L	(DosBase-DT,A4),A6
	MOVE.L	(lbL011918-DT,A4),D1
	MOVE.L	#lbL011914,D2
	MOVEQ	#4,D3
	JSR	(_LVORead,A6)
	MOVE.L	(lbL011914-DT,A4),D1
	ADDQ.L	#4,D1
	SUB.L	D1,(lbL011910-DT,A4)
	MOVEM.L	(SP)+,D1-D3/A0/A1
	RTS

lbC008812	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVEA.L	(lbL011A54-DT,A4),A6
	MOVE.L	A6,-(SP)
	LEA	(lbL01181E-DT,A4),A6
	MOVE.L	#$4000,D1
	MOVE.L	#$8000,D2
	MOVE.L	#$C000,D3
	MOVE.L	#$10000,D4
	MOVEA.L	(lbL011A98-DT,A4),A4
	MOVEA.L	(A4),A0
	MOVEA.L	(4,A4),A1
	MOVEA.L	(8,A4),A2
	MOVEA.L	(12,A4),A3
	MOVEA.L	($10,A4),A4
	CLR.L	D7
	MOVE.W	#0,D5
	BSR.B	lbC0088CA
	MOVE.W	#2,D5
	BSR.B	lbC0088CA
	MOVE.W	#4,D5
	BSR.B	lbC0088CA
	MOVE.W	#6,D5
	BSR.B	lbC0088CA
	MOVE.W	#8,D5
	BSR.B	lbC0088CA
	MOVE.W	#10,D5
	BSR.B	lbC0088CA
	MOVE.W	#12,D5
	BSR.B	lbC0088CA
	MOVE.W	#14,D5
	BSR.B	lbC0088CA
	MOVE.W	#$10,D5
	BSR.B	lbC0088CA
	MOVE.W	#$12,D5
	BSR.B	lbC0088CA
	MOVE.W	#$14,D5
	BSR.B	lbC0088CA
	MOVE.W	#$16,D5
	BSR.B	lbC0088CA
	MOVE.W	#$18,D5
	BSR.B	lbC0088CA
	MOVE.W	#$1A,D5
	BSR.B	lbC0088CA
	MOVE.W	#$1C,D5
	BSR.B	lbC0088CA
	MOVE.W	#$1E,D5
	BSR.B	lbC0088CA
	MOVE.W	#$20,D5
	BSR.B	lbC0088CA
	MOVE.W	#$22,D5
	BSR.B	lbC0088CA
	MOVE.W	#$24,D5
	BSR.B	lbC0088CA
	ADDQ.L	#4,SP
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

lbC0088CA	MOVE.W	(A6)+,D7
	BSR.B	lbC0088E4
	MOVE.W	(A6)+,D7
	BSR.B	lbC0088E4
	MOVE.W	(A6)+,D7
	BSR.B	lbC0088E4
	MOVE.W	(A6)+,D7
	BSR.B	lbC0088E4
	MOVE.W	(A6)+,D7
	BSR.B	lbC0088E4
	MOVE.W	(A6)+,D7
	BSR.B	lbC0088E4
	RTS

lbC0088E4	LSL.L	#6,D7
	MOVEA.L	(8,SP),A5
	LEA	(A5,D7.W),A5
	MOVE.W	#15,D6
lbC0088F2	MOVE.W	(A5,D4.L),(A4,D5.W)
	MOVE.W	(A5,D3.L),(A3,D5.W)
	MOVE.W	(A5,D2.L),(A2,D5.W)
	MOVE.W	(A5,D1.L),(A1,D5.W)
	MOVE.W	(A5)+,(A0,D5.W)
	ADD.L	#$28,D5
	MOVE.W	(A5,D4.L),(A4,D5.W)
	MOVE.W	(A5,D3.L),(A3,D5.W)
	MOVE.W	(A5,D2.L),(A2,D5.W)
	MOVE.W	(A5,D1.L),(A1,D5.W)
	MOVE.W	(A5)+,(A0,D5.W)
	ADD.L	#$28,D5
	DBRA	D6,lbC0088F2
	CLR.L	D7
	RTS

	ADD.L	#$500,D5
	CLR.L	D7
	RTS

lbC008948	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVE.L	($40,SP),D5
	MOVEA.L	(lbL011A54-DT,A4),A6
	MOVE.L	A6,-(SP)
	LEA	(lbL01181E-DT,A4),A6
	ADDA.L	D5,A6
	ADDA.L	D5,A6
	ADDA.L	D5,A6
	ADDA.L	D5,A6
	ADDA.L	D5,A6
	ADDA.L	D5,A6
	MOVE.L	#$4000,D1
	MOVE.L	#$8000,D2
	MOVE.L	#$C000,D3
	MOVE.L	#$10000,D4
	MOVEA.L	(lbL011A98-DT,A4),A4
	MOVEA.L	(A4),A0
	MOVEA.L	(4,A4),A1
	MOVEA.L	(8,A4),A2
	MOVEA.L	(12,A4),A3
	MOVEA.L	($10,A4),A4
	CLR.L	D7
	BSR.W	lbC0088CA
	ADDQ.L	#4,SP
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

lbC0089A2	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVE.L	($40,SP),D0
	MOVEA.L	(lbL011A54-DT,A4),A6
	MOVE.L	A6,-(SP)
	LEA	(lbL01181E-DT,A4),A6
	ADDA.L	D0,A6
	MULU.W	#$280,D0
	MOVE.L	#$4000,D1
	MOVE.L	#$8000,D2
	MOVE.L	#$C000,D3
	MOVE.L	#$10000,D4
	MOVEA.L	(lbL011A98-DT,A4),A4
	MOVEA.L	(A4),A0
	MOVEA.L	(4,A4),A1
	MOVEA.L	(8,A4),A2
	MOVEA.L	(12,A4),A3
	MOVEA.L	($10,A4),A4
	CLR.L	D7
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#2,D0
	BSR.B	lbC008A3C
	ADDQ.L	#4,SP
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

lbC008A3C	MOVE.L	D0,D5
	MOVE.W	(A6),D7
	BSR.W	lbC0088E4
	ADDA.W	#12,A6
	RTS

lbC008A4A	MOVEM.L	D1-D7/A0-A6,-(SP)
	MOVEA.L	(mid_buffer_36864-DT,A4),A0
	MOVEA.L	(buffer_36864-DT,A4),A1
	MOVE.L	($3C,SP),D0
	MOVE.L	($40,SP),D1
	LSR.W	#8,D0
	SUB.W	#9,D0
	SUB.W	(lbW0119C2-DT,A4),D0
	LSR.W	#8,D1
	SUBQ.W	#4,D1
	SUB.W	(lbW0119C4-DT,A4),D1
	CMP.W	#$20,D0
	BGE.B	lbC008A7A
	ADD.W	#$80,D0
lbC008A7A	CMP.W	#$60,D0
	BLE.B	lbC008A84
	SUB.W	#$80,D0
lbC008A84	CMP.W	#$20,D1
	BGE.B	lbC008A8E
	ADD.W	#$80,D1
lbC008A8E	CMP.W	#$60,D1
	BLE.B	lbC008A98
	SUB.W	#$80,D1
lbC008A98	CMP.W	#0,D0
	BGE.B	lbC008AA0
	CLR.W	D0
lbC008AA0	CMP.W	#$2E,D0
	BLE.B	lbC008AAA
	MOVE.W	#$2E,D0
lbC008AAA	CMP.W	#0,D1
	BGE.B	lbC008AB2
	CLR.W	D1
lbC008AB2	CMP.W	#$17,D1
	BLE.B	lbC008ABC
	MOVE.W	#$17,D1
lbC008ABC	MOVE.L	D0,(lbL011AB8-DT,A4)
	MOVE.L	D1,(lbL011ABC-DT,A4)
	CLR.L	D7
	CLR.W	D2
lbC008AC8	MOVE.W	D2,D4
	ADD.W	D1,D4
	LSL.W	#7,D4
	CLR.W	D3
lbC008AD0	MOVE.W	(lbW0119C2-DT,A4),D5
	ADD.W	D0,D5
	ADD.W	D3,D5
	ADD.W	D4,D5
	CLR.L	D6
	MOVE.B	(A0,D5.W),D6
	LSL.W	#7,D6
	ADD.L	A1,D6
	BSR.B	lbC008B04
	ADDQ.L	#2,D7
	ADDQ.W	#1,D3
	CMP.W	#$12,D3
	BLT.B	lbC008AD0
	ADD.L	#$25C,D7
	ADDQ.W	#1,D2
	CMP.W	#9,D2
	BLT.B	lbC008AC8
	MOVEM.L	(SP)+,D1-D7/A0-A6
	RTS

lbC008B04	MOVEM.L	D0-D7/A0-A6,-(SP)
	MOVEA.L	D6,A6
	MOVE.L	D7,D0
	MOVEA.L	(lbL011A98-DT,A4),A0
	MOVEA.L	($10,A0),A5
	MOVEA.L	(12,A0),A3
	MOVEA.L	(8,A0),A2
	MOVEA.L	(4,A0),A1
	MOVEA.L	(A0),A0
	MOVE.L	A0,(lbL011AC0-DT,A4)
	ADDA.L	D0,A0
	ADDA.L	D0,A1
	ADDA.L	D0,A2
	ADDA.L	D0,A3
	ADDA.L	D0,A5
	MOVEA.L	(buffer_1024-DT,A4),A4
	MOVE.W	#7,D7
lbC008B38	MOVE.W	#15,D6
lbC008B3C	CLR.W	D5
	MOVE.B	(A6)+,D5
	ADD.W	D5,D5
	ADD.W	D5,D5
	MOVE.B	(3,A4,D5.W),D5
	ROXR.B	#1,D5
	ROXL.W	#1,D0
	ROXR.B	#1,D5
	ROXL.W	#1,D1
	ROXR.B	#1,D5
	ROXL.W	#1,D2
	ROXR.B	#1,D5
	ROXL.W	#1,D3
	ROXR.B	#1,D5
	ROXL.W	#1,D4
	DBRA	D6,lbC008B3C
	MOVE.W	D0,(A0)
	MOVE.W	D0,($28,A0)
	ADDA.W	#$50,A0
	MOVE.W	D1,(A1)
	MOVE.W	D1,($28,A1)
	ADDA.W	#$50,A1
	MOVE.W	D2,(A2)
	MOVE.W	D2,($28,A2)
	ADDA.W	#$50,A2
	MOVE.W	D3,(A3)
	MOVE.W	D3,($28,A3)
	ADDA.W	#$50,A3
	MOVE.W	D4,(A5)
	MOVE.W	D4,($28,A5)
	ADDA.W	#$50,A5
	DBRA	D7,lbC008B38
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

lbC008B9C	MOVEM.L	D2-D6/A0/A1,-(SP)
	MOVEA.L	(lbL011A68-DT,A4),A0
	ADDQ.W	#2,A0
	MOVEA.L	(buffer_12288-DT,A4),A1
	MOVE.L	($20,SP),D3
	MOVE.L	($24,SP),D4
	MOVE.L	($28,SP),D2
	MOVE.L	($2C,SP),D0
	ADD.L	D2,D2
	LSL.L	#6,D0
	LEA	(A1,D0.W),A1
	MULU.W	D2,D4
	LSL.W	#5,D4
	ADD.W	D3,D4
	ADD.W	D3,D4
	LEA	(A0,D4.W),A0
	MOVE.W	#7,D6
lbC008BD2	MOVE.W	(A1)+,(A0)
	ADDA.W	D2,A0
	MOVE.W	(A1)+,(A0)
	ADDA.W	D2,A0
	MOVE.W	(A1)+,(A0)
	ADDA.W	D2,A0
	MOVE.W	(A1)+,(A0)
	ADDA.W	D2,A0
	DBRA	D6,lbC008BD2
	MOVEM.L	(SP)+,D2-D6/A0/A1
	RTS

lbC008BEC	MOVE.L	(4,SP),D0
	MOVE.L	(8,SP),D1
	MOVEM.L	D2-D4/A1,-(SP)
	MOVE.W	D0,D2
	LSR.W	#4,D2
	SUB.W	(lbW0119C2-DT,A4),D2
	BTST	#6,D2
	BEQ.B	lbC008C10
	BTST	#5,D2
	SEQ	D2
	AND.W	#$3F,D2
lbC008C10	MOVE.W	D1,D3
	LSR.W	#3,D3
	SUB.W	(lbW0119C4-DT,A4),D3
	BTST	#5,D3
	BEQ.B	lbC008C28
	BTST	#4,D3
	SEQ	D3
	AND.W	#$1F,D3
lbC008C28	LSL.W	#7,D3
	ADD.W	D2,D3
	ADD.W	(lbW0119C2-DT,A4),D3
	MOVEA.L	(mid_buffer_36864-DT,A4),A0
	MOVEA.L	(buffer_36864-DT,A4),A1
	CLR.W	D2
	MOVE.B	(A0,D3.W),D2
	AND.W	#15,D0
	AND.W	#7,D1
	LSL.W	#7,D2
	LSL.W	#4,D1
	OR.W	D1,D2
	OR.W	D0,D2
	ADDA.W	D2,A1
	MOVE.L	A1,D0
	MOVEM.L	(SP)+,D2-D4/A1
	RTS

lbC008C58	MOVE.L	(4,SP),D1
	MOVE.L	(8,SP),D0
	MOVEM.L	D0-D7/A0-A2,-(SP)
	MOVE.L	D0,D2
	MOVEA.L	(mid_buffer_36864-DT,A4),A1
	MOVEA.L	(buffer_36864-DT,A4),A2
	LEA	(lbL01181E-DT,A4),A0
	CLR.W	D0
	CLR.W	D6
lbC008C76	AND.W	#$7FF,D1
	MOVE.W	D1,D3
	LSR.W	#4,D3
	SUB.W	(lbW0119C2-DT,A4),D3
	BTST	#6,D3
	BEQ.B	lbC008C92
	BTST	#5,D3
	SEQ	D3
	AND.W	#$3F,D3
lbC008C92	ADD.W	(lbW0119C2-DT,A4),D3
	CLR.W	D7
lbC008C98	MOVE.W	D2,D4
	ADD.W	D7,D4
	AND.W	#$7FFF,D4
	MOVE.W	D4,D5
	LSR.W	#3,D5
	SUB.W	(lbW0119C4-DT,A4),D5
	BPL.B	lbC008CAC
	CLR.W	D5
lbC008CAC	CMP.W	#$20,D5
	BCS.B	lbC008CB6
	MOVE.W	#$1F,D5
lbC008CB6	LSL.W	#7,D5
	ADD.W	D3,D5
	MOVE.B	(A1,D5.W),D0
	MOVE.W	D0,D5
	LSL.W	#7,D5
	AND.W	#7,D4
	LSL.W	#4,D4
	ADD.W	D4,D5
	MOVE.W	D1,D4
	AND.W	#15,D4
	ADD.W	D4,D5
	MOVE.B	(A2,D5.W),D0
	MOVE.W	D0,(A0)+
	ADDQ.W	#1,D7
	CMP.W	#6,D7
	BLT.B	lbC008C98
	ADDQ.W	#1,D1
	ADDQ.W	#1,D6
	CMP.W	#$13,D6
	BLT.B	lbC008C76
	CLR.L	D0
	CLR.L	D1
	CLR.L	D2
	MOVE.B	(lbW01195A-DT,A4),D0
	MOVE.B	(lbW01195C-DT,A4),D1
	SUB.W	(lbW0119C4-DT,A4),D1
	LSL.W	#7,D1
	ADD.W	D1,D0
	MOVE.B	(A1,D0.W),D2
	MOVE.W	(lbW00ED02-DT,A4),D0
	CMP.B	#7,D0
	BLS.B	lbC008D12
	ADD.W	#$100,D2
lbC008D12	MOVE.W	D2,(lbW011984-DT,A4)
	MOVEM.L	(SP)+,D0-D7/A0-A2
	RTS

lbC008D1C	TST.B	(lbB011924-DT,A4)
	BNE.B	lbC008D3E
	MOVEA.L	(4,SP),A0
	MOVE.L	(lbL011926-DT,A4),D1
	MOVEA.L	(lbL01192A-DT,A4),A1
	SUBQ.W	#1,D1
	BMI.B	lbC008D38
lbC008D32	MOVE.B	(A1)+,(A0)+
	DBRA	D1,lbC008D32
lbC008D38	MOVE.L	A1,(lbL01192A-DT,A4)
	RTS

lbC008D3E	MOVEA.L	(4,SP),A0
	MOVEA.L	(lbL01192A-DT,A4),A1
	CLR.L	D2
lbC008D48	CLR.W	D0
	MOVE.B	(A1)+,D0
	BMI.B	lbC008D58
lbC008D4E	ADDQ.L	#1,D2
	MOVE.B	(A1)+,(A0)+
	DBRA	D0,lbC008D4E
	BRA.B	lbC008D64

lbC008D58	NEG.B	D0
	MOVE.B	(A1)+,D3
lbC008D5C	ADDQ.L	#1,D2
	MOVE.B	D3,(A0)+
	DBRA	D0,lbC008D5C
lbC008D64	CMP.L	(lbL011926-DT,A4),D2
	BCS.B	lbC008D48
	MOVE.L	A1,(lbL01192A-DT,A4)
	RTS

lbL008D70	dl	$FFFE0000
	dl	$20003
	dl	$20000
	dl	$FFFEFFFD
	dl	0
lbL008D84	dl	$FFFEFFFD
	dl	$FFFE0000
	dl	$20003
	dl	$20000
	dl	0

lbC008D98	MOVE.L	(4,SP),D0
	MOVE.L	(8,SP),D2
	CMP.B	#7,D2
	BHI.B	lbC008DC0
	MOVE.L	(12,SP),D3
	LEA	(lbL008D70,PC),A0
	ADD.B	D2,D2
	MOVE.W	(A0,D2.W),D2
	MULS.W	D2,D3
	LSR.W	#1,D3
	ADD.W	D3,D0
	AND.L	#$7FFF,D0
lbC008DC0	RTS

lbC008DC2	MOVE.L	(4,SP),D0
	MOVE.L	(8,SP),D2
	CMP.B	#7,D2
	BHI.B	lbC008DF2
	MOVE.L	(12,SP),D3
	MOVE.L	D0,D1
	LEA	(lbL008D84,PC),A0
	ADD.B	D2,D2
	MOVE.W	(A0,D2.W),D2
	MULS.W	D2,D3
	LSR.W	#1,D3
	ADD.W	D3,D0
	AND.L	#$7FFF,D0
	AND.W	#$8000,D1
	OR.W	D1,D0
lbC008DF2	RTS

lbC008DF4	MOVE.L	(4,SP),D0
	BTST	#14,D0
	BEQ.B	lbC008E04
	OR.W	#$8000,D0
	RTS

lbC008E04	AND.W	#$7FFF,D0
	RTS

lbC008E0A	MOVE.L	(4,SP),D0
	MOVE.L	(8,SP),D1
	MOVEM.L	D2/D3,-(SP)
	SUB.W	#$90,D0
	SUB.W	#$46,D1
	MOVE.W	D0,D2
	MOVE.W	D1,D3
	SUB.W	(lbW011956-DT,A4),D2
	SUB.W	(lbW011958-DT,A4),D3
	LSL.W	#1,D2
	ASR.W	#1,D2
	LSL.W	#1,D3
	ASR.W	#1,D3
	CMP.W	#$FFBA,D2
	BGE.B	lbC008E42
	ADD.W	#$46,D0
	MOVE.W	D0,(lbW011956-DT,A4)
	BRA.B	lbC008E68

lbC008E42	CMP.W	#$46,D2
	BLE.B	lbC008E52
	SUB.W	#$46,D0
	MOVE.W	D0,(lbW011956-DT,A4)
	BRA.B	lbC008E68

lbC008E52	CMP.W	#$FFEC,D2
	BGE.B	lbC008E5E
	SUBQ.W	#1,(lbW011956-DT,A4)
	BRA.B	lbC008E68

lbC008E5E	CMP.W	#$14,D2
	BLE.B	lbC008E68
	ADDQ.W	#1,(lbW011956-DT,A4)
lbC008E68	CMP.W	#$FFE8,D3
	BGE.B	lbC008E78
	ADD.W	#$18,D1
	MOVE.W	D1,(lbW011958-DT,A4)
	BRA.B	lbC008E9E

lbC008E78	CMP.W	#$2C,D3
	BLE.B	lbC008E88
	SUB.W	#$2C,D1
	MOVE.W	D1,(lbW011958-DT,A4)
	BRA.B	lbC008E9E

lbC008E88	CMP.W	#$FFF6,D3
	BGE.B	lbC008E94
	SUBQ.W	#1,(lbW011958-DT,A4)
	BRA.B	lbC008E9E

lbC008E94	CMP.W	#10,D3
	BLE.B	lbC008E9E
	ADDQ.W	#1,(lbW011958-DT,A4)
lbC008E9E	MOVEM.L	(SP)+,D2/D3
	RTS

ERROR.MSG	db	'ERROR '

lbC008EAA	MOVE.L	(4,SP),D0
	CMP.W	#2,D0
	BEQ.B	lbC008EE0
	PEA	($5A).W
	PEA	($C8).W
	BSR.W	lbC008698
	PEA	(6).W
	PEA	(ERROR.MSG,PC)
	BSR.W	lbC0086B6
	ADDA.W	#$10,SP
	MOVE.L	(4,SP),D0
	PEA	(2).W
	MOVE.L	D0,-(SP)
	BSR.W	lbC008554
	ADDQ.W	#8,SP
lbC008EE0	RTS

lbC008EE2	MOVE.L	D1,-(SP)
	MOVE.L	(8,SP),D1
	MOVE.L	A0,(8,SP)
	LEA	(lbL008F2E,PC),A0
	CLR.L	D0
	MOVE.B	(A0,D1.W),D0
	CMP.W	#11,D1
	BLT.B	lbC008F26
	MOVEQ	#10,D0
	CMP.W	#$88,D1
	BGT.B	lbC008F26
	MOVEQ	#7,D0
	CMP.W	#$87,D1
	BGT.B	lbC008F26
	MOVEQ	#6,D0
	CMP.W	#$7B,D1
	BGT.B	lbC008F26
	MOVEQ	#5,D0
	CMP.W	#$62,D1
	BGT.B	lbC008F26
	MOVEQ	#4,D0
	CMP.W	#$47,D1
	BGT.B	lbC008F26
	MOVEQ	#3,D0
lbC008F26	MOVEA.L	(8,SP),A0
	MOVE.L	(SP)+,D1
	RTS

lbL008F2E	dl	$9090807
	dl	$6050505
	dw	$404
	db	4
ascii.MSG9	db	0
	db	1
	db	2
	db	7
	db	9
	db	3
	db	6
	db	5
	db	4

lbC008F42	MOVEM.L	D0-D4/A0,-(SP)
	LEA	(lbW01210C-DT,A4),A0
	MOVE.W	(4,A0),D2
	AND.W	#$6000,D2
	BEQ.B	lbC008F94
	MOVE.W	(A0),D0
	MOVE.W	(2,A0),D1
	MOVEQ	#9,D2
	CMP.W	#$109,D0
	ble	lbC009000
	MOVEQ	#0,D2
	MOVEQ	#7,D3
	MOVEQ	#6,D4
	CMP.W	#$124,D0
	BLT.B	lbC008F82
	MOVEQ	#2,D2
	MOVEQ	#3,D3
	MOVEQ	#4,D4
	CMP.W	#$12C,D0
	BGT.B	lbC008F82
	MOVEQ	#1,D2
	MOVEQ	#9,D3
	MOVEQ	#5,D4
lbC008F82	CMP.W	#$A6,D1
	BLT.B	lbC009000
	MOVE.W	D4,D2
	CMP.W	#$AE,D1
	BGT.B	lbC009000
	MOVE.W	D3,D2
	BRA.B	lbC009000

lbC008F94	LEA	(_custom).L,A0
	MOVE.B	(joy1dat,A0),D0
	MOVE.B	D0,D1
	LSR.B	#1,D0
	AND.B	#1,D0
	AND.B	#1,D1
	EOR.B	D0,D1
	MOVE.B	(joy1dat+1,A0),D2
	MOVE.B	D2,D3
	LSR.B	#1,D2
	AND.B	#1,D2
	AND.B	#1,D3
	EOR.B	D2,D3
	SUB.B	D0,D2
	SUB.B	D1,D3
	MOVE.B	D3,D0
	OR.B	D2,D0
	BEQ.B	lbC008FE6
	MOVEQ	#4,D0
	ADD.B	D3,D0
	ADD.B	D3,D0
	ADD.B	D3,D0
	ADD.B	D2,D0
	EXT.W	D0
	LEA	(ascii.MSG9,PC),A0
	CLR.L	D2
	MOVE.B	(A0,D0.W),D2
	MOVE.W	#1,(lbW00EDEC-DT,A4)
	BRA.B	lbC009000

lbC008FE6	CLR.L	D2
	MOVE.W	(lbW00EDEC-DT,A4),D2
	SUB.W	#$14,D2
	BMI.B	lbC008FFA
	CMP.W	#10,D2
	BGE.B	lbC008FFA
	BRA.B	lbC009000

lbC008FFA	MOVEQ	#9,D2
	CLR.W	(lbW00EDEC-DT,A4)
lbC009000	CMP.W	(lbW00EDEA-DT,A4),D2
	BEQ.B	lbC009012
	MOVE.W	D2,(lbW00EDEA-DT,A4)
	MOVE.L	D2,-(SP)
	JSR	(lbC00A264,PC)
	ADDQ.W	#4,SP
lbC009012	MOVEM.L	(SP)+,D0-D4/A0
	RTS

lbC009018	MOVE.L	(4,SP),D0
	MOVE.L	(8,SP),D1
	ADDQ.W	#4,D0
	ADDQ.W	#2,D1
	BSR.W	lbC008730
	CMP.W	#1,D0
	BEQ.B	lbC009052
	CMP.W	#10,D0
	BGE.B	lbC009052
	MOVE.L	(4,SP),D0
	MOVE.L	(8,SP),D1
	SUBQ.W	#4,D0
	ADDQ.W	#2,D1
	BSR.W	lbC008730
	CMP.W	#1,D0
	BEQ.B	lbC009052
	CMP.W	#8,D0
	BGE.B	lbC009052
	CLR.L	D0
lbC009052	RTS

lbC009054	MOVEM.L	D1-D4/A0-A5,-(SP)
	MOVEA.L	($2C,SP),A4
	MOVEA.L	($30,SP),A5
	MOVE.L	($34,SP),D4
	MOVE.L	($38,SP),D3
	MOVE.L	($3C,SP),D2
	SUBQ.W	#1,D2
	MULU.W	D3,D4
	MOVE.W	D4,D1
	ADD.L	D1,D1
lbC009074	MOVEA.L	A4,A0
	LEA	(A0,D1.L),A1
	LEA	(A1,D1.L),A2
	LEA	(A2,D1.L),A3
	LEA	(A3,D1.L),A4
	MOVE.W	D4,D3
	SUBQ.W	#1,D3
lbC00908A	MOVE.W	(A0)+,D0
	AND.W	(A1)+,D0
	AND.W	(A2)+,D0
	AND.W	(A3)+,D0
	AND.W	(A4)+,D0
	NOT.W	D0
	MOVE.W	D0,(A5)+
	DBRA	D3,lbC00908A
	DBRA	D2,lbC009074
	MOVEM.L	(SP)+,D1-D4/A0-A5
	RTS

lbL0090A6	dl	$1DFA1DFC
	dl	$43012
	dl	$18FA1DFC
	dl	$42812
	dl	$18FC1DFC
	dl	$22813
	dl	$18FC1DFA
	dl	$42812
	dl	$20000
	dl	$43012
	dl	$5020000
	dl	$42812
	dl	$5000000
	dl	$22813
	dl	$5000002
	dl	$42812

do_blit_1	MOVEM.L	D1/D2/A2-A6,-(SP)
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOOwnBlitter,A6)
	MOVEA.L	#_custom,A0
	MOVEQ	#4,D2
lbC0090FA	MOVE.W	D2,D0
	ADD.W	D0,D0
	ADD.W	D0,D0
	MOVEA.L	(lbL011A98-DT,A4),A2
	MOVEA.L	(A2,D0.W),A2
	MOVEA.L	A2,A3
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BEQ.B	lbC009120
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOWaitBlit,A6)
lbC009120	MOVE.L	($20,SP),D0
	MOVE.W	D0,D1
	LSR.W	#1,D1
	NOT.W	D1
	AND.W	#2,D1
	MOVE.W	D1,(bltcon1,A0)
	MOVE.W	#$9F0,(bltcon0,A0)
	MOVE.W	#$FFFF,(bltafwm,A0)
	MOVE.W	#$FFFF,(bltalwm,A0)
	LSL.W	#3,D0
	LEA	(lbL0090A6,PC),A5
	ADDA.W	D0,A5
	ADDA.W	(A5)+,A2
	ADDA.W	(A5)+,A3
	MOVE.L	A2,(bltapt,A0)
	MOVE.L	A3,(bltdpt,A0)
	MOVE.W	(A5),(bltamod,A0)
	MOVE.W	(A5)+,(bltdmod,A0)
	MOVE.W	(A5),(bltsize,A0)
	DBRA	D2,lbC0090FA
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVODisownBlitter,A6)
	MOVEM.L	(SP)+,D1/D2/A2-A6
	RTS

lbC009176	MOVEA.L	#_custom,A0
	MOVE.W	#$100,(bltcon0,A0)
	MOVE.W	#0,(bltcon1,A0)
	MOVE.W	#0,(bltdmod,A0)
	MOVE.L	(4,SP),(bltdpt,A0)
	MOVE.W	(10,SP),(bltsize,A0)
	MOVE.W	#0,D0
	RTS

do_blit_2	MOVEM.L	D1-D3/A2-A4/A6,-(SP)
	MOVEA.L	#_custom,A0
	MOVEA.L	(lbL011A00-DT,A4),A3
	MOVEQ	#4,D3
lbC0091B0	MOVE.W	D3,D0
	ADD.W	D0,D0
	ADD.W	D0,D0
	MOVEA.L	(lbL011A98-DT,A4),A2
	MOVEA.L	(A2,D0.W),A2
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BEQ.B	lbC0091D4
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOWaitBlit,A6)
lbC0091D4	MOVE.W	(lbW0119CC-DT,A4),D1
	MOVE.W	D1,D2
	LSL.W	#6,D1
	LSL.W	#6,D1
	MOVE.W	D1,(bltcon1,A0)
	MOVE.W	#$FCA,(bltcon0,A0)
	MOVE.W	#$FFFF,D1
	LSR.W	D2,D1
	MOVE.W	D1,D2
	AND.W	(lbW0119D6-DT,A4),D2
	MOVE.W	D2,(bltafwm,A0)
	NOT.W	D1
	BNE.B	lbC009200
	MOVE.W	#$FFFF,D1
lbC009200	MOVE.W	D1,(bltalwm,A0)
	ADDA.W	(8,A3),A2
	MOVE.L	A2,(bltdpt,A0)
	MOVE.L	A2,(bltcpt,A0)
	MOVEA.L	(lbL011AA0-DT,A4),A2
	ADDA.W	(lbW0119D0-DT,A4),A2
	MOVE.W	(lbW0119D4-DT,A4),D1
	MULU.W	D3,D1
	ADDA.W	D1,A2
	MOVE.L	A2,(bltbpt,A0)
	MOVEA.L	(lbL011A68-DT,A4),A2
	ADDQ.W	#2,A2
	ADDA.W	(lbW0119CE-DT,A4),A2
	MOVE.L	A2,(bltapt,A0)
	MOVE.W	#0,(bltamod,A0)
	MOVE.W	(lbW0119D2-DT,A4),(bltbmod,A0)
	MOVE.W	(10,A3),(bltcmod,A0)
	MOVE.W	(10,A3),(bltdmod,A0)
	MOVE.W	(6,A3),(bltsize,A0)
	DBRA	D3,lbC0091B0
	MOVEM.L	(SP)+,D1-D3/A2-A4/A6
	RTS

do_blit_3	MOVEM.L	D1-D3/A2-A4/A6,-(SP)
	MOVEA.L	#_custom,A0
	MOVEA.L	(lbL011A00-DT,A4),A3
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BEQ.B	lbC00927E
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOWaitBlit,A6)
lbC00927E	MOVEA.L	(lbL011A68-DT,A4),A2
	ADDQ.W	#2,A2
	ADDA.W	(lbW0119CE-DT,A4),A2
	MOVE.L	A2,(bltdpt,A0)
	MOVE.L	A2,(bltcpt,A0)
	MOVEA.L	(lbL011A9C-DT,A4),A2
	ADDA.W	(lbW0119D0-DT,A4),A2
	MOVE.L	A2,(bltapt,A0)
	MOVE.W	(lbW0119CC-DT,A4),D1
	MOVE.W	D1,D2
	LSL.W	#6,D1
	LSL.W	#6,D1
	OR.W	#$B50,D1
	MOVE.W	D1,(bltcon0,A0)
	MOVE.W	#0,(bltcon1,A0)
	MOVE.W	#$FFFF,D1
	LSR.W	D2,D1
	MOVE.W	#$FFFF,(bltafwm,A0)
	MOVE.W	#$FFFF,(bltalwm,A0)
	MOVE.W	(lbW0119D2-DT,A4),(bltamod,A0)
	MOVE.W	#0,(bltdmod,A0)
	MOVE.W	#0,(bltcmod,A0)
	MOVE.W	(6,A3),(bltsize,A0)
	MOVEM.L	(SP)+,D1-D3/A2-A4/A6
	RTS

do_blit_4	MOVEM.L	D1-D3/A2-A4/A6,-(SP)
	MOVEA.L	#_custom,A0
	MOVEA.L	(lbL011A00-DT,A4),A3
	MOVEQ	#4,D2
lbC0092F4	MOVE.W	D2,D0
	ADD.W	D0,D0
	ADD.W	D0,D0
	MOVEA.L	(lbL011A98-DT,A4),A2
	MOVEA.L	(A2,D0.W),A2
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BEQ.B	lbC009318
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOWaitBlit,A6)
lbC009318	MOVE.W	#0,(bltcon1,A0)
	MOVE.W	#$5CC,(bltcon0,A0)
	MOVE.W	#$FFFF,(bltafwm,A0)
	MOVE.W	#$FFFF,(bltalwm,A0)
	ADDA.W	(8,A3),A2
	MOVE.L	A2,(bltbpt,A0)
	MOVEA.L	($20,SP),A2
	MOVE.W	(4,A3),D1
	MULU.W	D2,D1
	ADDA.W	D1,A2
	MOVE.L	A2,(bltdpt,A0)
	MOVE.W	(10,A3),(bltbmod,A0)
	MOVE.W	#0,(bltdmod,A0)
	MOVE.W	(6,A3),(bltsize,A0)
	DBRA	D2,lbC0092F4
	MOVEM.L	(SP)+,D1-D3/A2-A4/A6
	RTS

do_blit_5	MOVEM.L	D1-D3/A2-A4/A6,-(SP)
	MOVEA.L	#_custom,A0
	MOVEA.L	(lbL011A00-DT,A4),A3
	MOVEQ	#4,D2
lbC009374	MOVE.W	D2,D0
	ADD.W	D0,D0
	ADD.W	D0,D0
	MOVEA.L	(lbL011A98-DT,A4),A2
	MOVEA.L	(A2,D0.W),A2
	MOVEA.L	(lbL011A00-DT,A4),A3
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BTST	#DMAB_BLITTER,(dmaconr,A0)
	BEQ.B	lbC00939C
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOWaitBlit,A6)
lbC00939C	MOVE.W	#0,(bltcon1,A0)
	MOVE.W	#$5CC,(bltcon0,A0)
	MOVE.W	#$FFFF,(bltafwm,A0)
	MOVE.W	#$FFFF,(bltalwm,A0)
	ADDA.W	(8,A3),A2
	MOVE.L	A2,(bltdpt,A0)
	MOVEA.L	($20,SP),A2
	MOVE.W	(4,A3),D1
	MULU.W	D2,D1
	ADDA.W	D1,A2
	MOVE.L	A2,(bltbpt,A0)
	MOVE.W	(10,A3),(bltdmod,A0)
	MOVE.W	#0,(bltbmod,A0)
	MOVE.W	(6,A3),(bltsize,A0)
	DBRA	D2,lbC009374
	MOVEM.L	(SP)+,D1-D3/A2-A4/A6
	RTS

lbC0093E8	MOVE.L	(4,SP),D0
	ADD.W	D0,D0
	ADD.W	D0,D0
	LEA	(lbL009400,PC),A0
	ADDA.L	(A0,D0.W),A0
	MOVE.L	A0,(4,SP)
	JMP	(lbC00DEA4-DT,A4)

lbL009400	dl	$20
	dl	$35
	dl	$4E
	dl	$62
	dl	$71
	dl	$83
	dl	$99
	dl	$AA
	db	'To Quest for the...?',0
	db	'Make haste, but take...?',0
	db	'Scorn murderous...?',0
	db	'Summon the...?',0
	db	'Wing forth in...?',0
	db	'Hold fast to your...?',0
	db	'Defy Ye that...?',0
	db	'In black darker than...?',0,0
	db	0
	db	0

lbC0094C6	MOVE.L	(4,SP),D0
	ADD.W	D0,D0
	ADD.W	D0,D0
	LEA	(lbL0094DE,PC),A0
	ADDA.L	(A0,D0.W),A0
	MOVE.L	A0,(4,SP)
	JMP	(lbC00DDDE-DT,A4)

lbL0094DE	dl	$50
	dl	$112
	dl	$17B
	dl	$1CF
	dl	$234
	dl	$2C9
	dl	$311
	dl	$361
	dl	$399
	dl	$39D
	dl	$404
	dl	$435
	dl	$439
	dl	$4AF
	dl	$4DF
	dl	$4E3
	dl	$567
	dl	$598
	dl	$5F7
	dl	$61A
	db	$80
	db	10
	db	$1C
	db	'   "Rescue the Talisman!"'
	db	$80
	db	10
	db	'''was the Mayor''s plea.'
	db	$80
	db	10
	db	'2"Only the Talisman can'
	db	$80
	db	10
	db	'=protect our village from'
	db	$80
	db	10
	db	'Hthe evil forces of the'
	db	$80
	db	10
	db	'Snight." And so Julian'
	db	$80
	db	10
	db	'^set out on his quest to'
	db	$80
	db	10
	db	'irecover it.',0
	db	$80
	db	12
	db	',Unfortunately for Julian,'
	db	$80
	db	12
	db	'7his luck had run out.'
	db	$80
	db	12
	db	'BMany months passed and'
	db	$80
	db	12
	db	'MJulian did not return...',0
	db	$80
	db	$14
	db	',So Phillip set out,'
	db	$80
	db	$14
	db	'7determined to find his'
	db	$80
	db	$14
	db	'Bbrother and complete'
	db	$80
	db	$14
	db	'Mthe quest.',0
	db	$80
	db	12
	db	',But sadly, Phillip''s'
	db	$80
	db	12
	db	'7cleverness could not save'
	db	$80
	db	12
	db	'Bhim from the same fate'
	db	$80
	db	12
	db	'Mas his older brother.',0
	db	$80
	db	15
	db	$1E
	db	'So Kevin took up the'
	db	$80
	db	15
	db	')quest, risking all, for'
	db	$80
	db	15
	db	'4the village had grown'
	db	$80
	db	15
	db	'?desperate. Young and'
	db	$80
	db	15
	db	'Jinexperienced, his'
	db	$80
	db	15
	db	'Uchances did not look'
	db	$80
	db	15
	db	'`good.',0
	db	$80
	db	10
	db	$1F
	db	'And so ends our sad tale.'
	db	$80
	db	12
	db	'-The Lesson of the Story:'
	db	$80
	db	'!XStay at Home!',0
	db	$80
	db	14
	db	' Having defeated the'
	db	$80
	db	14
	db	'+villanous Necromancer'
	db	$80
	db	14
	db	'6and recovered the'
	db	$80
	db	14
	db	'ATalisman, ',0
	db	$80
	db	14
	db	'Lreturned to Marheim'
	db	$80
	db	14
	db	'Wwhere he wed the'
	db	$80
	db	14
	db	'bprincess...',0
	db	$80
	db	10
	db	$1A
	db	0
	db	' had rescued Katra,'
	db	$80
	db	10
	db	'%Princess of Marheim.'
	db	$80
	db	10
	db	'0Though they had pledged'
	db	$80
	db	10
	db	';their love for each, '
	db	$80
	db	10
	db	'Fother, ',0
	db	' knew that'
	db	$80
	db	10
	db	'Q his quest could not'
	db	$80
	db	10
	db	'\be forsaken.',0
	db	$80
	db	10
	db	'!',0
	db	' had rescued Karla'
	db	$80
	db	10
	db	',(Katra''s sister), Princess'
	db	$80
	db	10
	db	'7of Marheim. Though they'
	db	$80
	db	10
	db	'Bhad pledged their love'
	db	$80
	db	10
	db	'Mfor each other, ',0
	db	$80
	db	10
	db	'Xknew that his quest'
	db	$80
	db	10
	db	'ccould not be forsaken.',0
	db	$80
	db	10
	db	$1A
	db	0
	db	' had rescued Kandy'
	db	$80
	db	10
	db	'%(Katra''s and Karla''s'
	db	$80
	db	10
	db	'0sister), Princess of'
	db	$80
	db	10
	db	';Marheim. Though they had'
	db	$80
	db	10
	db	'Fpledged their love for'
	db	$80
	db	10
	db	'Qeach other, ',0
	db	' knew '
	db	$80
	db	10
	db	'\that his quest could'
	db	$80
	db	10
	db	'gnot be forsaken.',0
	db	$80
	db	'#%After seeing the'
	db	$80
	db	$11
	db	'0princess safely to her'
	db	$80
	db	$11
	db	';home city, and with a'
	db	$80
	db	$11
	db	'Fking''s gift in gold,'
	db	$80
	db	$11
	db	'Q',0
	db	' once more set'
	db	$80
	db	$11
	db	'\out on his quest.',0
	db	$80
	db	'@'
	db	$13
	db	'So...'
	db	$80
	db	$11
	db	'AYou, game seeker, would guide the'
	db	$80
	db	5
	db	'Kbrothers to their destiny? You would'
	db	$80
	db	5
	db	'Uaid them and give directions? Answer,'
	db	$80
	db	5
	db	'_then, these three questions and prove'
	db	$80
	db	5
	db	'iyour fitness to be their advisor:',0
lbL009BC0	dl	$10207
	dl	$9030605
	dw	$400

lbC009BCA	MOVEM.L	D0-D7/A0/A1,-(SP)
	MOVE.L	($2C,SP),D2
	MOVE.L	($30,SP),D0
	MOVE.L	($34,SP),D1
	MOVE.L	($38,SP),D3
	LEA	(lbW01230A-DT,A4),A1
	MULU.W	#$16,D2
	ADDA.L	D2,A1
	CMP.B	#6,D3
	BEQ.B	lbC009BF8
	NEG.W	D0
	NEG.W	D1
	ADD.W	(A1),D0
	ADD.W	(2,A1),D1
lbC009BF8	CLR.L	D6
	CLR.L	D7
	TST.W	D0
	BEQ.B	lbC009C0A
	BMI.B	lbC009C06
	MOVEQ	#1,D6
	BRA.B	lbC009C0A

lbC009C06	NEG.W	D0
	MOVEQ	#-1,D6
lbC009C0A	TST.W	D1
	BEQ.B	lbC009C18
	BMI.B	lbC009C14
	MOVEQ	#1,D7
	BRA.B	lbC009C18

lbC009C14	NEG.W	D1
	MOVEQ	#-1,D7
lbC009C18	CMP.B	#4,D3
	BEQ.B	lbC009C32
	MOVE.W	D0,D4
	LSR.W	#1,D4
	CMP.W	D4,D1
	BGE.B	lbC009C28
	CLR.L	D7
lbC009C28	MOVE.W	D1,D4
	LSR.W	#1,D4
	CMP.W	D4,D0
	BGE.B	lbC009C32
	CLR.L	D6
lbC009C32	CLR.L	D4
	MOVE.W	D0,D5
	ADD.W	D1,D5
	CMP.B	#1,D3
	BNE.B	lbC009C46
	CMP.W	#$28,D5
	BGE.B	lbC009C46
	MOVEQ	#1,D4
lbC009C46	CMP.B	#2,D3
	BNE.B	lbC009C54
	CMP.W	#$1E,D5
	BGE.B	lbC009C54
	MOVEQ	#1,D4
lbC009C54	CMP.B	#3,D3
	BNE.B	lbC009C5E
	NEG.B	D6
	NEG.B	D7
lbC009C5E	MOVEQ	#4,D5
	SUB.B	D7,D5
	SUB.B	D7,D5
	SUB.B	D7,D5
	SUB.B	D6,D5
	LEA	(lbL009BC0,PC),A0
	MOVE.B	(A0,D5.W),D5
	CMP.B	#9,D5
	BNE.B	lbC009C7E
	MOVE.B	#13,($10,A1)
	BRA.B	lbC009CA2

lbC009C7E	JSR	(lbC00DDA2-DT,A4)
	BTST	#1,D0
	BEQ.B	lbC009C8C
	ADD.B	D4,D5
	BRA.B	lbC009C8E

lbC009C8C	SUB.B	D4,D5
lbC009C8E	AND.B	#7,D5
	MOVE.B	D5,($11,A1)
	CMP.B	#5,D3
	BEQ.B	lbC009CA2
	MOVE.B	#12,($10,A1)
lbC009CA2	MOVEM.L	(SP)+,D0-D7/A0/A1
	RTS

lbC009CA8	LINK.W	A5,#0
	MOVEM.L	D4-D6,-(SP)
	MOVE.L	(8,A5),D4
	MOVE.L	(12,A5),D5
	MOVE.L	($10,A5),D6
	CMPI.B	#4,(lbB012316-DT,A4)
	BGE.B	lbC009D0E
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012313-DT,A4),A0
	CMPI.B	#9,(A0,D0.L)
	BEQ.B	lbC009CFC
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012313-DT,A4),A1
	MOVEQ	#0,D2
	MOVE.B	(A1,D0.L),D2
	CMP.L	#$89,D2
	BNE.B	lbC009D0E
	MOVEA.L	(lbL0119FC-DT,A4),A6
	TST.B	(7,A6)
	BNE.B	lbC009D0E
lbC009CFC	PEA	($3A).W
	JSR	(lbC00AA06,PC)
	ADDQ.W	#4,SP
lbC009D06	MOVEM.L	(SP)+,D4-D6
	UNLK	A5
	RTS

lbC009D0E	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012313-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.B	(A0,D0.L),D2
	CMP.L	#$8A,D2
	BEQ.B	lbC009D42
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012313-DT,A4),A1
	MOVEQ	#0,D3
	MOVE.B	(A1,D0.L),D3
	CMP.L	#$8B,D3
	BNE.B	lbC009D44
lbC009D42	BRA.B	lbC009D06

lbC009D44	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01231C-DT,A4),A0
	ADDA.L	D0,A0
	MOVE.W	($16,A5),D2
	SUB.W	D2,(A0)
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01231C-DT,A4),A0
	TST.W	(A0,D0.L)
	BGE.B	lbC009D7A
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01231C-DT,A4),A0
	CLR.W	(A0,D0.L)
lbC009D7A	CMP.L	#$FFFFFFFF,D4
	BNE.B	lbC009D98
	JSR	(lbC00DDC0-DT,A4)
	MOVEA.L	D0,A0
	PEA	($1F4,A0)
	PEA	(2).W
	JSR	(lbC00827A,PC)
	ADDQ.W	#8,SP
	BRA.B	lbC009DEE

lbC009D98	CMP.L	#$FFFFFFFE,D4
	BNE.B	lbC009DBC
	PEA	($1FF).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	D0,A0
	PEA	($C80,A0)
	PEA	(5).W
	JSR	(lbC00827A,PC)
	ADDQ.W	#8,SP
	BRA.B	lbC009DEE

lbC009DBC	TST.L	D5
	BNE.B	lbC009DDA
	PEA	($1FF).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	D0,A0
	PEA	($320,A0)
	CLR.L	-(SP)
	JSR	(lbC00827A,PC)
	ADDQ.W	#8,SP
	BRA.B	lbC009DEE

lbC009DDA	JSR	(lbC00DDC6-DT,A4)
	MOVEA.L	D0,A0
	PEA	($190,A0)
	PEA	(3).W
	JSR	(lbC00827A,PC)
	ADDQ.W	#8,SP
lbC009DEE	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012312-DT,A4),A0
	CMPI.B	#6,(A0,D0.L)
	BEQ.B	lbC009E3E
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012312-DT,A4),A1
	CMPI.B	#4,(A1,D0.L)
	BEQ.B	lbC009E3E
	PEA	(2).W
	MOVE.L	D6,-(SP)
	MOVE.L	D5,-(SP)
	JSR	(lbC00A1B2,PC)
	LEA	(12,SP),SP
	TST.L	D0
	BEQ.B	lbC009E3E
	TST.L	D4
	BLT.B	lbC009E3E
	PEA	(2).W
	MOVE.L	D6,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00A1B2,PC)
	LEA	(12,SP),SP
lbC009E3E	PEA	(5).W
	MOVE.L	D5,-(SP)
	JSR	(lbC005DF0,PC)
	ADDQ.W	#8,SP
	bra	lbC009D06

lbC009E4E	LINK.W	A5,#0
	MOVEM.L	D4-D7,-(SP)
	MOVEQ	#0,D5
	MOVE.L	D5,D4
	MOVEQ	#3,D6
	BRA.B	lbC009EA4

lbC009E5E	MOVEQ	#$16,D1
	MOVE.L	D6,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012312-DT,A4),A0
	CMPI.B	#2,(A0,D0.L)
	BEQ.B	lbC009E74
	BRA.B	lbC009EA2

lbC009E74	MOVEQ	#$16,D1
	MOVE.L	D6,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB01231A-DT,A4),A0
	CMPI.B	#15,(A0,D0.L)
	BNE.B	lbC009E8C
	ADDQ.L	#1,D4
	BRA.B	lbC009EA2

lbC009E8C	MOVEQ	#$16,D1
	MOVE.L	D6,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW012318-DT,A4),A0
	CMPI.B	#5,(A0,D0.L)
	BNE.B	lbC009EA2
	ADDQ.L	#1,D5
lbC009EA2	ADDQ.L	#1,D6
lbC009EA4	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D6
	BLT.B	lbC009E5E
	CMPI.W	#1,(lbW01231C-DT,A4)
	BGE.B	lbC009EB8
	BRA.B	lbC009F20

lbC009EB8	CMPI.W	#5,(lbW01231C-DT,A4)
	BGE.B	lbC009ED0
	TST.L	D4
	BEQ.B	lbC009ED0
	PEA	(Bravelydone.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC009F20

lbC009ED0	CMPI.W	#$32,(lbW011992-DT,A4)
	BGE.B	lbC009F20
	TST.L	D4
	BEQ.B	lbC009EFC
	PEA	(lbB009F40,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(1).W
	MOVE.L	D4,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	(foesweredefea.MSG,PC)
	JSR	(lbC00A8CC,PC)
	ADDQ.W	#4,SP
lbC009EFC	TST.L	D5
	BEQ.B	lbC009F20
	PEA	(lbB009F5F,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(1).W
	MOVE.L	D5,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	(foesfledinret.MSG,PC)
	JSR	(lbC00A8CC,PC)
	ADDQ.W	#4,SP
lbC009F20	TST.B	(lbB011819-DT,A4)
	BEQ.B	lbC009F2A
	JSR	(lbC007EAC,PC)
lbC009F2A	MOVEM.L	(SP)+,D4-D7
	UNLK	A5
	RTS

Bravelydone.MSG	db	'Bravely done!',0
lbB009F40	db	0
foesweredefea.MSG	db	'foes were defeated in battle.',0
lbB009F5F	db	0
foesfledinret.MSG	db	'foes fled in retreat.',0

lbC009F76	LINK.W	A5,#0
	MOVEM.L	D4-D6,-(SP)
	MOVE.W	($12,A5),D0
	MULS.W	#$16,D0
	LEA	(lbB012312-DT,A4),A0
	CMPI.B	#2,(A0,D0.L)
	BNE.B	lbC009FA6
	MOVE.W	($12,A5),D1
	MULS.W	#$16,D1
	LEA	(lbB012313-DT,A4),A1
	CMPI.B	#2,(A1,D1.L)
	BEQ.B	lbC009FE4
lbC009FA6	MOVE.W	(14,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(10,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	JSR	(lbC009018,PC)
	ADDQ.W	#8,SP
	MOVE.L	D0,D4
	TST.W	($12,A5)
	BNE.B	lbC009FD6
	CMP.L	#8,D4
	BEQ.B	lbC009FD4
	CMP.L	#9,D4
	BNE.B	lbC009FD6
lbC009FD4	MOVEQ	#0,D4
lbC009FD6	TST.L	D4
	BEQ.B	lbC009FE4
	MOVE.L	D4,D0
lbC009FDC	MOVEM.L	(SP)+,D4-D6
	UNLK	A5
	RTS

lbC009FE4	MOVEQ	#0,D6
	bra	lbC00A090

lbC009FEA	MOVE.W	($12,A5),D0
	EXT.L	D0
	CMP.L	D6,D0
	beq	lbC00A08E
	CMP.L	#1,D6
	beq	lbC00A08E
	MOVEQ	#$16,D1
	MOVE.L	D6,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012312-DT,A4),A0
	CMPI.B	#5,(A0,D0.L)
	BEQ.B	lbC00A08E
	MOVEQ	#$16,D1
	MOVE.L	D6,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB01231A-DT,A4),A1
	CMPI.B	#15,(A1,D0.L)
	BEQ.B	lbC00A08E
	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVEQ	#$16,D1
	MOVE.L	D0,-(SP)
	MOVE.L	D6,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D0.L),D2
	MOVE.L	(SP)+,D3
	MOVE.L	D3,D4
	SUB.L	D2,D4
	MOVE.W	(14,A5),D0
	EXT.L	D0
	MOVEQ	#$16,D1
	MOVE.L	D0,-(SP)
	MOVE.L	D6,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D0.L),D2
	MOVE.L	(SP)+,D3
	MOVE.L	D3,D5
	SUB.L	D2,D5
	CMP.L	#11,D4
	BGE.B	lbC00A08E
	CMP.L	#$FFFFFFF5,D4
	BLE.B	lbC00A08E
	CMP.L	#9,D5
	BGE.B	lbC00A08E
	CMP.L	#$FFFFFFF7,D5
	BLE.B	lbC00A08E
	MOVEQ	#$10,D0
	bra	lbC009FDC

lbC00A08E	ADDQ.L	#1,D6
lbC00A090	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D6
	blt	lbC009FEA
	MOVEQ	#0,D0
	bra	lbC009FDC

lbC00A0A2	LINK.W	A5,#0
	MOVEM.L	D4/D5,-(SP)
	CLR.W	(lbW0119AE-DT,A4)
	MOVEQ	#1,D5
	BRA.B	lbC00A0FE

lbC00A0B2	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012312-DT,A4),A0
	CMPI.B	#1,(A0,D0.L)
	BNE.B	lbC00A0E0
	TST.B	(11,A5)
	BNE.B	lbC00A0FC
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbB012314-DT,A4),A1
	CMPI.B	#$1D,(A1,D0.L)
	BEQ.B	lbC00A0FC
lbC00A0E0	CLR.L	-(SP)
	MOVE.L	D5,-(SP)
	BSR.B	lbC00A116
	ADDQ.W	#8,SP
	MOVE.L	D0,D4
	MOVE.W	(14,A5),D0
	EXT.L	D0
	CMP.L	D0,D4
	BGE.B	lbC00A0FC
	MOVE.W	D5,(lbW0119AE-DT,A4)
	MOVE.W	D4,(14,A5)
lbC00A0FC	ADDQ.L	#1,D5
lbC00A0FE	MOVE.W	(lbW01194C-DT,A4),D0
	EXT.L	D0
	CMP.L	D0,D5
	BLT.B	lbC00A0B2
	MOVE.W	(14,A5),D0
	EXT.L	D0
	MOVEM.L	(SP)+,D4/D5
	UNLK	A5
	RTS

lbC00A116	LINK.W	A5,#-2
	MOVEM.L	D4-D7,-(SP)
	MOVE.L	(8,A5),D4
	MOVE.L	(12,A5),D5
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D0.L),D2
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A1
	MOVEQ	#0,D3
	MOVE.W	(A1,D0.L),D3
	MOVE.L	D2,D6
	SUB.L	D3,D6
	TST.L	D6
	BGE.B	lbC00A154
	NEG.L	D6
lbC00A154	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D0.L),D2
	MOVEQ	#$16,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230C-DT,A4),A1
	MOVEQ	#0,D3
	MOVE.W	(A1,D0.L),D3
	MOVE.L	D2,D7
	SUB.L	D3,D7
	TST.L	D7
	BGE.B	lbC00A182
	NEG.L	D7
lbC00A182	MOVE.L	D7,D0
	ADD.L	D7,D0
	CMP.L	D0,D6
	BLE.B	lbC00A194
	MOVE.L	D6,D0
lbC00A18C	MOVEM.L	(SP)+,D4-D7
	UNLK	A5
	RTS

lbC00A194	MOVE.L	D6,D0
	ADD.L	D6,D0
	CMP.L	D0,D7
	BLE.B	lbC00A1A0
	MOVE.L	D7,D0
	BRA.B	lbC00A18C

lbC00A1A0	MOVE.L	D6,D0
	ADD.L	D7,D0
	MOVEQ	#5,D1
	JSR	(__mulu-DT,A4)
	MOVEQ	#7,D1
	JSR	(__divs-DT,A4)
	BRA.B	lbC00A18C

lbC00A1B2	LINK.W	A5,#0
	MOVEM.L	D4/D5,-(SP)
	MOVE.W	($12,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(14,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.W	(10,A5),D2
	MULS.W	#$16,D2
	LEA	(lbW01230A-DT,A4),A0
	MOVEQ	#0,D3
	MOVE.W	(A0,D2.L),D3
	MOVE.L	D3,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,D4
	MOVE.W	($12,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(14,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.W	(10,A5),D2
	MULS.W	#$16,D2
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D3
	MOVE.W	(A0,D2.L),D3
	MOVE.L	D3,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,D5
	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	D5,D1
	MOVE.L	D1,-(SP)
	MOVEQ	#0,D2
	MOVE.W	D4,D2
	MOVE.L	D2,-(SP)
	JSR	(lbC009F76,PC)
	LEA	(12,SP),SP
	TST.L	D0
	BEQ.B	lbC00A240
	MOVEQ	#0,D0
lbC00A238	MOVEM.L	(SP)+,D4/D5
	UNLK	A5
	RTS

lbC00A240	MOVE.W	(10,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	MOVE.W	D4,(A0,D0.L)
	MOVE.W	(10,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230C-DT,A4),A0
	MOVE.W	D5,(A0,D0.L)
	MOVEQ	#1,D0
	BRA.B	lbC00A238

lbC00A264	LINK.W	A5,#0
	MOVEM.L	D4-D7,-(SP)
	MOVE.W	(10,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB010D66-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,D4
	MOVE.W	(10,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB010D67-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,D5
	MOVE.W	(10,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB010D68-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,D6
	MOVE.W	(10,A5),D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(ascii.MSG23-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,D7
	MOVEA.L	(bitmap64x24x3_ptr-DT,A4),A0
	MOVE.L	(lbL011A38-DT,A4),($10,A0)
	CLR.L	-(SP)
	PEA	(4).W
	PEA	(192).W
	PEA	(24).W
	PEA	(48).W
	PEA	(15).W
	PEA	(567).W
	MOVE.L	(bitmap640x57x4_ptr-DT,A4),-(SP)
	CLR.L	-(SP)
	CLR.L	-(SP)
	MOVE.L	(bitmap64x24x3_ptr-DT,A4),-(SP)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	CMPI.W	#9,(10,A5)
	BGE.B	lbC00A334
	MOVEA.L	(bitmap64x24x3_ptr-DT,A4),A0
	MOVE.L	(lbL011A3C-DT,A4),($10,A0)
	CLR.L	-(SP)
	PEA	(4).W
	PEA	($C0).W
	MOVE.L	D7,-(SP)
	MOVE.L	D6,-(SP)
	MOVEA.L	D5,A0
	PEA	(15,A0)
	MOVEA.L	D4,A1
	PEA	($237,A1)
	MOVE.L	(bitmap640x57x4_ptr-DT,A4),-(SP)
	MOVE.L	D5,-(SP)
	MOVE.L	D4,-(SP)
	MOVE.L	(bitmap64x24x3_ptr-DT,A4),-(SP)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
lbC00A334	MOVEM.L	(SP)+,D4-D7
	UNLK	A5
	RTS

lbC00A33C	LINK.W	A5,#-2
	MOVEM.L	D4-D7,-(SP)
	CMPI.W	#4,(lbW00ED02-DT,A4)
	BNE.B	lbC00A354
	MOVE.W	#$980,(lbW010DCC-DT,A4)
	BRA.B	lbC00A378

lbC00A354	CMPI.W	#9,(lbW00ED02-DT,A4)
	BNE.B	lbC00A372
	TST.W	(lbW011996-DT,A4)
	BEQ.B	lbC00A36A
	MOVE.W	#$F0,(lbW010DCC-DT,A4)
	BRA.B	lbC00A370

lbC00A36A	MOVE.W	#$445,(lbW010DCC-DT,A4)
lbC00A370	BRA.B	lbC00A378

lbC00A372	MOVE.W	#$BDF,(lbW010DCC-DT,A4)
lbC00A378	CMPI.W	#$64,(10,A5)
	BLE.B	lbC00A386
	MOVE.W	#$64,(10,A5)
lbC00A386	CMPI.W	#$64,(14,A5)
	BLE.B	lbC00A394
	MOVE.W	#$64,(14,A5)
lbC00A394	CMPI.W	#$64,($12,A5)
	BLE.B	lbC00A3A2
	MOVE.W	#$64,($12,A5)
lbC00A3A2	TST.W	($16,A5)
	BEQ.B	lbC00A3E6
	CMPI.W	#10,(10,A5)
	BGE.B	lbC00A3B6
	MOVE.W	#10,(10,A5)
lbC00A3B6	CMPI.W	#$19,(14,A5)
	BGE.B	lbC00A3C4
	MOVE.W	#$19,(14,A5)
lbC00A3C4	CMPI.W	#$3C,($12,A5)
	BGE.B	lbC00A3D2
	MOVE.W	#$3C,($12,A5)
lbC00A3D2	MOVEQ	#$64,D0
	MOVE.W	(14,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVEQ	#3,D1
	JSR	(__divs-DT,A4)
	MOVE.L	D0,D7
	BRA.B	lbC00A406

lbC00A3E6	TST.W	(10,A5)
	BGE.B	lbC00A3F0
	CLR.W	(10,A5)
lbC00A3F0	TST.W	(14,A5)
	BGE.B	lbC00A3FA
	CLR.W	(14,A5)
lbC00A3FA	TST.W	($12,A5)
	BGE.B	lbC00A404
	CLR.W	($12,A5)
lbC00A404	MOVEQ	#0,D7
lbC00A406	CLR.W	(-2,A5)
	bra	lbC00A51C

lbC00A40E	MOVE.W	(-2,A5),D0
	EXT.L	D0
	ASL.L	#1,D0
	MOVEA.L	($18,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	AND.L	#$F00,D1
	MOVE.L	D1,D4
	LSR.L	#4,D4
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	ASL.L	#1,D0
	MOVEA.L	($18,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	MOVE.L	D1,D6
	AND.L	#$F0,D6
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	ASL.L	#1,D0
	MOVEA.L	($18,A5),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	MOVE.L	D1,D5
	AND.L	#15,D5
	TST.W	(lbW011998-DT,A4)
	BEQ.B	lbC00A46A
	CMP.L	D6,D4
	BGE.B	lbC00A46A
	MOVE.L	D6,D4
lbC00A46A	MOVE.W	(10,A5),D0
	EXT.L	D0
	MOVE.L	D4,D1
	JSR	(__mulu-DT,A4)
	MOVE.L	#$640,D1
	JSR	(__divs-DT,A4)
	MOVE.L	D0,D4
	MOVE.W	(14,A5),D0
	EXT.L	D0
	MOVE.L	D6,D1
	JSR	(__mulu-DT,A4)
	MOVE.L	#$640,D1
	JSR	(__divs-DT,A4)
	MOVE.L	D0,D6
	MOVE.W	($12,A5),D0
	EXT.L	D0
	MOVE.L	D5,D1
	JSR	(__mulu-DT,A4)
	MOVE.L	D6,D1
	MOVE.L	D0,-(SP)
	MOVE.L	D7,D0
	JSR	(__mulu-DT,A4)
	MOVE.L	D0,D2
	MOVE.L	(SP)+,D0
	ADD.L	D2,D0
	MOVEQ	#$64,D1
	JSR	(__divs-DT,A4)
	MOVE.L	D0,D5
	TST.W	($16,A5)
	BEQ.B	lbC00A4FC
	CMPI.W	#$10,(-2,A5)
	BLT.B	lbC00A4F2
	CMPI.W	#$18,(-2,A5)
	BGT.B	lbC00A4F2
	CMPI.W	#$14,(14,A5)
	BLE.B	lbC00A4F2
	CMPI.W	#$32,(14,A5)
	BGE.B	lbC00A4E8
	ADDQ.L	#2,D5
	BRA.B	lbC00A4F2

lbC00A4E8	CMPI.W	#$4B,(14,A5)
	BGE.B	lbC00A4F2
	ADDQ.L	#1,D5
lbC00A4F2	CMP.L	#15,D5
	BLE.B	lbC00A4FC
	MOVEQ	#15,D5
lbC00A4FC	MOVE.L	D4,D0
	ASL.L	#8,D0
	MOVE.L	D6,D1
	ASL.L	#4,D1
	ADD.L	D1,D0
	ADD.L	D5,D0
	MOVE.W	(-2,A5),D2
	EXT.L	D2
	ASL.L	#1,D2
	LEA	(colormap-DT,A4),A0
	MOVE.W	D0,(A0,D2.L)
	ADDQ.W	#1,(-2,A5)
lbC00A51C	CMPI.W	#$20,(-2,A5)
	blt	lbC00A40E
	PEA	(32).W
	PEA	(colormap-DT,A4)
	PEA	(viewport1-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	MOVEM.L	(SP)+,D4-D7
	UNLK	A5
	RTS

lbC00A542	LINK.W	A5,#0
	MOVEM.L	D4/D5,-(SP)
	MOVEQ	#0,D5
lbC00A54C	MOVEQ	#1,D4
lbC00A54E	PEA	($FFF).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	D4,D1
	ASL.L	#1,D1
	LEA	(colormap-DT,A4),A0
	MOVE.W	D0,(A0,D1.L)
	ADDQ.L	#1,D4
	CMP.L	#$20,D4
	BLT.B	lbC00A54E
	PEA	(32).W
	PEA	(colormap-DT,A4)
	PEA	(viewport1-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	PEA	(1).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	ADDQ.L	#1,D5
	CMP.L	#$20,D5
	BLT.B	lbC00A54C
	MOVEM.L	(SP)+,D4/D5
	UNLK	A5
	RTS

lbC00A59E	LINK.W	A5,#0
	MOVE.L	D4,-(SP)
	MOVE.W	(lbW010DCE-DT,A4),D0
	CMP.W	(lbW010DD0-DT,A4),D0
	BNE.B	lbC00A5BC
	PEA	(1).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	bra	lbC00A7D8

lbC00A5BC	MOVE.W	(lbW010DD0-DT,A4),D0
	LEA	(lbL011C00-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D4
	MOVE.W	(lbW010DD0-DT,A4),D0
	EXT.L	D0
	ADDQ.L	#1,D0
	AND.L	#$1F,D0
	MOVE.W	D0,(lbW010DD0-DT,A4)
	MOVE.L	D4,D0
	bra	lbC00A7C4

lbC00A5E6	PEA	(Coords.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(6).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	(6).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	(MemoryAvailab.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(6).W
	CLR.L	-(SP)
	JSR	(AvailMem,PC)
	ADDQ.W	#4,SP
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	bra	lbC00A7D8

lbC00A636	PEA	(Youareat.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(3).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	LSR.L	#8,D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	(3).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	LSR.L	#8,D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	(HSector.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(3).W
	MOVE.W	(lbW011984-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	(10).W
	PEA	(Extent.MSG,PC)
	JSR	(lbC0086B6,PC)
	ADDQ.W	#8,SP
	PEA	(2).W
	MOVE.W	(lbW011992-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	bra	lbC00A7D8

lbC00A6A8	PEA	($34).W
	PEA	($F5).W
	JSR	(lbC008698,PC)
	ADDQ.W	#8,SP
	PEA	(4).W
	PEA	(Vit.MSG,PC)
	JSR	(lbC0086B6,PC)
	ADDQ.W	#8,SP
	PEA	(3).W
	MOVE.W	(lbW01231C-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	bra	lbC00A7D8

lbC00A6DA	JSR	(lbC0067BC,PC)
	bra	lbC00A7D8

lbC00A6E2	TST.W	(lbW011976-DT,A4)
	BGE.B	lbC00A6EC
	CLR.W	(lbW011976-DT,A4)
lbC00A6EC	PEA	($34).W
	PEA	(14).W
	JSR	(lbC008698,PC)
	ADDQ.W	#8,SP
	PEA	(4).W
	PEA	(Brv.MSG,PC)
	JSR	(lbC0086B6,PC)
	ADDQ.W	#8,SP
	PEA	(3).W
	MOVE.W	(lbW011974-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	($34).W
	PEA	($5A).W
	JSR	(lbC008698,PC)
	ADDQ.W	#8,SP
	PEA	(4).W
	PEA	(Lck.MSG,PC)
	JSR	(lbC0086B6,PC)
	ADDQ.W	#8,SP
	PEA	(3).W
	MOVE.W	(lbW011976-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	($34).W
	PEA	($A8).W
	JSR	(lbC008698,PC)
	ADDQ.W	#8,SP
	PEA	(4).W
	PEA	(Knd.MSG,PC)
	JSR	(lbC0086B6,PC)
	ADDQ.W	#8,SP
	PEA	(3).W
	MOVE.W	(lbW011978-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	PEA	($34).W
	PEA	($141).W
	JSR	(lbC008698,PC)
	ADDQ.W	#8,SP
	PEA	(5).W
	PEA	(Wlth.MSG,PC)
	JSR	(lbC0086B6,PC)
	ADDQ.W	#8,SP
	PEA	(3).W
	MOVE.W	(lbW01197A-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DDD2-DT,A4)
	ADDQ.W	#8,SP
	BRA.B	lbC00A7D8

lbC00A7A6	PEA	(TakeWhat.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC00A7D8

lbW00A7B2	dw	lbC00A5E6-lbC00A7D6
	dw	lbC00A636-lbC00A7D6
	dw	lbC00A6A8-lbC00A7D6
	dw	lbC00A6DA-lbC00A7D6
	dw	lbC00A7D8-lbC00A7D6
	dw	lbC00A6E2-lbC00A7D6
	dw	lbC00A7D8-lbC00A7D6
	dw	lbC00A7D8-lbC00A7D6
	dw	lbC00A7A6-lbC00A7D6

lbC00A7C4	SUBQ.L	#2,D0
	CMP.L	#9,D0
	BCC.B	lbC00A7D8
	ASL.L	#1,D0
	MOVE.W	(lbW00A7B2,PC,D0.W),D0
	JMP	(lbC00A7D6,PC,D0.W)
lbC00A7D6	EQU	*-2

lbC00A7D8	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

Coords.MSG	db	'Coords = ',0
MemoryAvailab.MSG	db	'Memory Available: ',0
Youareat.MSG	db	'You are at: ',0
HSector.MSG	db	'H/Sector = ',0
Extent.MSG	db	' Extent = ',0
Vit.MSG	db	'Vit:',0
Brv.MSG	db	'Brv:',0
Lck.MSG	db	'Lck:',0
Knd.MSG	db	'Knd:',0
Wlth.MSG	db	'Wlth:',0
TakeWhat.MSG	db	'Take What?',0

lbC00A844	MOVEM.L	D0/D1/A1,-(SP)
	MOVE.W	(lbW010DCE-DT,A4),D0
	MOVE.W	(lbW010DD0-DT,A4),D1
	ADDQ.W	#1,D0
	AND.W	#$1F,D0
	CMP.W	D0,D1
	BEQ.B	lbC00A86C
	MOVE.W	(lbW010DCE-DT,A4),D1
	MOVE.W	D0,(lbW010DCE-DT,A4)
	LEA	(lbL011C00-DT,A4),A1
	MOVE.B	($13,SP),(A1,D1.W)
lbC00A86C	MOVEM.L	(SP)+,D0/D1/A1
	RTS

lbC00A872	LINK.W	A5,#0
	MOVEM.L	D4/A2,-(SP)
	MOVEA.L	(8,A5),A2
	MOVEQ	#0,D4
lbC00A880	TST.B	(A2,D4.L)
	BEQ.B	lbC00A88A
	ADDQ.L	#1,D4
	BRA.B	lbC00A880

lbC00A88A	PEA	(44).W
	PEA	(400).W
	PEA	(5).W
	PEA	(16).W
	PEA	(10).W
	CLR.L	-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(ScrollRaster,PC)
	LEA	($1C,SP),SP
	PEA	(42).W
	PEA	(16).W
	JSR	(lbC008698,PC)
	ADDQ.W	#8,SP
	MOVE.L	D4,-(SP)
	MOVE.L	A2,-(SP)
	JSR	(lbC0086B6,PC)
	ADDQ.W	#8,SP
	MOVEM.L	(SP)+,D4/A2
	UNLK	A5
	RTS

lbC00A8CC	LINK.W	A5,#0
	MOVEM.L	D4/A2,-(SP)
	MOVEA.L	(8,A5),A2
	MOVEQ	#0,D4
lbC00A8DA	TST.B	(A2,D4.L)
	BEQ.B	lbC00A8E4
	ADDQ.L	#1,D4
	BRA.B	lbC00A8DA

lbC00A8E4	MOVE.L	D4,-(SP)
	MOVE.L	A2,-(SP)
	JSR	(lbC0086B6,PC)
	ADDQ.W	#8,SP
	MOVEM.L	(SP)+,D4/A2
	UNLK	A5
	RTS

lbC00A8F6	LINK.W	A5,#-8
	MOVEM.L	D4/A2/A3,-(SP)
	MOVEA.L	(8,A5),A2
	LEA	(lbL012242-DT,A4),A0
	MOVE.L	A0,(lbL011AC4-DT,A4)
	MOVE.L	A0,(-4,A5)
	CLR.W	(-8,A5)
lbC00A912	MOVEQ	#0,D4
	BRA.B	lbC00A994

lbC00A916	MOVEA.L	A2,A0
	ADDQ.L	#1,A2
	MOVE.B	(A0),(-5,A5)
	CMPI.B	#$20,(-5,A5)
	BNE.B	lbC00A92A
	MOVE.L	(lbL011AC4-DT,A4),D4
lbC00A92A	TST.B	(-5,A5)
	BNE.B	lbC00A93E
	MOVE.L	(lbL011AC4-DT,A4),D4
	MOVEA.L	D4,A0
	CLR.B	(A0)
	MOVE.W	#$3E8,(-8,A5)
lbC00A93E	CMPI.B	#13,(-5,A5)
	BNE.B	lbC00A950
	MOVE.L	(lbL011AC4-DT,A4),D4
	MOVEA.L	D4,A0
	CLR.B	(A0)
	BRA.B	lbC00A99E

lbC00A950	CMPI.B	#$25,(-5,A5)
	BNE.B	lbC00A984
	MOVE.W	(lbW011980-DT,A4),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	ASL.L	#2,D0
	LEA	(lbL00ECF6-DT,A4),A0
	MOVEA.L	(A0,D0.L),A3
lbC00A96A	TST.B	(A3)
	BEQ.B	lbC00A982
	MOVEA.L	A3,A0
	ADDQ.L	#1,A3
	MOVEA.L	(lbL011AC4-DT,A4),A1
	ADDQ.L	#1,(lbL011AC4-DT,A4)
	MOVE.B	(A0),(A1)
	ADDQ.W	#1,(-8,A5)
	BRA.B	lbC00A96A

lbC00A982	BRA.B	lbC00A990

lbC00A984	MOVEA.L	(lbL011AC4-DT,A4),A0
	ADDQ.L	#1,(lbL011AC4-DT,A4)
	MOVE.B	(-5,A5),(A0)
lbC00A990	ADDQ.W	#1,(-8,A5)
lbC00A994	CMPI.W	#$25,(-8,A5)
	blt	lbC00A916
lbC00A99E	TST.L	D4
	BEQ.B	lbC00A9CA
	MOVEA.L	D4,A0
	ADDQ.L	#1,D4
	CLR.B	(A0)
	MOVE.L	(-4,A5),-(SP)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	CMPI.W	#$26,(-8,A5)
	BGT.B	lbC00A9F4
	MOVE.L	(lbL011AC4-DT,A4),D0
	SUB.L	D4,D0
	MOVE.W	D0,(-8,A5)
	MOVE.L	D4,(-4,A5)
	BRA.B	lbC00A9F0

lbC00A9CA	MOVEA.L	(lbL011AC4-DT,A4),A0
	ADDQ.L	#1,(lbL011AC4-DT,A4)
	CLR.B	(A0)
	CMPI.W	#$26,(-8,A5)
	BGT.B	lbC00A9F4
	MOVE.L	(-4,A5),-(SP)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	CLR.W	(-8,A5)
	MOVE.L	(lbL011AC4-DT,A4),(-4,A5)
lbC00A9F0	bra	lbC00A912

lbC00A9F4	MOVEM.L	(SP)+,D4/A2/A3
	UNLK	A5
	RTS

lbC00A9FC	LEA	(wasgettingrat.MSG-DT,A4),A0
	MOVE.L	(4,SP),D0
	BRA.B	lbC00AA18

lbC00AA06	LEA	(attemptedtoco.MSG-DT,A4),A0
	MOVE.L	(4,SP),D0
	BRA.B	lbC00AA18

lbC00AA10	MOVEA.L	(4,SP),A0
	MOVE.L	(8,SP),D0
lbC00AA18	BEQ.B	lbC00AA22
lbC00AA1A	TST.B	(A0)+
	BNE.B	lbC00AA1A
	SUBQ.W	#1,D0
	BNE.B	lbC00AA1A
lbC00AA22	MOVE.L	A0,(4,SP)
	bra	lbC00A8F6

lbC00AA2A	LINK.W	A5,#0
	MOVE.W	(lbW011980-DT,A4),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	ASL.L	#2,D0
	LEA	(lbL00ECF6-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(found.MSG,PC)
	JSR	(lbC00A8CC,PC)
	ADDQ.W	#4,SP
	MOVE.L	(8,A5),-(SP)
	JSR	(lbC00A8CC,PC)
	ADDQ.W	#4,SP
	PEA	(containing.MSG,PC)
	JSR	(lbC00A8CC,PC)
	ADDQ.W	#4,SP
	UNLK	A5
	RTS

found.MSG	db	' found ',0
containing.MSG	db	' containing ',0,0

lbC00AA7E	LINK.W	A5,#0
	MOVE.W	(lbW011980-DT,A4),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	ASL.L	#2,D0
	LEA	(lbL00ECF6-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(found.MSG0,PC)
	JSR	(lbC00A8CC,PC)
	ADDQ.W	#4,SP
	MOVE.L	(8,A5),-(SP)
	JSR	(lbC00A8CC,PC)
	ADDQ.W	#4,SP
	UNLK	A5
	RTS

found.MSG0	db	' found ',0

lbC00AABA	LINK.W	A5,#0
	MOVE.W	(lbW011980-DT,A4),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	ASL.L	#2,D0
	LEA	(lbL00ECF6-DT,A4),A0
	MOVE.L	(A0,D0.L),-(SP)
	JSR	(lbC00A8CC,PC)
	ADDQ.W	#4,SP
	UNLK	A5
	RTS

lbC00AADA	LINK.W	A5,#0
	JSR	(lbC00AB66,PC)
	LEA	(rp1-DT,A4),A0
	MOVE.L	A0,(active_rp_ptr-DT,A4)
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(rp1_bitmap_ptr-DT,A4)
	CLR.L	-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetDrMd-DT,A4)
	ADDQ.W	#8,SP
	PEA	($18).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	CLR.L	-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetRast-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	#$E000,(viewport2_modes-DT,A4)	;!**********************
	JSR	(lbC00ABCE,PC)
	PEA	(32).W
	PEA	(lbL010D8E-DT,A4)
	PEA	(viewport1-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	MOVE.B	#2,(lbB011939-DT,A4)
	UNLK	A5
	RTS

lbC00AB44	LINK.W	A5,#0
	BSR.B	lbC00AB66
	LEA	(active_rp-DT,A4),A0
	MOVE.L	A0,(active_rp_ptr-DT,A4)
	MOVE.W	#$C000,(viewport2_modes-DT,A4)	;!****************
	JSR	(make_display,PC)
	MOVE.B	#3,(lbB011939-DT,A4)
	UNLK	A5
	RTS

lbC00AB66	LINK.W	A5,#0
	MOVE.L	D4,-(SP)
	MOVEQ	#$64,D4
lbC00AB6E	PEA	(lbL010D8E-DT,A4)
	CLR.L	-(SP)
	MOVE.L	D4,-(SP)
	MOVE.L	D4,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00A33C,PC)
	LEA	($14,SP),SP
	PEA	(1).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	SUBQ.L	#5,D4
	TST.L	D4
	BGE.B	lbC00AB6E
	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

lbC00AB98	LINK.W	A5,#0
	MOVE.L	D4,-(SP)
	MOVEQ	#0,D4
lbC00ABA0	PEA	(lbL010D8E-DT,A4)
	CLR.L	-(SP)
	MOVE.L	D4,-(SP)
	MOVE.L	D4,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC00A33C,PC)
	LEA	($14,SP),SP
	PEA	(1).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	ADDQ.L	#5,D4
	CMP.L	#$64,D4
	BLE.B	lbC00ABA0
	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

lbC00ABCE	LINK.W	A5,#0
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	CLR.W	(10,A1)
	MOVEA.L	(lbL011A04-DT,A4),A6
	MOVEA.L	(A6),A1
	CLR.W	(8,A1)
	JSR	(make_display,PC)
	UNLK	A5
	RTS

trackdisk_read_3	LINK.W	A5,#0
	MOVE.L	(buffer_78000-DT,A4),(trackdisk_buffer_ptr-DT,A4)
	PEA	(3).W
	JSR	(trackdisk_read_2,PC)
	ADDQ.W	#4,SP
	PEA	(1).W
	JSR	(wait_for_trackdisk_8,PC)
	ADDQ.W	#4,SP
	MOVE.W	(lbW011980-DT,A4),D0
	EXT.L	D0
	SUBQ.L	#1,D0
	MOVE.L	D0,-(SP)
	BSR.B	trackdisk_read_2
	ADDQ.W	#4,SP
	CLR.L	-(SP)
	JSR	(wait_for_trackdisk_8,PC)
	ADDQ.W	#4,SP
	PEA	(4).W
	BSR.B	trackdisk_read_2
	ADDQ.W	#4,SP
	PEA	(3).W
	JSR	(wait_for_trackdisk_8,PC)
	ADDQ.W	#4,SP
	MOVE.L	(trackdisk_buffer_ptr-DT,A4),(lbL012038-DT,A4)
	MOVE.W	(lbW01198C-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	BSR.B	trackdisk_read_2
	ADDQ.W	#4,SP
	MOVE.W	(lbW01198C-DT,A4),D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbW010DD6-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,-(SP)
	JSR	(wait_for_trackdisk_8,PC)
	ADDQ.W	#4,SP
	MOVE.W	(lbW01198E-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	BSR.B	trackdisk_read_2
	ADDQ.W	#4,SP
	PEA	(4).W
	JSR	(wait_for_trackdisk_8,PC)
	ADDQ.W	#4,SP
	MOVE.W	(lbW00ED02-DT,A4),(lbW0119C6-DT,A4)
	JSR	(lbC007FE8,PC)
;	JSR	(trackdisk_motor_off,PC)
	UNLK	A5
	RTS

trackdisk_read_2	LINK.W	A5,#-4
	MOVEM.L	D4/D5,-(SP)
	MOVE.L	(8,A5),D4
	MOVE.L	D4,D0
	ASL.L	#3,D0
	LEA	(lbW010DD6-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,D5
	MOVE.L	D4,D0
	ASL.L	#3,D0
	LEA	(lbB010DD3-DT,A4),A0
	MOVE.L	D0,D1
	MOVEQ	#0,D0
	MOVE.B	(A0,D1.L),D0
	MOVE.L	D4,D2
	ASL.L	#3,D2
	LEA	(lbB010DD2-DT,A4),A1
	MOVEQ	#0,D1
	MOVE.B	(A1,D2.L),D1
	JSR	(__mulu-DT,A4)
	ASL.L	#1,D0
	MOVEQ	#$12,D1
	MOVE.W	D0,-(SP)
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL01201C-DT,A4),A6
	MOVE.W	(SP)+,D3
	MOVE.W	D3,(A6,D0.L)
	MOVEQ	#$12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL01201C-DT,A4),A0
	MOVE.L	D0,D2
	MOVE.W	(A0,D2.L),D0
	EXT.L	D0
	MOVE.L	D4,D3
	ASL.L	#3,D3
	LEA	(C.MSG-DT,A4),A1
	MOVEQ	#0,D1
	MOVE.B	(A1,D3.L),D1
	JSR	(__mulu-DT,A4)
	MOVE.L	D0,(-4,A5)
	MOVEQ	#$12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL012014-DT,A4),A0
	MOVE.L	(trackdisk_buffer_ptr-DT,A4),(A0,D0.L)
	MOVE.L	D4,D0
	ASL.L	#3,D0
	LEA	(lbB010DD2-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.W	D1,-(SP)
	MOVEQ	#$12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01200E-DT,A4),A1
	MOVE.W	(SP)+,D2
	MOVE.W	D2,(A1,D0.L)
	MOVE.L	D4,D0
	ASL.L	#3,D0
	LEA	(lbB010DD3-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.W	D1,-(SP)
	MOVEQ	#$12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW012010-DT,A4),A1
	MOVE.W	(SP)+,D2
	MOVE.W	D2,(A1,D0.L)
	MOVE.L	D4,D0
	ASL.L	#3,D0
	LEA	(C.MSG-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.W	D1,-(SP)
	MOVEQ	#$12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW012012-DT,A4),A1
	MOVE.W	(SP)+,D2
	MOVE.W	D2,(A1,D0.L)
	MOVEQ	#6,D1
	MOVE.L	(-4,A5),D0
	JSR	(__mulu-DT,A4)
	ADD.L	(trackdisk_buffer_ptr-DT,A4),D0
	MOVEA.L	(buffer_78000-DT,A4),A0
	ADDA.L	#$130B0,A0
	CMP.L	A0,D0
	BHI.B	lbC00ADF0
	PEA	(8).W	;trackdisk_io index
	MOVE.L	(trackdisk_buffer_ptr-DT,A4),-(SP)	;buffer address
	MOVE.L	D4,D0
	ASL.L	#3,D0
	LEA	(lbB010DD5-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.B	(A0,D0.L),D1
	MOVE.L	D1,-(SP)	;number of sectors
	MOVE.L	D4,D2
	ASL.L	#3,D2
	LEA	(lbL010DD8-DT,A4),A1
	MOVEQ	#0,D3
	MOVE.W	(A1,D2.L),D3
	MOVE.L	D3,-(SP)	;starting sector
;	BSR.B	trackdisk_read
	jsr	(_trackdisk_read)
	LEA	($10,SP),SP
	MOVEQ	#5,D1
	MOVE.L	(-4,A5),D0
	JSR	(__mulu-DT,A4)
	ADD.L	D0,(trackdisk_buffer_ptr-DT,A4)
	MOVEQ	#$12,D1
	MOVE.L	D5,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbL012018-DT,A4),A0
	MOVE.L	(trackdisk_buffer_ptr-DT,A4),(A0,D0.L)
	MOVE.L	(-4,A5),D0
	ADD.L	D0,(trackdisk_buffer_ptr-DT,A4)
lbC00ADF0	MOVEM.L	(SP)+,D4/D5
	UNLK	A5
	RTS

;trackdisk_read	LINK.W	A5,#-2
;	MOVE.W	(22,A5),D0	;trackdisk_io index
;	MULS.W	#56,D0
;	LEA	(trackdisk_io_array-DT,A4),A0
;	ADD.L	A0,D0
;	MOVE.L	D0,(trackdisk_io_ptr-DT,A4)
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	CMPI.W	#CMD_READ,(IO_COMMAND,A0)
;	BNE.B	lbC00AE24
;	MOVE.L	(trackdisk_io_ptr-DT,A4),-(SP)
;	JSR	(_WaitIO-DT,A4)
;	ADDQ.W	#4,SP
;lbC00AE24	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	MOVEA.L	(trackdisk_io-DT,A4),A1
;	MOVEQ	#13,D0
;lbC00AE2E	MOVE.L	(A1)+,(A0)+
;	DBRA	D0,lbC00AE2E
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	MOVE.W	(14,A5),D0	;size in 512-byte sectors
;	EXT.L	D0
;	MOVEQ	#9,D1
;	ASL.L	D1,D0
;	MOVE.L	D0,(IO_LENGTH,A0)
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	MOVE.L	(16,A5),(IO_DATA,A0)	;buffer address
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	MOVE.W	#CMD_READ,(IO_COMMAND,A0)
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	MOVE.W	(10,A5),D0	;offset in 512-byte sectors
;	EXT.L	D0
;	MOVEQ	#9,D1
;	ASL.L	D1,D0
;	MOVE.L	D0,(IO_OFFSET,A0)
;	MOVE.L	(trackdisk_io_ptr-DT,A4),-(SP)
;	JSR	(SendIO,PC)
;	ADDQ.W	#4,SP
;	UNLK	A5
;	RTS

;trackdisk_motor_off	LINK.W	A5,#0
;	LEA	(trackdisk_io_copy-DT,A4),A0
;	MOVEA.L	(trackdisk_io-DT,A4),A1
;	MOVEQ	#13,D0
;lbC00AE88	MOVE.L	(A1)+,(A0)+
;	DBRA	D0,lbC00AE88
;	CLR.L	(lbL0126DE-DT,A4)
;	MOVE.W	#TD_MOTOR,(lbW0126D6-DT,A4)
;	PEA	(trackdisk_io_copy-DT,A4)
;	JSR	(_DoIO-DT,A4)
;	ADDQ.W	#4,SP
;	UNLK	A5
;	RTS

lbC00AEA6	LINK.W	A5,#0
	JSR	(lbC00BE8A,PC)
	UNLK	A5
	RTS

wait_for_trackdisk_8
	LINK.W	A5,#0
;	PEA	(trackdisk_io_8-DT,A4)
;	JSR	(_WaitIO-DT,A4)
;	ADDQ.W	#4,SP
	CLR.W	(lbW01269E-DT,A4)
	MOVE.W	(10,A5),D0
	MULS.W	#$12,D0
	LEA	(lbW012012-DT,A4),A0
	MOVE.W	(A0,D0.L),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.W	(10,A5),D2
	MULS.W	#$12,D2
	LEA	(lbW012010-DT,A4),A1
	MOVE.W	(A1,D2.L),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	MOVE.W	(10,A5),D3
	MULS.W	#$12,D3
	LEA	(lbW01200E-DT,A4),A6
	MOVE.W	(A6,D3.L),D2
	EXT.L	D2
	MOVE.L	D2,-(SP)
	MOVE.W	(10,A5),D3
	MULS.W	#$12,D3
	LEA	(lbL012018-DT,A4),A6
	MOVE.L	(A6,D3.L),-(SP)
	MOVE.W	(10,A5),D3
	MULS.W	#$12,D3
	LEA	(lbL012014-DT,A4),A6
	MOVE.L	(A6,D3.L),-(SP)
	JSR	(lbC009054,PC)
	LEA	($14,SP),SP
	UNLK	A5
	RTS

check_for_trackdisk_and_read_tracks
	LINK.W	A5,#0
;	MOVEA.L	(trackdisk_io_ptr-DT,A4),A0
;	CMPI.W	#CMD_READ,(IO_COMMAND,A0)
;	BNE.B	lbC00AF4A
;	MOVE.L	(trackdisk_io_ptr-DT,A4),-(SP)
;	JSR	(_CheckIO-DT,A4)
;	ADDQ.W	#4,SP
;	TST.L	D0
;	BEQ.B	lbC00AF4E
lbC00AF4A	JSR	(read_tracks,PC)
lbC00AF4E	UNLK	A5
	RTS

read_songs_file	LINK.W	A5,#-$10
	MOVE.L	D4,-(SP)
	CLR.L	(-$10,A5)
	CLR.L	(-12,A5)
	PEA	(MODE_OLDFILE).W
	PEA	(songs.MSG,PC)
	JSR	(_Open-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(-4,A5)
	BEQ.B	lbC00AFF2
	MOVEQ	#0,D4
lbC00AF76	PEA	(4).W
	PEA	(-8,A5)
	MOVE.L	(-4,A5),-(SP)
	JSR	(_Read-DT,A4)
	LEA	(12,SP),SP
	MOVE.L	(-8,A5),D0
	ASL.L	#1,D0
	ADD.L	(-12,A5),D0
	CMP.L	#$170C,D0
	BGT.B	lbC00AFE8
	MOVE.L	(-$10,A5),D0
	ASL.L	#2,D0
	LEA	(lbL01208C-DT,A4),A0
	MOVE.L	(lbL011A94-DT,A4),D1
	ADD.L	(-12,A5),D1
	MOVE.L	D1,(A0,D0.L)
	ADDQ.L	#1,(-$10,A5)
	MOVE.L	(-8,A5),D0
	ASL.L	#1,D0
	MOVE.L	D0,-(SP)
	MOVEA.L	(lbL011A94-DT,A4),A0
	ADDA.L	(-12,A5),A0
	MOVE.L	A0,-(SP)
	MOVE.L	(-4,A5),-(SP)
	JSR	(_Read-DT,A4)
	LEA	(12,SP),SP
	MOVE.L	(-8,A5),D0
	ASL.L	#1,D0
	ADD.L	D0,(-12,A5)
	ADDQ.L	#1,D4
	CMP.L	#$1C,D4
	BLT.B	lbC00AF76
lbC00AFE8	MOVE.L	(-4,A5),-(SP)
	JSR	(_Close-DT,A4)
	ADDQ.W	#4,SP
lbC00AFF2	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

songs.MSG	db	'progdir:songs',0

display_brother	LINK.W	A5,#0
	TST.B	(lbB011818-DT,A4)
	BEQ.B	lbC00B00C
lbC00B008	UNLK	A5
	RTS

lbC00B00C	PEA	($15E).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	PEA	($C8).W
	PEA	($140).W
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	(bitmap320x200x5-DT,A4)
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	(bitmap320x200x5_2-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	PEA	($18).W
	PEA	(4).W
	PEA	(bitmap320x200x5_2-DT,A4)
	MOVE.L	(8,A5),-(SP)
	JSR	(lbC00DF88-DT,A4)
	LEA	($10,SP),SP
	MOVE.W	($16,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	($12,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	PEA	(bitmap320x200x5_2-DT,A4)
	MOVE.L	(12,A5),-(SP)
	JSR	(lbC00DF88-DT,A4)
	LEA	($10,SP),SP
	JSR	(lbC00B350,PC)
	TST.L	D0
	BEQ.B	lbC00B082
	BRA.B	lbC00B008

lbC00B082	BSR.B	lbC00B08C
	JSR	(lbC00B350,PC)
	bra	lbC00B008

lbC00B08C	LINK.W	A5,#-10
	MOVEM.L	D4-D7,-(SP)
	CLR.W	(-2,A5)
	bra	lbC00B33E

lbC00B09C	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(-10,A5)
	MOVEQ	#0,D5
	MOVE.W	(-2,A5),D0
	LEA	(lbL010E62-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D6
	MOVE.W	(-2,A5),D0
	LEA	(lbL010E78-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,D7
	CMPI.W	#11,(-2,A5)
	bge	lbC00B1CA
	MOVE.L	#$A1,D4
	SUB.L	D7,D4
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	PEA	($C8).W
	PEA	($87).W
	CLR.L	-(SP)
	PEA	($A0).W
	MOVE.L	(-10,A5),-(SP)
	CLR.L	-(SP)
	PEA	($A0).W
	PEA	(bitmap320x200x5_2-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	TST.L	D6
	beq	lbC00B310
	MOVE.W	D7,(-4,A5)
	BRA.B	lbC00B186

lbC00B11A	MOVE.W	(-4,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC008EE2,PC)
	ADDQ.W	#4,SP
	MOVE.W	D0,(-6,A5)
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	MOVE.L	#$C8,D1
	SUB.L	D0,D1
	MOVE.W	(-6,A5),D2
	EXT.L	D2
	SUB.L	D2,D1
	MOVE.L	D1,-(SP)
	MOVE.L	D7,-(SP)
	MOVE.W	(-6,A5),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	MOVEA.L	D5,A0
	PEA	($A1,A0)
	MOVE.L	(-10,A5),-(SP)
	MOVE.W	(-6,A5),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	MOVE.W	(-4,A5),D3
	EXT.L	D3
	ADD.L	D4,D3
	MOVE.L	D3,-(SP)
	PEA	(bitmap320x200x5-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	ADD.L	D7,D5
	ADD.W	D6,(-4,A5)
lbC00B186	CMPI.W	#$88,(-4,A5)
	BLT.B	lbC00B11A
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	PEA	($BA).W
	PEA	(1).W
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVEA.L	D5,A0
	PEA	($A1,A0)
	MOVE.L	(-10,A5),-(SP)
	PEA	(7).W
	PEA	($128).W
	PEA	(bitmap320x200x5-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	bra	lbC00B310

lbC00B1CA	MOVE.L	#$A0,D4
	TST.L	D6
	BNE.B	lbC00B206
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	PEA	($C8).W
	PEA	($87).W
	CLR.L	-(SP)
	PEA	($18).W
	MOVE.L	(-10,A5),-(SP)
	CLR.L	-(SP)
	PEA	($18).W
	PEA	(bitmap320x200x5_2-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	bra	lbC00B310

lbC00B206	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	PEA	($C8).W
	PEA	($87).W
	CLR.L	-(SP)
	PEA	($18).W
	MOVE.L	(-10,A5),-(SP)
	CLR.L	-(SP)
	PEA	($18).W
	PEA	(bitmap320x200x5-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	MOVE.W	D7,(-4,A5)
	BRA.B	lbC00B2A8

lbC00B23A	MOVE.W	(-4,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(lbC008EE2,PC)
	ADDQ.W	#4,SP
	MOVE.W	D0,(-6,A5)
	ADD.L	D7,D5
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	MOVE.L	#$C8,D1
	SUB.L	D0,D1
	MOVE.W	(-6,A5),D2
	EXT.L	D2
	SUB.L	D2,D1
	MOVE.L	D1,-(SP)
	MOVE.L	D7,-(SP)
	MOVE.W	(-6,A5),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	MOVEA.L	D4,A0
	SUBA.L	D5,A0
	MOVE.L	A0,-(SP)
	MOVE.L	(-10,A5),-(SP)
	MOVE.W	(-6,A5),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	MOVE.W	(-4,A5),D3
	EXT.L	D3
	MOVEA.L	D4,A1
	SUBA.L	D3,A1
	MOVE.L	A1,-(SP)
	PEA	(bitmap320x200x5_2-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
	ADD.W	D6,(-4,A5)
lbC00B2A8	CMPI.W	#$88,(-4,A5)
	BLT.B	lbC00B23A
	MOVE.W	#$87,(-4,A5)
	MOVE.W	#7,(-6,A5)
	CLR.L	-(SP)
	PEA	($1F).W
	PEA	($C0).W
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	MOVE.L	#$C8,D1
	SUB.L	D0,D1
	MOVE.W	(-6,A5),D2
	EXT.L	D2
	SUB.L	D2,D1
	MOVE.L	D1,-(SP)
	PEA	(1).W
	MOVE.W	(-6,A5),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	MOVEA.L	#$9F,A0
	SUBA.L	D5,A0
	MOVE.L	A0,-(SP)
	MOVE.L	(-10,A5),-(SP)
	MOVE.W	(-6,A5),D3
	EXT.L	D3
	MOVE.L	D3,-(SP)
	PEA	($18).W
	PEA	(bitmap320x200x5_2-DT,A4)
	JSR	(_BltBitMap-DT,A4)
	LEA	($2C,SP),SP
lbC00B310	JSR	(make_display,PC)
	MOVE.W	(-2,A5),D0
	LEA	(lbL010E8E-DT,A4),A0
	TST.B	(A0,D0.W)
	BEQ.B	lbC00B33A
	MOVE.W	(-2,A5),D0
	LEA	(lbL010E8E-DT,A4),A0
	MOVE.B	(A0,D0.W),D1
	EXT.W	D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
lbC00B33A	ADDQ.W	#1,(-2,A5)
lbC00B33E	CMPI.W	#$16,(-2,A5)
	blt	lbC00B09C
	MOVEM.L	(SP)+,D4-D7
	UNLK	A5
	RTS

lbC00B350	LINK.W	A5,#0
	JSR	(_get_key_perhaps-DT,A4)
	CMP.L	#$20,D0
	BNE.B	lbC00B364
	MOVEQ	#1,D0
	BRA.B	lbC00B366

lbC00B364	MOVEQ	#0,D0
lbC00B366	MOVE.B	D0,(lbB011818-DT,A4)
	EXT.W	D0
	EXT.L	D0
	UNLK	A5
	RTS

malloc_maybe	LINK.W	A5,#0
	MOVEM.L	D4/A2/A3,-(SP)
	MOVEA.L	(8,A5),A2
	CMPA.L	#$1FFFFF,A2
	BGT.B	lbC00B390
	MOVE.L	A2,D0
lbC00B388	MOVEM.L	(SP)+,D4/A2/A3
	UNLK	A5
	RTS

lbC00B390	PEA	(MEMF_CHIP).W
	MOVE.L	(12,A5),-(SP)
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A3
	MOVEQ	#0,D4
	BRA.B	lbC00B3AE

lbC00B3A4	MOVEA.L	A2,A0
	ADDQ.L	#1,A2
	MOVE.B	(A0),(A3,D4.L)
	ADDQ.L	#1,D4
lbC00B3AE	CMP.L	(12,A5),D4
	BLT.B	lbC00B3A4
	MOVE.L	A3,D0
	BRA.B	lbC00B388

lbC00B3B8	LINK.W	A5,#-$26
	MOVEM.L	D4/A2/A3,-(SP)
	MOVEA.L	(8,A5),A2
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	AND.L	#$FFF0,D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$14,A5)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011958-DT,A4),D1
	AND.L	#$FFE0,D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$16,A5)
	CLR.L	-(SP)
	PEA	(1).W
	PEA	($C0).W
	PEA	($130).W
	CLR.L	-(SP)
	CLR.L	-(SP)
	PEA	(rp1_bitmap_ptr-DT,A4)
	MOVE.L	(layerinfo-DT,A4),-(SP)
	JSR	(CreateUpfrontLayer,PC)
	LEA	($20,SP),SP
	MOVE.L	D0,(layer_ptr-DT,A4)
	LEA	(rp1-DT,A4),A0
	MOVE.L	A0,D4
	MOVEA.L	D4,A0
	MOVE.L	(A0),(lbL011AD0-DT,A4)
	MOVEA.L	D4,A0
	MOVE.L	(layer_ptr-DT,A4),(A0)
	MOVE.W	($22,A2),D0
	EXT.L	D0
	ADD.L	#$3F,D0
	ASL.L	#2,D0
	MOVE.B	D0,(-1,A5)
	MOVEQ	#0,D0
	MOVE.B	(-1,A5),D0
	LEA	(lbL010F6A-DT,A4),A0
	MOVEA.L	D0,A3
	ADDA.L	A0,A3
	MOVE.B	(A3),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	($1E,A2),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-4,A5)
	MOVE.B	(1,A3),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	($20,A2),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-6,A5)
	MOVE.B	(2,A3),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	($1E,A2),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-8,A5)
	MOVE.B	(3,A3),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	($20,A2),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-10,A5)
	MOVE.W	($22,A2),D0
	EXT.L	D0
	ADDQ.L	#1,D0
	ASL.L	#2,D0
	MOVE.B	D0,(-1,A5)
	MOVEQ	#0,D0
	MOVE.B	(-1,A5),D0
	LEA	(lbL010F6A-DT,A4),A0
	MOVEA.L	D0,A3
	ADDA.L	A0,A3
	MOVE.B	(A3),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	($1E,A2),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-12,A5)
	MOVE.B	(1,A3),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	($20,A2),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-14,A5)
	MOVE.B	(2,A3),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	($1E,A2),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-$10,A5)
	MOVE.B	(3,A3),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.W	($20,A2),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.W	D0,(-$12,A5)
	MOVE.W	(-8,A5),D0
	EXT.L	D0
	MOVE.W	(-4,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$18,A5)
	MOVE.W	(-10,A5),D0
	EXT.L	D0
	MOVE.W	(-6,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$1A,A5)
	MOVE.W	(-$14,A5),D0
	EXT.L	D0
	MOVE.W	(-4,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$1C,A5)
	MOVE.W	(-$16,A5),D0
	EXT.L	D0
	MOVE.W	(-6,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$1E,A5)
	MOVE.W	(-$18,A5),D0
	MULS.W	(-$1E,A5),D0
	MOVE.W	(-$1A,A5),D1
	MULS.W	(-$1C,A5),D1
	SUB.L	D1,D0
	MOVE.W	D0,(lbW01181A-DT,A4)
	CLR.W	(lbW0119DA-DT,A4)
	TST.W	(lbW01181A-DT,A4)
	BLT.B	lbC00B572
	MOVE.W	#1,(lbW0119DA-DT,A4)
lbC00B572	MOVE.W	(-$10,A5),D0
	EXT.L	D0
	MOVE.W	(-12,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$18,A5)
	MOVE.W	(-$12,A5),D0
	EXT.L	D0
	MOVE.W	(-14,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$1A,A5)
	MOVE.W	(-$14,A5),D0
	EXT.L	D0
	MOVE.W	(-12,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$1C,A5)
	MOVE.W	(-$16,A5),D0
	EXT.L	D0
	MOVE.W	(-14,A5),D1
	EXT.L	D1
	SUB.L	D1,D0
	MOVE.W	D0,(-$1E,A5)
	MOVE.W	(-$18,A5),D0
	MULS.W	(-$1E,A5),D0
	MOVE.W	(-$1A,A5),D1
	MULS.W	(-$1C,A5),D1
	SUB.L	D1,D0
	MOVE.W	D0,(lbW01181C-DT,A4)
	CLR.W	(lbW0119DC-DT,A4)
	TST.W	(lbW01181C-DT,A4)
	BLT.B	lbC00B5E0
	MOVE.W	#1,(lbW0119DC-DT,A4)
lbC00B5E0	PEA	(2).W
	MOVE.L	D4,-(SP)
	JSR	(_SetDrMd-DT,A4)
	ADDQ.W	#8,SP
	PEA	($64).W
	PEA	($64).W
	JSR	(_AllocRaster-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011AC8-DT,A4)
	beq	lbC00B6DE
	MOVEA.L	D4,A0
	MOVE.L	(12,A0),(-$22,A5)
	MOVEA.L	D4,A0
	MOVE.L	($10,A0),(-$26,A5)
	PEA	($578).W
	MOVE.L	(lbL011AC8-DT,A4),-(SP)
	PEA	(lbL011B18-DT,A4)
	JSR	(InitTmpRas,PC)
	LEA	(12,SP),SP
	MOVEA.L	D4,A0
	MOVE.L	D0,(12,A0)
	PEA	(9).W
	PEA	(lbL011DC6-DT,A4)
	PEA	(lbL011BE8-DT,A4)
	JSR	(InitArea,PC)
	LEA	(12,SP),SP
	LEA	(lbL011BE8-DT,A4),A0
	MOVEA.L	D4,A1
	MOVE.L	A0,($10,A1)
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-4,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(AreaMove,PC)
	LEA	(12,SP),SP
	MOVE.W	(-10,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-8,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(AreaDraw,PC)
	LEA	(12,SP),SP
	MOVE.W	(-$12,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-$10,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(AreaDraw,PC)
	LEA	(12,SP),SP
	MOVE.W	(-14,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-12,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(AreaDraw,PC)
	LEA	(12,SP),SP
	MOVE.L	D4,-(SP)
	JSR	(AreaEnd,PC)
	ADDQ.W	#4,SP
	PEA	($64).W
	PEA	($64).W
	MOVE.L	(lbL011AC8-DT,A4),-(SP)
	JSR	(_FreeRaster-DT,A4)
	LEA	(12,SP),SP
	MOVEA.L	D4,A0
	MOVE.L	(-$22,A5),(12,A0)
	MOVEA.L	D4,A0
	MOVE.L	(-$26,A5),($10,A0)
lbC00B6DE	MOVEA.L	D4,A0
	MOVE.L	(lbL011AD0-DT,A4),(A0)
	MOVE.L	(layer_ptr-DT,A4),-(SP)
	MOVE.L	(layerinfo-DT,A4),-(SP)
	JSR	(DeleteLayer,PC)
	ADDQ.W	#8,SP
	MOVEM.L	(SP)+,D4/A2/A3
	UNLK	A5
	RTS

lbC00B6FA	LINK.W	A5,#0
	MOVE.W	#2,(lbW0119E2-DT,A4)
	PEA	($80).W
	MOVE.W	(lbW0115F0-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	PEA	(lbW0110BA-DT,A4)
	JSR	(lbC00B820,PC)
	LEA	(12,SP),SP
	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW00ED02-DT,A4),D0
	ASL.L	#1,D0
	LEA	(lbL0115C8-DT,A4),A0
	MOVE.W	(A0,D0.L),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	MOVEQ	#0,D2
	MOVE.W	(lbW00ED02-DT,A4),D2
	ASL.L	#2,D2
	LEA	(lbL0115A0-DT,A4),A1
	MOVE.L	(A1,D2.L),-(SP)
	JSR	(lbC00B820,PC)
	LEA	(12,SP),SP
	CMPI.W	#3,(lbW0119E2-DT,A4)
	BLE.B	lbC00B758
	MOVE.W	(lbW0119E2-DT,A4),(lbW01194A-DT,A4)
lbC00B758	UNLK	A5
	RTS

lbC00B75C	LINK.W	A5,#0
	MOVE.W	(10,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	MOVE.W	(A0,D0.L),(lbW0110BA-DT,A4)
	MOVE.W	(10,A5),D0
	MULS.W	#$16,D0
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D1
	MOVE.W	(A0,D0.L),D1
	ADD.L	#10,D1
	MOVE.W	D1,(lbW0110BC-DT,A4)
	MOVE.B	(15,A5),(lbB0110BE-DT,A4)
	MOVE.B	#1,(lbB0110BF-DT,A4)
	UNLK	A5
	RTS

lbC00B79E	LINK.W	A5,#0
	MOVEM.L	D4/D5/A2/A3,-(SP)
	MOVE.L	(8,A5),D4
	MOVE.L	(12,A5),D5
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	MOVE.W	($12,A2),D0
	EXT.L	D0
	MOVE.L	D0,D4
	AND.L	#$7F,D4
	BTST	#7,($13,A2)
	BEQ.B	lbC00B7E6
	MOVEQ	#6,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW0110BA-DT,A4),A0
	MOVEA.L	D0,A3
	ADDA.L	A0,A3
	BRA.B	lbC00B804

lbC00B7E6	MOVEQ	#0,D0
	MOVE.W	(lbW00ED02-DT,A4),D0
	ASL.L	#2,D0
	LEA	(lbL0115A0-DT,A4),A0
	MOVEQ	#6,D1
	MOVE.L	D0,-(SP)
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	MOVE.L	(SP)+,D2
	MOVEA.L	(A0,D2.L),A3
	ADDA.L	D0,A3
lbC00B804	CMPI.B	#15,(4,A3)
	BNE.B	lbC00B814
	MOVE.B	#$1D,(4,A3)
	BRA.B	lbC00B818

lbC00B814	MOVE.B	D5,(5,A3)
lbC00B818	MOVEM.L	(SP)+,D4/D5/A2/A3
	UNLK	A5
	RTS

lbC00B820	LINK.W	A5,#-14
	MOVE.L	A2,-(SP)
	MOVE.W	(14,A5),(lbW0119DE-DT,A4)
	MOVE.W	(lbW00ED02-DT,A4),(lbW0119E0-DT,A4)
	CLR.B	(lbB011941-DT,A4)
	CLR.B	(lbB011819-DT,A4)
	MOVEQ	#0,D0
	MOVE.W	(lbW00ED02-DT,A4),D0
	ASL.L	#1,D0
	LEA	(lbL0115DC-DT,A4),A0
	TST.W	(A0,D0.L)
	bne	lbC00B95C
	CMPI.W	#10,(lbW0119C6-DT,A4)
	BCS.W	lbC00B95C
	MOVEQ	#0,D0
	MOVE.W	(lbW00ED02-DT,A4),D0
	ASL.L	#2,D0
	LEA	(lbL0115A0-DT,A4),A0
	MOVEA.L	(A0,D0.L),A2
	CLR.W	(-6,A5)
	bra	lbC00B940

lbC00B870	MOVEQ	#0,D0
	MOVE.W	(lbW00ED02-DT,A4),D0
	AND.L	#1,D0
	MOVEQ	#14,D1
	ASL.L	D1,D0
	MOVE.L	D0,-(SP)
	PEA	($3FFF).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(SP)+,D1
	ADD.L	D0,D1
	MOVE.W	D1,(-2,A5)
	MOVEQ	#0,D0
	MOVE.W	(lbW00ED02-DT,A4),D0
	AND.L	#6,D0
	MOVEQ	#12,D1
	ASL.L	D1,D0
	MOVE.L	D0,-(SP)
	PEA	($1FFF).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	(SP)+,D1
	ADD.L	D0,D1
	MOVE.W	D1,(-4,A5)
	MOVE.W	(-4,A5),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.W	(-2,A5),D1
	EXT.L	D1
	MOVE.L	D1,-(SP)
	JSR	(lbC00DDE4-DT,A4)
	ADDQ.W	#8,SP
	TST.L	D0
	BNE.B	lbC00B870
	MOVEQ	#0,D0
	MOVE.W	(lbW00ED02-DT,A4),D0
	ASL.L	#1,D0
	LEA	(lbL0115C8-DT,A4),A0
	MOVE.W	(A0,D0.L),D1
	ADDQ.W	#1,(A0,D0.L)
	MOVE.W	D1,(-8,A5)
	MOVE.W	(-8,A5),D0
	MULS.W	#6,D0
	MOVE.W	(-2,A5),(A2,D0.L)
	MOVE.W	(-8,A5),D0
	MULS.W	#6,D0
	MOVEA.L	D0,A0
	ADDA.L	A2,A0
	MOVE.W	(-4,A5),(2,A0)
	PEA	(15).W
	JSR	(lbC00DDA8-DT,A4)
	ADDQ.W	#4,SP
	LEA	(lbL0110AA-DT,A4),A0
	MOVE.W	(-8,A5),D1
	MULS.W	#6,D1
	MOVEA.L	D1,A1
	ADDA.L	A2,A1
	MOVE.B	(A0,D0.L),(4,A1)
	MOVE.W	(-8,A5),D0
	MULS.W	#6,D0
	MOVEA.L	D0,A0
	ADDA.L	A2,A0
	MOVE.B	#1,(5,A0)
	ADDQ.W	#1,(-6,A5)
lbC00B940	CMPI.W	#10,(-6,A5)
	blt	lbC00B870
	MOVEQ	#0,D0
	MOVE.W	(lbW00ED02-DT,A4),D0
	ASL.L	#1,D0
	LEA	(lbL0115DC-DT,A4),A0
	MOVE.W	#1,(A0,D0.L)
lbC00B95C	CLR.W	(-6,A5)
lbC00B960	TST.W	(14,A5)
	ble	lbC00BC9E
	SUBQ.W	#1,(14,A5)
	CMPI.W	#$14,(lbW01194C-DT,A4)
	BLT.B	lbC00B97A
lbC00B974	MOVEA.L	(SP)+,A2
	UNLK	A5
	RTS

lbC00B97A	MOVEA.L	(8,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011956-DT,A4),D1
	SUB.L	D1,D0
	SUBQ.L	#8,D0
	MOVE.W	D0,(-2,A5)
	MOVEA.L	(8,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(2,A0),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW011958-DT,A4),D1
	SUB.L	D1,D0
	SUBQ.L	#8,D0
	MOVE.W	D0,(-4,A5)
	MOVEA.L	(8,A5),A0
	CMPI.B	#3,(5,A0)
	BEQ.B	lbC00B9C2
	MOVEA.L	(8,A5),A1
	CMPI.B	#4,(5,A1)
	bne	lbC00BA7E
lbC00B9C2	CMPI.W	#$FF9C,(-2,A5)
	ble	lbC00BA7A
	CMPI.W	#$190,(-2,A5)
	bge	lbC00BA7A
	CMPI.W	#$FF9C,(-4,A5)
	ble	lbC00BA7A
	CMPI.W	#$12C,(-4,A5)
	bge	lbC00BA7A
	MOVEA.L	(8,A5),A0
	MOVE.B	(4,A0),(-10,A5)
	MOVE.B	(-10,A5),D0
	EXT.W	D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(ascii.MSG15-DT,A4),A0
	MOVE.B	(A0,D0.L),(-9,A5)
	MOVE.B	(-9,A5),D0
	EXT.W	D0
	EXT.L	D0
	ASL.L	#3,D0
	LEA	(lbL010DD8-DT,A4),A0
	MOVE.W	(lbW01198E-DT,A4),D1
	EXT.L	D1
	ASL.L	#3,D1
	LEA	(lbL010DD8-DT,A4),A1
	MOVE.W	(A0,D0.L),D2
	CMP.W	(A1,D1.L),D2
	BEQ.B	lbC00BA5A
	MOVE.B	(-9,A5),D0
	EXT.W	D0
	MOVE.W	D0,(lbW01198E-DT,A4)
	MOVE.L	(lbL01205C-DT,A4),(trackdisk_buffer_ptr-DT,A4)
	MOVE.B	(-9,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(trackdisk_read_2,PC)
	ADDQ.W	#4,SP
	PEA	(4).W
	JSR	(wait_for_trackdisk_8,PC)
	ADDQ.W	#4,SP
;	JSR	(trackdisk_motor_off,PC)
lbC00BA5A	MOVEA.L	(8,A5),A0
	CMPI.B	#9,(4,A0)
	BNE.B	lbC00BA78
	MOVEA.L	(8,A5),A1
	CMPI.B	#3,(5,A1)
	BNE.B	lbC00BA78
	MOVE.B	#1,(lbB011941-DT,A4)
lbC00BA78	BRA.B	lbC00BA7E

lbC00BA7A	bra	lbC00BC92

lbC00BA7E	MOVEA.L	(8,A5),A0
	CMPI.B	#2,(5,A0)
	beq	lbC00BC92
	MOVEA.L	(8,A5),A1
	TST.B	(5,A1)
	beq	lbC00BC92
	CMPI.W	#$FFEC,(-2,A5)
	ble	lbC00BC92
	CMPI.W	#$154,(-2,A5)
	bge	lbC00BC92
	CMPI.W	#$FFEC,(-4,A5)
	ble	lbC00BC92
	CMPI.W	#$BE,(-4,A5)
	bge	lbC00BC92
	MOVEA.L	(8,A5),A0
	CMPI.B	#3,(5,A0)
	BEQ.B	lbC00BADA
	MOVEA.L	(8,A5),A1
	CMPI.B	#4,(5,A1)
	bne	lbC00BBD4
lbC00BADA	MOVE.W	(lbW0119E2-DT,A4),D0
	ADDQ.W	#1,(lbW0119E2-DT,A4)
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-14,A5)
	MOVEA.L	(-14,A5),A0
	MOVEA.L	(8,A5),A1
	MOVE.W	(A0),D0
	CMP.W	(A1),D0
	BNE.B	lbC00BB2A
	MOVEA.L	(-14,A5),A6
	MOVEA.L	(8,A5),A1
	MOVE.W	(2,A6),D1
	CMP.W	(2,A1),D1
	BNE.B	lbC00BB2A
	MOVEA.L	(-14,A5),A0
	CMPI.B	#15,($10,A0)
	BNE.B	lbC00BB26
	MOVEA.L	(8,A5),A0
	MOVE.B	#4,(5,A0)
lbC00BB26	bra	lbC00BC92

lbC00BB2A	MOVEA.L	(-14,A5),A0
	MOVE.B	#4,(8,A0)
	MOVE.B	(-10,A5),D0
	EXT.W	D0
	EXT.L	D0
	ASL.L	#2,D0
	LEA	(lbB00E129-DT,A4),A0
	MOVEA.L	(-14,A5),A1
	MOVE.B	(A0,D0.L),(10,A1)
	MOVEA.L	(-14,A5),A0
	CLR.B	(12,A0)
	MOVE.B	(-10,A5),D0
	EXT.W	D0
	EXT.L	D0
	MOVE.B	(-10,A5),D1
	EXT.W	D1
	EXT.L	D1
	ADD.L	D1,D0
	ADDQ.L	#2,D0
	MOVEA.L	(-14,A5),A0
	MOVE.W	D0,($12,A0)
	MOVEA.L	(-14,A5),A0
	MOVE.B	(-5,A5),(14,A0)
	MOVEA.L	(-14,A5),A0
	CLR.B	(13,A0)
	MOVEA.L	(8,A5),A0
	CMPI.B	#4,(5,A0)
	BNE.B	lbC00BB9A
	MOVEA.L	(-14,A5),A0
	MOVE.B	#15,($10,A0)
	BRA.B	lbC00BBA4

lbC00BB9A	MOVEA.L	(-14,A5),A0
	MOVE.B	#13,($10,A0)
lbC00BBA4	MOVE.B	(-10,A5),D0
	EXT.W	D0
	EXT.L	D0
	ADD.L	#$80,D0
	MOVEA.L	(-14,A5),A0
	MOVE.B	D0,(9,A0)
	SUBI.W	#$12,(-4,A5)
	MOVE.W	(lbW0119E2-DT,A4),D0
	CMP.W	(lbW01194C-DT,A4),D0
	BLE.B	lbC00BBD0
	MOVE.W	(lbW0119E2-DT,A4),(lbW01194C-DT,A4)
lbC00BBD0	bra	lbC00BC66

lbC00BBD4	MOVEA.L	(8,A5),A0
	CMPI.B	#$66,(4,A0)
	BNE.B	lbC00BBE6
	MOVE.B	(lbB01194D-DT,A4),(lbB011819-DT,A4)
lbC00BBE6	MOVE.W	(lbW01194C-DT,A4),D0
	ADDQ.W	#1,(lbW01194C-DT,A4)
	MULS.W	#$16,D0
	LEA	(lbW01230A-DT,A4),A0
	ADD.L	A0,D0
	MOVE.L	D0,(-14,A5)
	MOVEA.L	(-14,A5),A0
	MOVE.B	#1,(8,A0)
	MOVEA.L	(8,A5),A0
	MOVEA.L	(-14,A5),A1
	MOVE.B	(4,A0),(10,A1)
	MOVEA.L	(-14,A5),A0
	CLR.B	(12,A0)
	MOVE.W	(-6,A5),D0
	EXT.L	D0
	ADD.L	($10,A5),D0
	MOVEA.L	(-14,A5),A0
	MOVE.W	D0,($12,A0)
	MOVEA.L	(8,A5),A0
	CMPI.B	#6,(5,A0)
	BNE.B	lbC00BC46
	MOVEA.L	(-14,A5),A0
	MOVE.B	#2,(9,A0)
	BRA.B	lbC00BC66

lbC00BC46	MOVEA.L	(8,A5),A0
	CMPI.B	#5,(5,A0)
	BNE.B	lbC00BC5C
	MOVEA.L	(-14,A5),A0
	CLR.B	(9,A0)
	BRA.B	lbC00BC66

lbC00BC5C	MOVEA.L	(-14,A5),A0
	MOVE.B	#1,(9,A0)
lbC00BC66	MOVEA.L	(8,A5),A0
	MOVEA.L	(-14,A5),A1
	MOVE.W	(A0),(A1)
	MOVEA.L	(8,A5),A0
	MOVEA.L	(-14,A5),A1
	MOVE.W	(2,A0),(2,A1)
	MOVEA.L	(-14,A5),A0
	MOVE.W	(-2,A5),(4,A0)
	MOVEA.L	(-14,A5),A0
	MOVE.W	(-4,A5),(6,A0)
lbC00BC92	ADDQ.L	#6,(8,A5)
	ADDQ.W	#1,(-6,A5)
	bra	lbC00B960

lbC00BC9E	bra	lbC00B974

LIGHT.MSG	db	'LIGHT',0
HEED.MSG	db	'HEED',0
DEED.MSG	db	'DEED',0
SIGHT.MSG	db	'SIGHT',0
FLIGHT.MSG	db	'FLIGHT',0
CREED.MSG	db	'CREED',0
BLIGHT.MSG	db	'BLIGHT',0
NIGHT.MSG	db	'NIGHT',0

lbC00BCD2	LINK.W	A5,#-4
	MOVEM.L	D4-D6/A2/A3,-(SP)
	PEA	(1).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetDrMd-DT,A4)
	ADDQ.W	#8,SP
	CLR.L	(-4,A5)
lbC00BCEC	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	D0,D6
	MOVE.L	D6,D0
	ASL.L	#2,D0
	LEA	(lbL0115F2-DT,A4),A0
	MOVEA.L	(A0,D0.L),A2
	MOVE.L	A2,D1
	BEQ.B	lbC00BCEC
	PEA	(1).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	MOVEQ	#10,D1
	MOVE.L	(-4,A5),D0
	JSR	(__mulu-DT,A4)
	MOVEA.L	D0,A0
	PEA	($7D,A0)
	PEA	(10).W
	JSR	(lbC008698,PC)
	ADDQ.W	#8,SP
	MOVE.L	D6,-(SP)
	JSR	(lbC0093E8,PC)
	ADDQ.W	#4,SP
	MOVEA.L	(active_rp_ptr-DT,A4),A0
	MOVE.W	($24,A0),(lbW0119E4-DT,A4)
	MOVEA.L	(active_rp_ptr-DT,A4),A0
	MOVE.W	($26,A0),(lbW0119E6-DT,A4)
	MOVEQ	#0,D5
	PEA	(4).W
	CLR.L	-(SP)
	JSR	(lbC00BDF8,PC)
	ADDQ.W	#8,SP
lbC00BD54	JSR	(_get_key_perhaps-DT,A4)
	MOVE.B	D0,D4
	CMP.B	#8,D4
	BNE.B	lbC00BD74
	TST.L	D5
	BLE.B	lbC00BD74
	SUBQ.L	#1,D5
	PEA	(4).W
	MOVE.L	D5,-(SP)
	JSR	(lbC00BDF8,PC)
	ADDQ.W	#8,SP
	BRA.B	lbC00BDAE

lbC00BD74	CMP.B	#13,D4
	BNE.B	lbC00BD84
	CLR.L	-(SP)
	MOVE.L	D5,-(SP)
	BSR.B	lbC00BDF8
	ADDQ.W	#8,SP
	BRA.B	lbC00BDB4

lbC00BD84	CMP.B	#$20,D4
	BLT.B	lbC00BDAE
	CMP.B	#$7F,D4
	BGE.B	lbC00BDAE
	CMP.L	#9,D5
	BGE.B	lbC00BDAE
	MOVE.L	D5,D0
	ADDQ.L	#1,D5
	LEA	(lbL011B20-DT,A4),A0
	MOVE.B	D4,(A0,D0.L)
	PEA	(4).W
	MOVE.L	D5,-(SP)
	BSR.B	lbC00BDF8
	ADDQ.W	#8,SP
lbC00BDAE	JSR	(lbC00DDA2-DT,A4)
	BRA.B	lbC00BD54

lbC00BDB4	LEA	(lbL011B20-DT,A4),A0
	MOVEA.L	A0,A3
lbC00BDBA	TST.B	(A2)
	BEQ.B	lbC00BDD8
	MOVEA.L	A2,A0
	ADDQ.L	#1,A2
	MOVEA.L	A3,A1
	ADDQ.L	#1,A3
	MOVE.B	(A0),D0
	CMP.B	(A1),D0
	BEQ.B	lbC00BDD6
	MOVEQ	#0,D0
lbC00BDCE	MOVEM.L	(SP)+,D4-D6/A2/A3
	UNLK	A5
	RTS

lbC00BDD6	BRA.B	lbC00BDBA

lbC00BDD8	MOVE.L	D6,D0
	ASL.L	#2,D0
	LEA	(lbL0115F2-DT,A4),A0
	CLR.L	(A0,D0.L)
	ADDQ.L	#1,(-4,A5)
	CMPI.L	#3,(-4,A5)
	blt	lbC00BCEC
	MOVEQ	#1,D0
	BRA.B	lbC00BDCE

lbC00BDF8	MOVEM.L	D0-D7/A0-A6,-(SP)
	CLR.L	D0
	JSR	(-$15C,A6)
	CLR.L	D0
	CLR.L	D1
	MOVE.W	(lbW0119E4-DT,A4),D0
	MOVE.W	(lbW0119E6-DT,A4),D1
	JSR	(-$F0,A6)
	LEA	(lbL011B20-DT,A4),A0
	MOVE.L	($40,SP),D0
	JSR	(-$3C,A6)
	MOVEA.L	(active_rp_ptr-DT,A4),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	MOVE.L	($44,SP),D0
	JSR	(-$15C,A6)
	MOVE.W	#$2020,-(SP)
	MOVEA.L	SP,A0
	MOVEQ	#1,D0
	MOVEA.L	(active_rp_ptr-DT,A4),A1
	JSR	(-$3C,A6)
	MOVEA.L	(active_rp_ptr-DT,A4),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	CLR.L	D0
	JSR	(-$15C,A6)
	MOVEA.L	SP,A0
	MOVEQ	#1,D0
	JSR	(-$3C,A6)
	ADDQ.L	#2,SP
	MOVEM.L	(SP)+,D0-D7/A0-A6
	RTS

lbC00BE5C	LINK.W	A5,#0
	MOVE.L	(12,A5),-(SP)
	MOVE.L	(8,A5),-(SP)
	JSR	(Lock2,PC)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011AE0-DT,A4)
	TST.L	(lbL011AE0-DT,A4)
	BEQ.B	lbC00BE82
	MOVE.L	(lbL011AE0-DT,A4),-(SP)
	JSR	(UnLock2,PC)
	ADDQ.W	#4,SP
lbC00BE82	MOVE.L	(lbL011AE0-DT,A4),D0
	UNLK	A5
	RTS

lbC00BE8A	LINK.W	A5,#-8
	PEA	(-2).W
	PEA	(df0.MSG,PC)
	JSR	(Lock2,PC)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011AE0-DT,A4)
	TST.L	(lbL011AE0-DT,A4)
	BEQ.B	lbC00BED8
	MOVE.L	(lbL011AE0-DT,A4),D0
	ASL.L	#2,D0
	MOVE.L	D0,(-8,A5)
	MOVEA.L	(-8,A5),A0
	MOVE.L	($10,A0),D0
	ASL.L	#2,D0
	MOVE.L	D0,(-4,A5)
	MOVEA.L	(-4,A5),A0
	CMPI.L	#$E6,($18,A0)
	BEQ.B	lbC00BECE
	BSR.B	lbC00BEE6
lbC00BECE	MOVE.L	(lbL011AE0-DT,A4),-(SP)
	JSR	(UnLock2,PC)
	ADDQ.W	#4,SP
lbC00BED8	MOVE.L	(lbL011AE0-DT,A4),D0
	UNLK	A5
	RTS

df0.MSG	db	'df0:',0,0

lbC00BEE6	JMP	(-4).W

lbC00BEEA	LINK.W	A5,#-2
	CLR.W	(-2,A5)
	BRA.B	lbC00BF12

lbC00BEF4	TST.B	(lbB012114-DT,A4)
	BEQ.B	lbC00BF04
	CLR.B	(lbB012114-DT,A4)
	MOVEQ	#1,D0
lbC00BF00	UNLK	A5
	RTS

lbC00BF04	PEA	(5).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	ADDQ.W	#1,(-2,A5)
lbC00BF12	CMPI.W	#$12C,(-2,A5)
	BLT.B	lbC00BEF4
	MOVEQ	#0,D0
	BRA.B	lbC00BF00

lbC00BF1E	LINK.W	A5,#-4
	CLR.L	(lbL011ADC-DT,A4)
	MOVE.L	(lbL011A4C-DT,A4),-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetFont-DT,A4)
	ADDQ.W	#8,SP
;lbC00BF34	PEA	(-1).W
;	PEA	(df1.MSG,PC)
;	JSR	(lbC00BE5C,PC)
;	ADDQ.W	#8,SP
;	TST.L	D0
;	BEQ.B	lbC00BF4E
;	MOVE.B	#$31,(ascii.MSG26-DT,A4)
;	BRA.B	lbC00BF9C

;lbC00BF4E	PEA	(-1).W
;	PEA	(df0.MSG0,PC)
;	JSR	(lbC00BE5C,PC)
;	ADDQ.W	#8,SP
;	TST.L	D0
;	BEQ.B	lbC00BF7A
;	PEA	(-2).W
;	PEA	(df0winpic.MSG,PC)
;	JSR	(lbC00BE5C,PC)
;	ADDQ.W	#8,SP
;	TST.L	D0
;	BNE.B	lbC00BF7A
;	MOVE.B	#$30,(ascii.MSG26-DT,A4)
;	BRA.B	lbC00BF9C

;lbC00BF7A	PEA	(Insertawritab.MSG,PC)
;	JSR	(lbC00A872,PC)
;	ADDQ.W	#4,SP
;	JSR	(lbC00BEEA,PC)
;	TST.L	D0
;	BNE.B	lbC00BF9A
;	PEA	(Aborted.MSG,PC)
;	JSR	(lbC00A872,PC)
;	ADDQ.W	#4,SP
;	bra	lbC00C162

;lbC00BF9A	BRA.B	lbC00BF34

lbC00BF9C	MOVE.W	(10,A5),D0
	EXT.L	D0
	ADD.L	#$41,D0
	MOVE.B	D0,(Afaery.MSG-DT,A4)
	TST.B	(lbB01190E-DT,A4)
	BEQ.B	lbC00BFC6
	PEA	(MODE_NEWFILE).W
;;;	PEA	(df.MSG-DT,A4)
	pea	(Afaery.MSG-DT,a4)
	JSR	(_Open-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011AD8-DT,A4)
	BRA.B	lbC00BFD8

lbC00BFC6	PEA	(MODE_OLDFILE).W
;;;	PEA	(df.MSG-DT,A4)
	pea	(Afaery.MSG-DT,a4)
	JSR	(_Open-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011AD8-DT,A4)
lbC00BFD8	TST.L	(lbL011AD8-DT,A4)
	beq	_IoErr2
	PEA	($50).W
	PEA	(lbW011956-DT,A4)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	PEA	(2).W
	PEA	(lbW00ED02-DT,A4)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	PEA	(6).W
	PEA	(lbW01194A-DT,A4)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	MOVE.W	(lbW01194A-DT,A4),D0
	MULU.W	#$16,D0
	MOVE.L	D0,-(SP)
	PEA	(lbW01230A-DT,A4)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	JSR	(lbC0082BA,PC)
	PEA	($18).W
	PEA	(lbW00E67E-DT,A4)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	MOVE.W	(lbW0115F0-DT,A4),D0
	MULU.W	#6,D0
	MOVE.L	D0,-(SP)
	PEA	(lbW0110BA-DT,A4)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	PEA	($14).W
	PEA	(lbL0115C8-DT,A4)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	PEA	($14).W
	PEA	(lbL0115DC-DT,A4)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	CLR.L	(-4,A5)
lbC00C064	MOVE.L	(-4,A5),D0
	ASL.L	#1,D0
	LEA	(lbL0115C8-DT,A4),A0
	MOVE.W	(A0,D0.L),D1
	MULU.W	#6,D1
	MOVE.L	D1,-(SP)
	MOVE.L	(-4,A5),D2
	ASL.L	#2,D2
	LEA	(lbL0115A0-DT,A4),A1
	MOVE.L	(A1,D2.L),-(SP)
	JSR	(lbC00C214,PC)
	ADDQ.W	#8,SP
	ADDQ.L	#1,(-4,A5)
	CMPI.L	#10,(-4,A5)
	BLT.B	lbC00C064
	MOVE.L	(lbL011AD8-DT,A4),-(SP)
	JSR	(_Close-DT,A4)
	ADDQ.W	#4,SP
	BRA.B	lbC00C0AE

_IoErr2	JSR	(IoErr2,PC)
	MOVE.L	D0,(lbL011ADC-DT,A4)
lbC00C0AE	TST.L	(lbL011ADC-DT,A4)
	BEQ.B	lbC00C0D0
	TST.B	(lbB01190E-DT,A4)
	BEQ.B	lbC00C0C6
	PEA	(ERRORCouldnts.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC00C0D0

lbC00C0C6	PEA	(ERRORCouldntl.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
lbC00C0D0
;	PEA	(-2).W
;	PEA	(df0winpic.MSG0,PC)
;	JSR	(Lock2,PC)
;	ADDQ.W	#8,SP
;	MOVE.L	D0,(lbL011AE0-DT,A4)
;	TST.L	(lbL011AE0-DT,A4)
;	BEQ.B	lbC00C0F4
;	MOVE.L	(lbL011AE0-DT,A4),-(SP)
;	JSR	(UnLock2,PC)
;	ADDQ.W	#4,SP
;	BRA.B	lbC00C104

;lbC00C0F4	PEA	(PleaseinsertG.MSG,PC)
;	JSR	(lbC00A872,PC)
;	ADDQ.W	#4,SP
;	JSR	(lbC00BEEA,PC)
;	BRA.B	lbC00C0D0

lbC00C104	TST.B	(lbB01190E-DT,A4)
	BNE.B	lbC00C162
	MOVEQ	#0,D0
	MOVE.B	D0,(lbB011945-DT,A4)
	EXT.W	D0
	MOVE.W	D0,(lbW0119C0-DT,A4)
	JSR	(trackdisk_read_3,PC)
	JSR	(lbC007F3A,PC)
	MOVE.B	#$63,(lbB011939-DT,A4)
	PEA	(4).W
	JSR	(lbC00A844,PC)
	ADDQ.W	#4,SP
	PEA	(7).W
	JSR	(lbC00A844,PC)
	ADDQ.W	#4,SP
	PEA	(lbB00C211,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(lbB00C212,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	PEA	(lbB00C213,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
	MOVEQ	#0,D0
	MOVE.B	D0,(lbB01193C-DT,A4)
	EXT.W	D0
	MOVE.W	D0,(lbW01199E-DT,A4)
lbC00C162	MOVE.L	(font_ptr-DT,A4),-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetFont-DT,A4)
	ADDQ.W	#8,SP
	UNLK	A5
	RTS

;df1.MSG	db	'df1:',0
;df0.MSG0	db	'df0:',0
;df0winpic.MSG	db	'df0:winpic',0
;Insertawritab.MSG	db	'Insert a writable disk in ANY drive.',0
Aborted.MSG	db	'Aborted.',0
ERRORCouldnts.MSG	db	'ERROR: Couldn''t save game.',0
ERRORCouldntl.MSG	db	'ERROR: Couldn''t load game.',0
;df0winpic.MSG0	db	'df0:winpic',0
;PleaseinsertG.MSG	db	'Please insert GAME disk.',0
lbB00C211	db	0
lbB00C212	db	0
lbB00C213	db	0

lbC00C214	LINK.W	A5,#-2
	TST.B	(lbB01190E-DT,A4)
	BEQ.B	lbC00C238
	MOVE.L	(12,A5),-(SP)
	MOVE.L	(8,A5),-(SP)
	MOVE.L	(lbL011AD8-DT,A4),-(SP)
	JSR	(Write2,PC)
	LEA	(12,SP),SP
	MOVE.W	D0,(-2,A5)
	BRA.B	lbC00C250

lbC00C238	MOVE.L	(12,A5),-(SP)
	MOVE.L	(8,A5),-(SP)
	MOVE.L	(lbL011AD8-DT,A4),-(SP)
	JSR	(_Read-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(-2,A5)
lbC00C250	TST.W	(-2,A5)
	BGE.B	lbC00C25E
	JSR	(IoErr2,PC)
	MOVE.L	D0,(lbL011ADC-DT,A4)
lbC00C25E	UNLK	A5
	RTS

lbC00C262	LINK.W	A5,#0
	MOVE.L	A2,-(SP)
	MOVE.W	(10,A5),D0
	MULS.W	#12,D0
	LEA	(lbW00E67E-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	MOVE.W	(14,A5),D0
	EXT.L	D0
	SUB.L	#$FA,D0
	MOVE.W	D0,(A2)
	MOVE.W	($12,A5),D0
	EXT.L	D0
	SUB.L	#$C8,D0
	MOVE.W	D0,(2,A2)
	MOVE.W	(14,A5),D0
	EXT.L	D0
	ADD.L	#$FA,D0
	MOVE.W	D0,(4,A2)
	MOVE.W	($12,A5),D0
	EXT.L	D0
	ADD.L	#$C8,D0
	MOVE.W	D0,(6,A2)
	MOVEA.L	(SP)+,A2
	UNLK	A5
	RTS

lbC00C2BC	LINK.W	A5,#0
	MOVE.L	D4,-(SP)
	JSR	(lbC00AADA,PC)
	MOVE.L	(font_ptr-DT,A4),-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetFont-DT,A4)
	ADDQ.W	#8,SP
	MOVE.W	(lbW011982-DT,A4),D4
	MULS.W	#3,D4
	MOVE.L	D4,D0
	ADDQ.L	#8,D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00AABA,PC)
	MOVEA.L	D4,A0
	PEA	(9,A0)
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00AABA,PC)
	MOVEA.L	D4,A0
	PEA	(10,A0)
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00DDD8-DT,A4)
	PEA	($17C).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	CLR.L	-(SP)
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	PEA	($6B).W
	PEA	($10F).W
	PEA	(13).W
	PEA	(13).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_RectFill-DT,A4)
	LEA	($14,SP),SP
	PEA	(10).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	PEA	($18).W
	MOVE.L	(active_rp_ptr-DT,A4),-(SP)
	JSR	(_SetAPen-DT,A4)
	ADDQ.W	#8,SP
	PEA	($11).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00AABA,PC)
	PEA	($12).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	PEA	($17C).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00AB44,PC)
	ADDQ.W	#1,(lbW011982-DT,A4)
	CLR.L	-(SP)
	PEA	($83F4).L
	PEA	($1587).W
	JSR	(lbC005778,PC)
	LEA	(12,SP),SP
	PEA	($52EF).W
	PEA	($56BD).W
	CLR.L	-(SP)
	JSR	(lbC00C262,PC)
	LEA	(12,SP),SP
	MOVE.B	#4,(lbL0113A6-DT,A4)
	MOVEA.L	(lbL0119FC-DT,A4),A0
	MOVE.B	#1,($1C,A0)
	PEA	($12).W
	JSR	(lbC00AA06,PC)
	ADDQ.W	#4,SP
	ADDI.W	#$64,(lbW01197A-DT,A4)
	CLR.B	(lbB0113D1-DT,A4)
	MOVEQ	#$10,D4
lbC00C3CC	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDA.L	D4,A0
	ADDQ.B	#3,(A0)
	ADDQ.L	#1,D4
	CMP.L	#$16,D4
	BLT.B	lbC00C3CC
	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

lbC00C3E4	LINK.W	A5,#0
	MOVEM.L	D4/D5,-(SP)
	PEA	(6).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00AABA,PC)
	PEA	(7).W
	JSR	(lbC00DE5C-DT,A4)
	ADDQ.W	#4,SP
	JSR	(lbC00DDD8-DT,A4)
	PEA	($50).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	MOVEA.L	(lbL011A04-DT,A4),A0
	MOVEA.L	(A0),A1
	MOVE.L	(4,A1),(lbL011A1C-DT,A4)
	CLR.L	-(SP)
	CLR.L	-(SP)
	MOVE.L	(lbL011A1C-DT,A4),-(SP)
	PEA	(winpic.MSG,PC)
	JSR	(lbC00DF88-DT,A4)
	LEA	($10,SP),SP
	PEA	($20).W
	PEA	(colormap2-DT,A4)
	PEA	(viewport1-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	PEA	($20).W
	PEA	(colormap2-DT,A4)
	PEA	(viewport2-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	#$E000,(viewport2_modes-DT,A4)
	PEA	($9C).W
	JSR	(make_display_2,PC)
	ADDQ.W	#4,SP
	MOVEQ	#$19,D4
lbC00C46C	CLR.W	(lbW011E68-DT,A4)
	CLR.W	(colormap-DT,A4)
	MOVE.W	#$FFF,(lbW011E62-DT,A4)
	MOVE.W	#$FFF,(lbW011E2C-DT,A4)
	MOVEQ	#2,D5
lbC00C482	MOVE.L	D4,D0
	ADD.L	D5,D0
	TST.L	D0
	BLE.B	lbC00C4A4
	MOVE.L	D4,D0
	ADD.L	D5,D0
	ASL.L	#1,D0
	LEA	(lbL01161E-DT,A4),A0
	MOVE.L	D5,D1
	ASL.L	#1,D1
	LEA	(colormap-DT,A4),A1
	MOVE.W	(A0,D0.L),(A1,D1.L)
	BRA.B	lbC00C4B0

lbC00C4A4	MOVE.L	D5,D0
	ASL.L	#1,D0
	LEA	(colormap-DT,A4),A0
	CLR.W	(A0,D0.L)
lbC00C4B0	ADDQ.L	#1,D5
	CMP.L	#$1C,D5
	BLT.B	lbC00C482
	CMP.L	#$FFFFFFF2,D4
	BLE.B	lbC00C4D0
	MOVE.W	#$800,(lbW011E64-DT,A4)
	MOVE.W	#$400,(lbW011E66-DT,A4)
	BRA.B	lbC00C4F6

lbC00C4D0	MOVE.L	D4,D0
	ADD.L	#$1E,D0
	MOVEQ	#2,D1
	JSR	(__divs-DT,A4)
	MOVE.L	D0,D5
	MOVE.L	D5,D0
	ASL.L	#8,D0
	MOVE.W	D0,(lbW011E64-DT,A4)
	MOVEQ	#2,D1
	MOVE.L	D5,D0
	JSR	(__divs-DT,A4)
	ASL.L	#8,D0
	MOVE.W	D0,(lbW011E66-DT,A4)
lbC00C4F6	PEA	($20).W
	PEA	(colormap-DT,A4)
	PEA	(viewport1-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	CMP.L	#$19,D4
	BNE.B	lbC00C51C
	PEA	($3C).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
lbC00C51C	PEA	(9).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	SUBQ.L	#1,D4
	CMP.L	#$FFFFFFE2,D4
	bgt	lbC00C46C
	PEA	($1E).W
	JSR	(_Delay-DT,A4)
	ADDQ.W	#4,SP
	PEA	($20).W
	PEA	(colormap2-DT,A4)
	PEA	(viewport1-DT,A4)
	JSR	(_LoadRGB4-DT,A4)
	LEA	(12,SP),SP
	MOVEM.L	(SP)+,D4/D5
	UNLK	A5
	RTS

winpic.MSG	db	'progdir:winpic',0,0

lbC00C560	MOVEQ	#8,D0
	MOVEA.L	(lbL0119FC-DT,A4),A0
	ADDA.L	(4,SP),A0
	TST.B	(A0)
	BEQ.B	lbC00C570
	MOVEQ	#10,D0
lbC00C570	RTS

lbC00C572	LINK.W	A5,#0
	MOVE.L	D4,-(SP)
	TST.W	(lbW011998-DT,A4)
	BEQ.B	lbC00C586
	MOVE.L	#$C8,D4
	BRA.B	lbC00C588

lbC00C586	MOVEQ	#0,D4
lbC00C588	MOVE.W	(lbW011988-DT,A4),D0
	AND.W	#3,D0
	BEQ.B	lbC00C59A
	CMPI.B	#$61,(lbB011939-DT,A4)
	BLE.B	lbC00C5F6
lbC00C59A	CMPI.W	#8,(lbW00ED02-DT,A4)
	BCC.B	lbC00C5DA
	PEA	(lbL010D8E-DT,A4)
	PEA	(1).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01198A-DT,A4),D0
	MOVEA.L	D0,A0
	PEA	(-$3E,A0)
	MOVEQ	#0,D1
	MOVE.W	(lbW01198A-DT,A4),D1
	MOVEA.L	D1,A1
	PEA	(-$3D,A1)
	MOVEQ	#0,D2
	MOVE.W	(lbW01198A-DT,A4),D2
	MOVEA.L	D2,A6
	ADDA.L	D4,A6
	PEA	(-$50,A6)
	JSR	(lbC00A33C,PC)
	LEA	($14,SP),SP
	BRA.B	lbC00C5F6

lbC00C5DA	PEA	(lbL010D8E-DT,A4)
	PEA	(1).W
	PEA	($64).W
	PEA	($64).W
	PEA	($64).W
	JSR	(lbC00A33C,PC)
	LEA	($14,SP),SP
lbC00C5F6	MOVE.L	(SP)+,D4
	UNLK	A5
	RTS

lbC00C5FC	LINK.W	A5,#-4
	MOVEM.L	D4-D7/A2,-(SP)
	MOVE.L	(8,A5),D4
	MOVE.L	(12,A5),D5
	JSR	(lbC00DDA2-DT,A4)
	AND.L	#7,D0
	BNE.B	lbC00C61C
	MOVEQ	#1,D1
	BRA.B	lbC00C61E

lbC00C61C	MOVEQ	#0,D1
lbC00C61E	EXT.L	D1
	MOVE.L	D1,D6
	MOVEQ	#$16,D1
	MOVE.L	D4,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	MOVE.B	D5,(15,A2)
	CMPI.B	#2,(14,A2)
	BNE.B	lbC00C654
	JSR	(lbC00DDA2-DT,A4)
	AND.L	#3,D0
	BNE.B	lbC00C64E
	MOVEQ	#1,D1
	BRA.B	lbC00C650

lbC00C64E	MOVEQ	#0,D1
lbC00C650	EXT.L	D1
	MOVE.L	D1,D6
lbC00C654	CMP.L	#1,D5
	BNE.B	lbC00C680
	TST.L	D6
	BEQ.B	lbC00C67C
	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC009BCA,PC)
	LEA	($10,SP),SP
lbC00C67C	bra	lbC00C8A8

lbC00C680	CMP.L	#8,D5
	bne	lbC00C74C
	MOVEQ	#0,D0
	MOVE.W	(A2),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW01230A-DT,A4),D1
	SUB.L	D1,D0
	MOVE.W	D0,(-2,A5)
	MOVEQ	#0,D0
	MOVE.W	(2,A2),D0
	MOVEQ	#0,D1
	MOVE.W	(lbW01230C-DT,A4),D1
	SUB.L	D1,D0
	MOVE.W	D0,(-4,A5)
	TST.W	(-2,A5)
	BGE.B	lbC00C6B6
	NEG.W	(-2,A5)
lbC00C6B6	TST.W	(-4,A5)
	BGE.B	lbC00C6C0
	NEG.W	(-4,A5)
lbC00C6C0	JSR	(lbC00DDA2-DT,A4)
	BTST	#0,D0
	BEQ.B	lbC00C72C
	CMPI.W	#8,(-2,A5)
	BLT.B	lbC00C6FE
	CMPI.W	#8,(-4,A5)
	BLT.B	lbC00C6FE
	MOVE.W	(-2,A5),D0
	EXT.L	D0
	MOVE.W	(-4,A5),D1
	EXT.L	D1
	SUBQ.L	#5,D1
	CMP.L	D1,D0
	BLE.B	lbC00C72C
	MOVE.W	(-2,A5),D2
	EXT.L	D2
	MOVE.W	(-4,A5),D3
	EXT.L	D3
	ADDQ.L	#7,D3
	CMP.L	D3,D2
	BGE.B	lbC00C72C
lbC00C6FE	PEA	(5).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC009BCA,PC)
	LEA	($10,SP),SP
	CMPI.B	#$18,($10,A2)
	BGE.B	lbC00C72A
	MOVE.B	#$18,($10,A2)
lbC00C72A	BRA.B	lbC00C748

lbC00C72C	CLR.L	-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC009BCA,PC)
	LEA	($10,SP),SP
lbC00C748	bra	lbC00C8A8

lbC00C74C	CMP.L	#4,D5
	BNE.B	lbC00C770
	TST.L	D6
	BEQ.B	lbC00C766
	JSR	(lbC00DDA2-DT,A4)
	AND.L	#7,D0
	MOVE.B	D0,($11,A2)
lbC00C766	MOVE.B	#12,($10,A2)
	bra	lbC00C8A8

lbC00C770	CMP.L	#3,D5
	BNE.B	lbC00C79E
	TST.L	D6
	BEQ.B	lbC00C79A
	PEA	(4).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
lbC00C78A	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC009BCA,PC)
	LEA	($10,SP),SP
lbC00C79A	bra	lbC00C8A8

lbC00C79E	CMP.L	#5,D5
	BNE.B	lbC00C7CC
	TST.L	D6
	BEQ.B	lbC00C7C8
	PEA	(3).W
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	MOVEQ	#0,D1
	MOVE.W	(lbW01195A-DT,A4),D1
	MOVE.L	D1,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC009BCA,PC)
	LEA	($10,SP),SP
lbC00C7C8	bra	lbC00C8A8

lbC00C7CC	CMP.L	#2,D5
	BNE.B	lbC00C826
	MOVE.W	(lbW011994-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,D7
	CMP.L	D7,D4
	BNE.B	lbC00C7E6
	MOVE.B	#4,(15,A2)
lbC00C7E6	TST.L	D6
	BEQ.B	lbC00C822
	CLR.L	-(SP)
	MOVEQ	#$16,D1
	MOVE.L	D7,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D0.L),D2
	MOVEA.L	D2,A1
	PEA	($14,A1)
	MOVEQ	#$16,D1
	MOVE.L	D7,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A6
	MOVEQ	#0,D3
	MOVE.W	(A6,D0.L),D3
	MOVE.L	D3,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC009BCA,PC)
	LEA	($10,SP),SP
lbC00C822	bra	lbC00C8A8

lbC00C826	CMP.L	#6,D5
	BNE.B	lbC00C882
	MOVE.W	(lbW01194A-DT,A4),D0
	EXT.L	D0
	CMP.L	D4,D0
	BNE.B	lbC00C83E
	MOVE.L	D4,D7
	SUBQ.L	#1,D7
	BRA.B	lbC00C842

lbC00C83E	MOVE.L	D4,D7
	ADD.L	D4,D7
lbC00C842	TST.L	D6
	BEQ.B	lbC00C880
	PEA	(2).W
	MOVEQ	#$16,D1
	MOVE.L	D7,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230C-DT,A4),A0
	MOVEQ	#0,D2
	MOVE.W	(A0,D0.L),D2
	MOVEA.L	D2,A1
	PEA	($14,A1)
	MOVEQ	#$16,D1
	MOVE.L	D7,D0
	JSR	(__mulu-DT,A4)
	LEA	(lbW01230A-DT,A4),A6
	MOVEQ	#0,D3
	MOVE.W	(A6,D0.L),D3
	MOVE.L	D3,-(SP)
	MOVE.L	D4,-(SP)
	JSR	(lbC009BCA,PC)
	LEA	($10,SP),SP
lbC00C880	BRA.B	lbC00C8A8

lbC00C882	CMP.L	#10,D5
	BNE.B	lbC00C8A8
	TST.L	D6
	BEQ.B	lbC00C8A2
	CLR.L	-(SP)
	PEA	($1623).W
	PEA	($5A2F).W
	MOVE.L	D4,-(SP)
	JSR	(lbC009BCA,PC)
	LEA	($10,SP),SP
lbC00C8A2	MOVE.B	#12,($10,A2)
lbC00C8A8	MOVEM.L	(SP)+,D4-D7/A2
	UNLK	A5
	RTS

lbC00C8B0	LINK.W	A5,#0
	MOVE.W	(10,A5),D0
	SUB.W	D0,(lbW01197C-DT,A4)
	TST.W	(lbW01197C-DT,A4)
	BGE.B	lbC00C8D2
	CLR.W	(lbW01197C-DT,A4)
	PEA	(13).W
	JSR	(lbC00A9FC,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC00C8DC

lbC00C8D2	PEA	(Yum.MSG,PC)
	JSR	(lbC00A872,PC)
	ADDQ.W	#4,SP
lbC00C8DC	UNLK	A5
	RTS

Yum.MSG	db	'Yum!',0,0

lbC00C8E6	LINK.W	A5,#0
	MOVEM.L	D4/D5,-(SP)
	JSR	(lbC00DDBA-DT,A4)
	MOVE.L	D0,D5
	JSR	(lbC00DDC0-DT,A4)
	MOVE.L	D0,D4
	ADD.L	#$96,D4
	MOVE.L	D4,-(SP)
	MOVE.L	D5,-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195A-DT,A4),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DE14-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(lbW0119BA-DT,A4)
	MOVE.L	D4,-(SP)
	MOVE.L	D5,-(SP)
	MOVEQ	#0,D0
	MOVE.W	(lbW01195C-DT,A4),D0
	MOVE.L	D0,-(SP)
	JSR	(lbC00DE1A-DT,A4)
	LEA	(12,SP),SP
	MOVE.W	D0,(lbW0119BC-DT,A4)
	MOVEM.L	(SP)+,D4/D5
	UNLK	A5
	RTS

FORMILBMBMHDC.MSG	db	'FORMILBMBMHDCMAPGRABBODYDESTCAMGCRNG',0,0

lbC00C95E	LINK.W	A5,#-8
	MOVEA.L	(12,A5),A0
	MOVE.W	(A0),D0
	MULU.W	($16,A5),D0
	MOVE.W	($12,A5),D1
	EXT.L	D1
	ADD.L	D1,D0
	MOVE.L	D0,(-4,A5)
	PEA	(MODE_OLDFILE).W
	MOVE.L	(8,A5),-(SP)
	JSR	(_Open-DT,A4)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011918-DT,A4)
	TST.L	(lbL011918-DT,A4)
	BNE.B	lbC00C996
	MOVEQ	#0,D0
lbC00C992	UNLK	A5
	RTS

lbC00C996	MOVE.L	(lbL011688-DT,A4),(lbL011AE4-DT,A4)
	JSR	(lbC0087C8,PC)
	MOVEA.L	(lbL011AE4-DT,A4),A0
	MOVE.L	(A0),D0
	CMP.L	(lbL011920-DT,A4),D0
	BEQ.B	lbC00C9BA
	MOVE.L	(lbL011918-DT,A4),-(SP)
	JSR	(_Close-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#0,D0
	BRA.B	lbC00C992

lbC00C9BA	JSR	(lbC0087EA,PC)
	MOVE.L	(lbL011914-DT,A4),(lbL011910-DT,A4)
lbC00C9C4	TST.L	(lbL011910-DT,A4)
	beq	lbC00CBE8
	JSR	(lbC0087C8,PC)
	MOVEA.L	(lbL011AE4-DT,A4),A0
	MOVE.L	(4,A0),D0
	CMP.L	(lbL011920-DT,A4),D0
	BNE.B	lbC00C9E2
	bra	lbC00CBE4

lbC00C9E2	MOVEA.L	(lbL011AE4-DT,A4),A0
	MOVE.L	(8,A0),D0
	CMP.L	(lbL011920-DT,A4),D0
	BNE.B	lbC00CA0C
	JSR	(lbC0087EA,PC)
	MOVE.L	(lbL011914-DT,A4),-(SP)
	PEA	(lbW011BA2-DT,A4)
	MOVE.L	(lbL011918-DT,A4),-(SP)
	JSR	(_Read-DT,A4)
	LEA	(12,SP),SP
	bra	lbC00CBE4

lbC00CA0C	MOVEA.L	(lbL011AE4-DT,A4),A0
	MOVE.L	($1C,A0),D0
	CMP.L	(lbL011920-DT,A4),D0
	BEQ.B	lbC00CA52
	MOVEA.L	(lbL011AE4-DT,A4),A1
	MOVE.L	($20,A1),D1
	CMP.L	(lbL011920-DT,A4),D1
	BEQ.B	lbC00CA52
	MOVEA.L	(lbL011AE4-DT,A4),A6
	MOVE.L	($18,A6),D2
	CMP.L	(lbL011920-DT,A4),D2
	BEQ.B	lbC00CA52
	MOVEA.L	(lbL011AE4-DT,A4),A6
	MOVE.L	(12,A6),D3
	CMP.L	(lbL011920-DT,A4),D3
	BEQ.B	lbC00CA52
	MOVEA.L	(lbL011AE4-DT,A4),A6
	MOVEA.L	($10,A6),A1
	CMPA.L	(lbL011920-DT,A4),A1
	BNE.B	lbC00CA6C
lbC00CA52	JSR	(lbC0087EA,PC)
	CLR.L	-(SP)
	MOVE.L	(lbL011914-DT,A4),-(SP)
	MOVE.L	(lbL011918-DT,A4),-(SP)
	JSR	(_Seek-DT,A4)
	LEA	(12,SP),SP
	bra	lbC00CBE4

lbC00CA6C	MOVEA.L	(lbL011AE4-DT,A4),A0
	MOVE.L	($14,A0),D0
	CMP.L	(lbL011920-DT,A4),D0
	bne	lbC00CBD4
	MOVE.L	(buffer_78000-DT,A4),(lbL01192A-DT,A4)
	MOVE.W	(lbW011BA2-DT,A4),D0
	EXT.L	D0
	ADD.L	#15,D0
	MOVEQ	#8,D1
	JSR	(__divs-DT,A4)
	AND.L	#$FFFE,D0
	MOVE.L	D0,(lbL011926-DT,A4)
	JSR	(lbC0087EA,PC)
	MOVE.L	(lbL011914-DT,A4),-(SP)
	MOVE.L	(lbL01192A-DT,A4),-(SP)
	MOVE.L	(lbL011918-DT,A4),-(SP)
	JSR	(_Read-DT,A4)
	LEA	(12,SP),SP
	MOVEA.L	(12,A5),A0
	MOVE.L	(8,A0),D0
	ADD.L	(-4,A5),D0
	MOVE.L	D0,(lbL011AE8-DT,A4)
	MOVEA.L	(12,A5),A0
	MOVE.L	(12,A0),D0
	ADD.L	(-4,A5),D0
	MOVE.L	D0,(lbL011AEC-DT,A4)
	MOVEA.L	(12,A5),A0
	MOVE.L	($10,A0),D0
	ADD.L	(-4,A5),D0
	MOVE.L	D0,(lbL011AF0-DT,A4)
	MOVEA.L	(12,A5),A0
	MOVE.L	($14,A0),D0
	ADD.L	(-4,A5),D0
	MOVE.L	D0,(lbL011AF4-DT,A4)
	MOVEA.L	(12,A5),A0
	MOVE.L	($18,A0),D0
	ADD.L	(-4,A5),D0
	MOVE.L	D0,(lbL011AF8-DT,A4)
	MOVE.B	(lbB011BAC-DT,A4),(lbB011924-DT,A4)
	CLR.L	(-8,A5)
	bra	lbC00CBC0

lbC00CB14	MOVEA.L	(12,A5),A0
	TST.B	(5,A0)
	BLS.B	lbC00CB28
	MOVE.L	(lbL011AE8-DT,A4),-(SP)
	JSR	(lbC008D1C,PC)
	ADDQ.W	#4,SP
lbC00CB28	MOVEA.L	(12,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	ADD.L	D0,(lbL011AE8-DT,A4)
	MOVEA.L	(12,A5),A0
	CMPI.B	#1,(5,A0)
	BLS.B	lbC00CB4A
	MOVE.L	(lbL011AEC-DT,A4),-(SP)
	JSR	(lbC008D1C,PC)
	ADDQ.W	#4,SP
lbC00CB4A	MOVEA.L	(12,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	ADD.L	D0,(lbL011AEC-DT,A4)
	MOVEA.L	(12,A5),A0
	CMPI.B	#2,(5,A0)
	BLS.B	lbC00CB6C
	MOVE.L	(lbL011AF0-DT,A4),-(SP)
	JSR	(lbC008D1C,PC)
	ADDQ.W	#4,SP
lbC00CB6C	MOVEA.L	(12,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	ADD.L	D0,(lbL011AF0-DT,A4)
	MOVEA.L	(12,A5),A0
	CMPI.B	#3,(5,A0)
	BLS.B	lbC00CB8E
	MOVE.L	(lbL011AF4-DT,A4),-(SP)
	JSR	(lbC008D1C,PC)
	ADDQ.W	#4,SP
lbC00CB8E	MOVEA.L	(12,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	ADD.L	D0,(lbL011AF4-DT,A4)
	MOVEA.L	(12,A5),A0
	CMPI.B	#4,(5,A0)
	BLS.B	lbC00CBB0
	MOVE.L	(lbL011AF8-DT,A4),-(SP)
	JSR	(lbC008D1C,PC)
	ADDQ.W	#4,SP
lbC00CBB0	MOVEA.L	(12,A5),A0
	MOVEQ	#0,D0
	MOVE.W	(A0),D0
	ADD.L	D0,(lbL011AF8-DT,A4)
	ADDQ.L	#1,(-8,A5)
lbC00CBC0	MOVE.W	(lbW011BA4-DT,A4),D0
	EXT.L	D0
	MOVE.L	(-8,A5),D1
	CMP.L	D0,D1
	blt	lbC00CB14
	BRA.B	lbC00CBE8

	BRA.B	lbC00CBE4

lbC00CBD4	MOVE.L	(lbL011918-DT,A4),-(SP)
	JSR	(_Close-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#0,D0
	bra	lbC00C992

lbC00CBE4	bra	lbC00C9C4

lbC00CBE8	MOVE.L	(lbL011918-DT,A4),-(SP)
	JSR	(_Close-DT,A4)
	ADDQ.W	#4,SP
	MOVEQ	#1,D0
	bra	lbC00C992

; ---------------------------------------------------
vblank_server	MOVEM.L	D0-D5/A1-A5,-(SP)
	CLR.B	(1,A1)
	CLR.L	D0
	MOVE.W	(2,A1),D0
	ADD.L	D0,($10,A1)
	TST.B	(A1)
	BNE.B	lbC00CC1A
	MOVEA.L	A1,A3
	MOVEA.L	A0,A4
	BSR.B	lbC00CC24
	BSR.B	lbC00CC24
	BSR.B	lbC00CC24
	BSR.B	lbC00CC24
lbC00CC1A	CLR.B	D2
	ST	D2
	MOVEM.L	(SP)+,D0-D5/A1-A5
	RTS

lbC00CC24	TST.L	($28,A3)
	beq	lbC00CD38
	MOVE.L	($10,A1),D0
	CMP.L	($1C,A3),D0
	BPL.B	lbC00CC7A
	TST.B	($1B,A3)
	bne	lbC00CD38
	CMP.L	($20,A3),D0
	BPL.B	lbC00CC62
	TST.B	($1A,A3)
	bne	lbC00CD38
	MOVEA.L	($24,A3),A2
	MOVE.B	(A2)+,D0
	BMI.W	lbC00CD38

;;;;	MOVE.B	D0,($A8,A4)

	move.w	d0,($a8,a4)

	MOVE.L	A2,($24,A3)
	bra	lbC00CD38

lbC00CC62
;;;;	MOVE.B	(0).W,($A8,A4)	;!*****************

	move.w	#0,($a8,a4)

	bra	lbC00CD38

lbC00CC6C
;;;;	CLR.B	($A8,A4)

	move.w	#0,($a8,a4)

	MOVE.L	($10,A1),($20,A3)
	bra	lbC00CD38

lbC00CC7A	MOVEA.L	($28,A3),A2
	CLR.L	D2
	CLR.L	D3
	MOVE.B	(A2)+,D3
	MOVE.B	(A2)+,D2
	MOVE.L	A2,($28,A3)
	BTST	#7,D3
	BEQ.B	lbC00CCB0
	CMP.B	#$80,D3
	BEQ.B	lbC00CCB0
	CMP.B	#$81,D3
	beq	lbC00CEFA
	CMP.B	#$90,D3
	beq	lbC00CF10
	CMP.B	#$FF,D3
	beq	lbC00CF1E
	BRA.B	lbC00CC7A

lbC00CCB0	BCLR	#7,D2
	BCLR	#6,D2
	LEA	(lbL00CE7A,PC),A5
	ADD.W	D2,D2
	CLR.L	D5
	MOVE.W	(A5,D2.W),D5
	MOVE.L	D5,D4
	SUB.L	#$12C,D4
	BPL.B	lbC00CCD0
	MOVE.L	D5,D4
lbC00CCD0	ADD.L	($1C,A3),D4
	MOVE.L	D4,($20,A3)
	ADD.L	D5,($1C,A3)
	TST.B	($1B,A3)
	BNE.B	lbC00CD38
	CLR.L	D4
	MOVE.B	($18,A3),D4
	LSL.W	#7,D4
	ADD.L	(12,A1),D4
	CLR.L	D5
	MOVE.B	($19,A3),D5
	LSL.W	#8,D5
	ADD.L	(8,A1),D5
	MOVEA.L	D5,A5
	CLR.W	D5
	MOVE.B	(A5)+,D5
	MOVE.L	A5,($24,A3)
	CLR.W	($1A,A3)
	TST.B	D3
	BMI.W	lbC00CC6C
	LSL.W	#2,D3
	MOVE.W	(lbL00CD44,PC,D3.W),D2
	MOVE.W	(lbW00CD42,PC,D3.W),D1
	MOVE.W	#$20,D3
	SUB.W	D2,D3
	LSL.W	#2,D2
	AND.L	#$FFFF,D2
	ADD.L	D2,D4
	MOVE.W	D5,($A8,A4)
	MOVE.L	D4,($A0,A4)
	MOVE.W	D3,($A4,A4)
	MOVE.W	D1,($A6,A4)
lbC00CD38	ADDA.W	#$1C,A3
	ADDA.W	#$10,A4
	RTS

lbW00CD42	dw	$5A0
lbL00CD44	dl	$54C
	dl	$500
	dl	$4B8
	dl	$474
	dl	$434
	dl	$3F8
	dl	$3C0
	dl	$38A
	dl	$358
	dl	$328
	dl	$2FA
	dl	$2D0
	dl	$2A6
	dl	$280
	dl	$25C
	dl	$23A
	dl	$21A
	dl	$1FC
	dl	$1E0
	dl	$1C5
	dl	$1AC
	dl	$194
	dl	$17D
	dl	$168
	dl	$153
	dl	$140
	dl	$12E
	dl	$11D
	dl	$10D
	dl	$1FC
	dl	$1001E0
	dl	$1001C5
	dl	$1001AC
	dl	$100194
	dl	$10017D
	dl	$100168
	dl	$100153
	dl	$100140
	dl	$10012E
	dl	$10011D
	dl	$10010D
	dl	$1001FC
	dl	$1801E0
	dl	$1801C5
	dl	$1801AC
	dl	$180194
	dl	$18017D
	dl	$180168
	dl	$180153
	dl	$180140
	dl	$18012E
	dl	$18011D
	dl	$18010D
	dl	$1801FC
	dl	$1C01E0
	dl	$1C01C5
	dl	$1C01AC
	dl	$1C0194
	dl	$1C017D
	dl	$1C0168
	dl	$1C0153
	dl	$1C0140
	dl	$1C012E
	dl	$1C011D
	dl	$1C010D
	dl	$1C00FE
	dl	$1C00F0
	dl	$1C00E2
	dl	$1C00D6
	dl	$1C00CA
	dl	$1C00BE
	dl	$1C00B4
	dl	$1C00AA
	dl	$1C00A0
	dl	$1C0097
	dl	$1C008F
	dl	$1C0087
	dw	$1C
lbL00CE7A	dl	$69003480
	dl	$1A400D20
	dl	$6900348
	dl	$1A400D2
	dl	$9D804EC0
	dl	$276013B0
	dl	$9D804EC
	dl	$276013B
	dl	$46002300
	dl	$118008C0
	dl	$4600230
	dl	$118008C
	dl	$69003480
	dl	$1A400D20
	dl	$6900348
	dl	$1A400D2
	dl	$54002A00
	dl	$15000A80
	dl	$54002A0
	dl	$15000A8
	dl	$7E003F00
	dl	$1F800FC0
	dl	$7E003F0
	dl	$1F800FC
	dl	$5A002D00
	dl	$16800B40
	dl	$5A002D0
	dl	$16800B4
	dl	$87004380
	dl	$21C010E0
	dl	$8700438
	dl	$21C010E

lbC00CEFA	AND.L	#15,D2
	ADD.W	D2,D2
	MOVEA.L	(4,A1),A2
	MOVE.W	(A2,D2.W),($18,A3)
	bra	lbC00CC7A

lbC00CF10	AND.L	#$FF,D2
	MOVE.W	D2,(2,A1)
	bra	lbC00CC7A

lbC00CF1E	TST.B	D2
	BNE.B	lbC00CF36
	CLR.L	($28,A3)
	MOVE.B	#$FF,($1A,A3)

;;;;	MOVE.W	(0).W,($A8,A4)	;!***************

	move.w	#0,($a8,a4)

	bra	lbC00CD38

lbC00CF36	MOVE.L	($2C,A3),($28,A3)
	bra	lbC00CC7A

aud_handler	MOVEM.L	D1/A2,-(SP)
	MOVE.W	#$100,($9A,A0)
	MOVE.W	#$100,($9C,A0)
	LEA	($37,A1),A2
	TST.B	(A2)
	BEQ.B	lbC00CF70
	SUBQ.B	#1,(A2)
	BNE.B	lbC00CF6A
	MOVE.W	#0,($B8,A0)
	MOVE.W	#2,($B6,A0)
	BEQ.B	lbC00CF70
lbC00CF6A	MOVE.W	#$8100,($9A,A0)	;!***************
lbC00CF70	MOVEM.L	(SP)+,D1/A2
	RTS

start_aud_note	MOVEA.L	#_custom,A0
	MOVE.W	#DMAF_AUD1,(dmacon,A0)
	MOVE.W	#2,(aud1+ac_per,A0)
	MOVE.L	(4,SP),D0
	MOVE.L	(8,SP),D1
	MOVE.L	(12,SP),D2
	LEA	(vblank_data-DT,A4),A1
	MOVE.B	#2,($37,A1)
	MOVE.B	#$FF,($36,A1)
	MOVE.W	#$40,(aud1+ac_vol,A0)
	MOVE.L	D0,(aud1,A0)
	MOVE.W	D1,(aud1+ac_len,A0)
	MOVE.W	D2,(aud1+ac_per,A0)
	MOVE.W	#INTF_AUD1,(intreq,A0)
	MOVE.W	#(INTF_AUD1|INTF_SETCLR),(intena,A0)
	MOVE.W	#(DMAF_AUD1|DMAF_MASTER|DMAF_SETCLR),(dmacon,A0)
	RTS

	LEA	(vblank_data-DT,A4),A1
	ANDI.B	#$FE,($6F,A1)
	MOVEA.L	#_custom,A0
	MOVE.W	#0,(aud1+ac_vol,A0)
	MOVE.W	#2,(aud1+ac_per,A0)
	RTS

	LEA	(vblank_data-DT,A4),A1
	MOVE.L	(4,SP),D0
	MOVE.W	D0,(2,A1)
	RTS

lbC00CFF6	LEA	(vblank_data-DT,A4),A1
	MOVE.L	(4,SP),D0
	MOVE.L	D0,($2C,A1)
	MOVE.L	(8,SP),D0
	MOVE.L	D0,($48,A1)
	MOVE.L	(12,SP),D0
	MOVE.L	D0,($64,A1)
	MOVE.L	($10,SP),D0
	MOVE.L	D0,($80,A1)
	RTS

start_aud_play	MOVEM.L	D0/A0-A2,-(SP)
	MOVEA.L	#_custom,A0
	LEA	(vblank_data-DT,A4),A1
	MOVE.L	($14,SP),D0
	MOVE.L	D0,($2C,A1)
	MOVE.L	D0,($28,A1)
	MOVE.L	($18,SP),D0
	MOVE.L	D0,($48,A1)
	MOVE.L	D0,($44,A1)
	MOVE.L	($1C,SP),D0
	MOVE.L	D0,($64,A1)
	MOVE.L	D0,($60,A1)
	MOVE.L	($20,SP),D0
	MOVE.L	D0,($80,A1)
	MOVE.L	D0,($7C,A1)

;;;;	CLR.W	(aud0+ac_vol,A0)
;;;;	CLR.W	(aud1+ac_vol,A0)
;;;;	CLR.W	(aud2+ac_vol,A0)
;;;;	CLR.W	(aud3+ac_vol,A0)

	moveq	#0,d0
	move.w	d0,(aud0+ac_vol,a0)
	move.w	d0,(aud1+ac_vol,a0)
	move.w	d0,(aud2+ac_vol,a0)
	move.w	d0,(aud3+ac_vol,a0)

	MOVEA.L	(4,A1),A2
	MOVE.W	(A2)+,($18,A1)
	MOVE.W	(A2)+,($34,A1)
	MOVE.W	(A2)+,($50,A1)
	MOVE.W	(A2)+,($6C,A1)
	MOVE.W	#$FFFF,D0
	MOVE.B	D0,($1A,A1)
	MOVE.B	D0,($36,A1)
	MOVE.B	D0,($52,A1)
	MOVE.B	D0,($6E,A1)
	CLR.L	D0
	MOVE.L	D0,($10,A1)
	MOVE.L	D0,($1C,A1)
	MOVE.L	D0,($38,A1)
	MOVE.L	D0,($54,A1)
	MOVE.L	D0,($70,A1)
	MOVE.L	D0,($20,A1)
	MOVE.L	D0,($3C,A1)
	MOVE.L	D0,($58,A1)
	MOVE.L	D0,($74,A1)
	MOVE.B	D0,($1B,A1)
	MOVE.B	D0,($37,A1)
	MOVE.B	D0,($53,A1)
	MOVE.B	D0,($6F,A1)
	MOVE.B	#0,(A1)
	MOVE.W	#(DMAF_AUD0|DMAF_AUD1|DMAF_AUD2|DMAF_AUD3|DMAF_AUDIO|DMAF_MASTER|DMAF_SETCLR),(dmacon,A0)
	MOVEM.L	(SP)+,D0/A0-A2
	RTS

silence_audio	MOVEA.L	#_custom,A0
	LEA	(vblank_data-DT,A4),A1

;;;;	CLR.W	(aud0+ac_vol,A0)
;;;;	CLR.W	(aud1+ac_vol,A0)
;;;;	CLR.W	(aud2+ac_vol,A0)
;;;;	CLR.W	(aud3+ac_vol,A0)

	movem.l	d0/d1,-(sp)
	moveq	#0,d0
	moveq	#2,d1
	move.w	d1,(aud0+ac_len,a0)
	move.w	d1,(aud0+ac_per,a0)
	move.w	d0,(aud0+ac_vol,a0)
	move.w	d1,(aud1+ac_len,a0)
	move.w	d1,(aud1+ac_per,a0)
	move.w	d0,(aud1+ac_vol,a0)
	move.w	d1,(aud2+ac_len,a0)
	move.w	d1,(aud2+ac_per,a0)
	move.w	d0,(aud2+ac_vol,a0)
	move.w	d1,(aud3+ac_len,a0)
	move.w	d1,(aud3+ac_per,a0)
	move.w	d0,(aud3+ac_vol,a0)
	movem.l	(sp)+,d0/d1

	MOVE.W	#(DMAF_AUD0|DMAF_AUD1|DMAF_AUD2|DMAF_AUD3|DMAF_AUDIO),(dmacon,A0)
	MOVE.B	#$FF,(A1)
	RTS

install_aud_handlers
	MOVE.L	A6,-(SP)
	MOVEA.L	#vblank_data,A1
	MOVE.L	(8,SP),(4,A1)
	MOVE.L	(12,SP),(12,A1)
	MOVE.L	($10,SP),(8,A1)
	MOVE.W	#$96,(2,A1)
	MOVE.B	#$FF,(A1)
	LEA	(vblank_interrupt-DT,A4),A1

;;;;	MOVE.L	(0).W,(LN_SUCC,A1)	;!**************
;;;;	MOVE.L	(0).W,(LN_PRED,A1)	;!**************
;;;;	MOVE.W	#1,(LN_TYPE,A1)

	move.l	#0,(LN_SUCC,a1)
	move.l	#0,(LN_PRED,a1)
	move.b	#NT_INTERRUPT,(LN_TYPE,a1)
	move.b	#127,(LN_PRI,a1)

	MOVE.L	#musicvblank.MSG,(LN_NAME,A1)
	MOVE.L	#vblank_data,(IS_DATA,A1)
	MOVE.L	#vblank_server,(IS_CODE,A1)
	MOVEA.L	(4).W,A6
	MOVEQ	#INTB_VERTB,D0
	JSR	(_LVOAddIntServer,A6)
	LEA	(lbL011768-DT,A4),A1

;;;;	MOVE.L	(0).W,(LN_SUCC,A1)	;!***************
;;;;	MOVE.L	(0).W,(LN_PRED,A1)	;!***************
;;;;	MOVE.W	#1,(LN_TYPE,A1)

	move.l	#0,(LN_SUCC,a1)
	move.l	#0,(LN_PRED,a1)
	move.b	#NT_INTERRUPT,(LN_TYPE,a1)
	move.b	#127,(LN_PRI,a1)

	MOVE.L	#audio4.MSG,(LN_NAME,A1)
	MOVE.L	#vblank_data,(IS_DATA,A1)
	MOVE.L	#aud_handler,(IS_CODE,A1)
	MOVEA.L	(4).W,A6
	MOVEQ	#INTB_AUD1,D0
	JSR	(_LVOSetIntVector,A6)
	MOVE.L	D0,(old_aud_handler-DT,A4)
	MOVEA.L	#_custom,A0
	MOVE.W	#INTF_AUD1,(intreq,A0)
	MOVE.W	#INTF_AUD1,(intena,A0)
	MOVEA.L	(SP)+,A6
	RTS

remove_aud_handlers	JSR	(silence_audio,PC)
	MOVE.L	A6,-(SP)
	MOVEA.L	(4).W,A6
	LEA	(vblank_interrupt-DT,A4),A1
	MOVEQ	#INTB_VERTB,D0
	JSR	(_LVORemIntServer,A6)
	move.l	#_custom,a0
	MOVE.W	#INTF_AUD1,(intena,A0)	;!**************
	MOVEA.L	(4).W,A6
	MOVEA.L	(old_aud_handler-DT,A4),A1
	MOVEQ	#INTB_AUD1,D0
	JSR	(_LVOSetIntVector,A6)
	MOVEA.L	(SP)+,A6
	RTS

lbL00D1D4	dl	0

ProgramStart
	movem.l	d2-d7/a2-a6,-(sp)
;	LEA	(ProgStart-4).L,A1
;	MOVEA.L	(A1),A4
;	ADDA.L	A4,A4
;	ADDA.L	A4,A4
;	ADDA.L	#$8002,A4
	move.l	#DT,a4
	LEA	(lbB011818-DT,A4),A1
	LEA	(lbB011818-DT,A4),A2
	CMPA.L	A1,A2
	BNE.B	lbC00D204
	MOVE.W	#$3B6,D1
	BMI.B	lbC00D204
	MOVEQ	#0,D2
lbC00D1FE	MOVE.L	D2,(A1)+
	DBRA	D1,lbC00D1FE
lbC00D204	LEA	(lbL00D1D4,PC),A1
	MOVE.L	A4,(A1)
	MOVE.L	SP,(lbL01192E-DT,A4)
	MOVEA.L	(AbsExecBase).W,A6
	MOVE.L	A6,(SysBase-DT,A4)
	MOVEM.L	D0/A0,-(SP)
	JSR	(lbC00D228,PC)
	ADDQ.W	#8,SP
	movem.l	(sp)+,d2-d7/a2-a6
	RTS

	MOVEA.L	(lbL00D1D4,PC),A4
	RTS

lbC00D228	LINK.W	A5,#-4
	MOVEM.L	D4-D6/A2/A3,-(SP)
	CLR.L	-(SP)
	PEA	(DosName,PC)
	JSR	(OpenLibrary,PC)
	ADDQ.W	#8,SP
	MOVE.L	D0,(DosBase-DT,A4)
	BNE.B	lbC00D256
	CLR.L	-(SP)
	PEA	((AT_Recovery|AG_OpenLib|AO_DOSLib)).L
	JSR	(Alert,PC)
	ADDQ.W	#8,SP
	MOVEA.L	(lbL01192E-DT,A4),SP
	RTS

lbC00D256	CLR.L	-(SP)
	JSR	(FindTask,PC)
	ADDQ.W	#4,SP
	MOVEA.L	D0,A3
	TST.L	(pr_CLI,A3)
	beq	lbC00D44A
	MOVEA.L	(lbL01192E-DT,A4),A0
	MOVE.L	(lbL01192E-DT,A4),D0
	SUB.L	(4,A0),D0
	ADDQ.L	#8,D0
	MOVE.L	D0,(lbL011B08-DT,A4)
	MOVEA.L	(lbL011B08-DT,A4),A0
	MOVE.L	#'MANX',(A0)
	MOVE.L	(pr_CLI,A3),D0
	ASL.L	#2,D0
	MOVE.L	D0,D5
	MOVEA.L	D5,A0
	MOVE.L	($10,A0),D0
	ASL.L	#2,D0
	MOVEA.L	D0,A2
	MOVE.B	(A2),D0
	EXT.W	D0
	EXT.L	D0
	ADD.L	(8,A5),D0
	ADDQ.L	#2,D0
	MOVE.W	D0,(lbW0119EE-DT,A4)
	CLR.L	-(SP)
	MOVE.W	(lbW0119EE-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	JSR	(AllocMem,PC)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011B10-DT,A4)
	MOVE.B	(A2),D0
	EXT.W	D0
	MOVE.W	D0,-(SP)
	MOVEA.L	A2,A0
	ADDQ.L	#1,A0
	MOVE.L	A0,-(SP)
	MOVE.L	(lbL011B10-DT,A4),-(SP)
	JSR	(_strncpy,PC)
	LEA	(10,SP),SP
	PEA	(ascii.MSG1,PC)
	MOVE.B	(A2),D0
	EXT.W	D0
	EXT.L	D0
	ADD.L	(lbL011B10-DT,A4),D0
	MOVE.L	D0,-(SP)
	JSR	(_strcpy,PC)
	ADDQ.W	#8,SP
	MOVE.W	(10,A5),-(SP)
	MOVE.L	(12,A5),-(SP)
	MOVE.L	(lbL011B10-DT,A4),-(SP)
	JSR	(_strncat,PC)
	LEA	(10,SP),SP
	CLR.W	(lbW0119EC-DT,A4)
	MOVEA.L	(lbL011B10-DT,A4),A2
	MOVE.L	A2,(12,A5)
lbC00D308	MOVE.B	(A2),D0
	EXT.W	D0
	ADDQ.W	#1,D0
	LEA	(lbL01178C-DT,A4),A0
	BTST	#4,(A0,D0.W)
	BEQ.B	lbC00D31E
	ADDQ.L	#1,A2
	BRA.B	lbC00D308

lbC00D31E	CMPI.B	#$20,(A2)
	BLT.B	lbC00D39E
	CMPI.B	#$22,(A2)
	BNE.B	lbC00D360
	ADDQ.L	#1,A2
lbC00D32C	MOVEA.L	A2,A0
	ADDQ.L	#1,A2
	MOVE.B	(A0),D0
	EXT.W	D0
	MOVE.W	D0,D4
	BEQ.B	lbC00D35E
	MOVEA.L	(12,A5),A0
	ADDQ.L	#1,(12,A5)
	MOVE.B	D4,(A0)
	CMP.W	#$22,D4
	BNE.B	lbC00D35C
	CMPI.B	#$22,(A2)
	BNE.B	lbC00D352
	ADDQ.L	#1,A2
	BRA.B	lbC00D35C

lbC00D352	MOVEA.L	(12,A5),A0
	CLR.B	(-1,A0)
	BRA.B	lbC00D35E

lbC00D35C	BRA.B	lbC00D32C

lbC00D35E	BRA.B	lbC00D392

lbC00D360	MOVEA.L	A2,A0
	ADDQ.L	#1,A2
	MOVE.B	(A0),D0
	EXT.W	D0
	MOVE.W	D0,D4
	BEQ.B	lbC00D388
	MOVE.W	D4,D1
	ADDQ.W	#1,D1
	LEA	(lbL01178C-DT,A4),A1
	BTST	#4,(A1,D1.W)
	BNE.B	lbC00D388
	MOVEA.L	(12,A5),A0
	ADDQ.L	#1,(12,A5)
	MOVE.B	D4,(A0)
	BRA.B	lbC00D360

lbC00D388	MOVEA.L	(12,A5),A0
	ADDQ.L	#1,(12,A5)
	CLR.B	(A0)
lbC00D392	TST.W	D4
	BEQ.B	lbC00D39E
	ADDQ.W	#1,(lbW0119EC-DT,A4)
	bra	lbC00D308

lbC00D39E	MOVEA.L	(12,A5),A0
	CLR.B	(A0)
	CLR.L	-(SP)
	MOVE.W	(lbW0119EC-DT,A4),D0
	ADDQ.W	#1,D0
	EXT.L	D0
	ASL.L	#2,D0
	MOVE.L	D0,-(SP)
	JSR	(AllocMem,PC)
	ADDQ.W	#8,SP
	MOVE.L	D0,(lbL011B0C-DT,A4)
	MOVEQ	#0,D4
	MOVEA.L	(lbL011B10-DT,A4),A2
	BRA.B	lbC00D3E2

lbC00D3C4	MOVEQ	#0,D0
	MOVE.W	D4,D0
	ASL.L	#2,D0
	MOVEA.L	(lbL011B0C-DT,A4),A0
	MOVE.L	A2,(A0,D0.L)
	MOVE.L	A2,-(SP)
	JSR	(__strlen,PC)
	ADDQ.W	#4,SP
	ADDQ.W	#1,D0
	EXT.L	D0
	ADDA.L	D0,A2
	ADDQ.W	#1,D4
lbC00D3E2	CMP.W	(lbW0119EC-DT,A4),D4
	BCS.B	lbC00D3C4
	MOVEQ	#0,D0
	MOVE.W	D4,D0
	ASL.L	#2,D0
	MOVEA.L	(lbL011B0C-DT,A4),A0
	CLR.L	(A0,D0.L)
	JSR	(Input,PC)
	MOVE.L	D0,(input_handle-DT,A4)
	MOVE.W	#$8000,(lbW011F9A-DT,A4)
	JSR	(Output,PC)
	MOVE.L	D0,(output_handle-DT,A4)
	MOVE.W	#$8001,(lbW011FA0-DT,A4)
	PEA	(MODE_OLDFILE).W
	PEA	(ascii.MSG10,PC)
	JSR	(Open,PC)
	ADDQ.W	#8,SP
	MOVE.L	D0,(star_handle-DT,A4)
	MOVE.W	#1,(lbW011FA6-DT,A4)
	MOVE.W	#1,(lbW0119EA-DT,A4)
	MOVE.L	(lbL011B0C-DT,A4),-(SP)
	MOVE.W	(lbW0119EC-DT,A4),-(SP)
	JSR	(_main-DT,A4)
	ADDQ.W	#6,SP
	CLR.W	-(SP)
	JSR	(_exit,PC)
	ADDQ.W	#2,SP
	bra	lbC00D502

lbC00D44A	MOVE.L	(pr_Task+TC_SPLOWER,A3),D0
	ADDQ.L	#8,D0
	MOVE.L	D0,(lbL011B08-DT,A4)
	MOVEA.L	(lbL011B08-DT,A4),A0
	MOVE.L	#'MANX',(A0)
;;;;	PEA	(pr_MsgPort,A3)
;;;;	JSR	(WaitPort,PC)
;;;;	ADDQ.W	#4,SP
;;;;	PEA	(pr_MsgPort,A3)
;;;;	JSR	(GetMsg,PC)
;;;;	ADDQ.W	#4,SP
;;;;	MOVE.L	D0,(workbench_message-DT,A4)
	move.l	(_wbmessage),(workbench_message-DT,A4)
	MOVEA.L	(workbench_message-DT,A4),A0
	TST.L	(sm_ArgList,A0)
	BEQ.B	lbC00D490
	MOVEA.L	(workbench_message-DT,A4),A0
	MOVEA.L	(sm_ArgList,A0),A1
	MOVE.L	(A1),-(SP)
	JSR	(CurrentDir,PC)
	ADDQ.W	#4,SP
lbC00D490	MOVEA.L	(workbench_message-DT,A4),A0
	TST.L	(sm_ToolWindow,A0)
	BEQ.B	lbC00D4EE
	PEA	(MODE_OLDFILE).W
	MOVEA.L	(workbench_message-DT,A4),A0
	MOVE.L	(sm_ToolWindow,A0),-(SP)
	JSR	(Open,PC)
	ADDQ.W	#8,SP
	MOVE.L	D0,(input_handle-DT,A4)
	BEQ.B	lbC00D4EE
	MOVE.L	(input_handle-DT,A4),(star_handle-DT,A4)
	MOVE.L	(input_handle-DT,A4),(output_handle-DT,A4)
	MOVE.L	(input_handle-DT,A4),(pr_COS,A3)
	MOVE.L	(pr_COS,A3),(pr_CIS,A3)
	CLR.W	(lbW011F9A-DT,A4)
	MOVE.W	#1,(lbW011FA6-DT,A4)
	MOVE.W	#1,(lbW011FA0-DT,A4)
	MOVE.L	(input_handle-DT,A4),D0
	ASL.L	#2,D0
	MOVE.L	D0,(-4,A5)
	MOVEA.L	(-4,A5),A0
	MOVE.L	(8,A0),(pr_ConsoleTask,A3)
lbC00D4EE	MOVE.L	(workbench_message-DT,A4),-(SP)
	CLR.W	-(SP)
	JSR	(_main-DT,A4)
	ADDQ.W	#6,SP
	CLR.W	-(SP)
	JSR	(_exit,PC)
	ADDQ.W	#2,SP
lbC00D502	MOVEM.L	(SP)+,D4-D6/A2/A3
	UNLK	A5
	RTS

DosName	db	'dos.library',0
ascii.MSG1	db	' ',0
ascii.MSG10	db	'*',0

; strncpy(dest,source,maxlength)
_strncpy	MOVEM.L	(strncpy_dest,SP),A0/A1
	MOVE.L	A0,D0
	MOVE.W	(strncpy_maxlength,SP),D1
	BRA.B	.loopstarter

.loop	MOVE.B	(A1)+,(A0)+
.loopstarter	DBEQ	D1,.loop
	BEQ.B	.loop0starter
	ADDQ.W	#1,D1
	BRA.B	.loop0starter

.loop0	CLR.B	(A0)+
.loop0starter	DBRA	D1,.loop0
	RTS

; strcat(dest,source)
_strcat	MOVE.W	#$7FFF,D0
	BRA.B	catcommon

; strncat(dest,source,maxlength)
_strncat	MOVE.W	(strncat_maxlength,SP),D0
catcommon	MOVEA.L	(strncat_dest,SP),A0
.loop	TST.B	(A0)+
	BNE.B	.loop
	SUBQ.W	#1,A0
	MOVEA.L	(strncat_source,SP),A1
	SUBQ.W	#1,D0
.loop0	MOVE.B	(A1)+,(A0)+
	DBEQ	D0,.loop0
	BEQ.B	.exit
	CLR.B	(A0)
.exit	MOVE.L	(strncat_dest,SP),D0
	RTS

_strcpy	MOVEA.L	(4,SP),A0
	MOVE.L	A0,D0
	MOVEA.L	(8,SP),A1
.loop	MOVE.B	(A1)+,(A0)+
	BNE.B	.loop
	RTS

; D0 = D0 * D1
_mulu	MOVEM.L	D1-D3,-(SP)
	MOVE.W	D1,D2
	MULU.W	D0,D2
	MOVE.L	D1,D3
	SWAP	D3
	MULU.W	D0,D3
	SWAP	D3
	CLR.W	D3
	ADD.L	D3,D2
	SWAP	D0
	MULU.W	D1,D0
	SWAP	D0
	CLR.W	D0
	ADD.L	D2,D0
	MOVEM.L	(SP)+,D1-D3
	RTS

; D0.L = D0.L / D1.L
_divs	MOVEM.L	D1/D4,-(SP)
	CLR.L	D4
	TST.L	D0
	BPL.B	1$
	NEG.L	D0
	ADDQ.W	#1,D4
1$	TST.L	D1
	BPL.B	2$
	NEG.L	D1
	EORI.W	#1,D4
2$	BSR.B	comdivide
divs_chksign	TST.W	D4
	BEQ.B	divs_exit
	NEG.L	D0
divs_exit	MOVEM.L	(SP)+,D1/D4
	TST.L	D0
	RTS

; D0.L = D0.L MOD D1.L signed
_mods	MOVEM.L	D1/D4,-(SP)
	CLR.L	D4
	TST.L	D0
	BPL.B	1$
	NEG.L	D0
	ADDQ.W	#1,D4
1$	TST.L	D1
	BPL.B	2$
	NEG.L	D1
2$	BSR.B	comdivide
	MOVE.L	D1,D0
	BRA.B	divs_chksign

; D0.L = D0.L MOD D1.L unsigned
_modu	MOVE.L	D1,-(SP)
	BSR.B	comdivide
	MOVE.L	D1,D0
	MOVE.L	(SP)+,D1
	TST.L	D0
	RTS

; D0.L = D0.L / D1.L unsigned
_divu	MOVE.L	D1,-(SP)
	BSR.B	comdivide
	MOVE.L	(SP)+,D1
	TST.L	D0
	RTS

comdivide	MOVEM.L	D2/D3,-(SP)
	SWAP	D1
	TST.W	D1
	BNE.B	.hardldv
	SWAP	D1
	MOVE.W	D1,D3
	MOVE.W	D0,D2
	CLR.W	D0
	SWAP	D0
	DIVU.W	D3,D0
	MOVE.L	D0,D1
	SWAP	D0
	MOVE.W	D2,D1
	DIVU.W	D3,D1
	MOVE.W	D1,D0
	CLR.W	D1
	SWAP	D1
	MOVEM.L	(SP)+,D2/D3
	RTS

.hardldv	SWAP	D1
	MOVE.L	D1,D3
	MOVE.L	D0,D1
	CLR.W	D1
	SWAP	D1
	SWAP	D0
	CLR.W	D0
	MOVEQ	#16-1,D2
.loop	ADD.L	D0,D0
	ADDX.L	D1,D1
	CMP.L	D1,D3
	BHI.B	1$
	SUB.L	D3,D1
	ADDQ.W	#1,D0
1$	DBRA	D2,.loop
	MOVEM.L	(SP)+,D2/D3
	RTS

__strlen	MOVEA.L	(4,SP),A0
	MOVE.L	A0,D0
.loop	TST.B	(A0)+
	BNE.B	.loop
	SUBA.L	D0,A0
	MOVE.L	A0,D0
	SUBQ.L	#1,D0
	RTS

; exit(code)
_exit	LINK.W	A5,#0
	TST.L	(lbL01180E-DT,A4)
	BEQ.B	.dontcls
	MOVEA.L	(lbL01180E-DT,A4),A0
	JSR	(A0)
.dontcls	MOVE.W	(exit_code,A5),-(SP)
	JSR	(__exit,PC)
	ADDQ.W	#2,SP
	UNLK	A5
	RTS

__exit	LINK.W	A5,#-2
	CLR.W	(-2,A5)
lbC00D67A	MOVE.W	(-2,A5),-(SP)
	JSR	(lbC00D726,PC)
	ADDQ.W	#2,SP
	ADDQ.W	#1,(-2,A5)
	CMPI.W	#$14,(-2,A5)
	BLT.B	lbC00D67A
	TST.L	(lbL011812-DT,A4)
	BEQ.B	lbC00D69C
	MOVEA.L	(lbL011812-DT,A4),A0
	JSR	(A0)
lbC00D69C	TST.L	(lbL011B00-DT,A4)
	BEQ.B	lbC00D6AC
	MOVE.L	(lbL011B00-DT,A4),-(SP)
	JSR	(CloseLibrary,PC)
	ADDQ.W	#4,SP
lbC00D6AC	TST.L	(lbL011AFC-DT,A4)
	BEQ.B	lbC00D6BC
	MOVE.L	(lbL011AFC-DT,A4),-(SP)
	JSR	(CloseLibrary,PC)
	ADDQ.W	#4,SP
lbC00D6BC	TST.L	(lbL011B04-DT,A4)
	BEQ.B	lbC00D6CC
	MOVE.L	(lbL011B04-DT,A4),-(SP)
	JSR	(CloseLibrary,PC)
	ADDQ.W	#4,SP
lbC00D6CC
	TST.L	(workbench_message-DT,A4)
	BNE.B	_Forbid
	MOVE.W	(lbW0119EE-DT,A4),D0
	EXT.L	D0
	MOVE.L	D0,-(SP)
	MOVE.L	(lbL011B10-DT,A4),-(SP)
	JSR	(FreeMem,PC)
	ADDQ.W	#8,SP
	MOVE.W	(lbW0119EC-DT,A4),D0
	ADDQ.W	#1,D0
	EXT.L	D0
	ASL.L	#2,D0
	MOVE.L	D0,-(SP)
	MOVE.L	(lbL011B0C-DT,A4),-(SP)
	JSR	(FreeMem,PC)
	ADDQ.W	#8,SP
	MOVE.W	(8,A5),D0
	EXT.L	D0
;;;;	MOVE.L	D0,-(SP)
;;;;	JSR	(Exit,PC)
;;;;	ADDQ.W	#4,SP
	BRA.B	lbC00D722

_Forbid
;;;;	JSR	(Forbid,PC)
;;;;	MOVE.L	(workbench_message-DT,A4),-(SP)
;;;;	JSR	(ReplyMsg,PC)
;;;;	ADDQ.W	#4,SP
	MOVE.L	(8,A5),D0
;;;;	MOVEA.L	(lbL01192E-DT,A4),SP
;;;;	RTS

lbC00D722	UNLK	A5
	RTS

lbC00D726	LINK.W	A5,#0
	MOVEM.L	D4-D6/A2,-(SP)
	MOVE.W	(8,A5),D4
	MOVE.W	D4,D0
	MULS.W	#6,D0
	LEA	(input_handle-DT,A4),A0
	MOVEA.L	D0,A2
	ADDA.L	A0,A2
	TST.W	D4
	BLT.B	lbC00D74E
	CMP.W	#$13,D4
	BGT.B	lbC00D74E
	TST.L	(A2)
	BNE.B	lbC00D75E
lbC00D74E	MOVE.W	#3,(lbW0119E8-DT,A4)
	MOVEQ	#-1,D0
lbC00D756	MOVEM.L	(SP)+,D4-D6/A2
	UNLK	A5
	RTS

lbC00D75E	MOVE.W	(4,A2),D0
	AND.W	#$8000,D0
	BNE.B	lbC00D770
	MOVE.L	(A2),-(SP)
	JSR	(Close,PC)
	ADDQ.W	#4,SP
lbC00D770	CLR.L	(A2)
	MOVEQ	#0,D0
	BRA.B	lbC00D756

Close2	JMP	(Close,PC)

Close	MOVE.L	(4,SP),D1
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOClose,A6)

CurrentDir	MOVE.L	(4,SP),D1
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOCurrentDir,A6)

Delay	MOVE.L	(4,SP),D1
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVODelay,A6)

Exit	MOVE.L	(4,SP),D1
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOExit,A6)

Input	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOInput,A6)

IoErr2	JMP	(IoErr,PC)

IoErr	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOIoErr,A6)

LoadSeg	MOVE.L	(4,SP),D1
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOLoadSeg,A6)

Lock2	JMP	(Lock,PC)

Lock	MOVEM.L	(4,SP),D1/D2
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOLock,A6)

Open2	JMP	(Open,PC)

Open	MOVEM.L	(4,SP),D1/D2
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOOpen,A6)

Output	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOOutput,A6)

Read2	JMP	(Read,PC)

Read	MOVEM.L	(4,SP),D1-D3
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVORead,A6)

Seek2	JMP	(Seek,PC)

Seek	MOVEM.L	(4,SP),D1-D3
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOSeek,A6)

UnLoadSeg	MOVE.L	(4,SP),D1
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOUnLoadSeg,A6)

UnLock2	JMP	(UnLock,PC)

UnLock	MOVE.L	(4,SP),D1
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOUnLock,A6)

Write2	JMP	(Write,PC)

Write	MOVEM.L	(4,SP),D1-D3
	MOVEA.L	(DosBase-DT,A4),A6
	JMP	(_LVOWrite,A6)

Alert	MOVEM.L	D7/A5,-(SP)
	MOVEM.L	(12,SP),D7/A5
	MOVEA.L	(SysBase-DT,A4),A6
	JSR	(_LVOAlert,A6)
	MOVEM.L	(SP)+,D7/A5
	RTS

AvailMem	MOVE.L	(4,SP),D1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOAvailMem,A6)

CheckIO	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOCheckIO,A6)

CloseDevice	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOCloseDevice,A6)

CloseLibrary2	JMP	(CloseLibrary,PC)

CloseLibrary	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOCloseLibrary,A6)

CreateMsgPort	LINK.W	A5,#0
	MOVEM.L	D4/A2,-(SP)
	PEA	(-1).W
	JSR	(AllocSignal,PC)
	ADDQ.W	#4,SP
	MOVE.L	D0,D4
	CMP.L	#$FFFFFFFF,D0
	BNE.B	lbC00D8BA
	MOVEQ	#0,D0
lbC00D8B2	MOVEM.L	(SP)+,D4/A2
	UNLK	A5
	RTS

lbC00D8BA	PEA	((MEMF_PUBLIC|MEMF_CLEAR)).L
	PEA	($22).W
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A2
	TST.L	D0
	BNE.B	lbC00D8DC
	MOVE.L	D4,-(SP)
	JSR	(FreeSignal,PC)
	ADDQ.W	#4,SP
	MOVEQ	#0,D0
	BRA.B	lbC00D8B2

lbC00D8DC	MOVE.L	(8,A5),(10,A2)
	MOVE.B	(15,A5),(9,A2)
	MOVE.B	#4,(8,A2)
	CLR.B	(14,A2)
	MOVE.B	D4,(15,A2)
	CLR.L	-(SP)
	JSR	(_FindTask-DT,A4)
	ADDQ.W	#4,SP
	MOVE.L	D0,($10,A2)
	TST.L	(8,A5)
	BEQ.B	lbC00D912
	MOVE.L	A2,-(SP)
	JSR	(AddPort,PC)
	ADDQ.W	#4,SP
	BRA.B	lbC00D91C

lbC00D912	PEA	($14,A2)
	JSR	(_NewList,PC)
	ADDQ.W	#4,SP
lbC00D91C	MOVE.L	A2,D0
	BRA.B	lbC00D8B2

DeleteMsgPort	LINK.W	A5,#0
	MOVE.L	A2,-(SP)
	MOVEA.L	(8,A5),A2
	TST.L	(10,A2)
	BEQ.B	lbC00D938
	MOVE.L	A2,-(SP)
	JSR	(RemPort,PC)
	ADDQ.W	#4,SP
lbC00D938	MOVE.B	#$FF,(8,A2)
	MOVE.L	#$FFFFFFFF,($14,A2)
	MOVEQ	#0,D0
	MOVE.B	(15,A2),D0
	MOVE.L	D0,-(SP)
	JSR	(FreeSignal,PC)
	ADDQ.W	#4,SP
	PEA	($22).W
	MOVE.L	A2,-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	(SP)+,A2
	UNLK	A5
	RTS

AddPort	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOAddPort,A6)

AllocSignal	MOVE.L	(4,SP),D0
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOAllocSignal,A6)

; CreateStdIO(mp)
_CreateStdIO	LINK.W	A5,#0
	PEA	(IOSTD_SIZE).W
	MOVE.L	(CreateStdIO_mp,A5),-(SP)
	JSR	(_CreateStdIO2-DT,A4)
	ADDQ.W	#8,SP
	UNLK	A5
	RTS

; DeleteStdIO(iop)
_DeleteStdIO	LINK.W	A5,#0
	MOVE.L	(DeleteStdIO_iop,A5),-(SP)
	JSR	(_DeleteStdIO2-DT,A4)
	ADDQ.W	#4,SP
	UNLK	A5
	RTS

CreateStdIO	LINK.W	A5,#0
	MOVE.L	A2,-(SP)
	TST.L	(8,A5)
	BNE.B	lbC00D9BA
	MOVEQ	#0,D0
lbC00D9B4	MOVEA.L	(SP)+,A2
	UNLK	A5
	RTS

lbC00D9BA	PEA	((MEMF_PUBLIC|MEMF_CLEAR)).L
	MOVE.L	(12,A5),-(SP)
	JSR	(_AllocMem-DT,A4)
	ADDQ.W	#8,SP
	MOVEA.L	D0,A2
	TST.L	D0
	BNE.B	lbC00D9D4
	MOVEQ	#0,D0
	BRA.B	lbC00D9B4

lbC00D9D4	MOVE.B	#5,(8,A2)
	MOVE.W	(14,A5),($12,A2)
	MOVE.L	(8,A5),(14,A2)
	MOVE.L	A2,D0
	BRA.B	lbC00D9B4

DeleteStdIO	LINK.W	A5,#0
	MOVE.L	A2,-(SP)
	MOVEA.L	(8,A5),A2
	MOVE.L	A2,D0
	BNE.B	lbC00D9FE
lbC00D9F8	MOVEA.L	(SP)+,A2
	UNLK	A5
	RTS

lbC00D9FE	MOVE.B	#$FF,(8,A2)
	MOVE.L	#$FFFFFFFF,($14,A2)
	MOVE.L	#$FFFFFFFF,($18,A2)
	MOVEQ	#0,D0
	MOVE.W	($12,A2),D0
	MOVE.L	D0,-(SP)
	MOVE.L	A2,-(SP)
	JSR	(_FreeMem-DT,A4)
	ADDQ.W	#8,SP
	BRA.B	lbC00D9F8

AllocMem2	JMP	(AllocMem,PC)

AllocMem	MOVEM.L	(4,SP),D0/D1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOAllocMem,A6)

DoIO	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVODoIO,A6)

FindTask2	JMP	(FindTask,PC)

FindTask	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOFindTask,A6)

Forbid	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOForbid,A6)

FreeMem2	JMP	(FreeMem,PC)

FreeMem	MOVEA.L	(4,SP),A1
	MOVE.L	(8,SP),D0
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOFreeMem,A6)

FreeSignal	MOVE.L	(4,SP),D0
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOFreeSignal,A6)

GetMsg	MOVEA.L	(4,SP),A0
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOGetMsg,A6)

; Prepare a list structure for use
; NewList(list*)
_NewList	MOVEA.L	(4,SP),A0
	MOVE.L	A0,(LH_HEAD,A0)
	ADDQ.L	#LH_TAIL,(A0)
	CLR.L	(LH_TAIL,A0)
	MOVE.L	A0,(LH_TAILPRED,A0)
	RTS

OpenDevice	MOVEA.L	(4,SP),A0
	MOVEM.L	(8,SP),D0/A1
	MOVE.L	($10,SP),D1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOOpenDevice,A6)

OpenLibrary2	JMP	(OpenLibrary,PC)

OpenLibrary	MOVEA.L	(SysBase-DT,A4),A6
	MOVEA.L	(4,SP),A1
	MOVE.L	(8,SP),D0
	JMP	(_LVOOpenLibrary,A6)

RemPort	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVORemPort,A6)

ReplyMsg	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOReplyMsg,A6)

SendIO	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOSendIO,A6)

WaitIO	MOVEA.L	(4,SP),A1
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOWaitIO,A6)

WaitPort	MOVEA.L	(4,SP),A0
	MOVEA.L	(SysBase-DT,A4),A6
	JMP	(_LVOWaitPort,A6)

AllocRaster	MOVEM.L	(4,SP),D0/D1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOAllocRaster,A6)

AreaDraw	MOVEA.L	(4,SP),A1
	MOVEM.L	(8,SP),D0/D1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOAreaDraw,A6)

AreaEnd	MOVEA.L	(4,SP),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOAreaEnd,A6)

AreaMove	MOVEA.L	(4,SP),A1
	MOVEM.L	(8,SP),D0/D1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOAreaMove,A6)

BltBitMap	MOVEM.L	D4-D7/A2,-(SP)
	MOVEA.L	($18,SP),A0
	MOVEM.L	($1C,SP),D0/D1/A1
	MOVEM.L	($28,SP),D2-D7/A2
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOBltBitMap,A6)
	MOVEM.L	(SP)+,D4-D7/A2
	RTS

ChangeSprite	MOVE.L	A2,-(SP)
	MOVEM.L	(8,SP),A0-A2
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOChangeSprite,A6)
	MOVEA.L	(SP)+,A2
	RTS

DisownBlitter	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVODisownBlitter,A6)

FreeColorMap	MOVEA.L	(4,SP),A0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOFreeColorMap,A6)

FreeCprList	MOVEA.L	(4,SP),A0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOFreeCprList,A6)

FreeRaster	MOVEA.L	(4,SP),A0
	MOVEM.L	(8,SP),D0/D1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOFreeRaster,A6)

FreeSprite	MOVE.L	(4,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOFreeSprite,A6)

FreeVPortCopLists	MOVEA.L	(4,SP),A0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOFreeVPortCopLists,A6)

GetColorMap	MOVE.L	(4,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOGetColorMap,A6)

GetSprite	MOVEA.L	(4,SP),A0
	MOVE.L	(8,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOGetSprite,A6)

InitArea	MOVEM.L	(4,SP),A0/A1
	MOVE.L	(12,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOInitArea,A6)

InitBitMap	MOVEA.L	(4,SP),A0
	MOVEM.L	(8,SP),D0-D2
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOInitBitMap,A6)

InitRastPort	MOVEA.L	(4,SP),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOInitRastPort,A6)

InitTmpRas	MOVEM.L	(4,SP),A0/A1
	MOVE.L	(12,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOInitTmpRas,A6)

InitView	MOVEA.L	(4,SP),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOInitView,A6)

InitVPort	MOVEA.L	(4,SP),A0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOInitVPort,A6)

LoadRGB4	MOVEM.L	(4,SP),A0/A1
	MOVE.L	(12,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOLoadRGB4,A6)

LoadView	MOVEA.L	(4,SP),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOLoadView,A6)

MakeVPort	MOVEM.L	(4,SP),A0/A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOMakeVPort,A6)

Move	MOVEA.L	(4,SP),A1
	MOVEM.L	(8,SP),D0/D1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOMove,A6)

MrgCop	MOVEA.L	(4,SP),A1
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOMrgCop,A6)

OwnBlitter	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOOwnBlitter,A6)

RectFill	MOVEA.L	(4,SP),A1
	MOVEM.L	(8,SP),D0-D3
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVORectFill,A6)

ScrollRaster	MOVEM.L	D4/D5,-(SP)
	MOVEA.L	(12,SP),A1
	MOVEM.L	($10,SP),D0-D5
	MOVEA.L	(_GfxBase-DT,A4),A6
	JSR	(_LVOScrollRaster,A6)
	MOVEM.L	(SP)+,D4/D5
	RTS

SetAPen	MOVEA.L	(4,SP),A1
	MOVE.L	(8,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOSetAPen,A6)

SetBPen	MOVEA.L	(4,SP),A1
	MOVE.L	(8,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOSetBPen,A6)

SetDrMd	MOVEA.L	(4,SP),A1
	MOVE.L	(8,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOSetDrMd,A6)

SetFont	MOVEA.L	(4,SP),A1
	MOVEA.L	(8,SP),A0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOSetFont,A6)

SetRast	MOVEA.L	(4,SP),A1
	MOVE.L	(8,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOSetRast,A6)

SetRGB4	MOVEA.L	(4,SP),A0
	MOVEM.L	(8,SP),D0-D3
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOSetRGB4,A6)

Text	MOVEA.L	(4,SP),A1
	MOVEA.L	(8,SP),A0
	MOVE.L	(12,SP),D0
	MOVEA.L	(_GfxBase-DT,A4),A6
	MOVE.L	D7,-(SP)
	JSR	(_LVOText,A6)
	MOVE.L	(SP)+,D7
	RTS

WaitBlit	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOWaitBlit,A6)

WaitBOVP	MOVEA.L	(4,SP),A0
	MOVEA.L	(_GfxBase-DT,A4),A6
	JMP	(_LVOWaitBOVP,A6)

CreateUpfrontLayer	MOVEM.L	D4/A2,-(SP)
	MOVEM.L	(12,SP),A0/A1
	MOVEM.L	($14,SP),D0-D4/A2
	MOVEA.L	(LayersBase-DT,A4),A6
	JSR	(_LVOCreateUpfrontLayer,A6)
	MOVEM.L	(SP)+,D4/A2
	RTS

DeleteLayer	MOVEM.L	(4,SP),A0/A1
	MOVEA.L	(LayersBase-DT,A4),A6
	JMP	(_LVODeleteLayer,A6)

DisposeLayerInfo	MOVEA.L	(LayersBase-DT,A4),A6
	MOVEA.L	(4,SP),A0
	JMP	(_LVODisposeLayerInfo,A6)

NewLayerInfo	MOVEA.L	(LayersBase-DT,A4),A6
	JMP	(_LVONewLayerInfo,A6)


	SECTION	fmainrs00DD84,DATA,CHIP
DT	EQU	*+$7FFE
	JMP	(_PROGSTART).L

_main	JMP	(main).L

_my_trap_code	JMP	(my_trap_code).L

_input_handler	JMP	(input_handler).L

_get_key_perhaps	JMP	(get_key_perhaps).L

lbC00DDA2	JMP	(lbC0084EE).L

lbC00DDA8	JMP	(lbC008506).L

lbC00DDAE	JMP	(lbC00850E).L

lbC00DDB4	JMP	(lbC008518).L

lbC00DDBA	JMP	(lbC008522).L

lbC00DDC0	JMP	(lbC00852C).L

lbC00DDC6	JMP	(lbC008536).L

lbC00DDCC	JMP	(lbC008540).L

lbC00DDD2	JMP	(lbC008554).L

lbC00DDD8	JMP	(lbC0085D0).L

lbC00DDDE	JMP	(lbC0086D4).L

lbC00DDE4	JMP	(lbC008728).L

lbC00DDEA	JMP	(lbC008812).L

lbC00DDF0	JMP	(lbC008948).L

lbC00DDF6	JMP	(lbC0089A2).L

lbC00DDFC	JMP	(lbC008A4A).L

lbC00DE02	JMP	(lbC008B9C).L

lbC00DE08	JMP	(lbC008BEC).L

lbC00DE0E	JMP	(lbC008C58).L

lbC00DE14	JMP	(lbC008D98).L

lbC00DE1A	JMP	(lbC008DC2).L

lbC00DE20	JMP	(lbC008DF4).L

lbC00DE26	JMP	(lbC008E0A).L

lbC00DE2C	JMP	(lbC008EAA).L

lbC00DE32	JMP	(lbC008F42).L

_do_blit_1	JMP	(do_blit_1).L

lbC00DE3E	JMP	(lbC009176).L

_do_blit_2	JMP	(do_blit_2).L

_do_blit_3	JMP	(do_blit_3).L

_do_blit_4	JMP	(do_blit_4).L

_do_blit	JMP	(do_blit_5).L

lbC00DE5C	JMP	(lbC0094C6).L

lbC00DE62	JMP	(lbC009BCA).L

lbC00DE68	JMP	(lbC009CA8).L

lbC00DE6E	JMP	(lbC009E4E).L

lbC00DE74	JMP	(lbC009F76).L

lbC00DE7A	JMP	(lbC00A0A2).L

lbC00DE80	JMP	(lbC00A116).L

lbC00DE86	JMP	(lbC00A33C).L

lbC00DE8C	JMP	(lbC00A542).L

lbC00DE92	JMP	(lbC00A59E).L

lbC00DE98	JMP	(lbC00A844).L

_log_message	JMP	(lbC00A872).L

lbC00DEA4	JMP	(lbC00A8CC).L

lbC00DEAA	JMP	(lbC00A8F6).L

lbC00DEB0	JMP	(lbC00A9FC).L

lbC00DEB6	JMP	(lbC00AA06).L

lbC00DEBC	JMP	(lbC00AA10).L

lbC00DEC2	JMP	(lbC00AA2A).L

lbC00DEC8	JMP	(lbC00AA7E).L

lbC00DECE	JMP	(lbC00AADA).L

lbC00DED4	JMP	(lbC00AB44).L

lbC00DEDA	JMP	(lbC00AB66).L

lbC00DEE0	JMP	(lbC00AB98).L

lbC00DEE6	JMP	(lbC00ABCE).L

_trackdisk_read_3	JMP	(trackdisk_read_3).L

_trackdisk_read_2	JMP	(trackdisk_read_2).L

;_trackdisk_read	JMP	(trackdisk_read).L
;
;_trackdisk_motor_off
;	JMP	(trackdisk_motor_off).L

lbC00DF04	JMP	(lbC00AEA6).L

_wait_for_trackdisk_8
	JMP	(wait_for_trackdisk_8).L

_check_for_trackdisk_and_read_tracks
	JMP	(check_for_trackdisk_and_read_tracks).L

_read_songs_file	JMP	(read_songs_file).L

_display_brother	JMP	(display_brother).L

lbC00DF22	JMP	(lbC00B350).L

_malloc_maybe	JMP	(malloc_maybe).L

lbC00DF2E	JMP	(lbC00B3B8).L

lbC00DF34	JMP	(lbC00B6FA).L

lbC00DF3A	JMP	(lbC00B75C).L

lbC00DF40	JMP	(lbC00B79E).L

lbC00DF46	JMP	(lbC00BCD2).L

lbC00DF4C	JMP	(lbC00BF1E).L

lbC00DF52	JMP	(lbC00C214).L

lbC00DF58	JMP	(lbC00C262).L

lbC00DF5E	JMP	(lbC00C2BC).L

lbC00DF64	JMP	(lbC00C3E4).L

lbC00DF6A	JMP	(lbC00C560).L

lbC00DF70	JMP	(lbC00C572).L

lbC00DF76	JMP	(lbC00C5FC).L

lbC00DF7C	JMP	(lbC00C8B0).L

lbC00DF82	JMP	(lbC00C8E6).L

lbC00DF88	JMP	(lbC00C95E).L

_start_note	JMP	(start_aud_note).L

lbC00DF94	JMP	(lbC00CFF6).L

_init_aud_2	JMP	(start_aud_play).L

_silence_audio	JMP	(silence_audio).L

_install_aud_handlers
	JMP	(install_aud_handlers).L

_remove_aud_handlers
	JMP	(remove_aud_handlers).L

	JMP	(ProgramStart).L

__mulu	JMP	(_mulu).L

__divs	JMP	(_divs).L

__mods	JMP	(_mods).L

__modu	JMP	(_modu).L

__divu	JMP	(_divu).L

_Close	JMP	(Close2).L

_Delay	JMP	(Delay).L

_LoadSeg	JMP	(LoadSeg).L

_Open	JMP	(Open2).L

_Read	JMP	(Read2).L

_Seek	JMP	(Seek2).L

_UnLoadSeg	JMP	(UnLoadSeg).L

_CheckIO	JMP	(CheckIO).L

_CloseDevice	JMP	(CloseDevice).L

_CloseLibrary	JMP	(CloseLibrary2).L

_CreateMsgPort	JMP	(CreateMsgPort).L

_DeleteMsgPort	JMP	(DeleteMsgPort).L

__CreateStdIO	JMP	(_CreateStdIO).L

__DeleteStdIO	JMP	(_DeleteStdIO).L

_CreateStdIO2	JMP	(CreateStdIO).L

_DeleteStdIO2	JMP	(DeleteStdIO).L

_AllocMem	JMP	(AllocMem2).L

_DoIO	JMP	(DoIO).L

_FindTask	JMP	(FindTask2).L

_FreeMem	JMP	(FreeMem2).L

_OpenDevice	JMP	(OpenDevice).L

_OpenLibrary	JMP	(OpenLibrary2).L

_WaitIO	JMP	(WaitIO).L

_AllocRaster	JMP	(AllocRaster).L

_BltBitMap	JMP	(BltBitMap).L

_ChangeSprite	JMP	(ChangeSprite).L

_DisownBlitter	JMP	(DisownBlitter).L

_FreeColorMap	JMP	(FreeColorMap).L

_FreeCprList	JMP	(FreeCprList).L

_FreeRaster	JMP	(FreeRaster).L

_FreeSprite	JMP	(FreeSprite).L

_FreeVPortCopLists	JMP	(FreeVPortCopLists).L

_GetColorMap	JMP	(GetColorMap).L

_GetSprite	JMP	(GetSprite).L

_InitBitMap	JMP	(InitBitMap).L

_InitRastPort	JMP	(InitRastPort).L

_InitView	JMP	(InitView).L

_InitVPort	JMP	(InitVPort).L

_LoadRGB4	JMP	(LoadRGB4).L

_LoadView	JMP	(LoadView).L

_MakeVPort	JMP	(MakeVPort).L

_Move	JMP	(Move).L

_MrgCop	JMP	(MrgCop).L

_OwnBlitter	JMP	(OwnBlitter).L

_RectFill	JMP	(RectFill).L

_SetAPen	JMP	(SetAPen).L

_SetBPen	JMP	(SetBPen).L

_SetDrMd	JMP	(SetDrMd).L

_SetFont	JMP	(SetFont).L

_SetRast	JMP	(SetRast).L

_SetRGB4	JMP	(SetRGB4).L

_Text	JMP	(Text).L

_WaitBlit	JMP	(WaitBlit).L

_WaitBOVP	JMP	(WaitBOVP).L

_DisposeLayerInfo	JMP	(DisposeLayerInfo).L

_NewLayerInfo	JMP	(NewLayerInfo).L

	dw	0
ascii.MSG15	db	13
lbB00E129	db	0
lbL00E12A	dl	$1000D04
	dl	$1000E00
	dl	$E01
	dl	$E02
	dl	$E04
	dl	$1000E06
	dl	$E07
	dl	$F00
	dl	$1000
	dl	$1006
	dl	$1007
	dl	$1100
	dl	$1001104
	dw	$100
lbW00E160	dw	$1201
lbB00E162	db	2
lbB00E163	db	0
lbB00E164	db	2
lbB00E165	db	6
	dl	$C010401
	dl	$1061001
	dl	$6010407
	dl	$8010300
	dl	$3071001
	dl	$6010008
	dl	$9010300
	dl	$70A01
	dl	$6010008
	dl	$28010701
	dl	$80C01
	dl	$6010009
	dl	$32010500
	dl	$90400
	dl	9
lbL00E1A2	dl	$1080001
	dl	$2000100
	dl	$3010208
	dl	$4020307
	dl	$5030406
	dl	$6040505
	dl	$8050604
	dl	$8060703
	dl	$60802
lbB00E1C6	db	0
lbB00E1C7	db	11
lbB00E1C8	db	$FE
lbB00E1C9	db	11
	dl	$10BFD0B
	dl	$20BFD0A
	dl	$30BFD09
	dl	$40BFD0A
	dl	$50BFD0B
	dl	$60BFE0B
	dl	$70BFF0B
	dl	$809F40B
	dl	$909F50C
	dl	$A09F80D
	dl	$B09FC0D
	dl	$C09000D
	dl	$D09FC0D
	dl	$E09F80D
	dl	$F09F50C
	dl	$100EFF01
	dl	$110EFF02
	dl	$120EFF03
	dl	$130EFF04
	dl	$140EFF03
	dl	$150EFF02
	dl	$160EFF01
	dl	$170EFF01
	dl	$180A050C
	dl	$190A030C
	dl	$1A0A020C
	dl	$1B0A030C
	dl	$1C0A050C
	dl	$1D0A060C
	dl	$1E0A060B
	dl	$1F0A060C
	dl	$200BFE0C
	dl	$200A000C
	dl	$2100020A
	dl	$22010406
	dl	$22020104
	dl	$22030004
	dl	$2404FB00
	dl	$2405F601
	dl	$230CFB05
	dl	$24000006
	dl	$2655FA05
	dl	$2551FA05
	dl	$2809F90C
	dl	$2808F709
	dl	$2907F605
	dl	$2A07F404
	dl	$2A06F403
	dl	$2A05F403
	dl	$2C05F803
	dl	$2C0EF906
	dl	$2B0DF908
	dl	$2A05F403
	dl	$2E56FD00
	dl	$2D52FD00
	dl	$300EFD00
	dl	$3006FDFF
	dl	$3105FEFD
	dl	$3205FDFC
	dl	$32040000
	dl	$32030300
	dl	$34040601
	dl	$340F0703
	dl	$330E0106
	dl	$32040000
	dl	$36570300
	dl	$35530300
	dl	$380A050B
	dl	$38000609
	dl	$39010A06
	dl	$3A010A05
	dl	$3A020703
	dl	$3A030603
	dl	$3C040100
	dl	$3C030302
	dl	$3B0F0401
	dl	$3A040501
	dl	$3E540300
	dl	$3D500300
	dl	$2F00050B
	dl	$3F000609
	dl	$27000609
	dl	$370A050B
	dl	$400A050B
	dl	$410A050B
	dl	$420A050B
lbL00E322	dl	$11705060
	dl	$28708B60
	dl	$1011170
	dl	$50602870
	dl	$8B600101
	dl	$11705060
	dl	$28708B60
	dl	$1011170
	dl	$50602870
	dl	$8B600101
	dl	$13901B60
	dl	$19808C60
	dl	$12021770
	dl	$6AA02270
	dl	$96A00901
	dl	$197062A0
	dl	$1F7096A0
	dl	$9011AA0
	dl	$4BA013A0
	dl	$95A01101
	dl	$1AA04C60
	dl	$13A09760
	dl	$11011B20
	dl	$4B601720
	dl	$95601101
	dl	$1B804B80
	dl	$15809580
	dl	$11011B80
	dl	$4C401580
	dl	$97401101
	dl	$1E703B60
	dl	$28809C60
	dl	$3012480
	dl	$33A02E80
	dl	$8DA00101
	dl	$29608760
	dl	$2B0092C0
	dl	$F012B00
	dl	$92C02960
	dl	$87800F02
	dl	$2C007160
	dl	$2AF09360
	dl	$9012F70
	dl	$2E603180
	dl	$9A600301
	dl	$2F7063A0
	dl	$1C7096A0
	dl	$9013180
	dl	$38C02780
	dl	$98C00101
	dl	$34704B60
	dl	$4708EE0
	dl	$F023DE0
	dl	$1BC02EE0
	dl	$93C00701
	dl	$3E001BC0
	dl	$2F0093C0
	dl	$7014270
	dl	$25602E80
	dl	$9A600301
	dl	$42803BC0
	dl	$298098C0
	dl	$10145E0
	dl	$538025D0
	dl	$96800A01
	dl	$47802FC0
	dl	$258098C0
	dl	$1014860
	dl	$66401C60
	dl	$9A401201
	dl	$489066A0
	dl	$1C909AA0
	dl	$B014960
	dl	$5B402260
	dl	$9A401201
	dl	$49905BA0
	dl	$22909AA0
	dl	$B0149A0
	dl	$3CC00BA0
	dl	$82C00201
	dl	$49D03DC0
	dl	$BD084C0
	dl	$20149D0
	dl	$3E000BD0
	dl	$85000201
	dl	$4A103C80
	dl	$D108280
	dl	$1014A10
	dl	$3D400F10
	dl	$83400101
	dl	$4A303DC0
	dl	$E3085C0
	dl	$1014A60
	dl	$3E801060
	dl	$85800101
	dl	$4A703C80
	dl	$13708280
	dl	$1014A80
	dl	$3D401190
	dl	$83400101
	dl	$4C703260
	dl	$25809C60
	dl	$3014D60
	dl	$54401F60
	dl	$9C401201
	dl	$4D904380
	dl	$30808D80
	dl	$D014D90
	dl	$54A01F90
	dl	$9CA00B01
	dl	$4DE06B80
	dl	$29D09680
	dl	$A015360
	dl	$58402260
	dl	$98401201
	dl	$539058A0
	dl	$229098A0
	dl	$B015460
	dl	$45401C60
	dl	$98401201
	dl	$54706480
	dl	$2C808D80
	dl	$3015490
	dl	$45A01C90
	dl	$98A00B01
	dl	$55F052E0
	dl	$16E083E0
	dl	$A0156C0
	dl	$53C01BC0
	dl	$84C00D01
	dl	$56C05440
	dl	$19C08540
	dl	$D0156F0
	dl	$51A019F0
	dl	$82A00D01
	dl	$57005240
	dl	$1DF08340
	dl	$E015710
	dl	$54401C10
	dl	$86400D01
	dl	$57305300
	dl	$1A508400
	dl	$D015730
	dl	$53801C30
	dl	$84800E01
	dl	$575051A0
	dl	$1C6082A0
	dl	$D015750
	dl	$52602050
	dl	$83600D01
	dl	$576053C0
	dl	$206084C0
	dl	$D015760
	dl	$54401E60
	dl	$85400D01
	dl	$58605D40
	dl	$1C609A40
	dl	$12015890
	dl	$5DA01C90
	dl	$9CA00B01
	dl	$58C02E60
	dl	$AC08860
	dl	$12025960
	dl	$6F402260
	dl	$9A401201
	dl	$59906FA0
	dl	$22909CA0
	dl	$B0159A0
	dl	$67602AA0
	dl	$8B600F01
	dl	$59E05880
	dl	$27D09680
	dl	$A015E70
	dl	$1A602580
	dl	$9A600301
	dl	$5EC02960
	dl	$11C08B60
	dl	$12026060
	dl	$72401960
	dl	$9C401201
	dl	$609072A0
	dl	$19909CA0
	dl	$B0160F0
	dl	$32C025F0
	dl	$8BC00301
	dl	$64C01860
	dl	$3C08660
	dl	$12026560
	dl	$5D401F60
	dl	$9A401201
	dl	$65905DA0
	dl	$1F9098A0
	dl	$B0165C0
	dl	$1A2004B0
	dl	$88400902
	dl	$66702A60
	dl	$2B809A60
	dl	$3016800
	dl	$1B602AF0
	dl	$90600901
	dl	$6B504380
	dl	$28508D80
	dl	$D016BE0
	dl	$7C802BD0
	dl	$96800A01
	dl	$6C702E60
	dl	$28809A60
	dl	$3016D60
	dl	$68401F60
	dl	$9A401201
	dl	$6D9068A0
	dl	$1F909AA0
	dl	$B016EE0
	dl	$528031D0
	dl	$96800A01
lbW00E67E	dw	$846
lbL00E680	dl	$6A650A3A
	dl	$6BF54600
	dl	$10B0000
	dl	0
	dl	$4600
	dl	$1051A5D
	dl	$88871C51
	dl	$8A174600
	dl	$10A0FDF
	dl	$8803132D
	dl	$89353504
	dl	$106255B
	dl	$845B27A0
	dl	$869E3C01
	dl	$10959A1
	dl	$15DD5AB9
	dl	$16733D03
	dl	$2042A44
	dl	$8B3E2A7D
	dl	$8B565301
	dl	$1004C8C
	dl	$42E34E06
	dl	$43F93008
	dl	$8024BC8
	dl	$428A4F10
	dl	$444C5004
	dl	$14002400
	dl	$82003100
	dl	$8A003403
	dl	$1081498
	dl	$821417E0
	dl	$85985100
	dl	$1002DC0
	dl	$91E63080
	dl	$94845200
	dl	$1000AC0
	dl	$821421B8
	dl	$8A485000
	dl	$1002730
	dl	$8ADE32B0
	dl	$9D4E5000
	dl	$1001268
	dl	$94D42730
	dl	$9D9E5000
	dl	$100539D
	dl	$63EF5543
	dl	$65AC3C01
	dl	$107180C
	dl	$31D3301C
	dl	$3E210701
	dl	$8001414
	dl	$882C1874
	dl	$918C0801
	dl	$8000294
	dl	$82E6080C
	dl	$87000801
	dl	$80048FF
	dl	$3BEA4B0B
	dl	$3F085000
	dl	$1004239
	dl	$491F4F10
	dl	$444C0301
	dl	$3005071
	dl	$491F5A49
	dl	$58F10301
	dl	$3000000
	dl	$7FFF
	dl	$9FFF0301
	dw	$800
lbB00E792	db	$36
lbB00E793	db	$2B
	db	$47
	db	$4D
	db	$4E
	db	$66
	db	$42
	db	$79
	db	12
	db	$55
	db	$4F
	db	$28
	db	$6B
	db	$26
	db	$49
	db	$15
	db	12
	db	$1A
	db	$1A
	db	$35
	db	$54
	db	$3C
ascii.MSG12	db	12
lbB00E7A9	db	10
lbB00E7AA	db	0
lbB00E7AB	db	0
lbB00E7AC	db	0
lbB00E7AD	db	8
lbW00E7AE	dw	$100
lbL00E7B0	dl	Dirk.MSG
	dl	$90A0A00
	dl	$80100
	dl	Mace.MSG
	dl	$80A1400
	dl	$80100
	dl	Sword.MSG
	dl	$A0A1E00
	dl	$80100
	dl	Bow.MSG
	dl	$110A2800
	dl	$8080100
	dl	MagicWand.MSG
	dl	$1B0A3200
	dl	$80100
	dl	GoldenLasso.MSG
	dl	$170A3C00
	dl	$8080100
	dl	SeaShell.MSG
	dl	$1B0A4600
	dl	$8080100
	dl	SunStone.MSG
	dl	$31E0003
	dl	$7012D00
	dl	Arrows.MSG
	dl	$12320009
	dl	$80F00
	dl	BlueStone.MSG
	dl	$13410006
	dl	$51700
	dl	GreenJewel.MSG
	dl	$16500008
	dl	$71100
	dl	GlassVial.MSG
	dl	$155F0007
	dl	$61400
	dl	CrystalOrb.MSG
	dl	$176E000A
	dl	$90E00
	dl	BirdTotem.MSG
	dl	$117D0006
	dl	$51700
	dl	GoldRing.MSG
	dl	$188C000A
	dl	$90E00
	dl	JadeSkull.MSG
	dl	$19A00005
	dl	$51900
	dl	GoldKey.MSG
	dl	$19AC0005
	dl	$8051900
	dl	GreenKey.MSG
	dl	$72B80005
	dl	$51900
	dl	BlueKey.MSG
	dl	$72C40005
	dl	$8051900
	dl	RedKey.MSG
	dl	$1AD00005
	dl	$51900
	dl	GreyKey.MSG
	dl	$1ADC0005
	dl	$8051900
	dl	WhiteKey.MSG
	dl	$B005000
	dl	$8080100
	dl	Talisman.MSG
	dl	$13005A00
	dl	$8080100
	dl	Rose.MSG
	dl	$14006400
	dl	$8080100
	dl	Fruit.MSG
	dl	$15E8000A
	dl	$8080500
	dl	GoldStatue.MSG
	dl	$16006E00
	dl	$8080100
	dl	Book.MSG
	dl	$80E5000
	dl	$8080100
	dl	Herb.MSG
	dl	$90E5A00
	dl	$8080100
	dl	Writ.MSG
	dl	$A0E6400
	dl	$8080100
	dl	Bone.MSG
	dl	$C0E6E00
	dl	$8080100
	dl	Shard.MSG
	dl	0
	dl	$200
	dl	GoldPieces.MSG
	dl	0
	dl	$500
	dl	GoldPieces.MSG0
	dl	0
	dl	$A00
	dl	GoldPieces.MSG1
	dl	0
	dl	$6400
	dl	GoldPieces.MSG2
	dl	0
	dl	0
	dl	quiverofarrow.MSG
simplesprite	dl	0	;posctldata
	dw	$10	;height
	dw	0	;x
	dw	0	;y
	dw	1	;sprite num
lbL00E964	dl	0
	dl	$80060000
	dl	$60010002
	dl	$40012000
	dl	$10030000
	dl	$8FE0001
	dl	$581007F
	dl	$3000081
	dl	$6010101
	dl	$C800201
	dl	$8410401
	dl	$8200401
	dl	$8110401
	dl	$80C0401
	dl	$880F0401
	dl	$98074400
	dl	$75560FFC
	dl	0
	dl	0
	dl	0
lbL00E9B4	dl	$FFF
	dl	$C000F60
	dl	$F0C0F
	dl	$900FF0
	dl	$F900F0C
	dl	$A500FDB
	dl	$EB70CCC
	dl	$8880444
	dl	$DB0
	dl	$7400C70
colormap2	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
lbL00EA1C	dl	$FFF
	dl	$E000A00
	dl	$D800EC0
	dl	$3900021
	dl	$EEB0EDA
	dl	$EEA0CB8
	dl	$A950973
	dl	$8400620
	dl	$A520C74
	dl	$D960FCA
	dl	$4490444
	dl	$DC90668
	dl	$33F0888
	dl	$A600AAF
	dl	$BBB0CCF
	dl	$DDD0EEE
lbL00EA5C	dl	0
	dl	0
	dw	0
	db	$20
ItemsMagicTal.MSG	db	'ItemsMagicTalk Buy  Game ',0
ListTakeLookU.MSG	db	'List Take Look Use  Give ',0
YellSayAsk.MSG	db	'Yell Say  Ask  ',0
PauseMusicSou.MSG	db	'PauseMusicSoundQuit Load ',0
FoodArrowVial.MSG	db	'Food ArrowVial Mace SwordBow  Totem',0
StoneJewelVia.MSG	db	'StoneJewelVial Orb  TotemRing Skull',0
DirkMaceSword.MSG	db	'Dirk Mace SwordBow  Wand LassoShellKey  Sun  Book ',0
SaveExit.MSG	db	'Save Exit ',0
GoldGreenBlue.MSG	db	'Gold GreenBlue Red  Grey White',0
GoldBookWritB.MSG	db	'Gold Book Writ Bone ',0
ABCDEFGH.MSG	db	'  A    B    C    D    E    F    G   '
H.MSG	db	' H  ',0
	db	8
	db	6
	db	4
	db	2
	db	14
	db	1
lbL00EBAE	dl	ListTakeLookU.MSG
ascii.MSG11	db	10
lbB00EBB3	db	6
lbL00EBB4	dl	$3020202
	dl	$20A0A0A
	dl	$A0A0000
	dl	StoneJewelVia.MSG
	dl	$C050203
	dw	$202
	db	2
ascii.MSG18	db	8
	db	8
	db	8
	db	8
	db	8
	db	8
	db	8
	dl	YellSayAsk.MSG
	db	8
	db	9
	db	2
	db	2
	db	3
	db	2
	db	2
	db	10
	db	10
	db	10
	db	0
	db	0
	db	0
	db	0
	dl	FoodArrowVial.MSG
	db	12
	db	10
	db	2
	db	2
	db	2
	db	3
	db	2
	db	10
	db	10
	db	10
	db	10
	db	10
	db	10
	db	10
	dl	PauseMusicSou.MSG
	db	10
	db	2
	db	2
	db	2
	db	2
	db	2
	db	3
lbB00EC01	db	6
lbB00EC02	db	7
lbB00EC03	db	7
	db	10
	db	10
	db	0
	db	0
	dl	SaveExit.MSG
	db	7
	db	0
	db	2
	db	2
	db	2
	db	2
	db	2
	db	10
	db	10
	db	0
	db	0
	db	0
	db	0
	db	0
	dl	GoldGreenBlue.MSG
	db	11
	db	8
	db	2
	db	2
	db	2
	db	2
	db	2
ascii.MSG14	db	10
	db	10
	db	10
	db	10
	db	10
	db	10
	db	0
	dl	GoldBookWritB.MSG
	db	9
	db	10
	db	2
	db	2
	db	2
	db	2
	db	2
lbB00EC37	db	10
lbB00EC38	db	0
lbB00EC39	db	0
lbB00EC3A	db	0
	db	0
	db	0
	db	0
	dl	DirkMaceSword.MSG
	db	10
	db	8
ascii.MSG13	db	10
	db	10
	db	10
	db	10
	db	10
	db	10
	db	10
lbB00EC4B	db	10
lbB00EC4C	db	10
	db	0
	db	10
	db	10
	dl	ABCDEFGH.MSG
	db	10
	db	5
	db	10
	db	10
	db	10
	db	10
	db	10
	db	10
	db	10
	db	10
	db	0
	db	0
	db	0
	db	0
I.MSG	db	'I'
lbB00EC63	db	0
lbL00EC64	dl	$5005400
	dl	$6003F00
	dl	$7005500
	dl	$8004700
	dl	$9005902
	dl	$5005302
	dl	$6004102
	dl	$7002004
	dl	$5004D04
	dl	$6004604
	dl	$7005104
	dl	$8004C04
	dl	$9004F03
	dl	$5005203
	dl	$6003803
	dl	$7004303
	dl	$8005703
	dl	$9004203
	dl	$A004503
	dl	$B005605
	dl	$5005805
	dl	$6000A01
	dl	$5000B01
	dl	$6000C01
	dl	$7000D01
	dl	$8000E01
	dl	$9000F01
	dl	$A001001
	dl	$B003108
	dl	$3208
	dl	$1003308
	dl	$2003408
	dl	$3003508
	dl	$4003608
	dl	$5003708
	dl	$6004B08
	dw	$700
lbL00ECF6	dl	Julian.MSG
	dl	Phillip.MSG
	dl	Kevin.MSG
lbW00ED02	dw	3
lbB00ED03	EQU	*-1
lbL00ED04	dl	0
	dl	0
lbW00ED0C	dw	1
lbW00ED0E	dw	2
lbW00ED10	dw	0
lbW00ED12	dw	0
	dw	0
lbL00ED16	dl	$14001E0
	dl	$2080230
	dl	1
	dl	$2000A0
	dl	$160140
	dl	$1680190
	dl	$1B80002
	dl	$30020
	dl	$A00015
	dl	$1400168
	dl	$2080230
	dl	$20001
	dl	$2000A8
	dl	$160140
	dl	$1680190
	dl	$1B80002
	dl	$30020
	dl	$A80015
	dl	$14001E0
	dl	$2080258
	dl	4
	dl	$2000B0
	dl	$140
	dl	$11800F0
	dl	$C80005
	dl	$60020
	dl	$B00017
	dl	$1400280
	dl	$2080258
	dl	$70004
	dl	$2000B8
	dl	$140
	dl	$11800F0
	dl	$C80005
	dl	$60020
	dl	$B80018
	dl	$2A802D0
	dl	$3200348
	dl	$80009
	dl	$6000C0
	dl	$2A8
	dl	$2F80320
	dl	$348000A
	dl	$90060
	dl	$C00000
audio_something	dl	0
	dl	0
	dl	$50202
	dl	$1010103
	dl	$40504
lbW00EDDE	dw	$100
	dw	$500
lbL00EDE2	dl	$12EB18D
	dl	$16073D4
lbW00EDEA	dw	9
lbB00EDEB	EQU	*-1
lbW00EDEC	dw	0
lbL00EDEE	dl	$10101818
	dl	$808
lbW00EDF6	dw	$3838
	dw	$4444
	dw	$2020
	dw	$2C2C
lbW00EDFE	dw	$4000
lbW00EE00	dw	$168
lbB00EE02	db	$7B
lbB00EE03	db	$7C
lbB00EE04	db	2
lbB00EE05	db	2
	dl	$78000168
	dl	$7D7E0200
	dl	$7A000168
	dl	$7F000000
	dl	$40000118
	dl	$7C7D0205
	dl	$4D000118
	dl	$7E000005
	dl	$520001E0
	dl	$54550203
	dl	$400001E0
	dl	$696A0202
	dl	$800000F0
	dl	$9A9B0106
	dl	$270002A8
	dl	$292A0201
	dl	$190002A8
	dl	$1B1A0301
	dl	$720002F8
	dl	$74750104
	dl	$760002F8
	dl	$74750105
	dl	$88000320
	dl	$85868701
	dl	$BB000320
	dl	$4C4D0200
	dl	$490002D0
	dl	$4B000000
	dl	$A5000320
	dl	$55560402
	dl	$D2000348
	dl	$D0D10200
lbL00EE86	dl	$23140F14
lbL00EE8A	dl	lbL011C20
	dl	$14230F0F
	dl	lbB011C43
	dl	$F14230A
	dl	lbL011C66
TTheFaeryTale.MSG	db	$80
	db	'T!"The Faery Tale Adventure"'
	db	$80
	db	'LJAnimation, Programming and Music'
	db	$80
	db	$92
	db	'Zby'
	db	$80
	db	'}eDavid Joiner'
	db	$80
	db	'T'
	db	$A0
	db	'Copyright (C) 1986 MicroIllusions ',0
lbL00EF18	dl	$1FFF8FF
	dl	$FC038000
	dl	$1FF0007
	dl	$FC038000
	dl	$7E0F078
	dl	$3F038000
	dl	$190FE03F
	dl	$C4C38000
	dl	$FC7FC01F
	dl	$F1FF8000
	dl	$F19F800F
	dl	$CC7F8000
	dl	$E7E70007
	dl	$3F3F8000
	dl	$CFF9800C
	dl	$FF9F8000
	dl	$9FFE6033
	dl	$FFCF8000
	dl	$3F0798CF
	dl	$C3E78000
	dl	$7001E79F
	dl	$338000
	dl	$783C
	dl	$38000
	dl	$1930
	dl	0
	dl	$780C
	dl	$38000
	dl	$7801C7F3
	dl	$338000
	dl	$3F87383C
	dl	$C3E78000
	dl	$9FFCF01F
	dl	$3FCF8000
	dl	$CFF3C00F
	dl	$CF9F8000
	dl	$E7CF8007
	dl	$F33F8000
	dl	$F13F800F
	dl	$FC7F8000
	dl	$FC7FC01F
	dl	$F1308000
	dl	$331FE03F
	dl	$C7C08000
	dl	$FE0F078
	dl	$3F008000
	dl	$3FF0007
	dl	$FF008000
	dl	$3FFF8FF
	dl	$FFFF0000
lbL00EFE0	dl	$1FFF8FF
	dl	$FC038000
	dl	$79FF0207
	dl	$FCF38000
	dl	$67E0F278
	dl	$3F338000
	dl	$190FE73F
	dl	$C4C38000
	dl	$FC7FCF9F
	dl	$F1FF8000
	dl	$F19F9FCF
	dl	$CC7F8000
	dl	$E7E73FE7
	dl	$3F3F8000
	dl	$CFF99FCC
	dl	$FF9F8000
	dl	$9FFE6733
	dl	$FFCF8000
	dl	$3F0798CF
	dl	$C3E78000
	dl	$70F9E79F
	dl	$3C338000
	dl	$FFE783C
	dl	$FFC38000
	dl	$FFFF9933
	dl	$FFF80000
	dl	$7FE780C
	dl	$FFC38000
	dl	$7879C7F3
	dl	$3C338000
	dl	$3F87383C
	dl	$C3E78000
	dl	$9FFCF39F
	dl	$3FCF8000
	dl	$CFF3CFCF
	dl	$CF9F8000
	dl	$E7CF9FE7
	dl	$F33F8000
	dl	$F13F9FCF
	dl	$FC7F8000
	dl	$FC7FCF9F
	dl	$F1308000
	dl	$331FE73F
	dl	$C7CC8000
	dl	$CFE0F278
	dl	$3F3C8000
	dl	$F3FF0207
	dl	$FF008000
	dl	$3FFF8FF
	dl	$FFFF0000
wasgettingrat.MSG	db	'% was getting rather hungry.',0
	db	'% was getting very hungry.',0
	db	'% was starving!',0
	db	'% was getting tired.',0
	db	'% was getting sleepy.',0
	db	'% was hit and killed!',0
	db	'% was drowned in the water!',0
	db	'% was burned in the lava.',0
	db	'% was turned to stone by the witch.',0
	db	'% started the journey in his home village of Tambry',0
	db	'as had his brother before him.',0
	db	'as had his brothers before him.',0
	db	'% just couldn''t stay awake any longer!',0
	db	'% was feeling quite full.',0
	db	'% was feeling quite rested.',0
	db	'Even % would not be stupid enough to draw weapon in '
	db	'here.',0
	db	'A great calming influence comes over %, preventing h'
	db	'im from drawing his weapon.',0
	db	'% picked up a scrap of paper.',0
	db	'It read: "Find the turtle!"',0
	db	'It read: "Meet me at midnight at the Crypt. Signed, '
	db	'the Wraith Lord."',0
	db	'% looked around but discovered nothing.',0
	db	'% does not have that item.',0
	db	'% bought some food and ate it.',0
	db	'% bought some arrows.',0
	db	'% passed out from hunger!',0
	db	'% is not sleepy.',0
	db	'% was tired, so he decided to lie down and sleep.',0
	db	'% perished in the hot lava!',0
	db	'It was midnight.',0
	db	'It was morning.',0
	db	'It was midday.',0
	db	'Evening was drawing near.',0
	db	'Ground is too hot for swan to land.',0
	db	'Flying too fast to dismount.',0
	db	'"They''re all dead!" he cried.',0
	db	'No time for that now!',0
	db	'% put an apple away for later.',0
	db	'% ate one of his apples.',0
	db	'% discovered a hidden object.',0
lbB00F56B	db	$33
	db	$33
	db	$13
	db	$40
	db	$45
	db	2
	db	$46
	db	$49
	db	3
	db	$50
	db	$5F
	db	6
	db	$60
	db	$63
	db	7
	db	$8A
	db	$8B
	db	8
	db	$90
	db	$90
	db	9
	db	$93
	db	$93
	db	10
	db	$94
	db	$94
	db	$14
	db	$9F
	db	$A2
	db	$11
	db	$A3
	db	$A3
	db	$12
	db	$A4
	db	$A7
	db	12
	db	$A8
	db	$A8
	db	$15
	db	$AA
	db	$AA
	db	$16
	db	$AB
	db	$AE
	db	14
	db	$B0
	db	$B0
	db	13
	db	$B2
	db	$B2
	db	$17
	db	$B3
	db	$B3
	db	$18
	db	$B4
	db	$B4
	db	$19
	db	$AF
	db	$B4
	db	0
	db	$D0
	db	$DD
	db	11
	db	$F3
	db	$F3
	db	$10
	db	$FA
	db	$FC
	db	0
	db	$FF
	db	$FF
	db	$1A
	db	$4E
	db	$4E
	db	4
	db	$BB
	db	$EF
	db	4
	db	0
	db	$4F
	db	0
	db	$B9
	db	$FE
	db	15
	db	0
	db	$FF
	db	0
lbL00F5C2	dl	$2020207
	dl	$7030404
	dl	$4050605
	dl	$90A061E
	dl	$1E071321
	dl	$E65650E
	dl	$82860E24
	dl	$240D252A
	dl	$C2E2E00
	dl	$2B3B0B64
	dl	$640B8F95
	dl	$B3E3E10
	dl	$4142123C
	dl	$4E115252
	dl	$11565711
	dl	$5C5C115E
	dl	$5F116163
	dl	$11787811
	dl	$7477118B
	dl	$8D114F60
	dl	$9686813
	dl	$72721469
	dl	$7308878A
	dl	$87D7D15
	dl	$7F7F0A8E
	dl	$8E167981
	dl	$1696A10F
	dw	$FF
	db	0
ascii.MSG21	db	0
	db	0
	db	'% returned to the village of Tambry.',0
	db	'% came to Vermillion Manor.',0
	db	'% reached the Mountains of Frost',0
	db	'% reached the Plain of Grief.',0
	db	'% came to the city of Marheim.',0
	db	'% came to the Witch''s castle.',0
	db	'% came to the Graveyard.',0
	db	'% came to a great stone ring.',0
	db	'% came to a watchtower.',0
	db	'% traveled to the great Bog.',0
	db	'% came to the Crystal Palace.',0
	db	'% came to mysterious Pixle Grove.',0
	db	'% entered the Citadel of Doom.',0
	db	'% entered the Burning Waste.',0
	db	'% found an oasis.',0
	db	'% came to the hidden city of Azal.',0
	db	'% discovered an outlying fort.',0
	db	'% came to a small keep.',0
	db	'% came to an old castle.',0
	db	'% came to a log cabin.',0
	db	'% came to a dark stone tower.',0
	db	'% came to an isolated cabin.',0
	db	'% came to the Tombs of Hemsath.',0
	db	'% reached the Forbidden Keep.',0
	db	'% found a cave in the hillside.',0
ascii.MSG22	db	0
	db	0
	db	'% came to a small chamber.',0
	db	'% came to a large chamber.',0
	db	'% came to a long passageway.',0
	db	'% came to a twisting tunnel.',0
	db	'% came to a forked intersection.',0
	db	'He entered the keep.',0
	db	'He entered the castle.',0
	db	'He entered the castle of King Mar.',0
	db	'He entered the sanctuary of the temple.',0
	db	'% entered the Spirit Plane.',0
	db	'% came to a large room.',0
	db	'% came to an octagonal room.',0
	db	'% traveled along a stone corridor.',0
	db	'% came to a stone maze.',0
	db	'He entered a small building.',0
	db	'He entered the building.',0
	db	'He entered the tavern.',0
	db	'He went inside the inn.',0
	db	'He entered the crypt.',0
	db	'He walked into the cabin.',0
	db	'He unlocked the door and entered.',0
attemptedtoco.MSG	db	'% attempted to communicate with the Ogre but a guttu'
	db	'ral snarl was the only response.',0
	db	'"Human must die!" said the goblin-man.',0
	db	'"Doom!" wailed the wraith.',0
	db	'A clattering of bones was the only reply.',0
	db	'% knew that it is a waste of time to talk to a snake'
	db	'.',0
	db	'...',0
	db	'There was no reply.',0
	db	'"Die, foolish mortal!" he said.',0
	db	'"No need to shout, son!" he said.',0
	db	'"Nice weather we''re having, isn''t it?" queried the'
	db	' ranger.',0
	db	'"Good luck, sonny!" said the ranger. "Hope you win!"'
	db	0
	db	'"If you need to cross the lake" said the ranger, "Th'
	db	'ere''s a raft just north of here."',0
	db	'"Would you like to buy something?" said the tavern k'
	db	'eeper. "Or do you just need lodging for the night?"',0
	db	'"Good Morning." said the tavern keeper. "Hope you sl'
	db	'ept well."',0
	db	'"Have a drink!" said the tavern keeper."',0
	db	'"State your business!" said the guard.',$D
	db	'"My business is with the king." stated %, respectful'
	db	'ly.',0
	db	'"Please, sir, rescue me from this horrible prison!" '
	db	'pleaded the princess.',0
	db	'"I cannot help you, young man." said the king. "My a'
	db	'rmies are decimated, and I fear that with the loss o'
	db	'f my children, I have lost all hope."',0
	db	'"Here is a writ designating you as my official agent'
	db	'. Be sure and show this to the Priest before you lea'
	db	've Marheim.',0
	db	'"I''m afraid I cannot help you, young man. I already'
	db	' gave the golden statue to the other young man.',0
	db	'"If you could rescue the king''s daughter," said Lor'
	db	'd Trane, "The King''s courage would be restored."',0
	db	'"Sorry, I have no use for it."',0
	db	'"The dragon''s cave is directly north of here." said'
	db	' the ranger."',0
	db	'"Alms! Alms for the poor!"',0
	db	'"I have a prophecy for you, m''lord." said the begga'
	db	'r. "You must seek two women, one Good, one Evil."',0
	db	'"Lovely Jewels, glint in the night - give to us the '
	db	'gift of Sight!" he said.',0
	db	'"Where is the hidden city? How can you find it when '
	db	'you cannot even see it?" said the beggar.',0
	db	'"Kind deeds could gain thee a friend from the sea."',0
	db	'"Seek the place that is darker than night - There yo'
	db	'u shall find your goal in sight!" said the wizard, c'
	db	'ryptically.',0
	db	'"Like the eye itself, a crystal Orb can help to find'
	db	' things concealed."',0
	db	'"The Witch lives in the dim forest of Grimwood, wher'
	db	'e the very trees are warped to her will. Her gaze is'
	db	' Death!"',0
	db	'"Only the light of the Sun can destroy the Witch''s '
	db	'Evil."',0
	db	'"The maiden you seek lies imprisoned in an unreachab'
	db	'le castle surrounded by unclimbable mountains."',0
	db	'Tame the golden beast and no mountain may deny you! '
	db	'''But what rope could hold such a creature?"',0
	db	'"Just what I needed!" he said.',0
	db	'"Away with you, young ruffian!" said the Wizard. "Pe'
	db	'rhaps you can find some small animal to torment if t'
	db	'hat pleases you!"',0
	db	'You must seek your enemy on the spirit plane. ''It i'
	db	's hazardous in the extreme. Space may twist, and tim'
	db	'e itself may run backwards!"',0
	db	'"When you wish to travel quickly, seek the power of '
	db	'the Stones." he said.',0
	db	'"Since you are brave of heart, I shall Heal all your'
	db	' wounds."',$D
	db	'Instantly % felt much better.',0
	db	'"Ah! You have a writ from the king. Here is one of t'
	db	'he golden statues of Azal-Car-Ithil. Find all five a'
	db	'nd you''ll find the vanishing city."',0
	db	'"Repent, Sinner! Thou art an uncouth brute and I hav'
	db	'e no interest in your conversation!"',0
	db	'"Ho there, young traveler!" said the black figure. "'
	db	'None may enter the sacred shrine of the People who c'
	db	'ame Before!"',0
	db	'"Your prowess in battle is great." said the Knight o'
	db	'f Dreams. "You have earned the right to enter and cl'
	db	'aim the prize."',0
	db	'"So this is the so-called Hero who has been sent to '
	db	'hinder my plans. Simply Pathetic. Well, try this, yo'
	db	'ung Fool!"',0
	db	'% gasped. The Necromancer had been transformed into '
	db	'a normal man. All of his evil was gone.',0
	db	'"%." said the Sorceress. "Welcome. Here is one of th'
	db	'e five golden figurines you will need."',$D
	db	'"Thank you." said %.',0
	db	'"Look into my eyes and Die!!" hissed the witch.',$D
	db	'"Not a chance!" replied %',0
	db	'The Spectre spoke. "HE has usurped my place as lord '
	db	'of undead. Bring me bones of the ancient King and I'''
	db	'll help you destroy him."',0
	db	'% gave him the ancient bones.',$D
	db	'"Good! That spirit now rests quietly in my halls. Ta'
	db	'ke this crystal shard."',0
	db	'"%..." said the apparition. "I am the ghost of your '
	db	'dead brother. Find my bones -- there you will find s'
	db	'ome things you need.',0
	db	'% gave him some gold coins. ',$D
	db	'"Why, thank you, young sir!"',0
	db	'"Sorry, but I have nothing to sell."',0,0
	db	'"The dragon''s cave is east of here." said the range'
	db	'r."',0
	db	'"The dragon''s cave is west of here." said the range'
	db	'r."',0
	db	'"The dragon''s cave is south of here." said the rang'
	db	'er."',0
	db	'"Oh, thank you for saving my eggs, kind man!" said t'
	db	'he turtle. "Take this seashell as a token of my grat'
	db	'itude."',0
	db	'"Just hop on my back if you need a ride somewhere." '
	db	'said the turtle.',0
	db	'"Stupid fool, you can''t hurt me with that!"',0
	db	'"Your magic won''t work here, fool!"',0
	db	'The Sunstone has made the witch vulnerable!',0,0
	db	1
	db	2
	db	7
	db	9
	db	3
	db	6
	db	5
	db	4
	db	0
lbB010D66	db	0
lbB010D67	db	0
lbB010D68	db	$10
ascii.MSG23	db	8
	db	$10
	db	0
	db	$10
	db	9
	db	' ',0
	db	$10
	db	8
	db	$1E
	db	8
	db	$12
	db	8
	db	' '
	db	$10
	db	$10
	db	8
	db	$10
	db	13
	db	$10
	db	11
	db	0
	db	$10
	db	$10
	db	8
	db	0
	db	8
	db	$12
	db	8
	db	0
	db	0
	db	1
	db	1
	db	0
	db	0
	db	1
	db	1
lbL010D8E	dl	$FFF
	dl	$E960B63
	dl	$63107BF
	dl	$3330DB8
	dl	$2230445
	dl	$8890BBC
	dl	$5210941
	dl	$F820FC7
	dl	$400070
	dl	$B006F6
	dl	$50009
	dl	$D037F
	dl	$C000F50
	dl	$FA00FF6
	dl	$EB60EA5
	dw	15
lbW010DCC	dw	$BDF
lbW010DCE	dw	0
lbW010DD0	dw	0
lbB010DD2	db	1
lbB010DD3	db	$20
C.MSG	db	'C'
lbB010DD5	db	$2A
lbW010DD6	dw	0
lbL010DD8	dl	$5600120
	dl	$432A0000
	dl	$58A0120
	dl	$432A0000
	dl	$5B40110
	dl	$74240100
	dl	$5200220
	dl	$2030300
	dl	$5440220
	dl	$10140500
	dl	$5470120
	dl	$40280200
	dl	$3C00120
	dl	$40280200
	dl	$4380120
	dl	$40280200
	dl	$3E80120
	dl	$40280200
	dl	$4100328
	dl	$50C0600
	dl	$4880440
	dl	$8280500
	dl	$4600120
	dl	$40280200
	dl	$5600120
	dl	$8050400
	dl	$3A80120
	dl	$8050400
	dl	$3A30120
	dl	$8050400
	dl	$3AD0120
	dl	$8050400
	dl	$3B20120
	dl	$8050400
	dw	$3B7
lbL010E62	dl	$8060504
	dl	$3020305
	dl	$D00000D
	dl	$5030203
	dl	$4050608
	dw	0
lbL010E78	dl	$7050403
	dl	$2010101
	dl	$1000001
	dl	$1010102
	dl	$3040507
	dw	0
lbL010E8E	dl	$C090603
	dl	0
	dl	0
	dl	0
	dl	$30609
	dw	0
lbL010EA4	dl	$3080A
	dl	$B0F011E
	dl	$22D034B
	dw	$D14
lbL010EB2	dl	0
	dl	0
	dl	$90B0D1F
	dl	$1F111120
	dl	$C0E1414
	dl	$141F211F
	dl	$A0A1010
	dl	$B111213
	dl	$F150000
	dl	0
lbL010EDA	dl	0
	dl	$1010101
	dl	$1020102
	dl	$1020302
	dl	$4040302
	dl	$5050505
	dl	$8080808
	dl	$3030303
lbL010EFA	dl	0
	dl	$2022
	dl	$3A6F7071
	dl	$24273C6F
	dl	$70713738
	dl	$3D6F7071
lbL010F12	dl	$1020304
	dl	$3020100
	dl	$30200FE
	dl	$FDFE0002
	dl	$FDFDFDFD
	dl	$FDFDFDFE
	dl	$10101
	dl	$FEFDFE
lbL010F32	dl	$8080807
	dl	$8080808
	dl	$B0C0D0D
	dl	$D0D0D0C
	dl	$8070605
	dl	$6070809
	dl	$C0C0C0C
	dl	$C0C0B0C
lbL010F52	dl	$306
	dl	$FDFDFDFA
lbL010F5A	dl	$FAFAFF00
	dl	$60800FF
lbL010F62	dl	$2000407
	dl	$9040708
lbL010F6A	dl	$64000A
	dl	$9630009
	dl	$13620109
	dl	$1D5F0209
	dl	$265C0309
	dl	$2F580408
	dl	$37530508
	dl	$3F4D0607
	dl	$46460707
	dl	$4D3F0706
	dl	$53370805
	dl	$582F0804
	dl	$5C260903
	dl	$5F1D0902
	dl	$62130901
	dl	$63090900
	dl	$64000A00
	dl	$63F609FF
	dl	$62EC09FE
	dl	$5FE209FD
	dl	$5CD909FC
	dl	$58D008FB
	dl	$53C808FA
	dl	$4DC007F9
	dl	$46B907F8
	dl	$3FB206F8
	dl	$37AC05F7
	dl	$2FA704F7
	dl	$26A303F6
	dl	$1DA002F6
	dl	$139D01F6
	dl	$99C00F6
	dl	$9C00F6
	dl	$F69CFFF6
	dl	$EC9DFEF6
	dl	$E2A0FDF6
	dl	$D9A3FCF6
	dl	$D0A7FBF7
	dl	$C8ACFAF7
	dl	$C0B2F9F8
	dl	$B9B9F8F8
	dl	$B2C0F8F9
	dl	$ACC8F7FA
	dl	$A7D0F7FB
	dl	$A3D9F6FC
	dl	$A0E2F6FD
	dl	$9DECF6FE
	dl	$9CF6F6FF
	dl	$9CFFF6FF
	dl	$9C09F600
	dl	$9D13F601
	dl	$A01DF602
	dl	$A326F603
	dl	$A72FF704
	dl	$AC37F705
	dl	$B23FF806
	dl	$B946F807
	dl	$C04DF907
	dl	$C853FA08
	dl	$D058FB08
	dl	$D95CFC09
	dl	$E25FFD09
	dl	$EC62FE09
	dl	$F663FF09
ascii.MSG24	db	11
ascii.MSG25	db	'#'
	db	$12
	db	9
	db	$13
	db	10
	db	$16
	db	11
	db	$15
	db	12
	db	$17
	db	13
	db	$11
	db	14
	db	$18
	db	15
	db	$91
	db	4
	db	$1B
	db	5
	db	8
	db	2
	db	9
	db	1
	db	12
	db	0
	db	10
	db	3
	db	$93
	db	$17
	db	$94
	db	$18
	db	$95
	db	$19
	db	$96
	db	$1A
	db	$97
	db	6
	db	$9B
	db	7
	db	$88
	db	$1B
	db	$89
	db	$1C
	db	$8A
	db	$1D
	db	$8B
	db	$16
	db	$8C
	db	$1E
	db	$19
	db	$10
	db	$99
	db	$11
	db	'r'
	db	$12
	db	'ò'
	db	$13
	db	$1A
	db	$14
	db	$9A
	db	$15
	db	0
	db	0
lbL0110AA	dl	$10101010
	dl	$F0D190B
	dl	$1A1A1AF2
	dl	$17169A0F
lbW0110BA	dw	0
lbW0110BC	dw	0
lbB0110BE	db	0
lbB0110BF	db	0
	db	0
	db	0
	db	0
	db	0
	db	$1C
	db	0
	db	0
	db	0
	db	0
	db	0
	db	$1C
	db	0
	db	$4B
	db	$74
	db	$3D
	db	$83
	db	11
lbB0110D1	db	0
	db	$47
	db	$14
	db	$3D
	db	$77
	db	11
lbB0110D7	db	0
	db	$30
	db	$97
	db	$8D
	db	$6A
	db	10
lbB0110DD	db	3
	db	$2B
	db	$54
	db	$96
	db	$7E
	db	$95
	db	1
	db	$64
	db	$89
	db	$29
	db	$A6
	db	$95
	db	1
	db	11
	db	$5E
	db	$98
	db	$6F
	db	$95
	db	1
	db	$2E
	db	$F9
	db	$93
	db	7
	db	$95
lbB0110F5	db	0
	db	$1A
	db	$2C
	db	$83
	db	$E6
	db	$95
lbB0110FB	db	0
lbL0110FC	dl	$D0C1A4F
	dl	$C0325CE
	dl	$1B7B0C03
	dl	$137518A2
	dl	$C030000
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dw	0
lbL01114A	dl	$5A2F1623
	dl	$66010000
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dw	0
lbL01118C	dl	$35643A98
	dl	$32983
	dl	$33620003
	dl	$13752748
	dl	$C03367E
	dl	$2B4F1001
	dl	$28688D4B
	dl	$97010000
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dw	0
lbL0111E6	dl	$4B623F00
	dl	$F014786
	dl	$3E610D03
	dl	$4E413841
	dl	$360DA
	dl	$332E0D03
	dl	$547A3C56
	dl	$12015470
	dl	$3C600D01
	dl	$54843C60
	dl	$11014E95
	dl	$378E1301
	dl	$5E792670
	dl	$100164A9
	dl	$29790D01
	dl	$644E29CF
	dl	$12014319
	dl	$29671401
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
lbL01126A	dl	0
	dl	0
	dl	0
	dl	$1AA14CED
	dl	$D030000
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dw	0
lbL0112B8	dl	$56A852A4
	dl	$D03492E
	dl	$44BB1101
	dl	$532E5878
	dl	$F0159AC
	dl	$4DF30003
	dl	$6EB65855
	dl	$30000
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dw	0
lbL0112EE	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
lbL011312	dl	$60DA332E
	dl	$D030000
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dw	0
lbL011354	dl	$5B0116A5
	dl	$66010000
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dw	0
lbL011396	dl	$1A2C83DC
	dl	$1031573
	dl	$83F40503
	dl	$15D883E4
lbL0113A6	dl	$603158A
	dl	$83840203
	dl	$15C68384
	dl	$20322AE
	dl	$98530003
	dl	$1E608524
	dl	$3158A
	dl	$84590303
	dl	$15C68459
	dl	$3032A65
	dw	$8B48
	db	4
lbB0113D1	db	3
	dl	$2F0592EE
	dl	$7032B05
	dl	$8FC40903
	dl	$259F9829
	dl	$80327CF
	dl	$98290803
	dl	$29999829
	dl	$8030B96
	dl	$84AC0803
	dl	$253C9C42
	dl	$1F011A5B
	dl	$83D71F01
	dl	$2C928D49
	dl	$9B01254E
	dl	$9C1C1701
	dl	$25509C1C
	dl	$170125D2
	dl	$9C1C1701
	dl	$25D49C1C
	dl	$1701253C
	dl	$9CB71701
	dl	$25679A23
	dl	$E012576
	dl	$9A230E01
	dl	$25859A23
	dl	$E0125D0
	dl	$9A1D1601
	dl	$25D29A1D
	dl	$16012638
	dl	$9A1D1601
	dl	$25C49A82
	dl	$F012B52
	dl	$9A260D01
	dl	$2B649A22
	dl	$17012B6E
	dl	$9A231701
	dl	$2B789A23
	dl	$17012B82
	dl	$9A221701
	dl	$2B8C9A23
	dl	$17012B96
	dl	$9A231701
	dl	$2E4F8D6E
	dl	$1F012E85
	dl	$8D660F01
	dl	$2E8E8D96
	dl	$17012E98
	dl	$8D961701
	dl	$2EA28D96
	dl	$17012FB4
	dl	$96510F01
	dl	$2D849651
	dl	$F20128BB
	dl	$9C291F01
	dl	$28539C87
	dl	$E01274B
	dl	$96481001
	dl	$28688D4B
	dl	$97012EA0
	dl	$8D6F1401
	dl	$25CA8B67
	dl	$E011561
	dl	$972B9301
	dl	$1C118626
	dl	$94011C16
	dl	$86269401
	dl	$1C1B8626
	dl	$94011C11
	dl	$862B9401
	dl	$1C16862B
	dl	$94011C1B
	dl	$862B9401
	dl	$19C18525
	dl	$940119C6
	dl	$85259401
	dl	$19C1852A
	dl	$940119C6
	dl	$852A9401
	dl	$F20830A
	dl	$19050F2F
	dl	$82E61705
	dl	$118F82E6
	dl	$16050CFF
	dl	$82671805
	dl	$107D8547
	dl	$B051DBA
	dl	$83441605
	dl	$1DC082F2
	dl	$D052562
	dl	$8BB81205
	dl	$25C48BB9
	dl	$B052551
	dl	$98271105
	dl	$274E985D
	dl	$18052951
	dl	$98271605
	dl	$2B369A5A
	dl	$D05228D
	dl	$9A469A05
	dl	$198E9A46
	dl	$13051C91
	dl	$9850F205
lbL01156A	dl	$1D749680
	dl	$91012598
	dl	$8ECF9101
	dl	$25989253
	dl	$91012091
	dl	$8F6F9101
	dl	$1FDA884A
	dl	$F011E92
	dl	$8B9D0F01
	dl	$D84918C
	dl	$32125
	dl	$8B8D0D01
	dl	$E8B99AC
	dw	$8A01
lbL0115A0	dl	lbL0110FC
	dl	lbL01114A
	dl	lbL01118C
	dl	lbL0111E6
	dl	lbL01126A
	dl	lbL0112B8
	dl	lbL011312
	dl	lbL011354
	dl	lbL011396
	dl	lbL01156A
lbL0115C8	dl	$30001
	dl	$5000C
	dl	$30005
	dl	$10001
	dl	$4D0009
lbL0115DC	dl	0
	dl	0
	dl	0
	dl	0
	dl	$10001
lbW0115F0	dw	11
lbL0115F2	dl	LIGHT.MSG
	dl	HEED.MSG
	dl	DEED.MSG
	dl	SIGHT.MSG
	dl	FLIGHT.MSG
	dl	CREED.MSG
	dl	BLIGHT.MSG
	dl	NIGHT.MSG
;df.MSG	db	'df'
;ascii.MSG26	db	'1:'
Afaery.MSG	db	'A.faery',0
lbL01161E	dl	0
	dl	$10002
	dl	$20012
	dl	$1120113
	dl	$1130214
	dl	$2240225
	dl	$3260326
	dl	$3370338
	dl	$4380439
	dl	$449054A
	dl	$54B054B
	dl	$55C065C
	dl	$65D066E
	dl	$76E076F
	dl	$86F097E
	dl	$A7E0B7E
	dl	$B8D0C8D
	dl	$D8D0D8D
	dl	$E9C0E9C
	dl	$E9B0E9B
	dl	$FAA0FAA
	dl	$F990F98
	dl	$F980F97
	dl	$F860F85
	dl	$F840F84
	dl	$F930F92
	dw	$76F
lbL011688	dl	FORMILBMBMHDC.MSG
musicvblank.MSG	db	'music vblank',0,0
	db	0
	db	0
	db	0
	db	0
audio4.MSG	db	'audio 4',0,0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
	db	0
vblank_data	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
vblank_interrupt	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dw	0
lbL011768	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
	dl	0
old_aud_handler	dl	0
lbL01178C	dl	$202020
	dl	$20202020
	dl	$20203030
	dl	$30303020
	dl	$20202020
	dl	$20202020
	dl	$20202020
	dl	$20202020
	dl	$20904040
	dl	$40404040
	dl	$40404040
	dl	$40404040
	dl	$400C0C0C
	dl	$C0C0C0C
	dl	$C0C0C40
	dl	$40404040
	dl	$40400909
	dl	$9090909
	dl	$1010101
	dl	$1010101
	dl	$1010101
	dl	$1010101
	dl	$1010101
	dl	$40404040
	dl	$40400A0A
	dl	$A0A0A0A
	dl	$2020202
	dl	$2020202
	dl	$2020202
	dl	$2020202
	dl	$2020202
	dl	$40404040
	dw	$2000
lbL01180E	dl	0
lbL011812	dl	0
	dw	0
lbB011818	ds.b	1
lbB011819	ds.b	1
lbW01181A	ds.w	1
lbW01181C	ds.w	1
lbL01181E	ds.l	$3C
lbB01190E	ds.b	2
lbL011910	ds.l	1
lbL011914	ds.l	1
lbL011918	ds.l	1
DosBase	ds.l	1
lbL011920	ds.l	1
lbB011924	ds.b	2
lbL011926	ds.l	1
lbL01192A	ds.l	1
lbL01192E	ds.l	1
SysBase	ds.l	1
lbB011936	ds.b	1
lbB011937	ds.b	1
lbB011938	ds.b	1
lbB011939	ds.b	1
lbB01193A	ds.b	1
lbB01193B	ds.b	1
lbB01193C	ds.b	1
lbB01193D	ds.b	1
lbB01193E	ds.b	1
lbB01193F	ds.b	1
lbB011940	ds.b	1
lbB011941	ds.b	1
lbB011942	ds.b	1
lbB011943	ds.b	1
lbB011944	ds.b	1
lbB011945	ds.b	1
lbB011946	ds.b	1
lbB011947	ds.b	1
lbB011948	ds.b	1
lbB011949	ds.b	1
lbW01194A	ds.w	1
lbW01194C	ds.b	1
lbB01194D	ds.b	1
lbW01194E	ds.w	1
lbW011950	ds.w	3
lbW011956	ds.w	1
lbW011958	ds.w	1
lbW01195A	ds.w	1
lbW01195C	ds.b	1
lbB01195D	ds.b	1
lbW01195E	ds.w	1
lbW011960	ds.w	1
lbW011962	ds.w	1
lbW011964	ds.w	1
lbW011966	ds.w	1
lbW011968	ds.w	1
lbW01196A	ds.w	2
lbW01196E	ds.w	1
lbW011970	ds.w	1
lbW011972	ds.w	1
lbW011974	ds.w	1
lbW011976	ds.w	1
lbW011978	ds.w	1
lbW01197A	ds.w	1
lbW01197C	ds.w	1
lbW01197E	ds.w	1
lbW011980	ds.w	1
lbW011982	ds.w	1
lbW011984	ds.w	1
lbW011986	ds.w	1
lbW011988	ds.w	1
lbW01198A	ds.w	1
lbW01198C	ds.w	1
lbW01198E	ds.w	1
lbW011990	ds.w	1
lbW011992	ds.w	1
lbW011994	ds.w	1
lbW011996	ds.w	1
lbW011998	ds.w	1
lbW01199A	ds.w	1
lbW01199C	ds.w	1
lbW01199E	ds.w	8
lbW0119AE	ds.w	1
lbW0119B0	ds.w	1
lbW0119B2	ds.w	1
lbW0119B4	ds.w	1
lbW0119B6	ds.w	1
lbW0119B8	ds.w	1
lbW0119BA	ds.w	1
lbW0119BC	ds.w	1
lbW0119BE	ds.b	1
lbB0119BF	ds.b	1
lbW0119C0	ds.w	1
lbW0119C2	ds.w	1
lbW0119C4	ds.w	1
lbW0119C6	ds.w	1
lbW0119C8	ds.w	1
some_more_flags	ds.b	1
some_flags	ds.b	1
lbW0119CC	ds.w	1
lbW0119CE	ds.w	1
lbW0119D0	ds.w	1
lbW0119D2	ds.w	1
lbW0119D4	ds.w	1
lbW0119D6	ds.w	1
lbW0119D8	ds.w	1
lbW0119DA	ds.w	1
lbW0119DC	ds.w	1
lbW0119DE	ds.w	1
lbW0119E0	ds.w	1
lbW0119E2	ds.w	1
lbW0119E4	ds.w	1
lbW0119E6	ds.w	1
lbW0119E8	ds.w	1
lbW0119EA	ds.w	1
lbW0119EC	ds.w	1
lbW0119EE	ds.w	1
actiview	ds.l	1
lbL0119F4	ds.l	1
lbL0119F8	ds.l	1
lbL0119FC	ds.l	1
lbL011A00	ds.l	1
lbL011A04	ds.l	1
lbL011A08	ds.l	1
bitmap_array_ptr	ds.l	1	;320x200x5
bitmap320x200x5_ptr	ds.l	1	;320x200x5
bitmap640x57x4_ptr	ds.l	1	;640x57x4
bitmap320x200x1_ptr	ds.l	1	;320x200x1
lbL011A1C	ds.l	1
bitmap64x24x3_ptr	ds.l	1	;64x24x3
active_rp_ptr	ds.l	2
lbL011A2C	ds.l	1
_GfxBase	ds.l	1
LayersBase	ds.l	1
lbL011A38	ds.l	1
lbL011A3C	ds.l	1
spritedata_ptr	ds.l	1	;points to struct spriteimage
fontseg_bptr	ds.l	1
fontseg_ptr	ds.l	1
lbL011A4C	ds.l	1
font_ptr	ds.l	1
lbL011A54	ds.l	1
buffer_36864	ds.l	1
mid_buffer_36864	ds.l	1
buffer_12288	ds.l	1
buffer_78000	ds.l	1
lbL011A68	ds.l	1
lbL011A6C	ds.l	1
buffer_5632	ds.l	1
buffer_1024	ds.l	1
trackdisk_buffer_ptr
	ds.l	2
;trackdisk_mp	ds.l	1
;trackdisk_io	ds.l	1
;trackdisk_io_ptr	ds.l	1
v6_buffer_ptr	ds.l	1
v6_buffer2_ptr	ds.l	1
lbL011A94	ds.l	1
lbL011A98	ds.l	1
lbL011A9C	ds.l	1
lbL011AA0	ds.l	1
active_bitmap_ptr	ds.l	1
layerinfo	ds.l	1
my_task	ds.l	1
input_mp	ds.l	1
input_io	ds.l	1
lbL011AB8	ds.l	1
lbL011ABC	ds.l	1
lbL011AC0	ds.l	1
lbL011AC4	ds.l	1
lbL011AC8	ds.l	1
layer_ptr	ds.l	1
lbL011AD0	ds.l	2
lbL011AD8	ds.l	1
lbL011ADC	ds.l	1
lbL011AE0	ds.l	1
lbL011AE4	ds.l	1
lbL011AE8	ds.l	1
lbL011AEC	ds.l	1
lbL011AF0	ds.l	1
lbL011AF4	ds.l	1
lbL011AF8	ds.l	1
lbL011AFC	ds.l	1
lbL011B00	ds.l	1
lbL011B04	ds.l	1
lbL011B08	ds.l	1
lbL011B0C	ds.l	1
lbL011B10	ds.l	1
workbench_message	ds.l	1
lbL011B18	ds.l	2
lbL011B20	ds.l	2
	ds.w	1
; RasInfo contains LONG next, LONG *bitmap, WORD RxOffset, WORD RyOffset
viewport1_rasinfo	ds.l	1	;ptr to next rasinfo
rasinfo1_bitmap_ptr	ds.l	1
rasinfo1_rxoffset	ds.w	1
rasinfo1_ryoffset	ds.w	1
; ------------
rasinfo3	ds.l	1
rasinfo3_bitmap_ptr	ds.l	1
rasinfo3_rxoffset	ds.w	1
rasinfo3_ryoffset	ds.w	1
; RasInfo contains LONG next, LONG *bitmap, WORD RxOffset, WORD RyOffset
viewport2_rasinfo	ds.l	1	;ptr to next RasInfo
rasinfo2_bitmap_ptr	ds.l	1
rasinfo2_rxoffset	ds.w	1
rasinfo2_ryoffset	ds.w	7
lbL011B5A	ds.l	3
; -----------
view	ds.l	1	;ptr to 1st ViewPort
view_lofcprlist	ds.l	1	;LOFCprList
view_shfcprlist	ds.l	2	;SHFCprList
	ds.b	1	;modes (word)
view_modes_lowbyte	ds.b	1
; ------------
lbL011B78	ds.l	5
input_interrupt	ds.l	2
	ds.b	1
input_handler_priority
	ds.b	5
lbL011B9A	ds.l	1
input_handler_ptr	ds.l	1
lbW011BA2	ds.w	1
lbW011BA4	ds.w	4
lbB011BAC	ds.b	12
lbL011BB8	ds.l	6
lbL011BD0	ds.l	6
lbL011BE8	ds.l	6
lbL011C00	ds.l	8
lbL011C20	ds.l	8
	ds.w	1
	ds.b	1
lbB011C43	ds.b	$23
lbL011C66	ds.l	9
lbL011C8A	ds.l	1
lbL011C8E	ds.l	3
lbW011C9A	ds.w	1
lbL011C9C	ds.l	1
lbL011CA0	ds.l	3
	ds.w	1
lbW011CAE	ds.w	1
rasinfo3_ptr	ds.l	1
lbL011CB4	ds.l	3
lbW011CC0	ds.w	1
lbL011CC2	ds.l	1
lbL011CC6	ds.l	3
	ds.w	1
lbW011CD4	ds.w	1
; 288x140 (+16+0) viewport
viewport1	ds.l	1	;ptr to next ViewPort
viewport1_colormap	ds.l	5	;colormap & 4 copper lists
viewport1_dwidth	ds.w	1	;DWidth
viewport1_dheight	ds.w	1	;DHeight
viewport1_dxoffset	ds.w	1	;DxOffset
viewport1_dyoffset	ds.w	3	;DyOffset & modes
viewport1_rasinfo_ptr
	ds.l	1	;ptr to rasinfo
; 640x57 (+0+143) viewport
viewport2	ds.l	1	;ptr to next ViewPort
viewport2_colormap	ds.l	5	;colormap & 4 copper lists
viewport2_dwidth	ds.w	1	;DWidth
viewport2_dheight	ds.w	1	;DHeight
viewport2_dxoffset	ds.w	1	;DxOffset
viewport2_dyoffset	ds.w	1	;DyOffset
viewport2_modes	ds.w	2	;Modes (word)
viewport2_rasinfo_ptr
	ds.l	11	;ptr to RasInfo
bitmap640x57x1	ds.l	2	;640x57x1
bitmap640x57x1_planes
	ds.l	8
bitmap320x200x5	ds.l	2	;320x200x5 (16x8000x5)
bitmap320x200x5_plane0
	ds.l	1
bitmap320x200x5_plane1
	ds.l	1
bitmap320x200x5_plane2
	ds.l	1
bitmap320x200x5_plane3
	ds.l	1
bitmap320x200x5_plane4
	ds.l	4
bitmap320x200x5_2	ds.l	2	;320x200x5
bitmap320x200x5_2_planes
	ds.l	8
lbL011DC6	ds.l	10
lbL011DEE	ds.l	15
colormap	ds.w	1
lbW011E2C	ds.w	$1B
lbW011E62	ds.w	1
lbW011E64	ds.w	1
lbW011E66	ds.w	1
lbW011E68	ds.w	1
rp1	ds.l	1
rp1_bitmap_ptr	ds.l	$18
active_rp	ds.l	1
active_rp_bitmap_ptr
	ds.l	12
lbL011F02	ds.l	12
rp640x57x4	ds.l	1
rp640x57x4_bitmap_ptr
	ds.l	$18
input_handle	ds.l	1
lbW011F9A	ds.w	1
output_handle	ds.l	1
lbW011FA0	ds.w	1
star_handle	ds.l	1
lbW011FA6	ds.w	$34
lbW01200E	ds.w	1
lbW012010	ds.w	1
lbW012012	ds.w	1
lbL012014	ds.l	1
lbL012018	ds.l	1
lbL01201C	ds.l	2
	ds.w	1
lbL012026	ds.l	4
	ds.w	1
lbL012038	ds.l	9
lbL01205C	ds.l	12
lbL01208C	ds.l	12
tune_1	ds.l	1
tune_2	ds.l	1
tune_3	ds.l	1
tune_4	ds.l	$11
lbW01210C	ds.w	1
lbW01210E	ds.w	1
lbB012110	ds.b	2
lbB012112	ds.b	1
lbB012113	ds.b	1
lbB012114	ds.b	1
lbB012115	ds.b	1
_GfxBase2	ds.l	1
lbL01211A	ds.l	1
viewport2_ptr	ds.l	$49
lbL012242	ds.l	$32
lbW01230A	ds.w	1
lbW01230C	ds.w	3
lbB012312	ds.b	1
lbB012313	ds.b	1
lbB012314	ds.b	1
lbB012315	ds.b	1
lbB012316	ds.b	1
lbB012317	ds.b	1
lbW012318	ds.w	1
lbB01231A	ds.b	1
lbB01231B	ds.b	1
lbW01231C	ds.w	1
lbB01231E	ds.b	1
lbB01231F	ds.b	1
lbL012320	ds.l	5
	ds.w	1
lbW012336	ds.w	1
lbW012338	ds.w	7
	ds.b	1
lbB012347	ds.b	5
lbW01234C	ds.w	1
lbW01234E	ds.w	3
	ds.b	1
lbB012355	ds.b	$16D
;trackdisk_io_array	ds.l	28
;trackdisk_io_2	ds.l	84
;trackdisk_io_8	ds.l	7
lbW01269E	ds.w	14
;trackdisk_io_copy	ds.l	7
lbW0126D6	ds.w	4
lbL0126DE	ds.l	5
	ds.w	1
		ds.b	1000	; added to stop mungwall hits
DxAreaEnd

	SECTION	fmainrs0126F4,BSS
	ds.l	1

	end
