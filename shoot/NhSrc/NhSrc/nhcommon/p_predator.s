	.file	"p_predator.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC0:
	.long 0x3f800000
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl randomPredator
	.type	 randomPredator,@function
randomPredator:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 11,.LC0@ha
	lis 9,maxclients@ha
	la 11,.LC0@l(11)
	mr 31,3
	lfs 0,0(11)
	li 4,0
	li 10,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L32
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	addi 11,11,952
	lfd 13,0(9)
.L28:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L31
	lwz 0,932(11)
	cmpwi 0,0,0
	bc 4,2,.L31
	xor 9,11,31
	addic 9,9,-1
	subfe 9,9,9
	addi 0,4,1
	andc 0,0,9
	and 9,4,9
	or 4,9,0
.L31:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,952
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L28
.L32:
	cmpwi 0,4,0
	bc 12,2,.L25
	li 3,1
	bl nhrand
	lis 9,maxclients@ha
	mr 7,3
	lwz 11,maxclients@l(9)
	li 10,0
	li 8,1
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	lfs 13,20(11)
	lfs 0,0(9)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L43
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	addi 3,11,952
	lfd 13,0(9)
.L37:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L42
	lwz 0,932(3)
	cmpwi 0,0,0
	bc 4,2,.L42
	xor 9,3,31
	addic 9,9,-1
	subfe 9,9,9
	addi 0,10,1
	andc 0,0,9
	and 9,10,9
	or 10,9,0
	cmpw 0,10,7
	bc 12,2,.L41
.L42:
	addi 8,8,1
	xoris 0,8,0x8000
	addi 3,3,952
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L37
.L43:
	li 3,0
.L41:
	bl switchPredator
.L25:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 randomPredator,.Lfe1-randomPredator
	.section	".rodata"
	.align 2
.LC2:
	.string	"rockets"
	.align 2
.LC3:
	.string	"slugs"
	.align 2
.LC4:
	.string	"Railgun"
	.align 2
.LC5:
	.string	"Rocket Launcher"
	.section	".text"
	.align 2
	.globl initPredator
	.type	 initPredator,@function
initPredator:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,predator_max_rockets@ha
	lwz 10,predator_max_rockets@l(11)
	mr 31,3
	lis 8,predator_max_slugs@ha
	mr 11,9
	lwz 7,84(31)
	lis 3,.LC2@ha
	lfs 0,20(10)
	la 3,.LC2@l(3)
	lis 28,0x286b
	lwz 10,predator_max_slugs@l(8)
	ori 28,28,51739
	li 30,1
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,1772(7)
	lfs 0,20(10)
	lwz 9,84(31)
	fctiwz 12,0
	stfd 12,8(1)
	lwz 11,12(1)
	stw 11,1784(9)
	bl FindItem
	lis 9,predator_start_rockets@ha
	lis 29,itemlist@ha
	lwz 11,84(31)
	lwz 10,predator_start_rockets@l(9)
	la 29,itemlist@l(29)
	subf 0,29,3
	lfs 0,20(10)
	mullw 0,0,28
	addi 11,11,740
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	rlwinm 0,0,0,0,29
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stwx 9,11,0
	bl FindItem
	lis 10,predator_start_slugs@ha
	subf 0,29,3
	lwz 11,84(31)
	lwz 8,predator_start_slugs@l(10)
	mullw 0,0,28
	lis 3,.LC4@ha
	addi 11,11,740
	la 3,.LC4@l(3)
	lfs 0,20(8)
	rlwinm 0,0,0,0,29
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stwx 9,11,0
	bl FindItem
	subf 0,29,3
	lwz 11,84(31)
	mullw 0,0,28
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	srawi 0,0,2
	stw 0,736(11)
	lwz 9,84(31)
	lwz 0,736(9)
	addi 9,9,740
	slwi 0,0,2
	stwx 30,9,0
	bl FindItem
	subf 29,29,3
	lwz 11,84(31)
	lis 9,predator_start_health@ha
	mullw 29,29,28
	lwz 6,predator_start_health@l(9)
	mr 8,10
	mr 7,10
	srawi 29,29,2
	stw 29,736(11)
	lwz 9,84(31)
	lwz 0,736(9)
	addi 9,9,740
	slwi 0,0,2
	stwx 30,9,0
	lwz 11,84(31)
	stw 3,1788(11)
	lfs 0,20(6)
	lwz 9,84(31)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
	stw 10,728(9)
	lfs 0,20(6)
	lwz 9,84(31)
	fctiwz 12,0
	stfd 12,8(1)
	lwz 8,12(1)
	stw 8,724(9)
	lfs 0,20(6)
	lwz 0,900(31)
	cmpwi 0,0,0
	fctiwz 11,0
	stfd 11,8(1)
	lwz 7,12(1)
	stw 7,480(31)
	bc 12,2,.L53
	lwz 11,84(31)
	lwz 0,724(11)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	stw 0,724(11)
	lwz 9,84(31)
	lwz 0,724(9)
	stw 0,480(31)
