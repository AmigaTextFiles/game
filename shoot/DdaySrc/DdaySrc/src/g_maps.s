	.file	"g_maps.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"dday/"
	.align 2
.LC1:
	.string	"r"
	.align 2
.LC2:
	.string	"Could not open file \"%s\".\n"
	.align 2
.LC3:
	.string	"ERROR -- DDay_CloseFile() exception.\n"
	.align 2
.LC4:
	.string	"%s"
	.align 2
.LC5:
	.string	"[maplist]"
	.align 2
.LC6:
	.string	"-------------------------------------\n"
	.align 2
.LC7:
	.string	"ERROR - No [maplist] section in \"%s\".\n"
	.align 2
.LC8:
	.string	"###"
	.align 2
.LC9:
	.string	"...%s\n"
	.align 2
.LC10:
	.string	"No maps listed in [maplist] section of %s\n"
	.align 2
.LC11:
	.string	"%i map(s) loaded.\n"
	.section	".text"
	.align 2
	.globl LoadMapList
	.type	 LoadMapList,@function
LoadMapList:
	stwu 1,-368(1)
	mflr 0
	mfcr 12
	stmw 27,348(1)
	stw 0,372(1)
	stw 12,344(1)
	lis 9,.LC0@ha
	mr 27,3
	la 11,.LC0@l(9)
	lwz 10,.LC0@l(9)
	mr 4,27
	lhz 0,4(11)
	addi 3,1,88
	li 30,0
	stw 10,88(1)
	sth 0,92(1)
	bl strcat
	lis 4,.LC1@ha
	addi 3,1,88
	la 4,.LC1@l(4)
	bl fopen
	mr. 3,3
	bc 4,2,.L12
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
	addi 4,1,88
	li 31,0
	mtlr 0
	crxor 6,6,6
	blrl
	b .L13
.L12:
	mr 31,3
.L13:
	cmpwi 4,31,0
	bc 12,18,.L14
	lis 28,.LC4@ha
	lis 29,.LC5@ha
.L18:
	mr 3,31
	la 4,.LC4@l(28)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L32
	addi 3,1,8
	la 4,.LC5@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	lhz 0,12(31)
	andi. 9,0,32
	bc 12,2,.L20
.L32:
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
	mr 4,27
	la 3,.LC7@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	la 3,.LC6@l(28)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L21
.L20:
	lis 9,gi+4@ha
	lis 3,.LC6@ha
	lwz 0,gi+4@l(9)
	la 3,.LC6@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L22
.L25:
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
	lis 3,.LC9@ha
	lwz 0,gi+4@l(9)
	la 3,.LC9@l(3)
	mr 4,29
	mtlr 0
	crxor 6,6,6
	blrl
.L22:
	lhz 0,12(31)
	cmpwi 7,30,63
	xori 0,0,32
	rlwinm 0,0,27,31,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 12,2,.L23
	lis 4,.LC4@ha
	addi 5,1,8
	la 4,.LC4@l(4)
	mr 3,31
	crxor 6,6,6
	bl fscanf
	lis 4,.LC8@ha
	addi 3,1,8
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L25
.L23:
	lis 3,maplist@ha
	mr 4,27
	la 3,maplist@l(3)
	li 5,20
	bl strncpy
.L21:
	bc 12,18,.L27
	mr 3,31
	bl fclose
	b .L29
.L27:
	lis 9,gi+4@ha
	lis 3,.LC3@ha
	lwz 0,gi+4@l(9)
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L29:
	cmpwi 0,30,0
	bc 12,2,.L30
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,4(29)
	mr 4,30
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,maplist+24@ha
	li 3,1
	stw 30,maplist+24@l(9)
	b .L31
.L30:
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,4(29)
	mr 4,27
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L14:
	li 3,0
.L31:
	lwz 0,372(1)
	lwz 12,344(1)
	mtlr 0
	lmw 27,348(1)
	mtcrf 8,12
	la 1,368(1)
	blr
.Lfe1:
	.size	 LoadMapList,.Lfe1-LoadMapList
	.section	".rodata"
	.align 2
