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
	.string	"rode the green pole"
	.align 2
.LC33:
	.string	"picked up the wrong pack"
	.align 2
.LC34:
	.string	"was in the wrong place"
	.align 2
.LC35:
	.string	"tried to put the pin back in"
	.align 2
.LC36:
	.string	"tripped on its own grenade"
	.align 2
.LC37:
	.string	"tripped on her own grenade"
	.align 2
.LC38:
	.string	"tripped on his own grenade"
	.align 2
.LC39:
	.string	"blew itself up"
	.align 2
.LC40:
	.string	"blew herself up"
	.align 2
.LC41:
	.string	"blew himself up"
	.align 2
.LC42:
	.string	"picked up the their own wrong pack"
	.align 2
.LC43:
	.string	"should have used a smaller gun"
	.align 2
.LC44:
	.string	"killed itself"
	.align 2
.LC45:
	.string	"killed herself"
	.align 2
.LC46:
	.string	"killed himself"
	.align 2
.LC47:
	.string	"%s %s.\n"
	.align 2
.LC48:
	.string	"had their head cut off by"
	.align 2
.LC49:
	.string	"was sliced by"
	.align 2
.LC50:
	.string	"had their brain shotgunned by"
	.align 2
.LC51:
	.string	"was gunned down by"
	.align 2
.LC52:
	.string	"put both barrels of"
	.align 2
.LC53:
	.string	"'s shotgun in their mouth"
	.align 2
.LC54:
	.string	"was blown away by"
	.align 2
.LC55:
	.string	"'s super shotgun"
	.align 2
.LC56:
	.string	"got a hot lead facial from"
	.align 2
.LC57:
	.string	"was machinegunned by"
	.align 2
.LC58:
	.string	"replaced their brain with"
	.align 2
.LC59:
	.string	"'s bullets"
	.align 2
.LC60:
	.string	"was cut in half by"
	.align 2
.LC61:
	.string	"'s chaingun"
	.align 2
.LC62:
	.string	"had their face ripped off by"
	.align 2
.LC63:
	.string	"was popped by"
	.align 2
.LC64:
	.string	"'s grenade"
	.align 2
.LC65:
	.string	"was shredded by"
	.align 2
.LC66:
	.string	"'s shrapnel"
	.align 2
.LC67:
	.string	"had thier head removed by"
	.align 2
.LC68:
	.string	"ate"
	.align 2
.LC69:
	.string	"'s rocket"
	.align 2
.LC70:
	.string	"almost dodged"
	.align 2
.LC71:
	.string	"has their brains melted by"
	.align 2
.LC72:
	.string	"was melted by"
	.align 2
.LC73:
	.string	"'s hyperblaster"
	.align 2
.LC74:
	.string	"has a slug sized hole in their head, thanks to"
	.align 2
.LC75:
	.string	"was railed by"
	.align 2
.LC76:
	.string	"had their skull cracked open by"
	.align 2
.LC77:
	.string	"saw the pretty lights from"
	.align 2
.LC78:
	.string	"'s BFG"
	.align 2
.LC79:
	.string	"was disintegrated by"
	.align 2
.LC80:
	.string	"'s BFG blast"
	.align 2
.LC81:
	.string	"couldn't hide from"
	.align 2
.LC82:
	.string	"caught"
	.align 2
.LC83:
	.string	"'s handgrenade"
	.align 2
.LC84:
	.string	"didn't see"
	.align 2
.LC85:
	.string	"feels"
	.align 2
.LC86:
	.string	"'s pain"
	.align 2
.LC87:
	.string	"tried to invade"
	.align 2
.LC88:
	.string	"'s personal space"
	.align 2
.LC89:
	.string	"was traced down by"
	.align 2
.LC90:
	.string	"%s %s %s%s\n"
	.align 2
.LC91:
	.string	"%s died.\n"
	.align 2
.LC92:
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
	lis 8,.LC92@ha
	lwz 11,coop@l(9)
	la 8,.LC92@l(8)
	mr 31,3
	lfs 13,0(8)
	mr 28,5
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L36
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L36:
	lis 11,.LC92@ha
	lis 9,deathmatch@ha
	la 11,.LC92@l(11)
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
	lwz 30,968(31)
	lwz 0,meansOfDeath@l(9)
	la 29,.LC22@l(11)
	li 6,0
	rlwinm 27,0,0,5,3
	rlwinm 26,0,0,4,4
	addi 10,27,-17
	cmplwi 0,10,18
	bc 12,1,.L39
	lis 11,.L55@ha
	slwi 10,10,2
	la 11,.L55@l(11)
	lis 9,.L55@ha
	lwzx 0,10,11
	la 9,.L55@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L55:
	.long .L43-.L55
	.long .L44-.L55
	.long .L45-.L55
	.long .L42-.L55
	.long .L39-.L55
	.long .L41-.L55
	.long .L40-.L55
	.long .L39-.L55
	.long .L47-.L55
	.long .L47-.L55
	.long .L54-.L55
	.long .L48-.L55
	.long .L54-.L55
	.long .L49-.L55
	.long .L54-.L55
	.long .L39-.L55
	.long .L50-.L55
	.long .L39-.L55
	.long .L51-.L55
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
.L51:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
	b .L39
.L54:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
.L39:
	cmpw 0,28,31
	bc 4,2,.L57
	addi 10,27,-7
	cmplwi 0,10,28
	bc 12,1,.L85
	lis 11,.L96@ha
	slwi 10,10,2
	la 11,.L96@l(11)
	lis 9,.L96@ha
	lwzx 0,10,11
	la 9,.L96@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L96:
	.long .L61-.L96
	.long .L85-.L96
	.long .L72-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L84-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L61-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L59-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L85-.L96
	.long .L83-.L96
.L59:
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L57
.L61:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L63
	li 10,0
	b .L64
.L63:
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
	bc 12,2,.L64
	cmpwi 0,11,109
	bc 12,2,.L64
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L64:
	cmpwi 0,10,0
	bc 12,2,.L62
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L57
.L62:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L68
	li 0,0
	b .L69
.L68:
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
.L69:
	cmpwi 0,0,0
	bc 12,2,.L67
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L57
.L67:
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L57
.L72:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L74
	li 10,0
	b .L75
.L74:
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
	bc 12,2,.L75
	cmpwi 0,11,109
	bc 12,2,.L75
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L75:
	cmpwi 0,10,0
	bc 12,2,.L73
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L57
.L73:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L79
	li 0,0
	b .L80
.L79:
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
.L80:
	cmpwi 0,0,0
	bc 12,2,.L78
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L57
.L78:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
	b .L57
.L83:
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
	b .L57
.L84:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L57
.L85:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L87
	li 10,0
	b .L88
.L87:
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
	bc 12,2,.L88
	cmpwi 0,11,109
	bc 12,2,.L88
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L88:
	cmpwi 0,10,0
	bc 12,2,.L86
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L57
.L86:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L92
	li 0,0
	b .L93
.L92:
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
.L93:
	cmpwi 0,0,0
	bc 12,2,.L91
	lis 9,.LC45@ha
	la 6,.LC45@l(9)
	b .L57
.L91:
	lis 9,.LC46@ha
	la 6,.LC46@l(9)
.L57:
	cmpwi 0,6,0
	bc 12,2,.L97
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC47@ha
	lwz 0,gi@l(9)
	la 4,.LC47@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC92@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC92@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L98
	mr 3,31
	li 4,0
	li 5,0
	bl KOTSScoring
.L98:
	li 0,0
	stw 0,540(31)
	b .L35
.L97:
	cmpwi 0,28,0
	stw 28,540(31)
	bc 12,2,.L37
	lwz 0,84(28)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L37
	addi 0,27,-1
	cmplwi 0,0,35
	bc 12,1,.L100
	lis 11,.L140@ha
	slwi 10,0,2
	la 11,.L140@l(11)
	lis 9,.L140@ha
	lwzx 0,10,11
	la 9,.L140@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L140:
	.long .L101-.L140
	.long .L104-.L140
	.long .L107-.L140
	.long .L110-.L140
	.long .L113-.L140
	.long .L116-.L140
	.long .L119-.L140
	.long .L120-.L140
	.long .L123-.L140
	.long .L124-.L140
	.long .L127-.L140
	.long .L130-.L140
	.long .L133-.L140
	.long .L134-.L140
	.long .L135-.L140
	.long .L136-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L138-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L137-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L100-.L140
	.long .L139-.L140
.L101:
	cmpwi 0,30,35
	bc 4,2,.L102
	lis 9,.LC48@ha
	la 6,.LC48@l(9)
	b .L100
.L102:
	lis 9,.LC49@ha
	la 6,.LC49@l(9)
	b .L100
.L104:
	cmpwi 0,30,35
	bc 4,2,.L105
	lis 9,.LC50@ha
	la 6,.LC50@l(9)
	b .L100
.L105:
	lis 9,.LC51@ha
	la 6,.LC51@l(9)
	b .L100
