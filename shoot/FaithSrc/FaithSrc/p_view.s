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
	.section	".sbss","aw",@nobits
	.align 2
i.12:
	.space	4
	.size	 i.12,4
	.section	".rodata"
	.align 2
.LC1:
	.string	"*pain%i_%i.wav"
	.align 3
.LC0:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC2:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC3:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC4:
	.long 0x3e4ccccd
	.align 3
.LC5:
	.long 0x3fe33333
	.long 0x33333333
	.align 2
.LC6:
	.long 0x3f19999a
	.align 3
.LC7:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0x41200000
	.align 2
.LC11:
	.long 0x3f800000
	.align 2
.LC12:
	.long 0x42c80000
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC14:
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
	li 9,0
	lwz 31,84(30)
	lwz 0,3576(31)
	sth 9,150(31)
	cmpwi 0,0,0
	bc 12,2,.L12
	li 0,1
	sth 0,150(31)
.L12:
	lwz 0,3568(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,264(30)
	andi. 8,0,16
	bc 4,2,.L13
	lis 11,level@ha
	lfs 12,3744(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC8@ha
	xoris 0,0,0x8000
	la 11,.LC8@l(11)
	stw 0,44(1)
	stw 10,40(1)
	lfd 13,0(11)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L13
	lhz 0,150(31)
	ori 0,0,2
	sth 0,150(31)
.L13:
	lis 9,.LC8@ha
	lwz 0,3576(31)
	la 9,.LC8@l(9)
	lwz 10,3568(31)
	lis 8,0x4330
	lfd 13,0(9)
	lis 9,.LC9@ha
	add 0,0,10
	la 9,.LC9@l(9)
	lfs 12,0(9)
	lwz 9,3572(31)
	add 0,0,9
	xoris 0,0,0x8000
	stw 0,44(1)
	stw 8,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 31,0
	fcmpu 0,31,12
	bc 12,2,.L11
	lwz 0,3728(31)
	cmpwi 0,0,2
	bc 12,1,.L15
	lwz 0,40(30)
	cmpwi 0,0,255
	bc 4,2,.L15
	lbz 9,16(31)
	li 0,3
	stw 0,3728(31)
	andi. 10,9,1
	bc 12,2,.L16
	li 0,168
	li 9,172
	b .L42
.L16:
	lis 8,i.12@ha
	lis 9,0x5555
	lwz 10,i.12@l(8)
	ori 9,9,21846
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	cmpwi 0,10,1
	stw 10,i.12@l(8)
	bc 12,2,.L20
	bc 12,1,.L24
	cmpwi 0,10,0
	bc 12,2,.L19
	b .L15
.L24:
	cmpwi 0,10,2
	bc 12,2,.L21
	b .L15
.L19:
	li 0,53
	li 9,57
	b .L42
.L20:
	li 0,57
	li 9,61
	b .L42
.L21:
	li 0,61
	li 9,65
.L42:
	stw 0,56(30)
	stw 9,3724(31)
.L15:
	lis 11,.LC10@ha
	fmr 29,31
	la 11,.LC10@l(11)
	lfs 0,0(11)
	fcmpu 0,29,0
	bc 4,0,.L25
	lis 8,.LC10@ha
	la 8,.LC10@l(8)
	lfs 31,0(8)
.L25:
	lis 9,level@ha
	lfs 13,464(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L26
	lwz 0,264(30)
	andi. 9,0,16
	bc 4,2,.L26
	lis 9,level@ha
	lfs 12,3744(31)
	lwz 0,level@l(9)
	lis 10,.LC8@ha
	lis 9,0x4330
	la 10,.LC8@l(10)
	xoris 0,0,0x8000
	lfd 13,0(10)
	stw 0,44(1)
	stw 9,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L26
	bl rand
	lfs 0,4(29)
	lis 9,.LC0@ha
	rlwinm 3,3,0,31,31
	lfd 13,.LC0@l(9)
	addi 5,3,1
	lwz 0,480(30)
	cmpwi 0,0,24
	fadd 0,0,13
	frsp 0,0
	stfs 0,464(30)
	bc 12,1,.L27
	li 4,25
	b .L28
.L27:
	cmpwi 0,0,49
	bc 12,1,.L29
	li 4,50
	b .L28
.L29:
	cmpwi 7,0,74
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,100
	andi. 9,9,75
	or 4,0,9
.L28:
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC11@ha
	lis 9,.LC11@ha
	lis 10,.LC9@ha
	mr 5,3
	la 8,.LC11@l(8)
	la 9,.LC11@l(9)
	mtlr 0
	la 10,.LC9@l(10)
	li 4,2
	lfs 1,0(8)
	mr 3,30
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L26:
	lis 8,.LC9@ha
	lfs 0,3648(31)
	la 8,.LC9@l(8)
	lfs 30,0(8)
	fcmpu 0,0,30
	bc 4,0,.L33
	stfs 30,3648(31)
.L33:
	lfs 13,3648(31)
	lis 9,.LC2@ha
	fmr 28,31
	lis 11,.LC3@ha
	lfd 0,.LC2@l(9)
	lfd 12,.LC3@l(11)
	fmadd 0,28,0,13
	frsp 0,0
	fmr 13,0
	stfs 0,3648(31)
	fcmpu 0,13,12
	bc 4,0,.L34
	lis 9,.LC4@ha
	lfs 0,.LC4@l(9)
	stfs 0,3648(31)
.L34:
	lfs 0,3648(31)
	lis 9,.LC5@ha
	lfd 13,.LC5@l(9)
	fcmpu 0,0,13
	bc 4,1,.L35
	lis 9,.LC6@ha
	lfs 0,.LC6@l(9)
	stfs 0,3648(31)
.L35:
	stfs 30,16(1)
	stfs 30,12(1)
	stfs 30,8(1)
	lwz 0,3572(31)
	cmpwi 0,0,0
	bc 12,2,.L36
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 10,.LC8@ha
	la 10,.LC8@l(10)
	stw 11,40(1)
	addi 3,1,8
	lfd 0,0(10)
	lis 4,power_color.9@ha
	mr 5,3
	lfd 1,40(1)
	la 4,power_color.9@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,29
	bl VectorMA
.L36:
	lwz 0,3568(31)
	cmpwi 0,0,0
	bc 12,2,.L37
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 8,.LC8@ha
	la 8,.LC8@l(8)
	stw 11,40(1)
	addi 3,1,8
	lfd 0,0(8)
	lis 4,acolor.10@ha
	mr 5,3
	lfd 1,40(1)
	la 4,acolor.10@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,29
	bl VectorMA
.L37:
	lwz 0,3576(31)
	cmpwi 0,0,0
	bc 12,2,.L38
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 8,.LC8@ha
	la 8,.LC8@l(8)
	stw 11,40(1)
	addi 3,1,8
	lfd 0,0(8)
	lis 4,bcolor.11@ha
	mr 5,3
	lfd 1,40(1)
	la 4,bcolor.11@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,29
	bl VectorMA
.L38:
	lis 8,.LC8@ha
	lwz 11,3580(31)
	la 8,.LC8@l(8)
	lfs 0,8(1)
	lis 10,0x4330
	lfd 10,0(8)
	srawi 8,11,31
	xor 0,8,11
	stfs 0,3656(31)
	subf 0,8,0
	lfs 13,12(1)
	xoris 0,0,0x8000
	stw 0,44(1)
	stw 10,40(1)
	lfd 0,40(1)
	stfs 13,3660(31)
	lfs 12,16(1)
	fsub 0,0,10
	stfs 12,3664(31)
	frsp 31,0
	fcmpu 0,31,30
	bc 12,2,.L39
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L39
	xoris 0,0,0x8000
	lis 11,.LC12@ha
	stw 0,44(1)
	la 11,.LC12@l(11)
	lis 8,.LC13@ha
	stw 10,40(1)
	la 8,.LC13@l(8)
	lfd 0,40(1)
	lfs 12,0(11)
	lfd 30,0(8)
	fsub 0,0,10
	fmuls 12,31,12
	fmul 11,28,30
	frsp 0,0
	fdivs 31,12,0
	fmr 13,31
	fcmpu 0,13,11
	bc 4,0,.L40
	frsp 31,11
.L40:
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,1,.L41
	lis 10,.LC14@ha
	la 10,.LC14@l(10)
	lfs 31,0(10)
.L41:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,3584(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,3588(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,3592(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize
	lis 9,right@ha
	lfs 0,12(1)
	lis 10,.LC7@ha
	la 11,right@l(9)
	lfs 10,right@l(9)
	lis 8,forward@ha
	lfs 12,4(11)
	la 9,forward@l(8)
	lis 7,level+4@ha
	lfs 13,8(1)
	lfs 11,8(11)
	fmuls 0,0,12
	lfd 8,.LC7@l(10)
	lfs 12,16(1)
	fmadds 13,13,10,0
	fmadds 0,12,11,13
	fmuls 0,31,0
	fmul 0,0,8
	frsp 0,0
	stfs 0,3628(31)
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
	stfs 0,3632(31)
	lfs 13,level+4@l(7)
	fadd 13,13,30
	frsp 13,13
	stfs 13,3636(31)
.L39:
	li 0,0
	stw 0,3580(31)
	stw 0,3576(31)
	stw 0,3568(31)
	stw 0,3572(31)
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
.LC15:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC16:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC17:
	.long 0x0
	.align 2
.LC18:
	.long 0x40c00000
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC20:
	.long 0xc1600000
	.align 2
.LC21:
	.long 0x41600000
	.align 2
.LC22:
	.long 0xc1b00000
	.align 2
.LC23:
	.long 0x41f00000
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
	bc 12,2,.L44
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
	lfs 0,3596(9)
	stfs 0,32(9)
	b .L45
.L44:
	lfs 0,3604(31)
	lis 9,level@ha
	lis 11,.LC17@ha
	la 10,level@l(9)
	la 11,.LC17@l(11)
	lfs 11,0(11)
	stfs 0,52(31)
	lwz 9,84(12)
	lfs 0,3608(9)
	stfs 0,4(30)
	lwz 9,84(12)
	lfs 0,3612(9)
	stfs 0,8(30)
	lwz 9,84(12)
	lfs 13,4(10)
	lfs 0,3636(9)
	fsubs 0,0,13
	fadd 0,0,0
	frsp 9,0
	fcmpu 0,9,11
	bc 4,0,.L46
	lis 11,.LC17@ha
	la 11,.LC17@l(11)
	lfs 9,0(11)
	stfs 9,3632(9)
	lwz 9,84(12)
	stfs 9,3628(9)
.L46:
	lwz 9,84(12)
	lis 11,.LC15@ha
	lfs 13,52(31)
	lfs 0,3632(9)
	lfd 12,.LC15@l(11)
	fmadds 0,9,0,13
	stfs 0,52(31)
	lwz 9,84(12)
	lfs 13,8(30)
	lfs 0,3628(9)
	fmadds 0,9,0,13
	stfs 0,8(30)
	lwz 9,84(12)
	lfs 13,4(10)
	lfs 0,3640(9)
	fsubs 0,0,13
	fdiv 0,0,12
	frsp 9,0
	fcmpu 0,9,11
	bc 4,0,.L47
	lis 11,.LC17@ha
	la 11,.LC17@l(11)
	lfs 9,0(11)
.L47:
	lfs 11,3644(9)
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
	bc 12,2,.L48
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
	fmuls 10,10,0
.L48:
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
	bc 12,2,.L49
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
	fmuls 10,10,0
.L49:
	lis 9,bobcycle@ha
	lwz 0,bobcycle@l(9)
	andi. 9,0,1
	bc 12,2,.L50
	fneg 10,10
.L50:
	lfs 0,8(30)
	fadds 0,0,10
	stfs 0,8(30)
.L45:
	lwz 0,508(12)
	lis 8,0x4330
	lis 11,.LC19@ha
	lwz 7,84(12)
	lis 10,.LC15@ha
	xoris 0,0,0x8000
	la 11,.LC19@l(11)
	lfd 13,.LC15@l(10)
	stw 0,36(1)
	stw 8,32(1)
	lfd 12,0(11)
	lfd 0,32(1)
	lis 11,.LC17@ha
	la 11,.LC17@l(11)
	lfs 8,0(11)
	fsub 0,0,12
	lis 11,level+4@ha
	lfs 11,level+4@l(11)
	stfs 8,12(1)
	frsp 0,0
	stfs 8,8(1)
	fadds 12,0,8
	stfs 12,16(1)
	lfs 0,3640(7)
	fsubs 0,0,11
	fdiv 0,0,13
	frsp 9,0
	fcmpu 0,9,8
	bc 4,0,.L51
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 9,0(9)
.L51:
	lfs 0,3644(7)
	lis 9,.LC16@ha
	fmr 13,12
	lis 11,bobfracsin@ha
	lfd 10,.LC16@l(9)
	lis 10,xyspeed@ha
	lfs 12,bobfracsin@l(11)
	lis 9,bob_up@ha
	fmuls 0,9,0
	lis 11,.LC18@ha
	lfs 11,xyspeed@l(10)
	la 11,.LC18@l(11)
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
	bc 4,1,.L52
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
.L52:
	fadds 12,13,0
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
	lfs 10,0(11)
	stfs 12,16(1)
	lfs 0,3616(7)
	fadds 11,0,8
	stfs 11,8(1)
	fcmpu 0,11,10
	lfs 0,3620(7)
	fadds 0,0,8
	stfs 0,12(1)
	lfs 13,3624(7)
	fadds 12,12,13
	stfs 12,16(1)
	bc 4,0,.L53
	stfs 10,8(1)
	b .L54
.L53:
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L54
	stfs 0,8(1)
.L54:
	lis 11,.LC20@ha
	lfs 0,12(1)
	la 11,.LC20@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L62
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L57
.L62:
	stfs 13,12(1)
.L57:
	lis 11,.LC22@ha
	lfs 0,16(1)
	la 11,.LC22@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L63
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L60
.L63:
	stfs 13,16(1)
.L60:
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
.LC24:
	.long 0x3f747ae1
	.long 0x47ae147b
	.align 3
.LC25:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC26:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC27:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC28:
	.long 0x43340000
	.align 2
.LC29:
	.long 0x43b40000
	.align 2
.LC30:
	.long 0xc3340000
	.align 2
.LC31:
	.long 0x42340000
	.align 2
.LC32:
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
	lis 9,.LC24@ha
	lis 10,.LC25@ha
	lfs 13,xyspeed@l(7)
	lis 11,bobcycle@ha
	lfd 11,.LC24@l(9)
	lfd 12,.LC25@l(10)
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
	bc 12,2,.L65
	lwz 9,84(3)
	lfs 0,72(9)
	fneg 0,0
	stfs 0,72(9)
	lwz 11,84(3)
	lfs 0,68(11)
	fneg 0,0
	stfs 0,68(11)
.L65:
	lfs 0,xyspeed@l(7)
	lis 9,.LC26@ha
	lis 10,.LC28@ha
	lfs 13,bobfracsin@l(6)
	la 10,.LC28@l(10)
	li 0,3
	lfd 9,.LC26@l(9)
	lis 11,.LC27@ha
	mtctr 0
	li 7,0
	lfs 5,0(10)
	lis 9,.LC29@ha
	li 8,0
	fmuls 0,0,13
	la 9,.LC29@l(9)
	lis 10,.LC30@ha
	lfd 10,.LC27@l(11)
	la 10,.LC30@l(10)
	lfs 12,0(9)
	lfs 6,0(10)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lis 10,.LC32@ha
	lfs 7,0(9)
	la 10,.LC32@l(10)
	lwz 9,84(3)
	fmul 0,0,11
	lfs 8,0(10)
	frsp 0,0
	stfs 0,64(9)
.L82:
	lwz 10,84(3)
	addi 9,10,3684
	addi 11,10,28
	lfsx 13,9,8
	lfsx 0,11,8
	fsubs 13,13,0
	fcmpu 0,13,5
	bc 4,1,.L70
	fsubs 13,13,12
.L70:
	fcmpu 0,13,6
	bc 4,0,.L71
	fadds 13,13,12
.L71:
	fcmpu 0,13,7
	bc 4,1,.L72
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 13,0(9)
.L72:
	fcmpu 0,13,8
	bc 4,0,.L73
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 13,0(9)
.L73:
	cmpwi 0,7,1
	bc 4,2,.L74
	lfs 0,72(10)
	fmadd 0,13,9,0
	frsp 0,0
	stfs 0,72(10)
.L74:
	lwz 9,84(3)
	addi 7,7,1
	addi 9,9,64
	lfsx 0,9,8
	fmadd 0,13,10,0
	frsp 0,0
	stfsx 0,9,8
	addi 8,8,4
	bdnz .L82
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
.L81:
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
	bdnz .L81
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 SV_CalcGunOffset,.Lfe3-SV_CalcGunOffset
	.section	".rodata"
	.align 2
.LC39:
	.string	"items/damage2.wav"
	.align 2
.LC41:
	.string	"items/protect2.wav"
	.align 2
.LC42:
	.string	"items/airout.wav"
	.align 2
.LC33:
	.long 0x3e99999a
	.align 2
.LC34:
	.long 0x3f19999a
	.align 2
.LC35:
	.long 0x3dcccccd
	.align 2
.LC36:
	.long 0x3d4ccccd
	.align 2
.LC37:
	.long 0x3e4ccccd
	.align 2
.LC38:
	.long 0x3ecccccd
	.align 2
.LC40:
	.long 0x3da3d70a
	.align 2
.LC43:
	.long 0x3d23d70a
	.align 2
.LC44:
	.long 0x3f59999a
	.align 2
.LC45:
	.long 0x3f333333
	.align 3
.LC46:
	.long 0x3faeb851
	.long 0xeb851eb8
	.align 3
.LC47:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC48:
	.long 0x0
	.align 2
.LC49:
	.long 0x3f800000
	.align 2
.LC50:
	.long 0x3f000000
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
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
	mr 30,3
	li 0,0
	lwz 9,84(30)
	lis 10,gi+52@ha
	addi 3,1,8
	stw 0,96(9)
	stw 0,108(9)
	stw 0,104(9)
	stw 0,100(9)
	lwz 11,84(30)
	lfs 13,4(30)
	lfs 0,40(11)
	lfs 12,8(30)
	lfs 11,12(30)
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
	bc 12,2,.L86
	lwz 9,84(30)
	lwz 0,116(9)
	ori 0,0,1
	b .L142
.L86:
	lwz 9,84(30)
	lwz 0,116(9)
	rlwinm 0,0,0,0,30
.L142:
	stw 0,116(9)
	lwz 11,84(30)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 9,0(9)
	lfs 13,3812(11)
	fcmpu 0,13,9
	bc 4,1,.L88
	lfs 0,3816(11)
	lis 10,.LC49@ha
	la 10,.LC49@l(10)
	lfs 11,0(10)
	fdivs 13,13,0
	fcmpu 0,13,11
	bc 4,1,.L89
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 13,0(9)
.L89:
	lwz 0,3820(11)
	cmpwi 0,0,1
	bc 4,2,.L90
	fcmpu 0,13,9
	addi 9,11,96
	cror 3,2,0
	bc 12,3,.L93
	lfs 0,12(9)
	lfs 12,96(11)
	fsubs 10,11,0
	fmadds 10,10,13,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 11,11,9
	b .L143
.L90:
	fcmpu 0,13,9
	addi 9,11,96
	cror 3,2,0
	bc 12,3,.L93
	lfs 0,12(9)
	lfs 12,96(11)
	fsubs 10,11,0
	fmadds 10,10,13,0
	fdivs 0,0,10
	fsubs 11,11,0
.L143:
	fmadds 12,12,0,11
	stfs 12,96(11)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,11
	stfs 13,4(9)
	stfs 12,8(9)
.L93:
	lwz 9,84(30)
	lis 10,.LC49@ha
	la 10,.LC49@l(10)
	lfs 0,3812(9)
	lfs 13,0(10)
	fsubs 0,0,13
	stfs 0,3812(9)
.L88:
	andi. 11,3,9
	bc 12,2,.L96
	lis 9,.LC49@ha
	lwz 11,84(30)
	lis 10,.LC33@ha
	la 9,.LC49@l(9)
	lfs 13,.LC33@l(10)
	lfs 11,0(9)
	lis 9,.LC34@ha
	lfs 12,96(11)
	lfs 8,.LC34@l(9)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 9,0(9)
	addi 9,11,96
	lfs 0,12(9)
	fsubs 10,11,0
	fmadds 10,10,8,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmadds 12,12,0,11
	fmuls 9,11,9
	fmuls 11,11,13
	stfs 12,96(11)
	b .L144
.L96:
	andi. 10,3,16
	bc 12,2,.L100
	lis 9,.LC34@ha
	lwz 10,84(30)
	lis 11,.LC49@ha
	lfs 7,.LC34@l(9)
	la 11,.LC49@l(11)
	lis 8,.LC35@ha
	lis 9,.LC48@ha
	lfs 11,0(11)
	la 9,.LC48@l(9)
	lfs 12,96(10)
	lis 11,.LC36@ha
	lfs 13,0(9)
	addi 9,10,96
	lfs 9,.LC36@l(11)
	lfs 0,12(9)
	lfs 8,.LC35@l(8)
	b .L145
.L100:
	andi. 10,3,32
	bc 12,2,.L99
	lis 9,.LC38@ha
	lwz 10,84(30)
	lis 11,.LC49@ha
	lfs 7,.LC38@l(9)
	la 11,.LC49@l(11)
	lis 8,.LC33@ha
	lis 9,.LC50@ha
	lfs 11,0(11)
	la 9,.LC50@l(9)
	lfs 12,96(10)
	lis 11,.LC37@ha
	lfs 13,0(9)
	addi 9,10,96
	lfs 9,.LC37@l(11)
	lfs 0,12(9)
	lfs 8,.LC33@l(8)
.L145:
	fsubs 10,11,0
	fmadds 10,10,7,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 13,11,13
	fmuls 9,11,9
	fmuls 11,11,8
	fmadds 12,12,0,13
	stfs 12,96(10)
.L144:
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,9
	stfs 13,4(9)
	stfs 12,8(9)
.L99:
	lis 11,level@ha
	lwz 8,84(30)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC51@ha
	lfs 12,3740(8)
	xoris 0,0,0x8000
	la 11,.LC51@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L107
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 4,31,30
	bc 4,18,.L108
	lis 29,gi@ha
	lis 3,.LC39@ha
	la 29,gi@l(29)
	la 3,.LC39@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC49@ha
	lis 10,.LC49@ha
	lis 11,.LC48@ha
	mr 5,3
	la 9,.LC49@l(9)
	la 10,.LC49@l(10)
	mtlr 0
	la 11,.LC48@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L108:
	bc 12,17,.L110
	andi. 0,31,4
	bc 12,2,.L113
.L110:
	lis 9,.LC49@ha
	lwz 11,84(30)
	lis 10,.LC48@ha
	la 9,.LC49@l(9)
	la 10,.LC48@l(10)
	lfs 9,0(9)
	lis 9,.LC40@ha
	lfs 10,0(10)
	lfs 13,.LC40@l(9)
	addi 9,11,96
	lfs 12,96(11)
	lfs 0,12(9)
	fsubs 11,9,0
	fmadds 11,11,13,0
	fdivs 0,0,11
	fsubs 9,9,0
	fmuls 10,9,10
	fmadds 12,12,0,10
	stfs 12,96(11)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 11,12(9)
	fmadds 13,13,0,10
	fmadds 12,12,0,9
	b .L146
.L107:
	lfs 13,3744(8)
	fcmpu 0,13,0
	bc 4,1,.L114
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 4,31,30
	bc 4,18,.L115
	lis 29,gi@ha
	lis 3,.LC41@ha
	la 29,gi@l(29)
	la 3,.LC41@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC49@ha
	lis 10,.LC49@ha
	lis 11,.LC48@ha
	mr 5,3
	la 9,.LC49@l(9)
	la 10,.LC49@l(10)
	mtlr 0
	la 11,.LC48@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L115:
	bc 12,17,.L117
	andi. 0,31,4
	bc 12,2,.L113
.L117:
	lis 9,.LC49@ha
	lwz 11,84(30)
	lis 10,.LC48@ha
	la 9,.LC49@l(9)
	la 10,.LC48@l(10)
	lfs 10,0(9)
	lis 9,.LC40@ha
	lfs 12,96(11)
	lfs 13,.LC40@l(9)
	addi 9,11,96
	lfs 9,0(10)
	lfs 0,12(9)
	fsubs 11,10,0
	fmadds 11,11,13,0
	fdivs 0,0,11
	fsubs 10,10,0
	fmadds 12,12,0,10
	fmuls 9,10,9
	stfs 12,96(11)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 11,12(9)
	fmadds 13,13,0,10
	fmadds 12,12,0,9
	b .L146
.L114:
	lfs 13,3752(8)
	fcmpu 0,13,0
	bc 4,1,.L121
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 4,31,30
	bc 4,18,.L122
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC49@ha
	lis 10,.LC49@ha
	lis 11,.LC48@ha
	mr 5,3
	la 9,.LC49@l(9)
	la 10,.LC49@l(10)
	mtlr 0
	la 11,.LC48@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L122:
	bc 12,17,.L124
	andi. 0,31,4
	bc 12,2,.L113
.L124:
	lis 9,.LC49@ha
	lwz 11,84(30)
	lis 10,.LC48@ha
	la 9,.LC49@l(9)
	la 10,.LC48@l(10)
	lfs 10,0(9)
	lis 9,.LC40@ha
	lfs 9,0(10)
	lfs 13,.LC40@l(9)
	addi 9,11,96
	lfs 12,96(11)
	lfs 0,12(9)
	fsubs 11,10,0
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
	b .L146
.L121:
	lfs 13,3748(8)
	fcmpu 0,13,0
	bc 4,1,.L113
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 4,31,30
	bc 4,18,.L129
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC49@ha
	lis 10,.LC49@ha
	lis 11,.LC48@ha
	mr 5,3
	la 9,.LC49@l(9)
	la 10,.LC49@l(10)
	mtlr 0
	la 11,.LC48@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L129:
	bc 12,17,.L131
	andi. 0,31,4
	bc 12,2,.L113
.L131:
	lis 9,.LC49@ha
	lwz 10,84(30)
	lis 11,.LC38@ha
	la 9,.LC49@l(9)
	lfs 10,.LC38@l(11)
	lfs 9,0(9)
	lis 9,.LC43@ha
	lfs 12,96(10)
	lfs 13,.LC43@l(9)
	addi 9,10,96
	lfs 0,12(9)
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
.L146:
	stfs 13,4(9)
	stfs 12,8(9)
.L113:
	lwz 9,84(30)
	lis 10,.LC48@ha
	la 10,.LC48@l(10)
	lfs 0,0(10)
	lfs 8,3648(9)
	fcmpu 0,8,0
	bc 4,1,.L134
	lfs 12,3656(9)
	addi 11,9,96
	lfs 7,3660(9)
	lfs 9,3664(9)
	cror 3,2,0
	bc 12,3,.L134
	lis 10,.LC49@ha
	lfs 13,12(11)
	la 10,.LC49@l(10)
	lfs 11,96(9)
	lfs 0,0(10)
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
.L134:
	lwz 8,84(30)
	lis 11,.LC48@ha
	la 11,.LC48@l(11)
	lfs 0,0(11)
	lfs 12,3652(8)
	fcmpu 0,12,0
	bc 4,1,.L137
	lis 9,.LC44@ha
	lis 10,.LC45@ha
	lfs 7,.LC44@l(9)
	lis 11,.LC33@ha
	addi 9,8,96
	lfs 8,.LC45@l(10)
	lfs 9,.LC33@l(11)
	cror 3,2,0
	bc 12,3,.L137
	lis 10,.LC49@ha
	lfs 13,12(9)
	la 10,.LC49@l(10)
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
.L137:
	lwz 11,84(30)
	lis 9,.LC46@ha
	lis 10,.LC48@ha
	lfd 13,.LC46@l(9)
	la 10,.LC48@l(10)
	lfs 0,3648(11)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3648(11)
	lwz 9,84(30)
	lfs 0,3648(9)
	fcmpu 0,0,12
	bc 4,0,.L140
	stfs 12,3648(9)
.L140:
	lwz 11,84(30)
	lis 9,.LC47@ha
	lfd 13,.LC47@l(9)
	lfs 0,3652(11)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3652(11)
	lwz 3,84(30)
	lfs 0,3652(3)
	fcmpu 0,0,12
	bc 4,0,.L141
	stfs 12,3652(3)
.L141:
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
.LC52:
	.long 0x3f1a36e2
	.long 0xeb1c432d
	.align 3
.LC53:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC54:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC55:
	.long 0x0
	.align 3
.LC56:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC57:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC58:
	.long 0x3f800000
	.align 2
.LC59:
	.long 0x41700000
	.align 2
.LC60:
	.long 0x42200000
	.align 2
.LC61:
	.long 0x41f00000
	.align 2
.LC62:
	.long 0x425c0000
	.align 2
.LC63:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl P_FallingDamage
	.type	 P_FallingDamage,@function
P_FallingDamage:
	stwu 1,-48(1)
	mflr 0
	stw 0,52(1)
	lwz 0,40(3)
	cmpwi 0,0,255
	bc 4,2,.L147
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 12,2,.L147
	lwz 9,84(3)
	lis 11,.LC55@ha
	la 11,.LC55@l(11)
	lfs 0,0(11)
	mr 10,9
	lfs 13,3704(9)
	fcmpu 0,13,0
	bc 4,0,.L150
	lfs 0,384(3)
	fcmpu 0,0,13
	bc 4,1,.L150
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 4,2,.L169
	fmr 9,13
	b .L151
.L150:
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 12,2,.L147
.L169:
	lfs 13,384(3)
	lfs 0,3704(10)
	fsubs 9,13,0
.L151:
	lis 11,level@ha
	lfs 10,3788(10)
	fmuls 13,9,9
	lis 9,.LC53@ha
	la 8,level@l(11)
	lfd 11,.LC53@l(9)
	lfs 0,4(8)
	lis 11,.LC52@ha
	lfd 12,.LC52@l(11)
	fsubs 0,0,10
	fmul 13,13,12
	frsp 9,13
	fcmpu 0,0,11
	cror 3,2,0
	bc 12,3,.L147
	lwz 0,3780(10)
	cmpwi 0,0,0
	bc 12,2,.L153
	lwz 0,3784(10)
	cmpwi 0,0,0
	bc 12,1,.L147
.L153:
	lwz 0,612(3)
	cmpwi 0,0,3
	bc 12,2,.L147
	cmpwi 0,0,2
	bc 4,2,.L156
	lis 9,.LC56@ha
	fmr 0,9
	la 9,.LC56@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 9,0
.L156:
	cmpwi 0,0,1
	bc 4,2,.L157
	lis 11,.LC57@ha
	fmr 0,9
	la 11,.LC57@l(11)
	lfd 13,0(11)
	fmul 0,0,13
	frsp 9,0
.L157:
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 0,0(9)
	fcmpu 0,9,0
	bc 12,0,.L147
	lis 11,.LC59@ha
	la 11,.LC59@l(11)
	lfs 0,0(11)
	fcmpu 0,9,0
	bc 4,0,.L159
	li 0,2
	b .L170
.L159:
	lis 9,.LC57@ha
	fmr 0,9
	lis 11,.LC60@ha
	la 9,.LC57@l(9)
	la 11,.LC60@l(11)
	lfd 13,0(9)
	lfs 12,0(11)
	fmul 0,0,13
	frsp 0,0
	stfs 0,3644(10)
	lwz 9,84(3)
	lfs 0,3644(9)
	fcmpu 0,0,12
	bc 4,1,.L160
	stfs 12,3644(9)
.L160:
	lfs 0,4(8)
	lis 9,.LC54@ha
	lis 11,.LC61@ha
	lfd 12,.LC54@l(9)
	la 11,.LC61@l(11)
	lfs 13,0(11)
	lwz 9,84(3)
	fcmpu 0,9,13
	fadd 0,0,12
	frsp 0,0
	stfs 0,3640(9)
	bc 4,1,.L161
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L162
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 0,0(9)
	fcmpu 0,9,0
	li 0,4
	cror 3,2,1
	bc 4,3,.L163
	li 0,5
.L163:
	stw 0,80(3)
.L162:
	lis 11,.LC61@ha
	lis 9,.LC63@ha
	la 11,.LC61@l(11)
	la 9,.LC63@l(9)
	lfs 0,0(11)
	lis 0,0x3f80
	lfs 10,0(9)
	lis 11,deathmatch@ha
	lis 9,level+4@ha
	fsubs 0,9,0
	lfs 13,level+4@l(9)
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	fmuls 0,0,10
	lfs 11,0(9)
	lwz 9,deathmatch@l(11)
	stfs 13,464(3)
	stw 0,24(1)
	stfs 11,16(1)
	stfs 11,20(1)
	fctiwz 12,0
	lfs 13,20(9)
	stfd 12,40(1)
	fcmpu 0,13,11
	lwz 7,44(1)
	srawi 9,7,31
	subf 9,7,9
	srawi 9,9,31
	addi 0,9,1
	and 9,7,9
	or 7,9,0
	bc 12,2,.L167
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 11,44(1)
	andi. 0,11,8
	bc 4,2,.L147
.L167:
	lis 9,g_edicts@ha
	li 0,0
	lwz 4,g_edicts@l(9)
	li 11,22
	lis 8,vec3_origin@ha
	mr 9,7
	stw 0,8(1)
	la 8,vec3_origin@l(8)
	stw 11,12(1)
	mr 5,4
	addi 6,1,16
	addi 7,3,4
	li 10,0
	bl T_Damage
	b .L147
.L161:
	li 0,3
.L170:
	stw 0,80(3)
.L147:
	lwz 0,52(1)
	mtlr 0
	la 1,48(1)
	blr
.Lfe5:
	.size	 P_FallingDamage,.Lfe5-P_FallingDamage
	.section	".rodata"
	.align 2
.LC64:
	.string	"player/lava_in.wav"
	.align 2
.LC65:
	.string	"player/watr_in.wav"
	.align 2
.LC66:
	.string	"player/watr_out.wav"
	.align 2
.LC67:
	.string	"player/watr_un.wav"
	.align 2
.LC68:
	.string	"player/gasp1.wav"
	.align 2
.LC69:
	.string	"player/gasp2.wav"
	.align 2
.LC70:
	.string	"player/u_breath1.wav"
	.align 2
.LC71:
	.string	"player/u_breath2.wav"
	.align 2
.LC72:
	.string	"player/drown1.wav"
	.align 2
.LC73:
	.string	"*gurp1.wav"
	.align 2
.LC74:
	.string	"*gurp2.wav"
	.align 2
.LC75:
	.string	"player/burn1.wav"
	.align 2
.LC76:
	.string	"player/burn2.wav"
	.align 2
.LC77:
	.long 0x41400000
	.align 3
.LC78:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC79:
	.long 0x3f800000
	.align 2
.LC80:
	.long 0x0
	.align 2
.LC81:
	.long 0x41300000
	.align 2
.LC82:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl P_WorldEffects
	.type	 P_WorldEffects,@function
P_WorldEffects:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stmw 24,48(1)
	stw 0,84(1)
	stw 12,44(1)
	lis 9,current_player@ha
	lis 26,current_player@ha
	lwz 3,current_player@l(9)
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L173
	lis 7,.LC77@ha
	lis 9,level+4@ha
	la 7,.LC77@l(7)
	lfs 0,level+4@l(9)
	lfs 13,0(7)
	fadds 0,0,13
	stfs 0,404(3)
	b .L172
.L173:
	lis 9,current_client@ha
	lwz 30,612(3)
	lis 7,level@ha
	lwz 11,current_client@l(9)
	lis 6,0x4330
	addic 0,30,-1
	subfe 8,0,30
	lis 9,.LC78@ha
	lwz 31,3712(11)
	la 9,.LC78@l(9)
	stw 30,3712(11)
	lwz 0,level@l(7)
	lfd 13,0(9)
	xoris 0,0,0x8000
	lfs 11,3752(11)
	subfic 7,31,0
	adde 9,7,31
	stw 0,36(1)
	and. 7,9,8
	stw 6,32(1)
	lfd 0,32(1)
	lfs 12,3748(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,11,0
	fcmpu 6,12,0
	mfcr 24
	rlwinm 25,24,30,1
	rlwinm 24,24,26,1
	bc 12,2,.L174
	li 5,0
	addi 4,3,4
	bl PlayerNoise
	lwz 28,current_player@l(26)
	lwz 0,608(28)
	andi. 7,0,8
	bc 12,2,.L175
	lis 29,gi@ha
	lis 3,.LC64@ha
	la 29,gi@l(29)
	la 3,.LC64@l(3)
	b .L208
.L175:
	andi. 7,0,16
	bc 12,2,.L177
	lis 29,gi@ha
	lis 3,.LC65@ha
	la 29,gi@l(29)
	la 3,.LC65@l(3)
.L208:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L176
.L177:
	andi. 7,0,32
	bc 12,2,.L176
	lis 29,gi@ha
	lis 3,.LC65@ha
	la 29,gi@l(29)
	la 3,.LC65@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L176:
	lis 11,current_player@ha
	lis 7,.LC79@ha
	lwz 9,current_player@l(11)
	lis 10,level+4@ha
	la 7,.LC79@l(7)
	lfs 13,0(7)
	lwz 0,264(9)
	ori 0,0,8
	stw 0,264(9)
	lfs 0,level+4@l(10)
	fsubs 0,0,13
	stfs 0,468(9)
.L174:
	cmpwi 0,30,0
	addic 10,31,-1
	subfe 9,10,31
	mcrf 4,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 11,9,0
	bc 12,2,.L180
	lis 28,current_player@ha
	li 5,0
	lwz 3,current_player@l(28)
	addi 4,3,4
	bl PlayerNoise
	lis 29,gi@ha
	lis 3,.LC66@ha
	lwz 27,current_player@l(28)
	la 29,gi@l(29)
	la 3,.LC66@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	la 9,.LC79@l(9)
	mr 5,3
	la 7,.LC79@l(7)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,27
	lfs 3,0(10)
	blrl
	lwz 9,current_player@l(28)
	lwz 0,264(9)
	rlwinm 0,0,0,29,27
	stw 0,264(9)
.L180:
	cmpwi 0,30,3
	xori 0,31,3
	addic 7,0,-1
	subfe 9,7,0
	mfcr 27
	mfcr 0
	rlwinm 0,0,3,1
	and. 10,9,0
	bc 12,2,.L181
	lis 29,gi@ha
	lis 3,.LC67@ha
	la 29,gi@l(29)
	la 3,.LC67@l(3)
	lwz 11,36(29)
	lis 9,current_player@ha
	lwz 28,current_player@l(9)
	mtlr 11
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L181:
	xori 0,30,3
	xori 11,31,3
	subfic 7,11,0
	adde 11,7,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L182
	lis 9,current_player@ha
	lis 11,level+4@ha
	lwz 28,current_player@l(9)
	lfs 12,level+4@l(11)
	lfs 13,404(28)
	fcmpu 0,13,12
	bc 4,0,.L183
	lis 29,gi@ha
	lis 3,.LC68@ha
	la 29,gi@l(29)
	la 3,.LC68@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
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
	b .L182
.L183:
	lis 7,.LC81@ha
	la 7,.LC81@l(7)
	lfs 0,0(7)
	fadds 0,12,0
	fcmpu 0,13,0
	bc 4,0,.L182
	lis 29,gi@ha
	lis 3,.LC69@ha
	la 29,gi@l(29)
	la 3,.LC69@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L182:
	mtcrf 128,27
	bc 4,2,.L186
	or. 0,24,25
	bc 12,2,.L187
	lis 8,level@ha
	lis 7,.LC82@ha
	la 7,.LC82@l(7)
	la 9,level@l(8)
	lfs 13,0(7)
	lis 11,current_player@ha
	lfs 0,4(9)
	lis 7,0x4330
	lis 9,.LC78@ha
	lwz 28,current_player@l(11)
	la 9,.LC78@l(9)
	mr 11,10
	fadds 0,0,13
	lfd 11,0(9)
	lis 9,current_client@ha
	lwz 6,current_client@l(9)
	stfs 0,404(28)
	lis 9,0x51eb
	lwz 0,level@l(8)
	ori 9,9,34079
	lfs 13,3748(6)
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 7,32(1)
	lfd 0,32(1)
	fsub 0,0,11
	frsp 0,0
	fsubs 13,13,0
	fctiwz 12,13
	stfd 12,32(1)
	lwz 11,36(1)
	mulhw 9,11,9
	srawi 0,11,31
	srawi 9,9,3
	subf 9,0,9
	mulli 9,9,25
	cmpw 0,11,9
	bc 4,2,.L187
	lwz 0,3716(6)
	cmpwi 0,0,0
	bc 4,2,.L189
	lis 29,gi@ha
	lis 3,.LC70@ha
	la 29,gi@l(29)
	la 3,.LC70@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L190
.L189:
	lis 29,gi@ha
	lis 3,.LC71@ha
	la 29,gi@l(29)
	la 3,.LC71@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L190:
	lis 9,current_client@ha
	lis 11,current_player@ha
	lwz 10,current_client@l(9)
	li 5,0
	lwz 3,current_player@l(11)
	lwz 0,3716(10)
	addi 4,3,4
	xori 0,0,1
	stw 0,3716(10)
	bl PlayerNoise
.L187:
	lis 9,current_player@ha
	lis 11,level+4@ha
	lwz 10,current_player@l(9)
	lfs 13,level+4@l(11)
	lfs 0,404(10)
	fcmpu 0,0,13
	bc 4,0,.L198
	lwz 9,84(10)
	lfs 0,3708(9)
	fcmpu 0,0,13
	bc 4,0,.L198
	lwz 0,480(10)
	cmpwi 0,0,0
	bc 4,1,.L198
	lis 7,.LC79@ha
	la 7,.LC79@l(7)
	lfs 0,0(7)
	fadds 0,13,0
	stfs 0,3708(9)
	lwz 9,516(10)
	addi 9,9,2
	cmpwi 0,9,15
	stw 9,516(10)
	bc 4,1,.L193
	li 0,15
	stw 0,516(10)
.L193:
	lwz 28,current_player@l(26)
	lwz 9,480(28)
	lwz 0,516(28)
	cmpw 0,9,0
	bc 12,1,.L194
	lis 29,gi@ha
	lis 3,.LC72@ha
	la 29,gi@l(29)
	la 3,.LC72@l(3)
	b .L209
.L194:
	bl rand
	andi. 0,3,1
	bc 12,2,.L196
	lis 29,gi@ha
	lis 3,.LC73@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC73@l(3)
.L209:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L195
.L196:
	lis 29,gi@ha
	lis 3,.LC74@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC74@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L195:
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
	b .L198
.L186:
	lis 7,.LC77@ha
	lis 9,level+4@ha
	la 7,.LC77@l(7)
	lfs 0,level+4@l(9)
	lis 11,current_player@ha
	lfs 13,0(7)
	li 0,2
	lwz 9,current_player@l(11)
	fadds 0,0,13
	stw 0,516(9)
	stfs 0,404(9)
.L198:
	bc 12,18,.L172
	lis 9,current_player@ha
	lwz 11,current_player@l(9)
	lwz 0,608(11)
	andi. 9,0,24
	bc 12,2,.L172
	andi. 10,0,8
	bc 12,2,.L200
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L201
	lis 9,level+4@ha
	lfs 13,464(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L201
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 7,.LC78@ha
	la 7,.LC78@l(7)
	lis 9,current_client@ha
	xoris 0,0,0x8000
	lfd 12,0(7)
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	lwz 10,current_client@l(9)
	fsub 0,0,12
	lfs 13,3744(10)
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L201
	bl rand
	andi. 0,3,1
	bc 12,2,.L202
	lis 29,gi@ha
	lis 3,.LC75@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC75@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L203
.L202:
	lis 29,gi@ha
	lis 3,.LC76@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC76@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC79@ha
	lis 9,.LC79@ha
	lis 10,.LC80@ha
	mr 5,3
	la 7,.LC79@l(7)
	la 9,.LC79@l(9)
	mtlr 0
	la 10,.LC80@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L203:
	lis 7,.LC79@ha
	lis 11,level+4@ha
	la 7,.LC79@l(7)
	lfs 0,level+4@l(11)
	lis 9,current_player@ha
	lfs 13,0(7)
	lwz 11,current_player@l(9)
	fadds 0,0,13
	stfs 0,464(11)
.L201:
	cmpwi 0,25,0
	bc 12,2,.L204
	lis 9,current_player@ha
	lis 11,g_edicts@ha
	lwz 3,current_player@l(9)
	lis 6,vec3_origin@ha
	li 0,0
	li 9,19
	lwz 4,g_edicts@l(11)
	la 6,vec3_origin@l(6)
	stw 9,12(1)
	mr 8,6
	addi 7,3,4
	stw 0,8(1)
	mr 5,4
	mr 9,30
	li 10,0
	bl T_Damage
	b .L200
.L204:
	lis 9,current_player@ha
	lis 11,g_edicts@ha
	stw 25,8(1)
	lwz 3,current_player@l(9)
	lis 6,vec3_origin@ha
	li 0,19
	lwz 4,g_edicts@l(11)
	slwi 9,30,1
	la 6,vec3_origin@l(6)
	stw 0,12(1)
	add 9,9,30
	addi 7,3,4
	mr 5,4
	mr 8,6
	li 10,0
	bl T_Damage
.L200:
	lis 9,current_player@ha
	lwz 3,current_player@l(9)
	lwz 0,608(3)
	andi. 7,0,16
	bc 12,2,.L172
	cmpwi 0,25,0
	bc 4,2,.L172
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	stw 25,8(1)
	lwz 4,g_edicts@l(9)
	la 6,vec3_origin@l(6)
	li 0,18
	mr 9,30
	stw 0,12(1)
	addi 7,3,4
	mr 5,4
	mr 8,6
	li 10,0
	bl T_Damage
.L172:
	lwz 0,84(1)
	lwz 12,44(1)
	mtlr 0
	lmw 24,48(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe6:
	.size	 P_WorldEffects,.Lfe6-P_WorldEffects
	.section	".rodata"
	.align 2
.LC83:
	.long 0x0
	.align 3
.LC84:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl G_SetClientEffects
	.type	 G_SetClientEffects,@function
G_SetClientEffects:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	li 9,0
	lwz 0,480(31)
	stw 9,68(31)
	cmpwi 0,0,0
	stw 9,64(31)
	bc 4,1,.L210
	lis 9,level@ha
	lis 7,.LC83@ha
	la 7,.LC83@l(7)
	la 9,level@l(9)
	lfs 13,0(7)
	lfs 0,200(9)
	fcmpu 0,0,13
	bc 4,2,.L210
	lfs 13,4(9)
	lfs 0,500(31)
	fcmpu 0,0,13
	bc 4,1,.L213
	bl PowerArmorType
	cmpwi 0,3,1
	bc 4,2,.L214
	lwz 0,64(31)
	ori 0,0,512
	stw 0,64(31)
	b .L213
.L214:
	cmpwi 0,3,2
	bc 4,2,.L213
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(31)
	stw 9,68(31)
.L213:
	mr 3,31
	bl CTFEffects
	lis 11,level@ha
	lwz 10,84(31)
	lwz 11,level@l(11)
	lis 8,0x4330
	lis 7,.LC84@ha
	la 7,.LC84@l(7)
	lfs 12,3740(10)
	xoris 0,11,0x8000
	lfd 13,0(7)
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L217
	andi. 9,11,8
	bc 12,2,.L217
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,30
	bc 12,1,.L219
	andi. 11,0,4
	bc 12,2,.L217
.L219:
	lwz 0,64(31)
	ori 0,0,32768
	stw 0,64(31)
.L217:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 11,level@l(11)
	lis 8,0x4330
	lis 7,.LC84@ha
	la 7,.LC84@l(7)
	lfs 12,3744(10)
	xoris 0,11,0x8000
	lfd 13,0(7)
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L220
	andi. 9,11,8
	bc 12,2,.L220
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,30
	bc 12,1,.L222
	andi. 11,0,4
	bc 12,2,.L220
.L222:
	lwz 0,64(31)
	oris 0,0,0x1
	stw 0,64(31)
.L220:
	lwz 0,264(31)
	andi. 7,0,16
	bc 12,2,.L210
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,7168
	stw 0,64(31)
	stw 9,68(31)
.L210:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 G_SetClientEffects,.Lfe7-G_SetClientEffects
	.section	".rodata"
	.align 2
.LC85:
	.string	"misc/pc_up.wav"
	.align 2
.LC86:
	.string	""
	.align 2
.LC87:
	.string	"weapon_railgun"
	.align 2
.LC88:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC89:
	.string	"weapon_bfg"
	.align 2
.LC90:
	.string	"weapons/bfg_hum.wav"
	.align 2
.LC91:
	.long 0x3f800000
	.align 2
.LC92:
	.long 0x40400000
	.align 2
.LC93:
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
	lwz 0,3484(11)
	cmpw 0,0,9
	bc 12,2,.L229
	stw 9,3484(11)
	li 0,1
	lwz 9,84(31)
	stw 0,3488(9)
.L229:
	lwz 10,84(31)
	lwz 11,3488(10)
	cmpwi 7,11,3
	addic 0,11,-1
	subfe 9,0,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 8,9,0
	bc 12,2,.L230
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,63
	bc 4,2,.L230
	addi 0,11,1
	lis 29,gi@ha
	stw 0,3488(10)
	la 29,gi@l(29)
	lis 3,.LC85@ha
	lwz 9,36(29)
	la 3,.LC85@l(3)
	mtlr 9
	blrl
	lis 8,.LC91@ha
	lwz 0,16(29)
	lis 9,.LC92@ha
	la 8,.LC91@l(8)
	mr 5,3
	lfs 1,0(8)
	la 9,.LC92@l(9)
	li 4,2
	mtlr 0
	lis 8,.LC93@ha
	mr 3,31
	lfs 2,0(9)
	la 8,.LC93@l(8)
	lfs 3,0(8)
	blrl
.L230:
	lwz 9,84(31)
	lwz 3,1788(9)
	cmpwi 0,3,0
	bc 12,2,.L231
	lwz 29,0(3)
	b .L232
.L231:
	lis 9,.LC86@ha
	la 29,.LC86@l(9)
.L232:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L233
	lwz 0,608(31)
	andi. 8,0,24
	bc 12,2,.L233
	lis 9,snd_fry@ha
	lwz 0,snd_fry@l(9)
	b .L239
.L233:
	lis 4,.LC87@ha
	mr 3,29
	la 4,.LC87@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L235
	lis 9,gi+36@ha
	lis 3,.LC88@ha
	lwz 0,gi+36@l(9)
	la 3,.LC88@l(3)
	b .L241
.L235:
	lis 4,.LC89@ha
	mr 3,29
	la 4,.LC89@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L237
	lis 9,gi+36@ha
	lis 3,.LC90@ha
	lwz 0,gi+36@l(9)
	la 3,.LC90@l(3)
.L241:
	mtlr 0
	blrl
	stw 3,76(31)
	b .L234
.L237:
	lwz 9,84(31)
	lwz 0,3768(9)
	cmpwi 0,0,0
.L239:
	stw 0,76(31)
.L234:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 G_SetClientSound,.Lfe8-G_SetClientSound
	.section	".rodata"
	.align 2
.LC94:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetClientFrame
	.type	 G_SetClientFrame,@function
G_SetClientFrame:
	lwz 0,40(3)
	cmpwi 0,0,255
	bclr 4,2
	lis 10,.LC94@ha
	lis 9,xyspeed@ha
	lwz 11,84(3)
	la 10,.LC94@l(10)
	lfs 0,xyspeed@l(9)
	lfs 13,0(10)
	mr 5,11
	lbz 9,16(11)
	lwz 0,3732(11)
	fcmpu 7,0,13
	rlwinm 9,9,0,31,31
	cmpw 0,9,0
	crnor 31,30,30
	mfcr 7
	rlwinm 7,7,0,1
	bc 12,2,.L248
	lwz 0,3728(11)
	cmpwi 0,0,5
	bc 4,2,.L249
.L248:
	lwz 0,3736(11)
	lwz 8,3728(11)
	cmpw 0,7,0
	bc 12,2,.L250
	cmpwi 0,8,0
	bc 12,2,.L249
.L250:
	lwz 0,552(3)
	cmpwi 0,0,0
	mr 6,0
	bc 4,2,.L251
	cmpwi 0,8,1
	bc 4,1,.L249
.L251:
	cmpwi 0,8,-1
	bc 4,2,.L252
	lwz 10,56(3)
	lwz 0,3724(11)
	cmpw 0,10,0
	bc 4,1,.L254
	addi 0,10,-1
	stw 0,56(3)
	blr
.L252:
	lwz 10,56(3)
	lwz 0,3724(11)
	cmpw 0,10,0
	bc 4,0,.L254
	addi 0,10,1
	stw 0,56(3)
	blr
.L254:
	cmpwi 0,8,5
	bclr 12,2
	cmpwi 0,8,2
	bc 4,2,.L249
	cmpwi 0,6,0
	bclr 12,2
	li 0,1
	li 10,68
	stw 0,3728(5)
	li 11,71
	lwz 9,84(3)
	stw 10,56(3)
	stw 11,3724(9)
	blr
.L249:
	li 0,0
	stw 9,3732(11)
	stw 0,3728(11)
	stw 7,3736(11)
	lwz 10,552(3)
	cmpwi 0,10,0
	bc 4,2,.L259
	lwz 0,3780(11)
	cmpwi 0,0,0
	bc 12,2,.L260
	stw 10,56(3)
.L271:
	li 0,39
	stw 0,3724(11)
	blr
.L260:
	li 0,2
	stw 0,3728(11)
	lwz 9,56(3)
	cmpwi 0,9,67
	bc 12,2,.L262
	li 0,66
	stw 0,56(3)
.L262:
	li 0,67
	stw 0,3724(11)
	blr
.L259:
	cmpwi 0,7,0
	bc 12,2,.L264
	cmpwi 0,9,0
	bc 12,2,.L265
	li 0,154
	li 9,159
.L270:
	stw 0,56(3)
	stw 9,3724(11)
	blr
.L265:
	li 0,40
	li 9,45
	b .L270
.L264:
	cmpwi 0,9,0
	bc 12,2,.L268
	li 0,135
	li 9,153
	b .L270
.L268:
	stw 9,56(3)
	b .L271
.Lfe9:
	.size	 G_SetClientFrame,.Lfe9-G_SetClientFrame
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
	.long 0x3f800000
	.align 3
.LC106:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC107:
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
.L310:
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
	bdnz .L310
	lis 11,.LC97@ha
	lis 9,level+200@ha
	la 11,.LC97@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L278
	lis 9,current_client@ha
	lis 0,0x42b4
	lwz 11,current_client@l(9)
	mr 3,31
	stw 0,112(11)
	stfs 13,108(11)
	bl G_SetStats
	b .L272
.L278:
	lwz 3,84(31)
	lis 4,forward@ha
	lis 5,right@ha
	lis 6,up@ha
	la 4,forward@l(4)
	la 6,up@l(6)
	addi 3,3,3668
	la 5,right@l(5)
	bl AngleVectors
	bl P_WorldEffects
	lwz 9,84(31)
	lis 11,.LC98@ha
	la 11,.LC98@l(11)
	lfs 0,0(11)
	lfs 12,3668(9)
	fcmpu 0,12,0
	bc 4,1,.L279
	lis 9,.LC99@ha
	lis 11,.LC100@ha
	la 9,.LC99@l(9)
	la 11,.LC100@l(11)
	lfs 0,0(9)
	lfs 13,0(11)
	fadds 0,12,0
	fdivs 0,0,13
	b .L311
.L279:
	lis 9,.LC100@ha
	la 9,.LC100@l(9)
	lfs 0,0(9)
	fdivs 0,12,0
.L311:
	stfs 0,16(31)
	lwz 9,84(31)
	lis 11,.LC97@ha
	lis 0,0x3f80
	la 11,.LC97@l(11)
	lfs 12,376(31)
	lfs 9,0(11)
	lfs 13,3672(9)
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
	bc 4,0,.L281
	lis 0,0xbf80
.L281:
	lis 8,sv_rollspeed@ha
	fabs 13,13
	lis 9,sv_rollangle@ha
	lwz 11,sv_rollspeed@l(8)
	lwz 10,sv_rollangle@l(9)
	lfs 12,20(11)
	lfs 0,20(10)
	fcmpu 0,13,12
	bc 4,0,.L283
	fmuls 0,13,0
	fdivs 13,0,12
	b .L284
.L283:
	fmr 13,0
.L284:
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
	bc 4,0,.L286
	lis 11,current_client@ha
	li 0,0
	lwz 10,current_client@l(11)
	lis 9,bobmove@ha
	stw 0,bobmove@l(9)
	stw 0,3680(10)
	b .L287
.L286:
	lwz 0,552(31)
	lis 9,bobmove@ha
	cmpwi 0,0,0
	bc 12,2,.L287
	lis 11,.LC103@ha
	la 11,.LC103@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L289
	lis 0,0x3e80
	b .L312
.L289:
	lis 11,.LC104@ha
	la 11,.LC104@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L291
	lis 0,0x3e00
	b .L312
.L309:
	lwz 4,84(31)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 9,84(29)
	li 0,1
	sth 0,146(9)
	b .L296
.L291:
	lis 0,0x3d80
.L312:
	stw 0,bobmove@l(9)
.L287:
	lis 11,current_client@ha
	lis 10,bobmove@ha
	lwz 9,current_client@l(11)
	lfs 13,bobmove@l(10)
	lfs 0,3680(9)
	lbz 0,16(9)
	fadds 0,0,13
	andi. 11,0,1
	fmr 13,0
	stfs 0,3680(9)
	bc 12,2,.L293
	lis 9,.LC101@ha
	la 9,.LC101@l(9)
	lfs 0,0(9)
	fmuls 13,13,0
.L293:
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
	lwz 0,3804(9)
	cmpwi 0,0,0
	bc 4,2,.L294
	mr 3,31
	bl G_SetStats
.L294:
	lis 11,.LC105@ha
	lis 9,maxclients@ha
	la 11,.LC105@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L296
	lis 9,g_edicts@ha
	lwz 0,88(31)
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC106@ha
	cmpwi 7,0,0
	la 9,.LC106@l(9)
	addi 29,11,904
	lfd 13,0(9)
	addi 11,11,988
.L298:
	bc 12,30,.L297
	lwz 3,0(11)
	lwz 0,3804(3)
	cmpw 0,0,31
	bc 12,2,.L309
.L297:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,904
	stw 0,44(1)
	addi 29,29,904
	stw 8,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L298
.L296:
	lwz 0,80(31)
	cmpwi 0,0,0
	bc 4,2,.L303
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L303
	lis 11,.LC107@ha
	lis 9,xyspeed@ha
	la 11,.LC107@l(11)
	lfs 0,xyspeed@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L303
	lis 11,current_client@ha
	lis 8,bobmove@ha
	lwz 10,current_client@l(11)
	lfs 12,bobmove@l(8)
	lis 11,bobcycle@ha
	lfs 0,3680(10)
	lwz 0,bobcycle@l(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,40(1)
	lwz 9,44(1)
	cmpw 0,9,0
	bc 12,2,.L303
	li 0,2
	stw 0,80(31)
.L303:
	mr 3,31
	bl G_SetClientEffects
	mr 3,31
	bl G_SetClientSound
	mr 3,31
	bl G_SetClientFrame
	lfs 0,376(31)
	li 0,0
	lwz 11,84(31)
	stfs 0,3696(11)
	lfs 0,380(31)
	lwz 9,84(31)
	stfs 0,3700(9)
	lfs 0,384(31)
	lwz 11,84(31)
	stfs 0,3704(11)
	lwz 9,84(31)
	lfs 0,28(9)
	stfs 0,3684(9)
	lwz 11,84(31)
	lfs 0,32(11)
	stfs 0,3688(11)
	lwz 10,84(31)
	lfs 0,36(10)
	stfs 0,3692(10)
	lwz 9,84(31)
	stw 0,3616(9)
	stw 0,3624(9)
	stw 0,3620(9)
	lwz 11,84(31)
	stw 0,3604(11)
	stw 0,3612(11)
	stw 0,3608(11)
	lwz 11,84(31)
	lwz 0,3520(11)
	cmpwi 0,0,0
	bc 12,2,.L272
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,31
	bc 4,2,.L272
	lwz 0,3528(11)
	cmpwi 0,0,0
	bc 12,2,.L307
	mr 3,31
	bl PMenu_Update
	b .L308
.L307:
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
.L308:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,0
	mtlr 0
	blrl
.L272:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 ClientEndServerFrame,.Lfe10-ClientEndServerFrame
	.comm	maplist,292,4
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
.LC108:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_CalcRoll
	.type	 SV_CalcRoll,@function
SV_CalcRoll:
	stwu 1,-32(1)
	lis 9,right@ha
	lfs 12,4(4)
	lis 10,.LC108@ha
	la 11,right@l(9)
	lfs 10,right@l(9)
	la 10,.LC108@l(10)
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
.Lfe11:
	.size	 SV_CalcRoll,.Lfe11-SV_CalcRoll
	.section	".rodata"
	.align 2
.LC109:
	.long 0x0
	.align 2
.LC110:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SV_AddBlend
	.type	 SV_AddBlend,@function
SV_AddBlend:
	lis 9,.LC109@ha
	la 9,.LC109@l(9)
	lfs 0,0(9)
	fcmpu 0,4,0
	cror 3,2,0
	bclr 12,3
	lis 9,.LC110@ha
	lfs 12,12(3)
	la 9,.LC110@l(9)
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
.Lfe12:
	.size	 SV_AddBlend,.Lfe12-SV_AddBlend
	.section	".rodata"
	.align 2
.LC111:
	.long 0x43610000
	.section	".text"
	.align 2
	.globl G_SetClientEvent
	.type	 G_SetClientEvent,@function
G_SetClientEvent:
	stwu 1,-16(1)
	lwz 0,80(3)
	cmpwi 0,0,0
	bc 4,2,.L224
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 12,2,.L224
	lis 11,.LC111@ha
	lis 9,xyspeed@ha
	la 11,.LC111@l(11)
	lfs 0,xyspeed@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L224
	lis 11,current_client@ha
	lis 8,bobmove@ha
	lwz 10,current_client@l(11)
	lfs 12,bobmove@l(8)
	lis 11,bobcycle@ha
	lfs 0,3680(10)
	lwz 0,bobcycle@l(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	cmpw 0,9,0
	bc 12,2,.L224
	li 0,2
	stw 0,80(3)
.L224:
	la 1,16(1)
	blr
.Lfe13:
	.size	 G_SetClientEvent,.Lfe13-G_SetClientEvent
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
