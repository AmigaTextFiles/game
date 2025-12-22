	.file	"scanner.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Scout"
	.align 2
.LC1:
	.string	"Assasin"
	.align 2
.LC2:
	.string	"Soldier"
	.align 2
.LC3:
	.string	"Demolition Man"
	.align 2
.LC4:
	.string	"Heavy Weapons Guy"
	.align 2
.LC5:
	.string	"Energy trooper"
	.align 2
.LC6:
	.string	"Engineer"
	.align 2
.LC7:
	.string	"Commando"
	.align 2
.LC8:
	.string	"Berserk"
	.align 2
.LC9:
	.string	"Spy"
	.align 2
.LC10:
	.string	"-> Scout <-"
	.align 2
.LC11:
	.string	"-> Assasin <-"
	.align 2
.LC12:
	.string	"-> Soldier <-"
	.align 2
.LC13:
	.string	"-> Demolition Man <-"
	.align 2
.LC14:
	.string	"-> Heavy Weapons Guy <-"
	.align 2
.LC15:
	.string	"-> Energy Trooper <-"
	.align 2
.LC16:
	.string	"-> Engineer <-"
	.align 2
.LC17:
	.string	"-> Commando <-"
	.align 2
.LC18:
	.string	"-> Berserk <-"
	.align 2
.LC19:
	.string	"-> Spy <-"
	.align 2
.LC20:
	.ascii	"xv 0 yv 16 cstring2 \"%20s\" xv 0 yv 24 cstring2 \"%20s\" xv"
	.ascii	" 0 yv 32 cs"
	.string	"tring2 \"%20s\" xv 0 yv 40 cstring2 \"%20s\" xv 0 yv 48 cstring2 \"%20s\" xv 0 yv 56 cstring2 \"%20s\" xv 0 yv 64 cstring2 \"%20s\" xv 0 yv 72 cstring2 \"%20s\" xv 0 yv 80 cstring2 \"%20s\" xv 0 yv 88 cstring2 \"%20s\" xv 0 yv 96 cstring2 \"press your use button to spawn\" "
	.section	".text"
	.align 2
	.globl ShowClasses
	.type	 ShowClasses,@function
ShowClasses:
	stwu 1,-1088(1)
	mflr 0
	stmw 24,1056(1)
	stw 0,1092(1)
	mr 31,3
	lis 29,.LC4@ha
	lwz 12,84(31)
	lis 28,.LC0@ha
	lis 6,.LC1@ha
	lis 5,.LC2@ha
	lis 3,.LC3@ha
	lwz 0,1816(12)
	lis 11,.LC5@ha
	lis 10,.LC6@ha
	lis 8,.LC7@ha
	lis 7,.LC8@ha
	cmpwi 0,0,0
	lis 9,.LC9@ha
	mr 30,4
	la 24,.LC4@l(29)
	la 28,.LC0@l(28)
	la 27,.LC1@l(6)
	la 26,.LC2@l(5)
	la 25,.LC3@l(3)
	la 11,.LC5@l(11)
	la 10,.LC6@l(10)
	la 8,.LC7@l(8)
	la 4,.LC8@l(7)
	la 29,.LC9@l(9)
	bc 4,2,.L17
	li 0,1
	stw 0,1816(12)
.L17:
	lwz 9,84(31)
	lwz 3,1816(9)
	cmpwi 0,3,1
	bc 4,2,.L18
	lis 9,.LC10@ha
	la 28,.LC10@l(9)
.L18:
	cmpwi 0,3,2
	bc 4,2,.L19
	lis 9,.LC11@ha
	la 27,.LC11@l(9)
.L19:
	cmpwi 0,3,3
	bc 4,2,.L20
	lis 9,.LC12@ha
	la 26,.LC12@l(9)
.L20:
	cmpwi 0,3,4
	bc 4,2,.L21
	lis 9,.LC13@ha
	la 25,.LC13@l(9)
.L21:
	cmpwi 0,3,5
	bc 4,2,.L22
	lis 9,.LC14@ha
	la 24,.LC14@l(9)
.L22:
	cmpwi 0,3,6
	bc 4,2,.L23
	lis 9,.LC15@ha
	la 11,.LC15@l(9)
.L23:
	cmpwi 0,3,7
	bc 4,2,.L24
	lis 9,.LC16@ha
	la 10,.LC16@l(9)
.L24:
	cmpwi 0,3,8
	bc 4,2,.L25
	lis 9,.LC17@ha
	la 8,.LC17@l(9)
.L25:
	cmpwi 0,3,9
	bc 4,2,.L26
	lis 9,.LC18@ha
	la 4,.LC18@l(9)
.L26:
	cmpwi 0,3,10
	bc 4,2,.L27
	lis 9,.LC19@ha
	la 29,.LC19@l(9)
