	opt	L+
	opt	O2+
	opt	OW-

*==========================================
*
* File:        editor.s
* Version:     1
* Revision:    0
* Created:     27-VIII-1993
* By:          FNC Slothouber
* Last Update: 25-Aug-1995
* By:          FNC Slothouber
*
*==========================================

	incdir	"include:"

	include graphics/graphics_lib.i
	include	graphics/view.i
	include	exec/exec_lib.i
	include exec/memory.i
	include exec/nodes.i
	include exec/interrupts.i
	include	libraries/dos_lib.i
	include	libraries/dos.i
	include	ExtGfx.i
	include	reqtools/reqtools_lib.i
	include reqtools/reqtools.i
	include	intuition/intuition_lib.i
	include	intuition/intuition.i
	include	execmacros.i
	include	boulderdash.i

	XDEF	Start_Editor
	XDEF	Stop_Editor
	XDEF	Field_Editor
	XDEF	BD_window

	XREF	_ExtGfxBase
	XREF	_IntuitionBase
	XREF	_GfxBase
	XREF	_ReqToolsBase
	XREF	_DOSBase
	XREF	bitmap1
	XREF	bitmapg
	XREF	colors
	XREF	Editor_Animate
	XREF	grid_field
	XREF	test_field
	XREF	Play
	XREF	Editor_Draw_One_Object 
	XREF	integer_time
	XREF	integer_target
	XREF	integer_score

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


GADGET_OFFSET	equ	12
GAME_FILE_SIZE	equ	GRIDF_HEIGHT*GRIDF_WIDTH+4+4+2+2

*
* Start_Editor - Open Screen and window for the editor
*
*

Start_Editor
	lea	BD_newscreen,a0
	move.l	bitmap1,ns_CustomBitMap(a0)
	INTCALL	OpenScreen
	move.l	d0,BD_screen
	beq	.error
	lea	BD_newwindow,a0
	move.l	d0,nw_Screen(a0)
	INTCALL	OpenWindow
	move.l	d0,BD_window
	beq	.error

* Set Colors
	lea	colors,a2
	moveq	#NUM_COLORS-1,d4
	moveq	#0,d5
.loop1
	move.l	d5,d0
	addq.l	#1,d5
	moveq	#0,d1
	move.w	(a2)+,d1	Get RGB value
	move.l	d1,d2		copy G to d2
	move.l	d1,d3		copy B to d3
	lsr.w	#8,d1		Get them in the right place
	lsr.w	#4,d2
        and.w   #$F,d1
	and.w	#$F,d2
	and.w	#$F,d3
	move.l	BD_screen,a0
	add.l	#sc_ViewPort,a0
	GRAFCALL SetRGB4
	dbra	d4,.loop1
	bsr	Display_Gadgets_Images

* Init Menus

	move.l	BD_window,a0
	lea	menu1,a1
	INTCALL	SetMenuStrip

* Allocate File Requesters
* PLAY
	move.l	#RT_FILEREQ,d0
	sub.l	a0,a0
	CALLREQT rtAllocRequestA
	move.l	d0,play_file_requester
	beq	.error
	lea	play_dir_tags,a0
	move.l	play_file_requester,a1
	CALLREQT rtChangeReqAttrA
* LOAD SAVE
	move.l	#RT_FILEREQ,d0
	sub.l	a0,a0
	CALLREQT rtAllocRequestA
	move.l	d0,loadsave_file_requester
	beq	.error
	lea	wild_tags,a0
	move.l	loadsave_file_requester,a1
	CALLREQT rtChangeReqAttrA

	moveq	#0,d0
	bra	.exit
.error	moveq	#-1,d0
.exit	rts


*
* Display_Gadgets_Images - Copy gadget graphics from graphics bitmap to
*                          screen bitmap.
*


Display_Gadgets_Images
	move.l	bitmap1,a0
	CALLEXT ClearBitMap

	move.l	bitmapg,a0
	add.l	#bm_Planes,a0
	move.l	bitmap1,a1
	add.l	#bm_Planes,a1

	move.w	#BM_d-1,d0
.loop1	move.l	(a0)+,a2		Source
	move.l	(a1)+,a3		Dest
	add.l	#IM_GADGETS,a2
	add.l	#GADGET_OFFSET*(BM_x/8),a3	make room for screen title bar
	move.w	#32-1,d1
.loop2	move.w	#(BD_SCREEN_x/16)-1,d2
.loop3	move.w	(a2)+,(a3)+
	dbra	d2,.loop3
	add.l	#(BM_x-GRAPHICS_x)/8,a3
	dbra	d1,.loop2
	dbra	d0,.loop1

	move.l	BD_screen,a0
	moveq	#-1,d0
	INTCALL ShowTitle

	rts

*
* Stop_Editor - Close Screen and Window
*
*

Stop_Editor
	move.l	loadsave_file_requester,d0
	beq	.ll4
	move.l	d0,a1
	CALLREQT rtFreeRequest
.ll4
	move.l	play_file_requester,d0
	beq	.ll3
	move.l	d0,a1
	CALLREQT rtFreeRequest
.ll3
	move.l	BD_window,d0
	beq	.ll2
	move.l	d0,a0
	INTCALL	ClearMenuStrip
	move.l	BD_window,a0
	INTCALL	CloseWindow
.ll2
	move.l	BD_screen,d0
	beq	.ll1
	move.l	d0,a0
	INTCALL	CloseScreen
.ll1	rts


*
* Field_Editor -
*
*
*
*

Field_Editor ; ()
	move.l	a7,editor_break

* Intialize some constants
	move.w	#FALSE,flag_work_dirty

	lea	target_data,a1
	move.l	#100,(a1)
	lea	time_data,a1
	move.l	#5000,(a1)

	lea	play_filename,a0
	move.b	#0,(a0)
	lea	filename,a0
	move.b	#0,(a0)

