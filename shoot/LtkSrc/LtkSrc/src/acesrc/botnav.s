	.file	"botnav.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl AntStartSearch
	.type	 AntStartSearch,@function
AntStartSearch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,4
	mr 28,5
	subfic 9,29,-1
	subfic 0,9,0
	adde 9,0,9
	mr 30,3
	subfic 0,28,-1
	subfic 10,0,0
	adde 0,10,0
	or. 11,9,0
	bc 4,2,.L27
	lis 9,level+4@ha
	lis 10,.LC0@ha
	lfs 13,952(30)
	lfs 11,level+4@l(9)
	la 10,.LC0@l(10)
	li 0,1
	lfd 12,0(10)
	lis 9,antSearch@ha
	stw 0,antSearch@l(9)
	fmr 0,11
	fsub 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L13
	stw 11,antSearch@l(9)
	lis 3,nodeused@ha
	li 4,0
	stfs 11,952(30)
	la 3,nodeused@l(3)
	li 5,4800
	crxor 6,6,6
	bl memset
	lis 3,nodefrom@ha
	li 4,-1
	la 3,nodefrom@l(3)
	li 5,2400
	bl memset
	addi 31,30,944
	b .L14
.L16:
	mr 3,31
	bl SLLpop_front
.L14:
	mr 3,31
	bl SLLempty
	cmpwi 0,3,0
	bc 12,2,.L16
	mr 3,30
	mr 4,29
	mr 5,28
	bl AntFindPath
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L26
.L13:
	mr 4,29
	mr 5,28
	mr 3,30
	bl AntQuickPath
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L26
	lis 3,nodeused@ha
	li 4,0
	la 3,nodeused@l(3)
	li 5,4800
	crxor 6,6,6
	bl memset
	lis 3,nodefrom@ha
	li 4,-1
	la 3,nodefrom@l(3)
	li 5,2400
	bl memset
	addi 31,30,944
	b .L21
.L23:
	mr 3,31
	bl SLLpop_front
.L21:
	mr 3,31
	bl SLLempty
	cmpwi 0,3,0
	bc 12,2,.L23
.L27:
	li 3,0
.L26:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 AntStartSearch,.Lfe1-AntStartSearch
	.align 2
	.globl AntQuickPath
	.type	 AntQuickPath,@function
AntQuickPath:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 26,3
	mr 28,4
	mr 31,5
	lis 3,nodeused@ha
	la 3,nodeused@l(3)
	li 4,0
	li 5,4800
	mr 29,28
	crxor 6,6,6
	bl memset
	lis 3,nodefrom@ha
	li 4,-1
	la 3,nodefrom@l(3)
	li 5,2400
	bl memset
	b .L29
.L31:
	mr 3,27
	bl SLLpop_front
.L29:
	addi 3,26,944
	mr 27,3
	bl SLLempty
	cmpwi 0,3,0
	bc 12,2,.L31
	lis 9,nodeused@ha
	slwi 11,28,2
	la 9,nodeused@l(9)
	li 0,1
	stwx 0,9,11
	cmpwi 7,28,-1
	b .L34
.L37:
	cmpwi 7,29,-1
	bc 12,30,.L35
	lis 9,nodeused@ha
	slwi 10,29,2
	la 8,nodeused@l(9)
	lwzx 0,8,10
	cmpwi 0,0,0
	bc 4,2,.L35
	lis 9,nodefrom@ha
	li 11,1
	la 9,nodefrom@l(9)
	add 0,29,29
	stwx 11,8,10
	sthx 30,9,0
.L34:
	bc 12,30,.L35
	mr 30,29
	add 0,31,31
	mulli 11,30,2400
	lis 9,path_table@ha
	mr 8,0
	la 9,path_table@l(9)
	add 0,0,11
	lhax 29,9,0
	cmpw 0,29,31
	bc 4,2,.L37
	lis 9,nodefrom@ha
	lis 11,nodeused@ha
	la 9,nodefrom@l(9)
	la 11,nodeused@l(11)
	slwi 10,31,2
	li 0,1
	sthx 30,9,8
	stwx 0,11,10
.L35:
	cmpw 0,29,31
	bc 4,2,.L44
	mr 3,27
	mr 4,31
	bl SLLpush_front
	cmpw 0,31,28
	bc 12,2,.L46
	lis 9,nodefrom@ha
	la 31,nodefrom@l(9)
.L47:
	add 29,29,29
	mr 3,27
	lhax 4,31,29
	bl SLLpush_front
	lhax 29,31,29
	cmpw 0,29,28
	bc 4,2,.L47
.L46:
	li 3,1
	b .L54
