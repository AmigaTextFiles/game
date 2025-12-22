	.file	"p_client.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl num_clients
	.section	".sdata","aw"
	.align 2
	.type	 num_clients,@object
	.size	 num_clients,4
num_clients:
	.long 0
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
	.string	"shouldn't play with matches"
	.align 2
.LC43:
	.string	"homed the wrong target"
	.align 2
.LC44:
	.string	"blinded itself to death"
	.align 2
.LC45:
	.string	"blinded herself to death"
	.align 2
.LC46:
	.string	"blinded himself to death"
	.align 2
.LC47:
	.string	"froze itself to death"
	.align 2
.LC48:
	.string	"froze herself to death"
	.align 2
.LC49:
	.string	"froze himself to death"
	.align 2
.LC50:
	.string	"got drunk on its own drunk rocket"
	.align 2
.LC51:
	.string	"got drunk on her own drunk rocket"
	.align 2
.LC52:
	.string	"got drunk on his own drunk rocket"
	.align 2
.LC53:
	.string	"made it stop"
	.align 2
.LC54:
	.string	"killed itself"
	.align 2
.LC55:
	.string	"killed herself"
	.align 2
.LC56:
	.string	"killed himself"
	.align 2
.LC57:
	.string	"%s %s.\n"
	.align 2
.LC58:
	.string	"was blasted by"
	.align 2
.LC59:
	.string	"was gunned down by"
	.align 2
.LC60:
	.string	"was blown away by"
	.align 2
.LC61:
	.string	"'s super shotgun"
	.align 2
.LC62:
	.string	"was machinegunned by"
	.align 2
.LC63:
	.string	"was cut in half by"
	.align 2
.LC64:
	.string	"'s chaingun"
	.align 2
.LC65:
	.string	"was popped by"
	.align 2
.LC66:
	.string	"'s grenade"
	.align 2
.LC67:
	.string	"was shredded by"
	.align 2
.LC68:
	.string	"'s shrapnel"
	.align 2
.LC69:
	.string	"ate"
	.align 2
.LC70:
	.string	"'s rocket"
	.align 2
.LC71:
	.string	"almost dodged"
	.align 2
.LC72:
	.string	"was melted by"
	.align 2
.LC73:
	.string	"'s hyperblaster"
	.align 2
.LC74:
	.string	"was railed by"
	.align 2
.LC75:
	.string	"saw the pretty lights from"
	.align 2
.LC76:
	.string	"'s BFG"
	.align 2
.LC77:
	.string	"was disintegrated by"
	.align 2
.LC78:
	.string	"'s BFG blast"
	.align 2
.LC79:
	.string	"couldn't hide from"
	.align 2
.LC80:
	.string	"caught"
	.align 2
.LC81:
	.string	"'s handgrenade"
	.align 2
.LC82:
	.string	"didn't see"
	.align 2
.LC83:
	.string	"feels"
	.align 2
.LC84:
	.string	"'s pain"
	.align 2
.LC85:
	.string	"tried to invade"
	.align 2
.LC86:
	.string	"'s personal space"
	.align 2
.LC87:
	.string	"was caught by"
	.align 2
.LC88:
	.string	"'s grapple"
	.align 2
.LC89:
	.string	"was torched by"
	.align 2
.LC90:
	.string	"was gibbed to death by"
	.align 2
.LC91:
	.string	"got homed in on by"
	.align 2
.LC92:
	.string	"was overwhelmed by"
	.align 2
.LC93:
	.string	"'s homing hyperblaster"
	.align 2
.LC94:
	.string	"tried to hide from"
	.align 2
.LC95:
	.string	"'s homing rocket"
	.align 2
.LC96:
	.string	"couldn't avoid"
	.align 2
.LC97:
	.string	"was blinded to death by"
	.align 2
.LC98:
	.string	"was frozen to death by"
	.align 2
.LC99:
	.string	"got too drunk on"
	.align 2
.LC100:
	.string	"'s drunk rockets"
	.align 2
.LC101:
	.string	"couldn't outrun"
	.align 2
.LC102:
	.string	"got reverse telefragged by"
	.align 2
.LC103:
	.string	"%s %s %s%s\n"
	.align 2
.LC104:
	.string	"%s died.\n"
	.align 2
.LC105:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,coop@ha
	lis 8,.LC105@ha
	lwz 11,coop@l(9)
	la 8,.LC105@l(8)
	mr 31,3
	lfs 13,0(8)
	mr 26,4
	mr 29,5
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 4,2,.L181
.L36:
	lis 11,.LC105@ha
	lis 9,deathmatch@ha
	la 11,.LC105@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L37
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L37
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L37
	mr 3,31
	mr 4,29
	bl SameTeam
	cmpwi 0,3,0
	bc 12,2,.L37
.L181:
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L37:
	lis 9,deathmatch@ha
	lis 8,.LC105@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC105@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L40
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L39
.L40:
	lis 9,meansOfDeath@ha
	lis 11,.LC22@ha
	lwz 0,meansOfDeath@l(9)
	la 30,.LC22@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	rlwinm 27,0,0,4,4
	addi 10,28,-17
	cmplwi 0,10,16
	bc 12,1,.L41
	lis 11,.L56@ha
	slwi 10,10,2
	la 11,.L56@l(11)
	lis 9,.L56@ha
	lwzx 0,10,11
	la 9,.L56@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L56:
	.long .L45-.L56
	.long .L46-.L56
	.long .L47-.L56
	.long .L44-.L56
	.long .L41-.L56
	.long .L43-.L56
	.long .L42-.L56
	.long .L41-.L56
	.long .L49-.L56
	.long .L49-.L56
	.long .L55-.L56
	.long .L50-.L56
	.long .L55-.L56
	.long .L51-.L56
	.long .L55-.L56
	.long .L41-.L56
	.long .L52-.L56
.L42:
	lis 9,.LC23@ha
	la 6,.LC23@l(9)
	b .L41
.L43:
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
	b .L41
.L44:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L41
.L45:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L41
.L46:
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L41
.L47:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L41
.L49:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L41
.L50:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L41
.L51:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L41
.L52:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L41
.L55:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
.L41:
	cmpw 0,29,31
	bc 4,2,.L58
	addi 10,28,-7
	cmplwi 0,10,37
	bc 12,1,.L124
	lis 11,.L134@ha
	slwi 10,10,2
	la 11,.L134@l(11)
	lis 9,.L134@ha
	lwzx 0,10,11
	la 9,.L134@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L134:
	.long .L62-.L134
	.long .L124-.L134
	.long .L73-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L84-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L62-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L123-.L134
	.long .L60-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L124-.L134
	.long .L85-.L134
	.long .L90-.L134
	.long .L124-.L134
	.long .L112-.L134
	.long .L124-.L134
	.long .L89-.L134
	.long .L89-.L134
	.long .L88-.L134
	.long .L89-.L134
	.long .L101-.L134
.L60:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L58
.L62:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L64
	li 10,0
	b .L65
.L64:
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
	bc 12,2,.L65
	cmpwi 0,11,109
	bc 12,2,.L65
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L65:
	cmpwi 0,10,0
	bc 12,2,.L63
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L58
.L63:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L69
	li 0,0
	b .L70
.L69:
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
.L70:
	cmpwi 0,0,0
	bc 12,2,.L68
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L58
.L68:
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L58
.L73:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L75
	li 10,0
	b .L76
.L75:
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
	bc 12,2,.L76
	cmpwi 0,11,109
	bc 12,2,.L76
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L76:
	cmpwi 0,10,0
	bc 12,2,.L74
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L58
.L74:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L80
	li 0,0
	b .L81
.L80:
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
.L81:
	cmpwi 0,0,0
	bc 12,2,.L79
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L58
.L79:
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L58
.L84:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
	b .L58
.L85:
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
	b .L58
.L88:
.L89:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L58
.L90:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L92
	li 10,0
	b .L93
.L92:
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
	bc 12,2,.L93
	cmpwi 0,11,109
	bc 12,2,.L93
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L93:
	cmpwi 0,10,0
	bc 12,2,.L91
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L58
.L91:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L97
	li 0,0
	b .L98
.L97:
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
.L98:
	cmpwi 0,0,0
	bc 12,2,.L96
	lis 9,.LC45@ha
	la 6,.LC45@l(9)
	b .L58
.L96:
	lis 9,.LC46@ha
	la 6,.LC46@l(9)
	b .L58
.L101:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L103
	li 10,0
	b .L104
.L103:
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
	bc 12,2,.L104
	cmpwi 0,11,109
	bc 12,2,.L104
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L104:
	cmpwi 0,10,0
	bc 12,2,.L102
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L58
.L102:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L108
	li 0,0
	b .L109
.L108:
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
.L109:
	cmpwi 0,0,0
	bc 12,2,.L107
	lis 9,.LC48@ha
	la 6,.LC48@l(9)
	b .L58
.L107:
	lis 9,.LC49@ha
	la 6,.LC49@l(9)
	b .L58
.L112:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L114
	li 10,0
	b .L115
.L114:
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
	bc 12,2,.L115
	cmpwi 0,11,109
	bc 12,2,.L115
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L115:
	cmpwi 0,10,0
	bc 12,2,.L113
	lis 9,.LC50@ha
	la 6,.LC50@l(9)
	b .L58
.L113:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L119
	li 0,0
	b .L120
.L119:
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
.L120:
	cmpwi 0,0,0
	bc 12,2,.L118
	lis 9,.LC51@ha
	la 6,.LC51@l(9)
	b .L58
.L118:
	lis 9,.LC52@ha
	la 6,.LC52@l(9)
	b .L58
.L123:
	lis 9,.LC53@ha
	la 6,.LC53@l(9)
	b .L58
.L124:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L125
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
	and. 8,9,0
	bc 12,2,.L125
	cmpwi 0,11,109
.L125:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L130
	li 0,0
	b .L131
.L130:
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
.L131:
	cmpwi 0,0,0
	bc 12,2,.L129
	lis 9,.LC55@ha
	la 6,.LC55@l(9)
	b .L58
.L129:
	lis 9,.LC56@ha
	la 6,.LC56@l(9)
.L58:
	cmpwi 0,6,0
	bc 12,2,.L135
	lwz 5,84(31)
	lis 4,.LC57@ha
	li 3,1
	la 4,.LC57@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC105@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC105@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L136
	lwz 9,84(31)
	lwz 11,3464(9)
	addi 11,11,-1
	stw 11,3464(9)
	lwz 10,84(31)
	lwz 11,3912(10)
	cmpwi 0,11,0
	bc 12,2,.L136
	lwz 9,144(11)
	addi 9,9,-1
	stw 9,144(11)
.L136:
	li 0,0
	stw 0,540(31)
	b .L35
.L135:
	cmpwi 0,29,0
	stw 29,540(31)
	bc 12,2,.L39
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L39
	addi 0,28,-1
	cmplwi 0,0,65
	bc 12,1,.L139
	lis 11,.L170@ha
	slwi 10,0,2
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
	.long .L140-.L170
	.long .L141-.L170
	.long .L142-.L170
	.long .L143-.L170
	.long .L144-.L170
	.long .L145-.L170
	.long .L146-.L170
	.long .L147-.L170
	.long .L148-.L170
	.long .L149-.L170
	.long .L150-.L170
	.long .L151-.L170
	.long .L152-.L170
	.long .L153-.L170
	.long .L154-.L170
	.long .L155-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L157-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L156-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L160-.L170
	.long .L159-.L170
	.long .L165-.L170
	.long .L167-.L170
	.long .L168-.L170
	.long .L169-.L170
	.long .L161-.L170
	.long .L162-.L170
	.long .L163-.L170
	.long .L164-.L170
	.long .L166-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L139-.L170
	.long .L158-.L170
.L140:
	lis 9,.LC58@ha
	la 6,.LC58@l(9)
	b .L139
.L141:
	lis 9,.LC59@ha
	la 6,.LC59@l(9)
	b .L139
.L142:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 30,.LC61@l(11)
	b .L139
.L143:
	lis 9,.LC62@ha
	la 6,.LC62@l(9)
	b .L139
.L144:
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	la 6,.LC63@l(9)
	la 30,.LC64@l(11)
	b .L139
.L145:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 6,.LC65@l(9)
	la 30,.LC66@l(11)
	b .L139
.L146:
	lis 9,.LC67@ha
	lis 11,.LC68@ha
	la 6,.LC67@l(9)
	la 30,.LC68@l(11)
	b .L139
.L147:
	lis 9,.LC69@ha
	lis 11,.LC70@ha
	la 6,.LC69@l(9)
	la 30,.LC70@l(11)
	b .L139
.L148:
	lis 9,.LC71@ha
	lis 11,.LC70@ha
	la 6,.LC71@l(9)
	la 30,.LC70@l(11)
	b .L139
.L149:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 6,.LC72@l(9)
	la 30,.LC73@l(11)
	b .L139
.L150:
	lis 9,.LC74@ha
	la 6,.LC74@l(9)
	b .L139
.L151:
	lis 9,.LC75@ha
	lis 11,.LC76@ha
	la 6,.LC75@l(9)
	la 30,.LC76@l(11)
	b .L139
.L152:
	lis 9,.LC77@ha
	lis 11,.LC78@ha
	la 6,.LC77@l(9)
	la 30,.LC78@l(11)
	b .L139
.L153:
	lis 9,.LC79@ha
	lis 11,.LC76@ha
	la 6,.LC79@l(9)
	la 30,.LC76@l(11)
	b .L139
.L154:
	lis 9,.LC80@ha
	lis 11,.LC81@ha
	la 6,.LC80@l(9)
	la 30,.LC81@l(11)
	b .L139
.L155:
	lis 9,.LC82@ha
	lis 11,.LC81@ha
	la 6,.LC82@l(9)
	la 30,.LC81@l(11)
	b .L139
.L156:
	lis 9,.LC83@ha
	lis 11,.LC84@ha
	la 6,.LC83@l(9)
	la 30,.LC84@l(11)
	b .L139
.L157:
	lis 9,.LC85@ha
	lis 11,.LC86@ha
	la 6,.LC85@l(9)
	la 30,.LC86@l(11)
	b .L139
.L158:
	lis 9,.LC87@ha
	lis 11,.LC88@ha
	la 6,.LC87@l(9)
	la 30,.LC88@l(11)
	b .L139
.L159:
	lis 9,.LC89@ha
	la 6,.LC89@l(9)
	b .L139
.L160:
	lis 9,.LC90@ha
	la 6,.LC90@l(9)
	b .L139
.L161:
	lis 9,.LC91@ha
	la 6,.LC91@l(9)
	b .L139
.L162:
	lis 9,.LC92@ha
	lis 11,.LC93@ha
	la 6,.LC92@l(9)
	la 30,.LC93@l(11)
	b .L139
