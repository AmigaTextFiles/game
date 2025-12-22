	.file	"k2_cycle.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 2
.LC0:
	.string	"Reading new map list.\n"
	.align 2
.LC1:
	.string	"resetlevels"
	.align 2
.LC2:
	.string	"0"
	.align 2
.LC3:
	.string	"target_changelevel"
	.align 2
.LC4:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_CheckLevelCycle
	.type	 K2_CheckLevelCycle,@function
K2_CheckLevelCycle:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 11,.LC4@ha
	lis 9,levelcycle@ha
	la 11,.LC4@l(11)
	lfs 31,0(11)
	lwz 11,levelcycle@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L13
	li 3,0
	b .L26
.L13:
	lis 9,resetlevels@ha
	lwz 11,resetlevels@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L15
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L16
	bl K2_ReadCTFLevelCycleFile
	b .L17
.L16:
	bl K2_ReadDMLevelCycleFile
.L17:
	lis 9,gi+148@ha
	lis 3,.LC1@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC2@ha
	la 3,.LC1@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L15:
	lis 9,.LC4@ha
	lis 11,ctf@ha
	la 9,.LC4@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L18
	lis 9,iCurrCTFLevel@ha
	lis 11,iTotalCTFLevels@ha
	lwz 9,iCurrCTFLevel@l(9)
	lis 10,iCurrCTFLevel@ha
	lwz 0,iTotalCTFLevels@l(11)
	cmpw 0,9,0
	li 0,0
	bc 12,2,.L27
	addi 0,9,1
.L27:
	stw 0,iCurrCTFLevel@l(10)
	lis 11,iCurrCTFLevel@ha
	lis 9,CTFLevels@ha
	lwz 3,iCurrCTFLevel@l(11)
	la 9,CTFLevels@l(9)
	slwi 3,3,4
	add 3,3,9
	bl K2_GetCTFLevelSettings
	b .L28
.L18:
	lis 9,iCurrLevel@ha
	lis 11,iTotalLevels@ha
	lwz 9,iCurrLevel@l(9)
	lis 10,iCurrLevel@ha
	lwz 0,iTotalLevels@l(11)
	cmpw 0,9,0
	li 0,0
	bc 12,2,.L29
	addi 0,9,1
.L29:
	stw 0,iCurrLevel@l(10)
	lis 11,iCurrLevel@ha
	lis 9,Levels@ha
	lwz 3,iCurrLevel@l(11)
	la 9,Levels@l(9)
	slwi 3,3,4
	add 3,3,9
	bl K2_GetDMLevelSettings
.L28:
	mr 31,3
	bl G_Spawn
	lis 11,.LC3@ha
	mr 9,3
	la 11,.LC3@l(11)
	stw 31,504(9)
	stw 11,280(9)
	bl BeginIntermission
	li 3,1
.L26:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 K2_CheckLevelCycle,.Lfe1-K2_CheckLevelCycle
	.section	".rodata"
	.align 2
.LC5:
	.string	""
	.globl memset
	.align 2
.LC6:
	.string	"game"
	.align 2
.LC7:
	.string	"baseq2"
	.align 2
.LC8:
	.string	"DM Level cycling is ON\n"
	.align 2
.LC9:
	.string	"%s/k2maps.txt"
	.align 2
.LC10:
	.string	"rt"
	.align 2
.LC11:
	.string	"%s"
	.align 2
.LC12:
	.string	"[dmbegin]"
	.align 2
.LC13:
	.string	"-------------------------------------\n"
	.align 2
.LC14:
	.string	"ERROR - No maps listed in DM Section in \"%s\".\n"
	.align 2
.LC15:
	.string	"Level Cycling DISABLED\n\n"
	.align 2
.LC16:
	.string	"levelcycle"
	.align 2
.LC17:
	.string	"[dmend]"
	.align 2
.LC18:
	.string	"ERROR - No maps listed in \"%s\".\n"
	.align 2
.LC19:
	.string	"Bogus map...not added\n"
	.align 2
.LC20:
	.string	""
	.string	""
	.align 2
.LC21:
	.string	"Map:%s\tAdded\n"
	.align 2
