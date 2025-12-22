	.file	"g_combat.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x3f800000
	.align 2
.LC1:
	.long 0x3f000000
	.align 3
.LC2:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC3:
	.long 0x402e0000
	.long 0x0
	.section	".text"
	.align 2
	.globl CanDamage
	.type	 CanDamage,@function
CanDamage:
	stwu 1,-128(1)
	mflr 0
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 26,88(1)
	stw 0,132(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L7
	lwz 0,3448(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	lwz 0,3464(9)
	cmpwi 0,0,8
	bc 4,2,.L7
	lis 9,.LC0@ha
	lis 11,invuln_medic@ha
	la 9,.LC0@l(9)
	lfs 13,0(9)
	lwz 9,invuln_medic@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L7
	li 3,0
	b .L16
.L7:
	lwz 0,264(31)
	cmpwi 0,0,2
	bc 4,2,.L8
	lfs 11,224(31)
	lis 11,.LC1@ha
	addi 3,1,8
	lfs 12,212(31)
	la 11,.LC1@l(11)
	mr 4,3
	lfs 10,228(31)
	lfs 13,216(31)
	fadds 12,12,11
	lfs 0,220(31)
	lfs 11,232(31)
	fadds 13,13,10
	lfs 1,0(11)
	stfs 12,8(1)
	fadds 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorScale
	lis 9,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(9)
	la 5,vec3_origin@l(5)
	mr 8,30
	li 9,3
	addi 3,1,24
	addi 4,30,4
	mr 6,5
	mtlr 0
	addi 7,1,8
	blrl
	lfs 0,32(1)
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	li 3,1
	bc 12,2,.L16
	lwz 3,76(1)
	xor 3,3,31
	subfic 11,3,0
	adde 3,11,3
	b .L16
.L8:
	lis 9,gi@ha
	lis 27,vec3_origin@ha
	la 26,gi@l(9)
	la 5,vec3_origin@l(27)
	lwz 10,48(26)
	addi 29,1,24
	addi 28,30,4
	mr 3,29
	mr 4,28
	mr 6,5
	addi 7,31,4
	mtlr 10
	mr 8,30
	li 9,3
	lis 11,.LC2@ha
	la 11,.LC2@l(11)
	lfd 30,0(11)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,30
	bc 12,2,.L14
	lfs 13,4(31)
	lis 9,.LC3@ha
	la 5,vec3_origin@l(27)
	lfs 0,8(31)
	la 9,.LC3@l(9)
	mr 3,29
	lfd 31,0(9)
	mr 4,28
	mr 6,5
	lwz 11,48(26)
	addi 7,1,8
	mr 8,30
	lfs 12,12(31)
	li 9,3
	mtlr 11
	fadd 13,13,31
	fadd 0,0,31
	stfs 12,16(1)
	frsp 13,13
	frsp 0,0
	stfs 13,8(1)
	stfs 0,12(1)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,30
	bc 12,2,.L14
	lfs 13,4(31)
	la 5,vec3_origin@l(27)
	mr 3,29
	lfs 0,8(31)
	mr 4,28
	mr 6,5
	lwz 11,48(26)
	addi 7,1,8
	mr 8,30
	lfs 12,12(31)
	li 9,3
	mtlr 11
	fadd 13,13,31
	stfs 12,16(1)
	fsub 0,0,31
	frsp 13,13
	frsp 0,0
	stfs 13,8(1)
	stfs 0,12(1)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,30
	bc 12,2,.L14
	lfs 13,4(31)
	la 5,vec3_origin@l(27)
	mr 3,29
	lfs 0,8(31)
	mr 4,28
	mr 6,5
	lwz 11,48(26)
	addi 7,1,8
	mr 8,30
	lfs 12,12(31)
	li 9,3
	mtlr 11
	fsub 13,13,31
	stfs 12,16(1)
	fadd 0,0,31
	frsp 13,13
	frsp 0,0
	stfs 13,8(1)
	stfs 0,12(1)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,30
	bc 12,2,.L14
	lfs 13,4(31)
	la 5,vec3_origin@l(27)
	mr 3,29
	lfs 0,8(31)
	mr 4,28
	mr 8,30
	lwz 0,48(26)
	mr 6,5
	addi 7,1,8
	lfs 12,12(31)
	li 9,3
	mtlr 0
	fsub 13,13,31
	stfs 12,16(1)
	fsub 0,0,31
	frsp 13,13
	frsp 0,0
	stfs 13,8(1)
	stfs 0,12(1)
	blrl
	lfs 0,32(1)
	fcmpu 7,0,30
	mfcr 3
	rlwinm 3,3,31,1
	b .L16
.L14:
	li 3,1
.L16:
	lwz 0,132(1)
	mtlr 0
	lmw 26,88(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe1:
	.size	 CanDamage,.Lfe1-CanDamage
	.section	".rodata"
	.align 2
.LC4:
	.string	"monster_medic"
	.align 2
.LC5:
	.string	"spawn_camp_time"
	.align 2
.LC6:
	.string	"2"
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x40000000
	.align 2
.LC9:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl Killed
	.type	 Killed,@function
Killed:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	mr 31,3
	mr 28,4
	lwz 0,484(31)
	mr 30,5
	mr 27,6
	mr 26,7
	cmpwi 0,0,-999
	bc 4,0,.L18
	li 0,-999
	stw 0,484(31)
.L18:
	lwz 0,184(31)
	stw 30,548(31)
	andi. 8,0,4
	bc 12,2,.L19
	lwz 0,496(31)
	cmpwi 0,0,2
	bc 12,2,.L19
	lwz 0,820(31)
	andi. 9,0,256
	bc 4,2,.L19
	lis 9,coop@ha
	lis 11,level@ha
	lwz 10,coop@l(9)
	la 11,level@l(11)
	lis 8,.LC7@ha
	lwz 9,292(11)
	la 8,.LC7@l(8)
	lfs 13,0(8)
	addi 9,9,1
	stw 9,292(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 12,2,.L21
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L21
	lwz 9,3424(11)
	addi 9,9,1
	stw 9,3424(11)
.L21:
	lwz 3,284(30)
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L19
	stw 30,256(31)
.L19:
	lwz 9,264(31)
	addi 0,9,-2
	subfic 8,9,0
	adde 9,8,9
	subfic 0,0,1
	li 0,0
	adde 0,0,0
	or. 11,0,9
	bc 12,2,.L23
	lwz 0,460(31)
	mr 3,31
	mr 4,28
	mr 5,30
	mr 6,27
	mr 7,26
	mtlr 0
	blrl
	b .L17
.L23:
	lwz 0,84(31)
	addic 8,30,-1
	subfe 11,8,30
	mr 10,0
	addic 8,0,-1
	subfe 9,8,0
	and. 0,9,11
	bc 12,2,.L24
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 4,2,.L24
	lwz 9,256(30)
	cmpwi 0,9,0
	bc 12,2,.L24
	lwz 0,84(9)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,30,0
	or 30,0,9
.L24:
	addic 8,10,-1
	subfe 9,8,10
	addic 11,28,-1
	subfe 0,11,28
	and. 8,9,0
	bc 12,2,.L25
	cmpw 0,28,30
	bc 12,2,.L25
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 4,2,.L25
	lwz 9,256(28)
	cmpwi 0,9,0
	bc 12,2,.L25
	lwz 0,84(9)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,30,0
	or 30,0,9
.L25:
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 4,2,.L26
	cmpw 0,30,31
	subfic 11,30,0
	adde 9,11,30
	mcrf 7,0
	mfcr 0
	rlwinm 0,0,3,1
	or. 8,0,9
	bc 4,2,.L28
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,30,0
	bc 4,2,.L27
.L28:
	lwz 10,84(31)
	lis 11,team_list@ha
	la 11,team_list@l(11)
	lwz 9,3448(10)
	lwz 0,84(9)
	addic 0,0,-1
	subfe 0,0,0
	rlwinm 0,0,0,29,29
	lwzx 10,11,0
	lwz 9,76(10)
	addi 9,9,1
	stw 9,76(10)
.L27:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L55
	lwz 0,3484(9)
	cmpwi 0,0,0
	bc 12,2,.L35
	lwz 9,3448(9)
	lis 11,team_list@ha
	la 11,team_list@l(11)
	lwz 0,84(9)
	addic 0,0,-1
	subfe 0,0,0
	rlwinm 0,0,0,29,29
	lwzx 10,11,0
	lwz 9,76(10)
	addi 9,9,-1
	stw 9,76(10)
.L35:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L55
	lwz 0,84(30)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L26
	lwz 9,3448(9)
	cmpwi 0,9,0
	bc 12,2,.L26
	lwz 0,3448(8)
	cmpwi 0,0,0
	bc 12,2,.L26
	bc 12,30,.L43
	cmpw 0,0,9
	bc 4,2,.L57
	lis 9,.LC8@ha
	lis 11,team_kill@ha
	la 9,.LC8@l(9)
	lfs 13,0(9)
	lwz 9,team_kill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L43
	li 0,1
	stw 0,4608(8)
.L43:
	lwz 9,84(30)
	lwz 11,84(31)
	lwz 10,3448(9)
	mr 8,9
	lwz 0,3448(11)
	cmpw 0,10,0
	bc 12,2,.L45
.L57:
	lwz 11,3448(8)
	lwz 9,76(11)
	addi 9,9,1
	stw 9,76(11)
.L45:
	lis 11,.LC7@ha
	lwz 10,84(31)
	lis 9,spawn_camp_check@ha
	la 11,.LC7@l(11)
	lwz 8,spawn_camp_check@l(9)
	lfs 31,0(11)
	lwz 11,3448(10)
	lwz 9,72(11)
	addi 9,9,1
	stw 9,72(11)
	lfs 0,20(8)
	fcmpu 0,0,31
	bc 12,2,.L26
	lis 29,spawn_camp_time@ha
	lwz 9,spawn_camp_time@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L47
	lis 9,gi+148@ha
	lis 3,.LC5@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC6@ha
	la 3,.LC5@l(3)
	la 4,.LC6@l(4)
	mtlr 0
	blrl
.L47:
	lis 9,level@ha
	lwz 10,84(31)
	la 9,level@l(9)
	lwz 11,spawn_camp_time@l(29)
	lfs 12,4(9)
	lfs 0,4544(10)
	lfs 13,20(11)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,0,.L26
	lwz 11,84(30)
	lfs 0,3488(11)
	fcmpu 0,0,31
	bc 12,2,.L49
	stfs 0,3492(11)
	lfs 0,4(9)
	lwz 9,84(30)
	stfs 0,3488(9)
	lfs 12,604(30)
	lwz 9,84(30)
	fcmpu 0,12,31
	lfs 13,3492(9)
	lfs 0,3488(9)
	fsubs 11,0,13
	bc 12,2,.L51
	lis 8,.LC9@ha
	la 8,.LC9@l(8)
	lfs 0,0(8)
	fadds 0,12,0
	fcmpu 0,11,0
	cror 3,2,0
	bc 12,3,.L52
	b .L26
.L51:
	lis 9,.LC9@ha
	lis 11,RI@ha
	la 9,.LC9@l(9)
	lfs 13,0(9)
	lwz 9,RI@l(11)
	lfs 0,20(9)
	fadds 0,0,13
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L26
.L52:
	lwz 9,84(31)
	lwz 0,0(9)
	cmpwi 0,0,2
	bc 12,2,.L26
	lwz 9,84(30)
	li 0,2
	stw 0,4608(9)
	b .L26
.L49:
	stfs 12,3488(11)
.L26:
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L55
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 4,2,.L55
	lis 11,level@ha
	lwz 9,level@l(11)
	addi 9,9,100
	stw 9,4556(10)
.L55:
	lwz 9,460(31)
	mr 3,31
	mr 4,28
	mr 5,30
	mr 6,27
	mr 7,26
	mtlr 9
	li 0,0
	stw 0,692(31)
	blrl
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Killed,.Lfe2-Killed
	.section	".rodata"
	.align 2
.LC10:
	.string	"Cells"
	.align 3
.LC11:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC12:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 CheckPowerArmor,@function
CheckPowerArmor:
	stwu 1,-96(1)
	mflr 0
	mfcr 12
	stmw 22,56(1)
	stw 0,100(1)
	stw 12,52(1)
	mr. 30,6
	mr 31,3
	mr 26,4
	mr 22,5
	bc 12,2,.L81
	andi. 0,7,2
	lwz 24,84(31)
	bc 4,2,.L81
	cmpwi 4,24,0
	bc 12,18,.L63
	mr 3,31
	bl PowerArmorType
	mr. 29,3
	bc 12,2,.L81
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 3,9,3
	addi 11,24,740
	mullw 3,3,0
	srawi 23,3,3
	slwi 0,23,2
	lwzx 28,11,0
	b .L65
.L63:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L81
	lwz 29,928(31)
	lwz 28,932(31)
.L65:
	cmpwi 0,29,0
	bc 12,2,.L81
	cmpwi 0,28,0
	bc 12,2,.L81
	cmpwi 0,29,1
	bc 4,2,.L70
	addi 3,31,16
	addi 4,1,24
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 11,4(31)
	addi 3,1,8
	lfs 12,0(26)
	lfs 10,8(31)
	lfs 13,4(26)
	fsubs 12,12,11
	lfs 0,8(26)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorNormalize
	lfs 0,28(1)
	lis 9,.LC11@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC11@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L81
	lis 0,0x5555
	srawi 9,30,31
	ori 0,0,21846
	li 27,1
	mulhw 0,30,0
	li 25,12
	subf 30,9,0
	b .L72
.L70:
	add 9,30,30
	lis 0,0x5555
	srawi 11,9,31
	ori 0,0,21846
	mulhw 9,9,0
	li 27,2
	li 25,13
	subf 30,11,9
.L72:
	mullw. 28,28,27
	bc 4,2,.L73
.L81:
	li 3,0
	b .L79
.L73:
	cmpw 7,28,30
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,3
	lwz 11,100(29)
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	mtlr 11
	neg 0,0
	andc 9,30,0
	and 0,28,0
	or 28,0,9
	blrl
	lwz 9,100(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,22
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC12@ha
	divw 10,28,27
	lfs 0,level+4@l(9)
	lfd 13,.LC12@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,504(31)
	bc 12,18,.L77
	slwi 11,23,2
	addi 9,24,740
	lwzx 0,9,11
	subf 0,10,0
	stwx 0,9,11
	b .L78
.L77:
	lwz 0,932(31)
	subf 0,10,0
	stw 0,932(31)
.L78:
	mr 3,28
.L79:
	lwz 0,100(1)
	lwz 12,52(1)
	mtlr 0
	lmw 22,56(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe3:
	.size	 CheckPowerArmor,.Lfe3-CheckPowerArmor
	.section	".rodata"
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 CheckArmor,@function
CheckArmor:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr. 29,6
	mr 9,3
	mr 27,4
	mr 25,5
	mr 26,7
	mr 31,8
	bc 12,2,.L90
	lwz 28,84(9)
	cmpwi 0,28,0
	bc 12,2,.L90
	andi. 0,31,2
	li 3,0
	bc 4,2,.L93
	mr 3,9
	bl ArmorIndex
	mr. 30,3
	li 3,0
	bc 12,2,.L93
	mr 3,30
	bl GetItemByIndex
	andi. 0,31,4
	bc 12,2,.L87
	xoris 11,29,0x8000
	lwz 10,60(3)
	stw 11,28(1)
	lis 0,0x4330
	lis 11,.LC13@ha
	stw 0,24(1)
	la 11,.LC13@l(11)
	lfd 0,24(1)
	lfd 13,0(11)
	lfs 1,12(10)
	b .L94
.L87:
	xoris 11,29,0x8000
	lwz 10,60(3)
	stw 11,28(1)
	lis 0,0x4330
	lis 11,.LC13@ha
	stw 0,24(1)
	la 11,.LC13@l(11)
	lfd 0,24(1)
	lfd 13,0(11)
	lfs 1,8(10)
.L94:
	fsub 0,0,13
	frsp 0,0
	fmuls 1,1,0
	bl ceil
	fctiwz 0,1
	stfd 0,24(1)
	lwz 31,28(1)
	slwi 3,30,2
	addi 10,28,740
	lwzx 11,10,3
	cmpw 7,31,11
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	andc 9,11,0
	and 0,31,0
	or. 31,0,9
	bc 12,2,.L90
	subf 0,31,11
	lis 29,gi@ha
	stwx 0,10,3
	la 29,gi@l(29)
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	b .L93
.L90:
	li 3,0
.L93:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 CheckArmor,.Lfe4-CheckArmor
	.section	".rodata"
	.align 2
.LC14:
	.string	"monster_tank"
	.align 2
.LC15:
	.string	"monster_supertank"
	.align 2
.LC16:
	.string	"monster_makron"
	.align 2
.LC17:
	.string	"monster_jorg"
	.section	".text"
	.align 2
	.globl M_ReactToDamage
	.type	 M_ReactToDamage,@function
M_ReactToDamage:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,4
	mr 31,3
	lwz 0,84(30)
	cmpwi 7,0,0
	bc 4,30,.L96
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L95
.L96:
	cmpw 0,30,31
	bc 12,2,.L95
	lwz 4,548(31)
	cmpw 0,30,4
	bc 12,2,.L95
	lwz 0,820(31)
	andi. 11,0,256
	bc 12,2,.L99
	bc 4,30,.L95
	lwz 0,820(30)
	andi. 9,0,256
	bc 4,2,.L95
.L99:
	bc 12,30,.L102
	cmpwi 0,4,0
	bc 12,2,.L106
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L106
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L104
	stw 30,552(31)
	b .L95
.L104:
	lwz 0,548(31)
	stw 0,552(31)
	b .L106
.L102:
	lwz 9,268(31)
	lwz 0,268(30)
	rlwinm 9,9,0,30,31
	rlwinm 0,0,0,30,31
	cmpw 0,9,0
	bc 4,2,.L105
	lwz 3,284(31)
	lwz 4,284(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L105
	lwz 3,284(30)
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L105
	lwz 3,284(30)
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L105
	lwz 3,284(30)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L105
	lwz 3,284(30)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L105
	lwz 9,548(31)
	cmpwi 0,9,0
	bc 12,2,.L106
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L106
	stw 9,552(31)
.L106:
	stw 30,548(31)
	b .L95
.L105:
	lwz 9,548(31)
	cmpwi 0,9,0
	bc 12,2,.L109
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L109
	stw 9,552(31)
.L109:
	lwz 0,820(31)
	lwz 9,548(30)
	andi. 11,0,2048
	stw 9,548(31)
	bc 4,2,.L95
	mr 3,31
	bl FoundTarget
.L95:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 M_ReactToDamage,.Lfe5-M_ReactToDamage
	.section	".rodata"
	.align 3
.LC18:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC19:
	.long 0x42380000
	.align 2
.LC20:
	.long 0x42140000
	.align 2
.LC21:
	.long 0x41e00000
	.align 2
.LC22:
	.long 0x42080000
	.align 2
.LC23:
	.long 0x41d00000
	.align 2
.LC24:
	.long 0x41800000
	.align 2
.LC25:
	.long 0x41900000
	.section	".text"
	.align 2
	.globl Damage_Loc
	.type	 Damage_Loc,@function
Damage_Loc:
	lfs 0,12(3)
	lis 9,.LC18@ha
	lfs 12,196(3)
	lfd 13,.LC18@l(9)
	lwz 0,672(3)
	fadds 0,0,12
	cmpwi 0,0,2
	fsub 0,0,13
	frsp 11,0
	bc 12,2,.L127
	bc 12,1,.L138
	cmpwi 0,0,1
	bc 12,2,.L119
	b .L118
.L138:
	cmpwi 0,0,4
	bc 12,2,.L142
	b .L118
.L119:
	lis 9,.LC19@ha
	lfs 13,8(4)
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fmr 12,13
	fadds 0,11,0
	fcmpu 7,13,0
	bc 4,29,.L120
.L140:
	li 3,8
	blr
.L120:
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fadds 0,11,0
	fcmpu 0,12,0
	bc 4,1,.L122
	bc 4,28,.L122
.L141:
	li 3,4
	blr
.L122:
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fadds 0,11,0
	fcmpu 0,12,0
	bc 4,1,.L124
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fadds 0,11,0
	fcmpu 0,12,0
	bc 4,0,.L124
.L142:
	li 3,2
	blr
.L124:
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
.L143:
	lfs 0,0(9)
	fadds 0,11,0
	fcmpu 0,12,0
	bc 4,0,.L118
	li 3,1
	blr
.L127:
	lis 9,.LC22@ha
	lfs 13,8(4)
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fmr 12,13
	fadds 0,11,0
	fcmpu 7,13,0
	bc 12,29,.L140
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fadds 0,11,0
	fcmpu 0,12,0
	bc 4,1,.L130
	bc 12,28,.L141
.L130:
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fadds 0,11,0
	fcmpu 0,12,0
	bc 4,1,.L132
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fadds 0,11,0
	fcmpu 0,12,0
	bc 12,0,.L142
.L132:
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	b .L143
.L118:
	li 3,2
	blr
.Lfe6:
	.size	 Damage_Loc,.Lfe6-Damage_Loc
	.section	".rodata"
	.align 2
.LC26:
	.string	"Fists"
	.align 2
.LC27:
	.string	"misc/drop.wav"
	.align 2
.LC28:
	.string	"SHIT! YOU DROPPED YOUR WEAPON!!\n"
	.align 2
.LC29:
	.string	"weapon_panzer"
	.align 2
.LC30:
	.string	"world/ric2.wav"
	.align 2
.LC31:
	.string	"DEFLECTION\n"
	.align 2
.LC34:
	.string	"misc/hitleg.wav"
	.align 2
.LC35:
	.string	"weapon_fists"
	.align 2
.LC36:
	.string	"weapon_Morphine"
	.align 2
.LC37:
	.string	"weapon_flamethrower"
	.align 2
.LC38:
	.string	"weapon_binoculars"
	.align 2
.LC40:
	.string	"misc/hittorso.wav"
	.align 2
.LC42:
	.string	"Helmet"
	.align 2
.LC43:
	.string	"misc/hithelm.wav"
	.align 2
.LC44:
	.string	"You lucky bastard! Your helmet deflected the shot!\n"
	.align 2
.LC45:
	.string	"misc/hithead.wav"
	.align 2
.LC46:
	.string	"Your head's been shot off!\n"
	.align 3
.LC32:
	.long 0x3ff26666
	.long 0x66666666
	.align 2
.LC33:
	.long 0x3fd9999a
	.align 2
.LC39:
	.long 0x3fb33333
	.align 2
.LC41:
	.long 0x3fa66666
	.align 3
.LC47:
	.long 0x407f4000
	.long 0x0
	.align 3
.LC48:
	.long 0x40140000
	.long 0x0
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
	.long 0x0
	.align 2
.LC52:
	.long 0x40400000
	.align 3
.LC53:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC54:
	.long 0x40a00000
	.align 2
.LC55:
	.long 0x40000000
	.align 3
.LC56:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC57:
	.long 0x42480000
	.align 3
.LC58:
	.long 0x40990000
	.long 0x0
	.section	".text"
	.align 2
	.globl T_Damage
	.type	 T_Damage,@function
T_Damage:
	stwu 1,-128(1)
	mflr 0
	mfcr 12
	stmw 14,56(1)
	stw 0,132(1)
	stw 12,52(1)
	mr 31,3
	mr 14,4
	lwz 15,136(1)
	mr 23,5
	mr 20,6
	lwz 24,140(1)
	mr 26,7
	mr 17,8
	mr 28,9
	mr 19,10
	li 16,0
	bl IsValidPlayer
	cmpwi 0,3,0
	bc 12,2,.L148
	lis 11,invuln_spawn@ha
	lwz 10,84(31)
	lis 8,level+4@ha
	lwz 9,invuln_spawn@l(11)
	lfs 0,4544(10)
	lfs 13,20(9)
	lfs 12,level+4@l(8)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 12,0,.L147
.L148:
	lwz 0,84(31)
	li 18,0
	li 21,0
	cmpwi 0,0,0
	bc 12,2,.L149
	cmpwi 7,24,10
	addi 0,24,-1
	subfic 0,0,4
	li 0,0
	adde 0,0,0
	mfcr 9
	rlwinm 9,9,31,1
	mcrf 4,7
	or. 8,0,9
	bc 4,2,.L150
	xori 9,24,11
	subfic 10,9,0
	adde 9,10,9
	xori 0,24,36
	subfic 11,0,0
	adde 0,11,0
	or. 8,9,0
	bc 12,2,.L149
.L150:
	mr 3,31
	mr 4,26
	bl Damage_Loc
	mr 25,3
	lwz 9,84(31)
	li 0,20
	cmpwi 0,25,1
	stw 0,4168(9)
	bc 12,2,.L151
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L151
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 12,2,.L151
	lwz 0,4392(3)
	cmpwi 0,0,0
	bc 12,2,.L151
	lwz 0,3448(3)
	cmpwi 0,0,0
	bc 12,2,.L151
	lwz 3,1796(3)
	cmpwi 0,3,0
	bc 12,2,.L151
	lwz 3,0(3)
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L151
	bl rand
	lis 0,0x51eb
	srawi 11,3,31
	ori 0,0,34079
	mulhw 0,3,0
	lis 8,.LC48@ha
	la 8,.LC48@l(8)
	srawi 0,0,5
	lfd 12,0(8)
	subf 0,11,0
	mulli 0,0,100
	subf 3,0,3
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,44(1)
	stw 0,40(1)
	lfd 0,40(1)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfd 13,0(9)
	fsub 0,0,13
	fcmpu 0,0,12
	bc 4,0,.L151
	lis 29,gi@ha
	lis 3,.LC30@ha
	la 29,gi@l(29)
	la 3,.LC30@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 8,.LC50@ha
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	la 8,.LC50@l(8)
	la 10,.LC51@l(10)
	mr 5,3
	mtlr 11
	lfs 1,0(8)
	la 9,.LC50@l(9)
	lfs 3,0(10)
	mr 3,31
	lfs 2,0(9)
	li 4,4
	blrl
	lwz 9,8(29)
	lis 5,.LC31@ha
	li 4,2
	la 5,.LC31@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	lwz 11,84(31)
	li 0,0
	lis 8,.LC52@ha
	la 8,.LC52@l(8)
	stw 0,4688(11)
	lwz 9,84(31)
	lfs 13,0(8)
	lfs 0,4200(9)
	fadds 0,0,13
	stfs 0,4200(9)
	lwz 11,84(31)
	lfs 0,4204(11)
	fadds 0,0,13
	stfs 0,4204(11)
	lwz 9,84(31)
	lfs 0,4208(9)
	fsubs 0,0,13
	stfs 0,4208(9)
	b .L147
.L151:
	mfcr 9
	rlwinm 9,9,19,1
	xori 0,24,4
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L152
	xori 0,25,8
	srawi 8,0,31
	xor 9,8,0
	subf 9,9,8
	srawi 9,9,31
	nor 0,9,9
	and 9,25,9
	rlwinm 0,0,0,29,29
	or 25,9,0
.L152:
	cmpwi 0,25,2
	bc 12,2,.L156
	bc 12,1,.L177
	cmpwi 0,25,1
	bc 12,2,.L154
	b .L147
.L177:
	cmpwi 0,25,4
	bc 12,2,.L164
	cmpwi 0,25,8
	bc 12,2,.L168
	b .L147
.L154:
	xoris 11,28,0x8000
	lwz 8,84(31)
	stw 11,44(1)
	lis 0,0x4330
	lis 10,.LC49@ha
	la 10,.LC49@l(10)
	stw 0,40(1)
	lis 11,.LC32@ha
	lfd 11,0(10)
	cmpwi 0,8,0
	ori 21,21,1
	lfd 0,40(1)
	mr 10,9
	lfd 13,.LC32@l(11)
	fsub 0,0,11
	fmul 0,0,13
	fctiwz 12,0
	stfd 12,40(1)
	lwz 28,44(1)
	bc 12,2,.L155
	lis 9,.LC33@ha
	lfs 0,.LC33@l(9)
	stfs 0,4688(8)
.L155:
	lis 29,gi@ha
	lis 3,.LC34@ha
	la 29,gi@l(29)
	la 3,.LC34@l(3)
	b .L226
.L156:
	xoris 11,28,0x8000
	lwz 10,692(31)
	stw 11,44(1)
	lis 0,0x4330
	lis 8,.LC49@ha
	stw 0,40(1)
	la 8,.LC49@l(8)
	lis 11,.LC53@ha
	lfd 0,40(1)
	la 11,.LC53@l(11)
	cmpwi 0,10,0
	lfd 11,0(8)
	ori 21,21,2
	lfd 12,0(11)
	mr 11,9
	fsub 0,0,11
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,40(1)
	lwz 28,44(1)
	bc 4,2,.L157
	lis 8,.LC54@ha
	lis 9,level+4@ha
	la 8,.LC54@l(8)
	lfs 0,level+4@l(9)
	lfs 12,0(8)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,40(1)
	lwz 18,44(1)
	b .L158
.L157:
	li 18,-20
.L158:
	bl rand
	lis 29,gi@ha
	bl srand
	bl rand
	lis 0,0x51eb
	srawi 11,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,11,0
	mulli 9,0,100
	subf 0,9,3
	cmpwi 0,0,97
	bc 4,1,.L159
	mr 3,31
	bl IsValidPlayer
	cmpwi 0,3,0
	bc 12,2,.L159
	lwz 9,84(31)
	lwz 3,1796(9)
	cmpwi 0,3,0
	bc 12,2,.L159
	lwz 3,0(3)
	cmpwi 0,3,0
	bc 12,2,.L159
	lis 4,.LC35@ha
	la 4,.LC35@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L159
	lwz 11,84(31)
	lis 4,.LC36@ha
	la 4,.LC36@l(4)
	lwz 9,1796(11)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L159
	lwz 11,84(31)
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	lwz 9,1796(11)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L159
	lwz 11,84(31)
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	lwz 9,1796(11)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L159
	lwz 10,84(31)
	lwz 30,1796(10)
	cmpwi 0,30,0
	bc 12,2,.L159
	lwz 11,4132(10)
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	rlwinm 11,11,0,0,30
	subf 9,9,30
	stw 11,4132(10)
	mullw 9,9,0
	li 22,0
	lis 3,.LC26@ha
	lwz 11,84(31)
	la 3,.LC26@l(3)
	srawi 9,9,3
	lwz 0,4140(11)
	slwi 27,9,2
	rlwinm 0,0,0,0,30
	stw 0,4140(11)
	lwz 9,84(31)
	stw 22,4192(9)
	bl FindItem
	mr 4,3
	mr 3,31
	bl Use_Weapon
	lwz 9,84(31)
	addi 9,9,740
	lwzx 0,9,27
	cmpwi 0,0,0
	bc 12,2,.L159
	mr 4,30
	mr 3,31
	bl Drop_Item
	la 29,gi@l(29)
	lwz 9,84(31)
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	addi 9,9,740
	stwx 22,9,27
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 8,.LC50@ha
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	mr 5,3
	la 8,.LC50@l(8)
	la 9,.LC50@l(9)
	mtlr 11
	la 10,.LC51@l(10)
	li 4,4
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	lwz 0,12(29)
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L159:
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L167
	lis 9,.LC39@ha
	lfs 0,.LC39@l(9)
	b .L229
.L164:
	lwz 0,692(31)
	add 28,28,28
	ori 21,21,4
	cmpwi 0,0,0
	bc 4,2,.L165
	lis 8,.LC54@ha
	lis 9,level+4@ha
	la 8,.LC54@l(8)
	lfs 0,level+4@l(9)
	lfs 12,0(8)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,40(1)
	lwz 18,44(1)
	b .L166
.L165:
	li 18,-45
.L166:
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L167
	lis 9,.LC41@ha
	lfs 0,.LC41@l(9)
.L229:
	stfs 0,4688(11)
.L167:
	lis 29,gi@ha
	lis 3,.LC40@ha
	la 29,gi@l(29)
	la 3,.LC40@l(3)
.L226:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC50@ha
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	mr 5,3
	la 8,.LC50@l(8)
	la 9,.LC50@l(9)
	mtlr 0
	la 10,.LC51@l(10)
	li 4,4
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L149
.L168:
	lwz 29,84(31)
	cmpwi 0,29,0
	bc 12,2,.L149
	lis 3,.LC42@ha
	la 3,.LC42@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 3,9,3
	addi 11,29,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,2,.L170
	bl rand
	bl srand
	bl rand
	lis 0,0x51eb
	srawi 11,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,11,0
	mulli 9,0,100
	subf 0,9,3
	cmpwi 0,0,85
	bc 4,1,.L170
	lis 29,gi@ha
	lis 3,.LC43@ha
	la 29,gi@l(29)
	la 3,.LC43@l(3)
	lwz 9,36(29)
	li 28,0
	li 16,1
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 8,.LC50@ha
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	la 8,.LC50@l(8)
	la 9,.LC50@l(9)
	mr 5,3
	mtlr 11
	lfs 1,0(8)
	la 10,.LC51@l(10)
	lfs 2,0(9)
	li 4,4
	mr 3,31
	lfs 3,0(10)
	blrl
	lwz 0,8(29)
	lis 5,.LC44@ha
	mr 3,31
	la 5,.LC44@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lis 8,.LC52@ha
	li 0,0
	la 8,.LC52@l(8)
	lfs 0,4200(11)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,4200(11)
	lwz 9,84(31)
	lfs 0,4204(9)
	fsubs 0,0,13
	stfs 0,4204(9)
	lwz 11,84(31)
	lfs 0,4208(11)
	fadds 0,0,13
	stfs 0,4208(11)
	lwz 9,84(31)
	stw 0,4688(9)
.L170:
	cmpwi 0,16,0
	bc 4,2,.L172
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 4,2,.L173
	lis 29,gi@ha
	lis 3,.LC45@ha
	la 29,gi@l(29)
	la 3,.LC45@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 8,.LC50@ha
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	mr 5,3
	la 8,.LC50@l(8)
	la 9,.LC50@l(9)
	mtlr 11
	la 10,.LC51@l(10)
	li 4,4
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	lwz 0,8(29)
	lis 5,.LC46@ha
	mr 3,31
	la 5,.LC46@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L173:
	lwz 9,84(31)
	lis 0,0x3f80
	mulli 28,28,100
	ori 21,21,8
	stw 0,3456(9)
	b .L149
.L172:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
.L149:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 12,2,.L147
	xor 0,31,23
	addic 8,23,-1
	subfe 11,8,23
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L179
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L179
	lwz 0,84(23)
	cmpwi 0,0,0
	bc 12,2,.L179
	lwz 0,3464(9)
	cmpwi 0,0,8
	bc 4,2,.L180
	lis 11,invuln_medic@ha
	lis 8,.LC50@ha
	lwz 9,invuln_medic@l(11)
	la 8,.LC50@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L180
	li 21,0
	li 18,0
	li 28,0
.L180:
	mr 3,31
	mr 4,23
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L181
	lis 9,team_kill@ha
	lis 8,.LC50@ha
	lwz 11,team_kill@l(9)
	la 8,.LC50@l(8)
	lfs 0,0(8)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L183
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L182
.L183:
	lwz 9,688(31)
	cmpwi 0,25,8
	oris 24,24,0x800
	lwz 0,692(31)
	or 9,9,21
	add 0,0,18
	stw 9,688(31)
	stw 0,692(31)
	bc 12,2,.L227
	b .L228
.L182:
	li 28,0
	li 19,0
	b .L188
.L181:
	lwz 9,688(31)
	cmpwi 0,25,8
	lwz 0,692(31)
	or 9,9,21
	subf 0,18,0
	stw 9,688(31)
	stw 0,692(31)
	bc 4,2,.L189
.L227:
	cmpwi 0,16,0
	bc 4,2,.L188
.L228:
	mr 3,31
	mr 4,26
	mr 5,20
	mr 6,28
	mr 7,24
	bl SprayBlood
	b .L188
.L189:
	mr 3,31
	mr 4,26
	mr 5,20
	mr 6,28
	mr 7,24
	bl SprayBlood
.L188:
	mr 3,31
	bl WeighPlayer
.L179:
	lis 11,skill@ha
	lis 8,.LC51@ha
	lwz 10,skill@l(11)
	la 8,.LC51@l(8)
	lis 9,meansOfDeath@ha
	lfs 13,0(8)
	lfs 0,20(10)
	stw 24,meansOfDeath@l(9)
	fcmpu 0,0,13
	bc 4,2,.L192
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L192
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L192
	xoris 11,28,0x8000
	stw 11,44(1)
	lis 0,0x4330
	lis 10,.LC49@ha
	stw 0,40(1)
	la 10,.LC49@l(10)
	lis 11,.LC56@ha
	lfd 0,40(1)
	la 11,.LC56@l(11)
	lfd 11,0(10)
	lfd 12,0(11)
	mr 11,9
	fsub 0,0,11
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,40(1)
	lwz 28,44(1)
	srawi 0,28,31
	xor 9,0,28
	subf 9,9,0
	srawi 9,9,31
	addi 0,9,1
	and 9,28,9
	or 28,9,0
.L192:
	andi. 8,15,16
	lwz 27,84(31)
	mr 3,20
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,9
	rlwinm 9,9,0,28,30
	or 22,0,9
	bl VectorNormalize
	andi. 0,15,1
	bc 4,2,.L196
	lwz 0,184(31)
	andi. 8,0,4
	bc 12,2,.L196
	lwz 0,84(23)
	cmpwi 0,0,0
	bc 12,2,.L196
	lwz 0,548(31)
	cmpwi 0,0,0
	bc 4,2,.L196
	lwz 9,484(31)
	add 11,28,28
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,28,9
	or 28,9,11
.L196:
	andi. 0,15,8
	lwz 9,268(31)
	mcrf 7,0
	andi. 8,9,2048
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	and 25,19,0
	mr 19,25
	bc 4,30,.L198
	cmpwi 0,25,0
	bc 12,2,.L198
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 12,2,.L198
	cmpwi 0,0,9
	bc 12,2,.L198
	cmpwi 0,0,2
	bc 12,2,.L198
	cmpwi 0,0,3
	bc 12,2,.L198
	lwz 0,404(31)
	cmpwi 0,0,49
	bc 12,1,.L200
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 0,0(9)
	b .L201
.L200:
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 10,.LC49@ha
	la 10,.LC49@l(10)
	stw 11,40(1)
	lfd 13,0(10)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
.L201:
	lwz 0,84(31)
	xor 11,23,31
	subfic 8,11,0
	adde 11,8,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,9,11
	bc 12,2,.L202
	xoris 0,19,0x8000
	fmr 11,0
	lis 9,0x4330
	stw 0,44(1)
	lis 8,.LC49@ha
	stw 9,40(1)
	la 8,.LC49@l(8)
	mr 3,20
	lfd 13,0(8)
	lis 9,.LC58@ha
	addi 4,1,8
	lfd 0,40(1)
	la 9,.LC58@l(9)
	lfd 12,0(9)
	fsub 0,0,13
	frsp 0,0
	fmr 1,0
	fmul 1,1,12
	fdiv 1,1,11
	frsp 1,1
	bl VectorScale
	b .L203
.L202:
	xoris 0,19,0x8000
	fmr 11,0
	stw 0,44(1)
	lis 9,0x4330
	lis 8,.LC49@ha
	la 8,.LC49@l(8)
	stw 9,40(1)
	lis 10,.LC47@ha
	lfd 12,0(8)
	mr 3,20
	addi 4,1,8
	lfd 0,40(1)
	lfd 13,.LC47@l(10)
	fsub 0,0,12
	frsp 0,0
	fmr 1,0
	fmul 1,1,13
	fdiv 1,1,11
	frsp 1,1
	bl VectorScale
.L203:
	lfs 11,8(1)
	lfs 10,12(1)
	lfs 9,16(1)
	lfs 0,380(31)
	lfs 13,384(31)
	lfs 12,388(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	stfs 0,380(31)
	stfs 13,384(31)
	stfs 12,388(31)
.L198:
	mr 30,28
	mr 8,15
	mr 6,30
	mr 3,31
	mr 4,26
	mr 5,17
	mr 7,22
	bl CheckArmor
	mr 28,3
	subf. 30,28,30
	bc 12,2,.L204
	lwz 0,184(31)
	addic 8,27,-1
	subfe 9,8,27
	rlwinm 0,0,30,31,31
	or. 10,0,9
	bc 12,2,.L205
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,17
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	b .L208
.L205:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,22
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,17
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
.L208:
	cmpwi 0,23,0
	bc 12,2,.L211
	stw 23,548(31)
	b .L212
.L211:
	cmpwi 0,24,35
	bc 4,2,.L212
	lwz 23,548(31)
.L212:
	lwz 0,484(31)
	subf 0,30,0
	cmpwi 0,0,0
	stw 0,484(31)
	bc 12,1,.L204
	lwz 0,184(31)
	addic 8,27,-1
	subfe 9,8,27
	rlwinm 0,0,30,31,31
	or. 10,0,9
	bc 12,2,.L215
	lwz 0,268(31)
	ori 0,0,2048
	stw 0,268(31)
.L215:
	mr 3,31
	mr 4,14
	mr 5,23
	mr 6,30
	mr 7,26
	bl Killed
	b .L147
.L204:
	lwz 0,184(31)
	andi. 8,0,4
	bc 12,2,.L216
	mr 3,31
	mr 4,23
	bl M_ReactToDamage
	cmpwi 0,27,0
	lwz 0,820(31)
	addic 8,30,-1
	subfe 9,8,30
	xori 0,0,2048
	mfcr 29
	rlwinm 0,0,21,31,31
	and. 10,0,9
	bc 12,2,.L219
	xoris 11,19,0x8000
	lwz 10,456(31)
	stw 11,44(1)
	lis 0,0x4330
	mr 4,23
	lis 11,.LC49@ha
	stw 0,40(1)
	mr 3,31
	mtlr 10
	la 11,.LC49@l(11)
	lfd 1,40(1)
	mr 5,30
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	blrl
	lis 11,skill@ha
	lis 8,.LC52@ha
	lwz 9,skill@l(11)
	la 8,.LC52@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L219
	lis 10,.LC54@ha
	lis 9,level+4@ha
	la 10,.LC54@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,468(31)
	b .L219
.L216:
	cmpwi 0,27,0
	mfcr 29
	bc 12,2,.L220
	lwz 0,268(31)
	addic 8,30,-1
	subfe 9,8,30
	xori 0,0,16
	rlwinm 0,0,28,31,31
	and. 10,0,9
	bc 12,2,.L219
	xoris 11,19,0x8000
	lwz 10,456(31)
	stw 11,44(1)
	lis 0,0x4330
	mr 3,31
	lis 11,.LC49@ha
	stw 0,40(1)
	mr 4,23
	mtlr 10
	la 11,.LC49@l(11)
	lfd 1,40(1)
	mr 5,30
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	blrl
	b .L219
.L220:
	cmpwi 0,30,0
	bc 12,2,.L219
	lwz 10,456(31)
	cmpwi 0,10,0
	bc 12,2,.L219
	xoris 0,19,0x8000
	mtlr 10
	stw 0,44(1)
	lis 11,0x4330
	lis 8,.LC49@ha
	la 8,.LC49@l(8)
	stw 11,40(1)
	mr 3,31
	lfd 0,0(8)
	mr 4,23
	mr 5,30
	lfd 1,40(1)
	fsub 1,1,0
	frsp 1,1
	blrl
.L219:
	mtcrf 128,29
	bc 12,2,.L147
	lis 8,.LC55@ha
	lis 10,level+4@ha
	lwz 9,4156(27)
	la 8,.LC55@l(8)
	lfs 0,level+4@l(10)
	lfs 13,0(8)
	add 9,9,28
	lwz 11,4164(27)
	lwz 0,4168(27)
	fadds 0,0,13
	add 11,11,30
	stw 9,4156(27)
	add 0,0,25
	stw 11,4164(27)
	stw 0,4168(27)
	stfs 0,4184(27)
	lfs 0,0(26)
	stfs 0,4172(27)
	lfs 13,4(26)
	stfs 13,4176(27)
	lfs 0,8(26)
	stfs 0,4180(27)
.L147:
	lwz 0,132(1)
	lwz 12,52(1)
	mtlr 0
	lmw 14,56(1)
	mtcrf 8,12
	la 1,128(1)
	blr
.Lfe7:
	.size	 T_Damage,.Lfe7-T_Damage
	.section	".rodata"
	.align 2
.LC60:
	.string	"sprites/null.sp2"
	.align 2
.LC61:
	.string	"blood_spray"
	.align 3
.LC62:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SprayBlood
	.type	 SprayBlood,@function
SprayBlood:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	addi 10,7,-1
	mr 26,3
	cmplwi 0,10,68
	mr 30,4
	mr 28,5
	mr 25,6
	bc 12,1,.L253
	lis 11,.L254@ha
	slwi 10,10,2
	la 11,.L254@l(11)
	lis 9,.L254@ha
	lwzx 0,10,11
	la 9,.L254@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L254:
	.long .L245-.L254
	.long .L246-.L254
	.long .L247-.L254
	.long .L248-.L254
	.long .L249-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L251-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
	.long .L253-.L254
.L245:
	li 31,250
	b .L244
.L246:
	li 31,300
	b .L244
.L247:
.L248:
	li 31,400
	b .L244
.L249:
	li 31,700
	b .L244
.L251:
	li 31,800
	b .L244
.L253:
	li 31,500
.L244:
	addi 0,7,-1
	xori 9,7,10
	subfic 11,9,0
	adde 9,11,9
	subfic 0,0,4
	li 0,0
	adde 0,0,0
	or. 11,0,9
	bc 4,2,.L256
	xori 9,7,11
	subfic 0,9,0
	adde 9,0,9
	xori 0,7,36
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L256
	cmpwi 0,7,69
	bc 4,2,.L255
.L256:
	bl G_Spawn
	lis 27,0x4330
	lis 9,.LC62@ha
	mr 29,3
	la 9,.LC62@l(9)
	mr 3,28
	lfd 31,0(9)
	bl VectorNormalize
	lfs 13,0(30)
	mr 3,28
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,4(30)
	stfs 0,8(29)
	lfs 13,8(30)
	stfs 13,12(29)
	lfs 0,0(28)
	stfs 0,344(29)
	lfs 13,4(28)
	stfs 13,348(29)
	lfs 0,8(28)
	stfs 0,352(29)
	bl vectoangles
	xoris 0,31,0x8000
	stw 0,20(1)
	mr 3,28
	addi 4,29,380
	stw 27,16(1)
	lfd 1,16(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorScale
	lwz 11,64(29)
	lis 0,0x600
	li 9,0
	ori 0,0,3
	li 10,7
	stw 9,200(29)
	ori 11,11,2
	li 8,2
	stw 10,264(29)
	lis 28,gi@ha
	stw 0,252(29)
	lis 3,.LC60@ha
	la 28,gi@l(28)
	stw 8,248(29)
	la 3,.LC60@l(3)
	stw 11,64(29)
	stw 9,196(29)
	stw 9,192(29)
	stw 9,188(29)
	stw 9,208(29)
	stw 9,204(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 0,0x51eb
	stw 3,40(29)
	ori 0,0,34079
	stw 26,256(29)
	lis 11,level+4@ha
	mulhw 0,31,0
	lfs 13,level+4@l(11)
	lis 9,blood_spray_touch@ha
	lis 10,.LC61@ha
	lis 11,BloodSprayThink@ha
	la 9,blood_spray_touch@l(9)
	stw 25,520(29)
	srawi 0,0,6
	la 11,BloodSprayThink@l(11)
	stw 9,448(29)
	xoris 0,0,0x8000
	la 10,.LC61@l(10)
	stw 11,440(29)
	stw 0,20(1)
	mr 3,29
	stw 27,16(1)
	lfd 0,16(1)
	stw 10,284(29)
	fsub 0,0,31
	frsp 0,0
	fadds 13,13,0
	stfs 13,432(29)
	lwz 0,72(28)
	mtlr 0
	blrl
.L255:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 SprayBlood,.Lfe8-SprayBlood
	.comm	is_silenced,1,1
	.section	".rodata"
	.align 2
.LC64:
	.long 0x3f000000
	.align 3
.LC65:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC66:
	.long 0x0
	.section	".text"
	.align 2
	.globl T_RadiusDamage
	.type	 T_RadiusDamage,@function
T_RadiusDamage:
	stwu 1,-112(1)
	mflr 0
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 26,64(1)
	stw 0,116(1)
	fmr 29,1
	mr 30,3
	mr 28,4
	fmr 30,2
	addi 29,30,4
	mr 26,5
	mr 27,6
	li 31,0
	b .L231
.L233:
	cmpw 0,31,26
	bc 12,2,.L231
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 12,2,.L231
	lfs 0,200(31)
	lis 9,.LC64@ha
	addi 4,1,16
	lfs 13,188(31)
	la 9,.LC64@l(9)
	addi 3,31,4
	lfs 1,0(9)
	mr 5,4
	fadds 13,13,0
	stfs 13,16(1)
	lfs 13,204(31)
	lfs 0,192(31)
	fadds 0,0,13
	stfs 0,20(1)
	lfs 0,208(31)
	lfs 13,196(31)
	fadds 13,13,0
	stfs 13,24(1)
	bl VectorMA
	lfs 0,4(30)
	addi 3,1,16
	lfs 13,8(30)
	lfs 12,12(30)
	lfs 11,20(1)
	lfs 9,16(1)
	lfs 10,24(1)
	fsubs 13,13,11
	fsubs 0,0,9
	fsubs 12,12,10
	stfs 13,20(1)
	stfs 0,16(1)
	stfs 12,24(1)
	bl VectorLength
	lis 9,.LC65@ha
	cmpw 0,31,28
	la 9,.LC65@l(9)
	fmr 0,29
	lfd 11,0(9)
	fmul 1,1,11
	fsub 0,0,1
	frsp 31,0
	bc 4,2,.L236
	fmr 0,31
	fmul 0,0,11
	frsp 31,0
.L236:
	lis 9,.LC66@ha
	la 9,.LC66@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,1,.L231
	mr 3,31
	mr 4,30
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L231
	lfs 0,4(30)
	fmr 11,31
	li 0,1
	lfs 12,4(31)
	lis 8,vec3_origin@ha
	mr 3,31
	lfs 10,8(30)
	la 8,vec3_origin@l(8)
	mr 4,30
	lfs 9,12(30)
	fctiwz 13,11
	mr 5,28
	addi 6,1,32
	fsubs 12,12,0
	mr 7,29
	stfd 13,56(1)
	stfs 12,32(1)
	lfs 0,8(31)
	lwz 9,60(1)
	fsubs 0,0,10
	mr 10,9
	stfs 0,36(1)
	lfs 0,12(31)
	stw 0,8(1)
	stw 27,12(1)
	fsubs 0,0,9
	stfs 0,40(1)
	bl T_Damage
.L231:
	fmr 1,30
	mr 3,31
	mr 4,29
	bl findradius
	mr. 31,3
	bc 4,2,.L233
	fmr 1,29
	mr 3,30
	fmr 2,30
	bl SetExplosionEffect
	lwz 0,116(1)
	mtlr 0
	lmw 26,64(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe9:
	.size	 T_RadiusDamage,.Lfe9-T_RadiusDamage
	.align 2
	.globl BloodSprayThink
	.type	 BloodSprayThink,@function
BloodSprayThink:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 BloodSprayThink,.Lfe10-BloodSprayThink
	.section	".rodata"
	.align 3
.LC67:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl blood_spray_touch
	.type	 blood_spray_touch,@function
blood_spray_touch:
	lwz 0,256(3)
	cmpw 0,4,0
	bclr 12,2
	lis 9,G_FreeEdict@ha
	lis 10,level+4@ha
	la 9,G_FreeEdict@l(9)
	lis 11,.LC67@ha
	stw 9,440(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC67@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe11:
	.size	 blood_spray_touch,.Lfe11-blood_spray_touch
	.section	".rodata"
	.align 2
.LC68:
	.long 0x43898000
	.align 2
.LC69:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl SetExplosionEffect
	.type	 SetExplosionEffect,@function
SetExplosionEffect:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 26,24(1)
	stw 0,68(1)
	lis 9,.LC68@ha
	fadds 31,2,1
	mr 30,3
	lfs 30,.LC68@l(9)
	li 31,0
	lis 26,level@ha
	li 27,999
	li 28,1
	li 29,0
	b .L258
.L260:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L258
	lwz 0,level@l(26)
	stw 0,4692(9)
	lwz 9,84(31)
	stw 27,4696(9)
	lfs 13,200(31)
	lfs 0,188(31)
	fadds 0,0,13
	stfs 0,8(1)
	lfs 0,204(31)
	lfs 13,192(31)
	fadds 13,13,0
	stfs 13,12(1)
	lfs 13,208(31)
	lfs 0,196(31)
	fadds 0,0,13
	stfs 0,16(1)
	bl VectorMA
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,8(30)
	lfs 12,12(30)
	lfs 9,8(1)
	lfs 11,12(1)
	lfs 10,16(1)
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 12,16(1)
	bl VectorLength
	fsubs 1,31,1
	lwz 9,84(31)
	addi 3,1,8
	stfs 1,4704(9)
	bl VectorLength
	fcmpu 0,1,30
	bc 4,0,.L262
	lwz 9,84(31)
	stw 28,4708(9)
	b .L258
.L262:
	lwz 9,84(31)
	stw 29,4708(9)
.L258:
	fmr 1,31
	mr 3,31
	addi 4,30,4
	bl findradius
	mr. 31,3
	lis 9,.LC69@ha
	addi 4,1,8
	la 9,.LC69@l(9)
	lfs 1,0(9)
	mr 5,4
	addi 3,31,4
	bc 4,2,.L260
	lwz 0,68(1)
	mtlr 0
	lmw 26,24(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 SetExplosionEffect,.Lfe12-SetExplosionEffect
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.align 2
	.globl SpawnDamage
	.type	 SpawnDamage,@function
SpawnDamage:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 26,4
	mr 27,5
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 SpawnDamage,.Lfe13-SpawnDamage
	.align 2
	.globl CheckTeamDamage
	.type	 CheckTeamDamage,@function
CheckTeamDamage:
	li 3,0
	blr
.Lfe14:
	.size	 CheckTeamDamage,.Lfe14-CheckTeamDamage
	.section	".rodata"
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl In_Vector_Range
	.type	 In_Vector_Range,@function
In_Vector_Range:
	stwu 1,-32(1)
	lfs 12,0(3)
	lis 8,.LC70@ha
	lfs 11,0(4)
	mr 11,9
	la 8,.LC70@l(8)
	lfs 0,8(4)
	lis 10,0x4330
	lfs 10,8(3)
	fsubs 12,12,11
	lfd 8,0(8)
	lfs 9,4(3)
	fsubs 10,10,0
	lfs 11,4(4)
	fmr 0,12
	stfs 12,8(1)
	fsubs 9,9,11
	stfs 10,16(1)
	fctiwz 13,0
	stfs 9,12(1)
	stfd 13,24(1)
	lwz 9,28(1)
	srawi 8,9,31
	xor 0,8,9
	subf 0,8,0
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,8
	frsp 0,0
	fcmpu 0,0,1
	bc 12,1,.L115
	fmr 13,9
	mr 11,9
	fctiwz 0,13
	stfd 0,24(1)
	lwz 9,28(1)
	srawi 8,9,31
	xor 0,8,9
	subf 0,8,0
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,8
	frsp 0,0
	fcmpu 0,0,2
	bc 12,1,.L115
	fmr 13,10
	mr 11,9
	fctiwz 0,13
	stfd 0,24(1)
	lwz 9,28(1)
	srawi 8,9,31
	xor 0,8,9
	subf 0,8,0
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,8
	frsp 0,0
	fcmpu 7,0,3
	mfcr 3
	rlwinm 3,3,30,1
	xori 3,3,1
	b .L265
.L115:
	li 3,0
.L265:
	la 1,32(1)
	blr
.Lfe15:
	.size	 In_Vector_Range,.Lfe15-In_Vector_Range
	.section	".rodata"
	.align 2
.LC71:
	.long 0x3f800000
	.align 2
.LC72:
	.long 0x0
	.section	".text"
	.align 2
	.globl Drop_Shot
	.type	 Drop_Shot,@function
Drop_Shot:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr. 29,4
	mr 31,3
	bc 12,2,.L144
	lwz 10,84(31)
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	lwz 11,4132(10)
	subf 9,9,29
	li 28,0
	mullw 9,9,0
	lis 3,.LC26@ha
	rlwinm 11,11,0,0,30
	la 3,.LC26@l(3)
	stw 11,4132(10)
	srawi 9,9,3
	lwz 11,84(31)
	slwi 30,9,2
	lwz 0,4140(11)
	rlwinm 0,0,0,0,30
	stw 0,4140(11)
	lwz 9,84(31)
	stw 28,4192(9)
	bl FindItem
	mr 4,3
	mr 3,31
	bl Use_Weapon
	lwz 9,84(31)
	addi 9,9,740
	lwzx 0,9,30
	cmpwi 0,0,0
	bc 12,2,.L144
	mr 4,29
	mr 3,31
	bl Drop_Item
	lwz 9,84(31)
	lis 29,gi@ha
	lis 3,.LC27@ha
	la 29,gi@l(29)
	la 3,.LC27@l(3)
	addi 9,9,740
	stwx 28,9,30
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC71@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC71@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 2,0(9)
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,12(29)
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L144:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Drop_Shot,.Lfe16-Drop_Shot
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