* Create Grid Field
	move.l	grid_field,a0
	lea	test_field,a1
	bsr	Init_Grid_Field

	move.l	#2*grid_sizeof,screen_x
	move.l	#2*grid_sizeof*GRIDF_WIDTH,screen_y

	move.w	#0,ted_x
	move.w	#0,ted_y

* Show Grid Field
	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate

* Set Current Object
	move.w	#TRANS_NONE,CObject_trans
	move.w	#DRAW_ROCK,CObject_draw
	move.w	#G_ROCK,CObject_type

* Wait for a message to arrive
.wait	move.l	BD_window,a0
	move.l	wd_UserPort(a0),a0
	moveq	#0,d1
	move.b	MP_SIGBIT(a0),d1
	moveq	#1,d0
	lsl.l	d1,d0
	EXECCALL Wait

* One or more messages have arrived. Respond to them
.resp	move.l	BD_window,a0
	move.l	wd_UserPort(a0),a0
	EXECCALL GetMsg
	move.l	d0,a1
	move.l	d0,d1
	beq	.wait

	move.l	im_Class(a1),bd_ms_class
	move.w	im_Code(a1),bd_ms_code
	move.l	im_IAddress(a1),bd_ms_iaddress
	move.w	im_MouseX(a1),bd_ms_mousex
	move.w	im_MouseY(a1),bd_ms_mousey

	EXECCALL ReplyMsg

	move.l	bd_ms_class,d0

* User selected a gadget ?
	cmp.l	#GADGETUP,d0
	bne.s	.pos2

	move.l	bd_ms_iaddress,a0
	moveq	#0,d0
	move.w	gg_GadgetID(a0),d0
	pea	.next
	bra	gad_table_access

* User Pressed a mouse button ?
.pos2	cmp.l	#MOUSEBUTTONS,d0
	bne.s	.pos3
	bsr	proc_mouse

* User Pressed a Key
.pos3	cmp.l	#RAWKEY,d0
	bne	.pos4
	move.w	bd_ms_code,d0
	cmp.w	#$4c,d0			Cursor Up
	bne.s	.key2
	bsr	gadget_up
	bra	.next
.key2	cmp.w	#$4d,d0			Cursor Down
	bne.s	.key3
	bsr	gadget_down
	bra	.next
.key3	cmp.w	#$4f,d0			Cursor Left
	bne.s	.key4
	bsr	gadget_left
	bra	.next
.key4	cmp.w	#$4e,d0			Cursor Right
	bne.s	.key5
	bsr	gadget_right
	bra	.next
.key5	cmp.w	#$14,d0			T
	bne.s	.key6
	bsr	gadget_test
	bra	.next
.key6	cmp.w	#$19,d0			P
	bne.s	.key7
	bsr	gadget_play
	bra	.next
.key7	cmp.w	#$10,d0			Q
	bne.s	.key8
	bsr	gadget_quit
	bra	.next
.key8	cmp.w	#$5f,d0			Help Key
	bne	.next
	bsr	gadget_help
	bra	.next

* User selected a menu Item ?
.pos4	cmp.l	#MENUPICK,d0
	bne	.pos5
	move.w	bd_ms_code,d0
	move.w	d0,d1
	and.w	#%11111,d0
	lsr.w	#5,d1
	and.w	#%111111,d1
* Project Menu ?
	cmp.w	#MENUProject,d0
	bne.s	.men2
	cmp.w	#ITEMOpen,d1
	bne.s	.item11
	bsr	gadget_load
	bra	.next
.item11	cmp.w	#ITEMClear,d1
	bne.s	.item12
	bsr	gadget_clr
	bra	.next
.item12	cmp.w	#ITEMSave,d1
	bne.s	.item13
	bsr	gadget_save
	bra	.next
.item13	cmp.w	#ITEMQuit,d1
	bne.s	.item14
	bsr	gadget_quit
	bra	.next
.item14	cmp.w	#ITEMHelp,d1
	bne.s	.next
	bsr	gadget_help
	bra	.next
* Game Menu ?
.men2	cmp.w	#MENUGame,d0
	bne.s	.next
.item21	cmp.w	#ITEMPlay,d1
	bne.s	.item22
	bsr	gadget_play
	bra	.next
.item22	cmp.w	#ITEMTest,d1
	bne.s	.item23
	bsr	gadget_test
	bra	.next
.item23	cmp.w	#ITEMTime,d1
	bne.s	.item24
	bsr	gadget_time
	bra	.next
.item24	cmp.w	#ITEMTarget,d1
	bne.s	.next
	bsr	gadget_target
	bra	.next
.pos5	nop
.next	bra	.resp


******************
*** Jump Table ***
******************
gad_table_access
	jmp	gadtabel(pc,d0)
gadtabel
	jmp	gadget_diamond		current object = diamond
	jmp	gadget_ted		current object = ted
	jmp	gadget_brick		current object = brick
	jmp	gadget_border			""
	jmp	gadget_mover			""
	jmp	gadget_rock			""
	jmp	gadget_dirt			""
	jmp	gadget_empty			""
	jmp	gadget_butterfly		""
	jmp	gadget_fungis			""
	jmp	gadget_fast_left
	jmp	gadget_fast_right
	jmp	gadget_fast_up
	jmp	gadget_fast_down
	jmp	gadget_left
	jmp	gadget_right
	jmp	gadget_up
	jmp	gadget_down
	jmp	gadget_play
	jmp	gadget_test
	jmp	gadget_load
	jmp	gadget_save
	jmp	gadget_clr
	jmp	gadget_quit
	jmp	gadget_time
	jmp	gadget_target
	jmp	gadget_help
	jmp	gadget_exit
	jmp	gadget_dummy			for safety
	jmp	gadget_dummy
	jmp	gadget_dummy
	jmp	gadget_dummy


