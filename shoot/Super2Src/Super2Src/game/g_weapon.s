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
	stwu 1,-256(1)
	mflr 0
	stfd 31,248(1)
	stmw 21,204(1)
	stw 0,260(1)
	mr 31,3
	mr 30,4
	lwz 9,540(31)
	addi 3,1,160
	mr 23,5
	lfs 0,4(31)
	mr 21,3
	mr 25,6
	lfs 13,4(9)
	mr 22,7
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
	mr 4,21
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
	addi 3,31,16
	mr 6,27
	mr 4,29
	mr 5,28
	bl AngleVectors
	fmr 1,31
	mr 3,24
	mr 4,29
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
	li 0,72
	lfs 0,144(1)
	add 10,25,10
	lis 8,vec3_origin@ha
	lfs 11,4(11)
	mr 9,23
	mr 6,21
	lfs 13,148(1)
	mr 7,26
	la 8,vec3_origin@l(8)
	lfs 12,152(1)
	srawi 10,10,1
	mr 4,31
	fsubs 0,0,11
	lwz 3,68(1)
	mr 5,31
	stfs 0,160(1)
	lfs 0,8(11)
	fsubs 13,13,0
	stfs 13,164(1)
	lfs 0,12(11)
	stw 0,8(1)
	stw 22,12(1)
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
	stw 11,196(1)
	lis 0,0x4330
	mr 4,29
	lis 11,.LC4@ha
	stw 0,192(1)
	addi 3,3,376
	la 11,.LC4@l(11)
	lfd 1,192(1)
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
	lwz 0,260(1)
	mtlr 0
	lmw 21,204(1)
	lfd 31,248(1)
	la 1,256(1)
	blr
.Lfe1:
	.size	 fire_hit,.Lfe1-fire_hit
	.section	".rodata"
	.align 2
.LC7:
	.string	"*brwater"
	.align 2
.LC8:
	.string	"sky"
	.align 3
.LC5:
	.long 0x3ffccccc
	.long 0xcccccccd
	.align 2
.LC6:
	.long 0x46fffe00
	.align 2
.LC9:
	.long 0x0
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC11:
	.long 0x40040000
	.long 0x0
	.align 3
.LC12:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC14:
	.long 0x46000000
	.align 2
.LC15:
	.long 0xc0000000
	.align 2
.LC16:
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
	mr 30,3
	lis 24,0x600
	lwz 11,84(30)
	mr 31,4
	mr 16,5
	mr 21,6
	stw 7,192(1)
	mr 20,9
	cmpwi 0,11,0
	stw 8,196(1)
	mr 19,10
	li 17,0
	ori 24,24,59
	bc 12,2,.L26
	lwz 0,1812(11)
	cmpwi 0,0,15
	bc 12,2,.L27
	lwz 0,1816(11)
	cmpwi 0,0,3
	bc 4,2,.L26
.L27:
	addi 3,30,376
	li 20,0
	bl VectorLength
	li 19,0
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L28
	xoris 11,21,0x8000
	stw 11,212(1)
	lis 0,0x4330
	lis 10,.LC10@ha
	stw 0,208(1)
	la 10,.LC10@l(10)
	lis 11,.LC11@ha
	lfd 0,208(1)
	la 11,.LC11@l(11)
	lfd 11,0(10)
	lfd 12,0(11)
	mr 11,9
	fsub 0,0,11
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,208(1)
	lwz 21,212(1)
	b .L26
.L28:
	xoris 11,21,0x8000
	stw 11,212(1)
	lis 0,0x4330
	lis 10,.LC10@ha
	la 10,.LC10@l(10)
	stw 0,208(1)
	lis 11,.LC5@ha
	lfd 11,0(10)
	lfd 0,208(1)
	mr 10,9
	lfd 13,.LC5@l(11)
	fsub 0,0,11
	fmul 0,0,13
	fctiwz 12,0
	stfd 12,208(1)
	lwz 21,212(1)
.L26:
	lis 11,gi@ha
	lis 9,0x600
	la 22,gi@l(11)
	ori 9,9,3
	lwz 11,48(22)
	addi 3,1,16
	addi 4,30,4
	li 5,0
	li 6,0
	mr 7,31
	mr 8,30
	mtlr 11
	blrl
	lfs 0,24(1)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L30
	addi 29,1,80
	mr 3,16
	mr 4,29
	lis 28,0x4330
	bl vectoangles
	mr 18,29
	addi 27,1,96
	addi 26,1,112
	addi 25,1,128
	mr 4,27
	mr 6,25
	mr 5,26
	mr 3,29
	mr 15,27
	bl AngleVectors
	mr 14,26
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfd 31,0(9)
	bl rand
	lis 9,.LC13@ha
	rlwinm 3,3,0,17,31
	la 9,.LC13@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 10,.LC6@ha
	xoris 0,20,0x8000
	lfs 29,.LC6@l(10)
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
	lis 10,.LC14@ha
	stw 28,208(1)
	la 10,.LC14@l(10)
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
	bc 12,2,.L31
	lfs 0,0(31)
	li 17,1
	rlwinm 24,24,0,29,25
	lfs 13,4(31)
	lfs 12,8(31)
	stfs 0,160(1)
	stfs 13,164(1)
	stfs 12,168(1)
.L31:
	lwz 0,48(22)
	mr 9,24
	addi 3,1,16
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	mr 7,23
	mr 8,30
	blrl
	lwz 0,64(1)
	andi. 9,0,56
	bc 12,2,.L30
	lfs 12,28(1)
	addi 0,1,28
	mr 3,31
	lfs 13,32(1)
	mr 4,0
	mr 26,0
	lfs 0,36(1)
	addi 27,1,160
	li 17,1
	stfs 12,160(1)
	stfs 13,164(1)
	stfs 0,168(1)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L33
	lwz 0,64(1)
	andi. 9,0,32
	bc 12,2,.L34
	lwz 3,60(1)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl strcmp
	addic 3,3,-1
	subfe 3,3,3
	rlwinm 3,3,0,30,31
	ori 28,3,2
	b .L37
.L34:
	andi. 9,0,16
	bc 12,2,.L38
	li 28,4
	b .L37
.L38:
	rlwinm 0,0,0,28,28
	neg 0,0
	srawi 0,0,31
	andi. 28,0,5
.L37:
	cmpwi 0,28,0
	bc 12,2,.L42
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
.L42:
	lfs 9,8(31)
	lis 9,.LC10@ha
	lis 10,.LC13@ha
	lfs 10,0(31)
	la 9,.LC10@l(9)
	la 10,.LC13@l(10)
	lfs 12,4(31)
	addi 28,1,160
	mr 3,18
	lfs 11,144(1)
	mr 4,18
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
	addi 6,1,128
	mr 4,15
	mr 5,14
	mr 3,18
	bl AngleVectors
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC6@ha
	stw 3,212(1)
	mr 11,9
	xoris 0,20,0x8000
	stw 29,208(1)
	lfd 13,208(1)
	lfs 29,.LC6@l(10)
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
	lis 10,.LC14@ha
	stw 29,208(1)
	la 10,.LC14@l(10)
	mr 4,15
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
	mr 4,14
	mr 3,23
	mr 5,23
	bl VectorMA
	fmr 1,31
	addi 4,1,128
	mr 3,23
	mr 5,23
	bl VectorMA
.L33:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 4,27
	mr 7,23
	addi 3,1,16
	li 5,0
	li 6,0
	mr 8,30
	mtlr 0
	ori 9,9,3
	blrl
.L30:
	lwz 3,60(1)
	cmpwi 0,3,0
	bc 12,2,.L44
	lwz 0,16(3)
	andi. 9,0,4
	bc 4,2,.L43
.L44:
	lfs 0,24(1)
	lis 10,.LC12@ha
	la 10,.LC12@l(10)
	lfd 13,0(10)
	fcmpu 0,0,13
	bc 4,0,.L43
	lwz 11,68(1)
	lwz 0,512(11)
	cmpwi 0,0,0
	bc 12,2,.L46
	li 9,16
	lwz 0,328(1)
	mr 4,30
	stw 9,8(1)
	mr 3,11
	mr 6,16
	lwz 10,192(1)
	mr 9,21
	mr 5,4
	stw 0,12(1)
	addi 7,1,28
	addi 8,1,40
	bl T_Damage
	b .L43
.L46:
	lis 4,.LC8@ha
	li 5,3
	la 4,.LC8@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L43
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,1,28
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,196(1)
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
	bc 12,2,.L43
	mr 3,30
	mr 4,28
	li 5,2
	bl PlayerNoise
