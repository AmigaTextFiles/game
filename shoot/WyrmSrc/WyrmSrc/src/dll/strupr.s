	.file	"strupr.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl strupr
	.type	 strupr,@function
strupr:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr. 30,3
	bc 12,2,.L2
	li 31,0
	lis 29,_ctype_@ha
	b .L4
.L7:
	lbzx 10,30,31
	lwz 9,_ctype_@l(29)
	addi 8,10,-32
	add 9,10,9
	lbz 11,1(9)
	andi. 0,11,2
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	andc 8,8,0
	and 10,10,0
	or 10,10,8
	stbx 10,30,31
	addi 31,31,1
.L4:
	mr 3,30
	bl strlen
	cmplw 0,31,3
	bc 12,0,.L7
.L2:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 strupr,.Lfe1-strupr
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