*
* gadget_diamond
*
*

gadget_diamond
	move.w	#DRAW_DIAMOND,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_DIAMOND,CObject_type
	rts

*
* gadget_ted
*
*

gadget_ted
	move.w	#DRAW_TED,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_TED,CObject_type
	rts

*
* gadget_brick
*
*

gadget_brick
	move.w	#DRAW_BRICK,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_BRICK,CObject_type
	rts

*
* gadget_border
*
*

gadget_border
	move.w	#DRAW_BORDER,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_BORDER,CObject_type
	rts

*
* gadget_mover
*
*

gadget_mover
	move.w	#DRAW_MOVER,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_MOVER,CObject_type
	rts

*
* gadget_rock
*
*

gadget_rock
	move.w	#DRAW_ROCK,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_ROCK,CObject_type
	rts

*
* gadget_dirt
*
*

gadget_dirt
	move.w	#DRAW_DIRT,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_DIRT,CObject_type
	rts

*
* gadget_empty
*
*

gadget_empty
	move.w	#DRAW_EMPTY,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_EMPTY,CObject_type
	rts

*
* gadget_butterfly
*
*

gadget_butterfly
	move.w	#DRAW_BUTTERFLY,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_BUTTERFLY,CObject_type
	rts

*
* gadget_fungis
*
*

gadget_fungis
	move.w	#DRAW_FUNGIS,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_FUNGIS,CObject_type
	rts

*
* gadget_exit
*
*

gadget_exit
	move.w	#DRAW_EXIT,CObject_draw
	move.w	#TRANS_NONE,CObject_trans
	move.w	#G_EXIT,CObject_type
	rts


*
* gadget_fast_left
*
*

gadget_fast_left
	move.l	#EDIT_SCROLL_LEFT_MAX,d0
	move.l	d0,screen_x

	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate
	rts

*
* gadget_fast_right
*
*

gadget_fast_right
	move.l	#EDIT_SCROLL_RIGHT_MAX,d0
	move.l	d0,screen_x
	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate
	rts

*
* gadget_fast_up
*
*

gadget_fast_up
	move.l	#EDIT_SCROLL_UP_MAX,d0
	move.l	d0,screen_y
	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate
	rts

*
* gadget_fast_down
*
*

gadget_fast_down
	move.l	#EDIT_SCROLL_DOWN_MAX,d0
	move.l	d0,screen_y
	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate
	rts

*
* gadget_left
*
*

gadget_left
	move.l	screen_x,d0
	cmp.l	#EDIT_SCROLL_LEFT_MAX,d0
	beq	.exit
	subq.l	#grid_sizeof,d0
	move.l	d0,screen_x

	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate
.exit	rts

*
* gadget_right
*
*

gadget_right
	move.l	screen_x,d0
	cmp.l	#EDIT_SCROLL_RIGHT_MAX,d0
	beq	.exit
	addq.l	#grid_sizeof,d0
	move.l	d0,screen_x

	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate
.exit	rts

*
* gadget_up
*
*

gadget_up
	move.l	screen_y,d0
	cmp.l	#EDIT_SCROLL_UP_MAX,d0
	beq	.exit
	sub.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,screen_y

	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate

.exit	rts

*
* gadget_down
*
*

gadget_down
	move.l	screen_y,d0
	cmp.l	#EDIT_SCROLL_DOWN_MAX,d0
	beq	.exit
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,screen_y

	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate
.exit	rts

*
* gadget_play
*
*

gadget_play

* Store Current Grid Field in a temporary File
	lea	temp_file_name,a2
	bsr	Save_Field

* Let The User Select A Game Field

.load	lea	play_tags,a0
	move.l	BD_window,ti_Data(a0)
	move.l	play_file_requester,a1
	lea	play_filename,a2
	lea	play_title,a3
	CALLREQT rtFileRequestA
	move.l	d0,d0
	beq	.no_file

	lea	play_filename,a0
	lea	completename,a1
	move.l	play_file_requester,a2
	bsr	Make_File_Name
	lea	completename,a2
	bsr	Load_Field
	move.l	d0,d0
	bne	.load

* Remember Our screen view
	move.l	_GfxBase,a0
	move.l	$22(a0),edit_view

	move.l	time_data,d0
	move.l	target_data,d1
	move.w	ted_x,d2
	move.w	ted_y,d3
	jsr	Play

* Load Old Grid Field
	lea	temp_file_name,a2
	bsr	Load_Field

* Restore Screen
	bsr	Display_Gadgets_Images

* Restore Editor Settings
	move.l	#2*grid_sizeof,screen_x
	move.l	#2*grid_sizeof*GRIDF_WIDTH,screen_y

	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate

* Display Screen
	move.l	edit_view,a1		; Load our original view.
	GRAFCALL LoadView

	lea	score_tags,a0
	move.l	BD_window,ti_Data(a0)
	lea	score_bodyfmt,a1
	lea	score_gadfmt,a2
	sub.l	a3,a3
	lea	score_args,a4
	move.w	integer_score,(a4)
	move.w	integer_target,2(a4)
	move.w	integer_time,4(a4)
	CALLREQT rtEZRequestA

.no_file
.exit	rts


*
* gadget_test
*
*

gadget_test
	move.l	_GfxBase,a0
	move.l	$22(a0),edit_view

* Save Current Game Field to a temporary file.
	lea	temp_file_name,a2
	bsr	Save_Field

	move.l	time_data,d0
	move.l	target_data,d1
	move.w	ted_x,d2
	move.w	ted_y,d3
	jsr	Play

