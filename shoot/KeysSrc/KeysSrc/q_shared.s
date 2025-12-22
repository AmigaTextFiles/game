	.file	"q_shared.c"
gcc2_compiled.:
	.globl vec3_origin
	.section	".data"
	.align 2
	.type	 vec3_origin,@object
	.size	 vec3_origin,12
vec3_origin:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 3
.LC0:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC1:
	.long 0x40668000
	.long 0x0
	.section	".text"
	.align 2
	.globl RotatePointAroundVector
	.type	 RotatePointAroundVector,@function
RotatePointAroundVector:
	stwu 1,-352(1)
	mflr 0
	stfd 31,344(1)
	stmw 23,308(1)
	stw 0,356(1)
	mr 9,4
	addi 29,1,248
	fmr 31,1
	lfs 13,0(9)
	mr 23,3
	addi 24,1,56
	lfs 12,4(9)
	addi 27,1,8
	addi 28,1,104
	lfs 0,8(9)
	addi 26,1,152
	addi 25,1,200
	stfs 13,280(1)
	mr 31,5
	stfs 12,284(1)
	mr 3,29
	stfs 0,288(1)
	bl PerpendicularVector
	addi 4,1,280
	addi 5,1,264
	mr 3,29
	bl CrossProduct
	lfs 0,256(1)
	mr 4,27
	li 5,36
	lfs 13,264(1)
	mr 3,24
	lfs 12,268(1)
	lfs 11,272(1)
	lfs 10,280(1)
	lfs 9,284(1)
	lfs 6,248(1)
	lfs 7,252(1)
	lfs 8,288(1)
	stfs 0,32(1)
	stfs 13,12(1)
	stfs 12,24(1)
	stfs 11,36(1)
	stfs 10,16(1)
	stfs 9,28(1)
	stfs 6,8(1)
	stfs 7,20(1)
	stfs 8,40(1)
	crxor 6,6,6
	bl memcpy
	lfs 0,12(1)
	li 4,0
	li 5,36
	lfs 13,36(1)
	mr 3,28
	lfs 9,20(1)
	lfs 10,32(1)
	lfs 12,16(1)
	lfs 11,28(1)
	stfs 0,68(1)
	stfs 13,76(1)
	stfs 9,60(1)
	stfs 10,64(1)
	stfs 12,80(1)
	stfs 11,84(1)
	crxor 6,6,6
	bl memset
	lis 9,.LC0@ha
	lis 11,.LC1@ha
	lfd 0,.LC0@l(9)
	lis 0,0x3f80
	lfd 13,.LC1@l(11)
	stw 0,104(1)
	fmul 31,31,0
	stw 0,136(1)
	stw 0,120(1)
	fdiv 31,31,13
	fmr 1,31
	bl cos
	frsp 0,1
	fmr 1,31
	stfs 0,104(1)
	bl sin
	frsp 0,1
	fmr 1,31
	stfs 0,108(1)
	bl sin
	fneg 0,1
	fmr 1,31
	frsp 0,0
	stfs 0,116(1)
	bl cos
	frsp 1,1
	mr 3,27
	mr 4,28
	mr 5,26
	stfs 1,120(1)
	bl R_ConcatRotations
	mr 3,26
	mr 4,24
	mr 5,25
	bl R_ConcatRotations
	li 0,3
	addi 10,1,204
	mtctr 0
	addi 11,1,208
	li 9,0
.L12:
	lfsx 12,9,10
	lfs 0,4(31)
	lfsx 13,9,25
	lfs 10,0(31)
	fmuls 12,12,0
	lfs 11,8(31)
	lfsx 0,9,11
	addi 9,9,12
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,0(23)
	addi 23,23,4
	bdnz .L12
	lwz 0,356(1)
	mtlr 0
	lmw 23,308(1)
	lfd 31,344(1)
	la 1,352(1)
	blr
.Lfe1:
	.size	 RotatePointAroundVector,.Lfe1-RotatePointAroundVector
	.section	".sbss","aw",@nobits
	.align 2
sr.9:
	.space	4
	.size	 sr.9,4
	.align 2
sp.10:
	.space	4
	.size	 sp.10,4
	.align 2
sy.11:
	.space	4
	.size	 sy.11,4
	.align 2
cr.12:
	.space	4
	.size	 cr.12,4
	.align 2
cp.13:
	.space	4
	.size	 cp.13,4
	.align 2
cy.14:
	.space	4
	.size	 cy.14,4
	.section	".rodata"
	.align 3
.LC2:
	.long 0x3f91df46
	.long 0xa2529d39
	.section	".text"
	.align 2
	.globl AngleVectors
	.type	 AngleVectors,@function
AngleVectors:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 22,8(1)
	stw 0,68(1)
	mr 29,3
	lis 9,.LC2@ha
	lfs 0,4(29)
	mr 31,4
	mr 30,5
	lfd 30,.LC2@l(9)
	mr 28,6
	lis 25,sy.11@ha
	lis 26,cy.14@ha
	lis 27,sp.10@ha
	lis 22,cp.13@ha
	lis 24,sr.9@ha
	lis 23,cr.12@ha
	fmul 0,0,30
	frsp 0,0
	fmr 31,0
	fmr 1,31
	bl sin
	frsp 0,1
	fmr 1,31
	stfs 0,sy.11@l(25)
	bl cos
	frsp 1,1
	stfs 1,cy.14@l(26)
	lfs 0,0(29)
	fmul 0,0,30
	frsp 0,0
	fmr 31,0
	fmr 1,31
	bl sin
	frsp 0,1
	fmr 1,31
	stfs 0,sp.10@l(27)
	bl cos
	lfs 0,8(29)
	frsp 1,1
	stfs 1,cp.13@l(22)
	fmul 0,0,30
	frsp 0,0
	fmr 31,0
	fmr 1,31
	bl sin
	frsp 0,1
	fmr 1,31
	stfs 0,sr.9@l(24)
	bl cos
	frsp 1,1
	cmpwi 0,31,0
	stfs 1,cr.12@l(23)
	bc 12,2,.L14
	lfs 13,cy.14@l(26)
	lfs 0,cp.13@l(22)
	fmuls 0,0,13
	stfs 0,0(31)
	lfs 13,cp.13@l(22)
	lfs 12,sy.11@l(25)
	lfs 0,sp.10@l(27)
	fmuls 13,13,12
	fneg 0,0
	stfs 13,4(31)
	stfs 0,8(31)
.L14:
	cmpwi 0,30,0
	bc 12,2,.L15
	lfs 0,sr.9@l(24)
	lfs 13,cr.12@l(23)
	lfs 12,sy.11@l(25)
	lfs 11,sp.10@l(27)
	fneg 0,0
	fneg 13,13
	lfs 10,cy.14@l(26)
	fneg 12,12
	fmuls 0,0,11
	fmuls 13,13,12
	fmadds 0,0,10,13
	stfs 0,0(30)
	lfs 12,sr.9@l(24)
	lfs 0,cr.12@l(23)
	lfs 13,sp.10@l(27)
	lfs 10,cy.14@l(26)
	fneg 12,12
	fneg 0,0
	lfs 9,sy.11@l(25)
	lfs 11,cp.13@l(22)
	fmuls 13,12,13
	fmuls 0,0,10
	fmuls 12,12,11
	fmadds 13,13,9,0
	stfs 12,8(30)
	stfs 13,4(30)