.L53:
	lwz 9,84(31)
	stw 30,720(9)
	bl getMaxTeleportShots
	lwz 11,84(31)
	li 0,0
	stw 3,1820(11)
	lwz 9,84(31)
	stw 0,3820(9)
	stw 0,900(31)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 initPredator,.Lfe2-initPredator
	.section	".rodata"
	.align 2
.LC6:
	.string	"fov"
	.align 2
.LC7:
	.string	"%s\\%s"
	.align 2
.LC8:
	.string	"h_pred"
	.align 2
.LC9:
	.string	"misc/tele1.wav"
	.align 2
.LC10:
	.long 0x3f800000
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl startPredator
	.type	 startPredator,@function
startPredator:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 28,3
	li 4,0
	lwz 3,84(28)
	li 5,1024
	addi 3,3,740
	crxor 6,6,6
	bl memset
	mr 3,28
	bl initPredator
	lwz 9,84(28)
	mr 3,28
	lwz 0,1788(9)
	stw 0,3548(9)
	bl ChangeWeapon
	lwz 9,84(28)
	li 10,0
	lis 8,g_edicts@ha
	lis 11,0x46fd
	li 7,4
	stw 10,0(9)
	ori 11,11,55623
	lis 26,gi@ha
	lwz 9,84(28)
	la 26,gi@l(26)
	lbz 0,16(9)
	andi. 0,0,191
	stb 0,16(9)
	lwz 29,g_edicts@l(8)
	lwz 27,84(28)
	subf 29,29,28
	stw 10,912(28)
	mullw 29,29,11
	stw 10,492(28)
	addi 27,27,700
	stw 7,260(28)
	srawi 29,29,3
	addi 29,29,1311
	bl getLivePredatorSkin
	mr 5,3
	mr 4,27
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	crxor 6,6,6
	bl va
	lwz 9,24(26)
	mr 4,3
	mr 3,29
	mtlr 9
	blrl
	lwz 9,40(26)
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	mtlr 9
	blrl
	lwz 9,84(28)
	sth 3,158(9)
	mr 3,28
	bl PutClientInServer
	lwz 9,36(26)
	lis 3,.LC9@ha
	la 3,.LC9@l(3)
	mtlr 9
	blrl
	lis 9,.LC10@ha
	lwz 0,16(26)
	mr 5,3
	la 9,.LC10@l(9)
	li 4,2
	lfs 1,0(9)
	mtlr 0
	mr 3,28
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 2,0(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 3,0(9)
	blrl
	mr 3,28
	bl ClearFlashlight
	bl getPanicTime
	lis 11,level+4@ha
	lwz 10,84(28)
	lfs 0,level+4@l(11)
	li 0,1
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	add 9,9,3
	stw 9,3848(10)
	mr 3,28
	stw 0,512(28)
	bl setSafetyMode
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 startPredator,.Lfe3-startPredator
	.section	".rodata"
	.align 2
.LC12:
	.string	"predator_max_rockets"
	.align 2
.LC13:
	.string	"50"
	.align 2
.LC14:
	.string	"predator_max_slugs"
	.align 2
.LC15:
	.string	"20"
	.align 2
.LC16:
	.string	"predator_start_rockets"
	.align 2
.LC17:
	.string	"10"
	.align 2
.LC18:
	.string	"predator_start_slugs"
	.align 2
.LC19:
	.string	"5"
	.align 2
.LC20:
	.string	"predator_start_health"
	.align 2
.LC21:
	.string	"200"
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.align 2
.LC22:
	.long 0x3f800000
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl lookForPredator
	.type	 lookForPredator,@function
lookForPredator:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC22@ha
	lis 9,maxclients@ha
	la 11,.LC22@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L46
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	addi 11,11,952
	lfd 13,0(9)
.L48:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L47
	lwz 0,932(11)
	cmpwi 0,0,0
	bc 4,2,.L47
	lwz 0,896(11)
	cmpwi 0,0,0
	bc 4,2,.L44
.L47:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,952
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L48
.L46:
	li 3,0
	bl randomPredator
.L44:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 lookForPredator,.Lfe4-lookForPredator
	.section	".rodata"
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC25:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl switchPredator
	.type	 switchPredator,@function
switchPredator:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 29,3
	li 26,1
	lis 28,level@ha
	stw 26,896(29)
	li 27,0
	la 28,level@l(28)
	li 0,0
	stw 27,320(28)
	lis 4,.LC6@ha
	stw 27,324(28)
	la 4,.LC6@l(4)
	stw 27,328(28)
	lwz 9,84(29)
	stw 27,92(9)
	lwz 11,84(29)
	stw 27,88(11)
	lwz 9,84(29)
	stw 0,3724(9)
	lwz 11,84(29)
	stw 0,3728(11)
	lwz 9,84(29)
	stw 0,3732(9)
	lwz 11,84(29)
	stw 0,3736(11)
	lwz 9,84(29)
	stw 0,3860(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 10,84(29)
	stw 3,20(1)
	lis 0,0x4330
	lis 11,.LC24@ha
	la 11,.LC24@l(11)
	stw 0,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC25@ha
	la 11,.LC25@l(11)
	lfs 11,0(11)
	fsub 0,0,12
	mr 11,9
	frsp 0,0
	stfs 0,112(10)
	stw 27,512(29)
	lfs 0,4(28)
	fadds 0,0,11
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	stw 11,312(28)
	stw 26,912(29)
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 switchPredator,.Lfe5-switchPredator
	.section	".rodata"
	.align 2
.LC26:
	.long 0x3f800000
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl countPlayers
	.type	 countPlayers,@function
countPlayers:
	stwu 1,-16(1)
	lis 11,.LC26@ha
	lis 9,maxclients@ha
	la 11,.LC26@l(11)
	mr 8,3
	lfs 0,0(11)
	li 3,0
	li 10,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L8
	lis 9,g_edicts@ha
	fmr 12,13
	lis 7,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	addi 11,11,952
	lfd 13,0(9)
.L10:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 0,932(11)
	cmpwi 0,0,0
	bc 4,2,.L9
	xor 9,11,8
	addic 9,9,-1
	subfe 9,9,9
	addi 0,3,1
	andc 0,0,9
	and 9,3,9
	or 3,9,0
.L9:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,952
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L10
.L8:
	la 1,16(1)
	blr
.Lfe6:
	.size	 countPlayers,.Lfe6-countPlayers
	.section	".rodata"
	.align 2
.LC28:
	.long 0x3f800000
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl getPlayer
	.type	 getPlayer,@function
getPlayer:
	stwu 1,-16(1)
	lis 11,.LC28@ha
	lis 9,maxclients@ha
	la 11,.LC28@l(11)
	mr 7,3
	lfs 0,0(11)
	li 10,0
	li 8,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L16
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	addi 3,11,952
	lfd 13,0(9)
.L18:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L17
	lwz 0,932(3)
	cmpwi 0,0,0
	bc 4,2,.L17
	xor 9,3,4
	addic 9,9,-1
	subfe 9,9,9
	addi 0,10,1
	andc 0,0,9
	and 9,10,9
	or 10,9,0
	cmpw 0,10,7
	bc 12,2,.L96
.L17:
	addi 8,8,1
	xoris 0,8,0x8000
	addi 3,3,952
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L18
.L16:
	li 3,0
.L96:
	la 1,16(1)
	blr
.Lfe7:
	.size	 getPlayer,.Lfe7-getPlayer
	.align 2
	.globl quitPredator
	.type	 quitPredator,@function
quitPredator:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lwz 0,896(9)
	cmpwi 0,0,0
	bc 12,2,.L23
	li 0,0
	stw 0,912(9)
	stw 0,896(9)
	bl randomPredator
.L23:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 quitPredator,.Lfe8-quitPredator
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.section	".sbss","aw",@nobits
	.align 2
saveHand:
	.space	4
	.size	 saveHand,4
	.section	".rodata"
	.align 2
.LC30:
	.long 0x0
	.align 2
.LC31:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validatePredatorMaxRockets
	.type	 validatePredatorMaxRockets,@function
validatePredatorMaxRockets:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC30@ha
	lis 9,predator_max_rockets@ha
	la 11,.LC30@l(11)
	lfs 0,0(11)
	lwz 11,predator_max_rockets@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L58
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L57
.L58:
	lis 9,gi+148@ha
	lis 3,.LC12@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC13@ha
	la 3,.LC12@l(3)
	la 4,.LC13@l(4)
	mtlr 0
	blrl
.L57:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 validatePredatorMaxRockets,.Lfe9-validatePredatorMaxRockets
	.section	".rodata"
	.align 2
.LC32:
	.long 0x0
	.align 2
.LC33:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getPredatorMaxRockets
	.type	 getPredatorMaxRockets,@function
getPredatorMaxRockets:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_max_rockets@ha
	lwz 9,predator_max_rockets@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L60
	lfs 13,20(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L61
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L60
.L61:
	lis 9,gi+148@ha
	lis 3,.LC12@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC13@ha
	la 3,.LC12@l(3)
	la 4,.LC13@l(4)
	mtlr 0
	blrl
.L60:
	lis 11,predator_max_rockets@ha
	lwz 9,predator_max_rockets@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 getPredatorMaxRockets,.Lfe10-getPredatorMaxRockets
	.section	".rodata"
	.align 2
.LC34:
	.long 0x0
	.align 2
.LC35:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validatePredatorMaxSlugs
	.type	 validatePredatorMaxSlugs,@function
validatePredatorMaxSlugs:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC34@ha
	lis 9,predator_max_slugs@ha
	la 11,.LC34@l(11)
	lfs 0,0(11)
	lwz 11,predator_max_slugs@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L66
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L65
.L66:
	lis 9,gi+148@ha
	lis 3,.LC14@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC15@ha
	la 3,.LC14@l(3)
	la 4,.LC15@l(4)
	mtlr 0
	blrl
.L65:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 validatePredatorMaxSlugs,.Lfe11-validatePredatorMaxSlugs
	.section	".rodata"
	.align 2
.LC36:
	.long 0x0
	.align 2
.LC37:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getPredatorMaxSlugs
	.type	 getPredatorMaxSlugs,@function
getPredatorMaxSlugs:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_max_slugs@ha
	lwz 9,predator_max_slugs@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L68
	lfs 13,20(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L69
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L68
.L69:
	lis 9,gi+148@ha
	lis 3,.LC14@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC15@ha
	la 3,.LC14@l(3)
	la 4,.LC15@l(4)
	mtlr 0
	blrl
.L68:
	lis 11,predator_max_slugs@ha
	lwz 9,predator_max_slugs@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 getPredatorMaxSlugs,.Lfe12-getPredatorMaxSlugs
	.section	".rodata"
	.align 2
.LC38:
	.long 0x0
	.align 2
.LC39:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validatePredatorStartRockets
	.type	 validatePredatorStartRockets,@function
validatePredatorStartRockets:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC38@ha
	lis 9,predator_start_rockets@ha
	la 11,.LC38@l(11)
	lfs 0,0(11)
	lwz 11,predator_start_rockets@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L74
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L73
.L74:
	lis 9,gi+148@ha
	lis 3,.LC16@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC17@ha
	la 3,.LC16@l(3)
	la 4,.LC17@l(4)
	mtlr 0
	blrl
.L73:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 validatePredatorStartRockets,.Lfe13-validatePredatorStartRockets
	.section	".rodata"
	.align 2
.LC40:
	.long 0x0
	.align 2
.LC41:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getPredatorStartRockets
	.type	 getPredatorStartRockets,@function
getPredatorStartRockets:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_start_rockets@ha
	lwz 9,predator_start_rockets@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L76
	lfs 13,20(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L77
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L76
.L77:
	lis 9,gi+148@ha
	lis 3,.LC16@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC17@ha
	la 3,.LC16@l(3)
	la 4,.LC17@l(4)
	mtlr 0
	blrl
.L76:
	lis 11,predator_start_rockets@ha
	lwz 9,predator_start_rockets@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 getPredatorStartRockets,.Lfe14-getPredatorStartRockets
	.section	".rodata"
	.align 2
.LC42:
	.long 0x0
	.align 2
.LC43:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validatePredatorStartSlugs
	.type	 validatePredatorStartSlugs,@function
validatePredatorStartSlugs:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC42@ha
	lis 9,predator_start_slugs@ha
	la 11,.LC42@l(11)
	lfs 0,0(11)
	lwz 11,predator_start_slugs@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L82
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L81
.L82:
	lis 9,gi+148@ha
	lis 3,.LC18@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC19@ha
	la 3,.LC18@l(3)
	la 4,.LC19@l(4)
	mtlr 0
	blrl
.L81:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 validatePredatorStartSlugs,.Lfe15-validatePredatorStartSlugs
	.section	".rodata"
	.align 2
.LC44:
	.long 0x0
	.align 2
.LC45:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getPredatorStartSlugs
	.type	 getPredatorStartSlugs,@function
getPredatorStartSlugs:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_start_slugs@ha
	lwz 9,predator_start_slugs@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L84
	lfs 13,20(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L85
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L84
.L85:
	lis 9,gi+148@ha
	lis 3,.LC18@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC19@ha
	la 3,.LC18@l(3)
	la 4,.LC19@l(4)
	mtlr 0
	blrl
.L84:
	lis 11,predator_start_slugs@ha
	lwz 9,predator_start_slugs@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 getPredatorStartSlugs,.Lfe16-getPredatorStartSlugs
	.section	".rodata"
	.align 2
.LC46:
	.long 0x0
	.align 2
.LC47:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validatePredatorStartHealth
	.type	 validatePredatorStartHealth,@function
validatePredatorStartHealth:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC46@ha
	lis 9,predator_start_health@ha
	la 11,.LC46@l(11)
	lfs 0,0(11)
	lwz 11,predator_start_health@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L90
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L89
.L90:
	lis 9,gi+148@ha
	lis 3,.LC20@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC21@ha
	la 3,.LC20@l(3)
	la 4,.LC21@l(4)
	mtlr 0
	blrl
.L89:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 validatePredatorStartHealth,.Lfe17-validatePredatorStartHealth
	.section	".rodata"
	.align 2
.LC48:
	.long 0x0
	.align 2
.LC49:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getPredatorStartHealth
	.type	 getPredatorStartHealth,@function
getPredatorStartHealth:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_start_health@ha
	lwz 9,predator_start_health@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L92
	lfs 13,20(9)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L93
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L92
.L93:
	lis 9,gi+148@ha
	lis 3,.LC20@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC21@ha
	la 3,.LC20@l(3)
	la 4,.LC21@l(4)
	mtlr 0
	blrl
.L92:
	lis 11,predator_start_health@ha
	lwz 9,predator_start_health@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 getPredatorStartHealth,.Lfe18-getPredatorStartHealth
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
