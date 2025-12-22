	.file	"g_ctf.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC0:
	.string	"Cannot enter chasecam mode as Predator\n"
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFChaseCam
	.type	 CTFChaseCam,@function
CTFChaseCam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lwz 30,896(31)
	cmpwi 0,30,0
	bc 12,2,.L7
	lis 9,gi+12@ha
	lis 4,.LC0@ha
	lwz 0,gi+12@l(9)
	la 4,.LC0@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L7:
	lwz 0,184(31)
	li 9,1
	lis 10,gi+72@ha
	lwz 11,84(31)
	mr 3,31
	ori 0,0,1
	stw 9,260(31)
	stw 0,184(31)
	stw 30,248(31)
	stw 30,88(11)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 30,492(31)
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,2,.L8
	mr 3,31
	stw 30,3812(9)
	bl PMenu_Close
	mr 3,31
	crxor 6,6,6
	bl Cmd_Observe_f
	b .L6
.L8:
	li 8,1
	b .L9
.L11:
	addi 8,8,1
.L9:
	xoris 0,8,0x8000
	lis 9,0x4330
	stw 0,20(1)
	lis 11,.LC1@ha
	la 11,.LC1@l(11)
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
	bc 4,3,.L6
	lis 9,g_edicts@ha
	mulli 11,8,952
	lwz 0,g_edicts@l(9)
	add 11,0,11
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L11
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L11
	lwz 9,84(31)
	mr 3,31
	stw 11,3812(9)
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,3816(9)
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 CTFChaseCam,.Lfe1-CTFChaseCam
	.section	".rodata"
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC3:
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
	bc 4,2,.L17
	b .L27
.L26:
	li 3,1
	b .L25
.L17:
	mr 10,3
	lfs 12,188(3)
	addi 11,3,188
	lfsu 9,4(10)
	addi 8,3,200
	lis 9,.LC2@ha
	lfs 7,200(3)
	la 9,.LC2@l(9)
	lfd 6,0(9)
	lis 6,0x4330
	addi 28,1,168
	fadds 8,9,12
	lis 9,gi@ha
	lis 27,vec3_origin@ha
	fadds 9,9,7
	la 26,gi@l(9)
	addi 31,1,72
	lis 9,.LC3@ha
	addi 29,1,156
	stfs 8,72(1)
	fsubs 12,8,12
	la 9,.LC3@l(9)
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
.L22:
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
	bc 12,2,.L26
	addi 31,31,12
	cmpw 0,31,29
	bc 4,1,.L22
.L27:
	li 3,0
