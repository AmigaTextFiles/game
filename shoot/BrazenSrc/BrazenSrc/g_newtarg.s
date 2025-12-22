	.file	"g_newtarg.c"
gcc2_compiled.:
	.section	".sbss","aw",@nobits
	.align 2
nextid.6:
	.space	4
	.size	 nextid.6,4
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.align 2
.LC1:
	.long 0x447a0000
	.align 2
.LC2:
	.long 0x3f000000
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC4:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC5:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl use_target_steam
	.type	 use_target_steam,@function
use_target_steam:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lis 9,nextid.6@ha
	mr 31,3
	lwz 11,nextid.6@l(9)
	lis 10,nextid.6@ha
	cmpwi 0,11,20000
	bc 4,1,.L7
	lis 0,0x68db
	srawi 9,11,31
	ori 0,0,35757
	mulhw 0,11,0
	srawi 0,0,13
	subf 0,9,0
	mulli 0,0,20000
	subf 0,0,11
	stw 0,nextid.6@l(10)
.L7:
	lis 9,.LC0@ha
	lfs 13,592(31)
	la 9,.LC0@l(9)
	lfs 0,0(9)
	lwz 9,nextid.6@l(10)
	fcmpu 0,13,0
	addi 9,9,1
	stw 9,nextid.6@l(10)
	bc 4,2,.L8
	cmpwi 0,4,0
	bc 12,2,.L9
	lis 10,.LC1@ha
	lfs 0,592(4)
	la 10,.LC1@l(10)
	lfs 13,0(10)
	fmuls 0,0,13
	stfs 0,592(31)
	b .L8
.L9:
	lis 0,0x447a
	stw 0,592(31)
.L8:
	lwz 3,540(31)
	addi 28,31,340
	cmpwi 0,3,0
	bc 12,2,.L11
	lis 9,.LC2@ha
	addi 4,3,236
	la 9,.LC2@l(9)
	addi 3,3,212
	lfs 1,0(9)
	addi 5,1,8
	bl VectorMA
	lfs 12,8(1)
	mr 3,28
	lfs 11,4(31)
	lfs 13,12(1)
	lfs 0,16(1)
	fsubs 12,12,11
	lfs 10,8(31)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,340(31)
	fsubs 0,0,11
	stfs 13,344(31)
	stfs 0,348(31)
	bl VectorNormalize
.L11:
	lwz 0,1032(31)
	lis 11,0x4330
	lis 10,.LC3@ha
	addi 30,31,4
	xoris 0,0,0x8000
	la 10,.LC3@l(10)
	stw 0,28(1)
	mr 3,30
	mr 4,28
	stw 11,24(1)
	addi 5,1,8
	lfd 0,0(10)
	lfd 1,24(1)
	lis 10,.LC4@ha
	la 10,.LC4@l(10)
	lfd 13,0(10)
	fsub 1,1,0
	fmul 1,1,13
	frsp 1,1
	bl VectorMA
	lis 9,.LC5@ha
	lfs 13,592(31)
	la 9,.LC5@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L12
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,40
	mtlr 9
	blrl
	lwz 11,104(29)
	lis 9,nextid.6@ha
	lwz 3,nextid.6@l(9)
	mtlr 11
	blrl
	lwz 9,100(29)
	lwz 3,532(31)
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,100(29)
	lbz 3,531(31)
	mtlr 9
	blrl
	lwz 9,104(29)
	lha 3,1034(31)
	mtlr 9
	blrl
	lfs 0,592(31)
	lwz 9,108(29)
	mtlr 9
	fctiwz 13,0
	stfd 13,24(1)
	lwz 3,28(1)
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	b .L13
.L12:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,40
	mtlr 9
	blrl
	lwz 9,104(29)
	li 3,-1
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,532(31)
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,100(29)
	lbz 3,531(31)
	mtlr 9
	blrl
	lwz 9,104(29)
	lha 3,1034(31)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
.L13:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 use_target_steam,.Lfe1-use_target_steam
	.section	".rodata"
	.align 2
.LC6:
	.string	"%s at %s: %s is a bad target\n"
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl target_steam_start
	.type	 target_steam_start,@function
