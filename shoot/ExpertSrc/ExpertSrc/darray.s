	.file	"darray.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl ArrayNew
	.type	 ArrayNew,@function
ArrayNew:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 26,3
	mr 29,4
	mr 27,5
	li 3,20
	bl malloc
	srawi 9,29,31
	mr 28,3
	subf 9,29,9
	li 11,0
	stw 27,16(28)
	srawi 9,9,31
	stw 11,8(28)
	nor 0,9,9
	and 29,29,9
	stw 26,4(28)
	andi. 0,0,10
	or 29,29,0
	mullw 3,26,29
	stw 29,12(28)
	bl malloc
	stw 3,0(28)
	mr 3,28
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 ArrayNew,.Lfe1-ArrayNew
	.align 2
	.globl ArrayReplaceComparator
	.type	 ArrayReplaceComparator,@function
ArrayReplaceComparator:
	stw 4,16(3)
	blr
.Lfe2:
	.size	 ArrayReplaceComparator,.Lfe2-ArrayReplaceComparator
	.align 2
	.globl ArrayFree
	.type	 ArrayFree,@function
ArrayFree:
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
.Lfe3:
	.size	 ArrayFree,.Lfe3-ArrayFree
	.align 2
	.globl ArraySize
	.type	 ArraySize,@function
ArraySize:
	lwz 3,8(3)
	blr
.Lfe4:
	.size	 ArraySize,.Lfe4-ArraySize
	.align 2
	.globl ArrayElementAt
	.type	 ArrayElementAt,@function
ArrayElementAt:
	lwz 0,4(3)
	lwz 3,0(3)
	mullw 0,0,4
	add 3,3,0
	blr
.Lfe5:
	.size	 ArrayElementAt,.Lfe5-ArrayElementAt
	.align 2
	.globl ArrayAppend
	.type	 ArrayAppend,@function
ArrayAppend:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,12(31)
	lwz 0,8(31)
	cmpw 0,9,0
	bc 12,1,.L24
	lwz 4,4(31)
	lwz 3,0(31)
	add 4,4,4
	mullw 4,9,4
	bl realloc
	lwz 0,12(31)
	stw 3,0(31)
	add 0,0,0
	stw 0,12(31)
