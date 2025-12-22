	.file	"g_weapon.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
	.long 0x3f800000
	.align 2
.LC3:
	.long 0x3f000000
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl fire_hit
	.type	 fire_hit,@function
fire_hit:
	stwu 1,-240(1)
	mflr 0
	stfd 31,232(1)
	stmw 22,192(1)
	stw 0,244(1)
	mr 31,3
	mr 30,4
	lwz 9,548(31)
	addi 3,1,160
	mr 23,5
	lfs 0,4(31)
	mr 22,3
	mr 25,6
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,160(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,164(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,168(1)
	bl VectorLength
	fmr 31,1
	lfs 0,0(30)
	fcmpu 0,31,0
	bc 12,1,.L23
	lfs 0,4(30)
	lfs 13,188(31)
	fmr 12,0
	fcmpu 0,0,13
	bc 4,1,.L12
	lfs 0,200(31)
	fcmpu 0,12,0
	bc 4,0,.L12
	lwz 9,548(31)
	lfs 0,200(9)
	fsubs 31,31,0
	b .L13
.L12:
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,0,.L14
	lwz 9,548(31)
	lfs 0,188(9)
	b .L24
.L14:
	lwz 9,548(31)
	lfs 0,200(9)
.L24:
	stfs 0,4(30)
.L13:
	fmr 1,31
	addi 28,1,144
	addi 29,31,4
	mr 3,29
	mr 4,22
	mr 5,28
	mr 24,29
	bl VectorMA
	mr 26,28
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	addi 3,1,16
	mr 4,29
	li 5,0
	li 6,0
	mr 7,28
	mtlr 0
	mr 8,31
	blrl
	lis 9,.LC2@ha
	lfs 13,24(1)
	la 9,.LC2@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L16
	lwz 9,68(1)
	lwz 0,516(9)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L19
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L16
.L19:
	lwz 0,548(31)
	stw 0,68(1)
.L16:
	addi 29,1,80
	addi 28,1,96
	addi 27,1,112
	mr 4,29
	mr 6,27
	addi 3,31,16
	mr 5,28
	bl AngleVectors
	fmr 1,31
	mr 4,29
	mr 3,24
	mr 5,26
	bl VectorMA
	lfs 1,4(30)
	mr 4,28
	mr 3,26
	mr 5,26
	bl VectorMA
	lfs 1,8(30)
	mr 4,27
	mr 3,26
	mr 5,26
	bl VectorMA
	lwz 11,548(31)
	srwi 10,25,31
	li 0,32
	lfs 0,144(1)
	add 10,25,10
	li 29,8
	lfs 11,4(11)
	lis 8,vec3_origin@ha
	mr 9,23
	lfs 13,148(1)
	mr 6,22
	mr 7,26
	lfs 12,152(1)
	la 8,vec3_origin@l(8)
	srawi 10,10,1
	fsubs 0,0,11
	lwz 3,68(1)
	mr 4,31
	mr 5,31
	stfs 0,160(1)
	lfs 0,8(11)
	fsubs 13,13,0
	stfs 13,164(1)
	lfs 0,12(11)
	stw 0,12(1)
	stw 29,8(1)
	fsubs 12,12,0
	stfs 12,168(1)
	bl T_Damage
	lwz 9,68(1)
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L20
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L20
.L23:
	li 3,0
	b .L22
.L20:
	lis 9,.LC3@ha
	lwz 3,548(31)
	addi 29,1,128
	la 9,.LC3@l(9)
	mr 5,29
	lfs 1,0(9)
	addi 4,3,236
	addi 3,3,212
	bl VectorMA
	lfs 12,128(1)
	mr 3,29
	lfs 0,132(1)
	lfs 13,136(1)
	lfs 11,144(1)
	lfs 10,148(1)
	lfs 9,152(1)
	fsubs 12,12,11
	fsubs 0,0,10
	fsubs 13,13,9
	stfs 12,128(1)
	stfs 0,132(1)
	stfs 13,136(1)
	bl VectorNormalize
	xoris 11,25,0x8000
	lwz 3,548(31)
	stw 11,188(1)
	lis 0,0x4330
	mr 4,29
	lis 11,.LC4@ha
	stw 0,184(1)
	addi 3,3,380
	la 11,.LC4@l(11)
	lfd 1,184(1)
	mr 5,3
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	bl VectorMA
	lwz 3,548(31)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lfs 0,388(3)
	fcmpu 0,0,13
	bc 4,1,.L21
	li 0,0
	stw 0,560(3)
.L21:
	li 3,1
.L22:
	lwz 0,244(1)
	mtlr 0
	lmw 22,192(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe1:
	.size	 fire_hit,.Lfe1-fire_hit
	.section	".rodata"
	.align 2
.LC5:
	.string	"%s (%f, %f, %f)\n"
	.align 2
.LC6:
	.long 0x0
	.long 0x0
	.long 0xc6000000
	.align 2
.LC9:
	.string	"*brwater"
	.align 2
.LC10:
	.string	"sky"
	.align 2
.LC7:
	.long 0x46fffe00
	.align 3
.LC8:
	.long 0x4082c000
	.long 0x0
	.align 3
.LC11:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC12:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC14:
	.long 0x40490000
	.long 0x0
	.align 2
.LC15:
	.long 0x41a00000
	.align 2
.LC16:
	.long 0x0
	.align 3
.LC17:
	.long 0x40990000
	.long 0x0
	.align 2
.LC18:
	.long 0x46000000
	.align 2
.LC19:
	.long 0xc0000000
	.align 2
.LC20:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl fire_gun
	.type	 fire_gun,@function
fire_gun:
	stwu 1,-432(1)
	mflr 0
	stfd 27,392(1)
	stfd 28,400(1)
	stfd 29,408(1)
	stfd 30,416(1)
	stfd 31,424(1)
	stmw 14,320(1)
	stw 0,436(1)
	lis 11,.LC6@ha
	mr 31,3
	lwz 28,.LC6@l(11)
	addi 29,1,208
	lis 27,gi@ha
	la 11,.LC6@l(11)
	la 27,gi@l(27)
	lwz 3,8(11)
	mr 30,4
	mr 19,5
	lwz 0,4(11)
	mr 15,6
	mr 14,7
	stw 28,208(1)
	mr 18,8
	mr 17,9
	stw 0,4(29)
	addi 4,1,176
	mr 7,29
	stw 3,8(29)
	addi 5,31,188
	addi 6,31,200
	lfs 10,4(31)
	addi 3,1,224
	mr 8,31
	lfs 9,8(31)
	li 9,3
	mr 16,10
	lfs 11,12(31)
	lis 28,0x600
	li 20,0
	lfs 12,208(1)
	ori 28,28,59
	lfs 13,212(1)
	lfs 0,216(1)
	lwz 11,48(27)
	fadds 12,10,12
	fadds 13,9,13
	stfs 10,176(1)
	fadds 0,11,0
	mtlr 11
	stfs 11,184(1)
	stfs 12,208(1)
	stfs 13,212(1)
	stfs 0,216(1)
	stfs 9,180(1)
	blrl
	mr 4,31
	lfs 0,236(1)
	lis 9,0x600
	lfsu 11,4(4)
	ori 9,9,3
	addi 3,1,16
	lfs 12,8(31)
	li 5,0
	li 6,0
	lfs 13,244(1)
	mr 7,30
	mr 8,31
	fsubs 11,11,0
	lfs 10,240(1)
	lfs 0,12(31)
	lwz 0,48(27)
	fsubs 12,12,10
	stfs 11,192(1)
	fsubs 0,0,13
	mtlr 0
	stfs 12,196(1)
	stfs 0,200(1)
	blrl
	lfs 0,24(1)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L31
	addi 29,1,80
	mr 3,19
	mr 4,29
	mr 23,29
	bl vectoangles
	addi 4,1,96
	addi 5,1,112
	addi 6,1,128
	mr 22,4
	mr 21,5
	mr 3,29
	mr 24,6
	bl AngleVectors
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 4,2,.L32
	bl rand
	lis 29,0x4330
	lis 9,.LC12@ha
	rlwinm 3,3,0,17,31
	la 9,.LC12@l(9)
	xoris 3,3,0x8000
	lfd 29,0(9)
	lis 10,.LC7@ha
	lis 11,.LC13@ha
	lfs 28,.LC7@l(10)
	la 11,.LC13@l(11)
	stw 3,316(1)
	stw 29,312(1)
	lfd 13,312(1)
	lfd 30,0(11)
	lis 11,.LC8@ha
	fsub 13,13,29
	lfd 31,.LC8@l(11)
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,31
	frsp 27,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,316(1)
	stw 29,312(1)
	lfd 13,312(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,31
	b .L65
.L32:
	bl rand
	lis 29,0x4330
	lis 9,.LC12@ha
	rlwinm 3,3,0,17,31
	la 9,.LC12@l(9)
	xoris 3,3,0x8000
	lfd 29,0(9)
	lis 11,.LC7@ha
	lis 10,.LC13@ha
	lfs 28,.LC7@l(11)
	la 10,.LC13@l(10)
	stw 3,316(1)
	stw 29,312(1)
	lfd 13,312(1)
	lfd 31,0(10)
	lis 10,.LC14@ha
	fsub 13,13,29
	la 10,.LC14@l(10)
	lfd 30,0(10)
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,30
	frsp 27,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,316(1)
	stw 29,312(1)
	lfd 13,312(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,30
.L65:
	frsp 31,0
	addi 3,1,192
	bl VectorLength
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L34
	lis 10,.LC16@ha
	lfs 13,388(31)
	la 10,.LC16@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 12,2,.L34
	bl rand
	lis 29,0x4330
	lis 9,.LC12@ha
	rlwinm 3,3,0,17,31
	la 9,.LC12@l(9)
	xoris 3,3,0x8000
	lfd 29,0(9)
	lis 11,.LC7@ha
	lis 10,.LC13@ha
	lfs 28,.LC7@l(11)
	la 10,.LC13@l(10)
	stw 3,316(1)
	stw 29,312(1)
	lfd 13,312(1)
	lfd 31,0(10)
	lis 10,.LC17@ha
	fsub 13,13,29
	la 10,.LC17@l(10)
	lfd 30,0(10)
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,30
	frsp 27,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,316(1)
	stw 29,312(1)
	lfd 13,312(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,30
	frsp 31,0
.L34:
	lis 9,.LC18@ha
	addi 29,1,144
	la 9,.LC18@l(9)
	mr 5,29
	lfs 1,0(9)
	mr 3,30
	mr 4,22
	mr 26,29
	bl VectorMA
	fmr 1,27
	mr 3,29
	mr 5,29
	mr 4,21
	bl VectorMA
	fmr 1,31
	mr 3,29
	mr 5,29
	mr 4,24
	bl VectorMA
	lis 9,gi@ha
	mr 3,30
	la 29,gi@l(9)
	lwz 9,52(29)
	mtlr 9
	blrl
	andi. 0,3,56
	bc 12,2,.L35
	lfs 0,0(30)
	li 20,1
	rlwinm 28,28,0,29,25
	lfs 13,4(30)
	lfs 12,8(30)
	stfs 0,160(1)
	stfs 13,164(1)
	stfs 12,168(1)
.L35:
	lwz 0,48(29)
	mr 9,28
	addi 3,1,16
	mr 4,30
	li 5,0
	mtlr 0
	li 6,0
	mr 7,26
	mr 8,31
	blrl
	lwz 9,64(1)
	lis 0,0x1
	ori 0,0,3
	and. 10,9,0
	bc 12,2,.L36
	mr 3,31
	addi 4,1,28
	mr 5,24
	li 6,0
	li 7,0
	bl SprayBlood
.L36:
	li 0,0
	cmpwi 0,0,0
	bc 12,2,.L37
	bl rand
	xoris 3,3,0x8000
	lwz 11,84(31)
	lis 10,.LC12@ha
	stw 3,316(1)
	lis 0,0x4330
	la 10,.LC12@l(10)
	stw 0,312(1)
	lfd 13,0(10)
	lfd 0,312(1)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 11,96(10)
	fsub 0,0,13
	slwi 9,9,2
	lwzx 10,9,11
	frsp 0,0
	lfs 13,60(10)
	fcmpu 0,0,13
	bc 4,0,.L37
	bl rand
.L37:
	lwz 0,64(1)
	andi. 9,0,56
	bc 12,2,.L31
	lfs 12,28(1)
	addi 0,1,28
	mr 3,30
	lfs 13,32(1)
	mr 4,0
	mr 25,0
	lfs 0,36(1)
	addi 27,1,160
	li 20,1
	stfs 12,160(1)
	stfs 13,164(1)
	stfs 0,168(1)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L43
	lwz 0,64(1)
	andi. 9,0,32
	bc 12,2,.L44
	lwz 3,60(1)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	addic 3,3,-1
	subfe 3,3,3
	rlwinm 3,3,0,30,31
	ori 28,3,2
	b .L47
.L44:
	andi. 9,0,16
	bc 12,2,.L48
	li 28,4
	b .L47
.L48:
	rlwinm 0,0,0,28,28
	neg 0,0
	srawi 0,0,31
	andi. 28,0,5
.L47:
	cmpwi 0,28,0
	bc 12,2,.L52
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,8
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,40
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
.L52:
	lfs 9,8(30)
	lis 9,.LC12@ha
	lis 10,.LC13@ha
	lfs 10,0(30)
	la 9,.LC12@l(9)
	la 10,.LC13@l(10)
	lfs 12,4(30)
	addi 28,1,160
	mr 3,23
	lfs 11,144(1)
	mr 4,23
	lis 29,0x4330
	lfs 13,148(1)
	mr 27,28
	lfs 0,152(1)
	fsubs 11,11,10
	lfd 31,0(9)
	fsubs 13,13,12
	lfd 30,0(10)
	fsubs 0,0,9
	stfs 11,80(1)
	stfs 13,84(1)
	stfs 0,88(1)
	bl vectoangles
	mr 6,24
	mr 4,22
	mr 5,21
	mr 3,23
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC7@ha
	stw 3,316(1)
	mr 11,9
	xoris 0,18,0x8000
	stw 29,312(1)
	lfd 13,312(1)
	lfs 29,.LC7@l(10)
	stw 0,316(1)
	fsub 13,13,31
	stw 29,312(1)
	lfd 12,312(1)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,12
	fadd 0,0,0
	frsp 27,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	mr 11,9
	stw 3,316(1)
	xoris 0,17,0x8000
	lis 10,.LC18@ha
	stw 29,312(1)
	la 10,.LC18@l(10)
	mr 4,22
	lfd 13,312(1)
	mr 3,28
	mr 5,26
	stw 0,316(1)
	stw 29,312(1)
	fsub 13,13,31
	lfd 12,312(1)
	lfs 1,0(10)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,12
	fadd 0,0,0
	frsp 31,0
	bl VectorMA
	fmr 1,27
	mr 4,21
	mr 3,26
	mr 5,26
	bl VectorMA
	fmr 1,31
	mr 4,24
	mr 3,26
	mr 5,26
	bl VectorMA
.L43:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 4,27
	mr 7,26
	addi 3,1,16
	li 5,0
	li 6,0
	mr 8,31
	mtlr 0
	ori 9,9,3
	blrl
.L31:
	lwz 3,60(1)
	cmpwi 0,3,0
	bc 12,2,.L54
	lwz 0,16(3)
	andi. 9,0,4
	bc 4,2,.L53
.L54:
	lfs 0,24(1)
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	lfd 13,0(10)
	fcmpu 0,0,13
	bc 4,0,.L53
	lwz 9,68(1)
	lwz 0,516(9)
	cmpwi 0,0,0
	bc 12,2,.L56
	mr 4,31
	li 0,16
	stw 16,12(1)
	mr 3,9
	stw 0,8(1)
	mr 6,19
	mr 9,15
	mr 10,14
	mr 5,4
	addi 7,1,28
	addi 8,1,40
	bl T_Damage
	b .L53
.L56:
	lis 4,.LC10@ha
	li 5,3
	la 4,.LC10@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L53
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,316(1)
	lis 10,.LC12@ha
	lis 11,.LC7@ha
	la 10,.LC12@l(10)
	stw 0,312(1)
	lfd 13,0(10)
	lfd 0,312(1)
	lis 10,.LC13@ha
	lfs 11,.LC7@l(11)
	la 10,.LC13@l(10)
	lfd 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fsub 13,13,12
	fadd 13,13,13
	fcmpu 0,13,12
	bc 4,0,.L59
	lwz 0,100(29)
	li 3,0
	mtlr 0
	blrl
	b .L60
.L59:
	lwz 0,100(29)
	li 3,14
	mtlr 0
	blrl
.L60:
	lis 29,gi@ha
	addi 28,1,28
	la 29,gi@l(29)
	mr 3,28
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,40
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L53
	mr 3,31
	mr 4,28
	li 5,2
	bl PlayerNoise
.L53:
	cmpwi 0,20,0
	bc 12,2,.L62
	lfs 0,160(1)
	addi 27,1,80
	addi 29,1,288
	lfs 11,28(1)
	addi 28,1,28
	mr 3,27
	lfs 13,32(1)
	mr 31,29
	mr 25,28
	lfs 10,164(1)
	fsubs 11,11,0
	lfs 12,168(1)
	lfs 0,36(1)
	fsubs 13,13,10
	stfs 11,80(1)
	fsubs 0,0,12
	stfs 13,84(1)
	stfs 0,88(1)
	bl VectorNormalize
	lis 9,.LC19@ha
	mr 5,29
	la 9,.LC19@l(9)
	mr 4,27
	lfs 1,0(9)
	mr 3,28
	bl VectorMA
	lis 9,gi@ha
	mr 3,29
	la 29,gi@l(9)
	lwz 9,52(29)
	mtlr 9
	blrl
	andi. 0,3,56
	bc 12,2,.L63
	lfs 0,288(1)
	addi 27,1,160
	lfs 13,292(1)
	lfs 12,296(1)
	stfs 0,28(1)
	stfs 13,32(1)
	stfs 12,36(1)
	b .L64
.L63:
	lwz 11,48(29)
	addi 0,1,160
	addi 3,1,16
	mr 4,31
	li 5,0
	lwz 8,68(1)
	li 6,0
	mr 7,0
	mtlr 11
	li 9,56
	mr 27,0
	blrl
.L64:
	lfs 11,28(1)
	lis 9,.LC20@ha
	mr 4,31
	lfs 12,160(1)
	la 9,.LC20@l(9)
	mr 3,31
	lfs 13,164(1)
	lfs 10,32(1)
	fadds 12,12,11
	lfs 0,168(1)
	lfs 11,36(1)
	fadds 13,13,10
	lfs 1,0(9)
	stfs 12,288(1)
	fadds 0,0,11
	stfs 13,292(1)
	stfs 0,296(1)
	bl VectorScale
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,11
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,31
	li 4,2
	mtlr 0
	blrl
.L62:
	lwz 0,436(1)
	mtlr 0
	lmw 14,320(1)
	lfd 27,392(1)
	lfd 28,400(1)
	lfd 29,408(1)
	lfd 30,416(1)
	lfd 31,424(1)
	la 1,432(1)
	blr
.Lfe2:
	.size	 fire_gun,.Lfe2-fire_gun
	.section	".rodata"
	.align 2
.LC21:
	.long 0x46fffe00
	.align 3
.LC22:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC24:
	.long 0x46000000
	.align 3
.LC25:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC26:
	.long 0xc0000000
	.align 2
.LC27:
	.long 0x3f000000
	.section	".text"
	.align 2
	.type	 fire_lead,@function
fire_lead:
	stwu 1,-304(1)
	mflr 0
	stfd 28,272(1)
	stfd 29,280(1)
	stfd 30,288(1)
	stfd 31,296(1)
	stmw 14,200(1)
	stw 0,308(1)
	lis 11,gi+48@ha
	mr 20,9
	lwz 0,gi+48@l(11)
	mr 30,3
	mr 27,4
	mr 17,5
	mr 16,6
	mr 15,7
	mr 14,8
	mtlr 0
	lis 9,0x600
	mr 8,30
	addi 3,1,16
	addi 4,30,4
	li 5,0
	li 6,0
	mr 7,27
	ori 9,9,3
	mr 19,10
	lis 28,0x600
	li 18,0
	ori 28,28,59
	blrl
	lfs 0,24(1)
	lis 8,.LC22@ha
	la 8,.LC22@l(8)
	lfd 13,0(8)
	fcmpu 0,0,13
	bc 12,0,.L67
	addi 29,1,80
	mr 3,17
	mr 4,29
	mr 25,29
	bl vectoangles
	addi 4,1,96
	addi 5,1,112
	addi 6,1,128
	mr 21,5
	mr 23,6
	mr 3,29
	mr 22,4
	bl AngleVectors
	xoris 0,20,0x8000
	lis 10,0x4330
	stw 0,196(1)
	mr 11,9
	stw 10,192(1)
	xoris 0,19,0x8000
	lis 8,.LC23@ha
	lfd 13,192(1)
	la 8,.LC23@l(8)
	addi 29,1,144
	stw 0,196(1)
	lis 9,.LC24@ha
	mr 5,29
	lfd 12,0(8)
	la 9,.LC24@l(9)
	mr 3,27
	stw 10,192(1)
	mr 4,22
	mr 26,29
	lfd 0,192(1)
	fsub 13,13,12
	lfs 1,0(9)
	fsub 0,0,12
	frsp 28,13
	frsp 31,0
	bl VectorMA
	fmr 1,28
	mr 3,29
	mr 5,29
	mr 4,21
	bl VectorMA
	fmr 1,31
	mr 3,29
	mr 5,29
	mr 4,23
	bl VectorMA
	lis 9,gi@ha
	mr 3,27
	la 29,gi@l(9)
	lwz 9,52(29)
	mtlr 9
	blrl
	andi. 0,3,56
	bc 12,2,.L72
	lfs 0,0(27)
	li 18,1
	rlwinm 28,28,0,29,25
	lfs 13,4(27)
	lfs 12,8(27)
	stfs 0,160(1)
	stfs 13,164(1)
	stfs 12,168(1)
.L72:
	lwz 0,48(29)
	mr 9,28
	mr 8,30
	addi 3,1,16
	mr 4,27
	mtlr 0
	li 5,0
	li 6,0
	mr 7,26
	blrl
	lwz 9,64(1)
	lis 0,0x1
	ori 0,0,3
	and. 8,9,0
	bc 12,2,.L73
	mr 3,30
	addi 4,1,28
	mr 5,23
	li 6,0
	li 7,0
	bl SprayBlood
.L73:
	li 0,0
	cmpwi 0,0,0
	bc 12,2,.L74
	bl rand
	xoris 3,3,0x8000
	lwz 11,84(30)
	stw 3,196(1)
	lis 0,0x4330
	lis 8,.LC23@ha
	stw 0,192(1)
	la 8,.LC23@l(8)
	lfd 13,0(8)
	lfd 0,192(1)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 11,96(10)
	fsub 0,0,13
	slwi 9,9,2
	lwzx 10,9,11
	frsp 0,0
	lfs 13,60(10)
	fcmpu 0,0,13
	bc 4,0,.L74
	bl rand
.L74:
	lwz 0,64(1)
	andi. 8,0,56
	bc 12,2,.L67
	lfs 12,28(1)
	addi 0,1,28
	mr 3,27
	lfs 13,32(1)
	mr 4,0
	mr 24,0
	lfs 0,36(1)
	addi 31,1,160
	li 18,1
	stfs 12,160(1)
	stfs 13,164(1)
	stfs 0,168(1)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L80
	lwz 0,64(1)
	andi. 8,0,32
	bc 12,2,.L81
	lwz 3,60(1)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	addic 3,3,-1
	subfe 3,3,3
	rlwinm 3,3,0,30,31
	ori 28,3,2
	b .L84
.L81:
	andi. 8,0,16
	bc 12,2,.L85
	li 28,4
	b .L84
.L85:
	rlwinm 0,0,0,28,28
	neg 0,0
	srawi 0,0,31
	andi. 28,0,5
.L84:
	cmpwi 0,28,0
	bc 12,2,.L89
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,8
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,40
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,24
	li 4,2
	mtlr 0
	blrl
.L89:
	lfs 9,8(27)
	lis 8,.LC23@ha
	lis 9,.LC25@ha
	lfs 10,0(27)
	la 8,.LC23@l(8)
	la 9,.LC25@l(9)
	lfs 12,4(27)
	addi 28,1,160
	mr 3,25
	lfs 11,144(1)
	mr 4,25
	lis 29,0x4330
	lfs 13,148(1)
	mr 31,28
	lfs 0,152(1)
	fsubs 11,11,10
	lfd 31,0(8)
	fsubs 13,13,12
	lfd 30,0(9)
	fsubs 0,0,9
	stfs 11,80(1)
	stfs 13,84(1)
	stfs 0,88(1)
	bl vectoangles
	mr 6,23
	mr 4,22
	mr 5,21
	mr 3,25
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC21@ha
	stw 3,196(1)
	mr 11,9
	xoris 0,20,0x8000
	stw 29,192(1)
	lfd 13,192(1)
	lfs 29,.LC21@l(10)
	stw 0,196(1)
	fsub 13,13,31
	stw 29,192(1)
	lfd 12,192(1)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,12
	fadd 0,0,0
	frsp 28,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	mr 11,9
	stw 3,196(1)
	xoris 0,19,0x8000
	lis 8,.LC24@ha
	stw 29,192(1)
	la 8,.LC24@l(8)
	mr 4,22
	lfd 13,192(1)
	mr 3,28
	mr 5,26
	stw 0,196(1)
	stw 29,192(1)
	fsub 13,13,31
	lfd 12,192(1)
	lfs 1,0(8)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,12
	fadd 0,0,0
	frsp 31,0
	bl VectorMA
	fmr 1,28
	mr 4,21
	mr 3,26
	mr 5,26
	bl VectorMA
	fmr 1,31
	mr 4,23
	mr 3,26
	mr 5,26
	bl VectorMA
.L80:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 4,31
	mr 7,26
	addi 3,1,16
	li 5,0
	li 6,0
	mr 8,30
	mtlr 0
	ori 9,9,3
	blrl
.L67:
	lwz 3,60(1)
	cmpwi 0,3,0
	bc 12,2,.L91
	lwz 0,16(3)
	andi. 8,0,4
	bc 4,2,.L90
.L91:
	lfs 0,24(1)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L90
	lwz 11,68(1)
	lwz 0,516(11)
	cmpwi 0,0,0
	bc 12,2,.L93
	li 9,16
	lwz 0,312(1)
	mr 4,30
	stw 9,8(1)
	mr 3,11
	mr 6,17
	stw 0,12(1)
	mr 9,16
	mr 10,15
	mr 5,4
	addi 7,1,28
	addi 8,1,40
	bl T_Damage
	b .L90
.L93:
	lis 4,.LC10@ha
	li 5,3
	la 4,.LC10@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L90
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,1,28
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,14
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,40
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L90
	mr 3,30
	mr 4,28
	li 5,2
	bl PlayerNoise
.L90:
	cmpwi 0,18,0
	bc 12,2,.L97
	lfs 0,160(1)
	addi 27,1,80
	addi 29,1,176
	lfs 11,28(1)
	addi 28,1,28
	mr 3,27
	lfs 13,32(1)
	mr 30,29
	mr 24,28
	lfs 10,164(1)
	fsubs 11,11,0
	lfs 12,168(1)
	lfs 0,36(1)
	fsubs 13,13,10
	stfs 11,80(1)
	fsubs 0,0,12
	stfs 13,84(1)
	stfs 0,88(1)
	bl VectorNormalize
	lis 8,.LC26@ha
	mr 5,29
	la 8,.LC26@l(8)
	mr 4,27
	lfs 1,0(8)
	mr 3,28
	bl VectorMA
	lis 9,gi@ha
	mr 3,29
	la 29,gi@l(9)
	lwz 9,52(29)
	mtlr 9
	blrl
	andi. 0,3,56
	bc 12,2,.L98
	lfs 0,176(1)
	addi 31,1,160
	lfs 13,180(1)
	lfs 12,184(1)
	stfs 0,28(1)
	stfs 13,32(1)
	stfs 12,36(1)
	b .L99
.L98:
	lwz 11,48(29)
	addi 0,1,160
	addi 3,1,16
	mr 4,30
	li 5,0
	lwz 8,68(1)
	li 6,0
	mr 7,0
	mtlr 11
	li 9,56
	mr 31,0
	blrl
.L99:
	lfs 11,28(1)
	lis 8,.LC27@ha
	mr 4,30
	lfs 12,160(1)
	la 8,.LC27@l(8)
	mr 3,30
	lfs 13,164(1)
	lfs 10,32(1)
	fadds 12,12,11
	lfs 0,168(1)
	lfs 11,36(1)
	fadds 13,13,10
	lfs 1,0(8)
	stfs 12,176(1)
	fadds 0,0,11
	stfs 13,180(1)
	stfs 0,184(1)
	bl VectorScale
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,11
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
.L97:
	lwz 0,308(1)
	mtlr 0
	lmw 14,200(1)
	lfd 28,272(1)
	lfd 29,280(1)
	lfd 30,288(1)
	lfd 31,296(1)
	la 1,304(1)
	blr
.Lfe3:
	.size	 fire_lead,.Lfe3-fire_lead
	.section	".rodata"
	.align 2
.LC28:
	.string	"models/objects/laser/tris.md2"
	.align 2
.LC29:
	.string	"misc/bwhiz.wav"
	.align 2
.LC30:
	.string	"bolt"
	.align 2
.LC31:
	.long 0x46fffe00
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC34:
	.long 0x0
	.align 2
.LC35:
	.long 0x41200000
	.align 3
.LC36:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC37:
	.long 0x46000000
	.align 3
.LC38:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC39:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl fire_tracer
	.type	 fire_tracer,@function
fire_tracer:
	stwu 1,-240(1)
	mflr 0
	stfd 29,216(1)
	stfd 30,224(1)
	stfd 31,232(1)
	stmw 24,184(1)
	stw 0,244(1)
	mr 30,3
	mr 25,5
	mr 28,6
	mr 27,7
	mr 3,25
	lis 24,0x4330
	bl VectorNormalize
	li 29,1500
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfd 30,0(9)
	bl G_Spawn
	lfs 13,4(30)
	mr 31,3
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	mr 3,25
	lfs 31,0(9)
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,8(30)
	stfs 0,8(31)
	lfs 12,12(30)
	stfs 12,12(31)
	lfs 0,4(30)
	stfs 0,28(31)
	lfs 13,8(30)
	stfs 13,32(31)
	lfs 0,12(30)
	stfs 0,36(31)
	lwz 0,512(30)
	xoris 0,0,0x8000
	stw 0,180(1)
	stw 24,176(1)
	lfd 0,176(1)
	fsub 0,0,30
	frsp 0,0
	fadds 12,12,0
	stfs 12,12(31)
	bl vectoangles
	xoris 29,29,0x8000
	stw 29,180(1)
	addi 4,31,380
	mr 3,25
	stw 24,176(1)
	lfd 0,176(1)
	fsub 0,0,30
	frsp 29,0
	fmr 1,29
	bl VectorScale
	lwz 11,64(31)
	li 9,8
	lis 0,0x600
	stw 9,264(31)
	ori 0,0,3
	li 10,2
	ori 11,11,64
	lis 9,gi@ha
	stw 0,252(31)
	la 26,gi@l(9)
	stw 10,248(31)
	lis 3,.LC28@ha
	stw 11,64(31)
	la 3,.LC28@l(3)
	stfs 31,196(31)
	stfs 31,192(31)
	stfs 31,188(31)
	stfs 31,208(31)
	stfs 31,204(31)
	stfs 31,200(31)
	lwz 9,32(26)
	mtlr 9
	blrl
	stw 3,40(31)
	lwz 9,36(26)
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	mtlr 9
	blrl
	lis 9,tracer_touch@ha
	lis 11,.LC35@ha
	stw 3,76(31)
	la 9,tracer_touch@l(9)
	stw 30,256(31)
	lis 10,level+4@ha
	stw 9,448(31)
	la 11,.LC35@l(11)
	li 0,1
	lfs 0,level+4@l(10)
	lis 9,.LC30@ha
	mr 3,31
	lfs 13,0(11)
	la 9,.LC30@l(9)
	lis 11,G_FreeEdict@ha
	stw 0,288(31)
	la 11,G_FreeEdict@l(11)
	stw 28,520(31)
	fadds 0,0,13
	stw 11,440(31)
	stw 9,284(31)
	stw 27,540(31)
	stfs 0,432(31)
	lwz 9,72(26)
	mtlr 9
	blrl
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L115
	lis 9,skill@ha
	addi 29,31,4
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L116
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC31@ha
	stw 3,180(1)
	lis 10,.LC36@ha
	stw 24,176(1)
	la 10,.LC36@l(10)
	lfd 0,176(1)
	lfs 12,.LC31@l(11)
	lfd 11,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L115
.L116:
	lis 11,.LC37@ha
	addi 5,1,72
	la 11,.LC37@l(11)
	mr 3,29
	lfs 1,0(11)
	mr 4,25
	bl VectorMA
	lwz 0,48(26)
	lis 9,0x600
	addi 3,1,104
	mr 4,29
	li 5,0
	li 6,0
	addi 7,1,72
	mtlr 0
	mr 8,30
	ori 9,9,3
	blrl
	lwz 3,156(1)
	cmpwi 0,3,0
	bc 12,2,.L115
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L115
	lwz 0,484(3)
	cmpwi 0,0,0
	bc 4,1,.L115
	lwz 0,852(3)
	cmpwi 0,0,0
	bc 12,2,.L115
	mr 4,30
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L115
	lfs 13,4(31)
	addi 3,1,88
	lfs 0,116(1)
	lfs 12,120(1)
	lfs 11,124(1)
	fsubs 0,0,13
	stfs 0,88(1)
	lfs 13,4(29)
	fsubs 12,12,13
	stfs 12,92(1)
	lfs 0,8(29)
	fsubs 11,11,0
	stfs 11,96(1)
	bl VectorLength
	lwz 9,156(1)
	mr 4,30
	lfs 0,200(9)
	mr 3,9
	lwz 0,852(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,29
	blrl
.L115:
	lis 11,gi+48@ha
	addi 29,31,4
	lwz 0,gi+48@l(11)
	lis 9,0x600
	addi 4,30,4
	ori 9,9,3
	addi 3,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 7,29
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L120
	lis 10,.LC39@ha
	mr 3,29
	la 10,.LC39@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,25
	bl VectorMA
	lwz 0,448(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L120:
	lwz 0,244(1)
	mtlr 0
	lmw 24,184(1)
	lfd 29,216(1)
	lfd 30,224(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe4:
	.size	 fire_tracer,.Lfe4-fire_tracer
	.section	".rodata"
	.align 2
.LC40:
	.string	"misc/lasfly.wav"
	.align 2
.LC41:
	.long 0x46fffe00
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC43:
	.long 0x0
	.align 2
.LC44:
	.long 0x40000000
	.align 3
.LC45:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC46:
	.long 0x46000000
	.align 3
.LC47:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC48:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl fire_blaster
	.type	 fire_blaster,@function
fire_blaster:
	stwu 1,-256(1)
	mflr 0
	stfd 29,232(1)
	stfd 30,240(1)
	stfd 31,248(1)
	stmw 23,196(1)
	stw 0,260(1)
	mr 24,5
	mr 30,3
	mr 29,4
	mr 26,9
	mr 25,6
	mr 28,7
	mr 27,8
	mr 3,24
	bl VectorNormalize
	lis 23,0x4330
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfd 30,0(9)
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	mr 3,24
	lfs 31,0(9)
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,28(31)
	lfs 13,4(29)
	stfs 13,32(31)
	lfs 0,8(29)
	stfs 0,36(31)
	bl vectoangles
	xoris 28,28,0x8000
	stw 28,188(1)
	addi 4,31,380
	mr 3,24
	stw 23,184(1)
	lfd 0,184(1)
	fsub 0,0,30
	frsp 29,0
	fmr 1,29
	bl VectorScale
	lwz 11,64(31)
	li 9,8
	lis 0,0x600
	stw 9,264(31)
	li 10,2
	ori 0,0,3
	or 11,11,27
	lis 9,gi@ha
	stw 10,248(31)
	stw 11,64(31)
	la 28,gi@l(9)
	lis 3,.LC28@ha
	stw 0,252(31)
	la 3,.LC28@l(3)
	stfs 31,196(31)
	stfs 31,192(31)
	stfs 31,188(31)
	stfs 31,208(31)
	stfs 31,204(31)
	stfs 31,200(31)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(31)
	lwz 9,36(28)
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	mtlr 9
	blrl
	lis 9,blaster_touch@ha
	lis 11,.LC44@ha
	stw 3,76(31)
	la 9,blaster_touch@l(9)
	la 11,.LC44@l(11)
	stw 30,256(31)
	stw 9,448(31)
	lis 10,level+4@ha
	cmpwi 0,26,0
	lfs 0,level+4@l(10)
	lis 9,G_FreeEdict@ha
	lfs 13,0(11)
	la 9,G_FreeEdict@l(9)
	lis 11,.LC30@ha
	stw 9,440(31)
	la 11,.LC30@l(11)
	stw 25,520(31)
	fadds 0,0,13
	stw 11,284(31)
	stfs 0,432(31)
	bc 12,2,.L133
	li 0,1
	stw 0,288(31)
.L133:
	lwz 9,72(28)
	mr 3,31
	addi 29,31,4
	mtlr 9
	blrl
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L134
	lis 9,skill@ha
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L135
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC41@ha
	stw 3,188(1)
	lis 10,.LC45@ha
	stw 23,184(1)
	la 10,.LC45@l(10)
	lfd 0,184(1)
	lfs 12,.LC41@l(11)
	lfd 11,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L134
.L135:
	lis 11,.LC46@ha
	addi 5,1,72
	la 11,.LC46@l(11)
	mr 3,29
	lfs 1,0(11)
	mr 4,24
	bl VectorMA
	lwz 0,48(28)
	lis 9,0x600
	addi 3,1,104
	mr 4,29
	li 5,0
	li 6,0
	addi 7,1,72
	mtlr 0
	mr 8,30
	ori 9,9,3
	blrl
	lwz 3,156(1)
	cmpwi 0,3,0
	bc 12,2,.L134
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L134
	lwz 0,484(3)
	cmpwi 0,0,0
	bc 4,1,.L134
	lwz 0,852(3)
	cmpwi 0,0,0
	bc 12,2,.L134
	mr 4,30
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L134
	lfs 13,4(31)
	addi 3,1,88
	lfs 0,116(1)
	lfs 12,120(1)
	lfs 11,124(1)
	fsubs 0,0,13
	stfs 0,88(1)
	lfs 13,4(29)
	fsubs 12,12,13
	stfs 12,92(1)
	lfs 0,8(29)
	fsubs 11,11,0
	stfs 11,96(1)
	bl VectorLength
	lwz 9,156(1)
	mr 4,30
	lfs 0,200(9)
	mr 3,9
	lwz 0,852(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,29
	blrl
.L134:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	addi 4,30,4
	addi 3,1,8
	li 5,0
	li 6,0
	mr 7,29
	mtlr 0
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L139
	lis 10,.LC48@ha
	mr 3,29
	la 10,.LC48@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,24
	bl VectorMA
	lwz 0,448(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L139:
	lwz 0,260(1)
	mtlr 0
	lmw 23,196(1)
	lfd 29,232(1)
	lfd 30,240(1)
	lfd 31,248(1)
	la 1,256(1)
	blr
.Lfe5:
	.size	 fire_blaster,.Lfe5-fire_blaster
	.section	".rodata"
	.align 2
.LC49:
	.long 0xbca3d70a
	.align 2
.LC50:
	.long 0x0
	.align 2
.LC51:
	.long 0x42000000
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC53:
	.long 0x3f000000
	.align 3
.LC54:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Shrapnel_Explode
	.type	 Shrapnel_Explode,@function
Shrapnel_Explode:
	stwu 1,-176(1)
	mflr 0
	stfd 31,168(1)
	stmw 21,124(1)
	stw 0,180(1)
	mr 31,3
	lwz 3,256(31)
	cmpwi 0,3,0
	bc 12,2,.L141
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L141
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L141:
	lis 8,.LC50@ha
	lis 9,.LC51@ha
	lfs 12,4(31)
	la 8,.LC50@l(8)
	la 9,.LC51@l(9)
	lfs 13,8(31)
	lfs 0,12(31)
	addi 22,31,4
	addi 21,31,380
	lfs 11,0(8)
	lfs 10,0(9)
	lwz 0,952(31)
	fadds 12,12,11
	fadds 13,13,11
	cmpwi 0,0,0
	fadds 0,0,10
	stfs 12,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
	stfs 12,48(1)
	stfs 13,52(1)
	stfs 0,56(1)
	bc 4,2,.L142
	lis 11,.LC52@ha
	lis 30,0x6666
	la 11,.LC52@l(11)
	li 9,0
	lfd 31,0(11)
	ori 30,30,26215
	lis 26,0x4330
	lis 23,0x40a0
	li 24,7
	li 25,0
.L146:
	addi 27,9,1
	li 28,8
.L150:
	bl rand
	mulhw 0,3,30
	srawi 9,3,31
	srawi 0,0,4
	subf 0,9,0
	mulli 0,0,40
	subf 3,0,3
	addi 3,3,-20
	xoris 3,3,0x8000
	stw 3,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,32(1)
	bl rand
	mr 11,3
	stw 23,40(1)
	mulhw 0,11,30
	srawi 9,11,31
	stw 24,8(1)
	mr 3,31
	stw 25,12(1)
	addi 4,1,48
	addi 5,1,32
	srawi 0,0,4
	li 6,35
	subf 0,9,0
	li 7,2
	mulli 0,0,40
	li 8,0
	li 9,4500
	li 10,4500
	subf 11,0,11
	addi 11,11,-20
	xoris 11,11,0x8000
	stw 11,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,36(1)
	bl fire_lead
	addic. 28,28,-1
	bc 4,2,.L150
	mr 9,27
	cmpwi 0,9,5
	bc 4,1,.L146
.L142:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 12,2,.L154
	lfs 12,200(31)
	lis 8,.LC53@ha
	addi 29,1,64
	lfs 11,188(31)
	la 8,.LC53@l(8)
	mr 4,29
	lfs 10,204(31)
	mr 5,29
	mr 3,22
	lfs 13,192(31)
	fadds 11,11,12
	lfs 0,196(31)
	lfs 12,208(31)
	fadds 13,13,10
	lfs 1,0(8)
	stfs 11,64(1)
	fadds 0,0,12
	stfs 13,68(1)
	stfs 0,72(1)
	bl VectorMA
	lfs 0,4(31)
	mr 3,29
	lfs 13,8(31)
	lfs 12,12(31)
	lfs 9,64(1)
	lfs 11,68(1)
	lfs 10,72(1)
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,64(1)
	stfs 13,68(1)
	stfs 12,72(1)
	bl VectorLength
	lwz 11,520(31)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lis 8,0x4330
	lwz 0,288(31)
	lfd 9,0(9)
	xoris 11,11,0x8000
	mr 3,31
	stw 11,116(1)
	lis 9,.LC54@ha
	rlwinm 0,0,0,31,31
	stw 8,112(1)
	la 9,.LC54@l(9)
	neg 0,0
	lfd 0,0(9)
	rlwinm 0,0,0,28,31
	li 11,1
	lfd 13,112(1)
	mr 9,10
	lis 8,vec3_origin@ha
	lfs 11,4(31)
	ori 10,0,6
	la 8,vec3_origin@l(8)
	fmul 1,1,0
	lfs 12,8(31)
	mr 4,31
	addi 6,1,80
	fsub 13,13,9
	lfs 0,12(31)
	mr 7,22
	lwz 5,256(31)
	fsubs 11,11,11
	fsubs 12,12,12
	stw 10,12(1)
	fsub 13,13,1
	stw 11,8(1)
	fsubs 0,0,0
	stfs 11,80(1)
	stfs 12,84(1)
	frsp 13,13
	stfs 0,88(1)
	fmr 0,13
	fctiwz 10,0
	stfd 10,112(1)
	lwz 9,116(1)
	mr 10,9
	bl T_Damage
.L154:
	lwz 0,288(31)
	andi. 8,0,2
	bc 12,2,.L157
	li 10,24
	b .L158
.L157:
	andi. 9,0,1
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,29,31
	rlwinm 9,9,0,27,27
	or 10,0,9
.L158:
	lwz 0,520(31)
	lis 11,0x4330
	lis 8,.LC52@ha
	lfs 2,528(31)
	mr 6,10
	xoris 0,0,0x8000
	la 8,.LC52@l(8)
	lwz 4,256(31)
	stw 0,116(1)
	mr 3,31
	mr 5,31
	stw 11,112(1)
	lfd 1,112(1)
	lfd 0,0(8)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,.LC49@ha
	mr 4,21
	lfs 1,.LC49@l(9)
	mr 3,22
	addi 5,1,16
	bl VectorMA
	lis 9,gi@ha
	li 3,3
	la 30,gi@l(9)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 0,620(31)
	cmpwi 0,0,0
	bc 12,2,.L161
	lwz 0,560(31)
	cmpwi 0,0,0
	bc 12,2,.L162
	lwz 0,100(30)
	li 3,18
	b .L167
.L162:
	lwz 0,100(30)
	li 3,17
	b .L167
.L161:
	lwz 0,560(31)
	cmpwi 0,0,0
	bc 12,2,.L165
	lwz 0,100(30)
	li 3,8
.L167:
	mtlr 0
	blrl
	b .L164
.L165:
	lwz 0,100(30)
	li 3,7
	mtlr 0
	blrl
.L164:
	lis 29,gi@ha
	addi 3,1,16
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,22
	li 4,1
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,180(1)
	mtlr 0
	lmw 21,124(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe6:
	.size	 Shrapnel_Explode,.Lfe6-Shrapnel_Explode
	.section	".rodata"
	.align 2
.LC55:
	.string	"Your grenade did not go off!\n"
	.align 2
.LC57:
	.string	"weapons/hgrenb1a.wav"
	.align 2
.LC58:
	.string	"weapons/hgrenb2a.wav"
	.align 2
.LC59:
	.string	"weapons/grenlb1b.wav"
	.align 2
.LC60:
	.string	"You have a live grenade!\n"
	.align 2
.LC56:
	.long 0x46fffe00
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC62:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC63:
	.long 0x3f800000
	.align 2
.LC64:
	.long 0x0
	.section	".text"
	.align 2
	.globl Shrapnel_Touch
	.type	 Shrapnel_Touch,@function
Shrapnel_Touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr. 6,6
	mr 31,3
	mr 29,4
	bc 12,2,.L173
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L173
	bl G_FreeEdict
	b .L172
.L173:
	lwz 0,516(29)
	cmpwi 0,0,0
	bc 12,2,.L175
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 4,2,.L182
.L175:
	cmpw 0,29,31
	bc 12,2,.L174
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L176
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC61@ha
	lis 11,.LC56@ha
	la 10,.LC61@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC62@ha
	lfs 12,.LC56@l(11)
	la 10,.LC62@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L177
	lis 29,gi@ha
	lis 3,.LC57@ha
	la 29,gi@l(29)
	la 3,.LC57@l(3)
	b .L183
.L177:
	lis 29,gi@ha
	lis 3,.LC58@ha
	la 29,gi@l(29)
	la 3,.LC58@l(3)
	b .L183
.L176:
	lis 29,gi@ha
	lis 3,.LC59@ha
	la 29,gi@l(29)
	la 3,.LC59@l(3)
.L183:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC63@ha
	lis 10,.LC63@ha
	lis 11,.LC64@ha
	mr 5,3
	la 9,.LC63@l(9)
	la 10,.LC63@l(10)
	mtlr 0
	la 11,.LC64@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L172
.L174:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L172
.L182:
	lwz 10,84(29)
	lwz 30,4356(10)
	cmpwi 0,30,0
	bc 4,2,.L172
	lis 9,.LC63@ha
	lis 11,invuln_medic@ha
	la 9,.LC63@l(9)
	lfs 13,0(9)
	lwz 9,invuln_medic@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L180
	lwz 0,3464(10)
	cmpwi 0,0,8
	bc 12,2,.L172
.L180:
	lwz 0,664(31)
	lis 9,itemlist@ha
	lis 10,0xc4ec
	la 9,itemlist@l(9)
	ori 10,10,20165
	stw 30,448(31)
	subf 0,9,0
	lwz 11,84(29)
	mr 3,29
	mullw 0,0,10
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	lwz 10,84(29)
	lwz 0,664(31)
	stw 0,4148(10)
	lwz 9,84(29)
	stw 31,4356(9)
	lwz 11,84(29)
	stw 30,4392(11)
	bl ChangeWeapon
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC60@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	stw 30,40(31)
.L172:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 Shrapnel_Touch,.Lfe7-Shrapnel_Touch
	.section	".rodata"
	.align 2
.LC65:
	.string	"*** fire_grenade2 error"
	.align 2
.LC66:
	.string	"USA Grenade"
	.align 2
.LC67:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC68:
	.string	"Potato Masher"
	.align 2
.LC69:
	.string	"models/objects/masher/tris.md2"
	.align 2
.LC70:
	.string	"models/objects/"
	.align 2
.LC71:
	.string	"grenade/tris.md2"
	.align 2
.LC72:
	.long 0x46fffe00
	.align 3
.LC73:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC74:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC75:
	.long 0x40240000
	.long 0x0
	.align 3
.LC76:
	.long 0x40690000
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_grenade2
	.type	 fire_grenade2,@function
fire_grenade2:
	stwu 1,-208(1)
	mflr 0
	stfd 28,176(1)
	stfd 29,184(1)
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 24,144(1)
	stw 0,212(1)
	mr 27,5
	mr 29,3
	mr 30,4
	mr 26,7
	addi 4,1,8
	mr 3,27
	bl vectoangles
	addi 5,1,40
	addi 6,1,56
	mr 24,5
	mr 25,6
	addi 3,1,8
	addi 4,1,24
	bl AngleVectors
	lwz 9,84(29)
	lwz 31,4356(9)
	cmpwi 0,31,0
	bc 12,2,.L184
	li 0,0
	stw 0,4356(9)
	lwz 11,664(31)
	cmpwi 0,11,0
	bc 12,2,.L186
	lis 9,team_list@ha
	lwz 3,88(11)
	lwz 4,team_list@l(9)
	la 28,team_list@l(9)
	addi 4,4,100
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L187
	li 29,0
	b .L191
.L187:
	lwz 9,664(31)
	lwz 4,4(28)
	lwz 3,88(9)
	addi 4,4,100
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L189
	li 29,1
	b .L191
.L189:
	lis 9,gi+8@ha
	lis 5,.LC65@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC65@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L186:
	lwz 9,84(29)
	lwz 11,3448(9)
	lwz 29,84(11)
.L191:
	lwz 9,664(31)
	lis 4,.LC66@ha
	la 4,.LC66@l(4)
	lwz 3,52(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L192
	lis 9,gi+32@ha
	lis 3,.LC67@ha
	lwz 0,gi+32@l(9)
	la 3,.LC67@l(3)
	b .L197
.L192:
	lwz 9,664(31)
	lis 4,.LC68@ha
	la 4,.LC68@l(4)
	lwz 3,52(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L194
	lis 9,gi+32@ha
	lis 3,.LC69@ha
	lwz 0,gi+32@l(9)
	la 3,.LC69@l(3)
	b .L197
.L194:
	lis 11,.LC70@ha
	lis 9,team_list@ha
	lwz 8,.LC70@l(11)
	la 9,team_list@l(9)
	slwi 0,29,2
	lwzx 4,9,0
	la 11,.LC70@l(11)
	addi 29,1,72
	lwz 9,4(11)
	mr 3,29
	lwz 0,8(11)
	addi 4,4,100
	lwz 10,12(11)
	stw 8,72(1)
	stw 9,4(29)
	stw 0,8(29)
	stw 10,12(29)
	bl strcat
	lis 4,.LC71@ha
	mr 3,29
	la 4,.LC71@l(4)
	bl strcat
	lis 9,gi+32@ha
	mr 3,29
	lwz 0,gi+32@l(9)
.L197:
	mtlr 0
	blrl
	stw 3,40(31)
	lis 9,Shrapnel_Touch@ha
	lis 11,gi+72@ha
	la 9,Shrapnel_Touch@l(9)
	mr 3,31
	stw 9,448(31)
	lis 10,.LC74@ha
	lis 28,0x4330
	lwz 0,gi+72@l(11)
	lis 9,.LC73@ha
	la 10,.LC74@l(10)
	la 9,.LC73@l(9)
	lfd 29,0(10)
	addi 29,31,380
	mtlr 0
	lfd 31,0(9)
	lis 9,.LC75@ha
	la 9,.LC75@l(9)
	lfd 28,0(9)
	blrl
	xoris 0,26,0x8000
	lfs 13,0(30)
	stw 0,140(1)
	mr 4,29
	mr 3,27
	stw 28,136(1)
	lfd 1,136(1)
	stfs 13,4(31)
	lfs 0,4(30)
	fsub 1,1,31
	stfs 0,8(31)
	lfs 13,8(30)
	frsp 1,1
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC72@ha
	stw 3,140(1)
	lis 10,.LC76@ha
	mr 4,25
	stw 28,136(1)
	la 10,.LC76@l(10)
	mr 5,29
	lfd 0,136(1)
	mr 3,29
	lfs 30,.LC72@l(11)
	lfd 13,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmadd 1,1,28,13
	frsp 1,1
	bl VectorMA
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	mr 3,29
	stw 0,140(1)
	mr 4,24
	mr 5,3
	stw 28,136(1)
	lfd 0,136(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmul 1,1,28
	frsp 1,1
	bl VectorMA
	lis 0,0x4396
	stw 0,400(31)
	stw 0,392(31)
	stw 0,396(31)
.L184:
	lwz 0,212(1)
	mtlr 0
	lmw 24,144(1)
	lfd 28,176(1)
	lfd 29,184(1)
	lfd 30,192(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe8:
	.size	 fire_grenade2,.Lfe8-fire_grenade2
	.section	".rodata"
	.align 2
.LC78:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC77:
	.long 0xbca3d70a
	.align 2
.LC79:
	.long 0x40000000
	.align 3
.LC80:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl rocket_touch
	.type	 rocket_touch,@function
rocket_touch:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stmw 26,56(1)
	stw 0,84(1)
	stw 12,52(1)
	mr 31,3
	mr 27,4
	lwz 0,256(31)
	mr 26,5
	mr 29,6
	cmpw 0,27,0
	bc 12,2,.L198
	cmpwi 4,29,0
	bc 12,18,.L200
	lwz 0,16(29)
	andi. 9,0,4
	bc 12,2,.L200
	bl G_FreeEdict
	b .L198
.L200:
	lwz 3,256(31)
	addi 28,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L201
	mr 4,28
	li 5,2
	bl PlayerNoise
.L201:
	lis 9,.LC77@ha
	addi 30,31,380
	lfs 1,.LC77@l(9)
	mr 3,28
	mr 4,30
	addi 5,1,16
	bl VectorMA
	lwz 0,516(27)
	cmpwi 0,0,0
	bc 12,2,.L202
	lwz 5,256(31)
	li 0,0
	li 11,8
	lwz 9,520(31)
	mr 6,30
	mr 8,26
	stw 0,8(1)
	mr 3,27
	mr 4,31
	stw 11,12(1)
	mr 7,28
	li 10,0
	bl T_Damage
	b .L203
.L202:
	bc 12,18,.L203
	lwz 0,16(29)
	andi. 9,0,120
	bc 4,2,.L203
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,1
	subf 29,11,0
	slwi 9,29,2
	add 9,9,29
	subf 29,9,3
	cmpwi 0,29,0
	addi 29,29,-1
	bc 12,2,.L203
	lis 30,.LC78@ha
.L207:
	lis 9,.LC79@ha
	mr 3,31
	la 9,.LC79@l(9)
	la 4,.LC78@l(30)
	lfs 1,0(9)
	mr 5,28
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L207
.L203:
	lwz 0,524(31)
	lis 11,0x4330
	lis 10,.LC80@ha
	lfs 2,528(31)
	mr 5,27
	xoris 0,0,0x8000
	la 10,.LC80@l(10)
	lwz 4,256(31)
	stw 0,44(1)
	mr 3,31
	li 6,9
	stw 11,40(1)
	lfd 1,40(1)
	lfd 0,0(10)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,620(31)
	cmpwi 0,0,0
	bc 12,2,.L209
	lwz 0,100(29)
	li 3,17
	mtlr 0
	blrl
	b .L210
.L209:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L210:
	lis 29,gi@ha
	addi 3,1,16
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,1
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
.L198:
	lwz 0,84(1)
	lwz 12,52(1)
	mtlr 0
	lmw 26,56(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe9:
	.size	 rocket_touch,.Lfe9-rocket_touch
	.section	".rodata"
	.align 2
.LC81:
	.string	"models/objects/rocket/tris.md2"
	.align 2
.LC82:
	.string	"weapons/rockfly.wav"
	.align 2
.LC83:
	.string	"rocket"
	.align 2
.LC84:
	.long 0x46fffe00
	.align 3
.LC85:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC86:
	.long 0x0
	.align 3
.LC87:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC88:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_rocket
	.type	 fire_rocket,@function
fire_rocket:
	stwu 1,-192(1)
	mflr 0
	stfd 28,160(1)
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 23,124(1)
	stw 0,196(1)
	mr 30,5
	mr 28,7
	fmr 31,1
	mr 26,8
	mr 27,6
	mr 29,4
	mr 25,3
	bl G_Spawn
	lis 23,0x4330
	lfs 13,0(29)
	mr 31,3
	lis 9,.LC85@ha
	lis 10,.LC86@ha
	la 9,.LC85@l(9)
	la 10,.LC86@l(10)
	lfd 29,0(9)
	mr 3,30
	stfs 13,4(31)
	addi 4,31,16
	lfs 0,4(29)
	lfs 30,0(10)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(30)
	stfs 0,344(31)
	lfs 13,4(30)
	stfs 13,348(31)
	lfs 0,8(30)
	stfs 0,352(31)
	bl vectoangles
	xoris 0,28,0x8000
	stw 0,116(1)
	addi 4,31,380
	mr 3,30
	stw 23,112(1)
	lfd 0,112(1)
	fsub 0,0,29
	frsp 28,0
	fmr 1,28
	bl VectorScale
	lis 0,0x600
	li 11,8
	stfs 30,196(31)
	ori 0,0,3
	li 10,2
	stw 11,264(31)
	lis 9,gi@ha
	stw 0,252(31)
	lis 3,.LC81@ha
	la 24,gi@l(9)
	stw 10,248(31)
	la 3,.LC81@l(3)
	stfs 30,192(31)
	stfs 30,188(31)
	stfs 30,208(31)
	stfs 30,204(31)
	stfs 30,200(31)
	lwz 9,32(24)
	mtlr 9
	blrl
	li 0,8000
	stw 3,40(31)
	divw 0,0,28
	lis 9,rocket_touch@ha
	stw 25,256(31)
	lis 8,level+4@ha
	la 9,rocket_touch@l(9)
	lis 11,G_FreeEdict@ha
	stw 9,448(31)
	la 11,G_FreeEdict@l(11)
	lis 3,.LC82@ha
	lfs 13,level+4@l(8)
	la 3,.LC82@l(3)
	stw 11,440(31)
	stw 27,520(31)
	stw 26,524(31)
	stfs 31,528(31)
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 23,112(1)
	lfd 0,112(1)
	fsub 0,0,29
	frsp 0,0
	fadds 13,13,0
	stfs 13,432(31)
	lwz 9,36(24)
	mtlr 9
	blrl
	lis 9,.LC83@ha
	stw 3,76(31)
	la 9,.LC83@l(9)
	stw 9,284(31)
	lwz 0,84(25)
	cmpwi 0,0,0
	bc 12,2,.L212
	lis 9,skill@ha
	addi 29,31,4
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L213
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC84@ha
	stw 3,116(1)
	lis 10,.LC87@ha
	stw 23,112(1)
	la 10,.LC87@l(10)
	lfd 0,112(1)
	lfs 12,.LC84@l(11)
	lfd 11,0(10)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L212
.L213:
	lis 9,.LC88@ha
	addi 5,1,8
	la 9,.LC88@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 3,29
	bl VectorMA
	lwz 0,48(24)
	lis 9,0x600
	addi 3,1,40
	mr 4,29
	li 5,0
	li 6,0
	addi 7,1,8
	mtlr 0
	mr 8,25
	ori 9,9,3
	blrl
	lwz 3,92(1)
	cmpwi 0,3,0
	bc 12,2,.L212
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L212
	lwz 0,484(3)
	cmpwi 0,0,0
	bc 4,1,.L212
	lwz 0,852(3)
	cmpwi 0,0,0
	bc 12,2,.L212
	mr 4,25
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L212
	lfs 13,4(31)
	addi 3,1,24
	lfs 0,52(1)
	lfs 12,56(1)
	lfs 11,60(1)
	fsubs 0,0,13
	stfs 0,24(1)
	lfs 13,4(29)
	fsubs 12,12,13
	stfs 12,28(1)
	lfs 0,8(29)
	fsubs 11,11,0
	stfs 11,32(1)
	bl VectorLength
	lwz 9,92(1)
	mr 4,25
	lfs 0,200(9)
	mr 3,9
	lwz 0,852(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,28
	blrl
.L212:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,196(1)
	mtlr 0
	lmw 23,124(1)
	lfd 28,160(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe10:
	.size	 fire_rocket,.Lfe10-fire_rocket
	.section	".rodata"
	.align 2
.LC89:
	.string	"world/sparks3.wav"
	.align 2
.LC90:
	.string	"shell"
	.align 2
.LC91:
	.long 0x46fffe00
	.align 3
.LC92:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC93:
	.long 0x0
	.align 3
.LC94:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC95:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_shell
	.type	 fire_shell,@function
fire_shell:
	stwu 1,-192(1)
	mflr 0
	stfd 28,160(1)
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 23,124(1)
	stw 0,196(1)
	mr 30,5
	mr 28,7
	fmr 31,1
	mr 26,8
	mr 27,6
	mr 29,4
	mr 25,3
	bl G_Spawn
	lis 23,0x4330
	lfs 13,0(29)
	mr 31,3
	lis 9,.LC92@ha
	lis 10,.LC93@ha
	la 9,.LC92@l(9)
	la 10,.LC93@l(10)
	lfd 29,0(9)
	mr 3,30
	stfs 13,4(31)
	addi 4,31,16
	lfs 0,4(29)
	lfs 30,0(10)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(30)
	stfs 0,344(31)
	lfs 13,4(30)
	stfs 13,348(31)
	lfs 0,8(30)
	stfs 0,352(31)
	bl vectoangles
	xoris 0,28,0x8000
	stw 0,116(1)
	addi 4,31,380
	mr 3,30
	stw 23,112(1)
	lfd 0,112(1)
	fsub 0,0,29
	frsp 28,0
	fmr 1,28
	bl VectorScale
	lis 0,0x600
	li 11,8
	stfs 30,196(31)
	ori 0,0,3
	li 10,2
	stw 11,264(31)
	lis 9,gi@ha
	stw 0,252(31)
	lis 3,.LC81@ha
	la 24,gi@l(9)
	stw 10,248(31)
	la 3,.LC81@l(3)
	stfs 30,192(31)
	stfs 30,188(31)
	stfs 30,208(31)
	stfs 30,204(31)
	stfs 30,200(31)
	lwz 9,32(24)
	mtlr 9
	blrl
	li 0,8000
	stw 3,40(31)
	divw 0,0,28
	lis 9,rocket_touch@ha
	stw 25,256(31)
	lis 8,level+4@ha
	la 9,rocket_touch@l(9)
	lis 11,G_FreeEdict@ha
	stw 9,448(31)
	la 11,G_FreeEdict@l(11)
	lis 3,.LC89@ha
	lfs 13,level+4@l(8)
	la 3,.LC89@l(3)
	stw 11,440(31)
	stw 27,520(31)
	stw 26,524(31)
	stfs 31,528(31)
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 23,112(1)
	lfd 0,112(1)
	fsub 0,0,29
	frsp 0,0
	fadds 13,13,0
	stfs 13,432(31)
	lwz 9,36(24)
	mtlr 9
	blrl
	lis 9,.LC90@ha
	stw 3,76(31)
	la 9,.LC90@l(9)
	stw 9,284(31)
	lwz 0,84(25)
	cmpwi 0,0,0
	bc 12,2,.L218
	lis 9,skill@ha
	addi 29,31,4
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L219
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC91@ha
	stw 3,116(1)
	lis 10,.LC94@ha
	stw 23,112(1)
	la 10,.LC94@l(10)
	lfd 0,112(1)
	lfs 12,.LC91@l(11)
	lfd 11,0(10)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L218
.L219:
	lis 9,.LC95@ha
	addi 5,1,8
	la 9,.LC95@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 3,29
	bl VectorMA
	lwz 0,48(24)
	lis 9,0x600
	addi 3,1,40
	mr 4,29
	li 5,0
	li 6,0
	addi 7,1,8
	mtlr 0
	mr 8,25
	ori 9,9,3
	blrl
	lwz 3,92(1)
	cmpwi 0,3,0
	bc 12,2,.L218
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L218
	lwz 0,484(3)
	cmpwi 0,0,0
	bc 4,1,.L218
	lwz 0,852(3)
	cmpwi 0,0,0
	bc 12,2,.L218
	mr 4,25
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L218
	lfs 13,4(31)
	addi 3,1,24
	lfs 0,52(1)
	lfs 12,56(1)
	lfs 11,60(1)
	fsubs 0,0,13
	stfs 0,24(1)
	lfs 13,4(29)
	fsubs 12,12,13
	stfs 12,28(1)
	lfs 0,8(29)
	fsubs 11,11,0
	stfs 11,32(1)
	bl VectorLength
	lwz 9,92(1)
	mr 4,25
	lfs 0,200(9)
	mr 3,9
	lwz 0,852(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,28
	blrl
.L218:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,196(1)
	mtlr 0
	lmw 23,124(1)
	lfd 28,160(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe11:
	.size	 fire_shell,.Lfe11-fire_shell
	.section	".rodata"
	.align 2
.LC96:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_rifle
	.type	 fire_rifle,@function
fire_rifle:
	stwu 1,-176(1)
	mflr 0
	stmw 18,120(1)
	stw 0,180(1)
	lis 9,.LC96@ha
	mr 25,5
	la 9,.LC96@l(9)
	mr 26,4
	lfs 1,0(9)
	mr 29,3
	addi 5,1,32
	mr 18,5
	mr 21,6
	mr 22,7
	mr 23,8
	mr 3,26
	mr 4,25
	bl VectorMA
	lis 30,0x600
	mr 31,29
	lfs 12,0(26)
	cmpwi 0,29,0
	li 24,0
	lfs 13,4(26)
	ori 30,30,27
	addi 28,1,60
	lfs 0,8(26)
	addi 27,1,72
	stfs 12,16(1)
	stfs 13,20(1)
	stfs 0,24(1)
	bc 12,2,.L225
	lis 9,gi@ha
	li 20,0
	la 19,gi@l(9)
.L226:
	lwz 11,48(19)
	mr 9,30
	addi 3,1,48
	addi 4,1,16
	li 5,0
	li 6,0
	mr 7,18
	mtlr 11
	mr 8,31
	blrl
	lwz 0,96(1)
	andi. 9,0,24
	bc 12,2,.L227
	li 24,1
	rlwinm 30,30,0,29,26
	b .L228
.L227:
	lwz 9,100(1)
	lwz 0,184(9)
	mr 3,9
	andi. 9,0,4
	bc 4,2,.L230
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L229
.L230:
	mr 31,3
	b .L231
.L229:
	li 31,0
.L231:
	cmpw 0,3,29
	bc 12,2,.L228
	lwz 0,516(3)
	cmpwi 0,0,0
	bc 12,2,.L228
	stw 20,8(1)
	mr 4,29
	mr 5,29
	stw 23,12(1)
	mr 6,25
	mr 7,28
	mr 8,27
	mr 9,21
	mr 10,22
	bl T_Damage
.L228:
	lfs 0,60(1)
	cmpwi 0,31,0
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	bc 4,2,.L226
.L225:
	lis 9,gi@ha
	li 3,3
	la 31,gi@l(9)
	lwz 9,100(31)
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,0
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(31)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,88(31)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	cmpwi 0,24,0
	bc 12,2,.L234
	lwz 9,100(31)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,11
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(31)
	mr 3,28
	li 4,1
	mtlr 0
	blrl
.L234:
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L235
	mr 3,29
	mr 4,28
	li 5,2
	bl PlayerNoise
.L235:
	lwz 0,180(1)
	mtlr 0
	lmw 18,120(1)
	la 1,176(1)
	blr
.Lfe12:
	.size	 fire_rifle,.Lfe12-fire_rifle
	.section	".rodata"
	.align 3
.LC97:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC98:
	.long 0x41c00000
	.align 2
.LC99:
	.long 0x41000000
	.align 2
.LC100:
	.long 0xc0000000
	.align 2
.LC101:
	.long 0x41a00000
	.align 3
.LC102:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ApplyFirstAid
	.type	 ApplyFirstAid,@function
ApplyFirstAid:
	stwu 1,-192(1)
	mflr 0
	stmw 24,160(1)
	stw 0,196(1)
	mr 29,3
	addi 27,1,24
	lwz 3,84(29)
	addi 26,1,40
	addi 4,1,8
	mr 5,27
	li 6,0
	addi 3,3,4264
	addi 24,29,4
	bl AngleVectors
	lis 11,.LC97@ha
	lwz 9,512(29)
	la 11,.LC97@l(11)
	lis 0,0x4330
	lwz 3,84(29)
	lfd 11,0(11)
	addi 9,9,-8
	addi 25,1,136
	lis 11,vec3_origin@ha
	xoris 9,9,0x8000
	la 28,vec3_origin@l(11)
	lfs 12,vec3_origin@l(11)
	addi 6,1,8
	lis 11,.LC98@ha
	stw 9,156(1)
	addi 5,1,56
	la 11,.LC98@l(11)
	stw 0,152(1)
	lis 9,.LC99@ha
	lfs 0,0(11)
	la 9,.LC99@l(9)
	mr 7,27
	lfs 10,0(9)
	mr 8,26
	mr 4,24
	lfs 9,8(28)
	fadds 12,12,0
	lfs 13,4(28)
	lfd 0,152(1)
	fadds 13,13,10
	stfs 12,56(1)
	fsub 0,0,11
	stfs 13,60(1)
	frsp 0,0
	fadds 0,0,9
	stfs 0,64(1)
	bl P_ProjectSource
	lis 9,.LC100@ha
	lwz 4,84(29)
	addi 3,1,8
	la 9,.LC100@l(9)
	lfs 1,0(9)
	addi 4,4,4212
	bl VectorScale
	lis 11,.LC101@ha
	lwz 9,84(29)
	lis 0,0xbf80
	la 11,.LC101@l(11)
	addi 4,1,8
	lfs 1,0(11)
	mr 3,26
	mr 5,25
	stw 0,4200(9)
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mr 4,24
	mr 7,25
	mr 8,29
	addi 3,1,72
	li 5,0
	mtlr 0
	li 6,0
	blrl
	lwz 9,116(1)
	cmpwi 0,9,0
	bc 12,2,.L238
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L237
.L238:
	lfs 0,80(1)
	lis 11,.LC102@ha
	la 11,.LC102@l(11)
	lfd 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L237
	lwz 3,124(1)
	lwz 9,516(3)
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and 3,3,0
	b .L242
.L237:
	li 3,0
.L242:
	lwz 0,196(1)
	mtlr 0
	lmw 24,160(1)
	la 1,192(1)
	blr
.Lfe13:
	.size	 ApplyFirstAid,.Lfe13-ApplyFirstAid
	.section	".sbss","aw",@nobits
	.align 2
lastone.72:
	.space	4
	.size	 lastone.72,4
	.section	".rodata"
	.align 2
.LC103:
	.string	"player/male/jump1.wav"
	.align 2
.LC104:
	.string	"soldier/solidle1.wav"
	.align 2
.LC105:
	.string	"player/male/fall2.wav"
	.align 2
.LC106:
	.string	"player/male/pain25_2"
	.align 2
.LC107:
	.string	"player/male/pain50_2.wav"
	.align 2
.LC108:
	.string	"player/male/pain100_1.wav"
	.align 2
.LC109:
	.string	"player/male/pain100_2.wav"
	.align 2
.LC110:
	.string	"player/male/pain75_1.wav"
	.align 2
.LC111:
	.string	"player/male/pain75_2.wav"
	.align 2
.LC112:
	.string	"chick/chkdeth2.wav"
	.align 2
.LC113:
	.string	"chick/chkidle1.wav"
	.align 2
.LC114:
	.string	"chick/chkidle2.wav"
	.align 2
.LC115:
	.string	"chick/chksrch2.wav"
	.align 2
.LC116:
	.string	"player/female/fall2.wav"
	.align 2
.LC117:
	.string	"chick/cchkidle2.wav"
	.align 2
.LC118:
	.string	"chick/chkpain1.wav"
	.align 2
.LC119:
	.string	"chick/chkpain2.wav"
	.align 2
.LC120:
	.string	"player/male/chick/chkpain3.wav"
	.align 2
.LC121:
	.string	"chick/chkatck1.wav"
	.align 2
.LC122:
	.string	"player/male/death1.wav"
	.align 3
.LC123:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC124:
	.long 0x41c00000
	.align 2
.LC125:
	.long 0x41a80000
	.align 2
.LC126:
	.long 0x41a00000
	.align 2
.LC127:
	.long 0x41800000
	.align 2
.LC128:
	.long 0x41700000
	.align 2
.LC129:
	.long 0x41600000
	.align 2
.LC130:
	.long 0x41500000
	.align 2
.LC131:
	.long 0x41400000
	.align 2
.LC132:
	.long 0x41300000
	.align 2
.LC133:
	.long 0x41200000
	.align 2
.LC134:
	.long 0x41100000
	.align 2
.LC135:
	.long 0x41000000
	.align 2
.LC136:
	.long 0x40e00000
	.align 2
.LC137:
	.long 0x40c00000
	.align 2
.LC138:
	.long 0x40a00000
	.align 2
.LC139:
	.long 0x40800000
	.align 2
.LC140:
	.long 0x40400000
	.align 2
.LC141:
	.long 0x41980000
	.align 2
.LC142:
	.long 0x41c80000
	.section	".text"
	.align 2
	.globl DoAnarchyStuff
	.type	 DoAnarchyStuff,@function
DoAnarchyStuff:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 27,28(1)
	stw 0,68(1)
	mr 27,3
	lwz 0,1000(27)
	mr 3,4
	cmpwi 0,0,0
	bc 4,2,.L244
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	b .L287
.L244:
	li 3,0
	lis 29,0x4ec4
	bl time
	ori 29,29,60495
	lis 28,0x4330
	lis 9,.LC123@ha
	la 9,.LC123@l(9)
	lfd 31,0(9)
	bl srand
	bl rand
	mulhw 0,3,29
	srawi 9,3,31
	srawi 0,0,3
	subf 0,9,0
	mulli 0,0,26
	subf 3,0,3
	xoris 3,3,0x8000
	stw 3,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 30,0
	bl rand
	mulhw 29,3,29
	srawi 8,3,31
	lwz 11,1004(27)
	lis 9,lastone.72@ha
	srawi 29,29,3
	lwz 0,lastone.72@l(9)
	addi 11,11,1
	subf 29,8,29
	stw 11,1004(27)
	mulli 29,29,26
	cmpwi 0,0,1
	subf 3,29,3
	xoris 3,3,0x8000
	stw 3,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 31,0
	bc 4,2,.L245
	lis 9,.LC124@ha
	lis 10,.LC125@ha
	la 9,.LC124@l(9)
	la 10,.LC125@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,30,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L246
	lis 9,gi+36@ha
	lis 3,.LC103@ha
	lwz 0,gi+36@l(9)
	la 3,.LC103@l(3)
	b .L288
.L246:
	lis 9,.LC126@ha
	lis 10,.LC127@ha
	la 9,.LC126@l(9)
	la 10,.LC127@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,30,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L248
	lis 9,gi+36@ha
	lis 3,.LC104@ha
	lwz 0,gi+36@l(9)
	la 3,.LC104@l(3)
	b .L288
.L248:
	lis 9,.LC128@ha
	lis 10,.LC129@ha
	la 9,.LC128@l(9)
	la 10,.LC129@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,30,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L250
	lis 9,gi+36@ha
	lis 3,.LC105@ha
	lwz 0,gi+36@l(9)
	la 3,.LC105@l(3)
	b .L288
.L250:
	lis 9,.LC130@ha
	lis 10,.LC131@ha
	la 9,.LC130@l(9)
	la 10,.LC131@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,30,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L252
	lis 9,gi+36@ha
	lis 3,.LC106@ha
	lwz 0,gi+36@l(9)
	la 3,.LC106@l(3)
	b .L288
.L252:
	lis 9,.LC132@ha
	lis 10,.LC133@ha
	la 9,.LC132@l(9)
	la 10,.LC133@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,30,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L254
	lis 9,gi+36@ha
	lis 3,.LC107@ha
	lwz 0,gi+36@l(9)
	la 3,.LC107@l(3)
	b .L288
.L254:
	lis 9,.LC134@ha
	lis 10,.LC135@ha
	la 9,.LC134@l(9)
	la 10,.LC135@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,30,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L256
	lis 9,gi+36@ha
	lis 3,.LC108@ha
	lwz 0,gi+36@l(9)
	la 3,.LC108@l(3)
	b .L288
.L256:
	lis 9,.LC136@ha
	lis 10,.LC137@ha
	la 9,.LC136@l(9)
	la 10,.LC137@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,30,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L258
	lis 9,gi+36@ha
	lis 3,.LC109@ha
	lwz 0,gi+36@l(9)
	la 3,.LC109@l(3)
	b .L288
.L258:
	lis 9,.LC138@ha
	lis 10,.LC139@ha
	la 9,.LC138@l(9)
	la 10,.LC139@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,30,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L260
	lis 9,gi+36@ha
	lis 3,.LC110@ha
	lwz 0,gi+36@l(9)
	la 3,.LC110@l(3)
	b .L288
.L260:
	lis 9,.LC140@ha
	la 9,.LC140@l(9)
	lfs 0,0(9)
	fcmpu 0,30,0
	cror 3,2,0
	bc 4,3,.L247
	lis 9,gi+36@ha
	lis 3,.LC111@ha
	lwz 0,gi+36@l(9)
	la 3,.LC111@l(3)
.L288:
	mtlr 0
	blrl
	mr 31,3
.L247:
	lis 9,lastone.72@ha
	li 0,0
	b .L289
.L245:
	lis 9,.LC124@ha
	lis 10,.LC126@ha
	la 9,.LC124@l(9)
	la 10,.LC126@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,31,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L264
	lis 9,gi+36@ha
	lis 3,.LC112@ha
	lwz 0,gi+36@l(9)
	la 3,.LC112@l(3)
	b .L290
.L264:
	lis 9,.LC141@ha
	lis 10,.LC128@ha
	la 9,.LC141@l(9)
	la 10,.LC128@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,31,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L266
	lis 9,gi+36@ha
	lis 3,.LC113@ha
	lwz 0,gi+36@l(9)
	la 3,.LC113@l(3)
	b .L290
.L266:
	lis 9,.LC129@ha
	lis 10,.LC130@ha
	la 9,.LC129@l(9)
	la 10,.LC130@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,31,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L268
	lis 9,gi+36@ha
	lis 3,.LC114@ha
	lwz 0,gi+36@l(9)
	la 3,.LC114@l(3)
	b .L290
.L268:
	lis 9,.LC131@ha
	lis 10,.LC132@ha
	la 9,.LC131@l(9)
	la 10,.LC132@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,31,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L270
	lis 9,gi+36@ha
	lis 3,.LC115@ha
	lwz 0,gi+36@l(9)
	la 3,.LC115@l(3)
	b .L290
.L270:
	lis 9,.LC133@ha
	lis 10,.LC134@ha
	la 9,.LC133@l(9)
	la 10,.LC134@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,31,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L272
	lis 9,gi+36@ha
	lis 3,.LC116@ha
	lwz 0,gi+36@l(9)
	la 3,.LC116@l(3)
	b .L290
.L272:
	lis 9,.LC135@ha
	la 9,.LC135@l(9)
	lfs 0,0(9)
	fcmpu 7,30,0
	fcmpu 6,31,0
	cror 31,30,29
	cror 27,26,24
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 10,0,9
	bc 12,2,.L274
	lis 9,gi+36@ha
	lis 3,.LC117@ha
	lwz 0,gi+36@l(9)
	la 3,.LC117@l(3)
	b .L290
.L274:
	lis 9,.LC136@ha
	lis 10,.LC137@ha
	la 9,.LC136@l(9)
	la 10,.LC137@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,31,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L276
	lis 9,gi+36@ha
	lis 3,.LC118@ha
	lwz 0,gi+36@l(9)
	la 3,.LC118@l(3)
	b .L290
.L276:
	lis 9,.LC138@ha
	lis 10,.LC139@ha
	la 9,.LC138@l(9)
	la 10,.LC139@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fcmpu 7,31,0
	fcmpu 6,30,13
	cror 31,30,28
	cror 27,26,25
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,28,1
	and. 11,9,0
	bc 12,2,.L278
	lis 9,gi+36@ha
	lis 3,.LC119@ha
	lwz 0,gi+36@l(9)
	la 3,.LC119@l(3)
	b .L290
.L278:
	lis 9,.LC140@ha
	la 9,.LC140@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	cror 3,2,0
	bc 4,3,.L265
	lis 9,gi+36@ha
	lis 3,.LC120@ha
	lwz 0,gi+36@l(9)
	la 3,.LC120@l(3)
.L290:
	mtlr 0
	blrl
	mr 30,3
.L265:
	lis 9,lastone.72@ha
	li 0,1
.L289:
	stw 0,lastone.72@l(9)
	lis 9,.LC142@ha
	lwz 11,1004(27)
	la 9,.LC142@l(9)
	lfs 0,0(9)
	fcmpu 7,31,0
	fcmpu 6,30,0
	mfcr 0
	rlwinm 9,0,31,1
	rlwinm 0,0,27,1
	or. 10,0,9
	bc 4,2,.L282
	cmpwi 0,11,13
	bc 4,2,.L281
.L282:
	cmpwi 0,11,7
	bc 4,1,.L283
	lis 29,gi@ha
	lis 3,.LC121@ha
	la 29,gi@l(29)
	la 3,.LC121@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,36(29)
	mr 30,3
	lis 3,.LC122@ha
	mtlr 0
	la 3,.LC122@l(3)
	blrl
	li 0,0
	mr 31,3
	stw 0,1004(27)
	stw 0,1000(27)
	b .L281
.L283:
	lis 29,gi@ha
	lis 3,.LC112@ha
	la 29,gi@l(29)
	la 3,.LC112@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	mr 30,3
	lwz 0,36(29)
	lis 3,.LC103@ha
	la 3,.LC103@l(3)
	mtlr 0
	blrl
	mr 31,3
.L281:
	lis 9,lastone.72@ha
	lwz 0,lastone.72@l(9)
	srawi 9,0,31
	xor 3,9,0
	subf 3,3,9
	srawi 3,3,31
	andc 0,31,3
	and 3,30,3
	or 3,3,0
.L287:
	lwz 0,68(1)
	mtlr 0
	lmw 27,28(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 DoAnarchyStuff,.Lfe14-DoAnarchyStuff
	.section	".rodata"
	.align 2
.LC143:
	.string	"weapons/noammo.wav"
	.align 2
.LC144:
	.string	"*** Firing System Error\n"
	.align 2
.LC145:
	.long 0x3f800000
	.align 2
.LC146:
	.long 0x0
	.align 3
.LC147:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC148:
	.long 0x40000000
	.align 2
.LC149:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Weapon_Pistol_Fire
	.type	 Weapon_Pistol_Fire,@function
Weapon_Pistol_Fire:
	stwu 1,-160(1)
	mflr 0
	stmw 23,124(1)
	stw 0,164(1)
	mr 31,3
	lis 9,level@ha
	lwz 8,84(31)
	la 27,level@l(9)
	lwz 10,level@l(9)
	lwz 11,1796(8)
	lwz 0,4384(8)
	lwz 30,96(11)
	cmpw 0,0,10
	lwz 7,100(11)
	lwz 24,88(30)
	lwz 25,92(30)
	bc 12,1,.L291
	lwz 0,4132(8)
	andi. 0,0,1
	bc 4,2,.L293
	stw 0,4320(8)
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L291
.L293:
	lwz 9,92(8)
	mulli 11,7,48
	addi 9,9,1
	mr 28,11
	stw 9,92(8)
	lwz 10,84(31)
	addi 9,10,4400
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 4,2,.L294
	lwz 9,32(30)
	addi 9,9,1
	stw 9,92(10)
	lfs 13,4(27)
	lfs 0,468(31)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L291
	lis 29,gi@ha
	lis 3,.LC143@ha
	la 29,gi@l(29)
	la 3,.LC143@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC145@ha
	lwz 0,16(29)
	lis 11,.LC145@ha
	la 9,.LC145@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC145@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC146@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC146@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC145@ha
	lfs 0,4(27)
	la 9,.LC145@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,468(31)
	b .L291
.L294:
	li 11,2
	addi 3,1,80
	mtctr 11
	addi 29,1,32
	addi 27,1,48
	addi 23,31,4
	addi 26,1,64
.L298:
	bdnz .L298
	lwz 9,84(31)
	mr 4,29
	mr 5,27
	li 6,0
	lfs 13,4200(9)
	lfs 0,4264(9)
	fadds 0,0,13
	stfs 0,80(1)
	lfs 0,4204(9)
	lfs 13,4268(9)
	fadds 13,13,0
	stfs 13,84(1)
	lfs 12,4208(9)
	lfs 0,4272(9)
	fadds 0,0,12
	stfs 0,88(1)
	bl AngleVectors
	lwz 9,84(31)
	lwz 11,1796(9)
	lwz 0,68(11)
	cmpwi 0,0,3
	bc 4,2,.L301
	lwz 0,512(31)
	lis 10,0x4330
	lis 11,.LC147@ha
	xoris 0,0,0x8000
	la 11,.LC147@l(11)
	stw 0,116(1)
	stw 10,112(1)
	lfd 13,0(11)
	lfd 0,112(1)
	li 11,0
	stw 11,20(1)
	stw 11,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,24(1)
	b .L302
.L301:
	lis 9,gi+4@ha
	lis 3,.LC144@ha
	lwz 0,gi+4@l(9)
	la 3,.LC144@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L302:
	lwz 3,84(31)
	addi 5,1,16
	mr 7,27
	mr 4,23
	mr 6,29
	mr 8,26
	bl P_ProjectSource
	li 0,0
	li 9,0
	stw 0,8(1)
	mr 4,26
	mr 5,29
	mr 6,25
	mr 10,24
	mr 3,31
	li 7,2
	li 8,0
	bl fire_gun
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L303
	lis 11,.LC148@ha
	lfs 0,4200(9)
	la 11,.LC148@l(11)
	b .L307
.L303:
	lis 11,.LC149@ha
	lfs 0,4200(9)
	la 11,.LC149@l(11)
.L307:
	lfs 13,0(11)
	fsubs 0,0,13
	stfs 0,4200(9)
	lwz 10,84(31)
	addi 9,10,4400
	lwzx 0,9,28
	cmpwi 0,0,1
	bc 4,2,.L305
	lwz 11,40(30)
	li 0,4
	lis 29,gi@ha
	la 29,gi@l(29)
	addi 11,11,1
	stw 11,92(10)
	lwz 9,84(31)
	stw 0,4192(9)
	lwz 9,36(29)
	lwz 3,84(30)
	mtlr 9
	blrl
	lis 9,.LC145@ha
	lwz 0,16(29)
	lis 11,.LC145@ha
	la 9,.LC145@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC145@l(11)
	li 4,1
	mtlr 0
	lis 9,.LC146@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC146@l(9)
	lfs 3,0(9)
	blrl
.L305:
	lwz 11,84(31)
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	addi 11,11,4400
	lwzx 9,11,28
	addi 9,9,-1
	stwx 9,11,28
	lwz 4,80(30)
	bl DoAnarchyStuff
	lis 9,.LC145@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC145@l(9)
	li 4,1
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC145@ha
	la 9,.LC145@l(9)
	lfs 2,0(9)
	lis 9,.LC146@ha
	la 9,.LC146@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lis 9,is_silenced@ha
	lwz 11,100(29)
	lbz 3,is_silenced@l(9)
	mtlr 11
	ori 3,3,1
	blrl
	lwz 0,88(29)
	mr 3,23
	li 4,2
	mtlr 0
	blrl
	lis 9,level@ha
	lwz 10,100(30)
	lwz 0,level@l(9)
	lwz 11,84(31)
	add 0,0,10
	stw 0,4384(11)
.L291:
	lwz 0,164(1)
	mtlr 0
	lmw 23,124(1)
	la 1,160(1)
	blr
.Lfe15:
	.size	 Weapon_Pistol_Fire,.Lfe15-Weapon_Pistol_Fire
	.section	".rodata"
	.align 2
.LC150:
	.long 0x3f800000
	.align 2
.LC151:
	.long 0x0
	.align 3
.LC152:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC153:
	.long 0x40040000
	.long 0x0
	.align 2
.LC154:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Weapon_Rifle_Fire
	.type	 Weapon_Rifle_Fire,@function
Weapon_Rifle_Fire:
	stwu 1,-144(1)
	mflr 0
	stmw 20,96(1)
	stw 0,148(1)
	mr 31,3
	lwz 8,84(31)
	lwz 9,1796(8)
	addi 10,8,4416
	lwz 7,100(9)
	lwz 27,96(9)
	mulli 11,7,48
	lwz 20,88(27)
	lwzx 0,10,11
	lwz 21,92(27)
	cmpwi 0,0,1
	bc 12,2,.L309
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L309:
	lwz 10,84(31)
	lwz 0,4132(10)
	andi. 9,0,1
	bc 4,2,.L310
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 12,2,.L311
	lwz 0,36(27)
	b .L333
.L311:
	lwz 0,32(27)
.L333:
	stw 0,92(10)
	lwz 9,84(31)
	li 10,0
	stw 10,4320(9)
	lwz 11,84(31)
	lwz 0,4132(11)
	ori 0,0,1
	stw 0,4132(11)
	lwz 9,84(31)
	stw 10,4192(9)
	b .L308
.L310:
	lis 9,level@ha
	lwz 11,4384(10)
	lwz 0,level@l(9)
	cmpw 0,11,0
	bc 4,1,.L313
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 12,2,.L314
	lwz 9,36(27)
	b .L334
.L314:
	lwz 9,32(27)
.L334:
	addi 9,9,1
	stw 9,92(10)
.L313:
	lwz 10,84(31)
	lwz 9,4496(10)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 4,2,.L316
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 12,2,.L317
	lwz 9,36(27)
	b .L335
.L317:
	lwz 9,32(27)
.L335:
	addi 0,9,1
	lis 9,level@ha
	stw 0,92(10)
	la 30,level@l(9)
	lfs 13,468(31)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L308
	lis 29,gi@ha
	lis 3,.LC143@ha
	la 29,gi@l(29)
	la 3,.LC143@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC150@ha
	lis 10,.LC150@ha
	lis 11,.LC151@ha
	la 9,.LC150@l(9)
	mr 5,3
	la 10,.LC150@l(10)
	lfs 1,0(9)
	mtlr 0
	la 11,.LC151@l(11)
	li 4,2
	lfs 2,0(10)
	mr 3,31
	lfs 3,0(11)
	blrl
	lis 9,.LC150@ha
	lfs 0,4(30)
	la 9,.LC150@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,468(31)
	b .L308
.L316:
	lis 9,level@ha
	lwz 0,4384(10)
	lwz 9,level@l(9)
	cmpw 0,0,9
	bc 12,1,.L308
	lwz 0,100(27)
	mulli 11,7,48
	add 0,9,0
	mr 23,11
	stw 0,4384(10)
	lwz 10,84(31)
	addi 9,10,4416
	lwzx 0,9,11
	cmpwi 0,0,1
	bc 4,2,.L321
	lwz 11,40(27)
	li 0,4
	lis 29,gi@ha
	la 29,gi@l(29)
	addi 11,11,1
	stw 11,92(10)
	lwz 9,84(31)
	stw 0,4192(9)
	lwz 9,36(29)
	lwz 3,84(27)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC150@ha
	lis 10,.LC150@ha
	lis 11,.LC151@ha
	mr 5,3
	la 9,.LC150@l(9)
	la 10,.LC150@l(10)
	mtlr 0
	la 11,.LC151@l(11)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L321:
	addi 26,1,32
	addi 25,1,48
	addi 22,31,4
	addi 24,1,64
	li 30,2
.L325:
	addic. 30,30,-1
	bc 4,2,.L325
	lwz 11,84(31)
	mr 4,26
	mr 5,25
	li 6,0
	lwz 9,4320(11)
	addi 9,9,1
	stw 9,4320(11)
	lwz 3,84(31)
	addi 3,3,4264
	bl AngleVectors
	lis 10,.LC152@ha
	lwz 11,84(31)
	li 0,4
	la 10,.LC152@l(10)
	lfd 13,0(10)
	lis 28,0x4330
	li 29,0
	lwz 10,1796(11)
	addi 8,1,16
	mr 5,24
	mr 7,25
	mr 4,22
	stw 0,68(10)
	mr 6,26
	lwz 0,512(31)
	lwz 3,84(31)
	xoris 0,0,0x8000
	stw 29,68(1)
	stw 0,92(1)
	stw 28,88(1)
	lfd 0,88(1)
	stw 29,64(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,72(1)
	bl P_ProjectSource
	li 9,0
	stw 30,8(1)
	mr 5,26
	mr 6,21
	mr 10,20
	mr 3,31
	addi 4,1,16
	li 7,200
	li 8,0
	bl fire_gun
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L330
	lfs 0,4200(9)
	lis 10,.LC153@ha
	la 10,.LC153@l(10)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	b .L336
.L330:
	lis 11,.LC154@ha
	lfs 0,4200(9)
	la 11,.LC154@l(11)
	lfs 13,0(11)
	fsubs 0,0,13
.L336:
	stfs 0,4200(9)
	lwz 11,84(31)
	lis 29,gi@ha
	la 29,gi@l(29)
	addi 11,11,4416
	lwzx 9,11,23
	addi 9,9,-1
	stwx 9,11,23
	lwz 9,36(29)
	lwz 3,80(27)
	mtlr 9
	blrl
	lis 9,.LC150@ha
	lwz 11,16(29)
	lis 10,.LC150@ha
	la 9,.LC150@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC150@l(10)
	li 4,1
	mtlr 11
	lis 9,.LC151@ha
	lfs 2,0(10)
	mr 3,31
	la 9,.LC151@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lis 9,is_silenced@ha
	lwz 11,100(29)
	lbz 3,is_silenced@l(9)
	mtlr 11
	ori 3,3,1
	blrl
	lwz 0,88(29)
	mr 3,22
	li 4,2
	mtlr 0
	blrl
.L308:
	lwz 0,148(1)
	mtlr 0
	lmw 20,96(1)
	la 1,144(1)
	blr
.Lfe16:
	.size	 Weapon_Rifle_Fire,.Lfe16-Weapon_Rifle_Fire
	.section	".rodata"
	.align 2
.LC155:
	.long 0x3f800000
	.align 2
.LC156:
	.long 0x0
	.align 3
.LC157:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC158:
	.long 0x3ff80000
	.long 0x0
	.align 3
.LC159:
	.long 0xbff80000
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Submachinegun_Fire
	.type	 Weapon_Submachinegun_Fire,@function
Weapon_Submachinegun_Fire:
	stwu 1,-144(1)
	mflr 0
	stmw 22,104(1)
	stw 0,148(1)
	mr 31,3
	lis 9,level@ha
	lwz 8,84(31)
	lwz 10,level@l(9)
	lwz 11,1796(8)
	lwz 0,4384(8)
	lwz 30,96(11)
	cmpw 0,0,10
	lwz 7,100(11)
	lwz 22,88(30)
	lwz 23,92(30)
	bc 12,1,.L337
	lwz 0,4132(8)
	andi. 0,0,1
	bc 4,2,.L339
	stw 0,4320(8)
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L337
.L339:
	lwz 0,4392(8)
	cmpwi 0,0,0
	bc 12,2,.L340
	lwz 0,92(8)
	lwz 9,36(30)
	cmpw 0,0,9
	bc 12,2,.L372
	b .L344
.L340:
	lwz 0,92(8)
	lwz 9,32(30)
	cmpw 0,0,9
	bc 4,2,.L344
.L372:
	addi 0,9,-1
	stw 0,92(8)
	b .L343
.L344:
	stw 9,92(8)
.L343:
	lwz 10,84(31)
	mulli 0,7,48
	addi 9,10,4408
	mr 26,0
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L346
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 12,2,.L347
	lwz 9,36(30)
	b .L373
.L347:
	lwz 9,32(30)
.L373:
	addi 0,9,1
	lis 9,level@ha
	stw 0,92(10)
	la 30,level@l(9)
	lfs 13,468(31)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L337
	lis 29,gi@ha
	lis 3,.LC143@ha
	la 29,gi@l(29)
	la 3,.LC143@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC155@ha
	lis 9,.LC155@ha
	lis 11,.LC156@ha
	la 8,.LC155@l(8)
	mr 5,3
	la 9,.LC155@l(9)
	lfs 1,0(8)
	mtlr 0
	la 11,.LC156@l(11)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(11)
	blrl
	lis 8,.LC155@ha
	lfs 0,4(30)
	la 8,.LC155@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,468(31)
	b .L337
.L346:
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 4,2,.L350
	li 9,3
	addi 25,1,64
	mtctr 9
	addi 29,1,32
	addi 28,1,48
	addi 27,31,4
	addi 24,1,80
.L371:
	bdnz .L371
	b .L356
.L350:
	li 11,2
	addi 25,1,64
	mtctr 11
	addi 29,1,32
	addi 28,1,48
	addi 27,31,4
	addi 24,1,80
.L359:
	bdnz .L359
.L356:
	lwz 9,84(31)
	lwz 11,4320(9)
	addi 11,11,1
	stw 11,4320(9)
	lwz 9,84(31)
	lwz 0,4320(9)
	cmpwi 0,0,9
	bc 4,1,.L362
	li 0,9
	stw 0,4320(9)
.L362:
	lwz 9,84(31)
	lwz 11,1796(9)
	lwz 0,68(11)
	cmpwi 0,0,5
	bc 4,2,.L363
	lwz 0,512(31)
	lis 10,0x4330
	lis 8,.LC157@ha
	li 11,0
	xoris 0,0,0x8000
	la 8,.LC157@l(8)
	stw 11,84(1)
	stw 0,100(1)
	stw 10,96(1)
	lfd 13,0(8)
	lfd 0,96(1)
	stw 11,80(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,88(1)
	b .L364
.L363:
	lis 9,gi+4@ha
	lis 3,.LC144@ha
	lwz 0,gi+4@l(9)
	la 3,.LC144@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L364:
	lis 11,level@ha
	lis 9,0x5555
	lwz 10,level@l(11)
	ori 9,9,21846
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	cmpw 0,10,0
	bc 4,2,.L365
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L366
	lfs 0,4200(9)
	lis 8,.LC158@ha
	la 8,.LC158@l(8)
	lfd 13,0(8)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4200(9)
	b .L365
.L366:
	lis 0,0xc040
	stw 0,4200(9)
.L365:
	lwz 10,84(31)
	lis 11,0x4330
	lis 8,.LC157@ha
	mr 3,25
	lwz 0,4320(10)
	la 8,.LC157@l(8)
	mr 4,29
	lfd 13,0(8)
	mr 5,28
	li 6,0
	xoris 0,0,0x8000
	lis 8,.LC159@ha
	stw 0,100(1)
	la 8,.LC159@l(8)
	stw 11,96(1)
	lfd 0,96(1)
	lfd 12,0(8)
	fsub 0,0,13
	fmul 0,0,12
	frsp 0,0
	stfs 0,4200(10)
	lwz 9,84(31)
	lfs 13,4200(9)
	lfs 0,4264(9)
	fadds 0,0,13
	stfs 0,64(1)
	lfs 0,4204(9)
	lfs 13,4268(9)
	fadds 13,13,0
	stfs 13,68(1)
	lfs 12,4208(9)
	lfs 0,4272(9)
	fadds 0,0,12
	stfs 0,72(1)
	bl AngleVectors
	lwz 3,84(31)
	addi 8,1,16
	mr 5,24
	mr 7,28
	mr 4,27
	mr 6,29
	bl P_ProjectSource
	li 0,0
	mr 10,22
	stw 0,8(1)
	li 9,0
	mr 5,29
	mr 6,23
	mr 3,31
	addi 4,1,16
	li 7,2
	li 8,0
	bl fire_gun
	lwz 10,84(31)
	addi 9,10,4408
	lwzx 0,9,26
	cmpwi 0,0,1
	bc 4,2,.L368
	lwz 11,40(30)
	li 0,4
	lis 29,gi@ha
	la 29,gi@l(29)
	addi 11,11,1
	stw 11,92(10)
	lwz 9,84(31)
	stw 0,4192(9)
	lwz 9,36(29)
	lwz 3,84(30)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC155@ha
	lis 9,.LC155@ha
	lis 11,.LC156@ha
	mr 5,3
	la 8,.LC155@l(8)
	la 9,.LC155@l(9)
	mtlr 0
	la 11,.LC156@l(11)
	li 4,1
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L368:
	lis 29,gi@ha
	lwz 3,80(30)
	la 29,gi@l(29)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 8,.LC155@ha
	lwz 11,16(29)
	lis 9,.LC155@ha
	la 8,.LC155@l(8)
	mr 5,3
	lfs 1,0(8)
	la 9,.LC155@l(9)
	li 4,1
	mtlr 11
	lis 8,.LC156@ha
	lfs 2,0(9)
	mr 3,31
	la 8,.LC156@l(8)
	lfs 3,0(8)
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lis 9,is_silenced@ha
	lwz 11,100(29)
	lbz 3,is_silenced@l(9)
	mtlr 11
	ori 3,3,1
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 10,level@ha
	addi 11,11,4408
	lwzx 9,11,26
	addi 9,9,-1
	stwx 9,11,26
	lwz 0,level@l(10)
	lwz 9,100(30)
	lwz 11,84(31)
	add 0,0,9
	stw 0,4384(11)
.L337:
	lwz 0,148(1)
	mtlr 0
	lmw 22,104(1)
	la 1,144(1)
	blr
.Lfe17:
	.size	 Weapon_Submachinegun_Fire,.Lfe17-Weapon_Submachinegun_Fire
	.section	".rodata"
	.align 2
.LC160:
	.long 0x3f800000
	.align 2
.LC161:
	.long 0x0
	.align 3
.LC162:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC163:
	.long 0x3ff80000
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_LMG_Fire
	.type	 Weapon_LMG_Fire,@function
Weapon_LMG_Fire:
	stwu 1,-176(1)
	mflr 0
	stmw 23,140(1)
	stw 0,180(1)
	mr 31,3
	lis 9,level@ha
	lwz 8,84(31)
	lwz 10,level@l(9)
	lwz 11,1796(8)
	lwz 0,4384(8)
	lwz 28,96(11)
	cmpw 0,0,10
	lwz 9,100(11)
	lwz 23,88(28)
	lwz 24,92(28)
	bc 12,1,.L374
	lwz 0,4132(8)
	andi. 0,0,1
	bc 4,2,.L376
	stw 0,4320(8)
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L374
.L376:
	mulli 0,9,48
	addi 11,8,4432
	lwzx 9,11,0
	mr 25,0
	cmpwi 0,9,0
	bc 12,1,.L377
	lwz 0,4392(8)
	cmpwi 0,0,0
	bc 12,2,.L378
	lwz 9,36(28)
	b .L402
.L378:
	lwz 9,32(28)
.L402:
	addi 9,9,1
	stw 9,92(8)
	li 0,0
	lwz 11,84(31)
	lis 9,level@ha
	la 30,level@l(9)
	stw 0,4192(11)
	lfs 13,4(30)
	lfs 0,468(31)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L374
	lis 29,gi@ha
	lis 3,.LC143@ha
	la 29,gi@l(29)
	la 3,.LC143@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC160@ha
	lwz 0,16(29)
	lis 11,.LC160@ha
	la 9,.LC160@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC160@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC161@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC161@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC160@ha
	lfs 0,4(30)
	la 9,.LC160@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,468(31)
	b .L374
.L377:
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
	lwz 11,84(31)
	lwz 0,4392(11)
	cmpwi 0,0,0
	bc 4,2,.L381
	li 11,3
	addi 3,1,80
	mtctr 11
	addi 29,1,32
	addi 30,1,48
	addi 6,1,64
	addi 27,31,4
	addi 26,1,96
.L401:
	bdnz .L401
	lwz 9,84(31)
	mr 4,29
	mr 5,30
	lfs 13,4200(9)
	lfs 0,4264(9)
	fadds 0,0,13
	stfs 0,80(1)
	lfs 0,4204(9)
	lfs 13,4268(9)
	fadds 13,13,0
	stfs 13,84(1)
	lfs 12,4208(9)
	lfs 0,4272(9)
	fadds 0,0,12
	stfs 0,88(1)
	bl AngleVectors
	b .L387
.L381:
	li 0,2
	addi 3,1,80
	mtctr 0
	addi 29,1,32
	addi 30,1,48
	addi 27,31,4
	addi 26,1,96
.L390:
	bdnz .L390
	lwz 9,84(31)
	mr 4,29
	mr 5,30
	li 6,0
	lfs 13,4200(9)
	lfs 0,4264(9)
	fadds 0,0,13
	stfs 0,80(1)
	lfs 0,4204(9)
	lfs 13,4268(9)
	fadds 13,13,0
	stfs 13,84(1)
	lfs 12,4208(9)
	lfs 0,4272(9)
	fadds 0,0,12
	stfs 0,88(1)
	bl AngleVectors
.L387:
	lwz 9,84(31)
	lwz 11,1796(9)
	lwz 0,68(11)
	cmpwi 0,0,6
	bc 4,2,.L393
	lwz 0,512(31)
	lis 10,0x4330
	lis 11,.LC162@ha
	xoris 0,0,0x8000
	la 11,.LC162@l(11)
	stw 0,132(1)
	stw 10,128(1)
	lfd 13,0(11)
	lfd 0,128(1)
	li 11,0
	stw 11,100(1)
	stw 11,96(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,104(1)
	b .L394
.L393:
	lis 9,gi+4@ha
	lis 3,.LC144@ha
	lwz 0,gi+4@l(9)
	la 3,.LC144@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L394:
	lwz 3,84(31)
	addi 8,1,16
	mr 5,26
	mr 7,30
	mr 4,27
	mr 6,29
	bl P_ProjectSource
	li 0,0
	mr 10,23
	stw 0,8(1)
	li 9,0
	mr 5,29
	mr 6,24
	mr 3,31
	addi 4,1,16
	li 7,2
	li 8,0
	bl fire_gun
	lis 11,level@ha
	lis 9,0x5555
	lwz 10,level@l(11)
	ori 9,9,21846
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	cmpw 0,10,0
	bc 4,2,.L395
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L396
	lfs 0,4200(9)
	lis 11,.LC163@ha
	la 11,.LC163@l(11)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4200(9)
	b .L395
.L396:
	lis 0,0xc040
	stw 0,4200(9)
.L395:
	lwz 10,84(31)
	addi 9,10,4432
	lwzx 0,9,25
	cmpwi 0,0,1
	bc 4,2,.L398
	lwz 11,40(28)
	li 0,4
	lis 29,gi@ha
	la 29,gi@l(29)
	addi 11,11,1
	stw 11,92(10)
	lwz 9,84(31)
	stw 0,4192(9)
	lwz 9,36(29)
	lwz 3,84(28)
	mtlr 9
	blrl
	lis 9,.LC160@ha
	lwz 0,16(29)
	lis 11,.LC160@ha
	la 9,.LC160@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC160@l(11)
	li 4,1
	mtlr 0
	lis 9,.LC161@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC161@l(9)
	lfs 3,0(9)
	blrl
.L398:
	lis 29,gi@ha
	lwz 3,80(28)
	la 29,gi@l(29)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC160@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC160@l(9)
	li 4,1
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC160@ha
	la 9,.LC160@l(9)
	lfs 2,0(9)
	lis 9,.LC161@ha
	la 9,.LC161@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lis 9,is_silenced@ha
	lwz 11,100(29)
	lbz 3,is_silenced@l(9)
	mtlr 11
	ori 3,3,1
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 10,level@ha
	addi 11,11,4432
	lwzx 9,11,25
	addi 9,9,-1
	stwx 9,11,25
	lwz 0,level@l(10)
	lwz 9,100(28)
	lwz 11,84(31)
	add 0,0,9
	stw 0,4384(11)
.L374:
	lwz 0,180(1)
	mtlr 0
	lmw 23,140(1)
	la 1,176(1)
	blr
.Lfe18:
	.size	 Weapon_LMG_Fire,.Lfe18-Weapon_LMG_Fire
	.section	".rodata"
	.align 2
.LC164:
	.string	"You can't shoot that thing while standing up!\n"
	.align 2
.LC165:
	.long 0x46fffe00
	.align 3
.LC166:
	.long 0x400acccc
	.long 0xcccccccd
	.align 3
.LC167:
	.long 0x402b6666
	.long 0x66666666
	.align 3
.LC168:
	.long 0x3fd66666
	.long 0x66666666
	.align 3
.LC169:
	.long 0xbffccccc
	.long 0xcccccccd
	.align 3
.LC170:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC171:
	.long 0x3f800000
	.align 2
.LC172:
	.long 0x0
	.align 3
.LC173:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC174:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC175:
	.long 0x3ff80000
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_HMG_Fire
	.type	 Weapon_HMG_Fire,@function
Weapon_HMG_Fire:
	stwu 1,-224(1)
	mflr 0
	stfd 26,176(1)
	stfd 27,184(1)
	stfd 28,192(1)
	stfd 29,200(1)
	stfd 30,208(1)
	stfd 31,216(1)
	stmw 18,120(1)
	stw 0,228(1)
	mr 31,3
	lis 9,level@ha
	lwz 10,84(31)
	lwz 9,level@l(9)
	lwz 11,1796(10)
	lwz 0,4384(10)
	lwz 27,96(11)
	cmpw 0,0,9
	lwz 8,100(11)
	lwz 18,88(27)
	lwz 19,92(27)
	bc 12,1,.L403
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 4,2,.L405
	lwz 0,4132(10)
	andi. 9,0,1
	bc 12,2,.L435
	lis 9,gi+8@ha
	lis 5,.LC164@ha
	lwz 0,gi+8@l(9)
	la 5,.LC164@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L403
.L405:
	lwz 0,4132(10)
	andi. 11,0,1
	bc 4,2,.L406
.L435:
	lwz 11,84(31)
	lwz 0,4392(11)
	cmpwi 0,0,0
	bc 4,2,.L407
	lwz 0,32(27)
	b .L436
.L407:
	lwz 0,36(27)
.L436:
	stw 0,92(11)
	lwz 11,84(31)
	li 8,0
	stw 8,4372(11)
	lwz 9,84(31)
	stw 8,4320(9)
	lwz 11,84(31)
	lwz 0,4132(11)
	rlwinm 0,0,0,0,30
	stw 0,4132(11)
	lwz 10,84(31)
	lwz 0,4140(10)
	rlwinm 0,0,0,0,30
	stw 0,4140(10)
	lwz 9,84(31)
	stw 8,4192(9)
	b .L403
.L406:
	lwz 0,4392(10)
	rlwinm 29,9,0,31,31
	cmpwi 0,0,0
	bc 12,2,.L409
	slwi 0,29,2
	addi 9,27,16
	lwzx 11,9,0
	stw 11,92(10)
	b .L410
.L409:
	slwi 0,29,2
	lwzx 9,27,0
	stw 9,92(10)
.L410:
	lwz 9,84(31)
	mr 11,9
	lwz 9,4496(9)
	cmpwi 0,9,0
	bc 12,2,.L411
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 4,2,.L411
	lwz 0,4192(11)
	cmpwi 0,0,3
	bc 4,2,.L403
	lis 9,level@ha
	lfs 13,468(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L413
	lis 29,gi@ha
	lis 3,.LC143@ha
	la 29,gi@l(29)
	la 3,.LC143@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC171@ha
	lwz 0,16(29)
	lis 11,.LC171@ha
	la 9,.LC171@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC171@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC172@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC172@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC171@ha
	lfs 0,4(30)
	la 9,.LC171@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,468(31)
.L413:
	lwz 11,84(31)
	lwz 0,4392(11)
	cmpwi 0,0,0
	bc 12,2,.L414
	lwz 0,36(27)
	b .L437
.L414:
	lwz 0,32(27)
.L437:
	stw 0,92(11)
	lwz 9,84(31)
	li 0,0
	stw 0,4192(9)
	b .L403
.L411:
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 12,2,.L417
	lwz 0,4392(11)
	cmpwi 0,0,0
	bc 4,2,.L416
.L417:
	lis 11,.LC165@ha
	lis 9,.LC166@ha
	mulli 21,8,48
	lfs 28,.LC165@l(11)
	addi 25,1,96
	addi 24,1,32
	lis 11,.LC167@ha
	lfd 26,.LC166@l(9)
	addi 23,1,48
	lfd 27,.LC167@l(11)
	lis 9,.LC174@ha
	addi 26,1,64
	lis 11,.LC173@ha
	la 9,.LC174@l(9)
	la 11,.LC173@l(11)
	lfd 30,0(9)
	addi 22,31,4
	lfd 29,0(11)
	addi 20,1,80
	lis 28,0x4330
	lis 11,.LC175@ha
	li 30,0
	la 11,.LC175@l(11)
	li 29,3
	lfd 31,0(11)
.L421:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	stw 3,116(1)
	addi 11,11,4212
	stw 28,112(1)
	lfd 13,112(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmsub 0,0,26,31
	frsp 0,0
	stfsx 0,11,30
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	addic. 29,29,-1
	stw 3,116(1)
	addi 11,11,4200
	stw 28,112(1)
	lfd 13,112(1)
	lfsx 12,11,30
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmsub 0,0,27,31
	fadd 12,12,0
	frsp 12,12
	stfsx 12,11,30
	addi 30,30,4
	bc 4,2,.L421
	bl rand
	rlwinm 3,3,0,17,31
	lwz 29,84(31)
	xoris 3,3,0x8000
	lis 7,0x4330
	stw 3,116(1)
	lis 11,.LC173@ha
	lis 10,.LC165@ha
	stw 7,112(1)
	la 11,.LC173@l(11)
	lis 8,.LC168@ha
	lfd 8,0(11)
	mr 3,25
	mr 6,26
	lfd 13,112(1)
	lis 11,.LC174@ha
	mr 4,24
	lfs 10,.LC165@l(10)
	la 11,.LC174@l(11)
	mr 5,23
	lfd 11,0(11)
	fsub 13,13,8
	lfd 12,.LC168@l(8)
	mr 11,9
	lis 9,.LC169@ha
	lfd 9,.LC169@l(9)
	frsp 13,13
	fdivs 13,13,10
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,12
	frsp 0,0
	stfs 0,4212(29)
	lwz 9,84(31)
	lwz 0,4320(9)
	lfs 13,4200(9)
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 7,112(1)
	lfd 0,112(1)
	fsub 0,0,8
	fmadd 0,0,9,13
	frsp 0,0
	stfs 0,4200(9)
	lwz 10,84(31)
	lwz 9,4320(10)
	addi 9,9,2
	stw 9,4320(10)
	lwz 11,84(31)
	lfs 13,4200(11)
	lfs 0,4264(11)
	fadds 0,0,13
	stfs 0,96(1)
	lfs 0,4204(11)
	lfs 13,4268(11)
	fadds 13,13,0
	stfs 13,100(1)
	lfs 12,4208(11)
	lfs 0,4272(11)
	fadds 0,0,12
	stfs 0,104(1)
	bl AngleVectors
	b .L423
.L416:
	lis 11,.LC165@ha
	lis 9,.LC168@ha
	mulli 21,8,48
	lfs 29,.LC165@l(11)
	addi 25,1,96
	addi 24,1,32
	lis 11,.LC170@ha
	lfd 27,.LC168@l(9)
	addi 23,1,48
	lfd 28,.LC170@l(11)
	lis 9,.LC173@ha
	addi 26,1,64
	lis 11,.LC174@ha
	la 9,.LC173@l(9)
	la 11,.LC174@l(11)
	lfd 30,0(9)
	addi 22,31,4
	lfd 31,0(11)
	addi 20,1,80
	lis 28,0x4330
	li 30,0
	li 29,3
.L427:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	stw 3,116(1)
	addi 11,11,4212
	stw 28,112(1)
	lfd 13,112(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,27
	frsp 0,0
	stfsx 0,11,30
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	addic. 29,29,-1
	stw 3,116(1)
	addi 11,11,4200
	stw 28,112(1)
	lfd 13,112(1)
	lfsx 12,11,30
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,28,12
	frsp 0,0
	stfsx 0,11,30
	addi 30,30,4
	bc 4,2,.L427
	lwz 9,84(31)
	mr 3,25
	mr 6,26
	mr 4,24
	mr 5,23
	lfs 13,4200(9)
	lfs 0,4264(9)
	fadds 0,0,13
	stfs 0,96(1)
	lfs 0,4204(9)
	lfs 13,4268(9)
	fadds 13,13,0
	stfs 13,100(1)
	lfs 12,4208(9)
	lfs 0,4272(9)
	fadds 0,0,12
	stfs 0,104(1)
	bl AngleVectors
.L423:
	lwz 11,84(31)
	lwz 9,4320(11)
	cmpwi 0,9,10
	bc 4,1,.L429
	addi 0,9,-10
	stw 0,4320(11)
.L429:
	lwz 0,512(31)
	lis 10,0x4330
	lis 11,.LC173@ha
	lwz 3,84(31)
	mr 5,20
	xoris 0,0,0x8000
	la 11,.LC173@l(11)
	stw 0,116(1)
	mr 7,23
	mr 4,22
	stw 10,112(1)
	mr 6,24
	addi 8,1,16
	lfd 13,0(11)
	lfd 0,112(1)
	li 11,0
	stw 11,84(1)
	stw 11,80(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,88(1)
	bl P_ProjectSource
	lwz 11,668(31)
	lis 9,0x6666
	ori 9,9,26215
	addi 11,11,1
	mulhw 9,11,9
	srawi 10,11,31
	stw 11,668(31)
	srawi 9,9,1
	subf 9,10,9
	slwi 0,9,2
	add 0,0,9
	subf 11,0,11
	cmpwi 0,11,1
	bc 4,2,.L430
	mr 5,24
	mr 6,19
	mr 7,18
	mr 3,31
	addi 4,1,16
	bl fire_tracer
	b .L431
.L430:
	li 0,0
	mr 5,24
	stw 0,8(1)
	mr 6,19
	mr 10,18
	mr 3,31
	addi 4,1,16
	li 7,30
	li 8,0
	li 9,0
	bl fire_gun
.L431:
	lis 9,gi@ha
	lwz 3,80(27)
	la 30,gi@l(9)
	lwz 9,36(30)
	mtlr 9
	blrl
	lis 9,.LC171@ha
	lwz 11,16(30)
	mr 5,3
	la 9,.LC171@l(9)
	li 4,1
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC171@ha
	la 9,.LC171@l(9)
	lfs 2,0(9)
	lis 9,.LC172@ha
	la 9,.LC172@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,100(30)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(30)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lis 9,is_silenced@ha
	lwz 11,100(30)
	lbz 3,is_silenced@l(9)
	mtlr 11
	ori 3,3,1
	blrl
	lwz 9,88(30)
	mr 3,22
	li 4,2
	mtlr 9
	blrl
	lwz 11,84(31)
	lwz 9,4496(11)
	cmpwi 0,9,0
	bc 12,2,.L433
	lwz 0,0(9)
	cmpwi 0,0,1
	bc 4,2,.L433
	lwz 9,40(27)
	li 0,4
	addi 9,9,1
	stw 9,92(11)
	lwz 11,84(31)
	stw 0,4192(11)
	lwz 9,36(30)
	lwz 3,84(27)
	mtlr 9
	blrl
	lis 9,.LC171@ha
	lwz 0,16(30)
	lis 11,.LC171@ha
	la 9,.LC171@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC171@l(11)
	li 4,1
	mtlr 0
	lis 9,.LC172@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC172@l(9)
	lfs 3,0(9)
	blrl
.L433:
	lwz 11,84(31)
	lis 10,level@ha
	addi 11,11,4440
	lwzx 9,11,21
	addi 9,9,-1
	stwx 9,11,21
	lwz 0,level@l(10)
	lwz 9,100(27)
	lwz 11,84(31)
	add 0,0,9
	stw 0,4384(11)
.L403:
	lwz 0,228(1)
	mtlr 0
	lmw 18,120(1)
	lfd 26,176(1)
	lfd 27,184(1)
	lfd 28,192(1)
	lfd 29,200(1)
	lfd 30,208(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe19:
	.size	 Weapon_HMG_Fire,.Lfe19-Weapon_HMG_Fire
	.section	".rodata"
	.align 2
.LC176:
	.string	"You must kneel (crouch), be on dry land, and aim before firing that thing!\n"
	.align 2
.LC177:
	.long 0xc0000000
	.align 3
.LC178:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC179:
	.long 0x3f800000
	.align 2
.LC180:
	.long 0x0
	.align 2
.LC181:
	.long 0x43610000
	.align 2
.LC182:
	.long 0x40e00000
	.align 2
.LC183:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Weapon_Rocket_Fire
	.type	 Weapon_Rocket_Fire,@function
Weapon_Rocket_Fire:
	stwu 1,-144(1)
	mflr 0
	stmw 21,100(1)
	stw 0,148(1)
	mr 31,3
	lis 21,level@ha
	lwz 7,84(31)
	lwz 11,level@l(21)
	lwz 9,1796(7)
	lwz 0,4384(7)
	lwz 30,96(9)
	cmpw 0,0,11
	lwz 26,100(9)
	lfs 0,96(30)
	lwz 22,92(30)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 23,92(1)
	bc 12,1,.L438
	lwz 0,672(31)
	lis 11,gi@ha
	xori 9,0,4
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	or. 8,0,9
	bc 4,2,.L441
	lwz 0,4540(7)
	cmpwi 0,0,0
	bc 4,2,.L441
	lwz 0,4392(7)
	cmpwi 0,0,0
	bc 12,2,.L441
	la 27,gi@l(11)
	addi 25,31,4
	lwz 9,52(27)
	mr 3,25
	mtlr 9
	blrl
	andi. 0,3,56
	bc 12,2,.L440
.L441:
	lis 9,gi+8@ha
	lis 5,.LC176@ha
	lwz 0,gi+8@l(9)
	la 5,.LC176@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 0,4392(11)
	cmpwi 0,0,0
	bc 12,2,.L442
	lwz 9,36(30)
	b .L454
.L442:
	lwz 9,32(30)
.L454:
	addi 9,9,1
	stw 9,92(11)
	li 0,0
	lwz 9,84(31)
	stw 0,4372(9)
	lwz 11,84(31)
	stw 0,4192(11)
	b .L438
.L440:
	lwz 3,84(31)
	lwz 0,4132(3)
	andi. 8,0,1
	bc 4,2,.L444
	lwz 0,4392(3)
	cmpwi 0,0,0
	bc 12,2,.L445
	lwz 9,36(30)
	b .L455
.L445:
	lwz 9,32(30)
.L455:
	addi 9,9,1
	stw 9,92(3)
	b .L438
.L444:
	addi 28,1,40
	addi 29,1,56
	mulli 26,26,48
	mr 5,29
	li 6,0
	mr 4,28
	addi 3,3,4264
	bl AngleVectors
	lis 8,.LC177@ha
	lwz 4,84(31)
	addi 24,1,24
	la 8,.LC177@l(8)
	mr 3,28
	lfs 1,0(8)
	addi 4,4,4212
	bl VectorScale
	lwz 9,512(31)
	lis 10,0x4330
	lis 8,.LC178@ha
	lis 0,0x4100
	lwz 3,84(31)
	addi 9,9,-8
	la 8,.LC178@l(8)
	stw 0,12(1)
	xoris 9,9,0x8000
	lfd 13,0(8)
	mr 7,29
	stw 9,92(1)
	mr 4,25
	addi 5,1,8
	stw 10,88(1)
	mr 6,28
	mr 8,24
	lfd 0,88(1)
	stw 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	bl P_ProjectSource
	lwz 11,84(31)
	addi 9,11,4444
	lwzx 0,9,26
	cmpwi 0,0,0
	bc 4,2,.L447
	lwz 0,4392(11)
	cmpwi 0,0,0
	bc 12,2,.L448
	lwz 9,36(30)
	b .L456
.L448:
	lwz 9,32(30)
.L456:
	addi 0,9,1
	lis 9,level@ha
	stw 0,92(11)
	la 30,level@l(9)
	lfs 13,468(31)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L438
	lis 29,gi@ha
	lis 3,.LC143@ha
	la 29,gi@l(29)
	la 3,.LC143@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC179@ha
	lis 9,.LC179@ha
	lis 10,.LC180@ha
	la 8,.LC179@l(8)
	mr 5,3
	la 9,.LC179@l(9)
	lfs 1,0(8)
	mtlr 0
	la 10,.LC180@l(10)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 8,.LC179@ha
	lfs 0,4(30)
	la 8,.LC179@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,468(31)
	b .L438
.L447:
	cmpwi 0,0,1
	bc 4,2,.L451
	lwz 9,40(30)
	li 0,4
	addi 9,9,1
	stw 9,92(11)
	lwz 11,84(31)
	stw 0,4192(11)
	lwz 9,36(27)
	lwz 3,84(30)
	mtlr 9
	blrl
	lwz 11,16(27)
	lis 8,.LC179@ha
	lis 9,.LC179@ha
	lis 10,.LC180@ha
	mr 5,3
	la 8,.LC179@l(8)
	la 9,.LC179@l(9)
	mtlr 11
	la 10,.LC180@l(10)
	li 4,1
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L451:
	lis 9,.LC181@ha
	mr 8,23
	la 9,.LC181@l(9)
	mr 6,22
	lfs 1,0(9)
	li 7,1000
	mr 4,24
	mr 5,28
	mr 3,31
	bl fire_rocket
	lwz 11,84(31)
	lis 8,.LC182@ha
	lis 9,.LC183@ha
	la 8,.LC182@l(8)
	la 9,.LC183@l(9)
	lfs 13,0(8)
	lfs 0,4200(11)
	lfs 12,0(9)
	fsubs 0,0,13
	stfs 0,4200(11)
	lwz 9,84(31)
	lfs 0,4220(9)
	fsubs 0,0,12
	stfs 0,4220(9)
	lwz 9,36(27)
	lwz 3,80(30)
	mtlr 9
	blrl
	lwz 11,16(27)
	lis 8,.LC179@ha
	lis 9,.LC179@ha
	lis 10,.LC180@ha
	mr 5,3
	la 8,.LC179@l(8)
	la 10,.LC180@l(10)
	mtlr 11
	la 9,.LC179@l(9)
	lfs 3,0(10)
	li 4,1
	lfs 2,0(9)
	mr 3,31
	lfs 1,0(8)
	blrl
	lwz 9,100(27)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(27)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,100(27)
	li 3,7
	mtlr 9
	blrl
	lwz 0,88(27)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
	lwz 10,84(31)
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
	lwz 11,84(31)
	addi 11,11,4444
	lwzx 9,11,26
	addi 9,9,-1
	stwx 9,11,26
	lwz 0,level@l(21)
	lwz 9,100(30)
	lwz 11,84(31)
	add 0,0,9
	stw 0,4384(11)
.L438:
	lwz 0,148(1)
	mtlr 0
	lmw 21,100(1)
	la 1,144(1)
	blr
.Lfe20:
	.size	 Weapon_Rocket_Fire,.Lfe20-Weapon_Rocket_Fire
	.section	".rodata"
	.align 2
.LC184:
	.string	"You can't fire the sniper rifle while moving!\n"
	.align 2
.LC185:
	.long 0x3f800000
	.align 2
.LC186:
	.long 0x0
	.align 2
.LC187:
	.long 0x42aa0000
	.align 3
.LC188:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC189:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Weapon_Sniper_Fire
	.type	 Weapon_Sniper_Fire,@function
Weapon_Sniper_Fire:
	stwu 1,-160(1)
	mflr 0
	stmw 23,124(1)
	stw 0,164(1)
	mr 31,3
	lwz 8,84(31)
	lwz 9,1796(8)
	addi 10,8,4424
	lwz 7,100(9)
	lwz 30,96(9)
	mulli 11,7,48
	lwz 24,88(30)
	lwzx 0,10,11
	lwz 25,92(30)
	cmpwi 0,0,0
	bc 12,2,.L459
	lwz 9,3448(8)
	addi 11,8,4724
	lwz 0,84(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L458
.L459:
	lis 9,level+4@ha
	lfs 13,468(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L460
	lwz 9,92(8)
	lwz 0,24(30)
	cmpw 0,9,0
	bc 12,2,.L460
	lwz 0,4132(8)
	andi. 8,0,1
	bc 12,2,.L460
	lis 29,gi@ha
	lis 3,.LC143@ha
	la 29,gi@l(29)
	la 3,.LC143@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC185@ha
	lis 9,.LC185@ha
	lis 10,.LC186@ha
	mr 5,3
	la 8,.LC185@l(8)
	la 9,.LC185@l(9)
	mtlr 0
	la 10,.LC186@l(10)
	li 4,2
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L460:
	lwz 11,32(30)
	li 0,0
	lis 8,.LC187@ha
	lwz 10,84(31)
	la 8,.LC187@l(8)
	addi 11,11,1
	lfs 13,0(8)
	stw 11,92(10)
	lwz 9,84(31)
	stw 0,4192(9)
	lwz 11,84(31)
	stw 0,4392(11)
	lwz 3,84(31)
	lfs 0,112(3)
	fcmpu 0,0,13
	bc 12,2,.L457
	stfs 13,112(3)
	b .L457
.L458:
	lwz 0,4392(8)
	cmpwi 0,0,0
	bc 12,2,.L462
	lwz 0,4540(8)
	cmpwi 0,0,0
	bc 12,2,.L463
	lwz 9,92(8)
	lwz 0,16(30)
	cmpw 0,9,0
	bc 12,1,.L463
	lis 9,gi+8@ha
	lis 5,.LC184@ha
	lwz 0,gi+8@l(9)
	la 5,.LC184@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,0
	stw 0,4372(11)
	lwz 9,84(31)
	stw 0,4192(9)
	b .L457
.L463:
	lwz 8,84(31)
	lwz 9,20(30)
	lwz 0,92(8)
	addi 9,9,-2
	cmpw 0,0,9
	bc 12,2,.L465
	lis 9,level@ha
	lwz 11,4384(8)
	lwz 0,level@l(9)
	cmpw 0,11,0
	bc 4,1,.L462
.L465:
	lis 0,0x42aa
	li 10,0
	stw 0,112(8)
	lwz 9,84(31)
	li 8,7
	stw 10,4528(9)
	lwz 11,84(31)
	stw 8,4192(11)
	b .L457
.L462:
	lis 9,level@ha
	li 8,2
	lwz 11,100(30)
	mulli 27,7,48
	lwz 0,level@l(9)
	mtctr 8
	addi 28,1,32
	addi 29,1,48
	lwz 9,84(31)
	addi 23,31,4
	addi 26,1,64
	add 0,0,11
	stw 0,4384(9)
.L468:
	bdnz .L468
	lwz 9,84(31)
	mr 4,28
	mr 5,29
	li 6,0
	lfs 0,4200(9)
	addi 3,9,4264
	lfs 13,4264(9)
	fadds 13,13,0
	stfs 13,80(1)
	lfs 13,4204(9)
	lfs 0,4268(9)
	fadds 0,0,13
	stfs 0,84(1)
	lfs 13,4272(9)
	lfs 0,4208(9)
	fadds 13,13,0
	stfs 13,88(1)
	bl AngleVectors
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	lwz 9,512(31)
	lis 10,0x4330
	lis 8,.LC188@ha
	li 0,0
	addi 9,9,3
	la 8,.LC188@l(8)
	stw 0,68(1)
	xoris 9,9,0x8000
	lfd 13,0(8)
	stw 9,116(1)
	stw 10,112(1)
	lfd 0,112(1)
	stw 0,64(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,72(1)
	lwz 3,84(31)
	mr 5,26
	mr 7,29
	mr 4,23
	mr 6,28
	addi 8,1,16
	bl P_ProjectSource
	lwz 10,84(31)
	addi 9,10,4424
	lwzx 0,9,27
	cmpwi 0,0,1
	bc 4,2,.L473
	lwz 11,40(30)
	li 0,4
	lis 29,gi@ha
	la 29,gi@l(29)
	addi 11,11,1
	stw 11,92(10)
	lwz 9,84(31)
	stw 0,4192(9)
	lwz 9,36(29)
	lwz 3,84(30)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC185@ha
	lis 9,.LC185@ha
	lis 10,.LC186@ha
	mr 5,3
	la 8,.LC185@l(8)
	la 9,.LC185@l(9)
	mtlr 0
	la 10,.LC186@l(10)
	li 4,1
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L473:
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L475
	mr 5,28
	mr 6,25
	mr 8,24
	mr 3,31
	addi 4,1,16
	li 7,200
	bl fire_rifle
	b .L476
.L475:
	stw 0,8(1)
	mr 5,28
	mr 6,25
	mr 10,24
	mr 3,31
	addi 4,1,16
	li 7,200
	li 8,0
	li 9,0
	bl fire_gun
.L476:
	lwz 9,84(31)
	li 10,0
	lis 8,.LC189@ha
	la 8,.LC189@l(8)
	lis 29,gi@ha
	lwz 11,3448(9)
	la 29,gi@l(29)
	addi 9,9,4724
	lfs 13,0(8)
	lwz 0,84(11)
	slwi 0,0,2
	stwx 10,9,0
	lwz 11,84(31)
	lfs 0,4200(11)
	fsubs 0,0,13
	stfs 0,4200(11)
	lwz 9,36(29)
	lwz 3,80(30)
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 8,.LC185@ha
	lis 9,.LC185@ha
	lis 10,.LC186@ha
	mr 5,3
	la 8,.LC185@l(8)
	la 10,.LC186@l(10)
	mtlr 11
	la 9,.LC185@l(9)
	lfs 3,0(10)
	li 4,1
	lfs 2,0(9)
	mr 3,31
	lfs 1,0(8)
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lis 9,is_silenced@ha
	lwz 11,100(29)
	lbz 3,is_silenced@l(9)
	mtlr 11
	ori 3,3,1
	blrl
	lwz 0,88(29)
	mr 3,23
	li 4,2
	mtlr 0
	blrl
	lwz 11,84(31)
	addi 11,11,4424
	lwzx 9,11,27
	addi 9,9,-1
	stwx 9,11,27
	lwz 10,84(31)
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
.L457:
	lwz 0,164(1)
	mtlr 0
	lmw 23,124(1)
	la 1,160(1)
	blr
.Lfe21:
	.size	 Weapon_Sniper_Fire,.Lfe21-Weapon_Sniper_Fire
	.section	".rodata"
	.align 2
.LC191:
	.string	"weapons/tnt/boom.wav"
	.align 2
.LC190:
	.long 0xbca3d70a
	.align 2
.LC192:
	.long 0x0
	.align 2
.LC193:
	.long 0x42000000
	.align 3
.LC194:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC195:
	.long 0x3f000000
	.align 3
.LC196:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC197:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl TNT_Explode
	.type	 TNT_Explode,@function
TNT_Explode:
	stwu 1,-176(1)
	mflr 0
	stfd 31,168(1)
	stmw 21,124(1)
	stw 0,180(1)
	mr 31,3
	lwz 3,256(31)
	cmpwi 0,3,0
	bc 12,2,.L479
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L479
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L479:
	lis 8,.LC192@ha
	lis 9,.LC193@ha
	lfs 12,4(31)
	la 9,.LC193@l(9)
	la 8,.LC192@l(8)
	lfs 13,8(31)
	lfs 0,12(31)
	lis 11,.LC194@ha
	lis 30,0x6666
	lfs 11,0(8)
	la 11,.LC194@l(11)
	addi 22,31,4
	lfs 10,0(9)
	addi 21,31,380
	ori 30,30,26215
	lfd 31,0(11)
	li 9,0
	lis 26,0x4330
	fadds 12,12,11
	lis 23,0x40a0
	li 24,7
	fadds 13,13,11
	li 25,0
	fadds 0,0,10
	stfs 12,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
	stfs 12,48(1)
	stfs 13,52(1)
	stfs 0,56(1)
.L483:
	addi 27,9,1
	li 28,8
.L487:
	bl rand
	mulhw 0,3,30
	srawi 9,3,31
	srawi 0,0,3
	subf 0,9,0
	mulli 0,0,20
	subf 3,0,3
	addi 3,3,-40
	xoris 3,3,0x8000
	stw 3,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,32(1)
	bl rand
	mr 11,3
	stw 23,40(1)
	mulhw 0,11,30
	srawi 9,11,31
	stw 24,8(1)
	mr 3,31
	stw 25,12(1)
	addi 4,1,48
	addi 5,1,32
	srawi 0,0,3
	li 6,35
	subf 0,9,0
	li 7,2
	mulli 0,0,20
	li 8,0
	li 9,4500
	li 10,10000
	subf 11,0,11
	addi 11,11,-40
	xoris 11,11,0x8000
	stw 11,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,36(1)
	bl fire_lead
	addic. 28,28,-1
	bc 4,2,.L487
	mr 9,27
	cmpwi 0,9,7
	bc 4,1,.L483
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 12,2,.L491
	lfs 12,200(31)
	lis 8,.LC195@ha
	addi 29,1,64
	lfs 11,188(31)
	la 8,.LC195@l(8)
	mr 4,29
	lfs 10,204(31)
	mr 5,29
	mr 3,22
	lfs 13,192(31)
	fadds 11,11,12
	lfs 0,196(31)
	lfs 12,208(31)
	fadds 13,13,10
	lfs 1,0(8)
	stfs 11,64(1)
	fadds 0,0,12
	stfs 13,68(1)
	stfs 0,72(1)
	bl VectorMA
	lfs 0,4(31)
	mr 3,29
	lfs 13,8(31)
	lfs 12,12(31)
	lfs 9,64(1)
	lfs 11,68(1)
	lfs 10,72(1)
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,64(1)
	stfs 13,68(1)
	stfs 12,72(1)
	bl VectorLength
	lwz 0,520(31)
	lis 9,.LC194@ha
	la 9,.LC194@l(9)
	lis 8,0x4330
	lwz 10,288(31)
	xoris 0,0,0x8000
	lfd 9,0(9)
	li 29,1
	stw 0,116(1)
	lis 9,.LC196@ha
	mr 3,31
	stw 8,112(1)
	la 9,.LC196@l(9)
	andi. 0,10,1
	lfd 0,0(9)
	lis 8,vec3_origin@ha
	mr 4,31
	lfd 13,112(1)
	mr 9,11
	la 8,vec3_origin@l(8)
	lfs 11,4(31)
	mfcr 11
	rlwinm 11,11,3,1
	addi 6,1,80
	fmul 1,1,0
	lfs 12,8(31)
	neg 11,11
	mr 7,22
	fsub 13,13,9
	lfs 0,12(31)
	nor 0,11,11
	lwz 5,256(31)
	fsubs 11,11,11
	andi. 11,11,42
	andi. 0,0,41
	fsubs 12,12,12
	or 10,11,0
	stw 29,8(1)
	fsub 13,13,1
	stw 10,12(1)
	fsubs 0,0,0
	stfs 11,80(1)
	stfs 12,84(1)
	frsp 13,13
	stfs 0,88(1)
	fmr 0,13
	fctiwz 10,0
	stfd 10,112(1)
	lwz 9,116(1)
	mr 10,9
	bl T_Damage
.L491:
	lwz 0,288(31)
	andi. 8,0,2
	bc 12,2,.L494
	li 10,43
	b .L495
.L494:
	andi. 9,0,1
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	andi. 0,0,45
	ori 10,0,44
.L495:
	lwz 0,520(31)
	lis 11,0x4330
	lis 8,.LC194@ha
	lfs 2,528(31)
	mr 6,10
	xoris 0,0,0x8000
	la 8,.LC194@l(8)
	lwz 4,256(31)
	stw 0,116(1)
	mr 3,31
	mr 5,31
	stw 11,112(1)
	lfd 0,0(8)
	lfd 1,112(1)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,.LC190@ha
	addi 5,1,16
	lfs 1,.LC190@l(9)
	mr 4,21
	mr 3,22
	bl VectorMA
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,1,16
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,22
	li 4,1
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC191@ha
	la 3,.LC191@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC192@ha
	lis 9,.LC197@ha
	lis 11,.LC197@ha
	la 8,.LC192@l(8)
	mr 5,3
	la 9,.LC197@l(9)
	lfs 3,0(8)
	mtlr 0
	la 11,.LC197@l(11)
	mr 3,31
	lfs 1,0(9)
	li 4,1
	lfs 2,0(11)
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,180(1)
	mtlr 0
	lmw 21,124(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe22:
	.size	 TNT_Explode,.Lfe22-TNT_Explode
	.section	".rodata"
	.align 2
.LC198:
	.string	"weapons/tnt/wall.wav"
	.align 3
.LC199:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC200:
	.long 0x444a0000
	.section	".text"
	.align 2
	.globl TNT_Think
	.type	 TNT_Think,@function
TNT_Think:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	bl srand
	lis 9,level+4@ha
	lfs 13,604(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L504
	lis 9,gi@ha
	addi 3,31,4
	la 9,gi@l(9)
	lwz 0,52(9)
	mtlr 0
	blrl
	andi. 0,3,56
	bc 12,2,.L505
	bl rand
	lis 0,0x51eb
	srawi 11,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,11,0
	mulli 9,0,100
	subf 0,9,3
	cmpwi 0,0,60
	bc 4,1,.L506
	mr 3,31
	bl G_FreeEdict
	b .L504
.L506:
	li 0,1700
	lis 9,0x4416
	stw 0,520(31)
	mr 3,31
	stw 9,528(31)
	bl TNT_Explode
	b .L504
.L505:
	mr 3,31
	bl TNT_Explode
.L504:
	lis 9,.LC200@ha
	lis 11,easter_egg@ha
	la 9,.LC200@l(9)
	lfs 13,0(9)
	lwz 9,easter_egg@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L509
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,22
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	b .L510
.L509:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
.L510:
	lis 9,TNT_Think@ha
	lis 10,level+4@ha
	la 9,TNT_Think@l(9)
	lis 11,.LC199@ha
	stw 9,440(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC199@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 TNT_Think,.Lfe23-TNT_Think
	.section	".rodata"
	.align 2
.LC201:
	.string	"models/objects/tnt/tris.md2"
	.comm	is_silenced,1,1
	.section	".text"
	.align 2
	.globl fire_fragment
	.type	 fire_fragment,@function
fire_fragment:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,9
	stw 10,8(1)
	li 0,0
	mr 9,8
	stw 0,12(1)
	mr 10,11
	li 8,0
	bl fire_lead
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 fire_fragment,.Lfe24-fire_fragment
	.align 2
	.globl fire_bullet
	.type	 fire_bullet,@function
fire_bullet:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lwz 0,40(1)
	mr 12,7
	mr 31,9
	mr 7,10
	cmpwi 0,0,0
	bc 4,2,.L102
	li 0,1
	stw 7,8(1)
	mr 9,8
	stw 0,12(1)
	mr 7,12
	mr 10,31
	li 8,0
	bl fire_lead
	b .L103
.L102:
	lwz 11,668(3)
	lis 9,0x6666
	ori 9,9,26215
	addi 11,11,1
	mulhw 9,11,9
	srawi 10,11,31
	stw 11,668(3)
	srawi 9,9,1
	subf 9,10,9
	slwi 0,9,2
	add 0,0,9
	subf 11,0,11
	cmpwi 0,11,1
	bc 4,2,.L104
	bl fire_tracer
	b .L103
.L104:
	li 0,1
	stw 7,8(1)
	mr 9,8
	stw 0,12(1)
	mr 7,12
	mr 10,31
	li 8,0
	bl fire_lead
.L103:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 fire_bullet,.Lfe25-fire_bullet
	.section	".rodata"
	.align 2
.LC203:
	.long 0x46fffe00
	.align 3
.LC204:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC205:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC206:
	.long 0x40240000
	.long 0x0
	.align 3
.LC207:
	.long 0x40390000
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_tnt
	.type	 fire_tnt,@function
fire_tnt:
	stwu 1,-160(1)
	mflr 0
	stfd 28,128(1)
	stfd 29,136(1)
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 23,92(1)
	stw 0,164(1)
	mr 26,5
	mr 29,3
	mr 30,4
	mr 25,7
	addi 4,1,8
	mr 3,26
	bl vectoangles
	addi 23,1,40
	addi 24,1,56
	addi 3,1,8
	addi 4,1,24
	mr 5,23
	mr 6,24
	bl AngleVectors
	lwz 9,84(29)
	lwz 31,4364(9)
	cmpwi 0,31,0
	bc 12,2,.L511
	li 0,0
	lis 29,gi@ha
	stw 0,4364(9)
	la 29,gi@l(29)
	lis 3,.LC201@ha
	lwz 11,32(29)
	lis 9,.LC204@ha
	la 3,.LC201@l(3)
	la 9,.LC204@l(9)
	lis 10,.LC205@ha
	mtlr 11
	lfd 31,0(9)
	la 10,.LC205@l(10)
	lis 27,0x4330
	lis 9,.LC206@ha
	lfd 29,0(10)
	addi 28,31,380
	la 9,.LC206@l(9)
	lfd 28,0(9)
	blrl
	lis 9,TNT_Touch@ha
	stw 3,40(31)
	la 9,TNT_Touch@l(9)
	mr 3,31
	stw 9,448(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	xoris 0,25,0x8000
	lfs 13,0(30)
	stw 0,84(1)
	mr 4,28
	mr 3,26
	stw 27,80(1)
	lfd 1,80(1)
	stfs 13,4(31)
	lfs 0,4(30)
	fsub 1,1,31
	stfs 0,8(31)
	lfs 13,8(30)
	frsp 1,1
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC203@ha
	stw 3,84(1)
	lis 10,.LC207@ha
	mr 4,24
	stw 27,80(1)
	la 10,.LC207@l(10)
	mr 5,28
	lfd 0,80(1)
	mr 3,28
	lfs 30,.LC203@l(11)
	lfd 13,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmadd 1,1,28,13
	frsp 1,1
	bl VectorMA
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	mr 3,28
	stw 0,84(1)
	mr 4,23
	mr 5,3
	stw 27,80(1)
	lfd 0,80(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmul 1,1,28
	frsp 1,1
	bl VectorMA
	lis 0,0x4396
	stw 0,400(31)
	stw 0,392(31)
	stw 0,396(31)
.L511:
	lwz 0,164(1)
	mtlr 0
	lmw 23,92(1)
	lfd 28,128(1)
	lfd 29,136(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe26:
	.size	 fire_tnt,.Lfe26-fire_tnt
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.section	".rodata"
	.align 3
.LC208:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl calcVspread
	.type	 calcVspread,@function
calcVspread:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	lwz 9,84(29)
	lwz 11,1796(9)
	lwz 31,80(11)
	lwz 30,84(11)
	bl rand
	srawi 31,31,2
	lis 9,.LC208@ha
	xoris 3,3,0x8000
	lwz 8,84(29)
	la 9,.LC208@l(9)
	lis 7,0x4330
	lfd 9,0(9)
	lwz 11,3448(8)
	stw 3,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	lwz 9,3464(8)
	lwz 10,96(11)
	fsub 0,0,9
	slwi 9,9,2
	lwzx 11,9,10
	frsp 0,0
	lfs 13,60(11)
	fcmpu 0,0,13
	bc 4,0,.L26
	bl rand
	mulli 3,3,500
	b .L514
.L26:
	xoris 0,30,0x8000
	lfs 10,12(28)
	stw 0,12(1)
	mr 9,11
	xoris 10,31,0x8000
	stw 7,8(1)
	lfd 13,8(1)
	stw 10,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 13,13,9
	fsub 0,0,9
	frsp 13,13
	frsp 11,0
	fcmpu 0,10,11
	bc 4,0,.L27
	fmuls 0,13,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	b .L514
.L27:
	lwz 11,1796(8)
	mr 10,9
	lwz 0,80(11)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,9
	frsp 0,0
	fsubs 0,0,10
	fmuls 0,13,0
	fdivs 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,8(1)
	lwz 3,12(1)
.L514:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 calcVspread,.Lfe27-calcVspread
	.align 2
	.globl showvector
	.type	 showvector,@function
showvector:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,4
	lis 11,gi+4@ha
	lfs 3,8(9)
	mr 4,3
	lfs 1,0(9)
	lis 3,.LC5@ha
	lfs 2,4(9)
	la 3,.LC5@l(3)
	lwz 0,gi+4@l(11)
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 showvector,.Lfe28-showvector
	.align 2
	.globl tracer_touch
	.type	 tracer_touch,@function
tracer_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,256(31)
	mr 28,5
	cmpw 0,30,0
	bc 12,2,.L106
	cmpwi 0,6,0
	bc 12,2,.L108
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L108
	bl G_FreeEdict
	b .L106
.L108:
	lwz 3,256(31)
	addi 29,31,4
	cmpwi 0,3,0
	bc 12,2,.L109
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L109
	mr 4,29
	li 5,2
	bl PlayerNoise
.L109:
	lwz 0,516(30)
	cmpwi 0,0,0
	bc 12,2,.L110
	lwz 0,540(31)
	li 11,4
	mr 3,30
	lwz 5,256(31)
	mr 7,29
	mr 8,28
	lwz 9,520(31)
	mr 4,31
	addi 6,31,380
	stw 11,8(1)
	li 10,1
	stw 0,12(1)
	bl T_Damage
	b .L111
.L110:
	lis 9,gi@ha
	li 3,3
	la 30,gi@l(9)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,0
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,29
	mtlr 9
	blrl
	cmpwi 0,28,0
	bc 4,2,.L112
	lwz 0,124(30)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L113
.L112:
	lwz 0,124(30)
	mr 3,28
	mtlr 0
	blrl
.L113:
	lis 9,gi+88@ha
	mr 3,29
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L111:
	mr 3,31
	bl G_FreeEdict
.L106:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 tracer_touch,.Lfe29-tracer_touch
	.section	".rodata"
	.align 2
.LC209:
	.long 0x3f800000
	.align 2
.LC210:
	.long 0x0
	.section	".text"
	.align 2
	.globl Play_WepSound
	.type	 Play_WepSound,@function
Play_WepSound:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	mr 3,4
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC209@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC209@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,28
	mtlr 0
	lis 9,.LC209@ha
	la 9,.LC209@l(9)
	lfs 2,0(9)
	lis 9,.LC210@ha
	la 9,.LC210@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 Play_WepSound,.Lfe30-Play_WepSound
	.align 2
	.globl blaster_touch
	.type	 blaster_touch,@function
blaster_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	mr 31,4
	lwz 0,256(30)
	mr 28,5
	cmpw 0,31,0
	bc 12,2,.L122
	cmpwi 0,6,0
	bc 12,2,.L124
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L124
	bl G_FreeEdict
	b .L122
.L124:
	lwz 3,256(30)
	addi 29,30,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L125
	mr 4,29
	li 5,2
	bl PlayerNoise
.L125:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 12,2,.L126
	lwz 0,288(30)
	li 11,4
	mr 3,31
	lwz 5,256(30)
	mr 7,29
	mr 8,28
	andi. 9,0,1
	mr 4,30
	lwz 9,520(30)
	addi 6,30,380
	li 10,1
	stw 11,8(1)
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	nor 11,0,0
	rlwinm 0,0,0,31,31
	andi. 11,11,10
	or 0,0,11
	stw 0,12(1)
	bl T_Damage
	b .L129
.L126:
	lis 9,gi@ha
	li 3,3
	la 31,gi@l(9)
	lwz 9,100(31)
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,2
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,29
	mtlr 9
	blrl
	cmpwi 0,28,0
	bc 4,2,.L130
	lwz 0,124(31)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L131
.L130:
	lwz 0,124(31)
	mr 3,28
	mtlr 0
	blrl
.L131:
	lis 9,gi+88@ha
	mr 3,29
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L129:
	mr 3,30
	bl G_FreeEdict
.L122:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 blaster_touch,.Lfe31-blaster_touch
	.align 2
	.globl Shrapnel_Dud
	.type	 Shrapnel_Dud,@function
Shrapnel_Dud:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,256(31)
	cmpwi 0,3,0
	bc 12,2,.L168
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L168
	lis 9,gi+12@ha
	lis 4,.LC55@ha
	lwz 0,gi+12@l(9)
	la 4,.LC55@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,256(31)
	lwz 11,84(9)
	lwz 0,4356(11)
	cmpw 0,31,0
	bc 4,2,.L171
	lwz 0,4360(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
.L171:
	mr 3,31
	bl G_FreeEdict
.L168:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 Shrapnel_Dud,.Lfe32-Shrapnel_Dud
	.section	".rodata"
	.align 2
.LC211:
	.long 0x3f800000
	.align 2
.LC212:
	.long 0x0
	.section	".text"
	.align 2
	.type	 TNT_Touch,@function
TNT_Touch:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr. 6,6
	mr 31,3
	bc 12,2,.L499
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L499
	bl G_FreeEdict
	b .L498
.L499:
	lwz 0,516(4)
	cmpwi 0,0,0
	bc 12,2,.L501
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 4,2,.L498
.L501:
	cmpw 0,4,31
	bc 12,2,.L498
	lwz 4,664(4)
	cmpwi 0,4,0
	bc 12,2,.L502
	lwz 9,68(4)
	xori 11,9,12
	addi 9,9,-1
	addic 10,11,-1
	subfe 0,10,11
	subfic 9,9,1
	subfe 9,9,9
	neg 9,9
	and. 11,9,0
	bc 12,2,.L502
	lis 29,gi@ha
	lis 3,.LC198@ha
	la 29,gi@l(29)
	la 3,.LC198@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC211@ha
	lis 10,.LC211@ha
	lis 11,.LC212@ha
	mr 5,3
	la 9,.LC211@l(9)
	la 10,.LC211@l(10)
	mtlr 0
	la 11,.LC212@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L502:
	li 9,0
	li 0,0
	stw 0,264(31)
	stw 9,392(31)
	stw 9,388(31)
	stw 9,384(31)
	stw 9,380(31)
	stw 9,400(31)
	stw 9,396(31)
.L498:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 TNT_Touch,.Lfe33-TNT_Touch
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
