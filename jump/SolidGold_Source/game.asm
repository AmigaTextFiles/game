*
* Game engine and level loop
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* initgame(d0.w=level)
* d0=flag = exitgame()
* $game()
* addScore(d0.w=bcdScore)
* addLives(d0.b=bcdLives)
* addGems(d0.b=bcdGems)
*
* SolidBlocks
* BackgdBlocks
* FgBlockTypes
* FrameRand
* StartLevel
* Level
* Score
* Lives
* Status
*

	include	"display.i"
	include	"view.i"
	include	"game.i"
	include	"world.i"
	include	"hero.i"
	include	"sound.i"
	include	"files.i"


; from memory.asm
	xref	save_chipmem
	xref	restore_chipmem

; from trackdisk.asm
	xref	td_loadcr
	xref	td_motoroff

; from init.asm
	xref	stackcheck

; from input.asm
	xref	readController
	xref	getkey

; from main.asm
	xref	set_vertb_irq
	xref	clr_vertb_irq
	xref	rand
	xref	ovflowerr
	xref	loaderr
	xref	color_intensity
	xref	Button
	xref	UpDown
	xref	LeftRight
	xref	LastKey

; from display.asm
	xref	display_off
	xref	make_scrollviews
	xref	startdisplay
	xref	switchView
	xref	View

; from newworld.asm
	xref	newworld_screen

; from newlevel.asm
	xref	newlevel_scr_open
	xref	newlevel_scr_close

; from levelstats.asm
	xref	init_stats
	xref	level_stats
	xref	LevelTime
	xref	LivesLost

; from hero.asm
	xref	loadHero
	xref	initHero
	xref	updateHero
	xref	updateLevDone
	xref	getHeroPos
	xref	lookupStartPos
	xref	getStart
	xref	killHero
	xref	Hero_alive

; from monster.asm
	xref	load_monster16
	xref	load_monster20
	xref	load_monsterchar
	xref	add_monster_bobs
	xref	update_monsters

; from bob.asm
	xref	initBOBs
	xref	updateBOBs
	xref	drawBOBs
	xref	undrawBOBs

; from map.asm
	xref	load_map
	xref	ScrWidth
	xref	ScrHeight

; from illuminate.asm
	xref	reset_illumination
	xref	illuminate

; from scroll.asm
	xref	set_scroll_pos
	xref	scroll
	xref	copper_scroll
	xref	load_copperback

; from tiles.asm
	xref	init_tiles
	xref	makeSwitchTileTab
	xref	load_tiles
	xref	draw_tiles
	xref	drawlist_backgd
	xref	initTileAnims
	xref	updateTileAnims

; from fgblocks.asm
	xref	init_fgblocks
	xref	load_fgblocks
	xref	animate_fgblocks
	xref	drawlist_foregd

; from sprite.asm
	xref	init_gamesprites
	xref	load_gamesprites
	xref	activate_gamesprites
	xref	update_gamesprites
	xref	move_infosprite_right
	xref	move_infosprite_left
	xref	draw_infosprite_text

; from font.asm
	xref	load_gamefont

; from sound.asm
	xref	loadSFX
	xref	playSFX

; from music.asm
	xref	loadMusic
	xref	startMusic
	xref	stopMusic



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	initgame
initgame:
; Initializations when starting a new game.
; d0 = start level of the game

	ifd	DEBUG
	move.l	View(a4),$7ff00		; first View pointer
	move.l	View+4(a4),$7ff04	; second View pointer
	endif

	move.w	d0,StartLevel(a4)
	move.w	d0,Level(a4)
	clr.w	World(a4)
	clr.b	LevelDone(a4)
	clr.b	GameFinished(a4)

	; Reset score and gems, set initial number of lives (all in BCD)
	moveq	#$00,d0
	move.b	d0,Score(a4)
	move.b	d0,Score+1(a4)
	move.b	d0,Score+2(a4)
	move.b	#NUMLIVES,Lives(a4)
	move.b	d0,Gems(a4)

	bsr	save_chipmem
	move.l	d0,GameChipPtr(a4)
	clr.l	WorldChipPtr(a4)

	bsr	init_tiles
	bsr	init_fgblocks

	bsr	init_gamesprites
	bsr	load_gamesprites

	bsr	load_gamefont

	bra	loadHero


;---------------------------------------------------------------------------
	xdef	exitgame