.L27:
	stw 10,12(1)
	lis 5,.LC20@ha
	addi 3,1,32
	stw 8,16(1)
	mr 6,28
	la 5,.LC20@l(5)
	stw 4,20(1)
	mr 7,27
	mr 8,26
	stw 29,24(1)
	mr 9,25
	mr 10,24
	stw 11,8(1)
	li 4,1024
	crxor 6,6,6
	bl Com_sprintf
	mr 3,30
	bl strlen
	mr 29,3
	addi 3,1,32
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L28
	mr 3,30
	addi 4,1,32
	bl strcat
.L28:
	lwz 0,1092(1)
	mtlr 0
	lmw 24,1056(1)
	la 1,1088(1)
	blr
.Lfe1:
	.size	 ShowClasses,.Lfe1-ShowClasses
	.section	".rodata"
	.align 2
.LC21:
	.string	"xv 80 yv 40 picn %s "
	.align 2
.LC22:
	.string	"scanner/scanner"
	.align 2
.LC23:
	.long 0x0
	.long 0x0
	.long 0xbf800000
	.align 2
.LC24:
	.string	"scanner/dot"
	.align 2
.LC25:
	.string	"scanner/quaddot"
	.align 2
.LC26:
	.string	"scanner/invdot"
	.align 2
.LC27:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC28:
	.string	"yv %i picn %s "
	.align 2
.LC29:
	.string	"scanner/up"
	.align 2
.LC30:
	.string	"scanner/down"
	.align 2
.LC31:
	.long 0x3d000000
	.align 2
.LC32:
	.long 0x40000000
	.align 2
.LC33:
	.long 0x42c80000
	.align 2
.LC34:
	.long 0x42a00000
	.align 2
.LC35:
	.long 0x43200000
	.align 2
.LC36:
	.long 0x42f00000
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ShowScanner
	.type	 ShowScanner,@function
ShowScanner:
	stwu 1,-240(1)
	mflr 0
	stfd 28,208(1)
	stfd 29,216(1)
	stfd 30,224(1)
	stfd 31,232(1)
	stmw 17,148(1)
	stw 0,244(1)
	lis 9,g_edicts@ha
	mr 27,4
	mr 28,3
	lis 5,.LC21@ha
	lwz 31,g_edicts@l(9)
	lis 6,.LC22@ha
	addi 3,1,8
	la 5,.LC21@l(5)
	la 6,.LC22@l(6)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	mr 3,27
	bl strlen
	mr 29,3
	addi 3,1,8
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L30
	mr 3,27
	addi 4,1,8
	bl strcat
.L30:
	lis 9,game+1544@ha
	li 23,0
	lwz 0,game+1544@l(9)
	lis 17,game@ha
	cmpw 0,23,0
	bc 4,0,.L32
	lis 10,.LC31@ha
	lis 11,.LC32@ha
	la 10,.LC31@l(10)
	la 11,.LC32@l(11)
	lis 9,.LC23@ha
	lfs 28,0(10)
	addi 24,1,104
	lfs 29,0(11)
	la 19,.LC23@l(9)
	addi 25,1,88
	lwz 18,.LC23@l(9)
	lis 20,.LC26@ha
	lis 21,.LC28@ha
.L34:
	addi 31,31,1268
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L33
	lwz 11,84(31)
	xor 9,31,28
	subfic 0,9,0
	adde 9,0,9
	subfic 10,11,0
	adde 0,10,11
	or. 22,0,9
	bc 4,2,.L33
	lwz 0,728(31)
	cmpwi 0,0,0
	bc 4,1,.L33
	lwz 0,1804(11)
	cmpwi 0,0,8
	bc 12,2,.L33
	lfs 13,4(31)
	lis 11,.LC33@ha
	lfs 12,4(28)
	li 0,0
	addi 29,1,72
	lfs 11,8(28)
	la 11,.LC33@l(11)
	mr 3,29
	lfs 0,12(28)
	fsubs 12,12,13
	lfs 30,0(11)
	stfs 12,72(1)
	lfs 13,8(31)
	fsubs 11,11,13
	stfs 11,76(1)
	lfs 13,12(31)
	stw 0,80(1)
	fsubs 0,0,13
	fmuls 0,0,28
	fctiwz 10,0
	stfd 10,136(1)
	lwz 26,140(1)
	bl VectorLength
	fmuls 31,1,28
	fcmpu 0,31,30
	cror 3,2,0
	bc 4,3,.L33
	lwz 0,8(19)
	mr 3,29
	lwz 9,4(19)
	stw 18,104(1)
	stw 0,8(24)
	stw 9,4(24)
	bl VectorNormalize
	lfs 1,20(28)
	mr 5,29
	mr 3,25
	mr 4,24
	bl RotatePointAroundVector
	lis 9,.LC34@ha
	mr 3,25
	la 9,.LC34@l(9)
	mr 4,25
	lfs 1,0(9)
	fmuls 1,31,1
	fdivs 1,1,30
	bl VectorScale
	lis 9,.LC35@ha
	lfs 13,92(1)
	lis 10,.LC36@ha
	la 9,.LC35@l(9)
	la 10,.LC36@l(10)
	lfs 0,88(1)
	lfs 10,0(9)
	lfs 9,0(10)
	lis 9,.LC24@ha
	lwz 0,908(31)
	mr 10,11
	la 29,.LC24@l(9)
	fadds 13,13,10
	fadds 0,0,9
	cmpwi 0,0,1
	fsubs 13,13,29
	fsubs 0,0,29
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,136(1)
	lwz 6,140(1)
	stfd 11,136(1)
	lwz 30,140(1)
	bc 4,2,.L39
	lis 9,.LC25@ha
	la 29,.LC25@l(9)
