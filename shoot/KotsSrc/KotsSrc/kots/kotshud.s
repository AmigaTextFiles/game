	.file	"kotshud.cpp"
gcc2_compiled.:
	.globl kots_statusbar
	.section	".rodata"
	.align 2
.LC0:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif if 4 \txv\t185 \trnum \txv\t235 \tpic 4 en"
	.ascii	"dif if 23  xr -75  num 3 23 \txr -25 \tpic 6 endif yb\t-50 i"
	.ascii	"f 9  xr -75  num 3 10 \txr -25  pic 9 endif if 11 xv 148 pic"
	.ascii	" 11 endif xr\t-32 yt 2 string \"Game\" xr\t-50 yt 10 num 3 1"
	.ascii	"4 yt 40 xr -32 string \"Rank\" yt 48 xr\t-50 num 3 21 yt 73 "
	.ascii	"xr -40 string \"Spree\" yt 81 xr\t-50 num 3 "
	.string	"25 yb -85 xr -24 string \"Lvl\" yb -77 xr\t-50 num 3 20 if 24 yb -118 xr -32 string \"H-ID\" yb -110 xr -50 num 3 24 endif if 18  yb\t-50 \txl\t0  num 2 19 \txl\t34 \tyb\t-35 \tstat_string 18 \tyb\t-100 endif if 16 xl 0 yb -35 string \"Chasing\" xl 64 stat_string 16 endif "
	.section	".sdata","aw"
	.align 2
	.type	 kots_statusbar,@object
	.size	 kots_statusbar,4
kots_statusbar:
	.long .LC0
	.section	".rodata"
	.align 2
.LC1:
	.string	"your vote has been registered.\n"
	.globl votemenu
	.section	".data"
	.align 2
	.type	 votemenu,@object
	.size	 votemenu,960
votemenu:
	.string	"*Norb & Mother's"
	.space	33
	.space	2
	.long 1
	.long 0
	.long 0
	.string	"*King of the Servers"
	.space	29
	.space	2
	.long 1
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Vote for the next map"
	.space	28
	.space	2
	.long 1
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"1. "
	.space	46
	.space	2
	.long 0
	.long 1
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"2. "
	.space	46
	.space	2
	.long 0
	.long 2
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"3. "
	.space	46
	.space	2
	.long 0
	.long 3
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"4. "
	.space	46
	.space	2
	.long 0
	.long 4
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"5. "
	.space	46
	.space	2
	.long 0
	.long 5
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"6. "
	.space	46
	.space	2
	.long 0
	.long 6
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"7. "
	.space	46
	.space	2
	.long 0
	.long 7
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"8. "
	.space	46
	.space	2
	.long 0
	.long 8
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"9. "
	.space	46
	.space	2
	.long 0
	.long 9
	.long KOTSVote__FP7edict_sP5SMenu
	.string	"10. "
	.space	45
	.space	2
	.long 0
	.long 10
	.long KOTSVote__FP7edict_sP5SMenu
	.section	".rodata"
	.align 2
.LC2:
	.string	" ,\n\r"
	.section	".sdata","aw"
	.align 2
	.type	 seps.12,@object
	.size	 seps.12,4
seps.12:
	.long .LC2
	.section	".rodata"
	.align 2
.LC3:
	.string	"no maps to vote on.\n"
	.align 2
.LC4:
	.string	"%d: %s"
	.section	".text"
	.align 2
	.globl KOTSCmd_Vote_f
	.type	 KOTSCmd_Vote_f,@function
KOTSCmd_Vote_f:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	li 29,5
	bl KOTSGetUser__FP7edict_s
	cmpwi 0,3,0
	bc 12,2,.L13
	lwz 9,84(30)
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L15
	mr 3,30
	bl PMenu_Close
	b .L13
.L15:
	lis 28,sv_maplist@ha
	lwz 9,sv_maplist@l(28)
	lwz 3,4(9)
	bl strlen
	cmplwi 0,3,1
	bc 12,1,.L16
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC3@l(5)
	li 4,2
	b .L23
.L16:
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 4,2,.L17
	lwz 9,160(31)
	li 3,1
	mtlr 9
	blrl
	bl atoi
	stw 3,892(30)
	lis 5,.LC1@ha
	li 4,2
	lwz 0,8(31)
	mr 3,30
	la 5,.LC1@l(5)
.L23:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L13
.L17:
	lwz 9,sv_maplist@l(28)
	lis 26,seps.12@ha
	lwz 3,4(9)
	bl strdup
	lis 9,seps.12@ha
	mr 28,3
	lwz 4,seps.12@l(9)
	bl strtok
	mr. 3,3
	bc 12,2,.L19
	lis 9,votemenu@ha
	lis 27,.LC4@ha
	la 9,votemenu@l(9)
	addi 31,9,320
.L20:
	mr 6,3
	addi 5,29,-4
	mr 3,31
	la 4,.LC4@l(27)
	crxor 6,6,6
	bl sprintf
	addi 29,29,1
	addi 31,31,64
	lwz 4,seps.12@l(26)
	li 3,0
	bl strtok
	cmpwi 7,29,14
	addic 0,3,-1
	subfe 9,0,3
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 11,9,0
	bc 4,2,.L20
.L19:
	mr 3,28
	bl free
	lis 4,votemenu@ha
	mr 3,30
	la 4,votemenu@l(4)
	mr 6,29
	li 5,0
	bl PMenu_Open__FP7edict_sP5SMenuii
.L13:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 KOTSCmd_Vote_f,.Lfe1-KOTSCmd_Vote_f
	.globl infomenu
	.section	".data"
	.align 2
	.type	 infomenu,@object
	.size	 infomenu,1088
infomenu:
	.string	"*Norb & Mother's"
	.space	33
	.space	2
	.long 1
	.long 0
	.long 0
	.string	"*King of the Servers"
	.space	29
	.space	2
	.long 1
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Name"
	.space	45
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Level"
	.space	44
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Rank"
	.space	45
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Score"
	.space	44
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Points"
	.space	43
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Hole"
	.space	45
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Frags"
	.space	44
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Shots"
	.space	44
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Hits"
	.space	45
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Accuracy"
	.space	41
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Spree"
	.space	44
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"(TAB to Return)"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.space	46
	.space	14
	.section	".rodata"
	.align 2
.LC5:
	.string	"Name    : %s"
	.align 2
.LC6:
	.string	"Level   : %d"
	.align 2
.LC7:
	.string	"Rank    : %d/%d"
	.align 2
.LC8:
	.string	"Score   : %d"
	.align 2
.LC9:
	.string	"Points  : %d"
	.align 2
.LC10:
	.string	"Hole    : %d"
	.align 2
.LC11:
	.string	"Frags   : %d"
	.align 2
.LC12:
	.string	"Shots   : %d"
	.align 2
.LC13:
	.string	"Hits    : %d"
	.align 2
.LC14:
	.string	"Accuracy: %3.2f%%"
	.align 2
.LC15:
	.string	"Spree   : %d"
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC17:
	.long 0x42c80000
	.align 2
