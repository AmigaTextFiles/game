	.file	"fileio.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"r"
	.align 2
.LC1:
	.string	"Could not open file \"%s\".\n"
	.align 2
.LC2:
	.string	"ERROR -- CloseFile() exception.\n"
	.section	".text"
	.align 2
	.globl OpenFile
	.type	 OpenFile,@function
OpenFile:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl fopen
	mr. 3,3
	bc 4,2,.L11
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
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 OpenFile,.Lfe1-OpenFile
	.align 2
	.globl CloseFile
	.type	 CloseFile,@function
CloseFile:
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
.Lfe2:
	.size	 CloseFile,.Lfe2-CloseFile
	.comm	maplist,292,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
