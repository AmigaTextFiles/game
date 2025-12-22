	.file	"a_items.c"
gcc2_compiled.:
	.globl tnames
	.section	".data"
	.align 2
	.type	 tnames,@object
tnames:
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long 0
	.section	".rodata"
	.align 2
.LC4:
	.string	"item_lasersight"
	.align 2
.LC3:
	.string	"item_band"
	.align 2
.LC2:
	.string	"item_vest"
	.align 2
.LC1:
	.string	"item_slippers"
	.align 2
.LC0:
	.string	"item_quiet"
	.size	 tnames,24
	.align 2
.LC5:
	.string	"info_player_deathmatch"
	.align 2
.LC6:
	.string	"Lasersight"
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x42c80000
	.align 2
.LC9:
	.long 0x41800000
	.align 2
.LC10:
	.long 0x42700000
	.section	".text"
	.align 2
	.type	 SpawnSpec,@function
SpawnSpec:
	stwu 1,-96(1)
	mflr 0
	stmw 27,76(1)
	stw 0,100(1)
	mr 29,3
	mr 27,4
	bl G_Spawn
	lis 28,0xc170
	lis 30,0x4170
	lwz 9,0(29)
	mr 31,3
	lis 0,0x1
	stw 0,284(31)
	li 11,512
	lis 4,.LC6@ha
	stw 9,280(31)
	la 4,.LC6@l(4)
	stw 29,648(31)
	lwz 0,28(29)
	stw 11,68(31)
	stw 0,64(31)
	stw 28,188(31)
	stw 28,192(31)
	stw 28,196(31)
	stw 30,200(31)
	stw 30,204(31)
	stw 30,208(31)
	lwz 3,40(29)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L14
	lis 0,0xbf80
	lis 9,0x3f80
	stw 28,192(31)
	stw 0,196(31)
	stw 30,204(31)
	stw 9,208(31)
	stw 28,188(31)
	stw 30,200(31)
