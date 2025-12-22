	.file	"m_move.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x3f800000
	.align 3
.LC1:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC2:
	.long 0x42100000
	.align 3
.LC3:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC4:
	.long 0x41900000
	.section	".text"
	.align 2
	.globl M_CheckBottom
	.type	 M_CheckBottom,@function
M_CheckBottom:
	stwu 1,-208(1)
	mflr 0
	mfcr 12
	stfd 28,176(1)
	stfd 29,184(1)
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 24,144(1)
	stw 0,212(1)
	stw 12,140(1)
	mr 29,3
	lis 9,.LC0@ha
	lfs 7,12(29)
	la 9,.LC0@l(9)
	li 30,0
	lfs 9,196(29)
	lis 26,gi@ha
	addi 27,1,40
	lfs 12,4(29)
	lfs 11,8(29)
	lfs 13,188(29)
	fadds 9,7,9
	lfs 0,204(29)
	lfs 5,192(29)
	lfs 6,200(29)
	fadds 13,12,13
	lfs 10,208(29)
	fadds 0,11,0
	lfs 8,0(9)
	fadds 11,11,5
	fadds 12,12,6
	stfs 13,8(1)
	fadds 7,7,10
	stfs 0,28(1)
	fsubs 8,9,8
	stfs 11,12(1)
	stfs 12,24(1)
	stfs 7,32(1)
	stfs 8,48(1)
	stfs 9,16(1)
.L10:
	cmpwi 4,30,0
	li 31,0
.L14:
	bc 12,18,.L15
	lfs 0,24(1)
	b .L16
.L15:
	lfs 0,8(1)
.L16:
	cmpwi 0,31,0
	stfs 0,40(1)
	bc 12,2,.L17
	lfs 0,28(1)
	b .L18
.L17:
	lfs 0,12(1)
.L18:
	la 28,gi@l(26)
	mr 3,27
	stfs 0,44(1)
	lwz 9,52(28)
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 4,2,.L20
	addi 31,31,1
	cmpwi 0,31,1
	bc 4,1,.L14
	addi 30,30,1
	cmpwi 0,30,1
	bc 4,1,.L10
	b .L42
.L20:
	lfs 12,24(1)
	lis 9,.LC1@ha
	lis 5,vec3_origin@ha
	lfs 13,8(1)
	la 9,.LC1@l(9)
	lis 10,c_no@ha
	lfs 0,12(1)
	la 5,vec3_origin@l(5)
	addi 3,1,72
	lfs 11,28(1)
	addi 7,1,56
	mr 4,27
	fadds 13,13,12
	lfd 9,0(9)
	mr 6,5
	mr 8,29
	lis 9,.LC2@ha
	lfs 10,16(1)
	mr 24,3
	fadds 0,0,11
	la 9,.LC2@l(9)
	lwz 31,48(28)
	mr 25,7
	lfs 12,0(9)
	lis 26,vec3_origin@ha
	lis 9,0x202
	lwz 11,c_no@l(10)
	mtlr 31
	ori 9,9,3
	stfs 10,48(1)
	fmul 13,13,9
	addi 11,11,1
	fsubs 12,10,12
	stw 11,c_no@l(10)
	fmul 0,0,9
	frsp 13,13
	stfs 12,64(1)
	frsp 0,0
	stfs 13,40(1)
	stfs 13,56(1)
	stfs 0,44(1)
	stfs 0,60(1)
	blrl
	lfs 0,80(1)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L38
	lis 9,.LC3@ha
	lfs 29,92(1)
	li 30,0
	la 9,.LC3@l(9)
	lfd 30,0(9)
	lis 9,.LC4@ha
	fmr 31,29
	la 9,.LC4@l(9)
	lfs 28,0(9)
.L27:
	cmpwi 4,30,0
	li 31,0
.L31:
	bc 12,18,.L32
	lfs 0,24(1)
	b .L33
.L32:
	lfs 0,8(1)
.L33:
	cmpwi 0,31,0
	stfs 0,40(1)
	stfs 0,56(1)
	bc 12,2,.L34
	lfs 0,28(1)
	b .L35
.L34:
	lfs 0,12(1)
.L35:
	lwz 11,48(28)
	la 5,vec3_origin@l(26)
	lis 9,0x202
	mr 3,24
	mr 4,27
	stfs 0,44(1)
	mr 6,5
	mr 7,25
	mtlr 11
	stfs 0,60(1)
	mr 8,29
	ori 9,9,3
	blrl
	lfs 0,80(1)
	fcmpu 0,0,30
	bc 12,2,.L36
	lfs 0,92(1)
	fcmpu 0,0,31
	bc 4,1,.L36
	fmr 31,0
.L36:
	lfs 0,80(1)
	fcmpu 0,0,30
	bc 12,2,.L38
	lfs 0,92(1)
	fsubs 0,29,0
	fcmpu 0,0,28
	bc 4,1,.L30
