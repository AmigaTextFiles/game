	opt	L+
	opt	O2+
	opt	OW-

*==========================================
*
* File:        start.s
* Version:     1
* Revision:    0
* Created:     3-VII-1993
* By:          FNC Slothouber
* Last Update: 25-Aug-1995
* By:          FNC Slothouber
*
*==========================================

	incdir	"include:"

	include graphics/graphics_lib.i
	include graphics/gfxbase.i
	include	graphics/view.i
	include hardware/custom.i
	include hardware/intbits.i
	include	exec/exec_lib.i
	include exec/memory.i
	include exec/nodes.i
	include exec/interrupts.i
	include	workbench/startup.i

	include	libraries/dos_lib.i
	include	libraries/dos.i

	include	ExtGfx.i

	include	reqtools/reqtools.i

	include execmacros.i
	include	boulderdash.i

	XDEF	grid_field
	XDEF	_ExtGfxBase
	XDEF	_IntuitionBase
	XDEF	_GfxBase
	XDEF	_ReqToolsBase
	XDEF	_DOSBase
	XDEF	bitmap1
	XDEF	bitmap2
	XDEF	st_bitmap1
	XDEF	st_bitmap2
	XDEF	bitmapg
	XDEF	display

	XDEF	list1
	XDEF	list2
	XDEF	list2_right4
	XDEF	list2_right12
	XDEF	list1_right8
	XDEF	list2_left4
	XDEF	list2_left12
	XDEF	list1_left8

	XDEF	list2_up4
	XDEF	list2_up12
	XDEF	list1_up8
	XDEF	list2_down4
	XDEF	list2_down12
	XDEF	list1_down8

	XDEF	colors

	XREF	Start_Editor
	XREF	Stop_Editor
	XREF	Field_Editor

	XREF	AllocRasters
	XREF	FreeRasters
	XREF	EG_AllocBitMap
	XREF	EG_FreeBitMap
	XREF	GetPicture
	XREF	ClearBitMap
	XREF	GetDisplay
	XREF	FreeDisplay
	XREF	CreatePort
	XREF	DeletePort
	XREF	CreateStdIO
	XREF	CreateExtIO
	XREF	DeleteStdIO
	XREF	DeleteExtIO


CALLEXT		macro
		jsr	\1
		endm

	IFND	EXEC_EXEC_I
	include	"exec/exec.i"
	ENDC
	IFND	LIBRARIES_DOSEXTENS_I
	include	"libraries/dosextens.i
	ENDC


	movem.l	d0/a0,-(sp)		save initial values
	clr.l	returnMsg

	sub.l	a1,a1
	EXECCALL FindTask		find us
	move.l	d0,a4

	tst.l	pr_CLI(a4)
	beq.s	fromWorkbench

* we were called from the CLI
	movem.l	(sp)+,d0/a0		restore regs
	bra	end_startup		and run the user prog

* we were called from the Workbench
fromWorkbench
	lea	pr_MsgPort(a4),a0
	EXECCALL WaitPort		wait for a message
	lea	pr_MsgPort(a4),a0
	EXECCALL GetMsg			then get it
	move.l	d0,returnMsg		save it for later reply

* do some other stuff here RSN like the command line etc
	nop

	movem.l	(sp)+,d0/a0		restore
end_startup
	bsr.s	_main			call our program

* returns to here with exit code in d0
	move.l	d0,-(sp)		save it

	tst.l	returnMsg
	beq.s	exitToDOS		if I was a CLI

	EXECCALL Forbid
	move.l	returnMsg(pc),a1
	EXECCALL ReplyMsg

exitToDOS
	move.l	(sp)+,d0		exit code
	rts

* startup code variable
returnMsg	dc.l	0

* the program starts here
	even

_main	move.l	sp,old_stack

* Try to open Intuition library

	OPENLIB IntName
	move.l  d0,_IntuitionBase
	beq	CleanUp			Intuition library did not open

* Try to open Graphics library

	OPENLIB GFXName
	move.l  d0,_GfxBase
	beq	CleanUp			GFX library did not open

* Try to open Dos library

	OPENLIB DosName
	move.l  d0,_DOSBase
	beq	CleanUp			DOS library did not open

