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
	lwz 0,260(31)
	cmpwi 0,0,2
	bc 4,2,.L8
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
	lis 11,.LC1@ha
	la 11,.LC1@l(11)
	lfd 30,0(11)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,30
	bc 12,2,.L14
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
.LC3:
	.string	"monster_carrier"
	.align 2
.LC4:
	.string	"monster_medic_commander"
	.align 2
.LC5:
	.string	"monster_widow"
	.align 2
.LC6:
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
	lwz 0,480(31)
	mr 30,5
	mr 28,6
	mr 27,7
	cmpwi 0,0,-999
	bc 4,0,.L18
	li 0,-999
	stw 0,480(31)
.L18:
	lwz 0,776(31)
	andi. 9,0,8192
	bc 12,2,.L19
	lwz 10,540(31)
	cmpwi 0,10,0
	bc 12,2,.L20
	lwz 0,776(10)
	li 9,0
	li 11,1
	stw 9,916(10)
	mr 3,10
	rlwinm 0,0,0,18,16
	stw 11,512(10)
	stw 0,776(10)
	bl M_SetEffects
.L20:
	lwz 0,776(31)
	stw 30,540(31)
	rlwinm 0,0,0,19,17
	stw 0,776(31)
	b .L22
.L19:
	stw 30,540(31)
.L22:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L23
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L23
	lwz 0,776(31)
	andis. 11,0,128
	bc 12,2,.L24
	lwz 9,976(31)
	cmpwi 0,9,0
	bc 12,2,.L24
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L24
	lwz 3,280(9)
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L24
	lwz 11,976(31)
	lwz 9,968(11)
	addi 9,9,1
	stw 9,968(11)
.L24:
	lwz 0,776(31)
	andis. 9,0,256
	bc 12,2,.L26
	lwz 9,976(31)
	cmpwi 0,9,0
	bc 12,2,.L26
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 3,280(9)
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L26
	lwz 11,976(31)
	lwz 9,968(11)
	addi 9,9,1
	stw 9,968(11)
.L26:
	lwz 0,776(31)
	andis. 9,0,512
	bc 12,2,.L29
	lwz 9,976(31)
	cmpwi 0,9,0
	bc 12,2,.L29
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L29
	lwz 3,280(9)
	lis 4,.LC5@ha
	li 5,13
	la 4,.LC5@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L29
	lwz 11,976(31)
	lwz 9,972(11)
	cmpwi 0,9,0
	bc 4,1,.L29
	addi 0,9,-1
	stw 0,972(11)
