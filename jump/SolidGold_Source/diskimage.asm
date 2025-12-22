*
* Boot block and disk image for Solid Gold
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

	include	"exec/io.i"
	include	"exec/memory.i"
	include	"exec/execbase.i"
	include	"devices/trackdisk.i"

	include	"version.i"
	include	"loader.i"
	include	"files.i"
	include	"custom.i"


; exec.library LVOs
Supervisor	equ	-30
AllocMem	equ	-198
AllocAbs	equ	-204
DoIO		equ	-456



	org	0			; don't care, all code is PC-relative


	; AmigaDOS boot blocks (1024 bytes)
boot:
	dc.b	"DOS",0
	dc.l	0			; checksum will be inserted here
	dc.l	DISK_ID			; identification for td_selectdisk()

;---------------------------------------------------------------------------
boot_code:
; a6 = SysBase
; a1 = trackdisk IOStdReq

	move.l	a1,a5			; a5 IOStdReq

	; get a Chip RAM buffer for the crunched loader
	move.l	#loader_end-loader,d0
	move.l	#MEMF_CHIP,d1
	jsr	AllocMem(a6)
	move.l	d0,-(sp)
	beq	nomemerr
	move.l	d0,a2			; a2 crunched loader

	; read the bytekiller-crunched loader into that buffer
	move.l	a5,a1
	move.l	#loader_end-loader,IO_LENGTH(a1)
	move.l	a2,IO_DATA(a1)
	move.l	#loader-boot,IO_OFFSET(a1)
	jsr	DoIO(a6)
	tst.b	d0
	bne	readerr

	; get Bytekiller header into d5-d7
	; 0: crunched size
	; 4: decrunced size
	; 8: checksum
	movem.l	(a2)+,d5-d7

	; allocate memory for the loader at LOADERBASE
	lea	LOADERBASE,a3		; a3 loader base address
	move.l	a3,a1
	move.l	d6,d0
	jsr	AllocAbs(a6)
	tst.l	d0
	beq	nomemerr

	; get the first word and decrunch the loader
	lea	(a3,d6.l),a4		; a4 loader end address
	add.l	d5,a2			; a2 end of crunched data
	move.l	-(a2),d0
	eor.l	d0,d7
	bsr	decrunch
	bne	csumerr

	; Flush the caches to make the new code visible to the CPU.
	btst	#AFB_68020,AttnFlags+1(a6)
	beq	.1
	move.l	a5,-(sp)
	lea	flushCaches(pc),a5
	jsr	Supervisor(a6)
	move.l	(sp)+,a5

	; Run our loader at LOADERBASE.
	; Arguments: d0 = disk offset main program
.1:	move.l	#solidgold-boot,d0
	jsr	(a3)

	moveq	#0,d0
	rts

csumerr:
	move.w	#$00f,d0		; checksum error after decrunching
	bra	err
nomemerr:
	move.w	#$f00,d0		; cannot allocate memory
	bra	err
readerr:
	move.w	#$cc0,d0		; trackdisk read error
err:	move.w	d0,CUSTOM+COLOR00
	bra	err


;---------------------------------------------------------------------------
; Macro to get the next word from the stream
	macro	NEXTWORD
	move.l	-(a2),d0
	eor.l	d0,d7
	move.w	#$10,ccr
	roxr.l	#1,d0
	endm

decrunch:
; a2 = pointer to current longword to decrunch (loaded to d0)
; a3 = base address of decrunched data
; a4 = pointer to last decrunched longword written
; d0 = current 32-bit stream to decrunch
; d7 = current checksum

	lsr.l	#1,d0
	bne	.1
	NEXTWORD
.1:	bcs	.cmd1xx
	moveq	#8-1,d4
	moveq	#1,d3
	lsr.l	#1,d0
	bne	.2
	NEXTWORD
.2:	bcs	.copy_n_from_d

	; cmd 00: nnn [dddd dddd]  -  copy n+1 times next d to *dest
	moveq	#3-1,d4
	bsr	getbits
	move.w	d2,d3

.copy_d_from_stream:
; copy n+1 times next 8-bit word from stream to *dest
; d3 = n
	moveq	#8-1,d4
.3:	lsr.l	#1,d0
	bne	.4
	NEXTWORD
.4:	roxl.l	#1,d2
	dbf	d4,.3
	move.b	d2,-(a4)
	dbf	d3,.copy_d_from_stream
	bra	check_done

.cmd111:
	; cmd 111: nnnn nnnn [dddd dddd]  -  copy n+9 times next d to *dest
	moveq	#8-1,d4
	bsr	getbits
	move.w	d2,d3
	addq.w	#8,d3			; n+8
	bra	.copy_d_from_stream

