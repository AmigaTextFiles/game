	.file	"gslog.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 fWasAlreadyOpen,@object
	.size	 fWasAlreadyOpen,4
fWasAlreadyOpen:
	.long 0
	.align 2
	.type	 pPatch,@object
	.size	 pPatch,4
pPatch:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"dmflags"
	.align 2
.LC1:
	.string	"0"
	.align 2
.LC2:
	.string	"Suicide"
	.align 2
.LC3:
	.string	"Fell"
	.align 2
.LC4:
	.string	"Crushed"
	.align 2
.LC5:
	.string	"Drowned"
	.align 2
.LC6:
	.string	"Melted"
	.align 2
.LC7:
	.string	"Lava"
	.align 2
.LC8:
	.string	"Explosion"
	.align 2
.LC9:
	.string	"Lasered"
	.align 2
.LC10:
	.string	"Pecked"
	.align 2
.LC11:
	.string	"Blasted"
	.align 2
.LC12:
	.string	"Kill"
	.align 2
.LC13:
	.string	"Telefrag"
	.align 2
.LC14:
	.string	""
	.align 2
.LC15:
	.string	"ERROR"
	.align 2
.LC16:
	.long 0x0
	.align 3
.LC17:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_WriteStdLogDeath
	.type	 sl_WriteStdLogDeath,@function
sl_WriteStdLogDeath:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 11,.LC16@ha
	lis 9,deathmatch@ha
	la 11,.LC16@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 24,4
	mr 28,5
	lwz 11,deathmatch@l(9)
	mr 25,7
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L23
	lis 27,pPatch@ha
	lwz 30,pPatch@l(27)
	bl sl_OpenLogFile
	mr. 26,3
	bc 12,2,.L23
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L25
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	mr 4,30
	mr 3,31
	stw 30,pPatch@l(27)
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L26
	fctiwz 0,13
	stfd 0,8(1)
	lwz 4,12(1)
	b .L27
.L26:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 4,12(1)
	xoris 4,4,0x8000
.L27:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 26,fWasAlreadyOpen@l(9)
.L25:
	cmpwi 0,26,0
	bc 12,2,.L23
	lis 9,meansOfDeath@ha
	cmpw 0,25,28
	lwz 0,meansOfDeath@l(9)
	li 4,0
	li 5,0
	li 6,0
	li 29,0
	rlwinm 30,0,0,5,3
	li 8,0
	bc 4,2,.L29
	lwz 11,84(28)
	lis 9,.LC2@ha
	li 8,-1
	la 6,.LC2@l(9)
	lwz 9,1788(11)
	addi 4,11,700
	cmpwi 0,9,0
	bc 12,2,.L32
	lwz 29,40(9)
	b .L32
.L29:
	addi 10,30,-17
	li 3,0
	cmplwi 0,10,17
	bc 12,1,.L33
	lis 11,.L49@ha
	slwi 10,10,2
	la 11,.L49@l(11)
	lis 9,.L49@ha
	lwzx 0,10,11
	la 9,.L49@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L49:
	.long .L36-.L49
	.long .L37-.L49
	.long .L38-.L49
	.long .L35-.L49
	.long .L33-.L49
	.long .L34-.L49
	.long .L48-.L49
	.long .L33-.L49
	.long .L41-.L49
	.long .L41-.L49
	.long .L41-.L49
	.long .L48-.L49
	.long .L48-.L49
	.long .L42-.L49
	.long .L48-.L49
	.long .L33-.L49
	.long .L44-.L49
	.long .L43-.L49
.L34:
	lis 9,.LC3@ha
	li 3,1
	la 29,.LC3@l(9)
	b .L33
.L35:
	lis 9,.LC4@ha
	li 3,1
	la 29,.LC4@l(9)
	b .L33
.L36:
	lis 9,.LC5@ha
	li 3,1
	la 29,.LC5@l(9)
	b .L33
.L37:
	lis 9,.LC6@ha
	li 3,1
	la 29,.LC6@l(9)
	b .L33
