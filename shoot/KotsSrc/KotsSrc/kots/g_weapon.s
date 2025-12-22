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
	lwz 9,540(31)
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
	lwz 9,540(31)
	lfs 0,200(9)
	fsubs 31,31,0
	b .L13
.L12:
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,0,.L14
	lwz 9,540(31)
	lfs 0,188(9)
	b .L24
.L14:
	lwz 9,540(31)
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
	lwz 0,512(9)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L19
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L16
.L19:
	lwz 0,540(31)
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
	lwz 11,540(31)
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
	lwz 3,540(31)
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
	lwz 3,540(31)
	stw 11,188(1)
	lis 0,0x4330
	mr 4,29
	lis 11,.LC4@ha
	stw 0,184(1)
	addi 3,3,376
	la 11,.LC4@l(11)
	lfd 1,184(1)
	mr 5,3
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	bl VectorMA
	lwz 3,540(31)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lfs 0,384(3)
	fcmpu 0,0,13
	bc 4,1,.L21
	li 0,0
	stw 0,552(3)
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
.LC6:
	.string	"*brwater"
	.align 2
.LC7:
	.string	"sky"
	.align 2
.LC5:
	.long 0x46fffe00
	.align 3
.LC8:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC10:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC11:
	.long 0x46000000
	.align 2
.LC12:
	.long 0xc0000000
	.align 2
.LC13:
	.long 0x3f000000
	.section	".text"
	.align 2
	.type	 fire_lead,@function
fire_lead:
	stwu 1,-320(1)
	mflr 0
	stfd 28,288(1)
	stfd 29,296(1)
	stfd 30,304(1)
	stfd 31,312(1)
	stmw 14,216(1)
	stw 0,324(1)
	mr 20,9
	mr 24,3
	stw 8,192(1)
	lis 9,gi@ha
	mr 31,4
	la 22,gi@l(9)
	mr 17,5
	lwz 11,48(22)
	mr 15,6
	mr 14,7
	lis 9,0x600
	addi 3,1,16
	ori 9,9,3
	addi 4,24,4
	mtlr 11
	li 5,0
	li 6,0
	mr 7,31
	mr 8,24
	mr 19,10
	lis 30,0x600
	li 18,0
	ori 30,30,59
	blrl
	lfs 0,24(1)
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L26
	addi 29,1,80
	mr 3,17
	mr 4,29
	lis 28,0x4330
	bl vectoangles
	mr 21,29
	addi 27,1,96
	addi 26,1,112
	addi 25,1,128
	mr 4,27
	mr 6,25
	mr 5,26
	mr 3,29
	mr 16,27
	bl AngleVectors
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfd 31,0(9)
	bl rand
	lis 9,.LC10@ha
	rlwinm 3,3,0,17,31
	la 9,.LC10@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 10,.LC5@ha
	xoris 0,20,0x8000
	lfs 29,.LC5@l(10)
	addi 29,1,144
	stw 3,212(1)
	mr 11,9
	mr 23,29
	stw 28,208(1)
	lfd 13,208(1)
	stw 0,212(1)
	stw 28,208(1)
	fsub 13,13,31
	lfd 12,208(1)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,12
	frsp 28,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	mr 11,9
	stw 3,212(1)
	xoris 0,19,0x8000
	lis 10,.LC11@ha
	stw 28,208(1)
	la 10,.LC11@l(10)
	mr 3,31
	lfd 13,208(1)
	mr 4,27
	mr 5,29
	stw 0,212(1)
	stw 28,208(1)
	fsub 13,13,31
	lfd 12,208(1)
	lfs 1,0(10)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmul 0,0,12
	frsp 31,0
	bl VectorMA
	fmr 1,28
	mr 3,29
	mr 4,26
	mr 5,29
	bl VectorMA
	fmr 1,31
	mr 3,29
	mr 4,25
	mr 5,29
	bl VectorMA
	lwz 9,52(22)
	mr 3,31
	mtlr 9
	blrl
	andi. 0,3,56
	bc 12,2,.L27
	lfs 12,0(31)
	lis 30,0x600
	li 18,1
	lfs 13,4(31)
	ori 30,30,3
	lfs 0,8(31)
	stfs 12,160(1)
	stfs 13,164(1)
	stfs 0,168(1)
.L27:
	lwz 0,48(22)
	mr 9,30
	addi 3,1,16
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	mr 7,23
	mr 8,24
	blrl
	lwz 0,64(1)
	andi. 9,0,56
	bc 12,2,.L26
	lfs 12,28(1)
	addi 0,1,28
	mr 3,31
	lfs 13,32(1)
	mr 4,0
	mr 26,0
	lfs 0,36(1)
	addi 30,1,160
	li 18,1
	stfs 12,160(1)
	stfs 13,164(1)
	stfs 0,168(1)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L29
	lwz 0,64(1)
	andi. 9,0,32
	bc 12,2,.L30
	lwz 3,60(1)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl strcmp
	addic 3,3,-1
	subfe 3,3,3
	rlwinm 3,3,0,30,31
	ori 28,3,2
	b .L33
.L30:
	andi. 9,0,16
	bc 12,2,.L34
	li 28,4
	b .L33
.L34:
	rlwinm 0,0,0,28,28
	neg 0,0
	srawi 0,0,31
	andi. 28,0,5
.L33:
	cmpwi 0,28,0
	bc 12,2,.L38
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
	mr 3,26
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
	mr 3,26
	li 4,2
	mtlr 0
	blrl
.L38:
	lfs 9,8(31)
	lis 9,.LC9@ha
	lis 10,.LC10@ha
	lfs 10,0(31)
	la 9,.LC9@l(9)
	la 10,.LC10@l(10)
	lfs 12,4(31)
	addi 28,1,160
	mr 3,21
	lfs 11,144(1)
	mr 4,21
	lis 29,0x4330
	lfs 13,148(1)
	mr 30,28
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
	addi 5,1,112
	addi 6,1,128
	mr 4,16
	mr 3,21
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC5@ha
	stw 3,212(1)
	mr 11,9
	xoris 0,20,0x8000
	stw 29,208(1)
	lfd 13,208(1)
	lfs 29,.LC5@l(10)
	stw 0,212(1)
	fsub 13,13,31
	stw 29,208(1)
	lfd 12,208(1)
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
	stw 3,212(1)
	xoris 0,19,0x8000
	lis 10,.LC11@ha
	stw 29,208(1)
	la 10,.LC11@l(10)
	mr 4,16
	lfd 13,208(1)
	mr 3,28
	mr 5,23
	stw 0,212(1)
	stw 29,208(1)
	fsub 13,13,31
	lfd 12,208(1)
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
	fmr 1,28
	addi 4,1,112
	mr 3,23
	mr 5,23
	bl VectorMA
	fmr 1,31
	addi 4,1,128
	mr 3,23
	mr 5,23
	bl VectorMA
.L29:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 4,30
	mr 7,23
	addi 3,1,16
	li 5,0
	li 6,0
	mr 8,24
	mtlr 0
	ori 9,9,3
	blrl
.L26:
	lwz 3,60(1)
	cmpwi 0,3,0
	bc 12,2,.L40
	lwz 0,16(3)
	andi. 9,0,4
	bc 4,2,.L39
.L40:
	lfs 0,24(1)
	lis 10,.LC8@ha
	la 10,.LC8@l(10)
	lfd 13,0(10)
	fcmpu 0,0,13
	bc 4,0,.L39
	lwz 11,68(1)
	lwz 0,512(11)
	cmpwi 0,0,0
	bc 12,2,.L42
	li 9,16
	lwz 0,328(1)
	mr 4,24
	stw 9,8(1)
	mr 3,11
	mr 6,17
	stw 0,12(1)
	mr 9,15
	mr 10,14
	mr 5,4
	addi 7,1,28
	addi 8,1,40
	bl T_Damage
	b .L39
.L42:
	lis 4,.LC7@ha
	li 5,3
	la 4,.LC7@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L39
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,1,28
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,192(1)
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
	lwz 0,84(24)
	cmpwi 0,0,0
	bc 12,2,.L39
	mr 3,24
	mr 4,28
	li 5,2
	bl PlayerNoise
.L39:
	cmpwi 0,18,0
	bc 12,2,.L46
	lfs 0,160(1)
	addi 27,1,80
	addi 29,1,176
	lfs 11,28(1)
	addi 28,1,28
	mr 3,27
	lfs 13,32(1)
	mr 31,29
	mr 26,28
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
	lis 9,.LC12@ha
	mr 5,29
	la 9,.LC12@l(9)
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
	bc 12,2,.L47
	lfs 0,176(1)
	addi 30,1,160
	lfs 13,180(1)
	lfs 12,184(1)
	stfs 0,28(1)
	stfs 13,32(1)
	stfs 12,36(1)
	b .L48
.L47:
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
	mr 30,0
	blrl
