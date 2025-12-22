	.file	"p_client.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"info_player_start"
	.align 2
.LC1:
	.string	"security"
	.align 2
.LC2:
	.string	"info_player_coop"
	.align 2
.LC3:
	.string	"jail3"
	.align 2
.LC5:
	.string	"jail2"
	.align 2
.LC6:
	.string	"jail4"
	.align 2
.LC7:
	.string	"mine1"
	.align 2
.LC8:
	.string	"mine2"
	.align 2
.LC9:
	.string	"mine3"
	.align 2
.LC10:
	.string	"mine4"
	.align 2
.LC11:
	.string	"lab"
	.align 2
.LC12:
	.string	"boss1"
	.align 2
.LC13:
	.string	"fact3"
	.align 2
.LC14:
	.string	"biggun"
	.align 2
.LC15:
	.string	"space"
	.align 2
.LC16:
	.string	"command"
	.align 2
.LC17:
	.string	"power2"
	.align 2
.LC18:
	.string	"strike"
	.align 3
.LC19:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC20:
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
	lis 11,.LC20@ha
	lis 9,coop@ha
	la 11,.LC20@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L24
	bl G_FreeEdict
	b .L23
.L24:
	lis 31,level+72@ha
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	la 3,level+72@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC6@ha
	la 3,level+72@l(31)
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC7@ha
	la 3,level+72@l(31)
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC8@ha
	la 3,level+72@l(31)
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC9@ha
	la 3,level+72@l(31)
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC10@ha
	la 3,level+72@l(31)
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC11@ha
	la 3,level+72@l(31)
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC12@ha
	la 3,level+72@l(31)
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC13@ha
	la 3,level+72@l(31)
	la 4,.LC13@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC14@ha
	la 3,level+72@l(31)
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC15@ha
	la 3,level+72@l(31)
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC16@ha
	la 3,level+72@l(31)
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC17@ha
	la 3,level+72@l(31)
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC18@ha
	la 3,level+72@l(31)
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L23
.L26:
	lis 9,SP_FixCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_FixCoopSpots@l(9)
	lis 11,.LC19@ha
	stw 9,436(30)
	lfs 0,level+4@l(10)
	lfd 13,.LC19@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L23:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 SP_info_player_coop,.Lfe1-SP_info_player_coop
	.section	".rodata"
	.align 2
.LC21:
	.string	"gender"
	.align 2
.LC22:
	.string	""
	.align 2
.LC23:
	.string	"suicides"
	.align 2
.LC24:
	.string	"cratered"
	.align 2
.LC25:
	.string	"was squished"
	.align 2
.LC26:
	.string	"sank like a rock"
	.align 2
.LC27:
	.string	"melted"
	.align 2
.LC28:
	.string	"does a back flip into the lava"
	.align 2
.LC29:
	.string	"blew up"
	.align 2
.LC30:
	.string	"found a way out"
	.align 2
.LC31:
	.string	"saw the light"
	.align 2
.LC32:
	.string	"got blasted"
	.align 2
.LC33:
	.string	"was in the wrong place"
	.align 2
.LC34:
	.string	"tried to put the pin back in"
	.align 2
.LC35:
	.string	"tripped on its own grenade"
	.align 2
.LC36:
	.string	"tripped on her own grenade"
	.align 2
.LC37:
	.string	"tripped on his own grenade"
	.align 2
.LC38:
	.string	"blew itself up"
	.align 2
.LC39:
	.string	"blew herself up"
	.align 2
.LC40:
	.string	"blew himself up"
	.align 2
.LC41:
	.string	"should have used a smaller gun"
	.align 2
.LC42:
	.string	"killed itself"
	.align 2
.LC43:
	.string	"killed herself"
	.align 2
.LC44:
	.string	"killed himself"
	.align 2
.LC45:
	.string	"%s %s.\n"
	.align 2
.LC46:
	.string	"was blasted by"
	.align 2
.LC47:
	.string	"was gunned down by"
	.align 2
.LC48:
	.string	"was blown away by"
	.align 2
.LC49:
	.string	"'s super shotgun"
	.align 2
.LC50:
	.string	"was machinegunned by"
	.align 2
.LC51:
	.string	"was cut in half by"
	.align 2
.LC52:
	.string	"'s chaingun"
	.align 2
.LC53:
	.string	"was popped by"
	.align 2
.LC54:
	.string	"'s grenade"
	.align 2
.LC55:
	.string	"was shredded by"
	.align 2
.LC56:
	.string	"'s shrapnel"
	.align 2
.LC57:
	.string	"ate"
	.align 2
.LC58:
	.string	"'s rocket"
	.align 2
.LC59:
	.string	"almost dodged"
	.align 2
.LC60:
	.string	"was melted by"
	.align 2
.LC61:
	.string	"'s hyperblaster"
	.align 2
.LC62:
	.string	"was railed by"
	.align 2
.LC63:
	.string	"saw the pretty lights from"
	.align 2
.LC64:
	.string	"'s BFG"
	.align 2
.LC65:
	.string	"was disintegrated by"
	.align 2
.LC66:
	.string	"'s BFG blast"
	.align 2
.LC67:
	.string	"couldn't hide from"
	.align 2
.LC68:
	.string	"caught"
	.align 2
.LC69:
	.string	"'s handgrenade"
	.align 2
.LC70:
	.string	"didn't see"
	.align 2
.LC71:
	.string	"feels"
	.align 2
.LC72:
	.string	"'s pain"
	.align 2
.LC73:
	.string	"tried to invade"
	.align 2
.LC74:
	.string	"'s personal space"
	.align 2
.LC75:
	.string	"was caught by"
	.align 2
.LC76:
	.string	"'s grapple"
	.align 2
.LC77:
	.string	"%s %s %s%s\n"
	.align 2
.LC78:
	.string	"%s died.\n"
	.align 2
.LC79:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,coop@ha
	lis 8,.LC79@ha
	lwz 11,coop@l(9)
	la 8,.LC79@l(8)
	mr 30,3
	lfs 13,0(8)
	mr 29,5
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L36
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L36:
	lis 11,.LC79@ha
	lis 9,deathmatch@ha
	la 11,.LC79@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L38
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L37
.L38:
	lis 9,meansOfDeath@ha
	lis 11,.LC22@ha
	lwz 0,meansOfDeath@l(9)
	la 31,.LC22@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	rlwinm 27,0,0,4,4
	addi 10,28,-17
	cmplwi 0,10,16
	bc 12,1,.L39
	lis 11,.L54@ha
	slwi 10,10,2
	la 11,.L54@l(11)
	lis 9,.L54@ha
	lwzx 0,10,11
	la 9,.L54@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L54:
	.long .L43-.L54
	.long .L44-.L54
	.long .L45-.L54
	.long .L42-.L54
	.long .L39-.L54
	.long .L41-.L54
	.long .L40-.L54
	.long .L39-.L54
	.long .L47-.L54
	.long .L47-.L54
	.long .L53-.L54
	.long .L48-.L54
	.long .L53-.L54
	.long .L49-.L54
	.long .L53-.L54
	.long .L39-.L54
	.long .L50-.L54
.L40:
	lis 9,.LC23@ha
	la 6,.LC23@l(9)
	b .L39
.L41:
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
	b .L39
.L42:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L39
.L43:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L39
.L44:
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L39
.L45:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L39
.L47:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L39
.L48:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L39
.L49:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L39
.L50:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L39
.L53:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
.L39:
	cmpw 0,29,30
	bc 4,2,.L56
	addi 10,28,-7
	cmplwi 0,10,17
	bc 12,1,.L83
	lis 11,.L94@ha
	slwi 10,10,2
	la 11,.L94@l(11)
	lis 9,.L94@ha
	lwzx 0,10,11
	la 9,.L94@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L94:
	.long .L60-.L94
	.long .L83-.L94
	.long .L71-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L82-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L60-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L58-.L94
.L58:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L56
.L60:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L62
	li 10,0
	b .L63
.L62:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
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
	bc 12,2,.L63
	cmpwi 0,11,109
	bc 12,2,.L63
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L63:
	cmpwi 0,10,0
	bc 12,2,.L61
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L56
.L61:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L67
	li 0,0
	b .L68
.L67:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L68:
	cmpwi 0,0,0
	bc 12,2,.L66
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L56
.L66:
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L56
.L71:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L73
	li 10,0
	b .L74
.L73:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
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
	bc 12,2,.L74
	cmpwi 0,11,109
	bc 12,2,.L74
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L74:
	cmpwi 0,10,0
	bc 12,2,.L72
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L56
.L72:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L78
	li 0,0
	b .L79
.L78:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L79:
	cmpwi 0,0,0
	bc 12,2,.L77
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L56
.L77:
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L56
.L82:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
	b .L56
.L83:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L85
	li 10,0
	b .L86
.L85:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
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
	bc 12,2,.L86
	cmpwi 0,11,109
	bc 12,2,.L86
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L86:
	cmpwi 0,10,0
	bc 12,2,.L84
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
	b .L56
.L84:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L90
	li 0,0
	b .L91
