	.file	"g_turret.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"weapons/rocklf1a.wav"
	.align 2
.LC3:
	.string	"cl_predict 1\n"
	.align 2
.LC4:
	.string	"cl_predict 0\n"
	.align 2
.LC5:
	.string	"Turret mounted\n\nPress USE to fire, JUMP to abandon"
	.align 3
.LC1:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC2:
	.long 0x3f91df46
	.long 0xa2529d39
	.align 2
.LC6:
	.long 0x43b40000
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x43340000
	.align 2
.LC9:
	.long 0xc3340000
	.align 2
.LC10:
	.long 0x41200000
	.align 3
.LC11:
	.long 0x40200000
	.long 0x0
	.align 3
.LC12:
	.long 0x0
	.long 0x0
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC15:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC16:
	.long 0x43160000
	.align 2
.LC17:
	.long 0x3f800000
	.align 2
.LC18:
	.long 0x42000000
	.align 2
.LC19:
	.long 0x41000000
	.align 2
.LC20:
	.long 0xc3960000
	.align 2
.LC21:
	.long 0x42a00000
	.align 3
.LC22:
	.long 0x40500000
	.long 0x0
	.align 2
.LC23:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl turret_breach_think
	.type	 turret_breach_think,@function
turret_breach_think:
	stwu 1,-256(1)
	mflr 0
	stfd 30,240(1)
	stfd 31,248(1)
	stmw 24,208(1)
	stw 0,260(1)
	lis 9,.LC6@ha
	mr 31,3
	la 9,.LC6@l(9)
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
	lis 10,.LC6@ha
	fmr 0,11
	la 10,.LC6@l(10)
	lfs 13,0(10)
.L34:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L34
	stfs 0,0(9)
.L35:
	lis 11,.LC7@ha
	lfs 13,0(9)
	addi 30,31,628
	la 11,.LC7@l(11)
	addi 4,31,388
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L149
	lis 10,.LC6@ha
	lis 11,.LC7@ha
	la 10,.LC6@l(10)
	la 11,.LC7@l(11)
	lfs 11,0(10)
	lfs 12,0(11)
.L38:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L38
	stfs 0,0(9)
.L149:
	lis 10,.LC6@ha
	lfs 13,4(9)
	la 10,.LC6@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L150
	lis 11,.LC6@ha
	la 11,.LC6@l(11)
	lfs 12,0(11)
.L42:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L42
	stfs 0,4(9)
.L150:
	lis 10,.LC7@ha
	lfs 13,4(9)
	la 10,.LC7@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L151
	lis 11,.LC6@ha
	lis 10,.LC7@ha
	la 11,.LC6@l(11)
	la 10,.LC7@l(10)
	lfs 11,0(11)
	lfs 12,0(10)
.L46:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L46
	stfs 0,4(9)
.L151:
	lis 11,.LC6@ha
	lfs 13,628(31)
	la 11,.LC6@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L52
	lis 9,.LC6@ha
	lfs 0,0(30)
	la 9,.LC6@l(9)
	lfs 13,0(9)
.L51:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L51
	stfs 0,0(30)
.L52:
	lis 10,.LC7@ha
	lfs 13,0(30)
	la 10,.LC7@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L152
	lis 11,.LC6@ha
	lis 9,.LC7@ha
	la 11,.LC6@l(11)
	la 9,.LC7@l(9)
	lfs 11,0(11)
	lfs 12,0(9)
.L55:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L55
	stfs 0,0(30)
.L152:
	lis 10,.LC6@ha
	lfs 13,4(30)
	la 10,.LC6@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L153
	lis 11,.LC6@ha
	la 11,.LC6@l(11)
	lfs 12,0(11)
.L59:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L59
	stfs 0,4(30)
.L153:
	lis 9,.LC7@ha
	lfs 13,4(30)
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L154
	lis 10,.LC6@ha
	lis 11,.LC7@ha
	la 10,.LC6@l(10)
	la 11,.LC7@l(11)
	lfs 11,0(10)
	lfs 12,0(11)
.L63:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L63
	stfs 0,4(30)
.L154:
	lis 9,.LC8@ha
	lfs 13,628(31)
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L66
	lis 10,.LC6@ha
	la 10,.LC6@l(10)
	lfs 0,0(10)
	fsubs 0,13,0
	stfs 0,628(31)
.L66:
	lfs 13,628(31)
	lfs 0,352(31)
	fcmpu 0,13,0
	bc 12,1,.L172
	lfs 0,364(31)
	fcmpu 0,13,0
	bc 4,0,.L68
.L172:
	stfs 0,628(31)
.L68:
	lfs 13,632(31)
	lfs 0,356(31)
	lfs 10,368(31)
	fmr 12,13
	fcmpu 0,13,0
	fmr 9,0
	bc 12,0,.L71
	fcmpu 0,12,10
	bc 4,1,.L70
.L71:
	fsubs 0,9,12
	lis 11,.LC9@ha
	la 11,.LC9@l(11)
	lfs 13,0(11)
	fabs 11,0
	fcmpu 0,11,13
	bc 4,0,.L72
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fadds 11,11,0
	b .L73