.L14:
	lwz 9,648(31)
	lis 28,gi@ha
	mr 3,31
	la 28,gi@l(28)
	li 29,0
	lwz 4,24(9)
	lwz 9,44(28)
	mtlr 9
	blrl
	lis 9,Touch_Item@ha
	li 11,1
	stw 31,256(31)
	la 9,Touch_Item@l(9)
	li 0,7
	stw 11,248(31)
	stw 0,260(31)
	stw 9,444(31)
	stw 29,40(1)
	bl rand
	lis 0,0xb60b
	mr 9,3
	stw 29,48(1)
	ori 0,0,24759
	srawi 10,9,31
	mulhw 0,9,0
	lis 8,0x4330
	lis 7,.LC7@ha
	addi 3,1,40
	add 0,0,9
	la 7,.LC7@l(7)
	srawi 0,0,8
	lfd 13,0(7)
	addi 4,1,8
	subf 0,10,0
	addi 5,1,24
	mulli 0,0,360
	li 6,0
	subf 9,0,9
	xoris 9,9,0x8000
	stw 9,68(1)
	stw 8,64(1)
	lfd 0,64(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,44(1)
	bl AngleVectors
	lfs 0,4(27)
	lis 9,.LC9@ha
	lis 7,.LC8@ha
	la 9,.LC9@l(9)
	la 7,.LC8@l(7)
	lfs 12,0(9)
	addi 3,1,8
	addi 4,31,376
	stfs 0,4(31)
	lfs 13,8(27)
	lfs 1,0(7)
	stfs 13,8(31)
	lfs 0,12(27)
	fadds 0,0,12
	stfs 0,12(31)
	bl VectorScale
	lis 0,0x4396
	lis 7,.LC10@ha
	stw 0,384(31)
	lis 11,level+4@ha
	la 7,.LC10@l(7)
	lfs 0,level+4@l(11)
	lis 9,SpecThink@ha
	mr 3,31
	lfs 13,0(7)
	la 9,SpecThink@l(9)
	stw 9,436(31)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 27,76(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SpawnSpec,.Lfe1-SpawnSpec
	.section	".rodata"
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC12:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl DeadDropSpec
	.type	 DeadDropSpec,@function
DeadDropSpec:
	stwu 1,-96(1)
	mflr 0
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 21,36(1)
	stw 0,100(1)
	lis 9,tnames@ha
	mr 28,3
	la 3,tnames@l(9)
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L46
	lis 9,itemlist@ha
	lis 30,0x1b4e
	la 21,itemlist@l(9)
	lis 11,level@ha
	lis 9,MakeTouchSpecThink@ha
	lis 27,0x38e3
	la 23,MakeTouchSpecThink@l(9)
	la 22,level@l(11)
	lis 9,.LC11@ha
	mr 24,3
	la 9,.LC11@l(9)
	ori 30,30,33205
	lfd 31,0(9)
	lis 25,0x4330
	li 26,0
	lis 9,.LC12@ha
	ori 27,27,36409
	la 9,.LC12@l(9)
	lfs 30,0(9)
.L47:
	lwz 3,0(24)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L48
	subf 0,21,3
	lwz 11,84(28)
	mullw 0,0,27
	addi 11,11,740
	srawi 0,0,3
	slwi 31,0,2
	lwzx 9,11,31
	cmpwi 0,9,0
	bc 12,2,.L48
	mr 4,3
	mr 3,28
	bl Drop_Item
	mr 29,3
	bl rand
	mulhw 0,3,30
	srawi 9,3,31
	srawi 0,0,6
	subf 0,9,0
	mulli 0,0,600
	subf 3,0,3
	addi 3,3,-300
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,376(29)
	bl rand
	mulhw 0,3,30
	srawi 9,3,31
	srawi 0,0,6
	subf 0,9,0
	mulli 0,0,600
	subf 3,0,3
	addi 3,3,-300
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,380(29)
	lfs 13,4(22)
	stw 26,256(29)
	stw 23,436(29)
	fadds 13,13,30
	stfs 13,428(29)
	lwz 9,84(28)
	addi 9,9,740
	stwx 26,9,31
.L48:
	lwzu 0,4(24)
	cmpwi 0,0,0
	bc 4,2,.L47
.L46:
	lwz 0,100(1)
	mtlr 0
	lmw 21,36(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 DeadDropSpec,.Lfe2-DeadDropSpec
	.section	".rodata"
	.align 2
.LC13:
	.long 0x40800000
	.section	".text"
	.align 2
	.globl SetupSpecSpawn
	.type	 SetupSpecSpawn,@function
SetupSpecSpawn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,level@ha
	la 31,level@l(9)
	lwz 0,304(31)
	cmpwi 0,0,0
	bc 4,2,.L59
	bl G_Spawn
	lis 9,.LC13@ha
	lfs 0,4(31)
	li 0,1
	la 9,.LC13@l(9)
	lfs 13,0(9)
	lis 9,SpawnSpecs@ha
	la 9,SpawnSpecs@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	stw 0,304(31)
.L59:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 SetupSpecSpawn,.Lfe3-SetupSpecSpawn
	.align 2
	.globl RespawnSpec
	.type	 RespawnSpec,@function
RespawnSpec:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 30,0
	bl rand
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L55
	lis 29,.LC5@ha
.L54:
	mr 3,30
	li 4,280
	la 5,.LC5@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L54
.L55:
	cmpwi 0,30,0
	bc 4,2,.L61
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L51
.L61:
	lwz 3,648(28)
	mr 4,30
	bl SpawnSpec
.L51:
	mr 3,28
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 RespawnSpec,.Lfe4-RespawnSpec
	.section	".rodata"
	.align 2
.LC14:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Drop_Spec
	.type	 Drop_Spec,@function
Drop_Spec:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	mr 29,4
	bl Drop_Item
	lis 9,.LC14@ha
	lis 11,level+4@ha
	la 9,.LC14@l(9)
	lfs 0,level+4@l(11)
	lis 0,0x38e3
	lfs 13,0(9)
	lis 11,MakeTouchSpecThink@ha
	ori 0,0,36409
	lis 9,itemlist@ha
	la 11,MakeTouchSpecThink@l(11)
	la 9,itemlist@l(9)
	stw 11,436(3)
	fadds 0,0,13
	subf 29,9,29
	mullw 29,29,0
	stfs 0,428(3)
	srawi 29,29,3
	lwz 11,84(28)
	slwi 29,29,2
	addi 11,11,740
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Drop_Spec,.Lfe5-Drop_Spec
	.section	".rodata"
	.align 2
.LC15:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl SpecThink
	.type	 SpecThink,@function
SpecThink:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 30,0
	bl rand
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L33
	lis 28,.LC5@ha
.L32:
	mr 3,30
	li 4,280
	la 5,.LC5@l(28)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L32
.L33:
	cmpwi 0,30,0
	bc 4,2,.L62
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L29
.L62:
	lwz 3,648(29)
	mr 4,30
	bl SpawnSpec
	mr 3,29
	bl G_FreeEdict
	b .L37
.L29:
	lis 9,.LC15@ha
	lis 11,level+4@ha
	la 9,.LC15@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,SpecThink@ha
	la 9,SpecThink@l(9)
	fadds 0,0,13
	stw 9,436(29)
	stfs 0,428(29)
.L37:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SpecThink,.Lfe6-SpecThink
	.align 2
	.globl SpawnSpecs
	.type	 SpawnSpecs,@function
SpawnSpecs:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,tnames@ha
	li 31,0
	la 9,tnames@l(9)
	lwzx 0,9,31
	cmpwi 0,0,0
	bc 12,2,.L17
	mr 26,9
	lis 25,.LC5@ha
.L18:
	slwi 0,31,2
	addi 27,31,1
	lwzx 3,26,0
	bl FindItemByClassname
	mr. 28,3
	bc 12,2,.L19
	bl rand
	li 30,0
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L23
	lis 29,.LC5@ha
.L22:
	mr 3,30
	li 4,280
	la 5,.LC5@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L22
.L23:
	cmpwi 0,30,0
	bc 4,2,.L63
	li 3,0
	li 4,280
	la 5,.LC5@l(25)
	bl G_Find
	mr. 30,3
	bc 12,2,.L19
.L63:
	mr 3,28
	mr 4,30
	bl SpawnSpec
.L19:
	mr 31,27
	slwi 0,31,2
	lwzx 9,26,0
	cmpwi 0,9,0
	bc 4,2,.L18
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 SpawnSpecs,.Lfe7-SpawnSpecs
	.section	".rodata"
	.align 2
.LC16:
	.long 0x0
	.align 2
.LC17:
	.long 0x42700000
	.align 2
.LC18:
	.long 0x3f800000
	.section	".text"
	.align 2
	.type	 MakeTouchSpecThink,@function
MakeTouchSpecThink:
	lis 9,Touch_Item@ha
	lis 11,deathmatch@ha
	la 9,Touch_Item@l(9)
	lwz 10,deathmatch@l(11)
	stw 9,444(3)
	lis 9,.LC16@ha
	lfs 0,20(10)
	la 9,.LC16@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L39
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L39
	lis 9,allitem@ha
	lwz 11,allitem@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L39
	lis 11,.LC17@ha
	lis 9,level+4@ha
	la 11,.LC17@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 12,0(9)
	fadds 0,0,13
	lis 9,SpecThink@ha
	la 9,SpecThink@l(9)
	stw 9,436(3)
	fsubs 0,0,12
	stfs 0,428(3)
	blr
.L39:
	lis 11,.LC16@ha
	lis 9,teamplay@ha
	la 11,.LC16@l(11)
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L41
	lis 9,allitem@ha
	lwz 11,allitem@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L41
	lis 9,.LC17@ha
	lis 11,level+4@ha
	la 9,.LC17@l(9)
.L64:
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	blr
.L41:
	lis 9,.LC18@ha
	lis 11,level+4@ha
	la 9,.LC18@l(9)
	b .L64
.Lfe8:
	.size	 MakeTouchSpecThink,.Lfe8-MakeTouchSpecThink
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
