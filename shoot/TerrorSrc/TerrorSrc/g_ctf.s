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
	.ascii	"yb\t-24 if 2 \txv\t100 \tyb -26 \tanum \txv\t150 \tyb -30 \t"
	.ascii	"pic 2 endif yb\t-50 if 9 xv 246 num 2 10 xv 296 pic 9 endif "
	.ascii	"yb -102 if 17 xr -26 pic 17 endif xr -100 num 4 18 if 22 yb "
	.ascii	"-104 xr -28 pic 22 endif yb -75 if 19 xr -26 pic 19 endif xr"
	.ascii	" -100 num 4 20 if 23 yb -77 xr -28 pic 23 endif if 21 yt 26 "
	.ascii	"xr -24 pic 21 endif xl\t40 yt 2 num 2 27 if 16 xl 4 yt 2 pic"
	.ascii	" 16endif if 29 xl 4 yt 72 pic 29endif if 30 xl 4 yt 72 pic 3"
	.ascii	"0endif xl\t40 yt 40 nu"
	.string	"m 2 5 if 11 xl 4 yt 40 pic 11endif xl\t40 yb -24 hnum xl\t4 yb -30 pic 0 if 7 \txl\t40 \tyb\t-60 \tpic 7 \txl\t70 \tyb\t-45 \tstat_string 8 endif if 6 \txl\t4 \tyb -60 \tpic 6 endif if 31 \txl 4 \tyb -60 \tpic 31 endif if 4 xl 4 yt 72 pic 4endif if 28 yv 0 xv 0 pic 28 endif "
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
	.long .LC5
	.long .LC6
	.long .LC7
	.long .LC8
	.long .LC9
	.long .LC10
	.long .LC11
	.long .LC12
	.long .LC13
	.long .LC9
	.long .LC13
	.long .LC14
	.long .LC15
	.long .LC15
	.long .LC16
	.long .LC17
	.long .LC17
	.long .LC18
	.long .LC19
	.long .LC20
	.long .LC21
	.long .LC21
	.long 0
	.section	".rodata"
	.align 2
.LC21:
	.string	"ammo_msg90"
	.align 2
.LC20:
	.string	"weapon_msg90"
	.align 2
.LC19:
	.string	"ammo_m60"
	.align 2
.LC18:
	.string	"weapon_m60"
	.align 2
.LC17:
	.string	"ammo_mp5"
	.align 2
.LC16:
	.string	"weapon_mp5"
	.align 2
.LC15:
	.string	"ammo_beretta"
	.align 2
.LC14:
	.string	"weapon_beretta"
	.align 2
.LC13:
	.string	"ammo_casull"
	.align 2
.LC12:
	.string	"weapon_casull"
	.align 2
.LC11:
	.string	"weapon_c4"
	.align 2
.LC10:
	.string	"weapon_mine"
	.align 2
.LC9:
	.string	"ammo_glock"
	.align 2
.LC8:
	.string	"weapon_glock"
	.align 2
.LC7:
	.string	"item_medkit"
	.align 2
.LC6:
	.string	"item_scuba"
	.align 2
.LC5:
	.string	"item_light"
	.align 2
.LC4:
	.string	"item_ir"
	.align 2
.LC3:
	.string	"item_helmet"
	.align 2
.LC2:
	.string	"item_vest"
	.align 2
.LC1:
	.string	"item_detonator"
	.size	 tnames,108
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC23:
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
	lis 9,.LC22@ha
	lfs 7,200(3)
	la 9,.LC22@l(9)
	lfd 6,0(9)
	lis 6,0x4330
	addi 28,1,168
	fadds 8,9,12
	lis 9,gi@ha
	lis 27,vec3_origin@ha
	fadds 9,9,7
	la 26,gi@l(9)
	addi 31,1,72
	lis 9,.LC23@ha
	addi 29,1,156
	stfs 8,72(1)
	fsubs 12,8,12
	la 9,.LC23@l(9)
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
.LC24:
	.string	"ctf"
	.align 2
.LC25:
	.string	"0"
	.align 2
.LC26:
	.string	"ctf_forcejoin"
	.align 2
.LC27:
	.string	""
	.align 2
.LC28:
	.string	"item_flag_team1"
	.align 2
.LC29:
	.string	"item_flag_team2"
	.align 2
.LC30:
	.string	"Terrorists"
	.align 2
.LC31:
	.string	"Force"
	.align 2
.LC32:
	.string	"UKNOWN"
	.align 2
.LC33:
	.string	"%s"
	.align 2
.LC34:
	.string	"male/"
	.align 2
.LC35:
	.string	"%s\\%s%s"
	.align 2
.LC36:
	.string	"terror/"
	.align 2
.LC37:
	.string	"terror"
	.align 2
.LC38:
	.string	"force/"
	.align 2
.LC39:
	.string	"saspolice"
	.align 2
.LC40:
	.string	"%s\\%s"
	.section	".text"
	.align 2
	.globl CTFAssignSkin
	.type	 CTFAssignSkin,@function
CTFAssignSkin:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	lis 11,g_edicts@ha
	mr 29,3
	lwz 9,g_edicts@l(11)
	lis 0,0x4f72
	mr 31,4
	ori 0,0,49717
	lis 5,.LC33@ha
	subf 9,9,29
	addi 3,1,8
	mullw 9,9,0
	la 5,.LC33@l(5)
	li 4,64
	mr 6,31
	srawi 9,9,5
	addi 28,9,-1
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	li 4,47
	bl strrchr
	mr. 3,3
	bc 12,2,.L57
	li 0,0
	stb 0,1(3)
	b .L58
.L57:
	lis 9,.LC34@ha
	la 11,.LC34@l(9)
	lwz 0,.LC34@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L58:
	lwz 9,84(29)
	lwz 3,3532(9)
	mr 4,9
	cmpwi 0,3,1
	bc 12,2,.L60
	cmpwi 0,3,2
	bc 12,2,.L61
	b .L62
.L60:
	lis 29,gi@ha
	lis 3,.LC35@ha
	lis 5,.LC36@ha
	lis 6,.LC37@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC35@l(3)
	la 5,.LC36@l(5)
	la 6,.LC37@l(6)
	b .L64
.L61:
	lis 29,gi@ha
	lis 3,.LC35@ha
	lis 5,.LC38@ha
	lis 6,.LC39@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC35@l(3)
	la 5,.LC38@l(5)
	la 6,.LC39@l(6)
.L64:
	addi 28,28,1312
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	b .L59
.L62:
	lis 29,gi@ha
	lis 3,.LC40@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC40@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,28,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L59:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 CTFAssignSkin,.Lfe2-CTFAssignSkin
	.section	".rodata"
	.align 2
.LC41:
	.long 0x3f800000
	.align 3
.LC42:
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
	stw 7,3536(31)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andis. 0,9,2
	bc 4,2,.L66
	stw 8,3532(31)
	b .L65
.L66:
	lis 11,.LC41@ha
	lis 9,maxclients@ha
	la 11,.LC41@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L79
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	addi 11,11,928
	lfd 13,0(9)
.L70:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L69
	lwz 9,84(11)
	cmpw 0,9,31
	bc 12,2,.L69
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 12,2,.L74
	cmpwi 0,0,2
	bc 12,2,.L75
	b .L69
.L74:
	addi 7,7,1
	b .L69
.L75:
	addi 8,8,1
.L69:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,928
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L70
.L79:
	cmpw 0,8,7
	bc 12,0,.L83
	bl rand
	andi. 0,3,1
	li 0,1
	bc 4,2,.L85
.L83:
	li 0,2
.L85:
	stw 0,3532(31)
.L65:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 CTFAssignTeam,.Lfe3-CTFAssignTeam
	.section	".rodata"
	.align 2
.LC43:
	.string	"info_player_team1"
	.align 2
.LC44:
	.string	"info_player_team2"
	.align 2
.LC45:
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
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L87
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L111
	bl SelectFarthestDeathmatchSpawnPoint
	b .L110
.L87:
	li 0,1
	stw 0,3536(9)
	lwz 9,84(3)
	lwz 3,3532(9)
	cmpwi 0,3,1
	bc 12,2,.L91
	cmpwi 0,3,2
	bc 12,2,.L92
	b .L111
.L91:
	lis 9,.LC43@ha
	la 27,.LC43@l(9)
	b .L90
.L92:
	lis 9,.LC44@ha
	la 27,.LC44@l(9)
.L90:
	lis 9,.LC45@ha
	li 30,0
	lfs 31,.LC45@l(9)
	li 28,0
	li 29,0
	fmr 30,31
	b .L95
.L97:
	mr 3,30
	addi 31,31,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L98
	fmr 30,1
	mr 29,30
	b .L95
.L98:
	fcmpu 0,1,31
	bc 4,0,.L95
	fmr 31,1
	mr 28,30
.L95:
	mr 3,30
	li 4,280
	mr 5,27
	bl G_Find
	mr. 30,3
	bc 4,2,.L97
	cmpwi 0,31,0
	bc 4,2,.L102
.L111:
	bl SelectRandomDeathmatchSpawnPoint
	b .L110
.L102:
	cmpwi 0,31,2
	bc 12,1,.L103
	li 28,0
	li 29,0
	b .L104
.L103:
	addi 31,31,-2
.L104:
	bl rand
	li 30,0
	divw 0,3,31
	mullw 0,0,31
	subf 31,0,3
.L109:
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
	bc 4,2,.L109
