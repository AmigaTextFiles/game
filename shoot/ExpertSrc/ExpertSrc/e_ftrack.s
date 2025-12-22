	.file	"e_ftrack.c"
gcc2_compiled.:
	.globl flagtrack_statusbar
	.section	".rodata"
	.align 2
.LC0:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 en"
	.ascii	"dif"
	.string	" if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 \txv\t0 \tpic 7 \txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 endif if 9 xv 246 num 2 10 xv 296 pic 9 endif if 11 xv 148 pic 11 endif xr\t-50 yt 2 num 3 14 if 21 yb -137 xl 2 pic 21 endif if 27 yb -58 xv 120 stat_string 27 endif "
	.section	".sdata","aw"
	.align 2
	.type	 flagtrack_statusbar,@object
	.size	 flagtrack_statusbar,4
flagtrack_statusbar:
	.long .LC0
	.section	".rodata"
	.align 2
.LC1:
	.string	"players/male/flag1.md2"
	.align 2
.LC2:
	.string	"players/male/flag2.md2"
	.align 2
.LC3:
	.string	"item_flag"
	.align 2
.LC4:
	.string	"FlagTrack: flag startsolid at %s\n"
	.align 2
.LC5:
	.long 0xc1700000
	.align 2
.LC6:
	.long 0x41700000
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl spawnFlag
	.type	 spawnFlag,@function
spawnFlag:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	mr 30,3
	bl G_Spawn
	lis 9,.LC3@ha
	lis 11,.LC5@ha
	mr 31,3
	la 9,.LC3@l(9)
	la 11,.LC5@l(11)
	stw 9,280(31)
	lfs 1,0(11)
	lis 9,.LC5@ha
	lis 11,.LC5@ha
	la 9,.LC5@l(9)
	la 11,.LC5@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	bl tv
	lfs 13,0(3)
	lis 9,.LC6@ha
	lis 11,.LC6@ha
	la 9,.LC6@l(9)
	la 11,.LC6@l(11)
	lfs 1,0(9)
	stfs 13,188(31)
	lis 9,.LC6@ha
	lfs 0,4(3)
	la 9,.LC6@l(9)
	lfs 2,0(11)
	lfs 3,0(9)
	stfs 0,192(31)
	lfs 13,8(3)
	stfs 13,196(31)
	bl tv
	lfs 0,0(3)
	cmpwi 0,30,0
	stfs 0,200(31)
	lfs 13,4(3)
	stfs 13,204(31)
	lfs 0,8(3)
	stw 30,908(31)
	stfs 0,208(31)
	bc 4,2,.L24
	lis 9,.LC1@ha
	la 4,.LC1@l(9)
	b .L25
.L24:
	lis 9,.LC2@ha
	la 4,.LC2@l(9)
.L25:
	lis 29,gi@ha
	stw 4,268(31)
	mr 3,31
	la 29,gi@l(29)
	lwz 9,44(29)
	mtlr 9
	blrl
	lwz 0,32(29)
	lwz 3,268(31)
	mtlr 0
	blrl
	cmpwi 0,30,0
	lis 0,0x8
	bc 4,2,.L27
	lis 0,0x4
