	.file	"p_client.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s has %d kills in a row and receives %d frags for the kill!\n"
	.align 2
.LC1:
	.string	"Kill count: %d\n"
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl Add_Frag
	.type	 Add_Frag,@function
Add_Frag:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,.LC2@ha
	lwz 10,84(31)
	la 9,.LC2@l(9)
	lis 11,teamplay@ha
	lfs 13,0(9)
	lwz 9,3468(10)
	lwz 8,teamplay@l(11)
	addi 9,9,1
	stw 9,3468(10)
	lwz 11,84(31)
	lwz 9,3476(11)
	addi 9,9,1
	stw 9,3476(11)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 4,2,.L8
	lwz 5,84(31)
	lwz 6,3476(5)
	cmpwi 0,6,3
	bc 12,1,.L7
.L8:
	lwz 11,84(31)
	lwz 9,3440(11)
	addi 9,9,1
	b .L17
.L7:
	cmpwi 0,6,7
	bc 12,1,.L10
	lis 4,.LC0@ha
	addi 5,5,700
	la 4,.LC0@l(4)
	li 3,1
	li 7,2
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(31)
	lwz 9,3440(11)
	addi 9,9,2
	b .L17
.L10:
	cmpwi 0,6,15
	bc 12,1,.L12
	lis 4,.LC0@ha
	addi 5,5,700
	la 4,.LC0@l(4)
	li 3,1
	li 7,4
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(31)
	lwz 9,3440(11)
	addi 9,9,4
	b .L17
.L12:
	cmpwi 0,6,31
	bc 12,1,.L14
	lis 4,.LC0@ha
	addi 5,5,700
	la 4,.LC0@l(4)
	li 3,1
	li 7,8
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(31)
	lwz 9,3440(11)
	addi 9,9,8
	b .L17
.L14:
	lis 4,.LC0@ha
	addi 5,5,700
	la 4,.LC0@l(4)
	li 3,1
	li 7,16
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(31)
	lwz 9,3440(11)
	addi 9,9,16
.L17:
	stw 9,3440(11)
	lis 9,.LC2@ha
	lis 11,teamplay@ha
	la 9,.LC2@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L16
	lwz 9,84(31)
	lwz 6,3476(9)
	cmpwi 0,6,0
	bc 4,1,.L16
	lis 5,.LC1@ha
	mr 3,31
	la 5,.LC1@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L16:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 Add_Frag,.Lfe1-Add_Frag
	.section	".rodata"
	.align 2
.LC3:
	.string	"You were hit by %s, your TEAMMATE!\n"
	.align 2
.LC4:
	.string	"You hit your TEAMMATE %s!\n"
	.align 2
.LC5:
	.string	"%s is in danger of being banned for wounding teammates\n"
	.align 2
.LC6:
	.string	"WARNING: You'll be temporarily banned if you continue wounding teammates!\n"
	.align 2
.LC7:
	.string	"Banning %s@%s for team wounding\n"
	.align 2
.LC8:
	.string	"You've wounded teammates too many times, and are banned for %d %s.\n"
	.align 2
.LC9:
	.string	"games"
	.align 2
.LC10:
	.string	"game"
	.align 2
.LC11:
	.string	"Error banning %s: unable to get ipaddr\n"
	.align 2
.LC12:
	.long 0x0
	.section	".text"
	.align 2
	.globl Add_TeamWound
	.type	 Add_TeamWound,@function
Add_TeamWound:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC12@ha
	lis 9,teamplay@ha
	la 11,.LC12@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L19
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L19
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L19
	lwz 9,4452(11)
	addi 9,9,1
	stw 9,4452(11)
	lwz 9,84(31)
	lwz 0,4460(9)
	cmpwi 0,0,0
	bc 4,2,.L22
	li 0,1
	lis 5,.LC3@ha
	stw 0,4460(9)
	la 5,.LC3@l(5)
	mr 3,30
	lwz 6,84(31)
	li 4,2
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
	lwz 6,84(30)
	lis 5,.LC4@ha
	mr 3,31
	la 5,.LC4@l(5)
	li 4,2
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
.L22:
	lwz 8,84(31)
	lis 11,maxteamkills@ha
	lwz 10,maxteamkills@l(11)
	lwz 9,4456(8)
	addi 9,9,1
	stw 9,4452(8)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,0
	bc 4,1,.L19
	lwz 6,84(31)
	slwi 0,9,1
	add 0,0,9
	lwz 11,4452(6)
	cmpw 0,11,0
	bc 12,0,.L19
	slwi 0,9,2
	cmpw 0,11,0
	bc 4,0,.L26
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,1
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
	lis 5,.LC6@ha
	mr 3,31
	la 5,.LC6@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L19
.L26:
	cmpwi 0,6,-4464
	bc 12,2,.L19
	lis 30,twbanrounds@ha
	lwz 9,twbanrounds@l(30)
	mr 3,31
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 4,20(1)
	bl Ban_TeamKiller
	cmpwi 0,3,0
	bc 12,2,.L29
	lwz 6,84(31)
	lis 5,.LC7@ha
	li 3,0
	la 5,.LC7@l(5)
	li 4,1
	addi 7,6,4464
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,twbanrounds@l(30)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 6,20(1)
	cmpwi 0,6,1
	bc 4,1,.L30
	lis 9,.LC9@ha
	la 7,.LC9@l(9)
	b .L31
.L30:
	lis 9,.LC10@ha
	la 7,.LC10@l(9)
.L31:
	lis 5,.LC8@ha
	mr 3,31
	la 5,.LC8@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L32
.L29:
	lwz 6,84(31)
	lis 5,.LC11@ha
	li 3,0
	la 5,.LC11@l(5)
	li 4,1
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
.L32:
	mr 3,31
	bl Kick_Client
.L19:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Add_TeamWound,.Lfe2-Add_TeamWound
	.section	".rodata"
	.align 2
.LC13:
	.string	"You killed your TEAMMATE!\n"
	.align 2
.LC14:
	.string	"%s is in danger of being banned for killing teammates\n"
	.align 2
.LC15:
	.string	"WARNING: You'll be temporarily banned if you continue killing teammates!\n"
	.align 2
.LC16:
	.string	"Banning %s@%s for team killing\n"
	.align 2
.LC17:
	.string	"You've killed too many teammates, and are banned for %d %s.\n"
	.align 2
.LC18:
	.long 0x0
	.section	".text"
	.align 2
	.globl Add_TeamKill
	.type	 Add_TeamKill,@function
Add_TeamKill:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC18@ha
	lis 9,teamplay@ha
	la 11,.LC18@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L33
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L33
	lwz 9,4448(11)
	addi 9,9,1
	stw 9,4448(11)
	lwz 9,84(31)
	lwz 11,4456(9)
	lwz 0,4452(9)
	cmpw 0,0,11
	bc 4,1,.L36
	stw 11,4452(9)
.L36:
	lis 11,maxteamkills@ha
	lwz 9,maxteamkills@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,0
	bc 4,1,.L38
	lwz 6,84(31)
	srwi 0,9,31
	add 0,9,0
	lwz 11,4448(6)
	srawi 0,0,1
	subf 0,0,9
	cmpw 0,11,0
	bc 4,0,.L37
.L38:
	lis 5,.LC13@ha
	mr 3,31
	la 5,.LC13@l(5)
	b .L47
.L37:
	cmpw 0,11,9
	bc 4,0,.L40
	lis 5,.LC14@ha
	li 3,0
	la 5,.LC14@l(5)
	li 4,1
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
	lis 5,.LC15@ha
	mr 3,31
	la 5,.LC15@l(5)
.L47:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L33
.L40:
	cmpwi 0,6,-4464
	bc 12,2,.L42
	lis 30,tkbanrounds@ha
	lwz 9,tkbanrounds@l(30)
	mr 3,31
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 4,20(1)
	bl Ban_TeamKiller
	cmpwi 0,3,0
	bc 12,2,.L43
	lwz 6,84(31)
	lis 5,.LC16@ha
	li 3,0
	la 5,.LC16@l(5)
	li 4,1
	addi 7,6,4464
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,tkbanrounds@l(30)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 6,20(1)
	cmpwi 0,6,1
	bc 4,1,.L44
	lis 9,.LC9@ha
	la 7,.LC9@l(9)
	b .L45
.L44:
	lis 9,.LC10@ha
	la 7,.LC10@l(9)
.L45:
	lis 5,.LC17@ha
	mr 3,31
	la 5,.LC17@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L42
.L43:
	lwz 6,84(31)
	lis 5,.LC11@ha
	li 3,0
	la 5,.LC11@l(5)
	li 4,1
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
.L42:
	mr 3,31
	bl Kick_Client
.L33:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Add_TeamKill,.Lfe3-Add_TeamKill
	.section	".rodata"
	.align 2
.LC19:
	.string	"info_player_start"
	.align 2
.LC20:
	.string	"security"
	.align 2
.LC21:
	.string	"info_player_coop"
	.align 2
.LC22:
	.string	"jail3"
	.align 2
.LC24:
	.string	"jail2"
	.align 2
.LC25:
	.string	"jail4"
	.align 2
.LC26:
	.string	"mine1"
	.align 2
.LC27:
	.string	"mine2"
	.align 2
.LC28:
	.string	"mine3"
	.align 2
.LC29:
	.string	"mine4"
	.align 2
.LC30:
	.string	"lab"
	.align 2
.LC31:
	.string	"boss1"
	.align 2
.LC32:
	.string	"fact3"
	.align 2
.LC33:
	.string	"biggun"
	.align 2
.LC34:
	.string	"space"
	.align 2
.LC35:
	.string	"command"
	.align 2
.LC36:
	.string	"power2"
	.align 2
.LC37:
	.string	"strike"
	.align 3
.LC38:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_coop
	.type	 SP_info_player_coop,@function
SP_info_player_coop:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC39@ha
	lis 9,coop@ha
	la 11,.LC39@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L66
	bl G_FreeEdict
	b .L65
.L66:
	lis 31,level+72@ha
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	la 3,level+72@l(31)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC25@ha
	la 3,level+72@l(31)
	la 4,.LC25@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC26@ha
	la 3,level+72@l(31)
	la 4,.LC26@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC27@ha
	la 3,level+72@l(31)
	la 4,.LC27@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC28@ha
	la 3,level+72@l(31)
	la 4,.LC28@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC29@ha
	la 3,level+72@l(31)
	la 4,.LC29@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC30@ha
	la 3,level+72@l(31)
	la 4,.LC30@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC31@ha
	la 3,level+72@l(31)
	la 4,.LC31@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC32@ha
	la 3,level+72@l(31)
	la 4,.LC32@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC33@ha
	la 3,level+72@l(31)
	la 4,.LC33@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC34@ha
	la 3,level+72@l(31)
	la 4,.LC34@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC35@ha
	la 3,level+72@l(31)
	la 4,.LC35@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC36@ha
	la 3,level+72@l(31)
	la 4,.LC36@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L68
	lis 4,.LC37@ha
	la 3,level+72@l(31)
	la 4,.LC37@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L65
.L68:
	lis 9,SP_FixCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_FixCoopSpots@l(9)
	lis 11,.LC38@ha
	stw 9,436(30)
	lfs 0,level+4@l(10)
	lfd 13,.LC38@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L65:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 SP_info_player_coop,.Lfe4-SP_info_player_coop
	.section	".rodata"
	.align 2
.LC40:
	.string	"gender"
	.align 2
.LC41:
	.string	"%s"
	.align 2
.LC42:
	.string	""
	.align 2
.LC43:
	.string	"ate too much glass"
	.align 2
.LC44:
	.string	"suicides"
	.align 2
.LC45:
	.string	"plummets to its death"
	.align 2
.LC46:
	.string	"plummets to her death"
	.align 2
.LC47:
	.string	"plummets to his death"
	.align 2
.LC48:
	.string	"was flattened"
	.align 2
.LC49:
	.string	"sank like a rock"
	.align 2
.LC50:
	.string	"melted"
	.align 2
.LC51:
	.string	"does a back flip into the lava"
	.align 2
.LC52:
	.string	"blew up"
	.align 2
.LC53:
	.string	"found a way out"
	.align 2
.LC54:
	.string	"saw the light"
	.align 2
.LC55:
	.string	"got blasted"
	.align 2
.LC56:
	.string	"was in the wrong place"
	.align 2
.LC57:
	.string	"tried to put the pin back in"
	.align 2
.LC58:
	.string	"didn't throw its grenade far enough"
	.align 2
.LC59:
	.string	"didn't throw her grenade far enough"
	.align 2
.LC60:
	.string	"didn't throw his grenade far enough"
	.align 2
.LC61:
	.string	"tripped on its own grenade"
	.align 2
.LC62:
	.string	"tripped on her own grenade"
	.align 2
.LC63:
	.string	"tripped on his own grenade"
	.align 2
.LC64:
	.string	"blew itself up"
	.align 2
.LC65:
	.string	"blew herself up"
	.align 2
.LC66:
	.string	"blew himself up"
	.align 2
.LC67:
	.string	"should have used a smaller gun"
	.align 2
.LC68:
	.string	"killed itself"
	.align 2
.LC69:
	.string	"killed herself"
	.align 2
.LC70:
	.string	"killed himself"
	.align 2
.LC71:
	.string	"%s %s\n"
	.align 2
.LC72:
	.string	"%s was taught how to fly by %s\n"
	.align 2
.LC73:
	.string	"%s plummets to its death\n"
	.align 2
.LC74:
	.string	"%s plummets to her death\n"
	.align 2
.LC75:
	.string	"%s plummets to his death\n"
	.align 2
.LC76:
	.string	" has a hole in its head from"
	.align 2
.LC77:
	.string	" has a hole in her head from"
	.align 2
.LC78:
	.string	" has a hole in his head from"
	.align 2
.LC79:
	.string	"'s Mark 23 pistol"
	.align 2
.LC80:
	.string	" loses a vital chest organ thanks to"
	.align 2
.LC81:
	.string	" loses its lunch to"
	.align 2
.LC82:
	.string	" loses her lunch to"
	.align 2
.LC83:
	.string	" loses his lunch to"
	.align 2
.LC84:
	.string	"'s .45 caliber pistol round"
	.align 2
.LC85:
	.string	" is legless because of"
	.align 2
.LC86:
	.string	" was shot by"
	.align 2
.LC87:
	.string	"'s Mark 23 Pistol"
	.align 2
.LC88:
	.string	"'s brains are on the wall thanks to"
	.align 2
.LC89:
	.string	"'s 10mm MP5/10 round"
	.align 2
.LC90:
	.string	" feels some chest pain via"
	.align 2
.LC91:
	.string	"'s MP5/10 Submachinegun"
	.align 2
.LC92:
	.string	" needs some Pepto Bismol after"
	.align 2
.LC93:
	.string	"'s 10mm MP5 round"
	.align 2
.LC94:
	.string	" had its legs blown off thanks to"
	.align 2
.LC95:
	.string	" had her legs blown off thanks to"
	.align 2
.LC96:
	.string	" had his legs blown off thanks to"
	.align 2
.LC97:
	.string	" had a makeover by"
	.align 2
.LC98:
	.string	"'s M4 Assault Rifle"
	.align 2
.LC99:
	.string	" feels some heart burn thanks to"
	.align 2
.LC100:
	.string	" has an upset stomach thanks to"
	.align 2
.LC101:
	.string	" is now shorter thanks to"
	.align 2
.LC102:
	.string	" accepts"
	.align 2
.LC103:
	.string	"'s M3 Super 90 Assault Shotgun in hole-y matrimony"
	.align 2
.LC104:
	.string	" is full of buckshot from"
	.align 2
.LC105:
	.string	"'s M3 Super 90 Assault Shotgun"
	.align 2
.LC106:
	.string	" ate"
	.align 2
.LC107:
	.string	"'s sawed-off 12 gauge"
	.align 2
.LC108:
	.string	"'s sawed off shotgun"
	.align 2
.LC109:
	.string	" saw the sniper bullet go through its scope thanks to"
	.align 2
.LC110:
	.string	" saw the sniper bullet go through her scope thanks to"
	.align 2
.LC111:
	.string	" saw the sniper bullet go through his scope thanks to"
	.align 2
.LC112:
	.string	" caught a sniper bullet between the eyes from"
	.align 2
.LC113:
	.string	" was picked off by"
	.align 2
.LC114:
	.string	" was sniped in the stomach by"
	.align 2
.LC115:
	.string	" was shot in the legs by"
	.align 2
.LC116:
	.string	"was sniped by"
	.align 2
.LC117:
	.string	" was trepanned by"
	.align 2
.LC118:
	.string	"'s akimbo Mark 23 pistols"
	.align 2
.LC119:
	.string	" was John Woo'd by"
	.align 2
.LC120:
	.string	" needs some new kidneys thanks to"
	.align 2
.LC121:
	.string	"'s pair of Mark 23 Pistols"
	.align 2
.LC122:
	.string	" had its throat slit by"
	.align 2
.LC123:
	.string	" had her throat slit by"
	.align 2
.LC124:
	.string	" had his throat slit by"
	.align 2
.LC125:
	.string	" had open heart surgery, compliments of"
	.align 2
.LC126:
	.string	" was gutted by"
	.align 2
.LC127:
	.string	" was stabbed repeatedly in the legs by"
	.align 2
.LC128:
	.string	" was slashed apart by"
	.align 2
.LC129:
	.string	"'s Combat Knife"
	.align 2
.LC130:
	.string	" caught"
	.align 2
.LC131:
	.string	"'s flying knife with its forehead"
	.align 2
.LC132:
	.string	"'s flying knife with her forehead"
	.align 2
.LC133:
	.string	"'s flying knife with his forehead"
	.align 2
.LC134:
	.string	"'s ribs don't help against"
	.align 2
.LC135:
	.string	"'s flying knife"
	.align 2
.LC136:
	.string	" sees the contents of its own stomach thanks to"
	.align 2
.LC137:
	.string	" sees the contents of her own stomach thanks to"
	.align 2
.LC138:
	.string	" sees the contents of his own stomach thanks to"
	.align 2
.LC139:
	.string	" had its legs cut off thanks to"
	.align 2
.LC140:
	.string	" had her legs cut off thanks to"
	.align 2
.LC141:
	.string	" had his legs cut off thanks to"
	.align 2
.LC142:
	.string	" was hit by"
	.align 2
.LC143:
	.string	"'s flying Combat Knife"
	.align 2
.LC144:
	.string	"sucks down some toxic gas thanks to"
	.align 2
.LC145:
	.string	" got its ass kicked by"
	.align 2
.LC146:
	.string	" got her ass kicked by"
	.align 2
.LC147:
	.string	" got his ass kicked by"
	.align 2
.LC148:
	.string	" couldn't remove"
	.align 2
.LC149:
	.string	"'s boot from its ass"
	.align 2
.LC150:
	.string	"'s boot from her ass"
	.align 2
.LC151:
	.string	"'s boot from his ass"
	.align 2
.LC152:
	.string	" had a Bruce Lee put on it by"
	.align 2
.LC153:
	.string	", with a quickness"
	.align 2
.LC154:
	.string	" had a Bruce Lee put on her by"
	.align 2
.LC155:
	.string	" had a Bruce Lee put on him by"
	.align 2
.LC156:
	.string	"was blasted by"
	.align 2
.LC157:
	.string	"was gunned down by"
	.align 2
.LC158:
	.string	"was blown away by"
	.align 2
.LC159:
	.string	"'s super shotgun"
	.align 2
.LC160:
	.string	"was machinegunned by"
	.align 2
.LC161:
	.string	"was cut in half by"
	.align 2
.LC162:
	.string	"'s chaingun"
	.align 2
.LC163:
	.string	"was popped by"
	.align 2
.LC164:
	.string	"'s grenade"
	.align 2
.LC165:
	.string	"was shredded by"
	.align 2
.LC166:
	.string	"'s shrapnel"
	.align 2
.LC167:
	.string	"ate"
	.align 2
.LC168:
	.string	"'s rocket"
	.align 2
.LC169:
	.string	"almost dodged"
	.align 2
.LC170:
	.string	"was melted by"
	.align 2
.LC171:
	.string	"'s hyperblaster"
	.align 2
.LC172:
	.string	"was railed by"
	.align 2
.LC173:
	.string	"saw the pretty lights from"
	.align 2
.LC174:
	.string	"'s BFG"
	.align 2
.LC175:
	.string	"was disintegrated by"
	.align 2
.LC176:
	.string	"'s BFG blast"
	.align 2
.LC177:
	.string	"couldn't hide from"
	.align 2
.LC178:
	.string	"'s handgrenade"
	.align 2
.LC179:
	.string	" didn't see"
	.align 2
.LC180:
	.string	" feels"
	.align 2
.LC181:
	.string	"'s pain"
	.align 2
.LC182:
	.string	" tried to invade"
	.align 2
.LC183:
	.string	"'s personal space"
	.align 2
.LC184:
	.string	"%s%s %s%s\n"
	.align 2
.LC185:
	.string	"%s died\n"
	.align 2
.LC186:
	.long 0x0
	.align 2
