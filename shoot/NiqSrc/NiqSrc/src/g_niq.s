	.file	"g_niq.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl motdlines
	.type	 motdlines,@object
	.size	 motdlines,164
motdlines:
	.string	""
	.space	40
	.string	""
	.space	40
	.string	""
	.space	40
	.string	""
	.space	40
	.section	".sdata","aw"
	.align 2
	.type	 g_nSBLineNum,@object
	.size	 g_nSBLineNum,4
g_nSBLineNum:
	.long 0
	.align 2
	.type	 g_helpptr,@object
	.size	 g_helpptr,4
g_helpptr:
	.long 0
	.globl niq_prevwsecs
	.align 2
	.type	 niq_prevwsecs,@object
	.size	 niq_prevwsecs,4
niq_prevwsecs:
	.long 0xbf800000
	.globl szWelcomeStrNIQ
	.section	".data"
	.align 2
	.type	 szWelcomeStrNIQ,@object
	.size	 szWelcomeStrNIQ,33
szWelcomeStrNIQ:
	.string	"Welcome to NIQ x.xx for Quake II"
	.globl szWelcomeStr1NIQ
	.align 2
	.type	 szWelcomeStr1NIQ,@object
	.size	 szWelcomeStr1NIQ,38
szWelcomeStr1NIQ:
	.string	"This is NIQ Version x.xx for Quake II"
	.globl szWelcomeStr2NIQ
	.align 2
	.type	 szWelcomeStr2NIQ,@object
	.size	 szWelcomeStr2NIQ,35
szWelcomeStr2NIQ:
	.string	"NIQ code: Mike (Artful Dodger) Fox"
	.globl szWelcomeStr3NIQ
	.align 2
	.type	 szWelcomeStr3NIQ,@object
	.size	 szWelcomeStr3NIQ,31
szWelcomeStr3NIQ:
	.string	"Bot code: Ryan (Ridah) Feltrin"
	.globl szWelcomeStr4NIQ
	.align 2
	.type	 szWelcomeStr4NIQ,@object
	.size	 szWelcomeStr4NIQ,29
szWelcomeStr4NIQ:
	.string	"Other: See the NIQ web site."
	.globl szNIQCTFMENUStr1
	.align 2
	.type	 szNIQCTFMENUStr1,@object
	.size	 szNIQCTFMENUStr1,21
szNIQCTFMENUStr1:
	.string	"*Quake II (NIQ x.xx)"
	.globl szNIQCTFMENUStr2
	.align 2
	.type	 szNIQCTFMENUStr2,@object
	.size	 szNIQCTFMENUStr2,24
szNIQCTFMENUStr2:
	.string	"*(NIQ x.xx by Mike Fox)"
	.globl szNIQTitle_NIQ
	.align 2
	.type	 szNIQTitle_NIQ,@object
	.size	 szNIQTitle_NIQ,9
szNIQTitle_NIQ:
	.string	"NIQ x.xx"
	.globl szContact1
	.align 2
	.type	 szContact1,@object
	.size	 szContact1,41
szContact1:
	.string	"Check out the official NIQ home page at:"
	.globl szContact2
	.align 2
	.type	 szContact2,@object
	.size	 szContact2,24
szContact2:
	.string	"www.planetquake.com/niq"
	.globl szContact3
	.align 2
	.type	 szContact3,@object
	.size	 szContact3,35
szContact3:
	.string	"Send Comments/Suggestions/Bugs to:"
	.globl szContact4
	.align 2
	.type	 szContact4,@object
	.size	 szContact4,19
szContact4:
	.string	"mfox@legendent.com"
	.globl szPrompt0
	.align 2
	.type	 szPrompt0,@object
	.size	 szPrompt0,36
szPrompt0:
	.string	"You are currently in observer mode."
	.globl szPrompt1
	.align 2
	.type	 szPrompt1,@object
	.size	 szPrompt1,41
szPrompt1:
	.string	"Use [ or ] to change screens, Esc exits."
	.globl szBlank1
	.align 2
	.type	 szBlank1,@object
	.size	 szBlank1,12
szBlank1:
	.string	"(observing)"
	.globl szBlank2
	.align 2
	.type	 szBlank2,@object
	.size	 szBlank2,12
szBlank2:
	.string	"Use [ ] Esc"
	.globl szNIQTitle_320A
	.align 2
	.type	 szNIQTitle_320A,@object
	.size	 szNIQTitle_320A,41
szNIQTitle_320A:
	.string	"Name          KLS KLD SUI PING PPH SCORE"
	.globl szNIQTitle_320B
	.align 2
	.type	 szNIQTitle_320B,@object
	.size	 szNIQTitle_320B,41
szNIQTitle_320B:
	.string	"Name     KLS KLD SUI TIME PING PPH SCORE"
	.globl szNIQTitle_320C
	.align 2
	.type	 szNIQTitle_320C,@object
	.size	 szNIQTitle_320C,41
szNIQTitle_320C:
	.string	"Name            TIME PING PPH RANK SCORE"
	.globl szNIQTitle_320D
	.align 2
	.type	 szNIQTitle_320D,@object
	.size	 szNIQTitle_320D,41
szNIQTitle_320D:
	.string	"Name          DFAVG DFCUR PING PPH SCORE"
	.globl szNIQTitle_320E
	.align 2
	.type	 szNIQTitle_320E,@object
	.size	 szNIQTitle_320E,41
szNIQTitle_320E:
	.string	"Name    DFAV DFCU KLS KLD SUI PING SCORE"
	.globl szNIQTitle_512A
	.align 2
	.type	 szNIQTitle_512A,@object
	.size	 szNIQTitle_512A,65
szNIQTitle_512A:
	.string	"Name            DFAVG DFCUR KLS KLD SUI TIME PING PPH RANK SCORE"
	.globl szNIQTitle_640A
	.align 2
	.type	 szNIQTitle_640A,@object
	.size	 szNIQTitle_640A,81
szNIQTitle_640A:
	.string	"Name            WEAP HLTH AMMO  DFAVG DFCUR KLS KLD SUI TIME PING PPH RANK SCORE"
	.globl szSBHelp
	.align 2
	.type	 szSBHelp,@object
	.size	 szSBHelp,22
szSBHelp:
	.string	"(type nhelp for help)"
	.globl szHUDLabelStr
	.align 2
	.type	 szHUDLabelStr,@object
	.size	 szHUDLabelStr,83
szHUDLabelStr:
	.string	"xr -42 yt 2 string2 \"SCORE\" xr -26 yt 42 string2 \"PPH\" xr -34 yt 82 string2 \"RANK\""
	.globl num_view_weapons
	.section	".sdata","aw"
	.align 2
	.type	 num_view_weapons,@object
	.size	 num_view_weapons,4
num_view_weapons:
	.long 0
	.globl niqlist
	.section	".data"
	.align 2
	.type	 niqlist,@object
	.size	 niqlist,432
niqlist:
	.long 0
	.space	32
	.long .LC0
	.long .LC1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 999
	.long 999
	.long .LC2
	.long .LC3
	.long .LC4
	.long 10
	.long 1
	.long 2
	.long 50
	.long 999
	.long 999
	.long .LC5
	.long .LC6
	.long .LC4
	.long 12
	.long 1
	.long 1
	.long 50
	.long 999
	.long 999
	.long .LC7
	.long .LC8
	.long .LC9
	.long 50
	.long 5
	.long 1
	.long 200
	.long 999
	.long 999
	.long .LC10
	.long .LC11
	.long .LC9
	.long 100
	.long 10
	.long 1
	.long 200
	.long 999
	.long 999
	.long .LC12
	.long .LC13
	.long .LC14
	.long 10
	.long 1
	.long 2
	.long 50
	.long 999
	.long 999
	.long .LC15
	.long .LC16
	.long .LC17
	.long 10
	.long 1
	.long 2
	.long 50
	.long 999
	.long 999
	.long .LC18
	.long .LC19
	.long .LC20
	.long 100
	.long 4
	.long 1
	.long 200
	.long 999
	.long 999
	.long .LC21
	.long .LC22
	.long .LC23
	.long 10
	.long 1
	.long 3
	.long 25
	.long 999
	.long 999
	.long .LC24
	.long .LC25
	.long .LC20
	.long 100
	.long 5
	.long 1
	.long 200
	.long 999
	.long 999
	.long .LC26
	.long 0
	.space	32
	.section	".rodata"
	.align 2
.LC26:
	.string	"switching to bfg10k"
	.align 2
.LC25:
	.string	"bfg10k"
	.align 2
.LC24:
	.string	"switching to railgun"
	.align 2
.LC23:
	.string	"slugs"
	.align 2
.LC22:
	.string	"railgun"
	.align 2
.LC21:
	.string	"switching to hyperblaster"
	.align 2
.LC20:
	.string	"cells"
	.align 2
.LC19:
	.string	"hyperblaster"
	.align 2
.LC18:
	.string	"switching to rocket launcher"
	.align 2
.LC17:
	.string	"rockets"
	.align 2
.LC16:
	.string	"rocket launcher"
	.align 2
.LC15:
	.string	"switching to grenade launcher"
	.align 2
.LC14:
	.string	"grenades"
	.align 2
.LC13:
	.string	"grenade launcher"
	.align 2
.LC12:
	.string	"switching to chaingun"
	.align 2
.LC11:
	.string	"chaingun"
	.align 2
.LC10:
	.string	"switching to machinegun"
	.align 2
.LC9:
	.string	"bullets"
	.align 2
.LC8:
	.string	"machinegun"
	.align 2
.LC7:
	.string	"switching to super shotgun"
	.align 2
.LC6:
	.string	"super shotgun"
	.align 2
.LC5:
	.string	"switching to shotgun"
	.align 2
.LC4:
	.string	"shells"
	.align 2
.LC3:
	.string	"shotgun"
	.align 2
.LC2:
	.string	"switching to super blaster"
	.align 2
.LC1:
	.string	""
	.align 2
.LC0:
	.string	"blaster"
	.globl niq_weap_fire_times
	.section	".data"
	.align 2
	.type	 niq_weap_fire_times,@object
	.size	 niq_weap_fire_times,40
niq_weap_fire_times:
	.long 0x3f4ccccd
	.long 0x3fe66666
	.long 0x3fd9999a
	.long 0x3f000000
	.long 0x40466666
	.long 0x3fcccccd
	.long 0x3f99999a
	.long 0x40000000
	.long 0x3fe66666
	.long 0x404ccccd
	.globl niq_dm_statusbar
	.section	".rodata"
	.align 2
.LC27:
	.string	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t124 \tanum \txv\t174 \tpic 2 endif if 4 \txv\t244 \trnum \txv\t294 \tpic 4 endif if 27 xv 0 yb -58 stat_string 27 endif if 31 xr\t-50 yt 12 num 3 14endif if 31 xr\t-50 yt 52 num 3 29endif if 31 xr\t-50 yt 92 num 3 30endif "
	.section	".sdata","aw"
	.align 2
	.type	 niq_dm_statusbar,@object
	.size	 niq_dm_statusbar,4
niq_dm_statusbar:
	.long .LC27
	.globl niq_ctf_statusbar
	.section	".rodata"
	.align 2
.LC28:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t124 \tanum \txv\t"
	.ascii	"174 \tpic 2 endif if 4 \txv\t244 \trnum \txv\t294 \tpic 4 en"
	.ascii	"dif if 21 yb -50 xr -26 pic 21 endif yb\t-50 if 7 \txv\t0 \t"
	.ascii	"pic 7 \txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 endif yb "
	.ascii	"-102 if 17 xr -26 pic 17 endif xr -62 num 2 1"
	.string	"8 if 22 yb -104 xr -28 pic 22 endif yb -75 if 19 xr -26 pic 19 endif xr -62 num 2 20 if 23 yb -77 xr -28 pic 23 endif if 27 xv 0 yb -58 stat_string 27 endif if 31 xr\t-50 yt 12 num 3 14endif if 31 xr\t-50 yt 52 num 3 29endif if 31 xr\t-50 yt 92 num 3 30endif "
	.section	".sdata","aw"
	.align 2
	.type	 niq_ctf_statusbar,@object
	.size	 niq_ctf_statusbar,4
niq_ctf_statusbar:
	.long .LC28
	.section	".rodata"
	.align 2
.LC29:
	.string	"x.xx"
	.align 2
.LC30:
	.string	"x.xx not found in version string\n"
	.align 2
.LC31:
	.string	"1.95"
	.section	".text"
	.align 2
	.globl niq_patchversionstrings
	.type	 niq_patchversionstrings,@function
niq_patchversionstrings:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 3,szNIQTitle_NIQ@ha
	lis 30,.LC29@ha
	la 3,szNIQTitle_NIQ@l(3)
	la 4,.LC29@l(30)
	bl strstr
	mr. 31,3
	bc 4,2,.L9
	lis 9,gi+4@ha
	lis 3,.LC30@ha
	lwz 0,gi+4@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L9:
	lis 29,.LC31@ha
	mr 3,31
	la 4,.LC31@l(29)
	li 5,4
	bl strncpy
	lis 3,szWelcomeStrNIQ@ha
	la 4,.LC29@l(30)
	la 3,szWelcomeStrNIQ@l(3)
	bl strstr
	mr. 31,3
	bc 4,2,.L11
	lis 9,gi+4@ha
	lis 3,.LC30@ha
	lwz 0,gi+4@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L11:
	mr 3,31
	la 4,.LC31@l(29)
	li 5,4
	bl strncpy
	lis 3,szWelcomeStr1NIQ@ha
	la 4,.LC29@l(30)
	la 3,szWelcomeStr1NIQ@l(3)
	bl strstr
	mr. 31,3
	bc 4,2,.L13
	lis 9,gi+4@ha
	lis 3,.LC30@ha
	lwz 0,gi+4@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L13:
	mr 3,31
	la 4,.LC31@l(29)
	li 5,4
	bl strncpy
	lis 3,szNIQCTFMENUStr1@ha
	la 4,.LC29@l(30)
	la 3,szNIQCTFMENUStr1@l(3)
	bl strstr
	mr. 31,3
	bc 4,2,.L15
	lis 9,gi+4@ha
	lis 3,.LC30@ha
	lwz 0,gi+4@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L15:
	mr 3,31
	la 4,.LC31@l(29)
	li 5,4
	bl strncpy
	lis 3,szNIQCTFMENUStr2@ha
	la 4,.LC29@l(30)
	la 3,szNIQCTFMENUStr2@l(3)
	bl strstr
	mr. 31,3
	bc 4,2,.L17
	lis 9,gi+4@ha
	lis 3,.LC30@ha
	lwz 0,gi+4@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L17:
	mr 3,31
	la 4,.LC31@l(29)
	li 5,4
	bl strncpy
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 niq_patchversionstrings,.Lfe1-niq_patchversionstrings
	.section	".rodata"
	.align 2
.LC32:
	.string	"%s\n"
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_selectcurrentweapon
	.type	 niq_selectcurrentweapon,@function
niq_selectcurrentweapon:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,game@ha
	la 8,game@l(9)
	lwz 0,2388(8)
	cmpwi 0,0,1
	bc 4,2,.L33
	lwz 0,1584(8)
	stw 0,1564(8)
	b .L34
.L33:
	lis 11,.LC33@ha
	lis 9,niq_weaprand@ha
	la 11,.LC33@l(11)
	lfs 13,0(11)
	lwz 11,niq_weaprand@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L35
	lis 9,niq_weapall@ha
	lwz 11,niq_weapall@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
	cmpwi 0,0,0
	li 7,0
	li 10,1
	bc 4,1,.L38
	mr 6,0
	addi 8,8,1988
.L40:
	lwz 0,0(8)
	addi 10,10,1
	cmpw 7,10,6
	addi 8,8,4
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	cror 31,30,28
	mfcr 11
	rlwinm 11,11,0,1
	addi 0,9,1
	and 9,7,9
	or. 7,9,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 9,11,0
	bc 4,2,.L40
.L38:
	cmpwi 0,7,0
	bc 4,2,.L43
	lis 9,game@ha
	li 10,1
	la 9,game@l(9)
	lwz 0,2388(9)
	cmpw 0,10,0
	bc 12,1,.L45
	li 8,0
	addi 11,9,1988
.L47:
	stw 8,0(11)
	addi 10,10,1
	lwz 0,2388(9)
	addi 11,11,4
	cmpw 0,10,0
	bc 4,1,.L47
.L45:
	lis 9,game@ha
	la 31,game@l(9)
.L52:
	bl rand
	lwz 9,2388(31)
	lwz 11,1572(31)
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	addi 3,3,1
	cmpw 0,3,11
	bc 12,2,.L52
	b .L53
.L43:
	bl rand
	lis 9,game@ha
	la 9,game@l(9)
	lwz 11,2388(9)
	addi 8,9,1984
	divw 0,3,11
	mullw 0,0,11
	subf 3,0,3
	addi 3,3,1
	slwi 0,3,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 12,2,.L53
	mr 10,11
.L56:
	addi 3,3,1
	cmpw 7,3,10
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	neg 9,9
	addi 11,9,1
	and 9,3,9
	or 3,9,11
	slwi 0,3,2
	lwzx 9,8,0
	cmpwi 0,9,0
	bc 4,2,.L56
.L53:
	lis 9,game@ha
	slwi 11,3,2
	la 9,game@l(9)
	li 0,1
	addi 9,9,1984
	stwx 0,9,11
	b .L59
.L36:
	mr 31,8
.L63:
	bl rand
	lwz 9,2388(31)
	lwz 11,1572(31)
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	addi 3,3,1
	cmpw 0,3,11
	bc 12,2,.L63
.L59:
	lis 9,game@ha
	slwi 10,3,2
	la 9,game@l(9)
	addi 11,9,1580
	lwzx 0,11,10
	stw 3,1572(9)
	stw 0,1564(9)
	b .L34
.L35:
	cmpwi 0,3,0
	bc 12,2,.L65
	lwz 9,1584(8)
	li 0,1
	stw 0,1572(8)
	b .L68
.L65:
	lwz 9,1572(8)
	addi 9,9,1
	cmpw 0,9,0
	stw 9,1572(8)
	bc 4,1,.L67
	li 0,1
	stw 0,1572(8)
.L67:
	lwz 0,1572(8)
	addi 11,8,1580
	slwi 0,0,2
	lwzx 9,11,0
.L68:
	stw 9,1564(8)
.L34:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 niq_selectcurrentweapon,.Lfe2-niq_selectcurrentweapon
	.section	".rodata"
	.align 2
.LC34:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl niq_setweapontimer
	.type	 niq_setweapontimer,@function
niq_setweapontimer:
	lis 9,game@ha
	lis 11,.LC34@ha
	la 11,.LC34@l(11)
	la 8,game@l(9)
	lfs 13,0(11)
	lfs 0,1576(8)
	fcmpu 0,0,13
	bc 4,2,.L71
	lis 11,niq_weapsecs@ha
	stfs 13,1576(8)
	lis 10,niq_prevwsecs@ha
	lwz 9,niq_weapsecs@l(11)
	lfs 0,20(9)
	stfs 0,niq_prevwsecs@l(10)
	blr
.L71:
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L73
	fsubs 0,0,13
	lis 9,niq_weapsecs@ha
	lis 11,niq_prevwsecs@ha
	lwz 9,niq_weapsecs@l(9)
	stfs 0,1576(8)
	lfs 13,20(9)
	fcmpu 0,0,13
	stfs 13,niq_prevwsecs@l(11)
	bclr 4,1
	stfs 13,1576(8)
	lfs 0,20(9)
	stfs 0,niq_prevwsecs@l(11)
	blr
.L73:
	lis 9,niq_weapsecs@ha
	lis 10,niq_prevwsecs@ha
	lwz 11,niq_weapsecs@l(9)
	lfs 0,20(11)
	stfs 0,1576(8)
	lfs 13,20(11)
	stfs 13,niq_prevwsecs@l(10)
	blr
.Lfe3:
	.size	 niq_setweapontimer,.Lfe3-niq_setweapontimer
	.section	".rodata"
	.align 2
.LC35:
	.string	"items/s_health.wav"
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC37:
	.long 0x41e00000
	.long 0x0
	.align 2
.LC38:
	.long 0x0
	.align 2
.LC39:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl niq_incrementhealth
	.type	 niq_incrementhealth,@function