* Try to open ReqTools library

	OPENLIB ReqToolsName
	move.l  d0,_ReqToolsBase
	beq	CleanUp			REQTOOLS library did not open


* 

	move.l	returnMsg,d0
	beq	.clistart

	move.l	d0,a0
	move.l	sm_NumArgs(a0),d0
	beq	.clistart

	move.l	sm_ArgList(a0),a0
	move.l	(a0),d1
	DOSCALL CurrentDir

.clistart

* Alloc Memory for Grid Field

	move.l	#GRIDF_SIZE,d0
	move.l	#MEMF_PUBLIC|MEMF_CLEAR,d1
	EXECCALL AllocMem
	move.l	d0,grid_field
	beq	CleanUp

* Allocate BitMap 1
	move.l	#BM_d,d0		; Allocate a bitmap
	move.l	#BM_x,d1
	move.l	#BM_y,d2
	CALLEXT EG_AllocBitMap
	move.l	d0,bitmap1
	beq	CleanUp

* Allocate BitMap 2
	move.l	#BM_d,d0		; Allocate a bitmap
	move.l	#BM_x,d1
	move.l	#BM_y,d2
	CALLEXT EG_AllocBitMap
	move.l	d0,bitmap2
	beq	CleanUp

* Allocate Bitmap for graphics images
	move.l	#GRAPHICS_d,d0		; Allocate a bitmap
	move.l	#GRAPHICS_x,d1
	move.l	#GRAPHICS_y,d2
	CALLEXT EG_AllocBitMap
	move.l	d0,bitmapg
	beq	CleanUp

* Allocate BitMap 1 For status display
	move.l	#ST_BM_d,d0
	move.l	#ST_BM_x,d1
	move.l	#ST_BM_y,d2
	CALLEXT EG_AllocBitMap
	move.l	d0,st_bitmap1
	beq	CleanUp

* Allocate BitMap 2 status display
	move.l	#ST_BM_d,d0
	move.l	#ST_BM_x,d1
	move.l	#ST_BM_y,d2
	CALLEXT EG_AllocBitMap
	move.l	d0,st_bitmap2
	beq	CleanUp

* Load Images

	lea	graphics_file_name,a0
	move.l	bitmapg,a1
	lea	colors,a2
	CALLEXT GetPicture

* Get a display
	move.l	bitmap1,a0	; allocate a display structure.
	suba.l	a1,a1
	lea	new_disp,a2	; Display Definition
	CALLEXT	GetDisplay
	move.l	d0,display
	beq	CleanUp

* Create additional Viewport for status display
	moveq.l	#32,d0
	GRAFCALL GetColorMap
	move.l	d0,status_color_map
	beq	CleanUp

	lea	status_view_port,a0
	GRAFCALL InitVPort
	lea	status_view_port,a0
	lea	status_rastinfo,a1
	move.l	st_bitmap1,ri_BitMap(a1)
	move.l	a1,vp_RasInfo(a0)
	move.w	#ST_BM_x,vp_DWidth(a0)
	move.w	#ST_BM_y,vp_DHeight(a0)
	move.w	#V_SPRITES,vp_Modes(a0)
	move.l	status_color_map,vp_ColorMap(a0)

	move.l	display,a2
	move.l	dsp_ViewPort(a2),a1	link old Viewport to niew Viewport
	move.l	a1,vp_Next(a0)
	move.l	dsp_View(a2),a1		link new viewport to view
	move.l	a0,v_ViewPort(a1)

* Remember the old view
	move.l	_GfxBase,a0
	move.l	$22(a0),oldview

* Define Colors

	move.l	display,a2		; Load the colors
	move.l	dsp_ViewPort(a2),a0
	lea	colors,a1
	move.l	#32,d0
	GRAFCALL LoadRGB4

	lea	status_view_port,a0
	lea	colors,a1
	move.l	#32,d0
	GRAFCALL LoadRGB4

* Do the graphics stuff
	move.l	display,a2		; Make a copperlist to display view