.L72:
	lis 10,.LC8@ha
	la 10,.LC8@l(10)
	lfs 0,0(10)
	fcmpu 0,11,0
	bc 4,1,.L73
	lis 11,.LC6@ha
	la 11,.LC6@l(11)
	lfs 0,0(11)
	fsubs 11,11,0
.L73:
	fsubs 0,10,12
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 13,0(9)
	fabs 12,0
	fcmpu 0,12,13
	bc 4,0,.L75
	lis 10,.LC6@ha
	la 10,.LC6@l(10)
	lfs 0,0(10)
	fadds 12,12,0
	b .L76
.L75:
	lis 11,.LC8@ha
	la 11,.LC8@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 4,1,.L76
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fsubs 12,12,0
.L76:
	fmr 13,11
	fmr 0,12
	fabs 13,13
	fabs 0,0
	fcmpu 0,13,0
	bc 4,0,.L78
	stfs 9,632(31)
	b .L70
.L78:
	stfs 10,632(31)
.L70:
	lfs 11,628(31)
	lis 10,.LC9@ha
	lfs 0,8(1)
	la 10,.LC9@l(10)
	lfs 10,0(10)
	lfs 13,632(31)
	fsubs 9,11,0
	lfs 12,12(1)
	lfs 0,636(31)
	lfs 11,16(1)
	fcmpu 0,9,10
	stfs 9,24(1)
	fsubs 13,13,12
	fsubs 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bc 4,0,.L80
	lis 11,.LC6@ha
	la 11,.LC6@l(11)
	lfs 0,0(11)
	fadds 0,9,0
	b .L173
.L80:
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,9,0
	bc 4,1,.L81
	lis 10,.LC6@ha
	la 10,.LC6@l(10)
	lfs 0,0(10)
	fsubs 0,9,0
.L173:
	stfs 0,24(1)
.L81:
	lis 11,.LC9@ha
	lfs 13,28(1)
	la 11,.LC9@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L83
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L174
.L83:
	lis 10,.LC8@ha
	la 10,.LC8@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L84
	lis 11,.LC6@ha
	la 11,.LC6@l(11)
	lfs 0,0(11)
	fsubs 0,13,0
.L174:
	stfs 0,28(1)
.L84:
	lfs 13,328(31)
	lis 9,.LC1@ha
	li 0,0
	lfd 31,.LC1@l(9)
	lfs 0,24(1)
	stw 0,32(1)
	fmul 13,13,31
	fcmpu 0,0,13
	bc 4,1,.L86
	frsp 0,13
	stfs 0,24(1)