.L48:
	lfs 11,28(1)
	lis 9,.LC13@ha
	mr 4,31
	lfs 12,160(1)
	la 9,.LC13@l(9)
	mr 3,31
	lfs 13,164(1)
	lfs 10,32(1)
	fadds 12,12,11
	lfs 0,168(1)
	lfs 11,36(1)
	fadds 13,13,10
	lfs 1,0(9)
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
	mr 3,30
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,31
	li 4,2
	mtlr 0
	blrl
.L46:
	lwz 0,324(1)
	mtlr 0
	lmw 14,216(1)
	lfd 28,288(1)
	lfd 29,296(1)
	lfd 30,304(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe2:
	.size	 fire_lead,.Lfe2-fire_lead
	.section	".rodata"
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x0
	.align 3
.LC16:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_sword
	.type	 fire_sword,@function
fire_sword:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 23,148(1)
	stw 0,196(1)
	mr 31,3
	mr 25,5
	mr 24,6
	mr 23,7
	li 4,1
	li 5,0
	lis 28,0x4330
	bl KOTSSpecial
	lis 9,.LC14@ha
	xoris 3,3,0x8000
	la 9,.LC14@l(9)
	addi 29,1,80
	lfd 31,0(9)
	addi 27,1,96
	addi 26,1,28
	mr 4,25
	stw 3,140(1)
	mr 5,29
	stw 28,136(1)
	addi 3,31,4
	lfd 1,136(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorMA
	lwz 11,508(31)
	lis 9,gi@ha
	la 30,gi@l(9)
	lfs 11,4(31)
	addi 3,1,16
	addi 11,11,-8
	lis 9,.LC15@ha
	lfs 12,8(31)
	xoris 11,11,0x8000
	la 9,.LC15@l(9)
	lfs 10,12(31)
	stw 11,140(1)
	mr 7,29
	mr 4,27
	stw 28,136(1)
	li 5,0
	li 6,0
	lfd 0,136(1)
	mr 8,31
	lfs 13,0(9)
	lwz 11,48(30)
	lis 9,0x600
	fsub 0,0,31
	ori 9,9,3
	fadds 11,11,13
	mtlr 11
	stfs 13,112(1)
	fadds 12,12,13
	stfs 13,116(1)
	frsp 0,0
	stfs 11,96(1)
	stfs 12,100(1)
	fadds 10,10,0
	stfs 0,120(1)
	stfs 10,104(1)
	blrl
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,23
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,88(30)
	mr 3,27
	li 4,1
	mtlr 9
	blrl
	lwz 9,60(1)
	cmpwi 0,9,0
	bc 12,2,.L70
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L68
.L70:
	lfs 0,24(1)
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L68
	lwz 3,68(1)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L72
	mr 4,31
	addi 29,1,40
	li 0,0
	li 11,1
	stw 0,8(1)
	mr 9,24
	mr 5,4
	mr 6,25
	stw 11,12(1)
	mr 10,23
	mr 7,26
	mr 8,29
	bl T_Damage
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,2
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(30)
	mr 3,29
	mtlr 9
	blrl
	lwz 0,88(30)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	b .L68
.L72:
	lwz 0,88(30)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
.L68:
	lwz 0,196(1)
	mtlr 0
	lmw 23,148(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe3:
	.size	 fire_sword,.Lfe3-fire_sword
	.section	".rodata"
	.align 2
.LC17:
	.string	"models/objects/laser/tris.md2"
	.align 2
.LC18:
	.string	"misc/lasfly.wav"
	.align 2
.LC19:
	.string	"bolt"
	.align 2
.LC20:
	.long 0x46fffe00
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC22:
	.long 0x0
	.align 2
.LC23:
	.long 0x40000000
	.align 3
.LC24:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC25:
	.long 0x46000000
	.align 3
.LC26:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC27:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl fire_blaster
	.type	 fire_blaster,@function
fire_blaster:
	stwu 1,-240(1)
	mflr 0
	stfd 29,216(1)
	stfd 30,224(1)
	stfd 31,232(1)
	stmw 22,176(1)
	stw 0,244(1)
	mr 24,5
	mr 25,3
	mr 29,4
	mr 26,9
	mr 30,6
	mr 28,7
	mr 27,8
	mr 3,24
	bl VectorNormalize
	li 23,2
	lis 22,0x4330
	bl G_Spawn
	mr 31,3
	lis 9,.LC21@ha
	stw 23,184(31)
	lis 10,.LC22@ha
	la 9,.LC21@l(9)
	lfs 0,0(29)
	la 10,.LC22@l(10)
	mr 3,24
	lfs 31,0(10)
	addi 4,31,16
	lfd 30,0(9)
	stfs 0,4(31)
	lfs 13,4(29)
	stfs 13,8(31)
	lfs 0,8(29)
	stfs 0,12(31)
	lfs 13,0(29)
	stfs 13,28(31)
	lfs 0,4(29)
	stfs 0,32(31)
	lfs 13,8(29)
	stfs 13,36(31)
	bl vectoangles
	xoris 28,28,0x8000
	stw 28,172(1)
	addi 4,31,376
	mr 3,24
	stw 22,168(1)
	lfd 0,168(1)
	fsub 0,0,30
	frsp 29,0
	fmr 1,29
	bl VectorScale
	lwz 9,64(31)
	lis 0,0x600
	li 11,8
	lis 10,gi@ha
	ori 0,0,3
	stw 11,260(31)
	or 9,9,27
	la 28,gi@l(10)
	stw 0,252(31)
	stw 9,64(31)
	lis 3,.LC17@ha
	stw 23,248(31)
	la 3,.LC17@l(3)
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
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	mtlr 9
	blrl
	lis 9,blaster_touch@ha
	lis 11,.LC23@ha
	stw 3,76(31)
	la 9,blaster_touch@l(9)
	la 11,.LC23@l(11)
	stw 25,256(31)
	stw 9,444(31)
	lis 10,level+4@ha
	cmpwi 0,26,0
	lfs 0,level+4@l(10)
	lis 9,G_FreeEdict@ha
	lfs 13,0(11)
	la 9,G_FreeEdict@l(9)
	lis 11,.LC19@ha
	stw 9,436(31)
	la 11,.LC19@l(11)
	stw 30,516(31)
	fadds 0,0,13
	stw 11,280(31)
	stfs 0,428(31)
	bc 12,2,.L75
	li 0,1
	stw 0,284(31)
.L75:
	xori 9,30,30
	subfic 0,9,0
	adde 9,0,9
	xori 0,30,50
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L76
	stw 23,284(31)
.L76:
	lwz 9,72(28)
	mr 3,31
	addi 29,31,4
	mtlr 9
	blrl
	lwz 0,84(25)
	cmpwi 0,0,0
	bc 12,2,.L77
	lis 9,skill@ha
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L78
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC20@ha
	stw 3,172(1)
	lis 10,.LC24@ha
	stw 22,168(1)
	la 10,.LC24@l(10)
	lfd 0,168(1)
	lfs 12,.LC20@l(11)
	lfd 11,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L77
.L78:
	lis 11,.LC25@ha
	addi 5,1,72
	la 11,.LC25@l(11)
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
	mr 8,25
	ori 9,9,3
	blrl
	lwz 3,156(1)
	cmpwi 0,3,0
	bc 12,2,.L77
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L77
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L77
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L77
	mr 4,25
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L77
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
	mr 4,25
	lfs 0,200(9)
	mr 3,9
	lwz 0,808(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,29
	blrl
.L77:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	addi 4,25,4
	addi 3,1,8
	li 5,0
	li 6,0
	mr 7,29
	mtlr 0
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L82
	lis 10,.LC27@ha
	mr 3,29
	la 10,.LC27@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,24
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L82:
	lwz 0,244(1)
	mtlr 0
	lmw 22,176(1)
	lfd 29,216(1)
	lfd 30,224(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe4:
	.size	 fire_blaster,.Lfe4-fire_blaster
	.section	".rodata"
	.align 2
.LC28:
	.string	"grenade"
	.align 2
.LC29:
	.long 0xbca3d70a
	.align 2
.LC30:
	.long 0x3f000000
	.align 3
.LC31:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 Grenade_Explode,@function
Grenade_Explode:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	mr 31,3
	lwz 9,256(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L84
	lwz 3,280(31)
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L84
	lwz 3,256(31)
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L84:
	lwz 9,540(31)
	addi 30,31,4
	cmpwi 0,9,0
	bc 12,2,.L86
	lfs 0,200(9)
	lis 8,.LC30@ha
	addi 4,1,32
	lfs 13,188(9)
	la 8,.LC30@l(8)
	addi 3,9,4
	lfs 1,0(8)
	mr 5,4
	fadds 13,13,0
	stfs 13,32(1)
	lfs 13,204(9)
	lfs 0,192(9)
	fadds 0,0,13
	stfs 0,36(1)
	lfs 0,208(9)
	lfs 13,196(9)
	fadds 13,13,0
	stfs 13,40(1)
	bl VectorMA
	lwz 0,516(31)
	lis 11,0x4330
	lfs 8,4(31)
	lis 8,.LC31@ha
	mr 9,10
	lfs 6,8(31)
	xoris 0,0,0x8000
	la 8,.LC31@l(8)
	lfs 7,12(31)
	li 29,1
	mr 4,31
	lfs 11,32(1)
	addi 6,1,48
	mr 7,30
	lfs 13,36(1)
	lfs 12,40(1)
	stw 0,76(1)
	fsubs 11,8,11
	stw 11,72(1)
	fsubs 13,6,13
	fsubs 12,7,12
	lfd 0,72(1)
	lfd 9,0(8)
	lwz 11,540(31)
	lis 8,vec3_origin@ha
	stfs 12,40(1)
	la 8,vec3_origin@l(8)
	stfs 11,32(1)
	fsub 0,0,9
	mr 3,11
	stfs 13,36(1)
	lfs 13,4(11)
	frsp 0,0
	lwz 0,284(31)
	lwz 5,256(31)
	fsubs 13,13,8
	rlwinm 0,0,0,31,31
	fmr 12,0
	neg 0,0
	rlwinm 0,0,0,28,31
	stfs 13,48(1)
	ori 10,0,6
	lfs 0,8(11)
	fctiwz 10,12
	fsubs 0,0,6
	stfd 10,72(1)
	lwz 9,76(1)
	stfs 0,52(1)
	lfs 13,12(11)
	stw 10,12(1)
	stw 29,8(1)
	mr 10,9
	fsubs 13,13,7
	stfs 13,56(1)
	bl T_Damage
.L86:
	lwz 0,284(31)
	andi. 8,0,2
	bc 12,2,.L89
	li 10,24
	b .L90
.L89:
	andi. 9,0,1
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,29,31
	rlwinm 9,9,0,27,27
	or 10,0,9
.L90:
	lwz 0,520(31)
	lis 11,0x4330
	lis 8,.LC31@ha
	lfs 2,524(31)
	mr 6,10
	xoris 0,0,0x8000
	la 8,.LC31@l(8)
	lwz 4,256(31)
	stw 0,76(1)
	mr 3,31
	stw 11,72(1)
	lfd 1,72(1)
	lfd 0,0(8)
	lwz 5,540(31)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,.LC29@ha
	mr 3,30
	lfs 1,.LC29@l(9)
	addi 4,31,376
	addi 5,1,16
	bl VectorMA
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L93
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L94
	lwz 0,100(29)
	li 3,18
	b .L99
.L94:
	lwz 0,100(29)
	li 3,17
	b .L99
.L93:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L97
	lwz 0,100(29)
	li 3,8
.L99:
	mtlr 0
	blrl
	b .L96
.L97:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L96:
	lis 29,gi@ha
	addi 3,1,16
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,1
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe5:
	.size	 Grenade_Explode,.Lfe5-Grenade_Explode
	.section	".rodata"
	.align 2
.LC33:
	.string	"weapons/hgrenb1a.wav"
	.align 2
.LC34:
	.string	"weapons/hgrenb2a.wav"
	.align 2
.LC35:
	.string	"weapons/grenlb1b.wav"
	.align 2
.LC36:
	.string	"flash_grenade"
	.align 2
.LC32:
	.long 0x46fffe00
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC38:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC39:
	.long 0x3f800000
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Grenade_Touch,@function
Grenade_Touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	mr 9,4
	lwz 0,256(31)
	cmpw 0,9,0
	bc 12,2,.L100
	cmpwi 0,6,0
	bc 12,2,.L102
	lwz 0,16(6)
	andi. 10,0,4
	bc 12,2,.L102
	bl G_FreeEdict
	b .L100
.L102:
	lwz 0,512(9)
	cmpwi 0,0,0
	bc 4,2,.L103
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L104
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC37@ha
	lis 11,.LC32@ha
	la 10,.LC37@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC38@ha
	lfs 12,.LC32@l(11)
	la 10,.LC38@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L105
	lis 29,gi@ha
	lis 3,.LC33@ha
	la 29,gi@l(29)
	la 3,.LC33@l(3)
	b .L110
.L105:
	lis 29,gi@ha
	lis 3,.LC34@ha
	la 29,gi@l(29)
	la 3,.LC34@l(3)
	b .L110
.L104:
	lis 29,gi@ha
	lis 3,.LC35@ha
	la 29,gi@l(29)
	la 3,.LC35@l(3)
.L110:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC39@ha
	lis 10,.LC39@ha
	lis 11,.LC40@ha
	mr 5,3
	la 9,.LC39@l(9)
	la 10,.LC39@l(10)
	mtlr 0
	la 11,.LC40@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L100
.L103:
	lwz 3,280(31)
	lis 4,.LC36@ha
	stw 9,540(31)
	la 4,.LC36@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L108
	mr 3,31
	bl Flash_Grenade_Explode
	b .L100
.L108:
	mr 3,31
	bl Grenade_Explode
.L100:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Grenade_Touch,.Lfe6-Grenade_Touch
	.section	".rodata"
	.align 2
.LC42:
	.string	"models/objects/grenade/tris.md2"
	.align 2
.LC41:
	.long 0x46fffe00
	.align 3
.LC43:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC44:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC45:
	.long 0x40240000
	.long 0x0
	.align 3
.LC46:
	.long 0x40690000
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_grenade
	.type	 fire_grenade,@function
fire_grenade:
	stwu 1,-176(1)
	mflr 0
	stfd 26,128(1)
	stfd 27,136(1)
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 22,88(1)
	stw 0,180(1)
	mr 27,4
	mr 25,5
	fmr 26,2
	mr 30,3
	addi 23,1,40
	fmr 27,1
	mr 29,7
	addi 4,1,8
	mr 22,6
	mr 3,25
	bl vectoangles
	lis 26,0x4330
	addi 24,1,56
	addi 4,1,24
	mr 6,24
	addi 3,1,8
	mr 5,23
	bl AngleVectors
	lis 9,.LC43@ha
	lis 10,.LC44@ha
	la 10,.LC44@l(10)
	la 9,.LC43@l(9)
	lfd 29,0(10)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC45@ha
	lfs 13,0(27)
	xoris 29,29,0x8000
	la 9,.LC45@l(9)
	mr 31,3
	lfd 28,0(9)
	addi 28,31,376
	mr 3,25
	stfs 13,4(31)
	mr 4,28
	stw 29,84(1)
	stw 26,80(1)
	lfd 1,80(1)
	lfs 0,4(27)
	fsub 1,1,31
	stfs 0,8(31)
	lfs 13,8(27)
	frsp 1,1
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC41@ha
	stw 3,84(1)
	lis 10,.LC46@ha
	mr 4,24
	stw 26,80(1)
	la 10,.LC46@l(10)
	mr 5,28
	lfd 0,80(1)
	mr 3,28
	lfs 30,.LC41@l(11)
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
	mr 5,3
	mr 4,23
	stw 26,80(1)
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
	lis 0,0x600
	lis 9,0x4396
	ori 0,0,3
	li 11,9
	stw 9,396(31)
	li 10,2
	stw 11,260(31)
	mr 3,30
	stw 0,252(31)
	li 4,6
	li 5,12
	stw 10,248(31)
	stw 9,388(31)
	stw 9,392(31)
	bl KOTSSpecial
	cmpwi 0,3,0
	bc 4,2,.L112
	lwz 0,64(31)
	ori 0,0,32
	stw 0,64(31)
.L112:
	li 0,0
	lis 9,0x1
	lis 29,gi@ha
	stw 0,200(31)
	lis 3,.LC42@ha
	la 29,gi@l(29)
	stw 0,196(31)
	la 3,.LC42@l(3)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	stw 9,284(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,Grenade_Touch@ha
	stw 3,40(31)
	lis 8,level+4@ha
	la 9,Grenade_Touch@l(9)
	stw 30,256(31)
	lis 11,Grenade_Explode@ha
	stw 9,444(31)
	lis 10,.LC28@ha
	li 0,120
	lfs 0,level+4@l(8)
	la 11,Grenade_Explode@l(11)
	la 10,.LC28@l(10)
	stw 11,436(31)
	mr 3,31
	stw 22,516(31)
	fadds 0,0,27
	stw 0,520(31)
	stfs 26,524(31)
	stw 10,280(31)
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,180(1)
	mtlr 0
	lmw 22,88(1)
	lfd 26,128(1)
	lfd 27,136(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe7:
	.size	 fire_grenade,.Lfe7-fire_grenade
	.section	".rodata"
	.align 2
.LC48:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC49:
	.string	"hgrenade"
	.align 2
.LC50:
	.string	"weapons/hgrenc1b.wav"
	.align 2
.LC51:
	.string	"weapons/hgrent1a.wav"
	.align 2
.LC47:
	.long 0x46fffe00
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC53:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC54:
	.long 0x40240000
	.long 0x0
	.align 3
.LC55:
	.long 0x40690000
	.long 0x0
	.align 3
.LC56:
	.long 0x0
	.long 0x0
	.align 2
.LC57:
	.long 0x3f800000
	.align 2
.LC58:
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_grenade2
	.type	 fire_grenade2,@function
fire_grenade2:
	stwu 1,-192(1)
	mflr 0
	stfd 26,144(1)
	stfd 27,152(1)
	stfd 28,160(1)
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 21,100(1)
	stw 0,196(1)
	mr 27,4
	mr 25,5
	fmr 26,2
	mr 30,3
	mr 29,7
	fmr 27,1
	addi 4,1,8
	mr 22,8
	mr 21,6
	mr 3,25
	bl vectoangles
	lis 26,0x4330
	addi 23,1,40
	addi 24,1,56
	addi 4,1,24
	mr 6,24
	addi 3,1,8
	mr 5,23
	bl AngleVectors
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC53@ha
	lfs 13,0(27)
	xoris 29,29,0x8000
	la 9,.LC53@l(9)
	mr 31,3
	lfd 29,0(9)
	lis 10,.LC54@ha
	addi 28,31,376
	stfs 13,4(31)
	la 10,.LC54@l(10)
	stw 29,92(1)
	mr 4,28
	mr 3,25
	stw 26,88(1)
	lfd 1,88(1)
	lfs 0,4(27)
	lfd 28,0(10)
	fsub 1,1,31
	stfs 0,8(31)
	lfs 13,8(27)
	frsp 1,1
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC47@ha
	stw 3,92(1)
	lis 10,.LC55@ha
	mr 4,24
	stw 26,88(1)
	la 10,.LC55@l(10)
	mr 5,28
	lfd 0,88(1)
	mr 3,28
	lfs 30,.LC47@l(11)
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
	stw 0,92(1)
	mr 5,3
	mr 4,23
	stw 26,88(1)
	lfd 0,88(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmul 1,1,28
	frsp 1,1
	bl VectorMA
	lis 0,0x600
	lis 9,0x4396
	ori 0,0,3
	li 11,9
	stw 9,396(31)
	li 10,2
	stw 11,260(31)
	mr 3,30
	stw 0,252(31)
	li 4,15
	li 5,5
	stw 10,248(31)
	stw 9,388(31)
	stw 9,392(31)
	bl KOTSSpecial
	cmpwi 0,3,0
	bc 4,2,.L114
	lwz 0,64(31)
	ori 0,0,32
	stw 0,64(31)
.L114:
	li 0,0
	lis 9,gi+32@ha
	stw 0,200(31)
	lis 3,.LC48@ha
	stw 0,196(31)
	la 3,.LC48@l(3)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lis 9,Grenade_Touch@ha
	stw 3,40(31)
	lis 10,level+4@ha
	la 9,Grenade_Touch@l(9)
	stw 30,256(31)
	lis 11,Grenade_Explode@ha
	stw 9,444(31)
	cmpwi 0,22,0
	la 11,Grenade_Explode@l(11)
	lfs 0,level+4@l(10)
	lis 9,.LC49@ha
	li 0,120
	la 9,.LC49@l(9)
	stw 11,436(31)
	stw 21,516(31)
	fadds 0,0,27
	stw 0,520(31)
	stfs 26,524(31)
	stw 9,280(31)
	stfs 0,428(31)
	li 0,1
	bc 12,2,.L115
	li 0,3
.L115:
	stw 0,284(31)
	lis 9,gi@ha
	lis 3,.LC50@ha
	la 29,gi@l(9)
	la 3,.LC50@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC56@ha
	fmr 13,27
	stw 3,76(31)
	la 9,.LC56@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L117
	mr 3,31
	bl Grenade_Explode
	b .L118
.L117:
	lwz 9,36(29)
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	mtlr 9
	blrl
	lis 9,.LC57@ha
	lwz 11,16(29)
	lis 10,.LC58@ha
	la 9,.LC57@l(9)
	la 10,.LC58@l(10)
	lfs 2,0(9)
	mr 5,3
	mtlr 11
	li 4,1
	lis 9,.LC57@ha
	mr 3,30
	lfs 3,0(10)
	la 9,.LC57@l(9)
	lfs 1,0(9)
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
.L118:
	lwz 0,196(1)
	mtlr 0
	lmw 21,100(1)
	lfd 26,144(1)
	lfd 27,152(1)
	lfd 28,160(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe8:
	.size	 fire_grenade2,.Lfe8-fire_grenade2
	.section	".rodata"
	.align 2
.LC60:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC59:
	.long 0xbca3d70a
	.align 2
.LC61:
	.long 0x0
	.align 2
.LC62:
	.long 0x40000000
	.align 3
.LC63:
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
	mr 30,6
	cmpw 0,27,0
	bc 12,2,.L120
	cmpwi 4,30,0
	bc 12,18,.L122
	lwz 0,16(30)
	andi. 9,0,4
	bc 12,2,.L122
	bl G_FreeEdict
	b .L120
.L122:
	lwz 3,256(31)
	addi 28,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L123
	mr 4,28
	li 5,2
	bl PlayerNoise
.L123:
	lis 9,.LC59@ha
	addi 29,31,376
	lfs 1,.LC59@l(9)
	mr 3,28
	mr 4,29
	addi 5,1,16
	bl VectorMA
	lwz 0,512(27)
	cmpwi 0,0,0
	bc 12,2,.L124
	lwz 5,256(31)
	li 0,0
	li 11,8
	lwz 9,516(31)
	mr 6,29
	mr 8,26
	stw 0,8(1)
	mr 3,27
	mr 4,31
	stw 11,12(1)
	mr 7,28
	li 10,0
	bl T_Damage
	b .L125
.L124:
	lis 9,deathmatch@ha
	lis 10,.LC61@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC61@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L125
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L125
	bc 12,18,.L125
	lwz 0,16(30)
	andi. 11,0,120
	bc 4,2,.L125
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
	bc 12,2,.L125
	lis 30,.LC60@ha
.L130:
	lis 9,.LC62@ha
	mr 3,31
	la 9,.LC62@l(9)
	la 4,.LC60@l(30)
	lfs 1,0(9)
	mr 5,28
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L130
.L125:
	lwz 0,520(31)
	lis 11,0x4330
	lis 10,.LC63@ha
	lfs 2,524(31)
	mr 5,27
	xoris 0,0,0x8000
	la 10,.LC63@l(10)
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
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L132
	lwz 0,100(29)
	li 3,17
	mtlr 0
	blrl
	b .L133
.L132:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L133:
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
.L120:
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
.LC64:
	.string	"models/objects/rocket/tris.md2"
	.align 2
.LC65:
	.string	"weapons/rockfly.wav"
	.align 2
.LC66:
	.string	"rocket"
	.align 2
.LC67:
	.long 0x46fffe00
	.align 3
.LC68:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC69:
	.long 0x0
	.align 3
.LC70:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC71:
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
	mr 29,4
	fmr 29,1
	mr 26,7
	mr 24,6
	mr 23,8
	mr 28,3
	bl G_Spawn
	lis 25,0x4330
	lfs 13,0(29)
	mr 31,3
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	mr 3,30
	lfd 30,0(9)
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(30)
	stfs 0,340(31)
	lfs 13,4(30)
	stfs 13,344(31)
	lfs 0,8(30)
	stfs 0,348(31)
	bl vectoangles
	xoris 0,26,0x8000
	stw 0,116(1)
	mr 3,30
	addi 4,31,376
	stw 25,112(1)
	lfd 0,112(1)
	fsub 0,0,30
	frsp 28,0
	fmr 1,28
	bl VectorScale
	lis 0,0x600
	li 9,8
	ori 0,0,3
	li 11,2
	stw 9,260(31)
	stw 0,252(31)
	mr 3,28
	li 4,8
	stw 11,248(31)
	li 5,0
	bl KOTSSpecial
	cmpwi 0,3,0
	bc 4,2,.L135
	lwz 0,64(31)
	ori 0,0,16
	stw 0,64(31)
.L135:
	lis 9,.LC69@ha
	lis 3,.LC64@ha
	la 9,.LC69@l(9)
	la 3,.LC64@l(3)
	lfs 31,0(9)
	lis 9,gi@ha
	la 27,gi@l(9)
	stfs 31,196(31)
	stfs 31,192(31)
	stfs 31,188(31)
	stfs 31,208(31)
	stfs 31,204(31)
	stfs 31,200(31)
	lwz 9,32(27)
	mtlr 9
	blrl
	li 0,8000
	stw 3,40(31)
	divw 0,0,26
	lis 9,rocket_touch@ha
	stw 28,256(31)
	lis 8,level+4@ha
	la 9,rocket_touch@l(9)
	lis 11,G_FreeEdict@ha
	stw 9,444(31)
	la 11,G_FreeEdict@l(11)
	lis 3,.LC65@ha
	lfs 13,level+4@l(8)
	la 3,.LC65@l(3)
	stw 11,436(31)
	stw 24,516(31)
	stw 23,520(31)
	stfs 29,524(31)
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 25,112(1)
	lfd 0,112(1)
	fsub 0,0,30
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
	lwz 9,36(27)
	mtlr 9
	blrl
	lis 9,.LC66@ha
	stw 3,76(31)
	la 9,.LC66@l(9)
	stw 9,280(31)
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L136
	lis 9,skill@ha
	addi 29,31,4
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L137
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC67@ha
	stw 3,116(1)
	lis 10,.LC70@ha
	stw 25,112(1)
	la 10,.LC70@l(10)
	lfd 0,112(1)
	lfs 12,.LC67@l(11)
	lfd 11,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L136
.L137:
	lis 9,.LC71@ha
	addi 5,1,8
	la 9,.LC71@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 3,29
	bl VectorMA
	lwz 0,48(27)
	lis 9,0x600
	addi 3,1,40
	mr 4,29
	li 5,0
	li 6,0
	addi 7,1,8
	mtlr 0
	mr 8,28
	ori 9,9,3
	blrl
	lwz 3,92(1)
	cmpwi 0,3,0
	bc 12,2,.L136
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L136
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L136
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L136
	mr 4,28
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L136
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
	mr 4,28
	lfs 0,200(9)
	mr 3,9
	lwz 0,808(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,28
	blrl
.L136:
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
.LC72:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_rail
	.type	 fire_rail,@function
fire_rail:
	stwu 1,-176(1)
	mflr 0
	stmw 19,124(1)
	stw 0,180(1)
	lis 9,.LC72@ha
	mr 26,5
	la 9,.LC72@l(9)
	mr 27,4
	lfs 1,0(9)
	mr 29,3
	addi 5,1,32
	mr 19,5
	mr 23,6
	mr 24,7
	mr 3,27
	mr 4,26
	lis 30,0x600
	bl VectorMA
	mr 31,29
	li 25,0
	lfs 12,0(27)
	cmpwi 0,29,0
	ori 30,30,27
	lfs 13,4(27)
	addi 28,1,60
	lfs 0,8(27)
	stfs 12,16(1)
	stfs 13,20(1)
	stfs 0,24(1)
	bc 12,2,.L143
	lis 9,gi@ha
	li 21,0
	la 20,gi@l(9)
	li 22,11
.L144:
	lwz 11,48(20)
	mr 9,30
	addi 3,1,48
	addi 4,1,16
	li 5,0
	li 6,0
	mr 7,19
	mtlr 11
	mr 8,31
	blrl
	lwz 0,96(1)
	andi. 9,0,24
	bc 12,2,.L145
	li 25,1
	rlwinm 30,30,0,29,26
	b .L146
.L145:
	lwz 9,100(1)
	lwz 0,184(9)
	mr 3,9
	andi. 9,0,4
	bc 4,2,.L148
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L148
	lwz 0,248(3)
	cmpwi 0,0,2
	bc 4,2,.L147
.L148:
	mr 31,3
	b .L149
.L147:
	li 31,0
.L149:
	cmpw 0,3,29
	bc 12,2,.L146
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L146
	stw 21,8(1)
	mr 4,29
	mr 5,29
	stw 22,12(1)
	mr 6,26
	mr 7,28
	addi 8,1,72
	mr 9,23
	mr 10,24
	bl T_Damage
.L146:
	lfs 0,60(1)
	cmpwi 0,31,0
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	bc 4,2,.L144
.L143:
	lis 9,gi@ha
	li 3,3
	la 31,gi@l(9)
	lwz 9,100(31)
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,3
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(31)
	addi 3,29,4
	li 4,1
	mtlr 9
	blrl
	cmpwi 0,25,0
	bc 12,2,.L152
	lwz 9,100(31)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,3
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,27
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
.L152:
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L153
	mr 3,29
	mr 4,28
	li 5,2
	bl PlayerNoise
.L153:
	lwz 0,180(1)
	mtlr 0
	lmw 19,124(1)
	la 1,176(1)
	blr
.Lfe11:
	.size	 fire_rail,.Lfe11-fire_rail
	.section	".rodata"
	.align 2
.LC74:
	.string	"weapons/bfg__x1b.wav"
	.align 2
.LC76:
	.string	"sprites/s_bfg3.sp2"
	.align 2
.LC75:
	.long 0xbdcccccd
	.align 3
.LC77:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC78:
	.long 0x43480000
	.align 2
.LC79:
	.long 0x42c80000
	.align 2
.LC80:
	.long 0x0
	.align 2
.LC81:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl bfg_touch
	.type	 bfg_touch,@function
bfg_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 31,3
	mr 27,4
	lwz 0,256(31)
	mr 29,5
	cmpw 0,27,0
	bc 12,2,.L156
	cmpwi 0,6,0
	bc 12,2,.L158
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L158
	bl G_FreeEdict
	b .L156
.L158:
	lwz 3,256(31)
	addi 30,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L159
	mr 4,30
	li 5,2
	bl PlayerNoise
.L159:
	lwz 0,512(27)
	addi 26,31,376
	cmpwi 0,0,0
	bc 12,2,.L160
	lwz 5,256(31)
	li 9,13
	li 0,0
	stw 9,12(1)
	mr 8,29
	mr 3,27
	stw 0,8(1)
	mr 4,31
	mr 6,26
	mr 7,30
	li 9,200
	li 10,0
	bl T_Damage
.L160:
	lis 9,.LC78@ha
	lwz 4,256(31)
	li 6,13
	la 9,.LC78@l(9)
	mr 5,27
	lfs 1,0(9)
	mr 3,31
	li 28,0
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
	lfs 2,0(9)
	bl T_RadiusDamage
	lis 29,gi@ha
	lis 3,.LC74@ha
	la 29,gi@l(29)
	la 3,.LC74@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC80@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC80@l(9)
	mr 3,31
	lfs 3,0(9)
	mtlr 11
	li 4,2
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 2,0(9)
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 1,0(9)
	blrl
	lis 9,.LC75@ha
	mr 4,26
	stw 28,248(31)
	lfs 1,.LC75@l(9)
	mr 5,30
	mr 3,30
	stw 28,444(31)
	bl VectorMA
	li 0,0
	lis 3,.LC76@ha
	stw 0,376(31)
	la 3,.LC76@l(3)
	stw 0,384(31)
	stw 0,380(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 0,64(31)
	lis 9,bfg_explode@ha
	lis 10,level+4@ha
	la 9,bfg_explode@l(9)
	stw 3,40(31)
	lis 11,.LC77@ha
	rlwinm 0,0,0,19,17
	stw 28,76(31)
	li 3,3
	stw 0,64(31)
	stw 9,436(31)
	stw 28,56(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC77@l(11)
	stw 27,540(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,21
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
.L156:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 bfg_touch,.Lfe12-bfg_touch
	.section	".rodata"
	.align 2
.LC82:
	.string	"misc_explobox"
	.align 3
.LC83:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC84:
	.long 0x0
	.align 2
.LC85:
	.long 0x3f000000
	.align 2
.LC86:
	.long 0x45000000
	.align 2
.LC87:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl bfg_think
	.type	 bfg_think,@function
bfg_think:
	stwu 1,-192(1)
	mflr 0
	stmw 23,156(1)
	stw 0,196(1)
	lis 11,.LC84@ha
	lis 9,deathmatch@ha
	la 11,.LC84@l(11)
	mr 31,3
	lfs 13,0(11)
	li 26,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,10
	andi. 9,9,5
	or 23,0,9
	b .L164
.L179:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,15
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,4
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,104
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,60(31)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	b .L172
.L166:
	cmpw 0,26,31
	bc 12,2,.L164
	lwz 0,256(31)
	cmpw 0,26,0
	bc 12,2,.L164
	lwz 0,512(26)
	cmpwi 0,0,0
	bc 12,2,.L164
	lwz 0,184(26)
	andi. 9,0,4
	bc 4,2,.L170
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 4,2,.L170
	lwz 3,280(26)
	lis 4,.LC82@ha
	la 4,.LC82@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L164
.L170:
	lis 9,.LC85@ha
	addi 5,1,16
	la 9,.LC85@l(9)
	addi 4,26,236
	lfs 1,0(9)
	addi 3,26,212
	mr 30,31
	bl VectorMA
	lfs 12,4(31)
	addi 29,1,32
	addi 27,1,48
	lfs 11,16(1)
	addi 28,1,64
	mr 3,29
	lfs 10,8(31)
	lfs 13,20(1)
	fsubs 11,11,12
	lfs 0,24(1)
	lfs 12,12(31)
	fsubs 13,13,10
	stfs 11,32(1)
	fsubs 0,0,12
	stfs 13,36(1)
	stfs 0,40(1)
	bl VectorNormalize
	lis 9,.LC86@ha
	lfs 12,4(31)
	mr 3,27
	lfs 13,8(31)
	la 9,.LC86@l(9)
	mr 4,29
	lfs 0,12(31)
	mr 5,28
	lfs 1,0(9)
	stfs 12,48(1)
	stfs 13,52(1)
	stfs 0,56(1)
	bl VectorMA
	mr 24,29
	mr 25,27
	addi 29,1,80
	addi 27,1,92
	b .L173
.L174:
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L175
	lwz 0,264(3)
	andi. 9,0,4
	bc 4,2,.L175
	lwz 5,256(31)
	cmpw 0,3,5
	bc 12,2,.L175
	li 9,12
	li 0,4
	lis 8,vec3_origin@ha
	stw 9,12(1)
	mr 4,31
	stw 0,8(1)
	la 8,vec3_origin@l(8)
	mr 6,24
	mr 7,27
	mr 9,23
	li 10,1
	bl T_Damage
.L175:
	lwz 8,132(1)
	lwz 0,184(8)
	mr 9,8
	andi. 11,0,4
	bc 4,2,.L176
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L179
.L176:
	lfs 0,92(1)
	mr 30,8
	lfs 13,96(1)
	lfs 12,100(1)
	stfs 0,48(1)
	stfs 13,52(1)
	stfs 12,56(1)
.L173:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 3,29
	mr 8,30
	mr 4,25
	li 5,0
	li 6,0
	mr 7,28
	mtlr 0
	ori 9,9,1
	blrl
	lwz 3,132(1)
	cmpwi 0,3,0
	bc 4,2,.L174
.L172:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,23
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,1
	mtlr 0
	blrl
.L164:
	lis 9,.LC87@ha
	mr 3,26
	la 9,.LC87@l(9)
	addi 4,31,4
	lfs 1,0(9)
	bl findradius
	mr. 26,3
	bc 4,2,.L166
	lis 9,level+4@ha
	lis 11,.LC83@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC83@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,196(1)
	mtlr 0
	lmw 23,156(1)
	la 1,192(1)
	blr
.Lfe13:
	.size	 bfg_think,.Lfe13-bfg_think
	.section	".rodata"
	.align 2
.LC88:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_bfg
	.type	 fire_bfg,@function
fire_bfg:
	stwu 1,-144(1)
	mflr 0
	stmw 24,112(1)
	stw 0,148(1)
	mr 31,3
	mr 30,5
	addi 27,1,96
	mr 28,4
	mr 25,6
	mr 3,30
	bl VectorNormalize
	lis 9,.LC88@ha
	addi 26,1,28
	la 9,.LC88@l(9)
	mr 3,28
	lfs 1,0(9)
	mr 4,30
	mr 5,27
	mr 24,26
	bl VectorMA
	lis 29,gi@ha
	lis 9,0x600
	lfs 12,0(28)
	la 29,gi@l(29)
	addi 4,1,80
	lfs 13,4(28)
	lwz 11,48(29)
	ori 9,9,3
	addi 3,1,16
	mr 7,27
	li 5,0
	lfs 0,8(28)
	mtlr 11
	li 6,0
	mr 8,31
	stfs 12,80(1)
	stfs 13,84(1)
	stfs 0,88(1)
	blrl
	lwz 9,100(29)
	li 3,3
	lfs 0,28(1)
	lfs 13,32(1)
	mtlr 9
	lfs 12,36(1)
	stfs 0,80(1)
	stfs 13,84(1)
	stfs 12,88(1)
	blrl
	lwz 9,100(29)
	li 3,23
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,1
	mtlr 0
	blrl
	lwz 3,68(1)
	cmpw 0,3,31
	bc 12,2,.L181
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L181
	li 9,12
	mr 4,31
	li 0,4
	lis 8,vec3_origin@ha
	stw 9,12(1)
	stw 0,8(1)
	mr 6,30
	mr 7,24
	la 8,vec3_origin@l(8)
	mr 9,25
	mr 5,4
	li 10,200
	bl T_Damage
	b .L182
.L181:
	lwz 9,60(1)
	cmpwi 0,9,0
	bc 12,2,.L184
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L182
.L184:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,2
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
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L182:
	lwz 0,148(1)
	mtlr 0
	lmw 24,112(1)
	la 1,144(1)
	blr
.Lfe14:
	.size	 fire_bfg,.Lfe14-fire_bfg
	.section	".rodata"
	.align 2
.LC89:
	.string	"sprites/s_bfg1.sp2"
	.align 2
.LC90:
	.string	"bfg blast"
	.align 2
.LC91:
	.string	"weapons/bfg__l1a.wav"
	.align 2
.LC92:
	.long 0x46fffe00
	.align 3
.LC93:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC94:
	.long 0x0
	.align 3
.LC95:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC96:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_bfgball
	.type	 fire_bfgball,@function
fire_bfgball:
	stwu 1,-176(1)
	mflr 0
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 24,112(1)
	stw 0,180(1)
	mr 30,5
	mr 28,7
	fmr 31,1
	mr 27,6
	mr 29,4
	mr 26,3
	lis 24,0x4330
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	lis 9,.LC93@ha
	lis 10,.LC94@ha
	la 9,.LC93@l(9)
	la 10,.LC94@l(10)
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
	stfs 0,340(31)
	lfs 13,4(30)
	stfs 13,344(31)
	lfs 0,8(30)
	stfs 0,348(31)
	bl vectoangles
	xoris 0,28,0x8000
	stw 0,108(1)
	addi 4,31,376
	mr 3,30
	stw 24,104(1)
	lfd 0,104(1)
	fsub 0,0,29
	frsp 28,0
	fmr 1,28
	bl VectorScale
	lwz 11,64(31)
	li 9,8
	lis 0,0x600
	stw 9,260(31)
	ori 0,0,3
	li 10,2
	ori 11,11,8320
	lis 9,gi@ha
	stw 0,252(31)
	la 25,gi@l(9)
	stw 10,248(31)
	lis 3,.LC89@ha
	stw 11,64(31)
	la 3,.LC89@l(3)
	stfs 30,196(31)
	stfs 30,192(31)
	stfs 30,188(31)
	stfs 30,208(31)
	stfs 30,204(31)
	stfs 30,200(31)
	lwz 9,32(25)
	mtlr 9
	blrl
	li 0,8000
	stw 3,40(31)
	divw 0,0,28
	lis 9,bfg_touch@ha
	stw 26,256(31)
	lis 7,level+4@ha
	la 9,bfg_touch@l(9)
	lis 11,G_FreeEdict@ha
	stw 9,444(31)
	lis 10,.LC90@ha
	la 11,G_FreeEdict@l(11)
	lfs 13,level+4@l(7)
	la 10,.LC90@l(10)
	lis 3,.LC91@ha
	stw 11,436(31)
	la 3,.LC91@l(3)
	stw 27,520(31)
	stfs 31,524(31)
	stw 10,280(31)
	xoris 0,0,0x8000
	stw 0,108(1)
	stw 24,104(1)
	lfd 0,104(1)
	fsub 0,0,29
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
	lwz 9,36(25)
	mtlr 9
	blrl
	li 0,0
	stw 3,76(31)
	stw 0,560(31)
	stw 31,564(31)
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L186
	lis 9,skill@ha
	addi 29,31,4
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L187
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC92@ha
	stw 3,108(1)
	lis 10,.LC95@ha
	stw 24,104(1)
	la 10,.LC95@l(10)
	lfd 0,104(1)
	lfs 12,.LC92@l(11)
	lfd 11,0(10)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L186
.L187:
	lis 9,.LC96@ha
	addi 5,1,8
	la 9,.LC96@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 3,29
	bl VectorMA
	lwz 0,48(25)
	lis 9,0x600
	addi 3,1,40
	mr 4,29
	li 5,0
	li 6,0
	addi 7,1,8
	mtlr 0
	mr 8,26
	ori 9,9,3
	blrl
	lwz 3,92(1)
	cmpwi 0,3,0
	bc 12,2,.L186
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L186
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L186
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L186
	mr 4,26
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L186
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
	mr 4,26
	lfs 0,200(9)
	mr 3,9
	lwz 0,808(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,28
	blrl
.L186:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,180(1)
	mtlr 0
	lmw 24,112(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe15:
	.size	 fire_bfgball,.Lfe15-fire_bfgball
	.section	".rodata"
	.align 2
.LC97:
	.string	"boomerang"
	.align 2
.LC98:
	.string	"models/items/keys/data_cd/tris.md2"
	.align 2
.LC99:
	.string	"flyer/Flyatck2.wav"
	.align 2
.LC100:
	.string	"Damage Amp"
	.align 2
.LC101:
	.string	"resist"
	.align 2
.LC102:
	.string	"player"
	.align 2
.LC103:
	.string	"You got the boomerang\nTo use this type KOTSBOOMERANG\n"
	.align 2
.LC104:
	.long 0x44610000
	.align 2
.LC105:
	.long 0x42b40000
	.align 2
.LC106:
	.long 0x3f800000
	.align 2
.LC107:
	.long 0x40400000
	.align 2
.LC108:
	.long 0x0
	.align 2
.LC109:
	.long 0x43960000
	.section	".text"
	.align 2
	.type	 Boomerang_Touch,@function
Boomerang_Touch:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 3,280(31)
	lis 4,.LC97@ha
	mr 27,5
	la 4,.LC97@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L191
	lwz 0,512(31)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L194
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,1,.L193
.L194:
	lwz 0,532(30)
	cmpwi 0,0,0
	bc 12,1,.L193
	bl G_Spawn
	addi 29,30,936
	mr 31,3
	stw 30,256(31)
	mr 3,29
	addi 28,31,4
	lfs 0,4(30)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
	stfs 0,12(31)
	bl VectorInverse
	lfs 13,936(30)
	mr 3,29
	addi 4,31,16
	stfs 13,340(31)
	lfs 0,940(30)
	stfs 0,344(31)
	lfs 13,944(30)
	stfs 13,348(31)
	lfs 0,936(30)
	stfs 0,936(31)
	lfs 13,940(30)
	stfs 13,940(31)
	lfs 0,944(30)
	stfs 0,944(31)
	bl vectoangles
	lis 9,.LC104@ha
	addi 4,31,376
	la 9,.LC104@l(9)
	addi 3,31,340
	lfs 1,0(9)
	bl VectorScale
	lis 9,.LC105@ha
	lfs 0,16(31)
	mr 3,30
	la 9,.LC105@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,16(31)
	lwz 0,444(30)
	stw 0,444(31)
	lwz 9,516(30)
	stw 9,516(31)
	lwz 0,280(30)
	stw 0,280(31)
	lwz 11,544(30)
	stw 11,544(31)
	lwz 9,532(30)
	addi 9,9,1
	stw 9,532(30)
	stw 9,532(31)
	bl G_FreeEdict
	lis 0,0x600
	lis 7,0xc180
	ori 0,0,3
	lis 8,0x4180
	stw 7,192(31)
	stw 0,252(31)
	li 11,2
	lis 10,0xc0e0
	lis 0,0x40e0
	li 9,8
	stw 11,248(31)
	lis 29,gi@ha
	stw 0,208(31)
	lis 3,.LC98@ha
	la 29,gi@l(29)
	stw 10,196(31)
	la 3,.LC98@l(3)
	stw 8,204(31)
	stw 7,188(31)
	stw 8,200(31)
	stw 9,260(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	stw 3,40(31)
	lwz 9,100(29)
	li 3,3
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
	mr 3,27
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC99@ha
	la 3,.LC99@l(3)
	mtlr 9
	blrl
	lis 9,.LC106@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC106@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC107@ha
	la 9,.LC107@l(9)
	lfs 2,0(9)
	lis 9,.LC108@ha
	la 9,.LC108@l(9)
	lfs 3,0(9)
	blrl
	b .L191
.L193:
	cmpwi 0,9,0
	bc 12,2,.L197
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,1,.L196
.L197:
	lwz 0,532(30)
	cmpwi 0,0,0
	bc 4,1,.L196
	cmpwi 0,0,2
	bc 12,1,.L191
	bl G_Spawn
	lfs 0,28(30)
	mr 31,3
	lis 29,gi@ha
	mr 28,31
	la 29,gi@l(29)
	li 3,3
	stfsu 0,4(28)
	lfs 0,32(30)
	stfs 0,8(31)
	lfs 13,36(30)
	stfs 13,12(31)
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
	mr 3,27
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC99@ha
	la 3,.LC99@l(3)
	mtlr 9
	blrl
	lis 9,.LC107@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC107@l(9)
	li 4,0
	lfs 2,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC108@ha
	la 9,.LC108@l(9)
	lfs 3,0(9)
	lis 9,.LC106@ha
	la 9,.LC106@l(9)
	lfs 1,0(9)
	blrl
	addi 3,30,936
	bl VectorInverse
	lfs 13,936(30)
	lis 9,.LC109@ha
	addi 4,31,376
	la 9,.LC109@l(9)
	addi 3,31,340
	lfs 1,0(9)
	stfs 13,340(31)
	lfs 0,940(30)
	stfs 0,344(31)
	lfs 13,944(30)
	stfs 13,348(31)
	lfs 0,936(30)
	stfs 0,936(31)
	lfs 13,940(30)
	stfs 13,940(31)
	lfs 0,944(30)
	stfs 0,944(31)
	bl VectorScale
	stw 30,256(31)
	mr 3,30
	lwz 0,444(30)
	stw 0,444(31)
	lwz 9,516(30)
	stw 9,516(31)
	lwz 0,280(30)
	stw 0,280(31)
	lwz 11,544(30)
	stw 11,544(31)
	lwz 9,532(30)
	addi 9,9,1
	stw 9,532(30)
	stw 9,532(31)
	bl G_FreeEdict
	lis 0,0x600
	lis 6,0xc180
	ori 0,0,3
	lis 7,0x4180
	stw 6,192(31)
	stw 0,252(31)
	li 9,9
	li 11,2
	lis 10,0xc0e0
	lis 8,0x40e0
	stw 9,260(31)
	lis 0,0x42b4
	stw 11,248(31)
	lis 3,.LC98@ha
	stw 10,196(31)
	la 3,.LC98@l(3)
	stw 7,204(31)
	stw 8,208(31)
	stw 0,16(31)
	stw 6,188(31)
	stw 7,200(31)
	lwz 0,32(29)
	mtlr 0
	blrl
	stw 3,40(31)
	b .L191
.L196:
	lis 3,.LC100@ha
	lwz 29,84(31)
	lis 28,0x286b
	la 3,.LC100@l(3)
	ori 28,28,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,28
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,1,.L191
	lis 3,.LC101@ha
	lwz 29,84(31)
	la 3,.LC101@l(3)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,28
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,1,.L191
	lwz 3,280(31)
	lis 29,.LC102@ha
	la 4,.LC102@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L202
	lwz 9,84(31)
	lwz 0,1860(9)
	cmpwi 0,0,24
	bc 12,1,.L191
.L202:
	lwz 0,544(30)
	cmpw 0,31,0
	bc 12,2,.L203
	lis 9,gi+8@ha
	lis 5,.LC103@ha
	lwz 0,gi+8@l(9)
	la 5,.LC103@l(5)
	mr 3,31
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
.L203:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L191
	lwz 3,280(31)
	la 4,.LC102@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L191
	lis 29,gi@ha
	lis 3,.LC99@ha
	la 29,gi@l(29)
	la 3,.LC99@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC106@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC106@l(9)
	li 4,0
	lfs 1,0(9)
	mtlr 0
	mr 3,31
	lis 9,.LC107@ha
	la 9,.LC107@l(9)
	lfs 2,0(9)
	lis 9,.LC108@ha
	la 9,.LC108@l(9)
	lfs 3,0(9)
	blrl
	mr 3,30
	bl G_FreeEdict
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	bl FindItem
	subf 3,27,3
	lwz 11,84(31)
	mullw 3,3,28
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,1
	stwx 9,11,3
.L191:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Boomerang_Touch,.Lfe16-Boomerang_Touch
	.section	".rodata"
	.align 2
.LC110:
	.string	"brain/melee2.wav"
	.align 2
.LC111:
	.string	"You are blinded by a flash grenade!!!\n"
	.align 2
.LC112:
	.string	"%s is blinded by your flash grenade!\n"
	.align 2
.LC113:
	.long 0x0
	.align 2
.LC114:
	.long 0x41200000
	.align 3
.LC115:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC116:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl Flash_Grenade_Explode
	.type	 Flash_Grenade_Explode,@function
Flash_Grenade_Explode:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	lis 7,.LC113@ha
	lis 9,.LC114@ha
	mr 31,3
	la 7,.LC113@l(7)
	la 9,.LC114@l(9)
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	lfs 0,0(7)
	lfs 10,0(9)
	lwz 3,256(31)
	fadds 13,13,0
	stfs 0,8(1)
	fadds 12,12,0
	stfs 0,12(1)
	fadds 11,11,10
	stfs 13,4(31)
	stfs 12,8(31)
	stfs 11,12(31)
	stfs 10,16(1)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L208
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L208:
	li 30,0
	addi 28,31,4
	b .L209
.L211:
	lwz 0,256(31)
	cmpw 0,30,0
	bc 12,2,.L209
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L209
	mr 3,31
	mr 4,30
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L209
	mr 3,30
	mr 4,31
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L209
	lwz 11,84(30)
	lis 0,0x4170
	lis 10,0x41a0
	stw 0,3956(11)
	lwz 9,84(30)
	stw 10,3960(9)
	bl rand
	lis 0,0xb60b
	mr 9,3
	ori 0,0,24759
	srawi 10,9,31
	mulhw 0,9,0
	lis 8,0x4330
	lis 7,.LC115@ha
	lis 29,gi@ha
	add 0,0,9
	la 7,.LC115@l(7)
	srawi 0,0,8
	lfd 13,0(7)
	la 29,gi@l(29)
	subf 0,10,0
	lis 5,.LC111@ha
	mulli 0,0,360
	la 5,.LC111@l(5)
	mr 3,30
	li 4,2
	subf 9,0,9
	xoris 9,9,0x8000
	stw 9,44(1)
	stw 8,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,20(30)
	lwz 9,8(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 6,84(30)
	lis 5,.LC112@ha
	li 4,2
	lwz 0,8(29)
	la 5,.LC112@l(5)
	addi 6,6,700
	lwz 3,256(31)
	mtlr 0
	crxor 6,6,6
	blrl
.L209:
	lis 7,.LC116@ha
	mr 3,30
	la 7,.LC116@l(7)
	mr 4,28
	lfs 1,0(7)
	bl findradius
	mr. 30,3
	bc 4,2,.L211
	mr 3,31
	bl BecomeExplosion1
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe17:
	.size	 Flash_Grenade_Explode,.Lfe17-Flash_Grenade_Explode
	.section	".rodata"
	.align 2
.LC117:
	.long 0x46fffe00
	.align 3
.LC118:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC119:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC120:
	.long 0x40240000
	.long 0x0
	.align 3
.LC121:
	.long 0x40690000
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_flash_grenade
	.type	 fire_flash_grenade,@function
fire_flash_grenade:
	stwu 1,-176(1)
	mflr 0
	stfd 26,128(1)
	stfd 27,136(1)
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 23,92(1)
	stw 0,180(1)
	mr 27,4
	mr 25,5
	fmr 26,2
	mr 30,3
	addi 4,1,8
	fmr 27,1
	mr 29,6
	mr 3,25
	bl vectoangles
	lis 26,0x4330
	addi 23,1,40
	addi 24,1,56
	addi 4,1,24
	mr 6,24
	addi 3,1,8
	mr 5,23
	bl AngleVectors
	lis 9,.LC118@ha
	la 9,.LC118@l(9)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC119@ha
	lfs 13,0(27)
	xoris 29,29,0x8000
	la 9,.LC119@l(9)
	mr 31,3
	lfd 29,0(9)
	lis 10,.LC120@ha
	addi 28,31,376
	stfs 13,4(31)
	la 10,.LC120@l(10)
	stw 29,84(1)
	mr 4,28
	mr 3,25
	stw 26,80(1)
	lfd 1,80(1)
	lfs 0,4(27)
	lfd 28,0(10)
	fsub 1,1,31
	stfs 0,8(31)
	lfs 13,8(27)
	frsp 1,1
	stfs 13,12(31)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC117@ha
	stw 3,84(1)
	lis 10,.LC121@ha
	mr 4,24
	stw 26,80(1)
	la 10,.LC121@l(10)
	mr 5,28
	lfd 0,80(1)
	mr 3,28
	lfs 30,.LC117@l(11)
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
	mr 5,3
	mr 4,23
	stw 26,80(1)
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
	lis 0,0x600
	lis 9,0x4396
	ori 0,0,3
	li 11,9
	stw 9,396(31)
	li 10,2
	stw 11,260(31)
	mr 3,30
	stw 0,252(31)
	li 4,6
	li 5,12
	stw 10,248(31)
	stw 9,388(31)
	stw 9,392(31)
	bl KOTSSpecial
	cmpwi 0,3,0
	bc 4,2,.L218
	lwz 0,64(31)
	ori 0,0,32
	stw 0,64(31)
.L218:
	li 0,0
	lis 9,0x1
	lis 29,gi@ha
	stw 0,200(31)
	lis 3,.LC42@ha
	la 29,gi@l(29)
	stw 0,196(31)
	la 3,.LC42@l(3)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	stw 9,284(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,Grenade_Touch@ha
	stw 3,40(31)
	lis 8,level+4@ha
	la 9,Grenade_Touch@l(9)
	stw 30,256(31)
	lis 11,Flash_Grenade_Explode@ha
	stw 9,444(31)
	lis 10,.LC36@ha
	li 0,0
	lfs 0,level+4@l(8)
	la 11,Flash_Grenade_Explode@l(11)
	la 10,.LC36@l(10)
	stw 11,436(31)
	mr 3,31
	stw 0,516(31)
	fadds 0,0,27
	stfs 26,524(31)
	stw 10,280(31)
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,180(1)
	mtlr 0
	lmw 23,92(1)
	lfd 26,128(1)
	lfd 27,136(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe18:
	.size	 fire_flash_grenade,.Lfe18-fire_flash_grenade
	.align 2
	.globl fire_bullet
	.type	 fire_bullet,@function
fire_bullet:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 0,9
	stw 10,8(1)
	mr 9,8
	mr 10,0
	li 8,0
	bl fire_lead
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 fire_bullet,.Lfe19-fire_bullet
	.align 2
	.globl fire_shotgun
	.type	 fire_shotgun,@function
fire_shotgun:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	mr. 0,10
	mr 24,3
	lwz 23,72(1)
	mr 25,4
	mr 26,5
	mr 27,6
	mr 28,7
	mtctr 0
	mr 29,8
	mr 30,9
	bc 4,1,.L52
	mfctr 31
.L54:
	stw 23,8(1)
	mr 3,24
	mr 4,25
	mr 5,26
	mr 6,27
	mr 7,28
	li 8,4
	mr 9,29
	mr 10,30
	bl fire_lead
	addic. 31,31,-1
	bc 4,2,.L54
.L52:
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe20:
	.size	 fire_shotgun,.Lfe20-fire_shotgun
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
	bc 12,2,.L56
	cmpwi 0,6,0
	bc 12,2,.L58
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L58
	bl G_FreeEdict
	b .L56
.L58:
	lwz 3,256(30)
	addi 29,30,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L59
	mr 4,29
	li 5,2
	bl PlayerNoise
.L59:
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L60
	lwz 0,284(30)
	andi. 9,0,1
	bc 12,2,.L61
	li 11,10
	b .L62
.L61:
	andi. 9,0,2
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,31,31
	andi. 9,9,36
	or 11,0,9
.L62:
	lwz 5,256(30)
	li 0,4
	mr 3,31
	lwz 9,516(30)
	mr 7,29
	mr 8,28
	stw 0,8(1)
	mr 4,30
	addi 6,30,376
	stw 11,12(1)
	li 10,1
	bl T_Damage
	b .L65
.L60:
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
	bc 4,2,.L66
	lwz 0,124(31)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L67
.L66:
	lwz 0,124(31)
	mr 3,28
	mtlr 0
	blrl
.L67:
	lis 9,gi+88@ha
	mr 3,29
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L65:
	mr 3,30
	bl G_FreeEdict
.L56:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 blaster_touch,.Lfe21-blaster_touch
	.section	".rodata"
	.align 3
.LC122:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl bfg_explode
	.type	 bfg_explode,@function
bfg_explode:
	stwu 1,-32(1)
	lis 9,level+4@ha
	lis 11,.LC122@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC122@l(11)
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,5
	stw 9,56(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	bc 4,2,.L155
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(3)
.L155:
	la 1,32(1)
	blr
.Lfe22:
	.size	 bfg_explode,.Lfe22-bfg_explode
	.section	".rodata"
	.align 3
.LC123:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC124:
	.long 0x42b40000
	.align 2
.LC125:
	.long 0x3f800000
	.align 2
.LC126:
	.long 0x40400000
	.align 2
.LC127:
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_boomerang
	.type	 fire_boomerang,@function
fire_boomerang:
	stwu 1,-112(1)
	mflr 0
	stmw 24,80(1)
	stw 0,116(1)
	mr 27,5
	mr 26,7
	mr 24,6
	mr 28,4
	mr 25,3
	bl G_Spawn
	lfs 13,0(28)
	mr 29,3
	mr 3,27
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,4(28)
	stfs 0,8(29)
	lfs 13,8(28)
	stfs 13,12(29)
	lfs 0,0(27)
	stfs 0,340(29)
	lfs 13,4(27)
	stfs 13,344(29)
	lfs 0,8(27)
	stfs 0,348(29)
	lfs 13,0(27)
	stfs 13,936(29)
	lfs 0,4(27)
	stfs 0,940(29)
	lfs 13,8(27)
	stfs 13,944(29)
	bl vectoangles
	xoris 26,26,0x8000
	stw 26,76(1)
	lis 0,0x4330
	lis 11,.LC123@ha
	stw 0,72(1)
	la 11,.LC123@l(11)
	addi 4,29,376
	lfd 1,72(1)
	mr 3,27
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lis 9,.LC124@ha
	lfs 13,16(29)
	lis 0,0x600
	la 9,.LC124@l(9)
	ori 0,0,3
	lfs 0,0(9)
	lis 7,0xc1a0
	lis 8,0x41a0
	stw 0,252(29)
	lis 10,0x40e0
	li 11,2
	lis 0,0xc0e0
	li 9,8
	stw 7,192(29)
	fadds 13,13,0
	lis 28,gi@ha
	stw 0,196(29)
	lis 3,.LC98@ha
	la 28,gi@l(28)
	stw 8,204(29)
	la 3,.LC98@l(3)
	stw 10,208(29)
	stfs 13,16(29)
	stw 7,188(29)
	stw 8,200(29)
	stw 11,248(29)
	stw 9,260(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,Boomerang_Touch@ha
	lis 11,.LC97@ha
	stw 3,40(29)
	la 11,.LC97@l(11)
	la 9,Boomerang_Touch@l(9)
	stw 24,516(29)
	stw 11,280(29)
	mr 3,29
	stw 9,444(29)
	stw 25,256(29)
	stw 25,544(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 9,36(28)
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
	mtlr 9
	blrl
	lis 9,.LC125@ha
	lwz 0,16(28)
	lis 11,.LC126@ha
	la 9,.LC125@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC126@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC127@ha
	mr 3,25
	lfs 2,0(11)
	la 9,.LC127@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe23:
	.size	 fire_boomerang,.Lfe23-fire_boomerang
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