.LC187:
	.long 0x42b40000
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-2128(1)
	mflr 0
	stmw 21,2084(1)
	stw 0,2132(1)
	lis 9,coop@ha
	lis 8,.LC186@ha
	lwz 11,coop@l(9)
	la 8,.LC186@l(8)
	mr 29,3
	lfs 13,0(8)
	mr 26,5
	li 27,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L89
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L89
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L89:
	xor 0,26,29
	addic 9,26,-1
	subfe 11,9,26
	mr 31,0
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L91
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L90
	mr 3,29
	mr 4,26
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L90
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L90:
	addic 0,31,-1
	subfe 9,0,31
	addic 8,26,-1
	subfe 0,8,26
	and. 10,0,9
	bc 12,2,.L91
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L91
	stw 26,956(29)
.L91:
	lis 11,.LC186@ha
	lis 9,deathmatch@ha
	la 11,.LC186@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L93
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L92
.L93:
	lis 9,meansOfDeath@ha
	lis 10,locOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	lis 11,.LC42@ha
	li 31,0
	lwz 30,locOfDeath@l(10)
	la 28,.LC42@l(11)
	rlwinm 22,0,0,5,3
	rlwinm 21,0,0,4,4
	addi 10,22,-17
	cmplwi 0,10,29
	bc 12,1,.L94
	lis 11,.L121@ha
	slwi 10,10,2
	la 11,.L121@l(11)
	lis 9,.L121@ha
	lwzx 0,10,11
	la 9,.L121@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L121:
	.long .L110-.L121
	.long .L111-.L121
	.long .L112-.L121
	.long .L109-.L121
	.long .L94-.L121
	.long .L97-.L121
	.long .L96-.L121
	.long .L94-.L121
	.long .L114-.L121
	.long .L114-.L121
	.long .L120-.L121
	.long .L115-.L121
	.long .L120-.L121
	.long .L116-.L121
	.long .L120-.L121
	.long .L94-.L121
	.long .L117-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L94-.L121
	.long .L95-.L121
.L95:
	lis 9,.LC43@ha
	la 31,.LC43@l(9)
	b .L94
.L96:
	lis 9,.LC44@ha
	la 31,.LC44@l(9)
	b .L94
.L97:
	lwz 3,84(29)
	lwz 9,4412(3)
	cmpwi 0,3,0
	addic 9,9,-1
	subfe 9,9,9
	addi 0,9,1
	and 9,27,9
	or 27,9,0
	bc 4,2,.L100
	li 10,0
	b .L101
.L100:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L101
	cmpwi 0,11,109
	bc 12,2,.L101
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L101:
	cmpwi 0,10,0
	bc 12,2,.L99
	lis 9,.LC45@ha
	la 31,.LC45@l(9)
	b .L94
.L99:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L105
	li 0,0
	b .L106
.L105:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L106:
	cmpwi 0,0,0
	bc 12,2,.L104
	lis 9,.LC46@ha
	la 31,.LC46@l(9)
	b .L94
.L104:
	lis 9,.LC47@ha
	la 31,.LC47@l(9)
	b .L94
.L109:
	lis 9,.LC48@ha
	la 31,.LC48@l(9)
	b .L94
.L110:
	lis 9,.LC49@ha
	la 31,.LC49@l(9)
	b .L94
.L111:
	lis 9,.LC50@ha
	la 31,.LC50@l(9)
	b .L94
.L112:
	lis 9,.LC51@ha
	la 31,.LC51@l(9)
	b .L94
.L114:
	lis 9,.LC52@ha
	la 31,.LC52@l(9)
	b .L94
.L115:
	lis 9,.LC53@ha
	la 31,.LC53@l(9)
	b .L94
.L116:
	lis 9,.LC54@ha
	la 31,.LC54@l(9)
	b .L94
.L117:
	lis 9,.LC55@ha
	la 31,.LC55@l(9)
	b .L94
.L120:
	lis 9,.LC56@ha
	la 31,.LC56@l(9)
.L94:
	cmpw 0,26,29
	bc 4,2,.L123
	addi 10,22,-7
	cmplwi 0,10,17
	bc 12,1,.L159
	lis 11,.L170@ha
	slwi 10,10,2
	la 11,.L170@l(11)
	lis 9,.L170@ha
	lwzx 0,10,11
	la 9,.L170@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L170:
	.long .L136-.L170
	.long .L159-.L170
	.long .L147-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L158-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L126-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L159-.L170
	.long .L125-.L170
.L125:
	lis 9,.LC57@ha
	la 31,.LC57@l(9)
	b .L123
.L126:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 12,2,.L127
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L127
	cmpwi 0,11,109
.L127:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L132
	li 0,0
	b .L133
.L132:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L133:
	cmpwi 0,0,0
	bc 12,2,.L131
	lis 9,.LC59@ha
	la 31,.LC59@l(9)
	b .L123
.L131:
	lis 9,.LC60@ha
	la 31,.LC60@l(9)
	b .L123
.L136:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L138
	li 10,0
	b .L139
.L138:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L139
	cmpwi 0,11,109
	bc 12,2,.L139
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L139:
	cmpwi 0,10,0
	bc 12,2,.L137
	lis 9,.LC61@ha
	la 31,.LC61@l(9)
	b .L123
.L137:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L143
	li 0,0
	b .L144
.L143:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L144:
	cmpwi 0,0,0
	bc 12,2,.L142
	lis 9,.LC62@ha
	la 31,.LC62@l(9)
	b .L123
.L142:
	lis 9,.LC63@ha
	la 31,.LC63@l(9)
	b .L123
.L147:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L149
	li 10,0
	b .L150
.L149:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L150
	cmpwi 0,11,109
	bc 12,2,.L150
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L150:
	cmpwi 0,10,0
	bc 12,2,.L148
	lis 9,.LC64@ha
	la 31,.LC64@l(9)
	b .L123
.L148:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L154
	li 0,0
	b .L155
.L154:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L155:
	cmpwi 0,0,0
	bc 12,2,.L153
	lis 9,.LC65@ha
	la 31,.LC65@l(9)
	b .L123
.L153:
	lis 9,.LC66@ha
	la 31,.LC66@l(9)
	b .L123
.L158:
	lis 9,.LC67@ha
	la 31,.LC67@l(9)
	b .L123
.L159:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L161
	li 10,0
	b .L162
.L161:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L162
	cmpwi 0,11,109
	bc 12,2,.L162
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L162:
	cmpwi 0,10,0
	bc 12,2,.L160
	lis 9,.LC68@ha
	la 31,.LC68@l(9)
	b .L123
.L160:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L166
	li 0,0
	b .L167
.L166:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L167:
	cmpwi 0,0,0
	bc 12,2,.L165
	lis 9,.LC69@ha
	la 31,.LC69@l(9)
	b .L123
.L165:
	lis 9,.LC70@ha
	la 31,.LC70@l(9)
.L123:
	cmpwi 7,27,0
	addic 11,31,-1
	subfe 9,11,31
	mfcr 0
	rlwinm 0,0,31,1
	and. 8,9,0
	bc 12,2,.L171
	lwz 5,84(29)
	addi 3,1,8
	lis 4,.LC71@ha
	mr 6,31
	la 4,.LC71@l(4)
	addi 5,5,700
	mr 28,3
	crxor 6,6,6
	bl sprintf
	lis 9,teamplay@ha
	lis 8,.LC186@ha
	lwz 11,teamplay@l(9)
	la 8,.LC186@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L472
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L174
	lis 5,.LC41@ha
	li 3,0
	la 5,.LC41@l(5)
	li 4,1
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L174:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L217
	mr 24,9
	lis 25,g_edicts@ha
	lis 26,team_round_going@ha
	lis 27,.LC41@ha
	li 30,996
.L177:
	lwz 0,g_edicts@l(25)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L180
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L180
	cmpw 0,29,3
	bc 12,2,.L181
	lwz 0,team_round_going@l(26)
	cmpwi 0,0,0
	bc 12,2,.L181
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L180
.L181:
	li 4,1
	la 5,.LC41@l(27)
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L180:
	lwz 0,1544(24)
	addi 31,31,1
	addi 30,30,996
	cmpw 0,31,0
	bc 4,1,.L177
	b .L217
.L171:
	bc 12,30,.L185
	lwz 5,84(29)
	lwz 6,4400(5)
	cmpwi 0,6,0
	bc 12,2,.L187
	lwz 6,84(6)
	cmpwi 0,6,0
	bc 12,2,.L187
	cmpw 0,6,5
	bc 12,2,.L187
	addi 3,1,8
	lis 4,.LC72@ha
	addi 5,5,700
	la 4,.LC72@l(4)
	addi 6,6,700
	mr 28,3
	crxor 6,6,6
	bl sprintf
	lis 9,teamplay@ha
	lis 8,.LC186@ha
	lwz 11,teamplay@l(9)
	la 8,.LC186@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L188
	mr 4,28
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	b .L189
.L188:
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L190
	lis 5,.LC41@ha
	li 3,0
	la 5,.LC41@l(5)
	li 4,1
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L190:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L189
	mr 24,9
	lis 25,g_edicts@ha
	lis 26,team_round_going@ha
	lis 27,.LC41@ha
	li 30,996
.L193:
	lwz 0,g_edicts@l(25)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L196
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L196
	cmpw 0,29,3
	bc 12,2,.L197
	lwz 0,team_round_going@l(26)
	cmpwi 0,0,0
	bc 12,2,.L197
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L196
.L197:
	li 4,1
	la 5,.LC41@l(27)
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L196:
	lwz 0,1544(24)
	addi 31,31,1
	addi 30,30,996
	cmpw 0,31,0
	bc 4,1,.L193
.L189:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,2072(1)
	lwz 11,2076(1)
	andi. 31,11,256
	bc 4,2,.L199
	lwz 9,84(29)
	mr 3,29
	lwz 4,4400(9)
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L199
	lis 11,teamplay@ha
	lis 8,.LC186@ha
	lwz 9,teamplay@l(11)
	la 8,.LC186@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L199
	bc 12,2,.L201
	lis 9,team_round_going@ha
	lwz 0,team_round_going@l(9)
	cmpwi 0,0,0
	bc 12,2,.L88
.L201:
	lwz 9,84(29)
	lwz 3,4400(9)
	bl Add_TeamKill
	lwz 9,84(29)
	lwz 8,4400(9)
	lwz 10,84(8)
	lwz 9,3440(10)
	addi 9,9,-1
	stw 9,3440(10)
	lwz 11,84(8)
	stw 31,3476(11)
	b .L88
.L199:
	lis 9,teamplay@ha
	lis 8,.LC186@ha
	lwz 11,teamplay@l(9)
	la 8,.LC186@l(8)
	xori 0,22,21
	lfs 13,0(8)
	addic 10,0,-1
	subfe 9,10,0
	lfs 0,20(11)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	or. 11,0,9
	bc 12,2,.L88
	lwz 9,84(29)
	lwz 3,4400(9)
	bl Add_Frag
	b .L88
.L187:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L207
	li 10,0
	b .L208
.L207:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L208
	cmpwi 0,11,109
	bc 12,2,.L208
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L208:
	cmpwi 0,10,0
	bc 12,2,.L206
	lwz 5,84(29)
	lis 4,.LC73@ha
	addi 3,1,8
	la 4,.LC73@l(4)
	b .L470
.L206:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L212
	li 0,0
	b .L213
.L212:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L213:
	cmpwi 0,0,0
	bc 12,2,.L211
	lwz 5,84(29)
	lis 4,.LC74@ha
	addi 3,1,8
	la 4,.LC74@l(4)
.L470:
	addi 5,5,700
	crxor 6,6,6
	bl sprintf
	b .L210
.L211:
	lwz 5,84(29)
	lis 4,.LC75@ha
	addi 3,1,8
	la 4,.LC75@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl sprintf
.L210:
	lis 9,teamplay@ha
	lis 8,.LC186@ha
	lwz 11,teamplay@l(9)
	la 8,.LC186@l(8)
	addi 28,1,8
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L216
.L472:
	mr 4,28
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	b .L217
.L216:
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L218
	lis 5,.LC41@ha
	li 3,0
	la 5,.LC41@l(5)
	li 4,1
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L218:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L217
	mr 24,9
	lis 25,g_edicts@ha
	lis 26,team_round_going@ha
	lis 27,.LC41@ha
	li 30,996
.L221:
	lwz 0,g_edicts@l(25)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L224
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L224
	cmpw 0,29,3
	bc 12,2,.L225
	lwz 0,team_round_going@l(26)
	cmpwi 0,0,0
	bc 12,2,.L225
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L224
.L225:
	li 4,1
	la 5,.LC41@l(27)
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L224:
	lwz 0,1544(24)
	addi 31,31,1
	addi 30,30,996
	cmpw 0,31,0
	bc 4,1,.L221
.L217:
	lis 11,deathmatch@ha
	lis 8,.LC186@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC186@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L227
	lwz 10,84(29)
	li 0,0
	lwz 9,3440(10)
	addi 9,9,-1
	stw 9,3440(10)
	lwz 11,84(29)
	stw 0,3476(11)
.L227:
	li 0,0
	stw 0,540(29)
	b .L88
.L185:
	cmpwi 0,26,0
	stw 26,540(29)
	bc 12,2,.L92
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L92
	addi 10,22,-1
	cmplwi 0,10,44
	bc 12,1,.L230
	lis 11,.L436@ha
	slwi 10,10,2
	la 11,.L436@l(11)
	lis 9,.L436@ha
	lwzx 0,10,11
	la 9,.L436@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L436:
	.long .L418-.L436
	.long .L419-.L436
	.long .L420-.L436
	.long .L421-.L436
	.long .L422-.L436
	.long .L423-.L436
	.long .L424-.L436
	.long .L425-.L436
	.long .L426-.L436
	.long .L427-.L436
	.long .L428-.L436
	.long .L429-.L436
	.long .L430-.L436
	.long .L431-.L436
	.long .L432-.L436
	.long .L433-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L435-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L434-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L230-.L436
	.long .L231-.L436
	.long .L260-.L436
	.long .L279-.L436
	.long .L288-.L436
	.long .L291-.L436
	.long .L294-.L436
	.long .L315-.L436
	.long .L324-.L436
	.long .L343-.L436
	.long .L230-.L436
	.long .L382-.L436
	.long .L383-.L436
.L231:
	cmpwi 0,30,2
	bc 12,2,.L244
	bc 12,1,.L259
	cmpwi 0,30,1
	bc 12,2,.L233
	b .L257
.L259:
	cmpwi 0,30,3
	bc 12,2,.L245
	cmpwi 0,30,4
	bc 12,2,.L256
	b .L257
.L233:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L235
	li 10,0
	b .L236
.L235:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L236
	cmpwi 0,11,109
	bc 12,2,.L236
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L236:
	cmpwi 0,10,0
	bc 12,2,.L234
	lis 9,.LC76@ha
	la 31,.LC76@l(9)
	b .L238
.L234:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L240
	li 0,0
	b .L241
.L240:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L241:
	cmpwi 0,0,0
	bc 12,2,.L239
	lis 9,.LC77@ha
	la 31,.LC77@l(9)
	b .L238
.L239:
	lis 9,.LC78@ha
	la 31,.LC78@l(9)
.L238:
	lis 9,.LC79@ha
	la 28,.LC79@l(9)
	b .L230
.L244:
	lis 9,.LC80@ha
	lis 11,.LC79@ha
	la 31,.LC80@l(9)
	la 28,.LC79@l(11)
	b .L230
.L245:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L247
	li 10,0
	b .L248
.L247:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L248
	cmpwi 0,11,109
	bc 12,2,.L248
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L248:
	cmpwi 0,10,0
	bc 12,2,.L246
	lis 9,.LC81@ha
	la 31,.LC81@l(9)
	b .L250
.L246:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L252
	li 0,0
	b .L253
.L252:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L253:
	cmpwi 0,0,0
	bc 12,2,.L251
	lis 9,.LC82@ha
	la 31,.LC82@l(9)
	b .L250
.L251:
	lis 9,.LC83@ha
	la 31,.LC83@l(9)
.L250:
	lis 9,.LC84@ha
	la 28,.LC84@l(9)
	b .L230
.L256:
	lis 9,.LC85@ha
	lis 11,.LC84@ha
	la 31,.LC85@l(9)
	la 28,.LC84@l(11)
	b .L230
.L257:
	lis 9,.LC86@ha
	lis 11,.LC87@ha
	la 31,.LC86@l(9)
	la 28,.LC87@l(11)
	b .L230
.L260:
	cmpwi 0,30,2
	bc 12,2,.L263
	bc 12,1,.L278
	cmpwi 0,30,1
	bc 12,2,.L262
	b .L276
.L278:
	cmpwi 0,30,3
	bc 12,2,.L264
	cmpwi 0,30,4
	bc 12,2,.L265
	b .L276
.L262:
	lis 9,.LC88@ha
	lis 11,.LC89@ha
	la 31,.LC88@l(9)
	la 28,.LC89@l(11)
	b .L230
.L263:
	lis 9,.LC90@ha
	lis 11,.LC91@ha
	la 31,.LC90@l(9)
	la 28,.LC91@l(11)
	b .L230
.L264:
	lis 9,.LC92@ha
	lis 11,.LC93@ha
	la 31,.LC92@l(9)
	la 28,.LC93@l(11)
	b .L230
.L265:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L267
	li 10,0
	b .L268
.L267:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L268
	cmpwi 0,11,109
	bc 12,2,.L268
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L268:
	cmpwi 0,10,0
	bc 12,2,.L266
	lis 9,.LC94@ha
	la 31,.LC94@l(9)
	b .L270
.L266:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L272
	li 0,0
	b .L273
.L272:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L273:
	cmpwi 0,0,0
	bc 12,2,.L271
	lis 9,.LC95@ha
	la 31,.LC95@l(9)
	b .L270
.L271:
	lis 9,.LC96@ha
	la 31,.LC96@l(9)
.L270:
	lis 9,.LC91@ha
	la 28,.LC91@l(9)
	b .L230
.L276:
	lis 9,.LC86@ha
	lis 11,.LC91@ha
	la 31,.LC86@l(9)
	la 28,.LC91@l(11)
	b .L230
.L279:
	cmpwi 0,30,2
	bc 12,2,.L282
	bc 12,1,.L287
	cmpwi 0,30,1
	bc 12,2,.L281
	b .L285
.L287:
	cmpwi 0,30,3
	bc 12,2,.L283
	cmpwi 0,30,4
	bc 12,2,.L284
	b .L285
.L281:
	lis 9,.LC97@ha
	lis 11,.LC98@ha
	la 31,.LC97@l(9)
	la 28,.LC98@l(11)
	b .L230
.L282:
	lis 9,.LC99@ha
	lis 11,.LC98@ha
	la 31,.LC99@l(9)
	la 28,.LC98@l(11)
	b .L230
.L283:
	lis 9,.LC100@ha
	lis 11,.LC98@ha
	la 31,.LC100@l(9)
	la 28,.LC98@l(11)
	b .L230
.L284:
	lis 9,.LC101@ha
	lis 11,.LC98@ha
	la 31,.LC101@l(9)
	la 28,.LC98@l(11)
	b .L230
.L285:
	lis 9,.LC86@ha
	lis 11,.LC98@ha
	la 31,.LC86@l(9)
	la 28,.LC98@l(11)
	b .L230
.L288:
	bl rand
	srwi 0,3,31
	add 0,3,0
	rlwinm 0,0,0,0,30
	cmpw 0,3,0
	bc 4,2,.L289
	lis 9,.LC102@ha
	lis 11,.LC103@ha
	la 31,.LC102@l(9)
	la 28,.LC103@l(11)
	b .L230
.L289:
	lis 9,.LC104@ha
	lis 11,.LC105@ha
	la 31,.LC104@l(9)
	la 28,.LC105@l(11)
	b .L230
.L291:
	bl rand
	srwi 0,3,31
	add 0,3,0
	rlwinm 0,0,0,0,30
	cmpw 0,3,0
	bc 4,2,.L292
	lis 9,.LC106@ha
	lis 11,.LC107@ha
	la 31,.LC106@l(9)
	la 28,.LC107@l(11)
	b .L230
.L292:
	lis 9,.LC104@ha
	lis 11,.LC108@ha
	la 31,.LC104@l(9)
	la 28,.LC108@l(11)
	b .L230
.L294:
	cmpwi 0,30,2
	bc 12,2,.L309
	bc 12,1,.L314
	cmpwi 0,30,1
	bc 12,2,.L296
	b .L312
.L314:
	cmpwi 0,30,3
	bc 12,2,.L310
	cmpwi 0,30,4
	bc 12,2,.L311
	b .L312
.L296:
	lwz 3,84(29)
	lis 8,.LC187@ha
	la 8,.LC187@l(8)
	lfs 13,0(8)
	lfs 0,112(3)
	fcmpu 0,0,13
	bc 4,0,.L297
	cmpwi 0,3,0
	bc 4,2,.L299
	li 10,0
	b .L300
.L299:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L300
	cmpwi 0,11,109
	bc 12,2,.L300
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L300:
	cmpwi 0,10,0
	bc 12,2,.L298
	lis 9,.LC109@ha
	la 31,.LC109@l(9)
	b .L230
.L298:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L304
	li 0,0
	b .L305
.L304:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L305:
	cmpwi 0,0,0
	bc 12,2,.L303
	lis 9,.LC110@ha
	la 31,.LC110@l(9)
	b .L230
.L303:
	lis 9,.LC111@ha
	la 31,.LC111@l(9)
	b .L230
