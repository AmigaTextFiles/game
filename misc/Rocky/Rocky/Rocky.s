*************************************************************************
*									*
*	'Rocky Clone' by Laurence Vanhelsuwé		© 1992		*
*									*
*************************************************************************

		INCLUDE	std
		INCLUDE	b.macros	;2-d cell access macros

*************************************************************************

*---------------------------------------
* ALL STRUCTURES MUST BE EVEN SIZED !!!! : (check BYTE sized tails only) 
*---------------------------------------
 RSRESET	;MEMORY structure
mem_type		RS.L	1	;CHIP,PUBLIC or FAST
mem_size		RS.L	1	;# of bytes to allocate
mem_ptr			RS.L	1	;ptr to LONG to hold address
MEMORY_sizeof		rs.b	0

 RSRESET	;FILE structure
name_ptr		RS.L	1	;ptr to C-string
buf_ptr			RS.L	1
buf_size		RS.L	1
FILE_sizeof		rs.b	0

 RSRESET	;WORLD structure
jewel_value		RS.L	4	;how much a standard gem scores
greedy_value		RS.L	4	;how much a gem scores BEYOND required number
to_collect		RS.W	4	;number of gems to collect
time_lefts		RS.W	4	;seconds to solve this level in
WORLD_sizeof		rs.b	0

 RSRESET	;SNAKE structure
SNK_segm_ptrs		RS.L	8	;8 ptrs to the 8 snake segments in game map
SNK_reversebuf1		RS.L	8
SNK_head_index		RS.W	1
SNK_dir_codes		RS.B	8	;0..3 U,R,D,L
SNK_reversebuf2		RS.B	8
SNK_head_codes		RS.B	4	
SNK_segm_codes		RS.B	4
SNK_tail_codes		RS.B	4
SNK_turn_rocks_into	RS.B	1	;ROCKS into DIAMS or FFLIES
SNK_length		RS.B	1	;1..8
SNK_hatched		RS.B	1	;has this snake hatched out of his egg yet?
pad_00			RS.B	1
SNAKE_sizeof		rs.b	0

FIRE_BUTTONS		equ	$BFE001
FIRE2			equ	7
FIRE1			equ	6
STICK2			equ	1
joy0dat			equ	$00A
vposr			equ	$004	;used in random number generator !

;************************************************************************

;----------------------- INTUITION CONSTANTS
; IDCMP flags
;------------
WINDOW_IDCMP		equ	VANILLAKEY	;would like pure ASCII please...

*WINDOW_IDCMP		equ	CLOSEWINDOW+MOUSEBUTTONS+RAWKEY+GADGETUP

WINDOW_FLAGS		equ	ACTIVATE+BACKDROP+BORDERLESS

************************************************************************
** Game specific equates
************************************************************************

* The dimensions of the game area (in cells)

COLUMNS			equ	40
ROWS			equ	22
MAP_SIZE		equ	ROWS*COLUMNS

SCREEN_WIDTH		equ	40

;----------------------- LIFE FORMS IN ROCKY
AIR			equ	$00
GRASS			equ	$01
RWALL			equ	$02	;rock wall : indestructible
WALL			equ	$03
EWALL			equ	$04	;04,05,06,07
GWALL			equ	$08

FWALL			equ	$0C	;0C,0D,0E,0F
AMIBA			equ	$10	;10,11,12,13

MAN			equ	$20	
WMAN			equ	$24	;waiting man
ROCK			equ	$28	;28

FROCK			equ	$2C	;2C,2D,2E,2F	;falling (killer) rock
BUTTER_FLY		equ	$30	;ANIMATING,ANTI-CLOCK WISE
BUTFLY_U		equ	$30	;bat,pirhanas,birds 
BUTFLY_R		equ	$31
BUTFLY_D		equ	$32
BUTFLY_L		equ	$33
FIRE_FLY		equ	$34	;ROTATING,CLOCK WISE MOVEMENT
FIREFLY_U		equ	$34	;monkeys,fish
FIREFLY_R		equ	$35
FIREFLY_D		equ	$36
FIREFLY_L		equ	$37
FIRE_TAP		equ	$38	;38,39,3A,3B

EXPL_BFLY_DIAM		equ	$40	;40,41,42,43
EXPL_ROCK_FFLY		equ	$44	;44,45,46,47
EXPL_FFLY_AIR		equ	$48	;48,49,4A,4B
EXPL_AIR		equ	$4C	;4C,4D
EXPL_AMIB_DIAM		equ	$4E	;4E,4F
EXPL_AMIB_ROCK		equ	$50	;50,51
EXPL_DIAM_BFLY		equ	$54	;54,55,56,57

DROPLETS		equ	$60	;for all drops and fires
FALLING_DROP		equ	$60	;60,61
FLAME			equ	$68	;68,69
HR_DROP			equ	$62	;62,63
HL_DROP			equ	$64	;64,65
EXPL_DROP		equ	$66	;66,67
HR_FLAME		equ	$6A	;6A,6B
HL_FLAME		equ	$6C	;6C,6D

BEGG			equ	$70	;70,71,72,73
EXIT			equ	$74	;74,75,76,77
NUMBER			equ	$78	;78,79,7A,7B
EXTRA_T			equ	$7C	;7C,7D,7E,7F
EXTRA_L			equ	$80	;80,81,82,83
GEGG			equ	$84	;84,85,86,87
DIAMOND			equ	$88

FDIAMOND		equ	$8C

GSNAKE			equ	$90
GS_HEAD			equ	$90	;90,91,92,93,94,95,96,97 UU/RR/DD/LL
GS_SEGM			equ	$98	;98,99,9A,9B,9C,9D,9E,9F
GS_TAIL			equ	$A0	;A0,A1,A2,A3,A4,A5,A6,A7

WATER_TAP		equ	$C4	;C4,C5,C6,C7

BSNAKE			equ	$D0
BS_HEAD			equ	$D0	;D0,D1,D2,D3,D4,D5,D6,D7 UU/RR/DD/LL
BS_SEGM			equ	$D8	;D8,D9,DA,DB,DC,DD,DE,DF
BS_TAIL			equ	$E0	;E0,E1,E2,E3,E4,E5,E6,E7

;----------------------- GAME SETTINGS
PUSH			equ	4	;range 1..1+PUSH
AFTER_LIFE		equ	10	;generations between fade after rf death
MAGIC_TIME		equ	350	;N generations of EWALL
G_HATCH_TIME		equ	100	;generations before egg hatches
B_HATCH_TIME		equ	200
BONUS_SECS		equ	20	;seconds added
BONUS_CHANCE		equ	20	; % to get bonus life when completed level
BSNAKE_BADNESS		equ	10	; % to get a fire fly out of a rock
DROP_NERVES		equ	40	; % for stuck drop to explode
DROPS_SPEED		equ	3	;has to be a 2^n -1

FLASH_TIME		equ	5
REPEAT_MOVIE		equ	3
AMIBA_SPEED		equ	70	;smaller is quicker (max 127)
TRIGGERX		equ	32
TRIGGERY		equ	20
*-----------------------
PLANES			equ	3
*-----------------------

PAUSE			equ	' '	;press SPACE to pause game
SUICIDE			equ	CR	;press RETURN to commit suicide
QUIT			equ	ESC	;press ESCAPE to quit game

CRSRU			equ	'w'	;press "w" to move up
CRSRD			equ	's'	;press "s" to move down
CRSRR			equ	'p'	;press "p" to move right
CRSRL			equ	'o'	;press "o" to move left

*-----------------------BIT NAMES

RIGHT			equ	0	;returned bit numbers from read_stick
LEFT			equ	1
UP			equ	2
DOWN			equ	3
FIRE			equ	4

MASK1			equ	-1	;$FFFFF
MASK2			equ	-2	;$FFFFE
MASK4			equ	-4	;$FFFFC
MASK8			equ	-8	;$FFFF8
MASK16			equ	-16	;$FFFF0
MASK32			equ	-32	;$FFFE0
BFLY_MASK		equ	$7C	;%0111 1100
FFLY_MASK		equ	$74	;%0111 0100

************************************************************************
************************************************************************
***********************                 ********************************
*********************** PROGRAM SECTION ********************************
***********************                 ********************************
************************************************************************
************************************************************************

START_PROGRAM	move.l	sp,stack_level		;remember stack pointer for bail outs

		bsr	open_libraries		;open Amiga libraries
		bsr	open_screen		;open game screen
		bsr	get_n_load_most		;allocate buffers & load files
		bsr	init_divu_table
		move.w	#0,level

;---------------
next_map	bsr	load_level		;copy R/O level into working map
		bsr	new_game		;initialize game

		bsr	play_level		;play level until solved
		bra	next_map
;---------------
quit_game	move.l	stack_level,sp		;restore stack pointer

		bsr	close_screen		;kill our game Screen
		bsr	ret_mem_blocks		;return allocated memory to pool
		bsr	close_libraries		;release previously opened libraries

		moveq	#0,d0			;clean CLI return code

END_PROGRAM	rts

************************************************************************
************************************************************************
***********************                 ********************************
***********************   END OF MAIN   ********************************
***********************                 ********************************
************************************************************************
************************************************************************

;-------------------------------------------------------
play_level	

game_loop	bsr	tune_game_speed		;depending on which 680x0 this is...

		bsr	test_IDCMP		;check Intuition events (keypresses)
		bsr	get_key
		
		sf	key_move		;assume move made with keys (not joyst)
		cmp.b	#CRSRU,d0
		bne	not_crsru
		bset	#UP,key_move		;simulate joystick input

not_crsru	cmp.b	#CRSRD,d0
		bne	not_crsrd
		bset	#DOWN,key_move		;simulate joystick input

not_crsrd	cmp.b	#CRSRL,d0
		bne	not_crsrl
		bset	#LEFT,key_move		;simulate joystick input

not_crsrl	cmp.b	#CRSRR,d0
		bne	not_next
		bset	#RIGHT,key_move		;simulate joystick input
		
;		cmp.b	#'n',d0			;CHEAT key ?
;		bne	not_next
;		st	found_exit

not_next	cmp.b	#PAUSE,d0		;PAUSE key
		bne	not_spc
		not.b	pauze
		bra	done_keys

not_spc		cmp.b	#SUICIDE,d0		;SUICIDE key
		bne	not_esc
		st	die_anyway
		bra	done_keys

not_esc		cmp.b	#QUIT,d0		;QUIT game key
		beq	quit_game

done_keys	tst.b	pauze
		bne	game_loop

		bsr	redraw_screen		;display generation
		bsr	get_user_move		;check joystick/keyboard
		bsr	anim_map		;calc next generation
		bsr	update_panel		;score,diamonds,time
		bsr	track_time		;keep track of seconds
	
dont_stop	move.b	out_of_time,d0
		or.b	rockf_died,d0
		move.b	found_exit,d1
		or.b	d0,d1
		beq	game_loop
;- - - -
		st	disable_rockf
		subq.b	#1,death_count
		bne	game_loop

		tst.b	d0
		beq	quit_level
		subq.w	#1,lives

quit_level	lea	bonus_scores,a0
		move.w	next_bonus,d0
		add.w	d0,d0
		add.w	d0,d0
		move.l	score,d1
		cmp.l	0(a0,d0),d1
		bcs.s	not_crossed
		addq.w	#1,next_bonus
		addq.w	#1,lives
		
not_crossed	tst.b	found_exit
		beq	no_time_bonus
		move.l	#200000,d0
		bsr	delay
		bsr	add_secs_left
		move.l	#200000,d0
		bsr	delay

no_time_bonus	tst.b	found_exit
		bne	next_level
		tst.w	lives
		bpl	play_level
		moveq	#0,d0
		rts

next_level	addq.w	#1,level
		cmp.w	#40,level
		beq	quit_game
		rts
;-------------------------------------------------------
get_n_load_most	lea	alloc_params,a5

;-------------------------------------------------------
; A5 -> alloc & load blocks

get_things	move.l	4.w,a6
		move.w	(a5)+,d7
alloc_block	move.l	mem_type(a5),d1		;type
		move.l	mem_size(a5),d0		;size
		EXEC	AllocMem
		move.l	mem_ptr(a5),a0
		move.l	d0,(a0)
		add.w	#MEMORY_sizeof,a5	;next allocation entry
		dbeq	d7,alloc_block
		beq	HANG

		move.l	DOS_LIB_PTR,a6
		move.w	(a5)+,d7
