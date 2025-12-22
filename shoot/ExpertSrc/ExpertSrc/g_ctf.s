	.file	"g_ctf.c"
gcc2_compiled.:
	.globl ctf_statusbar
	.section	".rodata"
	.align 2
.LC0:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 en"
	.ascii	"dif if 6 \txv\t296 \tpic 6 endif yb\t-50 if 9 xv 246 num 2 1"
	.ascii	"0 xv 296 pic 9 endif if 11 xv 148 pic 11 endif xr\t-50 yt 2 "
	.ascii	"num 3 14 yb -102 if 17 xl 2 pic 17 endif xl 28 num 2 18 if 2"
	.ascii	"2 yb -104 xl 0 pic 22 endif yb -75 if 19 xl 2 pic 19 endif x"
	.ascii	"l 28 num 2 20 if 23 yb -77 xl 0 pic 23 endif if"
	.string	" 21 yb -137 xl 2 pic 21 endif if 27 yb -58 xv 120 stat_string 27 endif xl 68 if 28 yb -94 stat_string 28 endif if 29 yb -67 stat_string 29 endif if 30 xr -12 yb -142 pic 7 yb -60 pic 8 xr -12 yb -78 pic 30 yb -96 pic 31 yb -114 pic 26 yb -132 pic 16 endif "
	.section	".sdata","aw"
	.align 2
	.type	 ctf_statusbar,@object
	.size	 ctf_statusbar,4
ctf_statusbar:
	.long .LC0
	.section	".rodata"
	.align 2
.LC1:
	.string	"item_flag_team1"
	.align 2
.LC2:
	.string	"item_flag_team2"
	.align 2
.LC3:
	.string	"Map is missing at least one flag.  Disabling CTF\n"
	.align 2
.LC4:
	.string	"ctf"
	.align 2
.LC5:
	.string	"0"
	.section	".text"
	.align 2
	.globl CTFInit
	.type	 CTFInit,@function
CTFInit:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 30,.LC1@ha
	li 3,0
	li 4,280
	la 5,.LC1@l(30)
	bl G_Find
	cmpwi 0,3,0
	bc 12,2,.L23
	lis 31,.LC2@ha
	li 3,0
	li 4,280
	la 5,.LC2@l(31)
	bl G_Find
	cmpwi 0,3,0
	bc 4,2,.L22
.L23:
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,148(29)
	lis 3,.LC4@ha
	lis 4,.LC5@ha
	la 3,.LC4@l(3)
	la 4,.LC5@l(4)
	mtlr 0
	blrl
	b .L21
.L22:
	lis 29,flag1_item@ha
	lwz 0,flag1_item@l(29)
	cmpwi 0,0,0
	bc 4,2,.L24
	la 3,.LC1@l(30)
	bl FindItemByClassname
	stw 3,flag1_item@l(29)
.L24:
	lis 29,flag2_item@ha
	lwz 0,flag2_item@l(29)
	cmpwi 0,0,0
	bc 4,2,.L25
	la 3,.LC2@l(31)
	bl FindItemByClassname
	stw 3,flag2_item@l(29)
.L25:
	lis 29,ctfgame@ha
	li 4,0
	la 29,ctfgame@l(29)
	li 5,92
	mr 3,29
	crxor 6,6,6
	bl memset
	la 5,.LC1@l(30)
	li 4,280
	li 3,0
	bl G_Find
	stw 3,68(29)
	la 5,.LC2@l(31)
	li 4,280
	li 3,0
	bl G_Find
	stw 3,72(29)
	bl InitSpawnLists
.L21:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 CTFInit,.Lfe1-CTFInit
	.section	".rodata"
	.align 2
.LC6:
	.string	"info_player_deathmatch"
	.align 2
.LC8:
	.string	"Small map: picking CTF team spawns\naccording to distance between bases.\n"
	.align 2
.LC7:
	.long 0x44bb8000
	.align 3
.LC9:
	.long 0x3fd55555
	.long 0x55555555
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC11:
	.long 0x40180000
	.long 0x0
	.section	".text"
	.align 2
	.globl findLegalSpawns
	.type	 findLegalSpawns,@function
findLegalSpawns:
	stwu 1,-112(1)
	mflr 0
	mfcr 12
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 26,72(1)
	stw 0,116(1)
	stw 12,68(1)
	mr 29,3
	li 4,0
	li 3,0
	li 31,0
	bl listNew
	lis 9,ctfgame@ha
	mr 30,3
	la 9,ctfgame@l(9)
	lwz 27,72(9)
	lwz 28,68(9)
	lis 26,.LC6@ha
	b .L40
.L42:
	cmpwi 0,29,0
	bc 4,2,.L44
	lis 9,ctfgame+72@ha
	lwz 9,ctfgame+72@l(9)
	b .L45
.L44:
	lis 9,ctfgame+68@ha
	lwz 9,ctfgame+68@l(9)