exitgame:
; Turn the display off and free all Chip RAM which we used during the game.
; d0.b = game finished flag

	bsr	display_off

	move.l	GameChipPtr(a4),a0
	bsr	restore_chipmem

	move.b	GameFinished(a4),d0
	rts


;---------------------------------------------------------------------------
	xdef	game
game:
; Play the game. Initialize current level. Reset display to start position.
; Run the game engine in VERTB interrupt.

	bsr	display_off

	;-----------------------
	; Load next level/world.
	;-----------------------

	move.w	Level(a4),d1		; current level (starts with 1)
	lea	LevelWorlds(a4),a0
	moveq	#0,d0
	move.b	-1(a0,d1.w),d0		; current world
	cmp.w	World(a4),d0
	beq	game_newmap

	; New world. Deallocate old world's data, when needed
	move.w	d0,World(a4)
	move.l	WorldChipPtr(a4),d0
	beq	game_newworld
	move.l	d0,a0
	bsr	restore_chipmem

game_newworld:
	bsr	save_chipmem
	move.l	d0,WorldChipPtr(a4)
	clr.l	ViewChipPtr(a4)

	; Load all the needed files for the current world.
	bsr	loadworld
	moveq	#0,d0			; do not load the font in loadlevel

game_newmap:
	; Load map and monster locations. Turn off disk motor after that.
	bsr	loadlevel

	; Find starting point in map.
	bsr	lookupStartPos

	; Init display hardware and create copper lists for scrolling.
	bsr	make_scrollviews

	; Setup continuous background tile animations.
	move.l	AnimBlocks(a4),a1
	lea	256(a1),a0		; animation parameter table
	bsr	initTileAnims

	; Reset flags for each new level.
	moveq	#0,d0
	move.b	d0,JinglePlayed(a4)
	move.b	d0,LevelDone(a4)

	move.b	d0,LastKey(a4)
	move.w	d0,InputBufIndex(a4)
	st	ShowPosX(a4)		; disable ShowPosX/Y display

	; Play jingle, when starting a new level.
	move.b	GetRdySongPos(a4),d0
	moveq	#JINGLE_VOLUME,d1
	bsr	startMusic

	;-----------------------------------------------
	; Restart at last checkpoint. Redraw everything!
	;-----------------------------------------------

game_restart:
	; Deallocate each View's BOB backup buffers. They will always be
	; reallocated when resetting the Views during redraw_start().
	move.l	ViewChipPtr(a4),d0
	beq	.1
	move.l	d0,a0
	bsr	restore_chipmem
.1:	bsr	save_chipmem
	move.l	d0,ViewChipPtr(a4)

	; Center the display on the start position and redraw both Views.
	bsr	display_off
	bsr	redraw_start

	; Draw "get ready" into the info sprites.
	lea	TxtGetReady(pc),a0
	bsr	draw_infosprite_text

	; Load our Colortable and start the display DMA.
	move.l	Colortable(a4),a0
	bsr	startdisplay

	;----------------------------
	; Get ready and run the game.
	;----------------------------

game_run:
	; Run the game. Move in the info sprites with the message.
	move.b	#GAME_MESSAGE,Status(a4)

game_cont:
	; Render each frame during VERTB interrupt.
	lea	do_frame(pc),a0
	bsr	set_vertb_irq

	;--------------------------------
	; Game running in vertical blank.
	;--------------------------------

game_loop:
	ifd	KILLOS
	ifd	DEBUG
	bsr	stackcheck		; check for stack overflow
	endif
	endif

	; pressing the ESC key kills the hero, when status is GAME_RUNNING
	cmp.b	#27,LastKey(a4)
	bne	.2
	tst.b	Status(a4)
	bpl	.3

	; ESC quits the game, when in unlimited lives mode
	cmp.b	#$99,Lives(a4)
	bne	.1
	st	LevelDone(a4)
	bra	game_stop

.1:	bsr	killHero

.2:	tst.b	Status(a4)		; loop as long as not GAME_STOPPED
.3:	bne	game_loop


	;--------------------------------------
	; Stop the game. Handle special events.
	;--------------------------------------

