	.file	"m_move.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.align 2
.LC1:
	.long 0x3f800000
	.align 3
.LC2:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC3:
	.long 0x41900000
	.align 3
.LC4:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl M_CheckBottom
	.type	 M_CheckBottom,@function
M_CheckBottom:
	stwu 1,-224(1)
	mflr 0
	mfcr 12
	stfd 27,184(1)
	stfd 28,192(1)
	stfd 29,200(1)
	stfd 30,208(1)
	stfd 31,216(1)
	stmw 24,152(1)
	stw 0,228(1)
	stw 12,148(1)
	lis 9,.LC0@ha
	mr 30,3
	la 9,.LC0@l(9)
	lfs 13,1056(30)
	lfs 10,0(9)
	lfs 12,4(30)
	lis 9,.LC1@ha
	lfs 0,188(30)
	la 9,.LC1@l(9)
	lfs 6,12(30)
	fcmpu 0,13,10
	lfs 8,196(30)
	lfs 11,8(30)
	fadds 0,12,0
	lfs 13,192(30)
	lfs 7,200(30)
	fadds 8,6,8
	lfs 10,204(30)
	lfs 9,208(30)
	fadds 13,11,13
	lfs 4,0(9)
	fadds 12,12,7
	stfs 0,8(1)
	fadds 11,11,10
	fadds 0,6,9
	stfs 13,12(1)
	fsubs 5,8,4
	stfs 12,24(1)
	stfs 11,28(1)
	stfs 8,16(1)
	stfs 5,48(1)
	stfs 0,32(1)
	bc 4,1,.L7
	fadds 0,0,4
	stfs 0,48(1)
.L7:
	lis 9,gi@ha
	li 29,0
	la 28,gi@l(9)
	addi 27,1,40
.L11:
	cmpwi 4,29,0
	li 31,0
.L15:
	bc 12,18,.L16
	lfs 0,24(1)
	b .L17
.L16:
	lfs 0,8(1)
.L17:
	cmpwi 0,31,0
	stfs 0,40(1)
	bc 12,2,.L18
	lfs 0,28(1)
	b .L19
.L18:
	lfs 0,12(1)
.L19:
	lwz 9,52(28)
	mr 3,27
	stfs 0,44(1)
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 4,2,.L21
	addi 31,31,1
	cmpwi 0,31,1
	bc 4,1,.L15
	addi 29,29,1
	cmpwi 0,29,1
	bc 4,1,.L11
	b .L50
.L21:
	lfs 12,28(1)
	lis 9,.LC2@ha
	lis 11,c_no@ha
	lfs 13,8(1)
	la 9,.LC2@l(9)
	lfs 11,24(1)
	lfs 0,12(1)
	lfd 9,0(9)
	fadds 13,13,11
	lis 9,.LC0@ha
	lfs 10,1056(30)
	fadds 0,0,12
	la 9,.LC0@l(9)
	lfs 8,0(9)
	lwz 9,c_no@l(11)
	lfs 12,16(1)
	fcmpu 0,10,8
	addi 9,9,1
	fmul 13,13,9
	stw 9,c_no@l(11)
	fmul 0,0,9
	stfs 12,48(1)
	frsp 13,13
	frsp 0,0
	stfs 13,40(1)
	stfs 13,56(1)
	stfs 0,44(1)
	stfs 0,60(1)
	bc 4,0,.L24
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	fsubs 0,12,13
	fsubs 0,0,13
	stfs 0,64(1)
	b .L25
.L24:
	lis 9,.LC3@ha
	lfs 0,32(1)
	la 9,.LC3@l(9)
	lfs 12,0(9)
	stfs 0,48(1)
	fadds 13,0,12
	fadds 13,13,12
	stfs 13,64(1)
.L25:
	lis 9,gi@ha
	lis 5,vec3_origin@ha
	la 31,gi@l(9)
	la 5,vec3_origin@l(5)
	lwz 11,48(31)
	lis 9,0x202
	addi 3,1,72
	addi 7,1,56
	ori 9,9,3
	mr 4,27
	mr 6,5
	mtlr 11
	mr 8,30
	mr 24,3
	mr 25,7
	lis 26,vec3_origin@ha
	blrl
	lfs 0,80(1)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L46
	lis 9,.LC4@ha
	lfs 29,92(1)
	mr 28,31
	la 9,.LC4@l(9)
	li 29,0
	lfd 30,0(9)
	lis 9,.LC3@ha
	fmr 31,29
	la 9,.LC3@l(9)
	lfs 28,0(9)
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	lfs 27,0(9)
.L30:
	cmpwi 4,29,0
	li 31,0
