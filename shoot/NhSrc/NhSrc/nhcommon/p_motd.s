	.file	"p_motd.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC0:
	.string	"nhunters/motd.txt"
	.align 2
.LC1:
	.string	"r"
	.align 2
.LC2:
	.string	"xv 0 yv %i string \"%s\" "
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ShowMOTD
	.type	 ShowMOTD,@function
ShowMOTD:
	stwu 1,-2192(1)
	mflr 0
	stmw 23,2156(1)
	stw 0,2196(1)
	mr 23,3
	lis 4,.LC1@ha
	lis 3,.LC0@ha
	la 4,.LC1@l(4)
	la 3,.LC0@l(3)
	li 24,0
	bl fopen
	li 25,16
	li 26,0
	mr. 27,3
	addi 31,1,728
	bc 12,2,.L7
	addi 3,1,8
	li 4,500
	mr 5,27
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L8
	addi 30,1,520
	b .L9
.L11:
	addi 29,1,600
	lis 5,.LC2@ha
	mr 6,25
	la 5,.LC2@l(5)
	li 4,120
	mr 7,30
	mr 3,29
	addi 24,24,1
	crxor 6,6,6
	bl Com_sprintf
	addi 25,25,8
	mr 3,29
	bl strlen
	mr 28,3
	mr 4,29
	add 3,31,26
	bl strcpy
	add 26,26,28
.L9:
	mr 3,30
	li 4,80
	mr 5,27
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L8
	cmpwi 0,24,19
	bc 4,1,.L11
.L8:
	mr 3,27
	bl fclose
.L7:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,23
	li 4,1
	mtlr 0
	blrl
	bl getMotdTime
	xoris 3,3,0x8000
	stw 3,2148(1)
	lis 0,0x4330
	lis 11,.LC3@ha
	la 11,.LC3@l(11)
	stw 0,2144(1)
	lis 10,level+4@ha
	lfd 11,0(11)
	lfd 0,2144(1)
	mr 11,9
	lfs 13,level+4@l(10)
	fsub 0,0,11
	frsp 0,0
	fadds 13,13,0
	fctiwz 12,13
	stfd 12,2144(1)
	lwz 11,2148(1)
	stw 11,924(23)
	lwz 0,2196(1)
	mtlr 0
	lmw 23,2156(1)
	la 1,2192(1)
	blr
.Lfe1:
	.size	 ShowMOTD,.Lfe1-ShowMOTD
	.section	".rodata"
	.align 2
.LC5:
	.string	"motd_time"
	.align 2
.LC6:
	.string	"15"
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.section	".text"
	.align 2
	.globl ShowingMOTD
	.type	 ShowingMOTD,@function
ShowingMOTD:
	stwu 1,-16(1)
	lis 11,level+4@ha
	lwz 0,924(3)
	lfs 0,level+4@l(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	cmpw 7,0,9
	mfcr 3
	rlwinm 3,3,30,1
	la 1,16(1)
	blr
.Lfe2:
	.size	 ShowingMOTD,.Lfe2-ShowingMOTD
	.align 2
	.globl ClearMOTD
	.type	 ClearMOTD,@function
ClearMOTD:
	stwu 1,-16(1)
	lis 11,level+4@ha
	lfs 0,level+4@l(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,924(3)
	la 1,16(1)
	blr
.Lfe3:
	.size	 ClearMOTD,.Lfe3-ClearMOTD
	.section	".rodata"
	.align 2
.LC8:
	.long 0x461c3c00
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl validateMotdTime
	.type	 validateMotdTime,@function
validateMotdTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC9@ha
	lis 9,motd_time@ha
	la 11,.LC9@l(11)
	lfs 0,0(11)
	lwz 11,motd_time@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L19
	lis 9,.LC8@ha
	lfs 0,.LC8@l(9)
	fcmpu 0,13,0
	bc 4,1,.L18
.L19:
	lis 9,gi+148@ha
	lis 3,.LC5@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC6@ha
	la 3,.LC5@l(3)
	la 4,.LC6@l(4)
	mtlr 0
	blrl
.L18:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 validateMotdTime,.Lfe4-validateMotdTime
	.section	".rodata"
	.align 2
.LC10:
	.long 0x461c3c00
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl getMotdTime
	.type	 getMotdTime,@function
getMotdTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,motd_time@ha
	lwz 9,motd_time@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L21
	lfs 13,20(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L22
	lis 9,.LC10@ha
	lfs 0,.LC10@l(9)
	fcmpu 0,13,0
	bc 4,1,.L21
.L22:
	lis 9,gi+148@ha
	lis 3,.LC5@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC6@ha
	la 3,.LC5@l(3)
	la 4,.LC6@l(4)
	mtlr 0
	blrl
.L21:
	lis 11,motd_time@ha
	lwz 9,motd_time@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 getMotdTime,.Lfe5-getMotdTime
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