game_stop:
	bsr	clr_vertb_irq

	move.w	ShowPosX(a4),d0
	bpl	game_showpos		; show current hero pos as message

	tst.b	LevelDone(a4)
	bmi	stopMusic		; game over: stop music and quit
	bne	game_nextlevel		; proceed to next level

	tst.b	JinglePlayed(a4)
	beq	game_mainsong		; jingle played, start main song

	tst.b	Hero_alive(a4)
	bne	game_leveldone		; game stopped with hero still alive

	; Hero died. Decrement lives.
	addq.w	#1,LivesLost(a4)
	moveq	#1,d0
	bsr	subLives
	bne	game_restart		; continue at last checkpoint

	; No lives left. Draw "game over" into the info sprites
	; and continue the game, until the player pressed the button.
	bsr	stopMusic
	st	LevelDone(a4)		; set Game Over status
	lea	TxtGameOver(pc),a0
	bsr	draw_infosprite_text	; draw "Game Over"
	moveq	#0,d0
	move.b	GamOvrSongPos(a4),d0
	moveq	#JINGLE_VOLUME,d1
	bsr	startMusic		; play game-over jingle
	bra	game_run

game_showpos:
	clr.b	Hero_alive(a4)
	st	ShowPosX(a4)		; disable ShowPosX/Y again
	move.w	ShowPosY(a4),d1
	bsr	show_pos
	bra	game_run		; show position as message

game_mainsong:
	; Stop the level's initial jingle and start the main song.
	bsr	stopMusic
	st	JinglePlayed(a4)
	moveq	#0,d0
	move.b	LevelSongPos(a4),d0
	moveq	#SONG_VOLUME,d1
	bsr	startMusic
	move.b	#GAME_READY,Status(a4)
	bra	game_cont

game_leveldone:
	; Draw the "well done" into the info sprites and continue the game
	; while showing the level-done animation and playing a jingle.
	bsr	stopMusic
	addq.b	#1,LevelDone(a4)	; set level-done flag
	lea	TxtWellDone(pc),a0
	bsr	draw_infosprite_text	; draw "Well Done"
	moveq	#0,d0
	move.b	d0,Hero_alive(a4)	; make hero invulnerable
	move.b	LvDoneSongPos(a4),d0
	moveq	#JINGLE_VOLUME,d1
	bsr	startMusic		; play level-done jingle
	bra	game_run

game_nextlevel:
	bsr	stopMusic

	; free BOB backup buffers
	move.l	ViewChipPtr(a4),a0
	bsr	restore_chipmem
	clr.l	ViewChipPtr(a4)

	; show statistics from last level
	move.b	StatsSongPos(a4),d0
	move.l	Colortable(a4),a0
	bsr	level_stats

	; Proceed to next level.
	addq.w	#1,Level(a4)
	cmp.w	#MAXLEVEL,Level(a4)
	bls	game

	; Finished the last level! Show end-sequence.
	st	GameFinished(a4)
	rts


TxtGetReady:
	dc.b	" GET  "
	dc.b	"READY!"
TxtGameOver:
	dc.b	" GAME "
	dc.b	" OVER "
TxtWellDone:
	dc.b	" WELL "
	dc.b	" DONE!"


;---------------------------------------------------------------------------
do_frame:
; This is the core of the game. All game mechanics and rendering
; takes place here.
; Running in VERTB interrupt.
; a4 = SmallData base
; a6 = CUSTOM

	ifd	DEBUG
	move.w	#$555,$180(a6)
	endif

	;-----------------------------
	; redraw changed score digits
	;-----------------------------
	move.l	Score(a4),d0
	move.b	Gems(a4),d1
	bsr	update_gamesprites

	;-----------------------------------------------------------
	; switch Views, so we can render to the new background View
	;-----------------------------------------------------------
	bsr	switchView
	move.l	a0,a5			; a5 rendering View

	;-----------------------
	; first remove all BOBs
	;-----------------------
	bsr	undrawBOBs

	;--------------------------------------------------------
	; illuminate some colors as long as the timer is running
	;--------------------------------------------------------
	bsr	illuminate

	;--------------------------------------------------
	; scroll the display to show the current Xpos/Ypos
	;--------------------------------------------------
.1:	bsr	scroll

	;-----------------------------------
	; each frame has a new random value
	;-----------------------------------
	bsr	rand
	move.w	d0,FrameRand(a4)

	;------------------------------------------
	; draw everything from back- to foreground
	;------------------------------------------
	bsr	drawlist_backgd		; animated background tiles
	bsr	updateBOBs
	bsr	drawBOBs		; BOBs
	bsr	drawlist_foregd		; foreground tiles

	;------------------------------------------
	; read and remember joystick port 2 status
	;------------------------------------------
	moveq	#1,d0
	bsr	readController
	move.l	d0,Button(a4)		; set Button, UpDown, LeftRight

	;--------------------
	; update game status
	;--------------------
	move.b	Status(a4),d0
	bmi	.updhero		; GAME_RUNNING: updateHero
	subq.b	#1,d0
	bne	.3

	; GAME_MESSAGE - move info sprites with message to the center
	bsr	move_infosprite_right
	add.b	d0,Status(a4)		; set GAME_WAITBTN, when centered