.L34:
	bc 12,18,.L35
	lfs 0,24(1)
	b .L36
.L35:
	lfs 0,8(1)
.L36:
	cmpwi 0,31,0
	stfs 0,40(1)
	stfs 0,56(1)
	bc 12,2,.L37
	lfs 0,28(1)
	b .L38
.L37:
	lfs 0,12(1)
.L38:
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
	mr 8,30
	ori 9,9,3
	blrl
	lfs 0,1056(30)
	fcmpu 0,0,27
	bc 4,1,.L39
	lfs 0,80(1)
	fmr 13,0
	fcmpu 0,13,30
	bc 12,2,.L40
	lfs 13,92(1)
	fcmpu 0,13,31
	bc 4,0,.L40
	fmr 31,13
.L40:
	fcmpu 0,0,30
	bc 12,2,.L46
	lfs 0,92(1)
	fsubs 0,0,29
	b .L51
.L39:
	lfs 0,80(1)
	fmr 13,0
	fcmpu 0,13,30
	bc 12,2,.L44
	lfs 13,92(1)
	fcmpu 0,13,31
	bc 4,1,.L44
	fmr 31,13
.L44:
	fcmpu 0,0,30
	bc 12,2,.L46
	lfs 0,92(1)
	fsubs 0,29,0
.L51:
	fcmpu 0,0,28
	bc 4,1,.L33
.L46:
	li 3,0
	b .L49
.L33:
	addi 31,31,1
	cmpwi 0,31,1
	bc 4,1,.L34
	addi 29,29,1
	cmpwi 0,29,1
	bc 4,1,.L30
.L50:
	lis 11,c_yes@ha
	li 3,1
	lwz 9,c_yes@l(11)
	addi 9,9,1
	stw 9,c_yes@l(11)
.L49:
	lwz 0,228(1)
	lwz 12,148(1)
	mtlr 0
	lmw 24,152(1)
	lfd 27,184(1)
	lfd 28,192(1)
	lfd 29,200(1)
	lfd 30,208(1)
	lfd 31,216(1)
	mtcrf 8,12
	la 1,224(1)
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
	mr 27,4
	lwz 0,480(31)
	mr 22,5
	cmpwi 0,0,0
	bc 4,1,.L56
	bl CheckForBadArea
	mr. 23,3
	bc 12,2,.L57
	lwz 9,540(31)
	stw 23,1060(31)
	cmpwi 0,9,0
	bc 12,2,.L56
	lwz 3,280(9)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L56
	lfs 13,0(27)
	addi 3,1,136
	addi 29,31,16
	lfs 0,4(27)
	lfs 12,8(27)
	stfs 13,168(1)
	stfs 0,172(1)
	stfs 12,176(1)
	lfs 0,4(31)
	lfs 13,4(23)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,136(1)
	lfs 0,8(23)
	fsubs 0,0,12
	stfs 0,140(1)
	lfs 13,12(23)
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
	bc 12,2,.L60
	li 0,1
	b .L61
.L60:
	mfcr 0
	rlwinm 9,0,26,1
	rlwinm 0,0,30,1
	and 0,9,0
.L61:
	cmpwi 0,0,0
	bc 12,2,.L56
	lis 9,.LC9@ha
	mr 3,27
	la 9,.LC9@l(9)
	mr 4,27
	lfs 1,0(9)
	bl VectorScale
	b .L56
.L57:
	lwz 0,1060(31)
	cmpwi 0,0,0
	bc 12,2,.L56
	lwz 0,544(31)
	stw 23,1060(31)
	cmpwi 0,0,0
	bc 12,2,.L56
	mr 3,31
	stw 0,412(31)
	stw 0,540(31)
	bl FoundTarget
	b .L129
.L56:
	lfs 11,4(31)
	lfs 10,8(31)
	lfs 9,12(31)
	lfs 0,0(27)
	lfs 13,4(27)
	lfs 12,8(27)
	lwz 0,264(31)
	fadds 0,11,0
	fadds 13,10,13
	stfs 11,8(1)
	fadds 12,9,12
	andi. 9,0,3
	stfs 10,12(1)
	stfs 0,24(1)
	stfs 13,28(1)
	stfs 12,32(1)
	stfs 9,16(1)
	bc 12,2,.L66
	lis 11,.LC10@ha
	lis 9,.LC11@ha
	la 11,.LC10@l(11)
	la 9,.LC11@l(9)
	lfs 29,0(11)
	lis 26,gi@ha
	li 29,0
	lfs 30,0(9)
	la 28,gi@l(26)
	addi 19,1,56
	addi 20,31,4
	addi 21,31,188
	addi 24,31,200
	addi 25,1,24