.L297:
	lis 9,.LC112@ha
	la 31,.LC112@l(9)
	b .L230
.L309:
	lis 9,.LC113@ha
	la 31,.LC113@l(9)
	b .L230
.L310:
	lis 9,.LC114@ha
	la 31,.LC114@l(9)
	b .L230
.L311:
	lis 9,.LC115@ha
	la 31,.LC115@l(9)
	b .L230
.L312:
	lis 9,.LC116@ha
	la 31,.LC116@l(9)
	b .L230
.L315:
	cmpwi 0,30,2
	bc 12,2,.L318
	bc 12,1,.L323
	cmpwi 0,30,1
	bc 12,2,.L317
	b .L321
.L323:
	cmpwi 0,30,3
	bc 12,2,.L319
	cmpwi 0,30,4
	bc 12,2,.L320
	b .L321
.L317:
	lis 9,.LC117@ha
	lis 11,.LC118@ha
	la 31,.LC117@l(9)
	la 28,.LC118@l(11)
	b .L230
.L318:
	lis 9,.LC119@ha
	la 31,.LC119@l(9)
	b .L230
.L319:
	lis 9,.LC120@ha
	lis 11,.LC118@ha
	la 31,.LC120@l(9)
	la 28,.LC118@l(11)
	b .L230
.L320:
	lis 9,.LC115@ha
	lis 11,.LC118@ha
	la 31,.LC115@l(9)
	la 28,.LC118@l(11)
	b .L230
.L321:
	lis 9,.LC86@ha
	lis 11,.LC121@ha
	la 31,.LC86@l(9)
	la 28,.LC121@l(11)
	b .L230
.L324:
	cmpwi 0,30,2
	bc 12,2,.L337
	bc 12,1,.L342
	cmpwi 0,30,1
	bc 12,2,.L326
	b .L340
.L342:
	cmpwi 0,30,3
	bc 12,2,.L338
	cmpwi 0,30,4
	bc 12,2,.L339
	b .L340
.L326:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L328
	li 10,0
	b .L329
.L328:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L329
	cmpwi 0,11,109
	bc 12,2,.L329
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L329:
	cmpwi 0,10,0
	bc 12,2,.L327
	lis 9,.LC122@ha
	la 31,.LC122@l(9)
	b .L230
.L327:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L333
	li 0,0
	b .L334
.L333:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L334:
	cmpwi 0,0,0
	bc 12,2,.L332
	lis 9,.LC123@ha
	la 31,.LC123@l(9)
	b .L230
.L332:
	lis 9,.LC124@ha
	la 31,.LC124@l(9)
	b .L230
.L337:
	lis 9,.LC125@ha
	la 31,.LC125@l(9)
	b .L230
.L338:
	lis 9,.LC126@ha
	la 31,.LC126@l(9)
	b .L230
.L339:
	lis 9,.LC127@ha
	la 31,.LC127@l(9)
	b .L230
.L340:
	lis 9,.LC128@ha
	lis 11,.LC129@ha
	la 31,.LC128@l(9)
	la 28,.LC129@l(11)
	b .L230
.L343:
	cmpwi 0,30,2
	bc 12,2,.L356
	bc 12,1,.L381
	cmpwi 0,30,1
	bc 12,2,.L345
	b .L379
.L381:
	cmpwi 0,30,3
	bc 12,2,.L357
	cmpwi 0,30,4
	bc 12,2,.L368
	b .L379
.L345:
	lwz 3,84(29)
	lis 9,.LC130@ha
	la 31,.LC130@l(9)
	cmpwi 0,3,0
	bc 4,2,.L347
	li 10,0
	b .L348
.L347:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L348
	cmpwi 0,11,109
	bc 12,2,.L348
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L348:
	cmpwi 0,10,0
	bc 12,2,.L346
	lis 9,.LC131@ha
	la 28,.LC131@l(9)
	b .L230
.L346:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L352
	li 0,0
	b .L353
.L352:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L353:
	cmpwi 0,0,0
	bc 12,2,.L351
	lis 9,.LC132@ha
	la 28,.LC132@l(9)
	b .L230
.L351:
	lis 9,.LC133@ha
	la 28,.LC133@l(9)
	b .L230
.L356:
	lis 9,.LC134@ha
	lis 11,.LC135@ha
	la 31,.LC134@l(9)
	la 28,.LC135@l(11)
	b .L230
.L357:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L359
	li 10,0
	b .L360
.L359:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L360
	cmpwi 0,11,109
	bc 12,2,.L360
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L360:
	cmpwi 0,10,0
	bc 12,2,.L358
	lis 9,.LC136@ha
	la 31,.LC136@l(9)
	b .L373
.L358:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L364
	li 0,0
	b .L365
.L364:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L365:
	cmpwi 0,0,0
	bc 12,2,.L363
	lis 9,.LC137@ha
	la 31,.LC137@l(9)
	b .L373
.L363:
	lis 9,.LC138@ha
	la 31,.LC138@l(9)
	b .L373
.L368:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L370
	li 10,0
	b .L371
.L370:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L371
	cmpwi 0,11,109
	bc 12,2,.L371
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L371:
	cmpwi 0,10,0
	bc 12,2,.L369
	lis 9,.LC139@ha
	la 31,.LC139@l(9)
	b .L373
.L369:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L375
	li 0,0
	b .L376
.L375:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L376:
	cmpwi 0,0,0
	bc 12,2,.L374
	lis 9,.LC140@ha
	la 31,.LC140@l(9)
	b .L373
.L374:
	lis 9,.LC141@ha
	la 31,.LC141@l(9)
.L373:
	lis 9,.LC135@ha
	la 28,.LC135@l(9)
	b .L230
.L379:
	lis 9,.LC142@ha
	lis 11,.LC143@ha
	la 31,.LC142@l(9)
	la 28,.LC143@l(11)
	b .L230
.L382:
	lis 9,.LC144@ha
	la 31,.LC144@l(9)
	b .L230
.L383:
	bl rand
	lis 9,0x5555
	srawi 11,3,31
	ori 9,9,21846
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 3,0,3
	cmpwi 0,3,0
	addi 0,3,1
	bc 4,2,.L384
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L386
	li 10,0
	b .L387
.L386:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L387
	cmpwi 0,11,109
	bc 12,2,.L387
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L387:
	cmpwi 0,10,0
	bc 12,2,.L385
	lis 9,.LC145@ha
	la 31,.LC145@l(9)
	b .L230
.L385:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L391
	li 0,0
	b .L392
.L391:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L392:
	cmpwi 0,0,0
	bc 12,2,.L390
	lis 9,.LC146@ha
	la 31,.LC146@l(9)
	b .L230
.L390:
	lis 9,.LC147@ha
	la 31,.LC147@l(9)
	b .L230
.L384:
	cmpwi 0,0,2
	bc 4,2,.L396
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L398
	li 10,0
	b .L399
.L398:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L399
	cmpwi 0,11,109
	bc 12,2,.L399
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L399:
	cmpwi 0,10,0
	bc 12,2,.L397
	lis 9,.LC148@ha
	lis 11,.LC149@ha
	la 31,.LC148@l(9)
	la 28,.LC149@l(11)
	b .L230
.L397:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L403
	li 0,0
	b .L404
.L403:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L404:
	cmpwi 0,0,0
	bc 12,2,.L402
	lis 9,.LC148@ha
	lis 11,.LC150@ha
	la 31,.LC148@l(9)
	la 28,.LC150@l(11)
	b .L230
.L402:
	lis 9,.LC148@ha
	lis 11,.LC151@ha
	la 31,.LC148@l(9)
	la 28,.LC151@l(11)
	b .L230
.L396:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L409
	li 10,0
	b .L410
.L409:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L410
	cmpwi 0,11,109
	bc 12,2,.L410
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L410:
	cmpwi 0,10,0
	bc 12,2,.L408
	lis 9,.LC152@ha
	lis 11,.LC153@ha
	la 31,.LC152@l(9)
	la 28,.LC153@l(11)
	b .L230
.L408:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L414
	li 0,0
	b .L415
.L414:
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L415:
	cmpwi 0,0,0
	bc 12,2,.L413
	lis 9,.LC154@ha
	lis 11,.LC153@ha
	la 31,.LC154@l(9)
	la 28,.LC153@l(11)
	b .L230
.L413:
	lis 9,.LC155@ha
	lis 11,.LC153@ha
	la 31,.LC155@l(9)
	la 28,.LC153@l(11)
	b .L230
.L418:
	lis 9,.LC156@ha
	la 31,.LC156@l(9)
	b .L230
.L419:
	lis 9,.LC157@ha
	la 31,.LC157@l(9)
	b .L230
.L420:
	lis 9,.LC158@ha
	lis 11,.LC159@ha
	la 31,.LC158@l(9)
	la 28,.LC159@l(11)
	b .L230
.L421:
	lis 9,.LC160@ha
	la 31,.LC160@l(9)
	b .L230
.L422:
	lis 9,.LC161@ha
	lis 11,.LC162@ha
	la 31,.LC161@l(9)
	la 28,.LC162@l(11)
	b .L230
.L423:
	lis 9,.LC163@ha
	lis 11,.LC164@ha
	la 31,.LC163@l(9)
	la 28,.LC164@l(11)
	b .L230
.L424:
	lis 9,.LC165@ha
	lis 11,.LC166@ha
	la 31,.LC165@l(9)
	la 28,.LC166@l(11)
	b .L230
.L425:
	lis 9,.LC167@ha
	lis 11,.LC168@ha
	la 31,.LC167@l(9)
	la 28,.LC168@l(11)
	b .L230
.L426:
	lis 9,.LC169@ha
	lis 11,.LC168@ha
	la 31,.LC169@l(9)
	la 28,.LC168@l(11)
	b .L230
.L427:
	lis 9,.LC170@ha
	lis 11,.LC171@ha
	la 31,.LC170@l(9)
	la 28,.LC171@l(11)
	b .L230
.L428:
	lis 9,.LC172@ha
	la 31,.LC172@l(9)
	b .L230
.L429:
	lis 9,.LC173@ha
	lis 11,.LC174@ha
	la 31,.LC173@l(9)
	la 28,.LC174@l(11)
	b .L230
.L430:
	lis 9,.LC175@ha
	lis 11,.LC176@ha
	la 31,.LC175@l(9)
	la 28,.LC176@l(11)
	b .L230
.L431:
	lis 9,.LC177@ha
	lis 11,.LC174@ha
	la 31,.LC177@l(9)
	la 28,.LC174@l(11)
	b .L230
.L432:
	lis 9,.LC130@ha
	lis 11,.LC178@ha
	la 31,.LC130@l(9)
	la 28,.LC178@l(11)
	b .L230
.L433:
	lis 9,.LC179@ha
	lis 11,.LC178@ha
	la 31,.LC179@l(9)
	la 28,.LC178@l(11)
	b .L230
.L434:
	lis 9,.LC180@ha
	lis 11,.LC181@ha
	la 31,.LC180@l(9)
	la 28,.LC181@l(11)
	b .L230
.L435:
	lis 9,.LC182@ha
	lis 11,.LC183@ha
	la 31,.LC182@l(9)
	la 28,.LC183@l(11)
.L230:
	cmpwi 0,31,0
	bc 12,2,.L92
	lwz 5,84(29)
	mr 8,28
	addi 3,1,8
	lwz 7,84(26)
	lis 4,.LC184@ha
	mr 6,31
	la 4,.LC184@l(4)
	addi 5,5,700
	addi 7,7,700
	mr 28,3
	crxor 6,6,6
	bl sprintf
	lis 9,teamplay@ha
	lis 8,.LC186@ha
	lwz 11,teamplay@l(9)
	la 8,.LC186@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L439
	mr 4,28
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	b .L440
.L439:
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L441
	lis 5,.LC41@ha
	li 3,0
	la 5,.LC41@l(5)
	li 4,1
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L441:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L440
	mr 23,9
	lis 24,g_edicts@ha
	lis 25,team_round_going@ha
	lis 27,.LC41@ha
	li 30,996
.L444:
	lwz 0,g_edicts@l(24)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L447
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L447
	cmpw 0,29,3
	bc 12,2,.L448
	lwz 0,team_round_going@l(25)
	cmpwi 0,0,0
	bc 12,2,.L448
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L447
.L448:
	li 4,1
	la 5,.LC41@l(27)
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L447:
	lwz 0,1544(23)
	addi 31,31,1
	addi 30,30,996
	cmpw 0,31,0
	bc 4,1,.L444
.L440:
	lis 9,deathmatch@ha
	lis 8,.LC186@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC186@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L88
	cmpwi 0,21,0
	bc 12,2,.L451
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L453
	lis 9,team_round_going@ha
	lwz 0,team_round_going@l(9)
	cmpwi 0,0,0
	bc 12,2,.L88
.L453:
	mr 3,26
	bl Add_TeamKill
	lwz 10,84(26)
	li 0,0
	lwz 9,3440(10)
	addi 9,9,-1
	stw 9,3440(10)
	lwz 11,84(26)
	b .L471
.L451:
	lis 9,teamplay@ha
	xori 0,22,21
	lwz 11,teamplay@l(9)
	addic 8,0,-1
	subfe 10,8,0
	lfs 0,20(11)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	or. 9,0,10
	bc 12,2,.L88
	mr 3,26
	bl Add_Frag
	b .L88
.L92:
	lwz 5,84(29)
	addi 3,1,8
	lis 4,.LC185@ha
	la 4,.LC185@l(4)
	mr 28,3
	addi 5,5,700
	crxor 6,6,6
	bl sprintf
	lis 9,teamplay@ha
	lis 8,.LC186@ha
	lwz 11,teamplay@l(9)
	la 8,.LC186@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L457
	mr 4,28
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	b .L458
.L457:
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L459
	lis 5,.LC41@ha
	li 3,0
	la 5,.LC41@l(5)
	li 4,1
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L459:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L458
	mr 24,9
	lis 25,g_edicts@ha
	lis 26,team_round_going@ha
	lis 27,.LC41@ha
	li 30,996
.L462:
	lwz 0,g_edicts@l(25)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L465
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L465
	cmpw 0,29,3
	bc 12,2,.L466
	lwz 0,team_round_going@l(26)
	cmpwi 0,0,0
	bc 12,2,.L466
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L465
.L466:
	li 4,1
	la 5,.LC41@l(27)
	mr 6,28
	crxor 6,6,6
	bl safe_cprintf
.L465:
	lwz 0,1544(24)
	addi 31,31,1
	addi 30,30,996
	cmpw 0,31,0
	bc 4,1,.L462
.L458:
	lis 11,deathmatch@ha
	lis 8,.LC186@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC186@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L88
	lwz 10,84(29)
	li 0,0
	lwz 9,3440(10)
	addi 9,9,-1
	stw 9,3440(10)
	lwz 11,84(29)
.L471:
	stw 0,3476(11)
.L88:
	lwz 0,2132(1)
	mtlr 0
	lmw 21,2084(1)
	la 1,2128(1)
	blr
.Lfe5:
	.size	 ClientObituary,.Lfe5-ClientObituary
	.section	".rodata"
	.align 2
.LC192:
	.string	"Lasersight"
	.align 2
.LC193:
	.string	"Dual MK23 Pistols"
	.align 2
.LC196:
	.string	"MP5/10 Submachinegun"
	.align 2
.LC197:
	.string	"M4 Assault Rifle"
	.align 2
.LC198:
	.string	"M3 Super 90 Assault Shotgun"
	.align 2
.LC199:
	.string	"Handcannon"
	.align 2
.LC200:
	.string	"Sniper Rifle"
	.align 2
.LC201:
	.string	"Combat Knife"
	.align 2
.LC194:
	.long 0x46fffe00
	.align 3
.LC195:
	.long 0x4072c000
	.long 0x0
	.align 2
.LC202:
	.long 0x0
	.align 3
.LC203:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC204:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl TossItemsOnDeath
	.type	 TossItemsOnDeath,@function
TossItemsOnDeath:
	stwu 1,-96(1)
	mflr 0
	mfcr 12
	stfd 27,56(1)
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 26,32(1)
	stw 0,100(1)
	stw 12,28(1)
	lis 11,.LC202@ha
	lis 9,allitem@ha
	la 11,.LC202@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,allitem@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L478
	lis 9,allweapon@ha
	lwz 11,allweapon@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L478
	lis 3,.LC192@ha
	la 3,.LC192@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	li 9,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 9,11,3
	b .L477
.L478:
	lis 11,.LC202@ha
	lis 9,allweapon@ha
	la 11,.LC202@l(11)
	lfs 13,0(11)
	lwz 11,allweapon@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L479
	mr 3,31
	bl DeadDropSpec
	b .L477
.L479:
	lis 9,allitem@ha
	lwz 11,allitem@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L480
	mr 3,31
	bl DeadDropSpec
	b .L481
.L480:
	lis 3,.LC192@ha
	la 3,.LC192@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,30
	mullw 9,9,0
	addi 11,11,740
	mr 4,30
	li 0,0
	mr 3,31
	srawi 9,9,3
	slwi 9,9,2
	stwx 0,11,9
	bl SP_LaserSight
.L481:
	lis 3,.LC193@ha
	lis 29,0x38e3
	la 3,.LC193@l(3)
	ori 29,29,36409
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 11,84(31)
	la 28,itemlist@l(9)
	cmpwi 0,30,0
	subf 0,28,30
	addi 11,11,740
	mullw 0,0,29
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,1
	stwx 9,11,0
	bc 12,2,.L483
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC203@ha
	lis 10,.LC194@ha
	stw 0,16(1)
	la 11,.LC203@l(11)
	mr 4,30
	lfd 11,0(11)
	mr 3,31
	lfd 0,16(1)
	lis 11,.LC204@ha
	lfs 10,.LC194@l(10)
	la 11,.LC204@l(11)
	lfd 9,0(11)
	fsub 0,0,11
	lis 11,.LC195@ha
	lfs 13,4064(8)
	lfd 12,.LC195@l(11)
	frsp 0,0
	fdivs 0,0,10
	fmr 31,0
	fsub 31,31,9
	fadd 31,31,31
	fmul 31,31,12
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(8)
	bl Drop_Item
	lwz 9,84(31)
	lis 0,0x2
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 0,284(3)
.L483:
	lis 3,.LC196@ha
	la 3,.LC196@l(3)
	bl FindItem
	mr 30,3
	lwz 10,84(31)
	subf 0,28,30
	mullw 0,0,29
	addi 11,10,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L485
	lis 9,.LC194@ha
	lis 11,.LC195@ha
	lfs 27,.LC194@l(9)
	cmpwi 4,30,0
	mr 29,0
	lis 9,temp_think_specweap@ha
	lfd 28,.LC195@l(11)
	lis 27,0x4330
	la 26,temp_think_specweap@l(9)
	lis 11,.LC204@ha
	lis 9,.LC203@ha
	la 11,.LC204@l(11)
	la 9,.LC203@l(9)
	lfd 30,0(11)
	lis 28,0x2
	lfd 29,0(9)
.L486:
	addi 11,10,740
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bc 12,18,.L484
	bl rand
	rlwinm 0,3,0,17,31
	lwz 11,84(31)
	xoris 0,0,0x8000
	mr 3,31
	stw 0,20(1)
	mr 4,30
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,4064(11)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,27
	fmr 31,0
	fsub 31,31,30
	fadd 31,31,31
	fmul 31,31,28
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(11)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 26,436(3)
	stw 28,284(3)
.L484:
	lwz 10,84(31)
	addi 9,10,740
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 12,1,.L486
.L485:
	lis 3,.LC197@ha
	la 3,.LC197@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,30
	mullw 9,9,0
	addi 11,10,740
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 4,1,.L491
	lis 9,.LC194@ha
	lis 11,.LC195@ha
	lfs 27,.LC194@l(9)
	cmpwi 4,30,0
	mr 29,8
	lis 9,temp_think_specweap@ha
	lfd 28,.LC195@l(11)
	lis 27,0x4330
	la 26,temp_think_specweap@l(9)
	lis 11,.LC204@ha
	lis 9,.LC203@ha
	la 11,.LC204@l(11)
	la 9,.LC203@l(9)
	lfd 30,0(11)
	lis 28,0x2
	lfd 29,0(9)
.L492:
	addi 11,10,740
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bc 12,18,.L490
	bl rand
	rlwinm 0,3,0,17,31
	lwz 11,84(31)
	xoris 0,0,0x8000
	mr 3,31
	stw 0,20(1)
	mr 4,30
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,4064(11)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,27
	fmr 31,0
	fsub 31,31,30
	fadd 31,31,31
	fmul 31,31,28
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(11)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 26,436(3)
	stw 28,284(3)
.L490:
	lwz 10,84(31)
	addi 9,10,740
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 12,1,.L492
.L491:
	lis 3,.LC198@ha
	la 3,.LC198@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,30
	mullw 9,9,0
	addi 11,10,740
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 4,1,.L497
	lis 9,.LC194@ha
	lis 11,.LC195@ha
	lfs 27,.LC194@l(9)
	cmpwi 4,30,0
	mr 29,8
	lis 9,temp_think_specweap@ha
	lfd 28,.LC195@l(11)
	lis 27,0x4330
	la 26,temp_think_specweap@l(9)
	lis 11,.LC204@ha
	lis 9,.LC203@ha
	la 11,.LC204@l(11)
	la 9,.LC203@l(9)
	lfd 30,0(11)
	lis 28,0x2
	lfd 29,0(9)
