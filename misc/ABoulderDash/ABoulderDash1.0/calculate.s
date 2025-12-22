	opt	L+
	opt	O2+
	opt	OW-

*==========================================
*
* File:        Calculate.s
* Version:     1
* Revision:    0
* Created:     5-VII-1993
* By:          FNC Slothouber
* Last Update: 22-Jan-1995
* By:          FNC Slothouber
*
*==========================================

	incdir	"include:"

	include	boulderdash.i

	XDEF	Calculate

	XREF	ted_bitmap_x
	XREF	ted_grid_field_x
	XREF	animate_offset_x
	XREF	ted_bitmap_y
	XREF	ted_grid_field_y
	XREF	animate_offset_y
	XREF	flag_scroll_left
	XREF	flag_scroll_right
	XREF	flag_view_scroll_left
	XREF	flag_view_scroll_right
	XREF	flag_scroll_up
	XREF	flag_scroll_down
	XREF	flag_view_scroll_up
	XREF	flag_view_scroll_down
	XREF	Update_Score
	XREF	time_flag
	XREF	ted_wins_flag
	XREF	ted_reach_limit

	XDEF	test_fungis
	XDEF	fungis_timer

MAX_FUN_TIME	equ	500


MTry_Move_Left	macro
	cmp.w	#G_EMPTY,grid_type+ONE_LEFT(a2)
	bne.s	.\@
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_LEFT(a2)
*	bne.s	.\@
	bne	.next
	move.w	#TRANS_MOVER_LEFT,grid_trans(a2)
	move.w	#DRAW_MOVER_LEFT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_LEFT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#MOVING_LEFT,grid_data(a2)
	move.b	#EMPTY_OCC_MOVER,grid_data+ONE_LEFT(a2)
	bra	.next
.\@
		endm

MTry_Move_Right	macro
	cmp.w	#G_EMPTY,grid_type+ONE_RIGHT(a2)
	bne.s	.\@
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_RIGHT(a2)
*	bne.s	.\@
	bne	.next
	move.w	#TRANS_MOVER_RIGHT,grid_trans(a2)
	move.w	#DRAW_MOVER_RIGHT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_RIGHT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#MOVING_RIGHT,grid_data(a2)
	move.b	#EMPTY_OCC_MOVER,grid_data+ONE_RIGHT(a2)
	bra	.next
.\@
		endm

MTry_Move_Up	macro
	cmp.w	#G_EMPTY,grid_type+ONE_UP(a2)
	bne.s	.\@
	move.b	grid_data+ONE_UP(a2),d1
	cmp.b	#EMPTY_OCC_ROCK_DOWN,d1
	bne.s	.d\@
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#TRANS_KILL_MOVER,grid_trans+ONE_UP+ONE_UP(a2)
	bra	.next
.d\@	cmp.b	#EMPTY_REAL_EMPTY,d1
	bne.s	.\@
	move.w	#TRANS_MOVER_UP,grid_trans(a2)
	move.w	#DRAW_MOVER_UP0,grid_draw(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#MOVING_UP,grid_data(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_UP(a2)
	move.b	#EMPTY_OCC_MOVER,grid_data+ONE_UP(a2)
	bra	.next
.\@
		endm

MTry_Move_Down	macro
	cmp.w	#G_EMPTY,grid_type+ONE_DOWN(a2)
	bne.s	.\@
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN(a2)
	bne.s	.\@
	move.w	#TRANS_MOVER_DOWN,grid_trans(a2)
	move.w	#DRAW_MOVER_DOWN0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_DOWN(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#MOVING_DOWN,grid_data(a2)
	move.b	#EMPTY_OCC_MOVER,grid_data+ONE_DOWN(a2)
	bra	.next
.\@
		endm

BTry_Move_Left	macro
	cmp.w	#G_EMPTY,grid_type+ONE_LEFT(a2)
	bne.s	.\@
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_LEFT(a2)
*	bne.s	.\@
	bne	.next
	move.w	#TRANS_BUTTERFLY_LEFT,grid_trans(a2)
	move.w	#DRAW_BUTTERFLY_LEFT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_LEFT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#MOVING_LEFT,grid_data(a2)
	move.b	#EMPTY_OCC_MOVER,grid_data+ONE_LEFT(a2)
	bra	.next
.\@
		endm

BTry_Move_Right	macro
	cmp.w	#G_EMPTY,grid_type+ONE_RIGHT(a2)
	bne.s	.\@
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_RIGHT(a2)
*	bne	.\@
	bne	.next
	move.w	#TRANS_BUTTERFLY_RIGHT,grid_trans(a2)
	move.w	#DRAW_BUTTERFLY_RIGHT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_RIGHT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#MOVING_RIGHT,grid_data(a2)
	move.b	#EMPTY_OCC_MOVER,grid_data+ONE_RIGHT(a2)
	bra	.next
.\@
		endm

BTry_Move_Up	macro
	cmp.w	#G_EMPTY,grid_type+ONE_UP(a2)
	bne.s	.\@
	move.b	grid_data+ONE_UP(a2),d1
	cmp.b	#EMPTY_OCC_ROCK_DOWN,d1
	bne.s	.d\@
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#TRANS_KILL_BUTTERFLY,grid_trans+ONE_UP+ONE_UP(a2)
	bra	.next
