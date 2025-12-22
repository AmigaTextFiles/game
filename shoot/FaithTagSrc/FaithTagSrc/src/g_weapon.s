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
	.align 2
.LC14:
	.string	"models/objects/laser/tris.md2"
	.align 2
.LC15:
	.string	"misc/lasfly.wav"
	.align 2
.LC16:
	.string	"bolt"
	.align 2
.LC17:
	.long 0x46fffe00
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x40000000
	.align 3
.LC21:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC22:
	.long 0x46000000
	.align 3
.LC23:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC24:
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
	mr 23,5
	mr 30,3
	mr 29,4
	mr 25,9
	mr 24,6
	mr 28,7
	mr 26,8
	mr 3,23
	bl VectorNormalize
	li 27,2
	lis 22,0x4330
	bl G_Spawn
	mr 31,3
	lis 9,.LC18@ha
	stw 27,184(31)
	lis 10,.LC19@ha
	la 9,.LC18@l(9)
	lfs 0,0(29)
	la 10,.LC19@l(10)
	mr 3,23
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
	mr 3,23
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
	or 9,9,26
	la 28,gi@l(10)
	stw 0,252(31)
	stw 27,248(31)
	lis 3,.LC14@ha
	stw 9,64(31)
	la 3,.LC14@l(3)
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
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	mtlr 9
	blrl
	lis 9,blaster_touch@ha
	lis 11,.LC20@ha
	stw 3,76(31)
	la 9,blaster_touch@l(9)
	la 11,.LC20@l(11)
	stw 30,256(31)
	stw 9,444(31)
	lis 10,level+4@ha
	cmpwi 0,25,0
	lfs 0,level+4@l(10)
	lis 9,G_FreeEdict@ha
	lfs 13,0(11)
	la 9,G_FreeEdict@l(9)
	lis 11,.LC16@ha
	stw 9,436(31)
	la 11,.LC16@l(11)
	stw 24,516(31)
	fadds 0,0,13
	stw 11,280(31)
	stfs 0,428(31)
	bc 12,2,.L67
	li 0,1
	stw 0,284(31)
.L67:
	lwz 9,72(28)
	mr 3,31
	addi 29,31,4
	mtlr 9
	blrl
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L68
	lis 9,skill@ha
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L69
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC17@ha
	stw 3,172(1)
	lis 10,.LC21@ha
	stw 22,168(1)
	la 10,.LC21@l(10)
	lfd 0,168(1)
	lfs 12,.LC17@l(11)
	lfd 11,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L68
