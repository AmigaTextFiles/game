	.file	"g_combat.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x3f000000
	.align 3
.LC1:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC2:
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
	lwz 0,264(31)
	cmpwi 0,0,2
	bc 4,2,.L7
	lfs 11,224(31)
	lis 9,.LC0@ha
	addi 3,1,8
	lfs 12,212(31)
	la 9,.LC0@l(9)
	mr 4,3
	lfs 10,228(31)
	lfs 13,216(31)
	fadds 12,12,11
	lfs 0,220(31)
	lfs 11,232(31)
	fadds 13,13,10
	lfs 1,0(9)
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
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	li 3,1
	bc 12,2,.L15
	lwz 3,76(1)
	xor 3,3,31
	subfic 11,3,0
	adde 3,11,3
	b .L15
.L7:
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
	lis 11,.LC1@ha
	la 11,.LC1@l(11)
	lfd 30,0(11)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,30
	bc 12,2,.L13
	lfs 13,4(31)
	lis 9,.LC2@ha
	la 5,vec3_origin@l(27)
	lfs 0,8(31)
	la 9,.LC2@l(9)
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
	bc 12,2,.L13
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
	bc 12,2,.L13
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
	bc 12,2,.L13
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
	b .L15
.L13:
	li 3,1
.L15:
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
.LC3:
	.string	"monster_medic"
	.align 2
.LC4:
	.string	"Cells"
	.align 3
.LC5:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC6:
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
	bc 12,2,.L47
	andi. 0,7,2
	lwz 24,84(31)
	bc 4,2,.L47
	cmpwi 4,24,0
	bc 12,18,.L29
	mr 3,31
	bl PowerArmorType
	mr. 29,3
	bc 12,2,.L47
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,24,748
	mullw 3,3,0
	srawi 23,3,3
	slwi 0,23,2
	lwzx 28,11,0
	b .L31
.L29:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L47
	lwz 29,1236(31)
	lwz 28,1240(31)
.L31:
	cmpwi 0,29,0
	bc 12,2,.L47
	cmpwi 0,28,0
	bc 12,2,.L47
	cmpwi 0,29,1
	bc 4,2,.L36
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
	lis 9,.LC5@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC5@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L47
	lis 0,0x5555
	srawi 9,30,31
	ori 0,0,21846
	li 27,1
	mulhw 0,30,0
	li 25,12
	subf 30,9,0
	b .L38
.L36:
	add 9,30,30
	lis 0,0x5555
	srawi 11,9,31
	ori 0,0,21846
	mulhw 9,9,0
	li 27,2
	li 25,13
	subf 30,11,9
.L38:
	mullw. 28,28,27
	bc 4,2,.L39
.L47:
	li 3,0
	b .L45
.L39:
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
	lis 11,.LC6@ha
	divw 10,28,27
	lfs 0,level+4@l(9)
	lfd 13,.LC6@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,776(31)
	bc 12,18,.L43
	slwi 11,23,2
	addi 9,24,748
	lwzx 0,9,11
	subf 0,10,0
	stwx 0,9,11
	b .L44
.L43:
	lwz 0,1240(31)
	subf 0,10,0
	stw 0,1240(31)
.L44:
	mr 3,28