load_file	move.l	(a5)+,d1
		move.l	#MODE_OLDFILE,d2
		DOS	Open
		move.l	d0,d1			;file handle
		beq	DOS_PROBLEM
		move.l	d0,d6
		move.l	(a5)+,a0
		move.l	(a0),d2
		move.l	(a5)+,d3
		DOS	Read
		move.l	d6,d1
		DOS	Close
		dbra	d7,load_file
		rts
;---------------------------------------
DOS_PROBLEM	move.w	#WHITE,COLOR_BASE
		move.w	#BLACK,COLOR_BASE
		jmp	DOS_PROBLEM
;---------------------------------------
ret_mem_blocks	move.l	4.w,a6
		lea	alloc_params,a5
		move.w	(a5)+,d7
free_block	tst.l	(a5)+			;skip memory type
		move.l	(a5)+,d0		;get size
		move.l	(a5)+,a1		;get addr of mem ptr
		move.l	(a1),a1			;get mem ptr
		EXEC	FreeMem
		dbra	d7,free_block
		rts
;---------------------------------------
alloc_params	dc.w	((load_params-al_params)/MEMORY_sizeof)-1
al_params	dc.l	MEMF_PUBLIC,MAP_SIZE,maps
		dc.l	MEMF_PUBLIC,PLANES*8000,char_graphics
		dc.l	MEMF_PUBLIC,256*4,divu_table

load_params	dc.w	((ld_parms_2-ld_parms_1)/FILE_sizeof)-1
ld_parms_1	dc.l	fname0,char_graphics,PLANES*8000
ld_parms_2
;---------------------------------------
load_level	move.w	level,d2
		mulu	#MAP_SIZE,d2
		lea	source_maps,a0
		add.l	d2,a0
		move.l	maps,a1
		move.w	#MAP_SIZE/2-1,d0
download	move.w	(a0)+,(a1)+
		dbra	d0,download
		rts
;---------------------------------------
reset_flags	lea	flag_map,a0		;reset 'done' map
		move.w	#MAP_SIZE/4-1,d0
		moveq	#0,d1
reset_map	move.l	d1,(a0)+
		dbra	d0,reset_map
		rts
;---------------------------------------
get_user_move	move.b	key_move,d0	;did player use keyboard for a move ?
		beq	check_joystick
		move.b	d0,joystick+1	;yes, use this move instead of joystick.
		rts

check_joystick	moveq	#STICK2,d0	;read player decisions in same
		bsr	read_stick	;place to avoid timing problems
		move.w	d0,joystick
		rts
;---------------------------------------

************************************************************************************
* Bring entire game map to life by scanning all cells and executing their state
* handler.
* Also handle game elements which need extra procedures (above state mechanism):
* - The snakes 	(connected cells are too hard to do with cellular automaton)
* - The Amoeba	(keep track of its size and mutate cells to rocks when big enough)
* - Diamond counting, opening of EXIT
* - Magic wall timeouts
* - Animate Rockford randomly
************************************************************************************

anim_map	sf	added_amiba
		sf	bonk
		sf	ping
		st	rockf_died

		bsr.s	reset_flags

		move.w	#MAP_SIZE,scan_count	;process ALL cells ...
		lea	cell_map,a1
		lea	flag_map,a2
;- - - - - - - - - - - - - - - - - - - -
scan_map	tst.b	(a2)		;is cell already part of new generation ?
		bne	done_cel	;no,

		moveq	#0,d0
		move.b	(a1),d0		;curr. cell # in D0
		move.w	d0,d1
		add.w	d1,d1		;use as index into state routines
		add.w	d1,d1
		movem.l	a1/a2,-(SP)

		lea	funcs,a0
		move.l	0(a0,d1.w),d1
		beq	no_call

		move.l	d1,a0
		lea	no_call,a6	;RTS address cached !!!

		JMP	(a0)		;EXECUTE CELL STATE HANDLER

no_call		movem.l	(SP)+,a1/a2
		st	(a2)

done_cel	addq.w	#1,a1
		addq.w	#1,a2
		subq.w	#1,scan_count
		bne	scan_map
;- - - - - - - - - - - - - - - - - - - - -
		tst.b	good_snake
		beq	no_good_snake
		lea	gsnake_struct,a0
		bsr	handle_snake

no_good_snake	tst.b	bad_snake
		beq	no_snakes
		lea	bsnake_struct,a0
		bsr	handle_snake

no_snakes	bsr	handle_amiba	;change to DIAM,ROCK
		bsr	handle_diams	;change price if enough
		bsr	handle_ewall	;change to WALL after magic
		bsr	animate_things	;animate man

		tst.b	bonk
		beq	no_bonk

	NOP

no_bonk		tst.b	ping
		beq	no_bonk2

	NOP

no_bonk2	rts
;---------------------------------------
funcs		dc.l	0	AIR	0	CODES 00..0F ARE RESERVED
		dc.l	0	GRASS	1	FOR PERSPECTIVE CELLS !!!
		dc.l	0	RWALL	2
		dc.l	0	WALL	3

		dc.l	ewall	EWALL	4
		dc.l	ewall		5
		dc.l	ewall		6
		dc.l	ewall		7

		dc.l	gwall	GWALL	8
		dc.l	0		9
		dc.l	0		A
		dc.l	0		B

		dc.l	fwall	FWALL	C
		dc.l	fwall		D
		dc.l	fwall		E
		dc.l	fwall		F

		dc.l	amiba	AMIBA	10	;AND MASK4 = AMIBA
		dc.l	amiba	''	11
		dc.l	amiba	''	12
		dc.l	amiba	''	13

		dc.l	0		14
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		18
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		1C
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	Rocky MAN	20
		dc.l	0		21
		dc.l	0		22
		dc.l	0		23
		dc.l	Rocky WMAN	24
		dc.l	0		25
		dc.l	0		26
		dc.l	0		27

		dc.l	rock	ROCK	28	;AND MASK8 = ROCK
		dc.l	0		29
		dc.l	0		2A
		dc.l	0		2B
		dc.l	rock	FROCK	2C	;AND MASK4 = FROCK
		dc.l	rock	FROCK	2D	
		dc.l	rock	FROCK	2E
		dc.l	rock	FROCK	2F

		dc.l	big_butterfly	30	;AND MASK4 = BUTTER_FLY
		dc.l	big_butterfly	31
		dc.l	big_butterfly	32
		dc.l	big_butterfly	33

		dc.l	big_firefly	34	;AND MASK4 = FIRE_FLY
		dc.l	big_firefly	35
		dc.l	big_firefly	36
		dc.l	big_firefly	37

		dc.l	fire_tap FIRE_TAP 38
		dc.l	fire_tap	39
		dc.l	fire_tap	3A
		dc.l	fire_tap	3B

		dc.l	big_firefly	3C
		dc.l	big_firefly
		dc.l	big_firefly
		dc.l	big_firefly

		dc.l	bfly_diam_1	40
		dc.l	bfly_diam_2	41
		dc.l	bfly_diam_3	42
		dc.l	bfly_diam_4	43

		dc.l	rock_ffly_1	44
		dc.l	rock_ffly_2	45
		dc.l	rock_ffly_3	46
		dc.l	rock_ffly_4	47
		
		dc.l	ffly_air_1	48
		dc.l	ffly_air_2	49
		dc.l	ffly_air_3	4A
		dc.l	ffly_air_4	4B

		dc.l	air_expl_1	4C
		dc.l	air_expl_2	4D

		dc.l	amib_diam_1	4E
		dc.l	amib_diam_2	4F

		dc.l	amib_rock_1	50
		dc.l	amib_rock_2	51
		dc.l	0		52
		dc.l	0		53

		dc.l	diam_bfly_1	54
		dc.l	diam_bfly_2	55
		dc.l	diam_bfly_3	56
		dc.l	diam_bfly_4	57

		dc.l	0		58
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		5C
		dc.l	0		5D
		dc.l	0		5E
		dc.l	0		5F

		dc.l	fall_drop	60
		dc.l	fall_drop	61
		dc.l	horiz_drop_r	62
		dc.l	horiz_drop_r	63

		dc.l	horiz_drop_l	64
		dc.l	horiz_drop_l	65
		dc.l	expl_drop1	66
		dc.l	expl_drop2	67

		dc.l	flame		68
		dc.l	flame		69
		dc.l	horiz_flame_r	6A
		dc.l	horiz_flame_r	6B

		dc.l	horiz_flame_l	6C
		dc.l	horiz_flame_l	6D
		dc.l	0
		dc.l	0

		dc.l	begg	BEGG	70
		dc.l	begg		71
		dc.l	begg		72
		dc.l	begg		73

		dc.l	exit_1	EXIT	74
		dc.l	exit_2		75
		dc.l	exit_3		76
		dc.l	exit_4		77

		dc.l	bonus_1	NUMBER	78
		dc.l	bonus_2		79
		dc.l	bonus_3		7A
		dc.l	bonus_4		7B

		dc.l	extra_t1 EXTRA_T 7C
		dc.l	extra_t2 	7D
		dc.l	extra_t3 	7E
		dc.l	extra_t4 	7F

		dc.l	extra_l1 EXTRA_L 80
		dc.l	extra_l2 	81
		dc.l	extra_l3 	82
		dc.l	extra_l4 	83

		dc.l	gegg	GEGG	84
		dc.l	gegg		85
		dc.l	gegg		86
		dc.l	gegg		87

		dc.l	diamond	DIAMOND	88
		dc.l	0		89
		dc.l	0		8A
		dc.l	0		8B
		dc.l	diamond FDIAMOND 8C
		dc.l	0		8D
		dc.l	0		8E
		dc.l	0		8F

		dc.l	0 GS_HEAD	90
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		94
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0 GS_SEGM	98
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		9C
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0 GS_TAIL	A0
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		A4
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		A8
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		AC
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	big_butterfly	B0
		dc.l	big_butterfly
		dc.l	big_butterfly
		dc.l	big_butterfly

		dc.l	big_firefly	B4
		dc.l	big_firefly
		dc.l	big_firefly
		dc.l	big_firefly

		dc.l	0		B8
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	big_firefly	BC
		dc.l	big_firefly
		dc.l	big_firefly
		dc.l	big_firefly

		dc.l	0		C0
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	water_tap	C4
		dc.l	water_tap
		dc.l	water_tap
		dc.l	water_tap

		dc.l	0		C8
		dc.l	0		
		dc.l	0		
		dc.l	0		

		dc.l	0		CC
		dc.l	0		
		dc.l	0		
		dc.l	0		

		dc.l	0		D0
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		D4
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		D8
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l	0		DC
		dc.l	0
		dc.l	0
		dc.l	0

		dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 E0
		dc.l 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 F0
;---------------------------------------
handle_amiba	tst.w	amiba_count
		beq	no_blob
		cmp.w	#MAP_SIZE/4,amiba_count
		bcc.s	too_many
		tst.b	added_amiba
		bne	no_blob
		move.w	#EXPL_AMIB_DIAM,d1
		bra	kill_amiba
too_many	move.w	#EXPL_AMIB_ROCK,d1
kill_amiba	move.w	#AMIBA,d0
		moveq	#MASK4,d2
		bsr	replace_cells
		clr.w	amiba_count	;no more amiba stuff !
no_blob		rts
;---------------------------------------
handle_diams	tst.b	enough_diamonds
		bne	not_enough
		tst.w	diamonds
		bne	not_enough
		move.b	#FLASH_TIME,flash
		moveq	#3,d0
		and.w	level,d0
		add.w	d0,d0
		add.w	d0,d0
		move.l	world_ptr,a0
		move.l	greedy_value(a0,d0),price
		st	enough_diamonds
not_enough	rts
;---------------------------------------
handle_ewall	tst.b	magic_walls	;is magic mode ON ?
		beq	no_ewalls	;yes,

		subq.w	#1,magic_timer	;keep track of time: magic doesn't
		bne	no_ewalls	;last forever

		move.w	#EWALL,d0	;time's up !
		move.w	#WALL,d1	
		moveq	#MASK4,d2
		bsr	replace_cells	;no more magic !

		sf	magic_walls

no_ewalls	rts
;---------------------------------------
neighb_offsets	dc.w	-COLUMNS,1,COLUMNS,-1	;U,R,D,L		
;---------------------------------------
; A0 -> SNAKE structure