.LC18:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSCmd_Info_f
	.type	 KOTSCmd_Info_f,@function
KOTSCmd_Info_f:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
	stw 0,116(1)
	mr 31,3
	li 30,1
	li 27,1
	bl KOTSGetUser__FP7edict_s
	mr. 28,3
	bc 12,2,.L24
	lwz 11,84(31)
	lwz 0,3932(11)
	cmpwi 0,0,0
	bc 12,2,.L26
	mr 3,31
	bl PMenu_Close
	b .L24
.L26:
	lis 9,game@ha
	li 26,3
	la 10,game@l(9)
	addi 5,28,8
	lwz 0,1544(10)
	cmpwi 0,0,0
	bc 4,1,.L28
	lis 9,g_edicts@ha
	mr 4,11
	mtctr 0
	lwz 11,g_edicts@l(9)
	mr 3,10
	li 6,0
	addi 7,11,976
.L30:
	lwz 0,88(7)
	cmpwi 0,0,0
	bc 12,2,.L29
	cmpw 0,7,31
	bc 12,2,.L29
	lwz 11,1028(3)
	addi 8,30,1
	addi 27,27,1
	lwz 10,3560(4)
	add 11,6,11
	lwz 9,3560(11)
	cmpw 7,10,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 8,8,0
	and 0,30,0
	or 30,0,8
.L29:
	addi 6,6,3964
	addi 7,7,976
	bdnz .L30
.L28:
	lis 4,.LC5@ha
	addi 3,1,8
	la 4,.LC5@l(4)
	crxor 6,6,6
	bl sprintf
	lis 29,infomenu@ha
	slwi 3,26,6
	la 29,infomenu@l(29)
	addi 4,1,8
	add 3,3,29
	li 26,12
	bl strcpy
	li 4,0
	mr 3,28
	bl Level__5CUserPl
	mr 5,3
	lis 4,.LC6@ha
	addi 3,1,8
	la 4,.LC6@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,8
	addi 3,29,256
	bl strcpy
	lis 4,.LC7@ha
	mr 6,27
	addi 3,1,8
	mr 5,30
	la 4,.LC7@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,8
	addi 3,29,320
	bl strcpy
	li 4,0
	mr 3,28
	bl Score__5CUserl
	mr 5,3
	lis 4,.LC8@ha
	addi 3,1,8
	la 4,.LC8@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,8
	addi 3,29,384
	bl strcpy
	lwz 5,200(28)
	lis 4,.LC9@ha
	addi 3,1,8
	la 4,.LC9@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,8
	addi 3,29,448
	bl strcpy
	lwz 5,240(28)
	lis 4,.LC10@ha
	addi 3,1,8
	la 4,.LC10@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,8
	addi 3,29,512
	bl strcpy
	lwz 5,920(31)
	lis 4,.LC11@ha
	addi 3,1,8
	la 4,.LC11@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,8
	addi 3,29,576
	bl strcpy
	lwz 5,916(31)
	lis 4,.LC12@ha
	addi 3,1,8
	la 4,.LC12@l(4)
	crxor 6,6,6
	bl sprintf
	addi 4,1,8
	addi 3,29,640
	bl strcpy
	lwz 5,924(31)
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	crxor 6,6,6
	bl sprintf
	addi 3,29,704
	addi 4,1,8
	bl strcpy
	lwz 8,916(31)
	cmpwi 0,8,0
	bc 4,1,.L35
	lwz 0,924(31)
	lis 10,0x4330
	mr 11,9
	xoris 8,8,0x8000
	xoris 0,0,0x8000
	lis 7,.LC16@ha
	stw 0,84(1)
	la 7,.LC16@l(7)
	stw 10,80(1)
	lfd 13,80(1)
	stw 8,84(1)
	stw 10,80(1)
	lfd 12,0(7)
	lfd 0,80(1)
	lis 7,.LC17@ha
	la 7,.LC17@l(7)
	fsub 13,13,12
	lfs 11,0(7)
	fsub 0,0,12
	frsp 13,13
	frsp 0,0
	fdivs 1,13,0
	fmuls 1,1,11
	b .L36
.L35:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 1,0(9)
.L36:
	lis 4,.LC14@ha
	addi 3,1,8
	la 4,.LC14@l(4)
	creqv 6,6,6
	bl sprintf
	lis 29,infomenu@ha
	slwi 3,26,6
	la 29,infomenu@l(29)
	addi 4,1,8
	add 3,3,29
	addi 26,26,1
	bl strcpy
	lwz 9,84(31)
	lis 4,.LC15@ha
	addi 3,1,8
	la 4,.LC15@l(4)
	lwz 5,1860(9)
	crxor 6,6,6
	bl sprintf
	slwi 3,26,6
	addi 4,1,8
	add 3,3,29
	bl strcpy
	mr 3,31
	mr 4,29
	li 5,0
	li 6,17
	bl PMenu_Open__FP7edict_sP5SMenuii
.L24:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe2:
	.size	 KOTSCmd_Info_f,.Lfe2-KOTSCmd_Info_f
	.align 2
	.globl KOTSTeam__FP7edict_s
	.type	 KOTSTeam__FP7edict_s,@function
KOTSTeam__FP7edict_s:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	addi 29,1,8
	mr 31,3
	mr 3,29
	li 4,0
	li 5,8
	bl memset
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,0
	bc 4,1,.L40
	lis 9,g_edicts@ha
	mtctr 0
	mr 10,29
	lwz 11,g_edicts@l(9)
	addi 11,11,976
.L42:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L41
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 12,2,.L41
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 12,2,.L41
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L41
	lwz 0,3584(9)
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L41:
	addi 11,11,976
	bdnz .L42
.L40:
	lwz 9,4(29)
	lwz 0,8(1)
	cmpw 0,9,0
	bc 4,0,.L48
	lwz 9,84(31)
	li 0,1
	b .L51
.L48:
	lwz 9,84(31)
	li 0,0
.L51:
	stw 0,3584(9)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 KOTSTeam__FP7edict_s,.Lfe3-KOTSTeam__FP7edict_s
	.section	".rodata"
	.align 2
.LC19:
	.string	"%s Joins Team %s\n"
	.align 2
.LC20:
	.string	"You are on the %s Team\n"
	.align 2
.LC21:
	.string	"%s Starts Their Reign\n"
	.globl helpmenu
	.section	".data"
	.align 2
	.type	 helpmenu,@object
	.size	 helpmenu,1088
helpmenu:
	.string	"*King of the Server"
	.space	30
	.space	2
	.long 1
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"At the console type:"
	.space	29
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"set kots_password yp u"
	.space	27
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Replace yp with"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"your own unique password."
	.space	24
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"type it twice."
	.space	35
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Select Start Reign."
	.space	30
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Back"
	.space	45
	.space	2
	.long 0
	.long 0
	.long KOTSBack__FP7edict_sP5SMenu
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"ENTER to select"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"ESC to Exit Menu"
	.space	33
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"(TAB to Return)"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.globl creditmenu
	.align 2
	.type	 creditmenu,@object
	.size	 creditmenu,1024
