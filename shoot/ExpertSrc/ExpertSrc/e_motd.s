	.file	"e_motd.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s/%s"
	.align 2
.LC1:
	.string	"motd.txt"
	.align 2
.LC2:
	.string	"r"
	.align 2
.LC3:
	.string	"ERROR: Ran out of memory while initializing MOTD. Continuting execution.\n"
	.section	".text"
	.align 2
	.globl InitMOTD
	.type	 InitMOTD,@function
InitMOTD:
	stwu 1,-288(1)
	mflr 0
	stmw 28,272(1)
	stw 0,292(1)
	lis 9,levelCycle@ha
	lis 11,gamedir@ha
	lwz 10,levelCycle@l(9)
	lis 3,.LC0@ha
	lis 5,.LC1@ha
	lwz 9,gamedir@l(11)
	la 5,.LC1@l(5)
	la 3,.LC0@l(3)
	lwz 4,4(10)
	lwz 29,4(9)
	crxor 6,6,6
	bl va
	mr 4,3
	lis 5,.LC2@ha
	mr 3,29
	la 5,.LC2@l(5)
	bl OpenGamedirFile
	mr. 28,3
	bc 12,2,.L7
	li 3,1
	li 4,1
	bl calloc
	li 30,1
	mr. 31,3
	bc 4,2,.L9
	b .L16
.L11:
	addi 3,1,8
	bl strlen
	mr 29,3
	add 30,30,29
	mr 3,31
	mr 4,30
	bl realloc
	mr. 31,3
	bc 12,2,.L16
	mr 5,29
	mr 3,31
	addi 4,1,8
	bl strncat
.L9:
	addi 3,1,8
	li 4,256
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L11
	lis 9,gi+132@ha
	li 4,766
	lwz 0,gi+132@l(9)
	mr 3,30
	lis 29,motd@ha
	mtlr 0
	blrl
	mr 5,30
	mr 4,31
	stw 3,motd@l(29)
	bl strncpy
	mr 3,28
	bl fclose
	mr 3,31
	bl free
	b .L6
.L16:
	lis 9,gi+4@ha
	lis 3,.LC3@ha
	lwz 0,gi+4@l(9)
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,28
	bl fclose
	b .L6
.L7:
	lis 9,motd@ha
	stw 28,motd@l(9)
.L6:
	lwz 0,292(1)
	mtlr 0
	lmw 28,272(1)
	la 1,288(1)
	blr
.Lfe1:
	.size	 InitMOTD,.Lfe1-InitMOTD
	.section	".rodata"
	.align 2
.LC4:
	.string	"Expert Quake2 v%s\nhttp://www.planetquake.com/expert/\n\n\"settings\" for settings\n\n%s"
	.align 2
.LC5:
	.string	"3.2"
	.align 2
.LC6:
	.string	"Expert Quake2 v%s\nhttp://www.planetquake.com/expert/\n"
	.align 2
.LC7:
	.string	"Expert %s - \"help\" for info\n"
	.align 2
.LC8:
	.string	"Arena"
	.align 2
.LC9:
	.string	"DM"
	.align 2
.LC10:
	.string	"Teams"
	.align 2
.LC11:
	.string	"CTF"
	.align 2
.LC12:
	.string	"The following options are in effect: "
	.align 2
.LC13:
	.string	"%s"
	.align 2
.LC14:
	.string	", %s"
	.align 2
.LC15:
	.string	"\n"
	.align 2
.LC16:
	.string	"Pace multiplier is %.2f\n"
	.align 2
.LC17:
	.string	"Lethality multiplier is %.2f\n"
	.section	".text"
	.align 2
	.globl DisplaySettings
	.type	 DisplaySettings,@function
DisplaySettings:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	lis 9,gi@ha
	mr 31,3
	la 9,gi@l(9)
	lis 5,.LC12@ha
	lwz 0,8(9)
	la 5,.LC12@l(5)
	li 4,1
	mr 26,9
	mtlr 0
	li 27,1
	li 30,0
	lis 23,sv_expflags@ha
	lis 24,.LC13@ha
	lis 25,.LC14@ha
	crxor 6,6,6
	blrl
	lis 9,e_bits@ha
	la 29,e_bits@l(9)
	mr 28,29
.L31:
	lwz 11,sv_expflags@l(23)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	sraw 9,9,30
	andi. 0,9,1
	bc 12,2,.L30
	cmpwi 0,27,0
	bc 12,2,.L33
	lwz 9,8(26)
	mr 3,31
	li 4,1
	la 5,.LC13@l(24)
	mr 6,29
	mtlr 9
	li 27,0
	crxor 6,6,6
	blrl
	b .L30
.L33:
	lwz 9,8(26)
	mr 3,31
	li 4,1
	la 5,.LC14@l(25)
	mr 6,28
	mtlr 9
	crxor 6,6,6
	blrl
.L30:
	addi 30,30,1
	addi 28,28,25
	cmpwi 0,30,18
	addi 29,29,25
	bc 4,1,.L31
	lis 29,gi@ha
	lis 5,.LC15@ha
	la 29,gi@l(29)
	la 5,.LC15@l(5)
	lwz 9,8(29)
	mr 3,31
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,sv_pace@ha
	lwz 10,8(29)
	lis 5,.LC16@ha
	lwz 11,sv_pace@l(9)
	la 5,.LC16@l(5)
	mr 3,31
	li 4,1
	mtlr 10
	lfs 1,20(11)
	creqv 6,6,6
	blrl
	lis 9,sv_lethality@ha
	lwz 0,8(29)
	lis 5,.LC17@ha
	lwz 11,sv_lethality@l(9)
	mr 3,31
	la 5,.LC17@l(5)
	li 4,1
	mtlr 0
	lfs 1,20(11)
	creqv 6,6,6
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 DisplaySettings,.Lfe2-DisplaySettings
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.align 2
	.globl DisplayMOTD
	.type	 DisplayMOTD,@function
DisplayMOTD:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,motd@ha
	lwz 6,motd@l(9)
	cmpwi 0,6,0
	bc 12,2,.L18
	lis 9,gi+12@ha
	lis 4,.LC4@ha
	lwz 0,gi+12@l(9)
	lis 5,.LC5@ha
	la 4,.LC4@l(4)
	la 5,.LC5@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L19
.L18:
	lis 9,gi+12@ha
	lis 4,.LC6@ha
	lwz 0,gi+12@l(9)
	lis 5,.LC5@ha
	la 4,.LC6@l(4)
	la 5,.LC5@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
.L19:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 DisplayMOTD,.Lfe3-DisplayMOTD
	.align 2
	.globl DisplayRespawnLine
	.type	 DisplayRespawnLine,@function
DisplayRespawnLine:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gametype@ha
	lis 11,gi@ha
	lwz 0,gametype@l(9)
	la 11,gi@l(11)
	cmpwi 0,0,3
	bc 12,2,.L21
	cmpwi 0,0,2
	bc 12,2,.L23
	cmpwi 0,0,4
	bc 4,2,.L25
	lis 9,.LC8@ha
	la 6,.LC8@l(9)
	b .L22
.L25:
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
	b .L22
.L23:
	lis 9,.LC10@ha
	la 6,.LC10@l(9)
	b .L22
.L21:
	lis 9,.LC11@ha
	la 6,.LC11@l(9)
.L22:
	lwz 0,8(11)
	lis 5,.LC7@ha
	li 4,1
	la 5,.LC7@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 DisplayRespawnLine,.Lfe4-DisplayRespawnLine
	.comm	motd,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