.d\@	cmp.b	#EMPTY_REAL_EMPTY,d1
	bne.s	.\@
	move.w	#TRANS_BUTTERFLY_UP,grid_trans(a2)
	move.w	#DRAW_BUTTERFLY_UP0,grid_draw(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#MOVING_UP,grid_data(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_UP(a2)
	move.b	#EMPTY_OCC_MOVER,grid_data+ONE_UP(a2)
	bra	.next
.\@
		endm

BTry_Move_Down	macro
	cmp.w	#G_EMPTY,grid_type+ONE_DOWN(a2)
	bne.s	.\@
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN(a2)
	bne.s	.\@
	move.w	#TRANS_BUTTERFLY_DOWN,grid_trans(a2)
	move.w	#DRAW_BUTTERFLY_DOWN0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_DOWN(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#MOVING_DOWN,grid_data(a2)
	move.b	#EMPTY_OCC_MOVER,grid_data+ONE_DOWN(a2)
	bra	.next
.\@
		endm

Do_Not_Move	macro
	move.w	#TRANS_NONE,grid_trans(a2)
	bra	.next
		endm


*
* Calculate
*
* A0                        D0
* A1                        D1
* A2 - grid field           D2 - grid_x
* A3 - copy of grid field   D3 - grid_y
* A4 -                      D4
* A5 -                      D5
* A6                        D6
*                           D7

Calculate ; (Grid Field) ,a2

* Copy For Test Green Fungis
	move.l	a2,a3

	move.w	#GRIDF_HEIGHT-1-6,d3				; skip border
	add.l	#3*GRIDF_WIDTH*grid_sizeof+(3*grid_sizeof),a2	; skip border
.ll0	move.w	#GRIDF_WIDTH-1-6,d2				; skip border
.ll1	move.w	grid_type(a2),d0
	cmp.w	#G_DIRT,d0
	beq	.next
	cmp.w	#G_EMPTY,d0
	beq	.next
	cmp.w	#G_BORDER,d0
	beq	.next
*----------------
*  ROCK ROCK ROCK
*----------------
* is it a rock ?
	cmp.w	#G_ROCK,d0
	bne	.pos2
* can it fall strait down ?
	move.w	grid_type+ONE_DOWN(a2),d1
	cmp.w	#G_EMPTY,d1
	beq.s	.remp
* can it kill ted below ?
	cmp.w	#G_TED,d1
	bne.s	.rock00
	cmp.b	#ROCK_MOVING,grid_data(a2)
	bne	.next
	move.w	#TRANS_KILL_TED,grid_trans+ONE_DOWN(a2)
	bra	.next
* can it kill a mover below ?
.rock00	cmp.w	#G_MOVER,d1
	bne.s	.rock0
	cmp.b	#ROCK_MOVING,grid_data(a2)
	bne	.next
	move.w	#TRANS_KILL_MOVER,grid_trans(a2)
	move.b	#MOVING_NOT,grid_data+ONE_DOWN(a2)
	bra	.next
* can it kill a butterfly below ?
.rock0	cmp.w	#G_BUTTERFLY,d1
	bne.s	.rock1
	cmp.b	#ROCK_MOVING,grid_data(a2)
	bne	.next
	move.w	#TRANS_KILL_BUTTERFLY,grid_trans(a2)
	move.b	#MOVING_NOT,grid_data+ONE_DOWN(a2)
	bra	.next

.remp	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN(a2)
	bne.s	.rock1
	move.w	#TRANS_ROCK_DOWN,grid_trans(a2)
	move.w	#DRAW_ROCK_DOWN0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_DOWN(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_ROCK_DOWN,grid_data+ONE_DOWN(a2)
	move.b	#ROCK_MOVING,grid_data(a2)
	bra	.next

* can it fall sideways to the left
.rock1	cmp.w	#G_EMPTY,grid_type+ONE_DOWN+ONE_LEFT(a2)
	bne.s	.rock2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN+ONE_LEFT(a2)
	bne.s	.rock2

* Is the rock on top of another rock or diamond ?
	move.w	grid_type+ONE_DOWN(a2),d1
	cmp.w	#G_ROCK,d1
	beq.s	.roc8
	cmp.w	#G_DIAMOND,d1
	bne	.rock_stops

* Can it move to the left ?
.roc8	cmp.w	#G_EMPTY,grid_type+ONE_LEFT(a2)
	bne.s	.rock2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_LEFT(a2)
	bne.s	.rock2
	move.w	#TRANS_ROCK_LEFT,grid_trans(a2)
	move.w	#DRAW_ROCK_LEFT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_LEFT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_ROCK,grid_data+ONE_LEFT(a2)
	move.b	#ROCK_MOVING,grid_data(a2)
	bra	.next

* can it fall sideways to the right
.rock2	cmp.w	#G_EMPTY,grid_type+ONE_DOWN+ONE_RIGHT(a2)
	bne	.rock_stops
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN+ONE_RIGHT(a2)
	bne	.rock_stops

* Is the rock on top of another rock or diamond ?
	move.w	grid_type+ONE_DOWN(a2),d1
	cmp.w	#G_ROCK,d1
	beq.s	.roc9
	cmp.w	#G_DIAMOND,d1
	bne	.rock_stops

