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
	.string	"player/burn1.wav"
	.align 2
.LC2:
	.string	"player/burn2.wav"
	.align 2
.LC3:
	.string	"*pain%i_%i.wav"
	.align 3
.LC0:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC4:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC5:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x3e4ccccd
	.align 3
.LC7:
	.long 0x3fe33333
	.long 0x33333333
	.align 2
.LC8:
	.long 0x3f19999a
	.align 3
.LC9:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC11:
	.long 0x0
	.align 2
.LC12:
	.long 0x41200000
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
	.long 0x42c80000
	.align 3
.LC15:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC16:
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
	lwz 0,3636(31)
	sth 9,150(31)
	cmpwi 0,0,0
	bc 12,2,.L12
	li 0,1
	sth 0,150(31)
.L12:
	lwz 0,3628(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,264(30)
	andi. 8,0,16
	bc 4,2,.L13
	lis 11,level@ha
	lfs 12,3804(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC10@ha
	xoris 0,0,0x8000
	la 11,.LC10@l(11)
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
	lis 9,.LC10@ha
	lwz 0,3636(31)
	la 9,.LC10@l(9)
	lwz 10,3628(31)
	lis 8,0x4330
	lfd 13,0(9)
	lis 9,.LC11@ha
	add 0,0,10
	la 9,.LC11@l(9)
	lfs 12,0(9)
	lwz 9,3632(31)
	add 0,0,9
	xoris 0,0,0x8000
	stw 0,44(1)
	stw 8,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 31,0
	fcmpu 0,31,12
	bc 12,2,.L11
	lwz 0,3788(31)
	cmpwi 0,0,2
	bc 12,1,.L15
	lwz 0,40(30)
	cmpwi 0,0,255
	bc 4,2,.L15
	lbz 9,16(31)
	li 0,3
	stw 0,3788(31)
	andi. 10,9,1
	bc 12,2,.L16
	li 0,168
	li 9,172
	b .L46
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
	b .L46
.L20:
	li 0,57
	li 9,61
	b .L46
.L21:
	li 0,61
	li 9,65
.L46:
	stw 0,56(30)
	stw 9,3784(31)
.L15:
	lis 11,.LC12@ha
	fmr 28,31
	la 11,.LC12@l(11)
	lfs 0,0(11)
	fcmpu 0,28,0
	bc 4,0,.L25
	lis 8,.LC12@ha
	la 8,.LC12@l(8)
	lfs 31,0(8)
.L25:
	lis 9,level@ha
	lfs 0,464(30)
	la 29,level@l(9)
	lfs 11,4(29)
	fcmpu 0,11,0
	bc 4,1,.L26
	lwz 0,264(30)
	andi. 9,0,16
	bc 4,2,.L26
	lis 9,level@ha
	lfs 12,3804(31)
	lwz 0,level@l(9)
	lis 10,.LC10@ha
	lis 9,0x4330
	la 10,.LC10@l(10)
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
	lfs 0,1140(30)
	fcmpu 0,0,11
	bc 4,1,.L27
	lis 9,.LC0@ha
	fmr 0,11
	lfd 13,.LC0@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,464(30)
	bl rand
	andi. 0,3,1
	bc 12,2,.L28
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	b .L47
.L28:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
.L47:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC13@ha
	lis 9,.LC13@ha
	lis 10,.LC11@ha
	mr 5,3
	la 8,.LC13@l(8)
	la 9,.LC13@l(9)
	mtlr 0
	la 10,.LC11@l(10)
	li 4,2
	lfs 1,0(8)
	mr 3,30
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L26
.L27:
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
	bc 12,1,.L31
	li 4,25
	b .L32
.L31:
	cmpwi 0,0,49
	bc 12,1,.L33
	li 4,50
	b .L32
.L33:
	cmpwi 7,0,74
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,100
	andi. 9,9,75
	or 4,0,9
.L32:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC13@ha
	lis 9,.LC13@ha
	lis 10,.LC11@ha
	mr 5,3
	la 8,.LC13@l(8)
	la 9,.LC13@l(9)
	mtlr 0
	la 10,.LC11@l(10)
	li 4,2
	lfs 1,0(8)
	mr 3,30
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L26:
	lis 8,.LC11@ha
	lfs 0,3708(31)
	la 8,.LC11@l(8)
	lfs 30,0(8)
	fcmpu 0,0,30
	bc 4,0,.L37
	stfs 30,3708(31)
.L37:
	lfs 13,3708(31)
	lis 9,.LC4@ha
	fmr 29,31
	lis 11,.LC5@ha
	lfd 0,.LC4@l(9)
	lfd 12,.LC5@l(11)
	fmadd 0,29,0,13
	frsp 0,0
	fmr 13,0
	stfs 0,3708(31)
	fcmpu 0,13,12
	bc 4,0,.L38
	lis 9,.LC6@ha
	lfs 0,.LC6@l(9)
	stfs 0,3708(31)
.L38:
	lfs 0,3708(31)
	lis 9,.LC7@ha
	lfd 13,.LC7@l(9)
	fcmpu 0,0,13
	bc 4,1,.L39
	lis 9,.LC8@ha
	lfs 0,.LC8@l(9)
	stfs 0,3708(31)
.L39:
	stfs 30,16(1)
	stfs 30,12(1)
	stfs 30,8(1)
	lwz 0,3632(31)
	cmpwi 0,0,0
	bc 12,2,.L40
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 10,.LC10@ha
	la 10,.LC10@l(10)
	stw 11,40(1)
	addi 3,1,8
	lfd 0,0(10)
	lis 4,power_color.9@ha
	mr 5,3
	lfd 1,40(1)
	la 4,power_color.9@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,28
	bl VectorMA
.L40:
	lwz 0,3628(31)
	cmpwi 0,0,0
	bc 12,2,.L41
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 8,.LC10@ha
	la 8,.LC10@l(8)
	stw 11,40(1)
	addi 3,1,8
	lfd 0,0(8)
	lis 4,acolor.10@ha
	mr 5,3
	lfd 1,40(1)
	la 4,acolor.10@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,28
	bl VectorMA
.L41:
	lwz 0,3636(31)
	cmpwi 0,0,0
	bc 12,2,.L42
	xoris 0,0,0x8000
	stw 0,44(1)
	lis 11,0x4330
	lis 8,.LC10@ha
	la 8,.LC10@l(8)
	stw 11,40(1)
	addi 3,1,8
	lfd 0,0(8)
	lis 4,bcolor.11@ha
	mr 5,3
	lfd 1,40(1)
	la 4,bcolor.11@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,28
	bl VectorMA
.L42:
	lis 8,.LC10@ha
	lwz 11,3640(31)
	la 8,.LC10@l(8)
	lfs 0,8(1)
	lis 10,0x4330
	lfd 10,0(8)
	srawi 8,11,31
	xor 0,8,11
	stfs 0,3716(31)
	subf 0,8,0
	lfs 13,12(1)
	xoris 0,0,0x8000
	stw 0,44(1)
	stw 10,40(1)
	lfd 0,40(1)
	stfs 13,3720(31)
	lfs 12,16(1)
	fsub 0,0,10
	stfs 12,3724(31)
	frsp 31,0
	fcmpu 0,31,30
	bc 12,2,.L43
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L43
	xoris 0,0,0x8000
	lis 11,.LC14@ha
	stw 0,44(1)
	la 11,.LC14@l(11)
	lis 8,.LC15@ha
	stw 10,40(1)
	la 8,.LC15@l(8)
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
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,1,.L45
	lis 10,.LC16@ha
	la 10,.LC16@l(10)
	lfs 31,0(10)
.L45:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,3644(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,3648(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,3652(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize
	lis 9,right@ha
	lfs 0,12(1)
	lis 10,.LC9@ha
	la 11,right@l(9)
	lfs 10,right@l(9)
	lis 8,forward@ha
	lfs 12,4(11)
	la 9,forward@l(8)
	lis 7,level+4@ha
	lfs 13,8(1)
	lfs 11,8(11)
	fmuls 0,0,12
	lfd 8,.LC9@l(10)
	lfs 12,16(1)
	fmadds 13,13,10,0
	fmadds 0,12,11,13
	fmuls 0,31,0
	fmul 0,0,8
	frsp 0,0
	stfs 0,3688(31)
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
	stfs 0,3692(31)
	lfs 13,level+4@l(7)
	fadd 13,13,30
	frsp 13,13
	stfs 13,3696(31)
.L43:
	li 0,0
	stw 0,3640(31)
	stw 0,3636(31)
	stw 0,3628(31)
	stw 0,3632(31)
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
.LC17:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC18:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x40c00000
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC22:
	.long 0xc1600000
	.align 2
.LC23:
	.long 0x41600000
	.align 2
.LC24:
	.long 0xc1b00000
	.align 2
.LC25:
	.long 0x41f00000
	.align 2
.LC26:
	.long 0xc2000000
	.align 2
.LC27:
	.long 0x41000000
	.align 2
.LC28:
	.long 0x43c80000
	.section	".text"
	.align 2
	.globl SV_CalcViewOffset
	.type	 SV_CalcViewOffset,@function
SV_CalcViewOffset:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 31,3
	lwz 0,492(31)
	lwz 29,84(31)
	cmpwi 0,0,0
	addi 28,29,52
	bc 12,2,.L49
	li 0,0
	lis 10,0x4220
	stw 0,4(28)
	lis 8,0xc170
	stw 0,8(28)
	stw 0,52(29)
	lwz 9,84(31)
	stw 10,36(9)
	lwz 11,84(31)
	stw 8,28(11)
	lwz 9,84(31)
	lfs 0,3656(9)
	stfs 0,32(9)
	b .L50
.L49:
	lfs 0,3664(29)
	lis 9,level@ha
	lis 7,.LC19@ha
	la 10,level@l(9)
	la 7,.LC19@l(7)
	lfs 11,0(7)
	stfs 0,52(29)
	lwz 9,84(31)
	lfs 0,3668(9)
	stfs 0,4(28)
	lwz 9,84(31)
	lfs 0,3672(9)
	stfs 0,8(28)
	lwz 9,84(31)
	lfs 13,4(10)
	lfs 0,3696(9)
	fsubs 0,0,13
	fadd 0,0,0
	frsp 9,0
	fcmpu 0,9,11
	bc 4,0,.L51
	lis 11,.LC19@ha
	la 11,.LC19@l(11)
	lfs 9,0(11)
	stfs 9,3692(9)
	lwz 9,84(31)
	stfs 9,3688(9)
.L51:
	lwz 9,84(31)
	lis 11,.LC17@ha
	lfs 13,52(29)
	lfs 0,3692(9)
	lfd 12,.LC17@l(11)
	fmadds 0,9,0,13
	stfs 0,52(29)
	lwz 9,84(31)
	lfs 13,8(28)
	lfs 0,3688(9)
	fmadds 0,9,0,13
	stfs 0,8(28)
	lwz 9,84(31)
	lfs 13,4(10)
	lfs 0,3700(9)
	fsubs 0,0,13
	fdiv 0,0,12
	frsp 9,0
	fcmpu 0,9,11
	bc 4,0,.L52
	lis 7,.LC19@ha
	la 7,.LC19@l(7)
	lfs 9,0(7)
.L52:
	lfs 11,3704(9)
	lis 7,run_pitch@ha
	lis 10,right@ha
	lfs 0,52(29)
	lis 9,forward@ha
	la 8,right@l(10)
	la 11,forward@l(9)
	lis 6,run_roll@ha
	lis 5,bob_pitch@ha
	lis 4,bobfracsin@ha
	fmadds 11,9,11,0
	lis 3,xyspeed@ha
	stfs 11,52(29)
	lfs 12,4(11)
	lfs 0,380(31)
	lfs 10,forward@l(9)
	lfs 13,376(31)
	fmuls 0,0,12
	lfs 9,8(11)
	lfs 12,384(31)
	lwz 9,run_pitch@l(7)
	fmadds 13,13,10,0
	lfs 0,20(9)
	fmadds 10,12,9,13
	fmadds 0,10,0,11
	stfs 0,52(29)
	lfs 0,4(8)
	lfs 13,380(31)
	lfs 11,right@l(10)
	lfs 12,376(31)
	fmuls 13,13,0
	lfs 9,8(8)
	lfs 10,384(31)
	lwz 9,run_roll@l(6)
	fmadds 12,12,11,13
	lwz 11,bob_pitch@l(5)
	lfs 0,20(9)
	lfs 11,8(28)
	fmadds 10,10,9,12
	lfs 13,bobfracsin@l(4)
	lfs 12,xyspeed@l(3)
	fmadds 0,10,0,11
	stfs 0,8(28)
	lwz 9,84(31)
	lfs 0,20(11)
	lbz 0,16(9)
	fmuls 13,13,0
	andi. 9,0,1
	fmuls 10,13,12
	bc 12,2,.L53
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
	lfs 0,0(11)
	fmuls 10,10,0
.L53:
	lfs 0,52(29)
	lis 9,bob_roll@ha
	fadds 0,0,10
	stfs 0,52(29)
	lwz 11,bob_roll@l(9)
	lis 9,bobfracsin@ha
	lwz 10,84(31)
	lfs 0,bobfracsin@l(9)
	lfs 13,20(11)
	lis 9,xyspeed@ha
	lbz 0,16(10)
	fmuls 0,0,13
	andi. 7,0,1
	lfs 13,xyspeed@l(9)
	fmuls 10,0,13
	bc 12,2,.L54
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fmuls 10,10,0
.L54:
	lis 9,bobcycle@ha
	lwz 0,bobcycle@l(9)
	andi. 11,0,1
	bc 12,2,.L55
	fneg 10,10
.L55:
	lfs 0,8(28)
	fadds 0,0,10
	stfs 0,8(28)
.L50:
	lwz 0,508(31)
	lis 8,0x4330
	lis 7,.LC21@ha
	lis 11,.LC19@ha
	xoris 0,0,0x8000
	la 7,.LC21@l(7)
	stw 0,124(1)
	la 11,.LC19@l(11)
	lis 10,.LC17@ha
	stw 8,120(1)
	lfd 12,0(7)
	lfd 0,120(1)
	lfs 8,0(11)
	lwz 7,84(31)
	lis 11,level+4@ha
	fsub 0,0,12
	lfs 11,level+4@l(11)
	stfs 8,12(1)
	stfs 8,8(1)
	frsp 0,0
	lfd 13,.LC17@l(10)
	fadds 12,0,8
	stfs 12,16(1)
	lfs 0,3700(7)
	fsubs 0,0,11
	fdiv 0,0,13
	frsp 9,0
	fcmpu 0,9,8
	bc 4,0,.L56
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 9,0(9)
.L56:
	lfs 0,3704(7)
	lis 9,.LC18@ha
	fmr 13,12
	lis 11,bobfracsin@ha
	lfd 10,.LC18@l(9)
	lis 10,xyspeed@ha
	lfs 12,bobfracsin@l(11)
	lis 9,bob_up@ha
	fmuls 0,9,0
	lis 11,.LC20@ha
	lfs 11,xyspeed@l(10)
	la 11,.LC20@l(11)
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
	bc 4,1,.L57
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
.L57:
	fadds 12,13,0
	stfs 12,16(1)
	lfs 0,3676(7)
	fadds 11,0,8
	stfs 11,8(1)
	lfs 0,3680(7)
	fadds 0,0,8
	stfs 0,12(1)
	lfs 13,3684(7)
	fadds 12,12,13
	stfs 12,16(1)
	lwz 0,3912(7)
	cmpwi 0,0,0
	bc 4,2,.L58
	lwz 0,3908(7)
	cmpwi 0,0,0
	bc 4,2,.L58
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfs 0,0(11)
	fcmpu 0,11,0
	bc 12,0,.L72
	lis 7,.LC23@ha
	la 7,.LC23@l(7)
	lfs 0,0(7)
	fcmpu 0,11,0
	bc 4,1,.L60
.L72:
	stfs 0,8(1)
.L60:
	lis 9,.LC22@ha
	lfs 0,12(1)
	la 9,.LC22@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L73
	lis 11,.LC23@ha
	la 11,.LC23@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L63
.L73:
	stfs 13,12(1)
.L63:
	lis 7,.LC24@ha
	lfs 0,16(1)
	la 7,.LC24@l(7)
	lfs 13,0(7)
	fcmpu 0,0,13
	bc 12,0,.L74
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L68
.L74:
	stfs 13,16(1)
	b .L68
.L58:
	lwz 3,84(31)
	li 0,0
	stw 0,16(1)
	stw 0,8(1)
	stw 0,12(1)
	lwz 9,3908(3)
	cmpwi 0,9,0
	bc 12,2,.L69
	addi 28,1,24
	addi 29,1,40
	addi 3,3,28
	li 6,0
	mr 4,28
	li 5,0
	bl AngleVectors
	lwz 9,84(31)
	lis 7,.LC26@ha
	mr 4,28
	la 7,.LC26@l(7)
	mr 5,29
	lfs 1,0(7)
	lwz 3,3908(9)
	addi 3,3,4
	bl VectorMA
	lwz 11,84(31)
	lis 10,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(10)
	mr 7,29
	mr 8,31
	lwz 4,3908(11)
	addi 3,1,56
	ori 9,9,3
	li 5,0
	li 6,0
	mtlr 0
	addi 4,4,4
	blrl
	lis 7,.LC27@ha
	lfs 7,68(1)
	la 7,.LC27@l(7)
	lfs 8,72(1)
	mr 11,9
	lfs 9,0(7)
	mr 10,9
	mr 3,28
	lfs 10,76(1)
	lis 7,.LC28@ha
	lwz 8,84(31)
	la 7,.LC28@l(7)
	fmuls 0,7,9
	stfs 8,44(1)
	stfs 10,48(1)
	stfs 7,40(1)
	lfs 1,0(7)
	fctiwz 13,0
	stfd 13,120(1)
	lwz 9,124(1)
	sth 9,4(8)
	lfs 0,44(1)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,120(1)
	lwz 11,124(1)
	sth 11,6(9)
	lfs 0,48(1)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,120(1)
	lwz 10,124(1)
	sth 10,8(9)
	lwz 11,84(31)
	lfs 0,28(11)
	lwz 9,3908(11)
	stfs 0,16(9)
	lwz 11,84(31)
	lfs 0,32(11)
	lwz 9,3908(11)
	stfs 0,20(9)
	lwz 11,84(31)
	lfs 0,36(11)
	lwz 9,3908(11)
	stfs 0,24(9)
	lwz 11,84(31)
	lwz 4,3908(11)
	addi 4,4,376
	bl VectorScale
	b .L68
.L69:
	lwz 9,3916(3)
	cmpwi 0,9,0
	bc 12,2,.L68
	lis 7,.LC27@ha
	lfs 0,4(9)
	la 7,.LC27@l(7)
	lfs 10,0(7)
	mr 11,9
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,120(1)
	lwz 9,124(1)
	sth 9,4(3)
	lwz 8,84(31)
	lwz 9,3916(8)
	lfs 0,8(9)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,120(1)
	lwz 11,124(1)
	sth 11,6(8)
	lwz 7,84(31)
	lwz 9,3916(7)
	lfs 0,12(9)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,120(1)
	lwz 10,124(1)
	sth 10,8(7)
	lwz 11,84(31)
	lwz 9,3916(11)
	lfs 0,16(9)
	stfs 0,28(11)
	lwz 10,84(31)
	lwz 9,3916(10)
	lfs 0,20(9)
	stfs 0,32(10)
	lwz 11,84(31)
	lwz 9,3916(11)
	lfs 0,24(9)
	stfs 0,36(11)
.L68:
	lfs 0,8(1)
	lwz 9,84(31)
	stfs 0,40(9)
	lfs 0,12(1)
	lwz 11,84(31)
	stfs 0,44(11)
	lfs 0,16(1)
	lwz 9,84(31)
	stfs 0,48(9)
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
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
	bc 12,2,.L76
	lwz 9,84(3)
	lfs 0,72(9)
	fneg 0,0
	stfs 0,72(9)
	lwz 11,84(3)
	lfs 0,68(11)
	fneg 0,0
	stfs 0,68(11)
.L76:
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
.L93:
	lwz 10,84(3)
	addi 9,10,3744
	addi 11,10,28
	lfsx 13,9,8
	lfsx 0,11,8
	fsubs 13,13,0
	fcmpu 0,13,5
	bc 4,1,.L81
	fsubs 13,13,12
.L81:
	fcmpu 0,13,6
	bc 4,0,.L82
	fadds 13,13,12
.L82:
	fcmpu 0,13,7
	bc 4,1,.L83
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
.L83:
	fcmpu 0,13,8
	bc 4,0,.L84
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
.L84:
	cmpwi 0,7,1
	bc 4,2,.L85
	lfs 0,72(10)
	fmadd 0,13,9,0
	frsp 0,0
	stfs 0,72(10)
.L85:
	lwz 9,84(3)
	addi 7,7,1
	addi 9,9,64
	lfsx 0,9,8
	fmadd 0,13,10,0
	frsp 0,0
	stfsx 0,9,8
	addi 8,8,4
	bdnz .L93
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
.L92:
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
	bdnz .L92
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 SV_CalcGunOffset,.Lfe3-SV_CalcGunOffset
	.section	".rodata"
	.align 2
.LC44:
	.string	"Jetpack"
	.align 2
.LC45:
	.string	"hover/hovidle1.wav"
	.align 2
.LC47:
	.string	"items/protect.wav"
	.align 2
.LC49:
	.string	"items/damage2.wav"
	.align 2
.LC50:
	.string	"items/protect2.wav"
	.align 2
.LC51:
	.string	"cloak/off.wav"
	.align 2
.LC52:
	.string	"cloak/running.wav"
	.align 2
.LC53:
	.string	"items/airout.wav"
	.align 2
.LC56:
	.string	"copb/copb_4.wav"
	.align 2
.LC57:
	.string	"copb/copb_5.wav"
	.align 2
.LC59:
	.string	"copb/copb_1.wav"
	.align 2
.LC61:
	.string	"copb/copb_2.wav"
	.align 2
.LC62:
	.string	"copb/copb_3.wav"
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
.LC42:
	.long 0x3e4ccccd
	.align 2
.LC43:
	.long 0x3ecccccd
	.align 2
.LC46:
	.long 0x3f666666
	.align 2
.LC48:
	.long 0x3da3d70a
	.align 2
.LC54:
	.long 0x3d23d70a
	.align 2
.LC55:
	.long 0x46fffe00
	.align 3
.LC58:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC60:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 2
.LC63:
	.long 0x3f59999a
	.align 2
.LC64:
	.long 0x3f333333
	.align 3
.LC65:
	.long 0x3faeb851
	.long 0xeb851eb8
	.align 3
.LC66:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC67:
	.long 0x3f800000
	.align 2
.LC68:
	.long 0x0
	.align 2
.LC69:
	.long 0x3f000000
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC71:
	.long 0x42200000
	.align 3
.LC72:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC73:
	.long 0x42c80000
	.align 2
.LC74:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl SV_CalcBlend
	.type	 SV_CalcBlend,@function
SV_CalcBlend:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 28,48(1)
	stw 0,84(1)
	stw 12,44(1)
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
	bc 12,2,.L97
	lwz 9,84(30)
	lwz 0,116(9)
	ori 0,0,1
	b .L190
.L97:
	lwz 9,84(30)
	lwz 0,116(9)
	rlwinm 0,0,0,0,30
.L190:
	stw 0,116(9)
	andi. 9,3,9
	bc 12,2,.L99
	lis 9,.LC39@ha
	lwz 11,84(30)
	lis 10,.LC67@ha
	lfs 8,.LC39@l(9)
	la 10,.LC67@l(10)
	lis 9,.LC68@ha
	lfs 11,0(10)
	la 9,.LC68@l(9)
	lfs 12,96(11)
	lis 10,.LC38@ha
	lfs 9,0(9)
	addi 9,11,96
	lfs 13,.LC38@l(10)
	lfs 0,12(9)
	fsubs 10,11,0
	fmadds 10,10,8,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmadds 12,12,0,11
	fmuls 9,11,9
	fmuls 11,11,13
	stfs 12,96(11)
	b .L191
.L99:
	andi. 10,3,16
	bc 12,2,.L103
	lis 9,.LC39@ha
	lwz 10,84(30)
	lis 11,.LC67@ha
	lfs 7,.LC39@l(9)
	la 11,.LC67@l(11)
	lis 8,.LC40@ha
	lis 9,.LC68@ha
	lfs 11,0(11)
	la 9,.LC68@l(9)
	lfs 12,96(10)
	lis 11,.LC41@ha
	lfs 13,0(9)
	addi 9,10,96
	lfs 9,.LC41@l(11)
	lfs 0,12(9)
	lfs 8,.LC40@l(8)
	b .L192
.L103:
	andi. 10,3,32
	bc 12,2,.L102
	lis 9,.LC43@ha
	lwz 10,84(30)
	lis 11,.LC67@ha
	lfs 7,.LC43@l(9)
	la 11,.LC67@l(11)
	lis 8,.LC38@ha
	lis 9,.LC69@ha
	lfs 11,0(11)
	la 9,.LC69@l(9)
	lfs 12,96(10)
	lis 11,.LC42@ha
	lfs 13,0(9)
	addi 9,10,96
	lfs 9,.LC42@l(11)
	lfs 0,12(9)
	lfs 8,.LC38@l(8)
.L192:
	fsubs 10,11,0
	fmadds 10,10,7,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 13,11,13
	fmuls 9,11,9
	fmuls 11,11,8
	fmadds 12,12,0,13
	stfs 12,96(10)
.L191:
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,9
	stfs 13,4(9)
	stfs 12,8(9)
.L102:
	mr 3,30
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L110
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,.LC70@ha
	lis 3,.LC44@ha
	lis 9,0x4330
	la 10,.LC70@l(10)
	xoris 0,0,0x8000
	lfd 12,0(10)
	la 3,.LC44@l(3)
	stw 0,36(1)
	stw 9,32(1)
	lfd 0,32(1)
	lwz 10,84(30)
	fsub 0,0,12
	lfs 13,3996(10)
	frsp 0,0
	fsubs 31,13,0
	bl FindItem
	lis 10,.LC68@ha
	lis 9,itemlist@ha
	lwz 11,84(30)
	fmr 12,31
	la 10,.LC68@l(10)
	la 9,itemlist@l(9)
	lfs 13,0(10)
	subf 3,9,3
	lis 0,0x3cf3
	ori 0,0,53053
	fctiwz 0,12
	mullw 3,3,0
	addi 11,11,740
	fcmpu 0,31,13
	rlwinm 3,3,0,0,29
	stfd 0,32(1)
	lwz 31,36(1)
	stwx 31,11,3
	bc 4,2,.L111
	mr 3,30
	bl ValidateSelectedItem
.L111:
	lis 0,0x2aaa
	srawi 28,31,31
	ori 0,0,43691
	mulhw 0,31,0
	subf 0,28,0
	mulli 0,0,6
	cmpw 0,31,0
	bc 4,2,.L112
	lis 29,gi@ha
	lis 3,.LC45@ha
	la 29,gi@l(29)
	la 3,.LC45@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC46@ha
	lwz 0,16(29)
	lis 10,.LC68@ha
	lfs 1,.LC46@l(9)
	mr 5,3
	la 10,.LC68@l(10)
	lis 9,.LC67@ha
	mr 3,30
	lfs 3,0(10)
	mtlr 0
	la 9,.LC67@l(9)
	li 4,0
	lfs 2,0(9)
	blrl
.L112:
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	cror 3,2,0
	bc 4,3,.L110
	lis 0,0x6666
	ori 0,0,26215
	mulhw 0,31,0
	srawi 0,0,2
	subf 0,28,0
	mulli 0,0,10
	cmpw 0,31,0
	bc 4,2,.L114
	lis 29,gi@ha
	lis 3,.LC47@ha
	la 29,gi@l(29)
	la 3,.LC47@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L114:
	andi. 0,31,4
	bc 4,2,.L110
	lwz 10,84(30)
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	addi 11,10,96
	lfs 10,0(9)
	lfs 0,12(11)
	lis 9,.LC48@ha
	lfs 13,.LC48@l(9)
	lfs 12,96(10)
	fsubs 11,10,0
	fmadds 11,11,13,0
	fdivs 0,0,11
	fsubs 10,10,0
	fmadds 12,12,0,10
	stfs 12,96(10)
	lfs 13,4(11)
	lfs 12,8(11)
	stfs 11,12(11)
	fmadds 13,13,0,10
	fmadds 12,12,0,10
	stfs 13,4(11)
	stfs 12,8(11)
.L110:
	lis 11,level@ha
	lwz 8,84(30)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC70@ha
	lfs 12,3800(8)
	xoris 0,0,0x8000
	la 11,.LC70@l(11)
	stw 0,36(1)
	stw 10,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L118
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 31,36(1)
	cmpwi 4,31,30
	bc 4,18,.L119
	lis 29,gi@ha
	lis 3,.LC49@ha
	la 29,gi@l(29)
	la 3,.LC49@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L119:
	bc 12,17,.L121
	andi. 0,31,4
	bc 12,2,.L124
.L121:
	lis 9,.LC67@ha
	lwz 11,84(30)
	lis 10,.LC68@ha
	la 9,.LC67@l(9)
	la 10,.LC68@l(10)
	lfs 9,0(9)
	lis 9,.LC48@ha
	lfs 10,0(10)
	lfs 13,.LC48@l(9)
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
	b .L193
.L118:
	lfs 13,3804(8)
	fcmpu 0,13,0
	bc 4,1,.L125
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 31,36(1)
	cmpwi 4,31,30
	bc 4,18,.L126
	lis 29,gi@ha
	lis 3,.LC50@ha
	la 29,gi@l(29)
	la 3,.LC50@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L126:
	bc 12,17,.L128
	andi. 0,31,4
	bc 12,2,.L124
.L128:
	lis 9,.LC67@ha
	lwz 11,84(30)
	lis 10,.LC68@ha
	la 9,.LC67@l(9)
	la 10,.LC68@l(10)
	lfs 10,0(9)
	lis 9,.LC48@ha
	lfs 12,96(11)
	lfs 13,.LC48@l(9)
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
	b .L193
.L125:
	lfs 13,3900(8)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L132
	bc 4,2,.L133
	lis 29,gi@ha
	lis 3,.LC51@ha
	la 29,gi@l(29)
	la 3,.LC51@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L124
.L133:
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 31,36(1)
	andi. 0,31,63
	cmpwi 4,31,30
	mfcr 9
	rlwinm 0,9,3,1
	rlwinm 9,9,18,1
	and. 10,0,9
	bc 12,2,.L135
	lis 29,gi@ha
	lis 3,.LC52@ha
	la 29,gi@l(29)
	la 3,.LC52@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L135:
	bc 12,17,.L137
	andi. 0,31,4
	bc 12,2,.L124
.L137:
	lwz 10,84(30)
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	addi 11,10,96
	lfs 10,0(9)
	lfs 0,12(11)
	lis 9,.LC48@ha
	lfs 13,.LC48@l(9)
	lfs 12,96(10)
	fsubs 11,10,0
	fmadds 11,11,13,0
	fdivs 0,0,11
	fsubs 10,10,0
	fmadds 12,12,0,10
	stfs 12,96(10)
	lfs 13,4(11)
	lfs 12,8(11)
	stfs 11,12(11)
	fmadds 13,13,0,10
	fmadds 12,12,0,10
	b .L194
.L132:
	lfs 13,3812(8)
	fcmpu 0,13,0
	bc 4,1,.L141
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 31,36(1)
	cmpwi 4,31,30
	bc 4,18,.L142
	lis 29,gi@ha
	lis 3,.LC53@ha
	la 29,gi@l(29)
	la 3,.LC53@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L142:
	bc 12,17,.L144
	andi. 0,31,4
	bc 12,2,.L124
.L144:
	lis 9,.LC67@ha
	lwz 11,84(30)
	lis 10,.LC68@ha
	la 9,.LC67@l(9)
	la 10,.LC68@l(10)
	lfs 10,0(9)
	lis 9,.LC48@ha
	lfs 9,0(10)
	lfs 13,.LC48@l(9)
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
	b .L193
.L141:
	lfs 13,3808(8)
	fcmpu 0,13,0
	bc 4,1,.L148
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 31,36(1)
	cmpwi 4,31,30
	bc 4,18,.L149
	lis 29,gi@ha
	lis 3,.LC53@ha
	la 29,gi@l(29)
	la 3,.LC53@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L149:
	bc 12,17,.L151
	andi. 0,31,4
	bc 12,2,.L124
.L151:
	lis 9,.LC67@ha
	lwz 10,84(30)
	lis 11,.LC43@ha
	la 9,.LC67@l(9)
	lfs 10,.LC43@l(11)
	lfs 9,0(9)
	lis 9,.LC54@ha
	lfs 12,96(10)
	lfs 13,.LC54@l(9)
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
.L193:
	stfs 13,4(9)
	stfs 12,8(9)
	b .L124
.L148:
	lfs 13,3896(8)
	fcmpu 0,13,0
	bc 4,1,.L124
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 31,36(1)
	cmpwi 0,31,30
	bc 12,1,.L157
	andi. 10,31,4
	bc 12,2,.L124
.L157:
	lis 9,.LC67@ha
	addi 11,8,96
	lfs 12,96(8)
	la 9,.LC67@l(9)
	lfs 0,12(11)
	lis 10,.LC43@ha
	lfs 10,0(9)
	lis 9,.LC54@ha
	lfs 9,.LC43@l(10)
	lfs 13,.LC54@l(9)
	fsubs 11,10,0
	fmadds 11,11,13,0
	fdivs 0,0,11
	fsubs 10,10,0
	fmadds 12,12,0,10
	fmuls 9,10,9
	stfs 12,96(8)
	lfs 13,4(11)
	lfs 12,8(11)
	stfs 11,12(11)
	fmadds 13,13,0,10
	fmadds 12,12,0,9
.L194:
	stfs 13,4(11)
	stfs 12,8(11)
.L124:
	lis 11,level@ha
	lwz 8,84(30)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC70@ha
	lfs 12,3924(8)
	xoris 0,0,0x8000
	la 11,.LC70@l(11)
	stw 0,36(1)
	stw 10,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L160
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 31,36(1)
	cmpwi 0,31,30
	bc 12,1,.L162
	andi. 0,31,4
	bc 12,2,.L161
.L162:
	lwz 0,116(8)
	lis 9,.LC67@ha
	lis 10,.LC68@ha
	la 9,.LC67@l(9)
	la 10,.LC68@l(10)
	ori 0,0,4
	lfs 11,0(9)
	stw 0,116(8)
	lis 9,.LC42@ha
	lwz 11,84(30)
	lfs 13,.LC42@l(9)
	addi 9,11,96
	lfs 12,96(11)
	lfs 0,12(9)
	lfs 9,0(10)
	fsubs 10,11,0
	fmadds 10,10,13,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmadds 12,12,0,11
	fmuls 11,11,9
	stfs 12,96(11)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,11
	stfs 13,4(9)
	stfs 12,8(9)
	b .L166
.L161:
.L160:
	lwz 0,116(8)
	rlwinm 0,0,0,30,28
	stw 0,116(8)
.L166:
	lis 11,level@ha
	lwz 10,84(30)
	lwz 0,level@l(11)
	lis 29,0x4330
	lis 11,.LC70@ha
	lfs 13,3904(10)
	xoris 0,0,0x8000
	la 11,.LC70@l(11)
	stw 0,36(1)
	stw 29,32(1)
	lfd 31,0(11)
	lfd 0,32(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L167
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 31,36(1)
	cmpwi 0,31,0
	bc 4,2,.L168
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC55@ha
	stw 3,36(1)
	lis 10,.LC72@ha
	stw 29,32(1)
	la 10,.LC72@l(10)
	lfd 0,32(1)
	lfs 12,.LC55@l(11)
	lfd 11,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L169
	lis 29,gi@ha
	lis 3,.LC56@ha
	la 29,gi@l(29)
	la 3,.LC56@l(3)
	b .L195
.L169:
	lis 29,gi@ha
	lis 3,.LC57@ha
	la 29,gi@l(29)
	la 3,.LC57@l(3)
	b .L195
.L168:
	lis 0,0x51eb
	srawi 9,31,31
	ori 0,0,34079
	mulhw 0,31,0
	srawi 0,0,4
	subf 0,9,0
	mulli 0,0,50
	subf. 31,0,31
	bc 4,2,.L167
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,384(30)
	xoris 3,3,0x8000
	lis 11,.LC55@ha
	lwz 0,552(30)
	stw 3,36(1)
	lis 10,.LC73@ha
	stw 29,32(1)
	la 10,.LC73@l(10)
	cmpwi 0,0,0
	lfd 0,32(1)
	lfs 30,.LC55@l(11)
	lfs 11,0(10)
	fsub 0,0,31
	lis 10,.LC74@ha
	la 10,.LC74@l(10)
	lfs 12,0(10)
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,11,12
	fadds 13,13,0
	stfs 13,384(30)
	bc 12,2,.L173
	lis 11,.LC67@ha
	lfs 0,12(30)
	la 11,.LC67@l(11)
	stw 31,552(30)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,12(30)
.L173:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC58@ha
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 13,.LC58@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L174
	lis 29,gi@ha
	lis 3,.LC59@ha
	la 29,gi@l(29)
	la 3,.LC59@l(3)
	b .L195
.L174:
	lis 9,.LC60@ha
	lfd 0,.LC60@l(9)
	fcmpu 0,12,0
	bc 4,0,.L176
	lis 29,gi@ha
	lis 3,.LC61@ha
	la 29,gi@l(29)
	la 3,.LC61@l(3)
.L195:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L167
.L176:
	lis 29,gi@ha
	lis 3,.LC62@ha
	la 29,gi@l(29)
	la 3,.LC62@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC67@ha
	lis 10,.LC67@ha
	lis 11,.LC68@ha
	mr 5,3
	la 9,.LC67@l(9)
	la 10,.LC67@l(10)
	mtlr 0
	la 11,.LC68@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L167:
	lwz 9,84(30)
	lis 10,.LC68@ha
	la 10,.LC68@l(10)
	lfs 0,0(10)
	lfs 8,3708(9)
	fcmpu 0,8,0
	bc 4,1,.L178
	lfs 12,3716(9)
	addi 11,9,96
	lfs 7,3720(9)
	lfs 9,3724(9)
	cror 3,2,0
	bc 12,3,.L178
	lis 10,.LC67@ha
	lfs 13,12(11)
	la 10,.LC67@l(10)
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
.L178:
	lwz 8,84(30)
	lis 11,.LC68@ha
	la 11,.LC68@l(11)
	lfs 0,0(11)
	lfs 12,3712(8)
	fcmpu 0,12,0
	bc 4,1,.L181
	lis 9,.LC63@ha
	lis 10,.LC64@ha
	lfs 7,.LC63@l(9)
	lis 11,.LC38@ha
	addi 9,8,96
	lfs 8,.LC64@l(10)
	lfs 9,.LC38@l(11)
	cror 3,2,0
	bc 12,3,.L181
	lis 10,.LC67@ha
	lfs 13,12(9)
	la 10,.LC67@l(10)
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
.L181:
	lwz 11,84(30)
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfs 0,0(9)
	lfs 13,4008(11)
	fcmpu 0,13,0
	bc 4,1,.L184
	addi 9,11,96
	cror 3,2,0
	bc 12,3,.L184
	lis 10,.LC67@ha
	lfs 0,12(9)
	la 10,.LC67@l(10)
	lfs 12,96(11)
	lfs 11,0(10)
	fsubs 10,11,0
	fmadds 10,10,13,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmadds 12,12,0,11
	stfs 12,96(11)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,11
	stfs 13,4(9)
	stfs 12,8(9)
.L184:
	lwz 11,84(30)
	lis 9,.LC65@ha
	lis 10,.LC68@ha
	lfd 13,.LC65@l(9)
	la 10,.LC68@l(10)
	lfs 0,3708(11)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3708(11)
	lwz 9,84(30)
	lfs 0,3708(9)
	fcmpu 0,0,12
	bc 4,0,.L187
	stfs 12,3708(9)
.L187:
	lwz 11,84(30)
	lis 9,.LC66@ha
	lfd 13,.LC66@l(9)
	lfs 0,3712(11)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3712(11)
	lwz 9,84(30)
	lfs 0,3712(9)
	fcmpu 0,0,12
	bc 4,0,.L188
	stfs 12,3712(9)
.L188:
	lwz 9,84(30)
	lfs 0,4008(9)
	lfs 13,4012(9)
	fsubs 0,0,13
	stfs 0,4008(9)
	lwz 9,84(30)
	lfs 0,4008(9)
	fcmpu 0,0,12
	bc 4,0,.L189
	stfs 12,4008(9)
	lwz 9,84(30)
	stfs 12,4012(9)
.L189:
	lwz 0,84(1)
	lwz 12,44(1)
	mtlr 0
	lmw 28,48(1)
	lfd 30,64(1)
	lfd 31,72(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe4:
	.size	 SV_CalcBlend,.Lfe4-SV_CalcBlend
	.section	".rodata"
	.align 3
.LC75:
	.long 0x3f1a36e2
	.long 0xeb1c432d
	.align 3
.LC76:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC77:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC78:
	.long 0x0
	.align 3
.LC79:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC80:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC81:
	.long 0x3f800000
	.align 2
.LC82:
	.long 0x41700000
	.align 2
.LC83:
	.long 0x42200000
	.align 2
.LC84:
	.long 0x41f00000
	.align 2
.LC85:
	.long 0x425c0000
	.align 2
.LC86:
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
	bc 4,2,.L196
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 12,2,.L196
	lwz 9,84(3)
	lis 11,.LC78@ha
	la 11,.LC78@l(11)
	lfs 0,0(11)
	mr 10,9
	lfs 13,3764(9)
	fcmpu 0,13,0
	bc 4,0,.L199
	lfs 0,384(3)
	fcmpu 0,0,13
	bc 4,1,.L199
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 4,2,.L218
	fmr 9,13
	b .L200
.L199:
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 12,2,.L196
.L218:
	lfs 13,384(3)
	lfs 0,3764(10)
	fsubs 9,13,0
.L200:
	lis 11,level@ha
	lfs 10,3980(10)
	fmuls 13,9,9
	lis 9,.LC76@ha
	la 8,level@l(11)
	lfd 11,.LC76@l(9)
	lfs 0,4(8)
	lis 11,.LC75@ha
	lfd 12,.LC75@l(11)
	fsubs 0,0,10
	fmul 13,13,12
	frsp 9,13
	fcmpu 0,0,11
	cror 3,2,0
	bc 12,3,.L196
	lwz 0,3972(10)
	cmpwi 0,0,0
	bc 12,2,.L202
	lwz 0,3976(10)
	cmpwi 0,0,0
	bc 12,1,.L196
.L202:
	lwz 0,612(3)
	cmpwi 0,0,3
	bc 12,2,.L196
	cmpwi 0,0,2
	bc 4,2,.L205
	lis 9,.LC79@ha
	fmr 0,9
	la 9,.LC79@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 9,0
.L205:
	cmpwi 0,0,1
	bc 4,2,.L206
	lis 11,.LC80@ha
	fmr 0,9
	la 11,.LC80@l(11)
	lfd 13,0(11)
	fmul 0,0,13
	frsp 9,0
.L206:
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 0,0(9)
	fcmpu 0,9,0
	bc 12,0,.L196
	lis 11,.LC82@ha
	la 11,.LC82@l(11)
	lfs 0,0(11)
	fcmpu 0,9,0
	bc 4,0,.L208
	li 0,2
	b .L219
.L208:
	lis 9,.LC80@ha
	fmr 0,9
	lis 11,.LC83@ha
	la 9,.LC80@l(9)
	la 11,.LC83@l(11)
	lfd 13,0(9)
	lfs 12,0(11)
	fmul 0,0,13
	frsp 0,0
	stfs 0,3704(10)
	lwz 9,84(3)
	lfs 0,3704(9)
	fcmpu 0,0,12
	bc 4,1,.L209
	stfs 12,3704(9)
.L209:
	lfs 0,4(8)
	lis 9,.LC77@ha
	lis 11,.LC84@ha
	lfd 12,.LC77@l(9)
	la 11,.LC84@l(11)
	lfs 13,0(11)
	lwz 9,84(3)
	fcmpu 0,9,13
	fadd 0,0,12
	frsp 0,0
	stfs 0,3700(9)
	bc 4,1,.L210
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L211
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfs 0,0(9)
	fcmpu 0,9,0
	li 0,4
	cror 3,2,1
	bc 4,3,.L212
	li 0,5
.L212:
	stw 0,80(3)
.L211:
	lis 11,.LC84@ha
	lis 9,.LC86@ha
	la 11,.LC84@l(11)
	la 9,.LC86@l(9)
	lfs 0,0(11)
	lis 0,0x3f80
	lfs 10,0(9)
	lis 11,deathmatch@ha
	lis 9,level+4@ha
	fsubs 0,9,0
	lfs 13,level+4@l(9)
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
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
	bc 12,2,.L216
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 11,44(1)
	andi. 0,11,8
	bc 4,2,.L196
.L216:
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
	b .L196
.L210:
	li 0,3
.L219:
	stw 0,80(3)
.L196:
	lwz 0,52(1)
	mtlr 0
	la 1,48(1)
	blr
.Lfe5:
	.size	 P_FallingDamage,.Lfe5-P_FallingDamage
	.section	".rodata"
	.align 2
.LC87:
	.string	"player/lava_in.wav"
	.align 2
.LC88:
	.string	"player/watr_in.wav"
	.align 2
.LC89:
	.string	"player/watr_out.wav"
	.align 2
.LC90:
	.string	"player/watr_un.wav"
	.align 2
.LC91:
	.string	"player/gasp1.wav"
	.align 2
.LC92:
	.string	"player/gasp2.wav"
	.align 2
.LC93:
	.string	"player/u_breath1.wav"
	.align 2
.LC94:
	.string	"player/u_breath2.wav"
	.align 2
.LC95:
	.string	"*drown1.wav"
	.align 2
.LC96:
	.string	"*gurp1.wav"
	.align 2
.LC97:
	.string	"*gurp2.wav"
	.align 2
.LC98:
	.long 0x41400000
	.align 3
.LC99:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC100:
	.long 0x3f800000
	.align 2
.LC101:
	.long 0x0
	.align 2
.LC102:
	.long 0x41300000
	.align 2
.LC103:
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
	bc 4,2,.L222
	lis 7,.LC98@ha
	lis 9,level+4@ha
	la 7,.LC98@l(7)
	lfs 0,level+4@l(9)
	lfs 13,0(7)
	fadds 0,0,13
	stfs 0,404(3)
	b .L221
.L222:
	lis 9,current_client@ha
	lwz 30,612(3)
	lis 7,level@ha
	lwz 11,current_client@l(9)
	lis 6,0x4330
	addic 0,30,-1
	subfe 8,0,30
	lis 9,.LC99@ha
	lwz 31,3772(11)
	la 9,.LC99@l(9)
	stw 30,3772(11)
	lwz 0,level@l(7)
	lfd 13,0(9)
	xoris 0,0,0x8000
	lfs 11,3812(11)
	subfic 7,31,0
	adde 9,7,31
	stw 0,36(1)
	and. 7,9,8
	stw 6,32(1)
	lfd 0,32(1)
	lfs 12,3808(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,11,0
	fcmpu 6,12,0
	mfcr 24
	rlwinm 25,24,30,1
	rlwinm 24,24,26,1
	bc 12,2,.L223
	li 5,0
	addi 4,3,4
	bl PlayerNoise
	lwz 28,current_player@l(26)
	lwz 0,608(28)
	andi. 7,0,8
	bc 12,2,.L224
	lis 29,gi@ha
	lis 3,.LC87@ha
	la 29,gi@l(29)
	la 3,.LC87@l(3)
	b .L258
.L224:
	andi. 7,0,16
	bc 12,2,.L226
	lis 29,gi@ha
	lis 3,.LC88@ha
	la 29,gi@l(29)
	la 3,.LC88@l(3)
.L258:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L225
.L226:
	andi. 7,0,32
	bc 12,2,.L225
	lis 29,gi@ha
	lis 3,.LC88@ha
	la 29,gi@l(29)
	la 3,.LC88@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L225:
	lis 11,current_player@ha
	lis 7,.LC100@ha
	lwz 9,current_player@l(11)
	lis 10,level+4@ha
	la 7,.LC100@l(7)
	lfs 13,0(7)
	lwz 0,264(9)
	ori 0,0,8
	stw 0,264(9)
	lfs 0,level+4@l(10)
	fsubs 0,0,13
	stfs 0,468(9)
.L223:
	cmpwi 0,30,0
	addic 10,31,-1
	subfe 9,10,31
	mcrf 4,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 11,9,0
	bc 12,2,.L229
	lis 28,current_player@ha
	li 5,0
	lwz 3,current_player@l(28)
	addi 4,3,4
	bl PlayerNoise
	lis 29,gi@ha
	lis 3,.LC89@ha
	lwz 27,current_player@l(28)
	la 29,gi@l(29)
	la 3,.LC89@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	la 9,.LC100@l(9)
	mr 5,3
	la 7,.LC100@l(7)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,27
	lfs 3,0(10)
	blrl
	lwz 9,current_player@l(28)
	lwz 0,264(9)
	rlwinm 0,0,0,29,27
	stw 0,264(9)
.L229:
	cmpwi 0,30,3
	xori 0,31,3
	addic 7,0,-1
	subfe 9,7,0
	mfcr 27
	mfcr 0
	rlwinm 0,0,3,1
	and. 10,9,0
	bc 12,2,.L230
	lis 29,gi@ha
	lis 3,.LC90@ha
	la 29,gi@l(29)
	la 3,.LC90@l(3)
	lwz 11,36(29)
	lis 9,current_player@ha
	lwz 28,current_player@l(9)
	mtlr 11
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L230:
	xori 0,30,3
	xori 11,31,3
	subfic 7,11,0
	adde 11,7,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L231
	lis 9,current_player@ha
	lis 11,level+4@ha
	lwz 28,current_player@l(9)
	lfs 12,level+4@l(11)
	lfs 13,404(28)
	fcmpu 0,13,12
	bc 4,0,.L232
	lis 29,gi@ha
	lis 3,.LC91@ha
	la 29,gi@l(29)
	la 3,.LC91@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
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
	b .L231
.L232:
	lis 7,.LC102@ha
	la 7,.LC102@l(7)
	lfs 0,0(7)
	fadds 0,12,0
	fcmpu 0,13,0
	bc 4,0,.L231
	lis 29,gi@ha
	lis 3,.LC92@ha
	la 29,gi@l(29)
	la 3,.LC92@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L231:
	mtcrf 128,27
	bc 4,2,.L235
	lis 9,current_player@ha
	lwz 3,current_player@l(9)
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L236
	lwz 3,current_player@l(26)
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	lwz 4,g_edicts@l(9)
	la 6,vec3_origin@l(6)
	li 11,2
	lwz 9,480(3)
	li 0,0
	addi 7,3,4
	stw 11,8(1)
	mr 5,4
	mr 8,6
	stw 0,12(1)
	addi 9,9,1
	li 10,0
	bl T_Damage
.L236:
	or. 0,24,25
	bc 12,2,.L237
	lis 9,.LC103@ha
	lis 7,level@ha
	lwz 28,current_player@l(26)
	la 9,.LC103@l(9)
	lis 11,current_client@ha
	lfs 13,0(9)
	lis 6,0x4330
	la 9,level@l(7)
	lwz 11,current_client@l(11)
	lis 10,.LC99@ha
	lfs 0,4(9)
	la 10,.LC99@l(10)
	lfd 11,0(10)
	lis 9,0x51eb
	mr 10,8
	ori 9,9,34079
	fadds 0,0,13
	stfs 0,404(28)
	lwz 0,level@l(7)
	lfs 13,3808(11)
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 6,32(1)
	lfd 0,32(1)
	fsub 0,0,11
	frsp 0,0
	fsubs 13,13,0
	fctiwz 12,13
	stfd 12,32(1)
	lwz 10,36(1)
	mulhw 9,10,9
	srawi 0,10,31
	srawi 9,9,3
	subf 9,0,9
	mulli 9,9,25
	cmpw 0,10,9
	bc 4,2,.L237
	lwz 0,3776(11)
	cmpwi 0,0,0
	bc 4,2,.L239
	lis 29,gi@ha
	lis 3,.LC93@ha
	la 29,gi@l(29)
	la 3,.LC93@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L240
.L239:
	lis 29,gi@ha
	lis 3,.LC94@ha
	la 29,gi@l(29)
	la 3,.LC94@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L240:
	lis 9,current_client@ha
	lis 11,current_player@ha
	lwz 10,current_client@l(9)
	li 5,0
	lwz 3,current_player@l(11)
	lwz 0,3776(10)
	addi 4,3,4
	xori 0,0,1
	stw 0,3776(10)
	bl PlayerNoise
.L237:
	lis 9,current_player@ha
	lis 11,level+4@ha
	lwz 10,current_player@l(9)
	lfs 13,level+4@l(11)
	lfs 0,404(10)
	fcmpu 0,0,13
	bc 4,0,.L248
	lwz 9,84(10)
	lfs 0,3768(9)
	fcmpu 0,0,13
	bc 4,0,.L248
	lwz 0,480(10)
	cmpwi 0,0,0
	bc 4,1,.L248
	lis 7,.LC100@ha
	la 7,.LC100@l(7)
	lfs 0,0(7)
	fadds 0,13,0
	stfs 0,3768(9)
	lwz 9,516(10)
	addi 9,9,2
	cmpwi 0,9,15
	stw 9,516(10)
	bc 4,1,.L243
	li 0,15
	stw 0,516(10)
.L243:
	lwz 28,current_player@l(26)
	lwz 9,480(28)
	lwz 0,516(28)
	cmpw 0,9,0
	bc 12,1,.L244
	lis 29,gi@ha
	lis 3,.LC95@ha
	la 29,gi@l(29)
	la 3,.LC95@l(3)
	b .L259
.L244:
	bl rand
	andi. 0,3,1
	bc 12,2,.L246
	lis 29,gi@ha
	lis 3,.LC96@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC96@l(3)
.L259:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L245
.L246:
	lis 29,gi@ha
	lis 3,.LC97@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC97@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L245:
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
	b .L248
.L235:
	lis 7,.LC98@ha
	lis 9,level+4@ha
	la 7,.LC98@l(7)
	lfs 0,level+4@l(9)
	lis 11,current_player@ha
	lfs 13,0(7)
	li 0,2
	lwz 9,current_player@l(11)
	fadds 0,0,13
	stw 0,516(9)
	stfs 0,404(9)
.L248:
	bc 12,18,.L221
	lis 9,current_player@ha
	lwz 11,current_player@l(9)
	lwz 0,608(11)
	andi. 9,0,24
	bc 12,2,.L221
	andi. 10,0,8
	bc 12,2,.L250
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L251
	lis 9,level+4@ha
	lfs 13,464(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L251
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 7,.LC99@ha
	la 7,.LC99@l(7)
	lis 9,current_client@ha
	xoris 0,0,0x8000
	lfd 12,0(7)
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	lwz 10,current_client@l(9)
	fsub 0,0,12
	lfs 13,3804(10)
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L251
	bl rand
	andi. 0,3,1
	bc 12,2,.L252
	lis 29,gi@ha
	lis 3,.LC1@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L253
.L252:
	lis 29,gi@ha
	lis 3,.LC2@ha
	lwz 28,current_player@l(26)
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC100@ha
	lis 9,.LC100@ha
	lis 10,.LC101@ha
	mr 5,3
	la 7,.LC100@l(7)
	la 9,.LC100@l(9)
	mtlr 0
	la 10,.LC101@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L253:
	lis 7,.LC100@ha
	lis 11,level+4@ha
	la 7,.LC100@l(7)
	lfs 0,level+4@l(11)
	lis 9,current_player@ha
	lfs 13,0(7)
	lwz 11,current_player@l(9)
	fadds 0,0,13
	stfs 0,464(11)
.L251:
	cmpwi 0,25,0
	bc 12,2,.L254
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
	b .L250
.L254:
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
.L250:
	lis 9,current_player@ha
	lwz 3,current_player@l(9)
	lwz 0,608(3)
	andi. 7,0,16
	bc 12,2,.L221
	cmpwi 0,25,0
	bc 4,2,.L221
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
.L221:
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
.LC104:
	.long 0x0
	.align 3
.LC105:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl G_SetClientEffects
	.type	 G_SetClientEffects,@function
G_SetClientEffects:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	li 0,0
	lwz 11,480(31)
	li 9,0
	ori 0,0,32768
	stw 9,64(31)
	cmpwi 0,11,0
	stw 0,68(31)
	bc 4,1,.L260
	lis 9,level@ha
	lis 7,.LC104@ha
	la 7,.LC104@l(7)
	la 30,level@l(9)
	lfs 13,0(7)
	lfs 0,200(30)
	fcmpu 0,0,13
	bc 4,2,.L260
	bl CTFEffects
	mr 3,31
	bl nightmareEffects
	lfs 13,4(30)
	lfs 0,500(31)
	fcmpu 0,0,13
	bc 4,1,.L263
	mr 3,31
	bl PowerArmorType
	cmpwi 0,3,1
	bc 4,2,.L264
	lwz 0,64(31)
	ori 0,0,512
	stw 0,64(31)
	b .L263
.L264:
	cmpwi 0,3,2
	bc 4,2,.L263
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(31)
	stw 9,68(31)
.L263:
	lwz 0,264(31)
	andi. 7,0,16384
	bc 12,2,.L267
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,7168
	stw 0,64(31)
	stw 9,68(31)
.L267:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC105@ha
	lfs 12,3900(10)
	xoris 0,0,0x8000
	la 11,.LC105@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L268
	lwz 9,56(31)
	lwz 11,64(31)
	addi 0,9,-135
	subfic 9,9,39
	li 9,0
	adde 9,9,9
	subfic 0,0,18
	li 0,0
	adde 0,0,0
	or. 7,0,9
	oris 11,11,0x1000
	stw 11,64(31)
	bc 12,2,.L269
	lwz 0,184(31)
	ori 0,0,1
	b .L281
.L269:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L272
.L268:
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
.L281:
	stw 0,184(31)
.L272:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 11,level@l(11)
	lis 8,0x4330
	lis 7,.LC105@ha
	la 7,.LC105@l(7)
	lfs 12,3800(10)
	xoris 0,11,0x8000
	lfd 13,0(7)
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L273
	andi. 9,11,8
	bc 12,2,.L273
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,30
	bc 12,1,.L275
	andi. 10,0,4
	bc 12,2,.L273
.L275:
	lwz 0,64(31)
	ori 0,0,32768
	stw 0,64(31)
.L273:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 11,level@l(11)
	lis 8,0x4330
	lis 7,.LC105@ha
	la 7,.LC105@l(7)
	lfs 12,3804(10)
	xoris 0,11,0x8000
	lfd 13,0(7)
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L276
	andi. 9,11,8
	bc 12,2,.L276
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,30
	bc 12,1,.L278
	andi. 10,0,4
	bc 12,2,.L276
.L278:
	lwz 0,64(31)
	oris 0,0,0x1
	stw 0,64(31)
.L276:
	lwz 0,264(31)
	andi. 11,0,16
	bc 12,2,.L279
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,7168
	stw 0,64(31)
	stw 9,68(31)
.L279:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 7,.LC105@ha
	la 7,.LC105@l(7)
	lfs 12,3928(10)
	xoris 0,0,0x8000
	lfd 13,0(7)
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L260
	lwz 0,64(31)
	oris 0,0,0x8000
	stw 0,64(31)
.L260:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 G_SetClientEffects,.Lfe7-G_SetClientEffects
	.section	".rodata"
	.align 2
.LC106:
	.string	"misc/pc_up.wav"
	.align 2
.LC107:
	.string	""
	.align 2
.LC108:
	.string	"weapon_railgun"
	.align 2
.LC109:
	.string	"weapons/rg_hum.wav"
	.align 2
.LC110:
	.string	"weapon_bfg"
	.align 2
.LC111:
	.string	"weapons/bfg_hum.wav"
	.align 2
.LC112:
	.long 0x3f800000
	.align 2
.LC113:
	.long 0x40400000
	.align 2
.LC114:
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
	lwz 0,1804(11)
	cmpw 0,0,9
	bc 12,2,.L288
	stw 9,1804(11)
	li 0,1
	lwz 9,84(31)
	stw 0,1808(9)
.L288:
	lwz 10,84(31)
	lwz 11,1808(10)
	cmpwi 7,11,3
	addic 0,11,-1
	subfe 9,0,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 8,9,0
	bc 12,2,.L289
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,63
	bc 4,2,.L289
	addi 0,11,1
	lis 29,gi@ha
	stw 0,1808(10)
	la 29,gi@l(29)
	lis 3,.LC106@ha
	lwz 9,36(29)
	la 3,.LC106@l(3)
	mtlr 9
	blrl
	lis 8,.LC112@ha
	lwz 0,16(29)
	lis 9,.LC113@ha
	la 8,.LC112@l(8)
	mr 5,3
	lfs 1,0(8)
	la 9,.LC113@l(9)
	li 4,2
	mtlr 0
	lis 8,.LC114@ha
	mr 3,31
	lfs 2,0(9)
	la 8,.LC114@l(8)
	lfs 3,0(8)
	blrl
.L289:
	lwz 9,84(31)
	lwz 3,1788(9)
	cmpwi 0,3,0
	bc 12,2,.L290
	lwz 29,0(3)
	b .L291
.L290:
	lis 9,.LC107@ha
	la 29,.LC107@l(9)
.L291:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L292
	lwz 0,608(31)
	andi. 8,0,24
	bc 12,2,.L292
	lis 9,snd_fry@ha
	lwz 0,snd_fry@l(9)
	b .L298
.L292:
	lis 4,.LC108@ha
	mr 3,29
	la 4,.LC108@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L294
	lis 9,gi+36@ha
	lis 3,.LC109@ha
	lwz 0,gi+36@l(9)
	la 3,.LC109@l(3)
	b .L300
.L294:
	lis 4,.LC110@ha
	mr 3,29
	la 4,.LC110@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L296
	lis 9,gi+36@ha
	lis 3,.LC111@ha
	lwz 0,gi+36@l(9)
	la 3,.LC111@l(3)
.L300:
	mtlr 0
	blrl
	stw 3,76(31)
	b .L293
.L296:
	lwz 9,84(31)
	lwz 0,3828(9)
	cmpwi 0,0,0
.L298:
	stw 0,76(31)
.L293:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 G_SetClientSound,.Lfe8-G_SetClientSound
	.section	".rodata"
	.align 2
.LC115:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetClientFrame
	.type	 G_SetClientFrame,@function
G_SetClientFrame:
	lwz 0,40(3)
	cmpwi 0,0,255
	bclr 4,2
	lwz 0,264(3)
	andi. 9,0,16384
	bclr 4,2
	lis 10,.LC115@ha
	lis 9,xyspeed@ha
	lwz 11,84(3)
	la 10,.LC115@l(10)
	lfs 0,xyspeed@l(9)
	lfs 13,0(10)
	mr 5,11
	lbz 9,16(11)
	lwz 0,3792(11)
	fcmpu 7,0,13
	rlwinm 9,9,0,31,31
	cmpw 0,9,0
	crnor 31,30,30
	mfcr 7
	rlwinm 7,7,0,1
	bc 12,2,.L308
	lwz 0,3788(11)
	cmpwi 0,0,4
	bc 4,1,.L309
.L308:
	lwz 0,3796(11)
	lwz 8,3788(11)
	cmpw 0,7,0
	bc 12,2,.L310
	cmpwi 0,8,0
	bc 12,2,.L309
.L310:
	lwz 0,552(3)
	cmpwi 0,0,0
	mr 6,0
	bc 4,2,.L311
	cmpwi 0,8,1
	bc 4,1,.L309
.L311:
	cmpwi 0,8,6
	bc 4,2,.L312
	lwz 10,56(3)
	lwz 0,3784(11)
	cmpw 0,10,0
	bc 4,1,.L314
	addi 0,10,-1
	stw 0,56(3)
	blr
.L312:
	lwz 10,56(3)
	lwz 0,3784(11)
	cmpw 0,10,0
	bc 4,0,.L314
	addi 0,10,1
	stw 0,56(3)
	blr
.L314:
	cmpwi 0,8,5
	bclr 12,2
	cmpwi 0,8,2
	bc 4,2,.L309
	cmpwi 0,6,0
	bclr 12,2
	li 0,1
	li 10,68
	stw 0,3788(5)
	li 11,71
	lwz 9,84(3)
	stw 10,56(3)
	stw 11,3784(9)
	blr
.L309:
	li 0,0
	stw 9,3792(11)
	stw 0,3788(11)
	stw 7,3796(11)
	lwz 10,552(3)
	cmpwi 0,10,0
	bc 4,2,.L319
	lwz 0,3972(11)
	cmpwi 0,0,0
	bc 12,2,.L320
	stw 10,56(3)
.L331:
	li 0,39
	stw 0,3784(11)
	blr
.L320:
	li 0,2
	stw 0,3788(11)
	lwz 9,56(3)
	cmpwi 0,9,67
	bc 12,2,.L322
	li 0,66
	stw 0,56(3)
.L322:
	li 0,67
	stw 0,3784(11)
	blr
.L319:
	cmpwi 0,7,0
	bc 12,2,.L324
	cmpwi 0,9,0
	bc 12,2,.L325
	li 0,154
	li 9,159
.L330:
	stw 0,56(3)
	stw 9,3784(11)
	blr
.L325:
	li 0,40
	li 9,45
	b .L330
.L324:
	cmpwi 0,9,0
	bc 12,2,.L328
	li 0,135
	li 9,153
	b .L330
.L328:
	stw 9,56(3)
	b .L331
.Lfe9:
	.size	 G_SetClientFrame,.Lfe9-G_SetClientFrame
	.section	".rodata"
	.align 3
.LC116:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC117:
	.long 0x40200000
	.long 0x0
	.align 2
.LC118:
	.long 0x0
	.align 2
.LC119:
	.long 0x43340000
	.align 2
.LC120:
	.long 0xc3b40000
	.align 2
.LC121:
	.long 0x40400000
	.align 2
.LC122:
	.long 0x40800000
	.align 2
.LC123:
	.long 0x40a00000
	.align 2
.LC124:
	.long 0x43520000
	.align 2
.LC125:
	.long 0x42c80000
	.align 2
.LC126:
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
	lis 9,.LC117@ha
	addi 10,11,10
	la 9,.LC117@l(9)
	li 11,3
	lfd 11,0(9)
	mtctr 11
.L372:
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
	bdnz .L372
	lis 11,.LC118@ha
	lis 9,level+200@ha
	la 11,.LC118@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L338
	lis 9,current_client@ha
	lis 0,0x42b4
	lwz 11,current_client@l(9)
	mr 3,31
	stw 0,112(11)
	stfs 13,108(11)
	bl G_SetStats
	b .L332
.L338:
	lwz 3,84(31)
	lis 4,forward@ha
	lis 5,right@ha
	lis 6,up@ha
	la 5,right@l(5)
	la 6,up@l(6)
	addi 3,3,3728
	la 4,forward@l(4)
	bl AngleVectors
	bl P_WorldEffects
	lis 9,current_client@ha
	lwz 9,current_client@l(9)
	lwz 0,3964(9)
	cmpwi 0,0,0
	bc 12,2,.L339
	lwz 3,3968(9)
	bl turret_client_check
.L339:
	lwz 9,84(31)
	lis 11,.LC119@ha
	la 11,.LC119@l(11)
	lfs 0,0(11)
	lfs 12,3728(9)
	fcmpu 0,12,0
	bc 4,1,.L340
	lis 9,.LC120@ha
	lis 11,.LC121@ha
	la 9,.LC120@l(9)
	la 11,.LC121@l(11)
	lfs 0,0(9)
	lfs 13,0(11)
	fadds 0,12,0
	fdivs 0,0,13
	b .L373
.L340:
	lis 9,.LC121@ha
	la 9,.LC121@l(9)
	lfs 0,0(9)
	fdivs 0,12,0
.L373:
	stfs 0,16(31)
	lwz 9,84(31)
	lis 11,.LC118@ha
	lis 0,0x3f80
	la 11,.LC118@l(11)
	lfs 12,376(31)
	lfs 9,0(11)
	lfs 13,3732(9)
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
	bc 4,0,.L342
	lis 0,0xbf80
.L342:
	lis 8,sv_rollspeed@ha
	fabs 13,13
	lis 9,sv_rollangle@ha
	lwz 11,sv_rollspeed@l(8)
	lwz 10,sv_rollangle@l(9)
	lfs 12,20(11)
	lfs 0,20(10)
	fcmpu 0,13,12
	bc 4,0,.L344
	fmuls 0,13,0
	fdivs 13,0,12
	b .L345
.L344:
	fmr 13,0
.L345:
	lfs 0,380(31)
	lis 9,.LC122@ha
	lis 29,xyspeed@ha
	stw 0,8(1)
	la 9,.LC122@l(9)
	lfs 12,8(1)
	fmuls 0,0,0
	lfs 1,376(31)
	fmuls 13,13,12
	lfs 12,0(9)
	fmadds 1,1,1,0
	fmuls 13,13,12
	stfs 13,24(31)
	bl sqrt
	lis 9,.LC123@ha
	frsp 1,1
	la 9,.LC123@l(9)
	lfs 0,0(9)
	stfs 1,xyspeed@l(29)
	fcmpu 0,1,0
	bc 4,0,.L347
	lis 11,current_client@ha
	li 0,0
	lwz 10,current_client@l(11)
	lis 9,bobmove@ha
	stw 0,bobmove@l(9)
	stw 0,3740(10)
	b .L348
.L347:
	lwz 0,552(31)
	lis 9,bobmove@ha
	cmpwi 0,0,0
	bc 12,2,.L348
	lis 11,.LC124@ha
	la 11,.LC124@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L350
	lis 0,0x3e80
	b .L374
.L350:
	lis 11,.LC125@ha
	la 11,.LC125@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L352
	lis 0,0x3e00
	b .L374
.L352:
	lis 0,0x3d80
.L374:
	stw 0,bobmove@l(9)
.L348:
	lis 11,current_client@ha
	lis 10,bobmove@ha
	lwz 9,current_client@l(11)
	lfs 13,bobmove@l(10)
	lfs 0,3740(9)
	lbz 0,16(9)
	fadds 0,0,13
	andi. 11,0,1
	fmr 13,0
	stfs 0,3740(9)
	bc 12,2,.L354
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	lfs 0,0(9)
	fmuls 13,13,0
.L354:
	lis 11,.LC116@ha
	lfd 1,.LC116@l(11)
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
	lwz 0,3496(9)
	cmpwi 0,0,0
	bc 4,2,.L356
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L355
.L356:
	mr 3,31
	bl G_SetSpectatorStats
	b .L357
.L355:
	mr 3,31
	bl G_SetStats
.L357:
	mr 3,31
	bl G_CheckChaseStats
	lwz 0,80(31)
	cmpwi 0,0,0
	bc 4,2,.L359
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L359
	lis 11,.LC126@ha
	lis 9,xyspeed@ha
	la 11,.LC126@l(11)
	lfs 0,xyspeed@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L359
	lis 11,current_client@ha
	lis 8,bobmove@ha
	lwz 10,current_client@l(11)
	lfs 12,bobmove@l(8)
	lis 11,bobcycle@ha
	lfs 0,3740(10)
	lwz 0,bobcycle@l(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,40(1)
	lwz 9,44(1)
	cmpw 0,9,0
	bc 12,2,.L359
	lis 9,.LC118@ha
	lis 11,footsteps@ha
	la 9,.LC118@l(9)
	lfs 13,0(9)
	lwz 9,footsteps@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L359
	lwz 0,264(31)
	andi. 11,0,16384
	bc 4,2,.L359
	li 0,2
	stw 0,80(31)
.L359:
	mr 3,31
	bl G_SetClientEffects
	mr 3,31
	bl G_SetClientSound
	mr 3,31
	bl G_SetClientFrame
	lis 9,.LC118@ha
	lfs 0,376(31)
	la 9,.LC118@l(9)
	lfs 13,0(9)
	lwz 9,84(31)
	stfs 0,3756(9)
	lfs 0,380(31)
	lwz 11,84(31)
	stfs 0,3760(11)
	lfs 0,384(31)
	lwz 10,84(31)
	stfs 0,3764(10)
	lwz 9,84(31)
	lfs 0,28(9)
	stfs 0,3744(9)
	lwz 11,84(31)
	lfs 0,32(11)
	stfs 0,3748(11)
	lwz 10,84(31)
	lfs 0,36(10)
	stfs 0,3752(10)
	lwz 9,84(31)
	stfs 13,3676(9)
	stfs 13,3684(9)
	stfs 13,3680(9)
	lwz 11,84(31)
	stfs 13,3664(11)
	stfs 13,3672(11)
	stfs 13,3668(11)
	lwz 9,84(31)
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 4,2,.L366
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 12,2,.L365
.L366:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L365
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 11,0,1
	bc 12,2,.L364
.L365:
	lwz 9,84(31)
	lwz 0,1820(9)
	andi. 9,0,2
	bc 12,2,.L363
.L364:
	lwz 9,84(31)
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 12,2,.L367
	mr 3,31
	bl PMenu_Update
	b .L368
.L367:
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
.L368:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,0
	mtlr 0
	blrl
	lwz 9,84(31)
	lwz 0,1820(9)
	rlwinm 0,0,0,31,29
	stw 0,1820(9)
.L363:
	lwz 9,84(31)
	lwz 11,1820(9)
	cmpwi 0,11,0
	bc 12,2,.L369
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,1
	bc 4,2,.L369
	andi. 0,11,2
	bc 4,2,.L369
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,0
	mtlr 0
	blrl
	lwz 9,84(31)
	lwz 0,1820(9)
	rlwinm 0,0,0,31,29
	stw 0,1820(9)
.L369:
	lwz 9,84(31)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 4,2,.L371
	lwz 0,3908(9)
	cmpwi 0,0,0
	bc 12,2,.L332
.L371:
	mr 3,31
	bl CheckChasecam_Viewent
.L332:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 ClientEndServerFrame,.Lfe10-ClientEndServerFrame
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
.LC127:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_CalcRoll
	.type	 SV_CalcRoll,@function
SV_CalcRoll:
	stwu 1,-32(1)
	lis 9,right@ha
	lfs 12,4(4)
	lis 10,.LC127@ha
	la 11,right@l(9)
	lfs 10,right@l(9)
	la 10,.LC127@l(10)
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
.LC128:
	.long 0x0
	.align 2
.LC129:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SV_AddBlend
	.type	 SV_AddBlend,@function
SV_AddBlend:
	lis 9,.LC128@ha
	la 9,.LC128@l(9)
	lfs 0,0(9)
	fcmpu 0,4,0
	cror 3,2,0
	bclr 12,3
	lis 9,.LC129@ha
	lfs 12,12(3)
	la 9,.LC129@l(9)
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
.LC130:
	.long 0x43610000
	.align 2
.LC131:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetClientEvent
	.type	 G_SetClientEvent,@function
G_SetClientEvent:
	stwu 1,-16(1)
	lwz 0,80(3)
	cmpwi 0,0,0
	bc 4,2,.L282
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 12,2,.L282
	lis 11,.LC130@ha
	lis 9,xyspeed@ha
	la 11,.LC130@l(11)
	lfs 0,xyspeed@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L282
	lis 11,current_client@ha
	lis 8,bobmove@ha
	lwz 10,current_client@l(11)
	lfs 12,bobmove@l(8)
	lis 11,bobcycle@ha
	lfs 0,3740(10)
	lwz 0,bobcycle@l(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	cmpw 0,9,0
	bc 12,2,.L282
	lis 9,.LC131@ha
	lis 11,footsteps@ha
	la 9,.LC131@l(9)
	lfs 13,0(9)
	lwz 9,footsteps@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L282
	lwz 0,264(3)
	andi. 11,0,16384
	bc 4,2,.L282
	li 0,2
	stw 0,80(3)
.L282:
	la 1,16(1)
	blr
.Lfe13:
	.size	 G_SetClientEvent,.Lfe13-G_SetClientEvent
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