.L69:
	lis 11,.LC22@ha
	addi 5,1,72
	la 11,.LC22@l(11)
	mr 3,29
	lfs 1,0(11)
	mr 4,23
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
	bc 12,2,.L68
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L68
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L68
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L68
	mr 4,30
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L68
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
	lwz 0,808(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,29
	blrl
.L68:
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
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L73
	lis 10,.LC24@ha
	mr 3,29
	la 10,.LC24@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,23
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L73:
	lwz 0,244(1)
	mtlr 0
	lmw 22,176(1)
	lfd 29,216(1)
	lfd 30,224(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe3:
	.size	 fire_blaster,.Lfe3-fire_blaster
	.section	".rodata"
	.align 2
.LC25:
	.long 0xbca3d70a
	.align 2
.LC26:
	.long 0x3f000000
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC28:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.type	 Grenade_Explode,@function
Grenade_Explode:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	mr 31,3
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L75
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L75:
	lwz 9,540(31)
	addi 30,31,4
	cmpwi 0,9,0
	bc 12,2,.L76
	lfs 0,200(9)
	lis 10,.LC26@ha
	addi 29,1,32
	lfs 13,188(9)
	la 10,.LC26@l(10)
	addi 3,9,4
	lfs 1,0(10)
	mr 4,29
	mr 5,29
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
	lfs 0,4(31)
	mr 3,29
	lfs 13,8(31)
	lfs 12,12(31)
	lfs 9,32(1)
	lfs 11,36(1)
	lfs 10,40(1)
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,32(1)
	stfs 13,36(1)
	stfs 12,40(1)
	bl VectorLength
	lis 10,.LC28@ha
	lwz 0,516(31)
	la 10,.LC28@l(10)
	lis 7,0x4330
	lfs 9,4(31)
	lfd 0,0(10)
	xoris 0,0,0x8000
	lis 9,.LC27@ha
	stw 0,76(1)
	la 9,.LC27@l(9)
	li 29,1
	lwz 10,540(31)
	lis 8,vec3_origin@ha
	mr 4,31
	stw 7,72(1)
	fmul 1,1,0
	la 8,vec3_origin@l(8)
	addi 6,1,48
	lfd 12,0(9)
	mr 3,10
	mr 7,30
	lfd 0,72(1)
	mr 9,11
	lfs 13,4(10)
	lfs 10,8(31)
	fsub 0,0,12
	lwz 0,284(31)
	fsubs 13,13,9
	lfs 8,12(31)
	lwz 5,256(31)
	rlwinm 0,0,0,31,31
	fsub 0,0,1
	neg 0,0
	stfs 13,48(1)
	rlwinm 0,0,0,28,31
	lfs 13,8(10)
	ori 12,0,6
	frsp 0,0
	fsubs 13,13,10
	fmr 12,0
	stfs 13,52(1)
	lfs 0,12(10)
	fctiwz 11,12
	stw 29,8(1)
	stw 12,12(1)
	fsubs 0,0,8
	stfd 11,72(1)
	lwz 9,76(1)
	stfs 0,56(1)
	mr 10,9
	bl T_Damage
.L76:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L79
	li 12,24
	b .L80
.L79:
	andi. 10,0,1
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,29,31
	rlwinm 9,9,0,27,27
	or 12,0,9
.L80:
	lwz 0,516(31)
	lis 11,0x4330
	lis 10,.LC27@ha
	lfs 2,524(31)
	mr 6,12
	xoris 0,0,0x8000
	la 10,.LC27@l(10)
	lwz 4,256(31)
	stw 0,76(1)
	mr 3,31
	stw 11,72(1)
	lfd 1,72(1)
	lfd 0,0(10)
	lwz 5,540(31)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,.LC25@ha
	mr 3,30
	lfs 1,.LC25@l(9)
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
	bc 12,2,.L83
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L84
	lwz 0,100(29)
	li 3,18
	b .L89
.L84:
	lwz 0,100(29)
	li 3,17
	b .L89
.L83:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L87
	lwz 0,100(29)
	li 3,8
.L89:
	mtlr 0
	blrl
	b .L86
.L87:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L86:
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
.Lfe4:
	.size	 Grenade_Explode,.Lfe4-Grenade_Explode
	.section	".rodata"
	.align 2
.LC30:
	.string	"weapons/hgrenb1a.wav"
	.align 2
.LC31:
	.string	"weapons/hgrenb2a.wav"
	.align 2
.LC32:
	.string	"weapons/grenlb1b.wav"
	.align 2
.LC34:
	.string	"models/objects/grenade/tris.md2"
	.align 2
.LC35:
	.string	"grenade"
	.align 2
.LC33:
	.long 0x46fffe00
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC37:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC38:
	.long 0x40240000
	.long 0x0
	.align 3
.LC39:
	.long 0x40690000
	.long 0x0
	.section	".text"
	.align 2
	.globl fire_grenade
	.type	 fire_grenade,@function
fire_grenade:
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
	mr 22,3
	mr 28,7
	fmr 27,1
	addi 23,1,40
	addi 4,1,8
	mr 21,6
	mr 3,25
	bl vectoangles
	lis 26,0x4330
	addi 24,1,56
	addi 4,1,24
	mr 6,24
	addi 3,1,8
	mr 5,23
	bl AngleVectors
	lis 9,.LC36@ha
	lis 10,.LC37@ha
	la 10,.LC37@l(10)
	la 9,.LC36@l(9)
	lfd 29,0(10)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC38@ha
	lfs 13,0(27)
	xoris 28,28,0x8000
	la 9,.LC38@l(9)
	mr 29,3
	lfd 28,0(9)
	mr 3,25
	stfs 13,4(29)
	stw 28,92(1)
	stw 26,88(1)
	addi 28,29,376
	lfd 1,88(1)
	mr 4,28
	lfs 0,4(27)
	fsub 1,1,31
	stfs 0,8(29)
	lfs 13,8(27)
	frsp 1,1
	stfs 13,12(29)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC33@ha
	stw 3,92(1)
	lis 10,.LC39@ha
	mr 5,28
	stw 26,88(1)
	la 10,.LC39@l(10)
	mr 4,24
	lfd 0,88(1)
	mr 3,28
	lfs 30,.LC33@l(11)
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
	lwz 8,64(29)
	lis 0,0x600
	li 9,0
	lis 11,0x4396
	ori 0,0,3
	stw 9,200(29)
	ori 8,8,32
	li 10,9
	stw 11,396(29)
	li 7,2
	lis 28,gi@ha
	stw 10,260(29)
	la 28,gi@l(28)
	stw 0,252(29)
	lis 3,.LC34@ha
	stw 8,64(29)
	la 3,.LC34@l(3)
	stw 11,388(29)
	stw 11,392(29)
	stw 7,248(29)
	stw 9,196(29)
	stw 9,192(29)
	stw 9,188(29)
	stw 9,208(29)
	stw 9,204(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,Grenade_Touch@ha
	stw 3,40(29)
	lis 8,level+4@ha
	la 9,Grenade_Touch@l(9)
	stw 22,256(29)
	lis 11,Grenade_Explode@ha
	stw 9,444(29)
	lis 10,.LC35@ha
	la 11,Grenade_Explode@l(11)
	lfs 0,level+4@l(8)
	la 10,.LC35@l(10)
	mr 3,29
	stw 11,436(29)
	stw 21,516(29)
	fadds 0,0,27
	stfs 26,524(29)
	stw 10,280(29)
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
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
.Lfe5:
	.size	 fire_grenade,.Lfe5-fire_grenade
	.section	".rodata"
	.align 2
.LC41:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC42:
	.string	"hgrenade"
	.align 2
.LC43:
	.string	"weapons/hgrenc1b.wav"
	.align 2
.LC44:
	.string	"weapons/hgrent1a.wav"
	.align 2
.LC40:
	.long 0x46fffe00
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC46:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC47:
	.long 0x40240000
	.long 0x0
	.align 3
.LC48:
	.long 0x40690000
	.long 0x0
	.align 3
.LC49:
	.long 0x0
	.long 0x0
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
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
	fmr 27,2
	mr 30,3
	mr 29,7
	fmr 26,1
	mr 22,8
	addi 4,1,8
	mr 21,6
	mr 3,25
	bl vectoangles
	lis 26,0x4330
	addi 23,1,40
	addi 24,1,56
	mr 6,24
	addi 4,1,24
	addi 3,1,8
	mr 5,23
	bl AngleVectors
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC46@ha
	lfs 13,0(27)
	xoris 29,29,0x8000
	la 9,.LC46@l(9)
	mr 31,3
	lfd 29,0(9)
	lis 10,.LC47@ha
	addi 28,31,376
	stfs 13,4(31)
	la 10,.LC47@l(10)
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
	lis 11,.LC40@ha
	stw 3,92(1)
	lis 10,.LC48@ha
	mr 4,24
	stw 26,88(1)
	la 10,.LC48@l(10)
	mr 5,28
	lfd 0,88(1)
	mr 3,28
	lfs 30,.LC40@l(11)
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
	lwz 8,64(31)
	lis 0,0x600
	li 9,0
	lis 10,0x4396
	ori 0,0,3
	stw 9,200(31)
	li 11,9
	ori 8,8,32
	stw 10,396(31)
	li 7,2
	stw 11,260(31)
	lis 6,gi+32@ha
	stw 10,388(31)
	lis 3,.LC41@ha
	stw 10,392(31)
	la 3,.LC41@l(3)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	stw 0,252(31)
	stw 7,248(31)
	stw 8,64(31)
	lwz 0,gi+32@l(6)
	mtlr 0
	blrl
	lis 11,Grenade_Touch@ha
	stw 3,40(31)
	lis 10,level+4@ha
	la 11,Grenade_Touch@l(11)
	stw 30,256(31)
	lis 9,Grenade_Explode@ha
	stw 11,444(31)
	cmpwi 0,22,0
	la 9,Grenade_Explode@l(9)
	lfs 0,level+4@l(10)
	lis 11,.LC42@ha
	la 11,.LC42@l(11)
	stw 9,436(31)
	stw 21,516(31)
	fadds 0,0,26
	stfs 27,524(31)
	stw 11,280(31)
	stfs 0,428(31)
	li 0,1
	bc 12,2,.L100
	li 0,3
.L100:
	stw 0,284(31)
	lis 9,gi@ha
	lis 3,.LC43@ha
	la 29,gi@l(9)
	la 3,.LC43@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC49@ha
	fmr 13,26
	stw 3,76(31)
	la 9,.LC49@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L102
	mr 3,31
	bl Grenade_Explode
	b .L103
.L102:
	lwz 9,36(29)
	lis 3,.LC44@ha
	la 3,.LC44@l(3)
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 11,16(29)
	lis 10,.LC51@ha
	la 9,.LC50@l(9)
	la 10,.LC51@l(10)
	lfs 2,0(9)
	mr 5,3
	mtlr 11
	li 4,1
	lis 9,.LC50@ha
	mr 3,30
	lfs 3,0(10)
	la 9,.LC50@l(9)
	lfs 1,0(9)
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
.L103:
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
.Lfe6:
	.size	 fire_grenade2,.Lfe6-fire_grenade2
	.section	".rodata"
	.align 2
.LC53:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC52:
	.long 0xbca3d70a
	.align 2
.LC54:
	.long 0x0
	.align 2
.LC55:
	.long 0x40000000
	.align 3
.LC56:
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
	bc 12,2,.L105
	cmpwi 4,30,0
	bc 12,18,.L107
	lwz 0,16(30)
	andi. 9,0,4
	bc 12,2,.L107
	bl G_FreeEdict
	b .L105
.L107:
	lwz 3,256(31)
	addi 28,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L108
	mr 4,28
	li 5,2
	bl PlayerNoise
.L108:
	lis 9,.LC52@ha
	addi 29,31,376
	lfs 1,.LC52@l(9)
	mr 3,28
	mr 4,29
	addi 5,1,16
	bl VectorMA
	lwz 0,512(27)
	cmpwi 0,0,0
	bc 12,2,.L109
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
	b .L110
.L109:
	lis 9,deathmatch@ha
	lis 10,.LC54@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC54@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L110
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L110
	bc 12,18,.L110
	lwz 0,16(30)
	andi. 11,0,120
	bc 4,2,.L110
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
	bc 12,2,.L110
	lis 30,.LC53@ha
.L115:
	lis 9,.LC55@ha
	mr 3,31
	la 9,.LC55@l(9)
	la 4,.LC53@l(30)
	lfs 1,0(9)
	mr 5,28
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L115
.L110:
	lwz 0,520(31)
	lis 11,0x4330
	lis 10,.LC56@ha
	lfs 2,524(31)
	mr 5,27
	xoris 0,0,0x8000
	la 10,.LC56@l(10)
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
	bc 12,2,.L117
	lwz 0,100(29)
	li 3,17
	mtlr 0
	blrl
	b .L118
.L117:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L118:
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
.L105:
	lwz 0,84(1)
	lwz 12,52(1)
	mtlr 0
	lmw 26,56(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe7:
	.size	 rocket_touch,.Lfe7-rocket_touch
	.section	".rodata"
	.align 2
.LC57:
	.string	"models/objects/rocket/tris.md2"
	.align 2
.LC58:
	.string	"weapons/rockfly.wav"
	.align 2
.LC59:
	.string	"rocket"
	.align 2
.LC60:
	.long 0x46fffe00
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC62:
	.long 0x0
	.align 3
.LC63:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC64:
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
	lis 9,.LC61@ha
	lis 10,.LC62@ha
	la 9,.LC61@l(9)
	la 10,.LC62@l(10)
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
	stw 0,116(1)
	addi 4,31,376
	mr 3,30
	stw 23,112(1)
	lfd 0,112(1)
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
	ori 11,11,16
	lis 9,gi@ha
	stw 0,252(31)
	la 24,gi@l(9)
	stw 10,248(31)
	lis 3,.LC57@ha
	stw 11,64(31)
	la 3,.LC57@l(3)
	stfs 30,196(31)
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
	stw 9,444(31)
	la 11,G_FreeEdict@l(11)
	lis 3,.LC58@ha
	lfs 13,level+4@l(8)
	la 3,.LC58@l(3)
	stw 11,436(31)
	stw 27,516(31)
	stw 26,520(31)
	stfs 31,524(31)
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 23,112(1)
	lfd 0,112(1)
	fsub 0,0,29
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
	lwz 9,36(24)
	mtlr 9
	blrl
	lis 9,.LC59@ha
	stw 3,76(31)
	la 9,.LC59@l(9)
	stw 9,280(31)
	lwz 0,84(25)
	cmpwi 0,0,0
	bc 12,2,.L120
	lis 9,skill@ha
	addi 29,31,4
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L121
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC60@ha
	stw 3,116(1)
	lis 10,.LC63@ha
	stw 23,112(1)
	la 10,.LC63@l(10)
	lfd 0,112(1)
	lfs 12,.LC60@l(11)
	lfd 11,0(10)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L120
.L121:
	lis 9,.LC64@ha
	addi 5,1,8
	la 9,.LC64@l(9)
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
	bc 12,2,.L120
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L120
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L120
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L120
	mr 4,25
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L120
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
	lwz 0,808(9)
	fsubs 1,1,0
	mtlr 0
	fdivs 1,1,28
	blrl
.L120:
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
.Lfe8:
	.size	 fire_rocket,.Lfe8-fire_rocket
	.section	".rodata"
	.align 2
.LC65:
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
	lis 9,.LC65@ha
	mr 26,5
	la 9,.LC65@l(9)
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
	bc 12,2,.L127
	lis 9,gi@ha
	li 21,0
	la 20,gi@l(9)
	li 22,11
.L128:
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
	bc 12,2,.L129
	li 25,1
	rlwinm 30,30,0,29,26
	b .L130
.L129:
	lwz 9,100(1)
	lwz 0,184(9)
	mr 3,9
	andi. 9,0,4
	bc 4,2,.L132
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L132
	lwz 0,248(3)
	cmpwi 0,0,2
	bc 4,2,.L131
.L132:
	mr 31,3
	b .L133
.L131:
	li 31,0
.L133:
	cmpw 0,3,29
	bc 12,2,.L130
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L130
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
.L130:
	lfs 0,60(1)
	cmpwi 0,31,0
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	bc 4,2,.L128
.L127:
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
	bc 12,2,.L136
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
.L136:
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L137
	mr 3,29
	mr 4,28
	li 5,2
	bl PlayerNoise
.L137:
	lwz 0,180(1)
	mtlr 0
	lmw 19,124(1)
	la 1,176(1)
	blr
.Lfe9:
	.size	 fire_rail,.Lfe9-fire_rail
	.section	".rodata"
	.align 3
.LC66:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC67:
	.long 0x3f000000
	.align 3
.LC68:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC69:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC70:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl bfg_explode
	.type	 bfg_explode,@function
bfg_explode:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 27,52(1)
	stw 0,84(1)
	mr 31,3
	lwz 0,56(31)
	cmpwi 0,0,0
	bc 4,2,.L139
	li 30,0
	addi 27,31,4
	b .L140
.L142:
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L140
	lwz 0,256(31)
	cmpw 0,30,0
	bc 12,2,.L140
	mr 3,30
	mr 4,31
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L140
	lwz 4,256(31)
	mr 3,30
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L140
	lfs 0,200(30)
	lis 9,.LC67@ha
	addi 4,1,16
	lfs 13,188(30)
	la 9,.LC67@l(9)
	addi 28,30,4
	lfs 1,0(9)
	mr 5,4
	mr 3,28
	fadds 13,13,0
	stfs 13,16(1)
	lfs 13,204(30)
	lfs 0,192(30)
	fadds 0,0,13
	stfs 0,20(1)
	lfs 0,208(30)
	lfs 13,196(30)
	fadds 13,13,0
	stfs 13,24(1)
	bl VectorMA
	lfs 0,4(31)
	addi 3,1,16
	lfs 13,8(31)
	lfs 12,12(31)
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
	lfs 13,524(31)
	lis 11,0x4330
	lwz 0,520(31)
	lis 10,.LC68@ha
	la 10,.LC68@l(10)
	fdivs 1,1,13
	xoris 0,0,0x8000
	lfd 0,0(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 31,40(1)
	fsub 31,31,0
	bl sqrt
	lis 9,.LC69@ha
	lwz 0,256(31)
	la 9,.LC69@l(9)
	lfd 0,0(9)
	cmpw 0,30,0
	fsub 0,0,1
	fmul 31,31,0
	frsp 31,31
	bc 4,2,.L147
	lis 10,.LC70@ha
	fmr 0,31
	la 10,.LC70@l(10)
	lfd 13,0(10)
	fmul 0,0,13
	frsp 31,0
.L147:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,20
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,1
	mtlr 0
	blrl
	fmr 13,31
	lwz 5,256(31)
	li 0,4
	li 11,14
	lis 8,vec3_origin@ha
	stw 0,8(1)
	stw 11,12(1)
	mr 7,28
	la 8,vec3_origin@l(8)
	fctiwz 0,13
	mr 3,30
	mr 4,31
	addi 6,31,376
	li 10,0
	stfd 0,40(1)
	lwz 9,44(1)
	bl T_Damage
.L140:
	lfs 1,524(31)
	mr 3,30
	mr 4,27
	bl findradius
	mr. 30,3
	bc 4,2,.L142
.L139:
	lis 11,level+4@ha
	lis 10,.LC66@ha
	lwz 9,56(31)
	lfs 0,level+4@l(11)
	lfd 13,.LC66@l(10)
	addi 9,9,1
	cmpwi 0,9,5
	stw 9,56(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L149
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
.L149:
	lwz 0,84(1)
	mtlr 0
	lmw 27,52(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe10:
	.size	 bfg_explode,.Lfe10-bfg_explode
	.section	".rodata"
	.align 2
.LC71:
	.string	"weapons/bfg__x1b.wav"
	.align 2
.LC73:
	.string	"sprites/s_bfg3.sp2"
	.align 2
.LC72:
	.long 0xbdcccccd
	.align 3
.LC74:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC75:
	.long 0x43480000
	.align 2
.LC76:
	.long 0x42c80000
	.align 2
.LC77:
	.long 0x0
	.align 2
.LC78:
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
	bc 12,2,.L150
	cmpwi 0,6,0
	bc 12,2,.L152
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L152
	bl G_FreeEdict
	b .L150
.L152:
	lwz 3,256(31)
	addi 30,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L153
	mr 4,30
	li 5,2
	bl PlayerNoise
.L153:
	lwz 0,512(27)
	addi 26,31,376
	cmpwi 0,0,0
	bc 12,2,.L154
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
.L154:
	lis 9,.LC75@ha
	lwz 4,256(31)
	li 6,13
	la 9,.LC75@l(9)
	mr 5,27
	lfs 1,0(9)
	mr 3,31
	li 28,0
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 2,0(9)
	bl T_RadiusDamage
	lis 29,gi@ha
	lis 3,.LC71@ha
	la 29,gi@l(29)
	la 3,.LC71@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC77@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC77@l(9)
	mr 3,31
	lfs 3,0(9)
	mtlr 11
	li 4,2
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 2,0(9)
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 1,0(9)
	blrl
	lis 9,.LC72@ha
	mr 4,26
	stw 28,248(31)
	lfs 1,.LC72@l(9)
	mr 5,30
	mr 3,30
	stw 28,444(31)
	bl VectorMA
	li 0,0
	lis 3,.LC73@ha
	stw 0,376(31)
	la 3,.LC73@l(3)
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
	lis 11,.LC74@ha
	rlwinm 0,0,0,19,17
	stw 28,76(31)
	li 3,3
	stw 0,64(31)
	stw 9,436(31)
	stw 28,56(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC74@l(11)
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
.L150:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 bfg_touch,.Lfe11-bfg_touch
	.section	".rodata"
	.align 2
.LC79:
	.string	"misc_explobox"
	.align 3
.LC80:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC81:
	.long 0x0
	.align 2
.LC82:
	.long 0x3f000000
	.align 2
.LC83:
	.long 0x45000000
	.align 2
.LC84:
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
	lis 11,.LC81@ha
	lis 9,deathmatch@ha
	la 11,.LC81@l(11)
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
	b .L158
.L173:
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
	b .L166
.L160:
	cmpw 0,26,31
	bc 12,2,.L158
	lwz 0,256(31)
	cmpw 0,26,0
	bc 12,2,.L158
	lwz 0,512(26)
	cmpwi 0,0,0
	bc 12,2,.L158
	lwz 0,184(26)
	andi. 9,0,4
	bc 4,2,.L164
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 4,2,.L164
	lwz 3,280(26)
	lis 4,.LC79@ha
	la 4,.LC79@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L158
.L164:
	lis 9,.LC82@ha
	addi 5,1,16
	la 9,.LC82@l(9)
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
	lis 9,.LC83@ha
	lfs 12,4(31)
	mr 3,27
	lfs 13,8(31)
	la 9,.LC83@l(9)
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
	b .L167
.L168:
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L169
	lwz 0,264(3)
	andi. 9,0,4
	bc 4,2,.L169
	lwz 5,256(31)
	cmpw 0,3,5
	bc 12,2,.L169
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
.L169:
	lwz 8,132(1)
	lwz 0,184(8)
	mr 9,8
	andi. 11,0,4
	bc 4,2,.L170
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L173
.L170:
	lfs 0,92(1)
	mr 30,8
	lfs 13,96(1)
	lfs 12,100(1)
	stfs 0,48(1)
	stfs 13,52(1)
	stfs 12,56(1)
.L167:
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
	bc 4,2,.L168
.L166:
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
.L158:
	lis 9,.LC84@ha
	mr 3,26
	la 9,.LC84@l(9)
	addi 4,31,4
	lfs 1,0(9)
	bl findradius
	mr. 26,3
	bc 4,2,.L160
	lis 9,level+4@ha
	lis 11,.LC80@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC80@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,196(1)
	mtlr 0
	lmw 23,156(1)
	la 1,192(1)
	blr
.Lfe12:
	.size	 bfg_think,.Lfe12-bfg_think
	.section	".rodata"
	.align 2
.LC85:
	.string	"sprites/s_bfg1.sp2"
	.align 2
.LC86:
	.string	"bfg blast"
	.align 2
.LC87:
	.string	"weapons/bfg__l1a.wav"
	.align 3
.LC88:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC89:
	.long 0x46fffe00
	.align 3
.LC90:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC91:
	.long 0x0
	.align 3
.LC92:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC93:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_bfg
	.type	 fire_bfg,@function
fire_bfg:
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
	lis 9,.LC90@ha
	lis 10,.LC91@ha
	la 9,.LC90@l(9)
	la 10,.LC91@l(10)
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
	lis 3,.LC85@ha
	stw 11,64(31)
	la 3,.LC85@l(3)
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
	lis 29,level@ha
	stw 26,256(31)
	la 9,bfg_touch@l(9)
	la 29,level@l(29)
	stw 9,444(31)
	lis 11,G_FreeEdict@ha
	lis 3,.LC87@ha
	lfs 13,4(29)
	lis 9,.LC86@ha
	la 11,G_FreeEdict@l(11)
	la 9,.LC86@l(9)
	stw 11,436(31)
	la 3,.LC87@l(3)
	stw 27,520(31)
	stfs 31,524(31)
	stw 9,280(31)
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
	lis 9,bfg_think@ha
	stw 3,76(31)
	lis 11,.LC88@ha
	la 9,bfg_think@l(9)
	lfd 13,.LC88@l(11)
	li 0,0
	stw 9,436(31)
	lfs 0,4(29)
	stw 0,560(31)
	stw 31,564(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L175
	lis 9,skill@ha
	addi 29,31,4
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L176
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC89@ha
	stw 3,108(1)
	lis 10,.LC92@ha
	stw 24,104(1)
	la 10,.LC92@l(10)
	lfd 0,104(1)
	lfs 12,.LC89@l(11)
	lfd 11,0(10)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L175
.L176:
	lis 9,.LC93@ha
	addi 5,1,8
	la 9,.LC93@l(9)
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
	bc 12,2,.L175
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L175
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L175
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L175
	mr 4,26
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L175
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
.L175:
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
.Lfe13:
	.size	 fire_bfg,.Lfe13-fire_bfg
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
.Lfe14:
	.size	 fire_bullet,.Lfe14-fire_bullet
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
.Lfe15:
	.size	 fire_shotgun,.Lfe15-fire_shotgun
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
	li 11,4
	mr 3,31
	lwz 5,256(30)
	mr 7,29
	mr 8,28
	andi. 9,0,1
	mr 4,30
	lwz 9,516(30)
	addi 6,30,376
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
	b .L63
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
	bc 4,2,.L64
	lwz 0,124(31)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L65
.L64:
	lwz 0,124(31)
	mr 3,28
	mtlr 0
	blrl
.L65:
	lis 9,gi+88@ha
	mr 3,29
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L63:
	mr 3,30
	bl G_FreeEdict
.L56:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 blaster_touch,.Lfe16-blaster_touch
	.section	".rodata"
	.align 2
.LC94:
	.long 0x46fffe00
	.align 3
.LC95:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC96:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC97:
	.long 0x3f800000
	.align 2
.LC98:
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
	lwz 0,256(31)
	cmpw 0,4,0
	bc 12,2,.L90
	cmpwi 0,6,0
	bc 12,2,.L92
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L92
	bl G_FreeEdict
	b .L90
.L92:
	lwz 0,512(4)
	cmpwi 0,0,0
	bc 4,2,.L93
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L94
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC95@ha
	lis 11,.LC94@ha
	la 10,.LC95@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC96@ha
	lfs 12,.LC94@l(11)
	la 10,.LC96@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L95
	lis 29,gi@ha
	lis 3,.LC30@ha
	la 29,gi@l(29)
	la 3,.LC30@l(3)
	b .L180
.L95:
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 29,gi@l(29)
	la 3,.LC31@l(3)
	b .L180
.L94:
	lis 29,gi@ha
	lis 3,.LC32@ha
	la 29,gi@l(29)
	la 3,.LC32@l(3)
.L180:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC97@ha
	lis 10,.LC97@ha
	lis 11,.LC98@ha
	mr 5,3
	la 9,.LC97@l(9)
	la 10,.LC97@l(10)
	mtlr 0
	la 11,.LC98@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L90
.L93:
	stw 4,540(31)
	mr 3,31
	bl Grenade_Explode
.L90:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 Grenade_Touch,.Lfe17-Grenade_Touch
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
