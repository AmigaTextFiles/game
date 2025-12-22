	.file	"scam.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC1:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC2:
	.long 0x42820000
	.align 3
.LC3:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl MoveBack
	.type	 MoveBack,@function
MoveBack:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	lwz 29,256(3)
	lwz 9,84(29)
	lfs 12,4040(9)
	stfs 12,4(29)
	lfs 0,4044(9)
	stfs 0,8(29)
	lfs 13,4048(9)
	stfs 13,12(29)
	lfs 0,4028(9)
	fsubs 0,0,12
	stfs 0,24(1)
	fmr 2,0
	lwz 9,84(29)
	lfs 0,8(29)
	lfs 1,4032(9)
	fsubs 1,1,0
	stfs 1,28(1)
	lwz 9,84(29)
	lfs 13,12(29)
	lfs 0,4036(9)
	fsubs 0,0,13
	stfs 0,32(1)
	bl atan2
	lis 9,.LC1@ha
	lfs 13,8(1)
	lis 11,.LC2@ha
	lfd 0,.LC1@l(9)
	la 11,.LC2@l(11)
	mr 3,29
	lfs 12,0(11)
	lis 11,gi+72@ha
	fmul 1,1,0
	frsp 1,1
	stfs 1,12(1)
	stfs 13,16(29)
	lfs 0,12(1)
	lfs 13,12(29)
	stfs 0,20(29)
	lfs 0,16(1)
	fadds 13,13,12
	stfs 0,24(29)
	stfs 13,12(29)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 9,84(29)
	li 0,1
	lis 10,BackToLast@ha
	la 10,BackToLast@l(10)
	lis 8,level+4@ha
	stw 0,3904(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfd 13,0(9)
	lwz 9,84(29)
	lwz 11,4052(9)
	stw 10,436(11)
	lfs 0,level+4@l(8)
	lwz 9,84(29)
	lwz 11,4052(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(11)
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 MoveBack,.Lfe1-MoveBack
	.section	".rodata"
	.align 3
.LC4:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC5:
	.long 0x42aa0000
	.align 3
.LC6:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl MoveBack2
	.type	 MoveBack2,@function
MoveBack2:
	stwu 1,-48(1)
	mflr 0
	stmw 30,40(1)
	stw 0,52(1)
	lwz 31,256(3)
	li 0,0
	lwz 9,84(31)
	stw 0,3900(9)
	lwz 11,84(31)
	lfs 12,4040(11)
	stfs 12,4(31)
	lfs 0,4044(11)
	stfs 0,8(31)
	lfs 13,4048(11)
	stfs 13,12(31)
	lfs 0,4028(11)
	fsubs 0,0,12
	stfs 0,24(1)
	fmr 2,0
	lwz 9,84(31)
	lfs 0,8(31)
	lfs 1,4032(9)
	fsubs 1,1,0
	stfs 1,28(1)
	lwz 9,84(31)
	lfs 13,12(31)
	lfs 0,4036(9)
	fsubs 0,0,13
	stfs 0,32(1)
	bl atan2
	lis 11,.LC4@ha
	lfs 13,8(1)
	lis 9,.LC5@ha
	lfd 0,.LC4@l(11)
	la 9,.LC5@l(9)
	addi 3,31,4
	lfs 12,0(9)
	lis 9,gi@ha
	fmul 1,1,0
	la 30,gi@l(9)
	frsp 1,1
	stfs 1,12(1)
	stfs 13,16(31)
	lfs 0,12(1)
	lfs 13,12(31)
	stfs 0,20(31)
	lfs 0,16(1)
	fadds 13,13,12
	stfs 0,24(31)
	stfs 13,12(31)
	lwz 9,52(30)
	mtlr 9
	blrl
	andi. 0,3,1
	bc 12,2,.L14
	lis 0,0x42c8
	stw 0,12(31)
.L14:
	lwz 0,72(30)
	mr 3,31
	mtlr 0
	blrl
	lwz 9,84(31)
	li 0,1
	lis 10,BackToLast@ha
	la 10,BackToLast@l(10)
	lis 8,level+4@ha
	stw 0,3904(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfd 13,0(9)
	lwz 9,84(31)
	lwz 11,4052(9)
	stw 10,436(11)
	lfs 0,level+4@l(8)
	lwz 9,84(31)
	lwz 11,4052(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(11)
	lwz 0,52(1)
	mtlr 0
	lmw 30,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 MoveBack2,.Lfe2-MoveBack2
	.section	".rodata"
	.align 2
.LC7:
	.string	"track_norm"
	.align 3
.LC8:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC9:
	.long 0x42a00000
	.align 2
.LC10:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl CheckTrack
	.type	 CheckTrack,@function
CheckTrack:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	li 29,0
	lwz 9,84(31)
	lwz 0,3900(9)
	cmpwi 0,0,1
	bc 12,2,.L15
	b .L17
.L19:
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(29)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(29)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(29)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L17
	lwz 9,84(31)
	addi 3,1,24
	lfs 13,4(29)
	lfs 0,3980(9)
	fsubs 0,0,13
	stfs 0,24(1)
	lfs 13,3984(9)
	lfs 0,8(29)
	fsubs 13,13,0
	stfs 13,28(1)
	lfs 0,3988(9)
	lfs 13,12(29)
	fsubs 0,0,13
	stfs 0,32(1)
	bl VectorLength
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L21
	lis 9,gi@ha
	li 3,3
	la 30,gi@l(9)
	addi 29,31,4
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,8
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,88(30)
	mr 3,29
	li 4,1
	mtlr 9
	blrl
	lwz 10,84(31)
	lis 9,MoveBack@ha
	la 9,MoveBack@l(9)
	lwz 11,4052(10)
	stw 9,436(11)
	lwz 10,84(31)
	lwz 0,3900(10)
	cmpwi 0,0,0
	bc 4,2,.L22
	lis 9,level+4@ha
	lis 11,.LC8@ha
	lwz 10,4052(10)
	lfs 0,level+4@l(9)
	lfd 13,.LC8@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(10)
.L22:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3900(11)
	lwz 9,84(31)
	stw 0,3908(9)
	lwz 0,72(30)
	b .L25
.L21:
	lwz 11,84(31)
	lis 10,gi+72@ha
	mr 3,31
	lfs 0,4028(11)
	stfs 0,4040(11)
	lwz 9,84(31)
	lfs 0,4032(9)
	stfs 0,4044(9)
	lwz 11,84(31)
	lfs 0,4036(11)
	stfs 0,4048(11)
	lfs 0,4(29)
	lwz 9,84(31)
	stfs 0,4028(9)
	lfs 0,8(29)
	lwz 11,84(31)
	stfs 0,4032(11)
	lfs 0,12(29)
	lwz 9,84(31)
	stfs 0,4036(9)
	lfs 0,4(29)
	lwz 11,84(31)
	stfs 0,3980(11)
	lfs 0,8(29)
	lwz 9,84(31)
	stfs 0,3984(9)
	lfs 13,12(29)
	lwz 9,84(31)
	stfs 13,3988(9)
	lwz 0,gi+72@l(10)
.L25:
	mtlr 0
	blrl
	b .L15
.L17:
	lis 5,.LC7@ha
	mr 3,29
	la 5,.LC7@l(5)
	li 4,280
	bl G_Find
	mr. 29,3
	bc 4,2,.L19
.L15:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 CheckTrack,.Lfe3-CheckTrack
	.section	".rodata"
	.align 2
.LC11:
	.string	"Your position was: %i\nTotal Race Time: %i:%i:%i \n\n\n"
	.align 2
.LC12:
	.string	"map \"%s\"\n"
	.align 2
.LC13:
	.string	"Your position was: %i\nTotal Race Time: %i:%i:%i \n"
	.align 2
.LC14:
	.string	"track_finish2"
	.align 2
.LC15:
	.string	"fin_one"
	.align 2
.LC16:
	.string	"fin_two"
	.align 2
.LC17:
	.string	"fin_three"
	.align 2
.LC18:
	.string	"fin_four"
	.align 2
.LC19:
	.string	"*** Race Over ***\n"
	.align 2
.LC21:
	.string	"Your position was: %i\n"
	.align 2
.LC22:
	.string	"Total Race Time: %i:%i:%i \n"
	.align 2
.LC23:
	.string	"crowd.wav"
	.align 2
.LC24:
	.string	"stop\n"
	.align 2
.LC20:
	.long 0x497423f0
	.align 2
.LC25:
	.long 0x41200000
	.align 2
.LC26:
	.long 0x3f800000
	.align 2
.LC27:
	.long 0x0
	.align 2
.LC28:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl FinishRace
	.type	 FinishRace,@function
FinishRace:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 0,0
	stw 0,376(31)
	li 3,0
	li 29,0
	stw 0,384(31)
	stw 0,380(31)
	b .L35
.L37:
	lwz 9,284(3)
	addi 9,9,1
	stw 9,284(3)
	lwz 11,84(31)
	stw 9,3972(11)
	lwz 10,84(31)
	lwz 28,3972(10)
.L35:
	lis 5,.LC14@ha
	li 4,280
	la 5,.LC14@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L37
	cmpwi 0,28,1
	bc 4,2,.L39
	b .L40
.L42:
	lfs 0,4(29)
	stfs 0,4(31)
	lfs 13,8(29)
	stfs 13,8(31)
	lfs 0,12(29)
	stfs 0,12(31)
.L40:
	lis 5,.LC15@ha
	mr 3,29
	la 5,.LC15@l(5)
	li 4,280
	bl G_Find
	mr. 29,3
	bc 4,2,.L42
	b .L44
.L39:
	cmpwi 0,28,2
	bc 4,2,.L45
	b .L46
.L48:
	lfs 0,4(29)
	stfs 0,4(31)
	lfs 13,8(29)
	stfs 13,8(31)
	lfs 0,12(29)
	stfs 0,12(31)
.L46:
	lis 5,.LC16@ha
	mr 3,29
	la 5,.LC16@l(5)
	li 4,280
	bl G_Find
	mr. 29,3
	bc 4,2,.L48
	b .L44
.L45:
	cmpwi 0,28,3
	bc 4,2,.L57
	b .L52
.L54:
	lfs 0,4(29)
	stfs 0,4(31)
	lfs 13,8(29)
	stfs 13,8(31)
	lfs 0,12(29)
	stfs 0,12(31)
.L52:
	lis 5,.LC17@ha
	mr 3,29
	la 5,.LC17@l(5)
	li 4,280
	bl G_Find
	mr. 29,3
	bc 4,2,.L54
	b .L44
.L59:
	lfs 0,4(29)
	stfs 0,4(31)
	lfs 13,8(29)
	stfs 13,8(31)
	lfs 0,12(29)
	stfs 0,12(31)
.L57:
	lis 5,.LC18@ha
	mr 3,29
	la 5,.LC18@l(5)
	li 4,280
	bl G_Find
	mr. 29,3
	bc 4,2,.L59
.L44:
	lis 9,.LC25@ha
	lfs 0,12(31)
	lis 29,gi@ha
	la 9,.LC25@l(9)
	la 29,gi@l(29)
	lfs 13,0(9)
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
	li 4,2
	fadds 0,0,13
	stfs 0,12(31)
	lwz 9,8(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 28,level@ha
	lis 9,.LC20@ha
	lwz 10,84(31)
	la 28,level@l(28)
	lfs 13,.LC20@l(9)
	lis 5,.LC21@ha
	lfs 0,4(28)
	la 5,.LC21@l(5)
	mr 3,31
	lwz 11,4060(10)
	li 4,2
	fadds 0,0,13
	stfs 0,428(11)
	lwz 9,84(31)
	lwz 11,8(29)
	lwz 6,3972(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lis 5,.LC22@ha
	li 4,2
	mr 3,31
	la 5,.LC22@l(5)
	lwz 0,3972(11)
	stw 0,3424(11)
	lwz 9,84(31)
	lwz 11,8(29)
	lwz 8,3964(9)
	lwz 6,3956(9)
	mtlr 11
	lwz 7,3960(9)
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lis 4,.LC13@ha
	mr 3,31
	lwz 11,12(29)
	la 4,.LC13@l(4)
	lwz 8,3964(9)
	lwz 6,3956(9)
	mtlr 11
	lwz 7,3960(9)
	lwz 5,3972(9)
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	lis 3,.LC23@ha
	la 3,.LC23@l(3)
	stw 0,3896(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC26@ha
	lis 11,.LC26@ha
	la 9,.LC26@l(9)
	la 11,.LC26@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,2
	lfs 2,0(11)
	lis 9,.LC27@ha
	mr 3,31
	lwz 11,16(29)
	la 9,.LC27@l(9)
	lfs 3,0(9)
	mtlr 11
	blrl
	lwz 0,168(29)
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	mtlr 0
	blrl
	lis 11,.LC28@ha
	lwz 10,84(31)
	lis 9,Invite@ha
	la 11,.LC28@l(11)
	la 9,Invite@l(9)
	lfs 13,0(11)
	lwz 11,4056(10)
	stw 9,436(11)
	lfs 0,4(28)
	lwz 11,84(31)
	fadds 0,0,13
	lwz 9,4056(11)
	stfs 0,428(9)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 FinishRace,.Lfe4-FinishRace
	.section	".rodata"
	.align 2
.LC29:
	.string	"track_point"
	.align 2
.LC30:
	.string	"Lap Time   : %i:%i:%i \n"
	.align 2
.LC31:
	.string	"Lap Time   :\n"
	.align 2
.LC32:
	.string	"Total Time : %i:%i:%i \n"
	.align 2
.LC33:
	.string	"Laps Done  : %i\\%i \n\n"
	.align 2
.LC34:
	.long 0x3f800000
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PrintStats
	.type	 PrintStats,@function
PrintStats:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 7,84(31)
	lwz 8,3896(7)
	cmpwi 0,8,0
	bc 4,2,.L80
	lis 9,.LC34@ha
	lfs 13,4076(7)
	la 9,.LC34@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L80
	lwz 0,3968(7)
	lis 10,0x4330
	lis 11,.LC35@ha
	xoris 0,0,0x8000
	la 11,.LC35@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,0,.L83
	lwz 0,3976(7)
	cmpwi 0,0,1
	bc 4,2,.L84
	stw 8,3976(7)
	lis 11,gi+8@ha
	lis 5,.LC30@ha
	lwz 9,84(31)
	la 5,.LC30@l(5)
	lwz 0,gi+8@l(11)
	li 4,2
	lwz 8,3952(9)
	lwz 6,3948(9)
	mtlr 0
	lwz 7,3944(9)
	crxor 6,6,6
	blrl
	b .L86
.L84:
	li 0,1
	lis 9,gi+8@ha
	stw 0,3976(7)
	lis 5,.LC31@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC31@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L86
.L83:
	lis 9,gi+8@ha
	lis 5,.LC30@ha
	lwz 8,3940(7)
	lwz 0,gi+8@l(9)
	la 5,.LC30@l(5)
	mr 3,31
	lwz 6,3936(7)
	li 4,2
	lwz 7,3932(7)
	mtlr 0
	crxor 6,6,6
	blrl
.L86:
	lwz 9,84(31)
	lis 29,gi@ha
	lis 5,.LC32@ha
	la 29,gi@l(29)
	la 5,.LC32@l(5)
	lwz 6,3956(9)
	mr 3,31
	li 4,2
	lwz 7,3960(9)
	lwz 8,3964(9)
	lwz 9,8(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lis 5,.LC33@ha
	mr 3,31
	lwz 0,8(29)
	la 5,.LC33@l(5)
	li 4,2
	lwz 7,3916(9)
	lwz 6,3912(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L80:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 PrintStats,.Lfe5-PrintStats
	.section	".rodata"
	.align 3
.LC36:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl ClockThink
	.type	 ClockThink,@function
ClockThink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lwz 31,256(3)
	lwz 9,84(31)
	lwz 11,3964(9)
	addi 11,11,1
	stw 11,3964(9)
	lwz 9,84(31)
	lwz 0,3964(9)
	cmpwi 0,0,10
	bc 4,2,.L88
	li 10,0
	stw 10,3964(9)
	lwz 9,84(31)
	lwz 11,3960(9)
	addi 11,11,1
	stw 11,3960(9)
	lwz 9,84(31)
	lwz 0,3960(9)
	cmpwi 0,0,60
	bc 4,2,.L88
	stw 10,3960(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	addi 9,9,1
	stw 9,3956(11)
.L88:
	lwz 9,84(31)
	lwz 11,3940(9)
	addi 11,11,1
	stw 11,3940(9)
	lwz 9,84(31)
	lwz 0,3940(9)
	cmpwi 0,0,10
	bc 4,2,.L90
	li 10,0
	stw 10,3940(9)
	lwz 9,84(31)
	lwz 11,3932(9)
	addi 11,11,1
	stw 11,3932(9)
	lwz 9,84(31)
	lwz 0,3932(9)
	cmpwi 0,0,60
	bc 4,2,.L90
	stw 10,3932(9)
	lwz 11,84(31)
	lwz 9,3936(11)
	addi 9,9,1
	stw 9,3936(11)
.L90:
	mr 3,31
	bl PrintStats
	lwz 8,84(31)
	lis 9,ClockThink@ha
	lis 7,level+4@ha
	la 9,ClockThink@l(9)
	lis 11,.LC36@ha
	lwz 10,4060(8)
	lfd 13,.LC36@l(11)
	stw 9,436(10)
	lfs 0,level+4@l(7)
	lwz 9,84(31)
	lwz 11,4060(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(11)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 ClockThink,.Lfe6-ClockThink
	.section	".rodata"
	.align 2
.LC38:
	.string	"bot_lap"
	.align 2
.LC37:
	.long 0x497423f0
	.align 2
.LC39:
	.long 0x3f800000
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.globl BotFinish
	.type	 BotFinish,@function
BotFinish:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC23@ha
	lwz 9,36(29)
	la 3,.LC23@l(3)
	li 28,0
	li 30,0
	mtlr 9
	blrl
	lis 9,.LC39@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC39@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 2,0(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 3,0(9)
	blrl
	b .L93
.L95:
	lwz 9,284(28)
	addi 9,9,1
	cmpwi 0,9,1
	stw 9,284(28)
	bc 4,2,.L96
	lis 9,.LC37@ha
	lis 11,level@ha
	lfs 31,.LC37@l(9)
	la 29,level@l(11)
	lis 5,.LC15@ha
	mr 3,30
	la 5,.LC15@l(5)
	b .L120
.L96:
	cmpwi 0,9,2
	bc 4,2,.L103
	lis 9,.LC37@ha
	lis 11,level@ha
	lfs 31,.LC37@l(9)
	la 29,level@l(11)
	lis 5,.LC16@ha
	mr 3,30
	la 5,.LC16@l(5)
	b .L120
.L103:
	cmpwi 0,9,3
	bc 4,2,.L109
	lis 9,.LC37@ha
	lis 11,level@ha
	lfs 31,.LC37@l(9)
	la 29,level@l(11)
	lis 5,.LC17@ha
	mr 3,30
	la 5,.LC17@l(5)
	b .L120
.L109:
	lis 9,.LC37@ha
	lis 11,level@ha
	lfs 31,.LC37@l(9)
	la 29,level@l(11)
	lis 5,.LC38@ha
	b .L115
.L117:
	lfs 0,4(30)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 12,12(30)
	stfs 12,12(31)
	lfs 0,4(29)
	fadds 0,0,31
	stfs 0,428(31)
	b .L100
.L115:
	mr 3,30
	la 5,.LC38@l(5)
.L120:
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L117
.L100:
	li 0,0
	li 9,1
	stw 0,376(31)
	stw 9,940(31)
	stw 0,384(31)
	stw 0,380(31)
	stw 9,944(31)
.L93:
	lis 5,.LC14@ha
	mr 3,28
	la 5,.LC14@l(5)
	li 4,280
	bl G_Find
	mr. 28,3
	bc 4,2,.L95
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 BotFinish,.Lfe7-BotFinish
	.section	".rodata"
	.align 2
.LC41:
	.string	"track_finish1"
	.align 2
.LC42:
	.string	"track_finish3"
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
	.long 0x0
	.align 2
.LC45:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl CheckFinish
	.type	 CheckFinish,@function
CheckFinish:
	stwu 1,-64(1)
	mflr 0
	stmw 26,40(1)
	stw 0,68(1)
	mr 31,3
	li 27,0
	li 26,0
	li 30,0
	b .L130
.L138:
	lfs 0,4(26)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(26)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(26)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lfs 13,4(27)
	addi 3,1,8
	lfs 12,4(31)
	lfs 11,8(31)
	lfs 10,12(31)
	fctiwz 0,1
	fsubs 12,12,13
	stfd 0,32(1)
	stfs 12,8(1)
	lfs 13,8(27)
	lwz 28,36(1)
	fsubs 11,11,13
	stfs 11,12(1)
	lfs 0,12(27)
	fsubs 10,10,0
	stfs 10,16(1)
	bl VectorLength
	lfs 13,4(30)
	addi 3,1,8
	lfs 12,4(31)
	lfs 11,8(31)
	lfs 10,12(31)
	fctiwz 0,1
	fsubs 12,12,13
	stfd 0,32(1)
	stfs 12,8(1)
	lfs 13,8(30)
	lwz 29,36(1)
	fsubs 11,11,13
	stfs 11,12(1)
	lfs 0,12(30)
	fsubs 10,10,0
	stfs 10,16(1)
	bl VectorLength
	cmpwi 6,28,99
	cmpwi 7,29,99
	fctiwz 0,1
	cror 27,26,24
	cror 31,30,28
	mfcr 0
	rlwinm 9,0,28,1
	rlwinm 0,0,0,1
	or. 10,9,0
	stfd 0,32(1)
	lwz 0,36(1)
	bc 12,2,.L136
	cmpwi 0,0,99
	bc 12,1,.L136
	lwz 9,84(31)
	lwz 0,3920(9)
	cmpwi 0,0,0
	bc 12,2,.L136
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC43@ha
	lwz 0,16(29)
	lis 10,.LC43@ha
	la 9,.LC43@l(9)
	la 10,.LC43@l(10)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,2
	lis 9,.LC44@ha
	lfs 2,0(10)
	mr 3,31
	la 9,.LC44@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC45@ha
	lwz 10,84(31)
	li 7,0
	la 9,.LC45@l(9)
	lis 6,level+4@ha
	lfs 12,0(9)
	lwz 9,3912(10)
	addi 9,9,1
	stw 9,3912(10)
	lwz 11,84(31)
	lwz 0,3936(11)
	stw 0,3948(11)
	lwz 9,84(31)
	lwz 0,3932(9)
	stw 0,3944(9)
	lwz 11,84(31)
	lwz 0,3940(11)
	stw 0,3952(11)
	lwz 9,84(31)
	stw 7,3940(9)
	lwz 11,84(31)
	stw 7,3932(11)
	lwz 9,84(31)
	stw 7,3936(9)
	lfs 0,level+4@l(6)
	lwz 11,84(31)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,32(1)
	lwz 8,36(1)
	stw 8,3968(11)
	lwz 9,84(31)
	stw 7,3920(9)
	lwz 11,84(31)
	lwz 9,3916(11)
	lwz 0,3912(11)
	cmpw 0,0,9
	bc 4,2,.L136
	mr 3,31
	bl FinishRace
.L136:
	lis 5,.LC42@ha
	mr 3,30
	la 5,.LC42@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L138
.L133:
	lis 5,.LC14@ha
	mr 3,27
	la 5,.LC14@l(5)
	li 4,280
	bl G_Find
	mr. 27,3
	bc 4,2,.L136
.L130:
	lis 5,.LC41@ha
	mr 3,26
	la 5,.LC41@l(5)
	li 4,280
	bl G_Find
	mr. 26,3
	bc 4,2,.L133
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 CheckFinish,.Lfe8-CheckFinish
	.section	".rodata"
	.align 2
.LC46:
	.long 0x3f800000
	.align 2
.LC47:
	.long 0x0
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl BotCheckFinish
	.type	 BotCheckFinish,@function
BotCheckFinish:
	stwu 1,-64(1)
	mflr 0
	stmw 26,40(1)
	stw 0,68(1)
	mr 31,3
	li 27,0
	li 26,0
	li 30,0
	b .L147
.L155:
	lfs 0,4(26)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(26)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(26)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lfs 13,4(27)
	addi 3,1,8
	lfs 12,4(31)
	lfs 11,8(31)
	lfs 10,12(31)
	fctiwz 0,1
	fsubs 12,12,13
	stfd 0,32(1)
	stfs 12,8(1)
	lfs 13,8(27)
	lwz 28,36(1)
	fsubs 11,11,13
	stfs 11,12(1)
	lfs 0,12(27)
	fsubs 10,10,0
	stfs 10,16(1)
	bl VectorLength
	lfs 13,4(30)
	addi 3,1,8
	lfs 12,4(31)
	lfs 11,8(31)
	lfs 10,12(31)
	fctiwz 0,1
	fsubs 12,12,13
	stfd 0,32(1)
	stfs 12,8(1)
	lfs 13,8(30)
	lwz 29,36(1)
	fsubs 11,11,13
	stfs 11,12(1)
	lfs 0,12(30)
	fsubs 10,10,0
	stfs 10,16(1)
	bl VectorLength
	cmpwi 6,28,99
	cmpwi 7,29,99
	fctiwz 0,1
	cror 27,26,24
	cror 31,30,28
	mfcr 0
	rlwinm 9,0,28,1
	rlwinm 0,0,0,1
	or. 10,9,0
	stfd 0,32(1)
	lwz 0,36(1)
	bc 12,2,.L153
	cmpwi 0,0,99
	bc 12,1,.L153
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC46@ha
	lwz 0,16(29)
	lis 10,.LC46@ha
	la 9,.LC46@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC46@l(10)
	mtlr 0
	li 4,2
	lis 9,.LC47@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC47@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,488(31)
	cmpwi 0,0,1
	bc 4,2,.L159
	lwz 11,532(31)
	lis 7,0x4330
	lis 9,.LC48@ha
	addi 11,11,1
	la 9,.LC48@l(9)
	xoris 0,11,0x8000
	lfd 12,0(9)
	stw 0,36(1)
	lis 9,fraglimit@ha
	stw 7,32(1)
	lfd 0,32(1)
	lwz 8,fraglimit@l(9)
	stw 11,532(31)
	fsub 0,0,12
	lfs 13,20(8)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,2,.L158
	mr 3,31
	bl BotFinish
	b .L159
.L158:
	mr 3,31
	bl AI_car_finishthink
	li 0,0
	stw 0,488(31)
.L159:
	li 0,0
	stw 0,628(31)
.L153:
	lis 5,.LC42@ha
	mr 3,30
	la 5,.LC42@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L155
.L150:
	lis 5,.LC14@ha
	mr 3,27
	la 5,.LC14@l(5)
	li 4,280
	bl G_Find
	mr. 27,3
	bc 4,2,.L153
.L147:
	lis 5,.LC41@ha
	mr 3,26
	la 5,.LC41@l(5)
	li 4,280
	bl G_Find
	mr. 26,3
	bc 4,2,.L150
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 BotCheckFinish,.Lfe9-BotCheckFinish
	.section	".rodata"
	.align 2
.LC50:
	.long 0x46fffe00
	.align 3
.LC51:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC52:
	.long 0x40059999
	.long 0x9999999a
	.align 3
.LC53:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC54:
	.long 0x3f800000
	.align 3
.LC55:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC56:
	.long 0x437a0000
	.align 2
.LC57:
	.long 0x42f00000
	.align 3
.LC58:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC59:
	.long 0x0
	.section	".text"
	.align 2
	.globl AI_car_think
	.type	 AI_car_think,@function
AI_car_think:
	stwu 1,-224(1)
	mflr 0
	stfd 30,208(1)
	stfd 31,216(1)
	stmw 23,172(1)
	stw 0,228(1)
	mr 31,3
	li 29,0
	lwz 0,940(31)
	lis 23,.LC29@ha
	cmpwi 0,0,1
	bc 12,2,.L171
	addi 27,1,88
	addi 25,31,16
	addi 28,1,24
	addi 26,1,40
	addi 24,31,4
	addi 30,1,56
	b .L172
.L174:
	lfs 0,4(29)
	addi 3,1,104
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,104(1)
	lfs 0,8(29)
	fsubs 12,12,0
	stfs 12,108(1)
	lfs 0,12(29)
	fsubs 11,11,0
	stfs 11,112(1)
	bl VectorLength
	fctiwz 0,1
	stfd 0,160(1)
	lwz 9,164(1)
	cmpwi 0,9,89
	bc 12,1,.L172
	lis 9,level+4@ha
	lfs 0,592(29)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L172
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,592(29)
	stw 29,540(31)
	lfs 0,12(29)
	stfs 0,12(31)
.L172:
	lis 5,.LC7@ha
	mr 3,29
	la 5,.LC7@l(5)
	li 4,280
	bl G_Find
	mr. 29,3
	bc 4,2,.L174
	lwz 9,540(31)
	lis 11,.LC55@ha
	mr 3,27
	lfs 0,4(31)
	la 11,.LC55@l(11)
	lis 27,0x4330
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	lfd 31,0(11)
	stfs 13,88(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,92(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,96(1)
	bl vectoyaw
	stfs 1,424(31)
	mr 3,31
	bl M_ChangeYaw
	mr 6,26
	addi 4,1,8
	mr 5,28
	mr 3,25
	bl AngleVectors
	bl rand
	lis 9,.LC50@ha
	mr 3,24
	lfs 30,.LC50@l(9)
	addi 4,1,8
	mr 5,30
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 1,0(9)
	bl VectorMA
	lis 9,level@ha
	lfs 13,620(31)
	la 26,level@l(9)
	lfs 0,4(26)
	fcmpu 0,13,0
	bc 4,1,.L178
	lfs 0,56(1)
	lfs 13,60(1)
	lfs 12,64(1)
	stfs 0,120(1)
	stfs 13,124(1)
	stfs 12,128(1)
	b .L171
.L178:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC57@ha
	stw 3,164(1)
	la 11,.LC57@l(11)
	mr 29,9
	stw 27,160(1)
	lfd 0,160(1)
	lfs 11,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,160(1)
	lwz 29,164(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC58@ha
	stw 3,164(1)
	la 11,.LC58@l(11)
	neg 0,29
	stw 27,160(1)
	lfd 0,160(1)
	lfd 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L179
	mr 29,0
.L179:
	xoris 0,29,0x8000
	stw 0,164(1)
	mr 3,30
	mr 4,28
	stw 27,160(1)
	addi 5,1,120
	lfd 1,160(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorMA
	lfs 0,4(26)
	lis 9,.LC51@ha
	lfd 13,.LC51@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,620(31)
.L171:
	lfs 12,120(1)
	addi 3,31,376
	lfs 11,4(31)
	lfs 13,124(1)
	lfs 10,8(31)
	fsubs 12,12,11
	lfs 0,128(1)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,376(31)
	fsubs 0,0,11
	stfs 12,72(1)
	stfs 13,380(31)
	stfs 13,76(1)
	stfs 0,384(31)
	stfs 0,80(1)
	bl VectorLength
	addi 3,31,916
	fctiwz 0,1
	stfd 0,160(1)
	lwz 29,164(1)
	bl VectorLength
	lwz 0,552(31)
	cmpwi 0,0,0
	fctiwz 0,1
	stfd 0,160(1)
	lwz 0,164(1)
	bc 12,2,.L184
	cmpw 0,0,29
	bc 4,1,.L182
	lfs 13,376(31)
	lis 9,.LC52@ha
	lis 11,.LC59@ha
	lfs 0,380(31)
	la 11,.LC59@l(11)
	lfd 12,.LC52@l(9)
	lfs 11,384(31)
	lfs 10,0(11)
	fmul 13,13,12
	fmul 0,0,12
	fmuls 11,11,10
	frsp 13,13
	frsp 0,0
	stfs 11,384(31)
	stfs 13,376(31)
	stfs 0,380(31)
	b .L183
.L182:
	lis 9,.LC59@ha
	lfs 0,384(31)
	la 9,.LC59@l(9)
	lfs 13,0(9)
	fmuls 0,0,13
	stfs 0,384(31)
.L183:
	lfs 0,376(31)
	lwz 9,84(31)
	stfs 0,3788(9)
	lfs 0,380(31)
	lwz 11,84(31)
	stfs 0,3792(11)
	lfs 0,384(31)
	lwz 9,84(31)
	stfs 0,3796(9)
.L184:
	li 29,0
	li 30,1
	b .L185
.L187:
	lfs 0,4(29)
	addi 3,1,136
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,136(1)
	lfs 0,8(29)
	fsubs 12,12,0
	stfs 12,140(1)
	lfs 0,12(29)
	fsubs 11,11,0
	stfs 11,144(1)
	bl VectorLength
	fctiwz 0,1
	stfd 0,160(1)
	lwz 9,164(1)
	cmpwi 0,9,99
	bc 12,1,.L185
	lwz 0,284(29)
	cmpwi 0,0,2
	bc 4,2,.L185
	stw 30,488(31)
.L185:
	mr 3,29
	li 4,280
	la 5,.LC29@l(23)
	bl G_Find
	mr. 29,3
	bc 4,2,.L187
	mr 3,31
	bl BotCheckFinish
	lwz 0,944(31)
	cmpwi 0,0,1
	bc 12,2,.L193
	lis 9,AI_car_think@ha
	lis 10,level+4@ha
	la 9,AI_car_think@l(9)
	lis 11,.LC53@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC53@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L193:
	stw 29,628(31)
	lwz 0,228(1)
	mtlr 0
	lmw 23,172(1)
	lfd 30,208(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe10:
	.size	 AI_car_think,.Lfe10-AI_car_think
	.section	".rodata"
	.align 2
.LC60:
	.string	"*********************\n"
	.align 2
.LC62:
	.string	"models/bot/tris.md2"
	.align 2
.LC63:
	.string	"Paul Matthews"
	.align 2
.LC64:
	.string	"bot"
	.align 2
.LC65:
	.string	"models/bot2/tris.md2"
	.align 2
.LC66:
	.string	"models/bot3/tris.md2"
	.align 2
.LC67:
	.string	"models/bot4/tris.md2"
	.align 2
.LC68:
	.string	"Ladies & Gentlemen - START YOUR ENGINES!!!\n"
	.align 2
.LC69:
	.string	" Design & Art by: \n\nSteven Cheetham\n"
	.align 2
.LC70:
	.string	"Design & Art by:\n\nPaul Matthews\n"
	.align 2
.LC71:
	.string	"Programmed & Produced by:\n\nAdrian Flitcroft\n"
	.align 2
.LC72:
	.string	"Q-Racing V2 COPYRIGHT(c) FLITSOFT 1999 \nwww.telefragged/flitsoft.com\nflitsoft@telefragged.com\n"
	.align 2
.LC73:
	.string	"brake.wav"
	.align 3
.LC74:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC75:
	.long 0x3f800000
	.align 2
.LC76:
	.long 0x0
	.section	".text"
	.align 2
	.globl Handbrake
	.type	 Handbrake,@function
Handbrake:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4068(9)
	cmpwi 0,0,3
	bc 12,2,.L217
	lis 29,gi@ha
	lis 3,.LC73@ha
	la 29,gi@l(29)
	la 3,.LC73@l(3)
	lwz 9,36(29)
	addi 28,31,4
	mtlr 9
	blrl
	lis 9,.LC75@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC75@l(9)
	li 4,4
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC75@ha
	la 9,.LC75@l(9)
	lfs 2,0(9)
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 3,0(9)
	blrl
	lis 9,level+4@ha
	lis 11,.LC74@ha
	lwz 10,84(31)
	lfs 0,level+4@l(9)
	li 3,3
	lfd 13,.LC74@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3756(10)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,40
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,528(31)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
.L217:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Handbrake,.Lfe11-Handbrake
	.section	".rodata"
	.align 2
.LC77:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl CarTouch
	.type	 CarTouch,@function
CarTouch:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L6
	lis 9,level+4@ha
	lfs 13,3764(11)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 12,0,.L6
	lis 29,gi@ha
	lwz 3,268(30)
	la 29,gi@l(29)
	lwz 9,32(29)
	mtlr 9
	blrl
	stw 3,40(31)
	lis 9,.LC77@ha
	li 0,1
	lfs 13,4(30)
	la 9,.LC77@l(9)
	mr 3,31
	lfs 11,0(9)
	lwz 9,84(31)
	stfs 13,4(31)
	lfs 0,8(30)
	stfs 0,8(31)
	lfs 12,12(30)
	stfs 12,12(31)
	lfs 0,376(30)
	fadds 12,12,11
	stfs 0,376(31)
	lfs 13,380(30)
	stfs 13,380(31)
	lfs 0,384(30)
	stfs 0,384(31)
	lfs 13,16(30)
	stfs 13,16(31)
	lfs 0,20(30)
	stfs 0,20(31)
	lfs 13,24(30)
	stfs 13,24(31)
	lfs 0,188(30)
	stfs 0,188(31)
	lfs 13,192(30)
	stfs 13,192(31)
	lfs 0,196(30)
	stfs 0,196(31)
	lfs 13,200(30)
	stfs 13,200(31)
	lfs 0,204(30)
	stfs 0,204(31)
	lfs 13,208(30)
	stfs 12,12(31)
	stfs 13,208(31)
	stw 0,3772(9)
	lwz 0,72(29)
	mtlr 0
	blrl
	mr 3,30
	bl G_FreeEdict
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 CarTouch,.Lfe12-CarTouch
	.section	".rodata"
	.align 3
.LC78:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Cmd_GetInCar_f
	.type	 Cmd_GetInCar_f,@function
Cmd_GetInCar_f:
	lis 9,level+4@ha
	lis 11,.LC78@ha
	lwz 10,84(3)
	lfs 0,level+4@l(9)
	lfd 13,.LC78@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3764(10)
	blr
.Lfe13:
	.size	 Cmd_GetInCar_f,.Lfe13-Cmd_GetInCar_f
	.align 2
	.globl SP_NULL
	.type	 SP_NULL,@function
SP_NULL:
	blr
.Lfe14:
	.size	 SP_NULL,.Lfe14-SP_NULL
	.section	".rodata"
	.align 2
.LC79:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl BackToLast
	.type	 BackToLast,@function
BackToLast:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC79@ha
	lis 9,level+4@ha
	lwz 10,256(3)
	la 11,.LC79@l(11)
	lfs 0,level+4@l(9)
	li 0,0
	lfs 13,0(11)
	li 8,0
	lis 29,gi@ha
	lwz 9,84(10)
	la 29,gi@l(29)
	li 3,3
	addi 28,10,4
	fadds 0,0,13
	stfs 0,4072(9)
	lwz 11,84(10)
	stw 0,384(10)
	stw 0,376(10)
	stw 0,380(10)
	stw 8,3908(11)
	lwz 9,84(10)
	stw 8,3900(9)
	lwz 11,84(10)
	stw 8,3896(11)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,8
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 BackToLast,.Lfe15-BackToLast
	.section	".rodata"
	.align 2
.LC80:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Sitescores
	.type	 Sitescores,@function
Sitescores:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 9,gi+8@ha
	lwz 3,256(29)
	lis 5,.LC11@ha
	li 4,2
	lwz 0,gi+8@l(9)
	la 5,.LC11@l(5)
	lwz 11,84(3)
	mtlr 0
	lwz 9,3964(11)
	lwz 6,3972(11)
	lwz 7,3956(11)
	lwz 8,3960(11)
	crxor 6,6,6
	blrl
	lis 9,Sitescores@ha
	lis 10,.LC80@ha
	la 9,Sitescores@l(9)
	lis 11,level+4@ha
	la 10,.LC80@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Sitescores,.Lfe16-Sitescores
	.section	".rodata"
	.align 2
.LC81:
	.long 0x40000000
	.align 2
.LC82:
	.long 0x0
	.section	".text"
	.align 2
	.globl Site2
	.type	 Site2,@function
Site2:
	stwu 1,-288(1)
	mflr 0
	stmw 29,276(1)
	stw 0,292(1)
	mr 29,3
	lwz 3,256(29)
	bl Cmd_Score_f
	lis 9,Sitescores@ha
	lis 11,level@ha
	la 9,Sitescores@l(9)
	la 6,level@l(11)
	stw 9,436(29)
	lis 11,.LC82@ha
	lis 9,.LC81@ha
	lfs 0,4(6)
	la 11,.LC82@l(11)
	la 9,.LC81@l(9)
	lfs 12,0(11)
	lfs 13,0(9)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	fadds 0,0,13
	stfs 0,428(29)
	lfs 13,20(11)
	fcmpu 0,13,12
	bc 12,2,.L28
	bl EndDMLevel
	b .L29
.L28:
	lis 5,.LC12@ha
	addi 3,1,8
	addi 6,6,72
	la 5,.LC12@l(5)
	li 4,256
	crxor 6,6,6
	bl Com_sprintf
	lis 9,gi+168@ha
	addi 3,1,8
	lwz 0,gi+168@l(9)
	mtlr 0
	blrl
.L29:
	lwz 0,292(1)
	mtlr 0
	lmw 29,276(1)
	la 1,288(1)
	blr
.Lfe17:
	.size	 Site2,.Lfe17-Site2
	.section	".rodata"
	.align 2
.LC83:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Site
	.type	 Site,@function
Site:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 9,gi+12@ha
	lwz 3,256(29)
	lis 4,.LC13@ha
	lwz 0,gi+12@l(9)
	la 4,.LC13@l(4)
	lwz 9,84(3)
	mtlr 0
	lwz 8,3964(9)
	lwz 5,3972(9)
	lwz 6,3956(9)
	lwz 7,3960(9)
	crxor 6,6,6
	blrl
	lis 9,Site2@ha
	lis 10,.LC83@ha
	la 9,Site2@l(9)
	lis 11,level+4@ha
	la 10,.LC83@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 Site,.Lfe18-Site
	.section	".rodata"
	.align 2
.LC84:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Site0
	.type	 Site0,@function
Site0:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 9,gi+12@ha
	lwz 3,256(29)
	lis 4,.LC13@ha
	lwz 0,gi+12@l(9)
	la 4,.LC13@l(4)
	lwz 9,84(3)
	mtlr 0
	lwz 8,3964(9)
	lwz 5,3972(9)
	lwz 6,3956(9)
	lwz 7,3960(9)
	crxor 6,6,6
	blrl
	lis 9,Site@ha
	lis 10,.LC84@ha
	la 9,Site@l(9)
	lis 11,level+4@ha
	la 10,.LC84@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 Site0,.Lfe19-Site0
	.section	".rodata"
	.align 2
.LC85:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Site9
	.type	 Site9,@function
Site9:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 9,gi+12@ha
	lwz 3,256(29)
	lis 4,.LC13@ha
	lwz 0,gi+12@l(9)
	la 4,.LC13@l(4)
	lwz 9,84(3)
	mtlr 0
	lwz 8,3964(9)
	lwz 5,3972(9)
	lwz 6,3956(9)
	lwz 7,3960(9)
	crxor 6,6,6
	blrl
	lis 9,Site0@ha
	lis 10,.LC85@ha
	la 9,Site0@l(9)
	lis 11,level+4@ha
	la 10,.LC85@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 Site9,.Lfe20-Site9
	.section	".rodata"
	.align 2
.LC86:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Invite
	.type	 Invite,@function
Invite:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 9,gi+12@ha
	lwz 3,256(29)
	lis 4,.LC13@ha
	lwz 0,gi+12@l(9)
	la 4,.LC13@l(4)
	lwz 9,84(3)
	mtlr 0
	lwz 8,3964(9)
	lwz 5,3972(9)
	lwz 6,3956(9)
	lwz 7,3960(9)
	crxor 6,6,6
	blrl
	lis 9,Site9@ha
	lis 10,.LC86@ha
	la 9,Site9@l(9)
	lis 11,level+4@ha
	la 10,.LC86@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 Invite,.Lfe21-Invite
	.align 2
	.globl SameLevel
	.type	 SameLevel,@function
SameLevel:
	subf 4,4,3
	addi 4,4,4
	subfic 3,4,8
	li 3,0
	adde 3,3,3
	blr
.Lfe22:
	.size	 SameLevel,.Lfe22-SameLevel
	.align 2
	.globl CheckPoints
	.type	 CheckPoints,@function
CheckPoints:
	stwu 1,-48(1)
	mflr 0
	stmw 30,40(1)
	stw 0,52(1)
	mr 31,3
	li 30,0
	b .L65
.L67:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(30)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	fctiwz 0,1
	stfd 0,32(1)
	lwz 9,36(1)
	cmpwi 0,9,299
	bc 12,1,.L65
	lfs 0,12(31)
	lfs 13,12(30)
	fsubs 0,0,13
	fctiwz 12,0
	stfd 12,32(1)
	lwz 9,36(1)
	addi 9,9,9
	cmplwi 0,9,18
	bc 12,1,.L65
	lwz 11,84(31)
	lwz 0,284(30)
	lwz 9,3924(11)
	cmpw 0,9,0
	bc 12,2,.L64
	stw 9,3928(11)
	lwz 9,84(31)
	lwz 0,284(30)
	stw 0,3924(9)
	lwz 3,84(31)
	lwz 9,3924(3)
	cmpwi 0,9,1
	bc 4,2,.L64
	lwz 0,3928(3)
	cmpwi 0,0,0
	bc 4,2,.L64
	stw 9,3920(3)
	b .L64
.L65:
	lis 5,.LC29@ha
	mr 3,30
	la 5,.LC29@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L67
.L64:
	lwz 0,52(1)
	mtlr 0
	lmw 30,40(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 CheckPoints,.Lfe23-CheckPoints
	.align 2
	.globl BotCheckPoints
	.type	 BotCheckPoints,@function
BotCheckPoints:
	stwu 1,-48(1)
	mflr 0
	stmw 30,40(1)
	stw 0,52(1)
	mr 31,3
	li 30,0
	b .L74
.L76:
	lfs 0,4(30)
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(30)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	fctiwz 0,1
	stfd 0,32(1)
	lwz 9,36(1)
	cmpwi 0,9,99
	bc 12,1,.L74
	lwz 0,284(30)
	li 9,1
	cmpwi 0,0,2
	bc 4,2,.L74
	stw 9,488(31)
.L74:
	lis 5,.LC29@ha
	mr 3,30
	la 5,.LC29@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	addi 3,1,8
	bc 4,2,.L76
	lwz 0,52(1)
	mtlr 0
	lmw 30,40(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 BotCheckPoints,.Lfe24-BotCheckPoints
	.section	".rodata"
	.align 3
.LC87:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl AI_car_finishthink
	.type	 AI_car_finishthink,@function
AI_car_finishthink:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+4@ha
	mr 31,3
	lwz 0,gi+4@l(9)
	lis 3,.LC60@ha
	li 30,0
	la 3,.LC60@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L195
.L197:
	stw 30,540(31)
	lfs 0,4(30)
	lfd 11,.LC87@l(11)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 12,12(30)
	stw 9,436(31)
	stfs 12,12(31)
	lfs 0,level+4@l(10)
	fadd 0,0,11
	frsp 0,0
	stfs 0,428(31)
.L195:
	lis 5,.LC38@ha
	mr 3,30
	la 5,.LC38@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	lis 9,AI_car_think@ha
	lis 10,level+4@ha
	la 9,AI_car_think@l(9)
	lis 11,.LC87@ha
	bc 4,2,.L197
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 AI_car_finishthink,.Lfe25-AI_car_finishthink
	.section	".rodata"
	.align 2
.LC88:
	.long 0x3f800000
	.align 2
.LC89:
	.long 0x0
	.align 3
.LC90:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl BotFinishCross
	.type	 BotFinishCross,@function
BotFinishCross:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC23@ha
	lwz 9,36(29)
	la 3,.LC23@l(3)
	mtlr 9
	blrl
	lis 9,.LC88@ha
	lwz 0,16(29)
	lis 11,.LC88@ha
	la 9,.LC88@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC88@l(11)
	mtlr 0
	li 4,2
	lis 9,.LC89@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC89@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,488(31)
	cmpwi 0,0,1
	bc 4,2,.L124
	lwz 9,532(31)
	lis 7,0x4330
	lis 11,.LC90@ha
	addi 9,9,1
	la 11,.LC90@l(11)
	xoris 0,9,0x8000
	lfd 12,0(11)
	stw 0,28(1)
	lis 11,fraglimit@ha
	stw 7,24(1)
	lfd 0,24(1)
	lwz 8,fraglimit@l(11)
	stw 9,532(31)
	fsub 0,0,12
	lfs 13,20(8)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,2,.L123
	mr 3,31
	bl BotFinish
	b .L124
.L123:
	mr 3,31
	bl AI_car_finishthink
	li 0,0
	stw 0,488(31)
.L124:
	li 0,0
	stw 0,628(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 BotFinishCross,.Lfe26-BotFinishCross
	.section	".rodata"
	.align 2
.LC91:
	.long 0x3f800000
	.align 2
.LC92:
	.long 0x0
	.align 2
.LC93:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl FinishCross
	.type	 FinishCross,@function
FinishCross:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3920(9)
	cmpwi 0,0,0
	bc 12,2,.L126
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC91@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC91@l(9)
	li 4,2
	lfs 1,0(9)
	mtlr 0
	mr 3,31
	lis 9,.LC91@ha
	la 9,.LC91@l(9)
	lfs 2,0(9)
	lis 9,.LC92@ha
	la 9,.LC92@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC93@ha
	lwz 8,84(31)
	li 7,0
	la 9,.LC93@l(9)
	lis 6,level+4@ha
	lfs 12,0(9)
	lwz 9,3912(8)
	addi 9,9,1
	stw 9,3912(8)
	lwz 11,84(31)
	lwz 0,3936(11)
	stw 0,3948(11)
	lwz 9,84(31)
	lwz 0,3932(9)
	stw 0,3944(9)
	lwz 11,84(31)
	lwz 0,3940(11)
	stw 0,3952(11)
	lwz 9,84(31)
	stw 7,3940(9)
	lwz 11,84(31)
	stw 7,3932(11)
	lwz 9,84(31)
	stw 7,3936(9)
	lfs 0,level+4@l(6)
	lwz 11,84(31)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 10,28(1)
	stw 10,3968(11)
	lwz 9,84(31)
	stw 7,3920(9)
	lwz 11,84(31)
	lwz 9,3916(11)
	lwz 0,3912(11)
	cmpw 0,0,9
	bc 4,2,.L126
	mr 3,31
	bl FinishRace
.L126:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 FinishCross,.Lfe27-FinishCross
	.section	".rodata"
	.align 3
.LC94:
	.long 0x40059999
	.long 0x9999999a
	.align 2
.LC95:
	.long 0x0
	.section	".text"
	.align 2
	.globl BotPhysics
	.type	 BotPhysics,@function
BotPhysics:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	addi 3,31,376
	bl VectorLength
	addi 3,31,916
	fctiwz 0,1
	stfd 0,16(1)
	lwz 30,20(1)
	bl VectorLength
	lwz 0,552(31)
	cmpwi 0,0,0
	fctiwz 0,1
	stfd 0,16(1)
	lwz 0,20(1)
	bc 12,2,.L166
	cmpw 0,0,30
	bc 4,1,.L167
	lfs 13,376(31)
	lis 9,.LC94@ha
	lis 11,.LC95@ha
	lfs 0,380(31)
	la 11,.LC95@l(11)
	lfd 12,.LC94@l(9)
	lfs 11,384(31)
	lfs 10,0(11)
	fmul 13,13,12
	fmul 0,0,12
	fmuls 11,11,10
	frsp 13,13
	frsp 0,0
	stfs 11,384(31)
	stfs 13,376(31)
	stfs 0,380(31)
	b .L168
.L167:
	lis 9,.LC95@ha
	lfs 0,384(31)
	la 9,.LC95@l(9)
	lfs 13,0(9)
	fmuls 0,0,13
	stfs 0,384(31)
.L168:
	lfs 0,376(31)
	lwz 9,84(31)
	stfs 0,3788(9)
	lfs 0,380(31)
	lwz 11,84(31)
	stfs 0,3792(11)
	lfs 13,384(31)
	lwz 9,84(31)
	stfs 13,3796(9)
.L166:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 BotPhysics,.Lfe28-BotPhysics
	.section	".rodata"
	.align 2
.LC96:
	.long 0x0
	.align 2
.LC97:
	.long 0x41300000
	.section	".text"
	.align 2
	.globl AI_car_spawn
	.type	 AI_car_spawn,@function
AI_car_spawn:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC96@ha
	lis 9,deathmatch@ha
	la 11,.LC96@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L199
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L199
	lis 29,gi@ha
	lis 3,.LC62@ha
	la 29,gi@l(29)
	la 3,.LC62@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	lwz 10,184(31)
	la 9,.LC63@l(9)
	la 11,.LC64@l(11)
	stw 3,40(31)
	stw 9,912(31)
	lis 0,0xc1c0
	lis 8,AI_car_think@ha
	stw 11,280(31)
	lis 9,0x4200
	lis 4,0xc180
	stw 0,196(31)
	lis 28,0x4180
	li 5,0
	stw 9,208(31)
	li 0,50
	la 8,AI_car_think@l(8)
	rlwinm 10,10,0,30,28
	li 7,8
	stw 4,192(31)
	li 6,2
	lis 11,0x4170
	stw 28,204(31)
	lis 3,.LC97@ha
	stw 5,56(31)
	lis 9,level+4@ha
	la 3,.LC97@l(3)
	stw 10,184(31)
	stw 7,260(31)
	stw 6,248(31)
	stw 0,400(31)
	stw 11,420(31)
	stw 8,436(31)
	stw 4,188(31)
	stw 28,200(31)
	stw 5,60(31)
	lfs 13,0(3)
	lfs 0,level+4@l(9)
	mr 3,31
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L199:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 AI_car_spawn,.Lfe29-AI_car_spawn
	.section	".rodata"
	.align 2
.LC98:
	.long 0x0
	.align 2
.LC99:
	.long 0x41300000
	.section	".text"
	.align 2
	.globl AI_car_spawntruck
	.type	 AI_car_spawntruck,@function
AI_car_spawntruck:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC98@ha
	lis 9,deathmatch@ha
	la 11,.LC98@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L202
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L202
	lis 29,gi@ha
	lis 3,.LC65@ha
	la 29,gi@l(29)
	la 3,.LC65@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	lwz 10,184(31)
	la 9,.LC63@l(9)
	la 11,.LC64@l(11)
	stw 3,40(31)
	stw 9,912(31)
	lis 0,0xc1c0
	lis 8,AI_car_think@ha
	stw 11,280(31)
	lis 9,0x4200
	lis 4,0xc180
	stw 0,196(31)
	lis 28,0x4180
	li 5,0
	stw 9,208(31)
	li 0,50
	la 8,AI_car_think@l(8)
	rlwinm 10,10,0,30,28
	li 7,8
	stw 4,192(31)
	li 6,2
	lis 11,0x4170
	stw 28,204(31)
	lis 3,.LC99@ha
	stw 5,56(31)
	lis 9,level+4@ha
	la 3,.LC99@l(3)
	stw 10,184(31)
	stw 7,260(31)
	stw 6,248(31)
	stw 0,400(31)
	stw 11,420(31)
	stw 8,436(31)
	stw 4,188(31)
	stw 28,200(31)
	stw 5,60(31)
	lfs 13,0(3)
	lfs 0,level+4@l(9)
	mr 3,31
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L202:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 AI_car_spawntruck,.Lfe30-AI_car_spawntruck
	.section	".rodata"
	.align 2
.LC100:
	.long 0x0
	.align 2
.LC101:
	.long 0x41300000
	.section	".text"
	.align 2
	.globl AI_car_spawnviper
	.type	 AI_car_spawnviper,@function
AI_car_spawnviper:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC100@ha
	lis 9,deathmatch@ha
	la 11,.LC100@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L205
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L205
	lis 29,gi@ha
	lis 3,.LC66@ha
	la 29,gi@l(29)
	la 3,.LC66@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	lwz 10,184(31)
	la 9,.LC63@l(9)
	la 11,.LC64@l(11)
	stw 3,40(31)
	stw 9,912(31)
	lis 0,0xc1c0
	lis 8,AI_car_think@ha
	stw 11,280(31)
	lis 9,0x4200
	lis 4,0xc180
	stw 0,196(31)
	lis 28,0x4180
	li 5,0
	stw 9,208(31)
	li 0,50
	la 8,AI_car_think@l(8)
	rlwinm 10,10,0,30,28
	li 7,8
	stw 4,192(31)
	li 6,2
	lis 11,0x4170
	stw 28,204(31)
	lis 3,.LC101@ha
	stw 5,56(31)
	lis 9,level+4@ha
	la 3,.LC101@l(3)
	stw 10,184(31)
	stw 7,260(31)
	stw 6,248(31)
	stw 0,400(31)
	stw 11,420(31)
	stw 8,436(31)
	stw 4,188(31)
	stw 28,200(31)
	stw 5,60(31)
	lfs 13,0(3)
	lfs 0,level+4@l(9)
	mr 3,31
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L205:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 AI_car_spawnviper,.Lfe31-AI_car_spawnviper
	.section	".rodata"
	.align 2
.LC102:
	.long 0x0
	.align 2
.LC103:
	.long 0x41300000
	.section	".text"
	.align 2
	.globl AI_car_spawnpod
	.type	 AI_car_spawnpod,@function
AI_car_spawnpod:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC102@ha
	lis 9,deathmatch@ha
	la 11,.LC102@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L208
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L208
	lis 29,gi@ha
	lis 3,.LC67@ha
	la 29,gi@l(29)
	la 3,.LC67@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	lwz 10,184(31)
	la 9,.LC63@l(9)
	la 11,.LC64@l(11)
	stw 3,40(31)
	stw 9,912(31)
	lis 0,0xc1c0
	lis 8,AI_car_think@ha
	stw 11,280(31)
	lis 9,0x4200
	lis 4,0xc180
	stw 0,196(31)
	lis 28,0x4180
	li 5,0
	stw 9,208(31)
	li 0,50
	la 8,AI_car_think@l(8)
	rlwinm 10,10,0,30,28
	li 7,8
	stw 4,192(31)
	li 6,2
	lis 11,0x4170
	stw 28,204(31)
	lis 3,.LC103@ha
	stw 5,56(31)
	lis 9,level+4@ha
	la 3,.LC103@l(3)
	stw 10,184(31)
	stw 7,260(31)
	stw 6,248(31)
	stw 0,400(31)
	stw 11,420(31)
	stw 8,436(31)
	stw 4,188(31)
	stw 28,200(31)
	stw 5,60(31)
	lfs 13,0(3)
	lfs 0,level+4@l(9)
	mr 3,31
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L208:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 AI_car_spawnpod,.Lfe32-AI_car_spawnpod
	.align 2
	.globl Credits5
	.type	 Credits5,@function
Credits5:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+12@ha
	lis 4,.LC68@ha
	lwz 3,256(3)
	lwz 0,gi+12@l(9)
	la 4,.LC68@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 Credits5,.Lfe33-Credits5
	.align 2
	.globl Credits4
	.type	 Credits4,@function
Credits4:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+12@ha
	lis 4,.LC69@ha
	lwz 3,256(3)
	lwz 0,gi+12@l(9)
	la 4,.LC69@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 Credits4,.Lfe34-Credits4
	.section	".rodata"
	.align 2
.LC104:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Credits3
	.type	 Credits3,@function
Credits3:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+12@ha
	mr 29,3
	lwz 0,gi+12@l(9)
	lis 4,.LC70@ha
	la 4,.LC70@l(4)
	lwz 3,256(29)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,Credits4@ha
	lis 10,.LC104@ha
	la 9,Credits4@l(9)
	lis 11,level+4@ha
	la 10,.LC104@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 Credits3,.Lfe35-Credits3
	.section	".rodata"
	.align 2
.LC105:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Credits2
	.type	 Credits2,@function
Credits2:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+12@ha
	mr 29,3
	lwz 0,gi+12@l(9)
	lis 4,.LC71@ha
	la 4,.LC71@l(4)
	lwz 3,256(29)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,Credits3@ha
	lis 10,.LC105@ha
	la 9,Credits3@l(9)
	lis 11,level+4@ha
	la 10,.LC105@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 Credits2,.Lfe36-Credits2
	.section	".rodata"
	.align 2
.LC106:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Credits15
	.type	 Credits15,@function
Credits15:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+12@ha
	mr 29,3
	lwz 0,gi+12@l(9)
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	lwz 3,256(29)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,Credits2@ha
	lis 10,.LC106@ha
	la 9,Credits2@l(9)
	lis 11,level+4@ha
	la 10,.LC106@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 Credits15,.Lfe37-Credits15
	.section	".rodata"
	.align 2
.LC107:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl PrintCredits
	.type	 PrintCredits,@function
PrintCredits:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+12@ha
	mr 29,3
	lwz 0,gi+12@l(9)
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	lwz 3,256(29)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,Credits15@ha
	lis 10,.LC107@ha
	la 9,Credits15@l(9)
	lis 11,level+4@ha
	la 10,.LC107@l(10)
	stw 9,436(29)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 PrintCredits,.Lfe38-PrintCredits
	.align 2
	.globl SP_powerup
	.type	 SP_powerup,@function
SP_powerup:
	blr
.Lfe39:
	.size	 SP_powerup,.Lfe39-SP_powerup
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