creditmenu:
	.string	"*King of the Server"
	.space	30
	.space	2
	.long 1
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Code:    norb"
	.space	36
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Code:    mother"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Artwork: bork"
	.space	36
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Website: bork"
	.space	36
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"Testing: soul"
	.space	36
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Back"
	.space	45
	.space	2
	.long 0
	.long 0
	.long KOTSBack__FP7edict_sP5SMenu
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Use [ and ] to move cursor"
	.space	23
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"ENTER to select"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"ESC to Exit Menu"
	.space	33
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"(TAB to Return)"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"vkotsv525"
	.space	40
	.space	2
	.long 2
	.long 0
	.long 0
	.globl joinmenu
	.align 2
	.type	 joinmenu,@object
	.size	 joinmenu,1024
joinmenu:
	.string	"*Quake II"
	.space	40
	.space	2
	.long 1
	.long 0
	.long 0
	.string	"*Norb & Mother's"
	.space	33
	.space	2
	.long 1
	.long 0
	.long 0
	.string	"*King of the Server"
	.space	30
	.space	2
	.long 1
	.long 0
	.long 0
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.byte 0
	.byte 1
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Start your Reign"
	.space	33
	.space	2
	.long 0
	.long 0
	.long KOTSJoin__FP7edict_sP5SMenu
	.string	"Help"
	.space	45
	.space	2
	.long 0
	.long 0
	.long KOTSHelp__FP7edict_sP5SMenu
	.string	"Chase Camera"
	.space	37
	.space	2
	.long 0
	.long 0
	.long KOTSChaseCam__FP7edict_sP5SMenu
	.string	"Credits"
	.space	42
	.space	2
	.long 0
	.long 0
	.long KOTSCredits__FP7edict_sP5SMenu
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"Use [ and ] to move cursor"
	.space	23
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"ENTER to select"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"ESC to Exit Menu"
	.space	33
	.space	2
	.long 0
	.long 0
	.long 0
	.string	"(TAB to Return)"
	.space	34
	.space	2
	.long 0
	.long 0
	.long 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.space	46
	.space	14
	.string	"vkotsv525"
	.space	40
	.space	2
	.long 2
	.long 0
	.long 0
	.lcomm	levelname.37,32,4
	.section	".rodata"
	.align 2
.LC22:
	.string	"Leave Chase Camera"
	.align 2
.LC23:
	.string	"Chase Camera"
	.align 2
.LC24:
	.string	"Join KOTS Teamplay"
	.align 2
.LC25:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSUpdateJoinMenu__FP7edict_s
	.type	 KOTSUpdateJoinMenu__FP7edict_s,@function
KOTSUpdateJoinMenu__FP7edict_s:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3920(9)
	cmpwi 0,0,0
	bc 12,2,.L73
	lis 10,.LC22@ha
	lis 8,joinmenu+448@ha
	lwz 4,.LC22@l(10)
	la 9,.LC22@l(10)
	la 11,joinmenu+448@l(8)
	lbz 0,18(9)
	lwz 10,4(9)
	lwz 7,8(9)
	lwz 6,12(9)
	lhz 5,16(9)
	stw 4,joinmenu+448@l(8)
	stb 0,18(11)
	stw 10,4(11)
	stw 7,8(11)
	stw 6,12(11)
	sth 5,16(11)
	b .L74
.L73:
	lis 10,.LC23@ha
	lis 7,joinmenu+448@ha
	lwz 6,.LC23@l(10)
	la 9,.LC23@l(10)
	la 11,joinmenu+448@l(7)
	lbz 0,12(9)
	lwz 10,4(9)
	lwz 8,8(9)
	stw 6,joinmenu+448@l(7)
	stb 0,12(11)
	stw 10,4(11)
	stw 8,8(11)
.L74:
	lis 9,kots_teamplay@ha
	lis 11,levelname.37@ha
	lwz 10,kots_teamplay@l(9)
	li 0,42
	la 3,levelname.37@l(11)
	lis 9,.LC25@ha
	stb 0,levelname.37@l(11)
	la 9,.LC25@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L75
	lis 10,.LC24@ha
	lis 8,joinmenu+320@ha
	lwz 4,.LC24@l(10)
	la 9,.LC24@l(10)
	la 11,joinmenu+320@l(8)
	lbz 0,18(9)
	lwz 10,4(9)
	lwz 7,8(9)
	lwz 6,12(9)
	lhz 5,16(9)
	stw 4,joinmenu+320@l(8)
	stb 0,18(11)
	stw 10,4(11)
	stw 7,8(11)
	stw 6,12(11)
	sth 5,16(11)
.L75:
	lis 9,g_edicts@ha
	lwz 11,g_edicts@l(9)
	lwz 4,276(11)
	cmpwi 0,4,0
	bc 12,2,.L76
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L77
.L76:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L77:
	lis 4,levelname.37@ha
	li 0,0
	la 4,levelname.37@l(4)
	lis 3,joinmenu+192@ha
	stb 0,31(4)
	la 3,joinmenu+192@l(3)
	bl strcpy
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 KOTSUpdateJoinMenu__FP7edict_s,.Lfe4-KOTSUpdateJoinMenu__FP7edict_s
	.section	".rodata"
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC27:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.type	 loc_CanSee__FP7edict_sT0,@function
loc_CanSee__FP7edict_sT0:
	stwu 1,-304(1)
	mflr 0
	stfd 31,296(1)
	stmw 24,264(1)
	stw 0,308(1)
	lwz 0,260(3)
	mr 30,4
	cmpwi 0,0,2
	bc 4,2,.L86
	b .L98
.L97:
	li 3,1
	b .L96
.L86:
	mr 10,3
	lfs 12,188(3)
	addi 11,3,188
	lfsu 9,4(10)
	addi 8,3,200
	lis 9,.LC26@ha
	lfs 7,200(3)
	la 9,.LC26@l(9)
	lfd 6,0(9)
	lis 6,0x4330
	addi 26,1,168
	fadds 8,9,12
	lis 9,gi@ha
	lis 25,vec3_origin@ha
	fadds 9,9,7
	la 24,gi@l(9)
	addi 27,1,8
	lis 9,.LC27@ha
	addi 29,1,184
	stfs 8,72(1)
	fsubs 12,8,12
	la 9,.LC27@l(9)
	addi 31,1,72
	lfs 0,4(11)
	fsubs 5,9,7
	addi 28,1,156
	lfs 11,4(10)
	fsubs 7,8,7
	lfd 31,0(9)
	fadds 11,11,0
	stfs 11,76(1)
	lfs 0,8(11)
	lfs 10,8(10)
	stfs 11,100(1)
	stfs 11,88(1)
	fadds 10,10,0
	stfs 12,84(1)
	stfs 8,96(1)
	stfs 10,80(1)
	stfs 10,92(1)
	stfs 10,104(1)
	lfs 13,4(11)
	stfs 11,112(1)
	stfs 10,116(1)
	fsubs 13,11,13
	stfs 12,108(1)
	stfs 13,100(1)
	lfs 0,4(11)
	stfs 9,120(1)
	fsubs 0,11,0
	stfs 0,112(1)
	lfs 0,4(8)
	lfs 13,4(10)
	fadds 13,13,0
	stfs 13,124(1)
	lfs 12,8(8)
	lfs 0,8(10)
	stfs 13,136(1)
	stfs 5,132(1)
	fadds 0,0,12
	stfs 0,140(1)
	stfs 0,128(1)
	stfs 8,144(1)
	lwz 0,508(30)
	stfs 11,148(1)
	xoris 0,0,0x8000
	stfs 10,152(1)
	stw 0,260(1)
	lfs 13,4(8)
	stw 6,256(1)
	lfd 0,256(1)
	fsubs 13,11,13
	stfs 11,160(1)
	stfs 10,164(1)
	stfs 7,156(1)
	fsub 0,0,6
	lfs 12,12(30)
	stfs 13,148(1)
	lfs 13,4(8)
	frsp 0,0
	lfs 9,4(30)
	lfs 10,8(30)
	fsubs 11,11,13
	fadds 12,12,0
	stfs 9,168(1)
	stfs 10,172(1)
	stfs 11,160(1)
	stfs 12,176(1)
