	.file	"s_spells.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Cells"
	.align 2
.LC1:
	.string	"items/protect4.wav"
	.align 2
.LC2:
	.long 0x3f800000
	.align 2
.LC3:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cell_VicThink
	.type	 Cell_VicThink,@function
Cell_VicThink:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,256(30)
	lwz 0,892(9)
	xori 10,0,2
	xori 0,0,9
	addic 9,0,-1
	subfe 11,9,0
	addic 0,10,-1
	subfe 9,0,10
	and. 0,11,9
	bc 12,2,.L7
	bl G_FreeEdict
	b .L6
.L7:
	lis 26,.LC0@ha
	lwz 29,84(30)
	lis 28,0x286b
	la 3,.LC0@l(26)
	ori 28,28,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,28
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,100
	bc 12,2,.L13
	lwz 3,256(30)
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L15
	lwz 3,256(30)
	bl G_ClientNotDead
	cmpwi 0,3,0
	bc 4,2,.L10
.L15:
	mr 3,30
	bl G_FreeEdict
	b .L6
.L10:
	lwz 31,256(30)
	lwz 0,892(31)
	cmpwi 0,0,9
	bc 4,2,.L11
	lwz 0,908(31)
	andi. 9,0,32
	bc 4,2,.L14
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC2@ha
	lwz 0,16(29)
	lis 11,.LC2@ha
	la 9,.LC2@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC2@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC3@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC3@l(9)
	lfs 3,0(9)
	blrl
.L11:
	lwz 9,256(30)
	lwz 0,908(9)
	andi. 9,0,32
	bc 12,2,.L12
.L14:
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	b .L16
.L12:
	la 3,.LC0@l(26)
	bl FindItem
	subf 3,27,3
	lwz 11,84(30)
	mullw 3,3,28
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,1
.L16:
	stwx 9,11,3
.L13:
	lis 11,.LC2@ha
	lis 9,level+4@ha
	la 11,.LC2@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(30)
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Cell_VicThink,.Lfe1-Cell_VicThink
	.section	".rodata"
	.align 2
.LC4:
	.string	"You don't have enough experience\n"
	.align 2
.LC5:
	.string	"Not enough mana for spell\n"
	.align 2
.LC6:
	.string	"earthquake"
	.align 2
.LC8:
	.string	"world/quake.wav"
	.align 3
.LC7:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC9:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Spawn_eq
	.type	 Spawn_eq,@function
Spawn_eq:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,892(31)
	cmpwi 0,0,2
	bc 12,2,.L23
	lwz 9,84(31)
	lwz 0,1872(9)
	cmpwi 0,0,2
	bc 4,2,.L22
.L23:
	lis 27,.LC0@ha
	lwz 29,84(31)
	lis 28,0x286b
	la 3,.LC0@l(27)
	ori 28,28,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 30,itemlist@l(9)
	subf 3,30,3
	mullw 3,3,28
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,74
	bc 12,1,.L24
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC5@l(5)
	b .L26