.L43:
	cmpwi 0,17,0
	bc 12,2,.L50
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
	lis 9,.LC15@ha
	mr 5,29
	la 9,.LC15@l(9)
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
	bc 12,2,.L51
	lfs 0,176(1)
	addi 27,1,160
	lfs 13,180(1)
	lfs 12,184(1)
	stfs 0,28(1)
	stfs 13,32(1)
	stfs 12,36(1)
	b .L52
.L51:
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
.L52:
	lfs 11,28(1)
	lis 9,.LC16@ha
	mr 4,31
	lfs 12,160(1)
	la 9,.LC16@l(9)
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
	mr 3,27
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
.L50:
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
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC18:
	.long 0x42480000
	.section	".text"
	.align 2
	.globl blaster_touch
	.type	 blaster_touch,@function
blaster_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	lwz 0,256(31)
	mr 28,5
	cmpw 0,30,0
	bc 12,2,.L67
	cmpwi 0,6,0
	bc 12,2,.L69
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L69
	bl G_FreeEdict
	b .L67
.L69:
	lwz 3,256(31)
	addi 29,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L70
	mr 4,29
	li 5,2
	bl PlayerNoise
.L70:
	lwz 0,264(31)
	andis. 9,0,1
	bc 12,2,.L71
	lwz 0,520(31)
	lis 11,0x4330
	lis 10,.LC17@ha
	lwz 4,256(31)
	mr 3,31
	xoris 0,0,0x8000
	la 10,.LC17@l(10)
	stw 0,28(1)
	li 6,128
	mr 5,4
	stw 11,24(1)
	li 7,35
	lfd 0,0(10)
	lfd 1,24(1)
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfs 2,0(10)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
.L71:
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L72
	lwz 0,284(31)
	lwz 11,256(31)
	andi. 9,0,1
	mr 5,11
	lwz 11,84(11)
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	cmpwi 7,11,0
	nor 0,9,9
	rlwinm 9,9,0,31,31
	andi. 0,0,10
	or 10,9,0
	bc 12,30,.L75
	lwz 0,1808(11)
	cmpwi 0,0,-2
	bc 4,2,.L75
	lwz 9,516(31)
	li 0,256
	b .L80
.L75:
	lwz 9,516(31)
	li 0,4
.L80:
	mr 3,30
	stw 10,12(1)
	mr 7,29
	mr 8,28
	stw 0,8(1)
	mr 4,31
	addi 6,31,376
	li 10,1
	bl T_Damage
	b .L77
.L72:
	lis 9,gi@ha
	li 3,3
	la 30,gi@l(9)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,2
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,29
	mtlr 9
	blrl
	cmpwi 0,28,0
	bc 4,2,.L78
	lwz 0,124(30)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L79
.L78:
	lwz 0,124(30)
	mr 3,28
	mtlr 0
	blrl
.L79:
	lis 9,gi+88@ha
	mr 3,29
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L77:
	mr 3,31
	bl G_FreeEdict
.L67:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 blaster_touch,.Lfe3-blaster_touch
	.section	".rodata"
	.align 2
.LC19:
	.string	"bolt"
	.align 2
.LC20:
	.string	"models/objects/laser/tris.md2"
	.align 2
.LC21:
	.string	"misc/lasfly.wav"
	.align 2
.LC22:
	.long 0x46fffe00
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC24:
	.long 0x40000000
	.align 2
.LC25:
	.long 0x0
	.align 3
.LC26:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC27:
	.long 0x46000000
	.align 3
.LC28:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC29:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl fire_blaster
	.type	 fire_blaster,@function