* Can it move to the Right ?
.roc9	cmp.w	#G_EMPTY,grid_type+ONE_RIGHT(a2)
	bne	.rock_stops
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_RIGHT(a2)
	bne	.rock_stops
	move.w	#TRANS_ROCK_RIGHT,grid_trans(a2)
	move.w	#DRAW_ROCK_RIGHT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_RIGHT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_ROCK,grid_data+ONE_RIGHT(a2)
	move.b	#ROCK_MOVING,grid_data(a2)
	bra	.next

.rock_stops
	move.b	#ROCK_STEADY,grid_data(a2)
	bra	.next
.pos2
*-------------------
*  MOVER MOVER MOVER
*-------------------
	cmp.w	#G_MOVER,d0
	bne	.pos3
	move.b	grid_data(a2),d1
* is the mover to be killed ?
	cmp.b	#MOVING_NOT,d1
	beq	.next
* calculate moving direction
	cmp.b	#MOVING_UP,d1
	bne	.move2
	MTry_Move_Left
	MTry_Move_Up
	MTry_Move_Right
	MTry_Move_Down
	Do_Not_Move
.move2	cmp.b	#MOVING_DOWN,d1
	bne	.move3
	MTry_Move_Right
	MTry_Move_Down
	MTry_Move_Left
	MTry_Move_Up
	Do_Not_Move
.move3	cmp.b	#MOVING_LEFT,d1
	bne	.move4
	MTry_Move_Down
	MTry_Move_Left
	MTry_Move_Up
	MTry_Move_Right
	Do_Not_Move
.move4	MTry_Move_Up
	MTry_Move_Right
	MTry_Move_Down
	MTry_Move_Left
	Do_Not_Move

.pos3
*---------------------
*  BUTTERFLY BUTTERFLY
*---------------------
	cmp.w	#G_BUTTERFLY,d0
	bne	.pos4
	move.b	grid_data(a2),d1
* is the butterfly to be killed ?
	cmp.b	#MOVING_NOT,d1
	beq	.next

	cmp.w	#G_FUNGIS,grid_type+ONE_LEFT(a2)
	bne.s	.bf1
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#TRANS_KILL_BUTTERFLY4,grid_trans+ONE_LEFT(a2)
	bra	.next
.bf1	cmp.w	#G_FUNGIS,grid_type+ONE_RIGHT(a2)
	bne.s	.bf2
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#TRANS_KILL_BUTTERFLY2,grid_trans+ONE_RIGHT(a2)
	bra	.next
.bf2	cmp.w	#G_FUNGIS,grid_type+ONE_UP(a2)
	bne.s	.bf3
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#TRANS_KILL_BUTTERFLY,grid_trans+ONE_UP(a2)
	bra	.next
.bf3	cmp.w	#G_FUNGIS,grid_type+ONE_DOWN(a2)
	bne.s	.butt0
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#TRANS_KILL_BUTTERFLY3,grid_trans+ONE_DOWN(a2)
	bra	.next

.butt0	move.b	grid_data(a2),d1
	cmp.b	#MOVING_UP,d1
	bne	.butt2
	BTry_Move_Right
	BTry_Move_Up
	BTry_Move_Left
	BTry_Move_Down
	Do_Not_Move
.butt2	cmp.b	#MOVING_DOWN,d1
	bne	.butt3
	BTry_Move_Left
	BTry_Move_Down
	BTry_Move_Right
	BTry_Move_Up
	Do_Not_Move
.butt3	cmp.b	#MOVING_LEFT,d1
	bne	.butt4
	BTry_Move_Up
	BTry_Move_Left
	BTry_Move_Down
	BTry_Move_Right
	Do_Not_Move
.butt4	BTry_Move_Down
	BTry_Move_Right
	BTry_Move_Up
	BTry_Move_Left
	Do_Not_Move

.pos4
*---------------------
*  DIAMOND DIAMOND
*---------------------
	cmp.w	#G_DIAMOND,d0
	bne	.pos5
* can it fall strait down ?
	cmp.w	#G_EMPTY,grid_type+ONE_DOWN(a2)
	bne.s	.diamond1
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN(a2)
	bne.s	.diamond1
	move.w	#TRANS_DIAMOND_DOWN,grid_trans(a2)
	move.w	#DRAW_DIAMOND_DOWN0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_DOWN(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_DIAMOND,grid_data+ONE_DOWN(a2)
	bra	.next
* can it fall sideways to the left
.diamond1
	cmp.w	#G_EMPTY,grid_type+ONE_DOWN+ONE_LEFT(a2)
	bne.s	.diamond2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN+ONE_LEFT(a2)
	bne.s	.diamond2

* Is the diamond on top of another rock or diamond ?
	move.w	grid_type+ONE_DOWN(a2),d1
	cmp.w	#G_ROCK,d1
	beq.s	.dia8
	cmp.w	#G_DIAMOND,d1
	bne.s	.diamond2

* Can it move to the Left ?
.dia8	cmp.w	#G_EMPTY,grid_type+ONE_LEFT(a2)
	bne.s	.diamond2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_LEFT(a2)
	bne.s	.diamond2
	move.w	#TRANS_DIAMOND_LEFT,grid_trans(a2)
	move.w	#DRAW_DIAMOND_LEFT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_LEFT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_DIAMOND,grid_data+ONE_LEFT(a2)
	bra	.next