* Restore Game Field.
	lea	temp_file_name,a2
	bsr	Load_Field

	bsr	Display_Gadgets_Images

	move.l	#2*grid_sizeof,screen_x
	move.l	#2*grid_sizeof*GRIDF_WIDTH,screen_y

	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate

	move.l	edit_view,a1		; Load our original view.
	GRAFCALL LoadView

	rts

*
*
* gadget_load
*
*

gadget_load
	move.w	flag_work_dirty,d0
	beq	.load
	lea	sw_tags,a0
	move.l	BD_window,ti_Data(a0)
	lea	sw_bodyfmt,a1
	lea	sw_gadfmt,a2
	sub.l	a3,a3
	sub.l	a4,a4
	CALLREQT rtEZRequestA
	move.l	d0,d7
	beq	.load
	bsr	gadget_save

.load	lea	load_tags,a0
	move.l	BD_window,ti_Data(a0)
	move.l	loadsave_file_requester,a1
	lea	filename,a2
	lea	load_title,a3
	CALLREQT rtFileRequestA
	move.l	d0,d0
	beq	.no_file

	move.w	#FALSE,flag_work_dirty

	lea	filename,a0
	lea	completename,a1
	move.l	loadsave_file_requester,a2
	bsr	Make_File_Name
	lea	completename,a2
	bsr	Load_Field
	move.l	d0,d0
	bne	.load

* Show Grid Field
	move.l	#2*grid_sizeof,screen_x
	move.l	#2*grid_sizeof*GRIDF_WIDTH,screen_y

	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate

.no_file
.exit	rts

*
*
* gadget_save
*
*

gadget_save
	lea	save_tags,a0
	move.l	BD_window,ti_Data(a0)
	move.l	loadsave_file_requester,a1
	lea	filename,a2
	lea	save_title,a3
	CALLREQT rtFileRequestA
	move.l	d0,d0
	beq	.no_file

	move.w	#FALSE,flag_work_dirty

	lea	filename,a0
	lea	completename,a1
	move.l	loadsave_file_requester,a2
	bsr	Make_File_Name
	lea	completename,a2
	bsr	Save_Field

.no_file
.exit	rts

*
*
* gadget_clr
*
*

gadget_clr
	move.w	flag_work_dirty,d0
	beq	.clear
	lea	clr_tags,a0
	move.l	BD_window,ti_Data(a0)
	lea	clr_bodyfmt,a1
	lea	clr_gadfmt,a2
	sub.l	a3,a3
	sub.l	a4,a4
	CALLREQT rtEZRequestA
	move.l	d0,d7
	beq	.exit

* Restore Editor Settings
.clear	move.w	#FALSE,flag_work_dirty

	lea	filename,a0
	move.b	#0,(a0)

* Clear Grid Field
	move.l	grid_field,a0
	lea	test_field,a1
	bsr	Init_Grid_Field

* Reset Cursor
	move.l	#2*grid_sizeof,screen_x
	move.l	#2*grid_sizeof*GRIDF_WIDTH,screen_y
	move.w	#0,ted_x
	move.w	#0,ted_y

* Show Grid Field
	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate
.exit	rts

*
* gadget_quit
*
*

gadget_quit
	move.w	flag_work_dirty,d0
	beq	.quit
	lea	sw_tags,a0
	move.l	BD_window,ti_Data(a0)
	lea	sw_bodyfmt,a1
	lea	sw_gadfmt,a2
	sub.l	a3,a3
	sub.l	a4,a4
	CALLREQT rtEZRequestA
	move.l	d0,d7
	beq	.quit
	bsr	gadget_save
.quit	move.l	editor_break,a7
.exit	rts


*
* gadget_time
*
*

gadget_time
	lea	time_tags,a0
	move.l	BD_window,ti_Data(a0)
	lea	time_data,a1
	lea	time_title,a2
	sub.l	a3,a3
	CALLREQT rtGetLongA
	rts

*
* gadget_target
*
*

gadget_target
	lea	target_tags,a0
	move.l	BD_window,ti_Data(a0)
	lea	target_data,a1
	lea	target_title,a2
	sub.l	a3,a3
	CALLREQT rtGetLongA
	rts

*
* gadget_help
*
*

gadget_help
*	lea	help_tags,a0
*	move.l	BD_window,ti_Data(a0)
	sub.l	a0,a0
	lea	help_bodyfmt,a1
	lea	help_gadfmt,a2
	sub.l	a3,a3
	sub.l	a4,a4
	CALLREQT rtEZRequestA
	rts


gadget_dummy
	rts

***

*
* Panic - Inform User That Something Went Wrong
*
*

Panic ; ()

	lea	panic_tags,a0
	move.l	BD_window,ti_Data(a0)
	lea	panic_bodyfmt,a1
	lea	panic_gadfmt,a2
	sub.l	a3,a3
	sub.l	a4,a4
	CALLREQT rtEZRequestA
	rts


*
* Panic2 - Inform User That Something Went Wrong
*
*

Panic2 ; ()

	lea	panic2_tags,a0
	move.l	BD_window,ti_Data(a0)
	lea	panic2_bodyfmt,a1
	lea	panic2_gadfmt,a2
	sub.l	a3,a3
	sub.l	a4,a4
	CALLREQT rtEZRequestA
	rts


*
* Make_File_Name - Join Filename and Directory name
*
*

Make_File_Name ; (FileName,CompleteName,File_Requester),a0,a1,a2

	move.l	rtfi_Dir(a2),a2
.loop1
	move.b	(a2)+,d0
	beq.s	.ex1
	move.b	d0,(a1)+
	bra.s	.loop1