.L38:
	li 3,0
	b .L41
.L30:
	addi 31,31,1
	cmpwi 0,31,1
	bc 4,1,.L31
	addi 30,30,1
	cmpwi 0,30,1
	bc 4,1,.L27
.L42:
	lis 11,c_yes@ha
	li 3,1
	lwz 9,c_yes@l(11)
	addi 9,9,1
	stw 9,c_yes@l(11)
.L41:
	lwz 0,212(1)
	lwz 12,140(1)
	mtlr 0
	lmw 24,144(1)
	lfd 28,176(1)
	lfd 29,184(1)
	lfd 30,192(1)
	lfd 31,200(1)
	mtcrf 8,12
	la 1,208(1)
	blr
.Lfe1:
	.size	 M_CheckBottom,.Lfe1-M_CheckBottom
	.section	".rodata"
	.align 2
.LC5:
	.string	"tesla"
	.align 2
.LC6:
	.string	"monster_carrier"
	.align 2
.LC7:
	.string	"telsa"
	.align 2
.LC8:
	.long 0x0
	.align 2
.LC9:
	.long 0xbf800000
	.align 2
.LC10:
	.long 0x41000000
	.align 2
.LC11:
	.long 0x3f800000
	.align 2
.LC12:
	.long 0x42200000
	.align 2
.LC13:
	.long 0x42d00000
	.align 2
.LC14:
	.long 0x41200000
	.align 2
.LC15:
	.long 0xc1000000
	.align 2
.LC16:
	.long 0x41900000
	.section	".text"
	.align 2
	.globl SV_movestep
	.type	 SV_movestep,@function
SV_movestep:
	stwu 1,-272(1)
	mflr 0
	stfd 29,248(1)
	stfd 30,256(1)
	stfd 31,264(1)
	stmw 19,196(1)
	stw 0,276(1)
	mr 31,3
	mr 30,4
	lwz 0,480(31)
	mr 23,5
	cmpwi 0,0,0
	bc 4,1,.L47
	bl CheckForBadArea
	mr. 24,3
	bc 12,2,.L48
	lwz 9,540(31)
	stw 24,1040(31)
	cmpwi 0,9,0
	bc 12,2,.L47
	lwz 3,280(9)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L47
	lfs 13,0(30)
	addi 3,1,136
	addi 29,31,16
	lfs 0,4(30)
	lfs 12,8(30)
	stfs 13,168(1)
	stfs 0,172(1)
	stfs 12,176(1)
	lfs 0,4(31)
	lfs 13,4(24)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,136(1)
	lfs 0,8(24)
	fsubs 0,0,12
	stfs 0,140(1)
	lfs 13,12(24)
	fsubs 13,13,11
	stfs 13,144(1)
	bl VectorNormalize
	addi 4,1,152
	li 5,0
	li 6,0
	mr 3,29
	bl AngleVectors
	lfs 12,140(1)
	addi 3,1,168
	lfs 13,156(1)
	lfs 11,136(1)
	lfs 0,152(1)
	fmuls 13,13,12
	lfs 31,160(1)
	lfs 12,144(1)
	fmadds 0,0,11,13
	fmadds 31,31,12,0
	bl VectorNormalize
	mr 3,29
	addi 4,1,152
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 0,172(1)
	lis 9,.LC8@ha
	lfs 12,156(1)
	la 9,.LC8@l(9)
	lfs 13,152(1)
	lfs 11,168(1)
	fmuls 12,12,0
	lfs 10,176(1)
	lfs 0,160(1)
	lfs 9,0(9)
	fmadds 13,13,11,12
	fcmpu 6,31,9
	fmadds 0,0,10,13
	fcmpu 7,0,9
	mfcr 0
	rlwinm 9,0,25,1
	rlwinm 0,0,29,1
	and. 11,9,0
	bc 12,2,.L51
	li 0,1
	b .L52
.L51:
	mfcr 0
	rlwinm 9,0,26,1
	rlwinm 0,0,30,1
	and 0,9,0
.L52:
	cmpwi 0,0,0
	bc 12,2,.L47
	lis 9,.LC9@ha
	mr 3,30
	la 9,.LC9@l(9)
	mr 4,30
	lfs 1,0(9)
	bl VectorScale
	b .L47
.L48:
	lwz 0,1040(31)
	cmpwi 0,0,0
	bc 12,2,.L47
	lwz 0,544(31)
	stw 24,1040(31)
	cmpwi 0,0,0
	bc 12,2,.L47
	mr 3,31
	stw 0,412(31)
	stw 0,540(31)
	bl FoundTarget
	b .L126