* can it fall sideways to the right
.diamond2
	cmp.w	#G_EMPTY,grid_type+ONE_DOWN+ONE_RIGHT(a2)
	bne	.next
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN+ONE_RIGHT(a2)
	bne	.next

* Is the diamond on top of another rock or diamond ?
	move.w	grid_type+ONE_DOWN(a2),d1
	cmp.w	#G_ROCK,d1
	beq.s	.dia9
	cmp.w	#G_DIAMOND,d1
	bne	.next

* Can it move to the Right ?
.dia9	cmp.w	#G_EMPTY,grid_type+ONE_RIGHT(a2)
	bne	.next
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_RIGHT(a2)
	bne	.next
	move.w	#TRANS_DIAMOND_RIGHT,grid_trans(a2)
	move.w	#DRAW_DIAMOND_RIGHT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_RIGHT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_DIAMOND,grid_data+ONE_RIGHT(a2)
	bra	.next
.diamond3

*---------------------
*  TED TED TED TED
*---------------------

.pos5	cmp.w	#G_TED,d0
	bne	.pos6

* did ted reach the exit and wins ?
	move.w	ted_reach_limit,d0
	beq.s	.ktd
	cmp.w	#G_EXIT,grid_type+ONE_LEFT(a2)
	beq.s	.tedwins
	cmp.w	#G_EXIT,grid_type+ONE_RIGHT(a2)
	beq.s	.tedwins
	cmp.w	#G_EXIT,grid_type+ONE_UP(a2)
	beq.s	.tedwins
	cmp.w	#G_EXIT,grid_type+ONE_DOWN(a2)
	bne.s	.ktd
.tedwins
	move.w	#TRUE,ted_wins_flag

* Is Ted To be Killed ?
.ktd	cmp.w	#TRANS_KILL_TED,grid_trans(a2)
	beq	.next
	cmp.w	#TIMESUP,time_flag
	beq.s	.killTed
	cmp.w	#G_MOVER,grid_type+ONE_DOWN(a2)
	beq.s	.killTed
	cmp.w	#G_MOVER,grid_type+ONE_UP(a2)
	beq.s	.killTed
	cmp.w	#G_MOVER,grid_type+ONE_LEFT(a2)
	beq.s	.killTed
	cmp.w	#G_MOVER,grid_type+ONE_RIGHT(a2)
	beq.s	.killTed
	cmp.w	#G_BUTTERFLY,grid_type+ONE_DOWN(a2)
	beq.s	.killTed
	cmp.w	#G_BUTTERFLY,grid_type+ONE_UP(a2)
	beq.s	.killTed
	cmp.w	#G_BUTTERFLY,grid_type+ONE_LEFT(a2)
	beq.s	.killTed
	cmp.w	#G_BUTTERFLY,grid_type+ONE_RIGHT(a2)
	bne.s	.joyst
.killTed
	move.w	#TRANS_KILL_TED,grid_trans(a2)
	move.w	#FALSE,ted_wins_flag
	bra	.next

* Read Joystick
.joyst	move.w	$dff00c,d0		; Joystick 1

	btst	#0,d0
	beq.s	.xor1
	btst	#1,d0
	beq	.teddown		bit 0=1 & bit 1=0
.xor0	btst	#8,d0
	beq.s	.xor2
	btst	#9,d0
	beq	.tedup			bit 8=1 & bit 9=0 
	bra.s	.tedlr
.xor1	btst	#1,d0
	bne	.teddown		bit 0=0 & bit 1=1
	bra.s	.xor0
.xor2	btst	#9,d0			bit 8=0 & bit 9=1
	bne	.tedup
.tedlr	btst	#1,d0
	bne	.tedright
	btst	#9,d0
	bne	.tedleft
* ted does not want to move
	bra	.next

*------------------
* Ted Left Ted Left
*------------------

.tedleft
	move.b	$bfe001,d0
	btst	#7,d0
	beq	.fireleft

* Try to move to the left
* Is there a diamond to the left of Ted
	move.w	grid_type+ONE_LEFT(a2),d1
	cmp.w	#G_DIAMOND,d1
	bne.s	.tleft0
* Is it falling down ?
	move.w	grid_trans+ONE_LEFT(a2),d1
	cmp.w	#TRANS_NONE,d1
	bne	.next
* Ted Collects Diamond and moves to the Left
	jsr	Update_Score
	bra.s	.tleft1
* Is there a empty grid to the left of Ted
.tleft0	cmp.w	#G_EMPTY,d1
	bne.s	.tleft2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_LEFT(a2)
	bne	.next
* Move Ted one grid to the left
.tleft1	move.w	#TRANS_TED_LEFT,grid_trans(a2)
	move.w	#DRAW_TED_LEFT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_LEFT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_TED,grid_data+ONE_LEFT(a2)
	bra	.tedlupdate
* Is the a dirt grid to the right of Ted
.tleft2	cmp.w	#G_DIRT,d1
	bne	.next