handle_snake	tst.b	SNK_hatched(a0)
		beq	no_ewalls

		move.w	SNK_head_index(a0),d0
		move.w	d0,d1
		add.w	d1,d1
		add.w	d1,d1
		moveq	#0,d2
		move.b	SNK_dir_codes(a0,d0),d2
		move.w	d2,d3
		move.l	SNK_segm_ptrs(a0,d1),a1
		add.w	d3,d3
		move.l	a1,a3
		lea	neighb_offsets,a2
		adda.w	0(a2,d3),a3
		tst.b	(a3)		;AIR in front ?
		beq	move_snake	;no,
		cmp.b	#ROCK,(a3)	;ROCK in front ?
		bne	test_alt_dirs
		cmp.b	#EXPL_ROCK_FFLY,SNK_turn_rocks_into(a0)
		bne	unconditional
		move.w	#100,d1
		bsr	rnd
		cmp.w	#BSNAKE_BADNESS,d0
		bcc.s	test_alt_dirs
unconditional	move.b	SNK_turn_rocks_into(a0),(a3)

test_alt_dirs	move.w	d2,d3	;test relative RIGHT & LEFT cells
		addq.b	#1,d3
		and.w	#3,d3
		move.w	d3,d6	;rem new direction for relative RIGHT
		add.w	d3,d3
		move.l	a1,a3
		adda.w	0(a2,d3),a3
		move.l	a3,a4	;rem new address
		tst.b	(a3)
		seq	D4	;AIR at relative RIGHT

		move.w	d2,d3
		subq.b	#1,d3
		and.w	#3,d3
		move.w	d3,d7
		add.w	d3,d3
		move.l	a1,a3
		adda.w	0(a2,d3),a3
		tst.b	(a3)
		seq	D5	;AIR at relative LEFT

		tst.b	D4		;RIGHT blocked ?
		beq	snake_left	;no,
		tst.b	D5		;LEFT blocked ?
		beq	snake_right	;no,
		move.w	#10000,d1	;choose random direction
		bsr	rnd
		cmp.w	#5000,d0
		bcc	snake_left

snake_right	tst.b	D4		;can i go right ?
		beq	reverse_snake
		move.b	d6,d2
		move.l	a4,a3
		bra	move_snake

snake_left	tst.b	D5		;can i go left ?
		beq	reverse_snake
		move.b	d7,d2

move_snake	lea	SNK_head_index(a0),a6	;advance in circular buffer
		move.w	(a6),d0
		addq.w	#1,d0
		and.w	#7,d0
		move.w	d0,(a6)
		move.b	d2,SNK_dir_codes(a0,d0)	;same direction as old head
		add.w	d0,d0
		add.w	d0,d0
		cmp.b	#8,SNK_length(a0)
		beq	erase_tail
		addq.b	#1,SNK_length(a0)
		bra	grow_snake
erase_tail	move.l	SNK_segm_ptrs(a0,d0),a2
		clr.b	(a2)			;erase tail cell if len=8
grow_snake	move.l	a3,SNK_segm_ptrs(a0,d0)
		bra	copy_codes
;---------------------------------------
reverse_snake	move.b	SNK_length(a0),d0
		subq.b	#1,d0
		beq	copy_codes
		lea	SNK_reversebuf1(a0),a1
		lea	SNK_reversebuf2(a0),a2
		moveq	#0,d0
		move.b	SNK_length(a0),d0
		subq.b	#1,d0
		move.w	SNK_head_index(a0),d1
		move.w	d1,d2
		add.w	d2,d2
		add.w	d2,d2
rev_copy	move.l	SNK_segm_ptrs(a0,d2),(a1)+
		move.b	SNK_dir_codes(a0,d1),d3
		addq.b	#2,d3		;turn 180 degrees
		and.w	#3,d3
		move.b	d3,(a2)+
		subq.w	#1,d1		;go back !
		subq.w	#4,d2
		and.w	#7,d1
		and.w	#31,d2
		dbra	d0,rev_copy

		lea	SNK_reversebuf1(a0),a1
		lea	SNK_reversebuf2(a0),a2
		lea	SNK_segm_ptrs(a0),a3
		lea	SNK_dir_codes(a0),a4
		moveq	#8-1,d0
copy_snake_info	move.l	(a1)+,(a3)+
		move.b	(a2)+,(a4)+
		dbra	d0,copy_snake_info

		moveq	#0,d0
		move.b	SNK_length(a0),d0
		subq.w	#1,d0
		move.w	d0,SNK_head_index(a0)	;FALL THROUGH *!
;---------------------------------------
copy_codes	moveq	#1,d4
		and.w	anim_clock,d4

		move.w	SNK_head_index(a0),d0
		move.w	d0,d1
		add.w	d1,d1
		add.w	d1,d1
		moveq	#0,d2
		move.b	SNK_dir_codes(a0,d0),d2
		move.b	SNK_head_codes(a0,d2),d2
		or.b	d4,d2		;add animation
		move.l	SNK_segm_ptrs(a0,d1),a1
		move.b	d2,(a1)		;poke head cell

		move.b	SNK_length(a0),d3
		subq.b	#3,d3			;-head  -tail
		bmi.s	skip_segments
set_segments	subq.w	#1,d0			;going down !
		subq.w	#4,d1
		and.w	#7,d0
		and.w	#31,d1
		move.b	SNK_dir_codes(a0,d0),d2
		move.b	SNK_segm_codes(a0,d2),d2
		or.b	d4,d2
		move.l	SNK_segm_ptrs(a0,d1),a1
		move.b	d2,(a1)
		subq.b	#1,d3
		bpl.s	set_segments

skip_segments	move.b	SNK_length(a0),d3
		subq.b	#1,d3
		beq	no_tail
		subq.w	#1,d0
		subq.w	#4,d1
		and.w	#7,d0
		and.w	#31,d1
		move.b	SNK_dir_codes(a0,d0),d2
		move.b	SNK_tail_codes(a0,d2),d2
		or.b	d4,d2
		move.l	SNK_segm_ptrs(a0,d1),a1
		move.b	d2,(a1)
no_tail		rts
;---------------------------------------
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-	CELL	FUNCTIONS	*-*-*-*-*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
*
*	INPUTS		D0 	= current cel #
*			A1/A2	-> cell_map,flag_map current cel
*			A6	-> return addr to main loop !!!!!
*
*	MACROS use	D7(,D6(,D5))  as scratch register(s)

DONE	MACRO
	jmp	(a6)
	ENDM

;---------------------------------------
circle_offsets	dc.w	-COLUMNS,-COLUMNS+1,1,COLUMNS+1	;U,UR,R,DR
		dc.w	COLUMNS,COLUMNS-1,-1,-COLUMNS-1	;D,DL,L,UL
;---------------------------------------
big_butterfly	bchg	#7,d0		;flap wings
		tst.w	amiba_count	;if there are any AMIBAs around,
		beq	no_amibas
		bsr	touch_amiba1	;see if BUTTERFLY is touching one !

no_amibas	lea	circle_offsets,a0
		moveq	#3,d1
		and.w	d0,d1		;get current movement heading
		move.w	d1,d2		;00..11 for U/R/D/L
		add.w	d2,d2
		add.w	d2,d2		;skip diagonals
		move.w	d2,d3
		move.w	0(a0,d2),d3	;get addressing offset
		lea	0(a1,d3.w),a3
		lea	0(a2,d3.w),a4
		tst.b	(a3)		;obstacle in front ? (non-AIR cell)
		bne	rotate_bfly	;yes, turn anti-clockwise

		addq.w	#2,d2		;alternatively AIR diagonally right ?
		move.w	0(a0,d2),d3
		tst.b	0(a1,d3.w)
		bne	go_fwd_bfly

		addq.w	#1,d1		;hug walls
		and.w	#3,d1
		or.w	#BUTTER_FLY,d1
		and.w	#$80,d0
		or.w	d1,d0

go_fwd_bfly	move.b	d0,(a3)		;store 'animated' cell back
		st	(a4)

and_clear	SETCEL	AIR		
		DONE
;---------------
rotate_bfly	subq.w	#1,d1		;anti-clockwise turn on the
		and.w	#3,d1		;spot for obstacles
		or.w	#BUTTER_FLY,d1
		and.w	#$80,d0
		or.w	d0,d1
		SETCELR	d1
		DONE
;---------------------------------------
big_firefly	bchg	#7,d0		;rotate through banks 34,B4,3C,BC
		bne	no_high
		bchg	#3,d0
no_high		tst.w	amiba_count
		beq	no_amibas2
		bsr	touch_amiba2

no_amibas2	lea	circle_offsets,a0	
		moveq	#3,d1
		and.w	d0,d1		;get current heading
		move.w	d1,d2
		add.w	d2,d2
		add.w	d2,d2		;skip diagonals
		move.w	d2,d3
		move.w	0(a0,d2),d3	;get addressing offset
		lea	0(a1,d3.w),a3
		lea	0(a2,d3.w),a4
		tst.b	(a3)		;AIR in front ?
		bne	rotate_ffly
		move.w	d1,d2
		subq.w	#1,d2
		and.w	#3,d2
		add.w	d2,d2
		add.w	d2,d2
		addq.w	#2,d2		;and AIR diagonally left ?
		move.w	0(a0,d2),d3
		tst.b	0(a1,d3.w)
		bne	go_fwd_ffly

		subq.w	#1,d1		;hug walls
		and.w	#3,d1
		or.w	#FIRE_FLY,d1
		and.w	#$88,d0
		or.w	d1,d0
go_fwd_ffly	move.b	d0,(a3)
		st	(a4)
and_clear2	SETCEL	AIR
		DONE

rotate_ffly	addq.w	#1,d1		;clockwise turn on the
		and.w	#3,d1		;spot for obstacles
		or.w	#FIRE_FLY,d1
		and.w	#$88,d0
		or.w	d0,d1
		SETCELR	d1
		DONE
;---------------------------------------
rock		COMP_D	AIR		;if falling,
		bne	not_down
		addq.w	#1,d0		;can't use NEXCELL here
		moveq	#3,d1
		and.w	d0,d1
		or.w	#FROCK,d1
		SETR_D	d1
		SETCEL	AIR
		DONE

not_down	COMP_D	ROCK		;test unstability
		beq	unstable
		COMP_D	DIAMOND
		beq	unstable
		COMP_D	WALL
		beq	unstable

		move.w	#EXPL_FFLY_AIR,d2	;if on fire fly
		COMPM_D	FFLY_MASK,FIRE_FLY
		beq	kill_it00
		move.w	#EXPL_BFLY_DIAM,d2	;if on butter fly
		COMPM_D	BFLY_MASK,BUTTER_FLY
		beq	kill_it00
		move.w	#EXPL_AIR,d2
		COMPM_D	MASK8,MAN		;if on Rocky
		bne	done_rock

kill_it00	moveq	#MASK4,d1	;if I'm a killer rock AND
		and.w	d0,d1
		cmp.b	#FROCK,d1
		bne	done_rock
		move.w	d2,d0
		bsr	explode_under	;center under current cel

unstable	COMP_R	AIR		;test right diag slide
		bne	not_right
		COMP_DR	AIR
		bne	not_right
		SET_DR	FROCK
		SETCEL	AIR
		DONE

not_right	COMP_L	AIR		;test left diag slide
		bne	done_rock
		COMP_DL	AIR
		bne	done_rock
		SET_DL	FROCK
		SETCEL	AIR
		DONE

done_rock	moveq	#MASK4,d0
		and.b	(a1),d0
		cmp.b	#FROCK,d0
		bne	sit_there
		st	bonk
sit_there	SETCEL	ROCK		;always point up if stable
		DONE
;---------------------------------------
diamond		COMP_D	AIR		;if in mid air,
		bne	not_down2
		SET_D	FDIAMOND	;drop 1
		SETCEL	AIR
		DONE

not_down2	COMP_D	ROCK
		beq	unstable2
		COMP_D	DIAMOND
		beq	unstable2

		move.w	#EXPL_FFLY_AIR,d2	;if on fire fly
		COMPM_D	FFLY_MASK,FIRE_FLY
		beq	kill_it01
		move.w	#EXPL_BFLY_DIAM,d2	;on butter fly
		COMPM_D	BFLY_MASK,BUTTER_FLY
		beq	kill_it01		
		COMPM_D	MASK8,MAN		;on Rocky
		bne	done_rock2

kill_it01	cmp.b	#FDIAMOND,d0	;if falling diamond
		bne	done_rock2
		move.w	d2,d0
		bsr	explode_under	;destroy with center down 1

