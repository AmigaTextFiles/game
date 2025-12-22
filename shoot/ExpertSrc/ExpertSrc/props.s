	.file	"props.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s\t\t%s\n"
	.comm	gametype,4,4
	.section	".text"
	.align 2
	.globl newProps
	.type	 newProps,@function
newProps:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	li 3,8
	lis 28,p_stricmp@ha
	bl malloc
	mr 29,3
	la 4,p_stricmp@l(28)
	li 3,0
	bl listNew
	stw 3,0(29)
	la 4,p_stricmp@l(28)
	li 3,0
	bl listNew
	stw 3,4(29)
	mr 3,29
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 newProps,.Lfe1-newProps
	.align 2
	.globl freeProps
	.type	 freeProps,@function
freeProps:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 3,0(29)
	bl listFree
	lwz 3,4(29)
	bl listFree
	mr 3,29
	bl free
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 freeProps,.Lfe2-freeProps
	.align 2
	.globl printProps
	.type	 printProps,@function
printProps:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lwz 3,0(30)
	bl listSize
	mr 28,3
	cmpw 0,31,28
	bc 4,0,.L21
	lis 9,gi@ha
	lis 26,.LC0@ha
	la 27,gi@l(9)
.L23:
	lwz 3,0(30)
	mr 4,31
	bl listElementAt
	mr 29,3
	mr 4,31
	lwz 3,4(30)
	addi 31,31,1
	bl listElementAt
	lwz 9,8(27)
	mr 7,3
	mr 6,29
	li 3,0
	li 4,2
	la 5,.LC0@l(26)
	mtlr 9
	crxor 6,6,6
	blrl
	cmpw 0,31,28
	bc 12,0,.L23
.L21:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 printProps,.Lfe3-printProps
	.align 2
	.globl getProp
	.type	 getProp,@function
getProp:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 5,0
	lwz 3,0(31)
	bl listSearchPosition
	mr 4,3
	cmpwi 0,4,-1
	bc 12,2,.L17
	lwz 3,4(31)
	bl listElementAt
	b .L25
.L17:
	li 3,0
.L25:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 getProp,.Lfe4-getProp
	.align 2
	.globl addProp
	.type	 addProp,@function
addProp:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 29,4
	mr 30,5
	lwz 3,0(31)
	li 5,0
	bl listSearchPosition
	mr 28,3
	cmpwi 0,28,-1
	bc 12,2,.L12
	lwz 3,4(31)
	mr 4,28
	bl listElementAt
	bl free
	lwz 3,4(31)
	mr 4,28
	bl listDeleteAt
	mr 3,30
	bl strlen
	addi 3,3,1
	bl malloc
	lwz 29,4(31)
	mr 4,30
	bl strcpy
	mr 4,3
	mr 5,28
	mr 3,29
	bl listInsertAt
	b .L13
.L12:
	mr 3,29
	bl strlen
	addi 3,3,1
	bl malloc
	mr 28,3
	mr 3,30
	bl strlen
	addi 3,3,1
	bl malloc
	mr 4,29
	mr 27,3
	lwz 29,0(31)
	mr 3,28
	bl strcpy
	mr 4,3
	mr 3,29
	bl listAppend
	lwz 29,4(31)
	mr 4,30
	mr 3,27
	bl strcpy
	mr 4,3
	mr 3,29
	bl listAppend
.L13:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 addProp,.Lfe5-addProp
	.align 2
	.globl removeProp
	.type	 removeProp,@function
removeProp:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	li 5,0
	lwz 3,0(30)
	bl listSearchPosition
	mr 31,3
	cmpwi 0,31,-1
	bc 12,2,.L15
	lwz 3,0(30)
	mr 4,31
	bl listElementAt
	bl free
	lwz 3,4(30)
	mr 4,31
	bl listElementAt
	bl free
	lwz 3,0(30)
	mr 4,31
	bl listDeleteAt
	lwz 3,4(30)
	mr 4,31
	bl listDeleteAt
.L15:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 removeProp,.Lfe6-removeProp
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.align 2
	.globl p_stricmp
	.type	 p_stricmp,@function
p_stricmp:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 0,3
	cmpw 0,0,4
	li 3,1
	bc 12,2,.L26
	mr 3,0
	bl Q_stricmp
.L26:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 p_stricmp,.Lfe7-p_stricmp
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