* Ted moves to the dirt to the left
	move.w	#TRANS_TED_LEFT,grid_trans(a2)
	move.w	#DRAW_TED_DIRT_LEFT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_LEFT(a2)
	move.b	#4,grid_dirty(a2)
	bra	.tedlupdate

.fireleft
	move.w	grid_type+ONE_LEFT(a2),d1
	cmp.w	#G_DIRT,d1
	bne	.fil2
* Ted empties the grid to the left of him.
	move.w	#DRAW_EMPTY,grid_draw+ONE_LEFT(a2)
	move.w	#TRANS_TO_EMPTY,grid_trans+ONE_LEFT(a2)
	move.b	#2,grid_dirty+ONE_LEFT(a2)
	bra	.next
.fil2	cmp.w	#G_ROCK,d1
	bne	.next
* is the rock about to fall any direction ?
	move.w	grid_trans+ONE_LEFT(a2),d1
	cmp.w	#TRANS_NONE,d1
	bne	.next
* can we move the rock ?
	move.w	grid_type+ONE_LEFT+ONE_LEFT(a2),d1
	cmp.w	#G_EMPTY,d1
	bne	.next
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_LEFT+ONE_LEFT(a2)
	bne	.next
* Ted moves the rock to the left of him.
	move.w	#DRAW_NOT,grid_draw+ONE_LEFT(a2)
	move.b	#EMPTY_OCC_ROCK,grid_data+ONE_LEFT+ONE_LEFT(a2)
	move.w	#TRANS_TED_MOVES_ROCK_LEFT,grid_trans(a2)
	move.w	#DRAW_TED_ROCK_LEFT0,grid_draw(a2)
	move.b	#4,grid_dirty(a2)

* Update Ted co-ordinates
.tedlupdate
	move.l	ted_bitmap_x,d0
	subq.l	#grid_sizeof,d0
	move.l	animate_offset_x,d1
	beq.s	.noscrl
	bls.s	.noscrl
	cmp.l	#SCROLL_RIGHT,d0
	bhs.s	.noscrl
	move.w	grid_trans(a2),d1
	cmp.w	#TRANS_TED_MOVES_ROCK_LEFT,d1
	bne.s	.lnorm
	move.w	#TRANS_TED_SCROLL_MOVES_ROCK_LEFT,grid_trans(a2)
	bra.s	.lnorm2
.lnorm	move.w	#TRANS_LEFT_SCROLL_RIGHT,grid_trans(a2)
.lnorm2	move.w	#DO_SCROLL,flag_view_scroll_right
.noscrl	move.l	d0,ted_bitmap_x
	move.l	ted_grid_field_x,d0
	subq.l	#grid_sizeof,d0
	move.l	d0,ted_grid_field_x
	bra	.next


*--------------------
* Ted Right Ted Right
*--------------------

.tedright
	move.b	$bfe001,d0
	btst	#7,d0
	beq	.fireright
* Try to move to the right
	move.w	grid_type+ONE_RIGHT(a2),d1
	cmp.w	#G_DIAMOND,d1
	bne.s	.tright0
* There is a diamond
* Is it falling down ?
	move.w	grid_type+ONE_DOWN+ONE_RIGHT(a2),d1
	cmp.w	#G_EMPTY,d1
	bne.s	.trr0
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN+ONE_RIGHT(a2)
	beq	.next
* Can is fall sideways to the right ?
.trr0	move.w	grid_type+ONE_RIGHT+ONE_RIGHT(a2),d1
	cmp.w	#G_EMPTY,d1
	bne.s	.trghd1
	move.w	grid_type+ONE_RIGHT+ONE_DOWN(a2),d1
	cmp.w	#G_ROCK,d1
	beq	.trr1
	cmp.w	#G_DIAMOND,d1
	bne.s	.trghd1
.trr1	move.w	grid_type+ONE_RIGHT+ONE_RIGHT+ONE_DOWN(a2),d1
	cmp.w	#G_EMPTY,d1
	beq	.next
	bra	.trghd1

* Is there a empty grid to the right of Ted
.tright0
	cmp.w	#G_EMPTY,d1
	bne	.tright2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_RIGHT(a2)
	bne	.next
	bra	.tright1
* Ted Collect Diamond and moves to the right
.trghd1	jsr	Update_Score
* Ted moves to the right
.tright1
	move.w	#TRANS_TED_RIGHT,grid_trans(a2)
	move.w	#DRAW_TED_RIGHT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_RIGHT(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_TED,grid_data+ONE_RIGHT(a2)
	bra	.tedrupdate
* Is the a dirt grid to the right of Ted
.tright2
	cmp.w	#G_DIRT,d1
	bne	.next
* Ted moves to the dirt to the right
	move.w	#TRANS_TED_RIGHT,grid_trans(a2)
	move.w	#DRAW_TED_DIRT_RIGHT0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_RIGHT(a2)
	move.b	#4,grid_dirty(a2)
	bra	.tedrupdate
.fireright
	move.w	grid_type+ONE_RIGHT(a2),d1
	cmp.w	#G_DIRT,d1
	bne	.firr1
* Ted empties the grid to the right of him.
	move.w	#DRAW_EMPTY,grid_draw+ONE_RIGHT(a2)
	move.w	#TRANS_TO_EMPTY,grid_trans+ONE_RIGHT(a2)
	move.b	#2,grid_dirty+ONE_RIGHT(a2)
	bra	.next
