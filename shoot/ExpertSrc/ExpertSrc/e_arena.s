	.file	"e_arena.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Combat Armor"
	.align 2
.LC1:
	.string	"Blaster"
	.align 2
.LC2:
	.string	"Shotgun"
	.align 2
.LC3:
	.string	"Super Shotgun"
	.align 2
.LC4:
	.string	"Machinegun"
	.align 2
.LC5:
	.string	"Chaingun"
	.align 2
.LC6:
	.string	"Grenade Launcher"
	.align 2
.LC7:
	.string	"Rocket Launcher"
	.align 2
.LC8:
	.string	"HyperBlaster"
	.align 2
.LC9:
	.string	"Railgun"
	.align 2
.LC10:
	.string	"BFG10K"
	.align 2
.LC11:
	.string	"Shells"
	.align 2
.LC12:
	.string	"Bullets"
	.align 2
.LC13:
	.string	"Cells"
	.align 2
.LC14:
	.string	"Grenades"
	.align 2
.LC15:
	.string	"Slugs"
	.align 2
.LC16:
	.string	"Rockets"
	.section	".text"
	.align 2
	.globl setArenaStats
	.type	 setArenaStats,@function
setArenaStats:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	lwz 26,84(3)
	li 0,100
	li 23,50
	li 24,200
	lis 3,.LC0@ha
	stw 0,728(26)
	la 3,.LC0@l(3)
	lis 28,0x38e3
	stw 0,732(26)
	ori 28,28,36409
	addi 27,26,744
	stw 0,1772(26)
	li 25,1
	li 22,5
	stw 24,1768(26)
	stw 23,1776(26)
	stw 23,1780(26)
	stw 24,1784(26)
	stw 23,1788(26)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC1@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC1@l(9)
	srawi 0,0,3
	slwi 0,0,2
	stwx 24,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	mr 11,3
	subf 0,29,11
	lis 3,.LC8@ha
	mullw 0,0,28
	la 3,.LC8@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stwx 25,27,9
	stw 11,1792(26)
	stw 0,740(26)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC9@ha
	la 3,.LC9@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 25,27,0
	bl FindItem
	subf 0,29,3
	li 9,25
	mullw 0,0,28
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 23,27,0
	bl FindItem
	subf 0,29,3
	li 9,40
	mullw 0,0,28
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 22,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 22,27,0
	bl FindItem
	subf 3,29,3
	li 0,10
	mullw 3,3,28
	srawi 3,3,3
	slwi 3,3,2
	stwx 0,27,3
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 setArenaStats,.Lfe1-setArenaStats
	.section	".rodata"
	.align 2
.LC17:
	.string	"%s steps into the arena\n"
	.section	".text"
	.align 2
	.globl cycleArena
	.type	 cycleArena,@function
cycleArena:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 31,waitList@ha
	lwz 3,waitList@l(31)
	bl ArraySize
	mr. 3,3
	bc 4,2,.L18
	lis 9,gArenaState@ha
	stw 3,gArenaState@l(9)
	b .L17
.L18:
	lwz 3,waitList@l(31)
	li 4,0
	lis 29,arenaList@ha
	li 30,1
	bl ArrayElementAt
	lwz 0,0(3)
	li 4,0
	lwz 3,waitList@l(31)
	stw 0,8(1)
	bl ArrayDeleteAt
	lwz 3,arenaList@l(29)
	addi 4,1,8
	bl ArrayAppend
	lwz 9,8(1)
	lwz 11,84(9)
	stw 30,3576(11)
	lwz 3,8(1)
	bl respawn
	lwz 11,8(1)
	lis 9,gi@ha
	lis 4,.LC17@ha
	lwz 0,gi@l(9)
	la 4,.LC17@l(4)
	li 3,2
	lwz 5,84(11)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 3,arenaList@l(29)
	bl ArraySize
	cmpwi 0,3,1
	bc 4,1,.L19
	lis 9,level+4@ha
	lis 10,gArenaState@ha
	lfs 0,level+4@l(9)
	lis 11,gCountdownSince@ha
	stw 30,gArenaState@l(10)
	stfs 0,gCountdownSince@l(11)
	b .L17
.L19:
	lis 9,gArenaState@ha
	li 0,0
	stw 0,gArenaState@l(9)
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 cycleArena,.Lfe2-cycleArena
	.section	".rodata"
	.align 2
.LC18:
	.string	"The champion, "
	.align 2
.LC19:
	.string	"The challenger, "
	.align 2
.LC20:
	.string	"%s, has been defeated\n"
	.align 2
.LC21:
	.string	"Fight!!!\n"
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.section	".text"
	.align 2
	.globl arenaInitLevel
	.type	 arenaInitLevel,@function
arenaInitLevel:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,maxclients@ha
	lwz 9,maxclients@l(29)
	lis 28,edictCompare@ha
	li 3,4
	la 5,edictCompare@l(28)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 4,12(1)
	bl ArrayNew
	lwz 11,maxclients@l(29)
	lis 9,waitList@ha
	stw 3,waitList@l(9)
	la 5,edictCompare@l(28)
	lfs 0,20(11)
	li 3,4
	fctiwz 13,0
	stfd 13,8(1)
	lwz 4,12(1)
	bl ArrayNew
	lis 9,arenaList@ha
	lis 11,gArenaState@ha
	li 0,0
	stw 3,arenaList@l(9)
	stw 0,gArenaState@l(11)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 arenaInitLevel,.Lfe3-arenaInitLevel
	.align 2
	.globl arenaEndLevel
	.type	 arenaEndLevel,@function
