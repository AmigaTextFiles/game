	.file	"dooments.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC2:
	.long 0x402e0000
	.long 0x0
	.align 2
.LC3:
	.long 0x437a0000
	.align 3
.LC4:
	.long 0x40340000
	.long 0x0
	.align 2
.LC5:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl DoomSpawn_think
	.type	 DoomSpawn_think,@function
DoomSpawn_think:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 8,.LC1@ha
	lis 10,.LC0@ha
	stw 0,8(1)
	la 8,.LC1@l(8)
	lis 9,.LC2@ha
	lfd 13,0(8)
	la 9,.LC2@l(9)
	li 3,0
	lfd 0,8(1)
	lfs 11,.LC0@l(10)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fmul 13,13,10
	fctiwz 12,13
	stfd 12,8(1)
	lwz 9,12(1)
	addi 30,9,1
	b .L15
.L17:
	lwz 0,884(3)
	cmpwi 0,0,0
	bc 12,2,.L18
	lwz 0,576(3)
	cmpwi 0,0,0
	li 0,0
	bc 12,1,.L19
.L18:
	lwz 0,292(3)
	cmpwi 0,0,0
	bc 4,1,.L15
	lwz 0,576(3)
	cmpwi 0,0,0
	bc 4,1,.L15
	li 0,0
	b .L19
.L15:
	lis 8,.LC3@ha
	addi 4,28,4
	la 8,.LC3@l(8)
	lfs 1,0(8)
	bl findradius
	mr. 3,3
	bc 4,2,.L17
	li 0,1
.L19:
	cmpwi 0,0,0
	bc 12,2,.L14
	bl G_Spawn
	lfs 13,4(28)
	mr 31,3
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,1
	stfs 13,4(31)
	lfs 0,8(28)
	stfs 0,8(31)
	lfs 13,12(28)
	stfs 13,12(31)
	lfs 0,16(28)
	stfs 0,16(31)
	lfs 13,20(28)
	stfs 13,20(31)
	lfs 0,24(28)
	stfs 0,24(31)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbdef
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,31711
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	cmpwi 0,30,1
	bc 4,2,.L22
	mr 3,31
	bl SP_monster_berserk
.L22:
	cmpwi 0,30,2
	bc 4,2,.L23
	mr 3,31
	bl SP_monster_brain
.L23:
	cmpwi 0,30,3
	bc 4,2,.L24
	mr 3,31
	bl SP_monster_chick
.L24:
	cmpwi 0,30,4
	bc 4,2,.L25
	mr 3,31
	bl SP_monster_floater
.L25:
	cmpwi 0,30,5
	bc 4,2,.L26
	mr 3,31
	bl SP_monster_flyer
.L26:
	cmpwi 0,30,6
	bc 4,2,.L27
	mr 3,31
	bl SP_monster_gladiator
.L27:
	cmpwi 0,30,7
	bc 4,2,.L28
	mr 3,31
	bl SP_monster_gunner
.L28:
	cmpwi 0,30,8
	bc 4,2,.L29
	mr 3,31
	bl SP_monster_hover
.L29:
	cmpwi 0,30,9
	bc 4,2,.L30
	mr 3,31
	bl SP_monster_infantry
.L30:
	cmpwi 0,30,10
	bc 4,2,.L31
	mr 3,31
	bl SP_monster_soldier_ss
.L31:
	cmpwi 0,30,11
	bc 4,2,.L32
	mr 3,31
	bl SP_monster_parasite
.L32:
	cmpwi 0,30,12
	bc 4,2,.L33
	mr 3,31
	bl SP_monster_soldier_light
.L33:
	cmpwi 0,30,13
	bc 4,2,.L34
	mr 3,31
	bl SP_monster_soldier
.L34:
	cmpwi 0,30,14
	bc 4,2,.L35
	mr 3,31
	bl SP_monster_soldier_ss
.L35:
	cmpwi 0,30,15
	bc 4,2,.L14
	mr 3,31
	bl SP_monster_tank
