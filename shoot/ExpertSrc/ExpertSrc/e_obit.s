	.file	"e_obit.c"
gcc2_compiled.:
	.globl o_Causes
	.section	".data"
	.type	 o_Causes,@object
	.size	 o_Causes,700
o_Causes:
	.string	"*"
	.space	18
	.string	"blaster"
	.space	12
	.string	"shotgun"
	.space	12
	.string	"sshotgun"
	.space	11
	.string	"machinegun"
	.space	9
	.string	"chaingun"
	.space	11
	.string	"grenade"
	.space	12
	.string	"grenade splash"
	.space	5
	.string	"rocket"
	.space	13
	.string	"rocket splash"
	.space	6
	.string	"hyperblaster"
	.space	7
	.string	"railgun"
	.space	12
	.string	"bfg laser"
	.space	10
	.string	"bfg blast"
	.space	10
	.string	"bfg effect"
	.space	9
	.string	"handgrenade"
	.space	8
	.string	"handgrenade splash"
	.space	1
	.string	"water"
	.space	14
	.string	"slime"
	.space	14
	.string	"lava"
	.space	15
	.string	"crush"
	.space	14
	.string	"telefrag"
	.space	11
	.string	"falling"
	.space	12
	.string	"suicide"
	.space	12
	.string	"held grenade"
	.space	7
	.string	"explosive"
	.space	10
	.string	"barrel"
	.space	13
	.string	"bomb"
	.space	15
	.string	"exit"
	.space	15
	.string	"splash"
	.space	13
	.string	"target laser"
	.space	7
	.string	"trigger hurt"
	.space	7
	.string	"hit"
	.space	16
	.string	"target blaster"
	.space	5
	.string	"grapple"
	.space	12
	.globl o_Contexts
	.type	 o_Contexts,@object
	.size	 o_Contexts,580
o_Contexts:
	.string	"victim female"
	.space	6
	.string	"victim male"
	.space	8
	.string	"attacker female"
	.space	4
	.string	"attacker male"
	.space	6
	.string	"attacker has quad"
	.space	2
	.string	"attacker has invuln"
	.string	"victim has quad"
	.space	4
	.string	"victim has invuln"
	.space	2
	.string	"victim short life"
	.space	2
	.string	"victim long life"
	.space	3
	.string	"attacker long life"
	.space	1
	.string	"leg hit"
	.space	12
	.string	"torso hit"
	.space	10
	.string	"head hit"
	.space	11
	.string	"front hit"
	.space	10
	.string	"side hit"
	.space	11
	.string	"back hit"
	.space	11
	.string	"gibbed"
	.space	13
	.string	"pointblank range"
	.space	3
	.string	"extreme range"
	.space	6
	.string	"mercy kill"
	.space	9
	.string	"victim on ground"
	.space	3
	.string	"attacker on ground"
	.space	1
	.string	"victim airborne"
	.space	4
	.string	"attacker airborne"
	.space	2
	.string	"victim above"
	.space	7
	.string	"attacker above"
	.space	5
	.string	"friendly fire"
	.space	6
	.string	"kill self"
	.space	10
	.section	".text"
	.align 2
	.globl ExpertClientObituary
	.type	 ExpertClientObituary,@function
ExpertClientObituary:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 27,28(1)
	stw 0,52(1)
	stw 12,24(1)
	mr 31,3
	mr 30,5
	cmpw 0,30,31
	mr 28,6
	rlwinm 27,28,0,5,3
	li 6,0
	rlwinm 29,28,0,4,4
	bc 4,2,.L8
	lwz 11,84(31)
	cmpwi 4,31,0
	lwz 9,3432(11)
	addi 9,9,-1
	stw 9,3432(11)
	stw 6,540(31)
	b .L9
.L8:
	cmpwi 0,29,0
	stw 30,540(31)
	bc 12,2,.L10
	lwz 11,84(30)
	cmpwi 4,30,0
	b .L20
.L10:
	cmpwi 4,30,0
	bc 12,18,.L12
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L12
	lwz 9,3432(11)
	addi 9,9,1
	stw 9,3432(11)
	lwz 11,84(30)
	lwz 9,4576(11)
	addi 9,9,1
	stw 9,4576(11)
	b .L9
.L12:
	lwz 11,84(31)
.L20:
	lwz 9,3432(11)
	addi 9,9,-1
	stw 9,3432(11)
.L9:
	mr 6,7
	mr 3,31
	mr 5,30
	bl DiscoverContexts
	lis 10,sv_utilflags@ha
	lwz 11,sv_utilflags@l(10)
	mr 29,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,1
	bc 12,2,.L14
	andis. 0,29,4096
	bc 12,2,.L15
	mr 4,28
	mr 3,31
	bl gsLogKillSelf
	b .L14
.L15:
	mr 5,28
	mr 3,31
	mr 4,30
	bl gsLogFrag
.L14:
	mr 3,30
	bl GetEntityGender
	mr 28,3
	mr 3,31
	bl GetEntityGender
	mr 6,3
	bc 12,18,.L18
	lwz 7,84(30)
	cmpwi 0,7,0
	bc 4,2,.L17
.L18:
	lwz 8,84(31)
	mr 3,27
	mr 4,29
	mr 5,28
	li 7,0
	addi 8,8,700
	bl DisplayBestObituaryMessage
	b .L19
.L17:
	lwz 8,84(31)
	mr 3,27
	mr 4,29
	mr 5,28
	addi 7,7,700
	addi 8,8,700
	bl DisplayBestObituaryMessage