.L24:
	lwz 3,4(31)
	mr 4,30
	lwz 0,8(31)
	mr 5,3
	lwz 9,0(31)
	mullw 3,3,0
	add 3,9,3
	crxor 6,6,6
	bl memcpy
	lwz 9,8(31)
	addi 9,9,1
	stw 9,8(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 ArrayAppend,.Lfe6-ArrayAppend
	.align 2
	.globl ArrayInsertAt
	.type	 ArrayInsertAt,@function
ArrayInsertAt:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 28,4
	lwz 9,12(31)
	mr 29,5
	lwz 0,8(31)
	cmpw 0,9,0
	bc 12,1,.L21
	lwz 4,4(31)
	lwz 3,0(31)
	add 4,4,4
	mullw 4,9,4
	bl realloc
	lwz 0,12(31)
	stw 3,0(31)
	add 0,0,0
	stw 0,12(31)
.L21:
	lwz 11,4(31)
	lwz 10,8(31)
	mullw 9,11,29
	lwz 0,0(31)
	cmpwi 0,10,0
	add 30,0,9
	bc 4,1,.L22
	mullw 5,11,10
	add 3,30,11
	mr 4,30
	subf 5,29,5
	bl memmove
.L22:
	lwz 5,4(31)
	mr 3,30
	mr 4,28
	crxor 6,6,6
	bl memcpy
	lwz 9,8(31)
	addi 9,9,1
	stw 9,8(31)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 ArrayInsertAt,.Lfe7-ArrayInsertAt
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
	.globl ArrayDeleteAt
	.type	 ArrayDeleteAt,@function
ArrayDeleteAt:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,8(31)
	lwz 9,12(31)
	add 0,0,0
	cmpw 0,9,0
	bc 4,1,.L13
	cmpwi 0,9,8
	bc 4,1,.L13
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
	lwz 4,4(31)
	lwz 3,0(31)
	stfd 0,16(1)
	lwz 9,20(1)
	mullw 4,9,4
	stw 9,12(31)
	bl realloc
	stw 3,0(31)
.L13:
	lwz 4,4(31)
	lwz 5,8(31)
	mullw 0,4,30
	lwz 3,0(31)
	mullw 5,4,5
	add 3,3,0
	subf 5,30,5
	add 4,3,4
	bl memmove
	lwz 9,8(31)
	addi 9,9,-1
	stw 9,8(31)
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 ArrayDeleteAt,.Lfe8-ArrayDeleteAt
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
	.globl ArrayDelete
	.type	 ArrayDelete,@function
ArrayDelete:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	bl ArraySearchPosition
	lwz 0,8(31)
	mr 30,3
	lwz 9,12(31)
	add 0,0,0
	cmpw 0,9,0
	bc 4,1,.L16
	cmpwi 0,9,8
	bc 4,1,.L16
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
	lwz 4,4(31)
	lwz 3,0(31)
	stfd 0,16(1)
	lwz 9,20(1)
	mullw 4,9,4
	stw 9,12(31)
	bl realloc
	stw 3,0(31)
.L16:
	lwz 4,4(31)
	lwz 5,8(31)
	mullw 0,4,30
	lwz 3,0(31)
	mullw 5,4,5
	add 3,3,0
	subf 5,30,5
	add 4,3,4
	bl memmove
	lwz 9,8(31)
	addi 9,9,-1
	stw 9,8(31)
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 ArrayDelete,.Lfe9-ArrayDelete
	.align 2
	.globl ArraySort
	.type	 ArraySort,@function
ArraySort:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lwz 6,16(9)
	lwz 3,0(9)
	lwz 4,8(9)
	lwz 5,4(9)
	bl qsort
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 ArraySort,.Lfe10-ArraySort
	.align 2
	.globl ArraySearch
	.type	 ArraySearch,@function
ArraySearch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,5,0
	mr 31,3
	mr 28,4
	bc 4,2,.L34
	lwz 0,8(31)
	li 29,0
	lwz 30,0(31)
	cmpw 0,29,0
	bc 4,0,.L41
.L37:
	lwz 9,16(31)
	mr 3,28
	mr 4,30
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L52
	lwz 9,8(31)
	addi 29,29,1
	lwz 0,4(31)
	cmpw 0,29,9
	add 30,30,0
	bc 12,0,.L37
.L41:
	li 9,-1
.L39:
	cmpwi 0,9,-1
	bc 4,2,.L42
	li 3,0
	b .L51
.L52:
	mr 9,29
	b .L39
.L42:
	lwz 3,4(31)
	lwz 0,0(31)
	mullw 3,3,9
	add 3,0,3
	b .L51
.L34:
	lwz 7,16(31)
	mr 3,28
	lwz 4,0(31)
	lwz 5,8(31)
	lwz 6,4(31)
	bl bsearch
.L51:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 ArraySearch,.Lfe11-ArraySearch
	.align 2
	.globl ArraySearchPosition
	.type	 ArraySearchPosition,@function
ArraySearchPosition:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 29,0
	lwz 0,8(31)
	mr 28,4
	lwz 30,0(31)
	cmpw 0,29,0
	bc 4,0,.L28
.L30:
	lwz 9,16(31)
	mr 3,28
	mr 4,30
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L31
	mr 3,29
	b .L53
.L31:
	lwz 9,8(31)
	addi 29,29,1
	lwz 0,4(31)
	cmpw 0,29,9
	add 30,30,0
	bc 12,0,.L30
.L28:
	li 3,-1
.L53:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ArraySearchPosition,.Lfe12-ArraySearchPosition
	.align 2
	.globl ArrayContains
	.type	 ArrayContains,@function
ArrayContains:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl ArraySearchPosition
	nor 3,3,3
	srwi 3,3,31
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 ArrayContains,.Lfe13-ArrayContains
	.align 2
	.globl ArrayMap
	.type	 ArrayMap,@function
ArrayMap:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	li 29,0
	lwz 0,8(30)
	mr 27,4
	mr 28,5
	lwz 31,0(30)
	cmpw 0,29,0
	bc 4,0,.L47
.L49:
	mr 3,31
	mr 4,28
	mtlr 27
	addi 29,29,1
	blrl
	lwz 0,8(30)
	lwz 9,4(30)
	cmpw 0,29,0
	add 31,31,9
	bc 12,0,.L49
.L47:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ArrayMap,.Lfe14-ArrayMap
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