.L14:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 8,.LC1@ha
	lis 9,.LC4@ha
	stw 0,8(1)
	la 8,.LC1@l(8)
	la 9,.LC4@l(9)
	lfd 8,0(8)
	mr 10,11
	lfd 13,8(1)
	lis 8,.LC0@ha
	lfs 10,.LC0@l(8)
	lfd 9,0(9)
	lis 8,.LC5@ha
	fsub 13,13,8
	mr 9,11
	la 8,.LC5@l(8)
	lis 11,level+4@ha
	lfs 0,0(8)
	lfs 11,level+4@l(11)
	frsp 13,13
	fadds 11,11,0
	fdivs 13,13,10
	fmr 0,13
	fmul 0,0,9
	fctiwz 12,0
	stfd 12,8(1)
	lwz 9,12(1)
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 0,8(1)
	fsub 0,0,8
	frsp 0,0
	fadds 11,11,0
	stfs 11,524(28)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 DoomSpawn_think,.Lfe1-DoomSpawn_think
	.section	".rodata"
	.align 2
.LC6:
	.long 0x46fffe00
	.align 3
.LC7:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC9:
	.long 0x402e0000
	.long 0x0
	.align 2
.LC10:
	.long 0x437a0000
	.align 2
.LC11:
	.long 0x42800000
	.align 3
.LC12:
	.long 0x40340000
	.long 0x0
	.align 2
.LC13:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl DoomSpawngl_think
	.type	 DoomSpawngl_think,@function
DoomSpawngl_think:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,336(28)
	xoris 3,3,0x8000
	lis 7,0x4330
	stw 3,12(1)
	lis 10,.LC8@ha
	lis 8,.LC6@ha
	stw 7,8(1)
	la 10,.LC8@l(10)
	lis 11,.LC9@ha
	lfd 9,0(10)
	la 11,.LC9@l(11)
	xoris 0,0,0x8000
	lfd 13,8(1)
	mr 10,9
	lfs 11,.LC6@l(8)
	lfd 10,0(11)
	fsub 13,13,9
	mr 11,9
	lis 9,level+4@ha
	lfs 8,level+4@l(9)
	frsp 13,13
	fdivs 13,13,11
	fmr 0,13
	fmul 0,0,10
	fctiwz 12,0
	stfd 12,8(1)
	lwz 11,12(1)
	stw 0,12(1)
	stw 7,8(1)
	addi 30,11,1
	lfd 0,8(1)
	fsub 0,0,9
	frsp 0,0
	fcmpu 0,0,8
	bc 4,0,.L39
	li 3,0
	addi 31,28,4
	b .L41
.L43:
	lwz 0,884(3)
	cmpwi 0,0,0
	bc 12,2,.L44
	lwz 0,576(3)
	cmpwi 0,0,0
	li 0,0
	bc 12,1,.L45
.L44:
	lwz 0,292(3)
	cmpwi 0,0,0
	bc 4,1,.L41
	lwz 0,576(3)
	cmpwi 0,0,0
	bc 4,1,.L41
	li 0,0
	b .L45
.L41:
	lis 9,.LC10@ha
	mr 4,31
	la 9,.LC10@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 3,3
	bc 4,2,.L43
	li 0,1
.L45:
	cmpwi 0,0,0
	bc 12,2,.L40
	bl G_Spawn
	lfs 13,4(28)
	mr 31,3
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,1
	stfs 13,4(31)
	lfs 0,8(28)
	stfs 0,8(31)
	lfs 13,12(28)
	stfs 13,12(31)
	lfs 0,16(28)
	stfs 0,16(31)
	lfs 13,20(28)
	stfs 13,20(31)
	lfs 0,24(28)
	stfs 0,24(31)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbdef
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,31711
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	lis 9,.LC11@ha
	lfs 0,12(28)
	cmpwi 0,30,1
	la 9,.LC11@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(31)
	bc 4,2,.L48
	mr 3,31
	bl SP_monster_berserk
.L48:
	cmpwi 0,30,2
	bc 4,2,.L49
	mr 3,31
	bl SP_monster_brain
.L49:
	cmpwi 0,30,3
	bc 4,2,.L50
	mr 3,31
	bl SP_monster_chick
.L50:
	cmpwi 0,30,4
	bc 4,2,.L51
	mr 3,31
	bl SP_monster_floater
.L51:
	cmpwi 0,30,5
	bc 4,2,.L52
	mr 3,31
	bl SP_monster_flyer
.L52:
	cmpwi 0,30,6
	bc 4,2,.L53
	mr 3,31
	bl SP_monster_gladiator
.L53:
	cmpwi 0,30,7
	bc 4,2,.L54
	mr 3,31
	bl SP_monster_gunner