.2:	move.b	LevelDone(a4),d0
	subq.b	#1,d0
	blt	.updmonst
	bsr	updateLevDone		; show hero's level-done animation
	bra	.updmonst

.3:	subq.b	#1,d0
	bne	.6

	; GAME_WAITBTN - wait until player presses the button
	tst.b	Button(a4)
	beq	.2
	tst.b	LevelDone(a4)
	beq	.5
.4:	clr.b	Status(a4)		; Quit the game loop again.
	bra	.updmonst
.5:	st	Hero_alive(a4)		; hero is alive and vulnerable now!
	tst.b	JinglePlayed(a4)
	beq	.4			; stop jingle, start main song
	addq.b	#1,Status(a4)		; set GAME_READY, when button pressed

.6:	; GAME_READY - make the "get ready" text disappear
	bsr	move_infosprite_left
	tst.b	d0
	beq	.updhero
	move.b	#GAME_RUNNING,Status(a4)

	;--------------------------------------
	; update hero, monsters and animations
	;--------------------------------------
.updhero:
	addq.l	#1,LevelTime(a4)
	bsr	updateHero
.updmonst:
	bsr	update_monsters
	bsr	updateTileAnims
	bsr	animate_fgblocks

	;-----------------------------
	; get next key from the queue
	;-----------------------------
	bsr	getkey
	move.b	d0,LastKey(a4)
	beq	.done

	lea	InputBuf(a4),a0
	moveq	#7,d1
	and.w	InputBufIndex(a4),d1
	move.b	d0,(a0,d1.w)

	addq.w	#1,d1
	cmp.b	#10,d0			; Return key enters the buffer
	bne	.updinpidx

	; handle entered string
	bsr	handle_input
	moveq	#0,d1			; reset index

.updinpidx:
	move.w	d1,InputBufIndex(a4)

.done:
	ifd	DEBUG
	move.w	#$000,$180(a6)
	endif
	rts


;---------------------------------------------------------------------------
redraw_start:
; Center the display around the hero's start position and redraw everything
; in both views.
; Initializes Xpos, Ypos and Ymod.

	movem.l	d2/a5,-(sp)

	; Take the start position from the map (StartX/StartY) and
	; transform it into screen coordinates, which point to the
	; hero's center.
	bsr	getStart
	lsl.w	#4,d0
	addq.w	#8,d0			; + hero width / 2
	lsl.w	#4,d1
	add.w	#HEROH/2-(HEROH-16),d1

	; Then calculate the top/left display position to show the
	; hero as centered as possible.
	sub.w	#DISPW/2,d0
	bmi	.1
	move.w	#DISPW,d2
	add.w	d0,d2
	cmp.w	ScrWidth(a4),d2
	blo	.2
	move.w	ScrWidth(a4),d0
	sub.w	#DISPW,d0
	bra	.2
.1:	moveq	#0,d0

.2:	sub.w	#DISPH/2,d1
	bmi	.3
	move.w	#DISPH,d2
	add.w	d1,d2
	cmp.w	ScrHeight(a4),d2
	blo	.4
	move.w	ScrHeight(a4),d1
	sub.w	#DISPH,d1
	bra	.4
.3:	moveq	#0,d1

.4:	bsr	set_scroll_pos

	; init BOB system
	move.l	View(a4),a5
	bsr	initBOBs
	move.l	View+4(a4),a5
	bsr	initBOBs

	; initialize the hero on the start position and add monsters
	bsr	initHero
	bsr	add_monster_bobs

	; Reset both views to Xpos,Ypos and redraw everything
	move.l	View(a4),a5
	bsr	reset_view
	move.l	View+4(a4),a5
	bsr	reset_view

	; make our sprites visible and redraw the score
	bsr	activate_gamesprites
	move.l	Score(a4),d0
	bsr	update_gamesprites

	movem.l	(sp)+,d2/a5
	rts