.L92:
	lwz 11,48(24)
	la 5,vec3_origin@l(25)
	mr 3,29
	mr 6,5
	mr 4,26
	mr 7,31
	mr 8,30
	mtlr 11
	li 9,3
	blrl
	mr 3,27
	mr 4,29
	li 5,56
	crxor 6,6,6
	bl memcpy
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 12,2,.L97
	addi 31,31,12
	cmpw 0,31,28
	bc 4,1,.L92
.L98:
	li 3,0
.L96:
	lwz 0,308(1)
	mtlr 0
	lmw 24,264(1)
	lfd 31,296(1)
	la 1,304(1)
	blr
.Lfe5:
	.size	 loc_CanSee__FP7edict_sT0,.Lfe5-loc_CanSee__FP7edict_sT0
	.section	".rodata"
	.align 3
.LC28:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC29:
	.long 0x0
	.align 2
.LC30:
	.long 0x44800000
	.align 2
.LC31:
	.long 0x3f800000
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 KOTSSetIDView__FP7edict_s,@function
KOTSSetIDView__FP7edict_s:
	stwu 1,-256(1)
	mflr 0
	stfd 29,232(1)
	stfd 30,240(1)
	stfd 31,248(1)
	stmw 23,196(1)
	stw 0,260(1)
	lis 9,.LC29@ha
	mr 31,3
	la 9,.LC29@l(9)
	lfs 29,0(9)
	bl KOTSGetUser__FP7edict_s
	mr. 23,3
	bc 12,2,.L99
	lwz 3,84(31)
	addi 29,1,104
	addi 4,1,8
	li 5,0
	li 6,0
	addi 3,3,3760
	bl AngleVectors
	lis 9,.LC30@ha
	addi 3,1,8
	la 9,.LC30@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lfs 12,4(31)
	lis 11,gi+48@ha
	li 9,3
	lfs 0,8(31)
	addi 7,1,8
	mr 8,31
	lfs 13,12(31)
	mr 3,29
	addi 4,31,4
	lfs 9,8(1)
	li 5,0
	li 6,0
	lfs 11,12(1)
	lfs 10,16(1)
	lwz 0,gi+48@l(11)
	fadds 12,12,9
	fadds 0,0,11
	fadds 13,13,10
	mtlr 0
	stfs 12,8(1)
	stfs 0,12(1)
	stfs 13,16(1)
	blrl
	mr 4,29
	addi 3,1,40
	li 5,56
	crxor 6,6,6
	bl memcpy
	lis 9,.LC31@ha
	lfs 13,48(1)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L101
	lwz 3,92(1)
	cmpwi 0,3,0
	bc 12,2,.L101
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L101
	bl KOTSGetUser__FP7edict_s
	mr. 29,3
	bc 12,2,.L99
	lwz 9,92(1)
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L99
	li 4,0
	mr 3,29
	bl Level__5CUserPl
	lwz 11,84(31)
	lis 9,g_edicts@ha
	lis 0,0xc10c
	lwz 10,g_edicts@l(9)
	ori 0,0,38677
	li 4,0
	sth 3,158(11)
	lwz 9,92(1)
	mr 3,23
	lwz 11,84(31)
	subf 9,10,9
	mullw 9,9,0
	srawi 9,9,4
	addi 9,9,1311
	sth 9,156(11)
	bl Level__5CUserPl
	cmpwi 0,3,5
	bc 4,1,.L99
	lwz 9,92(1)
	lwz 11,84(31)
	lhz 0,482(9)
	sth 0,168(11)
	b .L99
.L101:
	lwz 3,84(31)
	addi 4,1,8
	li 5,0
	li 6,0
	li 27,0
	addi 3,3,3760
	li 28,1
	bl AngleVectors
	lis 24,maxclients@ha
	lis 9,.LC31@ha
	lis 11,maxclients@ha
	la 9,.LC31@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L106
	lis 9,.LC32@ha
	lis 25,g_edicts@ha
	la 9,.LC32@l(9)
	lis 26,0x4330
	lfd 30,0(9)
	li 30,976
.L108:
	lwz 0,g_edicts@l(25)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L107
	lfs 0,4(31)
	addi 3,1,24
	lfs 13,4(29)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(29)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(29)
	fsubs 13,13,11
	stfs 13,32(1)
	bl VectorNormalize
	lfs 0,28(1)
	lfs 12,12(1)
	lfs 13,8(1)
	lfs 11,24(1)
	fmuls 12,12,0
	lfs 10,16(1)
	lfs 0,32(1)
	fmadds 13,13,11,12
	fmadds 31,10,0,13
	fcmpu 0,31,29
	bc 4,1,.L107
	mr 3,31
	mr 4,29
	bl loc_CanSee__FP7edict_sT0
	cmpwi 0,3,0
	bc 12,2,.L107
	fmr 29,31
	mr 27,29