.L54:
	cmpwi 0,30,8
	bc 4,2,.L55
	mr 3,31
	bl SP_monster_hover
.L55:
	cmpwi 0,30,9
	bc 4,2,.L56
	mr 3,31
	bl SP_monster_infantry
.L56:
	cmpwi 0,30,10
	bc 4,2,.L57
	mr 3,31
	bl SP_monster_soldier_ss
.L57:
	cmpwi 0,30,11
	bc 4,2,.L58
	mr 3,31
	bl SP_monster_parasite
.L58:
	cmpwi 0,30,12
	bc 4,2,.L59
	mr 3,31
	bl SP_monster_soldier_light
.L59:
	cmpwi 0,30,13
	bc 4,2,.L60
	mr 3,31
	bl SP_monster_soldier
.L60:
	cmpwi 0,30,14
	bc 4,2,.L61
	mr 3,31
	bl SP_monster_soldier_ss
.L61:
	cmpwi 0,30,15
	bc 4,2,.L40
	mr 3,31
	bl SP_monster_tank
.L40:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 9,.LC8@ha
	lis 10,.LC6@ha
	stw 0,8(1)
	la 9,.LC8@l(9)
	mr 8,11
	lfd 7,0(9)
	lfd 13,8(1)
	lis 9,.LC12@ha
	lfs 8,.LC6@l(10)
	la 9,.LC12@l(9)
	lfd 9,0(9)
	lis 10,.LC13@ha
	fsub 13,13,7
	mr 9,11
	la 10,.LC13@l(10)
	lis 11,level+4@ha
	lfs 0,0(10)
	lfs 12,level+4@l(11)
	frsp 13,13
	fadds 12,12,0
	fdivs 13,13,8
	fmr 0,13
	fmul 0,0,9
	fctiwz 11,0
	stfd 11,8(1)
	lwz 9,12(1)
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 0,8(1)
	fsub 0,0,7
	frsp 0,0
	fadds 12,12,0
	fctiwz 10,12
	stfd 10,8(1)
	lwz 10,12(1)
	stw 10,336(28)
.L39:
	lis 9,level+4@ha
	lis 11,.LC7@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC7@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(28)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 DoomSpawngl_think,.Lfe2-DoomSpawngl_think
	.section	".rodata"
	.align 2
.LC15:
	.string	"models/objects/dmspot/tris.md2"
	.align 2
.LC16:
	.long 0x46fffe00
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC18:
	.long 0x40340000
	.long 0x0
	.align 2
.LC19:
	.long 0x41700000
	.align 2
.LC20:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl SP_func_DoomSpawngl
	.type	 SP_func_DoomSpawngl,@function