.L110:
	lwz 0,68(1)
	mtlr 0
	lmw 27,28(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 SelectCTFSpawnPoint,.Lfe4-SelectCTFSpawnPoint
	.section	".rodata"
	.align 2
.LC46:
	.string	"BONUS: %d points for fragging enemy flag carrier.\n"
	.align 2
.LC47:
	.string	"%s defends %s's flag carrier against an agressive enemy\n"
	.align 2
.LC48:
	.string	"%s defends the %s base.\n"
	.align 2
.LC49:
	.string	"%s defends the %s hideout.\n"
	.align 2
.LC50:
	.string	"%s defends the Force`s illegal drugs.\n"
	.align 2
.LC51:
	.string	"%s defends the Terrorists confiscated drugs.\n"
	.align 2
.LC52:
	.string	"%s defends the %s's flag carrier.\n"
	.align 2
.LC53:
	.long 0x3f800000
	.align 3
.LC54:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC55:
	.long 0x0
	.align 2
.LC56:
	.long 0x41000000
	.align 2
.LC57:
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
	mr 28,5
	lwz 10,84(27)
	cmpwi 0,10,0
	bc 12,2,.L112
	lwz 0,84(28)
	xor 11,27,28
	subfic 8,11,0
	adde 11,8,11
	subfic 8,0,0
	adde 9,8,0
	mr 8,0
	or. 0,9,11
	bc 4,2,.L112
	lwz 0,3532(10)
	cmpwi 0,0,1
	bc 12,2,.L115
	cmpwi 0,0,2
	bc 12,2,.L116
	b .L119
.L115:
	li 31,2
	b .L118
.L116:
	li 31,1
	b .L118
.L119:
	li 31,-1
.L118:
	cmpwi 0,31,0
	bc 12,0,.L112
	lwz 9,84(27)
	lwz 0,3532(9)
	mr 7,9
	cmpwi 0,0,1
	bc 4,2,.L121
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 26,flag1_item@l(9)
	lwz 0,flag2_item@l(11)
	b .L122
.L121:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 26,flag2_item@l(9)
	lwz 0,flag1_item@l(11)
.L122:
	lis 9,itemlist@ha
	lis 10,0x286b
	la 6,itemlist@l(9)
	ori 10,10,51739
	subf 0,6,0
	addi 11,7,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L123
	lis 9,level+4@ha
	lis 10,gi+8@ha
	lfs 0,level+4@l(9)
	lis 5,.LC46@ha
	mr 3,28
	la 5,.LC46@l(5)
	li 4,1
	li 6,2
	stfs 0,3552(8)
	lwz 11,84(28)
	lwz 9,3528(11)
	addi 9,9,2
	stw 9,3528(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,maxclients@ha
	lis 8,.LC53@ha
	lwz 11,maxclients@l(9)
	la 8,.LC53@l(8)
	li 10,1
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L112
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 6,0
	lis 7,0x4330
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	addi 11,11,928
	lfd 12,0(9)
.L127:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L126
	lwz 9,84(11)
	lwz 0,3532(9)
	cmpw 0,0,31
	bc 4,2,.L126
	stw 6,3540(9)
.L126:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,928
	stw 0,44(1)
	stw 7,40(1)
	lfd 0,40(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L127
	b .L112
.L123:
	lis 11,.LC55@ha
	lfs 12,3540(7)
	la 11,.LC55@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 12,2,.L130
	lis 9,level+4@ha
	lis 11,.LC56@ha
	lfs 0,level+4@l(9)
	la 11,.LC56@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L130
	subf 0,6,26
	addi 11,8,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L130
	lwz 9,3528(8)
	lis 11,gi@ha
	la 10,gi@l(11)
	addi 9,9,2
	stw 9,3528(8)
	lwz 11,84(28)
	lwz 0,3532(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L131
	cmpwi 0,0,2
	bc 12,2,.L132
	b .L135
.L131:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L134
.L132:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L134
.L135:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
.L134:
	lwz 0,0(10)
	lis 4,.LC47@ha
	li 3,1
	la 4,.LC47@l(4)
	b .L191
.L130:
	lwz 0,3532(8)
	cmpwi 0,0,1
	bc 12,2,.L137
	cmpwi 0,0,2
	bc 12,2,.L138
	b .L112
.L137:
	lis 9,.LC28@ha
	la 30,.LC28@l(9)
	b .L136
.L138:
	lis 9,.LC29@ha
	la 30,.LC29@l(9)
.L136:
	li 31,0
.L144:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	mcrf 7,0
	bc 12,30,.L112
	lwz 0,284(31)
	andis. 8,0,1
	bc 4,2,.L144
	bc 12,30,.L112
	lis 9,maxclients@ha
	lis 10,.LC53@ha
	lfs 11,4(27)
	lwz 11,maxclients@l(9)
	la 10,.LC53@l(10)
	lfs 0,0(10)
	lfs 13,20(11)
	li 10,1
	lfs 10,4(31)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L147
	lis 11,g_edicts@ha
	lis 9,itemlist@ha
	fmr 12,13
	lis 0,0x286b
	la 9,itemlist@l(9)
	lwz 7,g_edicts@l(11)
	ori 0,0,51739
	subf 9,9,26
	lis 11,.LC54@ha
	mullw 9,9,0
	lis 6,0x4330
	la 11,.LC54@l(11)
	lfd 13,0(11)
	rlwinm 8,9,0,0,29
	li 11,928
.L149:
	add 29,7,11
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L150
	lwz 9,84(29)
	addi 9,9,740
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 4,2,.L147
.L150:
	addi 10,10,1
	xoris 0,10,0x8000
	li 29,0
	stw 0,44(1)
	addi 11,11,928
	stw 6,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L149
.L147:
	fsubs 10,11,10
	lfs 13,8(27)
	lis 8,.LC57@ha
	addi 3,1,8
	lfs 12,12(27)
	la 8,.LC57@l(8)
	lfs 11,4(28)
	stfs 10,8(1)
	lfs 0,8(31)
	lfs 10,8(28)
	lfs 9,12(28)
	fsubs 13,13,0
	lfs 31,0(8)
	stfs 13,12(1)
	lfs 0,12(31)
	fsubs 12,12,0
	stfs 12,16(1)
	lfs 0,4(31)
	fsubs 11,11,0
	stfs 11,24(1)
	lfs 0,8(31)
	fsubs 10,10,0
	stfs 10,28(1)
	lfs 0,12(31)
	fsubs 9,9,0
	stfs 9,32(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L153
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L153
	mr 3,31
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L153
	mr 3,31
	mr 4,28
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L152
.L153:
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L154
	lwz 9,84(28)
	lwz 0,3532(9)
	mr 8,9
	cmpwi 0,0,2
	bc 4,2,.L155
	lwz 9,84(27)
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 4,2,.L155
	lis 9,gi@ha
	lis 6,.LC31@ha
	lwz 0,gi@l(9)
	lis 4,.LC48@ha
	addi 5,8,700
	la 4,.LC48@l(4)
	la 6,.LC31@l(6)
	b .L192
.L155:
	lwz 0,3532(8)
	cmpwi 0,0,1
	bc 4,2,.L112
	lwz 9,84(27)
	lwz 0,3532(9)
	cmpwi 0,0,2
	bc 4,2,.L112
	lis 9,gi@ha
	lis 6,.LC30@ha
	lwz 0,gi@l(9)
	lis 4,.LC49@ha
	addi 5,8,700
	la 4,.LC49@l(4)
	la 6,.LC30@l(6)
.L192:
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L152
.L154:
	lwz 9,84(28)
	lwz 0,3532(9)
	mr 8,9
	cmpwi 0,0,1
	bc 4,2,.L170
	lwz 9,84(27)
	lwz 0,3532(9)
	cmpwi 0,0,2
	bc 4,2,.L170
	lis 9,gi@ha
	lis 6,.LC30@ha
	lwz 0,gi@l(9)
	lis 4,.LC50@ha
	addi 5,8,700
	la 4,.LC50@l(4)
	la 6,.LC30@l(6)
	b .L193
.L170:
	lwz 0,3532(8)
	cmpwi 0,0,2
	bc 4,2,.L112
	lwz 9,84(27)
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 4,2,.L112
	lis 9,gi@ha
	lis 6,.LC31@ha
	lwz 0,gi@l(9)
	lis 4,.LC51@ha
	addi 5,8,700
	la 4,.LC51@l(4)
	la 6,.LC31@l(6)
.L193:
	li 3,1
.L191:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L112
.L152:
	xor 0,29,28
	addic 8,29,-1
	subfe 11,8,29
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L112
	lfs 13,4(29)
	lis 8,.LC57@ha
	addi 3,1,8
	lfs 0,4(27)
	la 8,.LC57@l(8)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	lfs 10,4(28)
	lfs 9,8(28)
	lfs 31,0(8)
	stfs 0,8(1)
	lfs 13,8(29)
	lfs 8,12(28)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(29)
	fsubs 11,11,0
	stfs 11,16(1)
	lfs 0,4(29)
	fsubs 10,10,0
	stfs 10,8(1)
	lfs 0,8(29)
	fsubs 9,9,0
	stfs 9,12(1)
	lfs 0,12(29)
	fsubs 8,8,0
	stfs 8,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L185
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L185
	mr 4,27
	mr 3,29
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L185
	mr 3,29
	mr 4,28
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L112
.L185:
	lwz 10,84(28)
	lis 11,gi@ha
	la 8,gi@l(11)
	lwz 9,3528(10)
	addi 9,9,1
	stw 9,3528(10)
	lwz 11,84(28)
	lwz 0,3532(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L186
	cmpwi 0,0,2
	bc 12,2,.L187
	b .L190
.L186:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L189
.L187:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L189
.L190:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
.L189:
	lwz 0,0(8)
	lis 4,.LC52@ha
	li 3,1
	la 4,.LC52@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L112:
	lwz 0,84(1)
	mtlr 0
	lmw 26,48(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe5:
	.size	 CTFFragBonuses,.Lfe5-CTFFragBonuses
	.align 2
	.globl CTFResetFlags
	.type	 CTFResetFlags,@function
CTFResetFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC28@ha
	li 31,0
	la 29,.LC28@l(9)
	b .L218
.L220:
	lwz 0,284(31)
	andis. 11,0,1
	bc 12,2,.L221
	mr 3,31
	bl G_FreeEdict
	b .L218
.L221:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 30,80(31)
.L218:
	mr 3,31
	li 4,280
	mr 5,29
	li 30,1
	bl G_Find
	mr. 31,3
	lis 9,gi+72@ha
	mr 3,31
	bc 4,2,.L220
	lis 9,.LC29@ha
	lis 11,gi@ha
	la 28,.LC29@l(9)
	la 29,gi@l(11)
	li 31,0
	b .L229
.L231:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L232
	mr 3,31
	bl G_FreeEdict
	b .L229
.L232:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L229:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L231
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 CTFResetFlags,.Lfe6-CTFResetFlags
	.section	".rodata"
	.align 2
.LC58:
	.string	"Don't know what team the drugpack is on.\n"
	.align 2
.LC59:
	.string	"%s brought back the confiscated drugs...\n"
	.align 2
.LC60:
	.string	"%s managed to confiscate the Terrorists illegal drugs\n"
	.align 2
.LC61:
	.string	"ctf/flagcap.wav"
	.align 2
.LC62:
	.string	"%s returned the Terrorists illegal drugs!\n"
	.align 2
.LC63:
	.string	"%s returned the Force`s confiscated drugs!\n"
	.align 2
.LC64:
	.string	"ctf/flagret.wav"
	.align 2
.LC65:
	.string	"%s found the Force`s confiscated drugs!\nCover him on his way home!\n"
	.align 2
.LC66:
	.string	"%s found the Terrorists illegal drugs!\nCover him on his way home!\n"
	.align 2
.LC67:
	.long 0x3f800000
	.align 2
.LC68:
	.long 0x0
	.align 3
.LC69:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFPickup_Flag
	.type	 CTFPickup_Flag,@function
CTFPickup_Flag:
	stwu 1,-64(1)
	mflr 0
	mfcr 12
	stmw 26,40(1)
	stw 0,68(1)
	stw 12,36(1)
	mr 31,4
	mr 30,3
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 9,0,1
	bc 12,2,.L236
	lwz 3,280(30)
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L237
	li 26,1
	b .L238
.L237:
	lwz 3,280(30)
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L239
	lis 9,gi+8@ha
	lis 5,.LC58@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC58@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L236
.L239:
	li 26,2
.L238:
	cmpwi 4,26,1
	bc 4,18,.L241
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 27,flag1_item@l(9)
	lwz 28,flag2_item@l(11)
	b .L242
.L241:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 27,flag2_item@l(9)
	lwz 28,flag1_item@l(11)
.L242:
	lwz 5,84(31)
	lwz 29,3532(5)
	cmpw 0,26,29
	bc 4,2,.L243
	lwz 0,284(30)
	andis. 9,0,1
	bc 4,2,.L244
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,28
	addi 11,5,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L236
	lis 9,gi@ha
	bc 4,18,.L246
	lwz 0,gi@l(9)
	lis 6,.LC30@ha
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	addi 5,5,700
	la 6,.LC30@l(6)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,3
	stw 9,4008(11)
.L246:
	lwz 5,84(31)
	lwz 0,3532(5)
	cmpwi 0,0,2
	bc 4,2,.L252
	lis 9,gi@ha
	addi 5,5,700
	la 11,gi@l(9)
	bc 12,18,.L253
	cmpwi 0,29,2
	bc 12,2,.L254
	b .L257
.L253:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L256
.L254:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L256
.L257:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
.L256:
	lwz 0,0(11)
	lis 4,.LC60@ha
	li 3,2
	la 4,.LC60@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,3
	stw 9,4008(11)
.L252:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,28
	addi 11,11,740
	mullw 9,9,0
	li 10,0
	lis 8,level+4@ha
	lis 6,ctfgame@ha
	rlwinm 9,9,0,0,29
	la 7,ctfgame@l(6)
	stwx 10,11,9
	lfs 0,level+4@l(8)
	stw 26,20(7)
	stfs 0,16(7)
	bc 4,18,.L258
	lwz 9,ctfgame@l(6)
	addi 9,9,10
	stw 9,ctfgame@l(6)
	b .L259
.L258:
	lwz 9,4(7)
	addi 9,9,10
	stw 9,4(7)
.L259:
	lis 29,gi@ha
	lis 3,.LC61@ha
	la 29,gi@l(29)
	la 3,.LC61@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC67@ha
	lwz 0,16(29)
	lis 11,.LC68@ha
	la 9,.LC67@l(9)
	la 11,.LC68@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,26
	mtlr 0
	lis 9,.LC68@ha
	lfs 2,0(11)
	mr 3,30
	la 9,.LC68@l(9)
	lfs 3,0(9)
	blrl
	lis 11,.LC67@ha
	lis 9,maxclients@ha
	la 11,.LC67@l(11)
	li 7,1
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L261
	lis 9,g_edicts@ha
	mr 6,11
	lwz 11,g_edicts@l(9)
	lis 5,0x4330
	lis 9,.LC69@ha
	la 9,.LC69@l(9)
	addi 8,11,928
	lfd 12,0(9)
.L263:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L262
	lwz 10,84(8)
	lwz 9,84(31)
	lwz 11,3532(10)
	lwz 0,3532(9)
	cmpw 0,11,0
	bc 4,2,.L262
	cmpw 0,8,31
	bc 12,2,.L262
	lwz 9,3528(10)
	addi 9,9,5
	stw 9,3528(10)
.L262:
	addi 7,7,1
	lfs 13,20(6)
	xoris 0,7,0x8000
	addi 8,8,928
	stw 0,28(1)
	stw 5,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L263
.L261:
	bl CTFResetFlags
	b .L236
.L244:
	bc 4,18,.L269
	lis 9,gi@ha
	lis 4,.LC62@ha
	lwz 0,gi@l(9)
	la 4,.LC62@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L270
.L269:
	cmpwi 0,29,2
	lis 9,gi@ha
	bc 4,2,.L270
	lwz 0,gi@l(9)
	lis 4,.LC63@ha
	addi 5,5,700
	la 4,.LC63@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L270:
	lis 9,level+4@ha
	lwz 11,84(31)
	lis 29,gi@ha
	lfs 0,level+4@l(9)
	la 29,gi@l(29)
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	stfs 0,3544(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC67@ha
	lwz 0,16(29)
	lis 11,.LC68@ha
	la 9,.LC67@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC68@l(11)
	li 4,26
	mtlr 0
	lis 9,.LC68@ha
	mr 3,30
	lfs 2,0(11)
	la 9,.LC68@l(9)
	lfs 3,0(9)
	blrl
	bc 12,18,.L272
	cmpwi 0,26,2
	bc 12,2,.L273
	b .L236
.L272:
	lis 9,.LC28@ha
	la 30,.LC28@l(9)
	b .L275
.L273:
	lis 9,.LC29@ha
	la 30,.LC29@l(9)
.L275:
	lis 9,gi@ha
	li 29,0
	la 28,gi@l(9)
	li 31,1
	b .L277
.L279:
	lwz 0,284(29)
	andis. 9,0,1
	bc 12,2,.L280
	mr 3,29
	bl G_FreeEdict
	b .L277
.L280:
	lwz 0,184(29)
	mr 3,29
	stw 31,248(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 31,80(29)
.L277:
	mr 3,29
	li 4,280
	mr 5,30
	bl G_Find
	mr. 29,3
	bc 4,2,.L279
	b .L236
.L243:
	lwz 0,4008(5)
	cmpwi 0,0,2
	bc 4,1,.L236
	cmpwi 0,29,1
	bc 4,2,.L284
	lis 9,gi@ha
	lis 4,.LC65@ha
	lwz 0,gi@l(9)
	la 4,.LC65@l(4)
	b .L290
.L284:
	cmpwi 0,29,2
	bc 4,2,.L285
	lis 9,gi@ha
	lis 4,.LC66@ha
	lwz 0,gi@l(9)
	la 4,.LC66@l(4)
.L290:
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,-3
	stw 9,4008(11)
.L285:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	addi 10,10,740
	mullw 9,9,0
	li 8,1
	lis 7,level+4@ha
	rlwinm 9,9,0,0,29
	stwx 8,10,9
	lfs 0,level+4@l(7)
	lwz 11,84(31)
	stfs 0,3548(11)
	lwz 0,284(30)
	andis. 11,0,0x1
	bc 4,2,.L287
	lwz 0,264(30)
	lwz 9,184(30)
	oris 0,0,0x8000
	stw 11,248(30)
	ori 9,9,1
	stw 0,264(30)
	stw 9,184(30)
.L287:
	li 3,1
	b .L289
.L236:
	li 3,0
.L289:
	lwz 0,68(1)
	lwz 12,36(1)
	mtlr 0
	lmw 26,40(1)
	mtcrf 8,12
	la 1,64(1)
	blr
.Lfe7:
	.size	 CTFPickup_Flag,.Lfe7-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC70:
	.string	"The Terrorists illegal drugs has returned!\n"
	.align 2
.LC71:
	.string	"The Force`s confiscated drugs has returned!\n"
	.section	".text"
	.align 2
	.type	 CTFDropFlagThink,@function
CTFDropFlagThink:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 29,.LC28@ha
	lwz 3,280(31)
	la 4,.LC28@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L294
	la 30,.LC28@l(29)
	li 31,0
	b .L300
.L302:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L303
	mr 3,31
	bl G_FreeEdict
	b .L300
.L303:
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
.L300:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L302
	lis 9,gi@ha
	lis 5,.LC30@ha
	lwz 0,gi@l(9)
	lis 4,.LC70@ha
	la 5,.LC30@l(5)
	la 4,.LC70@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L311
.L294:
	lwz 3,280(31)
	lis 31,.LC29@ha
	la 4,.LC29@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L311
	la 30,.LC29@l(31)
	li 31,0
	b .L318
.L320:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L321
	mr 3,31
	bl G_FreeEdict
	b .L318
.L321:
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
.L318:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L320
	lis 9,gi@ha
	lis 5,.LC31@ha
	lwz 0,gi@l(9)
	lis 4,.LC71@ha
	la 5,.LC31@l(5)
	la 4,.LC71@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L311:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 CTFDropFlagThink,.Lfe8-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC72:
	.string	"%s lost the Terrorists illegal drugs!\n"
	.align 2
.LC73:
	.string	"%s lost the Force`s confiscated drugs!\n"
	.align 2
.LC74:
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
	bc 12,2,.L331
	lwz 0,flag2_item@l(25)
	cmpwi 0,0,0
	bc 4,2,.L330
.L331:
	lis 29,gi@ha
	lis 3,.LC24@ha
	la 29,gi@l(29)
	lis 4,.LC25@ha
	lwz 9,144(29)
	la 4,.LC25@l(4)
	li 5,4
	la 3,.LC24@l(3)
	mtlr 9
	blrl
	lwz 0,144(29)
	lis 9,ctf@ha
	lis 11,.LC26@ha
	stw 3,ctf@l(9)
	lis 4,.LC27@ha
	li 5,0
	mtlr 0
	la 3,.LC26@l(11)
	la 4,.LC27@l(4)
	blrl
	lwz 0,flag1_item@l(26)
	lis 9,ctf_forcejoin@ha
	stw 3,ctf_forcejoin@l(9)
	cmpwi 0,0,0
	bc 4,2,.L332
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(26)
.L332:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	cmpwi 0,0,0
	bc 4,2,.L333
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	bl FindItemByClassname
	stw 3,flag2_item@l(25)
.L333:
	lis 3,ctfgame@ha
	li 4,0
	la 3,ctfgame@l(3)
	li 5,24
	crxor 6,6,6
	bl memset
	lis 9,techspawn@ha
	stw 27,techspawn@l(9)
.L330:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 4,flag1_item@l(9)
	la 30,itemlist@l(11)
	lis 29,0x286b
	ori 29,29,51739
	addi 10,10,740
	subf 0,30,4
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 28,10,0
	cmpwi 0,28,0
	bc 12,2,.L335
	mr 3,31
	bl Drop_Item
	lwz 0,flag1_item@l(26)
	li 10,0
	lis 11,gi@ha
	lwz 9,84(31)
	mr 27,3
	lis 6,.LC30@ha
	subf 0,30,0
	lis 4,.LC72@ha
	mullw 0,0,29
	addi 9,9,740
	la 4,.LC72@l(4)
	la 6,.LC30@l(6)
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 10,9,0
	lwz 5,84(31)
	lwz 0,gi@l(11)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L341
.L335:
	lis 9,flag2_item@ha
	lwz 4,flag2_item@l(9)
	subf 0,30,4
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L341
	mr 3,31
	bl Drop_Item
	lwz 0,flag2_item@l(25)
	lis 11,gi@ha
	mr 27,3
	lwz 9,84(31)
	lis 6,.LC31@ha
	lis 4,.LC73@ha
	subf 0,30,0
	la 4,.LC73@l(4)
	mullw 0,0,29
	addi 9,9,740
	la 6,.LC31@l(6)
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 28,9,0
	lwz 5,84(31)
	lwz 0,gi@l(11)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L341:
	cmpwi 0,27,0
	bc 12,2,.L348
	lis 11,CTFDropFlagThink@ha
	lis 9,.LC74@ha
	la 11,CTFDropFlagThink@l(11)
	la 9,.LC74@l(9)
	lis 10,level+4@ha
	stw 11,436(27)
	lfs 0,level+4@l(10)
	lfs 13,0(9)
	lis 9,CTFDropFlagTouch@ha
	la 9,CTFDropFlagTouch@l(9)
	fadds 0,0,13
	stw 9,444(27)
	stfs 0,428(27)
.L348:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 CTFDeadDropFlag,.Lfe9-CTFDeadDropFlag
	.section	".rodata"
	.align 2
.LC75:
	.string	"Only lusers drop drugs.\n"
	.align 2
.LC76:
	.string	"Winners don't drop drugs.\n"
	.align 2
.LC78:
	.string	"CTFFlagSetup: %s startsolid at %s\n"
	.align 2
.LC79:
	.long 0xc1700000
	.align 2
.LC80:
	.long 0x41700000
	.align 2
.LC81:
	.long 0x0
	.align 2
.LC82:
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
	lis 9,.LC79@ha
	lis 11,.LC79@ha
	la 9,.LC79@l(9)
	la 11,.LC79@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC79@ha
	lfs 2,0(11)
	la 9,.LC79@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC80@ha
	lfs 13,0(11)
	la 9,.LC80@l(9)
	lfs 1,0(9)
	lis 9,.LC80@ha
	stfs 13,188(31)
	la 9,.LC80@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC80@ha
	stfs 0,192(31)
	la 9,.LC80@l(9)
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
	bc 12,2,.L355
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L356
.L355:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L356:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC81@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC81@l(11)
	lis 9,.LC82@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC82@l(9)
	lis 11,.LC81@ha
	lfs 3,0(9)
	la 11,.LC81@l(11)
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
	bc 12,2,.L357
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L354
.L357:
	lfs 0,20(1)
	mr 3,31
	lfs 13,24(1)
	lfs 12,28(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	lwz 0,72(30)
	mtlr 0
	blrl
.L354:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe10:
	.size	 CTFFlagSetup,.Lfe10-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC83:
	.string	"You`ve successfully bandaged\n"
	.align 2
.LC84:
	.string	"MedKit"
	.align 2
.LC85:
	.string	"IR goggles"
	.align 2
.LC86:
	.string	"Helmet"
	.align 2
.LC87:
	.string	"Bullet Proof Vest"
	.align 2
.LC88:
	.string	"Scuba Gear"
	.align 2
.LC89:
	.string	"Head Light"
	.section	".text"
	.align 2
	.globl CTFEffects
	.type	 CTFEffects,@function
CTFEffects:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L358
	lwz 0,92(9)
	cmpwi 0,0,0
	bc 4,2,.L360
	lis 11,gi+32@ha
	lwz 9,1824(9)
	lwz 0,gi+32@l(11)
	lwz 3,32(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
.L360:
	lis 11,level@ha
	lis 10,0x6666
	lwz 9,level@l(11)
	ori 10,10,26215
	mulhw 0,9,10
	srawi 11,9,31
	srawi 0,0,2
	subf 0,11,0
	mulli 0,0,10
	cmpw 0,9,0
	bc 4,2,.L362
	lwz 9,84(31)
	lwz 0,4044(9)
	cmpwi 0,0,1
	bc 4,2,.L361
	lwz 9,480(31)
	addi 9,9,-1
	stw 9,480(31)
.L361:
	lis 9,level@ha
	lwz 11,level@l(9)
	mulhw 0,11,10
	srawi 9,11,31
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	cmpw 0,11,0
	bc 4,2,.L362
	lwz 11,84(31)
	lwz 0,3696(11)
	cmpwi 0,0,6
	bc 4,2,.L362
	lwz 9,4040(11)
	addi 9,9,1
	stw 9,4040(11)
.L362:
	lwz 9,84(31)
	lwz 0,4040(9)
	cmpwi 0,0,10
	bc 4,2,.L363
	lis 9,gi+8@ha
	lis 5,.LC83@ha
	lwz 0,gi+8@l(9)
	la 5,.LC83@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 10,0
	li 0,1
	stw 10,92(11)
	lwz 9,84(31)
	stw 0,3696(9)
	lwz 11,84(31)
	stw 10,4040(11)
.L363:
	lwz 9,84(31)
	lwz 0,4040(9)
	cmpwi 0,0,6
	bc 4,2,.L364
	li 0,0
	stw 0,4044(9)
	lwz 9,84(31)
	stw 0,4020(9)
	lwz 11,84(31)
	stw 0,4024(11)
.L364:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,1,.L365
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 12,2,.L366
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L366
	lwz 9,84(31)
	lwz 0,4044(9)
	cmpwi 0,0,1
	bc 4,2,.L367
	lis 9,meansOfDeath@ha
	li 0,39
	lis 6,0x1
	lis 7,vec3_origin@ha
	stw 0,meansOfDeath@l(9)
	mr 3,31
	la 7,vec3_origin@l(7)
	mr 5,4
	b .L377
.L367:
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 3,31
	la 7,vec3_origin@l(7)
	mr 5,4
	b .L377
.L366:
	mr 3,31
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 4,3
	la 7,vec3_origin@l(7)
	mr 5,3
.L377:
	ori 6,6,34464
	bl player_die
	b .L358
.L365:
	cmpwi 0,0,99
	lis 26,.LC84@ha
	lis 29,itemlist@ha
	bc 12,1,.L370
	lwz 30,84(31)
	lwz 0,4044(30)
	cmpwi 0,0,0
	bc 4,2,.L370
	lis 9,level@ha
	lis 0,0x8888
	lwz 11,level@l(9)
	ori 0,0,34953
	mulhw 0,11,0
	srawi 9,11,31
	add 0,0,11
	srawi 0,0,4
	subf 0,9,0
	mulli 0,0,30
	cmpw 0,11,0
	bc 4,2,.L370
	la 3,.LC84@l(26)
	bl FindItem
	la 9,itemlist@l(29)
	lis 0,0x286b
	subf 3,9,3
	ori 0,0,51739
	mullw 3,3,0
	addi 9,30,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 12,2,.L370
	lwz 9,480(31)
	addi 9,9,1
	stw 9,480(31)
.L370:
	lis 27,.LC85@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC85@l(27)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,0,.L371
	la 3,.LC85@l(27)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	li 0,0
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
.L371:
	lis 27,.LC86@ha
	lwz 29,84(31)
	la 3,.LC86@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,0,.L372
	la 3,.LC86@l(27)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	li 0,0
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
.L372:
	lis 27,.LC87@ha
	lwz 29,84(31)
	la 3,.LC87@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,0,.L373
	la 3,.LC87@l(27)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	li 0,0
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
.L373:
	lis 3,.LC84@ha
	lwz 29,84(31)
	la 3,.LC84@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,0,.L374
	la 3,.LC84@l(26)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	li 0,0
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
.L374:
	lis 27,.LC88@ha
	lwz 29,84(31)
	la 3,.LC88@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,0,.L375
	la 3,.LC88@l(27)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	li 0,0
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
.L375:
	lis 27,.LC89@ha
	lwz 29,84(31)
	la 3,.LC89@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,0,.L358
	la 3,.LC89@l(27)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	li 0,0
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
.L358:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 CTFEffects,.Lfe11-CTFEffects
	.section	".rodata"
	.align 2
.LC90:
	.long 0x0
	.align 3
.LC91:
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
	lis 9,.LC90@ha
	stw 0,8(8)
	li 6,0
	la 9,.LC90@l(9)
	stw 0,12(8)
	lfs 13,0(9)
	lfs 0,20(7)
	fcmpu 0,13,0
	bc 4,0,.L380
	lis 9,g_edicts@ha
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	mr 5,7
	la 11,game@l(11)
	lis 9,.LC91@ha
	lis 4,0x4330
	la 9,.LC91@l(9)
	addi 10,10,1016
	lfd 12,0(9)
	li 7,0
.L382:
	lwz 0,0(10)
	addi 10,10,928
	cmpwi 0,0,0
	bc 12,2,.L381
	lwz 0,1028(11)
	add 9,7,0
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 4,2,.L384
	lwz 9,3528(9)
	lwz 0,8(8)
	add 0,0,9
	stw 0,8(8)
	b .L381
.L384:
	cmpwi 0,0,2
	bc 4,2,.L381
	lwz 9,3528(9)
	lwz 0,12(8)
	add 0,0,9
	stw 0,12(8)
.L381:
	addi 6,6,1
	lfs 13,20(5)
	xoris 0,6,0x8000
	addi 7,7,4080
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L382
.L380:
	la 1,16(1)
	blr
.Lfe12:
	.size	 CTFCalcScores,.Lfe12-CTFCalcScores
	.section	".rodata"
	.align 2
.LC92:
	.string	"Disabling player identication display.\n"
	.align 2
.LC93:
	.string	"Activating player identication display.\n"
	.align 2
.LC94:
	.long 0x0
	.align 2
.LC95:
	.long 0x44800000
	.align 2
.LC96:
	.long 0x3f800000
	.align 3
.LC97:
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
	stmw 25,124(1)
	stw 0,180(1)
	mr 30,3
	lis 9,.LC94@ha
	lwz 3,84(30)
	la 9,.LC94@l(9)
	addi 4,1,8
	li 5,0
	li 6,0
	lfs 29,0(9)
	addi 3,3,3764
	bl AngleVectors
	lis 9,.LC95@ha
	addi 3,1,8
	la 9,.LC95@l(9)
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
	lis 9,.LC96@ha
	lfs 13,48(1)
	la 9,.LC96@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L392
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L392
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L391
.L392:
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	li 28,1
	addi 3,3,3764
	lis 25,maxclients@ha
	bl AngleVectors
	lis 9,.LC96@ha
	lis 11,maxclients@ha
	la 9,.LC96@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L391
	lis 9,.LC97@ha
	lis 26,g_edicts@ha
	la 9,.LC97@l(9)
	lis 27,0x4330
	lfd 30,0(9)
	li 29,928
.L396:
	lwz 0,g_edicts@l(26)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L395
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
	bc 4,1,.L395
	mr 4,31
	mr 3,30
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L395
	fmr 29,31
.L395:
	addi 28,28,1
	lwz 11,maxclients@l(25)
	xoris 0,28,0x8000
	addi 29,29,928
	stw 0,116(1)
	stw 27,112(1)
	lfd 0,112(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L396
.L391:
	lwz 0,180(1)
	mtlr 0
	lmw 25,124(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe13:
	.size	 CTFSetIDView,.Lfe13-CTFSetIDView
	.section	".rodata"
	.align 2
.LC98:
	.string	"ctfsb1"
	.align 2
.LC99:
	.string	"ctfsb2"
	.align 2
.LC100:
	.string	"i_ctf1"
	.align 2
.LC101:
	.string	"i_ctf1d"
	.align 2
.LC102:
	.string	"i_ctf2"
	.align 2
.LC103:
	.string	"i_ctf2d"
	.align 2
.LC104:
	.long 0x0
	.align 2
.LC105:
	.long 0x3f800000
	.align 3
.LC106:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC107:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl SetCTFStats
	.type	 SetCTFStats,@function
SetCTFStats:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC98@ha
	lwz 9,40(29)
	la 3,.LC98@l(3)
	lis 27,level@ha
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC99@ha
	sth 3,168(9)
	lwz 0,40(29)
	la 3,.LC99@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 10,.LC104@ha
	lis 11,level+200@ha
	la 10,.LC104@l(10)
	sth 3,170(9)
	lfs 13,0(10)
	lfs 0,level+200@l(11)
	lis 10,ctfgame@ha
	fcmpu 0,0,13
	bc 12,2,.L401
	lwz 0,level@l(27)
	andi. 11,0,8
	bc 12,2,.L401
	la 11,ctfgame@l(10)
	lwz 9,ctfgame@l(10)
	lwz 0,4(11)
	cmpw 0,9,0
	bc 12,1,.L446
	cmpw 0,0,9
	bc 12,1,.L447
	lwz 9,12(11)
	lwz 0,8(11)
	cmpw 0,0,9
	bc 4,1,.L406
.L446:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	b .L401
.L406:
	cmpw 0,9,0
	bc 4,1,.L408
.L447:
	lwz 9,84(31)
	li 0,0
	sth 0,170(9)
	b .L401
.L408:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	lwz 11,84(31)
	sth 0,170(11)
.L401:
	lis 9,gi@ha
	lis 3,.LC100@ha
	la 29,gi@l(9)
	la 3,.LC100@l(3)
	lwz 9,40(29)
	lis 26,.LC102@ha
	mtlr 9
	blrl
	mr 28,3
	lis 5,.LC28@ha
	la 5,.LC28@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L410
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L411
	lwz 0,40(29)
	lis 3,.LC100@ha
	la 3,.LC100@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC105@ha
	lwz 11,maxclients@l(9)
	la 10,.LC105@l(10)
	mr 28,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L410
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
	lis 9,.LC106@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC106@l(9)
	addi 8,8,928
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L415:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L414
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L444
.L414:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,928
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L415
	b .L410
.L444:
	lis 9,gi+40@ha
	lis 3,.LC100@ha
	lwz 0,gi+40@l(9)
	la 3,.LC100@l(3)
	b .L448
.L411:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L410
	lwz 0,40(29)
	lis 3,.LC101@ha
	la 3,.LC101@l(3)
.L448:
	mtlr 0
	blrl
	mr 28,3
.L410:
	lis 9,gi@ha
	lis 3,.LC102@ha
	la 29,gi@l(9)
	la 3,.LC102@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	mr 30,3
	lis 5,.LC29@ha
	la 5,.LC29@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L420
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L421
	lwz 0,40(29)
	la 3,.LC102@l(26)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC105@ha
	lwz 11,maxclients@l(9)
	la 10,.LC105@l(10)
	mr 30,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L420
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
	lis 9,.LC106@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC106@l(9)
	addi 8,8,928
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L425:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L424
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L445
.L424:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,928
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L425
	b .L420
.L445:
	lis 9,gi+40@ha
	lis 3,.LC102@ha
	lwz 0,gi+40@l(9)
	la 3,.LC102@l(3)
	b .L449
.L421:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L420
	lwz 0,40(29)
	lis 3,.LC103@ha
	la 3,.LC103@l(3)
.L449:
	mtlr 0
	blrl
	mr 30,3
.L420:
	lis 10,.LC104@ha
	lwz 11,84(31)
	lis 9,ctfgame@ha
	la 10,.LC104@l(10)
	lfs 0,0(10)
	sth 28,154(11)
	la 10,ctfgame@l(9)
	lwz 9,84(31)
	sth 30,158(9)
	lfs 12,16(10)
	fcmpu 0,12,0
	bc 12,2,.L430
	lis 9,level+4@ha
	lis 11,.LC107@ha
	lfs 0,level+4@l(9)
	la 11,.LC107@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L430
	lwz 0,20(10)
	cmpwi 0,0,1
	bc 4,2,.L431
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L432
	lwz 9,84(31)
	sth 28,154(9)
	b .L430
.L432:
	lwz 9,84(31)
	sth 0,154(9)
	b .L430
.L431:
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L435
	lwz 9,84(31)
	sth 30,158(9)
	b .L430
.L435:
	lwz 9,84(31)
	sth 0,158(9)
.L430:
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
	lwz 0,3532(10)
	cmpwi 0,0,1
	bc 4,2,.L437
	lis 9,flag2_item@ha
	lis 11,itemlist@ha
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	addi 10,10,740
	lis 9,0x286b
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L437
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L437
	lis 9,gi+40@ha
	lis 3,.LC102@ha
	lwz 0,gi+40@l(9)
	la 3,.LC102@l(3)
	b .L450
.L437:
	lwz 10,84(31)
	lwz 0,3532(10)
	cmpwi 0,0,2
	bc 4,2,.L438
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	addi 10,10,740
	lis 9,0x286b
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L438
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L438
	lis 9,gi+40@ha
	lis 3,.LC100@ha
	lwz 0,gi+40@l(9)
	la 3,.LC100@l(3)
.L450:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,162(9)
.L438:
	lwz 11,84(31)
	li 0,0
	sth 0,164(11)
	lwz 9,84(31)
	sth 0,166(9)
	lwz 11,84(31)
	lwz 0,3532(11)
	cmpwi 0,0,1
	bc 4,2,.L440
	lis 9,gi+40@ha
	lis 3,.LC100@ha
	lwz 0,gi+40@l(9)
	la 3,.LC100@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,164(9)
	b .L441
.L440:
	cmpwi 0,0,2
	bc 4,2,.L441
	lis 9,gi+40@ha
	lis 3,.LC102@ha
	lwz 0,gi+40@l(9)
	la 3,.LC102@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,166(9)
.L441:
	lwz 9,84(31)
	lwz 0,3556(9)
	cmpwi 0,0,0
	bc 12,2,.L443
	mr 3,31
	bl CTFSetIDView
.L443:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 SetCTFStats,.Lfe14-SetCTFStats
	.section	".rodata"
	.align 2
.LC109:
	.string	"weapons/grapple/grreset.wav"
	.align 2
.LC111:
	.string	"weapons/grapple/grpull.wav"
	.align 2
.LC112:
	.string	"weapons/grapple/grhit.wav"
	.align 2
.LC110:
	.long 0x3e4ccccd
	.align 2
.LC113:
	.long 0x3f800000
	.align 2
.LC114:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFGrappleTouch
	.type	 CTFGrappleTouch,@function
CTFGrappleTouch:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	mr 31,3
	mr 29,4
	lwz 30,256(31)
	lis 9,.LC113@ha
	mr 26,5
	la 9,.LC113@l(9)
	cmpw 0,29,30
	lfs 31,0(9)
	bc 12,2,.L458
	lwz 9,84(30)
	lwz 28,3936(9)
	cmpwi 0,28,0
	bc 4,2,.L458
	cmpwi 0,6,0
	bc 12,2,.L461
	lwz 0,16(6)
	andi. 11,0,4
	bc 12,2,.L461
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L458
	lwz 0,3860(9)
	lis 9,.LC113@ha
	cmpwi 0,0,0
	la 9,.LC113@l(9)
	lfs 31,0(9)
	bc 12,2,.L463
	lis 9,.LC110@ha
	lfs 31,.LC110@l(9)
.L463:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC113@ha
	lis 11,.LC114@ha
	fmr 1,31
	la 9,.LC113@l(9)
	la 11,.LC114@l(11)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	li 4,17
	mr 3,30
	lfs 3,0(11)
	blrl
	lwz 11,256(31)
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 28,3932(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3936(9)
	andi. 0,0,191
	stfs 0,3940(9)
	stb 0,16(9)
	bl G_FreeEdict
	b .L458
.L461:
	lis 9,vec3_origin@ha
	addi 4,31,4
	lwz 3,256(31)
	lfs 13,vec3_origin@l(9)
	la 28,vec3_origin@l(9)
	mr 27,4
	li 5,2
	stfs 13,376(31)
	lfs 0,4(28)
	stfs 0,380(31)
	lfs 13,8(28)
	stfs 13,384(31)
	bl PlayerNoise
	lwz 11,256(31)
	li 0,1
	li 10,0
	lwz 9,84(11)
	stw 0,3936(9)
	lwz 30,256(31)
	stw 29,540(31)
	stw 10,248(31)
	lwz 9,84(30)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L465
	lis 9,.LC110@ha
	lfs 31,.LC110@l(9)
.L465:
	lis 9,gi@ha
	lis 3,.LC111@ha
	la 29,gi@l(9)
	la 3,.LC111@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC113@ha
	lwz 11,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC113@l(9)
	li 4,17
	lfs 2,0(9)
	mtlr 11
	mr 3,30
	lis 9,.LC114@ha
	la 9,.LC114@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	lis 3,.LC112@ha
	la 3,.LC112@l(3)
	mtlr 9
	blrl
	lis 9,.LC113@ha
	lwz 11,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC113@l(9)
	li 4,1
	lfs 2,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC114@ha
	la 9,.LC114@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	cmpwi 0,26,0
	bc 4,2,.L466
	lwz 0,124(29)
	mr 3,28
	mtlr 0
	blrl
	b .L467
.L466:
	lwz 0,124(29)
	mr 3,26
	mtlr 0
	blrl
.L467:
	lis 9,gi+88@ha
	mr 3,27
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L458:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 CTFGrappleTouch,.Lfe15-CTFGrappleTouch
	.section	".rodata"
	.align 3
.LC115:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC116:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl CTFGrappleDrawCable
	.type	 CTFGrappleDrawCable,@function
CTFGrappleDrawCable:
	stwu 1,-128(1)
	mflr 0
	stmw 28,112(1)
	stw 0,132(1)
	mr 31,3
	addi 28,1,56
	lwz 9,256(31)
	addi 29,1,72
	mr 4,28
	mr 5,29
	li 6,0
	lwz 3,84(9)
	addi 3,3,3764
	bl AngleVectors
	lis 9,.LC115@ha
	lwz 10,256(31)
	lis 0,0x4180
	la 9,.LC115@l(9)
	stw 0,12(1)
	lfd 13,0(9)
	lis 3,0x4330
	mr 7,29
	stw 0,8(1)
	addi 8,1,24
	addi 4,10,4
	lwz 9,508(10)
	mr 6,28
	addi 5,1,8
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,108(1)
	stw 3,104(1)
	lfd 0,104(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	lwz 3,84(10)
	bl P_ProjectSource
	lwz 9,256(31)
	addi 3,1,88
	lfs 9,24(1)
	lfs 0,4(9)
	lfs 13,4(31)
	lfs 11,8(31)
	fsubs 0,9,0
	lfs 12,28(1)
	lfs 8,32(1)
	fsubs 9,9,13
	stfs 0,8(1)
	fsubs 11,12,11
	lfs 10,8(9)
	lfs 0,12(31)
	fsubs 12,12,10
	fsubs 0,8,0
	stfs 12,12(1)
	lfs 13,12(9)
	stfs 0,96(1)
	stfs 9,88(1)
	fsubs 8,8,13
	stfs 11,92(1)
	stfs 8,16(1)
	bl VectorLength
	lis 9,.LC116@ha
	la 9,.LC116@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L468
	lis 29,gi@ha
	lfs 12,4(31)
	li 3,3
	la 29,gi@l(29)
	lfs 13,8(31)
	lwz 9,100(29)
	lfs 0,12(31)
	mtlr 9
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	blrl
	lwz 9,100(29)
	li 3,24
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lwz 3,256(31)
	lis 0,0x4f72
	lwz 11,g_edicts@l(9)
	ori 0,0,49717
	lwz 10,104(29)
	subf 3,11,3
	mullw 3,3,0
	mtlr 10
	srawi 3,3,5
	blrl
	lwz 9,120(29)
	lwz 3,256(31)
	mtlr 9
	addi 3,3,4
	blrl
	lwz 9,120(29)
	addi 3,1,40
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L468:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe16:
	.size	 CTFGrappleDrawCable,.Lfe16-CTFGrappleDrawCable
	.section	".rodata"
	.align 2
.LC117:
	.string	"weapon_grapple"
	.align 2
.LC119:
	.string	"weapons/grapple/grhang.wav"
	.align 2
.LC118:
	.long 0x3e4ccccd
	.align 2
.LC120:
	.long 0x44228000
	.align 2
.LC121:
	.long 0x3f800000
	.align 2
.LC122:
	.long 0x0
	.align 2
.LC123:
	.long 0x3f000000
	.align 3
.LC124:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC125:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl CTFGrapplePull
	.type	 CTFGrapplePull,@function
CTFGrapplePull:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stmw 28,88(1)
	stw 0,116(1)
	mr 31,3
	lis 4,.LC117@ha
	lwz 10,256(31)
	la 4,.LC117@l(4)
	lwz 9,84(10)
	lwz 11,1824(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L471
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 28,3660(9)
	cmpwi 0,28,0
	bc 4,2,.L471
	lwz 0,3696(9)
	cmpwi 0,0,3
	bc 12,2,.L471
	cmpwi 0,0,1
	bc 12,2,.L471
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L470
	lwz 0,3860(9)
	lis 8,.LC121@ha
	la 8,.LC121@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L473
	lis 9,.LC118@ha
	lfs 31,.LC118@l(9)
.L473:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC121@ha
	lis 9,.LC122@ha
	fmr 1,31
	la 9,.LC122@l(9)
	mr 5,3
	la 8,.LC121@l(8)
	mr 3,30
	lfs 3,0(9)
	mtlr 0
	li 4,17
	lfs 2,0(8)
	blrl
	lwz 11,256(31)
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 28,3932(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3936(9)
	b .L491
.L471:
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L475
	lwz 28,248(3)
	cmpwi 0,28,0
	bc 4,2,.L476
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L470
	lwz 0,3860(9)
	lis 8,.LC121@ha
	la 8,.LC121@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L478
	lis 9,.LC118@ha
	lfs 31,.LC118@l(9)
.L478:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC121@ha
	lis 9,.LC122@ha
	fmr 1,31
	la 9,.LC122@l(9)
	mr 5,3
	la 8,.LC121@l(8)
	mr 3,30
	lfs 3,0(9)
	mtlr 0
	li 4,17
	lfs 2,0(8)
	blrl
	lwz 11,256(31)
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 28,3932(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3936(9)
	b .L491
.L476:
	cmpwi 0,28,2
	bc 4,2,.L480
	lis 8,.LC123@ha
	addi 3,3,236
	la 8,.LC123@l(8)
	addi 4,1,24
	lfs 1,0(8)
	bl VectorScale
	lwz 9,540(31)
	lis 11,gi+72@ha
	mr 3,31
	lfs 13,24(1)
	lfs 0,4(9)
	lfs 12,28(1)
	lfs 11,32(1)
	fadds 13,13,0
	stfs 13,24(1)
	lfs 0,8(9)
	fadds 12,12,0
	stfs 12,28(1)
	lfs 0,12(9)
	fadds 11,11,0
	stfs 11,32(1)
	lfs 0,188(9)
	fadds 13,13,0
	stfs 13,4(31)
	lfs 0,192(9)
	fadds 12,12,0
	stfs 12,8(31)
	lfs 0,196(9)
	fadds 11,11,0
	stfs 11,12(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	b .L481
.L480:
	lfs 0,376(3)
	stfs 0,376(31)
	lfs 13,380(3)
	stfs 13,380(31)
	lfs 0,384(3)
	stfs 0,384(31)
.L481:
	lwz 3,540(31)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L482
	lwz 4,256(31)
	bl CheckTeamDamage
.L482:
	lwz 9,540(31)
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L475
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L470
	lwz 0,3860(9)
	lis 8,.LC121@ha
	la 8,.LC121@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L486
	lis 9,.LC118@ha
	lfs 31,.LC118@l(9)
.L486:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC121@ha
	lis 9,.LC122@ha
	fmr 1,31
	la 8,.LC121@l(8)
	la 9,.LC122@l(9)
	mr 5,3
	lfs 2,0(8)
	mtlr 0
	li 4,17
	mr 3,30
	lfs 3,0(9)
	blrl
	lwz 11,256(31)
	li 8,0
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 8,3932(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3936(9)
.L491:
	andi. 0,0,191
	stfs 0,3940(9)
	stb 0,16(9)
	bl G_FreeEdict
	b .L470
.L475:
	mr 3,31
	bl CTFGrappleDrawCable
	lwz 9,256(31)
	lwz 3,84(9)
	lwz 0,3936(3)
	cmpwi 0,0,0
	bc 4,1,.L470
	addi 3,3,3764
	addi 4,1,40
	li 5,0
	addi 6,1,56
	bl AngleVectors
	lwz 9,256(31)
	lis 10,0x4330
	lfs 10,4(31)
	lis 8,.LC124@ha
	addi 3,1,8
	lfs 0,4(9)
	la 8,.LC124@l(8)
	lfs 11,8(31)
	lfd 8,0(8)
	stfs 0,24(1)
	fsubs 10,10,0
	lfs 13,8(9)
	lfs 9,12(31)
	stfs 13,28(1)
	fsubs 11,11,13
	lfs 12,12(9)
	stfs 12,32(1)
	lwz 0,508(9)
	stfs 10,8(1)
	xoris 0,0,0x8000
	stfs 11,12(1)
	stw 0,84(1)
	stw 10,80(1)
	lfd 0,80(1)
	fsub 0,0,8
	frsp 0,0
	fadds 12,12,0
	fsubs 9,9,12
	stfs 12,32(1)
	stfs 9,16(1)
	bl VectorLength
	lis 8,.LC125@ha
	lwz 9,256(31)
	la 8,.LC125@l(8)
	lfs 0,0(8)
	lwz 11,84(9)
	fcmpu 7,1,0
	lwz 0,3936(11)
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	mfcr 9
	rlwinm 9,9,29,1
	and. 8,0,9
	bc 12,2,.L489
	lwz 0,3860(11)
	lis 9,.LC121@ha
	la 9,.LC121@l(9)
	cmpwi 0,0,0
	lfs 31,0(9)
	bc 12,2,.L490
	lis 9,.LC118@ha
	lfs 31,.LC118@l(9)
.L490:
	lbz 0,16(11)
	lis 29,gi@ha
	lis 3,.LC119@ha
	la 29,gi@l(29)
	la 3,.LC119@l(3)
	ori 0,0,64
	stb 0,16(11)
	lwz 9,36(29)
	lwz 28,256(31)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC121@ha
	lis 9,.LC122@ha
	fmr 1,31
	la 9,.LC122@l(9)
	mr 5,3
	la 8,.LC121@l(8)
	lfs 3,0(9)
	mtlr 0
	li 4,17
	mr 3,28
	lfs 2,0(8)
	blrl
	lwz 11,256(31)
	li 0,2
	lwz 9,84(11)
	stw 0,3936(9)
.L489:
	addi 3,1,8
	bl VectorNormalize
	lis 9,.LC120@ha
	addi 3,1,8
	lfs 1,.LC120@l(9)
	mr 4,3
	bl VectorScale
	lfs 0,8(1)
	lwz 9,256(31)
	stfs 0,376(9)
	lfs 0,12(1)
	lwz 11,256(31)
	stfs 0,380(11)
	lfs 0,16(1)
	lwz 9,256(31)
	stfs 0,384(9)
	lwz 3,256(31)
	bl SV_AddGravity
.L470:
	lwz 0,116(1)
	mtlr 0
	lmw 28,88(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe17:
	.size	 CTFGrapplePull,.Lfe17-CTFGrapplePull
	.section	".rodata"
	.align 2
.LC126:
	.string	"models/weapons/grapple/hook/tris.md2"
	.align 2
.LC128:
	.string	"weapons/grapple/grfire.wav"
	.align 2
.LC127:
	.long 0x3e4ccccd
	.align 2
.LC129:
	.long 0x3f800000
	.align 3
.LC130:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC131:
	.long 0x41c00000
	.align 2
.LC132:
	.long 0x41000000
	.align 2
.LC133:
	.long 0xc0000000
	.align 2
.LC134:
	.long 0x0
	.align 3
.LC135:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC136:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl CTFGrappleFire
	.type	 CTFGrappleFire,@function
CTFGrappleFire:
	stwu 1,-224(1)
	mflr 0
	stfd 30,208(1)
	stfd 31,216(1)
	stmw 21,164(1)
	stw 0,228(1)
	mr 30,3
	lis 9,.LC129@ha
	lwz 3,84(30)
	la 9,.LC129@l(9)
	mr 28,4
	mr 21,5
	mr 23,6
	lfs 30,0(9)
	lwz 0,3936(3)
	cmpwi 0,0,0
	bc 12,1,.L494
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3764
	mr 5,29
	li 6,0
	lis 22,0x4330
	bl AngleVectors
	addi 25,30,4
	lis 9,.LC130@ha
	lis 10,.LC131@ha
	lfs 12,0(28)
	la 9,.LC130@l(9)
	la 10,.LC131@l(10)
	lfs 10,8(28)
	lfd 31,0(9)
	addi 24,1,40
	lwz 9,508(30)
	mr 4,25
	mr 7,29
	lfs 0,0(10)
	addi 5,1,56
	addi 6,1,8
	addi 9,9,-6
	lis 10,.LC132@ha
	lfs 13,4(28)
	xoris 9,9,0x8000
	la 10,.LC132@l(10)
	lwz 3,84(30)
	stw 9,156(1)
	fadds 12,12,0
	mr 8,24
	stw 22,152(1)
	lfd 0,152(1)
	lfs 11,0(10)
	stfs 12,56(1)
	fsub 0,0,31
	fadds 13,13,11
	frsp 0,0
	stfs 13,60(1)
	fadds 0,0,10
	stfs 0,64(1)
	bl P_ProjectSource
	lis 9,.LC133@ha
	lwz 4,84(30)
	addi 3,1,8
	la 9,.LC133@l(9)
	lfs 1,0(9)
	addi 4,4,3712
	bl VectorScale
	lwz 11,84(30)
	lis 0,0xbf80
	stw 0,3700(11)
	lwz 9,84(30)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L496
	lis 9,.LC127@ha
	lfs 30,.LC127@l(9)
.L496:
	lis 29,gi@ha
	lis 3,.LC128@ha
	la 29,gi@l(29)
	la 3,.LC128@l(3)
	lwz 9,36(29)
	addi 27,1,8
	li 28,650
	mtlr 9
	blrl
	lis 9,.LC129@ha
	lis 10,.LC134@ha
	fmr 1,30
	la 9,.LC129@l(9)
	mr 5,3
	lfs 2,0(9)
	la 10,.LC134@l(10)
	li 4,17
	lwz 9,16(29)
	mr 3,30
	lfs 3,0(10)
	mtlr 9
	blrl
	mr 3,27
	bl VectorNormalize
	bl G_Spawn
	lfs 0,40(1)
	mr 31,3
	mr 3,27
	addi 4,31,16
	addi 26,31,4
	stfs 0,4(31)
	lfs 0,44(1)
	stfs 0,8(31)
	lfs 13,48(1)
	stfs 13,12(31)
	lfs 0,40(1)
	stfs 0,28(31)
	lfs 13,44(1)
	stfs 13,32(31)
	lfs 0,48(1)
	stfs 0,36(31)
	bl vectoangles
	xoris 28,28,0x8000
	stw 28,156(1)
	addi 4,31,376
	mr 3,27
	stw 22,152(1)
	lfd 1,152(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	li 9,0
	li 10,8
	li 8,2
	stw 9,200(31)
	ori 0,0,3
	or 11,11,23
	stw 10,260(31)
	stw 8,248(31)
	lis 3,.LC126@ha
	stw 0,252(31)
	la 3,.LC126@l(3)
	stw 11,64(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,CTFGrappleTouch@ha
	stw 3,40(31)
	li 0,0
	la 9,CTFGrappleTouch@l(9)
	stw 21,516(31)
	mr 3,31
	stw 9,444(31)
	stw 30,256(31)
	lwz 9,84(30)
	stw 31,3932(9)
	lwz 11,84(30)
	stw 0,3936(11)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 0,48(29)
	lis 9,0x600
	mr 4,25
	ori 9,9,3
	addi 3,1,72
	li 5,0
	li 6,0
	mtlr 0
	mr 7,26
	mr 8,31
	blrl
	lfs 0,80(1)
	lis 9,.LC135@ha
	la 9,.LC135@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L498
	lis 10,.LC136@ha
	mr 3,26
	la 10,.LC136@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,27
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,124(1)
	li 6,0
	mtlr 0
	blrl
.L498:
	mr 3,30
	mr 4,24
	li 5,1
	bl PlayerNoise
.L494:
	lwz 0,228(1)
	mtlr 0
	lmw 21,164(1)
	lfd 30,208(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe18:
	.size	 CTFGrappleFire,.Lfe18-CTFGrappleFire
	.section	".rodata"
	.align 2
.LC137:
	.string	"fire grapple\n"
	.section	".data"
	.align 2
	.type	 pause_frames.117,@object
pause_frames.117:
	.long 10
	.long 18
	.long 27
	.long 0
	.align 2
	.type	 fire_frames.118,@object
fire_frames.118:
	.long 6
	.long 0
	.section	".rodata"
	.align 2
.LC138:
	.long 0x3e4ccccd
	.align 2
.LC139:
	.long 0x3f800000
	.align 2
.LC140:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFWeapon_Grapple
	.type	 CTFWeapon_Grapple,@function
CTFWeapon_Grapple:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 30,3
	lwz 9,84(30)
	lwz 0,3644(9)
	andi. 11,0,1
	bc 12,2,.L511
	lwz 0,3696(9)
	cmpwi 0,0,3
	bc 4,2,.L501
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L501
	li 0,9
	stw 0,92(9)
.L501:
	lwz 9,84(30)
	lwz 0,3644(9)
	andi. 9,0,1
	bc 4,2,.L502
.L511:
	lwz 9,84(30)
	lwz 31,3932(9)
	cmpwi 0,31,0
	bc 12,2,.L502
	lwz 28,256(31)
	lwz 9,84(28)
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L505
	lwz 0,3860(9)
	lis 11,.LC139@ha
	la 11,.LC139@l(11)
	cmpwi 0,0,0
	lfs 31,0(11)
	bc 12,2,.L504
	lis 9,.LC138@ha
	lfs 31,.LC138@l(9)
.L504:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC139@ha
	lis 11,.LC140@ha
	fmr 1,31
	la 9,.LC139@l(9)
	la 11,.LC140@l(11)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	li 4,17
	lfs 3,0(11)
	mr 3,28
	blrl
	lwz 11,256(31)
	li 8,0
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 8,3932(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3936(9)
	andi. 0,0,191
	stfs 0,3940(9)
	stb 0,16(9)
	bl G_FreeEdict
.L505:
	lwz 9,84(30)
	lwz 0,3696(9)
	cmpwi 0,0,3
	bc 4,2,.L502
	li 0,0
	stw 0,3696(9)
.L502:
	lwz 9,84(30)
	lwz 0,3660(9)
	cmpwi 0,0,0
	bc 12,2,.L507
	lwz 0,3936(9)
	cmpwi 0,0,0
	bc 4,1,.L507
	lwz 0,3696(9)
	cmpwi 0,0,3
	bc 4,2,.L507
	li 0,2
	li 11,32
	stw 0,3696(9)
	lwz 9,84(30)
	stw 11,92(9)
.L507:
	lwz 10,84(30)
	lis 9,fire_frames.118@ha
	lis 11,CTFWeapon_Grapple_Fire@ha
	la 9,fire_frames.118@l(9)
	la 11,CTFWeapon_Grapple_Fire@l(11)
	lwz 29,3696(10)
	mr 3,30
	li 4,5
	stw 9,8(1)
	lis 10,pause_frames.117@ha
	li 5,9
	la 10,pause_frames.117@l(10)
	stw 11,12(1)
	li 6,31
	li 7,36
	li 8,0
	li 9,0
	bl Weapon_Generic
	cmpwi 0,29,1
	bc 4,2,.L508
	lwz 9,84(30)
	lwz 0,3696(9)
	cmpwi 0,0,0
	bc 4,2,.L508
	lwz 0,3936(9)
	cmpwi 0,0,0
	bc 4,1,.L508
	lwz 0,3644(9)
	andi. 11,0,1
	li 0,5
	bc 4,2,.L509
	li 0,9
.L509:
	stw 0,92(9)
	lwz 9,84(30)
	li 0,3
	stw 0,3696(9)
.L508:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 CTFWeapon_Grapple,.Lfe19-CTFWeapon_Grapple
	.section	".rodata"
	.align 2
.LC141:
	.string	"You are on the %s team.\n"
	.align 2
.LC142:
	.string	"terrorists"
	.align 2
.LC143:
	.string	"force"
	.align 2
.LC144:
	.string	"Unknown team %s.\n"
	.align 2
.LC145:
	.string	"You are already on the %s team.\n"
	.align 2
.LC146:
	.string	"skin"
	.align 2
.LC147:
	.string	"%s joined the %s.\n"
	.align 2
.LC148:
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
	bc 4,2,.L514
	lwz 9,84(31)
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 12,2,.L515
	cmpwi 0,0,2
	bc 12,2,.L516
	b .L519
.L515:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L518
.L516:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L518
.L519:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
.L518:
	lwz 0,8(29)
	lis 5,.LC141@ha
	mr 3,31
	la 5,.LC141@l(5)
	li 4,2
	b .L541
.L514:
	lis 4,.LC142@ha
	mr 3,30
	la 4,.LC142@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L520
	li 30,1
	b .L521
.L520:
	lis 4,.LC143@ha
	mr 3,30
	la 4,.LC143@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L522
	lwz 0,8(29)
	lis 5,.LC144@ha
	mr 3,31
	la 5,.LC144@l(5)
	mr 6,30
	li 4,2
	b .L541
.L522:
	li 30,2
.L521:
	lwz 9,84(31)
	lwz 0,3532(9)
	cmpw 0,0,30
	bc 4,2,.L524
	cmpwi 0,30,1
	lis 9,gi@ha
	la 11,gi@l(9)
	bc 12,2,.L525
	cmpwi 0,30,2
	bc 12,2,.L526
	b .L529
.L525:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L528
.L526:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L528
.L529:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
.L528:
	lwz 0,8(11)
	lis 5,.LC145@ha
	mr 3,31
	la 5,.LC145@l(5)
	li 4,2
	b .L541
.L524:
	lwz 0,264(31)
	li 29,0
	lis 4,.LC146@ha
	stw 29,184(31)
	la 4,.LC146@l(4)
	rlwinm 0,0,0,28,26
	stw 0,264(31)
	stw 30,3532(9)
	lwz 9,84(31)
	stw 29,3536(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L530
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
	bc 12,2,.L531
	cmpwi 0,30,2
	bc 12,2,.L532
	b .L535
.L531:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L534
.L532:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L534
.L535:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
.L534:
	lwz 0,0(10)
	lis 4,.LC147@ha
	li 3,2
	la 4,.LC147@l(4)
.L541:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L513
.L530:
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
	stw 29,3528(11)
	lwz 9,84(31)
	addi 5,9,700
	bc 12,2,.L536
	cmpwi 0,30,2
	bc 12,2,.L537
	b .L540
.L536:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L539
.L537:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L539
.L540:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
.L539:
	lwz 0,0(10)
	lis 4,.LC148@ha
	li 3,2
	la 4,.LC148@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L513:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 CTFTeam_f,.Lfe20-CTFTeam_f
	.section	".rodata"
	.align 2
.LC149:
	.string	"if 24 xv 8 yv 8 pic 24 endif xv 40 yv 28 string \"%4d %s\" if 25 xv 168 yv 8 pic 25 endif xv 200 yv 28 string \"%4d %s\" "
	.align 2
.LC150:
	.string	"points"
	.align 2
.LC151:
	.string	"ctf 0 %d %d --- %d "
	.align 2
.LC152:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC153:
	.string	"xv 56 yv %d picn sbfctf2 "
	.align 2
.LC154:
	.string	"ctf 160 %d %d --- %d "
	.align 2
.LC155:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC156:
	.string	"xv 216 yv %d picn sbfctf1 "
	.align 2
.LC157:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC158:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC159:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC160:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC161:
	.long 0x0
	.align 3
.LC162:
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
	addi 11,1,6536
	la 10,game@l(9)
	li 0,0
	lwz 9,1544(10)
	li 25,0
	mr 16,11
	stw 0,4(11)
	li 23,0
	li 24,0
	stw 0,6536(1)
	addi 11,1,6544
	cmpw 0,23,9
	stw 25,4(11)
	addi 20,1,1032
	stw 25,6544(1)
	bc 4,0,.L544
	lis 9,g_edicts@ha
	mr 19,10
	lwz 17,g_edicts@l(9)
	mr 31,11
	mr 21,16
	addi 18,1,4488
	mr 12,16
.L546:
	mulli 9,23,928
	addi 22,23,1
	add 28,9,17
	lwz 0,1016(28)
	cmpwi 0,0,0
	bc 12,2,.L545
	mulli 9,23,4080
	lwz 0,1028(19)
	mr 8,9
	add 9,9,0
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 4,2,.L548
	li 10,0
	b .L549
.L548:
	cmpwi 0,0,2
	bc 4,2,.L545
	li 10,1
.L549:
	slwi 0,10,2
	lwz 9,1028(19)
	li 26,0
	lwzx 11,21,0
	mr 3,0
	slwi 7,10,10
	add 9,8,9
	addi 6,1,4488
	cmpw 0,26,11
	lwz 30,3528(9)
	addi 4,1,2440
	addi 22,23,1
	bc 4,0,.L553
	lwzx 0,18,7
	cmpw 0,30,0
	bc 12,1,.L553
	lwzx 11,3,12
	add 9,7,6
.L554:
	addi 26,26,1
	cmpw 0,26,11
	bc 4,0,.L553
	lwzu 0,4(9)
	cmpw 0,30,0
	bc 4,1,.L554
.L553:
	lwzx 27,3,21
	slwi 28,26,2
	cmpw 0,27,26
	bc 4,1,.L559
	addi 11,4,-4
	slwi 9,27,2
	add 11,7,11
	addi 0,6,-4
	add 0,7,0
	add 10,9,11
	mr 29,4
	add 8,9,0
	add 11,9,7
	mr 5,6
.L561:
	lwz 9,0(10)
	addi 27,27,-1
	cmpw 0,27,26
	addi 10,10,-4
	stwx 9,11,29
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L561
.L559:
	add 0,28,7
	stwx 23,4,0
	stwx 30,6,0
	lwzx 9,3,31
	lwzx 11,3,21
	add 9,9,30
	addi 11,11,1
	stwx 9,3,31
	stwx 11,3,21
.L545:
	lwz 0,1544(19)
	mr 23,22
	cmpw 0,23,0
	bc 12,0,.L546
.L544:
	lis 9,ctfgame@ha
	lis 6,.LC150@ha
	la 11,ctfgame@l(9)
	li 0,0
	lwz 5,ctfgame@l(9)
	la 6,.LC150@l(6)
	lwz 7,4(11)
	lis 4,.LC149@ha
	stb 0,1032(1)
	la 4,.LC149@l(4)
	mr 8,6
	mr 3,20
	li 23,0
	crxor 6,6,6
	bl sprintf
	mr 3,20
	bl strlen
	lwz 0,6536(1)
	mr 21,3
	b .L604
.L568:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,23,9
	bc 4,0,.L569
	lis 9,tpfrag@ha
	slwi 27,23,2
	lwz 8,tpfrag@l(9)
	addi 30,1,2440
	lis 11,game+1028@ha
	lis 9,.LC161@ha
	lwzx 0,30,27
	lis 10,g_edicts@ha
	la 9,.LC161@l(9)
	lfs 0,20(8)
	lfs 13,0(9)
	mulli 9,0,928
	lwz 8,game+1028@l(11)
	lwz 11,g_edicts@l(10)
	mulli 0,0,4080
	fcmpu 0,0,13
	addi 9,9,928
	add 31,8,0
	add 28,11,9
	bc 12,2,.L570
	addi 3,1,8
	mr 29,3
	bl strlen
	mr 26,29
	lwz 9,184(31)
	slwi 11,23,3
	lis 4,.LC151@ha
	lwzx 6,30,27
	add 3,29,3
	la 4,.LC151@l(4)
	cmpwi 7,9,1000
	addi 5,11,42
	mr 30,11
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 7,0,0
	and 9,9,0
	andi. 7,7,999
	or 7,9,7
	crxor 6,6,6
	bl sprintf
	b .L572
.L570:
	addi 3,1,8
	mr 29,3
	bl strlen
	mr 26,29
	lwz 9,184(31)
	slwi 11,23,3
	lis 4,.LC152@ha
	lwzx 6,30,27
	add 3,29,3
	la 4,.LC152@l(4)
	cmpwi 7,9,1000
	lwz 7,3528(31)
	addi 5,11,42
	mr 30,11
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 9,9,0
	andi. 8,8,999
	or 8,9,8
	crxor 6,6,6
	bl sprintf
.L572:
	lis 9,flag2_item@ha
	lis 11,itemlist@ha
	lwz 8,84(28)
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x286b
	addi 10,8,740
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L575
	lwz 0,4060(8)
	cmpwi 0,0,1
	bc 4,2,.L574
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 4,2,.L574
.L575:
	addi 3,1,8
	bl strlen
	lis 4,.LC153@ha
	add 3,26,3
	la 4,.LC153@l(4)
	addi 5,30,42
	crxor 6,6,6
	bl sprintf
.L574:
	addi 3,1,8
	subfic 29,21,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L569
	addi 4,1,8
	mr 3,20
	bl strcat
	mr 24,23
	mr 3,20
	bl strlen
	mr 21,3
.L569:
	lwz 0,4(16)
	cmpw 0,23,0
	bc 4,0,.L566
	lis 9,tpfrag@ha
	slwi 27,23,2
	lwz 8,tpfrag@l(9)
	addi 30,1,3464
	lis 11,game+1028@ha
	lis 9,.LC161@ha
	lwzx 0,30,27
	lis 10,g_edicts@ha
	la 9,.LC161@l(9)
	lfs 0,20(8)
	lfs 13,0(9)
	mulli 9,0,928
	lwz 8,game+1028@l(11)
	lwz 11,g_edicts@l(10)
	mulli 0,0,4080
	fcmpu 0,0,13
	addi 9,9,928
	add 31,8,0
	add 28,11,9
	bc 12,2,.L578
	addi 3,1,8
	mr 29,3
	bl strlen
	mr 26,29
	lwz 9,184(31)
	slwi 11,23,3
	lis 4,.LC154@ha
	lwzx 6,30,27
	add 3,29,3
	la 4,.LC154@l(4)
	cmpwi 7,9,1000
	addi 5,11,42
	mr 30,11
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 7,0,0
	and 9,9,0
	andi. 7,7,999
	or 7,9,7
	crxor 6,6,6
	bl sprintf
	b .L580
.L578:
	addi 3,1,8
	mr 29,3
	bl strlen
	mr 26,29
	lwz 9,184(31)
	slwi 11,23,3
	lis 4,.LC155@ha
	lwzx 6,30,27
	add 3,29,3
	la 4,.LC155@l(4)
	cmpwi 7,9,1000
	lwz 7,3528(31)
	addi 5,11,42
	mr 30,11
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 9,9,0
	andi. 8,8,999
	or 8,9,8
	crxor 6,6,6
	bl sprintf
.L580:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 8,84(28)
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x286b
	addi 10,8,740
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L583
	lwz 0,4064(8)
	cmpwi 0,0,1
	bc 4,2,.L582
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 4,2,.L582
.L583:
	addi 3,1,8
	bl strlen
	lis 4,.LC156@ha
	add 3,26,3
	la 4,.LC156@l(4)
	addi 5,30,42
	crxor 6,6,6
	bl sprintf
.L582:
	addi 3,1,8
	subfic 29,21,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L566
	addi 4,1,8
	mr 3,20
	bl strcat
	mr 25,23
	mr 3,20
	bl strlen
	mr 21,3
.L566:
	addi 23,23,1
	cmpwi 0,23,15
	bc 12,1,.L565
	lwz 0,6536(1)
.L604:
	cmpw 0,23,0
	bc 12,0,.L568
	lwz 0,4(16)
	cmpw 0,23,0
	bc 12,0,.L568
.L565:
	cmpw 7,24,25
	subfic 0,21,1000
	cmpwi 0,0,50
	li 17,0
	li 27,0
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,24,0
	and 0,25,0
	or 26,0,11
	slwi 9,26,3
	addi 26,9,58
	bc 4,1,.L588
	lis 9,maxclients@ha
	lis 10,.LC161@ha
	lwz 11,maxclients@l(9)
	la 10,.LC161@l(10)
	li 23,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L588
	lis 9,game@ha
	mr 22,20
	la 14,game@l(9)
	lis 15,0x4330
	li 18,0
	li 19,928
.L592:
	lis 11,g_edicts@ha
	lwz 0,g_edicts@l(11)
	lwz 11,1028(14)
	add 28,0,19
	lwz 9,88(28)
	add 31,11,18
	cmpwi 0,9,0
	bc 12,2,.L591
	lwz 0,248(28)
	cmpwi 0,0,0
	bc 4,2,.L591
	lwz 9,84(28)
	lwz 0,3532(9)
	cmpwi 0,0,0
	bc 4,2,.L591
	cmpwi 0,27,0
	bc 4,2,.L595
	lis 4,.LC157@ha
	mr 5,26
	addi 3,1,8
	la 4,.LC157@l(4)
	crxor 6,6,6
	bl sprintf
	li 27,1
	addi 26,26,8
	addi 4,1,8
	mr 3,22
	bl strcat
	mr 3,22
	bl strlen
	mr 21,3
.L595:
	addi 3,1,8
	subfic 29,21,1000
	mr 30,3
	bl strlen
	lwz 11,184(31)
	rlwinm 5,17,0,31,31
	lis 4,.LC158@ha
	cmpwi 4,5,0
	lwz 8,3528(31)
	la 4,.LC158@l(4)
	cmpwi 7,11,1000
	neg 5,5
	andi. 5,5,160
	mr 6,26
	mr 7,23
	add 3,30,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 11,11,0
	andi. 9,9,999
	or 9,11,9
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L599
	mr 4,30
	mr 3,22
	bl strcat
	mr 3,22
	bl strlen
	mr 21,3
.L599:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,26,8
	neg 0,0
	addi 17,17,1
	andc 9,9,0
	and 0,26,0
	or 26,0,9
.L591:
	lis 10,maxclients@ha
	addi 23,23,1
	lwz 11,maxclients@l(10)
	xoris 0,23,0x8000
	lis 10,.LC162@ha
	stw 0,6572(1)
	addi 18,18,4080
	la 10,.LC162@l(10)
	stw 15,6568(1)
	addi 19,19,928
	lfd 12,0(10)
	lfd 0,6568(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L592
.L588:
	lwz 0,6536(1)
	subf 0,24,0
	cmpwi 0,0,1
	bc 4,1,.L602
	mr 3,20
	bl strlen
	lwz 6,6536(1)
	slwi 5,24,3
	lis 4,.LC159@ha
	la 4,.LC159@l(4)
	addi 5,5,50
	subf 6,24,6
	add 3,20,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L602:
	lwz 0,4(16)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L603
	mr 3,20
	bl strlen
	lwz 6,4(16)
	slwi 5,25,3
	lis 4,.LC160@ha
	la 4,.LC160@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,20,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L603:
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
	lwz 0,6660(1)
	lwz 12,6580(1)
	mtlr 0
	lmw 14,6584(1)
	mtcrf 8,12
	la 1,6656(1)
	blr
.Lfe21:
	.size	 CTFScoreboardMessage,.Lfe21-CTFScoreboardMessage
	.section	".rodata"
	.align 2
.LC163:
	.string	"You already have a TECH powerup."
	.align 2
.LC164:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl CTFPickup_Tech
	.type	 CTFPickup_Tech,@function
CTFPickup_Tech:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 24,8(1)
	stw 0,52(1)
	lis 9,tnames@ha
	mr 27,3
	la 3,tnames@l(9)
	mr 30,4
	lwz 0,0(3)
	lis 25,level@ha
	cmpwi 0,0,0
	bc 12,2,.L615
	lis 9,gi@ha
	lis 31,0x286b
	la 24,gi@l(9)
	lis 11,itemlist@ha
	lis 9,.LC164@ha
	la 28,itemlist@l(11)
	la 9,.LC164@l(9)
	mr 29,3
	lfs 31,0(9)
	ori 31,31,51739
	lis 26,.LC163@ha
.L616:
	lwz 3,0(29)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L617
	subf 0,28,3
	lwz 10,84(30)
	mullw 0,0,31
	addi 11,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L617
	la 31,level@l(25)
	lfs 13,3952(10)
	lfs 0,4(31)
	fsubs 0,0,13
	fcmpu 0,0,31
	bc 4,1,.L619
	lwz 0,12(24)
	la 4,.LC163@l(26)
	mr 3,30
	mtlr 0
	crxor 6,6,6
	blrl
	lfs 0,4(31)
	lwz 9,84(30)
	stfs 0,3952(9)
.L619:
	li 3,0
	b .L621
.L617:
	lwzu 0,4(29)
	cmpwi 0,0,0
	bc 4,2,.L616
.L615:
	lwz 0,648(27)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(30)
	subf 0,9,0
	lis 8,level+4@ha
	mullw 0,0,11
	addi 10,10,740
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,level+4@l(8)
	lwz 11,84(30)
	stfs 0,3944(11)
.L621:
	lwz 0,52(1)
	mtlr 0
	lmw 24,8(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 CTFPickup_Tech,.Lfe22-CTFPickup_Tech
	.section	".rodata"
	.align 2
.LC165:
	.string	"info_player_deathmatch"
	.align 3
.LC166:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC167:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl CTFDeadDropTech
	.type	 CTFDeadDropTech,@function
CTFDeadDropTech:
	stwu 1,-96(1)
	mflr 0
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 21,36(1)
	stw 0,100(1)
	lis 9,tnames@ha
	mr 28,3
	la 3,tnames@l(9)
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L640
	lis 9,itemlist@ha
	lis 30,0x1b4e
	la 21,itemlist@l(9)
	lis 11,level@ha
	lis 9,TechThink@ha
	lis 27,0x286b
	la 23,TechThink@l(9)
	la 22,level@l(11)
	lis 9,.LC166@ha
	mr 24,3
	la 9,.LC166@l(9)
	ori 30,30,33205
	lfd 31,0(9)
	lis 25,0x4330
	li 26,0
	lis 9,.LC167@ha
	ori 27,27,51739
	la 9,.LC167@l(9)
	lfs 30,0(9)
.L641:
	lwz 3,0(24)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L642
	subf 0,21,3
	lwz 11,84(28)
	mullw 0,0,27
	addi 11,11,740
	rlwinm 31,0,0,0,29
	lwzx 9,11,31
	cmpwi 0,9,0
	bc 12,2,.L642
	mr 4,3
	mr 3,28
	bl Drop_Item
	mr 29,3
	bl rand
	mulhw 0,3,30
	srawi 9,3,31
	srawi 0,0,6
	subf 0,9,0
	mulli 0,0,600
	subf 3,0,3
	addi 3,3,-300
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,376(29)
	bl rand
	mulhw 0,3,30
	srawi 9,3,31
	srawi 0,0,6
	subf 0,9,0
	mulli 0,0,600
	subf 3,0,3
	addi 3,3,-300
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,380(29)
	lfs 13,4(22)
	stw 26,256(29)
	stw 23,436(29)
	fadds 13,13,30
	stfs 13,428(29)
	lwz 9,84(28)
	addi 9,9,740
	stwx 26,9,31
.L642:
	lwzu 0,4(24)
	cmpwi 0,0,0
	bc 4,2,.L641
.L640:
	lwz 0,100(1)
	mtlr 0
	lmw 21,36(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe23:
	.size	 CTFDeadDropTech,.Lfe23-CTFDeadDropTech
	.section	".rodata"
	.align 2
.LC168:
	.string	"ammo_grenades"
	.align 2
.LC169:
	.long 0x0
	.align 3
.LC170:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC171:
	.long 0x41800000
	.align 2
.LC172:
	.long 0x42c80000
	.section	".text"
	.align 2
	.type	 SpawnTech,@function
SpawnTech:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 29,76(1)
	stw 0,100(1)
	lis 9,compatible@ha
	lis 7,.LC169@ha
	lwz 11,compatible@l(9)
	la 7,.LC169@l(7)
	mr 30,3
	lfs 31,0(7)
	mr 29,4
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L644
	bl G_Spawn
	lwz 0,0(30)
	mr 31,3
	lis 9,0xc170
	stw 30,648(31)
	lis 11,0x4170
	lis 10,gi+44@ha
	stw 0,280(31)
	lwz 0,28(30)
	stw 9,196(31)
	stw 11,208(31)
	stw 9,188(31)
	stw 9,192(31)
	stw 11,200(31)
	stw 11,204(31)
	stw 0,64(31)
	lwz 0,gi+44@l(10)
	lwz 4,24(30)
	mtlr 0
	blrl
	lis 9,Touch_Item@ha
	li 11,1
	stw 31,256(31)
	la 9,Touch_Item@l(9)
	li 0,7
	stw 11,248(31)
	stw 0,260(31)
	stw 9,444(31)
	stfs 31,40(1)
	bl rand
	lis 0,0xb60b
	mr 9,3
	stfs 31,48(1)
	ori 0,0,24759
	srawi 10,9,31
	mulhw 0,9,0
	lis 8,0x4330
	lis 7,.LC170@ha
	addi 3,1,40
	add 0,0,9
	la 7,.LC170@l(7)
	srawi 0,0,8
	lfd 13,0(7)
	addi 4,1,8
	subf 0,10,0
	addi 5,1,24
	mulli 0,0,360
	li 6,0
	subf 9,0,9
	xoris 9,9,0x8000
	stw 9,68(1)
	stw 8,64(1)
	lfd 0,64(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,44(1)
	bl AngleVectors
	lfs 0,4(29)
	lis 7,.LC171@ha
	lis 9,.LC172@ha
	la 7,.LC171@l(7)
	la 9,.LC172@l(9)
	lfs 12,0(7)
	addi 3,1,8
	addi 4,31,376
	stfs 0,4(31)
	lfs 13,8(29)
	lfs 1,0(9)
	stfs 13,8(31)
	lfs 0,12(29)
	fadds 0,0,12
	stfs 0,12(31)
	bl VectorScale
	lis 9,explosives@ha
	lis 0,0x4396
	lwz 11,explosives@l(9)
	stw 0,384(31)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L646
	lwz 0,280(31)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	cmpw 0,0,9
	bc 12,2,.L648
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	cmpw 0,0,9
	bc 12,2,.L648
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	cmpw 0,0,9
	bc 12,2,.L648
	lis 9,.LC168@ha
	la 9,.LC168@l(9)
	cmpw 0,0,9
	bc 4,2,.L646
.L648:
	mr 3,31
	bl G_FreeEdict
.L646:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L644:
	lwz 0,100(1)
	mtlr 0
	lmw 29,76(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe24:
	.size	 SpawnTech,.Lfe24-SpawnTech
	.section	".sdata","aw"
	.align 2
	.type	 tech.161,@object
	.size	 tech.161,4
tech.161:
	.long 0
	.section	".rodata"
	.align 2
.LC174:
	.string	"item_tech1"
	.align 2
.LC175:
	.string	"ctf/tech1.wav"
	.section	".sdata","aw"
	.align 2
	.type	 tech.165,@object
	.size	 tech.165,4
tech.165:
	.long 0
	.section	".rodata"
	.align 2
.LC176:
	.string	"item_tech2"
	.section	".sdata","aw"
	.align 2
	.type	 tech.169,@object
	.size	 tech.169,4
tech.169:
	.long 0
	.section	".rodata"
	.align 2
.LC178:
	.string	"ctf/tech2x.wav"
	.align 2
.LC179:
	.string	"ctf/tech2.wav"
	.align 2
.LC177:
	.long 0x3e4ccccd
	.align 2
.LC180:
	.long 0x3f800000
	.align 3
.LC181:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC182:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyStrengthSound
	.type	 CTFApplyStrengthSound,@function
CTFApplyStrengthSound:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	lis 7,.LC180@ha
	lwz 9,84(31)
	la 7,.LC180@l(7)
	lfs 31,0(7)
	cmpwi 0,9,0
	bc 12,2,.L680
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L680
	lis 9,.LC177@ha
	lfs 31,.LC177@l(9)
.L680:
	lis 29,tech.169@ha
	lwz 0,tech.169@l(29)
	cmpwi 0,0,0
	bc 4,2,.L687
	lis 3,.LC176@ha
	la 3,.LC176@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.169@l(29)
	bc 12,2,.L682
.L687:
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L682
	lwz 0,tech.169@l(29)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,8,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L682
	lis 11,level@ha
	lfs 0,3948(8)
	la 9,level@l(11)
	lfs 13,4(9)
	fcmpu 0,0,13
	bc 4,0,.L683
	lis 7,.LC180@ha
	la 7,.LC180@l(7)
	lis 10,0x4330
	lfs 0,0(7)
	lis 7,.LC181@ha
	la 7,.LC181@l(7)
	fadds 0,13,0
	lfd 12,0(7)
	stfs 0,3948(8)
	lwz 0,level@l(11)
	lwz 11,84(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	lfs 13,3836(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L684
	lis 29,gi@ha
	lis 3,.LC178@ha
	la 29,gi@l(29)
	la 3,.LC178@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC180@ha
	lis 9,.LC182@ha
	fmr 1,31
	mr 5,3
	la 7,.LC180@l(7)
	la 9,.LC182@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
	b .L683
.L684:
	lis 29,gi@ha
	lis 3,.LC179@ha
	la 29,gi@l(29)
	la 3,.LC179@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC180@ha
	lis 9,.LC182@ha
	fmr 1,31
	mr 5,3
	la 7,.LC180@l(7)
	la 9,.LC182@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
.L683:
	li 3,1
	b .L686
.L682:
	li 3,0
.L686:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 CTFApplyStrengthSound,.Lfe25-CTFApplyStrengthSound
	.section	".sdata","aw"
	.align 2
	.type	 tech.173,@object
	.size	 tech.173,4
tech.173:
	.long 0
	.section	".rodata"
	.align 2
.LC183:
	.string	"item_tech3"
	.section	".sdata","aw"
	.align 2
	.type	 tech.177,@object
	.size	 tech.177,4
tech.177:
	.long 0
	.section	".rodata"
	.align 2
.LC185:
	.string	"ctf/tech3.wav"
	.align 2
.LC184:
	.long 0x3e4ccccd
	.align 2
.LC186:
	.long 0x3f800000
	.align 2
.LC187:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyHasteSound
	.type	 CTFApplyHasteSound,@function
CTFApplyHasteSound:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	lis 9,.LC186@ha
	mr 31,3
	la 9,.LC186@l(9)
	lfs 31,0(9)
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L692
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L692
	lis 9,.LC184@ha
	lfs 31,.LC184@l(9)
.L692:
	lis 29,tech.177@ha
	lwz 0,tech.177@l(29)
	cmpwi 0,0,0
	bc 4,2,.L695
	lis 3,.LC183@ha
	la 3,.LC183@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.177@l(29)
	bc 12,2,.L694
.L695:
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L694
	lwz 0,tech.177@l(29)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,8,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L694
	lis 9,level+4@ha
	lfs 0,3948(8)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L694
	lis 9,.LC186@ha
	lis 29,gi@ha
	la 9,.LC186@l(9)
	la 29,gi@l(29)
	lfs 0,0(9)
	lis 3,.LC185@ha
	la 3,.LC185@l(3)
	fadds 0,13,0
	stfs 0,3948(8)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC186@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC186@l(9)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC187@ha
	la 9,.LC187@l(9)
	lfs 3,0(9)
	blrl
.L694:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 CTFApplyHasteSound,.Lfe26-CTFApplyHasteSound
	.section	".sdata","aw"
	.align 2
	.type	 tech.181,@object
	.size	 tech.181,4
tech.181:
	.long 0
	.section	".rodata"
	.align 2
.LC189:
	.string	"item_tech4"
	.align 2
.LC190:
	.string	"ctf/tech4.wav"
	.align 2
.LC188:
	.long 0x3e4ccccd
	.align 2
.LC191:
	.long 0x3f800000
	.align 3
.LC192:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC193:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyRegeneration
	.type	 CTFApplyRegeneration,@function
CTFApplyRegeneration:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 30,3
	lis 9,.LC191@ha
	lwz 29,84(30)
	la 9,.LC191@l(9)
	li 28,0
	lfs 31,0(9)
	cmpwi 0,29,0
	bc 12,2,.L696
	lwz 0,3860(29)
	cmpwi 0,0,0
	bc 12,2,.L698
	lis 9,.LC188@ha
	lfs 31,.LC188@l(9)
.L698:
	lis 31,tech.181@ha
	lwz 0,tech.181@l(31)
	cmpwi 0,0,0
	bc 4,2,.L707
	lis 3,.LC189@ha
	la 3,.LC189@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.181@l(31)
	bc 12,2,.L696
.L707:
	lwz 0,tech.181@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,29,740
	mullw 0,0,11
	mr 31,10
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L696
	lis 9,level+4@ha
	lfs 0,3944(29)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L701
	stfs 13,3944(29)
	lwz 9,480(30)
	cmpwi 0,9,149
	bc 12,1,.L702
	addi 0,9,5
	cmpwi 0,0,150
	stw 0,480(30)
	bc 4,1,.L703
	li 0,150
	stw 0,480(30)
.L703:
	lfs 0,3944(29)
	lis 9,.LC192@ha
	li 28,1
	la 9,.LC192@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3944(29)
.L702:
	mr 3,30
	bl ArmorIndex
	mr. 3,3
	bc 12,2,.L701
	slwi 3,3,2
	lwzx 9,31,3
	cmpwi 0,9,149
	bc 12,1,.L701
	addi 0,9,5
	cmpwi 0,0,150
	stwx 0,31,3
	bc 4,1,.L705
	li 0,150
	stwx 0,31,3
.L705:
	lfs 0,3944(29)
	lis 9,.LC192@ha
	li 28,1
	la 9,.LC192@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3944(29)
.L701:
	cmpwi 0,28,0
	bc 12,2,.L696
	lwz 11,84(30)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3948(11)
	fcmpu 0,0,13
	bc 4,0,.L696
	lis 9,.LC191@ha
	lis 29,gi@ha
	la 9,.LC191@l(9)
	la 29,gi@l(29)
	lfs 0,0(9)
	lis 3,.LC190@ha
	la 3,.LC190@l(3)
	fadds 0,13,0
	stfs 0,3948(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC191@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC191@l(9)
	li 4,2
	lfs 2,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC193@ha
	la 9,.LC193@l(9)
	lfs 3,0(9)
	blrl
.L696:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 CTFApplyRegeneration,.Lfe27-CTFApplyRegeneration
	.section	".sdata","aw"
	.align 2
	.type	 tech.185,@object
	.size	 tech.185,4
tech.185:
	.long 0
	.section	".rodata"
	.align 2
.LC195:
	.string	"models/ctf/banner/tris.md2"
	.align 2
.LC197:
	.string	"models/ctf/banner/small.md2"
	.globl creditsmenu
	.section	".data"
	.align 2
	.type	 creditsmenu,@object
creditsmenu:
	.long .LC199
	.long 1
	.long 0
	.long 0
	.long .LC200
	.long 1
	.long 0
	.long 0
	.long .LC201
	.long 0
	.long 0
	.long 0
	.long .LC202
	.long 0
	.long 0
	.long 0
	.long .LC203
	.long 0
	.long 0
	.long 0
	.long .LC204
	.long 0
	.long 0
	.long 0
	.long .LC205
	.long 0
	.long 0
	.long 0
	.long .LC206
	.long 0
	.long 0
	.long 0
	.long .LC207
	.long 0
	.long 0
	.long 0
	.long .LC208
	.long 0
	.long 0
	.long 0
	.long .LC209
	.long 0
	.long 0
	.long 0
	.long .LC210
	.long 0
	.long 0
	.long 0
	.long .LC211
	.long 0
	.long 0
	.long 0
	.long .LC212
	.long 0
	.long 0
	.long 0
	.long .LC213
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC214
	.long 0
	.long 0
	.long CTFReturnToMain
	.section	".rodata"
	.align 2
.LC214:
	.string	"Return to Main Menu"
	.align 2
.LC213:
	.string	"CLIFFE"
	.align 2
.LC212:
	.string	"*Web page design/graphics"
	.align 2
.LC211:
	.string	"Mexican Radio"
	.align 2
.LC210:
	.string	"Igor[ROCK]"
	.align 2
.LC209:
	.string	"*Maps"
	.align 2
.LC208:
	.string	"The Dark Lord"
	.align 2
.LC207:
	.string	"*PR guy & manual designer"
	.align 2
.LC206:
	.string	"Trond Abusdal"
	.align 2
.LC205:
	.string	"*Code"
	.align 2
.LC204:
	.string	"SGT ROck"
	.align 2
.LC203:
	.string	"*Skins"
	.align 2
.LC202:
	.string	"Lantz"
	.align 2
.LC201:
	.string	"*Models"
	.align 2
.LC200:
	.string	"###terror.telefragged.com###"
	.align 2
.LC199:
	.string	"*SLAT Software`s Terror Quake"
	.size	 creditsmenu,272
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
	.long .LC199
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
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC215
	.long 0
	.long 0
	.long CTFJoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC216
	.long 0
	.long 0
	.long CTFJoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC217
	.long 0
	.long 0
	.long CTFCredits
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC218
	.long 0
	.long 0
	.long 0
	.long .LC219
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC220
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC220:
	.string	"TQ V. 1.0, 13. May"
	.align 2
.LC219:
	.string	"ENTER to select"
	.align 2
.LC218:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC217:
	.string	"Credits"
	.align 2
.LC216:
	.string	"Join the Force"
	.align 2
.LC215:
	.string	"Join the Terrorists"
	.size	 joinmenu,272
	.lcomm	levelname.216,32,4
	.lcomm	team1players.217,32,4
	.lcomm	team2players.218,32,4
	.align 2
.LC221:
	.string	"red"
	.align 2
.LC222:
	.string	"blue"
	.align 2
.LC223:
	.string	"  (%d Terrorist(s))"
	.align 2
.LC224:
	.string	"  (%d Police guy(s))"
	.align 2
.LC225:
	.long 0x0
	.align 3
.LC226:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFUpdateJoinMenu
	.type	 CTFUpdateJoinMenu,@function
CTFUpdateJoinMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,joinmenu@ha
	lis 8,.LC215@ha
	la 31,joinmenu@l(9)
	lis 11,CTFJoinTeam1@ha
	lis 9,.LC216@ha
	lis 10,CTFJoinTeam2@ha
	lis 30,ctf_forcejoin@ha
	la 8,.LC215@l(8)
	lwz 7,ctf_forcejoin@l(30)
	la 11,CTFJoinTeam1@l(11)
	la 9,.LC216@l(9)
	la 10,CTFJoinTeam2@l(10)
	stw 8,64(31)
	stw 11,76(31)
	stw 9,96(31)
	stw 10,108(31)
	lwz 3,4(7)
	cmpwi 0,3,0
	bc 12,2,.L747
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L747
	lis 4,.LC221@ha
	la 4,.LC221@l(4)
	bl strcmp
	mr. 3,3
	bc 4,2,.L748
	stw 3,108(31)
	stw 3,96(31)
	b .L747
.L748:
	lwz 9,ctf_forcejoin@l(30)
	lis 4,.LC222@ha
	la 4,.LC222@l(4)
	lwz 3,4(9)
	bl strcmp
	mr. 3,3
	bc 4,2,.L747
	stw 3,76(31)
	stw 3,64(31)
.L747:
	lis 9,g_edicts@ha
	lis 11,levelname.216@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.216@l(11)
	stb 0,levelname.216@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L751
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L752
.L751:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L752:
	lis 9,maxclients@ha
	lis 11,levelname.216+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC225@ha
	la 4,.LC225@l(4)
	stb 0,levelname.216+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L754
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC226@ha
	li 8,0
	la 9,.LC226@l(9)
	addi 10,10,1016
	lfd 13,0(9)
.L756:
	lwz 0,0(10)
	addi 10,10,928
	cmpwi 0,0,0
	bc 12,2,.L755
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,3532(9)
	cmpwi 0,11,1
	bc 4,2,.L758
	addi 30,30,1
	b .L755
.L758:
	xori 11,11,2
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L755:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,4080
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L756
.L754:
	lis 3,team1players.217@ha
	lis 4,.LC223@ha
	la 4,.LC223@l(4)
	mr 5,30
	la 3,team1players.217@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.218@ha
	lis 4,.LC224@ha
	la 3,team2players.218@l(3)
	la 4,.LC224@l(4)
	mr 5,31
	crxor 6,6,6
	bl sprintf
	lis 11,joinmenu@ha
	lis 9,levelname.216@ha
	la 11,joinmenu@l(11)
	la 9,levelname.216@l(9)
	lwz 0,64(11)
	stw 9,32(11)
	cmpwi 0,0,0
	bc 12,2,.L762
	lis 9,team1players.217@ha
	la 9,team1players.217@l(9)
	stw 9,80(11)
	b .L763
.L762:
	stw 0,80(11)
.L763:
	lis 9,joinmenu@ha
	la 11,joinmenu@l(9)
	lwz 0,96(11)
	cmpwi 0,0,0
	bc 12,2,.L764
	lis 9,team2players.218@ha
	la 9,team2players.218@l(9)
	stw 9,112(11)
	b .L765
.L764:
	stw 0,112(11)
.L765:
	cmpw 0,30,31
	bc 12,1,.L772
	cmpw 0,31,30
	bc 4,1,.L767
.L772:
	li 3,1
	b .L771
.L767:
	bl rand
	andi. 0,3,1
	mfcr 3
	rlwinm 3,3,3,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
.L771:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 CTFUpdateJoinMenu,.Lfe28-CTFUpdateJoinMenu
	.section	".rodata"
	.align 2
.LC227:
	.string	"Capturelimit hit.\n"
	.align 2
.LC228:
	.string	"Couldn't find destination\n"
	.align 2
.LC229:
	.long 0x47800000
	.align 2
.LC230:
	.long 0x43b40000
	.align 2
.LC231:
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
	bc 12,2,.L790
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L792
	lis 9,gi+4@ha
	lis 3,.LC228@ha
	lwz 0,gi+4@l(9)
	la 3,.LC228@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L790
.L792:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L794
	lwz 3,3932(3)
	cmpwi 0,3,0
	bc 12,2,.L794
	bl CTFResetGrapple
.L794:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	addi 28,31,376
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC229@ha
	lis 11,.LC230@ha
	la 9,.LC229@l(9)
	la 11,.LC230@l(11)
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
.L801:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,3560
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
	bdnz .L801
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
	stfs 0,3764(9)
	lfs 0,20(30)
	lwz 11,84(31)
	stfs 0,3768(11)
	lfs 13,24(30)
	lwz 9,84(31)
	stfs 13,3772(9)
	lwz 3,84(31)
	addi 3,3,3764
	bl AngleVectors
	lis 9,.LC231@ha
	addi 3,1,8
	la 9,.LC231@l(9)
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
.L790:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe29:
	.size	 old_teleporter_touch,.Lfe29-old_teleporter_touch
	.section	".rodata"
	.align 2
.LC232:
	.string	"teleporter without a target.\n"
	.align 2
.LC233:
	.string	"world/hum1.wav"
	.align 2
.LC234:
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
	bc 4,2,.L803
	lis 9,gi+4@ha
	lis 3,.LC232@ha
	lwz 0,gi+4@l(9)
	la 3,.LC232@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L802
.L803:
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
	lis 9,.LC234@ha
	mtctr 0
	la 9,.LC234@l(9)
	mr 30,3
	lfs 12,0(9)
	addi 8,31,200
	addi 10,31,188
	stw 30,540(31)
	addi 11,30,4
	li 9,0
.L809:
	lfsx 13,9,10
	lfsx 0,9,8
	addi 9,9,4
	fsubs 0,0,13
	fmadds 0,0,12,13
	stfs 0,0(11)
	addi 11,11,4
	bdnz .L809
	lis 29,gi@ha
	lis 3,.LC233@ha
	la 29,gi@l(29)
	la 3,.LC233@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(30)
	lwz 0,72(29)
	mr 3,30
	mtlr 0
	blrl
.L802:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 SP_trigger_teleport,.Lfe30-SP_trigger_teleport
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	ctfgame,24,4
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
	lis 3,.LC24@ha
	la 29,gi@l(29)
	lis 4,.LC25@ha
	lwz 9,144(29)
	la 4,.LC25@l(4)
	li 5,4
	la 3,.LC24@l(3)
	lis 31,flag1_item@ha
	mtlr 9
	blrl
	lwz 0,144(29)
	lis 9,ctf@ha
	lis 11,.LC26@ha
	stw 3,ctf@l(9)
	lis 4,.LC27@ha
	li 5,0
	mtlr 0
	la 3,.LC26@l(11)
	la 4,.LC27@l(4)
	blrl
	lwz 0,flag1_item@l(31)
	lis 9,ctf_forcejoin@ha
	stw 3,ctf_forcejoin@l(9)
	cmpwi 0,0,0
	bc 4,2,.L36
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(31)
.L36:
	lis 29,flag2_item@ha
	lwz 0,flag2_item@l(29)
	cmpwi 0,0,0
	bc 4,2,.L37
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
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
.Lfe31:
	.size	 CTFInit,.Lfe31-CTFInit
	.align 2
	.globl SP_info_player_team1
	.type	 SP_info_player_team1,@function
SP_info_player_team1:
	blr
.Lfe32:
	.size	 SP_info_player_team1,.Lfe32-SP_info_player_team1
	.align 2
	.globl SP_info_player_team2
	.type	 SP_info_player_team2,@function
SP_info_player_team2:
	blr
.Lfe33:
	.size	 SP_info_player_team2,.Lfe33-SP_info_player_team2
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
	lis 3,.LC30@ha
	la 3,.LC30@l(3)
	blr
.L41:
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	blr
.L39:
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
	blr
.Lfe34:
	.size	 CTFTeamName,.Lfe34-CTFTeamName
	.align 2
	.globl CTFOtherTeamName
	.type	 CTFOtherTeamName,@function
CTFOtherTeamName:
	cmpwi 0,3,1
	bc 12,2,.L46
	cmpwi 0,3,2
	bc 12,2,.L47
	b .L45
.L46:
	lis 3,.LC30@ha
	la 3,.LC30@l(3)
	blr
.L47:
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	blr
.L45:
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
	blr
.Lfe35:
	.size	 CTFOtherTeamName,.Lfe35-CTFOtherTeamName
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
	bc 12,2,.L350
	lis 9,gi+8@ha
	lis 5,.LC75@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC75@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L351
.L350:
	lis 9,gi+8@ha
	lis 5,.LC76@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC76@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L351:
	li 3,0
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 CTFDrop_Flag,.Lfe36-CTFDrop_Flag
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
	lwz 0,3556(9)
	cmpwi 0,0,0
	bc 12,2,.L389
	lis 9,gi+8@ha
	lis 5,.LC92@ha
	lwz 0,gi+8@l(9)
	la 5,.LC92@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	b .L813
.L389:
	lis 9,gi+8@ha
	lis 5,.LC93@ha
	lwz 0,gi+8@l(9)
	la 5,.LC93@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
.L813:
	stw 0,3556(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 CTFID_f,.Lfe37-CTFID_f
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,3,1
	bc 12,2,.L202
	cmpwi 0,3,2
	bc 12,2,.L203
	b .L200
.L202:
	lis 9,.LC28@ha
	la 29,.LC28@l(9)
	b .L201
.L203:
	lis 9,.LC29@ha
	la 29,.LC29@l(9)
.L201:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L206
.L208:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L209
	mr 3,31
	bl G_FreeEdict
	b .L206
.L209:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L206:
	mr 3,31
	li 4,280
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L208
.L200:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 CTFResetFlag,.Lfe38-CTFResetFlag
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
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 4,2,.L197
	lis 9,flag2_item@ha
	lwz 10,flag2_item@l(9)
	b .L198
.L197:
	lis 9,flag1_item@ha
	lwz 10,flag1_item@l(9)
.L198:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 3,84(3)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,3,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bclr 12,2
	lwz 9,3532(3)
	lwz 0,3532(8)
	cmpw 0,9,0
	bclr 12,2
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,3540(8)
	blr
.Lfe39:
	.size	 CTFCheckHurtCarrier,.Lfe39-CTFCheckHurtCarrier
	.align 2
	.globl CTFPlayerResetGrapple
	.type	 CTFPlayerResetGrapple,@function
CTFPlayerResetGrapple:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L454
	lwz 3,3932(3)
	cmpwi 0,3,0
	bc 12,2,.L454
	bl CTFResetGrapple
.L454:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 CTFPlayerResetGrapple,.Lfe40-CTFPlayerResetGrapple
	.section	".rodata"
	.align 2
.LC235:
	.long 0x3e4ccccd
	.align 2
.LC236:
	.long 0x3f800000
	.align 2
.LC237:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFResetGrapple
	.type	 CTFResetGrapple,@function
CTFResetGrapple:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L456
	lwz 0,3860(9)
	lis 9,.LC236@ha
	cmpwi 0,0,0
	la 9,.LC236@l(9)
	lfs 31,0(9)
	bc 12,2,.L457
	lis 9,.LC235@ha
	lfs 31,.LC235@l(9)
.L457:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC236@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC236@l(9)
	mr 3,30
	lfs 2,0(9)
	mtlr 0
	li 4,17
	lis 9,.LC237@ha
	la 9,.LC237@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,256(31)
	li 8,0
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 8,3932(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3936(9)
	andi. 0,0,191
	stfs 0,3940(9)
	stb 0,16(9)
	bl G_FreeEdict
.L456:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe41:
	.size	 CTFResetGrapple,.Lfe41-CTFResetGrapple
	.align 2
	.globl CTFWhat_Tech
	.type	 CTFWhat_Tech,@function
CTFWhat_Tech:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,tnames@ha
	mr 29,3
	la 3,tnames@l(9)
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L609
	lis 9,itemlist@ha
	lis 31,0x286b
	la 28,itemlist@l(9)
	mr 30,3
	ori 31,31,51739
.L610:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L611
	subf 0,28,3
	lwz 11,84(29)
	mullw 0,0,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L814
.L611:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L610
.L609:
	li 3,0
.L814:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 CTFWhat_Tech,.Lfe42-CTFWhat_Tech
	.section	".rodata"
	.align 2
.LC238:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl CTFDrop_Tech
	.type	 CTFDrop_Tech,@function
CTFDrop_Tech:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	mr 29,4
	bl Drop_Item
	lis 9,.LC238@ha
	lis 11,level+4@ha
	la 9,.LC238@l(9)
	lfs 0,level+4@l(11)
	lis 0,0x286b
	lfs 13,0(9)
	lis 11,itemlist@ha
	ori 0,0,51739
	lis 9,TechThink@ha
	la 11,itemlist@l(11)
	la 9,TechThink@l(9)
	subf 29,11,29
	fadds 0,0,13
	stw 9,436(3)
	mullw 29,29,0
	li 11,0
	rlwinm 29,29,0,0,29
	stfs 0,428(3)
	lwz 9,84(28)
	addi 9,9,740
	stwx 11,9,29
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 CTFDrop_Tech,.Lfe43-CTFDrop_Tech
	.section	".rodata"
	.align 2
.LC239:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl CTFSetupTechSpawn
	.type	 CTFSetupTechSpawn,@function
CTFSetupTechSpawn:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 31,techspawn@ha
	lwz 0,techspawn@l(31)
	cmpwi 0,0,0
	bc 4,2,.L669
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,8
	bc 4,2,.L669
	bl G_Spawn
	lis 9,.LC239@ha
	lis 11,level+4@ha
	la 9,.LC239@l(9)
	lfs 0,level+4@l(11)
	li 0,1
	lfs 13,0(9)
	lis 9,SpawnTechs@ha
	la 9,SpawnTechs@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	stw 0,techspawn@l(31)
.L669:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe44:
	.size	 CTFSetupTechSpawn,.Lfe44-CTFSetupTechSpawn
	.section	".rodata"
	.align 2
.LC240:
	.long 0x3e4ccccd
	.align 2
.LC241:
	.long 0x3f800000
	.align 2
.LC242:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyResistance
	.type	 CTFApplyResistance,@function
CTFApplyResistance:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 30,3
	lis 11,.LC241@ha
	lwz 9,84(30)
	la 11,.LC241@l(11)
	mr 31,4
	lfs 31,0(11)
	cmpwi 0,9,0
	bc 12,2,.L673
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L673
	lis 9,.LC240@ha
	lfs 31,.LC240@l(9)
.L673:
	lis 29,tech.161@ha
	lwz 0,tech.161@l(29)
	cmpwi 0,0,0
	bc 4,2,.L674
	lis 3,.LC174@ha
	la 3,.LC174@l(3)
	bl FindItemByClassname
	stw 3,tech.161@l(29)
.L674:
	cmpwi 0,31,0
	bc 12,2,.L675
	lwz 10,tech.161@l(29)
	cmpwi 0,10,0
	bc 12,2,.L675
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L675
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L675
	lis 29,gi@ha
	lis 3,.LC175@ha
	la 29,gi@l(29)
	la 3,.LC175@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC241@ha
	lis 11,.LC242@ha
	fmr 1,31
	mr 5,3
	la 9,.LC241@l(9)
	la 11,.LC242@l(11)
	mr 3,30
	lfs 2,0(9)
	mtlr 0
	li 4,2
	lfs 3,0(11)
	blrl
	srwi 3,31,31
	add 3,31,3
	srawi 3,3,1
	b .L815
.L675:
	mr 3,31
.L815:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 CTFApplyResistance,.Lfe45-CTFApplyResistance
	.align 2
	.globl CTFApplyStrength
	.type	 CTFApplyStrength,@function
CTFApplyStrength:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 31,tech.165@ha
	mr 29,3
	lwz 0,tech.165@l(31)
	mr 30,4
	cmpwi 0,0,0
	bc 4,2,.L677
	lis 3,.LC176@ha
	la 3,.LC176@l(3)
	bl FindItemByClassname
	stw 3,tech.165@l(31)
.L677:
	cmpwi 0,30,0
	bc 12,2,.L678
	lwz 11,tech.165@l(31)
	cmpwi 0,11,0
	bc 12,2,.L678
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 12,2,.L678
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,11
	mullw 9,9,0
	addi 11,3,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L678
	slwi 3,30,1
	b .L816
.L678:
	mr 3,30
.L816:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 CTFApplyStrength,.Lfe46-CTFApplyStrength
	.align 2
	.globl CTFApplyHaste
	.type	 CTFApplyHaste,@function
CTFApplyHaste:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 31,tech.173@ha
	mr 30,3
	lwz 0,tech.173@l(31)
	cmpwi 0,0,0
	bc 4,2,.L818
	lis 3,.LC183@ha
	la 3,.LC183@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.173@l(31)
	bc 12,2,.L690
.L818:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L690
	lwz 0,tech.173@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,3,740
	mullw 0,0,11
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L817
.L690:
	li 3,0
.L817:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 CTFApplyHaste,.Lfe47-CTFApplyHaste
	.align 2
	.globl CTFHasRegeneration
	.type	 CTFHasRegeneration,@function
CTFHasRegeneration:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 31,tech.185@ha
	mr 30,3
	lwz 0,tech.185@l(31)
	cmpwi 0,0,0
	bc 4,2,.L820
	lis 3,.LC189@ha
	la 3,.LC189@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.185@l(31)
	bc 12,2,.L710
.L820:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L710
	lwz 0,tech.185@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,3,740
	mullw 0,0,11
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L819
.L710:
	li 3,0
.L819:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe48:
	.size	 CTFHasRegeneration,.Lfe48-CTFHasRegeneration
	.align 2
	.globl CTFRespawnTech
	.type	 CTFRespawnTech,@function
CTFRespawnTech:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 30,0
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,3
	subf 31,11,0
	mulli 9,31,20
	subf 31,9,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L666
	lis 29,.LC165@ha
.L665:
	mr 3,30
	li 4,280
	la 5,.LC165@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L665
.L666:
	cmpwi 0,30,0
	bc 4,2,.L821
	lis 5,.LC165@ha
	li 3,0
	la 5,.LC165@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L662
.L821:
	lwz 3,648(28)
	mr 4,30
	bl SpawnTech
.L662:
	mr 3,28
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 CTFRespawnTech,.Lfe49-CTFRespawnTech
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
	lwz 0,3924(9)
	cmpwi 0,0,0
	bc 12,2,.L774
	li 5,8
	b .L775
.L774:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L775:
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
.Lfe50:
	.size	 CTFOpenJoinMenu,.Lfe50-CTFOpenJoinMenu
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
	lwz 0,3532(8)
	cmpwi 0,0,0
	bc 4,2,.L781
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 10,11,0x2
	bc 4,2,.L781
	lwz 0,184(31)
	li 9,1
	lis 11,gi+72@ha
	stw 9,260(31)
	mr 3,31
	ori 0,0,1
	stw 10,248(31)
	stw 0,184(31)
	stw 10,3532(8)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	mr 3,31
	bl CTFUpdateJoinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,3924(9)
	cmpwi 0,0,0
	bc 12,2,.L782
	li 5,8
	b .L783
.L782:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L783:
	lis 4,joinmenu@ha
	mr 3,31
	la 4,joinmenu@l(4)
	li 6,17
	bl PMenu_Open
	li 3,1
	b .L822
.L781:
	li 3,0
.L822:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe51:
	.size	 CTFStartClient,.Lfe51-CTFStartClient
	.section	".rodata"
	.align 2
.LC243:
	.long 0x0
	.align 3
.LC244:
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
	lis 11,.LC243@ha
	lis 9,capturelimit@ha
	la 11,.LC243@l(11)
	lfs 0,0(11)
	lwz 11,capturelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L788
	lis 9,ctfgame@ha
	lwz 0,ctfgame@l(9)
	la 8,ctfgame@l(9)
	lis 10,0x4330
	lis 9,.LC244@ha
	xoris 0,0,0x8000
	la 9,.LC244@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L789
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
	bc 4,3,.L788
.L789:
	lis 9,gi@ha
	lis 4,.LC227@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC227@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L823
.L788:
	li 3,0
.L823:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe52:
	.size	 CTFCheckRules,.Lfe52-CTFCheckRules
	.section	".rodata"
	.align 3
.LC245:
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
	lis 3,.LC195@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC195@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L713
	li 0,1
	stw 0,60(31)
.L713:
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
	lis 11,.LC245@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC245@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe53:
	.size	 SP_misc_ctf_banner,.Lfe53-SP_misc_ctf_banner
	.section	".rodata"
	.align 3
.LC246:
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
	lis 3,.LC197@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC197@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L715
	li 0,1
	stw 0,60(31)
.L715:
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
	lis 11,.LC246@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC246@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe54:
	.size	 SP_misc_ctf_small_banner,.Lfe54-SP_misc_ctf_small_banner
	.section	".rodata"
	.align 2
.LC247:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	lis 9,.LC247@ha
	lfs 0,12(3)
	la 9,.LC247@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe55:
	.size	 SP_info_teleport_destination,.Lfe55-SP_info_teleport_destination
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
.Lfe56:
	.size	 stuffcmd,.Lfe56-stuffcmd
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.comm	ctf_forcejoin,4,4
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
	.globl CTFOtherTeam
	.type	 CTFOtherTeam,@function
CTFOtherTeam:
	cmpwi 0,3,1
	bc 12,2,.L52
	cmpwi 0,3,2
	bc 12,2,.L53
	b .L51
.L52:
	li 3,2
	blr
.L53:
	li 3,1
	blr
.L51:
	li 3,-1
	blr
.Lfe57:
	.size	 CTFOtherTeam,.Lfe57-CTFOtherTeam
	.section	".rodata"
	.align 2
.LC248:
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
	bc 4,2,.L292
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC248@ha
	lfs 13,level+4@l(9)
	la 11,.LC248@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L291
.L292:
	bl Touch_Item
.L291:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe58:
	.size	 CTFDropFlagTouch,.Lfe58-CTFDropFlagTouch
	.section	".rodata"
	.align 3
.LC249:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC250:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC251:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl CTFFireGrapple
	.type	 CTFFireGrapple,@function
CTFFireGrapple:
	stwu 1,-112(1)
	mflr 0
	stmw 24,80(1)
	stw 0,116(1)
	mr 30,5
	mr 27,3
	mr 29,4
	mr 26,8
	mr 25,6
	mr 28,7
	mr 3,30
	bl VectorNormalize
	bl G_Spawn
	lfs 0,0(29)
	mr 31,3
	mr 3,30
	addi 4,31,16
	addi 24,31,4
	stfs 0,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,28(31)
	lfs 13,4(29)
	stfs 13,32(31)
	lfs 0,8(29)
	stfs 0,36(31)
	bl vectoangles
	xoris 28,28,0x8000
	stw 28,76(1)
	lis 0,0x4330
	lis 11,.LC249@ha
	stw 0,72(1)
	la 11,.LC249@l(11)
	addi 4,31,376
	lfd 0,0(11)
	mr 3,30
	lfd 1,72(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	li 9,0
	li 10,8
	li 8,2
	stw 9,200(31)
	ori 0,0,3
	or 11,11,26
	stw 10,260(31)
	lis 29,gi@ha
	stw 8,248(31)
	lis 3,.LC126@ha
	la 29,gi@l(29)
	stw 0,252(31)
	la 3,.LC126@l(3)
	stw 11,64(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,CTFGrappleTouch@ha
	stw 3,40(31)
	li 0,0
	la 9,CTFGrappleTouch@l(9)
	stw 25,516(31)
	mr 3,31
	stw 9,444(31)
	stw 27,256(31)
	lwz 9,84(27)
	stw 31,3932(9)
	lwz 11,84(27)
	stw 0,3936(11)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 0,48(29)
	lis 9,0x600
	addi 4,27,4
	ori 9,9,3
	addi 3,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 7,24
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC250@ha
	la 9,.LC250@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L493
	lis 11,.LC251@ha
	mr 3,24
	la 11,.LC251@l(11)
	mr 5,3
	lfs 1,0(11)
	mr 4,30
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L493:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe59:
	.size	 CTFFireGrapple,.Lfe59-CTFFireGrapple
	.align 2
	.globl CTFWeapon_Grapple_Fire
	.type	 CTFWeapon_Grapple_Fire,@function
CTFWeapon_Grapple_Fire:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+8@ha
	mr 29,3
	lwz 0,gi+8@l(9)
	lis 5,.LC137@ha
	li 4,2
	la 5,.LC137@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,vec3_origin@ha
	mr 3,29
	la 4,vec3_origin@l(4)
	li 5,10
	li 6,0
	bl CTFGrappleFire
	lwz 11,84(29)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe60:
	.size	 CTFWeapon_Grapple_Fire,.Lfe60-CTFWeapon_Grapple_Fire
	.section	".rodata"
	.align 2
.LC252:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl CTFHasTech
	.type	 CTFHasTech,@function
CTFHasTech:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level@ha
	lwz 11,84(31)
	la 30,level@l(9)
	lfs 0,4(30)
	lis 9,.LC252@ha
	lfs 13,3952(11)
	la 9,.LC252@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L606
	lis 9,gi+12@ha
	lis 4,.LC163@ha
	lwz 0,gi+12@l(9)
	la 4,.LC163@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lfs 0,4(30)
	lwz 9,84(31)
	stfs 0,3952(9)
.L606:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe61:
	.size	 CTFHasTech,.Lfe61-CTFHasTech
	.section	".rodata"
	.align 2
.LC253:
	.long 0x42700000
	.section	".text"
	.align 2
	.type	 TechThink,@function
TechThink:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 30,0
	bl rand
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,3
	subf 31,11,0
	mulli 9,31,20
	subf 31,9,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L633
	lis 28,.LC165@ha
.L632:
	mr 3,30
	li 4,280
	la 5,.LC165@l(28)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L632
.L633:
	cmpwi 0,30,0
	bc 4,2,.L825
	lis 5,.LC165@ha
	li 3,0
	la 5,.LC165@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L629
.L825:
	lwz 3,648(29)
	mr 4,30
	bl SpawnTech
	mr 3,29
	bl G_FreeEdict
	b .L636
.L629:
	lis 9,.LC253@ha
	lis 11,level+4@ha
	la 9,.LC253@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,TechThink@ha
	la 9,TechThink@l(9)
	fadds 0,0,13
	stw 9,436(29)
	stfs 0,428(29)
.L636:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe62:
	.size	 TechThink,.Lfe62-TechThink
	.align 2
	.type	 SpawnTechs,@function
SpawnTechs:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,tnames@ha
	li 31,0
	la 9,tnames@l(9)
	lwzx 0,9,31
	cmpwi 0,0,0
	bc 12,2,.L651
	lis 27,0x6666
	mr 25,9
	ori 27,27,26215
	lis 24,.LC165@ha
.L652:
	slwi 0,31,2
	addi 26,31,1
	lwzx 3,25,0
	bl FindItemByClassname
	mr. 28,3
	bc 12,2,.L653
	bl rand
	li 30,0
	mulhw 0,3,27
	srawi 11,3,31
	srawi 0,0,3
	subf 31,11,0
	mulli 9,31,20
	subf 31,9,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L657
	lis 29,.LC165@ha
.L656:
	mr 3,30
	li 4,280
	la 5,.LC165@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L656
.L657:
	cmpwi 0,30,0
	bc 4,2,.L826
	li 3,0
	li 4,280
	la 5,.LC165@l(24)
	bl G_Find
	mr. 30,3
	bc 12,2,.L653
.L826:
	mr 3,28
	mr 4,30
	bl SpawnTech
.L653:
	mr 31,26
	slwi 0,31,2
	lwzx 9,25,0
	cmpwi 0,9,0
	bc 4,2,.L652
.L651:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe63:
	.size	 SpawnTechs,.Lfe63-SpawnTechs
	.section	".rodata"
	.align 3
.LC254:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 misc_ctf_banner_think,@function
misc_ctf_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC254@ha
	lfd 13,.LC254@l(11)
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
.Lfe64:
	.size	 misc_ctf_banner_think,.Lfe64-misc_ctf_banner_think
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
	lis 4,.LC146@ha
	lwz 11,84(29)
	la 4,.LC146@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 31,3532(11)
	lwz 9,84(29)
	stw 10,3536(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
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
	bc 12,2,.L717
	cmpwi 0,31,2
	bc 12,2,.L718
	b .L721
.L717:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L720
.L718:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L720
.L721:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
.L720:
	lwz 0,0(10)
	lis 4,.LC147@ha
	li 3,2
	la 4,.LC147@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe65:
	.size	 CTFJoinTeam,.Lfe65-CTFJoinTeam
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
	lis 4,.LC146@ha
	lwz 11,84(29)
	la 4,.LC146@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,3532(11)
	lwz 9,84(29)
	stw 10,3536(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 6,.LC30@ha
	lis 4,.LC147@ha
	lwz 9,84(29)
	la 4,.LC147@l(4)
	la 6,.LC30@l(6)
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
.Lfe66:
	.size	 CTFJoinTeam1,.Lfe66-CTFJoinTeam1
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
	lis 4,.LC146@ha
	lwz 11,84(29)
	la 4,.LC146@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,3532(11)
	lwz 9,84(29)
	stw 10,3536(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 6,.LC31@ha
	lis 4,.LC147@ha
	lwz 9,84(29)
	la 4,.LC147@l(4)
	la 6,.LC31@l(6)
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
.Lfe67:
	.size	 CTFJoinTeam2,.Lfe67-CTFJoinTeam2
	.section	".rodata"
	.align 3
.LC255:
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
	lwz 0,3924(9)
	cmpwi 0,0,0
	bc 12,2,.L737
	li 0,0
	stw 0,3924(9)
	bl PMenu_Close
	b .L736
.L737:
	li 8,1
	b .L738
.L740:
	addi 8,8,1
.L738:
	xoris 0,8,0x8000
	lis 9,0x4330
	stw 0,20(1)
	lis 11,.LC255@ha
	la 11,.LC255@l(11)
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
	bc 4,3,.L736
	lis 9,g_edicts@ha
	mulli 11,8,928
	lwz 0,g_edicts@l(9)
	add 11,0,11
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L740
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L740
	lwz 9,84(31)
	mr 3,31
	stw 11,3924(9)
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,3928(9)
.L736:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe68:
	.size	 CTFChaseCam,.Lfe68-CTFChaseCam
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
.Lfe69:
	.size	 CTFReturnToMain,.Lfe69-CTFReturnToMain
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
	li 6,17
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe70:
	.size	 CTFCredits,.Lfe70-CTFCredits
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
	stw 0,3616(11)
	lwz 9,84(29)
	stw 10,3628(9)
	bl DeathmatchScoreboard
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe71:
	.size	 CTFShowScores,.Lfe71-CTFShowScores
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