.L25:
	lwz 0,228(1)
	mtlr 0
	lmw 26,192(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe2:
	.size	 loc_CanSee,.Lfe2-loc_CanSee
	.globl loc_names
	.section	".data"
	.align 2
	.type	 loc_names,@object
loc_names:
	.long .LC4
	.long 1
	.long .LC5
	.long 1
	.long .LC6
	.long 2
	.long .LC7
	.long 2
	.long .LC8
	.long 3
	.long .LC9
	.long 4
	.long .LC10
	.long 4
	.long .LC11
	.long 4
	.long .LC12
	.long 4
	.long .LC13
	.long 4
	.long .LC14
	.long 4
	.long .LC15
	.long 4
	.long .LC16
	.long 4
	.long .LC17
	.long 5
	.long .LC18
	.long 5
	.long .LC19
	.long 6
	.long .LC20
	.long 6
	.long .LC21
	.long 6
	.long .LC22
	.long 7
	.long .LC23
	.long 7
	.long .LC24
	.long 7
	.long .LC25
	.long 7
	.long .LC26
	.long 8
	.long .LC27
	.long 8
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC27:
	.string	"item_pack"
	.align 2
.LC26:
	.string	"item_bandolier"
	.align 2
.LC25:
	.string	"item_adrenaline"
	.align 2
.LC24:
	.string	"item_enviro"
	.align 2
.LC23:
	.string	"item_breather"
	.align 2
.LC22:
	.string	"item_silencer"
	.align 2
.LC21:
	.string	"item_armor_jacket"
	.align 2
.LC20:
	.string	"item_armor_combat"
	.align 2
.LC19:
	.string	"item_armor_body"
	.align 2
.LC18:
	.string	"item_power_shield"
	.align 2
.LC17:
	.string	"item_power_screen"
	.align 2
.LC16:
	.string	"weapon_shotgun"
	.align 2
.LC15:
	.string	"weapon_supershotgun"
	.align 2
.LC14:
	.string	"weapon_machinegun"
	.align 2
.LC13:
	.string	"weapon_grenadelauncher"
	.align 2
.LC12:
	.string	"weapon_chaingun"
	.align 2
.LC11:
	.string	"weapon_hyperblaster"
	.align 2
.LC10:
	.string	"weapon_rocketlauncher"
	.align 2
.LC9:
	.string	"weapon_railgun"
	.align 2
.LC8:
	.string	"weapon_bfg"
	.align 2
.LC7:
	.string	"item_invulnerability"
	.align 2
.LC6:
	.string	"item_quad"
	.align 2
.LC5:
	.string	"item_flag_team2"
	.align 2
.LC4:
	.string	"item_flag_team1"
	.size	 loc_names,200
	.align 2
.LC29:
	.string	"nowhere"
	.align 2
.LC30:
	.string	"in the water "
	.align 2
.LC31:
	.string	"above "
	.align 2
.LC32:
	.string	"below "
	.align 2
.LC33:
	.string	"near "
	.align 2
.LC34:
	.string	"the "
	.align 2
.LC35:
	.string	"IR goggles"
	.align 2
.LC36:
	.string	"Combat Armor"
	.align 2
.LC28:
	.long 0x497423f0
	.align 2
.LC37:
	.long 0x44800000
	.align 3
.LC38:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC39:
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
	stmw 16,48(1)
	stw 0,132(1)
	stw 12,44(1)
	lis 9,loc_names+4@ha
	lis 11,.LC28@ha
	la 20,loc_names+4@l(9)
	lfs 31,.LC28@l(11)
	mr 27,3
	lis 9,.LC37@ha
	addi 17,20,-4
	la 9,.LC37@l(9)
	addi 18,27,4
	lfs 30,0(9)
	mr 26,4
	li 28,0
	li 25,0
	li 23,999
	li 22,0
	addi 19,1,24
	lis 21,g_edicts@ha
	lis 16,globals@ha
.L44:
	cmpwi 0,28,0
	bc 4,2,.L47
	lwz 31,g_edicts@l(21)
	b .L48
.L84:
	mr 28,31
	b .L60
.L47:
	addi 31,28,952
.L48:
	la 11,globals@l(16)
	lwz 9,g_edicts@l(21)
	lwz 0,72(11)
	mulli 0,0,952
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L61
	mr 24,11
	addi 28,31,188
	addi 30,31,200
	addi 29,31,4
.L51:
	lwz 0,-112(30)
	cmpwi 0,0,0
	bc 12,2,.L53
	li 0,3
	lis 9,.LC38@ha
	mtctr 0
	la 9,.LC38@l(9)
	mr 8,29
	lfd 10,0(9)
	mr 10,28
	mr 11,30
	li 9,0
.L85:
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
	bdnz .L85
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,30
	bc 4,1,.L84
.L53:
	lwz 9,72(24)
	addi 31,31,952
	addi 28,28,952
	lwz 0,g_edicts@l(21)
	addi 30,30,952
	addi 29,29,952
	mulli 9,9,952
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L51
.L61:
	li 28,0
.L60:
	cmpwi 0,28,0
	bc 12,2,.L45
	li 31,0
	b .L62
.L64:
	addi 31,31,1
.L62:
	slwi 29,31,3
	lwzx 4,17,29
	mr 30,29
	cmpwi 0,4,0
	bc 12,2,.L44
	lwz 3,280(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L64
	lwzx 0,17,30
	cmpwi 0,0,0
	bc 12,2,.L44
	mr 3,28
	mr 4,27
	bl loc_CanSee
	cmpwi 7,22,0
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,9,0
	bc 12,2,.L69
	mr 25,28
	lfs 0,4(27)
	addi 3,1,8
	lfs 13,4(25)
	li 22,1
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 13,13,0
	lwzx 23,20,30
	stfs 13,8(1)
	lfs 0,8(25)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(25)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fmr 31,1
	b .L44
.L69:
	cmpwi 4,3,0
	addic 0,22,-1
	subfe 9,0,22
	mfcr 0
	rlwinm 0,0,19,1
	and. 11,9,0
	bc 4,2,.L44
	bc 12,30,.L71
	lwzx 0,20,30
	cmpw 0,23,0
	bc 12,0,.L44
.L71:
	lfs 0,4(27)
	addi 3,1,8
	lfs 13,4(28)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(28)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(28)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L73
	bc 12,18,.L44
	lwzx 0,20,29
	cmpw 0,0,23
	bc 4,0,.L44
.L73:
	mr 25,28
	fmr 31,1
	mr 4,27
	mr 3,25
	mr 23,31
	bl loc_CanSee
	mr 22,3
	b .L44
.L45:
	cmpwi 0,25,0
	bc 12,2,.L86
	lwz 3,280(25)
	bl FindItemByClassname
	mr. 31,3
	bc 4,2,.L75
.L86:
	lis 9,.LC29@ha
	la 11,.LC29@l(9)
	lwz 0,.LC29@l(9)
	lwz 10,4(11)
	stw 0,0(26)
	stw 10,4(26)
	b .L43
.L75:
	lwz 0,612(27)
	cmpwi 0,0,0
	bc 12,2,.L76
	lis 11,.LC30@ha
	lwz 10,.LC30@l(11)
	la 9,.LC30@l(11)
	lhz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,0(26)
	stw 0,4(26)
	stw 11,8(26)
	sth 8,12(26)
	b .L77
.L76:
	stb 0,0(26)
.L77:
	lfs 13,4(25)
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(25)
	fsubs 10,12,13
	fabs 0,0
	stfs 10,12(1)
	lfs 13,12(25)
	fsubs 11,11,13
	fmr 12,11
	stfs 11,16(1)
	fabs 12,12
	fcmpu 0,12,0
	bc 4,1,.L78
	fmr 0,10
	fabs 0,0
	fcmpu 0,12,0
	bc 4,1,.L78
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L79
	lis 4,.LC31@ha
	mr 3,26
	la 4,.LC31@l(4)
	bl strcat
	b .L81
.L79:
	lis 4,.LC32@ha
	mr 3,26
	la 4,.LC32@l(4)
	bl strcat
	b .L81
.L78:
	lis 4,.LC33@ha
	mr 3,26
	la 4,.LC33@l(4)
	bl strcat
.L81:
	lis 4,.LC34@ha
	mr 3,26
	la 4,.LC34@l(4)
	bl strcat
	lwz 3,40(31)
	lis 4,.LC35@ha
	la 4,.LC35@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L82
	bl getIREffectTime
	cmpwi 0,3,0
	bc 4,2,.L82
	lis 4,.LC36@ha
	mr 3,26
	la 4,.LC36@l(4)
	bl strcat
	b .L43
.L82:
	lwz 4,40(31)
	mr 3,26
	bl strcat
.L43:
	lwz 0,132(1)
	lwz 12,44(1)
	mtlr 0
	lmw 16,48(1)
	lfd 30,112(1)
	lfd 31,120(1)
	mtcrf 8,12
	la 1,128(1)
	blr
.Lfe3:
	.size	 CTFSay_Team_Location,.Lfe3-CTFSay_Team_Location
	.section	".rodata"
	.align 2
.LC40:
	.string	", "
	.align 2
.LC41:
	.string	" and "
	.align 2
.LC42:
	.string	"no one"
	.align 2
.LC43:
	.long 0x3f800000
	.align 3
.LC44:
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
	lis 9,.LC43@ha
	stb 27,1032(1)
	li 24,1
	la 9,.LC43@l(9)
	stb 27,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L89
	lis 11,.LC44@ha
	lis 20,g_edicts@ha
	la 11,.LC44@l(11)
	lis 21,.LC40@ha
	lfd 31,0(11)
	lis 22,0x4330
	li 25,952
.L91:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,26
	subfic 11,0,0
	adde 0,11,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L90
	mr 3,30
	mr 4,26
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L90
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L94
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L95
	cmpwi 0,27,0
	bc 12,2,.L96
	addi 3,1,8
	la 4,.LC40@l(21)
	bl strcat
.L96:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L95:
	addi 27,27,1
.L94:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
.L90:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	addi 25,25,952
	stw 0,2076(1)
	stw 22,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L91
.L89:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L98
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L99
	cmpwi 0,27,0
	bc 12,2,.L100
	lis 4,.LC41@ha
	addi 3,1,8
	la 4,.LC41@l(4)
	bl strcat
.L100:
	mr 4,31
	addi 3,1,8
	bl strcat
.L99:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L101
.L98:
	lis 9,.LC42@ha
	lwz 10,.LC42@l(9)
	la 11,.LC42@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L101:
	lwz 0,2148(1)
	mtlr 0
	lmw 19,2084(1)
	lfd 31,2136(1)
	la 1,2144(1)
	blr
.Lfe4:
	.size	 CTFSay_Team_Sight,.Lfe4-CTFSay_Team_Sight
	.section	".rodata"
	.align 2
.LC45:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC46:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC47:
	.string	"(%s): %s\n"
	.align 2
.LC48:
	.long 0x0
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC50:
	.long 0x3f800000
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
	mr 29,4
	li 31,0
	lbz 0,0(29)
	mr 28,3
	stb 31,8(1)
	cmpwi 0,0,34
	bc 4,2,.L103
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
	addi 29,29,1
.L103:
	lbz 9,0(29)
	addi 31,1,8
	mr 27,31
	cmpwi 0,9,0
	bc 12,2,.L105
	addi 30,1,1032
.L107:
	cmpwi 0,9,37
	bc 4,2,.L109
	lbzu 0,1(29)
	cmpwi 0,0,78
	bc 12,2,.L114
	bc 12,1,.L117
	cmpwi 0,0,76
	bc 12,2,.L112
	b .L115
.L117:
	cmpwi 0,0,108
	bc 12,2,.L112
	cmpwi 0,0,110
	bc 12,2,.L114
	b .L115
.L112:
	mr 3,28
	mr 4,30
	bl CTFSay_Team_Location
	b .L130
.L114:
	mr 3,28
	mr 4,30
	bl CTFSay_Team_Sight
.L130:
	mr 3,31
	mr 4,30
	bl strcpy
	mr 3,30
	bl strlen
	add 31,31,3
	b .L106
.L115:
	lbz 0,0(29)
	stb 0,0(31)
	b .L131
.L109:
	stb 9,0(31)
.L131:
	addi 31,31,1
.L106:
	lbzu 9,1(29)
	cmpwi 0,9,0
	bc 12,2,.L105
	subf 0,27,31
	cmplwi 0,0,1022
	bc 4,1,.L107
.L105:
	lis 9,flood_msgs@ha
	li 0,0
	lwz 11,flood_msgs@l(9)
	lis 9,.LC48@ha
	stb 0,0(31)
	la 9,.LC48@l(9)
	lfs 9,20(11)
	lfs 8,0(9)
	fcmpu 0,9,8
	bc 12,2,.L120
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3760(7)
	fcmpu 0,10,0
	bc 4,0,.L121
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC45@ha
	mr 3,28
	la 5,.LC45@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	b .L132
.L121:
	lwz 0,3804(7)
	lis 10,0x4330
	lis 11,.LC49@ha
	addi 8,7,3764
	mr 6,0
	la 11,.LC49@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2068(1)
	lis 11,.LC50@ha
	stw 10,2064(1)
	la 11,.LC50@l(11)
	lfd 0,2064(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2064(1)
	lwz 31,2068(1)
	nor 0,31,31
	addi 9,31,10
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
	slwi 11,31,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L123
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L123
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC46@ha
	mr 3,28
	la 5,.LC46@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3760(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2064(1)
.L132:
	lwz 6,2068(1)
	crxor 6,6,6
	blrl
	b .L102
.L123:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3804(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L120:
	lis 11,.LC48@ha
	lis 9,maxclients@ha
	la 11,.LC48@l(11)
	li 31,0
	lfs 13,0(11)
	lis 24,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L102
	lis 9,gi@ha
	lis 25,g_edicts@ha
	la 26,gi@l(9)
	lis 27,.LC47@ha
	lis 9,.LC49@ha
	lis 29,0x4330
	la 9,.LC49@l(9)
	li 30,952
	lfd 31,0(9)
.L127:
	lwz 0,g_edicts@l(25)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L126
	lwz 6,84(28)
	li 4,3
	la 5,.LC47@l(27)
	lwz 9,8(26)
	addi 7,1,8
	addi 6,6,700
	mtlr 9
	crxor 6,6,6
	blrl
.L126:
	addi 31,31,1
	lwz 11,maxclients@l(24)
	xoris 0,31,0x8000
	addi 30,30,952
	stw 0,2068(1)
	stw 29,2064(1)
	lfd 0,2064(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L127
.L102:
	lwz 0,2116(1)
	mtlr 0
	lmw 24,2072(1)
	lfd 31,2104(1)
	la 1,2112(1)
	blr
.Lfe5:
	.size	 CTFSay_Team,.Lfe5-CTFSay_Team
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
