	.file	"p_view.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 power_color.9,@object
	.size	 power_color.9,12
power_color.9:
	.long 0x0
	.long 0x3f800000
	.long 0x0
	.align 2
	.type	 acolor.10,@object
	.size	 acolor.10,12
acolor.10:
	.long 0x3f800000
	.long 0x3f800000
	.long 0x3f800000
	.align 2
	.type	 bcolor.11,@object
	.size	 bcolor.11,12
bcolor.11:
	.long 0x3f800000
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 2
.LC0:
	.string	""
	.align 2
.LC1:
	.string	"weapon_saber"
	.align 2
.LC4:
	.string	"*pain%i_%i.wav"
	.align 2
.LC2:
	.long 0x46fffe00
	.align 3
.LC3:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC5:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC6:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC7:
	.long 0x3e4ccccd
	.align 3
.LC8:
	.long 0x3fe33333
	.long 0x33333333
	.align 2
.LC9:
	.long 0x3f19999a
	.align 3
.LC10:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x41c80000
	.align 3
.LC14:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC15:
	.long 0x41200000
	.align 2
.LC16:
	.long 0x3f800000
	.align 2
.LC17:
	.long 0x42c80000
	.align 2
.LC18:
	.long 0x42480000
	.section	".text"
	.align 2
	.globl P_DamageFeedback
	.type	 P_DamageFeedback,@function
P_DamageFeedback:
	stwu 1,-96(1)
	mflr 0
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 29,52(1)
	stw 0,100(1)
	mr 30,3
	lwz 9,84(30)
	lwz 3,1764(9)
	cmpwi 0,3,0
	bc 12,2,.L12
	lwz 3,0(3)
	b .L13
.L12:
	lis 9,.LC0@ha
	la 3,.LC0@l(9)
.L13:
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strcmp
	lwz 31,84(30)
	subfic 0,3,0
	adde 3,0,3
	li 0,0
	lwz 9,4160(31)
	sth 0,150(31)
	cmpwi 0,9,0
	bc 12,2,.L16
	li 0,1
	sth 0,150(31)
.L16:
	lwz 0,4160(31)
	lis 11,0x4330
	lis 8,.LC11@ha
	lis 10,.LC12@ha
	xoris 0,0,0x8000
	la 8,.LC11@l(8)
	stw 0,44(1)
	la 10,.LC12@l(10)
	stw 11,40(1)
	lfd 13,0(8)
	lfd 0,40(1)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 31,0
	fcmpu 0,31,12
	bc 12,2,.L11
	lwz 0,4312(31)
	cmpwi 0,0,2
	bc 12,1,.L18
	lwz 0,40(30)
	cmpwi 0,0,255
	bc 4,2,.L18
	lwz 9,4828(31)
	li 0,3
	stw 0,4312(31)
	cmpwi 0,9,0
	bc 12,2,.L19
	cmpwi 0,9,2
	bc 4,1,.L20
	li 0,46
	li 9,49
	b .L46
.L20:
	li 0,45
	li 9,49
	b .L46
.L19:
	lbz 0,16(31)
	andi. 11,0,1
	bc 12,2,.L23
	cmpwi 0,3,0
	bc 4,2,.L23
	li 0,127
	li 9,131
	b .L46
.L23:
	lwz 0,612(30)
	cmpwi 0,0,1
	bc 4,1,.L25
	li 0,171
	li 9,174
	b .L46
.L25:
	lis 8,.LC13@ha
	la 8,.LC13@l(8)
	lfs 0,0(8)
	fcmpu 0,31,0
	cror 3,2,0
	bc 4,3,.L27
	li 0,40
	li 9,44
	b .L46
.L27:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,44(1)
	lis 8,.LC11@ha
	lis 11,.LC2@ha
	la 8,.LC11@l(8)
	stw 0,40(1)
	lis 10,.LC14@ha
	lfd 13,0(8)
	la 10,.LC14@l(10)
	lfd 0,40(1)
	lfs 12,.LC2@l(11)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L29
	li 0,33
	li 9,36
	b .L46
.L29:
	li 0,36
	li 9,40
.L46:
	stw 0,56(30)
	stw 9,4308(31)
.L18:
	lis 11,.LC15@ha
	fmr 28,31
	la 11,.LC15@l(11)
	lfs 0,0(11)
	fcmpu 0,28,0
	bc 4,0,.L31
	lis 8,.LC15@ha
	la 8,.LC15@l(8)
	lfs 31,0(8)