.L498:
	addi 11,10,740
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bc 12,18,.L496
	bl rand
	rlwinm 0,3,0,17,31
	lwz 11,84(31)
	xoris 0,0,0x8000
	mr 3,31
	stw 0,20(1)
	mr 4,30
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,4064(11)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,27
	fmr 31,0
	fsub 31,31,30
	fadd 31,31,31
	fmul 31,31,28
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(11)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 26,436(3)
	stw 28,284(3)
.L496:
	lwz 10,84(31)
	addi 9,10,740
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 12,1,.L498
.L497:
	lis 3,.LC199@ha
	la 3,.LC199@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,30
	mullw 9,9,0
	addi 11,10,740
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 4,1,.L503
	lis 9,.LC194@ha
	lis 11,.LC195@ha
	lfs 27,.LC194@l(9)
	cmpwi 4,30,0
	mr 29,8
	lis 9,temp_think_specweap@ha
	lfd 28,.LC195@l(11)
	lis 27,0x4330
	la 26,temp_think_specweap@l(9)
	lis 11,.LC204@ha
	lis 9,.LC203@ha
	la 11,.LC204@l(11)
	la 9,.LC203@l(9)
	lfd 30,0(11)
	lis 28,0x2
	lfd 29,0(9)
.L504:
	addi 11,10,740
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bc 12,18,.L502
	bl rand
	rlwinm 0,3,0,17,31
	lwz 11,84(31)
	xoris 0,0,0x8000
	mr 3,31
	stw 0,20(1)
	mr 4,30
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,4064(11)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,27
	fmr 31,0
	fsub 31,31,30
	fadd 31,31,31
	fmul 31,31,28
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(11)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 26,436(3)
	stw 28,284(3)
.L502:
	lwz 10,84(31)
	addi 9,10,740
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 12,1,.L504
.L503:
	lis 3,.LC200@ha
	la 3,.LC200@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,30
	mullw 9,9,0
	addi 11,10,740
	srawi 9,9,3
	slwi 8,9,2
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 4,1,.L509
	lis 9,.LC194@ha
	lis 11,.LC195@ha
	lfs 27,.LC194@l(9)
	cmpwi 4,30,0
	mr 29,8
	lis 9,temp_think_specweap@ha
	lfd 28,.LC195@l(11)
	lis 27,0x4330
	la 26,temp_think_specweap@l(9)
	lis 11,.LC204@ha
	lis 9,.LC203@ha
	la 11,.LC204@l(11)
	la 9,.LC203@l(9)
	lfd 30,0(11)
	lis 28,0x2
	lfd 29,0(9)
.L510:
	addi 11,10,740
	lwzx 9,11,29
	addi 9,9,-1
	stwx 9,11,29
	bc 12,18,.L508
	bl rand
	rlwinm 0,3,0,17,31
	lwz 11,84(31)
	xoris 0,0,0x8000
	mr 3,31
	stw 0,20(1)
	mr 4,30
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,4064(11)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,27
	fmr 31,0
	fsub 31,31,30
	fadd 31,31,31
	fmul 31,31,28
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(11)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 26,436(3)
	stw 28,284(3)
