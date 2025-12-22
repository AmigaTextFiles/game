	.file	"g_turret.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC2:
	.string	"weapons/rocklf1a.wav"
	.align 2
.LC3:
	.string	"weapons/machgf1b.wav"
	.align 2
.LC4:
	.string	"tank/tnkatck3.wav"
	.align 2
.LC5:
	.string	"weapons/railgf1a.wav"
	.align 2
.LC6:
	.string	"weapons/plasma.wav"
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl turret_breach_fire
	.type	 turret_breach_fire,@function
turret_breach_fire:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	addi 28,1,24
	addi 29,1,40
	mr 30,3
	addi 31,1,56
	addi 4,1,8
	mr 6,29
	addi 3,30,16
	mr 5,28
	bl AngleVectors
	lfs 1,616(30)
	addi 4,1,8
	addi 3,30,4
	mr 5,31
	bl VectorMA
	lfs 1,620(30)
	mr 3,31
	mr 4,28
	mr 5,31
	bl VectorMA
	lfs 1,624(30)
	mr 3,31
	mr 4,29
	mr 5,31
	bl VectorMA
	bl rand
	lwz 10,564(30)
	lwz 0,532(10)
	cmpwi 0,0,0
	bc 4,2,.L31
	lfs 0,600(10)
	lis 0,0x4330
	lwz 6,480(10)
	mr 11,7
	mr 4,31
	lwz 3,256(10)
	addi 5,1,8
	addi 9,6,40
	mr 8,6
	xoris 9,9,0x8000
	fctiwz 13,0
	stfd 13,72(1)
	lwz 7,76(1)
	stw 9,76(1)
	lis 9,.LC7@ha
	stw 0,72(1)
	la 9,.LC7@l(9)
	lfd 1,72(1)
	lfd 0,0(9)
	fsub 1,1,0
	frsp 1,1
	bl fire_rocket
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	b .L40
.L31:
	cmpwi 0,0,1
	bc 4,2,.L33
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
	mr 3,31
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,7
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,31
	li 4,2
	mtlr 9
	blrl
	lwz 11,564(30)
	mr 4,31
	addi 5,1,8
	li 9,500
	li 10,4
	lwz 3,256(11)
	li 7,0
	li 8,300
	lwz 6,480(11)
	bl fire_bullet
	lwz 9,36(29)
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	b .L41
.L33:
	cmpwi 0,0,4
	bc 4,2,.L35
	lfs 0,600(10)
	mr 4,31
	lwz 3,256(10)
	addi 5,1,8
	li 9,1
	lwz 6,480(10)
	li 8,64
	fctiwz 13,0
	stfd 13,72(1)
	lwz 7,76(1)
	bl fire_blaster
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	b .L40
.L35:
	cmpwi 0,0,2
	bc 4,2,.L37
	lwz 3,256(10)
	mr 4,31
	addi 5,1,8
	lwz 6,480(10)
	li 7,0
	bl fire_rail
	lis 29,gi@ha
	lis 3,.LC5@ha
	la 29,gi@l(29)
	la 3,.LC5@l(3)
.L40:
	lwz 9,36(29)
.L41:
	mtlr 9
	blrl
	lis 9,.LC8@ha
	lwz 0,20(29)
	mr 6,3
	la 9,.LC8@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 3,31
	li 5,1
	mtlr 0
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 2,0(9)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 3,0(9)
	blrl
	b .L32
.L37:
	cmpwi 0,0,3
	bc 4,2,.L32
	lfs 0,600(10)
	mr 6,29
	lwz 3,256(10)
	mr 4,31
	addi 5,1,8
	lwz 8,480(10)
	mr 7,28
	fctiwz 13,0
	stfd 13,72(1)
	lwz 9,76(1)
	bl fire_plasma
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC8@ha
	lwz 0,20(29)
	mr 6,3
	la 9,.LC8@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 3,31
	li 5,1
	mtlr 0
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 2,0(9)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 3,0(9)
	blrl
.L32:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 turret_breach_fire,.Lfe1-turret_breach_fire
	.section	".rodata"
	.align 2