unstable2	COMP_R	AIR
		bne	not_right2
		COMP_DR	AIR
		bne	not_right2
		SET_DR	FDIAMOND
		SETCEL	AIR
		DONE

not_right2	COMP_L	AIR
		bne	done_rock2
		COMP_DL	AIR
		bne	done_rock2
		SET_DL	FDIAMOND
		SETCEL	AIR
		DONE

done_rock2	cmp.b	#FDIAMOND,(a1)
		bne	no_ping
		st	ping
no_ping		SETCEL	DIAMOND
		DONE
;---------------------------------------
; Growing Wall
; ------------
gwall		COMP_R	AIR
		bne	no_grow_r
		SET_R	GWALL
		DONE

no_grow_r	COMP_L	AIR
		bne	dont_grow
		SET_L	GWALL
dont_grow	DONE
;---------------------------------------
; Enchanted Wall	(turns Rocks into Diamonds once a rock drops on it)
; --------------
ewall		tst.b	magic_walls	;magic mode activated ?
		beq	not_started

		NEXCELL	MASK4,EWALL
		COMP_U	ROCK		;has to be a stable rock
		bne	maybe_diam
		SET_U	EXPL_AIR
		COMP_D	AIR
		bne	no_cave
		SET_D	DIAMOND
		DONE

maybe_diam	COMP_U	DIAMOND
		bne	no_cave
		SET_U	EXPL_AIR
		COMP_D	AIR
		bne	no_cave
		SET_D	ROCK
no_cave		DONE
;---------------
not_started	COMPM_U	MASK4,FROCK	;is a Falling Rock on top of me ?
		bne	maybe_diam2	;yes,

start_magic	st	magic_walls	;start magic mode
		move.w	#MAGIC_TIME,magic_timer	;and start a timer
		DONE

maybe_diam2	COMP_U	FDIAMOND	;or maybe a Falling Diamond ?
		beq	start_magic
		DONE
;---------------------------------------
fwall		NEXCELL	MASK4,FWALL		;animate FILTER wall

		move.w	#400,d1			;every so often...
		bsr	rnd
		subq.w	#2,d0			;see if we should let something
		bpl.s	block_filter		;drop through

		COMP_D	AIR			;cavity underneath to receive
		bne	block_filter		;ROCK or DIAMOND ?

		COMP_U	ROCK
		bne	pass_diam		;yes,
		SET_U	EXPL_AIR		;dissolve ROCK above wall
		SET_D	FROCK			;and gen ROCK below wall !
		DONE

pass_diam	COMP_U	DIAMOND
		bne	block_filter
		SET_U	AIR
		SET_D	DIAMOND
block_filter	DONE
;---------------------------------------
amiba		moveq	#AMIBA_SPEED,d1
		bsr	rnd
		subq.w	#2,d0
		spl	D1		;if D1=TRUE don't occupie if poss.
		and.w	#3,d0
		or.w	#AMIBA,d0	;random AMIBA char
		SETCELR	d0
		
		COMPM_R	MASK2,AIR	;if (AIR or GRASS)
		bne	encl_00
		tst.b	D1
		bne	sneaky
		SETR_R	D0		;occupy cell
		bra	done_amiba

encl_00		COMPM_L	MASK2,AIR
		bne	encl_01
		tst.b	D1
		bne	sneaky
		SETR_L	D0
		bra	done_amiba

encl_01		COMPM_U	MASK2,AIR
		bne	encl_02
		tst.b	D1
		bne	sneaky
		SETR_U	D0
		bra	done_amiba

encl_02		COMPM_D	MASK2,AIR
		bne	stuck
eat_03		tst.b	D1
		bne	sneaky
		SETR_D	D0

done_amiba	addq.w	#1,amiba_count
sneaky		st	added_amiba
stuck		DONE
;---------------------------------------
;--------------- TAP STUFF
;---------------------------------------
water_tap	tst.b	water_taps_on
		beq	dont_leak
		NEXCELL	MASK4,WATER_TAP
		move.w	anim_clock,d0
		addq.w	#4,d0
		and.w	#DROPS_SPEED<<1+1,d0
		bne	dont_leak
		COMP_D	AIR
		bne	dont_leak
		SET_D	FALLING_DROP
dont_leak	DONE
;---------------------------------------
fall_drop	btst	#0,anim_clock+1
		bne	dont_leak
		bchg	#0,(a1)
		moveq	#DROPS_SPEED,d1
		and.w	anim_clock,d1
		bne	dont_leak
		COMP_D	AIR
		bne	fire_collide
		addq.w	#1,d0
		and.w	#1,d0
flow		or.b	#FALLING_DROP,d0
		SETR_D	d0
		SETCEL	AIR
		DONE
		
fire_collide	COMPM_D	MASK4,FLAME
		beq	fire_and_water
		SETCEL	EXPL_DROP
		DONE

fire_and_water	move.w	#EXPL_AIR,d0
		bsr	explode
;---------------------------------------
horiz_drop_r	bsr	touch_bfly
		btst	#0,anim_clock+1
		bne	dont_leak
		bchg	#0,(a1)
		moveq	#DROPS_SPEED,d1
		and.w	anim_clock,d1
		bne	dont_leak
		addq.w	#1,d0
		and.w	#1,d0
		COMP_D	AIR
		beq	flow
flow_right	COMP_R	AIR
		bne	flow_left
		or.w	#HR_DROP,d0
		SETR_R	d0
		SETCEL	AIR
		DONE

flow_left	COMP_L	AIR
		bne	get_nervous
		or.w	#HL_DROP,d0
		SETR_L	d0
		SETCEL	AIR
		DONE

get_nervous	move.w	#100,d1
		bsr	rnd
		cmp.w	#DROP_NERVES,d0
		bcc.s	kool_it
		SETCEL	EXPL_AIR
kool_it		DONE
;---------------------------------------
horiz_drop_l	bsr	touch_bfly
		btst	#0,anim_clock+1
		bne	dont_leak
		bchg	#0,(a1)
		moveq	#DROPS_SPEED,d1
		and.w	anim_clock,d1
		bne	dont_leak
		addq.w	#1,d0
		and.w	#1,d0
		COMP_D	AIR
		beq	flow
		COMP_L	AIR
		beq	flow_left
		COMP_R	AIR
		beq	flow_right
		bra	get_nervous
;---------------------------------------
fire_tap	tst.b	fire_taps_on
		beq	no_fires
		NEXCELL	MASK4,FIRE_TAP
		move.w	anim_clock,d0
		addq.w	#4,d0
		and.w	#DROPS_SPEED<<1+1,d0
		bne	no_fires
		COMP_U	AIR
		bne	no_fires
		SET_U	FLAME
no_fires	DONE
;---------------------------------------
flame		COMP_U	AIR
		bne	flame_stuck
burn		moveq	#DROPS_SPEED,d1
		and.w	anim_clock,d1
		bne	dont_rise
		addq.w	#1,d0
		and.w	#1,d0
		or.w	#FLAME,d0
		SETR_U	d0
		SETCEL	AIR
		DONE

flame_stuck	SETCEL	HR_FLAME
dont_rise	DONE
;---------------------------------------
horiz_flame_r	COMP_U	AIR
		beq	burn
		moveq	#DROPS_SPEED,d1
		and.w	anim_clock,d1
		bne	no_fires
		COMP_R	AIR
		beq	burn_right0
		COMP_R	DIAMOND
		bne	burn_left0
		SET_R	EXPL_DIAM_BFLY
		DONE

burn_right0	addq.w	#1,d0
		and.w	#1,d0
		or.w	#HR_FLAME,d0
		SETR_R	d0
		SETCEL	AIR
		DONE

burn_left0	COMP_L	AIR
		bne	get_nervous
		SET_L	HL_FLAME
		SETCEL	AIR
		DONE
;---------------------------------------
horiz_flame_l	COMP_U	AIR
		beq	burn
		moveq	#DROPS_SPEED,d0
		and.w	anim_clock,d0
		bne	no_fires
		COMP_L	AIR
		beq	burn_left1
		COMP_L	DIAMOND
		bne	burn_right1
		SET_L	EXPL_DIAM_BFLY
		DONE

burn_left1	addq.w	#1,d0
		and.w	#1,d0
		or.w	#HL_FLAME,d0
		SETR_L	d0
		SETCEL	AIR
		DONE

burn_right1	COMP_R	AIR
		bne	get_nervous
		SET_R	HR_FLAME
		SETCEL	AIR
		DONE
;---------------------------------------
MAN_U	equ	0
MAN_R	equ	2
MAN_D	equ	4
MAN_L	equ	6
MAN_PR	equ	8
MAN_PL	equ	10

SETCHAR		MACRO
		moveq	#1,d0
		and.w	anim_clock,d0
		or.w	#\1,d0
		move.w	d0,man_char
		ENDM
;---------------------------------------
Rocky		tst.b	die_anyway
		bne	byebye
		tst.b	out_of_time	
		beq	dont_die
byebye		sf	die_anyway
		move.w	#EXPL_BFLY_DIAM,d0
		bsr	explode

dont_die	sf	rockf_died		;I'm still alive !
		tst.b	disable_rockf
		bne	noblasting
		bsr	touch_bfly
		bsr	touch_ffly
		move.w	joystick,d0		;read in fixed 'time place'
		btst	#FIRE,d0
		bne	blast_cell
;---------
walk_right	btst	#RIGHT,d0		;joystick pulled RIGHT ?
		beq	walk_left		;yes,

		COMPM_R	MASK2,AIR		;AIR in next cell?
		beq	move_right		;yes: move into it
		COMPM_R	MASK16,DROPLETS		;WATER DROPS in next cell?
		beq	move_right		;yes: move into it
		COMP_R	DIAMOND			;DIAMOND in next cell?
		bne	test_rest00
		bsr	add_diamond		;eat DIAMOND (score++,diam--)
		bra	move_right

test_rest00	COMPM_R	MASK8,ROCK	;if pushing against ROCK + AIR,
		bne	test_rest01
		COMP_RR	AIR
		bne	hopeless1
		subq.b	#1,energy	;see if energy count OK
		bne	hopeless1
		moveq	#PUSH,d1	;(generate new value for next time)
		bsr	rnd
		addq.w	#1,d0
		move.b	d0,energy
		move.b	2(a1),d0	;get rock frame #
		addq.b	#1,d0		;animate rolling rock 
		moveq	#3,d1
		and.b	d1,d0
		or.b	#FROCK,d0
		SETR_RR	d0
		bra	move_right

test_rest01	COMPM_R	MASK4,EXIT	;next cell is EXIT ?
		bne	test_rest02	;yes,
		tst.b	enough_diamonds	;enough DIAMONDs collected ?
		beq	hopeless1
		st	found_exit	;got EXIT !
		bra	move_right	;move into that cell

test_rest02	COMPM_R	MASK4,EXTRA_L
		bne	test_rest03a
		addq.w	#1,lives
		bsr	show_lives
		bra	move_right
test_rest03a	COMPM_R	MASK4,EXTRA_T
		bne	test_rest03
		add.w	#BONUS_SECS,time_left
		bra	move_right
test_rest03	COMPM_R	MASK4,NUMBER
		bne	test_rest04
		moveq	#3,d0
		and.b	1(a1),d0
		mulu	#1000,d0
		add.l	d0,score
		bra	move_right
test_rest04	COMPM_R	MASK4,WATER_TAP
		bne	test_rest05
		st	water_taps_on
		bra	hopeless1
test_rest05	COMPM_R	MASK4,FIRE_TAP
		bne	test_rest06
		st	fire_taps_on
		bra	hopeless1
test_rest06	COMPM_R	MASK4,GEGG
		bne	test_rest07
		clr.w	gegg_timer	;wake up snake !
		bra	hopeless1
test_rest07	COMPM_R	MASK4,BEGG
		bne	hopeless1
		clr.w	begg_timer
hopeless1	SETCHAR	MAN_PR
		SETCEL	MAN
		DONE

move_right	SETCHAR	MAN_R
		SET_R	MAN
		SETCEL	AIR
		addq.w	#1,rf_x
		bra	step_sound
;--------
walk_left	btst	#LEFT,d0
		beq	walk_up

		COMPM_L	MASK2,AIR
		beq	move_left
		COMPM_L	MASK16,DROPLETS
		beq	move_left
		COMP_L	DIAMOND
		bne	test_rest10
		bsr	add_diamond
		bra	move_left
