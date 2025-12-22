	.file	"z_hands.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl Think_Hands
	.type	 Think_Hands,@function
Think_Hands:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 30,-1
	lwz 9,84(31)
	li 29,-1
	lwz 10,4664(9)
	cmplwi 0,10,10
	bc 12,1,.L17
	lis 11,.L18@ha
	slwi 10,10,2
	la 11,.L18@l(11)
	lis 9,.L18@ha
	lwzx 0,10,11
	la 9,.L18@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L18:
	.long .L9-.L18
	.long .L9-.L18
	.long .L17-.L18
	.long .L17-.L18
	.long .L17-.L18
	.long .L17-.L18
	.long .L17-.L18
	.long .L19-.L18
	.long .L19-.L18
	.long .L17-.L18
	.long .L19-.L18
.L9:
	lwz 9,84(31)
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L10
	mr 3,31
	bl ChangeRightWeapon
	b .L19
.L10:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L19
	mr 3,31
	bl ChangeLeftWeapon
	b .L19
.L17:
	li 30,0
.L19:
	cmpwi 0,29,-1
	bc 12,2,.L22
	lwz 9,84(31)
	stw 29,92(9)
.L22:
	cmpwi 0,30,-1
	bc 12,2,.L23
	lwz 9,84(31)
	stw 30,4664(9)
.L23:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Think_Hands,.Lfe1-Think_Hands
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