.L163:
	lis 9,.LC94@ha
	lis 11,.LC95@ha
	la 6,.LC94@l(9)
	la 30,.LC95@l(11)
	b .L139
.L164:
	lis 9,.LC96@ha
	lis 11,.LC95@ha
	la 6,.LC96@l(9)
	la 30,.LC95@l(11)
	b .L139
.L165:
	lis 9,.LC97@ha
	la 6,.LC97@l(9)
	b .L139
.L166:
	lis 9,.LC98@ha
	la 6,.LC98@l(9)
	b .L139
.L167:
	lis 9,.LC99@ha
	lis 11,.LC100@ha
	la 6,.LC99@l(9)
	la 30,.LC100@l(11)
	b .L139
.L168:
	lis 9,.LC101@ha
	lis 11,.LC100@ha
	la 6,.LC101@l(9)
	la 30,.LC100@l(11)
	b .L139
.L169:
	lis 9,.LC102@ha
	la 6,.LC102@l(9)
.L139:
	cmpwi 0,6,0
	bc 12,2,.L39
	lwz 5,84(31)
	lis 4,.LC103@ha
	mr 8,30
	la 4,.LC103@l(4)
	addi 7,7,700
	addi 5,5,700
	li 3,1
	crxor 6,6,6
	bl my_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC105@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC105@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	cmpwi 0,27,0
	bc 12,2,.L174
	lwz 9,84(29)
	lwz 11,3464(9)
	addi 11,11,-1
	stw 11,3464(9)
	lwz 10,84(29)
	lwz 4,3912(10)
	cmpwi 0,4,0
	bc 12,2,.L35
	lwz 9,144(4)
	addi 9,9,-1
	stw 9,144(4)
	b .L35
.L174:
	lwz 9,84(29)
	lwz 11,3464(9)
	addi 11,11,1
	stw 11,3464(9)
	lwz 10,84(29)
	lwz 11,3912(10)
	cmpwi 0,11,0
	bc 12,2,.L177
	lwz 9,144(11)
	addi 9,9,1
	stw 9,144(11)
.L177:
	lwz 9,84(31)
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L35
	mr 3,31
	mr 4,26
	mr 5,29
	bl K2_BonusFrags
	b .L35
.L39:
	lwz 5,84(31)
	lis 4,.LC104@ha
	li 3,1
	la 4,.LC104@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC105@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC105@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	lwz 9,84(31)
	lwz 11,3464(9)
	addi 11,11,-1
	stw 11,3464(9)
	lwz 10,84(31)
	lwz 3,3912(10)
	cmpwi 0,3,0
	bc 12,2,.L35
	lwz 9,144(3)
	addi 9,9,-1
	stw 9,144(3)
.L35:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC106:
	.string	"Blaster"
	.align 2
.LC107:
	.string	"item_quad"
	.align 3
.LC108:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC109:
	.long 0x0
	.align 3
