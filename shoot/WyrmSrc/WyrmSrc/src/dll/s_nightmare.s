	.file	"s_nightmare.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"a"
	.align 2
.LC1:
	.string	"z"
	.align 2
.LC2:
	.string	"m"
	.align 2
.LC3:
	.string	"mmnmmommommnonmmonqnmmo"
	.align 2
.LC4:
	.string	"abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba"
	.align 2
.LC5:
	.string	"mmmmmaaaaammmmmaaaaaabcdefgabcdefg"
	.align 2
.LC6:
	.string	"mamamamamama"
	.align 2
.LC7:
	.string	"jklmnopqrstuvwxyzyxwvutsrqponmlkj"
	.align 2
.LC8:
	.string	"nmonqnmomnmomomno"
	.align 2
.LC9:
	.string	"mmmaaaabcdefgmmmmaaaammmaamm"
	.align 2
.LC10:
	.string	"mmmaaammmaaammmabcdefaaaammmmabcdefmmmaaaa"
	.align 2
.LC11:
	.string	"aaaaaaaazzzzzzzz"
	.align 2
.LC12:
	.string	"mmamammmmammamamaaamammma"
	.align 2
.LC13:
	.string	"abcdefghijklmnopqrrqponmlkjihgfedcba"
	.section	".text"
	.align 2
	.globl nightmareModeSetup
	.type	 nightmareModeSetup,@function
