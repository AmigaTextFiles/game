	.file	"randspaw.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl findspawnpoint
	.type	 findspawnpoint,@function
findspawnpoint:
	stwu 1,-176(1)
	mflr 0
	stfd 31,168(1)
	stmw 23,132(1)
	stw 0,180(1)
	mr 30,3
	li 4,0
	addi 3,1,8
	li 5,12
	mr 24,3
	lis 28,0x3ff
	crxor 6,6,6
	bl memset
	addi 27,24,8
	li 26,0
	lis 9,.LC0@ha
	li 29,0
	la 9,.LC0@l(9)
	lis 23,gi@ha
	lfd 31,0(9)
	ori 28,28,57345
	lis 25,0x4330
.L17:
	addi 26,26,1
	mr 31,24
.L22:
	bl rand
	mulhw 9,3,28
	srawi 11,3,31
	srawi 9,9,7
	subf 9,11,9
	slwi 0,9,13
	add 0,0,9
	subf 3,0,3
	addi 3,3,-4096
	xoris 3,3,0x8000
	stw 3,124(1)
	stw 25,120(1)
	lfd 0,120(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,0(31)
	addi 31,31,4
	cmpw 0,31,27
	bc 4,1,.L22
	la 31,gi@l(23)
	addi 3,1,8
	lwz 9,52(31)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L24
	lwz 11,48(31)
	li 9,59
	addi 3,1,40
	lfs 13,8(1)
	addi 4,1,8
	addi 5,30,200
	lfs 0,12(1)
	addi 6,30,188
	addi 7,1,24
	mtlr 11
	li 8,0
	lis 0,0xc580
	stw 0,32(1)
	addi 29,29,1
	stfs 13,24(1)
	stfs 0,28(1)
	blrl
	lwz 0,88(1)
	andi. 9,0,56
	bc 4,2,.L24
	lfs 0,196(30)
	addi 3,1,8
	lfs 13,208(30)
	lfs 12,60(1)
	lwz 0,52(31)
	fsubs 13,13,0
	lfs 11,56(1)
	lfs 0,52(1)
	mtlr 0
	fadds 12,12,13
	stfs 11,12(1)
	stfs 0,8(1)
	stfs 12,16(1)
	blrl
	subfic 0,3,0
	adde 3,0,3
	b .L16
.L24:
	li 3,0
.L16:
	cmpwi 0,3,0
	cmpwi 7,26,1000
	mcrf 1,0
	mfcr 0
	rlwinm 9,0,3,1
	rlwinm 0,0,29,1
	mcrf 6,7
	and. 11,9,0
	bc 12,2,.L15
	cmpwi 0,29,500
	bc 4,0,.L15
	cror 27,26,25
	mfcr 0
	rlwinm 0,0,28,1
	or. 9,3,0
	bc 12,2,.L17
.L15:
	bc 4,6,.L31
	cmpwi 7,29,500
	cror 27,26,25
	cror 31,30,29
	mfcr 0
	rlwinm 9,0,28,1
	rlwinm 0,0,0,1
	or. 11,9,0
	bc 12,2,.L31
	li 3,0
	b .L32
.L31:
	lfs 0,8(1)
	li 3,1
	lfs 13,12(1)
	lfs 12,16(1)
	stfs 0,28(30)
	stfs 13,32(30)
	stfs 12,36(30)
	stfs 0,4(30)
	stfs 13,8(30)
	stfs 12,12(30)
.L32:
	lwz 0,180(1)
	mtlr 0
	lmw 23,132(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe1:
	.size	 findspawnpoint,.Lfe1-findspawnpoint
	.section	".rodata"
	.align 2
.LC1:
	.string	"doesn't exist"
	.align 2
.LC2:
	.string	"%s Added at %d,%d,%d\n"
	.section	".text"
	.align 2
	.globl spawn_random_item
	.type	 spawn_random_item,@function
spawn_random_item:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	bl FindItemByClassname
	mr. 30,3
	bc 4,2,.L34
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L38
.L34:
	bl G_Spawn
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	li 4,766
	lwz 9,132(29)
	li 3,64
	mtlr 9
	blrl
	mr 0,3
	mr 4,28
	stw 0,280(31)
	bl strcpy
	stw 30,744(31)
	lis 9,Touch_Item@ha
	lis 11,0xc170
	lwz 8,28(30)
	lis 0,0x4170
	la 9,Touch_Item@l(9)
	li 10,512
	stw 9,540(31)
	mr 3,31
	stw 8,64(31)
	stw 10,68(31)
	stw 11,196(31)
	stw 0,208(31)
	stw 11,188(31)
	stw 11,192(31)
	stw 0,200(31)
	stw 0,204(31)
	lwz 0,44(29)
	lwz 4,24(30)
	mtlr 0
	blrl
	li 0,1
	li 9,9
	stw 31,256(31)
	stw 0,248(31)
	stw 9,260(31)
.L37:
	mr 3,31
	bl findspawnpoint
	cmpwi 0,3,0
	bc 12,2,.L37
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,72(29)
	mtlr 9
	blrl
	lfs 12,4(31)
	lis 3,.LC2@ha
	lfs 13,8(31)
	mr 6,5
	mr 7,5
	lfs 0,12(31)
	la 3,.LC2@l(3)
	lwz 0,4(29)
	lwz 4,280(31)
	mtlr 0
	fctiwz 11,12
	fctiwz 10,13
	fctiwz 9,0
	stfd 11,8(1)
	lwz 5,12(1)
	stfd 10,8(1)
	lwz 6,12(1)
	stfd 9,8(1)
	lwz 7,12(1)
	crxor 6,6,6
	blrl
	li 3,1
.L38:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 spawn_random_item,.Lfe2-spawn_random_item
	.section	".rodata"
	.align 2
.LC3:
	.string	"game"
	.align 2
.LC4:
	.string	""
	.align 2
.LC5:
	.string	"/config/"
	.align 2
.LC6:
	.string	".rif"
	.align 2
.LC7:
	.string	"rt"
	.align 2
.LC8:
	.string	"No Random item file found\n"
	.align 2
.LC9:
	.string	"%63s"
	.align 2
.LC10:
	.string	"Error in config/%s.rif on line %d!\n"
	.align 2
.LC11:
	.string	"fuck up at line %d\n"
	.section	".text"
	.align 2
	.globl load_random_items
	.type	 load_random_items,@function
load_random_items:
	stwu 1,-624(1)
	mflr 0
	stmw 23,588(1)
	stw 0,628(1)
	lis 9,gi@ha
	lis 3,.LC3@ha
	la 27,gi@l(9)
	lis 4,.LC4@ha
	lwz 9,144(27)
	li 5,0
	la 4,.LC4@l(4)
	la 3,.LC3@l(3)
	addi 28,1,8
	mtlr 9
	lis 23,level+92@ha
	blrl
	lwz 4,4(3)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	mr 29,3
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	add 3,28,29
	crxor 6,6,6
	bl sprintf
	add 29,29,3
	lis 4,level+92@ha
	la 4,level+92@l(4)
	add 3,28,29
	crxor 6,6,6
	bl sprintf
	add 29,29,3
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	add 3,28,29
	crxor 6,6,6
	bl sprintf
	lis 4,.LC7@ha
	mr 3,28
	la 4,.LC7@l(4)
	bl fopen
	mr. 31,3
	bc 4,2,.L40
	lwz 0,4(27)
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L57
.L40:
	lhz 0,12(31)
	li 30,0
	andi. 9,0,32
	bc 4,2,.L42
	addi 28,1,328
	li 24,0
	lis 25,.LC9@ha
	lis 26,.LC10@ha
.L43:
	addi 30,30,1
	li 29,0
	b .L44
.L46:
	stbx 3,28,29
	addi 29,29,1
.L44:
	cmpwi 0,29,253
	bc 12,1,.L49
	mr 3,31
	bl fgetc
	cmpwi 0,3,10
	bc 12,2,.L49
	cmpwi 0,3,-1
	bc 4,2,.L46
.L49:
	stbx 24,28,29
	lbz 0,328(1)
	xori 9,0,35
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 0,0,9
	bc 4,2,.L41
	addi 29,1,264
	stb 0,264(1)
	la 4,.LC9@l(25)
	mr 5,29
	mr 3,28
	crxor 6,6,6
	bl sscanf
	mr 3,29
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L53
	mr 3,29
	bl FindItemByClassname
	cmpwi 0,3,0
	bc 4,2,.L52
.L53:
	lwz 9,4(27)
	la 3,.LC10@l(26)
	la 4,level+92@l(23)
	mr 5,30
	mtlr 9
	crxor 6,6,6
	blrl
	b .L41
.L52:
	mr 3,29
	bl spawn_random_item
	cmpwi 0,3,0
	bc 4,2,.L41
	lwz 9,4(27)
	lis 3,.LC11@ha
	mr 4,30
	la 3,.LC11@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
.L41:
	lhz 0,12(31)
	andi. 9,0,32
	bc 12,2,.L43
.L42:
	mr 3,31
	bl fclose
	li 3,1
.L57:
	lwz 0,628(1)
	mtlr 0
	lmw 23,588(1)
	la 1,624(1)
	blr
.Lfe3:
	.size	 load_random_items,.Lfe3-load_random_items
	.comm	maplist,292,4
	.align 2
	.globl GetLineFromFile
	.type	 GetLineFromFile,@function
GetLineFromFile:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	mr 30,4
	li 31,0
	b .L7
.L10:
	stbx 3,30,31
	addi 31,31,1
.L7:
	cmpwi 0,31,253
	bc 12,1,.L8
	mr 3,29
	bl fgetc
	cmpwi 0,3,10
	bc 12,2,.L8
	cmpwi 0,3,-1
	bc 4,2,.L10
.L8:
	li 0,0
	mr 3,31
	stbx 0,30,31
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 GetLineFromFile,.Lfe4-GetLineFromFile
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