.LC10:
	.long 0x43b40000
	.align 2
.LC11:
	.long 0x0
	.align 2
.LC12:
	.long 0x42200000
	.align 2
.LC13:
	.long 0xc3960000
	.align 2
.LC14:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl turret_client_check
	.type	 turret_client_check,@function
turret_client_check:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	lis 9,.LC10@ha
	mr 30,3
	la 9,.LC10@l(9)
	lfs 13,628(30)
	addi 29,1,24
	lfs 0,0(9)
	addi 9,30,628
	fcmpu 0,13,0
	bc 4,1,.L46
	lis 11,.LC10@ha
	fmr 0,13
	la 11,.LC10@l(11)
	lfs 13,0(11)
.L45:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L45
	stfs 0,0(9)
.L46:
	lis 11,.LC11@ha
	lfs 13,0(9)
	addi 28,30,16
	la 11,.LC11@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L62
	lis 11,.LC10@ha
	la 11,.LC10@l(11)
	lfs 11,0(11)
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	lfs 12,0(11)
.L49:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L49
	stfs 0,0(9)
.L62:
	lis 11,.LC10@ha
	lfs 13,4(9)
	la 11,.LC10@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L63
	lis 11,.LC10@ha
	la 11,.LC10@l(11)
	lfs 12,0(11)
.L53:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L53
	stfs 0,4(9)
.L63:
	lis 11,.LC11@ha
	lfs 13,4(9)
	la 11,.LC11@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L64
	lis 11,.LC10@ha
	la 11,.LC10@l(11)
	lfs 11,0(11)
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	lfs 12,0(11)
.L57:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L57
	stfs 0,4(9)