test_rest10	COMPM_L	MASK8,ROCK
		bne	test_rest11
		COMP_LL	AIR
		bne	hopeless2
		subq.b	#1,energy
		bne	hopeless2
		moveq	#PUSH,d1
		bsr	rnd
		addq.w	#1,d0
		move.b	d0,energy
		move.b	-2(a1),d0
		subq.b	#1,d0
		moveq	#3,d1
		and.b	d1,d0
		or.b	#FROCK,d0
		SETR_LL	d0
		bra	move_left
test_rest11	COMPM_L	MASK4,EXIT
		bne	test_rest12
		tst.b	enough_diamonds
		beq	hopeless2
		st	found_exit
		bra	move_left
test_rest12	COMPM_L	MASK4,EXTRA_L
		bne	test_rest13a
		addq.w	#1,lives
		bsr	show_lives
		bra	move_left
test_rest13a	COMPM_L	MASK4,EXTRA_T
		bne	test_rest13
		add.w	#BONUS_SECS,time_left
		bra	move_left
test_rest13	COMPM_L	MASK4,NUMBER
		bne	test_rest14
		moveq	#3,d0
		and.b	-1(a1),d0
		mulu	#1000,d0
		add.l	d0,score
		bra	move_left
test_rest14	COMPM_L	MASK4,WATER_TAP
		bne	test_rest15
		st	water_taps_on
		bra	hopeless2
test_rest15	COMPM_L	MASK4,FIRE_TAP
		bne	test_rest16
		st	fire_taps_on
		bra	hopeless2
test_rest16	COMPM_L	MASK4,GEGG
		bne	test_rest17
		clr.w	gegg_timer
		bra	hopeless2
test_rest17	COMPM_L	MASK4,BEGG
		bne	hopeless2
		clr.w	begg_timer
hopeless2	SETCHAR	MAN_PL
		SETCEL	MAN
		DONE

move_left	SETCHAR	MAN_L
		SET_L	MAN
		SETCEL	AIR
		subq.w	#1,rf_x
		bra	step_sound
;--------
walk_up		btst	#UP,d0
		beq	walk_down
		COMPM_U	MASK2,AIR
		beq	move_up
		COMPM_U	MASK16,DROPLETS
		beq	move_up
		COMP_U	DIAMOND
		bne	test_rest20
		bsr	add_diamond
		bra	move_up
test_rest20	COMPM_U	MASK4,EXIT
		bne	test_rest21
		tst.b	enough_diamonds
		beq	stay
		st	found_exit
		bra	move_up
test_rest21	COMPM_U	MASK4,EXTRA_T
		bne	test_rest22
		add.w	#BONUS_SECS,time_left
		bra	move_up
test_rest22	COMPM_U	MASK4,EXTRA_L
		bne	test_rest23a	
		addq.w	#1,lives
		bsr	show_lives
		bra	move_up
test_rest23a	COMPM_U	MASK4,NUMBER
		bne	test_rest23
		moveq	#3,d0
		and.b	-COLUMNS(a1),d0
		mulu	#1000,d0
		add.l	d0,score
		bra	move_up
test_rest23	COMPM_U	MASK4,WATER_TAP
		bne	test_rest24
		st	water_taps_on
		bra	stay
test_rest24	COMPM_U	MASK4,FIRE_TAP
		bne	test_rest25
		st	fire_taps_on
		bra	stay
test_rest25	COMPM_U	MASK4,GEGG
		bne	test_rest26
		clr.w	gegg_timer
		bra	stay
test_rest26	COMPM_U	MASK4,BEGG
		bne	stay
		clr.w	begg_timer
		bra	stay

move_up		SETCHAR	MAN_U
		SET_U	MAN
		SETCEL	AIR
		subq.w	#1,rf_y
		bra	step_sound
;---------
walk_down	btst	#DOWN,d0
		beq	stay
		COMPM_D	MASK2,AIR
		beq	move_down
		COMPM_D	MASK16,DROPLETS
		beq	move_down
		COMP_D	DIAMOND
		bne	test_rest30
		bsr	add_diamond
		bra	move_down
test_rest30	COMPM_D	MASK4,EXIT
		bne	test_rest31
		tst.b	enough_diamonds
		beq	stay
		st	found_exit
		bra	move_down
test_rest31	COMPM_D	MASK4,EXTRA_L
		bne	test_rest32a
		addq.w	#1,lives
		bsr	show_lives
		bra	move_down
test_rest32a	COMPM_D	MASK4,EXTRA_T
		bne	test_rest32
		add.w	#BONUS_SECS,time_left
		bra	move_down
test_rest32	COMPM_D	MASK4,NUMBER
		bne	test_rest33
		moveq	#3,d0
		and.b	COLUMNS(a1),d0
		mulu	#1000,d0
		add.l	d0,score
		bra	move_down
test_rest33	COMPM_D	MASK4,WATER_TAP
		bne	test_rest34
		st	water_taps_on
		bra	stay
test_rest34	COMPM_D	MASK4,FIRE_TAP
		bne	test_rest35
		st	fire_taps_on
		bra	stay
test_rest35	COMPM_D	MASK4,GEGG
		bne	test_rest36
		clr.w	gegg_timer
		bra	stay
test_rest36	COMPM_D	MASK4,BEGG
		bne	stay
		clr.w	begg_timer
		bra	stay

move_down	SETCHAR	MAN_D
		SET_D	MAN
		SETCEL	AIR
		addq.w	#1,rf_y
		bra	step_sound

stay		SETCEL	WMAN
		DONE

blast_cell	btst	#RIGHT,d0
		beq	nobl_right	
		COMPM_R	MASK2,AIR	;(AIR or GRASS)
		beq	blast00
		COMPM_R	MASK16,DROPLETS	;(DROPS & FIRE)
		beq	blast00
		COMP_R	DIAMOND
		bne	blast_rock0
		bsr	add_diamond
		bra	blast00
blast_rock0	COMPM_R	MASK8,ROCK	;if pushing against ROCK + AIR,
		bne	noblasting
		COMP_RR	AIR
		bne	noblasting
		move.b	2(a1),d0	;get rock frame #
		addq.b	#1,d0		;animate rolling rock 
		moveq	#3,d1
		and.b	d1,d0
		or.b	#FROCK,d0
		SETR_RR	d0
blast00		SET_R	EXPL_AIR
		bra	blast_sound

nobl_right	btst	#LEFT,d0
		beq	nobl_left
		COMPM_L	MASK2,AIR
		beq	blast01
		COMPM_L	MASK16,DROPLETS
		beq	blast01
		COMP_L	DIAMOND
		bne	blast_rock1
		bsr	add_diamond
		bra	blast01
blast_rock1	COMPM_L	MASK8,ROCK
		bne	noblasting
		COMP_LL	AIR
		bne	noblasting
		move.b	-2(a1),d0
		subq.b	#1,d0
		moveq	#3,d1
		and.b	d1,d0
		or.b	#FROCK,d0
		SETR_LL	d0
blast01		SET_L	EXPL_AIR
		bra	blast_sound

nobl_left	btst	#UP,d0
		beq	nobl_up
		COMPM_U	MASK2,AIR
		beq	blast02
		COMPM_U	MASK16,DROPLETS
		beq	blast02
		COMP_U	DIAMOND
		bne	noblasting
		bsr	add_diamond
blast02		SET_U	EXPL_AIR
		bra	blast_sound

nobl_up		btst	#DOWN,d0
		beq	noblasting
		COMPM_D	MASK2,AIR
		beq	blast03
		COMPM_D	MASK16,DROPLETS
		beq	blast03
		COMP_D	DIAMOND
		bne	noblasting
		bsr	add_diamond
blast03		SET_D	EXPL_AIR
		bra	blast_sound

noblasting	DONE
;---------------------------------------
step_sound	moveq	#1,d0
		not.b	one_two
		bne	step2
		moveq	#0,d0
step2		moveq	#2,d1
;		
		DONE
;---------------------------------------
blast_sound	moveq	#8,d0
		moveq	#2,d1
;
		DONE
;---------------------------------------
gegg		NEXCELL	MASK4,GEGG
		subq.w	#1,gegg_timer
		bpl.s	dont_hatch
		st	gsnake_struct+SNK_hatched
		SETCEL	GS_HEAD
dont_hatch	DONE
;---------------------------------------
begg		NEXCELL	MASK4,BEGG
		subq.w	#1,begg_timer
		bpl.s	dont_hatch2
		st	bsnake_struct+SNK_hatched
		SETCEL	BS_HEAD
dont_hatch2	DONE
;---------------------------------------
;--------------- QUICK MUTATIONS
;---------------------------------------
diam_bfly_1	SETCEL	EXPL_DIAM_BFLY+1
		DONE
;---------------------------------------
diam_bfly_2	SETCEL	EXPL_DIAM_BFLY+2
		DONE
;---------------------------------------
diam_bfly_3	SETCEL	EXPL_DIAM_BFLY+3
		DONE
;---------------------------------------
diam_bfly_4	SETCEL	BUTTER_FLY
		DONE
;---------------------------------------
bfly_diam_1	SETCEL	EXPL_BFLY_DIAM+1
		DONE
;---------------------------------------
bfly_diam_2	SETCEL	EXPL_BFLY_DIAM+2
		DONE
;---------------------------------------
bfly_diam_3	SETCEL	EXPL_BFLY_DIAM+3
		DONE
;---------------------------------------
bfly_diam_4	SETCEL	DIAMOND
		DONE
;---------------------------------------
rock_ffly_1	SETCEL	EXPL_ROCK_FFLY+1
		DONE
;---------------------------------------
rock_ffly_2	SETCEL	EXPL_ROCK_FFLY+2
		DONE
;---------------------------------------
rock_ffly_3	SETCEL	EXPL_ROCK_FFLY+3
		DONE
;---------------------------------------
rock_ffly_4	SETCEL	FIRE_FLY
		DONE
;---------------------------------------
ffly_air_1	SETCEL	EXPL_FFLY_AIR+1
		DONE
;---------------------------------------
ffly_air_2	SETCEL	EXPL_FFLY_AIR+2
		DONE
;---------------------------------------
ffly_air_3	SETCEL	EXPL_FFLY_AIR+3
		DONE
;---------------------------------------
ffly_air_4	SETCEL	AIR
		DONE
;---------------------------------------
air_expl_1	SETCEL	EXPL_AIR+1
		DONE
;---------------------------------------
air_expl_2	SETCEL	AIR
		DONE
;---------------------------------------
bonus_1		SETCEL	NUMBER+1
		DONE
;---------------------------------------
bonus_2		SETCEL	NUMBER+2
		DONE
;---------------------------------------
bonus_3		SETCEL	NUMBER+3
		DONE
;---------------------------------------
bonus_4		SETCEL	NUMBER
		DONE
;---------------------------------------
extra_t1	SETCEL	EXTRA_T+1
		DONE
;---------------------------------------
extra_t2	SETCEL	EXTRA_T+2
		DONE
;---------------------------------------
extra_t3	SETCEL	EXTRA_T+3
		DONE
;---------------------------------------
extra_t4	SETCEL	EXTRA_T
		DONE
;---------------------------------------
extra_l1	SETCEL	EXTRA_L+1
		DONE
;---------------------------------------
extra_l2	SETCEL	EXTRA_L+2
		DONE
;---------------------------------------
extra_l3	SETCEL	EXTRA_L+3
		DONE
;---------------------------------------
extra_l4	SETCEL	EXTRA_L
		DONE
;---------------------------------------
amib_rock_1	SETCEL	EXPL_AMIB_ROCK+1
		DONE
;---------------------------------------
amib_rock_2	SETCEL	ROCK
		DONE
;---------------------------------------
amib_diam_1	SETCEL	EXPL_AMIB_DIAM+1
		DONE
;---------------------------------------
amib_diam_2	SETCEL	DIAMOND
		DONE
;---------------------------------------
expl_drop1	moveq	#DROPS_SPEED>>1,d0
		and.w	anim_clock,d0
		bne	door_shut
		SETCEL	EXPL_DROP+1
		DONE
;---------------------------------------
expl_drop2	moveq	#DROPS_SPEED>>1,d0
		and.w	anim_clock,d0
		bne	door_shut
		SETCEL	HR_DROP
		DONE
;---------------------------------------
exit_1		tst.b	enough_diamonds
		beq	door_shut
		SETCEL	EXIT+1
door_shut	DONE
;---------------------------------------
exit_2		SETCEL	EXIT+2
		DONE
;---------------------------------------
exit_3		SETCEL	EXIT+3
		DONE