.LC12:
	.string	"Maplist cleared/disabled.\n"
	.align 2
.LC13:
	.string	"usage:\n"
	.align 2
.LC14:
	.string	"MAPLIST <filename> [<rotate_f>]\n"
	.align 2
.LC15:
	.string	"  <filename> - server ini file\n"
	.align 2
.LC16:
	.string	"  <rotate_f> - 0 = sequential (def)\n"
	.align 2
.LC17:
	.string	"               1 = random\n"
	.align 2
.LC18:
	.string	"MAPLIST START    - go to 1st map\n"
	.align 2
.LC19:
	.string	"MAPLIST NEXT     - go to next map\n"
	.align 2
.LC20:
	.string	"MAPLIST GOTO <n> - go to map #<n>\n"
	.align 2
.LC21:
	.string	"MAPLIST          - show current list\n"
	.align 2
.LC22:
	.string	"MAPLIST HELP     - (this screen)\n"
	.align 2
.LC23:
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
	lis 29,.LC6@ha
	lwz 9,8(31)
	la 5,.LC6@l(29)
	li 4,2
	cmpwi 4,30,0
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L35
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
	lwz 9,8(31)
	lis 5,.LC17@ha
	li 3,0
	la 5,.LC17@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC18@ha
	li 3,0
	la 5,.LC18@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC19@ha
	li 3,0
	la 5,.LC19@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC20@ha
	li 3,0
	la 5,.LC20@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L35:
	lwz 9,8(31)
	lis 5,.LC21@ha
	mr 3,30
	la 5,.LC21@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(31)
	lis 5,.LC22@ha
	mr 3,30
	la 5,.LC22@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L36
	lwz 9,8(31)
	lis 5,.LC23@ha
	li 3,0
	la 5,.LC23@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L36:
	lwz 0,8(31)
	mr 3,30
	la 5,.LC6@l(29)
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
.LC24:
	.string	"FILENAME: %s\n"
	.align 2
.LC25:
	.string	"#%2d \"%s\"\n"
	.align 2
.LC26:
	.string	"%i map(s) in list.\n"
	.align 2
.LC27:
	.string	"Rotation flag = %i "
	.align 2
.LC28:
	.string	"\"sequential\"\n"
	.align 2
.LC29:
	.string	"\"random\"\n"
	.align 2
.LC30:
	.string	"(ERROR)\n"
	.align 2
.LC31:
	.string	"Current map = #-1 (not started)\n"
	.align 2
.LC32:
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
	lis 5,.LC6@ha
	lwz 9,8(30)
	la 5,.LC6@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	cmpwi 0,31,0
	bc 4,2,.L38
	lwz 9,4(30)
	lis 3,.LC24@ha
	lis 4,maplist@ha
	la 4,maplist@l(4)
	la 3,.LC24@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
.L38:
	lis 9,maplist@ha
	li 6,0
	la 9,maplist@l(9)
	lwz 0,24(9)
	cmpw 0,6,0
	bc 4,0,.L40
	mr 26,30
	mr 27,9
	addi 28,9,28
	lis 30,.LC25@ha
.L42:
	lwz 9,8(26)
	slwi 7,6,4
	addi 29,6,1
	mr 6,29
	add 7,7,28
	mr 3,31
	li 4,2
	mtlr 9
	la 5,.LC25@l(30)
	crxor 6,6,6
	blrl
	lwz 0,24(27)
	mr 6,29
	cmpw 0,6,0
	bc 12,0,.L42