nightmareModeSetup:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,nightmareModeState@ha
	lwz 0,nightmareModeState@l(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	lis 29,gi@ha
	lis 28,.LC0@ha
	la 29,gi@l(29)
	li 3,800
	lwz 9,24(29)
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,801
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,802
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,803
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,804
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,805
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,806
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,807
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,808
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,809
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	li 3,810
	la 4,.LC0@l(28)
	mtlr 9
	blrl
	lwz 9,24(29)
	la 4,.LC0@l(28)
	li 3,811
	mtlr 9
	blrl
	lwz 0,24(29)
	lis 4,.LC1@ha
	li 3,863
	la 4,.LC1@l(4)
	mtlr 0
	blrl
	b .L8
.L7:
	lis 29,gi@ha
	lis 4,.LC2@ha
	la 29,gi@l(29)
	la 4,.LC2@l(4)
	lwz 9,24(29)
	li 3,800
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC3@ha
	li 3,801
	la 4,.LC3@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC4@ha
	li 3,802
	la 4,.LC4@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC5@ha
	li 3,803
	la 4,.LC5@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC6@ha
	li 3,804
	la 4,.LC6@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC7@ha
	li 3,805
	la 4,.LC7@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC8@ha
	li 3,806
	la 4,.LC8@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC9@ha
	li 3,807
	la 4,.LC9@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC10@ha
	li 3,808
	la 4,.LC10@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC11@ha
	li 3,809
	la 4,.LC11@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC12@ha
	li 3,810
	la 4,.LC12@l(4)
	mtlr 9
	blrl
	lwz 9,24(29)
	lis 4,.LC13@ha
	li 3,811
	la 4,.LC13@l(4)
	mtlr 9
	blrl
	lwz 0,24(29)
	lis 4,.LC0@ha
	li 3,863
	la 4,.LC0@l(4)
	mtlr 0
	blrl
.L8:
	lis 9,level+4@ha
	lis 11,nightmareToggleTime@ha
	lfs 0,level+4@l(9)
	stfs 0,nightmareToggleTime@l(11)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 nightmareModeSetup,.Lfe1-nightmareModeSetup
	.section	".rodata"
	.align 2
.LC15:
	.string	"misc/lasfly.wav"
	.align 2
.LC16:
	.long 0x3e4ccccd
	.align 3
.LC17:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC18:
	.long 0x0
	.align 2
.LC19:
	.long 0x3f800000
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC21:
	.long 0x46000000
	.align 3
.LC22:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl flashlight_think
	.type	 flashlight_think,@function
flashlight_think:
	stwu 1,-224(1)
	mflr 0
	stfd 31,216(1)
	stmw 27,196(1)
	stw 0,228(1)
	lis 11,.LC18@ha
	lis 9,level+200@ha
	la 11,.LC18@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 31,0(11)
	fcmpu 0,0,31
	bc 4,2,.L14
	lwz 9,256(31)
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L14
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L13
.L14:
	lwz 28,256(31)
	lwz 9,84(28)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 0,3956(9)
	cmpwi 0,0,0
	bc 12,2,.L15
	lwz 0,3824(9)
	lis 9,.LC19@ha
	cmpwi 0,0,0
	la 9,.LC19@l(9)
	lfs 31,0(9)
	bc 12,2,.L16
	lis 9,.LC16@ha
	lfs 31,.LC16@l(9)
.L16:
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC19@ha
	lis 11,.LC18@ha
	fmr 1,31
	la 9,.LC19@l(9)
	la 11,.LC18@l(11)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	li 4,17
	lfs 3,0(11)
	mr 3,28
	blrl
	lwz 11,256(31)
	li 0,0
	lwz 9,84(11)
	stw 0,3956(9)
	lwz 11,256(31)
	lwz 9,84(11)
	stw 0,3960(9)
.L15:
	mr 3,31
	bl G_FreeEdict
	b .L12
.L13:
	lwz 3,84(9)
	addi 28,1,24
	addi 29,1,72
	addi 4,1,8
	addi 6,1,40
	addi 3,3,3728
	mr 5,28
	bl AngleVectors
	lis 9,.LC20@ha
	lwz 10,256(31)
	lis 0,0x4100
	la 9,.LC20@l(9)
	stw 0,60(1)
	stfs 31,56(1)
	lis 3,0x4330
	addi 27,1,88
	lfd 13,0(9)
	addi 4,10,4
	addi 6,1,8
	lwz 9,508(10)
	addi 5,1,56
	mr 7,28
	mr 8,29
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,188(1)
	stw 3,184(1)
	lfd 0,184(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	lwz 3,84(10)
	bl P_ProjectSource
	lis 9,.LC21@ha
	addi 4,1,8
	la 9,.LC21@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 5,27
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 8,256(31)
	lwz 0,gi+48@l(11)
	ori 9,9,1
	mr 4,29
	mr 7,27
	addi 3,1,104
	li 5,0
	li 6,0
	mtlr 0
	blrl
	lwz 9,148(1)
	cmpwi 0,9,0
	bc 12,2,.L19
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L18
.L19:
	lfs 0,112(1)
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfd 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L18
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	b .L21
.L18:
	lwz 0,184(31)
	ori 0,0,1
.L21:
	stw 0,184(31)
	addi 3,1,128
	addi 4,31,16
	bl vectoangles
	lfs 0,120(1)
	lis 9,level+4@ha
	lis 11,.LC17@ha
	lfs 13,124(1)
	lis 10,gi+72@ha
	mr 3,31
	lfs 12,116(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC17@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
.L12:
	lwz 0,228(1)
	mtlr 0
	lmw 27,196(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe2:
	.size	 flashlight_think,.Lfe2-flashlight_think
	.section	".rodata"
	.align 2
.LC25:
	.string	"flashlight"
	.align 2
.LC26:
	.string	"models/lsight/tris.md2"
	.align 2
.LC23:
	.long 0x3e4ccccd
	.align 3
.LC24:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC27:
	.long 0x3f800000
	.align 2
.LC28:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Flashlight
	.type	 Use_Flashlight,@function
Use_Flashlight:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 30,3956(9)
	cmpwi 0,30,0
	bc 12,2,.L23
	lwz 7,3960(9)
	cmpwi 0,7,0
	bc 4,2,.L24
	li 0,1
	li 10,32
	stw 0,3960(9)
	lis 8,gi+72@ha
	lwz 9,84(31)
	lwz 11,3956(9)
	stw 7,64(11)
	lwz 9,84(31)
	lwz 11,3956(9)
	stw 10,68(11)
	b .L33
.L24:
	cmpwi 0,7,1
	bc 4,2,.L26
	li 0,2
	li 10,64
	stw 0,3960(9)
	lis 8,gi+72@ha
	lwz 9,84(31)
	lwz 11,3956(9)
	stw 10,64(11)
.L33:
	lwz 9,84(31)
	lwz 0,gi+72@l(8)
	lwz 3,3956(9)
	mtlr 0
	blrl
	b .L31
.L26:
	li 28,0
	stw 28,3960(9)
	lwz 9,84(31)
	lwz 31,3956(9)
	lwz 30,256(31)
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L28
	lwz 0,3956(9)
	cmpwi 0,0,0
	bc 12,2,.L28
	lwz 0,3824(9)
	lis 9,.LC27@ha
	cmpwi 0,0,0
	la 9,.LC27@l(9)
	lfs 31,0(9)
	bc 12,2,.L29
	lis 9,.LC23@ha
	lfs 31,.LC23@l(9)
.L29:
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC27@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC27@l(9)
	li 4,17
	lfs 2,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,256(31)
	lwz 11,84(9)
	stw 28,3956(11)
	lwz 9,256(31)
	lwz 11,84(9)
	stw 28,3960(11)
.L28:
	mr 3,31
	bl G_FreeEdict
	b .L31
.L23:
	lwz 0,3824(9)
	lis 9,.LC27@ha
	cmpwi 0,0,0
	la 9,.LC27@l(9)
	lfs 31,0(9)
	bc 12,2,.L32
	lis 9,.LC23@ha
	lfs 31,.LC23@l(9)
.L32:
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC27@ha
	lwz 11,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC27@l(9)
	li 4,17
	lfs 2,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 3,0(9)
	blrl
	bl G_Spawn
	lwz 9,84(31)
	li 5,1
	lis 0,0x600
	ori 0,0,3
	lis 6,level+4@ha
	stw 3,3956(9)
	lis 10,.LC24@ha
	lis 8,flashlight_think@ha
	lwz 11,84(31)
	la 8,flashlight_think@l(8)
	lis 7,.LC25@ha
	lfs 0,4(31)
	la 7,.LC25@l(7)
	lis 3,.LC26@ha
	lwz 9,3956(11)
	la 3,.LC26@l(3)
	lfd 13,.LC24@l(10)
	stfs 0,4(9)
	lwz 11,84(31)
	lfs 0,8(31)
	lwz 9,3956(11)
	stfs 0,8(9)
	lwz 11,84(31)
	lfs 0,12(31)
	lwz 9,3956(11)
	stfs 0,12(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 5,260(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 0,252(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 30,248(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 31,256(9)
	lfs 0,level+4@l(6)
	lwz 9,84(31)
	lwz 11,3956(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(11)
	lwz 9,84(31)
	lwz 11,3956(9)
	stw 8,436(11)
	lwz 9,84(31)
	lwz 11,3956(9)
	stw 7,280(11)
	lwz 9,84(31)
	lwz 11,3956(9)
	stw 5,184(11)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 11,84(31)
	li 0,0
	li 10,64
	lwz 9,3956(11)
	stw 3,40(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 30,56(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 30,60(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 0,188(9)
	stw 0,196(9)
	stw 0,192(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 0,200(9)
	stw 0,208(9)
	stw 0,204(9)
	lwz 11,84(31)
	lwz 9,3956(11)
	stw 10,64(9)
	lwz 11,84(31)
	lwz 10,3956(11)
	lwz 0,68(10)
	ori 0,0,32
	stw 0,68(10)
	lwz 9,84(31)
	lwz 11,3956(9)
	lwz 0,68(11)
	ori 0,0,8
	stw 0,68(11)
	lwz 9,84(31)
	lwz 0,72(29)
	lwz 3,3956(9)
	mtlr 0
	blrl
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Use_Flashlight,.Lfe3-Use_Flashlight
	.section	".rodata"
	.align 2
.LC29:
	.long 0x0
	.align 2
.LC30:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl nightmareCheckRules
	.type	 nightmareCheckRules,@function
nightmareCheckRules:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,nightmareModeState@ha
	lis 10,nightmareModeState@ha
	lwz 0,nightmareModeState@l(9)
	cmpwi 0,0,0
	bc 12,2,.L35
	lis 9,nightmare@ha
	lwz 11,nightmare@l(9)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L36
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 12,2,.L35
.L36:
	li 0,0
	stw 0,nightmareModeState@l(10)
	b .L37
.L35:
	lis 11,.LC29@ha
	lis 9,nightmare@ha
	la 11,.LC29@l(11)
	lfs 13,0(11)
	lwz 11,nightmare@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L38
	lis 9,nightmareModeState@ha
	lwz 0,nightmareModeState@l(9)
	cmpwi 0,0,0
	bc 4,2,.L42
	lis 9,lighttime@ha
	lwz 11,lighttime@l(9)
	lfs 11,20(11)
	fcmpu 0,11,13
	bc 4,1,.L38
	lis 9,.LC30@ha
	lis 11,nightmareToggleTime@ha
	la 9,.LC30@l(9)
	lfs 12,nightmareToggleTime@l(11)
	lfs 0,0(9)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	fmadds 0,11,0,12
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L38
	li 0,1
	stw 0,nightmareModeState@l(10)
	b .L37
.L38:
	lis 9,nightmareModeState@ha
	lwz 0,nightmareModeState@l(9)
	cmpwi 0,0,0
	bc 12,2,.L34
.L42:
	lis 11,.LC29@ha
	lis 9,nighttime@ha
	la 11,.LC29@l(11)
	lfs 0,0(11)
	lwz 11,nighttime@l(9)
	lfs 11,20(11)
	fcmpu 0,11,0
	bc 4,1,.L34
	lis 9,.LC30@ha
	lis 11,nightmareToggleTime@ha
	la 9,.LC30@l(9)
	lfs 12,nightmareToggleTime@l(11)
	lfs 0,0(9)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	fmadds 0,11,0,12
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L34
	lis 9,nightmareModeState@ha
	li 0,0
	stw 0,nightmareModeState@l(9)
.L37:
	bl nightmareModeSetup
.L34:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 nightmareCheckRules,.Lfe4-nightmareCheckRules
	.section	".rodata"
	.align 2
.LC31:
	.string	"nightmare"
	.align 2
.LC32:
	.string	"Nightmare mode TOGGLE\n"
	.align 2
.LC33:
	.string	"0"
	.align 2
.LC34:
	.string	"Nightmare mode OFF\n"
	.align 2
.LC35:
	.string	"1"
	.align 2
.LC36:
	.string	"Nightmare mode ON\n"
	.align 2
.LC37:
	.string	"nighttime"
	.align 2
.LC38:
	.string	"lighttime"
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl nightmareModeToggle
	.type	 nightmareModeToggle,@function
nightmareModeToggle:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,3,0
	bc 12,2,.L44
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 4,1,.L45
	lwz 9,160(29)
	li 3,2
	mtlr 9
	blrl
	bl atoi
	cmpwi 0,3,0
	bc 12,2,.L45
	lwz 9,160(29)
	li 3,2
	mtlr 9
	blrl
	mr 4,3
	lwz 0,152(29)
	lis 3,.LC31@ha
	mtlr 0
	la 3,.LC31@l(3)
	blrl
	lis 9,gi@ha
	lis 4,.LC32@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC32@l(4)
	b .L52
.L45:
	lis 9,.LC39@ha
	lis 11,nightmare@ha
	la 9,.LC39@l(9)
	lfs 13,0(9)
	lwz 9,nightmare@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L47
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 9,gi@l(29)
	lis 4,.LC33@ha
	lwz 0,152(9)
	la 4,.LC33@l(4)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC34@ha
	li 3,2
	la 4,.LC34@l(4)
	b .L52
.L47:
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 9,gi@l(29)
	lis 4,.LC35@ha
	lwz 0,152(9)
	la 4,.LC35@l(4)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC36@ha
	li 3,2
	la 4,.LC36@l(4)
.L52:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L49
.L44:
	lis 29,gi@ha
	lis 28,.LC33@ha
	la 29,gi@l(29)
	lis 3,.LC31@ha
	lwz 9,144(29)
	la 4,.LC33@l(28)
	li 5,20
	la 3,.LC31@l(3)
	mtlr 9
	blrl
	lwz 10,144(29)
	lis 9,nightmare@ha
	lis 11,.LC37@ha
	stw 3,nightmare@l(9)
	la 4,.LC33@l(28)
	li 5,0
	mtlr 10
	la 3,.LC37@l(11)
	blrl
	lis 9,nighttime@ha
	lwz 0,144(29)
	lis 11,.LC38@ha
	stw 3,nighttime@l(9)
	la 4,.LC33@l(28)
	li 5,0
	la 3,.LC38@l(11)
	mtlr 0
	blrl
	lis 9,lighttime@ha
	stw 3,lighttime@l(9)
.L49:
	lis 9,.LC39@ha
	lis 11,nightmare@ha
	la 9,.LC39@l(9)
	lfs 13,0(9)
	lwz 9,nightmare@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,1,.L50
	lis 9,nightmareModeState@ha
	li 0,1
	b .L53
.L50:
	lis 9,nightmareModeState@ha
	li 0,0
.L53:
	stw 0,nightmareModeState@l(9)
	bl nightmareModeSetup
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 nightmareModeToggle,.Lfe5-nightmareModeToggle
	.section	".rodata"
	.align 2
.LC41:
	.long 0x3e4ccccd
	.align 2
.LC42:
	.long 0x3f800000
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.globl nightmareResetFlashlight
	.type	 nightmareResetFlashlight,@function
nightmareResetFlashlight:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 30,256(31)
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L10
	lwz 0,3956(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	lwz 0,3824(9)
	lis 9,.LC42@ha
	cmpwi 0,0,0
	la 9,.LC42@l(9)
	lfs 31,0(9)
	bc 12,2,.L11
	lis 9,.LC41@ha
	lfs 31,.LC41@l(9)
.L11:
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC42@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC42@l(9)
	li 4,17
	lfs 2,0(9)
	mtlr 0
	mr 3,30
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,256(31)
	li 0,0
	lwz 9,84(11)
	stw 0,3956(9)
	lwz 11,256(31)
	lwz 9,84(11)
	stw 0,3960(9)
.L10:
	mr 3,31
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 nightmareResetFlashlight,.Lfe6-nightmareResetFlashlight
	.section	".rodata"
	.align 2
.LC44:
	.long 0x3e4ccccd
	.align 2
.LC45:
	.long 0x3f800000
	.align 2
.LC46:
	.long 0x0
	.section	".text"
	.align 2
	.globl nightmarePlayerResetFlashlight
	.type	 nightmarePlayerResetFlashlight,@function
nightmarePlayerResetFlashlight:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	lwz 9,84(3)
	lwz 31,3956(9)
	cmpwi 0,31,0
	bc 12,2,.L55
	lwz 30,256(31)
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L56
	lwz 0,3956(9)
	cmpwi 0,0,0
	bc 12,2,.L56
	lwz 0,3824(9)
	lis 9,.LC45@ha
	cmpwi 0,0,0
	la 9,.LC45@l(9)
	lfs 31,0(9)
	bc 12,2,.L57
	lis 9,.LC44@ha
	lfs 31,.LC44@l(9)
.L57:
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC45@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC45@l(9)
	li 4,17
	lfs 2,0(9)
	mtlr 0
	mr 3,30
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,256(31)
	li 0,0
	lwz 9,84(11)
	stw 0,3956(9)
	lwz 11,256(31)
	lwz 9,84(11)
	stw 0,3960(9)
.L56:
	mr 3,31
	bl G_FreeEdict
.L55:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 nightmarePlayerResetFlashlight,.Lfe7-nightmarePlayerResetFlashlight
	.align 2
	.globl nightmareEffects
	.type	 nightmareEffects,@function
nightmareEffects:
	lwz 9,84(3)
	lwz 0,3956(9)
	cmpwi 0,0,0
	bclr 12,2
	lwz 0,3960(9)
	cmpwi 0,0,1
	bclr 12,2
	lwz 0,68(3)
	ori 0,0,8
	stw 0,68(3)
	blr
.Lfe8:
	.size	 nightmareEffects,.Lfe8-nightmareEffects
	.comm	nightmareToggleTime,4,4
	.comm	nightmareModeState,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
