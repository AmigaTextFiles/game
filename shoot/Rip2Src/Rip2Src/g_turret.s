	.file	"g_turret.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"weapons/rocklf1a.wav"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC3:
	.long 0x42480000
	.align 2
.LC4:
	.long 0x42c80000
	.align 2
.LC5:
	.long 0x43160000
	.align 2
.LC6:
	.long 0x3f800000
	.align 2
.LC7:
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
	mr 5,28
	mr 3,28
	bl VectorMA
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,564(27)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 8,.LC2@ha
	lis 11,.LC0@ha
	stw 0,80(1)
	la 8,.LC2@l(8)
	lfd 13,0(8)
	mr 4,28
	addi 5,1,8
	lfd 0,80(1)
	lis 8,.LC3@ha
	li 7,750
	lfs 11,.LC0@l(11)
	lis 9,.LC4@ha
	la 8,.LC3@l(8)
	la 9,.LC4@l(9)
	lfs 9,0(8)
	lis 11,.LC5@ha
	fsub 0,0,13
	lfs 10,0(9)
	la 11,.LC5@l(11)
	lfs 1,0(11)
	lwz 3,256(10)
	frsp 0,0
	fdivs 0,0,11
	fmadds 0,0,9,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,80(1)
	lwz 6,84(1)
	mr 8,6
	bl fire_rocket
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,20(29)
	lis 8,.LC6@ha
	lis 9,.LC6@ha
	lis 11,.LC7@ha
	mr 6,3
	la 8,.LC6@l(8)
	la 9,.LC6@l(9)
	mtlr 0
	la 11,.LC7@l(11)
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
	.align 2
.LC10:
	.string	"cl_predict 0\n"
	.align 2
.LC11:
	.string	"Only scientist can drive turrets\n"
	.align 2
.LC12:
	.string	"Turret mounted\n\nPress attack to fire, JUMP to abandon"
	.align 3
.LC8:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC9:
	.long 0x3f91df46
	.long 0xa2529d39
	.align 2
.LC13:
	.long 0x43b40000
	.align 2
.LC14:
	.long 0x0
	.align 2
.LC15:
	.long 0x43340000
	.align 2
.LC16:
	.long 0xc3340000
	.align 2
.LC17:
	.long 0x41200000
	.align 3
.LC18:
	.long 0x40200000
	.long 0x0
	.align 3
.LC19:
	.long 0x0
	.long 0x0
	.align 3
.LC20:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC22:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC23:
	.long 0x42000000
	.align 2
.LC24:
	.long 0x41000000
	.align 2
.LC25:
	.long 0x3f800000
	.align 2
.LC26:
	.long 0xc3960000
	.align 2
.LC27:
	.long 0x42a00000
	.align 2
.LC28:
	.long 0x43160000
	.align 3
.LC29:
	.long 0x40500000
	.long 0x0
	.align 2
.LC30:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl turret_breach_think
	.type	 turret_breach_think,@function
turret_breach_think:
	stwu 1,-160(1)
	mflr 0
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 24,112(1)
	stw 0,164(1)
	lis 9,.LC13@ha
	mr 30,3
	la 9,.LC13@l(9)
	lfs 11,16(30)
	addi 3,1,24
	lfs 12,0(9)
	lfs 13,20(30)
	addi 9,1,8
	lfs 0,24(30)
	fcmpu 0,11,12
	stfs 11,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	bc 4,1,.L35
	lis 10,.LC13@ha
	fmr 0,11
	la 10,.LC13@l(10)
	lfs 13,0(10)
.L34:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L34
	stfs 0,0(9)
.L35:
	lis 11,.LC14@ha
	lfs 13,0(9)
	addi 31,30,628
	la 11,.LC14@l(11)
	addi 4,30,388
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L148
	lis 10,.LC13@ha
	lis 11,.LC14@ha
	la 10,.LC13@l(10)
	la 11,.LC14@l(11)
	lfs 11,0(10)
	lfs 12,0(11)
.L38:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L38
	stfs 0,0(9)
.L148:
	lis 10,.LC13@ha
	lfs 13,4(9)
	la 10,.LC13@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L149
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 12,0(11)
.L42:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L42
	stfs 0,4(9)
