	.file	"g_turret.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC2:
	.string	"weapons/rocklf1a.wav"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 2
.LC1:
	.long 0x44098000
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC4:
	.long 0x42480000
	.align 2
.LC5:
	.long 0x42c80000
	.align 2
.LC6:
	.long 0x43160000
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl turret_breach_fire
	.type	 turret_breach_fire,@function
turret_breach_fire:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
	stw 0,116(1)
	addi 29,1,24
	addi 26,1,40
	mr 27,3
	addi 28,1,56
	addi 4,1,8
	mr 6,26
	mr 5,29
	addi 3,27,16
	bl AngleVectors
	lfs 1,632(27)
	addi 4,1,8
	addi 3,27,4
	mr 5,28
	bl VectorMA
	lfs 1,636(27)
	mr 4,29
	mr 3,28
	mr 5,28
	bl VectorMA
	lfs 1,640(27)
	mr 4,26
	mr 5,28
	mr 3,28
	bl VectorMA
	bl rand
	rlwinm 3,3,0,17,31
	lwz 29,572(27)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 8,.LC3@ha
	lis 11,.LC0@ha
	stw 0,80(1)
	la 8,.LC3@l(8)
	lis 10,skill@ha
	lfd 13,0(8)
	mr 4,28
	lfd 0,80(1)
	lis 8,.LC4@ha
	mr 7,6
	lfs 8,.LC0@l(11)
	lis 9,.LC5@ha
	la 8,.LC4@l(8)
	la 9,.LC5@l(9)
	lfs 9,0(8)
	lis 11,.LC6@ha
	fsub 0,0,13
	lfs 7,0(9)
	lis 8,.LC1@ha
	la 11,.LC6@l(11)
	lwz 9,skill@l(10)
	addi 5,1,8
	lfs 12,.LC1@l(8)
	frsp 0,0
	lfs 13,20(9)
	lfs 1,0(11)
	lwz 3,256(29)
	fdivs 0,0,8
	fmadds 0,0,9,7
	fmadds 13,13,9,12
	fmr 12,0
	fctiwz 11,12
	fctiwz 10,13
	stfd 11,80(1)
	lwz 6,84(1)
	stfd 10,80(1)
	lwz 7,84(1)
	mr 8,6
	bl fire_rocket
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,20(29)
	lis 8,.LC7@ha
	lis 9,.LC7@ha
	lis 11,.LC8@ha
	mr 6,3
	la 8,.LC7@l(8)
	la 9,.LC7@l(9)
	mtlr 0
	la 11,.LC8@l(11)
	mr 4,27
	lfs 1,0(8)
	mr 3,28
	li 5,1
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 turret_breach_fire,.Lfe1-turret_breach_fire
	.section	".rodata"
	.align 3
.LC9:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC10:
	.long 0x3f91df46
	.long 0xa2529d39
	.align 2
.LC11:
	.long 0x43b40000
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x43340000
	.align 2
.LC14:
	.long 0xc3340000
	.align 2
.LC15:
	.long 0x41200000
	.align 3
.LC16:
	.long 0x40200000
	.long 0x0
	.align 3
.LC17:
	.long 0x0
	.long 0x0
	.align 3
.LC18:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC20:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl turret_breach_think
	.type	 turret_breach_think,@function
turret_breach_think:
	stwu 1,-112(1)
	mflr 0
	stfd 30,96(1)
	stfd 31,104(1)
	stw 31,92(1)
	stw 0,116(1)
	lis 9,.LC11@ha
	mr 31,3
	la 9,.LC11@l(9)
	lfs 11,16(31)
	addi 3,1,24
	lfs 12,0(9)
	lfs 13,20(31)
	addi 9,1,8
	lfs 0,24(31)
	fcmpu 0,11,12
	stfs 11,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	bc 4,1,.L35
	lis 10,.LC11@ha
	fmr 0,11
	la 10,.LC11@l(10)
	lfs 13,0(10)
.L34:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L34
	stfs 0,0(9)
.L35:
	lis 11,.LC12@ha
	lfs 13,0(9)
	addi 4,31,392
	la 11,.LC12@l(11)
	lfs 0,0(11)
	addi 11,31,644
	fcmpu 0,13,0
	bc 4,0,.L106
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	lfs 11,0(10)
	lis 10,.LC12@ha
	la 10,.LC12@l(10)
	lfs 12,0(10)
