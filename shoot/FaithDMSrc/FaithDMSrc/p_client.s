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
	.string	"%s %s %s%s\n"
	.align 2
.LC76:
	.string	"%s died.\n"
	.align 2
.LC77:
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
	lis 8,.LC77@ha
	lwz 11,coop@l(9)
	la 8,.LC77@l(8)
	mr 31,3
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
	lis 11,.LC77@ha
	lis 9,deathmatch@ha
	la 11,.LC77@l(11)
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
	la 30,.LC22@l(11)
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
	cmpw 0,29,31
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
	lwz 3,84(31)
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
	lwz 3,84(31)
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
	lwz 3,84(31)
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
	lwz 3,84(31)
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
	lwz 3,84(31)
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
	lwz 3,84(31)
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
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC45@ha
	lwz 0,gi@l(9)
	la 4,.LC45@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC77@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC77@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L96
	lwz 11,84(31)
	lwz 9,3448(11)
	addi 9,9,-1
	stw 9,3448(11)
.L96:
	li 0,0
	stw 0,540(31)
	b .L35
.L95:
	cmpwi 0,29,0
	stw 29,540(31)
	bc 12,2,.L37
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L37
	addi 0,28,-1
	cmplwi 0,0,23
	bc 12,1,.L98
	lis 11,.L117@ha
	slwi 10,0,2
	la 11,.L117@l(11)
	lis 9,.L117@ha
	lwzx 0,10,11
	la 9,.L117@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L117:
	.long .L99-.L117
	.long .L100-.L117
	.long .L101-.L117
	.long .L102-.L117
	.long .L103-.L117
	.long .L104-.L117
	.long .L105-.L117
	.long .L106-.L117
	.long .L107-.L117
	.long .L108-.L117
	.long .L109-.L117
	.long .L110-.L117
	.long .L111-.L117
	.long .L112-.L117
	.long .L113-.L117
	.long .L114-.L117
	.long .L98-.L117
	.long .L98-.L117
	.long .L98-.L117
	.long .L98-.L117
	.long .L116-.L117
	.long .L98-.L117
	.long .L98-.L117
	.long .L115-.L117
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
	la 30,.LC49@l(11)
	b .L98
.L102:
	lis 9,.LC50@ha
	la 6,.LC50@l(9)
	b .L98
.L103:
	lis 9,.LC51@ha
	lis 11,.LC52@ha
	la 6,.LC51@l(9)
	la 30,.LC52@l(11)
	b .L98
.L104:
	lis 9,.LC53@ha
	lis 11,.LC54@ha
	la 6,.LC53@l(9)
	la 30,.LC54@l(11)
	b .L98
.L105:
	lis 9,.LC55@ha
	lis 11,.LC56@ha
	la 6,.LC55@l(9)
	la 30,.LC56@l(11)
	b .L98
.L106:
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 6,.LC57@l(9)
	la 30,.LC58@l(11)
	b .L98
.L107:
	lis 9,.LC59@ha
	lis 11,.LC58@ha
	la 6,.LC59@l(9)
	la 30,.LC58@l(11)
	b .L98
.L108:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 30,.LC61@l(11)
	b .L98
.L109:
	lis 9,.LC62@ha
	la 6,.LC62@l(9)
	b .L98
.L110:
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	la 6,.LC63@l(9)
	la 30,.LC64@l(11)
	b .L98
.L111:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 6,.LC65@l(9)
	la 30,.LC66@l(11)
	b .L98
.L112:
	lis 9,.LC67@ha
	lis 11,.LC64@ha
	la 6,.LC67@l(9)
	la 30,.LC64@l(11)
	b .L98
.L113:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 6,.LC68@l(9)
	la 30,.LC69@l(11)
	b .L98
.L114:
	lis 9,.LC70@ha
	lis 11,.LC69@ha
	la 6,.LC70@l(9)
	la 30,.LC69@l(11)
	b .L98
.L115:
	lis 9,.LC71@ha
	lis 11,.LC72@ha
	la 6,.LC71@l(9)
	la 30,.LC72@l(11)
	b .L98
.L116:
	lis 9,.LC73@ha
	lis 11,.LC74@ha
	la 6,.LC73@l(9)
	la 30,.LC74@l(11)
.L98:
	cmpwi 0,6,0
	bc 12,2,.L37
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC75@ha
	lwz 0,gi@l(9)
	mr 8,30
	la 4,.LC75@l(4)
	addi 5,5,700
	addi 7,7,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC77@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC77@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	cmpwi 0,27,0
	bc 12,2,.L121
	lwz 11,84(29)
	lwz 9,3448(11)
	addi 9,9,-1
	b .L124
.L121:
	lwz 11,84(29)
	lwz 9,3448(11)
	addi 9,9,1
.L124:
	stw 9,3448(11)
	mr 3,29
	crxor 6,6,6
	bl holylevel
	b .L35
.L37:
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC76@ha
	lwz 0,gi@l(9)
	la 4,.LC76@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC77@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC77@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	lwz 11,84(31)
	lwz 9,3448(11)
	addi 9,9,-1
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
.LC78:
	.string	"Blaster"
	.align 2
.LC79:
	.string	"item_quad"
	.align 3
.LC80:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC81:
	.long 0x0
	.align 3