.firr1	cmp.w	#G_ROCK,d1
	bne	.next
* is the rock about to fall any direction ?
	move.w	grid_type+ONE_DOWN+ONE_RIGHT(a2),d1
	cmp.w	#G_EMPTY,d1
	bne.s	.firr2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN+ONE_RIGHT(a2)
	beq	.next
.firr2	cmp.w	#G_MOVER,d1
	beq	.next
* Can the rock fall side ways to the right
.firr3	move.w	grid_type+ONE_RIGHT+ONE_RIGHT(a2),d1
	cmp.w	#G_EMPTY,d1
	bne	.next
	move.w	grid_type+ONE_RIGHT+ONE_DOWN(a2),d1
	cmp.w	#G_ROCK,d1
	beq	.firr0
	cmp.w	#G_DIAMOND,d1
	bne.s	.firr4
.firr0	move.w	grid_type+ONE_RIGHT+ONE_RIGHT+ONE_DOWN(a2),d1
	cmp.w	#G_EMPTY,d1
	beq	.next
* Ted moves the rock to the right of him.
.firr4	move.w	#DRAW_NOT,grid_draw+ONE_RIGHT(a2)
	move.b	#EMPTY_OCC_ROCK,grid_data+ONE_RIGHT+ONE_RIGHT(a2)
	move.w	#TRANS_TED_MOVES_ROCK_RIGHT,grid_trans(a2)
	move.w	#DRAW_TED_ROCK_RIGHT0,grid_draw(a2)
	move.b	#4,grid_dirty(a2)

* Update Ted co-ordinates
.tedrupdate
	move.l	ted_bitmap_x,d0
	addq.l	#grid_sizeof,d0
	move.l	animate_offset_x,d1
	cmp.l	#SCROLL_LEFT_MAX,d1
	bhs.s	.noscrr
	cmp.l	#SCROLL_LEFT,d0
	bls.s	.noscrr
	move.w	grid_trans(a2),d1
	cmp.w	#TRANS_TED_MOVES_ROCK_RIGHT,d1
	bne.s	.rnorm
	move.w	#TRANS_TED_SCROLL_MOVES_ROCK_RIGHT,grid_trans(a2)
	bra.s	.rnorm2
.rnorm	move.w	#TRANS_RIGHT_SCROLL_LEFT,grid_trans(a2)
.rnorm2	move.w	#DO_SCROLL,flag_view_scroll_left
.noscrr	move.l	d0,ted_bitmap_x

	move.l	ted_grid_field_x,d0
	add.l	#grid_sizeof,d0
	move.l	d0,ted_grid_field_x

	bra	.next

*--------------
* Ted Up Ted Up
*--------------

.tedup
	move.b	$bfe001,d0
	btst	#7,d0
	beq	.fireup
* Try to move up

* Is there a diamond above ted ?
	move.w	grid_type+ONE_UP(a2),d1
	cmp.w	#G_DIAMOND,d1
	bne.s	.tuu1
* It is falling down ?
	move.w	grid_trans+ONE_UP(a2),d1
	cmp.w	#TRANS_NONE,d1
	bne	.next
* Ted Collects Diamond and moves to the Up
	jsr	Update_Score
	bra.s	.touk0
* Is there a empty grid above ted ?
.tuu1	cmp.w	#G_EMPTY,d1
	bne.s	.touk1
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_UP(a2)
	bne	.next
* Ted moves to the up
.touk0	move.w	#TRANS_TED_UP,grid_trans(a2)
	move.w	#DRAW_TED_UP0,grid_draw(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_TED,grid_data+ONE_UP(a2)
	bra	.teduupdate
.touk1	cmp.w	#G_DIRT,d1
	bne	.next
* Ted moves to the up trough the dirt
	move.w	#TRANS_TED_UP,grid_trans(a2)
	move.w	#DRAW_TED_DIRT_UP0,grid_draw(a2)
	move.b	#4,grid_dirty(a2)
	bra	.teduupdate
.fireup
	move.w	grid_type+ONE_UP(a2),d1
	cmp.w	#G_DIRT,d1
	bne	.next
* Ted empties the grid above him.
	move.w	#DRAW_EMPTY,grid_draw+ONE_UP(a2)
	move.w	#TRANS_TO_EMPTY,grid_trans+ONE_UP(a2)
	move.b	#2,grid_dirty+ONE_UP(a2)
	bra	.next

* Update Ted co-ordinates
.teduupdate
	move.l	ted_bitmap_y,d0
	sub.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	animate_offset_y,d1
	beq.s	.noscru
	bls.s	.noscru
	cmp.l	#SCROLL_DOWN,d0
	bhs.s	.noscru
	move.w	#TRANS_UP_SCROLL_DOWN,grid_trans(a2)
	move.w	#DO_SCROLL,flag_view_scroll_down
.noscru	move.l	d0,ted_bitmap_y
	move.l	ted_grid_field_y,d0
	sub.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,ted_grid_field_y
	bra	.next

*------------------
* Ted Down Ted Down
*------------------

.teddown
	move.b	$bfe001,d0
	btst	#7,d0
	beq	.firedown