.ex1	cmp.b	#':',-1(a1)
	beq.s	.ok
	cmp.b	#'/',-1(a1)
	beq.s	.ok
	move.b	#'/',(a1)+
.ok	move.b	(a0)+,d0
	move.b	d0,(a1)+
	bne.s	.ok

	cmp.b	#'d',-2(a1)
	bne.s	.add_bd
	cmp.b	#'b',-3(a1)
	bne.s	.add_bd
	cmp.b	#'.',-4(a1)
	beq.s	.exit
.add_bd	subq.l	#1,a1
	move.b	#'.',(a1)+
	move.b	#'b',(a1)+
	move.b	#'d',(a1)+
	move.b	#0,(a1)
.exit	rts


*
* Save_Field
*
*
*

Save_Field ; (Filename),a2

	move.l	#GAME_FILE_SIZE,d0
	move.l	#MEMF_PUBLIC|MEMF_CLEAR,d1
	EXECCALL AllocMem
	move.l	d0,compact_field
	bne.s	.ok0
	bsr	Panic2
	bra	.exit

.ok0	move.l	d0,a0
	move.l	time_data,(a0)+
	move.l	target_data,(a0)+
	move.w	ted_x,(a0)+
	move.w	ted_y,(a0)+
	move.l	grid_field,a1
	moveq	#GRIDF_HEIGHT-1,d0
.loop1	moveq	#GRIDF_WIDTH-1,d1
.loop2	move.w	grid_type(a1),d2
	move.b	d2,(a0)+
	addq.l	#grid_sizeof,a1
	dbra	d1,.loop2
	dbra	d0,.loop1

	move.l	a2,d1
	move.l	#MODE_NEWFILE,d2
	DOSCALL	Open
	move.l	d0,filehandle
	bne	.ok1
	bsr	Panic
	bra	.cleanup1

.ok1	move.l	filehandle,d1
	move.l	compact_field,d2
	move.l	#GAME_FILE_SIZE,d3
	DOSCALL	Write
	cmp.l	#-1,d0
	bne.s	.cleanup2
	bsr	Panic
.cleanup2
	move.l	compact_field,a1
	move.l	#GAME_FILE_SIZE,d0
	EXECCALL FreeMem
.cleanup1
	move.l	filehandle,d1
	DOSCALL Close
.exit	rts


*
* Load_Field
*
*
*

Load_Field ; (Filename),a2  -> (Error),d0

	moveq	#0,d7
	move.l	#GAME_FILE_SIZE,d0
	move.l	#MEMF_PUBLIC|MEMF_CLEAR,d1
	EXECCALL AllocMem
	move.l	d0,compact_field
	bne	.ok0
	bsr	Panic2
	moveq	#-1,d7
	bra	.exit
.ok0
	move.l	a2,d1
	move.l	#MODE_OLDFILE,d2
	DOSCALL	Open
	move.l	d0,filehandle
	bne.s	.ok1
	moveq	#-1,d7
	bsr	Panic
	bra	.cleanup1

.ok1	move.l	filehandle,d1
	move.l	compact_field,d2
	move.l	#GAME_FILE_SIZE,d3
	DOSCALL	Read
	cmp.l	#-1,d0
	bne.s	.ok2
	moveq	#-1,d7
	bsr	Panic
	bra	.cleanup2

.ok2
* Convert File into Grid Field and read game time and target and ted coords
	move.l	grid_field,a0
	move.l	compact_field,a1
	move.l	(a1)+,time_data
	move.l	(a1)+,target_data
	move.w	(a1)+,ted_x
	move.w	(a1)+,ted_y
	bsr	Init_Grid_Field

.cleanup2
	move.l	compact_field,a1
	move.l	#GAME_FILE_SIZE,d0
	EXECCALL FreeMem
.cleanup1
	move.l	filehandle,d1
	DOSCALL Close
.exit	move.l	d7,d0
	rts

*
* proc_mouse - Draw grid object at current mouse position
*
*
*

proc_mouse ; ()


* Is it a Legal Position.
	moveq	#0,d0
	moveq	#0,d1
	move.w	bd_ms_mousex,d0
	move.w	bd_ms_mousey,d1
	lsr.l	#4,d0
	sub.l	#32+16,d1
	bmi	.exit
	lsr.l	#4,d1
	mulu	#grid_sizeof,d0
	mulu	#grid_sizeof*GRIDF_WIDTH,d1
	add.l	screen_x,d0
* Make sure the position is not on a border element. 
	cmp.l	#3*grid_sizeof,d0
	blo	.exit
	cmp.l	#(GRIDF_WIDTH-3)*grid_sizeof,d0
	bhs	.exit
	add.l	d1,d0
	add.l	screen_y,d0
	cmp.l	#3*grid_sizeof*GRIDF_WIDTH,d0
	bls	.exit
	cmp.l	#(GRIDF_HEIGHT-3)*grid_sizeof*GRIDF_WIDTH,d0
	bhs	.exit

	move.w	#TRUE,flag_work_dirty

* Is It A Ted ?
	cmp.w	#G_TED,CObject_type
	bne	.noted

* Remove Old Ted
	moveq	#0,d0
	moveq	#0,d1
	move.w	ted_x,d0
	move.w	ted_y,d1
	addq.w	#3,d0
	addq.w	#3,d1
	mulu	#grid_sizeof,d0
	mulu	#grid_sizeof*GRIDF_WIDTH,d1
	add.l	d0,d1
	move.l	grid_field,a0
	add.l	d1,a0
	move.w	#DRAW_DIRT,grid_draw(a0)
	move.w	#G_DIRT,grid_type(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.b	#2,grid_dirty(a0)
	move.b	#0,grid_data(a0)

* Redraw Screen
	move.l	grid_field,a2
	add.l	screen_x,a2
	add.l	screen_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	jsr	Editor_Animate