.L27:
	stw 0,64(31)
	li 0,0
	lis 9,.LC6@ha
	stw 0,248(31)
	lis 11,level+4@ha
	la 9,.LC6@l(9)
	lfs 0,level+4@l(11)
	mr 3,31
	addi 30,31,4
	lfs 13,0(9)
	lis 9,activateFlag@ha
	la 9,activateFlag@l(9)
	fadds 0,0,13
	stw 9,436(31)
	stfs 0,428(31)
	bl SelectFarthestDeathmatchSpawnPoint
	lfs 13,4(3)
	lis 9,.LC7@ha
	lis 11,.LC7@ha
	la 9,.LC7@l(9)
	la 11,.LC7@l(11)
	lfs 1,0(9)
	stfs 13,4(31)
	lis 9,.LC8@ha
	lfs 0,8(3)
	la 9,.LC8@l(9)
	lfs 2,0(11)
	lfs 3,0(9)
	stfs 0,8(31)
	lfs 13,12(3)
	stfs 13,12(31)
	bl tv
	mr 11,3
	lfs 13,4(31)
	lis 9,gi@ha
	lfs 0,0(11)
	la 29,gi@l(9)
	addi 3,1,8
	lwz 10,48(29)
	mr 4,30
	addi 5,31,188
	addi 6,31,200
	addi 7,1,72
	fadds 13,13,0
	mr 8,31
	li 9,3
	mtlr 10
	stfs 13,72(1)
	lfs 13,4(11)
	lfs 0,8(31)
	fadds 0,0,13
	stfs 0,76(1)
	lfs 13,8(11)
	lfs 0,12(31)
	fadds 0,0,13
	stfs 0,80(1)
	blrl
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 4,2,.L30
	lfs 13,20(1)
	lis 9,flags@ha
	mr 4,31
	lwz 3,flags@l(9)
	stfs 13,4(31)
	lfs 0,24(1)
	stfs 0,8(31)
	lfs 13,28(1)
	stfs 13,12(31)
	bl listAppend
	mr 3,31
	b .L31
.L30:
	mr 3,30
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	li 3,0
.L31:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 spawnFlag,.Lfe1-spawnFlag
	.section	".rodata"
	.align 2
.LC9:
	.long 0xc1700000
	.align 2
.LC10:
	.long 0x41700000
	.align 2
.LC11:
	.long 0x42c80000
	.align 2
.LC12:
	.long 0x42b40000
	.section	".text"
	.align 2
	.globl tossFlag
	.type	 tossFlag,@function
tossFlag:
	stwu 1,-144(1)
	mflr 0
	stmw 27,124(1)
	stw 0,148(1)
	mr 30,3
	lwz 9,84(30)
	lwz 28,4004(9)
	cmpwi 0,28,-1
	bc 4,2,.L34
	li 3,0
	b .L41
.L34:
	bl G_Spawn
	lis 9,.LC3@ha
	mr 31,3
	la 9,.LC3@l(9)
	lis 10,.LC9@ha
	stw 9,280(31)
	lis 11,.LC9@ha
	la 10,.LC9@l(10)
	lis 9,.LC9@ha
	la 11,.LC9@l(11)
	lfs 1,0(10)
	la 9,.LC9@l(9)
	lfs 2,0(11)
	lfs 3,0(9)
	bl tv
	lfs 13,0(3)
	lis 9,.LC10@ha
	lis 10,.LC10@ha
	lis 11,.LC10@ha
	la 9,.LC10@l(9)
	la 10,.LC10@l(10)
	la 11,.LC10@l(11)
	lfs 1,0(9)
	stfs 13,188(31)
	lfs 0,4(3)
	lfs 2,0(10)
	lfs 3,0(11)
	stfs 0,192(31)
	lfs 13,8(3)
	stfs 13,196(31)
	bl tv
	lfs 0,0(3)
	cmpwi 0,28,0
	stfs 0,200(31)
	lfs 13,4(3)
	stfs 13,204(31)
	lfs 0,8(3)
	stw 28,908(31)
	stfs 0,208(31)
	bc 4,2,.L35
	lis 9,.LC1@ha
	la 4,.LC1@l(9)
	b .L36
.L35:
	lis 9,.LC2@ha
	la 4,.LC2@l(9)
.L36:
	lis 29,gi@ha
	stw 4,268(31)
	mr 3,31
	la 29,gi@l(29)
	lwz 9,44(29)
	mtlr 9
	blrl
	lwz 0,32(29)
	lwz 3,268(31)
	mtlr 0
	blrl
	cmpwi 0,28,0
	lis 0,0x8
	bc 4,2,.L38
	lis 0,0x4
