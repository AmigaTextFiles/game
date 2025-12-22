	.file	"e_gbstat.c"
gcc2_compiled.:
	.globl gsCauseTable
	.section	".data"
	.type	 gsCauseTable,@object
	.size	 gsCauseTable,700
gsCauseTable:
	.string	"Unknown"
	.space	12
	.string	"Blaster"
	.space	12
	.string	"Shotgun"
	.space	12
	.string	"Super Shotgun"
	.space	6
	.string	"Machinegun"
	.space	9
	.string	"Chaingun"
	.space	11
	.string	"Grenade Launcher"
	.space	3
	.string	"Grenade Launcher"
	.space	3
	.string	"Rocket Launcher"
	.space	4
	.string	"Rocket Launcher"
	.space	4
	.string	"Hyperblaster"
	.space	7
	.string	"Railgun"
	.space	12
	.string	"BFG10K"
	.space	13
	.string	"BFG10K"
	.space	13
	.string	"BFG10K"
	.space	13
	.string	"Hand Grenade"
	.space	7
	.string	"Hand Grenade"
	.space	7
	.string	"Drowned"
	.space	12
	.string	"Slime"
	.space	14
	.string	"Lava"
	.space	15
	.string	"Squished"
	.space	11
	.string	"Telefrag"
	.space	11
	.string	"Fell"
	.space	15
	.string	"Kill Command"
	.space	7
	.string	"Hand Grenade"
	.space	7
	.string	"Blown Up"
	.space	11
	.string	"Blown Up"
	.space	11
	.string	"Blown Up"
	.space	11
	.string	"Exit"
	.space	15
	.string	"Blown Up"
	.space	11
	.string	"Laser Trap"
	.space	9
	.string	"Trap"
	.space	15
	.string	"Trap"
	.space	15
	.string	"Blaster Trap"
	.space	7
	.string	"Hook"
	.space	15
	.section	".rodata"
	.align 2
.LC0:
	.string	"The cvar \"giblog\", which tells the server the name of the file in which to write the gibstats log, is blank.  Disabling Gibstats\n"
	.align 2
.LC1:
	.string	"1.2"
	.align 2
.LC2:
	.string	"/"
	.align 2
.LC3:
	.string	".%02u.%02u.%02u.%s.%02u.%02u.%02u"
	.align 2
.LC4:
	.string	"w"
	.align 2
.LC5:
	.string	"a+"
	.align 2
.LC6:
	.string	"***************************\n"
	.align 2
.LC7:
	.string	"ERROR: Couldn't open %s (GibStat).\n"
	.align 2
.LC8:
	.string	"Started GibStats %s Logging...\n"
	.section	".text"
	.align 2
	.globl gsStartLogging
	.type	 gsStartLogging,@function