* Calc Pos New Ted
	moveq	#0,d0
	moveq	#0,d1
	move.w	bd_ms_mousex,d0
	move.w	bd_ms_mousey,d1
	lsr.l	#4,d0
	sub.l	#32+16,d1
	lsr.l	#4,d1
	subq	#1,d0
	subq	#1,d1
	move.l	screen_x,d2
	divu	#grid_sizeof,d2
	subq.w	#2,d2
	add.w	d2,d0
	move.l	screen_y,d2
	divu	#grid_sizeof*GRIDF_WIDTH,d2
	subq.w	#2,d2
	add.w	d2,d1
	move.w	d0,ted_x
	move.w	d1,ted_y

* Put New Object In Grid Field
* Calc Position
.noted	moveq	#0,d0
	moveq	#0,d1
	move.w	bd_ms_mousex,d0
	move.w	bd_ms_mousey,d1
	lsr.l	#4,d0
	sub.l	#32+16,d1
	lsr.l	#4,d1
	mulu	#grid_sizeof,d0
	mulu	#grid_sizeof*GRIDF_WIDTH,d1
	add.l	screen_x,d0
	add.l	d1,d0
	add.l	screen_y,d0

* Put it in the grid_field
	move.l	grid_field,a0
* Is the User Trying to Kill Ted ?
	cmp.w	#G_TED,grid_type(a0,d0)
	bne.s	.nopp
	cmp.w	#G_TED,CObject_type
	bne.s	.exit
.nopp	move.w	CObject_draw,grid_draw(a0,d0)
	move.w	CObject_type,grid_type(a0,d0)
	move.w	CObject_trans,grid_trans(a0,d0)
	move.b	#2,grid_dirty(a0,d0)
	move.b	#0,grid_data(a0,d0)

* Display New Object
	moveq	#0,d0
	moveq	#0,d1
	move.w	bd_ms_mousex,d0
	move.w	bd_ms_mousey,d1
	lsr.l	#4,d0			x=x/16
	lsl.l	#1,d0			x=x*2
	and.w	#$FFF0,d1		y=(y div 16)*16
	mulu	#BM_width,d1
	add.l	d1,d0
	move.l	d0,d2

	moveq	#0,d1
	move.w	CObject_draw,d1

	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Editor_Draw_One_Object

.exit	rts


*
* Init_Grid_Field - Convert a compact field to a grid field.
*
*   A0 - a pointer to the grid field
*   A1 - a pointer to a compact field
*

Init_Grid_Field ; (grid_field,compact_field),A0, A1

	move.w	#NUMBER_OF_GRIDS-1,d0
.ll1
	moveq	#0,d1
	move.b	(a1)+,d1
	cmp.b	#G_BORDER,d1
	bne.s	.pos2
	move.w	#DRAW_BORDER,(a0)+		drawing procedure
	move.w	#TRANS_NONE,(a0)+		transition procedure
	move.w	#G_BORDER,(a0)+			type
	move.b	#2,(a0)+			dirty code
	move.b	#0,(a0)+			data
	bra	.next
.pos2	cmp.b	#G_EMPTY,d1
	bne.s	.pos3
	move.w	#DRAW_EMPTY,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#EMPTY_REAL_EMPTY,(a0)+
	bra	.next
.pos3	cmp.b	#G_DIRT,d1
	bne.s	.pos4
	move.w	#DRAW_DIRT,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#0,(a0)+
	bra	.next
.pos4	cmp.b	#G_ROCK,d1
	bne.s	.pos5
	move.w	#DRAW_ROCK,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#ROCK_STEADY,(a0)+
	bra	.next
.pos5	cmp.b	#G_DIAMOND,d1
	bne.s	.pos6
	move.w	#DRAW_DIAMOND,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#0,(a0)+
	bra	.next
.pos6	cmp.b	#G_BUTTERFLY,d1
	bne.s	.pos7
	move.w	#DRAW_BUTTERFLY,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#MOVING_UP,(a0)+
	bra	.next
.pos7	cmp.b	#G_BRICK,d1
	bne.s	.pos8
	move.w	#DRAW_BRICK,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#0,(a0)+
	bra	.next
.pos8	cmp.b	#G_FUNGIS,d1
	bne.s	.pos9
	move.w	#DRAW_FUNGIS,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#0,(a0)+
	bra	.next
.pos9	cmp.b	#G_MOVER,d1
	bne.s	.pos10
	move.w	#DRAW_MOVER,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#MOVING_UP,(a0)+
	bra	.next
.pos10	cmp.b	#G_TED,d1
	bne.s	.pos11
	move.w	#DRAW_TED,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#MOVING_UP,(a0)+
	bra	.next
.pos11	cmp.b	#G_EXIT,d1
	bne.s	.pos12
	move.w	#DRAW_EXIT,(a0)+
	move.w	#TRANS_NONE,(a0)+
	move.w	d1,(a0)+
	move.b	#2,(a0)+
	move.b	#0,(a0)+
	bra	.next
.pos12	nop
.next	dbra	d0,.ll1
	rts


**********************************************************

editor_break	dc.l	0
edit_view	dc.l	0
screen_x	dc.l	0
screen_y	dc.l	0
ted_x		dc.w	0
ted_y		dc.w	0


compact_field	dc.l	0
filehandle	dc.l	0

* Current Object to Draw in Grid
CObject_trans	dc.w	0
CObject_draw	dc.w	0
CObject_type	dc.w	0
		even

* Message Buffer
bd_ms_class	dc.l	0
bd_ms_code	dc.w	0
bd_ms_iaddress	dc.l	0
bd_ms_mousex	dc.w	0
bd_ms_mousey	dc.w	0