.L64:
	mr 3,28
	mr 4,29
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC12@ha
	mr 3,29
	la 9,.LC12@l(9)
	mr 4,29
	lfs 1,0(9)
	bl VectorScale
	lfs 12,4(30)
	li 10,0
	lfs 11,24(1)
	lfs 13,8(30)
	lfs 0,12(30)
	fsubs 12,12,11
	lfs 10,28(1)
	lfs 11,32(1)
	lwz 9,256(30)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	stw 10,376(9)
	stw 10,384(9)
	stw 10,380(9)
	lfs 0,8(1)
	lwz 11,256(30)
	stfs 0,4(11)
	lfs 0,12(1)
	lwz 9,256(30)
	stfs 0,8(9)
	lfs 0,16(1)
	lwz 11,256(30)
	stfs 0,12(11)
	lwz 31,256(30)
	lwz 9,84(31)
	lwz 0,3964(9)
	cmpwi 0,0,2
	bc 4,1,.L60
	stw 10,628(30)
	mr 3,28
	mr 4,29
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC13@ha
	mr 3,29
	la 9,.LC13@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lfs 0,24(1)
	lis 0,0x4316
	lis 9,.LC14@ha
	stw 0,32(1)
	la 9,.LC14@l(9)
	lis 11,0x3f80
	lfs 12,0(9)
	lis 8,gi@ha
	stfs 0,376(31)
	li 9,4
	lfs 13,28(1)
	lfs 0,12(31)
	lwz 10,84(31)
	stfs 13,380(31)
	lfs 13,32(1)
	fadds 0,0,12
	stw 9,260(31)
	stw 11,408(31)
	stfs 13,384(31)
	stfs 0,12(31)
	lwz 0,3912(10)
	cmpwi 0,0,0
	bc 4,2,.L61
	lwz 0,3908(10)
	cmpwi 0,0,0
	bc 4,2,.L61
	la 9,gi@l(8)
	lwz 11,1788(10)
	lwz 0,32(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 0,0,191
	stb 0,16(11)
.L61:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 11,256(30)
	li 0,0
	lwz 9,84(11)
	stw 0,3964(9)
	stw 0,256(30)
.L60:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 turret_client_check,.Lfe2-turret_client_check
	.section	".rodata"
	.align 2
.LC17:
	.string	"Turret mounted\n\nPress FIRE to fire, JUMP to abandon"
	.align 3
.LC15:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC16:
	.long 0x3f91df46
	.long 0xa2529d39
	.align 2
.LC18:
	.long 0x43b40000
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x43340000
	.align 2
.LC21:
	.long 0xc3340000
	.align 2
.LC22:
	.long 0x41200000
	.align 3
.LC23:
	.long 0x40200000
	.long 0x0
	.align 3
.LC24:
	.long 0x0
	.long 0x0
	.align 3
.LC25:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC27:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC28:
	.long 0x42000000
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
	stwu 1,-176(1)
	mflr 0
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 23,124(1)
	stw 0,180(1)
	lis 9,.LC18@ha
	mr 30,3
	la 9,.LC18@l(9)
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
	bc 4,1,.L73
	lis 10,.LC18@ha
	fmr 0,11
	la 10,.LC18@l(10)
	lfs 13,0(10)
.L72:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L72
	stfs 0,0(9)
.L73:
	lis 11,.LC19@ha
	lfs 13,0(9)
	addi 29,30,628
	la 11,.LC19@l(11)
	addi 4,30,388
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L162
	lis 10,.LC18@ha
	lis 11,.LC19@ha
	la 10,.LC18@l(10)
	la 11,.LC19@l(11)
	lfs 11,0(10)
	lfs 12,0(11)
.L76:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L76
	stfs 0,0(9)
.L162:
	lis 10,.LC18@ha
	lfs 13,4(9)
	la 10,.LC18@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L163
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 12,0(11)
.L80:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L80
	stfs 0,4(9)
.L163:
	lis 10,.LC19@ha
	lfs 13,4(9)
	la 10,.LC19@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L164
	lis 11,.LC18@ha
	lis 10,.LC19@ha
	la 11,.LC18@l(11)
	la 10,.LC19@l(10)
	lfs 11,0(11)
	lfs 12,0(10)
.L84:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L84
	stfs 0,4(9)
.L164:
	lis 11,.LC18@ha
	lfs 13,628(30)
	la 11,.LC18@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L90
	lis 9,.LC18@ha
	lfs 0,0(29)
	la 9,.LC18@l(9)
	lfs 13,0(9)
.L89:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L89
	stfs 0,0(29)
.L90:
	lis 10,.LC19@ha
	lfs 13,0(29)
	la 10,.LC19@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L165
	lis 11,.LC18@ha
	lis 9,.LC19@ha
	la 11,.LC18@l(11)
	la 9,.LC19@l(9)
	lfs 11,0(11)
	lfs 12,0(9)
.L93:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L93
	stfs 0,0(29)
.L165:
	lis 10,.LC18@ha
	lfs 13,4(29)
	la 10,.LC18@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L166
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 12,0(11)
.L97:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L97
	stfs 0,4(29)
.L166:
	lis 9,.LC19@ha
	lfs 13,4(29)
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L167
	lis 10,.LC18@ha
	lis 11,.LC19@ha
	la 10,.LC18@l(10)
	la 11,.LC19@l(11)
	lfs 11,0(10)
	lfs 12,0(11)
.L101:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L101
	stfs 0,4(29)
.L167:
	lis 9,.LC20@ha
	lfs 13,628(30)
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L104
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfs 0,0(10)
	fsubs 0,13,0
	stfs 0,628(30)
.L104:
	lfs 13,628(30)
	lfs 0,352(30)
	fcmpu 0,13,0
	bc 12,1,.L177
	lfs 0,364(30)
	fcmpu 0,13,0
	bc 4,0,.L106
.L177:
	stfs 0,628(30)
.L106:
	lfs 13,632(30)
	lfs 0,356(30)
	lfs 10,368(30)
	fmr 12,13
	fcmpu 0,13,0
	fmr 9,0
	bc 12,0,.L109
	fcmpu 0,12,10
	bc 4,1,.L108
.L109:
	fsubs 0,9,12
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 13,0(11)
	fabs 11,0
	fcmpu 0,11,13
	bc 4,0,.L110
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fadds 11,11,0
	b .L111
.L110:
	lis 10,.LC20@ha
	la 10,.LC20@l(10)
	lfs 0,0(10)
	fcmpu 0,11,0
	bc 4,1,.L111
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
	fsubs 11,11,0
.L111:
	fsubs 0,10,12
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	fabs 12,0
	fcmpu 0,12,13
	bc 4,0,.L113
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfs 0,0(10)
	fadds 12,12,0
	b .L114
.L113:
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 4,1,.L114
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fsubs 12,12,0
.L114:
	fmr 13,11
	fmr 0,12
	fabs 13,13
	fabs 0,0
	fcmpu 0,13,0
	bc 4,0,.L116
	stfs 9,632(30)
	b .L108
.L116:
	stfs 10,632(30)
.L108:
	lfs 11,628(30)
	lis 10,.LC21@ha
	lfs 0,8(1)
	la 10,.LC21@l(10)
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
	bc 4,0,.L118
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
	fadds 0,9,0
	b .L178
.L118:
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,9,0
	bc 4,1,.L119
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfs 0,0(10)
	fsubs 0,9,0
.L178:
	stfs 0,24(1)
.L119:
	lis 11,.LC21@ha
	lfs 13,28(1)
	la 11,.LC21@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L121
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L179
.L121:
	lis 10,.LC20@ha
	la 10,.LC20@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L122
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
	fsubs 0,13,0
.L179:
	stfs 0,28(1)
.L122:
	lfs 13,328(30)
	lis 9,.LC15@ha
	li 0,0
	lfd 31,.LC15@l(9)
	lfs 0,24(1)
	stw 0,32(1)
	fmul 13,13,31
	fcmpu 0,0,13
	bc 4,1,.L124
	frsp 0,13
	stfs 0,24(1)
.L124:
	lfs 0,328(30)
	lfs 13,24(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L125
	frsp 0,0
	stfs 0,24(1)
.L125:
	lfs 0,328(30)
	lfs 13,28(1)
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,1,.L126
	frsp 0,0
	stfs 0,28(1)
.L126:
	lfs 0,328(30)
	lfs 13,28(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L127
	frsp 0,0
	stfs 0,28(1)
.L127:
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 1,0(9)
	bl VectorScale
	lis 9,level+4@ha
	lwz 11,564(30)
	lfs 0,level+4@l(9)
	cmpwi 0,11,0
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(30)
	bc 12,2,.L129
.L131:
	lfs 0,392(30)
	stfs 0,392(11)
	lwz 11,560(11)
	cmpwi 0,11,0
	bc 4,2,.L131
.L129:
	lwz 11,256(30)
	cmpwi 0,11,0
	bc 12,2,.L133
	lwz 0,84(11)
	cmpwi 0,0,0
	bc 12,2,.L134
	li 0,3
	mr 8,29
	mtctr 0
	li 10,0
.L176:
	lwz 9,256(30)
	lwz 11,84(9)
	addi 11,11,3728
	lfsx 0,11,10
	stfsx 0,10,8
	addi 10,10,4
	bdnz .L176
	lwz 9,256(30)
	lwz 11,84(9)
	lwz 0,3608(11)
	andi. 9,0,1
	bc 12,2,.L152
	lis 9,level@ha
	lfs 13,596(30)
	la 31,level@l(9)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L152
	mr 3,30
	bl turret_breach_fire
	lfs 0,4(31)
	lfs 13,592(30)
	fadds 0,0,13
	stfs 0,596(30)
	b .L152
.L134:
	lfs 0,388(30)
	lis 9,.LC16@ha
	lfd 12,.LC16@l(9)
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
	lis 10,.LC23@ha
	lis 11,.LC24@ha
	la 10,.LC23@l(10)
	la 11,.LC24@l(11)
	lfs 0,616(9)
	lfd 13,0(10)
	lfd 12,0(11)
	fmadd 1,1,0,31
	frsp 0,1
	fmul 0,0,13
	frsp 0,0
	fmr 1,0
	fcmpu 0,1,12
	bc 4,1,.L142
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L180
.L142:
	lis 10,.LC25@ha
	la 10,.LC25@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L180:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lfs 31,8(30)
	mr 11,9
	lis 10,.LC26@ha
	fmr 1,30
	la 10,.LC26@l(10)
	fctiwz 0,13
	lfd 11,0(10)
	lis 10,.LC27@ha
	la 10,.LC27@l(10)
	stfd 0,112(1)
	lwz 9,116(1)
	lfd 12,0(10)
	xoris 9,9,0x8000
	stw 9,116(1)
	stw 0,112(1)
	lfd 0,112(1)
	fsub 0,0,11
	fmul 0,0,12
	frsp 0,0
	stfs 0,40(1)
	bl sin
	lwz 9,256(30)
	lis 10,.LC23@ha
	lis 11,.LC24@ha
	la 10,.LC23@l(10)
	la 11,.LC24@l(11)
	lfs 0,616(9)
	lfd 13,0(10)
	lfd 12,0(11)
	fmadd 1,1,0,31
	frsp 0,1
	fmul 0,0,13
	frsp 0,0
	fmr 1,0
	fcmpu 0,1,12
	bc 4,1,.L145
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L181
.L145:
	lis 10,.LC25@ha
	la 10,.LC25@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L181:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 7,256(30)
	mr 8,10
	lis 11,.LC26@ha
	lfs 10,40(1)
	la 11,.LC26@l(11)
	lis 9,.LC27@ha
	fctiwz 0,13
	lfd 11,0(11)
	la 9,.LC27@l(9)
	lfd 12,0(9)
	lis 11,.LC15@ha
	lfd 9,.LC15@l(11)
	lis 9,.LC16@ha
	stfd 0,112(1)
	lwz 10,116(1)
	lfd 8,.LC16@l(9)
	xoris 10,10,0x8000
	stw 10,116(1)
	stw 0,112(1)
	lfd 0,112(1)
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
	stfs 13,376(7)
	lfs 0,60(1)
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
	lis 10,.LC23@ha
	lis 11,.LC24@ha
	lfs 12,12(30)
	la 10,.LC23@l(10)
	la 11,.LC24@l(11)
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
	bc 4,1,.L148
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfd 0,0(9)
	fadd 0,13,0
	b .L182
.L148:
	lis 10,.LC25@ha
	la 10,.LC25@l(10)
	lfd 0,0(10)
	fsub 0,13,0
.L182:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 8,256(30)
	mr 10,9
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	lfs 9,12(8)
	fctiwz 0,13
	lfd 10,0(11)
	lis 11,.LC27@ha
	la 11,.LC27@l(11)
	stfd 0,112(1)
	lwz 9,116(1)
	lfd 12,0(11)
	xoris 9,9,0x8000
	lis 11,.LC15@ha
	stw 9,116(1)
	stw 0,112(1)
	lfd 0,112(1)
	lfd 11,.LC15@l(11)
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
	bc 12,2,.L152
	mr 3,30
	bl turret_breach_fire
	lwz 0,284(30)
	rlwinm 0,0,0,16,14
	stw 0,284(30)
	b .L152
.L133:
	lis 10,.LC19@ha
	lis 9,maxclients@ha
	la 10,.LC19@l(10)
	lis 11,g_edicts@ha
	lfs 13,0(10)
	li 26,0
	lis 23,maxclients@ha
	lwz 10,maxclients@l(9)
	lwz 31,g_edicts@l(11)
	lfs 0,20(10)
	addi 31,31,1160
	fcmpu 0,13,0
	bc 4,0,.L152
	lis 9,gi@ha
	addi 27,1,72
	la 25,gi@l(9)
	li 28,0
	lis 24,0x4330
.L156:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L155
	lwz 9,84(31)
	lwz 29,0(9)
	cmpwi 0,29,0
	bc 4,2,.L155
	addi 3,30,16
	mr 4,27
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC28@ha
	mr 3,27
	la 9,.LC28@l(9)
	mr 4,27
	lfs 1,0(9)
	bl VectorScale
	lfs 13,4(30)
	lis 9,.LC29@ha
	lfs 0,72(1)
	la 9,.LC29@l(9)
	lfs 11,8(30)
	lfs 12,12(30)
	fsubs 13,13,0
	lfs 10,76(1)
	lfs 0,80(1)
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
	bc 4,0,.L159
	stw 28,96(1)
.L159:
	addi 3,1,88
	bl VectorLength
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L155
	stw 31,256(30)
	lis 10,0x3f80
	li 0,2
	lwz 11,84(31)
	mr 3,31
	stw 28,3996(11)
	lwz 9,84(31)
	stw 30,3968(9)
	lwz 11,84(31)
	stw 10,408(31)
	stw 0,260(31)
	stw 28,384(31)
	stw 28,380(31)
	stw 28,376(31)
	stw 29,3660(11)
	lwz 9,84(31)
	stw 29,3828(9)
	lwz 11,84(31)
	stw 29,88(11)
	lwz 9,84(31)
	lbz 0,16(9)
	ori 0,0,64
	stb 0,16(9)
	lwz 9,72(25)
	mtlr 9
	blrl
	lwz 9,12(25)
	lis 4,.LC17@ha
	mr 3,31
	la 4,.LC17@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	stw 0,3964(9)
.L155:
	addi 26,26,1
	lwz 11,maxclients@l(23)
	xoris 0,26,0x8000
	lis 10,.LC26@ha
	stw 0,116(1)
	la 10,.LC26@l(10)
	addi 31,31,1160
	stw 24,112(1)
	lfd 13,0(10)
	lfd 0,112(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L156
.L152:
	lwz 0,180(1)
	mtlr 0
	lmw 23,124(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 turret_breach_think,.Lfe3-turret_breach_think
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
	bc 4,2,.L187
	lis 0,0x4248
	stw 0,328(31)
.L187:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L188
	li 0,10
	stw 0,516(31)
.L188:
	lis 9,st@ha
	la 7,st@l(9)
	lfs 0,60(7)
	fcmpu 0,0,13
	bc 4,2,.L189
	lis 0,0xc1f0
	stw 0,60(7)
.L189:
	lfs 0,64(7)
	fcmpu 0,0,13
	bc 4,2,.L190
	lis 0,0x41f0
	stw 0,64(7)
.L190:
	lfs 0,56(7)
	fcmpu 0,0,13
	bc 4,2,.L191
	lis 0,0x43b4
	stw 0,56(7)
.L191:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L192
	lis 0,0x3f80
	stw 0,592(31)
.L192:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,2,.L193
	li 0,110
	stw 0,480(31)
.L193:
	lfs 0,600(31)
	fcmpu 0,0,13
	bc 4,2,.L194
	lis 0,0x4448
	stw 0,600(31)
.L194:
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
.Lfe4:
	.size	 SP_turret_breach,.Lfe4-SP_turret_breach
	.section	".rodata"
	.align 3
.LC34:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
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
	lis 11,.LC34@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC34@l(11)
	lwz 9,540(31)
	cmpwi 0,9,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L212
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L204
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 12,1,.L203
.L204:
	li 0,0
	stw 0,540(31)
.L203:
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 4,2,.L205
.L212:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 12,2,.L202
	lis 9,level+4@ha
	lwz 0,776(31)
	lfs 0,level+4@l(9)
	rlwinm 0,0,0,29,27
	b .L213
.L205:
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L208
	lwz 0,776(31)
	ori 0,0,8
	stw 0,776(31)
	b .L202
.L208:
	lwz 0,776(31)
	andi. 9,0,8
	bc 12,2,.L207
	lis 9,level+4@ha
	rlwinm 0,0,0,29,27
	lfs 0,level+4@l(9)
.L213:
	stw 0,776(31)
	stfs 0,852(31)
.L207:
	lwz 9,540(31)
	lis 10,.LC35@ha
	la 10,.LC35@l(10)
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
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L202
	lwz 11,324(31)
	lwz 9,564(11)
	lfs 0,592(9)
	fadds 0,13,0
	stfs 0,832(31)
	lwz 0,284(11)
	oris 0,0,0x1
	stw 0,284(11)
.L202:
	lwz 0,68(1)
	mtlr 0
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 turret_driver_think,.Lfe5-turret_driver_think
	.section	".rodata"
	.align 3
.LC36:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC37:
	.long 0x43b40000
	.align 2
.LC38:
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
	lis 11,.LC36@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC36@l(11)
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
	lis 11,.LC37@ha
	lfs 13,8(1)
	addi 9,1,8
	la 11,.LC37@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L218
	lis 11,.LC37@ha
	fmr 0,13
	la 11,.LC37@l(11)
	lfs 13,0(11)
.L217:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L217
	stfs 0,0(9)
.L218:
	lis 11,.LC38@ha
	lfs 13,0(9)
	la 11,.LC38@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L237
	lis 11,.LC37@ha
	la 11,.LC37@l(11)
	lfs 11,0(11)
	lis 11,.LC38@ha
	la 11,.LC38@l(11)
	lfs 12,0(11)
.L221:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L221
	stfs 0,0(9)
.L237:
	lis 11,.LC37@ha
	lfs 13,4(9)
	la 11,.LC37@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L238
	lis 11,.LC37@ha
	la 11,.LC37@l(11)
	lfs 12,0(11)
.L225:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L225
	stfs 0,4(9)
.L238:
	lis 11,.LC38@ha
	lfs 13,4(9)
	la 11,.LC38@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L239
	lis 11,.LC37@ha
	la 11,.LC37@l(11)
	lfs 11,0(11)
	lis 11,.LC38@ha
	la 11,.LC38@l(11)
	lfs 12,0(11)
.L229:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L229
	stfs 0,4(9)
.L239:
	lfs 0,12(1)
	lwz 9,324(31)
	stfs 0,620(31)
	lfs 13,12(9)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,624(31)
	lwz 9,564(9)
	b .L244
.L234:
	lwz 9,560(9)
.L244:
	lwz 0,560(9)
	cmpwi 0,0,0
	bc 4,2,.L234
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
.Lfe6:
	.size	 turret_driver_link,.Lfe6-turret_driver_link
	.section	".rodata"
	.align 2
.LC39:
	.string	"models/monsters/infantry/tris.md2"
	.align 2
.LC40:
	.string	"%s at %s has bad item: %s\n"
	.align 3
.LC41:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_turret_driver
	.type	 SP_turret_driver,@function
SP_turret_driver:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 11,.LC42@ha
	lis 9,deathmatch@ha
	la 11,.LC42@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L246
	bl G_FreeEdict
	b .L245
.L246:
	li 29,2
	lis 9,gi@ha
	la 26,gi@l(9)
	stw 29,260(31)
	lis 3,.LC39@ha
	stw 29,248(31)
	la 3,.LC39@l(3)
	lwz 9,32(26)
	mtlr 9
	blrl
	lis 9,turret_driver_die@ha
	lwz 5,264(31)
	lis 0,0xc1c0
	la 9,turret_driver_die@l(9)
	stw 3,40(31)
	lis 8,infantry_stand@ha
	stw 9,456(31)
	lis 3,0x4180
	lis 28,0xc180
	lis 9,0x4200
	stw 0,196(31)
	li 27,0
	stw 9,208(31)
	li 10,100
	li 0,5120
	lis 9,st@ha
	la 8,infantry_stand@l(8)
	stw 3,204(31)
	ori 5,5,2048
	li 6,200
	stw 10,480(31)
	li 4,24
	lis 11,level@ha
	stw 0,1136(31)
	stw 3,200(31)
	la 11,level@l(11)
	la 30,st@l(9)
	stw 28,192(31)
	lis 7,monster_use@ha
	lis 10,0x202
	stw 6,400(31)
	la 7,monster_use@l(7)
	ori 10,10,3
	stw 4,508(31)
	stw 8,788(31)
	stw 5,264(31)
	stw 28,188(31)
	stw 27,488(31)
	lwz 9,284(11)
	addi 9,9,1
	stw 9,284(11)
	lwz 0,184(31)
	lwz 9,68(31)
	lfs 12,4(31)
	ori 0,0,4
	lfs 13,8(31)
	ori 9,9,64
	lfs 0,12(31)
	lwz 11,776(31)
	stw 0,184(31)
	stw 27,992(31)
	ori 11,11,2049
	stw 9,68(31)
	stw 29,512(31)
	stw 7,448(31)
	stw 10,252(31)
	stfs 12,28(31)
	stfs 13,32(31)
	stfs 0,36(31)
	stw 11,776(31)
	lwz 3,44(30)
	cmpwi 0,3,0
	bc 12,2,.L247
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,648(31)
	bc 4,2,.L247
	lwz 29,280(31)
	addi 3,31,4
	bl vtos
	mr 5,3
	lwz 0,4(26)
	mr 4,29
	lis 3,.LC40@ha
	lwz 6,44(30)
	la 3,.LC40@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L247:
	lis 9,turret_driver_link@ha
	lis 10,level+4@ha
	la 9,turret_driver_link@l(9)
	lis 11,.LC41@ha
	stw 9,436(31)
	lis 8,gi+72@ha
	mr 3,31
	lfs 0,level+4@l(10)
	lfd 13,.LC41@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
.L245:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 SP_turret_driver,.Lfe7-SP_turret_driver
	.section	".rodata"
	.align 2
.LC43:
	.long 0x43b40000
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.globl AnglesNormalize
	.type	 AnglesNormalize,@function
AnglesNormalize:
	lis 9,.LC43@ha
	lfs 13,0(3)
	la 9,.LC43@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L8
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 12,0(9)
.L9:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L9
	stfs 0,0(3)
.L8:
	lis 9,.LC44@ha
	lfs 13,0(3)
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L249
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 11,0(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 12,0(9)
.L13:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L13
	stfs 0,0(3)
.L249:
	lis 9,.LC43@ha
	lfs 13,4(3)
	la 9,.LC43@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L250
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 12,0(9)
.L17:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L17
	stfs 0,4(3)
.L250:
	lis 9,.LC44@ha
	lfs 13,4(3)
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bclr 4,0
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 11,0(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 12,0(9)
.L21:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L21
	stfs 0,4(3)
	blr
.Lfe8:
	.size	 AnglesNormalize,.Lfe8-AnglesNormalize
	.section	".rodata"
	.align 3
.LC45:
	.long 0x40200000
	.long 0x0
	.align 3
.LC46:
	.long 0x0
	.long 0x0
	.align 3
.LC47:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC49:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SnapToEights
	.type	 SnapToEights,@function
SnapToEights:
	stwu 1,-16(1)
	lis 9,.LC45@ha
	lis 10,.LC46@ha
	la 9,.LC45@l(9)
	la 10,.LC46@l(10)
	lfd 0,0(9)
	lfd 13,0(10)
	fmul 1,1,0
	frsp 0,1
	fmr 1,0
	fcmpu 0,1,13
	bc 4,1,.L24
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L256
.L24:
	lis 10,.LC47@ha
	la 10,.LC47@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L256:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	mr 11,9
	lis 10,.LC48@ha
	la 10,.LC48@l(10)
	fctiwz 0,13
	lfd 12,0(10)
	lis 10,.LC49@ha
	la 10,.LC49@l(10)
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
.Lfe9:
	.size	 SnapToEights,.Lfe9-SnapToEights
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
.Lfe10:
	.size	 turret_blocked,.Lfe10-turret_blocked
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
	bc 4,2,.L184
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
	b .L185
.L184:
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
.L185:
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
.Lfe11:
	.size	 turret_breach_finish_init,.Lfe11-turret_breach_finish_init
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
.Lfe12:
	.size	 SP_turret_base,.Lfe12-SP_turret_base
	.align 2
	.globl turret_driver_die
	.type	 turret_driver_die,@function
turret_driver_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 8,3
	li 0,0
	lwz 11,324(8)
	stw 0,628(11)
	lwz 9,324(8)
	lwz 9,564(9)
	b .L257
.L199:
	lwz 9,560(9)
.L257:
	lwz 0,560(9)
	cmpw 0,0,8
	bc 4,2,.L199
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
	bl infantry_die
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 turret_driver_die,.Lfe13-turret_driver_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
