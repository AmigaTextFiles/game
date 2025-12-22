	.file	"list.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl listPointerCompare
	.type	 listPointerCompare,@function
listPointerCompare:
	cmplw 0,3,4
	li 3,-1
	bclr 12,0
	mfcr 3
	rlwinm 3,3,2,1
	blr
.Lfe1:
	.size	 listPointerCompare,.Lfe1-listPointerCompare
	.align 2
	.globl listStringCompare
	.type	 listStringCompare,@function
listStringCompare:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl strcmp
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 listStringCompare,.Lfe2-listStringCompare
	.align 2
	.globl listNew
	.type	 listNew,@function
listNew:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	mr 27,4
	li 3,16
	bl malloc
	srawi 9,29,31
	mr 28,3
	subf 9,29,9
	li 11,0
	stw 27,12(28)
	srawi 9,9,31
	stw 11,4(28)
	nor 0,9,9
	and 29,29,9
	andi. 0,0,10
	or 29,29,0
	slwi 3,29,2
	stw 29,8(28)
	bl malloc
	stw 3,0(28)
	mr 3,28
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 listNew,.Lfe3-listNew
	.align 2
	.globl listReplaceComparator
	.type	 listReplaceComparator,@function
listReplaceComparator:
	stw 4,12(3)
	blr
.Lfe4:
	.size	 listReplaceComparator,.Lfe4-listReplaceComparator
	.align 2
	.globl listFree
	.type	 listFree,@function
listFree:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 3,0(29)
	bl free
	mr 3,29
	bl free
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 listFree,.Lfe5-listFree
	.align 2
	.globl listSize
	.type	 listSize,@function
listSize:
	lwz 3,4(3)
	blr
.Lfe6:
	.size	 listSize,.Lfe6-listSize
	.align 2
	.globl listElementAt
	.type	 listElementAt,@function
listElementAt:
	lwz 9,0(3)
	slwi 4,4,2
	lwzx 3,4,9
	blr
.Lfe7:
	.size	 listElementAt,.Lfe7-listElementAt
	.align 2
	.globl listAppend
	.type	 listAppend,@function
listAppend:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 4,8(31)
	lwz 0,4(31)
	cmpw 0,4,0
	bc 12,1,.L34
	lwz 3,0(31)
	slwi 4,4,3
	bl realloc
	lwz 0,8(31)
	stw 3,0(31)
	add 0,0,0
	stw 0,8(31)