.LC22:
	.string	"No DM maps listed in %s\n"
	.align 2
.LC23:
	.string	"%i map(s) loaded.\n\n"
	.align 2
.LC24:
	.string	"Couldn't open %s for level cycling\nLevel cycling not on\n"
	.section	".text"
	.align 2
	.globl K2_ReadDMLevelCycleFile
	.type	 K2_ReadDMLevelCycleFile,@function
K2_ReadDMLevelCycleFile:
	stwu 1,-224(1)
	mflr 0
	stmw 21,180(1)
	stw 0,228(1)
	lis 9,.LC5@ha
	addi 30,1,88
	lbz 29,.LC5@l(9)
	addi 3,1,9
	li 4,0
	li 5,79
	li 25,0
	stb 29,8(1)
	mr 22,30
	crxor 6,6,6
	bl memset
	addi 3,1,89
	stb 29,88(1)
	li 4,0
	li 5,49
	crxor 6,6,6
	bl memset
	lis 9,gi@ha
	lis 3,.LC6@ha
	la 28,gi@l(9)
	lis 4,.LC7@ha
	lwz 9,144(28)
	la 4,.LC7@l(4)
	li 5,4
	la 3,.LC6@l(3)
	mtlr 9
	blrl
	lwz 9,4(28)
	mr 29,3
	lis 3,.LC8@ha
	mtlr 9
	la 3,.LC8@l(3)
	crxor 6,6,6
	blrl
	lwz 5,4(29)
	lis 4,.LC9@ha
	mr 3,30
	la 4,.LC9@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC10@ha
	mr 3,30
	la 4,.LC10@l(4)
	bl fopen
	mr. 31,3
	bc 12,2,.L31
	lis 29,.LC11@ha
	lis 23,.LC11@ha
	lis 30,.LC12@ha
.L35:
	mr 3,31
	la 4,.LC11@l(29)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L67
	addi 3,1,8
	la 4,.LC12@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L35
	lhz 0,12(31)
	andi. 9,0,32
	bc 12,2,.L37
.L67:
	lis 29,gi@ha
	lis 28,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(28)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC14@ha
	mr 4,22
	la 3,.LC14@l(3)
	b .L70
.L37:
	addi 4,1,152
	mr 3,31
	mr 29,4
	lis 30,.LC17@ha
	bl fgetpos
.L41:
	mr 3,31
	la 4,.LC11@l(23)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L68
	addi 3,1,8
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L39
	addi 3,1,8
	la 4,.LC17@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L41
.L39:
	lhz 0,12(31)
	andi. 9,0,32
	bc 12,2,.L43
.L68:
	lis 29,gi@ha
	lis 28,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(28)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC18@ha
	mr 4,22
	la 3,.LC18@l(3)
.L70:
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,152(29)
	lis 3,.LC16@ha
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	la 3,.LC16@l(3)
	mtlr 9
	blrl
	lwz 0,4(29)
	la 3,.LC13@l(28)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl fclose
	b .L30
.L43:
	mr 4,29
	mr 3,31
	bl fsetpos
	lis 9,gi@ha
	lis 3,.LC13@ha
	la 9,gi@l(9)
	la 3,.LC13@l(3)
	lwz 0,4(9)
	mr 24,9
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,Levels@ha
	slwi 11,25,4
	la 9,Levels@l(9)
	mr 30,11
	addi 21,9,-1
	addi 26,11,1
	b .L45
.L47:
	la 4,.LC11@l(23)
	addi 5,1,8
	mr 3,31
	crxor 6,6,6
	bl fscanf
	addi 3,1,8
	li 4,35
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L45
	addi 3,1,8
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 12,2,.L45
	la 4,.LC17@l(29)
	addi 3,1,8
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L46
	addi 3,1,8
	mr 27,30
	bl strlen
	li 11,1
	lis 8,Levels@ha
	cmpw 0,11,3
	bc 4,0,.L53
	add 9,30,21
	addi 10,1,8
	addi 9,9,1