.L90:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L91:
	cmpwi 0,0,0
	bc 12,2,.L89
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L56
.L89:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
.L56:
	cmpwi 0,6,0
	bc 12,2,.L95
	lwz 5,84(30)
	lis 4,.LC45@ha
	li 3,1
	la 4,.LC45@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC79@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC79@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L96
	lwz 11,84(30)
	lwz 9,3448(11)
	addi 9,9,-1
	stw 9,3448(11)
.L96:
	li 0,0
	stw 0,540(30)
	b .L35
.L95:
	cmpwi 0,29,0
	stw 29,540(30)
	bc 12,2,.L37
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L37
	addi 0,28,-1
	cmplwi 0,0,33
	bc 12,1,.L98
	lis 11,.L118@ha
	slwi 10,0,2
	la 11,.L118@l(11)
	lis 9,.L118@ha
	lwzx 0,10,11
	la 9,.L118@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L118:
	.long .L99-.L118
	.long .L100-.L118
	.long .L101-.L118
	.long .L102-.L118
	.long .L103-.L118
	.long .L104-.L118
	.long .L105-.L118
	.long .L106-.L118
	.long .L107-.L118
	.long .L108-.L118
	.long .L109-.L118
	.long .L110-.L118
	.long .L111-.L118
	.long .L112-.L118
	.long .L113-.L118
	.long .L114-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L116-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L115-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L98-.L118
	.long .L117-.L118
.L99:
	lis 9,.LC46@ha
	la 6,.LC46@l(9)
	b .L98
.L100:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L98
.L101:
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 6,.LC48@l(9)
	la 31,.LC49@l(11)
	b .L98
.L102:
	lis 9,.LC50@ha
	la 6,.LC50@l(9)
	b .L98
.L103:
	lis 9,.LC51@ha
	lis 11,.LC52@ha
	la 6,.LC51@l(9)
	la 31,.LC52@l(11)
	b .L98
.L104:
	lis 9,.LC53@ha
	lis 11,.LC54@ha
	la 6,.LC53@l(9)
	la 31,.LC54@l(11)
	b .L98
.L105:
	lis 9,.LC55@ha
	lis 11,.LC56@ha
	la 6,.LC55@l(9)
	la 31,.LC56@l(11)
	b .L98
.L106:
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 6,.LC57@l(9)
	la 31,.LC58@l(11)
	b .L98
.L107:
	lis 9,.LC59@ha
	lis 11,.LC58@ha
	la 6,.LC59@l(9)
	la 31,.LC58@l(11)
	b .L98
.L108:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 31,.LC61@l(11)
	b .L98
.L109:
	lis 9,.LC62@ha
	la 6,.LC62@l(9)
	b .L98
.L110:
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	la 6,.LC63@l(9)
	la 31,.LC64@l(11)
	b .L98
.L111:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 6,.LC65@l(9)
	la 31,.LC66@l(11)
	b .L98
.L112:
	lis 9,.LC67@ha
	lis 11,.LC64@ha
	la 6,.LC67@l(9)
	la 31,.LC64@l(11)
	b .L98
.L113:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 6,.LC68@l(9)
	la 31,.LC69@l(11)
	b .L98
.L114:
	lis 9,.LC70@ha
	lis 11,.LC69@ha
	la 6,.LC70@l(9)
	la 31,.LC69@l(11)
	b .L98
.L115:
	lis 9,.LC71@ha
	lis 11,.LC72@ha
	la 6,.LC71@l(9)
	la 31,.LC72@l(11)
	b .L98
.L116:
	lis 9,.LC73@ha
	lis 11,.LC74@ha
	la 6,.LC73@l(9)
	la 31,.LC74@l(11)
	b .L98
.L117:
	lis 9,.LC75@ha
	lis 11,.LC76@ha
	la 6,.LC75@l(9)
	la 31,.LC76@l(11)
.L98:
	cmpwi 0,6,0
	bc 12,2,.L37
	lwz 5,84(30)
	lis 4,.LC77@ha
	mr 8,31
	la 4,.LC77@l(4)
	addi 7,7,700
	addi 5,5,700
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC79@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC79@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	cmpwi 0,27,0
	bc 12,2,.L122
	lwz 11,84(29)
	b .L125
.L122:
	lwz 11,84(29)
	lwz 9,3448(11)
	addi 9,9,1
	b .L126
.L37:
	lwz 5,84(30)
	lis 4,.LC78@ha
	li 3,1
	la 4,.LC78@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC79@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC79@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	lwz 11,84(30)
.L125:
	lwz 9,3448(11)
	addi 9,9,-1
.L126:
	stw 9,3448(11)
.L35:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC80:
	.string	"Blaster"
	.align 2
.LC81:
	.string	"item_quad"
	.align 3
.LC82:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC83:
	.long 0x0
	.align 3