arenaEndLevel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,waitList@ha
	lwz 3,waitList@l(9)
	bl ArrayFree
	lis 9,arenaList@ha
	lwz 3,arenaList@l(9)
	bl ArrayFree
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 arenaEndLevel,.Lfe4-arenaEndLevel
	.align 2
	.globl arenaConnect
	.type	 arenaConnect,@function
arenaConnect:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lwz 11,84(3)
	lis 9,waitList@ha
	li 0,0
	stw 3,8(1)
	addi 4,1,8
	lwz 3,waitList@l(9)
	stw 0,3576(11)
	bl ArrayAppend
	lis 9,arenaList@ha
	lwz 3,arenaList@l(9)
	bl ArraySize
	cmpwi 0,3,1
	bc 12,1,.L22
	bl cycleArena
.L22:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe5:
	.size	 arenaConnect,.Lfe5-arenaConnect
	.align 2
	.globl arenaDisconnect
	.type	 arenaDisconnect,@function
arenaDisconnect:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lwz 9,84(3)
	stw 3,8(1)
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 12,2,.L24
	lis 9,arenaList@ha
	addi 4,1,8
	lwz 3,arenaList@l(9)
	bl ArrayDelete
	bl cycleArena
	b .L25
.L24:
	lis 9,waitList@ha
	addi 4,1,8
	lwz 3,waitList@l(9)
	bl ArrayDelete
.L25:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe6:
	.size	 arenaDisconnect,.Lfe6-arenaDisconnect
	.align 2
	.globl arenaKilled
	.type	 arenaKilled,@function
arenaKilled:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	stw 3,8(1)
	lis 9,arenaList@ha
	li 4,0
	lwz 3,arenaList@l(9)
	bl ArrayElementAt
	lwz 0,8(1)
	cmpw 0,0,3
	bc 4,2,.L27
	lis 9,gi@ha
	lis 4,.LC18@ha
	lwz 0,gi@l(9)
	la 4,.LC18@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L28
.L27:
	lis 9,gi@ha
	lis 4,.LC19@ha
	lwz 0,gi@l(9)
	la 4,.LC19@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L28:
	lwz 11,8(1)
	lis 9,gi@ha
	lis 4,.LC20@ha
	lwz 0,gi@l(9)
	la 4,.LC20@l(4)
	li 3,2
	lwz 5,84(11)
	addi 29,1,8
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 9,arenaList@ha
	mr 4,29
	lwz 3,arenaList@l(9)
	bl ArrayDelete
	lis 9,waitList@ha
	mr 4,29
	lwz 3,waitList@l(9)
	bl ArrayAppend
	lwz 11,8(1)
	li 0,0
	lwz 9,84(11)
	stw 0,3576(9)
	bl cycleArena
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 arenaKilled,.Lfe7-arenaKilled
	.align 2
	.globl arenaSpawn
	.type	 arenaSpawn,@function
arenaSpawn:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 8,3
	lwz 9,84(8)
	lwz 11,3576(9)
	cmpwi 0,11,0
	bc 12,2,.L15
	lwz 9,184(8)
	lis 0,0x201
	li 11,4
	li 10,2
	ori 0,0,3
	stw 11,260(8)
	rlwinm 9,9,0,0,30
	stw 10,248(8)
	stw 0,252(8)
	stw 9,184(8)
	bl setArenaStats
	b .L16
.L15:
	lwz 9,184(8)
	li 0,1
	stw 0,260(8)
	ori 9,9,1
	stw 11,252(8)
	stw 9,184(8)
	stw 11,248(8)
.L16:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 arenaSpawn,.Lfe8-arenaSpawn
	.align 2
	.globl arenaCountdown
	.type	 arenaCountdown,@function
arenaCountdown:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 8,gArenaState@ha
	lwz 0,gArenaState@l(8)
	cmpwi 0,0,1
	bc 4,2,.L29
	lis 11,level+4@ha
	lis 10,gCountdownSince@ha
	lfs 0,level+4@l(11)
	lfs 12,gCountdownSince@l(10)
	fsubs 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	cmpwi 0,9,10
	bc 4,1,.L29
	lis 9,gi@ha
	lis 4,.LC21@ha
	lwz 9,gi@l(9)
	la 4,.LC21@l(4)
	li 3,2
	li 0,2
	mtlr 9
	stw 0,gArenaState@l(8)
	crxor 6,6,6
	blrl
.L29:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 arenaCountdown,.Lfe9-arenaCountdown
	.align 2
	.globl arenaCombatAllowed
	.type	 arenaCombatAllowed,@function
arenaCombatAllowed:
	lwz 9,84(3)
	li 3,0
	lwz 0,3576(9)
	cmpwi 0,0,0
	bclr 12,2
	lis 9,gArenaState@ha
	lwz 0,gArenaState@l(9)
	xori 3,0,2
	subfic 9,3,0
	adde 3,9,3
	blr
.Lfe10:
	.size	 arenaCombatAllowed,.Lfe10-arenaCombatAllowed
	.comm	waitList,4,4
	.comm	arenaList,4,4
	.comm	gCountdownSince,4,4
	.comm	gArenaState,4,4
	.align 2
	.globl edictCompare
	.type	 edictCompare,@function
edictCompare:
	lwz 0,0(3)
	lwz 3,0(4)
	cmpw 0,0,3
	bc 12,2,.L7
	subfc 3,0,3
	subfe 3,3,3
	nand 3,3,3
	ori 3,3,1
	blr
.L7:
	li 3,0
	blr
.Lfe11:
	.size	 edictCompare,.Lfe11-edictCompare
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