.cmd1xx:
	moveq	#2-1,d4
	bsr	getbits
	cmp.b	#2,d2
	blt	.cmd10x
	cmp.b	#3,d2
	beq	.cmd111

	; cmd 110: nnnn nnnn dddd dddd dddd
	; copy n+1 times *(dest+d) to *dest
	moveq	#8-1,d4
	bsr	getbits			; n
	move.w	d2,d3
	moveq	#12-1,d4		; 12 d-bits
	bra	.copy_n_from_d

.cmd10x:
	; cmd 100: dddd dddd d  -  copy 3 times *(dest+d) to *dest
	; cmd 101: dddd dddd dd -  copy 4 times *(dest+d) to *dest
	moveq	#9-1,d4
	add.w	d2,d4			; 9 or 10 d-bits
	addq.w	#2,d2
	move.w	d2,d3			; n = cmd&3 + 2

.copy_n_from_d:
	; copy n+1 times from *(dest+d) to *dest
	; d4 = bitcount for d -1
	; d3 = n
	bsr	getbits			; get d -> d2
	lea	(a4,d2.w),a1
.copyloop:
	move.b	-(a1),-(a4)
	dbf	d3,.copyloop

check_done:
	cmp.l	a4,a3
	blt	decrunch

	move.l	d7,d0			; return checksum
	rts

getbits:
; a2 = crunched stream pointer
; d4 = bits to get - 1
; -> d2 = result, extended to 16 bits

	clr.w	d2
.1:	lsr.l	#1,d0
	bne	.2
	NEXTWORD
.2:	roxl.l	#1,d2
	dbf	d4,.1
	rts


;---------------------------------------------------------------------------
flushCaches:
; This code is run on 68020+ CPUs only and flushes all caches.

	mc68020
	movec	cacr,d0
	tst.w	d0
	bmi	.1			; 68040/68060 I-Cache enabled?

	; clear 68020/68030 caches
	or.w	#$808,d0
	movec	d0,cacr
	rte

	mc68040
	; clear 68040/68060 caches
.1:	nop
	cpusha	bc
	rte


;---------------------------------------------------------------------------
	rorg	1*TD_SECTOR-4

	; Block 0, Offset $1fc: Program version.
	dc.b	'V','0'+VERSION,'.','0'+REVISION


;---------------------------------------------------------------------------
	; Block 1: The directory. Contains start blocks of all files on disk.
	; Must match the file definitions in files.i !
Directory:
	; Menu
	dc.w	(loadingimg-boot)/TD_SECTOR
	dc.w	(logosolid-boot)/TD_SECTOR
	dc.w	(logogold-boot)/TD_SECTOR
	dc.w	(logostars-boot)/TD_SECTOR
	dc.w	(menupointer-boot)/TD_SECTOR
	dc.w	(menufont8-boot)/TD_SECTOR
	dc.w	(menufont16-boot)/TD_SECTOR
	dc.w	(modmentrk-boot)/TD_SECTOR
	dc.w	(modmensmp-boot)/TD_SECTOR