.L24:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,49
	bc 12,1,.L25
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
.L26:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L22
.L25:
	la 3,.LC0@l(27)
	bl FindItem
	subf 3,30,3
	lwz 11,84(31)
	mullw 3,3,28
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-75
	stwx 9,11,3
	bl G_Spawn
	lis 9,.LC6@ha
	mr 29,3
	la 9,.LC6@l(9)
	lis 11,level@ha
	stw 9,280(29)
	la 11,level@l(11)
	li 0,0
	lis 9,.LC9@ha
	lfs 13,4(11)
	lis 10,.LC7@ha
	la 9,.LC9@l(9)
	stw 0,476(29)
	lis 28,gi@ha
	lfs 0,0(9)
	lis 0,0x442f
	la 28,gi@l(28)
	lis 9,target_earthquake_think@ha
	stw 31,256(29)
	lis 3,.LC8@ha
	la 9,target_earthquake_think@l(9)
	stw 31,548(29)
	la 3,.LC8@l(3)
	fadds 13,13,0
	stw 9,436(29)
	stfs 13,288(29)
	lfs 0,4(11)
	lfd 13,.LC7@l(10)
	stw 0,328(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	stw 3,576(29)
	lfs 13,4(31)
	mr 3,29
	stfs 13,4(29)
	lfs 0,8(31)
	stfs 0,8(29)
	lfs 13,12(31)
	stfs 13,12(29)
	lwz 0,72(28)
	mtlr 0
	blrl
.L22:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Spawn_eq,.Lfe2-Spawn_eq
	.section	".rodata"
	.align 2
.LC10:
	.string	"Not enough cells for spell\n"
	.align 2
.LC11:
	.string	"cells"
	.align 2
.LC12:
	.string	"weapons/slash1.wav"
	.align 2
.LC13:
	.string	"weapons/attack2.wav"
	.align 2
.LC14:
	.long 0x40000000
	.align 2
.LC15:
	.long 0x3f800000
	.align 2
.LC16:
	.long 0x0
	.align 2
.LC17:
	.long 0x43af0000
	.align 2
.LC18:
	.long 0xc4480000
	.section	".text"
	.align 2
	.globl MageJump1
	.type	 MageJump1,@function
MageJump1:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,892(31)
	cmpwi 0,0,2
	bc 12,2,.L28
	lwz 9,84(31)
	lwz 0,1872(9)
	cmpwi 0,0,2
	bc 4,2,.L27
.L28:
	lis 3,.LC0@ha
	lwz 29,84(31)
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,1
	bc 12,1,.L29
	lis 9,gi+8@ha
	lis 5,.LC10@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC10@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L27
.L29:
	lis 9,.LC14@ha
	lis 4,.LC11@ha
	la 9,.LC14@l(9)
	la 4,.LC11@l(4)
	lfs 1,0(9)
	mr 3,31
	bl LessAmmo
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC15@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC15@l(9)
	li 4,4
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 2,0(9)
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	mtlr 9
	blrl
	lis 9,.LC15@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC15@l(9)
	mr 3,31
	lfs 1,0(9)
	li 4,1
	mtlr 0
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 2,0(9)
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC17@ha
	lfs 0,384(31)
	addi 4,1,8
	la 9,.LC17@l(9)
	lwz 3,84(31)
	li 5,0
	lfs 13,0(9)
	li 6,0
	addi 3,3,2124
	fadds 0,0,13
	stfs 0,384(31)
	bl AngleVectors
	lis 9,.LC18@ha
	addi 3,31,376
	la 9,.LC18@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
.L27:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 MageJump1,.Lfe3-MageJump1
	.section	".rodata"
	.align 2
.LC19:
	.long 0x40000000
	.align 2
.LC20:
	.long 0x3f800000
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0x43af0000
	.align 2
.LC23:
	.long 0x44480000
	.section	".text"
	.align 2
	.globl MageJump2
	.type	 MageJump2,@function
MageJump2:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,892(31)
	cmpwi 0,0,2
	bc 12,2,.L31
	lwz 9,84(31)
	lwz 0,1872(9)
	cmpwi 0,0,2
	bc 4,2,.L30
.L31:
	lis 3,.LC0@ha
	lwz 29,84(31)
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,1
	bc 12,1,.L32
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC5@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L30
.L32:
	lis 9,.LC19@ha
	lis 4,.LC11@ha
	la 9,.LC19@l(9)
	la 4,.LC11@l(4)
	lfs 1,0(9)
	mr 3,31
	bl LessAmmo
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC20@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC20@l(9)
	li 4,4
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	mtlr 9
	blrl
	lis 9,.LC20@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC20@l(9)
	mr 3,31
	lfs 1,0(9)
	li 4,1
	mtlr 0
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC22@ha
	lfs 0,384(31)
	addi 4,1,8
	la 9,.LC22@l(9)
	lwz 3,84(31)
	li 5,0
	lfs 13,0(9)
	li 6,0
	addi 3,3,2124
	fadds 0,0,13
	stfs 0,384(31)
	bl AngleVectors
	lis 9,.LC23@ha
	addi 3,31,376
	la 9,.LC23@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
.L30:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 MageJump2,.Lfe4-MageJump2
	.section	".rodata"
	.align 2
.LC24:
	.string	"Cast spell"
	.align 2
.LC25:
	.string	"Jump Forward"
	.align 2
.LC26:
	.string	"Jump Back"
	.align 2
.LC27:
	.string	"Cell regeneration"
	.align 2
.LC28:
	.string	"Earthquake"
	.align 3
.LC29:
	.long 0x40140000
	.long 0x0
	.section	".text"
	.align 2
	.globl G_ClientInGame
	.type	 G_ClientInGame,@function
G_ClientInGame:
	mr. 3,3
	li 0,0
	mcrf 7,0
	bc 12,30,.L73
	lwz 0,88(3)
	addic 11,0,-1
	subfe 9,11,0
	mr 0,9
.L73:
	cmpwi 0,0,0
	bc 4,2,.L72
	li 3,0
	blr
.L72:
	lwz 10,84(3)
	li 5,0
	li 7,0
	lwz 8,480(3)
	lwz 9,0(10)
	mr 6,10
	srawi 0,8,31
	lwz 11,492(3)
	subf 0,8,0
	xori 9,9,2
	srwi 10,0,31
	xori 11,11,2
	addic 0,9,-1
	subfe 8,0,9
	addic 0,11,-1
	subfe 9,0,11
	mr 11,9
	bc 12,30,.L76
	lwz 0,88(3)
	addic 9,0,-1
	subfe 7,9,0
.L76:
	cmpwi 0,7,0
	bc 12,2,.L78
	addic 9,6,-1
	subfe 9,9,9
	addi 5,9,1
.L78:
	cmpwi 0,5,0
	bc 4,2,.L80
	li 0,0
	b .L81
.L80:
	or. 0,10,11
	li 0,0
	bc 4,2,.L82
	cmpwi 0,8,0
	bc 12,2,.L81
.L82:
	li 0,1
.L81:
	cmpwi 0,0,0
	bc 12,2,.L75
	lfs 13,2228(6)
	lis 11,.LC29@ha
	lis 9,level+4@ha
	la 11,.LC29@l(11)
	lfs 0,level+4@l(9)
	lfd 12,0(11)
	fadd 13,13,12
	fcmpu 7,13,0
	mfcr 3
	rlwinm 3,3,29,1
	blr
.L75:
	li 3,0
	blr
.Lfe5:
	.size	 G_ClientInGame,.Lfe5-G_ClientInGame
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".rodata"
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl G_Within_Radius
	.type	 G_Within_Radius,@function
G_Within_Radius:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 29,44(1)
	stw 0,68(1)
	addi 29,1,8
	mr 30,3
	fmr 31,1
	mr 31,4
	mr 3,29
	li 4,0
	li 5,12
	crxor 6,6,6
	bl memset
	lis 7,.LC30@ha
	li 9,3
	la 7,.LC30@l(7)
	mtctr 9
	lis 8,0x4330
	lfd 11,0(7)
	li 10,0
.L91:
	lfsx 0,10,30
	lfsx 13,10,31
	mr 11,9
	fsubs 0,0,13
	fctiwz 12,0
	stfd 12,32(1)
	lwz 9,36(1)
	srawi 7,9,31
	xor 0,7,9
	subf 0,7,0
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	fsub 0,0,11
	frsp 0,0
	stfsx 0,10,29
	addi 10,10,4
	bdnz .L91
	addi 3,1,8
	bl VectorLength
	fcmpu 7,1,31
	mfcr 3
	rlwinm 3,3,29,1
	lwz 0,68(1)
	mtlr 0
	lmw 29,44(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 G_Within_Radius,.Lfe6-G_Within_Radius
	.align 2
	.globl G_ClientNotDead
	.type	 G_ClientNotDead,@function
G_ClientNotDead:
	lwz 10,480(3)
	cmpwi 0,3,0
	li 5,0
	lwz 8,84(3)
	li 6,0
	srawi 0,10,31
	lwz 11,492(3)
	lwz 9,0(8)
	subf 0,10,0
	srwi 10,0,31
	xori 11,11,2
	xori 9,9,2
	addic 0,9,-1
	subfe 7,0,9
	addic 0,11,-1
	subfe 9,0,11
	mr 11,9
	bc 12,2,.L65
	lwz 0,88(3)
	addic 9,0,-1
	subfe 6,9,0
.L65:
	cmpwi 0,6,0
	bc 12,2,.L67
	addic 9,8,-1
	subfe 9,9,9
	addi 5,9,1
.L67:
	cmpwi 0,5,0
	bc 4,2,.L64
	li 3,0
	blr
.L64:
	or. 0,10,11
	li 3,0
	bc 4,2,.L70
	cmpwi 0,7,0
	bclr 12,2
.L70:
	li 3,1
	blr
.Lfe7:
	.size	 G_ClientNotDead,.Lfe7-G_ClientNotDead
	.align 2
	.globl G_ClientExists
	.type	 G_ClientExists,@function
G_ClientExists:
	mr. 3,3
	li 9,0
	li 0,0
	bc 12,2,.L61
	lwz 0,88(3)
	addic 11,0,-1
	subfe 10,11,0
	mr 0,10
.L61:
	cmpwi 0,0,0
	bc 12,2,.L60
	lwz 9,84(3)
	addic 9,9,-1
	subfe 9,9,9
	addi 9,9,1
.L60:
	mr 3,9
	blr
.Lfe8:
	.size	 G_ClientExists,.Lfe8-G_ClientExists
	.align 2
	.globl G_EntExists
	.type	 G_EntExists,@function
G_EntExists:
	mr. 3,3
	li 0,0
	bc 12,2,.L58
	lwz 0,88(3)
	addic 11,0,-1
	subfe 9,11,0
	mr 0,9
.L58:
	mr 3,0
	blr
.Lfe9:
	.size	 G_EntExists,.Lfe9-G_EntExists
	.section	".rodata"
	.align 2
.LC31:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cell_VicMake
	.type	 Cell_VicMake,@function
Cell_VicMake:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl G_Spawn
	lis 9,Cell_VicThink@ha
	mr 11,3
	la 9,Cell_VicThink@l(9)
	stw 29,256(11)
	lis 10,level+4@ha
	stw 9,436(11)
	lis 9,.LC31@ha
	lfs 0,level+4@l(10)
	la 9,.LC31@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(11)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Cell_VicMake,.Lfe10-Cell_VicMake
	.section	".rodata"
	.align 2
.LC32:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cell_spell
	.type	 Cell_spell,@function
Cell_spell:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,892(31)
	cmpwi 0,0,2
	bc 12,2,.L19
	lwz 9,84(31)
	lwz 0,1872(9)
	cmpwi 0,0,2
	bc 4,2,.L18
.L19:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,14
	bc 12,1,.L20
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L18
.L20:
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	li 9,0
	rlwinm 3,3,0,0,29
	stwx 9,11,3
	bl G_Spawn
	lis 9,Cell_VicThink@ha
	mr 11,3
	la 9,Cell_VicThink@l(9)
	stw 31,256(11)
	lis 10,level+4@ha
	stw 9,436(11)
	lis 9,.LC32@ha
	lfs 0,level+4@l(10)
	la 9,.LC32@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(11)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 Cell_spell,.Lfe11-Cell_spell
	.section	".rodata"
	.align 2
.LC33:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Health_VicThink
	.type	 Health_VicThink,@function
Health_VicThink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,256(31)
	bl G_ClientExists
	cmpwi 0,3,0
	bc 4,2,.L34
	mr 3,31
	bl G_FreeEdict
	b .L33
.L34:
	lwz 11,84(31)
	lwz 9,724(11)
	cmpwi 0,9,90
	bc 12,2,.L33
	addi 0,9,1
	stw 0,724(11)
	lis 9,level+4@ha
	lis 11,.LC33@ha
	lfs 0,level+4@l(9)
	la 11,.LC33@l(11)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(31)
.L33:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Health_VicThink,.Lfe12-Health_VicThink
	.section	".rodata"
	.align 2
.LC34:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Health_VicMake
	.type	 Health_VicMake,@function
Health_VicMake:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl G_Spawn
	lis 9,Health_VicThink@ha
	mr 11,3
	la 9,Health_VicThink@l(9)
	stw 29,256(11)
	lis 10,level+4@ha
	stw 9,436(11)
	lis 9,.LC34@ha
	lfs 0,level+4@l(10)
	la 9,.LC34@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(11)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Health_VicMake,.Lfe13-Health_VicMake
	.section	".rodata"
	.align 2
.LC35:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Health_spell
	.type	 Health_spell,@function
Health_spell:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,892(31)
	cmpwi 0,0,2
	bc 12,2,.L38
	lwz 9,84(31)
	lwz 0,1872(9)
	cmpwi 0,0,2
	bc 4,2,.L37
.L38:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,29
	bc 12,1,.L39
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L37
.L39:
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	li 9,0
	rlwinm 3,3,0,0,29
	stwx 9,11,3
	bl G_Spawn
	lis 9,Health_VicThink@ha
	mr 11,3
	la 9,Health_VicThink@l(9)
	stw 31,256(11)
	lis 10,level+4@ha
	stw 9,436(11)
	lis 9,.LC35@ha
	lfs 0,level+4@l(10)
	la 9,.LC35@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(11)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L37:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 Health_spell,.Lfe14-Health_spell
	.section	".rodata"
	.align 2
.LC36:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl MyCell_Sel
	.type	 MyCell_Sel,@function
MyCell_Sel:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	cmpwi 0,4,1
	mr 31,3
	bc 12,2,.L44
	bc 12,1,.L53
	cmpwi 0,4,0
	bc 12,2,.L43
	b .L42
.L53:
	cmpwi 0,4,2
	bc 12,2,.L45
	cmpwi 0,4,3
	bc 12,2,.L50
	b .L42
.L43:
	mr 3,31
	bl MageJump2
	b .L42
.L44:
	mr 3,31
	bl MageJump1
	b .L42
.L45:
	lwz 0,892(31)
	lwz 9,84(31)
	cmpwi 0,0,2
	bc 12,2,.L46
	lwz 0,1872(9)
	cmpwi 0,0,2
	bc 4,2,.L42
.L46:
	lwz 0,1816(9)
	cmpwi 0,0,14
	bc 12,1,.L48
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L42
.L48:
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	li 9,0
	rlwinm 3,3,0,0,29
	stwx 9,11,3
	bl G_Spawn
	lis 9,Cell_VicThink@ha
	mr 11,3
	la 9,Cell_VicThink@l(9)
	stw 31,256(11)
	lis 10,level+4@ha
	stw 9,436(11)
	lis 9,.LC36@ha
	lfs 0,level+4@l(10)
	la 9,.LC36@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(11)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	b .L42
.L50:
	mr 3,31
	bl Spawn_eq
.L42:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 MyCell_Sel,.Lfe15-MyCell_Sel
	.align 2
	.globl Cmd_Spell_f
	.type	 Cmd_Spell_f,@function
Cmd_Spell_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L54
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L54
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L54
	lwz 0,1936(9)
	cmpwi 0,0,0
	bc 4,2,.L54
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl Menu_Title
	lis 4,.LC25@ha
	mr 3,31
	la 4,.LC25@l(4)
	bl Menu_Add
	lis 4,.LC26@ha
	mr 3,31
	la 4,.LC26@l(4)
	bl Menu_Add
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl Menu_Add
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,MyCell_Sel@ha
	mr 3,31
	la 9,MyCell_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L54:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 Cmd_Spell_f,.Lfe16-Cmd_Spell_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