.L34:
	lwz 9,4(31)
	lwz 10,0(31)
	slwi 9,9,2
	stwx 30,9,10
	lwz 11,4(31)
	addi 11,11,1
	stw 11,4(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 listAppend,.Lfe8-listAppend
	.align 2
	.globl listInsertAt
	.type	 listInsertAt,@function
listInsertAt:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 27,4
	lwz 4,8(31)
	mr 28,5
	lwz 0,4(31)
	cmpw 0,4,0
	bc 12,1,.L31
	lwz 3,0(31)
	slwi 4,4,3
	bl realloc
	lwz 0,8(31)
	stw 3,0(31)
	add 0,0,0
	stw 0,8(31)
.L31:
	lwz 5,4(31)
	slwi 29,28,2
	lwz 30,0(31)
	cmpwi 0,5,0
	add 3,30,29
	bc 4,1,.L32
	subf 5,28,5
	mr 4,3
	slwi 5,5,2
	addi 3,3,4
	bl memmove
.L32:
	stwx 27,30,29
	lwz 9,4(31)
	addi 9,9,1
	stw 9,4(31)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 listInsertAt,.Lfe9-listInsertAt
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC1:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl listDeleteAt
	.type	 listDeleteAt,@function
listDeleteAt:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,4(31)
	lwz 9,8(31)
	add 0,0,0
	cmpw 0,9,0
	bc 4,1,.L25
	cmpwi 0,9,8
	bc 4,1,.L25
	xoris 0,9,0x8000
	lis 11,0x4330
	lis 10,.LC0@ha
	stw 0,20(1)
	la 10,.LC0@l(10)
	stw 11,16(1)
	lfd 1,16(1)
	lis 11,.LC1@ha
	lfd 13,0(10)
	la 11,.LC1@l(11)
	lfd 0,0(11)
	fsub 1,1,13
	fmul 1,1,0
	bl ceil
	fctiwz 0,1
	lwz 3,0(31)
	stfd 0,16(1)
	lwz 9,20(1)
	slwi 4,9,2
	stw 9,8(31)
	bl realloc
	stw 3,0(31)
.L25:
	lwz 3,0(31)
	slwi 0,30,2
	lwz 5,4(31)
	add 3,3,0
	subf 5,30,5
	addi 4,3,4
	slwi 5,5,2
	bl memmove
	lwz 9,4(31)
	addi 9,9,-1
	stw 9,4(31)
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 listDeleteAt,.Lfe10-listDeleteAt
	.align 2
	.globl listSort
	.type	 listSort,@function
listSort:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,12(3)
	lis 9,globalCompare@ha
	lis 6,listIndirectCompare@ha
	lwz 4,4(3)
	li 5,4
	la 6,listIndirectCompare@l(6)
	lwz 3,0(3)
	stw 0,globalCompare@l(9)
	bl qsort
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 listSort,.Lfe11-listSort
	.section	".rodata"
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC3:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl listDelete
	.type	 listDelete,@function
listDelete:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	bl listSearchPosition
	lwz 0,4(31)
	mr 30,3
	lwz 9,8(31)
	add 0,0,0
	cmpw 0,9,0
	bc 4,1,.L27
	cmpwi 0,9,8
	bc 4,1,.L27
	xoris 0,9,0x8000
	lis 11,0x4330
	lis 10,.LC2@ha
	stw 0,20(1)
	la 10,.LC2@l(10)
	stw 11,16(1)
	lfd 1,16(1)
	lis 11,.LC3@ha
	lfd 13,0(10)
	la 11,.LC3@l(11)
	lfd 0,0(11)
	fsub 1,1,13
	fmul 1,1,0
	bl ceil
	fctiwz 0,1
	lwz 3,0(31)
	stfd 0,16(1)
	lwz 9,20(1)
	slwi 4,9,2
	stw 9,8(31)
	bl realloc
	stw 3,0(31)
.L27:
	lwz 3,0(31)
	slwi 0,30,2
	lwz 5,4(31)
	add 3,3,0
	subf 5,30,5
	addi 4,3,4
	slwi 5,5,2
	bl memmove
	lwz 9,4(31)
	addi 9,9,-1
	stw 9,4(31)
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 listDelete,.Lfe12-listDelete
	.align 2
	.globl listSearch
	.type	 listSearch,@function
listSearch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	cmpwi 0,5,0
	mr 31,3
	stw 4,8(1)
	bc 4,2,.L47
	lwz 0,4(31)
	li 29,0
	lwz 30,0(31)
	cmpw 0,29,0
	bc 4,0,.L54
.L50:
	lwz 9,12(31)
	lwz 3,8(1)
	lwz 4,0(30)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L66
	lwz 0,4(31)
	addi 29,29,1
	addi 30,30,4
	cmpw 0,29,0
	bc 12,0,.L50
.L54:
	li 9,-1
.L52:
	cmpwi 0,9,-1
	bc 4,2,.L55
	li 3,0
	b .L65
.L66:
	mr 9,29
	b .L52
.L55:
	lwz 11,0(31)
	slwi 9,9,2
	lwzx 3,9,11
	b .L65
.L47:
	lwz 0,12(31)
	lis 9,globalCompare@ha
	lis 7,listIndirectCompare@ha
	lwz 5,4(31)
	la 7,listIndirectCompare@l(7)
	addi 3,1,8
	lwz 4,0(31)
	li 6,4
	stw 0,globalCompare@l(9)
	bl bsearch
	lwz 3,0(3)
.L65:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 listSearch,.Lfe13-listSearch
	.align 2
	.globl listSearchPosition
	.type	 listSearchPosition,@function
listSearchPosition:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	cmpwi 0,5,0
	mr 31,3
	stw 4,8(1)
	bc 4,2,.L37
	lwz 0,4(31)
	li 29,0
	lwz 30,0(31)
	cmpw 0,29,0
	bc 4,0,.L44
.L40:
	lwz 9,12(31)
	lwz 3,8(1)
	lwz 4,0(30)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L68
	lwz 0,4(31)
	addi 29,29,1
	addi 30,30,4
	cmpw 0,29,0
	bc 12,0,.L40
.L44:
	li 3,-1
	b .L67
.L68:
	mr 3,29
	b .L67
.L37:
	lwz 0,12(31)
	lis 9,globalCompare@ha
	lis 7,listIndirectCompare@ha
	lwz 4,0(31)
	la 7,listIndirectCompare@l(7)
	addi 3,1,8
	lwz 5,4(31)
	li 6,4
	stw 0,globalCompare@l(9)
	bl bsearch
	lwz 0,0(31)
	subf 3,0,3
	srawi 3,3,2
.L67:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 listSearchPosition,.Lfe14-listSearchPosition
	.align 2
	.globl listContains
	.type	 listContains,@function
listContains:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl listSearchPosition
	nor 3,3,3
	srwi 3,3,31
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 listContains,.Lfe15-listContains
	.align 2
	.globl listIterate
	.type	 listIterate,@function
listIterate:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	li 30,0
	lwz 0,4(29)
	mr 27,4
	mr 28,5
	lwz 31,0(29)
	cmpw 0,30,0
	bc 4,0,.L60
.L62:
	lwz 3,0(31)
	mr 4,28
	mtlr 27
	addi 30,30,1
	addi 31,31,4
	blrl
	lwz 0,4(29)
	cmpw 0,30,0
	bc 12,0,.L62
.L60:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 listIterate,.Lfe16-listIterate
	.section	".sbss","aw",@nobits
	.align 2
globalCompare:
	.space	4
	.size	 globalCompare,4
	.section	".text"
	.align 2
	.globl listIndirectCompare
	.type	 listIndirectCompare,@function
listIndirectCompare:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,globalCompare@ha
	lwz 3,0(3)
	lwz 0,globalCompare@l(9)
	lwz 4,0(4)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 listIndirectCompare,.Lfe17-listIndirectCompare
	.align 2
	.globl linearSearch
	.type	 linearSearch,@function
linearSearch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 30,0
	lwz 0,4(29)
	mr 28,4
	lwz 31,0(29)
	cmpw 0,30,0
	bc 4,0,.L19
.L21:
	lwz 9,12(29)
	mr 3,28
	lwz 4,0(31)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L22
	mr 3,30
	b .L69
.L22:
	lwz 0,4(29)
	addi 30,30,1
	addi 31,31,4
	cmpw 0,30,0
	bc 12,0,.L21
.L19:
	li 3,-1
.L69:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 linearSearch,.Lfe18-linearSearch
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