.L47:
	lfs 0,0(30)
	lfs 11,4(31)
	lfs 10,8(31)
	lfs 9,12(31)
	lfs 13,4(30)
	fadds 8,11,0
	lfs 12,8(30)
	lwz 0,264(31)
	fadds 7,10,13
	stfs 11,8(1)
	fadds 0,9,12
	andi. 9,0,3
	stfs 10,12(1)
	stfs 9,16(1)
	stfs 8,24(1)
	stfs 7,28(1)
	stfs 0,32(1)
	bc 12,2,.L57
	lis 11,.LC10@ha
	lis 9,.LC11@ha
	la 11,.LC10@l(11)
	la 9,.LC11@l(9)
	lfs 29,0(11)
	lis 26,gi@ha
	li 28,0
	lfs 30,0(9)
	la 27,gi@l(26)
	addi 19,1,56
	addi 20,31,4
	addi 21,31,188
	addi 22,31,200
	addi 25,1,24
.L61:
	lfs 11,0(30)
	cmpwi 0,28,0
	lfs 12,4(31)
	lfs 13,8(31)
	lfs 10,4(30)
	fadds 12,12,11
	lfs 0,12(31)
	lfs 11,8(30)
	fadds 13,13,10
	stfs 12,24(1)
	fadds 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bc 4,2,.L62
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L62
	lwz 0,412(31)
	cmpwi 0,0,0
	bc 4,2,.L63
	stw 9,412(31)
.L63:
	lwz 9,412(31)
	lfs 13,12(31)
	lwz 0,84(9)
	lfs 0,12(9)
	cmpwi 0,0,0
	fsubs 31,13,0
	bc 12,2,.L64
	lwz 3,280(31)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl strcmp
	lis 9,.LC12@ha
	cmpwi 0,3,0
	la 9,.LC12@l(9)
	lfs 13,0(9)
	bc 4,2,.L65
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 13,0(11)
.L65:
	fcmpu 0,31,13
	bc 4,1,.L67
	lfs 0,32(1)
	fsubs 0,0,29
	stfs 0,32(1)
.L67:
	lwz 0,264(31)
	andi. 9,0,2
	bc 12,2,.L69
	lwz 0,612(31)
	cmpwi 0,0,1
	bc 4,1,.L62
.L69:
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	lfs 0,0(11)
	fsubs 0,13,0
	fcmpu 0,31,0
	bc 4,0,.L62
	lfs 0,32(1)
	fadds 0,0,29
	b .L131
.L64:
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 13,0(9)
	fcmpu 0,31,13
	bc 4,1,.L72
	lfs 0,32(1)
	fsubs 0,0,13
	b .L131
.L72:
	lis 11,.LC8@ha
	la 11,.LC8@l(11)
	lfs 0,0(11)
	fcmpu 0,31,0
	bc 4,1,.L74
	lfs 0,32(1)
	fsubs 0,0,31
	b .L131
.L74:
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,0,.L76
	lfs 0,32(1)
	fadds 0,0,13
	b .L131
.L76:
	lfs 0,32(1)
	fadds 0,0,31
.L131:
	stfs 0,32(1)