;---------------------------------------
exit_4		SETCEL	EXIT
		DONE
;---------------------------------------
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-	SUPPORTING CELL	FUNCTIONS	*-*-*-*-*-
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

touch_amiba1	move.w	#AMIBA,d1
		moveq	#MASK4,d2
		move.w	#EXPL_BFLY_DIAM,d3
		bra	red_hot
touch_amiba2	move.w	#AMIBA,d1
		moveq	#MASK4,d2
		move.w	#EXPL_FFLY_AIR,d3
		bra	red_hot
touch_ffly	move.w	#FIRE_FLY,d1
		moveq	#FFLY_MASK,d2
		move.w	#EXPL_FFLY_AIR,d3
		bra	red_hot
touch_bfly	move.w	#BUTTER_FLY,d1
		moveq	#BFLY_MASK,d2
		move.w	#EXPL_BFLY_DIAM,d3	;fall through !
;---------------------------------------
; D1 = cell to TOUCH
; D2 = explosion primer if touching

red_hot		CPMRR_U	d2,d1
		beq	explodeA
		CPMRR_R	d2,d1
		beq	explodeA
		CPMRR_D	d2,d1
		beq	explodeA
		CPMRR_L	d2,d1
		beq	explodeA
		rts
explodeA	move.w	d3,d0
		bra	explode
;---------------------------------------
; D0 = EXPLOSION PRIMER
;  *! CHANGE compares to masked compares if necessary !!

SETEXPL		MACRO
		lea	\2(a1),a0
		move.b	(a0),d7
		cmp.b	d1,d7
		beq	\1
		moveq	#MASK4,d6	;EXIT CONSISTS OF 4 CELLS
		and.w	d7,d6
		cmp.b	d2,d6
		beq	\1
		cmp.b	d3,d6		;TAPS ARE 4 CELLS
		beq	\1
		cmp.b	d4,d6
		beq	\1
		move.b	d0,(a0)
		st	\2(a2)
		ENDM

explode_under	add.w	#COLUMNS,a1
		add.w	#COLUMNS,a2

explode		move.w	#RWALL,d1	;set 3*3 square to explosion
		move.w	#EXIT,d2	;primer except for indestr. cells
		move.w	#WATER_TAP,d3
		move.w	#FIRE_TAP,d4

		SETEXPL	leave00,-COLUMNS-1	;UL	
leave00		SETEXPL	leave01,-COLUMNS	;U
leave01		SETEXPL	leave02,-COLUMNS+1	;UR
leave02		SETEXPL	leave03,1		;R
leave03		SETEXPL	leave04,COLUMNS+1	;DR
leave04		SETEXPL	leave05,COLUMNS		;D
leave05		SETEXPL	leave06,COLUMNS-1	;DL
leave06		SETEXPL	leave07,-1		;L
leave07		SETEXPL	leave08,0		;C
leave08		tst.l	(SP)+		;pop a level
		move.l	a6,-(SP)
		moveq	#4,d0
		moveq	#0,d1		;same as bonk
;
		move.l	(SP)+,a6
		DONE
;---------------------------------------
add_diamond	move.l	price,d0
		add.l	d0,score
		subq.w	#1,diamonds
		moveq	#5,d0
		moveq	#3,d1
;
		rts
;---------------------------------------
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--
;---------------------------------------
gsnake_cells	dc.b	GS_HEAD+0,GS_HEAD+2,GS_HEAD+4,GS_HEAD+6
		dc.b	GS_SEGM+0,GS_SEGM+2,GS_SEGM+4,GS_SEGM+6
		dc.b	GS_TAIL+0,GS_TAIL+2,GS_TAIL+4,GS_TAIL+6

bsnake_cells	dc.b	BS_HEAD+0,BS_HEAD+2,BS_HEAD+4,BS_HEAD+6
		dc.b	BS_SEGM+0,BS_SEGM+2,BS_SEGM+4,BS_SEGM+6
		dc.b	BS_TAIL+0,BS_TAIL+2,BS_TAIL+4,BS_TAIL+6

init_snakes	move.w	#GEGG,d0
		bsr	find_cell
		spl	good_snake
		bmi.s	scan_for_bad
		move.l	a0,gsnake_struct+SNK_segm_ptrs
		lea	gsnake_struct,a0
		clr.w	SNK_head_index(a0)
		move.b	#EXPL_AMIB_DIAM,SNK_turn_rocks_into(a0)
		move.b	#1,SNK_length(a0)
		clr.l	SNK_dir_codes(a0)		;all facing UP
		clr.l	SNK_dir_codes+4(a0)
		sf	SNK_hatched(a0)
		lea	gsnake_cells,a1
		bsr	copy_snake_cells
		move.w	#G_HATCH_TIME,gegg_timer

scan_for_bad	move.w	#BEGG,d0
		bsr	find_cell
		spl	bad_snake
		bmi.s	no_bad_snake
		move.l	a0,bsnake_struct+SNK_segm_ptrs
		lea	bsnake_struct,a0
		clr.w	SNK_head_index(a0)
		move.b	#EXPL_ROCK_FFLY,SNK_turn_rocks_into(a0)
		move.b	#1,SNK_length(a0)
		clr.l	SNK_dir_codes(a0)
		clr.l	SNK_dir_codes+4(a0)
		sf	SNK_hatched(a0)
		lea	bsnake_cells,a1
		bsr	copy_snake_cells
		move.w	#B_HATCH_TIME,begg_timer
no_bad_snake	rts
;---------------------------------------
copy_snake_cells lea	SNK_head_codes(a0),a2
		moveq	#3*4-1,d0
copy_sncells	move.b	(a1)+,(a2)+
		dbra	d0,copy_sncells
		rts
;---------------------------------------
init_divu_table	move.l	divu_table,a0
		moveq	#0,d7
gen_divtab	move.l	d7,d0
		divu	#20,d0
		move.l	d0,(a0)+
		addq.w	#1,d7
		cmp.w	#256,d7
		bne	gen_divtab
		rts
;---------------------------------------
show_lives	rts
;---------------------------------------
add_secs_left	bra	while_secs
time_bonus	moveq	#3,d0
		and.l	score,d0
		bne	no_tock
		moveq	#7,d0
		moveq	#1,d1
		not.b	one_two
		bne	tick2
		moveq	#6,d0
		moveq	#0,d1		
tick2		NOP
;

no_tock		addq.l	#1,score
		bsr	update_score
		bsr	update_time
		move.l	#7000,d0
		bsr	delay
while_secs	tst.w	time_left
		bne	time_bonus
		rts
;---------------------------------------
find_rf		move.w	#MAN,d0
		bsr	find_cell
		bmi.s	no_man
		movem.w	d0/d1,rf_x
		rts
no_man		clr.l	rf_x		;& rf_y
		rts
;---------------------------------------
count_amibas	move.w	#AMIBA,d0
		bsr	count_cells
		move.w	d1,amiba_count
		rts
;---------------------------------------
; D0 = cells to count		returns in D1

count_cells	lea	cell_map,a0
		clr.w	d1		;clear count
		move.w	#MAP_SIZE-1,d2
count_loop	cmp.b	(a0)+,d0
		dbeq	d2,count_loop
		bne	map_scanned
		addq.w	#1,d1
		subq.w	#1,d2
		bpl.s	count_loop
map_scanned	rts
;---------------------------------------
; D0 = cell to find	BMI for not found

find_cell	lea	cell_map,a0
		move.l	a0,a1
		move.w	#MAP_SIZE-1,d2
search_cell	cmp.b	(a1)+,d0
		dbeq	d2,search_cell
		bne	not_found
		subq.w	#1,a1
		move.l	a1,-(SP)
		suba.l	a0,a1
		move.l	a1,d1
		move.l	(SP)+,a0
		divu	#COLUMNS,d1
		move.l	d1,d0
		swap	d0
		rts
not_found	moveq	#-1,d0		;MINUS for error
		rts
;---------------------------------------
; D0 = general code
; D1 = replace cell
; D2 = mask

replace_cells	lea	cell_map,a0
		move.w	#MAP_SIZE-1,d3
look_for_cells	move.b	(a0),d4
		and.b	d2,d4
		cmp.b	d0,d4
		beq	change_cell
		addq.w	#1,a0
		dbra	d3,look_for_cells
		rts
change_cell	move.b	d1,(a0)+
		subq.w	#1,d3
		bpl.s	look_for_cells
none_found	rts
;---------------------------------------
open_libraries	movea.l	4.w,a6
		lea	intui_name,a1
		moveq	#0,d0
		EXEC	OpenLibrary
		move.l	d0,INTUI_LIB_PTR

		lea	gfx_name,a1
		moveq	#0,d0
		EXEC	OpenLibrary
		move.l	d0,GFX_LIB_PTR

		lea	dos_name,a1
		moveq	#0,d0
		EXEC	OpenLibrary
		move.l	d0,DOS_LIB_PTR
		rts	
;---------------------------------------
close_libraries	move.l	4.w,a6

		move.l	INTUI_LIB_PTR,a1
		EXEC	CloseLibrary

		move.l	GFX_LIB_PTR,a1
		EXEC	CloseLibrary

		move.l	DOS_LIB_PTR,a1
		EXEC	CloseLibrary
		rts
;---------------------------------------
open_screen	move.l	INTUI_LIB_PTR,a6
		lea	rocky_screendef,a0
		INTUI	OpenScreen

		move.l	d0,myscreen
		move.l	d0,window_screen
		move.l	d0,a0
		lea	sc_ViewPort(a0),a1
		move.l	a1,myviewport
		lea	sc_RastPort(a0),a1
		move.l	a1,myrastport
		lea	184(a0),a1
		move.l	a1,mybitmap

		addq.w	#8,a1			;goto bm_Planes
		move.l	a1,plane_ptrs
		lea	screen_base,a3
		moveq	#PLANES-1,d0

set_scrptrs	move.l	(a1)+,a2		;get Intui Plane ptr
		add.w	#20*SCREEN_WIDTH,a2	;add offset to playfield
		move.l	a2,(a3)+		;store
		dbra	d0,set_scrptrs

		move.l	myviewport,a0
		lea	screen_colors,a1
		moveq	#8,d0
		move.l	GFX_LIB_PTR,a6
		GFX	LoadRGB4		;set screen colors

open_window	move.l	INTUI_LIB_PTR,a6
		lea	windowdef,a0
		INTUI	OpenWindow
		move.l	d0,mywindow
		move.l	d0,a0
		move.l	wd_UserPort(a0),mymsgport
		move.l	mymsgport,a0
		move.b	MP_SIGBIT(a0),d0
		moveq	#1,d1
		lsl.l	d0,d1
		move.l	d1,waitmask
		rts
;---------------------------------------
close_screen	move.l	INTUI_LIB_PTR,a6
		move.l	mywindow,a0
		INTUI	CloseWindow

		move.l	myscreen,a0
		INTUI	CloseScreen
		rts
;---------------------------------------
test_IDCMP	move.l	4.w,a6
		move.l	mymsgport,a0
		EXEC	GetMsg		;see if Intuition
		tst.l	d0			;sent us a msg
		beq	dummy

		move.l	d0,a1
		move.l	im_Class(a1),imsg_class		;copy relevant info
		move.w	im_Code(a1),imsg_code
		move.l	im_IAddress(a1),imsg_addr
		move.l	im_MouseX(a1),imsg_ratcords
		EXEC	ReplyMsg			;and return msg
		move.l	imsg_class,d0
		lea	event_routines,a0
		bra	scan_types
possible_event	move.l	(a0)+,a1
		cmp.l	d0,d1

		bne	scan_types
		jmp	(a1)			;execute event handler

scan_types	move.l	(a0)+,d1
		bpl.s	possible_event
		rts

event_routines	dc.l	VANILLAKEY,keypress
		dc.l	-1

*		dc.l	RAWKEY,keypress
*		dc.l	GADGETUP,intui_gadget
*		dc.l	MOUSEBUTTONS,gadget_press
*		dc.l	CLOSEWINDOW,quit_me

;---------------------------------------
; Here we insert a DOS delay loop depending on which machine/config we're running on.
;---------------------------------------

tune_game_speed	move.l	4.w,a6		; -> Exec structure
		move.w	AttnFlags(a6),d0 ;what kind of processor is this ?
		beq	need_the_juice	;if plain old 68000 then don't delay at all !!!
		
		btst	#AFB_68040,d0	;040 based Amiga ?
		beq	not_040
		moveq	#6,d1		;.... I guess
		bra	delay_game