* scroll zero bitmap 1
	lea	status_view_port,a0
	move.w	#0,vp_DyOffset(a0)
	move.w	#16,vp_DxOffset(a0)

	move.l	dsp_ViewPort(a2),a0	; make room for status display
	move.w	#25,vp_DyOffset(a0)
	move.w	#16,vp_DxOffset(a0)

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list1
	move.l	#0,v_LOFCprList(a0)

* scroll right 8 bitmap 1

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16-8,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list1_right8
	move.l	#0,v_LOFCprList(a0)

* scroll left 8 bitmap 1

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16+8,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list1_left8
	move.l	#0,v_LOFCprList(a0)

* scroll up 8 bitmap 1

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16+8,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list1_up8
	move.l	#0,v_LOFCprList(a0)

* scroll down 8 bitmap 1

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16-8,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list1_down8
	move.l	#0,v_LOFCprList(a0)

* scroll 0 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16,ri_RyOffset(a0)

	move.l	display,a2
	move.l	dsp_RasInfo(a2),a1
	move.l	bitmap2,ri_BitMap(a1)
	lea	status_rastinfo,a1
	move.l	st_bitmap2,ri_BitMap(a1)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2
	move.l	#0,v_LOFCprList(a0)

* scroll right 4 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16-4,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2_right4
	move.l	#0,v_LOFCprList(a0)

* scroll left 4 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16+4,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2_left4
	move.l	#0,v_LOFCprList(a0)

* scroll up 4 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16+4,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2_up4
	move.l	#0,v_LOFCprList(a0)

* scroll down 4 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16-4,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2_down4
	move.l	#0,v_LOFCprList(a0)

* scroll right 12 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+4,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2_right12
	move.l	#0,v_LOFCprList(a0)

* scroll left 12 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16+12,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2_left12
	move.l	#0,v_LOFCprList(a0)

* scroll left 12 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16+12,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2_up12
	move.l	#0,v_LOFCprList(a0)

* scroll down 12 bitmap 2

	move.l	dsp_RasInfo(a2),a0
	move.w	#32+16,ri_RxOffset(a0)	; offset into bitmap
	move.w	#32+16-12,ri_RyOffset(a0)

	bsr	Make_Copper_List

	move.l	dsp_View(a2),a0
	move.l	v_LOFCprList(a0),list2_down12

	jsr	Start_Editor
	move.w	d0,d1
	bne.s	.ono_error
	jsr	Field_Editor
.ono_error
	jsr	Stop_Editor

	move.l	oldview,a1		; Load our original view.
	GRAFCALL LoadView

	move.l	display,a2		; Free Copper list structures.
	move.l	dsp_ViewPort(a2),a0
	GRAFCALL FreeVPortCopLists

	lea	status_view_port,a0
	GRAFCALL FreeVPortCopLists


	move.l	list2_down12,a0
	GRAFCALL FreeCprList
	move.l	list2_up12,a0
	GRAFCALL FreeCprList
	move.l	list2_left12,a0
	GRAFCALL FreeCprList
	move.l	list2_right12,a0
	GRAFCALL FreeCprList

	move.l	list2_down4,a0
	GRAFCALL FreeCprList
	move.l	list2_up4,a0
	GRAFCALL FreeCprList
	move.l	list2_left4,a0
	GRAFCALL FreeCprList
	move.l	list2_right4,a0
	GRAFCALL FreeCprList

	move.l	list2,a0
	GRAFCALL FreeCprList

	move.l	list1_down8,a0
	GRAFCALL FreeCprList
	move.l	list1_up8,a0
	GRAFCALL FreeCprList
	move.l	list1_left8,a0
	GRAFCALL FreeCprList
	move.l	list1_right8,a0
	GRAFCALL FreeCprList

	move.l	list1,a0
	GRAFCALL FreeCprList

CleanUp
	move.l	status_color_map,d0
	beq	.ll3
	move.l	d0,a0
	GRAFCALL FreeColorMap

.ll3	move.l	grid_field,d0
	beq.s	.ll4
	move.l	d0,a1
	move.l	#GRIDF_SIZE,d0
	EXECCALL FreeMem

.ll4	move.l	display,d0	; Free our display structure.
	beq	.ll601
	move.l	d0,a0
	CALLEXT	FreeDisplay

.ll601
	move.l	st_bitmap2,d0
	beq.s	.ll602
	move.l	d0,a0
	CALLEXT EG_FreeBitMap