.L149:
	lis 10,.LC14@ha
	lfs 13,4(9)
	la 10,.LC14@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L150
	lis 11,.LC13@ha
	lis 10,.LC14@ha
	la 11,.LC13@l(11)
	la 10,.LC14@l(10)
	lfs 11,0(11)
	lfs 12,0(10)
.L46:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L46
	stfs 0,4(9)
.L150:
	lis 11,.LC13@ha
	lfs 13,628(30)
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L52
	lis 9,.LC13@ha
	lfs 0,0(31)
	la 9,.LC13@l(9)
	lfs 13,0(9)
.L51:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L51
	stfs 0,0(31)
.L52:
	lis 10,.LC14@ha
	lfs 13,0(31)
	la 10,.LC14@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L151
	lis 11,.LC13@ha
	lis 9,.LC14@ha
	la 11,.LC13@l(11)
	la 9,.LC14@l(9)
	lfs 11,0(11)
	lfs 12,0(9)
.L55:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L55
	stfs 0,0(31)
.L151:
	lis 10,.LC13@ha
	lfs 13,4(31)
	la 10,.LC13@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L152
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 12,0(11)
.L59:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L59
	stfs 0,4(31)
.L152:
	lis 9,.LC14@ha
	lfs 13,4(31)
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L153
	lis 10,.LC13@ha
	lis 11,.LC14@ha
	la 10,.LC13@l(10)
	la 11,.LC14@l(11)
	lfs 11,0(10)
	lfs 12,0(11)
.L63:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L63
	stfs 0,4(31)
.L153:
	lis 9,.LC15@ha
	lfs 13,628(30)
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L66
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
	lfs 0,0(10)
	fsubs 0,13,0
	stfs 0,628(30)
.L66:
	lfs 13,628(30)
	lfs 0,352(30)
	fcmpu 0,13,0
	bc 12,1,.L172
	lfs 0,364(30)
	fcmpu 0,13,0
	bc 4,0,.L68
.L172:
	stfs 0,628(30)
.L68:
	lfs 13,632(30)
	lfs 0,356(30)
	lfs 10,368(30)
	fmr 12,13
	fcmpu 0,13,0
	fmr 9,0
	bc 12,0,.L71
	fcmpu 0,12,10
	bc 4,1,.L70
.L71:
	fsubs 0,9,12
	lis 11,.LC16@ha
	la 11,.LC16@l(11)
	lfs 13,0(11)
	fabs 11,0
	fcmpu 0,11,13
	bc 4,0,.L72
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fadds 11,11,0
	b .L73
.L72:
	lis 10,.LC15@ha
	la 10,.LC15@l(10)
	lfs 0,0(10)
	fcmpu 0,11,0
	bc 4,1,.L73
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fsubs 11,11,0
.L73:
	fsubs 0,10,12
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 13,0(9)
	fabs 12,0
	fcmpu 0,12,13
	bc 4,0,.L75
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
	lfs 0,0(10)
	fadds 12,12,0
	b .L76
.L75:
	lis 11,.LC15@ha
	la 11,.LC15@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 4,1,.L76
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fsubs 12,12,0
.L76:
	fmr 13,11
	fmr 0,12
	fabs 13,13
	fabs 0,0
	fcmpu 0,13,0
	bc 4,0,.L78
	stfs 9,632(30)
	b .L70
.L78:
	stfs 10,632(30)
.L70:
	lfs 11,628(30)
	lis 10,.LC16@ha
	lfs 0,8(1)
	la 10,.LC16@l(10)
	lfs 10,0(10)
	lfs 13,632(30)
	fsubs 9,11,0
	lfs 12,12(1)
	lfs 0,636(30)
	lfs 11,16(1)
	fcmpu 0,9,10
	stfs 9,24(1)
	fsubs 13,13,12
	fsubs 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bc 4,0,.L80
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fadds 0,9,0
	b .L173
.L80:
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,9,0
	bc 4,1,.L81
	lis 10,.LC13@ha
	la 10,.LC13@l(10)
	lfs 0,0(10)
	fsubs 0,9,0
.L173:
	stfs 0,24(1)
