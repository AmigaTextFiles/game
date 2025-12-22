	.file	"g_ctf.c"
gcc2_compiled.:
	.globl techspawn
	.section	".sdata","aw"
	.align 2
	.type	 techspawn,@object
	.size	 techspawn,4
techspawn:
	.long 0
	.globl ctf_statusbar
	.section	".rodata"
	.align 2
.LC0:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 en"
	.ascii	"dif if 6 \txv\t296 \tpic 6 endif if 18    xv      75    yb -"
	.ascii	"48    num 3 18    xv      125    yb -48    pic 0 endif yb\t-"
	.ascii	"50 if 7 \txv\t0 \tpic 7 \txv\t26 \tyb\t-42 \tstat_string 8 \t"
	.ascii	"yb\t-50 endif if 9 xv 246 num 2 10 xv 296 pic 9 endif if 11 "
	.ascii	"xv 148 pic 11 endif xr\t-50 yt 2 num 3 14 yb -129 if 26 xr -"
	.ascii	"26 pic 26 endif yb -"
	.string	"102 if 17 xr -26 pic 17 endif xr -62 num 2 18 if 22 yb -104 xr -28 pic 22 endif yb -75 if 19 xr -26 pic 19 endif xr -62 num 2 20 if 23 yb -77 xr -28 pic 23 endif if 21 yt 26 xr -24 pic 21 endif if 27 xv 0 yb -58 string \"Viewing\" xv 64 stat_string 27 endif "
	.section	".sdata","aw"
	.align 2
	.type	 ctf_statusbar,@object
	.size	 ctf_statusbar,4
ctf_statusbar:
	.long .LC0
	.section	".data"
	.align 2
	.type	 tnames,@object
tnames:
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long 0
	.section	".rodata"
	.align 2
.LC4:
	.string	"item_tech4"
	.align 2
.LC3:
	.string	"item_tech3"
	.align 2
.LC2:
	.string	"item_tech2"
	.align 2
.LC1:
	.string	"item_tech1"
	.size	 tnames,20
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC6:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.type	 loc_CanSee,@function
loc_CanSee:
	stwu 1,-224(1)
	mflr 0
	stfd 31,216(1)
	stmw 26,192(1)
	stw 0,228(1)
	lwz 0,260(3)
	mr 30,4
	cmpwi 0,0,2
	bc 4,2,.L24
	b .L34
.L33:
	li 3,1
	b .L32
.L24:
	mr 10,3
	lfs 12,188(3)
	addi 11,3,188
	lfsu 9,4(10)
	addi 8,3,200
	lis 9,.LC5@ha
	lfs 7,200(3)
	la 9,.LC5@l(9)
	lfd 6,0(9)
	lis 6,0x4330
	addi 28,1,168
	fadds 8,9,12
	lis 9,gi@ha
	lis 27,vec3_origin@ha
	fadds 9,9,7
	la 26,gi@l(9)
	addi 31,1,72
	lis 9,.LC6@ha
	addi 29,1,156
	stfs 8,72(1)
	fsubs 12,8,12
	la 9,.LC6@l(9)
	lfs 0,4(11)
	fsubs 5,9,7
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
	stw 0,188(1)
	lfs 13,4(8)
	stw 6,184(1)
	lfd 0,184(1)
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
.L29:
	lwz 11,48(26)
	la 5,vec3_origin@l(27)
	addi 3,1,8
	mr 4,28
	mr 6,5
	mr 7,31
	mr 8,30
	mtlr 11
	li 9,3
	blrl
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 12,2,.L33
	addi 31,31,12
	cmpw 0,31,29
	bc 4,1,.L29
.L34:
	li 3,0