.L44:
	cmpw 0,30,28
	add 8,31,31
	mulli 4,28,2400
	bc 12,2,.L51
	lis 11,nodefrom@ha
	add 10,30,30
	la 11,nodefrom@l(11)
	lis 9,path_table@ha
	lhax 0,11,10
	la 9,path_table@l(9)
	mulli 0,0,2400
	add 10,8,0
.L52:
	bc 4,2,.L52
	li 0,-1
	sthx 0,9,10
.L51:
	lis 9,path_table@ha
	add 11,8,4
	la 9,path_table@l(9)
	li 0,-1
	sthx 0,9,11
	li 3,0
.L54:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 AntQuickPath,.Lfe2-AntQuickPath
	.align 2
	.globl AntFindPath
	.type	 AntFindPath,@function
AntFindPath:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stmw 21,36(1)
	stw 0,84(1)
	stw 12,32(1)
	mr 25,4
	mr 28,5
	subfic 0,25,-1
	subfic 9,0,0
	adde 0,9,0
	li 26,0
	subfic 9,28,-1
	subfic 11,9,0
	adde 9,11,9
	mr 21,3
	or. 11,0,9
	li 30,-1
	addi 9,1,8
	stw 26,4(9)
	mr 27,9
	stw 26,8(1)
	bc 4,2,.L71
	lis 9,nodefrom@ha
	add 0,25,25
	la 9,nodefrom@l(9)
	mr 3,27
	sthx 30,9,0
	mr 4,25
	bl SLLpush_back
	lis 9,nodeused@ha
	slwi 11,25,2
	la 9,nodeused@l(9)
	li 0,1
	stwx 0,9,11
	lis 22,nodeused@ha
	cmpw 4,30,28
	b .L58
.L60:
	mr 3,27
	li 26,0
	bl SLLfront
	li 23,1
	mr 29,3
	lis 10,nodes@ha
	mulli 11,29,116
	la 10,nodes@l(10)
	lis 9,nodefrom@ha
	la 24,nodefrom@l(9)
	add 11,11,10
	lha 30,20(11)
	addi 31,11,20
	b .L62
.L66:
	addi 26,26,1
	addi 31,31,8
	cmpwi 0,26,11
	bc 12,1,.L63
	lha 30,0(31)
.L62:
	cmpwi 0,30,-1
	cmpw 4,30,28
	bc 12,2,.L63
	la 11,nodeused@l(22)
	slwi 9,30,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L65
	add 0,30,30
	stwx 23,11,9
	mr 3,27
	sthx 29,24,0
	mr 4,30
	bl SLLpush_back
.L65:
	bc 4,18,.L66
.L63:
	mr 3,27
	bl SLLpop_front
.L58:
	mr 3,27
	bl SLLempty
	cmpwi 0,3,0
	bc 4,2,.L59
	bc 4,18,.L60
.L59:
	mr 3,27
	bl SLLdelete
	bc 4,18,.L71
	addi 3,21,944
	mr 4,30
	mr 26,3
	bl SLLpush_front
	lis 11,nodefrom@ha
	add 9,30,30
	la 8,nodefrom@l(11)
	lis 10,path_table@ha
	lhax 11,8,9
	la 10,path_table@l(10)
	mulli 0,11,2400
	add 9,9,0
	sthx 30,10,9
	mr 30,11
	cmpwi 0,30,-1
	bc 12,2,.L73
	cmpw 0,30,25
	bc 12,2,.L73
	mr 27,10
	add 31,28,28
	mr 29,8
.L74:
	mr 4,30
	mr 3,26
	bl SLLpush_front
	add 0,30,30
	lhax 0,29,0
	mulli 9,0,2400
	cmpwi 0,0,-1
	add 9,31,9
	sthx 30,27,9
	mr 30,0
	bc 12,2,.L73
	cmpw 0,0,25
	bc 4,2,.L74
.L73:
	li 3,1
	b .L77
.L71:
	li 3,0