fire_blaster:
	stwu 1,-208(1)
	mflr 0
	stmw 24,176(1)
	stw 0,212(1)
	mr 27,5
	mr 29,3
	mr 30,4
	mr 24,7
	mr 26,8
	mr 25,9
	mr 28,6
	mr 3,27
	bl VectorNormalize
	bl G_Spawn
	lfs 13,0(30)
	mr 31,3
	mr 3,27
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(30)
	stfs 0,8(31)
	lfs 13,8(30)
	stfs 13,12(31)
	lfs 0,0(30)
	stfs 0,28(31)
	lfs 13,4(30)
	stfs 13,32(31)
	lfs 0,8(30)
	stfs 0,36(31)
	bl vectoangles
	xoris 0,24,0x8000
	stw 0,172(1)
	lis 11,0x4330
	lis 10,.LC23@ha
	stw 11,168(1)
	la 10,.LC23@l(10)
	mr 3,27
	lfd 0,0(10)
	addi 4,31,376
	lfd 1,168(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lis 11,0x600
	lis 9,.LC19@ha
	li 0,0
	la 9,.LC19@l(9)
	li 8,8
	ori 11,11,3
	stw 9,280(31)
	li 10,2
	stw 8,260(31)
	stw 11,252(31)
	stw 10,248(31)
	stw 0,200(31)
	stw 0,196(31)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	lwz 9,84(29)
	cmpwi 0,9,0
	bc 12,2,.L83
	lwz 0,1812(9)
	cmpwi 0,0,13
	bc 12,2,.L82
.L83:
	lis 9,gi+32@ha
	lis 3,.LC20@ha
	lwz 0,gi+32@l(9)
	la 3,.LC20@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
.L82:
	lwz 9,84(29)
	cmpwi 0,9,0
	bc 12,2,.L84
	lwz 0,1808(9)
	cmpwi 0,0,-2
	bc 4,2,.L84
	bl rand
	lfs 0,0(30)
	lis 0,0x2aaa
	srawi 11,3,31
	lfs 13,376(31)
	ori 0,0,43691
	li 10,1
	lfs 11,380(31)
	mulhw 0,3,0
	li 8,3
	lfs 12,384(31)
	fadds 0,0,13
	srawi 0,0,1
	lwz 9,68(31)
	subf 0,11,0
	mulli 0,0,12
	ori 9,9,128
	stfs 0,28(31)
	lfs 0,4(30)
	subf. 0,0,3
	fadds 0,0,11
	stfs 0,32(31)
	lfs 13,8(30)
	stw 9,68(31)
	stw 10,40(31)
	fadds 13,13,12
	stw 8,56(31)
	stfs 13,36(31)
	bc 4,2,.L85
	lis 0,0xf2f2
	ori 0,0,61680
	stw 0,60(31)
	b .L108
.L85:
	cmpwi 0,0,1
	bc 12,2,.L117
	cmpwi 0,0,2
	bc 4,2,.L89
	lis 0,0xd0d1
	ori 0,0,53971
	stw 0,60(31)
	b .L108
.L89:
	cmpwi 0,0,3
	bc 4,2,.L91
.L117:
	lis 0,0xf3f3
	ori 0,0,61937
	stw 0,60(31)
	b .L108
.L91:
	cmpwi 0,0,4
	bc 4,2,.L93
	lis 0,0xdcdd
	ori 0,0,57055
	stw 0,60(31)
	b .L108
.L93:
	cmpwi 0,0,5
	bc 4,2,.L95
	lis 0,0xe0e1
	ori 0,0,58083
	stw 0,60(31)
	b .L108
.L95:
	cmpwi 0,0,6
	bc 4,2,.L97
	lis 0,0xe2e5
	ori 0,0,58342
	stw 0,60(31)
	b .L108
.L97:
	cmpwi 0,0,7
	bc 4,2,.L99
	lis 0,0xd0f1
	ori 0,0,54259
	stw 0,60(31)
	b .L108
.L99:
	cmpwi 0,0,8
	bc 4,2,.L101
	lis 0,0xf2f3
	ori 0,0,61681
	stw 0,60(31)
	b .L108
.L101:
	cmpwi 0,0,9
	bc 4,2,.L103
	lis 0,0xf3f2
	ori 0,0,61936
	stw 0,60(31)
	b .L108
.L103:
	cmpwi 0,0,10
	bc 4,2,.L105
	lis 0,0xdad0
	ori 0,0,56530
	stw 0,60(31)
	b .L108
.L105:
	cmpwi 0,0,11
	bc 4,2,.L108
	lis 0,0xd0da
	ori 0,0,53980
	stw 0,60(31)
	b .L108
.L84:
	lwz 0,64(31)
	or 0,0,26
	stw 0,64(31)
.L108:
	lis 9,gi+36@ha
	lis 3,.LC21@ha
	lwz 0,gi+36@l(9)
	la 3,.LC21@l(3)
	mtlr 0
	blrl
	lis 9,blaster_touch@ha
	lis 10,.LC24@ha
	stw 3,76(31)
	la 9,blaster_touch@l(9)
	lis 11,level+4@ha
	stw 29,256(31)
	stw 9,444(31)
	la 10,.LC24@l(10)
	cmpwi 0,25,0
	lfs 0,level+4@l(11)
	lis 9,G_FreeEdict@ha
	lfs 13,0(10)
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	stw 28,516(31)
	fadds 0,0,13
	stfs 0,428(31)
	bc 12,2,.L109
	li 0,1
	stw 0,284(31)
.L109:
	lwz 9,84(29)
	cmpwi 0,9,0
	bc 12,2,.L110
	lwz 0,1812(9)
	cmpwi 0,0,30
	bc 4,2,.L110
	lis 0,0x51eb
	lwz 9,264(31)
	srawi 11,28,31
	ori 0,0,34079
	mulhw 0,28,0
	oris 9,9,0x1
	stw 9,264(31)
	srawi 0,0,5
	subf 0,11,0
	mulli 9,0,100
	stw 0,520(31)
	subf 9,9,28
	stw 9,516(31)
.L110:
	lis 9,gi@ha
	mr 3,31
	la 28,gi@l(9)
	addi 30,31,4
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L111
	lis 9,.LC25@ha
	lis 11,skill@ha
	la 9,.LC25@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L112
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,172(1)
	lis 10,.LC23@ha
	lis 11,.LC22@ha
	la 10,.LC23@l(10)
	stw 0,168(1)
	lfd 13,0(10)
	lfd 0,168(1)
	lis 10,.LC26@ha
	lfs 12,.LC22@l(11)
	la 10,.LC26@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L111
.L112:
	lis 11,.LC27@ha
	addi 5,1,72
	la 11,.LC27@l(11)
	mr 3,30
	lfs 1,0(11)
	mr 4,27
	bl VectorMA
	lwz 0,48(28)
	lis 9,0x600
	addi 3,1,104
	mr 4,30
	li 5,0
	li 6,0
	addi 7,1,72
	mtlr 0
	mr 8,29
	ori 9,9,3
	blrl
	lwz 3,156(1)
	cmpwi 0,3,0
	bc 12,2,.L111
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L111
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L111
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L111
	mr 4,29
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L111
	lfs 13,4(31)
	addi 3,1,88
	lfs 0,116(1)
	lfs 12,120(1)
	lfs 11,124(1)
	fsubs 0,0,13
	stfs 0,88(1)
	lfs 13,4(30)
	fsubs 12,12,13
	stfs 12,92(1)
	lfs 0,8(30)
	fsubs 11,11,0
	stfs 11,96(1)
	bl VectorLength
	xoris 10,24,0x8000
	lwz 11,156(1)
	stw 10,172(1)
	lis 0,0x4330
	mr 4,29
	lis 10,.LC23@ha
	stw 0,168(1)
	mr 3,11
	la 10,.LC23@l(10)
	lfd 0,168(1)
	lfd 12,0(10)
	lfs 13,200(11)
	lwz 0,808(11)
	fsub 0,0,12
	fsubs 1,1,13
	mtlr 0
	frsp 0,0
	fdivs 1,1,0
	blrl
.L111:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	addi 4,29,4
	addi 3,1,8
	li 5,0
	li 6,0
	mr 7,30
	mtlr 0
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L116
	lis 10,.LC29@ha
	mr 3,30
	la 10,.LC29@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,27
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L116:
	lwz 0,212(1)
	mtlr 0
	lmw 24,176(1)
	la 1,208(1)
	blr
.Lfe4:
	.size	 fire_blaster,.Lfe4-fire_blaster
	.section	".rodata"
	.align 2
.LC30:
	.string	"weapons/xpld_wat.wav"
	.align 2
.LC32:
	.string	"powers/freezegren.wav"
	.align 2
.LC31:
	.long 0xbca3d70a
	.align 2
.LC33:
	.long 0x3f800000
	.align 2
.LC34:
	.long 0x0
	.align 2
.LC35:
	.long 0x40400000
	.align 3
.LC36:
	.long 0x3ff80000
	.long 0x0
	.section	".text"
	.align 2
	.globl Freeze_Explode
	.type	 Freeze_Explode,@function
Freeze_Explode:
	stwu 1,-80(1)
	mflr 0
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,32(1)
	stw 0,84(1)
	mr 31,3
	lwz 3,256(31)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L119
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L119:
	lis 9,gi@ha
	lis 3,.LC30@ha
	la 30,gi@l(9)
	la 3,.LC30@l(3)
	lwz 9,36(30)
	addi 29,31,4
	mr 26,29
	mtlr 9
	blrl
	lis 9,.LC33@ha
	lwz 11,16(30)
	mr 5,3
	la 9,.LC33@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 2,0(9)
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC31@ha
	mr 3,29
	lfs 1,.LC31@l(9)
	addi 4,31,376
	addi 5,1,8
	bl VectorMA
	lis 9,g_edicts@ha
	lwz 29,g_edicts@l(9)
	cmpwi 0,29,0
	bc 12,2,.L121
	lis 9,level@ha
	mr 28,30
	la 30,level@l(9)
	lis 11,.LC33@ha
	lis 9,.LC35@ha
	la 11,.LC33@l(11)
	la 9,.LC35@l(9)
	lfs 30,0(11)
	li 27,0
	lfs 29,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfd 31,0(9)
.L133:
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L132
	lwz 0,1808(9)
	cmpwi 0,0,12
	bc 4,2,.L125
	lfs 0,4(30)
	fadds 0,0,29
	b .L134
.L132:
	lwz 0,184(29)
	andi. 11,0,4
	bc 12,2,.L123
.L125:
	lwz 0,256(31)
	cmpw 0,29,0
	bc 4,2,.L127
	lfs 0,4(30)
	fadds 0,0,30
	b .L134
.L127:
	cmpwi 0,9,0
	bc 12,2,.L129
	lwz 0,1808(9)
	cmpwi 0,0,8
	bc 4,2,.L129
	stw 27,896(29)
	b .L126
.L129:
	lfs 0,4(30)
	fadd 0,0,31
	frsp 0,0
.L134:
	stfs 0,896(29)
.L126:
	lwz 9,36(28)
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
	mtlr 9
	blrl
	lis 9,.LC33@ha
	lwz 11,16(28)
	mr 5,3
	la 9,.LC33@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,29
	mtlr 11
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 2,0(9)
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 3,0(9)
	blrl
.L123:
	lfs 1,524(31)
	mr 3,29
	addi 4,1,8
	bl findradius
	mr. 29,3
	bc 4,2,.L133
.L121:
	mr 4,26
	mr 5,31
	li 3,2
	bl make_ball
	lwz 0,84(1)
	mtlr 0
	lmw 26,32(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe5:
	.size	 Freeze_Explode,.Lfe5-Freeze_Explode
	.section	".rodata"
	.align 2
.LC38:
	.string	"misc_teleporter_dest"
	.align 2
.LC39:
	.string	"info_player_deathmatch"
	.align 2
.LC40:
	.string	"item_flag_team1"
	.align 2
.LC41:
	.string	"item_flag_team2"
	.align 2
.LC42:
	.string	"powers/prox1.wav"
	.align 3
.LC37:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC43:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC44:
	.long 0x3f866666
	.align 2
.LC45:
	.long 0x3f800000
	.align 2
.LC46:
	.long 0x0
	.section	".text"
	.align 2
	.globl Prox_Think
	.type	 Prox_Think,@function
Prox_Think:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	li 4,0
	addi 3,1,8
	li 5,12
	crxor 6,6,6
	bl memset
	li 30,0
	lis 9,level+4@ha
	lis 11,.LC37@ha
	lfs 0,level+4@l(9)
	lis 10,g_edicts@ha
	lfd 13,.LC37@l(11)
	lwz 29,g_edicts@l(10)
	cmpwi 0,29,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L140
.L147:
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L144
	lwz 0,264(29)
	andi. 9,0,8192
	bc 4,2,.L144
	lwz 4,256(31)
	mr 3,29
	bl CTFSameTeam
	cmpwi 0,3,0
	bc 12,2,.L143
.L144:
	lwz 0,184(29)
	andi. 9,0,4
	bc 4,2,.L143
	lwz 3,280(29)
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L143
	lwz 3,280(29)
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L143
	lwz 3,280(29)
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L143
	lwz 3,280(29)
	lis 4,.LC41@ha
	la 4,.LC41@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L142
.L143:
	lfs 0,4(31)
	li 30,1
	lfs 13,4(29)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(29)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(29)
	fsubs 13,13,11
	stfs 13,16(1)
	b .L140
.L142:
	lfs 1,524(31)
	mr 3,29
	addi 4,31,4
	bl findradius
	mr. 29,3
	bc 4,2,.L147
.L140:
	lis 9,level@ha
	lfs 13,592(31)
	la 28,level@l(9)
	lfs 0,4(28)
	fcmpu 7,13,0
	mfcr 0
	rlwinm 0,0,29,1
	or. 9,0,30
	bc 12,2,.L146
	lwz 0,264(31)
	addi 5,1,8
	addi 4,31,4
	li 6,200
	li 3,9
	oris 0,0,0x1
	stw 0,264(31)
	bl SpawnDamage
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC45@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC45@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 2,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 3,0(9)
	blrl
	lis 9,Grenade_Explode@ha
	lis 11,.LC43@ha
	la 9,Grenade_Explode@l(9)
	lfd 13,.LC43@l(11)
	stw 9,436(31)
	lfs 0,4(28)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L138
.L146:
	lis 9,.LC44@ha
	addi 3,31,388
	lfs 1,.LC44@l(9)
	mr 4,3
	bl VectorScale
.L138:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Prox_Think,.Lfe6-Prox_Think
	.section	".rodata"
	.align 2
.LC47:
	.string	"world/spark1.wav"
	.align 2
.LC49:
	.long 0xbca3d70a
	.align 3
.LC50:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 Grenade_Explode,@function
Grenade_Explode:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,644(31)
	lwz 3,256(31)
	xori 0,0,2
	srawi 10,0,31
	lwz 11,84(3)
	xor 9,10,0
	subf 9,9,10
	cmpwi 7,11,0
	srawi 9,9,31
	nor 0,9,9
	rlwinm 9,9,0,29,30
	andi. 0,0,51
	or 29,9,0
	bc 12,30,.L153
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L153:
	lwz 0,516(31)
	lis 11,0x4330
	lis 10,.LC50@ha
	lfs 2,524(31)
	mr 7,29
	xoris 0,0,0x8000
	la 10,.LC50@l(10)
	lwz 4,256(31)
	stw 0,44(1)
	li 6,0
	mr 3,31
	stw 11,40(1)
	li 5,0
	addi 29,31,4
	lfd 1,40(1)
	mr 30,29
	lfd 0,0(10)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,.LC49@ha
	mr 3,29
	lfs 1,.LC49@l(9)
	addi 4,31,376
	addi 5,1,8
	bl VectorMA
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L154
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L155
	lwz 0,100(29)
	li 3,18
	b .L160
.L155:
	lwz 0,100(29)
	li 3,17
	b .L160
.L154:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L158
	lwz 0,100(29)
	li 3,8
.L160:
	mtlr 0
	blrl
	b .L157
.L158:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L157:
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 Grenade_Explode,.Lfe7-Grenade_Explode
	.section	".rodata"
	.align 2
.LC52:
	.string	"weapons/hgrenb1a.wav"
	.align 2
.LC53:
	.string	"weapons/hgrenb2a.wav"
	.align 2
.LC54:
	.string	"weapons/grenlb1b.wav"
	.align 2
.LC56:
	.string	"models/super2/prox/tris.md2"
	.align 2
.LC57:
	.string	"models/objects/grenade/tris.md2"
	.align 2
.LC58:
	.string	"grenade"
	.align 2
.LC55:
	.long 0x46fffe00
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC60:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC61:
	.long 0x40240000
	.long 0x0
	.align 3
.LC62:
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
	mr 29,7
	fmr 27,1
	mr 30,8
	addi 4,1,8
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
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC60@ha
	lfs 13,0(27)
	xoris 29,29,0x8000
	la 9,.LC60@l(9)
	mr 31,3
	lfd 29,0(9)
	lis 10,.LC61@ha
	addi 28,31,376
	stfs 13,4(31)
	la 10,.LC61@l(10)
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
	lis 11,.LC55@ha
	stw 3,92(1)
	lis 10,.LC62@ha
	mr 4,24
	stw 26,88(1)
	la 10,.LC62@l(10)
	mr 5,28
	lfd 0,88(1)
	mr 3,28
	lfs 30,.LC55@l(11)
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
	mr 4,23
	mr 5,3
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
	li 9,0
	lis 11,0x4396
	li 8,9
	stw 9,200(31)
	ori 0,0,3
	li 10,2
	stw 11,396(31)
	stw 8,260(31)
	stw 0,252(31)
	stw 10,248(31)
	stw 11,388(31)
	stw 11,392(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	lwz 9,84(22)
	cmpwi 0,9,0
	bc 12,2,.L171
	lwz 0,1812(9)
	cmpwi 0,0,13
	bc 12,2,.L170
.L171:
	cmpwi 0,30,2
	bc 4,2,.L172
	lis 9,gi+32@ha
	lis 3,.LC56@ha
	lwz 0,gi+32@l(9)
	la 3,.LC56@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
	stw 30,644(31)
	b .L170
.L172:
	lis 9,gi+32@ha
	lis 3,.LC57@ha
	lwz 0,gi+32@l(9)
	la 3,.LC57@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
.L170:
	lis 9,level@ha
	stw 22,256(31)
	cmpwi 0,30,0
	la 7,level@l(9)
	lfs 0,4(7)
	fadds 0,0,27
	stfs 0,428(31)
	bc 4,2,.L174
	lis 9,Grenade_Touch@ha
	lis 11,Grenade_Explode@ha
	la 9,Grenade_Touch@l(9)
	la 11,Grenade_Explode@l(11)
	b .L179
.L174:
	cmpwi 0,30,1
	bc 4,2,.L176
	lis 9,Freeze_Touch@ha
	lis 11,Freeze_Explode@ha
	la 9,Freeze_Touch@l(9)
	la 11,Freeze_Explode@l(11)
.L179:
	stw 9,444(31)
	stw 11,436(31)
	b .L175
.L176:
	cmpwi 0,30,2
	bc 4,2,.L175
	lis 9,Prox_Touch@ha
	lis 11,Prox_Think@ha
	la 9,Prox_Touch@l(9)
	la 11,Prox_Think@l(11)
	li 8,0
	stw 9,444(31)
	lis 10,BecomeExplosion1@ha
	stw 11,436(31)
	lis 0,0xc040
	lis 9,0x4040
	stw 8,428(31)
	la 10,BecomeExplosion1@l(10)
	li 11,100
	lfs 0,4(7)
	stw 0,196(31)
	stw 9,208(31)
	fadds 0,0,27
	stw 30,512(31)
	stw 11,480(31)
	stw 10,456(31)
	stfs 0,592(31)
	stw 0,188(31)
	stw 0,192(31)
	stw 9,200(31)
	stw 9,204(31)
.L175:
	lis 9,.LC58@ha
	stw 21,516(31)
	lis 11,gi+72@ha
	la 9,.LC58@l(9)
	stfs 26,524(31)
	mr 3,31
	stw 9,280(31)
	lwz 0,gi+72@l(11)
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
.Lfe8:
	.size	 fire_grenade,.Lfe8-fire_grenade
	.section	".rodata"
	.align 2
.LC64:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC65:
	.string	"hgrenade"
	.align 2
.LC66:
	.string	"weapons/hgrenc1b.wav"
	.align 2
.LC67:
	.string	"weapons/hgrent1a.wav"
	.align 2
.LC63:
	.long 0x46fffe00
	.align 3
.LC68:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC69:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC70:
	.long 0x40240000
	.long 0x0
	.align 3
.LC71:
	.long 0x40690000
	.long 0x0
	.align 3
.LC72:
	.long 0x0
	.long 0x0
	.align 2
.LC73:
	.long 0x3f800000
	.align 2
.LC74:
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
	mr 22,8
	addi 4,1,8
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
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfd 31,0(9)
	bl G_Spawn
	lis 9,.LC69@ha
	lfs 13,0(27)
	xoris 29,29,0x8000
	la 9,.LC69@l(9)
	mr 31,3
	lfd 29,0(9)
	lis 10,.LC70@ha
	addi 28,31,376
	stfs 13,4(31)
	la 10,.LC70@l(10)
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
	lis 11,.LC63@ha
	stw 3,92(1)
	lis 10,.LC71@ha
	mr 4,24
	stw 26,88(1)
	la 10,.LC71@l(10)
	mr 5,28
	lfd 0,88(1)
	mr 3,28
	lfs 30,.LC63@l(11)
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
	mr 4,23
	mr 5,3
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
	li 9,0
	lis 11,0x4396
	li 8,9
	stw 9,200(31)
	ori 0,0,3
	li 10,2
	stw 11,396(31)
	stw 8,260(31)
	stw 0,252(31)
	stw 10,248(31)
	stw 11,388(31)
	stw 11,392(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L182
	lwz 0,1812(9)
	cmpwi 0,0,13
	bc 12,2,.L181
.L182:
	lis 9,gi+32@ha
	lis 3,.LC64@ha
	lwz 0,gi+32@l(9)
	la 3,.LC64@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
.L181:
	lis 9,Grenade_Touch@ha
	stw 30,256(31)
	lis 10,level+4@ha
	la 9,Grenade_Touch@l(9)
	lis 11,Grenade_Explode@ha
	stw 9,444(31)
	cmpwi 0,22,0
	la 11,Grenade_Explode@l(11)
	lfs 0,level+4@l(10)
	lis 9,.LC65@ha
	la 9,.LC65@l(9)
	stw 11,436(31)
	stw 21,516(31)
	fadds 0,0,27
	stfs 26,524(31)
	stw 9,280(31)
	stfs 0,428(31)
	li 0,1
	bc 12,2,.L183
	li 0,3
.L183:
	stw 0,284(31)
	lis 9,gi@ha
	lis 3,.LC66@ha
	la 29,gi@l(9)
	la 3,.LC66@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC72@ha
	fmr 13,27
	stw 3,76(31)
	la 9,.LC72@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L185
	mr 3,31
	bl Grenade_Explode
	b .L186
.L185:
	lwz 9,36(29)
	lis 3,.LC67@ha
	la 3,.LC67@l(3)
	mtlr 9
	blrl
	lis 9,.LC73@ha
	lwz 11,16(29)
	lis 10,.LC74@ha
	la 9,.LC73@l(9)
	la 10,.LC74@l(10)
	lfs 2,0(9)
	mr 5,3
	mtlr 11
	li 4,1
	lis 9,.LC73@ha
	mr 3,30
	lfs 3,0(10)
	la 9,.LC73@l(9)
	lfs 1,0(9)
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
.L186:
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
.Lfe9:
	.size	 fire_grenade2,.Lfe9-fire_grenade2
	.section	".rodata"
	.align 2
.LC75:
	.string	"super shot"
	.align 2
.LC77:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC78:
	.string	"robo rocket"
	.align 2
.LC76:
	.long 0xbca3d70a
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC80:
	.long 0x0
	.align 2
.LC81:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl rocket_touch
	.type	 rocket_touch,@function
rocket_touch:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stmw 25,52(1)
	stw 0,84(1)
	stw 12,48(1)
	mr 31,3
	mr 27,4
	lwz 3,280(31)
	lis 29,.LC75@ha
	mr 25,5
	mr 30,6
	la 4,.LC75@l(29)
	bl strcmp
	srawi 9,3,31
	lwz 11,256(31)
	xor 0,9,3
	subf 0,0,9
	cmpw 7,27,11
	srawi 0,0,31
	nor 9,0,0
	rlwinm 0,0,0,28,28
	andi. 9,9,55
	or 26,0,9
	bc 12,30,.L188
	lwz 3,280(27)
	la 4,.LC75@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L188
	cmpwi 4,30,0
	bc 12,18,.L193
	lwz 0,16(30)
	andi. 9,0,4
	bc 12,2,.L193
	mr 3,31
	bl G_FreeEdict
	b .L188
.L193:
	lwz 3,256(31)
	addi 28,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L194
	mr 4,28
	li 5,2
	bl PlayerNoise
.L194:
	lis 9,.LC76@ha
	addi 29,31,376
	lfs 1,.LC76@l(9)
	mr 3,28
	mr 4,29
	addi 5,1,16
	bl VectorMA
	lwz 0,512(27)
	cmpwi 0,0,0
	bc 12,2,.L195
	lwz 9,516(31)
	cmpwi 0,9,0
	bc 12,2,.L212
	lwz 5,256(31)
	li 0,0
	li 11,8
	mr 6,29
	stw 0,8(1)
	mr 3,27
	stw 11,12(1)
	mr 4,31
	mr 7,28
	li 10,0
	mr 8,25
	bl T_Damage
	b .L198
.L195:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 12,2,.L212
	lis 9,deathmatch@ha
	lis 10,.LC80@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC80@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L198
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L198
	bc 12,18,.L198
	lwz 0,16(30)
	andi. 11,0,120
	bc 4,2,.L198
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
	bc 12,2,.L198
	lis 30,.LC77@ha
.L202:
	lis 9,.LC81@ha
	mr 3,31
	la 9,.LC81@l(9)
	la 4,.LC77@l(30)
	lfs 1,0(9)
	mr 5,28
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L202
.L198:
	lwz 0,520(31)
	lis 11,0x4330
	lis 10,.LC79@ha
	lfs 2,524(31)
	mr 5,27
	xoris 0,0,0x8000
	la 10,.LC79@l(10)
	lwz 4,256(31)
	stw 0,44(1)
	mr 7,26
	mr 3,31
	stw 11,40(1)
	li 6,0
	lfd 0,0(10)
	lfd 1,40(1)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	b .L196
.L212:
	lwz 0,520(31)
	lis 11,0x4330
	lis 10,.LC79@ha
	lfs 2,524(31)
	mr 7,26
	xoris 0,0,0x8000
	la 10,.LC79@l(10)
	lwz 4,256(31)
	stw 0,44(1)
	mr 3,31
	li 5,0
	stw 11,40(1)
	li 6,0
	lfd 0,0(10)
	lfd 1,40(1)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
.L196:
	lwz 3,280(31)
	lis 4,.LC78@ha
	la 4,.LC78@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L206
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,2
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	cmpwi 0,25,0
	bc 4,2,.L207
	lwz 0,124(29)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L208
.L207:
	lwz 0,124(29)
	mr 3,25
	mtlr 0
	blrl
.L208:
	lis 9,gi+88@ha
	mr 3,28
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
	b .L209
.L206:
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L210
	lwz 0,100(29)
	li 3,17
	mtlr 0
	blrl
	b .L211
.L210:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L211:
	lis 29,gi@ha
	addi 3,1,16
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
.L209:
	mr 3,31
	bl G_FreeEdict
.L188:
	lwz 0,84(1)
	lwz 12,48(1)
	mtlr 0
	lmw 25,52(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe10:
	.size	 rocket_touch,.Lfe10-rocket_touch
	.section	".rodata"
	.align 3
.LC82:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC83:
	.long 0x43480000
	.align 3
.LC84:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC85:
	.long 0xc0000000
	.section	".text"
	.align 2
	.globl robo_rocket_think
	.type	 robo_rocket_think,@function
robo_rocket_think:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 26,96(1)
	stw 0,132(1)
	mr 30,3
	lwz 0,412(30)
	cmpwi 0,0,0
	bc 4,2,.L223
	lis 9,g_edicts@ha
	addi 4,30,4
	lwz 3,g_edicts@l(9)
	mr 29,4
	addi 27,30,376
	lis 9,.LC83@ha
	addi 28,30,16
	la 9,.LC83@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 12,2,.L214
	lis 11,.LC84@ha
	lis 9,gi@ha
	la 11,.LC84@l(11)
	la 26,gi@l(9)
	lfd 31,0(11)
.L217:
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L218
	lwz 0,256(30)
	cmpw 0,31,0
	bc 12,2,.L218
	lwz 0,248(31)
	cmpwi 0,0,3
	bc 12,2,.L218
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L218
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L219
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L218
.L219:
	lwz 11,48(26)
	lis 9,0x600
	addi 3,1,8
	addi 4,31,4
	addi 5,30,188
	addi 6,30,200
	mr 7,29
	mtlr 11
	mr 8,30
	ori 9,9,3
	blrl
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 4,2,.L218
	stw 31,412(30)
	b .L214
.L218:
	lis 9,.LC83@ha
	mr 3,31
	la 9,.LC83@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L217
.L214:
	lwz 0,412(30)
	cmpwi 0,0,0
	bc 12,2,.L222
.L223:
	lwz 9,412(30)
	lis 11,.LC85@ha
	addi 0,30,376
	lfs 11,4(30)
	la 11,.LC85@l(11)
	mr 3,0
	lfs 0,4(9)
	addi 4,1,72
	mr 5,0
	lfs 13,8(30)
	mr 27,0
	addi 28,30,16
	lfs 12,12(30)
	fsubs 11,11,0
	lfs 1,0(11)
	stfs 11,72(1)
	lfs 0,8(9)
	fsubs 13,13,0
	stfs 13,76(1)
	lfs 0,12(9)
	fsubs 12,12,0
	stfs 12,80(1)
	bl VectorMA
.L222:
	mr 3,27
	mr 4,28
	bl vectoangles
	lis 9,level+4@ha
	lis 11,.LC82@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC82@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	lwz 0,132(1)
	mtlr 0
	lmw 26,96(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe11:
	.size	 robo_rocket_think,.Lfe11-robo_rocket_think
	.section	".rodata"
	.align 2
.LC88:
	.string	"rocket"
	.align 2
.LC89:
	.string	"models/objects/rocket/tris.md2"
	.align 2
.LC90:
	.string	"weapons/rockfly.wav"
	.align 3
.LC86:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC87:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC91:
	.long 0x46fffe00
	.align 2
.LC92:
	.long 0x3f800000
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
	.globl fire_rocket
	.type	 fire_rocket,@function
fire_rocket:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 25,124(1)
	stw 0,164(1)
	mr 28,5
	mr 29,4
	fmr 31,1
	mr 30,3
	mr 26,6
	mr 27,7
	mr 25,8
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,28
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(28)
	stfs 0,340(31)
	lfs 13,4(28)
	stfs 13,344(31)
	lfs 0,8(28)
	stfs 0,348(31)
	bl vectoangles
	lis 0,0x600
	li 9,8
	ori 0,0,3
	li 11,2
	stw 9,260(31)
	stw 0,252(31)
	stw 11,248(31)
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L225
	lwz 0,1808(9)
	cmpwi 0,0,-4
	bc 4,2,.L225
	lis 9,.LC92@ha
	lfs 13,592(30)
	la 9,.LC92@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L226
	lwz 0,68(31)
	ori 0,0,1024
	b .L236
.L226:
	lwz 0,68(31)
	ori 0,0,2048
.L236:
	stw 0,68(31)
	xoris 9,27,0x8000
	lwz 8,64(31)
	stw 9,116(1)
	lis 0,0x4330
	lis 10,robo_rocket_think@ha
	stw 0,112(1)
	lis 9,.LC78@ha
	ori 8,8,256
	lfd 12,112(1)
	la 9,.LC78@l(9)
	la 10,robo_rocket_think@l(10)
	lis 11,.LC93@ha
	stw 9,280(31)
	lis 7,level+4@ha
	la 11,.LC93@l(11)
	stw 8,64(31)
	lis 9,.LC87@ha
	lfd 0,0(11)
	lis 8,.LC86@ha
	stw 10,436(31)
	lfd 11,.LC87@l(9)
	fsub 12,12,0
	lfd 13,.LC86@l(8)
	lfs 0,level+4@l(7)
	fmul 12,12,11
	fctiwz 10,12
	fadd 0,0,13
	stfd 10,112(1)
	frsp 0,0
	lwz 27,116(1)
	stfs 0,428(31)
	b .L228
.L225:
	li 10,8000
	lwz 0,64(31)
	divw 10,10,27
	lis 6,0x4330
	lis 9,.LC93@ha
	la 9,.LC93@l(9)
	lis 11,.LC88@ha
	lfd 12,0(9)
	ori 0,0,16
	la 11,.LC88@l(11)
	stw 0,64(31)
	lis 8,level+4@ha
	lis 9,G_FreeEdict@ha
	stw 11,280(31)
	la 9,G_FreeEdict@l(9)
	lfs 13,level+4@l(8)
	stw 9,436(31)
	xoris 10,10,0x8000
	stw 10,116(1)
	stw 6,112(1)
	lfd 0,112(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
.L228:
	xoris 0,27,0x8000
	stw 0,116(1)
	lis 11,0x4330
	lis 10,.LC93@ha
	stw 11,112(1)
	la 10,.LC93@l(10)
	mr 3,28
	lfd 1,112(1)
	addi 4,31,376
	lfd 0,0(10)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	li 0,0
	stw 0,200(31)
	stw 0,196(31)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L230
	lwz 0,1812(9)
	cmpwi 0,0,13
	bc 12,2,.L229
.L230:
	lis 9,gi+32@ha
	lis 3,.LC89@ha
	lwz 0,gi+32@l(9)
	la 3,.LC89@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
.L229:
	lis 9,rocket_touch@ha
	stw 26,516(31)
	lis 11,gi@ha
	la 9,rocket_touch@l(9)
	la 26,gi@l(11)
	stw 25,520(31)
	stw 9,444(31)
	lis 3,.LC90@ha
	stfs 31,524(31)
	la 3,.LC90@l(3)
	stw 30,256(31)
	lwz 9,36(26)
	mtlr 9
	blrl
	stw 3,76(31)
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L231
	lis 9,skill@ha
	lis 10,.LC94@ha
	lwz 11,skill@l(9)
	la 10,.LC94@l(10)
	addi 29,31,4
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L232
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,116(1)
	lis 10,.LC93@ha
	lis 11,.LC91@ha
	la 10,.LC93@l(10)
	stw 0,112(1)
	lfd 13,0(10)
	lfd 0,112(1)
	lis 10,.LC95@ha
	lfs 12,.LC91@l(11)
	la 10,.LC95@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L231
.L232:
	lis 11,.LC96@ha
	addi 5,1,8
	la 11,.LC96@l(11)
	mr 4,28
	lfs 1,0(11)
	mr 3,29
	bl VectorMA
	lwz 0,48(26)
	lis 9,0x600
	addi 3,1,40
	mr 4,29
	li 5,0
	li 6,0
	addi 7,1,8
	mtlr 0
	mr 8,30
	ori 9,9,3
	blrl
	lwz 3,92(1)
	cmpwi 0,3,0
	bc 12,2,.L231
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L231
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L231
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L231
	mr 4,30
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L231
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
	xoris 10,27,0x8000
	lwz 11,92(1)
	stw 10,116(1)
	lis 0,0x4330
	mr 4,30
	lis 10,.LC93@ha
	stw 0,112(1)
	mr 3,11
	la 10,.LC93@l(10)
	lfd 0,112(1)
	lfd 12,0(10)
	lfs 13,200(11)
	lwz 0,808(11)
	fsub 0,0,12
	fsubs 1,1,13
	mtlr 0
	frsp 0,0
	fdivs 1,1,0
	blrl
.L231:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,164(1)
	mtlr 0
	lmw 25,124(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe12:
	.size	 fire_rocket,.Lfe12-fire_rocket
	.section	".rodata"
	.align 2
.LC97:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_rail
	.type	 fire_rail,@function
fire_rail:
	stwu 1,-160(1)
	mflr 0
	stmw 20,112(1)
	stw 0,164(1)
	lis 9,.LC97@ha
	mr 27,5
	la 9,.LC97@l(9)
	mr 30,4
	lfs 1,0(9)
	mr 31,3
	addi 5,1,32
	mr 20,5
	mr 24,6
	mr 25,7
	mr 3,30
	mr 4,27
	lis 28,0x600
	bl VectorMA
	mr 29,31
	li 26,0
	lfs 12,0(30)
	cmpwi 0,31,0
	ori 28,28,27
	lfs 0,4(30)
	lfs 13,8(30)
	stfs 12,16(1)
	stfs 0,20(1)
	stfs 13,24(1)
	bc 12,2,.L239
	lis 9,gi@ha
	li 21,0
	la 22,gi@l(9)
	li 23,11
.L240:
	lwz 11,48(22)
	mr 9,28
	addi 3,1,48
	addi 4,1,16
	li 5,0
	li 6,0
	mr 7,20
	mtlr 11
	mr 8,29
	blrl
	lwz 0,96(1)
	andi. 9,0,24
	bc 12,2,.L241
	li 26,1
	rlwinm 28,28,0,29,26
	b .L242
.L241:
	lwz 9,100(1)
	lwz 0,184(9)
	mr 3,9
	andi. 9,0,4
	bc 4,2,.L244
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L243
.L244:
	mr 29,3
	b .L245
.L243:
	li 29,0
.L245:
	cmpw 0,3,31
	bc 12,2,.L242
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L242
	stw 21,8(1)
	mr 4,31
	mr 5,31
	stw 23,12(1)
	mr 6,27
	addi 7,1,60
	addi 8,1,72
	mr 9,24
	mr 10,25
	bl T_Damage
.L242:
	lfs 0,60(1)
	cmpwi 0,29,0
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	bc 4,2,.L240
.L239:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L249
	lwz 0,1812(9)
	cmpwi 0,0,13
	bc 12,2,.L248
.L249:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,1,60
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,1
	mtlr 0
	blrl
.L248:
	cmpwi 0,26,0
	bc 12,2,.L250
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,1,60
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
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
.L250:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L251
	mr 3,31
	addi 4,1,60
	li 5,2
	bl PlayerNoise
.L251:
	lwz 0,164(1)
	mtlr 0
	lmw 20,112(1)
	la 1,160(1)
	blr
.Lfe13:
	.size	 fire_rail,.Lfe13-fire_rail
	.section	".rodata"
	.align 3
.LC98:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC99:
	.long 0x3f000000
	.align 3
.LC100:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC101:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC102:
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
	bc 4,2,.L253
	li 30,0
	addi 27,31,4
	b .L254
.L256:
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L254
	lwz 0,256(31)
	cmpw 0,30,0
	bc 12,2,.L254
	mr 3,30
	mr 4,31
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L254
	lwz 4,256(31)
	mr 3,30
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L254
	lfs 0,200(30)
	lis 9,.LC99@ha
	addi 4,1,16
	lfs 13,188(30)
	la 9,.LC99@l(9)
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
	lis 10,.LC100@ha
	la 10,.LC100@l(10)
	fdivs 1,1,13
	xoris 0,0,0x8000
	lfd 0,0(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 31,40(1)
	fsub 31,31,0
	bl sqrt
	lis 9,.LC101@ha
	lwz 0,256(31)
	la 9,.LC101@l(9)
	lfd 0,0(9)
	cmpw 0,30,0
	fsub 0,0,1
	fmul 31,31,0
	frsp 31,31
	bc 4,2,.L261
	lis 10,.LC102@ha
	fmr 0,31
	la 10,.LC102@l(10)
	lfd 13,0(10)
	fmul 0,0,13
	frsp 31,0
.L261:
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
	li 4,2
	mtlr 0
	blrl
	fmr 13,31
	lwz 5,256(31)
	li 0,4
	li 11,13
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
.L254:
	lfs 1,524(31)
	mr 3,30
	mr 4,27
	bl findradius
	mr. 30,3
	bc 4,2,.L256
.L253:
	lis 11,level+4@ha
	lis 10,.LC98@ha
	lwz 9,56(31)
	lfs 0,level+4@l(11)
	lfd 13,.LC98@l(10)
	addi 9,9,1
	cmpwi 0,9,5
	stw 9,56(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L263
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
.L263:
	lwz 0,84(1)
	mtlr 0
	lmw 27,52(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe14:
	.size	 bfg_explode,.Lfe14-bfg_explode
	.section	".rodata"
	.align 2
.LC103:
	.string	"weapons/bfg__x1b.wav"
	.align 2
.LC105:
	.string	"sprites/s_bfg3.sp2"
	.align 2
.LC104:
	.long 0xbdcccccd
	.align 3
.LC106:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC107:
	.long 0x43480000
	.align 2
.LC108:
	.long 0x42c80000
	.align 2
.LC109:
	.long 0x0
	.align 2
.LC110:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl bfg_touch
	.type	 bfg_touch,@function
bfg_touch:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 26,24(1)
	stw 0,52(1)
	stw 12,20(1)
	mr 31,3
	mr 28,4
	lwz 0,256(31)
	mr 26,5
	mr 30,6
	cmpw 0,28,0
	bc 12,2,.L264
	lwz 29,560(31)
	cmpwi 4,30,0
	cmpwi 0,29,0
	bc 12,2,.L267
.L269:
	mr 3,29
	lwz 29,560(29)
	bl G_FreeEdict
	mr. 29,29
	bc 4,2,.L269
.L267:
	bc 12,18,.L271
	lwz 0,16(30)
	andi. 9,0,4
	bc 12,2,.L271
	mr 3,31
	bl G_FreeEdict
	b .L264
.L271:
	lwz 3,256(31)
	addi 30,31,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L272
	mr 4,30
	li 5,2
	bl PlayerNoise
.L272:
	lwz 0,512(28)
	addi 27,31,376
	cmpwi 0,0,0
	bc 12,2,.L273
	lwz 5,256(31)
	li 9,13
	li 0,0
	stw 9,12(1)
	mr 8,26
	mr 3,28
	stw 0,8(1)
	mr 4,31
	mr 6,27
	mr 7,30
	li 9,200
	li 10,0
	bl T_Damage
.L273:
	lis 9,.LC107@ha
	lwz 4,256(31)
	li 6,0
	la 9,.LC107@l(9)
	li 7,13
	lfs 1,0(9)
	mr 5,28
	mr 3,31
	lis 9,.LC108@ha
	la 9,.LC108@l(9)
	lfs 2,0(9)
	bl T_RadiusDamage
	lis 9,gi@ha
	lis 3,.LC103@ha
	la 29,gi@l(9)
	la 3,.LC103@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC109@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC109@l(9)
	mr 3,31
	lfs 3,0(9)
	li 4,2
	mtlr 11
	lis 9,.LC110@ha
	la 9,.LC110@l(9)
	lfs 1,0(9)
	lis 9,.LC110@ha
	la 9,.LC110@l(9)
	lfs 2,0(9)
	blrl
	lis 9,.LC104@ha
	li 0,0
	lfs 1,.LC104@l(9)
	mr 4,27
	mr 3,30
	stw 0,444(31)
	mr 5,30
	stw 0,248(31)
	bl VectorMA
	lwz 9,84(31)
	li 0,0
	stw 0,376(31)
	cmpwi 0,9,0
	stw 0,384(31)
	stw 0,380(31)
	bc 12,2,.L275
	lwz 0,1812(9)
	cmpwi 0,0,13
	bc 12,2,.L274
.L275:
	lwz 0,32(29)
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
.L274:
	lwz 0,64(31)
	lis 9,bfg_explode@ha
	li 11,0
	la 9,bfg_explode@l(9)
	stw 11,76(31)
	lis 8,level+4@ha
	rlwinm 0,0,0,19,17
	stw 11,56(31)
	lis 10,.LC106@ha
	stw 0,64(31)
	lis 29,gi@ha
	li 3,3
	stw 9,436(31)
	la 29,gi@l(29)
	lfs 0,level+4@l(8)
	lfd 13,.LC106@l(10)
	stw 28,540(31)
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
.L264:
	lwz 0,52(1)
	lwz 12,20(1)
	mtlr 0
	lmw 26,24(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe15:
	.size	 bfg_touch,.Lfe15-bfg_touch
	.section	".rodata"
	.align 2
.LC112:
	.string	"sprites/s_bfg1.sp2"
	.align 2
.LC113:
	.string	"bfg blast"
	.align 2
.LC114:
	.string	"weapons/bfg__l1a.wav"
	.align 3
.LC115:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC116:
	.long 0x46fffe00
	.align 3
.LC117:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC118:
	.long 0x0
	.align 3
.LC119:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC120:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl fire_bfg
	.type	 fire_bfg,@function
fire_bfg:
	stwu 1,-160(1)
	mflr 0
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 24,112(1)
	stw 0,164(1)
	mr 30,5
	mr 29,4
	fmr 30,1
	mr 27,7
	mr 25,6
	mr 28,3
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,30
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
	xoris 0,27,0x8000
	stw 0,108(1)
	lis 11,0x4330
	lis 10,.LC117@ha
	stw 11,104(1)
	la 10,.LC117@l(10)
	mr 3,30
	lfd 0,0(10)
	addi 4,31,376
	lfd 1,104(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	li 9,0
	li 8,8
	ori 0,0,3
	stw 9,200(31)
	ori 11,11,8320
	li 10,2
	stw 8,260(31)
	stw 0,252(31)
	stw 10,248(31)
	stw 11,64(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	lwz 9,84(28)
	cmpwi 0,9,0
	bc 12,2,.L285
	lwz 0,1812(9)
	cmpwi 0,0,13
	bc 12,2,.L284
.L285:
	lis 9,gi+32@ha
	lis 3,.LC112@ha
	lwz 0,gi+32@l(9)
	la 3,.LC112@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
.L284:
	li 0,8000
	stw 28,256(31)
	divw 0,0,27
	lis 26,0x4330
	lis 9,.LC117@ha
	la 9,.LC117@l(9)
	lis 29,level@ha
	lfd 31,0(9)
	la 29,level@l(29)
	lis 11,G_FreeEdict@ha
	lis 9,bfg_touch@ha
	la 11,G_FreeEdict@l(11)
	la 9,bfg_touch@l(9)
	lis 10,gi@ha
	stw 9,444(31)
	la 24,gi@l(10)
	lis 3,.LC114@ha
	lfs 13,4(29)
	lis 9,.LC113@ha
	la 3,.LC114@l(3)
	la 9,.LC113@l(9)
	stw 11,436(31)
	stw 25,520(31)
	stfs 30,524(31)
	stw 9,280(31)
	xoris 0,0,0x8000
	stw 0,108(1)
	stw 26,104(1)
	lfd 0,104(1)
	fsub 0,0,31
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
	lwz 9,36(24)
	mtlr 9
	blrl
	lis 9,bfg_think@ha
	stw 3,76(31)
	lis 11,.LC115@ha
	la 9,bfg_think@l(9)
	lfd 13,.LC115@l(11)
	li 0,0
	stw 9,436(31)
	lfs 0,4(29)
	stw 0,560(31)
	stw 31,564(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L286
	lis 9,skill@ha
	lis 10,.LC118@ha
	lwz 11,skill@l(9)
	la 10,.LC118@l(10)
	addi 29,31,4
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L287
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC116@ha
	stw 3,108(1)
	lis 10,.LC119@ha
	stw 26,104(1)
	la 10,.LC119@l(10)
	lfd 0,104(1)
	lfs 12,.LC116@l(11)
	lfd 11,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L286
.L287:
	lis 11,.LC120@ha
	addi 5,1,8
	la 11,.LC120@l(11)
	mr 4,30
	lfs 1,0(11)
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
	mr 8,28
	ori 9,9,3
	blrl
	lwz 3,92(1)
	cmpwi 0,3,0
	bc 12,2,.L286
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L286
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L286
	lwz 0,808(3)
	cmpwi 0,0,0
	bc 12,2,.L286
	mr 4,28
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L286
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
	xoris 0,27,0x8000
	lwz 11,92(1)
	stw 0,108(1)
	mr 4,28
	stw 26,104(1)
	mr 3,11
	lfd 0,104(1)
	lfs 13,200(11)
	lwz 0,808(11)
	fsub 0,0,31
	fsubs 1,1,13
	mtlr 0
	frsp 0,0
	fdivs 1,1,0
	blrl
.L286:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,164(1)
	mtlr 0
	lmw 24,112(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe16:
	.size	 fire_bfg,.Lfe16-fire_bfg
	.comm	v_forward,12,4
	.comm	v_right,12,4
	.comm	v_up,12,4
	.comm	invis_index,4,4
	.comm	cripple_index,4,4
	.comm	robot_index,4,4
	.comm	sun_index,4,4
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
.Lfe17:
	.size	 fire_bullet,.Lfe17-fire_bullet
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
	bc 4,1,.L63
	mfctr 31
.L65:
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
	bc 4,2,.L65
.L63:
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe18:
	.size	 fire_shotgun,.Lfe18-fire_shotgun
	.align 2
	.globl fire_fastbop
	.type	 fire_fastbop,@function
fire_fastbop:
	stwu 1,-64(1)
	mflr 0
	stmw 22,24(1)
	stw 0,68(1)
	mr. 0,10
	mr 24,3
	lwz 22,72(1)
	mr 25,4
	mr 26,5
	lwz 23,76(1)
	mr 27,6
	mr 28,7
	mtctr 0
	mr 29,8
	mr 30,9
	bc 4,1,.L56
	mfctr 31
.L58:
	stw 22,8(1)
	mr 3,24
	mr 4,25
	mr 5,26
	mr 6,27
	mr 7,28
	mr 8,23
	mr 9,29
	mr 10,30
	bl fire_lead
	addic. 31,31,-1
	bc 4,2,.L58
.L56:
	lwz 0,68(1)
	mtlr 0
	lmw 22,24(1)
	la 1,64(1)
	blr
.Lfe19:
	.size	 fire_fastbop,.Lfe19-fire_fastbop
	.section	".rodata"
	.align 2
.LC121:
	.long 0x44fa0000
	.section	".text"
	.align 2
	.globl fire_explobop
	.type	 fire_explobop,@function
fire_explobop:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	lis 9,.LC121@ha
	mr 28,4
	la 9,.LC121@l(9)
	addi 29,1,72
	lfs 1,0(9)
	mr 27,3
	mr 4,5
	mr 26,6
	mr 25,7
	mr 3,28
	mr 5,29
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 4,28
	addi 3,1,8
	li 5,0
	li 6,0
	mr 7,29
	mr 8,27
	mtlr 0
	ori 9,9,3
	blrl
	mr 3,27
	mr 5,26
	mr 6,25
	addi 4,1,20
	bl blast_fire
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe20:
	.size	 fire_explobop,.Lfe20-fire_explobop
	.align 2
	.globl Freeze_Touch
	.type	 Freeze_Touch,@function
Freeze_Touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 12,2,.L135
	cmpwi 0,6,0
	bc 12,2,.L137
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L137
	bl G_FreeEdict
	b .L135
.L137:
	bl Freeze_Explode
.L135:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 Freeze_Touch,.Lfe21-Freeze_Touch
	.section	".rodata"
	.align 3
.LC122:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC123:
	.long 0x3f800000
	.align 2
.LC124:
	.long 0x0
	.section	".text"
	.align 2
	.globl Prox_Touch
	.type	 Prox_Touch,@function
Prox_Touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,256(31)
	cmpw 0,4,0
	bc 12,2,.L148
	cmpwi 0,6,0
	bc 12,2,.L150
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L150
	bl G_FreeEdict
	b .L148
.L150:
	lwz 9,256(31)
	lis 29,gi@ha
	lis 3,.LC47@ha
	lfs 0,4(31)
	la 29,gi@l(29)
	la 3,.LC47@l(3)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	lwz 11,36(29)
	mtlr 11
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	blrl
	lis 9,.LC123@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC123@l(9)
	mr 3,31
	lfs 1,0(9)
	mtlr 11
	li 4,0
	lis 9,.LC123@ha
	la 9,.LC123@l(9)
	lfs 2,0(9)
	lis 9,.LC124@ha
	la 9,.LC124@l(9)
	lfs 3,0(9)
	blrl
	li 3,9
	li 6,200
	addi 4,31,4
	addi 5,1,8
	bl SpawnDamage
	lis 9,Prox_Think@ha
	lis 11,level+4@ha
	la 9,Prox_Think@l(9)
	lis 10,.LC122@ha
	stw 9,436(31)
	li 0,0
	mr 3,31
	lfs 0,level+4@l(11)
	li 9,6
	lfd 13,.LC122@l(10)
	stw 0,376(31)
	stw 9,260(31)
	stw 0,384(31)
	stw 0,380(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L148:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 Prox_Touch,.Lfe22-Prox_Touch
	.section	".rodata"
	.align 2
.LC125:
	.long 0x46fffe00
	.align 3
.LC126:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC127:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC128:
	.long 0x3f800000
	.align 2
.LC129:
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
	bc 12,2,.L161
	cmpwi 0,6,0
	bc 12,2,.L163
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L163
	bl G_FreeEdict
	b .L161
.L163:
	lwz 0,512(4)
	cmpwi 0,0,0
	bc 4,2,.L164
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L165
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC126@ha
	lis 11,.LC125@ha
	la 10,.LC126@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC127@ha
	lfs 12,.LC125@l(11)
	la 10,.LC127@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L166
	lis 29,gi@ha
	lis 3,.LC52@ha
	la 29,gi@l(29)
	la 3,.LC52@l(3)
	b .L291
.L166:
	lis 29,gi@ha
	lis 3,.LC53@ha
	la 29,gi@l(29)
	la 3,.LC53@l(3)
	b .L291
.L165:
	lis 29,gi@ha
	lis 3,.LC54@ha
	la 29,gi@l(29)
	la 3,.LC54@l(3)
.L291:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC128@ha
	lis 10,.LC128@ha
	lis 11,.LC129@ha
	mr 5,3
	la 9,.LC128@l(9)
	la 10,.LC128@l(10)
	mtlr 0
	la 11,.LC129@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L161
.L164:
	mr 3,31
	bl Grenade_Explode
.L161:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 Grenade_Touch,.Lfe23-Grenade_Touch
	.section	".rodata"
	.align 3
.LC130:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC131:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl bfg_think
	.type	 bfg_think,@function
bfg_think:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 30,3
	li 0,0
	lwz 31,560(30)
	stw 0,560(30)
	cmpwi 0,31,0
	bc 12,2,.L278
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	lfs 31,0(9)
.L279:
	lwz 9,540(31)
	addi 3,1,8
	lfs 13,4(30)
	lfs 0,4(9)
	lfs 12,8(30)
	lwz 29,560(31)
	fsubs 0,0,13
	lfs 13,12(30)
	stfs 0,8(1)
	lwz 9,540(31)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lwz 9,540(31)
	lfs 0,12(9)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	cror 3,2,0
	bc 4,3,.L280
	lwz 0,560(30)
	stw 0,560(31)
	stw 31,560(30)
	b .L281
.L280:
	mr 3,31
	bl G_FreeEdict
.L281:
	mr. 31,29
	bc 4,2,.L279
.L278:
	lis 9,level+4@ha
	lis 11,.LC130@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC130@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 bfg_think,.Lfe24-bfg_think
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