* Try to move down
* Is there a diamond below ted
	move.w	grid_type+ONE_DOWN(a2),d1
	cmp.w	#G_DIAMOND,d1
	bne.s	.tdd1
* Is it falling down ?
	move.w	grid_type+ONE_DOWN+ONE_DOWN(a2),d1
	cmp.w	#G_EMPTY,d1
	bne.s	.tdd2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN+ONE_DOWN(a2)
	beq	.next
* Can is fall sideways to the right ?
.tdd2	move.w	grid_type+ONE_DOWN+ONE_RIGHT(a2),d1
	cmp.w	#G_EMPTY,d1
	bne.s	.toddk1
	move.w	grid_type+ONE_DOWN+ONE_DOWN(a2),d1
	cmp.w	#G_ROCK,d1
	beq	.tdd3
	cmp.w	#G_DIAMOND,d1
	bne.s	.toddk1
.tdd3	move.w	grid_type+ONE_DOWN+ONE_RIGHT+ONE_DOWN(a2),d1
	cmp.w	#G_EMPTY,d1
	beq	.next
	bra	.toddk1

* Is there a empty grid below ted
.tdd1	cmp.w	#G_EMPTY,d1
	bne.s	.todk2
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN(a2)
	bne	.next
	bra	.todk1

* Ted Collects Diamond and moves down
.toddk1	jsr	Update_Score

* Ted moves to the down
.todk1	move.w	#TRANS_TED_DOWN,grid_trans(a2)
	move.w	#DRAW_TED_DOWN0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_DOWN(a2)
	move.b	#4,grid_dirty(a2)
	move.b	#EMPTY_OCC_TED,grid_data+ONE_DOWN(a2)
	bra	.teddupdate
.todk2	cmp.w	#G_DIRT,d1
	bne	.next
* Ted moves to the down trough the dirt
	move.w	#TRANS_TED_DOWN,grid_trans(a2)
	move.w	#DRAW_TED_DIRT_DOWN0,grid_draw(a2)
	move.w	#DRAW_NOT,grid_draw+ONE_DOWN(a2)
	move.b	#4,grid_dirty(a2)
	bra	.teddupdate

.firedown
	move.w	grid_type+ONE_DOWN(a2),d1
	cmp.w	#G_DIRT,d1
	bne	.next
* Ted empties the grid above him.
	move.w	#DRAW_EMPTY,grid_draw+ONE_DOWN(a2)
	move.w	#TRANS_TO_EMPTY,grid_trans+ONE_DOWN(a2)
	move.b	#2,grid_dirty+ONE_DOWN(a2)
	bra	.next

* Update Ted co-ordinates
.teddupdate
	move.l	ted_bitmap_y,d0
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	animate_offset_y,d1
	cmp.l	#SCROLL_UP_MAX,d1
	bhs.s	.noscrd
	cmp.l	#SCROLL_UP,d0
	bls.s	.noscrd
	move.w	#TRANS_DOWN_SCROLL_UP,grid_trans(a2)
	move.w	#DO_SCROLL,flag_view_scroll_up
.noscrd	move.l	d0,ted_bitmap_y
	move.l	ted_grid_field_y,d0
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,ted_grid_field_y
	bra	.next

*---------------------
*  FUNGIS FUNGIS
*---------------------

.pos6	cmp.w	#G_FUNGIS,d0
	bne	.pos7
	bsr	Random
	and.w	#$03f0,d0
	bne	.next
* Try to grow
* Select direction
	bsr	Random
	lsr.w	#8,d0
	and.w	#$0003,d0
	cmp.w	#3,d0
	bne.s	.fung1
* Try to expand to the left
	move.w	grid_type+ONE_LEFT(a2),d0
	cmp.w	#G_DIRT,d0
	beq	.funputl
	cmp.w	#G_EMPTY,d0
	bne	.next
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_LEFT(a2)
	bne	.next
.funputl
* Expand to the Left
	move.b	#EMPTY_OCC_FUNGIS,grid_data+ONE_LEFT(a2)
	move.w	#TRANS_TO_FUNGIS,grid_trans+ONE_LEFT(a2)
	move.w	#DRAW_FUNGIS_LEFT0,grid_draw+ONE_LEFT(a2)
	move.b	#4,grid_dirty+ONE_LEFT(a2)
* Reset Fungis Timer
	move.w	#0,fungis_timer
	bra	.next
.fung1	cmp.w	#1,d0
	bne.s	.fung2
* Try to expand to the right
	move.w	grid_type+ONE_RIGHT(a2),d0
	cmp.w	#G_DIRT,d0
	beq	.funputr
	cmp.w	#G_EMPTY,d0
	bne	.next
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_RIGHT(a2)
	bne	.next
.funputr
* Expand to the Right
	move.b	#EMPTY_OCC_FUNGIS,grid_data+ONE_RIGHT(a2)
	move.w	#TRANS_TO_FUNGIS,grid_trans+ONE_RIGHT(a2)
	move.w	#DRAW_FUNGIS_RIGHT0,grid_draw+ONE_RIGHT(a2)
	move.b	#4,grid_dirty+ONE_RIGHT(a2)
* Reset Fungis Timer
	move.w	#0,fungis_timer
	bra	.next
.fung2	cmp.w	#2,d0
	bne.s	.fung3