.L107:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	addi 30,30,976
	stw 0,188(1)
	stw 26,184(1)
	lfd 0,184(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L108
.L106:
	lis 9,.LC28@ha
	fmr 13,29
	lfd 0,.LC28@l(9)
	fcmpu 0,13,0
	bc 4,1,.L99
	mr 3,27
	bl KOTSGetUser__FP7edict_s
	mr. 29,3
	bc 12,2,.L99
	lwz 0,480(27)
	cmpwi 0,0,0
	bc 4,1,.L99
	mr 3,23
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,5
	bc 4,1,.L115
	lwz 9,84(31)
	lhz 0,482(27)
	sth 0,168(9)
.L115:
	mr 3,29
	li 4,0
	bl Level__5CUserPl
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,84(31)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	sth 3,158(10)
	subf 9,9,27
	lwz 11,84(31)
	mullw 9,9,0
	srawi 9,9,4
	addi 9,9,1311
	sth 9,156(11)
.L99:
	lwz 0,260(1)
	mtlr 0
	lmw 23,196(1)
	lfd 29,232(1)
	lfd 30,240(1)
	lfd 31,248(1)
	la 1,256(1)
	blr
.Lfe6:
	.size	 KOTSSetIDView__FP7edict_s,.Lfe6-KOTSSetIDView__FP7edict_s
	.align 2
	.globl KOTSShowHUD
	.type	 KOTSShowHUD,@function
KOTSShowHUD:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 29,1
	bl KOTSGetUser__FP7edict_s
	lwz 11,84(31)
	li 0,0
	mr. 28,3
	sth 0,168(11)
	lwz 9,84(31)
	sth 0,156(9)
	lwz 11,84(31)
	sth 0,158(11)
	lwz 9,84(31)
	sth 0,162(9)
	lwz 11,84(31)
	sth 0,160(11)
	lwz 9,84(31)
	sth 0,166(9)
	lwz 11,84(31)
	sth 0,170(11)
	bc 12,2,.L117
	lwz 11,84(31)
	lis 9,game@ha
	la 10,game@l(9)
	sth 29,166(11)
	lwz 0,1544(10)
	cmpwi 0,0,0
	bc 4,1,.L120
	lis 9,g_edicts@ha
	mtctr 0
	mr 4,10
	lwz 11,g_edicts@l(9)
	li 5,0
	addi 6,11,976
.L122:
	lwz 0,88(6)
	cmpwi 0,0,0
	bc 12,2,.L121
	cmpw 0,6,31
	bc 12,2,.L121
	lwz 11,1028(4)
	addi 7,29,1
	lwz 10,84(31)
	add 11,5,11
	lwz 8,3560(10)
	lwz 9,3560(11)
	cmpw 7,8,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 7,7,0
	and 0,29,0
	or 29,0,7
.L121:
	addi 5,5,3964
	addi 6,6,976
	bdnz .L122
.L120:
	lwz 9,84(31)
	li 4,0
	mr 3,28
	lwz 30,736(9)
	addi 11,9,740
	slwi 0,30,2
	lwzx 30,11,0
	sth 29,162(9)
	bl Level__5CUserPl
	lwz 9,84(31)
	li 4,0
	sth 3,160(9)
	lwz 11,84(31)
	mr 3,28
	sth 30,166(11)
	lwz 9,84(31)
	lhz 0,1862(9)
	sth 0,170(9)
	bl Level__5CUserPl
	cmpwi 0,3,4
	bc 12,1,.L128
	mr 3,28
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,5
	bc 4,1,.L117
.L128:
	mr 3,31
	bl KOTSSetIDView__FP7edict_s
.L117:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 KOTSShowHUD,.Lfe7-KOTSShowHUD
	.section	".rodata"
	.align 2
.LC33:
	.string	"xv 5 yv 7 string2 \"Team 0: %d\" xv 133 yv 7 string2 \"Team 1: %d\" xv 5 yv 15 string2 \"Player\" xv 133 yv 15 string2 \"Game\" xv 173 yv 15 string2 \"Tm\" xv 197 yv 15 string2 \"Lvl\" xv 229 yv 15 string2 \"Png\" "
	.align 2
.LC34:
	.string	"xv 5 yv %d string2 \"%s\" xv 133 yv %i string \"%4i %2i %3i %3i\" "
	.section	".text"
	.align 2
	.globl KOTSTeamplayScoreboard__FP7edict_si
	.type	 KOTSTeamplayScoreboard__FP7edict_si,@function
KOTSTeamplayScoreboard__FP7edict_si:
	stwu 1,-4592(1)
	mflr 0
	stmw 20,4544(1)
	stw 0,4596(1)
	addi 29,1,4528
	mr 28,3
	mr 21,4
	li 5,8
	li 4,0
	mr 3,29
	bl memset
	li 27,0
	li 30,0
	mr 3,28
	bl PMenu_Close
	lis 9,game@ha
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,27,0
	bc 4,0,.L132
	lis 9,g_edicts@ha
	mr 24,11
	lwz 22,g_edicts@l(9)
	addi 23,1,3504
	mr 25,29
.L134:
	mulli 9,30,976
	addi 26,30,1
	addi 9,9,976
	add 3,22,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L133
	lwz 0,1028(24)
	mulli 9,30,3964
	li 5,0
	addi 31,1,3504
	cmpw 0,5,27
	lwz 3,84(3)
	addi 28,1,2480
	add 9,9,0
	addi 12,27,1
	lwz 4,3560(9)
	bc 4,0,.L137
	lwz 0,0(23)
	cmpw 0,4,0
	bc 12,1,.L137
	mr 9,31
.L138:
	addi 5,5,1
	cmpw 0,5,27
	bc 4,0,.L137
	lwzu 0,4(9)
	cmpw 0,4,0
	bc 4,1,.L138
.L137:
	lwz 9,3584(3)
	cmpw 0,27,5
	mr 6,27
	slwi 3,5,2
	slwi 9,9,2
	lwzx 0,9,25
	add 0,0,4
	stwx 0,9,25
	bc 4,1,.L143
	slwi 9,27,2
	mr 7,28
	mr 10,9
	mr 8,31
	addi 11,9,-4
.L145:
	lwzx 9,11,7
	addi 6,6,-1
	cmpw 0,6,5
	stwx 9,10,7
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L145
.L143:
	stwx 30,28,3
	mr 27,12
	stwx 4,31,3
.L133:
	lwz 0,1544(24)
	mr 30,26
	cmpw 0,30,0
	bc 12,0,.L134
.L132:
	cmpwi 0,21,0
	bc 12,2,.L148
	cmpwi 0,27,1
	bc 4,1,.L130
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,30,0
	bc 4,0,.L130
	mr 27,9
	lis 28,g_edicts@ha
	li 31,976
.L153:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L152
	lwz 9,84(3)
	lwz 11,3584(9)
	addic 10,11,-1
	subfe 10,10,10
	slwi 11,11,2
	rlwinm 10,10,0,29,29
	lwzx 9,11,29
	lwzx 0,10,29
	cmpw 0,9,0
	bc 4,1,.L152
	bl KOTSGetUser__FP7edict_s
.L152:
	lwz 0,1544(27)
	addi 30,30,1
	addi 31,31,976
	cmpw 0,30,0
	bc 12,0,.L153
	b .L130
.L148:
	lwz 7,4(29)
	lis 5,.LC33@ha
	li 4,1400
	addi 29,1,1072
	lwz 6,4528(1)
	la 5,.LC33@l(5)
	stb 21,1072(1)
	mr 3,29
	li 30,0
	crxor 6,6,6
	bl Com_sprintf
	mr 20,29
	mr 3,29
	bl strlen
	cmpw 0,30,27
	mr 25,3
	bc 4,0,.L161
	lis 9,game@ha
	lis 21,g_edicts@ha
	la 22,game@l(9)
	mr 23,20
	li 26,25
	li 24,0
.L163:
	lwz 10,1028(22)
	li 9,0
	addi 11,1,2480
	stb 9,48(1)
	lwzx 0,11,24
	lwz 9,g_edicts@l(21)
	mulli 3,0,976
	mulli 0,0,3964
	addi 3,3,976
	add 28,10,0
	add 3,9,3
	bl KOTSGetUser__FP7edict_s
	mr 29,3
	li 4,0
	addi 3,1,16
	li 5,20
	bl memset
	cmpwi 0,29,0
	bc 4,2,.L164
	addi 3,1,16
	addi 4,28,700
	li 5,15
	bl strncpy
	li 3,-1
	b .L165
.L164:
	addi 4,29,8
	li 5,15
	addi 3,1,16
	bl strncpy
	mr 3,29
	li 4,0
	bl Level__5CUserPl
.L165:
	lwz 0,3580(28)
	li 10,-1
	cmpwi 0,0,0
	bc 12,2,.L166
	lwz 10,3584(28)
.L166:
	lwz 9,3560(28)
	addi 31,1,48
	lis 5,.LC34@ha
	stw 3,8(1)
	la 5,.LC34@l(5)
	li 4,1024
	lwz 29,184(28)
	mr 3,31
	mr 6,26
	addi 7,1,16
	mr 8,26
	cmpwi 7,29,1000
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 11,0,0
	and 29,29,0
	andi. 11,11,999
	or 29,29,11
	stw 29,12(1)
	crxor 6,6,6
	bl Com_sprintf
	mr 3,31
	bl strlen
	add 3,25,3
	cmplwi 0,3,1024
	bc 12,1,.L161
	mr 4,31
	mr 3,23
	bl strcat
	addi 30,30,1
	addi 26,26,8
	mr 3,23
	addi 24,24,4
	bl strlen
	cmpw 0,30,27
	mr 25,3
	bc 12,0,.L163
.L161:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,20
	mtlr 0
	blrl
.L130:
	lwz 0,4596(1)
	mtlr 0
	lmw 20,4544(1)
	la 1,4592(1)
	blr
.Lfe8:
	.size	 KOTSTeamplayScoreboard__FP7edict_si,.Lfe8-KOTSTeamplayScoreboard__FP7edict_si
	.section	".rodata"
	.align 2
.LC35:
	.string	"xv 5 yv 15 string2 \"Player\" xv 128 yv 15 string2 \"Game\" xv 168 yv 15 string2 \"Lvl\" xv 200 yv 15 string2 \"Lives\" xv 248 yv 15 string2 \"Ping\" "
	.align 2
.LC36:
	.string	"xv 5 yv 15 string2 \"Player\" xv 133 yv 15 string2 \"Game\" xv 173 yv 15 string2 \"Lv\" xv 197 yv 15 string2 \"Frg\" xv 229 yv 15 string2 \"Png\" "
	.align 2
.LC37:
	.string	"xv 5 yv %d string2 \"%s\" xv 128 yv %i string \"%4i %3i %5i %4i\" "
	.align 2
.LC38:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSScoreboardMessage
	.type	 KOTSScoreboardMessage,@function
KOTSScoreboardMessage:
	stwu 1,-4592(1)
	mflr 0
	stmw 19,4540(1)
	stw 0,4596(1)
	lis 11,.LC38@ha
	lis 9,kots_teamplay@ha
	la 11,.LC38@l(11)
	mr 26,5
	lfs 13,0(11)
	li 27,0
	lwz 11,kots_teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L172
	mr 4,26
	bl KOTSTeamplayScoreboard__FP7edict_si
	b .L171
.L172:
	bl PMenu_Close
	li 28,0
	lis 9,game@ha
	cmpwi 7,26,0
	la 10,game@l(9)
	lwz 0,1544(10)
	cmpw 0,27,0
	bc 4,0,.L174
	lis 9,g_edicts@ha
	lis 11,kots_lives@ha
	lwz 22,g_edicts@l(9)
	mr 25,10
	addi 24,1,3504
	lis 9,.LC38@ha
	lwz 23,kots_lives@l(11)
	la 9,.LC38@l(9)
	lfs 13,0(9)
.L176:
	mulli 9,28,976
	addi 8,28,1
	addi 9,9,976
	add 29,22,9
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L175
	lfs 0,20(23)
	fcmpu 0,0,13
	bc 12,2,.L178
	lwz 3,928(29)
	b .L179
.L178:
	lwz 0,1028(25)
	mulli 9,28,3964
	add 9,9,0
	lwz 3,3560(9)
.L179:
	li 29,0
	addi 31,1,3504
	cmpw 0,29,27
	addi 12,1,2480
	addi 30,27,1
	addi 8,28,1
	bc 4,0,.L181
	lwz 0,0(24)
	cmpw 0,3,0
	bc 12,1,.L181
	mr 9,31
.L182:
	addi 29,29,1
	cmpw 0,29,27
	bc 4,0,.L181
	lwzu 0,4(9)
	cmpw 0,3,0
	bc 4,1,.L182
.L181:
	cmpw 0,27,29
	mr 5,27
	slwi 10,29,2
	bc 4,1,.L187
	slwi 9,27,2
	mr 4,12
	mr 7,9
	mr 6,31
	addi 11,9,-4
.L189:
	lwzx 9,11,4
	addi 5,5,-1
	cmpw 0,5,29
	stwx 9,7,4
	lwzx 0,11,6
	addi 11,11,-4
	stwx 0,7,6
	addi 7,7,-4
	bc 12,1,.L189
.L187:
	stwx 28,12,10
	mr 27,30
	stwx 3,31,10
.L175:
	lwz 0,1544(25)
	mr 28,8
	cmpw 0,28,0
	bc 12,0,.L176
.L174:
	bc 12,30,.L192
	cmpwi 0,27,1
	bc 4,1,.L171
	lwz 9,2480(1)
	lis 11,g_edicts@ha
	lwz 10,g_edicts@l(11)
	mulli 9,9,976
	addi 9,9,976
	add 29,10,9
	lwz 0,928(29)
	cmpwi 0,0,0
	bc 4,1,.L171
	mr 3,29
	bl KOTSGetUser__FP7edict_s
	mr. 31,3
	bc 12,2,.L171
	lis 9,.LC38@ha
	lis 11,kots_lives@ha
	la 9,.LC38@l(9)
	lfs 13,0(9)
	lwz 9,kots_lives@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L196
	slwi 0,27,2
	add 4,0,27
	b .L197
.L196:
	cmpwi 7,27,8
	addi 9,27,20
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	andc 9,9,0
	and 0,27,0
	or 4,0,9
.L197:
	mr 3,31
	li 5,5
	bl ModScore__5CUserli
	b .L171
.L192:
	lis 9,.LC38@ha
	lis 11,kots_lives@ha
	stb 26,1072(1)
	la 9,.LC38@l(9)
	lis 19,kots_lives@ha
	lfs 13,0(9)
	lwz 9,kots_lives@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L199
	addi 0,1,1072
	lis 5,.LC35@ha
	la 5,.LC35@l(5)
	mr 3,0
	li 4,1400
	mr 22,0
	crxor 6,6,6
	bl Com_sprintf
	b .L200
.L199:
	addi 0,1,1072
	lis 5,.LC36@ha
	la 5,.LC36@l(5)
	mr 3,0
	li 4,1400
	mr 22,0
	crxor 6,6,6
	bl Com_sprintf
.L200:
	mr 3,22
	li 28,0
	bl strlen
	cmpw 0,28,27
	mr 25,3
	bc 4,0,.L202
	lis 9,game@ha
	lis 20,g_edicts@ha
	la 21,game@l(9)
	mr 23,22
	li 26,25
	li 24,0
.L204:
	li 9,0
	addi 11,1,2480
	lwz 8,g_edicts@l(20)
	stb 9,48(1)
	lwzx 0,11,24
	lwz 10,1028(21)
	mulli 9,0,976
	mulli 0,0,3964
	addi 9,9,976
	add 29,8,9
	add 30,10,0
	mr 3,29
	bl KOTSGetUser__FP7edict_s
	mr 31,3
	li 4,0
	addi 3,1,16
	li 5,20
	bl memset
	cmpwi 0,31,0
	bc 4,2,.L205
	addi 3,1,16
	addi 4,30,700
	li 5,15
	bl strncpy
	li 3,0
	b .L206
.L205:
	addi 4,31,8
	li 5,15
	addi 3,1,16
	bl strncpy
	mr 3,31
	li 4,0
	bl Level__5CUserPl
.L206:
	lwz 9,kots_lives@l(19)
	lis 11,.LC38@ha
	la 11,.LC38@l(11)
	lfs 13,0(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L207
	lwz 0,928(29)
	mr 10,3
	lis 5,.LC37@ha
	lwz 9,3560(30)
	addi 3,1,48
	la 5,.LC37@l(5)
	stw 0,8(1)
	li 4,1024
	mr 6,26
	lwz 29,184(30)
	addi 7,1,16
	mr 8,26
	mr 31,3
	cmpwi 7,29,1000
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 11,0,0
	and 29,29,0
	andi. 11,11,999
	or 29,29,11
	stw 29,12(1)
	crxor 6,6,6
	bl Com_sprintf
	b .L209
.L207:
	lwz 0,920(29)
	mr 10,3
	lis 5,.LC34@ha
	lwz 9,3560(30)
	addi 3,1,48
	la 5,.LC34@l(5)
	stw 0,8(1)
	li 4,1024
	mr 6,26
	lwz 29,184(30)
	addi 7,1,16
	mr 8,26
	mr 31,3
	cmpwi 7,29,1000
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 11,0,0
	and 29,29,0
	andi. 11,11,999
	or 29,29,11
	stw 29,12(1)
	crxor 6,6,6
	bl Com_sprintf
.L209:
	mr 3,31
	bl strlen
	add 3,25,3
	cmplwi 0,3,1024
	bc 12,1,.L202
	mr 4,31
	mr 3,23
	bl strcat
	addi 28,28,1
	addi 26,26,8
	mr 3,23
	addi 24,24,4
	bl strlen
	cmpw 0,28,27
	mr 25,3
	bc 12,0,.L204
.L202:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,22
	mtlr 0
	blrl
.L171:
	lwz 0,4596(1)
	mtlr 0
	lmw 19,4540(1)
	la 1,4592(1)
	blr
.Lfe9:
	.size	 KOTSScoreboardMessage,.Lfe9-KOTSScoreboardMessage
	.section	".rodata"
	.align 2
.LC39:
	.string	"xv 5 yv 15 string2 \"Player\" xv 133 yv 15 string2 \"Shots\" xv 181 yv 15 string2 \"Hits\" xv 221 yv 15 string2 \"Accuracy\" "
	.align 2
.LC40:
	.string	"xv 5 yv %d string2 \"%s\" xv 133 yv %i string \"%5i %4i %3.3f%%\" "
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC42:
	.long 0x42c80000
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSStatScoreboard
	.type	 KOTSStatScoreboard,@function
KOTSStatScoreboard:
	stwu 1,-4592(1)
	mflr 0
	stmw 18,4536(1)
	stw 0,4596(1)
	bl PMenu_Close
	li 27,0
	li 28,0
	lis 9,game@ha
	addi 21,1,1064
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,27,0
	bc 4,0,.L216
	lis 9,g_edicts@ha
	mr 24,11
	lwz 25,g_edicts@l(9)
	lis 26,0x4330
	addi 31,1,3496
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfd 12,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 11,0(9)
.L218:
	mulli 9,28,976
	addi 30,28,1
	addi 9,9,976
	add 29,25,9
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L217
	lwz 10,916(29)
	cmpwi 0,10,0
	bc 4,1,.L220
	lwz 0,924(29)
	xoris 10,10,0x8000
	mr 11,9
	xoris 0,0,0x8000
	stw 0,4532(1)
	stw 26,4528(1)
	lfd 13,4528(1)
	stw 10,4532(1)
	stw 26,4528(1)
	lfd 0,4528(1)
	fsub 13,13,12
	fsub 0,0,12
	frsp 13,13
	frsp 0,0
	fdivs 13,13,0
	fmuls 13,13,11
	b .L221
.L220:
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
.L221:
	li 6,0
	addi 5,1,3496
	cmpw 0,6,27
	addi 4,1,2472
	addi 29,27,1
	addi 30,28,1
	bc 4,0,.L223
	lfs 0,0(31)
	fcmpu 0,13,0
	bc 12,1,.L223
	mr 9,5
.L224:
	addi 6,6,1
	cmpw 0,6,27
	bc 4,0,.L223
	lfsu 0,4(9)
	fcmpu 0,13,0
	bc 4,1,.L224
.L223:
	cmpw 0,27,6
	mr 8,27
	slwi 3,6,2
	bc 4,1,.L229
	slwi 9,27,2
	mr 7,4
	mr 11,9
	mr 10,5
	addi 9,9,-4
.L231:
	lwzx 0,9,7
	addi 8,8,-1
	cmpw 0,8,6
	stwx 0,11,7
	lfsx 0,9,10
	addi 9,9,-4
	stfsx 0,11,10
	addi 11,11,-4
	bc 12,1,.L231
.L229:
	stwx 28,4,3
	mr 27,29
	stfsx 13,5,3
.L217:
	lwz 0,1544(24)
	mr 28,30
	cmpw 0,28,0
	bc 12,0,.L218
.L216:
	li 0,0
	lis 5,.LC39@ha
	la 5,.LC39@l(5)
	stb 0,1064(1)
	mr 3,21
	li 4,1400
	li 28,0
	crxor 6,6,6
	bl Com_sprintf
	mr 3,21
	bl strlen
	cmpw 0,28,27
	mr 25,3
	bc 4,0,.L235
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	mr 22,21
	li 23,0
	li 26,25
	li 24,0
	li 20,0
.L237:
	addi 9,1,2472
	stb 20,40(1)
	lwzx 0,9,24
	lwz 10,g_edicts@l(18)
	mulli 9,0,976
	lwz 11,1028(19)
	mulli 0,0,3964
	addi 9,9,976
	add 29,10,9
	add 30,11,0
	mr 3,29
	bl KOTSGetUser__FP7edict_s
	mr 31,3
	li 4,0
	addi 3,1,8
	li 5,20
	bl memset
	cmpwi 0,31,0
	bc 4,2,.L238
	addi 4,30,700
	addi 3,1,8
	li 5,15
	bl strncpy
	b .L239
.L238:
	addi 4,31,8
	addi 3,1,8
	li 5,15
	bl strncpy
.L239:
	addi 9,1,3496
	addi 31,1,40
	lwz 10,924(29)
	lfsx 1,9,23
	lis 5,.LC40@ha
	mr 3,31
	lwz 9,916(29)
	la 5,.LC40@l(5)
	li 4,1024
	mr 6,26
	addi 7,1,8
	mr 8,26
	creqv 6,6,6
	bl Com_sprintf
	mr 3,31
	bl strlen
	add 3,25,3
	cmplwi 0,3,1024
	bc 12,1,.L235
	mr 4,31
	mr 3,22
	bl strcat
	addi 28,28,1
	addi 23,23,4
	mr 3,22
	addi 26,26,8
	bl strlen
	addi 24,24,4
	cmpw 0,28,27
	mr 25,3
	bc 12,0,.L237
.L235:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,21
	mtlr 0
	blrl
	lwz 0,4596(1)
	mtlr 0
	lmw 18,4536(1)
	la 1,4592(1)
	blr
.Lfe10:
	.size	 KOTSStatScoreboard,.Lfe10-KOTSStatScoreboard
	.align 2
	.globl KOTSWorldSpawn
	.type	 KOTSWorldSpawn,@function
KOTSWorldSpawn:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+24@ha
	lis 11,kots_statusbar@ha
	lwz 0,gi+24@l(9)
	li 3,5
	lwz 4,kots_statusbar@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 KOTSWorldSpawn,.Lfe11-KOTSWorldSpawn
	.align 2
	.type	 KOTSVote__FP7edict_sP5SMenu,@function
KOTSVote__FP7edict_sP5SMenu:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	bl PMenu_Close
	cmpwi 0,31,0
	bc 12,2,.L9
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 0,56(30)
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	mr 3,31
	la 5,.LC1@l(5)
	stw 0,892(31)
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L9:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 KOTSVote__FP7edict_sP5SMenu,.Lfe12-KOTSVote__FP7edict_sP5SMenu
	.section	".rodata"
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSJoin__FP7edict_sP5SMenu
	.type	 KOTSJoin__FP7edict_sP5SMenu,@function
KOTSJoin__FP7edict_sP5SMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	bl PMenu_Close
	mr 3,31
	bl KOTSClientCanEnter__FP7edict_s
	cmpwi 0,3,0
	bc 12,2,.L52
	lis 9,kots_teamplay@ha
	lwz 10,84(31)
	li 11,1
	lwz 8,kots_teamplay@l(9)
	stw 11,3580(10)
	lis 9,.LC44@ha
	lwz 0,184(31)
	la 9,.LC44@l(9)
	lfs 13,0(9)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L54
	mr 3,31
	bl KOTSTeam__FP7edict_s
	mr 3,31
	bl KOTSAssignSkin
	lis 29,gi@ha
	lwz 5,84(31)
	mr 28,3
	lwz 9,gi@l(29)
	lis 4,.LC19@ha
	li 3,2
	la 4,.LC19@l(4)
	addi 5,5,700
	mtlr 9
	mr 6,28
	la 29,gi@l(29)
	crxor 6,6,6
	blrl
	lwz 0,12(29)
	lis 4,.LC20@ha
	mr 5,28
	la 4,.LC20@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	b .L55
.L54:
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC21@ha
	lwz 0,gi@l(9)
	la 4,.LC21@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L55:
	mr 3,31
	bl PutClientInServer
.L52:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 KOTSJoin__FP7edict_sP5SMenu,.Lfe13-KOTSJoin__FP7edict_sP5SMenu
	.section	".rodata"
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl KOTSChaseCam__FP7edict_sP5SMenu
	.type	 KOTSChaseCam__FP7edict_sP5SMenu,@function
KOTSChaseCam__FP7edict_sP5SMenu:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3920(9)
	cmpwi 0,0,0
	bc 12,2,.L58
	li 0,0
	stw 0,3920(9)
	bl PMenu_Close
	b .L57
.L58:
	li 8,1
	b .L59
.L61:
	addi 8,8,1
.L59:
	xoris 0,8,0x8000
	lis 9,0x4330
	stw 0,20(1)
	lis 11,.LC45@ha
	la 11,.LC45@l(11)
	stw 9,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	fsub 0,0,12
	lfs 13,20(9)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L57
	lis 9,g_edicts@ha
	mulli 11,8,976
	lwz 0,g_edicts@l(9)
	add 11,0,11
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L61
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L61
	lwz 9,84(31)
	mr 3,31
	stw 11,3920(9)
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,3924(9)
.L57:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 KOTSChaseCam__FP7edict_sP5SMenu,.Lfe14-KOTSChaseCam__FP7edict_sP5SMenu
	.align 2
	.globl KOTSBack__FP7edict_sP5SMenu
	.type	 KOTSBack__FP7edict_sP5SMenu,@function
KOTSBack__FP7edict_sP5SMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl KOTSOpenJoinMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 KOTSBack__FP7edict_sP5SMenu,.Lfe15-KOTSBack__FP7edict_sP5SMenu
	.align 2
	.globl KOTSHelp__FP7edict_sP5SMenu
	.type	 KOTSHelp__FP7edict_sP5SMenu,@function
KOTSHelp__FP7edict_sP5SMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,helpmenu@ha
	mr 3,29
	la 4,helpmenu@l(4)
	li 5,12
	li 6,17
	bl PMenu_Open__FP7edict_sP5SMenuii
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 KOTSHelp__FP7edict_sP5SMenu,.Lfe16-KOTSHelp__FP7edict_sP5SMenu
	.align 2
	.globl KOTSCredits__FP7edict_sP5SMenu
	.type	 KOTSCredits__FP7edict_sP5SMenu,@function
KOTSCredits__FP7edict_sP5SMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,creditmenu@ha
	mr 3,29
	la 4,creditmenu@l(4)
	li 5,8
	li 6,16
	bl PMenu_Open__FP7edict_sP5SMenuii
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 KOTSCredits__FP7edict_sP5SMenu,.Lfe17-KOTSCredits__FP7edict_sP5SMenu
	.align 2
	.globl KOTSOpenJoinMenu
	.type	 KOTSOpenJoinMenu,@function
KOTSOpenJoinMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl KOTSUpdateJoinMenu__FP7edict_s
	lwz 9,84(29)
	lis 4,joinmenu@ha
	mr 3,29
	la 4,joinmenu@l(4)
	li 6,16
	lwz 0,3920(9)
	srawi 9,0,31
	xor 5,9,0
	subf 5,5,9
	srawi 5,5,31
	rlwinm 5,5,0,29,31
	ori 5,5,5
	bl PMenu_Open__FP7edict_sP5SMenuii
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 KOTSOpenJoinMenu,.Lfe18-KOTSOpenJoinMenu
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
