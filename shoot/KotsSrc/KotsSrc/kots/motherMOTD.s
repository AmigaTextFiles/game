	.file	"motherMOTD.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"Welcome to King of the Server Teamplay"
	.align 2
.LC2:
	.string	"Welcome to King of the Server"
	.align 3
.LC3:
	.long 0x3ffb3333
	.long 0x33333333
	.align 2
.LC4:
	.long 0x40000000
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTS_MOTD
	.type	 KOTS_MOTD,@function
KOTS_MOTD:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC4@ha
	lfs 11,964(3)
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,0,.L7
	lis 9,level+4@ha
	lis 11,.LC3@ha
	lfs 0,level+4@l(9)
	lfd 12,.LC3@l(11)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lis 11,.LC6@ha
	lfs 13,0(9)
	la 11,.LC6@l(11)
	lis 9,kots_teamplay@ha
	fadd 0,0,12
	fadds 13,11,13
	lfs 11,0(11)
	frsp 0,0
	lwz 11,kots_teamplay@l(9)
	stfs 13,964(3)
	stfs 0,960(3)
	lfs 13,20(11)
	fcmpu 0,13,11
	bc 12,2,.L8
	lis 9,gi+12@ha
	lis 4,.LC1@ha
	lwz 0,gi+12@l(9)
	la 4,.LC1@l(4)
	b .L11
.L8:
	lis 9,gi+12@ha
	lis 4,.LC2@ha
	lwz 0,gi+12@l(9)
	la 4,.LC2@l(4)
.L11:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L10
.L7:
	li 0,0
	stw 0,960(3)
.L10:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe1:
	.size	 KOTS_MOTD,.Lfe1-KOTS_MOTD
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