niq_incrementhealth:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 6,0
	lwz 0,612(31)
	li 5,0
	cmpwi 0,0,2
	bc 4,1,.L81
	lis 9,level+4@ha
	lfs 13,404(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L81
	li 5,1
.L81:
	lwz 0,480(31)
	lis 7,0x4330
	lis 11,.LC36@ha
	lwz 10,608(31)
	xoris 0,0,0x8000
	la 11,.LC36@l(11)
	stw 0,28(1)
	stw 7,24(1)
	rlwinm 0,10,0,28,28
	lfd 12,0(11)
	lfd 0,24(1)
	lis 11,niq_hlthmax@ha
	lwz 8,niq_hlthmax@l(11)
	rlwinm 11,10,0,27,27
	fsub 0,0,12
	lfs 13,20(8)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L82
	fmr 0,13
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,480(31)
.L82:
	neg 0,0
	srwi 0,0,31
	or. 9,5,0
	bc 4,2,.L80
	cmpwi 0,11,0
	bc 4,2,.L80
	lwz 0,480(31)
	lis 9,niq_hlthmax@ha
	lwz 10,niq_hlthmax@l(9)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	lfs 13,20(10)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L85
	lis 11,.LC37@ha
	lis 9,niq_sndhlth@ha
	la 11,.LC37@l(11)
	lfd 12,0(11)
	lwz 11,niq_sndhlth@l(9)
	lfs 0,20(11)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L86
	fctiwz 0,13
	stfd 0,24(1)
	lwz 6,28(1)
	b .L87
.L86:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 6,28(1)
	xoris 6,6,0x8000
.L87:
	lis 9,.LC38@ha
	lis 11,deathmatch@ha
	la 9,.LC38@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L88
	lwz 0,1820(4)
	li 8,0
	cmpwi 0,0,0
	bc 12,2,.L89
	lis 11,game+1564@ha
	lis 10,niq_weap_fire_times@ha
	lfs 13,976(31)
	lwz 9,game+1564@l(11)
	la 10,niq_weap_fire_times@l(10)
	lis 11,level+4@ha
	addi 9,9,-1
	lfs 12,level+4@l(11)
	slwi 9,9,2
	lfsx 0,10,9
	fadds 13,13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 4,3,.L91
	b .L93
.L89:
	lwz 0,3648(4)
	cmpwi 0,0,3
	bc 12,2,.L93
	lwz 9,3596(4)
	lwz 0,3604(4)
	or 0,0,9
	andi. 11,0,1
	bc 12,2,.L91
.L93:
	li 8,1
.L91:
	cmpwi 0,8,0
	bc 4,2,.L94
	lwz 0,480(31)
	lis 7,0x4330
	lis 9,.LC36@ha
	mr 11,10
	xoris 0,0,0x8000
	la 9,.LC36@l(9)
	stw 0,28(1)
	stw 7,24(1)
	lfd 13,0(9)
	lfd 0,24(1)
	lis 9,niq_hlthinc@ha
	lwz 8,niq_hlthinc@l(9)
	fsub 0,0,13
	lfs 11,20(8)
	b .L99
.L94:
	li 6,0
	b .L96
.L88:
	lwz 0,480(31)
	lis 7,0x4330
	lis 11,.LC36@ha
	lis 9,niq_hlthinc@ha
	xoris 0,0,0x8000
	la 11,.LC36@l(11)
	lwz 8,niq_hlthinc@l(9)
	stw 0,28(1)
	stw 7,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	mr 11,10
	lfs 11,20(8)
	fsub 0,0,13
.L99:
	frsp 0,0
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,24(1)
	lwz 11,28(1)
	stw 11,480(31)
.L96:
	lwz 0,480(31)
	lis 8,0x4330
	lis 11,.LC36@ha
	xoris 0,0,0x8000
	la 11,.LC36@l(11)
	stw 0,28(1)
	stw 8,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	lis 11,niq_hlthmax@ha
	lwz 10,niq_hlthmax@l(11)
	fsub 0,0,13
	lfs 12,20(10)
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L85
	fmr 0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,480(31)
.L85:
	cmpwi 0,6,0
	bc 12,2,.L80
	lis 29,gi@ha
	lis 3,.LC35@ha
	la 29,gi@l(29)
	la 3,.LC35@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC39@ha
	lwz 0,16(29)
	lis 11,.LC39@ha
	la 9,.LC39@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC39@l(11)
	li 4,5
	mtlr 0
	lis 9,.LC38@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC38@l(9)
	lfs 3,0(9)
	blrl
.L80:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 niq_incrementhealth,.Lfe4-niq_incrementhealth
	.align 2
	.globl niq_incrementammo
	.type	 niq_incrementammo,@function
niq_incrementammo:
	lwz 10,3952(3)
	lis 11,game@ha
	lis 9,niqlist@ha
	la 8,game@l(11)
	la 6,niqlist@l(9)
	addi 10,10,1
	addi 11,6,16
	stw 10,3952(3)
	lwz 0,1564(8)
	mulli 0,0,36
	lwzx 9,11,0
	cmpw 0,10,9
	bclr 12,0
	li 0,0
	stw 0,3952(3)
	lwz 11,1564(8)
	cmpwi 0,11,1
	bclr 12,2
	mulli 10,11,36
	addi 9,6,12
	addi 11,6,28
	lwzx 7,9,10
	lwzx 0,11,10
	cmpwi 0,7,0
	bclr 4,1
	cmpwi 0,0,0
	bclr 4,1
	cmpwi 0,0,999
	bclr 12,2
	slwi 8,0,2
	addi 3,3,740
	addi 9,6,20
	lwzx 0,3,8
	lwzx 11,9,10
	cmpw 0,0,11
	bclr 4,0
	add 9,7,0
	cmpw 7,9,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,11,0
	and 9,9,0
	or 9,9,11
	stwx 9,3,8
	blr
.Lfe5:
	.size	 niq_incrementammo,.Lfe5-niq_incrementammo
	.section	".rodata"
	.align 2
.LC40:
	.string	"if 24 xv 8 yv 8 pic 24 endif xv 40 yv 28 string \"%4d/%-3d\" xv 98 yv 12 num 2 18 if 25 xv 168 yv 8 pic 25 endif xv 200 yv 28 string \"%4d/%-3d\" xv 256 yv 12 num 2 20 "
	.align 2
.LC41:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC42:
	.string	"xv 56 yv %d picn sbfctf2 "
	.align 2
.LC43:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC44:
	.string	"xv 216 yv %d picn sbfctf1 "
	.align 2
.LC45:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC46:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC47:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC48:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 3
.LC49:
	.long 0x0
	.long 0x0
	.align 3
.LC50:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC51:
	.long 0x0
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl niq_CTFScoreboardMessage
	.type	 niq_CTFScoreboardMessage,@function
niq_CTFScoreboardMessage:
	stwu 1,-6656(1)
	mflr 0
	mfcr 12
	stfd 31,6648(1)
	stmw 14,6576(1)
	stw 0,6660(1)
	stw 12,6572(1)
	lis 9,game@ha
	li 10,0
	la 7,game@l(9)
	addi 11,1,6536
	lwz 8,1544(7)
	li 22,0
	addi 9,1,6544
	stw 10,4(11)
	li 0,0
	li 24,0
	stw 10,6536(1)
	cmpw 0,22,8
	mr 15,11
	stw 0,4(9)
	mr 14,9
	addi 19,1,1032
	stw 0,6544(1)
	li 23,0
	bc 4,0,.L127
	lis 9,g_edicts@ha
	mr 20,7
	lwz 16,g_edicts@l(9)
	mr 21,15
	mr 18,14
	addi 17,1,4488
	mr 12,15
.L129:
	mulli 9,22,1332
	addi 30,22,1
	add 29,9,16
	lwz 0,1420(29)
	cmpwi 0,0,0
	bc 12,2,.L128
	mulli 9,22,3968
	lwz 0,1028(20)
	mr 8,9
	add 9,9,0
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 4,2,.L131
	li 10,0
	b .L132
.L131:
	cmpwi 0,0,2
	bc 4,2,.L128
	li 10,1
.L132:
	slwi 0,10,2
	lwz 9,1028(20)
	li 25,0
	lwzx 11,21,0
	mr 5,0
	slwi 7,10,10
	add 9,8,9
	addi 31,1,2440
	cmpw 0,25,11
	addi 8,1,4488
	lfs 13,3512(9)
	addi 30,22,1
	bc 4,0,.L136
	lfsx 0,17,7
	fcmpu 0,13,0
	bc 12,1,.L136
	lwzx 0,5,12
	add 9,7,8
.L137:
	addi 25,25,1
	cmpw 0,25,0
	bc 4,0,.L136
	lfsu 0,4(9)
	fcmpu 0,13,0
	bc 4,1,.L137
.L136:
	lwzx 26,5,21
	slwi 3,25,2
	cmpw 0,26,25
	bc 4,1,.L142
	addi 0,8,-4
	addi 11,31,-4
	slwi 9,26,2
	add 0,7,0
	add 11,7,11
	add 10,9,0
	add 11,9,11
	mr 4,31
	add 9,9,7
	mr 6,8
.L144:
	lwz 0,0(11)
	addi 26,26,-1
	cmpw 0,26,25
	addi 11,11,-4
	stwx 0,9,4
	lfs 0,0(10)
	addi 10,10,-4
	stfsx 0,9,6
	addi 9,9,-4
	bc 12,1,.L144
.L142:
	add 0,3,7
	stwx 22,31,0
	stfsx 13,8,0
	lfsx 0,5,18
	lwzx 9,5,21
	fadds 0,0,13
	addi 9,9,1
	stwx 9,5,21
	stfsx 0,5,18
.L128:
	lwz 0,1544(20)
	mr 22,30
	cmpw 0,22,0
	bc 12,0,.L129
.L127:
	lfs 13,6544(1)
	lis 9,.LC49@ha
	li 0,0
	la 9,.LC49@l(9)
	stb 0,1032(1)
	lfd 0,0(9)
	fmr 12,13
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L147
	lis 10,.LC50@ha
	la 10,.LC50@l(10)
	lfd 0,0(10)
	fadd 0,12,0
	b .L189
.L147:
	lis 11,.LC50@ha
	la 11,.LC50@l(11)
	lfd 0,0(11)
	fsub 0,12,0
.L189:
	fctiwz 13,0
	stfd 13,6560(1)
	lwz 27,6564(1)
	lfs 13,4(14)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfd 0,0(9)
	fmr 12,13
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L149
	lis 10,.LC50@ha
	la 10,.LC50@l(10)
	lfd 0,0(10)
	fadd 0,12,0
	b .L190
.L149:
	lis 11,.LC50@ha
	la 11,.LC50@l(11)
	lfd 0,0(11)
	fsub 0,12,0
.L190:
	fctiwz 13,0
	stfd 13,6560(1)
	lwz 28,6564(1)
	lwz 8,4(15)
	lis 4,.LC40@ha
	mr 5,27
	lwz 6,6536(1)
	la 4,.LC40@l(4)
	mr 7,28
	mr 3,19
	li 22,0
	crxor 6,6,6
	bl sprintf
	mr 3,19
	bl strlen
	lwz 0,6536(1)
	mr 20,3
	b .L191
.L155:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,22,9
	bc 4,0,.L156
	slwi 7,22,2
	addi 8,1,2440
	lwzx 11,8,7
	lis 9,game+1028@ha
	lis 10,.LC49@ha
	lwz 6,game+1028@l(9)
	la 10,.LC49@l(10)
	mr 31,8
	mulli 0,11,3968
	lfd 13,0(10)
	mr 25,7
	lis 10,g_edicts@ha
	mulli 11,11,1332
	add 30,6,0
	lwz 9,g_edicts@l(10)
	lfs 0,3512(30)
	addi 11,11,1332
	add 29,9,11
	fmr 12,0
	fcmpu 0,12,13
	cror 3,2,1
	bc 4,3,.L157
	lis 11,.LC50@ha
	la 11,.LC50@l(11)
	lfd 0,0(11)
	fadd 0,12,0
	b .L192
.L157:
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfd 0,0(9)
	fsub 0,12,0
.L192:
	fctiwz 13,0
	stfd 13,6560(1)
	lwz 27,6564(1)
	addi 3,1,8
	mr 26,3
	bl strlen
	lwz 11,184(30)
	slwi 9,22,3
	lis 4,.LC41@ha
	addi 30,9,42
	lwzx 6,31,25
	la 4,.LC41@l(4)
	cmpwi 7,11,1000
	add 3,26,3
	mr 5,30
	mr 7,27
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
	lwz 10,84(29)
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x38e3
	addi 10,10,740
	ori 9,9,36409
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L160
	mr 3,26
	bl strlen
	lis 4,.LC42@ha
	mr 5,30
	la 4,.LC42@l(4)
	add 3,26,3
	crxor 6,6,6
	bl sprintf
.L160:
	mr 3,26
	subfic 29,20,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L156
	mr 4,26
	mr 3,19
	bl strcat
	mr 23,22
	mr 3,19
	bl strlen
	mr 20,3
.L156:
	lwz 0,4(15)
	cmpw 0,22,0
	bc 4,0,.L153
	addi 11,1,3464
	slwi 8,22,2
	lwzx 10,11,8
	lis 9,game+1028@ha
	mr 26,11
	lwz 7,game+1028@l(9)
	mr 25,8
	mulli 0,10,3968
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	mulli 10,10,1332
	add 30,7,0
	lfd 13,0(9)
	lfs 0,3512(30)
	lis 9,g_edicts@ha
	addi 10,10,1332
	lwz 11,g_edicts@l(9)
	fmr 12,0
	add 29,11,10
	fcmpu 0,12,13
	cror 3,2,1
	bc 4,3,.L163
	lis 10,.LC50@ha
	la 10,.LC50@l(10)
	lfd 0,0(10)
	fadd 0,12,0
	b .L193
.L163:
	lis 11,.LC50@ha
	la 11,.LC50@l(11)
	lfd 0,0(11)
	fsub 0,12,0
.L193:
	fctiwz 13,0
	stfd 13,6560(1)
	lwz 27,6564(1)
	addi 3,1,8
	mr 31,3
	bl strlen
	lwz 11,184(30)
	slwi 9,22,3
	lis 4,.LC43@ha
	addi 30,9,42
	lwzx 6,26,25
	la 4,.LC43@l(4)
	cmpwi 7,11,1000
	add 3,31,3
	mr 5,30
	mr 7,27
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
	lwz 10,84(29)
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x38e3
	addi 10,10,740
	ori 9,9,36409
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L166
	mr 3,31
	bl strlen
	lis 4,.LC44@ha
	mr 5,30
	la 4,.LC44@l(4)
	add 3,31,3
	crxor 6,6,6
	bl sprintf
.L166:
	mr 3,31
	subfic 29,20,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L153
	mr 4,31
	mr 3,19
	bl strcat
	mr 24,22
	mr 3,19
	bl strlen
	mr 20,3
.L153:
	addi 22,22,1
	cmpwi 0,22,15
	bc 12,1,.L152
	lwz 0,6536(1)
.L191:
	cmpw 0,22,0
	bc 12,0,.L155
	lwz 0,4(15)
	cmpw 0,22,0
	bc 12,0,.L155
.L152:
	cmpw 7,23,24
	subfic 0,20,1000
	cmpwi 0,0,50
	li 16,0
	li 26,0
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,23,0
	and 0,24,0
	or 25,0,11
	slwi 9,25,3
	addi 25,9,58
	bc 4,1,.L171
	lis 9,maxclients@ha
	lis 10,.LC51@ha
	lwz 11,maxclients@l(9)
	la 10,.LC51@l(10)
	li 22,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L171
	lis 11,.LC50@ha
	mr 21,19
	la 11,.LC50@l(11)
	lis 14,0x4330
	lfd 31,0(11)
	li 17,0
	li 18,1332
.L175:
	lis 9,g_edicts@ha
	lis 10,game@ha
	lwz 0,g_edicts@l(9)
	la 10,game@l(10)
	lwz 11,1028(10)
	add 29,0,18
	lwz 9,88(29)
	add 30,11,17
	cmpwi 0,9,0
	bc 12,2,.L174
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L174
	lwz 9,84(29)
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 4,2,.L174
	cmpwi 0,26,0
	bc 4,2,.L178
	lis 4,.LC45@ha
	mr 5,25
	addi 3,1,8
	la 4,.LC45@l(4)
	crxor 6,6,6
	bl sprintf
	li 26,1
	addi 25,25,8
	addi 4,1,8
	mr 3,21
	bl strcat
	mr 3,21
	bl strlen
	mr 20,3
.L178:
	lfs 13,3512(30)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L179
	fadd 0,13,31
	b .L194
.L179:
	fsub 0,13,31
.L194:
	fctiwz 13,0
	stfd 13,6560(1)
	lwz 27,6564(1)
	addi 3,1,8
	subfic 29,20,1000
	mr 31,3
	bl strlen
	lwz 11,184(30)
	rlwinm 5,16,0,31,31
	lis 4,.LC46@ha
	cmpwi 4,5,0
	la 4,.LC46@l(4)
	cmpwi 7,11,1000
	neg 5,5
	andi. 5,5,160
	mr 6,25
	mr 7,22
	mr 8,27
	mfcr 0
	rlwinm 0,0,29,1
	add 3,31,3
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
	bc 4,1,.L184
	mr 4,31
	mr 3,21
	bl strcat
	mr 3,21
	bl strlen
	mr 20,3
.L184:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,25,8
	neg 0,0
	addi 16,16,1
	andc 9,9,0
	and 0,25,0
	or 25,0,9
.L174:
	lis 10,maxclients@ha
	addi 22,22,1
	lwz 11,maxclients@l(10)
	xoris 0,22,0x8000
	lis 10,.LC52@ha
	stw 0,6564(1)
	addi 17,17,3968
	la 10,.LC52@l(10)
	stw 14,6560(1)
	addi 18,18,1332
	lfd 12,0(10)
	lfd 0,6560(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L175
.L171:
	lwz 0,6536(1)
	subf 0,23,0
	cmpwi 0,0,1
	bc 4,1,.L187
	mr 3,19
	bl strlen
	lwz 6,6536(1)
	slwi 5,23,3
	lis 4,.LC47@ha
	la 4,.LC47@l(4)
	addi 5,5,50
	subf 6,23,6
	add 3,19,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L187:
	lwz 0,4(15)
	subf 0,24,0
	cmpwi 0,0,1
	bc 4,1,.L188
	mr 3,19
	bl strlen
	lwz 6,4(15)
	slwi 5,24,3
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	addi 5,5,50
	subf 6,24,6
	add 3,19,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L188:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,19
	mtlr 0
	blrl
	lwz 0,6660(1)
	lwz 12,6572(1)
	mtlr 0
	lmw 14,6576(1)
	lfd 31,6648(1)
	mtcrf 8,12
	la 1,6656(1)
	blr
.Lfe6:
	.size	 niq_CTFScoreboardMessage,.Lfe6-niq_CTFScoreboardMessage
	.section	".rodata"
	.align 2
.LC53:
	.string	"xv %d yv %d string \"%s\""
	.align 2
.LC54:
	.string	""
	.globl memset
	.align 2
.LC55:
	.string	"NIQ: invalid scoreboard setting.\n"
	.section	".text"
	.align 2
	.globl niq_sb_addmaintitles
	.type	 niq_sb_addmaintitles,@function
niq_sb_addmaintitles:
	stwu 1,-448(1)
	mflr 0
	stmw 28,432(1)
	stw 0,452(1)
	lis 9,.LC54@ha
	mr 28,4
	lbz 29,.LC54@l(9)
	mr 31,3
	li 4,0
	addi 3,1,9
	li 5,199
	stb 29,8(1)
	crxor 6,6,6
	bl memset
	stb 29,216(1)
	addi 3,1,217
	li 4,0
	li 5,199
	crxor 6,6,6
	bl memset
	bl niq_getnumclients
	cmpwi 0,28,0
	bc 4,2,.L197
	lis 29,szNIQTitle_320A@ha
	addi 28,1,8
	la 29,szNIQTitle_320A@l(29)
	b .L218
.L197:
	cmpwi 0,28,1
	bc 4,2,.L200
	lis 29,szNIQTitle_320B@ha
	addi 28,1,8
	la 29,szNIQTitle_320B@l(29)
	b .L218
.L200:
	cmpwi 0,28,2
	bc 4,2,.L203
	lis 29,szNIQTitle_320C@ha
	addi 28,1,8
	la 29,szNIQTitle_320C@l(29)
	b .L218
.L203:
	cmpwi 0,28,3
	bc 4,2,.L206
	lis 29,szNIQTitle_320D@ha
	addi 28,1,8
	la 29,szNIQTitle_320D@l(29)
	b .L218
.L206:
	cmpwi 0,28,4
	bc 4,2,.L209
	lis 29,szNIQTitle_320E@ha
	addi 28,1,8
	la 29,szNIQTitle_320E@l(29)
	b .L218
.L209:
	cmpwi 0,28,5
	bc 4,2,.L212
	lis 29,szNIQTitle_512A@ha
	addi 28,1,8
	la 29,szNIQTitle_512A@l(29)
	b .L218
.L212:
	cmpwi 0,28,6
	bc 4,2,.L215
	lis 29,szNIQTitle_640A@ha
	addi 28,1,8
	la 29,szNIQTitle_640A@l(29)
.L218:
	mr 3,29
	bl strlen
	subfic 5,3,40
	lis 4,.LC53@ha
	mr 3,28
	la 4,.LC53@l(4)
	slwi 5,5,2
	mr 7,29
	li 6,40
	crxor 6,6,6
	bl sprintf
	b .L199
.L215:
	lis 9,gi+4@ha
	lis 3,.LC55@ha
	lwz 0,gi+4@l(9)
	la 3,.LC55@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L199:
	addi 29,1,216
	addi 4,1,8
	mr 3,29
	bl strcat
	mr 3,31
	mr 4,29
	bl strcat
	lwz 0,452(1)
	mtlr 0
	lmw 28,432(1)
	la 1,448(1)
	blr
.Lfe7:
	.size	 niq_sb_addmaintitles,.Lfe7-niq_sb_addmaintitles
	.section	".rodata"
	.align 2
.LC59:
	.string	"BFG"
	.align 2
.LC60:
	.string	"RG"
	.align 2
.LC61:
	.string	"HB"
	.align 2
.LC62:
	.string	"RL"
	.align 2
.LC63:
	.string	"GL"
	.align 2
.LC64:
	.string	"CG"
	.align 2
.LC65:
	.string	"MG"
	.align 2
.LC66:
	.string	"SSG"
	.align 2
.LC67:
	.string	"SG"
	.align 2
.LC68:
	.string	"SB"
	.align 2
.LC69:
	.string	"??"
	.section	".text"
	.align 2
	.globl niq_getcurweapname
	.type	 niq_getcurweapname,@function
niq_getcurweapname:
	lis 9,item_bfg10k@ha
	lis 11,itemlist@ha
	lwz 0,item_bfg10k@l(9)
	la 10,itemlist@l(11)
	addi 3,3,740
	lis 11,0x38e3
	ori 11,11,36409
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L230
	lis 9,.LC59@ha
	lwz 0,.LC59@l(9)
	stw 0,0(4)
	blr
.L230:
	lis 9,item_railgun@ha
	lwz 0,item_railgun@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L232
	lis 9,.LC60@ha
	la 11,.LC60@l(9)
	lhz 0,.LC60@l(9)
.L250:
	lbz 10,2(11)
	sth 0,0(4)
	stb 10,2(4)
	blr
.L232:
	lis 9,item_hyperblaster@ha
	lwz 0,item_hyperblaster@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L234
	lis 9,.LC61@ha
	la 11,.LC61@l(9)
	lhz 0,.LC61@l(9)
	b .L250
.L234:
	lis 9,item_rocketlauncher@ha
	lwz 0,item_rocketlauncher@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L236
	lis 9,.LC62@ha
	la 11,.LC62@l(9)
	lhz 0,.LC62@l(9)
	b .L250
.L236:
	lis 9,item_grenadelauncher@ha
	lwz 0,item_grenadelauncher@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L238
	lis 9,.LC63@ha
	la 11,.LC63@l(9)
	lhz 0,.LC63@l(9)
	b .L250
.L238:
	lis 9,item_chaingun@ha
	lwz 0,item_chaingun@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L240
	lis 9,.LC64@ha
	la 11,.LC64@l(9)
	lhz 0,.LC64@l(9)
	b .L250
.L240:
	lis 9,item_machinegun@ha
	lwz 0,item_machinegun@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L242
	lis 9,.LC65@ha
	la 11,.LC65@l(9)
	lhz 0,.LC65@l(9)
	b .L250
.L242:
	lis 9,item_supershotgun@ha
	lwz 0,item_supershotgun@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L244
	lis 9,.LC66@ha
	lwz 0,.LC66@l(9)
	stw 0,0(4)
	blr
.L244:
	lis 9,item_shotgun@ha
	lwz 0,item_shotgun@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L246
	lis 9,.LC67@ha
	la 11,.LC67@l(9)
	lhz 0,.LC67@l(9)
	b .L250
.L246:
	lis 9,item_blaster@ha
	lwz 0,item_blaster@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,3,0
	cmpwi 0,9,0
	bc 12,2,.L248
	lis 9,.LC68@ha
	la 11,.LC68@l(9)
	lhz 0,.LC68@l(9)
	b .L250
.L248:
	lis 9,.LC69@ha
	la 11,.LC69@l(9)
	lhz 0,.LC69@l(9)
	b .L250
.Lfe8:
	.size	 niq_getcurweapname,.Lfe8-niq_getcurweapname
	.section	".rodata"
	.align 2
.LC70:
	.string	"%-13s %3d %3d %3d %4d %3d %5.1f"
	.align 2
.LC74:
	.string	"%-8s %3d %3d %3d %4d %4d %3d %5.1f"
	.align 2
.LC75:
	.string	"%-15s %4d %4d %3d %4d %5.1f"
	.align 2
.LC76:
	.string	"%-13s %5.1f %5.1f %4d %3d %5.1f"
	.align 2
.LC77:
	.string	"%-7s %4.1f %4.1f %3d %3d %3d %4d %5.1f"
	.align 2
.LC78:
	.string	"%-15s %5.1f %5.1f %3d %3d %3d %4d %4d %3d %4d %5.1f"
	.align 2
.LC79:
	.string	"*"
	.align 2
.LC80:
	.string	"%-15s %4s %4d %4d  %5.1f %5.1f %3d %3d %3d %4d %4d %3d %4d %5.1f"
	.align 2
.LC81:
	.string	"xv %d yv %d string2 \"%s\""
	.align 3
.LC71:
	.long 0x40ac2000
	.long 0x0
	.align 3
.LC72:
	.long 0x408f3800
	.long 0x0
	.align 3
.LC73:
	.long 0xc058c000
	.long 0x0
	.align 3
.LC82:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC83:
	.long 0x40240000
	.long 0x0
	.align 3
.LC84:
	.long 0x0
	.long 0x0
	.align 3
.LC85:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_sb_addcliententry
	.type	 niq_sb_addcliententry,@function
niq_sb_addcliententry:
	stwu 1,-592(1)
	mflr 0
	stmw 19,540(1)
	stw 0,596(1)
	lis 11,.LC54@ha
	mr 20,3
	lbz 29,.LC54@l(11)
	mr 19,4
	mr 31,5
	mr 30,6
	addi 3,1,33
	mr 24,7
	mr 21,8
	stb 29,32(1)
	mr 26,9
	li 4,0
	li 5,199
	li 22,0
	crxor 6,6,6
	bl memset
	stb 29,240(1)
	addi 3,1,241
	li 4,0
	li 5,199
	crxor 6,6,6
	bl memset
	cmplwi 0,30,4
	bc 12,1,.L266
	lis 11,.L267@ha
	slwi 10,30,2
	la 11,.L267@l(11)
	lis 9,.L267@ha
	lwzx 0,10,11
	la 9,.L267@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L267:
	.long .L264-.L267
	.long .L262-.L267
	.long .L266-.L267
	.long .L264-.L267
	.long .L265-.L267
.L262:
	li 28,8
	b .L260
.L264:
	li 28,13
	b .L260
.L265:
	li 28,7
	b .L260
.L266:
	li 28,15
.L260:
	addi 29,1,448
	addi 4,31,700
	mr 3,29
	li 5,15
	bl strncpy
	li 27,0
	mr 25,29
	lwz 0,1820(31)
	stbx 27,29,28
	cmpwi 0,0,0
	bc 12,2,.L275
	mr 3,25
	bl strlen
	cmpw 0,3,28
	bc 4,0,.L269
	li 0,170
	add 9,3,25
	stbx 0,25,3
	stb 27,1(9)
	b .L275
.L269:
	add 9,3,25
	li 0,170
	stb 0,-1(9)
.L275:
	cmpwi 0,30,0
	bc 4,2,.L276
	lis 9,level@ha
	lwz 10,3460(31)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC82@ha
	lwz 6,3516(31)
	subf 0,10,0
	la 9,.LC82@l(9)
	lwz 7,3520(31)
	xoris 0,0,0x8000
	lfd 13,0(9)
	stw 0,532(1)
	lis 9,.LC83@ha
	stw 8,528(1)
	la 9,.LC83@l(9)
	lfd 0,528(1)
	lfd 12,0(9)
	lis 9,.LC84@ha
	lwz 3,3524(31)
	fsub 0,0,13
	la 9,.LC84@l(9)
	lwz 0,184(31)
	lfd 11,0(9)
	fdiv 0,0,12
	frsp 0,0
	fmr 10,0
	fcmpu 0,10,11
	bc 4,1,.L277
	lfs 12,3512(31)
	lis 9,.LC71@ha
	lfd 13,.LC71@l(9)
	fmr 0,12
	fmul 0,0,13
	fdiv 0,0,10
	frsp 0,0
	b .L278
.L277:
	lfs 12,3512(31)
	fmr 0,12
.L278:
	fmr 11,0
	lis 9,.LC72@ha
	lfd 0,.LC72@l(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L279
	li 10,999
	b .L280
.L279:
	lis 9,.LC73@ha
	lfd 0,.LC73@l(9)
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L281
	li 10,-99
	b .L280
.L281:
	lis 11,.LC84@ha
	la 11,.LC84@l(11)
	lfd 0,0(11)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L282
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfd 0,0(9)
	fadd 0,11,0
	b .L359
.L282:
	lis 11,.LC85@ha
	la 11,.LC85@l(11)
	lfd 0,0(11)
	fsub 0,11,0
.L359:
	fctiwz 13,0
	stfd 13,528(1)
	lwz 10,532(1)
.L280:
	cmpwi 0,26,0
	fmr 1,12
	mr 8,3
	lis 4,.LC70@ha
	mr 5,25
	la 4,.LC70@l(4)
	mr 9,0
	addi 3,1,32
	mfcr 30
	creqv 6,6,6
	bl sprintf
	addi 27,1,240
	b .L284
.L276:
	cmpwi 0,30,1
	bc 4,2,.L285
	lis 11,level@ha
	lwz 10,3460(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC82@ha
	mr 7,10
	subf 0,10,0
	la 11,.LC82@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,532(1)
	lis 11,.LC83@ha
	stw 8,528(1)
	la 11,.LC83@l(11)
	lfd 0,528(1)
	lfd 12,0(11)
	lis 11,.LC84@ha
	fsub 0,0,13
	la 11,.LC84@l(11)
	lfd 11,0(11)
	fdiv 0,0,12
	frsp 0,0
	fmr 10,0
	fcmpu 0,10,11
	bc 4,1,.L286
	lfs 12,3512(31)
	lis 9,.LC71@ha
	lfd 13,.LC71@l(9)
	fmr 0,12
	fmul 0,0,13
	fdiv 0,0,10
	frsp 0,0
	b .L287
.L286:
	lfs 12,3512(31)
	fmr 0,12
.L287:
	fmr 11,0
	lis 9,.LC72@ha
	lfd 0,.LC72@l(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L288
	li 3,999
	b .L289
.L288:
	lis 9,.LC73@ha
	lfd 0,.LC73@l(9)
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L290
	li 3,-99
	b .L289
.L290:
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfd 0,0(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L291
	lis 11,.LC85@ha
	la 11,.LC85@l(11)
	lfd 0,0(11)
	fadd 0,11,0
	b .L360
.L291:
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfd 0,0(9)
	fsub 0,11,0
.L360:
	fctiwz 13,0
	stfd 13,528(1)
	lwz 3,532(1)
.L289:
	lis 11,level@ha
	lis 9,0x1b4e
	lwz 10,184(31)
	fmr 1,12
	lwz 0,level@l(11)
	ori 9,9,33205
	cmpwi 0,26,0
	lwz 6,3516(31)
	lis 4,.LC74@ha
	mr 5,25
	subf 0,7,0
	lwz 8,3524(31)
	la 4,.LC74@l(4)
	mulhw 9,0,9
	lwz 7,3520(31)
	mfcr 30
	srawi 0,0,31
	stw 3,8(1)
	srawi 9,9,6
	addi 3,1,32
	subf 9,0,9
	creqv 6,6,6
	bl sprintf
	addi 27,1,240
	b .L284
.L285:
	cmpwi 0,30,2
	bc 4,2,.L294
	lis 11,level@ha
	lwz 8,3460(31)
	lwz 9,level@l(11)
	lis 7,0x4330
	lis 0,0x1b4e
	lis 11,.LC82@ha
	ori 0,0,33205
	lwz 3,184(31)
	la 11,.LC82@l(11)
	subf 9,8,9
	lfd 12,0(11)
	mulhw 0,9,0
	lis 11,.LC83@ha
	la 11,.LC83@l(11)
	srawi 0,0,6
	lfd 11,0(11)
	lis 11,.LC84@ha
	la 11,.LC84@l(11)
	lfd 13,0(11)
	xoris 11,9,0x8000
	stw 11,532(1)
	srawi 9,9,31
	stw 7,528(1)
	subf 6,9,0
	lfd 0,528(1)
	fsub 0,0,12
	fdiv 0,0,11
	frsp 0,0
	fmr 11,0
	fcmpu 0,11,13
	bc 4,1,.L295
	lfs 12,3512(31)
	lis 9,.LC71@ha
	lfd 13,.LC71@l(9)
	fmr 0,12
	fmul 0,0,13
	fdiv 0,0,11
	frsp 0,0
	b .L296
.L295:
	lfs 12,3512(31)
	fmr 0,12
.L296:
	fmr 11,0
	lis 9,.LC72@ha
	lfd 0,.LC72@l(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L297
	li 8,999
	b .L298
.L297:
	lis 9,.LC73@ha
	lfd 0,.LC73@l(9)
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L299
	li 8,-99
	b .L298
.L299:
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfd 0,0(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L300
	lis 11,.LC85@ha
	la 11,.LC85@l(11)
	lfd 0,0(11)
	fadd 0,11,0
	b .L361
.L300:
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfd 0,0(9)
	fsub 0,11,0
.L361:
	fctiwz 13,0
	stfd 13,528(1)
	lwz 8,532(1)
.L298:
	fmr 1,12
	mr 7,3
	lis 4,.LC75@ha
	mr 5,25
	la 4,.LC75@l(4)
	mr 9,24
	addi 3,1,32
	creqv 6,6,6
	bl sprintf
	cmpwi 0,26,0
	addi 27,1,240
	mfcr 30
	b .L284
.L294:
	cmpwi 0,30,3
	bc 4,2,.L303
	lwz 11,3532(31)
	cmpwi 0,11,0
	bc 12,2,.L304
	xoris 11,11,0x8000
	lfs 12,3528(31)
	stw 11,532(1)
	lis 0,0x4330
	lis 11,.LC82@ha
	stw 0,528(1)
	la 11,.LC82@l(11)
	lfd 0,528(1)
	lfd 13,0(11)
	lfs 2,1804(31)
	fsub 0,0,13
	frsp 0,0
	fdivs 1,12,0
	b .L305
.L304:
	lfs 2,1804(31)
	fmr 1,2
.L305:
	lis 11,level@ha
	lwz 8,3460(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC82@ha
	lwz 6,184(31)
	subf 0,8,0
	la 11,.LC82@l(11)
	xoris 0,0,0x8000
	lfd 12,0(11)
	stw 0,532(1)
	lis 11,.LC83@ha
	stw 10,528(1)
	la 11,.LC83@l(11)
	lfd 0,528(1)
	lfd 13,0(11)
	lis 11,.LC84@ha
	fsub 0,0,12
	la 11,.LC84@l(11)
	lfd 11,0(11)
	fdiv 0,0,13
	frsp 0,0
	fmr 10,0
	fcmpu 0,10,11
	bc 4,1,.L307
	lfs 12,3512(31)
	lis 9,.LC71@ha
	lfd 13,.LC71@l(9)
	fmr 0,12
	fmul 0,0,13
	fdiv 0,0,10
	frsp 0,0
	b .L308
.L307:
	lfs 12,3512(31)
	fmr 0,12
.L308:
	fmr 11,0
	lis 9,.LC72@ha
	lfd 0,.LC72@l(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L309
	li 7,999
	b .L310
.L309:
	lis 9,.LC73@ha
	lfd 0,.LC73@l(9)
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L311
	li 7,-99
	b .L310
.L311:
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfd 0,0(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L312
	lis 11,.LC85@ha
	la 11,.LC85@l(11)
	lfd 0,0(11)
	fadd 0,11,0
	b .L362
.L312:
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfd 0,0(9)
	fsub 0,11,0
.L362:
	fctiwz 13,0
	stfd 13,528(1)
	lwz 7,532(1)
.L310:
	cmpwi 0,26,0
	fmr 3,12
	lis 4,.LC76@ha
	mr 5,25
	la 4,.LC76@l(4)
	addi 3,1,32
	addi 27,1,240
	mfcr 30
	creqv 6,6,6
	bl sprintf
	b .L284
.L303:
	cmpwi 0,30,4
	bc 4,2,.L315
	lwz 11,3532(31)
	cmpwi 0,11,0
	bc 12,2,.L316
	xoris 11,11,0x8000
	lfs 12,3528(31)
	stw 11,532(1)
	lis 0,0x4330
	lis 11,.LC82@ha
	stw 0,528(1)
	la 11,.LC82@l(11)
	lfd 0,528(1)
	lfd 13,0(11)
	lfs 2,1804(31)
	fsub 0,0,13
	frsp 0,0
	fdivs 1,12,0
	b .L317
.L316:
	lfs 2,1804(31)
	fmr 1,2
.L317:
	lfs 3,3512(31)
	cmpwi 0,26,0
	lis 4,.LC77@ha
	lwz 9,184(31)
	mr 5,25
	la 4,.LC77@l(4)
	lwz 6,3516(31)
	addi 3,1,32
	addi 27,1,240
	lwz 7,3520(31)
	mfcr 30
	lwz 8,3524(31)
	creqv 6,6,6
	bl sprintf
	b .L284
.L315:
	cmpwi 0,30,5
	bc 4,2,.L320
	lwz 11,3532(31)
	cmpwi 0,11,0
	bc 12,2,.L321
	xoris 11,11,0x8000
	lfs 12,3528(31)
	stw 11,532(1)
	lis 0,0x4330
	lis 11,.LC82@ha
	stw 0,528(1)
	la 11,.LC82@l(11)
	lfd 0,528(1)
	lfd 13,0(11)
	lfs 2,1804(31)
	fsub 0,0,13
	frsp 0,0
	fdivs 1,12,0
	b .L322
.L321:
	lfs 2,1804(31)
	fmr 1,2
.L322:
	lis 11,level@ha
	lwz 10,3460(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC82@ha
	mr 7,10
	subf 0,10,0
	la 11,.LC82@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,532(1)
	lis 11,.LC83@ha
	stw 8,528(1)
	la 11,.LC83@l(11)
	lfd 0,528(1)
	lfd 12,0(11)
	lis 11,.LC84@ha
	fsub 0,0,13
	la 11,.LC84@l(11)
	lfd 11,0(11)
	fdiv 0,0,12
	frsp 0,0
	fmr 10,0
	fcmpu 0,10,11
	bc 4,1,.L324
	lfs 12,3512(31)
	lis 9,.LC71@ha
	lfd 13,.LC71@l(9)
	fmr 0,12
	fmul 0,0,13
	fdiv 0,0,10
	frsp 0,0
	b .L325
.L324:
	lfs 12,3512(31)
	fmr 0,12
.L325:
	fmr 11,0
	lis 9,.LC72@ha
	lfd 0,.LC72@l(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L326
	li 3,999
	b .L327
.L326:
	lis 9,.LC73@ha
	lfd 0,.LC73@l(9)
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L328
	li 3,-99
	b .L327
.L328:
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfd 0,0(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L329
	lis 11,.LC85@ha
	la 11,.LC85@l(11)
	lfd 0,0(11)
	fadd 0,11,0
	b .L363
.L329:
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfd 0,0(9)
	fsub 0,11,0
.L363:
	fctiwz 13,0
	stfd 13,528(1)
	lwz 3,532(1)
.L327:
	lis 11,level@ha
	lis 9,0x1b4e
	lwz 10,184(31)
	lwz 0,level@l(11)
	ori 9,9,33205
	cmpwi 0,26,0
	fmr 3,12
	lwz 6,3516(31)
	lis 4,.LC78@ha
	mr 5,25
	subf 0,7,0
	lwz 8,3524(31)
	la 4,.LC78@l(4)
	mulhw 9,0,9
	lwz 7,3520(31)
	mfcr 30
	li 22,-96
	srawi 0,0,31
	stw 3,8(1)
	srawi 9,9,6
	addi 3,1,32
	stw 24,12(1)
	subf 9,0,9
	creqv 6,6,6
	bl sprintf
	addi 27,1,240
	b .L284
.L320:
	cmpwi 7,26,0
	addi 27,1,240
	cmpwi 0,30,6
	mfcr 30
	rlwinm 30,30,28,0xf0000000
	bc 4,2,.L284
	addi 4,1,496
	mr 3,31
	mr 29,4
	addi 26,31,740
	bl niq_getcurweapname
	lis 9,game@ha
	li 8,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,8,0
	bc 4,0,.L334
	mr 6,9
	lis 11,niq_weap_fire_times@ha
	lis 9,level@ha
	la 11,niq_weap_fire_times@l(11)
	la 3,level@l(9)
	lis 5,g_edicts@ha
	lis 4,.LC79@ha
	li 7,1332
.L336:
	lwz 0,g_edicts@l(5)
	add 10,0,7
	lwz 9,88(10)
	cmpwi 0,9,0
	bc 12,2,.L335
	lwz 0,84(10)
	cmpw 0,0,31
	bc 4,2,.L335
	lwz 0,1820(31)
	lwz 23,480(10)
	cmpwi 0,0,0
	bc 12,2,.L339
	lwz 9,1564(6)
	lfs 13,976(10)
	addi 9,9,-1
	lfs 12,4(3)
	slwi 9,9,2
	lfsx 0,11,9
	fadds 13,13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 4,3,.L334
	b .L343
.L339:
	lwz 0,3648(31)
	cmpwi 0,0,3
	bc 12,2,.L343
	lwz 9,3596(31)
	lwz 0,3604(31)
	or 0,0,9
	andi. 9,0,1
	bc 12,2,.L334
.L343:
	la 4,.LC79@l(4)
	mr 3,29
	bl strcat
	b .L334
.L335:
	lwz 0,1544(6)
	addi 8,8,1
	addi 7,7,1332
	cmpw 0,8,0
	bc 12,0,.L336
.L334:
	lwz 11,3532(31)
	cmpwi 0,11,0
	bc 12,2,.L345
	xoris 11,11,0x8000
	lfs 12,3528(31)
	stw 11,532(1)
	lis 0,0x4330
	lis 11,.LC82@ha
	stw 0,528(1)
	la 11,.LC82@l(11)
	lfd 0,528(1)
	lfd 13,0(11)
	lfs 2,1804(31)
	fsub 0,0,13
	frsp 0,0
	fdivs 1,12,0
	b .L346
.L345:
	lfs 2,1804(31)
	fmr 1,2
.L346:
	lis 11,level@ha
	lwz 8,3460(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC82@ha
	subf 0,8,0
	la 11,.LC82@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,532(1)
	lis 11,.LC83@ha
	stw 10,528(1)
	la 11,.LC83@l(11)
	lfd 0,528(1)
	lfd 12,0(11)
	lis 11,.LC84@ha
	fsub 0,0,13
	la 11,.LC84@l(11)
	lfd 11,0(11)
	fdiv 0,0,12
	frsp 0,0
	fmr 10,0
	fcmpu 0,10,11
	bc 4,1,.L348
	lfs 12,3512(31)
	lis 9,.LC71@ha
	lfd 13,.LC71@l(9)
	fmr 0,12
	fmul 0,0,13
	fdiv 0,0,10
	frsp 0,0
	b .L349
.L348:
	lfs 12,3512(31)
	fmr 0,12
.L349:
	fmr 11,0
	lis 9,.LC72@ha
	lfd 0,.LC72@l(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L350
	li 12,999
	b .L351
.L350:
	lis 9,.LC73@ha
	lfd 0,.LC73@l(9)
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L352
	li 12,-99
	b .L351
.L352:
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfd 0,0(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L353
	lis 11,.LC85@ha
	la 11,.LC85@l(11)
	lfd 0,0(11)
	fadd 0,11,0
	b .L364
.L353:
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfd 0,0(9)
	fsub 0,11,0
.L364:
	fctiwz 13,0
	stfd 13,528(1)
	lwz 12,532(1)
.L351:
	lis 11,game+1564@ha
	lis 9,level@ha
	lwz 7,3460(31)
	lwz 8,game+1564@l(11)
	lis 10,niqlist@ha
	lis 0,0x1b4e
	fmr 3,12
	lwz 3,level@l(9)
	la 10,niqlist@l(10)
	ori 0,0,33205
	mulli 8,8,36
	addi 10,10,28
	mr 6,29
	lwz 28,184(31)
	subf 3,7,3
	lwz 29,3524(31)
	lis 4,.LC80@ha
	lwzx 11,10,8
	mulhw 0,3,0
	la 4,.LC80@l(4)
	mr 5,25
	srawi 3,3,31
	lwz 9,3516(31)
	mr 7,23
	slwi 11,11,2
	srawi 0,0,6
	lwz 10,3520(31)
	lwzx 8,26,11
	subf 0,3,0
	li 22,-160
	stw 29,8(1)
	addi 3,1,32
	stw 0,12(1)
	stw 28,16(1)
	stw 12,20(1)
	stw 24,24(1)
	creqv 6,6,6
	bl sprintf
.L284:
	mtcrf 128,30
	bc 12,2,.L355
	lis 4,.LC81@ha
	mr 5,22
	la 4,.LC81@l(4)
	mr 6,21
	mr 3,27
	addi 7,1,32
	crxor 6,6,6
	bl sprintf
	b .L356
.L355:
	lis 4,.LC53@ha
	mr 5,22
	la 4,.LC53@l(4)
	mr 6,21
	mr 3,27
	addi 7,1,32
	crxor 6,6,6
	bl sprintf
.L356:
	mr 3,27
	bl strlen
	mr 30,3
	add 0,20,30
	cmpwi 0,0,1399
	bc 12,1,.L357
	add 3,19,20
	mr 4,27
	bl strcat
	mr 3,30
	b .L358
.L357:
	li 3,0
.L358:
	lwz 0,596(1)
	mtlr 0
	lmw 19,540(1)
	la 1,592(1)
	blr
.Lfe9:
	.size	 niq_sb_addcliententry,.Lfe9-niq_sb_addcliententry
	.section	".rodata"
	.align 3
.LC86:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl niq_sortclients
	.type	 niq_sortclients,@function
niq_sortclients:
	stwu 1,-2128(1)
	stmw 21,2084(1)
	lis 9,game@ha
	li 10,0
	la 9,game@l(9)
	mr 31,3
	lwz 0,1544(9)
	mr 24,4
	mr 23,5
	mr 28,6
	li 3,0
	cmpw 0,10,0
	bc 4,0,.L367
	mr 27,9
	lis 21,g_edicts@ha
	lis 9,.LC86@ha
	lis 22,0x4330
	la 9,.LC86@l(9)
	addi 25,1,8
	lfd 10,0(9)
	addi 26,1,1032
.L369:
	mulli 9,3,1332
	lwz 11,g_edicts@l(21)
	addi 30,3,1
	addi 9,9,1332
	add 11,11,9
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L368
	cmpw 0,11,24
	bc 4,2,.L371
	stw 3,0(28)
.L371:
	mulli 0,3,3968
	lwz 9,1028(27)
	add 11,0,9
	lwz 0,3532(11)
	lfs 11,3512(11)
	cmpwi 0,0,0
	bc 4,2,.L372
	lfs 12,1804(11)
	b .L373
.L372:
	xoris 0,0,0x8000
	lfs 13,3528(11)
	stw 0,2076(1)
	stw 22,2072(1)
	lfd 0,2072(1)
	fsub 0,0,10
	frsp 0,0
	fdivs 12,13,0
.L373:
	li 5,0
	addi 4,1,8
	cmpw 0,5,10
	addi 7,1,1032
	addi 29,10,1
	addi 30,3,1
	bc 4,0,.L375
	lfs 0,0(25)
	fcmpu 0,11,0
	bc 12,1,.L375
	bc 4,2,.L376
	lfs 0,0(26)
	fcmpu 0,12,0
	bc 12,0,.L375
.L376:
	addi 5,5,1
	cmpw 0,5,10
	bc 4,0,.L375
	slwi 0,5,2
	lfsx 0,4,0
	fcmpu 0,11,0
	bc 12,1,.L375
	bc 4,2,.L376
	lfsx 0,7,0
	fcmpu 0,12,0
	bc 4,0,.L376
.L375:
	cmpw 0,10,5
	mr 8,10
	slwi 6,5,2
	bc 4,1,.L382
	slwi 9,10,2
	mr 12,4
	mr 11,9
	mr 10,7
	addi 9,9,-4
.L384:
	lwzx 0,9,31
	addi 8,8,-1
	cmpw 0,8,5
	stwx 0,11,31
	lfsx 0,9,12
	stfsx 0,11,12
	lfsx 13,9,10
	addi 9,9,-4
	stfsx 13,11,10
	addi 11,11,-4
	bc 12,1,.L384
.L382:
	stwx 3,6,31
	mr 10,29
	stfsx 11,4,6
	stfsx 12,7,6
.L368:
	lwz 0,1544(27)
	mr 3,30
	cmpw 0,3,0
	bc 12,0,.L369
.L367:
	li 3,0
	cmpw 0,3,10
	bc 4,0,.L388
	lwz 0,0(28)
	lwz 9,0(31)
	mr 11,0
	cmpw 0,9,0
	b .L393
.L389:
	addi 3,3,1
	cmpw 0,3,10
	bc 4,0,.L388
	slwi 0,3,2
	lwzx 9,31,0
	cmpw 0,9,11
.L393:
	bc 4,2,.L389
	stw 3,0(28)
.L388:
	stw 10,0(23)
	lmw 21,2084(1)
	la 1,2128(1)
	blr
.Lfe10:
	.size	 niq_sortclients,.Lfe10-niq_sortclients
	.section	".rodata"
	.align 2
.LC87:
	.long 0x4b18967f
	.align 3
.LC88:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 niq_deathmatchscoreboard,@function
niq_deathmatchscoreboard:
	stwu 1,-2512(1)
	mflr 0
	stfd 31,2504(1)
	stmw 22,2464(1)
	stw 0,2516(1)
	mr 29,3
	li 0,-1
	addi 3,1,1416
	stw 0,2444(1)
	mr 4,29
	mr 22,3
	addi 5,1,2440
	addi 6,1,2444
	li 24,0
	bl niq_sortclients
	lwz 9,84(29)
	lwz 25,1808(9)
	cmpwi 0,25,5
	bc 4,2,.L395
	li 7,6
	b .L396
.L395:
	xori 0,25,6
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	nor 0,9,9
	rlwinm 9,9,0,28,29
	rlwinm 0,0,0,29,30
	or 7,9,0
.L396:
	lwz 0,2440(1)
	lis 8,0x4330
	lis 11,.LC88@ha
	xoris 0,0,0x8000
	la 11,.LC88@l(11)
	stw 0,2460(1)
	stw 8,2456(1)
	lfd 13,0(11)
	lfd 0,2456(1)
	lis 11,niq_sblines@ha
	lwz 10,niq_sblines@l(11)
	fsub 0,0,13
	lfs 12,20(10)
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L398
	fmr 0,12
	fctiwz 13,0
	stfd 13,2456(1)
	lwz 9,2460(1)
	stw 9,2440(1)
.L398:
	lwz 0,2440(1)
	cmpwi 0,0,0
	bc 12,1,.L399
	stw 7,2440(1)
.L399:
	lwz 0,2440(1)
	cmpw 0,0,7
	bc 4,1,.L400
	stw 7,2440(1)
.L400:
	li 0,0
	addi 3,1,8
	stb 0,8(1)
	mr 4,25
	li 27,0
	bl niq_sb_addmaintitles
	li 29,0
	addi 3,1,8
	bl strlen
	lwz 0,2440(1)
	lis 9,.LC87@ha
	mr 31,3
	lfs 31,.LC87@l(9)
	cmpw 0,27,0
	bc 4,0,.L402
	lis 9,game@ha
	li 26,60
	la 23,game@l(9)
	mr 28,22
.L404:
	lwz 0,0(28)
	lwz 9,1028(23)
	addi 28,28,4
	mulli 0,0,3968
	add 30,9,0
	lfs 0,3512(30)
	fcmpu 0,0,31
	bc 4,0,.L405
	fmr 31,0
	addi 27,27,1
.L405:
	lwz 9,2444(1)
	mr 3,31
	addi 4,1,8
	mr 5,30
	mr 6,25
	mr 7,27
	mr 8,26
	xor 9,29,9
	subfic 0,9,0
	adde 9,0,9
	bl niq_sb_addcliententry
	mr. 24,3
	bc 12,2,.L408
	lwz 0,2440(1)
	addi 29,29,1
	add 31,31,24
	addi 26,26,10
	cmpw 0,29,0
	bc 12,0,.L404
.L402:
	cmpwi 0,24,0
	bc 12,2,.L408
	lwz 9,2444(1)
	lwz 0,2440(1)
	mr 10,9
	cmpw 0,9,0
	mr 11,0
	bc 12,0,.L408
	cmpw 0,11,10
	mr 29,11
	bc 12,1,.L410
	lis 9,game+1028@ha
	slwi 0,11,2
	lwz 8,game+1028@l(9)
	add 3,0,22
	mr 9,10
.L412:
	lwz 0,0(3)
	addi 3,3,4
	mulli 0,0,3968
	add 30,8,0
	lfs 0,3512(30)
	fcmpu 0,0,31
	bc 4,0,.L411
	fmr 31,0
	addi 27,27,1
.L411:
	addi 29,29,1
	cmpw 0,29,9
	bc 4,1,.L412
.L410:
	cmpw 0,10,11
	bc 4,2,.L415
	mulli 9,11,10
	addi 8,9,60
	b .L416
.L415:
	mulli 9,11,10
	addi 8,9,70
.L416:
	mr 3,31
	mr 5,30
	mr 6,25
	mr 7,27
	addi 4,1,8
	li 9,1
	bl niq_sb_addcliententry
	add 31,31,3
.L408:
	cmpwi 0,31,1299
	bc 12,1,.L417
	lis 28,szSBHelp@ha
	addi 29,1,8
	add 29,29,31
	la 3,szSBHelp@l(28)
	bl strlen
	subfic 5,3,40
	lis 4,.LC53@ha
	mr 3,29
	la 4,.LC53@l(4)
	slwi 5,5,2
	la 7,szSBHelp@l(28)
	li 6,200
	crxor 6,6,6
	bl sprintf
.L417:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	addi 3,1,8
	mtlr 0
	blrl
	lwz 0,2516(1)
	mtlr 0
	lmw 22,2464(1)
	lfd 31,2504(1)
	la 1,2512(1)
	blr
.Lfe11:
	.size	 niq_deathmatchscoreboard,.Lfe11-niq_deathmatchscoreboard
	.section	".rodata"
	.align 2
.LC89:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_deathmatchscoreboardmessage
	.type	 niq_deathmatchscoreboardmessage,@function
niq_deathmatchscoreboardmessage:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr. 31,3
	mr 30,5
	bc 12,2,.L418
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L418
	lwz 8,1820(10)
	cmpwi 0,8,0
	bc 4,2,.L418
	lis 11,.LC89@ha
	lis 9,ctf@ha
	la 11,.LC89@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L422
	lwz 0,1808(10)
	cmpwi 0,0,8
	bc 4,2,.L422
	lis 9,niq_handicap@ha
	lwz 11,niq_handicap@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L423
	li 0,3
	stw 0,1808(10)
	b .L422
.L423:
	stw 8,1808(10)
.L422:
	lis 9,.LC89@ha
	lis 11,niq_sbdebug@ha
	la 9,.LC89@l(9)
	lfs 13,0(9)
	lwz 9,niq_sbdebug@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L425
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,6
	bc 4,2,.L425
	li 0,7
	stw 0,1808(9)
.L425:
	lis 9,.LC89@ha
	lis 11,niq_sbwide@ha
	la 9,.LC89@l(9)
	lfs 13,0(9)
	lwz 9,niq_sbwide@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L426
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,4
	bc 4,1,.L426
	cmpwi 0,0,6
	bc 12,1,.L429
	li 0,7
	stw 0,1808(9)
.L426:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,6
	bc 4,1,.L427
.L429:
	mr 3,31
	bl DeathmatchScoreboardMessage
	b .L428
.L427:
	mr 3,31
	bl niq_deathmatchscoreboard
.L428:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	mr 4,30
	mtlr 0
	blrl
.L418:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 niq_deathmatchscoreboardmessage,.Lfe12-niq_deathmatchscoreboardmessage
	.section	".sdata","aw"
	.align 2
	.type	 bDFEnabled.84,@object
	.size	 bDFEnabled.84,4
bDFEnabled.84:
	.long 0
	.section	".rodata"
	.align 2
.LC90:
	.long 0x0
	.align 3
.LC91:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC92:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl niq_checktimers
	.type	 niq_checktimers,@function
niq_checktimers:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L440
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L440
	lwz 31,84(3)
	cmpwi 0,31,0
	bc 12,2,.L440
	lwz 0,184(3)
	andi. 9,0,1
	bc 4,2,.L440
	lis 11,.LC90@ha
	lis 9,ctf@ha
	la 11,.LC90@l(11)
	lfs 31,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L445
	lwz 0,3464(31)
	cmpwi 0,0,0
	bc 12,2,.L440
.L445:
	lis 9,level+4@ha
	lfs 13,3948(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L440
	lis 9,niq_auto@ha
	lwz 11,niq_auto@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L447
	mr 4,31
	bl niq_incrementhealth
.L447:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,8192
	bc 4,2,.L448
	mr 3,31
	bl niq_incrementammo
.L448:
	lis 9,niq_handicap@ha
	lwz 11,niq_handicap@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L449
	lfs 0,3528(31)
	lis 11,bDFEnabled.84@ha
	li 0,1
	lfs 13,1804(31)
	lwz 9,3532(31)
	fadds 0,0,13
	addi 9,9,1
	stw 9,3532(31)
	stfs 0,3528(31)
	stw 0,bDFEnabled.84@l(11)
	b .L451
.L449:
	lis 9,bDFEnabled.84@ha
	lwz 0,bDFEnabled.84@l(9)
	cmpwi 0,0,0
	bc 12,2,.L452
	lis 9,game@ha
	li 30,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,30,0
	bc 12,1,.L462
	mr 26,9
	lis 27,g_edicts@ha
	lis 9,.LC91@ha
	lis 28,0x3f80
	la 9,.LC91@l(9)
	li 29,1332
	lfd 31,0(9)
.L455:
	lwz 0,g_edicts@l(27)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L457
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L457
	lfs 0,1804(9)
	fcmpu 0,0,31
	bc 12,2,.L457
	stw 28,1804(9)
	lwz 9,84(3)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L457
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L457:
	lwz 0,1544(26)
	addi 30,30,1
	addi 29,29,1332
	cmpw 0,30,0
	bc 4,1,.L455
.L462:
	lis 9,bDFEnabled.84@ha
	li 0,0
	stw 0,bDFEnabled.84@l(9)
.L452:
	lwz 9,3532(31)
	cmpwi 0,9,0
	bc 12,2,.L451
	lfs 0,3528(31)
	addi 0,9,1
	lfs 13,1804(31)
	stw 0,3532(31)
	fadds 0,0,13
	stfs 0,3528(31)
.L451:
	lis 11,.LC92@ha
	lis 9,level+4@ha
	la 11,.LC92@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,3948(31)
.L440:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 niq_checktimers,.Lfe13-niq_checktimers
	.section	".rodata"
	.align 2
.LC93:
	.string	"Grapple"
	.align 2
.LC94:
	.string	"misc/w_pkup.wav"
	.align 2
.LC95:
	.long 0x0
	.align 2
.LC96:
	.long 0x3f800000
	.section	".text"
	.align 2
	.type	 niq_changeclientweapon,@function
niq_changeclientweapon:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 25,3
	lwz 29,84(25)
	cmpwi 0,29,0
	bc 12,2,.L475
	lwz 0,480(25)
	cmpwi 0,0,0
	bc 4,1,.L475
	lis 9,niqlist@ha
	mulli 0,4,36
	la 8,niqlist@l(9)
	mulli 5,5,36
	addi 9,8,24
	addi 11,8,28
	lwzx 27,9,0
	mr 24,0
	addi 10,8,8
	lwzx 26,11,0
	lwzx 31,9,5
	addi 9,27,-1
	addi 0,26,-1
	lwzx 30,11,5
	or 9,27,9
	or 0,26,0
	lwzx 11,10,5
	srwi 9,9,31
	srwi 0,0,31
	or. 10,9,0
	bc 4,2,.L475
	addi 9,31,-1
	addi 0,30,-1
	or 9,31,9
	or 0,30,0
	srwi 9,9,31
	srwi 0,0,31
	or. 10,9,0
	bc 4,2,.L475
	cmpwi 7,11,0
	bc 12,28,.L475
	cmpwi 0,30,999
	addi 28,29,740
	bc 12,2,.L480
	addi 10,8,20
	slwi 8,30,2
	bc 12,30,.L483
	lwzx 9,10,5
	lwzx 0,28,8
	cmpw 0,0,9
	bc 12,1,.L480
.L483:
	lwzx 9,10,5
	cmpw 7,11,9
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,11,0
	or 0,0,9
	stwx 0,28,8
.L480:
	lwz 8,84(25)
	lis 9,ctf@ha
	slwi 11,31,2
	lwz 10,ctf@l(9)
	li 0,1
	stw 30,3592(8)
	lis 9,.LC95@ha
	la 9,.LC95@l(9)
	stwx 0,28,11
	lfs 13,0(9)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L486
	lis 9,grapple@ha
	lwz 11,grapple@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L485
.L486:
	lwz 3,1788(29)
	cmpwi 0,3,0
	bc 12,2,.L489
	lwz 3,40(3)
	cmpwi 0,3,0
	bc 12,2,.L489
	lis 4,.LC93@ha
	la 4,.LC93@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L488
	lwz 0,3612(29)
	cmpwi 0,0,0
	bc 12,2,.L489
.L488:
.L485:
	mulli 0,31,72
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 0,0,9
	stw 0,3612(29)
.L489:
	cmpw 0,27,31
	bc 12,2,.L490
	slwi 9,27,2
	li 0,0
	stwx 0,28,9
.L490:
	xori 0,26,999
	xor 10,26,30
	addic 9,0,-1
	subfe 11,9,0
	addic 0,10,-1
	subfe 9,0,10
	and. 10,11,9
	bc 12,2,.L491
	lwz 7,84(25)
	cmpwi 0,7,0
	bc 12,2,.L491
	lis 9,niqlist@ha
	li 0,0
	la 9,niqlist@l(9)
	addi 7,7,740
	addi 8,9,20
	lwzx 11,8,24
	addi 9,9,28
	lwzx 10,9,24
	cmpw 7,0,11
	slwi 10,10,2
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	and 11,11,0
	stwx 11,7,10
.L491:
	lis 11,.LC95@ha
	lis 9,ctf@ha
	lwz 30,736(29)
	la 11,.LC95@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L497
	lis 9,grapple@ha
	lwz 11,grapple@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L496
.L497:
	lwz 3,1788(29)
	cmpwi 0,3,0
	bc 12,2,.L500
	lwz 3,40(3)
	cmpwi 0,3,0
	bc 12,2,.L500
	lis 4,.LC93@ha
	la 4,.LC93@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L499
	lwz 0,3612(29)
	cmpwi 0,0,0
	bc 12,2,.L500
.L499:
.L496:
	stw 31,736(29)
.L500:
	lwz 9,736(29)
	li 0,0
	stw 0,3952(29)
	cmpw 0,30,9
	stw 0,3816(29)
	bc 12,2,.L501
	mr 3,25
	bl ChangeWeapon
.L501:
	lis 9,.LC95@ha
	lis 11,niq_sndswitch@ha
	la 9,.LC95@l(9)
	lfs 13,0(9)
	lwz 9,niq_sndswitch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L475
	lis 29,gi@ha
	lis 3,.LC94@ha
	la 29,gi@l(29)
	la 3,.LC94@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC96@ha
	lis 10,.LC96@ha
	lis 11,.LC95@ha
	mr 5,3
	la 9,.LC96@l(9)
	la 10,.LC96@l(10)
	mtlr 0
	la 11,.LC95@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,25
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L475:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 niq_changeclientweapon,.Lfe14-niq_changeclientweapon
	.section	".rodata"
	.align 2
.LC97:
	.long 0x0
	.align 2
.LC98:
	.long 0x3f800000
	.align 3
.LC99:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 niq_changeweapon,@function
niq_changeweapon:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	lis 9,game@ha
	li 3,0
	la 30,game@l(9)
	lis 23,maxclients@ha
	lwz 24,1564(30)
	bl niq_selectcurrentweapon
	lis 9,.LC97@ha
	lis 11,niq_msgswitch@ha
	la 9,.LC97@l(9)
	lfs 13,0(9)
	lwz 9,niq_msgswitch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L504
	lwz 0,1564(30)
	lis 9,niqlist@ha
	li 31,1
	lwz 11,1544(30)
	la 9,niqlist@l(9)
	mulli 0,0,36
	addi 9,9,32
	cmpw 0,31,11
	lwzx 29,9,0
	bc 12,1,.L504
	lis 9,gi@ha
	mr 25,30
	la 26,gi@l(9)
	lis 27,g_edicts@ha
	lis 28,.LC32@ha
	li 30,1332
.L507:
	lwz 0,g_edicts@l(27)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L509
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L509
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 4,2,.L509
	lwz 0,184(3)
	andi. 11,0,1
	bc 4,2,.L509
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 4,2,.L509
	lwz 9,12(26)
	la 4,.LC32@l(28)
	mr 5,29
	mtlr 9
	crxor 6,6,6
	blrl
.L509:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1332
	cmpw 0,31,0
	bc 4,1,.L507
.L504:
	lis 11,.LC98@ha
	lis 9,maxclients@ha
	la 11,.LC98@l(11)
	li 30,1
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L519
	lis 9,game@ha
	lis 27,g_edicts@ha
	la 28,game@l(9)
	lis 29,0x4330
	lis 9,.LC99@ha
	li 31,1332
	la 9,.LC99@l(9)
	lfd 31,0(9)
.L521:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L520
	lwz 5,1564(28)
	mr 4,24
	bl niq_changeclientweapon
.L520:
	addi 30,30,1
	lwz 11,maxclients@l(23)
	xoris 0,30,0x8000
	addi 31,31,1332
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L521
.L519:
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe15:
	.size	 niq_changeweapon,.Lfe15-niq_changeweapon
	.section	".sdata","aw"
	.align 2
	.type	 fSavedTime.97,@object
	.size	 fSavedTime.97,4
fSavedTime.97:
	.long 0xbf800000
	.align 2
	.type	 bDidIntermission.98,@object
	.size	 bDidIntermission.98,4
bDidIntermission.98:
	.long 0
	.section	".rodata"
	.align 2
.LC100:
	.string	"items/damage2.wav"
	.align 2
.LC101:
	.long 0x0
	.align 2
.LC102:
	.long 0xbf800000
	.align 3
.LC103:
	.long 0xbff00000
	.long 0x0
	.align 3
.LC104:
	.long 0x0
	.long 0x0
	.align 3
.LC105:
	.long 0x40080000
	.long 0x0
	.align 2
.LC106:
	.long 0x3f800000
	.align 3
.LC107:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl niq_checkiftimetochangeweapon
	.type	 niq_checkiftimetochangeweapon,@function
niq_checkiftimetochangeweapon:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 23,28(1)
	stw 0,84(1)
	lis 9,game+2388@ha
	lwz 0,game+2388@l(9)
	cmpwi 0,0,1
	bc 12,2,.L524
	lis 9,deathmatch@ha
	lis 8,.LC101@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC101@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L526
	lis 9,niq_auto@ha
	lwz 11,niq_auto@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L526
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 12,2,.L528
	lis 9,.LC102@ha
	lis 11,niq_weapkills@ha
	la 9,.LC102@l(9)
	lfs 13,0(9)
	lwz 9,niq_weapkills@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L524
	lis 31,bDidIntermission.98@ha
	lwz 0,bDidIntermission.98@l(31)
	cmpwi 0,0,0
	bc 4,2,.L524
	b .L562
.L528:
	lis 9,bDidIntermission.98@ha
	li 0,0
	stw 0,bDidIntermission.98@l(9)
	b .L524
.L526:
	lis 9,level@ha
	lis 8,.LC101@ha
	la 8,.LC101@l(8)
	la 10,level@l(9)
	lfs 13,0(8)
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 12,2,.L531
	lis 11,.LC102@ha
	lis 9,game+1576@ha
	la 11,.LC102@l(11)
	lfs 0,game+1576@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L532
	lis 31,bDidIntermission.98@ha
	lwz 0,bDidIntermission.98@l(31)
	cmpwi 0,0,0
	bc 4,2,.L532
.L562:
	bl niq_changeweapon
	li 0,1
	stw 0,bDidIntermission.98@l(31)
	b .L524
.L532:
	lis 10,fSavedTime.97@ha
	lis 8,.LC103@ha
	lfs 0,fSavedTime.97@l(10)
	la 8,.LC103@l(8)
	lfd 13,0(8)
	fcmpu 0,0,13
	bc 4,2,.L524
	lis 9,game+1576@ha
	lis 11,level+4@ha
	lfs 0,game+1576@l(9)
	lfs 13,level+4@l(11)
	lis 9,.LC104@ha
	la 9,.LC104@l(9)
	lfd 11,0(9)
	fsubs 0,0,13
	fmr 12,0
	stfs 0,fSavedTime.97@l(10)
	fcmpu 0,12,11
	bc 4,0,.L524
	li 0,0
	stw 0,fSavedTime.97@l(10)
	b .L524
.L531:
	lis 11,fSavedTime.97@ha
	lis 8,.LC103@ha
	lfs 12,fSavedTime.97@l(11)
	la 8,.LC103@l(8)
	lis 9,bDidIntermission.98@ha
	lfd 13,0(8)
	li 0,0
	stw 0,bDidIntermission.98@l(9)
	fmr 0,12
	fcmpu 0,0,13
	bc 12,2,.L535
	lis 9,game@ha
	lis 8,.LC102@ha
	la 8,.LC102@l(8)
	la 9,game@l(9)
	lfs 13,0(8)
	lfs 0,1576(9)
	fcmpu 0,0,13
	bc 12,2,.L536
	lfs 0,4(10)
	fadds 0,0,12
	stfs 0,1576(9)
.L536:
	stfs 13,fSavedTime.97@l(11)
.L535:
	lis 9,niq_weapsecs@ha
	lis 11,.LC102@ha
	lwz 10,niq_weapsecs@l(9)
	la 11,.LC102@l(11)
	lfs 13,0(11)
	lfs 12,20(10)
	fcmpu 7,12,13
	bc 4,30,.L537
	lis 9,game+1576@ha
	lis 11,niq_prevwsecs@ha
	stfs 13,game+1576@l(9)
	lfs 0,20(10)
	stfs 0,niq_prevwsecs@l(11)
	b .L539
.L537:
	lis 9,niq_prevwsecs@ha
	lis 8,niq_prevwsecs@ha
	lfs 0,niq_prevwsecs@l(9)
	fcmpu 0,0,13
	bc 4,2,.L540
	bc 4,30,.L563
.L540:
	lis 9,niq_weapsecs@ha
	lis 11,niq_prevwsecs@ha
	lwz 10,niq_weapsecs@l(9)
	lfs 0,niq_prevwsecs@l(11)
	lfs 12,20(10)
	fcmpu 0,12,0
	bc 4,1,.L543
.L563:
	lis 9,level+4@ha
	lis 11,game+1576@ha
	lfs 0,level+4@l(9)
	fadds 0,0,12
	stfs 0,game+1576@l(11)
	lfs 13,20(10)
	stfs 13,niq_prevwsecs@l(8)
	b .L539
.L543:
	lis 9,level+4@ha
	lis 11,game@ha
	lfs 13,level+4@l(9)
	la 11,game@l(11)
	lfs 0,1576(11)
	fadds 13,13,12
	fcmpu 0,13,0
	bc 4,0,.L539
	stfs 13,1576(11)
	lfs 0,20(10)
	stfs 0,niq_prevwsecs@l(8)
.L539:
	lis 9,game@ha
	lis 8,.LC102@ha
	la 8,.LC102@l(8)
	la 30,game@l(9)
	lfs 0,0(8)
	lfs 12,1576(30)
	fcmpu 0,12,0
	bc 12,2,.L524
	lis 9,level@ha
	la 31,level@l(9)
	lfs 11,4(31)
	fcmpu 0,12,11
	bc 4,0,.L549
	bl niq_changeweapon
	lis 11,niq_weapsecs@ha
	lfs 13,4(31)
	lis 10,niq_prevwsecs@ha
	lwz 9,niq_weapsecs@l(11)
	lfs 0,20(9)
	fadds 13,13,0
	stfs 13,1576(30)
	lfs 0,20(9)
	stfs 0,niq_prevwsecs@l(10)
	b .L524
.L549:
	lis 11,niq_sndwarn@ha
	lis 8,.LC101@ha
	lwz 9,niq_sndwarn@l(11)
	la 8,.LC101@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L524
	fsubs 0,12,11
	lis 9,.LC105@ha
	la 9,.LC105@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L524
	lis 11,.LC106@ha
	lis 9,maxclients@ha
	la 11,.LC106@l(11)
	li 29,1
	lfs 13,0(11)
	lis 23,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L524
	lis 9,gi@ha
	lis 8,.LC101@ha
	la 28,gi@l(9)
	la 8,.LC101@l(8)
	lis 9,.LC107@ha
	lfs 30,0(8)
	lis 24,g_edicts@ha
	la 9,.LC107@l(9)
	lis 25,ctf@ha
	lfd 31,0(9)
	lis 26,.LC100@ha
	lis 27,0x4330
	li 30,1332
.L557:
	lwz 0,g_edicts@l(24)
	add 31,0,30
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L556
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L556
	lwz 9,ctf@l(25)
	lfs 0,20(9)
	fcmpu 0,0,30
	bc 12,2,.L560
	lwz 0,3464(11)
	cmpwi 0,0,0
	bc 12,2,.L524
.L560:
	lwz 9,36(28)
	la 3,.LC100@l(26)
	mtlr 9
	blrl
	lis 8,.LC106@ha
	lwz 11,16(28)
	lis 9,.LC106@ha
	la 8,.LC106@l(8)
	mr 5,3
	lfs 1,0(8)
	la 9,.LC106@l(9)
	li 4,3
	mtlr 11
	lis 8,.LC101@ha
	mr 3,31
	lfs 2,0(9)
	la 8,.LC101@l(8)
	lfs 3,0(8)
	blrl
.L556:
	addi 29,29,1
	lwz 11,maxclients@l(23)
	xoris 0,29,0x8000
	addi 30,30,1332
	stw 0,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L557
.L524:
	lwz 0,84(1)
	mtlr 0
	lmw 23,28(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe16:
	.size	 niq_checkiftimetochangeweapon,.Lfe16-niq_checkiftimetochangeweapon
	.section	".rodata"
	.align 2
.LC108:
	.string	"gamedir"
	.align 2
.LC109:
	.string	"\\"
	.align 2
.LC110:
	.string	"ctf/"
	.align 2
.LC111:
	.string	"niq/"
	.align 2
.LC112:
	.string	"r"
	.align 2
.LC113:
	.string	"NIQ: file '%s' not found in gamedir or in default dir -- using defaults.\n"
	.align 2
.LC114:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_fopen,@function
niq_fopen:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	lis 9,.LC54@ha
	mr 30,3
	lbz 0,.LC54@l(9)
	mr 29,4
	addi 3,1,9
	li 4,0
	li 5,127
	stb 0,8(1)
	crxor 6,6,6
	bl memset
	lis 9,gi+144@ha
	lis 3,.LC108@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC1@ha
	la 3,.LC108@l(3)
	la 4,.LC1@l(4)
	li 5,4
	mtlr 0
	blrl
	mr. 3,3
	bc 12,2,.L574
	lwz 4,4(3)
	lbz 0,0(4)
	cmpwi 0,0,0
	bc 12,2,.L574
	addi 3,1,8
	bl strcpy
	lis 4,.LC109@ha
	addi 3,1,8
	la 4,.LC109@l(4)
	bl strcat
	b .L575
.L574:
	lis 9,.LC114@ha
	lis 11,ctf@ha
	la 9,.LC114@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L576
	lis 9,.LC110@ha
	la 11,.LC110@l(9)
	lwz 0,.LC110@l(9)
	b .L579
.L576:
	lis 9,.LC111@ha
	la 11,.LC111@l(9)
	lwz 0,.LC111@l(9)
.L579:
	lbz 10,4(11)
	stw 0,8(1)
	stb 10,12(1)
.L575:
	mr 4,30
	addi 3,1,8
	bl strcat
	lis 4,.LC112@ha
	addi 3,1,8
	la 4,.LC112@l(4)
	bl fopen
	subfic 0,29,0
	adde 9,0,29
	mr 31,3
	subfic 11,31,0
	adde 0,11,31
	and. 11,0,9
	bc 12,2,.L578
	lis 9,gi+4@ha
	lis 3,.LC113@ha
	lwz 0,gi+4@l(9)
	la 3,.LC113@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
.L578:
	mr 3,31
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe17:
	.size	 niq_fopen,.Lfe17-niq_fopen
	.section	".rodata"
	.align 2
.LC115:
	.string	"niqmotd.txt"
	.align 2
.LC116:
	.string	"NIQ: more than %d motd lines, extra lines ignored.\n"
	.align 2
.LC117:
	.string	"niqweaps.txt"
	.align 2
.LC118:
	.string	"superblaster"
	.align 2
.LC119:
	.string	"NIQ: invalid weapon list item at line %d, resetting default list.\n"
	.align 2
.LC120:
	.string	"NIQ: more than %d weapons specified, no more weapons accepted.\n"
	.section	".text"
	.align 2
	.globl niq_loadweaponlist
	.type	 niq_loadweaponlist,@function
niq_loadweaponlist:
	stwu 1,-320(1)
	mflr 0
	stmw 20,272(1)
	stw 0,324(1)
	lis 9,game@ha
	li 27,0
	la 9,game@l(9)
	lis 3,.LC117@ha
	stw 27,2388(9)
	la 3,.LC117@l(3)
	li 4,0
	bl niq_fopen
	lis 24,game@ha
	mr. 26,3
	bc 12,2,.L589
	lis 23,.LC0@ha
	lis 9,gi@ha
	lis 11,niqlist@ha
	la 25,gi@l(9)
	la 20,niqlist@l(11)
	la 21,.LC0@l(23)
	addi 22,1,8
	b .L590
.L592:
	lbz 11,8(1)
	addi 27,27,1
	xori 9,11,47
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,35
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L590
	cmpwi 0,11,32
	bc 12,2,.L590
	cmpwi 0,11,10
	bc 12,2,.L590
	addi 3,1,8
	bl strlen
	cmplwi 0,3,1
	bc 4,1,.L590
	lis 4,.LC118@ha
	addi 3,1,8
	la 4,.LC118@l(4)
	li 5,12
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L596
	lwz 0,.LC0@l(23)
	lwz 9,4(21)
	stw 0,8(1)
	stw 9,4(22)
.L596:
	li 30,1
	li 28,0
	addi 31,20,36
.L599:
	lwz 29,0(31)
	mr 3,29
	bl strlen
	mr 5,3
	mr 4,29
	addi 3,1,8
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L600
	li 28,1
	b .L597
.L600:
	addi 31,31,36
	addi 30,30,1
.L597:
	cmpwi 7,30,10
	cmpwi 6,28,0
	cror 31,30,28
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,27,1
	and. 10,9,0
	bc 4,2,.L599
	bc 4,26,.L603
	lwz 0,4(25)
	lis 3,.LC119@ha
	mr 4,27
	la 3,.LC119@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	la 9,game@l(24)
	stw 28,2388(9)
	b .L591
.L603:
	la 10,game@l(24)
	lwz 9,2388(10)
	cmpwi 0,9,99
	bc 4,1,.L604
	lwz 0,4(25)
	lis 3,.LC120@ha
	li 4,100
	la 3,.LC120@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L591
.L604:
	addi 0,9,1
	addi 11,10,1580
	slwi 9,0,2
	stw 0,2388(10)
	stwx 30,11,9
.L590:
	addi 3,1,8
	li 4,80
	mr 5,26
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L592
.L591:
	mr 3,26
	bl fclose
.L589:
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,2388(9)
	cmpwi 0,0,0
	bc 4,2,.L606
	li 0,10
	addi 9,9,1584
	mtctr 0
	li 30,1
.L617:
	stw 30,0(9)
	addi 9,9,4
	addi 30,30,1
	bdnz .L617
	lis 9,game+2388@ha
	li 0,10
	stw 0,game+2388@l(9)
.L606:
	lis 9,game@ha
	li 30,1
	la 9,game@l(9)
	lwz 0,2388(9)
	cmpw 0,30,0
	bc 12,1,.L613
	li 10,0
	addi 11,9,1988
.L615:
	stw 10,0(11)
	addi 30,30,1
	lwz 0,2388(9)
	addi 11,11,4
	cmpw 0,30,0
	bc 4,1,.L615
.L613:
	lwz 0,324(1)
	mtlr 0
	lmw 20,272(1)
	la 1,320(1)
	blr
.Lfe18:
	.size	 niq_loadweaponlist,.Lfe18-niq_loadweaponlist
	.section	".rodata"
	.align 2
.LC121:
	.string	"niqammo.txt"
	.align 2
.LC122:
	.string	"%d %d %d %d\n"
	.align 2
.LC123:
	.string	"NIQ: invalid ammo list item at line %d.\n"
	.section	".text"
	.align 2
	.globl niq_loadammolist
	.type	 niq_loadammolist,@function
niq_loadammolist:
	stwu 1,-336(1)
	mflr 0
	stmw 20,288(1)
	stw 0,340(1)
	lis 3,.LC121@ha
	li 4,0
	la 3,.LC121@l(3)
	li 25,0
	bl niq_fopen
	mr. 26,3
	bc 12,2,.L619
	lis 9,niqlist+8@ha
	lis 11,gi@ha
	la 24,niqlist+8@l(9)
	la 20,gi@l(11)
	addi 21,24,4
	addi 22,24,8
	addi 23,24,12
	b .L620
.L635:
	lwzx 3,27,30
	bl strlen
	addi 0,1,8
	lis 4,.LC122@ha
	add 3,0,3
	la 4,.LC122@l(4)
	addi 5,1,264
	addi 6,1,268
	addi 7,1,272
	addi 8,1,276
	crxor 6,6,6
	bl sscanf
	lwz 9,264(1)
	lwz 0,276(1)
	stwx 9,24,30
	lwz 11,268(1)
	stwx 0,23,30
	lwz 10,272(1)
	stwx 11,21,30
	stwx 10,22,30
	b .L627
.L622:
	lbz 11,8(1)
	addi 25,25,1
	xori 9,11,47
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,35
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L620
	cmpwi 0,11,32
	bc 12,2,.L620
	cmpwi 0,11,10
	bc 12,2,.L620
	addi 3,1,8
	bl strlen
	cmplwi 0,3,1
	bc 4,1,.L620
	lis 9,niqlist@ha
	li 28,1
	la 27,niqlist@l(9)
	li 30,36
	addi 31,27,36
.L628:
	lwz 29,0(31)
	addi 31,31,36
	mr 3,29
	bl strlen
	mr 5,3
	mr 4,29
	addi 3,1,8
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L635
	addi 28,28,1
	addi 30,30,36
	cmpwi 0,28,10
	bc 4,1,.L628
.L627:
	cmpwi 0,28,10
	bc 4,1,.L620
	lwz 9,4(20)
	lis 3,.LC123@ha
	mr 4,25
	la 3,.LC123@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
.L620:
	addi 3,1,8
	li 4,80
	mr 5,26
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L622
	mr 3,26
	bl fclose
.L619:
	lwz 0,340(1)
	mtlr 0
	lmw 20,288(1)
	la 1,336(1)
	blr
.Lfe19:
	.size	 niq_loadammolist,.Lfe19-niq_loadammolist
	.section	".rodata"
	.align 2
.LC124:
	.long 0x0
	.align 3
.LC125:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC126:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl niq_clientkill
	.type	 niq_clientkill,@function
niq_clientkill:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC124@ha
	lis 9,deathmatch@ha
	la 11,.LC124@l(11)
	mr 31,3
	lfs 9,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,9
	bc 12,2,.L636
	lis 9,niq_auto@ha
	lwz 11,niq_auto@l(9)
	lfs 0,20(11)
	fcmpu 0,0,9
	bc 4,2,.L636
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L636
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L636
	lwz 4,480(31)
	cmpwi 0,4,0
	bc 4,1,.L636
	xoris 0,4,0x8000
	stw 0,28(1)
	lis 6,0x4330
	lis 11,.LC125@ha
	stw 6,24(1)
	la 11,.LC125@l(11)
	lis 7,niq_hlthinc@ha
	lfd 10,0(11)
	mr 8,9
	lfd 0,24(1)
	mr 11,9
	lwz 10,niq_hlthinc@l(7)
	lis 9,niq_hlthmax@ha
	lwz 5,niq_hlthmax@l(9)
	fsub 0,0,10
	lfs 12,20(10)
	frsp 0,0
	fadds 0,0,12
	fmr 13,0
	fctiwz 11,13
	stfd 11,24(1)
	lwz 11,28(1)
	xoris 0,11,0x8000
	stw 11,480(31)
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	lfs 13,20(5)
	fsub 0,0,10
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L642
	fmr 0,13
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,480(31)
.L642:
	lis 9,niq_sndhlth@ha
	lwz 11,niq_sndhlth@l(9)
	lfs 0,20(11)
	fcmpu 0,0,9
	bc 12,2,.L636
	lwz 0,480(31)
	cmpw 0,0,4
	bc 4,1,.L636
	lis 29,gi@ha
	lis 3,.LC35@ha
	la 29,gi@l(29)
	la 3,.LC35@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC126@ha
	lwz 0,16(29)
	lis 11,.LC126@ha
	la 9,.LC126@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC126@l(11)
	li 4,5
	mtlr 0
	lis 9,.LC124@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC124@l(9)
	lfs 3,0(9)
	blrl
.L636:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 niq_clientkill,.Lfe20-niq_clientkill
	.section	".rodata"
	.align 2
.LC127:
	.string	"key_"
	.align 2
.LC128:
	.string	"item_breather"
	.align 2
.LC129:
	.string	"item_enviro"
	.align 2
.LC130:
	.string	"drop"
	.align 2
.LC131:
	.string	"invnextp"
	.align 2
.LC132:
	.string	"invprevp"
	.align 2
.LC133:
	.string	"invdrop"
	.align 2
.LC134:
	.string	"NIQ: command is unavailable.\n"
	.align 2
.LC135:
	.string	"invnextw"
	.align 2
.LC136:
	.string	"invprevw"
	.align 2
.LC137:
	.string	"weapprev"
	.align 2
.LC138:
	.string	"weapnext"
	.align 2
.LC139:
	.string	"weaplast"
	.align 2
.LC140:
	.string	"NIQ: command is currently unavailable.\n"
	.align 2
.LC141:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_commandisblocked,@function
niq_commandisblocked:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	lis 4,.LC130@ha
	mr 3,31
	la 4,.LC130@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L654
	lis 4,.LC131@ha
	mr 3,31
	la 4,.LC131@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L654
	lis 4,.LC132@ha
	mr 3,31
	la 4,.LC132@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L654
	lis 4,.LC133@ha
	mr 3,31
	la 4,.LC133@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L653
.L654:
	lis 9,gi+8@ha
	lis 5,.LC134@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC134@l(5)
	b .L658
.L653:
	lis 11,.LC141@ha
	lis 9,ctf@ha
	la 11,.LC141@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L655
	lis 9,grapple@ha
	lwz 11,grapple@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L655
	lis 4,.LC135@ha
	mr 3,31
	la 4,.LC135@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L656
	lis 4,.LC136@ha
	mr 3,31
	la 4,.LC136@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L656
	lis 4,.LC137@ha
	mr 3,31
	la 4,.LC137@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L656
	lis 4,.LC138@ha
	mr 3,31
	la 4,.LC138@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L656
	lis 4,.LC139@ha
	mr 3,31
	la 4,.LC139@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L655
.L656:
	lis 9,gi+8@ha
	lis 5,.LC140@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC140@l(5)
.L658:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L657
.L655:
	li 3,0
.L657:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 niq_commandisblocked,.Lfe21-niq_commandisblocked
	.section	".rodata"
	.align 2
.LC142:
	.string	"item_flag"
	.align 2
.LC143:
	.string	"weapon_grapple"
	.align 2
.LC144:
	.string	"weapon_"
	.align 2
.LC145:
	.string	"ammo_"
	.align 2
.LC146:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_zapitems,@function
niq_zapitems:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	lis 9,game+1556@ha
	li 30,0
	lwz 0,game+1556@l(9)
	lis 11,itemlist@ha
	lis 28,game@ha
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L661
	li 29,0
.L663:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L662
	lis 11,.LC146@ha
	lis 9,ctf@ha
	la 11,.LC146@l(11)
	lfs 31,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L665
	lis 4,.LC142@ha
	li 5,9
	la 4,.LC142@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L662
.L665:
	lwz 3,0(31)
	lis 4,.LC143@ha
	li 5,14
	la 4,.LC143@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L662
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L668
	lwz 3,0(31)
	lis 4,.LC127@ha
	li 5,4
	la 4,.LC127@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L662
	lwz 3,0(31)
	lis 4,.LC128@ha
	li 5,13
	la 4,.LC128@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L662
	lwz 3,0(31)
	lis 4,.LC129@ha
	li 5,11
	la 4,.LC129@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L662
.L668:
	lwz 3,0(31)
	lis 4,.LC144@ha
	li 5,7
	la 4,.LC144@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L672
	stw 29,8(31)
.L672:
	lwz 3,0(31)
	lis 4,.LC145@ha
	li 5,5
	la 4,.LC145@l(4)
	bl strncmp
	mr. 3,3
	bc 4,2,.L673
	stw 3,16(31)
	stw 3,8(31)
.L673:
	stw 29,12(31)
	stw 29,4(31)
.L662:
	la 9,game@l(28)
	addi 30,30,1
	lwz 0,1556(9)
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L663
.L661:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 niq_zapitems,.Lfe22-niq_zapitems
	.section	".rodata"
	.align 2
.LC147:
	.string	"niq_version"
	.align 2
.LC148:
	.string	"niq_enable"
	.align 2
.LC149:
	.string	"1"
	.align 2
.LC150:
	.string	"niq_ebots"
	.align 2
.LC151:
	.string	"0"
	.align 2
.LC152:
	.string	"niq_handicap"
	.align 2
.LC153:
	.string	"niq_allmaps"
	.align 2
.LC154:
	.string	"niq_tractor"
	.align 2
.LC155:
	.string	"niq_hooksky"
	.align 2
.LC156:
	.string	"niq_blk1"
	.align 2
.LC157:
	.string	"niq_blk2"
	.align 2
.LC158:
	.string	"stdlogfile"
	.align 2
.LC159:
	.string	"niq_sbhp"
	.align 2
.LC160:
	.string	"999"
	.align 2
.LC161:
	.string	"niq_auto"
	.align 2
.LC162:
	.string	"niq_weapsecs"
	.align 2
.LC163:
	.string	"60"
	.align 2
.LC164:
	.string	"niq_weapkills"
	.align 2
.LC165:
	.string	"5"
	.align 2
.LC166:
	.string	"niq_weaprand"
	.align 2
.LC167:
	.string	"niq_weapall"
	.align 2
.LC168:
	.string	"niq_hlthinc"
	.align 2
.LC169:
	.string	"10"
	.align 2
.LC170:
	.string	"niq_hlthmax"
	.align 2
.LC171:
	.string	"100"
	.align 2
.LC172:
	.string	"niq_killpts"
	.align 2
.LC173:
	.string	"1.0"
	.align 2
.LC174:
	.string	"niq_kildpts"
	.align 2
.LC175:
	.string	"0.2"
	.align 2
.LC176:
	.string	"niq_suicpts"
	.align 2
.LC177:
	.string	"niq_sndhlth"
	.align 2
.LC178:
	.string	"niq_sndwarn"
	.align 2
.LC179:
	.string	"niq_sndswitch"
	.align 2
.LC180:
	.string	"niq_msgswitch"
	.align 2
.LC181:
	.string	"niq_slines"
	.align 2
.LC182:
	.string	"12"
	.align 2
.LC183:
	.string	"niq_sbdebug"
	.align 2
.LC184:
	.string	"niq_sbwide"
	.align 2
.LC185:
	.string	"niq_sbmini"
	.align 2
.LC186:
	.string	"niq_inttime"
	.align 2
.LC187:
	.string	"10.0"
	.align 2
.LC188:
	.string	"niq_playerid"
	.section	".text"
	.align 2
	.globl niq_initcvars
	.type	 niq_initcvars,@function
niq_initcvars:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 3,.LC147@ha
	la 29,gi@l(29)
	lis 4,.LC31@ha
	lwz 9,144(29)
	la 4,.LC31@l(4)
	li 5,12
	la 3,.LC147@l(3)
	lis 28,.LC149@ha
	mtlr 9
	lis 27,.LC151@ha
	lis 26,.LC173@ha
	blrl
	lwz 10,144(29)
	lis 9,niq_version@ha
	lis 11,.LC148@ha
	stw 3,niq_version@l(9)
	la 4,.LC149@l(28)
	li 5,16
	mtlr 10
	la 3,.LC148@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_enable@ha
	lis 11,.LC150@ha
	stw 3,niq_enable@l(9)
	la 4,.LC151@l(27)
	li 5,16
	mtlr 10
	la 3,.LC150@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_ebots@ha
	lis 11,.LC152@ha
	stw 3,niq_ebots@l(9)
	la 4,.LC151@l(27)
	li 5,16
	mtlr 10
	la 3,.LC152@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_handicap@ha
	lis 11,.LC153@ha
	stw 3,niq_handicap@l(9)
	la 4,.LC149@l(28)
	li 5,16
	mtlr 10
	la 3,.LC153@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_allmaps@ha
	lis 11,.LC154@ha
	stw 3,niq_allmaps@l(9)
	la 4,.LC149@l(28)
	li 5,16
	mtlr 10
	la 3,.LC154@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_tractor@ha
	lis 11,.LC155@ha
	stw 3,niq_tractor@l(9)
	la 4,.LC151@l(27)
	li 5,16
	mtlr 10
	la 3,.LC155@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_hooksky@ha
	lis 11,.LC156@ha
	stw 3,niq_hooksky@l(9)
	la 4,.LC151@l(27)
	li 5,16
	mtlr 10
	la 3,.LC156@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_blk1@ha
	lis 11,.LC157@ha
	stw 3,niq_blk1@l(9)
	la 4,.LC151@l(27)
	li 5,16
	mtlr 10
	la 3,.LC157@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_blk2@ha
	lis 11,.LC158@ha
	stw 3,niq_blk2@l(9)
	la 4,.LC151@l(27)
	li 5,16
	mtlr 10
	la 3,.LC158@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_logfile@ha
	lis 11,.LC159@ha
	stw 3,niq_logfile@l(9)
	lis 4,.LC160@ha
	li 5,0
	mtlr 10
	la 4,.LC160@l(4)
	la 3,.LC159@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_sbhp@ha
	lis 11,.LC161@ha
	stw 3,niq_sbhp@l(9)
	la 4,.LC149@l(28)
	li 5,0
	mtlr 10
	la 3,.LC161@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_auto@ha
	lis 11,.LC162@ha
	stw 3,niq_auto@l(9)
	lis 4,.LC163@ha
	li 5,0
	la 4,.LC163@l(4)
	mtlr 10
	la 3,.LC162@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_weapsecs@ha
	lis 11,.LC164@ha
	stw 3,niq_weapsecs@l(9)
	lis 4,.LC165@ha
	li 5,0
	mtlr 10
	la 4,.LC165@l(4)
	la 3,.LC164@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_weapkills@ha
	lis 11,.LC166@ha
	stw 3,niq_weapkills@l(9)
	la 4,.LC149@l(28)
	li 5,0
	mtlr 10
	la 3,.LC166@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_weaprand@ha
	lis 11,.LC167@ha
	stw 3,niq_weaprand@l(9)
	la 4,.LC149@l(28)
	li 5,0
	mtlr 10
	la 3,.LC167@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_weapall@ha
	lis 11,.LC168@ha
	stw 3,niq_weapall@l(9)
	lis 4,.LC169@ha
	li 5,0
	la 4,.LC169@l(4)
	mtlr 10
	la 3,.LC168@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_hlthinc@ha
	lis 11,.LC170@ha
	stw 3,niq_hlthinc@l(9)
	lis 4,.LC171@ha
	li 5,0
	mtlr 10
	la 4,.LC171@l(4)
	la 3,.LC170@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_hlthmax@ha
	lis 11,.LC172@ha
	stw 3,niq_hlthmax@l(9)
	la 4,.LC173@l(26)
	li 5,0
	mtlr 10
	la 3,.LC172@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_killpts@ha
	lis 11,.LC174@ha
	stw 3,niq_killpts@l(9)
	lis 4,.LC175@ha
	li 5,0
	mtlr 10
	la 4,.LC175@l(4)
	la 3,.LC174@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_kildpts@ha
	lis 11,.LC176@ha
	stw 3,niq_kildpts@l(9)
	la 4,.LC173@l(26)
	li 5,0
	mtlr 10
	la 3,.LC176@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_suicpts@ha
	lis 11,.LC177@ha
	stw 3,niq_suicpts@l(9)
	la 4,.LC151@l(27)
	li 5,0
	mtlr 10
	la 3,.LC177@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_sndhlth@ha
	lis 11,.LC178@ha
	stw 3,niq_sndhlth@l(9)
	la 4,.LC149@l(28)
	li 5,0
	mtlr 10
	la 3,.LC178@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_sndwarn@ha
	lis 11,.LC179@ha
	stw 3,niq_sndwarn@l(9)
	la 4,.LC149@l(28)
	li 5,0
	mtlr 10
	la 3,.LC179@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_sndswitch@ha
	lis 11,.LC180@ha
	stw 3,niq_sndswitch@l(9)
	la 4,.LC151@l(27)
	li 5,0
	mtlr 10
	la 3,.LC180@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_msgswitch@ha
	lis 11,.LC181@ha
	stw 3,niq_msgswitch@l(9)
	lis 4,.LC182@ha
	li 5,0
	mtlr 10
	la 4,.LC182@l(4)
	la 3,.LC181@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_sblines@ha
	lis 11,.LC183@ha
	stw 3,niq_sblines@l(9)
	la 4,.LC151@l(27)
	li 5,0
	mtlr 10
	la 3,.LC183@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_sbdebug@ha
	lis 11,.LC184@ha
	stw 3,niq_sbdebug@l(9)
	la 4,.LC149@l(28)
	li 5,0
	mtlr 10
	la 3,.LC184@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_sbwide@ha
	lis 11,.LC185@ha
	stw 3,niq_sbwide@l(9)
	la 4,.LC149@l(28)
	li 5,0
	mtlr 10
	la 3,.LC185@l(11)
	blrl
	lwz 10,144(29)
	lis 9,niq_sbmini@ha
	lis 11,.LC186@ha
	stw 3,niq_sbmini@l(9)
	lis 4,.LC187@ha
	li 5,0
	mtlr 10
	la 4,.LC187@l(4)
	la 3,.LC186@l(11)
	blrl
	lis 9,niq_inttime@ha
	lwz 0,144(29)
	lis 11,.LC188@ha
	stw 3,niq_inttime@l(9)
	la 4,.LC149@l(28)
	li 5,0
	la 3,.LC188@l(11)
	mtlr 0
	blrl
	lis 9,niq_playerid@ha
	stw 3,niq_playerid@l(9)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 niq_initcvars,.Lfe23-niq_initcvars
	.section	".rodata"
	.align 2
.LC189:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_initall
	.type	 niq_initall,@function
niq_initall:
	stwu 1,-288(1)
	mflr 0
	stmw 28,272(1)
	stw 0,292(1)
	bl niq_initcvars
	li 31,0
	lis 9,game@ha
	li 0,0
	la 9,game@l(9)
	li 10,0
	li 11,10
	stw 0,1572(9)
	stw 11,2388(9)
	stw 10,1576(9)
	stw 0,1564(9)
	stw 0,1568(9)
	bl niq_patchversionstrings
	lis 3,.LC115@ha
	li 4,1
	la 3,.LC115@l(3)
	bl niq_fopen
	mr. 30,3
	bc 12,2,.L685
	b .L679
.L681:
	addi 3,1,8
	bl strlen
	addi 3,3,-1
	addi 4,1,8
	lbzx 0,4,3
	cmpwi 0,0,10
	bc 4,2,.L682
	li 0,0
	stbx 0,4,3
.L682:
	mulli 0,31,41
	lis 3,motdlines@ha
	li 9,0
	la 3,motdlines@l(3)
	stb 9,48(1)
	addi 31,31,1
	add 3,0,3
	bl strcpy
.L679:
	addi 3,1,8
	li 4,80
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L684
	cmpwi 0,31,3
	bc 4,1,.L681
	lis 9,gi+4@ha
	lis 3,.LC116@ha
	lwz 0,gi+4@l(9)
	la 3,.LC116@l(3)
	li 4,4
	mtlr 0
	crxor 6,6,6
	blrl
.L684:
	mr 3,30
	bl fclose
.L685:
	lis 9,.LC189@ha
	lis 11,niq_enable@ha
	la 9,.LC189@l(9)
	lfs 13,0(9)
	lwz 9,niq_enable@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L677
	bl niq_zapitems
	lis 30,0x38e3
	bl niq_loadweaponlist
	ori 30,30,36409
	bl niq_loadammolist
	li 3,0
	bl time
	bl srand
	lis 9,niqlist@ha
	lis 11,itemlist@ha
	la 9,niqlist@l(9)
	la 29,itemlist@l(11)
	addi 28,9,360
	addi 31,9,36
.L690:
	lwz 3,0(31)
	bl FindItem
	subf 3,29,3
	lwz 9,4(31)
	mullw 3,3,30
	srawi 3,3,3
	stw 3,24(31)
	lbz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L689
	mr 3,9
	bl FindItem
	subf 3,29,3
	mullw 3,3,30
	srawi 3,3,3
	stw 3,28(31)
.L689:
	addi 31,31,36
	cmpw 0,31,28
	bc 4,1,.L690
	li 3,1
	bl niq_selectcurrentweapon
	lis 9,game+1576@ha
	li 0,0
	stw 0,game+1576@l(9)
.L677:
	lwz 0,292(1)
	mtlr 0
	lmw 28,272(1)
	la 1,288(1)
	blr
.Lfe24:
	.size	 niq_initall,.Lfe24-niq_initall
	.section	".rodata"
	.align 2
.LC190:
	.string	"%2d Score"
	.align 2
.LC191:
	.string	"%2d PPH Score"
	.align 2
.LC192:
	.string	"%2d Name PPH Score"
	.align 2
.LC193:
	.string	"%2d Name Score"
	.align 2
.LC194:
	.string	"xl %d yt %d string \"%s\""
	.section	".text"
	.align 2
	.globl niq_hud_addmaintitles
	.type	 niq_hud_addmaintitles,@function
niq_hud_addmaintitles:
	stwu 1,-448(1)
	mflr 0
	stmw 29,436(1)
	stw 0,452(1)
	lis 9,game+1544@ha
	mr 31,4
	lwz 0,game+1544@l(9)
	li 5,0
	cmpwi 0,0,0
	bc 4,1,.L707
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 11,9,1332
.L703:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L705
	lwz 0,84(11)
	addi 9,5,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,5,0
	or 5,0,9
.L705:
	addi 11,11,1332
	bdnz .L703
.L707:
	cmpwi 0,31,0
	bc 4,2,.L709
	li 3,0
	b .L717
.L709:
	cmpwi 0,3,1
	bc 4,2,.L710
	lis 4,.LC190@ha
	addi 3,1,8
	la 4,.LC190@l(4)
	crxor 6,6,6
	bl sprintf
	b .L711
.L710:
	cmpwi 0,3,2
	bc 4,2,.L712
	lis 4,.LC191@ha
	addi 3,1,8
	la 4,.LC191@l(4)
	crxor 6,6,6
	bl sprintf
	b .L711
.L712:
	cmpwi 0,3,3
	bc 4,2,.L714
	lis 4,.LC192@ha
	addi 3,1,8
	la 4,.LC192@l(4)
	crxor 6,6,6
	bl sprintf
	b .L711
.L714:
	cmpwi 0,3,4
	bc 4,2,.L711
	lis 4,.LC193@ha
	addi 3,1,8
	la 4,.LC193@l(4)
	crxor 6,6,6
	bl sprintf
.L711:
	addi 29,1,216
	lis 4,.LC194@ha
	li 5,0
	li 6,40
	addi 7,1,8
	la 4,.LC194@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	mr 4,29
	mr 3,31
	bl strcat
	mr 3,29
	bl strlen
	add 3,31,3
.L717:
	lwz 0,452(1)
	mtlr 0
	lmw 29,436(1)
	la 1,448(1)
	blr
.Lfe25:
	.size	 niq_hud_addmaintitles,.Lfe25-niq_hud_addmaintitles
	.section	".rodata"
	.align 2
.LC195:
	.string	"%2d %5.1f"
	.align 2
.LC196:
	.string	"%2d %3d %5.1f"
	.align 2
.LC200:
	.string	"%2d %-*s %3d %5.1f"
	.align 2
.LC201:
	.string	"%2d %-*s %5.1f"
	.align 2
.LC202:
	.string	" R"
	.align 2
.LC203:
	.string	" B"
	.align 2
.LC204:
	.string	"yt %d string2 \"%s\""
	.align 2
.LC205:
	.string	"yt %d string \"%s\""
	.align 3
.LC197:
	.long 0x40ac2000
	.long 0x0
	.align 3
.LC198:
	.long 0x408f3800
	.long 0x0
	.align 3
.LC199:
	.long 0xc058c000
	.long 0x0
	.align 3
.LC206:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC207:
	.long 0x40240000
	.long 0x0
	.align 3
.LC208:
	.long 0x0
	.long 0x0
	.align 3
.LC209:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC210:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_addplayerstats
	.type	 niq_addplayerstats,@function
niq_addplayerstats:
	stwu 1,-576(1)
	mflr 0
	stmw 23,540(1)
	stw 0,580(1)
	lis 9,.LC54@ha
	mr 29,5
	lbz 28,.LC54@l(9)
	mr 30,3
	mr 23,4
	mr 25,8
	addi 3,1,9
	mr 31,6
	mr 26,7
	stb 28,8(1)
	li 4,0
	li 5,199
	crxor 6,6,6
	bl memset
	stb 28,216(1)
	addi 3,1,217
	li 4,0
	li 5,199
	crxor 6,6,6
	bl memset
	mulli 29,29,10
	cmpwi 0,25,0
	addi 24,29,60
	bc 4,2,.L719
	li 3,0
	b .L763
.L719:
	cmpwi 0,31,1
	bc 4,2,.L720
	lfs 1,3512(30)
	lis 4,.LC195@ha
	mr 5,26
	la 4,.LC195@l(4)
	addi 3,1,8
	creqv 6,6,6
	bl sprintf
	b .L721
.L720:
	cmpwi 0,31,2
	bc 4,2,.L722
	lis 11,level@ha
	lwz 10,3460(30)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC206@ha
	subf 0,10,0
	la 11,.LC206@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,532(1)
	lis 11,.LC207@ha
	stw 8,528(1)
	la 11,.LC207@l(11)
	lfd 0,528(1)
	lfd 12,0(11)
	lis 11,.LC208@ha
	fsub 0,0,13
	la 11,.LC208@l(11)
	lfd 11,0(11)
	fdiv 0,0,12
	frsp 0,0
	fmr 10,0
	fcmpu 0,10,11
	bc 4,1,.L723
	lfs 12,3512(30)
	lis 9,.LC197@ha
	lfd 13,.LC197@l(9)
	fmr 0,12
	fmul 0,0,13
	fdiv 0,0,10
	frsp 0,0
	b .L724
.L723:
	lfs 12,3512(30)
	fmr 0,12
.L724:
	fmr 11,0
	lis 9,.LC198@ha
	lfd 0,.LC198@l(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L725
	li 6,999
	b .L726
.L725:
	lis 9,.LC199@ha
	lfd 0,.LC199@l(9)
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L727
	li 6,-99
	b .L726
.L727:
	lis 9,.LC208@ha
	la 9,.LC208@l(9)
	lfd 0,0(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L728
	lis 11,.LC209@ha
	la 11,.LC209@l(11)
	lfd 0,0(11)
	fadd 0,11,0
	b .L764
.L728:
	lis 9,.LC209@ha
	la 9,.LC209@l(9)
	lfd 0,0(9)
	fsub 0,11,0
.L764:
	fctiwz 13,0
	stfd 13,528(1)
	lwz 6,532(1)
.L726:
	fmr 1,12
	lis 4,.LC196@ha
	mr 5,26
	la 4,.LC196@l(4)
	addi 3,1,8
	creqv 6,6,6
	bl sprintf
	b .L721
.L722:
	cmpwi 0,31,3
	bc 4,2,.L731
	addi 29,1,424
	addi 4,30,700
	mr 3,29
	li 5,15
	bl strncpy
	li 28,4
	li 31,0
	lwz 0,1820(30)
	mr 27,29
	stbx 31,29,28
	cmpwi 0,0,0
	bc 12,2,.L739
	mr 3,27
	bl strlen
	cmpwi 0,3,4
	bc 4,0,.L733
	li 0,170
	add 9,3,27
	stbx 0,27,3
	stb 31,1(9)
	b .L739
.L733:
	add 9,3,27
	li 0,170
	stb 0,-1(9)
.L739:
	lis 11,level@ha
	lwz 10,3460(30)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC206@ha
	subf 0,10,0
	la 11,.LC206@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,532(1)
	lis 11,.LC207@ha
	stw 8,528(1)
	la 11,.LC207@l(11)
	lfd 0,528(1)
	lfd 12,0(11)
	lis 11,.LC208@ha
	fsub 0,0,13
	la 11,.LC208@l(11)
	lfd 11,0(11)
	fdiv 0,0,12
	frsp 0,0
	fmr 10,0
	fcmpu 0,10,11
	bc 4,1,.L740
	lfs 12,3512(30)
	lis 9,.LC197@ha
	lfd 13,.LC197@l(9)
	fmr 0,12
	fmul 0,0,13
	fdiv 0,0,10
	frsp 0,0
	b .L741
.L740:
	lfs 12,3512(30)
	fmr 0,12
.L741:
	fmr 11,0
	lis 9,.LC198@ha
	lfd 0,.LC198@l(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L742
	li 8,999
	b .L743
.L742:
	lis 9,.LC199@ha
	lfd 0,.LC199@l(9)
	fcmpu 0,11,0
	cror 3,2,0
	bc 4,3,.L744
	li 8,-99
	b .L743
.L744:
	lis 9,.LC208@ha
	la 9,.LC208@l(9)
	lfd 0,0(9)
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L745
	lis 11,.LC209@ha
	la 11,.LC209@l(11)
	lfd 0,0(11)
	fadd 0,11,0
	b .L765
.L745:
	lis 9,.LC209@ha
	la 9,.LC209@l(9)
	lfd 0,0(9)
	fsub 0,11,0
.L765:
	fctiwz 13,0
	stfd 13,528(1)
	lwz 8,532(1)
.L743:
	fmr 1,12
	lis 4,.LC200@ha
	mr 5,26
	la 4,.LC200@l(4)
	mr 7,27
	addi 3,1,8
	li 6,4
	creqv 6,6,6
	bl sprintf
	b .L721
.L731:
	cmpwi 0,31,4
	bc 4,2,.L721
	addi 29,1,472
	addi 4,30,700
	mr 3,29
	li 5,15
	bl strncpy
	li 27,0
	mr 28,29
	lwz 0,1820(30)
	stbx 27,29,31
	cmpwi 0,0,0
	bc 12,2,.L756
	mr 3,28
	bl strlen
	cmpwi 0,3,4
	bc 4,0,.L750
	li 0,170
	add 9,3,28
	stbx 0,28,3
	stb 27,1(9)
	b .L756
.L750:
	add 9,3,28
	li 0,170
	stb 0,-1(9)
.L756:
	lfs 1,3512(30)
	lis 4,.LC201@ha
	mr 5,26
	la 4,.LC201@l(4)
	mr 7,28
	addi 3,1,8
	li 6,4
	creqv 6,6,6
	bl sprintf
.L721:
	lis 9,.LC210@ha
	lis 11,ctf@ha
	la 9,.LC210@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L757
	lwz 3,3464(30)
	cmpwi 0,3,1
	bc 4,2,.L758
	lis 4,.LC202@ha
	addi 3,1,8
	la 4,.LC202@l(4)
	bl strcat
	b .L757
.L758:
	cmpwi 0,3,2
	bc 4,2,.L757
	lis 4,.LC203@ha
	addi 3,1,8
	la 4,.LC203@l(4)
	bl strcat
.L757:
	cmpwi 0,23,0
	bc 12,2,.L761
	addi 29,1,216
	lis 4,.LC204@ha
	la 4,.LC204@l(4)
	mr 5,24
	mr 3,29
	addi 6,1,8
	crxor 6,6,6
	bl sprintf
	b .L762
.L761:
	addi 29,1,216
	lis 4,.LC205@ha
	la 4,.LC205@l(4)
	mr 5,24
	mr 3,29
	addi 6,1,8
	crxor 6,6,6
	bl sprintf
.L762:
	mr 4,29
	mr 3,25
	bl strcat
	mr 3,29
	bl strlen
	add 3,25,3
.L763:
	lwz 0,580(1)
	mtlr 0
	lmw 23,540(1)
	la 1,576(1)
	blr
.Lfe26:
	.size	 niq_addplayerstats,.Lfe26-niq_addplayerstats
	.section	".rodata"
	.align 2
.LC211:
	.long 0x4b18967f
	.align 2
.LC212:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_showhudsb
	.type	 niq_showhudsb,@function
niq_showhudsb:
	stwu 1,-2112(1)
	mflr 0
	stfd 31,2104(1)
	stmw 25,2076(1)
	stw 0,2116(1)
	mr 28,3
	li 0,-1
	lwz 10,84(28)
	stw 0,2060(1)
	lwz 8,1820(10)
	cmpwi 0,8,0
	bc 4,2,.L769
	lis 9,niq_sbmini@ha
	lis 6,.LC212@ha
	lwz 11,niq_sbmini@l(9)
	la 6,.LC212@l(6)
	lfs 13,0(6)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L771
	lwz 0,1812(10)
	cmpwi 0,0,0
	bc 12,2,.L771
	lis 9,deathmatch@ha
	stw 8,1812(10)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L769
	lwz 9,84(28)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 4,2,.L769
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,szHUDLabelStr@ha
	la 3,szHUDLabelStr@l(3)
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,28
	li 4,0
	mtlr 0
	blrl
	b .L769
.L771:
	lwz 3,84(28)
	lwz 0,3584(3)
	cmpwi 0,0,0
	bc 4,2,.L769
	lwz 0,3568(3)
	cmpwi 0,0,0
	bc 4,2,.L769
	lwz 0,3536(3)
	cmpwi 0,0,0
	bc 4,2,.L769
	stb 0,8(1)
	addi 30,1,1032
	mr 4,28
	lwz 27,1812(3)
	addi 5,1,2056
	addi 6,1,2060
	mr 3,30
	li 29,0
	bl niq_sortclients
	li 31,0
	li 26,0
	mr 3,27
	addi 4,1,8
	bl niq_hud_addmaintitles
	lwz 0,2056(1)
	lis 9,.LC211@ha
	mr 8,3
	lfs 31,.LC211@l(9)
	li 7,0
	cmpw 0,29,0
	bc 4,0,.L778
	lis 9,game@ha
	la 25,game@l(9)
.L780:
	lwz 0,0(30)
	lwz 9,1028(25)
	addi 30,30,4
	mulli 0,0,3968
	add. 3,9,0
	bc 12,2,.L779
	lfs 0,3512(3)
	fcmpu 0,0,31
	bc 4,0,.L782
	fmr 31,0
	addi 26,26,1
.L782:
	lwz 10,2056(1)
	subfic 6,29,0
	adde 0,6,29
	lwz 11,2060(1)
	cmpwi 7,10,5
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	or. 6,9,0
	bc 4,2,.L784
	addi 0,11,-1
	cmpw 0,29,0
	bc 12,2,.L784
	cmpw 0,29,11
	bc 12,2,.L784
	addi 0,11,1
	cmpw 0,29,0
	bc 12,2,.L784
	cmpwi 6,29,1
	bc 4,26,.L785
	addi 0,10,-1
	cmpw 0,11,0
	bc 12,2,.L784
.L785:
	cmpwi 7,29,2
	bc 4,30,.L786
	addi 0,10,-1
	cmpw 0,11,0
	bc 12,2,.L784
.L786:
	bc 4,26,.L787
	addi 0,10,-2
	cmpw 0,11,0
	bc 12,2,.L784
.L787:
	bc 4,30,.L788
	cmpwi 0,11,0
	bc 12,2,.L784
.L788:
	cmpwi 0,29,3
	bc 4,2,.L789
	cmpwi 0,11,1
	bc 4,1,.L784
.L789:
	addi 0,10,-1
	cmpw 0,29,0
	bc 4,2,.L779
.L784:
	addi 0,7,1
	addi 9,31,1
	cmpw 7,29,0
	mr 7,26
	xor 4,29,11
	subfic 0,4,0
	adde 4,0,4
	mr 6,27
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,31,0
	or 31,0,9
	mr 5,31
	bl niq_addplayerstats
	addi 31,31,1
	mr 8,3
	mr 7,29
.L779:
	lwz 0,2056(1)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L780
.L778:
	lis 4,szHUDLabelStr@ha
	addi 3,1,8
	la 4,szHUDLabelStr@l(4)
	bl strcat
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,28
	li 4,0
	mtlr 0
	blrl
.L769:
	lwz 0,2116(1)
	mtlr 0
	lmw 25,2076(1)
	lfd 31,2104(1)
	la 1,2112(1)
	blr
.Lfe27:
	.size	 niq_showhudsb,.Lfe27-niq_showhudsb
	.section	".rodata"
	.align 2
.LC213:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_updatescreen
	.type	 niq_updatescreen,@function
niq_updatescreen:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 10,84(31)
	lwz 0,1820(10)
	cmpwi 0,0,0
	bc 4,2,.L792
	lwz 0,3584(10)
	cmpwi 0,0,0
	bc 4,2,.L792
	lwz 0,3568(10)
	cmpwi 0,0,0
	bc 12,2,.L795
	lwz 0,3576(10)
	cmpwi 0,0,0
	bc 12,2,.L796
	bl PMenu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,0
	mtlr 0
	blrl
	b .L792
.L796:
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
	b .L792
.L795:
	lwz 0,3536(10)
	cmpwi 0,0,0
	bc 12,2,.L798
	mr 3,31
	bl niq_help
	b .L792
.L798:
	lis 11,.LC213@ha
	lis 9,niq_enable@ha
	la 11,.LC213@l(11)
	lfs 13,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L792
	lwz 0,1812(10)
	cmpwi 0,0,0
	bc 12,2,.L800
	mr 3,31
	bl niq_showhudsb
	b .L792
.L800:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L792
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,szHUDLabelStr@ha
	la 3,szHUDLabelStr@l(3)
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,0
	mtlr 0
	blrl
.L792:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 niq_updatescreen,.Lfe28-niq_updatescreen
	.section	".rodata"
	.align 3
.LC214:
	.long 0x40ac2000
	.long 0x0
	.align 3
.LC215:
	.long 0x408f3800
	.long 0x0
	.align 3
.LC216:
	.long 0xc058c000
	.long 0x0
	.align 3
.LC217:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC218:
	.long 0x0
	.align 3
.LC219:
	.long 0x0
	.long 0x0
	.align 3
.LC220:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC221:
	.long 0x40240000
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_setstats
	.type	 niq_setstats,@function
niq_setstats:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 11,84(31)
	lwz 10,1820(11)
	cmpwi 0,10,0
	bc 4,2,.L805
	lis 9,level+266@ha
	lhz 0,level+266@l(9)
	sth 0,120(11)
	lwz 9,84(31)
	lhz 0,482(31)
	sth 0,122(9)
	lwz 9,84(31)
	lwz 11,3592(9)
	cmpwi 0,11,0
	bc 12,2,.L808
	lwz 0,184(31)
	andi. 7,0,1
	bc 12,2,.L807
.L808:
	sth 10,124(9)
	lwz 9,84(31)
	sth 10,126(9)
	b .L809
.L807:
	lis 10,gi+40@ha
	mulli 11,11,72
	lis 9,itemlist@ha
	lwz 0,gi+40@l(10)
	la 9,itemlist@l(9)
	add 11,11,9
	lwz 3,36(11)
	mtlr 0
	blrl
	lwz 8,84(31)
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	sth 3,124(8)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,8192
	bc 12,2,.L810
	lwz 9,84(31)
	li 0,999
	b .L848
.L810:
	lwz 9,84(31)
	lwz 11,3592(9)
	slwi 11,11,2
	add 11,9,11
	lhz 0,742(11)
.L848:
	sth 0,126(9)
.L809:
	lis 9,level@ha
	lwz 11,84(31)
	la 29,level@l(9)
	lfs 13,4(29)
	lfs 0,3820(11)
	fcmpu 0,13,0
	bc 4,1,.L812
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L812:
	lwz 9,84(31)
	lwz 11,1788(9)
	cmpwi 0,11,0
	bc 12,2,.L813
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
.L813:
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,2388(9)
	cmpwi 0,0,1
	bc 4,1,.L814
	lfs 13,1576(9)
	lfs 0,4(29)
	fcmpu 0,13,0
	bc 4,1,.L814
	fsubs 0,13,0
	lis 7,.LC217@ha
	lwz 11,84(31)
	la 7,.LC217@l(7)
	lfd 12,0(7)
	fadd 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	sth 9,130(11)
	b .L815
.L814:
	lwz 9,84(31)
	li 0,0
	sth 0,130(9)
.L815:
	lis 11,deathmatch@ha
	lis 8,.LC218@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC218@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L816
	lis 9,game@ha
	lwz 11,84(31)
	li 30,1
	la 10,game@l(9)
	lwz 0,1544(10)
	mr 8,11
	lfs 13,3512(11)
	cmpwi 0,0,0
	bc 4,1,.L818
	lis 9,g_edicts@ha
	mtctr 0
	mr 7,10
	lwz 11,g_edicts@l(9)
	li 10,0
	addi 11,11,1332
.L820:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L819
	cmpw 0,11,31
	bc 12,2,.L819
	lwz 9,1028(7)
	addi 0,30,1
	add 9,10,9
	lfs 0,3512(9)
	fcmpu 0,0,13
	bc 4,1,.L819
	mr 30,0
.L819:
	addi 10,10,3968
	addi 11,11,1332
	bdnz .L820
.L818:
	lwz 0,3584(8)
	cmpwi 0,0,0
	bc 4,2,.L824
	lwz 0,3568(8)
	cmpwi 0,0,0
	bc 4,2,.L832
	lwz 0,3536(8)
	cmpwi 0,0,0
	bc 4,2,.L824
	lwz 0,1812(8)
	cmpwi 0,0,0
	bc 12,2,.L825
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,7
	bc 4,2,.L824
	mr 3,31
	bl niq_showhudsb
	b .L824
.L825:
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 7,0,31
	bc 4,2,.L824
	lis 9,.LC218@ha
	lis 11,deathmatch@ha
	la 9,.LC218@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L824
	lwz 0,1820(8)
	cmpwi 0,0,0
	bc 4,2,.L824
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,szHUDLabelStr@ha
	la 3,szHUDLabelStr@l(3)
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,0
	mtlr 0
	blrl
.L824:
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 4,2,.L832
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 4,2,.L832
	li 0,1
	lis 7,.LC219@ha
	sth 0,182(9)
	la 7,.LC219@l(7)
	lwz 11,84(31)
	lfd 13,0(7)
	lfs 0,3512(11)
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L833
	lis 8,.LC217@ha
	la 8,.LC217@l(8)
	lfd 0,0(8)
	fsub 0,12,0
	b .L849
.L833:
	lis 9,.LC217@ha
	la 9,.LC217@l(9)
	lfd 0,0(9)
	fadd 0,12,0
.L849:
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	sth 9,148(11)
	lis 9,level@ha
	lwz 8,84(31)
	lwz 0,level@l(9)
	lis 10,0x4330
	lis 7,.LC220@ha
	lwz 9,3460(8)
	la 7,.LC220@l(7)
	lfd 12,0(7)
	subf 0,9,0
	lis 7,.LC221@ha
	xoris 0,0,0x8000
	la 7,.LC221@l(7)
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	lfd 13,0(7)
	lis 7,.LC219@ha
	fsub 0,0,12
	la 7,.LC219@l(7)
	lfd 11,0(7)
	fdiv 0,0,13
	frsp 0,0
	fmr 12,0
	fcmpu 0,12,11
	bc 4,1,.L835
	lfs 0,3512(8)
	lis 9,.LC214@ha
	lfd 13,.LC214@l(9)
	fmul 0,0,13
	fdiv 0,0,12
	frsp 0,0
	b .L836
.L835:
	lfs 0,3512(8)
.L836:
	fmr 12,0
	lis 9,.LC215@ha
	lfd 0,.LC215@l(9)
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L837
	li 0,999
	b .L838
.L837:
	lis 9,.LC216@ha
	lfd 0,.LC216@l(9)
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L839
	li 0,-99
	b .L838
.L839:
	lis 8,.LC219@ha
	la 8,.LC219@l(8)
	lfd 0,0(8)
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L840
	lis 9,.LC217@ha
	la 9,.LC217@l(9)
	lfd 0,0(9)
	fadd 0,12,0
	b .L850
.L840:
	lis 11,.LC217@ha
	la 11,.LC217@l(11)
	lfd 0,0(11)
	fsub 0,12,0
.L850:
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
.L838:
	lwz 9,84(31)
	sth 0,178(9)
	lwz 11,84(31)
	sth 30,180(11)
	b .L816
.L832:
	lwz 9,84(31)
	li 0,0
	sth 0,182(9)
.L816:
	lwz 10,84(31)
	lis 9,deathmatch@ha
	li 0,0
	lwz 11,deathmatch@l(9)
	lis 7,.LC218@ha
	la 7,.LC218@l(7)
	sth 0,146(10)
	lfs 13,0(7)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L843
	lwz 9,84(31)
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
	lwz 9,84(31)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L843
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L843
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L843:
	lis 11,ctf@ha
	lis 8,.LC218@ha
	lwz 9,ctf@l(11)
	la 8,.LC218@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L845
	lwz 9,84(31)
	li 0,255
	sth 0,174(9)
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L805
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 4,2,.L805
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 4,2,.L805
	lwz 0,3536(9)
	xori 9,0,9
	subfic 11,9,0
	adde 9,11,9
	subfic 7,0,0
	adde 0,7,0
	or. 8,0,9
	bc 12,2,.L805
	mr 3,31
	bl CTFSetIDView
	b .L805
.L845:
	mr 3,31
	bl SetCTFStats
.L805:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe29:
	.size	 niq_setstats,.Lfe29-niq_setstats
	.section	".rodata"
	.align 2
.LC222:
	.string	"NIQ handicapping is disabled.\n"
	.align 2
.LC224:
	.string	"You must run the server with '+set cheats 1' to increase damage past 1.0.\n"
	.align 2
.LC227:
	.string	"NIQ damage factor set to: %0.1f\n"
	.align 3
.LC223:
	.long 0x3feff7ce
	.long 0xd916872b
	.align 3
.LC225:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC226:
	.long 0x4023ff7c
	.long 0xed916873
	.align 2
.LC228:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_increase_damage
	.type	 niq_increase_damage,@function
niq_increase_damage:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	bc 12,2,.L857
	lis 11,.LC228@ha
	lis 9,niq_handicap@ha
	la 11,.LC228@l(11)
	lfs 12,0(11)
	lwz 11,niq_handicap@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 4,2,.L859
	lis 9,gi+8@ha
	lis 5,.LC222@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC222@l(5)
	b .L865
.L859:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L857
	lfs 0,1804(9)
	lis 9,.LC223@ha
	lfd 13,.LC223@l(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L861
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 4,2,.L862
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L861
.L862:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 4,2,.L861
	lis 9,gi+8@ha
	lis 5,.LC224@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC224@l(5)
.L865:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L857
.L861:
	lwz 10,84(31)
	lis 9,.LC225@ha
	lis 11,.LC226@ha
	lfd 13,.LC225@l(9)
	lfs 0,1804(10)
	lfd 12,.LC226@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1804(10)
	lwz 9,84(31)
	lfs 0,1804(9)
	fcmpu 0,0,12
	bc 4,1,.L863
	lis 0,0x4120
	stw 0,1804(9)
.L863:
	lwz 11,84(31)
	lis 9,gi+8@ha
	lis 5,.LC227@ha
	lwz 0,gi+8@l(9)
	la 5,.LC227@l(5)
	mr 3,31
	lfs 1,1804(11)
	li 4,2
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L857
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L857:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe30:
	.size	 niq_increase_damage,.Lfe30-niq_increase_damage
	.section	".rodata"
	.align 2
.LC232:
	.string	"You must run the server with '+set cheats 1' to select maximum damage.\n"
	.align 2
.LC233:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_max_damage
	.type	 niq_max_damage,@function
niq_max_damage:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	bc 12,2,.L872
	lis 11,.LC233@ha
	lis 9,niq_handicap@ha
	la 11,.LC233@l(11)
	lfs 13,0(11)
	lwz 11,niq_handicap@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L874
	lis 9,gi+8@ha
	lis 5,.LC222@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC222@l(5)
	b .L879
.L874:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L876
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L875
.L876:
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L875
	lis 9,gi+8@ha
	lis 5,.LC232@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC232@l(5)
.L879:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L872
.L875:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L872
	lis 0,0x4120
	lis 11,gi+8@ha
	stw 0,1804(9)
	lis 5,.LC227@ha
	mr 3,31
	lwz 9,84(31)
	la 5,.LC227@l(5)
	li 4,2
	lwz 0,gi+8@l(11)
	lfs 1,1804(9)
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L872
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L872:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe31:
	.size	 niq_max_damage,.Lfe31-niq_max_damage
	.section	".rodata"
	.align 2
.LC235:
	.string	"NIQ damage factor is: %0.1f\n"
	.align 2
.LC236:
	.string	"xv %-3d yv %-3d string \"%s\""
	.align 2
.LC237:
	.string	"NIQ: string is too long in niq_addsbline!\n"
	.align 2
.LC238:
	.string	"niq_handicap=0: skipping scoreboards!\n"
	.align 2
.LC239:
	.string	"niq_sbwide=0: skipping scoreboards!\n"
	.align 2
.LC240:
	.string	"niq_sbdebug=0: skipping scoreboard!\n"
	.align 2
.LC241:
	.string	"Scoreboard needs at least 512x384!\n"
	.align 2
.LC242:
	.string	"Scoreboard needs at least 640x480!\n"
	.align 2
.LC243:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_toggle_scoreboard,@function
niq_toggle_scoreboard:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L896
	lis 9,.LC243@ha
	lis 11,ctf@ha
	la 9,.LC243@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L898
	lwz 9,1808(10)
	addi 9,9,1
	cmpwi 0,9,8
	b .L908
.L898:
	lwz 9,1808(10)
	addi 9,9,1
	cmpwi 0,9,7
.L908:
	stw 9,1808(10)
	bc 4,1,.L900
	lwz 9,84(31)
	li 0,0
	stw 0,1808(9)
.L900:
	lis 9,.LC243@ha
	lis 11,niq_handicap@ha
	la 9,.LC243@l(9)
	lfs 13,0(9)
	lwz 9,niq_handicap@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L902
	lwz 11,84(31)
	lwz 9,1808(11)
	addi 9,9,-3
	cmplwi 0,9,1
	bc 12,1,.L902
	lis 9,gi+8@ha
	lis 5,.LC238@ha
	lwz 0,gi+8@l(9)
	la 5,.LC238@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,5
	stw 0,1808(9)
.L902:
	lis 9,.LC243@ha
	lis 11,niq_sbwide@ha
	la 9,.LC243@l(9)
	lfs 13,0(9)
	lwz 9,niq_sbwide@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L903
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,4
	bc 4,1,.L903
	cmpwi 0,0,6
	bc 12,1,.L903
	lis 9,gi+8@ha
	lis 5,.LC239@ha
	lwz 0,gi+8@l(9)
	la 5,.LC239@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,7
	stw 0,1808(9)
.L903:
	lis 9,.LC243@ha
	lis 11,niq_sbdebug@ha
	la 9,.LC243@l(9)
	lfs 13,0(9)
	lwz 9,niq_sbdebug@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L904
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,6
	bc 4,2,.L904
	lis 9,gi+8@ha
	lis 5,.LC240@ha
	lwz 0,gi+8@l(9)
	la 5,.LC240@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,1808(11)
	addi 9,9,1
	stw 9,1808(11)
.L904:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,5
	bc 4,2,.L905
	lis 9,gi+8@ha
	lis 5,.LC241@ha
	lwz 0,gi+8@l(9)
	la 5,.LC241@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L906
.L905:
	cmpwi 0,0,6
	bc 4,2,.L906
	lis 9,gi+8@ha
	lis 5,.LC242@ha
	lwz 0,gi+8@l(9)
	la 5,.LC242@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L906:
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L896:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 niq_toggle_scoreboard,.Lfe32-niq_toggle_scoreboard
	.section	".rodata"
	.align 2
.LC244:
	.string	"%-36s %3s"
	.align 2
.LC245:
	.string	"NA"
	.align 2
.LC246:
	.string	"YES"
	.align 2
.LC247:
	.string	"NO"
	.align 2
.LC248:
	.string	"%-34s %5d"
	.align 2
.LC249:
	.string	"%-34s %5.1f"
	.align 2
.LC250:
	.string	"#### NIQ features are disabled ####"
	.align 2
.LC251:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_motd
	.type	 niq_motd,@function
niq_motd:
	stwu 1,-64(1)
	mflr 0
	stmw 19,12(1)
	stw 0,68(1)
	lis 9,szWelcomeStr1NIQ@ha
	mr 19,3
	la 30,szWelcomeStr1NIQ@l(9)
	li 25,0
	mr 3,30
	lis 28,g_helpptr@ha
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L932
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	lis 24,g_nSBLineNum@ha
	lis 20,.LC236@ha
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L933
.L932:
	lis 9,g_nSBLineNum@ha
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	lwz 6,g_nSBLineNum@l(9)
	la 4,.LC236@l(4)
	mr 7,30
	li 5,0
	stb 25,40(30)
	lis 24,g_nSBLineNum@ha
	mulli 6,6,10
	lis 20,.LC236@ha
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L933:
	lis 10,g_nSBLineNum@ha
	lis 11,szWelcomeStr2NIQ@ha
	lwz 9,g_nSBLineNum@l(10)
	la 30,szWelcomeStr2NIQ@l(11)
	mr 3,30
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L935
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L936
.L935:
	lwz 6,g_nSBLineNum@l(24)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L936:
	lis 10,g_nSBLineNum@ha
	lis 11,szWelcomeStr4NIQ@ha
	lwz 9,g_nSBLineNum@l(10)
	la 30,szWelcomeStr4NIQ@l(11)
	mr 3,30
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L938
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L939
.L938:
	lwz 6,g_nSBLineNum@l(24)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L939:
	lis 11,g_nSBLineNum@ha
	cmpwi 0,25,3
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,2
	stw 9,g_nSBLineNum@l(11)
	bc 12,1,.L942
	lis 9,motdlines@ha
	mulli 3,25,41
	la 11,motdlines@l(9)
	lbzx 0,11,3
	cmpwi 0,0,0
	bc 12,2,.L942
	lis 9,gi@ha
	mr 26,11
	la 21,gi@l(9)
	li 22,0
	lis 27,g_nSBLineNum@ha
	mr 29,3
	lis 23,.LC237@ha
.L943:
	add 31,3,26
	mr 3,31
	bl strlen
	mr 30,3
	cmpwi 0,30,40
	bc 12,1,.L945
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,30,40
	mr 7,31
	lwz 3,g_helpptr@l(28)
	slwi 5,5,2
	la 4,.LC236@l(20)
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,30,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L946
.L945:
	stb 22,40(31)
	mr 7,31
	la 4,.LC236@l(20)
	lwz 6,g_nSBLineNum@l(24)
	li 5,0
	lwz 3,g_helpptr@l(28)
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 11,4(21)
	la 3,.LC237@l(23)
	lwz 9,g_helpptr@l(28)
	mtlr 11
	addi 9,9,63
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L946:
	lwz 9,g_nSBLineNum@l(27)
	addi 25,25,1
	addi 29,29,41
	cmpwi 0,25,3
	addi 9,9,1
	stw 9,g_nSBLineNum@l(27)
	bc 12,1,.L942
	lbzx 0,29,26
	mr 3,29
	cmpwi 0,0,0
	bc 4,2,.L943
.L942:
	lis 9,niq_enable@ha
	lis 10,.LC251@ha
	lwz 11,niq_enable@l(9)
	la 10,.LC251@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	lis 10,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(10)
	fcmpu 0,0,13
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bc 4,2,.L949
	lis 9,.LC250@ha
	la 30,.LC250@l(9)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L950
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L951
.L950:
	lwz 6,g_nSBLineNum@l(24)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L951:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
.L949:
	lis 9,szContact1@ha
	la 30,szContact1@l(9)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L953
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L954
.L953:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,30
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L954:
	lis 10,g_nSBLineNum@ha
	lis 11,szContact2@ha
	lwz 9,g_nSBLineNum@l(10)
	la 30,szContact2@l(11)
	mr 3,30
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L956
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L957
.L956:
	lwz 6,g_nSBLineNum@l(24)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L957:
	lis 10,g_nSBLineNum@ha
	lis 11,szContact3@ha
	lwz 9,g_nSBLineNum@l(10)
	la 30,szContact3@l(11)
	mr 3,30
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L959
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L960
.L959:
	lwz 6,g_nSBLineNum@l(24)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L960:
	lis 10,g_nSBLineNum@ha
	lis 11,szContact4@ha
	lwz 9,g_nSBLineNum@l(10)
	la 30,szContact4@l(11)
	mr 3,30
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L962
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L963
.L962:
	lwz 6,g_nSBLineNum@l(24)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L963:
	lwz 0,184(19)
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	andi. 10,0,1
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	bc 12,2,.L965
	lis 9,szPrompt0@ha
	li 0,19
	la 30,szPrompt0@l(9)
	stw 0,g_nSBLineNum@l(24)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L966
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L967
.L966:
	lwz 6,g_nSBLineNum@l(24)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L967:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
.L965:
	lis 9,szPrompt1@ha
	lis 11,g_nSBLineNum@ha
	la 30,szPrompt1@l(9)
	li 0,20
	stw 0,g_nSBLineNum@l(11)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L969
	lwz 6,g_nSBLineNum@l(24)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L970
.L969:
	lwz 6,g_nSBLineNum@l(24)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L970:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,68(1)
	mtlr 0
	lmw 19,12(1)
	la 1,64(1)
	blr
.Lfe33:
	.size	 niq_motd,.Lfe33-niq_motd
	.section	".rodata"
	.align 2
.LC252:
	.string	"This server is running NIQ. In NIQ, all"
	.align 2
.LC253:
	.string	"items are removed from the game and the"
	.align 2
.LC254:
	.string	"server controls weapons, ammo and health"
	.align 2
.LC255:
	.string	"for everyone. All players always have"
	.align 2
.LC256:
	.string	"the same weapon, and ammo and health are"
	.align 2
.LC257:
	.string	"given out at the same rate for everyone."
	.align 2
.LC258:
	.string	"You can only gain health if you are not"
	.align 2
.LC259:
	.string	"attacking (firing), drowning or burning."
	.align 2
.LC260:
	.string	"Use nmotd, nhelp or ninfo to return to"
	.align 2
.LC261:
	.string	"these menus at any time during the game."
	.align 2
.LC262:
	.string	"(+attack also Exits observer mode)"
	.section	".text"
	.align 2
	.type	 niq_help1,@function
niq_help1:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,szWelcomeStrNIQ@ha
	mr 27,3
	la 29,szWelcomeStrNIQ@l(9)
	lis 30,g_helpptr@ha
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L973
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,g_helpptr@l(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	lis 28,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L974
.L973:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,g_helpptr@l(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,29
	stb 0,40(29)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	lis 28,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L974:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC252@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC252@l(11)
	mr 3,29
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L976
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L977
.L976:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L977:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC253@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC253@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L979
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L980
.L979:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L980:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC254@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC254@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L982
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L983
.L982:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L983:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC255@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC255@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L985
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L986
.L985:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L986:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC256@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC256@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L988
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L989
.L988:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L989:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC257@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC257@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L991
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L992
.L991:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L992:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC258@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC258@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L994
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L995
.L994:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L995:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC259@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC259@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L997
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L998
.L997:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L998:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC260@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC260@l(11)
	mr 3,29
	addi 9,9,3
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1000
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1001
.L1000:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1001:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC261@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC261@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1003
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1004
.L1003:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1004:
	lwz 0,184(27)
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	andi. 10,0,1
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	bc 12,2,.L1006
	lis 9,.LC262@ha
	la 29,.LC262@l(9)
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1007
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1008
.L1007:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1008:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
.L1006:
	lis 9,szPrompt1@ha
	lis 11,g_nSBLineNum@ha
	la 29,szPrompt1@l(9)
	li 0,20
	stw 0,g_nSBLineNum@l(11)
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1010
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1011
.L1010:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1011:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 niq_help1,.Lfe34-niq_help1
	.section	".rodata"
	.align 2
.LC263:
	.string	"While any scoreboard is being displayed"
	.align 2
.LC264:
	.string	"hit '1' (use Blaster) to toggle among"
	.align 2
.LC265:
	.string	"the available scoreboards (some of these"
	.align 2
.LC266:
	.string	"require 512x384 or higher and some may"
	.align 2
.LC267:
	.string	"be disabled). PPH=Points Per Hour."
	.align 2
.LC268:
	.string	"While NO scoreboard or menu is up, you"
	.align 2
.LC269:
	.string	"can also change the HUD mini-scoreboard"
	.align 2
.LC270:
	.string	"format by hitting '1'. The mini-SB will"
	.align 2
.LC271:
	.string	"continuously show you how you are doing"
	.align 2
.LC272:
	.string	"relative to other players in the game."
	.align 2
.LC273:
	.string	"NOTE THAT: to change your video mode"
	.align 2
.LC274:
	.string	"and MP settings etc., first go to the"
	.align 2
.LC275:
	.string	"console (tilde), *then* hit the Esc key."
	.section	".text"
	.align 2
	.type	 niq_help2,@function
niq_help2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC263@ha
	lis 30,g_helpptr@ha
	la 29,.LC263@l(9)
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1014
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,g_helpptr@l(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	lis 28,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1015
.L1014:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,g_helpptr@l(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,29
	stb 0,40(29)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	lis 28,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1015:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC264@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC264@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1017
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1018
.L1017:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1018:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC265@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC265@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1020
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1021
.L1020:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1021:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC266@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC266@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1023
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1024
.L1023:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1024:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC267@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC267@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1026
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1027
.L1026:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1027:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC268@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC268@l(11)
	mr 3,29
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1029
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1030
.L1029:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1030:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC269@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC269@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1032
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1033
.L1032:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1033:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC270@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC270@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1035
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1036
.L1035:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1036:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC271@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC271@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1038
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1039
.L1038:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1039:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC272@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC272@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1041
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1042
.L1041:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1042:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC273@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC273@l(11)
	mr 3,29
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1044
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1045
.L1044:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1045:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC274@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC274@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1047
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1048
.L1047:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1048:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC275@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC275@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1050
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1051
.L1050:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1051:
	lis 9,szPrompt1@ha
	lis 11,g_nSBLineNum@ha
	la 29,szPrompt1@l(9)
	li 0,20
	stw 0,g_nSBLineNum@l(11)
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1053
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1054
.L1053:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1054:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 niq_help2,.Lfe35-niq_help2
	.section	".rodata"
	.align 2
.LC276:
	.string	"Use the 'incdf' and 'decdf' commands to"
	.align 2
.LC277:
	.string	"change your Damage Factor if voluntary"
	.align 2
.LC278:
	.string	"handicapping is enabled. This is a"
	.align 2
.LC279:
	.string	"voluntary system which allows you to"
	.align 2
.LC280:
	.string	"make up for being an LPB, for example."
	.align 2
.LC281:
	.string	"Certain NIQ scoreboards show the average"
	.align 2
.LC282:
	.string	"and current DFs for the current level."
	.align 2
.LC283:
	.string	"The tractor beam is enabled. Bind a"
	.align 2
.LC284:
	.string	"key to +hook (e.g. bind CTRL +hook)"
	.align 2
.LC285:
	.string	"to be able to use it."
	.align 2
.LC286:
	.string	"If the grappling hook is enabled, the"
	.align 2
.LC287:
	.string	"best way to switch between it and the"
	.align 2
.LC288:
	.string	"current (only available) weapon is to"
	.align 2
.LC289:
	.string	"bind a key to 'weapnext', e.g. type"
	.align 2
.LC290:
	.string	"'bind mouse1 weapnext' at the console."
	.align 2
.LC291:
	.string	"The 'id' command enables player id."
	.align 2
.LC292:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_help3,@function
niq_help3:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC276@ha
	lis 30,g_helpptr@ha
	la 29,.LC276@l(9)
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1057
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,g_helpptr@l(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	lis 28,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1058
.L1057:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,g_helpptr@l(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,29
	stb 0,40(29)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	lis 28,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1058:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC277@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC277@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1060
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1061
.L1060:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1061:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC278@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC278@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1063
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1064
.L1063:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1064:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC279@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC279@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1066
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1067
.L1066:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1067:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC280@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC280@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1069
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1070
.L1069:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1070:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC281@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC281@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1072
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1073
.L1072:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1073:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC282@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC282@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1075
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1076
.L1075:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1076:
	lis 11,.LC292@ha
	lis 9,niq_tractor@ha
	la 11,.LC292@l(11)
	lis 10,g_nSBLineNum@ha
	lfs 13,0(11)
	lwz 11,niq_tractor@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	fcmpu 0,0,13
	bc 12,2,.L1078
	lis 9,.LC283@ha
	la 29,.LC283@l(9)
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1079
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1080
.L1079:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1080:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC284@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC284@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1082
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1083
.L1082:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1083:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC285@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC285@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 4,1,.L1110
	b .L1101
.L1078:
	lis 9,.LC286@ha
	la 29,.LC286@l(9)
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1089
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1090
.L1089:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1090:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC287@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC287@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1092
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1093
.L1092:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1093:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC288@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC288@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1095
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1096
.L1095:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1096:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC289@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC289@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1098
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1099
.L1098:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1099:
	lis 10,g_nSBLineNum@ha
	lis 11,.LC290@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC290@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1101
.L1110:
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1102
.L1101:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1102:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lis 10,g_nSBLineNum@ha
	lis 11,.LC291@ha
	lwz 9,g_nSBLineNum@l(10)
	la 29,.LC291@l(11)
	mr 3,29
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1104
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1105
.L1104:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1105:
	lis 9,szPrompt1@ha
	lis 11,g_nSBLineNum@ha
	la 29,szPrompt1@l(9)
	li 0,20
	stw 0,g_nSBLineNum@l(11)
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1107
	lwz 6,g_nSBLineNum@l(28)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,29
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(30)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(30)
	b .L1108
.L1107:
	lwz 6,g_nSBLineNum@l(28)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(30)
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	stb 0,40(29)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(30)
	crxor 6,6,6
	blrl
.L1108:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 niq_help3,.Lfe36-niq_help3
	.section	".rodata"
	.align 2
.LC293:
	.string	"NIQ Settings (1/4)"
	.align 2
.LC294:
	.string	"NIQ enabled:"
	.align 2
.LC295:
	.string	"Bots enabled:"
	.align 2
.LC296:
	.string	"Voluntary handicapping:"
	.align 2
.LC297:
	.string	"Random weapons:"
	.align 2
.LC298:
	.string	"Use all weapons:"
	.align 2
.LC299:
	.string	"Weapon time (secs):"
	.align 2
.LC300:
	.string	"Tractor beam (+hook):"
	.align 2
.LC301:
	.string	"Superblaster damage:"
	.align 2
.LC302:
	.string	"Points gained for a kill:"
	.align 2
.LC303:
	.string	"Points lost for being killed:"
	.align 2
.LC304:
	.string	"Points lost for suiciding:"
	.align 3
.LC305:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_info1,@function
niq_info1:
	stwu 1,-176(1)
	mflr 0
	stmw 27,156(1)
	stw 0,180(1)
	lis 9,.LC293@ha
	lis 28,g_helpptr@ha
	la 30,.LC293@l(9)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1113
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	lis 27,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1114
.L1113:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,30
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	lis 27,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1114:
	lis 11,.LC305@ha
	lis 9,niq_enable@ha
	la 11,.LC305@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_enable@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1116
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1117
.L1116:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1117:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC294@ha
	la 29,g_helpptr@l(9)
	la 5,.LC294@l(11)
	bc 12,2,.L1120
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1119
.L1120:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1119:
	addi 3,1,8
	mr 30,3
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1122
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1123
.L1122:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1123:
	lis 11,.LC305@ha
	lis 9,niq_ebots@ha
	la 11,.LC305@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_ebots@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1126
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1127
.L1126:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1127:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC295@ha
	la 29,g_helpptr@l(9)
	la 5,.LC295@l(11)
	bc 12,2,.L1130
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1129
.L1130:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1129:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1132
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1133
.L1132:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1133:
	lis 11,.LC305@ha
	lis 9,niq_handicap@ha
	la 11,.LC305@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_handicap@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1136
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1137
.L1136:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1137:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC296@ha
	la 29,g_helpptr@l(9)
	la 5,.LC296@l(11)
	bc 12,2,.L1140
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1139
.L1140:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1139:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1142
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1143
.L1142:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1143:
	lis 11,.LC305@ha
	lis 9,niq_weaprand@ha
	la 11,.LC305@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_weaprand@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1146
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1147
.L1146:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1147:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC297@ha
	la 29,g_helpptr@l(9)
	la 5,.LC297@l(11)
	bc 12,2,.L1150
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1149
.L1150:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1149:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1152
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1153
.L1152:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1153:
	lis 11,.LC305@ha
	lis 9,niq_weapall@ha
	la 11,.LC305@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_weapall@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1156
	fctiwz 0,13
	stfd 0,144(1)
	lwz 10,148(1)
	b .L1157
.L1156:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 10,148(1)
	xoris 10,10,0x8000
.L1157:
	lis 11,.LC305@ha
	lis 9,niq_weaprand@ha
	la 11,.LC305@l(11)
	lfd 12,0(11)
	lwz 11,niq_weaprand@l(9)
	lfs 0,20(11)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1158
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1159
.L1158:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1159:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC298@ha
	la 29,g_helpptr@l(9)
	la 5,.LC298@l(11)
	bc 4,2,.L1160
	lis 4,.LC244@ha
	lis 6,.LC245@ha
	la 4,.LC244@l(4)
	la 6,.LC245@l(6)
	b .L1201
.L1160:
	cmpwi 0,10,0
	bc 12,2,.L1162
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
.L1201:
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1161
.L1162:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1161:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1164
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1165
.L1164:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1165:
	lis 9,niq_weapsecs@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_weapsecs@l(9)
	lis 5,.LC299@ha
	lwz 9,g_nSBLineNum@l(10)
	lis 4,.LC248@ha
	la 5,.LC299@l(5)
	lfs 0,20(11)
	la 4,.LC248@l(4)
	addi 3,1,8
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 6,148(1)
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1168
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1169
.L1168:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1169:
	lis 11,.LC305@ha
	lis 9,niq_tractor@ha
	la 11,.LC305@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_tractor@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1172
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1173
.L1172:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1173:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC300@ha
	la 29,g_helpptr@l(9)
	la 5,.LC300@l(11)
	bc 12,2,.L1176
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1175
.L1176:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1175:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1178
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1179
.L1178:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1179:
	lis 9,niq_sbhp@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_sbhp@l(9)
	lis 5,.LC301@ha
	lwz 9,g_nSBLineNum@l(10)
	lis 4,.LC248@ha
	la 5,.LC301@l(5)
	lfs 0,20(11)
	la 4,.LC248@l(4)
	addi 3,1,8
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 6,148(1)
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1182
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1183
.L1182:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1183:
	lis 9,niq_killpts@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_killpts@l(9)
	lis 5,.LC302@ha
	lis 4,.LC249@ha
	lwz 9,g_nSBLineNum@l(10)
	la 4,.LC249@l(4)
	la 5,.LC302@l(5)
	lfs 1,20(11)
	addi 3,1,8
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	creqv 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1186
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1187
.L1186:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1187:
	lis 9,niq_kildpts@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_kildpts@l(9)
	lis 5,.LC303@ha
	lis 4,.LC249@ha
	lwz 9,g_nSBLineNum@l(10)
	la 4,.LC249@l(4)
	la 5,.LC303@l(5)
	lfs 1,20(11)
	addi 3,1,8
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	creqv 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1190
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1191
.L1190:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1191:
	lis 9,niq_suicpts@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_suicpts@l(9)
	lis 5,.LC304@ha
	lis 4,.LC249@ha
	lwz 9,g_nSBLineNum@l(10)
	la 4,.LC249@l(4)
	la 5,.LC304@l(5)
	lfs 1,20(11)
	addi 3,1,8
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	creqv 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1194
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1195
.L1194:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	lwz 6,g_nSBLineNum@l(27)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1195:
	lis 9,szPrompt1@ha
	lis 11,g_nSBLineNum@ha
	la 30,szPrompt1@l(9)
	li 0,20
	stw 0,g_nSBLineNum@l(11)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1198
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1199
.L1198:
	lwz 6,g_nSBLineNum@l(27)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1199:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,180(1)
	mtlr 0
	lmw 27,156(1)
	la 1,176(1)
	blr
.Lfe37:
	.size	 niq_info1,.Lfe37-niq_info1
	.section	".rodata"
	.align 2
.LC306:
	.string	"NIQ Settings (2/4)"
	.align 2
.LC307:
	.string	"Maximum health:"
	.align 2
.LC308:
	.string	"Health increment:"
	.align 2
.LC309:
	.string	"Need a kill to get health:"
	.align 2
.LC310:
	.string	"Health increment sound:"
	.align 2
.LC311:
	.string	"Switch warning sound:"
	.align 2
.LC312:
	.string	"Weapon switch sound:"
	.align 2
.LC313:
	.string	"Weapon switch messages:"
	.align 2
.LC314:
	.string	"Skill setting (bots):"
	.align 2
.LC315:
	.string	"Visible weapons (requires pak):"
	.align 2
.LC316:
	.string	"Grappling hook (requires pak):"
	.align 2
.LC317:
	.string	"Player ID in any mode:"
	.align 2
.LC318:
	.long 0x0
	.align 3
.LC319:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_info2,@function
niq_info2:
	stwu 1,-176(1)
	mflr 0
	stmw 27,156(1)
	stw 0,180(1)
	lis 9,.LC306@ha
	lis 28,g_helpptr@ha
	la 31,.LC306@l(9)
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1203
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	lis 27,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,29,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1204
.L1203:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,31
	stb 0,40(31)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	lis 27,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1204:
	lis 9,niq_hlthmax@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_hlthmax@l(9)
	addi 3,1,8
	lwz 9,g_nSBLineNum@l(10)
	lis 5,.LC307@ha
	lis 4,.LC248@ha
	lfs 0,20(11)
	mr 29,3
	la 5,.LC307@l(5)
	addi 9,9,2
	la 4,.LC248@l(4)
	stw 9,g_nSBLineNum@l(10)
	mr 31,29
	fctiwz 13,0
	stfd 13,144(1)
	lwz 6,148(1)
	crxor 6,6,6
	bl sprintf
	mr 3,29
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1206
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,29,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,31
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,29,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1207
.L1206:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(31)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1207:
	lis 9,niq_hlthinc@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_hlthinc@l(9)
	lis 5,.LC308@ha
	lwz 9,g_nSBLineNum@l(10)
	lis 4,.LC248@ha
	la 5,.LC308@l(5)
	lfs 0,20(11)
	la 4,.LC248@l(4)
	addi 3,1,8
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 6,148(1)
	crxor 6,6,6
	bl sprintf
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1210
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,29,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,31
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,29,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1211
.L1210:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(31)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1211:
	lis 9,niq_auto@ha
	lis 11,.LC318@ha
	lwz 8,niq_auto@l(9)
	la 11,.LC318@l(11)
	lis 7,g_nSBLineNum@ha
	lfs 13,0(11)
	lis 10,.LC309@ha
	lfs 0,20(8)
	lis 11,g_helpptr@ha
	la 5,.LC309@l(10)
	lwz 9,g_nSBLineNum@l(7)
	la 30,g_helpptr@l(11)
	fcmpu 0,0,13
	addi 9,9,1
	stw 9,g_nSBLineNum@l(7)
	bc 4,2,.L1216
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1215
.L1216:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1215:
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1218
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,29,23
	add 0,0,9
	stw 0,0(30)
	b .L1219
.L1218:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(31)
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(30)
	crxor 6,6,6
	blrl
.L1219:
	lis 11,.LC319@ha
	lis 9,niq_sndhlth@ha
	la 11,.LC319@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_sndhlth@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1222
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1223
.L1222:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1223:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC310@ha
	la 30,g_helpptr@l(9)
	la 5,.LC310@l(11)
	bc 12,2,.L1226
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1225
.L1226:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1225:
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1228
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,29,23
	add 0,0,9
	stw 0,0(30)
	b .L1229
.L1228:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(31)
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(30)
	crxor 6,6,6
	blrl
.L1229:
	lis 11,.LC319@ha
	lis 9,niq_sndwarn@ha
	la 11,.LC319@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_sndwarn@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1232
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1233
.L1232:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1233:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC311@ha
	la 30,g_helpptr@l(9)
	la 5,.LC311@l(11)
	bc 12,2,.L1236
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1235
.L1236:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1235:
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1238
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,29,23
	add 0,0,9
	stw 0,0(30)
	b .L1239
.L1238:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(31)
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(30)
	crxor 6,6,6
	blrl
.L1239:
	lis 11,.LC319@ha
	lis 9,niq_sndswitch@ha
	la 11,.LC319@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_sndswitch@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1242
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1243
.L1242:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1243:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC312@ha
	la 30,g_helpptr@l(9)
	la 5,.LC312@l(11)
	bc 12,2,.L1246
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1245
.L1246:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1245:
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1248
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,29,23
	add 0,0,9
	stw 0,0(30)
	b .L1249
.L1248:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(31)
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(30)
	crxor 6,6,6
	blrl
.L1249:
	lis 11,.LC319@ha
	lis 9,niq_msgswitch@ha
	la 11,.LC319@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_msgswitch@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1252
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1253
.L1252:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1253:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC313@ha
	la 30,g_helpptr@l(9)
	la 5,.LC313@l(11)
	bc 12,2,.L1256
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1255
.L1256:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1255:
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1258
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,29,23
	add 0,0,9
	stw 0,0(30)
	b .L1259
.L1258:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(31)
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(30)
	crxor 6,6,6
	blrl
.L1259:
	lis 9,skill@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,skill@l(9)
	lis 5,.LC314@ha
	lwz 9,g_nSBLineNum@l(10)
	lis 4,.LC248@ha
	la 5,.LC314@l(5)
	lfs 0,20(11)
	la 4,.LC248@l(4)
	addi 3,1,8
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 6,148(1)
	crxor 6,6,6
	bl sprintf
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1262
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,29,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,31
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,29,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1263
.L1262:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(31)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1263:
	lis 11,.LC319@ha
	lis 9,view_weapons@ha
	la 11,.LC319@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,view_weapons@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1266
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1267
.L1266:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1267:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC315@ha
	la 30,g_helpptr@l(9)
	la 5,.LC315@l(11)
	bc 12,2,.L1270
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1269
.L1270:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1269:
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1272
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,29,23
	add 0,0,9
	stw 0,0(30)
	b .L1273
.L1272:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(31)
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(30)
	crxor 6,6,6
	blrl
.L1273:
	lis 11,.LC319@ha
	lis 9,grapple@ha
	la 11,.LC319@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,grapple@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1276
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1277
.L1276:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1277:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC316@ha
	la 30,g_helpptr@l(9)
	la 5,.LC316@l(11)
	bc 12,2,.L1280
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1279
.L1280:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1279:
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1282
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,29,23
	add 0,0,9
	stw 0,0(30)
	b .L1283
.L1282:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(31)
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(30)
	crxor 6,6,6
	blrl
.L1283:
	lis 11,.LC319@ha
	lis 9,niq_playerid@ha
	la 11,.LC319@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_playerid@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1286
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1287
.L1286:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1287:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC317@ha
	la 30,g_helpptr@l(9)
	la 5,.LC317@l(11)
	bc 12,2,.L1290
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1289
.L1290:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1289:
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1292
	lis 9,g_nSBLineNum@ha
	subfic 5,29,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,29,23
	add 0,0,9
	stw 0,0(30)
	b .L1293
.L1292:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,31
	stb 0,40(31)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(30)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(30)
	crxor 6,6,6
	blrl
.L1293:
	lis 9,szPrompt1@ha
	lis 11,g_nSBLineNum@ha
	la 31,szPrompt1@l(9)
	li 0,20
	stw 0,g_nSBLineNum@l(11)
	mr 3,31
	bl strlen
	mr 29,3
	cmpwi 0,29,40
	bc 12,1,.L1296
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,29,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,31
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,29,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1297
.L1296:
	lwz 6,g_nSBLineNum@l(27)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,31
	mulli 6,6,10
	stb 0,40(31)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1297:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,180(1)
	mtlr 0
	lmw 27,156(1)
	la 1,176(1)
	blr
.Lfe38:
	.size	 niq_info2,.Lfe38-niq_info2
	.section	".rodata"
	.align 2
.LC320:
	.string	"NIQ Settings (3/4)"
	.align 2
.LC321:
	.string	"Current map: %27s"
	.align 2
.LC322:
	.string	"Map cycling:"
	.align 2
.LC323:
	.string	"Random maps:"
	.align 2
.LC324:
	.string	"Use all maps:"
	.align 2
.LC325:
	.string	"Intermission end delay (secs):"
	.align 2
.LC326:
	.string	"Wide scoreboards enabled:"
	.align 2
.LC327:
	.string	"HUD mini-scoreboard enabled:"
	.align 2
.LC328:
	.string	"Debug scoreboard enabled:"
	.align 2
.LC329:
	.string	"Maximum scoreboard lines:"
	.align 3
.LC330:
	.long 0x41e00000
	.long 0x0
	.align 2
.LC331:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_info3,@function
niq_info3:
	stwu 1,-304(1)
	mflr 0
	stmw 27,284(1)
	stw 0,308(1)
	lis 9,.LC54@ha
	addi 3,1,9
	lbz 0,.LC54@l(9)
	li 4,0
	li 5,127
	lis 28,g_helpptr@ha
	stb 0,8(1)
	crxor 6,6,6
	bl memset
	lis 9,.LC320@ha
	la 30,.LC320@l(9)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1300
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	lis 27,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1301
.L1300:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,30
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	lis 27,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1301:
	lis 11,g_nSBLineNum@ha
	addi 3,1,8
	lwz 9,g_nSBLineNum@l(11)
	lis 4,.LC321@ha
	lis 5,level+72@ha
	la 4,.LC321@l(4)
	la 5,level+72@l(5)
	addi 9,9,2
	mr 30,3
	stw 9,g_nSBLineNum@l(11)
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1303
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1304
.L1303:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	lwz 6,g_nSBLineNum@l(27)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1304:
	lis 9,map_mod_@ha
	lis 8,g_nSBLineNum@ha
	lwz 0,map_mod_@l(9)
	lis 11,g_helpptr@ha
	lis 10,.LC322@ha
	lwz 9,g_nSBLineNum@l(8)
	la 29,g_helpptr@l(11)
	la 5,.LC322@l(10)
	cmpwi 0,0,0
	addi 9,9,1
	stw 9,g_nSBLineNum@l(8)
	bc 12,2,.L1308
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
	b .L1307
.L1308:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
.L1307:
	addi 3,1,136
	mr 30,3
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1310
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1311
.L1310:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1311:
	lis 11,.LC330@ha
	lis 9,mapmod_random@ha
	la 11,.LC330@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,mapmod_random@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1314
	fctiwz 0,13
	stfd 0,272(1)
	lwz 10,276(1)
	b .L1315
.L1314:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,272(1)
	lwz 10,276(1)
	xoris 10,10,0x8000
.L1315:
	lis 9,map_mod_@ha
	lis 11,g_helpptr@ha
	lwz 0,map_mod_@l(9)
	la 29,g_helpptr@l(11)
	lis 9,.LC323@ha
	cmpwi 0,0,0
	la 5,.LC323@l(9)
	bc 4,2,.L1316
	lis 4,.LC244@ha
	lis 6,.LC245@ha
	la 4,.LC244@l(4)
	la 6,.LC245@l(6)
	b .L1378
.L1316:
	cmpwi 0,10,0
	bc 12,2,.L1318
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
.L1378:
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
	b .L1317
.L1318:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
.L1317:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1320
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1321
.L1320:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1321:
	lis 11,.LC330@ha
	lis 9,niq_allmaps@ha
	la 11,.LC330@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_allmaps@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1324
	fctiwz 0,13
	stfd 0,272(1)
	lwz 10,276(1)
	b .L1325
.L1324:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,272(1)
	lwz 10,276(1)
	xoris 10,10,0x8000
.L1325:
	lis 9,map_mod_@ha
	li 11,0
	lwz 0,map_mod_@l(9)
	cmpwi 0,0,0
	bc 12,2,.L1326
	lis 9,.LC331@ha
	lis 11,mapmod_random@ha
	la 9,.LC331@l(9)
	lfs 13,0(9)
	lwz 9,mapmod_random@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	crnor 31,30,30
	mfcr 11
	rlwinm 11,11,0,1
.L1326:
	cmpwi 0,11,0
	lis 9,g_helpptr@ha
	lis 11,.LC324@ha
	la 29,g_helpptr@l(9)
	la 5,.LC324@l(11)
	bc 4,2,.L1327
	lis 4,.LC244@ha
	lis 6,.LC245@ha
	la 4,.LC244@l(4)
	la 6,.LC245@l(6)
	b .L1379
.L1327:
	cmpwi 0,10,0
	bc 12,2,.L1329
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
.L1379:
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
	b .L1328
.L1329:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
.L1328:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1331
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1332
.L1331:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1332:
	lis 9,niq_inttime@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_inttime@l(9)
	lis 5,.LC325@ha
	lwz 9,g_nSBLineNum@l(10)
	lis 4,.LC248@ha
	la 5,.LC325@l(5)
	lfs 0,20(11)
	la 4,.LC248@l(4)
	addi 3,1,136
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fctiwz 13,0
	stfd 13,272(1)
	lwz 6,276(1)
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1335
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1336
.L1335:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1336:
	lis 11,.LC330@ha
	lis 9,niq_sbwide@ha
	la 11,.LC330@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_sbwide@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1339
	fctiwz 0,13
	stfd 0,272(1)
	lwz 0,276(1)
	b .L1340
.L1339:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,272(1)
	lwz 0,276(1)
	xoris 0,0,0x8000
.L1340:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC326@ha
	la 29,g_helpptr@l(9)
	la 5,.LC326@l(11)
	bc 12,2,.L1343
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
	b .L1342
.L1343:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
.L1342:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1345
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1346
.L1345:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1346:
	lis 11,.LC330@ha
	lis 9,niq_sbmini@ha
	la 11,.LC330@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_sbmini@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1349
	fctiwz 0,13
	stfd 0,272(1)
	lwz 0,276(1)
	b .L1350
.L1349:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,272(1)
	lwz 0,276(1)
	xoris 0,0,0x8000
.L1350:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC327@ha
	la 29,g_helpptr@l(9)
	la 5,.LC327@l(11)
	bc 12,2,.L1353
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
	b .L1352
.L1353:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
.L1352:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1355
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1356
.L1355:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1356:
	lis 11,.LC330@ha
	lis 9,niq_sbdebug@ha
	la 11,.LC330@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_sbdebug@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1359
	fctiwz 0,13
	stfd 0,272(1)
	lwz 10,276(1)
	b .L1360
.L1359:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,272(1)
	lwz 10,276(1)
	xoris 10,10,0x8000
.L1360:
	lis 11,.LC330@ha
	lis 9,niq_sbwide@ha
	la 11,.LC330@l(11)
	lfd 12,0(11)
	lwz 11,niq_sbwide@l(9)
	lfs 0,20(11)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1361
	fctiwz 0,13
	stfd 0,272(1)
	lwz 0,276(1)
	b .L1362
.L1361:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,272(1)
	lwz 0,276(1)
	xoris 0,0,0x8000
.L1362:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC328@ha
	la 29,g_helpptr@l(9)
	la 5,.LC328@l(11)
	bc 4,2,.L1363
	lis 4,.LC244@ha
	lis 6,.LC245@ha
	la 4,.LC244@l(4)
	la 6,.LC245@l(6)
	b .L1380
.L1363:
	cmpwi 0,10,0
	bc 12,2,.L1365
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
.L1380:
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
	b .L1364
.L1365:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,136
	crxor 6,6,6
	bl sprintf
.L1364:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1367
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1368
.L1367:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1368:
	lis 9,niq_sblines@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,niq_sblines@l(9)
	lis 5,.LC329@ha
	lwz 9,g_nSBLineNum@l(10)
	lis 4,.LC248@ha
	la 5,.LC329@l(5)
	lfs 0,20(11)
	la 4,.LC248@l(4)
	addi 3,1,136
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fctiwz 13,0
	stfd 13,272(1)
	lwz 6,276(1)
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1371
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1372
.L1371:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	lwz 6,g_nSBLineNum@l(27)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1372:
	lis 9,szPrompt1@ha
	lis 11,g_nSBLineNum@ha
	la 30,szPrompt1@l(9)
	li 0,20
	stw 0,g_nSBLineNum@l(11)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1375
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1376
.L1375:
	lwz 6,g_nSBLineNum@l(27)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1376:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,308(1)
	mtlr 0
	lmw 27,284(1)
	la 1,304(1)
	blr
.Lfe39:
	.size	 niq_info3,.Lfe39-niq_info3
	.section	".rodata"
	.align 2
.LC332:
	.string	"NIQ Settings (4/4)"
	.align 2
.LC333:
	.string	"CTF enabled (requires pak):"
	.align 2
.LC334:
	.string	"Spawn farthest:"
	.align 2
.LC335:
	.string	"Force respawn:"
	.align 2
.LC336:
	.string	"Friendly fire does damage:"
	.align 2
.LC337:
	.string	"Skin teams:"
	.align 2
.LC338:
	.string	"Model teams:"
	.align 2
.LC339:
	.string	"Fraglimit:"
	.align 2
.LC340:
	.string	"Timelimit:"
	.align 2
.LC341:
	.string	"Capturelimit:"
	.align 2
.LC342:
	.string	"Logging enabled (thx Mr.Bungle):"
	.align 3
.LC343:
	.long 0x41e00000
	.long 0x0
	.align 2
.LC344:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_info4,@function
niq_info4:
	stwu 1,-176(1)
	mflr 0
	stmw 27,156(1)
	stw 0,180(1)
	lis 9,.LC332@ha
	lis 28,g_helpptr@ha
	la 30,.LC332@l(9)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1382
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	lis 27,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1383
.L1382:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,g_helpptr@l(28)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,30
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	lis 27,g_nSBLineNum@ha
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1383:
	lis 11,.LC343@ha
	lis 9,ctf@ha
	la 11,.LC343@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,ctf@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1385
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1386
.L1385:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1386:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC333@ha
	la 29,g_helpptr@l(9)
	la 5,.LC333@l(11)
	bc 12,2,.L1389
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1388
.L1389:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1388:
	addi 3,1,8
	mr 30,3
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1391
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1392
.L1391:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1392:
	lis 9,dmflags@ha
	lwz 7,dmflags@l(9)
	lis 6,g_nSBLineNum@ha
	lis 11,g_helpptr@ha
	lwz 9,g_nSBLineNum@l(6)
	lis 10,.LC334@ha
	la 29,g_helpptr@l(11)
	lfs 0,20(7)
	la 5,.LC334@l(10)
	addi 9,9,2
	stw 9,g_nSBLineNum@l(6)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 8,148(1)
	andi. 0,8,512
	bc 12,2,.L1397
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1396
.L1397:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1396:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1399
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1400
.L1399:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1400:
	lis 9,dmflags@ha
	lwz 7,dmflags@l(9)
	lis 6,g_nSBLineNum@ha
	lis 11,g_helpptr@ha
	lwz 9,g_nSBLineNum@l(6)
	lis 10,.LC335@ha
	la 29,g_helpptr@l(11)
	lfs 0,20(7)
	la 5,.LC335@l(10)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(6)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 8,148(1)
	andi. 0,8,1024
	bc 12,2,.L1405
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1404
.L1405:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1404:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1407
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1408
.L1407:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1408:
	lis 9,dmflags@ha
	lwz 7,dmflags@l(9)
	lis 6,g_nSBLineNum@ha
	lis 11,g_helpptr@ha
	lwz 9,g_nSBLineNum@l(6)
	lis 10,.LC336@ha
	la 29,g_helpptr@l(11)
	lfs 0,20(7)
	la 5,.LC336@l(10)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(6)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 8,148(1)
	xori 8,8,256
	andi. 0,8,256
	bc 12,2,.L1413
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1412
.L1413:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1412:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1415
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1416
.L1415:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1416:
	lis 9,dmflags@ha
	lwz 7,dmflags@l(9)
	lis 6,g_nSBLineNum@ha
	lis 11,g_helpptr@ha
	lwz 9,g_nSBLineNum@l(6)
	lis 10,.LC337@ha
	la 29,g_helpptr@l(11)
	lfs 0,20(7)
	la 5,.LC337@l(10)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(6)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 8,148(1)
	andi. 0,8,64
	bc 12,2,.L1421
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1420
.L1421:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1420:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1423
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1424
.L1423:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1424:
	lis 9,dmflags@ha
	lwz 7,dmflags@l(9)
	lis 6,g_nSBLineNum@ha
	lis 11,g_helpptr@ha
	lwz 9,g_nSBLineNum@l(6)
	lis 10,.LC338@ha
	la 29,g_helpptr@l(11)
	lfs 0,20(7)
	la 5,.LC338@l(10)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(6)
	fctiwz 13,0
	stfd 13,144(1)
	lwz 8,148(1)
	andi. 0,8,128
	bc 12,2,.L1429
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1428
.L1429:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1428:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1431
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1432
.L1431:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	li 5,0
	stb 0,40(30)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1432:
	lis 9,fraglimit@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,fraglimit@l(9)
	lis 5,.LC339@ha
	lis 4,.LC249@ha
	lwz 9,g_nSBLineNum@l(10)
	la 4,.LC249@l(4)
	la 5,.LC339@l(5)
	lfs 1,20(11)
	addi 3,1,8
	addi 9,9,2
	stw 9,g_nSBLineNum@l(10)
	creqv 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1435
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1436
.L1435:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1436:
	lis 9,timelimit@ha
	lis 10,g_nSBLineNum@ha
	lwz 11,timelimit@l(9)
	lis 5,.LC340@ha
	lis 4,.LC249@ha
	lwz 9,g_nSBLineNum@l(10)
	la 4,.LC249@l(4)
	la 5,.LC340@l(5)
	lfs 1,20(11)
	addi 3,1,8
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	creqv 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1439
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1440
.L1439:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1440:
	lis 11,.LC344@ha
	lis 9,ctf@ha
	la 11,.LC344@l(11)
	lis 10,g_nSBLineNum@ha
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fcmpu 0,0,13
	bc 12,2,.L1443
	lis 9,capturelimit@ha
	lwz 11,capturelimit@l(9)
	lis 5,.LC341@ha
	lis 4,.LC248@ha
	la 4,.LC248@l(4)
	la 5,.LC341@l(5)
	lfs 0,20(11)
	addi 3,1,8
	fctiwz 13,0
	stfd 13,144(1)
	lwz 6,148(1)
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1444
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1445
.L1444:
	li 0,0
	lwz 3,g_helpptr@l(28)
	lis 4,.LC236@ha
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	lwz 6,g_nSBLineNum@l(27)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1445:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
.L1443:
	lis 11,.LC343@ha
	lis 9,niq_logfile@ha
	la 11,.LC343@l(11)
	lis 10,g_nSBLineNum@ha
	lfd 12,0(11)
	lwz 11,niq_logfile@l(9)
	lwz 9,g_nSBLineNum@l(10)
	lfs 0,20(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(10)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L1448
	fctiwz 0,13
	stfd 0,144(1)
	lwz 0,148(1)
	b .L1449
.L1448:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,144(1)
	lwz 0,148(1)
	xoris 0,0,0x8000
.L1449:
	cmpwi 0,0,0
	lis 9,g_helpptr@ha
	lis 11,.LC342@ha
	la 29,g_helpptr@l(9)
	la 5,.LC342@l(11)
	bc 12,2,.L1452
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	la 6,.LC246@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L1451
.L1452:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L1451:
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1454
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L1455
.L1454:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,30
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,0(29)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,0(29)
	crxor 6,6,6
	blrl
.L1455:
	lis 9,szPrompt1@ha
	lis 11,g_nSBLineNum@ha
	la 30,szPrompt1@l(9)
	li 0,20
	stw 0,g_nSBLineNum@l(11)
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L1458
	lwz 6,g_nSBLineNum@l(27)
	subfic 5,31,40
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	slwi 5,5,2
	mulli 6,6,10
	mr 7,30
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 9,31,23
	add 0,0,9
	stw 0,g_helpptr@l(28)
	b .L1459
.L1458:
	lwz 6,g_nSBLineNum@l(27)
	li 0,0
	lis 4,.LC236@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	stb 0,40(30)
	li 5,0
	crxor 6,6,6
	bl sprintf
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	lwz 9,g_helpptr@l(28)
	lwz 0,gi+4@l(11)
	la 3,.LC237@l(3)
	addi 9,9,63
	mtlr 0
	stw 9,g_helpptr@l(28)
	crxor 6,6,6
	blrl
.L1459:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,180(1)
	mtlr 0
	lmw 27,156(1)
	la 1,176(1)
	blr
.Lfe40:
	.size	 niq_info4,.Lfe40-niq_info4
	.section	".rodata"
	.align 2
.LC345:
	.string	"xv %-3d yb -20 string \"%s\""
	.align 2
.LC346:
	.string	"xv %-3d yb -10 string \"%s\""
	.align 2
.LC347:
	.string	"NIQ: invalid help level\n"
	.section	".text"
	.align 2
	.globl niq_help
	.type	 niq_help,@function
niq_help:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	lis 9,g_helpstr@ha
	lwz 8,84(31)
	la 9,g_helpstr@l(9)
	lis 11,g_helpptr@ha
	lis 10,g_nSBLineNum@ha
	li 0,4
	stw 9,g_helpptr@l(11)
	cmpwi 0,8,0
	stw 0,g_nSBLineNum@l(10)
	bc 12,2,.L1462
	lwz 0,1820(8)
	cmpwi 0,0,0
	bc 4,2,.L1462
	lwz 9,3536(8)
	addi 9,9,-1
	cmplwi 0,9,8
	bc 12,1,.L1476
	lis 11,.L1477@ha
	slwi 10,9,2
	la 11,.L1477@l(11)
	lis 9,.L1477@ha
	lwzx 0,10,11
	la 9,.L1477@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L1477:
	.long .L1466-.L1477
	.long .L1467-.L1477
	.long .L1468-.L1477
	.long .L1469-.L1477
	.long .L1470-.L1477
	.long .L1471-.L1477
	.long .L1472-.L1477
	.long .L1473-.L1477
	.long .L1474-.L1477
.L1466:
	mr 3,31
	bl niq_motd
	b .L1465
.L1467:
	mr 3,31
	bl niq_help1
	b .L1465
.L1468:
	mr 3,31
	bl niq_help2
	b .L1465
.L1469:
	mr 3,31
	bl niq_help3
	b .L1465
.L1470:
	mr 3,31
	bl niq_info1
	b .L1465
.L1471:
	mr 3,31
	bl niq_info2
	b .L1465
.L1472:
	mr 3,31
	bl niq_info3
	b .L1465
.L1473:
	mr 3,31
	bl niq_info4
	b .L1465
.L1474:
	lis 27,szBlank1@ha
	lis 28,g_helpptr@ha
	la 3,szBlank1@l(27)
	lis 26,szBlank2@ha
	bl strlen
	mr 29,3
	lis 4,.LC345@ha
	subfic 5,29,40
	lis 3,g_helpstr@ha
	la 4,.LC345@l(4)
	slwi 5,5,2
	la 6,szBlank1@l(27)
	la 3,g_helpstr@l(3)
	crxor 6,6,6
	bl sprintf
	lwz 0,g_helpptr@l(28)
	addi 29,29,23
	la 3,szBlank2@l(26)
	add 0,0,29
	stw 0,g_helpptr@l(28)
	bl strlen
	subfic 5,3,40
	lis 4,.LC346@ha
	lwz 3,g_helpptr@l(28)
	la 4,.LC346@l(4)
	slwi 5,5,2
	la 6,szBlank2@l(26)
	crxor 6,6,6
	bl sprintf
	b .L1465
.L1476:
	lis 9,gi+4@ha
	lis 3,.LC347@ha
	lwz 0,gi+4@l(9)
	la 3,.LC347@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L1465:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,g_helpstr@ha
	la 3,g_helpstr@l(3)
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,0
	mtlr 0
	blrl
.L1462:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe41:
	.size	 niq_help,.Lfe41-niq_help
	.section	".rodata"
	.align 2
.LC348:
	.string	"NIQ selects all weapons for you.\n"
	.align 2
.LC349:
	.string	"Only the grapple hook or the current weapon can be selected in CTF mode.\n"
	.align 2
.LC350:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_cmd_use_f,@function
niq_cmd_use_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	lwz 9,164(31)
	mtlr 9
	blrl
	bl FindItem
	mr. 3,3
	bc 12,2,.L1479
	lwz 0,8(3)
	cmpwi 0,0,0
	bc 12,2,.L1479
	lwz 0,56(3)
	andi. 9,0,1
	bc 12,2,.L1479
	lis 11,.LC350@ha
	lis 9,ctf@ha
	la 11,.LC350@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L1480
	lis 9,grapple@ha
	lwz 11,grapple@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L1480
	lwz 0,8(31)
	lis 5,.LC348@ha
	mr 3,30
	la 5,.LC348@l(5)
	b .L1485
.L1480:
	lis 29,itemlist@ha
	lis 28,0x38e3
	la 29,itemlist@l(29)
	ori 28,28,36409
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	srawi 31,0,3
	bl FindItem
	subf 3,29,3
	mullw 3,3,28
	srawi 3,3,3
	cmpw 0,31,3
	bc 12,2,.L1479
	lis 11,game+1564@ha
	lis 9,niqlist@ha
	lwz 0,game+1564@l(11)
	la 9,niqlist@l(9)
	addi 9,9,24
	mulli 0,0,36
	lwzx 11,9,0
	cmpw 0,31,11
	bc 12,2,.L1478
	lis 9,gi+8@ha
	lis 5,.LC349@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC349@l(5)
.L1485:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1478
.L1479:
	mr 3,30
	bl Cmd_Use_f
.L1478:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 niq_cmd_use_f,.Lfe42-niq_cmd_use_f
	.section	".rodata"
	.align 2
.LC351:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC352:
	.string	"all"
	.align 2
.LC353:
	.string	"health"
	.align 2
.LC354:
	.string	"ammo"
	.align 2
.LC355:
	.string	"unknown item\n"
	.align 2
.LC356:
	.string	"non-pickup item\n"
	.align 2
.LC357:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_cmd_give_f,@function
niq_cmd_give_f:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 25,20(1)
	stw 0,52(1)
	stw 12,16(1)
	lis 9,deathmatch@ha
	lis 10,.LC357@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC357@l(10)
	mr 27,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1487
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L1487
	lis 9,gi+8@ha
	lis 5,.LC351@ha
	lwz 0,gi+8@l(9)
	la 5,.LC351@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1486
.L1487:
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,164(30)
	mtlr 9
	blrl
	mr 26,3
	lis 4,.LC352@ha
	la 4,.LC352@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 29,0,3
	mfcr 31
	bc 4,2,.L1491
	lwz 9,160(30)
	li 3,1
	rlwinm 31,31,16,0xffffffff
	mtcrf 8,31
	rlwinm 31,31,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC353@ha
	la 4,.LC353@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1490
.L1491:
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L1492
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(27)
	b .L1493
.L1492:
	lwz 0,484(27)
	stw 0,480(27)
.L1493:
	cmpwi 4,29,0
	bc 12,18,.L1486
.L1490:
	bc 4,18,.L1496
	lis 4,.LC354@ha
	mr 3,26
	la 4,.LC354@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1495
.L1496:
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L1498
	lis 9,itemlist@ha
	mr 25,11
	la 28,itemlist@l(9)
	li 29,0
.L1500:
	mr 31,28
	lwz 0,56(31)
	andi. 9,0,2
	bc 12,2,.L1499
	lwz 9,84(27)
	addi 9,9,740
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 12,2,.L1499
	mr 4,31
	mr 3,27
	li 5,1000
	bl Add_Ammo
.L1499:
	lwz 0,1556(25)
	addi 30,30,1
	addi 29,29,4
	addi 28,28,72
	cmpw 0,30,0
	bc 12,0,.L1500
.L1498:
	bc 12,18,.L1486
.L1495:
	bc 12,18,.L1505
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L1486
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L1509:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L1508
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L1508
	lwz 9,84(27)
	addi 9,9,740
	stwx 8,9,10
.L1508:
	lwz 0,1556(7)
	addi 30,30,1
	addi 10,10,4
	addi 11,11,72
	cmpw 0,30,0
	bc 12,0,.L1509
	b .L1486
.L1505:
	mr 3,26
	bl FindItem
	mr. 31,3
	bc 4,2,.L1513
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	bl FindItem
	mr. 31,3
	bc 4,2,.L1513
	lwz 0,4(30)
	lis 3,.LC355@ha
	la 3,.LC355@l(3)
	b .L1521
.L1513:
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 4,2,.L1515
	lis 9,gi+4@ha
	lis 3,.LC356@ha
	lwz 0,gi+4@l(9)
	la 3,.LC356@l(3)
.L1521:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1486
.L1515:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,56(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,31
	andi. 10,11,2
	mullw 9,9,0
	srawi 29,9,3
	bc 12,2,.L1516
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L1517
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(27)
	slwi 0,29,2
	addi 9,9,740
	stwx 3,9,0
	b .L1486
.L1517:
	lwz 9,84(27)
	slwi 10,29,2
	lwz 11,48(31)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L1486
.L1516:
	bl G_Spawn
	lwz 0,0(31)
	mr 30,3
	mr 4,31
	stw 0,280(30)
	bl SpawnItem
	mr 4,27
	mr 3,30
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L1486
	mr 3,30
	bl G_FreeEdict
.L1486:
	lwz 0,52(1)
	lwz 12,16(1)
	mtlr 0
	lmw 25,20(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe43:
	.size	 niq_cmd_give_f,.Lfe43-niq_cmd_give_f
	.section	".rodata"
	.align 2
.LC358:
	.string	"%s joins NIQ, %d client(s)\n"
	.align 2
.LC359:
	.long 0x0
	.section	".text"
	.align 2
	.type	 NIQEndObserverMode,@function
NIQEndObserverMode:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,184(31)
	andi. 9,0,1
	bc 12,2,.L1522
	lis 9,ctf@ha
	lwz 10,84(31)
	li 0,1
	lwz 11,ctf@l(9)
	lis 9,.LC359@ha
	stw 0,1816(10)
	la 9,.LC359@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L1524
	bl CTFStartClient
	mr 3,31
	bl niq_updatescreen
	b .L1522
.L1524:
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 10,84(31)
	li 0,6
	li 9,32
	stw 0,80(31)
	li 8,14
	lis 7,game+1544@ha
	stb 9,16(10)
	lis 11,gi@ha
	li 6,0
	lwz 9,84(31)
	la 10,gi@l(11)
	stb 8,17(9)
	lwz 0,game+1544@l(7)
	lwz 9,84(31)
	cmpwi 0,0,0
	addi 5,9,700
	bc 4,1,.L1531
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 11,9,1332
.L1527:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L1529
	lwz 0,84(11)
	addi 9,6,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,6,0
	or 6,0,9
.L1529:
	addi 11,11,1332
	bdnz .L1527
.L1531:
	lwz 0,0(10)
	lis 4,.LC358@ha
	li 3,2
	la 4,.LC358@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl niq_updatescreen
.L1522:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe44:
	.size	 NIQEndObserverMode,.Lfe44-NIQEndObserverMode
	.section	".rodata"
	.align 2
.LC360:
	.string	"nmotd"
	.align 2
.LC361:
	.string	"nhelp"
	.align 2
.LC362:
	.string	"ninfo"
	.align 2
.LC363:
	.string	"incdf"
	.align 2
.LC364:
	.string	"decdf"
	.align 2
.LC368:
	.string	"maxdf"
	.align 2
.LC369:
	.string	"mindf"
	.align 2
.LC370:
	.string	"resetdf"
	.align 2
.LC371:
	.string	"showdf"
	.align 3
.LC365:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC366:
	.long 0x3fb9db22
	.long 0xd0e56042
	.align 2
.LC367:
	.long 0x3dcccccd
	.align 2
.LC372:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_command,@function
niq_command:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	lis 4,.LC360@ha
	mr 3,30
	la 4,.LC360@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L1537
	lwz 9,84(31)
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1538
	stw 3,3536(9)
	mr 3,31
	bl niq_updatescreen
	mr 3,31
	bl NIQEndObserverMode
	b .L1581
.L1538:
	stw 0,3580(9)
	mr 3,31
	lwz 9,84(31)
	stw 0,3584(9)
	lwz 11,84(31)
	stw 0,3568(11)
	lwz 9,84(31)
	li 0,1
	stw 0,3536(9)
	bl niq_help
	b .L1581
.L1537:
	lis 4,.LC361@ha
	mr 3,30
	la 4,.LC361@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L1541
	lwz 9,84(31)
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1542
	stw 3,3536(9)
	mr 3,31
	bl niq_updatescreen
	mr 3,31
	bl NIQEndObserverMode
	b .L1581
.L1542:
	stw 0,3580(9)
	mr 3,31
	lwz 9,84(31)
	stw 0,3584(9)
	lwz 11,84(31)
	stw 0,3568(11)
	lwz 9,84(31)
	li 0,2
	stw 0,3536(9)
	bl niq_help
	b .L1581
.L1541:
	lis 4,.LC362@ha
	mr 3,30
	la 4,.LC362@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L1545
	lwz 9,84(31)
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1546
	stw 3,3536(9)
	mr 3,31
	bl niq_updatescreen
	mr 3,31
	bl NIQEndObserverMode
	b .L1581
.L1546:
	stw 0,3580(9)
	mr 3,31
	lwz 9,84(31)
	stw 0,3584(9)
	lwz 11,84(31)
	stw 0,3568(11)
	lwz 9,84(31)
	li 0,5
	stw 0,3536(9)
	bl niq_help
	b .L1581
.L1545:
	lis 11,.LC372@ha
	lis 9,niq_enable@ha
	la 11,.LC372@l(11)
	li 3,0
	lfs 31,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L1575
	lis 4,.LC363@ha
	mr 3,30
	la 4,.LC363@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1550
	mr 3,31
	bl niq_increase_damage
.L1581:
	li 3,1
	b .L1575
.L1550:
	lis 4,.LC364@ha
	mr 3,30
	la 4,.LC364@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1551
	cmpwi 0,31,0
	bc 12,2,.L1581
	lis 9,niq_handicap@ha
	lwz 11,niq_handicap@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L1554
	lis 9,gi+8@ha
	lis 5,.LC222@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC222@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1581
.L1554:
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L1581
	lfs 0,1804(10)
	lis 9,.LC365@ha
	lis 11,.LC366@ha
	lfd 13,.LC365@l(9)
	fsub 0,0,13
	frsp 0,0
	stfs 0,1804(10)
	lwz 10,84(31)
	lfd 13,.LC366@l(11)
	lfs 0,1804(10)
	fcmpu 0,0,13
	bc 4,0,.L1556
	lis 9,.LC367@ha
	lfs 0,.LC367@l(9)
	stfs 0,1804(10)
.L1556:
	lwz 11,84(31)
	lis 9,gi+8@ha
	lis 5,.LC227@ha
	lwz 0,gi+8@l(9)
	la 5,.LC227@l(5)
	mr 3,31
	lfs 1,1804(11)
	li 4,2
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L1581
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
	b .L1581
.L1551:
	lis 4,.LC368@ha
	mr 3,30
	la 4,.LC368@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1558
	mr 3,31
	bl niq_max_damage
	b .L1581
.L1558:
	lis 4,.LC369@ha
	mr 3,30
	la 4,.LC369@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1559
	cmpwi 0,31,0
	bc 12,2,.L1581
	lis 9,niq_handicap@ha
	lwz 11,niq_handicap@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L1562
	lis 9,gi+8@ha
	lis 5,.LC222@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC222@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1581
.L1562:
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L1581
	lis 9,.LC367@ha
	lis 11,gi+8@ha
	lfs 0,.LC367@l(9)
	lis 5,.LC227@ha
	mr 3,31
	la 5,.LC227@l(5)
	li 4,2
	stfs 0,1804(10)
	lwz 9,84(31)
	lwz 0,gi+8@l(11)
	lfs 1,1804(9)
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L1581
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
	b .L1581
.L1559:
	lis 4,.LC370@ha
	mr 3,30
	la 4,.LC370@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1565
	cmpwi 0,31,0
	bc 12,2,.L1581
	lis 9,niq_handicap@ha
	lwz 11,niq_handicap@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L1568
	lis 9,gi+8@ha
	lis 5,.LC222@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC222@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1581
.L1568:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L1581
	lis 0,0x3f80
	lis 11,gi+8@ha
	stw 0,1804(9)
	lis 5,.LC227@ha
	mr 3,31
	lwz 9,84(31)
	la 5,.LC227@l(5)
	li 4,2
	lwz 0,gi+8@l(11)
	lfs 1,1804(9)
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L1581
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
	b .L1581
.L1565:
	lis 4,.LC371@ha
	mr 3,30
	la 4,.LC371@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1571
	cmpwi 0,31,0
	bc 12,2,.L1581
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L1581
	lfs 1,1804(9)
	lis 5,.LC235@ha
	mr 3,31
	lis 9,gi+8@ha
	la 5,.LC235@l(5)
	lwz 0,gi+8@l(9)
	li 4,2
	mtlr 0
	creqv 6,6,6
	blrl
	b .L1581
.L1571:
	li 3,0
.L1575:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 niq_command,.Lfe45-niq_command
	.section	".rodata"
	.align 2
.LC373:
	.string	"use"
	.align 2
.LC374:
	.string	"Blaster"
	.align 2
.LC375:
	.long 0x0
	.section	".text"
	.align 2
	.type	 niq_toggle_cmd,@function
niq_toggle_cmd:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,.LC373@ha
	mr 3,4
	la 4,.LC373@l(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1585
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lis 4,.LC374@ha
	la 4,.LC374@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1585
	lis 11,.LC375@ha
	lis 9,deathmatch@ha
	la 11,.LC375@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1585
	lwz 10,84(31)
	lwz 0,3568(10)
	cmpwi 0,0,0
	bc 4,2,.L1598
	lwz 0,3536(10)
	cmpwi 0,0,0
	bc 12,2,.L1589
.L1599:
	li 3,1
	b .L1597
.L1598:
	mr 3,31
	bl niq_toggle_scoreboard
	b .L1599
.L1589:
	cmpwi 0,10,0
	bc 12,2,.L1599
	lis 9,niq_sbmini@ha
	lwz 11,niq_sbmini@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L1593
	stw 0,1812(10)
	b .L1594
.L1593:
	lwz 9,1812(10)
	addi 9,9,1
	cmpwi 0,9,4
	stw 9,1812(10)
	bc 4,1,.L1594
	lwz 9,84(31)
	stw 0,1812(9)
.L1594:
	lwz 9,84(31)
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 4,2,.L1599
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 4,2,.L1599
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 4,2,.L1599
	mr 3,31
	bl niq_updatescreen
	b .L1599
.L1585:
	li 3,0
.L1597:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe46:
	.size	 niq_toggle_cmd,.Lfe46-niq_toggle_cmd
	.section	".rodata"
	.align 2
.LC376:
	.string	"putaway"
	.align 2
.LC377:
	.string	"inven"
	.align 2
.LC378:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_blocked_intermission_cmd
	.type	 niq_blocked_intermission_cmd,@function
niq_blocked_intermission_cmd:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 0,184(31)
	li 3,0
	andi. 9,0,1
	bc 12,2,.L1621
	mr 3,31
	bl niq_toggle_cmd
	cmpwi 0,3,0
	bc 12,2,.L1614
.L1622:
	li 3,1
	b .L1621
.L1614:
	lis 9,.LC378@ha
	lis 11,ctf@ha
	la 9,.LC378@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L1616
	lwz 9,84(31)
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1615
.L1616:
	lis 4,.LC376@ha
	mr 3,30
	la 4,.LC376@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L1615
	lwz 9,84(31)
	stw 10,3536(9)
	lwz 0,184(31)
	andi. 9,0,1
	bc 4,2,.L1617
	mr 3,31
	bl Cmd_PutAway_f
	b .L1622
.L1617:
	lwz 9,84(31)
	mr 3,31
	stw 10,3568(9)
	lwz 11,84(31)
	stw 10,3584(11)
	lwz 9,84(31)
	stw 10,3580(9)
	bl NIQEndObserverMode
	b .L1622
.L1615:
	lis 9,.LC378@ha
	lis 11,ctf@ha
	la 9,.LC378@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L1620
	lwz 9,84(31)
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1620
	lis 4,.LC377@ha
	mr 3,30
	la 4,.LC377@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L1621
.L1620:
	li 3,0
.L1621:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 niq_blocked_intermission_cmd,.Lfe47-niq_blocked_intermission_cmd
	.section	".rodata"
	.align 2
.LC379:
	.string	"invnext"
	.align 2
.LC380:
	.string	"invprev"
	.align 2
.LC381:
	.string	"hook"
	.align 2
.LC382:
	.string	"Tractor beam is disabled\n"
	.align 2
.LC383:
	.string	"unhook"
	.align 2
.LC384:
	.string	"give"
	.align 2
.LC385:
	.string	"id"
	.align 2
.LC386:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_clientcommand
	.type	 niq_clientcommand,@function
niq_clientcommand:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 4,2,.L1656
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1631
	lis 4,.LC379@ha
	mr 3,30
	la 4,.LC379@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1625
	lwz 0,184(31)
	andi. 9,0,1
	bc 12,2,.L1626
	lwz 11,84(31)
	lwz 9,3536(11)
	addi 9,9,1
	cmpwi 0,9,9
	b .L1657
.L1626:
	lwz 11,84(31)
	lwz 9,3536(11)
	addi 9,9,1
	cmpwi 0,9,8
.L1657:
	stw 9,3536(11)
	bc 4,1,.L1628
	lwz 9,84(31)
	li 0,1
	stw 0,3536(9)
.L1628:
	mr 3,31
	bl niq_updatescreen
	b .L1656
.L1625:
	lwz 9,84(31)
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1631
	lis 4,.LC380@ha
	mr 3,30
	la 4,.LC380@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1631
	lwz 11,84(31)
	lwz 9,3536(11)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,3536(11)
	bc 12,1,.L1632
	lwz 0,184(31)
	andi. 9,0,1
	bc 12,2,.L1633
	lwz 9,84(31)
	li 0,9
	b .L1658
.L1633:
	lwz 9,84(31)
	li 0,8
.L1658:
	stw 0,3536(9)
.L1632:
	mr 3,31
	bl niq_updatescreen
	b .L1656
.L1631:
	mr 3,31
	mr 4,30
	bl niq_blocked_intermission_cmd
	cmpwi 0,3,0
	bc 4,2,.L1656
	lwz 0,184(31)
	li 3,0
	andi. 9,0,1
	bc 4,2,.L1655
	mr 3,31
	mr 4,30
	bl niq_command
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L1655
	lis 4,.LC381@ha
	mr 3,30
	la 4,.LC381@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1639
	lis 9,.LC386@ha
	lis 11,niq_tractor@ha
	la 9,.LC386@l(9)
	lfs 13,0(9)
	lwz 9,niq_tractor@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L1640
	mr 3,31
	bl hook_fire
	b .L1656
.L1640:
	lis 9,gi+8@ha
	lis 5,.LC382@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC382@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1656
.L1639:
	lis 4,.LC383@ha
	mr 3,30
	la 4,.LC383@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1642
	lis 9,.LC386@ha
	lis 11,niq_tractor@ha
	la 9,.LC386@l(9)
	lfs 13,0(9)
	lwz 9,niq_tractor@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L1656
	lwz 9,84(31)
	lwz 3,3956(9)
	cmpwi 0,3,0
	bc 12,2,.L1656
	bl hook_reset
	b .L1656
.L1642:
	lis 11,.LC386@ha
	lis 9,niq_enable@ha
	la 11,.LC386@l(11)
	li 3,0
	lfs 13,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1655
	mr 3,31
	mr 4,30
	bl niq_toggle_cmd
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L1655
	mr 3,31
	mr 4,30
	bl niq_commandisblocked
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L1655
	lis 4,.LC377@ha
	mr 3,30
	la 4,.LC377@l(4)
	bl Q_stricmp
	mr. 0,3
	bc 4,2,.L1647
	lwz 9,84(31)
	mr 3,31
	stw 0,3536(9)
	bl Cmd_Inven_f
	mr 3,31
	bl NIQEndObserverMode
	b .L1656
.L1647:
	lis 4,.LC376@ha
	mr 3,30
	la 4,.LC376@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L1648
	lwz 9,84(31)
	stw 10,3536(9)
	lwz 0,184(31)
	andi. 9,0,1
	bc 4,2,.L1649
	mr 3,31
	bl Cmd_PutAway_f
	b .L1656
.L1649:
	lwz 9,84(31)
	mr 3,31
	stw 10,3568(9)
	lwz 11,84(31)
	stw 10,3584(11)
	lwz 9,84(31)
	stw 10,3580(9)
	bl NIQEndObserverMode
	b .L1656
.L1648:
	lis 4,.LC373@ha
	mr 3,30
	la 4,.LC373@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1652
	mr 3,31
	bl niq_cmd_use_f
	b .L1656
.L1652:
	lis 4,.LC384@ha
	mr 3,30
	la 4,.LC384@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L1653
	mr 3,31
	bl niq_cmd_give_f
	b .L1656
.L1653:
	lis 4,.LC385@ha
	mr 3,30
	la 4,.LC385@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	li 3,0
	bc 4,2,.L1655
	mr 3,31
	bl CTFID_f
.L1656:
	li 3,1
.L1655:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe48:
	.size	 niq_clientcommand,.Lfe48-niq_clientcommand
	.section	".rodata"
	.align 2
.LC387:
	.string	"%s %s %s%s (%d)\n"
	.align 2
.LC388:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_kill
	.type	 niq_kill,@function
niq_kill:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,4
	mr 8,7
	mr 30,3
	lwz 7,84(31)
	mr 29,5
	lwz 11,84(30)
	lis 4,.LC387@ha
	li 3,1
	lwz 9,480(31)
	la 4,.LC387@l(4)
	addi 7,7,700
	addi 5,11,700
	crxor 6,6,6
	bl my_bprintf
	lis 9,.LC388@ha
	lis 11,deathmatch@ha
	la 9,.LC388@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L1665
	cmpwi 0,29,0
	bc 12,2,.L1667
	lis 9,niq_killpts@ha
	lwz 11,84(31)
	lwz 10,niq_killpts@l(9)
	lfs 0,3512(11)
	lfs 13,20(10)
	fsubs 0,0,13
	stfs 0,3512(11)
	lwz 9,84(31)
	lwz 9,3880(9)
	cmpwi 0,9,0
	bc 12,2,.L1668
	lfs 13,20(10)
	lfs 0,144(9)
	fsubs 0,0,13
	stfs 0,144(9)
.L1668:
	lwz 11,84(31)
	lwz 9,3516(11)
	addi 9,9,-1
	stw 9,3516(11)
	b .L1665
.L1667:
	lis 9,niq_killpts@ha
	lwz 10,84(31)
	lis 7,niq_kildpts@ha
	lwz 8,niq_killpts@l(9)
	lfs 0,3512(10)
	lfs 13,20(8)
	lwz 9,niq_kildpts@l(7)
	fadds 0,0,13
	stfs 0,3512(10)
	lwz 11,84(30)
	lfs 13,20(9)
	lfs 0,3512(11)
	fsubs 0,0,13
	stfs 0,3512(11)
	lwz 9,84(31)
	lwz 9,3880(9)
	cmpwi 0,9,0
	bc 12,2,.L1670
	lfs 13,20(8)
	lfs 0,144(9)
	fadds 0,0,13
	stfs 0,144(9)
.L1670:
	lwz 9,84(30)
	lwz 11,3880(9)
	cmpwi 0,11,0
	bc 12,2,.L1671
	lwz 9,niq_kildpts@l(7)
	lfs 0,144(11)
	lfs 13,20(9)
	fsubs 0,0,13
	stfs 0,144(11)
.L1671:
	mr 3,31
	bl niq_clientkill
	lwz 11,84(31)
	lwz 9,3516(11)
	addi 9,9,1
	stw 9,3516(11)
	lwz 10,84(30)
	lwz 9,3520(10)
	addi 9,9,1
	stw 9,3520(10)
.L1665:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 niq_kill,.Lfe49-niq_kill
	.section	".rodata"
	.align 2
.LC389:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_setcurrentweapon
	.type	 niq_setcurrentweapon,@function
niq_setcurrentweapon:
	mr. 3,3
	bclr 12,2
	lis 9,game+1564@ha
	lis 11,niqlist@ha
	lwz 0,game+1564@l(9)
	la 6,niqlist@l(11)
	cmpwi 0,4,0
	addi 9,6,28
	addi 11,6,24
	mulli 8,0,36
	addi 7,3,740
	lwzx 4,9,8
	lwzx 5,11,8
	bc 12,2,.L1682
	lis 11,.LC389@ha
	lis 9,deathmatch@ha
	la 11,.LC389@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L1683
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L1682
.L1683:
	addi 9,6,8
	addi 11,6,20
	lwzx 10,9,8
	slwi 6,4,2
	addi 7,3,740
	cmpwi 0,10,0
	bc 12,2,.L1686
	lwzx 9,11,8
	lwzx 0,7,6
	cmpw 0,0,9
	bc 12,1,.L1682
.L1686:
	lwzx 9,11,8
	cmpw 7,10,9
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,10,0
	or 10,0,9
	stwx 10,7,6
.L1682:
	mulli 0,5,72
	lis 9,itemlist@ha
	slwi 10,5,2
	la 9,itemlist@l(9)
	li 11,1
	cmpwi 0,4,999
	stwx 11,7,10
	add 0,0,9
	stw 0,1788(3)
	stw 5,736(3)
	stw 0,3612(3)
	bc 4,2,.L1688
	li 0,0
	stw 0,3592(3)
	blr
.L1688:
	stw 4,3592(3)
	blr
.Lfe50:
	.size	 niq_setcurrentweapon,.Lfe50-niq_setcurrentweapon
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.comm	niq_enable,4,4
	.comm	niq_ebots,4,4
	.comm	niq_allmaps,4,4
	.comm	niq_sbhp,4,4
	.comm	niq_hlthmax,4,4
	.comm	niq_inttime,4,4
	.comm	niq_playerid,4,4
	.comm	niq_blk1,4,4
	.comm	niq_blk2,4,4
	.comm	niq_tractor,4,4
	.comm	niq_hooksky,4,4
	.comm	niq_logfile,4,4
	.align 2
	.globl niq_removeallweapons
	.type	 niq_removeallweapons,@function
niq_removeallweapons:
	li 0,10
	lis 9,niqlist@ha
	mtctr 0
	la 9,niqlist@l(9)
	li 6,0
	addi 8,9,64
.L1698:
	lwz 9,84(3)
	li 7,0
	lwz 0,-4(8)
	addi 9,9,740
	slwi 0,0,2
	stwx 6,9,0
	lwz 10,84(3)
	cmpwi 0,10,0
	bc 12,2,.L468
	lwz 11,-8(8)
	addi 10,10,740
	lwz 9,0(8)
	cmpw 7,7,11
	slwi 9,9,2
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	and 11,11,0
	stwx 11,10,9
.L468:
	addi 8,8,36
	bdnz .L1698
	lwz 9,84(3)
	li 0,0
	stw 0,3592(9)
	blr
.Lfe51:
	.size	 niq_removeallweapons,.Lfe51-niq_removeallweapons
	.section	".rodata"
	.align 2
.LC390:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_drop_item
	.type	 niq_drop_item,@function
niq_drop_item:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr. 31,4
	mr 30,3
	bc 12,2,.L644
	lis 9,.LC390@ha
	lis 11,deathmatch@ha
	la 9,.LC390@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L644
	lwz 3,0(31)
	lis 4,.LC127@ha
	li 5,4
	la 4,.LC127@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L1699
	lwz 3,0(31)
	lis 4,.LC128@ha
	li 5,13
	la 4,.LC128@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L649
.L1699:
	mr 3,30
	mr 4,31
	bl Drop_Item
	b .L644
.L649:
	lwz 3,0(31)
	lis 4,.LC129@ha
	li 5,11
	la 4,.LC129@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L644
	mr 3,30
	mr 4,31
	bl Drop_Item
.L644:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe52:
	.size	 niq_drop_item,.Lfe52-niq_drop_item
	.align 2
	.globl niq_strncmp
	.type	 niq_strncmp,@function
niq_strncmp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,4
	mr 28,3
	mr 3,29
	bl strlen
	mr 5,3
	mr 4,29
	mr 3,28
	bl strncmp
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 niq_strncmp,.Lfe53-niq_strncmp
	.align 2
	.globl niq_has_enough_ammo
	.type	 niq_has_enough_ammo,@function
niq_has_enough_ammo:
	lwz 10,84(3)
	cmpwi 0,10,0
	bc 4,2,.L101
	li 3,0
	blr
.L101:
	lis 11,game+1564@ha
	lis 9,niqlist@ha
	lwz 8,game+1564@l(11)
	la 9,niqlist@l(9)
	addi 10,10,740
	addi 9,9,28
	mulli 11,8,36
	cmpwi 0,8,1
	lwzx 0,9,11
	slwi 0,0,2
	lwzx 10,10,0
	bc 4,2,.L102
	li 3,1
	blr
.L102:
	cmpwi 0,8,3
	bc 4,2,.L103
	cmpwi 7,10,1
	mfcr 3
	rlwinm 3,3,30,1
	blr
.L103:
	cmpwi 0,8,10
	bc 12,2,.L104
	srawi 3,10,31
	subf 3,10,3
	srwi 3,3,31
	blr
.L104:
	cmpwi 7,10,49
	mfcr 3
	rlwinm 3,3,30,1
	blr
.Lfe54:
	.size	 niq_has_enough_ammo,.Lfe54-niq_has_enough_ammo
	.align 2
	.globl niq_getnumclients
	.type	 niq_getnumclients,@function
niq_getnumclients:
	lis 9,game+1544@ha
	li 3,0
	lwz 0,game+1544@l(9)
	cmpwi 0,0,0
	bclr 4,1
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 11,9,1332
.L569:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L568
	lwz 0,84(11)
	addi 9,3,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
.L568:
	addi 11,11,1332
	bdnz .L569
	blr
.Lfe55:
	.size	 niq_getnumclients,.Lfe55-niq_getnumclients
	.section	".rodata"
	.align 2
.LC391:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_initdefaults
	.type	 niq_initdefaults,@function
niq_initdefaults:
	lis 11,.LC391@ha
	lwz 10,84(3)
	li 9,0
	la 11,.LC391@l(11)
	lis 0,0x3f80
	lfs 13,0(11)
	stw 0,1804(10)
	li 11,7
	stw 9,3532(10)
	stfs 13,3528(10)
	lwz 0,968(3)
	stw 9,1812(10)
	cmpwi 0,0,0
	stw 11,1808(10)
	stw 0,1820(10)
	bclr 4,2
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,ctf@ha
	stw 0,1808(10)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L696
	li 9,4
	li 0,8
	stw 0,1808(10)
	stw 9,1812(10)
	blr
.L696:
	lis 9,niq_handicap@ha
	li 0,2
	lwz 11,niq_handicap@l(9)
	stw 0,1812(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bclr 12,2
	li 0,3
	stw 0,1808(10)
	blr
.Lfe56:
	.size	 niq_initdefaults,.Lfe56-niq_initdefaults
	.section	".rodata"
	.align 2
.LC392:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl niq_settimers
	.type	 niq_settimers,@function
niq_settimers:
	mr. 3,3
	bclr 12,2
	lis 11,.LC392@ha
	lis 9,level+4@ha
	la 11,.LC392@l(11)
	lfs 0,level+4@l(9)
	li 0,0
	lfs 13,0(11)
	stw 0,3952(3)
	fadds 0,0,13
	stfs 0,3948(3)
	blr
.Lfe57:
	.size	 niq_settimers,.Lfe57-niq_settimers
	.section	".rodata"
	.align 2
.LC393:
	.long 0x0
	.align 3
.LC394:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC395:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC396:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_adjustdamage
	.type	 niq_adjustdamage,@function
niq_adjustdamage:
	stwu 1,-16(1)
	lis 11,.LC393@ha
	lis 9,niq_handicap@ha
	la 11,.LC393@l(11)
	lfs 13,0(11)
	lwz 11,niq_handicap@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L851
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L854
	lwz 0,184(3)
	andi. 9,0,4
	bc 12,2,.L851
.L854:
	xor 0,3,4
	lwz 10,84(4)
	addic 9,0,-1
	subfe 11,9,0
	addic 0,10,-1
	subfe 9,0,10
	and. 0,9,11
	bc 12,2,.L851
	lfs 10,1804(10)
	lis 9,.LC394@ha
	la 9,.LC394@l(9)
	lfd 13,0(9)
	fmr 0,10
	fcmpu 0,0,13
	bc 12,2,.L851
	lwz 0,0(5)
	lis 10,0x4330
	lis 9,.LC395@ha
	xoris 0,0,0x8000
	la 9,.LC395@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(9)
	lfd 0,8(1)
	lis 9,.LC396@ha
	la 9,.LC396@l(9)
	lfd 11,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fmuls 0,0,10
	fmr 13,0
	fadd 13,13,11
	fctiwz 12,13
	stfd 12,8(1)
	lwz 9,12(1)
	cmpwi 0,9,0
	stw 9,0(5)
	bc 12,1,.L851
	li 0,1
	stw 0,0(5)
.L851:
	la 1,16(1)
	blr
.Lfe58:
	.size	 niq_adjustdamage,.Lfe58-niq_adjustdamage
	.align 2
	.globl niq_putaway
	.type	 niq_putaway,@function
niq_putaway:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	li 8,0
	lwz 9,84(10)
	stw 8,3536(9)
	lwz 0,184(10)
	andi. 9,0,1
	bc 4,2,.L1610
	bl Cmd_PutAway_f
	b .L1611
.L1610:
	lwz 9,84(10)
	mr 3,10
	stw 8,3568(9)
	lwz 11,84(10)
	stw 8,3584(11)
	lwz 9,84(10)
	stw 8,3580(9)
	bl NIQEndObserverMode
.L1611:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe59:
	.size	 niq_putaway,.Lfe59-niq_putaway
	.section	".rodata"
	.align 2
.LC397:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_zapitem
	.type	 niq_zapitem,@function
niq_zapitem:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC397@ha
	lis 9,deathmatch@ha
	la 11,.LC397@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1660
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1661
	lis 29,.LC142@ha
	lwz 28,0(4)
	la 29,.LC142@l(29)
	mr 3,29
	bl strlen
	mr 5,3
	mr 4,29
	mr 3,28
	bl strncmp
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L1701
.L1661:
	mr 3,31
	bl G_FreeEdict
	li 3,1
	b .L1701
.L1660:
	li 3,0
.L1701:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe60:
	.size	 niq_zapitem,.Lfe60-niq_zapitem
	.align 2
	.globl niq_suicide
	.type	 niq_suicide,@function
niq_suicide:
	lis 9,niq_suicpts@ha
	lwz 11,84(3)
	lwz 8,niq_suicpts@l(9)
	lfs 0,3512(11)
	lfs 13,20(8)
	fsubs 0,0,13
	stfs 0,3512(11)
	lwz 10,84(3)
	lwz 9,3524(10)
	addi 9,9,1
	stw 9,3524(10)
	lwz 11,84(3)
	lwz 9,3880(11)
	cmpwi 0,9,0
	bclr 12,2
	lfs 13,20(8)
	lfs 0,144(9)
	fsubs 0,0,13
	stfs 0,144(9)
	blr
.Lfe61:
	.size	 niq_suicide,.Lfe61-niq_suicide
	.align 2
	.globl niq_die
	.type	 niq_die,@function
niq_die:
	lis 9,niq_kildpts@ha
	lwz 11,84(3)
	lwz 10,niq_kildpts@l(9)
	lfs 0,3512(11)
	lfs 13,20(10)
	fsubs 0,0,13
	stfs 0,3512(11)
	lwz 9,84(3)
	lwz 9,3880(9)
	cmpwi 0,9,0
	bclr 12,2
	lfs 13,20(10)
	lfs 0,144(9)
	fsubs 0,0,13
	stfs 0,144(9)
	blr
.Lfe62:
	.size	 niq_die,.Lfe62-niq_die
	.align 2
	.globl niq_showscoreboards
	.type	 niq_showscoreboards,@function
niq_showscoreboards:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 11,84(31)
	lwz 0,3568(11)
	cmpwi 0,0,0
	bc 12,2,.L1702
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,31
	bc 12,2,.L1676
	lwz 0,1808(11)
	cmpwi 0,0,6
	bc 4,2,.L1675
.L1676:
	lwz 0,3576(11)
	cmpwi 0,0,0
	bc 12,2,.L1677
	mr 3,31
	bl PMenu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,0
	mtlr 0
	blrl
	b .L1675
.L1677:
	lwz 4,540(31)
	mr 3,31
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L1675:
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 4,2,.L1679
.L1702:
	lwz 9,84(31)
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1679
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,31
	bc 4,2,.L1679
	mr 3,31
	bl niq_help
.L1679:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe63:
	.size	 niq_showscoreboards,.Lfe63-niq_showscoreboards
	.section	".rodata"
	.align 2
.LC398:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_InitClientPersistant
	.type	 niq_InitClientPersistant,@function
niq_InitClientPersistant:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	li 4,0
	addi 3,31,188
	li 5,1636
	crxor 6,6,6
	bl memset
	lis 9,.LC398@ha
	la 9,.LC398@l(9)
	lfs 13,0(9)
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L1692
	lis 9,grapple@ha
	lwz 11,grapple@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1691
.L1692:
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,31,740
	mullw 3,3,0
	li 9,1
	srawi 3,3,3
	slwi 3,3,2
	stwx 9,11,3
.L1691:
	lis 11,niq_hlthmax@ha
	lwz 8,niq_hlthmax@l(11)
	mr 10,9
	li 0,999
	li 11,1
	mr 3,31
	lfs 0,20(8)
	li 4,1
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,724(31)
	lfs 0,20(8)
	stw 0,1784(31)
	stw 0,1764(31)
	stw 0,1768(31)
	stw 0,1772(31)
	stw 0,1776(31)
	fctiwz 12,0
	stw 0,1780(31)
	stw 11,720(31)
	stfd 12,16(1)
	lwz 10,20(1)
	stw 10,728(31)
	bl niq_setcurrentweapon
	li 0,0
	stw 0,1820(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe64:
	.size	 niq_InitClientPersistant,.Lfe64-niq_InitClientPersistant
	.align 2
	.globl niq_handleclientinit
	.type	 niq_handleclientinit,@function
niq_handleclientinit:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 25,12(1)
	stw 0,52(1)
	mr 29,3
	lfs 31,1804(29)
	lwz 27,1812(29)
	lwz 26,1808(29)
	lwz 25,1816(29)
	lwz 28,1820(29)
	bl InitClientPersistant
	stw 28,1820(29)
	stfs 31,1804(29)
	stw 27,1812(29)
	stw 26,1808(29)
	stw 25,1816(29)
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe65:
	.size	 niq_handleclientinit,.Lfe65-niq_handleclientinit
	.section	".rodata"
	.align 2
.LC399:
	.long 0x0
	.section	".text"
	.align 2
	.globl NIQStartClient
	.type	 NIQStartClient,@function
NIQStartClient:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC399@ha
	lis 9,niq_blk2@ha
	la 11,.LC399@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,niq_blk2@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1695
	lwz 11,84(31)
	li 0,1
	stw 0,3536(11)
	lwz 9,84(31)
	stw 0,1816(9)
	bl niq_help
	li 3,0
	b .L1703
.L1695:
	lwz 9,84(31)
	lwz 10,1820(9)
	cmpwi 0,10,0
	bc 12,2,.L1696
	li 0,0
	li 11,1
	stw 0,3536(9)
	li 3,0
	lwz 9,84(31)
	stw 11,1816(9)
	b .L1703
.L1696:
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L1697
	lwz 0,184(31)
	li 29,1
	lis 11,gi+72@ha
	stw 10,248(31)
	mr 3,31
	ori 0,0,1
	stw 29,260(31)
	stw 0,184(31)
	stw 10,3464(9)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	mr 3,31
	stw 29,3536(9)
	bl niq_help
	li 3,1
	b .L1703
.L1697:
	li 0,1
	li 3,0
	stw 0,1816(9)
.L1703:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 NIQStartClient,.Lfe66-NIQStartClient
	.comm	view_weapon_models,4096,1
	.lcomm	g_helpstr,1400,4
	.comm	niq_handicap,4,4
	.comm	niq_version,4,4
	.comm	niq_sblines,4,4
	.comm	niq_weapsecs,4,4
	.comm	niq_hlthinc,4,4
	.comm	niq_killpts,4,4
	.comm	niq_kildpts,4,4
	.comm	niq_suicpts,4,4
	.comm	niq_auto,4,4
	.comm	niq_weapkills,4,4
	.comm	niq_sbdebug,4,4
	.comm	niq_sbwide,4,4
	.comm	niq_sbmini,4,4
	.comm	niq_weaprand,4,4
	.comm	niq_weapall,4,4
	.comm	niq_sndhlth,4,4
	.comm	niq_sndwarn,4,4
	.comm	niq_sndswitch,4,4
	.comm	niq_msgswitch,4,4
	.align 2
	.globl niq_patchversionstring
	.type	 niq_patchversionstring,@function
niq_patchversionstring:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	bl strstr
	mr. 31,3
	bc 4,2,.L7
	lis 9,gi+4@ha
	lis 3,.LC30@ha
	lwz 0,gi+4@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L7:
	lis 4,.LC31@ha
	mr 3,31
	la 4,.LC31@l(4)
	li 5,4
	bl strncpy
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe67:
	.size	 niq_patchversionstring,.Lfe67-niq_patchversionstring
	.align 2
	.globl niq_showmessagetoallclients
	.type	 niq_showmessagetoallclients,@function
niq_showmessagetoallclients:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 25,20(1)
	stw 0,52(1)
	stw 12,16(1)
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	mr 30,3
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L21
	cmpwi 4,4,0
	lis 9,gi@ha
	la 27,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 28,.LC32@ha
	li 29,1332
.L23:
	lwz 0,g_edicts@l(26)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L22
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L22
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 4,2,.L22
	lwz 0,184(3)
	andi. 11,0,1
	bc 4,2,.L22
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 4,2,.L22
	bc 12,18,.L29
	lwz 9,8(27)
	li 4,2
	la 5,.LC32@l(28)
	mr 6,30
	mtlr 9
	crxor 6,6,6
	blrl
	b .L22
.L29:
	lwz 9,12(27)
	la 4,.LC32@l(28)
	mr 5,30
	mtlr 9
	crxor 6,6,6
	blrl
.L22:
	lwz 0,1544(25)
	addi 31,31,1
	addi 29,29,1332
	cmpw 0,31,0
	bc 4,1,.L23
.L21:
	lwz 0,52(1)
	lwz 12,16(1)
	mtlr 0
	lmw 25,20(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe68:
	.size	 niq_showmessagetoallclients,.Lfe68-niq_showmessagetoallclients
	.align 2
	.globl niq_setweapontime
	.type	 niq_setweapontime,@function
niq_setweapontime:
	lis 9,niq_weapsecs@ha
	lis 11,game+1576@ha
	lwz 10,niq_weapsecs@l(9)
	lis 8,niq_prevwsecs@ha
	stfs 1,game+1576@l(11)
	lfs 0,20(10)
	stfs 0,niq_prevwsecs@l(8)
	blr
.Lfe69:
	.size	 niq_setweapontime,.Lfe69-niq_setweapontime
	.align 2
	.globl niq_getcurrentweapon
	.type	 niq_getcurrentweapon,@function
niq_getcurrentweapon:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,game+1564@ha
	lis 9,niqlist@ha
	lwz 0,game+1564@l(11)
	la 9,niqlist@l(9)
	mulli 0,0,36
	lwzx 3,9,0
	bl FindItem
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe70:
	.size	 niq_getcurrentweapon,.Lfe70-niq_getcurrentweapon
	.align 2
	.globl niq_add_ammo
	.type	 niq_add_ammo,@function
niq_add_ammo:
	lis 9,niqlist@ha
	mulli 5,5,36
	addi 10,3,740
	la 9,niqlist@l(9)
	addi 11,9,28
	lwzx 0,11,5
	addi 9,9,20
	lwzx 9,9,5
	slwi 11,0,2
	lwzx 0,10,11
	cmpw 0,0,9
	bc 12,0,.L110
	li 3,1
	blr
.L110:
	add 4,4,0
	li 3,1
	cmpw 7,4,9
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,4,0
	or 4,0,9
	stwx 4,10,11
	blr
.Lfe71:
	.size	 niq_add_ammo,.Lfe71-niq_add_ammo
	.align 2
	.globl niq_trackdfactor
	.type	 niq_trackdfactor,@function
niq_trackdfactor:
	lfs 0,3528(3)
	lfs 13,1804(3)
	lwz 9,3532(3)
	fadds 0,0,13
	addi 9,9,1
	stw 9,3532(3)
	stfs 0,3528(3)
	blr
.Lfe72:
	.size	 niq_trackdfactor,.Lfe72-niq_trackdfactor
	.section	".rodata"
	.align 3
.LC400:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl niq_getaverageDF
	.type	 niq_getaverageDF,@function
niq_getaverageDF:
	stwu 1,-16(1)
	lwz 11,3532(3)
	cmpwi 0,11,0
	bc 4,2,.L220
	lfs 1,1804(3)
	b .L1705
.L220:
	xoris 11,11,0x8000
	lfs 13,3528(3)
	stw 11,12(1)
	lis 0,0x4330
	lis 11,.LC400@ha
	stw 0,8(1)
	la 11,.LC400@l(11)
	lfd 1,8(1)
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	fdivs 1,13,1
.L1705:
	la 1,16(1)
	blr
.Lfe73:
	.size	 niq_getaverageDF,.Lfe73-niq_getaverageDF
	.section	".rodata"
	.align 3
.LC401:
	.long 0x40ac2000
	.long 0x0
	.align 3
.LC402:
	.long 0x408f3800
	.long 0x0
	.align 3
.LC403:
	.long 0xc058c000
	.long 0x0
	.align 3
.LC404:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC405:
	.long 0x40240000
	.long 0x0
	.align 3
.LC406:
	.long 0x0
	.long 0x0
	.align 3
.LC407:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_getPPH
	.type	 niq_getPPH,@function
niq_getPPH:
	stwu 1,-16(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	lis 8,.LC404@ha
	lwz 9,3460(3)
	la 8,.LC404@l(8)
	lfd 13,0(8)
	subf 0,9,0
	lis 8,.LC405@ha
	xoris 0,0,0x8000
	la 8,.LC405@l(8)
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	lfd 12,0(8)
	lis 8,.LC406@ha
	fsub 0,0,13
	la 8,.LC406@l(8)
	lfd 11,0(8)
	fdiv 0,0,12
	frsp 0,0
	fmr 12,0
	fcmpu 0,12,11
	bc 4,1,.L223
	lfs 0,3512(3)
	lis 9,.LC401@ha
	lfd 13,.LC401@l(9)
	fmul 0,0,13
	fdiv 0,0,12
	frsp 0,0
	b .L224
.L223:
	lfs 0,3512(3)
.L224:
	fmr 12,0
	lis 9,.LC402@ha
	lfd 0,.LC402@l(9)
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L225
	li 3,999
	b .L1706
.L225:
	lis 9,.LC403@ha
	lfd 0,.LC403@l(9)
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L226
	li 3,-99
	b .L1706
.L226:
	lis 9,.LC406@ha
	la 9,.LC406@l(9)
	lfd 0,0(9)
	fcmpu 0,12,0
	cror 3,2,1
	bc 12,3,.L227
	lis 8,.LC407@ha
	la 8,.LC407@l(8)
	lfd 0,0(8)
	fsub 0,12,0
	b .L1707
.L227:
	lis 9,.LC407@ha
	la 9,.LC407@l(9)
	lfd 0,0(9)
	fadd 0,12,0
.L1707:
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
.L1706:
	la 1,16(1)
	blr
.Lfe74:
	.size	 niq_getPPH,.Lfe74-niq_getPPH
	.section	".rodata"
	.align 3
.LC408:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_cleardfforallclients
	.type	 niq_cleardfforallclients,@function
niq_cleardfforallclients:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L432
	mr 27,9
	lis 28,g_edicts@ha
	lis 9,.LC408@ha
	lis 29,0x3f80
	la 9,.LC408@l(9)
	li 30,1332
	lfd 31,0(9)
.L434:
	lwz 0,g_edicts@l(28)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L433
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L433
	lfs 0,1804(9)
	fcmpu 0,0,31
	bc 12,2,.L433
	stw 29,1804(9)
	lwz 9,84(3)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L433
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L433:
	lwz 0,1544(27)
	addi 31,31,1
	addi 30,30,1332
	cmpw 0,31,0
	bc 4,1,.L434
.L432:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe75:
	.size	 niq_cleardfforallclients,.Lfe75-niq_cleardfforallclients
	.align 2
	.globl niq_getclientrank
	.type	 niq_getclientrank,@function
niq_getclientrank:
	li 3,-1
	blr
.Lfe76:
	.size	 niq_getclientrank,.Lfe76-niq_getclientrank
	.align 2
	.globl niq_loadmotdfile
	.type	 niq_loadmotdfile,@function
niq_loadmotdfile:
	stwu 1,-288(1)
	mflr 0
	stmw 26,264(1)
	stw 0,292(1)
	lis 3,.LC115@ha
	li 4,1
	la 3,.LC115@l(3)
	li 29,0
	bl niq_fopen
	mr. 30,3
	bc 12,2,.L581
	lis 9,gi@ha
	lis 11,motdlines@ha
	la 26,gi@l(9)
	la 31,motdlines@l(11)
	lis 27,.LC116@ha
	li 28,0
	b .L582
.L585:
	addi 3,1,8
	bl strlen
	addi 3,3,-1
	addi 4,1,8
	lbzx 0,4,3
	cmpwi 0,0,10
	bc 4,2,.L586
	stbx 28,4,3
.L586:
	mr 3,31
	stb 28,48(1)
	addi 29,29,1
	bl strcpy
	addi 31,31,41
.L582:
	addi 3,1,8
	li 4,80
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L583
	cmpwi 0,29,3
	bc 4,1,.L585
	lwz 0,4(26)
	la 3,.LC116@l(27)
	li 4,4
	mtlr 0
	crxor 6,6,6
	blrl
.L583:
	mr 3,30
	bl fclose
.L581:
	lwz 0,292(1)
	mtlr 0
	lmw 26,264(1)
	la 1,288(1)
	blr
.Lfe77:
	.size	 niq_loadmotdfile,.Lfe77-niq_loadmotdfile
	.align 2
	.globl niq_getcurrentweaponindex
	.type	 niq_getcurrentweaponindex,@function
niq_getcurrentweaponindex:
	lis 9,game+1564@ha
	lis 11,niqlist@ha
	lwz 0,game+1564@l(9)
	la 11,niqlist@l(11)
	addi 11,11,24
	mulli 0,0,36
	lwzx 3,11,0
	blr
.Lfe78:
	.size	 niq_getcurrentweaponindex,.Lfe78-niq_getcurrentweaponindex
	.section	".rodata"
	.align 2
.LC409:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_showhudtext
	.type	 niq_showhudtext,@function
niq_showhudtext:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC409@ha
	lis 9,deathmatch@ha
	la 11,.LC409@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L766
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 4,2,.L766
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,szHUDLabelStr@ha
	la 3,szHUDLabelStr@l(3)
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,0
	mtlr 0
	blrl
.L766:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe79:
	.size	 niq_showhudtext,.Lfe79-niq_showhudtext
	.section	".rodata"
	.align 3
.LC410:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC411:
	.long 0x3fb9db22
	.long 0xd0e56042
	.align 2
.LC412:
	.long 0x3dcccccd
	.align 2
.LC413:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_decrease_damage
	.type	 niq_decrease_damage,@function
niq_decrease_damage:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	bc 12,2,.L866
	lis 9,.LC413@ha
	lis 11,niq_handicap@ha
	la 9,.LC413@l(9)
	lfs 13,0(9)
	lwz 9,niq_handicap@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L868
	lis 9,gi+8@ha
	lis 5,.LC222@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC222@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L866
.L868:
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L866
	lfs 0,1804(10)
	lis 9,.LC410@ha
	lis 11,.LC411@ha
	lfd 13,.LC410@l(9)
	lfd 12,.LC411@l(11)
	fsub 0,0,13
	frsp 0,0
	stfs 0,1804(10)
	lwz 11,84(31)
	lfs 0,1804(11)
	fcmpu 0,0,12
	bc 4,0,.L870
	lis 9,.LC412@ha
	lfs 0,.LC412@l(9)
	stfs 0,1804(11)
.L870:
	lwz 11,84(31)
	lis 9,gi+8@ha
	lis 5,.LC227@ha
	lwz 0,gi+8@l(9)
	la 5,.LC227@l(5)
	mr 3,31
	lfs 1,1804(11)
	li 4,2
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L866
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L866:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe80:
	.size	 niq_decrease_damage,.Lfe80-niq_decrease_damage
	.section	".rodata"
	.align 2
.LC414:
	.long 0x3dcccccd
	.align 2
.LC415:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_min_damage
	.type	 niq_min_damage,@function
niq_min_damage:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	bc 12,2,.L880
	lis 9,.LC415@ha
	lis 11,niq_handicap@ha
	la 9,.LC415@l(9)
	lfs 13,0(9)
	lwz 9,niq_handicap@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L882
	lis 9,gi+8@ha
	lis 5,.LC222@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC222@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L880
.L882:
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L880
	lis 9,.LC414@ha
	lis 11,gi+8@ha
	lfs 0,.LC414@l(9)
	lis 5,.LC227@ha
	mr 3,31
	la 5,.LC227@l(5)
	li 4,2
	stfs 0,1804(10)
	lwz 9,84(31)
	lwz 0,gi+8@l(11)
	lfs 1,1804(9)
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L880
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L880:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe81:
	.size	 niq_min_damage,.Lfe81-niq_min_damage
	.section	".rodata"
	.align 2
.LC416:
	.long 0x0
	.section	".text"
	.align 2
	.globl niq_reset_damage
	.type	 niq_reset_damage,@function
niq_reset_damage:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	bc 12,2,.L885
	lis 9,.LC416@ha
	lis 11,niq_handicap@ha
	la 9,.LC416@l(9)
	lfs 13,0(9)
	lwz 9,niq_handicap@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L887
	lis 9,gi+8@ha
	lis 5,.LC222@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC222@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L885
.L887:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L885
	lis 0,0x3f80
	lis 11,gi+8@ha
	stw 0,1804(9)
	lis 5,.LC227@ha
	mr 3,31
	lwz 9,84(31)
	la 5,.LC227@l(5)
	li 4,2
	lwz 0,gi+8@l(11)
	lfs 1,1804(9)
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L885
	mr 3,31
	li 4,0
	li 5,0
	bl niq_deathmatchscoreboardmessage
.L885:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe82:
	.size	 niq_reset_damage,.Lfe82-niq_reset_damage
	.align 2
	.globl niq_show_damage
	.type	 niq_show_damage,@function
niq_show_damage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 3,3
	bc 12,2,.L890
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L890
	lfs 1,1804(9)
	lis 5,.LC235@ha
	li 4,2
	lis 9,gi+8@ha
	la 5,.LC235@l(5)
	lwz 0,gi+8@l(9)
	mtlr 0
	creqv 6,6,6
	blrl
.L890:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe83:
	.size	 niq_show_damage,.Lfe83-niq_show_damage
	.align 2
	.globl niq_showinfo
	.type	 niq_showinfo,@function
niq_showinfo:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	cmpwi 0,6,0
	mr 29,3
	mr 0,4
	bc 4,2,.L916
	lis 4,.LC244@ha
	lis 6,.LC245@ha
	la 4,.LC244@l(4)
	mr 5,0
	la 6,.LC245@l(6)
	b .L1708
.L916:
	cmpwi 0,5,0
	bc 12,2,.L918
	lis 4,.LC244@ha
	lis 6,.LC246@ha
	la 4,.LC244@l(4)
	mr 5,0
	la 6,.LC246@l(6)
.L1708:
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L917
.L918:
	lis 4,.LC244@ha
	lis 6,.LC247@ha
	la 4,.LC244@l(4)
	mr 5,0
	la 6,.LC247@l(6)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
.L917:
	addi 30,1,8
	mr 3,30
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L920
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,30
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(29)
	addi 9,31,23
	add 0,0,9
	stw 0,0(29)
	b .L921
.L920:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(29)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,30
	stb 0,40(30)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 9,0(29)
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	la 3,.LC237@l(3)
	addi 9,9,63
	stw 9,0(29)
	lwz 0,gi+4@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L921:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe84:
	.size	 niq_showinfo,.Lfe84-niq_showinfo
	.align 2
	.globl niq_showinfoint
	.type	 niq_showinfoint,@function
niq_showinfoint:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	mr 0,4
	mr 6,5
	mr 30,3
	lis 4,.LC248@ha
	la 4,.LC248@l(4)
	mr 5,0
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	addi 29,1,8
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L924
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,31,23
	add 0,0,9
	stw 0,0(30)
	b .L925
.L924:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,29
	stb 0,40(29)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 9,0(30)
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	la 3,.LC237@l(3)
	addi 9,9,63
	stw 9,0(30)
	lwz 0,gi+4@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L925:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe85:
	.size	 niq_showinfoint,.Lfe85-niq_showinfoint
	.align 2
	.globl niq_showinfoflt
	.type	 niq_showinfoflt,@function
niq_showinfoflt:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	mr 5,4
	mr 30,3
	lis 4,.LC249@ha
	addi 3,1,8
	la 4,.LC249@l(4)
	creqv 6,6,6
	bl sprintf
	addi 29,1,8
	mr 3,29
	bl strlen
	mr 31,3
	cmpwi 0,31,40
	bc 12,1,.L928
	lis 9,g_nSBLineNum@ha
	subfic 5,31,40
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	slwi 5,5,2
	la 4,.LC236@l(4)
	mr 7,29
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 0,0(30)
	addi 9,31,23
	add 0,0,9
	stw 0,0(30)
	b .L929
.L928:
	lis 9,g_nSBLineNum@ha
	li 0,0
	lwz 3,0(30)
	lwz 6,g_nSBLineNum@l(9)
	lis 4,.LC236@ha
	mr 7,29
	stb 0,40(29)
	la 4,.LC236@l(4)
	li 5,0
	mulli 6,6,10
	crxor 6,6,6
	bl sprintf
	lwz 9,0(30)
	lis 11,gi+4@ha
	lis 3,.LC237@ha
	la 3,.LC237@l(3)
	addi 9,9,63
	stw 9,0(30)
	lwz 0,gi+4@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L929:
	lis 11,g_nSBLineNum@ha
	lwz 9,g_nSBLineNum@l(11)
	addi 9,9,1
	stw 9,g_nSBLineNum@l(11)
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe86:
	.size	 niq_showinfoflt,.Lfe86-niq_showinfoflt
	.align 2
	.globl niq_SelectNextMenu
	.type	 niq_SelectNextMenu,@function
niq_SelectNextMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,184(3)
	andi. 9,0,1
	bc 12,2,.L1601
	lwz 11,84(3)
	lwz 9,3536(11)
	addi 9,9,1
	cmpwi 0,9,9
	b .L1709
.L1601:
	lwz 11,84(3)
	lwz 9,3536(11)
	addi 9,9,1
	cmpwi 0,9,8
.L1709:
	stw 9,3536(11)
	bc 4,1,.L1603
	lwz 9,84(3)
	li 0,1
	stw 0,3536(9)
.L1603:
	bl niq_updatescreen
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe87:
	.size	 niq_SelectNextMenu,.Lfe87-niq_SelectNextMenu
	.align 2
	.globl niq_SelectPrevMenu
	.type	 niq_SelectPrevMenu,@function
niq_SelectPrevMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lwz 9,3536(11)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,3536(11)
	bc 12,1,.L1606
	lwz 0,184(3)
	andi. 9,0,1
	bc 12,2,.L1607
	lwz 9,84(3)
	li 0,9
	b .L1710
.L1607:
	lwz 9,84(3)
	li 0,8
.L1710:
	stw 0,3536(9)
.L1606:
	bl niq_updatescreen
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe88:
	.size	 niq_SelectPrevMenu,.Lfe88-niq_SelectPrevMenu
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