.L31:
	lis 9,level@ha
	lfs 13,464(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L32
	lwz 0,264(30)
	andi. 9,0,16
	bc 4,2,.L32
	bl rand
	lfs 0,4(29)
	lis 9,.LC3@ha
	rlwinm 3,3,0,31,31
	lfd 13,.LC3@l(9)
	addi 5,3,1
	lwz 0,480(30)
	cmpwi 0,0,24
	fadd 0,0,13
	frsp 0,0
	stfs 0,464(30)
	bc 12,1,.L33
	li 4,25
	b .L34
.L33:
	cmpwi 0,0,49
	bc 12,1,.L35
	li 4,50
	b .L34
.L35:
	cmpwi 7,0,74
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,100
	andi. 9,9,75
	or 4,0,9
.L34:
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC16@ha
	lis 9,.LC16@ha
	lis 10,.LC12@ha
	mr 5,3
	la 8,.LC16@l(8)
	la 9,.LC16@l(9)
	mtlr 0
	la 10,.LC12@l(10)
	li 4,2
	lfs 1,0(8)
	mr 3,30
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L32:
	lis 8,.LC12@ha
	lfs 0,4232(31)
	la 8,.LC12@l(8)
	lfs 30,0(8)
	fcmpu 0,0,30
	bc 4,0,.L39
	stfs 30,4232(31)
.L39:
	lfs 13,4232(31)
	lis 9,.LC5@ha
	fmr 29,31
	lis 11,.LC6@ha
	lfd 0,.LC5@l(9)
	lfd 12,.LC6@l(11)
	fmadd 0,29,0,13
	frsp 0,0
	fmr 13,0
	stfs 0,4232(31)
	fcmpu 0,13,12
	bc 4,0,.L40
	lis 9,.LC7@ha
	lfs 0,.LC7@l(9)
	stfs 0,4232(31)
.L40:
	lfs 0,4232(31)
	lis 9,.LC8@ha
	lfd 13,.LC8@l(9)
	fcmpu 0,0,13
	bc 4,1,.L41
	lis 9,.LC9@ha
	lfs 0,.LC9@l(9)
	stfs 0,4232(31)
.L41:
	stfs 30,16(1)
	stfs 30,12(1)
	stfs 30,8(1)
	lwz 0,4160(31)
	cmpwi 0,0,0
	bc 12,2,.L42
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	stw 11,40(1)
	addi 3,1,8
	lfd 0,0(10)
	lis 4,bcolor.11@ha
	mr 5,3
	lfd 1,40(1)
	la 4,bcolor.11@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,28
	bl VectorMA
.L42:
	lis 8,.LC11@ha
	lwz 11,4164(31)
	la 8,.LC11@l(8)
	lfs 0,8(1)
	lis 10,0x4330
	lfd 10,0(8)
	srawi 8,11,31
	xor 0,8,11
	stfs 0,4240(31)
	subf 0,8,0
	lfs 13,12(1)
	xoris 0,0,0x8000
	stw 0,44(1)
	stw 10,40(1)
	lfd 0,40(1)
	stfs 13,4244(31)
	lfs 12,16(1)
	fsub 0,0,10
	stfs 12,4248(31)
	frsp 31,0
	fcmpu 0,31,30
	bc 12,2,.L43
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L43
	xoris 0,0,0x8000
	lis 11,.LC17@ha
	stw 0,44(1)
	la 11,.LC17@l(11)
	lis 8,.LC14@ha
	stw 10,40(1)
	la 8,.LC14@l(8)
	lfd 0,40(1)
	lfs 12,0(11)
	lfd 30,0(8)
	fsub 0,0,10
	fmuls 12,31,12
	fmul 11,29,30
	frsp 0,0
	fdivs 31,12,0
	fmr 13,31
	fcmpu 0,13,11
	bc 4,0,.L44
	frsp 31,11
.L44:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,1,.L45
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	lfs 31,0(10)
.L45:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4168(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,4172(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,4176(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize
	lis 9,right@ha
	lfs 0,12(1)
	lis 10,.LC10@ha
	la 11,right@l(9)
	lfs 10,right@l(9)
	lis 8,forward@ha
	lfs 12,4(11)
	la 9,forward@l(8)
	lis 7,level+4@ha
	lfs 13,8(1)
	lfs 11,8(11)
	fmuls 0,0,12
	lfd 8,.LC10@l(10)
	lfs 12,16(1)
	fmadds 13,13,10,0
	fmadds 0,12,11,13
	fmuls 0,31,0
	fmul 0,0,8
	frsp 0,0
	stfs 0,4212(31)
	lfs 0,4(9)
	lfs 12,12(1)
	lfs 9,forward@l(8)
	lfs 13,8(1)
	fmuls 12,12,0
	lfs 10,8(9)
	lfs 11,16(1)
	fmadds 13,13,9,12
	fnmadds 0,11,10,13
	fmuls 0,31,0
	fmul 0,0,8
	frsp 0,0
	stfs 0,4216(31)
	lfs 13,level+4@l(7)
	fadd 13,13,30
	frsp 13,13
	stfs 13,4220(31)
.L43:
	li 0,0
	stw 0,4164(31)
	stw 0,4160(31)
	stw 0,4156(31)
.L11:
	lwz 0,100(1)
	mtlr 0
	lmw 29,52(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 P_DamageFeedback,.Lfe1-P_DamageFeedback
	.section	".rodata"
	.align 3
.LC19:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC20:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0x40c00000
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC24:
	.long 0xc1600000
	.align 2
.LC25:
	.long 0x41600000
	.align 2
.LC26:
	.long 0xc1b00000
	.align 2
.LC27:
	.long 0x41f00000
	.align 2
.LC28:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl SV_CalcViewOffset
	.type	 SV_CalcViewOffset,@function
SV_CalcViewOffset:
	stwu 1,-48(1)
	stmw 30,40(1)
	mr 12,3
	lwz 0,492(12)
	lwz 31,84(12)
	cmpwi 0,0,0
	addi 30,31,52
	bc 12,2,.L48
	li 0,0
	lis 10,0x4220
	stw 0,4(30)
	lis 8,0xc170
	stw 0,8(30)
	stw 0,52(31)
	lwz 9,84(12)
	stw 10,36(9)
	lwz 11,84(12)
	stw 8,28(11)
	lwz 9,84(12)
	lfs 0,4180(9)
	stfs 0,32(9)
	b .L49
.L48:
	lfs 0,4188(31)
	lis 9,level@ha
	lis 11,.LC21@ha
	la 10,level@l(9)
	la 11,.LC21@l(11)
	lfs 11,0(11)
	stfs 0,52(31)
	lwz 9,84(12)
	lfs 0,4192(9)
	stfs 0,4(30)
	lwz 9,84(12)
	lfs 0,4196(9)
	stfs 0,8(30)
	lwz 9,84(12)
	lfs 13,4(10)
	lfs 0,4220(9)
	fsubs 0,0,13
	fadd 0,0,0
	frsp 9,0
	fcmpu 0,9,11
	bc 4,0,.L50
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 9,0(11)
	stfs 9,4216(9)
	lwz 9,84(12)
	stfs 9,4212(9)
.L50:
	lwz 9,84(12)
	lis 11,.LC19@ha
	lfs 13,52(31)
	lfs 0,4216(9)
	lfd 12,.LC19@l(11)
	fmadds 0,9,0,13
	stfs 0,52(31)
	lwz 9,84(12)
	lfs 13,8(30)
	lfs 0,4212(9)
	fmadds 0,9,0,13
	stfs 0,8(30)
	lwz 9,84(12)
	lfs 13,4(10)
	lfs 0,4224(9)
	fsubs 0,0,13
	fdiv 0,0,12
	frsp 9,0
	fcmpu 0,9,11
	bc 4,0,.L51
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 9,0(11)
.L51:
	lfs 11,4228(9)
	lis 7,run_pitch@ha
	lis 10,right@ha
	lfs 0,52(31)
	lis 9,forward@ha
	la 8,right@l(10)
	la 11,forward@l(9)
	lis 6,run_roll@ha
	lis 5,bob_pitch@ha
	lis 4,bobfracsin@ha
	fmadds 11,9,11,0
	lis 3,xyspeed@ha
	stfs 11,52(31)
	lfs 12,4(11)
	lfs 0,380(12)
	lfs 10,forward@l(9)
	lfs 13,376(12)
	fmuls 0,0,12
	lfs 9,8(11)
	lfs 12,384(12)
	lwz 9,run_pitch@l(7)
	fmadds 13,13,10,0
	lfs 0,20(9)
	fmadds 10,12,9,13
	fmadds 0,10,0,11
	stfs 0,52(31)
	lfs 0,4(8)
	lfs 13,380(12)
	lfs 11,right@l(10)
	lfs 12,376(12)
	fmuls 13,13,0
	lfs 9,8(8)
	lfs 10,384(12)
	lwz 9,run_roll@l(6)
	fmadds 12,12,11,13
	lwz 11,bob_pitch@l(5)
	lfs 0,20(9)
	lfs 11,8(30)
	fmadds 10,10,9,12
	lfs 13,bobfracsin@l(4)
	lfs 12,xyspeed@l(3)
	fmadds 0,10,0,11
	stfs 0,8(30)
	lwz 9,84(12)
	lfs 0,20(11)
	lbz 0,16(9)
	fmuls 13,13,0
	andi. 9,0,1
	fmuls 10,13,12
	bc 12,2,.L52
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfs 0,0(11)
	fmuls 10,10,0
.L52:
	lfs 0,52(31)
	lis 9,bob_roll@ha
	fadds 0,0,10
	stfs 0,52(31)
	lwz 11,bob_roll@l(9)
	lis 9,bobfracsin@ha
	lwz 10,84(12)
	lfs 0,bobfracsin@l(9)
	lfs 13,20(11)
	lis 9,xyspeed@ha
	lbz 0,16(10)
	fmuls 0,0,13
	lfs 13,xyspeed@l(9)
	andi. 9,0,1
	fmuls 10,0,13
	bc 12,2,.L53
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfs 0,0(11)
	fmuls 10,10,0
.L53:
	lis 9,bobcycle@ha
	lwz 0,bobcycle@l(9)
	andi. 9,0,1
	bc 12,2,.L54
	fneg 10,10
.L54:
	lfs 0,8(30)
	fadds 0,0,10
	stfs 0,8(30)
.L49:
	lwz 0,508(12)
	lis 8,0x4330
	lis 11,.LC23@ha
	lwz 7,84(12)
	lis 10,.LC19@ha
	xoris 0,0,0x8000
	la 11,.LC23@l(11)
	lfd 13,.LC19@l(10)
	stw 0,36(1)
	stw 8,32(1)
	lfd 12,0(11)
	lfd 0,32(1)
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 8,0(11)
	fsub 0,0,12
	lis 11,level+4@ha
	lfs 11,level+4@l(11)
	stfs 8,12(1)
	frsp 0,0
	stfs 8,8(1)
	fadds 12,0,8
	stfs 12,16(1)
	lfs 0,4224(7)
	fsubs 0,0,11
	fdiv 0,0,13
	frsp 9,0
	fcmpu 0,9,8
	bc 4,0,.L55
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 9,0(9)
.L55:
	lfs 0,4228(7)
	lis 9,.LC20@ha
	fmr 13,12
	lis 11,bobfracsin@ha
	lfd 10,.LC20@l(9)
	lis 10,xyspeed@ha
	lfs 12,bobfracsin@l(11)
	lis 9,bob_up@ha
	fmuls 0,9,0
	lis 11,.LC22@ha
	lfs 11,xyspeed@l(10)
	la 11,.LC22@l(11)
	lfs 9,0(11)
	lwz 11,bob_up@l(9)
	fmuls 12,12,11
	fmul 0,0,10
	fsub 13,13,0
	frsp 13,13
	stfs 13,16(1)
	lfs 0,20(11)
	fmuls 0,12,0
	fcmpu 0,0,9
	bc 4,1,.L56
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 0,0(9)
.L56:
	fadds 12,13,0
	stfs 12,16(1)
	lfs 0,4200(7)
	fadds 11,0,8
	stfs 11,8(1)
	lfs 0,4204(7)
	fadds 0,0,8
	stfs 0,12(1)
	lfs 13,4208(7)
	fadds 12,12,13
	stfs 12,16(1)
	lwz 0,4724(7)
	cmpwi 0,0,0
	bc 4,2,.L57
	lis 11,.LC24@ha
	la 11,.LC24@l(11)
	lfs 0,0(11)
	fcmpu 0,11,0
	bc 12,0,.L69
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L59
.L69:
	stfs 0,8(1)
.L59:
	lis 11,.LC24@ha
	lfs 0,12(1)
	la 11,.LC24@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L70
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L62
.L70:
	stfs 13,12(1)
.L62:
	lis 11,.LC26@ha
	lfs 0,16(1)
	la 11,.LC26@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L71
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L67
.L71:
	stfs 13,16(1)
	b .L67
.L57:
	stfs 8,16(1)
	stfs 8,8(1)
	stfs 8,12(1)
	lwz 9,4728(7)
	cmpwi 0,9,0
	bc 12,2,.L67
	lis 11,.LC28@ha
	lfs 0,4(9)
	la 11,.LC28@l(11)
	lfs 10,0(11)
	mr 10,9
	mr 11,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,32(1)
	lwz 9,36(1)
	sth 9,4(7)
	lwz 8,84(12)
	lwz 9,4728(8)
	lfs 0,8(9)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,32(1)
	lwz 11,36(1)
	sth 11,6(8)
	lwz 7,84(12)
	lwz 9,4728(7)
	lfs 0,12(9)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,32(1)
	lwz 10,36(1)
	sth 10,8(7)
	lwz 11,84(12)
	lfs 0,16(12)
	lwz 9,4728(11)
	stfs 0,16(9)
	lwz 11,84(12)
	lfs 0,20(12)
	lwz 9,4728(11)
	stfs 0,20(9)
	lwz 11,84(12)
	lfs 0,24(12)
	lwz 9,4728(11)
	stfs 0,24(9)
.L67:
	lfs 0,8(1)
	lwz 9,84(12)
	stfs 0,40(9)
	lfs 0,12(1)
	lwz 11,84(12)
	stfs 0,44(11)
	lfs 0,16(1)
	lwz 9,84(12)
	stfs 0,48(9)
	lmw 30,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 SV_CalcViewOffset,.Lfe2-SV_CalcViewOffset
	.section	".rodata"
	.align 3
.LC29:
	.long 0x3f747ae1
	.long 0x47ae147b
	.align 3
.LC30:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC31:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC32:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC33:
	.long 0x43340000
	.align 2
.LC34:
	.long 0x43b40000
	.align 2
.LC35:
	.long 0xc3340000
	.align 2
.LC36:
	.long 0x42340000
	.align 2
.LC37:
	.long 0xc2340000
	.section	".text"
	.align 2
	.globl SV_CalcGunOffset
	.type	 SV_CalcGunOffset,@function
SV_CalcGunOffset:
	stwu 1,-16(1)
	stw 31,12(1)
	lis 7,xyspeed@ha
	lis 6,bobfracsin@ha
	lwz 8,84(3)
	lfs 0,bobfracsin@l(6)
	lis 9,.LC29@ha
	lis 10,.LC30@ha
	lfs 13,xyspeed@l(7)
	lis 11,bobcycle@ha
	lfd 11,.LC29@l(9)
	lfd 12,.LC30@l(10)
	fmuls 13,13,0
	lwz 0,bobcycle@l(11)
	andi. 9,0,1
	fmul 0,13,11
	fmul 13,13,12
	frsp 0,0
	frsp 13,13
	stfs 0,72(8)
	lwz 9,84(3)
	stfs 13,68(9)
	bc 12,2,.L73
	lwz 9,84(3)
	lfs 0,72(9)
	fneg 0,0
	stfs 0,72(9)
	lwz 11,84(3)
	lfs 0,68(11)
	fneg 0,0
	stfs 0,68(11)
.L73:
	lfs 0,xyspeed@l(7)
	lis 9,.LC31@ha
	lis 10,.LC33@ha
	lfs 13,bobfracsin@l(6)
	la 10,.LC33@l(10)
	li 0,3
	lfd 9,.LC31@l(9)
	lis 11,.LC32@ha
	mtctr 0
	li 7,0
	lfs 5,0(10)
	lis 9,.LC34@ha
	li 8,0
	fmuls 0,0,13
	la 9,.LC34@l(9)
	lis 10,.LC35@ha
	lfd 10,.LC32@l(11)
	la 10,.LC35@l(10)
	lfs 12,0(9)
	lfs 6,0(10)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lis 10,.LC37@ha
	lfs 7,0(9)
	la 10,.LC37@l(10)
	lwz 9,84(3)
	fmul 0,0,11
	lfs 8,0(10)
	frsp 0,0
	stfs 0,64(9)
.L90:
	lwz 10,84(3)
	addi 9,10,4268
	addi 11,10,28
	lfsx 13,9,8
	lfsx 0,11,8
	fsubs 13,13,0
	fcmpu 0,13,5
	bc 4,1,.L78
	fsubs 13,13,12
.L78:
	fcmpu 0,13,6
	bc 4,0,.L79
	fadds 13,13,12
.L79:
	fcmpu 0,13,7
	bc 4,1,.L80
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
.L80:
	fcmpu 0,13,8
	bc 4,0,.L81
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
.L81:
	cmpwi 0,7,1
	bc 4,2,.L82
	lfs 0,72(10)
	fmadd 0,13,9,0
	frsp 0,0
	stfs 0,72(10)
.L82:
	lwz 9,84(3)
	addi 7,7,1
	addi 9,9,64
	lfsx 0,9,8
	fmadd 0,13,10,0
	frsp 0,0
	stfsx 0,9,8
	addi 8,8,4
	bdnz .L90
	lis 9,gun_y@ha
	lis 11,gun_x@ha
	lwz 10,84(3)
	lwz 5,gun_y@l(9)
	lis 8,gun_z@ha
	li 0,0
	lis 9,forward@ha
	lwz 6,gun_x@l(11)
	la 31,forward@l(9)
	lwz 7,gun_z@l(8)
	lis 11,right@ha
	lis 9,up@ha
	la 12,right@l(11)
	stw 0,76(10)
	la 4,up@l(9)
	li 8,0
	stw 0,84(10)
	li 9,3
	stw 0,80(10)
	mtctr 9
.L89:
	lwz 9,84(3)
	lfsx 13,8,31
	addi 9,9,76
	lfs 12,20(5)
	lfsx 0,9,8
	fmadds 13,13,12,0
	stfsx 13,9,8
	lwz 11,84(3)
	lfsx 13,8,12
	addi 11,11,76
	lfs 12,20(6)
	lfsx 0,11,8
	fmadds 13,13,12,0
	stfsx 13,11,8
	lwz 9,84(3)
	lfs 12,20(7)
	addi 9,9,76
	lfsx 13,8,4
	lfsx 0,9,8
	fneg 12,12
	fmadds 13,13,12,0
	stfsx 13,9,8
	addi 8,8,4
	bdnz .L89
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 SV_CalcGunOffset,.Lfe3-SV_CalcGunOffset
	.section	".rodata"
	.align 2
.LC42:
	.string	"items/airout.wav"
	.align 2
.LC38:
	.long 0x3e99999a
	.align 2
.LC39:
	.long 0x3f19999a
	.align 2
.LC40:
	.long 0x3dcccccd
	.align 2
.LC41:
	.long 0x3d4ccccd
	.align 2
.LC43:
	.long 0x3ecccccd
	.align 2
.LC44:
	.long 0x3d23d70a
	.align 2
.LC45:
	.long 0x3e4ccccd
	.align 2
.LC46:
	.long 0x3f59999a
	.align 2
.LC47:
	.long 0x3f333333
	.align 3
.LC48:
	.long 0x3faeb851
	.long 0xeb851eb8
	.align 3
.LC49:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
	.long 0x0
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC53:
	.long 0x3e800000
	.align 2
.LC54:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl SV_CalcBlend
	.type	 SV_CalcBlend,@function
SV_CalcBlend:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 29,36(1)
	stw 0,52(1)
	stw 12,32(1)
	mr 31,3
	li 0,0
	lwz 9,84(31)
	lis 10,gi+52@ha
	addi 3,1,8
	stw 0,96(9)
	stw 0,108(9)
	stw 0,104(9)
	stw 0,100(9)
	lwz 11,84(31)
	lfs 13,4(31)
	lfs 0,40(11)
	lfs 12,8(31)
	lfs 11,12(31)
	fadds 13,13,0
	lwz 0,gi+52@l(10)
	mtlr 0
	stfs 13,8(1)
	lfs 0,44(11)
	fadds 12,12,0
	stfs 12,12(1)
	lfs 0,48(11)
	fadds 11,11,0
	stfs 11,16(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L94
	lwz 9,84(31)
	lwz 0,116(9)
	ori 0,0,1
	b .L130
.L94:
	lwz 9,84(31)
	lwz 0,116(9)
	rlwinm 0,0,0,0,30
.L130:
	stw 0,116(9)
	andi. 7,3,9
	bc 12,2,.L96
	lis 9,.LC50@ha
	lwz 11,84(31)
	lis 7,.LC51@ha
	la 9,.LC50@l(9)
	la 7,.LC51@l(7)
	lfs 11,0(9)
	lis 10,.LC38@ha
	lis 9,.LC39@ha
	lfs 12,96(11)
	lfs 8,.LC39@l(9)
	addi 9,11,96
	lfs 9,0(7)
	lfs 0,12(9)
	lfs 13,.LC38@l(10)
	fsubs 10,11,0
	fmadds 10,10,8,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmadds 12,12,0,11
	fmuls 9,11,9
	fmuls 11,11,13
	stfs 12,96(11)
	b .L131
.L96:
	andi. 9,3,16
	bc 12,2,.L100
	lwz 10,84(31)
	lis 9,.LC39@ha
	lis 11,.LC50@ha
	lfs 7,.LC39@l(9)
	la 11,.LC50@l(11)
	lis 7,.LC51@ha
	addi 9,10,96
	lfs 11,0(11)
	la 7,.LC51@l(7)
	lfs 0,12(9)
	lis 11,.LC41@ha
	lis 8,.LC40@ha
	lfs 13,0(7)
	lfs 12,96(10)
	fsubs 10,11,0
	lfs 9,.LC41@l(11)
	lfs 8,.LC40@l(8)
	fmadds 10,10,7,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 13,11,13
	fmuls 9,11,9
	fmuls 11,11,8
	fmadds 12,12,0,13
	stfs 12,96(10)
.L131:
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,9
	stfs 13,4(9)
	stfs 12,8(9)
	b .L99
.L100:
	andi. 9,3,32
	bc 12,2,.L99
	li 0,1
	stw 0,916(31)
.L99:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC52@ha
	lfs 12,4324(10)
	xoris 0,0,0x8000
	la 11,.LC52@l(11)
	stw 0,28(1)
	stw 8,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L105
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 30,28(1)
	cmpwi 4,30,30
	bc 4,18,.L106
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC50@ha
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	mr 5,3
	la 7,.LC50@l(7)
	la 9,.LC50@l(9)
	mtlr 0
	la 10,.LC51@l(10)
	li 4,3
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L106:
	bc 12,17,.L108
	andi. 0,30,4
	bc 12,2,.L105
.L108:
	lwz 10,84(31)
	lis 9,.LC44@ha
	lis 7,.LC50@ha
	lfs 13,.LC44@l(9)
	la 7,.LC50@l(7)
	lis 11,.LC43@ha
	addi 9,10,96
	lfs 9,0(7)
	lfs 0,12(9)
	lfs 10,.LC43@l(11)
	lfs 12,96(10)
	fsubs 11,9,0
	fmadds 11,11,13,0
	fdivs 0,0,11
	fsubs 9,9,0
	fmuls 10,9,10
	fmadds 12,12,0,10
	stfs 12,96(10)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 11,12(9)
	fmadds 13,13,0,9
	fmadds 12,12,0,10
	stfs 13,4(9)
	stfs 12,8(9)
.L105:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC52@ha
	lfs 12,4332(10)
	xoris 0,0,0x8000
	la 11,.LC52@l(11)
	stw 0,28(1)
	stw 8,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L111
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L111
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x6205
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,46533
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,33
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L111:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 11,level@l(11)
	lis 8,0x4330
	lis 7,.LC52@ha
	la 7,.LC52@l(7)
	lfs 12,4328(10)
	xoris 0,11,0x8000
	lfd 13,0(7)
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L112
	andi. 9,11,2
	bc 12,2,.L112
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L112
	lwz 9,480(31)
	addi 9,9,1
	stw 9,480(31)
.L112:
	lwz 11,84(31)
	lhz 0,4426(11)
	cmpwi 0,0,0
	bc 12,2,.L113
	lis 10,.LC50@ha
	addi 9,11,96
	lfs 12,96(11)
	la 10,.LC50@l(10)
	lfs 0,12(9)
	lis 7,.LC53@ha
	lfs 10,0(10)
	la 7,.LC53@l(7)
	lfs 13,0(7)
	lis 10,.LC51@ha
	la 10,.LC51@l(10)
	fsubs 11,10,0
	lfs 9,0(10)
	fmadds 11,11,13,0
	fdivs 0,0,11
	fsubs 10,10,0
	fmuls 9,10,9
	fmadds 12,12,0,9
	stfs 12,96(11)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 11,12(9)
	fmadds 13,13,0,10
	fmadds 12,12,0,9
	stfs 13,4(9)
	stfs 12,8(9)
.L113:
	mr 3,31
	li 4,10
	bl Force_constant_active
	cmpwi 0,3,255
	bc 12,2,.L116
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L116
	lwz 10,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4464(10)
	fcmpu 0,0,13
	bc 4,0,.L116
	lis 7,.LC50@ha
	stw 0,40(31)
	addi 11,10,96
	la 7,.LC50@l(7)
	lfs 0,12(11)
	lis 9,.LC54@ha
	lfs 11,0(7)
	la 9,.LC54@l(9)
	lfs 13,0(9)
	lis 9,.LC40@ha
	lfs 12,96(10)
	fsubs 10,11,0
	lfs 9,.LC40@l(9)
	fmadds 10,10,13,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 11,11,9
	fmadds 12,12,0,11
	stfs 12,96(10)
	lfs 13,4(11)
	lfs 12,8(11)
	stfs 10,12(11)
	fmadds 13,13,0,11
	fmadds 12,12,0,11
	stfs 13,4(11)
	stfs 12,8(11)
.L116:
	lwz 8,84(31)
	lwz 0,4828(8)
	cmpwi 0,0,0
	bc 12,2,.L119
	xoris 0,0,0x8000
	stw 0,28(1)
	lis 11,0x4330
	lis 10,.LC52@ha
	stw 11,24(1)
	la 10,.LC52@l(10)
	lfd 13,0(10)
	lis 11,.LC51@ha
	lfd 0,24(1)
	la 11,.LC51@l(11)
	lis 10,.LC45@ha
	lfs 12,0(11)
	addi 9,8,96
	lis 11,.LC40@ha
	lfs 8,.LC45@l(10)
	fsub 0,0,13
	lfs 7,.LC40@l(11)
	frsp 9,0
	fcmpu 0,9,12
	cror 3,2,0
	bc 12,3,.L119
	lis 7,.LC50@ha
	lfs 13,12(9)
	la 7,.LC50@l(7)
	lfs 11,96(8)
	lfs 0,0(7)
	fsubs 10,0,13
	fmadds 10,10,9,13
	fdivs 13,13,10
	fsubs 0,0,13
	fmuls 12,0,8
	fmuls 0,0,7
	fmadds 11,11,13,12
	stfs 11,96(8)
	lfs 12,4(9)
	lfs 11,8(9)
	stfs 10,12(9)
	fmadds 12,12,13,0
	fmadds 11,11,13,0
	stfs 12,4(9)
	stfs 11,8(9)
.L119:
	lwz 9,84(31)
	lis 10,.LC51@ha
	la 10,.LC51@l(10)
	lfs 0,0(10)
	lfs 8,4232(9)
	fcmpu 0,8,0
	bc 4,1,.L122
	lfs 12,4240(9)
	addi 11,9,96
	lfs 7,4244(9)
	lfs 9,4248(9)
	cror 3,2,0
	bc 12,3,.L122
	lis 7,.LC50@ha
	lfs 13,12(11)
	la 7,.LC50@l(7)
	lfs 11,96(9)
	lfs 0,0(7)
	fsubs 10,0,13
	fmadds 10,10,8,13
	fdivs 13,13,10
	fsubs 0,0,13
	fmuls 12,12,0
	fmuls 9,9,0
	fmuls 0,7,0
	fmadds 11,11,13,12
	stfs 11,96(9)
	lfs 12,4(11)
	lfs 11,8(11)
	stfs 10,12(11)
	fmadds 12,12,13,0
	fmadds 11,11,13,9
	stfs 12,4(11)
	stfs 11,8(11)
.L122:
	lwz 8,84(31)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 0,0(9)
	lfs 12,4236(8)
	fcmpu 0,12,0
	bc 4,1,.L125
	lis 9,.LC46@ha
	lis 10,.LC47@ha
	lfs 7,.LC46@l(9)
	lis 11,.LC38@ha
	addi 9,8,96
	lfs 8,.LC47@l(10)
	lfs 9,.LC38@l(11)
	cror 3,2,0
	bc 12,3,.L125
	lis 10,.LC50@ha
	lfs 13,12(9)
	la 10,.LC50@l(10)
	lfs 11,96(8)
	lfs 0,0(10)
	fsubs 10,0,13
	fmadds 10,10,12,13
	fdivs 13,13,10
	fsubs 0,0,13
	fmuls 12,0,7
	fmuls 9,0,9
	fmuls 0,0,8
	fmadds 11,11,13,12
	stfs 11,96(8)
	lfs 12,4(9)
	lfs 11,8(9)
	stfs 10,12(9)
	fmadds 12,12,13,0
	fmadds 11,11,13,9
	stfs 12,4(9)
	stfs 11,8(9)
.L125:
	lwz 11,84(31)
	lis 9,.LC48@ha
	lis 7,.LC51@ha
	lfd 13,.LC48@l(9)
	la 7,.LC51@l(7)
	lfs 0,4232(11)
	lfs 12,0(7)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4232(11)
	lwz 9,84(31)
	lfs 0,4232(9)
	fcmpu 0,0,12
	bc 4,0,.L128
	stfs 12,4232(9)
.L128:
	lwz 11,84(31)
	lis 9,.LC49@ha
	lfd 13,.LC49@l(9)
	lfs 0,4236(11)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4236(11)
	lwz 3,84(31)
	lfs 0,4236(3)
	fcmpu 0,0,12
	bc 4,0,.L129
	stfs 12,4236(3)
.L129:
	lwz 0,52(1)
	lwz 12,32(1)
	mtlr 0
	lmw 29,36(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe4:
	.size	 SV_CalcBlend,.Lfe4-SV_CalcBlend
	.section	".rodata"
	.align 3
.LC55:
	.long 0x3f1a36e2
	.long 0xeb1c432d
	.align 3
.LC56:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC57:
	.long 0x0
	.align 3
.LC58:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC59:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC60:
	.long 0x3f800000
	.align 2
.LC61:
	.long 0x41700000
	.align 2
.LC62:
	.long 0x42200000
	.align 2
.LC63:
	.long 0x41f00000
	.align 2
.LC64:
	.long 0x425c0000
	.section	".text"
	.align 2
	.globl P_FallingDamage
	.type	 P_FallingDamage,@function
P_FallingDamage:
	stwu 1,-32(1)
	lwz 0,40(3)
	cmpwi 0,0,255
	bc 4,2,.L132
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 12,2,.L132
	lwz 9,84(3)
	lis 11,.LC57@ha
	la 11,.LC57@l(11)
	lfs 0,0(11)
	lfs 13,4288(9)
	mr 11,9
	fcmpu 0,13,0
	bc 4,0,.L135
	lfs 0,384(3)
	fcmpu 0,0,13
	bc 4,1,.L135
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 4,2,.L150
	fmr 11,13
	b .L136
.L135:
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 12,2,.L132
.L150:
	lfs 13,4288(11)
	lfs 0,384(3)
	fsubs 11,0,13
.L136:
	fmuls 0,11,11
	lis 9,.LC55@ha
	lwz 0,612(3)
	lfd 13,.LC55@l(9)
	cmpwi 0,0,3
	fmul 0,0,13
	frsp 11,0
	bc 12,2,.L132
	cmpwi 0,0,2
	bc 4,2,.L139
	lis 9,.LC58@ha
	fmr 0,11
	la 9,.LC58@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 11,0
.L139:
	cmpwi 0,0,1
	bc 4,2,.L140
	lis 11,.LC59@ha
	fmr 0,11
	la 11,.LC59@l(11)
	lfd 13,0(11)
	fmul 0,0,13
	frsp 11,0
.L140:
	lis 9,.LC60@ha
	la 9,.LC60@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 12,0,.L132
	lis 11,.LC61@ha
	la 11,.LC61@l(11)
	lfs 0,0(11)
	fcmpu 0,11,0
	li 9,2
	bc 12,0,.L151
	lis 9,.LC59@ha
	fmr 0,11
	lis 11,.LC62@ha
	la 9,.LC59@l(9)
	la 11,.LC62@l(11)
	lfd 13,0(9)
	lwz 9,84(3)
	lfs 12,0(11)
	fmul 0,0,13
	frsp 0,0
	stfs 0,4228(9)
	lwz 9,84(3)
	lfs 0,4228(9)
	fcmpu 0,0,12
	bc 4,1,.L143
	stfs 12,4228(9)
.L143:
	lis 9,level+4@ha
	lis 11,.LC56@ha
	lwz 10,84(3)
	lfs 0,level+4@l(9)
	lis 9,.LC63@ha
	lfd 13,.LC56@l(11)
	la 9,.LC63@l(9)
	lfs 12,0(9)
	fadd 0,0,13
	fcmpu 0,11,12
	frsp 0,0
	stfs 0,4224(10)
	bc 4,1,.L144
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L145
	lis 11,.LC64@ha
	la 11,.LC64@l(11)
	lfs 0,0(11)
	fcmpu 0,11,0
	li 0,4
	cror 3,2,1
	bc 4,3,.L146
	li 0,5
.L146:
	stw 0,80(3)
.L145:
	lis 9,level+4@ha
	li 11,0
	lfs 0,level+4@l(9)
	lis 0,0x3f80
	stw 11,12(1)
	stfs 0,464(3)
	stw 0,16(1)
	stw 11,8(1)
	b .L149
.L144:
	li 9,3
.L151:
	li 0,0
	sth 0,976(3)
	stw 9,80(3)
	b .L132
.L149:
	li 0,0
	sth 0,976(3)
.L132:
	la 1,32(1)
	blr
.Lfe5:
	.size	 P_FallingDamage,.Lfe5-P_FallingDamage
	.section	".rodata"
	.align 2
.LC65:
	.string	"player/lava_in.wav"
	.align 2
.LC66:
	.string	"player/watr_in.wav"
	.align 2
.LC67:
	.string	"player/watr_out.wav"
	.align 2
.LC68:
	.string	"player/watr_un.wav"
	.align 2
.LC69:
	.string	"player/gasp1.wav"
	.align 2
.LC70:
	.string	"player/gasp2.wav"
	.align 2
.LC71:
	.string	"player/u_breath1.wav"
	.align 2
.LC72:
	.string	"player/u_breath2.wav"
	.align 2
.LC73:
	.string	"player/drown1.wav"
	.align 2
.LC74:
	.string	"*gurp1.wav"
	.align 2
.LC75:
	.string	"*gurp2.wav"
	.align 2
.LC76:
	.string	"player/burn1.wav"
	.align 2
.LC77:
	.string	"player/burn2.wav"
	.align 2
.LC78:
	.long 0x41400000
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC80:
	.long 0x3f800000
	.align 2
.LC81:
	.long 0x0
	.align 2
.LC82:
	.long 0x41300000
	.align 2
.LC83:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl P_WorldEffects
	.type	 P_WorldEffects,@function
P_WorldEffects:
	stwu 1,-64(1)
	mflr 0
	mfcr 12
	stmw 25,36(1)
	stw 0,68(1)
	stw 12,32(1)
	lis 9,current_player@ha
	lis 26,current_player@ha
	lwz 3,current_player@l(9)
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L154
	lis 7,.LC78@ha
	lis 9,level+4@ha
	la 7,.LC78@l(7)
	lfs 0,level+4@l(9)
	lfs 13,0(7)
	fadds 0,0,13
	stfs 0,404(3)
	b .L153
.L154:
	lis 9,current_client@ha
	lwz 30,612(3)
	lis 7,level@ha
	lwz 11,current_client@l(9)
	lis 6,0x4330
	addic 0,30,-1
	subfe 8,0,30
	lis 9,.LC79@ha
	lwz 31,4296(11)
	la 9,.LC79@l(9)
	stw 30,4296(11)
	lwz 0,level@l(7)
	lfd 13,0(9)
	xoris 0,0,0x8000
	lfs 12,4324(11)
	subfic 7,31,0
	adde 9,7,31
	stw 0,28(1)
	and. 11,9,8
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 25
	rlwinm 25,25,30,1
	bc 12,2,.L155
	li 5,0
	addi 4,3,4
	bl PlayerNoise
	lwz 28,current_player@l(26)
	lwz 0,608(28)
	andi. 7,0,8
	bc 12,2,.L156
	lis 29,gi@ha
	lis 3,.LC65@ha
	la 29,gi@l(29)
	la 3,.LC65@l(3)
	b .L186
.L156:
	andi. 7,0,16
	bc 12,2,.L158
	lis 29,gi@ha
	lis 3,.LC66@ha
	la 29,gi@l(29)
	la 3,.LC66@l(3)
.L186:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L157
.L158:
	andi. 7,0,32
	bc 12,2,.L157
	lis 29,gi@ha
	lis 3,.LC66@ha
	la 29,gi@l(29)
	la 3,.LC66@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L157:
	lis 11,current_player@ha
	lis 7,.LC80@ha
	lwz 9,current_player@l(11)
	lis 10,level+4@ha
	la 7,.LC80@l(7)
	lfs 13,0(7)
	lwz 0,264(9)
	ori 0,0,8
	stw 0,264(9)
	lfs 0,level+4@l(10)
	fsubs 0,0,13
	stfs 0,468(9)
.L155:
	cmpwi 0,30,0
	addic 10,31,-1
	subfe 9,10,31
	mcrf 4,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 11,9,0
	bc 12,2,.L161
	lis 28,current_player@ha
	li 5,0
	lwz 3,current_player@l(28)
	addi 4,3,4
	bl PlayerNoise
	lis 29,gi@ha
	lis 3,.LC67@ha
	lwz 27,current_player@l(28)
	la 29,gi@l(29)
	la 3,.LC67@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	la 9,.LC80@l(9)
	mr 5,3
	la 7,.LC80@l(7)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,27
	lfs 3,0(10)
	blrl
	lwz 9,current_player@l(28)
	lwz 0,264(9)
	rlwinm 0,0,0,29,27
	stw 0,264(9)
.L161:
	cmpwi 0,30,3
	xori 0,31,3
	addic 7,0,-1
	subfe 9,7,0
	mfcr 27
	mfcr 0
	rlwinm 0,0,3,1
	and. 10,9,0
	bc 12,2,.L162
	lis 29,gi@ha
	lis 3,.LC68@ha
	la 29,gi@l(29)
	la 3,.LC68@l(3)
	lwz 11,36(29)
	lis 9,current_player@ha
	lwz 28,current_player@l(9)
	mtlr 11
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L162:
	xori 0,30,3
	xori 11,31,3
	subfic 7,11,0
	adde 11,7,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L163
	lis 9,current_player@ha
	lis 11,level+4@ha
	lwz 28,current_player@l(9)
	lfs 12,level+4@l(11)
	lfs 13,404(28)
	fcmpu 0,13,12
	bc 4,0,.L164
	lis 29,gi@ha
	lis 3,.LC69@ha
	la 29,gi@l(29)
	la 3,.LC69@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	lwz 3,current_player@l(26)
	li 5,0
	addi 4,3,4
	bl PlayerNoise
	b .L163
.L164:
	lis 7,.LC82@ha
	la 7,.LC82@l(7)
	lfs 0,0(7)
	fadds 0,12,0
	fcmpu 0,13,0
	bc 4,0,.L163
	lis 29,gi@ha
	lis 3,.LC70@ha
	la 29,gi@l(29)
	la 3,.LC70@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L163:
	mtcrf 128,27
	bc 4,2,.L167
	cmpwi 0,25,0
	bc 12,2,.L168
	lis 8,level@ha
	lis 7,.LC83@ha
	la 7,.LC83@l(7)
	la 9,level@l(8)
	lfs 13,0(7)
	lis 11,current_player@ha
	lfs 0,4(9)
	lis 7,0x4330
	lis 9,.LC79@ha
	lwz 28,current_player@l(11)
	la 9,.LC79@l(9)
	mr 11,10
	fadds 0,0,13
	lfd 11,0(9)
	lis 9,current_client@ha
	lwz 6,current_client@l(9)
	stfs 0,404(28)
	lis 9,0x51eb
	lwz 0,level@l(8)
	ori 9,9,34079
	lfs 13,4324(6)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	fsub 0,0,11
	frsp 0,0
	fsubs 13,13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 11,28(1)
	mulhw 9,11,9
	srawi 0,11,31
	srawi 9,9,3
	subf 9,0,9
	mulli 9,9,25
	cmpw 0,11,9
	bc 4,2,.L168
	lwz 0,4300(6)
	cmpwi 0,0,0
	bc 4,2,.L170
	lis 29,gi@ha
	lis 3,.LC71@ha
	la 29,gi@l(29)
	la 3,.LC71@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L171
.L170:
	lis 29,gi@ha
	lis 3,.LC72@ha
	la 29,gi@l(29)
	la 3,.LC72@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L171:
	lis 9,current_client@ha
	lis 11,current_player@ha
	lwz 10,current_client@l(9)
	li 5,0
	lwz 3,current_player@l(11)
	lwz 0,4300(10)
	addi 4,3,4
	xori 0,0,1
	stw 0,4300(10)
	bl PlayerNoise
.L168:
	lis 9,current_player@ha
	lis 11,level+4@ha
	lwz 10,current_player@l(9)
	lfs 13,level+4@l(11)
	lfs 0,404(10)
	fcmpu 0,0,13
	bc 4,0,.L179
	lwz 9,84(10)
	lfs 0,4292(9)
	fcmpu 0,0,13
	bc 4,0,.L179
	lwz 0,480(10)
	cmpwi 0,0,0
	bc 4,1,.L179
	lis 7,.LC80@ha
	la 7,.LC80@l(7)
	lfs 0,0(7)
	fadds 0,13,0
	stfs 0,4292(9)
	lwz 9,516(10)
	addi 9,9,2
	cmpwi 0,9,15
	stw 9,516(10)
	bc 4,1,.L174
	li 0,15
	stw 0,516(10)
.L174:
	lwz 28,current_player@l(26)
	lwz 9,480(28)
	lwz 0,516(28)
	cmpw 0,9,0
	bc 12,1,.L175
	lis 29,gi@ha
	lis 3,.LC73@ha
	la 29,gi@l(29)
	la 3,.LC73@l(3)
	b .L187
.L175:
	bl rand
	andi. 0,3,1
	bc 12,2,.L177
	lis 29,gi@ha
	lis 3,.LC74@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC74@l(3)
.L187:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L176
.L177:
	lis 29,gi@ha
	lis 3,.LC75@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC75@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L176:
	lis 10,level+4@ha
	lis 9,current_player@ha
	lfs 0,level+4@l(10)
	lis 8,g_edicts@ha
	lis 6,vec3_origin@ha
	lwz 11,current_player@l(9)
	la 6,vec3_origin@l(6)
	li 0,2
	lwz 4,g_edicts@l(8)
	li 29,17
	li 10,0
	lwz 9,516(11)
	mr 3,11
	mr 8,6
	stfs 0,464(11)
	addi 7,3,4
	mr 5,4
	stw 0,8(1)
	stw 29,12(1)
	bl T_Damage
	b .L179
.L167:
	lis 7,.LC78@ha
	lis 9,level+4@ha
	la 7,.LC78@l(7)
	lfs 0,level+4@l(9)
	lis 11,current_player@ha
	lfs 13,0(7)
	li 0,2
	lwz 9,current_player@l(11)
	fadds 0,0,13
	stw 0,516(9)
	stfs 0,404(9)
.L179:
	bc 12,18,.L153
	lis 9,current_player@ha
	lwz 11,current_player@l(9)
	lwz 0,608(11)
	andi. 9,0,24
	bc 12,2,.L153
	andi. 10,0,8
	bc 12,2,.L181
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L182
	lis 9,level+4@ha
	lfs 13,464(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L182
	bl rand
	andi. 0,3,1
	bc 12,2,.L183
	lis 29,gi@ha
	lis 3,.LC76@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC76@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L184
.L183:
	lis 29,gi@ha
	lis 3,.LC77@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC77@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC80@ha
	lis 9,.LC80@ha
	lis 10,.LC81@ha
	mr 5,3
	la 7,.LC80@l(7)
	la 9,.LC80@l(9)
	mtlr 0
	la 10,.LC81@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L184:
	lis 7,.LC80@ha
	lis 11,level+4@ha
	la 7,.LC80@l(7)
	lfs 0,level+4@l(11)
	lis 9,current_player@ha
	lfs 13,0(7)
	lwz 11,current_player@l(9)
	fadds 0,0,13
	stfs 0,464(11)
.L182:
	lis 9,current_player@ha
	lis 11,g_edicts@ha
	lwz 3,current_player@l(9)
	lis 6,vec3_origin@ha
	li 0,0
	lwz 4,g_edicts@l(11)
	slwi 9,30,1
	la 6,vec3_origin@l(6)
	li 11,19
	stw 0,8(1)
	add 9,9,30
	stw 11,12(1)
	mr 5,4
	addi 7,3,4
	mr 8,6
	li 10,0
	bl T_Damage
.L181:
	lis 9,current_player@ha
	lwz 3,current_player@l(9)
	lwz 0,608(3)
	andi. 7,0,16
	bc 12,2,.L153
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	lwz 4,g_edicts@l(9)
	la 6,vec3_origin@l(6)
	li 0,0
	li 11,18
	stw 0,8(1)
	mr 9,30
	stw 11,12(1)
	mr 5,4
	addi 7,3,4
	mr 8,6
	li 10,0
	bl T_Damage
.L153:
	lwz 0,68(1)
	lwz 12,32(1)
	mtlr 0
	lmw 25,36(1)
	mtcrf 8,12
	la 1,64(1)
	blr
.Lfe6:
	.size	 P_WorldEffects,.Lfe6-P_WorldEffects
	.section	".rodata"
	.align 2
.LC84:
	.string	"misc/pc_up.wav"
	.align 2
.LC85:
	.string	"weapons/saber/idle.wav"
	.align 2
.LC86:
	.long 0x3f800000
	.align 2
.LC87:
	.long 0x40400000
	.align 2
.LC88:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetClientSound
	.type	 G_SetClientSound,@function
G_SetClientSound:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 9,game+1024@ha
	lwz 11,84(31)
	lwz 9,game+1024@l(9)
	lwz 0,1780(11)
	cmpw 0,0,9
	bc 12,2,.L199
	stw 9,1780(11)
	li 0,1
	lwz 9,84(31)
	stw 0,1784(9)
.L199:
	lwz 10,84(31)
	lwz 11,1784(10)
	cmpwi 7,11,3
	addic 0,11,-1
	subfe 9,0,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 8,9,0
	bc 12,2,.L200
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,63
	bc 4,2,.L200
	addi 0,11,1
	lis 29,gi@ha
	stw 0,1784(10)
	la 29,gi@l(29)
	lis 3,.LC84@ha
	lwz 9,36(29)
	la 3,.LC84@l(3)
	mtlr 9
	blrl
	lis 8,.LC86@ha
	lwz 0,16(29)
	lis 9,.LC87@ha
	la 8,.LC86@l(8)
	mr 5,3
	lfs 1,0(8)
	la 9,.LC87@l(9)
	li 4,2
	mtlr 0
	lis 8,.LC88@ha
	mr 3,31
	lfs 2,0(9)
	la 8,.LC88@l(8)
	lfs 3,0(8)
	blrl
.L200:
	lwz 9,84(31)
	lwz 3,1764(9)
	cmpwi 0,3,0
	bc 12,2,.L201
	lwz 3,0(3)
	b .L202
.L201:
	lis 9,.LC0@ha
	la 3,.LC0@l(9)
.L202:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L203
	lwz 0,608(31)
	andi. 8,0,24
	bc 12,2,.L203
	lis 9,snd_fry@ha
	lwz 0,snd_fry@l(9)
	b .L207
.L203:
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L205
	lis 9,gi+36@ha
	lis 3,.LC85@ha
	lwz 0,gi+36@l(9)
	la 3,.LC85@l(3)
	mtlr 0
	blrl
	stw 3,76(31)
	b .L204
.L205:
	lwz 9,84(31)
	lwz 0,4348(9)
	cmpwi 0,0,0
.L207:
	stw 0,76(31)
.L204:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 G_SetClientSound,.Lfe7-G_SetClientSound
	.section	".rodata"
	.align 2
.LC89:
	.string	"weapon_wristrocket"
	.align 2
.LC90:
	.string	"weapon_missiletube"
	.align 2
.LC91:
	.string	"weapon_blasterpistol"
	.align 2
.LC92:
	.long 0x43440000
	.align 2
.LC93:
	.long 0x3f800000
	.align 2
.LC94:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetClientFrame
	.type	 G_SetClientFrame,@function
G_SetClientFrame:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	mr 31,3
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L209
	lis 9,.LC92@ha
	lfs 13,12(31)
	addi 3,1,24
	la 9,.LC92@l(9)
	lfs 12,4(31)
	addi 4,31,4
	lfs 0,0(9)
	li 5,0
	li 6,0
	lis 9,gi+48@ha
	addi 7,1,8
	lwz 0,gi+48@l(9)
	mr 8,31
	fsubs 13,13,0
	li 9,3
	lfs 0,8(31)
	mtlr 0
	stfs 12,8(1)
	stfs 13,16(1)
	stfs 0,12(1)
	lwz 30,84(31)
	blrl
	lis 9,.LC93@ha
	lfs 13,32(1)
	la 9,.LC93@l(9)
	lfs 0,0(9)
	lwz 9,84(31)
	fcmpu 7,13,0
	lwz 3,1764(9)
	cmpwi 0,3,0
	mfcr 27
	rlwinm 27,27,31,1
	bc 12,2,.L213
	lwz 29,0(3)
	b .L214
.L213:
	lis 9,.LC0@ha
	la 29,.LC0@l(9)
.L214:
	lis 4,.LC1@ha
	mr 3,29
	la 4,.LC1@l(4)
	bl strcmp
	subfic 0,3,0
	adde 28,0,3
	lis 4,.LC89@ha
	la 4,.LC89@l(4)
	mr 3,29
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L218
	lis 4,.LC90@ha
	mr 3,29
	la 4,.LC90@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L218
	lis 4,.LC91@ha
	mr 3,29
	la 4,.LC91@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L217
.L218:
	li 6,1
	b .L219
.L217:
	li 6,0
.L219:
	lbz 0,16(30)
	lwz 11,84(31)
	andi. 9,0,1
	bc 12,2,.L220
	lwz 0,4436(11)
	cmpwi 0,0,0
	bc 12,2,.L220
	li 9,1
	stw 9,4820(11)
	lbz 0,16(30)
	rlwinm 0,0,0,31,31
	stb 0,16(30)
	b .L221
.L220:
	li 0,0
	stw 0,4820(11)
.L221:
	lbz 0,16(30)
	andi. 11,0,1
	bc 4,2,.L223
	lwz 0,4820(30)
	cmpwi 0,0,1
	bc 4,2,.L222
.L223:
	li 8,1
	b .L224
.L222:
	li 8,0
.L224:
	lis 11,.LC94@ha
	lis 9,xyspeed@ha
	lwz 0,4316(30)
	la 11,.LC94@l(11)
	lfs 0,xyspeed@l(9)
	lfs 13,0(11)
	cmpw 0,8,0
	lwz 11,4312(30)
	fcmpu 7,0,13
	crnor 31,30,30
	mfcr 10
	rlwinm 10,10,0,1
	bc 12,2,.L227
	cmpwi 0,11,4
	bc 4,1,.L228
.L227:
	lwz 0,4320(30)
	cmpw 0,10,0
	bc 12,2,.L229
	cmpwi 0,11,0
	bc 12,2,.L228
.L229:
	lwz 0,552(31)
	cmpwi 0,0,0
	mr 7,0
	bc 4,2,.L230
	cmpwi 0,11,1
	bc 12,1,.L230
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L228
.L230:
	cmpwi 0,11,6
	bc 4,2,.L231
	lwz 9,56(31)
	lwz 0,4308(30)
	cmpw 0,9,0
	bc 4,1,.L233
	addi 0,9,-1
	stw 0,56(31)
	b .L209
.L231:
	lwz 9,56(31)
	lwz 0,4308(30)
	cmpw 0,9,0
	bc 4,0,.L233
	addi 0,9,1
	stw 0,56(31)
	b .L209
.L233:
	cmpwi 0,11,5
	bc 12,2,.L209
	cmpwi 0,11,2
	bc 4,2,.L228
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L228
	cmpwi 0,27,0
	bc 12,2,.L237
	cmpwi 0,7,0
	bc 4,2,.L283
	lfs 0,384(31)
	fctiwz 13,0
	stfd 13,96(1)
	lwz 9,100(1)
	srawi 11,9,31
	xor 0,11,9
	subf 0,11,0
	cmpwi 0,0,39
	bc 12,1,.L237
	mr 3,31
	li 4,5
	bl Force_constant_active
	cmpwi 0,3,255
	bc 12,2,.L237
	lwz 11,84(31)
	lwz 0,4448(11)
	cmpwi 0,0,0
	bc 4,1,.L238
	li 0,63
	li 9,69
	b .L287
.L238:
	bc 4,0,.L237
	li 0,56
	li 9,62
.L287:
	stw 0,56(31)
	stw 9,4308(11)
.L237:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L209
.L283:
	lwz 11,84(31)
	li 0,1
	li 10,52
	li 8,55
	stw 0,4312(11)
	lwz 9,84(31)
	stw 10,56(31)
	stw 8,4308(9)
	b .L209
.L228:
	li 0,0
	stw 8,4316(30)
	stw 0,4312(30)
	stw 10,4320(30)
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L242
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L242
	li 0,2
	stw 0,4312(30)
	lwz 9,56(31)
	cmpwi 0,9,51
	bc 12,2,.L243
	li 0,50
	stw 0,56(31)
.L243:
	li 0,51
	b .L288
.L242:
	cmpwi 0,10,0
	bc 12,2,.L245
	cmpwi 7,8,0
	bc 12,30,.L246
	cmpwi 0,28,0
	bc 4,2,.L284
	li 0,105
	li 9,110
	b .L289
.L284:
	lwz 9,84(31)
	lwz 0,4436(9)
	cmpwi 0,0,0
	bc 4,2,.L249
	li 0,105
	li 9,110
	b .L289
.L249:
	li 0,246
	li 9,253
	b .L289
.L246:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L253
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L253
	lwz 9,84(31)
	lwz 0,4448(9)
	cmpwi 0,0,0
	bc 12,0,.L285
	li 0,156
	li 9,161
	b .L289
.L285:
	li 0,162
	li 9,167
	b .L289
.L253:
	cmpwi 6,28,0
	bc 12,26,.L258
	lwz 11,84(31)
	bc 12,30,.L259
	lwz 0,4436(11)
	cmpwi 0,0,0
	bc 4,2,.L259
	lwz 0,4448(11)
	cmpwi 0,0,0
	bc 4,2,.L259
	lwz 0,4452(11)
	cmpwi 0,0,0
	bc 4,2,.L259
	li 0,98
	li 9,104
	b .L289
.L259:
	lwz 9,4448(11)
	addi 9,9,300
	cmplwi 0,9,600
	bc 4,1,.L261
	bc 12,26,.L261
	lwz 0,4436(11)
	cmpwi 0,0,0
	bc 4,2,.L261
	li 0,254
	li 9,259
	b .L289
.L261:
	li 0,246
	li 9,253
	b .L289
.L258:
	lhz 0,926(31)
	cmpwi 0,0,0
	bc 12,2,.L264
	li 0,394
	li 9,401
	b .L289
.L264:
	cmpwi 0,6,0
	bc 12,2,.L266
	lwz 9,84(31)
	lwz 0,4448(9)
	srawi 9,0,31
	xor 11,9,0
	subf 11,9,11
	cmpwi 0,11,200
	bc 4,1,.L266
	li 0,139
	li 9,144
	b .L289
.L266:
	li 0,19
	li 9,24
	b .L289
.L245:
	cmpwi 0,8,0
	bc 12,2,.L269
	cmpwi 0,28,0
	bc 4,2,.L286
	li 0,98
	li 9,104
	b .L289
.L286:
	lwz 9,84(31)
	lwz 0,4436(9)
	cmpwi 0,0,0
	bc 4,2,.L244
	li 0,98
	li 9,104
	b .L289
.L269:
	lhz 0,926(31)
	cmpwi 0,0,0
	bc 12,2,.L274
	li 0,385
	li 9,393
	b .L289
.L274:
	cmpwi 0,28,0
	bc 12,2,.L276
	li 0,239
	li 9,245
	b .L289
.L276:
	cmpwi 0,6,0
	bc 12,2,.L278
	li 0,132
	li 9,138
.L289:
	stw 0,56(31)
	stw 9,4308(30)
	b .L244
.L278:
	stw 6,56(31)
	li 0,6
.L288:
	stw 0,4308(30)
.L244:
	lwz 0,4828(30)
	cmpwi 0,0,0
	bc 12,2,.L209
	cmpwi 0,0,2
	li 0,45
	bc 4,1,.L281
	li 0,46
.L281:
	li 9,49
	stw 0,56(31)
	stw 9,4308(30)
.L209:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe8:
	.size	 G_SetClientFrame,.Lfe8-G_SetClientFrame
	.section	".rodata"
	.align 3
.LC95:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC96:
	.long 0x40200000
	.long 0x0
	.align 2
.LC97:
	.long 0x0
	.align 2
.LC98:
	.long 0x43340000
	.align 2
.LC99:
	.long 0xc3b40000
	.align 2
.LC100:
	.long 0x40400000
	.align 2
.LC101:
	.long 0x40800000
	.align 2
.LC102:
	.long 0x40a00000
	.align 2
.LC103:
	.long 0x43520000
	.align 2
.LC104:
	.long 0x42c80000
	.align 2
.LC105:
	.long 0x43610000
	.section	".text"
	.align 2
	.globl ClientEndServerFrame
	.type	 ClientEndServerFrame,@function
ClientEndServerFrame:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	lis 10,current_client@ha
	lwz 11,84(31)
	lis 9,current_player@ha
	addi 29,31,376
	stw 31,current_player@l(9)
	mr 8,29
	stw 11,current_client@l(10)
	lis 9,.LC96@ha
	addi 10,11,10
	la 9,.LC96@l(9)
	li 11,3
	lfd 11,0(9)
	mtctr 11
.L332:
	lfs 0,-372(8)
	mr 11,9
	fmul 0,0,11
	fctiwz 13,0
	stfd 13,40(1)
	lwz 9,44(1)
	sth 9,-6(10)
	lfs 0,0(8)
	addi 8,8,4
	fmul 0,0,11
	fctiwz 12,0
	stfd 12,40(1)
	lwz 11,44(1)
	sth 11,0(10)
	addi 10,10,2
	bdnz .L332
	lis 11,.LC97@ha
	lis 9,level+200@ha
	la 11,.LC97@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L297
	lis 9,current_client@ha
	lis 0,0x42b4
	lwz 11,current_client@l(9)
	mr 3,31
	stw 0,112(11)
	stfs 13,108(11)
	bl G_SetStats
	b .L291
.L297:
	lwz 3,84(31)
	lis 4,forward@ha
	lis 5,right@ha
	lis 6,up@ha
	la 5,right@l(5)
	la 6,up@l(6)
	addi 3,3,4252
	la 4,forward@l(4)
	bl AngleVectors
	bl P_WorldEffects
	lwz 9,84(31)
	lis 11,.LC98@ha
	la 11,.LC98@l(11)
	lfs 0,0(11)
	lfs 12,4252(9)
	fcmpu 0,12,0
	bc 4,1,.L298
	lis 9,.LC99@ha
	lis 11,.LC100@ha
	la 9,.LC99@l(9)
	la 11,.LC100@l(11)
	lfs 0,0(9)
	lfs 13,0(11)
	fadds 0,12,0
	fdivs 0,0,13
	b .L333
.L298:
	lis 9,.LC100@ha
	la 9,.LC100@l(9)
	lfs 0,0(9)
	fdivs 0,12,0
.L333:
	stfs 0,16(31)
	lwz 9,84(31)
	lis 11,.LC97@ha
	lis 0,0x3f80
	la 11,.LC97@l(11)
	lfs 12,376(31)
	lfs 9,0(11)
	lfs 13,4256(9)
	lis 11,right@ha
	la 10,right@l(11)
	stfs 9,24(31)
	stfs 13,20(31)
	lfs 13,4(10)
	lfs 0,4(29)
	lfs 10,right@l(11)
	lfs 11,8(29)
	fmuls 0,0,13
	lfs 13,8(10)
	fmadds 12,12,10,0
	fmadds 13,11,13,12
	fcmpu 0,13,9
	bc 4,0,.L300
	lis 0,0xbf80
.L300:
	lis 8,sv_rollspeed@ha
	fabs 13,13
	lis 9,sv_rollangle@ha
	lwz 11,sv_rollspeed@l(8)
	lwz 10,sv_rollangle@l(9)
	lfs 12,20(11)
	lfs 0,20(10)
	fcmpu 0,13,12
	bc 4,0,.L302
	fmuls 0,13,0
	fdivs 13,0,12
	b .L303
.L302:
	fmr 13,0
.L303:
	lfs 0,380(31)
	lis 9,.LC101@ha
	lis 29,xyspeed@ha
	stw 0,8(1)
	la 9,.LC101@l(9)
	lfs 12,8(1)
	fmuls 0,0,0
	lfs 1,376(31)
	fmuls 13,13,12
	lfs 12,0(9)
	fmadds 1,1,1,0
	fmuls 13,13,12
	stfs 13,24(31)
	bl sqrt
	lis 9,.LC102@ha
	frsp 1,1
	la 9,.LC102@l(9)
	lfs 0,0(9)
	stfs 1,xyspeed@l(29)
	fcmpu 0,1,0
	bc 4,0,.L305
	lis 11,current_client@ha
	li 0,0
	lwz 10,current_client@l(11)
	lis 9,bobmove@ha
	stw 0,bobmove@l(9)
	stw 0,4264(10)
	b .L306
.L305:
	lwz 0,552(31)
	lis 9,bobmove@ha
	cmpwi 0,0,0
	bc 12,2,.L306
	lis 11,.LC103@ha
	la 11,.LC103@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L308
	lis 0,0x3e80
	b .L334
.L308:
	lis 11,.LC104@ha
	la 11,.LC104@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L310
	lis 0,0x3e00
	b .L334
.L310:
	lis 0,0x3d80
.L334:
	stw 0,bobmove@l(9)
.L306:
	lis 11,current_client@ha
	lis 10,bobmove@ha
	lwz 9,current_client@l(11)
	lfs 13,bobmove@l(10)
	lfs 0,4264(9)
	lbz 0,16(9)
	fadds 0,0,13
	andi. 11,0,1
	fmr 13,0
	stfs 0,4264(9)
	bc 12,2,.L312
	lis 9,.LC101@ha
	la 9,.LC101@l(9)
	lfs 0,0(9)
	fmuls 13,13,0
.L312:
	lis 11,.LC95@ha
	lfd 1,.LC95@l(11)
	lis 10,bobcycle@ha
	lis 29,bobfracsin@ha
	fctiwz 0,13
	fmul 1,13,1
	stfd 0,40(1)
	lwz 9,44(1)
	stw 9,bobcycle@l(10)
	bl sin
	fabs 1,1
	mr 3,31
	frsp 1,1
	stfs 1,bobfracsin@l(29)
	bl P_FallingDamage
	mr 3,31
	bl P_DamageFeedback
	mr 3,31
	bl SV_CalcViewOffset
	mr 3,31
	bl SV_CalcGunOffset
	mr 3,31
	bl SV_CalcBlend
	lwz 9,84(31)
	lwz 0,4076(9)
	cmpwi 0,0,0
	bc 12,2,.L313
	mr 3,31
	bl G_SetSpectatorStats
	b .L314
.L313:
	mr 3,31
	bl G_SetStats
.L314:
	mr 3,31
	bl G_CheckChaseStats
	lwz 0,80(31)
	cmpwi 0,0,0
	bc 4,2,.L316
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L316
	lis 11,.LC105@ha
	lis 9,xyspeed@ha
	la 11,.LC105@l(11)
	lfs 0,xyspeed@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L316
	lis 11,current_client@ha
	lis 8,bobmove@ha
	lwz 10,current_client@l(11)
	lfs 12,bobmove@l(8)
	lis 11,bobcycle@ha
	lfs 0,4264(10)
	lwz 0,bobcycle@l(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,40(1)
	lwz 9,44(1)
	cmpw 0,9,0
	bc 12,2,.L316
	li 0,2
	stw 0,80(31)
.L316:
	lwz 9,492(31)
	cmpwi 0,9,0
	bc 4,2,.L319
	lwz 0,480(31)
	stw 9,68(31)
	cmpwi 0,0,0
	stw 9,64(31)
	bc 4,1,.L319
	lis 11,.LC97@ha
	lis 9,level+200@ha
	la 11,.LC97@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L319
	lwz 9,84(31)
	lwz 0,4800(9)
	cmpwi 0,0,1
	bc 4,2,.L323
	lis 0,0x1000
	stw 0,64(31)
.L323:
	lwz 9,84(31)
	lwz 0,4800(9)
	cmpwi 0,0,2
	bc 4,2,.L324
	lwz 0,68(31)
	ori 0,0,128
	stw 0,68(31)
.L324:
	mr 3,31
	bl CTFEffects
	lwz 0,264(31)
	andi. 9,0,16
	bc 12,2,.L319
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,7168
	stw 0,64(31)
	stw 9,68(31)
.L319:
	mr 3,31
	bl G_SetClientSound
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,1,.L326
	mr 3,31
	bl G_SetClientFrame
.L326:
	lfs 0,376(31)
	li 0,0
	lwz 11,84(31)
	stfs 0,4280(11)
	lfs 0,380(31)
	lwz 9,84(31)
	stfs 0,4284(9)
	lfs 0,384(31)
	lwz 11,84(31)
	stfs 0,4288(11)
	lwz 9,84(31)
	lfs 0,28(9)
	stfs 0,4268(9)
	lwz 11,84(31)
	lfs 0,32(11)
	stfs 0,4272(11)
	lwz 10,84(31)
	lfs 0,36(10)
	stfs 0,4276(10)
	lwz 9,84(31)
	stw 0,4200(9)
	stw 0,4208(9)
	stw 0,4204(9)
	lwz 11,84(31)
	stw 0,4188(11)
	stw 0,4196(11)
	stw 0,4192(11)
	lwz 11,84(31)
	lwz 0,4112(11)
	cmpwi 0,0,0
	bc 12,2,.L327
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,31
	bc 4,2,.L327
	lwz 0,4760(11)
	cmpwi 0,0,0
	bc 12,2,.L328
	mr 3,31
	bl PMenu_Update
	b .L329
.L328:
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
.L329:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,0
	mtlr 0
	blrl
.L327:
	lis 9,holdthephone@ha
	lwz 0,holdthephone@l(9)
	cmpwi 0,0,1
	bc 4,2,.L330
	lwz 9,84(31)
	mr 3,31
	stw 0,4112(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,0
	mtlr 0
	blrl
.L330:
	lwz 9,84(31)
	lwz 0,4724(9)
	cmpwi 0,0,0
	bc 12,2,.L291
	mr 3,31
	bl CheckChasecam_Viewent
.L291:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 ClientEndServerFrame,.Lfe9-ClientEndServerFrame
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.section	".sbss","aw",@nobits
	.align 2
current_player:
	.space	4
	.size	 current_player,4
	.align 2
current_client:
	.space	4
	.size	 current_client,4
	.lcomm	forward,12,4
	.lcomm	right,12,4
	.lcomm	up,12,4
	.comm	xyspeed,4,4
	.comm	bobmove,4,4
	.comm	bobcycle,4,4
	.comm	bobfracsin,4,4
	.section	".rodata"
	.align 2
.LC106:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_CalcRoll
	.type	 SV_CalcRoll,@function
SV_CalcRoll:
	stwu 1,-32(1)
	lis 9,right@ha
	lfs 12,4(4)
	lis 10,.LC106@ha
	la 11,right@l(9)
	lfs 10,right@l(9)
	la 10,.LC106@l(10)
	lfs 13,4(11)
	lis 0,0x3f80
	lfs 0,0(4)
	lfs 11,8(4)
	fmuls 12,12,13
	lfs 9,0(10)
	lfs 13,8(11)
	fmadds 0,0,10,12
	fmadds 0,11,13,0
	fcmpu 0,0,9
	bc 4,0,.L7
	lis 0,0xbf80
.L7:
	lis 8,sv_rollspeed@ha
	fabs 0,0
	lis 9,sv_rollangle@ha
	lwz 11,sv_rollspeed@l(8)
	lwz 10,sv_rollangle@l(9)
	lfs 13,20(11)
	lfs 1,20(10)
	fcmpu 0,0,13
	bc 4,0,.L9
	fmuls 0,0,1
	fdivs 0,0,13
	b .L10
.L9:
	fmr 0,1
.L10:
	stw 0,8(1)
	lfs 13,8(1)
	fmuls 1,0,13
	la 1,32(1)
	blr
.Lfe10:
	.size	 SV_CalcRoll,.Lfe10-SV_CalcRoll
	.section	".rodata"
	.align 2
.LC107:
	.long 0x0
	.align 2
.LC108:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SV_AddBlend
	.type	 SV_AddBlend,@function
SV_AddBlend:
	lis 9,.LC107@ha
	la 9,.LC107@l(9)
	lfs 0,0(9)
	fcmpu 0,4,0
	cror 3,2,0
	bclr 12,3
	lis 9,.LC108@ha
	lfs 12,12(3)
	la 9,.LC108@l(9)
	lfs 8,0(3)
	lfs 13,0(9)
	lfs 9,4(3)
	lfs 11,8(3)
	fsubs 0,13,12
	fmadds 0,0,4,12
	fdivs 12,12,0
	stfs 0,12(3)
	fsubs 13,13,12
	fmuls 0,3,13
	fmuls 10,1,13
	fmuls 13,2,13
	fmadds 11,11,12,0
	fmadds 8,8,12,10
	fmadds 9,9,12,13
	stfs 11,8(3)
	stfs 8,0(3)
	stfs 9,4(3)
	blr
.Lfe11:
	.size	 SV_AddBlend,.Lfe11-SV_AddBlend
	.section	".rodata"
	.align 2
.LC109:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetClientEffects
	.type	 G_SetClientEffects,@function
G_SetClientEffects:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 9,0
	lwz 0,480(31)
	stw 9,68(31)
	cmpwi 0,0,0
	stw 9,64(31)
	bc 4,1,.L188
	lis 11,.LC109@ha
	lis 9,level+200@ha
	la 11,.LC109@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L188
	lwz 9,84(31)
	lwz 0,4800(9)
	cmpwi 0,0,1
	bc 4,2,.L191
	lis 0,0x1000
	stw 0,64(31)
.L191:
	lwz 9,84(31)
	lwz 0,4800(9)
	cmpwi 0,0,2
	bc 4,2,.L192
	lwz 0,68(31)
	ori 0,0,128
	stw 0,68(31)
.L192:
	mr 3,31
	bl CTFEffects
	lwz 0,264(31)
	andi. 9,0,16
	bc 12,2,.L188
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,7168
	stw 0,64(31)
	stw 9,68(31)
.L188:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 G_SetClientEffects,.Lfe12-G_SetClientEffects
	.section	".rodata"
	.align 2
.LC110:
	.long 0x43610000
	.section	".text"
	.align 2
	.globl G_SetClientEvent
	.type	 G_SetClientEvent,@function
G_SetClientEvent:
	stwu 1,-16(1)
	lwz 0,80(3)
	cmpwi 0,0,0
	bc 4,2,.L194
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 12,2,.L194
	lis 11,.LC110@ha
	lis 9,xyspeed@ha
	la 11,.LC110@l(11)
	lfs 0,xyspeed@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L194
	lis 11,current_client@ha
	lis 8,bobmove@ha
	lwz 10,current_client@l(11)
	lfs 12,bobmove@l(8)
	lis 11,bobcycle@ha
	lfs 0,4264(10)
	lwz 0,bobcycle@l(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	cmpw 0,9,0
	bc 12,2,.L194
	li 0,2
	stw 0,80(3)
.L194:
	la 1,16(1)
	blr
.Lfe13:
	.size	 G_SetClientEvent,.Lfe13-G_SetClientEvent
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