target_steam_start:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 9,use_target_steam@ha
	lwz 5,296(31)
	la 9,use_target_steam@l(9)
	stw 9,448(31)
	cmpwi 0,5,0
	bc 12,2,.L15
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L16
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC6@ha
	lwz 6,296(31)
	la 3,.LC6@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L16:
	stw 30,540(31)
	b .L17
.L15:
	addi 3,31,16
	addi 4,31,340
	bl G_SetMovedir
.L17:
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L18
	li 0,32
	stw 0,532(31)
.L18:
	lwz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L19
	li 0,75
	stw 0,1032(31)
.L19:
	lwz 0,528(31)
	cmpwi 0,0,0
	bc 4,2,.L20
	li 0,8
	stw 0,528(31)
.L20:
	lis 9,.LC7@ha
	lfs 13,592(31)
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L21
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fmuls 0,13,0
	stfs 0,592(31)
.L21:
	lbz 0,535(31)
	li 11,1
	lis 10,gi+72@ha
	lbz 9,531(31)
	mr 3,31
	stw 0,532(31)
	stw 9,528(31)
	stw 11,184(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 target_steam_start,.Lfe2-target_steam_start
	.section	".rodata"
	.align 2
.LC9:
	.string	"target_anger_use\n"
	.align 2
.LC10:
	.string	"found target %s\n"
	.align 2
.LC11:
	.string	"WARNING: entity used itself.\n"
	.align 2
.LC12:
	.string	"entity was removed while using targets\n"
	.align 2
.LC13:
	.string	"target_anger without target!\n"
	.align 2
.LC14:
	.string	"target_anger without killtarget!\n"
	.section	".text"
	.align 2
	.globl target_killplayers_use
	.type	 target_killplayers_use,@function
target_killplayers_use:
	stwu 1,-80(1)
	mflr 0
	stmw 19,28(1)
	stw 0,84(1)
	lis 9,game@ha
	li 29,0
	la 9,game@l(9)
	mr 28,3
	lwz 0,1544(9)
	lis 22,g_edicts@ha
	cmpw 0,29,0
	bc 4,0,.L42
	mr 25,9
	li 26,32
	li 27,21
	lis 30,vec3_origin@ha
	li 31,1084
.L44:
	lwz 0,g_edicts@l(22)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L43
	la 6,vec3_origin@l(30)
	lis 9,0x1
	stw 26,8(1)
	stw 27,12(1)
	mr 4,28
	mr 5,28
	addi 7,28,4
	mr 8,6
	ori 9,9,34464
	li 10,0
	bl T_Damage
.L43:
	lwz 0,1544(25)
	addi 29,29,1
	addi 31,31,1084
	cmpw 0,29,0
	bc 12,0,.L44
.L42:
	lis 9,globals@ha
	lis 11,g_edicts@ha
	la 10,globals@l(9)
	lwz 31,g_edicts@l(11)
	lwz 0,72(10)
	mulli 0,0,1084
	add 0,31,0
	cmplw 0,31,0
	bc 4,0,.L48
	lis 9,game@ha
	mr 19,10
	la 20,game@l(9)
	lis 21,game@ha
.L50:
	lwz 0,88(31)
	addi 23,31,1084
	cmpwi 0,0,0
	bc 12,2,.L49
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L49
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L49
	lwz 0,1544(20)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L49
	li 25,32
	li 24,21
	lis 26,vec3_origin@ha
	la 27,game@l(21)
	li 30,1084
.L57:
	lwz 0,g_edicts@l(22)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L56
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L56
	lwz 9,480(31)
	mr 3,31
	la 6,vec3_origin@l(26)
	stw 25,8(1)
	mr 4,28
	mr 5,28
	stw 24,12(1)
	addi 7,3,4
	mr 8,6
	li 10,0
	bl T_Damage
	b .L49
.L56:
	lwz 0,1544(27)
	addi 29,29,1
	addi 30,30,1084
	cmpw 0,29,0
	bc 12,0,.L57
.L49:
	lwz 9,72(19)
	mr 31,23
	lwz 0,g_edicts@l(22)
	mulli 9,9,1084
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L50
.L48:
	lwz 0,84(1)
	mtlr 0
	lmw 19,28(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 target_killplayers_use,.Lfe3-target_killplayers_use
	.section	".rodata"
	.align 2
.LC16:
	.string	"models/items/spawngro2/tris.md2"
	.align 2
.LC20:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SP_target_steam
	.type	 SP_target_steam,@function
SP_target_steam:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lfs 0,328(3)
	lwz 0,296(3)
	cmpwi 0,0,0
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,1032(3)
	bc 12,2,.L23
	lis 9,target_steam_start@ha
	lis 10,.LC20@ha
	la 9,target_steam_start@l(9)
	lis 11,level+4@ha
	la 10,.LC20@l(10)
	stw 9,436(3)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(3)
	b .L24
.L23:
	bl target_steam_start
.L24:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 SP_target_steam,.Lfe4-SP_target_steam
	.align 2
	.globl target_anger_use
	.type	 target_anger_use,@function
target_anger_use:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,gi@ha
	mr 29,3
	la 28,gi@l(9)
	lis 3,.LC9@ha
	lwz 9,4(28)
	la 3,.LC9@l(3)
	li 31,0
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 5,304(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 12,2,.L25
	lwz 0,296(29)
	cmpwi 0,0,0
	bc 12,2,.L25
	lwz 9,776(30)
	li 11,300
	lis 3,.LC10@ha
	lwz 0,184(30)
	la 3,.LC10@l(3)
	mr 27,28
	ori 9,9,256
	stw 11,480(30)
	lis 25,.LC11@ha
	ori 0,0,4
	stw 9,776(30)
	lis 26,.LC12@ha
	stw 0,184(30)
	lwz 0,4(28)
	lwz 4,280(30)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L27
.L29:
	cmpw 0,31,29
	bc 4,2,.L30
	lwz 9,4(27)
	la 3,.LC11@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L31
.L30:
	lwz 0,448(31)
	cmpwi 0,0,0
	bc 12,2,.L31
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,0,.L25
	lwz 0,776(31)
	stw 30,540(31)
	oris 9,0,0x2
	stw 9,776(31)
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L34
	ori 0,9,512
	stw 0,776(31)
.L34:
	mr 3,31
	bl FoundTarget
.L31:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 4,2,.L27
	lwz 0,4(27)
	la 3,.LC12@l(26)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L25
.L27:
	lwz 5,296(29)
	mr 3,31
	li 4,300
	bl G_Find
	mr. 31,3
	bc 4,2,.L29
.L25:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 target_anger_use,.Lfe5-target_anger_use
	.align 2
	.globl SP_target_anger
	.type	 SP_target_anger,@function
SP_target_anger:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L38
	lis 9,gi+4@ha
	lis 3,.LC13@ha
	lwz 0,gi+4@l(9)
	la 3,.LC13@l(3)
	b .L69
.L38:
	lwz 0,304(31)
	cmpwi 0,0,0
	bc 4,2,.L39
	lis 9,gi+4@ha
	lis 3,.LC14@ha
	lwz 0,gi+4@l(9)
	la 3,.LC14@l(3)
.L69:
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L37
.L39:
	lis 9,target_anger_use@ha
	li 0,1
	la 9,target_anger_use@l(9)
	stw 0,184(31)
	stw 9,448(31)
.L37:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 SP_target_anger,.Lfe6-SP_target_anger
	.align 2
	.globl SP_target_killplayers
	.type	 SP_target_killplayers,@function
SP_target_killplayers:
	lis 9,target_killplayers_use@ha
	li 0,1
	la 9,target_killplayers_use@l(9)
	stw 0,184(3)
	stw 9,448(3)
	blr
.Lfe7:
	.size	 SP_target_killplayers,.Lfe7-SP_target_killplayers
	.section	".rodata"
	.align 3
.LC21:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl blacklight_think
	.type	 blacklight_think,@function
blacklight_think:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 27,3
	lis 29,0xb60b
	bl rand
	ori 29,29,24759
	lis 28,0x4330
	mulhw 0,3,29
	srawi 11,3,31
	lis 10,.LC22@ha
	add 0,0,3
	la 10,.LC22@l(10)
	srawi 0,0,8
	lfd 31,0(10)
	subf 0,11,0
	mulli 0,0,360
	subf 3,0,3
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,16(27)
	bl rand
	mulhw 0,3,29
	srawi 11,3,31
	add 0,0,3
	srawi 0,0,8
	subf 0,11,0
	mulli 0,0,360
	subf 3,0,3
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,20(27)
	bl rand
	mulhw 29,3,29
	srawi 0,3,31
	lis 10,level+4@ha
	lis 9,.LC21@ha
	add 29,29,3
	lfd 12,.LC21@l(9)
	srawi 29,29,8
	subf 29,0,29
	mulli 29,29,360
	subf 3,29,3
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 13,24(1)
	fsub 13,13,31
	frsp 13,13
	stfs 13,24(27)
	lfs 0,level+4@l(10)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(27)
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 blacklight_think,.Lfe8-blacklight_think
	.section	".rodata"
	.align 3
.LC23:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_blacklight
	.type	 SP_target_blacklight,@function
SP_target_blacklight:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC24@ha
	lis 9,deathmatch@ha
	la 11,.LC24@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L65
	bl G_FreeEdict
	b .L64
.L65:
	lwz 0,64(31)
	lis 9,blacklight_think@ha
	lis 29,gi@ha
	la 9,blacklight_think@l(9)
	la 29,gi@l(29)
	stfs 13,200(31)
	oris 0,0,0x8400
	stfs 13,196(31)
	lis 3,.LC16@ha
	stw 0,64(31)
	la 3,.LC16@l(3)
	stfs 13,192(31)
	stfs 13,188(31)
	stfs 13,208(31)
	stfs 13,204(31)
	stw 9,436(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	li 0,1
	stw 3,40(31)
	lis 11,level+4@ha
	stw 0,56(31)
	lis 9,.LC23@ha
	mr 3,31
	lfs 0,level+4@l(11)
	lfd 13,.LC23@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L64:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 SP_target_blacklight,.Lfe9-SP_target_blacklight
	.section	".rodata"
	.align 3
.LC25:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl orb_think
	.type	 orb_think,@function
orb_think:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 27,3
	lis 29,0xb60b
	bl rand
	ori 29,29,24759
	lis 28,0x4330
	mulhw 0,3,29
	srawi 11,3,31
	lis 10,.LC26@ha
	add 0,0,3
	la 10,.LC26@l(10)
	srawi 0,0,8
	lfd 31,0(10)
	subf 0,11,0
	mulli 0,0,360
	subf 3,0,3
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,16(27)
	bl rand
	mulhw 0,3,29
	srawi 11,3,31
	add 0,0,3
	srawi 0,0,8
	subf 0,11,0
	mulli 0,0,360
	subf 3,0,3
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,20(27)
	bl rand
	mulhw 29,3,29
	srawi 0,3,31
	lis 10,level+4@ha
	lis 9,.LC25@ha
	add 29,29,3
	lfd 12,.LC25@l(9)
	srawi 29,29,8
	subf 29,0,29
	mulli 29,29,360
	subf 3,29,3
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 13,24(1)
	fsub 13,13,31
	frsp 13,13
	stfs 13,24(27)
	lfs 0,level+4@l(10)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(27)
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 orb_think,.Lfe10-orb_think
	.section	".rodata"
	.align 3
.LC27:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC28:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_orb
	.type	 SP_target_orb,@function
SP_target_orb:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC28@ha
	lis 9,deathmatch@ha
	la 11,.LC28@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L68
	bl G_FreeEdict
	b .L67
.L68:
	lis 9,orb_think@ha
	stfs 13,200(31)
	lis 10,level+4@ha
	la 9,orb_think@l(9)
	stfs 13,196(31)
	lis 11,.LC27@ha
	stfs 13,192(31)
	lis 29,gi@ha
	lis 3,.LC16@ha
	stfs 13,188(31)
	la 29,gi@l(29)
	la 3,.LC16@l(3)
	stfs 13,208(31)
	stfs 13,204(31)
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC27@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 0,64(31)
	li 9,2
	stw 3,40(31)
	oris 0,0,0x1000
	stw 9,56(31)
	mr 3,31
	stw 0,64(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L67:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 SP_target_orb,.Lfe11-SP_target_orb
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