.L38:
	stw 0,64(31)
	lwz 3,84(30)
	addi 29,1,24
	addi 4,1,8
	mr 5,29
	li 6,0
	addi 3,3,3876
	addi 27,30,4
	bl AngleVectors
	addi 28,31,4
	lis 0,0x41c0
	li 9,0
	lis 11,0xc180
	stw 0,40(1)
	addi 4,1,40
	stw 9,44(1)
	addi 5,1,8
	mr 6,29
	stw 11,48(1)
	mr 3,27
	mr 7,28
	bl G_ProjectSource
	lis 29,gi@ha
	mr 8,30
	la 29,gi@l(29)
	li 9,1
	lwz 11,48(29)
	mr 7,28
	addi 3,1,56
	addi 5,31,188
	addi 6,31,200
	mtlr 11
	mr 4,27
	blrl
	lfs 13,68(1)
	lis 9,.LC11@ha
	addi 3,1,8
	la 9,.LC11@l(9)
	addi 4,31,376
	lfs 1,0(9)
	stfs 13,4(31)
	lfs 0,72(1)
	stfs 0,8(31)
	lfs 13,76(1)
	stfs 13,12(31)
	bl VectorScale
	lis 9,touchFlag@ha
	lwz 8,68(31)
	li 10,1
	la 9,touchFlag@l(9)
	stw 10,248(31)
	lis 7,respawnInactiveFlag@ha
	stw 9,444(31)
	la 7,respawnInactiveFlag@l(7)
	ori 8,8,8
	lis 0,0x4396
	li 9,7
	stw 8,68(31)
	lis 11,level@ha
	lis 10,.LC12@ha
	stw 0,384(31)
	stw 9,260(31)
	la 11,level@l(11)
	la 10,.LC12@l(10)
	stw 7,436(31)
	lis 9,flags@ha
	li 0,-1
	lfs 0,4(11)
	mr 4,31
	lfs 13,0(10)
	lwz 3,flags@l(9)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 9,84(30)
	stw 0,4004(9)
	stw 30,256(31)
	lfs 0,4(11)
	stfs 0,900(31)
	bl listAppend
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	mr 3,31
.L41:
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe2:
	.size	 tossFlag,.Lfe2-tossFlag
	.section	".rodata"
	.align 2
.LC13:
	.string	"You aren't carrying a flag\n"
	.align 2
.LC14:
	.string	"You can only toss an enemy flag\n"
	.align 2
.LC15:
	.string	"You picked up your team's flag!\n"
	.align 2
.LC16:
	.string	"You picked up an enemy flag!\n"
	.align 2
.LC17:
	.string	"ASSIST: %s [%s]\n"
	.align 2
.LC18:
	.string	"ctf/flagcap.wav"
	.align 2
.LC19:
	.string	"%s [%s] CAPTURED a %s flag\n"
	.align 2
.LC20:
	.string	"%s"
	.align 2
.LC21:
	.long 0x3f800000
	.align 2
.LC22:
	.long 0x0
	.section	".text"
	.align 2
	.globl captureFlag
	.type	 captureFlag,@function
captureFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 26,3
	la 29,gi@l(29)
	lis 3,.LC18@ha
	lwz 9,36(29)
	la 3,.LC18@l(3)
	mr 30,4
	mtlr 9
	blrl
	lis 9,.LC21@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC21@l(9)
	li 4,16
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 2,0(9)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(30)
	lwz 9,3432(11)
	addi 9,9,5
	stw 9,3432(11)
	lwz 9,912(26)
	cmpwi 0,9,0
	bc 12,2,.L56
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L56
	lwz 29,84(9)
	lwz 0,720(29)
	cmpwi 0,0,0
	bc 12,2,.L56
	cmpwi 0,29,0
	bc 12,2,.L56
	cmpw 0,9,30
	bc 12,2,.L56
	lwz 9,84(30)
	lwz 3,3476(29)
	lwz 0,3476(9)
	cmpw 0,3,0
	bc 4,2,.L56
	addi 29,29,700
	bl nameForTeam
	lis 9,gi@ha
	mr 6,3
	lwz 0,gi@l(9)
	lis 4,.LC17@ha
	mr 5,29
	la 4,.LC17@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,912(26)
	lwz 10,84(11)
	lwz 9,3432(10)
	addi 9,9,5
	stw 9,3432(10)
.L56:
	lwz 9,84(30)
	lwz 0,4004(9)
	lwz 11,3476(9)
	mr 31,0
	cmpw 0,11,0
	bc 4,2,.L58
	lwz 31,908(26)