.L19:
	lwz 0,52(1)
	lwz 12,24(1)
	mtlr 0
	lmw 27,28(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe1:
	.size	 ExpertClientObituary,.Lfe1-ExpertClientObituary
	.section	".rodata"
	.align 2
.LC0:
	.string	"he"
	.align 2
.LC1:
	.string	"she"
	.align 2
.LC2:
	.string	"him"
	.align 2
.LC3:
	.string	"her"
	.align 2
.LC4:
	.string	"his"
	.align 2
.LC5:
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long .LC3
	.align 2
.LC6:
	.string	"%s died and nobody wrote an obituary.\n"
	.align 2
.LC7:
	.string	"$AName"
	.align 2
.LC8:
	.string	"$AHe"
	.align 2
.LC9:
	.string	"$AHim"
	.align 2
.LC10:
	.string	"$AHis"
	.align 2
.LC11:
	.string	"$VName"
	.align 2
.LC12:
	.string	"$VHe"
	.align 2
.LC13:
	.string	"$VHim"
	.align 2
.LC14:
	.string	"$VHis"
	.align 2
.LC15:
	.string	"%s\n"
	.section	".text"
	.align 2
	.globl PrintRandObitMsg
	.type	 PrintRandObitMsg,@function
PrintRandObitMsg:
	stwu 1,-96(1)
	mflr 0
	stmw 21,52(1)
	stw 0,100(1)
	lis 9,.LC5@ha
	mr. 27,7
	lwz 29,.LC5@l(9)
	addi 11,1,8
	mr 26,3
	la 9,.LC5@l(9)
	mr 21,11
	lwz 28,20(9)
	mr 25,4
	mr 23,5
	lwz 7,4(9)
	mr 22,6
	lwz 8,8(9)
	lwz 0,12(9)
	lwz 10,16(9)
	stw 29,8(1)
	stw 7,4(11)
	stw 8,8(11)
	stw 0,12(11)
	stw 10,16(11)
	stw 28,20(11)
	bc 4,2,.L36
	lis 9,gi@ha
	lis 4,.LC6@ha
	lwz 0,gi@l(9)
	la 4,.LC6@l(4)
	mr 5,25
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L35
.L36:
	li 4,512
	li 3,1
	bl calloc
	mr 30,3
	li 4,512
	li 3,1
	bl calloc
	mr 31,3
	li 4,100
	li 3,1
	bl calloc
	mr 29,3
	li 4,100
	li 3,1
	bl calloc
	cmpwi 0,26,0
	mr 24,3
	bc 12,2,.L37
	mr 4,26
	mr 3,29
	bl greenCopy
.L37:
	mr 4,25
	mr 3,24
	bl strcpy
	lwz 0,4(27)
	cmplwi 0,0,1
	bc 4,1,.L38
	li 3,0
	bl time
	bl srand
	bl rand
	lwz 11,4(27)
	mr 9,3
	lwz 10,8(27)
	mr 3,31
	divwu 0,9,11
	mullw 0,0,11
	subf 9,0,9
	slwi 9,9,2
	lwzx 4,9,10
	bl strcpy
	b .L39
.L38:
	lwz 9,8(27)
	mr 3,31
	lwz 4,0(9)
	bl strcpy
.L39:
	lis 5,.LC7@ha
	mr 6,29
	la 5,.LC7@l(5)
	li 7,512
	mr 4,31
	mr 3,30
	bl insertValue
	slwi 29,23,2
	slwi 28,22,2
	addi 27,1,16
	mr 4,30
	mr 3,31
	bl strcpy
	lwzx 6,21,29
	lis 5,.LC8@ha
	addi 26,1,24
	la 5,.LC8@l(5)
	li 7,512
	mr 4,31
	mr 3,30
	bl insertValue
	mr 4,30
	mr 3,31
	bl strcpy
	lwzx 6,27,29
	lis 5,.LC9@ha
	li 7,512
	la 5,.LC9@l(5)
	mr 4,31
	mr 3,30
	bl insertValue
	mr 4,30
	mr 3,31
	bl strcpy
	lwzx 6,26,29
	lis 5,.LC10@ha
	li 7,512
	la 5,.LC10@l(5)
	mr 4,31
	mr 3,30
	bl insertValue
	mr 4,30
	mr 3,31
	bl strcpy
	lis 5,.LC11@ha
	mr 6,24
	la 5,.LC11@l(5)
	li 7,512
	mr 4,31
	mr 3,30
	bl insertValue
	mr 4,30
	mr 3,31
	bl strcpy
	lwzx 6,21,28
	lis 5,.LC12@ha
	li 7,512
	la 5,.LC12@l(5)
	mr 4,31
	mr 3,30
	bl insertValue
	mr 4,30
	mr 3,31
	bl strcpy
	lwzx 6,27,28
	lis 5,.LC13@ha
	li 7,512
	la 5,.LC13@l(5)
	mr 4,31
	mr 3,30
	bl insertValue
	mr 4,30
	mr 3,31
	bl strcpy
	lwzx 6,26,28
	lis 5,.LC14@ha
	li 7,512
	la 5,.LC14@l(5)
	mr 4,31
	mr 3,30
	bl insertValue
	mr 4,30
	mr 3,31
	bl strcpy
	lis 9,gi@ha
	lis 4,.LC15@ha
	lwz 0,gi@l(9)
	la 4,.LC15@l(4)
	li 3,1
	mr 5,31
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	bl free
	mr 3,31
	bl free
.L35:
	lwz 0,100(1)
	mtlr 0
	lmw 21,52(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 PrintRandObitMsg,.Lfe2-PrintRandObitMsg
	.section	".rodata"
	.align 2
.LC16:
	.string	"Expert Client Obituary Disabled.\n"
	.align 2
.LC17:
	.string	"Expert Client Obituary failed to load.\n"
	.align 2
.LC18:
	.string	"\nExpert Client Obituary Memory Stats\n"
	.align 2
.LC19:
	.string	"-----------------------------------\n"
	.align 2
.LC20:
	.string	"Total Number of Messages: %i\n"
	.align 2
.LC21:
	.string	"Memory Used in bytes:     %i\n"
	.align 2
.LC22:
	.string	"\n"
	.section	".text"
	.align 2
	.globl DisplayObituaryInfo
	.type	 DisplayObituaryInfo,@function
DisplayObituaryInfo:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gCauseTable@ha
	mr 31,3
	lwz 0,gCauseTable@l(9)
	cmpwi 0,0,0
	bc 4,2,.L41
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,2
	bc 12,2,.L42
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 0,gi+8@l(9)
	la 5,.LC16@l(5)
	li 4,1
	b .L45
.L42:
	lis 9,gi+8@ha
	lis 5,.LC17@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC17@l(5)
	li 4,2
.L45:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L44
.L41:
	lis 29,gi@ha
	lis 5,.LC18@ha
	la 29,gi@l(29)
	la 5,.LC18@l(5)
	lwz 9,8(29)
	mr 3,31
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,8(29)
	lis 9,gMsgCount@ha
	lis 5,.LC20@ha
	la 5,.LC20@l(5)
	lwz 6,gMsgCount@l(9)
	mr 3,31
	mtlr 11
	li 4,1
	crxor 6,6,6
	blrl
	lwz 11,8(29)
	lis 9,gMemAllocated@ha
	lis 5,.LC21@ha
	la 5,.LC21@l(5)
	mr 3,31
	lwz 6,gMemAllocated@l(9)
	li 4,1
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
.L44:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 DisplayObituaryInfo,.Lfe3-DisplayObituaryInfo
	.section	".rodata"
	.align 2
.LC25:
	.string	"player"
	.align 3
.LC23:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC24:
	.long 0xbfd99999
	.long 0x9999999a
	.align 2
.LC26:
	.long 0xc2200000
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC28:
	.long 0x41c00000
	.align 2
.LC29:
	.long 0x40a00000
	.align 2
.LC30:
	.long 0x43960000
	.align 2
.LC31:
	.long 0x42000000
	.align 2
.LC32:
	.long 0xc2000000
	.align 2
.LC33:
	.long 0x42c80000
	.align 2
.LC34:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl DiscoverContexts
	.type	 DiscoverContexts,@function
DiscoverContexts:
	stwu 1,-80(1)
	mflr 0
	stmw 26,56(1)
	stw 0,84(1)
	lis 9,sv_lethality@ha
	lis 10,.LC26@ha
	lwz 11,sv_lethality@l(9)
	la 10,.LC26@l(10)
	mr 30,3
	lfs 12,0(10)
	mr 26,4
	mr 29,5
	lfs 0,20(11)
	mr 28,6
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,48(1)
	lwz 27,52(1)
	bl GetEntityGender
	cmpwi 0,3,1
	bc 4,2,.L47
	li 31,1
	b .L48
.L47:
	li 31,2
.L48:
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 12,2,.L49
	oris 31,31,0x20
	b .L50
.L49:
	mr 3,30
	bl nearToGround
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	oris 9,31,0x80
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L50:
	lis 11,level@ha
	lwz 8,84(30)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC27@ha
	lfs 12,3948(8)
	xoris 0,0,0x8000
	la 11,.LC27@l(11)
	stw 0,52(1)
	stw 10,48(1)
	lfd 13,0(11)
	lfd 0,48(1)
	ori 11,31,64
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,12,13
	bc 4,1,.L52
	mr 31,11
.L52:
	lfs 0,3952(8)
	ori 0,31,128
	fcmpu 0,0,13
	bc 4,1,.L53
	mr 31,0
.L53:
	lwz 0,184(8)
	oris 11,31,0x10
	lwz 9,480(30)
	cmpwi 7,0,900
	lfs 12,8(28)
	cmpw 6,9,27
	lfs 13,12(30)
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	mfcr 9
	rlwinm 9,9,26,1
	fcmpu 0,12,13
	andc 11,11,0
	neg 9,9
	and 0,31,0
	or 31,0,11
	oris 0,31,0x2
	and 11,31,9
	andc 9,0,9
	or 31,11,9
	bc 4,0,.L56
	ori 31,31,2048
	b .L57
.L56:
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	fcmpu 0,12,0
	bc 4,0,.L58
	ori 31,31,4096
	b .L57
.L58:
	ori 31,31,8192
.L57:
	addi 3,30,16
	addi 4,1,24
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 10,4(30)
	addi 3,1,8
	lfs 9,8(30)
	lfs 12,12(30)
	lfs 11,8(28)
	lfs 13,0(28)
	lfs 0,4(28)
	fsubs 11,11,12
	fsubs 13,13,10
	fsubs 0,0,9
	stfs 11,16(1)
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorNormalize
	lfs 0,28(1)
	lis 9,.LC23@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC23@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fmr 12,0
	fcmpu 0,12,13
	bc 4,1,.L60
	ori 31,31,16384
	b .L61
.L60:
	lis 9,.LC24@ha
	lfd 0,.LC24@l(9)
	fcmpu 0,12,0
	bc 4,0,.L62
	oris 31,31,0x1
	b .L61
.L62:
	ori 31,31,32768
.L61:
	lwz 11,84(30)
	lis 9,level+4@ha
	lis 10,.LC29@ha
	lfs 13,level+4@l(9)
	la 10,.LC29@l(10)
	ori 0,31,256
	lfs 0,3984(11)
	lfs 12,0(10)
	fsubs 13,13,0
	fcmpu 0,13,12
	bc 4,0,.L64
	mr 31,0
.L64:
	lis 11,.LC30@ha
	ori 0,31,512
	la 11,.LC30@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L65
	mr 31,0
.L65:
	subfic 0,29,0
	adde 9,0,29
	xor 0,30,29
	subfic 10,0,0
	adde 0,10,0
	or. 11,9,0
	bc 4,2,.L67
	lwz 3,280(29)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L66
.L67:
	oris 3,31,0x1000
	b .L85
.L66:
	lwz 0,84(29)
	mr 3,31
	cmpwi 0,0,0
	bc 12,2,.L85
	mr 3,29
	bl GetEntityGender
	cmpwi 0,3,1
	bc 4,2,.L69
	ori 31,31,4
	b .L70
.L69:
	ori 31,31,8
.L70:
	lwz 11,84(29)
	lis 9,level+4@ha
	lis 10,.LC30@ha
	lfs 0,level+4@l(9)
	la 10,.LC30@l(10)
	ori 0,31,1024
	lfs 13,3984(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L71
	mr 31,0
.L71:
	lfs 0,12(29)
	lis 11,.LC31@ha
	lfs 13,12(30)
	la 11,.LC31@l(11)
	lfs 12,0(11)
	fsubs 1,0,13
	fcmpu 0,1,12
	bc 4,1,.L72
	oris 31,31,0x400
	b .L73
.L72:
	lis 9,.LC32@ha
	oris 0,31,0x200
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L73
	mr 31,0
.L73:
	lwz 0,552(29)
	oris 9,31,0x40
	lis 4,.LC25@ha
	lwz 3,280(26)
	la 4,.LC25@l(4)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,31,0
	or 31,0,9
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L78
	lwz 0,904(26)
	oris 9,31,0x100
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L78:
	lis 11,level@ha
	lwz 8,84(29)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC27@ha
	lfs 12,3948(8)
	xoris 0,0,0x8000
	la 11,.LC27@l(11)
	stw 0,52(1)
	stw 10,48(1)
	lfd 13,0(11)
	lfd 0,48(1)
	ori 11,31,16
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,12,13
	bc 4,1,.L80
	mr 31,11
.L80:
	lfs 0,3952(8)
	ori 0,31,32
	fcmpu 0,0,13
	bc 4,1,.L81
	mr 31,0
.L81:
	mr 3,29
	mr 4,30
	bl playerDistance
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L82
	oris 31,31,0x4
	b .L83
.L82:
	lis 10,.LC34@ha
	oris 0,31,0x8
	la 10,.LC34@l(10)
	lfs 0,0(10)
	fcmpu 0,1,0
	bc 4,1,.L83
	mr 31,0
.L83:
	mr 3,31
.L85:
	lwz 0,84(1)
	mtlr 0
	lmw 26,56(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 DiscoverContexts,.Lfe4-DiscoverContexts
	.section	".rodata"
	.align 2
.LC35:
	.string	"Error: bogus cause number passed to messagesForContext: %d\n"
	.align 2
.LC36:
	.string	"all causes"
	.align 2
.LC37:
	.string	"\n  ================================\n\n"
	.align 2
.LC38:
	.string	"obituary.txt"
	.align 2
.LC39:
	.string	"********************\n"
	.align 2
.LC40:
	.string	"   ERROR: Couldn't allocate enough\n\t       memory for obituary. Default\n\t       messages will be used.\n"
	.align 2
.LC41:
	.string	"   Expert Obituary Initialized!\n"
	.section	".text"
	.align 2
	.globl InitExpertObituary
	.type	 InitExpertObituary,@function
InitExpertObituary:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	lis 29,.LC37@ha
	la 31,gi@l(9)
	la 3,.LC37@l(29)
	lwz 10,4(31)
	li 0,0
	lis 9,gMemAllocated@ha
	lis 11,gMsgCount@ha
	stw 0,gMemAllocated@l(9)
	mtlr 10
	stw 0,gMsgCount@l(11)
	crxor 6,6,6
	blrl
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	bl LoadMessageTree
	cmpwi 0,3,0
	lis 9,gCauseTable@ha
	stw 3,gCauseTable@l(9)
	bc 12,2,.L108
	crxor 6,6,6
	bl ReTagObitData
	cmpwi 0,3,0
	bc 4,2,.L107
.L108:
	lwz 9,4(31)
	lis 29,.LC39@ha
	la 3,.LC39@l(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(31)
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(31)
	la 3,.LC39@l(29)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L105
.L107:
	lwz 9,4(31)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(31)
	la 3,.LC37@l(29)
	mtlr 0
	crxor 6,6,6
	blrl
.L105:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 InitExpertObituary,.Lfe5-InitExpertObituary
	.align 2
	.globl addMessageToCause
	.type	 addMessageToCause,@function
addMessageToCause:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,4
	mr 27,3
	cmplwi 0,29,35
	mr 30,5
	bc 4,1,.L110
	lis 9,gi+4@ha
	lis 3,.LC35@ha
	lwz 0,gi+4@l(9)
	la 3,.LC35@l(3)
	li 31,0
	mtlr 0
	crxor 6,6,6
	blrl
	b .L111
.L110:
	lis 9,gCauseTable@ha
	slwi 10,29,2
	lwz 11,gCauseTable@l(9)
	lwzx 9,10,11
	lwz 10,4(9)
	cmpwi 0,10,0
	bc 4,2,.L112
	b .L119
.L125:
	mr 31,3
	b .L111
.L112:
	lwz 0,0(9)
	li 11,0
	cmplw 0,11,0
	bc 4,0,.L119
	mr 8,0
	mr 9,10
.L115:
	lwz 3,0(9)
	addi 9,9,4
	lwz 0,0(3)
	cmpw 0,0,30
	bc 12,2,.L125
	addi 11,11,1
	cmplw 0,11,8
	bc 12,0,.L115
.L119:
	li 31,0
.L111:
	cmpwi 0,31,0
	bc 4,2,.L120
	lis 9,gCauseTable@ha
	slwi 11,29,2
	lwz 10,gCauseTable@l(9)
	mr 28,11
	lis 31,gCauseTable@ha
	lwzx 10,11,10
	lwz 4,0(10)
	cmpwi 0,4,0
	bc 4,2,.L121
	li 3,4
	bl malloc
	b .L126
.L121:
	addi 4,4,1
	lwz 3,4(10)
	slwi 4,4,2
	bl realloc
.L126:
	lwz 9,gCauseTable@l(31)
	lwzx 11,28,9
	stw 3,4(11)
	lis 29,gCauseTable@ha
	lis 8,gi+132@ha
	lwz 10,gCauseTable@l(29)
	li 3,12
	li 4,766
	lwzx 11,28,10
	lwz 9,0(11)
	addi 9,9,1
	stw 9,0(11)
	lwz 0,gi+132@l(8)
	mtlr 0
	blrl
	lwz 9,gCauseTable@l(29)
	lis 7,gMemAllocated@ha
	mr 31,3
	lwz 11,gMemAllocated@l(7)
	lwzx 10,28,9
	addi 11,11,12
	lwz 9,0(10)
	lwz 8,4(10)
	addi 9,9,-1
	stw 11,gMemAllocated@l(7)
	slwi 9,9,2
	stwx 31,9,8
.L120:
	lwz 9,4(31)
	cmpwi 0,9,0
	bc 4,2,.L123
	li 0,1
	stw 30,0(31)
	li 3,4
	stw 0,4(31)
	bl malloc
	b .L127
.L123:
	addi 0,9,1
	lwz 3,8(31)
	slwi 4,0,2
	stw 0,4(31)
	bl realloc
.L127:
	stw 3,8(31)
	mr 3,27
	bl strlen
	lis 9,gi+132@ha
	slwi 29,3,2
	lwz 0,gi+132@l(9)
	addi 29,29,2
	li 4,766
	mr 3,29
	mtlr 0
	blrl
	mr 28,3
	mr 4,27
	bl strcpy
	lis 8,gMemAllocated@ha
	lis 7,gMsgCount@ha
	lwz 11,4(31)
	lwz 0,gMemAllocated@l(8)
	lwz 9,gMsgCount@l(7)
	slwi 11,11,2
	lwz 10,8(31)
	add 0,0,29
	addi 9,9,1
	stw 0,gMemAllocated@l(8)
	stw 9,gMsgCount@l(7)
	add 11,11,10
	stw 28,-4(11)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 addMessageToCause,.Lfe6-addMessageToCause
	.section	".rodata"
	.align 2
.LC42:
	.string	"/"
	.align 2
.LC43:
	.string	"   Loading Messages ...\n"
	.align 2
.LC44:
	.string	"r"
	.align 2
.LC45:
	.string	"   ERROR: Couldn't read/open\n          \"%s\"."
	.align 2
.LC46:
	.string	"#;'"
	.align 2
.LC47:
	.string	",\n\r"
	.align 2
.LC48:
	.string	"Error: \"%s\" is not a valid context.  Context discarded\n"
	.align 2
.LC49:
	.string	"|\n\r"
	.align 2
.LC50:
	.string	"*"
	.align 2
.LC51:
	.string	"Error: \"%s\" is not a valid cause-of-death\n"
	.align 2
.LC52:
	.string	"No valid causes provided for obituary \"%s\"\nThe obituary was discarded\n"
	.section	".text"
	.align 2
	.globl LoadMessageTree
	.type	 LoadMessageTree,@function
LoadMessageTree:
	stwu 1,-592(1)
	mflr 0
	stmw 16,528(1)
	stw 0,596(1)
	lis 28,gamedir@ha
	mr 30,3
	lwz 9,gamedir@l(28)
	li 27,0
	lis 16,gi@ha
	lwz 3,4(9)
	bl strlen
	mr 29,3
	mr 3,30
	bl strlen
	add 29,29,3
	addi 3,29,2
	bl malloc
	lwz 9,gamedir@l(28)
	mr 31,3
	lwz 4,4(9)
	bl strcpy
	lis 4,.LC42@ha
	mr 3,31
	la 4,.LC42@l(4)
	bl strcat
	mr 4,30
	mr 3,31
	bl strcat
	lis 9,gi@ha
	lis 3,.LC43@ha
	la 28,gi@l(9)
	la 3,.LC43@l(3)
	lwz 9,4(28)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 4,.LC44@ha
	mr 3,31
	la 4,.LC44@l(4)
	bl fopen
	mr. 18,3
	bc 4,2,.L129
	mr 3,31
	bl free
	lwz 0,4(28)
	lis 3,.LC45@ha
	mr 4,30
	la 3,.LC45@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L163
.L129:
	lwz 9,132(28)
	li 3,140
	li 4,766
	lis 29,gCauseTable@ha
	lis 26,gCauseTable@ha
	mtlr 9
	blrl
	lis 11,gMemAllocated@ha
	cmpwi 0,3,0
	stw 3,gCauseTable@l(29)
	lwz 9,gMemAllocated@l(11)
	addi 9,9,140
	stw 9,gMemAllocated@l(11)
	bc 4,2,.L130
	mr 3,31
	bl free
	lwz 0,4(28)
	b .L166
.L164:
	lwz 0,4(30)
.L166:
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L163
.L130:
	mr 30,28
	lis 29,gMemAllocated@ha
	li 31,0
.L134:
	lwz 9,132(30)
	li 3,8
	li 4,766
	mtlr 9
	blrl
	lwz 9,gCauseTable@l(26)
	cmpwi 0,3,0
	stwx 3,31,9
	bc 12,2,.L164
	lwz 9,gMemAllocated@l(29)
	addi 27,27,1
	addi 31,31,4
	cmpwi 0,27,34
	addi 9,9,8
	stw 9,gMemAllocated@l(29)
	bc 4,1,.L134
	lis 19,.LC47@ha
	lis 17,gi@ha
	b .L137
.L139:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,2
	bc 4,1,.L137
	lis 4,.LC46@ha
	addi 3,1,8
	la 4,.LC46@l(4)
	bl strcspn
	cmpwi 0,3,0
	bc 12,2,.L137
	addi 3,1,8
	la 4,.LC47@l(19)
	bl strtok
	li 27,0
	lis 25,.LC47@ha
	mr 24,3
	la 4,.LC47@l(19)
	li 3,0
	lis 26,.LC49@ha
	bl strtok
	mr 31,3
	li 3,0
	bl trimWhitespace
	li 3,0
	la 4,.LC47@l(19)
	bl strtok
	mr. 29,3
	bc 12,2,.L142
	la 30,gi@l(17)
	lis 28,.LC48@ha
.L143:
	mr 3,29
	bl trimWhitespace
	mr 3,29
	bl getContextBit
	mr. 3,3
	bc 4,2,.L144
	lwz 9,4(30)
	mr 4,29
	la 3,.LC48@l(28)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L145
.L144:
	or 27,27,3
.L145:
	li 3,0
	la 4,.LC47@l(25)
	bl strtok
	mr. 29,3
	bc 4,2,.L143
.L142:
	mr 3,31
	la 4,.LC49@l(26)
	bl strtok
	li 30,0
	mr. 31,3
	bc 12,2,.L148
	lis 9,o_Causes@ha
	lis 20,.LC36@ha
	la 21,o_Causes@l(9)
	lis 22,.LC50@ha
	la 23,gi@l(17)
	lis 25,.LC51@ha
.L150:
	mr 3,31
	la 4,.LC36@l(20)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L152
	li 29,-1
	b .L151
.L165:
	mr 29,28
	b .L151
.L152:
	li 28,34
	addi 29,21,680
.L155:
	mr 3,31
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L165
	addic. 28,28,-1
	addi 29,29,-20
	bc 4,2,.L155
	li 29,0
.L151:
	cmpwi 0,29,0
	bc 4,2,.L159
	mr 3,31
	la 4,.LC50@l(22)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L159
	lwz 9,4(23)
	mr 4,31
	la 3,.LC51@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L167
.L159:
	mr 4,29
	mr 3,24
	mr 5,27
	li 30,1
	bl addMessageToCause
.L167:
	li 3,0
	la 4,.LC49@l(26)
	bl strtok
	mr 31,3
	cmpwi 0,31,0
	bc 4,2,.L150
.L148:
	cmpwi 0,30,0
	bc 4,2,.L137
	la 9,gi@l(16)
	lis 3,.LC52@ha
	lwz 0,4(9)
	la 3,.LC52@l(3)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L137:
	addi 3,1,8
	li 4,512
	mr 5,18
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L139
	mr 3,18
	bl fclose
	lis 9,gCauseTable@ha
	lwz 3,gCauseTable@l(9)
.L163:
	lwz 0,596(1)
	mtlr 0
	lmw 16,528(1)
	la 1,592(1)
	blr
.Lfe7:
	.size	 LoadMessageTree,.Lfe7-LoadMessageTree
	.section	".rodata"
	.align 2
.LC53:
	.string	"skin"
	.section	".text"
	.align 2
	.globl MacroAddAll
	.type	 MacroAddAll,@function
MacroAddAll:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	mr 30,4
	mr 25,3
	mr 3,30
	li 26,0
	bl strlen
	lis 20,gi@ha
	lis 9,gi@ha
	slwi 3,3,2
	la 31,gi@l(9)
	addi 29,3,2
	lwz 9,132(31)
	mr 3,29
	li 4,766
	mtlr 9
	blrl
	mr. 24,3
	bc 4,2,.L218
	lwz 0,4(31)
	b .L247
.L244:
	lis 9,gi+4@ha
	lis 3,.LC40@ha
	lwz 0,gi+4@l(9)
	b .L248
.L245:
	lwz 0,4(30)
	b .L247
.L246:
	lis 9,gi+4@ha
	lis 3,.LC40@ha
	lwz 0,gi+4@l(9)
	b .L248
.L218:
	mr 4,30
	mr 3,24
	bl strcpy
	mr 22,31
	lis 23,gMemAllocated@ha
	lis 11,gMemAllocated@ha
	lis 10,gMsgCount@ha
	lwz 0,gMemAllocated@l(11)
	li 28,0
	lis 21,gCauseTable@ha
	lwz 9,gMsgCount@l(10)
	add 0,0,29
	addi 9,9,1
	stw 0,gMemAllocated@l(11)
	stw 9,gMsgCount@l(10)
.L222:
	cmplwi 0,26,35
	bc 4,1,.L223
	lwz 9,4(22)
	lis 3,.LC35@ha
	mr 4,26
	la 3,.LC35@l(3)
	li 31,0
	mtlr 9
	crxor 6,6,6
	blrl
	b .L224
.L223:
	lwz 9,gCauseTable@l(21)
	lwzx 9,28,9
	lwz 10,4(9)
	cmpwi 0,10,0
	bc 4,2,.L225
	b .L232
.L243:
	mr 31,3
	b .L224
.L225:
	lwz 0,0(9)
	li 11,0
	cmplw 0,11,0
	bc 4,0,.L232
	mr 8,0
	mr 9,10
.L228:
	lwz 3,0(9)
	addi 9,9,4
	lwz 0,0(3)
	cmpw 0,0,25
	bc 12,2,.L243
	addi 11,11,1
	cmplw 0,11,8
	bc 12,0,.L228
.L232:
	li 31,0
.L224:
	cmpwi 0,31,0
	bc 4,2,.L233
	lis 9,gCauseTable@ha
	lis 29,gCauseTable@ha
	lwz 11,gCauseTable@l(9)
	slwi 27,26,2
	lwzx 9,28,11
	lwz 4,0(9)
	cmpwi 0,4,0
	bc 4,2,.L234
	li 3,4
	bl malloc
	b .L249
.L234:
	addi 4,4,1
	lwz 3,4(9)
	slwi 4,4,2
	bl realloc
.L249:
	lwz 9,gCauseTable@l(29)
	lwzx 11,28,9
	stw 3,4(11)
	lwz 8,gCauseTable@l(29)
	lwzx 10,28,8
	lwz 9,0(10)
	addi 9,9,1
	stw 9,0(10)
	lwzx 11,28,8
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L244
	la 30,gi@l(20)
	li 3,12
	lwz 9,132(30)
	li 4,766
	mtlr 9
	blrl
	mr. 31,3
	bc 12,2,.L245
	lwz 9,gCauseTable@l(29)
	lwz 11,gMemAllocated@l(23)
	lwzx 10,27,9
	addi 11,11,12
	lwz 9,0(10)
	lwz 8,4(10)
	addi 9,9,-1
	stw 11,gMemAllocated@l(23)
	slwi 9,9,2
	stwx 31,9,8
.L233:
	lwz 9,4(31)
	cmpwi 0,9,0
	bc 4,2,.L238
	li 0,1
	stw 25,0(31)
	li 3,4
	stw 0,4(31)
	bl malloc
	cmpwi 0,3,0
	stw 3,8(31)
	bc 4,2,.L240
	lwz 0,4(22)
.L247:
	lis 3,.LC40@ha
.L248:
	la 3,.LC40@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L217
.L238:
	addi 0,9,1
	lwz 3,8(31)
	slwi 4,0,2
	stw 0,4(31)
	bl realloc
	cmpwi 0,3,0
	stw 3,8(31)
	bc 12,2,.L246
.L240:
	lwz 9,4(31)
	addi 26,26,1
	addi 28,28,4
	lwz 0,8(31)
	cmpwi 0,26,34
	slwi 9,9,2
	add 9,9,0
	stw 24,-4(9)
	bc 4,1,.L222
.L217:
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 MacroAddAll,.Lfe8-MacroAddAll
	.section	".rodata"
	.align 2
.LC54:
	.string	"%s[%d], "
	.align 2
.LC55:
	.string	"none"
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.comm	gMemAllocated,4,4
	.comm	gMsgCount,4,4
	.section	".text"
	.align 2
	.globl GetEntityGender
	.type	 GetEntityGender,@function
GetEntityGender:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L215
	lis 4,.LC53@ha
	addi 3,3,188
	la 4,.LC53@l(4)
	bl Info_ValueForKey
	lbz 3,0(3)
	xori 0,3,70
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,102
	subfic 9,3,0
	adde 3,9,3
	or 3,3,0
	b .L256
.L215:
	li 3,0
.L256:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 GetEntityGender,.Lfe9-GetEntityGender
	.align 2
	.globl DisplayBestObituaryMessage
	.type	 DisplayBestObituaryMessage,@function
DisplayBestObituaryMessage:
	stwu 1,-64(1)
	mflr 0
	stmw 21,20(1)
	stw 0,68(1)
	mr 26,3
	mr 30,4
	mr 22,5
	mr 21,6
	mr 24,7
	mr 23,8
	bl messagesForContext
	mr. 29,3
	bc 12,2,.L22
.L257:
	mr 3,24
	mr 4,23
	mr 5,22
	mr 6,21
	mr 7,29
	bl PrintRandObitMsg
	b .L21
.L22:
	mr 3,30
	li 27,0
	bl numberOfBitsSet
	mr 28,3
	cmplw 0,29,28
	bc 4,0,.L24
	li 25,1
.L26:
	li 31,0
.L30:
	slw 0,25,31
	and. 9,0,30
	bc 12,2,.L29
	andc 4,30,0
	mr 3,26
	bl messagesForContext
	mr. 29,3
	bc 4,2,.L257
.L29:
	addi 31,31,1
	cmplwi 0,31,31
	bc 4,1,.L30
	mr 3,30
	addi 27,27,1
	bl lowestOrderBit
	cmplw 0,27,28
	andc 30,30,3
	bc 12,0,.L26
.L24:
	li 4,0
	li 3,0
	bl messagesForContext
	mr 29,3
	mr 4,23
	mr 3,24
	mr 5,22
	mr 6,21
	mr 7,29
	bl PrintRandObitMsg
.L21:
	lwz 0,68(1)
	mtlr 0
	lmw 21,20(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 DisplayBestObituaryMessage,.Lfe10-DisplayBestObituaryMessage
	.align 2
	.globl messagesForContext
	.type	 messagesForContext,@function
messagesForContext:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	mr 8,4
	cmplwi 0,10,35
	bc 4,1,.L87
	lis 9,gi+4@ha
	lis 3,.LC35@ha
	lwz 0,gi+4@l(9)
	la 3,.LC35@l(3)
	mr 4,10
	mtlr 0
	crxor 6,6,6
	blrl
	b .L90
.L87:
	lis 9,gCauseTable@ha
	slwi 10,10,2
	lwz 11,gCauseTable@l(9)
	lwzx 3,10,11
	lwz 0,4(3)
	cmpwi 0,0,0
	bc 4,2,.L88
	li 3,0
	b .L258
.L88:
	lwz 3,0(3)
	li 11,0
	cmplw 0,11,3
	bc 4,0,.L90
	mr 4,3
	mr 9,0
.L92:
	lwz 3,0(9)
	addi 9,9,4
	lwz 0,0(3)
	cmpw 0,0,8
	bc 12,2,.L258
	addi 11,11,1
	cmplw 0,11,4
	bc 12,0,.L92
.L90:
	li 3,0
.L258:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 messagesForContext,.Lfe11-messagesForContext
	.align 2
	.globl ReTagObitData
	.type	 ReTagObitData,@function
ReTagObitData:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	li 30,0
	lis 29,gCauseTable@ha
	li 31,0
.L172:
	lwz 9,gCauseTable@l(29)
	lwzx 3,31,9
	bl TagMallocObituary
	cmpwi 0,3,0
	bc 4,2,.L171
	li 3,0
	b .L260
.L171:
	addi 30,30,1
	addi 31,31,4
	cmplwi 0,30,34
	bc 4,1,.L172
	li 3,1
.L260:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ReTagObitData,.Lfe12-ReTagObitData
	.align 2
	.globl TagMallocObituary
	.type	 TagMallocObituary,@function
TagMallocObituary:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	lis 9,gi+132@ha
	lwz 0,0(30)
	li 4,766
	lwz 9,gi+132@l(9)
	slwi 31,0,2
	mr 3,31
	mtlr 9
	blrl
	mr. 28,3
	bc 4,2,.L176
.L263:
	li 3,0
	b .L261
.L176:
	lis 11,gMemAllocated@ha
	lwz 9,0(30)
	li 29,0
	lwz 0,gMemAllocated@l(11)
	cmplw 0,29,9
	add 0,0,31
	stw 0,gMemAllocated@l(11)
	bc 4,0,.L178
	li 31,0
.L180:
	lwz 9,4(30)
	lwzx 0,31,9
	stwx 0,31,28
	lwz 9,4(30)
	lwzx 3,31,9
	bl TagMallocMessages
	cmpwi 0,3,0
	bc 12,2,.L263
	lwz 0,0(30)
	addi 29,29,1
	addi 31,31,4
	cmplw 0,29,0
	bc 12,0,.L180
.L178:
	lwz 3,4(30)
	bl free
	stw 28,4(30)
	mr 3,28
.L261:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 TagMallocObituary,.Lfe13-TagMallocObituary
	.align 2
	.globl TagMallocMessages
	.type	 TagMallocMessages,@function
TagMallocMessages:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 9,gi+132@ha
	lwz 0,4(31)
	li 4,766
	lwz 9,gi+132@l(9)
	slwi 29,0,2
	mr 3,29
	mtlr 9
	blrl
	mr. 30,3
	bc 4,2,.L184
	li 3,0
	b .L264
.L184:
	lis 11,gMemAllocated@ha
	lwz 9,4(31)
	li 10,0
	lwz 0,gMemAllocated@l(11)
	cmplw 0,10,9
	add 0,0,29
	stw 0,gMemAllocated@l(11)
	bc 4,0,.L186
	li 11,0
.L188:
	lwz 9,8(31)
	addi 10,10,1
	lwzx 0,11,9
	stwx 0,11,30
	lwz 9,4(31)
	addi 11,11,4
	cmplw 0,10,9
	bc 12,0,.L188
.L186:
	lwz 3,8(31)
	bl free
	stw 30,8(31)
	mr 3,30
.L264:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 TagMallocMessages,.Lfe14-TagMallocMessages
	.align 2
	.globl getCauseNumber
	.type	 getCauseNumber,@function
getCauseNumber:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr. 29,3
	li 3,0
	bc 12,2,.L265
	lis 4,.LC36@ha
	mr 3,29
	la 4,.LC36@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L98
	li 3,-1
	b .L265
.L266:
	mr 3,31
	b .L265
.L98:
	lis 9,o_Causes@ha
	li 31,34
	la 9,o_Causes@l(9)
	addi 30,9,680
.L102:
	mr 3,29
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L266
	addic. 31,31,-1
	addi 30,30,-20
	bc 4,2,.L102
	li 3,0
.L265:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 getCauseNumber,.Lfe15-getCauseNumber
	.align 2
	.globl getContextNumber
	.type	 getContextNumber,@function
getContextNumber:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,o_Contexts@ha
	mr 29,3
	la 30,o_Contexts@l(9)
	li 31,0
.L194:
	mr 3,29
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L193
	mr 3,31
	b .L267
.L193:
	addi 31,31,1
	addi 30,30,20
	cmplwi 0,31,28
	bc 4,1,.L194
	li 3,-1
.L267:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 getContextNumber,.Lfe16-getContextNumber
	.align 2
	.globl getContextBit
	.type	 getContextBit,@function
getContextBit:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,o_Contexts@ha
	mr 29,3
	la 30,o_Contexts@l(9)
	li 31,0
.L200:
	mr 3,29
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L269
	addi 31,31,1
	addi 30,30,20
	cmplwi 0,31,28
	bc 4,1,.L200
	li 0,-1
.L202:
	cmpwi 0,0,-1
	bc 4,2,.L205
	li 3,0
	b .L268
.L269:
	mr 0,31
	b .L202
.L270:
	mr 0,31
	b .L211
.L205:
	lis 9,o_Contexts@ha
	li 31,0
	la 30,o_Contexts@l(9)
.L209:
	mr 3,29
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L270
	addi 31,31,1
	addi 30,30,20
	cmplwi 0,31,28
	bc 4,1,.L209
	li 0,-1
.L211:
	li 3,1
	slw 3,3,0
.L268:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 getContextBit,.Lfe17-getContextBit
	.align 2
	.globl printContext
	.type	 printContext,@function
printContext:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 30,3
	cmpwi 0,30,0
	mr 31,30
	bc 12,2,.L252
	lis 11,o_Contexts@ha
	lis 9,gi@ha
	la 25,gi@l(9)
	la 26,o_Contexts@l(11)
	lis 27,.LC54@ha
.L253:
	mr 3,31
	bl lowestOrderBit
	mr 29,3
	bl log2
	mulli 28,3,20
	mr 3,29
	add 28,28,26
	bl log2
	lwz 9,4(25)
	mr 5,3
	mr 4,28
	la 3,.LC54@l(27)
	mtlr 9
	crxor 6,6,6
	blrl
	andc. 31,31,29
	bc 4,2,.L253
.L252:
	cmpwi 0,30,0
	bc 4,2,.L255
	lis 9,gi+4@ha
	lis 3,.LC55@ha
	lwz 0,gi+4@l(9)
	la 3,.LC55@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L255:
	lis 9,gi+4@ha
	lis 3,.LC22@ha
	lwz 0,gi+4@l(9)
	la 3,.LC22@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 printContext,.Lfe18-printContext
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