BD_screen	dc.l	0
BD_window	dc.l	0

BD_newscreen
	dc.w	0,0				leftedge,topedge
	dc.w	BD_SCREEN_x,BD_SCREEN_y		width,height
	dc.w	BD_SCREEN_d			depth
	dc.b	6,0				detailpeb,blockpen
	dc.w	0				display mode
	dc.w	CUSTOMSCREEN|CUSTOMBITMAP	type
	dc.l	0				font
	dc.l	bdname				name
	dc.l	0				gadgets
	dc.l	0				custom bitmap

	even
bdname	dc.b	'Boulderdash Editor v1.0',0
	even

BD_newwindow
	dc.w	0,0					leftedge,topedge
	dc.w	BD_SCREEN_x,BD_SCREEN_y			width,height
	dc.b	0,1					detailpeb,blockpen
	dc.l	GADGETUP|MOUSEBUTTONS|RAWKEY|MENUPICK	IDCMFlags
	dc.l	SMART_REFRESH|BACKDROP|BORDERLESS	Flags
	dc.l	BD_Gadgets				Gadgets
	dc.l	0					CheckMark
	dc.l	0					Title
	dc.l	0					Screen
	dc.l	0					BitMap
	dc.w	BD_SCREEN_x,BD_SCREEN_y			min
	dc.w	BD_SCREEN_x,BD_SCREEN_y			max
	dc.w	CUSTOMSCREEN				Type

	even

Make_Gadget	macro
	dc.l	\1
	dc.w	\2,\3+GADGET_OFFSET,\4,\5
	dc.w	GADGHCOMP		flags
	dc.w	RELVERIFY		activation
	dc.w	BOOLGADGET		type
	dc.l	0			gadget render
	dc.l	0			select render
	dc.l	0			text
	dc.l	0			mutualexclude
	dc.l	0			spec info
	dc.w	\6			id
	dc.l	0
		endm


BD_Gadgets
	Make_Gadget	gg2,0,0,16,16,GADGET_DIAMOND
gg2	Make_Gadget	gg3,16,0,16,16,GADGET_TED
gg3	Make_Gadget	gg4,32,0,16,16,GADGET_BRICK
gg4	Make_Gadget	gg5,48,0,16,16,GADGET_BORDER
gg5	Make_Gadget	gg6,64,0,16,16,GADGET_MOVER
gg6	Make_Gadget	gg7,0,16,16,16,GADGET_ROCK
gg7	Make_Gadget	gg8,16,16,16,16,GADGET_DIRT
gg8	Make_Gadget	gg9,32,16,16,16,GADGET_EMPTY
gg9	Make_Gadget	gg10,48,16,16,16,GADGET_BUTTERFLY
gg10	Make_Gadget	gg11,64,16,16,16,GADGET_FUNGIS

gg11	Make_Gadget	gg12,128,8,16,16,GADGET_FAST_LEFT
gg12	Make_Gadget	gg13,160,8,16,16,GADGET_FAST_RIGHT
gg13	Make_Gadget	gg14,144,0,16,16,GADGET_FAST_UP
gg14	Make_Gadget	gg15,144,16,16,16,GADGET_FAST_DOWN

gg15	Make_Gadget	gg16,176,8,16,16,GADGET_LEFT
gg16	Make_Gadget	gg17,208,8,16,16,GADGET_RIGHT
gg17	Make_Gadget	gg18,192,0,16,16,GADGET_UP
gg18	Make_Gadget	gg19,192,16,16,16,GADGET_DOWN

gg19	Make_Gadget	gg20,240,0,16,16,GADGET_PLAY
gg20	Make_Gadget	gg21,240,16,16,16,GADGET_TEST
gg21	Make_Gadget	gg22,272,0,16,16,GADGET_SAVE
gg22	Make_Gadget	gg23,272,16,16,16,GADGET_LOAD
gg23	Make_Gadget	gg24,304,0,16,16,GADGET_QUIT
gg24	Make_Gadget	gg25,304,16,16,16,GADGET_CLR
gg25	Make_Gadget	gg26,224,0,16,16,GADGET_TIME
gg26	Make_Gadget	gg27,224,16,16,16,GADGET_TARGET
gg27	Make_Gadget	gg28,256,0,16,16,GADGET_HELP
gg28	Make_Gadget	0,80,0,16,16,GADGET_EXIT


Make_Menu	macro
	dc.l	\1			NextMenu
	dc.w	\2,0,\3,\4
	dc.w	MENUENABLED		flags
	dc.l	\@			name
	dc.l	\6			first item
	dc.w	0,0,0,0
\@	dc.b	\5,0
	even
		endm

Make_Item	macro
	dc.l	\1			NextItem
	dc.w	\2,\3,\6,10
	dc.w	ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ		flags
	dc.l	0			Mut Excl
	dc.l	\@			ItemFill
	dc.l	0			SelectFill
	dc.b	\5			Command
	dc.b	0
	dc.l	0			SubItem
	dc.w	0			Next Select

\@	dc.b	0			FrontPen
	dc.b	1			BackPen
	dc.b	RP_JAM2			Draw Mode
	dc.b	0
	dc.w	0,0			Left_Edge,Top_Edge
	dc.l	0			Font
	dc.l	\@T			Text
	dc.l	0			NextText
\@T	dc.b	\4,0
	even
		endm

Def_Menu	macro
MENU\1		equ	IDMenu
IDMenu		set	IDMenu+1
IDMenuItem	set	0
		endm

Def_Item	macro
ITEM\1		equ	IDMenuItem
IDMenuItem	set	IDMenuItem+1
		endm


IDMenu		set	0

	Def_Menu	Project
	Def_Item	Clear
	Def_Item	Open
	Def_Item	Save
	Def_Item	Quit
	Def_Item	Help
	Def_Menu	Game
	Def_Item	Play
	Def_Item	Test
	Def_Item	Time
	Def_Item	Target