.LC110:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC111:
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
	lis 10,.LC109@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC109@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L182
	lwz 9,84(30)
	lwz 11,3576(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L185
	lwz 3,40(31)
	lis 4,.LC106@ha
	la 4,.LC106@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L185:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L186
	li 29,0
	b .L187
.L186:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC110@ha
	lfs 12,3772(8)
	addi 9,9,10
	la 10,.LC110@l(10)
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
.L187:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC109@ha
	and. 10,0,29
	la 9,.LC109@l(9)
	lfs 31,0(9)
	bc 12,2,.L188
	lis 11,.LC111@ha
	la 11,.LC111@l(11)
	lfs 31,0(11)
.L188:
	cmpwi 0,31,0
	bc 12,2,.L190
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3704(9)
	fsubs 0,0,31
	stfs 0,3704(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3704(9)
	fadds 0,0,31
	stfs 0,3704(9)
	stw 0,284(3)
.L190:
	cmpwi 0,29,0
	bc 12,2,.L182
	lwz 9,84(30)
	lis 3,.LC107@ha
	la 3,.LC107@l(3)
	lfs 0,3704(9)
	fadds 0,0,31
	stfs 0,3704(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC110@ha
	lis 11,Touch_Item@ha
	la 9,.LC110@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3704(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC108@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC108@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3704(7)
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
	lfs 0,3772(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L182:
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
.LC112:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC113:
	.long 0x0
	.align 2
.LC114:
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
	bc 12,2,.L193
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L193
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L203
.L193:
	cmpwi 0,4,0
	bc 12,2,.L195
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L195
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L203:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L194
.L195:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3628(9)
	b .L192
.L194:
	lis 9,.LC113@ha
	lfs 2,8(1)
	la 9,.LC113@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L197
	lfs 1,12(1)
	bl atan2
	lis 9,.LC112@ha
	lwz 11,84(31)
	lfd 0,.LC112@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3628(11)
	b .L198
.L197:
	lwz 9,84(31)
	stfs 13,3628(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L199
	lwz 9,84(31)
	lis 0,0x42b4
	b .L204
.L199:
	bc 4,0,.L198
	lwz 9,84(31)
	lis 0,0xc2b4
.L204:
	stw 0,3628(9)
.L198:
	lwz 3,84(31)
	lis 9,.LC113@ha
	la 9,.LC113@l(9)
	lfs 0,0(9)
	lfs 13,3628(3)
	fcmpu 0,13,0
	bc 4,0,.L192
	lis 11,.LC114@ha
	la 11,.LC114@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3628(3)
.L192:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 LookAtKiller,.Lfe4-LookAtKiller
	.section	".rodata"
	.align 2
.LC115:
	.string	"misc/udeath.wav"
	.align 2
.LC116:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.42:
	.space	4
	.size	 i.42,4
	.section	".rodata"
	.align 2
.LC117:
	.string	"*death%i.wav"
	.align 2
.LC118:
	.long 0x0
	.align 3
.LC119:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC120:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-352(1)
	mflr 0
	stfd 31,344(1)
	stmw 26,320(1)
	stw 0,356(1)
	lis 9,.LC118@ha
	mr 31,3
	la 9,.LC118@l(9)
	mr 28,4
	lfs 31,0(9)
	mr 30,5
	mr 26,6
	lwz 9,84(31)
	stfs 31,396(31)
	stfs 31,392(31)
	stfs 31,388(31)
	lwz 4,3988(9)
	cmpwi 0,4,0
	bc 12,2,.L206
	li 5,1
	bl K2_SpawnKey
.L206:
	lwz 9,84(31)
	lwz 3,3996(9)
	cmpwi 0,3,0
	bc 12,2,.L207
	bl Release_Grapple
.L207:
	lwz 9,84(31)
	li 0,0
	li 11,1
	li 10,7
	lis 7,0xc100
	stfs 31,96(9)
	stfs 31,104(9)
	stfs 31,100(9)
	lwz 8,84(31)
	stw 0,44(31)
	stw 0,48(31)
	stw 0,76(31)
	stw 11,512(31)
	stw 10,260(31)
	stfs 31,16(31)
	stfs 31,24(31)
	stw 0,3800(8)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 7,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L208
	lis 9,level@ha
	lis 11,.LC119@ha
	la 27,level@l(9)
	la 11,.LC119@l(11)
	lfs 0,4(27)
	mr 3,31
	mr 4,28
	lfd 13,0(11)
	mr 5,30
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3856(11)
	bl LookAtKiller
	lwz 9,84(31)
	li 0,2
	mr 3,31
	mr 4,28
	mr 5,30
	stw 0,0(9)
	bl ClientObituary
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 4,2,.L211
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L210
	lis 9,botfraglogging@ha
	lwz 11,botfraglogging@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L211
.L210:
	addi 29,1,8
	mr 4,27
	li 5,304
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lis 3,gi@ha
	mr 4,29
	la 3,gi@l(3)
	mr 5,31
	mr 6,28
	mr 7,30
	bl sl_WriteStdLogDeath
	lis 9,qwfraglog@ha
	lwz 11,qwfraglog@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L211
	mr 3,31
	mr 4,28
	mr 5,30
	bl WriteQWLogDeath
.L211:
	mr 5,30
	mr 4,28
	mr 3,31
	li 30,0
	bl CTFFragBonuses
	mr 3,31
	bl TossClientWeapon
	mr 3,31
	bl CTFPlayerResetGrapple
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
	lis 9,game@ha
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,30,0
	bc 4,0,.L214
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 5,10
	lwz 7,coop@l(11)
	addi 8,9,56
	li 6,0
	lis 9,.LC118@ha
	li 10,0
	la 9,.LC118@l(9)
	lfs 13,0(9)
.L216:
	lfs 0,20(7)
	fcmpu 0,0,13
	bc 12,2,.L217
	lwz 0,0(8)
	andi. 11,0,16
	bc 12,2,.L217
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2384
	stwx 0,9,10
.L217:
	lwz 9,84(31)
	addi 30,30,1
	addi 8,8,76
	addi 9,9,740
	stwx 6,9,10
	lwz 0,1556(5)
	addi 10,10,4
	cmpw 0,30,0
	bc 12,0,.L216
.L214:
	lis 9,.LC118@ha
	lis 11,deathmatch@ha
	la 9,.LC118@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L208
	mr 3,31
	bl Cmd_Help_f
.L208:
	lwz 11,84(31)
	li 0,0
	stw 0,3772(11)
	lwz 9,84(31)
	stw 0,3776(9)
	lwz 11,84(31)
	stw 0,3780(11)
	lwz 9,84(31)
	stw 0,3784(9)
	lwz 11,480(31)
	lwz 0,264(31)
	cmpwi 0,11,-40
	rlwinm 0,0,0,20,18
	stw 0,264(31)
	bc 4,0,.L220
	lis 29,gi@ha
	lis 3,.LC115@ha
	la 29,gi@l(29)
	la 3,.LC115@l(3)
	lwz 9,36(29)
	lis 28,.LC116@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC120@ha
	lwz 0,16(29)
	lis 11,.LC120@ha
	la 9,.LC120@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC120@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC118@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC118@l(9)
	lfs 3,0(9)
	blrl
.L224:
	mr 3,31
	la 4,.LC116@l(28)
	mr 5,26
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L224
	mr 4,26
	mr 3,31
	bl ThrowClientHead
	lwz 10,84(31)
	li 0,5
	li 11,0
	stw 0,3760(10)
	lwz 9,84(31)
	stw 11,3756(9)
	stw 11,512(31)
	b .L226
.L220:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L226
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
	stw 7,3760(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L228
	li 0,172
	li 9,177
	b .L237
.L228:
	cmpwi 0,10,1
	bc 12,2,.L232
	bc 12,1,.L236
	cmpwi 0,10,0
	bc 12,2,.L231
	b .L229
.L236:
	cmpwi 0,10,2
	bc 12,2,.L233
	b .L229
.L231:
	li 0,177
	li 9,183
	b .L237
.L232:
	li 0,183
	li 9,189
	b .L237
.L233:
	li 0,189
	li 9,197
.L237:
	stw 0,56(31)
	stw 9,3756(11)
.L229:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC117@ha
	srwi 0,0,30
	la 3,.LC117@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC120@ha
	lwz 0,16(29)
	lis 11,.LC120@ha
	la 9,.LC120@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC120@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC118@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC118@l(9)
	lfs 3,0(9)
	blrl
.L226:
	mr 3,31
	bl K2_InitClientVars
	mr 3,31
	bl K2_ResetClientKeyVars
	mr 3,31
	bl K2_ClearPrevOwner
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,356(1)
	mtlr 0
	lmw 26,320(1)
	lfd 31,344(1)
	la 1,352(1)
	blr
.Lfe5:
	.size	 player_die,.Lfe5-player_die
	.section	".rodata"
	.align 2
.LC121:
	.string	"Grapple"
	.align 2
.LC122:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	li 4,0
	li 5,1628
	addi 3,31,188
	crxor 6,6,6
	bl memset
	lis 30,0x286b
	addi 29,31,740
	lis 3,.LC106@ha
	ori 30,30,51739
	la 3,.LC106@l(3)
	li 27,1
	bl FindItem
	lis 9,itemlist@ha
	mr 10,3
	la 28,itemlist@l(9)
	lis 3,.LC121@ha
	subf 0,28,10
	la 3,.LC121@l(3)
	mullw 0,0,30
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 27,29,9
	stw 10,1792(31)
	stw 10,1788(31)
	bl FindItem
	lis 11,.LC122@ha
	lis 9,ctf@ha
	la 11,.LC122@l(11)
	mr 10,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L239
	subf 0,28,10
	mullw 0,0,30
	rlwinm 0,0,0,0,29
	stwx 27,29,0
	b .L240
.L239:
	subf 0,28,10
	li 9,0
	mullw 0,0,30
	rlwinm 0,0,0,0,29
	stwx 9,29,0
.L240:
	li 9,100
	li 11,50
	li 8,200
	li 7,0
	stw 9,1768(31)
	li 10,0
	li 0,1
	stw 8,1780(31)
	stw 0,720(31)
	stw 11,1784(31)
	stw 10,3988(31)
	stw 7,3984(31)
	stw 9,724(31)
	stw 9,728(31)
	stw 8,1764(31)
	stw 11,1772(31)
	stw 11,1776(31)
	stw 7,3980(31)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 InitClientPersistant,.Lfe6-InitClientPersistant
	.globl is_bot
	.section	".sdata","aw"
	.align 2
	.type	 is_bot,@object
	.size	 is_bot,4
is_bot:
	.long 0
	.section	".rodata"
	.align 2
.LC124:
	.long 0x47c34f80
	.align 2
.LC125:
	.long 0x4b18967f
	.section	".text"
	.align 2
	.globl SelectRandomDeathmatchSpawnPoint
	.type	 SelectRandomDeathmatchSpawnPoint,@function
SelectRandomDeathmatchSpawnPoint:
	stwu 1,-96(1)
	mflr 0
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 21,28(1)
	stw 0,100(1)
	lis 9,num_dm_spots@ha
	lis 11,.LC124@ha
	lwz 0,num_dm_spots@l(9)
	li 28,0
	li 24,0
	lfs 30,.LC124@l(11)
	li 25,0
	lis 21,num_dm_spots@ha
	cmpwi 0,0,0
	fmr 29,30
	bc 4,1,.L264
	lis 9,dm_spots@ha
	lis 22,.LC125@ha
	la 27,dm_spots@l(9)
	lis 26,num_players@ha
	lis 23,players@ha
.L265:
	lwz 0,num_players@l(26)
	li 29,0
	addi 28,28,1
	lwz 31,0(27)
	cmpw 0,29,0
	addi 27,27,4
	lfs 31,.LC125@l(22)
	bc 4,0,.L273
	la 30,players@l(23)
.L268:
	lwz 9,0(30)
	addi 30,30,4
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L270
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L270
	lfs 0,4(9)
	addi 3,1,8
	lfs 13,4(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(9)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(9)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L270
	fmr 31,1
.L270:
	lwz 0,num_players@l(26)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L268
.L273:
	fcmpu 0,31,29
	bc 4,0,.L275
	fmr 29,31
	mr 25,31
	b .L263
.L275:
	fcmpu 0,31,30
	bc 4,0,.L263
	fmr 30,31
	mr 24,31
.L263:
	lwz 0,num_dm_spots@l(21)
	cmpw 0,28,0
	bc 12,0,.L265
.L264:
	cmpwi 0,28,0
	bc 4,2,.L279
	li 3,0
	b .L287
.L279:
	cmpwi 0,28,2
	bc 12,1,.L280
	li 24,0
	li 25,0
	b .L281
.L280:
	addi 28,28,-2
.L281:
	bl rand
	divw 0,3,28
	lis 9,dm_spots@ha
	la 10,dm_spots@l(9)
	mullw 0,0,28
	subf 3,0,3
.L286:
	lwz 31,0(10)
	addi 0,3,1
	addi 10,10,4
	xor 9,31,25
	subfic 8,9,0
	adde 9,8,9
	xor 11,31,24
	subfic 8,11,0
	adde 11,8,11
	or 9,9,11
	addic 9,9,-1
	subfe 9,9,9
	andc 0,0,9
	and 9,3,9
	or 3,9,0
	cmpwi 0,3,0
	addi 3,3,-1
	bc 4,2,.L286
	mr 3,31
.L287:
	lwz 0,100(1)
	mtlr 0
	lmw 21,28(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe7:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe7-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC126:
	.long 0x4b18967f
	.align 2
.LC127:
	.long 0x0
	.section	".text"
	.align 2
	.globl SelectFarthestDeathmatchSpawnPoint
	.type	 SelectFarthestDeathmatchSpawnPoint,@function
SelectFarthestDeathmatchSpawnPoint:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 22,24(1)
	stw 0,84(1)
	lis 9,num_dm_spots@ha
	li 25,0
	lwz 0,num_dm_spots@l(9)
	li 27,0
	lis 22,num_dm_spots@ha
	lis 9,.LC127@ha
	cmpw 0,25,0
	la 9,.LC127@l(9)
	lfs 30,0(9)
	bc 4,0,.L290
	lis 9,dm_spots@ha
	lis 23,.LC126@ha
	la 28,dm_spots@l(9)
	lis 26,num_players@ha
	lis 24,players@ha
.L291:
	lwz 0,num_players@l(26)
	li 29,0
	addi 27,27,1
	lwz 30,0(28)
	cmpw 0,29,0
	addi 28,28,4
	lfs 31,.LC126@l(23)
	bc 4,0,.L299
	la 31,players@l(24)
.L294:
	lwz 9,0(31)
	addi 31,31,4
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L296
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L296
	lfs 0,4(9)
	addi 3,1,8
	lfs 13,4(30)
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
	fcmpu 0,1,31
	bc 4,0,.L296
	fmr 31,1
.L296:
	lwz 0,num_players@l(26)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L294
.L299:
	fcmpu 0,31,30
	bc 4,1,.L289
	fmr 30,31
	mr 25,30
.L289:
	lwz 0,num_dm_spots@l(22)
	cmpw 0,27,0
	bc 12,0,.L291
.L290:
	cmpwi 0,25,0
	bc 4,2,.L303
	lis 9,dm_spots@ha
	lwz 3,dm_spots@l(9)
	b .L304
.L303:
	mr 3,25
.L304:
	lwz 0,84(1)
	mtlr 0
	lmw 22,24(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe8:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe8-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC128:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC129:
	.long 0x0
	.align 2
.LC130:
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
	lis 11,.LC129@ha
	lis 9,deathmatch@ha
	la 11,.LC129@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 31,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L319
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L320
	bl SelectCTFSpawnPoint
	mr 31,3
	b .L325
.L320:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L322
	bl SelectFarthestDeathmatchSpawnPoint
	mr 31,3
	b .L325
.L322:
	bl SelectRandomDeathmatchSpawnPoint
	mr 31,3
	b .L325
.L349:
	li 31,0
	b .L325
.L319:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L325
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xf7fb
	lwz 10,game+1028@l(11)
	ori 9,9,65023
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 30,0,3
	bc 12,2,.L325
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 31,game+1032@ha
.L331:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L349
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
	bc 4,2,.L331
	addic. 30,30,-1
	bc 4,2,.L331
	mr 31,29
.L325:
	cmpwi 0,31,0
	bc 4,2,.L337
	lis 29,.LC0@ha
	lis 30,game@ha
.L344:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L350
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L348
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L339
	b .L344
.L348:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L344
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L344
.L339:
	cmpwi 0,31,0
	bc 4,2,.L337
.L350:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L346
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L346:
	cmpwi 0,31,0
	bc 4,2,.L337
	lis 9,gi+28@ha
	lis 3,.LC128@ha
	lwz 0,gi+28@l(9)
	la 3,.LC128@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L337:
	lfs 0,4(31)
	lis 9,.LC130@ha
	la 9,.LC130@l(9)
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
.Lfe9:
	.size	 SelectSpawnPoint,.Lfe9-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC131:
	.string	"bodyque"
	.align 3
.LC132:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC133:
	.long 0xc1700000
	.align 2
.LC134:
	.long 0xc1c00000
	.align 2
.LC135:
	.long 0x41700000
	.align 2
.LC136:
	.long 0x0
	.align 2
.LC137:
	.long 0xc3000000
	.align 2
.LC138:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl Body_droptofloor
	.type	 Body_droptofloor,@function
Body_droptofloor:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	lis 9,.LC133@ha
	lis 10,.LC133@ha
	la 9,.LC133@l(9)
	la 10,.LC133@l(10)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC134@ha
	lfs 2,0(10)
	la 9,.LC134@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC135@ha
	lfs 13,0(11)
	la 9,.LC135@l(9)
	lis 10,.LC135@ha
	lfs 1,0(9)
	la 10,.LC135@l(10)
	lis 9,.LC135@ha
	lfs 2,0(10)
	stfs 13,188(31)
	la 9,.LC135@l(9)
	lfs 0,4(11)
	lfs 3,0(9)
	stfs 0,192(31)
	lfs 13,8(11)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lis 9,.LC136@ha
	lfs 13,0(11)
	la 9,.LC136@l(9)
	lis 10,.LC136@ha
	lfs 1,0(9)
	la 10,.LC136@l(10)
	lis 9,.LC137@ha
	lfs 2,0(10)
	stfs 13,200(31)
	la 9,.LC137@l(9)
	lfs 0,4(11)
	lfs 3,0(9)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 10,.LC138@ha
	lfs 0,0(11)
	la 10,.LC138@l(10)
	lis 29,gi@ha
	lfs 12,12(31)
	la 29,gi@l(29)
	addi 3,1,8
	lfs 10,8(31)
	addi 4,31,4
	addi 5,31,188
	fadds 11,11,0
	lfs 13,0(10)
	addi 6,31,200
	addi 7,1,72
	mr 8,31
	li 9,3
	stfs 11,72(1)
	fadds 13,12,13
	lfs 0,4(11)
	fadds 10,10,0
	stfs 10,76(1)
	lfs 0,8(11)
	stfs 13,12(31)
	lwz 11,48(29)
	fadds 12,12,0
	mtlr 11
	stfs 12,80(1)
	blrl
	lfs 12,20(1)
	mr 3,31
	lfs 0,24(1)
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 12,2,.L358
	lis 9,level+4@ha
	lis 11,.LC132@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC132@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L358:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe10:
	.size	 Body_droptofloor,.Lfe10-Body_droptofloor
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
	mulli 27,27,1352
	addi 27,27,1352
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
	lis 9,0xfb74
	lis 11,body_die@ha
	ori 9,9,41881
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
.Lfe11:
	.size	 CopyToBodyQue,.Lfe11-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC139:
	.string	"menu_loadgame\n"
	.align 2
.LC140:
	.string	"spectator"
	.align 2
.LC141:
	.string	"none"
	.align 2
.LC142:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC143:
	.string	"spectator 0\n"
	.align 2
.LC144:
	.string	"Server spectator limit is full."
	.align 2
.LC145:
	.string	"password"
	.align 2
.LC146:
	.string	"Password incorrect.\n"
	.align 2
.LC147:
	.string	"spectator 1\n"
	.align 2
.LC148:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC149:
	.string	"%s joined the game\n"
	.align 2
.LC150:
	.long 0x3f800000
	.align 3
.LC151:
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
	bc 12,2,.L372
	lis 4,.LC140@ha
	addi 3,3,188
	la 4,.LC140@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L373
	lis 4,.LC141@ha
	la 4,.LC141@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L373
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L373
	lis 29,gi@ha
	lis 5,.LC142@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC142@l(5)
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
	lis 3,.LC143@ha
	la 3,.LC143@l(3)
	b .L386
.L373:
	lis 9,maxclients@ha
	lis 10,.LC150@ha
	lwz 11,maxclients@l(9)
	la 10,.LC150@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L375
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC151@ha
	la 9,.LC151@l(9)
	addi 10,11,1352
	lfd 13,0(9)
.L377:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L376
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L376:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1352
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L377
.L375:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC151@ha
	la 10,.LC151@l(10)
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
	bc 4,3,.L381
	lis 29,gi@ha
	lis 5,.LC144@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC144@l(5)
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
	lis 3,.LC143@ha
	la 3,.LC143@l(3)
	b .L386
.L372:
	lis 4,.LC145@ha
	addi 3,3,188
	la 4,.LC145@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lis 28,gi@ha
	lwz 9,password@l(29)
	mr 30,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L381
	lis 4,.LC141@ha
	la 4,.LC141@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L381
	lwz 9,password@l(29)
	mr 4,30
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L381
	la 29,gi@l(28)
	lis 5,.LC146@ha
	lwz 9,8(29)
	li 4,2
	la 5,.LC146@l(5)
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
	lis 3,.LC147@ha
	la 3,.LC147@l(3)
.L386:
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L371
.L381:
	lwz 11,84(31)
	li 9,0
	mr 3,31
	stw 9,3464(11)
	stw 9,1800(11)
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L383
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfb74
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,41881
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
.L383:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3856(11)
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L384
	lis 9,gi@ha
	lis 4,.LC148@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC148@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L371
.L384:
	lis 9,gi@ha
	lis 4,.LC149@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC149@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L371:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 spectator_respawn,.Lfe12-spectator_respawn
	.section	".rodata"
	.align 2
.LC152:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC153:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC154:
	.string	"player"
	.align 2
.LC155:
	.string	"players/male/tris.md2"
	.align 2
.LC156:
	.string	"fov"
	.align 2
.LC157:
	.long 0x0
	.align 2
.LC158:
	.long 0x41400000
	.align 2
.LC159:
	.long 0x41000000
	.align 3
.LC160:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC161:
	.long 0x3f800000
	.align 2
.LC162:
	.long 0x43200000
	.align 2
.LC163:
	.long 0x47800000
	.align 2
.LC164:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4512(1)
	mflr 0
	stfd 31,4504(1)
	stmw 20,4456(1)
	stw 0,4516(1)
	lis 9,.LC152@ha
	lis 30,the_client@ha
	lwz 4,.LC152@l(9)
	lis 11,.LC153@ha
	addi 8,1,8
	lwz 0,the_client@l(30)
	la 9,.LC152@l(9)
	la 7,.LC153@l(11)
	lwz 29,8(9)
	addi 5,1,24
	mr 31,3
	lwz 6,4(9)
	cmpwi 0,0,0
	stw 4,8(1)
	lwz 10,.LC153@l(11)
	stw 29,8(8)
	stw 6,4(8)
	lwz 0,8(7)
	lwz 9,4(7)
	stw 10,24(1)
	stw 0,8(5)
	stw 9,4(5)
	bc 4,2,.L388
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L388
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpwi 0,0,1
	bc 12,1,.L388
	stw 31,the_client@l(30)
.L388:
	lis 8,.LC157@ha
	addi 5,1,56
	la 8,.LC157@l(8)
	mr 3,31
	lfs 31,0(8)
	mr 20,5
	addi 4,1,40
	bl SelectSpawnPoint
	lis 9,deathmatch@ha
	lis 11,g_edicts@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	lis 0,0xfb74
	lwz 9,g_edicts@l(11)
	ori 0,0,41881
	lfs 0,20(10)
	subf 9,9,31
	mullw 9,9,0
	fcmpu 0,0,31
	srawi 9,9,3
	addi 21,9,-1
	bc 12,2,.L389
	addi 27,1,1704
	addi 26,30,1816
	addi 29,1,3416
	mr 4,26
	li 5,1708
	mr 3,27
	crxor 6,6,6
	bl memcpy
	addi 28,30,188
	mr 23,29
	mr 3,29
	mr 4,28
	li 5,512
	mr 22,27
	crxor 6,6,6
	bl memcpy
	mr 25,26
	mr 24,28
	lis 9,swaat@ha
	lwz 11,swaat@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L390
	mr 3,30
	bl K2_InitClientPersistant
	b .L391
.L390:
	mr 3,30
	bl InitClientPersistant
.L391:
	mr 4,23
	mr 3,31
	bl ClientUserinfoChanged
	b .L392
.L389:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L393
	addi 28,1,1704
	addi 27,30,1816
	mr 4,27
	li 5,1708
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 22,28
	mr 25,27
	addi 26,1,3928
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	mr 24,29
	lwz 9,1804(30)
	addi 4,1,1720
	li 5,1628
	mr 3,29
	stw 9,3336(1)
	lwz 0,1808(30)
	stw 0,3340(1)
	crxor 6,6,6
	bl memcpy
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3352(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L392
	stw 9,1800(30)
	b .L392
.L393:
	addi 29,1,1704
	li 4,0
	mr 3,29
	li 5,1708
	crxor 6,6,6
	bl memset
	mr 22,29
	addi 25,30,1816
	addi 24,30,188
.L392:
	addi 29,1,72
	mr 4,24
	li 5,1628
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lwz 26,3912(30)
	li 4,0
	li 5,4088
	lwz 27,3924(30)
	mr 3,30
	lwz 28,3928(30)
	lfs 31,3920(30)
	crxor 6,6,6
	bl memset
	mr 4,29
	li 5,1628
	mr 3,24
	crxor 6,6,6
	bl memcpy
	mr 3,25
	mr 4,22
	li 5,1708
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	stw 26,3912(30)
	cmpwi 0,0,0
	stw 27,3924(30)
	stw 28,3928(30)
	stfs 31,3920(30)
	bc 12,1,.L396
	lis 11,swaat@ha
	lis 8,.LC157@ha
	lwz 9,swaat@l(11)
	la 8,.LC157@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L397
	mr 3,30
	bl K2_InitClientPersistant
	b .L396
.L397:
	mr 3,30
	bl InitClientPersistant
.L396:
	lwz 7,84(31)
	lis 8,.LC157@ha
	lis 10,coop@ha
	la 8,.LC157@l(8)
	lwz 11,264(31)
	lwz 9,724(7)
	lfs 31,0(8)
	lwz 8,coop@l(10)
	stw 9,480(31)
	lwz 0,728(7)
	stw 0,484(31)
	lwz 9,732(7)
	or 11,11,9
	stw 11,264(31)
	lfs 0,20(8)
	fcmpu 0,0,31
	bc 12,2,.L400
	lwz 0,1800(7)
	stw 0,3464(7)
.L400:
	lwz 0,968(31)
	li 29,0
	stw 29,552(31)
	cmpwi 0,0,0
	bc 4,2,.L401
	lis 9,game+1028@ha
	mulli 11,21,4088
	lwz 0,game+1028@l(9)
	add 0,0,11
	stw 0,84(31)
.L401:
	li 9,22
	lis 11,.LC154@ha
	stw 29,492(31)
	stw 9,508(31)
	li 6,2
	la 11,.LC154@l(11)
	li 0,4
	li 10,1
	stw 11,280(31)
	li 8,200
	lis 9,.LC158@ha
	stw 0,260(31)
	la 9,.LC158@l(9)
	stw 6,248(31)
	lis 7,level+4@ha
	stw 10,88(31)
	lis 0,0x201
	stw 8,400(31)
	ori 0,0,3
	stw 6,512(31)
	lfs 0,level+4@l(7)
	lfs 13,0(9)
	lwz 11,968(31)
	lis 9,.LC155@ha
	la 9,.LC155@l(9)
	stw 0,252(31)
	fadds 0,0,13
	cmpwi 0,11,0
	stw 9,268(31)
	stfs 0,404(31)
	bc 4,2,.L402
	lis 9,player_pain@ha
	lis 11,player_die@ha
	la 9,player_pain@l(9)
	la 11,player_die@l(11)
	stw 9,452(31)
	stw 11,456(31)
.L402:
	lfs 10,12(1)
	li 4,0
	li 5,184
	lfs 0,16(1)
	lfs 13,24(1)
	lfs 12,28(1)
	lfs 11,32(1)
	lfs 9,8(1)
	lwz 9,264(31)
	lwz 0,184(31)
	rlwinm 9,9,0,21,19
	lwz 3,84(31)
	rlwinm 0,0,0,31,29
	stw 9,264(31)
	stw 0,184(31)
	stfs 10,192(31)
	stfs 0,196(31)
	stfs 13,200(31)
	stfs 12,204(31)
	stfs 11,208(31)
	stw 29,608(31)
	stfs 9,188(31)
	stw 29,612(31)
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 8,.LC159@ha
	lfs 0,40(1)
	la 8,.LC159@l(8)
	mr 11,9
	lfs 10,0(8)
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4448(1)
	lwz 9,4452(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4448(1)
	lwz 11,4452(1)
	sth 11,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4448(1)
	lwz 10,4452(1)
	sth 10,8(30)
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L403
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L404
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4448(1)
	lwz 11,4452(1)
	andi. 9,11,32768
	bc 4,2,.L437
.L404:
	lis 4,.LC156@ha
	mr 3,24
	la 4,.LC156@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4452(1)
	lis 0,0x4330
	lis 8,.LC160@ha
	la 8,.LC160@l(8)
	stw 0,4448(1)
	lis 11,.LC161@ha
	lfd 13,0(8)
	la 11,.LC161@l(11)
	lfd 0,4448(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L406
.L437:
	lis 0,0x42b4
	stw 0,112(30)
	b .L405
.L406:
	lis 8,.LC162@ha
	la 8,.LC162@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L405
	stfs 13,112(30)
.L405:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	stw 3,88(30)
.L403:
	lis 11,g_edicts@ha
	lis 8,.LC161@ha
	lfs 13,48(1)
	lwz 9,g_edicts@l(11)
	la 8,.LC161@l(8)
	lis 0,0xfb74
	lfs 0,0(8)
	ori 0,0,41881
	li 11,0
	subf 9,9,31
	lis 8,.LC163@ha
	lfs 12,40(1)
	mullw 9,9,0
	la 8,.LC163@l(8)
	li 10,255
	fadds 13,13,0
	lfs 10,0(8)
	li 0,3
	mr 5,20
	lfs 0,44(1)
	lis 8,.LC164@ha
	mtctr 0
	srawi 9,9,3
	la 8,.LC164@l(8)
	addi 9,9,-1
	stw 10,44(31)
	lfs 11,0(8)
	addi 6,30,3496
	addi 7,30,20
	stw 11,56(31)
	li 8,0
	stfs 12,28(31)
	stfs 0,32(31)
	stw 9,60(31)
	stfs 13,36(31)
	stw 11,64(31)
	stw 10,40(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
.L436:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,4448(1)
	lwz 9,4452(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L436
	lis 8,.LC157@ha
	lfs 0,60(1)
	la 8,.LC157@l(8)
	lfs 12,0(8)
	stfs 0,20(31)
	stfs 12,24(31)
	stfs 12,16(31)
	stfs 12,28(30)
	lfs 13,20(31)
	lwz 0,1812(30)
	stfs 13,32(30)
	cmpwi 0,0,0
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,3700(30)
	lfs 0,20(31)
	stfs 0,3704(30)
	lfs 13,24(31)
	stfs 13,3708(30)
	bc 12,2,.L414
	li 9,0
	li 10,1
	stw 10,3508(30)
	lis 8,gi+72@ha
	mr 3,31
	stw 9,3972(30)
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
	b .L387
.L414:
	lis 9,ctf@ha
	stw 0,3508(30)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L416
	mr 3,31
	bl CTFStartClient
	b .L438
.L416:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L418
	mr 3,31
	bl K2_StartClient
.L438:
	cmpwi 0,3,0
	bc 4,2,.L387
.L418:
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,504(31)
	cmpwi 0,0,0
	bc 4,2,.L422
	lwz 3,84(31)
	addi 3,3,700
	bl G_CopyString
	stw 3,504(31)
.L422:
	lwz 0,1788(30)
	stw 0,3596(30)
	lwz 9,968(31)
	cmpwi 0,9,0
	bc 4,2,.L423
	mr 3,31
	bl ChangeWeapon
.L423:
	lwz 11,968(31)
	li 9,0
	lis 0,0x4200
	stw 0,1304(31)
	cmpwi 0,11,0
	stw 9,1292(31)
	stw 9,1312(31)
	stw 9,1316(31)
	bc 4,2,.L424
	lwz 9,84(31)
	lis 28,bot_calc_nodes@ha
	lwz 0,3924(9)
	cmpwi 0,0,0
	bc 12,2,.L425
	li 0,10
	li 10,0
	mtctr 0
.L435:
	lwz 11,84(31)
	lfs 0,4(31)
	lwz 9,3924(11)
	stfsx 0,10,9
	lwz 11,84(31)
	lfs 0,8(31)
	lwz 9,3924(11)
	add 9,10,9
	stfs 0,4(9)
	lwz 11,84(31)
	lfs 0,12(31)
	lwz 9,3924(11)
	add 9,10,9
	stfs 0,8(9)
	lwz 11,84(31)
	lfs 0,3700(11)
	lwz 9,3928(11)
	stfsx 0,10,9
	lwz 11,84(31)
	lwz 9,3928(11)
	lfs 0,3704(11)
	add 9,10,9
	stfs 0,4(9)
	lwz 11,84(31)
	lwz 9,3928(11)
	lfs 0,3708(11)
	add 9,10,9
	addi 10,10,12
	stfs 0,8(9)
	bdnz .L435
.L425:
	lis 9,bot_calc_nodes@ha
	lwz 0,bot_calc_nodes@l(9)
	cmpwi 0,0,0
	bc 12,2,.L424
	lis 30,trail@ha
	lwz 0,trail@l(30)
	la 29,trail@l(30)
	cmpwi 0,0,0
	bc 4,2,.L432
	bl G_Spawn
	stw 3,trail@l(30)
.L432:
	lwz 9,bot_calc_nodes@l(28)
	lis 8,.LC157@ha
	la 8,.LC157@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L424
	lwz 9,trail@l(30)
	lfs 0,288(9)
	fcmpu 0,0,13
	bc 12,2,.L424
	mr 3,31
	li 4,0
	li 5,1
	bl ClosestNodeToEnt
	mr. 3,3
	bc 12,0,.L424
	slwi 0,3,2
	lwzx 9,29,0
	stw 9,1292(31)
.L424:
	lis 11,protecttime@ha
	lis 10,level+4@ha
	lwz 8,84(31)
	lwz 9,protecttime@l(11)
	lfs 0,level+4@l(10)
	lfs 13,20(9)
	fadds 0,0,13
	stfs 0,4056(8)
.L387:
	lwz 0,4516(1)
	mtlr 0
	lmw 20,4456(1)
	lfd 31,4504(1)
	la 1,4512(1)
	blr
.Lfe13:
	.size	 PutClientInServer,.Lfe13-PutClientInServer
	.section	".rodata"
	.align 2
.LC165:
	.long 0x0
	.align 2
.LC166:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-352(1)
	mflr 0
	stfd 31,344(1)
	stmw 28,328(1)
	stw 0,356(1)
	lis 9,.LC165@ha
	mr 30,3
	la 9,.LC165@l(9)
	lfs 31,0(9)
	bl G_InitEdict
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L440
	lwz 9,84(30)
	li 0,0
	stw 0,3912(9)
.L440:
	lwz 31,84(30)
	li 4,0
	li 5,1708
	lwz 29,3468(31)
	addi 3,31,1816
	lwz 28,3520(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3468(31)
	addi 3,31,1832
	stw 28,3520(31)
	addi 4,31,188
	li 5,1628
	lwz 0,level@l(9)
	stw 0,3460(31)
	crxor 6,6,6
	bl memcpy
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L442
	lwz 0,3468(31)
	cmpwi 0,0,0
	bc 12,1,.L442
	lis 9,is_bot@ha
	mr 3,31
	lwz 4,is_bot@l(9)
	bl CTFAssignTeam
.L442:
	mr 3,30
	bl K2_InitClientVars
	mr 3,30
	bl K2_ResetClientKeyVars
	mr 3,30
	bl PutClientInServer
	lis 9,level@ha
	lis 11,.LC166@ha
	lwz 10,84(30)
	la 28,level@l(9)
	la 11,.LC166@l(11)
	lfs 12,0(11)
	li 0,3
	mr 3,30
	lfs 0,4(28)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,320(1)
	lwz 11,324(1)
	stw 11,1816(10)
	lwz 9,84(30)
	stw 0,1824(9)
	bl EntityListAdd
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lwz 9,100(31)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfb74
	lwz 10,104(31)
	lwz 3,g_edicts@l(9)
	ori 0,0,41881
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,100(31)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(31)
	addi 3,30,4
	li 4,2
	mtlr 9
	blrl
	lis 9,.LC165@ha
	lis 11,ctf@ha
	la 9,.LC165@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L443
	lwz 29,84(30)
	lwz 3,3468(29)
	addi 29,29,700
	bl CTFTeamName
	lfs 1,4(28)
	mr 5,3
	mr 4,29
	mr 3,31
	bl sl_LogPlayerConnect
	b .L444
.L443:
	addi 29,1,8
	mr 4,28
	li 5,304
	mr 3,29
	crxor 6,6,6
	bl memcpy
	mr 3,31
	mr 4,29
	mr 5,30
	bl sl_WriteStdLogPlayerEntered
.L444:
	mr 3,30
	bl ClientEndServerFrame
	lwz 0,356(1)
	mtlr 0
	lmw 28,328(1)
	lfd 31,344(1)
	la 1,352(1)
	blr
.Lfe14:
	.size	 ClientBeginDeathmatch,.Lfe14-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC167:
	.string	"!zbot\n"
	.align 2
.LC168:
	.string	"#zbot\n"
	.align 2
.LC169:
	.string	"alias +hook +use; alias -hook -use;\n"
	.align 2
.LC170:
	.string	"alias +feign cmd feign; alias -feign cmd feign;\n"
	.align 2
.LC171:
	.string	"alias take_key cmd take\n"
	.align 2
.LC172:
	.string	"%s entered the game\n"
	.align 2
.LC173:
	.long 0x0
	.align 2
.LC174:
	.long 0x47800000
	.align 2
.LC175:
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
	lis 0,0xfb74
	lis 4,num_players@ha
	lis 11,game+1028@ha
	ori 0,0,41881
	lwz 10,num_players@l(4)
	subf 9,9,30
	lwz 7,game+1028@l(11)
	lis 6,num_clients@ha
	mullw 9,9,0
	lis 11,ctf@ha
	lis 8,players@ha
	lwz 5,ctf@l(11)
	slwi 0,10,2
	la 8,players@l(8)
	srawi 9,9,3
	lis 11,.LC173@ha
	mulli 9,9,4088
	la 11,.LC173@l(11)
	addi 10,10,1
	lfs 13,0(11)
	addi 9,9,-4088
	lwz 11,num_clients@l(6)
	add 7,7,9
	stw 7,84(30)
	addi 11,11,1
	stwx 30,8,0
	lfs 0,20(5)
	stw 10,num_players@l(4)
	stw 11,num_clients@l(6)
	fcmpu 0,0,13
	bc 4,2,.L447
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 12,2,.L447
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	li 9,0
	rlwinm 3,3,0,0,29
	stwx 9,11,3
.L447:
	lis 11,.LC173@ha
	lis 9,deathmatch@ha
	la 11,.LC173@l(11)
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L449
	lis 4,.LC169@ha
	mr 3,30
	la 4,.LC169@l(4)
	bl stuffcmd
	lis 4,.LC170@ha
	mr 3,30
	la 4,.LC170@l(4)
	bl stuffcmd
	lis 4,.LC171@ha
	mr 3,30
	la 4,.LC171@l(4)
	bl stuffcmd
	mr 3,30
	bl ClientBeginDeathmatch
	b .L446
.L449:
	lwz 0,88(30)
	cmpwi 0,0,1
	bc 4,2,.L450
	lis 9,.LC174@ha
	lis 11,.LC175@ha
	li 0,3
	la 9,.LC174@l(9)
	la 11,.LC175@l(11)
	mtctr 0
	lfs 11,0(9)
	li 8,0
	lfs 12,0(11)
	li 7,0
.L462:
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
	bdnz .L462
	b .L456
.L450:
	mr 3,30
	bl G_InitEdict
	lis 9,.LC154@ha
	lwz 31,84(30)
	li 4,0
	la 9,.LC154@l(9)
	li 5,1708
	stw 9,280(30)
	addi 3,31,1816
	lwz 29,3468(31)
	lwz 28,3520(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3468(31)
	addi 3,31,1832
	stw 28,3520(31)
	addi 4,31,188
	li 5,1628
	lwz 0,level@l(9)
	stw 0,3460(31)
	crxor 6,6,6
	bl memcpy
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L458
	lwz 0,3468(31)
	cmpwi 0,0,0
	bc 12,1,.L458
	lis 9,is_bot@ha
	mr 3,31
	lwz 4,is_bot@l(9)
	bl CTFAssignTeam
.L458:
	mr 3,30
	bl PutClientInServer
.L456:
	lis 11,.LC173@ha
	lis 9,level+200@ha
	la 11,.LC173@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L459
	mr 3,30
	bl MoveClientToIntermission
	b .L460
.L459:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L460
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfb74
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,41881
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
	lis 4,.LC172@ha
	li 3,2
	la 4,.LC172@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
.L460:
	mr 3,30
	bl ClientEndServerFrame
.L446:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ClientBegin,.Lfe15-ClientBegin
	.section	".rodata"
	.align 2
.LC176:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC177:
	.string	"name"
	.align 2
.LC178:
	.string	"0"
	.align 2
.LC179:
	.string	"skin"
	.align 2
.LC180:
	.string	"%s\\%s"
	.align 2
.LC181:
	.string	"hand"
	.align 2
.LC182:
	.long 0x0
	.align 3
.LC183:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC184:
	.long 0x3f800000
	.align 2
.LC185:
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
	mr 27,4
	mr 30,3
	mr 3,27
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L464
	lis 11,.LC176@ha
	lwz 0,.LC176@l(11)
	la 9,.LC176@l(11)
	lwz 10,4(9)
	lwz 11,8(9)
	lwz 8,12(9)
	stw 0,0(27)
	stw 10,4(27)
	stw 11,8(27)
	stw 8,12(27)
	lhz 7,28(9)
	lwz 0,16(9)
	lwz 11,20(9)
	lwz 10,24(9)
	stw 0,16(27)
	stw 11,20(27)
	stw 10,24(27)
	sth 7,28(27)
.L464:
	lis 4,.LC177@ha
	mr 3,27
	la 4,.LC177@l(4)
	bl Info_ValueForKey
	lwz 9,84(30)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lwz 3,84(30)
	addi 3,3,700
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L465
	lwz 3,84(30)
	mr 4,31
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L465
	lis 9,level+4@ha
	lwz 4,84(30)
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	la 3,gi@l(3)
	mr 5,31
	addi 4,4,700
	bl sl_LogPlayerRename
.L465:
	lis 4,.LC140@ha
	mr 3,27
	la 4,.LC140@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC182@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC182@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L467
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L467
	lis 4,.LC178@ha
	la 4,.LC178@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L467
	lwz 9,84(30)
	li 0,1
	b .L480
.L467:
	lwz 9,84(30)
	li 0,0
.L480:
	stw 0,1812(9)
	lwz 9,84(30)
	lwz 9,3912(9)
	cmpwi 0,9,0
	bc 12,2,.L470
	lwz 3,8(9)
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L469
.L470:
	lis 4,.LC179@ha
	mr 3,27
	la 4,.LC179@l(4)
	bl Info_ValueForKey
	lis 9,ctf@ha
	lis 11,g_edicts@ha
	lwz 10,ctf@l(9)
	mr 31,3
	lis 9,.LC182@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC182@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,30
	lis 9,0xfb74
	ori 9,9,41881
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,3
	bc 12,2,.L471
	mr 4,31
	mr 3,30
	bl CTFAssignSkin
	b .L473
.L471:
	lwz 4,84(30)
	lis 29,gi@ha
	lis 3,.LC180@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC180@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	b .L473
.L469:
	lwz 9,84(30)
	lwz 11,3912(9)
	lwz 3,8(11)
	bl G_CopyString
	lis 9,g_edicts@ha
	lis 0,0xfb74
	lwz 4,84(30)
	lwz 29,g_edicts@l(9)
	ori 0,0,41881
	mr 31,3
	lis 28,gi@ha
	lis 3,.LC180@ha
	subf 29,29,30
	la 28,gi@l(28)
	mullw 29,29,0
	addi 4,4,700
	mr 5,31
	la 3,.LC180@l(3)
	srawi 29,29,3
	addi 29,29,1311
	crxor 6,6,6
	bl va
	lwz 9,24(28)
	mr 4,3
	mr 3,29
	mtlr 9
	blrl
	lwz 0,136(28)
	mr 3,31
	mtlr 0
	blrl
.L473:
	lis 9,.LC182@ha
	lis 11,deathmatch@ha
	la 9,.LC182@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L474
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L474
	lwz 9,84(30)
	b .L481
.L474:
	lis 4,.LC156@ha
	mr 3,27
	la 4,.LC156@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(30)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC183@ha
	la 10,.LC183@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC184@ha
	la 10,.LC184@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(30)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L476
.L481:
	lis 0,0x42b4
	stw 0,112(9)
	b .L475
.L476:
	lis 11,.LC185@ha
	la 11,.LC185@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L475
	stfs 13,112(9)
.L475:
	lis 4,.LC181@ha
	mr 3,27
	la 4,.LC181@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L479
	mr 3,31
	bl atoi
	lwz 9,84(30)
	stw 3,716(9)
.L479:
	lwz 3,84(30)
	mr 4,27
	li 5,511
	addi 3,3,188
	bl strncpy
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 ClientUserinfoChanged,.Lfe16-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC186:
	.string	"ip"
	.align 2
.LC187:
	.string	"rejmsg"
	.align 2
.LC188:
	.string	"Banned."
	.align 2
.LC189:
	.string	"Spectator password required or incorrect."
	.align 2
.LC190:
	.string	"Password required or incorrect."
	.align 2
.LC191:
	.string	"%s connected\n"
	.align 2
.LC192:
	.long 0x0
	.align 3
.LC193:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 30,3
	mr 27,4
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 4,2,.L483
	lis 4,.LC186@ha
	mr 3,27
	la 4,.LC186@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L484
	lis 4,.LC187@ha
	lis 5,.LC188@ha
	mr 3,27
	la 4,.LC187@l(4)
	la 5,.LC188@l(5)
	b .L513
.L484:
	lis 4,.LC140@ha
	mr 3,27
	la 4,.LC140@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC192@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC192@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L485
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L485
	lis 4,.LC178@ha
	la 4,.LC178@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L485
	lis 29,spectator_password@ha
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L486
	lis 4,.LC141@ha
	la 4,.LC141@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L486
	lwz 9,spectator_password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L486
	lis 4,.LC187@ha
	lis 5,.LC189@ha
	mr 3,27
	la 4,.LC187@l(4)
	la 5,.LC189@l(5)
	b .L513
.L486:
	lis 9,maxclients@ha
	lis 10,.LC192@ha
	lwz 11,maxclients@l(9)
	la 10,.LC192@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L488
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC193@ha
	la 9,.LC193@l(9)
	addi 10,11,1352
	lfd 13,0(9)
.L490:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L489
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L489:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1352
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L490
.L488:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC193@ha
	la 10,.LC193@l(10)
	stw 11,16(1)
	lfd 12,0(10)
	lfd 0,16(1)
	lis 10,maxspectators@ha
	lwz 11,maxspectators@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L494
	lis 4,.LC187@ha
	lis 5,.LC144@ha
	mr 3,27
	la 4,.LC187@l(4)
	la 5,.LC144@l(5)
	b .L513
.L485:
	lis 4,.LC145@ha
	mr 3,27
	la 4,.LC145@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(29)
	mr 31,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L494
	lis 4,.LC141@ha
	la 4,.LC141@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L494
	lwz 9,password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L494
	lis 4,.LC187@ha
	lis 5,.LC190@ha
	mr 3,27
	la 4,.LC187@l(4)
	la 5,.LC190@l(5)
.L513:
	bl Info_SetValueForKey
	li 3,0
	b .L511
.L494:
	lis 9,.LC192@ha
	lis 11,connectlogging@ha
	la 9,.LC192@l(9)
	lfs 13,0(9)
	lwz 9,connectlogging@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L483
	mr 3,27
	bl K2_LogPlayerIP
.L483:
	lis 11,g_edicts@ha
	lis 0,0xfb74
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,41881
	lis 11,game+1028@ha
	cmpwi 0,10,0
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	srawi 9,9,3
	mulli 9,9,4088
	addi 9,9,-4088
	add 8,8,9
	stw 8,84(30)
	bc 4,2,.L497
	li 0,-1
	lis 9,is_bot@ha
	stw 0,3468(8)
	li 4,0
	li 5,1708
	lwz 31,84(30)
	lwz 0,968(30)
	lwz 29,3468(31)
	addi 3,31,1816
	stw 0,is_bot@l(9)
	lwz 28,3520(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3468(31)
	addi 3,31,1832
	stw 28,3520(31)
	addi 4,31,188
	li 5,1628
	lwz 0,level@l(9)
	stw 0,3460(31)
	crxor 6,6,6
	bl memcpy
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lis 9,.LC192@ha
	la 9,.LC192@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L499
	lwz 0,3468(31)
	cmpwi 0,0,0
	bc 12,1,.L499
	lis 9,is_bot@ha
	mr 3,31
	lwz 4,is_bot@l(9)
	bl CTFAssignTeam
.L499:
	lis 9,game+1560@ha
	lis 11,is_bot@ha
	lwz 10,game+1560@l(9)
	li 0,0
	stw 0,is_bot@l(11)
	cmpwi 0,10,0
	bc 12,2,.L501
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L497
.L501:
	lis 9,.LC192@ha
	lis 11,swaat@ha
	la 9,.LC192@l(9)
	lfs 13,0(9)
	lwz 9,swaat@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L502
	lwz 3,84(30)
	bl K2_InitClientPersistant
	b .L497
.L502:
	lwz 3,84(30)
	bl InitClientPersistant
.L497:
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 4,2,.L504
	lwz 9,84(30)
	lis 29,gi@ha
	li 4,765
	la 29,gi@l(29)
	li 3,120
	stw 0,3912(9)
	lwz 9,132(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	li 4,765
	stw 3,3924(9)
	lwz 0,132(29)
	li 3,120
	mtlr 0
	blrl
	li 0,10
	lwz 9,84(30)
	li 10,0
	mtctr 0
	stw 3,3928(9)
.L512:
	lwz 11,84(30)
	lfs 0,4(30)
	lwz 9,3924(11)
	stfsx 0,10,9
	lwz 11,84(30)
	lfs 0,8(30)
	lwz 9,3924(11)
	add 9,10,9
	stfs 0,4(9)
	lwz 11,84(30)
	lfs 0,12(30)
	lwz 9,3924(11)
	add 9,10,9
	stfs 0,8(9)
	lwz 11,84(30)
	lfs 0,3700(11)
	lwz 9,3928(11)
	stfsx 0,10,9
	lwz 11,84(30)
	lwz 9,3928(11)
	lfs 0,3704(11)
	add 9,10,9
	stfs 0,4(9)
	lwz 11,84(30)
	lwz 9,3928(11)
	lfs 0,3708(11)
	add 9,10,9
	addi 10,10,12
	stfs 0,8(9)
	bdnz .L512
.L504:
	mr 4,27
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L510
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC191@ha
	lwz 0,gi+4@l(9)
	la 3,.LC191@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L510:
	lwz 9,84(30)
	li 0,0
	li 11,1
	stw 0,184(30)
	li 3,1
	stw 11,720(9)
.L511:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientConnect,.Lfe17-ClientConnect
	.section	".rodata"
	.align 2
.LC194:
	.string	"%s wimped out with %i lousy frags\n"
	.align 2
.LC195:
	.string	"disconnected"
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-352(1)
	mflr 0
	stmw 24,320(1)
	stw 0,356(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L514
	bl EntityListRemove
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L516
	mr 3,31
	bl botRemovePlayer
.L516:
	lwz 5,84(31)
	lis 4,.LC194@ha
	li 3,2
	la 4,.LC194@l(4)
	addi 30,1,8
	lwz 6,3464(5)
	li 29,0
	lis 27,num_players@ha
	addi 5,5,700
	addi 24,31,4
	crxor 6,6,6
	bl my_bprintf
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpw 0,29,0
	bc 12,1,.L518
	lis 9,players@ha
	la 28,players@l(9)
.L520:
	lwz 3,0(28)
	addi 28,28,4
	cmpwi 0,3,0
	bc 12,2,.L519
	lwz 11,968(3)
	cmpwi 0,11,0
	bc 4,2,.L519
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L519
	lwz 9,84(3)
	lwz 0,3972(9)
	cmpw 0,0,31
	bc 4,2,.L519
	stw 11,88(31)
	bl UpdateChaseCam
.L519:
	lwz 0,num_players@l(27)
	addi 29,29,1
	cmpw 0,29,0
	bc 4,1,.L520
.L518:
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
	lwz 9,84(31)
	lwz 4,3988(9)
	cmpwi 0,4,0
	bc 12,2,.L525
	mr 3,31
	li 5,1
	bl K2_SpawnKey
.L525:
	mr 3,31
	li 27,0
	bl K2_ResetClientKeyVars
	lis 26,gi@ha
	lis 25,g_edicts@ha
	lwz 9,84(31)
	lis 4,level@ha
	li 5,304
	la 4,level@l(4)
	mr 3,30
	stw 27,3520(9)
	la 29,gi@l(26)
	lis 28,0xfb74
	crxor 6,6,6
	bl memcpy
	ori 28,28,41881
	mr 5,31
	mr 4,30
	mr 3,29
	bl sl_LogPlayerDisconnect
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 3,g_edicts@l(25)
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
	mr 3,24
	mtlr 9
	blrl
	lwz 9,76(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 3,g_edicts@l(25)
	lis 9,.LC195@ha
	lis 4,.LC22@ha
	la 9,.LC195@l(9)
	lwz 11,84(31)
	la 4,.LC22@l(4)
	stw 9,280(31)
	subf 3,3,31
	stw 27,40(31)
	mullw 3,3,28
	stw 27,248(31)
	stw 27,88(31)
	srawi 3,3,3
	stw 27,720(11)
	addi 3,3,1311
	lwz 0,24(29)
	mtlr 0
	blrl
.L514:
	lwz 0,356(1)
	mtlr 0
	lmw 24,320(1)
	la 1,352(1)
	blr
.Lfe18:
	.size	 ClientDisconnect,.Lfe18-ClientDisconnect
	.section	".rodata"
	.align 2
.LC196:
	.string	"sv %3i:%i %i\n"
	.globl last_bot
	.section	".sdata","aw"
	.align 2
	.type	 last_bot,@object
	.size	 last_bot,4
last_bot:
	.long 0
	.section	".rodata"
	.align 2
.LC197:
	.string	"PAUSED\n\n(type \"botpause\" to resume)"
	.align 2
.LC199:
	.string	"*jump1.wav"
	.align 3
.LC198:
	.long 0x3f768000
	.long 0x0
	.align 3
.LC200:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC201:
	.long 0x0
	.align 3
.LC202:
	.long 0x40140000
	.long 0x0
	.align 3
.LC203:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC204:
	.long 0x3f800000
	.align 2
.LC205:
	.long 0x41000000
	.align 3
.LC206:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC207:
	.long 0x447a0000
	.align 3
.LC208:
	.long 0x43300000
	.long 0x0
	.align 3
.LC209:
	.long 0x40490000
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-368(1)
	mflr 0
	stfd 30,352(1)
	stfd 31,360(1)
	stmw 14,280(1)
	stw 0,372(1)
	lis 9,paused@ha
	mr 28,3
	lwz 0,paused@l(9)
	mr 26,4
	li 15,0
	cmpwi 0,0,0
	bc 12,2,.L549
	lis 4,.LC197@ha
	la 4,.LC197@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	lwz 9,84(28)
	lbz 0,16(9)
	ori 0,0,64
	stb 0,16(9)
	b .L548
.L549:
	lis 9,level@ha
	lis 10,.LC201@ha
	la 9,level@l(9)
	la 10,.LC201@l(10)
	lfs 31,0(10)
	lfs 0,200(9)
	stw 28,292(9)
	lwz 31,84(28)
	fcmpu 0,0,31
	bc 12,2,.L550
	li 0,4
	lis 11,.LC202@ha
	stw 0,0(31)
	la 11,.LC202@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L548
	lbz 0,1(26)
	andi. 10,0,128
	bc 12,2,.L548
	li 0,1
	stw 0,208(9)
	b .L548
.L550:
	lwz 0,3860(31)
	cmpwi 0,0,0
	bc 12,2,.L552
	mr 3,28
	mr 4,26
	bl CameraThink
	b .L548
.L552:
	lwz 0,968(28)
	cmpwi 0,0,0
	bc 4,2,.L548
	lwz 0,4004(31)
	cmpwi 0,0,1
	bc 4,2,.L554
	mr 3,28
	bl Pull_Grapple
.L554:
	lwz 9,84(28)
	lis 11,pm_passent@ha
	stw 28,pm_passent@l(11)
	lwz 0,3972(9)
	cmpwi 0,0,0
	bc 12,2,.L555
	lha 0,2(26)
	lis 8,0x4330
	lis 9,.LC203@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC203@l(9)
	stw 0,276(1)
	stw 8,272(1)
	lfd 12,0(9)
	lfd 0,272(1)
	lis 9,.LC198@ha
	lfd 13,.LC198@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3496(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3500(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3504(31)
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,0,.L556
	lis 10,.LC204@ha
	lfs 0,328(28)
	la 10,.LC204@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	fcmpu 0,0,31
	stfs 0,328(28)
	bc 4,0,.L548
	stfs 31,328(28)
	b .L548
.L556:
	bc 4,1,.L548
	lis 11,.LC204@ha
	lfs 0,328(28)
	la 11,.LC204@l(11)
	lfs 13,0(11)
	fsubs 0,0,13
	stfs 0,328(28)
	b .L548
.L555:
	addi 3,1,8
	li 4,0
	mr 29,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,4004(31)
	cmpwi 0,0,0
	bc 12,2,.L560
	sth 15,18(31)
	b .L561
.L560:
	lis 10,sv_gravity@ha
	lwz 9,sv_gravity@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,272(1)
	lwz 11,276(1)
	sth 11,18(31)
.L561:
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 4,2,.L562
	stw 0,0(31)
	b .L563
.L562:
	lwz 0,40(28)
	cmpwi 0,0,255
	bc 12,2,.L564
	li 0,3
	stw 0,0(31)
	b .L563
.L564:
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 4,2,.L655
	lwz 10,84(28)
	lwz 8,4012(10)
	cmpwi 0,8,0
	bc 4,2,.L655
	lis 11,level@ha
	lfs 12,4020(10)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC203@ha
	xoris 0,0,0x8000
	la 11,.LC203@l(11)
	stw 0,276(1)
	stw 10,272(1)
	lfd 13,0(11)
	lfd 0,272(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L569
.L655:
	li 0,2
	stw 0,0(31)
	b .L563
.L569:
	stw 8,0(31)
.L563:
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
	addi 30,31,3524
	addi 27,1,36
	stw 9,4(29)
	lis 17,num_players@ha
	li 7,0
	stw 10,12(29)
	lis 9,.LC205@ha
	li 8,0
	la 9,.LC205@l(9)
	li 10,3
	stw 11,8(29)
	lfs 10,0(9)
	mtctr 10
	lwz 0,16(31)
	lwz 9,20(31)
	lwz 11,24(31)
	stw 0,16(29)
	stw 9,20(29)
	stw 11,24(29)
.L654:
	lfsx 13,7,5
	lfsx 0,7,6
	mr 9,11
	addi 7,7,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,272(1)
	lwz 11,276(1)
	stfd 11,272(1)
	lwz 9,276(1)
	sthx 11,8,3
	sthx 9,8,4
	addi 8,8,2
	bdnz .L654
	mr 3,30
	addi 4,1,8
	li 5,28
	bl memcmp
	mr. 3,3
	bc 12,2,.L576
	li 0,1
	stw 0,52(1)
	b .L577
.L576:
	stw 3,52(1)
.L577:
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
	lis 9,.LC203@ha
	lwz 11,8(1)
	mr 27,24
	la 9,.LC203@l(9)
	lwz 10,4(29)
	mr 3,25
	lfd 11,0(9)
	mr 4,23
	mr 5,22
	lis 9,.LC206@ha
	lwz 0,8(29)
	lis 6,0x4330
	la 9,.LC206@l(9)
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
	stw 0,3524(31)
	stw 9,4(30)
	stw 11,8(30)
	stw 10,12(30)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	stw 0,24(30)
	stw 9,16(30)
	stw 11,20(30)
.L653:
	lhax 0,7,27
	lhax 9,7,4
	mr 10,11
	xoris 0,0,0x8000
	addi 7,7,2
	stw 0,276(1)
	xoris 9,9,0x8000
	stw 6,272(1)
	lfd 13,272(1)
	stw 9,276(1)
	stw 6,272(1)
	lfd 0,272(1)
	fsub 13,13,11
	fsub 0,0,11
	fmul 13,13,12
	fmul 0,0,12
	frsp 13,13
	frsp 0,0
	stfsx 13,8,5
	stfsx 0,8,3
	addi 8,8,4
	bdnz .L653
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 10,.LC203@ha
	lis 7,.LC198@ha
	lfs 8,204(1)
	la 10,.LC203@l(10)
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
	lfd 12,0(10)
	xoris 0,0,0x8000
	lfd 13,.LC198@l(7)
	mr 10,11
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3496(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3500(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3504(31)
	lwz 0,552(28)
	cmpwi 0,0,0
	bc 12,2,.L583
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L583
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L583
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L583
	mr 3,28
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 4,2,.L583
	lis 29,gi@ha
	lis 3,.LC199@ha
	la 29,gi@l(29)
	la 3,.LC199@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC204@ha
	lis 10,.LC204@ha
	lis 11,.LC201@ha
	mr 5,3
	la 9,.LC204@l(9)
	la 10,.LC204@l(10)
	mtlr 0
	la 11,.LC201@l(11)
	mr 3,28
	lfs 1,0(9)
	li 4,2
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	mr 4,22
	mr 3,28
	li 5,0
	bl PlayerNoise
.L583:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(28)
	stw 11,608(28)
	fctiwz 13,0
	stw 10,552(28)
	stfd 13,272(1)
	lwz 9,276(1)
	stw 9,508(28)
	bc 12,2,.L585
	lwz 0,92(10)
	stw 0,556(28)
.L585:
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L586
	lfs 0,3628(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L587
.L586:
	lfs 0,188(1)
	stfs 0,3700(31)
	lfs 13,192(1)
	stfs 13,3704(31)
	lfs 0,196(1)
	stfs 0,3708(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L587:
	lwz 3,3944(31)
	cmpwi 0,3,0
	bc 12,2,.L588
	bl CTFGrapplePull
.L588:
	lis 9,gi+72@ha
	mr 3,28
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L589
	mr 3,28
	bl G_TouchTriggers
.L589:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L591
	addi 30,1,60
.L593:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,30,0
	addi 27,29,1
	bc 4,0,.L595
	lwz 0,0(30)
	cmpw 0,0,3
	bc 12,2,.L595
	mr 9,30
.L596:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L595
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L596
.L595:
	cmpw 0,11,29
	bc 4,2,.L592
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L592
	mr 4,28
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L592:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L593
.L591:
	lis 9,.LC201@ha
	lfs 11,3920(31)
	la 9,.LC201@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L603
	lwz 0,3580(31)
	andi. 10,0,1
	bc 4,2,.L603
	lbz 0,1(26)
	andi. 11,0,1
	bc 12,2,.L603
	lis 11,level@ha
	lfs 0,3916(31)
	lis 9,.LC200@ha
	la 11,level@l(11)
	lfd 13,.LC200@l(9)
	lfs 12,4(11)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,1,.L604
	lis 9,.LC207@ha
	la 9,.LC207@l(9)
	lfs 0,0(9)
	fdivs 0,11,0
	fadds 0,12,0
	stfs 0,3916(31)
.L604:
	lfs 13,4(11)
	lfs 0,3916(31)
	fcmpu 0,0,13
	bc 4,1,.L603
	lbz 0,1(26)
	rlwinm 9,0,0,24,30
	andi. 10,9,128
	stb 9,1(26)
	bc 12,2,.L603
	addi 0,9,128
	stb 0,1(26)
.L603:
	lis 11,.LC201@ha
	lfs 13,3920(31)
	la 11,.LC201@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L607
	lbz 0,1(26)
	andi. 9,0,1
	bc 4,2,.L607
	lis 9,level+4@ha
	lis 11,.LC200@ha
	lfs 10,3916(31)
	lfs 11,level+4@l(9)
	lfd 13,.LC200@l(11)
	fmr 12,10
	fmr 0,11
	fsub 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L607
	fcmpu 0,10,11
	cror 3,2,0
	bc 4,3,.L607
	ori 0,0,1
	stb 0,1(26)
.L607:
	lwz 0,3580(31)
	lwz 11,3588(31)
	stw 0,3584(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3580(31)
	or 11,11,0
	stw 11,3588(31)
	lbz 0,15(26)
	stw 0,640(28)
	lwz 9,3588(31)
	andi. 10,9,1
	bc 12,2,.L608
	lwz 0,3508(31)
	cmpwi 0,0,0
	bc 12,2,.L609
	lwz 0,3972(31)
	li 9,0
	stw 9,3588(31)
	cmpwi 0,0,0
	bc 12,2,.L610
	lbz 0,16(31)
	stw 9,3972(31)
	andi. 0,0,191
	stb 0,16(31)
	b .L608
.L610:
	mr 3,28
	bl GetChaseTarget
	b .L608
.L609:
	lwz 0,3592(31)
	cmpwi 0,0,0
	bc 4,2,.L608
	lwz 0,3520(31)
	cmpwi 0,0,0
	bc 12,2,.L608
	li 0,1
	mr 3,28
	stw 0,3592(31)
	bl Think_Weapon
.L608:
	lwz 0,3508(31)
	cmpwi 0,0,0
	bc 12,2,.L614
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L615
	lbz 0,16(31)
	andi. 9,0,2
	bc 4,2,.L614
	lwz 9,3972(31)
	ori 0,0,2
	stb 0,16(31)
	cmpwi 0,9,0
	bc 12,2,.L617
	mr 3,28
	bl ChaseNext
	b .L614
.L617:
	mr 3,28
	bl GetChaseTarget
	b .L614
.L615:
	lbz 0,16(31)
	andi. 0,0,253
	stb 0,16(31)
.L614:
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	cmpw 0,29,0
	bc 12,1,.L621
	lis 9,players@ha
	la 30,players@l(9)
.L623:
	lwz 3,0(30)
	addi 30,30,4
	cmpwi 0,3,0
	bc 12,2,.L622
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L622
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L622
	lwz 9,84(3)
	lwz 0,3972(9)
	cmpw 0,0,28
	bc 4,2,.L622
	bl UpdateChaseCam
.L622:
	lwz 0,num_players@l(17)
	addi 29,29,1
	cmpw 0,29,0
	bc 4,1,.L623
.L621:
	mr 3,28
	bl CTFApplyRegeneration
	mr 3,28
	bl K2_Regeneration
	mr 3,28
	bl K2_KeyExpiredCheck
	mr 3,28
	bl K2_botBFKInformDanger
	lwz 0,612(28)
	cmpwi 0,0,1
	bc 4,1,.L628
	lwz 9,84(28)
	li 0,0
	stw 0,4040(9)
.L628:
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpwi 0,0,2
	bc 4,1,.L641
	lis 9,num_clients@ha
	lwz 0,num_clients@l(9)
	cmpwi 0,0,1
	bc 4,2,.L641
	lis 29,last_bot@ha
	li 26,0
	lwz 27,last_bot@l(29)
	lis 30,last_bot@ha
	bl clock
	lwz 9,last_bot@l(29)
	mr 16,3
	lwz 0,num_players@l(17)
	addi 9,9,1
	cmpw 0,9,0
	stw 9,last_bot@l(29)
	bc 12,0,.L630
	stw 26,last_bot@l(30)
.L630:
	lwz 0,508(28)
	lis 11,0x4330
	lis 10,.LC203@ha
	lfs 12,12(28)
	cmpwi 0,15,4
	xoris 0,0,0x8000
	la 10,.LC203@l(10)
	lfs 10,4(28)
	stw 0,276(1)
	stw 11,272(1)
	lfd 11,0(10)
	lfd 0,272(1)
	lfs 13,8(28)
	stfs 10,248(1)
	fsub 0,0,11
	stfs 13,252(1)
	frsp 0,0
	fadds 12,12,0
	stfs 12,256(1)
	bc 12,1,.L641
	lis 9,.LC200@ha
	lis 11,.LC201@ha
	lfd 31,.LC200@l(9)
	la 11,.LC201@l(11)
	lis 18,players@ha
	lis 9,level@ha
	lfs 30,0(11)
	la 21,players@l(18)
	la 19,level@l(9)
	mr 23,21
	lis 9,gi@ha
	mr 24,19
	la 20,gi@l(9)
	lis 25,last_bot@ha
	li 22,0
	lis 14,0x4330
	b .L635
.L643:
	lwz 0,last_bot@l(30)
	lfs 13,4(24)
	slwi 0,0,2
	lwzx 9,23,0
	lfs 0,428(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L637
	fmr 0,13
	fadd 0,0,31
	frsp 0,0
	fcmpu 0,0,30
	stfs 0,428(9)
	bc 12,2,.L636
.L637:
	lwz 9,last_bot@l(25)
	lwz 8,num_players@l(17)
	addi 9,9,1
	cmpw 0,9,8
	stw 9,last_bot@l(25)
	bc 4,2,.L639
	stw 22,last_bot@l(30)
.L639:
	lwz 10,last_bot@l(30)
	addi 26,26,1
	slwi 0,10,2
	lwzx 9,21,0
	lwz 11,968(9)
	cmpwi 0,11,0
	bc 12,2,.L640
	cmpw 0,10,27
	bc 12,2,.L641
.L640:
	cmpw 0,26,8
	bc 12,1,.L641
.L635:
	lwz 0,last_bot@l(25)
	lfs 13,4(24)
	slwi 0,0,2
	lwzx 4,23,0
	lfs 0,1000(4)
	fcmpu 0,0,13
	bc 12,2,.L637
	lwz 0,968(4)
	cmpwi 0,0,0
	bc 12,2,.L637
	lwz 9,56(20)
	addi 4,4,4
	addi 3,1,248
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L643
.L636:
	srawi 9,27,31
	lwz 11,last_bot@l(30)
	la 29,players@l(18)
	xor 0,9,27
	lfs 13,4(19)
	subf 0,0,9
	slwi 9,11,2
	srawi 0,0,31
	lwzx 9,29,9
	andc 11,11,0
	and 0,27,0
	lfs 0,1000(9)
	or 27,0,11
	fsubs 13,13,0
	fcmpu 0,13,31
	cror 3,2,1
	bc 4,3,.L645
	lwz 0,436(9)
	mr 3,9
	addi 15,15,1
	mtlr 0
	blrl
	lwz 0,last_bot@l(30)
	lis 11,0xbf80
	slwi 0,0,2
	lwzx 9,29,0
	stw 11,428(9)
.L645:
	lwz 9,last_bot@l(30)
	cmpw 0,9,27
	bc 12,2,.L641
	lwz 11,num_players@l(17)
	addi 0,9,1
	stw 0,last_bot@l(30)
	cmpw 0,0,11
	bc 4,2,.L647
	stw 22,last_bot@l(30)
.L647:
	addi 26,26,1
	cmpw 0,26,11
	bc 12,1,.L641
	bl clock
	cmpwi 0,15,4
	bc 12,1,.L641
	subf 0,16,3
	stw 0,276(1)
	lis 10,.LC208@ha
	lis 11,.LC209@ha
	la 10,.LC208@l(10)
	stw 14,272(1)
	la 11,.LC209@l(11)
	lfd 13,0(10)
	lfd 0,272(1)
	lfd 12,0(11)
	fsub 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L635
.L641:
	lis 9,.LC201@ha
	lis 11,dedicated@ha
	la 9,.LC201@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L650
	bl OptimizeRouteCache
.L650:
	mr 3,31
	bl Started_Grappling
	cmpwi 0,3,0
	bc 12,2,.L651
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 4,2,.L651
	lis 9,level@ha
	lwz 0,4008(31)
	lwz 11,level@l(9)
	cmpw 0,0,11
	bc 12,1,.L651
	lwz 0,4012(31)
	cmpwi 0,0,0
	bc 4,2,.L651
	xoris 11,11,0x8000
	lfs 12,4020(31)
	stw 11,276(1)
	lis 0,0x4330
	lis 10,.LC203@ha
	la 10,.LC203@l(10)
	stw 0,272(1)
	lfd 13,0(10)
	lfd 0,272(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,0,.L651
	lwz 0,3520(31)
	cmpwi 0,0,0
	bc 12,2,.L651
	lwz 0,3508(31)
	cmpwi 0,0,0
	bc 4,2,.L651
	mr 3,28
	bl Throw_Grapple
.L651:
	mr 3,31
	bl Ended_Grappling
	cmpwi 0,3,0
	bc 12,2,.L548
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 4,2,.L548
	lwz 3,3996(31)
	cmpwi 0,3,0
	bc 12,2,.L548
	bl Release_Grapple
.L548:
	lwz 0,372(1)
	mtlr 0
	lmw 14,280(1)
	lfd 30,352(1)
	lfd 31,360(1)
	la 1,368(1)
	blr
.Lfe19:
	.size	 ClientThink,.Lfe19-ClientThink
	.section	".rodata"
	.align 2
.LC210:
	.string	"Zbot player--->%s has been disconnected\n"
	.align 2
.LC211:
	.string	"No ZBots allowed!\n"
	.align 2
.LC212:
	.string	"disconnect\n"
	.align 2
.LC213:
	.string	"player goal"
	.section	".sdata","aw"
	.align 2
	.type	 last_checkhelp.127,@object
	.size	 last_checkhelp.127,4
last_checkhelp.127:
	.long 0x0
	.section	".rodata"
	.align 2
.LC215:
	.string	"flag_path_src"
	.align 2
.LC216:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC214:
	.long 0x46fffe00
	.align 2
.LC217:
	.long 0x0
	.align 2
.LC218:
	.long 0x40a00000
	.align 3
.LC219:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC220:
	.long 0x40800000
	.align 3
.LC221:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC222:
	.long 0x447a0000
	.align 2
.LC223:
	.long 0x44fa0000
	.align 3
.LC224:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC225:
	.long 0x442f0000
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 24,16(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L656
	lis 9,level@ha
	lis 7,.LC217@ha
	la 7,.LC217@l(7)
	la 10,level@l(9)
	lfs 13,0(7)
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L656
	lwz 30,84(31)
	lwz 0,3860(30)
	cmpwi 0,0,0
	bc 4,2,.L656
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L660
	lwz 9,1812(30)
	lwz 0,3508(30)
	cmpw 0,9,0
	bc 12,2,.L660
	lfs 0,4(10)
	lis 9,.LC218@ha
	lfs 13,3856(30)
	la 9,.LC218@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L660
	bl spectator_respawn
	b .L656
.L660:
	lis 11,nozbots@ha
	lis 7,.LC217@ha
	lwz 9,nozbots@l(11)
	la 7,.LC217@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L661
	lwz 29,968(31)
	cmpwi 0,29,0
	bc 4,2,.L661
	lwz 8,84(31)
	lwz 0,1816(8)
	cmpwi 0,0,0
	bc 4,1,.L662
	xoris 0,0,0x8000
	stw 0,12(1)
	lis 11,0x4330
	lis 10,.LC219@ha
	la 10,.LC219@l(10)
	stw 11,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lis 10,level@ha
	la 28,level@l(10)
	lfs 12,4(28)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L662
	lis 4,.LC167@ha
	stw 29,1816(8)
	mr 3,31
	la 4,.LC167@l(4)
	bl stuffcmd
	lis 4,.LC168@ha
	mr 3,31
	la 4,.LC168@l(4)
	bl stuffcmd
	lwz 11,84(31)
	lis 7,.LC220@ha
	la 7,.LC220@l(7)
	stw 29,1828(11)
	lfs 0,4(28)
	lfs 12,0(7)
	lwz 11,84(31)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,1820(11)
.L662:
	lwz 8,84(31)
	lwz 0,1820(8)
	cmpwi 0,0,0
	bc 4,1,.L661
	xoris 0,0,0x8000
	stw 0,12(1)
	lis 11,0x4330
	lis 10,.LC219@ha
	la 10,.LC219@l(10)
	stw 11,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lis 10,level@ha
	la 28,level@l(10)
	lfs 12,4(28)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L661
	li 29,0
	stw 29,1820(8)
	lwz 11,84(31)
	lwz 0,1828(11)
	cmpwi 0,0,0
	bc 12,2,.L668
	lwz 9,1824(11)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,1824(11)
	bc 12,1,.L668
	lwz 5,84(31)
	lis 4,.LC210@ha
	li 3,2
	la 4,.LC210@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lis 5,.LC211@ha
	li 4,2
	mr 3,31
	la 5,.LC211@l(5)
	crxor 6,6,6
	bl safe_cprintf
	lis 4,.LC212@ha
	mr 3,31
	la 4,.LC212@l(4)
	bl stuffcmd
	b .L661
.L668:
	lis 4,.LC167@ha
	mr 3,31
	la 4,.LC167@l(4)
	bl stuffcmd
	lis 4,.LC168@ha
	mr 3,31
	la 4,.LC168@l(4)
	bl stuffcmd
	lwz 11,84(31)
	lis 7,.LC220@ha
	la 7,.LC220@l(7)
	stw 29,1828(11)
	lfs 0,4(28)
	lfs 12,0(7)
	lwz 11,84(31)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,1820(11)
.L661:
	lwz 0,3592(30)
	cmpwi 0,0,0
	bc 4,2,.L671
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L671
	mr 3,31
	bl Think_Weapon
	b .L672
.L671:
	li 0,0
	stw 0,3592(30)
.L672:
	lis 7,.LC217@ha
	lfs 13,3920(30)
	la 7,.LC217@l(7)
	lfs 0,0(7)
	fcmpu 0,13,0
	bc 4,1,.L673
	li 9,9
	li 8,108
	mtctr 9
.L735:
	lwz 11,3924(30)
	add 9,8,11
	lfs 0,-12(9)
	stfsx 0,8,11
	lwz 9,3924(30)
	add 9,8,9
	lfs 0,-8(9)
	stfs 0,4(9)
	lwz 11,3924(30)
	add 11,8,11
	lfs 0,-4(11)
	stfs 0,8(11)
	lwz 10,3928(30)
	add 9,8,10
	lfs 0,-12(9)
	stfsx 0,8,10
	lwz 9,3928(30)
	add 9,8,9
	lfs 0,-8(9)
	stfs 0,4(9)
	lwz 11,3928(30)
	add 11,8,11
	lfs 0,-4(11)
	addi 8,8,-12
	stfs 0,8(11)
	bdnz .L735
	lfs 0,4(31)
	lwz 9,3924(30)
	stfs 0,0(9)
	lfs 0,8(31)
	lwz 11,3924(30)
	stfs 0,4(11)
	lfs 0,12(31)
	lwz 9,3924(30)
	stfs 0,8(9)
	lwz 11,84(31)
	lwz 9,3928(30)
	lfs 0,3700(11)
	stfs 0,0(9)
	lwz 11,84(31)
	lwz 9,3928(30)
	lfs 0,3704(11)
	stfs 0,4(9)
	lwz 11,84(31)
	lwz 9,3928(30)
	lfs 0,3708(11)
	stfs 0,8(9)
.L673:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L679
	lis 9,level@ha
	lfs 13,3856(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L656
	lis 11,deathmatch@ha
	lis 10,.LC217@ha
	lwz 9,deathmatch@l(11)
	la 10,.LC217@l(10)
	lfs 12,0(10)
	lfs 0,20(9)
	lwz 10,3588(30)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L684
	bc 12,30,.L656
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1024
	bc 12,2,.L656
.L684:
	bc 4,30,.L685
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L686
.L685:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L687
	mr 3,31
	bl CopyToBodyQue
.L687:
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
	lis 11,level@ha
	stb 10,17(9)
	lfs 0,4(29)
	lwz 9,84(31)
	stfs 0,3856(9)
	lwz 9,level@l(11)
	lwz 10,84(31)
	addi 9,9,1
	stw 9,4008(10)
	b .L688
.L686:
	lis 9,gi+168@ha
	lis 3,.LC139@ha
	lwz 0,gi+168@l(9)
	la 3,.LC139@l(3)
	mtlr 0
	blrl
.L688:
	li 0,0
	stw 0,3588(30)
	b .L656
.L679:
	lis 11,bot_calc_nodes@ha
	lis 7,.LC217@ha
	stw 0,3588(30)
	lwz 9,bot_calc_nodes@l(11)
	la 7,.LC217@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L689
	mr 3,31
	bl CheckMoveForNodes
.L689:
	lwz 0,264(31)
	andi. 7,0,8192
	bc 12,2,.L690
	lwz 0,412(31)
	cmpwi 0,0,0
	bc 4,2,.L691
	bl G_Spawn
	lis 9,.LC213@ha
	stw 3,412(31)
	li 0,255
	la 9,.LC213@l(9)
	lis 8,gi+72@ha
	stw 9,280(3)
	lfs 0,188(31)
	lwz 9,412(31)
	stfs 0,188(9)
	lfs 0,192(31)
	lwz 11,412(31)
	stfs 0,192(11)
	lfs 0,196(31)
	lwz 9,412(31)
	stfs 0,196(9)
	lfs 0,200(31)
	lwz 11,412(31)
	stfs 0,200(11)
	lfs 0,204(31)
	lwz 9,412(31)
	stfs 0,204(9)
	lfs 0,208(31)
	lwz 11,412(31)
	stfs 0,208(11)
	lfs 0,4(31)
	lwz 9,412(31)
	stfs 0,4(9)
	lfs 0,8(31)
	lwz 11,412(31)
	stfs 0,8(11)
	lfs 0,12(31)
	lwz 10,412(31)
	stfs 0,12(10)
	lwz 9,412(31)
	stw 0,40(9)
	lwz 0,gi+72@l(8)
	lwz 3,412(31)
	mtlr 0
	blrl
.L691:
	lwz 9,84(31)
	lwz 0,3580(9)
	andi. 7,0,1
	bc 12,2,.L692
	lfs 0,4(31)
	li 0,255
	lis 10,gi+72@ha
	lwz 11,412(31)
	stfs 0,4(11)
	lfs 0,8(31)
	lwz 9,412(31)
	stfs 0,8(9)
	lfs 0,12(31)
	lwz 11,412(31)
	stfs 0,12(11)
	lwz 9,412(31)
	stw 0,40(9)
	lwz 0,gi+72@l(10)
	lwz 3,412(31)
	mtlr 0
	blrl
.L692:
	lwz 4,412(31)
	mr 3,31
	bl Debug_ShowPathToGoal
.L690:
	lis 11,ctf@ha
	lis 7,.LC217@ha
	lwz 9,ctf@l(11)
	la 7,.LC217@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L693
	mr 3,31
	bl CarryingFlag
	cmpwi 0,3,0
	bc 12,2,.L693
	lis 9,level+4@ha
	lis 7,.LC221@ha
	lfs 13,level+4@l(9)
	lis 11,last_checkhelp.127@ha
	la 7,.LC221@l(7)
	lfd 12,0(7)
	li 27,0
	li 28,0
	lfs 0,last_checkhelp.127@l(11)
	fsub 13,13,12
	fcmpu 0,0,13
	bc 4,0,.L693
	lis 9,num_players@ha
	lis 25,num_players@ha
	lwz 0,num_players@l(9)
	cmpw 0,27,0
	bc 4,0,.L698
	lis 9,CTFFlagThink@ha
	lis 10,.LC223@ha
	la 26,CTFFlagThink@l(9)
	la 10,.LC223@l(10)
	lis 9,.LC222@ha
	lfs 31,0(10)
	lis 11,players@ha
	la 9,.LC222@l(9)
	la 30,players@l(11)
	lfs 30,0(9)
.L700:
	lwz 29,0(30)
	lwz 10,84(31)
	addi 30,30,4
	lwz 9,84(29)
	lwz 11,3468(10)
	lwz 0,3468(9)
	cmpw 0,0,11
	bc 12,2,.L701
	lwz 0,540(29)
	cmpw 0,0,31
	bc 12,2,.L701
	lwz 4,324(29)
	cmpwi 0,4,0
	bc 12,2,.L703
	lwz 0,436(4)
	cmpw 0,0,26
	bc 4,2,.L703
	mr 3,29
	bl entdist
	fcmpu 0,1,30
	bc 4,1,.L701
.L703:
	mr 3,29
	mr 4,31
	bl entdist
	fcmpu 0,1,31
	bc 4,0,.L701
	stw 31,540(29)
.L701:
	cmpw 0,29,31
	bc 12,2,.L699
	lwz 0,324(29)
	addi 11,28,1
	xor 0,0,31
	srawi 7,0,31
	xor 9,7,0
	subf 9,9,7
	srawi 9,9,31
	andc 11,11,9
	and 9,28,9
	or 28,9,11
.L699:
	lwz 0,num_players@l(25)
	addi 27,27,1
	cmpw 0,27,0
	bc 12,0,.L700
.L698:
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	lis 10,0x4330
	lis 7,.LC224@ha
	lis 9,.LC219@ha
	la 7,.LC224@l(7)
	xoris 0,0,0x8000
	la 9,.LC219@l(9)
	lfd 12,0(7)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(9)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fmr 1,0
	fmul 1,1,12
	bl ceil
	fctiwz 0,1
	stfd 0,8(1)
	lwz 30,12(1)
	cmpw 0,28,30
	bc 4,0,.L706
	lwz 0,num_players@l(25)
	li 27,0
	cmpwi 0,0,0
	bc 4,1,.L717
	lis 7,.LC225@ha
	lis 11,players@ha
	la 7,.LC225@l(7)
	lis 9,gi@ha
	lfs 31,0(7)
	la 24,gi@l(9)
	la 26,players@l(11)
.L710:
	lwz 29,0(26)
	lwz 10,84(31)
	addi 26,26,4
	lwz 9,84(29)
	lwz 11,3468(10)
	lwz 0,3468(9)
	cmpw 0,0,11
	bc 4,2,.L709
	lwz 0,324(29)
	cmpw 0,0,31
	bc 12,2,.L709
	mr 3,29
	mr 4,31
	bl entdist
	fcmpu 0,1,31
	bc 12,1,.L709
	lwz 9,56(24)
	addi 3,29,4
	addi 4,31,4
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L709
	addi 28,28,1
	stw 31,324(29)
	cmpw 0,28,30
	bc 4,0,.L717
.L709:
	lwz 0,num_players@l(25)
	addi 27,27,1
	cmpw 7,28,30
	cmpw 6,27,0
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,25,1
	and. 7,0,9
	bc 4,2,.L710
	b .L717
.L706:
	bc 4,1,.L717
	li 27,0
	mcrf 6,0
	b .L719
.L721:
	addi 27,27,1
.L719:
	lis 9,num_players@ha
	mfcr 11
	rlwinm 11,11,25,1
	lwz 0,num_players@l(9)
	cmpw 7,27,0
	mfcr 9
	rlwinm 9,9,29,1
	and. 10,9,11
	bc 12,2,.L717
	lis 9,players@ha
	slwi 0,27,2
	lwz 11,84(31)
	la 9,players@l(9)
	lwzx 29,9,0
	lwz 10,3468(11)
	lwz 9,84(29)
	lwz 0,3468(9)
	cmpw 0,0,10
	bc 4,2,.L721
	lwz 0,324(29)
	cmpw 0,0,31
	bc 4,2,.L721
	li 0,0
	stw 0,324(29)
.L717:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 7,.LC219@ha
	lis 10,.LC214@ha
	la 7,.LC219@l(7)
	stw 0,8(1)
	lis 11,level+4@ha
	lfd 0,0(7)
	lis 8,last_checkhelp.127@ha
	lfd 13,8(1)
	lis 7,.LC221@ha
	lfs 10,.LC214@l(10)
	la 7,.LC221@l(7)
	lfs 12,level+4@l(11)
	fsub 13,13,0
	lfd 11,0(7)
	frsp 13,13
	fdivs 13,13,10
	fmr 0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,last_checkhelp.127@l(8)
.L693:
	lwz 0,264(31)
	andis. 9,0,1
	bc 12,2,.L656
	li 30,0
	b .L727
.L729:
	lwz 0,892(30)
	cmpwi 0,0,0
	bc 12,2,.L727
	lwz 0,324(30)
	cmpwi 0,0,0
	bc 12,2,.L727
	lis 9,gi@ha
	lis 3,.LC216@ha
	la 31,gi@l(9)
	la 3,.LC216@l(3)
	lwz 9,32(31)
	mtlr 9
	blrl
	lwz 0,892(30)
	stw 3,40(30)
	cmpwi 0,0,0
	bc 12,2,.L732
	lwz 9,100(31)
	li 3,3
	addi 29,30,4
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,23
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,120(31)
	lwz 3,892(30)
	mtlr 9
	addi 3,3,4
	blrl
	lwz 9,88(31)
	mr 3,29
	li 4,2
	mtlr 9
	blrl
.L732:
	lwz 0,324(30)
	cmpwi 0,0,0
	bc 12,2,.L727
	lwz 9,100(31)
	li 3,3
	addi 29,30,4
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,23
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,29
	mtlr 9
	blrl
	lwz 3,324(30)
	lwz 9,120(31)
	addi 3,3,4
	mtlr 9
	blrl
	lwz 0,88(31)
	mr 3,29
	li 4,1
	mtlr 0
	blrl
.L727:
	lis 5,.LC215@ha
	mr 3,30
	la 5,.LC215@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L729
.L656:
	lwz 0,68(1)
	mtlr 0
	lmw 24,16(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe20:
	.size	 ClientBeginServerFrame,.Lfe20-ClientBeginServerFrame
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".rodata"
	.align 2
.LC226:
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
	lis 11,.LC226@ha
	lis 9,deathmatch@ha
	la 11,.LC226@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L369
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L368
.L369:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L370
	mr 3,31
	bl CopyToBodyQue
.L370:
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 11,84(31)
	li 0,6
	li 9,32
	stw 0,80(31)
	lis 8,level@ha
	stb 9,16(11)
	li 0,14
	la 10,level@l(8)
	lwz 9,84(31)
	stb 0,17(9)
	lfs 0,4(10)
	lwz 11,84(31)
	stfs 0,3856(11)
	lwz 9,level@l(8)
	lwz 11,84(31)
	addi 9,9,1
	stw 9,4008(11)
	b .L367
.L368:
	lis 9,gi+168@ha
	lis 3,.LC139@ha
	lwz 0,gi+168@l(9)
	la 3,.LC139@l(3)
	mtlr 0
	blrl
.L367:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 respawn,.Lfe21-respawn
	.section	".rodata"
	.align 2
.LC227:
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
	lwz 29,3468(31)
	li 5,1708
	addi 3,31,1816
	lwz 28,3520(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3468(31)
	addi 3,31,1832
	stw 28,3520(31)
	addi 4,31,188
	li 5,1628
	lwz 0,level@l(9)
	stw 0,3460(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC227@ha
	lis 11,ctf@ha
	la 9,.LC227@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L242
	lwz 0,3468(31)
	cmpwi 0,0,0
	bc 12,1,.L242
	lis 9,is_bot@ha
	mr 3,31
	lwz 4,is_bot@l(9)
	bl CTFAssignTeam
.L242:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 InitClientResp,.Lfe22-InitClientResp
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
	lis 11,.LC131@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC131@l(11)
.L355:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L355
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 InitBodyQue,.Lfe23-InitBodyQue
	.comm	last_trail_time,4,4
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe24:
	.size	 player_pain,.Lfe24-player_pain
	.section	".rodata"
	.align 2
.LC228:
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
	lis 9,.LC228@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC228@l(9)
	addi 10,10,1352
	lfs 13,0(9)
.L247:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L246
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
	bc 12,2,.L246
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3464(9)
	add 11,7,11
	stw 0,1800(11)
.L246:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,4088
	addi 10,10,1352
	cmpw 0,6,0
	bc 12,0,.L247
	blr
.Lfe25:
	.size	 SaveClientData,.Lfe25-SaveClientData
	.section	".rodata"
	.align 2
.LC229:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC229@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC229@l(9)
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
	stw 0,3464(7)
	blr
.Lfe26:
	.size	 FetchClientEntData,.Lfe26-FetchClientEntData
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
	.section	".rodata"
	.align 2
.LC230:
	.long 0x4b18967f
	.section	".text"
	.align 2
	.globl PlayersRangeFromSpot
	.type	 PlayersRangeFromSpot,@function
PlayersRangeFromSpot:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	lis 9,num_players@ha
	li 30,0
	lwz 0,num_players@l(9)
	lis 11,.LC230@ha
	mr 31,3
	lfs 31,.LC230@l(11)
	lis 28,num_players@ha
	cmpw 0,30,0
	bc 4,0,.L255
	lis 9,players@ha
	la 29,players@l(9)
.L257:
	lwz 9,0(29)
	addi 29,29,4
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L256
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L256
	lfs 0,4(9)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L256
	fmr 31,1
.L256:
	lwz 0,num_players@l(28)
	addi 30,30,1
	cmpw 0,30,0
	bc 12,0,.L257
.L255:
	fmr 1,31
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 PlayersRangeFromSpot,.Lfe27-PlayersRangeFromSpot
	.comm	pTempFind,4,4
	.comm	PathToEnt_Node,4,4
	.comm	PathToEnt_TargetNode,4,4
	.comm	trail_head,4,4
	.comm	last_head,4,4
	.comm	dropped_trail,4,4
	.comm	last_optimize,4,4
	.comm	optimize_marker,4,4
	.comm	trail_portals,490000,4
	.comm	num_trail_portals,2500,4
	.comm	ctf_item_head,4,4
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.section	".rodata"
	.align 2
.LC231:
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
	lis 9,.LC231@ha
	mr 30,3
	la 9,.LC231@l(9)
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
.Lfe28:
	.size	 SP_FixCoopSpots,.Lfe28-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC232:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC233:
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
	lis 11,.LC233@ha
	lis 9,coop@ha
	la 11,.LC233@l(11)
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
	lis 11,.LC232@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC232@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe29:
	.size	 SP_info_player_start,.Lfe29-SP_info_player_start
	.comm	dm_spots,256,4
	.comm	num_dm_spots,4,4
	.section	".rodata"
	.align 2
.LC234:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC234@ha
	lis 9,deathmatch@ha
	la 11,.LC234@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L22
	bl G_FreeEdict
	b .L21
.L22:
	mr 3,31
	bl SP_misc_teleporter_dest
	lis 10,num_dm_spots@ha
	lis 11,dm_spots@ha
	lwz 9,num_dm_spots@l(10)
	la 11,dm_spots@l(11)
	slwi 0,9,2
	addi 9,9,1
	stwx 31,11,0
	stw 9,num_dm_spots@l(10)
.L21:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe30:
	.size	 SP_info_player_deathmatch,.Lfe30-SP_info_player_deathmatch
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe31:
	.size	 SP_info_player_intermission,.Lfe31-SP_info_player_intermission
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
	b .L736
.L30:
	li 3,0
.L736:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 IsFemale,.Lfe32-IsFemale
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
	bc 4,2,.L737
.L34:
	li 3,0
.L737:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 IsNeutral,.Lfe33-IsNeutral
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
	bc 4,2,.L306
	bl SelectRandomDeathmatchSpawnPoint
	b .L739
.L306:
	bl SelectFarthestDeathmatchSpawnPoint
.L739:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 SelectDeathmatchSpawnPoint,.Lfe34-SelectDeathmatchSpawnPoint
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
	lis 9,0xf7fb
	lwz 10,game+1028@l(11)
	ori 9,9,65023
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,3
	bc 12,2,.L740
.L312:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L313
	li 3,0
	b .L740
.L313:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L314
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L314:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L312
	addic. 31,31,-1
	bc 4,2,.L312
	mr 3,30
.L740:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 SelectCoopSpawnPoint,.Lfe35-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC235:
	.long 0x3f800000
	.align 2
.LC236:
	.long 0x0
	.align 2
.LC237:
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
	bc 4,0,.L360
	lis 29,gi@ha
	lis 3,.LC115@ha
	la 29,gi@l(29)
	la 3,.LC115@l(3)
	lwz 9,36(29)
	lis 27,.LC116@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC235@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC235@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC235@ha
	la 9,.LC235@l(9)
	lfs 2,0(9)
	lis 9,.LC236@ha
	la 9,.LC236@l(9)
	lfs 3,0(9)
	blrl
.L364:
	mr 3,31
	la 4,.LC116@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L364
	lis 9,.LC237@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC237@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L360:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 body_die,.Lfe36-body_die
	.section	".rodata"
	.align 2
.LC238:
	.long 0x40800000
	.section	".text"
	.align 2
	.globl ZBOT_StartScan
	.type	 ZBOT_StartScan,@function
ZBOT_StartScan:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lis 4,.LC167@ha
	la 4,.LC167@l(4)
	bl stuffcmd
	lis 4,.LC168@ha
	mr 3,29
	la 4,.LC168@l(4)
	bl stuffcmd
	lwz 10,84(29)
	li 0,0
	lis 9,.LC238@ha
	la 9,.LC238@l(9)
	lis 11,level+4@ha
	stw 0,1828(10)
	lfs 12,0(9)
	lfs 0,level+4@l(11)
	lwz 10,84(29)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,1820(10)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe37:
	.size	 ZBOT_StartScan,.Lfe37-ZBOT_StartScan
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
	bc 4,1,.L527
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L526
.L527:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L526:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 PM_trace,.Lfe38-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L531
.L533:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L533
.L531:
	mr 3,11
	blr
.Lfe39:
	.size	 CheckBlock,.Lfe39-CheckBlock
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
.L742:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L742
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L741:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L741
	lis 3,.LC196@ha
	la 3,.LC196@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 PrintPmove,.Lfe40-PrintPmove
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
.Lfe41:
	.size	 SP_CreateCoopSpots,.Lfe41-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