* Try to expand downwards
	move.w	grid_type+ONE_DOWN(a2),d0
	cmp.w	#G_DIRT,d0
	beq	.funputd
	cmp.w	#G_EMPTY,d0
	bne	.next
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN(a2)
	bne	.next
.funputd
* Expand Downwards
	move.b	#EMPTY_OCC_FUNGIS,grid_data+ONE_DOWN(a2)
	move.w	#TRANS_TO_FUNGIS,grid_trans+ONE_DOWN(a2)
	move.w	#DRAW_FUNGIS_DOWN0,grid_draw+ONE_DOWN(a2)
	move.b	#4,grid_dirty+ONE_DOWN(a2)
	move.w	#0,fungis_timer
	bra	.next
.fung3
* Try to expand upwards
	move.w	grid_type+ONE_UP(a2),d0
	cmp.w	#G_DIRT,d0
	beq	.funputu
	cmp.w	#G_EMPTY,d0
	bne	.next
	cmp.b	#EMPTY_REAL_EMPTY,grid_data+ONE_DOWN(a2)
	bne	.next
.funputu
* Expand Upwards
	move.b	#EMPTY_OCC_FUNGIS,grid_data+ONE_UP(a2)
	move.w	#TRANS_TO_FUNGIS,grid_trans+ONE_UP(a2)
	move.w	#DRAW_FUNGIS_UP0,grid_draw+ONE_UP(a2)
	move.b	#4,grid_dirty+ONE_UP(a2)
	move.w	#0,fungis_timer
	bra	.next

.pos7
	move.b	d0,d0			dummy
.next	addq.l	#grid_sizeof,a2
	dbra	d2,.ll1
	add.l	#6*grid_sizeof,a2	skip border
	dbra	d3,.ll0

******
*****  Test If Green Fungus Has Stoped Growing
******

	tst.w	test_fungis
	beq	.exit
	move.w	fungis_timer,d0
	addq.w	#1,d0
	cmp.w	#MAX_FUN_TIME,d0
	bne.s	.fungrow
* Trans Form All Fungis To Diamonds
	move.l	a3,a2
	move.w	#GRIDF_HEIGHT-1-6,d3				; skip border
	add.l	#3*GRIDF_WIDTH*grid_sizeof+(3*grid_sizeof),a2	; skip border
.kk0	move.w	#GRIDF_WIDTH-1-6,d2				; skip border
.kk1	cmp.w	#G_FUNGIS,grid_type(a2)
	bne.s	.kk3
	move.w	#G_DIAMOND,grid_type(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#DRAW_DIAMOND,grid_draw(a2)
	move.b	#2,grid_dirty(a2)
	move.b	#0,grid_data(a2)
.kk3	addq.l	#grid_sizeof,a2
	dbra	d2,.kk1
	add.l	#6*grid_sizeof,a2	skip border
	dbra	d3,.kk0
	move.w	#FALSE,test_fungis
	bra	.exit
.fungrow
	move.w	d0,fungis_timer
.exit	rts



*==============
* Random    () -> (number),d0
*==============

Ran_Regs	REG	d2/d3

Random	movem.l	Ran_Regs,-(sp)
	lea	table,a0
	move.w	j,d2
	move.w	k,d3
	move.l	(a0,d2.w),d0	Y[j]
	add.l	d0,(a0,d3.w)	Y[k]=Y[k]+Y[j]

	subq.w	#4,d2		j=j-1
	bne.s	.ll1
	move.w	#4*55,d2
.ll1
	subq.w	#4,d3
	bne.s	.ll2
	move.w	#4*55,d3
.ll2
	move.w	d2,j
	move.w	d3,k

	movem.l	(sp)+,Ran_Regs
	rts

j	dc.w	4*24
k	dc.w	4*55

table:
 dc.l	10003
 dc.l	9923213
 dc.l	234256
 dc.l	31416923
 dc.l	12933933
 dc.l	413123213
 dc.l	122334412
 dc.l	112342213
 dc.l	66666333
 dc.l	123123
 dc.l	9387432
 dc.l	1128765
 dc.l	44982379
 dc.l	8768776
 dc.l	823277324
 dc.l	41234333
 dc.l	981744
 dc.l	12321071
 dc.l	279879
 dc.l	123219798
 dc.l	987923423
 dc.l	2346546
 dc.l	87171
 dc.l	244564537
 dc.l	6464564564
 dc.l	98898888
 dc.l	6262621313
 dc.l	989954654
 dc.l	39879879799
 dc.l	798797979
 dc.l	87686868
 dc.l	98797987987
 dc.l	998798879
 dc.l	43242432
 dc.l	37777777
 dc.l	9879745656
 dc.l	98798798
 dc.l	838383838
 dc.l	123123333
 dc.l	912387432
 dc.l	3123128765
 dc.l	987945645
 dc.l	8768776
 dc.l	82232433
 dc.l	9871234
 dc.l	9817444653
 dc.l	09871456
 dc.l	98797987987
 dc.l	998798879
 dc.l	43242432
 dc.l	123123
 dc.l	12312
 dc.l	1
 dc.l	12321
 dc.l	3
 dc.l	3333

* Fungis Timeout Timer 
fungis_timer	dc.w	0
test_fungis	dc.w	0