menu1	Make_Menu	menu2,5,60,40,"Project",item11
item11	Make_Item	item12,5,4,"New",'N',64
item12	Make_Item	item13,5,14,"Open",'O',64
item13	Make_Item	item14,5,24,"Save",'W',64
item14	Make_Item	item15,5,34,"Quit",'Q',64
item15	Make_Item	0,5,50,"Help",'H',64
menu2	Make_Menu	0,80,60,40,"GAME",item21
item21	Make_Item	item22,5,4,"Play",'P',80
item22	Make_Item	item23,5,14,"Test",'T',80
item23	Make_Item	item24,5,24,"Time",'I',80
item24	Make_Item	0,5,34,"Target",'A',80

		even

flag_work_dirty		dc.w	0

play_file_requester	dc.l	0
loadsave_file_requester	dc.l	0

* Save Game Field Requester
save_title	dc.b	"SAVE GAME FIELD",0
		even
save_tags	dc.l	RT_Window
		dc.l	0
		dc.l	RTFI_Flags
		dc.l	FREQF_SAVE
		dc.l	RTFI_Flags
		dc.l	FREQF_PATGAD
		dc.l	RTFI_OkText
		dc.l	save_ok
		dc.l	TAG_END
		dc.l	0
save_ok		dc.b	'SAVE',0
		even

* Load Game Field Requester
load_title	dc.b	"LOAD GAME FIELD",0
		even
load_tags	dc.l	RT_Window
		dc.l	0
		dc.l	RTFI_Flags
		dc.l	FREQF_PATGAD
		dc.l	RTFI_OkText
		dc.l	load_ok
		dc.l	TAG_END
		dc.l	0
load_ok		dc.b	'LOAD',0
		even

* Play Game Requester
play_title	dc.b	"SELECT GAME FIELD",0
		even
play_tags	dc.l	RT_Window
		dc.l	0
		dc.l	RTFI_Flags
		dc.l	FREQF_PATGAD
		dc.l	RTFI_OkText
		dc.l	play_ok
		dc.l	TAG_END
		dc.l	0
play_ok		dc.b	'PLAY',0
		even

* Panic Requester
panic_bodyfmt	dc.b	"Can't Access File !",0
panic_gadfmt	dc.b	"That's too bad",0
		even
panic_tags	dc.l	RT_Window
		dc.l	0
		dc.l	TAG_END
		dc.l	0
panic2_bodyfmt	dc.b	"! Out of Memory !",0
panic2_gadfmt	dc.b	"That's too bad",0
		even
panic2_tags	dc.l	RT_Window
		dc.l	0
		dc.l	TAG_END
		dc.l	0

* Save Work  Requester
sw_bodyfmt	dc.b	"You've Made Some Changes",10
		dc.b	"to this Game Field.",10
		dc.b	"Want to Save Them ?",0
sw_gadfmt	dc.b	"Yes Sure|No Dump Them",0
		even
sw_tags		dc.l	RT_Window
		dc.l	0
		dc.l	TAG_END
		dc.l	0

* Clear Game Field Requester
clr_bodyfmt	dc.b	"You've Made Some Changes",10
		dc.b	"to this Game Field.",10
		dc.b	"CLEAR This Field ?",0
clr_gadfmt	dc.b	"Yes Sure|No Forget It",0
		even
clr_tags	dc.l	RT_Window
		dc.l	0
		dc.l	TAG_END
		dc.l	0
		even

* Get Game Time Requester
time_title	dc.b	"Enter Time Allowed",0
		even
time_data	dc.l	0
time_tags	dc.l	RT_Window
		dc.l	0
		dc.l	RTGL_Min
		dc.l	10
		dc.l	RTGL_Max
		dc.l	9999
		dc.l	RTGL_Width
		dc.l	200
		dc.l	TAG_END
		dc.l	0

* Get Game Target Requester
target_title	dc.b	"Enter Target",0
		even
target_data	dc.l	0
target_tags	dc.l	RT_Window
		dc.l	0
		dc.l	RTGL_Min
		dc.l	1
		dc.l	RTGL_Max
		dc.l	999
		dc.l	RTGL_Width
		dc.l	200
		dc.l	TAG_END
		dc.l	0

* Help Requester
help_bodyfmt	INCBIN	help_text
		dc.b	0
help_gadfmt	dc.b	"Great",0
		even
help_tags	dc.l	RT_Window
		dc.l	0
		dc.l	TAG_END
		dc.l	0

* Score Requester
score_bodyfmt	dc.b	"SCORE:",10
		dc.b	10
		dc.b	"You've Collected %d Diamonds.",10
		dc.b	"%d Were required.",10
		dc.b	"You've %d Time Units Left.",0
score_gadfmt	dc.b	"Ain't I Great",0
		even
score_tags	dc.l	RT_Window
		dc.l	0
		dc.l	TAG_END
		dc.l	0
score_args	dc.w	0
		dc.w	0
		dc.w	0

play_dir_tags	dc.l	RTFI_MatchPat
		dc.l	bd_wild_card
		dc.l	RTFI_Dir
		dc.l	play_directory,0
		dc.l	TAG_END
		dc.l	0

wild_tags	dc.l	RTFI_MatchPat
		dc.l	bd_wild_card
		dc.l	TAG_END
		dc.l	0

bd_wild_card	dc.b	'#?.bd',0
		even

play_directory	dc.b	'CAVES',0
		even

* Filenames and Name Buffers
filename	ds.b	112
play_filename	ds.b	112
completename	ds.b	224
		even
temp_file_name	dc.b	'ram:boulderdashtemp.bd',0