.L45:
	lfs 0,4(9)
	addi 3,1,24
	lfs 13,4(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 13,8(9)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,28(1)
	lfs 13,12(9)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,32(1)
	bl VectorLength
	lis 9,.LC7@ha
	lfs 0,.LC7@l(9)
	fcmpu 0,1,0
	cror 3,2,1
	bc 4,3,.L40
	mr 3,30
	mr 4,31
	bl listAppend
.L40:
	lis 5,.LC6@ha
	mr 3,31
	la 5,.LC6@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L42
	mr 3,30
	bl listSize
	xoris 3,3,0x8000
	lis 10,game+1544@ha
	lis 8,0x4330
	stw 3,60(1)
	lwz 0,game+1544@l(10)
	mr 9,11
	stw 8,56(1)
	lis 10,.LC10@ha
	lfd 31,56(1)
	xoris 0,0,0x8000
	la 10,.LC10@l(10)
	stw 0,60(1)
	stw 8,56(1)
	lfd 0,0(10)
	lfd 1,56(1)
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	lfd 13,0(10)
	fsub 31,31,0
	fsub 1,1,0
	fdiv 1,1,13
	bl floor
	fcmpu 0,31,1
	bc 4,1,.L48
	mr 3,30
	b .L59
.L48:
	lis 9,gi+4@ha
	lis 3,.LC8@ha
	lwz 0,gi+4@l(9)
	la 3,.LC8@l(3)
	cmpwi 4,29,0
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	bl listFree
	li 4,0
	li 3,0
	bl listNew
	lfs 0,4(27)
	mr 30,3
	lfs 13,4(28)
	addi 3,1,8
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(27)
	lfs 0,8(28)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(28)
	lfs 0,12(27)
	fsubs 13,13,0
	stfs 13,16(1)
	bl VectorLength
	lis 9,.LC9@ha
	fmr 30,1
	lis 11,ctfgame@ha
	lfd 31,.LC9@l(9)
	la 29,ctfgame@l(11)
	b .L49
.L51:
	bc 4,18,.L53
	lwz 9,72(29)
	b .L54
.L53:
	lwz 9,68(29)
.L54:
	lfs 0,4(9)
	addi 3,1,24
	lfs 13,4(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 13,8(9)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,28(1)
	lfs 13,12(9)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,32(1)
	bl VectorLength
	fdivs 1,1,30
	fcmpu 0,1,31
	cror 3,2,1
	bc 4,3,.L49
	mr 3,30
	mr 4,31
	bl listAppend
.L49:
	mr 3,31
	li 4,280
	la 5,.LC6@l(26)
	bl G_Find
	mr. 31,3
	bc 4,2,.L51
	mr 3,30
	bl listSize
	cmpwi 0,3,0
	mr 3,30
	bc 4,2,.L59
	bl listFree
	li 3,0
.L59:
	lwz 0,116(1)
	lwz 12,68(1)
	mtlr 0
	lmw 26,72(1)
	lfd 30,96(1)
	lfd 31,104(1)
	mtcrf 8,12
	la 1,112(1)
	blr
.Lfe2:
	.size	 findLegalSpawns,.Lfe2-findLegalSpawns
	.section	".rodata"
	.align 2
.LC14:
	.string	"info_player_team1"
	.align 2
.LC15:
	.string	"info_player_team2"
	.align 2
.LC13:
	.long 0x47c34f80
	.align 2
.LC16:
	.long 0x0
	.section	".text"
	.align 2
	.globl SelectCTFSpawnPoint
	.type	 SelectCTFSpawnPoint,@function
SelectCTFSpawnPoint:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 26,24(1)
	stw 0,68(1)
	mr 29,3
	li 31,0
	lwz 9,84(29)
	lwz 0,3436(9)
	cmpwi 0,0,0
	bc 12,2,.L84
	lwz 0,3476(9)
	cmpwi 0,0,-1
	bc 12,2,.L132
	lis 9,ctfgame@ha
	slwi 0,0,2
	la 9,ctfgame@l(9)
	addi 9,9,84
	lwzx 28,9,0
	cmpwi 0,28,0
	bc 12,2,.L132
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L87
	mr 3,28
	li 27,0
	bl listSize
	li 30,0
	mr 29,3
	lis 9,.LC16@ha
	cmpw 0,31,29
	la 9,.LC16@l(9)
	lfs 31,0(9)
	bc 4,0,.L93
.L90:
	mr 4,30
	mr 3,28
	bl listElementAt
	mr 31,3
	bl PlayersRangeFromSpot
	fcmpu 0,1,31
	bc 4,1,.L92
	fmr 31,1
	mr 27,31
.L92:
	addi 30,30,1
	cmpw 0,30,29
	bc 12,0,.L90
.L93:
	cmpwi 0,27,0
	bc 12,2,.L94
	mr 3,27
	b .L131
.L94:
	lis 5,.LC6@ha
	li 3,0
	la 5,.LC6@l(5)
	li 4,280
	bl G_Find
	b .L131
.L87:
	lis 9,.LC13@ha
	mr 3,28
	lfs 31,.LC13@l(9)
	li 26,0
	li 27,0
	bl listSize
	mr 30,3
	cmpwi 0,30,2
	fmr 30,31
	bc 4,1,.L107
	cmpw 0,31,30
	li 29,0
	bc 4,0,.L107
.L100:
	mr 4,29
	mr 3,28
	bl listElementAt
	mr 31,3
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L101
	fmr 30,1
	mr 27,31
	b .L104
.L101:
	fcmpu 0,1,31
	bc 4,0,.L104
	fmr 31,1
	mr 26,31
.L104:
	addi 29,29,1
	cmpw 0,29,30
	bc 12,0,.L100
.L107:
	bl rand
	mr 4,3
	divw 0,4,30
	mr 3,28
	mullw 0,0,30
	subf 4,0,4
	bl listElementAt
	mr 31,3
	xor 9,31,27
	subfic 0,9,0
	adde 9,0,9
	xor 0,31,26
	subfic 10,0,0
	adde 0,10,0
	or. 11,9,0
	bc 4,2,.L107
	b .L131
.L84:
	li 0,1
	stw 0,3436(9)
	lwz 9,84(29)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L112
	cmpwi 0,0,1
	bc 12,2,.L113
	b .L132
.L112:
	lis 9,.LC14@ha
	la 26,.LC14@l(9)
	b .L111
.L113:
	lis 9,.LC15@ha
	la 26,.LC15@l(9)
.L111:
	lis 9,.LC13@ha
	li 30,0
	lfs 31,.LC13@l(9)
	li 27,0
	li 28,0
	fmr 30,31
	b .L116
.L118:
	mr 3,30
	addi 31,31,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L119
	fmr 30,1
	mr 28,30
	b .L116
.L119:
	fcmpu 0,1,31
	bc 4,0,.L116
	fmr 31,1
	mr 27,30
.L116:
	mr 3,30
	li 4,280
	mr 5,26
	bl G_Find
	mr. 30,3
	bc 4,2,.L118
	cmpwi 0,31,0
	bc 4,2,.L123
.L132:
	mr 3,29
	bl SelectDeathmatchSpawnPoint
	b .L131
.L123:
	cmpwi 0,31,2
	bc 12,1,.L124
	li 27,0
	li 28,0
	b .L125
.L124:
	addi 31,31,-2
.L125:
	bl rand
	li 30,0
	divw 0,3,31
	mullw 0,0,31
	subf 31,0,3
.L130:
	mr 3,30
	li 4,280
	mr 5,26
	bl G_Find
	mr 30,3
	addi 0,31,1
	xor 9,30,28
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,27
	subfic 10,11,0
	adde 11,10,11
	or 9,9,11
	addic 9,9,-1
	subfe 9,9,9
	andc 0,0,9
	and 9,31,9
	or 31,9,0
	cmpwi 0,31,0
	addi 31,31,-1
	bc 4,2,.L130
.L131:
	lwz 0,68(1)
	mtlr 0
	lmw 26,24(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 SelectCTFSpawnPoint,.Lfe3-SelectCTFSpawnPoint
	.section	".rodata"
	.align 2
.LC17:
	.string	"Expert CTF scoring passed NULL attacker or targ\n"
	.align 2
.LC19:
	.string	"BONUS %s: CARRIER KILL: %d points\n"
	.align 2
.LC20:
	.string	"Carrier Kill"
	.align 2
.LC21:
	.string	"BONUS %s: %s CARRIER SAVE\n"
	.align 2
.LC22:
	.string	"Carrier Save"
	.align 2
.LC23:
	.string	"BONUS %s: %s BASE DEFENSE\n"
	.align 2
.LC24:
	.string	"Base Defense"
	.align 2
.LC25:
	.string	"BONUS %s: FLAG HOLDING\n"
	.align 2
.LC26:
	.string	"Flag Holding"
	.align 2
.LC27:
	.string	"BONUS %s: %s FLAG DEFENSE\n"
	.align 2
.LC28:
	.string	"Flag Defense"
	.align 2
.LC29:
	.string	"BONUS %s: %s DEFENDER KILL\n"
	.align 2
.LC30:
	.string	"Defender Kill"
	.align 2
.LC31:
	.string	"BONUS %s: %s CARRIER DEFENSE\n"
	.align 2
.LC32:
	.string	"Carrier Defense"
	.align 3
.LC18:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x41000000
	.align 2
.LC36:
	.long 0x44160000
	.section	".text"
	.align 2
	.globl ExpertCTFScoring
	.type	 ExpertCTFScoring,@function
ExpertCTFScoring:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 25,60(1)
	stw 0,100(1)
	mr 27,3
	mr 30,5
	subfic 0,27,0
	adde 9,0,27
	li 25,0
	subfic 10,30,0
	adde 0,10,30
	or. 11,9,0
	bc 12,2,.L134
	lis 9,gi+4@ha
	lis 3,.LC17@ha
	lwz 0,gi+4@l(9)
	la 3,.LC17@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L133
.L134:
	lwz 0,84(27)
	cmpwi 0,0,0
	bc 12,2,.L133
	lwz 0,84(30)
	xor 9,27,30
	subfic 10,9,0
	adde 9,10,9
	subfic 11,0,0
	adde 0,11,0
	or. 10,0,9
	bc 4,2,.L133
	mr 3,30
	mr 4,27
	bl onSameTeam
	cmpwi 0,3,0
	bc 4,2,.L133
	lwz 9,84(27)
	lwz 0,3476(9)
	mr 10,9
	cmpwi 0,0,0
	bc 12,2,.L137
	cmpwi 0,0,1
	bc 12,2,.L138
	b .L141
.L137:
	li 31,1
	b .L140
.L138:
	li 31,0
	b .L140
.L141:
	li 31,-1
.L140:
	cmpwi 0,31,0
	bc 12,0,.L133
	lwz 9,84(30)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L143
	cmpwi 0,0,1
	bc 12,2,.L144
	b .L147
.L143:
	li 31,1
	b .L146
.L144:
	li 31,0
	b .L146
.L147:
	li 31,-1
.L146:
	cmpwi 0,31,0
	bc 12,0,.L133
	lwz 0,3476(10)
	cmpwi 0,0,0
	bc 4,2,.L149
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 28,flag1_item@l(9)
	lwz 11,flag2_item@l(11)
	b .L150
.L149:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 28,flag2_item@l(9)
	lwz 11,flag1_item@l(11)
.L150:
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,11
	mullw 9,9,0
	addi 11,10,744
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L151
	lis 9,level@ha
	lwz 10,84(30)
	la 9,level@l(9)
	lfs 0,4(9)
	stfs 0,3452(10)
	lwz 11,84(27)
	lfs 0,4(9)
	lfs 13,3448(11)
	fsubs 0,0,13
	fctiwz 12,0
	stfd 12,48(1)
	lwz 0,52(1)
	cmpwi 0,0,3
	bc 12,1,.L152
	li 29,2
	b .L153
.L152:
	xoris 0,0,0x8000
	stw 0,52(1)
	lis 11,0x4330
	lis 10,.LC33@ha
	stw 11,48(1)
	la 10,.LC33@l(10)
	lfd 1,48(1)
	lfd 13,0(10)
	lis 10,.LC18@ha
	lfd 0,.LC18@l(10)
	fsub 1,1,13
	fmul 1,1,0
	bl floor
	fctiwz 0,1
	stfd 0,48(1)
	lwz 29,52(1)
	cmpwi 7,29,13
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,29,0
	rlwinm 9,9,0,28,29
	or 29,0,9
.L153:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC19@ha
	lwz 0,gi@l(9)
	la 4,.LC19@l(4)
	li 3,1
	addi 5,5,700
	addi 6,29,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(30)
	lis 4,.LC20@ha
	mr 5,29
	la 4,.LC20@l(4)
	mr 3,30
	lwz 0,3432(9)
	add 0,0,29
	stw 0,3432(9)
	bl gsLogScore
	lis 10,.LC34@ha
	lis 9,maxclients@ha
	la 10,.LC34@l(10)
	lis 11,g_edicts@ha
	lfs 13,0(10)
	li 8,1
	lwz 10,maxclients@l(9)
	lwz 9,g_edicts@l(11)
	lfs 0,20(10)
	addi 11,9,916
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L151
	lis 9,.LC33@ha
	li 6,0
	la 9,.LC33@l(9)
	lis 7,0x4330
	lfd 12,0(9)
.L158:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L159
	lwz 9,84(11)
	lwz 0,3476(9)
	cmpw 0,0,31
	bc 4,2,.L159
	stw 6,3440(9)
.L159:
	addi 8,8,1
	lfs 13,20(10)
	xoris 0,8,0x8000
	addi 11,11,916
	stw 0,52(1)
	stw 7,48(1)
	lfd 0,48(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L158
.L151:
	lwz 11,84(27)
	lis 9,level+4@ha
	lis 10,.LC35@ha
	lfs 0,level+4@l(9)
	la 10,.LC35@l(10)
	lfs 13,3440(11)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,0,.L161
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,28
	addi 11,10,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L161
	lwz 9,3432(10)
	lis 28,gi@ha
	li 25,1
	addi 9,9,3
	stw 9,3432(10)
	lwz 29,84(30)
	lwz 3,3476(29)
	addi 29,29,700
	bl nameForTeam
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC21@ha
	la 4,.LC21@l(4)
	mr 5,29
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC22@ha
	mr 3,30
	la 4,.LC22@l(4)
	li 5,3
	bl gsLogScore
.L161:
	lwz 10,84(30)
	lis 11,.LC36@ha
	lis 9,ctfgame@ha
	la 11,.LC36@l(11)
	la 9,ctfgame@l(9)
	lfs 13,4(27)
	lwz 0,3476(10)
	addi 3,1,8
	lfs 31,0(11)
	addi 11,9,68
	slwi 0,0,2
	lwzx 31,11,0
	addi 9,9,60
	lwzx 28,9,0
	lfs 0,4(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(31)
	lfs 0,8(27)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 0,12(31)
	lfs 13,12(27)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 13,4(31)
	lfs 0,4(30)
	fsubs 0,0,13
	stfs 0,24(1)
	lfs 0,8(31)
	lfs 13,8(30)
	fsubs 13,13,0
	stfs 13,28(1)
	lfs 0,12(30)
	lfs 13,12(31)
	fsubs 0,0,13
	stfs 0,32(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L163
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L163
	mr 3,31
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L163
	mr 3,31
	mr 4,30
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L162
.L163:
	lwz 11,84(30)
	lis 26,gi@ha
	lwz 9,3432(11)
	addi 9,9,1
	stw 9,3432(11)
	lwz 29,84(30)
	lwz 3,3476(29)
	addi 29,29,700
	bl nameForTeam
	lwz 9,gi@l(26)
	mr 6,3
	lis 4,.LC23@ha
	la 4,.LC23@l(4)
	mr 5,29
	li 3,1
	mtlr 9
	crxor 6,6,6
	blrl
	lis 4,.LC24@ha
	mr 3,30
	la 4,.LC24@l(4)
	li 5,1
	bl gsLogScore
	cmpw 0,31,28
	bc 12,2,.L162
	lwz 10,84(30)
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	lwz 0,3476(10)
	addi 9,9,76
	slwi 0,0,2
	lwzx 11,9,0
	cmpw 0,30,11
	bc 4,2,.L162
	lwz 9,3432(10)
	lis 4,.LC25@ha
	li 3,1
	la 4,.LC25@l(4)
	addi 9,9,1
	stw 9,3432(10)
	lwz 5,84(30)
	lwz 0,gi@l(26)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC26@ha
	mr 3,30
	la 4,.LC26@l(4)
	li 5,1
	bl gsLogScore
.L162:
	cmpwi 0,28,0
	bc 12,2,.L165
	lfs 0,4(28)
	lis 9,.LC36@ha
	addi 3,1,8
	lfs 13,4(27)
	la 9,.LC36@l(9)
	lfs 31,0(9)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(28)
	lfs 0,8(27)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 0,12(28)
	lfs 13,12(27)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 13,4(28)
	lfs 0,4(30)
	fsubs 0,0,13
	stfs 0,24(1)
	lfs 0,8(28)
	lfs 13,8(30)
	fsubs 13,13,0
	stfs 13,28(1)
	lfs 0,12(30)
	lfs 13,12(28)
	fsubs 0,0,13
	stfs 0,32(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L167
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L167
	mr 3,28
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L167
	mr 3,28
	mr 4,30
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L165
.L167:
	lwz 11,84(30)
	lis 28,gi@ha
	lwz 9,3432(11)
	addi 9,9,2
	stw 9,3432(11)
	lwz 29,84(30)
	lwz 3,3476(29)
	addi 29,29,700
	bl nameForTeam
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC27@ha
	la 4,.LC27@l(4)
	mr 5,29
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC28@ha
	mr 3,30
	la 4,.LC28@l(4)
	li 5,2
	bl gsLogScore
.L165:
	lwz 11,84(27)
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	lwz 0,3476(11)
	addi 9,9,60
	slwi 0,0,2
	lwzx 28,9,0
	cmpwi 0,28,0
	bc 12,2,.L168
	lfs 0,4(28)
	lis 9,.LC36@ha
	addi 3,1,8
	lfs 13,4(27)
	la 9,.LC36@l(9)
	lfs 31,0(9)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(28)
	lfs 0,8(27)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 0,12(28)
	lfs 13,12(27)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 13,4(28)
	lfs 0,4(30)
	fsubs 0,0,13
	stfs 0,24(1)
	lfs 0,8(28)
	lfs 13,8(30)
	fsubs 13,13,0
	stfs 13,28(1)
	lfs 0,12(30)
	lfs 13,12(28)
	fsubs 0,0,13
	stfs 0,32(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L170
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L170
	mr 3,28
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L170
	mr 3,28
	mr 4,30
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L168
.L170:
	lwz 10,84(30)
	lis 28,gi@ha
	lwz 9,3432(10)
	addi 9,9,1
	stw 9,3432(10)
	lwz 11,84(27)
	lwz 29,84(30)
	lwz 3,3476(11)
	addi 29,29,700
	bl nameForTeam
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	mr 5,29
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC30@ha
	mr 3,30
	la 4,.LC30@l(4)
	li 5,1
	bl gsLogScore
.L168:
	cmpwi 0,25,0
	bc 4,2,.L133
	lwz 11,84(30)
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	lwz 0,3476(11)
	addi 9,9,76
	slwi 0,0,2
	lwzx 29,9,0
	xor 11,29,30
	addic 0,29,-1
	subfe 9,0,29
	addic 10,11,-1
	subfe 0,10,11
	and. 11,9,0
	bc 12,2,.L133
	lfs 0,4(29)
	lis 9,.LC36@ha
	addi 3,1,8
	lfs 13,4(27)
	la 9,.LC36@l(9)
	lfs 31,0(9)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(29)
	lfs 0,8(27)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 0,12(29)
	lfs 13,12(27)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 13,4(29)
	lfs 0,4(30)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 0,8(29)
	lfs 13,8(30)
	fsubs 13,13,0
	stfs 13,12(1)
	lfs 0,12(30)
	lfs 13,12(29)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L174
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L174
	mr 4,27
	mr 3,29
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L174
	mr 3,29
	mr 4,30
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L133
.L174:
	lwz 11,84(30)
	lis 28,gi@ha
	lwz 9,3432(11)
	addi 9,9,2
	stw 9,3432(11)
	lwz 29,84(30)
	lwz 3,3476(29)
	addi 29,29,700
	bl nameForTeam
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC31@ha
	la 4,.LC31@l(4)
	mr 5,29
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC32@ha
	mr 3,30
	la 4,.LC32@l(4)
	li 5,2
	bl gsLogScore
.L133:
	lwz 0,100(1)
	mtlr 0
	lmw 25,60(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe4:
	.size	 ExpertCTFScoring,.Lfe4-ExpertCTFScoring
	.section	".rodata"
	.align 2
.LC37:
	.long 0x44bb8000
	.align 2
.LC38:
	.long 0x3f800000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl countPlayers
	.type	 countPlayers,@function
countPlayers:
	stwu 1,-112(1)
	mflr 0
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 22,56(1)
	stw 0,116(1)
	lis 9,ctfgame+8@ha
	li 4,0
	la 31,ctfgame+8@l(9)
	li 5,32
	mr 3,31
	li 27,1
	crxor 6,6,6
	bl memset
	lis 22,maxclients@ha
	lis 11,maxclients@ha
	lis 9,.LC38@ha
	lwz 10,maxclients@l(11)
	la 9,.LC38@l(9)
	lfs 13,0(9)
	lfs 0,20(10)
	lis 9,g_edicts@ha
	lwz 30,g_edicts@l(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L182
	lis 9,.LC37@ha
	mr 28,31
	lfs 30,.LC37@l(9)
	addi 24,28,4
	addi 25,28,12
	addi 26,28,8
	addi 29,31,60
	lis 23,0x4330
.L184:
	addi 30,30,916
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L183
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L183
	lwz 31,3476(9)
	cmpwi 0,31,-1
	bc 12,2,.L183
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L183
	slwi 0,31,2
	lfs 13,4(30)
	addi 3,1,8
	lwzx 9,29,0
	lfs 0,4(9)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(9)
	lfs 0,8(30)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(9)
	lfs 0,12(30)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	cmpwi 0,31,0
	fmr 31,1
	bc 12,2,.L189
	cmpwi 0,31,1
	bc 12,2,.L190
	b .L193
.L189:
	li 0,1
	b .L192
.L190:
	li 0,0
	b .L192
.L193:
	li 0,-1
.L192:
	slwi 0,0,2
	lfs 13,4(30)
	cmpwi 7,31,0
	lwzx 9,29,0
	lfs 0,4(9)
	fsubs 13,13,0
	stfs 13,24(1)
	bc 12,30,.L194
	cmpwi 0,31,1
	bc 12,2,.L195
	b .L198
.L194:
	li 0,1
	b .L197
.L195:
	li 0,0
	b .L197
.L198:
	li 0,-1
.L197:
	slwi 0,0,2
	lfs 13,8(30)
	lwzx 9,29,0
	lfs 0,8(9)
	fsubs 13,13,0
	stfs 13,28(1)
	bc 12,30,.L199
	cmpwi 0,31,1
	bc 12,2,.L200
	b .L203
.L199:
	li 0,1
	b .L202
.L200:
	li 0,0
	b .L202
.L203:
	li 0,-1
.L202:
	slwi 0,0,2
	lfs 13,12(30)
	addi 3,1,24
	lwzx 9,29,0
	lfs 0,12(9)
	fsubs 13,13,0
	stfs 13,32(1)
	bl VectorLength
	fcmpu 0,31,1
	bc 4,0,.L204
	fcmpu 0,31,30
	bc 4,0,.L205
	slwi 0,31,4
	lwzx 9,28,0
	addi 9,9,1
	stwx 9,28,0
	b .L183
.L205:
	slwi 0,31,4
	lwzx 9,24,0
	addi 9,9,1
	stwx 9,24,0
	b .L183
.L204:
	fcmpu 0,1,30
	bc 4,0,.L208
	slwi 0,31,4
	lwzx 9,25,0
	addi 9,9,1
	stwx 9,25,0
	b .L183
.L208:
	slwi 0,31,4
	lwzx 9,26,0
	addi 9,9,1
	stwx 9,26,0
.L183:
	addi 27,27,1
	lwz 11,maxclients@l(22)
	xoris 0,27,0x8000
	lis 10,.LC39@ha
	stw 0,52(1)
	la 10,.LC39@l(10)
	stw 23,48(1)
	lfd 13,0(10)
	lfd 0,48(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L184
.L182:
	lwz 0,116(1)
	mtlr 0
	lmw 22,56(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe5:
	.size	 countPlayers,.Lfe5-countPlayers
	.section	".rodata"
	.align 2
.LC40:
	.string	"i_etd0"
	.align 2
.LC41:
	.string	"i_etd25"
	.align 2
.LC42:
	.string	"i_etd50"
	.align 2
.LC43:
	.string	"i_etd75"
	.align 2
.LC44:
	.string	"i_etd100"
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC46:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC47:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC48:
	.long 0x3fe80000
	.long 0x0
	.section	".text"
	.align 2
	.globl convertToPics
	.type	 convertToPics,@function
convertToPics:
	stwu 1,-112(1)
	mflr 0
	stfd 27,72(1)
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 23,36(1)
	stw 0,116(1)
	lis 9,ctfgame@ha
	lis 11,gi@ha
	la 23,ctfgame@l(9)
	la 30,gi@l(11)
	lis 9,.LC45@ha
	li 31,0
	la 9,.LC45@l(9)
	lis 27,0x4330
	lfd 30,0(9)
	lis 24,.LC40@ha
	lis 25,.LC41@ha
	lis 9,.LC46@ha
	lis 26,.LC42@ha
	la 9,.LC46@l(9)
	lfd 27,0(9)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfd 28,0(9)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfd 29,0(9)
.L215:
	mr 3,31
	addi 28,31,1
	bl memberCount
	li 29,4
	srawi 0,3,31
	xor 9,0,3
	slwi 8,31,4
	subf 9,9,0
	addi 10,23,8
	srawi 9,9,31
	add 31,8,10
	addi 0,9,1
	and 9,3,9
	or 3,9,0
	xoris 0,3,0x8000
	stw 0,28(1)
	stw 27,24(1)
	lfd 0,24(1)
	fsub 0,0,30
	frsp 31,0
.L220:
	lwz 0,0(31)
	xoris 11,0,0x8000
	cmpwi 0,0,0
	stw 11,28(1)
	stw 27,24(1)
	lfd 0,24(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,31
	bc 4,2,.L221
	lwz 9,40(30)
	la 3,.LC40@l(24)
	b .L231
.L221:
	fcmpu 0,0,27
	cror 3,2,0
	bc 4,3,.L223
	lwz 9,40(30)
	la 3,.LC41@l(25)
	b .L231
.L223:
	fcmpu 0,0,28
	cror 3,2,0
	bc 4,3,.L225
	lwz 9,40(30)
	la 3,.LC42@l(26)
	b .L231
.L225:
	fcmpu 0,0,29
	cror 3,2,0
	bc 4,3,.L227
	lwz 9,40(30)
	lis 3,.LC43@ha
	la 3,.LC43@l(3)
	b .L231
.L227:
	lwz 9,40(30)
	lis 3,.LC44@ha
	la 3,.LC44@l(3)
.L231:
	mtlr 9
	blrl
	stw 3,0(31)
	addic. 29,29,-1
	addi 31,31,4
	bc 4,2,.L220
	mr 31,28
	cmpwi 0,31,1
	bc 4,1,.L215
	lwz 0,116(1)
	mtlr 0
	lmw 23,36(1)
	lfd 27,72(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe6:
	.size	 convertToPics,.Lfe6-convertToPics
	.align 2
	.globl CTFResetFlags
	.type	 CTFResetFlags,@function
CTFResetFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	lwz 3,60(9)
	lwz 31,68(9)
	cmpwi 0,3,0
	bc 12,2,.L236
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L236
	bl G_FreeEdict
.L236:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,ctfgame@ha
	stw 29,80(31)
	la 9,ctfgame@l(9)
	lwz 3,64(9)
	lwz 0,68(9)
	cmpwi 0,3,0
	lwz 31,72(9)
	stw 0,60(9)
	bc 12,2,.L238
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L238
	bl G_FreeEdict
.L238:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,ctfgame@ha
	stw 29,80(31)
	la 9,ctfgame@l(9)
	lwz 0,72(9)
	stw 0,64(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 CTFResetFlags,.Lfe7-CTFResetFlags
	.section	".rodata"
	.align 2
.LC49:
	.string	"%s %s the %s flag! (held %.1f seconds)\n"
	.align 2
.LC50:
	.string	"\303\301\320\324\325\322\305\304"
	.align 2
.LC51:
	.string	"ctf/flagcap.wav"
	.align 2
.LC52:
	.string	"world/x_alarm.wav"
	.align 2
.LC53:
	.string	"Flag Capture"
	.align 2
.LC54:
	.string	"%s %s: %s FLAG RETURN\n"
	.align 2
.LC55:
	.string	"\301\323\323\311\323\324"
	.align 2
.LC56:
	.string	"Return Assist"
	.align 2
.LC57:
	.string	"%s %s: %s CARRIER KILL\n"
	.align 2
.LC58:
	.string	"Kill Assist"
	.align 2
.LC59:
	.long 0x3f800000
	.align 2
.LC60:
	.long 0x41200000
	.align 2
.LC61:
	.long 0x41500000
	.align 3
.LC62:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFCapture
	.type	 CTFCapture,@function
CTFCapture:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 22,16(1)
	stw 0,68(1)
	mr 28,4
	lis 10,level+4@ha
	lwz 9,84(28)
	lis 11,gi@ha
	mr 31,3
	lfs 13,level+4@l(10)
	la 27,gi@l(11)
	mr 29,6
	lwz 0,3476(9)
	addi 30,9,700
	lis 22,level@ha
	lfs 0,3448(9)
	lis 25,gi@ha
	cmpwi 0,0,0
	fsubs 31,13,0
	bc 12,2,.L241
	cmpwi 0,0,1
	bc 12,2,.L242
	b .L245
.L241:
	li 3,1
	b .L244
.L242:
	li 3,0
	b .L244
.L245:
	li 3,-1
.L244:
	bl nameForTeam
	lwz 0,0(27)
	mr 7,3
	lis 4,.LC49@ha
	fmr 1,31
	lis 6,.LC50@ha
	mr 5,30
	la 6,.LC50@l(6)
	la 4,.LC49@l(4)
	mtlr 0
	li 3,2
	creqv 6,6,6
	blrl
	lwz 9,84(28)
	lis 11,itemlist@ha
	lis 0,0x38e3
	la 11,itemlist@l(11)
	ori 0,0,36409
	lfs 0,3572(9)
	subf 11,11,29
	li 5,0
	mullw 11,11,0
	lis 7,level+4@ha
	lis 10,ctfgame@ha
	lis 8,gi+36@ha
	la 10,ctfgame@l(10)
	fadds 0,0,31
	srawi 11,11,3
	lis 3,.LC51@ha
	slwi 11,11,2
	la 3,.LC51@l(3)
	addi 6,10,76
	stfs 0,3572(9)
	lwz 9,84(28)
	addi 9,9,744
	stwx 5,9,11
	lfs 0,level+4@l(7)
	lwz 8,gi+36@l(8)
	stfs 0,52(10)
	mtlr 8
	lwz 0,908(31)
	stw 0,56(10)
	lwz 11,908(31)
	slwi 11,11,2
	lwzx 9,10,11
	addi 9,9,1
	stwx 9,10,11
	lwz 0,908(31)
	slwi 0,0,2
	stwx 5,6,0
	lwz 29,908(31)
	blrl
	lis 9,.LC59@ha
	mr 4,3
	la 9,.LC59@l(9)
	mr 3,29
	lfs 1,0(9)
	bl teamSound
	lwz 3,908(31)
	cmpwi 0,3,0
	bc 12,2,.L246
	cmpwi 0,3,1
	bc 12,2,.L247
	b .L250
.L246:
	li 31,1
	b .L249
.L247:
	li 31,0
	b .L249
.L250:
	li 31,-1
.L249:
	lis 9,gi+36@ha
	lis 3,.LC52@ha
	lwz 0,gi+36@l(9)
	la 3,.LC52@l(3)
	li 27,1
	lis 23,maxclients@ha
	mtlr 0
	blrl
	lis 9,.LC59@ha
	mr 4,3
	la 9,.LC59@l(9)
	mr 3,31
	lfs 1,0(9)
	bl teamSound
	lwz 11,84(28)
	lis 4,.LC53@ha
	mr 3,28
	la 4,.LC53@l(4)
	li 5,9
	lwz 9,3432(11)
	addi 9,9,9
	stw 9,3432(11)
	bl gsLogScore
	lis 11,maxclients@ha
	lis 9,.LC59@ha
	lwz 10,maxclients@l(11)
	la 9,.LC59@l(9)
	lfs 13,0(9)
	lfs 0,20(10)
	lis 9,g_edicts@ha
	lwz 31,g_edicts@l(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L252
	lis 26,.LC55@ha
	lis 24,0x4330
.L254:
	addi 31,31,916
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L253
	lwz 29,84(31)
	lwz 9,84(28)
	lwz 3,3476(29)
	lwz 0,3476(9)
	cmpw 0,3,0
	bc 12,2,.L267
	lis 0,0xc0a0
	stw 0,3440(29)
	b .L253
.L267:
	lis 10,.LC60@ha
	lfs 0,3444(29)
	la 30,level@l(22)
	la 10,.LC60@l(10)
	lfs 13,4(30)
	lfs 12,0(10)
	fadds 0,0,12
	fcmpu 0,0,13
	bc 4,1,.L259
	addi 29,29,700
	bl nameForTeam
	lwz 9,gi@l(25)
	mr 7,3
	lis 4,.LC54@ha
	la 4,.LC54@l(4)
	li 3,2
	la 5,.LC55@l(26)
	mtlr 9
	mr 6,29
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	li 5,1
	lwz 9,3432(11)
	addi 9,9,1
	stw 9,3432(11)
	bl gsLogScore
.L259:
	lwz 6,84(31)
	lis 9,.LC61@ha
	la 9,.LC61@l(9)
	lfs 12,4(30)
	lfs 0,0(9)
	lfs 13,3452(6)
	fadds 13,13,0
	fcmpu 0,13,12
	bc 4,1,.L253
	lwz 0,3476(6)
	la 30,gi@l(25)
	addi 29,6,700
	cmpwi 0,0,0
	bc 12,2,.L261
	cmpwi 0,0,1
	bc 12,2,.L262
	b .L265
.L261:
	li 3,1
	b .L264
.L262:
	li 3,0
	b .L264
.L265:
	li 3,-1
.L264:
	bl nameForTeam
	lwz 0,0(30)
	mr 7,3
	lis 4,.LC57@ha
	la 4,.LC57@l(4)
	li 3,2
	la 5,.LC55@l(26)
	mr 6,29
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lis 4,.LC58@ha
	mr 3,31
	la 4,.LC58@l(4)
	li 5,2
	lwz 9,3432(11)
	addi 9,9,2
	stw 9,3432(11)
	bl gsLogScore
.L253:
	addi 27,27,1
	lwz 11,maxclients@l(23)
	xoris 0,27,0x8000
	lis 10,.LC62@ha
	stw 0,12(1)
	la 10,.LC62@l(10)
	stw 24,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L254
.L252:
	bl CTFResetFlags
	lwz 0,68(1)
	mtlr 0
	lmw 22,16(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 CTFCapture,.Lfe8-CTFCapture
	.section	".rodata"
	.align 2
.LC63:
	.string	"%s %s the %s flag!\n"
	.align 2
.LC64:
	.string	"\322\305\324\325\322\316\305\304"
	.align 2
.LC65:
	.string	"Flag Return"
	.align 2
.LC66:
	.string	"world/train2.wav"
	.align 2
.LC67:
	.string	"world/fuseout.wav"
	.align 2
.LC68:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CTFReturnFlag
	.type	 CTFReturnFlag,@function
CTFReturnFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 27,4
	mr 31,3
	lwz 29,84(27)
	lis 28,gi@ha
	lwz 3,908(31)
	la 26,gi@l(28)
	addi 29,29,700
	bl nameForTeam
	lwz 0,gi@l(28)
	mr 7,3
	lis 4,.LC63@ha
	lis 6,.LC64@ha
	la 4,.LC63@l(4)
	la 6,.LC64@l(6)
	mtlr 0
	mr 5,29
	li 3,2
	crxor 6,6,6
	blrl
	lwz 11,84(27)
	lis 4,.LC65@ha
	li 5,1
	la 4,.LC65@l(4)
	mr 3,27
	lwz 9,3432(11)
	addi 9,9,1
	stw 9,3432(11)
	bl gsLogScore
	lis 9,level+4@ha
	lwz 11,84(27)
	lis 3,.LC66@ha
	lfs 0,level+4@l(9)
	la 3,.LC66@l(3)
	stfs 0,3444(11)
	lwz 0,36(26)
	lwz 29,908(31)
	mtlr 0
	blrl
	lis 9,.LC68@ha
	mr 4,3
	la 9,.LC68@l(9)
	mr 3,29
	lfs 1,0(9)
	bl teamSound
	lwz 0,908(31)
	cmpwi 0,0,0
	bc 12,2,.L269
	cmpwi 0,0,1
	bc 12,2,.L270
	b .L273
.L269:
	li 29,1
	b .L272
.L270:
	li 29,0
	b .L272
.L273:
	li 29,-1
.L272:
	lis 9,gi+36@ha
	lis 3,.LC67@ha
	lwz 0,gi+36@l(9)
	la 3,.LC67@l(3)
	mtlr 0
	blrl
	lis 9,.LC68@ha
	mr 4,3
	la 9,.LC68@l(9)
	mr 3,29
	lfs 1,0(9)
	bl teamSound
	lwz 31,908(31)
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	addi 11,9,60
	slwi 0,31,2
	lwzx 3,11,0
	addi 9,9,68
	lwzx 28,9,0
	cmpwi 0,3,0
	bc 12,2,.L274
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L274
	bl G_FreeEdict
.L274:
	lwz 0,184(28)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(28)
	mr 3,28
	rlwinm 0,0,0,0,30
	stw 0,184(28)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,ctfgame@ha
	stw 29,80(28)
	slwi 10,31,2
	la 9,ctfgame@l(9)
	addi 11,9,68
	lwzx 0,11,10
	addi 9,9,60
	stwx 0,9,10
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 CTFReturnFlag,.Lfe9-CTFReturnFlag
	.section	".rodata"
	.align 2
.LC69:
	.string	"\307\322\301\302\302\305\304"
	.align 2
.LC70:
	.string	"Flag Pickup"
	.align 2
.LC71:
	.string	"ctf/flagtk.wav"
	.align 2
.LC72:
	.string	"world/fusein.wav"
	.align 2
.LC73:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CTFPickupFlag
	.type	 CTFPickupFlag,@function
CTFPickupFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	lwz 29,84(30)
	mr 26,5
	lis 28,gi@ha
	lwz 3,908(31)
	la 27,gi@l(28)
	addi 29,29,700
	bl nameForTeam
	lwz 0,gi@l(28)
	mr 7,3
	lis 4,.LC63@ha
	lis 6,.LC69@ha
	la 4,.LC63@l(4)
	la 6,.LC69@l(6)
	mtlr 0
	mr 5,29
	li 3,2
	crxor 6,6,6
	blrl
	lis 4,.LC70@ha
	li 5,0
	la 4,.LC70@l(4)
	mr 3,30
	bl gsLogScore
	lwz 0,36(27)
	lis 3,.LC71@ha
	la 3,.LC71@l(3)
	lwz 29,908(31)
	mtlr 0
	blrl
	lis 9,.LC73@ha
	mr 4,3
	la 9,.LC73@l(9)
	mr 3,29
	lfs 1,0(9)
	bl teamSound
	lwz 0,908(31)
	cmpwi 0,0,0
	bc 12,2,.L277
	cmpwi 0,0,1
	bc 12,2,.L278
	b .L281
.L277:
	li 29,1
	b .L280
.L278:
	li 29,0
	b .L280
.L281:
	li 29,-1
.L280:
	lis 9,gi+36@ha
	lis 3,.LC72@ha
	lwz 0,gi+36@l(9)
	la 3,.LC72@l(3)
	mtlr 0
	blrl
	lis 9,.LC73@ha
	mr 4,3
	la 9,.LC73@l(9)
	mr 3,29
	lfs 1,0(9)
	bl teamSound
	lwz 10,84(30)
	lis 8,ctfgame@ha
	lis 9,itemlist@ha
	la 8,ctfgame@l(8)
	la 9,itemlist@l(9)
	lwz 11,3476(10)
	lis 0,0x38e3
	subf 9,9,26
	addi 10,8,76
	ori 0,0,36409
	slwi 11,11,2
	mullw 9,9,0
	li 7,1
	stwx 30,10,11
	lis 6,level+4@ha
	addi 8,8,60
	lwz 11,84(30)
	srawi 9,9,3
	li 5,0
	slwi 9,9,2
	addi 11,11,744
	stwx 7,11,9
	lfs 0,level+4@l(6)
	lwz 10,84(30)
	stfs 0,3448(10)
	lwz 0,908(31)
	slwi 0,0,2
	stwx 5,8,0
	lwz 9,284(31)
	andis. 11,9,0x1
	bc 4,2,.L282
	lwz 0,264(31)
	lwz 9,184(31)
	oris 0,0,0x8000
	stw 11,248(31)
	ori 9,9,1
	stw 0,264(31)
	stw 9,184(31)
.L282:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 CTFPickupFlag,.Lfe10-CTFPickupFlag
	.section	".rodata"
	.align 2
.LC74:
	.string	"The %s flag has %s!\n"
	.align 2
.LC75:
	.long 0x3f800000
	.section	".text"
	.align 2
	.type	 CTFDropFlagThink,@function
CTFDropFlagThink:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 29,gi@ha
	lwz 3,908(31)
	la 28,gi@l(29)
	bl nameForTeam
	lwz 0,gi@l(29)
	mr 5,3
	lis 4,.LC74@ha
	lis 6,.LC64@ha
	la 4,.LC74@l(4)
	la 6,.LC64@l(6)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(28)
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	lwz 29,908(31)
	mtlr 0
	blrl
	lis 9,.LC75@ha
	mr 4,3
	la 9,.LC75@l(9)
	mr 3,29
	lfs 1,0(9)
	bl teamSound
	lwz 0,908(31)
	cmpwi 0,0,0
	bc 12,2,.L293
	cmpwi 0,0,1
	bc 12,2,.L294
	b .L297
.L293:
	li 29,1
	b .L296
.L294:
	li 29,0
	b .L296
.L297:
	li 29,-1
.L296:
	lis 9,gi+36@ha
	lis 3,.LC67@ha
	lwz 0,gi+36@l(9)
	la 3,.LC67@l(3)
	mtlr 0
	blrl
	lis 9,.LC75@ha
	mr 4,3
	la 9,.LC75@l(9)
	mr 3,29
	lfs 1,0(9)
	bl teamSound
	lwz 31,908(31)
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	addi 11,9,60
	slwi 0,31,2
	lwzx 3,11,0
	addi 9,9,68
	lwzx 28,9,0
	cmpwi 0,3,0
	bc 12,2,.L298
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L298
	bl G_FreeEdict
.L298:
	lwz 0,184(28)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(28)
	mr 3,28
	rlwinm 0,0,0,0,30
	stw 0,184(28)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,ctfgame@ha
	stw 29,80(28)
	slwi 10,31,2
	la 9,ctfgame@l(9)
	addi 11,9,68
	lwzx 0,11,10
	addi 9,9,60
	stwx 0,9,10
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 CTFDropFlagThink,.Lfe11-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC76:
	.string	"\314\317\323\324"
	.align 2
.LC77:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl CTFDeadDropFlag
	.type	 CTFDeadDropFlag,@function
CTFDeadDropFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,flag1_item@ha
	mr 31,3
	lwz 0,flag1_item@l(9)
	cmpwi 0,0,0
	bc 12,2,.L302
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	cmpwi 0,0,0
	bc 4,2,.L301
.L302:
	bl CTFInit
.L301:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 4,flag1_item@l(9)
	la 8,itemlist@l(11)
	lis 11,0x38e3
	addi 10,10,744
	ori 11,11,36409
	subf 0,8,4
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L322
	lis 9,flag2_item@ha
	lwz 4,flag2_item@l(9)
	subf 0,8,4
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L300
.L322:
	mr 30,4
	mr 3,31
	mr 4,30
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L307
	cmpwi 0,0,1
	bc 12,2,.L308
	b .L311
.L307:
	li 0,1
	b .L310
.L308:
	li 0,0
	b .L310
.L311:
	li 0,-1
.L310:
	stw 0,908(29)
	lis 11,ctfgame@ha
	li 10,0
	lwz 9,84(31)
	la 11,ctfgame@l(11)
	addi 11,11,76
	lwz 0,3476(9)
	slwi 0,0,2
	stwx 10,11,0
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L312
	cmpwi 0,0,1
	bc 12,2,.L313
	b .L316
.L312:
	li 10,1
	b .L315
.L313:
	li 10,0
	b .L315
.L316:
	li 10,-1
.L315:
	lis 11,ctfgame@ha
	lis 9,itemlist@ha
	la 11,ctfgame@l(11)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	subf 9,9,30
	slwi 10,10,2
	addi 11,11,60
	ori 0,0,36409
	stwx 29,11,10
	li 8,0
	mullw 9,9,0
	lwz 10,84(31)
	lis 11,gi@ha
	la 30,gi@l(11)
	srawi 9,9,3
	addi 10,10,744
	slwi 9,9,2
	stwx 8,10,9
	lwz 11,84(31)
	lwz 0,3476(11)
	addi 31,11,700
	cmpwi 0,0,0
	bc 12,2,.L317
	cmpwi 0,0,1
	bc 12,2,.L318
	b .L321
.L317:
	li 3,1
	b .L320
.L318:
	li 3,0
	b .L320
.L321:
	li 3,-1
.L320:
	bl nameForTeam
	lwz 0,0(30)
	mr 7,3
	lis 4,.LC63@ha
	lis 6,.LC76@ha
	la 4,.LC63@l(4)
	mr 5,31
	la 6,.LC76@l(6)
	mtlr 0
	li 3,2
	crxor 6,6,6
	blrl
	lis 11,CTFDropFlagThink@ha
	lis 9,.LC77@ha
	la 11,CTFDropFlagThink@l(11)
	la 9,.LC77@l(9)
	lis 10,level+4@ha
	stw 11,436(29)
	lfs 0,level+4@l(10)
	lfs 13,0(9)
	lis 9,CTFDropFlagTouch@ha
	la 9,CTFDropFlagTouch@l(9)
	fadds 0,0,13
	stw 9,444(29)
	stfs 0,428(29)
.L300:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 CTFDeadDropFlag,.Lfe12-CTFDeadDropFlag
	.section	".rodata"
	.align 2
.LC78:
	.string	"CTF is about carrier survival under fire\n\nIf you want to pass off the flag, you must do it by killing yourself in a situation where a teammate can grab the flag safely.\n"
	.align 2
.LC79:
	.string	"%s has the blue flag\n"
	.align 2
.LC80:
	.string	"********************************\n%s is supposed to have the blue flag, but doesn't!!!!!!!!\n"
	.align 2
.LC81:
	.string	"Blue flag is at base\n"
	.align 2
.LC82:
	.string	"Blue flag is dropped somewhere\n"
	.align 2
.LC83:
	.string	"%s has the red flag\n"
	.align 2
.LC84:
	.string	"********************************\n%s is supposed to have the red flag, but doesn't!!!!!!!!\n"
	.align 2
.LC85:
	.string	"Red flag is at base\n"
	.align 2
.LC86:
	.string	"Red flag is dropped somewhere\n"
	.section	".text"
	.align 2
	.globl flag_sanity
	.type	 flag_sanity,@function
flag_sanity:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,ctfgame@ha
	la 11,ctfgame@l(9)
	lwz 4,76(11)
	lwz 31,80(11)
	cmpwi 0,4,0
	bc 12,2,.L325
	lis 9,flag2_item@ha
	lis 11,itemlist@ha
	lwz 4,84(4)
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x38e3
	addi 10,4,744
	ori 9,9,36409
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L326
	lis 9,gi+4@ha
	lis 3,.LC79@ha
	lwz 0,gi+4@l(9)
	la 3,.LC79@l(3)
	b .L337
.L326:
	lis 9,gi+4@ha
	lis 3,.LC80@ha
	lwz 0,gi+4@l(9)
	la 3,.LC80@l(3)
.L337:
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L328
.L325:
	lwz 9,64(11)
	lwz 0,72(11)
	cmpw 0,0,9
	bc 4,2,.L329
	lis 9,gi+4@ha
	lis 3,.LC81@ha
	lwz 0,gi+4@l(9)
	la 3,.LC81@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L328
.L329:
	lis 9,gi+4@ha
	lis 3,.LC82@ha
	lwz 0,gi+4@l(9)
	la 3,.LC82@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L328:
	cmpwi 0,31,0
	bc 12,2,.L331
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 4,84(31)
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x38e3
	addi 10,4,744
	ori 9,9,36409
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L332
	lis 9,gi+4@ha
	lis 3,.LC83@ha
	lwz 0,gi+4@l(9)
	la 3,.LC83@l(3)
	b .L338
.L332:
	lis 9,gi+4@ha
	lis 3,.LC84@ha
	lwz 0,gi+4@l(9)
	la 3,.LC84@l(3)
.L338:
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L334
.L331:
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	lwz 11,60(9)
	lwz 0,68(9)
	cmpw 0,0,11
	bc 4,2,.L335
	lis 9,gi+4@ha
	lis 3,.LC85@ha
	lwz 0,gi+4@l(9)
	la 3,.LC85@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L334
.L335:
	lis 9,gi+4@ha
	lis 3,.LC86@ha
	lwz 0,gi+4@l(9)
	la 3,.LC86@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L334:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 flag_sanity,.Lfe13-flag_sanity
	.section	".rodata"
	.align 2
.LC88:
	.string	"CTFFlagSetup: %s startsolid at %s\n"
	.align 3
.LC89:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC90:
	.long 0xc1700000
	.align 2
.LC91:
	.long 0x41700000
	.align 2
.LC92:
	.long 0x0
	.align 2
.LC93:
	.long 0xc3000000
	.align 2
.LC94:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl CTFFlagSetup
	.type	 CTFFlagSetup,@function
CTFFlagSetup:
	stwu 1,-112(1)
	mflr 0
	stmw 28,96(1)
	stw 0,116(1)
	lis 8,.LC90@ha
	lis 9,.LC90@ha
	lis 11,.LC90@ha
	la 8,.LC90@l(8)
	la 9,.LC90@l(9)
	la 11,.LC90@l(11)
	lfs 1,0(8)
	lfs 2,0(9)
	mr 31,3
	lfs 3,0(11)
	bl tv
	mr 11,3
	lis 8,.LC91@ha
	lfs 13,0(11)
	la 8,.LC91@l(8)
	lis 9,.LC91@ha
	lfs 1,0(8)
	la 9,.LC91@l(9)
	lis 8,.LC91@ha
	lfs 2,0(9)
	stfs 13,188(31)
	la 8,.LC91@l(8)
	lfs 0,4(11)
	lfs 3,0(8)
	stfs 0,192(31)
	lfs 13,8(11)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lwz 4,268(31)
	lfs 13,0(11)
	cmpwi 0,4,0
	stfs 13,200(31)
	lfs 0,4(11)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bc 12,2,.L342
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L343
.L342:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L343:
	lis 8,.LC92@ha
	li 11,1
	la 8,.LC92@l(8)
	stw 11,248(31)
	lis 9,Touch_Item@ha
	lfs 1,0(8)
	lis 11,.LC92@ha
	la 9,Touch_Item@l(9)
	lis 8,.LC93@ha
	la 11,.LC92@l(11)
	stw 9,444(31)
	la 8,.LC93@l(8)
	lfs 2,0(11)
	li 0,7
	lfs 3,0(8)
	addi 29,31,4
	stw 0,260(31)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 9,gi@ha
	lfs 0,0(11)
	la 30,gi@l(9)
	addi 3,1,8
	lfs 12,8(31)
	mr 4,29
	addi 5,31,188
	lfs 13,12(31)
	addi 6,31,200
	addi 7,1,72
	fadds 11,11,0
	lwz 10,48(30)
	mr 8,31
	li 9,3
	mtlr 10
	stfs 11,72(1)
	lfs 0,4(11)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(11)
	fadds 13,13,0
	stfs 13,80(1)
	blrl
	lwz 28,12(1)
	cmpwi 0,28,0
	bc 12,2,.L344
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC88@ha
	la 3,.LC88@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L341
.L344:
	lfs 12,20(1)
	lis 3,.LC1@ha
	lfs 13,24(1)
	la 3,.LC1@l(3)
	lfs 0,28(1)
	lwz 4,280(31)
	stfs 12,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
	bl Q_stricmp
	addic 8,3,-1
	subfe 0,8,3
	lis 9,ctfgame@ha
	stw 0,908(31)
	la 9,ctfgame@l(9)
	slwi 10,0,2
	lwz 8,72(30)
	addi 11,9,68
	mr 3,31
	stwx 31,11,10
	addi 9,9,60
	mtlr 8
	lwz 0,908(31)
	slwi 0,0,2
	stwx 31,9,0
	blrl
	lis 11,level+4@ha
	lis 10,.LC89@ha
	lfs 0,level+4@l(11)
	lis 9,CTFFlagThink@ha
	lfd 13,.LC89@l(10)
	la 9,CTFFlagThink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bl G_Spawn
	mr 29,3
	bl SP_misc_teleporter_dest
	lwz 9,76(30)
	mr 3,29
	mtlr 9
	blrl
	lfs 0,4(31)
	lis 8,.LC94@ha
	mr 3,29
	la 8,.LC94@l(8)
	lwz 11,64(29)
	lfs 12,0(8)
	stfs 0,4(29)
	ori 10,11,32768
	lfs 13,8(31)
	oris 11,11,0x1
	stfs 13,8(29)
	lfs 0,12(31)
	stw 28,248(29)
	fadds 0,0,12
	stfs 0,12(29)
	lwz 0,908(31)
	xori 0,0,1
	srawi 8,0,31
	xor 9,8,0
	subf 9,9,8
	srawi 9,9,31
	andc 10,10,9
	and 11,11,9
	or 11,11,10
	stw 11,64(29)
	lwz 0,72(30)
	mtlr 0
	blrl
.L341:
	lwz 0,116(1)
	mtlr 0
	lmw 28,96(1)
	la 1,112(1)
	blr
.Lfe14:
	.size	 CTFFlagSetup,.Lfe14-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC95:
	.string	"players/male/flag1.md2"
	.align 2
.LC96:
	.string	"players/male/flag2.md2"
	.section	".text"
	.align 2
	.globl CTFEffects
	.type	 CTFEffects,@function
CTFEffects:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,480(31)
	lwz 9,64(31)
	cmpwi 0,0,0
	rlwinm 8,9,0,12,13
	stw 8,64(31)
	bc 4,1,.L351
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 7,itemlist@l(11)
	lis 10,0x38e3
	ori 10,10,36409
	lwz 11,84(31)
	subf 0,7,0
	mullw 0,0,10
	addi 11,11,744
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L352
	oris 0,8,0x4
	stw 0,64(31)
.L352:
	lis 9,flag2_item@ha
	lwz 11,84(31)
	lwz 0,flag2_item@l(9)
	addi 11,11,744
	subf 0,7,0
	mullw 0,0,10
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L351
	lwz 0,64(31)
	oris 0,0,0x8
	stw 0,64(31)
.L351:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag1_item@l(9)
	la 8,itemlist@l(11)
	lis 11,0x38e3
	addi 10,10,744
	ori 11,11,36409
	subf 0,8,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L354
	lis 9,gi+32@ha
	lis 3,.LC95@ha
	lwz 0,gi+32@l(9)
	la 3,.LC95@l(3)
	b .L358
.L354:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	subf 0,8,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 10,10,0
	cmpwi 0,10,0
	bc 12,2,.L356
	lis 9,gi+32@ha
	lis 3,.LC96@ha
	lwz 0,gi+32@l(9)
	la 3,.LC96@l(3)
.L358:
	mtlr 0
	blrl
	stw 3,48(31)
	b .L355
.L356:
	stw 10,48(31)
.L355:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 CTFEffects,.Lfe15-CTFEffects
	.section	".rodata"
	.align 2
.LC97:
	.long 0x0
	.align 3
.LC98:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFCalcScores
	.type	 CTFCalcScores,@function
CTFCalcScores:
	stwu 1,-16(1)
	lis 9,ctfgame@ha
	lis 11,maxclients@ha
	la 8,ctfgame@l(9)
	lwz 7,maxclients@l(11)
	li 0,0
	lis 9,.LC97@ha
	stw 0,44(8)
	li 6,0
	la 9,.LC97@l(9)
	stw 0,48(8)
	lfs 13,0(9)
	lfs 0,20(7)
	fcmpu 0,13,0
	bc 4,0,.L361
	lis 9,g_edicts@ha
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	mr 5,7
	la 11,game@l(11)
	lis 9,.LC98@ha
	lis 4,0x4330
	la 9,.LC98@l(9)
	addi 10,10,1004
	lfd 12,0(9)
	li 7,0
.L363:
	lwz 0,0(10)
	addi 10,10,916
	cmpwi 0,0,0
	bc 12,2,.L362
	lwz 0,1028(11)
	add 9,7,0
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 4,2,.L365
	lwz 9,3432(9)
	lwz 0,44(8)
	add 0,0,9
	stw 0,44(8)
	b .L362
.L365:
	cmpwi 0,0,1
	bc 4,2,.L362
	lwz 9,3432(9)
	lwz 0,48(8)
	add 0,0,9
	stw 0,48(8)
.L362:
	addi 6,6,1
	lfs 13,20(5)
	xoris 0,6,0x8000
	addi 7,7,4596
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L363
.L361:
	la 1,16(1)
	blr
.Lfe16:
	.size	 CTFCalcScores,.Lfe16-CTFCalcScores
	.section	".rodata"
	.align 2
.LC99:
	.string	"i_ctf1t"
	.align 2
.LC100:
	.string	"i_ctf2t"
	.align 2
.LC101:
	.string	"i_ctf1"
	.align 2
.LC102:
	.string	"i_ctf2"
	.align 2
.LC103:
	.string	"i_ctf1d"
	.align 2
.LC104:
	.string	"i_ctf2d"
	.align 2
.LC105:
	.string	"ctfsb1"
	.align 2
.LC106:
	.string	"ctfsb2"
	.align 2
.LC107:
	.string	"notd"
	.align 2
.LC108:
	.string	"sbfctf2"
	.align 2
.LC109:
	.string	"sbfctf1"
	.align 2
.LC110:
	.string	"i_ctfj"
	.align 2
.LC111:
	.long 0x0
	.align 2
.LC112:
	.long 0x40a00000
	.align 3
.LC113:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SetCTFStats
	.type	 SetCTFStats,@function
SetCTFStats:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC105@ha
	lwz 9,40(29)
	la 3,.LC105@l(3)
	lis 30,level@ha
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC106@ha
	sth 3,168(9)
	lwz 0,40(29)
	la 3,.LC106@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 10,.LC111@ha
	lis 11,level+200@ha
	la 10,.LC111@l(10)
	sth 3,170(9)
	lfs 13,0(10)
	lfs 0,level+200@l(11)
	lis 10,ctfgame@ha
	fcmpu 0,0,13
	bc 12,2,.L383
	lwz 0,level@l(30)
	andi. 11,0,8
	bc 12,2,.L383
	la 11,ctfgame@l(10)
	lwz 9,ctfgame@l(10)
	lwz 0,4(11)
	cmpw 0,9,0
	bc 12,1,.L434
	cmpw 0,0,9
	bc 12,1,.L435
	lwz 9,48(11)
	lwz 0,44(11)
	cmpw 0,0,9
	bc 4,1,.L388
.L434:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	b .L383
.L388:
	cmpw 0,9,0
	bc 4,1,.L390
.L435:
	lwz 9,84(31)
	li 0,0
	sth 0,170(9)
	b .L383
.L390:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	lwz 11,84(31)
	sth 0,170(11)
.L383:
	lis 9,ctfgame@ha
	lis 11,gi@ha
	la 10,ctfgame@l(9)
	la 11,gi@l(11)
	lwz 9,60(10)
	cmpwi 0,9,0
	bc 4,2,.L392
	lis 9,.LC99@ha
	la 3,.LC99@l(9)
	b .L395
.L392:
	lwz 0,68(10)
	cmpw 0,0,9
	bc 4,2,.L397
	lis 9,.LC101@ha
	la 3,.LC101@l(9)
	b .L395
.L397:
	lis 9,.LC103@ha
	la 3,.LC103@l(9)
.L395:
	lwz 0,40(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 11,ctfgame@ha
	lis 10,gi@ha
	la 8,ctfgame@l(11)
	la 10,gi@l(10)
	sth 3,154(9)
	lwz 11,64(8)
	cmpwi 0,11,0
	bc 4,2,.L403
	lis 9,.LC100@ha
	la 3,.LC100@l(9)
	b .L406
.L403:
	lwz 0,72(8)
	cmpw 0,0,11
	bc 4,2,.L412
	lis 9,.LC102@ha
	la 3,.LC102@l(9)
	b .L406
.L412:
	lis 9,.LC104@ha
	la 3,.LC104@l(9)
.L406:
	lwz 0,40(10)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 11,ctfgame@ha
	lis 10,.LC111@ha
	la 10,.LC111@l(10)
	la 11,ctfgame@l(11)
	sth 3,158(9)
	lfs 0,0(10)
	lfs 12,52(11)
	fcmpu 0,12,0
	bc 12,2,.L414
	lis 9,level+4@ha
	lis 10,.LC112@ha
	lfs 0,level+4@l(9)
	la 10,.LC112@l(10)
	lfs 13,0(10)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L414
	lwz 0,level@l(30)
	andi. 9,0,8
	bc 12,2,.L414
	lwz 11,56(11)
	cmpwi 0,11,0
	bc 4,2,.L415
	lwz 9,84(31)
	sth 11,154(9)
	b .L414
.L415:
	lwz 9,84(31)
	li 0,0
	sth 0,158(9)
.L414:
	lis 11,ctfgame@ha
	lwz 10,84(31)
	lis 9,sv_expflags@ha
	la 29,ctfgame@l(11)
	lwz 8,sv_expflags@l(9)
	lhz 0,2(29)
	sth 0,156(10)
	lwz 9,84(31)
	lhz 0,6(29)
	sth 0,160(9)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 10,11,32768
	bc 12,2,.L417
	lwz 3,84(31)
	lis 30,.LC107@ha
	la 4,.LC107@l(30)
	addi 3,3,188
	bl Info_ValueForKey
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 3,84(31)
	la 4,.LC107@l(30)
	addi 3,3,188
	bl Info_ValueForKey
	lbz 0,0(3)
	cmpwi 0,0,48
	bc 4,2,.L417
.L418:
	lwz 9,40(29)
	lis 0,0x4330
	lis 11,.LC113@ha
	addi 9,9,2
	la 11,.LC113@l(11)
	xoris 9,9,0x8000
	lfd 13,0(11)
	stw 9,28(1)
	lis 11,level@ha
	stw 0,24(1)
	la 30,level@l(11)
	lfd 0,24(1)
	lfs 12,4(30)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L419
	bl countPlayers
	bl convertToPics
	lfs 0,4(30)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,40(29)
.L419:
	lwz 7,84(31)
	lwz 0,3476(7)
	slwi 11,0,4
	cmpwi 0,0,0
	add 9,29,11
	lhz 10,10(9)
	mr 8,9
	mr 6,8
	sth 10,180(7)
	mr 11,6
	lhz 0,14(8)
	lwz 9,84(31)
	sth 0,182(9)
	lwz 9,84(31)
	lhz 10,18(6)
	sth 10,172(9)
	lhz 0,22(11)
	lwz 9,84(31)
	sth 0,152(9)
	bc 4,2,.L421
	lis 29,gi@ha
	lis 3,.LC108@ha
	la 29,gi@l(29)
	la 3,.LC108@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC109@ha
	sth 3,134(9)
	lwz 0,40(29)
	la 3,.LC109@l(11)
	b .L436
.L421:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC108@ha
	sth 3,134(9)
	lwz 0,40(29)
	la 3,.LC108@l(11)
.L436:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,136(9)
.L417:
	lwz 9,84(31)
	li 0,0
	lis 11,ctfgame@ha
	la 11,ctfgame@l(11)
	sth 0,162(9)
	addi 11,11,76
	lwz 9,84(31)
	lwz 10,3476(9)
	slwi 0,10,2
	lwzx 9,11,0
	cmpw 0,31,9
	bc 4,2,.L423
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L423
	cmpwi 0,10,0
	bc 4,2,.L425
	lis 9,gi+40@ha
	lis 3,.LC102@ha
	lwz 0,gi+40@l(9)
	la 3,.LC102@l(3)
	b .L437
.L425:
	lis 9,gi+40@ha
	lis 3,.LC101@ha
	lwz 0,gi+40@l(9)
	la 3,.LC101@l(3)
.L437:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,162(9)
.L423:
	lwz 11,84(31)
	li 0,0
	sth 0,164(11)
	lwz 9,84(31)
	sth 0,166(9)
	lwz 11,84(31)
	lwz 0,3476(11)
	cmpwi 0,0,0
	bc 4,2,.L427
	lis 9,gi+40@ha
	lis 3,.LC110@ha
	lwz 0,gi+40@l(9)
	la 3,.LC110@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,164(9)
	b .L428
.L427:
	cmpwi 0,0,1
	bc 4,2,.L428
	lis 9,gi+40@ha
	lis 3,.LC110@ha
	lwz 0,gi+40@l(9)
	la 3,.LC110@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,166(9)
.L428:
	lis 9,ctfgame+76@ha
	lwz 10,ctfgame+76@l(9)
	cmpwi 0,10,0
	bc 4,2,.L430
	li 0,0
	b .L431
.L430:
	lis 11,g_edicts@ha
	lis 0,0x478b
	lwz 9,g_edicts@l(11)
	ori 0,0,48365
	addis 9,9,0xffea
	addi 9,9,5504
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,2
	addi 0,9,-1
.L431:
	lwz 9,84(31)
	lis 11,ctfgame+80@ha
	sth 0,176(9)
	lwz 10,ctfgame+80@l(11)
	cmpwi 0,10,0
	bc 4,2,.L432
	li 0,0
	b .L433
.L432:
	lis 11,g_edicts@ha
	lis 0,0x478b
	lwz 9,g_edicts@l(11)
	ori 0,0,48365
	addis 9,9,0xffea
	addi 9,9,5504
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,2
	addi 0,9,-1
.L433:
	lwz 9,84(31)
	sth 0,178(9)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 SetCTFStats,.Lfe17-SetCTFStats
	.section	".rodata"
	.align 2
.LC114:
	.string	"if 24 xv 8 yv 8 pic 24 endif xv 40 yv 28 string \"%4d/%-3d\" xv 98 yv 12 num 2 18 if 25 xv 168 yv 8 pic 25 endif xv 200 yv 28 string \"%4d/%-3d\" xv 256 yv 12 num 2 20 "
	.align 2
.LC115:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC116:
	.string	"xv 56 yv %d picn sbfctf2 "
	.align 2
.LC117:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC118:
	.string	"xv 216 yv %d picn sbfctf1 "
	.align 2
.LC119:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC120:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC121:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC122:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC123:
	.long 0x0
	.align 3
.LC124:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFScoreboardMessage
	.type	 CTFScoreboardMessage,@function
CTFScoreboardMessage:
	stwu 1,-6656(1)
	mflr 0
	mfcr 12
	stmw 14,6584(1)
	stw 0,6660(1)
	stw 12,6580(1)
	lis 9,game@ha
	li 0,0
	la 8,game@l(9)
	addi 11,1,6536
	lwz 10,1544(8)
	li 26,0
	li 24,0
	stw 0,4(11)
	li 25,0
	addi 9,1,6544
	stw 0,6536(1)
	cmpw 0,24,10
	mr 17,11
	stw 26,4(9)
	mr 15,9
	addi 21,1,1032
	stw 26,6544(1)
	bc 4,0,.L442
	mr 18,8
	lis 16,g_edicts@ha
	mr 19,15
	mr 20,17
.L444:
	mulli 9,24,916
	lwz 11,g_edicts@l(16)
	addi 22,24,1
	addi 9,9,916
	add 31,11,9
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L443
	mr 3,31
	bl playerIsOnATeam
	cmpwi 0,3,0
	bc 12,2,.L443
	lwz 0,1028(18)
	mulli 9,24,4596
	li 27,0
	addi 6,1,4488
	addi 3,1,2440
	add 9,9,0
	lwz 10,3476(9)
	lwz 29,3432(9)
	slwi 0,10,2
	lwzx 11,17,0
	cmpw 0,27,11
	bc 4,0,.L448
	slwi 0,10,10
	lwzx 9,6,0
	mr 7,0
	cmpw 0,29,9
	bc 12,1,.L448
	mr 9,11
	add 11,7,6
.L449:
	addi 27,27,1
	cmpw 0,27,9
	bc 4,0,.L448
	lwzu 0,4(11)
	cmpw 0,29,0
	bc 4,1,.L449
.L448:
	slwi 0,10,2
	slwi 7,10,10
	lwzx 28,17,0
	mr 4,0
	slwi 23,27,2
	cmpw 0,28,27
	bc 4,1,.L454
	addi 11,3,-4
	slwi 9,28,2
	add 11,7,11
	addi 0,6,-4
	add 0,7,0
	add 10,9,11
	mr 30,3
	add 8,9,0
	add 11,9,7
	mr 5,6
.L456:
	lwz 9,0(10)
	addi 28,28,-1
	cmpw 0,28,27
	addi 10,10,-4
	stwx 9,11,30
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L456
.L454:
	add 0,23,7
	stwx 24,3,0
	stwx 29,6,0
	lwzx 9,4,19
	lwzx 11,4,20
	add 9,9,29
	addi 11,11,1
	stwx 9,4,19
	stwx 11,4,20
.L443:
	lwz 0,1544(18)
	mr 24,22
	cmpw 0,24,0
	bc 12,0,.L444
.L442:
	li 0,0
	lwz 7,4(15)
	lis 4,.LC114@ha
	lwz 8,4(17)
	la 4,.LC114@l(4)
	mr 3,21
	lwz 5,6544(1)
	li 24,0
	lwz 6,6536(1)
	stb 0,1032(1)
	crxor 6,6,6
	bl sprintf
	mr 3,21
	bl strlen
	lwz 0,6536(1)
	mr 22,3
	b .L491
.L463:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,24,9
	bc 4,0,.L464
	addi 29,1,2440
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,916
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,4596
	addi 9,9,916
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC115@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC115@l(4)
	cmpwi 7,11,1000
	lwz 7,3432(30)
	add 3,23,3
	mr 5,27
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 11,11,0
	andi. 8,8,999
	or 8,11,8
	crxor 6,6,6
	bl sprintf
	lis 9,flag2_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x38e3
	addi 10,10,744
	ori 9,9,36409
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L466
	mr 3,23
	bl strlen
	lis 4,.LC116@ha
	mr 5,27
	la 4,.LC116@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L466:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L464
	mr 4,23
	mr 3,21
	bl strcat
	mr 25,24
	mr 3,21
	bl strlen
	mr 22,3
.L464:
	lwz 0,4(17)
	cmpw 0,24,0
	bc 4,0,.L461
	addi 29,1,3464
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,916
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,4596
	addi 9,9,916
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC117@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC117@l(4)
	cmpwi 7,11,1000
	lwz 7,3432(30)
	add 3,23,3
	mr 5,27
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 11,11,0
	andi. 8,8,999
	or 8,11,8
	crxor 6,6,6
	bl sprintf
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x38e3
	addi 10,10,744
	ori 9,9,36409
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L470
	mr 3,23
	bl strlen
	lis 4,.LC118@ha
	mr 5,27
	la 4,.LC118@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L470:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L461
	mr 4,23
	mr 3,21
	bl strcat
	mr 26,24
	mr 3,21
	bl strlen
	mr 22,3
.L461:
	addi 24,24,1
	cmpwi 0,24,15
	bc 12,1,.L460
	lwz 0,6536(1)
.L491:
	cmpw 0,24,0
	bc 12,0,.L463
	lwz 0,4(17)
	cmpw 0,24,0
	bc 12,0,.L463
.L460:
	cmpw 7,25,26
	subfic 0,22,1000
	cmpwi 0,0,50
	li 18,0
	li 28,0
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,25,0
	and 0,26,0
	or 27,0,11
	slwi 9,27,3
	addi 27,9,58
	bc 4,1,.L475
	lis 9,maxclients@ha
	lis 10,.LC123@ha
	lwz 11,maxclients@l(9)
	la 10,.LC123@l(10)
	li 24,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L475
	lis 9,game@ha
	lis 14,g_edicts@ha
	la 15,game@l(9)
	mr 23,21
	lis 16,0x4330
	li 19,0
	li 20,916
.L479:
	lwz 0,g_edicts@l(14)
	lwz 11,1028(15)
	add 31,0,20
	lwz 9,88(31)
	add 30,11,19
	cmpwi 0,9,0
	bc 12,2,.L478
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L478
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,-1
	bc 4,2,.L478
	cmpwi 0,28,0
	bc 4,2,.L482
	lis 4,.LC119@ha
	mr 5,27
	addi 3,1,8
	la 4,.LC119@l(4)
	crxor 6,6,6
	bl sprintf
	li 28,1
	addi 27,27,8
	addi 4,1,8
	mr 3,23
	bl strcat
	mr 3,23
	bl strlen
	mr 22,3
.L482:
	addi 3,1,8
	subfic 29,22,1000
	mr 31,3
	bl strlen
	lwz 11,184(30)
	rlwinm 5,18,0,31,31
	lis 4,.LC120@ha
	cmpwi 4,5,0
	lwz 8,3432(30)
	la 4,.LC120@l(4)
	cmpwi 7,11,1000
	neg 5,5
	andi. 5,5,160
	mr 6,27
	mr 7,24
	add 3,31,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 11,11,0
	andi. 9,9,999
	or 9,11,9
	crxor 6,6,6
	bl sprintf
	mr 3,31
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L486
	mr 4,31
	mr 3,23
	bl strcat
	mr 3,23
	bl strlen
	mr 22,3
.L486:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,27,8
	neg 0,0
	addi 18,18,1
	andc 9,9,0
	and 0,27,0
	or 27,0,9
.L478:
	lis 10,maxclients@ha
	addi 24,24,1
	lwz 11,maxclients@l(10)
	xoris 0,24,0x8000
	lis 10,.LC124@ha
	stw 0,6572(1)
	addi 19,19,4596
	la 10,.LC124@l(10)
	stw 16,6568(1)
	addi 20,20,916
	lfd 12,0(10)
	lfd 0,6568(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L479
.L475:
	lwz 0,6536(1)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L489
	mr 3,21
	bl strlen
	lwz 6,6536(1)
	slwi 5,25,3
	lis 4,.LC121@ha
	la 4,.LC121@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L489:
	lwz 0,4(17)
	subf 0,26,0
	cmpwi 0,0,1
	bc 4,1,.L490
	mr 3,21
	bl strlen
	lwz 6,4(17)
	slwi 5,26,3
	lis 4,.LC122@ha
	la 4,.LC122@l(4)
	addi 5,5,50
	subf 6,26,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L490:
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
	lwz 0,6660(1)
	lwz 12,6580(1)
	mtlr 0
	lmw 14,6584(1)
	mtcrf 8,12
	la 1,6656(1)
	blr
.Lfe18:
	.size	 CTFScoreboardMessage,.Lfe18-CTFScoreboardMessage
	.globl loc_names
	.section	".data"
	.align 2
	.type	 loc_names,@object
loc_names:
	.long .LC1
	.long 1
	.long .LC2
	.long 1
	.long .LC125
	.long 2
	.long .LC126
	.long 2
	.long .LC127
	.long 3
	.long .LC128
	.long 4
	.long .LC129
	.long 4
	.long .LC130
	.long 4
	.long .LC131
	.long 4
	.long .LC132
	.long 4
	.long .LC133
	.long 4
	.long .LC134
	.long 4
	.long .LC135
	.long 4
	.long .LC136
	.long 5
	.long .LC137
	.long 5
	.long .LC138
	.long 6
	.long .LC139
	.long 6
	.long .LC140
	.long 6
	.long .LC141
	.long 7
	.long .LC142
	.long 7
	.long .LC143
	.long 7
	.long .LC144
	.long 7
	.long .LC145
	.long 8
	.long .LC146
	.long 8
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC146:
	.string	"item_pack"
	.align 2
.LC145:
	.string	"item_bandolier"
	.align 2
.LC144:
	.string	"item_adrenaline"
	.align 2
.LC143:
	.string	"item_enviro"
	.align 2
.LC142:
	.string	"item_breather"
	.align 2
.LC141:
	.string	"item_silencer"
	.align 2
.LC140:
	.string	"item_armor_jacket"
	.align 2
.LC139:
	.string	"item_armor_combat"
	.align 2
.LC138:
	.string	"item_armor_body"
	.align 2
.LC137:
	.string	"item_power_shield"
	.align 2
.LC136:
	.string	"item_power_screen"
	.align 2
.LC135:
	.string	"weapon_shotgun"
	.align 2
.LC134:
	.string	"weapon_supershotgun"
	.align 2
.LC133:
	.string	"weapon_machinegun"
	.align 2
.LC132:
	.string	"weapon_grenadelauncher"
	.align 2
.LC131:
	.string	"weapon_chaingun"
	.align 2
.LC130:
	.string	"weapon_hyperblaster"
	.align 2
.LC129:
	.string	"weapon_rocketlauncher"
	.align 2
.LC128:
	.string	"weapon_railgun"
	.align 2
.LC127:
	.string	"weapon_bfg"
	.align 2
.LC126:
	.string	"item_invulnerability"
	.align 2
.LC125:
	.string	"item_quad"
	.size	 loc_names,200
	.align 2
.LC148:
	.string	"nowhere"
	.align 2
.LC149:
	.string	"in the water "
	.align 2
.LC150:
	.string	"above "
	.align 2
.LC151:
	.string	"below "
	.align 2
.LC152:
	.string	"near "
	.align 2
.LC153:
	.string	"the red "
	.align 2
.LC154:
	.string	"the blue "
	.align 2
.LC155:
	.string	"the "
	.align 2
.LC147:
	.long 0x497423f0
	.align 2
.LC156:
	.long 0x44800000
	.align 3
.LC157:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC158:
	.long 0x0
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Location,@function
CTFSay_Team_Location:
	stwu 1,-128(1)
	mflr 0
	mfcr 12
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 15,44(1)
	stw 0,132(1)
	stw 12,40(1)
	lis 9,loc_names+4@ha
	lis 11,.LC147@ha
	la 20,loc_names+4@l(9)
	lfs 31,.LC147@l(11)
	mr 27,3
	lis 9,.LC156@ha
	addi 17,20,-4
	la 9,.LC156@l(9)
	addi 18,27,4
	lfs 30,0(9)
	mr 25,4
	li 30,0
	li 26,0
	li 23,999
	li 16,-1
	li 22,0
	addi 19,1,24
	lis 21,g_edicts@ha
	lis 15,globals@ha
.L493:
	cmpwi 0,30,0
	bc 4,2,.L496
	lwz 31,g_edicts@l(21)
	b .L497
.L544:
	mr 30,31
	b .L509
.L496:
	addi 31,30,916
.L497:
	la 11,globals@l(15)
	lwz 9,g_edicts@l(21)
	lwz 0,72(11)
	mulli 0,0,916
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L510
	mr 24,11
	addi 28,31,188
	addi 30,31,200
	addi 29,31,4
.L500:
	lwz 0,-112(30)
	cmpwi 0,0,0
	bc 12,2,.L502
	li 0,3
	lis 9,.LC157@ha
	mtctr 0
	la 9,.LC157@l(9)
	mr 8,29
	lfd 10,0(9)
	mr 10,28
	mr 11,30
	li 9,0
.L546:
	lfsx 13,9,10
	lfsx 11,9,11
	lfsx 12,9,8
	lfsx 0,9,18
	fadds 13,13,11
	fmadd 13,13,10,12
	fsub 0,0,13
	frsp 0,0
	stfsx 0,9,19
	addi 9,9,4
	bdnz .L546
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,30
	bc 4,1,.L544
.L502:
	lwz 9,72(24)
	addi 31,31,916
	addi 28,28,916
	lwz 0,g_edicts@l(21)
	addi 30,30,916
	addi 29,29,916
	mulli 9,9,916
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L500
.L510:
	li 30,0
.L509:
	cmpwi 0,30,0
	bc 12,2,.L494
	li 31,0
	b .L511
.L513:
	addi 31,31,1
.L511:
	slwi 28,31,3
	lwzx 4,17,28
	mr 29,28
	cmpwi 0,4,0
	bc 12,2,.L493
	lwz 3,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L513
	lwzx 0,17,29
	cmpwi 0,0,0
	bc 12,2,.L493
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 7,22,0
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,9,0
	bc 12,2,.L518
	mr 26,30
	lfs 0,4(27)
	addi 3,1,8
	lfs 13,4(26)
	li 22,1
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 13,13,0
	lwzx 23,20,29
	stfs 13,8(1)
	lfs 0,8(26)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(26)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fmr 31,1
	b .L493
.L518:
	cmpwi 4,3,0
	addic 0,22,-1
	subfe 9,0,22
	mfcr 0
	rlwinm 0,0,19,1
	and. 11,9,0
	bc 4,2,.L493
	bc 12,30,.L520
	lwzx 0,20,29
	cmpw 0,23,0
	bc 12,0,.L493
.L520:
	lfs 0,4(27)
	addi 3,1,8
	lfs 13,4(30)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(30)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L522
	bc 12,18,.L493
	lwzx 0,20,28
	cmpw 0,0,23
	bc 4,0,.L493
.L522:
	mr 26,30
	fmr 31,1
	mr 4,27
	mr 3,26
	mr 23,31
	bl loc_CanSee
	mr 22,3
	b .L493
.L494:
	cmpwi 0,26,0
	bc 4,2,.L523
	b .L547
.L545:
	li 16,0
	b .L525
.L523:
	li 30,0
	lis 31,.LC1@ha
	lis 29,.LC2@ha
	b .L524
.L526:
	cmpw 0,30,26
	bc 12,2,.L524
	la 5,.LC1@l(31)
	li 3,0
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L525
	la 5,.LC2@l(29)
	li 3,0
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L525
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(26)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(31)
	lfs 0,8(26)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(31)
	lfs 0,12(26)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	lfs 0,4(30)
	fmr 31,1
	addi 3,1,8
	lfs 13,4(26)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(30)
	lfs 0,8(26)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(30)
	lfs 0,12(26)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,31,1
	bc 12,0,.L545
	bc 4,1,.L525
	li 16,1
	b .L525
.L524:
	lwz 5,280(26)
	mr 3,30
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L526
.L525:
	lwz 3,280(26)
	bl FindItemByClassname
	mr. 31,3
	bc 4,2,.L533
.L547:
	lis 9,.LC148@ha
	la 11,.LC148@l(9)
	lwz 0,.LC148@l(9)
	lwz 10,4(11)
	stw 0,0(25)
	stw 10,4(25)
	b .L492
.L533:
	lwz 0,612(27)
	cmpwi 0,0,0
	bc 12,2,.L534
	lis 11,.LC149@ha
	lwz 10,.LC149@l(11)
	la 9,.LC149@l(11)
	lhz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,0(25)
	stw 0,4(25)
	stw 11,8(25)
	sth 8,12(25)
	b .L535
.L534:
	stb 0,0(25)
.L535:
	lfs 13,4(26)
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(26)
	fsubs 10,12,13
	fabs 0,0
	stfs 10,12(1)
	lfs 13,12(26)
	fsubs 11,11,13
	fmr 12,11
	stfs 11,16(1)
	fabs 12,12
	fcmpu 0,12,0
	bc 4,1,.L536
	fmr 0,10
	fabs 0,0
	fcmpu 0,12,0
	bc 4,1,.L536
	lis 9,.LC158@ha
	la 9,.LC158@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L537
	lis 4,.LC150@ha
	mr 3,25
	la 4,.LC150@l(4)
	bl strcat
	b .L539
.L537:
	lis 4,.LC151@ha
	mr 3,25
	la 4,.LC151@l(4)
	bl strcat
	b .L539
.L536:
	lis 4,.LC152@ha
	mr 3,25
	la 4,.LC152@l(4)
	bl strcat
.L539:
	cmpwi 0,16,0
	bc 4,2,.L540
	lis 4,.LC153@ha
	mr 3,25
	la 4,.LC153@l(4)
	bl strcat
	b .L541
.L540:
	cmpwi 0,16,1
	bc 4,2,.L542
	lis 4,.LC154@ha
	mr 3,25
	la 4,.LC154@l(4)
	bl strcat
	b .L541
.L542:
	lis 4,.LC155@ha
	mr 3,25
	la 4,.LC155@l(4)
	bl strcat
.L541:
	lwz 4,40(31)
	mr 3,25
	bl strcat
.L492:
	lwz 0,132(1)
	lwz 12,40(1)
	mtlr 0
	lmw 15,44(1)
	lfd 30,112(1)
	lfd 31,120(1)
	mtcrf 8,12
	la 1,128(1)
	blr
.Lfe19:
	.size	 CTFSay_Team_Location,.Lfe19-CTFSay_Team_Location
	.section	".rodata"
	.align 2
.LC159:
	.string	"cells"
	.align 2
.LC160:
	.string	"%s with %i cells "
	.align 2
.LC161:
	.string	"Power Screen"
	.align 2
.LC162:
	.string	"Power Shield"
	.align 2
.LC163:
	.string	"and "
	.align 2
.LC164:
	.string	"%i units of %s"
	.align 2
.LC165:
	.string	"no armor"
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Armor,@function
CTFSay_Team_Armor:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,4
	li 0,0
	mr 30,3
	stb 0,0(31)
	bl PowerArmorType
	mr. 28,3
	bc 12,2,.L549
	lis 3,.LC159@ha
	lwz 29,84(30)
	la 3,.LC159@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,744
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 29,29,3
	cmpwi 0,29,0
	bc 12,2,.L549
	mr 3,31
	bl strlen
	cmpwi 0,28,1
	add 3,31,3
	bc 4,2,.L551
	lis 9,.LC161@ha
	la 5,.LC161@l(9)
	b .L552
.L551:
	lis 9,.LC162@ha
	la 5,.LC162@l(9)
.L552:
	lis 4,.LC160@ha
	mr 6,29
	la 4,.LC160@l(4)
	crxor 6,6,6
	bl sprintf
.L549:
	mr 3,30
	bl ArmorIndex
	mr. 29,3
	bc 12,2,.L553
	mr 3,29
	bl GetItemByIndex
	mr. 28,3
	bc 12,2,.L553
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L555
	lis 4,.LC163@ha
	mr 3,31
	la 4,.LC163@l(4)
	bl strcat
.L555:
	mr 3,31
	bl strlen
	lwz 9,84(30)
	slwi 0,29,2
	lis 4,.LC164@ha
	lwz 6,40(28)
	la 4,.LC164@l(4)
	add 3,31,3
	addi 9,9,744
	lwzx 5,9,0
	crxor 6,6,6
	bl sprintf
.L553:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L556
	lis 9,.LC165@ha
	lwz 10,.LC165@l(9)
	la 11,.LC165@l(9)
	lbz 0,8(11)
	lwz 9,4(11)
	stb 0,8(31)
	stw 10,0(31)
	stw 9,4(31)
.L556:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 CTFSay_Team_Armor,.Lfe20-CTFSay_Team_Armor
	.section	".rodata"
	.align 2
.LC166:
	.string	"dead"
	.align 2
.LC167:
	.string	"%i health"
	.align 2
.LC168:
	.string	"none"
	.align 2
.LC169:
	.string	", "
	.align 2
.LC170:
	.string	" and "
	.align 2
.LC171:
	.string	"no one"
	.align 2
.LC172:
	.long 0x3f800000
	.align 3
.LC173:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Sight,@function
CTFSay_Team_Sight:
	stwu 1,-2144(1)
	mflr 0
	stfd 31,2136(1)
	stmw 19,2084(1)
	stw 0,2148(1)
	lis 9,maxclients@ha
	li 27,0
	lwz 11,maxclients@l(9)
	mr 26,3
	mr 23,4
	lis 9,.LC172@ha
	stb 27,1032(1)
	li 24,1
	la 9,.LC172@l(9)
	stb 27,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L565
	lis 11,.LC173@ha
	lis 20,g_edicts@ha
	la 11,.LC173@l(11)
	lis 21,.LC169@ha
	lfd 31,0(11)
	lis 22,0x4330
	li 25,916
.L567:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,26
	subfic 11,0,0
	adde 0,11,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L566
	mr 3,30
	mr 4,26
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L566
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L570
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L571
	cmpwi 0,27,0
	bc 12,2,.L572
	addi 3,1,8
	la 4,.LC169@l(21)
	bl strcat
.L572:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L571:
	addi 27,27,1
.L570:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
.L566:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	addi 25,25,916
	stw 0,2076(1)
	stw 22,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L567
.L565:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L574
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L575
	cmpwi 0,27,0
	bc 12,2,.L576
	lis 4,.LC170@ha
	addi 3,1,8
	la 4,.LC170@l(4)
	bl strcat
.L576:
	mr 4,31
	addi 3,1,8
	bl strcat
.L575:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L577
.L574:
	lis 9,.LC171@ha
	lwz 10,.LC171@l(9)
	la 11,.LC171@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L577:
	lwz 0,2148(1)
	mtlr 0
	lmw 19,2084(1)
	lfd 31,2136(1)
	la 1,2144(1)
	blr
.Lfe21:
	.size	 CTFSay_Team_Sight,.Lfe21-CTFSay_Team_Sight
	.section	".rodata"
	.align 2
.LC174:
	.string	"(%s): %s\n"
	.align 2
.LC175:
	.long 0x0
	.align 3
.LC176:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFSay_Team
	.type	 CTFSay_Team,@function
CTFSay_Team:
	stwu 1,-2112(1)
	mflr 0
	stfd 31,2104(1)
	stmw 24,2072(1)
	stw 0,2116(1)
	mr 28,3
	mr 30,4
	bl floodProt
	mr. 31,3
	bc 4,2,.L578
	lbz 0,0(30)
	stb 31,8(1)
	cmpwi 0,0,34
	bc 4,2,.L580
	mr 3,30
	bl strlen
	add 3,3,30
	stb 31,-1(3)
	addi 30,30,1
.L580:
	lbz 9,0(30)
	addi 31,1,8
	lis 24,maxclients@ha
	mr 27,31
	cmpwi 0,9,0
	bc 12,2,.L582
.L584:
	cmpwi 0,9,37
	bc 4,2,.L586
	lbzu 9,1(30)
	addi 9,9,-65
	cmplwi 0,9,54
	bc 12,1,.L604
	lis 11,.L605@ha
	slwi 10,9,2
	la 11,.L605@l(11)
	lis 9,.L605@ha
	lwzx 0,10,11
	la 9,.L605@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L605:
	.long .L591-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L593-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L589-.L605
	.long .L604-.L605
	.long .L603-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L598-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L591-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L593-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L589-.L605
	.long .L604-.L605
	.long .L603-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L604-.L605
	.long .L598-.L605
.L589:
	addi 29,1,1032
	mr 3,28
	mr 4,29
	bl CTFSay_Team_Location
	b .L615
.L591:
	addi 29,1,1032
	mr 3,28
	mr 4,29
	bl CTFSay_Team_Armor
	b .L615
.L593:
	lwz 5,480(28)
	cmpwi 0,5,0
	bc 12,1,.L594
	lis 9,.LC166@ha
	la 11,.LC166@l(9)
	lwz 0,.LC166@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
	b .L596
.L594:
	lis 4,.LC167@ha
	addi 3,1,1032
	la 4,.LC167@l(4)
	crxor 6,6,6
	bl sprintf
.L596:
	addi 29,1,1032
	b .L615
.L598:
	lwz 9,84(28)
	lwz 9,1792(9)
	cmpwi 0,9,0
	bc 12,2,.L599
	lwz 4,40(9)
	addi 3,1,1032
	bl strcpy
	b .L601
.L599:
	lis 9,.LC168@ha
	la 11,.LC168@l(9)
	lwz 0,.LC168@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
.L601:
	addi 29,1,1032
	b .L615
.L603:
	addi 29,1,1032
	mr 3,28
	mr 4,29
	bl CTFSay_Team_Sight
.L615:
	mr 3,31
	mr 4,29
	bl strcpy
	mr 3,29
	bl strlen
	add 31,31,3
	b .L583
.L604:
	lbz 0,0(30)
	stb 0,0(31)
	b .L616
.L586:
	stb 9,0(31)
.L616:
	addi 31,31,1
.L583:
	lbzu 9,1(30)
	cmpwi 0,9,0
	bc 12,2,.L582
	subf 0,27,31
	cmplwi 0,0,1022
	bc 4,1,.L584
.L582:
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	li 30,0
	lis 9,.LC175@ha
	stb 0,0(31)
	la 9,.LC175@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,13,0
	bc 4,0,.L578
	lis 9,gi@ha
	lis 25,g_edicts@ha
	la 26,gi@l(9)
	lis 27,.LC174@ha
	lis 9,.LC176@ha
	lis 29,0x4330
	la 9,.LC176@l(9)
	li 31,916
	lfd 31,0(9)
.L611:
	lwz 0,g_edicts@l(25)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L610
	lwz 9,84(3)
	lwz 6,84(28)
	lwz 11,3476(9)
	lwz 0,3476(6)
	cmpw 0,11,0
	bc 4,2,.L610
	lwz 9,8(26)
	addi 6,6,700
	li 4,3
	la 5,.LC174@l(27)
	addi 7,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L610:
	addi 30,30,1
	lwz 11,maxclients@l(24)
	xoris 0,30,0x8000
	addi 31,31,916
	stw 0,2068(1)
	stw 29,2064(1)
	lfd 0,2064(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L611
.L578:
	lwz 0,2116(1)
	mtlr 0
	lmw 24,2072(1)
	lfd 31,2104(1)
	la 1,2112(1)
	blr
.Lfe22:
	.size	 CTFSay_Team,.Lfe22-CTFSay_Team
	.section	".rodata"
	.align 2
.LC178:
	.string	"models/ctf/banner/tris.md2"
	.align 2
.LC180:
	.string	"models/ctf/banner/small.md2"
	.globl creditsmenu
	.section	".data"
	.align 2
	.type	 creditsmenu,@object
creditsmenu:
	.long .LC182
	.long 1
	.long 0
	.long 0
	.long .LC183
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC184
	.long 1
	.long 0
	.long 0
	.long .LC185
	.long 1
	.long 0
	.long 0
	.long .LC186
	.long 1
	.long 0
	.long 0
	.long .LC187
	.long 1
	.long 0
	.long 0
	.long .LC188
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC189
	.long 1
	.long 0
	.long 0
	.long .LC190
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC191
	.long 0
	.long 0
	.long CTFReturnToMain
	.section	".rodata"
	.align 2
.LC191:
	.string	"Return to Main Menu"
	.align 2
.LC190:
	.string	"David \"Zoid\" Kirsch"
	.align 2
.LC189:
	.string	"*Based on Threewave CTF by"
	.align 2
.LC188:
	.string	"Michael \"Smeagol\" Buttrey"
	.align 2
.LC187:
	.string	"Tim \"Blitherakt!\" Adamec"
	.align 2
.LC186:
	.string	"Rich \"Publius\" Tollerton"
	.align 2
.LC185:
	.string	"Charles \"Myrkul\" Kendrick"
	.align 2
.LC184:
	.string	"*The Expert Programming Team:"
	.align 2
.LC183:
	.string	"*Expert Quake2"
	.align 2
.LC182:
	.string	"*Quake II"
	.size	 creditsmenu,208
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
	.long .LC182
	.long 1
	.long 0
	.long 0
	.long .LC192
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC193
	.long 0
	.long 0
	.long CTFJoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC194
	.long 0
	.long 0
	.long CTFJoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC195
	.long 0
	.long 0
	.long CTFCredits
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC196
	.long 0
	.long 0
	.long 0
	.long .LC197
	.long 0
	.long 0
	.long 0
	.long .LC198
	.long 0
	.long 0
	.long 0
	.long .LC199
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC200
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC200:
	.string	"v1.02"
	.align 2
.LC199:
	.string	"(TAB to Return)"
	.align 2
.LC198:
	.string	"ESC to Exit Menu"
	.align 2
.LC197:
	.string	"ENTER to select"
	.align 2
.LC196:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC195:
	.string	"Credits"
	.align 2
.LC194:
	.string	"Join Blue Team"
	.align 2
.LC193:
	.string	"Join Red Team"
	.align 2
.LC192:
	.string	"*Expert CTF"
	.size	 joinmenu,256
	.lcomm	levelname.159,32,4
	.lcomm	team1players.160,32,4
	.lcomm	team2players.161,32,4
	.align 2
.LC201:
	.string	"Leave Chase Camera"
	.align 2
.LC202:
	.string	"Chase Camera"
	.align 2
.LC203:
	.string	"  (%d players)"
	.align 2
.LC204:
	.long 0x0
	.align 3
.LC205:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFUpdateJoinMenu
	.type	 CTFUpdateJoinMenu,@function
CTFUpdateJoinMenu:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,joinmenu@ha
	lis 8,.LC193@ha
	la 7,joinmenu@l(9)
	lis 11,CTFJoinTeam1@ha
	lis 9,.LC194@ha
	lis 10,CTFJoinTeam2@ha
	la 9,.LC194@l(9)
	la 8,.LC193@l(8)
	la 11,CTFJoinTeam1@l(11)
	la 10,CTFJoinTeam2@l(10)
	stw 8,64(7)
	stw 11,76(7)
	stw 9,96(7)
	stw 10,108(7)
	lwz 9,84(3)
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L630
	lis 9,.LC201@ha
	la 9,.LC201@l(9)
	b .L651
.L630:
	lis 9,.LC202@ha
	la 9,.LC202@l(9)
.L651:
	stw 9,128(7)
	lis 9,g_edicts@ha
	lis 11,levelname.159@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.159@l(11)
	stb 0,levelname.159@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L632
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L633
.L632:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L633:
	lis 9,maxclients@ha
	lis 11,levelname.159+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC204@ha
	la 4,.LC204@l(4)
	stb 0,levelname.159+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L635
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC205@ha
	li 8,0
	la 9,.LC205@l(9)
	addi 10,10,1004
	lfd 13,0(9)
.L637:
	lwz 0,0(10)
	addi 10,10,916
	cmpwi 0,0,0
	bc 12,2,.L636
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,3476(9)
	cmpwi 0,11,0
	bc 4,2,.L639
	addi 30,30,1
	b .L636
.L639:
	xori 11,11,1
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L636:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,4596
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L637
.L635:
	lis 29,.LC203@ha
	lis 3,team1players.160@ha
	la 4,.LC203@l(29)
	mr 5,30
	la 3,team1players.160@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.161@ha
	la 4,.LC203@l(29)
	la 3,team2players.161@l(3)
	mr 5,31
	crxor 6,6,6
	bl sprintf
	lis 11,joinmenu@ha
	lis 9,levelname.159@ha
	la 11,joinmenu@l(11)
	la 9,levelname.159@l(9)
	lwz 0,64(11)
	stw 9,32(11)
	cmpwi 0,0,0
	bc 12,2,.L643
	lis 9,team1players.160@ha
	la 9,team1players.160@l(9)
	stw 9,80(11)
	b .L644
.L643:
	stw 0,80(11)
.L644:
	lis 9,joinmenu@ha
	la 11,joinmenu@l(9)
	lwz 0,96(11)
	cmpwi 0,0,0
	bc 12,2,.L645
	lis 9,team2players.161@ha
	la 9,team2players.161@l(9)
	stw 9,112(11)
	b .L646
.L645:
	stw 0,112(11)
.L646:
	cmpw 0,30,31
	bc 12,1,.L648
	cmpw 0,31,30
	bc 12,1,.L648
	bl rand
	xori 3,3,1
	rlwinm 3,3,0,31,31
	b .L650
.L648:
	li 3,0
.L650:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 CTFUpdateJoinMenu,.Lfe23-CTFUpdateJoinMenu
	.section	".rodata"
	.align 2
.LC206:
	.string	"Capturelimit hit.\n"
	.align 2
.LC207:
	.string	"Couldn't find destination\n"
	.align 2
.LC208:
	.long 0x47800000
	.align 2
.LC209:
	.long 0x43b40000
	.align 2
.LC210:
	.long 0x43480000
	.section	".text"
	.align 2
	.type	 old_teleporter_touch,@function
old_teleporter_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,4
	mr 29,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L661
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L663
	lis 9,gi+4@ha
	lis 3,.LC207@ha
	lwz 0,gi+4@l(9)
	la 3,.LC207@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L661
.L663:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	addi 28,31,376
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC208@ha
	lis 11,.LC209@ha
	la 9,.LC208@l(9)
	la 11,.LC209@l(11)
	lwz 8,84(31)
	li 0,0
	lfs 10,0(9)
	li 10,6
	stfs 0,4(31)
	li 9,20
	addi 5,30,16
	lfs 13,8(30)
	li 6,0
	li 7,0
	lfs 11,0(11)
	li 11,3
	stfs 13,8(31)
	mtctr 11
	lfs 0,12(30)
	stfs 0,12(31)
	lfs 13,4(30)
	stfs 13,28(31)
	lfs 0,8(30)
	stfs 0,32(31)
	lfs 13,12(30)
	stw 0,376(31)
	stw 0,384(31)
	stfs 13,36(31)
	stw 0,380(31)
	stb 9,17(8)
	lwz 11,84(31)
	lbz 0,16(11)
	ori 0,0,32
	stb 0,16(11)
	lwz 9,540(29)
	stw 10,80(9)
	stw 10,80(31)
.L670:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,3456
	lfsx 13,9,7
	addi 10,10,20
	addi 7,7,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sthx 11,10,0
	bdnz .L670
	li 0,0
	lwz 11,84(31)
	addi 4,1,8
	stw 0,16(31)
	li 5,0
	li 6,0
	lfs 13,20(30)
	stw 0,24(31)
	stfs 13,20(31)
	lfs 0,16(30)
	stfs 0,28(11)
	lfs 0,20(30)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(30)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(30)
	lwz 9,84(31)
	stfs 0,3876(9)
	lfs 0,20(30)
	lwz 11,84(31)
	stfs 0,3880(11)
	lfs 13,24(30)
	lwz 9,84(31)
	stfs 13,3884(9)
	lwz 3,84(31)
	addi 3,3,3876
	bl AngleVectors
	lis 9,.LC210@ha
	addi 3,1,8
	la 9,.LC210@l(9)
	mr 4,28
	lfs 1,0(9)
	bl VectorScale
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L661:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 old_teleporter_touch,.Lfe24-old_teleporter_touch
	.section	".rodata"
	.align 2
.LC211:
	.string	"teleporter without a target.\n"
	.align 2
.LC212:
	.string	"world/hum1.wav"
	.align 2
.LC213:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl SP_trigger_teleport
	.type	 SP_trigger_teleport,@function
SP_trigger_teleport:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L672
	lis 9,gi+4@ha
	lis 3,.LC211@ha
	lwz 0,gi+4@l(9)
	la 3,.LC211@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L671
.L672:
	lwz 0,184(31)
	lis 9,old_teleporter_touch@ha
	li 11,1
	la 9,old_teleporter_touch@l(9)
	lis 29,gi@ha
	stw 11,248(31)
	ori 0,0,1
	la 29,gi@l(29)
	stw 9,444(31)
	stw 0,184(31)
	mr 3,31
	lwz 9,44(29)
	lwz 4,268(31)
	mtlr 9
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	bl G_Spawn
	li 0,3
	lis 9,.LC213@ha
	mtctr 0
	la 9,.LC213@l(9)
	mr 30,3
	lfs 12,0(9)
	addi 8,31,200
	addi 10,31,188
	stw 30,540(31)
	addi 11,30,4
	li 9,0
.L678:
	lfsx 13,9,10
	lfsx 0,9,8
	addi 9,9,4
	fsubs 0,0,13
	fmadds 0,0,12,13
	stfs 0,0(11)
	addi 11,11,4
	bdnz .L678
	lis 29,gi@ha
	lis 3,.LC212@ha
	la 29,gi@l(29)
	la 3,.LC212@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(30)
	lwz 0,72(29)
	mr 3,30
	mtlr 0
	blrl
.L671:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 SP_trigger_teleport,.Lfe25-SP_trigger_teleport
	.comm	gametype,4,4
	.align 2
	.globl SP_info_player_team1
	.type	 SP_info_player_team1,@function
SP_info_player_team1:
	blr
.Lfe26:
	.size	 SP_info_player_team1,.Lfe26-SP_info_player_team1
	.align 2
	.globl SP_info_player_team2
	.type	 SP_info_player_team2,@function
SP_info_player_team2:
	blr
.Lfe27:
	.size	 SP_info_player_team2,.Lfe27-SP_info_player_team2
	.align 2
	.globl CTFTouchFlag
	.type	 CTFTouchFlag,@function
CTFTouchFlag:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,908(3)
	cmpwi 0,0,0
	bc 4,2,.L284
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 5,flag1_item@l(9)
	lwz 6,flag2_item@l(11)
	b .L285
.L284:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 5,flag2_item@l(9)
	lwz 6,flag1_item@l(11)
.L285:
	lwz 11,84(4)
	lwz 9,908(3)
	lwz 0,3476(11)
	cmpw 0,9,0
	bc 4,2,.L286
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L287
	bl CTFReturnFlag
.L681:
	li 3,0
	b .L680
.L287:
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,6
	addi 11,11,744
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L681
	bl CTFCapture
	b .L681
.L286:
	bl CTFPickupFlag
	li 3,1
.L680:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 CTFTouchFlag,.Lfe28-CTFTouchFlag
	.align 2
	.globl CTFDrop_Flag
	.type	 CTFDrop_Flag,@function
CTFDrop_Flag:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC78@ha
	lwz 0,gi+8@l(9)
	la 5,.LC78@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 CTFDrop_Flag,.Lfe29-CTFDrop_Flag
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,ctfgame@ha
	mr 30,3
	la 9,ctfgame@l(9)
	slwi 0,30,2
	addi 11,9,60
	lwzx 3,11,0
	addi 9,9,68
	lwzx 31,9,0
	cmpwi 0,3,0
	bc 12,2,.L234
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L234
	bl G_FreeEdict
.L234:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,ctfgame@ha
	stw 29,80(31)
	slwi 10,30,2
	la 9,ctfgame@l(9)
	addi 11,9,68
	lwzx 0,11,10
	addi 9,9,60
	stwx 0,9,10
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 CTFResetFlag,.Lfe30-CTFResetFlag
	.align 2
	.globl CTFCheckHurtCarrier
	.type	 CTFCheckHurtCarrier,@function
CTFCheckHurtCarrier:
	lwz 9,84(3)
	cmpwi 0,9,0
	bclr 12,2
	lwz 4,84(4)
	cmpwi 0,4,0
	bclr 12,2
	lwz 10,3476(9)
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	slwi 0,10,2
	addi 9,9,76
	lwzx 11,9,0
	cmpw 0,3,11
	bclr 4,2
	lwz 0,3476(4)
	cmpw 0,10,0
	bclr 12,2
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,3440(4)
	blr
.Lfe31:
	.size	 CTFCheckHurtCarrier,.Lfe31-CTFCheckHurtCarrier
	.align 2
	.globl CTFOpenJoinMenu
	.type	 CTFOpenJoinMenu,@function
CTFOpenJoinMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl CTFUpdateJoinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L653
	li 5,8
	b .L654
.L653:
	srawi 9,5,31
	xor 0,9,5
	subf 0,0,9
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L654:
	lis 4,joinmenu@ha
	mr 3,31
	la 4,joinmenu@l(4)
	li 6,16
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 CTFOpenJoinMenu,.Lfe32-CTFOpenJoinMenu
	.section	".rodata"
	.align 2
.LC214:
	.long 0x0
	.align 3
.LC215:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFCheckRules
	.type	 CTFCheckRules,@function
CTFCheckRules:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC214@ha
	lis 9,capturelimit@ha
	la 11,.LC214@l(11)
	lfs 0,0(11)
	lwz 11,capturelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L659
	lis 9,ctfgame@ha
	lwz 0,ctfgame@l(9)
	la 8,ctfgame@l(9)
	lis 10,0x4330
	lis 9,.LC215@ha
	xoris 0,0,0x8000
	la 9,.LC215@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L660
	lwz 0,4(8)
	mr 9,11
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L659
.L660:
	lis 9,gi@ha
	lis 4,.LC206@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC206@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L682
.L659:
	li 3,0
.L682:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 CTFCheckRules,.Lfe33-CTFCheckRules
	.section	".rodata"
	.align 3
.LC216:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_ctf_banner
	.type	 SP_misc_ctf_banner,@function
SP_misc_ctf_banner:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lis 9,gi@ha
	stw 0,248(31)
	lis 3,.LC178@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC178@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L619
	li 0,1
	stw 0,60(31)
.L619:
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 9,misc_ctf_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_ctf_banner_think@l(9)
	lis 11,.LC216@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC216@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 SP_misc_ctf_banner,.Lfe34-SP_misc_ctf_banner
	.section	".rodata"
	.align 3
.LC217:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_ctf_small_banner
	.type	 SP_misc_ctf_small_banner,@function
SP_misc_ctf_small_banner:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lis 9,gi@ha
	stw 0,248(31)
	lis 3,.LC180@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC180@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L621
	li 0,1
	stw 0,60(31)
.L621:
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 9,misc_ctf_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_ctf_banner_think@l(9)
	lis 11,.LC217@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC217@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 SP_misc_ctf_small_banner,.Lfe35-SP_misc_ctf_small_banner
	.section	".rodata"
	.align 2
.LC218:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	lis 9,.LC218@ha
	lfs 0,12(3)
	la 9,.LC218@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe36:
	.size	 SP_info_teleport_destination,.Lfe36-SP_info_teleport_destination
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.comm	ctfgame,92,4
	.section	".sbss","aw",@nobits
	.align 2
flag1_item:
	.space	4
	.size	 flag1_item,4
	.align 2
flag2_item:
	.space	4
	.size	 flag2_item,4
	.section	".text"
	.align 2
	.globl InitSpawnLists
	.type	 InitSpawnLists,@function
InitSpawnLists:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	li 3,0
	bl findLegalSpawns
	lis 29,ctfgame@ha
	la 29,ctfgame@l(29)
	stw 3,84(29)
	li 3,1
	bl findLegalSpawns
	stw 3,88(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 InitSpawnLists,.Lfe37-InitSpawnLists
	.align 2
	.globl CTFOtherTeam
	.type	 CTFOtherTeam,@function
CTFOtherTeam:
	mr. 3,3
	bc 12,2,.L28
	cmpwi 0,3,1
	bc 12,2,.L29
	b .L27
.L28:
	li 3,1
	blr
.L29:
	li 3,0
	blr
.L27:
	li 3,-1
	blr
.Lfe38:
	.size	 CTFOtherTeam,.Lfe38-CTFOtherTeam
	.align 2
	.globl CTFTeamForFlagClass
	.type	 CTFTeamForFlagClass,@function
CTFTeamForFlagClass:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 4,3
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl Q_stricmp
	addic 9,3,-1
	subfe 0,9,3
	mr 3,0
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 CTFTeamForFlagClass,.Lfe39-CTFTeamForFlagClass
	.align 2
	.globl isCarrier
	.type	 isCarrier,@function
isCarrier:
	lwz 11,84(3)
	lis 9,ctfgame@ha
	la 9,ctfgame@l(9)
	lwz 0,3476(11)
	addi 9,9,76
	slwi 0,0,2
	lwzx 11,9,0
	xor 3,3,11
	subfic 0,3,0
	adde 3,0,3
	blr
.Lfe40:
	.size	 isCarrier,.Lfe40-isCarrier
	.align 2
	.globl RangeToEnemyFlag
	.type	 RangeToEnemyFlag,@function
RangeToEnemyFlag:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	cmpwi 0,4,0
	mr 11,3
	bc 4,2,.L37
	lis 9,ctfgame+72@ha
	lwz 9,ctfgame+72@l(9)
	b .L38
.L37:
	lis 9,ctfgame+68@ha
	lwz 9,ctfgame+68@l(9)
.L38:
	lfs 13,4(9)
	addi 3,1,8
	lfs 0,4(11)
	lfs 12,8(11)
	lfs 11,12(11)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(9)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe41:
	.size	 RangeToEnemyFlag,.Lfe41-RangeToEnemyFlag
	.section	".rodata"
	.align 2
.LC219:
	.long 0x0
	.section	".text"
	.align 2
	.globl SelectFarthestCTFSpawnPoint
	.type	 SelectFarthestCTFSpawnPoint,@function
SelectFarthestCTFSpawnPoint:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lwz 11,84(3)
	lis 9,ctfgame@ha
	lis 10,.LC219@ha
	la 9,ctfgame@l(9)
	la 10,.LC219@l(10)
	lwz 0,3476(11)
	addi 9,9,84
	li 27,0
	lfs 31,0(10)
	li 30,0
	slwi 0,0,2
	lwzx 29,9,0
	mr 3,29
	bl listSize
	mr. 28,3
	bc 4,1,.L63
.L65:
	mr 4,30
	mr 3,29
	bl listElementAt
	mr 31,3
	bl PlayersRangeFromSpot
	fcmpu 0,1,31
	bc 4,1,.L64
	fmr 31,1
	mr 27,31
.L64:
	addi 30,30,1
	cmpw 0,30,28
	bc 12,0,.L65
.L63:
	cmpwi 0,27,0
	mr 3,27
	bc 4,2,.L685
	lis 5,.LC6@ha
	li 3,0
	la 5,.LC6@l(5)
	li 4,280
	bl G_Find
.L685:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 SelectFarthestCTFSpawnPoint,.Lfe42-SelectFarthestCTFSpawnPoint
	.section	".rodata"
	.align 2
.LC220:
	.long 0x47c34f80
	.section	".text"
	.align 2
	.globl SelectRandomCTFSpawnPoint
	.type	 SelectRandomCTFSpawnPoint,@function
SelectRandomCTFSpawnPoint:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 26,8(1)
	stw 0,52(1)
	lwz 10,84(3)
	lis 9,ctfgame@ha
	lis 11,.LC220@ha
	la 9,ctfgame@l(9)
	lfs 31,.LC220@l(11)
	li 31,0
	lwz 0,3476(10)
	addi 9,9,84
	li 26,0
	li 27,0
	slwi 0,0,2
	fmr 30,31
	lwzx 28,9,0
	mr 3,28
	bl listSize
	mr 30,3
	cmpwi 0,30,2
	bc 4,1,.L82
	cmpw 0,31,30
	li 29,0
	bc 4,0,.L82
.L74:
	mr 4,29
	mr 3,28
	bl listElementAt
	mr 31,3
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L75
	fmr 30,1
	mr 27,31
	b .L73
.L75:
	fcmpu 0,1,31
	bc 4,0,.L73
	fmr 31,1
	mr 26,31
.L73:
	addi 29,29,1
	cmpw 0,29,30
	bc 12,0,.L74
.L82:
	bl rand
	mr 4,3
	divw 0,4,30
	mr 3,28
	mullw 0,0,30
	subf 4,0,4
	bl listElementAt
	mr 31,3
	xor 9,31,27
	subfic 0,9,0
	adde 9,0,9
	xor 0,31,26
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L82
	lwz 0,52(1)
	mtlr 0
	lmw 26,8(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe43:
	.size	 SelectRandomCTFSpawnPoint,.Lfe43-SelectRandomCTFSpawnPoint
	.align 2
	.globl calcTeamDistribution
	.type	 calcTeamDistribution,@function
calcTeamDistribution:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl countPlayers
	bl convertToPics
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 calcTeamDistribution,.Lfe44-calcTeamDistribution
	.section	".rodata"
	.align 2
.LC221:
	.long 0x41e00000
	.section	".text"
	.align 2
	.type	 CTFDropFlagTouch,@function
CTFDropFlagTouch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 4,2,.L291
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC221@ha
	lfs 13,level+4@l(9)
	la 11,.LC221@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L290
.L291:
	bl Touch_Item
.L290:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 CTFDropFlagTouch,.Lfe45-CTFDropFlagTouch
	.section	".rodata"
	.align 3
.LC222:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 CTFFlagThink,@function
CTFFlagThink:
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 12,2,.L340
	lwz 9,56(3)
	addi 9,9,-172
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	addi 9,9,173
	stw 9,56(3)
.L340:
	lis 9,level+4@ha
	lis 11,.LC222@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC222@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe46:
	.size	 CTFFlagThink,.Lfe46-CTFFlagThink
	.align 2
	.globl flagStatusIcon
	.type	 flagStatusIcon,@function
flagStatusIcon:
	lis 9,ctfgame@ha
	slwi 0,3,2
	la 10,ctfgame@l(9)
	addi 9,10,60
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L370
	cmpwi 0,3,0
	bc 4,2,.L371
	lis 9,.LC99@ha
	la 3,.LC99@l(9)
	blr
.L371:
	lis 9,.LC100@ha
	la 3,.LC100@l(9)
	blr
.L370:
	addi 9,10,68
	lwzx 0,9,0
	cmpw 0,0,11
	bc 4,2,.L374
	cmpwi 0,3,0
	bc 4,2,.L375
	lis 9,.LC101@ha
	la 3,.LC101@l(9)
	blr
.L375:
	lis 9,.LC102@ha
	la 3,.LC102@l(9)
	blr
.L374:
	cmpwi 0,3,0
	bc 4,2,.L378
	lis 9,.LC103@ha
	la 3,.LC103@l(9)
	blr
.L378:
	lis 9,.LC104@ha
	la 3,.LC104@l(9)
	blr
.Lfe47:
	.size	 flagStatusIcon,.Lfe47-flagStatusIcon
	.align 2
	.globl carrierName
	.type	 carrierName,@function
carrierName:
	lis 9,ctfgame@ha
	slwi 3,3,2
	la 9,ctfgame@l(9)
	addi 9,9,76
	lwzx 11,9,3
	cmpwi 0,11,0
	bc 12,2,.L381
	lis 9,g_edicts@ha
	lis 0,0x478b
	lwz 3,g_edicts@l(9)
	ori 0,0,48365
	addis 3,3,0xffea
	addi 3,3,5504
	subf 3,3,11
	mullw 3,3,0
	srawi 3,3,2
	addi 3,3,-1
	blr
.L381:
	li 3,0
	blr
.Lfe48:
	.size	 carrierName,.Lfe48-carrierName
	.section	".rodata"
	.align 3
.LC223:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 misc_ctf_banner_think,@function
misc_ctf_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC223@ha
	lfd 13,.LC223@l(11)
	addi 9,9,1
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(3)
	lfs 0,level+4@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe49:
	.size	 misc_ctf_banner_think,.Lfe49-misc_ctf_banner_think
	.align 2
	.globl CTFJoinTeam
	.type	 CTFJoinTeam,@function
CTFJoinTeam:
	blr
.Lfe50:
	.size	 CTFJoinTeam,.Lfe50-CTFJoinTeam
	.align 2
	.globl CTFJoinTeam1
	.type	 CTFJoinTeam1,@function
CTFJoinTeam1:
	blr
.Lfe51:
	.size	 CTFJoinTeam1,.Lfe51-CTFJoinTeam1
	.align 2
	.globl CTFJoinTeam2
	.type	 CTFJoinTeam2,@function
CTFJoinTeam2:
	blr
.Lfe52:
	.size	 CTFJoinTeam2,.Lfe52-CTFJoinTeam2
	.align 2
	.globl CTFReturnToMain
	.type	 CTFReturnToMain,@function
CTFReturnToMain:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl CTFOpenJoinMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 CTFReturnToMain,.Lfe53-CTFReturnToMain
	.align 2
	.globl CTFCredits
	.type	 CTFCredits,@function
CTFCredits:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,creditsmenu@ha
	mr 3,29
	la 4,creditsmenu@l(4)
	li 5,-1
	li 6,13
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe54:
	.size	 CTFCredits,.Lfe54-CTFCredits
	.align 2
	.globl CTFShowScores
	.type	 CTFShowScores,@function
CTFShowScores:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lwz 11,84(29)
	li 0,1
	li 10,0
	mr 3,29
	stw 0,3728(11)
	lwz 9,84(29)
	stw 10,3740(9)
	bl DeathmatchScoreboard
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe55:
	.size	 CTFShowScores,.Lfe55-CTFShowScores
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