.L55:
	lbzx 0,10,11
	addi 11,11,1
	cmpw 0,11,3
	stb 0,0(9)
	addi 9,9,1
	bc 12,0,.L55
.L53:
	la 28,Levels@l(8)
	add 9,11,26
	li 0,0
	add 29,30,28
	stbx 0,28,9
	mr 3,29
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L58
	mr 3,29
	bl strlen
	cmplwi 0,3,1
	bc 12,1,.L57
.L58:
	lwz 9,4(24)
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,.LC20@ha
	lbz 0,.LC20@l(9)
	stbx 0,27,28
	b .L45
.L57:
	lwz 9,4(24)
	lis 3,.LC21@ha
	mr 4,29
	la 3,.LC21@l(3)
	addi 26,26,16
	mtlr 9
	addi 30,30,16
	addi 25,25,1
	crxor 6,6,6
	blrl
.L45:
	lhz 0,12(31)
	cmpwi 7,25,255
	xori 0,0,32
	rlwinm 0,0,27,31,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 12,2,.L46
	lis 29,.LC17@ha
	addi 3,1,8
	la 4,.LC17@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L47
.L46:
	mr 3,31
	bl fclose
	cmpwi 0,25,0
	bc 4,2,.L60
	lis 29,gi@ha
	lis 3,.LC22@ha
	la 29,gi@l(29)
	la 3,.LC22@l(3)
	lwz 9,4(29)
	mr 4,22
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,148(29)
	lis 3,.LC16@ha
	lis 4,.LC2@ha
	la 3,.LC16@l(3)
	la 4,.LC2@l(4)
	mtlr 9
	blrl
	lwz 0,4(29)
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L30
.L60:
	lis 29,gi@ha
	lis 3,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(3)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC23@ha
	mr 4,25
	la 3,.LC23@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	addi 0,25,-1
	lis 9,iCurrLevel@ha
	stw 0,iCurrLevel@l(9)
	lis 11,iLevelsDone@ha
	lis 10,iTotalLevels@ha
	li 9,256
	la 11,iLevelsDone@l(11)
	stw 0,iTotalLevels@l(10)
	mtctr 9
	li 8,0
	addi 11,11,1020
.L69:
	stw 8,0(11)
	addi 11,11,-4
	bdnz .L69
	b .L30
.L31:
	lwz 9,4(28)
	lis 3,.LC24@ha
	mr 4,30
	la 3,.LC24@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,148(28)
	lis 3,.LC16@ha
	lis 4,.LC2@ha
	la 3,.LC16@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L30:
	lwz 0,228(1)
	mtlr 0
	lmw 21,180(1)
	la 1,224(1)
	blr
.Lfe2:
	.size	 K2_ReadDMLevelCycleFile,.Lfe2-K2_ReadDMLevelCycleFile
	.section	".rodata"
	.align 2
.LC25:
	.string	"CTF Level cycling is ON\n"
	.align 2
.LC26:
	.string	"[ctfbegin]"
	.align 2
.LC27:
	.string	"ERROR - No maps listed in CTF Section in \"%s\".\n"
	.align 2
.LC28:
	.string	"[ctfend]"
	.align 2
.LC29:
	.string	"No CTF maps listed in %s\n"
	.section	".text"
	.align 2
	.globl K2_ReadCTFLevelCycleFile
	.type	 K2_ReadCTFLevelCycleFile,@function
K2_ReadCTFLevelCycleFile:
	stwu 1,-224(1)
	mflr 0
	stmw 21,180(1)
	stw 0,228(1)
	lis 9,.LC5@ha
	addi 30,1,88
	lbz 29,.LC5@l(9)
	addi 3,1,9
	li 4,0
	li 5,79
	li 25,0
	stb 29,8(1)
	mr 22,30
	crxor 6,6,6
	bl memset
	addi 3,1,89
	stb 29,88(1)
	li 4,0
	li 5,49
	crxor 6,6,6
	bl memset
	lis 9,gi@ha
	lis 3,.LC6@ha
	la 28,gi@l(9)
	lis 4,.LC7@ha
	lwz 9,144(28)
	la 4,.LC7@l(4)
	li 5,4
	la 3,.LC6@l(3)
	mtlr 9
	blrl
	lwz 9,4(28)
	mr 29,3
	lis 3,.LC25@ha
	mtlr 9
	la 3,.LC25@l(3)
	crxor 6,6,6
	blrl
	lwz 5,4(29)
	lis 4,.LC9@ha
	mr 3,30
	la 4,.LC9@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC10@ha
	mr 3,30
	la 4,.LC10@l(4)
	bl fopen
	mr. 31,3
	bc 12,2,.L72
	lis 29,.LC11@ha
	lis 23,.LC11@ha
	lis 30,.LC26@ha
