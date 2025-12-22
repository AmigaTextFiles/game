	.file	"u_entmgr.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"*none*"
	.section	".text"
	.align 2
	.globl InsertItem
	.type	 InsertItem,@function
InsertItem:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	lis 9,game@ha
	li 30,1
	la 11,game@l(9)
	mr 24,3
	lwz 0,1556(11)
	mr 23,4
	li 22,0
	li 27,0
	cmpw 0,30,0
	bc 4,0,.L8
	lis 9,itemlist@ha
	mr 25,11
	la 28,itemlist@l(9)
	lis 26,.LC0@ha
	addi 29,28,104
	li 31,104
.L10:
	lwzx 3,31,28
	cmpwi 0,3,0
	bc 12,2,.L9
	la 4,.LC0@l(26)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L9
	mr 27,29
.L9:
	lwz 9,1556(25)
	addi 30,30,1
	subfic 0,27,0
	adde 11,0,27
	addi 29,29,104
	addi 31,31,104
	cmpw 7,30,9
	mfcr 0
	rlwinm 0,0,29,1
	and. 9,0,11
	bc 4,2,.L10
.L8:
	cmpwi 7,30,255
	subfic 11,27,0
	adde 9,11,27
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 11,9,0
	bc 12,2,.L13
	mulli 0,30,104
	lis 9,itemlist@ha
	li 22,1
	la 9,itemlist@l(9)
	add 27,0,9
.L13:
	cmpwi 0,27,0
	bc 12,2,.L14
	lis 9,spawns@ha
	li 29,0
	lwz 0,spawns@l(9)
	la 31,spawns@l(9)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L16
	lis 28,.LC0@ha
.L25:
	lwz 3,0(31)
	la 4,.LC0@l(28)
	addi 30,30,1
	bl Q_stricmp
	srawi 9,3,31
	cmpwi 0,30,1023
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	andc 9,31,0
	and 0,29,0
	addi 31,31,8
	or 29,0,9
	bc 12,1,.L16
	lwz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L25
.L16:
	cmpwi 0,29,0
	bc 4,2,.L26
	cmpwi 7,30,1022
	lwz 0,0(31)
	subfic 11,0,0
	adde 0,11,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and 0,0,9
	addic 0,0,-1
	subfe 0,0,0
	andc 29,31,0
	cmpwi 0,29,0
	bc 12,2,.L14
.L26:
	lfd 0,0(23)
	mr 3,27
	mr 4,24
	li 5,104
	stfd 0,0(29)
	crxor 6,6,6
	bl memcpy
	cmpwi 0,22,0
	bc 12,2,.L14
	lis 11,game@ha
	la 11,game@l(11)
	lwz 9,1556(11)
	addi 9,9,1
	stw 9,1556(11)
.L14:
	mr 3,24
	bl PrecacheItem
	mr 3,27
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 InsertItem,.Lfe1-InsertItem
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl InsertEntity
	.type	 InsertEntity,@function
InsertEntity:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,spawns@ha
	mr 27,3
	lwz 0,spawns@l(9)
	li 29,0
	la 31,spawns@l(9)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L32
	lis 28,.LC0@ha
.L34:
	lwz 3,0(31)
	la 4,.LC0@l(28)
	addi 30,30,1
	bl Q_stricmp
	srawi 9,3,31
	cmpwi 0,30,1023
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	andc 9,31,0
	and 0,29,0
	addi 31,31,8
	or 29,0,9
	bc 12,1,.L32
	lwz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L34
.L32:
	cmpwi 0,29,0
	bc 4,2,.L49
	cmpwi 7,30,1022
	lwz 0,0(31)
	subfic 9,0,0
	adde 0,9,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and 0,0,9
	addic 0,0,-1
	subfe 0,0,0
	andc 29,31,0
	cmpwi 0,29,0
	bc 12,2,.L39
.L49:
	lfd 0,0(27)
	stfd 0,0(29)
.L39:
	mr 3,29
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 InsertEntity,.Lfe2-InsertEntity
	.align 2
	.globl RemoveEntity
	.type	 RemoveEntity,@function
RemoveEntity:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,spawns@ha
	mr 28,3
	lwz 0,spawns@l(9)
	la 31,spawns@l(9)
	li 29,0
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L42
.L44:
	lwz 3,0(31)
	mr 4,28
	addi 29,29,1
	bl Q_stricmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	andc 11,31,0
	and 0,30,0
	lwzu 9,8(31)
	or. 30,0,11
	addic 0,9,-1
	subfe 11,0,9
	mfcr 0
	rlwinm 0,0,3,1
	and. 9,11,0
	bc 4,2,.L44
.L42:
	cmpwi 0,30,0
	bc 12,2,.L47
	lis 11,.LC0@ha
	lis 9,dummy2@ha
	la 11,.LC0@l(11)
	la 9,dummy2@l(9)
	stw 9,4(30)
	stw 11,0(30)
	b .L48
.L47:
	li 29,-1
.L48:
	mr 3,29
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 RemoveEntity,.Lfe3-RemoveEntity
	.align 2
	.globl booldummy
	.type	 booldummy,@function
booldummy:
	li 3,0
	blr
.Lfe4:
	.size	 booldummy,.Lfe4-booldummy
	.align 2
	.globl dummy1
	.type	 dummy1,@function
dummy1:
	blr
.Lfe5:
	.size	 dummy1,.Lfe5-dummy1
	.align 2
	.globl dummy2
	.type	 dummy2,@function
dummy2:
	blr
.Lfe6:
	.size	 dummy2,.Lfe6-dummy2
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