.L38:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L38
	stfs 0,0(9)
.L106:
	lis 10,.LC11@ha
	lfs 13,4(9)
	la 10,.LC11@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L107
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	lfs 12,0(10)
.L42:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L42
	stfs 0,4(9)
.L107:
	lis 10,.LC12@ha
	lfs 13,4(9)
	la 10,.LC12@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L108
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	lfs 11,0(10)
	lis 10,.LC12@ha
	la 10,.LC12@l(10)
	lfs 12,0(10)
.L46:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L46
	stfs 0,4(9)
.L108:
	lis 9,.LC11@ha
	lfs 13,644(31)
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L52
	lis 10,.LC11@ha
	lfs 0,0(11)
	la 10,.LC11@l(10)
	lfs 13,0(10)
.L51:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L51
	stfs 0,0(11)
.L52:
	lis 9,.LC12@ha
	lfs 13,0(11)
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L109
	lis 10,.LC11@ha
	lis 9,.LC12@ha
	la 10,.LC11@l(10)
	la 9,.LC12@l(9)
	lfs 11,0(10)
	lfs 12,0(9)
.L55:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L55
	stfs 0,0(11)
.L109:
	lis 10,.LC11@ha
	lfs 13,4(11)
	la 10,.LC11@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L110
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 12,0(9)
.L59:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L59
	stfs 0,4(11)
.L110:
	lis 10,.LC12@ha
	lfs 13,4(11)
	la 10,.LC12@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L111
	lis 9,.LC11@ha
	lis 10,.LC12@ha
	la 9,.LC11@l(9)
	la 10,.LC12@l(10)
	lfs 11,0(9)
	lfs 12,0(10)
.L63:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L63
	stfs 0,4(11)
.L111:
	lis 11,.LC13@ha
	lfs 13,644(31)
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L66
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fsubs 0,13,0
	stfs 0,644(31)
.L66:
	lfs 13,644(31)
	lfs 0,356(31)
	fcmpu 0,13,0
	bc 12,1,.L120
	lfs 0,368(31)
	fcmpu 0,13,0
	bc 4,0,.L68
.L120:
	stfs 0,644(31)
.L68:
	lfs 13,648(31)
	lfs 0,360(31)
	lfs 10,372(31)
	fmr 12,13
	fcmpu 0,13,0
	fmr 9,0
	bc 12,0,.L71
	fcmpu 0,12,10
	bc 4,1,.L70
.L71:
	fsubs 0,9,12
	lis 10,.LC14@ha
	la 10,.LC14@l(10)
	lfs 13,0(10)
	fabs 11,0
	fcmpu 0,11,13
	bc 4,0,.L72
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	lfs 0,0(11)
	fadds 11,11,0
	b .L73
.L72:
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L73
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	lfs 0,0(10)
	fsubs 11,11,0
.L73:
	fsubs 0,10,12
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	lfs 13,0(11)
	fabs 12,0
	fcmpu 0,12,13
	bc 4,0,.L75
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fadds 12,12,0
	b .L76
.L75:
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
	lfs 0,0(10)
	fcmpu 0,12,0
	bc 4,1,.L76
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	lfs 0,0(11)
	fsubs 12,12,0
.L76:
	fmr 13,11
	fmr 0,12
	fabs 13,13
	fabs 0,0
	fcmpu 0,13,0
	bc 4,0,.L78
	stfs 9,648(31)
	b .L70
.L78:
	stfs 10,648(31)
.L70:
	lfs 11,644(31)
	lis 9,.LC14@ha
	lfs 0,8(1)
	la 9,.LC14@l(9)
	lfs 10,0(9)
	lfs 13,648(31)
	fsubs 9,11,0
	lfs 12,12(1)
	lfs 0,652(31)
	lfs 11,16(1)
	fcmpu 0,9,10
	stfs 9,24(1)
	fsubs 13,13,12
	fsubs 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bc 4,0,.L80
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	lfs 0,0(10)
	fadds 0,9,0
	b .L121