.L107:
	cmpwi 0,30,35
	bc 4,2,.L108
	lis 9,.LC52@ha
	lis 11,.LC53@ha
	la 6,.LC52@l(9)
	la 29,.LC53@l(11)
	b .L100
.L108:
	lis 9,.LC54@ha
	lis 11,.LC55@ha
	la 6,.LC54@l(9)
	la 29,.LC55@l(11)
	b .L100
.L110:
	cmpwi 0,30,35
	bc 4,2,.L111
	lis 9,.LC56@ha
	la 6,.LC56@l(9)
	b .L100
.L111:
	lis 9,.LC57@ha
	la 6,.LC57@l(9)
	b .L100
.L113:
	cmpwi 0,30,35
	bc 4,2,.L114
	lis 9,.LC58@ha
	lis 11,.LC59@ha
	la 6,.LC58@l(9)
	la 29,.LC59@l(11)
	b .L100
.L114:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 29,.LC61@l(11)
	b .L100
.L116:
	cmpwi 0,30,35
	bc 4,2,.L117
	lis 9,.LC62@ha
	la 6,.LC62@l(9)
	b .L118
.L117:
	lis 9,.LC63@ha
	la 6,.LC63@l(9)
.L118:
	lis 9,.LC64@ha
	la 29,.LC64@l(9)
	b .L100
.L119:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 6,.LC65@l(9)
	la 29,.LC66@l(11)
	b .L100
.L120:
	cmpwi 0,30,35
	bc 4,2,.L121
	lis 9,.LC67@ha
	la 6,.LC67@l(9)
	b .L122
.L121:
	lis 9,.LC68@ha
	la 6,.LC68@l(9)
.L122:
	lis 9,.LC69@ha
	la 29,.LC69@l(9)
	b .L100
.L123:
	lis 9,.LC70@ha
	lis 11,.LC69@ha
	la 6,.LC70@l(9)
	la 29,.LC69@l(11)
	b .L100
.L124:
	cmpwi 0,30,35
	bc 4,2,.L125
	lis 9,.LC71@ha
	la 6,.LC71@l(9)
	b .L126
.L125:
	lis 9,.LC72@ha
	la 6,.LC72@l(9)
.L126:
	lis 9,.LC73@ha
	la 29,.LC73@l(9)
	b .L100
.L127:
	cmpwi 0,30,35
	bc 4,2,.L128
	lis 9,.LC74@ha
	la 6,.LC74@l(9)
	b .L100
.L128:
	lis 9,.LC75@ha
	la 6,.LC75@l(9)
	b .L100
.L130:
	cmpwi 0,30,35
	bc 4,2,.L131
	lis 9,.LC76@ha
	la 6,.LC76@l(9)
	b .L132
.L131:
	lis 9,.LC77@ha
	la 6,.LC77@l(9)
.L132:
	lis 9,.LC78@ha
	la 29,.LC78@l(9)
	b .L100
.L133:
	lis 9,.LC79@ha
	lis 11,.LC80@ha
	la 6,.LC79@l(9)
	la 29,.LC80@l(11)
	b .L100
.L134:
	lis 9,.LC81@ha
	lis 11,.LC78@ha
	la 6,.LC81@l(9)
	la 29,.LC78@l(11)
	b .L100
.L135:
	lis 9,.LC82@ha
	lis 11,.LC83@ha
	la 6,.LC82@l(9)
	la 29,.LC83@l(11)
	b .L100
.L136:
	lis 9,.LC84@ha
	lis 11,.LC83@ha
	la 6,.LC84@l(9)
	la 29,.LC83@l(11)
	b .L100
.L137:
	lis 9,.LC85@ha
	lis 11,.LC86@ha
	la 6,.LC85@l(9)
	la 29,.LC86@l(11)
	b .L100
.L138:
	lis 9,.LC87@ha
	lis 11,.LC88@ha
	la 6,.LC87@l(9)
	la 29,.LC88@l(11)
	b .L100
.L139:
	lis 9,.LC89@ha
	la 6,.LC89@l(9)
.L100:
	cmpwi 0,6,0
	bc 12,2,.L37
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC90@ha
	lwz 0,gi@l(9)
	mr 8,29
	la 4,.LC90@l(4)
	addi 5,5,700
	addi 7,7,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC92@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC92@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	cmpwi 0,26,0
	bc 12,2,.L144
	mr 3,28
	li 4,0
	li 5,0
	bl KOTSScoring
	b .L35
.L144:
	mr 3,31
	mr 4,28
	li 5,1
	bl KOTSScoring
	b .L35
.L37:
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC91@ha
	lwz 0,gi@l(9)
	la 4,.LC91@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC92@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC92@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	mr 3,31
	li 4,0
	li 5,0
	bl KOTSScoring
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
.LC93:
	.string	"Blaster"
	.align 2
.LC94:
	.string	"item_quad"
	.align 2
.LC96:
	.string	"Damage Amp"
	.align 2
.LC97:
	.string	"kots_damage_item"
	.align 2
.LC98:
	.string	"boomerang"
	.align 2
.LC99:
	.string	"kots_boomerang"
	.align 2
.LC100:
	.string	"resist"
	.align 2
.LC101:
	.string	"kots_resist_item"
	.align 3
.LC95:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC102:
	.long 0x0
	.align 3
.LC103:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC104:
	.long 0x41b40000
	.section	".text"
	.align 2
	.globl TossClientWeapon
	.type	 TossClientWeapon,@function
TossClientWeapon:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 9,deathmatch@ha
	lis 10,.LC102@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC102@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L147
	lwz 9,84(31)
	lwz 11,3636(9)
	addi 10,9,740
	lwz 7,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 7,7,0
	bc 12,2,.L150
	lis 4,.LC93@ha
	lwz 3,40(7)
	la 4,.LC93@l(4)
	bl strcmp
.L150:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	li 7,0
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,16384
	bc 4,2,.L151
	li 30,0
	b .L152
.L151:
	lis 10,level@ha
	lwz 8,84(31)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC103@ha
	lfs 12,3832(8)
	addi 9,9,10
	la 10,.LC103@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,28(1)
	stw 0,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 30
	rlwinm 30,30,30,1
.L152:
	addic 11,7,-1
	subfe 0,11,7
	lis 9,.LC102@ha
	and. 10,0,30
	la 9,.LC102@l(9)
	lfs 31,0(9)
	bc 12,2,.L153
	lis 11,.LC104@ha
	la 11,.LC104@l(11)
	lfs 31,0(11)
.L153:
	cmpwi 0,7,0
	bc 12,2,.L155
	lwz 9,84(31)
	mr 3,31
	li 4,0
	lfs 0,3764(9)
	fsubs 0,0,31
	stfs 0,3764(9)
	bl Drop_Item
	lwz 9,84(31)
	lis 0,0x2
	lfs 0,3764(9)
	fadds 0,0,31
	stfs 0,3764(9)
	stw 0,284(3)