.L77:
	lwz 0,84(1)
	lwz 12,32(1)
	mtlr 0
	lmw 21,36(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe3:
	.size	 AntFindPath,.Lfe3-AntFindPath
	.section	".rodata"
	.align 2
.LC1:
	.string	"Attempting to POP an empty list!\n"
	.section	".text"
	.align 2
	.globl AntInitSearch
	.type	 AntInitSearch,@function
AntInitSearch:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,nodeused@ha
	addi 31,3,944
	li 4,0
	li 5,4800
	la 3,nodeused@l(9)
	crxor 6,6,6
	bl memset
	lis 3,nodefrom@ha
	li 4,-1
	la 3,nodefrom@l(3)
	li 5,2400
	bl memset
	b .L7
.L9:
	bl SLLpop_front
.L7:
	mr 3,31
	bl SLLempty
	cmpwi 0,3,0
	mr 3,31
	bc 12,2,.L9
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 AntInitSearch,.Lfe4-AntInitSearch
	.align 2
	.globl AntLinkExists
	.type	 AntLinkExists,@function
AntLinkExists:
	subfic 11,3,-1
	subfic 0,11,0
	adde 11,0,11
	subfic 0,4,-1
	subfic 9,0,0
	adde 0,9,0
	mulli 3,3,116
	or. 9,11,0
	lis 9,nodes@ha
	li 11,0
	la 9,nodes@l(9)
	add 3,3,9
	bc 12,2,.L79
.L114:
	li 3,0
	blr
.L112:
	li 3,1
	blr
.L79:
	addi 3,3,20
.L82:
	lha 0,0(3)
	addi 3,3,8
	cmpw 0,0,4
	bc 12,2,.L112
	cmpwi 0,0,-1
	bc 12,2,.L114
	addi 11,11,1
	cmpwi 0,11,11
	bc 4,1,.L82
	li 3,0
	blr
.Lfe5:
	.size	 AntLinkExists,.Lfe5-AntLinkExists
	.align 2
	.globl SLLpush_front
	.type	 SLLpush_front,@function
SLLpush_front:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi+132@ha
	mr 31,3
	lwz 0,gi+132@l(9)
	mr 28,4
	li 3,8
	li 4,766
	lwz 29,0(31)
	mtlr 0
	blrl
	stw 3,0(31)
	stw 28,4(3)
	lwz 9,0(31)
	stw 29,0(9)
	lwz 9,0(31)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 4,2,.L88
	stw 9,4(31)
.L88:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SLLpush_front,.Lfe6-SLLpush_front
	.align 2
	.globl SLLpop_front
	.type	 SLLpop_front,@function
SLLpop_front:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	cmpwi 0,3,0
	lwz 11,0(3)
	bc 12,2,.L90
	cmpwi 0,11,0
	bc 12,2,.L90
	lwz 0,4(3)
	cmpw 0,11,0
	bc 4,2,.L91
	li 0,0
	stw 0,4(3)
	b .L115
.L91:
	lwz 0,0(11)
.L115:
	stw 0,0(3)
	lis 9,gi+136@ha
	mr 3,11
	lwz 0,gi+136@l(9)
	mtlr 0
	blrl
	b .L93
.L90:
	lis 4,.LC1@ha
	li 3,2
	la 4,.LC1@l(4)
	crxor 6,6,6
	bl safe_bprintf
.L93:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 SLLpop_front,.Lfe7-SLLpop_front
	.align 2
	.globl SLLfront
	.type	 SLLfront,@function
SLLfront:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	bc 12,2,.L95
	mr 3,31
	bl SLLempty
	cmpwi 0,3,0
	bc 4,2,.L95
	lwz 9,0(31)
	lwz 3,4(9)
	b .L116
.L95:
	li 3,-1
.L116:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 SLLfront,.Lfe8-SLLfront
	.align 2
	.globl SLLpush_back
	.type	 SLLpush_back,@function
SLLpush_back:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+132@ha
	mr 31,3
	lwz 0,gi+132@l(9)
	mr 29,4
	li 3,8
	li 4,766
	mtlr 0
	blrl
	li 9,0
	stw 29,4(3)
	stw 9,0(3)
	lwz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L98
	stw 3,4(31)
	stw 3,0(31)
	b .L99
.L98:
	lwz 9,4(31)
	stw 3,0(9)
	stw 3,4(31)
.L99:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 SLLpush_back,.Lfe9-SLLpush_back
	.align 2
	.globl SLLempty
	.type	 SLLempty,@function
SLLempty:
	mr. 3,3
	bc 4,2,.L101
	li 3,1
	blr
.L101:
	lwz 3,0(3)
	subfic 0,3,0
	adde 3,0,3
	blr
.Lfe10:
	.size	 SLLempty,.Lfe10-SLLempty
	.align 2
	.globl SLLdelete
	.type	 SLLdelete,@function
SLLdelete:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 30,24(1)
	stw 0,36(1)
	stw 12,20(1)
	mr. 31,3
	lis 9,gi@ha
	la 30,gi@l(9)
	mcrf 4,0
	b .L104
.L106:
	lwz 9,0(31)
	lwz 0,0(9)
	mr 3,9
	stw 0,0(31)
	lwz 9,136(30)
	mtlr 9
	blrl
.L104:
	bc 12,18,.L107
	lwz 0,0(31)
	subfic 9,0,0
	adde 0,9,0
	b .L108
.L107:
	li 0,1
.L108:
	cmpwi 0,0,0
	bc 12,2,.L106
	lwz 0,36(1)
	lwz 12,20(1)
	mtlr 0
	lmw 30,24(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe11:
	.size	 SLLdelete,.Lfe11-SLLdelete
	.comm	antSearch,4,4
	.comm	nodeused,4800,4
	.comm	nodefrom,2400,2
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
