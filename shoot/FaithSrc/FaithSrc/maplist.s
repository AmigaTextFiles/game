	.file	"maplist.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s"
	.align 2
.LC1:
	.string	"[maplist]"
	.align 2
.LC2:
	.string	"-------------------------------------\n"
	.align 2
.LC3:
	.string	"ERROR - No [maplist] section in \"%s\".\n"
	.align 2
.LC4:
	.string	"###"
	.align 2
.LC5:
	.string	"...%s\n"
	.align 2
.LC6:
	.string	"No maps listed in [maplist] section of %s\n"
	.align 2
.LC7:
	.string	"%i map(s) loaded.\n"
	.section	".text"
	.align 2
	.globl LoadMapList
	.type	 LoadMapList,@function
LoadMapList:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 27,3
	li 30,0
	bl OpenFile
	mr. 31,3
	bc 12,2,.L7
	lis 28,.LC0@ha
	lis 29,.LC1@ha
.L11:
	mr 3,31
	la 4,.LC0@l(28)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L22
	addi 3,1,8
	la 4,.LC1@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L11
	lhz 0,12(31)
	andi. 9,0,32
	bc 12,2,.L13
.L22:
	lis 29,gi@ha
	lis 28,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(28)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	lis 3,.LC3@ha
	mr 4,27
	la 3,.LC3@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	la 3,.LC2@l(28)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L14
.L13:
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L15
.L18:
	lis 9,maplist+28@ha
	slwi 29,30,4
	la 9,maplist+28@l(9)
	addi 4,1,8
	add 29,29,9
	li 5,16
	mr 3,29
	addi 30,30,1
	bl strncpy
	lis 9,gi+4@ha
	lis 3,.LC5@ha
	lwz 0,gi+4@l(9)
	la 3,.LC5@l(3)
	mr 4,29
	mtlr 0
	crxor 6,6,6
	blrl
.L15:
	lhz 0,12(31)
	cmpwi 7,30,15
	xori 0,0,32
	rlwinm 0,0,27,31,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 12,2,.L16
	lis 4,.LC0@ha
	addi 5,1,8
	la 4,.LC0@l(4)
	mr 3,31
	crxor 6,6,6
	bl fscanf
	lis 4,.LC4@ha
	addi 3,1,8
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
.L16:
	lis 3,maplist@ha
	mr 4,27
	la 3,maplist@l(3)
	li 5,20
	bl strncpy
.L14:
	mr 3,31
	bl CloseFile
	cmpwi 0,30,0
	bc 12,2,.L20
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	lwz 9,4(29)
	mr 4,30
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,maplist+24@ha
	li 3,1
	stw 30,maplist+24@l(9)
	b .L21
.L20:
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	lwz 9,4(29)
	mr 4,27
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L7:
	li 3,0
.L21:
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 LoadMapList,.Lfe1-LoadMapList
	.section	".rodata"
	.align 2
.LC8:
	.string	"Maplist cleared/disabled.\n"
	.align 2
.LC9:
	.string	"usage:\n"
	.align 2
.LC10:
	.string	"MAPLIST <filename> [<rotate_f>]\n"
	.align 2
.LC11:
	.string	"  <filename> - server ini file\n"
	.align 2
.LC12:
	.string	"  <rotate_f> - 0 = sequential (def)\n"
	.align 2
.LC13:
	.string	"               1 = random\n"
	.align 2
.LC14:
	.string	"MAPLIST START    - go to 1st map\n"
	.align 2
.LC15:
	.string	"MAPLIST NEXT     - go to next map\n"
	.align 2
.LC16:
	.string	"MAPLIST GOTO <n> - go to map #<n>\n"
	.align 2
.LC17:
	.string	"MAPLIST          - show current list\n"
	.align 2
.LC18:
	.string	"MAPLIST HELP     - (this screen)\n"
	.align 2