SP_func_DoomSpawngl:
	stwu 1,-96(1)
	mflr 0
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 24,32(1)
	stw 0,100(1)
	mr 28,3
	li 24,2
	bl G_Spawn
	lis 25,0x4330
	lis 9,.LC17@ha
	mr 29,3
	la 9,.LC17@l(9)
	addi 4,1,8
	lfd 31,0(9)
	li 6,0
	li 5,0
	lwz 9,84(28)
	addi 26,29,4
	addi 3,9,3636
	bl AngleVectors
	lis 9,.LC18@ha
	addi 4,1,8
	la 9,.LC18@l(9)
	mr 5,26
	lfd 29,0(9)
	addi 3,28,4
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 28,0(9)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 1,0(9)
	bl VectorMA
	lfs 13,16(28)
	lis 27,gi@ha
	li 3,1
	la 27,gi@l(27)
	stfs 13,16(29)
	lfs 0,24(28)
	stfs 0,24(29)
	lwz 9,100(27)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbdef
	lwz 10,104(27)
	lwz 3,g_edicts@l(9)
	ori 0,0,31711
	mtlr 10
	subf 3,3,29
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(27)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(27)
	li 4,2
	mr 3,26
	mtlr 9
	blrl
	lis 9,ds_die@ha
	lis 0,0x600
	stw 24,248(29)
	la 9,ds_die@l(9)
	lis 11,DoomSpawngl_think@ha
	stw 9,552(29)
	la 11,DoomSpawngl_think@l(11)
	li 10,7
	ori 0,0,3
	li 9,250
	stw 10,260(29)
	stw 11,532(29)
	lis 3,.LC15@ha
	stw 0,252(29)
	la 3,.LC15@l(3)
	stw 9,576(29)
	lwz 9,32(27)
	mtlr 9
	blrl
	lwz 0,64(29)
	li 9,1
	stw 9,60(29)
	oris 0,0,0x2
	stw 3,40(29)
	stw 0,64(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC16@ha
	stw 3,28(1)
	mr 11,9
	mr 10,9
	stw 25,24(1)
	lis 28,level@ha
	lis 0,0xc1c0
	lfd 13,24(1)
	la 28,level@l(28)
	lis 7,0x41c0
	lfs 30,.LC16@l(8)
	lis 9,0xc180
	lfs 11,4(28)
	li 8,1000
	fsub 13,13,31
	stw 0,196(29)
	stw 9,208(29)
	fadds 11,11,28
	stw 8,496(29)
	frsp 13,13
	stw 0,188(29)
	stw 0,192(29)
	stw 7,204(29)
	fdivs 13,13,30
	stw 24,608(29)
	stw 7,200(29)
	fmr 0,13
	fmul 0,0,29
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	xoris 11,11,0x8000
	stw 11,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fadds 11,11,0
	stfs 11,524(29)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(28)
	xoris 3,3,0x8000
	mr 9,11
	stw 3,28(1)
	mr 10,11
	mr 8,11
	stw 25,24(1)
	fadds 12,12,28
	mr 3,29
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fmul 13,13,29
	fctiwz 11,13
	stfd 11,24(1)
	lwz 9,28(1)
	xoris 9,9,0x8000
	stw 9,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fadds 12,12,0
	fctiwz 10,12
	stfd 10,24(1)
	lwz 8,28(1)
	stw 8,336(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 24,32(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe3:
	.size	 SP_func_DoomSpawngl,.Lfe3-SP_func_DoomSpawngl
	.section	".rodata"
	.align 2
.LC21:
	.long 0x46fffe00
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC23:
	.long 0x40340000
	.long 0x0
	.align 2
.LC24:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl SP_func_DoomSpawn
	.type	 SP_func_DoomSpawn,@function
SP_func_DoomSpawn:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,DoomSpawn_think@ha
	mr 29,3
	li 0,0
	la 9,DoomSpawn_think@l(9)
	stw 0,248(29)
	stw 9,532(29)
	stw 0,260(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 8,.LC22@ha
	lis 11,.LC23@ha
	stw 0,24(1)
	la 8,.LC22@l(8)
	la 11,.LC23@l(11)
	lfd 8,0(8)
	mr 10,9
	mr 3,29
	lfd 13,24(1)
	lis 8,.LC21@ha
	lfs 9,.LC21@l(8)
	lfd 10,0(11)
	lis 8,.LC24@ha
	fsub 13,13,8
	mr 11,9
	la 8,.LC24@l(8)
	lis 9,level+4@ha
	lfs 0,0(8)
	lfs 12,level+4@l(9)
	lis 8,gi+72@ha
	frsp 13,13
	fadds 12,12,0
	fdivs 13,13,9
	fmr 0,13
	fmul 0,0,10
	fctiwz 11,0
	stfd 11,24(1)
	lwz 11,28(1)
	xoris 11,11,0x8000
	stw 11,28(1)
	stw 0,24(1)
	lfd 0,24(1)
	fsub 0,0,8
	frsp 0,0
	fadds 12,12,0
	stfs 12,524(29)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 SP_func_DoomSpawn,.Lfe4-SP_func_DoomSpawn
	.comm	maplist,292,4
	.section	".rodata"
	.align 2
.LC25:
	.long 0x437a0000
	.section	".text"
	.align 2
	.globl CheckDoomRadius
	.type	 CheckDoomRadius,@function
CheckDoomRadius:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 9,0
	b .L7
.L9:
	lwz 0,884(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	lwz 0,576(9)
	cmpwi 0,0,0
	bc 4,1,.L10
	li 3,0
	b .L65
.L10:
	lwz 0,292(9)
	cmpwi 0,0,0
	bc 4,1,.L7
	lwz 0,576(9)
	li 3,0
	cmpwi 0,0,0
	bc 12,1,.L65
.L7:
	mr 3,9
	addi 4,31,4
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 9,3
	bc 4,2,.L9
	li 3,1
.L65:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 CheckDoomRadius,.Lfe5-CheckDoomRadius
	.align 2
	.globl ds_die
	.type	 ds_die,@function
ds_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 ds_die,.Lfe6-ds_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