;	dc.w	(sfxmenu-boot)/TD_SECTOR
	dc.w	(sfxselect-boot)/TD_SECTOR
	; Introduction
	dc.w	(modintrotrk-boot)/TD_SECTOR
	dc.w	(modintrosmp-boot)/TD_SECTOR
	dc.w	(introscene1-boot)/TD_SECTOR
	dc.w	(introscene2-boot)/TD_SECTOR
	dc.w	(introscene3-boot)/TD_SECTOR
	dc.w	(introscene4-boot)/TD_SECTOR
	dc.w	(introscene5-boot)/TD_SECTOR
	dc.w	(introscene6-boot)/TD_SECTOR
	; Miscellaneous
	dc.w	(modloadworld-boot)/TD_SECTOR
	dc.w	(endpic-boot)/TD_SECTOR
	; Game files
	dc.w	(hero22-boot)/TD_SECTOR
	dc.w	(gamefont8-boot)/TD_SECTOR
	dc.w	(gamesprites-boot)/TD_SECTOR
	dc.w	(sfxpling-boot)/TD_SECTOR
	dc.w	(sfxchkpt-boot)/TD_SECTOR
	dc.w	(sfxscream-boot)/TD_SECTOR
	dc.w	(sfxsplash-boot)/TD_SECTOR
	dc.w	(sfxhit-boot)/TD_SECTOR
	dc.w	(sfxwall-boot)/TD_SECTOR
	dc.w	(sfxxlife-boot)/TD_SECTOR
	dc.w	(sfxbonus-boot)/TD_SECTOR
	; World 1
	dc.w	(w1pic-boot)/TD_SECTOR
	dc.w	(w1types-boot)/TD_SECTOR
	dc.w	(w1tiles-boot)/TD_SECTOR
	dc.w	(w1fg-boot)/TD_SECTOR
	dc.w	(w1monstchar-boot)/TD_SECTOR
	dc.w	(w1monst16-boot)/TD_SECTOR
	dc.w	(w1monst20-boot)/TD_SECTOR
	dc.w	(w1copper-boot)/TD_SECTOR
	dc.w	(mod1trk-boot)/TD_SECTOR
	dc.w	(mod1smp-boot)/TD_SECTOR
	dc.w	(map1_1-boot)/TD_SECTOR
	dc.w	(map1_2-boot)/TD_SECTOR
	; World 2
	dc.w	(w2pic-boot)/TD_SECTOR
	dc.w	(w2types-boot)/TD_SECTOR
	dc.w	(w2tiles-boot)/TD_SECTOR
	dc.w	(w2fg-boot)/TD_SECTOR
	dc.w	(w2monstchar-boot)/TD_SECTOR
	dc.w	(w2monst16-boot)/TD_SECTOR
	dc.w	(w2monst20-boot)/TD_SECTOR
	dc.w	(w2copper-boot)/TD_SECTOR
	dc.w	(mod2trk-boot)/TD_SECTOR
	dc.w	(mod2smp-boot)/TD_SECTOR
	dc.w	(map2_1-boot)/TD_SECTOR
	dc.w	(map2_2-boot)/TD_SECTOR
	dc.w	(map2_3-boot)/TD_SECTOR
	; World 3
	dc.w	(w3pic-boot)/TD_SECTOR
	dc.w	(w3types-boot)/TD_SECTOR
	dc.w	(w3tiles-boot)/TD_SECTOR
	dc.w	(w3fg-boot)/TD_SECTOR
	dc.w	(w3monstchar-boot)/TD_SECTOR
	dc.w	(w3monst16-boot)/TD_SECTOR
	dc.w	(w3monst20-boot)/TD_SECTOR
	dc.w	(w3copper-boot)/TD_SECTOR
	dc.w	(mod3trk-boot)/TD_SECTOR
	dc.w	(mod3smp-boot)/TD_SECTOR
	dc.w	(map3_1-boot)/TD_SECTOR
	dc.w	(map3_2-boot)/TD_SECTOR
	dc.w	(map3_3-boot)/TD_SECTOR
	; World 4
	dc.w	(w4pic-boot)/TD_SECTOR
	dc.w	(w4types-boot)/TD_SECTOR
	dc.w	(w4tiles-boot)/TD_SECTOR
	dc.w	(w4fg-boot)/TD_SECTOR
	dc.w	(w4monstchar-boot)/TD_SECTOR
	dc.w	(w4monst16-boot)/TD_SECTOR
	dc.w	(w4monst20-boot)/TD_SECTOR
	dc.w	(w4copper-boot)/TD_SECTOR
	dc.w	(mod4trk-boot)/TD_SECTOR
	dc.w	(mod4smp-boot)/TD_SECTOR
	dc.w	(map4_1-boot)/TD_SECTOR
	dc.w	(map4_2-boot)/TD_SECTOR

	dc.w	(end-boot)/TD_SECTOR


	cnop	0,16
	dc.b	"Et stille skrig, der falmer hen. "
	dc.b	"Et roligt smil, der skinner op igen. "
	dc.b	"Glemmer alt der fylder mig med had, "
	dc.b	"og mærker mine minder tage afsted. "
	dc.b	"Jeg ser min tåre falde, af køligt begær. "
	dc.b	"Jeg ved min kamp er ovre, den endte her. "
	dc.b	"Nu er jeg fri, det var alt hvad der skulle til. "
	dc.b	"Jeg trækker vejret frit igen. Frit igen."


;---------------------------------------------------------------------------
	; Disk block 2: It follows the crunched loader program code.
	rorg	2*TD_SECTOR

loader:
	incbin	"loader.bk"
	cnop	0,TD_SECTOR
loader_end:


;---------------------------------------------------------------------------
	; The crunched main program code with reloc table in front.

solidgold:
	incbin	"SolidGold.bk"
	cnop	0,TD_SECTOR
solidgold_end:


;---------------------------------------------------------------------------
	; Menu files
