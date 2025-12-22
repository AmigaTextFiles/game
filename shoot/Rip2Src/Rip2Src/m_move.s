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
	.long 0x41000000
	.align 2
.LC6:
	.long 0x3f800000
	.align 2
.LC7:
	.long 0x42200000
	.align 2
.LC8:
	.long 0x41f00000
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0xc1000000
	.align 2
.LC11:
	.long 0x41900000
	.section	".text"
	.align 2
	.globl SV_movestep
	.type	 SV_movestep,@function
SV_movestep:
	stwu 1,-208(1)
	mflr 0
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 20,144(1)
	stw 0,212(1)
	mr 31,3
	mr 29,4
	lfs 0,0(29)
	mr 23,5
	lfs 11,4(31)
	lfs 10,8(31)
	lfs 9,12(31)
	lfs 13,4(29)
	fadds 8,11,0
	lfs 12,8(29)
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
	bc 12,2,.L44
	lis 9,.LC5@ha
	lis 26,gi@ha
	la 9,.LC5@l(9)
	li 28,0
	lfs 30,0(9)
	la 27,gi@l(26)
	addi 20,1,56
	lis 9,.LC6@ha
	addi 21,31,4
	la 9,.LC6@l(9)
	addi 22,31,188
	lfs 31,0(9)
	addi 24,31,200
	addi 25,1,24
.L48:
	lfs 11,0(29)
	cmpwi 0,28,0
	lfs 12,4(31)
	lfs 13,8(31)
	lfs 10,4(29)
	fadds 12,12,11
	lfs 0,12(31)
	lfs 11,8(29)
	fadds 13,13,10
	stfs 12,24(1)
	fadds 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bc 4,2,.L49
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L49
	lwz 0,412(31)
	cmpwi 0,0,0
	bc 4,2,.L50
	stw 9,412(31)
.L50:
	lwz 9,412(31)
	lfs 13,12(31)
	lwz 0,84(9)
	lfs 0,12(9)
	cmpwi 0,0,0
	fsubs 13,13,0
	bc 12,2,.L51
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L52
	lfs 0,32(1)
	fsubs 0,0,30
	stfs 0,32(1)
.L52:
	lwz 0,264(31)
	andi. 9,0,2
	bc 12,2,.L54
	lwz 0,612(31)
	cmpwi 0,0,1
	bc 4,1,.L49
.L54:
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L49
	lfs 0,32(1)
	fadds 0,0,30
	b .L92
.L51:
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 12,0(9)
	fcmpu 0,13,12
	bc 4,1,.L57
	lfs 0,32(1)
	fsubs 0,0,12
	b .L92
.L57:
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L59
	lfs 0,32(1)
	fsubs 0,0,13
	b .L92
.L59:
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L61
	lfs 0,32(1)
	fadds 0,0,12
	b .L92
.L61:
	lfs 0,32(1)
	fadds 0,0,13
.L92:
	stfs 0,32(1)
.L49:
	la 30,gi@l(26)
	lis 9,0x202
	lwz 11,48(30)
	ori 9,9,3
	mr 3,20
	mr 4,21
	mr 5,22
	mr 6,24
	mr 7,25
	mtlr 11
	mr 8,31
	blrl
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L63
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L63
	lfs 0,196(31)
	addi 3,1,120
	lfs 12,76(1)
	lwz 0,52(30)
	lfs 13,68(1)
	fadds 12,12,0
	mtlr 0
	lfs 0,72(1)
	stfs 13,120(1)
	fadds 12,12,31
	stfs 0,124(1)
	stfs 12,128(1)
	blrl
	andi. 0,3,56
	bc 4,2,.L90