.L70:
	lfs 11,0(27)
	cmpwi 0,29,0
	lfs 12,4(31)
	lfs 13,8(31)
	lfs 10,4(27)
	fadds 12,12,11
	lfs 0,12(31)
	lfs 11,8(27)
	fadds 13,13,10
	stfs 12,24(1)
	fadds 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bc 4,2,.L71
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L71
	lwz 0,412(31)
	cmpwi 0,0,0
	bc 4,2,.L72
	stw 9,412(31)
.L72:
	lwz 9,412(31)
	lfs 13,12(31)
	lwz 0,84(9)
	lfs 0,12(9)
	cmpwi 0,0,0
	fsubs 31,13,0
	bc 12,2,.L73
	lwz 3,280(31)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl strcmp
	lis 9,.LC12@ha
	cmpwi 0,3,0
	la 9,.LC12@l(9)
	lfs 13,0(9)
	bc 4,2,.L74
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 13,0(11)
.L74:
	fcmpu 0,31,13
	bc 4,1,.L76
	lfs 0,32(1)
	fsubs 0,0,29
	stfs 0,32(1)
.L76:
	lwz 0,264(31)
	andi. 9,0,2
	bc 12,2,.L78
	lwz 0,612(31)
	cmpwi 0,0,1
	bc 4,1,.L71
.L78:
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	lfs 0,0(11)
	fsubs 0,13,0
	fcmpu 0,31,0
	bc 4,0,.L71
	lfs 0,32(1)
	fadds 0,0,29
	b .L133
.L73:
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 13,0(9)
	fcmpu 0,31,13
	bc 4,1,.L81
	lfs 0,32(1)
	fsubs 0,0,13
	b .L133
.L81:
	lis 11,.LC8@ha
	la 11,.LC8@l(11)
	lfs 0,0(11)
	fcmpu 0,31,0
	bc 4,1,.L83
	lfs 0,32(1)
	fsubs 0,0,31
	b .L133
.L83:
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,0,.L85
	lfs 0,32(1)
	fadds 0,0,13
	b .L133
.L85:
	lfs 0,32(1)
	fadds 0,0,31
.L133:
	stfs 0,32(1)
.L71:
	la 30,gi@l(26)
	lis 9,0x202
	lwz 11,48(30)
	ori 9,9,3
	mr 3,19
	mr 4,20
	mr 5,21
	mr 6,24
	mr 7,25
	mtlr 11
	mr 8,31
	blrl
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L87
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L87
	lfs 0,196(31)
	addi 3,1,120
	lfs 12,76(1)
	lwz 0,52(30)
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
	bc 4,2,.L131