.L62:
	la 29,gi@l(26)
	lis 9,0x202
	lwz 11,48(29)
	ori 9,9,3
	mr 3,19
	mr 4,20
	mr 5,21
	mr 6,22
	mr 7,25
	mtlr 11
	mr 8,31
	blrl
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L78
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L78
	lfs 0,196(31)
	addi 3,1,120
	lfs 12,76(1)
	lwz 0,52(29)
	lfs 13,68(1)
	fadds 12,12,0
	mtlr 0
	lfs 0,72(1)
	stfs 13,120(1)
	fadds 12,12,30
	stfs 0,124(1)
	stfs 12,128(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L78
	lwz 0,260(31)
	cmpwi 0,0,12
	bc 4,2,.L130
.L78:
	lwz 0,264(31)
	andi. 9,0,2
	bc 12,2,.L81
	lwz 0,612(31)
	cmpwi 0,0,1
	bc 12,1,.L81
	lfs 0,196(31)
	addi 3,1,120
	lfs 12,76(1)
	lwz 9,52(27)
	lfs 13,68(1)
	fadds 12,12,0
	mtlr 9
	lfs 0,72(1)
	stfs 13,120(1)
	fadds 12,12,30
	stfs 0,124(1)
	stfs 12,128(1)
	blrl
	andi. 0,3,8
	bc 12,2,.L83
	lwz 0,264(31)
	andi. 9,0,128
	bc 12,2,.L129
.L83:
	andi. 11,3,16
	bc 12,2,.L81
	lwz 0,264(31)
	andi. 9,0,64
	bc 12,2,.L130
.L81:
	lfs 0,64(1)
	fcmpu 0,0,30
	bc 4,2,.L85
	lwz 0,56(1)
	cmpwi 0,0,0
	bc 4,2,.L85
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 4,2,.L85
	lfs 0,68(1)
	cmpwi 0,24,0
	lfs 13,72(1)
	lfs 12,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	bc 4,2,.L86
	mr 3,31
	bl CheckForBadArea
	cmpwi 0,3,0
	bc 12,2,.L86
	lfs 0,8(1)
	lfs 13,12(1)
	lfs 12,16(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	b .L85
.L86:
	cmpwi 0,23,0
	bc 12,2,.L126
	lwz 0,72(27)
	mr 3,31
	b .L135
.L85:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L130
	addi 28,28,1
	cmpwi 0,28,1
	bc 4,1,.L61
	b .L130
.L57:
	lwz 0,776(31)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	andi. 11,0,1024
	lfs 31,0(9)
	bc 4,2,.L91
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 31,0(9)
.L91:
	fadds 0,0,31
	lis 9,gi@ha
	stfs 8,40(1)
	addi 25,1,56
	la 22,gi@l(9)
	fadds 13,31,31
	stfs 7,44(1)
	addi 27,1,24
	lwz 11,48(22)
	addi 28,1,40
	addi 29,31,188
	stfs 0,32(1)
	addi 26,31,200
	lis 9,0x202
	fsubs 0,0,13
	mr 3,25
	mr 4,27
	mtlr 11
	mr 5,29
	mr 6,26
	mr 7,28
	mr 8,31
	ori 9,9,3
	stfs 0,48(1)
	blrl
	lwz 0,56(1)
	cmpwi 0,0,0
	bc 4,2,.L130
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 12,2,.L94
	lfs 0,32(1)
	lis 9,0x202
	mr 3,25
	lwz 0,48(22)
	mr 4,27
	mr 5,29
	mr 6,26
	mr 7,28
	fsubs 0,0,31
	mtlr 0
	mr 8,31
	ori 9,9,3
	stfs 0,32(1)
	blrl
	lwz 0,56(1)
	cmpwi 0,0,0
	bc 4,2,.L130
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 4,2,.L130
.L94:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L97
	lfs 12,196(31)
	lis 9,.LC11@ha
	addi 3,1,120
	lfs 0,76(1)
	la 9,.LC11@l(9)
	lfs 11,0(9)
	lis 9,gi+52@ha
	lfs 13,68(1)
	fadds 0,0,12
	lwz 0,gi+52@l(9)
	lfs 12,72(1)
	mtlr 0
	stfs 13,120(1)
	fadds 0,0,11
	stfs 12,124(1)
	stfs 0,128(1)
	blrl
	andi. 0,3,8
	bc 12,2,.L98
	lwz 0,264(31)
	andi. 9,0,128
	bc 12,2,.L130
.L98:
	andi. 11,3,16
	bc 12,2,.L97
	lwz 0,264(31)
	andi. 9,0,64
	bc 12,2,.L130
.L97:
	lis 11,.LC11@ha
	lfs 13,64(1)
	la 11,.LC11@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L100
	lwz 0,264(31)
	andi. 29,0,256
	bc 12,2,.L101
	lfs 13,0(30)
	cmpwi 0,23,0
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fadds 0,0,13
	stfs 0,4(31)
	lfs 13,4(30)
	fadds 12,12,13
	stfs 12,8(31)
	lfs 0,8(30)
	fadds 11,11,0
	stfs 11,12(31)
	bc 12,2,.L102
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L102:
	li 0,0
	li 3,1
	stw 0,552(31)
	b .L127
.L101:
	lwz 0,260(31)
	cmpwi 0,0,12
	bc 4,2,.L130
	lfs 13,0(30)
	cmpwi 0,23,0
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fadds 0,0,13
	stfs 0,4(31)
	lfs 13,4(30)
	fadds 12,12,13
	stfs 12,8(31)
	lfs 0,8(30)
	fadds 11,11,0
	stfs 11,12(31)
	bc 12,2,.L105
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L105:
	stw 29,552(31)
	b .L126
.L100:
	lwz 0,480(31)
	lfs 12,68(1)
	lfs 0,72(1)
	cmpwi 0,0,0
	lfs 13,76(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 4,1,.L106
	mr 3,31
	lis 30,new_bad@ha
	bl CheckForBadArea
	cmpwi 0,24,0
	lis 9,new_bad@ha
	stw 3,new_bad@l(9)
	bc 4,2,.L106
	cmpwi 0,3,0
	bc 12,2,.L106
	lwz 3,256(3)
	cmpwi 0,3,0
	bc 12,2,.L122
	lwz 3,280(3)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L122
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L111
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L110
.L111:
	lwz 9,new_bad@l(30)
	mr 3,31
	b .L133
.L110:
	lwz 3,280(9)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L122
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 12,2,.L115
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L115
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L122
	lwz 9,new_bad@l(30)
	mr 3,31
	b .L133
.L115:
	lis 11,new_bad@ha
	mr 3,31
	lwz 9,new_bad@l(11)
.L133:
	lwz 4,256(9)
	bl TargetTesla
	lwz 0,776(31)
	oris 0,0,0x400
	stw 0,776(31)
	b .L122
.L106:
	mr 3,31
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 4,2,.L119
	lwz 0,264(31)
	andi. 9,0,256
	bc 12,2,.L120
	cmpwi 0,23,0
	b .L137
.L120:
	lwz 0,260(31)
	cmpwi 0,0,12
	bc 4,2,.L122
	cmpwi 0,23,0
	b .L137
.L122:
	lfs 0,8(1)
	li 3,0
	lfs 12,12(1)
	lfs 13,16(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
	b .L127
.L129:
.L130:
	li 3,0
	b .L127
.L119:
	lwz 0,264(31)
	andi. 9,0,256
	bc 12,2,.L125
	rlwinm 0,0,0,24,22
	stw 0,264(31)
.L125:
	lwz 9,108(1)
	cmpwi 0,23,0
	stw 9,552(31)
	lwz 0,92(9)
	stw 0,556(31)
.L137:
	bc 12,2,.L126
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
.L135:
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L126:
	li 3,1
.L127:
	lwz 0,276(1)
	mtlr 0
	lmw 19,196(1)
	lfd 29,248(1)
	lfd 30,256(1)
	lfd 31,264(1)
	la 1,272(1)
	blr
.Lfe2:
	.size	 SV_movestep,.Lfe2-SV_movestep
	.section	".rodata"
	.align 2
.LC19:
	.string	"monster_widow"
	.align 3
.LC17:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC18:
	.long 0x40768000
	.long 0x0
	.align 2
.LC20:
	.long 0x439d8000
	.align 2
.LC21:
	.long 0x43340000
	.align 2
.LC22:
	.long 0x43b40000
	.align 2
.LC23:
	.long 0xc3340000
	.align 2
.LC24:
	.long 0x0
	.align 2
.LC25:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl SV_StepDirection
	.type	 SV_StepDirection,@function
SV_StepDirection:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stw 31,44(1)
	stw 0,68(1)
	mr 31,3
	fmr 31,1
	lwz 0,88(31)
	fmr 30,2
	cmpwi 0,0,0
	bc 12,2,.L167
	lfs 1,20(31)
	stfs 31,424(31)
	bl anglemod
	lfs 0,424(31)
	fcmpu 0,1,0
	bc 12,2,.L152
	fcmpu 0,0,1
	lfs 12,420(31)
	fsubs 13,0,1
	bc 4,1,.L153
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L155
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfs 0,0(11)
	fsubs 13,13,0
	b .L155
.L153:
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L155
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfs 0,0(11)
	fadds 13,13,0
.L155:
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L157
	fcmpu 0,13,12
	bc 4,1,.L159
	fmr 13,12
	b .L159
.L157:
	fneg 0,12
	fcmpu 0,13,0
	bc 4,0,.L159
	fmr 13,0
.L159:
	fadds 1,1,13
	bl anglemod
	stfs 1,20(31)
.L152:
	lis 9,.LC17@ha
	fmr 0,31
	lis 11,.LC18@ha
	lfd 13,.LC17@l(9)
	lfd 12,.LC18@l(11)
	fmul 0,0,13
	fadd 0,0,0
	fdiv 0,0,12
	frsp 31,0
	fmr 1,31
	bl cos
	fmul 0,1,30
	fmr 1,31
	frsp 0,0
	stfs 0,8(1)
	bl sin
	fmul 1,1,30
	lfs 12,4(31)
	li 0,0
	mr 3,31
	lfs 13,8(31)
	addi 4,1,8
	li 5,0
	lfs 0,12(31)
	frsp 1,1
	stw 0,16(1)
	stfs 12,24(1)
	stfs 13,28(1)
	stfs 1,12(1)
	stfs 0,32(1)
	bl SV_movestep
	cmpwi 0,3,0
	bc 12,2,.L161
	lwz 9,88(31)
	lwz 0,776(31)
	cmpwi 0,9,0
	rlwinm 0,0,0,6,4
	stw 0,776(31)
	bc 12,2,.L167
	lfs 0,20(31)
	lis 4,.LC19@ha
	li 5,13
	lfs 13,424(31)
	la 4,.LC19@l(4)
	lwz 3,280(31)
	fsubs 31,0,13
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L163
	lis 11,.LC25@ha
	lis 9,.LC20@ha
	la 11,.LC25@l(11)
	lfs 13,.LC20@l(9)
	lfs 0,0(11)
	fcmpu 6,31,13
	fcmpu 7,31,0
	mfcr 9
	rlwinm 0,9,25,1
	rlwinm 9,9,30,1
	and. 11,9,0
	bc 12,2,.L163
	lfs 0,24(1)
	lfs 13,28(1)
	lfs 12,32(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
.L163:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L167:
	li 3,1
	b .L165
.L161:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
	li 3,0
.L165:
	lwz 0,68(1)
	mtlr 0
	lwz 31,44(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 SV_StepDirection,.Lfe3-SV_StepDirection
	.section	".rodata"
	.align 2
.LC26:
	.long 0x439d8000
	.align 2
.LC27:
	.long 0x42340000
	.align 3
.LC28:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC29:
	.long 0x43340000
	.align 2
.LC30:
	.long 0x41200000
	.align 2
.LC31:
	.long 0xc1200000
	.align 2
.LC32:
	.long 0xbf800000
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0x42b40000
	.align 2
.LC35:
	.long 0x43070000
	.align 2
.LC36:
	.long 0x43570000
	.section	".text"
	.align 2
	.globl SV_NewChaseDir
	.type	 SV_NewChaseDir,@function
SV_NewChaseDir:
	stwu 1,-96(1)
	mflr 0
	stfd 26,48(1)
	stfd 27,56(1)
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 30,40(1)
	stw 0,100(1)
	mr. 30,4
	mr 31,3
	fmr 29,1
	bc 12,2,.L169
	lis 9,.LC27@ha
	lfs 0,424(31)
	lis 0,0x4330
	la 9,.LC27@l(9)
	lis 10,.LC28@ha
	lfs 12,0(9)
	la 10,.LC28@l(10)
	lfd 11,0(10)
	mr 11,9
	lis 10,.LC29@ha
	fdivs 0,0,12
	la 10,.LC29@l(10)
	lfs 31,0(10)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 9,36(1)
	mulli 9,9,45
	xoris 9,9,0x8000
	stw 9,36(1)
	stw 0,32(1)
	lfd 1,32(1)
	fsub 1,1,11
	frsp 1,1
	bl anglemod
	fmr 26,1
	fsubs 1,26,31
	bl anglemod
	lfs 11,4(30)
	lis 9,.LC30@ha
	fmr 30,1
	lfs 13,4(31)
	la 9,.LC30@l(9)
	lfs 10,0(9)
	lfs 12,8(30)
	fsubs 27,11,13
	lfs 0,8(31)
	fcmpu 0,27,10
	fsubs 28,12,0
	bc 4,1,.L171
	li 0,0
	b .L212
.L171:
	lis 10,.LC31@ha
	la 10,.LC31@l(10)
	lfs 0,0(10)
	fcmpu 0,27,0
	bc 4,0,.L173
	stfs 31,12(1)
	b .L172
.L173:
	lis 0,0xbf80
.L212:
	stw 0,12(1)
.L172:
	lis 11,.LC31@ha
	la 11,.LC31@l(11)
	lfs 0,0(11)
	fcmpu 0,28,0
	bc 4,0,.L175
	lis 0,0x4387
	b .L213
.L175:
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,28,0
	bc 4,1,.L177
	lis 0,0x42b4
	b .L213
.L177:
	lis 0,0xbf80
.L213:
	stw 0,16(1)
	lis 10,.LC32@ha
	lfs 13,12(1)
	la 10,.LC32@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 12,2,.L179
	lfs 12,16(1)
	fcmpu 0,12,0
	bc 12,2,.L179
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L180
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,2,.L181
	lis 10,.LC27@ha
	la 10,.LC27@l(10)
	lfs 31,0(10)
	b .L183
.L181:
	lis 9,.LC26@ha
	lfs 31,.LC26@l(9)
	b .L183
.L180:
	lis 11,.LC34@ha
	lis 9,.LC35@ha
	la 11,.LC34@l(11)
	lis 10,.LC36@ha
	lfs 0,0(11)
	la 9,.LC35@l(9)
	la 10,.LC36@l(10)
	lfs 13,0(9)
	lfs 31,0(10)
	fsubs 0,12,0
	fsel 31,0,31,13
	fneg 0,0
	fsel 31,0,13,31
.L183:
	fcmpu 0,31,30
	bc 12,2,.L179
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L169
.L179:
	bl rand
	andi. 0,3,1
	bc 4,2,.L188
	fmr 11,28
	fmr 12,27
	mr 9,11
	fctiwz 0,11
	fctiwz 13,12
	stfd 0,32(1)
	lwz 11,36(1)
	stfd 13,32(1)
	srawi 0,11,31
	lwz 9,36(1)
	xor 10,0,11
	subf 10,0,10
	srawi 11,9,31
	xor 0,11,9
	subf 0,11,0
	cmpw 0,10,0
	bc 4,1,.L187
.L188:
	lfs 31,12(1)
	lfs 0,16(1)
	stfs 31,16(1)
	stfs 0,12(1)
.L187:
	lis 9,.LC32@ha
	lfs 1,12(1)
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L189
	fcmpu 0,1,30
	bc 12,2,.L189
	fmr 2,29
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L169
.L189:
	lis 9,.LC32@ha
	lfs 1,16(1)
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L190
	fcmpu 0,1,30
	bc 12,2,.L190
	fmr 2,29
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L169
.L190:
	lwz 9,892(31)
	cmpwi 0,9,0
	bc 12,2,.L191
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L191
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L191
	mr 3,31
	fmr 1,29
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L169
.L191:
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,26,0
	bc 12,2,.L194
	fmr 1,26
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L169
.L194:
	bl rand
	andi. 0,3,1
	bc 12,2,.L195
	lis 10,.LC33@ha
	lis 11,.LC27@ha
	lis 9,.LC26@ha
	la 10,.LC33@l(10)
	la 11,.LC27@l(11)
	lfs 31,0(10)
	lfs 27,.LC26@l(9)
	lfs 28,0(11)
.L199:
	fcmpu 0,31,30
	bc 12,2,.L198
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L169
.L198:
	fadds 31,31,28
	fcmpu 0,31,27
	cror 3,2,0
	bc 12,3,.L199
	b .L202
.L195:
	lis 10,.LC27@ha
	lis 11,.LC33@ha
	lis 9,.LC26@ha
	la 10,.LC27@l(10)
	la 11,.LC33@l(11)
	lfs 27,0(10)
	lfs 31,.LC26@l(9)
	lfs 28,0(11)
.L206:
	fcmpu 0,31,30
	bc 12,2,.L205
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L169
.L205:
	fsubs 31,31,27
	fcmpu 0,31,28
	cror 3,2,1
	bc 12,3,.L206
.L202:
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,30,0
	bc 12,2,.L209
	fmr 1,30
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L169
.L209:
	stfs 26,424(31)
	mr 3,31
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 4,2,.L169
	lwz 0,264(31)
	ori 0,0,256
	stw 0,264(31)
.L169:
	lwz 0,100(1)
	mtlr 0
	lmw 30,40(1)
	lfd 26,48(1)
	lfd 27,56(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe4:
	.size	 SV_NewChaseDir,.Lfe4-SV_NewChaseDir
	.align 2
	.globl M_MoveToGoal
	.type	 M_MoveToGoal,@function
M_MoveToGoal:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	fmr 31,1
	lwz 0,552(31)
	lwz 30,412(31)
	cmpwi 0,0,0
	bc 4,2,.L223
	lwz 0,264(31)
	andi. 9,0,3
	bc 12,2,.L222
.L223:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L224
	li 0,3
	addi 10,9,224
	mtctr 0
	addi 7,9,212
	addi 8,31,224
	addi 11,31,212
	li 9,0
.L240:
	lfsx 0,9,8
	lfsx 13,9,7
	fadds 0,0,31
	fcmpu 0,13,0
	bc 12,1,.L238
	lfs 0,0(11)
	lfs 13,0(10)
	addi 11,11,4
	addi 10,10,4
	fsubs 0,0,31
	fcmpu 0,13,0
	bc 12,0,.L239
	addi 9,9,4
	bdnz .L240
	li 0,1
.L229:
	cmpwi 0,0,0
	bc 4,2,.L222
.L224:
	bl rand
	rlwinm 3,3,0,30,31
	cmpwi 0,3,1
	bc 4,2,.L235
	lwz 0,776(31)
	andis. 9,0,8
	bc 12,2,.L234
.L235:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L222
.L234:
	lwz 0,776(31)
	andis. 9,0,1024
	bc 12,2,.L236
	rlwinm 0,0,0,6,4
	stw 0,776(31)
	b .L222
.L239:
.L238:
	li 0,0
	b .L229
.L236:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L222
	fmr 1,31
	mr 3,31
	mr 4,30
	bl SV_NewChaseDir
.L222:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 M_MoveToGoal,.Lfe5-M_MoveToGoal
	.section	".rodata"
	.align 3
.LC39:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC40:
	.long 0x40768000
	.long 0x0
	.section	".text"
	.align 2
	.globl M_walkmove
	.type	 M_walkmove,@function
M_walkmove:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stw 31,28(1)
	stw 0,52(1)
	mr 31,3
	fmr 30,2
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L242
	lwz 0,264(31)
	andi. 9,0,3
	bc 4,2,.L242
	li 3,0
	b .L243
.L242:
	lis 9,.LC39@ha
	fmr 0,1
	lis 11,.LC40@ha
	lfd 13,.LC39@l(9)
	lfd 12,.LC40@l(11)
	fmul 0,0,13
	fadd 0,0,0
	fdiv 0,0,12
	frsp 1,0
	fmr 31,1
	fmr 1,31
	bl cos
	fmul 0,1,30
	fmr 1,31
	frsp 0,0
	stfs 0,8(1)
	bl sin
	fmul 1,1,30
	li 0,0
	mr 3,31
	stw 0,16(1)
	addi 4,1,8
	li 5,1
	frsp 1,1
	stfs 1,12(1)
	bl SV_movestep
	lwz 0,776(31)
	rlwinm 0,0,0,6,4
	stw 0,776(31)
.L243:
	lwz 0,52(1)
	mtlr 0
	lwz 31,28(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 M_walkmove,.Lfe6-M_walkmove
	.section	".rodata"
	.align 2
.LC41:
	.long 0x43340000
	.align 2
.LC42:
	.long 0x43b40000
	.align 2
.LC43:
	.long 0xc3340000
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.globl M_ChangeYaw
	.type	 M_ChangeYaw,@function
M_ChangeYaw:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lfs 1,20(31)
	bl anglemod
	lfs 0,424(31)
	fcmpu 0,1,0
	bc 12,2,.L139
	fcmpu 0,0,1
	lfs 12,420(31)
	fsubs 13,0,1
	bc 4,1,.L141
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L143
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fsubs 13,13,0
	b .L143
.L141:
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L143
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fadds 13,13,0
.L143:
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L145
	fcmpu 0,13,12
	bc 4,1,.L147
	fmr 13,12
	b .L147
.L145:
	fneg 0,12
	fcmpu 0,13,0
	bc 4,0,.L147
	fmr 13,0
.L147:
	fadds 1,1,13
	bl anglemod
	stfs 1,20(31)
.L139:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 M_ChangeYaw,.Lfe7-M_ChangeYaw
	.comm	new_bad,4,4
	.comm	c_yes,4,4
	.comm	c_no,4,4
	.section	".rodata"
	.align 2
.LC45:
	.long 0x0
	.section	".text"
	.align 2
	.globl IsBadAhead
	.type	 IsBadAhead,@function
IsBadAhead:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 28,56(1)
	stw 0,84(1)
	mr 9,3
	lfs 10,4(4)
	addi 28,1,24
	lfs 0,4(9)
	addi 29,9,16
	addi 3,1,8
	lfs 13,8(9)
	lfs 11,8(4)
	lfs 12,12(9)
	fsubs 10,10,0
	lfs 9,12(4)
	fsubs 11,11,13
	lfs 8,8(5)
	lfs 0,0(5)
	lfs 13,4(5)
	fsubs 9,9,12
	stfs 10,8(1)
	stfs 0,40(1)
	stfs 13,44(1)
	stfs 11,12(1)
	stfs 9,16(1)
	stfs 8,48(1)
	bl VectorNormalize
	mr 4,28
	li 5,0
	li 6,0
	mr 3,29
	bl AngleVectors
	lfs 12,12(1)
	addi 3,1,40
	lfs 13,28(1)
	lfs 11,8(1)
	lfs 0,24(1)
	fmuls 13,13,12
	lfs 31,32(1)
	lfs 12,16(1)
	fmadds 0,0,11,13
	fmadds 31,31,12,0
	bl VectorNormalize
	mr 3,29
	mr 4,28
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 0,44(1)
	lis 9,.LC45@ha
	lfs 12,28(1)
	la 9,.LC45@l(9)
	lfs 13,24(1)
	lfs 11,40(1)
	fmuls 12,12,0
	lfs 10,48(1)
	lfs 0,32(1)
	lfs 9,0(9)
	fmadds 13,13,11,12
	fcmpu 6,31,9
	fmadds 0,0,10,13
	fcmpu 7,0,9
	mfcr 0
	rlwinm 9,0,25,1
	rlwinm 0,0,29,1
	and. 11,9,0
	bc 4,2,.L44
	mfcr 3
	rlwinm 0,3,26,1
	rlwinm 3,3,30,1
	and 3,0,3
	b .L244
.L44:
	li 3,1
.L244:
	lwz 0,84(1)
	mtlr 0
	lmw 28,56(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe8:
	.size	 IsBadAhead,.Lfe8-IsBadAhead
	.align 2
	.globl SV_FixCheckBottom
	.type	 SV_FixCheckBottom,@function
SV_FixCheckBottom:
	lwz 0,264(3)
	ori 0,0,256
	stw 0,264(3)
	blr
.Lfe9:
	.size	 SV_FixCheckBottom,.Lfe9-SV_FixCheckBottom
	.align 2
	.globl SV_CloseEnough
	.type	 SV_CloseEnough,@function
SV_CloseEnough:
	li 0,3
	addi 4,4,224
	mtctr 0
	addi 3,3,212
.L246:
	lfs 0,12(3)
	lfs 13,-12(4)
	fadds 0,0,1
	fcmpu 0,13,0
	bc 4,1,.L219
.L247:
	li 3,0
	blr
.L219:
	lfs 0,0(3)
	lfs 13,0(4)
	fsubs 0,0,1
	fcmpu 0,13,0
	bc 12,0,.L247
	addi 4,4,4
	addi 3,3,4
	bdnz .L246
	li 3,1
	blr
.Lfe10:
	.size	 SV_CloseEnough,.Lfe10-SV_CloseEnough
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