.L38:
	lis 9,.LC7@ha
	li 3,1
	la 29,.LC7@l(9)
	b .L33
.L41:
	lis 9,.LC8@ha
	li 3,1
	la 29,.LC8@l(9)
	b .L33
.L42:
	lis 9,.LC9@ha
	li 3,1
	la 29,.LC9@l(9)
	b .L33
.L43:
	lis 9,.LC10@ha
	li 3,1
	la 29,.LC10@l(9)
	b .L33
.L44:
	lis 9,.LC11@ha
	li 3,1
	la 29,.LC11@l(9)
	b .L33
.L48:
	li 3,1
.L33:
	cmpwi 0,3,0
	bc 12,2,.L32
	lwz 11,84(28)
	lis 9,.LC2@ha
	li 8,-1
	la 6,.LC2@l(9)
	addi 4,11,700
.L32:
	subfic 0,4,0
	adde 9,0,4
	subfic 11,6,0
	adde 0,11,6
	or. 11,9,0
	bc 12,2,.L52
	cmpwi 0,25,0
	bc 12,2,.L52
	lwz 7,84(25)
	cmpwi 0,7,0
	bc 12,2,.L52
	cmpwi 0,30,21
	bc 12,2,.L75
	lwz 10,1788(7)
	lis 9,.LC12@ha
	addi 4,7,700
	lwz 11,84(28)
	la 6,.LC12@l(9)
	li 8,1
	cmpwi 0,10,0
	li 29,0
	addi 5,11,700
	bc 12,2,.L52
	lwz 29,40(10)
	b .L52
.L75:
	lwz 9,84(28)
	lis 11,.LC12@ha
	lis 10,.LC13@ha
	addi 4,7,700
	la 6,.LC12@l(11)
	addi 5,9,700
	la 29,.LC13@l(10)
	li 8,1
.L52:
	lfs 1,4(24)
	mr 3,31
	mr 7,29
	bl sl_LogScore
	b .L22
.L23:
	lis 4,.LC14@ha
	lfs 1,4(24)
	lis 6,.LC15@ha
	la 4,.LC14@l(4)
	mr 3,31
	mr 5,4
	la 6,.LC15@l(6)
	mr 7,5
	li 8,0
	bl sl_LogScore
.L22:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 sl_WriteStdLogDeath,.Lfe1-sl_WriteStdLogDeath
	.section	".rodata"
	.align 3
.LC18:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_Logging
	.type	 sl_Logging,@function
sl_Logging:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	bl sl_OpenLogFile
	mr. 28,3
	bc 12,2,.L7
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L7
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	lis 9,pPatch@ha
	mr 4,30
	stw 30,pPatch@l(9)
	mr 3,31
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L8
	fctiwz 0,13
	stfd 0,8(1)
	lwz 4,12(1)
	b .L9
.L8:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 4,12(1)
	xoris 4,4,0x8000
.L9:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 28,fWasAlreadyOpen@l(9)
.L7:
	mr 3,28
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 sl_Logging,.Lfe2-sl_Logging
	.section	".rodata"
	.align 3
.LC19:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_GameStart
	.type	 sl_GameStart,@function
sl_GameStart:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	mr 27,5
	bl sl_OpenLogFile
	mr. 28,3
	bc 12,2,.L11
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L12
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	lis 9,pPatch@ha
	mr 4,30
	stw 30,pPatch@l(9)
	mr 3,31
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L13
	fctiwz 0,13
	stfd 0,16(1)
	lwz 4,20(1)
	b .L14
.L13:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 4,20(1)
	xoris 4,4,0x8000
.L14:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 28,fWasAlreadyOpen@l(9)
.L12:
	cmpwi 0,28,0
	bc 12,2,.L11
	mr 3,31
	addi 4,27,8
	bl sl_LogMapName
	lfs 1,4(27)
	mr 3,31
	bl sl_LogGameStart