.L58:
	mr 3,31
	lis 27,gi@ha
	bl spawnFlag
	lwz 3,84(30)
	addi 3,3,700
	bl greenText
	mr 4,3
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	crxor 6,6,6
	bl va
	lwz 9,84(30)
	mr 28,3
	lwz 3,3476(9)
	bl nameForTeam
	mr 29,3
	mr 3,31
	bl nameForTeam
	lwz 0,gi@l(27)
	mr 7,3
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	mr 5,28
	mtlr 0
	mr 6,29
	li 3,2
	crxor 6,6,6
	blrl
	mr 3,26
	bl G_FreeEdict
	lwz 9,84(30)
	lwz 0,3476(9)
	stw 0,4004(9)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 captureFlag,.Lfe3-captureFlag
	.section	".rodata"
	.align 2
.LC23:
	.string	"Expert CTF scoring passed NULL attacker or targ\n"
	.align 2
.LC24:
	.string	"BONUS %s: CARRIER KILL: %d points\n"
	.comm	gametype,4,4
	.comm	flags,4,4
	.section	".text"
	.align 2
	.globl Cmd_Drop_Flag
	.type	 Cmd_Drop_Flag,@function
Cmd_Drop_Flag:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4004(9)
	cmpwi 0,0,-1
	bc 4,2,.L46
	lis 9,gi+8@ha
	lis 5,.LC13@ha
	lwz 0,gi+8@l(9)
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L46:
	lwz 9,84(31)
	lwz 11,3476(9)
	lwz 0,4004(9)
	cmpw 0,0,11
	bc 12,2,.L47
	mr 3,31
	bl tossFlag
	lwz 9,84(31)
	li 0,-1
	stw 0,4004(9)
	stw 31,912(3)
	b .L48
.L47:
	lis 9,gi+8@ha
	lis 5,.LC14@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC14@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L48:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_Drop_Flag,.Lfe4-Cmd_Drop_Flag
	.align 2
	.globl FlagTrackDeadDropFlag
	.type	 FlagTrackDeadDropFlag,@function
FlagTrackDeadDropFlag:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	bl tossFlag
	lwz 9,84(31)
	mr. 3,3
	li 0,-1
	stw 0,4004(9)
	bc 12,2,.L44
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L44
	lwz 9,84(31)
	lwz 11,3476(11)
	lwz 0,3476(9)
	cmpw 0,11,0
	bc 12,2,.L44
	stw 30,912(3)
.L44:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 FlagTrackDeadDropFlag,.Lfe5-FlagTrackDeadDropFlag
	.align 2
	.globl FlagTrackScoring
	.type	 FlagTrackScoring,@function
FlagTrackScoring:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,5
	subfic 0,31,0
	adde 9,0,31
	subfic 11,30,0
	adde 0,11,30
	or. 11,9,0
	bc 12,2,.L69
	lis 9,gi+4@ha
	lis 3,.LC23@ha
	lwz 0,gi+4@l(9)
	la 3,.LC23@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L68
.L69:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L68
	lwz 0,84(30)
	xor 9,31,30
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L68
	mr 3,30
	mr 4,31
	bl onSameTeam
	cmpwi 0,3,0
	bc 4,2,.L68
	lwz 9,84(31)
	lwz 0,4004(9)
	cmpwi 0,0,-1
	bc 12,2,.L68
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC24@ha
	lwz 0,gi@l(9)
	la 4,.LC24@l(4)
	li 3,1
	addi 5,5,700
	li 6,3
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(30)
	lwz 9,3432(11)
	addi 9,9,2
	stw 9,3432(11)
.L68:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 FlagTrackScoring,.Lfe6-FlagTrackScoring
	.align 2
	.globl FlagTrackEffects
	.type	 FlagTrackEffects,@function
FlagTrackEffects:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,480(31)
	lwz 9,64(31)
	cmpwi 0,0,0
	rlwinm 0,9,0,14,11
	stw 0,64(31)
	bc 4,1,.L10
	lwz 9,84(31)
	lwz 9,4004(9)
	cmpwi 0,9,0
	bc 4,2,.L11
	oris 0,0,0x4
	lis 9,gi+32@ha
	stw 0,64(31)
	lis 3,.LC1@ha
	lwz 0,gi+32@l(9)
	la 3,.LC1@l(3)
	b .L79
