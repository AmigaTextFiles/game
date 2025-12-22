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
	.string	"player/burn3.wav"
	.align 2
.LC4:
	.string	"player/burn4.wav"
	.align 2
.LC5:
	.string	"*pain%i_%i.wav"
	.align 3
.LC0:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC6:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC7:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC8:
	.long 0x3e4ccccd
	.align 3
.LC9:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC10:
	.long 0x3e99999a
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x41200000
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
	.long 0x42c80000
	.align 3
.LC16:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC17:
	.long 0x42480000
	.align 3
.LC18:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl P_DamageFeedback
	.type	 P_DamageFeedback,@function
P_DamageFeedback:
	stwu 1,-96(1)
	mflr 0
	stfd 27,56(1)
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 28,40(1)
	stw 0,100(1)
	mr 30,3
	li 9,0
	lwz 31,84(30)
	lwz 0,4164(31)
	sth 9,150(31)
	cmpwi 0,0,0
	bc 12,2,.L12
	li 0,1
	sth 0,150(31)
.L12:
	lwz 0,4156(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,268(30)
	andi. 7,0,16
	bc 4,2,.L13
	lis 11,level@ha
	lfs 12,4344(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 8,.LC11@ha
	la 8,.LC11@l(8)
	xoris 0,0,0x8000
	lfd 13,0(8)
	stw 0,36(1)
	stw 10,32(1)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L13
	lhz 0,150(31)
	ori 0,0,2
	sth 0,150(31)
.L13:
	lis 9,.LC11@ha
	lwz 0,4164(31)
	la 9,.LC11@l(9)
	lwz 10,4156(31)
	lis 8,0x4330
	lfd 13,0(9)
	lis 7,.LC12@ha
	lwz 9,4160(31)
	add 0,0,10
	la 7,.LC12@l(7)
	lfs 12,0(7)
	add 0,0,9
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 31,0
	fcmpu 0,31,12
	bc 12,2,.L11
	lwz 0,4328(31)
	cmpwi 0,0,2
	bc 12,1,.L15
	lwz 0,40(30)
	cmpwi 0,0,255
	bc 4,2,.L15
	li 0,3
	stw 0,4328(31)
	lwz 0,672(30)
	cmpwi 0,0,2
	bc 4,2,.L16
	li 0,168
	li 9,172
	b .L54
.L16:
	cmpwi 0,0,4
	bc 4,2,.L18
	li 0,229
	li 9,233
	b .L54
.L18:
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
	bc 12,2,.L22
	bc 12,1,.L26
	cmpwi 0,10,0
	bc 12,2,.L21
	b .L15
.L26:
	cmpwi 0,10,2
	bc 12,2,.L23
	b .L15
.L21:
	li 0,53
	li 9,57
	b .L54
.L22:
	li 0,57
	li 9,61
	b .L54
.L23:
	li 0,61
	li 9,65
.L54:
	stw 0,56(30)
	stw 9,4324(31)
.L15:
	lis 8,.LC13@ha
	fmr 27,31
	la 8,.LC13@l(8)
	lfs 0,0(8)
	fcmpu 0,27,0
	bc 4,0,.L27
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 31,0(9)
.L27:
	lis 9,level@ha
	lfs 0,468(30)
	la 29,level@l(9)
	lfs 11,4(29)
	fcmpu 0,11,0
	bc 4,1,.L28
	lwz 0,268(30)
	andi. 10,0,16
	bc 4,2,.L28
	lwz 0,level@l(9)
	lis 7,.LC11@ha
	lis 9,0x4330
	la 7,.LC11@l(7)
	lfs 12,4344(31)
	xoris 0,0,0x8000
	lfd 13,0(7)
	stw 0,36(1)
	stw 9,32(1)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L28
	lfs 0,988(30)
	fcmpu 0,0,11
	bc 4,1,.L29
	lis 9,.LC0@ha
	fmr 0,11
	lfd 13,.LC0@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,468(30)
	bl rand
	bl srand
	bl rand
	lis 0,0x51eb
	srawi 11,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 9,11,0
	mulli 9,9,100
	subf 9,9,3
	addi 0,9,-1
	cmplwi 0,0,23
	bc 4,1,.L36
	addi 0,9,-26
	cmplwi 0,0,23
	bc 12,1,.L32
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	b .L55
.L32:
	addi 0,9,-51
	cmplwi 0,0,23
	bc 12,1,.L34
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	b .L55
.L34:
	addi 0,9,-76
	cmplwi 0,0,23
	bc 12,1,.L36
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	b .L55
.L36:
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
.L55:
	lwz 11,36(29)
	lis 9,current_player@ha
	lwz 28,current_player@l(9)
	mtlr 11
	blrl
	lwz 0,16(29)
	lis 7,.LC14@ha
	lis 8,.LC14@ha
	lis 9,.LC12@ha
	mr 5,3
	la 7,.LC14@l(7)
	la 8,.LC14@l(8)
	mtlr 0
	la 9,.LC12@l(9)
	li 4,1
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	b .L28
.L29:
	bl rand
	lfs 0,4(29)
	lis 9,.LC0@ha
	rlwinm 3,3,0,31,31
	lfd 13,.LC0@l(9)
	addi 5,3,1
	lwz 0,484(30)
	cmpwi 0,0,24
	fadd 0,0,13
	frsp 0,0
	stfs 0,468(30)
	bc 12,1,.L39
	li 4,25
	b .L40
.L39:
	cmpwi 0,0,49
	bc 12,1,.L41
	li 4,50
	b .L40
.L41:
	cmpwi 7,0,74
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,100
	andi. 9,9,75
	or 4,0,9
.L40:
	lis 29,gi@ha
	lis 3,.LC5@ha
	la 29,gi@l(29)
	la 3,.LC5@l(3)
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC14@ha
	lis 8,.LC14@ha
	lis 9,.LC12@ha
	mr 5,3
	la 7,.LC14@l(7)
	la 8,.LC14@l(8)
	mtlr 0
	la 9,.LC12@l(9)
	li 4,2
	lfs 1,0(7)
	mr 3,30
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
.L28:
	lis 7,.LC12@ha
	lfs 0,4244(31)
	la 7,.LC12@l(7)
	lfs 30,0(7)
	fcmpu 0,0,30
	bc 4,0,.L45
	stfs 30,4244(31)
.L45:
	lfs 13,4244(31)
	lis 9,.LC6@ha
	fmr 29,31
	lis 11,.LC7@ha
	lfd 0,.LC6@l(9)
	lfd 12,.LC7@l(11)
	fmadd 0,29,0,13
	frsp 0,0
	fmr 13,0
	stfs 0,4244(31)
	fcmpu 0,13,12
	bc 4,0,.L46
	lis 9,.LC8@ha
	lfs 0,.LC8@l(9)
	stfs 0,4244(31)
.L46:
	lfs 0,4244(31)
	lis 9,.LC9@ha
	lfd 28,.LC9@l(9)
	fcmpu 0,0,28
	bc 4,1,.L47
	lis 9,.LC10@ha
	lfs 0,.LC10@l(9)
	stfs 0,4244(31)
.L47:
	stfs 30,16(1)
	stfs 30,12(1)
	stfs 30,8(1)
	lwz 0,4160(31)
	cmpwi 0,0,0
	bc 12,2,.L48
	xoris 0,0,0x8000
	stw 0,36(1)
	lis 11,0x4330
	lis 8,.LC11@ha
	la 8,.LC11@l(8)
	stw 11,32(1)
	addi 3,1,8
	lfd 0,0(8)
	lis 4,power_color.9@ha
	mr 5,3
	lfd 1,32(1)
	la 4,power_color.9@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,27
	bl VectorMA
.L48:
	lwz 0,4156(31)
	cmpwi 0,0,0
	bc 12,2,.L49
	xoris 0,0,0x8000
	stw 0,36(1)
	lis 11,0x4330
	lis 7,.LC11@ha
	la 7,.LC11@l(7)
	stw 11,32(1)
	addi 3,1,8
	lfd 0,0(7)
	lis 4,acolor.10@ha
	mr 5,3
	lfd 1,32(1)
	la 4,acolor.10@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,27
	bl VectorMA
.L49:
	lwz 0,4164(31)
	cmpwi 0,0,0
	bc 12,2,.L50
	xoris 0,0,0x8000
	stw 0,36(1)
	lis 11,0x4330
	lis 7,.LC11@ha
	la 7,.LC11@l(7)
	stw 11,32(1)
	addi 3,1,8
	lfd 0,0(7)
	lis 4,bcolor.11@ha
	mr 5,3
	lfd 1,32(1)
	la 4,bcolor.11@l(4)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,1,27
	bl VectorMA
.L50:
	lwz 11,4168(31)
	lis 10,0x4330
	lfs 0,8(1)
	lis 7,.LC11@ha
	srawi 8,11,31
	la 7,.LC11@l(7)
	xor 0,8,11
	lfd 10,0(7)
	subf 0,8,0
	stfs 0,4252(31)
	xoris 0,0,0x8000
	lfs 13,12(1)
	stw 0,36(1)
	stw 10,32(1)
	lfd 0,32(1)
	stfs 13,4256(31)
	lfs 12,16(1)
	fsub 0,0,10
	stfs 12,4260(31)
	frsp 31,0
	fcmpu 0,31,30
	bc 12,2,.L51
	lwz 0,484(30)
	cmpwi 0,0,0
	bc 4,1,.L51
	xoris 0,0,0x8000
	lis 11,.LC15@ha
	stw 0,36(1)
	la 11,.LC15@l(11)
	lis 7,.LC16@ha
	stw 10,32(1)
	la 7,.LC16@l(7)
	lfd 0,32(1)
	lfs 12,0(11)
	lfd 13,0(7)
	fsub 0,0,10
	fmuls 12,31,12
	fmul 11,29,13
	frsp 0,0
	fdivs 31,12,0
	fmr 13,31
	fcmpu 0,13,11
	bc 4,0,.L52
	frsp 31,11
.L52:
	lis 8,.LC17@ha
	la 8,.LC17@l(8)
	lfs 0,0(8)
	fcmpu 0,31,0
	bc 4,1,.L53
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 31,0(9)
.L53:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4172(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,4176(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,4180(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize
	lis 9,right@ha
	lfs 0,12(1)
	lis 10,forward@ha
	la 11,right@l(9)
	lfs 10,right@l(9)
	la 8,forward@l(10)
	lfs 12,4(11)
	lis 9,level+4@ha
	lis 7,.LC18@ha
	lfs 13,8(1)
	la 7,.LC18@l(7)
	lfs 11,8(11)
	fmuls 0,0,12
	lfd 8,0(7)
	lfs 12,16(1)
	fmadds 13,13,10,0
	fmadds 0,12,11,13
	fmuls 0,31,0
	fmul 0,0,28
	frsp 0,0
	stfs 0,4224(31)
	lfs 0,4(8)
	lfs 12,12(1)
	lfs 9,forward@l(10)
	lfs 13,8(1)
	fmuls 12,12,0
	lfs 10,8(8)
	lfs 11,16(1)
	fmadds 13,13,9,12
	fnmadds 0,11,10,13
	fmuls 0,31,0
	fmul 0,0,28
	frsp 0,0
	stfs 0,4228(31)
	lfs 13,level+4@l(9)
	fadd 13,13,8
	frsp 13,13
	stfs 13,4232(31)
.L51:
	li 0,0
	stw 0,4168(31)
	stw 0,4164(31)
	stw 0,4156(31)
	stw 0,4160(31)
.L11:
	lwz 0,100(1)
	mtlr 0
	lmw 28,40(1)
	lfd 27,56(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 P_DamageFeedback,.Lfe1-P_DamageFeedback
	.section	".rodata"
	.align 2
.LC19:
	.string	"misc/rumble.wav"
	.align 2
.LC23:
	.string	"misc/ring.wav"
	.align 3
.LC20:
	.long 0x3ffa6666
	.long 0x66666666
	.align 3
.LC21:
	.long 0x3fd66666
	.long 0x66666666
	.align 3
.LC22:
	.long 0xbfd66666
	.long 0x66666666
	.align 3
.LC24:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 2
.LC25:
	.long 0x0
	.align 2
.LC26:
	.long 0x41200000
	.align 2
.LC27:
	.long 0x3f800000
	.align 2
.LC28:
	.long 0x40400000
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC30:
	.long 0x41c80000
	.align 3
.LC31:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC32:
	.long 0xbfe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl P_ExplosionEffects
	.type	 P_ExplosionEffects,@function
P_ExplosionEffects:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	stw 12,16(1)
	mr 30,3
	lis 9,level@ha
	lwz 6,84(30)
	lwz 11,level@l(9)
	lwz 0,4692(6)
	subf 31,0,11
	cmpwi 0,31,25
	bc 12,1,.L58
	lis 7,.LC25@ha
	lfs 13,4704(6)
	la 7,.LC25@l(7)
	lfs 0,0(7)
	fcmpu 0,13,0
	bc 4,2,.L57
.L58:
	li 10,0
	li 0,0
	stw 10,4704(6)
	lwz 9,84(30)
	stw 0,4696(9)
	lwz 11,84(30)
	stw 0,4700(11)
	lwz 9,84(30)
	stw 10,4712(9)
	lwz 11,84(30)
	stw 0,4708(11)
	b .L56
.L57:
	bc 4,0,.L59
	lis 0,0x4248
	stw 0,4704(6)
.L59:
	lwz 11,84(30)
	lis 9,.LC26@ha
	cmpwi 0,31,1
	la 9,.LC26@l(9)
	lfs 12,0(9)
	lfs 0,4704(11)
	mfcr 27
	fdivs 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 28,12(1)
	bc 4,2,.L61
	lis 29,gi@ha
	lis 3,.LC19@ha
	la 29,gi@l(29)
	la 3,.LC19@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC27@ha
	lis 9,.LC28@ha
	lis 10,.LC25@ha
	mr 5,3
	la 7,.LC27@l(7)
	la 9,.LC28@l(9)
	mtlr 0
	la 10,.LC25@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,30
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L61:
	cmpwi 4,31,5
	bc 4,17,.L62
	lwz 9,84(30)
	lwz 0,4696(9)
	cmpwi 0,0,999
	bc 4,2,.L63
	li 0,0
	stw 0,4700(9)
.L63:
	lwz 11,84(30)
	lwz 0,4700(11)
	cmpwi 0,0,1
	bc 12,2,.L68
	cmplwi 0,0,1
	bc 12,0,.L65
	cmpwi 0,0,-1
	bc 12,2,.L70
	b .L56
.L65:
	andi. 0,28,1
	li 0,-1
	bc 12,2,.L66
	li 0,1
.L66:
	stw 0,4696(11)
	lwz 0,4696(11)
	stw 0,4700(11)
	b .L62
.L68:
	lwz 9,4696(11)
	addi 9,9,1
	stw 9,4696(11)
	lwz 9,84(30)
	lwz 0,4696(9)
	cmpwi 0,0,5
	bc 4,2,.L62
	li 0,-1
	b .L94
.L70:
	lwz 9,4696(11)
	addi 9,9,-1
	stw 9,4696(11)
	lwz 9,84(30)
	lwz 0,4696(9)
	cmpwi 0,0,-5
	bc 4,2,.L62
	li 0,1
.L94:
	stw 0,4700(9)
.L62:
	lwz 8,84(30)
	mtcrf 128,27
	bc 4,2,.L74
	xoris 0,28,0x8000
	stw 0,12(1)
	lis 11,0x4330
	lis 7,.LC29@ha
	la 7,.LC29@l(7)
	stw 11,8(1)
	lis 10,.LC20@ha
	lfd 12,0(7)
	lfd 0,8(1)
	lfd 13,.LC20@l(10)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	b .L75
.L74:
	cmpwi 0,31,4
	bc 12,1,.L76
	andi. 9,31,1
	bc 4,2,.L78
	neg 0,31
	xoris 0,0,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC29@ha
	la 10,.LC29@l(10)
	stw 11,8(1)
	lfd 0,0(10)
	b .L95
.L78:
	xoris 0,31,0x8000
	stw 0,12(1)
	lis 11,0x4330
	lis 7,.LC29@ha
	la 7,.LC29@l(7)
	stw 11,8(1)
	lfd 0,0(7)
.L95:
	lfd 13,8(1)
	fsub 13,13,0
	frsp 0,13
	b .L75
.L76:
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 0,0(9)
.L75:
	cmpwi 7,28,15
	mfcr 9
	rlwinm 9,9,18,1
	stfs 0,4200(8)
	lwz 27,84(30)
	mfcr 0
	rlwinm 0,0,30,1
	mcrf 3,7
	and. 10,9,0
	bc 12,2,.L80
	addi 0,31,145
	xoris 0,0,0x8000
	lis 29,0x4330
	stw 0,12(1)
	lis 11,.LC29@ha
	stw 29,8(1)
	la 11,.LC29@l(11)
	lfd 31,0(11)
	lfd 1,8(1)
	fsub 1,1,31
	bl sin
	lis 0,0x6666
	srawi 10,28,31
	ori 0,0,26215
	mulhw 0,28,0
	mr 11,9
	xoris 8,31,0x8000
	lis 7,.LC30@ha
	srawi 0,0,2
	la 7,.LC30@l(7)
	subf 0,10,0
	lfs 11,0(7)
	xoris 0,0,0x8000
	lis 7,.LC27@ha
	stw 0,12(1)
	la 7,.LC27@l(7)
	stw 29,8(1)
	lfd 13,8(1)
	stw 8,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	fsub 13,13,31
	lfs 12,0(7)
	fsub 0,0,31
	fmul 1,1,13
	frsp 0,0
	fadd 1,1,1
	fdivs 0,0,11
	fsubs 12,12,0
	fmul 1,1,12
	frsp 1,1
	b .L81
.L80:
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 1,0(9)
.L81:
	cmpwi 0,31,2
	stfs 1,4204(27)
	lwz 27,84(30)
	bc 12,1,.L82
	andi. 10,31,1
	bc 12,2,.L84
	xoris 0,28,0x8000
	stw 0,12(1)
	lis 11,0x4330
	lis 7,.LC29@ha
	la 7,.LC29@l(7)
	stw 11,8(1)
	lis 10,.LC31@ha
	lfd 12,0(7)
	la 10,.LC31@l(10)
	b .L96
.L84:
	xoris 0,28,0x8000
	stw 0,12(1)
	lis 11,0x4330
	lis 7,.LC29@ha
	la 7,.LC29@l(7)
	stw 11,8(1)
	lis 10,.LC32@ha
	lfd 12,0(7)
	la 10,.LC32@l(10)
.L96:
	lfd 0,8(1)
	lfd 13,0(10)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	b .L83
.L82:
	mfcr 0
	rlwinm 9,0,18,1
	rlwinm 0,0,14,1
	and. 11,9,0
	bc 12,2,.L86
	andi. 0,28,1
	bc 12,2,.L88
	addi 0,31,90
	xoris 0,0,0x8000
	lis 29,0x4330
	stw 0,12(1)
	lis 7,.LC29@ha
	stw 29,8(1)
	la 7,.LC29@l(7)
	lfd 31,0(7)
	lfd 1,8(1)
	fsub 1,1,31
	bl sin
	lis 0,0x6666
	srawi 8,28,31
	ori 0,0,26215
	mulhw 0,28,0
	mr 10,11
	xoris 7,31,0x8000
	lis 9,.LC30@ha
	srawi 0,0,2
	la 9,.LC30@l(9)
	subf 0,8,0
	lfs 10,0(9)
	xoris 0,0,0x8000
	lis 9,.LC27@ha
	stw 0,12(1)
	la 9,.LC27@l(9)
	stw 29,8(1)
	lfd 13,8(1)
	stw 7,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	fsub 13,13,31
	lfs 12,0(9)
	lis 9,.LC21@ha
	fsub 0,0,31
	lfd 11,.LC21@l(9)
	b .L97
.L88:
	addi 0,31,90
	xoris 0,0,0x8000
	lis 29,0x4330
	stw 0,12(1)
	lis 10,.LC29@ha
	stw 29,8(1)
	la 10,.LC29@l(10)
	lfd 31,0(10)
	lfd 1,8(1)
	fsub 1,1,31
	bl sin
	lis 0,0x6666
	srawi 8,28,31
	ori 0,0,26215
	mulhw 0,28,0
	mr 10,11
	xoris 7,31,0x8000
	lis 9,.LC30@ha
	srawi 0,0,2
	la 9,.LC30@l(9)
	subf 0,8,0
	lfs 10,0(9)
	xoris 0,0,0x8000
	lis 9,.LC27@ha
	stw 0,12(1)
	la 9,.LC27@l(9)
	stw 29,8(1)
	lfd 13,8(1)
	stw 7,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	fsub 13,13,31
	lfs 12,0(9)
	lis 9,.LC22@ha
	fsub 0,0,31
	lfd 11,.LC22@l(9)
.L97:
	fmul 1,1,13
	frsp 0,0
	fadd 1,1,1
	fdivs 0,0,10
	fsubs 12,12,0
	fmul 1,1,11
	fmul 0,1,12
	frsp 0,0
	b .L83
.L86:
	lis 10,.LC25@ha
	la 10,.LC25@l(10)
	lfs 0,0(10)
.L83:
	addi 0,31,-1
	stfs 0,4208(27)
	cmplwi 0,0,9
	bc 12,1,.L90
	lwz 9,84(30)
	lwz 0,4708(9)
	cmpwi 0,0,1
	bc 4,2,.L90
	cmpwi 0,31,3
	bc 4,2,.L91
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC27@ha
	lis 9,.LC28@ha
	lis 10,.LC25@ha
	mr 5,3
	la 7,.LC27@l(7)
	la 9,.LC28@l(9)
	mtlr 0
	la 10,.LC25@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,30
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L91:
	subfic 0,31,10
	lwz 8,84(30)
	xoris 0,0,0x8000
	lis 10,0x4330
	stw 0,12(1)
	lis 7,.LC29@ha
	lis 11,.LC24@ha
	la 7,.LC29@l(7)
	stw 10,8(1)
	lfd 12,0(7)
	lfd 0,8(1)
	lfd 13,.LC24@l(11)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4712(8)
	b .L56
.L90:
	lwz 9,84(30)
	li 0,0
	stw 0,4712(9)
.L56:
	lwz 0,52(1)
	lwz 12,16(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	mtcrf 24,12
	la 1,48(1)
	blr
.Lfe2:
	.size	 P_ExplosionEffects,.Lfe2-P_ExplosionEffects
	.section	".rodata"
	.align 3
.LC33:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC34:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC35:
	.long 0x0
	.align 2
.LC36:
	.long 0x40800000
	.align 2
.LC37:
	.long 0x40c00000
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC39:
	.long 0xc1600000
	.align 2
.LC40:
	.long 0x41600000
	.align 2
.LC41:
	.long 0xc1b00000
	.align 2
.LC42:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SV_CalcViewOffset
	.type	 SV_CalcViewOffset,@function
SV_CalcViewOffset:
	stwu 1,-48(1)
	stmw 30,40(1)
	mr 12,3
	lwz 0,496(12)
	lwz 31,84(12)
	cmpwi 0,0,0
	addi 30,31,52
	bc 12,2,.L99
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
	lfs 0,4188(9)
	stfs 0,32(9)
	b .L100
.L99:
	lfs 0,4200(31)
	lis 9,level@ha
	lis 11,.LC35@ha
	la 10,level@l(9)
	la 11,.LC35@l(11)
	lfs 11,0(11)
	stfs 0,52(31)
	lwz 9,84(12)
	lfs 0,4204(9)
	stfs 0,4(30)
	lwz 9,84(12)
	lfs 0,4208(9)
	stfs 0,8(30)
	lwz 9,84(12)
	lfs 13,4(10)
	lfs 0,4232(9)
	fsubs 0,0,13
	fadd 0,0,0
	frsp 9,0
	fcmpu 0,9,11
	bc 4,0,.L101
	lis 11,.LC35@ha
	la 11,.LC35@l(11)
	lfs 9,0(11)
	stfs 9,4228(9)
	lwz 9,84(12)
	stfs 9,4224(9)
.L101:
	lwz 9,84(12)
	lis 11,.LC33@ha
	lfs 13,52(31)
	lfs 0,4228(9)
	lfd 12,.LC33@l(11)
	fmadds 0,9,0,13
	stfs 0,52(31)
	lwz 9,84(12)
	lfs 13,8(30)
	lfs 0,4224(9)
	fmadds 0,9,0,13
	stfs 0,8(30)
	lwz 9,84(12)
	lfs 13,4(10)
	lfs 0,4236(9)
	fsubs 0,0,13
	fdiv 0,0,12
	frsp 9,0
	fcmpu 0,9,11
	bc 4,0,.L102
	lis 11,.LC35@ha
	la 11,.LC35@l(11)
	lfs 9,0(11)
.L102:
	lfs 11,4240(9)
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
	lfs 0,384(12)
	lfs 10,forward@l(9)
	lfs 13,380(12)
	fmuls 0,0,12
	lfs 9,8(11)
	lfs 12,388(12)
	lwz 9,run_pitch@l(7)
	fmadds 13,13,10,0
	lfs 0,20(9)
	fmadds 12,12,9,13
	fmadds 0,12,0,11
	stfs 0,52(31)
	lfs 0,4(8)
	lfs 13,384(12)
	lfs 11,right@l(10)
	lfs 12,380(12)
	fmuls 13,13,0
	lfs 9,8(8)
	lfs 10,388(12)
	lwz 9,run_roll@l(6)
	fmadds 12,12,11,13
	lfs 13,8(30)
	lfs 0,20(9)
	fmadds 12,10,9,12
	fmadds 0,12,0,13
	stfs 0,8(30)
	lwz 9,bob_pitch@l(5)
	lfs 0,bobfracsin@l(4)
	lfs 13,20(9)
	lwz 0,672(12)
	lfs 12,xyspeed@l(3)
	fmuls 0,0,13
	cmpwi 0,0,2
	fmuls 12,0,12
	bc 4,2,.L103
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 0,0(9)
	b .L121
.L103:
	cmpwi 0,0,4
	bc 4,2,.L104
	lis 11,.LC37@ha
	la 11,.LC37@l(11)
	lfs 0,0(11)
.L121:
	fmuls 12,12,0
.L104:
	lfs 0,0(30)
	lis 11,bob_roll@ha
	lis 10,bobfracsin@ha
	lis 8,xyspeed@ha
	fadds 0,0,12
	stfs 0,0(30)
	lwz 9,bob_roll@l(11)
	lfs 0,bobfracsin@l(10)
	lfs 13,20(9)
	lwz 0,672(12)
	lfs 12,xyspeed@l(8)
	fmuls 0,0,13
	cmpwi 0,0,2
	fmuls 12,0,12
	bc 4,2,.L106
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 0,0(9)
	b .L122
.L106:
	cmpwi 0,0,4
	bc 4,2,.L107
	lis 11,.LC37@ha
	la 11,.LC37@l(11)
	lfs 0,0(11)
.L122:
	fmuls 12,12,0
.L107:
	lis 9,bobcycle@ha
	lwz 0,bobcycle@l(9)
	andi. 9,0,1
	bc 12,2,.L109
	fneg 12,12
.L109:
	lfs 0,8(30)
	fadds 0,0,12
	stfs 0,8(30)
.L100:
	lwz 0,512(12)
	lis 8,0x4330
	lis 11,.LC38@ha
	lwz 7,84(12)
	lis 10,.LC33@ha
	xoris 0,0,0x8000
	la 11,.LC38@l(11)
	lfd 13,.LC33@l(10)
	stw 0,36(1)
	stw 8,32(1)
	lfd 12,0(11)
	lfd 0,32(1)
	lis 11,.LC35@ha
	la 11,.LC35@l(11)
	lfs 8,0(11)
	fsub 0,0,12
	lis 11,level+4@ha
	lfs 11,level+4@l(11)
	stfs 8,12(1)
	frsp 0,0
	stfs 8,8(1)
	fadds 12,0,8
	stfs 12,16(1)
	lfs 0,4236(7)
	fsubs 0,0,11
	fdiv 0,0,13
	frsp 9,0
	fcmpu 0,9,8
	bc 4,0,.L110
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 9,0(9)
.L110:
	lfs 0,4240(7)
	lis 9,.LC34@ha
	fmr 13,12
	lis 11,bobfracsin@ha
	lfd 10,.LC34@l(9)
	lis 10,xyspeed@ha
	lfs 12,bobfracsin@l(11)
	lis 9,bob_up@ha
	fmuls 0,9,0
	lis 11,.LC37@ha
	lfs 11,xyspeed@l(10)
	la 11,.LC37@l(11)
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
	bc 4,1,.L111
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 0,0(9)
.L111:
	fadds 12,13,0
	lis 11,.LC39@ha
	la 11,.LC39@l(11)
	lfs 10,0(11)
	stfs 12,16(1)
	lfs 0,4212(7)
	fadds 11,0,8
	stfs 11,8(1)
	fcmpu 0,11,10
	lfs 0,4216(7)
	fadds 0,0,8
	stfs 0,12(1)
	lfs 13,4220(7)
	fadds 12,12,13
	stfs 12,16(1)
	bc 4,0,.L112
	stfs 10,8(1)
	b .L113
.L112:
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L113
	stfs 0,8(1)
.L113:
	lis 11,.LC39@ha
	lfs 0,12(1)
	la 11,.LC39@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L123
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L116
.L123:
	stfs 13,12(1)
.L116:
	lis 11,.LC41@ha
	lfs 0,16(1)
	la 11,.LC41@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L124
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L119
.L124:
	stfs 13,16(1)
.L119:
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
.Lfe3:
	.size	 SV_CalcViewOffset,.Lfe3-SV_CalcViewOffset
	.section	".rodata"
	.align 3
.LC43:
	.long 0x3f747ae1
	.long 0x47ae147b
	.align 3
.LC44:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 3
.LC45:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC46:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC47:
	.long 0x43340000
	.align 2
.LC48:
	.long 0x43b40000
	.align 2
.LC49:
	.long 0xc3340000
	.align 2
.LC50:
	.long 0x42340000
	.align 2
.LC51:
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
	lis 9,.LC43@ha
	lis 10,.LC44@ha
	lfs 13,xyspeed@l(7)
	lis 11,bobcycle@ha
	lfd 11,.LC43@l(9)
	lfd 12,.LC44@l(10)
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
	bc 12,2,.L126
	lwz 9,84(3)
	lfs 0,72(9)
	fneg 0,0
	stfs 0,72(9)
	lwz 11,84(3)
	lfs 0,68(11)
	fneg 0,0
	stfs 0,68(11)
.L126:
	lfs 0,xyspeed@l(7)
	lis 9,.LC45@ha
	lis 10,.LC47@ha
	lfs 13,bobfracsin@l(6)
	la 10,.LC47@l(10)
	li 0,3
	lfd 9,.LC45@l(9)
	lis 11,.LC46@ha
	mtctr 0
	li 7,0
	lfs 5,0(10)
	lis 9,.LC48@ha
	li 8,0
	fmuls 0,0,13
	la 9,.LC48@l(9)
	lis 10,.LC49@ha
	lfd 10,.LC46@l(11)
	la 10,.LC49@l(10)
	lfs 12,0(9)
	lfs 6,0(10)
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lis 10,.LC51@ha
	lfs 7,0(9)
	la 10,.LC51@l(10)
	lwz 9,84(3)
	fmul 0,0,11
	lfs 8,0(10)
	frsp 0,0
	stfs 0,64(9)
.L143:
	lwz 10,84(3)
	addi 9,10,4280
	addi 11,10,28
	lfsx 13,9,8
	lfsx 0,11,8
	fsubs 13,13,0
	fcmpu 0,13,5
	bc 4,1,.L131
	fsubs 13,13,12
.L131:
	fcmpu 0,13,6
	bc 4,0,.L132
	fadds 13,13,12
.L132:
	fcmpu 0,13,7
	bc 4,1,.L133
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 13,0(9)
.L133:
	fcmpu 0,13,8
	bc 4,0,.L134
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 13,0(9)
.L134:
	cmpwi 0,7,1
	bc 4,2,.L135
	lfs 0,72(10)
	fmadd 0,13,9,0
	frsp 0,0
	stfs 0,72(10)
.L135:
	lwz 9,84(3)
	addi 7,7,1
	addi 9,9,64
	lfsx 0,9,8
	fmadd 0,13,10,0
	frsp 0,0
	stfsx 0,9,8
	addi 8,8,4
	bdnz .L143
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
.L142:
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
	bdnz .L142
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 SV_CalcGunOffset,.Lfe4-SV_CalcGunOffset
	.section	".rodata"
	.align 2
.LC61:
	.string	"items/damage2.wav"
	.align 2
.LC63:
	.string	"items/protect2.wav"
	.align 2
.LC64:
	.string	"items/airout.wav"
	.align 2
.LC52:
	.long 0x3f666666
	.align 2
.LC53:
	.long 0x3f19999a
	.align 2
.LC54:
	.long 0x3f570a3d
	.align 3
.LC55:
	.long 0x3f9eb851
	.long 0xeb851eb8
	.align 2
.LC56:
	.long 0x3e99999a
	.align 2
.LC57:
	.long 0x3dcccccd
	.align 2
.LC58:
	.long 0x3d4ccccd
	.align 2
.LC59:
	.long 0x3e4ccccd
	.align 2
.LC60:
	.long 0x3ecccccd
	.align 2
.LC62:
	.long 0x3da3d70a
	.align 2
.LC65:
	.long 0x3d23d70a
	.align 2
.LC66:
	.long 0x3f59999a
	.align 2
.LC67:
	.long 0x3f333333
	.align 3
.LC68:
	.long 0x3faeb851
	.long 0xeb851eb8
	.align 3
.LC69:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC70:
	.long 0x0
	.align 2
.LC71:
	.long 0x3f800000
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC73:
	.long 0x40240000
	.long 0x0
	.align 3
.LC74:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC75:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC76:
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
	bc 12,2,.L147
	lwz 9,84(30)
	lwz 0,116(9)
	ori 0,0,1
	b .L214
.L147:
	lwz 9,84(30)
	lwz 0,116(9)
	rlwinm 0,0,0,0,30
.L214:
	stw 0,116(9)
	lis 9,.LC70@ha
	lfs 0,988(30)
	la 9,.LC70@l(9)
	lfs 7,0(9)
	fcmpu 0,0,7
	bc 12,2,.L149
	lwz 10,84(30)
	lis 9,.LC54@ha
	lis 11,.LC71@ha
	lfs 8,.LC54@l(9)
	la 11,.LC71@l(11)
	lis 8,.LC53@ha
	addi 9,10,96
	lfs 11,0(11)
	lfs 0,12(9)
	lis 11,.LC52@ha
	lfs 9,.LC52@l(11)
	lfs 12,96(10)
	fsubs 10,11,0
	lfs 13,.LC53@l(8)
	fmadds 10,10,8,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 9,11,9
	fmuls 11,11,13
	fmadds 12,12,0,9
	stfs 12,96(10)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,9
	fmadds 12,12,0,11
	stfs 13,4(9)
	stfs 12,8(9)
.L149:
	lis 10,level_wait@ha
	lwz 8,level_wait@l(10)
	lis 9,level@ha
	lwz 0,level@l(9)
	lfs 0,20(8)
	fmr 10,0
	fctiwz 13,10
	stfd 13,24(1)
	lwz 11,28(1)
	mulli 11,11,10
	cmpw 0,0,11
	bc 4,0,.L152
	xoris 11,0,0x8000
	lwz 10,84(30)
	stw 11,28(1)
	lis 0,0x4330
	lis 11,.LC72@ha
	stw 0,24(1)
	la 11,.LC72@l(11)
	lfd 0,24(1)
	lfd 11,0(11)
	addi 9,10,96
	lis 11,.LC73@ha
	la 11,.LC73@l(11)
	lfd 13,0(11)
	fsub 0,0,11
	lis 11,.LC74@ha
	la 11,.LC74@l(11)
	fmul 13,10,13
	lfd 12,0(11)
	fdiv 0,0,13
	frsp 0,0
	fmr 13,0
	fsub 12,12,13
	frsp 12,12
	fcmpu 0,12,7
	cror 3,2,0
	bc 12,3,.L152
	lis 11,.LC71@ha
	lfs 13,12(9)
	la 11,.LC71@l(11)
	lfs 11,96(10)
	lfs 0,0(11)
	fsubs 10,0,13
	fmadds 10,10,12,13
	fdivs 13,13,10
	fsubs 0,0,13
	fmuls 0,0,7
	fmadds 11,11,13,0
	stfs 11,96(10)
	lfs 12,4(9)
	lfs 11,8(9)
	stfs 10,12(9)
	fmadds 12,12,13,0
	fmadds 11,11,13,0
	stfs 12,4(9)
	stfs 11,8(9)
.L152:
	lwz 0,496(30)
	cmpwi 0,0,0
	bc 12,2,.L155
	lwz 11,84(30)
	lis 9,.LC71@ha
	la 9,.LC71@l(9)
	lfs 11,0(9)
	lfs 0,3456(11)
	fcmpu 0,0,11
	bc 4,0,.L156
	lis 9,.LC55@ha
	lfd 13,.LC55@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3456(11)
.L156:
	lwz 9,84(30)
	lfs 0,3456(9)
	fcmpu 0,0,11
	bc 4,1,.L157
	stfs 11,3456(9)
.L157:
	lwz 11,84(30)
	lis 10,.LC75@ha
	lis 9,.LC70@ha
	la 10,.LC75@l(10)
	la 9,.LC70@l(9)
	lfs 9,3456(11)
	lfd 13,0(10)
	lfs 8,0(9)
	fmr 0,9
	addi 9,11,96
	fcmpu 0,9,8
	fmul 0,0,13
	fsub 13,13,0
	frsp 13,13
	cror 3,2,0
	bc 12,3,.L160
	lfs 0,12(9)
	lfs 12,96(11)
	fsubs 10,11,0
	fmadds 10,10,9,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 13,13,11
	fmuls 11,11,8
	fmadds 12,12,0,13
	stfs 12,96(11)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,11
	stfs 13,4(9)
	stfs 12,8(9)
	b .L160
.L155:
	lwz 9,84(30)
	lis 10,.LC70@ha
	la 10,.LC70@l(10)
	lfs 13,0(10)
	lfs 0,3456(9)
	fcmpu 0,0,13
	bc 12,2,.L160
	stfs 13,3456(9)
.L160:
	andi. 11,3,9
	bc 12,2,.L162
	lis 9,.LC71@ha
	lwz 11,84(30)
	lis 10,.LC56@ha
	la 9,.LC71@l(9)
	lfs 13,.LC56@l(10)
	lfs 11,0(9)
	lis 9,.LC53@ha
	lfs 12,96(11)
	lfs 8,.LC53@l(9)
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
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
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,9
	b .L215
.L162:
	andi. 10,3,16
	bc 12,2,.L166
	lis 9,.LC53@ha
	lwz 10,84(30)
	lis 11,.LC71@ha
	lfs 7,.LC53@l(9)
	la 11,.LC71@l(11)
	lis 8,.LC57@ha
	lis 9,.LC70@ha
	lfs 11,0(11)
	la 9,.LC70@l(9)
	lfs 12,96(10)
	lis 11,.LC58@ha
	lfs 13,0(9)
	addi 9,10,96
	lfs 9,.LC58@l(11)
	lfs 0,12(9)
	lfs 8,.LC57@l(8)
	fsubs 10,11,0
	fmadds 10,10,7,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 13,11,13
	fmuls 9,11,9
	fmuls 11,11,8
	fmadds 12,12,0,13
	stfs 12,96(10)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,9
	b .L215
.L166:
	andi. 10,3,32
	bc 12,2,.L170
	lis 9,.LC60@ha
	lwz 10,84(30)
	lis 11,.LC71@ha
	lfs 7,.LC60@l(9)
	la 11,.LC71@l(11)
	lis 8,.LC56@ha
	lis 9,.LC76@ha
	lfs 11,0(11)
	la 9,.LC76@l(9)
	lfs 12,96(10)
	lis 11,.LC59@ha
	lfs 13,0(9)
	addi 9,10,96
	lfs 9,.LC59@l(11)
	lfs 0,12(9)
	lfs 8,.LC56@l(8)
	fsubs 10,11,0
	fmadds 10,10,7,0
	fdivs 0,0,10
	fsubs 11,11,0
	fmuls 13,11,13
	fmuls 9,11,9
	fmuls 11,11,8
	fmadds 12,12,0,13
	stfs 12,96(10)
	lfs 13,4(9)
	lfs 12,8(9)
	stfs 10,12(9)
	fmadds 13,13,0,11
	fmadds 12,12,0,9
	b .L215
.L170:
	lwz 11,84(30)
	lwz 0,4708(11)
	cmpwi 0,0,0
	bc 12,2,.L165
	lis 10,.LC70@ha
	lfs 13,4712(11)
	addi 9,11,96
	la 10,.LC70@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L165
	lis 10,.LC71@ha
	lfs 0,12(9)
	la 10,.LC71@l(10)
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
.L215:
	stfs 13,4(9)
	stfs 12,8(9)
.L165:
	lis 11,level@ha
	lwz 8,84(30)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC72@ha
	lfs 12,4340(8)
	xoris 0,0,0x8000
	la 11,.LC72@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L177
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 4,31,30
	bc 4,18,.L178
	lis 29,gi@ha
	lis 3,.LC61@ha
	la 29,gi@l(29)
	la 3,.LC61@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC71@ha
	lis 10,.LC71@ha
	lis 11,.LC70@ha
	mr 5,3
	la 9,.LC71@l(9)
	la 10,.LC71@l(10)
	mtlr 0
	la 11,.LC70@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L178:
	bc 12,17,.L180
	andi. 0,31,4
	bc 12,2,.L183
.L180:
	lis 9,.LC71@ha
	lwz 11,84(30)
	lis 10,.LC70@ha
	la 9,.LC71@l(9)
	la 10,.LC70@l(10)
	lfs 9,0(9)
	lis 9,.LC62@ha
	lfs 10,0(10)
	lfs 13,.LC62@l(9)
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
	b .L216
.L177:
	lfs 13,4344(8)
	fcmpu 0,13,0
	bc 4,1,.L184
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 4,31,30
	bc 4,18,.L185
	lis 29,gi@ha
	lis 3,.LC63@ha
	la 29,gi@l(29)
	la 3,.LC63@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC71@ha
	lis 10,.LC71@ha
	lis 11,.LC70@ha
	mr 5,3
	la 9,.LC71@l(9)
	la 10,.LC71@l(10)
	mtlr 0
	la 11,.LC70@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L185:
	bc 12,17,.L187
	andi. 0,31,4
	bc 12,2,.L183
.L187:
	lis 9,.LC71@ha
	lwz 11,84(30)
	lis 10,.LC70@ha
	la 9,.LC71@l(9)
	la 10,.LC70@l(10)
	lfs 10,0(9)
	lis 9,.LC62@ha
	lfs 12,96(11)
	lfs 13,.LC62@l(9)
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
	b .L216
.L184:
	lfs 13,4352(8)
	fcmpu 0,13,0
	bc 4,1,.L191
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 4,31,30
	bc 4,18,.L192
	lis 29,gi@ha
	lis 3,.LC64@ha
	la 29,gi@l(29)
	la 3,.LC64@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC71@ha
	lis 10,.LC71@ha
	lis 11,.LC70@ha
	mr 5,3
	la 9,.LC71@l(9)
	la 10,.LC71@l(10)
	mtlr 0
	la 11,.LC70@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L192:
	bc 12,17,.L194
	andi. 0,31,4
	bc 12,2,.L183
.L194:
	lis 9,.LC71@ha
	lwz 11,84(30)
	lis 10,.LC70@ha
	la 9,.LC71@l(9)
	la 10,.LC70@l(10)
	lfs 10,0(9)
	lis 9,.LC62@ha
	lfs 9,0(10)
	lfs 13,.LC62@l(9)
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
	b .L216
.L191:
	lfs 13,4348(8)
	fcmpu 0,13,0
	bc 4,1,.L183
	fsubs 0,13,0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 4,31,30
	bc 4,18,.L199
	lis 29,gi@ha
	lis 3,.LC64@ha
	la 29,gi@l(29)
	la 3,.LC64@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC71@ha
	lis 10,.LC71@ha
	lis 11,.LC70@ha
	mr 5,3
	la 9,.LC71@l(9)
	la 10,.LC71@l(10)
	mtlr 0
	la 11,.LC70@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L199:
	bc 12,17,.L201
	andi. 0,31,4
	bc 12,2,.L183
.L201:
	lis 9,.LC71@ha
	lwz 10,84(30)
	lis 11,.LC60@ha
	la 9,.LC71@l(9)
	lfs 10,.LC60@l(11)
	lfs 9,0(9)
	lis 9,.LC65@ha
	lfs 12,96(10)
	lfs 13,.LC65@l(9)
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
.L216:
	stfs 13,4(9)
	stfs 12,8(9)
.L183:
	lwz 11,84(30)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4184(11)
	fcmpu 0,0,13
	bc 4,1,.L204
	lis 10,.LC70@ha
	lfs 8,4244(11)
	la 10,.LC70@l(10)
	lfs 0,0(10)
	fcmpu 0,8,0
	bc 4,1,.L205
	lfs 12,4252(11)
	addi 9,11,96
	lfs 7,4256(11)
	lfs 9,4260(11)
	cror 3,2,0
	bc 12,3,.L205
	lis 10,.LC71@ha
	lfs 13,12(9)
	la 10,.LC71@l(10)
	lfs 11,96(11)
	lfs 0,0(10)
	fsubs 10,0,13
	fmadds 10,10,8,13
	fdivs 13,13,10
	fsubs 0,0,13
	fmuls 12,12,0
	fmuls 9,9,0
	fmuls 0,7,0
	fmadds 11,11,13,12
	stfs 11,96(11)
	lfs 12,4(9)
	lfs 11,8(9)
	stfs 10,12(9)
	fmadds 12,12,13,0
	fmadds 11,11,13,9
	stfs 12,4(9)
	stfs 11,8(9)
.L205:
	lwz 3,84(30)
	lis 11,.LC70@ha
	la 11,.LC70@l(11)
	lfs 0,0(11)
	lfs 12,4248(3)
	fcmpu 0,12,0
	bc 4,1,.L211
	lis 9,.LC66@ha
	lis 10,.LC67@ha
	lfs 7,.LC66@l(9)
	lis 11,.LC56@ha
	addi 9,3,96
	lfs 8,.LC67@l(10)
	lfs 9,.LC56@l(11)
	cror 3,2,0
	bc 12,3,.L211
	lis 10,.LC71@ha
	lfs 13,12(9)
	la 10,.LC71@l(10)
	lfs 11,96(3)
	lfs 0,0(10)
	fsubs 10,0,13
	fmadds 10,10,12,13
	fdivs 13,13,10
	fsubs 0,0,13
	fmuls 12,0,7
	fmuls 9,0,9
	fmuls 0,0,8
	fmadds 11,11,13,12
	stfs 11,96(3)
	lfs 12,4(9)
	lfs 11,8(9)
	stfs 10,12(9)
	fmadds 12,12,13,0
	fmadds 11,11,13,9
	stfs 12,4(9)
	stfs 11,8(9)
	b .L211
.L204:
	lfs 0,4244(11)
	lis 9,.LC68@ha
	lis 10,.LC70@ha
	lfd 13,.LC68@l(9)
	la 10,.LC70@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4244(11)
	lwz 9,84(30)
	lfs 0,4244(9)
	fcmpu 0,0,12
	bc 4,0,.L212
	stfs 12,4244(9)
.L212:
	lwz 11,84(30)
	lis 9,.LC69@ha
	lfd 13,.LC69@l(9)
	lfs 0,4248(11)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4248(11)
	lwz 3,84(30)
	lfs 0,4248(3)
	fcmpu 0,0,12
	bc 4,0,.L211
	stfs 12,4248(3)
.L211:
	lwz 0,52(1)
	lwz 12,32(1)
	mtlr 0
	lmw 29,36(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe5:
	.size	 SV_CalcBlend,.Lfe5-SV_CalcBlend
	.section	".rodata"
	.align 3
.LC77:
	.long 0x3f1a36e2
	.long 0xeb1c432d
	.align 3
.LC78:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC79:
	.long 0x0
	.align 2
.LC80:
	.long 0x41200000
	.align 2
.LC81:
	.long 0x3f800000
	.align 2
.LC82:
	.long 0x41700000
	.align 3
.LC83:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC84:
	.long 0x42200000
	.align 2
.LC85:
	.long 0x41f00000
	.align 2
.LC86:
	.long 0x425c0000
	.align 2
.LC87:
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
	bc 4,2,.L217
	lwz 0,264(3)
	cmpwi 0,0,1
	bc 12,2,.L217
	lwz 9,84(3)
	lis 11,.LC79@ha
	la 11,.LC79@l(11)
	lfs 0,0(11)
	lfs 13,4300(9)
	mr 11,9
	fcmpu 0,13,0
	bc 4,0,.L220
	lfs 0,388(3)
	fcmpu 0,0,13
	bc 4,1,.L220
	lwz 0,560(3)
	cmpwi 0,0,0
	bc 4,2,.L238
	fmr 11,13
	b .L221
.L220:
	lwz 0,560(3)
	cmpwi 0,0,0
	bc 12,2,.L217
.L238:
	lfs 13,388(3)
	lfs 0,4300(11)
	fsubs 11,13,0
.L221:
	fmuls 0,11,11
	lis 9,.LC77@ha
	lwz 0,3464(11)
	lfd 13,.LC77@l(9)
	cmpwi 0,0,6
	fmul 0,0,13
	frsp 11,0
	bc 4,2,.L223
	lis 9,.LC80@ha
	lfs 0,4544(11)
	la 9,.LC80@l(9)
	lfs 12,0(9)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	fadds 0,0,12
	fcmpu 0,13,0
	bc 12,0,.L217
.L223:
	lwz 0,620(3)
	cmpwi 0,0,3
	bc 12,2,.L217
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 12,0,.L217
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,0,.L228
	li 0,2
	b .L239
.L228:
	lis 9,.LC83@ha
	fmr 0,11
	la 9,.LC83@l(9)
	lfd 13,0(9)
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	fmul 0,0,13
	lfs 12,0(9)
	frsp 0,0
	stfs 0,4240(11)
	lwz 9,84(3)
	lfs 0,4240(9)
	fcmpu 0,0,12
	bc 4,1,.L229
	stfs 12,4240(9)
.L229:
	lis 9,level+4@ha
	lis 11,.LC78@ha
	lwz 10,84(3)
	lfs 0,level+4@l(9)
	lis 9,.LC85@ha
	lfd 13,.LC78@l(11)
	la 9,.LC85@l(9)
	lfs 12,0(9)
	fadd 0,0,13
	fcmpu 0,11,12
	frsp 0,0
	stfs 0,4236(10)
	bc 4,1,.L230
	lwz 0,484(3)
	cmpwi 0,0,0
	bc 4,1,.L231
	lis 11,.LC86@ha
	la 11,.LC86@l(11)
	lfs 0,0(11)
	fcmpu 0,11,0
	li 0,4
	cror 3,2,1
	bc 4,3,.L232
	li 0,5
.L232:
	stw 0,80(3)
.L231:
	lis 9,.LC85@ha
	lis 11,.LC87@ha
	la 9,.LC85@l(9)
	la 11,.LC87@l(11)
	lfs 0,0(9)
	lis 0,0x3f80
	lfs 10,0(11)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lis 11,deathmatch@ha
	fsubs 0,11,0
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
	lfs 11,0(9)
	fmuls 0,0,10
	lwz 9,deathmatch@l(11)
	stfs 13,468(3)
	stw 0,24(1)
	stfs 11,16(1)
	stfs 11,20(1)
	lfs 13,20(9)
	fctiwz 12,0
	fcmpu 0,13,11
	stfd 12,40(1)
	lwz 7,44(1)
	srawi 9,7,31
	subf 9,7,9
	srawi 9,9,31
	addi 0,9,1
	and 9,7,9
	or 7,9,0
	mulli 7,7,30
	bc 12,2,.L236
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 11,44(1)
	andi. 0,11,8
	bc 4,2,.L217
.L236:
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
	b .L217
.L230:
	li 0,3
.L239:
	stw 0,80(3)
.L217:
	lwz 0,52(1)
	mtlr 0
	la 1,48(1)
	blr
.Lfe6:
	.size	 P_FallingDamage,.Lfe6-P_FallingDamage
	.section	".rodata"
	.align 2
.LC88:
	.string	"unknown penalty %i!\n"
	.align 2
.LC89:
	.string	"%s was penalized by execution for killing a fellow teammate.\n"
	.align 2
.LC90:
	.string	"%s was penalized by execution for spawn camping.\n"
	.align 2
.LC91:
	.string	"%s was penalized by execution for changing alliance.\n"
	.section	".text"
	.align 2
	.globl P_PenaltyCheck
	.type	 P_PenaltyCheck,@function
P_PenaltyCheck:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lwz 5,84(29)
	lwz 0,4608(5)
	cmpwi 0,0,0
	bc 12,2,.L241
	cmpwi 0,0,2
	bc 12,2,.L246
	bc 12,1,.L249
	cmpwi 0,0,1
	bc 12,2,.L245
	b .L244
.L249:
	cmpwi 0,0,3
	bc 12,2,.L247
.L244:
	lis 11,gi+8@ha
	lwz 9,84(29)
	lis 5,.LC88@ha
	lwz 0,gi+8@l(11)
	la 5,.LC88@l(5)
	mr 3,29
	lwz 6,4608(9)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 6,0
	b .L243
.L245:
	lis 9,gi@ha
	lis 4,.LC89@ha
	lwz 0,gi@l(9)
	la 4,.LC89@l(4)
	b .L250
.L246:
	lis 9,gi@ha
	lis 4,.LC90@ha
	lwz 0,gi@l(9)
	la 4,.LC90@l(4)
	b .L250
.L247:
	lis 9,gi@ha
	lis 4,.LC91@ha
	lwz 0,gi@l(9)
	la 4,.LC91@l(4)
.L250:
	addi 5,5,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	li 6,100
.L243:
	lwz 7,84(29)
	lis 9,g_edicts@ha
	li 11,0
	lis 0,0x3f80
	lwz 4,g_edicts@l(9)
	li 10,0
	mr 3,29
	stw 11,20(1)
	lis 8,vec3_origin@ha
	stw 0,24(1)
	li 29,39
	mr 9,6
	stw 11,16(1)
	la 8,vec3_origin@l(8)
	mr 5,4
	stw 10,4608(7)
	addi 6,1,16
	stw 10,8(1)
	addi 7,3,4
	stw 29,12(1)
	bl T_Damage
.L241:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 P_PenaltyCheck,.Lfe7-P_PenaltyCheck
	.section	".rodata"
	.align 2
.LC92:
	.string	"Health: %i"
	.align 2
.LC93:
	.string	"i_medic"
	.align 3
.LC94:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC95:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl P_ShowID
	.type	 P_ShowID,@function
P_ShowID:
	stwu 1,-160(1)
	mflr 0
	stmw 27,140(1)
	stw 0,164(1)
	mr 31,3
	lwz 0,512(31)
	lis 11,0x4330
	lis 10,.LC94@ha
	la 10,.LC94@l(10)
	lfs 13,12(31)
	addi 27,1,88
	xoris 0,0,0x8000
	lfd 11,0(10)
	addi 29,1,72
	stw 0,132(1)
	addi 28,1,104
	li 6,0
	stw 11,128(1)
	mr 4,27
	li 5,0
	lfd 0,128(1)
	lfs 10,4(31)
	lfs 12,8(31)
	fsub 0,0,11
	lwz 3,84(31)
	stfs 10,72(1)
	stfs 12,76(1)
	addi 3,3,4264
	frsp 0,0
	fadds 13,13,0
	stfs 13,80(1)
	bl AngleVectors
	lis 9,.LC95@ha
	mr 4,27
	la 9,.LC95@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 9,gi+48@ha
	mr 4,29
	lwz 0,gi+48@l(9)
	mr 7,28
	addi 3,1,8
	li 9,-1
	li 5,0
	li 6,0
	mr 8,31
	mtlr 0
	blrl
	lwz 9,60(1)
	lwz 10,84(9)
	cmpwi 0,10,0
	bc 12,2,.L252
	lwz 0,996(31)
	cmpwi 0,0,0
	bc 12,2,.L253
	lwz 0,3448(10)
	cmpwi 0,0,0
	bc 12,2,.L253
	lwz 0,3464(10)
	cmpwi 0,0,0
	bc 12,2,.L253
	lwz 10,84(31)
	lis 9,g_edicts@ha
	li 11,1
	lwz 8,g_edicts@l(9)
	lis 0,0xefdf
	li 7,0
	sth 11,154(10)
	ori 0,0,49023
	lwz 9,60(1)
	lwz 10,84(31)
	subf 9,8,9
	mullw 9,9,0
	srawi 9,9,3
	addi 9,9,1311
	sth 9,156(10)
	lwz 11,84(31)
	sth 7,158(11)
	lwz 9,84(31)
	sth 7,160(9)
	b .L261
.L253:
	lwz 10,84(31)
	lwz 9,3464(10)
	cmpwi 0,9,8
	bc 12,2,.L256
	lwz 0,3480(10)
	cmpwi 0,0,0
	bc 12,2,.L261
	lwz 8,3448(10)
	cmpwi 0,8,0
	bc 12,2,.L261
	cmpwi 0,9,0
	bc 12,2,.L261
	lwz 9,60(1)
	lwz 9,84(9)
	lwz 11,3448(9)
	cmpwi 0,11,0
	bc 12,2,.L261
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L261
	lwz 9,84(8)
	lwz 0,84(11)
	cmpw 0,9,0
	bc 4,2,.L261
.L256:
	li 0,1
	lis 30,g_edicts@ha
	sth 0,154(10)
	lis 28,0xefdf
	lwz 10,g_edicts@l(30)
	ori 28,28,49023
	lwz 9,60(1)
	lwz 11,84(31)
	subf 9,10,9
	mullw 9,9,28
	srawi 9,9,3
	addi 9,9,1311
	sth 9,156(11)
	lwz 9,84(31)
	lwz 0,3464(9)
	cmpwi 0,0,8
	bc 4,2,.L257
	subf 29,10,31
	lwz 11,60(1)
	lis 9,gi@ha
	mullw 29,29,28
	lis 3,.LC92@ha
	la 27,gi@l(9)
	lwz 4,484(11)
	la 3,.LC92@l(3)
	srawi 29,29,3
	addi 29,29,1567
	crxor 6,6,6
	bl va
	lwz 9,24(27)
	mr 4,3
	mr 3,29
	mtlr 9
	blrl
	lwz 9,g_edicts@l(30)
	lwz 11,84(31)
	subf 9,9,31
	mullw 9,9,28
	srawi 9,9,3
	addi 9,9,1567
	sth 9,158(11)
	lwz 4,60(1)
	lwz 9,484(4)
	lwz 0,488(4)
	cmpw 0,9,0
	bc 4,0,.L258
	mr 3,31
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L258
	lwz 0,40(27)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,160(9)
	b .L261
.L258:
	lwz 9,84(31)
	li 0,0
	sth 0,160(9)
	b .L261
.L257:
	li 0,0
	sth 0,158(9)
	lwz 9,84(31)
	sth 0,160(9)
	b .L261
.L252:
	lwz 9,84(31)
	sth 10,154(9)
	lwz 11,84(31)
	sth 10,156(11)
	lwz 9,84(31)
	sth 10,158(9)
	lwz 11,84(31)
	sth 10,160(11)
.L261:
	lwz 0,164(1)
	mtlr 0
	lmw 27,140(1)
	la 1,160(1)
	blr
.Lfe8:
	.size	 P_ShowID,.Lfe8-P_ShowID
	.section	".rodata"
	.align 2
.LC96:
	.string	"player/lava_in.wav"
	.align 2
.LC97:
	.string	"player/watr_in.wav"
	.align 2
.LC98:
	.string	"players/cloth.wav"
	.align 2
.LC99:
	.string	"player/watr_out.wav"
	.align 2
.LC100:
	.string	"player/watr_un.wav"
	.align 2
.LC101:
	.string	"player/gasp1.wav"
	.align 2
.LC102:
	.string	"player/gasp2.wav"
	.align 2
.LC103:
	.string	"player/u_breath1.wav"
	.align 2
.LC104:
	.string	"player/u_breath2.wav"
	.align 2
.LC105:
	.string	"*drown1.wav"
	.align 2
.LC106:
	.string	"*gurp1.wav"
	.align 2
.LC107:
	.string	"*gurp2.wav"
	.align 2
.LC108:
	.long 0x41400000
	.align 3
.LC109:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC110:
	.long 0x3f800000
	.align 2
.LC111:
	.long 0x0
	.align 2
.LC112:
	.long 0x41300000
	.align 2
.LC113:
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
	lis 27,current_player@ha
	lwz 3,current_player@l(9)
	lwz 0,264(3)
	cmpwi 0,0,1
	bc 4,2,.L263
	lis 7,.LC108@ha
	lis 9,level+4@ha
	la 7,.LC108@l(7)
	lfs 0,level+4@l(9)
	lfs 13,0(7)
	fadds 0,0,13
	stfs 0,408(3)
	b .L262
.L263:
	lis 11,current_client@ha
	lwz 0,616(3)
	lis 8,level@ha
	lwz 9,current_client@l(11)
	lis 7,.LC109@ha
	lwz 30,620(3)
	lis 11,0x4330
	la 7,.LC109@l(7)
	lwz 31,4308(9)
	lwz 25,4312(9)
	stw 0,4312(9)
	stw 30,4308(9)
	lwz 0,level@l(8)
	lfd 13,0(7)
	xoris 0,0,0x8000
	lfs 11,4352(9)
	stw 0,36(1)
	stw 11,32(1)
	lfd 0,32(1)
	lfs 12,4348(9)
	lwz 0,616(3)
	fsub 0,0,13
	andi. 9,0,8
	frsp 0,0
	fcmpu 7,11,0
	fcmpu 6,12,0
	mfcr 24
	rlwinm 26,24,30,1
	rlwinm 24,24,26,1
	bc 12,2,.L264
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	lwz 4,g_edicts@l(9)
	la 6,vec3_origin@l(6)
	li 0,0
	slwi 9,30,1
	li 11,19
	stw 0,8(1)
	add 9,9,30
	stw 11,12(1)
	mr 5,4
	addi 7,3,4
	mr 8,6
	li 10,0
	bl T_Damage
	b .L262
.L264:
	subfic 0,31,0
	adde 9,0,31
	addic 7,30,-1
	subfe 0,7,30
	and. 10,9,0
	bc 12,2,.L265
	li 5,0
	addi 4,3,4
	bl PlayerNoise
	lwz 28,current_player@l(27)
	lwz 0,616(28)
	andi. 7,0,8
	bc 12,2,.L266
	lis 29,gi@ha
	lis 3,.LC96@ha
	la 29,gi@l(29)
	la 3,.LC96@l(3)
	b .L307
.L266:
	andi. 7,0,16
	bc 12,2,.L268
	lis 29,gi@ha
	lis 3,.LC97@ha
	la 29,gi@l(29)
	la 3,.LC97@l(3)
.L307:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L267
.L268:
	andi. 7,0,32
	bc 12,2,.L267
	lis 29,gi@ha
	lis 3,.LC97@ha
	la 29,gi@l(29)
	la 3,.LC97@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L267:
	lis 11,current_player@ha
	lis 7,.LC110@ha
	lwz 9,current_player@l(11)
	lis 10,level+4@ha
	la 7,.LC110@l(7)
	lfs 13,0(7)
	lwz 0,268(9)
	ori 0,0,8
	stw 0,268(9)
	lfs 0,level+4@l(10)
	fsubs 0,0,13
	stfs 0,472(9)
.L265:
	cmpwi 0,30,0
	addic 10,31,-1
	subfe 9,10,31
	mcrf 3,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 11,9,0
	bc 12,2,.L271
	lis 9,current_player@ha
	li 5,0
	lwz 3,current_player@l(9)
	addi 4,3,4
	bl PlayerNoise
	andi. 0,25,8
	bc 12,2,.L272
	lis 29,gi@ha
	lis 3,.LC98@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC98@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L273
.L272:
	lis 29,gi@ha
	lis 3,.LC99@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC99@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L273:
	lis 9,current_player@ha
	lwz 11,current_player@l(9)
	lwz 0,268(11)
	rlwinm 0,0,0,29,27
	stw 0,268(11)
.L271:
	cmpwi 0,30,3
	xori 0,31,3
	addic 7,0,-1
	subfe 9,7,0
	mcrf 4,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 10,9,0
	bc 12,2,.L274
	lis 29,gi@ha
	lis 3,.LC100@ha
	la 29,gi@l(29)
	la 3,.LC100@l(3)
	lwz 11,36(29)
	lis 9,current_player@ha
	lwz 28,current_player@l(9)
	mtlr 11
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,4
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L274:
	xori 0,30,3
	xori 11,31,3
	subfic 7,11,0
	adde 11,7,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L275
	lis 9,current_player@ha
	lis 11,level+4@ha
	lwz 28,current_player@l(9)
	lfs 12,level+4@l(11)
	lfs 13,408(28)
	fcmpu 0,13,12
	bc 4,0,.L276
	lis 29,gi@ha
	lis 3,.LC101@ha
	la 29,gi@l(29)
	la 3,.LC101@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	lwz 3,current_player@l(27)
	li 5,0
	addi 4,3,4
	bl PlayerNoise
	b .L275
.L276:
	lis 7,.LC112@ha
	la 7,.LC112@l(7)
	lfs 0,0(7)
	fadds 0,12,0
	fcmpu 0,13,0
	bc 4,0,.L275
	lis 29,gi@ha
	lis 3,.LC102@ha
	la 29,gi@l(29)
	la 3,.LC102@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L275:
	bc 4,18,.L279
	or. 0,24,26
	bc 12,2,.L280
	lis 8,level@ha
	lis 7,.LC113@ha
	la 7,.LC113@l(7)
	la 9,level@l(8)
	lfs 13,0(7)
	lis 11,current_player@ha
	lfs 0,4(9)
	lis 7,0x4330
	lis 9,.LC109@ha
	lwz 28,current_player@l(11)
	la 9,.LC109@l(9)
	mr 11,10
	fadds 0,0,13
	lfd 11,0(9)
	lis 9,current_client@ha
	lwz 6,current_client@l(9)
	stfs 0,408(28)
	lis 9,0x51eb
	lwz 0,level@l(8)
	ori 9,9,34079
	lfs 13,4348(6)
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
	bc 4,2,.L280
	lwz 0,4316(6)
	cmpwi 0,0,0
	bc 4,2,.L282
	lis 29,gi@ha
	lis 3,.LC103@ha
	la 29,gi@l(29)
	la 3,.LC103@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L283
.L282:
	lis 29,gi@ha
	lis 3,.LC104@ha
	la 29,gi@l(29)
	la 3,.LC104@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L283:
	lis 9,current_client@ha
	lis 11,current_player@ha
	lwz 10,current_client@l(9)
	li 5,0
	lwz 3,current_player@l(11)
	lwz 0,4316(10)
	addi 4,3,4
	xori 0,0,1
	stw 0,4316(10)
	bl PlayerNoise
.L280:
	lis 9,current_player@ha
	lis 11,level+4@ha
	lwz 10,current_player@l(9)
	lfs 13,level+4@l(11)
	lfs 0,408(10)
	fcmpu 0,0,13
	bc 4,0,.L291
	lwz 9,84(10)
	lfs 0,4304(9)
	fcmpu 0,0,13
	bc 4,0,.L291
	lwz 0,484(10)
	cmpwi 0,0,0
	bc 4,1,.L291
	lis 7,.LC110@ha
	la 7,.LC110@l(7)
	lfs 0,0(7)
	fadds 0,13,0
	stfs 0,4304(9)
	lwz 9,520(10)
	addi 9,9,2
	cmpwi 0,9,15
	stw 9,520(10)
	bc 4,1,.L286
	li 0,15
	stw 0,520(10)
.L286:
	lwz 28,current_player@l(27)
	lwz 9,484(28)
	lwz 0,520(28)
	cmpw 0,9,0
	bc 12,1,.L287
	lis 29,gi@ha
	lis 3,.LC105@ha
	la 29,gi@l(29)
	la 3,.LC105@l(3)
	b .L308
.L287:
	bl rand
	andi. 0,3,1
	bc 12,2,.L289
	lis 29,gi@ha
	lis 3,.LC106@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC106@l(3)
.L308:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L288
.L289:
	lis 29,gi@ha
	lis 3,.LC107@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC107@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L288:
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
	lwz 9,520(11)
	mr 3,11
	mr 8,6
	stfs 0,468(11)
	addi 7,3,4
	mr 5,4
	stw 0,8(1)
	stw 29,12(1)
	bl T_Damage
	b .L291
.L279:
	lis 7,.LC108@ha
	lis 9,level+4@ha
	la 7,.LC108@l(7)
	lfs 0,level+4@l(9)
	lis 11,current_player@ha
	lfs 13,0(7)
	li 0,2
	lwz 9,current_player@l(11)
	fadds 0,0,13
	stw 0,520(9)
	stfs 0,408(9)
.L291:
	bc 12,14,.L262
	lis 9,current_player@ha
	lwz 11,current_player@l(9)
	lwz 0,616(11)
	andi. 9,0,24
	bc 12,2,.L262
	andi. 10,0,8
	bc 12,2,.L293
	lwz 0,484(11)
	cmpwi 0,0,0
	bc 4,1,.L294
	lis 9,level+4@ha
	lfs 13,468(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L294
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 7,.LC109@ha
	la 7,.LC109@l(7)
	lis 9,current_client@ha
	xoris 0,0,0x8000
	lfd 12,0(7)
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	lwz 10,current_client@l(9)
	fsub 0,0,12
	lfs 13,4344(10)
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L294
	bl rand
	bl srand
	bl rand
	lis 0,0x51eb
	srawi 11,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 9,11,0
	mulli 9,9,100
	subf 9,9,3
	addi 0,9,-1
	cmplwi 0,0,23
	bc 12,1,.L295
	lis 29,gi@ha
	lis 3,.LC1@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	b .L309
.L295:
	addi 0,9,-26
	cmplwi 0,0,23
	bc 12,1,.L297
	lis 29,gi@ha
	lis 3,.LC2@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	b .L309
.L297:
	addi 0,9,-51
	cmplwi 0,0,23
	bc 12,1,.L299
	lis 29,gi@ha
	lis 3,.LC3@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	b .L309
.L299:
	addi 0,9,-76
	cmplwi 0,0,23
	bc 12,1,.L301
	lis 29,gi@ha
	lis 3,.LC4@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC4@l(3)
.L309:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,1
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L296
.L301:
	lis 29,gi@ha
	lis 3,.LC1@ha
	lwz 28,current_player@l(27)
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC110@ha
	lis 9,.LC110@ha
	lis 10,.LC111@ha
	mr 5,3
	la 7,.LC110@l(7)
	la 9,.LC110@l(9)
	mtlr 0
	la 10,.LC111@l(10)
	li 4,1
	lfs 1,0(7)
	mr 3,28
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L296:
	lis 7,.LC110@ha
	lis 11,level+4@ha
	la 7,.LC110@l(7)
	lfs 0,level+4@l(11)
	lis 9,current_player@ha
	lfs 13,0(7)
	lwz 11,current_player@l(9)
	fadds 0,0,13
	stfs 0,468(11)
.L294:
	cmpwi 0,26,0
	bc 12,2,.L303
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
	b .L293
.L303:
	lis 9,current_player@ha
	lis 11,g_edicts@ha
	stw 26,8(1)
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
.L293:
	lis 9,current_player@ha
	lwz 3,current_player@l(9)
	lwz 0,616(3)
	andi. 7,0,16
	bc 12,2,.L262
	cmpwi 0,26,0
	bc 4,2,.L262
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	stw 26,8(1)
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
.L262:
	lwz 0,84(1)
	lwz 12,44(1)
	mtlr 0
	lmw 24,48(1)
	mtcrf 24,12
	la 1,80(1)
	blr
.Lfe9:
	.size	 P_WorldEffects,.Lfe9-P_WorldEffects
	.section	".rodata"
	.align 2
.LC114:
	.long 0x0
	.align 3
.LC115:
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
	lwz 0,484(31)
	stw 9,68(31)
	cmpwi 0,0,0
	stw 9,64(31)
	bc 4,1,.L310
	lis 9,level@ha
	lis 11,.LC114@ha
	la 11,.LC114@l(11)
	la 9,level@l(9)
	lfs 13,0(11)
	lfs 0,204(9)
	fcmpu 0,0,13
	bc 4,2,.L310
	lfs 13,4(9)
	lfs 0,504(31)
	fcmpu 0,0,13
	bc 4,1,.L313
	bl PowerArmorType
	cmpwi 0,3,1
	bc 4,2,.L314
	lwz 0,64(31)
	ori 0,0,512
	stw 0,64(31)
	b .L313
.L314:
	cmpwi 0,3,2
	bc 4,2,.L313
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,2048
	stw 0,64(31)
	stw 9,68(31)
.L313:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC115@ha
	lfs 12,4552(10)
	xoris 0,0,0x8000
	la 11,.LC115@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L317
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	andi. 9,0,2
	bc 12,2,.L317
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,1024
	stw 0,64(31)
	stw 9,68(31)
.L317:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC115@ha
	lfs 12,4340(10)
	xoris 0,0,0x8000
	la 11,.LC115@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L319
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,30
	bc 12,1,.L321
	andi. 9,0,2
	bc 12,2,.L319
.L321:
	lwz 0,64(31)
	ori 0,0,32768
	stw 0,64(31)
.L319:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC115@ha
	lfs 12,4344(10)
	xoris 0,0,0x8000
	la 11,.LC115@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L322
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,30
	bc 12,1,.L324
	andi. 9,0,4
	bc 12,2,.L322
.L324:
	lwz 0,64(31)
	oris 0,0,0x1
	stw 0,64(31)
.L322:
	lwz 0,268(31)
	andi. 11,0,16
	bc 12,2,.L310
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,7168
	stw 0,64(31)
	stw 9,68(31)
.L310:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 G_SetClientEffects,.Lfe10-G_SetClientEffects
	.section	".rodata"
	.align 2
.LC116:
	.long 0x0
	.long 0x0
	.long 0xc3480000
	.align 2
.LC117:
	.long 0x0
	.long 0x0
	.long 0xbf800000
	.align 2
.LC119:
	.string	"foot/grass1.wav"
	.align 2
.LC120:
	.string	"foot/grass2.wav"
	.align 2
.LC121:
	.string	"foot/wood1.wav"
	.align 2
.LC122:
	.string	"foot/wood2.wav"
	.align 2
.LC123:
	.string	"foot/metal1.wav"
	.align 2
.LC124:
	.string	"foot/metal2.wav"
	.align 2
.LC125:
	.string	"foot/sand1.wav"
	.align 2
.LC126:
	.string	"foot/sand2.wav"
	.align 2
.LC127:
	.string	"player/step1.wav"
	.align 2
.LC128:
	.string	"player/step2.wav"
	.align 2
.LC129:
	.string	"player/step3.wav"
	.align 2
.LC130:
	.string	"player/step4.wav"
	.align 2
.LC118:
	.long 0x46fffe00
	.align 2
.LC131:
	.long 0x42480000
	.align 2
.LC132:
	.long 0x43480000
	.align 2
.LC133:
	.long 0x3f800000
	.align 3
.LC134:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC135:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC136:
	.long 0x40400000
	.align 3
.LC137:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC138:
	.long 0x3fe80000
	.long 0x0
	.align 2
.LC139:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetClientEvent
	.type	 G_SetClientEvent,@function
G_SetClientEvent:
	stwu 1,-240(1)
	mflr 0
	stfd 29,216(1)
	stfd 30,224(1)
	stfd 31,232(1)
	stmw 28,200(1)
	stw 0,244(1)
	lis 9,.LC116@ha
	mr 28,3
	lwz 11,.LC116@l(9)
	addi 29,1,8
	addi 31,28,4
	la 9,.LC116@l(9)
	mr 3,31
	lwz 0,4(9)
	mr 4,29
	mr 5,29
	lwz 10,8(9)
	lis 9,.LC131@ha
	stw 11,8(1)
	la 9,.LC131@l(9)
	stw 0,4(29)
	lfs 1,0(9)
	stw 10,8(29)
	bl VectorMA
	lis 9,gi@ha
	mr 7,29
	la 30,gi@l(9)
	addi 3,1,24
	lwz 11,48(30)
	mr 4,31
	li 5,0
	li 6,0
	mr 8,28
	li 9,-1
	mtlr 11
	blrl
	lwz 0,560(28)
	cmpwi 0,0,0
	bc 12,2,.L326
	lwz 0,672(28)
	cmpwi 0,0,1
	bc 4,2,.L326
	lis 11,current_client@ha
	lis 8,bobmove@ha
	lwz 10,current_client@l(11)
	lfs 12,bobmove@l(8)
	lis 11,bobcycle@ha
	lfs 0,4276(10)
	lwz 0,bobcycle@l(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,192(1)
	lwz 9,196(1)
	cmpw 0,9,0
	bc 12,2,.L326
	addi 3,28,380
	bl VectorLength
	lis 9,.LC132@ha
	lis 10,.LC133@ha
	la 9,.LC132@l(9)
	la 10,.LC133@l(10)
	lfs 0,0(9)
	addi 4,1,104
	lfs 13,0(10)
	lis 9,.LC117@ha
	lwz 11,.LC117@l(9)
	fdivs 30,1,0
	la 9,.LC117@l(9)
	lwz 10,8(9)
	lwz 0,4(9)
	stw 11,104(1)
	stw 0,4(4)
	stw 10,8(4)
	fcmpu 0,30,13
	bc 4,1,.L330
	lis 11,.LC133@ha
	la 11,.LC133@l(11)
	lfs 30,0(11)
.L330:
	lis 9,.LC131@ha
	addi 29,1,88
	la 9,.LC131@l(9)
	mr 3,31
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lwz 11,48(30)
	addi 3,1,120
	mr 4,31
	mr 7,29
	li 5,0
	li 6,0
	mr 8,28
	mtlr 11
	li 9,1
	blrl
	lwz 3,164(1)
	li 4,2
	bl Surface
	cmpwi 0,3,0
	bc 12,2,.L331
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,196(1)
	lis 10,.LC134@ha
	lis 11,.LC118@ha
	la 10,.LC134@l(10)
	stw 0,192(1)
	lfd 13,0(10)
	lfd 0,192(1)
	lis 10,.LC135@ha
	lfs 12,.LC118@l(11)
	la 10,.LC135@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L332
	lwz 0,36(30)
	lis 3,.LC119@ha
	la 3,.LC119@l(3)
	b .L354
.L332:
	lwz 0,36(30)
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	b .L354
.L331:
	lwz 3,164(1)
	li 4,3
	bl Surface
	cmpwi 0,3,0
	bc 12,2,.L335
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,196(1)
	lis 10,.LC134@ha
	lis 11,.LC118@ha
	la 10,.LC134@l(10)
	stw 0,192(1)
	lfd 13,0(10)
	lfd 0,192(1)
	lis 10,.LC135@ha
	lfs 12,.LC118@l(11)
	la 10,.LC135@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L336
	lwz 0,36(30)
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	b .L354
.L336:
	lwz 0,36(30)
	lis 3,.LC122@ha
	la 3,.LC122@l(3)
	b .L354
.L335:
	lwz 3,164(1)
	li 4,4
	bl Surface
	cmpwi 0,3,0
	bc 12,2,.L339
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,196(1)
	lis 10,.LC134@ha
	lis 11,.LC118@ha
	la 10,.LC134@l(10)
	stw 0,192(1)
	lfd 13,0(10)
	lfd 0,192(1)
	lis 10,.LC135@ha
	lfs 12,.LC118@l(11)
	la 10,.LC135@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L340
	lwz 0,36(30)
	lis 3,.LC123@ha
	la 3,.LC123@l(3)
	b .L354
.L340:
	lwz 0,36(30)
	lis 3,.LC124@ha
	la 3,.LC124@l(3)
	b .L354
.L339:
	lwz 3,164(1)
	li 4,1
	bl Surface
	cmpwi 0,3,0
	bc 12,2,.L343
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,196(1)
	lis 10,.LC134@ha
	lis 11,.LC118@ha
	la 10,.LC134@l(10)
	stw 0,192(1)
	lfd 13,0(10)
	lfd 0,192(1)
	lis 10,.LC135@ha
	lfs 12,.LC118@l(11)
	la 10,.LC135@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L344
	lwz 0,36(30)
	lis 3,.LC125@ha
	la 3,.LC125@l(3)
	b .L354
.L344:
	lwz 0,36(30)
	lis 3,.LC126@ha
	la 3,.LC126@l(3)
.L354:
	mtlr 0
	blrl
	mr 5,3
	lis 9,.LC136@ha
	la 9,.LC136@l(9)
	lfs 0,0(9)
	fdivs 30,30,0
	b .L334
.L343:
	bl rand
	lis 31,0x4330
	lis 9,.LC134@ha
	rlwinm 3,3,0,17,31
	la 9,.LC134@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC118@ha
	lis 10,.LC137@ha
	lfs 29,.LC118@l(11)
	la 10,.LC137@l(10)
	stw 3,196(1)
	stw 31,192(1)
	lfd 0,192(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L347
	lwz 0,36(30)
	lis 3,.LC127@ha
	la 3,.LC127@l(3)
	b .L357
.L347:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC135@ha
	stw 3,196(1)
	la 10,.LC135@l(10)
	stw 31,192(1)
	lfd 0,192(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L349
	lwz 0,36(30)
	lis 3,.LC128@ha
	la 3,.LC128@l(3)
	b .L357
.L349:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC138@ha
	stw 3,196(1)
	la 10,.LC138@l(10)
	stw 31,192(1)
	lfd 0,192(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L351
	lwz 0,36(30)
	lis 3,.LC129@ha
	la 3,.LC129@l(3)
	b .L357
.L351:
	lwz 0,36(30)
	lis 3,.LC130@ha
	la 3,.LC130@l(3)
.L357:
	mtlr 0
	blrl
	mr 5,3
.L334:
	lis 9,gi+16@ha
	lis 10,.LC139@ha
	fmr 1,30
	lwz 0,gi+16@l(9)
	la 10,.LC139@l(10)
	mr 3,28
	lis 9,.LC133@ha
	li 4,0
	lfs 3,0(10)
	la 9,.LC133@l(9)
	mtlr 0
	lfs 2,0(9)
	blrl
.L326:
	lwz 0,244(1)
	mtlr 0
	lmw 28,200(1)
	lfd 29,216(1)
	lfd 30,224(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe11:
	.size	 G_SetClientEvent,.Lfe11-G_SetClientEvent
	.section	".rodata"
	.align 2
.LC140:
	.string	"misc/pc_up.wav"
	.align 2
.LC141:
	.string	""
	.align 2
.LC142:
	.string	"weapon_flamethrower"
	.align 2
.LC143:
	.string	"weapons/flamer/fireitup.wav"
	.align 2
.LC144:
	.long 0x3f800000
	.align 2
.LC145:
	.long 0x40400000
	.align 2
.LC146:
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
	lwz 0,3440(11)
	cmpw 0,0,9
	bc 12,2,.L359
	stw 9,3440(11)
	li 0,0
	lwz 9,84(31)
	stw 0,3444(9)
.L359:
	lwz 10,84(31)
	lwz 9,3444(10)
	cmpwi 7,9,3
	addic 0,9,-1
	subfe 11,0,9
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 9,11,0
	bc 12,2,.L360
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 0,0,63
	bc 4,2,.L360
	lis 29,gi@ha
	stw 0,3444(10)
	lis 3,.LC140@ha
	la 29,gi@l(29)
	la 3,.LC140@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC144@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC144@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC145@ha
	la 9,.LC145@l(9)
	lfs 2,0(9)
	lis 9,.LC146@ha
	la 9,.LC146@l(9)
	lfs 3,0(9)
	blrl
.L360:
	lwz 9,84(31)
	lwz 3,1796(9)
	cmpwi 0,3,0
	bc 12,2,.L361
	lwz 3,0(3)
	b .L362
.L361:
	lis 9,.LC141@ha
	la 3,.LC141@l(9)
.L362:
	lwz 0,620(31)
	cmpwi 0,0,0
	bc 12,2,.L363
	lwz 0,616(31)
	andi. 9,0,24
	bc 12,2,.L363
	lis 9,snd_fry@ha
	lwz 0,snd_fry@l(9)
	b .L367
.L363:
	lis 4,.LC142@ha
	la 4,.LC142@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L365
	lis 9,gi+36@ha
	lis 3,.LC143@ha
	lwz 0,gi+36@l(9)
	la 3,.LC143@l(3)
	mtlr 0
	blrl
	stw 3,76(31)
	b .L364
.L365:
	lwz 9,84(31)
	lwz 0,4372(9)
	cmpwi 0,0,0
.L367:
	stw 0,76(31)
.L364:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 G_SetClientSound,.Lfe12-G_SetClientSound
	.section	".rodata"
	.align 2
.LC147:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetClientFrame
	.type	 G_SetClientFrame,@function
G_SetClientFrame:
	lwz 0,40(3)
	cmpwi 0,0,255
	bclr 4,2
	lis 10,.LC147@ha
	lis 9,xyspeed@ha
	lwz 11,84(3)
	la 10,.LC147@l(10)
	lfs 0,xyspeed@l(9)
	lfs 13,0(10)
	mr 5,11
	lwz 9,672(3)
	lwz 0,4332(11)
	fcmpu 7,0,13
	xori 9,9,2
	subfic 10,9,0
	adde 9,10,9
	cmpw 0,9,0
	crnor 31,30,30
	mfcr 7
	rlwinm 7,7,0,1
	bc 12,2,.L375
	lwz 0,4328(11)
	cmpwi 0,0,4
	bc 4,1,.L376
.L375:
	lwz 0,4336(11)
	lwz 8,4328(11)
	cmpw 0,7,0
	bc 12,2,.L377
	cmpwi 0,8,0
	bc 12,2,.L376
.L377:
	lwz 0,560(3)
	cmpwi 0,0,0
	mr 6,0
	bc 4,2,.L378
	cmpwi 0,8,1
	bc 4,1,.L376
.L378:
	cmpwi 0,8,-1
	bc 4,2,.L379
	lwz 10,56(3)
	lwz 0,4324(11)
	cmpw 0,10,0
	bc 4,1,.L381
	addi 0,10,-1
	stw 0,56(3)
	blr
.L379:
	lwz 10,56(3)
	lwz 0,4324(11)
	cmpw 0,10,0
	bc 4,0,.L381
	addi 0,10,1
	stw 0,56(3)
	blr
.L381:
	cmpwi 0,8,5
	bclr 12,2
	cmpwi 0,8,2
	bc 4,2,.L376
	cmpwi 0,6,0
	bclr 12,2
	li 0,1
	stw 0,4328(5)
	lwz 0,672(3)
	cmpwi 0,0,4
	bc 4,2,.L386
	lwz 9,84(3)
	li 0,198
	li 11,200
.L411:
	stw 0,56(3)
	stw 11,4324(9)
	blr
.L386:
	cmpwi 0,0,2
	bc 4,2,.L388
	lwz 9,84(3)
	li 0,135
	li 11,137
	b .L411
.L388:
	lwz 9,84(3)
	li 0,68
	li 11,71
	b .L411
.L376:
	li 0,0
	stw 9,4332(11)
	stw 0,4328(11)
	stw 7,4336(11)
	lwz 0,560(3)
	cmpwi 0,0,0
	bc 4,2,.L390
	li 0,2
	stw 0,4328(11)
	lwz 0,672(3)
	cmpwi 0,0,4
	bc 4,2,.L391
	lwz 0,56(3)
	cmpwi 0,0,199
	bc 12,2,.L392
	li 0,198
	stw 0,56(3)
.L392:
	li 0,199
	stw 0,4324(11)
	blr
.L391:
	cmpwi 0,0,2
	bc 4,2,.L394
	lwz 0,56(3)
	cmpwi 0,0,136
	bc 12,2,.L395
	li 0,135
	stw 0,56(3)
.L395:
	li 0,136
	stw 0,4324(11)
	blr
.L394:
	lwz 0,56(3)
	cmpwi 0,0,67
	bc 12,2,.L397
	li 0,66
	stw 0,56(3)
.L397:
	li 0,67
	stw 0,4324(11)
	blr
.L390:
	cmpwi 0,7,0
	bc 12,2,.L399
	cmpwi 0,9,0
	bc 12,2,.L400
	li 0,154
	li 9,159
.L412:
	stw 0,56(3)
	stw 9,4324(11)
	blr
.L400:
	lwz 0,672(3)
	cmpwi 0,0,4
	bc 4,2,.L402
	li 0,213
	li 9,220
	b .L412
.L402:
	li 0,40
	li 9,45
	b .L412
.L399:
	cmpwi 0,9,0
	bc 12,2,.L405
	li 0,135
	li 9,153
	b .L412
.L405:
	lwz 0,672(3)
	cmpwi 0,0,4
	bc 4,2,.L407
	li 0,198
	li 9,212
	b .L412
.L407:
	lwz 9,84(3)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L409
	li 0,47
	stw 0,56(3)
	stw 0,4324(11)
	blr
.L409:
	stw 0,56(3)
	li 0,39
	stw 0,4324(11)
	blr
.Lfe13:
	.size	 G_SetClientFrame,.Lfe13-G_SetClientFrame
	.section	".rodata"
	.align 2
.LC148:
	.long 0xc2820000
	.align 2
.LC149:
	.long 0x42820000
	.align 2
.LC150:
	.long 0xc2040000
	.align 2
.LC151:
	.long 0x42040000
	.section	".text"
	.align 2
	.globl FindOverlap
	.type	 FindOverlap,@function
FindOverlap:
	stwu 1,-32(1)
	mr. 4,4
	mr 10,3
	bc 12,2,.L414
	lis 11,g_edicts@ha
	lis 9,0xefdf
	lwz 0,g_edicts@l(11)
	ori 9,9,49023
	subf 0,0,4
	mullw 0,0,9
	srawi 4,0,3
	b .L415
.L414:
	li 4,0
.L415:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpw 0,4,0
	bc 4,0,.L417
	lis 9,g_edicts@ha
	mr 8,0
	mulli 11,4,1016
	lwz 0,g_edicts@l(9)
	lis 9,.LC148@ha
	addi 11,11,1016
	la 9,.LC148@l(9)
	add 3,11,0
	lfs 8,0(9)
	lis 9,.LC149@ha
	la 9,.LC149@l(9)
	lfs 9,0(9)
.L419:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 9,84(3)
	lwz 0,3448(9)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 0,3464(9)
	xor 9,3,10
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L418
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 0,496(3)
	cmpwi 0,0,2
	bc 12,2,.L418
	lfs 0,4(10)
	lis 9,.LC150@ha
	lfs 13,4(3)
	la 9,.LC150@l(9)
	lfs 12,8(10)
	lfs 11,12(10)
	fsubs 13,0,13
	lfs 10,0(9)
	stfs 13,8(1)
	fcmpu 0,13,10
	lfs 0,8(3)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(3)
	fsubs 11,11,0
	stfs 11,16(1)
	cror 3,2,1
	bc 4,3,.L418
	lis 11,.LC151@ha
	la 11,.LC151@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L418
	fcmpu 0,12,10
	cror 3,2,1
	bc 4,3,.L418
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L418
	fcmpu 0,11,8
	cror 3,2,1
	bc 4,3,.L418
	fcmpu 0,11,9
	cror 3,2,0
	bc 12,3,.L424
.L418:
	addi 4,4,1
	addi 3,3,1016
	cmpw 0,4,8
	bc 12,0,.L419
.L417:
	li 3,0
.L424:
	la 1,32(1)
	blr
.Lfe14:
	.size	 FindOverlap,.Lfe14-FindOverlap
	.section	".rodata"
	.align 3
.LC152:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC153:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC154:
	.long 0x0
	.align 3
.LC155:
	.long 0x40200000
	.long 0x0
	.align 3
.LC156:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC157:
	.long 0x43340000
	.align 2
.LC158:
	.long 0xc3b40000
	.align 2
.LC159:
	.long 0x40400000
	.align 2
.LC160:
	.long 0x40800000
	.align 2
.LC161:
	.long 0x40a00000
	.align 2
.LC162:
	.long 0x43520000
	.align 2
.LC163:
	.long 0x42c80000
	.align 2
.LC164:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientEndServerFrame
	.type	 ClientEndServerFrame,@function
ClientEndServerFrame:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,32(1)
	stw 0,68(1)
	mr 31,3
	lis 9,.LC154@ha
	lwz 10,84(31)
	la 9,.LC154@l(9)
	lis 11,current_client@ha
	lfs 12,0(9)
	lfs 0,4688(10)
	lis 9,current_player@ha
	stw 31,current_player@l(9)
	stw 10,current_client@l(11)
	fcmpu 0,0,12
	bc 4,1,.L427
	lis 9,.LC152@ha
	lfd 13,.LC152@l(9)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4688(10)
	lwz 9,84(31)
	lfs 0,4688(9)
	fcmpu 0,0,12
	bc 4,0,.L427
	stfs 12,4688(9)
.L427:
	lis 9,current_client@ha
	addi 30,31,380
	lwz 11,current_client@l(9)
	mr 6,30
	addi 7,31,4
	lis 9,.LC155@ha
	li 8,0
	addi 10,11,10
	la 9,.LC155@l(9)
	li 11,3
	lfd 11,0(9)
	mtctr 11
.L466:
	lfsx 0,8,7
	mr 11,9
	fmul 0,0,11
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	sth 9,-6(10)
	lfsx 0,8,6
	addi 8,8,4
	fmul 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,0(10)
	addi 10,10,2
	bdnz .L466
	lis 9,level@ha
	lis 11,.LC154@ha
	la 11,.LC154@l(11)
	la 29,level@l(9)
	lfs 30,0(11)
	lfs 0,204(29)
	fcmpu 0,0,30
	bc 12,2,.L434
	lis 9,.LC156@ha
	lis 0,0x42aa
	la 9,.LC156@l(9)
	mr 3,31
	lfd 13,0(9)
	lis 9,current_client@ha
	lwz 11,current_client@l(9)
	fadd 0,0,13
	stw 0,112(11)
	stfs 30,108(11)
	frsp 31,0
	bl G_SetStats
	lfs 0,4(29)
	fcmpu 0,0,31
	bc 4,0,.L435
	mr 3,31
	bl PMenu_Close
	lwz 11,84(31)
	li 0,0
	stw 0,3528(11)
	lwz 9,84(31)
	stw 0,3524(9)
	lwz 11,84(31)
	stw 0,3536(11)
	lwz 9,84(31)
	stw 0,3532(9)
.L435:
	lfs 0,4(29)
	fcmpu 0,0,31
	bc 4,2,.L426
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L438
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 12,2,.L437
.L438:
	lwz 9,84(31)
	li 0,1
	stw 0,3524(9)
.L437:
	mr 3,31
	bl DDayScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L426
.L434:
	lwz 3,84(31)
	lis 4,forward@ha
	lis 5,right@ha
	lis 6,up@ha
	la 5,right@l(5)
	la 6,up@l(6)
	addi 3,3,4264
	la 4,forward@l(4)
	bl AngleVectors
	bl P_WorldEffects
	lwz 9,84(31)
	lis 11,.LC157@ha
	la 11,.LC157@l(11)
	lfs 0,0(11)
	lfs 12,4264(9)
	fcmpu 0,12,0
	bc 4,1,.L439
	lis 9,.LC158@ha
	lis 11,.LC159@ha
	la 9,.LC158@l(9)
	la 11,.LC159@l(11)
	lfs 0,0(9)
	lfs 13,0(11)
	fadds 0,12,0
	fdivs 0,0,13
	b .L467
.L439:
	lis 9,.LC159@ha
	la 9,.LC159@l(9)
	lfs 0,0(9)
	fdivs 0,12,0
.L467:
	stfs 0,16(31)
	lwz 9,84(31)
	lis 11,.LC154@ha
	lis 0,0x3f80
	la 11,.LC154@l(11)
	lfs 12,380(31)
	lfs 9,0(11)
	lfs 13,4268(9)
	lis 11,right@ha
	la 10,right@l(11)
	stfs 9,24(31)
	stfs 13,20(31)
	lfs 13,4(10)
	lfs 0,4(30)
	lfs 10,right@l(11)
	lfs 11,8(30)
	fmuls 0,0,13
	lfs 13,8(10)
	fmadds 12,12,10,0
	fmadds 13,11,13,12
	fcmpu 0,13,9
	bc 4,0,.L441
	lis 0,0xbf80
.L441:
	lis 8,sv_rollspeed@ha
	fabs 13,13
	lis 9,sv_rollangle@ha
	lwz 11,sv_rollspeed@l(8)
	lwz 10,sv_rollangle@l(9)
	lfs 12,20(11)
	lfs 0,20(10)
	fcmpu 0,13,12
	bc 4,0,.L443
	fmuls 0,13,0
	fdivs 13,0,12
	b .L444
.L443:
	fmr 13,0
.L444:
	lfs 0,384(31)
	lis 9,.LC160@ha
	lis 29,xyspeed@ha
	stw 0,8(1)
	la 9,.LC160@l(9)
	lfs 12,8(1)
	fmuls 0,0,0
	lfs 1,380(31)
	fmuls 13,13,12
	lfs 12,0(9)
	fmadds 1,1,1,0
	fmuls 13,13,12
	stfs 13,24(31)
	bl sqrt
	lis 9,.LC161@ha
	frsp 1,1
	la 9,.LC161@l(9)
	lfs 0,0(9)
	stfs 1,xyspeed@l(29)
	fcmpu 0,1,0
	bc 4,0,.L446
	lis 11,current_client@ha
	li 0,0
	lwz 10,current_client@l(11)
	lis 9,bobmove@ha
	stw 0,bobmove@l(9)
	stw 0,4276(10)
	b .L447
.L446:
	lwz 0,560(31)
	lis 9,bobmove@ha
	cmpwi 0,0,0
	bc 12,2,.L447
	lis 11,.LC162@ha
	la 11,.LC162@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L449
	lis 0,0x3e80
	b .L468
.L449:
	lis 11,.LC163@ha
	la 11,.LC163@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,1,.L451
	lis 0,0x3e00
	b .L468
.L451:
	lis 0,0x3d80
.L468:
	stw 0,bobmove@l(9)
.L447:
	lis 11,current_client@ha
	lis 10,bobmove@ha
	lwz 9,current_client@l(11)
	lfs 13,bobmove@l(10)
	lfs 0,4276(9)
	lbz 0,16(9)
	fadds 0,0,13
	andi. 11,0,1
	fmr 13,0
	stfs 0,4276(9)
	bc 12,2,.L453
	lis 9,.LC160@ha
	la 9,.LC160@l(9)
	lfs 0,0(9)
	fmuls 13,13,0
.L453:
	lis 11,.LC153@ha
	lfd 1,.LC153@l(11)
	lis 10,bobcycle@ha
	lis 29,bobfracsin@ha
	fctiwz 0,13
	fmul 1,13,1
	stfd 0,24(1)
	lwz 9,28(1)
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
	bl P_ExplosionEffects
	mr 3,31
	bl P_PenaltyCheck
	mr 3,31
	bl P_ShowID
	mr 3,31
	bl SV_CalcViewOffset
	mr 3,31
	bl SV_CalcGunOffset
	mr 3,31
	bl SV_CalcBlend
	mr 3,31
	bl G_SetStats
	mr 3,31
	bl G_SetClientEvent
	mr 3,31
	bl G_SetClientEffects
	mr 3,31
	bl G_SetClientSound
	mr 3,31
	bl G_SetClientFrame
	lfs 0,380(31)
	li 0,0
	lwz 11,84(31)
	stfs 0,4292(11)
	lfs 0,384(31)
	lwz 9,84(31)
	stfs 0,4296(9)
	lfs 0,388(31)
	lwz 11,84(31)
	stfs 0,4300(11)
	lwz 9,84(31)
	lfs 0,28(9)
	stfs 0,4280(9)
	lwz 11,84(31)
	lfs 0,32(11)
	stfs 0,4284(11)
	lwz 10,84(31)
	lfs 0,36(10)
	stfs 0,4288(10)
	lwz 9,84(31)
	stw 0,4212(9)
	stw 0,4220(9)
	stw 0,4216(9)
	lwz 11,84(31)
	stw 0,4200(11)
	stw 0,4208(11)
	stw 0,4204(11)
	lwz 11,84(31)
	lwz 0,3524(11)
	cmpwi 0,0,0
	bc 12,2,.L454
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,31
	bc 4,2,.L454
	lwz 0,3548(11)
	cmpwi 0,0,0
	bc 12,2,.L455
	mr 3,31
	bl PMenu_Update
	b .L456
.L455:
	mr 3,31
	bl DDayScoreboardMessage
.L456:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,0
	mtlr 0
	blrl
.L454:
	lwz 0,248(31)
	cmpwi 0,0,1
	bc 4,2,.L426
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L458
	lwz 0,3448(9)
	cmpwi 0,0,0
	bc 12,2,.L458
	lwz 0,3464(9)
	cmpwi 0,0,8
	bc 4,2,.L458
	lis 9,.LC164@ha
	lis 11,invuln_medic@ha
	la 9,.LC164@l(9)
	lfs 13,0(9)
	lwz 9,invuln_medic@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L426
.L458:
	mr 3,31
	li 4,0
	bl FindOverlap
	mr. 29,3
	bc 4,2,.L459
	li 0,2
	lis 9,gi+72@ha
	stw 0,248(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	b .L426
.L459:
	lis 9,gi@ha
	li 28,1
	la 30,gi@l(9)
.L465:
	lwz 0,248(29)
	cmpwi 0,0,2
	bc 4,2,.L464
	stw 28,248(29)
	mr 3,29
	lwz 9,72(30)
	mtlr 9
	blrl
.L464:
	mr 4,29
	mr 3,31
	bl FindOverlap
	mr. 29,3
	bc 4,2,.L465
.L426:
	lwz 0,68(1)
	mtlr 0
	lmw 28,32(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 ClientEndServerFrame,.Lfe15-ClientEndServerFrame
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.section	".rodata"
	.align 2
.LC165:
	.long 0x0
	.align 2
.LC166:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SV_AddBlend
	.type	 SV_AddBlend,@function
SV_AddBlend:
	lis 9,.LC165@ha
	la 9,.LC165@l(9)
	lfs 0,0(9)
	fcmpu 0,4,0
	cror 3,2,0
	bclr 12,3
	lis 9,.LC166@ha
	lfs 12,12(3)
	la 9,.LC166@l(9)
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
.Lfe16:
	.size	 SV_AddBlend,.Lfe16-SV_AddBlend
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
.LC167:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_CalcRoll
	.type	 SV_CalcRoll,@function
SV_CalcRoll:
	stwu 1,-32(1)
	lis 9,right@ha
	lfs 12,4(4)
	lis 10,.LC167@ha
	la 11,right@l(9)
	lfs 10,right@l(9)
	la 10,.LC167@l(10)
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
.Lfe17:
	.size	 SV_CalcRoll,.Lfe17-SV_CalcRoll
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