.LC84:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC85:
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
	lis 10,.LC83@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC83@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L127
	lwz 9,84(30)
	lwz 11,3548(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L130
	lwz 3,40(31)
	lis 4,.LC80@ha
	la 4,.LC80@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L130:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L131
	li 29,0
	b .L132
.L131:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC84@ha
	lfs 12,3744(8)
	addi 9,9,10
	la 10,.LC84@l(10)
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
.L132:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC83@ha
	and. 10,0,29
	la 9,.LC83@l(9)
	lfs 31,0(9)
	bc 12,2,.L133
	lis 11,.LC85@ha
	la 11,.LC85@l(11)
	lfs 31,0(11)
.L133:
	cmpwi 0,31,0
	bc 12,2,.L135
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3676(9)
	fsubs 0,0,31
	stfs 0,3676(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3676(9)
	fadds 0,0,31
	stfs 0,3676(9)
	stw 0,284(3)
.L135:
	cmpwi 0,29,0
	bc 12,2,.L127
	lwz 9,84(30)
	lis 3,.LC81@ha
	la 3,.LC81@l(3)
	lfs 0,3676(9)
	fadds 0,0,31
	stfs 0,3676(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC84@ha
	lis 11,Touch_Item@ha
	la 9,.LC84@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3676(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC82@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC82@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3676(7)
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
	lfs 0,3744(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L127:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 3
.LC86:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC87:
	.long 0x0
	.align 2
.LC88:
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
	bc 12,2,.L138
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L138
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L148
.L138:
	cmpwi 0,4,0
	bc 12,2,.L140
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L140
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L148:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L139
.L140:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3600(9)
	b .L137
.L139:
	lis 9,.LC87@ha
	lfs 2,8(1)
	la 9,.LC87@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L142
	lfs 1,12(1)
	bl atan2
	lis 9,.LC86@ha
	lwz 11,84(31)
	lfd 0,.LC86@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3600(11)
	b .L143
.L142:
	lwz 9,84(31)
	stfs 13,3600(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L144
	lwz 9,84(31)
	lis 0,0x42b4
	b .L149
.L144:
	bc 4,0,.L143
	lwz 9,84(31)
	lis 0,0xc2b4
.L149:
	stw 0,3600(9)
.L143:
	lwz 3,84(31)
	lis 9,.LC87@ha
	la 9,.LC87@l(9)
	lfs 0,0(9)
	lfs 13,3600(3)
	fcmpu 0,13,0
	bc 4,0,.L137
	lis 11,.LC88@ha
	la 11,.LC88@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3600(3)
.L137:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 LookAtKiller,.Lfe4-LookAtKiller
	.section	".rodata"
	.align 2
.LC89:
	.string	"misc/udeath.wav"
	.align 2
.LC90:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.42:
	.space	4
	.size	 i.42,4
	.section	".rodata"
	.align 2
.LC91:
	.string	"*death%i.wav"
	.align 2
.LC92:
	.long 0x0
	.align 3
.LC93:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC94:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 9,.LC92@ha
	mr 31,3
	la 9,.LC92@l(9)
	li 11,0
	lwz 10,84(31)
	lfs 31,0(9)
	li 0,1
	lis 8,0xc100
	li 9,7
	stw 0,512(31)
	mr 30,4
	stw 9,260(31)
	mr 29,5
	mr 27,6
	stfs 31,396(31)
	stfs 31,392(31)
	stfs 31,388(31)
	stw 11,44(31)
	stw 11,48(31)
	stfs 31,16(31)
	stfs 31,24(31)
	stw 11,76(31)
	stw 11,3772(10)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 8,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L151
	lis 9,level+4@ha
	lis 11,.LC93@ha
	lfs 0,level+4@l(9)
	la 11,.LC93@l(11)
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3828(11)
	bl LookAtKiller
	lwz 9,84(31)
	li 0,2
	mr 3,31
	mr 4,30
	mr 5,29
	stw 0,0(9)
	bl ClientObituary
	mr 4,30
	mr 5,29
	mr 3,31
	bl CTFFragBonuses
	mr 3,31
	bl TossClientWeapon
	mr 3,31
	bl CTFPlayerResetGrapple
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L152
	mr 3,31
	bl Cmd_Help_f
.L152:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,30,0
	bc 4,0,.L151
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 5,10
	lwz 7,coop@l(11)
	addi 8,9,56
	li 6,0
	lis 9,.LC92@ha
	li 10,0
	la 9,.LC92@l(9)
	lfs 13,0(9)
.L156:
	lfs 0,20(7)
	fcmpu 0,0,13
	bc 12,2,.L157
	lwz 0,0(8)
	andi. 11,0,16
	bc 12,2,.L157
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2368
	stwx 0,9,10
.L157:
	lwz 9,84(31)
	addi 30,30,1
	addi 8,8,76
	addi 9,9,740
	stwx 6,9,10
	lwz 0,1556(5)
	addi 10,10,4
	cmpw 0,30,0
	bc 12,0,.L156
.L151:
	lwz 11,84(31)
	li 0,0
	stw 0,3744(11)
	lwz 9,84(31)
	stw 0,3748(9)
	lwz 11,84(31)
	stw 0,3752(11)
	lwz 9,84(31)
	stw 0,3756(9)
	lwz 11,480(31)
	lwz 0,264(31)
	cmpwi 0,11,-40
	rlwinm 0,0,0,20,18
	stw 0,264(31)
	bc 4,0,.L159
	lis 29,gi@ha
	lis 3,.LC89@ha
	la 29,gi@l(29)
	la 3,.LC89@l(3)
	lwz 9,36(29)
	lis 28,.LC90@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC94@ha
	lwz 0,16(29)
	lis 11,.LC94@ha
	la 9,.LC94@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC94@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC92@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC92@l(9)
	lfs 3,0(9)
	blrl
.L163:
	mr 3,31
	la 4,.LC90@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L163
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	lwz 10,84(31)
	li 0,5
	li 11,0
	stw 0,3732(10)
	lwz 9,84(31)
	stw 11,3728(9)
	stw 11,512(31)
	b .L165
.L159:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L165
	lis 8,i.42@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.42@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.42@l(8)
	stw 7,3732(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L167
	li 0,172
	li 9,177
	b .L176
.L167:
	cmpwi 0,10,1
	bc 12,2,.L171
	bc 12,1,.L175
	cmpwi 0,10,0
	bc 12,2,.L170
	b .L168
.L175:
	cmpwi 0,10,2
	bc 12,2,.L172
	b .L168
.L170:
	li 0,177
	li 9,183
	b .L176
.L171:
	li 0,183
	li 9,189
	b .L176
.L172:
	li 0,189
	li 9,197
.L176:
	stw 0,56(31)
	stw 9,3728(11)
.L168:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC91@ha
	srwi 0,0,30
	la 3,.LC91@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC94@ha
	lwz 0,16(29)
	lis 11,.LC94@ha
	la 9,.LC94@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC94@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC92@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC92@l(9)
	lfs 3,0(9)
	blrl
.L165:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 player_die,.Lfe5-player_die
	.section	".rodata"
	.align 2
.LC95:
	.string	"Grapple"
	.align 2
.LC98:
	.string	"info_player_deathmatch"
	.align 2
.LC97:
	.long 0x47c34f80
	.align 2
.LC99:
	.long 0x4b18967f
	.align 2
.LC100:
	.long 0x3f800000
	.align 3
.LC101:
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
	lis 9,.LC97@ha
	li 28,0
	lfs 29,.LC97@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC98@ha
	b .L200
.L202:
	lis 10,.LC100@ha
	lis 9,maxclients@ha
	la 10,.LC100@l(10)
	lis 11,.LC99@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC99@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L210
	lis 11,.LC101@ha
	lis 26,g_edicts@ha
	la 11,.LC101@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,952
.L205:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L207
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L207
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
	bc 4,0,.L207
	fmr 31,1
.L207:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,952
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L205
.L210:
	fcmpu 0,31,28
	bc 4,0,.L212
	fmr 28,31
	mr 24,30
	b .L200
.L212:
	fcmpu 0,31,29
	bc 4,0,.L200
	fmr 29,31
	mr 23,30
.L200:
	lis 5,.LC98@ha
	mr 3,30
	la 5,.LC98@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L202
	cmpwi 0,28,0
	bc 4,2,.L216
	li 3,0
	b .L224
.L216:
	cmpwi 0,28,2
	bc 12,1,.L217
	li 23,0
	li 24,0
	b .L218
.L217:
	addi 28,28,-2
.L218:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L223:
	mr 3,30
	li 4,280
	la 5,.LC98@l(22)
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
	bc 4,2,.L223
.L224:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe6:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe6-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC102:
	.long 0x4b18967f
	.align 2
.LC103:
	.long 0x0
	.align 2
.LC104:
	.long 0x3f800000
	.align 3
.LC105:
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
	lis 9,.LC103@ha
	li 31,0
	la 9,.LC103@l(9)
	li 25,0
	lfs 29,0(9)
	b .L226
.L228:
	lis 9,maxclients@ha
	lis 11,.LC104@ha
	lwz 10,maxclients@l(9)
	la 11,.LC104@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC102@ha
	lfs 31,.LC102@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L236
	lis 9,.LC105@ha
	lis 27,g_edicts@ha
	la 9,.LC105@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,952
.L231:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L233
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L233
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
	bc 4,0,.L233
	fmr 31,1
.L233:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,952
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L231
.L236:
	fcmpu 0,31,29
	bc 4,1,.L226
	fmr 29,31
	mr 25,31
.L226:
	lis 30,.LC98@ha
	mr 3,31
	li 4,280
	la 5,.LC98@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L228
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L241
	la 5,.LC98@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L241:
	lwz 0,100(1)
	mtlr 0
	lmw 25,44(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe7:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe7-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC106:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC107:
	.long 0x0
	.align 2
.LC108:
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
	lis 11,.LC107@ha
	lis 9,deathmatch@ha
	la 11,.LC107@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 31,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L256
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L257
	bl SelectCTFSpawnPoint
	mr 31,3
	b .L262
.L257:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L259
	bl SelectFarthestDeathmatchSpawnPoint
	mr 31,3
	b .L262
.L259:
	bl SelectRandomDeathmatchSpawnPoint
	mr 31,3
	b .L262
.L286:
	li 31,0
	b .L262
.L256:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L262
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xa99b
	lwz 10,game+1028@l(11)
	ori 9,9,19403
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 30,0,3
	bc 12,2,.L262
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 31,game+1032@ha
.L268:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L286
	lwz 4,300(29)
	la 9,.LC22@l(28)
	la 3,game+1032@l(31)
	srawi 11,4,31
	xor 0,11,4
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 4,4,0
	or 4,4,9
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L268
	addic. 30,30,-1
	bc 4,2,.L268
	mr 31,29
.L262:
	cmpwi 0,31,0
	bc 4,2,.L274
	lis 29,.LC0@ha
	lis 30,game@ha
.L281:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L287
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L285
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L276
	b .L281
.L285:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L281
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L281
.L276:
	cmpwi 0,31,0
	bc 4,2,.L274
.L287:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L283
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L283:
	cmpwi 0,31,0
	bc 4,2,.L274
	lis 9,gi+28@ha
	lis 3,.LC106@ha
	lwz 0,gi+28@l(9)
	la 3,.LC106@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L274:
	lfs 0,4(31)
	lis 9,.LC108@ha
	la 9,.LC108@l(9)
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
.Lfe8:
	.size	 SelectSpawnPoint,.Lfe8-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC109:
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
	mulli 27,27,952
	addi 27,27,952
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
	lis 9,0x46fd
	lis 11,body_die@ha
	ori 9,9,55623
	la 11,body_die@l(11)
	subf 0,0,29
	li 10,1
	mullw 0,0,9
	mr 3,29
	srawi 0,0,3
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
	lwz 0,248(28)
	stw 0,248(29)
	lwz 9,252(28)
	stw 9,252(29)
	lwz 0,256(28)
	stw 0,256(29)
	lwz 9,260(28)
	stw 11,456(29)
	stw 9,260(29)
	stw 10,512(29)
	lwz 0,72(26)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 CopyToBodyQue,.Lfe9-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC110:
	.string	"menu_loadgame\n"
	.align 2
.LC111:
	.string	"spectator"
	.align 2
.LC112:
	.string	"none"
	.align 2
.LC113:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC114:
	.string	"spectator 0\n"
	.align 2
.LC115:
	.string	"Server spectator limit is full."
	.align 2
.LC116:
	.string	"password"
	.align 2
.LC117:
	.string	"Password incorrect.\n"
	.align 2
.LC118:
	.string	"spectator 1\n"
	.align 2
.LC119:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC120:
	.string	"%s joined the game\n"
	.align 2
.LC121:
	.long 0x3f800000
	.align 3
.LC122:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl spectator_respawn
	.type	 spectator_respawn,@function
spectator_respawn:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L308
	lis 4,.LC111@ha
	addi 3,3,188
	la 4,.LC111@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L309
	lis 4,.LC112@ha
	la 4,.LC112@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L309
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L309
	lis 5,.LC113@ha
	li 4,2
	la 5,.LC113@l(5)
	mr 3,31
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC114@ha
	la 3,.LC114@l(3)
	b .L322
.L309:
	lis 9,maxclients@ha
	lis 10,.LC121@ha
	lwz 11,maxclients@l(9)
	la 10,.LC121@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L311
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	addi 10,11,952
	lfd 13,0(9)
.L313:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L312
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L312:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,952
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L313
.L311:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,28(1)
	lis 10,.LC122@ha
	la 10,.LC122@l(10)
	stw 11,24(1)
	lfd 12,0(10)
	lfd 0,24(1)
	lis 10,maxspectators@ha
	lwz 11,maxspectators@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L317
	lis 5,.LC115@ha
	li 4,2
	la 5,.LC115@l(5)
	mr 3,31
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC114@ha
	la 3,.LC114@l(3)
	b .L322
.L308:
	lis 4,.LC116@ha
	addi 3,3,188
	la 4,.LC116@l(4)
	lis 30,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L317
	lis 4,.LC112@ha
	la 4,.LC112@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L317
	lwz 9,password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L317
	lis 5,.LC117@ha
	li 4,2
	la 5,.LC117@l(5)
	mr 3,31
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC118@ha
	la 3,.LC118@l(3)
.L322:
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L307
.L317:
	lwz 11,84(31)
	li 9,0
	mr 3,31
	stw 9,3448(11)
	stw 9,1800(11)
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L319
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x46fd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,55623
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
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
	lwz 11,84(31)
	li 0,32
	li 10,14
	stb 0,16(11)
	lwz 9,84(31)
	stb 10,17(9)
.L319:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3828(11)
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L320
	lis 4,.LC119@ha
	addi 5,3,700
	la 4,.LC119@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	b .L307
.L320:
	lis 4,.LC120@ha
	addi 5,3,700
	la 4,.LC120@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
.L307:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 spectator_respawn,.Lfe10-spectator_respawn
	.section	".rodata"
	.align 2
.LC123:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC124:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC125:
	.string	"player"
	.align 2
.LC126:
	.string	"players/male/tris.md2"
	.align 2
.LC127:
	.string	"fov"
	.align 2
.LC128:
	.long 0x0
	.align 2
.LC129:
	.long 0x41400000
	.align 2
.LC130:
	.long 0x41000000
	.align 3
.LC131:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC132:
	.long 0x3f800000
	.align 2
.LC133:
	.long 0x43200000
	.align 2
.LC134:
	.long 0x47800000
	.align 2
.LC135:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4496(1)
	mflr 0
	stfd 31,4488(1)
	stmw 19,4436(1)
	stw 0,4500(1)
	lis 9,.LC123@ha
	lis 8,.LC124@ha
	lwz 0,.LC123@l(9)
	addi 10,1,8
	la 29,.LC124@l(8)
	la 9,.LC123@l(9)
	lwz 11,.LC124@l(8)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 19,5
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
	lis 9,.LC128@ha
	lis 11,g_edicts@ha
	lwz 30,84(31)
	la 9,.LC128@l(9)
	lis 0,0x46fd
	lfs 13,0(9)
	ori 0,0,55623
	lis 9,deathmatch@ha
	lwz 10,deathmatch@l(9)
	lwz 9,g_edicts@l(11)
	lfs 0,20(10)
	subf 9,9,31
	mullw 9,9,0
	fcmpu 0,0,13
	srawi 9,9,3
	addi 21,9,-1
	bc 12,2,.L324
	addi 26,1,1704
	addi 25,30,1816
	mr 4,25
	li 5,1680
	mr 3,26
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 22,29
	lis 28,0x286b
	addi 23,1,3384
	mr 4,29
	li 5,512
	mr 3,23
	crxor 6,6,6
	bl memcpy
	ori 28,28,51739
	li 27,1
	li 4,0
	li 5,1628
	mr 3,29
	addi 24,30,740
	crxor 6,6,6
	bl memset
	mr 20,26
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	bl FindItem
	lis 29,itemlist@ha
	mr 11,3
	la 29,itemlist@l(29)
	lis 3,.LC95@ha
	subf 0,29,11
	la 3,.LC95@l(3)
	mullw 0,0,28
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(30)
	stwx 27,24,9
	stw 11,1792(30)
	stw 11,1788(30)
	bl FindItem
	subf 0,29,3
	li 9,100
	mullw 0,0,28
	li 11,50
	li 10,200
	mr 4,23
	mr 3,31
	rlwinm 0,0,0,0,29
	stwx 27,24,0
	stw 9,1768(30)
	stw 10,1780(30)
	stw 11,1784(30)
	stw 27,720(30)
	stw 9,724(30)
	stw 9,728(30)
	stw 10,1764(30)
	stw 11,1772(30)
	stw 11,1776(30)
	bl ClientUserinfoChanged
	b .L326
.L324:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L327
	addi 28,1,1704
	addi 27,30,1816
	mr 4,27
	li 5,1680
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 20,28
	mr 25,27
	addi 26,1,3896
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	mr 22,29
	lwz 9,1804(30)
	mr 4,28
	li 5,1628
	mr 3,29
	stw 9,3320(1)
	lwz 0,1808(30)
	stw 0,3324(1)
	crxor 6,6,6
	bl memcpy
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3336(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L326
	stw 9,1800(30)
	b .L326
.L327:
	addi 29,1,1704
	li 4,0
	mr 3,29
	li 5,1680
	crxor 6,6,6
	bl memset
	mr 20,29
	addi 25,30,1816
	addi 22,30,188
.L326:
	addi 29,1,72
	mr 4,22
	li 5,1628
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3864
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,22
	li 5,1628
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L330
	li 4,0
	li 5,1628
	mr 3,22
	lis 28,0x286b
	crxor 6,6,6
	bl memset
	ori 28,28,51739
	li 27,1
	lis 3,.LC80@ha
	addi 26,30,740
	la 3,.LC80@l(3)
	bl FindItem
	lis 29,itemlist@ha
	mr 11,3
	la 29,itemlist@l(29)
	lis 3,.LC95@ha
	subf 0,29,11
	la 3,.LC95@l(3)
	mullw 0,0,28
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(30)
	stwx 27,26,9
	stw 11,1792(30)
	stw 11,1788(30)
	bl FindItem
	subf 3,29,3
	li 0,100
	mullw 3,3,28
	li 9,50
	li 11,200
	rlwinm 3,3,0,0,29
	stwx 27,26,3
	stw 0,1768(30)
	stw 11,1780(30)
	stw 9,1784(30)
	stw 27,720(30)
	stw 0,724(30)
	stw 0,728(30)
	stw 11,1764(30)
	stw 9,1772(30)
	stw 9,1776(30)
.L330:
	lis 9,.LC128@ha
	mr 3,25
	la 9,.LC128@l(9)
	mr 4,20
	lfs 31,0(9)
	li 5,1680
	crxor 6,6,6
	bl memcpy
	lwz 7,84(31)
	lis 10,coop@ha
	lwz 8,coop@l(10)
	lwz 9,724(7)
	lwz 11,264(31)
	stw 9,480(31)
	lwz 0,728(7)
	stw 0,484(31)
	lwz 9,732(7)
	or 11,11,9
	stw 11,264(31)
	lfs 0,20(8)
	fcmpu 0,0,31
	bc 12,2,.L333
	lwz 0,1800(7)
	stw 0,3448(7)
.L333:
	li 7,0
	lis 11,game+1028@ha
	mulli 8,21,3864
	lwz 6,264(31)
	stw 7,552(31)
	li 0,4
	lis 9,.LC125@ha
	lwz 3,game+1028@l(11)
	li 5,2
	la 9,.LC125@l(9)
	li 11,22
	stw 0,260(31)
	li 10,1
	stw 11,508(31)
	add 3,3,8
	li 0,200
	lis 11,.LC129@ha
	stw 10,88(31)
	lis 29,level+4@ha
	stw 9,280(31)
	la 11,.LC129@l(11)
	lis 10,0x201
	stw 0,400(31)
	lis 8,.LC126@ha
	lis 9,player_pain@ha
	stw 5,248(31)
	la 8,.LC126@l(8)
	la 9,player_pain@l(9)
	stw 5,512(31)
	ori 10,10,3
	rlwinm 6,6,0,21,19
	stw 3,84(31)
	li 28,-1
	li 4,0
	stw 7,492(31)
	li 5,184
	lfs 0,level+4@l(29)
	lfs 13,0(11)
	lfs 12,8(1)
	lis 11,player_die@ha
	lfs 11,12(1)
	la 11,player_die@l(11)
	fadds 0,0,13
	lwz 0,184(31)
	lfs 13,16(1)
	lfs 10,24(1)
	rlwinm 0,0,0,31,29
	stfs 0,404(31)
	stw 10,252(31)
	stw 8,268(31)
	stw 9,452(31)
	stw 11,456(31)
	stw 0,184(31)
	stfs 12,188(31)
	stfs 11,192(31)
	stfs 13,196(31)
	stw 6,264(31)
	stw 28,940(31)
	stw 7,896(31)
	stw 7,612(31)
	stw 7,608(31)
	stw 7,892(31)
	stfs 10,200(31)
	lfs 0,28(1)
	lfs 13,32(1)
	stfs 31,384(31)
	stfs 0,204(31)
	stfs 13,208(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC130@ha
	lfs 0,40(1)
	lis 8,deathmatch@ha
	la 9,.LC130@l(9)
	lbz 0,16(30)
	lfs 10,0(9)
	andi. 0,0,191
	mr 11,9
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4424(1)
	lwz 9,4428(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4424(1)
	lwz 11,4428(1)
	sth 11,6(30)
	lfs 0,48(1)
	stb 0,16(30)
	lwz 9,deathmatch@l(8)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4424(1)
	lwz 10,4428(1)
	sth 10,8(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L334
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4424(1)
	lwz 11,4428(1)
	andi. 0,11,32768
	bc 4,2,.L349
.L334:
	lis 4,.LC127@ha
	mr 3,22
	la 4,.LC127@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4428(1)
	lis 0,0x4330
	lis 11,.LC131@ha
	la 11,.LC131@l(11)
	stw 0,4424(1)
	lfd 13,0(11)
	lfd 0,4424(1)
	lis 11,.LC132@ha
	la 11,.LC132@l(11)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L336
.L349:
	lis 0,0x42b4
	stw 0,112(30)
	b .L335
.L336:
	lis 9,.LC133@ha
	la 9,.LC133@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L335
	stfs 13,112(30)
.L335:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 11,.LC135@ha
	lis 9,.LC134@ha
	stw 3,88(30)
	la 11,.LC135@l(11)
	la 9,.LC134@l(9)
	lfs 13,48(1)
	lfs 10,0(11)
	lis 0,0x46fd
	li 10,255
	lis 11,g_edicts@ha
	lfs 9,0(9)
	ori 0,0,55623
	lwz 9,g_edicts@l(11)
	mr 5,19
	addi 6,30,3480
	lis 11,.LC132@ha
	lfs 11,40(1)
	addi 7,30,20
	la 11,.LC132@l(11)
	subf 9,9,31
	lfs 12,44(1)
	lfs 0,0(11)
	mullw 9,9,0
	li 8,0
	li 0,3
	li 11,0
	stw 10,44(31)
	mtctr 0
	srawi 9,9,3
	stw 11,56(31)
	fadds 13,13,0
	addi 9,9,-1
	stfs 11,28(31)
	stfs 12,32(31)
	stw 9,60(31)
	stfs 13,36(31)
	stw 11,64(31)
	stw 10,40(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L348:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4424(1)
	lwz 9,4428(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L348
	lfs 0,60(1)
	li 0,0
	stw 0,24(31)
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(30)
	lfs 13,20(31)
	lwz 9,1812(30)
	stfs 13,32(30)
	cmpwi 0,9,0
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,3672(30)
	lfs 0,20(31)
	stfs 0,3676(30)
	lfs 13,24(31)
	stfs 13,3680(30)
	bc 12,2,.L344
	li 9,0
	li 10,1
	stw 10,3492(30)
	lis 8,gi+72@ha
	mr 3,31
	stw 9,3856(30)
	lwz 0,184(31)
	lwz 11,84(31)
	ori 0,0,1
	stw 10,260(31)
	stw 0,184(31)
	stw 9,248(31)
	stw 9,88(11)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L323
.L344:
	stw 9,3492(30)
	mr 3,31
	bl CTFStartClient
	cmpwi 0,3,0
	bc 4,2,.L323
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1788(30)
	mr 3,31
	stw 0,3568(30)
	bl ChangeWeapon
.L323:
	lwz 0,4500(1)
	mtlr 0
	lmw 19,4436(1)
	lfd 31,4488(1)
	la 1,4496(1)
	blr
.Lfe11:
	.size	 PutClientInServer,.Lfe11-PutClientInServer
	.lcomm	current_map.94,55,4
	.section	".rodata"
	.align 2
.LC136:
	.string	"%s entered the game\n"
	.align 2
.LC137:
	.string	"\n======================================\nACE Bot II Mod\n\n'sv addbot' to add a new bot.\n'sv removebot <name>' to remove bot.\n======================================\n\n"
	.align 2
.LC138:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	bl G_InitEdict
	lwz 31,84(30)
	li 4,0
	li 5,1680
	addi 28,31,1816
	lwz 29,3452(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3452(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1628
	stw 0,3444(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC138@ha
	lis 11,ctf@ha
	la 9,.LC138@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L352
	lwz 0,3452(31)
	cmpwi 0,0,0
	bc 12,1,.L352
	mr 3,31
	bl CTFAssignTeam
.L352:
	mr 3,30
	bl ACEIT_PlayerAdded
	mr 3,30
	bl PutClientInServer
	lis 11,.LC138@ha
	lis 9,level+200@ha
	la 11,.LC138@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L353
	mr 3,30
	bl MoveClientToIntermission
	b .L354
.L353:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x46fd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,55623
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,30,4
	li 4,2
	mtlr 0
	blrl
.L354:
	lwz 5,84(30)
	lis 4,.LC136@ha
	li 3,2
	la 4,.LC136@l(4)
	lis 29,level+72@ha
	addi 5,5,700
	lis 31,current_map.94@ha
	crxor 6,6,6
	bl safe_bprintf
	lis 4,.LC137@ha
	mr 3,30
	la 4,.LC137@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	la 3,level+72@l(29)
	la 4,current_map.94@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L355
	bl ACEND_InitNodes
	bl ACEND_LoadNodes
	bl ACESP_LoadBots
	la 3,current_map.94@l(31)
	la 4,level+72@l(29)
	bl strcpy
.L355:
	mr 3,30
	bl ClientEndServerFrame
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ClientBeginDeathmatch,.Lfe12-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC139:
	.long 0x0
	.align 2
.LC140:
	.long 0x47800000
	.align 2
.LC141:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	lis 11,g_edicts@ha
	mr 30,3
	lwz 9,g_edicts@l(11)
	lis 0,0x46fd
	lis 10,deathmatch@ha
	ori 0,0,55623
	lis 11,game+1028@ha
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC139@ha
	srawi 9,9,3
	la 10,.LC139@l(10)
	mulli 9,9,3864
	lfs 31,0(10)
	addi 9,9,-3864
	add 8,8,9
	stw 8,84(30)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L357
	bl ClientBeginDeathmatch
	b .L356
.L357:
	lwz 0,88(30)
	cmpwi 0,0,1
	bc 4,2,.L358
	lis 9,.LC140@ha
	lis 10,.LC141@ha
	li 11,3
	la 9,.LC140@l(9)
	la 10,.LC141@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L370:
	lwz 10,84(30)
	add 0,8,8
	addi 8,8,1
	addi 9,10,28
	lfsx 0,9,7
	addi 10,10,20
	addi 7,7,4
	fmuls 0,0,11
	fdivs 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	sthx 11,10,0
	bdnz .L370
	b .L364
.L358:
	mr 3,30
	bl G_InitEdict
	lwz 31,84(30)
	lis 9,.LC125@ha
	li 4,0
	la 9,.LC125@l(9)
	li 5,1680
	stw 9,280(30)
	addi 28,31,1816
	lwz 29,3452(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3452(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1628
	stw 0,3444(31)
	crxor 6,6,6
	bl memcpy
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L366
	lwz 0,3452(31)
	cmpwi 0,0,0
	bc 12,1,.L366
	mr 3,31
	bl CTFAssignTeam
.L366:
	mr 3,30
	bl PutClientInServer
.L364:
	lis 10,.LC139@ha
	lis 9,level+200@ha
	la 10,.LC139@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L367
	mr 3,30
	bl MoveClientToIntermission
	b .L368
.L367:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L368
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x46fd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,55623
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	li 4,2
	addi 3,30,4
	mtlr 0
	blrl
	lwz 5,84(30)
	lis 4,.LC136@ha
	li 3,2
	la 4,.LC136@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L368:
	mr 3,30
	bl ClientEndServerFrame
.L356:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 ClientBegin,.Lfe13-ClientBegin
	.section	".rodata"
	.align 2
.LC142:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC143:
	.string	"name"
	.align 2
.LC144:
	.string	"0"
	.align 2
.LC145:
	.string	"skin"
	.align 2
.LC146:
	.string	"%s\\%s"
	.align 2
.LC147:
	.string	"hand"
	.align 2
.LC148:
	.long 0x0
	.align 3
.LC149:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC150:
	.long 0x3f800000
	.align 2
.LC151:
	.long 0x43200000
	.section	".text"
	.align 2
	.globl ClientUserinfoChanged
	.type	 ClientUserinfoChanged,@function
ClientUserinfoChanged:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 30,4
	mr 27,3
	mr 3,30
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L372
	lis 11,.LC142@ha
	lwz 0,.LC142@l(11)
	la 9,.LC142@l(11)
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
.L372:
	lis 4,.LC143@ha
	mr 3,30
	la 4,.LC143@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC111@ha
	mr 3,30
	la 4,.LC111@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC148@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC148@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L373
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L373
	lis 4,.LC144@ha
	la 4,.LC144@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L373
	lwz 9,84(27)
	li 0,1
	b .L383
.L373:
	lwz 9,84(27)
	li 0,0
.L383:
	stw 0,1812(9)
	lis 4,.LC145@ha
	mr 3,30
	la 4,.LC145@l(4)
	bl Info_ValueForKey
	lis 9,ctf@ha
	lis 11,g_edicts@ha
	lwz 10,ctf@l(9)
	mr 31,3
	lis 9,.LC148@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC148@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,27
	lis 9,0x46fd
	ori 9,9,55623
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,3
	bc 12,2,.L375
	mr 4,31
	mr 3,27
	bl CTFAssignSkin
	b .L376
.L375:
	lwz 4,84(27)
	lis 29,gi@ha
	lis 3,.LC146@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC146@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L376:
	lis 9,.LC148@ha
	lis 11,deathmatch@ha
	la 9,.LC148@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L377
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L377
	lwz 9,84(27)
	b .L384
.L377:
	lis 4,.LC127@ha
	mr 3,30
	la 4,.LC127@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC149@ha
	la 10,.LC149@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC150@ha
	la 10,.LC150@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L379
.L384:
	lis 0,0x42b4
	stw 0,112(9)
	b .L378
.L379:
	lis 11,.LC151@ha
	la 11,.LC151@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L378
	stfs 13,112(9)
.L378:
	lis 4,.LC147@ha
	mr 3,30
	la 4,.LC147@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L382
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L382:
	lwz 3,84(27)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 ClientUserinfoChanged,.Lfe14-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC152:
	.string	"ip"
	.align 2
.LC153:
	.string	"rejmsg"
	.align 2
.LC154:
	.string	"Banned."
	.align 2
.LC155:
	.string	"Spectator password required or incorrect."
	.align 2
.LC156:
	.string	"Password required or incorrect."
	.align 2
.LC157:
	.string	"%s connected\n"
	.align 2
.LC158:
	.long 0x0
	.align 3
.LC159:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 25,4
	mr 30,3
	lis 4,.LC152@ha
	mr 3,25
	la 4,.LC152@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L386
	lis 4,.LC153@ha
	lis 5,.LC154@ha
	mr 3,25
	la 4,.LC153@l(4)
	la 5,.LC154@l(5)
	b .L406
.L386:
	lis 4,.LC111@ha
	mr 3,25
	la 4,.LC111@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC158@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC158@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L387
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L387
	lis 4,.LC144@ha
	la 4,.LC144@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L387
	lis 29,spectator_password@ha
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L388
	lis 4,.LC112@ha
	la 4,.LC112@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L388
	lwz 9,spectator_password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L388
	lis 4,.LC153@ha
	lis 5,.LC155@ha
	mr 3,25
	la 4,.LC153@l(4)
	la 5,.LC155@l(5)
	b .L406
.L388:
	lis 9,maxclients@ha
	lis 10,.LC158@ha
	lwz 11,maxclients@l(9)
	la 10,.LC158@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L390
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC159@ha
	la 9,.LC159@l(9)
	addi 10,11,952
	lfd 13,0(9)
.L392:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L391
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L391:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,952
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L392
.L390:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,28(1)
	lis 10,.LC159@ha
	la 10,.LC159@l(10)
	stw 11,24(1)
	lfd 12,0(10)
	lfd 0,24(1)
	lis 10,maxspectators@ha
	lwz 11,maxspectators@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L396
	lis 4,.LC153@ha
	lis 5,.LC115@ha
	mr 3,25
	la 4,.LC153@l(4)
	la 5,.LC115@l(5)
	b .L406
.L387:
	lis 4,.LC116@ha
	mr 3,25
	la 4,.LC116@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(29)
	mr 31,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L396
	lis 4,.LC112@ha
	la 4,.LC112@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L396
	lwz 9,password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L396
	lis 4,.LC153@ha
	lis 5,.LC156@ha
	mr 3,25
	la 4,.LC153@l(4)
	la 5,.LC156@l(5)
.L406:
	bl Info_SetValueForKey
	li 3,0
	b .L405
.L396:
	lis 11,g_edicts@ha
	lis 0,0x46fd
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,55623
	lis 11,game+1028@ha
	cmpwi 0,10,0
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	srawi 9,9,3
	mulli 9,9,3864
	addi 9,9,-3864
	add 8,8,9
	stw 8,84(30)
	bc 4,2,.L398
	li 0,-1
	li 4,0
	stw 0,3452(8)
	li 5,1680
	lwz 31,84(30)
	addi 28,31,1816
	lwz 29,3452(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3452(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1628
	stw 0,3444(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC158@ha
	lis 11,ctf@ha
	la 9,.LC158@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L400
	lwz 0,3452(31)
	cmpwi 0,0,0
	bc 12,1,.L400
	mr 3,31
	bl CTFAssignTeam
.L400:
	lis 9,game+1560@ha
	lwz 31,84(30)
	lwz 0,game+1560@l(9)
	cmpwi 0,0,0
	bc 12,2,.L402
	lwz 0,1788(31)
	cmpwi 0,0,0
	bc 4,2,.L398
.L402:
	li 4,0
	li 5,1628
	addi 3,31,188
	lis 28,0x286b
	crxor 6,6,6
	bl memset
	ori 28,28,51739
	li 27,1
	lis 3,.LC80@ha
	addi 26,31,740
	la 3,.LC80@l(3)
	bl FindItem
	lis 29,itemlist@ha
	mr 11,3
	la 29,itemlist@l(29)
	lis 3,.LC95@ha
	subf 0,29,11
	la 3,.LC95@l(3)
	mullw 0,0,28
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 27,26,9
	stw 11,1792(31)
	stw 11,1788(31)
	bl FindItem
	subf 3,29,3
	li 0,100
	mullw 3,3,28
	li 9,50
	li 11,200
	rlwinm 3,3,0,0,29
	stwx 27,26,3
	stw 27,720(31)
	stw 0,1768(31)
	stw 11,1780(31)
	stw 9,1784(31)
	stw 0,724(31)
	stw 0,728(31)
	stw 11,1764(31)
	stw 9,1772(31)
	stw 9,1776(31)
.L398:
	mr 4,25
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L404
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC157@ha
	lwz 0,gi+4@l(9)
	la 3,.LC157@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L404:
	lwz 9,84(30)
	li 0,0
	li 11,1
	stw 0,184(30)
	li 3,1
	stw 11,720(9)
.L405:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 ClientConnect,.Lfe15-ClientConnect
	.section	".rodata"
	.align 2
.LC160:
	.string	"%s disconnected\n"
	.align 2
.LC161:
	.string	"disconnected"
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L407
	lis 4,.LC160@ha
	addi 5,5,700
	la 4,.LC160@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	lis 27,g_edicts@ha
	lis 28,0x46fd
	mr 3,31
	ori 28,28,55623
	bl ACEIT_PlayerRemoved
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 3,g_edicts@l(27)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,28
	mtlr 9
	srawi 3,3,3
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 9,88(29)
	li 4,2
	addi 3,31,4
	mtlr 9
	blrl
	lwz 9,76(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 3,g_edicts@l(27)
	lis 9,.LC161@ha
	li 0,0
	la 9,.LC161@l(9)
	lwz 11,84(31)
	lis 4,.LC22@ha
	stw 9,280(31)
	subf 3,3,31
	la 4,.LC22@l(4)
	stw 0,40(31)
	mullw 3,3,28
	stw 0,248(31)
	stw 0,88(31)
	srawi 3,3,3
	stw 0,720(11)
	addi 3,3,1311
	lwz 0,24(29)
	mtlr 0
	blrl
.L407:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 ClientDisconnect,.Lfe16-ClientDisconnect
	.section	".rodata"
	.align 2
.LC162:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC164:
	.string	"*jump1.wav"
	.align 3
.LC163:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC165:
	.long 0x0
	.align 3
.LC166:
	.long 0x40140000
	.long 0x0
	.align 3
.LC167:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC168:
	.long 0x41000000
	.align 3
.LC169:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC170:
	.long 0x3f800000
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
	lis 10,.LC165@ha
	la 9,level@l(9)
	la 10,.LC165@l(10)
	lfs 13,0(10)
	mr 28,3
	mr 26,4
	lfs 0,200(9)
	stw 28,292(9)
	lwz 31,84(28)
	fcmpu 0,0,13
	bc 12,2,.L432
	li 0,4
	lis 11,.LC166@ha
	stw 0,0(31)
	la 11,.LC166@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L431
	lbz 0,1(26)
	andi. 20,0,128
	bc 12,2,.L431
	li 0,1
	stw 0,208(9)
	b .L431
.L432:
	lwz 0,3856(31)
	lis 9,pm_passent@ha
	stw 28,pm_passent@l(9)
	cmpwi 0,0,0
	bc 12,2,.L434
	lha 0,2(26)
	lis 8,0x4330
	lis 9,.LC167@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC167@l(9)
	stw 0,260(1)
	lis 21,maxclients@ha
	stw 8,256(1)
	lfd 12,0(9)
	lfd 0,256(1)
	lis 9,.LC163@ha
	lfd 13,.LC163@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3480(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3484(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3488(31)
	b .L435
.L434:
	addi 3,1,8
	li 4,0
	mr 30,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L440
	lwz 0,40(28)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L440
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L440
	li 0,2
.L440:
	stw 0,0(31)
	lis 9,sv_gravity@ha
	lwz 7,0(31)
	lwz 10,sv_gravity@l(9)
	li 20,3
	addi 23,1,12
	lwz 0,8(31)
	mtctr 20
	addi 24,28,4
	addi 22,1,18
	lfs 0,20(10)
	addi 25,28,376
	mr 12,23
	lwz 9,12(31)
	lis 10,.LC168@ha
	mr 4,24
	lwz 8,4(31)
	la 10,.LC168@l(10)
	mr 3,22
	lfs 10,0(10)
	mr 5,25
	addi 29,31,3496
	addi 27,1,36
	lis 21,maxclients@ha
	li 6,0
	li 10,0
	fctiwz 13,0
	stfd 13,256(1)
	lwz 11,260(1)
	sth 11,18(31)
	stw 7,8(1)
	stw 8,4(30)
	stw 0,8(30)
	stw 9,12(30)
	lwz 0,16(31)
	lwz 9,20(31)
	lwz 11,24(31)
	stw 0,16(30)
	stw 9,20(30)
	stw 11,24(30)
.L492:
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
	bdnz .L492
	mr 3,29
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L447
	li 0,1
	stw 0,52(1)
.L447:
	lis 9,gi@ha
	lwz 7,0(26)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(26)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lis 20,.LC169@ha
	lwz 8,8(26)
	la 20,.LC169@l(20)
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
	lis 9,.LC167@ha
	lwz 11,8(1)
	mr 27,23
	la 9,.LC167@l(9)
	lwz 10,4(30)
	mr 3,25
	lfd 11,0(9)
	mr 4,22
	mr 5,24
	lwz 0,8(30)
	lis 6,0x4330
	li 7,0
	lwz 9,12(30)
	li 8,0
	stw 11,0(31)
	li 11,3
	stw 10,4(31)
	stw 0,8(31)
	mtctr 11
	stw 9,12(31)
	lwz 0,16(30)
	lwz 9,20(30)
	lwz 11,24(30)
	stw 0,16(31)
	stw 9,20(31)
	stw 11,24(31)
	lwz 0,8(1)
	lwz 9,4(30)
	lwz 11,8(30)
	lwz 10,12(30)
	stw 0,3496(31)
	stw 9,4(29)
	stw 11,8(29)
	stw 10,12(29)
	lwz 0,24(30)
	lwz 9,16(30)
	lwz 11,20(30)
	lfd 12,0(20)
	stw 0,24(29)
	stw 9,16(29)
	stw 11,20(29)
.L491:
	lhax 0,7,27
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
	stfsx 13,8,5
	stfsx 0,8,3
	addi 8,8,4
	bdnz .L491
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 20,.LC167@ha
	lis 7,.LC163@ha
	lfs 8,204(1)
	la 20,.LC167@l(20)
	lfs 9,208(1)
	lfs 10,212(1)
	lfs 11,224(1)
	stfs 0,200(28)
	stfs 13,204(28)
	stfs 8,188(28)
	stfs 9,192(28)
	stfs 10,196(28)
	stfs 11,208(28)
	lha 0,2(26)
	lfd 12,0(20)
	xoris 0,0,0x8000
	lfd 13,.LC163@l(7)
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3480(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3484(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3488(31)
	lwz 0,552(28)
	cmpwi 0,0,0
	bc 12,2,.L453
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L453
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L453
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L453
	li 0,1
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,896(28)
	lis 3,.LC164@ha
	lwz 9,36(29)
	la 3,.LC164@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC170@ha
	lis 10,.LC170@ha
	lis 11,.LC165@ha
	mr 5,3
	la 9,.LC170@l(9)
	la 10,.LC170@l(10)
	mtlr 0
	la 11,.LC165@l(11)
	mr 3,28
	lfs 1,0(9)
	li 4,2
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	mr 4,24
	mr 3,28
	li 5,0
	bl PlayerNoise
.L453:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(28)
	stw 11,608(28)
	fctiwz 13,0
	stw 10,552(28)
	stfd 13,256(1)
	lwz 9,260(1)
	stw 9,508(28)
	bc 12,2,.L454
	lwz 0,92(10)
	stw 0,556(28)
.L454:
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L455
	lfs 0,3600(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L456
.L455:
	lfs 0,188(1)
	stfs 0,3672(31)
	lfs 13,192(1)
	stfs 13,3676(31)
	lfs 0,196(1)
	stfs 0,3680(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L456:
	lwz 3,3832(31)
	cmpwi 0,3,0
	bc 12,2,.L457
	bl CTFGrapplePull
.L457:
	lis 9,gi+72@ha
	mr 3,28
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L458
	mr 3,28
	bl G_TouchTriggers
.L458:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L435
	addi 30,1,60
.L462:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,30,0
	addi 27,29,1
	bc 4,0,.L464
	lwz 0,0(30)
	cmpw 0,0,3
	bc 12,2,.L464
	mr 9,30
.L465:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L464
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L465
.L464:
	cmpw 0,11,29
	bc 4,2,.L461
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L461
	mr 4,28
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L461:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L462
.L435:
	lwz 0,3552(31)
	lwz 11,3560(31)
	stw 0,3556(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3552(31)
	or 11,11,0
	stw 11,3560(31)
	lbz 0,15(26)
	stw 0,640(28)
	lwz 9,3560(31)
	andi. 0,9,1
	bc 12,2,.L472
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L472
	lwz 0,3492(31)
	cmpwi 0,0,0
	bc 12,2,.L473
	lwz 0,3856(31)
	li 9,0
	stw 9,3560(31)
	cmpwi 0,0,0
	bc 12,2,.L474
	lbz 0,16(31)
	stw 9,3856(31)
	andi. 0,0,191
	stb 0,16(31)
	b .L472
.L474:
	mr 3,28
	bl GetChaseTarget
	b .L472
.L473:
	lwz 0,3564(31)
	cmpwi 0,0,0
	bc 4,2,.L472
	li 0,1
	mr 3,28
	stw 0,3564(31)
	bl Think_Weapon
.L472:
	mr 3,28
	bl CTFApplyRegeneration
	lwz 0,892(28)
	cmpwi 0,0,0
	bc 4,2,.L478
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 4,2,.L478
	lwz 9,84(28)
	lwz 0,3492(9)
	cmpwi 0,0,0
	bc 4,2,.L478
	mr 3,28
	bl ACEND_PathMap
.L478:
	lwz 0,3492(31)
	cmpwi 0,0,0
	bc 12,2,.L479
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L480
	lbz 0,16(31)
	andi. 9,0,2
	bc 4,2,.L479
	lwz 9,3856(31)
	ori 0,0,2
	stb 0,16(31)
	cmpwi 0,9,0
	bc 12,2,.L482
	mr 3,28
	bl ChaseNext
	b .L479
.L482:
	mr 3,28
	bl GetChaseTarget
	b .L479
.L480:
	lbz 0,16(31)
	andi. 0,0,253
	stb 0,16(31)
.L479:
	lis 9,maxclients@ha
	lis 10,.LC170@ha
	lwz 11,maxclients@l(9)
	la 10,.LC170@l(10)
	li 29,1
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L431
	lis 11,.LC167@ha
	lis 27,g_edicts@ha
	la 11,.LC167@l(11)
	lis 30,0x4330
	lfd 31,0(11)
	li 31,952
.L488:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L487
	lwz 9,84(3)
	lwz 0,3856(9)
	cmpw 0,0,28
	bc 4,2,.L487
	bl UpdateChaseCam
.L487:
	addi 29,29,1
	lwz 11,maxclients@l(21)
	xoris 0,29,0x8000
	addi 31,31,952
	stw 0,260(1)
	stw 30,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L488
.L431:
	lwz 0,324(1)
	mtlr 0
	lmw 20,264(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe17:
	.size	 ClientThink,.Lfe17-ClientThink
	.section	".rodata"
	.align 2
.LC171:
	.long 0x0
	.align 2
.LC172:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,level@ha
	lis 11,.LC171@ha
	la 11,.LC171@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	mr 31,3
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L493
	lis 9,deathmatch@ha
	lwz 30,84(31)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L495
	lwz 9,1812(30)
	lwz 0,3492(30)
	cmpw 0,9,0
	bc 12,2,.L495
	lfs 0,4(10)
	lis 9,.LC172@ha
	lfs 13,3828(30)
	la 9,.LC172@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L495
	bl spectator_respawn
	b .L493
.L495:
	lwz 0,3564(30)
	cmpwi 0,0,0
	bc 4,2,.L496
	lwz 0,3492(30)
	cmpwi 0,0,0
	bc 4,2,.L496
	mr 3,31
	bl Think_Weapon
	b .L497
.L496:
	li 0,0
	stw 0,3564(30)
.L497:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L498
	lis 9,level@ha
	lfs 13,3828(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L493
	lis 9,.LC171@ha
	lis 11,deathmatch@ha
	lwz 10,3560(30)
	la 9,.LC171@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L503
	bc 12,30,.L493
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L493
.L503:
	bc 4,30,.L504
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L505
.L504:
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L506
	mr 3,31
	bl ACESP_Respawn
	b .L509
.L506:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L508
	mr 3,31
	bl CopyToBodyQue
.L508:
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 8,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	stb 11,16(8)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,4(29)
	lwz 11,84(31)
	stfs 0,3828(11)
	b .L509
.L505:
	lis 9,gi+168@ha
	lis 3,.LC110@ha
	lwz 0,gi+168@l(9)
	la 3,.LC110@l(3)
	mtlr 0
	blrl
	b .L511
.L498:
	lis 9,.LC171@ha
	lis 11,deathmatch@ha
	la 9,.LC171@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L509
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L509
	addi 3,31,28
	bl PlayerTrail_Add
.L511:
.L509:
	li 0,0
	stw 0,3560(30)
.L493:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 ClientBeginServerFrame,.Lfe18-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC173:
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
	lis 11,.LC173@ha
	lis 9,deathmatch@ha
	la 11,.LC173@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L304
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L303
.L304:
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L305
	mr 3,31
	bl ACESP_Respawn
	b .L302
.L305:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L306
	mr 3,31
	bl CopyToBodyQue
.L306:
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 7,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	lis 8,level+4@ha
	stb 11,16(7)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,level+4@l(8)
	lwz 11,84(31)
	stfs 0,3828(11)
	b .L302
.L303:
	lis 9,gi+168@ha
	lis 3,.LC110@ha
	lwz 0,gi+168@l(9)
	la 3,.LC110@l(3)
	mtlr 0
	blrl
.L302:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 respawn,.Lfe19-respawn
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
	li 5,1628
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 27,0x286b
	li 26,1
	lis 3,.LC80@ha
	ori 27,27,51739
	la 3,.LC80@l(3)
	addi 25,29,740
	bl FindItem
	lis 28,itemlist@ha
	mr 11,3
	la 28,itemlist@l(28)
	lis 3,.LC95@ha
	subf 0,28,11
	la 3,.LC95@l(3)
	mullw 0,0,27
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(29)
	stwx 26,25,9
	stw 11,1792(29)
	stw 11,1788(29)
	bl FindItem
	subf 3,28,3
	li 0,100
	mullw 3,3,27
	li 9,50
	li 11,200
	rlwinm 3,3,0,0,29
	stwx 26,25,3
	stw 26,720(29)
	stw 0,1768(29)
	stw 11,1780(29)
	stw 9,1784(29)
	stw 0,724(29)
	stw 0,728(29)
	stw 11,1764(29)
	stw 9,1772(29)
	stw 9,1776(29)
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 InitClientPersistant,.Lfe20-InitClientPersistant
	.section	".rodata"
	.align 2
.LC174:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 4,0
	addi 28,31,1816
	lwz 29,3452(31)
	li 5,1680
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3452(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1628
	stw 0,3444(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC174@ha
	lis 11,ctf@ha
	la 9,.LC174@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L179
	lwz 0,3452(31)
	cmpwi 0,0,0
	bc 12,1,.L179
	mr 3,31
	bl CTFAssignTeam
.L179:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 InitClientResp,.Lfe21-InitClientResp
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
	lis 11,.LC109@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC109@l(11)
.L292:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L292
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 InitBodyQue,.Lfe22-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe23:
	.size	 player_pain,.Lfe23-player_pain
	.section	".rodata"
	.align 2
.LC175:
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
	lis 9,.LC175@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC175@l(9)
	addi 10,10,952
	lfs 13,0(9)
.L184:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L183
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
	andi. 0,0,4144
	stw 0,732(9)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L183
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3448(9)
	add 11,7,11
	stw 0,1800(11)
.L183:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3864
	addi 10,10,952
	cmpw 0,6,0
	bc 12,0,.L184
	blr
.Lfe24:
	.size	 SaveClientData,.Lfe24-SaveClientData
	.section	".rodata"
	.align 2
.LC176:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC176@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC176@l(9)
	lwz 8,coop@l(10)
	lfs 13,0(9)
	lwz 9,724(7)
	lwz 11,264(3)
	stw 9,480(3)
	lwz 0,728(7)
	stw 0,484(3)
	lwz 9,732(7)
	or 11,11,9
	stw 11,264(3)
	lfs 0,20(8)
	fcmpu 0,0,13
	bclr 12,2
	lwz 0,1800(7)
	stw 0,3448(7)
	blr
.Lfe25:
	.size	 FetchClientEntData,.Lfe25-FetchClientEntData
	.section	".rodata"
	.align 2
.LC177:
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
	lis 9,.LC177@ha
	mr 30,3
	la 9,.LC177@l(9)
	li 31,0
	lfs 31,0(9)
	lis 29,.LC0@ha
.L9:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L6
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L9
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
	bc 4,0,.L9
	lwz 3,300(30)
	cmpwi 0,3,0
	bc 12,2,.L14
	lwz 4,300(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L6
.L14:
	lwz 0,300(31)
	stw 0,300(30)
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 SP_FixCoopSpots,.Lfe26-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC178:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC179:
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
	lis 11,.LC179@ha
	lis 9,coop@ha
	la 11,.LC179@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L18
	lis 3,level+72@ha
	lis 4,.LC1@ha
	la 3,level+72@l(3)
	la 4,.LC1@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	lis 9,SP_CreateCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_CreateCoopSpots@l(9)
	lis 11,.LC178@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC178@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe27:
	.size	 SP_info_player_start,.Lfe27-SP_info_player_start
	.section	".rodata"
	.align 2
.LC180:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC180@ha
	lis 9,deathmatch@ha
	la 11,.LC180@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L22
	bl G_FreeEdict
	b .L21
.L22:
	bl SP_misc_teleporter_dest
.L21:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 SP_info_player_deathmatch,.Lfe28-SP_info_player_deathmatch
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe29:
	.size	 SP_info_player_intermission,.Lfe29-SP_info_player_intermission
	.align 2
	.globl IsFemale
	.type	 IsFemale,@function
IsFemale:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L30
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 3,0(3)
	xori 0,3,70
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,102
	subfic 9,3,0
	adde 3,9,3
	or 3,3,0
	b .L512
.L30:
	li 3,0
.L512:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 IsFemale,.Lfe30-IsFemale
	.align 2
	.globl IsNeutral
	.type	 IsNeutral,@function
IsNeutral:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L34
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L34
	cmpwi 0,11,109
	bc 12,2,.L34
	cmpwi 0,11,77
	li 3,1
	bc 4,2,.L513
.L34:
	li 3,0
.L513:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 IsNeutral,.Lfe31-IsNeutral
	.section	".rodata"
	.align 2
.LC181:
	.long 0x4b18967f
	.align 2
.LC182:
	.long 0x3f800000
	.align 3
.LC183:
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
	lis 11,.LC182@ha
	lwz 10,maxclients@l(9)
	la 11,.LC182@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC181@ha
	lfs 31,.LC181@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L192
	lis 9,.LC183@ha
	lis 27,g_edicts@ha
	la 9,.LC183@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,952
.L194:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L193
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L193
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
	bc 4,0,.L193
	fmr 31,1
.L193:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,952
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L194
.L192:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe32:
	.size	 PlayersRangeFromSpot,.Lfe32-PlayersRangeFromSpot
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
	bc 4,2,.L243
	bl SelectRandomDeathmatchSpawnPoint
	b .L515
.L243:
	bl SelectFarthestDeathmatchSpawnPoint
.L515:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 SelectDeathmatchSpawnPoint,.Lfe33-SelectDeathmatchSpawnPoint
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
	lis 9,0xa99b
	lwz 10,game+1028@l(11)
	ori 9,9,19403
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,3
	bc 12,2,.L516
.L249:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L250
	li 3,0
	b .L516
.L250:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L251
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L251:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L249
	addic. 31,31,-1
	bc 4,2,.L249
	mr 3,30
.L516:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 SelectCoopSpawnPoint,.Lfe34-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC184:
	.long 0x3f800000
	.align 2
.LC185:
	.long 0x0
	.align 2
.LC186:
	.long 0x42400000
	.section	".text"
	.align 2
	.globl body_die
	.type	 body_die,@function
body_die:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 28,6
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,0,.L295
	lis 29,gi@ha
	lis 3,.LC89@ha
	la 29,gi@l(29)
	la 3,.LC89@l(3)
	lwz 9,36(29)
	lis 27,.LC90@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC184@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC184@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC184@ha
	la 9,.LC184@l(9)
	lfs 2,0(9)
	lis 9,.LC185@ha
	la 9,.LC185@l(9)
	lfs 3,0(9)
	blrl
.L299:
	mr 3,31
	la 4,.LC90@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L299
	lis 9,.LC186@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC186@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L295:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 body_die,.Lfe35-body_die
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
	bc 4,1,.L410
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L409
.L410:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L409:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 PM_trace,.Lfe36-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L414
.L416:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L416
.L414:
	mr 3,11
	blr
.Lfe37:
	.size	 CheckBlock,.Lfe37-CheckBlock
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
.L518:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L518
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L517:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L517
	lis 3,.LC162@ha
	la 3,.LC162@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 PrintPmove,.Lfe38-PrintPmove
	.align 2
	.type	 SP_CreateCoopSpots,@function
SP_CreateCoopSpots:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 3,level+72@ha
	lis 4,.LC1@ha
	la 3,level+72@l(3)
	la 4,.LC1@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L17
	bl G_Spawn
	lis 26,0xc324
	lis 25,0x42a0
	lis 29,.LC2@ha
	lis 28,.LC3@ha
	stw 26,8(3)
	la 29,.LC2@l(29)
	la 28,.LC3@l(28)
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
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 SP_CreateCoopSpots,.Lfe39-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