.L45:
	lwz 0,100(1)
	lwz 12,52(1)
	mtlr 0
	lmw 22,56(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe2:
	.size	 CheckPowerArmor,.Lfe2-CheckPowerArmor
	.section	".rodata"
	.align 3
.LC7:
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
	mr. 31,6
	mr 9,3
	mr 27,4
	mr 25,5
	mr 26,7
	mr 29,8
	bc 12,2,.L56
	lwz 28,84(9)
	cmpwi 0,28,0
	bc 12,2,.L56
	andi. 0,29,2
	li 3,0
	bc 4,2,.L59
	mr 3,9
	bl ArmorIndex
	mr. 30,3
	li 3,0
	bc 12,2,.L59
	mr 3,30
	bl GetItemByIndex
	andi. 0,29,4
	bc 12,2,.L53
	xoris 11,31,0x8000
	lwz 10,60(3)
	stw 11,28(1)
	lis 0,0x4330
	lis 11,.LC7@ha
	stw 0,24(1)
	la 11,.LC7@l(11)
	lfd 0,24(1)
	lfd 13,0(11)
	lfs 1,12(10)
	b .L60
.L53:
	xoris 11,31,0x8000
	lwz 10,60(3)
	stw 11,28(1)
	lis 0,0x4330
	lis 11,.LC7@ha
	stw 0,24(1)
	la 11,.LC7@l(11)
	lfd 0,24(1)
	lfd 13,0(11)
	lfs 1,8(10)
.L60:
	fsub 0,0,13
	frsp 0,0
	fmuls 1,1,0
	bl ceil
	fctiwz 0,1
	stfd 0,24(1)
	lwz 10,28(1)
	slwi 3,30,2
	addi 8,28,748
	lwzx 11,8,3
	cmpw 7,10,11
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	andc 9,11,0
	and 0,10,0
	or. 31,0,9
	bc 12,2,.L56
	subf 0,31,11
	lis 29,gi@ha
	stwx 0,8,3
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
	b .L59
.L56:
	li 3,0
.L59:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 CheckArmor,.Lfe3-CheckArmor
	.section	".rodata"
	.align 2
.LC8:
	.string	"monster_tank"
	.align 2
.LC9:
	.string	"monster_supertank"
	.align 2
.LC10:
	.string	"monster_makron"
	.align 2
.LC11:
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
	bc 4,30,.L62
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L61
.L62:
	cmpw 0,30,31
	bc 12,2,.L61
	lwz 4,816(31)
	cmpw 0,30,4
	bc 12,2,.L61
	lwz 0,1128(31)
	andi. 11,0,256
	bc 12,2,.L65
	bc 4,30,.L61
	lwz 0,1128(30)
	andi. 9,0,256
	bc 4,2,.L61
.L65:
	bc 12,30,.L68
	cmpwi 0,4,0
	bc 12,2,.L73
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L73
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L70
	stw 30,820(31)
	b .L61
.L70:
	lwz 0,816(31)
	stw 0,820(31)
	b .L73
.L68:
	lwz 9,268(31)
	lwz 0,268(30)
	rlwinm 9,9,0,30,31
	rlwinm 0,0,0,30,31
	cmpw 0,9,0
	bc 4,2,.L72
	lwz 3,284(31)
	lwz 4,284(30)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L72
	lwz 3,284(30)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L72
	lwz 3,284(30)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L72
	lwz 3,284(30)
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L72
	lwz 3,284(30)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L72
	lwz 9,816(31)
	cmpwi 0,9,0
	bc 12,2,.L73
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L73
	stw 9,820(31)
.L73:
	lwz 0,1128(31)
	stw 30,816(31)
	andi. 9,0,2048
	bc 4,2,.L61
	mr 3,31
	bl FoundTarget
	b .L61
.L72:
	lwz 9,816(31)
	cmpwi 0,9,0
	bc 12,2,.L77
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L77
	stw 9,820(31)
.L77:
	lwz 0,1128(31)
	lwz 9,816(30)
	andi. 11,0,2048
	stw 9,816(31)
	bc 4,2,.L61
	mr 3,31
	bl FoundTarget
.L61:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 M_ReactToDamage,.Lfe4-M_ReactToDamage
	.section	".rodata"
	.align 2
.LC12:
	.string	"Leg damage\n"
	.align 2
.LC13:
	.string	"You shot %s in the legs\n"
	.align 2
.LC15:
	.string	"Stomach damage\n"
	.align 2
.LC16:
	.string	"You shot %s in the stomach\n"
	.align 2
.LC18:
	.string	"Chest damage\n"
	.align 2
.LC19:
	.string	"You shot %s in the chest\n"
	.align 2
.LC20:
	.string	"Head damage\n"
	.align 2
.LC21:
	.string	"You shot %s in the head\n"
	.align 2
.LC23:
	.string	"items/protect4.wav"
	.align 3
.LC14:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC17:
	.long 0x3ff19999
	.long 0x9999999a
	.align 3
.LC22:
	.long 0x407f4000
	.long 0x0
	.align 2
.LC24:
	.long 0x0
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC26:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC27:
	.long 0x40a00000
	.align 2
.LC28:
	.long 0x41700000
	.align 2
.LC29:
	.long 0x41a00000
	.align 2
.LC30:
	.long 0x42480000
	.align 3
.LC31:
	.long 0x40990000
	.long 0x0
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x40000000
	.align 2
.LC34:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl T_Damage
	.type	 T_Damage,@function
T_Damage:
	stwu 1,-608(1)
	mflr 0
	mfcr 12
	stmw 17,548(1)
	stw 0,612(1)
	stw 12,544(1)
	mr 31,3
	mr 17,4
	lwz 19,616(1)
	lwz 0,84(31)
	mr 26,5
	mr 25,6
	mr 24,7
	mr 18,8
	lwz 30,620(1)
	cmpwi 0,0,0
	mr 28,9
	mr 22,10
	bc 12,2,.L82
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 4,2,.L83
	lwz 0,912(31)
	xori 0,0,1
	srawi 8,0,31
	xor 9,8,0
	subf 9,9,8
	srawi 9,9,31
	and 28,28,9
.L83:
	xori 0,30,4
	subfic 9,0,0
	adde 0,9,0
	xori 27,30,36
	subfic 10,27,0
	adde 27,10,27
	or. 11,0,27
	bc 4,2,.L86
	cmpwi 0,30,34
	bc 4,2,.L82
.L86:
	lfs 0,8(24)
	lis 8,.LC24@ha
	lfs 13,12(31)
	la 8,.LC24@l(8)
	lfs 12,0(8)
	fsubs 13,0,13
	fcmpu 0,13,12
	bc 4,0,.L87
	xoris 11,28,0x8000
	stw 11,540(1)
	lis 0,0x4330
	lis 10,.LC25@ha
	stw 0,536(1)
	la 10,.LC25@l(10)
	lis 11,.LC26@ha
	lfd 0,536(1)
	la 11,.LC26@l(11)
	lis 5,.LC12@ha
	lfd 11,0(10)
	la 5,.LC12@l(5)
	mr 3,31
	lfd 12,0(11)
	li 4,2
	lis 11,gi@ha
	fsub 0,0,11
	la 29,gi@l(11)
	lwz 11,8(29)
	fmul 0,0,12
	mtlr 11
	fctiwz 13,0
	stfd 13,536(1)
	lwz 28,540(1)
	crxor 6,6,6
	blrl
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L82
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,26
	lwz 6,84(31)
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	addi 6,6,700
	crxor 6,6,6
	blrl
	xori 0,30,34
	subfic 8,0,0
	adde 0,8,0
	or. 9,27,0
	bc 12,2,.L82
	lwz 9,84(31)
	lwz 0,1844(9)
	srwi 11,0,31
	add 0,0,11
	srawi 0,0,1
	stw 0,1844(9)
	b .L82
.L87:
	lis 10,.LC27@ha
	la 10,.LC27@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L91
	xoris 11,28,0x8000
	stw 11,540(1)
	lis 0,0x4330
	lis 10,.LC14@ha
	lis 11,.LC25@ha
	stw 0,536(1)
	lis 5,.LC15@ha
	la 11,.LC25@l(11)
	lfd 0,536(1)
	la 5,.LC15@l(5)
	lfd 11,0(11)
	mr 3,31
	li 4,2
	lfd 12,.LC14@l(10)
	lis 11,gi@ha
	la 29,gi@l(11)
	fsub 0,0,11
	lwz 11,8(29)
	mtlr 11
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,536(1)
	lwz 28,540(1)
	crxor 6,6,6
	blrl
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L82
	lwz 6,84(31)
	lis 5,.LC16@ha
	mr 3,26
	lwz 0,8(29)
	la 5,.LC16@l(5)
	b .L160
.L91:
	lis 8,.LC28@ha
	la 8,.LC28@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,0,.L94
	xoris 11,28,0x8000
	stw 11,540(1)
	lis 0,0x4330
	lis 10,.LC25@ha
	stw 0,536(1)
	la 10,.LC25@l(10)
	lis 11,gi@ha
	lfd 11,0(10)
	la 29,gi@l(11)
	lis 5,.LC18@ha
	lfd 0,536(1)
	lis 10,.LC17@ha
	la 5,.LC18@l(5)
	lfd 12,.LC17@l(10)
	mr 3,31
	li 4,2
	lwz 11,8(29)
	fsub 0,0,11
	mtlr 11
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,536(1)
	lwz 28,540(1)
	crxor 6,6,6
	blrl
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L82
	lwz 6,84(31)
	lis 5,.LC19@ha
	mr 3,26
	lwz 0,8(29)
	la 5,.LC19@l(5)
.L160:
	li 4,2
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L82
.L94:
	lis 9,gi@ha
	lis 5,.LC20@ha
	la 29,gi@l(9)
	la 5,.LC20@l(5)
	lwz 9,8(29)
	mr 3,31
	li 4,2
	add 28,28,28
	mtlr 9
	crxor 6,6,6
	blrl
	lis 8,.LC29@ha
	lis 11,level+4@ha
	la 8,.LC29@l(8)
	lfs 0,level+4@l(11)
	lfs 12,0(8)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,536(1)
	lwz 9,540(1)
	stw 9,732(31)
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L82
	lwz 6,84(31)
	lis 5,.LC21@ha
	mr 3,26
	lwz 0,8(29)
	la 5,.LC21@l(5)
	li 4,2
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
.L82:
	lwz 0,788(31)
	cmpwi 0,0,0
	bc 12,2,.L81
	cmpw 0,31,26
	lwz 0,564(31)
	mfcr 27
	cmpwi 0,0,0
	bc 4,2,.L99
	lwz 9,908(31)
	lwz 0,908(26)
	cmpw 0,9,0
	bc 4,2,.L99
	lis 11,dmflags@ha
	lwz 9,dmflags@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,536(1)
	lwz 0,540(1)
	andi. 8,0,256
	bc 12,2,.L99
	mtcrf 128,27
	bc 12,2,.L102
	li 28,0
	b .L99
.L102:
	rlwinm 0,0,0,14,14
	neg 0,0
	srawi 0,0,31
	and 28,28,0
.L99:
	lwz 4,84(26)
	cmpwi 0,4,0
	bc 12,2,.L106
	lwz 0,1804(4)
	cmpwi 0,0,10
	bc 4,2,.L106
	lwz 9,908(26)
	addi 29,1,8
	li 0,0
	addi 4,4,188
	stw 0,952(26)
	mr 3,29
	stw 9,948(26)
	li 5,512
	crxor 6,6,6
	bl memcpy
	mr 4,29
	mr 3,26
	crxor 6,6,6
	bl ClientUserinfoChanged
.L106:
	mtcrf 128,27
	bc 12,2,.L108
	lis 9,deathmatch@ha
	lis 8,.LC24@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC24@l(8)
	lfs 12,0(8)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L110
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,536(1)
	lwz 11,540(1)
	andi. 9,11,192
	bc 4,2,.L109
.L110:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L108
.L109:
	mr 3,31
	mr 4,26
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L108
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,536(1)
	lwz 11,540(1)
	andi. 0,11,256
	bc 12,2,.L112
	li 28,0
	b .L108
.L112:
	oris 30,30,0x800
.L108:
	lis 11,skill@ha
	lis 8,.LC24@ha
	lwz 10,skill@l(11)
	la 8,.LC24@l(8)
	lis 9,meansOfDeath@ha
	lfs 13,0(8)
	lfs 0,20(10)
	stw 30,meansOfDeath@l(9)
	fcmpu 0,0,13
	bc 4,2,.L114
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L114
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L114
	xoris 11,28,0x8000
	stw 11,540(1)
	lis 0,0x4330
	lis 10,.LC25@ha
	stw 0,536(1)
	la 10,.LC25@l(10)
	lis 11,.LC26@ha
	lfd 0,536(1)
	la 11,.LC26@l(11)
	lfd 11,0(10)
	lfd 12,0(11)
	mr 11,9
	fsub 0,0,11
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,536(1)
	lwz 28,540(1)
	srawi 0,28,31
	xor 9,0,28
	subf 9,9,0
	srawi 9,9,31
	addi 0,9,1
	and 9,28,9
	or 28,9,0
.L114:
	andi. 8,19,16
	lwz 27,84(31)
	mr 3,25
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,9
	rlwinm 9,9,0,28,30
	or 21,0,9
	bl VectorNormalize
	andi. 0,19,1
	bc 4,2,.L118
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 0,816(31)
	cmpwi 0,0,0
	bc 4,2,.L118
	lwz 9,728(31)
	add 11,28,28
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,28,9
	or 28,9,11
.L118:
	andi. 0,19,8
	lwz 9,268(31)
	mcrf 7,0
	andi. 8,9,2048
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	and 20,22,0
	mr 22,20
	bc 4,30,.L120
	cmpwi 0,20,0
	bc 12,2,.L120
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 12,2,.L120
	cmpwi 0,0,9
	bc 12,2,.L120
	cmpwi 0,0,2
	bc 12,2,.L120
	cmpwi 0,0,3
	bc 12,2,.L120
	lwz 0,644(31)
	cmpwi 0,0,49
	bc 12,1,.L122
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	b .L123
.L122:
	xoris 0,0,0x8000
	stw 0,540(1)
	lis 11,0x4330
	lis 10,.LC25@ha
	la 10,.LC25@l(10)
	stw 11,536(1)
	lfd 13,0(10)
	lfd 0,536(1)
	fsub 0,0,13
	frsp 0,0
.L123:
	lwz 0,84(31)
	xor 11,26,31
	subfic 8,11,0
	adde 11,8,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,9,11
	bc 12,2,.L124
	xoris 0,22,0x8000
	fmr 11,0
	lis 9,0x4330
	stw 0,540(1)
	lis 8,.LC25@ha
	stw 9,536(1)
	la 8,.LC25@l(8)
	mr 3,25
	lfd 13,0(8)
	lis 9,.LC31@ha
	addi 4,1,520
	lfd 0,536(1)
	la 9,.LC31@l(9)
	lfd 12,0(9)
	fsub 0,0,13
	frsp 0,0
	fmr 1,0
	fmul 1,1,12
	fdiv 1,1,11
	frsp 1,1
	bl VectorScale
	b .L125
.L124:
	xoris 0,22,0x8000
	fmr 11,0
	stw 0,540(1)
	lis 9,0x4330
	lis 8,.LC25@ha
	la 8,.LC25@l(8)
	stw 9,536(1)
	lis 10,.LC22@ha
	lfd 12,0(8)
	mr 3,25
	addi 4,1,520
	lfd 0,536(1)
	lfd 13,.LC22@l(10)
	fsub 0,0,12
	frsp 0,0
	fmr 1,0
	fmul 1,1,13
	fdiv 1,1,11
	frsp 1,1
	bl VectorScale
.L125:
	lfs 11,520(1)
	lfs 10,524(1)
	lfs 9,528(1)
	lfs 0,620(31)
	lfs 13,624(31)
	lfs 12,628(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	stfs 0,620(31)
	stfs 13,624(31)
	stfs 12,628(31)
.L120:
	lwz 0,268(31)
	mr 30,28
	li 25,0
	andi. 8,0,16
	bc 12,2,.L126
	andi. 9,19,32
	bc 4,2,.L126
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	li 30,0
	lwz 9,100(29)
	mr 25,28
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,21
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,18
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,24
	li 4,2
	mtlr 0
	blrl
.L126:
	cmpwi 4,27,0
	bc 12,18,.L129
	lis 11,level@ha
	lfs 12,3880(27)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 8,.LC25@ha
	la 8,.LC25@l(8)
	la 23,level@l(11)
	xoris 0,0,0x8000
	lfd 13,0(8)
	stw 0,540(1)
	stw 10,536(1)
	lfd 0,536(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L129
	andi. 9,19,32
	bc 4,2,.L129
	lfs 13,708(31)
	lfs 0,4(23)
	fcmpu 0,13,0
	bc 4,0,.L130
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC32@ha
	lis 9,.LC32@ha
	lis 10,.LC24@ha
	la 8,.LC32@l(8)
	mr 5,3
	la 9,.LC32@l(9)
	lfs 1,0(8)
	mtlr 0
	la 10,.LC24@l(10)
	li 4,3
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC33@ha
	lfs 0,4(23)
	la 8,.LC33@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,708(31)
.L130:
	mr 25,28
	li 30,0
.L129:
	mr 6,30
	mr 7,19
	mr 4,24
	mr 5,18
	mr 3,31
	bl CheckPowerArmor
	mr 23,3
	mr 8,19
	subf 30,23,30
	mr 3,31
	mr 6,30
	mr 4,24
	mr 5,18
	mr 7,21
	bl CheckArmor
	mr 28,3
	subf 30,28,30
	cmpwi 0,30,0
	add 28,28,25
	bc 12,2,.L133
	lwz 0,184(31)
	addic 8,27,-1
	subfe 9,8,27
	rlwinm 0,0,30,31,31
	or. 10,0,9
	bc 12,2,.L134
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
	mr 3,24
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,18
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,24
	li 4,2
	mtlr 0
	blrl
	b .L137
.L134:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,21
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,18
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,24
	li 4,2
	mtlr 0
	blrl
.L137:
	lwz 0,728(31)
	subf 0,30,0
	cmpwi 0,0,0
	stw 0,728(31)
	bc 12,1,.L133
	lwz 0,184(31)
	addic 8,27,-1
	subfe 9,8,27
	rlwinm 0,0,30,31,31
	or. 10,0,9
	bc 12,2,.L141
	lwz 0,268(31)
	ori 0,0,2048
	stw 0,268(31)
.L141:
	lwz 0,728(31)
	cmpwi 0,0,-999
	bc 4,0,.L142
	li 0,-999
	stw 0,728(31)
.L142:
	lwz 0,184(31)
	stw 26,816(31)
	andi. 11,0,4
	bc 12,2,.L143
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L143
	lwz 0,1128(31)
	andi. 8,0,256
	bc 4,2,.L143
	lis 9,coop@ha
	lis 11,level@ha
	lwz 10,coop@l(9)
	la 11,level@l(11)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 13,0(9)
	lwz 9,288(11)
	addi 9,9,1
	stw 9,288(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 12,2,.L145
	lwz 11,84(26)
	cmpwi 0,11,0
	bc 12,2,.L145
	lwz 9,3560(11)
	addi 9,9,1
	stw 9,3560(11)
.L145:
	lwz 3,284(26)
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L143
	stw 26,256(31)
.L143:
	lwz 9,264(31)
	addi 0,9,-2
	subfic 8,9,0
	adde 9,8,9
	subfic 0,0,1
	li 0,0
	adde 0,0,0
	or. 9,0,9
	bc 4,2,.L149
	lwz 0,184(31)
	andi. 8,0,4
	bc 12,2,.L149
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L149
	stw 9,688(31)
	mr 3,31
	bl monster_death_use
.L149:
	lwz 0,700(31)
	mr 3,31
	mr 4,17
	mr 5,26
	mr 6,30
	mr 7,24
	mtlr 0
	blrl
	b .L81
.L133:
	lwz 0,184(31)
	andi. 8,0,4
	bc 12,2,.L150
	mr 3,31
	mr 4,26
	bl M_ReactToDamage
	lwz 0,1128(31)
	addic 8,30,-1
	subfe 9,8,30
	xori 0,0,2048
	rlwinm 0,0,21,31,31
	and. 10,0,9
	bc 12,2,.L153
	xoris 11,22,0x8000
	lwz 10,696(31)
	stw 11,540(1)
	lis 0,0x4330
	mr 4,26
	lis 11,.LC25@ha
	stw 0,536(1)
	mr 3,31
	mtlr 10
	la 11,.LC25@l(11)
	lfd 1,536(1)
	mr 5,30
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	blrl
	lis 11,skill@ha
	lis 8,.LC34@ha
	lwz 9,skill@l(11)
	la 8,.LC34@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L153
	lis 10,.LC27@ha
	lis 9,level+4@ha
	la 10,.LC27@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,708(31)
	b .L153
.L150:
	bc 12,18,.L154
	lwz 0,268(31)
	addic 11,30,-1
	subfe 9,11,30
	xori 0,0,16
	rlwinm 0,0,28,31,31
	and. 8,0,9
	bc 12,2,.L153
	xoris 11,22,0x8000
	lwz 10,696(31)
	stw 11,540(1)
	lis 0,0x4330
	mr 3,31
	lis 11,.LC25@ha
	stw 0,536(1)
	mr 4,26
	mtlr 10
	la 11,.LC25@l(11)
	lfd 1,536(1)
	mr 5,30
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	blrl
	b .L153
.L154:
	cmpwi 0,30,0
	bc 12,2,.L153
	lwz 10,696(31)
	cmpwi 0,10,0
	bc 12,2,.L153
	xoris 0,22,0x8000
	mtlr 10
	stw 0,540(1)
	lis 11,0x4330
	lis 8,.LC25@ha
	la 8,.LC25@l(8)
	stw 11,536(1)
	mr 3,31
	lfd 0,0(8)
	mr 4,26
	mr 5,30
	lfd 1,536(1)
	fsub 1,1,0
	frsp 1,1
	blrl
.L153:
	bc 12,18,.L81
	lwz 0,3656(27)
	lwz 11,3652(27)
	lwz 10,3660(27)
	add 0,0,23
	lwz 9,3664(27)
	add 11,11,28
	add 10,10,30
	stw 0,3656(27)
	add 9,9,20
	stw 11,3652(27)
	stw 10,3660(27)
	stw 9,3664(27)
	lfs 0,0(24)
	stfs 0,3668(27)
	lfs 13,4(24)
	stfs 13,3672(27)
	lfs 0,8(24)
	stfs 0,3676(27)
.L81:
	lwz 0,612(1)
	lwz 12,544(1)
	mtlr 0
	lmw 17,548(1)
	mtcrf 8,12
	la 1,608(1)
	blr
.Lfe5:
	.size	 T_Damage,.Lfe5-T_Damage
	.section	".rodata"
	.align 2
.LC35:
	.long 0x3f000000
	.align 3
.LC36:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC37:
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
	b .L162
.L164:
	cmpw 0,31,26
	bc 12,2,.L162
	lwz 0,788(31)
	cmpwi 0,0,0
	bc 12,2,.L162
	lfs 0,200(31)
	lis 9,.LC35@ha
	addi 4,1,16
	lfs 13,188(31)
	la 9,.LC35@l(9)
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
	lis 9,.LC36@ha
	cmpw 0,31,28
	la 9,.LC36@l(9)
	fmr 0,29
	lfd 11,0(9)
	fmul 1,1,11
	fsub 0,0,1
	frsp 31,0
	bc 4,2,.L167
	fmr 0,31
	fmul 0,0,11
	frsp 31,0
.L167:
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,1,.L162
	mr 3,31
	mr 4,30
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L162
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
.L162:
	fmr 1,30
	mr 3,31
	mr 4,29
	bl findradius
	mr. 31,3
	bc 4,2,.L164
	lwz 0,116(1)
	mtlr 0
	lmw 26,64(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe6:
	.size	 T_RadiusDamage,.Lfe6-T_RadiusDamage
	.section	".rodata"
	.align 2
.LC38:
	.long 0x0
	.section	".text"
	.align 2
	.globl Killed
	.type	 Killed,@function
Killed:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 29,4
	lwz 0,728(31)
	mr 30,5
	mr 28,6
	mr 27,7
	cmpwi 0,0,-999
	bc 4,0,.L17
	li 0,-999
	stw 0,728(31)
.L17:
	lwz 0,184(31)
	stw 30,816(31)
	andi. 9,0,4
	bc 12,2,.L18
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L18
	lwz 0,1128(31)
	andi. 11,0,256
	bc 4,2,.L18
	lis 9,coop@ha
	lis 11,level@ha
	lwz 10,coop@l(9)
	la 11,level@l(11)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 13,0(9)
	lwz 9,288(11)
	addi 9,9,1
	stw 9,288(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 12,2,.L20
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L20
	lwz 9,3560(11)
	addi 9,9,1
	stw 9,3560(11)
.L20:
	lwz 3,284(30)
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L18
	stw 30,256(31)
.L18:
	lwz 9,264(31)
	addi 0,9,-2
	subfic 11,9,0
	adde 9,11,9
	subfic 0,0,1
	li 0,0
	adde 0,0,0
	or. 9,0,9
	bc 12,2,.L22
	lwz 0,700(31)
	mr 3,31
	mr 4,29
	mr 5,30
	mr 6,28
	mr 7,27
	mtlr 0
	blrl
	b .L16
.L22:
	lwz 0,184(31)
	andi. 11,0,4
	bc 12,2,.L23
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L23
	stw 9,688(31)
	mr 3,31
	bl monster_death_use
.L23:
	lwz 0,700(31)
	mr 3,31
	mr 4,29
	mr 5,30
	mr 6,28
	mr 7,27
	mtlr 0
	blrl
.L16:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Killed,.Lfe7-Killed
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
.Lfe8:
	.size	 SpawnDamage,.Lfe8-SpawnDamage
	.align 2
	.globl CheckTeamDamage
	.type	 CheckTeamDamage,@function
CheckTeamDamage:
	li 3,0
	blr
.Lfe9:
	.size	 CheckTeamDamage,.Lfe9-CheckTeamDamage
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