loadingimg:
	incbin	"gfx/loading.bk"
	cnop	0,TD_SECTOR
logosolid:
	incbin	"gfx/logo_solid.bk"
	cnop	0,TD_SECTOR
logogold:
	incbin	"gfx/logo_gold.bk"
	cnop	0,TD_SECTOR
logostars:
	incbin	"gfx/logo_stars.bk"
	cnop	0,TD_SECTOR
menupointer:
	incbin	"gfx/pointer.bk"
	cnop	0,TD_SECTOR
menufont8:
	incbin	"gfx/menufont8.bk"
	cnop	0,TD_SECTOR
menufont16:
	incbin	"gfx/menufont16.bk"
	cnop	0,TD_SECTOR
modmentrk:
	incbin	"mods/TitleTheme.trk.bk"
	cnop	0,TD_SECTOR
modmensmp:
	incbin	"mods/TitleTheme.smp.bk"
	cnop	0,TD_SECTOR
;sfxmenu:
;	incbin	"sfx/menu.bk"
;	cnop	0,TD_SECTOR
sfxselect:
	incbin	"sfx/select.bk"
	cnop	0,TD_SECTOR

	; Introduction files
modintrotrk:
	incbin	"mods/Introduction.trk.bk"
	cnop	0,TD_SECTOR
modintrosmp:
	incbin	"mods/Introduction.smp.bk"
	cnop	0,TD_SECTOR
introscene1:
	incbin	"gfx/introscene1.bk"
	cnop	0,TD_SECTOR
introscene2:
	incbin	"gfx/introscene2.bk"
	cnop	0,TD_SECTOR
introscene3:
	incbin	"gfx/introscene3.bk"
	cnop	0,TD_SECTOR
introscene4:
	incbin	"gfx/introscene4.bk"
	cnop	0,TD_SECTOR
introscene5:
	incbin	"gfx/introscene5.bk"
	cnop	0,TD_SECTOR
introscene6:
	incbin	"gfx/introscene6.bk"
	cnop	0,TD_SECTOR

	; Miscellaneous files
modloadworld:
	incbin	"mods/LoadWorld.mod.bk"
	cnop	0,TD_SECTOR
endpic:
	incbin	"gfx/end.bk"
	cnop	0,TD_SECTOR

	; Game files
hero22:
	incbin	"gfx/hero22.bk"
	cnop	0,TD_SECTOR
gamefont8:
	incbin	"gfx/gamefont_spr.bk"
	cnop	0,TD_SECTOR
gamesprites:
	incbin	"gfx/gamesprites.bk"
	cnop	0,TD_SECTOR
sfxpling:
	incbin	"sfx/pling.bk"
	cnop	0,TD_SECTOR
sfxchkpt:
	incbin	"sfx/checkpoint.bk"
	cnop	0,TD_SECTOR
sfxscream:
	incbin	"sfx/scream.bk"
	cnop	0,TD_SECTOR
sfxsplash:
	incbin	"sfx/splash.bk"
	cnop	0,TD_SECTOR
sfxhit:
	incbin	"sfx/hit.bk"
	cnop	0,TD_SECTOR
sfxwall:
	incbin	"sfx/wall.bk"
	cnop	0,TD_SECTOR
sfxxlife:
	incbin	"sfx/xlife.bk"
	cnop	0,TD_SECTOR
sfxbonus:
	incbin	"sfx/bonus.bk"
	cnop	0,TD_SECTOR

	; World 1 files
w1pic:
	incbin	"w1gfx/loadpic.bk"
	cnop	0,TD_SECTOR
w1types:
	incbin	"w1gfx/types.bk"
	cnop	0,TD_SECTOR
w1tiles:
	incbin	"w1gfx/tiles.bk"
	cnop	0,TD_SECTOR
w1fg:
	incbin	"w1gfx/fg.bk"
	cnop	0,TD_SECTOR
w1monstchar:
	incbin	"w1gfx/monsterchar.bk"
	cnop	0,TD_SECTOR
w1monst16:
	incbin	"w1gfx/monster16.bk"
	cnop	0,TD_SECTOR
w1monst20:
	incbin	"w1gfx/monster20.bk"
	cnop	0,TD_SECTOR
w1copper:
	incbin	"w1gfx/copper.bk"
	cnop	0,TD_SECTOR
mod1trk:
	incbin	"mods/Landhaus.trk.bk"
	cnop	0,TD_SECTOR
mod1smp:
	incbin	"mods/Landhaus.smp.bk"
	cnop	0,TD_SECTOR
map1_1:
	incbin	"maps/mansionlevel1.bk"
	cnop	0,TD_SECTOR