.L76:
	mr 3,31
	la 4,.LC11@l(29)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L108
	addi 3,1,8
	la 4,.LC26@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L76
	lhz 0,12(31)
	andi. 9,0,32
	bc 12,2,.L78
.L108:
	lis 29,gi@ha
	lis 28,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(28)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC27@ha
	mr 4,22
	la 3,.LC27@l(3)
	b .L111
.L78:
	addi 4,1,152
	mr 3,31
	mr 29,4
	lis 30,.LC28@ha
	bl fgetpos
.L82:
	mr 3,31
	la 4,.LC11@l(23)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L109
	addi 3,1,8
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L80
	addi 3,1,8
	la 4,.LC28@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L82
.L80:
	lhz 0,12(31)
	andi. 9,0,32
	bc 12,2,.L84
.L109:
	lis 29,gi@ha
	lis 28,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(28)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC18@ha
	mr 4,22
	la 3,.LC18@l(3)
.L111:
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,152(29)
	lis 3,.LC16@ha
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	la 3,.LC16@l(3)
	mtlr 9
	blrl
	lwz 0,4(29)
	la 3,.LC13@l(28)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl fclose
	b .L71
.L84:
	mr 4,29
	mr 3,31
	bl fsetpos
	lis 9,gi@ha
	lis 3,.LC13@ha
	la 9,gi@l(9)
	la 3,.LC13@l(3)
	lwz 0,4(9)
	mr 24,9
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,CTFLevels@ha
	slwi 11,25,4
	la 9,CTFLevels@l(9)
	mr 30,11
	addi 21,9,-1
	addi 26,11,1
	b .L86
.L88:
	la 4,.LC11@l(23)
	addi 5,1,8
	mr 3,31
	crxor 6,6,6
	bl fscanf
	addi 3,1,8
	li 4,35
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L86
	addi 3,1,8
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 12,2,.L86
	la 4,.LC28@l(29)
	addi 3,1,8
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L87
	addi 3,1,8
	mr 27,30
	bl strlen
	li 11,1
	lis 8,CTFLevels@ha
	cmpw 0,11,3
	bc 4,0,.L94
	add 9,30,21
	addi 10,1,8
	addi 9,9,1
.L96:
	lbzx 0,10,11
	addi 11,11,1
	cmpw 0,11,3
	stb 0,0(9)
	addi 9,9,1
	bc 12,0,.L96
.L94:
	la 28,CTFLevels@l(8)
	add 9,11,26
	li 0,0
	add 29,30,28
	stbx 0,28,9
	mr 3,29
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L99
	mr 3,29
	bl strlen
	cmplwi 0,3,1
	bc 12,1,.L98
.L99:
	lwz 9,4(24)
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,.LC20@ha
	lbz 0,.LC20@l(9)
	stbx 0,27,28
	b .L86
.L98:
	lwz 9,4(24)
	lis 3,.LC21@ha
	mr 4,29
	la 3,.LC21@l(3)
	addi 26,26,16
	mtlr 9
	addi 30,30,16
	addi 25,25,1
	crxor 6,6,6
	blrl
.L86:
	lhz 0,12(31)
	cmpwi 7,25,255
	xori 0,0,32
	rlwinm 0,0,27,31,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 12,2,.L87
	lis 29,.LC28@ha
	addi 3,1,8
	la 4,.LC28@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L88
