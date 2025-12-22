	.file	"p_menu.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"warning, ent already has a menu\n"
	.align 2
.LC1:
	.string	"warning:  ent has no menu\n"
	.align 2
.LC2:
	.string	"xv 32 yv 8 picn inventory "
	.align 2
.LC3:
	.string	"yv %d "
	.align 2
.LC4:
	.string	"xv %d "
	.align 2
.LC5:
	.string	"string2 \"\r%s\" "
	.align 2
.LC6:
	.string	"string2 \"%s\" "
	.align 2
.LC7:
	.string	"string \"%s\" "
	.section	".text"
	.align 2
	.globl PMenu_Update
	.type	 PMenu_Update,@function
PMenu_Update:
	stwu 1,-1456(1)
	mflr 0
	stmw 24,1424(1)
	stw 0,1460(1)
	lwz 9,84(3)
	li 24,0
	lwz 27,3516(9)
	cmpwi 0,27,0
	bc 4,2,.L23
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L22
.L23:
	lis 9,.LC2@ha
	addi 11,1,8
	lwz 4,.LC2@l(9)
	li 26,0
	mr 30,11
	la 9,.LC2@l(9)
	lwz 0,4(9)
	lbz 3,26(9)
	lwz 10,8(9)
	lwz 8,12(9)
	lwz 7,16(9)
	lwz 6,20(9)
	lhz 5,24(9)
	stw 4,8(1)
	stw 0,4(11)
	stw 10,8(11)
	stw 8,12(11)
	stw 7,16(11)
	stw 6,20(11)
	sth 5,24(11)
	stb 3,26(11)
	lwz 0,8(27)
	lwz 28,0(27)
	cmpw 0,26,0
	bc 4,0,.L25
	li 25,32
.L27:
	lwz 3,0(28)
	cmpwi 0,3,0
	bc 12,2,.L26
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L26
	cmpwi 0,0,42
	mr 31,3
	bc 4,2,.L30
	li 24,1
	addi 31,31,1
.L30:
	addi 3,1,8
	bl strlen
	lis 4,.LC3@ha
	add 3,30,3
	la 4,.LC3@l(4)
	mr 5,25
	crxor 6,6,6
	bl sprintf
	lwz 0,4(28)
	cmpwi 0,0,1
	bc 4,2,.L31
	mr 3,31
	bl strlen
	slwi 3,3,2
	subfic 29,3,162
	b .L32
.L31:
	cmpwi 0,0,2
	bc 4,2,.L33
	mr 3,31
	bl strlen
	slwi 3,3,3
	subfic 29,3,260
	b .L32
.L33:
	li 29,64
.L32:
	addi 3,1,8
	bl strlen
	lwz 5,4(27)
	lis 4,.LC4@ha
	add 3,30,3
	la 4,.LC4@l(4)
	xor 5,5,26
	subfic 0,5,0
	adde 5,0,5
	slwi 5,5,3
	subf 5,5,29
	crxor 6,6,6
	bl sprintf
	lwz 0,4(27)
	cmpw 0,0,26
	bc 4,2,.L35
	mr 3,30
	bl strlen
	lis 4,.LC5@ha
	mr 5,31
	la 4,.LC5@l(4)
	b .L40
.L35:
	cmpwi 0,24,0
	bc 12,2,.L37
	mr 3,30
	bl strlen
	lis 4,.LC6@ha
	mr 5,31
	la 4,.LC6@l(4)
.L40:
	add 3,30,3
	crxor 6,6,6
	bl sprintf
	b .L36
.L37:
	mr 3,30
	bl strlen
	lis 4,.LC7@ha
	mr 5,31
	la 4,.LC7@l(4)
	add 3,30,3
	crxor 6,6,6
	bl sprintf
.L36:
	li 24,0
.L26:
	lwz 0,8(27)
	addi 26,26,1
	addi 25,25,8
	addi 28,28,16
	cmpw 0,26,0
	bc 12,0,.L27
.L25:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	addi 3,1,8
	mtlr 0
	blrl
.L22:
	lwz 0,1460(1)
	mtlr 0
	lmw 24,1424(1)
	la 1,1456(1)
	blr