.L63:
	lwz 0,264(31)
	andi. 9,0,2
	bc 12,2,.L66
	lwz 0,612(31)
	cmpwi 0,0,1
	bc 12,1,.L66
	lfs 0,196(31)
	addi 3,1,120
	lfs 12,76(1)
	lwz 9,52(27)
	lfs 13,68(1)
	fadds 12,12,0
	mtlr 9
	lfs 0,72(1)
	stfs 13,120(1)
	fadds 12,12,31
	stfs 0,124(1)
	stfs 12,128(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L91
.L66:
	lfs 0,64(1)
	fcmpu 0,0,31
	bc 4,2,.L69
	lfs 0,68(1)
	cmpwi 0,23,0
	lfs 13,72(1)
	lfs 12,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	bc 12,2,.L88
	lwz 0,72(27)
	mr 3,31
	b .L95
.L69:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L91
	addi 28,28,1
	cmpwi 0,28,1
	bc 4,1,.L48
	b .L91
.L44:
	lis 9,.LC6@ha
	lwz 0,776(31)
	la 9,.LC6@l(9)
	lfs 31,0(9)
	andi. 9,0,1024
	bc 4,2,.L73
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 31,0(9)
.L73:
	fadds 0,0,31
	lis 9,gi@ha
	stfs 8,40(1)
	addi 25,1,56
	la 24,gi@l(9)
	fadds 13,31,31
	stfs 7,44(1)
	addi 27,1,24
	lwz 11,48(24)
	addi 28,1,40
	addi 30,31,188
	stfs 0,32(1)
	addi 26,31,200
	lis 9,0x202
	fsubs 0,0,13
	mr 3,25
	mr 4,27
	mtlr 11
	mr 5,30
	mr 6,26
	mr 7,28
	mr 8,31
	ori 9,9,3
	stfs 0,48(1)
	blrl
	lwz 0,56(1)
	cmpwi 0,0,0
	bc 4,2,.L91
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 12,2,.L76
	lfs 0,32(1)
	lis 9,0x202
	mr 3,25
	lwz 0,48(24)
	mr 4,27
	mr 5,30
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
	bc 4,2,.L91
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 4,2,.L91
.L76:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L79
	lfs 12,196(31)
	lis 9,.LC6@ha
	addi 3,1,120
	lfs 0,76(1)
	la 9,.LC6@l(9)
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
	andi. 0,3,56
	bc 4,2,.L91
.L79:
	lis 9,.LC6@ha
	lfs 13,64(1)
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L81
	lwz 0,264(31)
	andi. 9,0,256
	bc 12,2,.L91
	lfs 13,0(29)
	cmpwi 0,23,0
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fadds 0,0,13
	stfs 0,4(31)
	lfs 13,4(29)
	fadds 12,12,13
	stfs 12,8(31)
	lfs 0,8(29)
	fadds 11,11,0
	stfs 11,12(31)
	bc 12,2,.L83
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L83:
	li 0,0
	li 3,1
	stw 0,552(31)
	b .L89
.L81:
	lfs 0,68(1)
	mr 3,31
	lfs 13,72(1)
	lfs 12,76(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 4,2,.L84
	lwz 0,264(31)
	andi. 9,0,256
	bc 12,2,.L85
	cmpwi 0,23,0
	b .L97
.L85:
	lfs 0,8(1)
	li 3,0
	lfs 12,12(1)
	lfs 13,16(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
	b .L89
.L90:
.L91:
	li 3,0
	b .L89
.L84:
	lwz 0,264(31)
	andi. 9,0,256
	bc 12,2,.L87
	rlwinm 0,0,0,24,22
	stw 0,264(31)
.L87:
	lwz 9,108(1)
	cmpwi 0,23,0
	stw 9,552(31)
	lwz 0,92(9)
	stw 0,556(31)
.L97:
	bc 12,2,.L88
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
.L95:
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
.L88:
	li 3,1
.L89:
	lwz 0,212(1)
	mtlr 0
	lmw 20,144(1)
	lfd 30,192(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe2:
	.size	 SV_movestep,.Lfe2-SV_movestep
	.section	".rodata"
	.align 3
.LC12:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC13:
	.long 0x40768000
	.long 0x0
	.align 2
.LC14:
	.long 0x439d8000
	.align 2
.LC15:
	.long 0x43340000
	.align 2
.LC16:
	.long 0x43b40000
	.align 2
.LC17:
	.long 0xc3340000
	.align 2
.LC18:
	.long 0x0
	.align 2
.LC19:
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
	lfs 1,20(31)
	fmr 30,2
	stfs 31,424(31)
	bl anglemod
	lfs 0,424(31)
	fcmpu 0,1,0
	bc 12,2,.L110
	fcmpu 0,0,1
	lfs 12,420(31)
	fsubs 13,0,1
	bc 4,1,.L111
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L113
	lis 11,.LC16@ha
	la 11,.LC16@l(11)
	lfs 0,0(11)
	fsubs 13,13,0
	b .L113
.L111:
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L113
	lis 11,.LC16@ha
	la 11,.LC16@l(11)
	lfs 0,0(11)
	fadds 13,13,0
.L113:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L115
	fcmpu 0,13,12
	bc 4,1,.L117
	fmr 13,12
	b .L117
.L115:
	fneg 0,12
	fcmpu 0,13,0
	bc 4,0,.L117
	fmr 13,0
.L117:
	fadds 1,1,13
	bl anglemod
	stfs 1,20(31)
.L110:
	lis 9,.LC12@ha
	fmr 0,31
	lis 11,.LC13@ha
	lfd 13,.LC12@l(9)
	lfd 12,.LC13@l(11)
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
	bc 12,2,.L119
	lfs 0,20(31)
	lis 11,.LC19@ha
	lis 9,.LC14@ha
	lfs 13,424(31)
	la 11,.LC19@l(11)
	lfs 11,0(11)
	lfs 12,.LC14@l(9)
	fsubs 0,0,13
	fcmpu 7,0,12
	fcmpu 6,0,11
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 12,2,.L120
	lfs 0,24(1)
	lfs 13,28(1)
	lfs 12,32(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
.L120:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
	li 3,1
	b .L121
.L119:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	bl G_TouchTriggers
	li 3,0
.L121:
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
.LC20:
	.long 0x439d8000
	.align 2
.LC21:
	.long 0x42340000
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC23:
	.long 0x43340000
	.align 2
.LC24:
	.long 0x41200000
	.align 2
.LC25:
	.long 0xc1200000
	.align 2
.LC26:
	.long 0xbf800000
	.align 2
.LC27:
	.long 0x0
	.align 2
.LC28:
	.long 0x42b40000
	.align 2
.LC29:
	.long 0x43070000
	.align 2
.LC30:
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
	bc 12,2,.L123
	lis 9,.LC21@ha
	lfs 0,424(31)
	lis 0,0x4330
	la 9,.LC21@l(9)
	lis 10,.LC22@ha
	lfs 12,0(9)
	la 10,.LC22@l(10)
	lfd 11,0(10)
	mr 11,9
	lis 10,.LC23@ha
	fdivs 0,0,12
	la 10,.LC23@l(10)
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
	lis 9,.LC24@ha
	fmr 30,1
	lfs 13,4(31)
	la 9,.LC24@l(9)
	lfs 10,0(9)
	lfs 12,8(30)
	fsubs 27,11,13
	lfs 0,8(31)
	fcmpu 0,27,10
	fsubs 28,12,0
	bc 4,1,.L125
	li 0,0
	b .L163
.L125:
	lis 10,.LC25@ha
	la 10,.LC25@l(10)
	lfs 0,0(10)
	fcmpu 0,27,0
	bc 4,0,.L127
	stfs 31,12(1)
	b .L126
.L127:
	lis 0,0xbf80
.L163:
	stw 0,12(1)
.L126:
	lis 11,.LC25@ha
	la 11,.LC25@l(11)
	lfs 0,0(11)
	fcmpu 0,28,0
	bc 4,0,.L129
	lis 0,0x4387
	b .L164
.L129:
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,28,0
	bc 4,1,.L131
	lis 0,0x42b4
	b .L164
.L131:
	lis 0,0xbf80
.L164:
	stw 0,16(1)
	lis 10,.LC26@ha
	lfs 13,12(1)
	la 10,.LC26@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 12,2,.L133
	lfs 12,16(1)
	fcmpu 0,12,0
	bc 12,2,.L133
	lis 11,.LC27@ha
	la 11,.LC27@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L134
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,2,.L135
	lis 10,.LC21@ha
	la 10,.LC21@l(10)
	lfs 31,0(10)
	b .L137
.L135:
	lis 9,.LC20@ha
	lfs 31,.LC20@l(9)
	b .L137
.L134:
	lis 11,.LC28@ha
	lis 9,.LC29@ha
	la 11,.LC28@l(11)
	lis 10,.LC30@ha
	lfs 0,0(11)
	la 9,.LC29@l(9)
	la 10,.LC30@l(10)
	lfs 13,0(9)
	lfs 31,0(10)
	fsubs 0,12,0
	fsel 31,0,31,13
	fneg 0,0
	fsel 31,0,13,31
.L137:
	fcmpu 0,31,30
	bc 12,2,.L133
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L123
.L133:
	bl rand
	andi. 0,3,1
	bc 4,2,.L142
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
	bc 4,1,.L141
.L142:
	lfs 31,12(1)
	lfs 0,16(1)
	stfs 31,16(1)
	stfs 0,12(1)
.L141:
	lis 9,.LC26@ha
	lfs 1,12(1)
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L143
	fcmpu 0,1,30
	bc 12,2,.L143
	fmr 2,29
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L123
.L143:
	lis 9,.LC26@ha
	lfs 1,16(1)
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L144
	fcmpu 0,1,30
	bc 12,2,.L144
	fmr 2,29
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L123
.L144:
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,26,0
	bc 12,2,.L145
	fmr 1,26
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L123
.L145:
	bl rand
	andi. 0,3,1
	bc 12,2,.L146
	lis 10,.LC27@ha
	lis 11,.LC21@ha
	lis 9,.LC20@ha
	la 10,.LC27@l(10)
	la 11,.LC21@l(11)
	lfs 31,0(10)
	lfs 27,.LC20@l(9)
	lfs 28,0(11)
.L150:
	fcmpu 0,31,30
	bc 12,2,.L149
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L123
.L149:
	fadds 31,31,28
	fcmpu 0,31,27
	cror 3,2,0
	bc 12,3,.L150
	b .L153
.L146:
	lis 10,.LC21@ha
	lis 11,.LC27@ha
	lis 9,.LC20@ha
	la 10,.LC21@l(10)
	la 11,.LC27@l(11)
	lfs 27,0(10)
	lfs 31,.LC20@l(9)
	lfs 28,0(11)
.L157:
	fcmpu 0,31,30
	bc 12,2,.L156
	fmr 1,31
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L123
.L156:
	fsubs 31,31,27
	fcmpu 0,31,28
	cror 3,2,1
	bc 12,3,.L157
.L153:
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,30,0
	bc 12,2,.L160
	fmr 1,30
	mr 3,31
	fmr 2,29
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L123
.L160:
	stfs 26,424(31)
	mr 3,31
	bl M_CheckBottom
	cmpwi 0,3,0
	bc 4,2,.L123
	lwz 0,264(31)
	ori 0,0,256
	stw 0,264(31)
.L123:
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
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".rodata"
	.align 3
.LC33:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC34:
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
	bc 4,2,.L188
	lwz 0,264(31)
	andi. 9,0,3
	bc 4,2,.L188
	li 3,0
	b .L189
.L188:
	lis 9,.LC33@ha
	fmr 0,1
	lis 11,.LC34@ha
	lfd 13,.LC33@l(9)
	lfd 12,.LC34@l(11)
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
.L189:
	lwz 0,52(1)
	mtlr 0
	lwz 31,28(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 M_walkmove,.Lfe5-M_walkmove
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
	bc 4,2,.L174
	lwz 0,264(31)
	andi. 9,0,3
	bc 12,2,.L173
.L174:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L175
	li 0,3
	addi 10,9,224
	mtctr 0
	addi 7,9,212
	addi 8,31,224
	addi 11,31,212
	li 9,0
.L190:
	lfsx 0,9,8
	lfsx 13,9,7
	fadds 0,0,31
	fcmpu 0,13,0
	bc 12,1,.L191
	lfs 0,0(11)
	lfs 13,0(10)
	fsubs 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L182
.L191:
	li 0,0
	b .L180
.L182:
	addi 10,10,4
	addi 11,11,4
	addi 9,9,4
	bdnz .L190
	li 0,1
.L180:
	cmpwi 0,0,0
	bc 4,2,.L173
.L175:
	bl rand
	rlwinm 3,3,0,30,31
	cmpwi 0,3,1
	bc 12,2,.L185
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	bl SV_StepDirection
	cmpwi 0,3,0
	bc 4,2,.L173
.L185:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L173
	fmr 1,31
	mr 3,31
	mr 4,30
	bl SV_NewChaseDir
.L173:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 M_MoveToGoal,.Lfe6-M_MoveToGoal
	.section	".rodata"
	.align 2
.LC35:
	.long 0x43340000
	.align 2
.LC36:
	.long 0x43b40000
	.align 2
.LC37:
	.long 0xc3340000
	.align 2
.LC38:
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
	bc 12,2,.L98
	fcmpu 0,0,1
	lfs 12,420(31)
	fsubs 13,0,1
	bc 4,1,.L100
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L102
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 0,0(9)
	fsubs 13,13,0
	b .L102
.L100:
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L102
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 0,0(9)
	fadds 13,13,0
.L102:
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L104
	fcmpu 0,13,12
	bc 4,1,.L106
	fmr 13,12
	b .L106
.L104:
	fneg 0,12
	fcmpu 0,13,0
	bc 4,0,.L106
	fmr 13,0
.L106:
	fadds 1,1,13
	bl anglemod
	stfs 1,20(31)
.L98:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 M_ChangeYaw,.Lfe7-M_ChangeYaw
	.comm	c_yes,4,4
	.comm	c_no,4,4
	.align 2
	.globl SV_FixCheckBottom
	.type	 SV_FixCheckBottom,@function
SV_FixCheckBottom:
	lwz 0,264(3)
	ori 0,0,256
	stw 0,264(3)
	blr
.Lfe8:
	.size	 SV_FixCheckBottom,.Lfe8-SV_FixCheckBottom
	.align 2
	.globl SV_CloseEnough
	.type	 SV_CloseEnough,@function
SV_CloseEnough:
	li 0,3
	addi 4,4,224
	mtctr 0
	addi 3,3,212
.L193:
	lfs 0,12(3)
	lfs 13,-12(4)
	fadds 0,0,1
	fcmpu 0,13,0
	bc 4,1,.L170
.L194:
	li 3,0
	blr
.L170:
	lfs 0,0(3)
	lfs 13,0(4)
	fsubs 0,0,1
	fcmpu 0,13,0
	bc 12,0,.L194
	addi 4,4,4
	addi 3,3,4
	bdnz .L193
	li 3,1
	blr
.Lfe9:
	.size	 SV_CloseEnough,.Lfe9-SV_CloseEnough
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