not_040		btst	#AFB_68030,d0	;030 based Amiga ?
		beq	not_030
		moveq	#3,d1		;for a 25Mhz A3000 (coz that's what I've got)
		bra	delay_game

not_030		btst	#AFB_68020,d0
		beq	need_the_juice
		moveq	#1,d1		;.... I guess

delay_game	move.l	DOS_LIB_PTR,a6	;slow down game a bit... depending on CPU
		DOS	Delay

need_the_juice	rts
;---------------------------------------
keypress	move.b	imsg_code+1,keyval
		rts
;---------------------------------------
CELL_NUMS	dc.w	$8000+0	AIR	0	;CODES 00..1F
		dc.w	$8000+1	GRASS	1	;ARE RESERVED FOR
		dc.w	$8000+2	RWALL	2	;PERSPECTIVE CELLS
		dc.w	$8000+4	WALL 1	3	;ONLY !!!!!!!!!!!!

		dc.w	$8000+4	EWALL	4
		dc.w	$8000+5		5
		dc.w	$8000+6		6
		dc.w	$8000+7		7

		dc.w	$8000+4	GWALL	8
		dc.w	$8000+0		9
		dc.w	$8000+0		A
		dc.w	$8000+0		B

		dc.w	$8000+12 FWALL	C
		dc.w	$8000+13	D
		dc.w	$8000+14	E
		dc.w	$8000+15	F
;- - - - - - -
		dc.w	120	AMIBA	10
		dc.w	121		11
		dc.w	122		12
		dc.w	123		13
		dc.w	0		14
		dc.w	0		15
		dc.w	0		16
		dc.w	0		17
		dc.w	0		18
		dc.w	0		19
		dc.w	0		1A
		dc.w	0		1B
		dc.w	0		1C
		dc.w	0		1D
		dc.w	0		1E
		dc.w	0		1F

man_char	dc.w	2	MAN	20
		dc.w	0		21
		dc.w	0		22
		dc.w	0		23

wman_char	dc.w	8	WMAN	24
		dc.w	0		25
		dc.w	0		26
		dc.w	0		27

		dc.w	20	ROCK	28
		dc.w	0		29
		dc.w	0		2A
		dc.w	0		2B
		dc.w	20	FROCK	2C
		dc.w	21	FROCK	2D
		dc.w	22	FROCK	2E
		dc.w	23	FROCK	2F

		dc.w	24	BUTFLY_UP	30
		dc.w	26	BUTFLY_RIGHT	31
		dc.w	28	BUTFLY_DOWN	32
		dc.w	30	BUTFLY_LEFT	33

		dc.w	35	FLY_UP		34
		dc.w	34	FLY_RIGHT	35
		dc.w	33	FLY_DOWN	36
		dc.w	32	FLY_LEFT	37

		dc.w	36	FIRE_TAP 38
		dc.w	37		39
		dc.w	38		3A
		dc.w	39		3B

		dc.w	34	FLIES	3C
		dc.w	33		3D
		dc.w	32		3E
		dc.w	35		3F

		dc.w	136	BFLY_DIAM_EXPL	40
		dc.w	137	''	41
		dc.w	138	''	42
		dc.w	139	''	43

		dc.w	152	ROCK_FFLY_EXPL	44
		dc.w	153	''	45
		dc.w	154	''	46
		dc.w	155	''	47

		dc.w	132	FFLY_AIR_EXPL	48
		dc.w	133	''	49
		dc.w	134	''	4A
		dc.w	135	''	4B

		dc.w	134	EXPL_AIR	4C
		dc.w	135	''	4D
		dc.w	138	AMIB_DIAM	4E
		dc.w	139	''	4F

		dc.w	174	AMIB_ROCK	50
		dc.w	175	''	51
		dc.w	0		52
		dc.w	0		53
		
		dc.w	139	DIAM_BFLY	54
		dc.w	138	''	55
		dc.w	137	''	56
		dc.w	136	''	57

		dc.w	0,0,0,0		58
		dc.w	0,0,0,0		5C

		dc.w	80	FALLING_DROP 60
		dc.w	81	''
		dc.w	84	HR_DROP	62
		dc.w	85	''	63

		dc.w	86	HL_DROP 64
		dc.w	87	''	65
		dc.w	82	EXPL_DROP 66
		dc.w	83	''	67

		dc.w	88	FLAME	68
		dc.w	89	''	69
		dc.w	90	HR_FLAME 6A
		dc.w	91	''	6B

		dc.w	90	HL_FLAME 6C
		dc.w	91	''	6D
		dc.w	0		6E
		dc.w	0		6F

		dc.w	112	BEGG	70
		dc.w	113		71
		dc.w	114		72
		dc.w	115		73

		dc.w	92	EXIT	74
		dc.w	93		75
		dc.w	94		76
		dc.w	95		77

		dc.w	100	NUMBER	78
		dc.w	101		79
		dc.w	102		7A
		dc.w	103		7B

		dc.w	104	EXTRA_T	7C
		dc.w	105		7D
		dc.w	106		7E
		dc.w	107		7F

		dc.w	108	EXTRA_L	80
		dc.w	109		81
		dc.w	110		82
		dc.w	111		83

		dc.w	96	GEGG	84
		dc.w	97		85
		dc.w	98		86
		dc.w	99		87

		dc.w	116	DIAMOND	88
		dc.w	0		89
		dc.w	0		8A
		dc.w	0		8B
		dc.w	116	FDIAMOND 8C
		dc.w	0		8D
		dc.w	0		8E
		dc.w	0		8F

		dc.w	40	GS_HEAD	90	U
		dc.w	41		91	U
		dc.w	42		92	R
		dc.w	43		93	R

		dc.w	44		94	D
		dc.w	45		95	D
		dc.w	46		96	L
		dc.w	47		97	L

		dc.w	56	GS_SEGM	98
		dc.w	57		99
		dc.w	58		9A
		dc.w	59		9B

		dc.w	56		9C
		dc.w	57		9D
		dc.w	58		9E
		dc.w	59		9F

		dc.w	48 	GS_TAIL	A0
		dc.w	49 		A1
		dc.w	50 		A2
		dc.w	51 		A3

		dc.w	52		A4
		dc.w	53 		A5
		dc.w	54 		A6
		dc.w	55 		A7

		dc.w	0		A8
		dc.w	0		A9
		dc.w	0		AA
		dc.w	0		AB

		dc.w	0		AC
		dc.w	0		AD
		dc.w	0		AE
		dc.w	0		AF

		dc.w	25 BUTTERFLIES	B0	$30+$80
		dc.w	27		B1
		dc.w	29		B2
		dc.w	31		B3

		dc.w	33 FLIES	B4
		dc.w	32		B5
		dc.w	35		B6
		dc.w	34		B7

		dc.w	0		B8
		dc.w	0		B9
		dc.w	0		BA
		dc.w	0		BB

		dc.w	32 FLIES	BC
		dc.w	35		BD
		dc.w	34		BE
		dc.w	33		BF

		dc.w	0		C0
		dc.w	0		C1
		dc.w	0		C2
		dc.w	0		C3

		dc.w	176	WATER_TAP C4
		dc.w	177		C5
		dc.w	178		C6
		dc.w	179		C7

		dc.w	0		C8
		dc.w	0		C9
		dc.w	0		CA
		dc.w	0		CB

		dc.w	0		CC
		dc.w	0		CD
		dc.w	0		CE
		dc.w	0		CF

		dc.w	60 BS_HEAD	D0	U
		dc.w	61		D1	U
		dc.w	62		D2	R
		dc.w	63		D3	R

		dc.w	64		D4	D
		dc.w	65		D5	D
		dc.w	66		D6	L
		dc.w	67		D7	L

		dc.w	76 BS_SEGM	D8
		dc.w	77		D9
		dc.w	78		DA
		dc.w	79		DB

		dc.w	76		DC
		dc.w	77		DD
		dc.w	78		DE
		dc.w	79		DF

		dc.w	68 BS_TAIL	E0
		dc.w	69		E1
		dc.w	70		E2
		dc.w	71		E3

		dc.w	72		E4
		dc.w	73		E5
		dc.w	74		E6
		dc.w	75		E7

		dc.w	0,0,0,0,0,0,0,0 E8
		dc.w	0,0,0,0,0,0,0,0 F0
		dc.w	0,0,0,0,0,0,0,0 F8
;---------------------------------------
animate_things	addq.w	#1,anim_clock	;tick animation phases clock

		tst.b	found_exit
		bne	arrived
		moveq	#4,d1
		bsr	rnd
		add.w	#12,d0
		move.w	d0,wman_char
		bra	done_waiting

arrived		moveq	#3,d0
		and.w	anim_clock,d0
		add.w	#16,d0
		move.w	d0,man_char
done_waiting	rts
;---------------------------------------
new_game	bsr	copy_map
		bsr	init_game_vars
		bsr	init_panel
		rts
;---------------------------------------
init_game_vars	bsr	find_rf		;set rf_x,rf_y
		bsr	init_snakes
		bsr	count_amibas

		move.b	#PUSH,energy	;for pushing
		move.b	#AFTER_LIFE,death_count	;for life without rf

		sf	found_exit
		sf	out_of_time
		sf	enough_diamonds
		sf	magic_walls
		sf	water_taps_on
		sf	fire_taps_on
		sf	disable_rockf

		move.w	level,d0
		lsr.w	#2,d0
		move.w	d0,world		;4 levels per world

		mulu	#WORLD_sizeof,d0
		lea	world_descriptors,a0
		add.l	d0,a0
		move.l	a0,world_ptr
		moveq	#3,d1
		and.w	level,d1
		add.w	d1,d1
		move.w	to_collect(a0,d1),diamonds
		move.w	time_lefts(a0,d1),time_left
		addq.w	#1,time_left
		add.w	d1,d1				;D1 into LONGs
		move.l	jewel_value(a0,d1),price

		lea	score_field,a0
		moveq	#6-1,d0
reset_score	move.b	#'0',(a0)+
		dbra	d0,reset_score
		rts
;---------------------------------------
init_panel	lea	jewel_name,a0
		moveq	#0,d0		;char column
		moveq	#10,d1		;scan line
		moveq	#4,d3		;string len
		bsr	print_string

		moveq	#0,d0		;fill in level # field
		move.w	level,d0
		addq.w	#1,d0
		moveq	#2,d1		;01..40
		lea	level_num,a0
		bsr	bin_to_dec

		lea	level_string,a0
		moveq	#30,d0		;char column
		moveq	#10,d1		;scan line
		moveq	#8,d3		;string len
		bsr	print_string

		bsr	update_time

;- - - - - - - -------------------------
update_panel	move.w	diamonds,d0	;get # of diamonds
		ext.l	d0
		bpl.s	positive_ok
		moveq	#0,d0		;if neg, clip to zero
positive_ok	moveq	#3,d1		;need 3 chars
		lea	diam_string,a0
		bsr	bin_to_dec	;convert to string
		
		lea	diam_string,a0
		moveq	#5,d0		;column
		moveq	#10,d1		;line
		moveq	#3,d3		;string len
		bsr	print_string	;print on status strip

update_score	move.l	score,d0	;convert score to string
		moveq	#6,d1		;6 chars
		lea	score_field,a0
		bsr	bin_to_dec
		
		lea	score_string,a0	;print score string
		moveq	#10,d0		;column xco
		moveq	#10,d1		;pix yco 
		moveq	#13,d3		;string length
		bsr	print_string
		rts
;---------------------------------------
update_time	tst.w	time_left
		beq	time_out
		subq.w	#1,time_left
		seq	out_of_time

		moveq	#0,d0
		move.w	time_left,d0
		moveq	#3,d1
		lea	time_string,a0
		bsr	bin_to_dec

		lea	time_string,a0
		moveq	#25,d0
		moveq	#10,d1
		moveq	#3,d3
		bsr	print_string

time_out	rts
;---------------------------------------
copy_map	move.l	maps,a0
		lea	cell_map,a1
		move.w	#(MAP_SIZE/4)-1,d0
copy_map_l	move.l	(a0)+,(a1)+
		dbra	d0,copy_map_l
		rts
;---------------------------------------
get_key		moveq	#0,d0
		move.b	keyval,d0
		clr.b	keyval
		rts