.Lfe1:
	.size	 PMenu_Update,.Lfe1-PMenu_Update
	.align 2
	.globl PMenu_Open
	.type	 PMenu_Open,@function
PMenu_Open:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 28,4
	lwz 9,84(31)
	mr 30,5
	mr 29,6
	cmpwi 0,9,0
	bc 12,2,.L6
	lwz 0,3516(9)
	cmpwi 0,0,0
	bc 12,2,.L8
	lis 9,gi@ha
	lis 3,.LC0@ha
	la 9,gi@l(9)
	la 3,.LC0@l(3)
	lwz 0,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl PMenu_Close
.L8:
	li 3,12
	bl malloc
	cmpwi 0,30,0
	mr 10,3
	stw 28,0(10)
	stw 29,8(10)
	bc 12,0,.L10
	slwi 9,30,4
	add 9,9,28
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 4,2,.L9
.L10:
	li 5,0
	mr 4,28
	cmpw 0,5,29
	bc 4,0,.L65
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L17
.L13:
	addi 5,5,1
	addi 4,4,16
	cmpw 0,5,29
	bc 4,0,.L65
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 12,2,.L13
	b .L17
.L9:
	mr 5,30
.L17:
	cmpw 0,5,29
	bc 12,0,.L18
.L65:
	li 0,-1
	stw 0,4(10)
	b .L19
.L18:
	stw 5,4(10)
.L19:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3508(11)
	lwz 9,84(31)
	stw 0,3512(9)
	lwz 11,84(31)
	stw 10,3516(11)
	bl PMenu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 PMenu_Open,.Lfe2-PMenu_Open
	.align 2
	.globl PMenu_Close
	.type	 PMenu_Close,@function
PMenu_Close:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3516(9)
	cmpwi 0,3,0
	bc 12,2,.L20
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3516(9)
	lwz 11,84(31)
	stw 0,3508(11)
.L20:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 PMenu_Close,.Lfe3-PMenu_Close
	.align 2
	.globl PMenu_Next
	.type	 PMenu_Next,@function
PMenu_Next:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 10,3516(9)
	cmpwi 0,10,0
	bc 4,2,.L42
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L41
.L42:
	lwz 9,4(10)
	cmpwi 0,9,0
	bc 12,0,.L41
	lwz 0,0(10)
	mr 11,9
	slwi 9,11,4
	lwz 7,8(10)
	mr 8,0
	add 9,0,9
.L49:
	addi 11,11,1
	addi 9,9,16
	cmpw 0,11,7
	bc 4,2,.L47
	li 11,0
	mr 9,8
.L47:
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 4,2,.L45
	lwz 0,4(10)
	cmpw 0,11,0
	bc 4,2,.L49
.L45:
	mr 3,31
	stw 11,4(10)
	bl PMenu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L41:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 PMenu_Next,.Lfe4-PMenu_Next
	.align 2
	.globl PMenu_Prev
	.type	 PMenu_Prev,@function
PMenu_Prev:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 10,3516(9)
	cmpwi 0,10,0
	bc 4,2,.L51
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L50
.L51:
	lwz 0,4(10)
	cmpwi 0,0,0
	bc 12,0,.L50
	mr 11,0
	lwz 0,0(10)
	slwi 9,11,4
	mr 8,0
	add 9,0,9
.L59:
	cmpwi 0,11,0
	bc 4,2,.L56
	lwz 9,8(10)
	addi 11,9,-1
	slwi 0,11,4
	add 9,8,0
	b .L57
.L56:
	addi 11,11,-1
	addi 9,9,-16
.L57:
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 4,2,.L54
	lwz 0,4(10)
	cmpw 0,11,0
	bc 4,2,.L59
.L54:
	mr 3,31
	stw 11,4(10)
	bl PMenu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L50:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 PMenu_Prev,.Lfe5-PMenu_Prev
	.align 2
	.globl PMenu_Select
	.type	 PMenu_Select,@function
PMenu_Select:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 9,3516(9)
	cmpwi 0,9,0
	bc 4,2,.L61
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L60
.L61:
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,0,.L60
	lwz 9,0(9)
	slwi 0,0,4
	add 4,9,0
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 12,2,.L60
	mtlr 0
	blrl
.L60:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 PMenu_Select,.Lfe6-PMenu_Select
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
