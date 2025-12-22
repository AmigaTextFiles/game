	.file	"trond_menu.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"beretta"
	.align 2
.LC1:
	.string	"berettarounds"
	.align 2
.LC2:
	.string	"glock"
	.align 2
.LC3:
	.string	"glockrounds"
	.align 2
.LC4:
	.string	"casull"
	.align 2
.LC5:
	.string	"casullrounds"
	.align 2
.LC6:
	.string	"mp5"
	.align 2
.LC7:
	.string	"mp5rounds"
	.align 2
.LC8:
	.string	"mariner"
	.align 2
.LC9:
	.string	"marinerrounds"
	.align 2
.LC10:
	.string	"ak 47"
	.align 2
.LC11:
	.string	"ak47rounds"
	.align 2
.LC12:
	.string	"barrett"
	.align 2
.LC13:
	.string	"50cal"
	.globl weapmenu
	.section	".data"
	.align 2
	.type	 weapmenu,@object
weapmenu:
	.long .LC14
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC15
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC16
	.long 0
	.long 0
	.long Beretta
	.long .LC17
	.long 0
	.long 0
	.long Glock
	.long .LC18
	.long 0
	.long 0
	.long Casull
	.long .LC19
	.long 0
	.long 0
	.long MP5
	.long .LC20
	.long 0
	.long 0
	.long Mariner
	.long .LC21
	.long 0
	.long 0
	.long AK47
	.long .LC22
	.long 0
	.long 0
	.long Barrett
	.long .LC23
	.long 0
	.long 0
	.long Join
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC24
	.long 0
	.long 0
	.long 0
	.long .LC25
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC25:
	.string	"ENTER to select"
	.align 2
.LC24:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC23:
	.string	"Join game"
	.align 2
.LC22:
	.string	"Barrett"
	.align 2
.LC21:
	.string	"AK47"
	.align 2
.LC20:
	.string	"Mariner shotgun"
	.align 2
.LC19:
	.string	"MP5 w/silencer"
	.align 2
.LC18:
	.string	"Casull .454"
	.align 2
.LC17:
	.string	"Glock 17 w/silencer"
	.align 2
.LC16:
	.string	"Beretta 92FS"
	.align 2
.LC15:
	.string	"*What weapon(s) do you want?"
	.align 2
.LC14:
	.string	"*SLAT Software`s Terror Quake"
	.size	 weapmenu,272
	.lcomm	levelname.30,32,4
	.lcomm	team1players.31,32,4
	.lcomm	team2players.32,32,4
	.align 2
.LC26:
	.string	"  (%d Terrorist(s))"
	.align 2
.LC27:
	.string	"  (%d Police guy(s))"
	.align 2
.LC28:
	.long 0x0
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFUpdateWepMenu
	.type	 CTFUpdateWepMenu,@function
CTFUpdateWepMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,g_edicts@ha
	lis 9,weapmenu@ha
	lis 10,.LC16@ha
	lis 8,.LC17@ha
	lwz 28,g_edicts@l(11)
	lis 7,.LC18@ha
	lis 5,.LC19@ha
	lis 6,.LC23@ha
	la 9,weapmenu@l(9)
	la 10,.LC16@l(10)
	la 8,.LC17@l(8)
	la 7,.LC18@l(7)
	la 5,.LC19@l(5)
	stw 10,64(9)
	la 6,.LC23@l(6)
	stw 8,80(9)
	lis 11,levelname.30@ha
	stw 7,96(9)
	lis 4,.LC20@ha
	lis 3,.LC21@ha
	stw 5,112(9)
	lis 29,.LC22@ha
	li 0,42
	stw 6,176(9)
	la 4,.LC20@l(4)
	la 3,.LC21@l(3)
	stb 0,levelname.30@l(11)
	la 29,.LC22@l(29)
	la 10,levelname.30@l(11)
	stw 4,128(9)
	stw 3,144(9)
	stw 29,160(9)
	lwz 4,276(28)
	cmpwi 0,4,0
	bc 12,2,.L22
	addi 3,10,1
	li 5,30
	bl strncpy
	b .L23
.L22:
	lis 4,level+72@ha
	addi 3,10,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L23:
	lis 9,maxclients@ha
	lis 11,levelname.30+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	stb 0,levelname.30+31@l(11)
	li 29,0
	lfs 0,0(4)
	li 28,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L25
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC29@ha
	li 8,0
	la 9,.LC29@l(9)
	addi 10,10,1016
	lfd 13,0(9)
.L27:
	lwz 0,0(10)
	addi 10,10,928
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,3532(9)
	cmpwi 0,11,1
	bc 4,2,.L29
	addi 28,28,1
	b .L26
.L29:
	xori 11,11,2
	addi 9,29,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,29,0
	or 29,0,9
.L26:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,4080
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L27
.L25:
	lis 3,team1players.31@ha
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	mr 5,28
	la 3,team1players.31@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.32@ha
	lis 4,.LC27@ha
	la 3,team2players.32@l(3)
	la 4,.LC27@l(4)
	mr 5,29
	crxor 6,6,6
	bl sprintf
	cmpw 0,28,29
	bc 12,1,.L39
	cmpw 0,29,28
	bc 4,1,.L34
