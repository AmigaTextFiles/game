	.file	"matrix_misc.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"game"
	.align 2
.LC1:
	.string	""
	.align 2
.LC2:
	.string	"%s/%s"
	.align 2
.LC3:
	.string	"motd.ini"
	.align 2
.LC4:
	.string	"r"
	.section	".text"
	.align 2
	.globl Matrix_MOTD
	.type	 Matrix_MOTD,@function
Matrix_MOTD:
	stwu 1,-880(1)
	mflr 0
	stmw 29,868(1)
	stw 0,884(1)
	lis 9,gi+144@ha
	mr 30,3
	lwz 0,gi+144@l(9)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	li 5,0
	mtlr 0
	la 3,.LC0@l(3)
	addi 29,1,600
	blrl
	lwz 5,4(3)
	lis 4,.LC2@ha
	lis 6,.LC3@ha
	la 4,.LC2@l(4)
	la 6,.LC3@l(6)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	lis 4,.LC4@ha
	mr 3,29
	la 4,.LC4@l(4)
	bl fopen
	mr. 31,3
	bc 12,2,.L7
	addi 3,1,8
	li 4,500
	mr 5,31
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L8
	addi 29,1,520
	b .L9
.L11:
	addi 3,1,8
	mr 4,29
	bl strcat
.L9:
	mr 3,29
	li 4,80
	mr 5,31
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L11
	lis 9,gi+12@ha
	mr 3,30
	lwz 0,gi+12@l(9)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L8:
	mr 3,31
	bl fclose
.L7:
	lwz 0,884(1)
	mtlr 0
	lmw 29,868(1)
	la 1,880(1)
	blr
.Lfe1:
	.size	 Matrix_MOTD,.Lfe1-Matrix_MOTD
	.align 2
	.globl stuffcmd
	.type	 stuffcmd,@function
stuffcmd:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,11
	lwz 9,100(29)
	mr 28,4
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 stuffcmd,.Lfe2-stuffcmd
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
