	.file	"strsep.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	""
	.string	""
	.section	".text"
	.align 2
	.globl strsep
	.type	 strsep,@function
strsep:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,4
	lwz 30,0(3)
	lis 4,.LC0@ha
	mr 3,31
	la 4,.LC0@l(4)
	bl stricmp
	cmpwi 0,3,0
	mr 3,30
	bc 12,2,.L5
	mr 4,31
	bl strpbrk
	mr. 3,3
	bc 12,2,.L4
	li 0,0
	addi 9,3,1
	stb 0,0(3)
	stw 9,8(1)
	b .L5
.L4:
	li 3,0
.L5:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 strsep,.Lfe1-strsep
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