.L32:
	lwz 0,228(1)
	mtlr 0
	lmw 26,192(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe1:
	.size	 loc_CanSee,.Lfe1-loc_CanSee
	.section	".rodata"
	.align 2
.LC7:
	.string	"ctf"
	.align 2
.LC8:
	.string	"0"
	.align 2
.LC9:
	.string	"ctf_forcejoin"
	.align 2
.LC10:
	.string	""
	.align 2
.LC11:
	.string	"item_flag_team1"
	.align 2
.LC12:
	.string	"item_flag_team2"
	.align 2
.LC13:
	.string	"RED"
	.align 2
.LC14:
	.string	"BLUE"
	.align 2
.LC15:
	.string	"UKNOWN"
	.align 2
.LC16:
	.string	"Red"
	.align 2
.LC17:
	.string	"Blue"
	.align 2
.LC18:
	.string	"Green"
	.align 2
.LC19:
	.string	"White"
	.align 2
.LC20:
	.string	"Unknown"
	.align 2
.LC21:
	.string	"%s"
	.align 2
.LC22:
	.string	"male/"
	.align 2
.LC23:
	.string	"%s\\%s%s"
	.align 2
.LC24:
	.string	"ctf_r"
	.align 2
.LC25:
	.string	"ctf_b"
	.align 2
.LC26:
	.string	"%s\\%s"
	.section	".text"
	.align 2
	.globl CTFAssignSkin
	.type	 CTFAssignSkin,@function
CTFAssignSkin:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	lis 11,g_edicts@ha
	mr 29,3
	lwz 9,g_edicts@l(11)
	lis 0,0xc10c
	mr 30,4
	ori 0,0,38677
	lis 5,.LC21@ha
	subf 9,9,29
	addi 3,1,8
	mullw 9,9,0
	la 5,.LC21@l(5)
	li 4,64
	mr 6,30
	srawi 9,9,4
	addi 31,9,-1
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	li 4,47
	bl strrchr
	mr. 3,3
	bc 12,2,.L66
	li 0,0
	stb 0,1(3)
	b .L67
.L66:
	lis 9,.LC22@ha
	la 11,.LC22@l(9)
	lwz 0,.LC22@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L67:
	lwz 9,84(29)
	lwz 3,1840(9)
	mr 4,9
	cmpwi 0,3,1
	bc 12,2,.L69
	cmpwi 0,3,2
	bc 12,2,.L70
	b .L71
.L69:
	lis 29,gi@ha
	lis 3,.LC23@ha
	lis 6,.LC24@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC23@l(3)
	la 6,.LC24@l(6)
	b .L73
.L70:
	lis 29,gi@ha
	lis 3,.LC23@ha
	lis 6,.LC25@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC23@l(3)
	la 6,.LC25@l(6)
.L73:
	addi 5,1,8
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,31,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
	b .L68
.L71:
	lis 29,gi@ha
	lis 3,.LC26@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC26@l(3)
	mr 5,30
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,31,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L68:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 CTFAssignSkin,.Lfe2-CTFAssignSkin
	.section	".rodata"
	.align 2
.LC27:
	.string	"tdm_red"
	.align 2
.LC28:
	.string	"tdm_blue"
	.align 2
.LC29:
	.string	"tdm_green"
	.align 2
.LC30:
	.string	"tdm_white"
	.section	".text"
	.align 2
	.globl TDMAssignSkin
	.type	 TDMAssignSkin,@function
TDMAssignSkin:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	lis 11,g_edicts@ha
	mr 29,3
	lwz 9,g_edicts@l(11)
	lis 0,0xc10c
	mr 30,4
	ori 0,0,38677
	lis 5,.LC21@ha
	subf 9,9,29
	addi 3,1,8
	mullw 9,9,0
	la 5,.LC21@l(5)
	li 4,64
	mr 6,30
	srawi 9,9,4
	addi 31,9,-1
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	li 4,47
	bl strrchr
	mr. 3,3
	bc 12,2,.L75
	li 0,0
	stb 0,1(3)
	b .L76
.L75:
	lis 9,.LC22@ha
	la 11,.LC22@l(9)
	lwz 0,.LC22@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L76:
	lwz 9,84(29)
	lwz 3,1840(9)
	mr 4,9
	cmpwi 0,3,2
	bc 12,2,.L79
	bc 12,1,.L84
	cmpwi 0,3,1
	bc 12,2,.L78
	b .L82
.L84:
	cmpwi 0,3,3
	bc 12,2,.L80
	cmpwi 0,3,4
	bc 12,2,.L81
	b .L82
.L78:
	lis 29,gi@ha
	lis 3,.LC23@ha
	lis 6,.LC27@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC23@l(3)
	la 6,.LC27@l(6)
	b .L85
.L79:
	lis 29,gi@ha
	lis 3,.LC23@ha
	lis 6,.LC28@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC23@l(3)
	la 6,.LC28@l(6)
	b .L85
.L80:
	lis 29,gi@ha
	lis 3,.LC23@ha
	lis 6,.LC29@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC23@l(3)
	la 6,.LC29@l(6)
	b .L85
.L81:
	lis 29,gi@ha
	lis 3,.LC23@ha
	lis 6,.LC30@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC23@l(3)
	la 6,.LC30@l(6)
.L85:
	addi 5,1,8
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,31,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
	b .L77
.L82:
	lis 29,gi@ha
	lis 3,.LC26@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC26@l(3)
	mr 5,30
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,31,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L77:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe3:
	.size	 TDMAssignSkin,.Lfe3-TDMAssignSkin
	.section	".rodata"
	.align 2
.LC31:
	.long 0x3f800000
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFAssignTeam
	.type	 CTFAssignTeam,@function
CTFAssignTeam:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,dmflags@ha
	mr 31,3
	lwz 11,dmflags@l(9)
	li 7,0
	li 8,0
	stw 7,1844(31)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andis. 0,9,2
	bc 4,2,.L87
	stw 8,1840(31)
	b .L86
.L87:
	lis 11,.LC31@ha
	lis 9,maxclients@ha
	la 11,.LC31@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L100
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	addi 11,11,976
	lfd 13,0(9)
.L91:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L90
	lwz 9,84(11)
	cmpw 0,9,31
	bc 12,2,.L90
	lwz 0,1840(9)
	cmpwi 0,0,1
	bc 12,2,.L95
	cmpwi 0,0,2
	bc 12,2,.L96
	b .L90
.L95:
	addi 7,7,1
	b .L90
.L96:
	addi 8,8,1
.L90:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,976
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L91
.L100:
	cmpw 0,8,7
	bc 12,0,.L104
	bl rand
	andi. 0,3,1
	li 0,1
	bc 4,2,.L106
.L104:
	li 0,2
.L106:
	stw 0,1840(31)
.L86:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 CTFAssignTeam,.Lfe4-CTFAssignTeam
	.section	".rodata"
	.align 2
.LC33:
	.string	"info_player_team1"
	.align 2
.LC34:
	.string	"info_player_team2"
	.align 2
.LC35:
	.long 0x47c34f80
	.section	".text"
	.align 2
	.globl SelectCTFSpawnPoint
	.type	 SelectCTFSpawnPoint,@function
SelectCTFSpawnPoint:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 27,28(1)
	stw 0,68(1)
	lwz 9,84(3)
	li 31,0
	lwz 0,1844(9)
	cmpwi 0,0,0
	bc 12,2,.L108
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L132
	bl SelectFarthestDeathmatchSpawnPoint
	b .L131
.L108:
	li 0,1
	stw 0,1844(9)
	lwz 9,84(3)
	lwz 3,1840(9)
	cmpwi 0,3,1
	bc 12,2,.L112
	cmpwi 0,3,2
	bc 12,2,.L113
	b .L132
.L112:
	lis 9,.LC33@ha
	la 27,.LC33@l(9)
	b .L111
.L113:
	lis 9,.LC34@ha
	la 27,.LC34@l(9)
.L111:
	lis 9,.LC35@ha
	li 30,0
	lfs 31,.LC35@l(9)
	li 28,0
	li 29,0
	fmr 30,31
	b .L116
.L118:
	mr 3,30
	addi 31,31,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L119
	fmr 30,1
	mr 29,30
	b .L116
.L119:
	fcmpu 0,1,31
	bc 4,0,.L116
	fmr 31,1
	mr 28,30
.L116:
	mr 3,30
	li 4,280
	mr 5,27
	bl G_Find
	mr. 30,3
	bc 4,2,.L118
	cmpwi 0,31,0
	bc 4,2,.L123
.L132:
	bl SelectRandomDeathmatchSpawnPoint
	b .L131
.L123:
	cmpwi 0,31,2
	bc 12,1,.L124
	li 28,0
	li 29,0
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
	mr 5,27
	bl G_Find
	mr 30,3
	addi 0,31,1
	xor 9,30,29
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,28
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
	lmw 27,28(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 SelectCTFSpawnPoint,.Lfe5-SelectCTFSpawnPoint
	.section	".rodata"
	.align 2
.LC36:
	.string	"BONUS: %d points for fragging enemy flag carrier.\n"
	.align 2
.LC37:
	.string	"%s defends %s's flag carrier against an agressive enemy\n"
	.align 2
.LC38:
	.string	"%s defends the %s base.\n"
	.align 2
.LC39:
	.string	"%s defends the %s flag.\n"
	.align 2
.LC40:
	.string	"%s defends the %s's flag carrier.\n"
	.align 2
.LC41:
	.long 0x3f800000
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC43:
	.long 0x0
	.align 2
.LC44:
	.long 0x41000000
	.align 2
.LC45:
	.long 0x43c80000
	.section	".text"
	.align 2
	.globl CTFFragBonuses
	.type	 CTFFragBonuses,@function
CTFFragBonuses:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 26,48(1)
	stw 0,84(1)
	mr 27,3
	mr 29,5
	lwz 11,84(27)
	cmpwi 0,11,0
	bc 12,2,.L133
	lwz 0,84(29)
	xor 9,27,29
	subfic 10,9,0
	adde 9,10,9
	mr 8,0
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 4,2,.L133
	lwz 0,1840(11)
	cmpwi 0,0,1
	bc 12,2,.L136
	cmpwi 0,0,2
	bc 12,2,.L137
	b .L140
.L136:
	li 30,2
	b .L139
.L137:
	li 30,1
	b .L139
.L140:
	li 30,-1
.L139:
	cmpwi 0,30,0
	bc 12,0,.L133
	lwz 9,84(27)
	lwz 0,1840(9)
	mr 7,9
	cmpwi 0,0,1
	bc 4,2,.L142
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 26,flag1_item@l(9)
	lwz 0,flag2_item@l(11)
	b .L143
.L142:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 26,flag2_item@l(9)
	lwz 0,flag1_item@l(11)
.L143:
	lis 9,itemlist@ha
	lis 10,0x286b
	la 6,itemlist@l(9)
	ori 10,10,51739
	subf 0,6,0
	addi 11,7,744
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L144
	lis 9,level+4@ha
	lis 10,gi+8@ha
	lfs 0,level+4@l(9)
	lis 5,.LC36@ha
	mr 3,29
	la 5,.LC36@l(5)
	li 4,1
	li 6,2
	stfs 0,1860(8)
	lwz 11,84(29)
	lwz 9,1836(11)
	addi 9,9,2
	stw 9,1836(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,maxclients@ha
	lis 10,.LC41@ha
	lwz 11,maxclients@l(9)
	la 10,.LC41@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	li 10,1
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L133
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 6,0
	lis 7,0x4330
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	addi 11,11,976
	lfd 12,0(9)
.L148:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L147
	lwz 9,84(11)
	lwz 0,1840(9)
	cmpw 0,0,30
	bc 4,2,.L147
	stw 6,1848(9)
.L147:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,976
	stw 0,44(1)
	stw 7,40(1)
	lfd 0,40(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L148
	b .L133
.L144:
	lis 11,.LC43@ha
	lfs 12,1848(7)
	la 11,.LC43@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 12,2,.L151
	lis 9,level+4@ha
	lis 11,.LC44@ha
	lfs 0,level+4@l(9)
	la 11,.LC44@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L151
	subf 0,6,26
	addi 11,8,744
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L151
	lwz 9,1836(8)
	lis 11,gi@ha
	la 10,gi@l(11)
	addi 9,9,2
	stw 9,1836(8)
	lwz 11,84(29)
	lwz 0,1840(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L152
	cmpwi 0,0,2
	bc 12,2,.L153
	b .L156
.L152:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L155
.L153:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L155
.L156:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L155:
	lwz 0,0(10)
	lis 4,.LC37@ha
	li 3,1
	la 4,.LC37@l(4)
	b .L195
.L151:
	lwz 0,1840(8)
	cmpwi 0,0,1
	bc 12,2,.L158
	cmpwi 0,0,2
	bc 12,2,.L159
	b .L133
.L158:
	lis 9,.LC11@ha
	la 28,.LC11@l(9)
	b .L157
.L159:
	lis 9,.LC12@ha
	la 28,.LC12@l(9)
.L157:
	li 30,0
.L165:
	mr 3,30
	li 4,280
	mr 5,28
	bl G_Find
	mr. 30,3
	mcrf 7,0
	bc 12,30,.L133
	lwz 0,284(30)
	andis. 9,0,1
	bc 4,2,.L165
	bc 12,30,.L133
	lis 9,maxclients@ha
	lis 10,.LC41@ha
	lfs 11,4(27)
	lwz 11,maxclients@l(9)
	la 10,.LC41@l(10)
	lfs 0,0(10)
	lfs 13,20(11)
	li 10,1
	lfs 10,4(30)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L168
	lis 11,g_edicts@ha
	lis 9,itemlist@ha
	fmr 12,13
	lis 0,0x286b
	la 9,itemlist@l(9)
	lwz 7,g_edicts@l(11)
	ori 0,0,51739
	subf 9,9,26
	lis 11,.LC42@ha
	mullw 9,9,0
	lis 6,0x4330
	la 11,.LC42@l(11)
	lfd 13,0(11)
	rlwinm 8,9,0,0,29
	li 11,976
.L170:
	add 31,7,11
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L171
	lwz 9,84(31)
	addi 9,9,744
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 4,2,.L168
.L171:
	addi 10,10,1
	xoris 0,10,0x8000
	li 31,0
	stw 0,44(1)
	addi 11,11,976
	stw 6,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L170
.L168:
	fsubs 10,11,10
	lfs 13,8(27)
	lis 9,.LC45@ha
	addi 3,1,8
	lfs 12,12(27)
	la 9,.LC45@l(9)
	lfs 11,4(29)
	stfs 10,8(1)
	lfs 0,8(30)
	lfs 10,8(29)
	lfs 9,12(29)
	fsubs 13,13,0
	lfs 31,0(9)
	stfs 13,12(1)
	lfs 0,12(30)
	fsubs 12,12,0
	stfs 12,16(1)
	lfs 0,4(30)
	fsubs 11,11,0
	stfs 11,24(1)
	lfs 0,8(30)
	fsubs 10,10,0
	stfs 10,28(1)
	lfs 0,12(30)
	fsubs 9,9,0
	stfs 9,32(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L174
	addi 28,1,24
	mr 3,28
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L174
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L174
	mr 3,30
	mr 4,29
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L173
.L174:
	lwz 9,84(29)
	lwz 11,1836(9)
	addi 11,11,1
	stw 11,1836(9)
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 4,2,.L175
	lwz 11,84(29)
	lis 9,gi@ha
	la 10,gi@l(9)
	lwz 0,1840(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L176
	cmpwi 0,0,2
	bc 12,2,.L177
	b .L180
.L176:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L179
.L177:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L179
.L180:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L179:
	lwz 0,0(10)
	lis 4,.LC38@ha
	li 3,1
	la 4,.LC38@l(4)
	b .L195
.L175:
	lwz 11,84(29)
	lis 9,gi@ha
	la 10,gi@l(9)
	lwz 0,1840(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L182
	cmpwi 0,0,2
	bc 12,2,.L183
	b .L186
.L182:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L185
.L183:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L185
.L186:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L185:
	lwz 0,0(10)
	lis 4,.LC39@ha
	li 3,1
	la 4,.LC39@l(4)
.L195:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L133
.L173:
	xor 0,31,29
	addic 9,31,-1
	subfe 11,9,31
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L133
	lfs 13,4(31)
	addi 3,1,8
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	lfs 10,4(29)
	lfs 9,8(29)
	stfs 0,8(1)
	lfs 13,8(31)
	lfs 8,12(29)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,16(1)
	lfs 0,4(31)
	fsubs 10,10,0
	stfs 10,8(1)
	lfs 0,8(31)
	fsubs 9,9,0
	stfs 9,12(1)
	lfs 0,12(31)
	fsubs 8,8,0
	stfs 8,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L189
	mr 3,28
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L189
	mr 4,27
	mr 3,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L189
	mr 3,31
	mr 4,29
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L133
.L189:
	lwz 10,84(29)
	lis 11,gi@ha
	la 8,gi@l(11)
	lwz 9,1836(10)
	addi 9,9,1
	stw 9,1836(10)
	lwz 11,84(29)
	lwz 0,1840(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L190
	cmpwi 0,0,2
	bc 12,2,.L191
	b .L194
.L190:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L193
.L191:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L193
.L194:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L193:
	lwz 0,0(8)
	lis 4,.LC40@ha
	li 3,1
	la 4,.LC40@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L133:
	lwz 0,84(1)
	mtlr 0
	lmw 26,48(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 CTFFragBonuses,.Lfe6-CTFFragBonuses
	.align 2
	.globl CTFResetFlags
	.type	 CTFResetFlags,@function
CTFResetFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC11@ha
	li 31,0
	la 29,.LC11@l(9)
	b .L220
.L222:
	lwz 0,284(31)
	andis. 11,0,1
	bc 12,2,.L223
	mr 3,31
	bl G_FreeEdict
	b .L220
.L223:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 30,80(31)
.L220:
	mr 3,31
	li 4,280
	mr 5,29
	li 30,1
	bl G_Find
	mr. 31,3
	lis 9,gi+72@ha
	mr 3,31
	bc 4,2,.L222
	lis 9,.LC12@ha
	lis 11,gi@ha
	la 28,.LC12@l(9)
	la 29,gi@l(11)
	li 31,0
	b .L231
.L233:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L234
	mr 3,31
	bl G_FreeEdict
	b .L231
.L234:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L231:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L233
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 CTFResetFlags,.Lfe7-CTFResetFlags
	.section	".rodata"
	.align 2
.LC46:
	.string	"Don't know what team the flag is on.\n"
	.align 2
.LC47:
	.string	"%s captured the %s flag!\n"
	.align 2
.LC48:
	.string	"ctf/flagcap.wav"
	.align 2
.LC49:
	.string	"%s gets an assist for returning the flag!\n"
	.align 2
.LC50:
	.string	"%s gets an assist for fragging the flag carrier!\n"
	.align 2
.LC51:
	.string	"%s returned the %s flag!\n"
	.align 2
.LC52:
	.string	"ctf/flagret.wav"
	.align 2
.LC53:
	.string	"%s got the %s flag!\n"
	.align 2
.LC54:
	.long 0x3f800000
	.align 2
.LC55:
	.long 0x0
	.align 2
.LC56:
	.long 0x41200000
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFPickup_Flag
	.type	 CTFPickup_Flag,@function
CTFPickup_Flag:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stfd 31,72(1)
	stmw 19,20(1)
	stw 0,84(1)
	stw 12,16(1)
	mr 30,4
	mr 31,3
	lwz 3,280(31)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L238
	li 28,1
	b .L239
.L238:
	lwz 3,280(31)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L240
	lis 9,gi+8@ha
	lis 5,.LC46@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC46@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L291:
	li 3,0
	b .L288
.L240:
	li 28,2
.L239:
	cmpwi 4,28,1
	bc 4,18,.L242
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 27,flag1_item@l(9)
	lwz 29,flag2_item@l(11)
	b .L243
.L242:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 27,flag2_item@l(9)
	lwz 29,flag1_item@l(11)
.L243:
	lwz 5,84(30)
	lwz 0,1840(5)
	cmpw 0,28,0
	bc 4,2,.L244
	lwz 0,284(31)
	andis. 9,0,1
	bc 4,2,.L245
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,29
	addi 11,5,744
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L291
	lis 9,gi@ha
	addi 5,5,700
	la 11,gi@l(9)
	lis 26,gi@ha
	bc 12,18,.L247
	cmpwi 0,28,2
	bc 12,2,.L248
	b .L251
.L247:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L250
.L248:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L250
.L251:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L250:
	lwz 0,0(11)
	lis 4,.LC47@ha
	li 3,2
	la 4,.LC47@l(4)
	lis 19,level@ha
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,29
	addi 11,11,744
	mullw 9,9,0
	li 10,0
	lis 8,level+4@ha
	lis 6,ctfgame@ha
	rlwinm 9,9,0,0,29
	la 7,ctfgame@l(6)
	stwx 10,11,9
	lfs 0,level+4@l(8)
	stw 28,20(7)
	stfs 0,16(7)
	bc 4,18,.L252
	lwz 9,ctfgame@l(6)
	addi 9,9,1
	stw 9,ctfgame@l(6)
	b .L253
.L252:
	lwz 9,4(7)
	addi 9,9,1
	stw 9,4(7)
.L253:
	lis 29,gi@ha
	lis 3,.LC48@ha
	la 29,gi@l(29)
	la 3,.LC48@l(3)
	lwz 9,36(29)
	li 27,1
	lis 20,maxclients@ha
	mtlr 9
	blrl
	lis 9,.LC54@ha
	lwz 0,16(29)
	lis 10,.LC55@ha
	la 9,.LC54@l(9)
	la 10,.LC55@l(10)
	lfs 1,0(9)
	mr 5,3
	li 4,26
	mtlr 0
	lis 9,.LC55@ha
	lfs 2,0(10)
	mr 3,31
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC54@ha
	lwz 10,84(30)
	lis 11,maxclients@ha
	la 9,.LC54@l(9)
	lwz 8,maxclients@l(11)
	lfs 13,0(9)
	lwz 9,1836(10)
	addi 9,9,15
	stw 9,1836(10)
	lfs 0,20(8)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L255
	lis 21,g_edicts@ha
	lis 22,0x4330
	li 28,976
	lis 23,0xc0a0
	lis 24,.LC49@ha
	lis 25,.LC50@ha
.L257:
	lwz 0,g_edicts@l(21)
	add 29,0,28
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L256
	lwz 10,84(29)
	lwz 9,84(30)
	lwz 11,1840(10)
	lwz 0,1840(9)
	cmpw 0,11,0
	bc 12,2,.L289
	stw 23,1848(10)
	b .L256
.L289:
	cmpw 0,29,30
	bc 12,2,.L262
	lwz 9,1836(10)
	addi 9,9,10
	stw 9,1836(10)
.L262:
	lwz 5,84(29)
	lis 10,.LC56@ha
	la 31,level@l(19)
	la 10,.LC56@l(10)
	lfs 13,4(31)
	lfs 31,0(10)
	lfs 0,1852(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L263
	lwz 9,gi@l(26)
	addi 5,5,700
	li 3,2
	la 4,.LC49@l(24)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,1836(11)
	addi 9,9,1
	stw 9,1836(11)
.L263:
	lwz 5,84(29)
	lfs 13,4(31)
	lfs 0,1860(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L256
	lwz 9,gi@l(26)
	addi 5,5,700
	li 3,2
	la 4,.LC50@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,1836(11)
	addi 9,9,2
	stw 9,1836(11)
.L256:
	addi 27,27,1
	lwz 11,maxclients@l(20)
	xoris 0,27,0x8000
	lis 10,.LC57@ha
	stw 0,12(1)
	la 10,.LC57@l(10)
	addi 28,28,976
	stw 22,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L257
.L255:
	bl CTFResetFlags
	b .L291
.L245:
	lis 9,gi@ha
	addi 5,5,700
	la 11,gi@l(9)
	bc 12,18,.L266
	cmpwi 0,28,2
	bc 12,2,.L267
	b .L270
.L266:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L269
.L267:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L269
.L270:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L269:
	lwz 0,0(11)
	lis 4,.LC51@ha
	li 3,2
	la 4,.LC51@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 10,84(30)
	lis 8,level+4@ha
	lis 29,gi@ha
	la 29,gi@l(29)
	lis 3,.LC52@ha
	lwz 9,1836(10)
	la 3,.LC52@l(3)
	addi 9,9,1
	stw 9,1836(10)
	lfs 0,level+4@l(8)
	lwz 11,84(30)
	stfs 0,1852(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC54@ha
	lwz 0,16(29)
	lis 10,.LC55@ha
	la 9,.LC54@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC55@l(10)
	li 4,26
	mtlr 0
	lis 9,.LC55@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC55@l(9)
	lfs 3,0(9)
	blrl
	bc 12,18,.L271
	cmpwi 0,28,2
	bc 12,2,.L272
	b .L291
.L271:
	lis 9,.LC11@ha
	la 30,.LC11@l(9)
	b .L274
.L272:
	lis 9,.LC12@ha
	la 30,.LC12@l(9)
.L274:
	lis 9,gi@ha
	li 29,0
	la 28,gi@l(9)
	li 31,1
	b .L276
.L278:
	lwz 0,284(29)
	andis. 9,0,1
	bc 12,2,.L279
	mr 3,29
	bl G_FreeEdict
	b .L276
.L279:
	lwz 0,184(29)
	mr 3,29
	stw 31,248(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 31,80(29)
.L276:
	mr 3,29
	li 4,280
	mr 5,30
	bl G_Find
	mr. 29,3
	bc 4,2,.L278
	b .L291
.L244:
	lis 9,gi@ha
	addi 5,5,700
	la 11,gi@l(9)
	bc 12,18,.L282
	cmpwi 0,28,2
	bc 12,2,.L283
	b .L286
.L282:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L285
.L283:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L285
.L286:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L285:
	lwz 0,0(11)
	lis 4,.LC53@ha
	li 3,2
	la 4,.LC53@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 8,84(30)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,27
	mr 9,8
	mullw 11,11,0
	li 7,1
	addi 9,9,744
	lis 6,level+4@ha
	rlwinm 11,11,0,0,29
	stwx 7,9,11
	lfs 0,level+4@l(6)
	lwz 10,84(30)
	stfs 0,1856(10)
	lwz 0,284(31)
	andis. 11,0,0x1
	bc 4,2,.L287
	lwz 0,264(31)
	lwz 9,184(31)
	oris 0,0,0x8000
	stw 11,248(31)
	ori 9,9,1
	stw 0,264(31)
	stw 9,184(31)
.L287:
	li 3,1
.L288:
	lwz 0,84(1)
	lwz 12,16(1)
	mtlr 0
	lmw 19,20(1)
	lfd 31,72(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe8:
	.size	 CTFPickup_Flag,.Lfe8-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC58:
	.string	"The %s flag has returned!\n"
	.section	".text"
	.align 2
	.type	 CTFDropFlagThink,@function
CTFDropFlagThink:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 29,.LC11@ha
	lwz 3,280(31)
	la 4,.LC11@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L295
	la 30,.LC11@l(29)
	li 31,0
	b .L301
.L303:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L304
	mr 3,31
	bl G_FreeEdict
	b .L301
.L304:
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
	stw 29,80(31)
.L301:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L303
	lis 9,gi@ha
	lis 5,.LC13@ha
	lwz 0,gi@l(9)
	lis 4,.LC58@ha
	la 5,.LC13@l(5)
	la 4,.LC58@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L312
.L295:
	lwz 3,280(31)
	lis 31,.LC12@ha
	la 4,.LC12@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L312
	la 30,.LC12@l(31)
	li 31,0
	b .L319
.L321:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L322
	mr 3,31
	bl G_FreeEdict
	b .L319
.L322:
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
	stw 29,80(31)
.L319:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L321
	lis 9,gi@ha
	lis 5,.LC14@ha
	lwz 0,gi@l(9)
	lis 4,.LC58@ha
	la 5,.LC14@l(5)
	la 4,.LC58@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L312:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 CTFDropFlagThink,.Lfe9-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC59:
	.string	"%s lost the %s flag!\n"
	.align 2
.LC60:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl CTFDeadDropFlag
	.type	 CTFDeadDropFlag,@function
CTFDeadDropFlag:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,flag1_item@ha
	mr 31,3
	lwz 0,flag1_item@l(9)
	li 27,0
	lis 26,flag1_item@ha
	lis 25,flag2_item@ha
	cmpwi 0,0,0
	bc 12,2,.L332
	lwz 0,flag2_item@l(25)
	cmpwi 0,0,0
	bc 4,2,.L331
.L332:
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	lis 4,.LC8@ha
	lwz 9,144(29)
	la 4,.LC8@l(4)
	li 5,16
	la 3,.LC7@l(3)
	mtlr 9
	blrl
	lwz 0,144(29)
	lis 9,ctf@ha
	lis 11,.LC9@ha
	stw 3,ctf@l(9)
	lis 4,.LC10@ha
	li 5,0
	mtlr 0
	la 3,.LC9@l(11)
	la 4,.LC10@l(4)
	blrl
	lwz 0,flag1_item@l(26)
	lis 9,ctf_forcejoin@ha
	stw 3,ctf_forcejoin@l(9)
	cmpwi 0,0,0
	bc 4,2,.L333
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(26)
.L333:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	cmpwi 0,0,0
	bc 4,2,.L334
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	bl FindItemByClassname
	stw 3,flag2_item@l(25)
.L334:
	lis 3,ctfgame@ha
	li 4,0
	la 3,ctfgame@l(3)
	li 5,24
	crxor 6,6,6
	bl memset
	lis 9,techspawn@ha
	stw 27,techspawn@l(9)
.L331:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 4,flag1_item@l(9)
	la 30,itemlist@l(11)
	lis 29,0x286b
	ori 29,29,51739
	addi 10,10,744
	subf 0,30,4
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 28,10,0
	cmpwi 0,28,0
	bc 12,2,.L336
	mr 3,31
	bl Drop_Item
	lwz 0,flag1_item@l(26)
	li 10,0
	lis 11,gi@ha
	lwz 9,84(31)
	mr 27,3
	lis 6,.LC13@ha
	subf 0,30,0
	lis 4,.LC59@ha
	mullw 0,0,29
	addi 9,9,744
	la 4,.LC59@l(4)
	la 6,.LC13@l(6)
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	lwz 5,84(31)
	lwz 0,gi@l(11)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L342
.L336:
	lis 9,flag2_item@ha
	lwz 4,flag2_item@l(9)
	subf 0,30,4
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L342
	mr 3,31
	bl Drop_Item
	lwz 0,flag2_item@l(25)
	lis 11,gi@ha
	mr 27,3
	lwz 9,84(31)
	lis 6,.LC14@ha
	lis 4,.LC59@ha
	subf 0,30,0
	la 4,.LC59@l(4)
	mullw 0,0,29
	addi 9,9,744
	la 6,.LC14@l(6)
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 28,9,0
	lwz 5,84(31)
	lwz 0,gi@l(11)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L342:
	cmpwi 0,27,0
	bc 12,2,.L349
	lis 11,CTFDropFlagThink@ha
	lis 9,.LC60@ha
	la 11,CTFDropFlagThink@l(11)
	la 9,.LC60@l(9)
	lis 10,level+4@ha
	stw 11,436(27)
	lfs 0,level+4@l(10)
	lfs 13,0(9)
	lis 9,CTFDropFlagTouch@ha
	la 9,CTFDropFlagTouch@l(9)
	fadds 0,0,13
	stw 9,444(27)
	stfs 0,428(27)
.L349:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 CTFDeadDropFlag,.Lfe10-CTFDeadDropFlag
	.section	".rodata"
	.align 2
.LC61:
	.string	"Only lusers drop flags.\n"
	.align 2
.LC62:
	.string	"Winners don't drop flags.\n"
	.align 2
.LC64:
	.string	"CTFFlagSetup: %s startsolid at %s\n"
	.align 3
.LC65:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC66:
	.long 0xc1700000
	.align 2
.LC67:
	.long 0x41700000
	.align 2
.LC68:
	.long 0x0
	.align 2
.LC69:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl CTFFlagSetup
	.type	 CTFFlagSetup,@function
CTFFlagSetup:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	lis 9,.LC66@ha
	lis 11,.LC66@ha
	la 9,.LC66@l(9)
	la 11,.LC66@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC66@ha
	lfs 2,0(11)
	la 9,.LC66@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC67@ha
	lfs 13,0(11)
	la 9,.LC67@l(9)
	lfs 1,0(9)
	lis 9,.LC67@ha
	stfs 13,188(31)
	la 9,.LC67@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC67@ha
	stfs 0,192(31)
	la 9,.LC67@l(9)
	lfs 13,8(11)
	lfs 3,0(9)
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
	bc 12,2,.L356
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L357
.L356:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L357:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC68@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC68@l(11)
	lis 9,.LC69@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC69@l(9)
	lis 11,.LC68@ha
	lfs 3,0(9)
	la 11,.LC68@l(11)
	lfs 2,0(11)
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
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 12,2,.L358
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L355
.L358:
	lfs 0,24(1)
	mr 3,31
	lfs 13,28(1)
	lfs 12,20(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 11,level+4@ha
	lis 10,.LC65@ha
	lfs 0,level+4@l(11)
	lis 9,CTFFlagThink@ha
	lfd 13,.LC65@l(10)
	la 9,CTFFlagThink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L355:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe11:
	.size	 CTFFlagSetup,.Lfe11-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC70:
	.string	"players/male/flag1.md2"
	.align 2
.LC71:
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
	bc 4,1,.L360
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 7,itemlist@l(11)
	lis 10,0x286b
	ori 10,10,51739
	lwz 11,84(31)
	subf 0,7,0
	mullw 0,0,10
	addi 11,11,744
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L361
	oris 0,8,0x4
	stw 0,64(31)
.L361:
	lis 9,flag2_item@ha
	lwz 11,84(31)
	lwz 0,flag2_item@l(9)
	addi 11,11,744
	subf 0,7,0
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L360
	lwz 0,64(31)
	oris 0,0,0x8
	stw 0,64(31)
.L360:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag1_item@l(9)
	la 8,itemlist@l(11)
	lis 11,0x286b
	addi 10,10,744
	ori 11,11,51739
	subf 0,8,0
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L363
	lis 9,gi+32@ha
	lis 3,.LC70@ha
	lwz 0,gi+32@l(9)
	la 3,.LC70@l(3)
	b .L367
.L363:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	subf 0,8,0
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 10,10,0
	cmpwi 0,10,0
	bc 12,2,.L365
	lis 9,gi+32@ha
	lis 3,.LC71@ha
	lwz 0,gi+32@l(9)
	la 3,.LC71@l(3)
.L367:
	mtlr 0
	blrl
	stw 3,48(31)
	b .L364
.L365:
	stw 10,48(31)
.L364:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 CTFEffects,.Lfe12-CTFEffects
	.section	".rodata"
	.align 2
.LC72:
	.long 0x0
	.align 3
.LC73:
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
	lis 9,.LC72@ha
	stw 0,8(8)
	li 6,0
	la 9,.LC72@l(9)
	stw 0,12(8)
	lfs 13,0(9)
	lfs 0,20(7)
	fcmpu 0,13,0
	bc 4,0,.L370
	lis 9,g_edicts@ha
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	mr 5,7
	la 11,game@l(11)
	lis 9,.LC73@ha
	lis 4,0x4330
	la 9,.LC73@l(9)
	addi 10,10,1064
	lfd 12,0(9)
	li 7,0
.L372:
	lwz 0,0(10)
	addi 10,10,976
	cmpwi 0,0,0
	bc 12,2,.L371
	lwz 0,1028(11)
	add 9,7,0
	lwz 0,1840(9)
	cmpwi 0,0,1
	bc 4,2,.L374
	lwz 9,1836(9)
	lwz 0,8(8)
	add 0,0,9
	stw 0,8(8)
	b .L371
.L374:
	cmpwi 0,0,2
	bc 4,2,.L371
	lwz 9,1836(9)
	lwz 0,12(8)
	add 0,0,9
	stw 0,12(8)
.L371:
	addi 6,6,1
	lfs 13,20(5)
	xoris 0,6,0x8000
	addi 7,7,2384
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L372
.L370:
	la 1,16(1)
	blr
.Lfe13:
	.size	 CTFCalcScores,.Lfe13-CTFCalcScores
	.section	".rodata"
	.align 2
.LC74:
	.string	"Disabling player identication display.\n"
	.align 2
.LC75:
	.string	"Activating player identication display.\n"
	.align 3
.LC76:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC77:
	.long 0x0
	.align 2
.LC78:
	.long 0x44800000
	.align 2
.LC79:
	.long 0x3f800000
	.align 3
.LC80:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 CTFSetIDView,@function
CTFSetIDView:
	stwu 1,-176(1)
	mflr 0
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 24,120(1)
	stw 0,180(1)
	mr 30,3
	li 0,0
	lwz 9,84(30)
	lis 11,.LC77@ha
	addi 4,1,8
	la 11,.LC77@l(11)
	li 5,0
	sth 0,174(9)
	li 6,0
	lwz 3,84(30)
	lfs 29,0(11)
	addi 3,3,2072
	bl AngleVectors
	lis 9,.LC78@ha
	addi 3,1,8
	la 9,.LC78@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lfs 12,4(30)
	lis 11,gi+48@ha
	li 9,3
	lfs 0,8(30)
	addi 3,1,40
	addi 4,30,4
	lfs 13,12(30)
	li 5,0
	li 6,0
	lfs 9,8(1)
	addi 7,1,8
	mr 8,30
	lfs 10,12(1)
	lfs 11,16(1)
	lwz 0,gi+48@l(11)
	fadds 12,12,9
	fadds 0,0,10
	fadds 13,13,11
	mtlr 0
	stfs 12,8(1)
	stfs 0,12(1)
	stfs 13,16(1)
	blrl
	lis 9,.LC79@ha
	lfs 13,48(1)
	la 9,.LC79@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L382
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L382
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L382
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	subf 9,9,30
	b .L391
.L382:
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	li 27,0
	addi 3,3,2072
	li 28,1
	bl AngleVectors
	lis 24,maxclients@ha
	lis 9,.LC79@ha
	lis 11,maxclients@ha
	la 9,.LC79@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L384
	lis 11,.LC80@ha
	lis 25,g_edicts@ha
	la 11,.LC80@l(11)
	lis 26,0x4330
	lfd 30,0(11)
	li 29,976
.L386:
	lwz 0,g_edicts@l(25)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L385
	lfs 0,4(30)
	addi 3,1,24
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(31)
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
	bc 4,1,.L385
	mr 3,30
	mr 4,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L385
	fmr 29,31
	mr 27,31
.L385:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	addi 29,29,976
	stw 0,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L386
.L384:
	lis 9,.LC76@ha
	fmr 13,29
	lfd 0,.LC76@l(9)
	fcmpu 0,13,0
	bc 4,1,.L381
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	subf 9,9,27
.L391:
	mullw 9,9,0
	srawi 9,9,4
	addi 9,9,1311
	sth 9,174(10)
.L381:
	lwz 0,180(1)
	mtlr 0
	lmw 24,120(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe14:
	.size	 CTFSetIDView,.Lfe14-CTFSetIDView
	.section	".rodata"
	.align 2
.LC81:
	.string	"ctfsb1"
	.align 2
.LC82:
	.string	"ctfsb2"
	.align 2
.LC83:
	.string	"i_ctf1"
	.align 2
.LC84:
	.string	"i_ctf1d"
	.align 2
.LC85:
	.string	"i_ctf1t"
	.align 2
.LC86:
	.string	"i_ctf2"
	.align 2
.LC87:
	.string	"i_ctf2d"
	.align 2
.LC88:
	.string	"i_ctf2t"
	.align 2
.LC89:
	.string	"i_ctfj"
	.align 2
.LC90:
	.long 0x0
	.align 2
.LC91:
	.long 0x3f800000
	.align 3
.LC92:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC93:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl SetCTFStats
	.type	 SetCTFStats,@function
SetCTFStats:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC81@ha
	lwz 9,40(29)
	la 3,.LC81@l(3)
	lis 27,level@ha
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC82@ha
	sth 3,168(9)
	lwz 0,40(29)
	la 3,.LC82@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 10,.LC90@ha
	lis 11,level+200@ha
	la 10,.LC90@l(10)
	sth 3,170(9)
	lfs 13,0(10)
	lfs 0,level+200@l(11)
	lis 10,ctfgame@ha
	fcmpu 0,0,13
	bc 12,2,.L393
	lwz 0,level@l(27)
	andi. 11,0,8
	bc 12,2,.L393
	la 11,ctfgame@l(10)
	lwz 9,ctfgame@l(10)
	lwz 0,4(11)
	cmpw 0,9,0
	bc 12,1,.L444
	cmpw 0,0,9
	bc 12,1,.L445
	lwz 9,12(11)
	lwz 0,8(11)
	cmpw 0,0,9
	bc 4,1,.L398
.L444:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	b .L393
.L398:
	cmpw 0,9,0
	bc 4,1,.L400
.L445:
	lwz 9,84(31)
	li 0,0
	sth 0,170(9)
	b .L393
.L441:
	lis 9,gi+40@ha
	lwz 3,36(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,172(9)
	b .L403
.L400:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	lwz 11,84(31)
	sth 0,170(11)
.L393:
	lwz 10,84(31)
	li 11,0
	lis 9,tnames@ha
	la 3,tnames@l(9)
	sth 11,172(10)
	lwzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L403
	lis 9,itemlist@ha
	lis 29,0x286b
	la 28,itemlist@l(9)
	mr 30,3
	ori 29,29,51739
.L404:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L405
	subf 0,28,3
	lwz 11,84(31)
	mullw 0,0,29
	addi 11,11,744
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L441
.L405:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L404
.L403:
	lis 9,gi@ha
	lis 3,.LC83@ha
	la 30,gi@l(9)
	la 3,.LC83@l(3)
	lwz 9,40(30)
	mtlr 9
	blrl
	mr 28,3
	lis 5,.LC11@ha
	la 5,.LC11@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L407
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L408
	lwz 0,40(30)
	lis 3,.LC84@ha
	la 3,.LC84@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC91@ha
	lwz 11,maxclients@l(9)
	la 10,.LC91@l(10)
	mr 28,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L407
	lis 11,flag1_item@ha
	lis 9,itemlist@ha
	fmr 12,13
	lwz 10,flag1_item@l(11)
	la 9,itemlist@l(9)
	lis 0,0x286b
	lis 11,g_edicts@ha
	ori 0,0,51739
	subf 10,9,10
	lwz 8,g_edicts@l(11)
	lis 9,.LC92@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC92@l(9)
	addi 8,8,976
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L412:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L411
	lwz 9,84(8)
	addi 9,9,744
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L442
.L411:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,976
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L412
	b .L407
.L442:
	lis 9,gi+40@ha
	lis 3,.LC85@ha
	lwz 0,gi+40@l(9)
	la 3,.LC85@l(3)
	b .L446
.L408:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L407
	lwz 0,40(30)
	lis 3,.LC84@ha
	la 3,.LC84@l(3)
.L446:
	mtlr 0
	blrl
	mr 28,3
.L407:
	lis 9,gi@ha
	lis 3,.LC86@ha
	la 30,gi@l(9)
	la 3,.LC86@l(3)
	lwz 9,40(30)
	mtlr 9
	blrl
	mr 29,3
	lis 5,.LC12@ha
	la 5,.LC12@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L417
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L418
	lwz 0,40(30)
	lis 3,.LC87@ha
	la 3,.LC87@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC91@ha
	lwz 11,maxclients@l(9)
	la 10,.LC91@l(10)
	mr 29,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L417
	lis 11,flag2_item@ha
	lis 9,itemlist@ha
	fmr 12,13
	lwz 10,flag2_item@l(11)
	la 9,itemlist@l(9)
	lis 0,0x286b
	lis 11,g_edicts@ha
	ori 0,0,51739
	subf 10,9,10
	lwz 8,g_edicts@l(11)
	lis 9,.LC92@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC92@l(9)
	addi 8,8,976
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L422:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L421
	lwz 9,84(8)
	addi 9,9,744
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L443
.L421:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,976
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L422
	b .L417
.L443:
	lis 9,gi+40@ha
	lis 3,.LC88@ha
	lwz 0,gi+40@l(9)
	la 3,.LC88@l(3)
	b .L447
.L418:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L417
	lwz 0,40(30)
	lis 3,.LC87@ha
	la 3,.LC87@l(3)
.L447:
	mtlr 0
	blrl
	mr 29,3
.L417:
	lis 10,.LC90@ha
	lwz 11,84(31)
	lis 9,ctfgame@ha
	la 10,.LC90@l(10)
	lfs 0,0(10)
	sth 28,154(11)
	la 10,ctfgame@l(9)
	lwz 9,84(31)
	sth 29,158(9)
	lfs 12,16(10)
	fcmpu 0,12,0
	bc 12,2,.L427
	lis 9,level+4@ha
	lis 11,.LC93@ha
	lfs 0,level+4@l(9)
	la 11,.LC93@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L427
	lwz 0,20(10)
	cmpwi 0,0,1
	bc 4,2,.L428
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L429
	lwz 9,84(31)
	sth 28,154(9)
	b .L427
.L429:
	lwz 9,84(31)
	sth 0,154(9)
	b .L427
.L428:
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L432
	lwz 9,84(31)
	sth 29,158(9)
	b .L427
.L432:
	lwz 9,84(31)
	sth 0,158(9)
.L427:
	lis 11,ctfgame@ha
	lwz 9,84(31)
	li 8,0
	la 11,ctfgame@l(11)
	lhz 0,2(11)
	sth 0,156(9)
	lhz 10,6(11)
	lwz 9,84(31)
	sth 10,160(9)
	lwz 11,84(31)
	sth 8,162(11)
	lwz 10,84(31)
	lwz 0,1840(10)
	cmpwi 0,0,1
	bc 4,2,.L434
	lis 9,flag2_item@ha
	lis 11,itemlist@ha
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	addi 10,10,744
	lis 9,0x286b
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L434
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L434
	lis 9,gi+40@ha
	lis 3,.LC86@ha
	lwz 0,gi+40@l(9)
	la 3,.LC86@l(3)
	b .L448
.L434:
	lwz 10,84(31)
	lwz 0,1840(10)
	cmpwi 0,0,2
	bc 4,2,.L435
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	addi 10,10,744
	lis 9,0x286b
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L435
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L435
	lis 9,gi+40@ha
	lis 3,.LC83@ha
	lwz 0,gi+40@l(9)
	la 3,.LC83@l(3)
.L448:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,162(9)
.L435:
	lwz 11,84(31)
	li 0,0
	sth 0,164(11)
	lwz 9,84(31)
	sth 0,166(9)
	lwz 11,84(31)
	lwz 0,1840(11)
	cmpwi 0,0,1
	bc 4,2,.L437
	lis 9,gi+40@ha
	lis 3,.LC89@ha
	lwz 0,gi+40@l(9)
	la 3,.LC89@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,164(9)
	b .L438
.L437:
	cmpwi 0,0,2
	bc 4,2,.L438
	lis 9,gi+40@ha
	lis 3,.LC89@ha
	lwz 0,gi+40@l(9)
	la 3,.LC89@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,166(9)
.L438:
	lwz 11,84(31)
	li 0,0
	sth 0,174(11)
	lwz 9,84(31)
	lwz 0,1864(9)
	cmpwi 0,0,0
	bc 12,2,.L440
	mr 3,31
	bl CTFSetIDView
.L440:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 SetCTFStats,.Lfe15-SetCTFStats
	.section	".rodata"
	.align 2
.LC94:
	.string	"You are on the %s team.\n"
	.align 2
.LC95:
	.string	"red"
	.align 2
.LC96:
	.string	"blue"
	.align 2
.LC97:
	.string	"Unknown team %s.\n"
	.align 2
.LC98:
	.string	"You are already on the %s team.\n"
	.align 2
.LC99:
	.string	"skin"
	.align 2
.LC100:
	.string	"%s joined the %s team.\n"
	.align 2
.LC101:
	.string	"%s changed to the %s team.\n"
	.section	".text"
	.align 2
	.globl CTFTeam_f
	.type	 CTFTeam_f,@function
CTFTeam_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L452
	lwz 9,84(31)
	lwz 0,1840(9)
	cmpwi 0,0,1
	bc 12,2,.L453
	cmpwi 0,0,2
	bc 12,2,.L454
	b .L457
.L453:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L456
.L454:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L456
.L457:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L456:
	lwz 0,8(29)
	lis 5,.LC94@ha
	mr 3,31
	la 5,.LC94@l(5)
	li 4,2
	b .L479
.L452:
	lis 4,.LC95@ha
	mr 3,30
	la 4,.LC95@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L458
	li 30,1
	b .L459
.L458:
	lis 4,.LC96@ha
	mr 3,30
	la 4,.LC96@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 12,2,.L460
	lwz 0,8(29)
	lis 5,.LC97@ha
	mr 3,31
	la 5,.LC97@l(5)
	mr 6,30
	li 4,2
	b .L479
.L460:
	li 30,2
.L459:
	lwz 9,84(31)
	lwz 0,1840(9)
	cmpw 0,0,30
	bc 4,2,.L462
	cmpwi 0,30,1
	lis 9,gi@ha
	la 11,gi@l(9)
	bc 12,2,.L463
	cmpwi 0,30,2
	bc 12,2,.L464
	b .L467
.L463:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L466
.L464:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L466
.L467:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L466:
	lwz 0,8(11)
	lis 5,.LC98@ha
	mr 3,31
	la 5,.LC98@l(5)
	li 4,2
	b .L479
.L462:
	lwz 0,264(31)
	li 29,0
	lis 4,.LC99@ha
	stw 29,184(31)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,28,26
	stw 0,264(31)
	stw 30,1840(9)
	lwz 9,84(31)
	stw 29,1844(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L468
	mr 3,31
	bl PutClientInServer
	lwz 10,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	lis 9,gi@ha
	li 8,14
	stb 11,16(10)
	cmpwi 0,30,1
	lwz 11,84(31)
	la 10,gi@l(9)
	stb 8,17(11)
	lwz 9,84(31)
	addi 5,9,700
	bc 12,2,.L469
	cmpwi 0,30,2
	bc 12,2,.L470
	b .L473
.L469:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L472
.L470:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L472
.L473:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L472:
	lwz 0,0(10)
	lis 4,.LC100@ha
	li 3,2
	la 4,.LC100@l(4)
.L479:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L451
.L468:
	lis 6,0x1
	lis 7,vec3_origin@ha
	stw 29,480(31)
	mr 5,31
	la 7,vec3_origin@l(7)
	mr 3,31
	mr 4,31
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl respawn
	lwz 11,84(31)
	lis 9,gi@ha
	cmpwi 0,30,1
	la 10,gi@l(9)
	stw 29,1836(11)
	lwz 9,84(31)
	addi 5,9,700
	bc 12,2,.L474
	cmpwi 0,30,2
	bc 12,2,.L475
	b .L478
.L474:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L477
.L475:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L477
.L478:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L477:
	lwz 0,0(10)
	lis 4,.LC101@ha
	li 3,2
	la 4,.LC101@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L451:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 CTFTeam_f,.Lfe16-CTFTeam_f
	.section	".rodata"
	.align 2
.LC102:
	.string	"if 24 xv 8 yv 8 pic 24 endif xv 40 yv 28 string \"%4d/%-3d\" xv 98 yv 12 num 2 18 if 25 xv 168 yv 8 pic 25 endif xv 200 yv 28 string \"%4d/%-3d\" xv 256 yv 12 num 2 20 "
	.align 2
.LC103:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC104:
	.string	"xv 56 yv %d picn sbfctf2 "
	.align 2
.LC105:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC106:
	.string	"xv 216 yv %d picn sbfctf1 "
	.align 2
.LC107:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC108:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC109:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC110:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC111:
	.long 0x0
	.align 3
.LC112:
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
	mr 14,9
	addi 21,1,1032
	stw 26,6544(1)
	bc 4,0,.L482
	lis 9,g_edicts@ha
	mr 20,8
	lwz 16,g_edicts@l(9)
	mr 12,17
	mr 19,14
	addi 18,1,4488
	mr 15,17
.L484:
	mulli 9,24,976
	addi 22,24,1
	add 31,9,16
	lwz 0,1064(31)
	cmpwi 0,0,0
	bc 12,2,.L483
	mulli 9,24,2384
	lwz 0,1028(20)
	mr 8,9
	add 9,9,0
	lwz 0,1840(9)
	cmpwi 0,0,1
	bc 4,2,.L486
	li 10,0
	b .L487
.L486:
	cmpwi 0,0,2
	bc 4,2,.L483
	li 10,1
.L487:
	slwi 0,10,2
	lwz 9,1028(20)
	li 27,0
	lwzx 11,12,0
	mr 3,0
	slwi 7,10,10
	add 9,8,9
	addi 6,1,4488
	cmpw 0,27,11
	lwz 30,1836(9)
	addi 4,1,2440
	addi 22,24,1
	bc 4,0,.L491
	lwzx 0,18,7
	cmpw 0,30,0
	bc 12,1,.L491
	lwzx 11,3,15
	add 9,7,6
.L492:
	addi 27,27,1
	cmpw 0,27,11
	bc 4,0,.L491
	lwzu 0,4(9)
	cmpw 0,30,0
	bc 4,1,.L492
.L491:
	lwzx 28,3,12
	slwi 23,27,2
	cmpw 0,28,27
	bc 4,1,.L497
	addi 11,4,-4
	slwi 9,28,2
	add 11,7,11
	addi 0,6,-4
	add 0,7,0
	add 10,9,11
	mr 29,4
	add 8,9,0
	add 11,9,7
	mr 5,6
.L499:
	lwz 9,0(10)
	addi 28,28,-1
	cmpw 0,28,27
	addi 10,10,-4
	stwx 9,11,29
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L499
.L497:
	add 0,23,7
	stwx 24,4,0
	stwx 30,6,0
	lwzx 9,3,19
	lwzx 11,3,12
	add 9,9,30
	addi 11,11,1
	stwx 9,3,19
	stwx 11,3,12
.L483:
	lwz 0,1544(20)
	mr 24,22
	cmpw 0,24,0
	bc 12,0,.L484
.L482:
	li 0,0
	lwz 7,4(14)
	lis 4,.LC102@ha
	lwz 8,4(17)
	la 4,.LC102@l(4)
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
	b .L534
.L506:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,24,9
	bc 4,0,.L507
	addi 29,1,2440
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,976
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,2384
	addi 9,9,976
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC103@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC103@l(4)
	cmpwi 7,11,1000
	lwz 7,1836(30)
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
	lis 9,0x286b
	addi 10,10,744
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L509
	mr 3,23
	bl strlen
	lis 4,.LC104@ha
	mr 5,27
	la 4,.LC104@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L509:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L507
	mr 4,23
	mr 3,21
	bl strcat
	mr 25,24
	mr 3,21
	bl strlen
	mr 22,3
.L507:
	lwz 0,4(17)
	cmpw 0,24,0
	bc 4,0,.L504
	addi 29,1,3464
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,976
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,2384
	addi 9,9,976
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC105@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC105@l(4)
	cmpwi 7,11,1000
	lwz 7,1836(30)
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
	lis 9,0x286b
	addi 10,10,744
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L513
	mr 3,23
	bl strlen
	lis 4,.LC106@ha
	mr 5,27
	la 4,.LC106@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L513:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L504
	mr 4,23
	mr 3,21
	bl strcat
	mr 26,24
	mr 3,21
	bl strlen
	mr 22,3
.L504:
	addi 24,24,1
	cmpwi 0,24,15
	bc 12,1,.L503
	lwz 0,6536(1)
.L534:
	cmpw 0,24,0
	bc 12,0,.L506
	lwz 0,4(17)
	cmpw 0,24,0
	bc 12,0,.L506
.L503:
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
	bc 4,1,.L518
	lis 9,maxclients@ha
	lis 10,.LC111@ha
	lwz 11,maxclients@l(9)
	la 10,.LC111@l(10)
	li 24,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L518
	lis 9,game@ha
	lis 14,g_edicts@ha
	la 15,game@l(9)
	mr 23,21
	lis 16,0x4330
	li 19,0
	li 20,976
.L522:
	lwz 0,g_edicts@l(14)
	lwz 11,1028(15)
	add 31,0,20
	lwz 9,88(31)
	add 30,11,19
	cmpwi 0,9,0
	bc 12,2,.L521
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L521
	lwz 9,84(31)
	lwz 0,1840(9)
	cmpwi 0,0,0
	bc 4,2,.L521
	cmpwi 0,28,0
	bc 4,2,.L525
	lis 4,.LC107@ha
	mr 5,27
	addi 3,1,8
	la 4,.LC107@l(4)
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
.L525:
	addi 3,1,8
	subfic 29,22,1000
	mr 31,3
	bl strlen
	lwz 11,184(30)
	rlwinm 5,18,0,31,31
	lis 4,.LC108@ha
	cmpwi 4,5,0
	lwz 8,1836(30)
	la 4,.LC108@l(4)
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
	bc 4,1,.L529
	mr 4,31
	mr 3,23
	bl strcat
	mr 3,23
	bl strlen
	mr 22,3
.L529:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,27,8
	neg 0,0
	addi 18,18,1
	andc 9,9,0
	and 0,27,0
	or 27,0,9
.L521:
	lis 10,maxclients@ha
	addi 24,24,1
	lwz 11,maxclients@l(10)
	xoris 0,24,0x8000
	lis 10,.LC112@ha
	stw 0,6572(1)
	addi 19,19,2384
	la 10,.LC112@l(10)
	stw 16,6568(1)
	addi 20,20,976
	lfd 12,0(10)
	lfd 0,6568(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L522
.L518:
	lwz 0,6536(1)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L532
	mr 3,21
	bl strlen
	lwz 6,6536(1)
	slwi 5,25,3
	lis 4,.LC109@ha
	la 4,.LC109@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L532:
	lwz 0,4(17)
	subf 0,26,0
	cmpwi 0,0,1
	bc 4,1,.L533
	mr 3,21
	bl strlen
	lwz 6,4(17)
	slwi 5,26,3
	lis 4,.LC110@ha
	la 4,.LC110@l(4)
	addi 5,5,50
	subf 6,26,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L533:
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
.Lfe17:
	.size	 CTFScoreboardMessage,.Lfe17-CTFScoreboardMessage
	.globl loc_names
	.section	".data"
	.align 2
	.type	 loc_names,@object
loc_names:
	.long .LC11
	.long 1
	.long .LC12
	.long 1
	.long .LC113
	.long 2
	.long .LC114
	.long 2
	.long .LC115
	.long 3
	.long .LC116
	.long 4
	.long .LC117
	.long 4
	.long .LC118
	.long 4
	.long .LC119
	.long 4
	.long .LC120
	.long 4
	.long .LC121
	.long 4
	.long .LC122
	.long 4
	.long .LC123
	.long 4
	.long .LC124
	.long 5
	.long .LC125
	.long 5
	.long .LC126
	.long 6
	.long .LC127
	.long 6
	.long .LC128
	.long 6
	.long .LC129
	.long 7
	.long .LC130
	.long 7
	.long .LC131
	.long 7
	.long .LC132
	.long 7
	.long .LC133
	.long 8
	.long .LC134
	.long 8
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC134:
	.string	"item_pack"
	.align 2
.LC133:
	.string	"item_bandolier"
	.align 2
.LC132:
	.string	"item_adrenaline"
	.align 2
.LC131:
	.string	"item_enviro"
	.align 2
.LC130:
	.string	"item_breather"
	.align 2
.LC129:
	.string	"item_silencer"
	.align 2
.LC128:
	.string	"item_armor_jacket"
	.align 2
.LC127:
	.string	"item_armor_combat"
	.align 2
.LC126:
	.string	"item_armor_body"
	.align 2
.LC125:
	.string	"item_power_shield"
	.align 2
.LC124:
	.string	"item_power_screen"
	.align 2
.LC123:
	.string	"weapon_shotgun"
	.align 2
.LC122:
	.string	"weapon_supershotgun"
	.align 2
.LC121:
	.string	"weapon_machinegun"
	.align 2
.LC120:
	.string	"weapon_grenadelauncher"
	.align 2
.LC119:
	.string	"weapon_chaingun"
	.align 2
.LC118:
	.string	"weapon_hyperblaster"
	.align 2
.LC117:
	.string	"weapon_rocketlauncher"
	.align 2
.LC116:
	.string	"weapon_railgun"
	.align 2
.LC115:
	.string	"weapon_bfg"
	.align 2
.LC114:
	.string	"item_invulnerability"
	.align 2
.LC113:
	.string	"item_quad"
	.size	 loc_names,200
	.align 2
.LC136:
	.string	"nowhere"
	.align 2
.LC137:
	.string	"in the water "
	.align 2
.LC138:
	.string	"above "
	.align 2
.LC139:
	.string	"below "
	.align 2
.LC140:
	.string	"near "
	.align 2
.LC141:
	.string	"the red "
	.align 2
.LC142:
	.string	"the blue "
	.align 2
.LC143:
	.string	"the "
	.align 2
.LC135:
	.long 0x497423f0
	.align 2
.LC144:
	.long 0x44800000
	.align 3
.LC145:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC146:
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
	lis 11,.LC135@ha
	la 20,loc_names+4@l(9)
	lfs 31,.LC135@l(11)
	mr 27,3
	lis 9,.LC144@ha
	addi 17,20,-4
	la 9,.LC144@l(9)
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
.L536:
	cmpwi 0,30,0
	bc 4,2,.L539
	lwz 31,g_edicts@l(21)
	b .L540
.L587:
	mr 30,31
	b .L552
.L539:
	addi 31,30,976
.L540:
	la 11,globals@l(15)
	lwz 9,g_edicts@l(21)
	lwz 0,72(11)
	mulli 0,0,976
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L553
	mr 24,11
	addi 28,31,188
	addi 30,31,200
	addi 29,31,4
.L543:
	lwz 0,-112(30)
	cmpwi 0,0,0
	bc 12,2,.L545
	li 0,3
	lis 9,.LC145@ha
	mtctr 0
	la 9,.LC145@l(9)
	mr 8,29
	lfd 10,0(9)
	mr 10,28
	mr 11,30
	li 9,0
.L589:
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
	bdnz .L589
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,30
	bc 4,1,.L587
.L545:
	lwz 9,72(24)
	addi 31,31,976
	addi 28,28,976
	lwz 0,g_edicts@l(21)
	addi 30,30,976
	addi 29,29,976
	mulli 9,9,976
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L543
.L553:
	li 30,0
.L552:
	cmpwi 0,30,0
	bc 12,2,.L537
	li 31,0
	b .L554
.L556:
	addi 31,31,1
.L554:
	slwi 28,31,3
	lwzx 4,17,28
	mr 29,28
	cmpwi 0,4,0
	bc 12,2,.L536
	lwz 3,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L556
	lwzx 0,17,29
	cmpwi 0,0,0
	bc 12,2,.L536
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 7,22,0
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,9,0
	bc 12,2,.L561
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
	b .L536
.L561:
	cmpwi 4,3,0
	addic 0,22,-1
	subfe 9,0,22
	mfcr 0
	rlwinm 0,0,19,1
	and. 11,9,0
	bc 4,2,.L536
	bc 12,30,.L563
	lwzx 0,20,29
	cmpw 0,23,0
	bc 12,0,.L536
.L563:
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
	bc 12,0,.L565
	bc 12,18,.L536
	lwzx 0,20,28
	cmpw 0,0,23
	bc 4,0,.L536
.L565:
	mr 26,30
	fmr 31,1
	mr 4,27
	mr 3,26
	mr 23,31
	bl loc_CanSee
	mr 22,3
	b .L536
.L537:
	cmpwi 0,26,0
	bc 4,2,.L566
	b .L590
.L588:
	li 16,1
	b .L568
.L566:
	li 30,0
	lis 31,.LC11@ha
	lis 29,.LC12@ha
	b .L567
.L569:
	cmpw 0,30,26
	bc 12,2,.L567
	la 5,.LC11@l(31)
	li 3,0
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L568
	la 5,.LC12@l(29)
	li 3,0
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L568
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
	bc 12,0,.L588
	bc 4,1,.L568
	li 16,2
	b .L568
.L567:
	lwz 5,280(26)
	mr 3,30
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L569
.L568:
	lwz 3,280(26)
	bl FindItemByClassname
	mr. 31,3
	bc 4,2,.L576
.L590:
	lis 9,.LC136@ha
	la 11,.LC136@l(9)
	lwz 0,.LC136@l(9)
	lwz 10,4(11)
	stw 0,0(25)
	stw 10,4(25)
	b .L535
.L576:
	lwz 0,612(27)
	cmpwi 0,0,0
	bc 12,2,.L577
	lis 11,.LC137@ha
	lwz 10,.LC137@l(11)
	la 9,.LC137@l(11)
	lhz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,0(25)
	stw 0,4(25)
	stw 11,8(25)
	sth 8,12(25)
	b .L578
.L577:
	stb 0,0(25)
.L578:
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
	bc 4,1,.L579
	fmr 0,10
	fabs 0,0
	fcmpu 0,12,0
	bc 4,1,.L579
	lis 9,.LC146@ha
	la 9,.LC146@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L580
	lis 4,.LC138@ha
	mr 3,25
	la 4,.LC138@l(4)
	bl strcat
	b .L582
.L580:
	lis 4,.LC139@ha
	mr 3,25
	la 4,.LC139@l(4)
	bl strcat
	b .L582
.L579:
	lis 4,.LC140@ha
	mr 3,25
	la 4,.LC140@l(4)
	bl strcat
.L582:
	cmpwi 0,16,1
	bc 4,2,.L583
	lis 4,.LC141@ha
	mr 3,25
	la 4,.LC141@l(4)
	bl strcat
	b .L584
.L583:
	cmpwi 0,16,2
	bc 4,2,.L585
	lis 4,.LC142@ha
	mr 3,25
	la 4,.LC142@l(4)
	bl strcat
	b .L584
.L585:
	lis 4,.LC143@ha
	mr 3,25
	la 4,.LC143@l(4)
	bl strcat
.L584:
	lwz 4,40(31)
	mr 3,25
	bl strcat
.L535:
	lwz 0,132(1)
	lwz 12,40(1)
	mtlr 0
	lmw 15,44(1)
	lfd 30,112(1)
	lfd 31,120(1)
	mtcrf 8,12
	la 1,128(1)
	blr
.Lfe18:
	.size	 CTFSay_Team_Location,.Lfe18-CTFSay_Team_Location
	.section	".rodata"
	.align 2
.LC147:
	.string	"cells"
	.align 2
.LC148:
	.string	"%s with %i cells "
	.align 2
.LC149:
	.string	"Power Screen"
	.align 2
.LC150:
	.string	"Power Shield"
	.align 2
.LC151:
	.string	"and "
	.align 2
.LC152:
	.string	"%i units of %s"
	.align 2
.LC153:
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
	bc 12,2,.L592
	lis 3,.LC147@ha
	lwz 29,84(30)
	la 3,.LC147@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,744
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 29,29,3
	cmpwi 0,29,0
	bc 12,2,.L592
	mr 3,31
	bl strlen
	cmpwi 0,28,1
	add 3,31,3
	bc 4,2,.L594
	lis 9,.LC149@ha
	la 5,.LC149@l(9)
	b .L595
.L594:
	lis 9,.LC150@ha
	la 5,.LC150@l(9)
.L595:
	lis 4,.LC148@ha
	mr 6,29
	la 4,.LC148@l(4)
	crxor 6,6,6
	bl sprintf
.L592:
	mr 3,30
	bl ArmorIndex
	mr. 29,3
	bc 12,2,.L596
	mr 3,29
	bl GetItemByIndex
	mr. 28,3
	bc 12,2,.L596
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L598
	lis 4,.LC151@ha
	mr 3,31
	la 4,.LC151@l(4)
	bl strcat
.L598:
	mr 3,31
	bl strlen
	lwz 9,84(30)
	slwi 0,29,2
	lis 4,.LC152@ha
	lwz 6,40(28)
	la 4,.LC152@l(4)
	add 3,31,3
	addi 9,9,744
	lwzx 5,9,0
	crxor 6,6,6
	bl sprintf
.L596:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L599
	lis 9,.LC153@ha
	lwz 10,.LC153@l(9)
	la 11,.LC153@l(9)
	lbz 0,8(11)
	lwz 9,4(11)
	stb 0,8(31)
	stw 10,0(31)
	stw 9,4(31)
.L599:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 CTFSay_Team_Armor,.Lfe19-CTFSay_Team_Armor
	.section	".rodata"
	.align 2
.LC154:
	.string	"dead"
	.align 2
.LC155:
	.string	"%i health"
	.align 2
.LC156:
	.string	"the %s"
	.align 2
.LC157:
	.string	"no powerup"
	.align 2
.LC158:
	.string	"none"
	.align 2
.LC159:
	.string	", "
	.align 2
.LC160:
	.string	" and "
	.align 2
.LC161:
	.string	"no one"
	.align 2
.LC162:
	.long 0x3f800000
	.align 3
.LC163:
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
	lis 9,.LC162@ha
	stb 27,1032(1)
	li 24,1
	la 9,.LC162@l(9)
	stb 27,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L614
	lis 11,.LC163@ha
	lis 20,g_edicts@ha
	la 11,.LC163@l(11)
	lis 21,.LC159@ha
	lfd 31,0(11)
	lis 22,0x4330
	li 25,976
.L616:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,26
	subfic 11,0,0
	adde 0,11,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L615
	mr 3,30
	mr 4,26
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L615
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L619
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L620
	cmpwi 0,27,0
	bc 12,2,.L621
	addi 3,1,8
	la 4,.LC159@l(21)
	bl strcat
.L621:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L620:
	addi 27,27,1
.L619:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
.L615:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	addi 25,25,976
	stw 0,2076(1)
	stw 22,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L616
.L614:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L623
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L624
	cmpwi 0,27,0
	bc 12,2,.L625
	lis 4,.LC160@ha
	addi 3,1,8
	la 4,.LC160@l(4)
	bl strcat
.L625:
	mr 4,31
	addi 3,1,8
	bl strcat
.L624:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L626
.L623:
	lis 9,.LC161@ha
	lwz 10,.LC161@l(9)
	la 11,.LC161@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L626:
	lwz 0,2148(1)
	mtlr 0
	lmw 19,2084(1)
	lfd 31,2136(1)
	la 1,2144(1)
	blr
.Lfe20:
	.size	 CTFSay_Team_Sight,.Lfe20-CTFSay_Team_Sight
	.section	".rodata"
	.align 2
.LC164:
	.string	"(%s): %s\n"
	.align 2
.LC165:
	.long 0x0
	.align 3
.LC166:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFSay_Team
	.type	 CTFSay_Team,@function
CTFSay_Team:
	stwu 1,-2128(1)
	mflr 0
	stfd 31,2120(1)
	stmw 23,2084(1)
	stw 0,2132(1)
	li 31,0
	mr 30,4
	stb 31,8(1)
	mr 27,3
	lbz 0,0(30)
	cmpwi 0,0,34
	bc 4,2,.L628
	mr 3,30
	bl strlen
	add 3,3,30
	stb 31,-1(3)
	addi 30,30,1
.L628:
	lbz 9,0(30)
	addi 31,1,8
	lis 23,maxclients@ha
	mr 24,31
	cmpwi 0,9,0
	bc 12,2,.L630
.L632:
	cmpwi 0,9,37
	bc 4,2,.L634
	lbzu 9,1(30)
	addi 9,9,-65
	cmplwi 0,9,54
	bc 12,1,.L660
	lis 11,.L661@ha
	slwi 10,9,2
	la 11,.L661@l(11)
	lis 9,.L661@ha
	lwzx 0,10,11
	la 9,.L661@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L661:
	.long .L639-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L641-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L637-.L661
	.long .L660-.L661
	.long .L659-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L646-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L654-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L639-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L641-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L637-.L661
	.long .L660-.L661
	.long .L659-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L646-.L661
	.long .L660-.L661
	.long .L660-.L661
	.long .L654-.L661
.L637:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Location
	b .L672
.L639:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Armor
	b .L672
.L641:
	lwz 5,480(27)
	cmpwi 0,5,0
	bc 12,1,.L642
	lis 9,.LC154@ha
	la 11,.LC154@l(9)
	lwz 0,.LC154@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
	b .L644
.L642:
	lis 4,.LC155@ha
	addi 3,1,1032
	la 4,.LC155@l(4)
	crxor 6,6,6
	bl sprintf
.L644:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L673
.L671:
	lwz 5,40(3)
	lis 4,.LC156@ha
	addi 3,1,1032
	la 4,.LC156@l(4)
	crxor 6,6,6
	bl sprintf
	b .L651
.L646:
	lis 9,tnames@ha
	addi 30,30,1
	la 3,tnames@l(9)
	addi 25,1,1032
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L652
	lis 9,itemlist@ha
	lis 29,0x286b
	la 26,itemlist@l(9)
	mr 28,3
	ori 29,29,51739
.L649:
	lwz 3,0(28)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L650
	subf 0,26,3
	lwz 11,84(27)
	mullw 0,0,29
	addi 11,11,744
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L671
.L650:
	lwzu 0,4(28)
	cmpwi 0,0,0
	bc 4,2,.L649
.L652:
	lis 9,.LC157@ha
	la 11,.LC157@l(9)
	lwz 10,.LC157@l(9)
	lbz 8,10(11)
	lwz 0,4(11)
	lhz 9,8(11)
	stw 10,1032(1)
	stw 0,1036(1)
	sth 9,1040(1)
	stb 8,1042(1)
.L651:
	mr 3,31
	mr 4,25
	bl strcpy
	mr 3,25
	b .L674
.L654:
	lwz 9,84(27)
	lwz 9,1792(9)
	cmpwi 0,9,0
	bc 12,2,.L655
	lwz 4,40(9)
	addi 3,1,1032
	bl strcpy
	b .L657
.L655:
	lis 9,.LC158@ha
	la 11,.LC158@l(9)
	lwz 0,.LC158@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
.L657:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L673
.L659:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Sight
.L672:
	mr 3,31
	mr 4,29
.L673:
	bl strcpy
	mr 3,29
.L674:
	bl strlen
	add 31,31,3
	b .L631
.L660:
	lbz 0,0(30)
	addi 30,30,1
	stb 0,0(31)
	b .L675
.L634:
	stb 9,0(31)
	addi 30,30,1
.L675:
	addi 31,31,1
.L631:
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 12,2,.L630
	subf 0,24,31
	cmplwi 0,0,1022
	bc 4,1,.L632
.L630:
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	li 30,0
	lis 9,.LC165@ha
	stb 0,0(31)
	la 9,.LC165@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,13,0
	bc 4,0,.L665
	lis 9,gi@ha
	lis 25,g_edicts@ha
	la 26,gi@l(9)
	lis 28,.LC164@ha
	lis 9,.LC166@ha
	lis 29,0x4330
	la 9,.LC166@l(9)
	li 31,976
	lfd 31,0(9)
.L667:
	lwz 0,g_edicts@l(25)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L666
	lwz 9,84(3)
	lwz 6,84(27)
	lwz 11,1840(9)
	lwz 0,1840(6)
	cmpw 0,11,0
	bc 4,2,.L666
	lwz 9,8(26)
	addi 6,6,700
	li 4,3
	la 5,.LC164@l(28)
	addi 7,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L666:
	addi 30,30,1
	lwz 11,maxclients@l(23)
	xoris 0,30,0x8000
	addi 31,31,976
	stw 0,2076(1)
	stw 29,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L667
.L665:
	lwz 0,2132(1)
	mtlr 0
	lmw 23,2084(1)
	lfd 31,2120(1)
	la 1,2128(1)
	blr
.Lfe21:
	.size	 CTFSay_Team,.Lfe21-CTFSay_Team
	.section	".rodata"
	.align 2
.LC168:
	.string	"models/ctf/banner/tris.md2"
	.align 2
.LC170:
	.string	"models/ctf/banner/small.md2"
	.globl creditsmenu
	.section	".data"
	.align 2
	.type	 creditsmenu,@object
creditsmenu:
	.long .LC172
	.long 1
	.long 0
	.long 0
	.long .LC173
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC174
	.long 1
	.long 0
	.long 0
	.long .LC175
	.long 1
	.long 0
	.long 0
	.long .LC176
	.long 1
	.long 0
	.long 0
	.long .LC177
	.long 1
	.long 0
	.long 0
	.long .LC178
	.long 1
	.long 0
	.long 0
	.long .LC175
	.long 1
	.long 0
	.long 0
	.long .LC179
	.long 1
	.long 0
	.long 0
	.long .LC180
	.long 1
	.long 0
	.long 0
	.long .LC181
	.long 1
	.long 0
	.long 0
	.long .LC182
	.long 1
	.long 0
	.long 0
	.long .LC183
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
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC186
	.long 0
	.long 0
	.long CTFReturnToMain
	.section	".rodata"
	.align 2
.LC186:
	.string	"Return to Main Menu"
	.align 2
.LC185:
	.string	"Brian 'Whaleboy' Cozzens"
	.align 2
.LC184:
	.string	"*Original CTF Art Design"
	.align 2
.LC183:
	.string	"Tom 'Bjorn' Klok"
	.align 2
.LC182:
	.string	"*Sound"
	.align 2
.LC181:
	.string	"Kevin Cloud"
	.align 2
.LC180:
	.string	"Adrian Carmack Paul Steed"
	.align 2
.LC179:
	.string	"*Art"
	.align 2
.LC178:
	.string	"Tim Willits"
	.align 2
.LC177:
	.string	"Christian Antkow"
	.align 2
.LC176:
	.string	"*Level Design"
	.align 2
.LC175:
	.string	"Dave 'Zoid' Kirsch"
	.align 2
.LC174:
	.string	"*Programming"
	.align 2
.LC173:
	.string	"*ThreeWave Capture the Flag"
	.align 2
.LC172:
	.string	"*Quake II"
	.size	 creditsmenu,288
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
	.long .LC172
	.long 1
	.long 0
	.long 0
	.long .LC173
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
	.long .LC187
	.long 0
	.long 0
	.long CTFJoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC188
	.long 0
	.long 0
	.long CTFJoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC189
	.long 0
	.long 0
	.long CTFChaseCam
	.long .LC190
	.long 0
	.long 0
	.long CTFCredits
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC191
	.long 0
	.long 0
	.long 0
	.long .LC192
	.long 0
	.long 0
	.long 0
	.long .LC193
	.long 0
	.long 0
	.long 0
	.long .LC194
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC195
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC195:
	.string	"v1.02"
	.align 2
.LC194:
	.string	"(TAB to Return)"
	.align 2
.LC193:
	.string	"ESC to Exit Menu"
	.align 2
.LC192:
	.string	"ENTER to select"
	.align 2
.LC191:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC190:
	.string	"Credits"
	.align 2
.LC189:
	.string	"Chase Camera"
	.align 2
.LC188:
	.string	"Join Blue Team"
	.align 2
.LC187:
	.string	"Join Red Team"
	.size	 joinmenu,272
	.globl tdmjoinmenu
	.section	".data"
	.align 2
	.type	 tdmjoinmenu,@object
tdmjoinmenu:
	.long .LC172
	.long 1
	.long 0
	.long 0
	.long .LC196
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
	.long .LC187
	.long 0
	.long 0
	.long TDMJoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC188
	.long 0
	.long 0
	.long TDMJoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC197
	.long 0
	.long 0
	.long TDMJoinTeam3
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC198
	.long 0
	.long 0
	.long TDMJoinTeam4
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC191
	.long 0
	.long 0
	.long 0
	.long .LC192
	.long 0
	.long 0
	.long 0
	.long .LC193
	.long 0
	.long 0
	.long 0
	.long .LC194
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC199
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC199:
	.string	"v.1.0"
	.align 2
.LC198:
	.string	"Join White Team"
	.align 2
.LC197:
	.string	"Join Green Team"
	.align 2
.LC196:
	.string	"*FireTeam Team Deathmatch"
	.size	 tdmjoinmenu,288
	.globl classmenu
	.section	".data"
	.align 2
	.type	 classmenu,@object
classmenu:
	.long .LC172
	.long 1
	.long 0
	.long 0
	.long .LC200
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
	.long .LC201
	.long 0
	.long 0
	.long Infantry
	.long .LC202
	.long 0
	.long 0
	.long Recon
	.long .LC203
	.long 0
	.long 0
	.long Light_Assault
	.long .LC204
	.long 0
	.long 0
	.long Heavy_Defense
	.long .LC205
	.long 0
	.long 0
	.long Seal
	.long .LC206
	.long 0
	.long 0
	.long Engineer
	.long .LC207
	.long 0
	.long 0
	.long Sniper
	.long .LC208
	.long 0
	.long 0
	.long Demolitions
	.long .LC209
	.long 0
	.long 0
	.long Medic
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC191
	.long 0
	.long 0
	.long 0
	.long .LC192
	.long 0
	.long 0
	.long 0
	.long .LC193
	.long 0
	.long 0
	.long 0
	.long .LC194
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC199
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC209:
	.string	"Field Medic"
	.align 2
.LC208:
	.string	"Demolitions"
	.align 2
.LC207:
	.string	"Sniper"
	.align 2
.LC206:
	.string	"Combat Engineer"
	.align 2
.LC205:
	.string	"Seal"
	.align 2
.LC204:
	.string	"Heavy Defense"
	.align 2
.LC203:
	.string	"Light Assault"
	.align 2
.LC202:
	.string	"Recon"
	.align 2
.LC201:
	.string	"Infantryman"
	.align 2
.LC200:
	.string	"*FireTeam - Classes"
	.size	 classmenu,320
	.lcomm	levelname.195,32,4
	.lcomm	team1players.196,32,4
	.lcomm	team2players.197,32,4
	.align 2
.LC210:
	.string	"Leave Chase Camera"
	.align 2
.LC211:
	.string	"  (%d players)"
	.align 2
.LC212:
	.long 0x0
	.align 3
.LC213:
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
	lis 11,.LC187@ha
	la 29,joinmenu@l(9)
	lis 10,CTFJoinTeam1@ha
	lis 9,.LC188@ha
	lis 8,CTFJoinTeam2@ha
	lis 30,ctf_forcejoin@ha
	la 11,.LC187@l(11)
	lwz 7,ctf_forcejoin@l(30)
	la 10,CTFJoinTeam1@l(10)
	la 9,.LC188@l(9)
	la 8,CTFJoinTeam2@l(8)
	stw 11,64(29)
	mr 31,3
	stw 10,76(29)
	stw 9,96(29)
	stw 8,108(29)
	lwz 3,4(7)
	cmpwi 0,3,0
	bc 12,2,.L770
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L770
	lis 4,.LC95@ha
	la 4,.LC95@l(4)
	bl strcmp
	mr. 3,3
	bc 4,2,.L771
	stw 3,108(29)
	stw 3,96(29)
	b .L770
.L771:
	lwz 9,ctf_forcejoin@l(30)
	lis 4,.LC96@ha
	la 4,.LC96@l(4)
	lwz 3,4(9)
	bl strcmp
	mr. 3,3
	bc 4,2,.L770
	stw 3,76(29)
	stw 3,64(29)
.L770:
	lwz 9,84(31)
	lwz 0,2236(9)
	cmpwi 0,0,0
	bc 12,2,.L774
	lis 9,.LC210@ha
	lis 11,joinmenu+128@ha
	la 9,.LC210@l(9)
	b .L797
.L774:
	lis 9,.LC189@ha
	lis 11,joinmenu+128@ha
	la 9,.LC189@l(9)
.L797:
	stw 9,joinmenu+128@l(11)
	lis 9,g_edicts@ha
	lis 11,levelname.195@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.195@l(11)
	stb 0,levelname.195@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L776
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L777
.L776:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L777:
	lis 9,maxclients@ha
	lis 11,levelname.195+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC212@ha
	la 4,.LC212@l(4)
	stb 0,levelname.195+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L779
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC213@ha
	li 8,0
	la 9,.LC213@l(9)
	addi 10,10,1064
	lfd 13,0(9)
.L781:
	lwz 0,0(10)
	addi 10,10,976
	cmpwi 0,0,0
	bc 12,2,.L780
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,1840(9)
	cmpwi 0,11,1
	bc 4,2,.L783
	addi 30,30,1
	b .L780
.L783:
	xori 11,11,2
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L780:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,2384
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L781
.L779:
	lis 29,.LC211@ha
	lis 3,team1players.196@ha
	la 4,.LC211@l(29)
	mr 5,30
	la 3,team1players.196@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.197@ha
	la 4,.LC211@l(29)
	la 3,team2players.197@l(3)
	mr 5,31
	crxor 6,6,6
	bl sprintf
	lis 11,joinmenu@ha
	lis 9,levelname.195@ha
	la 11,joinmenu@l(11)
	la 9,levelname.195@l(9)
	lwz 0,64(11)
	stw 9,32(11)
	cmpwi 0,0,0
	bc 12,2,.L787
	lis 9,team1players.196@ha
	la 9,team1players.196@l(9)
	stw 9,80(11)
	b .L788
.L787:
	stw 0,80(11)
.L788:
	lis 9,joinmenu@ha
	la 11,joinmenu@l(9)
	lwz 0,96(11)
	cmpwi 0,0,0
	bc 12,2,.L789
	lis 9,team2players.197@ha
	la 9,team2players.197@l(9)
	stw 9,112(11)
	b .L790
.L789:
	stw 0,112(11)
.L790:
	cmpw 0,30,31
	bc 12,1,.L798
	cmpw 0,31,30
	bc 4,1,.L792
.L798:
	li 3,1
	b .L796
.L792:
	bl rand
	andi. 0,3,1
	mfcr 3
	rlwinm 3,3,3,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
.L796:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 CTFUpdateJoinMenu,.Lfe22-CTFUpdateJoinMenu
	.section	".rodata"
	.align 2
.LC214:
	.string	"Capturelimit hit.\n"
	.align 2
.LC215:
	.string	"Couldn't find destination\n"
	.align 2
.LC216:
	.long 0x47800000
	.align 2
.LC217:
	.long 0x43b40000
	.align 2
.LC218:
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
	bc 12,2,.L818
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L820
	lis 9,gi+4@ha
	lis 3,.LC215@ha
	lwz 0,gi+4@l(9)
	la 3,.LC215@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L818
.L820:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	addi 28,31,376
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC216@ha
	lis 11,.LC217@ha
	la 9,.LC216@l(9)
	la 11,.LC217@l(11)
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
.L827:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,1868
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
	bdnz .L827
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
	stfs 0,2072(9)
	lfs 0,20(30)
	lwz 11,84(31)
	stfs 0,2076(11)
	lfs 13,24(30)
	lwz 9,84(31)
	stfs 13,2080(9)
	lwz 3,84(31)
	addi 3,3,2072
	bl AngleVectors
	lis 9,.LC218@ha
	addi 3,1,8
	la 9,.LC218@l(9)
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
.L818:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 old_teleporter_touch,.Lfe23-old_teleporter_touch
	.section	".rodata"
	.align 2
.LC219:
	.string	"teleporter without a target.\n"
	.align 2
.LC220:
	.string	"world/hum1.wav"
	.align 2
.LC221:
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
	bc 4,2,.L829
	lis 9,gi+4@ha
	lis 3,.LC219@ha
	lwz 0,gi+4@l(9)
	la 3,.LC219@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L828
.L829:
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
	lis 9,.LC221@ha
	mtctr 0
	la 9,.LC221@l(9)
	mr 30,3
	lfs 12,0(9)
	addi 8,31,200
	addi 10,31,188
	stw 30,540(31)
	addi 11,30,4
	li 9,0
.L835:
	lfsx 13,9,10
	lfsx 0,9,8
	addi 9,9,4
	fsubs 0,0,13
	fmadds 0,0,12,13
	stfs 0,0(11)
	addi 11,11,4
	bdnz .L835
	lis 29,gi@ha
	lis 3,.LC220@ha
	la 29,gi@l(29)
	la 3,.LC220@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(30)
	lwz 0,72(29)
	mr 3,30
	mtlr 0
	blrl
.L828:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 SP_trigger_teleport,.Lfe24-SP_trigger_teleport
	.comm	lights,4,4
	.comm	saved_client,780,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_blaster,4,4
	.comm	item_shotgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_supershotgun,4,4
	.comm	item_chaingun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_railgun,4,4
	.comm	item_bfg,4,4
	.comm	item_jacketarmor,4,4
	.comm	item_combatarmor,4,4
	.comm	item_bodyarmor,4,4
	.comm	item_armorshard,4,4
	.comm	item_powerscreen,4,4
	.comm	item_powershield,4,4
	.comm	item_adrenaline,4,4
	.comm	item_health,4,4
	.comm	item_stimpak,4,4
	.comm	item_health_large,4,4
	.comm	item_health_mega,4,4
	.comm	item_quad,4,4
	.comm	item_invulnerability,4,4
	.comm	item_silencer,4,4
	.comm	item_breather,4,4
	.comm	item_enviro,4,4
	.comm	item_pack,4,4
	.comm	item_bandolier,4,4
	.comm	item_ancient_head,4,4
	.comm	key_data_cd,4,4
	.comm	key_power_cube,4,4
	.comm	key_pyramid,4,4
	.comm	key_data_spinner,4,4
	.comm	key_pass,4,4
	.comm	key_blue_key,4,4
	.comm	key_red_key,4,4
	.comm	key_commander_head,4,4
	.comm	key_airstrike_target,4,4
	.comm	ctf,4,4
	.align 2
	.globl CTFInit
	.type	 CTFInit,@function
CTFInit:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	lis 4,.LC8@ha
	lwz 9,144(29)
	la 4,.LC8@l(4)
	li 5,16
	la 3,.LC7@l(3)
	lis 31,flag1_item@ha
	mtlr 9
	blrl
	lwz 0,144(29)
	lis 9,ctf@ha
	lis 11,.LC9@ha
	stw 3,ctf@l(9)
	lis 4,.LC10@ha
	li 5,0
	mtlr 0
	la 3,.LC9@l(11)
	la 4,.LC10@l(4)
	blrl
	lwz 0,flag1_item@l(31)
	lis 9,ctf_forcejoin@ha
	stw 3,ctf_forcejoin@l(9)
	cmpwi 0,0,0
	bc 4,2,.L36
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(31)
.L36:
	lis 29,flag2_item@ha
	lwz 0,flag2_item@l(29)
	cmpwi 0,0,0
	bc 4,2,.L37
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	bl FindItemByClassname
	stw 3,flag2_item@l(29)
.L37:
	lis 3,ctfgame@ha
	li 4,0
	la 3,ctfgame@l(3)
	li 5,24
	crxor 6,6,6
	bl memset
	lis 9,techspawn@ha
	li 0,0
	stw 0,techspawn@l(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 CTFInit,.Lfe25-CTFInit
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
	.globl CTFTeamName
	.type	 CTFTeamName,@function
CTFTeamName:
	cmpwi 0,3,1
	bc 12,2,.L40
	cmpwi 0,3,2
	bc 12,2,.L41
	b .L39
.L40:
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	blr
.L41:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	blr
.L39:
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	blr
.Lfe28:
	.size	 CTFTeamName,.Lfe28-CTFTeamName
	.align 2
	.globl CTFOtherTeamName
	.type	 CTFOtherTeamName,@function
CTFOtherTeamName:
	cmpwi 0,3,1
	bc 12,2,.L55
	cmpwi 0,3,2
	bc 12,2,.L56
	b .L54
.L55:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	blr
.L56:
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	blr
.L54:
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	blr
.Lfe29:
	.size	 CTFOtherTeamName,.Lfe29-CTFOtherTeamName
	.align 2
	.globl CTFDrop_Flag
	.type	 CTFDrop_Flag,@function
CTFDrop_Flag:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl rand
	andi. 0,3,1
	bc 12,2,.L351
	lis 9,gi+8@ha
	lis 5,.LC61@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC61@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L352
.L351:
	lis 9,gi+8@ha
	lis 5,.LC62@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC62@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L352:
	li 3,0
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe30:
	.size	 CTFDrop_Flag,.Lfe30-CTFDrop_Flag
	.align 2
	.globl CTFID_f
	.type	 CTFID_f,@function
CTFID_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1864(9)
	cmpwi 0,0,0
	bc 12,2,.L379
	lis 9,gi+8@ha
	lis 5,.LC74@ha
	lwz 0,gi+8@l(9)
	la 5,.LC74@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	b .L839
.L379:
	lis 9,gi+8@ha
	lis 5,.LC75@ha
	lwz 0,gi+8@l(9)
	la 5,.LC75@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
.L839:
	stw 0,1864(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe31:
	.size	 CTFID_f,.Lfe31-CTFID_f
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,3,1
	bc 12,2,.L204
	cmpwi 0,3,2
	bc 12,2,.L205
	b .L202
.L204:
	lis 9,.LC11@ha
	la 29,.LC11@l(9)
	b .L203
.L205:
	lis 9,.LC12@ha
	la 29,.LC12@l(9)
.L203:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L208
.L210:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L211
	mr 3,31
	bl G_FreeEdict
	b .L208
.L211:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L208:
	mr 3,31
	li 4,280
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L210
.L202:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 CTFResetFlag,.Lfe32-CTFResetFlag
	.align 2
	.globl CTFCheckHurtCarrier
	.type	 CTFCheckHurtCarrier,@function
CTFCheckHurtCarrier:
	lwz 9,84(3)
	cmpwi 0,9,0
	bclr 12,2
	lwz 0,84(4)
	cmpwi 0,0,0
	mr 8,0
	bclr 12,2
	lwz 0,1840(9)
	cmpwi 0,0,1
	bc 4,2,.L199
	lis 9,flag2_item@ha
	lwz 10,flag2_item@l(9)
	b .L200
.L199:
	lis 9,flag1_item@ha
	lwz 10,flag1_item@l(9)
.L200:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 3,84(3)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,3,744
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bclr 12,2
	lwz 9,1840(3)
	lwz 0,1840(8)
	cmpw 0,9,0
	bclr 12,2
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,1848(8)
	blr
.Lfe33:
	.size	 CTFCheckHurtCarrier,.Lfe33-CTFCheckHurtCarrier
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
	lwz 0,2236(9)
	cmpwi 0,0,0
	bc 12,2,.L800
	li 5,8
	b .L801
.L800:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L801:
	lis 4,joinmenu@ha
	mr 3,31
	la 4,joinmenu@l(4)
	li 6,17
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 CTFOpenJoinMenu,.Lfe34-CTFOpenJoinMenu
	.align 2
	.globl CTFStartClient
	.type	 CTFStartClient,@function
CTFStartClient:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 8,84(31)
	lwz 0,1840(8)
	cmpwi 0,0,0
	bc 4,2,.L809
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 10,11,0x2
	bc 4,2,.L809
	lwz 0,184(31)
	li 9,1
	lis 11,gi+72@ha
	stw 9,260(31)
	mr 3,31
	ori 0,0,1
	stw 10,248(31)
	stw 0,184(31)
	stw 10,1840(8)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	mr 3,31
	bl CTFUpdateJoinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,2236(9)
	cmpwi 0,0,0
	bc 12,2,.L810
	li 5,8
	b .L811
.L810:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L811:
	lis 4,joinmenu@ha
	mr 3,31
	la 4,joinmenu@l(4)
	li 6,17
	bl PMenu_Open
	li 3,1
	b .L840
.L809:
	li 3,0
.L840:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 CTFStartClient,.Lfe35-CTFStartClient
	.section	".rodata"
	.align 2
.LC222:
	.long 0x0
	.align 3
.LC223:
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
	lis 11,.LC222@ha
	lis 9,capturelimit@ha
	la 11,.LC222@l(11)
	lfs 0,0(11)
	lwz 11,capturelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L816
	lis 9,ctfgame@ha
	lwz 0,ctfgame@l(9)
	la 8,ctfgame@l(9)
	lis 10,0x4330
	lis 9,.LC223@ha
	xoris 0,0,0x8000
	la 9,.LC223@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L817
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
	bc 4,3,.L816
.L817:
	lis 9,gi@ha
	lis 4,.LC214@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC214@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L841
.L816:
	li 3,0
.L841:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 CTFCheckRules,.Lfe36-CTFCheckRules
	.section	".rodata"
	.align 3
.LC224:
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
	lis 3,.LC168@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC168@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L678
	li 0,1
	stw 0,60(31)
.L678:
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
	lis 11,.LC224@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC224@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 SP_misc_ctf_banner,.Lfe37-SP_misc_ctf_banner
	.section	".rodata"
	.align 3
.LC225:
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
	lis 3,.LC170@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC170@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L680
	li 0,1
	stw 0,60(31)
.L680:
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
	lis 11,.LC225@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC225@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 SP_misc_ctf_small_banner,.Lfe38-SP_misc_ctf_small_banner
	.section	".rodata"
	.align 2
.LC226:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	lis 9,.LC226@ha
	lfs 0,12(3)
	la 9,.LC226@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe39:
	.size	 SP_info_teleport_destination,.Lfe39-SP_info_teleport_destination
	.comm	ctfgame,24,4
	.comm	ctf_forcejoin,4,4
	.align 2
	.globl stuffcmd
	.type	 stuffcmd,@function
stuffcmd:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,11
	lwz 9,100(29)
	mr 28,4
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 stuffcmd,.Lfe40-stuffcmd
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
	.globl TDMTeamName
	.type	 TDMTeamName,@function
TDMTeamName:
	cmpwi 0,3,2
	bc 12,2,.L47
	bc 12,1,.L52
	cmpwi 0,3,1
	bc 12,2,.L46
	b .L45
.L52:
	cmpwi 0,3,3
	bc 12,2,.L48
	cmpwi 0,3,4
	bc 12,2,.L49
	b .L45
.L46:
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	blr
.L47:
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	blr
.L48:
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	blr
.L49:
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	blr
.L45:
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	blr
.Lfe41:
	.size	 TDMTeamName,.Lfe41-TDMTeamName
	.align 2
	.globl CTFOtherTeam
	.type	 CTFOtherTeam,@function
CTFOtherTeam:
	cmpwi 0,3,1
	bc 12,2,.L61
	cmpwi 0,3,2
	bc 12,2,.L62
	b .L60
.L61:
	li 3,2
	blr
.L62:
	li 3,1
	blr
.L60:
	li 3,-1
	blr
.Lfe42:
	.size	 CTFOtherTeam,.Lfe42-CTFOtherTeam
	.section	".rodata"
	.align 2
.LC227:
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
	bc 4,2,.L293
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC227@ha
	lfs 13,level+4@l(9)
	la 11,.LC227@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L292
.L293:
	bl Touch_Item
.L292:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 CTFDropFlagTouch,.Lfe43-CTFDropFlagTouch
	.section	".rodata"
	.align 3
.LC228:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 CTFFlagThink,@function
CTFFlagThink:
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 12,2,.L354
	lwz 9,56(3)
	addi 9,9,-172
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	addi 9,9,173
	stw 9,56(3)
.L354:
	lis 9,level+4@ha
	lis 11,.LC228@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC228@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe44:
	.size	 CTFFlagThink,.Lfe44-CTFFlagThink
	.section	".rodata"
	.align 3
.LC229:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 misc_ctf_banner_think,@function
misc_ctf_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC229@ha
	lfd 13,.LC229@l(11)
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
.Lfe45:
	.size	 misc_ctf_banner_think,.Lfe45-misc_ctf_banner_think
	.align 2
	.globl CTFJoinTeam
	.type	 CTFJoinTeam,@function
CTFJoinTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	mr 31,4
	bl PMenu_Close
	lwz 0,184(29)
	li 10,0
	lis 4,.LC99@ha
	lwz 11,84(29)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 31,1840(11)
	lwz 9,84(29)
	stw 10,1844(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl CTFAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 10,84(29)
	li 0,6
	li 11,32
	stw 0,80(29)
	lis 9,gi@ha
	li 8,14
	stb 11,16(10)
	cmpwi 0,31,1
	lwz 11,84(29)
	la 10,gi@l(9)
	stb 8,17(11)
	lwz 9,84(29)
	addi 5,9,700
	bc 12,2,.L682
	cmpwi 0,31,2
	bc 12,2,.L683
	b .L686
.L682:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L685
.L683:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L685
.L686:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L685:
	lwz 0,0(10)
	lis 4,.LC100@ha
	li 3,2
	la 4,.LC100@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 CTFJoinTeam,.Lfe46-CTFJoinTeam
	.align 2
	.globl TDMJoinTeam
	.type	 TDMJoinTeam,@function
TDMJoinTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	mr 31,4
	bl PMenu_Close
	lwz 0,184(29)
	lis 4,.LC99@ha
	lwz 9,84(29)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 31,1884(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl TDMAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 10,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	cmpwi 0,31,2
	lis 11,gi@ha
	stb 9,16(10)
	li 0,14
	la 11,gi@l(11)
	lwz 10,84(29)
	stb 0,17(10)
	lwz 9,84(29)
	addi 5,9,700
	bc 12,2,.L688
	bc 12,1,.L689
	cmpwi 0,31,1
	bc 12,2,.L690
	b .L695
.L689:
	cmpwi 0,31,3
	bc 12,2,.L692
	cmpwi 0,31,4
	bc 12,2,.L693
	b .L695
.L690:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L694
.L688:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L694
.L692:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
	b .L694
.L693:
	lis 9,.LC19@ha
	la 6,.LC19@l(9)
	b .L694
.L695:
	lis 9,.LC20@ha
	la 6,.LC20@l(9)
.L694:
	lwz 0,0(11)
	lis 4,.LC100@ha
	li 3,2
	la 4,.LC100@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe47:
	.size	 TDMJoinTeam,.Lfe47-TDMJoinTeam
	.align 2
	.globl CTFJoinTeam1
	.type	 CTFJoinTeam1,@function
CTFJoinTeam1:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,1
	bl PMenu_Close
	lwz 0,184(29)
	li 10,0
	lis 4,.LC99@ha
	lwz 11,84(29)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,1840(11)
	lwz 9,84(29)
	stw 10,1844(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl CTFAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 6,.LC13@ha
	lis 4,.LC100@ha
	lwz 9,84(29)
	la 4,.LC100@l(4)
	la 6,.LC13@l(6)
	li 3,2
	stb 10,17(9)
	lwz 5,84(29)
	lwz 0,gi@l(8)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 CTFJoinTeam1,.Lfe48-CTFJoinTeam1
	.align 2
	.globl CTFJoinTeam2
	.type	 CTFJoinTeam2,@function
CTFJoinTeam2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,2
	bl PMenu_Close
	lwz 0,184(29)
	li 10,0
	lis 4,.LC99@ha
	lwz 11,84(29)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,1840(11)
	lwz 9,84(29)
	stw 10,1844(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl CTFAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 6,.LC14@ha
	lis 4,.LC100@ha
	lwz 9,84(29)
	la 4,.LC100@l(4)
	la 6,.LC14@l(6)
	li 3,2
	stb 10,17(9)
	lwz 5,84(29)
	lwz 0,gi@l(8)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 CTFJoinTeam2,.Lfe49-CTFJoinTeam2
	.align 2
	.globl TDMJoinTeam1
	.type	 TDMJoinTeam1,@function
TDMJoinTeam1:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,1
	bl PMenu_Close
	lwz 0,184(29)
	lis 4,.LC99@ha
	lwz 9,84(29)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,1884(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl TDMAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 6,.LC16@ha
	lis 4,.LC100@ha
	lwz 9,84(29)
	la 4,.LC100@l(4)
	la 6,.LC16@l(6)
	li 3,2
	stb 10,17(9)
	lwz 5,84(29)
	lwz 0,gi@l(8)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 TDMJoinTeam1,.Lfe50-TDMJoinTeam1
	.align 2
	.globl TDMJoinTeam2
	.type	 TDMJoinTeam2,@function
TDMJoinTeam2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,2
	bl PMenu_Close
	lwz 0,184(29)
	lis 4,.LC99@ha
	lwz 9,84(29)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,1884(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl TDMAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 6,.LC17@ha
	lis 4,.LC100@ha
	lwz 9,84(29)
	la 4,.LC100@l(4)
	la 6,.LC17@l(6)
	li 3,2
	stb 10,17(9)
	lwz 5,84(29)
	lwz 0,gi@l(8)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe51:
	.size	 TDMJoinTeam2,.Lfe51-TDMJoinTeam2
	.align 2
	.globl TDMJoinTeam3
	.type	 TDMJoinTeam3,@function
TDMJoinTeam3:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,3
	bl PMenu_Close
	lwz 0,184(29)
	lis 4,.LC99@ha
	lwz 9,84(29)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,1884(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl TDMAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 6,.LC18@ha
	lis 4,.LC100@ha
	lwz 9,84(29)
	la 4,.LC100@l(4)
	la 6,.LC18@l(6)
	li 3,2
	stb 10,17(9)
	lwz 5,84(29)
	lwz 0,gi@l(8)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe52:
	.size	 TDMJoinTeam3,.Lfe52-TDMJoinTeam3
	.align 2
	.globl TDMJoinTeam4
	.type	 TDMJoinTeam4,@function
TDMJoinTeam4:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,4
	bl PMenu_Close
	lwz 0,184(29)
	lis 4,.LC99@ha
	lwz 9,84(29)
	la 4,.LC99@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,1884(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl TDMAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 6,.LC19@ha
	lis 4,.LC100@ha
	lwz 9,84(29)
	la 4,.LC100@l(4)
	la 6,.LC19@l(6)
	li 3,2
	stb 10,17(9)
	lwz 5,84(29)
	lwz 0,gi@l(8)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 TDMJoinTeam4,.Lfe53-TDMJoinTeam4
	.align 2
	.globl Infantry
	.type	 Infantry,@function
Infantry:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,1
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe54:
	.size	 Infantry,.Lfe54-Infantry
	.align 2
	.globl Recon
	.type	 Recon,@function
Recon:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,2
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe55:
	.size	 Recon,.Lfe55-Recon
	.align 2
	.globl Light_Assault
	.type	 Light_Assault,@function
Light_Assault:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,3
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe56:
	.size	 Light_Assault,.Lfe56-Light_Assault
	.align 2
	.globl Heavy_Defense
	.type	 Heavy_Defense,@function
Heavy_Defense:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,4
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe57:
	.size	 Heavy_Defense,.Lfe57-Heavy_Defense
	.align 2
	.globl Seal
	.type	 Seal,@function
Seal:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,5
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe58:
	.size	 Seal,.Lfe58-Seal
	.align 2
	.globl Engineer
	.type	 Engineer,@function
Engineer:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,6
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe59:
	.size	 Engineer,.Lfe59-Engineer
	.align 2
	.globl Sniper
	.type	 Sniper,@function
Sniper:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,7
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe60:
	.size	 Sniper,.Lfe60-Sniper
	.align 2
	.globl Demolitions
	.type	 Demolitions,@function
Demolitions:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,8
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe61:
	.size	 Demolitions,.Lfe61-Demolitions
	.align 2
	.globl Medic
	.type	 Medic,@function
Medic:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,9
	bl Class_Set
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe62:
	.size	 Medic,.Lfe62-Medic
	.section	".rodata"
	.align 3
.LC230:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFChaseCam
	.type	 CTFChaseCam,@function
CTFChaseCam:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,2236(9)
	cmpwi 0,0,0
	bc 12,2,.L760
	li 0,0
	stw 0,2236(9)
	bl PMenu_Close
	b .L759
.L760:
	li 8,1
	b .L761
.L763:
	addi 8,8,1
.L761:
	xoris 0,8,0x8000
	lis 9,0x4330
	stw 0,20(1)
	lis 11,.LC230@ha
	la 11,.LC230@l(11)
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
	bc 4,3,.L759
	lis 9,g_edicts@ha
	mulli 11,8,976
	lwz 0,g_edicts@l(9)
	add 11,0,11
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L763
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L763
	lwz 9,84(31)
	mr 3,31
	stw 11,2236(9)
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,2240(9)
.L759:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe63:
	.size	 CTFChaseCam,.Lfe63-CTFChaseCam
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
.Lfe64:
	.size	 CTFReturnToMain,.Lfe64-CTFReturnToMain
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
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe65:
	.size	 CTFCredits,.Lfe65-CTFCredits
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
	stw 0,1920(11)
	lwz 9,84(29)
	stw 10,1932(9)
	bl DeathmatchScoreboard
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 CTFShowScores,.Lfe66-CTFShowScores
	.align 2
	.globl TDMOpenJoinMenu
	.type	 TDMOpenJoinMenu,@function
TDMOpenJoinMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 4,tdmjoinmenu@ha
	li 5,5
	la 4,tdmjoinmenu@l(4)
	li 6,18
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe67:
	.size	 TDMOpenJoinMenu,.Lfe67-TDMOpenJoinMenu
	.align 2
	.globl OpenClassMenu
	.type	 OpenClassMenu,@function
OpenClassMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 4,classmenu@ha
	li 5,4
	la 4,classmenu@l(4)
	li 6,20
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe68:
	.size	 OpenClassMenu,.Lfe68-OpenClassMenu
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