;---------------------------------------------------------------------------
reset_view:
; View the map at Xpos,Ypos and redraw everything in it.
; a5 = View

	movem.l	d2-d7/a2-a3,-(sp)

	; change copperlist to view the right portion of our bitmap
	bsr	copper_scroll
	movem.w	d2-d3,Vxpos(a5)

	; draw all visible background tiles from the map, setup DrawList
	bsr	draw_tiles

	; prepare visible BOBs for drawing
	bsr	updateBOBs

	; save background and draw masked BOB images
	bsr	drawBOBs

	; finally draw the foreground blocks on top of everything
	bsr	drawlist_foregd

	; reset illumination colors
	move.l	Colortable(a4),a0
	move.w	World(a4),d0
	bsr	reset_illumination

	movem.l	(sp)+,d2-d7/a2-a3
	rts


;---------------------------------------------------------------------------
loadworld:
; Load all files, which are defined in WorldRsrc, for the current world.

	movem.l	a2-a3,-(sp)

	move.w	World(a4),d0
	mulu	#sizeof_WF,d0
	lea	WorldRsrc(a4),a0
	lea	-sizeof_WF(a0,d0.l),a2

	; start the loading animation
	bsr	newworld_screen

	; load the world's types file (colormap, block types, animations)
	lea	TypesBuffer,a3
	moveq	#0,d0
	move.b	WFtypes(a2),d0
	move.l	a3,a0
	bsr	td_loadcr
	beq	loaderr
	cmp.l	#sizeof_Types,d0
	bhi	ovflowerr

	; multiply all block types by two for using them as jump table offsets
	move.l	SolidBlocks(a4),a0
	bsr	blktab_mult2
	move.l	BackgdBlocks(a4),a0
	bsr	blktab_mult2
	move.l	FgBlockTypes(a4),a0
	bsr	blktab_mult2
	move.l	AnimBlocks(a4),a0
	bsr	blktab_mult2

	; load background tiles
	moveq	#0,d0
	move.b	WFtiles(a2),d0
	lea	TTtilestypes(a3),a0
	bsr	load_tiles

	; load foreground blocks
	moveq	#0,d0
	move.b	WFfg(a2),d0
	lea	TTfgtypes(a3),a0
	lea	TTfganimphases(a3),a1
	bsr	load_fgblocks

	; load background copper colors
	moveq	#0,d0
	move.b	WFcopper(a2),d0
	bsr	load_copperback

	; load monster type characteristics
	moveq	#0,d0
	move.b	WFmonstchar(a2),d0
	bsr	load_monsterchar

	; load small monster images
	moveq	#0,d0
	move.b	WFmonst16(a2),d0
	lea	TTmonst16types(a3),a0
	bsr	load_monster16

	; load big monster images
	moveq	#0,d0
	move.b	WFmonst20(a2),d0
	lea	TTmonst20types(a3),a0
	bsr	load_monster20

	; finally load the world's music
	moveq	#0,d0
	move.b	WFmod(a2),d0
	bsr	loadMusic

	; remember song positions for the world's jingles
	move.b	WFgetready(a2),GetRdySongPos(a4)
	move.b	WFgameover(a2),GamOvrSongPos(a4)
	move.b	WFleveldone(a2),LvDoneSongPos(a4)

	move.b	WFlevelstats(a2),StatsSongPos(a4)

	; load sound effects
	moveq	#0,d0
	move.b	WFsfxset(a2),d0
	bsr	loadSFX

	; stop the loading animation and music
	bsr	clr_vertb_irq
	bsr	display_off
	bsr	stopMusic

	movem.l	(sp)+,a2-a3
	rts


;---------------------------------------------------------------------------
blktab_mult2:
; Multiply all entries in a block types table (256 bytes) by two.
; It would have been better to enter the doubled values directly in
; the tables, but this requires two digits in some places, which makes
; them unreadable. ;)
; a0 = table pointer

	moveq	#127,d1
.1:	move.b	(a0),d0
	add.b	d0,(a0)+
	move.b	(a0),d0
	add.b	d0,(a0)+
	dbf	d1,.1
	rts


;---------------------------------------------------------------------------
loadlevel:
; Load the level map, then turn off the disk motor.
; d0 = font-flag (false means that the font8 is already loaded)

	move.l	a2,-(sp)
	move.l	World(a4),d1		; d1 = World.w | Level.w
	bsr	newlevel_scr_open

	lea	LevelRsrc(a4),a0
	move.w	Level(a4),d1		; current level (starts with 1)
	add.w	d1,d1
	lea	-2(a0,d1.w),a2

	; load map and monster locations
	moveq	#0,d0
	move.b	(a2)+,d0
	bsr	load_map

	; wow the disk motor can be turned off
	bsr	td_motoroff

	; remember this level's song position
	move.b	(a2),LevelSongPos(a4)

	; remember locations of tiles to be controlled by a switch
	bsr	makeSwitchTileTab

	; count items and monsters in the map, reset statistic counters
	bsr	init_stats

	bsr	newlevel_scr_close
	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