.L87:
	lwz 0,264(31)
	andi. 9,0,2
	bc 12,2,.L90
	lwz 0,612(31)
	cmpwi 0,0,1
	bc 12,1,.L90
	lfs 0,196(31)
	addi 3,1,120
	lfs 12,76(1)
	lwz 9,52(28)
	lfs 13,68(1)
	fadds 12,12,0
	mtlr 9
	lfs 0,72(1)
	stfs 13,120(1)
	fadds 12,12,30
	stfs 0,124(1)
	stfs 12,128(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L132
.L90:
	lfs 0,64(1)
	fcmpu 0,0,30
	bc 4,2,.L93
	lwz 0,56(1)
	cmpwi 0,0,0
	bc 4,2,.L93
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 4,2,.L93
	lfs 0,68(1)
	cmpwi 0,23,0
	lfs 13,72(1)
	lfs 12,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	bc 4,2,.L94
	mr 3,31
	bl CheckForBadArea
	cmpwi 0,3,0
	bc 12,2,.L94
	lfs 0,8(1)
	lfs 13,12(1)
	lfs 12,16(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	b .L93
.L94:
	cmpwi 0,22,0
	bc 12,2,.L129
	lwz 0,72(28)
	mr 3,31
	b .L138
.L93:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L132
	addi 29,29,1
	cmpwi 0,29,1
	bc 4,1,.L70
	b .L132
.L66:
	lwz 0,776(31)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	andi. 11,0,1024
	lfs 31,0(9)
	bc 4,2,.L99
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 31,0(9)
.L99:
	fneg 1,31
	addi 30,1,24
	addi 29,31,1048
	addi 28,1,40
	mr 4,29
	mr 3,30
	mr 5,30
	bl VectorMA
	addi 25,31,188
	fadds 1,31,31
	addi 26,1,56
	mr 4,29
	mr 3,30
	mr 5,28
	addi 29,31,200
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x202
	la 24,gi@l(11)
	mr 3,26
	lwz 11,48(24)
	mr 4,30
	mr 5,25
	mr 6,29
	mr 7,28
	mr 8,31
	ori 9,9,3
	mtlr 11
	blrl
	lwz 0,56(1)
	cmpwi 0,0,0
	bc 4,2,.L132
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 12,2,.L102
	lfs 0,32(1)
	lis 9,0x202
	mr 3,26
	lwz 0,48(24)
	mr 4,30
	mr 5,25
	mr 6,29
	mr 7,28
	fsubs 0,0,31
	mtlr 0
	mr 8,31
	ori 9,9,3
	stfs 0,32(1)
	blrl
	lwz 0,56(1)
	cmpwi 0,0,0
	bc 4,2,.L132
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 4,2,.L132
.L102:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L105
	lis 9,.LC8@ha
	lfs 12,1056(31)
	la 9,.LC8@l(9)
	lfs 11,68(1)
	lfs 0,0(9)
	lfs 13,72(1)
	stfs 11,120(1)
	fcmpu 0,12,0
	stfs 13,124(1)
	bc 4,1,.L106
	lfs 13,208(31)
	lis 11,.LC11@ha
	lfs 0,76(1)
	la 11,.LC11@l(11)
	lfs 12,0(11)
	fadds 0,0,13
	fsubs 0,0,12
	b .L135
.L106:
	lfs 13,196(31)
	lis 9,.LC11@ha
	lfs 0,76(1)
	la 9,.LC11@l(9)
	lfs 12,0(9)
	fadds 0,0,13
	fadds 0,0,12
.L135:
	stfs 0,128(1)
	lis 9,gi+52@ha
	addi 3,1,120
	lwz 0,gi+52@l(9)
	mtlr 0
	blrl
	andi. 0,3,56
	bc 4,2,.L132
.L105:
	lis 9,.LC11@ha
	lfs 13,64(1)
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L109
	lwz 0,264(31)
	andi. 11,0,256
	bc 12,2,.L132
	lfs 13,0(27)
	cmpwi 0,22,0
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fadds 0,0,13
	stfs 0,4(31)
	lfs 13,4(27)
	fadds 12,12,13
	stfs 12,8(31)
	lfs 0,8(27)
	fadds 11,11,0
	stfs 11,12(31)
	bc 12,2,.L111
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L111:
	li 0,0
	li 3,1
	stw 0,552(31)
	b .L130
.L109:
	lwz 0,480(31)
	lfs 12,68(1)
	lfs 0,72(1)
	cmpwi 0,0,0
	lfs 13,76(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 4,1,.L112
	mr 3,31
	lis 30,new_bad@ha
	bl CheckForBadArea
	cmpwi 0,23,0
	lis 9,new_bad@ha
	stw 3,new_bad@l(9)
	bc 4,2,.L112
	cmpwi 0,3,0
	bc 12,2,.L112
	lwz 3,256(3)
	cmpwi 0,3,0
	bc 12,2,.L126
	lwz 3,280(3)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L126
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L117
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L116
.L117:
	lwz 9,new_bad@l(30)
	mr 3,31
	b .L136
.L116:
	lwz 3,280(9)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L126
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 12,2,.L121
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L121
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L126
	lwz 9,new_bad@l(30)
	mr 3,31
	b .L136
.L121:
	lis 11,new_bad@ha
	mr 3,31
	lwz 9,new_bad@l(11)
.L136:
	lwz 4,256(9)
	bl TargetTesla
	lwz 0,776(31)
	oris 0,0,0x400
	stw 0,776(31)
	b .L126
.L112:
	mr 3,31
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 4,2,.L125
	lwz 0,264(31)
	andi. 9,0,256
	bc 12,2,.L126
	cmpwi 0,22,0
	b .L140
.L126:
	lfs 0,8(1)
	li 3,0
	lfs 12,12(1)
	lfs 13,16(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
	b .L130
.L131:
.L132:
	li 3,0
	b .L130
.L125:
	lwz 0,264(31)
	andi. 9,0,256
	bc 12,2,.L128
	rlwinm 0,0,0,24,22
	stw 0,264(31)
.L128:
	lwz 9,108(1)
	cmpwi 0,22,0
	stw 9,552(31)
	lwz 0,92(9)
	stw 0,556(31)
.L140:
	bc 12,2,.L129
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
.L138:
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L129:
	li 3,1
.L130:
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
	bc 12,2,.L169
	lfs 1,20(31)
	stfs 31,424(31)
	bl anglemod
	lfs 0,424(31)
	fcmpu 0,1,0
	bc 12,2,.L154
	fcmpu 0,0,1
	lfs 12,420(31)
	fsubs 13,0,1
	bc 4,1,.L155
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L157
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfs 0,0(11)
	fsubs 13,13,0
	b .L157
.L155:
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L157
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfs 0,0(11)
	fadds 13,13,0
.L157:
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L159
	fcmpu 0,13,12
	bc 4,1,.L161
	fmr 13,12
	b .L161
.L159:
	fneg 0,12
	fcmpu 0,13,0
	bc 4,0,.L161
	fmr 13,0
.L161:
	fadds 1,1,13
	bl anglemod
	stfs 1,20(31)
.L154:
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
	bc 12,2,.L163
	lwz 9,88(31)
	lwz 0,776(31)
	cmpwi 0,9,0
	rlwinm 0,0,0,6,4
	stw 0,776(31)
	bc 12,2,.L169
	lfs 0,20(31)
	lis 4,.LC19@ha
	li 5,13
	lfs 13,424(31)
	la 4,.LC19@l(4)
	lwz 3,280(31)
	fsubs 31,0,13
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L165
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
	bc 12,2,.L165
	lfs 0,24(1)
	lfs 13,28(1)
	lfs 12,32(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
.L165:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L169:
	li 3,1
	b .L167
.L163:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
	li 3,0
.L167:
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
	bc 12,2,.L171
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
	bc 4,1,.L173
	li 0,0
	b .L214
.L173:
	lis 10,.LC31@ha
	la 10,.LC31@l(10)
	lfs 0,0(10)
	fcmpu 0,27,0
	bc 4,0,.L175
	stfs 31,12(1)
	b .L174
.L175:
	lis 0,0xbf80
.L214:
	stw 0,12(1)
.L174:
	lis 11,.LC31@ha
	la 11,.LC31@l(11)
	lfs 0,0(11)
	fcmpu 0,28,0
	bc 4,0,.L177
	lis 0,0x4387
	b .L215
.L177:
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,28,0
	bc 4,1,.L179
	lis 0,0x42b4
	b .L215
.L179:
	lis 0,0xbf80
.L215:
	stw 0,16(1)
	lis 10,.LC32@ha
	lfs 13,12(1)
	la 10,.LC32@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 12,2,.L181
	lfs 12,16(1)
	fcmpu 0,12,0
	bc 12,2,.L181
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L182
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,2,.L183
	lis 10,.LC27@ha
	la 10,.LC27@l(10)
	lfs 31,0(10)
	b .L185
.L183:
	lis 9,.LC26@ha
	lfs 31,.LC26@l(9)
	b .L185
.L182:
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
.L185:
	fcmpu 0,31,30
	bc 12,2,.L181
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L171
.L181:
	bl rand
	andi. 0,3,1
	bc 4,2,.L190
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
	bc 4,1,.L189
.L190:
	lfs 31,12(1)
	lfs 0,16(1)
	stfs 31,16(1)
	stfs 0,12(1)
.L189:
	lis 9,.LC32@ha
	lfs 1,12(1)
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L191
	fcmpu 0,1,30
	bc 12,2,.L191
	fmr 2,29
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L171
.L191:
	lis 9,.LC32@ha
	lfs 1,16(1)
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L192
	fcmpu 0,1,30
	bc 12,2,.L192
	fmr 2,29
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L171
.L192:
	lwz 9,892(31)
	cmpwi 0,9,0
	bc 12,2,.L193
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L193
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L193
	mr 3,31
	fmr 1,29
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L171
.L193:
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,26,0
	bc 12,2,.L196
	fmr 1,26
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L171
.L196:
	bl rand
	andi. 0,3,1
	bc 12,2,.L197
	lis 10,.LC33@ha
	lis 11,.LC27@ha
	lis 9,.LC26@ha
	la 10,.LC33@l(10)
	la 11,.LC27@l(11)
	lfs 31,0(10)
	lfs 27,.LC26@l(9)
	lfs 28,0(11)
.L201:
	fcmpu 0,31,30
	bc 12,2,.L200
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L171
.L200:
	fadds 31,31,28
	fcmpu 0,31,27
	cror 3,2,0
	bc 12,3,.L201
	b .L204
.L197:
	lis 10,.LC27@ha
	lis 11,.LC33@ha
	lis 9,.LC26@ha
	la 10,.LC27@l(10)
	la 11,.LC33@l(11)
	lfs 27,0(10)
	lfs 31,.LC26@l(9)
	lfs 28,0(11)
.L208:
	fcmpu 0,31,30
	bc 12,2,.L207
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L171
.L207:
	fsubs 31,31,27
	fcmpu 0,31,28
	cror 3,2,1
	bc 12,3,.L208
.L204:
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,30,0
	bc 12,2,.L211
	fmr 1,30
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L171
.L211:
	stfs 26,424(31)
	mr 3,31
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 4,2,.L171
	lwz 0,264(31)
	ori 0,0,256
	stw 0,264(31)
.L171:
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
	bc 4,2,.L225
	lwz 0,264(31)
	andi. 9,0,3
	bc 12,2,.L224
.L225:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L226
	li 0,3
	addi 10,9,224
	mtctr 0
	addi 7,9,212
	addi 8,31,224
	addi 11,31,212
	li 9,0
.L242:
	lfsx 0,9,8
	lfsx 13,9,7
	fadds 0,0,31
	fcmpu 0,13,0
	bc 12,1,.L240
	lfs 0,0(11)
	lfs 13,0(10)
	addi 11,11,4
	addi 10,10,4
	fsubs 0,0,31
	fcmpu 0,13,0
	bc 12,0,.L241
	addi 9,9,4
	bdnz .L242
	li 0,1
.L231:
	cmpwi 0,0,0
	bc 4,2,.L224
.L226:
	bl rand
	rlwinm 3,3,0,30,31
	cmpwi 0,3,1
	bc 4,2,.L237
	lwz 0,776(31)
	andis. 9,0,8
	bc 12,2,.L236
.L237:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L224
.L236:
	lwz 0,776(31)
	andis. 9,0,1024
	bc 12,2,.L238
	rlwinm 0,0,0,6,4
	stw 0,776(31)
	b .L224
.L241:
.L240:
	li 0,0
	b .L231
.L238:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L224
	fmr 1,31
	mr 3,31
	mr 4,30
	bl SV_NewChaseDir
.L224:
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
	bc 4,2,.L244
	lwz 0,264(31)
	andi. 9,0,3
	bc 4,2,.L244
	li 3,0
	b .L245
.L244:
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
.L245:
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
	bc 12,2,.L141
	fcmpu 0,0,1
	lfs 12,420(31)
	fsubs 13,0,1
	bc 4,1,.L143
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L145
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fsubs 13,13,0
	b .L145
.L143:
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L145
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fadds 13,13,0
.L145:
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L147
	fcmpu 0,13,12
	bc 4,1,.L149
	fmr 13,12
	b .L149
.L147:
	fneg 0,12
	fcmpu 0,13,0
	bc 4,0,.L149
	fmr 13,0
.L149:
	fadds 1,1,13
	bl anglemod
	stfs 1,20(31)
.L141:
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
	bc 4,2,.L53
	mfcr 3
	rlwinm 0,3,26,1
	rlwinm 3,3,30,1
	and 3,0,3
	b .L246
.L53:
	li 3,1
.L246:
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
.L248:
	lfs 0,12(3)
	lfs 13,-12(4)
	fadds 0,0,1
	fcmpu 0,13,0
	bc 4,1,.L221
.L249:
	li 3,0
	blr
.L221:
	lfs 0,0(3)
	lfs 13,0(4)
	fsubs 0,0,1
	fcmpu 0,13,0
	bc 12,0,.L249
	addi 4,4,4
	addi 3,3,4
	bdnz .L248
	li 3,1
	blr
.Lfe10:
	.size	 SV_CloseEnough,.Lfe10-SV_CloseEnough
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