.L508:
	lwz 10,84(31)
	addi 9,10,740
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 12,1,.L510
.L509:
	lis 3,.LC201@ha
	la 3,.LC201@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,30
	mullw 9,9,0
	addi 11,11,740
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,1,.L477
	cmpwi 0,30,0
	bc 12,2,.L477
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC203@ha
	lis 10,.LC194@ha
	stw 0,16(1)
	la 11,.LC203@l(11)
	mr 4,30
	lfd 11,0(11)
	mr 3,31
	lfd 0,16(1)
	lis 11,.LC204@ha
	lfs 10,.LC194@l(10)
	la 11,.LC204@l(11)
	lfd 9,0(11)
	fsub 0,0,11
	lis 11,.LC195@ha
	lfs 13,4064(8)
	lfd 12,.LC195@l(11)
	frsp 0,0
	fdivs 0,0,10
	fmr 31,0
	fsub 31,31,9
	fadd 31,31,31
	fmul 31,31,12
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(8)
	bl Drop_Item
	lwz 9,84(31)
	lis 0,0x2
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 0,284(3)
.L477:
	lwz 0,100(1)
	lwz 12,28(1)
	mtlr 0
	lmw 26,32(1)
	lfd 27,56(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe6:
	.size	 TossItemsOnDeath,.Lfe6-TossItemsOnDeath
	.section	".rodata"
	.align 2
.LC205:
	.string	"Blaster"
	.align 2
.LC206:
	.string	"item_quad"
	.align 3
.LC207:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC208:
	.long 0x0
	.align 3
.LC209:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC210:
	.long 0x41b40000
	.section	".text"
	.align 2
	.globl TossClientWeapon
	.type	 TossClientWeapon,@function
TossClientWeapon:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,deathmatch@ha
	lis 10,.LC208@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC208@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L517
	lwz 9,84(30)
	lwz 11,3936(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L520
	lwz 3,40(31)
	lis 4,.LC205@ha
	la 4,.LC205@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L520:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L521
	li 29,0
	b .L522
.L521:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC209@ha
	lfs 12,4132(8)
	addi 9,9,10
	la 10,.LC209@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 29
	rlwinm 29,29,30,1
.L522:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC208@ha
	and. 10,0,29
	la 9,.LC208@l(9)
	lfs 31,0(9)
	bc 12,2,.L523
	lis 11,.LC210@ha
	la 11,.LC210@l(11)
	lfs 31,0(11)
.L523:
	cmpwi 0,31,0
	bc 12,2,.L525
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,4064(9)
	fsubs 0,0,31
	stfs 0,4064(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 0,284(3)
.L525:
	cmpwi 0,29,0
	bc 12,2,.L517
	lwz 9,84(30)
	lis 3,.LC206@ha
	la 3,.LC206@l(3)
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC209@ha
	lis 11,Touch_Item@ha
	la 9,.LC209@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,4064(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC207@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC207@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,4064(7)
	lwz 0,284(3)
	stw 11,444(3)
	oris 0,0,0x2
	stw 0,284(3)
	lwz 9,level@l(6)
	lwz 11,84(30)
	xoris 9,9,0x8000
	lfs 12,4(5)
	stw 9,20(1)
	stw 4,16(1)
	lfd 13,16(1)
	lfs 0,4132(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L517:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 TossClientWeapon,.Lfe7-TossClientWeapon
	.section	".rodata"
	.align 3
.LC211:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC212:
	.long 0x0
	.align 2
.LC213:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl LookAtKiller
	.type	 LookAtKiller,@function
LookAtKiller:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr. 5,5
	mr 31,3
	bc 12,2,.L528
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L528
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L538
.L528:
	cmpwi 0,4,0
	bc 12,2,.L530
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L530
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L538:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L529
.L530:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3988(9)
	b .L527
.L529:
	lis 9,.LC212@ha
	lfs 2,8(1)
	la 9,.LC212@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L532
	lfs 1,12(1)
	bl atan2
	lis 9,.LC211@ha
	lwz 11,84(31)
	lfd 0,.LC211@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3988(11)
	b .L533
.L532:
	lwz 9,84(31)
	stfs 13,3988(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L534
	lwz 9,84(31)
	lis 0,0x42b4
	b .L539
.L534:
	bc 4,0,.L533
	lwz 9,84(31)
	lis 0,0xc2b4
.L539:
	stw 0,3988(9)
.L533:
	lwz 3,84(31)
	lis 9,.LC212@ha
	la 9,.LC212@l(9)
	lfs 0,0(9)
	lfs 13,3988(3)
	fcmpu 0,13,0
	bc 4,0,.L527
	lis 11,.LC213@ha
	la 11,.LC213@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3988(3)
.L527:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 LookAtKiller,.Lfe8-LookAtKiller
	.section	".sbss","aw",@nobits
	.align 2
i.66:
	.space	4
	.size	 i.66,4
	.section	".rodata"
	.align 2
.LC214:
	.string	"misc/glurp.wav"
	.align 2
.LC215:
	.string	"*death%i.wav"
	.align 2
.LC216:
	.long 0x0
	.align 3
.LC217:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC218:
	.long 0x40000000
	.align 2
.LC219:
	.long 0x43aa0000
	.align 2
.LC220:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,3
	lis 9,.LC216@ha
	la 9,.LC216@l(9)
	lwz 0,248(31)
	li 11,7
	lfs 31,0(9)
	mr 29,4
	mr 30,5
	cmpwi 0,0,1
	li 9,1
	stw 11,260(31)
	stw 9,512(31)
	stfs 31,396(31)
	stfs 31,392(31)
	stfs 31,388(31)
	bc 4,2,.L541
	li 0,2
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,248(31)
	lwz 0,72(9)
	mtlr 0
	blrl
	mr 3,31
	bl RemoveFromTransparentList
.L541:
	lis 28,teamplay@ha
	lwz 9,teamplay@l(28)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L542
	li 0,0
	lis 9,gi+72@ha
	stw 0,248(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L542:
	li 0,0
	lwz 11,84(31)
	lis 10,0xc100
	stw 0,44(31)
	stw 0,76(31)
	stfs 31,16(31)
	stfs 31,24(31)
	stw 0,4160(11)
	lwz 9,84(31)
	stw 0,4420(9)
	lwz 11,84(31)
	stw 0,4424(11)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 10,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L543
	lis 9,level+4@ha
	lis 10,.LC217@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	la 10,.LC217@l(10)
	mr 3,31
	lfd 13,0(10)
	mr 4,29
	mr 5,30
	fadd 0,0,13
	frsp 0,0
	stfs 0,4216(11)
	bl LookAtKiller
	lwz 9,84(31)
	li 0,2
	mr 4,29
	mr 5,30
	mr 3,31
	stw 0,0(9)
	bl ClientObituary
	mr 3,31
	bl TossItemsOnDeath
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L543
	lwz 9,teamplay@l(28)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L543
	mr 3,31
	bl Cmd_Help_f
.L543:
	lwz 11,84(31)
	li 10,0
	stw 10,4132(11)
	lwz 9,84(31)
	stw 10,4136(9)
	lwz 11,84(31)
	stw 10,4140(11)
	lwz 9,84(31)
	stw 10,4144(9)
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L545
	mr 3,31
	li 4,0
	bl SP_LaserSight
.L545:
	lwz 11,84(31)
	li 29,0
	li 0,90
	lis 10,0x42b4
	mr 3,31
	stw 29,4324(11)
	lwz 9,84(31)
	stw 29,3464(9)
	lwz 11,84(31)
	stw 0,4304(11)
	lwz 9,84(31)
	stw 10,112(9)
	lwz 11,84(31)
	stw 29,3476(11)
	bl Bandage
	lwz 9,84(31)
	li 4,0
	li 5,1024
	stw 29,4388(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lwz 11,84(31)
	lwz 0,4284(11)
	cmpwi 0,0,8
	bc 4,2,.L546
	lwz 9,92(11)
	addi 0,9,-4
	addi 9,9,-40
	subfic 0,0,5
	li 0,0
	adde 0,0,0
	subfic 9,9,29
	li 9,0
	adde 9,9,9
	or. 10,9,0
	bc 12,2,.L546
	stw 29,92(11)
	lis 9,.LC216@ha
	lis 10,.LC216@ha
	lis 11,.LC216@ha
	la 9,.LC216@l(9)
	la 10,.LC216@l(10)
	la 11,.LC216@l(11)
	lfs 2,0(9)
	lfs 1,0(11)
	addi 29,31,4
	lfs 3,0(10)
	bl tv
	lis 9,.LC218@ha
	lis 10,.LC219@ha
	la 9,.LC218@l(9)
	la 10,.LC219@l(10)
	lfs 1,0(9)
	mr 5,3
	mr 4,29
	lfs 2,0(10)
	mr 3,31
	li 6,170
	li 7,0
	li 8,0
	bl fire_grenade2
.L546:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L547
	lis 8,i.66@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.66@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.66@l(8)
	stw 7,4120(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L548
	li 0,172
	li 9,177
	b .L560
.L548:
	cmpwi 0,10,1
	bc 12,2,.L552
	bc 12,1,.L556
	cmpwi 0,10,0
	bc 12,2,.L551
	b .L549
.L556:
	cmpwi 0,10,2
	bc 12,2,.L553
	b .L549
.L551:
	li 0,177
	li 9,183
	b .L560
.L552:
	li 0,183
	li 9,189
	b .L560
.L553:
	li 0,189
	li 9,197
.L560:
	stw 0,56(31)
	stw 9,4116(11)
.L549:
	lis 9,meansOfDeath@ha
	lwz 9,meansOfDeath@l(9)
	xori 11,9,39
	subfic 10,11,0
	adde 11,10,11
	xori 0,9,41
	subfic 10,0,0
	adde 0,10,0
	or. 10,11,0
	bc 4,2,.L558
	cmpwi 0,9,42
	bc 4,2,.L557
.L558:
	lis 29,gi@ha
	lis 3,.LC214@ha
	la 29,gi@l(29)
	la 3,.LC214@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC220@ha
	lis 10,.LC220@ha
	lis 11,.LC216@ha
	mr 5,3
	la 9,.LC220@l(9)
	la 10,.LC220@l(10)
	mtlr 0
	la 11,.LC216@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L547
.L557:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC215@ha
	srwi 0,0,30
	la 3,.LC215@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC220@ha
	lis 10,.LC220@ha
	lis 11,.LC216@ha
	mr 5,3
	la 9,.LC220@l(9)
	la 10,.LC220@l(10)
	mtlr 0
	la 11,.LC216@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L547:
	lwz 10,84(31)
	li 0,0
	li 9,2
	lis 11,gi+72@ha
	mr 3,31
	stw 0,4284(10)
	stw 9,492(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 player_die,.Lfe9-player_die
	.section	".rodata"
	.align 2
.LC221:
	.string	"MK23 Pistol"
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 29,3
	li 4,0
	li 5,1624
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 27,0x38e3
	li 26,1
	lis 3,.LC221@ha
	ori 27,27,36409
	la 3,.LC221@l(3)
	addi 25,29,740
	bl FindItem
	lis 28,itemlist@ha
	mr 11,3
	la 28,itemlist@l(28)
	lis 3,.LC201@ha
	subf 0,28,11
	la 3,.LC201@l(3)
	mullw 0,0,27
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(29)
	stwx 26,25,9
	stw 11,1788(29)
	bl FindItem
	subf 3,28,3
	li 0,0
	mullw 3,3,27
	li 9,2
	li 6,100
	li 8,14
	li 7,50
	srawi 3,3,3
	li 10,20
	slwi 3,3,2
	li 11,10
	stwx 26,25,3
	stw 0,4284(29)
	stw 6,728(29)
	stw 8,1768(29)
	stw 7,1776(29)
	stw 10,1784(29)
	stw 11,4276(29)
	stw 9,4280(29)
	stw 26,720(29)
	stw 6,724(29)
	stw 9,1764(29)
	stw 9,1772(29)
	stw 26,1780(29)
	stw 0,4288(29)
	stw 0,4292(29)
	stw 0,4296(29)
	stw 0,4112(29)
	stw 0,4308(29)
	stw 0,4312(29)
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 InitClientPersistant,.Lfe10-InitClientPersistant
	.section	".rodata"
	.align 2
.LC222:
	.string	"Kevlar Vest"
	.align 2
.LC225:
	.string	"info_player_deathmatch"
	.align 2
.LC224:
	.long 0x47c34f80
	.align 2
.LC226:
	.long 0x4b18967f
	.align 2
.LC227:
	.long 0x3f800000
	.align 3
.LC228:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectRandomDeathmatchSpawnPoint
	.type	 SelectRandomDeathmatchSpawnPoint,@function
SelectRandomDeathmatchSpawnPoint:
	stwu 1,-112(1)
	mflr 0
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 22,40(1)
	stw 0,116(1)
	lis 9,.LC224@ha
	li 28,0
	lfs 29,.LC224@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC225@ha
	b .L584
.L586:
	lis 10,.LC227@ha
	lis 9,maxclients@ha
	la 10,.LC227@l(10)
	lis 11,.LC226@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC226@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L594
	lis 11,.LC228@ha
	lis 26,g_edicts@ha
	la 11,.LC228@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,996
.L589:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L591
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L591
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(11)
	lfs 0,8(30)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(11)
	lfs 0,12(30)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L591
	fmr 31,1
.L591:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,996
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L589
.L594:
	fcmpu 0,31,28
	bc 4,0,.L596
	fmr 28,31
	mr 24,30
	b .L584
.L596:
	fcmpu 0,31,29
	bc 4,0,.L584
	fmr 29,31
	mr 23,30
.L584:
	lis 5,.LC225@ha
	mr 3,30
	la 5,.LC225@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L586
	cmpwi 0,28,0
	bc 4,2,.L600
	li 3,0
	b .L608
.L600:
	cmpwi 0,28,2
	bc 12,1,.L601
	li 23,0
	li 24,0
	b .L602
.L601:
	addi 28,28,-2
.L602:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L607:
	mr 3,30
	li 4,280
	la 5,.LC225@l(22)
	bl G_Find
	mr 30,3
	addi 0,31,1
	xor 9,30,24
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,23
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
	bc 4,2,.L607
.L608:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe11:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe11-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC229:
	.long 0x4b18967f
	.align 2
.LC230:
	.long 0x0
	.align 2
.LC231:
	.long 0x3f800000
	.align 3
.LC232:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectFarthestDeathmatchSpawnPoint
	.type	 SelectFarthestDeathmatchSpawnPoint,@function
SelectFarthestDeathmatchSpawnPoint:
	stwu 1,-96(1)
	mflr 0
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 25,44(1)
	stw 0,100(1)
	lis 9,.LC230@ha
	li 31,0
	la 9,.LC230@l(9)
	li 25,0
	lfs 29,0(9)
	b .L610
.L612:
	lis 9,maxclients@ha
	lis 11,.LC231@ha
	lwz 10,maxclients@l(9)
	la 11,.LC231@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC229@ha
	lfs 31,.LC229@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L620
	lis 9,.LC232@ha
	lis 27,g_edicts@ha
	la 9,.LC232@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,996
.L615:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L617
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L617
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(11)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(11)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L617
	fmr 31,1
.L617:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,996
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L615
.L620:
	fcmpu 0,31,29
	bc 4,1,.L610
	fmr 29,31
	mr 25,31
.L610:
	lis 30,.LC225@ha
	mr 3,31
	li 4,280
	la 5,.LC225@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L612
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L625
	la 5,.LC225@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L625:
	lwz 0,100(1)
	mtlr 0
	lmw 25,44(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe12:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe12-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC233:
	.string	"Warning: failed to find deathmatch spawn point\n"
	.align 2
.LC234:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC235:
	.long 0x0
	.align 2
.LC236:
	.long 0x41100000
	.section	".text"
	.align 2
	.globl SelectSpawnPoint
	.type	 SelectSpawnPoint,@function
SelectSpawnPoint:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	lis 11,.LC235@ha
	lis 9,teamplay@ha
	la 11,.LC235@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 31,0
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L640
	lwz 9,84(3)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L640
	bl SelectTeamplaySpawnPoint
	mr 31,3
	b .L641
.L640:
	lis 11,.LC235@ha
	lis 9,deathmatch@ha
	la 11,.LC235@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L642
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L643
	bl SelectFarthestDeathmatchSpawnPoint
	mr 31,3
	b .L641
.L643:
	bl SelectRandomDeathmatchSpawnPoint
	mr 31,3
	b .L641
.L642:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L641
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xc0ba
	lwz 10,game+1028@l(11)
	ori 9,9,43997
	li 30,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 4,2,.L648
.L673:
	li 31,0
	b .L641
.L648:
	lis 27,.LC21@ha
	lis 28,.LC42@ha
	lis 29,game+1032@ha
.L652:
	mr 3,30
	li 4,280
	la 5,.LC21@l(27)
	bl G_Find
	mr. 30,3
	bc 12,2,.L673
	lwz 4,300(30)
	la 9,.LC42@l(28)
	la 3,game+1032@l(29)
	srawi 11,4,31
	xor 0,11,4
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 4,4,0
	or 4,4,9
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L652
	addic. 31,31,-1
	bc 4,2,.L652
	mr 31,30
.L641:
	cmpwi 0,31,0
	bc 4,2,.L658
	lis 9,.LC235@ha
	lis 11,deathmatch@ha
	la 9,.LC235@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L659
	lis 9,gi+4@ha
	lis 3,.LC233@ha
	lwz 0,gi+4@l(9)
	la 3,.LC233@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L659:
	lis 29,.LC19@ha
	lis 30,game@ha
.L666:
	mr 3,31
	li 4,280
	la 5,.LC19@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L672
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L670
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L661
	b .L666
.L670:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L666
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L666
.L661:
	cmpwi 0,31,0
	bc 4,2,.L658
.L672:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L668
	lis 5,.LC19@ha
	li 3,0
	la 5,.LC19@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L668:
	cmpwi 0,31,0
	bc 4,2,.L658
	lis 9,gi+28@ha
	lis 3,.LC234@ha
	lwz 0,gi+28@l(9)
	la 3,.LC234@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L658:
	lfs 0,4(31)
	lis 9,.LC236@ha
	la 9,.LC236@l(9)
	lfs 12,0(9)
	stfs 0,0(26)
	lfs 13,8(31)
	stfs 13,4(26)
	lfs 0,12(31)
	fadds 0,0,12
	stfs 0,8(26)
	lfs 13,16(31)
	stfs 13,0(25)
	lfs 0,20(31)
	stfs 0,4(25)
	lfs 13,24(31)
	stfs 13,8(25)
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe13:
	.size	 SelectSpawnPoint,.Lfe13-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC237:
	.string	"bodyque"
	.section	".text"
	.align 2
	.globl CopyToBodyQue
	.type	 CopyToBodyQue,@function
CopyToBodyQue:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,maxclients@ha
	lis 11,level@ha
	lwz 10,maxclients@l(9)
	la 11,level@l(11)
	lwz 8,296(11)
	lis 26,gi@ha
	mr 28,3
	lfs 0,20(10)
	la 26,gi@l(26)
	addi 9,8,1
	lwz 10,76(26)
	lis 25,g_edicts@ha
	srawi 0,9,31
	lwz 24,g_edicts@l(25)
	srwi 0,0,29
	mtlr 10
	add 0,9,0
	rlwinm 0,0,0,0,28
	fctiwz 13,0
	subf 9,0,9
	stw 9,296(11)
	stfd 13,8(1)
	lwz 27,12(1)
	add 27,27,8
	mulli 27,27,996
	addi 27,27,996
	blrl
	add 29,24,27
	lwz 9,76(26)
	mr 3,29
	mtlr 9
	blrl
	mr 4,28
	li 5,84
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lwz 0,g_edicts@l(25)
	lis 9,0xe64
	li 10,0
	ori 9,9,49481
	li 8,7
	subf 0,0,29
	lis 11,body_die@ha
	mullw 0,0,9
	la 11,body_die@l(11)
	li 7,1
	mr 3,29
	srawi 0,0,2
	stwx 0,24,27
	lwz 9,184(28)
	stw 9,184(29)
	lfs 0,188(28)
	stfs 0,188(29)
	lfs 13,192(28)
	stfs 13,192(29)
	lfs 0,196(28)
	stfs 0,196(29)
	lfs 13,200(28)
	stfs 13,200(29)
	lfs 0,204(28)
	stfs 0,204(29)
	lfs 13,208(28)
	stfs 13,208(29)
	lfs 0,212(28)
	stfs 0,212(29)
	lfs 13,216(28)
	stfs 13,216(29)
	lfs 0,220(28)
	stfs 0,220(29)
	lfs 13,224(28)
	stfs 13,224(29)
	lfs 0,228(28)
	stfs 0,228(29)
	lfs 13,232(28)
	stfs 13,232(29)
	lfs 0,236(28)
	stfs 0,236(29)
	lfs 13,240(28)
	stfs 13,240(29)
	lfs 0,244(28)
	stfs 0,244(29)
	stw 10,248(29)
	lwz 0,252(28)
	stw 0,252(29)
	lwz 9,256(28)
	stw 8,260(29)
	stw 9,256(29)
	lfs 0,376(28)
	stfs 0,376(29)
	lfs 13,380(28)
	stfs 13,380(29)
	lfs 0,384(28)
	stfs 0,384(29)
	lwz 0,400(28)
	stw 10,68(29)
	stw 0,400(29)
	stw 11,456(29)
	stw 7,512(29)
	stw 10,552(29)
	lwz 0,72(26)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 CopyToBodyQue,.Lfe14-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC238:
	.string	"menu_loadgame\n"
	.align 2
.LC239:
	.string	"M26 Fragmentation Grenade"
	.align 2
.LC240:
	.long 0x0
	.section	".text"
	.align 2
	.globl AllWeapons
	.type	 AllWeapons,@function
AllWeapons:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,game@ha
	li 31,0
	la 9,game@l(9)
	mr 30,3
	lwz 0,1556(9)
	cmpw 0,31,0
	bc 4,0,.L696
	mr 7,9
	li 8,1
	lis 9,itemlist@ha
	li 11,0
	la 10,itemlist@l(9)
.L698:
	mr 4,10
	lwz 0,4(4)
	cmpwi 0,0,0
	bc 12,2,.L697
	lwz 0,56(4)
	andi. 9,0,1
	bc 12,2,.L697
	lwz 9,84(30)
	addi 9,9,740
	stwx 8,9,11
.L697:
	lwz 0,1556(7)
	addi 31,31,1
	addi 11,11,4
	addi 10,10,72
	cmpw 0,31,0
	bc 12,0,.L698
.L696:
	lis 9,game@ha
	li 31,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,31,0
	bc 4,0,.L703
	lis 9,itemlist@ha
	mr 28,11
	la 29,itemlist@l(9)
.L705:
	mr 4,29
	lwz 0,4(4)
	cmpwi 0,0,0
	bc 12,2,.L704
	lwz 0,56(4)
	andi. 10,0,2
	bc 12,2,.L704
	mr 3,30
	li 5,1000
	bl Add_Ammo
.L704:
	lwz 0,1556(28)
	addi 31,31,1
	addi 29,29,72
	cmpw 0,31,0
	bc 12,0,.L705
.L703:
	lwz 11,84(30)
	lis 10,.LC240@ha
	lis 9,tgren@ha
	la 10,.LC240@l(10)
	lwz 0,4220(11)
	lfs 13,0(10)
	lwz 10,tgren@l(9)
	stw 0,4224(11)
	lwz 9,84(30)
	lwz 0,4228(9)
	stw 0,4232(9)
	lwz 11,84(30)
	lwz 0,4252(11)
	stw 0,4256(11)
	lwz 9,84(30)
	lwz 0,4260(9)
	stw 0,4264(9)
	lwz 11,84(30)
	lwz 0,4236(11)
	stw 0,4240(11)
	lwz 9,84(30)
	lwz 0,4244(9)
	stw 0,4248(9)
	lwz 11,84(30)
	lwz 0,4268(11)
	stw 0,4272(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L709
	lis 3,.LC239@ha
	la 3,.LC239@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	li 9,0
	srawi 3,3,3
	slwi 3,3,2
	stwx 9,11,3
.L709:
	lis 3,.LC201@ha
	la 3,.LC201@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	li 9,10
	srawi 3,3,3
	slwi 3,3,2
	stwx 9,11,3
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 AllWeapons,.Lfe15-AllWeapons
	.section	".rodata"
	.align 2
.LC241:
	.string	"Bandolier"
	.align 2
.LC242:
	.string	"Pistol Clip"
	.align 2
.LC243:
	.string	"Machinegun Magazine"
	.align 2
.LC244:
	.string	"M4 Clip"
	.align 2
.LC245:
	.string	"12 Gauge Shells"
	.align 2
.LC246:
	.string	"AP Sniper Ammo"
	.align 2
.LC247:
	.long 0x0
	.section	".text"
	.align 2
	.globl EquipClient
	.type	 EquipClient,@function
EquipClient:
	stwu 1,-1056(1)
	mflr 0
	mfcr 12
	stmw 25,1028(1)
	stw 0,1060(1)
	stw 12,1024(1)
	mr 25,3
	li 27,0
	lwz 31,84(25)
	lwz 9,3480(31)
	cmpwi 0,9,0
	bc 12,2,.L719
	lwz 0,3484(31)
	cmpwi 0,0,0
	bc 12,2,.L719
	lwz 3,40(9)
	lis 4,.LC241@ha
	lis 28,itemlist@ha
	la 4,.LC241@l(4)
	addi 29,31,740
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L722
	lis 9,.LC247@ha
	lis 30,tgren@ha
	la 9,.LC247@l(9)
	li 27,1
	lfs 13,0(9)
	lwz 9,tgren@l(30)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,1,.L722
	lis 3,.LC239@ha
	la 3,.LC239@l(3)
	bl FindItem
	lwz 11,tgren@l(30)
	la 9,itemlist@l(28)
	lis 0,0x38e3
	subf 3,9,3
	ori 0,0,36409
	lfs 0,20(11)
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	fctiwz 13,0
	stfd 13,1016(1)
	lwz 9,1020(1)
	stwx 9,29,3
.L722:
	lis 3,.LC242@ha
	cmpwi 4,27,0
	la 3,.LC242@l(3)
	bl FindItem
	mr 8,3
	bc 12,18,.L724
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	li 11,2
	b .L753
.L724:
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,8
	li 11,1
.L753:
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	stwx 11,29,9
	lwz 9,3484(31)
	lis 30,.LC196@ha
	la 4,.LC196@l(30)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L726
	la 3,.LC196@l(30)
	li 27,1
	bl FindItem
	lis 30,0x38e3
	lis 9,itemlist@ha
	mr 8,3
	la 28,itemlist@l(9)
	ori 30,30,36409
	subf 0,28,8
	lis 3,.LC243@ha
	mullw 0,0,30
	la 3,.LC243@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(31)
	stwx 27,29,9
	stw 8,1788(31)
	stw 27,4284(31)
	stw 27,4308(31)
	bl FindItem
	mr 8,3
	bc 12,18,.L727
	subf 0,28,8
	li 9,2
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,29,0
	b .L728
.L727:
	subf 0,28,8
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,29,0
.L728:
	lwz 0,4252(31)
	stw 0,4256(31)
	b .L729
.L726:
	lwz 9,3484(31)
	lis 30,.LC197@ha
	la 4,.LC197@l(30)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L730
	la 3,.LC197@l(30)
	li 27,1
	bl FindItem
	lis 30,0x38e3
	li 26,2
	lis 9,itemlist@ha
	mr 8,3
	la 28,itemlist@l(9)
	ori 30,30,36409
	subf 0,28,8
	lis 3,.LC244@ha
	mullw 0,0,30
	la 3,.LC244@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(31)
	stwx 27,29,9
	stw 8,1788(31)
	stw 26,4284(31)
	stw 27,4308(31)
	bl FindItem
	mr 8,3
	bc 12,18,.L731
	subf 0,28,8
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	stwx 26,29,0
	b .L732
.L731:
	subf 0,28,8
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,29,0
.L732:
	lwz 0,4260(31)
	stw 0,4264(31)
	b .L729
.L730:
	lwz 9,3484(31)
	lis 30,.LC198@ha
	la 4,.LC198@l(30)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L734
	la 3,.LC198@l(30)
	bl FindItem
	lis 30,0x38e3
	lis 9,itemlist@ha
	mr 8,3
	la 28,itemlist@l(9)
	ori 30,30,36409
	subf 0,28,8
	li 11,1
	mullw 0,0,30
	li 10,3
	lis 3,.LC245@ha
	la 3,.LC245@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(31)
	stwx 11,29,9
	stw 8,1788(31)
	stw 10,4284(31)
	stw 11,4308(31)
	bl FindItem
	mr 8,3
	bc 12,18,.L735
	subf 0,28,8
	li 9,14
	b .L754
.L735:
	subf 0,28,8
	li 9,7
.L754:
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,29,0
	lwz 0,4236(31)
	stw 0,4240(31)
	b .L729
.L734:
	lwz 9,3484(31)
	lis 30,.LC199@ha
	la 4,.LC199@l(30)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L738
	la 3,.LC199@l(30)
	bl FindItem
	lis 30,0x38e3
	lis 9,itemlist@ha
	mr 8,3
	la 28,itemlist@l(9)
	ori 30,30,36409
	subf 0,28,8
	li 11,1
	mullw 0,0,30
	li 10,4
	lis 3,.LC245@ha
	la 3,.LC245@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(31)
	stwx 11,29,9
	stw 8,1788(31)
	stw 10,4284(31)
	stw 11,4308(31)
	bl FindItem
	mr 8,3
	bc 12,18,.L739
	subf 0,28,8
	li 9,24
	b .L755
.L739:
	subf 0,28,8
	li 9,12
.L755:
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,29,0
	lwz 0,4268(31)
	stw 0,4272(31)
	b .L729
.L738:
	lwz 9,3484(31)
	lis 30,.LC200@ha
	la 4,.LC200@l(30)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L742
	la 3,.LC200@l(30)
	bl FindItem
	lis 30,0x38e3
	lis 9,itemlist@ha
	ori 30,30,36409
	la 28,itemlist@l(9)
	li 10,1
	subf 0,28,3
	lis 11,.LC246@ha
	mullw 0,0,30
	la 3,.LC246@l(11)
	srawi 0,0,3
	slwi 0,0,2
	stwx 10,29,0
	stw 10,4308(31)
	bl FindItem
	mr 8,3
	bc 12,18,.L743
	subf 0,28,8
	li 9,20
	b .L756
.L743:
	subf 0,28,8
	li 9,10
.L756:
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,29,0
	lwz 0,4244(31)
	stw 0,4248(31)
	b .L729
.L742:
	lwz 9,3484(31)
	lis 30,.LC193@ha
	la 4,.LC193@l(30)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L746
	la 3,.LC193@l(30)
	bl FindItem
	lis 30,0x38e3
	lis 9,itemlist@ha
	mr 8,3
	la 28,itemlist@l(9)
	ori 30,30,36409
	subf 0,28,8
	li 11,1
	mullw 0,0,30
	li 10,6
	lis 3,.LC242@ha
	la 3,.LC242@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(31)
	stwx 11,29,9
	stw 8,1788(31)
	stw 10,4284(31)
	bl FindItem
	mr 8,3
	bc 12,18,.L747
	subf 0,28,8
	li 9,4
	b .L757
.L747:
	subf 0,28,8
	li 9,2
.L757:
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,29,0
	lwz 0,4228(31)
	stw 0,4232(31)
	b .L729
.L746:
	lwz 9,3484(31)
	lis 30,.LC201@ha
	la 4,.LC201@l(30)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L729
	la 3,.LC201@l(30)
	bl FindItem
	lis 9,itemlist@ha
	mr 8,3
	la 9,itemlist@l(9)
	lis 0,0x38e3
	subf 9,9,8
	ori 0,0,36409
	mullw 9,9,0
	srawi 9,9,3
	stw 9,736(31)
	bc 12,18,.L751
	slwi 9,9,2
	li 0,20
	b .L758
.L751:
	slwi 9,9,2
	li 0,10
.L758:
	stwx 0,29,9
	li 0,7
	stw 8,1788(31)
	stw 0,4284(31)
.L729:
	lwz 0,3480(31)
	mr 4,25
	addi 3,1,8
	stw 0,656(1)
	bl Pickup_Special
.L719:
	lwz 0,1060(1)
	lwz 12,1024(1)
	mtlr 0
	lmw 25,1028(1)
	mtcrf 8,12
	la 1,1056(1)
	blr
.Lfe16:
	.size	 EquipClient,.Lfe16-EquipClient
	.section	".rodata"
	.align 2
.LC248:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC249:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC250:
	.string	"player"
	.align 2
.LC251:
	.string	"players/male/tris.md2"
	.align 2
.LC252:
	.string	"fov"
	.align 2
.LC253:
	.long 0x0
	.align 2
.LC254:
	.long 0x41400000
	.align 2
.LC255:
	.long 0x41000000
	.align 3
.LC256:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC257:
	.long 0x3f800000
	.align 2
.LC258:
	.long 0x43200000
	.align 2
.LC259:
	.long 0x47800000
	.align 2
.LC260:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-6016(1)
	mflr 0
	stfd 30,6000(1)
	stfd 31,6008(1)
	stmw 16,5936(1)
	stw 0,6020(1)
	lis 9,.LC248@ha
	lis 8,.LC249@ha
	lwz 0,.LC248@l(9)
	la 29,.LC249@l(8)
	addi 10,1,8
	la 9,.LC248@l(9)
	lwz 11,.LC249@l(8)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 17,5
	stw 0,8(1)
	addi 4,1,40
	stw 28,8(10)
	stw 6,4(10)
	lwz 0,8(29)
	lwz 9,4(29)
	stw 11,24(1)
	stw 0,8(7)
	stw 9,4(7)
	bl SelectSpawnPoint
	lis 9,deathmatch@ha
	lis 8,.LC253@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	la 8,.LC253@l(8)
	lis 11,g_edicts@ha
	lfs 13,0(8)
	lis 0,0xe64
	lfs 0,20(10)
	ori 0,0,49481
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,2
	addi 25,9,-1
	bc 12,2,.L760
	addi 28,1,1704
	addi 27,30,1812
	mulli 22,25,4564
	addi 26,1,3896
	mr 4,27
	li 5,2072
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 18,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 23,29
	crxor 6,6,6
	bl memcpy
	mr 24,27
	addi 25,30,4464
	addi 29,1,72
	mr 3,30
	bl InitClientPersistant
	lis 16,teamplay@ha
	addi 19,30,20
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L811
.L760:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L762
	addi 27,1,1704
	addi 26,30,1812
	mulli 22,25,4564
	addi 29,1,4408
	mr 4,26
	li 5,2072
	mr 3,27
	crxor 6,6,6
	bl memcpy
	addi 28,30,188
	mr 20,29
	mr 3,29
	mr 4,28
	li 5,512
	mr 18,27
	crxor 6,6,6
	bl memcpy
	mr 24,26
	mr 23,28
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	addi 29,1,72
	addi 25,30,4464
	addi 9,9,56
	lis 16,teamplay@ha
	addi 19,30,20
	addi 21,30,3444
	addi 10,1,2256
	addi 11,30,740
.L810:
	lwz 0,0(9)
	addi 9,9,72
	andi. 8,0,16
	bc 12,2,.L765
	lwz 0,0(11)
	stw 0,0(10)
.L765:
	addi 10,10,4
	addi 11,11,4
	bdnz .L810
	mr 4,18
	li 5,1624
	mr 3,23
	crxor 6,6,6
	bl memcpy
	mr 4,20
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3332(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L761
	stw 9,1800(30)
	b .L761
.L762:
	addi 29,1,1704
	li 4,0
	mulli 22,25,4564
	mr 3,29
	li 5,2072
	crxor 6,6,6
	bl memset
	mr 18,29
	addi 24,30,1812
	addi 23,30,188
	addi 29,1,72
	addi 25,30,4464
	lis 16,teamplay@ha
	addi 19,30,20
.L811:
	addi 21,30,3444
.L761:
	cmpwi 0,25,0
	mr 3,29
	mr 4,23
	li 5,1624
	mfcr 26
	crxor 6,6,6
	bl memcpy
	lwz 28,4452(30)
	lwz 27,4448(30)
	mtcrf 128,26
	bc 12,2,.L771
	addi 3,1,3784
	mr 4,25
	li 5,99
	bl strncpy
.L771:
	li 4,0
	li 5,4564
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,23
	li 5,1624
	crxor 6,6,6
	bl memcpy
	stw 28,4452(30)
	mtcrf 128,26
	stw 27,4448(30)
	bc 12,2,.L772
	mr 3,25
	addi 4,1,3784
	li 5,100
	bl strncpy
.L772:
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L773
	mr 3,30
	bl InitClientPersistant
.L773:
	mr 3,24
	mr 4,18
	li 5,2072
	crxor 6,6,6
	bl memcpy
	lwz 11,84(31)
	lwz 0,724(11)
	stw 0,480(31)
	lwz 9,728(11)
	stw 9,484(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L774
	lwz 0,264(31)
	ori 0,0,4096
	stw 0,264(31)
.L774:
	lis 9,coop@ha
	lis 8,.LC253@ha
	lwz 11,coop@l(9)
	la 8,.LC253@l(8)
	lfs 12,0(8)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L776
	lwz 9,84(31)
	lwz 0,1800(9)
	stw 0,3440(9)
.L776:
	li 7,0
	lis 11,game+1028@ha
	lwz 4,264(31)
	stw 7,552(31)
	lis 9,.LC250@ha
	li 5,2
	lwz 8,game+1028@l(11)
	la 9,.LC250@l(9)
	li 0,4
	li 11,22
	li 10,1
	stw 0,260(31)
	stw 11,508(31)
	add 26,8,22
	li 6,200
	lis 11,.LC254@ha
	stw 10,88(31)
	lis 8,level+4@ha
	stw 9,280(31)
	la 11,.LC254@l(11)
	rlwinm 27,4,0,21,19
	stw 6,400(31)
	lis 0,0x201
	lis 9,.LC251@ha
	stw 5,248(31)
	lis 10,player_pain@ha
	lis 6,teamplay@ha
	stw 5,512(31)
	la 9,.LC251@l(9)
	la 10,player_pain@l(10)
	stw 26,84(31)
	ori 0,0,3
	li 5,-1
	stw 7,492(31)
	lfs 0,level+4@l(8)
	lfs 13,0(11)
	lwz 3,184(31)
	lis 11,player_die@ha
	lwz 4,teamplay@l(6)
	la 11,player_die@l(11)
	fadds 0,0,13
	rlwinm 8,3,0,31,29
	stw 0,252(31)
	stw 9,268(31)
	stw 10,452(31)
	stfs 0,404(31)
	stw 11,456(31)
	stw 8,184(31)
	stw 5,976(31)
	stw 7,908(31)
	stw 7,612(31)
	stw 7,608(31)
	stw 27,264(31)
	stw 7,904(31)
	lfs 0,20(4)
	fcmpu 0,0,12
	bc 12,2,.L778
	lwz 0,3488(26)
	cmpwi 0,0,0
	bc 12,2,.L777
.L778:
	rlwinm 0,27,0,28,26
	rlwinm 9,3,0,0,29
	stw 0,264(31)
	stw 9,184(31)
.L777:
	lis 8,.LC253@ha
	lfs 10,12(1)
	li 4,0
	la 8,.LC253@l(8)
	lfs 0,16(1)
	li 5,184
	lfs 13,24(1)
	lfs 12,28(1)
	lfs 11,32(1)
	lfs 9,8(1)
	lfs 31,0(8)
	lwz 3,84(31)
	stfs 10,192(31)
	stfs 0,196(31)
	stfs 13,200(31)
	stfs 12,204(31)
	stfs 11,208(31)
	stfs 9,188(31)
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 8,.LC255@ha
	lfs 0,40(1)
	la 8,.LC255@l(8)
	mr 10,11
	lfs 10,0(8)
	lis 9,deathmatch@ha
	mr 8,11
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,5928(1)
	lwz 11,5932(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,5928(1)
	lwz 10,5932(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,5928(1)
	lwz 8,5932(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L779
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,5928(1)
	lwz 11,5932(1)
	andi. 9,11,32768
	bc 4,2,.L812
.L779:
	lis 4,.LC252@ha
	mr 3,23
	la 4,.LC252@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,5932(1)
	lis 0,0x4330
	lis 8,.LC256@ha
	la 8,.LC256@l(8)
	stw 0,5928(1)
	lis 11,.LC257@ha
	lfd 13,0(8)
	la 11,.LC257@l(11)
	lfd 0,5928(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L781
.L812:
	lis 0,0x42b4
	stw 0,112(30)
	b .L780
.L781:
	lis 8,.LC258@ha
	la 8,.LC258@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L780
	stfs 13,112(30)
.L780:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	li 29,0
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 10,g_edicts@ha
	lis 11,0xe64
	stw 3,88(30)
	lwz 9,g_edicts@l(10)
	ori 11,11,49481
	li 0,255
	stw 0,40(31)
	mr 3,31
	subf 9,9,31
	stw 29,64(31)
	mullw 9,9,11
	srawi 9,9,2
	addi 9,9,-1
	stw 9,60(31)
	bl ShowGun
	lis 9,.LC259@ha
	lfs 13,48(1)
	li 0,3
	la 9,.LC259@l(9)
	lfs 11,40(1)
	lis 11,.LC260@ha
	mtctr 0
	lfs 9,0(9)
	la 11,.LC260@l(11)
	mr 5,17
	lis 9,.LC257@ha
	lfs 12,44(1)
	mr 8,21
	la 9,.LC257@l(9)
	lfs 10,0(11)
	mr 10,19
	lfs 0,0(9)
	li 11,0
	stw 29,56(31)
	stfs 11,28(31)
	fadds 13,13,0
	stfs 12,32(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 13,36(31)
	stfs 13,12(31)
.L809:
	lfsx 0,11,5
	lfsx 12,11,8
	addi 11,11,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,5928(1)
	lwz 9,5932(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L809
	lis 8,.LC253@ha
	lfs 0,60(1)
	lis 9,teamplay@ha
	la 8,.LC253@l(8)
	lwz 11,teamplay@l(9)
	lfs 12,0(8)
	stfs 0,20(31)
	stfs 12,24(31)
	stfs 12,16(31)
	stfs 12,28(30)
	lfs 13,20(31)
	stfs 13,32(30)
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,4060(30)
	lfs 0,20(31)
	stfs 0,4064(30)
	lfs 13,24(31)
	stfs 13,4068(30)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L789
	mr 3,31
	bl StartClient
	b .L790
.L789:
	lwz 10,84(31)
	lwz 3,1804(10)
	cmpwi 0,3,0
	bc 12,2,.L808
	lwz 9,184(31)
	li 11,0
	li 0,1
	stw 0,260(31)
	ori 9,9,1
	stw 11,248(31)
	stw 9,184(31)
	stw 11,3488(10)
	lwz 9,84(31)
	stw 11,88(9)
.L790:
	cmpwi 0,3,0
	mfcr 29
	bc 4,2,.L792
.L808:
	lis 9,teamplay@ha
	lis 8,.LC253@ha
	lwz 11,teamplay@l(9)
	cmpwi 0,3,0
	la 8,.LC253@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	mfcr 29
	fcmpu 0,0,13
	bc 4,2,.L792
	mr 3,31
	bl KillBox
.L792:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,30
	li 11,12
	li 7,24
	li 6,2
	stw 0,4252(30)
	li 9,7
	li 10,6
	stw 7,4228(30)
	li 8,10
	li 0,0
	stw 9,4236(30)
	stw 10,4244(30)
	li 9,90
	mtcrf 128,29
	stw 11,4232(30)
	lis 10,0x42b4
	stw 8,4276(30)
	stw 6,4280(30)
	stw 11,4220(30)
	stw 7,4260(30)
	stw 6,4268(30)
	stw 11,4224(30)
	stw 0,892(31)
	stw 9,4304(30)
	stw 10,112(30)
	stw 0,4424(30)
	stw 0,3464(30)
	stw 0,4328(30)
	stw 0,4332(30)
	stw 0,4340(30)
	stw 0,4336(30)
	stw 0,4300(30)
	stw 0,4316(30)
	stw 0,4324(30)
	stw 0,4320(30)
	stw 0,4396(30)
	stw 0,4392(30)
	stw 0,4420(30)
	bc 4,2,.L759
	lis 11,allitem@ha
	lis 8,.LC253@ha
	lwz 9,allitem@l(11)
	la 8,.LC253@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L794
	lis 9,game@ha
	li 28,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,28,0
	bc 4,0,.L794
	lis 9,itemlist@ha
	mr 25,11
	la 29,itemlist@l(9)
	lis 11,.LC257@ha
	lis 9,.LC256@ha
	la 11,.LC257@l(11)
	la 9,.LC256@l(9)
	lfs 30,0(11)
	lis 26,0x4330
	lfd 31,0(9)
	lis 27,unique_items@ha
.L797:
	lwz 0,4(29)
	cmpwi 0,0,0
	bc 12,2,.L799
	lwz 0,56(29)
	andi. 8,0,64
	bc 12,2,.L799
	lwz 10,84(31)
	stw 29,5568(1)
	lwz 0,4312(10)
	lwz 11,unique_items@l(27)
	xoris 0,0,0x8000
	stw 0,5932(1)
	stw 26,5928(1)
	lfd 0,5928(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L801
	fsubs 0,13,30
	fctiwz 13,0
	stfd 13,5928(1)
	lwz 9,5932(1)
	stw 9,4312(10)
.L801:
	addi 3,1,4920
	mr 4,31
	bl Pickup_Special
.L799:
	lwz 0,1556(25)
	addi 28,28,1
	addi 29,29,72
	cmpw 0,28,0
	bc 12,0,.L797
.L794:
	lis 9,teamplay@ha
	lis 8,.LC253@ha
	lwz 11,teamplay@l(9)
	la 8,.LC253@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L804
	mr 3,31
	bl EquipClient
.L804:
	lwz 9,84(31)
	lwz 0,4432(9)
	cmpwi 0,0,0
	bc 12,2,.L805
	mr 3,31
	bl PMenu_Close
	b .L759
.L805:
	lis 9,allweapon@ha
	lwz 11,allweapon@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L806
	mr 3,31
	bl AllWeapons
.L806:
	lwz 0,1788(30)
	mr 3,31
	stw 0,3956(30)
	bl ChangeWeapon
	lwz 9,teamplay@l(16)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L759
	li 0,1
	lis 9,gi+72@ha
	stw 0,248(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L759:
	lwz 0,6020(1)
	mtlr 0
	lmw 16,5936(1)
	lfd 30,6000(1)
	lfd 31,6008(1)
	la 1,6016(1)
	blr
.Lfe17:
	.size	 PutClientInServer,.Lfe17-PutClientInServer
	.section	".rodata"
	.align 2
.LC261:
	.string	"%s entered the game\n"
	.align 2
.LC262:
	.string	"%s became a spectator\n"
	.align 2
.LC263:
	.string	"\n======================================\nL.T.K. AQ2 Mod\n\n'sv addbot' to add a new bot.\n'sv removebot <name>' to remove bot.\n======================================\n\n"
	.align 2
.LC264:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	bl G_InitEdict
	lwz 28,84(31)
	li 4,0
	li 5,2072
	addi 29,28,1812
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 27,level@ha
	addi 4,28,188
	lwz 0,level@l(27)
	li 5,1624
	mr 3,29
	la 27,level@l(27)
	stw 0,3436(28)
	crxor 6,6,6
	bl memcpy
	lis 3,.LC196@ha
	la 3,.LC196@l(3)
	bl FindItem
	stw 3,3484(28)
	lis 3,.LC222@ha
	la 3,.LC222@l(3)
	bl FindItem
	li 0,1
	stw 3,3480(28)
	stw 0,3868(28)
	mr 3,31
	bl ACEIT_PlayerAdded
	mr 3,31
	bl PutClientInServer
	lis 9,.LC264@ha
	lfs 0,200(27)
	la 9,.LC264@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L815
	mr 3,31
	bl MoveClientToIntermission
	b .L816
.L815:
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L816
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xe64
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49481
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L816:
	lwz 5,84(31)
	lis 4,.LC261@ha
	li 3,2
	la 4,.LC261@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lis 9,.LC264@ha
	la 9,.LC264@l(9)
	lfs 13,0(9)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L818
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L818
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L818
	lwz 5,84(31)
	lis 4,.LC262@ha
	li 3,2
	la 4,.LC262@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L818:
	mr 3,31
	lis 28,level+72@ha
	bl PrintMOTD
	lis 29,current_map@ha
	lwz 9,84(31)
	li 0,1
	lis 4,.LC263@ha
	la 4,.LC263@l(4)
	mr 3,31
	stw 0,3832(9)
	crxor 6,6,6
	bl safe_centerprintf
	la 3,level+72@l(28)
	la 4,current_map@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L819
	bl ACEND_InitNodes
	bl ACEND_LoadNodes
	bl ACESP_LoadBotConfig
	la 3,current_map@l(29)
	la 4,level+72@l(28)
	bl strcpy
.L819:
	mr 3,31
	bl ClientEndServerFrame
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 ClientBeginDeathmatch,.Lfe18-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC265:
	.long 0x0
	.align 2
.LC266:
	.long 0x47800000
	.align 2
.LC267:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,g_edicts@ha
	mr 31,3
	lwz 9,g_edicts@l(11)
	lis 0,0xe64
	lis 10,deathmatch@ha
	ori 0,0,49481
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC265@ha
	srawi 9,9,2
	la 10,.LC265@l(10)
	mulli 9,9,4564
	lfs 13,0(10)
	addi 9,9,-4564
	add 8,8,9
	stw 8,84(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L821
	bl ClientBeginDeathmatch
	b .L820
.L821:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L822
	lis 9,.LC266@ha
	lis 10,.LC267@ha
	li 11,3
	la 9,.LC266@l(9)
	la 10,.LC267@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L834:
	lwz 10,84(31)
	add 0,8,8
	addi 8,8,1
	addi 9,10,28
	lfsx 0,9,7
	addi 10,10,20
	addi 7,7,4
	fmuls 0,0,11
	fdivs 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	sthx 11,10,0
	bdnz .L834
	b .L828
.L822:
	mr 3,31
	bl G_InitEdict
	lwz 28,84(31)
	lis 9,.LC250@ha
	li 4,0
	la 9,.LC250@l(9)
	li 5,2072
	addi 29,28,1812
	stw 9,280(31)
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	addi 4,28,188
	lwz 0,level@l(9)
	li 5,1624
	mr 3,29
	stw 0,3436(28)
	crxor 6,6,6
	bl memcpy
	lis 3,.LC196@ha
	la 3,.LC196@l(3)
	bl FindItem
	stw 3,3484(28)
	lis 3,.LC222@ha
	la 3,.LC222@l(3)
	bl FindItem
	stw 3,3480(28)
	li 0,1
	stw 0,3868(28)
	mr 3,31
	bl PutClientInServer
.L828:
	lis 10,.LC265@ha
	lis 9,level+200@ha
	la 10,.LC265@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L830
	mr 3,31
	bl MoveClientToIntermission
	b .L831
.L830:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L831
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L833
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xe64
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49481
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L833:
	lwz 5,84(31)
	lis 4,.LC261@ha
	li 3,2
	la 4,.LC261@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L831:
	mr 3,31
	bl ClientEndServerFrame
.L820:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 ClientBegin,.Lfe19-ClientBegin
	.section	".rodata"
	.align 2
.LC268:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC269:
	.string	"name"
	.align 2
.LC270:
	.string	"spectator"
	.align 2
.LC271:
	.string	"0"
	.align 2
.LC272:
	.string	"rate"
	.align 2
.LC273:
	.string	"skin"
	.align 2
.LC274:
	.string	"%s\\%s"
	.align 2
.LC275:
	.string	"hand"
	.align 2
.LC276:
	.string	"classic high"
	.align 2
.LC277:
	.string	"classic"
	.align 2
.LC278:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientUserinfoChanged
	.type	 ClientUserinfoChanged,@function
ClientUserinfoChanged:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,4
	mr 27,3
	mr 3,30
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L836
	lis 11,.LC268@ha
	lwz 0,.LC268@l(11)
	la 9,.LC268@l(11)
	lwz 10,4(9)
	lwz 11,8(9)
	lwz 8,12(9)
	stw 0,0(30)
	stw 10,4(30)
	stw 11,8(30)
	stw 8,12(30)
	lhz 7,28(9)
	lwz 0,16(9)
	lwz 11,20(9)
	lwz 10,24(9)
	stw 0,16(30)
	stw 11,20(30)
	stw 10,24(30)
	sth 7,28(30)
.L836:
	lis 4,.LC269@ha
	mr 3,30
	la 4,.LC269@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC270@ha
	mr 3,30
	la 4,.LC270@l(4)
	bl Info_ValueForKey
	lis 4,.LC271@ha
	lwz 29,84(27)
	la 4,.LC271@l(4)
	bl strcmp
	addic 9,3,-1
	subfe 0,9,3
	lis 4,.LC272@ha
	stw 0,1804(29)
	la 4,.LC272@l(4)
	mr 3,30
	bl Info_ValueForKey
	bl atoi
	lwz 9,84(27)
	lis 4,.LC273@ha
	la 4,.LC273@l(4)
	stw 3,3916(9)
	mr 3,30
	bl Info_ValueForKey
	lis 9,teamplay@ha
	lis 11,g_edicts@ha
	lwz 10,teamplay@l(9)
	mr 31,3
	lis 9,.LC278@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC278@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,27
	lis 9,0xe64
	ori 9,9,49481
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,2
	bc 12,2,.L837
	mr 4,31
	mr 3,27
	bl AssignSkin
	b .L838
.L837:
	lwz 4,84(27)
	lis 29,gi@ha
	lis 3,.LC274@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC274@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L838:
	lwz 9,84(27)
	li 0,0
	lis 4,.LC275@ha
	la 4,.LC275@l(4)
	mr 3,30
	stw 0,1808(9)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L839
	mr 3,31
	bl atoi
	lwz 9,84(27)
	lis 4,.LC276@ha
	la 4,.LC276@l(4)
	stw 3,716(9)
	mr 3,31
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L840
	lwz 9,84(27)
	li 0,2
	b .L843
.L840:
	lis 4,.LC277@ha
	mr 3,31
	la 4,.LC277@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L839
	lwz 9,84(27)
	li 0,1
.L843:
	stw 0,1808(9)
.L839:
	lwz 3,84(27)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
	mr 3,27
	bl ShowGun
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 ClientUserinfoChanged,.Lfe20-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC279:
	.string	"ip"
	.align 2
.LC280:
	.string	"ipaddr_buf length exceeded\n"
	.align 2
.LC281:
	.string	"rejmsg"
	.align 2
.LC282:
	.string	"Banned."
	.align 2
.LC283:
	.string	"password"
	.align 2
.LC284:
	.string	"none"
	.align 2
.LC285:
	.string	"Password required or incorrect."
	.align 2
.LC286:
	.string	"%s@%s connected\n"
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-144(1)
	mflr 0
	stmw 27,124(1)
	stw 0,148(1)
	mr 30,4
	mr 31,3
	lis 4,.LC279@ha
	mr 3,30
	la 4,.LC279@l(4)
	bl Info_ValueForKey
	mr 29,3
	bl strlen
	cmplwi 0,3,99
	bc 4,1,.L845
	lis 9,gi+4@ha
	lis 3,.LC280@ha
	lwz 0,gi+4@l(9)
	la 3,.LC280@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L845:
	mr 4,29
	li 5,99
	addi 3,1,8
	bl strncpy
	li 0,0
	mr 3,29
	stb 0,107(1)
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L846
	lis 4,.LC281@ha
	lis 5,.LC282@ha
	mr 3,30
	la 4,.LC281@l(4)
	la 5,.LC282@l(5)
	b .L854
.L846:
	lis 4,.LC283@ha
	mr 3,30
	la 4,.LC283@l(4)
	lis 28,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(28)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L847
	lis 4,.LC284@ha
	la 4,.LC284@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L847
	lwz 9,password@l(28)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L847
	lis 4,.LC281@ha
	lis 5,.LC285@ha
	mr 3,30
	la 4,.LC281@l(4)
	la 5,.LC285@l(5)
.L854:
	bl Info_SetValueForKey
	li 3,0
	b .L853
.L847:
	lis 11,g_edicts@ha
	lis 0,0xe64
	lwz 9,g_edicts@l(11)
	ori 0,0,49481
	li 10,0
	lis 11,game@ha
	subf 9,9,31
	la 27,game@l(11)
	mullw 9,9,0
	lwz 11,1028(27)
	srawi 9,9,2
	mulli 9,9,4564
	addi 9,9,-4564
	add 11,11,9
	stw 11,84(31)
	stw 10,4448(11)
	lwz 9,84(31)
	stw 10,4452(9)
	lwz 11,84(31)
	stw 10,4456(11)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L848
	lwz 28,84(31)
	li 4,0
	li 5,2072
	addi 29,28,1812
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	addi 4,28,188
	lwz 0,level@l(9)
	li 5,1624
	mr 3,29
	stw 0,3436(28)
	crxor 6,6,6
	bl memcpy
	lis 3,.LC196@ha
	la 3,.LC196@l(3)
	bl FindItem
	stw 3,3484(28)
	lis 3,.LC222@ha
	la 3,.LC222@l(3)
	bl FindItem
	li 9,1
	stw 3,3480(28)
	stw 9,3868(28)
	lwz 0,1560(27)
	cmpwi 0,0,0
	bc 12,2,.L851
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L848
.L851:
	lwz 3,84(31)
	bl InitClientPersistant
.L848:
	mr 4,30
	mr 3,31
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L852
	lis 9,gi+4@ha
	lwz 4,84(31)
	lis 3,.LC286@ha
	lwz 0,gi+4@l(9)
	la 3,.LC286@l(3)
	addi 5,1,8
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L852:
	lwz 3,84(31)
	addi 4,1,8
	li 5,100
	addi 3,3,4464
	bl strncpy
	lwz 11,84(31)
	li 0,0
	li 9,1
	stw 0,184(31)
	li 3,1
	stw 9,720(11)
.L853:
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe21:
	.size	 ClientConnect,.Lfe21-ClientConnect
	.section	".rodata"
	.align 2
.LC287:
	.string	"%s disconnected\n"
	.align 2
.LC288:
	.string	"disconnected"
	.align 2
.LC289:
	.long 0x0
	.align 2
.LC290:
	.long 0x3f800000
	.align 3
.LC291:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L855
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L857
	bl TossItemsOnDeath
.L857:
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L858
	mr 3,31
	li 4,0
	bl SP_LaserSight
.L858:
	lis 9,.LC289@ha
	lis 11,teamplay@ha
	la 9,.LC289@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L859
	lwz 0,248(31)
	cmpwi 0,0,1
	bc 4,2,.L859
	mr 3,31
	bl RemoveFromTransparentList
.L859:
	lwz 5,84(31)
	li 0,0
	lis 4,.LC287@ha
	la 4,.LC287@l(4)
	stw 0,892(31)
	li 3,2
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	mr 3,31
	bl ACEIT_PlayerRemoved
	lis 9,maxclients@ha
	li 8,1
	lwz 10,maxclients@l(9)
	lis 9,.LC290@ha
	la 9,.LC290@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L861
	lis 9,g_edicts@ha
	li 6,0
	lwz 11,g_edicts@l(9)
	lis 7,0x4330
	lis 9,.LC291@ha
	la 9,.LC291@l(9)
	addi 11,11,996
	lfd 12,0(9)
.L863:
	cmpwi 0,11,0
	bc 12,2,.L862
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L862
	lwz 9,84(11)
	lwz 0,4400(9)
	cmpw 0,0,31
	bc 4,2,.L862
	stw 6,4400(9)
.L862:
	addi 8,8,1
	lfs 13,20(10)
	xoris 0,8,0x8000
	addi 11,11,996
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L863
.L861:
	lis 11,.LC289@ha
	lis 9,teamplay@ha
	la 11,.LC289@l(11)
	lfs 31,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L867
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xe64
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49481
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L867:
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,76(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	li 0,0
	lwz 10,84(31)
	lwz 3,g_edicts@l(9)
	lis 11,0xe64
	lis 4,.LC42@ha
	lis 9,.LC288@ha
	ori 11,11,49481
	stw 0,40(31)
	la 9,.LC288@l(9)
	stw 0,248(31)
	subf 3,3,31
	stw 9,280(31)
	mullw 3,3,11
	la 4,.LC42@l(4)
	stw 0,88(31)
	stw 0,720(10)
	srawi 3,3,2
	lwz 0,24(29)
	addi 3,3,1311
	mtlr 0
	blrl
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L855
	bl CheckForUnevenTeams
.L855:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 ClientDisconnect,.Lfe22-ClientDisconnect
	.section	".rodata"
	.align 2
.LC292:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC294:
	.string	"*pain100_1.wav"
	.align 3
.LC293:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC295:
	.long 0x0
	.align 3
.LC296:
	.long 0x40140000
	.long 0x0
	.align 3
.LC297:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC298:
	.long 0x41000000
	.align 2
.LC299:
	.long 0x40800000
	.align 3
.LC300:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC301:
	.long 0x3f800000
	.align 2
.LC302:
	.long 0x3e000000
	.align 2
.LC303:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-320(1)
	mflr 0
	stfd 31,312(1)
	stmw 20,264(1)
	stw 0,324(1)
	lis 9,level@ha
	lis 5,.LC295@ha
	la 9,level@l(9)
	la 5,.LC295@l(5)
	lfs 13,0(5)
	mr 30,3
	mr 26,4
	lfs 0,200(9)
	stw 30,292(9)
	lwz 31,84(30)
	fcmpu 0,0,13
	bc 12,2,.L892
	li 0,4
	lis 10,.LC296@ha
	stw 0,0(31)
	la 10,.LC296@l(10)
	lfs 0,200(9)
	lfd 12,0(10)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L891
	lbz 0,1(26)
	andi. 11,0,128
	bc 12,2,.L891
	li 0,1
	stw 0,208(9)
	b .L891
.L892:
	lis 10,motd_time@ha
	lwz 8,3832(31)
	lwz 11,motd_time@l(10)
	add 0,8,8
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,256(1)
	lwz 9,260(1)
	cmpw 0,9,0
	bc 4,1,.L894
	lis 9,level@ha
	lwz 11,3836(31)
	lwz 9,level@l(9)
	addi 0,9,-20
	cmpw 0,11,0
	bc 4,0,.L894
	addi 0,8,1
	stw 9,3836(31)
	mr 3,30
	stw 0,3832(31)
	bl PrintMOTD
.L894:
	lwz 9,84(30)
	lis 11,pm_passent@ha
	stw 30,pm_passent@l(11)
	lwz 0,4444(9)
	cmpwi 0,0,0
	bc 12,2,.L896
	lha 0,2(26)
	lis 8,0x4330
	lis 5,.LC297@ha
	lis 9,.LC293@ha
	xoris 0,0,0x8000
	la 5,.LC297@l(5)
	lfd 13,.LC293@l(9)
	stw 0,260(1)
	mr 10,11
	mr 9,11
	stw 8,256(1)
	lis 21,maxclients@ha
	lfd 12,0(5)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3444(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3448(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3452(31)
	b .L897
.L896:
	addi 3,1,8
	li 4,0
	mr 29,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L902
	lwz 0,40(30)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L902
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L902
	li 0,2
.L902:
	stw 0,0(31)
	lis 9,sv_gravity@ha
	lwz 7,0(31)
	lwz 10,sv_gravity@l(9)
	li 20,3
	addi 22,1,12
	lwz 0,8(31)
	mtctr 20
	addi 23,30,4
	addi 24,1,18
	lfs 0,20(10)
	addi 25,30,376
	mr 12,22
	lwz 9,12(31)
	lis 10,.LC298@ha
	mr 4,23
	lwz 8,4(31)
	la 10,.LC298@l(10)
	mr 3,24
	lfs 10,0(10)
	mr 5,25
	addi 28,31,3884
	addi 27,1,36
	lis 21,maxclients@ha
	li 6,0
	li 10,0
	fctiwz 13,0
	stfd 13,256(1)
	lwz 11,260(1)
	sth 11,18(31)
	stw 7,8(1)
	stw 8,4(29)
	stw 0,8(29)
	stw 9,12(29)
	lwz 0,16(31)
	lwz 9,20(31)
	lwz 11,24(31)
	stw 0,16(29)
	stw 9,20(29)
	stw 11,24(29)
.L972:
	lfsx 13,6,4
	lfsx 0,6,5
	mr 9,11
	addi 6,6,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,256(1)
	lwz 11,260(1)
	stfd 11,256(1)
	lwz 9,260(1)
	sthx 11,10,12
	sthx 9,10,3
	addi 10,10,2
	bdnz .L972
	mr 3,28
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L909
	li 0,1
	stw 0,52(1)
.L909:
	lis 9,gi@ha
	lwz 7,0(26)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(26)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lwz 8,8(26)
	lwz 0,12(26)
	mtlr 5
	stw 7,36(1)
	lwz 10,52(9)
	stw 0,12(27)
	stw 6,4(27)
	stw 8,8(27)
	stw 11,240(1)
	stw 10,244(1)
	blrl
	lis 5,.LC299@ha
	lfs 13,224(1)
	la 5,.LC299@l(5)
	lfs 0,0(5)
	fcmpu 0,13,0
	bc 4,2,.L910
	lis 0,0x4180
	li 9,8
	stw 0,224(1)
	lis 11,0x4100
	stw 9,508(30)
	stw 11,200(1)
	stw 0,208(30)
.L910:
	lwz 0,8(1)
	lwz 9,4(29)
	lwz 11,8(29)
	lwz 10,12(29)
	stw 0,0(31)
	stw 9,4(31)
	stw 11,8(31)
	stw 10,12(31)
	lwz 0,16(29)
	lwz 9,20(29)
	lwz 11,24(29)
	stw 0,16(31)
	stw 9,20(31)
	stw 11,24(31)
	lwz 0,8(1)
	lwz 9,4(29)
	lwz 11,8(29)
	lwz 10,12(29)
	stw 0,3884(31)
	stw 9,4(28)
	stw 11,8(28)
	stw 10,12(28)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	stw 0,24(28)
	stw 9,16(28)
	stw 11,20(28)
	lwz 9,84(30)
	lwz 0,4332(9)
	cmpwi 0,0,0
	bc 12,2,.L911
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 12,2,.L911
	lha 0,22(1)
	cmpwi 0,0,10
	bc 4,1,.L911
	li 0,0
	sth 0,22(1)
.L911:
	lis 9,.LC297@ha
	lis 10,.LC300@ha
	li 11,3
	la 9,.LC297@l(9)
	la 10,.LC300@l(10)
	mtctr 11
	lfd 11,0(9)
	mr 29,23
	lfd 12,0(10)
	mr 3,22
	mr 4,24
	lis 6,0x4330
	mr 5,25
	li 7,0
	li 8,0
.L971:
	lhax 0,7,3
	lhax 9,7,4
	mr 10,11
	xoris 0,0,0x8000
	addi 7,7,2
	stw 0,260(1)
	xoris 9,9,0x8000
	stw 6,256(1)
	lfd 13,256(1)
	stw 9,260(1)
	stw 6,256(1)
	lfd 0,256(1)
	fsub 13,13,11
	fsub 0,0,11
	fmul 13,13,12
	fmul 0,0,12
	frsp 13,13
	frsp 0,0
	stfsx 13,8,29
	stfsx 0,8,5
	addi 8,8,4
	bdnz .L971
	lis 9,level@ha
	lis 0,0x2aaa
	lwz 11,level@l(9)
	ori 0,0,43691
	mulhw 0,11,0
	srawi 9,11,31
	subf 0,9,0
	mulli 0,0,6
	subf 11,0,11
	cmpwi 0,11,2
	bc 12,1,.L917
	lwz 0,228(1)
	lis 20,.LC295@ha
	lis 5,.LC297@ha
	li 9,3
	la 20,.LC295@l(20)
	la 5,.LC297@l(5)
	mtctr 9
	lfs 11,0(20)
	cmpwi 7,0,0
	lfd 12,0(5)
	mr 10,25
	li 29,0
	lis 8,0x4330
	li 11,0
.L970:
	lwz 9,84(30)
	lwz 0,4332(9)
	cmpwi 0,0,0
	bc 12,2,.L920
	cmpwi 0,29,1
	bc 4,1,.L923
	lfs 0,384(30)
	fcmpu 0,0,11
	bc 4,1,.L920
.L923:
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 12,2,.L920
	bc 12,30,.L920
	lwz 0,4344(9)
	lfsx 13,11,10
	slwi 0,0,2
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	frsp 0,0
	fdivs 13,13,0
	stfsx 13,11,10
.L920:
	addi 11,11,4
	addi 29,29,1
	bdnz .L970
	lis 11,level@ha
	lis 0,0x38e3
	lwz 9,level@l(11)
	ori 0,0,36409
	mulhw 0,9,0
	srawi 11,9,31
	srawi 0,0,4
	subf 0,11,0
	mulli 0,0,72
	cmpw 0,9,0
	bc 4,2,.L925
	lwz 9,84(30)
	lwz 0,4332(9)
	cmpwi 0,0,1
	bc 4,1,.L925
	lis 29,gi@ha
	lis 3,.LC294@ha
	la 29,gi@l(29)
	la 3,.LC294@l(3)
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC301@ha
	lis 10,.LC301@ha
	lis 11,.LC295@ha
	mr 5,3
	la 9,.LC301@l(9)
	la 10,.LC301@l(10)
	mtlr 0
	la 11,.LC295@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,30
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L925:
	lis 5,.LC298@ha
	lfs 12,376(30)
	la 5,.LC298@l(5)
	lfs 13,380(30)
	mr 8,9
	lfs 8,0(5)
	mr 7,9
	mr 6,9
	mr 11,9
	mr 10,9
	lfs 0,384(30)
	lis 0,0x4330
	lis 20,.LC297@ha
	fmuls 12,12,8
	la 20,.LC297@l(20)
	lis 5,.LC302@ha
	fmuls 13,13,8
	lfd 7,0(20)
	la 5,.LC302@l(5)
	fmuls 0,0,8
	lfs 8,0(5)
	fctiwz 11,12
	fctiwz 10,13
	fctiwz 9,0
	stfd 11,256(1)
	lwz 9,260(1)
	xoris 9,9,0x8000
	stw 9,260(1)
	stw 0,256(1)
	lfd 12,256(1)
	stfd 10,256(1)
	lwz 11,260(1)
	fsub 12,12,7
	xoris 11,11,0x8000
	stw 11,260(1)
	stw 0,256(1)
	frsp 12,12
	lfd 13,256(1)
	stfd 9,256(1)
	lwz 10,260(1)
	fmuls 12,12,8
	fsub 13,13,7
	xoris 10,10,0x8000
	stw 10,260(1)
	stw 0,256(1)
	frsp 13,13
	lfd 0,256(1)
	stfs 12,376(30)
	fmuls 13,13,8
	fsub 0,0,7
	stfs 13,380(30)
	frsp 0,0
	fmuls 0,0,8
	stfs 0,384(30)
.L917:
	lfs 0,216(1)
	lis 8,0x4330
	lfs 13,220(1)
	lis 10,.LC297@ha
	lis 7,.LC293@ha
	lfs 8,204(1)
	la 10,.LC297@l(10)
	mr 11,9
	lfs 9,208(1)
	lfs 10,212(1)
	lfs 11,224(1)
	stfs 0,200(30)
	stfs 13,204(30)
	stfs 8,188(30)
	stfs 9,192(30)
	stfs 10,196(30)
	stfs 11,208(30)
	lha 0,2(26)
	lfd 12,0(10)
	xoris 0,0,0x8000
	lfd 13,.LC293@l(7)
	mr 10,9
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3444(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3448(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3452(31)
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 12,2,.L926
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L926
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L926
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L926
	lwz 9,84(30)
	lwz 0,4332(9)
	cmpwi 0,0,0
	bc 4,2,.L926
	li 0,1
	stw 0,4416(9)
.L926:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(30)
	stw 11,608(30)
	fctiwz 13,0
	stw 10,552(30)
	stfd 13,256(1)
	lwz 9,260(1)
	stw 9,508(30)
	bc 12,2,.L927
	lwz 0,92(10)
	stw 0,556(30)
.L927:
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L928
	lfs 0,3988(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L929
.L928:
	lfs 0,188(1)
	stfs 0,4060(31)
	lfs 13,192(1)
	stfs 13,4064(31)
	lfs 0,196(1)
	stfs 0,4068(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L929:
	lis 9,gi+72@ha
	mr 3,30
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L930
	mr 3,30
	bl G_TouchTriggers
.L930:
	li 0,0
	stw 0,4396(31)
	lwz 9,84(30)
	lwz 0,4416(9)
	cmpwi 0,0,0
	bc 12,2,.L931
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L931
	mr 3,30
	bl kick_attack
.L931:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L897
	addi 28,1,60
.L935:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,28,0
	addi 27,29,1
	bc 4,0,.L937
	lwz 0,0(28)
	cmpw 0,0,3
	bc 12,2,.L937
	mr 9,28
.L938:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L937
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L938
.L937:
	cmpw 0,11,29
	bc 4,2,.L934
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L934
	mr 4,30
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L934:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L935
.L897:
	lwz 0,3940(31)
	lwz 11,3948(31)
	stw 0,3944(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3940(31)
	or 11,11,0
	stw 11,3948(31)
	lbz 0,15(26)
	stw 0,640(30)
	lwz 9,3948(31)
	andi. 0,9,1
	bc 4,2,.L946
	lis 9,limchasecam@ha
	lis 5,.LC295@ha
	lwz 11,limchasecam@l(9)
	la 5,.LC295@l(5)
	lfs 0,0(5)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L948
	lwz 0,4444(31)
	cmpwi 0,0,0
	bc 12,2,.L947
.L948:
	lis 9,.LC303@ha
	la 9,.LC303@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L945
	lwz 0,4444(31)
	cmpwi 0,0,1
	bc 4,2,.L945
.L947:
	lis 9,team_round_going@ha
	lwz 0,team_round_going@l(9)
	cmpwi 0,0,0
	bc 12,2,.L945
	lwz 0,3488(31)
	cmpwi 0,0,0
	bc 12,2,.L945
	lis 11,limchasecam@ha
	lis 10,.LC303@ha
	lwz 9,limchasecam@l(11)
	la 10,.LC303@l(10)
	lfs 13,0(10)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L946
	lwz 0,4444(31)
	cmpwi 0,0,2
	bc 12,2,.L945
.L946:
	lwz 10,248(30)
	cmpwi 0,10,0
	bc 4,2,.L949
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L949
	lwz 0,4444(31)
	stw 10,3948(31)
	cmpwi 0,0,0
	bc 12,2,.L950
	cmpwi 0,0,1
	bc 4,2,.L951
	li 0,90
	lis 9,0x42b4
	li 11,2
	stw 0,4304(31)
	stw 9,112(31)
	stw 11,4444(31)
	b .L945
.L951:
	lbz 0,16(31)
	li 9,90
	lis 11,0x42b4
	stw 10,4436(31)
	andi. 0,0,191
	stw 9,4304(31)
	stw 11,112(31)
	stb 0,16(31)
	stw 10,4444(31)
	b .L945
.L950:
	stw 0,4436(31)
	mr 3,30
	bl GetChaseTarget
	lwz 0,4436(31)
	cmpwi 0,0,0
	bc 12,2,.L945
	li 0,1
	mr 3,30
	stw 0,4444(31)
	bl UpdateChaseCam
	b .L945
.L949:
	lwz 0,3952(31)
	cmpwi 0,0,0
	bc 4,2,.L945
	li 0,1
	mr 3,30
	stw 0,3952(31)
	bl Think_Weapon
.L945:
	lwz 0,904(30)
	cmpwi 0,0,0
	bc 4,2,.L957
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L957
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L957
	mr 3,30
	bl ACEND_PathMap
.L957:
	lwz 0,4444(31)
	cmpwi 0,0,0
	bc 12,2,.L958
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L959
	lbz 0,16(31)
	andi. 5,0,2
	bc 4,2,.L963
	lwz 9,4436(31)
	ori 0,0,2
	stb 0,16(31)
	cmpwi 0,9,0
	bc 12,2,.L961
	mr 3,30
	bl ChaseNext
	b .L963
.L961:
	mr 3,30
	bl GetChaseTarget
	mr 3,30
	bl UpdateChaseCam
	b .L963
.L959:
	lbz 0,16(31)
	andi. 0,0,253
	stb 0,16(31)
.L963:
	mr 3,30
	bl ChaseTargetGone
.L958:
	lis 9,maxclients@ha
	lis 5,.LC301@ha
	lwz 11,maxclients@l(9)
	la 5,.LC301@l(5)
	li 29,1
	lfs 13,0(5)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L891
	lis 9,.LC297@ha
	lis 27,g_edicts@ha
	la 9,.LC297@l(9)
	lis 28,0x4330
	lfd 31,0(9)
	li 31,996
.L967:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L966
	lwz 9,84(3)
	lwz 0,4444(9)
	cmpwi 0,0,0
	bc 12,2,.L966
	lwz 0,4436(9)
	cmpw 0,0,30
	bc 4,2,.L966
	bl UpdateChaseCam
.L966:
	addi 29,29,1
	lwz 11,maxclients@l(21)
	xoris 0,29,0x8000
	addi 31,31,996
	stw 0,260(1)
	stw 28,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L967
.L891:
	lwz 0,324(1)
	mtlr 0
	lmw 20,264(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe23:
	.size	 ClientThink,.Lfe23-ClientThink
	.section	".rodata"
	.align 2
.LC304:
	.string	"%s rejoined the game\n"
	.align 2
.LC305:
	.long 0x0
	.align 2
.LC306:
	.long 0x47800000
	.align 2
.LC307:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 11,.LC305@ha
	lis 9,level+200@ha
	la 11,.LC305@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 31,0(11)
	fcmpu 0,0,31
	bc 4,2,.L973
	lis 9,deathmatch@ha
	lwz 30,84(31)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L975
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L975
	lwz 7,248(31)
	li 9,0
	cmpwi 7,7,0
	bc 4,30,.L976
	lwz 0,492(31)
	xori 0,0,2
	addic 11,0,-1
	subfe 9,11,0
.L976:
	lwz 0,1804(30)
	cmpw 0,9,0
	bc 12,2,.L975
	bc 4,30,.L978
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L977
.L978:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L979
	lwz 0,264(31)
	li 29,0
	lis 11,meansOfDeath@ha
	li 9,23
	stw 29,480(31)
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(31)
	mr 4,31
	mr 5,31
	stw 9,meansOfDeath@l(11)
	la 7,vec3_origin@l(7)
	mr 3,31
	ori 6,6,34464
	bl player_die
	li 0,2
	li 11,1
	stw 29,248(31)
	stw 0,492(31)
	lis 9,gi+72@ha
	mr 3,31
	stw 11,260(31)
	lwz 0,gi+72@l(9)
	b .L1008
.L979:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L975
	mr 3,31
	bl CopyToBodyQue
	lwz 0,184(31)
	li 10,0
	li 9,1
	lwz 8,84(31)
	li 11,100
	lis 7,gi+72@ha
	ori 0,0,1
	stw 9,260(31)
	mr 3,31
	stw 0,184(31)
	stw 10,248(31)
	stw 11,724(8)
	stw 11,480(31)
	stw 10,492(31)
	lwz 0,gi+72@l(7)
.L1008:
	mtlr 0
	blrl
	lwz 5,84(31)
	lis 4,.LC262@ha
	li 3,2
	la 4,.LC262@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	b .L975
.L977:
	stw 7,4444(30)
	lis 9,gi@ha
	li 0,90
	lwz 11,84(31)
	la 29,gi@l(9)
	lis 10,0x42b4
	li 8,2
	mr 3,31
	stw 7,4436(11)
	lwz 9,84(31)
	stw 0,4304(9)
	lwz 11,84(31)
	stw 10,112(11)
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 0,0,191
	stb 0,16(9)
	stw 8,248(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 5,84(31)
	lis 4,.LC304@ha
	li 3,2
	la 4,.LC304@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L983
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L984
.L983:
	lwz 0,904(31)
	cmpwi 0,0,0
	bc 12,2,.L985
	mr 3,31
	bl ACESP_Respawn
	b .L975
.L985:
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L987
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L988
.L987:
	mr 3,31
	bl CopyToBodyQue
.L988:
	mr 3,31
	bl PutClientInServer
	lwz 0,184(31)
	lis 9,level+4@ha
	lwz 11,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lfs 0,level+4@l(9)
	stfs 0,4216(11)
	b .L975
.L984:
	lwz 0,168(29)
	lis 3,.LC238@ha
	la 3,.LC238@l(3)
	mtlr 0
	blrl
.L975:
	lwz 0,3952(30)
	cmpwi 0,0,0
	bc 4,2,.L989
	mr 3,31
	bl Think_Weapon
	b .L990
.L989:
	li 0,0
	stw 0,3952(30)
.L990:
	lwz 0,492(31)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L991
	lis 9,level+4@ha
	lfs 13,4216(30)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L973
	lis 11,.LC305@ha
	lis 9,teamplay@ha
	la 11,.LC305@l(11)
	lfs 31,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L994
	bc 4,2,.L993
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 12,2,.L993
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L993
	cmpwi 0,8,2
	bc 4,2,.L993
.L994:
	mr 3,31
	bl CopyToBodyQue
	lwz 0,184(31)
	li 7,0
	li 9,1
	lwz 6,84(31)
	li 8,100
	lis 11,.LC306@ha
	ori 0,0,1
	stw 9,260(31)
	la 11,.LC306@l(11)
	stw 0,184(31)
	lis 9,.LC307@ha
	lis 5,gi+72@ha
	stw 7,248(31)
	la 9,.LC307@l(9)
	mr 3,31
	stw 8,724(6)
	stw 8,480(31)
	stw 7,492(31)
	lfs 13,3444(30)
	lfs 12,3988(30)
	lfs 11,3448(30)
	lfs 6,0(11)
	fsubs 13,31,13
	lfs 0,3452(30)
	fsubs 12,12,11
	lfs 7,0(9)
	mr 10,11
	fmuls 13,13,6
	mr 9,11
	fsubs 0,31,0
	fmuls 12,12,6
	fdivs 13,13,7
	fmuls 0,0,6
	fdivs 12,12,7
	fdivs 0,0,7
	fctiwz 8,13
	fctiwz 9,12
	fctiwz 10,0
	stfd 8,16(1)
	lwz 11,20(1)
	stfd 9,16(1)
	lwz 10,20(1)
	stfd 10,16(1)
	lwz 9,20(1)
	sth 11,20(30)
	sth 10,22(30)
	sth 9,24(30)
	stfs 31,16(31)
	lfs 0,3988(30)
	stfs 31,24(31)
	stfs 0,20(31)
	stfs 31,28(30)
	lfs 0,20(31)
	stfs 0,32(30)
	lfs 13,24(31)
	stfs 13,36(30)
	lfs 0,16(31)
	stfs 0,4060(30)
	lfs 13,20(31)
	stfs 13,4064(30)
	lfs 0,24(31)
	stfs 0,4068(30)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
	b .L973
.L993:
	lis 9,.LC305@ha
	lis 11,deathmatch@ha
	lwz 10,3948(30)
	la 9,.LC305@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L999
	bc 12,30,.L973
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1024
	bc 12,2,.L973
.L999:
	bc 4,30,.L1000
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L1001
.L1000:
	lwz 0,904(31)
	cmpwi 0,0,0
	bc 12,2,.L1002
	mr 3,31
	bl ACESP_Respawn
	b .L1006
.L1002:
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L1004
	cmpwi 0,8,2
	bc 4,2,.L1005
.L1004:
	mr 3,31
	bl CopyToBodyQue
.L1005:
	mr 3,31
	bl PutClientInServer
	lwz 0,184(31)
	lis 9,level+4@ha
	lwz 11,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lfs 0,level+4@l(9)
	stfs 0,4216(11)
	b .L1006
.L1001:
	lis 9,gi+168@ha
	lis 3,.LC238@ha
	lwz 0,gi+168@l(9)
	la 3,.LC238@l(3)
	mtlr 0
	blrl
	b .L1009
.L991:
	lis 9,.LC305@ha
	lis 11,deathmatch@ha
	la 9,.LC305@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L1006
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L1006
	addi 3,31,28
	bl PlayerTrail_Add
.L1009:
.L1006:
	li 0,0
	stw 0,3948(30)
.L973:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 ClientBeginServerFrame,.Lfe24-ClientBeginServerFrame
	.align 2
	.globl CleanBodies
	.type	 CleanBodies,@function
CleanBodies:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game+1544@ha
	lis 10,g_edicts@ha
	lwz 0,game+1544@l(9)
	lis 11,gi@ha
	li 27,0
	lwz 9,g_edicts@l(10)
	la 28,gi@l(11)
	li 29,1
	mulli 0,0,996
	li 30,8
	add 9,9,0
	addi 31,9,996
.L686:
	lwz 9,76(28)
	mr 3,31
	mtlr 9
	blrl
	lwz 0,184(31)
	addic. 30,30,-1
	stw 27,248(31)
	ori 0,0,1
	stw 29,260(31)
	stw 0,184(31)
	addi 31,31,996
	bc 4,2,.L686
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 CleanBodies,.Lfe25-CleanBodies
	.align 2
	.globl IsNeutral
	.type	 IsNeutral,@function
IsNeutral:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L76
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L76
	cmpwi 0,11,109
	bc 12,2,.L76
	cmpwi 0,11,77
	li 3,1
	bc 4,2,.L1010
.L76:
	li 3,0
.L1010:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 IsNeutral,.Lfe26-IsNeutral
	.align 2
	.globl IsFemale
	.type	 IsFemale,@function
IsFemale:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L72
	lis 4,.LC40@ha
	addi 3,3,188
	la 4,.LC40@l(4)
	bl Info_ValueForKey
	lbz 3,0(3)
	xori 0,3,70
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,102
	subfic 9,3,0
	adde 3,9,3
	or 3,3,0
	b .L1011
.L72:
	li 3,0
.L1011:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 IsFemale,.Lfe27-IsFemale
	.section	".rodata"
	.align 2
.LC308:
	.long 0x0
	.section	".text"
	.align 2
	.globl respawn
	.type	 respawn,@function
respawn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC308@ha
	lis 9,deathmatch@ha
	la 11,.LC308@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L690
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L689
.L690:
	lwz 0,904(31)
	cmpwi 0,0,0
	bc 12,2,.L691
	mr 3,31
	bl ACESP_Respawn
	b .L688
.L691:
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L693
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L692
.L693:
	mr 3,31
	bl CopyToBodyQue
.L692:
	mr 3,31
	bl PutClientInServer
	lwz 0,184(31)
	lis 9,level+4@ha
	lwz 11,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lfs 0,level+4@l(9)
	stfs 0,4216(11)
	b .L688
.L689:
	lis 9,gi+168@ha
	lis 3,.LC238@ha
	lwz 0,gi+168@l(9)
	la 3,.LC238@l(3)
	mtlr 0
	blrl
.L688:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe28:
	.size	 respawn,.Lfe28-respawn
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 4,0
	addi 28,29,1812
	li 5,2072
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	addi 4,29,188
	lwz 0,level@l(9)
	li 5,1624
	mr 3,28
	stw 0,3436(29)
	crxor 6,6,6
	bl memcpy
	lis 3,.LC196@ha
	la 3,.LC196@l(3)
	bl FindItem
	stw 3,3484(29)
	lis 3,.LC222@ha
	la 3,.LC222@l(3)
	bl FindItem
	li 0,1
	stw 3,3480(29)
	stw 0,3868(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 InitClientResp,.Lfe29-InitClientResp
	.align 2
	.globl InitBodyQue
	.type	 InitBodyQue,@function
InitBodyQue:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,level+296@ha
	li 0,0
	lis 11,.LC237@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC237@l(11)
.L678:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L678
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe30:
	.size	 InitBodyQue,.Lfe30-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe31:
	.size	 player_pain,.Lfe31-player_pain
	.section	".rodata"
	.align 2
.LC309:
	.long 0x0
	.section	".text"
	.align 2
	.globl SaveClientData
	.type	 SaveClientData,@function
SaveClientData:
	lis 9,game@ha
	li 6,0
	la 8,game@l(9)
	lwz 0,1544(8)
	cmpw 0,6,0
	bclr 4,0
	lis 9,g_edicts@ha
	lis 11,coop@ha
	lwz 10,g_edicts@l(9)
	mr 3,8
	lis 4,game@ha
	lis 9,.LC309@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC309@l(9)
	addi 10,10,996
	lfs 13,0(9)
.L567:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L566
	la 8,game@l(4)
	lwz 0,480(10)
	lwz 9,1028(8)
	add 9,7,9
	stw 0,724(9)
	lwz 11,1028(8)
	lwz 0,484(10)
	add 11,7,11
	stw 0,728(11)
	lwz 9,1028(8)
	lwz 0,264(10)
	add 9,7,9
	rlwinm 0,0,0,19,19
	stw 0,732(9)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L566
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3440(9)
	add 11,7,11
	stw 0,1800(11)
.L566:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,4564
	addi 10,10,996
	cmpw 0,6,0
	bc 12,0,.L567
	blr
.Lfe32:
	.size	 SaveClientData,.Lfe32-SaveClientData
	.section	".rodata"
	.align 2
.LC310:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lwz 11,84(3)
	lwz 0,724(11)
	stw 0,480(3)
	lwz 9,728(11)
	stw 9,484(3)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L572
	lwz 0,264(3)
	ori 0,0,4096
	stw 0,264(3)
.L572:
	lis 9,.LC310@ha
	lis 11,coop@ha
	la 9,.LC310@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bclr 12,2
	lwz 9,84(3)
	lwz 0,1800(9)
	stw 0,3440(9)
	blr
.Lfe33:
	.size	 FetchClientEntData,.Lfe33-FetchClientEntData
	.align 2
	.globl Subtract_Frag
	.type	 Subtract_Frag,@function
Subtract_Frag:
	lwz 10,84(3)
	li 0,0
	lwz 9,3440(10)
	addi 9,9,-1
	stw 9,3440(10)
	lwz 11,84(3)
	stw 0,3476(11)
	blr
.Lfe34:
	.size	 Subtract_Frag,.Lfe34-Subtract_Frag
	.section	".rodata"
	.align 2
.LC311:
	.long 0x43c00000
	.section	".text"
	.align 2
	.type	 SP_FixCoopSpots,@function
SP_FixCoopSpots:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,.LC311@ha
	mr 30,3
	la 9,.LC311@l(9)
	li 31,0
	lfs 31,0(9)
	lis 29,.LC19@ha
.L51:
	mr 3,31
	li 4,280
	la 5,.LC19@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L48
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L51
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L51
	lwz 3,300(30)
	cmpwi 0,3,0
	bc 12,2,.L56
	lwz 4,300(31)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L48
.L56:
	lwz 0,300(31)
	stw 0,300(30)
.L48:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 SP_FixCoopSpots,.Lfe35-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC312:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC313:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_start
	.type	 SP_info_player_start,@function
SP_info_player_start:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC313@ha
	lis 9,coop@ha
	la 11,.LC313@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L60
	lis 3,level+72@ha
	lis 4,.LC20@ha
	la 3,level+72@l(3)
	la 4,.LC20@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L60
	lis 9,SP_CreateCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_CreateCoopSpots@l(9)
	lis 11,.LC312@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC312@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L60:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 SP_info_player_start,.Lfe36-SP_info_player_start
	.section	".rodata"
	.align 2
.LC314:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC314@ha
	lis 9,deathmatch@ha
	la 11,.LC314@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L64
	bl G_FreeEdict
	b .L63
.L64:
	bl SP_misc_teleporter_dest
.L63:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 SP_info_player_deathmatch,.Lfe37-SP_info_player_deathmatch
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe38:
	.size	 SP_info_player_intermission,.Lfe38-SP_info_player_intermission
	.section	".rodata"
	.align 2
.LC315:
	.long 0x0
	.section	".text"
	.align 2
	.globl PrintDeathMessage
	.type	 PrintDeathMessage,@function
PrintDeathMessage:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 11,.LC315@ha
	lis 9,teamplay@ha
	la 11,.LC315@l(11)
	mr 29,3
	lfs 13,0(11)
	mr 28,4
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L78
	mr 4,29
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	b .L77
.L78:
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L79
	lis 5,.LC41@ha
	li 3,0
	la 5,.LC41@l(5)
	li 4,1
	mr 6,29
	crxor 6,6,6
	bl safe_cprintf
.L79:
	lis 9,game@ha
	li 31,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 12,1,.L77
	mr 24,9
	lis 25,g_edicts@ha
	lis 26,team_round_going@ha
	lis 27,.LC41@ha
	li 30,996
.L83:
	lwz 0,g_edicts@l(25)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L82
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L82
	cmpw 0,28,3
	bc 12,2,.L86
	lwz 0,team_round_going@l(26)
	cmpwi 0,0,0
	bc 12,2,.L86
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L82
.L86:
	li 4,1
	la 5,.LC41@l(27)
	mr 6,29
	crxor 6,6,6
	bl safe_cprintf
.L82:
	lwz 0,1544(24)
	addi 31,31,1
	addi 30,30,996
	cmpw 0,31,0
	bc 4,1,.L83
.L77:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 PrintDeathMessage,.Lfe39-PrintDeathMessage
	.section	".rodata"
	.align 2
.LC316:
	.long 0x46fffe00
	.align 3
.LC317:
	.long 0x4072c000
	.long 0x0
	.align 3
.LC318:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC319:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl EjectItem
	.type	 EjectItem,@function
EjectItem:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr. 30,4
	mr 31,3
	bc 12,2,.L474
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 11,.LC318@ha
	lis 10,.LC316@ha
	stw 0,8(1)
	la 11,.LC318@l(11)
	mr 4,30
	lfd 11,0(11)
	mr 3,31
	lfd 0,8(1)
	lis 11,.LC319@ha
	lfs 10,.LC316@l(10)
	la 11,.LC319@l(11)
	lfd 9,0(11)
	fsub 0,0,11
	lis 11,.LC317@ha
	lfs 13,4064(8)
	lfd 12,.LC317@l(11)
	frsp 0,0
	fdivs 0,0,10
	fmr 31,0
	fsub 31,31,9
	fadd 31,31,31
	fmul 31,31,12
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(8)
	bl Drop_Item
	lwz 9,84(31)
	lis 0,0x2
	lfs 0,4064(9)
	fadds 0,0,31
	stfs 0,4064(9)
	stw 0,284(3)
.L474:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 EjectItem,.Lfe40-EjectItem
	.section	".rodata"
	.align 2
.LC320:
	.long 0x46fffe00
	.align 3
.LC321:
	.long 0x4072c000
	.long 0x0
	.align 3
.LC322:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC323:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl EjectWeapon
	.type	 EjectWeapon,@function
EjectWeapon:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr. 30,4
	mr 31,3
	bc 12,2,.L476
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 11,.LC322@ha
	lis 10,.LC320@ha
	stw 0,8(1)
	la 11,.LC322@l(11)
	mr 4,30
	lfd 11,0(11)
	mr 3,31
	lfd 0,8(1)
	lis 11,.LC323@ha
	lfs 10,.LC320@l(10)
	la 11,.LC323@l(11)
	lfd 9,0(11)
	fsub 0,0,11
	lis 11,.LC321@ha
	lfs 13,4064(8)
	lfd 12,.LC321@l(11)
	frsp 0,0
	fdivs 0,0,10
	fmr 31,0
	fsub 31,31,9
	fadd 31,31,31
	fmul 31,31,12
	frsp 31,31
	fsubs 13,13,31
	stfs 13,4064(8)
	bl Drop_Item
	lwz 11,84(31)
	lis 9,temp_think_specweap@ha
	lis 0,0x2
	la 9,temp_think_specweap@l(9)
	lfs 0,4064(11)
	fadds 0,0,31
	stfs 0,4064(11)
	stw 9,436(3)
	stw 0,284(3)
.L476:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe41:
	.size	 EjectWeapon,.Lfe41-EjectWeapon
	.section	".rodata"
	.align 2
.LC324:
	.long 0x4b18967f
	.align 2
.LC325:
	.long 0x3f800000
	.align 3
.LC326:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PlayersRangeFromSpot
	.type	 PlayersRangeFromSpot,@function
PlayersRangeFromSpot:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,40(1)
	stw 0,84(1)
	lis 9,maxclients@ha
	lis 11,.LC325@ha
	lwz 10,maxclients@l(9)
	la 11,.LC325@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC324@ha
	lfs 31,.LC324@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L576
	lis 9,.LC326@ha
	lis 27,g_edicts@ha
	la 9,.LC326@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,996
.L578:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L577
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L577
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(11)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(11)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L577
	fmr 31,1
.L577:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,996
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L578
.L576:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe42:
	.size	 PlayersRangeFromSpot,.Lfe42-PlayersRangeFromSpot
	.align 2
	.globl SelectDeathmatchSpawnPoint
	.type	 SelectDeathmatchSpawnPoint,@function
SelectDeathmatchSpawnPoint:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,512
	bc 4,2,.L627
	bl SelectRandomDeathmatchSpawnPoint
	b .L1013
.L627:
	bl SelectFarthestDeathmatchSpawnPoint
.L1013:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 SelectDeathmatchSpawnPoint,.Lfe43-SelectDeathmatchSpawnPoint
	.align 2
	.globl SelectCoopSpawnPoint
	.type	 SelectCoopSpawnPoint,@function
SelectCoopSpawnPoint:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xc0ba
	lwz 10,game+1028@l(11)
	ori 9,9,43997
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L1014
.L633:
	lis 5,.LC21@ha
	mr 3,30
	la 5,.LC21@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L634
	li 3,0
	b .L1014
.L634:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L635
	lis 9,.LC42@ha
	la 4,.LC42@l(9)
.L635:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L633
	addic. 31,31,-1
	bc 4,2,.L633
	mr 3,30
.L1014:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe44:
	.size	 SelectCoopSpawnPoint,.Lfe44-SelectCoopSpawnPoint
	.align 2
	.globl body_die
	.type	 body_die,@function
body_die:
	lwz 0,480(3)
	cmpwi 0,0,-40
	bclr 4,0
	li 0,0
	stw 0,512(3)
	blr
.Lfe45:
	.size	 body_die,.Lfe45-body_die
	.section	".rodata"
	.align 3
.LC327:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC328:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl AllItems
	.type	 AllItems,@function
AllItems:
	stwu 1,-1072(1)
	mflr 0
	stfd 30,1056(1)
	stfd 31,1064(1)
	stmw 26,1032(1)
	stw 0,1076(1)
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	mr 29,3
	lwz 0,1556(11)
	cmpw 0,30,0
	bc 4,0,.L712
	lis 9,itemlist@ha
	mr 26,11
	la 31,itemlist@l(9)
	lis 27,0x4330
	lis 9,.LC327@ha
	lis 28,unique_items@ha
	la 9,.LC327@l(9)
	lfd 31,0(9)
	lis 9,.LC328@ha
	la 9,.LC328@l(9)
	lfs 30,0(9)
.L714:
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 12,2,.L713
	lwz 0,56(31)
	andi. 9,0,64
	bc 12,2,.L713
	lwz 10,84(29)
	stw 31,656(1)
	lwz 0,4312(10)
	lwz 11,unique_items@l(28)
	xoris 0,0,0x8000
	stw 0,1028(1)
	stw 27,1024(1)
	lfd 0,1024(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L717
	fsubs 0,13,30
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 9,1028(1)
	stw 9,4312(10)
.L717:
	addi 3,1,8
	mr 4,29
	bl Pickup_Special
.L713:
	lwz 0,1556(26)
	addi 30,30,1
	addi 31,31,72
	cmpw 0,30,0
	bc 12,0,.L714
.L712:
	lwz 0,1076(1)
	mtlr 0
	lmw 26,1032(1)
	lfd 30,1056(1)
	lfd 31,1064(1)
	la 1,1072(1)
	blr
.Lfe46:
	.size	 AllItems,.Lfe46-AllItems
	.comm	current_map,55,4
	.comm	pm_passent,4,4
	.align 2
	.globl PM_trace
	.type	 PM_trace,@function
PM_trace:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,pm_passent@ha
	mr 31,3
	lwz 8,pm_passent@l(9)
	lwz 0,480(8)
	cmpwi 0,0,0
	bc 4,1,.L870
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L869
.L870:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L869:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 PM_trace,.Lfe47-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L874
.L876:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L876
.L874:
	mr 3,11
	blr
.Lfe48:
	.size	 CheckBlock,.Lfe48-CheckBlock
	.align 2
	.globl PrintPmove
	.type	 PrintPmove,@function
PrintPmove:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 0,28
	li 5,0
	mtctr 0
	li 9,0
.L1016:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L1016
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L1015:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L1015
	lis 3,.LC292@ha
	la 3,.LC292@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe49:
	.size	 PrintPmove,.Lfe49-PrintPmove
	.align 2
	.type	 SP_CreateCoopSpots,@function
SP_CreateCoopSpots:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 3,level+72@ha
	lis 4,.LC20@ha
	la 3,level+72@l(3)
	la 4,.LC20@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L59
	bl G_Spawn
	lis 26,0xc324
	lis 25,0x42a0
	lis 29,.LC21@ha
	lis 28,.LC22@ha
	stw 26,8(3)
	la 29,.LC21@l(29)
	la 28,.LC22@l(28)
	stw 25,12(3)
	lis 27,0x42b4
	lis 0,0x42f8
	stw 29,280(3)
	stw 0,4(3)
	stw 27,20(3)
	stw 28,300(3)
	bl G_Spawn
	lis 0,0x437c
	stw 27,20(3)
	stw 0,4(3)
	stw 29,280(3)
	stw 26,8(3)
	stw 25,12(3)
	stw 28,300(3)
	bl G_Spawn
	lis 0,0x439e
	stw 27,20(3)
	stw 29,280(3)
	stw 0,4(3)
	stw 26,8(3)
	stw 25,12(3)
	stw 28,300(3)
.L59:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe50:
	.size	 SP_CreateCoopSpots,.Lfe50-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