.L11:
	cmpwi 0,9,1
	bc 4,2,.L13
	oris 0,0,0x8
	lis 9,gi+32@ha
	stw 0,64(31)
	lis 3,.LC2@ha
	lwz 0,gi+32@l(9)
	la 3,.LC2@l(3)
.L79:
	mtlr 0
	blrl
	stw 3,48(31)
	b .L10
.L13:
	li 0,0
	stw 0,48(31)
.L10:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 FlagTrackEffects,.Lfe7-FlagTrackEffects
	.section	".rodata"
	.align 2
.LC25:
	.long 0x3e800000
	.section	".text"
	.align 2
	.globl FlagTrackInit
	.type	 FlagTrackInit,@function
FlagTrackInit:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,.LC25@ha
	lis 11,maxclients@ha
	la 9,.LC25@l(9)
	lfs 0,0(9)
	lwz 9,maxclients@l(11)
	lfs 1,20(9)
	fmuls 1,1,0
	bl ceil
	fctiwz 0,1
	li 3,0
	li 4,0
	stfd 0,16(1)
	lwz 31,20(1)
	bl listNew
	cmpwi 0,31,0
	lis 9,flags@ha
	stw 3,flags@l(9)
	bc 4,1,.L75
.L77:
	li 3,0
	bl spawnFlag
	li 3,1
	bl spawnFlag
	addic. 31,31,-1
	bc 4,2,.L77
.L75:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 FlagTrackInit,.Lfe8-FlagTrackInit
	.comm	gCauseTable,4,4
	.align 2
	.globl modelForTeam
	.type	 modelForTeam,@function
modelForTeam:
	cmpwi 0,3,0
	bc 4,2,.L7
	lis 9,.LC1@ha
	la 3,.LC1@l(9)
	blr
.L7:
	lis 9,.LC2@ha
	la 3,.LC2@l(9)
	blr
.Lfe9:
	.size	 modelForTeam,.Lfe9-modelForTeam
	.section	".rodata"
	.align 2
.LC26:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl touchFlag
	.type	 touchFlag,@function
touchFlag:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,4
	mr 31,3
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L59
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L59
	lwz 0,256(31)
	cmpw 0,0,30
	bc 4,2,.L62
	lis 9,level+4@ha
	lfs 13,900(31)
	lis 10,.LC26@ha
	lfs 0,level+4@l(9)
	la 10,.LC26@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L59
.L62:
	lwz 9,4004(11)
	cmpwi 0,9,-1
	bc 4,2,.L63
	lwz 9,3476(11)
	lwz 0,908(31)
	cmpw 0,9,0
	bc 4,2,.L64
	lis 9,gi+8@ha
	lis 5,.LC15@ha
	lwz 0,gi+8@l(9)
	la 5,.LC15@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L65
.L64:
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 0,gi+8@l(9)
	la 5,.LC16@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L65:
	lwz 9,84(30)
	mr 3,31
	lwz 0,908(31)
	stw 0,4004(9)
	bl G_FreeEdict
	b .L59
.L63:
	lwz 0,908(31)
	cmpw 0,0,9
	bc 12,2,.L59
	mr 3,31
	mr 4,30
	bl captureFlag
.L59:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 touchFlag,.Lfe10-touchFlag
	.align 2
	.globl respawnInactiveFlag
	.type	 respawnInactiveFlag,@function
respawnInactiveFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 3,908(29)
	bl spawnFlag
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 respawnInactiveFlag,.Lfe11-respawnInactiveFlag
	.section	".rodata"
	.align 2
.LC27:
	.long 0x42b40000
	.section	".text"
	.align 2
	.globl activateFlag
	.type	 activateFlag,@function