.L40:
	lis 9,gi@ha
	lis 5,.LC26@ha
	la 30,gi@l(9)
	la 5,.LC26@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 29,maplist@ha
	lis 5,.LC27@ha
	la 29,maplist@l(29)
	la 5,.LC27@l(5)
	mr 3,31
	li 4,2
	lbz 6,1052(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lbz 0,1052(29)
	cmpwi 0,0,0
	bc 12,2,.L45
	cmpwi 0,0,1
	bc 12,2,.L46
	b .L47
.L45:
	lwz 0,8(30)
	lis 5,.LC28@ha
	mr 3,31
	la 5,.LC28@l(5)
	b .L51
.L46:
	lwz 0,8(30)
	lis 5,.LC29@ha
	mr 3,31
	la 5,.LC29@l(5)
.L51:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L44
.L47:
	lis 9,gi+8@ha
	lis 5,.LC30@ha
	lwz 0,gi+8@l(9)
	la 5,.LC30@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L44:
	lis 9,maplist@ha
	la 9,maplist@l(9)
	lwz 6,1056(9)
	cmpwi 0,6,-1
	bc 4,2,.L49
	lis 9,gi+8@ha
	lis 5,.LC31@ha
	lwz 0,gi+8@l(9)
	la 5,.LC31@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L50
.L49:
	addi 0,9,28
	slwi 7,6,4
	lis 9,gi+8@ha
	lis 5,.LC32@ha
	lwz 9,gi+8@l(9)
	add 7,7,0
	la 5,.LC32@l(5)
	addi 6,6,1
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L50:
	lis 9,gi+8@ha
	lis 5,.LC6@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC6@l(5)
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
.LC33:
	.string	"*** No MAPLIST active ***\n"
	.align 2
.LC34:
	.string	"HELP"
	.align 2
.LC35:
	.string	"MAPLIST options locked by server.\n"
	.align 2
.LC36:
	.string	"START"
	.align 2
.LC37:
	.string	"NEXT"
	.align 2
.LC38:
	.string	"OFF"
	.align 2
.LC39:
	.string	"GOTO"
	.align 2
.LC40:
	.string	"*** Map# out of range ***\n"
	.align 2
.LC41:
	.string	"target_changelevel"
	.align 2
.LC42:
	.string	"You must disable current maplist first. (SV MAPLIST OFF)\n"
	.align 2
.LC43:
	.string	"Maplist created/enabled. You can now use START or NEXT.\n"
	.align 3
.LC44:
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
	bc 12,2,.L64
	bc 12,1,.L96
	cmpwi 0,3,2
	bc 12,2,.L91
	b .L94
.L96:
	cmpwi 0,3,4
	bc 12,2,.L79
	b .L94
.L64:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC34@ha
	la 4,.LC34@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L92
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC36@ha
	la 4,.LC36@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L66
	lis 9,maplist+24@ha
	lwz 0,maplist+24@l(9)
	cmpwi 0,0,0
	bc 12,1,.L97
	b .L92
.L66:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L70
	lis 9,maplist+24@ha
	lwz 0,maplist+24@l(9)
	cmpwi 0,0,0
	bc 4,1,.L92
.L97:
	bl EndDMLevel
	b .L63
.L70:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L74
	lis 9,maplist@ha
	la 9,maplist@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,1,.L92
	lis 10,dmflags@ha
	stw 3,24(9)
	lis 0,0x4330
	lwz 8,dmflags@l(10)
	lis 3,.LC12@ha
	mr 11,9
	lis 10,.LC44@ha
	lfs 0,20(8)
	la 10,.LC44@l(10)
	la 3,.LC12@l(3)
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
	b .L98
.L74:
	lis 9,maplist+1052@ha
	li 0,0
	stb 0,maplist+1052@l(9)
.L79:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,4
	bc 4,2,.L80
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
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L81
	cmpwi 0,31,0
	bc 4,1,.L83
	lis 9,maplist@ha
	la 30,maplist@l(9)
	lwz 0,24(30)
	cmpw 0,31,0
	bc 4,1,.L82
.L83:
	lwz 0,4(29)
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L99
.L82:
	bl G_Spawn
	addi 10,30,12
	lis 9,.LC41@ha
	slwi 0,31,4
	mr 11,3
	add 0,0,10
	la 9,.LC41@l(9)
	stw 9,284(11)
	addi 10,31,-1
	stw 0,508(11)
	stw 10,1056(30)
	bl BeginIntermission
	b .L63
.L81:
	cmplwi 0,31,1
	bc 12,1,.L92
	lwz 0,160(29)
	li 3,3
	mtlr 0
	blrl
	bl atoi
	lis 9,maplist+1052@ha
	stb 3,maplist+1052@l(9)
.L80:
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
	bc 12,2,.L88
	lwz 0,4(31)
	lis 3,.LC42@ha
	la 3,.LC42@l(3)
.L98:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L63
.L88:
	bl LoadMapList
	cmpwi 0,3,0
	bc 12,2,.L63
	lwz 10,dmflags@l(30)
	lis 0,0x4330
	mr 11,9
	lis 8,.LC44@ha
	lfs 0,20(10)
	la 8,.LC44@l(8)
	lis 3,.LC43@ha
	lfd 12,0(8)
	la 3,.LC43@l(3)
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
	lis 9,maplist+1056@ha
	li 0,-1
	stw 0,maplist+1056@l(9)
	b .L63
.L91:
	lis 9,maplist+24@ha
	lwz 0,maplist+24@l(9)
	cmpwi 0,0,0
	bc 4,1,.L92
.L99:
	li 3,0
	bl ShowCurrentMaplist
	b .L63
.L92:
	li 3,0
	bl DisplayMaplistUsage
	b .L63
.L94:
	li 3,0
	bl DisplayMaplistUsage
.L63:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Svcmd_Maplist_f,.Lfe4-Svcmd_Maplist_f
	.comm	is_silenced,1,1
	.align 2
	.globl DDay_OpenFile
	.type	 DDay_OpenFile,@function
DDay_OpenFile:
	stwu 1,-272(1)
	mflr 0
	stw 31,268(1)
	stw 0,276(1)
	lis 9,.LC0@ha
	addi 31,1,8
	lwz 11,.LC0@l(9)
	mr 4,3
	la 9,.LC0@l(9)
	mr 3,31
	lhz 0,4(9)
	stw 11,8(1)
	sth 0,4(31)
	bl strcat
	lis 4,.LC1@ha
	mr 3,31
	la 4,.LC1@l(4)
	bl fopen
	mr. 3,3
	bc 4,2,.L100
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
.L100:
	lwz 0,276(1)
	mtlr 0
	lwz 31,268(1)
	la 1,272(1)
	blr
.Lfe5:
	.size	 DDay_OpenFile,.Lfe5-DDay_OpenFile
	.align 2
	.globl DDay_CloseFile
	.type	 DDay_CloseFile,@function
DDay_CloseFile:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 3,3
	bc 12,2,.L9
	bl fclose
	b .L10
.L9:
	lis 9,gi+4@ha
	lis 3,.LC3@ha
	lwz 0,gi+4@l(9)
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L10:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 DDay_CloseFile,.Lfe6-DDay_CloseFile
	.comm	maplist,1060,4
	.section	".rodata"
	.align 3
.LC45:
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
	lis 3,.LC12@ha
	stw 0,maplist+24@l(10)
	la 3,.LC12@l(3)
	lfs 0,20(8)
	mr 11,9
	lis 0,0x4330
	lis 10,.LC45@ha
	la 10,.LC45@l(10)
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
.Lfe7:
	.size	 ClearMapList,.Lfe7-ClearMapList
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
	bc 12,2,.L54
	cmpwi 0,3,2
	bc 12,2,.L57
	b .L60
.L54:
	lis 9,maplist+24@ha
	lwz 0,maplist+24@l(9)
	cmpwi 0,0,0
	bc 4,1,.L55
	mr 3,31
	bl ShowCurrentMaplist
	b .L53
.L55:
	lwz 0,8(30)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L101
.L57:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 4,.LC34@ha
	la 4,.LC34@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L58
.L101:
	mr 3,31
	bl DisplayMaplistUsage
	b .L53
.L58:
	lwz 0,8(30)
	lis 5,.LC35@ha
	mr 3,31
	la 5,.LC35@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L53
.L60:
	mr 3,31
	bl DisplayMaplistUsage
.L53:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Maplist_f,.Lfe8-Cmd_Maplist_f
	.comm	team_list,8,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