.L81:
	lis 11,.LC16@ha
	lfs 13,28(1)
	la 11,.LC16@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L83
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L174
.L83:
	lis 10,.LC15@ha
	la 10,.LC15@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L84
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fsubs 0,13,0
.L174:
	stfs 0,28(1)
.L84:
	lfs 13,328(30)
	lis 9,.LC8@ha
	li 0,0
	lfd 31,.LC8@l(9)
	lfs 0,24(1)
	stw 0,32(1)
	fmul 13,13,31
	fcmpu 0,0,13
	bc 4,1,.L86
	frsp 0,13
	stfs 0,24(1)
.L86:
	lfs 0,328(30)
	lfs 13,24(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L87
	frsp 0,0
	stfs 0,24(1)
.L87:
	lfs 0,328(30)
	lfs 13,28(1)
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,1,.L88
	frsp 0,0
	stfs 0,28(1)
.L88:
	lfs 0,328(30)
	lfs 13,28(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L89
	frsp 0,0
	stfs 0,28(1)
.L89:
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 1,0(9)
	bl VectorScale
	lis 9,level+4@ha
	lwz 11,564(30)
	lfs 0,level+4@l(9)
	cmpwi 0,11,0
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(30)
	bc 12,2,.L91
.L93:
	lfs 0,392(30)
	stfs 0,392(11)
	lwz 11,560(11)
	cmpwi 0,11,0
	bc 4,2,.L93
.L91:
	lwz 11,256(30)
	cmpwi 0,11,0
	bc 12,2,.L95
	lwz 0,324(11)
	cmpw 0,0,30
	bc 4,2,.L96
	lfs 0,388(30)
	lis 9,.LC9@ha
	lfd 12,.LC9@l(9)
	stfs 0,388(11)
	lfs 0,392(30)
	lwz 9,256(30)
	stfs 0,392(9)
	lwz 11,256(30)
	lfs 13,20(30)
	lfs 0,620(11)
	lfs 31,4(30)
	fadds 30,13,0
	fmr 0,30
	fmul 0,0,12
	frsp 30,0
	fmr 1,30
	bl cos
	lwz 9,256(30)
	lis 10,.LC18@ha
	lis 11,.LC19@ha
	la 10,.LC18@l(10)
	la 11,.LC19@l(11)
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
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L175
.L97:
	lis 10,.LC20@ha
	la 10,.LC20@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L175:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lfs 31,8(30)
	mr 11,9
	lis 10,.LC21@ha
	fmr 1,30
	la 10,.LC21@l(10)
	fctiwz 0,13
	lfd 11,0(10)
	lis 10,.LC22@ha
	la 10,.LC22@l(10)
	stfd 0,104(1)
	lwz 9,108(1)
	lfd 12,0(10)
	xoris 9,9,0x8000
	stw 9,108(1)
	stw 0,104(1)
	lfd 0,104(1)
	fsub 0,0,11
	fmul 0,0,12
	frsp 0,0
	stfs 0,56(1)
	bl sin
	lwz 9,256(30)
	lis 10,.LC18@ha
	lis 11,.LC19@ha
	la 10,.LC18@l(10)
	la 11,.LC19@l(11)
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
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L176
.L100:
	lis 10,.LC20@ha
	la 10,.LC20@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L176:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 7,256(30)
	mr 8,10
	lis 11,.LC21@ha
	lfs 10,56(1)
	la 11,.LC21@l(11)
	lis 9,.LC22@ha
	fctiwz 0,13
	lfd 11,0(11)
	la 9,.LC22@l(9)
	lfd 12,0(9)
	lis 11,.LC8@ha
	lfd 9,.LC8@l(11)
	lis 9,.LC9@ha
	stfd 0,104(1)
	lwz 10,108(1)
	lfd 8,.LC9@l(9)
	xoris 10,10,0x8000
	stw 10,108(1)
	stw 0,104(1)
	lfd 0,104(1)
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
	lwz 9,256(30)
	fdiv 0,0,9
	frsp 0,0
	stfs 0,380(9)
	lfs 13,16(30)
	fmul 13,13,8
	frsp 30,13
	fmr 1,30
	bl tan
	lwz 9,256(30)
	lis 10,.LC18@ha
	lis 11,.LC19@ha
	lfs 12,12(30)
	la 10,.LC18@l(10)
	la 11,.LC19@l(11)
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
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfd 0,0(9)
	fadd 0,13,0
	b .L177
.L103:
	lis 10,.LC20@ha
	la 10,.LC20@l(10)
	lfd 0,0(10)
	fsub 0,13,0
.L177:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 8,256(30)
	mr 10,9
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 9,12(8)
	fctiwz 0,13
	lfd 10,0(11)
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	stfd 0,104(1)
	lwz 9,108(1)
	lfd 12,0(11)
	xoris 9,9,0x8000
	lis 11,.LC8@ha
	stw 9,108(1)
	stw 0,104(1)
	lfd 0,104(1)
	lfd 11,.LC8@l(11)
	fsub 0,0,10
	fmul 0,0,12
	frsp 0,0
	fsubs 0,0,9
	fmr 13,0
	fdiv 13,13,11
	frsp 13,13
	stfs 13,384(8)
	lwz 0,284(30)
	andis. 9,0,1
	bc 12,2,.L31
	mr 3,30
	bl turret_breach_fire
	lwz 0,284(30)
	rlwinm 0,0,0,16,14
	stw 0,284(30)
	b .L31
.L96:
	li 0,3
	addi 28,30,16
	mtctr 0
	addi 29,1,72
	mr 8,31
	li 10,0
.L171:
	lwz 9,256(30)
	lwz 11,84(9)
	addi 11,11,2124
	lfsx 0,11,10
	stfsx 0,10,8
	addi 10,10,4
	bdnz .L171
	lis 9,.LC13@ha
	lfs 13,628(30)
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L116
	lis 10,.LC13@ha
	lfs 0,0(31)
	la 10,.LC13@l(10)
	lfs 13,0(10)
.L115:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L115
	stfs 0,0(31)
.L116:
	lis 11,.LC14@ha
	lfs 13,0(31)
	la 11,.LC14@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L154
	lis 9,.LC13@ha
	lis 10,.LC14@ha
	la 9,.LC13@l(9)
	la 10,.LC14@l(10)
	lfs 11,0(9)
	lfs 12,0(10)
.L119:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L119
	stfs 0,0(31)
.L154:
	lis 11,.LC13@ha
	lfs 13,4(31)
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L155
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 12,0(9)
.L123:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L123
	stfs 0,4(31)
.L155:
	lis 10,.LC14@ha
	lfs 13,4(31)
	la 10,.LC14@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L156
	lis 11,.LC13@ha
	lis 9,.LC14@ha
	la 11,.LC13@l(11)
	la 9,.LC14@l(9)
	lfs 11,0(11)
	lfs 12,0(9)
.L127:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L127
	stfs 0,4(31)
.L156:
	li 5,0
	li 6,0
	mr 3,28
	mr 4,29
	bl AngleVectors
	lis 9,.LC23@ha
	mr 4,29
	la 9,.LC23@l(9)
	mr 3,29
	lfs 1,0(9)
	bl VectorScale
	lfs 11,72(1)
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lfs 12,4(30)
	lis 11,.LC24@ha
	la 9,.LC14@l(9)
	lfs 13,8(30)
	la 10,.LC14@l(10)
	la 11,.LC24@l(11)
	lfs 10,76(1)
	fsubs 12,12,11
	lfs 0,12(30)
	lfs 11,80(1)
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
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lfs 13,0(3)
	la 9,.LC14@l(9)
	lis 11,.LC24@ha
	lfs 1,0(9)
	la 10,.LC14@l(10)
	la 11,.LC24@l(11)
	lfs 2,0(10)
	fadds 0,0,13
	lfs 3,0(11)
	lwz 9,256(30)
	stfs 0,4(9)
	bl tv
	lfs 13,4(3)
	lis 9,.LC14@ha
	lis 10,.LC14@ha
	lfs 0,44(1)
	la 9,.LC14@l(9)
	lis 11,.LC24@ha
	lfs 1,0(9)
	la 10,.LC14@l(10)
	la 11,.LC24@l(11)
	lfs 3,0(11)
	fadds 0,0,13
	lwz 9,256(30)
	lfs 2,0(10)
	stfs 0,8(9)
	bl tv
	lfs 13,8(3)
	lis 11,gi+72@ha
	lfs 0,48(1)
	lwz 9,256(30)
	fadds 0,0,13
	stfs 0,12(9)
	lwz 0,gi+72@l(11)
	lwz 3,256(30)
	mtlr 0
	blrl
	lwz 9,256(30)
	lwz 11,84(9)
	lwz 0,2004(11)
	andi. 9,0,3
	bc 12,2,.L130
	lis 9,level@ha
	lfs 13,596(30)
	la 31,level@l(9)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L130
	mr 3,30
	bl turret_breach_fire
	lis 9,.LC25@ha
	lfs 0,4(31)
	la 9,.LC25@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,596(30)
.L130:
	lwz 31,256(30)
	lwz 9,84(31)
	lha 0,14(9)
	cmpwi 0,0,30
	bc 4,1,.L31
	li 0,0
	mr 3,28
	stw 0,628(30)
	mr 4,29
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC26@ha
	mr 3,29
	la 9,.LC26@l(9)
	mr 4,29
	lfs 1,0(9)
	bl VectorScale
	lis 10,.LC28@ha
	lfs 0,80(1)
	lis 9,.LC27@ha
	la 10,.LC28@l(10)
	la 9,.LC27@l(9)
	lfs 13,0(10)
	lfs 12,0(9)
	fadds 0,0,13
	fcmpu 0,0,12
	stfs 0,80(1)
	bc 4,0,.L132
	stfs 12,80(1)
.L132:
	li 0,3
	mr 3,29
	mtctr 0
	addi 11,31,376
	li 9,0
.L170:
	lfsx 0,9,3
	stfsx 0,9,11
	addi 9,9,4
	bdnz .L170
	lis 9,.LC25@ha
	lfs 0,12(31)
	li 0,2
	la 9,.LC25@l(9)
	lis 4,.LC10@ha
	stw 0,260(31)
	lfs 13,0(9)
	mr 3,31
	la 4,.LC10@l(4)
	fadds 0,0,13
	stfs 13,408(31)
	stfs 0,12(31)
	bl stuffcmd
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,0
	stw 0,256(30)
	b .L31
.L157:
	lis 9,gi+8@ha
	lis 5,.LC11@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC11@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L31
.L95:
	lis 10,.LC14@ha
	lis 9,maxclients@ha
	la 10,.LC14@l(10)
	lis 11,g_edicts@ha
	lfs 13,0(10)
	li 28,0
	lis 24,maxclients@ha
	lwz 10,maxclients@l(9)
	lwz 31,g_edicts@l(11)
	lfs 0,20(10)
	addi 31,31,1116
	fcmpu 0,13,0
	bc 4,0,.L31
	lis 9,gi@ha
	addi 29,1,56
	la 26,gi@l(9)
	li 27,0
	lis 25,0x4330
.L142:
	mr 3,31
	bl G_ClientExists
	cmpwi 0,3,0
	bc 4,2,.L141
	addi 3,30,16
	mr 4,29
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC23@ha
	mr 3,29
	la 9,.LC23@l(9)
	mr 4,29
	lfs 1,0(9)
	bl VectorScale
	lfs 13,4(30)
	lis 9,.LC29@ha
	lfs 0,56(1)
	la 9,.LC29@l(9)
	lfs 11,8(30)
	lfs 12,12(30)
	fsubs 13,13,0
	lfs 10,60(1)
	lfs 0,64(1)
	lfd 9,0(9)
	fsubs 11,11,10
	stfs 13,40(1)
	fsubs 12,12,0
	stfs 11,44(1)
	stfs 12,48(1)
	lfs 0,4(31)
	fsubs 13,13,0
	stfs 13,88(1)
	lfs 0,8(31)
	fsubs 11,11,0
	stfs 11,92(1)
	lfs 13,12(31)
	fsubs 12,12,13
	fmr 0,12
	stfs 12,96(1)
	fabs 0,0
	fcmpu 0,0,9
	bc 4,0,.L144
	stw 27,96(1)
.L144:
	addi 3,1,88
	bl VectorLength
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L141
	lwz 0,892(31)
	cmpwi 0,0,6
	bc 4,2,.L157
	stw 31,256(30)
	li 0,2
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	stw 0,260(31)
	mr 3,31
	stw 27,408(31)
	bl stuffcmd
	lwz 9,72(26)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,12(26)
	lis 4,.LC12@ha
	mr 3,31
	la 4,.LC12@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
.L141:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	lis 10,.LC21@ha
	stw 0,108(1)
	la 10,.LC21@l(10)
	addi 31,31,1116
	stw 25,104(1)
	lfd 13,0(10)
	lfd 0,104(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L142
.L31:
	lwz 0,164(1)
	mtlr 0
	lmw 24,112(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 turret_breach_think,.Lfe2-turret_breach_think
	.section	".rodata"
	.align 2
.LC31:
	.string	"%s at %s needs a target\n"
	.align 3
.LC32:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC33:
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
	lis 9,.LC33@ha
	lfs 0,328(31)
	la 9,.LC33@l(9)
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
	lis 9,.LC32@ha
	fneg 0,0
	lfd 12,.LC32@l(9)
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
.Lfe3:
	.size	 SP_turret_breach,.Lfe3-SP_turret_breach
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".rodata"
	.align 2
.LC34:
	.long 0x43b40000
	.align 2
.LC35:
	.long 0x0
	.section	".text"
	.align 2
	.globl AnglesNormalize
	.type	 AnglesNormalize,@function
AnglesNormalize:
	lis 9,.LC34@ha
	lfs 13,0(3)
	la 9,.LC34@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L8
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 12,0(9)
.L9:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L9
	stfs 0,0(3)
.L8:
	lis 9,.LC35@ha
	lfs 13,0(3)
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L190
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 11,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 12,0(9)
.L13:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L13
	stfs 0,0(3)
.L190:
	lis 9,.LC34@ha
	lfs 13,4(3)
	la 9,.LC34@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L191
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 12,0(9)
.L17:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L17
	stfs 0,4(3)
.L191:
	lis 9,.LC35@ha
	lfs 13,4(3)
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bclr 4,0
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 11,0(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 12,0(9)
.L21:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L21
	stfs 0,4(3)
	blr
.Lfe4:
	.size	 AnglesNormalize,.Lfe4-AnglesNormalize
	.section	".rodata"
	.align 3
.LC36:
	.long 0x40200000
	.long 0x0
	.align 3
.LC37:
	.long 0x0
	.long 0x0
	.align 3
.LC38:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC40:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SnapToEights
	.type	 SnapToEights,@function
SnapToEights:
	stwu 1,-16(1)
	lis 9,.LC36@ha
	lis 10,.LC37@ha
	la 9,.LC36@l(9)
	la 10,.LC37@l(10)
	lfd 0,0(9)
	lfd 13,0(10)
	fmul 1,1,0
	frsp 0,1
	fmr 1,0
	fcmpu 0,1,13
	bc 4,1,.L24
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L197
.L24:
	lis 10,.LC38@ha
	la 10,.LC38@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L197:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	mr 11,9
	lis 10,.LC39@ha
	la 10,.LC39@l(10)
	fctiwz 0,13
	lfd 12,0(10)
	lis 10,.LC40@ha
	la 10,.LC40@l(10)
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
.Lfe5:
	.size	 SnapToEights,.Lfe5-SnapToEights
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
	li 29,8
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
.Lfe6:
	.size	 turret_blocked,.Lfe6-turret_blocked
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
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L180
.L179:
	bl G_PickTarget
	stw 3,324(31)
	lfs 13,4(3)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,616(31)
	lfs 0,8(3)
	fsubs 0,0,12
	stfs 0,620(31)
	lfs 13,12(3)
	fsubs 13,13,11
	stfs 13,624(31)
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
.Lfe7:
	.size	 turret_breach_finish_init,.Lfe7-turret_breach_finish_init
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
.Lfe8:
	.size	 SP_turret_base,.Lfe8-SP_turret_base
	.align 2
	.globl turret_driver_die
	.type	 turret_driver_die,@function
turret_driver_die:
	blr
.Lfe9:
	.size	 turret_driver_die,.Lfe9-turret_driver_die
	.align 2
	.globl SP_turret_driver
	.type	 SP_turret_driver,@function
SP_turret_driver:
	blr
.Lfe10:
	.size	 SP_turret_driver,.Lfe10-SP_turret_driver
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