map1_2:
	incbin	"maps/mansionlevel2.bk"
	cnop	0,TD_SECTOR

	; World 2 files
w2pic:
	incbin	"w2gfx/loadpic.bk"
	cnop	0,TD_SECTOR
w2types:
	incbin	"w2gfx/types.bk"
	cnop	0,TD_SECTOR
w2tiles:
	incbin	"w2gfx/tiles.bk"
	cnop	0,TD_SECTOR
w2fg:
	incbin	"w2gfx/fg.bk"
	cnop	0,TD_SECTOR
w2monstchar:
	incbin	"w2gfx/monsterchar.bk"
	cnop	0,TD_SECTOR
w2monst16:
	incbin	"w2gfx/monster16.bk"
	cnop	0,TD_SECTOR
w2monst20:
	incbin	"w2gfx/monster20.bk"
	cnop	0,TD_SECTOR
w2copper:
	incbin	"w2gfx/copper.bk"
	cnop	0,TD_SECTOR
mod2trk:
	incbin	"mods/MexicanJungle.trk.bk"
	cnop	0,TD_SECTOR
mod2smp:
	incbin	"mods/MexicanJungle.smp.bk"
	cnop	0,TD_SECTOR
map2_1:
	incbin	"maps/mayalevel1.bk"
	cnop	0,TD_SECTOR
map2_2:
	incbin	"maps/mayalevel2.bk"
	cnop	0,TD_SECTOR
map2_3:
	incbin	"maps/mayalevel3.bk"
	cnop	0,TD_SECTOR

	; World 3 files
w3pic:
	incbin	"w3gfx/loadpic.bk"
	cnop	0,TD_SECTOR
w3types:
	incbin	"w3gfx/types.bk"
	cnop	0,TD_SECTOR
w3tiles:
	incbin	"w3gfx/tiles.bk"
	cnop	0,TD_SECTOR
w3fg:
	incbin	"w3gfx/fg.bk"
	cnop	0,TD_SECTOR
w3monstchar:
	incbin	"w3gfx/monsterchar.bk"
	cnop	0,TD_SECTOR
w3monst16:
	incbin	"w3gfx/monster16.bk"
	cnop	0,TD_SECTOR
w3monst20:
	incbin	"w3gfx/monster20.bk"
	cnop	0,TD_SECTOR
w3copper:
	incbin	"w3gfx/copper.bk"
	cnop	0,TD_SECTOR
mod3trk:
	incbin	"mods/Egypt.trk.bk"
	cnop	0,TD_SECTOR
mod3smp:
	incbin	"mods/Egypt.smp.bk"
	cnop	0,TD_SECTOR
map3_1:
	incbin	"maps/egyptlevel1.bk"
	cnop	0,TD_SECTOR
map3_2:
	incbin	"maps/egyptlevel2.bk"
	cnop	0,TD_SECTOR
map3_3:
	incbin	"maps/egyptlevel3.bk"
	cnop	0,TD_SECTOR

	; World 4 files
w4pic:
	incbin	"w4gfx/loadpic.bk"
	cnop	0,TD_SECTOR
w4types:
	incbin	"w4gfx/types.bk"
	cnop	0,TD_SECTOR
w4tiles:
	incbin	"w4gfx/tiles.bk"
	cnop	0,TD_SECTOR
w4fg:
	incbin	"w4gfx/fg.bk"
	cnop	0,TD_SECTOR
w4monstchar:
	incbin	"w4gfx/monsterchar.bk"
	cnop	0,TD_SECTOR
w4monst16:
	incbin	"w4gfx/monster16.bk"
	cnop	0,TD_SECTOR
w4monst20:
	incbin	"w4gfx/monster20.bk"
	cnop	0,TD_SECTOR
w4copper:
	incbin	"w4gfx/copper.bk"
	cnop	0,TD_SECTOR
mod4trk:
	incbin	"mods/BabylonSound.trk.bk"
	cnop	0,TD_SECTOR
mod4smp:
	incbin	"mods/BabylonSound.smp.bk"
	cnop	0,TD_SECTOR
map4_1:
	incbin	"maps/babylonlevel1.bk"
	cnop	0,TD_SECTOR
map4_2:
	incbin	"maps/babylonlevel2.bk"
	cnop	0,TD_SECTOR
end:

	; Reserve the last track for highscores. The assembler will
	; display a fatal error when this offset is passed.
	rorg	159*11*TD_SECTOR

	; Clear highscores. They will be initialized by the game.
	ds.b	11*TD_SECTOR

	end