.ll602
	move.l	st_bitmap1,d0
	beq.s	.ll6
	move.l	d0,a0
	CALLEXT EG_FreeBitMap

.ll6	move.l	bitmapg,d0
	beq.s	.ll62
	move.l	d0,a0
	CALLEXT EG_FreeBitMap

.ll62	move.l	bitmap2,d0
	beq.s	.ll7
	move.l	d0,a0
	CALLEXT EG_FreeBitMap

.ll7	move.l	bitmap1,d0
	beq.s	.ll83
	move.l	d0,a0
	CALLEXT EG_FreeBitMap

.ll83	move.l	_ReqToolsBase,d0
	beq.s	.ll82
	CLOSELIB _ReqToolsBase

.ll82	move.l	_DOSBase,d0
	beq.s	.ll81
	CLOSELIB _DOSBase

.ll81	move.l	_GfxBase,d0
	beq.s	.ll80
	CLOSELIB _GfxBase

.ll80	move.l	_IntuitionBase,d0
	beq	.ll8
	CLOSELIB _IntuitionBase

.ll8

.ll9	move.l	old_stack,sp
	rts

*****************************************

Make_Copper_List
	move.l	dsp_View(a2),a0
	lea	status_view_port,a1
	GRAFCALL MakeVPort
	move.l	dsp_View(a2),a0
	move.l	dsp_ViewPort(a2),a1
	GRAFCALL MakeVPort
	move.l	dsp_View(a2),a1
	GRAFCALL MrgCop
	rts






******************************************

grid_field	dc.l	0

_ExtGfxBase	dc.l	0
_IntuitionBase	dc.l	0
_GfxBase	dc.l	0
_DOSBase	dc.l	0
_ReqToolsBase	dc.l	0
old_stack	dc.l	0
st_bitmap1	dc.l	0	Bitmap for status display
st_bitmap2	dc.l	0	Bitmap for status display
bitmap1		dc.l	0	*BitMap Display 1
bitmap2		dc.l	0	*BitMap Display 2
bitmapg		dc.l	0	*BitMap graphics images
display		dc.l	0
oldview		dc.l	0
status_color_map	dc.l	0

list1		dc.l	0	*CopperList display 1
list2		dc.l	0	*CopperList display 2

list2_right4	dc.l	0
list1_right8	dc.l	0
list2_right12	dc.l	0

list2_left4	dc.l	0
list1_left8	dc.l	0
list2_left12	dc.l	0

list2_down4	dc.l	0
list1_down8	dc.l	0
list2_down12	dc.l	0

list2_up4	dc.l	0
list1_up8	dc.l	0
list2_up12	dc.l	0

bd_ColorMap	dc.l	0

new_disp	dc.w	D_x
		dc.w	D_y
		dc.w	V_SPRITES

status_view_port
		ds.b	vp_SIZEOF
		even
status_rastinfo
		ds.b	ri_SIZEOF

colors		dc.w	$000,$555 ; col 0 & 1
		dc.w	$f20,$5c3 ; col 2 & 3
		dc.w	$fe0,$13d ; col 4 & 5
		dc.w	$333,$999 ; col 6 & 7
		dc.w	$000,$000 ; col 8 & 9
		dc.w	$000,$000 ; col 10 & 11
		dc.w	$000,$000 ; col 12 & 13
		dc.w	$000,$000 ; col 14 & 15
		dc.w	$000,$ddd ; col 16 & 17 sp0&1
		dc.w	$cbb,$ba9 ; col 18 & 19
		dc.w	$987,$875 ; col 20 & 21 sp2&3
		dc.w	$764,$743 ; col 22 & 23
		dc.w	$f60,$d20 ; col 24 & 25 sp4&5
		dc.w	$fe0,$b00 ; col 26 & 27
		dc.w	$0d0,$0cc ; col 28 & 29 sp6&7
		dc.w	$06f,$00a ; col 30 & 31

IntName		dc.b	'intuition.library',0
		even
ReqToolsName	REQTOOLSNAME
		even
DosName		DOSNAME
		even
GFXName		GRAPHICSNAME
		even

graphics_file_name	dc.b	'boulders',0