.LC82:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC83:
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
	lis 10,.LC81@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC81@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L125
	lwz 9,84(30)
	lwz 11,3536(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L128
	lwz 3,40(31)
	lis 4,.LC78@ha
	la 4,.LC78@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L128:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L129
	li 29,0
	b .L130
.L129:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC82@ha
	lfs 12,3732(8)
	addi 9,9,10
	la 10,.LC82@l(10)
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
.L130:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC81@ha
	and. 10,0,29
	la 9,.LC81@l(9)
	lfs 31,0(9)
	bc 12,2,.L131
	lis 11,.LC83@ha
	la 11,.LC83@l(11)
	lfs 31,0(11)
.L131:
	cmpwi 0,31,0
	bc 12,2,.L133
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3664(9)
	fsubs 0,0,31
	stfs 0,3664(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3664(9)
	fadds 0,0,31
	stfs 0,3664(9)
	stw 0,284(3)
.L133:
	cmpwi 0,29,0
	bc 12,2,.L125
	lwz 9,84(30)
	lis 3,.LC79@ha
	la 3,.LC79@l(3)
	lfs 0,3664(9)
	fadds 0,0,31
	stfs 0,3664(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC82@ha
	lis 11,Touch_Item@ha
	la 9,.LC82@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3664(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC80@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC80@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3664(7)
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
	lfs 0,3732(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L125:
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
.LC84:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC85:
	.long 0x0
	.align 2
.LC86:
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
	bc 12,2,.L136
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L136
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L146
.L136:
	cmpwi 0,4,0
	bc 12,2,.L138
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L138
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L146:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L137
.L138:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3588(9)
	b .L135
.L137:
	lis 9,.LC85@ha
	lfs 2,8(1)
	la 9,.LC85@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L140
	lfs 1,12(1)
	bl atan2
	lis 9,.LC84@ha
	lwz 11,84(31)
	lfd 0,.LC84@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3588(11)
	b .L141
.L140:
	lwz 9,84(31)
	stfs 13,3588(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L142
	lwz 9,84(31)
	lis 0,0x42b4
	b .L147
.L142:
	bc 4,0,.L141
	lwz 9,84(31)
	lis 0,0xc2b4
.L147:
	stw 0,3588(9)
.L141:
	lwz 3,84(31)
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfs 0,0(9)
	lfs 13,3588(3)
	fcmpu 0,13,0
	bc 4,0,.L135
	lis 11,.LC86@ha
	la 11,.LC86@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3588(3)
.L135:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 LookAtKiller,.Lfe4-LookAtKiller
	.section	".rodata"
	.align 2
.LC87:
	.string	"misc/udeath.wav"
	.align 2
.LC88:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.42:
	.space	4
	.size	 i.42,4
	.section	".rodata"
	.align 2
.LC89:
	.string	"*death%i.wav"
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
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 9,.LC90@ha
	mr 31,3
	la 9,.LC90@l(9)
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
	stfs 31,16(31)
	stfs 31,24(31)
	stw 11,76(31)
	stw 11,3760(10)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 8,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L149
	lis 9,level+4@ha
	lis 11,.LC91@ha
	lfs 0,level+4@l(9)
	la 11,.LC91@l(11)
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3816(11)
	bl LookAtKiller
	lwz 9,84(31)
	li 0,2
	mr 4,30
	mr 5,29
	mr 3,31
	stw 0,0(9)
	bl ClientObituary
	mr 3,31
	bl TossClientWeapon
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L150
	mr 3,31
	bl Cmd_Help_f
.L150:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,30,0
	bc 4,0,.L149
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 5,10
	lwz 7,coop@l(11)
	addi 8,9,56
	li 6,0
	lis 9,.LC90@ha
	li 10,0
	la 9,.LC90@l(9)
	lfs 13,0(9)
.L154:
	lfs 0,20(7)
	fcmpu 0,0,13
	bc 12,2,.L155
	lwz 0,0(8)
	andi. 11,0,16
	bc 12,2,.L155
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2368
	stwx 0,9,10
.L155:
	lwz 9,84(31)
	addi 30,30,1
	addi 8,8,76
	addi 9,9,740
	stwx 6,9,10
	lwz 0,1556(5)
	addi 10,10,4
	cmpw 0,30,0
	bc 12,0,.L154
.L149:
	lwz 11,84(31)
	li 0,0
	stw 0,3732(11)
	lwz 9,84(31)
	stw 0,3736(9)
	lwz 11,84(31)
	stw 0,3740(11)
	lwz 9,84(31)
	stw 0,3744(9)
	lwz 11,480(31)
	lwz 0,264(31)
	cmpwi 0,11,-40
	rlwinm 0,0,0,20,18
	stw 0,264(31)
	bc 4,0,.L157
	lis 29,gi@ha
	lis 3,.LC87@ha
	la 29,gi@l(29)
	la 3,.LC87@l(3)
	lwz 9,36(29)
	lis 28,.LC88@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC92@ha
	lwz 0,16(29)
	lis 11,.LC92@ha
	la 9,.LC92@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC92@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC90@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC90@l(9)
	lfs 3,0(9)
	blrl
.L161:
	mr 3,31
	la 4,.LC88@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L161
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	li 0,0
	stw 0,512(31)
	b .L163
.L157:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L163
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
	stw 7,3720(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L165
	li 0,172
	li 9,177
	b .L174
.L165:
	cmpwi 0,10,1
	bc 12,2,.L169
	bc 12,1,.L173
	cmpwi 0,10,0
	bc 12,2,.L168
	b .L166
.L173:
	cmpwi 0,10,2
	bc 12,2,.L170
	b .L166
.L168:
	li 0,177
	li 9,183
	b .L174
.L169:
	li 0,183
	li 9,189
	b .L174
.L170:
	li 0,189
	li 9,197
.L174:
	stw 0,56(31)
	stw 9,3716(11)
.L166:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC89@ha
	srwi 0,0,30
	la 3,.LC89@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC92@ha
	lwz 0,16(29)
	lis 11,.LC92@ha
	la 9,.LC92@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC92@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC90@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC90@l(9)
	lfs 3,0(9)
	blrl
.L163:
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
	.string	"info_player_deathmatch"
	.align 2
.LC94:
	.long 0x47c34f80
	.align 2
.LC96:
	.long 0x4b18967f
	.align 2
.LC97:
	.long 0x3f800000
	.align 3
.LC98:
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
	lis 9,.LC94@ha
	li 28,0
	lfs 29,.LC94@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC95@ha
	b .L197
.L199:
	lis 10,.LC97@ha
	lis 9,maxclients@ha
	la 10,.LC97@l(10)
	lis 11,.LC96@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC96@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L207
	lis 11,.LC98@ha
	lis 26,g_edicts@ha
	la 11,.LC98@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,900
.L202:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L204
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L204
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
	bc 4,0,.L204
	fmr 31,1
.L204:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,900
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L202
.L207:
	fcmpu 0,31,28
	bc 4,0,.L209
	fmr 28,31
	mr 24,30
	b .L197
.L209:
	fcmpu 0,31,29
	bc 4,0,.L197
	fmr 29,31
	mr 23,30
.L197:
	lis 5,.LC95@ha
	mr 3,30
	la 5,.LC95@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L199
	cmpwi 0,28,0
	bc 4,2,.L213
	li 3,0
	b .L221
.L213:
	cmpwi 0,28,2
	bc 12,1,.L214
	li 23,0
	li 24,0
	b .L215
.L214:
	addi 28,28,-2
.L215:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L220:
	mr 3,30
	li 4,280
	la 5,.LC95@l(22)
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
	bc 4,2,.L220
.L221:
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
.LC99:
	.long 0x4b18967f
	.align 2
.LC100:
	.long 0x0
	.align 2
.LC101:
	.long 0x3f800000
	.align 3
.LC102:
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
	lis 9,.LC100@ha
	li 31,0
	la 9,.LC100@l(9)
	li 25,0
	lfs 29,0(9)
	b .L223
.L225:
	lis 9,maxclients@ha
	lis 11,.LC101@ha
	lwz 10,maxclients@l(9)
	la 11,.LC101@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC99@ha
	lfs 31,.LC99@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L233
	lis 9,.LC102@ha
	lis 27,g_edicts@ha
	la 9,.LC102@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,900
.L228:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L230
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L230
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
	bc 4,0,.L230
	fmr 31,1
.L230:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,900
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L228
.L233:
	fcmpu 0,31,29
	bc 4,1,.L223
	fmr 29,31
	mr 25,31
.L223:
	lis 30,.LC95@ha
	mr 3,31
	li 4,280
	la 5,.LC95@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L225
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L238
	la 5,.LC95@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L238:
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
.LC103:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC104:
	.long 0x0
	.align 2
.LC105:
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
	lis 11,.LC104@ha
	lis 9,deathmatch@ha
	la 11,.LC104@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 30,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L253
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L254
	bl SelectFarthestDeathmatchSpawnPoint
	mr 30,3
	b .L257
.L254:
	bl SelectRandomDeathmatchSpawnPoint
	mr 30,3
	b .L257
.L281:
	li 30,0
	b .L257
.L253:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L257
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xeeee
	lwz 10,game+1028@l(11)
	ori 9,9,61167
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,8
	bc 12,2,.L257
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 30,game+1032@ha
.L263:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L281
	lwz 4,300(29)
	la 9,.LC22@l(28)
	la 3,game+1032@l(30)
	srawi 11,4,31
	xor 0,11,4
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 4,4,0
	or 4,4,9
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L263
	addic. 31,31,-1
	bc 4,2,.L263
	mr 30,29
.L257:
	cmpwi 0,30,0
	bc 4,2,.L269
	lis 29,.LC0@ha
	lis 31,game@ha
.L276:
	mr 3,30
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 30,3
	bc 12,2,.L282
	la 3,game@l(31)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L280
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L271
	b .L276
.L280:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 12,2,.L276
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L276
.L271:
	cmpwi 0,30,0
	bc 4,2,.L269
.L282:
	lis 9,game@ha
	la 31,game@l(9)
	lbz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L278
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L278:
	cmpwi 0,30,0
	bc 4,2,.L269
	lis 9,gi+28@ha
	lis 3,.LC103@ha
	lwz 0,gi+28@l(9)
	la 3,.LC103@l(3)
	addi 4,31,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L269:
	lfs 0,4(30)
	lis 9,.LC105@ha
	la 9,.LC105@l(9)
	lfs 12,0(9)
	stfs 0,0(26)
	lfs 13,8(30)
	stfs 13,4(26)
	lfs 0,12(30)
	fadds 0,0,12
	stfs 0,8(26)
	lfs 13,16(30)
	stfs 13,0(25)
	lfs 0,20(30)
	stfs 0,4(25)
	lfs 13,24(30)
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
.LC106:
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
	mulli 27,27,900
	addi 27,27,900
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
	lis 9,0x8765
	lis 11,body_die@ha
	ori 9,9,17185
	la 11,body_die@l(11)
	subf 0,0,29
	li 10,1
	mullw 0,0,9
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
.LC107:
	.string	"menu_loadgame\n"
	.align 2
.LC108:
	.string	"spectator"
	.align 2
.LC109:
	.string	"none"
	.align 2
.LC110:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC111:
	.string	"spectator 0\n"
	.align 2
.LC112:
	.string	"Server spectator limit is full."
	.align 2
.LC113:
	.string	"password"
	.align 2
.LC114:
	.string	"Password incorrect.\n"
	.align 2
.LC115:
	.string	"spectator 1\n"
	.align 2
.LC116:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC117:
	.string	"%s joined the game\n"
	.align 2
.LC118:
	.long 0x3f800000
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl spectator_respawn
	.type	 spectator_respawn,@function
spectator_respawn:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L302
	lis 4,.LC108@ha
	addi 3,3,188
	la 4,.LC108@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L303
	lis 4,.LC109@ha
	la 4,.LC109@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L303
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L303
	lis 29,gi@ha
	lis 5,.LC110@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC110@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC111@ha
	la 3,.LC111@l(3)
	b .L316
.L303:
	lis 9,maxclients@ha
	lis 10,.LC118@ha
	lwz 11,maxclients@l(9)
	la 10,.LC118@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L305
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC119@ha
	la 9,.LC119@l(9)
	addi 10,11,900
	lfd 13,0(9)
.L307:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L306
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L306:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,900
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L307
.L305:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC119@ha
	la 10,.LC119@l(10)
	stw 11,8(1)
	lfd 12,0(10)
	lfd 0,8(1)
	lis 10,maxspectators@ha
	lwz 11,maxspectators@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L311
	lis 29,gi@ha
	lis 5,.LC112@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC112@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC111@ha
	la 3,.LC111@l(3)
	b .L316
.L302:
	lis 4,.LC113@ha
	addi 3,3,188
	la 4,.LC113@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lis 28,gi@ha
	lwz 9,password@l(29)
	mr 30,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L311
	lis 4,.LC109@ha
	la 4,.LC109@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L311
	lwz 9,password@l(29)
	mr 4,30
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L311
	la 29,gi@l(28)
	lis 5,.LC114@ha
	lwz 9,8(29)
	li 4,2
	la 5,.LC114@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
.L316:
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L301
.L311:
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
	bc 4,2,.L313
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x8765
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,17185
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
	lwz 11,84(31)
	li 0,32
	li 10,14
	stb 0,16(11)
	lwz 9,84(31)
	stb 10,17(9)
.L313:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3816(11)
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L314
	lis 9,gi@ha
	lis 4,.LC116@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC116@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L301
.L314:
	lis 9,gi@ha
	lis 4,.LC117@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC117@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L301:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 spectator_respawn,.Lfe10-spectator_respawn
	.section	".rodata"
	.align 2
.LC120:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC121:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC122:
	.string	"player"
	.align 2
.LC123:
	.string	"players/male/tris.md2"
	.align 2
.LC124:
	.string	"fov"
	.align 2
.LC125:
	.long 0x0
	.align 2
.LC126:
	.long 0x41400000
	.align 2
.LC127:
	.long 0x41000000
	.align 3
.LC128:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC129:
	.long 0x3f800000
	.align 2
.LC130:
	.long 0x43200000
	.align 2
.LC131:
	.long 0x47800000
	.align 2
.LC132:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4448(1)
	mflr 0
	stfd 31,4440(1)
	stmw 22,4400(1)
	stw 0,4452(1)
	lis 9,.LC120@ha
	lis 8,.LC121@ha
	lwz 0,.LC120@l(9)
	addi 10,1,8
	la 29,.LC121@l(8)
	la 9,.LC120@l(9)
	lwz 11,.LC121@l(8)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 22,5
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
	lis 9,.LC125@ha
	lis 11,g_edicts@ha
	lwz 30,84(31)
	la 9,.LC125@l(9)
	lis 0,0x8765
	lfs 13,0(9)
	ori 0,0,17185
	lis 9,deathmatch@ha
	lwz 10,deathmatch@l(9)
	lwz 9,g_edicts@l(11)
	lfs 0,20(10)
	subf 9,9,31
	mullw 9,9,0
	fcmpu 0,0,13
	srawi 9,9,2
	addi 24,9,-1
	bc 12,2,.L318
	addi 28,1,1704
	addi 27,30,1816
	mr 4,27
	li 5,1664
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 25,29
	mr 23,28
	addi 26,1,3368
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,1628
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,29
	mullw 9,9,0
	li 8,1
	addi 7,30,740
	li 11,100
	li 10,50
	srawi 9,9,2
	li 5,200
	slwi 0,9,2
	stw 9,736(30)
	li 6,0
	stwx 8,7,0
	mr 4,26
	mr 3,31
	stw 29,1788(30)
	stw 11,1768(30)
	stw 5,1780(30)
	stw 10,1784(30)
	stw 6,3520(30)
	stw 8,720(30)
	stw 11,724(30)
	stw 11,728(30)
	stw 5,1764(30)
	stw 10,1772(30)
	stw 10,1776(30)
	stw 8,3472(30)
	bl ClientUserinfoChanged
	b .L320
.L318:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L321
	addi 28,1,1704
	addi 27,30,1816
	mr 4,27
	li 5,1664
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 23,28
	mr 25,29
	addi 26,1,3880
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
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
	bc 4,1,.L320
	stw 9,1800(30)
	b .L320
.L321:
	addi 29,1,1704
	li 4,0
	mr 3,29
	li 5,1664
	crxor 6,6,6
	bl memset
	mr 23,29
	addi 27,30,1816
	addi 25,30,188
.L320:
	addi 29,1,72
	mr 4,25
	li 5,1628
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3840
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,25
	li 5,1628
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L324
	li 5,1628
	li 4,0
	mr 3,25
	crxor 6,6,6
	bl memset
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	li 8,1
	mullw 9,9,0
	addi 6,30,740
	li 11,100
	li 10,50
	li 5,200
	srawi 9,9,2
	li 7,0
	slwi 0,9,2
	stw 9,736(30)
	stwx 8,6,0
	stw 3,1788(30)
	stw 11,1768(30)
	stw 5,1780(30)
	stw 10,1784(30)
	stw 7,3520(30)
	stw 8,720(30)
	stw 11,724(30)
	stw 11,728(30)
	stw 5,1764(30)
	stw 10,1772(30)
	stw 10,1776(30)
	stw 8,3472(30)
.L324:
	lis 9,.LC125@ha
	mr 3,27
	la 9,.LC125@l(9)
	mr 4,23
	lfs 31,0(9)
	li 5,1664
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
	bc 12,2,.L327
	lwz 0,1800(7)
	stw 0,3448(7)
.L327:
	li 7,0
	lis 11,game+1028@ha
	mulli 8,24,3840
	lwz 6,264(31)
	stw 7,552(31)
	li 0,4
	lis 9,.LC122@ha
	lwz 3,game+1028@l(11)
	li 5,2
	la 9,.LC122@l(9)
	li 11,22
	stw 0,260(31)
	li 10,1
	stw 11,508(31)
	add 3,3,8
	li 0,200
	lis 11,.LC126@ha
	stw 10,88(31)
	lis 29,level+4@ha
	stw 9,280(31)
	la 11,.LC126@l(11)
	lis 10,0x201
	stw 0,400(31)
	lis 8,.LC123@ha
	lis 9,player_pain@ha
	stw 5,248(31)
	la 8,.LC123@l(8)
	la 9,player_pain@l(9)
	stw 5,512(31)
	ori 10,10,3
	rlwinm 6,6,0,21,19
	stw 7,492(31)
	li 4,0
	li 5,184
	stw 3,84(31)
	lfs 0,level+4@l(29)
	lfs 13,0(11)
	lfs 10,8(1)
	lis 11,player_die@ha
	lfs 12,24(1)
	la 11,player_die@l(11)
	fadds 0,0,13
	lfs 9,12(1)
	lfs 13,16(1)
	lwz 0,184(31)
	lfs 11,28(1)
	lfs 8,32(1)
	rlwinm 0,0,0,31,29
	stfs 0,404(31)
	stw 10,252(31)
	stw 8,268(31)
	stw 9,452(31)
	stw 11,456(31)
	stw 7,608(31)
	stfs 10,188(31)
	stfs 13,196(31)
	stfs 12,200(31)
	stw 6,264(31)
	stw 0,184(31)
	stfs 9,192(31)
	stfs 11,204(31)
	stw 7,612(31)
	stfs 8,208(31)
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC127@ha
	lfs 0,40(1)
	la 9,.LC127@l(9)
	mr 10,11
	lfs 10,0(9)
	mr 8,11
	lis 9,deathmatch@ha
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4392(1)
	lwz 11,4396(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4392(1)
	lwz 10,4396(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4392(1)
	lwz 8,4396(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L328
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4392(1)
	lwz 11,4396(1)
	andi. 0,11,32768
	bc 4,2,.L342
.L328:
	lis 4,.LC124@ha
	mr 3,25
	la 4,.LC124@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4396(1)
	lis 0,0x4330
	lis 11,.LC128@ha
	la 11,.LC128@l(11)
	stw 0,4392(1)
	lfd 13,0(11)
	lfd 0,4392(1)
	lis 11,.LC129@ha
	la 11,.LC129@l(11)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L330
.L342:
	lis 0,0x42b4
	stw 0,112(30)
	b .L329
.L330:
	lis 9,.LC130@ha
	la 9,.LC130@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L329
	stfs 13,112(30)
.L329:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 11,.LC132@ha
	lis 9,.LC131@ha
	stw 3,88(30)
	la 11,.LC132@l(11)
	la 9,.LC131@l(9)
	lfs 13,48(1)
	lfs 10,0(11)
	lis 0,0x8765
	li 10,255
	lis 11,g_edicts@ha
	lfs 9,0(9)
	ori 0,0,17185
	lwz 9,g_edicts@l(11)
	mr 5,22
	addi 6,30,3452
	lis 11,.LC129@ha
	lfs 11,40(1)
	addi 7,30,20
	la 11,.LC129@l(11)
	subf 9,9,31
	lfs 12,44(1)
	lfs 0,0(11)
	mullw 9,9,0
	li 8,0
	li 0,3
	li 11,0
	stw 10,44(31)
	mtctr 0
	srawi 9,9,2
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
.L341:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4392(1)
	lwz 9,4396(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L341
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
	stfs 13,3660(30)
	lfs 0,20(31)
	stfs 0,3664(30)
	lfs 13,24(31)
	stfs 13,3668(30)
	bc 12,2,.L338
	li 9,0
	li 10,1
	stw 10,3476(30)
	lis 8,gi+72@ha
	mr 3,31
	stw 9,3820(30)
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
	b .L317
.L338:
	stw 9,3476(30)
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1788(30)
	mr 3,31
	stw 0,3556(30)
	bl ChangeWeapon
.L317:
	lwz 0,4452(1)
	mtlr 0
	lmw 22,4400(1)
	lfd 31,4440(1)
	la 1,4448(1)
	blr
.Lfe11:
	.size	 PutClientInServer,.Lfe11-PutClientInServer
	.section	".rodata"
	.align 2
.LC133:
	.string	"%s entered the game\n"
	.align 2
.LC134:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	bl G_InitEdict
	lwz 29,84(31)
	li 4,0
	li 5,1664
	addi 27,29,1816
	lwz 25,3464(29)
	lwz 26,3468(29)
	mr 3,27
	crxor 6,6,6
	bl memset
	lis 28,level@ha
	addi 4,29,188
	lwz 0,level@l(28)
	li 5,1628
	mr 3,27
	la 28,level@l(28)
	stw 0,3444(29)
	crxor 6,6,6
	bl memcpy
	stw 26,3468(29)
	mr 3,31
	stw 25,3464(29)
	bl PutClientInServer
	lis 9,.LC134@ha
	lfs 13,200(28)
	la 9,.LC134@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L345
	mr 3,31
	bl MoveClientToIntermission
	b .L346
.L345:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x8765
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,17185
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
.L346:
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC133@ha
	lwz 0,gi@l(9)
	la 4,.LC133@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	crxor 6,6,6
	bl OpenTeamMenu
	mr 3,31
	bl ClientEndServerFrame
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 ClientBeginDeathmatch,.Lfe12-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC135:
	.long 0x0
	.align 2
.LC136:
	.long 0x47800000
	.align 2
.LC137:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 11,g_edicts@ha
	mr 31,3
	lwz 9,g_edicts@l(11)
	lis 0,0x8765
	lis 10,deathmatch@ha
	ori 0,0,17185
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC135@ha
	srawi 9,9,2
	la 10,.LC135@l(10)
	mulli 9,9,3840
	lfs 13,0(10)
	addi 9,9,-3840
	add 8,8,9
	stw 8,84(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L348
	bl ClientBeginDeathmatch
	b .L347
.L348:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L349
	lis 9,.LC136@ha
	lis 10,.LC137@ha
	li 11,3
	la 9,.LC136@l(9)
	la 10,.LC137@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L360:
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
	stfd 13,16(1)
	lwz 11,20(1)
	sthx 11,10,0
	bdnz .L360
	b .L355
.L349:
	mr 3,31
	bl G_InitEdict
	lwz 29,84(31)
	lis 9,.LC122@ha
	li 4,0
	la 9,.LC122@l(9)
	li 5,1664
	stw 9,280(31)
	addi 28,29,1816
	lwz 26,3464(29)
	mr 3,28
	lwz 27,3468(29)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1628
	stw 0,3444(29)
	crxor 6,6,6
	bl memcpy
	stw 27,3468(29)
	mr 3,31
	stw 26,3464(29)
	bl PutClientInServer
.L355:
	lis 10,.LC135@ha
	lis 9,level+200@ha
	la 10,.LC135@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L357
	mr 3,31
	bl MoveClientToIntermission
	b .L358
.L357:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L358
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x8765
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,17185
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
	li 4,2
	addi 3,31,4
	mtlr 0
	blrl
	lwz 5,84(31)
	lis 4,.LC133@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC133@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L358:
	mr 3,31
	bl ClientEndServerFrame
.L347:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 ClientBegin,.Lfe13-ClientBegin
	.section	".rodata"
	.align 2
.LC138:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC139:
	.string	"name"
	.align 2
.LC140:
	.string	"0"
	.align 2
.LC141:
	.string	"skin"
	.align 2
.LC142:
	.string	"%s\\%s"
	.align 2
.LC143:
	.string	"hand"
	.align 2
.LC144:
	.long 0x0
	.align 3
.LC145:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC146:
	.long 0x3f800000
	.align 2
.LC147:
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
	bc 4,2,.L362
	lis 11,.LC138@ha
	lwz 0,.LC138@l(11)
	la 9,.LC138@l(11)
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
.L362:
	lis 4,.LC139@ha
	mr 3,30
	la 4,.LC139@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC108@ha
	mr 3,30
	la 4,.LC108@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC144@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC144@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L363
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L363
	lis 4,.LC140@ha
	la 4,.LC140@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L363
	lwz 9,84(27)
	li 0,1
	b .L371
.L363:
	lwz 9,84(27)
	li 0,0
.L371:
	stw 0,1812(9)
	lis 4,.LC141@ha
	mr 3,30
	la 4,.LC141@l(4)
	bl Info_ValueForKey
	lis 9,g_edicts@ha
	lis 0,0x8765
	lwz 4,84(27)
	lwz 29,g_edicts@l(9)
	ori 0,0,17185
	mr 31,3
	lis 28,gi@ha
	lis 3,.LC142@ha
	subf 29,29,27
	la 28,gi@l(28)
	mullw 29,29,0
	addi 4,4,700
	mr 5,31
	la 3,.LC142@l(3)
	srawi 29,29,2
	addi 29,29,1311
	crxor 6,6,6
	bl va
	lwz 0,24(28)
	mr 4,3
	mr 3,29
	mtlr 0
	blrl
	lis 9,.LC144@ha
	lis 11,deathmatch@ha
	la 9,.LC144@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L365
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L365
	lwz 9,84(27)
	b .L372
.L365:
	lis 4,.LC124@ha
	mr 3,30
	la 4,.LC124@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC145@ha
	la 10,.LC145@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC146@ha
	la 10,.LC146@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L367
.L372:
	lis 0,0x42b4
	stw 0,112(9)
	b .L366
.L367:
	lis 11,.LC147@ha
	la 11,.LC147@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L366
	stfs 13,112(9)
.L366:
	lis 4,.LC143@ha
	mr 3,30
	la 4,.LC143@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L370
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L370:
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
.LC148:
	.string	"ip"
	.align 2
.LC149:
	.string	"rejmsg"
	.align 2
.LC150:
	.string	"Banned."
	.align 2
.LC151:
	.string	"Spectator password required or incorrect."
	.align 2
.LC152:
	.string	"Password required or incorrect."
	.align 2
.LC153:
	.string	"%s connected\n"
	.align 2
.LC154:
	.long 0x0
	.align 3
.LC155:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 26,4
	mr 30,3
	lis 4,.LC148@ha
	mr 3,26
	la 4,.LC148@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L374
	lis 4,.LC149@ha
	lis 5,.LC150@ha
	mr 3,26
	la 4,.LC149@l(4)
	la 5,.LC150@l(5)
	b .L393
.L374:
	lis 4,.LC108@ha
	mr 3,26
	la 4,.LC108@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC154@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC154@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L375
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L375
	lis 4,.LC140@ha
	la 4,.LC140@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L375
	lis 29,spectator_password@ha
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L376
	lis 4,.LC109@ha
	la 4,.LC109@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L376
	lwz 9,spectator_password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L376
	lis 4,.LC149@ha
	lis 5,.LC151@ha
	mr 3,26
	la 4,.LC149@l(4)
	la 5,.LC151@l(5)
	b .L393
.L376:
	lis 9,maxclients@ha
	lis 10,.LC154@ha
	lwz 11,maxclients@l(9)
	la 10,.LC154@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L378
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC155@ha
	la 9,.LC155@l(9)
	addi 10,11,900
	lfd 13,0(9)
.L380:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L379
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L379:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,900
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L380
.L378:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC155@ha
	la 10,.LC155@l(10)
	stw 11,8(1)
	lfd 12,0(10)
	lfd 0,8(1)
	lis 10,maxspectators@ha
	lwz 11,maxspectators@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L384
	lis 4,.LC149@ha
	lis 5,.LC112@ha
	mr 3,26
	la 4,.LC149@l(4)
	la 5,.LC112@l(5)
	b .L393
.L375:
	lis 4,.LC113@ha
	mr 3,26
	la 4,.LC113@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(29)
	mr 31,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L384
	lis 4,.LC109@ha
	la 4,.LC109@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L384
	lwz 9,password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L384
	lis 4,.LC149@ha
	lis 5,.LC152@ha
	mr 3,26
	la 4,.LC149@l(4)
	la 5,.LC152@l(5)
.L393:
	bl Info_SetValueForKey
	li 3,0
	b .L392
.L384:
	lis 11,g_edicts@ha
	lis 0,0x8765
	lwz 24,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,17185
	lis 11,game@ha
	cmpwi 0,24,0
	subf 9,9,30
	la 25,game@l(11)
	mullw 9,9,0
	lwz 11,1028(25)
	srawi 9,9,2
	mulli 9,9,3840
	addi 9,9,-3840
	add 31,11,9
	stw 31,84(30)
	bc 4,2,.L386
	addi 29,31,1816
	lwz 27,3464(31)
	li 4,0
	lwz 28,3468(31)
	li 5,1664
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1628
	stw 0,3444(31)
	crxor 6,6,6
	bl memcpy
	stw 28,3468(31)
	stw 27,3464(31)
	lwz 0,1560(25)
	cmpwi 0,0,0
	bc 12,2,.L389
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L386
.L389:
	lwz 29,84(30)
	li 4,0
	li 5,1628
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	li 8,1
	mullw 9,9,0
	addi 7,29,740
	li 10,50
	li 0,100
	li 6,200
	srawi 9,9,2
	slwi 11,9,2
	stw 9,736(29)
	stwx 8,7,11
	stw 8,720(29)
	stw 3,1788(29)
	stw 0,1768(29)
	stw 6,1780(29)
	stw 10,1784(29)
	stw 24,3520(29)
	stw 0,724(29)
	stw 0,728(29)
	stw 6,1764(29)
	stw 10,1772(29)
	stw 10,1776(29)
	stw 8,3472(29)
.L386:
	mr 4,26
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L391
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC153@ha
	lwz 0,gi+4@l(9)
	la 3,.LC153@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L391:
	lwz 9,84(30)
	li 0,0
	li 11,1
	stw 0,184(30)
	li 3,1
	stw 11,720(9)
.L392:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ClientConnect,.Lfe15-ClientConnect
	.section	".rodata"
	.align 2
.LC156:
	.string	"%s disconnected\n"
	.align 2
.LC157:
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
	bc 12,2,.L394
	lis 29,gi@ha
	lis 4,.LC156@ha
	lwz 9,gi@l(29)
	addi 5,5,700
	la 4,.LC156@l(4)
	li 3,2
	la 29,gi@l(29)
	mtlr 9
	lis 27,g_edicts@ha
	lis 28,0x8765
	ori 28,28,17185
	crxor 6,6,6
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 3,g_edicts@l(27)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,28
	mtlr 9
	srawi 3,3,2
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
	lis 9,.LC157@ha
	li 0,0
	la 9,.LC157@l(9)
	lwz 11,84(31)
	lis 4,.LC22@ha
	stw 9,280(31)
	subf 3,3,31
	la 4,.LC22@l(4)
	stw 0,40(31)
	mullw 3,3,28
	stw 0,248(31)
	stw 0,88(31)
	srawi 3,3,2
	stw 0,720(11)
	addi 3,3,1311
	lwz 0,24(29)
	mtlr 0
	blrl
.L394:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 ClientDisconnect,.Lfe16-ClientDisconnect
	.section	".rodata"
	.align 2
.LC158:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC161:
	.string	"*jump1.wav"
	.align 3
.LC159:
	.long 0x3f768000
	.long 0x0
	.align 3
.LC160:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC162:
	.long 0x0
	.align 3
.LC163:
	.long 0x40140000
	.long 0x0
	.align 3
.LC164:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC165:
	.long 0x41000000
	.align 3
.LC166:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC167:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-320(1)
	mflr 0
	stfd 31,312(1)
	stmw 21,268(1)
	stw 0,324(1)
	lis 9,level@ha
	lis 11,.LC162@ha
	la 9,level@l(9)
	la 11,.LC162@l(11)
	lfs 13,0(11)
	mr 28,3
	mr 26,4
	lfs 0,200(9)
	stw 28,292(9)
	lwz 31,84(28)
	fcmpu 0,0,13
	bc 12,2,.L419
	li 0,4
	lis 11,.LC163@ha
	stw 0,0(31)
	la 11,.LC163@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L418
	lbz 0,1(26)
	andi. 11,0,128
	bc 12,2,.L418
	li 0,1
	stw 0,208(9)
	b .L418
.L419:
	lwz 0,3820(31)
	lis 9,pm_passent@ha
	stw 28,pm_passent@l(9)
	cmpwi 0,0,0
	bc 12,2,.L421
	lha 0,2(26)
	lis 8,0x4330
	lis 9,.LC164@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC164@l(9)
	stw 0,260(1)
	lis 21,maxclients@ha
	stw 8,256(1)
	lfd 12,0(9)
	lfd 0,256(1)
	lis 9,.LC159@ha
	lfd 13,.LC159@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3452(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3456(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3460(31)
	b .L422
.L421:
	addi 3,1,8
	li 4,0
	mr 29,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L427
	lwz 0,40(28)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L427
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L427
	li 0,2
.L427:
	stw 0,0(31)
	lwz 9,84(28)
	lwz 0,3520(9)
	cmpwi 0,0,1
	bc 4,2,.L429
	lis 11,sv_gravity@ha
	lis 8,.LC160@ha
	lwz 10,sv_gravity@l(11)
	lfd 12,.LC160@l(8)
	lfs 0,20(10)
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,256(1)
	lwz 9,260(1)
	sth 9,18(31)
	b .L430
.L429:
	lis 10,sv_gravity@ha
	lwz 9,sv_gravity@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,256(1)
	lwz 11,260(1)
	sth 11,18(31)
.L430:
	lwz 0,0(31)
	addi 24,1,12
	addi 22,28,4
	lwz 9,4(31)
	addi 23,1,18
	addi 25,28,376
	lwz 11,8(31)
	mr 3,24
	mr 5,22
	lwz 10,12(31)
	mr 4,23
	mr 6,25
	stw 0,8(1)
	addi 30,31,3480
	addi 27,1,36
	stw 9,4(29)
	lis 21,maxclients@ha
	li 7,0
	stw 11,8(29)
	lis 9,.LC165@ha
	li 8,0
	la 9,.LC165@l(9)
	li 11,3
	stw 10,12(29)
	lfs 10,0(9)
	mtctr 11
	lwz 0,16(31)
	lwz 9,20(31)
	lwz 11,24(31)
	stw 0,16(29)
	stw 9,20(29)
	stw 11,24(29)
.L479:
	lfsx 13,7,5
	lfsx 0,7,6
	mr 9,11
	addi 7,7,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,256(1)
	lwz 11,260(1)
	stfd 11,256(1)
	lwz 9,260(1)
	sthx 11,8,3
	sthx 9,8,4
	addi 8,8,2
	bdnz .L479
	mr 3,30
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L436
	li 0,1
	stw 0,52(1)
.L436:
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
	lis 9,.LC164@ha
	lwz 11,8(1)
	mr 27,24
	la 9,.LC164@l(9)
	lwz 10,4(29)
	mr 3,25
	lfd 11,0(9)
	mr 4,23
	mr 5,22
	lis 9,.LC166@ha
	lwz 0,8(29)
	lis 6,0x4330
	la 9,.LC166@l(9)
	li 7,0
	lfd 12,0(9)
	li 8,0
	lwz 9,12(29)
	stw 11,0(31)
	li 11,3
	stw 10,4(31)
	stw 0,8(31)
	mtctr 11
	stw 9,12(31)
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
	stw 0,3480(31)
	stw 9,4(30)
	stw 11,8(30)
	stw 10,12(30)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	stw 0,24(30)
	stw 9,16(30)
	stw 11,20(30)
.L478:
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
	bdnz .L478
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 11,.LC164@ha
	lis 7,.LC159@ha
	lfs 8,204(1)
	la 11,.LC164@l(11)
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
	lfd 12,0(11)
	xoris 0,0,0x8000
	lfd 13,.LC159@l(7)
	stw 0,260(1)
	mr 10,11
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3452(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3456(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3460(31)
	lwz 0,552(28)
	cmpwi 0,0,0
	bc 12,2,.L442
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L442
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L442
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L442
	lis 29,gi@ha
	lis 3,.LC161@ha
	la 29,gi@l(29)
	la 3,.LC161@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC167@ha
	lwz 0,16(29)
	lis 11,.LC167@ha
	la 9,.LC167@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC167@l(11)
	mr 3,28
	mtlr 0
	lis 9,.LC162@ha
	li 4,2
	lfs 2,0(11)
	la 9,.LC162@l(9)
	lfs 3,0(9)
	blrl
	mr 4,22
	mr 3,28
	li 5,0
	bl PlayerNoise
.L442:
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
	bc 12,2,.L443
	lwz 0,92(10)
	stw 0,556(28)
.L443:
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L444
	lfs 0,3588(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L445
.L444:
	lfs 0,188(1)
	stfs 0,3660(31)
	lfs 13,192(1)
	stfs 13,3664(31)
	lfs 0,196(1)
	stfs 0,3668(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L445:
	lis 9,gi+72@ha
	mr 3,28
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L446
	mr 3,28
	bl G_TouchTriggers
.L446:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L422
	addi 30,1,60
.L450:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,30,0
	addi 27,29,1
	bc 4,0,.L452
	lwz 0,0(30)
	cmpw 0,0,3
	bc 12,2,.L452
	mr 9,30
.L453:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L452
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L453
.L452:
	cmpw 0,11,29
	bc 4,2,.L449
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L449
	mr 4,28
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L449:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L450
.L422:
	lwz 0,3540(31)
	lwz 11,3548(31)
	stw 0,3544(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3540(31)
	or 11,11,0
	stw 11,3548(31)
	lbz 0,15(26)
	stw 0,640(28)
	lwz 9,3548(31)
	andi. 0,9,1
	bc 12,2,.L460
	lwz 0,3476(31)
	cmpwi 0,0,0
	bc 12,2,.L461
	lwz 0,3820(31)
	li 9,0
	stw 9,3548(31)
	cmpwi 0,0,0
	bc 12,2,.L462
	lbz 0,16(31)
	stw 9,3820(31)
	andi. 0,0,191
	stb 0,16(31)
	b .L460
.L462:
	mr 3,28
	bl GetChaseTarget
	b .L460
.L461:
	lwz 0,3552(31)
	cmpwi 0,0,0
	bc 4,2,.L460
	li 0,1
	mr 3,28
	stw 0,3552(31)
	bl Think_Weapon
.L460:
	lwz 0,3476(31)
	cmpwi 0,0,0
	bc 12,2,.L466
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L467
	lbz 0,16(31)
	andi. 9,0,2
	bc 4,2,.L466
	lwz 9,3820(31)
	ori 0,0,2
	stb 0,16(31)
	cmpwi 0,9,0
	bc 12,2,.L469
	mr 3,28
	bl ChaseNext
	b .L466
.L469:
	mr 3,28
	bl GetChaseTarget
	b .L466
.L467:
	lbz 0,16(31)
	andi. 0,0,253
	stb 0,16(31)
.L466:
	lis 11,.LC167@ha
	lis 9,maxclients@ha
	la 11,.LC167@l(11)
	li 29,1
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L418
	lis 9,.LC164@ha
	lis 27,g_edicts@ha
	la 9,.LC164@l(9)
	lis 30,0x4330
	lfd 31,0(9)
	li 31,900
.L475:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L474
	lwz 9,84(3)
	lwz 0,3820(9)
	cmpw 0,0,28
	bc 4,2,.L474
	bl UpdateChaseCam
.L474:
	addi 29,29,1
	lwz 11,maxclients@l(21)
	xoris 0,29,0x8000
	addi 31,31,900
	stw 0,260(1)
	stw 30,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L475
.L418:
	lwz 0,324(1)
	mtlr 0
	lmw 21,268(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe17:
	.size	 ClientThink,.Lfe17-ClientThink
	.section	".rodata"
	.align 2
.LC168:
	.long 0x0
	.align 2
.LC169:
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
	lis 11,.LC168@ha
	la 11,.LC168@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	mr 31,3
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L480
	lis 9,deathmatch@ha
	lwz 30,84(31)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L482
	lwz 9,1812(30)
	lwz 0,3476(30)
	cmpw 0,9,0
	bc 12,2,.L482
	lfs 0,4(10)
	lis 9,.LC169@ha
	lfs 13,3816(30)
	la 9,.LC169@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L482
	bl spectator_respawn
	b .L480
.L482:
	lwz 0,3552(30)
	cmpwi 0,0,0
	bc 4,2,.L483
	lwz 0,3476(30)
	cmpwi 0,0,0
	bc 4,2,.L483
	mr 3,31
	bl Think_Weapon
	b .L484
.L483:
	li 0,0
	stw 0,3552(30)
.L484:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L485
	lis 9,level@ha
	lfs 13,3816(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L480
	lis 9,.LC168@ha
	lis 11,deathmatch@ha
	lwz 10,3548(30)
	la 9,.LC168@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L490
	bc 12,30,.L480
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L480
.L490:
	bc 4,30,.L491
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L492
.L491:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L493
	mr 3,31
	bl CopyToBodyQue
.L493:
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
	stfs 0,3816(11)
	b .L495
.L492:
	lis 9,gi+168@ha
	lis 3,.LC107@ha
	lwz 0,gi+168@l(9)
	la 3,.LC107@l(3)
	mtlr 0
	blrl
	b .L497
.L485:
	lis 9,.LC168@ha
	lis 11,deathmatch@ha
	la 9,.LC168@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L495
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L495
	addi 3,31,28
	bl PlayerTrail_Add
.L497:
.L495:
	li 0,0
	stw 0,3548(30)
.L480:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 ClientBeginServerFrame,.Lfe18-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC170:
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
	lis 11,.LC170@ha
	lis 9,deathmatch@ha
	la 11,.LC170@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L299
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L298
.L299:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L300
	mr 3,31
	bl CopyToBodyQue
.L300:
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
	stfs 0,3816(11)
	b .L297
.L298:
	lis 9,gi+168@ha
	lis 3,.LC107@ha
	lwz 0,gi+168@l(9)
	la 3,.LC107@l(3)
	mtlr 0
	blrl
.L297:
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
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 5,1628
	li 4,0
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	li 8,1
	mullw 9,9,0
	addi 6,29,740
	li 11,100
	li 10,50
	li 5,200
	srawi 9,9,2
	li 7,0
	slwi 0,9,2
	stw 9,736(29)
	stwx 8,6,0
	stw 8,720(29)
	stw 3,1788(29)
	stw 11,1768(29)
	stw 5,1780(29)
	stw 10,1784(29)
	stw 7,3520(29)
	stw 11,724(29)
	stw 11,728(29)
	stw 5,1764(29)
	stw 10,1772(29)
	stw 10,1776(29)
	stw 8,3472(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 InitClientPersistant,.Lfe20-InitClientPersistant
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 29,3
	li 4,0
	addi 28,29,1816
	lwz 26,3464(29)
	li 5,1664
	lwz 27,3468(29)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1628
	stw 0,3444(29)
	crxor 6,6,6
	bl memcpy
	stw 27,3468(29)
	stw 26,3464(29)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
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
	lis 11,.LC106@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC106@l(11)
.L287:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L287
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
.LC171:
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
	lis 9,.LC171@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC171@l(9)
	addi 10,10,900
	lfs 13,0(9)
.L181:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L180
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
	bc 12,2,.L180
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3448(9)
	add 11,7,11
	stw 0,1800(11)
.L180:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3840
	addi 10,10,900
	cmpw 0,6,0
	bc 12,0,.L181
	blr
.Lfe24:
	.size	 SaveClientData,.Lfe24-SaveClientData
	.section	".rodata"
	.align 2
.LC172:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC172@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC172@l(9)
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
.LC173:
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
	lis 9,.LC173@ha
	mr 30,3
	la 9,.LC173@l(9)
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
.LC174:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC175:
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
	lis 11,.LC175@ha
	lis 9,coop@ha
	la 11,.LC175@l(11)
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
	lis 11,.LC174@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC174@l(11)
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
.LC176:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC176@ha
	lis 9,deathmatch@ha
	la 11,.LC176@l(11)
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
	b .L498
.L30:
	li 3,0
.L498:
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
	bc 4,2,.L499
.L34:
	li 3,0
.L499:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 IsNeutral,.Lfe31-IsNeutral
	.section	".rodata"
	.align 2
.LC177:
	.long 0x4b18967f
	.align 2
.LC178:
	.long 0x3f800000
	.align 3
.LC179:
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
	lis 11,.LC178@ha
	lwz 10,maxclients@l(9)
	la 11,.LC178@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC177@ha
	lfs 31,.LC177@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L189
	lis 9,.LC179@ha
	lis 27,g_edicts@ha
	la 9,.LC179@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,900
.L191:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L190
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L190
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
	bc 4,0,.L190
	fmr 31,1
.L190:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,900
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L191
.L189:
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
	bc 4,2,.L240
	bl SelectRandomDeathmatchSpawnPoint
	b .L501
.L240:
	bl SelectFarthestDeathmatchSpawnPoint
.L501:
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
	lis 9,0xeeee
	lwz 10,game+1028@l(11)
	ori 9,9,61167
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,8
	bc 12,2,.L502
.L246:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L247
	li 3,0
	b .L502
.L247:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L248
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L248:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L246
	addic. 31,31,-1
	bc 4,2,.L246
	mr 3,30
.L502:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 SelectCoopSpawnPoint,.Lfe34-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC180:
	.long 0x3f800000
	.align 2
.LC181:
	.long 0x0
	.align 2
.LC182:
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
	bc 4,0,.L290
	lis 29,gi@ha
	lis 3,.LC87@ha
	la 29,gi@l(29)
	la 3,.LC87@l(3)
	lwz 9,36(29)
	lis 27,.LC88@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC180@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC180@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC180@ha
	la 9,.LC180@l(9)
	lfs 2,0(9)
	lis 9,.LC181@ha
	la 9,.LC181@l(9)
	lfs 3,0(9)
	blrl
.L294:
	mr 3,31
	la 4,.LC88@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L294
	lis 9,.LC182@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC182@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L290:
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
	bc 4,1,.L397
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L396
.L397:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L396:
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
	bc 4,0,.L401
.L403:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L403
.L401:
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
.L504:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L504
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L503:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L503
	lis 3,.LC158@ha
	la 3,.LC158@l(3)
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