.L155:
	cmpwi 0,30,0
	bc 12,2,.L156
	lwz 9,84(31)
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	lfs 0,3764(9)
	fadds 0,0,31
	stfs 0,3764(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	lwz 7,84(31)
	lis 9,.LC103@ha
	lis 11,Touch_Item@ha
	la 9,.LC103@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3764(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC95@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC95@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3764(7)
	lwz 0,284(3)
	stw 11,444(3)
	oris 0,0,0x2
	stw 0,284(3)
	lwz 9,level@l(6)
	lwz 11,84(31)
	xoris 9,9,0x8000
	lfs 12,4(5)
	stw 9,28(1)
	stw 4,24(1)
	lfd 13,24(1)
	lfs 0,3832(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L156:
	lis 27,.LC96@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC96@l(27)
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
	bc 12,2,.L157
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC96@l(27)
	bl FindItem
	subf 3,28,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L157:
	lis 27,.LC98@ha
	lwz 29,84(31)
	la 3,.LC98@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L158
	lis 3,.LC99@ha
	la 3,.LC99@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC98@l(27)
	bl FindItem
	subf 3,28,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L158:
	lis 27,.LC100@ha
	lwz 29,84(31)
	la 3,.LC100@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L147
	lis 3,.LC101@ha
	la 3,.LC101@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC100@l(27)
	bl FindItem
	subf 3,28,3
	lwz 11,84(31)
	mullw 3,3,30
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L147:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 3
.LC105:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC106:
	.long 0x0
	.align 2
.LC107:
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
	bc 12,2,.L161
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L161
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L171
.L161:
	cmpwi 0,4,0
	bc 12,2,.L163
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L163
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L171:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L162
.L163:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3688(9)
	b .L160
.L162:
	lis 9,.LC106@ha
	lfs 2,8(1)
	la 9,.LC106@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L165
	lfs 1,12(1)
	bl atan2
	lis 9,.LC105@ha
	lwz 11,84(31)
	lfd 0,.LC105@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3688(11)
	b .L166
.L165:
	lwz 9,84(31)
	stfs 13,3688(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L167
	lwz 9,84(31)
	lis 0,0x42b4
	b .L172
.L167:
	bc 4,0,.L166
	lwz 9,84(31)
	lis 0,0xc2b4
.L172:
	stw 0,3688(9)
.L166:
	lwz 3,84(31)
	lis 9,.LC106@ha
	la 9,.LC106@l(9)
	lfs 0,0(9)
	lfs 13,3688(3)
	fcmpu 0,13,0
	bc 4,0,.L160
	lis 11,.LC107@ha
	la 11,.LC107@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3688(3)
.L160:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 LookAtKiller,.Lfe4-LookAtKiller
	.section	".rodata"
	.align 2
.LC108:
	.string	"misc/udeath.wav"
	.align 2
.LC109:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.42:
	.space	4
	.size	 i.42,4
	.section	".rodata"
	.align 2
.LC110:
	.string	"*death%i.wav"
	.align 2
.LC111:
	.long 0x0
	.align 3
.LC112:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC113:
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
	lis 9,.LC111@ha
	mr 31,3
	la 9,.LC111@l(9)
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
	stw 11,3860(10)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 8,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L174
	lis 9,level+4@ha
	lis 11,.LC112@ha
	lfs 0,level+4@l(9)
	la 11,.LC112@l(11)
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3916(11)
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
	bc 12,2,.L175
	mr 3,31
	bl Cmd_Help_f
.L175:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,30,0
	bc 4,0,.L174
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 5,10
	lwz 7,coop@l(11)
	addi 8,9,56
	li 6,0
	lis 9,.LC111@ha
	li 10,0
	la 9,.LC111@l(9)
	lfs 13,0(9)
.L179:
	lfs 0,20(7)
	fcmpu 0,0,13
	bc 12,2,.L180
	lwz 0,0(8)
	andi. 11,0,16
	bc 12,2,.L180
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2424
	stwx 0,9,10
.L180:
	lwz 9,84(31)
	addi 30,30,1
	addi 8,8,76
	addi 9,9,740
	stwx 6,9,10
	lwz 0,1556(5)
	addi 10,10,4
	cmpw 0,30,0
	bc 12,0,.L179
.L174:
	lwz 11,84(31)
	li 0,0
	stw 0,3832(11)
	lwz 9,84(31)
	stw 0,3836(9)
	lwz 11,84(31)
	stw 0,3840(11)
	lwz 9,84(31)
	stw 0,3844(9)
	lwz 11,480(31)
	lwz 0,264(31)
	cmpwi 0,11,-40
	rlwinm 0,0,0,20,18
	stw 0,264(31)
	bc 4,0,.L182
	lis 29,gi@ha
	lis 3,.LC108@ha
	la 29,gi@l(29)
	la 3,.LC108@l(3)
	lwz 9,36(29)
	lis 28,.LC109@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC113@ha
	lwz 0,16(29)
	lis 11,.LC113@ha
	la 9,.LC113@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC113@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC111@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC111@l(9)
	lfs 3,0(9)
	blrl
.L186:
	mr 3,31
	la 4,.LC109@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L186
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	li 0,0
	stw 0,512(31)
	b .L188
.L182:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L188
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
	stw 7,3820(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L190
	li 0,172
	li 9,177
	b .L199
.L190:
	cmpwi 0,10,1
	bc 12,2,.L194
	bc 12,1,.L198
	cmpwi 0,10,0
	bc 12,2,.L193
	b .L191
.L198:
	cmpwi 0,10,2
	bc 12,2,.L195
	b .L191
.L193:
	li 0,177
	li 9,183
	b .L199
.L194:
	li 0,183
	li 9,189
	b .L199
.L195:
	li 0,189
	li 9,197
.L199:
	stw 0,56(31)
	stw 9,3816(11)
.L191:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC110@ha
	srwi 0,0,30
	la 3,.LC110@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC113@ha
	lwz 0,16(29)
	lis 11,.LC113@ha
	la 9,.LC113@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC113@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC111@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC111@l(9)
	lfs 3,0(9)
	blrl
.L188:
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
.LC116:
	.string	"info_player_deathmatch"
	.align 2
.LC115:
	.long 0x47c34f80
	.align 2
.LC117:
	.long 0x4b18967f
	.align 2
.LC118:
	.long 0x3f800000
	.align 3
.LC119:
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
	lis 9,.LC115@ha
	li 28,0
	lfs 29,.LC115@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC116@ha
	b .L222
.L224:
	lis 10,.LC118@ha
	lis 9,maxclients@ha
	la 10,.LC118@l(10)
	lis 11,.LC117@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC117@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L232
	lis 11,.LC119@ha
	lis 26,g_edicts@ha
	la 11,.LC119@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,976
.L227:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L229
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L229
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
	bc 4,0,.L229
	fmr 31,1
.L229:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,976
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L227
.L232:
	fcmpu 0,31,28
	bc 4,0,.L234
	fmr 28,31
	mr 24,30
	b .L222
.L234:
	fcmpu 0,31,29
	bc 4,0,.L222
	fmr 29,31
	mr 23,30
.L222:
	lis 5,.LC116@ha
	mr 3,30
	la 5,.LC116@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L224
	cmpwi 0,28,0
	bc 4,2,.L238
	li 3,0
	b .L246
.L238:
	cmpwi 0,28,2
	bc 12,1,.L239
	li 23,0
	li 24,0
	b .L240
.L239:
	addi 28,28,-2
.L240:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L245:
	mr 3,30
	li 4,280
	la 5,.LC116@l(22)
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
	bc 4,2,.L245
.L246:
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
.LC120:
	.long 0x4b18967f
	.align 2
.LC121:
	.long 0x0
	.align 2
.LC122:
	.long 0x3f800000
	.align 3
.LC123:
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
	lis 9,.LC121@ha
	li 31,0
	la 9,.LC121@l(9)
	li 25,0
	lfs 29,0(9)
	b .L248
.L250:
	lis 9,maxclients@ha
	lis 11,.LC122@ha
	lwz 10,maxclients@l(9)
	la 11,.LC122@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC120@ha
	lfs 31,.LC120@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L258
	lis 9,.LC123@ha
	lis 27,g_edicts@ha
	la 9,.LC123@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,976
.L253:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L255
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L255
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
	bc 4,0,.L255
	fmr 31,1
.L255:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,976
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L253
.L258:
	fcmpu 0,31,29
	bc 4,1,.L248
	fmr 29,31
	mr 25,31
.L248:
	lis 30,.LC116@ha
	mr 3,31
	li 4,280
	la 5,.LC116@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L250
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L263
	la 5,.LC116@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L263:
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
.LC124:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC125:
	.long 0x0
	.align 2
.LC126:
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
	lis 11,.LC125@ha
	lis 9,deathmatch@ha
	la 11,.LC125@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 30,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L278
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L279
	bl SelectFarthestDeathmatchSpawnPoint
	mr 30,3
	b .L282
.L279:
	bl SelectRandomDeathmatchSpawnPoint
	mr 30,3
	b .L282
.L306:
	li 30,0
	b .L282
.L278:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L282
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xcfb1
	lwz 10,game+1028@l(11)
	ori 9,9,30751
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L282
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 30,game+1032@ha
.L288:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L306
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
	bc 4,2,.L288
	addic. 31,31,-1
	bc 4,2,.L288
	mr 30,29
.L282:
	cmpwi 0,30,0
	bc 4,2,.L294
	lis 29,.LC0@ha
	lis 31,game@ha
.L301:
	mr 3,30
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 30,3
	bc 12,2,.L307
	la 3,game@l(31)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L305
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L296
	b .L301
.L305:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 12,2,.L301
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L301
.L296:
	cmpwi 0,30,0
	bc 4,2,.L294
.L307:
	lis 9,game@ha
	la 31,game@l(9)
	lbz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L303
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L303:
	cmpwi 0,30,0
	bc 4,2,.L294
	lis 9,gi+28@ha
	lis 3,.LC124@ha
	lwz 0,gi+28@l(9)
	la 3,.LC124@l(3)
	addi 4,31,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L294:
	lfs 0,4(30)
	lis 9,.LC126@ha
	la 9,.LC126@l(9)
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
.LC127:
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
	mulli 27,27,976
	addi 27,27,976
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
	lis 9,0xc10c
	lis 11,body_die@ha
	ori 9,9,38677
	la 11,body_die@l(11)
	subf 0,0,29
	li 10,1
	mullw 0,0,9
	mr 3,29
	srawi 0,0,4
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
.LC128:
	.string	"menu_loadgame\n"
	.align 2
.LC129:
	.string	"spectator"
	.align 2
.LC130:
	.string	"none"
	.align 2
.LC131:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC132:
	.string	"spectator 0\n"
	.align 2
.LC133:
	.string	"Server spectator limit is full."
	.align 2
.LC134:
	.string	"password"
	.align 2
.LC135:
	.string	"Password incorrect.\n"
	.align 2
.LC136:
	.string	"spectator 1\n"
	.align 2
.LC137:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC138:
	.string	"%s joined the game\n"
	.align 2
.LC139:
	.long 0x3f800000
	.align 3
.LC140:
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
	lwz 0,1868(3)
	cmpwi 0,0,0
	bc 12,2,.L327
	lis 4,.LC129@ha
	addi 3,3,188
	la 4,.LC129@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L328
	lis 4,.LC130@ha
	la 4,.LC130@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L328
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L328
	lis 29,gi@ha
	lis 5,.LC131@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC131@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	li 3,11
	stw 0,1868(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC132@ha
	la 3,.LC132@l(3)
	b .L341
.L328:
	lis 9,maxclients@ha
	lis 10,.LC139@ha
	lwz 11,maxclients@l(9)
	la 10,.LC139@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L330
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC140@ha
	la 9,.LC140@l(9)
	addi 10,11,976
	lfd 13,0(9)
.L332:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L331
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1868(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L331:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,976
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L332
.L330:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC140@ha
	la 10,.LC140@l(10)
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
	bc 4,3,.L336
	lis 29,gi@ha
	lis 5,.LC133@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC133@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	li 3,11
	stw 0,1868(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC132@ha
	la 3,.LC132@l(3)
	b .L341
.L327:
	lis 4,.LC134@ha
	addi 3,3,188
	la 4,.LC134@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lis 28,gi@ha
	lwz 9,password@l(29)
	mr 30,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L336
	lis 4,.LC130@ha
	la 4,.LC130@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L336
	lwz 9,password@l(29)
	mr 4,30
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L336
	la 29,gi@l(28)
	lis 5,.LC135@ha
	lwz 9,8(29)
	li 4,2
	la 5,.LC135@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	li 3,11
	stw 0,1868(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC136@ha
	la 3,.LC136@l(3)
.L341:
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L326
.L336:
	lwz 11,84(31)
	li 9,0
	mr 3,31
	stw 9,3560(11)
	stw 9,1800(11)
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,84(31)
	lwz 0,1868(9)
	cmpwi 0,0,0
	bc 4,2,.L338
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,38677
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,4
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
.L338:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3916(11)
	lwz 3,84(31)
	lwz 0,1868(3)
	cmpwi 0,0,0
	bc 12,2,.L339
	lis 9,gi@ha
	lis 4,.LC137@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC137@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L326
.L339:
	lis 9,gi@ha
	lis 4,.LC138@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC138@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L326:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 spectator_respawn,.Lfe10-spectator_respawn
	.section	".rodata"
	.align 2
.LC141:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC142:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC143:
	.string	"player"
	.align 2
.LC144:
	.string	"players/male/tris.md2"
	.align 2
.LC145:
	.string	"fov"
	.align 2
.LC146:
	.long 0x0
	.align 2
.LC147:
	.long 0x41400000
	.align 2
.LC148:
	.long 0x41000000
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
	.align 2
.LC152:
	.long 0x47800000
	.align 2
.LC153:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4576(1)
	mflr 0
	stfd 31,4568(1)
	stmw 22,4528(1)
	stw 0,4580(1)
	lis 9,.LC141@ha
	lis 8,.LC142@ha
	lwz 0,.LC141@l(9)
	addi 10,1,8
	la 29,.LC142@l(8)
	la 9,.LC141@l(9)
	lwz 11,.LC142@l(8)
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
	lis 9,.LC146@ha
	lis 11,g_edicts@ha
	lwz 30,84(31)
	la 9,.LC146@l(9)
	lis 0,0xc10c
	lfs 13,0(9)
	ori 0,0,38677
	lis 9,deathmatch@ha
	lwz 10,deathmatch@l(9)
	lwz 9,g_edicts@l(11)
	lfs 0,20(10)
	subf 9,9,31
	mullw 9,9,0
	fcmpu 0,0,13
	srawi 9,9,4
	addi 24,9,-1
	bc 12,2,.L343
	addi 28,1,1768
	addi 27,30,1872
	mr 4,27
	li 5,1720
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 23,28
	mr 25,29
	addi 26,1,3496
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,1684
	lwz 28,1812(30)
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 3,.LC93@ha
	stw 28,1812(30)
	la 3,.LC93@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 5,3
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,5
	mullw 9,9,0
	li 6,1
	addi 8,30,740
	li 11,100
	li 10,50
	srawi 9,9,2
	li 7,200
	slwi 0,9,2
	stw 9,736(30)
	mr 4,26
	stwx 6,8,0
	mr 3,31
	stw 5,1788(30)
	stw 11,1768(30)
	stw 7,1780(30)
	stw 10,1784(30)
	stw 6,720(30)
	stw 11,724(30)
	stw 11,728(30)
	stw 7,1764(30)
	stw 10,1772(30)
	stw 10,1776(30)
	bl ClientUserinfoChanged
	b .L345
.L343:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L346
	addi 28,1,1768
	addi 27,30,1872
	mr 4,27
	li 5,1720
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 23,28
	mr 25,29
	addi 26,1,4008
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	lwz 9,1804(30)
	mr 4,28
	li 5,1684
	mr 3,29
	stw 9,3384(1)
	lwz 0,1808(30)
	stw 0,3388(1)
	crxor 6,6,6
	bl memcpy
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3456(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L345
	stw 9,1800(30)
	b .L345
.L346:
	addi 29,1,1768
	li 4,0
	mr 3,29
	li 5,1720
	crxor 6,6,6
	bl memset
	mr 23,29
	addi 27,30,1872
	addi 25,30,188
.L345:
	addi 29,1,72
	mr 4,25
	li 5,1684
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3964
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,25
	li 5,1684
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L349
	lwz 29,1812(30)
	li 4,0
	li 5,1684
	mr 3,25
	crxor 6,6,6
	bl memset
	lis 3,.LC93@ha
	stw 29,1812(30)
	la 3,.LC93@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	li 6,1
	mullw 9,9,0
	addi 8,30,740
	li 11,100
	li 10,50
	li 7,200
	srawi 9,9,2
	slwi 0,9,2
	stw 9,736(30)
	stwx 6,8,0
	stw 3,1788(30)
	stw 11,1768(30)
	stw 7,1780(30)
	stw 10,1784(30)
	stw 6,720(30)
	stw 11,724(30)
	stw 11,728(30)
	stw 7,1764(30)
	stw 10,1772(30)
	stw 10,1776(30)
.L349:
	lis 9,.LC146@ha
	mr 3,27
	la 9,.LC146@l(9)
	mr 4,23
	lfs 31,0(9)
	li 5,1720
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
	bc 12,2,.L352
	lwz 0,1800(7)
	stw 0,3560(7)
.L352:
	li 7,0
	lis 11,game+1028@ha
	mulli 8,24,3964
	lwz 6,264(31)
	stw 7,552(31)
	li 0,4
	lis 9,.LC143@ha
	lwz 3,game+1028@l(11)
	li 5,2
	la 9,.LC143@l(9)
	li 11,22
	stw 0,260(31)
	li 10,1
	stw 11,508(31)
	add 3,3,8
	li 0,200
	lis 11,.LC147@ha
	stw 10,88(31)
	lis 29,level+4@ha
	stw 9,280(31)
	la 11,.LC147@l(11)
	lis 10,0x201
	stw 0,400(31)
	lis 8,.LC144@ha
	lis 9,player_pain@ha
	stw 5,248(31)
	la 8,.LC144@l(8)
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
	lis 9,.LC148@ha
	lfs 0,40(1)
	la 9,.LC148@l(9)
	mr 10,11
	lfs 10,0(9)
	mr 8,11
	lis 9,deathmatch@ha
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4520(1)
	lwz 11,4524(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4520(1)
	lwz 10,4524(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4520(1)
	lwz 8,4524(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L353
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4520(1)
	lwz 11,4524(1)
	andi. 0,11,32768
	bc 4,2,.L369
.L353:
	lis 4,.LC145@ha
	mr 3,25
	la 4,.LC145@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4524(1)
	lis 0,0x4330
	lis 11,.LC149@ha
	la 11,.LC149@l(11)
	stw 0,4520(1)
	lfd 13,0(11)
	lfd 0,4520(1)
	lis 11,.LC150@ha
	la 11,.LC150@l(11)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L355
.L369:
	lis 0,0x42b4
	stw 0,112(30)
	b .L354
.L355:
	lis 9,.LC151@ha
	la 9,.LC151@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L354
	stfs 13,112(30)
.L354:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 11,.LC153@ha
	lis 9,.LC152@ha
	stw 3,88(30)
	la 11,.LC153@l(11)
	la 9,.LC152@l(9)
	lfs 13,48(1)
	lfs 10,0(11)
	lis 0,0xc10c
	li 10,255
	lis 11,g_edicts@ha
	lfs 9,0(9)
	ori 0,0,38677
	lwz 9,g_edicts@l(11)
	mr 5,22
	addi 6,30,3564
	lis 11,.LC150@ha
	lfs 11,40(1)
	addi 7,30,20
	la 11,.LC150@l(11)
	subf 9,9,31
	lfs 12,44(1)
	lfs 0,0(11)
	mullw 9,9,0
	li 8,0
	li 0,3
	li 11,0
	stw 10,44(31)
	mtctr 0
	srawi 9,9,4
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
.L368:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4520(1)
	lwz 9,4524(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L368
	lis 9,.LC146@ha
	lfs 0,60(1)
	la 9,.LC146@l(9)
	lfs 12,0(9)
	stfs 0,20(31)
	lis 9,kots_lives@ha
	lwz 11,kots_lives@l(9)
	stfs 12,24(31)
	stfs 12,16(31)
	stfs 12,28(30)
	lfs 13,20(31)
	stfs 13,32(30)
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,3760(30)
	lfs 0,20(31)
	stfs 0,3764(30)
	lfs 13,24(31)
	stfs 13,3768(30)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L363
	lwz 0,928(31)
	cmpwi 0,0,0
	bc 12,1,.L363
	li 0,0
	stw 0,3580(30)
.L363:
	lwz 0,3580(30)
	cmpwi 0,0,0
	bc 4,2,.L364
	li 0,1
	stw 0,1868(30)
.L364:
	lwz 0,1868(30)
	cmpwi 0,0,0
	bc 12,2,.L365
	li 9,0
	li 10,1
	stw 10,3576(30)
	lis 8,gi+72@ha
	mr 3,31
	stw 9,3920(30)
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
	mr 3,31
	bl KOTSOpenJoinMenu
	b .L342
.L365:
	stw 0,3576(30)
	mr 3,31
	bl KOTSInit
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1788(30)
	mr 3,31
	stw 0,3656(30)
	bl ChangeWeapon
	mr 3,31
	bl KOTSDeathSound
.L342:
	lwz 0,4580(1)
	mtlr 0
	lmw 22,4528(1)
	lfd 31,4568(1)
	la 1,4576(1)
	blr
.Lfe11:
	.size	 PutClientInServer,.Lfe11-PutClientInServer
	.section	".rodata"
	.align 2
.LC154:
	.long 0x40800000
	.align 2
.LC155:
	.long 0x0
	.align 2
.LC156:
	.long 0x47800000
	.align 2
.LC157:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	lis 11,level@ha
	lis 10,g_edicts@ha
	la 24,level@l(11)
	lwz 9,g_edicts@l(10)
	mr 31,3
	lis 11,.LC154@ha
	lfs 13,4(24)
	lis 30,0xc10c
	la 11,.LC154@l(11)
	subf 9,9,31
	lfs 0,0(11)
	ori 30,30,38677
	lis 8,game+1028@ha
	lis 11,.LC155@ha
	mullw 9,9,30
	lis 25,level@ha
	la 11,.LC155@l(11)
	lfs 31,0(11)
	fadds 13,13,0
	srawi 9,9,4
	lis 11,deathmatch@ha
	mulli 9,9,3964
	lwz 10,deathmatch@l(11)
	stfs 31,964(31)
	addi 9,9,-3964
	stfs 13,960(31)
	lwz 0,game+1028@l(8)
	add 0,0,9
	stw 0,84(31)
	lfs 0,20(10)
	fcmpu 0,0,31
	bc 12,2,.L375
	bl G_InitEdict
	lwz 29,84(31)
	li 4,0
	li 5,1720
	addi 28,29,1872
	lwz 27,3584(29)
	lwz 26,3580(29)
	mr 3,28
	crxor 6,6,6
	bl memset
	lwz 0,level@l(25)
	addi 4,29,188
	li 5,1684
	mr 3,28
	stw 0,3556(29)
	crxor 6,6,6
	bl memcpy
	stw 27,3584(29)
	mr 3,31
	stw 26,3580(29)
	bl PutClientInServer
	lfs 0,200(24)
	fcmpu 0,0,31
	bc 12,2,.L377
	mr 3,31
	bl MoveClientToIntermission
	b .L378
.L377:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lwz 3,g_edicts@l(9)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,30
	mtlr 9
	srawi 3,3,4
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
.L378:
	mr 3,31
	bl KOTSEnter
	mr 3,31
	bl ClientEndServerFrame
	b .L374
.L375:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L380
	lis 9,.LC156@ha
	lis 11,.LC157@ha
	li 0,3
	la 9,.LC156@l(9)
	la 11,.LC157@l(11)
	mtctr 0
	lfs 11,0(9)
	li 8,0
	lfs 12,0(11)
	li 7,0
.L391:
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
	bdnz .L391
	b .L386
.L380:
	mr 3,31
	bl G_InitEdict
	lwz 29,84(31)
	lis 9,.LC143@ha
	li 4,0
	la 9,.LC143@l(9)
	li 5,1720
	stw 9,280(31)
	addi 28,29,1872
	lwz 27,3584(29)
	mr 3,28
	lwz 26,3580(29)
	crxor 6,6,6
	bl memset
	lwz 0,level@l(25)
	mr 3,28
	addi 4,29,188
	li 5,1684
	stw 0,3556(29)
	crxor 6,6,6
	bl memcpy
	stw 27,3584(29)
	mr 3,31
	stw 26,3580(29)
	bl PutClientInServer
.L386:
	lis 11,.LC155@ha
	lis 9,level+200@ha
	la 11,.LC155@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L388
	mr 3,31
	bl MoveClientToIntermission
	b .L389
.L388:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L389
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,38677
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,4
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
	mr 3,31
	bl KOTSEnter
.L389:
	mr 3,31
	bl ClientEndServerFrame
.L374:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 ClientBegin,.Lfe12-ClientBegin
	.section	".rodata"
	.align 2
.LC158:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC159:
	.string	"name"
	.align 2
.LC160:
	.string	"skin"
	.align 2
.LC161:
	.string	"%s\\%s"
	.align 2
.LC162:
	.string	"hand"
	.align 2
.LC163:
	.long 0x0
	.align 3
.LC164:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC165:
	.long 0x3f800000
	.align 2
.LC166:
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
	bc 4,2,.L393
	lis 11,.LC158@ha
	lwz 0,.LC158@l(11)
	la 9,.LC158@l(11)
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
.L393:
	lis 29,.LC159@ha
	mr 3,30
	la 4,.LC159@l(29)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	addi 3,9,700
	bl strlen
	cmplwi 0,3,2
	bc 12,1,.L394
	lwz 3,84(27)
	mr 4,31
	li 5,15
	addi 3,3,700
	bl strncpy
.L394:
	lwz 5,84(27)
	la 4,.LC159@l(29)
	mr 3,30
	addi 5,5,700
	bl Info_SetValueForKey
	lis 4,.LC129@ha
	mr 3,30
	la 4,.LC129@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	lwz 0,3580(9)
	cmpwi 0,0,0
	li 0,0
	bc 4,2,.L395
	li 0,1
.L395:
	stw 0,1868(9)
	lis 4,.LC160@ha
	mr 3,30
	la 4,.LC160@l(4)
	bl Info_ValueForKey
	lis 9,kots_teamplay@ha
	lis 11,g_edicts@ha
	lwz 10,kots_teamplay@l(9)
	mr 31,3
	lis 9,.LC163@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC163@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,27
	lis 9,0xc10c
	ori 9,9,38677
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,4
	bc 12,2,.L397
	mr 3,27
	bl KOTSAssignSkin
	b .L398
.L397:
	lwz 4,84(27)
	lis 29,gi@ha
	lis 3,.LC161@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC161@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L398:
	lis 9,.LC163@ha
	lis 11,deathmatch@ha
	la 9,.LC163@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L399
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L399
	lwz 9,84(27)
	b .L406
.L399:
	lis 4,.LC145@ha
	mr 3,30
	la 4,.LC145@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC164@ha
	la 10,.LC164@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC165@ha
	la 10,.LC165@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L401
.L406:
	lis 0,0x42b4
	stw 0,112(9)
	b .L400
.L401:
	lis 11,.LC166@ha
	la 11,.LC166@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L400
	stfs 13,112(9)
.L400:
	lis 4,.LC162@ha
	mr 3,30
	la 4,.LC162@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L404
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L404:
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
.Lfe13:
	.size	 ClientUserinfoChanged,.Lfe13-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC167:
	.string	"ip"
	.align 2
.LC168:
	.string	"rejmsg"
	.align 2
.LC169:
	.string	"Banned."
	.align 2
.LC170:
	.string	"0"
	.align 2
.LC171:
	.string	"Spectator password required or incorrect."
	.align 2
.LC172:
	.string	"Password required or incorrect."
	.align 2
.LC173:
	.string	"%s connected\n"
	.align 2
.LC174:
	.long 0x0
	.align 3
.LC175:
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
	mr 30,4
	mr 31,3
	lis 4,.LC167@ha
	mr 3,30
	la 4,.LC167@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L408
	lis 4,.LC168@ha
	lis 5,.LC169@ha
	mr 3,30
	la 4,.LC168@l(4)
	la 5,.LC169@l(5)
	b .L428
.L408:
	mr 3,31
	mr 4,30
	bl KOTSGetClientData
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L427
	lis 4,.LC129@ha
	mr 3,30
	la 4,.LC129@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC174@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC174@l(10)
	mr 29,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L410
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L410
	lis 4,.LC170@ha
	la 4,.LC170@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L410
	lis 28,spectator_password@ha
	lwz 9,spectator_password@l(28)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L411
	lis 4,.LC130@ha
	la 4,.LC130@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L411
	lwz 9,spectator_password@l(28)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L411
	lis 4,.LC168@ha
	lis 5,.LC171@ha
	mr 3,30
	la 4,.LC168@l(4)
	la 5,.LC171@l(5)
	b .L428
.L411:
	lis 9,maxclients@ha
	lis 10,.LC174@ha
	lwz 11,maxclients@l(9)
	la 10,.LC174@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L413
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC175@ha
	la 9,.LC175@l(9)
	addi 10,11,976
	lfd 13,0(9)
.L415:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L414
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1868(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L414:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,976
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L415
.L413:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,28(1)
	lis 10,.LC175@ha
	la 10,.LC175@l(10)
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
	bc 4,3,.L419
	lis 4,.LC168@ha
	lis 5,.LC133@ha
	mr 3,30
	la 4,.LC168@l(4)
	la 5,.LC133@l(5)
	b .L428
.L410:
	lis 4,.LC134@ha
	mr 3,30
	la 4,.LC134@l(4)
	lis 28,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(28)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L419
	lis 4,.LC130@ha
	la 4,.LC130@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L419
	lwz 9,password@l(28)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L419
	lis 4,.LC168@ha
	lis 5,.LC172@ha
	mr 3,30
	la 4,.LC168@l(4)
	la 5,.LC172@l(5)
.L428:
	bl Info_SetValueForKey
	li 3,0
	b .L427
.L419:
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 10,88(31)
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	lis 11,game@ha
	cmpwi 0,10,0
	subf 9,9,31
	la 25,game@l(11)
	mullw 9,9,0
	lwz 11,1028(25)
	srawi 9,9,4
	mulli 9,9,3964
	addi 9,9,-3964
	add 11,11,9
	stw 11,84(31)
	bc 4,2,.L421
	stw 10,3580(11)
	li 4,0
	li 5,1720
	lwz 29,84(31)
	addi 28,29,1872
	lwz 27,3584(29)
	lwz 26,3580(29)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1684
	stw 0,3556(29)
	crxor 6,6,6
	bl memcpy
	stw 27,3584(29)
	stw 26,3580(29)
	lwz 0,1560(25)
	cmpwi 0,0,0
	bc 12,2,.L424
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L421
.L424:
	lwz 29,84(31)
	li 4,0
	li 5,1684
	lwz 28,1812(29)
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 3,.LC93@ha
	stw 28,1812(29)
	la 3,.LC93@l(3)
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
	stw 0,724(29)
	stw 0,728(29)
	stw 6,1764(29)
	stw 10,1772(29)
	stw 10,1776(29)
.L421:
	mr 4,30
	mr 3,31
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L426
	lis 9,gi+4@ha
	lwz 4,84(31)
	lis 3,.LC173@ha
	lwz 0,gi+4@l(9)
	la 3,.LC173@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L426:
	lwz 9,84(31)
	li 0,0
	li 11,1
	stw 0,184(31)
	li 3,1
	stw 11,720(9)
.L427:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 ClientConnect,.Lfe14-ClientConnect
	.section	".rodata"
	.align 2
.LC176:
	.string	"%s disconnected\n"
	.align 2
.LC177:
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
	lwz 29,84(31)
	cmpwi 0,29,0
	bc 12,2,.L429
	lis 30,.LC96@ha
	lis 28,0x286b
	la 3,.LC96@l(30)
	ori 28,28,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 11,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,28
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,2,.L431
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC96@l(30)
	bl FindItem
	subf 3,27,3
	lwz 11,84(31)
	mullw 3,3,28
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L431:
	lis 30,.LC98@ha
	lwz 29,84(31)
	la 3,.LC98@l(30)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,28
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L432
	lis 3,.LC99@ha
	la 3,.LC99@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC98@l(30)
	bl FindItem
	subf 3,27,3
	lwz 11,84(31)
	mullw 3,3,28
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L432:
	lis 30,.LC100@ha
	lwz 29,84(31)
	la 3,.LC100@l(30)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,28
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L433
	lis 3,.LC101@ha
	la 3,.LC101@l(3)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	la 3,.LC100@l(30)
	bl FindItem
	subf 3,27,3
	lwz 11,84(31)
	mullw 3,3,28
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-1
	stwx 9,11,3
.L433:
	lis 29,gi@ha
	lwz 5,84(31)
	lis 4,.LC176@ha
	lwz 9,gi@l(29)
	la 4,.LC176@l(4)
	li 3,2
	addi 5,5,700
	la 29,gi@l(29)
	mtlr 9
	lis 27,g_edicts@ha
	lis 28,0xc10c
	ori 28,28,38677
	crxor 6,6,6
	blrl
	mr 3,31
	bl KOTSLeave
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 3,g_edicts@l(27)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,28
	mtlr 9
	srawi 3,3,4
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
	lis 9,.LC177@ha
	li 0,0
	la 9,.LC177@l(9)
	lwz 11,84(31)
	lis 4,.LC22@ha
	stw 9,280(31)
	subf 3,3,31
	la 4,.LC22@l(4)
	stw 0,40(31)
	mullw 3,3,28
	stw 0,248(31)
	stw 0,88(31)
	srawi 3,3,4
	stw 0,720(11)
	addi 3,3,1311
	lwz 0,24(29)
	mtlr 0
	blrl
.L429:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 ClientDisconnect,.Lfe15-ClientDisconnect
	.section	".rodata"
	.align 2
.LC178:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC180:
	.string	"*jump1.wav"
	.align 2
.LC181:
	.string	"grenade"
	.align 3
.LC179:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC182:
	.long 0x0
	.align 3
.LC183:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC184:
	.long 0x401c0000
	.long 0x0
	.align 3
.LC185:
	.long 0x40240000
	.long 0x0
	.align 3
.LC186:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC187:
	.long 0x41000000
	.align 3
.LC188:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC189:
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
	lis 10,.LC182@ha
	la 31,level@l(9)
	la 10,.LC182@l(10)
	lfs 31,0(10)
	mr 27,3
	mr 25,4
	lfs 0,200(31)
	stw 27,292(31)
	lwz 28,84(27)
	fcmpu 0,0,31
	bc 12,2,.L458
	li 0,4
	lis 11,.LC183@ha
	stw 0,0(28)
	la 11,.LC183@l(11)
	lfs 0,200(31)
	lfd 12,0(11)
	lfs 13,4(31)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L459
	lwz 0,912(27)
	cmpwi 0,0,0
	bc 4,2,.L459
	li 0,1
	stw 0,912(27)
	li 4,0
	stw 0,308(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,27
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L459:
	lis 9,level@ha
	lis 10,.LC184@ha
	la 9,level@l(9)
	la 10,.LC184@l(10)
	lfs 0,200(9)
	lfd 12,0(10)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L460
	lwz 0,908(27)
	cmpwi 0,0,0
	bc 4,2,.L460
	li 0,1
	mr 3,27
	stw 0,908(27)
	bl KOTSStatScoreboard
	lis 9,gi+92@ha
	mr 3,27
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L460:
	lis 9,level@ha
	lis 10,.LC185@ha
	la 9,level@l(9)
	la 10,.LC185@l(10)
	lfs 0,200(9)
	lfd 12,0(10)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L457
	lbz 0,1(25)
	andi. 11,0,128
	bc 12,2,.L457
	li 0,1
	stw 0,208(9)
	b .L457
.L458:
	mr 3,27
	bl KOTSTime
	lwz 0,1852(28)
	cmpwi 0,0,0
	bc 12,2,.L462
	mr 3,27
	bl KOTSFly
.L462:
	lfs 13,960(27)
	fcmpu 0,13,31
	bc 12,2,.L463
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L463
	mr 3,27
	bl KOTS_MOTD
.L463:
	lwz 9,84(27)
	lis 11,pm_passent@ha
	stw 27,pm_passent@l(11)
	lwz 0,3920(9)
	cmpwi 0,0,0
	bc 12,2,.L464
	lha 0,2(25)
	lis 8,0x4330
	lis 9,.LC186@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC186@l(9)
	stw 0,260(1)
	lis 21,maxclients@ha
	stw 8,256(1)
	lfd 12,0(9)
	lfd 0,256(1)
	lis 9,.LC179@ha
	lfd 13,.LC179@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3564(28)
	lha 0,4(25)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3568(28)
	lha 0,6(25)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3572(28)
	b .L465
.L464:
	addi 3,1,8
	li 4,0
	mr 30,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(27)
	cmpwi 0,0,1
	bc 12,2,.L470
	lwz 0,40(27)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L470
	lwz 0,492(27)
	cmpwi 0,0,0
	bc 12,2,.L470
	li 0,2
.L470:
	stw 0,0(28)
	lis 9,sv_gravity@ha
	lwz 7,0(28)
	lwz 10,sv_gravity@l(9)
	li 20,3
	addi 23,1,12
	lwz 0,8(28)
	mtctr 20
	addi 26,27,4
	addi 22,1,18
	lfs 0,20(10)
	addi 24,27,376
	mr 12,23
	lwz 9,12(28)
	lis 10,.LC187@ha
	mr 4,26
	lwz 8,4(28)
	la 10,.LC187@l(10)
	mr 3,22
	lfs 10,0(10)
	mr 5,24
	addi 29,28,3592
	addi 31,1,36
	lis 21,maxclients@ha
	li 6,0
	li 10,0
	fctiwz 13,0
	stfd 13,256(1)
	lwz 11,260(1)
	sth 11,18(28)
	stw 7,8(1)
	stw 8,4(30)
	stw 0,8(30)
	stw 9,12(30)
	lwz 0,16(28)
	lwz 9,20(28)
	lwz 11,24(28)
	stw 0,16(30)
	stw 9,20(30)
	stw 11,24(30)
.L524:
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
	bdnz .L524
	mr 3,29
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L477
	li 0,1
	stw 0,52(1)
.L477:
	lwz 9,0(25)
	lwz 0,12(25)
	lwz 11,4(25)
	lwz 10,8(25)
	stw 9,36(1)
	stw 0,12(31)
	stw 11,4(31)
	stw 10,8(31)
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L478
	mr 3,27
	bl KOTSHighJump
	cmpwi 0,3,0
	bc 12,2,.L478
	li 0,500
	sth 0,26(1)
.L478:
	lis 11,gi@ha
	addi 3,1,8
	la 11,gi@l(11)
	lis 9,PM_trace@ha
	lwz 10,84(11)
	la 9,PM_trace@l(9)
	lis 20,.LC188@ha
	lwz 0,52(11)
	la 20,.LC188@l(20)
	mtlr 10
	stw 9,240(1)
	stw 0,244(1)
	blrl
	lis 9,.LC186@ha
	lwz 11,8(1)
	mr 31,23
	la 9,.LC186@l(9)
	lwz 10,4(30)
	mr 3,24
	lfd 11,0(9)
	mr 4,22
	mr 5,26
	lwz 0,8(30)
	lis 6,0x4330
	li 7,0
	lwz 9,12(30)
	li 8,0
	stw 11,0(28)
	li 11,3
	stw 10,4(28)
	stw 0,8(28)
	mtctr 11
	stw 9,12(28)
	lwz 0,16(30)
	lwz 9,20(30)
	lwz 11,24(30)
	stw 0,16(28)
	stw 9,20(28)
	stw 11,24(28)
	lwz 0,8(1)
	lwz 9,4(30)
	lwz 11,8(30)
	lwz 10,12(30)
	stw 0,3592(28)
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
.L523:
	lhax 0,7,31
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
	bdnz .L523
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 20,.LC186@ha
	lis 7,.LC179@ha
	lfs 8,204(1)
	la 20,.LC186@l(20)
	lfs 9,208(1)
	lfs 10,212(1)
	lfs 11,224(1)
	stfs 0,200(27)
	stfs 13,204(27)
	stfs 8,188(27)
	stfs 9,192(27)
	stfs 10,196(27)
	stfs 11,208(27)
	lha 0,2(25)
	lfd 12,0(20)
	xoris 0,0,0x8000
	lfd 13,.LC179@l(7)
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3564(28)
	lha 0,4(25)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3568(28)
	lha 0,6(25)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3572(28)
	lwz 0,552(27)
	cmpwi 0,0,0
	bc 12,2,.L484
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L484
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L484
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L484
	mr 3,27
	bl KOTSSilentJump
	cmpwi 0,3,0
	bc 4,2,.L485
	lis 29,gi@ha
	lis 3,.LC180@ha
	la 29,gi@l(29)
	la 3,.LC180@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC189@ha
	lis 10,.LC189@ha
	lis 11,.LC182@ha
	mr 5,3
	la 9,.LC189@l(9)
	la 10,.LC189@l(10)
	mtlr 0
	la 11,.LC182@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,27
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L485:
	mr 4,26
	mr 3,27
	li 5,0
	bl PlayerNoise
.L484:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(27)
	stw 11,608(27)
	fctiwz 13,0
	stw 10,552(27)
	stfd 13,256(1)
	lwz 9,260(1)
	stw 9,508(27)
	bc 12,2,.L486
	lwz 0,92(10)
	stw 0,556(27)
.L486:
	lwz 0,492(27)
	cmpwi 0,0,0
	bc 12,2,.L487
	lfs 0,3688(28)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(28)
	stw 9,28(28)
	stfs 0,32(28)
	b .L488
.L487:
	lfs 0,188(1)
	stfs 0,3760(28)
	lfs 13,192(1)
	stfs 13,3764(28)
	lfs 0,196(1)
	stfs 0,3768(28)
	lfs 13,188(1)
	stfs 13,28(28)
	lfs 0,192(1)
	stfs 0,32(28)
	lfs 13,196(1)
	stfs 13,36(28)
.L488:
	lwz 0,1844(28)
	cmpwi 0,0,0
	bc 12,2,.L489
	mr 3,27
	mr 4,25
	bl KOTSCloak
.L489:
	lis 9,gi+72@ha
	mr 3,27
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(27)
	cmpwi 0,0,1
	bc 12,2,.L490
	mr 3,27
	bl G_TouchTriggers
.L490:
	li 30,0
	lis 24,.LC181@ha
	b .L491
.L495:
	li 9,0
	addi 26,30,1
	cmpw 0,9,30
	bc 4,0,.L497
	lwz 0,60(1)
	cmpw 0,0,29
	bc 12,2,.L497
	mr 11,31
.L498:
	addi 9,9,1
	cmpw 0,9,30
	bc 4,0,.L497
	lwzu 0,4(11)
	cmpw 0,0,29
	bc 4,2,.L498
.L497:
	cmpw 0,9,30
	bc 4,2,.L493
	lwz 0,444(29)
	cmpwi 0,0,0
	bc 12,2,.L493
	mr 3,29
	mr 4,27
	mtlr 0
	li 5,0
	li 6,0
	blrl
.L493:
	mr 30,26
.L491:
	lwz 0,56(1)
	cmpw 0,30,0
	bc 4,0,.L465
	slwi 0,30,2
	addi 31,1,60
	lwzx 29,31,0
	la 4,.LC181@l(24)
	lwz 3,280(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L495
.L465:
	lwz 0,3640(28)
	lwz 11,3648(28)
	stw 0,3644(28)
	lbz 9,1(25)
	andc 0,9,0
	stw 9,3640(28)
	or 11,11,0
	stw 11,3648(28)
	lbz 0,15(25)
	stw 0,640(27)
	lwz 9,3648(28)
	andi. 0,9,1
	bc 12,2,.L505
	lwz 0,3576(28)
	cmpwi 0,0,0
	bc 12,2,.L506
	lwz 0,3920(28)
	li 9,0
	stw 9,3648(28)
	cmpwi 0,0,0
	bc 12,2,.L507
	lbz 0,16(28)
	stw 9,3920(28)
	andi. 0,0,191
	stb 0,16(28)
	b .L505
.L507:
	mr 3,27
	bl GetChaseTarget
	b .L505
.L506:
	lwz 0,3652(28)
	cmpwi 0,0,0
	bc 4,2,.L505
	li 0,1
	mr 3,27
	stw 0,3652(28)
	bl Think_Weapon
.L505:
	lwz 0,3576(28)
	cmpwi 0,0,0
	bc 12,2,.L511
	lha 0,12(25)
	cmpwi 0,0,9
	bc 4,1,.L512
	lbz 0,16(28)
	andi. 9,0,2
	bc 4,2,.L511
	lwz 9,3920(28)
	ori 0,0,2
	stb 0,16(28)
	cmpwi 0,9,0
	bc 12,2,.L514
	mr 3,27
	bl ChaseNext
	b .L511
.L514:
	mr 3,27
	bl GetChaseTarget
	b .L511
.L512:
	lbz 0,16(28)
	andi. 0,0,253
	stb 0,16(28)
.L511:
	mr 3,27
	li 30,1
	bl KOTSRegen
	lis 9,.LC189@ha
	lis 11,maxclients@ha
	la 9,.LC189@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L457
	lis 10,.LC186@ha
	lis 26,g_edicts@ha
	la 10,.LC186@l(10)
	lis 28,0x4330
	lfd 31,0(10)
	li 31,976
.L520:
	lwz 0,g_edicts@l(26)
	add 29,0,31
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L519
	lwz 9,84(29)
	lwz 0,3920(9)
	cmpw 0,0,27
	bc 4,2,.L519
	mr 3,29
	bl UpdateChaseCam
.L519:
	addi 30,30,1
	lwz 11,maxclients@l(21)
	xoris 0,30,0x8000
	addi 31,31,976
	stw 0,260(1)
	stw 28,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L520
.L457:
	lwz 0,324(1)
	mtlr 0
	lmw 20,264(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe16:
	.size	 ClientThink,.Lfe16-ClientThink
	.section	".rodata"
	.align 2
.LC190:
	.long 0x0
	.align 2
.LC191:
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
	lis 11,.LC190@ha
	la 11,.LC190@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	mr 31,3
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L525
	lis 9,deathmatch@ha
	lwz 30,84(31)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L527
	lwz 9,1868(30)
	lwz 0,3576(30)
	cmpw 0,9,0
	bc 12,2,.L527
	lfs 0,4(10)
	lis 9,.LC191@ha
	lfs 13,3916(30)
	la 9,.LC191@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L527
	bl spectator_respawn
	b .L525
.L527:
	lwz 0,3652(30)
	cmpwi 0,0,0
	bc 4,2,.L528
	lwz 0,3576(30)
	cmpwi 0,0,0
	bc 4,2,.L528
	mr 3,31
	bl Think_Weapon
	b .L529
.L528:
	li 0,0
	stw 0,3652(30)
.L529:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L530
	lis 9,level@ha
	lfs 13,3916(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L525
	lis 9,.LC190@ha
	lis 11,deathmatch@ha
	lwz 10,3648(30)
	la 9,.LC190@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L535
	bc 12,30,.L525
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L525
.L535:
	bc 4,30,.L536
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L537
.L536:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L538
	mr 3,31
	bl CopyToBodyQue
.L538:
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
	stfs 0,3916(11)
	b .L540
.L537:
	lis 9,gi+168@ha
	lis 3,.LC128@ha
	lwz 0,gi+168@l(9)
	la 3,.LC128@l(3)
	mtlr 0
	blrl
	b .L542
.L530:
	lis 9,.LC190@ha
	lis 11,deathmatch@ha
	la 9,.LC190@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L540
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L540
	addi 3,31,28
	bl PlayerTrail_Add
.L542:
.L540:
	li 0,0
	stw 0,3648(30)
.L525:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientBeginServerFrame,.Lfe17-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC192:
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
	lis 11,.LC192@ha
	lis 9,deathmatch@ha
	la 11,.LC192@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L324
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L323
.L324:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L325
	mr 3,31
	bl CopyToBodyQue
.L325:
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
	stfs 0,3916(11)
	b .L322
.L323:
	lis 9,gi+168@ha
	lis 3,.LC128@ha
	lwz 0,gi+168@l(9)
	la 3,.LC128@l(3)
	mtlr 0
	blrl
.L322:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 respawn,.Lfe18-respawn
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 4,0
	lwz 28,1812(29)
	li 5,1684
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 3,.LC93@ha
	stw 28,1812(29)
	la 3,.LC93@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	li 8,1
	mullw 9,9,0
	addi 7,29,740
	li 11,100
	li 10,50
	li 6,200
	srawi 9,9,2
	slwi 0,9,2
	stw 9,736(29)
	stwx 8,7,0
	stw 8,720(29)
	stw 3,1788(29)
	stw 11,1768(29)
	stw 6,1780(29)
	stw 10,1784(29)
	stw 11,724(29)
	stw 11,728(29)
	stw 6,1764(29)
	stw 10,1772(29)
	stw 10,1776(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 InitClientPersistant,.Lfe19-InitClientPersistant
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
	addi 28,29,1872
	lwz 26,3584(29)
	li 5,1720
	lwz 27,3580(29)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1684
	stw 0,3556(29)
	crxor 6,6,6
	bl memcpy
	stw 26,3584(29)
	stw 27,3580(29)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 InitClientResp,.Lfe20-InitClientResp
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
	lis 11,.LC127@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC127@l(11)
.L312:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L312
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 InitBodyQue,.Lfe21-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe22:
	.size	 player_pain,.Lfe22-player_pain
	.section	".rodata"
	.align 2
.LC193:
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
	lis 9,.LC193@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC193@l(9)
	addi 10,10,976
	lfs 13,0(9)
.L206:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L205
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
	bc 12,2,.L205
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3560(9)
	add 11,7,11
	stw 0,1800(11)
.L205:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3964
	addi 10,10,976
	cmpw 0,6,0
	bc 12,0,.L206
	blr
.Lfe23:
	.size	 SaveClientData,.Lfe23-SaveClientData
	.section	".rodata"
	.align 2
.LC194:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC194@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC194@l(9)
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
	stw 0,3560(7)
	blr
.Lfe24:
	.size	 FetchClientEntData,.Lfe24-FetchClientEntData
	.section	".rodata"
	.align 2
.LC195:
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
	lis 9,.LC195@ha
	mr 30,3
	la 9,.LC195@l(9)
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
.Lfe25:
	.size	 SP_FixCoopSpots,.Lfe25-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC196:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC197:
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
	lis 11,.LC197@ha
	lis 9,coop@ha
	la 11,.LC197@l(11)
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
	lis 11,.LC196@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC196@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 SP_info_player_start,.Lfe26-SP_info_player_start
	.section	".rodata"
	.align 2
.LC198:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC198@ha
	lis 9,deathmatch@ha
	la 11,.LC198@l(11)
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
.Lfe27:
	.size	 SP_info_player_deathmatch,.Lfe27-SP_info_player_deathmatch
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe28:
	.size	 SP_info_player_intermission,.Lfe28-SP_info_player_intermission
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
	b .L543
.L30:
	li 3,0
.L543:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 IsFemale,.Lfe29-IsFemale
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
	bc 4,2,.L544
.L34:
	li 3,0
.L544:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 IsNeutral,.Lfe30-IsNeutral
	.section	".rodata"
	.align 2
.LC199:
	.long 0x4b18967f
	.align 2
.LC200:
	.long 0x3f800000
	.align 3
.LC201:
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
	lis 11,.LC200@ha
	lwz 10,maxclients@l(9)
	la 11,.LC200@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC199@ha
	lfs 31,.LC199@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L214
	lis 9,.LC201@ha
	lis 27,g_edicts@ha
	la 9,.LC201@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,976
.L216:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L215
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L215
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
	bc 4,0,.L215
	fmr 31,1
.L215:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,976
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L216
.L214:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe31:
	.size	 PlayersRangeFromSpot,.Lfe31-PlayersRangeFromSpot
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
	bc 4,2,.L265
	bl SelectRandomDeathmatchSpawnPoint
	b .L546
.L265:
	bl SelectFarthestDeathmatchSpawnPoint
.L546:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 SelectDeathmatchSpawnPoint,.Lfe32-SelectDeathmatchSpawnPoint
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
	lis 9,0xcfb1
	lwz 10,game+1028@l(11)
	ori 9,9,30751
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L547
.L271:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L272
	li 3,0
	b .L547
.L272:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L273
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L273:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L271
	addic. 31,31,-1
	bc 4,2,.L271
	mr 3,30
.L547:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe33:
	.size	 SelectCoopSpawnPoint,.Lfe33-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC202:
	.long 0x3f800000
	.align 2
.LC203:
	.long 0x0
	.align 2
.LC204:
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
	bc 4,0,.L315
	lis 29,gi@ha
	lis 3,.LC108@ha
	la 29,gi@l(29)
	la 3,.LC108@l(3)
	lwz 9,36(29)
	lis 27,.LC109@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC202@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC202@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC202@ha
	la 9,.LC202@l(9)
	lfs 2,0(9)
	lis 9,.LC203@ha
	la 9,.LC203@l(9)
	lfs 3,0(9)
	blrl
.L319:
	mr 3,31
	la 4,.LC109@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L319
	lis 9,.LC204@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC204@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L315:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 body_die,.Lfe34-body_die
	.section	".rodata"
	.align 2
.LC205:
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
	li 5,1720
	addi 27,29,1872
	lwz 26,3584(29)
	lwz 25,3580(29)
	mr 3,27
	crxor 6,6,6
	bl memset
	lis 28,level@ha
	addi 4,29,188
	lwz 0,level@l(28)
	li 5,1684
	mr 3,27
	la 28,level@l(28)
	stw 0,3556(29)
	crxor 6,6,6
	bl memcpy
	stw 26,3584(29)
	mr 3,31
	stw 25,3580(29)
	bl PutClientInServer
	lis 9,.LC205@ha
	lfs 13,200(28)
	la 9,.LC205@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L372
	mr 3,31
	bl MoveClientToIntermission
	b .L373
.L372:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,38677
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,4
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
.L373:
	mr 3,31
	bl KOTSEnter
	mr 3,31
	bl ClientEndServerFrame
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 ClientBeginDeathmatch,.Lfe35-ClientBeginDeathmatch
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
	bc 4,1,.L435
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L434
.L435:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L434:
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
	bc 4,0,.L439
.L441:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L441
.L439:
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
.L549:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L549
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L548:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L548
	lis 3,.LC178@ha
	la 3,.LC178@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 PrintPmove,.Lfe38-PrintPmove
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
.Lfe39:
	.size	 stuffcmd,.Lfe39-stuffcmd
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
.Lfe40:
	.size	 SP_CreateCoopSpots,.Lfe40-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