;---------------------------------------
track_time	tst.b	pauze
		bne	game_irqs_done
		move.l	INTUI_LIB_PTR,a0	;see if a second expired
		move.l	ib_Seconds(a0),d0
		cmp.l	time,d0
		beq	enough_time

		move.l	d0,time			;if so,
		bsr	update_time		;show on panel

		move.w	time_left,d1
		beq	enough_time
		moveq	#10,d0
		sub.w	d1,d0
		bmi.s	enough_time
		tst.b	found_exit
		bne	enough_time
		NOP				;time running out sound!

enough_time	
game_irqs_done	rts
;---------------------------------------
redraw_screen	lea	cell_map+MAP_SIZE,a6	;new cell #
		lea	CELL_NUMS,a5
		move.l	divu_table,a4
		move.w	#21*8*SCREEN_WIDTH+39,d5 ;screen offset
		moveq	#ROWS-1,d7		;line 21..0
next_line0	moveq	#COLUMNS-1,d6		;column 39..0
next_column0	BSR	draw_cell
		subq.w	#1,d5			;move left->right
		dbra	d6,next_column0
		sub.w	#7*SCREEN_WIDTH,d5	;move down->up
		dbra	d7,next_line0
		rts
;---------------------------------------
CP_CHAR		MACRO
		move.b	(a0),(a1)
		move.b	1*SCREEN_WIDTH(a0),1*SCREEN_WIDTH(a1)
		move.b	2*SCREEN_WIDTH(a0),2*SCREEN_WIDTH(a1)
		move.b	3*SCREEN_WIDTH(a0),3*SCREEN_WIDTH(a1)
		move.b	4*SCREEN_WIDTH(a0),4*SCREEN_WIDTH(a1)
		move.b	5*SCREEN_WIDTH(a0),5*SCREEN_WIDTH(a1)
		move.b	6*SCREEN_WIDTH(a0),6*SCREEN_WIDTH(a1)
		move.b	7*SCREEN_WIDTH(a0),7*SCREEN_WIDTH(a1)
		ENDM

; A6 -> new CELL in map

draw_cell	moveq	#0,d0
		move.b	-(a6),d0		;get cell
		add.w	d0,d0
		move.w	0(a5,d0),d0		;cell # >> char #
		bmi.s	perspective_cell
		add.w	#20,d0		;if normal cell: offset to next line
perspective_cell
		and.w	#255,d0		;mask of cell #
		add.w	d0,d0
		add.w	d0,d0
		move.l	0(a4,d0.w),d0	;get char position in src screen
		move.l	d0,d1
		mulu	#8*SCREEN_WIDTH,d0
		swap	d1
		add.w	d1,d0
		move.l	char_graphics,a0
		add.w	d0,a0

		move.l	screen_base,a1
		add.w	d5,a1
		CP_CHAR

		add.w	#8000,a0
		move.l	screen_base+4,a1
		add.w	d5,a1
		CP_CHAR

		add.w	#8000,a0
		move.l	screen_base+8,a1
		add.w	d5,a1
		CP_CHAR
		rts
;---------------------------------------
; D1 = X  // D2 = Y		;USES D0,D1,D2  A0,A1,A6
; D3 = string length
; A0-> 'C'-type string

print_string	move.l	a0,-(SP)		;save string ptr
		move.l	GFX_LIB_PTR,a6
		asl.w	#3,d0			;char column -> pix x
		addq.w	#7,d1			;cvt to baseline Y
		move.l	myrastport,a1
		GFX	Move

		moveq	#1,d0			;use color N
		move.l	myrastport,a1
		GFX	SetAPen

		move.l	(SP)+,a0		;retrieve string ptr
		move.w	d3,d0			;set string len
		move.l	myrastport,a1
		GFX	Text
		rts
;---------------------------------------
; D0=# of stick		;delivers C64 values

read_stick	movem.l	d7/a0,-(SP)
		lea	CUSTOM_BASE,a0
		and.w	#1,d0		;stick #1 or #2 ,nothing else
		move.w	d0,d7		;save which joystick
		add.w	d0,d0
		move.w	joy0dat(A0,d0.w),d1	;get status
		moveq	#0,d0		;clear C64 joyval

always_stick	btst	#1,d1		;decode bits
		beq	_not_right
		bset	#RIGHT,d0   ;set RIGHT bit in D0 (like in the C64 !)
		bchg	#0,d1
_not_right	btst	#9,d1
		beq	_not_left
		bset	#LEFT,d0
		bchg	#8,d1
_not_left	btst	#8,d1
		beq	_not_forw
		bset	#UP,d0
_not_forw	btst	#0,d1
		beq	_not_back
		bset	#DOWN,d0

_not_back	addq.w	#6,d7
		btst	d7,FIRE_BUTTONS	;test this joystick's fire button
		bne	_not_down
		bset	#FIRE,d0
_not_down	movem.l	(SP)+,d7/a0
		rts
;---------------------------------------
; D1 is WORD range ; returns in D0

rnd		move.l	a0,-(SP)
		tst.w	d1		;If param <> 0
		beq	_zero_range
		lea	_rndseed,a0	;Get address of seed
		move.l	(a0),d0		;Get seed
		rol.l	d0,d0		;mix bits
		swap	d0	
		add.l	CUSTOM_BASE+vposr,d0
		eori.l	#$1DA72BD5,D0
		move.l	d0,(a0)		;Save new seed
		clrh	d0		;make sure no Overflow occurs
		divu	d1,d0		;Divide by range
		swap	d0		;and get remainder (modulus)
quit_rnd	move.l	(SP)+,a0
		rts
_zero_range	moveq	#0,d0		;if range is 0 avoid division by 0
		bra	quit_rnd

_rndseed	dc.l	$1A39F5D6

;---------------------------------------
; A0 -> string dest
; D0 = # to be cvtd (LONG)
; D1 = # of chars wanted

bin_to_dec	subq.w	#8,d1
		neg.w	d1
		add.w	d1,d1
		add.w	d1,d1
		lea	powers(PC,d1),a1
next_pow	move.l	(a1)+,d1
		moveq	#0,d2
weigh		sub.l	d1,d0
		bcs.s	gotya
		addq.w	#1,d2
		bra	weigh
gotya		add.l	d1,d0
		add.b	#'0',d2
		move.b	d2,(a0)+
		subq.l	#1,d1
		bne	next_pow
		rts

powers		dc.l	10000000	7
		dc.l	1000000		6
		dc.l	100000		5
		dc.l	10000		4
		dc.l	1000		3
		dc.l	100		2
		dc.l	10		1
		dc.l	1		0
;---------------------------------------
delay		subq.l	#1,d0
		bne	delay
dummy		rts
;---------------------------------------
HANG		move.w	#YELLOW,COLOR_BASE
		move.w	#GREY,COLOR_BASE
		bra	HANG
;---------------------------------------
source_maps:	INCBIN	"maps"

;			*********
;			CONSTANTS 
;			*********

rocky_screendef	dc.w	0,0
		dc.w	320
		dc.w	200
		dc.w	PLANES
		dc.b	2,1
		dc.w	0			;screen modes
		dc.w	CUSTOMSCREEN
		dc.l	0
		dc.l	screen_name
		dc.l	0
		dc.l	0

windowdef	dc.w	0,20
		dc.w	320,160
		dc.b	2,1
		dc.l	WINDOW_IDCMP
		dc.l	WINDOW_FLAGS
		dc.l	0		;gadget list
		dc.l	0		;std checkmark
		dc.l	0		;no name !!
window_screen	dc.l	0
		dc.l	0		;no custom BitMap
		dc.w	50,50,320,200	;mins & maxs
		dc.w	CUSTOMSCREEN

screen_name	dc.b	'Rocky Clone V1.0',0
		dc.b	'© written by Laurence Vanhelsuwé.'

;-----------------------STRINGS
dos_name	DOSNAME
gfx_name	GRAFNAME
intui_name	INTNAME

score_string	dc.b	'POINTS '
score_field	dc.b	'000000',0

level_string	dc.b	'LEVEL '
level_num	dc.b	'XX'

time_string
diam_string	dc.b	'XXX',0

;-----------------------FILE NAMES
fname0		dc.b	'chars',0

jewel_name	dc.b	'GEMS'
;-----------------------
bonus_scores	dc.l	20000,60000,120000,240000,950000

screen_colors	dc.w	$000,$fdb,$b00,$080,$24c,$eb0,$b52,$f0f

world_descriptors
	dc.l	80,70,90,30			;normal points
	dc.l	100,90,35,35			;greedy points
	dc.w	40,40,80,100			;to collect
	dc.w	110,110,130,110			;time left

	dc.l	110,25,20,55,140,40,30,75
	dc.w	20,65,130,55
	dc.w	80,140,100,110

	dc.l	60,95,45,45,80,50,50,50
	dc.w	50,35,25,45
	dc.w	110,110,90,130

	dc.l	120,70,80,45,150,90,50,50
	dc.w	16,35,30,30
	dc.w	90,100,110,140

	dc.l	45,45,45,45,50,50,50,50
	dc.w	30,125,22,35
	dc.w	110,145,120,140

	dc.l	40,45,45,45,55,100,50,50
	dc.w	50,30,30,30
	dc.w	130,90,110,140

	dc.l	45,45,45,45,50,50,50,50
	dc.w	26,55,60,60
	dc.w	110,110,140,110

	dc.l	45,45,45,45,50,50,50,50
	dc.w	20,8,40,20
	dc.w	140,140,140,160

	dc.l	45,45,45,45,50,50,50,50
	dc.w	12,70,75,18
	dc.w	130,180,65,140

	dc.l	45,45,45,45,50,50,50,50
	dc.w	18,20,60,30
	dc.w	140,140,140,140

;-----------------------The Maps
no_mans_land	ds.b	COLUMNS+1
		EVEN
cell_map	ds.b	MAP_SIZE
flag_map	ds.b	MAP_SIZE	;used to hold TO DO/DONE flag
;---------------------------------------------------------------------
;		****************
;		VARIABLES & PTRS
;		****************

DOS_LIB_PTR	ds.l	1
GFX_LIB_PTR	ds.l	1
INTUI_LIB_PTR	ds.l	1

stack_level	ds.l	1

mymsgport	ds.l	1
waitmask	ds.l	1
imsg_class	ds.l	1
imsg_code	ds.w	1
imsg_addr	ds.l	1
imsg_ratcords	ds.l	1

myscreen	ds.l	1
mywindow	ds.l	1
myviewport	ds.l	1
myrastport	ds.l	1
mybitmap	ds.l	1

;-----------------------
;---------STRUCTURES
		EVEN
gsnake_struct	ds.b	SNAKE_sizeof
bsnake_struct	ds.b	SNAKE_sizeof

;-----------------------
;---------LONGS
maps		ds.l	1	;points to 1 map
plane_ptrs	ds.l	1
screen_base	ds.l	3
char_graphics	ds.l	1
divu_table	ds.l	1

;-- 'current level' vars
world_ptr	ds.l	1
price		ds.l	1
score		ds.l	1
time		ds.l	1	;intuition seconds counter
;---------WORDS
anim_clock	ds.w	1
time_left	ds.w	1
magic_timer	ds.w	1
gegg_timer	ds.w	1
begg_timer	ds.w	1

rf_x		ds.w	1
rf_y		ds.w	1
joystick	ds.w	1

world		ds.w	1
level		ds.w	1

amiba_count	ds.w	1
diamonds	ds.w	1
scan_count	ds.w	1
target		ds.w	1
lives		ds.w	1
next_bonus	ds.w	1

;---------BYTES
keyval		ds.b	1	;-1 for no key
energy		ds.b	1
flash		ds.b	1
death_count	ds.b	1
neighbours	ds.b	1

; FLAGS		$FF = TRUE // $00 = FALSE
;------
rockf_died	ds.b	1
die_anyway	ds.b	1
out_of_time	ds.b	1	;the three EXIT conditions
found_exit	ds.b	1

added_amiba	ds.b	1
magic_walls	ds.b	1
enough_diamonds	ds.b	1
fire_taps_on	ds.b	1
water_taps_on	ds.b	1
disable_rockf	ds.b	1
cleared		ds.b	1	;cell_buffer cleared
first_time	ds.b	1
one_two		ds.b	1

good_snake	ds.b	1
bad_snake	ds.b	1

pauze		ds.b	1
debounce	ds.b	1
key_move	ds.b	1	;keyboard generated simulated joystick move
bonk		ds.b	1	;rock fell
ping		ds.b	1
freeze_rf	ds.b	1

		END