.L15:
	cmpwi 0,28,0
	bc 12,2,.L16
	lfs 13,sr.9@l(24)
	lfs 12,sy.11@l(25)
	lfs 11,sp.10@l(27)
	lfs 0,cr.12@l(23)
	fneg 13,13
	fneg 12,12
	lfs 10,cy.14@l(26)
	fmuls 0,0,11
	fmuls 13,13,12
	fmadds 0,0,10,13
	stfs 0,0(28)
	lfs 12,sr.9@l(24)
	lfs 11,cr.12@l(23)
	lfs 13,sp.10@l(27)
	lfs 10,cy.14@l(26)
	fneg 12,12
	lfs 9,sy.11@l(25)
	lfs 0,cp.13@l(22)
	fmuls 13,11,13
	fmuls 12,12,10
	fmuls 11,11,0
	fmadds 13,13,9,12
	stfs 11,8(28)
	stfs 13,4(28)
.L16:
	lwz 0,68(1)
	mtlr 0
	lmw 22,8(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 AngleVectors,.Lfe2-AngleVectors
	.section	".rodata"
	.align 2
.LC3:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl PerpendicularVector
	.type	 PerpendicularVector,@function
PerpendicularVector:
	stwu 1,-48(1)
	mflr 0
	stw 0,52(1)
	li 0,3
	lis 9,.LC3@ha
	mtctr 0
	la 9,.LC3@l(9)
	mr 7,3
	lfs 12,0(9)
	li 10,0
	addi 8,1,8
	li 9,0
	mr 11,4
.L26:
	lfs 0,0(11)
	fmr 13,12
	addi 11,11,4
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L21
	frsp 12,0
	mr 9,10
.L21:
	addi 10,10,1
	bdnz .L26
	lfs 8,4(4)
	lis 11,.LC3@ha
	li 0,0
	lfs 11,0(4)
	la 11,.LC3@l(11)
	slwi 9,9,2
	lfs 0,8(4)
	mr 3,7
	fmuls 12,8,8
	lfs 10,0(11)
	stw 0,8(1)
	stw 0,16(1)
	fmadds 12,11,11,12
	stw 0,12(1)
	stfsx 10,8,9
	lfs 13,4(8)
	fmadds 12,0,0,12
	lfs 7,8(1)
	lfs 6,8(8)
	fmuls 13,8,13
	fdivs 10,10,12
	fmadds 13,11,7,13
	fmuls 9,0,10
	fmuls 11,11,10
	fmadds 0,0,6,13
	fmuls 8,8,10
	stfs 9,32(1)
	stfs 11,24(1)
	fmuls 0,0,10
	stfs 8,28(1)
	lfs 13,8(8)
	fmuls 9,0,9
	lfs 12,4(8)
	fmuls 11,0,11
	fmuls 0,0,8
	fsubs 13,13,9
	fsubs 7,7,11
	fsubs 12,12,0
	stfs 13,8(7)
	stfs 7,0(7)
	stfs 12,4(7)
	bl VectorNormalize
	lwz 0,52(1)
	mtlr 0
	la 1,48(1)
	blr
.Lfe3:
	.size	 PerpendicularVector,.Lfe3-PerpendicularVector
	.align 2
	.globl R_ConcatRotations
	.type	 R_ConcatRotations,@function
R_ConcatRotations:
	lfs 0,12(4)
	lfs 12,4(3)
	lfs 10,0(4)
	lfs 13,0(3)
	fmuls 12,12,0
	lfs 11,24(4)
	lfs 0,8(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,0(5)
	lfs 0,16(4)
	lfs 12,4(3)
	lfs 10,4(4)
	lfs 13,0(3)
	fmuls 12,12,0
	lfs 11,28(4)
	lfs 0,8(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,4(5)
	lfs 0,20(4)
	lfs 12,4(3)
	lfs 10,8(4)
	lfs 13,0(3)
	fmuls 12,12,0
	lfs 11,32(4)
	lfs 0,8(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,8(5)
	lfs 0,12(4)
	lfs 12,16(3)
	lfs 10,0(4)
	lfs 13,12(3)
	fmuls 12,12,0
	lfs 11,24(4)
	lfs 0,20(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,12(5)
	lfs 0,16(4)
	lfs 12,16(3)
	lfs 10,4(4)
	lfs 13,12(3)
	fmuls 12,12,0
	lfs 11,28(4)
	lfs 0,20(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,16(5)
	lfs 0,20(4)
	lfs 12,16(3)
	lfs 10,8(4)
	lfs 13,12(3)
	fmuls 12,12,0
	lfs 11,32(4)
	lfs 0,20(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,20(5)
	lfs 0,12(4)
	lfs 12,28(3)
	lfs 10,0(4)
	lfs 13,24(3)
	fmuls 12,12,0
	lfs 11,24(4)
	lfs 0,32(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,24(5)
	lfs 0,16(4)
	lfs 12,28(3)
	lfs 10,4(4)
	lfs 13,24(3)
	fmuls 12,12,0
	lfs 11,28(4)
	lfs 0,32(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,28(5)
	lfs 0,20(4)
	lfs 12,28(3)
	lfs 13,24(3)
	lfs 10,8(4)
	fmuls 12,12,0
	lfs 11,32(4)
	lfs 0,32(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,32(5)
	blr
.Lfe4:
	.size	 R_ConcatRotations,.Lfe4-R_ConcatRotations
	.align 2
	.globl R_ConcatTransforms
	.type	 R_ConcatTransforms,@function
R_ConcatTransforms:
	lfs 0,16(4)
	lfs 12,4(3)
	lfs 10,0(4)
	lfs 13,0(3)
	fmuls 12,12,0
	lfs 11,32(4)
	lfs 0,8(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,0(5)
	lfs 0,20(4)
	lfs 12,4(3)
	lfs 10,4(4)
	lfs 13,0(3)
	fmuls 12,12,0
	lfs 11,36(4)
	lfs 0,8(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,4(5)
	lfs 0,24(4)
	lfs 12,4(3)
	lfs 10,8(4)
	lfs 13,0(3)
	fmuls 12,12,0
	lfs 11,40(4)
	lfs 0,8(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,8(5)
	lfs 0,28(4)
	lfs 13,4(3)
	lfs 10,12(4)
	lfs 12,0(3)
	fmuls 13,13,0
	lfs 9,44(4)
	lfs 0,8(3)
	lfs 11,12(3)
	fmadds 12,12,10,13
	fmadds 0,0,9,12
	fadds 0,0,11
	stfs 0,12(5)
	lfs 0,16(4)
	lfs 12,20(3)
	lfs 10,0(4)
	lfs 13,16(3)
	fmuls 12,12,0
	lfs 11,32(4)
	lfs 0,24(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,16(5)
	lfs 0,20(4)
	lfs 12,20(3)
	lfs 10,4(4)
	lfs 13,16(3)
	fmuls 12,12,0
	lfs 11,36(4)
	lfs 0,24(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,20(5)
	lfs 0,24(4)
	lfs 12,20(3)
	lfs 10,8(4)
	lfs 13,16(3)
	fmuls 12,12,0
	lfs 11,40(4)
	lfs 0,24(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,24(5)
	lfs 0,28(4)
	lfs 13,20(3)
	lfs 10,12(4)
	lfs 12,16(3)
	fmuls 13,13,0
	lfs 9,44(4)
	lfs 0,24(3)
	lfs 11,28(3)
	fmadds 12,12,10,13
	fmadds 0,0,9,12
	fadds 0,0,11
	stfs 0,28(5)
	lfs 0,16(4)
	lfs 12,36(3)
	lfs 10,0(4)
	lfs 13,32(3)
	fmuls 12,12,0
	lfs 11,32(4)
	lfs 0,40(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,32(5)
	lfs 0,20(4)
	lfs 12,36(3)
	lfs 10,4(4)
	lfs 13,32(3)
	fmuls 12,12,0
	lfs 11,36(4)
	lfs 0,40(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,36(5)
	lfs 0,24(4)
	lfs 12,36(3)
	lfs 10,8(4)
	lfs 13,32(3)
	fmuls 12,12,0
	lfs 11,40(4)
	lfs 0,40(3)
	fmadds 13,13,10,12
	fmadds 0,0,11,13
	stfs 0,40(5)
	lfs 0,28(4)
	lfs 13,36(3)
	lfs 12,32(3)
	lfs 10,12(4)
	fmuls 13,13,0
	lfs 9,44(4)
	lfs 0,40(3)
	lfs 11,44(3)
	fmadds 12,12,10,13
	fmadds 0,0,9,12
	fadds 0,0,11
	stfs 0,44(5)
	blr
.Lfe5:
	.size	 R_ConcatTransforms,.Lfe5-R_ConcatTransforms
	.section	".rodata"
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl BoxOnPlaneSide
	.type	 BoxOnPlaneSide,@function
BoxOnPlaneSide:
	lbz 0,16(5)
	cmplwi 0,0,2
	bc 12,1,.L45
	slwi 0,0,2
	lfs 12,12(5)
	lfsx 0,3,0
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L46
	li 3,1
	blr
.L46:
	lfsx 0,4,0
	fcmpu 7,12,0
	cror 31,30,29
	mfcr 3
	rlwinm 3,3,0,1
	neg 3,3
	nor 0,3,3
	rlwinm 3,3,0,30,30
	rlwinm 0,0,0,30,31
	or 3,3,0
	blr
.L45:
	lbz 10,17(5)
	cmplwi 0,10,7
	bc 12,1,.L57
	lis 11,.L58@ha
	slwi 10,10,2
	la 11,.L58@l(11)
	lis 9,.L58@ha
	lwzx 0,10,11
	la 9,.L58@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L58:
	.long .L49-.L58
	.long .L50-.L58
	.long .L51-.L58
	.long .L52-.L58
	.long .L53-.L58
	.long .L54-.L58
	.long .L55-.L58
	.long .L56-.L58
.L49:
	lfs 12,4(5)
	lfs 0,4(4)
	lfs 10,4(3)
	lfs 13,0(5)
	fmuls 0,12,0
	lfs 11,0(4)
	fmuls 12,12,10
	lfs 9,0(3)
	lfs 10,8(3)
	fmadds 11,13,11,0
	lfs 8,8(4)
	b .L62
.L50:
	lfs 13,4(5)
	lfs 11,4(4)
	lfs 10,4(3)
	lfs 0,0(5)
	fmuls 11,13,11
	lfs 12,0(4)
	fmuls 13,13,10
	lfs 9,0(3)
	lfs 10,8(5)
	lfs 8,8(3)
	fmadds 12,0,12,13
	fmadds 0,0,9,11
	lfs 13,8(4)
	b .L63
.L51:
	lfs 13,4(5)
	lfs 11,4(4)
	lfs 0,4(3)
	lfs 12,0(5)
	fmuls 11,13,11
	lfs 9,0(4)
	fmuls 13,13,0
	lfs 10,8(5)
	lfs 0,0(3)
	lfs 8,8(3)
	fmadds 0,12,0,11
	fmadds 12,12,9,13
	lfs 11,8(4)
	b .L64
.L52:
	lfs 13,4(5)
	lfs 11,4(4)
	lfs 0,4(3)
	lfs 12,0(5)
	fmuls 11,13,11
	lfs 9,0(3)
	fmuls 13,13,0
	lfs 10,8(5)
	lfs 0,0(4)
	lfs 8,8(3)
	fmadds 0,12,0,11
	fmadds 12,12,9,13
	lfs 11,8(4)
	b .L64
.L53:
	lfs 13,4(5)
	lfs 11,4(3)
	lfs 0,4(4)
	lfs 12,0(5)
	fmuls 11,13,11
	lfs 9,0(4)
	fmuls 13,13,0
	lfs 10,8(5)
	lfs 0,0(3)
	b .L65
.L54:
	lfs 13,4(5)
	lfs 11,4(3)
	lfs 0,4(4)
	lfs 12,0(5)
	fmuls 11,13,11
	lfs 9,0(3)
	fmuls 13,13,0
	lfs 10,8(5)
	lfs 0,0(4)
.L65:
	lfs 8,8(4)
	fmadds 0,12,0,11
	fmadds 12,12,9,13
	lfs 11,8(3)
.L64:
	fmadds 9,10,8,0
	fmadds 0,10,11,12
	b .L48
.L55:
	lfs 13,4(5)
	lfs 11,4(3)
	lfs 10,4(4)
	lfs 0,0(5)
	fmuls 11,13,11
	lfs 12,0(3)
	fmuls 13,13,10
	lfs 9,0(4)
	lfs 10,8(5)
	lfs 8,8(4)
	fmadds 12,0,12,13
	fmadds 0,0,9,11
	lfs 13,8(3)
.L63:
	fmadds 9,10,8,12
	fmadds 0,10,13,0
	b .L48
.L56:
	lfs 12,4(5)
	lfs 0,4(3)
	lfs 10,4(4)
	lfs 13,0(5)
	fmuls 0,12,0
	lfs 11,0(3)
	fmuls 12,12,10
	lfs 9,0(4)
	lfs 10,8(4)
	fmadds 11,13,11,0
	lfs 8,8(3)
.L62:
	lfs 0,8(5)
	fmadds 13,13,9,12
	fmadds 9,0,10,13
	fmadds 0,0,8,11
	b .L48
.L57:
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 9,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
.L48:
	lfs 11,12(5)
	li 3,0
	fcmpu 0,0,11
	cror 3,2,1
	bc 4,3,.L59
	li 3,1
.L59:
	fcmpu 0,9,11
	ori 0,3,2
	bclr 4,0
	mr 3,0
	blr
.Lfe6:
	.size	 BoxOnPlaneSide,.Lfe6-BoxOnPlaneSide
	.section	".sbss","aw",@nobits
	.align 2
exten.96:
	.space	8
	.size	 exten.96,8
	.section	".rodata"
	.align 2
.LC9:
	.string	""
	.section	".text"
	.align 2
	.globl Swap_Init
	.type	 Swap_Init,@function
Swap_Init:
	stwu 1,-32(1)
	stmw 28,16(1)
	lis 11,ShortNoSwap@ha
	lis 9,bigendien@ha
	la 11,ShortNoSwap@l(11)
	li 0,1
	lis 10,_BigShort@ha
	lis 8,ShortSwap@ha
	stw 0,bigendien@l(9)
	lis 7,LongNoSwap@ha
	lis 6,LongSwap@ha
	stw 11,_BigShort@l(10)
	lis 5,FloatNoSwap@ha
	lis 4,FloatSwap@ha
	la 8,ShortSwap@l(8)
	la 7,LongNoSwap@l(7)
	la 6,LongSwap@l(6)
	la 5,FloatNoSwap@l(5)
	la 4,FloatSwap@l(4)
	lis 28,_LittleShort@ha
	lis 3,_BigLong@ha
	lis 29,_LittleLong@ha
	stw 8,_LittleShort@l(28)
	lis 9,_BigFloat@ha
	lis 11,_LittleFloat@ha
	stw 7,_BigLong@l(3)
	stw 6,_LittleLong@l(29)
	stw 5,_BigFloat@l(9)
	stw 4,_LittleFloat@l(11)
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Swap_Init,.Lfe7-Swap_Init
	.lcomm	string.148,1024,4
	.align 2
	.globl va
	.type	 va,@function
va:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	lis 12,0x100
	addi 11,1,168
	stw 4,12(1)
	addi 0,1,8
	stw 11,132(1)
	stw 0,136(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	stw 12,128(1)
	bc 4,6,.L166
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L166:
	addi 11,1,128
	addi 9,1,112
	lwz 10,8(11)
	mr 4,3
	lis 29,string.148@ha
	lwz 0,4(11)
	mr 5,9
	la 3,string.148@l(29)
	stw 12,112(1)
	stw 0,4(9)
	stw 10,8(9)
	bl vsprintf
	la 3,string.148@l(29)
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe8:
	.size	 va,.Lfe8-va
	.align 2
	.globl COM_Parse
	.type	 COM_Parse,@function
COM_Parse:
	mr 7,3
	li 8,0
	lwz 10,0(7)
	lis 9,com_token@ha
	stb 8,com_token@l(9)
	cmpwi 0,10,0
	bc 4,2,.L169
	lis 3,.LC9@ha
	stw 10,0(7)
	la 3,.LC9@l(3)
	blr
.L169:
	lbz 11,0(10)
	cmpwi 0,11,32
	bc 12,1,.L171
.L172:
	cmpwi 0,11,0
	bc 12,2,.L194
	lbzu 11,1(10)
	cmpwi 0,11,32
	bc 4,1,.L172
.L171:
	cmpwi 0,11,47
	bc 4,2,.L175
	lbz 0,1(10)
	cmpwi 0,0,47
	bc 4,2,.L175
	lbz 9,0(10)
	xori 0,9,10
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 5,9,0
	bc 12,2,.L169
.L178:
	lbzu 9,1(10)
	xori 0,9,10
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 6,9,0
	bc 4,2,.L178
	b .L169
.L194:
	lis 3,.LC9@ha
	stw 11,0(7)
	la 3,.LC9@l(3)
	blr
.L195:
	lis 3,com_token@ha
	li 0,0
	la 3,com_token@l(3)
	stbx 0,3,8
	stw 10,0(7)
	blr
.L175:
	cmpwi 0,11,34
	bc 4,2,.L180
	lis 9,com_token@ha
	addi 10,10,1
	la 6,com_token@l(9)
.L183:
	lbz 11,0(10)
	addi 10,10,1
	xori 9,11,34
	subfic 0,9,0
	adde 9,0,9
	subfic 5,11,0
	adde 0,5,11
	or. 5,9,0
	bc 4,2,.L195
	cmpwi 0,8,127
	bc 12,1,.L183
	stbx 11,6,8
	addi 8,8,1
	b .L183
.L180:
	lis 9,com_token@ha
	la 9,com_token@l(9)
.L191:
	cmpwi 0,8,127
	bc 12,1,.L190
	stbx 11,9,8
	addi 8,8,1
.L190:
	lbzu 11,1(10)
	cmpwi 0,11,32
	bc 12,1,.L191
	xori 11,8,128
	lis 9,com_token@ha
	srawi 6,11,31
	la 9,com_token@l(9)
	xor 0,6,11
	mr 3,9
	subf 0,0,6
	li 11,0
	srawi 0,0,31
	and 8,8,0
	stbx 11,9,8
	stw 10,0(7)
	blr
.Lfe9:
	.size	 COM_Parse,.Lfe9-COM_Parse
	.section	".rodata"
	.align 2
.LC10:
	.string	"Com_sprintf: overflow of %i in %i\n"
	.section	".text"
	.align 2
	.globl Com_sprintf
	.type	 Com_sprintf,@function
Com_sprintf:
	mr 12,1
	lis 0,0xfffe
	ori 0,0,65376
	stwux 1,1,0
	mflr 0
	stmw 28,-16(12)
	stw 0,4(12)
	lis 0,0x1
	lis 31,0x1
	ori 31,31,168
	ori 0,0,112
	add 12,1,0
	add 11,1,31
	lis 28,0x300
	addi 29,1,8
	stw 11,20(12)
	stw 29,24(12)
	mr 30,3
	mr 31,4
	stw 28,16(12)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L225
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L225:
	addi 11,12,16
	addi 9,1,112
	lwz 10,8(11)
	mr 4,5
	addi 29,1,128
	lwz 0,4(11)
	mr 5,9
	mr 3,29
	stw 28,112(1)
	stw 0,4(9)
	stw 10,8(9)
	bl vsprintf
	mr 4,3
	cmpw 0,4,31
	bc 12,0,.L226
	lis 3,.LC10@ha
	mr 5,31
	la 3,.LC10@l(3)
	crxor 6,6,6
	bl Com_Printf
.L226:
	mr 3,30
	mr 4,29
	addi 5,31,-1
	bl strncpy
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 28,-16(11)
	mr 1,11
	blr
.Lfe10:
	.size	 Com_sprintf,.Lfe10-Com_sprintf
	.lcomm	value.170,1024,1
	.section	".sbss","aw",@nobits
	.align 2
valueindex.171:
	.space	4
	.size	 valueindex.171,4
	.section	".text"
	.align 2
	.globl Info_ValueForKey
	.type	 Info_ValueForKey,@function
Info_ValueForKey:
	stwu 1,-560(1)
	mflr 0
	stmw 25,532(1)
	stw 0,564(1)
	lis 10,valueindex.171@ha
	mr 31,3
	lwz 0,valueindex.171@l(10)
	addi 11,31,1
	lis 9,value.170@ha
	la 27,value.170@l(9)
	mr 25,4
	xori 0,0,1
	lis 28,valueindex.171@ha
	stw 0,valueindex.171@l(10)
	addi 26,1,8
	li 29,0
	lbz 0,0(31)
	lis 30,.LC9@ha
	xori 0,0,92
	neg 0,0
	srawi 0,0,31
	andc 11,11,0
	and 0,31,0
	or 31,0,11
.L231:
	lbz 0,0(31)
	mr 11,26
	cmpwi 0,0,92
	bc 12,2,.L233
.L234:
	cmpwi 0,0,0
	bc 12,2,.L243
	stb 0,0(11)
	lbzu 0,1(31)
	addi 11,11,1
	cmpwi 0,0,92
	bc 4,2,.L234
.L233:
	stb 29,0(11)
	lbzu 10,1(31)
	lwz 0,valueindex.171@l(28)
	rlwinm 9,10,0,0xff
	xori 11,9,92
	slwi 0,0,9
	neg 9,9
	neg 11,11
	srwi 11,11,31
	srwi 9,9,31
	and. 8,11,9
	add 11,0,27
	bc 12,2,.L238
.L239:
	cmpwi 0,10,0
	bc 12,2,.L247
	stb 10,0(11)
	lbzu 10,1(31)
	addi 11,11,1
	rlwinm 9,10,0,0xff
	xori 0,9,92
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,0,9
	bc 4,2,.L239
.L238:
	stb 29,0(11)
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L242
	lwz 3,valueindex.171@l(28)
	slwi 3,3,9
	add 3,3,27
	b .L245
.L242:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L243
	addi 31,31,1
	b .L231
.L247:
.L243:
	la 3,.LC9@l(30)
.L245:
	lwz 0,564(1)
	mtlr 0
	lmw 25,532(1)
	la 1,560(1)
	blr
.Lfe11:
	.size	 Info_ValueForKey,.Lfe11-Info_ValueForKey
	.section	".rodata"
	.align 2
.LC11:
	.string	"\\"
	.section	".text"
	.align 2
	.globl Info_RemoveKey
	.type	 Info_RemoveKey,@function
Info_RemoveKey:
	stwu 1,-1056(1)
	mflr 0
	stmw 28,1040(1)
	stw 0,1060(1)
	mr 29,4
	mr 31,3
	lis 4,.LC11@ha
	mr 3,29
	la 4,.LC11@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L248
	li 28,0
.L252:
	mr 30,31
	addi 10,1,8
	lbz 0,0(30)
	addi 9,30,1
	xori 0,0,92
	neg 0,0
	srawi 0,0,31
	andc 9,9,0
	and 0,30,0
	or 31,0,9
	lbz 0,0(31)
	cmpwi 0,0,92
	bc 12,2,.L255
.L256:
	cmpwi 0,0,0
	bc 12,2,.L248
	stb 0,0(10)
	lbzu 0,1(31)
	addi 10,10,1
	cmpwi 0,0,92
	bc 4,2,.L256
.L255:
	stb 28,0(10)
	lbzu 11,1(31)
	addi 10,1,520
	b .L267
.L261:
	cmpwi 0,11,0
	bc 12,2,.L248
	stb 11,0(10)
	lbzu 11,1(31)
	addi 10,10,1
.L267:
	rlwinm 9,11,0,0xff
	xori 0,9,92
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,0,9
	bc 4,2,.L261
	stb 28,0(10)
	mr 3,29
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L264
	mr 3,30
	mr 4,31
	bl strcpy
	b .L248
.L264:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L252
.L248:
	lwz 0,1060(1)
	mtlr 0
	lmw 28,1040(1)
	la 1,1056(1)
	blr
.Lfe12:
	.size	 Info_RemoveKey,.Lfe12-Info_RemoveKey
	.section	".rodata"
	.align 2
.LC12:
	.string	"\""
	.align 2
.LC13:
	.string	";"
	.align 2
.LC14:
	.string	"Can't use keys or values with a \\\n"
	.align 2
.LC15:
	.string	"Can't use keys or values with a \"\n"
	.align 2
.LC16:
	.string	"Keys and values must be < 64 characters.\n"
	.align 2
.LC17:
	.string	"\\%s\\%s"
	.align 2
.LC18:
	.string	"Info string length exceeded\n"
	.section	".text"
	.align 2
	.globl Info_SetValueForKey
	.type	 Info_SetValueForKey,@function
Info_SetValueForKey:
	stwu 1,-544(1)
	mflr 0
	stmw 28,528(1)
	stw 0,548(1)
	mr 30,4
	mr 31,3
	lis 28,.LC11@ha
	mr 29,5
	mr 3,30
	la 4,.LC11@l(28)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L273
	la 4,.LC11@l(28)
	mr 3,29
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L272
.L273:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	crxor 6,6,6
	bl Com_Printf
	b .L271
.L272:
	lis 28,.LC12@ha
	mr 3,30
	la 4,.LC12@l(28)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L275
	la 4,.LC12@l(28)
	mr 3,29
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L274
.L275:
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	crxor 6,6,6
	bl Com_Printf
	b .L271
.L274:
	mr 3,30
	bl strlen
	cmplwi 0,3,63
	bc 12,1,.L277
	mr 3,29
	bl strlen
	cmplwi 0,3,63
	bc 4,1,.L276
.L277:
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	crxor 6,6,6
	bl Com_Printf
	b .L271
.L276:
	mr 3,31
	mr 4,30
	bl Info_RemoveKey
	cmpwi 0,29,0
	bc 12,2,.L271
	mr 3,29
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L271
	lis 5,.LC17@ha
	mr 7,29
	addi 3,1,8
	mr 6,30
	la 5,.LC17@l(5)
	li 4,512
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	cmplwi 0,29,512
	bc 4,1,.L280
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	crxor 6,6,6
	bl Com_Printf
	b .L271
.L280:
	mr 3,31
	bl strlen
	lbz 0,8(1)
	add 31,31,3
	addi 11,1,8
	cmpwi 0,0,0
	bc 12,2,.L282
.L283:
	lbz 9,0(11)
	addi 11,11,1
	rlwinm 9,9,0,25,31
	addi 0,9,-32
	cmplwi 0,0,94
	bc 12,1,.L281
	stb 9,0(31)
	addi 31,31,1
.L281:
	lbz 0,0(11)
	cmpwi 0,0,0
	bc 4,2,.L283
.L282:
	li 0,0
	stb 0,0(31)
.L271:
	lwz 0,548(1)
	mtlr 0
	lmw 28,528(1)
	la 1,544(1)
	blr
.Lfe13:
	.size	 Info_SetValueForKey,.Lfe13-Info_SetValueForKey
	.align 2
	.globl VectorMA
	.type	 VectorMA,@function
VectorMA:
	lfs 0,0(3)
	lfs 13,0(4)
	fmadds 13,1,13,0
	stfs 13,0(5)
	lfs 13,4(3)
	lfs 0,4(4)
	fmadds 0,1,0,13
	stfs 0,4(5)
	lfs 13,8(4)
	lfs 0,8(3)
	fmadds 1,1,13,0
	stfs 1,8(5)
	blr
.Lfe14:
	.size	 VectorMA,.Lfe14-VectorMA
	.align 2
	.globl _DotProduct
	.type	 _DotProduct,@function
_DotProduct:
	lfs 13,4(4)
	lfs 0,4(3)
	lfs 1,0(3)
	lfs 12,0(4)
	fmuls 0,0,13
	lfs 11,8(3)
	lfs 13,8(4)
	fmadds 1,1,12,0
	fmadds 1,11,13,1
	blr
.Lfe15:
	.size	 _DotProduct,.Lfe15-_DotProduct
	.align 2
	.globl _VectorSubtract
	.type	 _VectorSubtract,@function
_VectorSubtract:
	lfs 0,0(4)
	lfs 13,0(3)
	fsubs 13,13,0
	stfs 13,0(5)
	lfs 13,4(4)
	lfs 0,4(3)
	fsubs 0,0,13
	stfs 0,4(5)
	lfs 13,8(3)
	lfs 0,8(4)
	fsubs 13,13,0
	stfs 13,8(5)
	blr
.Lfe16:
	.size	 _VectorSubtract,.Lfe16-_VectorSubtract
	.align 2
	.globl _VectorAdd
	.type	 _VectorAdd,@function
_VectorAdd:
	lfs 0,0(4)
	lfs 13,0(3)
	fadds 13,13,0
	stfs 13,0(5)
	lfs 13,4(4)
	lfs 0,4(3)
	fadds 0,0,13
	stfs 0,4(5)
	lfs 13,8(3)
	lfs 0,8(4)
	fadds 13,13,0
	stfs 13,8(5)
	blr
.Lfe17:
	.size	 _VectorAdd,.Lfe17-_VectorAdd
	.align 2
	.globl _VectorCopy
	.type	 _VectorCopy,@function
_VectorCopy:
	lfs 0,0(3)
	stfs 0,0(4)
	lfs 13,4(3)
	stfs 13,4(4)
	lfs 0,8(3)
	stfs 0,8(4)
	blr
.Lfe18:
	.size	 _VectorCopy,.Lfe18-_VectorCopy
	.section	".rodata"
	.align 2
.LC19:
	.long 0x47c34f80
	.align 2
.LC20:
	.long 0xc7c34f80
	.section	".text"
	.align 2
	.globl ClearBounds
	.type	 ClearBounds,@function
ClearBounds:
	lis 9,.LC19@ha
	lis 11,.LC20@ha
	lfs 0,.LC19@l(9)
	lfs 13,.LC20@l(11)
	stfs 0,0(3)
	stfs 0,8(3)
	stfs 0,4(3)
	stfs 13,0(4)
	stfs 13,8(4)
	stfs 13,4(4)
	blr
.Lfe19:
	.size	 ClearBounds,.Lfe19-ClearBounds
	.align 2
	.globl AddPointToBounds
	.type	 AddPointToBounds,@function
AddPointToBounds:
	li 0,3
	li 9,0
	mtctr 0
.L286:
	lfsx 13,9,3
	lfsx 0,9,4
	fcmpu 0,13,0
	bc 4,0,.L72
	stfsx 13,9,4
.L72:
	lfsx 0,9,5
	fcmpu 0,13,0
	bc 4,1,.L70
	stfsx 13,9,5
.L70:
	addi 9,9,4
	bdnz .L286
	blr
.Lfe20:
	.size	 AddPointToBounds,.Lfe20-AddPointToBounds
	.align 2
	.globl VectorCompare
	.type	 VectorCompare,@function
VectorCompare:
	lfs 13,0(3)
	lfs 0,0(4)
	fcmpu 0,13,0
	bc 4,2,.L77
	lfs 13,4(3)
	lfs 0,4(4)
	fcmpu 0,13,0
	bc 4,2,.L77
	lfs 13,8(3)
	lfs 0,8(4)
	fcmpu 0,13,0
	bc 12,2,.L76
.L77:
	li 3,0
	blr
.L76:
	li 3,1
	blr
.Lfe21:
	.size	 VectorCompare,.Lfe21-VectorCompare
	.section	".rodata"
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl VectorLength
	.type	 VectorLength,@function
VectorLength:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC21@ha
	li 0,3
	la 9,.LC21@l(9)
	mtctr 0
	lfs 1,0(9)
.L288:
	lfs 0,0(3)
	addi 3,3,4
	fmadds 1,0,0,1
	bdnz .L288
	bl sqrt
	frsp 1,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 VectorLength,.Lfe22-VectorLength
	.align 2
	.globl CrossProduct
	.type	 CrossProduct,@function
CrossProduct:
	lfs 11,4(4)
	lfs 12,8(3)
	lfs 13,8(4)
	lfs 0,4(3)
	fmuls 12,12,11
	fmsubs 0,0,13,12
	stfs 0,0(5)
	lfs 11,8(4)
	lfs 12,0(3)
	lfs 13,0(4)
	lfs 0,8(3)
	fmuls 12,12,11
	fmsubs 0,0,13,12
	stfs 0,4(5)
	lfs 12,4(3)
	lfs 11,0(4)
	lfs 0,0(3)
	lfs 13,4(4)
	fmuls 12,12,11
	fmsubs 0,0,13,12
	stfs 0,8(5)
	blr
.Lfe23:
	.size	 CrossProduct,.Lfe23-CrossProduct
	.section	".rodata"
	.align 2
.LC22:
	.long 0x0
	.align 2
.LC23:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl VectorNormalize
	.type	 VectorNormalize,@function
VectorNormalize:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lfs 0,4(31)
	lfs 13,0(31)
	lfs 12,8(31)
	fmuls 0,0,0
	fmadds 13,13,13,0
	fmadds 1,12,12,13
	bl sqrt
	lis 9,.LC22@ha
	frsp 1,1
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L79
	lis 9,.LC23@ha
	lfs 11,0(31)
	la 9,.LC23@l(9)
	lfs 12,4(31)
	lfs 13,0(9)
	lfs 0,8(31)
	fdivs 13,13,1
	fmuls 0,0,13
	fmuls 11,11,13
	fmuls 12,12,13
	stfs 0,8(31)
	stfs 11,0(31)
	stfs 12,4(31)
.L79:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 VectorNormalize,.Lfe24-VectorNormalize
	.section	".rodata"
	.align 2
.LC24:
	.long 0x0
	.align 2
.LC25:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl VectorNormalize2
	.type	 VectorNormalize2,@function
VectorNormalize2:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lfs 0,4(31)
	lfs 13,0(31)
	lfs 12,8(31)
	fmuls 0,0,0
	fmadds 13,13,13,0
	fmadds 1,12,12,13
	bl sqrt
	lis 9,.LC24@ha
	frsp 1,1
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L81
	lis 9,.LC25@ha
	lfs 13,0(31)
	la 9,.LC25@l(9)
	lfs 12,0(9)
	fdivs 12,12,1
	fmuls 13,13,12
	stfs 13,0(30)
	lfs 0,4(31)
	fmuls 0,0,12
	stfs 0,4(30)
	lfs 13,8(31)
	fmuls 13,13,12
	stfs 13,8(30)
.L81:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 VectorNormalize2,.Lfe25-VectorNormalize2
	.align 2
	.globl VectorInverse
	.type	 VectorInverse,@function
VectorInverse:
	lfs 0,0(3)
	lfs 13,4(3)
	lfs 12,8(3)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,0(3)
	stfs 13,4(3)
	stfs 12,8(3)
	blr
.Lfe26:
	.size	 VectorInverse,.Lfe26-VectorInverse
	.align 2
	.globl VectorScale
	.type	 VectorScale,@function
VectorScale:
	lfs 0,0(3)
	fmuls 0,0,1
	stfs 0,0(4)
	lfs 13,4(3)
	fmuls 13,13,1
	stfs 13,4(4)
	lfs 0,8(3)
	fmuls 0,0,1
	stfs 0,8(4)
	blr
.Lfe27:
	.size	 VectorScale,.Lfe27-VectorScale
	.align 2
	.globl Q_log2
	.type	 Q_log2,@function
Q_log2:
	srawi. 3,3,1
	li 9,0
	bc 12,2,.L98
.L99:
	srawi. 3,3,1
	addi 9,9,1
	bc 4,2,.L99
.L98:
	mr 3,9
	blr
.Lfe28:
	.size	 Q_log2,.Lfe28-Q_log2
	.section	".rodata"
	.align 3
.LC26:
	.long 0x4066c16c
	.long 0x16c16c17
	.align 3
.LC27:
	.long 0x3f768000
	.long 0x0
	.align 3
.LC28:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl anglemod
	.type	 anglemod,@function
anglemod:
	stwu 1,-16(1)
	lis 11,.LC26@ha
	lfd 13,.LC26@l(11)
	mr 10,9
	lis 0,0x4330
	lis 11,.LC28@ha
	la 11,.LC28@l(11)
	fmul 1,1,13
	lfd 11,0(11)
	lis 11,.LC27@ha
	lfd 12,.LC27@l(11)
	fctiwz 0,1
	stfd 0,8(1)
	lwz 9,12(1)
	rlwinm 9,9,0,16,31
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 1,8(1)
	fsub 1,1,11
	fmul 1,1,12
	frsp 1,1
	la 1,16(1)
	blr
.Lfe29:
	.size	 anglemod,.Lfe29-anglemod
	.section	".rodata"
	.align 2
.LC29:
	.long 0x43340000
	.align 2
.LC30:
	.long 0x43b40000
	.align 2
.LC31:
	.long 0xc3340000
	.section	".text"
	.align 2
	.globl LerpAngle
	.type	 LerpAngle,@function
LerpAngle:
	fmr 12,1
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 13,0(9)
	fsubs 0,2,12
	fcmpu 0,0,13
	bc 4,1,.L31
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fsubs 2,2,0
.L31:
	lis 9,.LC31@ha
	fsubs 13,2,12
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L32
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fadds 2,2,0
.L32:
	fsubs 1,2,12
	fmadds 1,3,1,12
	blr
.Lfe30:
	.size	 LerpAngle,.Lfe30-LerpAngle
	.section	".rodata"
	.align 2
.LC32:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ProjectPointOnPlane
	.type	 ProjectPointOnPlane,@function
ProjectPointOnPlane:
	stwu 1,-32(1)
	lfs 9,4(5)
	lis 9,.LC32@ha
	lfs 13,0(5)
	la 9,.LC32@l(9)
	lfs 10,8(5)
	fmuls 11,9,9
	lfs 8,0(9)
	lfs 0,4(4)
	lfs 7,0(4)
	fmadds 11,13,13,11
	lfs 12,8(4)
	fmuls 0,9,0
	fmadds 11,10,10,11
	fmadds 0,13,7,0
	fdivs 8,8,11
	fmadds 12,10,12,0
	fmuls 13,13,8
	fmuls 9,9,8
	fmuls 12,12,8
	stfs 13,8(1)
	fmuls 10,10,8
	stfs 9,12(1)
	fmuls 13,12,13
	stfs 10,16(1)
	fmuls 9,12,9
	fmuls 12,12,10
	fsubs 7,7,13
	stfs 7,0(3)
	lfs 0,4(4)
	fsubs 0,0,9
	stfs 0,4(3)
	lfs 13,8(4)
	fsubs 13,13,12
	stfs 13,8(3)
	la 1,32(1)
	blr
.Lfe31:
	.size	 ProjectPointOnPlane,.Lfe31-ProjectPointOnPlane
	.align 2
	.globl COM_SkipPath
	.type	 COM_SkipPath,@function
COM_SkipPath:
	lbz 0,0(3)
	mr 10,3
	cmpwi 0,0,0
	bclr 12,2
.L104:
	lbz 9,0(10)
	addi 0,10,1
	mr 10,0
	xori 9,9,47
	lbz 11,0(10)
	neg 9,9
	srawi 9,9,31
	cmpwi 0,11,0
	andc 0,0,9
	and 9,3,9
	or 3,9,0
	bc 4,2,.L104
	blr
.Lfe32:
	.size	 COM_SkipPath,.Lfe32-COM_SkipPath
	.align 2
	.globl COM_StripExtension
	.type	 COM_StripExtension,@function
COM_StripExtension:
	lbz 11,0(3)
	b .L289
.L110:
	stb 11,0(4)
	lbzu 11,1(3)
	addi 4,4,1
.L289:
	rlwinm 9,11,0,0xff
	xori 0,9,46
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 4,2,.L110
	li 0,0
	stb 0,0(4)
	blr
.Lfe33:
	.size	 COM_StripExtension,.Lfe33-COM_StripExtension
	.align 2
	.globl COM_FileBase
	.type	 COM_FileBase,@function
COM_FileBase:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	bl strlen
	add 9,31,3
	addi 29,9,-1
	cmpw 0,29,31
	bc 12,2,.L126
	lbz 0,-1(9)
	cmpwi 0,0,46
	bc 12,2,.L126
.L127:
	addi 29,29,-1
	cmpw 0,29,31
	bc 12,2,.L126
	lbz 0,0(29)
	cmpwi 0,0,46
	bc 4,2,.L127
.L126:
	cmpw 0,29,31
	mr 9,29
	bc 12,2,.L131
	lbz 0,0(29)
	cmpwi 0,0,47
	bc 12,2,.L131
.L132:
	addi 9,9,-1
	cmpw 0,9,31
	bc 12,2,.L131
	lbz 0,0(9)
	cmpwi 0,0,47
	bc 4,2,.L132
.L131:
	subf 0,9,29
	cmpwi 0,0,1
	bc 12,1,.L136
	li 0,0
	stb 0,0(30)
	b .L137
.L136:
	addi 29,29,-1
	addi 4,9,1
	subf 29,9,29
	mr 3,30
	mr 5,29
	bl strncpy
	li 0,0
	stbx 0,30,29
.L137:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 COM_FileBase,.Lfe34-COM_FileBase
	.align 2
	.globl COM_FilePath
	.type	 COM_FilePath,@function
COM_FilePath:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	bl strlen
	add 9,31,3
	addi 29,9,-1
	cmpw 0,29,31
	bc 12,2,.L140
	lbz 0,-1(9)
	cmpwi 0,0,47
	bc 12,2,.L140
.L141:
	addi 29,29,-1
	cmpw 0,29,31
	bc 12,2,.L140
	lbz 0,0(29)
	cmpwi 0,0,47
	bc 4,2,.L141
.L140:
	subf 29,31,29
	mr 4,31
	mr 3,30
	mr 5,29
	bl strncpy
	li 0,0
	stbx 0,30,29
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 COM_FilePath,.Lfe35-COM_FilePath
	.align 2
	.globl COM_DefaultExtension
	.type	 COM_DefaultExtension,@function
COM_DefaultExtension:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	bl strlen
	add 3,31,3
	b .L290
.L147:
	lbz 0,0(3)
	cmpwi 0,0,46
	bc 12,2,.L144
.L290:
	lbzu 0,-1(3)
	xori 0,0,47
	xor 9,3,31
	neg 0,0
	addic 10,9,-1
	subfe 11,10,9
	srwi 0,0,31
	and. 9,0,11
	bc 4,2,.L147
	mr 3,31
	mr 4,30
	bl strcat
.L144:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 COM_DefaultExtension,.Lfe36-COM_DefaultExtension
	.align 2
	.globl Com_PageInMemory
	.type	 Com_PageInMemory,@function
Com_PageInMemory:
	addic. 4,4,-1
	bclr 4,1
	lis 11,paged_total@ha
.L200:
	lbzx 9,3,4
	lwz 0,paged_total@l(11)
	addic. 4,4,-4096
	add 0,0,9
	stw 0,paged_total@l(11)
	bc 12,1,.L200
	blr
.Lfe37:
	.size	 Com_PageInMemory,.Lfe37-Com_PageInMemory
	.align 2
	.globl Q_stricmp
	.type	 Q_stricmp,@function
Q_stricmp:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl strcasecmp
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 Q_stricmp,.Lfe38-Q_stricmp
	.align 2
	.globl Q_strcasecmp
	.type	 Q_strcasecmp,@function
Q_strcasecmp:
	lis 6,0x1
	ori 6,6,34463
.L215:
	cmpwi 0,6,0
	lbz 8,0(3)
	lbz 7,0(4)
	addi 3,3,1
	addi 6,6,-1
	addi 4,4,1
	bc 4,2,.L216
	li 3,0
	blr
.L216:
	cmpw 0,8,7
	bc 12,2,.L222
	addi 0,8,-97
	addi 9,7,-97
	subfic 0,0,25
	subfe 0,0,0
	subfic 9,9,25
	subfe 9,9,9
	addi 11,8,-32
	addi 10,7,-32
	andc 11,11,0
	andc 10,10,9
	and 0,8,0
	and 9,7,9
	or 8,0,11
	or 7,9,10
	cmpw 0,8,7
	bc 12,2,.L222
	li 3,-1
	blr
.L222:
	cmpwi 0,8,0
	bc 4,2,.L215
	li 3,0
	blr
.Lfe39:
	.size	 Q_strcasecmp,.Lfe39-Q_strcasecmp
	.align 2
	.globl Q_strncasecmp
	.type	 Q_strncasecmp,@function
Q_strncasecmp:
.L212:
	cmpwi 0,5,0
	lbz 8,0(3)
	lbz 7,0(4)
	addi 3,3,1
	addi 5,5,-1
	addi 4,4,1
	bc 4,2,.L207
	li 3,0
	blr
.L207:
	cmpw 0,8,7
	bc 12,2,.L206
	addi 0,8,-97
	addi 9,7,-97
	subfic 0,0,25
	subfe 0,0,0
	subfic 9,9,25
	subfe 9,9,9
	addi 11,8,-32
	addi 10,7,-32
	andc 11,11,0
	andc 10,10,9
	and 0,8,0
	and 9,7,9
	or 8,0,11
	or 7,9,10
	cmpw 0,8,7
	bc 12,2,.L206
	li 3,-1
	blr
.L206:
	cmpwi 0,8,0
	bc 4,2,.L212
	li 3,0
	blr
.Lfe40:
	.size	 Q_strncasecmp,.Lfe40-Q_strncasecmp
	.align 2
	.globl BigShort
	.type	 BigShort,@function
BigShort:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,_BigShort@ha
	lwz 0,_BigShort@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 BigShort,.Lfe41-BigShort
	.align 2
	.globl LittleShort
	.type	 LittleShort,@function
LittleShort:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,_LittleShort@ha
	lwz 0,_LittleShort@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 LittleShort,.Lfe42-LittleShort
	.align 2
	.globl BigLong
	.type	 BigLong,@function
BigLong:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,_BigLong@ha
	lwz 0,_BigLong@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 BigLong,.Lfe43-BigLong
	.align 2
	.globl LittleLong
	.type	 LittleLong,@function
LittleLong:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,_LittleLong@ha
	lwz 0,_LittleLong@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 LittleLong,.Lfe44-LittleLong
	.align 2
	.globl BigFloat
	.type	 BigFloat,@function
BigFloat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,_BigFloat@ha
	lwz 0,_BigFloat@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 BigFloat,.Lfe45-BigFloat
	.align 2
	.globl LittleFloat
	.type	 LittleFloat,@function
LittleFloat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,_LittleFloat@ha
	lwz 0,_LittleFloat@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 LittleFloat,.Lfe46-LittleFloat
	.align 2
	.globl Info_Validate
	.type	 Info_Validate,@function
Info_Validate:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl strstr
	cmpwi 0,3,0
	li 3,0
	bc 4,2,.L292
	lis 4,.LC13@ha
	mr 3,31
	la 4,.LC13@l(4)
	bl strstr
	subfic 0,3,0
	adde 3,0,3
.L292:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 Info_Validate,.Lfe47-Info_Validate
	.align 2
	.globl Q_fabs
	.type	 Q_fabs,@function
Q_fabs:
	stwu 1,-32(1)
	stfs 1,8(1)
	lwz 9,8(1)
	mr 0,9
	rlwinm 9,0,0,1,31
	stw 9,8(1)
	lfs 1,8(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 Q_fabs,.Lfe48-Q_fabs
	.comm	i,4,4
	.comm	corners,24,4
	.section	".rodata"
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl BoxOnPlaneSide2
	.type	 BoxOnPlaneSide2,@function
BoxOnPlaneSide2:
	stwu 1,-48(1)
	li 0,3
	lis 9,.LC33@ha
	mtctr 0
	la 9,.LC33@l(9)
	addi 10,1,8
	lfs 12,0(9)
	addi 11,1,20
	li 9,0
.L293:
	lfsx 0,9,5
	fcmpu 0,0,12
	bc 4,0,.L39
	lfsx 0,9,3
	lfsx 13,9,4
	stfsx 0,9,10
	stfsx 13,9,11
	b .L37
.L39:
	lfsx 0,9,3
	lfsx 13,9,4
	stfsx 0,9,11
	stfsx 13,9,10
.L37:
	addi 9,9,4
	bdnz .L293
	lfs 8,4(5)
	lis 9,.LC33@ha
	li 3,0
	lfs 0,12(1)
	la 9,.LC33@l(9)
	lfs 9,0(5)
	lfs 12,8(1)
	fmuls 0,8,0
	lfs 10,8(5)
	lfs 13,16(1)
	lfs 11,24(1)
	fmadds 12,9,12,0
	lfs 7,12(5)
	lfs 0,20(1)
	fmuls 8,8,11
	lfs 6,0(9)
	fmadds 13,10,13,12
	lfs 11,28(1)
	fmadds 9,9,0,8
	fsubs 13,13,7
	fmadds 10,10,11,9
	fcmpu 0,13,6
	fsubs 9,10,7
	cror 3,2,1
	bc 4,3,.L42
	li 3,1
.L42:
	fcmpu 0,9,6
	ori 0,3,2
	bc 4,0,.L43
	mr 3,0
.L43:
	la 1,48(1)
	blr
.Lfe49:
	.size	 BoxOnPlaneSide2,.Lfe49-BoxOnPlaneSide2
	.align 2
	.globl COM_FileExtension
	.type	 COM_FileExtension,@function
COM_FileExtension:
	lbz 9,0(3)
	b .L295
.L115:
	lbzu 9,1(3)
.L295:
	xori 0,9,46
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L115
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 4,2,.L117
	lis 3,.LC9@ha
	la 3,.LC9@l(3)
	blr
.L117:
	lbzu 0,1(3)
	li 11,0
	cmpwi 0,0,0
	bc 12,2,.L119
	lis 9,exten.96@ha
	la 9,exten.96@l(9)
.L121:
	stbx 0,11,9
	addi 3,3,1
	addi 11,11,1
	cmpwi 0,11,6
	bc 12,1,.L119
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 4,2,.L121
.L119:
	lis 3,exten.96@ha
	li 0,0
	la 3,exten.96@l(3)
	stbx 0,11,3
	blr
.Lfe50:
	.size	 COM_FileExtension,.Lfe50-COM_FileExtension
	.comm	bigendien,4,4
	.comm	_BigShort,4,4
	.comm	_LittleShort,4,4
	.comm	_BigLong,4,4
	.comm	_LittleLong,4,4
	.comm	_BigFloat,4,4
	.comm	_LittleFloat,4,4
	.align 2
	.globl ShortSwap
	.type	 ShortSwap,@function
ShortSwap:
	rlwinm 0,3,8,16,23
	rlwinm 3,3,24,24,31
	add 0,0,3
	extsh 3,0
	blr
.Lfe51:
	.size	 ShortSwap,.Lfe51-ShortSwap
	.align 2
	.globl ShortNoSwap
	.type	 ShortNoSwap,@function
ShortNoSwap:
	blr
.Lfe52:
	.size	 ShortNoSwap,.Lfe52-ShortNoSwap
	.align 2
	.globl LongSwap
	.type	 LongSwap,@function
LongSwap:
	slwi 0,3,24
	rlwinm 9,3,8,8,15
	rlwinm 11,3,24,16,23
	add 0,0,9
	add 0,0,11
	srwi 3,3,24
	add 3,0,3
	blr
.Lfe53:
	.size	 LongSwap,.Lfe53-LongSwap
	.align 2
	.globl LongNoSwap
	.type	 LongNoSwap,@function
LongNoSwap:
	blr
.Lfe54:
	.size	 LongNoSwap,.Lfe54-LongNoSwap
	.align 2
	.globl FloatSwap
	.type	 FloatSwap,@function
FloatSwap:
	stwu 1,-32(1)
	stfs 1,8(1)
	lwz 11,8(1)
	rlwimi 10,11,24,0,7
	rlwinm 0,11,24,24,31
	rlwimi 10,0,16,8,15
	rlwinm 9,11,16,24,31
	rlwimi 10,9,8,16,23
	rlwimi 10,11,8,24,31
	stw 10,8(1)
	lfs 0,8(1)
	fmr 1,0
	la 1,32(1)
	blr
.Lfe55:
	.size	 FloatSwap,.Lfe55-FloatSwap
	.align 2
	.globl FloatNoSwap
	.type	 FloatNoSwap,@function
FloatNoSwap:
	blr
.Lfe56:
	.size	 FloatNoSwap,.Lfe56-FloatNoSwap
	.comm	com_token,128,4
	.comm	paged_total,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