.LC19:
	.string	"MAPLIST OFF      - clear/disable\n"
	.section	".text"
	.align 2
	.globl DisplayMaplistUsage
	.type	 DisplayMaplistUsage,@function
DisplayMaplistUsage:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 29,20(1)
	stw 0,36(1)
	stw 12,16(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	lis 29,.LC2@ha
	lwz 9,8(31)
	la 5,.LC2@l(29)
	li 4,2
	cmpwi 4,30,0
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC9@ha
	mr 3,30
	la 5,.LC9@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L25
	lwz 9,8(31)
	lis 5,.LC10@ha
	li 3,0
	la 5,.LC10@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC11@ha
	li 3,0
	la 5,.LC11@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC12@ha
	li 3,0
	la 5,.LC12@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC13@ha
	li 3,0
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC14@ha
	li 3,0
	la 5,.LC14@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC15@ha
	li 3,0
	la 5,.LC15@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC16@ha
	li 3,0
	la 5,.LC16@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L25:
	lwz 9,8(31)
	lis 5,.LC17@ha
	mr 3,30
	la 5,.LC17@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC18@ha
	mr 3,30
	la 5,.LC18@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L26
	lwz 9,8(31)
	lis 5,.LC19@ha
	li 3,0
	la 5,.LC19@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L26:
	lwz 0,8(31)
	mr 3,30
	la 5,.LC2@l(29)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	lwz 12,16(1)
	mtlr 0
	lmw 29,20(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe2:
	.size	 DisplayMaplistUsage,.Lfe2-DisplayMaplistUsage
	.section	".rodata"
	.align 2
.LC20:
	.string	"FILENAME: %s\n"
	.align 2
.LC21:
	.string	"#%2d \"%s\"\n"
	.align 2
.LC22:
	.string	"%i map(s) in list.\n"
	.align 2
.LC23:
	.string	"Rotation flag = %i "
	.align 2
.LC24:
	.string	"\"sequential\"\n"
	.align 2
.LC25:
	.string	"\"random\"\n"
	.align 2
.LC26:
	.string	"(ERROR)\n"
	.align 2
.LC27:
	.string	"Current map = #-1 (not started)\n"
	.align 2
.LC28:
	.string	"Current map = #%i \"%s\"\n"
	.section	".text"
	.align 2
	.globl ShowCurrentMaplist
	.type	 ShowCurrentMaplist,@function
ShowCurrentMaplist:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lis 5,.LC2@ha
	lwz 9,8(30)
	la 5,.LC2@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	cmpwi 0,31,0
	bc 4,2,.L28
	lwz 9,4(30)
	lis 3,.LC20@ha
	lis 4,maplist@ha
	la 4,maplist@l(4)
	la 3,.LC20@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
.L28:
	lis 9,maplist@ha
	li 6,0
	la 9,maplist@l(9)
	lwz 0,24(9)
	cmpw 0,6,0
	bc 4,0,.L30
	mr 26,30
	mr 27,9
	addi 28,9,28
	lis 30,.LC21@ha
.L32:
	lwz 9,8(26)
	slwi 7,6,4
	addi 29,6,1
	mr 6,29
	add 7,7,28
	mr 3,31
	li 4,2
	mtlr 9
	la 5,.LC21@l(30)
	crxor 6,6,6
	blrl
	lwz 0,24(27)
	mr 6,29
	cmpw 0,6,0
	bc 12,0,.L32
.L30:
	lis 9,gi@ha
	lis 5,.LC22@ha
	la 30,gi@l(9)
	la 5,.LC22@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 29,maplist@ha
	lis 5,.LC23@ha
	la 29,maplist@l(29)
	la 5,.LC23@l(5)
	mr 3,31
	li 4,2
	lbz 6,284(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lbz 0,284(29)
	cmpwi 0,0,0
	bc 12,2,.L35
	cmpwi 0,0,1
	bc 12,2,.L36
	b .L37
.L35:
	lwz 0,8(30)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
	b .L41
.L36:
	lwz 0,8(30)
	lis 5,.LC25@ha
	mr 3,31
	la 5,.LC25@l(5)
.L41:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L34
.L37:
	lis 9,gi+8@ha
	lis 5,.LC26@ha
	lwz 0,gi+8@l(9)
	la 5,.LC26@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L34:
	lis 9,maplist@ha
	la 9,maplist@l(9)
	lwz 6,288(9)
	cmpwi 0,6,-1
	bc 4,2,.L39
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	la 5,.LC27@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L40
.L39:
	addi 0,9,28
	slwi 7,6,4
	lis 9,gi+8@ha
	lis 5,.LC28@ha
	lwz 9,gi+8@l(9)
	add 7,7,0
	la 5,.LC28@l(5)
	addi 6,6,1
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L40:
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC2@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 ShowCurrentMaplist,.Lfe3-ShowCurrentMaplist
	.section	".rodata"
	.align 2
.LC29:
	.string	"*** No MAPLIST active ***\n"
	.align 2
.LC30:
	.string	"HELP"
	.align 2
.LC31:
	.string	"MAPLIST options locked by server.\n"
	.align 2
.LC32:
	.string	"START"
	.align 2
.LC33:
	.string	"NEXT"
	.align 2
.LC34:
	.string	"OFF"
	.align 2
.LC35:
	.string	"GOTO"
	.align 2
.LC36:
	.string	"*** Map# out of range ***\n"
	.align 2
.LC37:
	.string	"target_changelevel"
	.align 2
.LC38:
	.string	"You must disable current maplist first. (SV MAPLIST OFF)\n"
	.align 2
.LC39:
	.string	"Maplist created/enabled. You can now use START or NEXT.\n"
	.align 3
.LC40:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Svcmd_Maplist_f
	.type	 Svcmd_Maplist_f,@function
Svcmd_Maplist_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 12,2,.L54
	bc 12,1,.L86
	cmpwi 0,3,2
	bc 12,2,.L81
	b .L84
.L86:
	cmpwi 0,3,4
	bc 12,2,.L69
	b .L84
.L54:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L82
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC32@ha
	la 4,.LC32@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L56
	lis 9,maplist+24@ha
	lwz 0,maplist+24@l(9)
	cmpwi 0,0,0
	bc 12,1,.L87
	b .L82
.L56:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC33@ha
	la 4,.LC33@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L60
	lis 9,maplist+24@ha
	lwz 0,maplist+24@l(9)
	cmpwi 0,0,0
	bc 4,1,.L82
.L87:
	bl EndDMLevel
	b .L53
.L60:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC34@ha
	la 4,.LC34@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L64
	lis 9,maplist@ha
	la 9,maplist@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,1,.L82
	lis 10,dmflags@ha
	stw 3,24(9)
	lis 0,0x4330
	lwz 8,dmflags@l(10)
	lis 3,.LC8@ha
	mr 11,9
	lis 10,.LC40@ha
	lfs 0,20(8)
	la 10,.LC40@l(10)
	la 3,.LC8@l(3)
	lfd 12,0(10)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	rlwinm 9,9,0,16,14
	xoris 9,9,0x8000
	stw 9,28(1)
	stw 0,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	stfs 0,20(8)
	lwz 0,4(31)
	b .L88
.L64:
	lis 9,maplist+284@ha
	li 0,0
	stb 0,maplist+284@l(9)
.L69:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,4
	bc 4,2,.L70
	lwz 9,160(29)
	li 3,3
	mtlr 9
	blrl
	bl atoi
	lwz 9,160(29)
	mr 31,3
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC35@ha
	la 4,.LC35@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L71
	cmpwi 0,31,0
	bc 4,1,.L73
	lis 9,maplist@ha
	la 30,maplist@l(9)
	lwz 0,24(30)
	cmpw 0,31,0
	bc 4,1,.L72
.L73:
	lwz 0,4(29)
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L89
.L72:
	bl G_Spawn
	addi 10,30,12
	lis 9,.LC37@ha
	slwi 0,31,4
	mr 11,3
	add 0,0,10
	la 9,.LC37@l(9)
	stw 9,280(11)
	addi 10,31,-1
	stw 0,504(11)
	stw 10,288(30)
	bl BeginIntermission
	b .L53
.L71:
	cmplwi 0,31,1
	bc 12,1,.L82
	lwz 0,160(29)
	li 3,3
	mtlr 0
	blrl
	bl atoi
	lis 9,maplist+284@ha
	stb 3,maplist+284@l(9)
.L70:
	lis 9,gi@ha
	li 3,2
	la 31,gi@l(9)
	lis 30,dmflags@ha
	lwz 9,160(31)
	mtlr 9
	blrl
	lwz 11,dmflags@l(30)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andis. 0,9,1
	bc 12,2,.L78
	lwz 0,4(31)
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
.L88:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L53
.L78:
	bl LoadMapList
	cmpwi 0,3,0
	bc 12,2,.L53
	lwz 10,dmflags@l(30)
	lis 0,0x4330
	mr 11,9
	lis 8,.LC40@ha
	lfs 0,20(10)
	la 8,.LC40@l(8)
	lis 3,.LC39@ha
	lfd 12,0(8)
	la 3,.LC39@l(3)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	oris 9,9,0x1
	xoris 9,9,0x8000
	stw 9,28(1)
	stw 0,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	stfs 0,20(10)
	lwz 0,4(31)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,maplist+288@ha
	li 0,-1
	stw 0,maplist+288@l(9)
	b .L53
.L81:
	lis 9,maplist+24@ha
	lwz 0,maplist+24@l(9)
	cmpwi 0,0,0
	bc 4,1,.L82
.L89:
	li 3,0
	bl ShowCurrentMaplist
	b .L53
.L82:
	li 3,0
	bl DisplayMaplistUsage
	b .L53
.L84:
	li 3,0
	bl DisplayMaplistUsage
.L53:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Svcmd_Maplist_f,.Lfe4-Svcmd_Maplist_f
	.comm	maplist,292,4
	.section	".rodata"
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClearMapList
	.type	 ClearMapList,@function
ClearMapList:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,dmflags@ha
	lis 10,maplist+24@ha
	lwz 8,dmflags@l(9)
	li 0,0
	lis 3,.LC8@ha
	stw 0,maplist+24@l(10)
	la 3,.LC8@l(3)
	lfs 0,20(8)
	mr 11,9
	lis 0,0x4330
	lis 10,.LC41@ha
	la 10,.LC41@l(10)
	lfd 12,0(10)
	lis 10,gi+4@ha
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	rlwinm 9,9,0,16,14
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	stfs 0,20(8)
	lwz 0,gi+4@l(10)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 ClearMapList,.Lfe5-ClearMapList
	.align 2
	.globl Cmd_Maplist_f
	.type	 Cmd_Maplist_f,@function
Cmd_Maplist_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 12,2,.L44
	cmpwi 0,3,2
	bc 12,2,.L47
	b .L50
.L44:
	lis 9,maplist+24@ha
	lwz 0,maplist+24@l(9)
	cmpwi 0,0,0
	bc 4,1,.L45
	mr 3,31
	bl ShowCurrentMaplist
	b .L43
.L45:
	lwz 0,8(30)
	lis 5,.LC29@ha
	mr 3,31
	la 5,.LC29@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L90
.L47:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L48
.L90:
	mr 3,31
	bl DisplayMaplistUsage
	b .L43
.L48:
	lwz 0,8(30)
	lis 5,.LC31@ha
	mr 3,31
	la 5,.LC31@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L43
.L50:
	mr 3,31
	bl DisplayMaplistUsage
.L43:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Cmd_Maplist_f,.Lfe6-Cmd_Maplist_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