.L87:
	mr 3,31
	bl fclose
	cmpwi 0,25,0
	bc 4,2,.L101
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	lwz 9,4(29)
	mr 4,22
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,148(29)
	lis 3,.LC16@ha
	lis 4,.LC2@ha
	la 3,.LC16@l(3)
	la 4,.LC2@l(4)
	mtlr 9
	blrl
	lwz 0,4(29)
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L71
.L101:
	lis 29,gi@ha
	lis 3,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(3)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC23@ha
	mr 4,25
	la 3,.LC23@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	addi 0,25,-1
	lis 9,iCurrCTFLevel@ha
	stw 0,iCurrCTFLevel@l(9)
	lis 11,iCTFLevelsDone@ha
	lis 10,iTotalCTFLevels@ha
	li 9,256
	la 11,iCTFLevelsDone@l(11)
	stw 0,iTotalCTFLevels@l(10)
	mtctr 9
	li 8,0
	addi 11,11,1020
.L110:
	stw 8,0(11)
	addi 11,11,-4
	bdnz .L110
	b .L71
.L72:
	lwz 9,4(28)
	lis 3,.LC24@ha
	mr 4,30
	la 3,.LC24@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,148(28)
	lis 3,.LC16@ha
	lis 4,.LC2@ha
	la 3,.LC16@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L71:
	lwz 0,228(1)
	mtlr 0
	lmw 21,180(1)
	la 1,224(1)
	blr
.Lfe3:
	.size	 K2_ReadCTFLevelCycleFile,.Lfe3-K2_ReadCTFLevelCycleFile
	.section	".rodata"
	.align 2
.LC30:
	.string	"No [dmbegin] section, level settings not changed!\n"
	.align 2
.LC31:
	.string	"Couldn't close %s\n"
	.align 2
.LC32:
	.string	"Closed %s\n"
	.align 2
.LC33:
	.string	"Level not listed.  Level settings not changed.\n"
	.align 2
.LC34:
	.string	"===========================\n"
	.align 2
.LC35:
	.string	"Changes for the next level:\n"
	.align 2
.LC36:
	.string	"%s set to %s"
	.align 2
.LC37:
	.string	""
	.section	".text"
	.align 2
	.globl K2_GetDMLevelSettings
	.type	 K2_GetDMLevelSettings,@function
K2_GetDMLevelSettings:
	stwu 1,-256(1)
	mflr 0
	stmw 21,212(1)
	stw 0,260(1)
	lis 9,.LC5@ha
	mr 26,3
	lbz 29,.LC5@l(9)
	addi 28,1,88
	addi 3,1,9
	li 4,0
	li 5,79
	stb 29,8(1)
	mr 30,28
	lis 21,gi@ha
	crxor 6,6,6
	bl memset
	addi 3,1,89
	stb 29,88(1)
	li 4,0
	li 5,29
	crxor 6,6,6
	bl memset
	lis 9,gi+144@ha
	lis 3,.LC6@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC7@ha
	li 5,4
	la 4,.LC7@l(4)
	la 3,.LC6@l(3)
	mtlr 0
	blrl
	mr 27,3
	stb 29,120(1)
	li 4,0
	addi 3,1,121
	li 5,49
	crxor 6,6,6
	bl memset
	addi 3,1,185
	stb 29,184(1)
	li 4,0
	li 5,9
	crxor 6,6,6
	bl memset
	lwz 5,4(27)
	lis 4,.LC9@ha
	mr 3,28
	la 4,.LC9@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC10@ha
	mr 3,28
	la 4,.LC10@l(4)
	bl fopen
	mr. 27,3
	mr 3,26
	bc 12,2,.L148
	lis 31,.LC12@ha