handle_input:
; Handle up to seven characters of input from InputBuf.

	tst.b	Status(a4)		; ignore input when not GAME_RUNNING
	bpl	.1

	lea	UnlimLivesCode(a4),a0
	bsr	check_input
	bne	.1

	; enable unlimited lives mode
	move.b	#$99,Lives(a4)
	moveq	#SND_XLIFE,d0
	bra	playSFX

.1:	lea	ExitLevelCode(a4),a0
	bsr	check_input
	beq	.2			; stop game and quit level

	lea	ShowPosCode(a4),a0
	bsr	check_input
	bne	.3

	; display hero position with info sprites
	bsr	getHeroPos
	add.w	#HEROW/2,d0		; center coordinates
	add.w	#HEROH/2,d1
	asr.w	#4,d0			; convert to map coordinates
	asr.w	#4,d1
	movem.w	d0-d1,ShowPosX(a4)

	; Stopping a game while the hero is alive will display the
	; "well done" message and proceed to the next level.
.2:	clr.b	Status(a4)		; GAME_STOPPED

.3:	rts


check_input:
; a0 = code to compare with input buffer
; -> Z true: match, false: no match
	lea	InputBuf(a4),a1
	moveq	#7,d1

.1:	move.b	-(a0),d0
	eor.b	d1,d0
	cmp.b	(a1)+,d0
	bne	.2
	cmp.b	#10,d0
	dbeq	d1,.1

.2:	rts


;---------------------------------------------------------------------------
	xdef	addScore
addScore:
; Add a maximum 4-digit BCD to the current score.
; d0.w = score in BCD
; All registers, except d0, are preserved!

	movem.l	a0-a1,-(sp)

	move.l	sp,a0
	move.w	d0,-(sp)
	clr.w	-(sp)
	lea	Score+3(a4),a1
	sub.w	d0,d0			; clear X
	abcd	-(a0),-(a1)
	abcd	-(a0),-(a1)
	abcd	-(a0),-(a1)
	addq.l	#4,sp
	bcc	.1

	; maximum BCD score overflowed, reset to $999999
	move.b	#$99,d0
	move.b	d0,(a1)+
	move.b	d0,(a1)+
	move.b	d0,(a1)

.1:	movem.l	(sp)+,a0-a1
	rts


;---------------------------------------------------------------------------
	xdef	addLives
addLives:
; Add a 2-digit BCD to the current number of lives.
; d0.b = lives to add in BCD
; All registers are preserved!

	move.l	d1,-(sp)

	sub.w	d1,d1			; clear X
	move.b	Lives(a4),d1
	cmp.b	#$99,d1			; unlimited lives?
	beq	.1
	abcd	d0,d1
.1:	move.b	d1,Lives(a4)

	move.l	(sp)+,d1
	rts


;---------------------------------------------------------------------------
	xdef	addGems
addGems:
; Add a 2-digit BCD to the current number of gems collected.
; d0.b = gems to add in BCD
; All registers are preserved!

	move.l	d1,-(sp)

	sub.w	d1,d1			; clear X
	move.b	Gems(a4),d1
	abcd	d0,d1
	cmp.b	#GEMS_XLIFE,d1
	blo	.1

	; enough gems collected - grant an extra life and reset the counter
	moveq	#1,d0
	bsr	addLives
	moveq	#SND_XLIFE,d0
	bsr	playSFX
	moveq	#0,d1

.1:	move.b	d1,Gems(a4)

	move.l	(sp)+,d1
	rts


;---------------------------------------------------------------------------
subLives:
; Subtract a 2-digit BCD from the current number of lives.
; d0.b = lives to subtract in BCD
; -> Z-flag set, when lives reached zero
; All registers are preserved!

	move.l	d1,-(sp)

	sub.w	d1,d1			; clear X
	move.b	Lives(a4),d1
	cmp.b	#$99,d1			; unlimited lives?
	beq	.1
	sbcd	d0,d1
	bcc	.1
	moveq	#0,d1
.1:	move.b	d1,Lives(a4)

	move.l	(sp)+,d1
	tst.b	Lives(a4)
	rts