.L11:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 sl_GameStart,.Lfe3-sl_GameStart
	.section	".rodata"
	.align 3
.LC20:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_GameEnd
	.type	 sl_GameEnd,@function
sl_GameEnd:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 31,3
	lis 28,pPatch@ha
	lwz 30,pPatch@l(28)
	mr 26,4
	bl sl_OpenLogFile
	mr. 27,3
	bc 12,2,.L17
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L18
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	mr 4,30
	mr 3,31
	stw 30,pPatch@l(28)
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L19
	fctiwz 0,13
	stfd 0,16(1)
	lwz 4,20(1)
	b .L20
.L19:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 4,20(1)
	xoris 4,4,0x8000
.L20:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 27,fWasAlreadyOpen@l(9)
.L18:
	cmpwi 0,27,0
	bc 12,2,.L17
	lfs 1,4(26)
	mr 3,31
	bl sl_LogGameEnd
	bl sl_CloseLogFile
	lis 9,fWasAlreadyOpen@ha
	li 0,0
	stw 0,fWasAlreadyOpen@l(9)
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 sl_GameEnd,.Lfe4-sl_GameEnd
	.section	".rodata"
	.align 3
.LC21:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_WriteStdLogPlayerEntered
	.type	 sl_WriteStdLogPlayerEntered,@function
sl_WriteStdLogPlayerEntered:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 31,3
	lis 28,pPatch@ha
	lwz 30,pPatch@l(28)
	mr 25,4
	mr 26,5
	bl sl_OpenLogFile
	mr. 27,3
	bc 12,2,.L79
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L80
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	mr 4,30
	mr 3,31
	stw 30,pPatch@l(28)
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L81
	fctiwz 0,13
	stfd 0,24(1)
	lwz 4,28(1)
	b .L82
.L81:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 4,28(1)
	xoris 4,4,0x8000
.L82:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 27,fWasAlreadyOpen@l(9)
.L80:
	cmpwi 0,27,0
	bc 12,2,.L79
	lwz 4,84(26)
	mr 3,31
	li 5,0
	lfs 1,4(25)
	addi 4,4,700
	bl sl_LogPlayerConnect
.L79:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 sl_WriteStdLogPlayerEntered,.Lfe5-sl_WriteStdLogPlayerEntered
	.section	".rodata"
	.align 3
.LC22:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogPlayerDisconnect
	.type	 sl_LogPlayerDisconnect,@function
sl_LogPlayerDisconnect:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 31,3
	lis 28,pPatch@ha
	lwz 30,pPatch@l(28)
	mr 25,4
	mr 26,5
	bl sl_OpenLogFile
	mr. 27,3
	bc 12,2,.L85
	lis 9,fWasAlreadyOpen@ha
	lwz 0,fWasAlreadyOpen@l(9)
	cmpwi 0,0,0
	bc 4,2,.L86
	lwz 9,144(31)
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	li 5,4
	la 4,.LC1@l(4)
	mtlr 9
	la 3,.LC0@l(3)
	blrl
	mr 29,3
	mr 3,31
	bl sl_LogVers
	mr 4,30
	mr 3,31
	stw 30,pPatch@l(28)
	bl sl_LogPatch
	mr 3,31
	bl sl_LogDate
	mr 3,31
	bl sl_LogTime
	lfs 0,20(29)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L87
	fctiwz 0,13
	stfd 0,24(1)
	lwz 4,28(1)
	b .L88
.L87:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 4,28(1)
	xoris 4,4,0x8000
.L88:
	mr 3,31
	bl sl_LogDeathFlags
	lis 9,fWasAlreadyOpen@ha
	stw 27,fWasAlreadyOpen@l(9)
.L86:
	cmpwi 0,27,0
	bc 12,2,.L85
	lwz 4,84(26)
	mr 3,31
	lfs 1,4(25)
	addi 4,4,700
	bl sl_LogPlayerLeft
.L85:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 sl_LogPlayerDisconnect,.Lfe6-sl_LogPlayerDisconnect
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