.L117:
	addi 3,1,8
	li 4,80
	mr 5,27
	bl fgets
	lhz 0,12(27)
	andi. 9,0,32
	bc 4,2,.L149
	addi 3,1,8
	la 4,.LC12@l(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L117
	lhz 0,12(27)
	andi. 9,0,32
	bc 12,2,.L119
.L149:
	mr 3,27
	bl fclose
	lis 9,gi+4@ha
	lis 3,.LC30@ha
	lwz 0,gi+4@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L151
.L119:
	lis 31,.LC17@ha
.L123:
	addi 3,1,8
	li 4,80
	mr 5,27
	bl fgets
	lhz 0,12(27)
	andi. 9,0,32
	bc 4,2,.L150
	addi 3,1,8
	mr 4,26
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L121
	addi 3,1,8
	la 4,.LC17@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L123
.L121:
	lhz 0,12(27)
	andi. 9,0,32
	bc 12,2,.L125
.L150:
	mr 3,27
	bl fclose
	cmpwi 0,3,0
	bc 12,2,.L126
	lis 9,gi+4@ha
	lis 3,.LC31@ha
	lwz 0,gi+4@l(9)
	la 3,.LC31@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
	b .L127
.L126:
	lis 9,gi+4@ha
	lis 3,.LC32@ha
	lwz 0,gi+4@l(9)
	la 3,.LC32@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
.L127:
	lis 9,gi+4@ha
	lis 3,.LC33@ha
	lwz 0,gi+4@l(9)
	la 3,.LC33@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L151
.L125:
	li 4,80
	mr 5,27
	addi 3,1,8
	bl fgets
	addi 3,1,8
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L152
	addi 3,1,8
	li 4,91
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L152
	lis 29,gi@ha
	lis 3,.LC34@ha
	la 29,gi@l(29)
	la 3,.LC34@l(3)
	lwz 9,4(29)
	lis 22,.LC34@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC35@ha
	la 3,.LC35@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lhz 0,12(27)
	andi. 9,0,32
	bc 4,2,.L131
	addi 23,1,8
	li 24,0
	lis 25,.LC37@ha
.L132:
	addi 3,1,8
	addi 29,1,120
	bl strlen
	lis 30,.LC36@ha
	li 9,4
	addi 28,1,184
	cmpw 0,9,3
	li 10,0
	bc 4,0,.L134
	lbz 0,4(23)
	cmpwi 0,0,32
	bc 12,2,.L134
	mr 8,29
	mr 11,23
.L137:
	lbzx 0,11,9
	addi 9,9,1
	cmpw 0,9,3
	stbx 0,8,10
	addi 10,10,1
	bc 4,0,.L134
	lbzx 0,11,9
	cmpwi 0,0,32
	bc 4,2,.L137
.L134:
	addi 9,9,1
	stbx 24,29,10
	cmpw 0,9,3
	li 10,0
	bc 4,0,.L140
	addi 8,1,8
	mr 11,28
.L142:
	lbzx 0,8,9
	cmpwi 0,0,34
	bc 12,2,.L141
	stbx 0,11,10
	addi 10,10,1
.L141:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L142
.L140:
	stbx 24,28,10
	la 31,gi@l(21)
	mr 4,28
	lwz 9,148(31)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,4(31)
	mr 5,28
	la 3,.LC36@l(30)
	mr 4,29
	mtlr 9
	crxor 6,6,6
	blrl
	la 4,.LC37@l(25)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	la 4,.LC37@l(25)
	mr 3,28
	crxor 6,6,6
	bl sprintf
	li 4,80
	mr 5,27
	addi 3,1,8
	bl fgets
	addi 3,1,8
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L146
	addi 3,1,8
	li 4,91
	bl strchr
	cmpwi 0,3,0
	bc 12,2,.L130
.L146:
	mr 3,27
	bl fclose
	lwz 0,4(31)
	la 3,.LC34@l(22)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L151
.L130:
	lhz 0,12(27)
	andi. 9,0,32
	bc 12,2,.L132
.L131:
	lis 9,gi+4@ha
	lis 3,.LC34@ha
	lwz 0,gi+4@l(9)
	la 3,.LC34@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L152:
	mr 3,27
	bl fclose
.L151:
	mr 3,26
.L148:
	lwz 0,260(1)
	mtlr 0
	lmw 21,212(1)
	la 1,256(1)
	blr
.Lfe4:
	.size	 K2_GetDMLevelSettings,.Lfe4-K2_GetDMLevelSettings
	.section	".rodata"
	.align 2
.LC38:
	.string	"No CTFBEGIN section, level settings not changed!\n"
	.section	".text"
	.align 2
	.globl K2_GetCTFLevelSettings
	.type	 K2_GetCTFLevelSettings,@function
K2_GetCTFLevelSettings:
	stwu 1,-256(1)
	mflr 0
	stmw 21,212(1)
	stw 0,260(1)
	lis 9,.LC5@ha
	mr 26,3
	lbz 29,.LC5@l(9)
	addi 28,1,88
	addi 3,1,9
	li 4,0
	li 5,79
	stb 29,8(1)
	mr 30,28
	lis 21,gi@ha
	crxor 6,6,6
	bl memset
	addi 3,1,89
	stb 29,88(1)
	li 4,0
	li 5,29
	crxor 6,6,6
	bl memset
	lis 9,gi+144@ha
	lis 3,.LC6@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC7@ha
	li 5,4
	la 4,.LC7@l(4)
	la 3,.LC6@l(3)
	mtlr 0
	blrl
	mr 27,3
	stb 29,120(1)
	li 4,0
	addi 3,1,121
	li 5,49
	crxor 6,6,6
	bl memset
	addi 3,1,185
	stb 29,184(1)
	li 4,0
	li 5,9
	crxor 6,6,6
	bl memset
	lwz 5,4(27)
	lis 4,.LC9@ha
	mr 3,28
	la 4,.LC9@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC10@ha
	mr 3,28
	la 4,.LC10@l(4)
	bl fopen
	mr. 27,3
	mr 3,26
	bc 12,2,.L189
	lis 31,.LC26@ha
.L158:
	addi 3,1,8
	li 4,80
	mr 5,27
	bl fgets
	lhz 0,12(27)
	andi. 9,0,32
	bc 4,2,.L190
	addi 3,1,8
	la 4,.LC26@l(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L158
	lhz 0,12(27)
	andi. 9,0,32
	bc 12,2,.L160
.L190:
	mr 3,27
	bl fclose
	lis 9,gi+4@ha
	lis 3,.LC38@ha
	lwz 0,gi+4@l(9)
	la 3,.LC38@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L192
.L160:
	lis 31,.LC28@ha
.L164:
	addi 3,1,8
	li 4,80
	mr 5,27
	bl fgets
	lhz 0,12(27)
	andi. 9,0,32
	bc 4,2,.L191
	addi 3,1,8
	mr 4,26
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L162
	addi 3,1,8
	la 4,.LC28@l(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L164
.L162:
	lhz 0,12(27)
	andi. 9,0,32
	bc 12,2,.L166
.L191:
	mr 3,27
	bl fclose
	cmpwi 0,3,0
	bc 12,2,.L167
	lis 9,gi+4@ha
	lis 3,.LC31@ha
	lwz 0,gi+4@l(9)
	la 3,.LC31@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
	b .L168
.L167:
	lis 9,gi+4@ha
	lis 3,.LC32@ha
	lwz 0,gi+4@l(9)
	la 3,.LC32@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
.L168:
	lis 9,gi+4@ha
	lis 3,.LC33@ha
	lwz 0,gi+4@l(9)
	la 3,.LC33@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L192
.L166:
	li 4,80
	mr 5,27
	addi 3,1,8
	bl fgets
	addi 3,1,8
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L193
	addi 3,1,8
	li 4,91
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L193
	lis 29,gi@ha
	lis 3,.LC34@ha
	la 29,gi@l(29)
	la 3,.LC34@l(3)
	lwz 9,4(29)
	lis 22,.LC34@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC35@ha
	la 3,.LC35@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lhz 0,12(27)
	andi. 9,0,32
	bc 4,2,.L172
	addi 23,1,8
	li 24,0
	lis 25,.LC37@ha
.L173:
	addi 3,1,8
	addi 29,1,120
	bl strlen
	lis 30,.LC36@ha
	li 9,4
	addi 28,1,184
	cmpw 0,9,3
	li 10,0
	bc 4,0,.L175
	lbz 0,4(23)
	cmpwi 0,0,32
	bc 12,2,.L175
	mr 8,29
	mr 11,23
.L178:
	lbzx 0,11,9
	addi 9,9,1
	cmpw 0,9,3
	stbx 0,8,10
	addi 10,10,1
	bc 4,0,.L175
	lbzx 0,11,9
	cmpwi 0,0,32
	bc 4,2,.L178
.L175:
	addi 9,9,1
	stbx 24,29,10
	cmpw 0,9,3
	li 10,0
	bc 4,0,.L181
	addi 8,1,8
	mr 11,28
.L183:
	lbzx 0,8,9
	cmpwi 0,0,34
	bc 12,2,.L182
	stbx 0,11,10
	addi 10,10,1
.L182:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L183
.L181:
	stbx 24,28,10
	la 31,gi@l(21)
	mr 4,28
	lwz 9,148(31)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,4(31)
	mr 5,28
	la 3,.LC36@l(30)
	mr 4,29
	mtlr 9
	crxor 6,6,6
	blrl
	la 4,.LC37@l(25)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	la 4,.LC37@l(25)
	mr 3,28
	crxor 6,6,6
	bl sprintf
	li 4,80
	mr 5,27
	addi 3,1,8
	bl fgets
	addi 3,1,8
	li 4,58
	bl strchr
	cmpwi 0,3,0
	bc 4,2,.L187
	addi 3,1,8
	li 4,91
	bl strchr
	cmpwi 0,3,0
	bc 12,2,.L171
.L187:
	mr 3,27
	bl fclose
	lwz 0,4(31)
	la 3,.LC34@l(22)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L192
.L171:
	lhz 0,12(27)
	andi. 9,0,32
	bc 12,2,.L173
.L172:
	lis 9,gi+4@ha
	lis 3,.LC34@ha
	lwz 0,gi+4@l(9)
	la 3,.LC34@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L193:
	mr 3,27
	bl fclose
.L192:
	mr 3,26
.L189:
	lwz 0,260(1)
	mtlr 0
	lmw 21,212(1)
	la 1,256(1)
	blr
.Lfe5:
	.size	 K2_GetCTFLevelSettings,.Lfe5-K2_GetCTFLevelSettings
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.comm	Levels,4096,1
	.comm	CTFLevels,4096,1
	.comm	iCurrLevel,4,4
	.comm	iCurrCTFLevel,4,4
	.comm	iTotalLevels,4,4
	.comm	iTotalCTFLevels,4,4
	.comm	iLevelsDone,1024,4
	.comm	iCTFLevelsDone,1024,4
	.align 2
	.globl GetNextLevel
	.type	 GetNextLevel,@function
GetNextLevel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,iCurrLevel@ha
	lis 11,iTotalLevels@ha
	lwz 9,iCurrLevel@l(9)
	lis 10,iCurrLevel@ha
	lwz 0,iTotalLevels@l(11)
	cmpw 0,9,0
	li 0,0
	bc 12,2,.L194
	addi 0,9,1
.L194:
	stw 0,iCurrLevel@l(10)
	lis 11,iCurrLevel@ha
	lis 9,Levels@ha
	lwz 3,iCurrLevel@l(11)
	la 9,Levels@l(9)
	slwi 3,3,4
	add 3,3,9
	bl K2_GetDMLevelSettings
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 GetNextLevel,.Lfe6-GetNextLevel
	.align 2
	.globl GetNextCTFLevel
	.type	 GetNextCTFLevel,@function
GetNextCTFLevel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,iCurrCTFLevel@ha
	lis 11,iTotalCTFLevels@ha
	lwz 9,iCurrCTFLevel@l(9)
	lis 10,iCurrCTFLevel@ha
	lwz 0,iTotalCTFLevels@l(11)
	cmpw 0,9,0
	li 0,0
	bc 12,2,.L195
	addi 0,9,1
.L195:
	stw 0,iCurrCTFLevel@l(10)
	lis 11,iCurrCTFLevel@ha
	lis 9,CTFLevels@ha
	lwz 3,iCurrCTFLevel@l(11)
	la 9,CTFLevels@l(9)
	slwi 3,3,4
	add 3,3,9
	bl K2_GetCTFLevelSettings
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 GetNextCTFLevel,.Lfe7-GetNextCTFLevel
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