.L86:
	lfs 0,328(31)
	lfs 13,24(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L87
	frsp 0,0
	stfs 0,24(1)
.L87:
	lfs 0,328(31)
	lfs 13,28(1)
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,1,.L88
	frsp 0,0
	stfs 0,28(1)
.L88:
	lfs 0,328(31)
	lfs 13,28(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L89
	frsp 0,0
	stfs 0,28(1)
.L89:
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 1,0(9)
	bl VectorScale
	lis 9,level+4@ha
	lwz 11,564(31)
	lfs 0,level+4@l(9)
	cmpwi 0,11,0
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L91
.L93:
	lfs 0,392(31)
	stfs 0,392(11)
	lwz 11,560(11)
	cmpwi 0,11,0
	bc 4,2,.L93
.L91:
	lwz 11,256(31)
	cmpwi 0,11,0
	bc 12,2,.L95
	lwz 0,324(11)
	cmpw 0,0,31
	bc 4,2,.L96
	lfs 0,388(31)
	lis 9,.LC2@ha
	lfd 12,.LC2@l(9)
	stfs 0,388(11)
	lfs 0,392(31)
	lwz 9,256(31)
	stfs 0,392(9)
	lwz 11,256(31)
	lfs 13,20(31)
	lfs 0,620(11)
	lfs 31,4(31)
	fadds 30,13,0
	fmr 0,30
	fmul 0,0,12
	frsp 30,0
	fmr 1,30
	bl cos
	lwz 9,256(31)
	lis 10,.LC11@ha
	lis 11,.LC12@ha
	la 10,.LC11@l(10)
	la 11,.LC12@l(11)
	lfs 0,616(9)
	lfd 13,0(10)
	lfd 12,0(11)
	fmadd 1,1,0,31
	frsp 0,1
	fmul 0,0,13
	frsp 0,0
	fmr 1,0
	fcmpu 0,1,12
	bc 4,1,.L97
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L175
.L97:
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L175:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lfs 31,8(31)
	mr 11,9
	lis 10,.LC14@ha
	fmr 1,30
	la 10,.LC14@l(10)
	fctiwz 0,13
	lfd 11,0(10)
	lis 10,.LC15@ha
	la 10,.LC15@l(10)
	stfd 0,200(1)
	lwz 9,204(1)
	lfd 12,0(10)
	xoris 9,9,0x8000
	stw 9,204(1)
	stw 0,200(1)
	lfd 0,200(1)
	fsub 0,0,11
	fmul 0,0,12
	frsp 0,0
	stfs 0,56(1)
	bl sin
	lwz 9,256(31)
	lis 10,.LC11@ha
	lis 11,.LC12@ha
	la 10,.LC11@l(10)
	la 11,.LC12@l(11)
	lfs 0,616(9)
	lfd 13,0(10)
	lfd 12,0(11)
	fmadd 1,1,0,31
	frsp 0,1
	fmul 0,0,13
	frsp 0,0
	fmr 1,0
	fcmpu 0,1,12
	bc 4,1,.L100
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L176
.L100:
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L176:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 7,256(31)
	mr 8,10
	lis 11,.LC14@ha
	lfs 10,56(1)
	la 11,.LC14@l(11)
	lis 9,.LC15@ha
	fctiwz 0,13
	lfd 11,0(11)
	la 9,.LC15@l(9)
	lfd 12,0(9)
	lis 11,.LC1@ha
	lfd 9,.LC1@l(11)
	lis 9,.LC2@ha
	stfd 0,200(1)
	lwz 10,204(1)
	lfd 8,.LC2@l(9)
	xoris 10,10,0x8000
	stw 10,204(1)
	stw 0,200(1)
	lfd 0,200(1)
	fsub 0,0,11
	fmul 0,0,12
	frsp 0,0
	stfs 0,60(1)
	lfs 11,12(7)
	stfs 11,64(1)
	lfs 12,4(7)
	fsubs 10,10,12
	fmr 13,10
	stfs 10,40(1)
	lfs 12,8(7)
	fdiv 13,13,9
	fsubs 0,0,12
	frsp 13,13
	stfs 0,44(1)
	lfs 12,12(7)
	fsubs 11,11,12
	stfs 11,48(1)
	stfs 13,376(7)
	lfs 0,44(1)
	lwz 9,256(31)
	fdiv 0,0,9
	frsp 0,0
	stfs 0,380(9)
	lfs 13,16(31)
	fmul 13,13,8
	frsp 30,13
	fmr 1,30
	bl tan
	lwz 9,256(31)
	lis 10,.LC11@ha
	lis 11,.LC12@ha
	lfs 12,12(31)
	la 10,.LC11@l(10)
	la 11,.LC12@l(11)
	lfs 13,616(9)
	lfs 0,624(9)
	lfd 11,0(10)
	lfd 10,0(11)
	fmadd 13,13,1,12
	fadd 13,13,0
	frsp 0,13
	fmul 0,0,11
	frsp 0,0
	fmr 13,0
	fcmpu 0,13,10
	bc 4,1,.L103
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfd 0,0(9)
	fadd 0,13,0
	b .L177
.L103:
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
	lfd 0,0(10)
	fsub 0,13,0
.L177:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 8,256(31)
	mr 10,9
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	lfs 9,12(8)
	fctiwz 0,13
	lfd 10,0(11)
	lis 11,.LC15@ha
	la 11,.LC15@l(11)
	stfd 0,200(1)
	lwz 9,204(1)
	lfd 12,0(11)
	xoris 9,9,0x8000
	lis 11,.LC1@ha
	stw 9,204(1)
	stw 0,200(1)
	lfd 0,200(1)
	lfd 11,.LC1@l(11)
	fsub 0,0,10
	fmul 0,0,12
	frsp 0,0
	fsubs 0,0,9
	fmr 13,0
	fdiv 13,13,11
	frsp 13,13
	stfs 13,384(8)
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L140
	addi 6,1,104
	addi 4,1,72
	addi 5,1,88
	addi 3,31,16
	bl AngleVectors
	lfs 1,616(31)
	addi 4,1,72
	addi 5,1,120
	addi 3,31,4
	bl VectorMA
	lfs 1,620(31)
	addi 3,1,120
	addi 4,1,88
	mr 5,3
	bl VectorMA
	lfs 1,624(31)
	addi 3,1,120
	addi 4,1,104
	mr 5,3
	bl VectorMA
	lwz 9,564(31)
	addi 4,1,120
	addi 5,1,72
	li 6,125
	li 7,650
	lwz 3,256(9)
	li 8,125
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 1,0(9)
	bl fire_rocket
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,20(29)
	lis 9,.LC17@ha
	lis 10,.LC17@ha
	lis 11,.LC7@ha
	mr 6,3
	la 9,.LC17@l(9)
	la 10,.LC17@l(10)
	mtlr 0
	la 11,.LC7@l(11)
	mr 4,31
	lfs 1,0(9)
	addi 3,1,120
	li 5,1
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	lwz 0,284(31)
	rlwinm 0,0,0,16,14
	stw 0,284(31)
	b .L140
.L96:
	li 0,3
	addi 28,31,16
	mtctr 0
	addi 29,1,56
	mr 8,30
	li 10,0
.L171:
	lwz 9,256(31)
	lwz 11,84(9)
	addi 11,11,3668
	lfsx 0,11,10
	stfsx 0,10,8
	addi 10,10,4
	bdnz .L171
	lis 9,.LC6@ha
	lfs 13,628(31)
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L117
	lis 10,.LC6@ha
	lfs 0,0(30)
	la 10,.LC6@l(10)
	lfs 13,0(10)
.L116:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L116
	stfs 0,0(30)
.L117:
	lis 11,.LC7@ha
	lfs 13,0(30)
	la 11,.LC7@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L155
	lis 9,.LC6@ha
	lis 10,.LC7@ha
	la 9,.LC6@l(9)
	la 10,.LC7@l(10)
	lfs 11,0(9)
	lfs 12,0(10)
.L120:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L120
	stfs 0,0(30)
.L155:
	lis 11,.LC6@ha
	lfs 13,4(30)
	la 11,.LC6@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L156
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 12,0(9)
.L124:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L124
	stfs 0,4(30)
.L156:
	lis 10,.LC7@ha
	lfs 13,4(30)
	la 10,.LC7@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L157
	lis 11,.LC6@ha
	lis 9,.LC7@ha
	la 11,.LC6@l(11)
	la 9,.LC7@l(9)
	lfs 11,0(11)
	lfs 12,0(9)
.L128:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L128
	stfs 0,4(30)
.L157:
	li 5,0
	li 6,0
	mr 3,28
	mr 4,29
	bl AngleVectors
	lis 9,.LC18@ha
	mr 4,29
	la 9,.LC18@l(9)
	mr 3,29
	lfs 1,0(9)
	bl VectorScale
	lfs 11,56(1)
	lis 9,.LC7@ha
	lis 10,.LC7@ha
	lfs 12,4(31)
	lis 11,.LC19@ha
	la 9,.LC7@l(9)
	lfs 13,8(31)
	la 10,.LC7@l(10)
	la 11,.LC19@l(11)
	lfs 10,60(1)
	fsubs 12,12,11
	lfs 0,12(31)
	lfs 11,64(1)
	fsubs 13,13,10
	lfs 1,0(9)
	lfs 2,0(10)
	fsubs 0,0,11
	lfs 3,0(11)
	stfs 13,44(1)
	stfs 12,40(1)
	stfs 0,48(1)
	bl tv
	lfs 0,40(1)
	lis 9,.LC7@ha
	lis 10,.LC7@ha
	lfs 13,0(3)
	la 9,.LC7@l(9)
	lis 11,.LC19@ha
	lfs 1,0(9)
	la 10,.LC7@l(10)
	la 11,.LC19@l(11)
	lfs 2,0(10)
	fadds 0,0,13
	lfs 3,0(11)
	lwz 9,256(31)
	stfs 0,4(9)
	bl tv
	lfs 13,4(3)
	lis 9,.LC7@ha
	lis 10,.LC7@ha
	lfs 0,44(1)
	la 9,.LC7@l(9)
	lis 11,.LC19@ha
	lfs 1,0(9)
	la 10,.LC7@l(10)
	la 11,.LC19@l(11)
	lfs 3,0(11)
	fadds 0,0,13
	lwz 9,256(31)
	lfs 2,0(10)
	stfs 0,8(9)
	bl tv
	lfs 13,8(3)
	lis 9,gi@ha
	lfs 0,48(1)
	la 30,gi@l(9)
	lwz 11,256(31)
	fadds 0,0,13
	stfs 0,12(11)
	lwz 9,72(30)
	lwz 3,256(31)
	mtlr 9
	blrl
	lwz 9,256(31)
	lwz 11,84(9)
	lwz 0,3548(11)
	andi. 9,0,2
	bc 12,2,.L131
	lis 9,level@ha
	lfs 13,596(31)
	la 27,level@l(9)
	lfs 0,4(27)
	fcmpu 0,13,0
	bc 4,0,.L131
	addi 6,1,168
	addi 4,1,136
	addi 5,1,152
	mr 3,28
	bl AngleVectors
	lfs 1,616(31)
	addi 4,1,136
	addi 5,1,184
	addi 3,31,4
	bl VectorMA
	lfs 1,620(31)
	addi 3,1,184
	addi 4,1,152
	mr 5,3
	bl VectorMA
	lfs 1,624(31)
	addi 3,1,184
	addi 4,1,168
	mr 5,3
	bl VectorMA
	lwz 9,564(31)
	addi 4,1,184
	addi 5,1,136
	li 6,125
	li 7,650
	lwz 3,256(9)
	li 8,125
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 1,0(9)
	bl fire_rocket
	lwz 9,36(30)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	mtlr 9
	blrl
	lwz 0,20(30)
	lis 9,.LC17@ha
	lis 10,.LC17@ha
	lis 11,.LC7@ha
	la 9,.LC17@l(9)
	mr 6,3
	la 10,.LC17@l(10)
	lfs 1,0(9)
	mtlr 0
	la 11,.LC7@l(11)
	mr 4,31
	lfs 2,0(10)
	addi 3,1,184
	li 5,1
	lfs 3,0(11)
	blrl
	lis 9,.LC17@ha
	lfs 0,4(27)
	la 9,.LC17@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,596(31)
.L131:
	lwz 30,256(31)
	lwz 9,84(30)
	lha 0,14(9)
	cmpwi 0,0,30
	bc 4,1,.L140
	li 0,0
	mr 3,28
	stw 0,628(31)
	mr 4,29
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC20@ha
	mr 3,29
	la 9,.LC20@l(9)
	mr 4,29
	lfs 1,0(9)
	bl VectorScale
	lis 10,.LC16@ha
	lfs 0,64(1)
	lis 9,.LC21@ha
	la 10,.LC16@l(10)
	la 9,.LC21@l(9)
	lfs 13,0(10)
	lfs 12,0(9)
	fadds 0,0,13
	fcmpu 0,0,12
	stfs 0,64(1)
	bc 4,0,.L134
	stfs 12,64(1)
.L134:
	li 0,3
	mr 3,29
	mtctr 0
	addi 11,30,376
	li 9,0
.L170:
	lfsx 0,9,3
	stfsx 0,9,11
	addi 9,9,4
	bdnz .L170
	lis 9,.LC17@ha
	lfs 0,12(30)
	li 0,4
	la 9,.LC17@l(9)
	lis 29,gi@ha
	stw 0,260(30)
	lfs 13,0(9)
	la 29,gi@l(29)
	li 3,11
	fadds 0,0,13
	stfs 13,408(30)
	stfs 0,12(30)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	mtlr 9
	blrl
	lwz 9,92(29)
	mr 3,30
	li 4,1
	mtlr 9
	blrl
	lwz 0,72(29)
	mr 3,30
	mtlr 0
	blrl
	li 0,0
	stw 0,256(31)
	b .L140
.L95:
	lis 10,.LC7@ha
	lis 9,maxclients@ha
	la 10,.LC7@l(10)
	lis 11,g_edicts@ha
	lfs 13,0(10)
	li 27,0
	lis 24,maxclients@ha
	lwz 10,maxclients@l(9)
	lwz 29,g_edicts@l(11)
	lfs 0,20(10)
	addi 29,29,904
	fcmpu 0,13,0
	bc 4,0,.L140
	lis 9,gi@ha
	addi 28,1,56
	la 30,gi@l(9)
	li 26,0
	lis 25,0x4330
.L144:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L143
	addi 3,31,16
	mr 4,28
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC18@ha
	mr 3,28
	la 9,.LC18@l(9)
	mr 4,28
	lfs 1,0(9)
	bl VectorScale
	lfs 13,4(31)
	lis 9,.LC22@ha
	lfs 0,56(1)
	la 9,.LC22@l(9)
	lfs 11,8(31)
	lfs 12,12(31)
	fsubs 13,13,0
	lfs 10,60(1)
	lfs 0,64(1)
	lfd 9,0(9)
	fsubs 11,11,10
	stfs 13,40(1)
	fsubs 12,12,0
	stfs 11,44(1)
	stfs 12,48(1)
	lfs 0,4(29)
	fsubs 13,13,0
	stfs 13,72(1)
	lfs 0,8(29)
	fsubs 11,11,0
	stfs 11,76(1)
	lfs 13,12(29)
	fsubs 12,12,13
	fmr 0,12
	stfs 12,80(1)
	fabs 0,0
	fcmpu 0,0,9
	bc 4,0,.L146
	stw 26,80(1)
.L146:
	addi 3,1,72
	bl VectorLength
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L143
	li 0,2
	stw 29,256(31)
	li 3,11
	stw 0,260(29)
	stw 26,408(29)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,116(30)
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	mtlr 9
	blrl
	lwz 9,92(30)
	li 4,1
	mr 3,29
	mtlr 9
	blrl
	lwz 9,72(30)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,12(30)
	lis 4,.LC5@ha
	mr 3,29
	la 4,.LC5@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
.L143:
	addi 27,27,1
	lwz 11,maxclients@l(24)
	xoris 0,27,0x8000
	lis 10,.LC14@ha
	stw 0,204(1)
	la 10,.LC14@l(10)
	addi 29,29,904
	stw 25,200(1)
	lfd 13,0(10)
	lfd 0,200(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L144
.L140:
	lwz 0,260(1)
	mtlr 0
	lmw 24,208(1)
	lfd 30,240(1)
	lfd 31,248(1)
	la 1,256(1)
	blr
.Lfe1:
	.size	 turret_breach_think,.Lfe1-turret_breach_think
	.section	".rodata"
	.align 2
.LC24:
	.string	"%s at %s needs a target\n"
	.align 3
.LC25:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC26:
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
	stw 11,260(31)
	lwz 9,44(30)
	lwz 4,268(31)
	mtlr 9
	blrl
	lis 9,.LC26@ha
	lfs 0,328(31)
	la 9,.LC26@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L182
	lis 0,0x4248
	stw 0,328(31)
.L182:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L183
	li 0,10
	stw 0,516(31)
.L183:
	lis 9,st@ha
	la 7,st@l(9)
	lfs 0,60(7)
	fcmpu 0,0,13
	bc 4,2,.L184
	lis 0,0xc1f0
	stw 0,60(7)
.L184:
	lfs 0,64(7)
	fcmpu 0,0,13
	bc 4,2,.L185
	lis 0,0x41f0
	stw 0,64(7)
.L185:
	lfs 0,56(7)
	fcmpu 0,0,13
	bc 4,2,.L186
	lis 0,0x43b4
	stw 0,56(7)
.L186:
	lfs 0,60(7)
	lis 11,turret_blocked@ha
	lis 10,turret_breach_finish_init@ha
	lfs 11,20(31)
	la 11,turret_blocked@l(11)
	la 10,turret_breach_finish_init@l(10)
	lis 8,level+4@ha
	lis 9,.LC25@ha
	fneg 0,0
	lfd 12,.LC25@l(9)
	mr 3,31
	stfs 0,352(31)
	lfs 13,52(7)
	stfs 13,356(31)
	lfs 0,64(7)
	fneg 0,0
	stfs 0,364(31)
	lfs 13,56(7)
	stfs 11,632(31)
	stw 11,440(31)
	stfs 13,368(31)
	stw 10,436(31)
	stfs 11,424(31)
	lfs 0,level+4@l(8)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 SP_turret_breach,.Lfe2-SP_turret_breach
	.section	".rodata"
	.align 3
.LC27:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC28:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC29:
	.long 0x40400000
	.align 3
.LC30:
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
	lis 11,.LC27@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC27@l(11)
	lwz 9,540(31)
	cmpwi 0,9,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L205
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L196
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 12,1,.L195
.L196:
	li 0,0
	stw 0,540(31)
.L195:
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 4,2,.L197
.L205:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 12,2,.L194
	lis 9,level+4@ha
	lwz 0,776(31)
	lfs 0,level+4@l(9)
	rlwinm 0,0,0,29,27
	b .L206
.L197:
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L200
	lwz 0,776(31)
	ori 0,0,8
	stw 0,776(31)
	b .L194
.L200:
	lwz 0,776(31)
	andi. 9,0,8
	bc 12,2,.L199
	lis 9,level+4@ha
	rlwinm 0,0,0,29,27
	lfs 0,level+4@l(9)
.L206:
	stw 0,776(31)
	stfs 0,852(31)
.L199:
	lwz 9,540(31)
	lis 10,.LC28@ha
	la 10,.LC28@l(10)
	lis 8,0x4330
	lfs 12,4(9)
	addi 3,1,24
	lfd 10,0(10)
	lwz 10,324(31)
	stfs 12,8(1)
	lfs 11,8(9)
	addi 4,10,628
	stfs 11,12(1)
	lfs 13,12(9)
	stfs 13,16(1)
	lwz 0,508(9)
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
	lfs 0,832(31)
	lfs 11,level+4@l(9)
	fcmpu 0,11,0
	bc 12,0,.L194
	lis 9,.LC29@ha
	lis 11,skill@ha
	lfs 13,852(31)
	la 9,.LC29@l(9)
	lfs 12,0(9)
	lwz 9,skill@l(11)
	fsubs 13,11,13
	lfs 0,20(9)
	fsubs 0,12,0
	fcmpu 0,13,0
	bc 12,0,.L194
	fadds 0,11,0
	lis 10,.LC30@ha
	lwz 9,324(31)
	la 10,.LC30@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,832(31)
	lwz 0,284(9)
	oris 0,0,0x1
	stw 0,284(9)
.L194:
	lwz 0,68(1)
	mtlr 0
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 turret_driver_think,.Lfe3-turret_driver_think
	.section	".rodata"
	.align 3
.LC31:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC32:
	.long 0x43b40000
	.align 2
.LC33:
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
	lwz 3,296(31)
	stw 9,436(31)
	lis 11,.LC31@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC31@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bl G_PickTarget
	mr 11,3
	li 0,0
	stw 11,324(31)
	addi 3,1,8
	stw 31,256(11)
	lwz 9,324(31)
	lwz 11,564(9)
	stw 31,256(11)
	lwz 9,324(31)
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
	lwz 9,324(31)
	addi 3,1,8
	stfs 1,616(31)
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
	lis 11,.LC32@ha
	lfs 13,8(1)
	addi 9,1,8
	la 11,.LC32@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L211
	lis 11,.LC32@ha
	fmr 0,13
	la 11,.LC32@l(11)
	lfs 13,0(11)
.L210:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L210
	stfs 0,0(9)
.L211:
	lis 11,.LC33@ha
	lfs 13,0(9)
	la 11,.LC33@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L230
	lis 11,.LC32@ha
	la 11,.LC32@l(11)
	lfs 11,0(11)
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	lfs 12,0(11)
.L214:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L214
	stfs 0,0(9)
.L230:
	lis 11,.LC32@ha
	lfs 13,4(9)
	la 11,.LC32@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L231
	lis 11,.LC32@ha
	la 11,.LC32@l(11)
	lfs 12,0(11)
.L218:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L218
	stfs 0,4(9)
.L231:
	lis 11,.LC33@ha
	lfs 13,4(9)
	la 11,.LC33@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L232
	lis 11,.LC32@ha
	la 11,.LC32@l(11)
	lfs 11,0(11)
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	lfs 12,0(11)
.L222:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L222
	stfs 0,4(9)
.L232:
	lfs 0,12(1)
	lwz 9,324(31)
	stfs 0,620(31)
	lfs 13,12(9)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,624(31)
	lwz 9,564(9)
	b .L237
.L227:
	lwz 9,560(9)
.L237:
	lwz 0,560(9)
	cmpwi 0,0,0
	bc 4,2,.L227
	stw 31,560(9)
	lwz 9,324(31)
	lwz 0,264(31)
	lwz 11,564(9)
	ori 0,0,1024
	stw 0,264(31)
	stw 11,564(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 turret_driver_link,.Lfe4-turret_driver_link
	.section	".rodata"
	.align 2
.LC34:
	.string	"models/monsters/infantry/tris.md2"
	.align 2
.LC35:
	.string	"%s at %s has bad item: %s\n"
	.align 3
.LC36:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_turret_driver
	.type	 SP_turret_driver,@function
SP_turret_driver:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	li 29,2
	lis 9,gi@ha
	stw 29,260(31)
	lis 3,.LC34@ha
	la 27,gi@l(9)
	stw 29,248(31)
	la 3,.LC34@l(3)
	lwz 9,32(27)
	mtlr 9
	blrl
	lis 9,turret_driver_die@ha
	lwz 6,264(31)
	lis 0,0xc1c0
	la 9,turret_driver_die@l(9)
	stw 3,40(31)
	lis 7,infantry_stand@ha
	stw 9,456(31)
	lis 3,0x4180
	lis 28,0xc180
	lis 9,0x4200
	stw 0,196(31)
	li 10,100
	stw 9,208(31)
	li 0,200
	la 7,infantry_stand@l(7)
	lis 9,st@ha
	ori 6,6,2048
	stw 10,480(31)
	li 5,0
	li 4,24
	stw 0,400(31)
	lis 11,level@ha
	stw 28,192(31)
	la 30,st@l(9)
	stw 3,204(31)
	la 11,level@l(11)
	lis 8,monster_use@ha
	stw 5,488(31)
	lis 10,0x202
	la 8,monster_use@l(8)
	stw 4,508(31)
	ori 10,10,3
	stw 7,788(31)
	stw 6,264(31)
	stw 28,188(31)
	stw 3,200(31)
	lwz 9,284(11)
	addi 9,9,1
	stw 9,284(11)
	lwz 0,184(31)
	lwz 9,68(31)
	lwz 11,776(31)
	ori 0,0,4
	lfs 12,4(31)
	ori 9,9,64
	lfs 13,8(31)
	ori 11,11,2049
	lfs 0,12(31)
	stw 0,184(31)
	stw 9,68(31)
	stw 29,512(31)
	stw 8,448(31)
	stw 10,252(31)
	stfs 12,28(31)
	stfs 13,32(31)
	stfs 0,36(31)
	stw 11,776(31)
	lwz 3,44(30)
	cmpwi 0,3,0
	bc 12,2,.L239
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,648(31)
	bc 4,2,.L239
	lwz 29,280(31)
	addi 3,31,4
	bl vtos
	mr 5,3
	lwz 0,4(27)
	mr 4,29
	lis 3,.LC35@ha
	lwz 6,44(30)
	la 3,.LC35@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L239:
	lis 9,turret_driver_link@ha
	lis 10,level+4@ha
	la 9,turret_driver_link@l(9)
	lis 11,.LC36@ha
	stw 9,436(31)
	lis 8,gi+72@ha
	mr 3,31
	lfs 0,level+4@l(10)
	lfd 13,.LC36@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 SP_turret_driver,.Lfe5-SP_turret_driver
	.globl infantry_frames_stand
	.section	".data"
	.align 2
	.type	 infantry_frames_stand,@object
infantry_frames_stand:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 infantry_frames_stand,264
	.globl infantry_move_stand
	.align 2
	.type	 infantry_move_stand,@object
	.size	 infantry_move_stand,16
infantry_move_stand:
	.long 50
	.long 71
	.long infantry_frames_stand
	.long 0
	.comm	maplist,292,4
	.section	".rodata"
	.align 2
.LC37:
	.long 0x43b40000
	.align 2
.LC38:
	.long 0x0
	.section	".text"
	.align 2
	.globl AnglesNormalize
	.type	 AnglesNormalize,@function
AnglesNormalize:
	lis 9,.LC37@ha
	lfs 13,0(3)
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L8
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 12,0(9)
.L9:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L9
	stfs 0,0(3)
.L8:
	lis 9,.LC38@ha
	lfs 13,0(3)
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L242
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 11,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 12,0(9)
.L13:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L13
	stfs 0,0(3)
.L242:
	lis 9,.LC37@ha
	lfs 13,4(3)
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L243
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 12,0(9)
.L17:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L17
	stfs 0,4(3)
.L243:
	lis 9,.LC38@ha
	lfs 13,4(3)
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bclr 4,0
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 11,0(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
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
.LC39:
	.long 0x40200000
	.long 0x0
	.align 3
.LC40:
	.long 0x0
	.long 0x0
	.align 3
.LC41:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC43:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SnapToEights
	.type	 SnapToEights,@function
SnapToEights:
	stwu 1,-16(1)
	lis 9,.LC39@ha
	lis 10,.LC40@ha
	la 9,.LC39@l(9)
	la 10,.LC40@l(10)
	lfd 0,0(9)
	lfd 13,0(10)
	fmul 1,1,0
	frsp 0,1
	fmr 1,0
	fcmpu 0,1,13
	bc 4,1,.L24
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L249
.L24:
	lis 10,.LC41@ha
	la 10,.LC41@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L249:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	mr 11,9
	lis 10,.LC42@ha
	la 10,.LC42@l(10)
	fctiwz 0,13
	lfd 12,0(10)
	lis 10,.LC43@ha
	la 10,.LC43@l(10)
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
	lwz 0,512(4)
	mr 9,3
	cmpwi 0,0,0
	bc 12,2,.L27
	lwz 11,564(9)
	mr 3,4
	li 10,0
	mr 4,9
	lis 6,vec3_origin@ha
	lwz 5,256(11)
	la 6,vec3_origin@l(6)
	li 29,20
	lwz 9,516(11)
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
	.section	".rodata"
	.align 2
.LC44:
	.long 0x43160000
	.align 2
.LC45:
	.long 0x3f800000
	.align 2
.LC46:
	.long 0x0
	.section	".text"
	.align 2
	.globl turret_breach_fire
	.type	 turret_breach_fire,@function
turret_breach_fire:
	stwu 1,-96(1)
	mflr 0
	stmw 26,72(1)
	stw 0,100(1)
	addi 29,1,24
	addi 26,1,40
	mr 27,3
	addi 28,1,56
	addi 4,1,8
	mr 6,26
	mr 5,29
	addi 3,27,16
	bl AngleVectors
	lfs 1,616(27)
	addi 4,1,8
	addi 3,27,4
	mr 5,28
	bl VectorMA
	lfs 1,620(27)
	mr 4,29
	mr 3,28
	mr 5,28
	bl VectorMA
	lfs 1,624(27)
	mr 4,26
	mr 3,28
	mr 5,28
	bl VectorMA
	lwz 9,564(27)
	mr 4,28
	addi 5,1,8
	li 6,125
	li 7,650
	lwz 3,256(9)
	li 8,125
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 1,0(9)
	bl fire_rocket
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC45@ha
	lwz 0,20(29)
	mr 6,3
	la 9,.LC45@l(9)
	mr 4,27
	lfs 1,0(9)
	mr 3,28
	li 5,1
	mtlr 0
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 2,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 26,72(1)
	la 1,96(1)
	blr
.Lfe9:
	.size	 turret_breach_fire,.Lfe9-turret_breach_fire
	.align 2
	.globl turret_breach_finish_init
	.type	 turret_breach_finish_init,@function
turret_breach_finish_init:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,296(31)
	cmpwi 0,3,0
	bc 4,2,.L179
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L180
.L179:
	bl G_PickTarget
	mr 9,3
	lfs 0,4(31)
	stw 9,324(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,616(31)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,620(31)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,624(31)
	bl G_FreeEdict
.L180:
	lis 9,turret_breach_think@ha
	lwz 11,564(31)
	mr 3,31
	la 9,turret_breach_think@l(9)
	lwz 0,516(31)
	mtlr 9
	stw 0,516(11)
	stw 9,436(31)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 turret_breach_finish_init,.Lfe10-turret_breach_finish_init
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
	stw 9,260(29)
	lwz 9,44(28)
	lwz 4,268(29)
	mtlr 9
	blrl
	lis 9,turret_blocked@ha
	mr 3,29
	la 9,turret_blocked@l(9)
	stw 9,440(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 SP_turret_base,.Lfe11-SP_turret_base
	.align 2
	.globl infantry_stand
	.type	 infantry_stand,@function
infantry_stand:
	lis 9,infantry_move_stand@ha
	la 9,infantry_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe12:
	.size	 infantry_stand,.Lfe12-infantry_stand
	.align 2
	.globl turret_driver_die
	.type	 turret_driver_die,@function
turret_driver_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 8,3
	li 0,0
	lwz 9,324(8)
	stw 0,628(9)
	lwz 11,324(8)
	lwz 9,564(11)
	b .L250
.L191:
	lwz 9,560(9)
.L250:
	lwz 0,560(9)
	cmpw 0,0,8
	bc 4,2,.L191
	li 10,0
	mr 3,8
	stw 10,560(9)
	lwz 0,264(8)
	lwz 11,324(8)
	rlwinm 0,0,0,22,20
	stw 10,564(8)
	stw 0,264(8)
	stw 10,256(11)
	lwz 9,324(8)
	lwz 11,564(9)
	stw 10,256(11)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 turret_driver_die,.Lfe13-turret_driver_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
