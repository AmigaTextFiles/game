	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Svcmd_Test_f()\n"
	.align 2
.LC1:
	.string	"test"
	.align 2
.LC2:
	.string	"Unknown server command \"%s\"\n"
	.section	".text"
	.align 2
	.globl ServerCommand
	.type	 ServerCommand,@function
ServerCommand:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L8
	lwz 0,8(30)
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L10
.L8:
	lwz 0,8(30)
	lis 5,.LC2@ha
	mr 6,31
	la 5,.LC2@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L10:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 ServerCommand,.Lfe1-ServerCommand
	.align 2
	.globl Svcmd_Test_f
	.type	 Svcmd_Test_f,@function
Svcmd_Test_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 Svcmd_Test_f,.Lfe2-Svcmd_Test_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