.L39:
	lis 9,level@ha
	lwz 10,84(31)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC37@ha
	lfs 12,3880(10)
	xoris 0,0,0x8000
	la 9,.LC37@l(9)
	stw 0,140(1)
	stw 8,136(1)
	lfd 13,0(9)
	lfd 0,136(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L40
	la 29,.LC26@l(20)
.L40:
	lwz 0,564(31)
	la 9,.LC26@l(20)
	lis 5,.LC27@ha
	addi 3,1,8
	la 5,.LC27@l(5)
	xori 0,0,1
	li 4,64
	srawi 10,0,31
	mr 7,30
	xor 8,10,0
	subf 8,8,10
	srawi 8,8,31
	andc 9,9,8
	and 8,29,8
	or 8,8,9
	crxor 6,6,6
	bl Com_sprintf
	mr 3,27
	bl strlen
	mr 29,3
	addi 3,1,8
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L42
	mr 3,27
	addi 4,1,8
	bl strcat
.L42:
	cmpwi 0,26,0
	stb 22,8(1)
	bc 4,0,.L43
	lis 7,.LC29@ha
	addi 6,30,-5
	la 7,.LC29@l(7)
	addi 3,1,8
	li 4,64
	la 5,.LC28@l(21)
	crxor 6,6,6
	bl Com_sprintf
	b .L44
.L43:
	bc 4,1,.L44
	lis 7,.LC30@ha
	addi 6,30,5
	la 7,.LC30@l(7)
	addi 3,1,8
	li 4,64
	la 5,.LC28@l(21)
	crxor 6,6,6
	bl Com_sprintf
.L44:
	lbz 0,8(1)
	cmpwi 0,0,0
	bc 12,2,.L33
	mr 3,27
	bl strlen
	mr 29,3
	addi 3,1,8
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L33
	mr 3,27
	addi 4,1,8
	bl strcat
.L33:
	la 9,game@l(17)
	addi 23,23,1
	lwz 0,1544(9)
	cmpw 0,23,0
	bc 12,0,.L34
.L32:
	lwz 0,244(1)
	mtlr 0
	lmw 17,148(1)
	lfd 28,208(1)
	lfd 29,216(1)
	lfd 30,224(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe2:
	.size	 ShowScanner,.Lfe2-ShowScanner
	.align 2
	.globl Toggle_Scanner
	.type	 Toggle_Scanner,@function
Toggle_Scanner:
	lwz 9,84(3)
	cmpwi 0,9,0
	bclr 12,2
	lwz 0,728(3)
	cmpwi 0,0,0
	bclr 4,1
	lwz 0,1864(9)
	xori 0,0,1
	andi. 11,0,1
	stw 0,1864(9)
	bc 12,2,.L11
	lwz 9,84(3)
	li 0,0
	stw 0,3616(9)
	lwz 11,84(3)
	stw 0,3612(11)
.L11:
	lwz 9,84(3)
	lwz 0,1864(9)
	ori 0,0,2
	stw 0,1864(9)
	blr
.Lfe3:
	.size	 Toggle_Scanner,.Lfe3-Toggle_Scanner
	.align 2
	.globl ClearScanner
	.type	 ClearScanner,@function
ClearScanner:
	li 0,0
	stw 0,1864(3)
	blr
.Lfe4:
	.size	 ClearScanner,.Lfe4-ClearScanner
	.align 2
	.globl ClearClasses
	.type	 ClearClasses,@function
ClearClasses:
	li 0,0
	stw 0,1868(3)
	blr
.Lfe5:
	.size	 ClearClasses,.Lfe5-ClearClasses
	.align 2
	.globl Toggle_Classes
	.type	 Toggle_Classes,@function
Toggle_Classes:
	lwz 9,84(3)
	cmpwi 0,9,0
	bclr 12,2
	lwz 0,728(3)
	cmpwi 0,0,0
	bclr 4,1
	lwz 0,1868(9)
	xori 0,0,1
	andi. 11,0,1
	stw 0,1868(9)
	bc 12,2,.L15
	lwz 9,84(3)
	li 0,0
	stw 0,3616(9)
	lwz 11,84(3)
	stw 0,3612(11)
.L15:
	lwz 9,84(3)
	lwz 0,1868(9)
	ori 0,0,2
	stw 0,1868(9)
	blr
.Lfe6:
	.size	 Toggle_Classes,.Lfe6-Toggle_Classes
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