activateFlag:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	li 8,7
	lis 9,touchFlag@ha
	stw 8,260(11)
	lis 10,respawnInactiveFlag@ha
	la 9,touchFlag@l(9)
	li 0,1
	stw 9,444(11)
	la 10,respawnInactiveFlag@l(10)
	lis 8,.LC27@ha
	stw 0,248(11)
	lis 9,level+4@ha
	la 8,.LC27@l(8)
	stw 10,436(11)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	lwz 0,64(11)
	lis 8,gi+72@ha
	lwz 9,68(11)
	fadds 0,0,13
	ori 0,0,1
	ori 9,9,8
	stw 0,64(11)
	stw 9,68(11)
	stfs 0,428(11)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 activateFlag,.Lfe12-activateFlag
	.section	".rodata"
	.align 2
.LC28:
	.long 0xc1700000
	.align 2
.LC29:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl createFlag
	.type	 createFlag,@function
createFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	bl G_Spawn
	lis 9,.LC3@ha
	lis 11,.LC28@ha
	mr 31,3
	la 9,.LC3@l(9)
	la 11,.LC28@l(11)
	stw 9,280(31)
	lfs 1,0(11)
	lis 9,.LC28@ha
	lis 11,.LC28@ha
	la 9,.LC28@l(9)
	la 11,.LC28@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	bl tv
	lfs 13,0(3)
	lis 9,.LC29@ha
	lis 11,.LC29@ha
	la 9,.LC29@l(9)
	la 11,.LC29@l(11)
	lfs 1,0(9)
	stfs 13,188(31)
	lis 9,.LC29@ha
	lfs 0,4(3)
	la 9,.LC29@l(9)
	lfs 2,0(11)
	lfs 3,0(9)
	stfs 0,192(31)
	lfs 13,8(3)
	stfs 13,196(31)
	bl tv
	lfs 0,0(3)
	cmpwi 0,30,0
	stfs 0,200(31)
	lfs 13,4(3)
	stfs 13,204(31)
	lfs 0,8(3)
	stw 30,908(31)
	stfs 0,208(31)
	bc 4,2,.L18
	lis 9,.LC1@ha
	la 4,.LC1@l(9)
	b .L19
.L18:
	lis 9,.LC2@ha
	la 4,.LC2@l(9)
.L19:
	lis 29,gi@ha
	stw 4,268(31)
	mr 3,31
	la 29,gi@l(29)
	lwz 9,44(29)
	mtlr 9
	blrl
	lwz 0,32(29)
	lwz 3,268(31)
	mtlr 0
	blrl
	cmpwi 0,30,0
	lis 0,0x8
	bc 4,2,.L21
	lis 0,0x4
.L21:
	stw 0,64(31)
	mr 3,31
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 createFlag,.Lfe13-createFlag
	.align 2
	.globl pickupFlag
	.type	 pickupFlag,@function
pickupFlag:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	lwz 9,84(31)
	lwz 11,908(30)
	lwz 0,3476(9)
	cmpw 0,0,11
	bc 4,2,.L50
	lis 9,gi+8@ha
	lis 5,.LC15@ha
	lwz 0,gi+8@l(9)
	la 5,.LC15@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L51
.L50:
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 0,gi+8@l(9)
	la 5,.LC16@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L51:
	lwz 9,84(31)
	mr 3,30
	lwz 0,908(30)
	stw 0,4004(9)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 pickupFlag,.Lfe14-pickupFlag
	.align 2
	.globl scoreAssist
	.type	 scoreAssist,@function
scoreAssist:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,912(31)
	cmpwi 0,9,0
	bc 12,2,.L53
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L53
	lwz 29,84(9)
	lwz 0,720(29)
	cmpwi 0,0,0
	bc 12,2,.L53
	cmpwi 0,29,0
	bc 12,2,.L53
	cmpw 0,9,4
	bc 12,2,.L53
	lwz 9,84(4)
	lwz 3,3476(29)
	lwz 0,3476(9)
	cmpw 0,3,0
	bc 4,2,.L53
	addi 29,29,700
	bl nameForTeam
	lis 9,gi@ha
	mr 6,3
	lwz 0,gi@l(9)
	lis 4,.LC17@ha
	mr 5,29
	la 4,.LC17@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,912(31)
	lwz 10,84(11)
	lwz 9,3432(10)
	addi 9,9,5
	stw 9,3432(10)
.L53:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 scoreAssist,.Lfe15-scoreAssist
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