.L80:
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fcmpu 0,9,0
	bc 4,1,.L81
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fsubs 0,9,0
.L121:
	stfs 0,24(1)
.L81:
	lis 10,.LC14@ha
	lfs 13,28(1)
	la 10,.LC14@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L83
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	b .L122
.L83:
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L84
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	lfs 0,0(10)
	fsubs 0,13,0
.L122:
	stfs 0,28(1)
.L84:
	lfs 13,332(31)
	lis 9,.LC9@ha
	li 0,0
	lfd 31,.LC9@l(9)
	lfs 0,24(1)
	stw 0,32(1)
	fmul 13,13,31
	fcmpu 0,0,13
	bc 4,1,.L86
	frsp 0,13
	stfs 0,24(1)
.L86:
	lfs 0,332(31)
	lfs 13,24(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L87
	frsp 0,0
	stfs 0,24(1)
.L87:
	lfs 0,332(31)
	lfs 13,28(1)
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,1,.L88
	frsp 0,0
	stfs 0,28(1)
.L88:
	lfs 0,332(31)
	lfs 13,28(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L89
	frsp 0,0
	stfs 0,28(1)
.L89:
	lis 11,.LC15@ha
	la 11,.LC15@l(11)
	lfs 1,0(11)
	bl VectorScale
	lis 9,level+4@ha
	lwz 11,572(31)
	lfs 0,level+4@l(9)
	cmpwi 0,11,0
	fadd 0,0,31
	frsp 0,0
	stfs 0,432(31)
	bc 12,2,.L91
.L93:
	lfs 0,396(31)
	stfs 0,396(11)
	lwz 11,568(11)
	cmpwi 0,11,0
	bc 4,2,.L93
.L91:
	lwz 11,256(31)
	cmpwi 0,11,0
	bc 12,2,.L95
	lfs 0,392(31)
	lis 9,.LC10@ha
	lfd 12,.LC10@l(9)
	stfs 0,392(11)
	lfs 0,396(31)
	lwz 9,256(31)
	stfs 0,396(9)
	lwz 11,256(31)
	lfs 13,20(31)
	lfs 0,636(11)
	lfs 31,4(31)
	fadds 30,13,0
	fmr 0,30
	fmul 0,0,12
	frsp 30,0
	fmr 1,30
	bl cos
	lwz 9,256(31)
	lis 10,.LC16@ha
	lis 11,.LC17@ha
	la 10,.LC16@l(10)
	la 11,.LC17@l(11)
	lfs 0,632(9)
	lfd 13,0(10)
	lfd 12,0(11)
	fmadd 1,1,0,31
	frsp 0,1
	fmul 0,0,13
	frsp 0,0
	fmr 1,0
	fcmpu 0,1,12
	bc 4,1,.L96
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L123
.L96:
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L123:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lfs 31,8(31)
	mr 11,9
	lis 10,.LC19@ha
	fmr 1,30
	la 10,.LC19@l(10)
	fctiwz 0,13
	lfd 11,0(10)
	lis 10,.LC20@ha
	la 10,.LC20@l(10)
	stfd 0,80(1)
	lwz 9,84(1)
	lfd 12,0(10)
	xoris 9,9,0x8000
	stw 9,84(1)
	stw 0,80(1)
	lfd 0,80(1)
	fsub 0,0,11
	fmul 0,0,12
	frsp 0,0
	stfs 0,40(1)
	bl sin
	lwz 9,256(31)
	lis 10,.LC16@ha
	lis 11,.LC17@ha
	la 10,.LC16@l(10)
	la 11,.LC17@l(11)
	lfs 0,632(9)
	lfd 13,0(10)
	lfd 12,0(11)
	fmadd 1,1,0,31
	frsp 0,1
	fmul 0,0,13
	frsp 0,0
	fmr 1,0
	fcmpu 0,1,12
	bc 4,1,.L99
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L124
.L99:
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L124:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 7,256(31)
	mr 8,10
	lis 11,.LC19@ha
	lfs 10,40(1)
	la 11,.LC19@l(11)
	lis 9,.LC20@ha
	fctiwz 0,13
	lfd 11,0(11)
	la 9,.LC20@l(9)
	lfd 12,0(9)
	lis 11,.LC9@ha
	lfd 9,.LC9@l(11)
	lis 9,.LC10@ha
	stfd 0,80(1)
	lwz 10,84(1)
	lfd 8,.LC10@l(9)
	xoris 10,10,0x8000
	stw 10,84(1)
	stw 0,80(1)
	lfd 0,80(1)
	fsub 0,0,11
	fmul 0,0,12
	frsp 0,0
	stfs 0,44(1)
	lfs 11,12(7)
	stfs 11,48(1)
	lfs 12,4(7)
	fsubs 10,10,12
	fmr 13,10
	stfs 10,56(1)
	lfs 12,8(7)
	fdiv 13,13,9
	fsubs 0,0,12
	frsp 13,13
	stfs 0,60(1)
	lfs 12,12(7)
	fsubs 11,11,12
	stfs 11,64(1)
	stfs 13,380(7)
	lfs 0,60(1)
	lwz 9,256(31)
	fdiv 0,0,9
	frsp 0,0
	stfs 0,384(9)
	lfs 13,16(31)
	fmul 13,13,8
	frsp 30,13
	fmr 1,30
	bl tan
	lwz 9,256(31)
	lis 10,.LC16@ha
	lis 11,.LC17@ha
	lfs 12,12(31)
	la 10,.LC16@l(10)
	la 11,.LC17@l(11)
	lfs 13,632(9)
	lfs 0,640(9)
	lfd 11,0(10)
	lfd 10,0(11)
	fmadd 13,13,1,12
	fadd 13,13,0
	frsp 0,13
	fmul 0,0,11
	frsp 0,0
	fmr 13,0
	fcmpu 0,13,10
	bc 4,1,.L102
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfd 0,0(9)
	fadd 0,13,0
	b .L125
.L102:
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfd 0,0(10)
	fsub 0,13,0
.L125:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 8,256(31)
	mr 10,9
	lis 11,.LC19@ha
	la 11,.LC19@l(11)
	lfs 9,12(8)
	fctiwz 0,13
	lfd 10,0(11)
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
	stfd 0,80(1)
	lwz 9,84(1)
	lfd 12,0(11)
	xoris 9,9,0x8000
	lis 11,.LC9@ha
	stw 9,84(1)
	stw 0,80(1)
	lfd 0,80(1)
	lfd 11,.LC9@l(11)
	fsub 0,0,10
	fmul 0,0,12
	frsp 0,0
	fsubs 0,0,9
	fmr 13,0
	fdiv 13,13,11
	frsp 13,13
	stfs 13,388(8)
	lwz 0,288(31)
	andis. 9,0,1
	bc 12,2,.L95
	mr 3,31
	bl turret_breach_fire
	lwz 0,288(31)
	rlwinm 0,0,0,16,14
	stw 0,288(31)
.L95:
	lwz 0,116(1)
	mtlr 0
	lwz 31,92(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe2:
	.size	 turret_breach_think,.Lfe2-turret_breach_think
	.section	".rodata"
	.align 2
.LC21:
	.string	"%s at %s needs a target\n"
	.align 3
.LC22:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC23:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_turret_breach
	.type	 SP_turret_breach,@function
SP_turret_breach:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,3
	li 11,2
	lis 9,gi@ha
	stw 0,248(31)
	la 30,gi@l(9)
	stw 11,264(31)
	lwz 9,44(30)
	lwz 4,272(31)
	mtlr 9
	blrl
	lis 9,.LC23@ha
	lfs 0,332(31)
	la 9,.LC23@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L130
	lis 0,0x4248
	stw 0,332(31)
.L130:
	lwz 0,520(31)
	cmpwi 0,0,0
	bc 4,2,.L131
	li 0,10
	stw 0,520(31)
.L131:
	lis 9,st@ha
	la 7,st@l(9)
	lfs 0,60(7)
	fcmpu 0,0,13
	bc 4,2,.L132
	lis 0,0xc1f0
	stw 0,60(7)
.L132:
	lfs 0,64(7)
	fcmpu 0,0,13
	bc 4,2,.L133
	lis 0,0x41f0
	stw 0,64(7)
.L133:
	lfs 0,56(7)
	fcmpu 0,0,13
	bc 4,2,.L134
	lis 0,0x43b4
	stw 0,56(7)
.L134:
	lfs 0,60(7)
	lis 11,turret_blocked@ha
	lis 10,turret_breach_finish_init@ha
	lfs 11,20(31)
	la 11,turret_blocked@l(11)
	la 10,turret_breach_finish_init@l(10)
	lis 8,level+4@ha
	lis 9,.LC22@ha
	fneg 0,0
	lfd 12,.LC22@l(9)
	mr 3,31
	stfs 0,356(31)
	lfs 13,52(7)
	stfs 13,360(31)
	lfs 0,64(7)
	fneg 0,0
	stfs 0,368(31)
	lfs 13,56(7)
	stfs 11,648(31)
	stw 11,444(31)
	stfs 13,372(31)
	stw 10,440(31)
	stfs 11,428(31)
	lfs 0,level+4@l(8)
	fadd 0,0,12
	frsp 0,0
	stfs 0,432(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 SP_turret_breach,.Lfe3-SP_turret_breach
	.section	".rodata"
	.align 3
.LC24:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC26:
	.long 0x40400000
	.align 3
.LC27:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl turret_driver_think
	.type	 turret_driver_think,@function
turret_driver_think:
	stwu 1,-64(1)
	mflr 0
	stw 31,60(1)
	stw 0,68(1)
	lis 9,level+4@ha
	lis 11,.LC24@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC24@l(11)
	lwz 9,548(31)
	cmpwi 0,9,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	bc 12,2,.L153
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L144
	lwz 0,484(9)
	cmpwi 0,0,0
	bc 12,1,.L143
.L144:
	li 0,0
	stw 0,548(31)
.L143:
	lwz 4,548(31)
	cmpwi 0,4,0
	bc 4,2,.L145
.L153:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 12,2,.L142
	lis 9,level+4@ha
	lwz 0,820(31)
	lfs 0,level+4@l(9)
	rlwinm 0,0,0,29,27
	b .L154
.L145:
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L148
	lwz 0,820(31)
	ori 0,0,8
	stw 0,820(31)
	b .L142
.L148:
	lwz 0,820(31)
	andi. 9,0,8
	bc 12,2,.L147
	lis 9,level+4@ha
	rlwinm 0,0,0,29,27
	lfs 0,level+4@l(9)
.L154:
	stw 0,820(31)
	stfs 0,896(31)
.L147:
	lwz 9,548(31)
	lis 10,.LC25@ha
	la 10,.LC25@l(10)
	lis 8,0x4330
	lfs 12,4(9)
	addi 3,1,24
	lfd 10,0(10)
	lwz 10,328(31)
	stfs 12,8(1)
	lfs 11,8(9)
	addi 4,10,644
	stfs 11,12(1)
	lfs 13,12(9)
	stfs 13,16(1)
	lwz 0,512(9)
	xoris 0,0,0x8000
	stw 0,52(1)
	stw 8,48(1)
	lfd 0,48(1)
	fsub 0,0,10
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	lfs 0,4(10)
	fsubs 12,12,0
	stfs 12,24(1)
	lfs 0,8(10)
	fsubs 11,11,0
	stfs 11,28(1)
	lfs 0,12(10)
	fsubs 13,13,0
	stfs 13,32(1)
	bl vectoangles
	lis 9,level+4@ha
	lfs 0,876(31)
	lfs 11,level+4@l(9)
	fcmpu 0,11,0
	bc 12,0,.L142
	lis 9,.LC26@ha
	lis 11,skill@ha
	lfs 13,896(31)
	la 9,.LC26@l(9)
	lfs 12,0(9)
	lwz 9,skill@l(11)
	fsubs 13,11,13
	lfs 0,20(9)
	fsubs 0,12,0
	fcmpu 0,13,0
	bc 12,0,.L142
	fadds 0,11,0
	lis 10,.LC27@ha
	lwz 9,328(31)
	la 10,.LC27@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,876(31)
	lwz 0,288(9)
	oris 0,0,0x1
	stw 0,288(9)
.L142:
	lwz 0,68(1)
	mtlr 0
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 turret_driver_think,.Lfe4-turret_driver_think
	.section	".rodata"
	.align 3
.LC28:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC29:
	.long 0x43b40000
	.align 2
.LC30:
	.long 0x0
	.section	".text"
	.align 2
	.globl turret_driver_link
	.type	 turret_driver_link,@function
turret_driver_link:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,turret_driver_think@ha
	mr 31,3
	la 9,turret_driver_think@l(9)
	lis 10,level+4@ha
	lwz 3,300(31)
	stw 9,440(31)
	lis 11,.LC28@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC28@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	bl G_PickTarget
	mr 11,3
	li 0,0
	stw 11,328(31)
	addi 3,1,8
	stw 31,256(11)
	lwz 9,328(31)
	lwz 11,572(9)
	stw 31,256(11)
	lwz 9,328(31)
	lfs 12,4(31)
	lfs 13,16(9)
	lfs 11,8(31)
	stfs 13,16(31)
	lfs 0,20(9)
	stfs 0,20(31)
	lfs 13,24(9)
	stfs 13,24(31)
	lfs 0,4(9)
	fsubs 0,0,12
	stfs 0,8(1)
	lfs 13,8(9)
	stw 0,16(1)
	fsubs 13,13,11
	stfs 13,12(1)
	bl VectorLength
	lwz 9,328(31)
	addi 3,1,8
	stfs 1,632(31)
	mr 4,3
	lfs 13,4(9)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(9)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl vectoangles
	lis 11,.LC29@ha
	lfs 13,8(1)
	addi 9,1,8
	la 11,.LC29@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L159
	lis 11,.LC29@ha
	fmr 0,13
	la 11,.LC29@l(11)
	lfs 13,0(11)
.L158:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L158
	stfs 0,0(9)
.L159:
	lis 11,.LC30@ha
	lfs 13,0(9)
	la 11,.LC30@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L178
	lis 11,.LC29@ha
	la 11,.LC29@l(11)
	lfs 11,0(11)
	lis 11,.LC30@ha
	la 11,.LC30@l(11)
	lfs 12,0(11)
.L162:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L162
	stfs 0,0(9)
.L178:
	lis 11,.LC29@ha
	lfs 13,4(9)
	la 11,.LC29@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L179
	lis 11,.LC29@ha
	la 11,.LC29@l(11)
	lfs 12,0(11)
.L166:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L166
	stfs 0,4(9)
.L179:
	lis 11,.LC30@ha
	lfs 13,4(9)
	la 11,.LC30@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L180
	lis 11,.LC29@ha
	la 11,.LC29@l(11)
	lfs 11,0(11)
	lis 11,.LC30@ha
	la 11,.LC30@l(11)
	lfs 12,0(11)
.L170:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L170
	stfs 0,4(9)
.L180:
	lfs 0,12(1)
	lwz 9,328(31)
	stfs 0,636(31)
	lfs 13,12(9)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,640(31)
	lwz 9,572(9)
	b .L185
.L175:
	lwz 9,568(9)
.L185:
	lwz 0,568(9)
	cmpwi 0,0,0
	bc 4,2,.L175
	stw 31,568(9)
	lwz 9,328(31)
	lwz 0,268(31)
	lwz 11,572(9)
	ori 0,0,1024
	stw 0,268(31)
	stw 11,572(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 turret_driver_link,.Lfe5-turret_driver_link
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.section	".rodata"
	.align 2
.LC31:
	.long 0x43b40000
	.align 2
.LC32:
	.long 0x0
	.section	".text"
	.align 2
	.globl AnglesNormalize
	.type	 AnglesNormalize,@function
AnglesNormalize:
	lis 9,.LC31@ha
	lfs 13,0(3)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L8
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 12,0(9)
.L9:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L9
	stfs 0,0(3)
.L8:
	lis 9,.LC32@ha
	lfs 13,0(3)
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L186
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 11,0(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 12,0(9)
.L13:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L13
	stfs 0,0(3)
.L186:
	lis 9,.LC31@ha
	lfs 13,4(3)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L187
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 12,0(9)
.L17:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L17
	stfs 0,4(3)
.L187:
	lis 9,.LC32@ha
	lfs 13,4(3)
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bclr 4,0
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 11,0(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 12,0(9)
.L21:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L21
	stfs 0,4(3)
	blr
.Lfe6:
	.size	 AnglesNormalize,.Lfe6-AnglesNormalize
	.section	".rodata"
	.align 3
.LC33:
	.long 0x40200000
	.long 0x0
	.align 3
.LC34:
	.long 0x0
	.long 0x0
	.align 3
.LC35:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC37:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SnapToEights
	.type	 SnapToEights,@function
SnapToEights:
	stwu 1,-16(1)
	lis 9,.LC33@ha
	lis 10,.LC34@ha
	la 9,.LC33@l(9)
	la 10,.LC34@l(10)
	lfd 0,0(9)
	lfd 13,0(10)
	fmul 1,1,0
	frsp 0,1
	fmr 1,0
	fcmpu 0,1,13
	bc 4,1,.L24
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L193
.L24:
	lis 10,.LC35@ha
	la 10,.LC35@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L193:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	mr 11,9
	lis 10,.LC36@ha
	la 10,.LC36@l(10)
	fctiwz 0,13
	lfd 12,0(10)
	lis 10,.LC37@ha
	la 10,.LC37@l(10)
	stfd 0,8(1)
	lwz 9,12(1)
	lfd 11,0(10)
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 1,8(1)
	fsub 1,1,12
	fmul 1,1,11
	frsp 1,1
	la 1,16(1)
	blr
.Lfe7:
	.size	 SnapToEights,.Lfe7-SnapToEights
	.align 2
	.globl turret_blocked
	.type	 turret_blocked,@function
turret_blocked:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 0,516(4)
	mr 9,3
	cmpwi 0,0,0
	bc 12,2,.L27
	lwz 11,572(9)
	mr 3,4
	li 10,0
	mr 4,9
	lis 6,vec3_origin@ha
	lwz 5,256(11)
	la 6,vec3_origin@l(6)
	li 29,20
	lwz 9,520(11)
	addi 7,3,4
	mr 8,6
	addic 0,5,-1
	subfe 0,0,0
	stw 10,8(1)
	andc 5,5,0
	and 11,11,0
	stw 29,12(1)
	li 10,10
	or 5,11,5
	bl T_Damage
.L27:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 turret_blocked,.Lfe8-turret_blocked
	.align 2
	.globl turret_breach_finish_init
	.type	 turret_breach_finish_init,@function
turret_breach_finish_init:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,300(31)
	cmpwi 0,3,0
	bc 4,2,.L127
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L128
.L127:
	bl G_PickTarget
	mr 9,3
	lfs 0,4(31)
	stw 9,328(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,632(31)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,636(31)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,640(31)
	bl G_FreeEdict
.L128:
	lis 9,turret_breach_think@ha
	lwz 11,572(31)
	mr 3,31
	la 9,turret_breach_think@l(9)
	lwz 0,520(31)
	mtlr 9
	stw 0,520(11)
	stw 9,440(31)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 turret_breach_finish_init,.Lfe9-turret_breach_finish_init
	.align 2
	.globl SP_turret_base
	.type	 SP_turret_base,@function
SP_turret_base:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,3
	li 9,2
	lis 28,gi@ha
	stw 0,248(29)
	la 28,gi@l(28)
	stw 9,264(29)
	lwz 9,44(28)
	lwz 4,272(29)
	mtlr 9
	blrl
	lis 9,turret_blocked@ha
	mr 3,29
	la 9,turret_blocked@l(9)
	stw 9,444(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 SP_turret_base,.Lfe10-SP_turret_base
	.align 2
	.globl turret_driver_die
	.type	 turret_driver_die,@function
turret_driver_die:
	lwz 9,328(3)
	li 0,0
	stw 0,644(9)
	lwz 11,328(3)
	lwz 9,572(11)
	b .L194
.L139:
	lwz 9,568(9)
.L194:
	lwz 0,568(9)
	cmpw 0,0,3
	bc 4,2,.L139
	li 10,0
	stw 10,568(9)
	lwz 0,268(3)
	lwz 11,328(3)
	rlwinm 0,0,0,22,20
	stw 10,572(3)
	stw 0,268(3)
	stw 10,256(11)
	lwz 9,328(3)
	lwz 11,572(9)
	stw 10,256(11)
	blr
.Lfe11:
	.size	 turret_driver_die,.Lfe11-turret_driver_die
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