gsStartLogging:
	stwu 1,-1056(1)
	mflr 0
	stmw 28,1040(1)
	stw 0,1060(1)
	lis 9,gsFile@ha
	lis 31,gsFile@ha
	lwz 0,gsFile@l(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	li 3,1
	b .L12
.L7:
	lis 28,sv_giblog@ha
	lwz 9,sv_giblog@l(28)
	lwz 3,4(9)
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L8
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L13
.L8:
	addi 29,1,1016
	mr 3,29
	bl time
	mr 3,29
	bl localtime
	lis 9,gamedir@ha
	mr 29,3
	lwz 11,gamedir@l(9)
	addi 3,1,8
	lwz 4,4(11)
	bl strcpy
	lis 4,.LC2@ha
	addi 3,1,8
	la 4,.LC2@l(4)
	bl strcat
	lwz 9,sv_giblog@l(28)
	addi 3,1,8
	lwz 4,4(9)
	bl strcat
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1032(1)
	lwz 11,1036(1)
	andi. 0,11,128
	bc 12,2,.L9
	lwz 5,16(29)
	lis 3,.LC3@ha
	lis 7,level+72@ha
	lwz 10,0(29)
	la 7,level+72@l(7)
	la 3,.LC3@l(3)
	lwz 6,12(29)
	addi 5,5,1
	lwz 8,8(29)
	lwz 9,4(29)
	lwz 4,20(29)
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC4@ha
	addi 3,1,8
	la 4,.LC4@l(4)
	b .L14
.L9:
	lis 4,.LC5@ha
	addi 3,1,8
	la 4,.LC5@l(4)
.L14:
	bl fopen
	stw 3,gsFile@l(31)
	lis 9,gsFile@ha
	lwz 0,gsFile@l(9)
	cmpwi 0,0,0
	bc 12,2,.L11
	lis 9,gi+4@ha
	lis 3,.LC8@ha
	lwz 0,gi+4@l(9)
	lis 4,.LC1@ha
	la 3,.LC8@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L12
.L11:
	lis 29,gi@ha
	lis 28,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(28)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC7@ha
	addi 4,1,8
	la 3,.LC7@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	la 3,.LC6@l(28)
	mtlr 0
	crxor 6,6,6
	blrl
.L13:
	li 3,0
.L12:
	lwz 0,1060(1)
	mtlr 0
	lmw 28,1040(1)
	la 1,1056(1)
	blr
.Lfe1:
	.size	 gsStartLogging,.Lfe1-gsStartLogging
	.section	".rodata"
	.align 2
.LC9:
	.string	"Stopped GibStats %s Logging...\n"
	.align 2
.LC10:
	.string	"\t\tLogDate\t%02u.%02u.%02u\n"
	.align 2
.LC11:
	.string	"\t\tLogTime\t%02u:%02u:%02u\n"
	.align 2
.LC12:
	.string	"\t\tPlayer\t%s\t%s\t%u\n"
	.align 2
.LC13:
	.string	""
	.align 2
.LC14:
	.long 0x3f800000
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl gsEnumConnectedClients
	.type	 gsEnumConnectedClients,@function
gsEnumConnectedClients:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 21,28(1)
	stw 0,84(1)
	lis 9,gsFile@ha
	lis 21,gsFile@ha
	lwz 0,gsFile@l(9)
	cmpwi 0,0,0
	bc 12,2,.L20
	lis 9,maxclients@ha
	lis 11,.LC14@ha
	lwz 10,maxclients@l(9)
	la 11,.LC14@l(11)
	li 28,1
	lfs 13,0(11)
	lis 22,maxclients@ha
	lfs 0,20(10)
	lis 11,g_edicts@ha
	lwz 9,g_edicts@l(11)
	fcmpu 0,13,0
	addi 30,9,916
	cror 3,2,0
	bc 4,3,.L20
	lis 9,level@ha
	lis 23,sv_expflags@ha
	la 24,level@l(9)
	lis 25,.LC13@ha
	lis 9,.LC15@ha
	lis 26,.LC12@ha
	la 9,.LC15@l(9)
	lis 27,0x4330
	lfd 31,0(9)
.L25:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 10,84(30)
	cmpwi 0,10,0
	bc 12,2,.L26
	lwz 11,sv_expflags@l(23)
	addi 29,10,700
	lwz 31,gsFile@l(21)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 11,9,256
	bc 12,2,.L27
	lwz 3,3476(10)
	bl nameForTeam
	mr 6,3
	b .L28
.L27:
	la 6,.LC13@l(25)
.L28:
	lfs 0,4(24)
	mr 3,31
	mr 5,29
	la 4,.LC12@l(26)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 7,20(1)
	crxor 6,6,6
	bl fprintf
.L26:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	addi 30,30,916
	stw 0,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L25
.L20:
	lwz 0,84(1)
	mtlr 0
	lmw 21,28(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 gsEnumConnectedClients,.Lfe2-gsEnumConnectedClients
	.section	".rodata"
	.align 2
.LC16:
	.string	"\t\tPlayerRename\t%s\t%s\t%u\n"
	.align 2
.LC17:
	.string	"\t\tPlayerTeamChange\t%s\t%s\t%u\n"
	.align 2
.LC18:
	.string	"\t\tStdLog\t%s\n"
	.align 2
.LC19:
	.string	"\t\tPatchName\t%s\n"
	.align 2
.LC20:
	.string	"Expert %s"
	.align 2
.LC21:
	.string	"Arena"
	.align 2
.LC22:
	.string	"DM"
	.align 2
.LC23:
	.string	"Teams"
	.align 2
.LC24:
	.string	"CTF"
	.align 2
.LC25:
	.string	"\t\tMap\t%s\n"
	.align 2
.LC26:
	.string	"\t\tLogDeathFlags\t%u\n"
	.align 2
.LC27:
	.string	"\t\tLogExpertFlags\t%u\n"
	.section	".text"
	.align 2
	.globl gsLogLevelStart
	.type	 gsLogLevelStart,@function
gsLogLevelStart:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	lis 9,gsFile@ha
	lis 30,gsFile@ha
	lwz 3,gsFile@l(9)
	cmpwi 0,3,0
	bc 12,2,.L34
	lis 4,.LC18@ha
	lis 5,.LC1@ha
	la 4,.LC18@l(4)
	la 5,.LC1@l(5)
	crxor 6,6,6
	bl fprintf
	lis 9,gametype@ha
	lwz 31,gsFile@l(30)
	lwz 0,gametype@l(9)
	cmpwi 0,0,3
	bc 12,2,.L36
	cmpwi 0,0,2
	bc 12,2,.L38
	cmpwi 0,0,4
	bc 4,2,.L40
	lis 9,.LC21@ha
	la 4,.LC21@l(9)
	b .L37
.L40:
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
	b .L37
.L38:
	lis 9,.LC23@ha
	la 4,.LC23@l(9)
	b .L37
.L36:
	lis 9,.LC24@ha
	la 4,.LC24@l(9)
.L37:
	lis 3,.LC20@ha
	lis 29,gsFile@ha
	la 3,.LC20@l(3)
	crxor 6,6,6
	bl va
	mr 5,3
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	lwz 3,gsFile@l(29)
	lis 4,.LC25@ha
	lis 5,level+8@ha
	la 4,.LC25@l(4)
	la 5,level+8@l(5)
	crxor 6,6,6
	bl fprintf
	lis 11,dmflags@ha
	lwz 3,gsFile@l(29)
	lwz 9,dmflags@l(11)
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 5,44(1)
	crxor 6,6,6
	bl fprintf
	lis 11,sv_expflags@ha
	lwz 3,gsFile@l(29)
	lwz 9,sv_expflags@l(11)
	lis 4,.LC27@ha
	la 4,.LC27@l(4)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 5,44(1)
	crxor 6,6,6
	bl fprintf
	lwz 0,gsFile@l(29)
	cmpwi 0,0,0
	bc 12,2,.L34
	addi 29,1,8
	mr 3,29
	bl time
	mr 3,29
	bl localtime
	mr 29,3
	lis 4,.LC10@ha
	lwz 6,16(29)
	la 4,.LC10@l(4)
	lwz 5,12(29)
	lwz 7,20(29)
	addi 6,6,1
	lwz 3,gsFile@l(30)
	crxor 6,6,6
	bl fprintf
	lis 4,.LC11@ha
	lwz 3,gsFile@l(30)
	lwz 7,0(29)
	la 4,.LC11@l(4)
	lwz 5,8(29)
	lwz 6,4(29)
	crxor 6,6,6
	bl fprintf
.L34:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 gsLogLevelStart,.Lfe3-gsLogLevelStart
	.section	".rodata"
	.align 2
.LC28:
	.string	"\t\tPlayerConnect\t%s\t%s\t%u\n"
	.align 2
.LC29:
	.string	"\t\tPlayerLeft\t%s\t\t%u\n"
	.align 2
.LC30:
	.string	"TeamKill"
	.align 2
.LC31:
	.string	"Kill"
	.align 2
.LC32:
	.string	"%s\t%s\t%s\t%s\t%i\t%u\t%u\n"
	.align 2
.LC33:
	.string	"Suicide"
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.section	".text"
	.align 2
	.globl gsStopLogging
	.type	 gsStopLogging,@function
gsStopLogging:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 31,gsFile@ha
	li 3,1
	lwz 0,gsFile@l(31)
	cmpwi 0,0,0
	bc 12,2,.L61
	mr 3,0
	bl fclose
	mr. 0,3
	bc 4,2,.L17
	lis 9,gi+4@ha
	stw 0,gsFile@l(31)
	lis 3,.LC9@ha
	lwz 0,gi+4@l(9)
	lis 4,.LC1@ha
	la 3,.LC9@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L61
.L17:
	li 3,0
.L61:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 gsStopLogging,.Lfe4-gsStopLogging
	.align 2
	.globl gsPlayerNameChange
	.type	 gsPlayerNameChange,@function
gsPlayerNameChange:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gsFile@ha
	mr 5,3
	lwz 3,gsFile@l(9)
	mr 6,4
	cmpwi 0,3,0
	bc 12,2,.L30
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 7,12(1)
	crxor 6,6,6
	bl fprintf
.L30:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 gsPlayerNameChange,.Lfe5-gsPlayerNameChange
	.align 2
	.globl gsTeamChange
	.type	 gsTeamChange,@function
gsTeamChange:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gsFile@ha
	mr 5,3
	lwz 3,gsFile@l(9)
	mr 6,4
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 7,12(1)
	crxor 6,6,6
	bl fprintf
.L32:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 gsTeamChange,.Lfe6-gsTeamChange
	.align 2
	.globl gsLogDate
	.type	 gsLogDate,@function
gsLogDate:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 31,gsFile@ha
	lwz 0,gsFile@l(31)
	cmpwi 0,0,0
	bc 12,2,.L18
	addi 29,1,8
	mr 3,29
	bl time
	mr 3,29
	bl localtime
	mr 29,3
	lis 4,.LC10@ha
	lwz 6,16(29)
	la 4,.LC10@l(4)
	lwz 5,12(29)
	lwz 7,20(29)
	addi 6,6,1
	lwz 3,gsFile@l(31)
	crxor 6,6,6
	bl fprintf
	lis 4,.LC11@ha
	lwz 3,gsFile@l(31)
	lwz 7,0(29)
	la 4,.LC11@l(4)
	lwz 5,8(29)
	lwz 6,4(29)
	crxor 6,6,6
	bl fprintf
.L18:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 gsLogDate,.Lfe7-gsLogDate
	.align 2
	.globl gsLogClientConnect
	.type	 gsLogClientConnect,@function
gsLogClientConnect:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gsFile@ha
	lwz 31,gsFile@l(9)
	cmpwi 0,31,0
	bc 12,2,.L44
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,256
	bc 12,2,.L46
	lwz 29,84(3)
	lwz 3,3476(29)
	addi 29,29,700
	bl nameForTeam
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	mr 6,3
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	mr 5,29
	fctiwz 13,0
	stfd 13,24(1)
	lwz 7,28(1)
	crxor 6,6,6
	bl fprintf
	b .L44
.L46:
	lis 9,level+4@ha
	lwz 5,84(3)
	lfs 0,level+4@l(9)
	lis 4,.LC28@ha
	lis 6,.LC13@ha
	mr 3,31
	la 4,.LC28@l(4)
	addi 5,5,700
	la 6,.LC13@l(6)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 7,28(1)
	crxor 6,6,6
	bl fprintf
.L44:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 gsLogClientConnect,.Lfe8-gsLogClientConnect
	.align 2
	.globl gsLogClientDisconnect
	.type	 gsLogClientDisconnect,@function
gsLogClientDisconnect:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gsFile@ha
	mr 11,3
	lwz 3,gsFile@l(9)
	cmpwi 0,3,0
	bc 12,2,.L48
	lis 9,level+4@ha
	lwz 5,84(11)
	lfs 0,level+4@l(9)
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	addi 5,5,700
	fctiwz 13,0
	stfd 13,8(1)
	lwz 6,12(1)
	crxor 6,6,6
	bl fprintf
.L48:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 gsLogClientDisconnect,.Lfe9-gsLogClientDisconnect
	.align 2
	.globl gsLogFrag
	.type	 gsLogFrag,@function
gsLogFrag:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,gsFile@ha
	mr 6,3
	lwz 0,gsFile@l(9)
	cmpwi 0,0,0
	bc 12,2,.L50
	andis. 0,5,2048
	bc 12,2,.L52
	lis 9,.LC30@ha
	rlwinm 0,5,0,5,3
	la 7,.LC30@l(9)
	b .L53
.L52:
	lis 9,.LC31@ha
	mr 0,5
	la 7,.LC31@l(9)
.L53:
	lis 11,level+4@ha
	mulli 0,0,20
	lis 8,gsCauseTable@ha
	lwz 5,84(4)
	lfs 0,level+4@l(11)
	la 8,gsCauseTable@l(8)
	add 8,0,8
	lis 9,gsFile@ha
	lwz 6,84(6)
	lwz 0,184(5)
	lis 4,.LC32@ha
	lwz 3,gsFile@l(9)
	la 4,.LC32@l(4)
	addi 5,5,700
	addi 6,6,700
	stw 0,8(1)
	li 9,1
	fctiwz 13,0
	stfd 13,24(1)
	lwz 10,28(1)
	crxor 6,6,6
	bl fprintf
.L50:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe10:
	.size	 gsLogFrag,.Lfe10-gsLogFrag
	.align 2
	.globl gsLogKillSelf
	.type	 gsLogKillSelf,@function
gsLogKillSelf:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,gsFile@ha
	mr 7,4
	lwz 12,gsFile@l(9)
	cmpwi 0,12,0
	bc 12,2,.L54
	lis 9,level+4@ha
	andis. 0,7,2048
	lwz 5,84(3)
	lfs 0,level+4@l(9)
	rlwinm 0,7,0,5,3
	lis 9,gsCauseTable@ha
	lwz 11,184(5)
	lis 4,.LC32@ha
	mfcr 8
	rlwinm 8,8,3,1
	la 9,gsCauseTable@l(9)
	neg 8,8
	lis 6,.LC13@ha
	stw 11,8(1)
	andc 0,0,8
	mr 3,12
	and 8,7,8
	la 4,.LC32@l(4)
	fctiwz 13,0
	or 8,8,0
	lis 7,.LC33@ha
	mulli 8,8,20
	addi 5,5,700
	la 6,.LC13@l(6)
	la 7,.LC33@l(7)
	stfd 13,24(1)
	add 8,8,9
	lwz 10,28(1)
	li 9,-1
	crxor 6,6,6
	bl fprintf
.L54:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe11:
	.size	 gsLogKillSelf,.Lfe11-gsLogKillSelf
	.align 2
	.globl gsLogScore
	.type	 gsLogScore,@function
gsLogScore:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,gsFile@ha
	mr 7,4
	lwz 11,gsFile@l(9)
	mr 8,5
	cmpwi 0,11,0
	bc 12,2,.L57
	lis 9,level+4@ha
	lwz 5,84(3)
	lfs 0,level+4@l(9)
	lis 6,.LC13@ha
	lis 4,.LC32@ha
	lwz 0,184(5)
	la 6,.LC13@l(6)
	mr 9,8
	mr 3,11
	la 4,.LC32@l(4)
	addi 5,5,700
	stw 0,8(1)
	mr 8,6
	fctiwz 13,0
	stfd 13,24(1)
	lwz 10,28(1)
	crxor 6,6,6
	bl fprintf
.L57:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe12:
	.size	 gsLogScore,.Lfe12-gsLogScore
	.align 2
	.globl gsLogMisc
	.type	 gsLogMisc,@function
gsLogMisc:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gsFile@ha
	mr 4,3
	lwz 3,gsFile@l(9)
	cmpwi 0,3,0
	bc 12,2,.L59
	crxor 6,6,6
	bl fprintf
.L59:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 gsLogMisc,.Lfe13-gsLogMisc
	.section	".sbss","aw",@nobits
	.align 2
gsFile:
	.space	4
	.size	 gsFile,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