;---------------------------------------------------------------------------
show_pos:
; Write a map position into the info sprites.
; d0 = map column (x)
; d1 = map row (y)

	; convert column
	lea	TxtMapPos+2(a4),a0
	bsr	.uword2asc

	; convert row
	lea	TxtMapPos+8(a4),a0
	move.w	d1,d0
	bsr	.uword2asc

	; render it into the sprites
	lea	TxtMapPos(a4),a0
	bra	draw_infosprite_text

.uword2asc:
; d0 = unsigned 16-bit value (0-9999)
; a0 = buffer for 4 ASCII digits

	ext.l	d0
	move.l	#$30303030,(a0)		; "0000"
	divu	#1000,d0
	add.b	d0,(a0)+
	clr.w	d0
	swap	d0
	divu	#100,d0
	add.b	d0,(a0)+
	clr.w	d0
	swap	d0
	divu	#10,d0
	add.b	d0,(a0)+
	swap	d0
	add.b	d0,(a0)+
	rts



	section	__MERGED,data


	; Level and World table. Defines which level belongs to which world.
LevelWorlds:
	dc.b	1,1			; 1: Mansion level 1-2
	dc.b	2,2,2			; 2: Maya level 3-5
	dc.b	3,3,3			; 3: Egypt level 6-8
	dc.b	4,4			; 4: Babylon level 9-10

	; Definition of all files to load for a world.
	; Structure is defined in game.i (WorldFiles, WF):
	; world number, loading-picture, loading-chipmod,
	; types, tiles, fgblocks, background-copper,
	; monster characteristics, monst16, monst20,
	; mod, get-ready songpos, game-over songpos, level-done songpos,
	; level-stats songpos, sound-set
WorldRsrc:
	; world 1
	dc.b	1,FIL_LOADPIC1,FIL_MODLOADWRLD
	dc.b	FIL_TYPES1,FIL_TILES1,FIL_FG1,FIL_COPPER1
	dc.b	FIL_MONSTCHAR1,FIL_16MONST1,FIL_20MONST1
	dc.b	FIL_MOD1,$3d,$3e,$3f,$40,SSET_WORLD1
	; world 2
	dc.b	2,FIL_LOADPIC2,FIL_MODLOADWRLD
	dc.b	FIL_TYPES2,FIL_TILES2,FIL_FG2,FIL_COPPER2
	dc.b	FIL_MONSTCHAR2,FIL_16MONST2,FIL_20MONST2
	dc.b	FIL_MOD2,$51,$52,$53,$54,SSET_WORLD1
	; world 3
	dc.b	3,FIL_LOADPIC3,FIL_MODLOADWRLD
	dc.b	FIL_TYPES3,FIL_TILES3,FIL_FG3,FIL_COPPER3
	dc.b	FIL_MONSTCHAR3,FIL_16MONST3,FIL_20MONST3
	dc.b	FIL_MOD3,$1f,$20,$21,$7a,SSET_WORLD1
	; world 4
	dc.b	4,FIL_LOADPIC4,FIL_MODLOADWRLD
	dc.b	FIL_TYPES4,FIL_TILES4,FIL_FG4,FIL_COPPER4
	dc.b	FIL_MONSTCHAR4,FIL_16MONST4,FIL_20MONST4
	dc.b	FIL_MOD4,$26,$27,$28,$4c,SSET_WORLD1

	; Defines the map file id and song position for each level.
	; Format: map_file_index, song_pos
LevelRsrc:
	; World 1: Mansion levels 1-2
	dc.b	FIL_MAP1_1,$00
	dc.b	FIL_MAP1_2,$1f
	; World 2: Maya levels 3-5
	dc.b	FIL_MAP2_1,$00
	dc.b	FIL_MAP2_2,$21
	dc.b	FIL_MAP2_3,$36
	; World 3: Egypt levels 6-8
	dc.b	FIL_MAP3_1,$00
	dc.b	FIL_MAP3_2,$22
	dc.b	FIL_MAP3_3,$4e
	; World 4: Babylon levels 9-10
	dc.b	FIL_MAP4_1,$00
	dc.b	FIL_MAP4_2,$29
	even

	; pointer to the world's color table (32 RGB4 entries)
Colortable:
	dc.l	TypesBuffer+TTcolormap

	; pointer to table of animated background blocks for the current map
AnimBlocks:
	dc.l	TypesBuffer+TTanimtypes

	; pointer to table of solid blocks for the current map
	xdef	SolidBlocks
SolidBlocks:
	dc.l	TypesBuffer+TTsolidblocks

	; pointer to table of background block types for the current map
	xdef	BackgdBlocks
