	.file	"g_turret.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC3:
	.string	"weapons/rocklf1a.wav"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 2
.LC1:
	.long 0x44098000
	.align 2
.LC2:
	.long 0x3fe66666
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC5:
	.long 0x42480000
	.align 2
.LC6:
	.long 0x42c80000
	.align 2
.LC7:
	.long 0x42f00000
	.align 2
.LC8:
	.long 0x43960000
	.align 2
.LC9:
	.long 0x43160000
	.align 2
.LC10:
	.long 0x3f800000
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl turret_breach_fire
	.type	 turret_breach_fire,@function
turret_breach_fire:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	addi 29,1,24
	addi 28,1,40
	mr 31,3
	addi 30,1,56
	mr 6,28
	addi 4,1,8
	addi 3,31,16
	mr 5,29
	bl AngleVectors
	lfs 1,968(31)
	addi 4,1,8
	addi 3,31,4
	mr 5,30
	bl VectorMA
	lfs 1,972(31)
	mr 4,29
	mr 3,30
	mr 5,30
	bl VectorMA
	lfs 1,976(31)
	mr 5,30
	mr 4,28
	mr 3,30
	bl VectorMA
	bl rand
	rlwinm 3,3,0,17,31
	lwz 5,868(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,140(1)
	lis 10,.LC4@ha
	lis 11,.LC0@ha
	stw 0,136(1)
	la 10,.LC4@l(10)
	lis 8,skill@ha
	lfd 13,0(10)
	cmpwi 0,5,1
	lfd 0,136(1)
	lis 10,.LC5@ha
	lfs 8,.LC0@l(11)
	lis 9,.LC6@ha
	la 10,.LC5@l(10)
	la 9,.LC6@l(9)
	lfs 9,0(10)
	mr 11,7
	fsub 0,0,13
	lfs 7,0(9)
	lis 10,.LC1@ha
	lwz 9,skill@l(8)
	lfs 12,.LC1@l(10)
	frsp 0,0
	lfs 13,20(9)
	fdivs 0,0,8
	fmadds 0,0,9,7
	fmadds 13,13,9,12
	fmr 12,0
	fctiwz 10,12
	fctiwz 11,13
	stfd 10,136(1)
	lwz 6,140(1)
	stfd 11,136(1)
	lwz 7,140(1)
	bc 4,2,.L31
	lis 10,.LC7@ha
	lis 9,.LC2@ha
	lwz 3,256(31)
	la 10,.LC7@l(10)
	lfs 1,.LC2@l(9)
	mr 4,30
	lfs 2,0(10)
	addi 5,1,8
	li 6,120
	li 7,1000
	bl fire_grenade
	b .L32
.L31:
	cmpwi 0,5,2
	bc 4,2,.L33
	lis 9,.LC8@ha
	lwz 3,256(31)
	mr 4,30
	la 9,.LC8@l(9)
	addi 5,1,8
	lfs 1,0(9)
	li 6,300
	li 7,500
	bl fire_bfg
	b .L32
.L33:
	cmpwi 0,5,3
	bc 4,2,.L35
	lwz 3,256(31)
	mr 4,30
	addi 5,1,8
	li 6,15
	li 7,800
	li 8,8
	li 9,0
	bl fire_blaster
	b .L32
.L35:
	cmpwi 0,5,4
	bc 4,2,.L37
	lwz 3,256(31)
	mr 4,30
	addi 5,1,8
	li 6,50
	li 7,100
	li 8,61
	bl monster_fire_railgun
	b .L32
.L37:
	cmpwi 0,5,5
	bc 4,2,.L39
	lis 9,.LC9@ha
	lfs 0,4(31)
	mr 4,30
	la 9,.LC9@l(9)
	lfs 10,72(1)
	addi 5,1,8
	lfs 11,0(9)
	li 7,0
	li 8,0
	lfs 9,8(31)
	li 9,0
	li 10,36
	lfs 13,12(31)
	fmadds 10,10,11,0
	lfs 12,76(1)
	lfs 0,80(1)
	lwz 3,256(31)
	fmadds 12,12,11,9
	stfs 10,56(1)
	fmadds 0,0,11,13
	stfs 12,60(1)
	stfs 0,64(1)
	bl fire_bullet
	b .L32
.L39:
	lis 9,.LC9@ha
	lwz 3,256(31)
	mr 4,30
	la 9,.LC9@l(9)
	addi 5,1,8
	lfs 1,0(9)
	mr 8,6
	bl fire_rocket
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,20(29)
	lis 9,.LC10@ha
	lis 10,.LC10@ha
	lis 11,.LC11@ha
	mr 6,3
	la 9,.LC10@l(9)
	la 10,.LC10@l(10)
	mtlr 0
	la 11,.LC11@l(11)
	mr 4,31
	lfs 1,0(9)
	mr 3,30
	li 5,1
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L32:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe1:
	.size	 turret_breach_fire,.Lfe1-turret_breach_fire
	.section	".rodata"
	.align 2
.LC21:
	.string	"cl_predict 1\n"
	.align 2
.LC22:
	.string	"cl_predict 0\n"
	.align 2
.LC23:
	.string	"Turret mounted\n\nPress USE to fire, JUMP to abandon"
	.align 3
.LC12:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC13:
	.long 0x3f91df46
	.long 0xa2529d39
	.align 3
.LC14:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC15:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC16:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC17:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC18:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC19:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC20:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC24:
	.long 0x43b40000
	.align 2
.LC25:
	.long 0x0
	.align 2
.LC26:
	.long 0x43340000
	.align 2
.LC27:
	.long 0xc3340000
	.align 2
.LC28:
	.long 0x41200000
	.align 3
.LC29:
	.long 0x40200000
	.long 0x0
	.align 3
.LC30:
	.long 0x0
	.long 0x0
	.align 3
.LC31:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC33:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC34:
	.long 0x42000000
	.align 2
.LC35:
	.long 0x41000000
	.align 2
.LC36:
	.long 0xc3960000
	.align 2
.LC37:
	.long 0x42a00000
	.align 2
.LC38:
	.long 0x43160000
	.align 2
.LC39:
	.long 0x3f800000
	.align 3
.LC40:
	.long 0x40500000
	.long 0x0
	.align 2
.LC41:
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
	lis 8,.LC24@ha
	mr 31,3
	la 8,.LC24@l(8)
	lfs 11,16(31)
	addi 9,1,8
	lfs 12,0(8)
	addi 3,1,24
	lfs 13,20(31)
	lfs 0,24(31)
	fcmpu 0,11,12
	stfs 11,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	bc 4,1,.L45
	lis 10,.LC24@ha
	fmr 0,11
	la 10,.LC24@l(10)
	lfs 13,0(10)
.L44:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L44
	stfs 0,0(9)
.L45:
	lis 11,.LC25@ha
	lfs 13,0(9)
	addi 30,31,980
	la 11,.LC25@l(11)
	addi 4,31,632
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L170
	lis 8,.LC24@ha
	lis 10,.LC25@ha
	la 8,.LC24@l(8)
	la 10,.LC25@l(10)
	lfs 11,0(8)
	lfs 12,0(10)
.L48:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L48
	stfs 0,0(9)
.L170:
	lis 11,.LC24@ha
	lfs 13,4(9)
	la 11,.LC24@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L171
	lis 8,.LC24@ha
	la 8,.LC24@l(8)
	lfs 12,0(8)
.L52:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L52
	stfs 0,4(9)
.L171:
	lis 10,.LC25@ha
	lfs 13,4(9)
	la 10,.LC25@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L172
	lis 11,.LC24@ha
	lis 8,.LC25@ha
	la 11,.LC24@l(11)
	la 8,.LC25@l(8)
	lfs 11,0(11)
	lfs 12,0(8)
.L56:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L56
	stfs 0,4(9)
.L172:
	lis 9,.LC24@ha
	lfs 13,980(31)
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L62
	lis 10,.LC24@ha
	lfs 0,0(30)
	la 10,.LC24@l(10)
	lfs 13,0(10)
.L61:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L61
	stfs 0,0(30)
.L62:
	lis 11,.LC25@ha
	lfs 13,0(30)
	la 11,.LC25@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L173
	lis 8,.LC24@ha
	lis 9,.LC25@ha
	la 8,.LC24@l(8)
	la 9,.LC25@l(9)
	lfs 11,0(8)
	lfs 12,0(9)
.L65:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L65
	stfs 0,0(30)
.L173:
	lis 10,.LC24@ha
	lfs 13,4(30)
	la 10,.LC24@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L174
	lis 11,.LC24@ha
	la 11,.LC24@l(11)
	lfs 12,0(11)
.L69:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L69
	stfs 0,4(30)
.L174:
	lis 8,.LC25@ha
	lfs 13,4(30)
	la 8,.LC25@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,0,.L175
	lis 9,.LC24@ha
	lis 10,.LC25@ha
	la 9,.LC24@l(9)
	la 10,.LC25@l(10)
	lfs 11,0(9)
	lfs 12,0(10)
.L73:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L73
	stfs 0,4(30)
.L175:
	lis 11,.LC26@ha
	lfs 13,980(31)
	la 11,.LC26@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L76
	lis 8,.LC24@ha
	la 8,.LC24@l(8)
	lfs 0,0(8)
	fsubs 0,13,0
	stfs 0,980(31)
.L76:
	lfs 13,980(31)
	lfs 0,596(31)
	fcmpu 0,13,0
	bc 12,1,.L193
	lfs 0,608(31)
	fcmpu 0,13,0
	bc 4,0,.L78
.L193:
	stfs 0,980(31)
.L78:
	lfs 13,984(31)
	lfs 0,600(31)
	lfs 10,612(31)
	fmr 12,13
	fcmpu 0,13,0
	fmr 9,0
	bc 12,0,.L81
	fcmpu 0,12,10
	bc 4,1,.L80
.L81:
	fsubs 0,9,12
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 13,0(9)
	fabs 11,0
	fcmpu 0,11,13
	bc 4,0,.L82
	lis 10,.LC24@ha
	la 10,.LC24@l(10)
	lfs 0,0(10)
	fadds 11,11,0
	b .L83
.L82:
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	lfs 0,0(11)
	fcmpu 0,11,0
	bc 4,1,.L83
	lis 8,.LC24@ha
	la 8,.LC24@l(8)
	lfs 0,0(8)
	fsubs 11,11,0
.L83:
	fsubs 0,10,12
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 13,0(9)
	fabs 12,0
	fcmpu 0,12,13
	bc 4,0,.L85
	lis 10,.LC24@ha
	la 10,.LC24@l(10)
	lfs 0,0(10)
	fadds 12,12,0
	b .L86
.L85:
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 4,1,.L86
	lis 8,.LC24@ha
	la 8,.LC24@l(8)
	lfs 0,0(8)
	fsubs 12,12,0
.L86:
	fmr 13,11
	fmr 0,12
	fabs 13,13
	fabs 0,0
	fcmpu 0,13,0
	bc 4,0,.L88
	stfs 9,984(31)
	b .L80
.L88:
	stfs 10,984(31)
.L80:
	lfs 11,980(31)
	lis 9,.LC27@ha
	lfs 0,8(1)
	la 9,.LC27@l(9)
	lfs 10,0(9)
	lfs 13,984(31)
	fsubs 9,11,0
	lfs 12,12(1)
	lfs 0,988(31)
	lfs 11,16(1)
	fcmpu 0,9,10
	stfs 9,24(1)
	fsubs 13,13,12
	fsubs 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bc 4,0,.L90
	lis 10,.LC24@ha
	la 10,.LC24@l(10)
	lfs 0,0(10)
	fadds 0,9,0
	b .L194
.L90:
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	lfs 0,0(11)
	fcmpu 0,9,0
	bc 4,1,.L91
	lis 8,.LC24@ha
	la 8,.LC24@l(8)
	lfs 0,0(8)
	fsubs 0,9,0
.L194:
	stfs 0,24(1)
.L91:
	lis 9,.LC27@ha
	lfs 13,28(1)
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L93
	lis 10,.LC24@ha
	la 10,.LC24@l(10)
	lfs 0,0(10)
	fadds 0,13,0
	b .L195
.L93:
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L94
	lis 8,.LC24@ha
	la 8,.LC24@l(8)
	lfs 0,0(8)
	fsubs 0,13,0
.L195:
	stfs 0,28(1)
.L94:
	lfs 13,572(31)
	lis 9,.LC12@ha
	li 0,0
	lfd 31,.LC12@l(9)
	lfs 0,24(1)
	stw 0,32(1)
	fmul 13,13,31
	fcmpu 0,0,13
	bc 4,1,.L96
	frsp 0,13
	stfs 0,24(1)
.L96:
	lfs 0,572(31)
	lfs 13,24(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L97
	frsp 0,0
	stfs 0,24(1)
.L97:
	lfs 0,572(31)
	lfs 13,28(1)
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,1,.L98
	frsp 0,0
	stfs 0,28(1)
.L98:
	lfs 0,572(31)
	lfs 13,28(1)
	fneg 0,0
	fmul 0,0,31
	fcmpu 0,13,0
	bc 4,0,.L99
	frsp 0,0
	stfs 0,28(1)
.L99:
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 1,0(9)
	bl VectorScale
	lis 9,level+4@ha
	lwz 11,840(31)
	lfs 0,level+4@l(9)
	cmpwi 0,11,0
	fadd 0,0,31
	frsp 0,0
	stfs 0,672(31)
	bc 12,2,.L101
.L103:
	lfs 0,636(31)
	stfs 0,636(11)
	lwz 11,836(11)
	cmpwi 0,11,0
	bc 4,2,.L103
.L101:
	lwz 11,256(31)
	cmpwi 0,11,0
	bc 12,2,.L105
	lwz 0,568(11)
	cmpw 0,0,31
	bc 4,2,.L106
	lfs 0,632(31)
	lis 9,.LC13@ha
	lfd 12,.LC13@l(9)
	stfs 0,632(11)
	lfs 0,636(31)
	lwz 9,256(31)
	stfs 0,636(9)
	lwz 11,256(31)
	lfs 13,20(31)
	lfs 0,972(11)
	lfs 31,4(31)
	fadds 30,13,0
	fmr 0,30
	fmul 0,0,12
	frsp 30,0
	fmr 1,30
	bl cos
	lwz 9,256(31)
	lis 8,.LC29@ha
	lis 10,.LC30@ha
	la 8,.LC29@l(8)
	la 10,.LC30@l(10)
	lfs 0,968(9)
	lfd 13,0(8)
	lfd 12,0(10)
	fmadd 1,1,0,31
	frsp 0,1
	fmul 0,0,13
	frsp 0,0
	fmr 1,0
	fcmpu 0,1,12
	bc 4,1,.L107
	lis 11,.LC31@ha
	la 11,.LC31@l(11)
	lfd 0,0(11)
	fadd 0,1,0
	b .L196
.L107:
	lis 8,.LC31@ha
	la 8,.LC31@l(8)
	lfd 0,0(8)
	fsub 0,1,0
.L196:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lfs 31,8(31)
	mr 11,9
	lis 10,.LC32@ha
	fmr 1,30
	la 10,.LC32@l(10)
	lis 8,.LC33@ha
	fctiwz 0,13
	lfd 11,0(10)
	la 8,.LC33@l(8)
	lfd 12,0(8)
	stfd 0,104(1)
	lwz 9,108(1)
	xoris 9,9,0x8000
	stw 9,108(1)
	stw 0,104(1)
	lfd 0,104(1)
	fsub 0,0,11
	fmul 0,0,12
	frsp 0,0
	stfs 0,56(1)
	bl sin
	lwz 9,256(31)
	lis 8,.LC29@ha
	lis 10,.LC30@ha
	la 8,.LC29@l(8)
	la 10,.LC30@l(10)
	lfs 0,968(9)
	lfd 13,0(8)
	lfd 12,0(10)
	fmadd 1,1,0,31
	frsp 0,1
	fmul 0,0,13
	frsp 0,0
	fmr 1,0
	fcmpu 0,1,12
	bc 4,1,.L110
	lis 11,.LC31@ha
	la 11,.LC31@l(11)
	lfd 0,0(11)
	fadd 0,1,0
	b .L197
.L110:
	lis 8,.LC31@ha
	la 8,.LC31@l(8)
	lfd 0,0(8)
	fsub 0,1,0
.L197:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 7,256(31)
	mr 8,10
	lis 9,.LC32@ha
	lfs 10,12(31)
	la 9,.LC32@l(9)
	lis 11,.LC33@ha
	fctiwz 0,13
	lfd 11,0(9)
	la 11,.LC33@l(11)
	li 6,0
	lfd 12,0(11)
	lis 9,.LC12@ha
	lfd 9,.LC12@l(9)
	lis 11,.LC13@ha
	stfd 0,104(1)
	lwz 10,108(1)
	lfd 8,.LC13@l(11)
	xoris 10,10,0x8000
	stw 10,108(1)
	stw 0,104(1)
	lfd 0,104(1)
	fsub 0,0,11
	fmul 0,0,12
	frsp 0,0
	stfs 0,60(1)
	lfs 13,12(7)
	stfs 13,64(1)
	stfs 10,12(7)
	lwz 9,256(31)
	stw 6,628(9)
	lwz 11,256(31)
	lfs 0,56(1)
	lfs 13,4(11)
	lfs 11,60(1)
	lfs 10,64(1)
	fsubs 0,0,13
	fmr 13,0
	stfs 0,40(1)
	lfs 12,8(11)
	fdiv 13,13,9
	fsubs 11,11,12
	frsp 13,13
	stfs 11,44(1)
	lfs 0,12(11)
	fsubs 10,10,0
	stfs 10,48(1)
	stfs 13,620(11)
	lfs 0,44(1)
	lwz 9,256(31)
	fdiv 0,0,9
	frsp 0,0
	stfs 0,624(9)
	lfs 13,16(31)
	fmul 13,13,8
	frsp 30,13
	fmr 1,30
	bl tan
	lwz 9,256(31)
	lis 8,.LC29@ha
	lis 10,.LC30@ha
	lfs 12,12(31)
	la 8,.LC29@l(8)
	la 10,.LC30@l(10)
	lfs 13,968(9)
	lfs 0,976(9)
	lfd 11,0(8)
	lfd 10,0(10)
	fmadd 13,13,1,12
	fadd 13,13,0
	frsp 0,13
	fmul 0,0,11
	frsp 0,0
	fmr 13,0
	fcmpu 0,13,10
	bc 4,1,.L113
	lis 11,.LC31@ha
	la 11,.LC31@l(11)
	lfd 0,0(11)
	fadd 0,13,0
	b .L198
.L113:
	lis 8,.LC31@ha
	la 8,.LC31@l(8)
	lfd 0,0(8)
	fsub 0,13,0
.L198:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	lwz 8,256(31)
	mr 10,9
	lis 11,.LC32@ha
	la 11,.LC32@l(11)
	lfs 9,12(8)
	fctiwz 0,13
	lfd 10,0(11)
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	stfd 0,104(1)
	lwz 9,108(1)
	lfd 12,0(11)
	xoris 9,9,0x8000
	lis 11,.LC12@ha
	stw 9,108(1)
	stw 0,104(1)
	lfd 0,104(1)
	lfd 11,.LC12@l(11)
	fsub 0,0,10
	fmul 0,0,12
	frsp 0,0
	fsubs 0,0,9
	fmr 13,0
	fdiv 13,13,11
	frsp 13,13
	stfs 13,628(8)
	lwz 0,288(31)
	andis. 8,0,1
	bc 12,2,.L41
	mr 3,31
	bl turret_breach_fire
	lwz 0,288(31)
	rlwinm 0,0,0,16,14
	stw 0,288(31)
	b .L41
.L106:
	li 0,3
	addi 27,31,16
	mtctr 0
	addi 28,1,72
	mr 8,30
	li 10,0
.L192:
	lwz 9,256(31)
	lwz 11,84(9)
	addi 11,11,3752
	lfsx 0,11,10
	stfsx 0,10,8
	addi 10,10,4
	bdnz .L192
	lis 8,.LC24@ha
	lfs 13,980(31)
	la 8,.LC24@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,1,.L126
	lis 9,.LC24@ha
	lfs 0,0(30)
	la 9,.LC24@l(9)
	lfs 13,0(9)
.L125:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L125
	stfs 0,0(30)
.L126:
	lis 10,.LC25@ha
	lfs 13,0(30)
	la 10,.LC25@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,0,.L176
	lis 11,.LC24@ha
	lis 8,.LC25@ha
	la 11,.LC24@l(11)
	la 8,.LC25@l(8)
	lfs 11,0(11)
	lfs 12,0(8)
.L129:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L129
	stfs 0,0(30)
.L176:
	lis 9,.LC24@ha
	lfs 13,4(30)
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L177
	lis 10,.LC24@ha
	la 10,.LC24@l(10)
	lfs 12,0(10)
.L133:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L133
	stfs 0,4(30)
.L177:
	lis 11,.LC25@ha
	lfs 13,4(30)
	la 11,.LC25@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L178
	lis 8,.LC24@ha
	lis 9,.LC25@ha
	la 8,.LC24@l(8)
	la 9,.LC25@l(9)
	lfs 11,0(8)
	lfs 12,0(9)
.L137:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L137
	stfs 0,4(30)
.L178:
	li 5,0
	li 6,0
	mr 3,27
	mr 4,28
	bl AngleVectors
	lis 8,.LC34@ha
	mr 4,28
	la 8,.LC34@l(8)
	mr 3,28
	lfs 1,0(8)
	bl VectorScale
	lfs 11,72(1)
	lis 8,.LC25@ha
	lis 9,.LC25@ha
	lfs 12,4(31)
	lis 10,.LC35@ha
	la 8,.LC25@l(8)
	lfs 13,8(31)
	la 9,.LC25@l(9)
	la 10,.LC35@l(10)
	lfs 10,76(1)
	fsubs 12,12,11
	lfs 0,12(31)
	lfs 11,80(1)
	fsubs 13,13,10
	lfs 1,0(8)
	lfs 2,0(9)
	fsubs 0,0,11
	lfs 3,0(10)
	stfs 13,44(1)
	stfs 12,40(1)
	stfs 0,48(1)
	bl tv
	lfs 0,40(1)
	lis 9,.LC25@ha
	lis 8,.LC25@ha
	lfs 13,0(3)
	la 9,.LC25@l(9)
	lis 10,.LC35@ha
	la 8,.LC25@l(8)
	lfs 2,0(9)
	la 10,.LC35@l(10)
	lfs 1,0(8)
	fadds 0,0,13
	lfs 3,0(10)
	lwz 9,256(31)
	stfs 0,4(9)
	bl tv
	lfs 13,4(3)
	lis 9,.LC25@ha
	lis 8,.LC25@ha
	lfs 0,44(1)
	la 9,.LC25@l(9)
	lis 10,.LC35@ha
	la 8,.LC25@l(8)
	lfs 2,0(9)
	la 10,.LC35@l(10)
	lfs 1,0(8)
	fadds 0,0,13
	lwz 9,256(31)
	lfs 3,0(10)
	stfs 0,8(9)
	bl tv
	lfs 13,8(3)
	lis 11,gi+72@ha
	lfs 0,48(1)
	lwz 9,256(31)
	fadds 0,0,13
	stfs 0,12(9)
	lwz 0,gi+72@l(11)
	lwz 3,256(31)
	mtlr 0
	blrl
	lis 8,.LC25@ha
	lfs 13,880(31)
	la 8,.LC25@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L140
	lis 0,0x4120
	stw 0,880(31)
.L140:
	lfs 0,880(31)
	lwz 9,256(31)
	lwz 11,84(9)
	lwz 0,3632(11)
	fctiwz 13,0
	andi. 9,0,2
	stfd 13,104(1)
	lwz 30,108(1)
	bc 12,2,.L141
	lis 9,level@ha
	lfs 13,888(31)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,13,0
	bc 4,0,.L141
	mr 3,31
	bl turret_breach_fire
	lis 0,0x6666
	srawi 10,30,31
	lfs 13,4(29)
	ori 0,0,26215
	mulhw 0,30,0
	lis 11,0x4330
	lis 8,.LC32@ha
	la 8,.LC32@l(8)
	cmpwi 0,30,1
	srawi 0,0,2
	lfd 12,0(8)
	subf 0,10,0
	xoris 0,0,0x8000
	stw 0,108(1)
	stw 11,104(1)
	lfd 0,104(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,888(31)
	bc 4,2,.L142
	lfs 0,4(29)
	lis 9,.LC12@ha
	lfd 13,.LC12@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L142:
	cmpwi 0,30,2
	bc 4,2,.L143
	lfs 0,4(29)
	lis 9,.LC14@ha
	lfd 13,.LC14@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L143:
	cmpwi 0,30,3
	bc 4,2,.L144
	lfs 0,4(29)
	lis 9,.LC15@ha
	lfd 13,.LC15@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L144:
	cmpwi 0,30,4
	bc 4,2,.L145
	lfs 0,4(29)
	lis 9,.LC16@ha
	lfd 13,.LC16@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L145:
	cmpwi 0,30,5
	bc 4,2,.L146
	lfs 0,4(29)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L146:
	cmpwi 0,30,6
	bc 4,2,.L147
	lfs 0,4(29)
	lis 9,.LC17@ha
	lfd 13,.LC17@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L147:
	cmpwi 0,30,7
	bc 4,2,.L148
	lfs 0,4(29)
	lis 9,.LC18@ha
	lfd 13,.LC18@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L148:
	cmpwi 0,30,8
	bc 4,2,.L149
	lfs 0,4(29)
	lis 9,.LC19@ha
	lfd 13,.LC19@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L149:
	cmpwi 0,30,9
	bc 4,2,.L141
	lfs 0,4(29)
	lis 9,.LC20@ha
	lfd 13,.LC20@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,888(31)
.L141:
	lwz 9,256(31)
	lwz 0,728(9)
	cmpwi 0,0,0
	bc 12,1,.L151
	lwz 9,84(9)
	li 0,50
	sth 0,14(9)
.L151:
	lwz 30,256(31)
	lwz 9,84(30)
	lha 0,14(9)
	cmpwi 0,0,30
	bc 4,1,.L41
	li 9,0
	li 0,0
	stw 9,912(31)
	mr 3,27
	mr 4,28
	stw 0,980(31)
	li 5,0
	li 6,0
	bl AngleVectors
	lis 8,.LC36@ha
	mr 3,28
	la 8,.LC36@l(8)
	mr 4,28
	lfs 1,0(8)
	bl VectorScale
	lis 9,.LC38@ha
	lfs 0,80(1)
	lis 8,.LC37@ha
	la 9,.LC38@l(9)
	la 8,.LC37@l(8)
	lfs 13,0(9)
	lfs 12,0(8)
	fadds 0,0,13
	fcmpu 0,0,12
	stfs 0,80(1)
	bc 4,0,.L153
	stfs 12,80(1)
.L153:
	li 10,3
	mr 3,28
	mtctr 10
	addi 11,30,620
	li 9,0
.L191:
	lfsx 0,9,3
	stfsx 0,9,11
	addi 9,9,4
	bdnz .L191
	lis 11,.LC39@ha
	lfs 0,12(30)
	li 0,4
	la 11,.LC39@l(11)
	stw 0,264(30)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,12(30)
	lwz 9,256(31)
	lwz 0,728(9)
	cmpwi 0,0,0
	bc 12,1,.L159
	li 0,7
	stw 0,264(30)
.L159:
	stfs 13,652(30)
	li 29,0
	lis 28,gi@ha
	la 28,gi@l(28)
	stw 29,912(31)
	li 3,11
	lwz 9,100(28)
	mtlr 9
	blrl
	lwz 9,116(28)
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	mtlr 9
	blrl
	lwz 9,92(28)
	mr 3,30
	li 4,1
	mtlr 9
	blrl
	lwz 0,72(28)
	mr 3,30
	mtlr 0
	blrl
	stw 29,256(31)
	b .L41
.L105:
	lis 9,maxclients@ha
	lis 8,.LC25@ha
	lwz 10,maxclients@l(9)
	la 8,.LC25@l(8)
	lis 11,g_edicts@ha
	lfs 13,0(8)
	li 27,0
	lis 24,maxclients@ha
	lfs 0,20(10)
	lwz 29,g_edicts@l(11)
	fcmpu 0,13,0
	addi 29,29,1268
	bc 4,0,.L41
	lis 9,gi@ha
	addi 28,1,56
	la 30,gi@l(9)
	li 26,0
	lis 25,0x4330
.L164:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L163
	addi 3,31,16
	mr 4,28
	li 5,0
	li 6,0
	bl AngleVectors
	lis 8,.LC34@ha
	mr 3,28
	la 8,.LC34@l(8)
	mr 4,28
	lfs 1,0(8)
	bl VectorScale
	lfs 13,4(31)
	lis 8,.LC40@ha
	lfs 0,56(1)
	la 8,.LC40@l(8)
	lfs 11,8(31)
	lfs 12,12(31)
	fsubs 13,13,0
	lfs 10,60(1)
	lfs 0,64(1)
	lfd 9,0(8)
	fsubs 11,11,10
	stfs 13,40(1)
	fsubs 12,12,0
	stfs 11,44(1)
	stfs 12,48(1)
	lfs 0,4(29)
	fsubs 13,13,0
	stfs 13,88(1)
	lfs 0,8(29)
	fsubs 11,11,0
	stfs 11,92(1)
	lfs 13,12(29)
	fsubs 12,12,13
	fmr 0,12
	stfs 12,96(1)
	fabs 0,0
	fcmpu 0,0,9
	bc 4,0,.L166
	stw 26,96(1)
.L166:
	addi 3,1,88
	bl VectorLength
	lis 8,.LC41@ha
	la 8,.LC41@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 4,0,.L163
	lwz 0,728(29)
	cmpwi 0,0,1
	bc 4,1,.L41
	stw 29,256(31)
	li 0,1
	li 9,2
	stw 0,912(29)
	li 3,11
	stw 9,264(29)
	stw 26,652(29)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,116(30)
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
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
	lis 4,.LC23@ha
	mr 3,29
	la 4,.LC23@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
.L163:
	addi 27,27,1
	lwz 11,maxclients@l(24)
	xoris 0,27,0x8000
	lis 8,.LC32@ha
	stw 0,108(1)
	la 8,.LC32@l(8)
	addi 29,29,1268
	stw 25,104(1)
	lfd 13,0(8)
	lfd 0,104(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L164
.L41:
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
.LC42:
	.string	"%s at %s needs a target\n"
	.align 3
.LC43:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC44:
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
	lis 9,.LC44@ha
	lfs 0,572(31)
	la 9,.LC44@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L203
	lis 0,0x4248
	stw 0,572(31)
.L203:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L204
	li 0,10
	stw 0,792(31)
.L204:
	lis 9,st@ha
	la 7,st@l(9)
	lfs 0,60(7)
	fcmpu 0,0,13
	bc 4,2,.L205
	lis 0,0xc1f0
	stw 0,60(7)
.L205:
	lfs 0,64(7)
	fcmpu 0,0,13
	bc 4,2,.L206
	lis 0,0x41f0
	stw 0,64(7)
.L206:
	lfs 0,56(7)
	fcmpu 0,0,13
	bc 4,2,.L207
	lis 0,0x43b4
	stw 0,56(7)
.L207:
	lfs 0,60(7)
	lis 11,turret_blocked@ha
	lis 10,turret_breach_finish_init@ha
	lfs 11,20(31)
	la 11,turret_blocked@l(11)
	la 10,turret_breach_finish_init@l(10)
	lis 8,level+4@ha
	lis 9,.LC43@ha
	fneg 0,0
	lfd 12,.LC43@l(9)
	mr 3,31
	stfs 0,596(31)
	lfs 13,52(7)
	stfs 13,600(31)
	lfs 0,64(7)
	fneg 0,0
	stfs 0,608(31)
	lfs 13,56(7)
	stfs 11,984(31)
	stw 11,684(31)
	stfs 13,612(31)
	stw 10,680(31)
	stfs 11,668(31)
	lfs 0,level+4@l(8)
	fadd 0,0,12
	frsp 0,0
	stfs 0,672(31)
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
.LC45:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC47:
	.long 0x40400000
	.align 3
.LC48:
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
	lis 11,.LC45@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC45@l(11)
	lwz 9,816(31)
	cmpwi 0,9,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	bc 12,2,.L226
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L217
	lwz 0,728(9)
	cmpwi 0,0,0
	bc 12,1,.L216
.L217:
	li 0,0
	stw 0,816(31)
.L216:
	lwz 4,816(31)
	cmpwi 0,4,0
	bc 4,2,.L218
.L226:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 12,2,.L215
	lis 9,level+4@ha
	lwz 0,1128(31)
	lfs 0,level+4@l(9)
	rlwinm 0,0,0,29,27
	b .L227
.L218:
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L221
	lwz 0,1128(31)
	ori 0,0,8
	stw 0,1128(31)
	b .L215
.L221:
	lwz 0,1128(31)
	andi. 9,0,8
	bc 12,2,.L220
	lis 9,level+4@ha
	rlwinm 0,0,0,29,27
	lfs 0,level+4@l(9)
.L227:
	stw 0,1128(31)
	stfs 0,1204(31)
.L220:
	lwz 9,816(31)
	lis 10,.LC46@ha
	la 10,.LC46@l(10)
	lis 8,0x4330
	lfs 12,4(9)
	addi 3,1,24
	lfd 10,0(10)
	lwz 10,568(31)
	stfs 12,8(1)
	lfs 11,8(9)
	addi 4,10,980
	stfs 11,12(1)
	lfs 13,12(9)
	stfs 13,16(1)
	lwz 0,784(9)
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
	lfs 0,1184(31)
	lfs 11,level+4@l(9)
	fcmpu 0,11,0
	bc 12,0,.L215
	lis 9,.LC47@ha
	lis 11,skill@ha
	lfs 13,1204(31)
	la 9,.LC47@l(9)
	lfs 12,0(9)
	lwz 9,skill@l(11)
	fsubs 13,11,13
	lfs 0,20(9)
	fsubs 0,12,0
	fcmpu 0,13,0
	bc 12,0,.L215
	fadds 0,11,0
	lis 10,.LC48@ha
	lwz 9,568(31)
	la 10,.LC48@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1184(31)
	lwz 0,288(9)
	oris 0,0,0x1
	stw 0,288(9)
.L215:
	lwz 0,68(1)
	mtlr 0
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 turret_driver_think,.Lfe4-turret_driver_think
	.section	".rodata"
	.align 3
.LC49:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC50:
	.long 0x43b40000
	.align 2
.LC51:
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
	lwz 3,532(31)
	stw 9,680(31)
	lis 11,.LC49@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC49@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	bl G_PickTarget
	mr 11,3
	li 0,0
	stw 11,568(31)
	addi 3,1,8
	stw 31,256(11)
	lwz 9,568(31)
	lwz 11,840(9)
	stw 31,256(11)
	lwz 9,568(31)
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
	lwz 9,568(31)
	addi 3,1,8
	stfs 1,968(31)
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
	lis 11,.LC50@ha
	lfs 13,8(1)
	addi 9,1,8
	la 11,.LC50@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L232
	lis 11,.LC50@ha
	fmr 0,13
	la 11,.LC50@l(11)
	lfs 13,0(11)
.L231:
	fsubs 0,0,13
	fcmpu 0,0,13
	bc 12,1,.L231
	stfs 0,0(9)
.L232:
	lis 11,.LC51@ha
	lfs 13,0(9)
	la 11,.LC51@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L251
	lis 11,.LC50@ha
	la 11,.LC50@l(11)
	lfs 11,0(11)
	lis 11,.LC51@ha
	la 11,.LC51@l(11)
	lfs 12,0(11)
.L235:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L235
	stfs 0,0(9)
.L251:
	lis 11,.LC50@ha
	lfs 13,4(9)
	la 11,.LC50@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L252
	lis 11,.LC50@ha
	la 11,.LC50@l(11)
	lfs 12,0(11)
.L239:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L239
	stfs 0,4(9)
.L252:
	lis 11,.LC51@ha
	lfs 13,4(9)
	la 11,.LC51@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L253
	lis 11,.LC50@ha
	la 11,.LC50@l(11)
	lfs 11,0(11)
	lis 11,.LC51@ha
	la 11,.LC51@l(11)
	lfs 12,0(11)
.L243:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L243
	stfs 0,4(9)
.L253:
	lfs 0,12(1)
	lwz 9,568(31)
	stfs 0,972(31)
	lfs 13,12(9)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,976(31)
	lwz 9,840(9)
	b .L258
.L248:
	lwz 9,836(9)
.L258:
	lwz 0,836(9)
	cmpwi 0,0,0
	bc 4,2,.L248
	stw 31,836(9)
	lwz 9,568(31)
	lwz 0,268(31)
	lwz 11,840(9)
	ori 0,0,1024
	stw 0,268(31)
	stw 11,840(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 turret_driver_link,.Lfe5-turret_driver_link
	.section	".rodata"
	.align 2
.LC52:
	.string	"models/monsters/infantry/tris.md2"
	.align 2
.LC53:
	.string	"%s at %s has bad item: %s\n"
	.align 3
.LC54:
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
	stw 29,264(31)
	lis 3,.LC52@ha
	la 27,gi@l(9)
	stw 29,248(31)
	la 3,.LC52@l(3)
	lwz 9,32(27)
	mtlr 9
	blrl
	lis 9,turret_driver_die@ha
	lwz 6,268(31)
	lis 0,0xc1c0
	la 9,turret_driver_die@l(9)
	stw 3,40(31)
	lis 7,infantry_stand@ha
	stw 9,700(31)
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
	stw 10,728(31)
	li 5,0
	li 4,24
	stw 0,644(31)
	lis 11,level@ha
	stw 28,192(31)
	la 30,st@l(9)
	stw 3,204(31)
	la 11,level@l(11)
	lis 8,monster_use@ha
	stw 5,760(31)
	lis 10,0x202
	la 8,monster_use@l(8)
	stw 4,784(31)
	ori 10,10,3
	stw 7,1140(31)
	stw 6,268(31)
	stw 28,188(31)
	stw 3,200(31)
	lwz 9,284(11)
	addi 9,9,1
	stw 9,284(11)
	lwz 0,184(31)
	lwz 9,68(31)
	lwz 11,1128(31)
	ori 0,0,4
	lfs 12,4(31)
	ori 9,9,64
	lfs 13,8(31)
	ori 11,11,2049
	lfs 0,12(31)
	stw 0,184(31)
	stw 9,68(31)
	stw 29,788(31)
	stw 8,692(31)
	stw 10,252(31)
	stfs 12,28(31)
	stfs 13,32(31)
	stfs 0,36(31)
	stw 11,1128(31)
	lwz 3,44(30)
	cmpwi 0,3,0
	bc 12,2,.L260
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,1000(31)
	bc 4,2,.L260
	lwz 29,284(31)
	addi 3,31,4
	bl vtos
	mr 5,3
	lwz 0,4(27)
	mr 4,29
	lis 3,.LC53@ha
	lwz 6,44(30)
	la 3,.LC53@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L260:
	lis 9,turret_driver_link@ha
	lis 10,level+4@ha
	la 9,turret_driver_link@l(9)
	lis 11,.LC54@ha
	stw 9,680(31)
	lis 8,gi+72@ha
	mr 3,31
	lfs 0,level+4@l(10)
	lfd 13,.LC54@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_turret_driver,.Lfe6-SP_turret_driver
	.section	".rodata"
	.align 2
.LC55:
	.long 0x43b40000
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.globl AnglesNormalize
	.type	 AnglesNormalize,@function
AnglesNormalize:
	lis 9,.LC55@ha
	lfs 13,0(3)
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L8
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 12,0(9)
.L9:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L9
	stfs 0,0(3)
.L8:
	lis 9,.LC56@ha
	lfs 13,0(3)
	la 9,.LC56@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L262
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 11,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 12,0(9)
.L13:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L13
	stfs 0,0(3)
.L262:
	lis 9,.LC55@ha
	lfs 13,4(3)
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L263
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 12,0(9)
.L17:
	fsubs 0,13,12
	fcmpu 0,0,12
	fmr 13,0
	bc 12,1,.L17
	stfs 0,4(3)
.L263:
	lis 9,.LC56@ha
	lfs 13,4(3)
	la 9,.LC56@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bclr 4,0
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 11,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 12,0(9)
.L21:
	fadds 0,13,11
	fcmpu 0,0,12
	fmr 13,0
	bc 12,0,.L21
	stfs 0,4(3)
	blr
.Lfe7:
	.size	 AnglesNormalize,.Lfe7-AnglesNormalize
	.section	".rodata"
	.align 3
.LC57:
	.long 0x40200000
	.long 0x0
	.align 3
.LC58:
	.long 0x0
	.long 0x0
	.align 3
.LC59:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC60:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC61:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SnapToEights
	.type	 SnapToEights,@function
SnapToEights:
	stwu 1,-16(1)
	lis 9,.LC57@ha
	lis 10,.LC58@ha
	la 9,.LC57@l(9)
	la 10,.LC58@l(10)
	lfd 0,0(9)
	lfd 13,0(10)
	fmul 1,1,0
	frsp 0,1
	fmr 1,0
	fcmpu 0,1,13
	bc 4,1,.L24
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfd 0,0(9)
	fadd 0,1,0
	b .L269
.L24:
	lis 10,.LC59@ha
	la 10,.LC59@l(10)
	lfd 0,0(10)
	fsub 0,1,0
.L269:
	frsp 0,0
	fmr 13,0
	lis 0,0x4330
	mr 11,9
	lis 10,.LC60@ha
	la 10,.LC60@l(10)
	fctiwz 0,13
	lfd 12,0(10)
	lis 10,.LC61@ha
	la 10,.LC61@l(10)
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
.Lfe8:
	.size	 SnapToEights,.Lfe8-SnapToEights
	.align 2
	.globl turret_blocked
	.type	 turret_blocked,@function
turret_blocked:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 0,788(4)
	mr 9,3
	cmpwi 0,0,0
	bc 12,2,.L27
	lwz 11,840(9)
	mr 3,4
	li 10,0
	mr 4,9
	lis 6,vec3_origin@ha
	lwz 5,256(11)
	la 6,vec3_origin@l(6)
	li 29,32
	lwz 9,792(11)
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
.Lfe9:
	.size	 turret_blocked,.Lfe9-turret_blocked
	.align 2
	.globl turret_breach_finish_init
	.type	 turret_breach_finish_init,@function
turret_breach_finish_init:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,532(31)
	cmpwi 0,3,0
	bc 4,2,.L200
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC42@ha
	la 3,.LC42@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L201
.L200:
	bl G_PickTarget
	mr 9,3
	lfs 0,4(31)
	stw 9,568(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,968(31)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,972(31)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,976(31)
	bl G_FreeEdict
.L201:
	lis 9,turret_breach_think@ha
	lwz 11,840(31)
	mr 3,31
	la 9,turret_breach_think@l(9)
	lwz 0,792(31)
	mtlr 9
	stw 0,792(11)
	stw 9,680(31)
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
	stw 9,264(29)
	lwz 9,44(28)
	lwz 4,272(29)
	mtlr 9
	blrl
	lis 9,turret_blocked@ha
	mr 3,29
	la 9,turret_blocked@l(9)
	stw 9,684(29)
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
	.globl turret_driver_die
	.type	 turret_driver_die,@function
turret_driver_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 8,3
	li 0,0
	lwz 11,568(8)
	stw 0,980(11)
	lwz 9,568(8)
	lwz 9,840(9)
	b .L270
.L212:
	lwz 9,836(9)
.L270:
	lwz 0,836(9)
	cmpw 0,0,8
	bc 4,2,.L212
	li 10,0
	mr 3,8
	stw 10,836(9)
	lwz 0,268(8)
	lwz 11,568(8)
	rlwinm 0,0,0,22,20
	stw 10,840(8)
	stw 0,268(8)
	stw 10,256(11)
	lwz 9,568(8)
	lwz 11,840(9)
	stw 10,256(11)
	bl infantry_die
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 turret_driver_die,.Lfe12-turret_driver_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
