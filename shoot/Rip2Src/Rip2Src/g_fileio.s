	.file	"g_fileio.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"r"
	.align 2
.LC1:
	.string	"Couldn't open file \"%s\".\n"
	.align 2
.LC2:
	.string	"ERROR -- CloseFile() exception.\n"
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".text"
	.align 2
	.globl CloseFile1
	.type	 CloseFile1,@function
CloseFile1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 3,3
	bc 12,2,.L9
	bl fclose
	b .L10
.L9:
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L10:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe1:
	.size	 CloseFile1,.Lfe1-CloseFile1
	.align 2
	.globl OpenFile1
	.type	 OpenFile1,@function
OpenFile1:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,4
	mr 31,3
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl fopen
	cmpwi 0,3,0
	bc 12,2,.L7
	mr 3,31
	mr 4,30
	bl fopen
	b .L11
.L7:
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
.L11:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 OpenFile1,.Lfe2-OpenFile1
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