.L29:
	lwz 9,776(31)
	lis 0,0x40
	ori 0,0,256
	and. 11,9,0
	bc 4,2,.L23
	lis 9,coop@ha
	lis 11,level@ha
	lwz 10,coop@l(9)
	la 11,level@l(11)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,288(11)
	addi 9,9,1
	stw 9,288(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 12,2,.L23
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L23
	lwz 9,4544(11)
	addi 9,9,1
	stw 9,4544(11)
.L23:
	lwz 9,260(31)
	addi 0,9,-2
	subfic 11,9,0
	adde 9,11,9
	subfic 0,0,1
	li 0,0
	adde 0,0,0
	or. 9,0,9
	bc 12,2,.L34
	lwz 0,456(31)
	mr 3,31
	mr 4,29
	mr 5,30
	mr 6,28
	mr 7,27
	mtlr 0
	blrl
	b .L17
.L34:
	lwz 0,184(31)
	andi. 11,0,4
	bc 12,2,.L35
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L35
	stw 9,444(31)
	mr 3,31
	bl monster_death_use
.L35:
	lwz 0,456(31)
	mr 3,31
	mr 4,29
	mr 5,30
	mr 6,28
	mr 7,27
	mtlr 0
	blrl
.L17:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Killed,.Lfe2-Killed
	.section	".rodata"
	.align 3
.LC7:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC8:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 CheckPowerArmor,@function
CheckPowerArmor:
	stwu 1,-80(1)
	mflr 0
	stmw 24,48(1)
	stw 0,84(1)
	mr. 31,6
	mr 30,3
	mr 26,4
	mr 24,5
	bc 12,2,.L50
	andi. 0,7,258
	lwz 0,84(30)
	bc 4,2,.L50
	cmpwi 0,0,0
	bc 4,2,.L50
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L50
	lwz 0,884(30)
	lwz 29,888(30)
	cmpwi 0,0,0
	bc 12,2,.L50
	cmpwi 0,29,0
	bc 12,2,.L50
	cmpwi 0,0,1
	bc 4,2,.L47
	addi 3,30,16
	addi 4,1,24
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 11,4(30)
	addi 3,1,8
	lfs 12,0(26)
	lfs 10,8(30)
	lfs 13,4(26)
	fsubs 12,12,11
	lfs 0,8(26)
	lfs 11,12(30)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorNormalize
	lfs 0,28(1)
	lis 9,.LC7@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC7@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L50
	lis 0,0x5555
	srawi 9,31,31
	ori 0,0,21846
	li 27,1
	mulhw 0,31,0
	li 25,12
	subf 31,9,0
	b .L49
.L47:
	add 9,31,31
	lis 0,0x5555
	srawi 11,9,31
	ori 0,0,21846
	mulhw 9,9,0
	li 27,2
	li 25,13
	subf 31,11,9
.L49:
	mullw. 9,29,27
	bc 12,2,.L50
	cmpw 7,9,31
	lis 28,gi@ha
	la 28,gi@l(28)
	li 3,3
	lwz 11,100(28)
	cror 31,30,28
	mfcr 29
	rlwinm 29,29,0,1
	mtlr 11
	neg 29,29
	andc 0,31,29
	and 29,9,29
	or 29,29,0
	blrl
	lwz 9,100(28)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,120(28)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(28)
	mr 3,24
	mtlr 9
	blrl
	lwz 0,88(28)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	divw 10,29,27
	lis 9,level+4@ha
	lis 11,.LC8@ha
	lwz 0,888(30)
	lfs 0,level+4@l(9)
	mr 3,29
	lfd 13,.LC8@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,500(30)
	subf 0,10,0
	stw 0,888(30)
	b .L54
.L50:
	li 3,0
.L54:
	lwz 0,84(1)
	mtlr 0
	lmw 24,48(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 CheckPowerArmor,.Lfe3-CheckPowerArmor
	.section	".rodata"
	.align 3
.LC9:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC11:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC12:
	.long 0x46fffe00
	.align 3
.LC13:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC15:
	.long 0xbfd33333
	.long 0x33333333
	.align 3
.LC16:
	.long 0x3fd47ae1
	.long 0x47ae147b
	.align 2
.LC17:
	.long 0x41100000
	.align 2
.LC18:
	.long 0x0
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CalcHitLoc
	.type	 CalcHitLoc,@function
CalcHitLoc:
	stwu 1,-144(1)
	mflr 0
	stfd 28,112(1)
	stfd 29,120(1)
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 30,104(1)
	stw 0,148(1)
	mr 31,3
	lis 9,hit_loc@ha
	lwz 11,480(31)
	li 0,0
	mr 30,5
	stw 0,hit_loc@l(9)
	cmpwi 0,11,0
	bc 4,1,.L55
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L55
	cmpwi 0,7,22
	li 0,128
	bc 12,2,.L92
	addi 0,7,-18
	cmplwi 0,0,1
	bc 12,1,.L58
	lwz 3,612(31)
	cmpwi 0,3,0
	bc 4,1,.L62
	li 0,128
	stw 0,hit_loc@l(9)
.L62:
	cmpwi 0,3,1
	bc 4,1,.L63
	lwz 0,hit_loc@l(9)
	ori 0,0,96
	stw 0,hit_loc@l(9)
.L63:
	cmpwi 0,3,2
	bc 4,1,.L55
	lwz 0,hit_loc@l(9)
	ori 0,0,272
	b .L92
.L58:
	addi 3,31,16
	addi 4,1,8
	addi 5,1,24
	addi 6,1,40
	bl AngleVectors
	lwz 9,84(31)
	li 0,0
	stw 0,32(1)
	cmpwi 0,9,0
	stw 0,16(1)
	bc 12,2,.L65
	lbz 0,16(9)
	andi. 9,0,1
	bc 12,2,.L65
	lis 11,.LC17@ha
	lfs 11,12(31)
	la 11,.LC17@l(11)
	lfs 12,8(30)
	lfs 0,0(11)
	lfs 10,4(31)
	lfs 9,8(31)
	fsubs 11,11,0
	lfs 13,4(30)
	lfs 0,0(30)
	stfs 10,56(1)
	fsubs 12,12,11
	stfs 9,60(1)
	fsubs 0,0,10
	stfs 11,64(1)
	fsubs 13,13,9
	stfs 12,80(1)
	stfs 0,72(1)
	stfs 13,76(1)
	b .L66
.L65:
	lfs 11,12(31)
	lfs 13,8(30)
	lfs 12,0(30)
	lfs 10,4(31)
	fsubs 13,13,11
	lfs 0,4(30)
	lfs 11,8(31)
	fsubs 12,12,10
	stfs 13,80(1)
	fsubs 0,0,11
	stfs 12,72(1)
	stfs 0,76(1)
.L66:
	addi 3,1,72
	bl VectorNormalize
	lfs 11,76(1)
	lis 9,.LC9@ha
	lfs 0,44(1)
	lfs 10,72(1)
	lfs 13,40(1)
	fmuls 0,11,0
	lfs 8,80(1)
	lfs 7,48(1)
	lfs 12,12(1)
	fmadds 13,10,13,0
	lfs 9,28(1)
	lfd 6,.LC9@l(9)
	fmuls 12,11,12
	lfs 0,8(1)
	fmadds 30,8,7,13
	fmuls 11,11,9
	lfs 7,24(1)
	fmadds 0,10,0,12
	lfs 9,16(1)
	fmr 13,30
	lfs 12,32(1)
	fmadds 10,10,7,11
	fmadds 28,8,9,0
	fcmpu 0,13,6
	fmadds 29,8,12,10
	bc 4,1,.L67
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,16
	b .L93
.L67:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,30,0
	cror 3,2,1
	bc 4,3,.L72
	lis 9,.LC11@ha
	fmr 0,29
	lfd 13,.LC11@l(9)
	fmr 31,0
	fcmpu 0,0,13
	bc 4,1,.L73
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,100(1)
	lis 11,.LC19@ha
	lis 10,.LC12@ha
	la 11,.LC19@l(11)
	stw 0,96(1)
	lfd 13,0(11)
	lfd 0,96(1)
	lis 11,.LC13@ha
	lfs 11,.LC12@l(10)
	lfd 12,.LC13@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L73
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,256
	b .L93
.L73:
	lis 9,.LC15@ha
	lfd 0,.LC15@l(9)
	fcmpu 0,31,0
	bc 4,0,.L76
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,100(1)
	lis 11,.LC19@ha
	lis 10,.LC12@ha
	la 11,.LC19@l(11)
	stw 0,96(1)
	lfd 13,0(11)
	lfd 0,96(1)
	lis 11,.LC13@ha
	lfs 11,.LC12@l(10)
	lfd 12,.LC13@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L76
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,256
	b .L93
.L76:
	lis 9,.LC16@ha
	fmr 13,30
	lfd 0,.LC16@l(9)
	fcmpu 0,13,0
	bc 4,1,.L79
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,32
	b .L93
.L79:
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,64
	b .L93
.L72:
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,128
.L93:
	stw 0,hit_loc@l(9)
	lis 9,.LC15@ha
	fmr 13,28
	lfd 0,.LC15@l(9)
	fcmpu 0,13,0
	bc 4,0,.L86
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,8
	b .L94
.L86:
	lis 9,.LC11@ha
	lfd 0,.LC11@l(9)
	fcmpu 0,13,0
	bc 4,1,.L87
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,1
.L94:
	stw 0,hit_loc@l(9)
.L87:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,29,0
	bc 4,0,.L89
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,2
	b .L92
.L89:
	bc 4,1,.L55
	lis 9,hit_loc@ha
	lwz 0,hit_loc@l(9)
	ori 0,0,4
.L92:
	stw 0,hit_loc@l(9)
.L55:
	lwz 0,148(1)
	mtlr 0
	lmw 30,104(1)
	lfd 28,112(1)
	lfd 29,120(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe4:
	.size	 CalcHitLoc,.Lfe4-CalcHitLoc
	.globl jacketarmor_info
	.section	".data"
	.align 2
	.type	 jacketarmor_info,@object
	.size	 jacketarmor_info,20
jacketarmor_info:
	.long 25
	.long 50
	.long 0x3e99999a
	.long 0x0
	.long 1
	.globl combatarmor_info
	.align 2
	.type	 combatarmor_info,@object
	.size	 combatarmor_info,20
combatarmor_info:
	.long 50
	.long 100
	.long 0x3f19999a
	.long 0x3e99999a
	.long 2
	.globl bodyarmor_info
	.align 2
	.type	 bodyarmor_info,@object
	.size	 bodyarmor_info,20
bodyarmor_info:
	.long 100
	.long 200
	.long 0x3f4ccccd
	.long 0x3f19999a
	.long 3
	.section	".rodata"
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 CheckArmor,@function
CheckArmor:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	mr. 28,7
	mr 25,3
	mr 26,4
	mr 30,5
	mr 23,6
	mr 24,8
	mr 31,9
	bc 12,2,.L127
	lwz 29,84(26)
	cmpwi 0,29,0
	bc 12,2,.L127
	andi. 0,31,2
	bc 4,2,.L127
	slwi 0,25,2
	addi 9,29,1848
	lwzx 3,9,0
	mr 27,0
	bl GetItemByTag
	mr. 3,3
	bc 4,2,.L107
.L127:
	li 3,0
	b .L124
.L107:
	lwz 3,20(3)
	li 10,0
	cmpwi 0,3,48
	bc 12,2,.L108
	bc 12,1,.L109
	cmpwi 0,3,47
	bc 12,2,.L110
	b .L113
.L109:
	cmpwi 0,3,49
	bc 12,2,.L112
	b .L113
.L110:
	lis 9,jacketarmor_info@ha
	la 10,jacketarmor_info@l(9)
	b .L113
.L108:
	lis 9,combatarmor_info@ha
	la 10,combatarmor_info@l(9)
	b .L113
.L112:
	lis 9,bodyarmor_info@ha
	la 10,bodyarmor_info@l(9)
.L113:
	andi. 0,31,4
	bc 12,2,.L115
	xoris 11,28,0x8000
	lfs 1,12(10)
	b .L126
.L115:
	xoris 11,28,0x8000
	lfs 1,8(10)
.L126:
	stw 11,20(1)
	lis 0,0x4330
	lis 11,.LC20@ha
	stw 0,16(1)
	la 11,.LC20@l(11)
	lfd 0,16(1)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	fmuls 1,1,0
	bl ceil
	fctiwz 0,1
	stfd 0,16(1)
	lwz 10,20(1)
	addi 8,29,1976
	lwzx 11,8,27
	cmpw 7,10,11
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	andc 9,11,0
	and 0,10,0
	or. 31,0,9
	bc 12,2,.L127
	subf 0,31,11
	cmpwi 0,0,0
	stwx 0,8,27
	bc 12,1,.L119
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,23
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	mr 3,26
	mr 4,25
	bl RemoveItem
.L119:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,23
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	mr 3,31
.L124:
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 CheckArmor,.Lfe5-CheckArmor
	.section	".rodata"
	.align 2
.LC21:
	.string	"tesla"
	.align 3
.LC22:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC24:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl M_ReactToDamage
	.type	 M_ReactToDamage,@function
M_ReactToDamage:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,4
	mr 31,3
	lwz 0,84(29)
	mr 30,5
	cmpwi 0,0,0
	bc 4,2,.L129
	lwz 0,184(29)
	andi. 7,0,4
	bc 12,2,.L128
.L129:
	cmpwi 0,30,0
	bc 12,2,.L130
	lwz 3,280(30)
	lis 4,.LC21@ha
	la 4,.LC21@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L130
	mr 3,31
	mr 4,30
	bl MarkTeslaArea
	cmpwi 0,3,0
	bc 12,2,.L128
	mr 3,31
	mr 4,30
	bl TargetTesla
	b .L128
.L130:
	cmpw 0,29,31
	bc 12,2,.L128
	lwz 9,540(31)
	cmpw 0,29,9
	bc 12,2,.L128
	lwz 6,776(31)
	andi. 0,6,256
	mr 11,6
	bc 12,2,.L134
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 4,2,.L128
	lwz 0,776(29)
	andi. 7,0,256
	bc 4,2,.L128
.L134:
	cmpwi 0,9,0
	bc 12,2,.L140
	andis. 8,11,2
	bc 12,2,.L137
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L138
	lwz 0,480(31)
	lis 8,0x4330
	lwz 9,484(31)
	mr 10,11
	lis 7,.LC23@ha
	xoris 0,0,0x8000
	la 7,.LC23@l(7)
	stw 0,28(1)
	xoris 9,9,0x8000
	stw 8,24(1)
	lfd 0,24(1)
	stw 9,28(1)
	stw 8,24(1)
	lfd 12,0(7)
	lfd 13,24(1)
	lis 7,.LC22@ha
	lfd 11,.LC22@l(7)
	fsub 0,0,12
	fsub 13,13,12
	frsp 0,0
	frsp 13,13
	fdivs 0,0,13
	fmr 12,0
	fcmpu 0,12,11
	bc 12,1,.L128
.L138:
	rlwinm 0,6,0,15,13
	stw 0,776(31)
.L137:
	lwz 6,540(31)
	cmpwi 0,6,0
	bc 12,2,.L140
	lwz 5,776(31)
	andi. 8,5,8192
	bc 12,2,.L140
	lwz 0,480(31)
	lis 7,0x4330
	lwz 9,484(31)
	mr 10,11
	lis 8,.LC23@ha
	xoris 0,0,0x8000
	la 8,.LC23@l(8)
	stw 0,28(1)
	xoris 9,9,0x8000
	stw 7,24(1)
	lfd 13,24(1)
	stw 9,28(1)
	stw 7,24(1)
	lfd 12,0(8)
	lfd 0,24(1)
	lwz 8,88(6)
	fsub 13,13,12
	fsub 0,0,12
	cmpwi 0,8,0
	frsp 13,13
	frsp 0,0
	fdivs 13,13,0
	bc 12,2,.L141
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L128
.L141:
	rlwinm 0,5,0,19,17
	li 9,0
	stw 0,776(31)
	li 11,1
	mr 3,6
	lwz 0,776(6)
	stw 9,916(6)
	rlwinm 0,0,0,18,16
	stw 11,512(6)
	stw 0,776(6)
	bl M_SetEffects
.L140:
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L143
	lwz 4,540(31)
	lwz 0,776(31)
	cmpwi 0,4,0
	rlwinm 0,0,0,30,28
	stw 0,776(31)
	bc 12,2,.L152
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L152
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L145
	stw 29,544(31)
	b .L128
.L145:
	lwz 0,540(31)
	stw 0,544(31)
	b .L152
.L143:
	lwz 9,264(31)
	lwz 0,264(29)
	rlwinm 9,9,0,30,31
	rlwinm 0,0,0,30,31
	cmpw 0,9,0
	bc 4,2,.L147
	lwz 3,280(31)
	lwz 4,280(29)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L147
	lwz 0,776(29)
	andis. 7,0,32
	bc 4,2,.L147
	lwz 0,776(31)
	andis. 8,0,32
	bc 4,2,.L147
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L148
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L148
	stw 9,544(31)
.L148:
	lwz 0,776(31)
	stw 29,540(31)
	andi. 9,0,2048
	b .L158
.L147:
	lwz 0,540(29)
	cmpw 7,0,31
	bc 4,30,.L151
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L152
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L152
	stw 9,544(31)
.L152:
	lwz 0,776(31)
	stw 29,540(31)
	andi. 7,0,2048
.L158:
	bc 4,2,.L128
	mr 3,31
	bl FoundTarget
	b .L128
.L151:
	cmpwi 0,0,0
	bc 12,2,.L128
	bc 12,30,.L128
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L156
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L156
	stw 9,544(31)
.L156:
	lwz 0,776(31)
	lwz 9,540(29)
	andi. 7,0,2048
	stw 9,540(31)
	bc 4,2,.L128
	mr 3,31
	bl FoundTarget
.L128:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 M_ReactToDamage,.Lfe6-M_ReactToDamage
	.section	".rodata"
	.align 2
.LC27:
	.string	"items/protect4.wav"
	.align 3
.LC25:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC26:
	.long 0x407f4000
	.long 0x0
	.align 2
.LC28:
	.long 0x46fffe00
	.align 2
.LC29:
	.long 0x0
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC31:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC32:
	.long 0x42480000
	.align 3
.LC33:
	.long 0x40990000
	.long 0x0
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x40000000
	.align 2
.LC36:
	.long 0x42700000
	.align 2
.LC37:
	.long 0x40400000
	.align 2
.LC38:
	.long 0x40a00000
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
	mr 15,4
	lwz 24,136(1)
	lwz 0,1016(31)
	mr 20,5
	mr 17,6
	mr 25,7
	mr 27,8
	lwz 23,140(1)
	cmpwi 0,0,0
	mr 28,9
	mr 18,10
	bc 12,2,.L161
	lwz 0,324(31)
	cmpwi 0,0,0
	bc 12,2,.L161
	lwz 0,184(20)
	andi. 8,0,4
	bc 12,2,.L162
	stw 30,540(20)
.L162:
	lwz 30,324(31)
	mr 3,30
	crxor 6,6,6
	bl EndCoopView
	stw 24,8(1)
	mr 3,30
	mr 4,15
	stw 23,12(1)
	mr 5,20
	mr 6,17
	mr 7,25
	mr 8,27
	mr 9,28
	mr 10,18
	bl T_Damage
	b .L160
.L161:
	lis 9,sv_edit@ha
	lis 8,.LC29@ha
	lwz 11,sv_edit@l(9)
	la 8,.LC29@l(8)
	lfs 12,0(8)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 4,2,.L160
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L160
	cmpw 0,31,20
	bc 12,2,.L165
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L167
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 11,44(1)
	andi. 9,11,192
	bc 4,2,.L166
.L167:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L165
.L166:
	mr 3,31
	mr 4,20
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L165
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 11,44(1)
	andi. 0,11,256
	bc 12,2,.L169
	li 28,0
	b .L165
.L169:
	oris 23,23,0x800
.L165:
	lis 11,skill@ha
	lis 8,.LC29@ha
	lwz 10,skill@l(11)
	la 8,.LC29@l(8)
	lis 9,meansOfDeath@ha
	lfs 13,0(8)
	lfs 0,20(10)
	stw 23,meansOfDeath@l(9)
	fcmpu 0,0,13
	bc 4,2,.L171
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L171
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L171
	xoris 11,28,0x8000
	stw 11,44(1)
	lis 0,0x4330
	lis 10,.LC30@ha
	stw 0,40(1)
	la 10,.LC30@l(10)
	lis 11,.LC31@ha
	lfd 0,40(1)
	la 11,.LC31@l(11)
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
.L171:
	andi. 8,24,16
	lwz 22,84(31)
	mr 3,17
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,9
	rlwinm 9,9,0,28,30
	or 26,0,9
	bl VectorNormalize
	andi. 0,24,1
	bc 4,2,.L175
	lwz 0,184(31)
	andi. 8,0,4
	bc 12,2,.L175
	lwz 0,84(20)
	cmpwi 0,0,0
	bc 12,2,.L175
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L175
	lwz 9,480(31)
	add 11,28,28
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,28,9
	or 28,9,11
.L175:
	cmpwi 0,23,40
	cmpwi 7,23,42
	mcrf 3,0
	mfcr 0
	rlwinm 9,0,3,1
	rlwinm 0,0,31,1
	mcrf 2,7
	or. 10,9,0
	bc 4,2,.L177
	xori 9,23,41
	subfic 11,9,0
	adde 9,11,9
	xori 0,23,43
	subfic 8,0,0
	adde 0,8,0
	or. 10,9,0
	bc 12,2,.L176
.L177:
	lwz 0,264(31)
	ori 24,24,10
	andis. 11,0,2
	bc 12,2,.L178
	add 28,28,28
	b .L176
.L178:
	xoris 11,28,0x8000
	stw 11,44(1)
	lis 0,0x4330
	lis 8,.LC30@ha
	stw 0,40(1)
	la 8,.LC30@l(8)
	lis 11,.LC25@ha
	lfd 0,40(1)
	mr 10,9
	lfd 11,0(8)
	lfd 13,.LC25@l(11)
	fsub 0,0,11
	fmul 0,0,13
	fctiwz 12,0
	stfd 12,40(1)
	lwz 28,44(1)
.L176:
	andi. 0,24,8
	lwz 9,264(31)
	mcrf 7,0
	andi. 8,9,2048
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	and 14,18,0
	mr 18,14
	bc 4,30,.L181
	cmpwi 0,14,0
	bc 12,2,.L181
	lwz 0,260(31)
	cmpwi 0,0,0
	bc 12,2,.L181
	cmpwi 0,0,9
	bc 12,2,.L181
	cmpwi 0,0,2
	bc 12,2,.L181
	cmpwi 0,0,3
	bc 12,2,.L181
	lwz 0,400(31)
	cmpwi 0,0,49
	bc 12,1,.L183
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 0,0(9)
	b .L184
.L183:
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 10,.LC30@ha
	la 10,.LC30@l(10)
	stw 11,40(1)
	lfd 13,0(10)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
.L184:
	lwz 0,84(31)
	xor 11,20,31
	subfic 8,11,0
	adde 11,8,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,9,11
	bc 12,2,.L185
	xoris 0,18,0x8000
	fmr 11,0
	lis 9,0x4330
	stw 0,44(1)
	lis 8,.LC30@ha
	stw 9,40(1)
	la 8,.LC30@l(8)
	mr 3,17
	lfd 13,0(8)
	lis 9,.LC33@ha
	addi 4,1,16
	lfd 0,40(1)
	la 9,.LC33@l(9)
	lfd 12,0(9)
	fsub 0,0,13
	frsp 0,0
	fmr 1,0
	fmul 1,1,12
	fdiv 1,1,11
	frsp 1,1
	bl VectorScale
	b .L186
.L185:
	xoris 0,18,0x8000
	fmr 11,0
	stw 0,44(1)
	lis 9,0x4330
	lis 8,.LC30@ha
	la 8,.LC30@l(8)
	stw 9,40(1)
	lis 10,.LC26@ha
	lfd 12,0(8)
	mr 3,17
	addi 4,1,16
	lfd 0,40(1)
	lfd 13,.LC26@l(10)
	fsub 0,0,12
	frsp 0,0
	fmr 1,0
	fmul 1,1,13
	fdiv 1,1,11
	frsp 1,1
	bl VectorScale
.L186:
	lfs 11,16(1)
	lfs 10,20(1)
	lfs 9,24(1)
	lfs 0,376(31)
	lfs 13,380(31)
	lfs 12,384(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	stfs 0,376(31)
	stfs 13,380(31)
	stfs 12,384(31)
.L181:
	lwz 0,264(31)
	mr 30,28
	li 16,0
	andi. 8,0,16
	bc 12,2,.L187
	andi. 9,24,32
	bc 4,2,.L187
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	li 30,0
	lwz 9,100(29)
	mr 16,28
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
.L187:
	cmpwi 4,22,0
	bc 12,18,.L190
	lis 11,level@ha
	lfs 12,4808(22)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 8,.LC30@ha
	la 8,.LC30@l(8)
	la 19,level@l(11)
	xoris 0,0,0x8000
	lfd 13,0(8)
	stw 0,44(1)
	stw 10,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L190
	andi. 9,24,32
	bc 4,2,.L190
	lfs 13,464(31)
	lfs 0,4(19)
	fcmpu 0,13,0
	bc 4,0,.L191
	lis 29,gi@ha
	lis 3,.LC27@ha
	la 29,gi@l(29)
	la 3,.LC27@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC34@ha
	lis 9,.LC34@ha
	lis 10,.LC29@ha
	la 8,.LC34@l(8)
	mr 5,3
	la 9,.LC34@l(9)
	lfs 1,0(8)
	mtlr 0
	la 10,.LC29@l(10)
	li 4,3
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC35@ha
	lfs 0,4(19)
	la 8,.LC35@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,464(31)
.L191:
	li 30,0
	mr 16,28
.L190:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L192
	lis 11,level@ha
	lfs 12,984(31)
	lwz 0,level@l(11)
	la 19,level@l(11)
	lis 10,0x4330
	lis 11,.LC30@ha
	xoris 0,0,0x8000
	la 11,.LC30@l(11)
	stw 0,44(1)
	stw 10,40(1)
	lfd 13,0(11)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L192
	andi. 0,24,32
	bc 4,2,.L192
	lfs 13,464(31)
	lfs 0,4(19)
	fcmpu 0,13,0
	bc 4,0,.L193
	lis 29,gi@ha
	lis 3,.LC27@ha
	la 29,gi@l(29)
	la 3,.LC27@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC34@ha
	lis 9,.LC34@ha
	lis 10,.LC29@ha
	la 8,.LC34@l(8)
	mr 5,3
	la 9,.LC34@l(9)
	lfs 1,0(8)
	mtlr 0
	la 10,.LC29@l(10)
	li 4,3
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC35@ha
	lfs 0,4(19)
	la 8,.LC35@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,464(31)
.L193:
	li 30,0
	mr 16,28
.L192:
	mr 6,24
	mr 7,23
	mr 4,17
	mr 3,31
	mr 5,25
	lis 29,hit_loc@ha
	bl CalcHitLoc
	lwz 0,hit_loc@l(29)
	mr 6,30
	mr 3,31
	mr 4,25
	mr 5,27
	stw 0,996(31)
	mr 7,24
	bl CheckPowerArmor
	lwz 0,hit_loc@l(29)
	mr 19,3
	subf 30,19,30
	andi. 8,0,16
	bc 12,2,.L194
	mr 7,30
	li 3,3
	mr 4,31
	mr 5,25
	mr 6,27
	mr 8,26
	mr 9,24
	bl CheckArmor
	mr 21,3
	subf 30,21,30
.L194:
	lwz 0,hit_loc@l(29)
	andi. 8,0,256
	bc 12,2,.L195
	mr 7,30
	li 3,2
	mr 4,31
	mr 5,25
	mr 6,27
	mr 8,26
	mr 9,24
	bl CheckArmor
	mr 21,3
	subf 30,21,30
.L195:
	lwz 0,hit_loc@l(29)
	andi. 8,0,96
	bc 12,2,.L196
	mr 7,30
	li 3,1
	mr 4,31
	mr 5,25
	mr 6,27
	mr 8,26
	mr 9,24
	bl CheckArmor
	mr 21,3
	subf 30,21,30
.L196:
	lwz 0,hit_loc@l(29)
	andi. 8,0,128
	bc 12,2,.L197
	mr 7,30
	li 3,0
	mr 4,31
	mr 5,25
	mr 6,27
	mr 8,26
	mr 9,24
	bl CheckArmor
	mr 21,3
	subf 30,21,30
.L197:
	lwz 0,1000(31)
	cmpwi 0,0,0
	bc 12,2,.L198
	mr 6,28
	mr 3,31
	mtlr 0
	mr 4,25
	mr 5,27
	mr 7,24
	mr 8,23
	blrl
	mr. 21,3
	bc 12,2,.L199
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
.L199:
	subf 30,21,30
.L198:
	cmpwi 0,30,0
	add 21,21,16
	bc 12,2,.L204
	mfcr 0
	rlwinm 9,0,15,1
	rlwinm 0,0,11,1
	or. 8,9,0
	bc 4,2,.L206
	xori 9,23,41
	subfic 10,9,0
	adde 9,10,9
	xori 0,23,43
	subfic 11,0,0
	adde 0,11,0
	or. 8,9,0
	bc 12,2,.L205
.L206:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lis 26,g_edicts@ha
	lwz 9,100(29)
	lis 28,0xa27a
	addi 27,15,4
	ori 28,28,52719
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,33
	mtlr 9
	blrl
	lwz 3,g_edicts@l(26)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,28
	mtlr 9
	srawi 3,3,2
	blrl
	lwz 3,g_edicts@l(26)
	lwz 9,104(29)
	subf 3,3,15
	mullw 3,3,28
	mtlr 9
	srawi 3,3,2
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	b .L237
.L205:
	lwz 0,264(31)
	andi. 8,0,8192
	bc 12,2,.L208
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,46
	b .L238
.L208:
	lwz 0,184(31)
	addic 8,22,-1
	subfe 9,8,22
	rlwinm 0,0,30,31,31
	or. 10,0,9
	bc 12,2,.L212
	bc 4,14,.L213
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,42
	b .L238
.L213:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,1
.L238:
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
.L237:
	li 4,2
	mtlr 0
	blrl
	b .L207
.L212:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
.L207:
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,1,.L222
	andi. 0,24,16
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	addi 0,9,1
	and 9,30,9
	or 30,9,0
.L222:
	subf 0,30,11
	stw 23,1024(31)
	cmpwi 0,0,0
	stw 0,480(31)
	bc 12,1,.L204
	lwz 0,184(31)
	addic 8,22,-1
	subfe 9,8,22
	rlwinm 0,0,30,31,31
	or. 10,0,9
	bc 12,2,.L224
	lwz 0,264(31)
	ori 0,0,2048
	stw 0,264(31)
.L224:
	mr 3,31
	mr 4,15
	mr 5,20
	mr 6,30
	mr 7,25
	bl Killed
	b .L160
.L204:
	lwz 0,184(31)
	andi. 8,0,4
	bc 12,2,.L225
	mr 5,15
	mr 3,31
	mr 4,20
	bl M_ReactToDamage
	lwz 0,776(31)
	addic 8,30,-1
	subfe 9,8,30
	xori 0,0,2048
	rlwinm 0,0,21,31,31
	and. 10,0,9
	bc 12,2,.L230
	lwz 0,264(31)
	andis. 11,0,2
	bc 12,2,.L227
	mfcr 0
	rlwinm 9,0,15,1
	rlwinm 0,0,11,1
	or. 8,9,0
	bc 4,2,.L228
	xori 9,23,43
	subfic 10,9,0
	adde 9,10,9
	xori 0,23,41
	subfic 11,0,0
	adde 0,11,0
	or. 8,0,9
	bc 12,2,.L227
.L228:
	lis 29,level@ha
	la 9,level@l(29)
	lfs 0,4(9)
	stfs 0,464(31)
	bl rand
	lwz 9,level@l(29)
	lis 0,0x4330
	rlwinm 3,3,0,17,31
	mr 10,11
	addi 9,9,60
	xoris 3,3,0x8000
	xoris 9,9,0x8000
	lis 8,.LC30@ha
	stw 9,44(1)
	la 8,.LC30@l(8)
	stw 0,40(1)
	lis 9,.LC36@ha
	lfd 13,40(1)
	la 9,.LC36@l(9)
	stw 3,44(1)
	stw 0,40(1)
	lfd 12,0(8)
	lfd 0,40(1)
	lis 8,.LC28@ha
	lfs 11,.LC28@l(8)
	fsub 13,13,12
	lfs 10,0(9)
	fsub 0,0,12
	frsp 13,13
	frsp 0,0
	fdivs 0,0,11
	fmadds 0,0,10,13
	stfs 0,1028(31)
.L227:
	xoris 11,18,0x8000
	lwz 10,452(31)
	stw 11,44(1)
	lis 0,0x4330
	mr 4,20
	lis 11,.LC30@ha
	stw 0,40(1)
	mr 3,31
	mtlr 10
	la 11,.LC30@l(11)
	lfd 1,40(1)
	mr 5,30
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	blrl
	lis 11,skill@ha
	lis 8,.LC37@ha
	lwz 9,skill@l(11)
	la 8,.LC37@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L230
	lis 10,.LC38@ha
	lis 9,level+4@ha
	la 10,.LC38@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,464(31)
	b .L230
.L225:
	bc 12,18,.L231
	lwz 0,264(31)
	addic 11,30,-1
	subfe 9,11,30
	xori 0,0,16
	rlwinm 0,0,28,31,31
	and. 8,0,9
	bc 12,2,.L230
	xoris 11,18,0x8000
	lwz 10,452(31)
	stw 11,44(1)
	lis 0,0x4330
	mr 3,31
	lis 11,.LC30@ha
	stw 0,40(1)
	mr 4,20
	mtlr 10
	la 11,.LC30@l(11)
	lfd 1,40(1)
	mr 5,30
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	blrl
	b .L230
.L231:
	cmpwi 0,30,0
	bc 12,2,.L230
	lwz 10,452(31)
	cmpwi 0,10,0
	bc 12,2,.L230
	xoris 0,18,0x8000
	mtlr 10
	stw 0,44(1)
	lis 11,0x4330
	lis 8,.LC30@ha
	la 8,.LC30@l(8)
	stw 11,40(1)
	mr 3,31
	lfd 0,0(8)
	mr 4,20
	mr 5,30
	lfd 1,40(1)
	fsub 1,1,0
	frsp 1,1
	blrl
.L230:
	bc 12,18,.L160
	lwz 0,4636(22)
	lwz 11,4632(22)
	lwz 10,4640(22)
	add 0,0,19
	lwz 9,4644(22)
	add 11,11,21
	add 10,10,30
	stw 0,4636(22)
	add 9,9,14
	stw 11,4632(22)
	stw 10,4640(22)
	stw 9,4644(22)
	lfs 0,0(25)
	stfs 0,4648(22)
	lfs 13,4(25)
	stfs 13,4652(22)
	lfs 0,8(25)
	stfs 0,4656(22)
.L160:
	lwz 0,132(1)
	lwz 12,52(1)
	mtlr 0
	lmw 14,56(1)
	mtcrf 56,12
	la 1,128(1)
	blr
.Lfe7:
	.size	 T_Damage,.Lfe7-T_Damage
	.section	".rodata"
	.align 2
.LC39:
	.long 0x3f000000
	.align 3
.LC40:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC41:
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
	mr 26,4
	fmr 30,2
	addi 29,30,4
	mr 27,5
	mr 28,6
	li 31,0
	b .L240
.L242:
	bc 12,30,.L240
	lwz 0,512(31)
	lis 9,.LC39@ha
	addi 4,1,16
	la 9,.LC39@l(9)
	addi 3,31,4
	cmpwi 0,0,0
	lfs 1,0(9)
	mr 5,4
	bc 12,2,.L240
	lfs 13,200(31)
	lfs 0,188(31)
	fadds 0,0,13
	stfs 0,16(1)
	lfs 0,204(31)
	lfs 13,192(31)
	fadds 13,13,0
	stfs 13,20(1)
	lfs 13,208(31)
	lfs 0,196(31)
	fadds 0,0,13
	stfs 0,24(1)
	bl VectorMA
	lfs 0,4(30)
	addi 3,1,16
	lfs 13,8(30)
	lfs 12,12(30)
	lfs 9,16(1)
	lfs 11,20(1)
	lfs 10,24(1)
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	bl VectorLength
	lis 9,.LC40@ha
	mr 4,30
	la 9,.LC40@l(9)
	fmr 0,29
	mr 3,31
	lfd 13,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	fmul 1,1,13
	lfs 12,0(9)
	fsub 0,0,1
	frsp 31,0
	fcmpu 0,31,12
	bc 4,1,.L240
	bl CanDamage
	cmpwi 0,3,0
	lis 8,vec3_origin@ha
	li 0,1
	mr 3,31
	la 8,vec3_origin@l(8)
	mr 5,26
	addi 6,1,32
	mr 7,29
	mr 4,30
	bc 12,2,.L240
	lfs 0,4(30)
	fmr 13,31
	lfs 12,4(31)
	lfs 11,8(30)
	lfs 10,12(30)
	fctiwz 9,13
	fsubs 12,12,0
	stfd 9,56(1)
	stfs 12,32(1)
	lfs 0,8(31)
	lwz 9,60(1)
	fsubs 0,0,11
	mr 10,9
	stfs 0,36(1)
	lfs 13,12(31)
	stw 0,8(1)
	stw 28,12(1)
	fsubs 13,13,10
	stfs 13,40(1)
	bl T_Damage
.L240:
	fmr 1,30
	mr 3,31
	mr 4,29
	bl findradius
	mr. 31,3
	cmpw 7,31,27
	bc 4,2,.L242
	lwz 0,116(1)
	mtlr 0
	lmw 26,64(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe8:
	.size	 T_RadiusDamage,.Lfe8-T_RadiusDamage
	.align 2
	.globl cleanupHealTarget
	.type	 cleanupHealTarget,@function
cleanupHealTarget:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 11,0
	lwz 0,776(9)
	li 10,1
	stw 11,916(9)
	rlwinm 0,0,0,18,16
	stw 10,512(9)
	stw 0,776(9)
	bl M_SetEffects
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 cleanupHealTarget,.Lfe9-cleanupHealTarget
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
.Lfe10:
	.size	 SpawnDamage,.Lfe10-SpawnDamage
	.comm	hit_loc,4,4
	.align 2
	.globl GetArmorInfo
	.type	 GetArmorInfo,@function
GetArmorInfo:
	cmpwi 0,3,48
	li 9,0
	bc 12,2,.L98
	bc 12,1,.L102
	cmpwi 0,3,47
	bc 12,2,.L97
	b .L96
.L102:
	cmpwi 0,3,49
	bc 12,2,.L99
	b .L96
.L97:
	lis 9,jacketarmor_info@ha
	la 9,jacketarmor_info@l(9)
	b .L96
.L98:
	lis 9,combatarmor_info@ha
	la 9,combatarmor_info@l(9)
	b .L96
.L99:
	lis 9,bodyarmor_info@ha
	la 9,bodyarmor_info@l(9)
.L96:
	mr 3,9
	blr
.Lfe11:
	.size	 GetArmorInfo,.Lfe11-GetArmorInfo
	.align 2
	.globl CheckTeamDamage
	.type	 CheckTeamDamage,@function
CheckTeamDamage:
	li 3,0
	blr
.Lfe12:
	.size	 CheckTeamDamage,.Lfe12-CheckTeamDamage
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