BackgdBlocks:
	dc.l	TypesBuffer+TTbackgdblocks

	; pointer to table of foreground block types for the current map
	xdef	FgBlockTypes
FgBlockTypes:
	dc.l	TypesBuffer+TTfgblktypes

	; Cheat codes.
	; Strings are stored in reverse order, maximum length 7 characters,
	; xored by 7-pos and terminated by a line feed (10).
	dc.b	10,'X'^1,'I'^2,'N'^3,'E'^4,'O'^5,'H'^6,'P'^7
UnlimLivesCode:				; "PHOENIX"
	dc.b	10^1,'G'^2,'N'^3,'A'^4,'G'^5,'D'^6,'U'^7
ExitLevelCode:				; "UDGANG"
	dc.b	10^1,'S'^2,'D'^3,'R'^4,'O'^5,'O'^6,'C'^7
ShowPosCode:				; "COORDS"
	even

	; Position text to write into the info sprites.
TxtMapPos:
	dc.b	"X:0000"
	dc.b	"Y:0000"



	section	__MERGED,bss


	; Keyboard input ring buffer for 8 characters. Reset by Return key.
InputBuf:
	ds.b	8
InputBufIndex:
	ds.w	1

	; Position to show in info sprites.
ShowPosX:
	ds.w	1
ShowPosY:
	ds.w	1

	; Each frame has a new 16-bit random value.
	xdef	FrameRand
FrameRand:
	ds.w	1

	; Remember the base Chip RAM address for data belonging to the
	; current world and the whole game.
	; The WorldChipPtr memory will be deallocated when a new world
	; is entered. The GameChipPtr when the game is stopped.
GameChipPtr:
	ds.l	1
WorldChipPtr:
	ds.l	1

	; The ViewChipPtr restores the BOB backup buffers when
	; resetting the Views (level restart).
ViewChipPtr:
	ds.l	1

	; Current world. Warning: Level MUST follow World in memory!
World:
	ds.w	1

	; Current level and start level
	xdef	Level
	xdef	StartLevel
Level:
	ds.w	1
StartLevel:
	ds.w	1

	; Score, number of lives and gems collected in BCD
	xdef	Score
Score:
	ds.b	3
	xdef	Lives
Lives:
	ds.b	1
Gems:
	ds.b	1

	; Game status.
	; Set to GAME_RUNNING, when the game is running normally.
	; Set to GAME_MESSAGE, when a message text (like "get ready"
	; or "game over" is displayed, then set to GAME_WAITBTN to
	; wait for the button.
	; Set to GAME_STOPPED by external events to break the game loop
	; (e.g. when the player lost a life).
	xdef	Status
Status:
	ds.b	1

	; Set to non-zero, when we want to leave the current level.
	; -1 means that we're leaving because the game is over and
	; 1 means that we successfully finished that level.
LevelDone:
	ds.b	1

	; Set to non-zero, when the last level was finished. Returned as a
	; flag by exitgame() to request the end-sequence.
GameFinished:
	ds.b	1

	; Song position of Get Ready, Game Over and Well Done jingles.
GetRdySongPos:
	ds.b	1
GamOvrSongPos:
	ds.b	1
LvDoneSongPos:
	ds.b	1

	; True, when Get Ready jingle had been played once for this level.
JinglePlayed:
	ds.b	1

	; Level's main song position.
LevelSongPos:
	ds.b	1

	; Level statistics song position.
StatsSongPos:
	ds.b	1
	even



	bss


	; The types buffer contains all kinds of information about the
	; current world's tileset.
	; The used color map, tables with types of solid, background and
	; foreground blocks, which are important to detect collisions.
	; And a table of animated background tiles.
	;
	; Offset $0000: color map
	; Offset $0040: background tiles types (unmasked, empty)
	; Offset $0140: foreground blocks types (masked, empty)
	; Offset $0240: number of animation phases for foreground blocks
	; Offset $0340: animation speed in frames for foreground blocks
	; Offset $0440: monster16 image types (masked, empty)
	; Offset $0540: monster20 image types (masked, empty)
	; Offset $0640: solid blocks table
	; Offset $0740: background block types table
	; Offset $0840: foreground block types table
	; Offset $0940: animated background tiles types table
	; Offset $0a40: animated background tiles: number of phases and speed
	;               For each type: 1 byte nPhase, 1 byte speed
TypesBuffer:
	ds.b	sizeof_Types