.L39:
	li 3,1
	b .L38
.L34:
	bl rand
	andi. 0,3,1
	mfcr 3
	rlwinm 3,3,3,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
.L38:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 CTFUpdateWepMenu,.Lfe1-CTFUpdateWepMenu
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.align 2
	.globl Beretta
	.type	 Beretta,@function
Beretta:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4008(9)
	cmpwi 0,0,3
	bc 4,1,.L6
	lis 3,.LC0@ha
	lis 28,0x286b
	la 3,.LC0@l(3)
	ori 28,28,51739
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC1@ha
	la 29,itemlist@l(29)
	li 10,1
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC1@l(11)
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	bl FindItem
	subf 3,29,3
	lwz 9,84(31)
	li 0,15
	mullw 3,3,28
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,-4
	stw 9,4008(11)
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Beretta,.Lfe2-Beretta
	.align 2
	.globl Glock
	.type	 Glock,@function
Glock:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4008(9)
	cmpwi 0,0,4
	bc 4,1,.L8
	lis 3,.LC2@ha
	lis 28,0x286b
	la 3,.LC2@l(3)
	ori 28,28,51739
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC3@ha
	la 29,itemlist@l(29)
	li 10,1
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC3@l(11)
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	bl FindItem
	subf 3,29,3
	lwz 9,84(31)
	li 0,17
	mullw 3,3,28
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,-5
	stw 9,4008(11)
.L8:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Glock,.Lfe3-Glock
	.align 2
	.globl Casull
	.type	 Casull,@function
Casull:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4008(9)
	cmpwi 0,0,7
	bc 4,1,.L10
	lis 3,.LC4@ha
	lis 28,0x286b
	la 3,.LC4@l(3)
	ori 28,28,51739
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC5@ha
	la 29,itemlist@l(29)
	li 10,1
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC5@l(11)
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	bl FindItem
	subf 3,29,3
	lwz 9,84(31)
	li 0,5
	mullw 3,3,28
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,-8
	stw 9,4008(11)
.L10:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Casull,.Lfe4-Casull
	.align 2
	.globl MP5
	.type	 MP5,@function
MP5:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4008(9)
	cmpwi 0,0,7
	bc 4,1,.L12
	lis 3,.LC6@ha
	lis 28,0x286b
	la 3,.LC6@l(3)
	ori 28,28,51739
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC7@ha
	la 29,itemlist@l(29)
	li 10,1
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC7@l(11)
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	bl FindItem
	subf 3,29,3
	lwz 9,84(31)
	li 0,32
	mullw 3,3,28
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,-8
	stw 9,4008(11)
.L12:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 MP5,.Lfe5-MP5
	.align 2
	.globl Mariner
	.type	 Mariner,@function
Mariner:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4008(9)
	cmpwi 0,0,8
	bc 4,1,.L14
	lis 3,.LC8@ha
	lis 28,0x286b
	la 3,.LC8@l(3)
	ori 28,28,51739
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC9@ha
	la 29,itemlist@l(29)
	li 10,1
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC9@l(11)
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	bl FindItem
	subf 3,29,3
	lwz 9,84(31)
	li 0,9
	mullw 3,3,28
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,-9
	stw 9,4008(11)
.L14:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Mariner,.Lfe6-Mariner
	.align 2
	.globl AK47
	.type	 AK47,@function
AK47:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4008(9)
	cmpwi 0,0,10
	bc 4,1,.L16
	lis 3,.LC10@ha
	lis 28,0x286b
	la 3,.LC10@l(3)
	ori 28,28,51739
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC11@ha
	la 29,itemlist@l(29)
	li 10,1
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC11@l(11)
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	bl FindItem
	subf 3,29,3
	lwz 9,84(31)
	li 0,40
	mullw 3,3,28
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,-11
	stw 9,4008(11)
.L16:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 AK47,.Lfe7-AK47
	.align 2
	.globl Barrett
	.type	 Barrett,@function
Barrett:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4008(9)
	cmpwi 0,0,16
	bc 4,1,.L18
	lis 3,.LC12@ha
	lis 28,0x286b
	la 3,.LC12@l(3)
	ori 28,28,51739
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC13@ha
	la 29,itemlist@l(29)
	li 10,1
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC13@l(11)
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	bl FindItem
	subf 3,29,3
	lwz 9,84(31)
	li 0,10
	mullw 3,3,28
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,-17
	stw 9,4008(11)
.L18:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Barrett,.Lfe8-Barrett
	.align 2
	.globl Join
	.type	 Join,@function
Join:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl PutClientInServer
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 Join,.Lfe9-Join
	.align 2
	.globl CTFOpenWepMenu
	.type	 CTFOpenWepMenu,@function
CTFOpenWepMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl CTFUpdateWepMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,3924(9)
	cmpwi 0,0,0
	bc 12,2,.L41
	li 5,8
	b .L42
.L41:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L42:
	lis 4,weapmenu@ha
	mr 3,31
	la 4,weapmenu@l(4)
	li 6,17
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 CTFOpenWepMenu,.Lfe10-CTFOpenWepMenu
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
