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
	bc 4,2,.L25
	bl G_FreeEdict
	b .L24
.L25:
	lis 31,level+72@ha
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	la 3,level+72@l(31)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC6@ha
	la 3,level+72@l(31)
	la 4,.LC6@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC7@ha
	la 3,level+72@l(31)
	la 4,.LC7@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC8@ha
	la 3,level+72@l(31)
	la 4,.LC8@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC9@ha
	la 3,level+72@l(31)
	la 4,.LC9@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC10@ha
	la 3,level+72@l(31)
	la 4,.LC10@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC11@ha
	la 3,level+72@l(31)
	la 4,.LC11@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC12@ha
	la 3,level+72@l(31)
	la 4,.LC12@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC13@ha
	la 3,level+72@l(31)
	la 4,.LC13@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC14@ha
	la 3,level+72@l(31)
	la 4,.LC14@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC15@ha
	la 3,level+72@l(31)
	la 4,.LC15@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC16@ha
	la 3,level+72@l(31)
	la 4,.LC16@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC17@ha
	la 3,level+72@l(31)
	la 4,.LC17@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC18@ha
	la 3,level+72@l(31)
	la 4,.LC18@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L24
.L27:
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
.L24:
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
	.string	"skin"
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
	.string	"tripped on her own grenade"
	.align 2
.LC36:
	.string	"tripped on his own grenade"
	.align 2
.LC37:
	.string	"blew herself up"
	.align 2
.LC38:
	.string	"blew himself up"
	.align 2
.LC39:
	.string	"should have used a smaller gun"
	.align 2
.LC40:
	.string	"killed herself"
	.align 2
.LC41:
	.string	"killed himself"
	.align 2
.LC42:
	.string	"%s %s.\n"
	.align 2
.LC43:
	.string	"was blasted by"
	.align 2
.LC44:
	.string	"was gunned down by"
	.align 2
.LC45:
	.string	"was blown away by"
	.align 2
.LC46:
	.string	"'s super shotgun"
	.align 2
.LC47:
	.string	"was machinegunned by"
	.align 2
.LC48:
	.string	"was cut in half by"
	.align 2
.LC49:
	.string	"'s chaingun"
	.align 2
.LC50:
	.string	"was popped by"
	.align 2
.LC51:
	.string	"'s grenade"
	.align 2
.LC52:
	.string	"was shredded by"
	.align 2
.LC53:
	.string	"'s shrapnel"
	.align 2
.LC54:
	.string	"ate"
	.align 2
.LC55:
	.string	"'s rocket"
	.align 2
.LC56:
	.string	"almost dodged"
	.align 2
.LC57:
	.string	"was melted by"
	.align 2
.LC58:
	.string	"'s hyperblaster"
	.align 2
.LC59:
	.string	"was railed by"
	.align 2
.LC60:
	.string	"saw the pretty lights from"
	.align 2
.LC61:
	.string	"'s BFG"
	.align 2
.LC62:
	.string	"was disintegrated by"
	.align 2
.LC63:
	.string	"'s BFG blast"
	.align 2
.LC64:
	.string	"couldn't hide from"
	.align 2
.LC65:
	.string	"caught"
	.align 2
.LC66:
	.string	"'s handgrenade"
	.align 2
.LC67:
	.string	"didn't see"
	.align 2
.LC68:
	.string	"feels"
	.align 2
.LC69:
	.string	"'s pain"
	.align 2
.LC70:
	.string	"tried to invade"
	.align 2
.LC71:
	.string	"'s personal space"
	.align 2
.LC72:
	.string	"was caught by"
	.align 2
.LC73:
	.string	"'s grapple"
	.align 2
.LC74:
	.string	"%s %s %s%s\n"
	.align 2
.LC75:
	.string	"%s died.\n"
	.align 2
.LC76:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 11,sv_utilflags@ha
	lwz 10,sv_utilflags@l(11)
	mr 30,3
	mr 29,5
	mr 7,6
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,2
	bc 4,2,.L34
	lis 9,meansOfDeath@ha
	lwz 6,meansOfDeath@l(9)
	bl ExpertClientObituary
	b .L33
.L34:
	lis 9,.LC76@ha
	lis 11,coop@ha
	la 9,.LC76@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L35
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L35:
	lis 11,.LC76@ha
	lis 9,deathmatch@ha
	la 11,.LC76@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L37
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
.L37:
	lis 9,meansOfDeath@ha
	lis 11,.LC22@ha
	lwz 0,meansOfDeath@l(9)
	la 31,.LC22@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	rlwinm 27,0,0,4,4
	addi 10,28,-17
	cmplwi 0,10,16
	bc 12,1,.L38
	lis 11,.L53@ha
	slwi 10,10,2
	la 11,.L53@l(11)
	lis 9,.L53@ha
	lwzx 0,10,11
	la 9,.L53@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L53:
	.long .L42-.L53
	.long .L43-.L53
	.long .L44-.L53
	.long .L41-.L53
	.long .L38-.L53
	.long .L40-.L53
	.long .L39-.L53
	.long .L38-.L53
	.long .L46-.L53
	.long .L46-.L53
	.long .L52-.L53
	.long .L47-.L53
	.long .L52-.L53
	.long .L48-.L53
	.long .L52-.L53
	.long .L38-.L53
	.long .L49-.L53
.L39:
	lis 9,.LC23@ha
	la 6,.LC23@l(9)
	b .L38
.L40:
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
	b .L38
.L41:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L38
.L42:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L38
.L43:
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L38
.L44:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L38
.L46:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L38
.L47:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L38
.L48:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L38
.L49:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L38
.L52:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
.L38:
	cmpw 0,29,30
	bc 4,2,.L55
	addi 10,28,-7
	cmplwi 0,10,17
	bc 12,1,.L72
	lis 11,.L78@ha
	slwi 10,10,2
	la 11,.L78@l(11)
	lis 9,.L78@ha
	lwzx 0,10,11
	la 9,.L78@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L78:
	.long .L59-.L78
	.long .L72-.L78
	.long .L65-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L71-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L59-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L72-.L78
	.long .L57-.L78
.L57:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L55
.L59:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L61
	li 0,0
	b .L62
.L61:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L62:
	cmpwi 0,0,0
	bc 12,2,.L60
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L55
.L60:
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L55
.L65:
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
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L68:
	cmpwi 0,0,0
	bc 12,2,.L66
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L55
.L66:
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L55
.L71:
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L55
.L72:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L74
	li 0,0
	b .L75
.L74:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L75:
	cmpwi 0,0,0
	bc 12,2,.L73
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L55
.L73:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
.L55:
	cmpwi 0,6,0
	bc 12,2,.L79
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC42@ha
	lwz 0,gi@l(9)
	la 4,.LC42@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC76@ha
	lis 11,deathmatch@ha
	la 9,.LC76@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L80
	lwz 11,84(30)
	lwz 9,3432(11)
	addi 9,9,-1
	stw 9,3432(11)
.L80:
	lis 11,sv_utilflags@ha
	li 0,0
	lwz 10,sv_utilflags@l(11)
	stw 0,540(30)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 11,9,1
	bc 12,2,.L33
	lis 9,meansOfDeath@ha
	mr 3,30
	lwz 4,meansOfDeath@l(9)
	bl gsLogKillSelf
	b .L33
.L79:
	cmpwi 0,29,0
	stw 29,540(30)
	bc 12,2,.L36
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L36
	addi 0,28,-1
	cmplwi 0,0,33
	bc 12,1,.L83
	lis 11,.L103@ha
	slwi 10,0,2
	la 11,.L103@l(11)
	lis 9,.L103@ha
	lwzx 0,10,11
	la 9,.L103@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L103:
	.long .L84-.L103
	.long .L85-.L103
	.long .L86-.L103
	.long .L87-.L103
	.long .L88-.L103
	.long .L89-.L103
	.long .L90-.L103
	.long .L91-.L103
	.long .L92-.L103
	.long .L93-.L103
	.long .L94-.L103
	.long .L95-.L103
	.long .L96-.L103
	.long .L97-.L103
	.long .L98-.L103
	.long .L99-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L101-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L100-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L83-.L103
	.long .L102-.L103
.L84:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L83
.L85:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L83
.L86:
	lis 9,.LC45@ha
	lis 11,.LC46@ha
	la 6,.LC45@l(9)
	la 31,.LC46@l(11)
	b .L83
.L87:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L83
.L88:
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 6,.LC48@l(9)
	la 31,.LC49@l(11)
	b .L83
.L89:
	lis 9,.LC50@ha
	lis 11,.LC51@ha
	la 6,.LC50@l(9)
	la 31,.LC51@l(11)
	b .L83
.L90:
	lis 9,.LC52@ha
	lis 11,.LC53@ha
	la 6,.LC52@l(9)
	la 31,.LC53@l(11)
	b .L83
.L91:
	lis 9,.LC54@ha
	lis 11,.LC55@ha
	la 6,.LC54@l(9)
	la 31,.LC55@l(11)
	b .L83
.L92:
	lis 9,.LC56@ha
	lis 11,.LC55@ha
	la 6,.LC56@l(9)
	la 31,.LC55@l(11)
	b .L83
.L93:
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 6,.LC57@l(9)
	la 31,.LC58@l(11)
	b .L83
.L94:
	lis 9,.LC59@ha
	la 6,.LC59@l(9)
	b .L83
.L95:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 31,.LC61@l(11)
	b .L83
.L96:
	lis 9,.LC62@ha
	lis 11,.LC63@ha
	la 6,.LC62@l(9)
	la 31,.LC63@l(11)
	b .L83
.L97:
	lis 9,.LC64@ha
	lis 11,.LC61@ha
	la 6,.LC64@l(9)
	la 31,.LC61@l(11)
	b .L83
.L98:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 6,.LC65@l(9)
	la 31,.LC66@l(11)
	b .L83
.L99:
	lis 9,.LC67@ha
	lis 11,.LC66@ha
	la 6,.LC67@l(9)
	la 31,.LC66@l(11)
	b .L83
.L100:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 6,.LC68@l(9)
	la 31,.LC69@l(11)
	b .L83
.L101:
	lis 9,.LC70@ha
	lis 11,.LC71@ha
	la 6,.LC70@l(9)
	la 31,.LC71@l(11)
	b .L83
.L102:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 6,.LC72@l(9)
	la 31,.LC73@l(11)
.L83:
	cmpwi 0,6,0
	bc 12,2,.L36
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC74@ha
	lwz 0,gi@l(9)
	la 4,.LC74@l(4)
	addi 7,7,700
	addi 5,5,700
	mr 8,31
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC76@ha
	lis 11,deathmatch@ha
	la 9,.LC76@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L106
	cmpwi 0,27,0
	bc 12,2,.L107
	lwz 11,84(29)
	lwz 9,3432(11)
	addi 9,9,-1
	b .L112
.L107:
	lwz 11,84(29)
	lwz 9,3432(11)
	addi 9,9,1
.L112:
	stw 9,3432(11)
.L106:
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L33
	lis 9,meansOfDeath@ha
	mr 3,30
	lwz 5,meansOfDeath@l(9)
	mr 4,29
	bl gsLogFrag
	b .L33
.L36:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC75@ha
	lwz 0,gi@l(9)
	la 4,.LC75@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC76@ha
	lis 11,deathmatch@ha
	la 9,.LC76@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L33
	lwz 7,84(30)
	lis 10,sv_utilflags@ha
	lwz 8,sv_utilflags@l(10)
	lwz 9,3432(7)
	addi 9,9,-1
	stw 9,3432(7)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L33
	lis 9,meansOfDeath@ha
	mr 3,30
	lwz 4,meansOfDeath@l(9)
	bl gsLogKillSelf
.L33:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC77:
	.string	"Blaster"
	.align 2
.LC78:
	.string	"item_quad"
	.align 3
.LC79:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC80:
	.long 0x0
	.align 3
.LC81:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC82:
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
	lis 10,.LC80@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC80@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
	lis 10,sv_expflags@ha
	lwz 8,84(30)
	lwz 11,sv_expflags@l(10)
	lwz 31,1792(8)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 11,9,2
	bc 4,2,.L115
	lwz 9,3752(8)
	addi 10,8,744
	slwi 9,9,2
	lwzx 11,10,9
	srawi 9,11,31
	xor 0,9,11
	subf 0,0,9
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L115
	lwz 3,40(31)
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L115:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 12,2,.L119
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 11,11,10
	cmpwi 0,11,10
	bc 4,2,.L118
.L119:
	li 29,0
	b .L120
.L118:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC81@ha
	lfs 12,3948(8)
	addi 9,9,10
	la 10,.LC81@l(10)
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
.L120:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC80@ha
	and. 10,0,29
	la 9,.LC80@l(9)
	lfs 31,0(9)
	bc 12,2,.L121
	lis 11,.LC82@ha
	la 11,.LC82@l(11)
	lfs 31,0(11)
.L121:
	cmpwi 0,31,0
	bc 12,2,.L123
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3880(9)
	fsubs 0,0,31
	stfs 0,3880(9)
	bl Drop_Item
	lwz 9,84(30)
	mr 12,3
	lis 0,0x2
	mr 4,30
	lfs 0,3880(9)
	fadds 0,0,31
	stfs 0,3880(9)
	stw 0,284(12)
	bl ExpertAddToDroppedWeapon
.L123:
	cmpwi 0,29,0
	bc 12,2,.L113
	lwz 9,84(30)
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	lfs 0,3880(9)
	fadds 0,0,31
	stfs 0,3880(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	mr 12,3
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lis 11,Touch_Item@ha
	lfs 0,3880(7)
	la 11,Touch_Item@l(11)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	lis 9,.LC79@ha
	la 5,level@l(6)
	fsubs 0,0,31
	lfd 11,.LC79@l(9)
	lis 10,G_FreeEdict@ha
	la 10,G_FreeEdict@l(10)
	stfs 0,3880(7)
	lwz 0,284(12)
	stw 11,444(12)
	oris 0,0,0x2
	stw 0,284(12)
	lwz 9,level@l(6)
	lwz 11,84(30)
	xoris 9,9,0x8000
	lfs 12,4(5)
	stw 9,20(1)
	stw 4,16(1)
	lfd 13,16(1)
	lfs 0,3948(11)
	stw 10,436(12)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(12)
.L113:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 2
.LC85:
	.string	"misc/udeath.wav"
	.align 2
.LC86:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.39:
	.space	4
	.size	 i.39,4
	.section	".rodata"
	.align 2
.LC87:
	.string	"*death%i.wav"
	.align 3
.LC84:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC88:
	.long 0xc2200000
	.align 3
.LC89:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC90:
	.long 0x0
	.align 2
.LC91:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 25,44(1)
	stw 0,84(1)
	lis 11,.LC88@ha
	lis 9,sv_lethality@ha
	la 11,.LC88@l(11)
	mr 31,3
	lfs 12,0(11)
	mr 29,4
	lwz 11,sv_lethality@l(9)
	mr 30,5
	mr 26,6
	lwz 9,84(31)
	mr 28,7
	lfs 0,20(11)
	lwz 3,4020(9)
	fmuls 0,0,12
	cmpwi 0,3,0
	fctiwz 13,0
	stfd 13,32(1)
	lwz 25,36(1)
	bc 12,2,.L131
	bl Release_Grapple
.L131:
	li 0,0
	li 11,0
	lwz 7,84(31)
	li 9,1
	li 10,7
	stw 0,24(31)
	stw 9,512(31)
	lis 8,0xc100
	stw 0,396(31)
	stw 0,392(31)
	stw 0,388(31)
	stw 0,16(31)
	stw 10,260(31)
	stw 11,44(31)
	stw 11,48(31)
	stw 11,76(31)
	stw 11,3976(7)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 8,208(31)
	ori 0,0,2
	stw 11,248(31)
	stw 0,184(31)
	bc 4,2,.L132
	mr 6,28
	mr 3,31
	mr 4,29
	mr 5,30
	bl ClientObituary
	lis 9,level+4@ha
	lis 11,.LC89@ha
	lfs 0,level+4@l(9)
	la 11,.LC89@l(11)
	cmpwi 0,30,0
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3984(11)
	bc 12,2,.L133
	lis 9,g_edicts@ha
	xor 11,30,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,30,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L133
	lfs 11,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(30)
	b .L163
.L133:
	cmpwi 0,29,0
	bc 12,2,.L135
	lis 9,g_edicts@ha
	xor 11,29,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,29,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L135
	lfs 11,4(31)
	lfs 13,4(29)
	lfs 12,8(29)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(29)
.L163:
	lfs 11,12(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	b .L134
.L135:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3804(9)
	b .L137
.L134:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC84@ha
	lwz 11,84(31)
	lfd 0,.LC84@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3804(11)
.L137:
	lwz 8,84(31)
	lis 11,sv_expflags@ha
	li 0,2
	lwz 10,sv_expflags@l(11)
	stw 0,0(8)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 9,36(1)
	andis. 0,9,1
	bc 12,2,.L138
	mr 3,30
	mr 4,31
	bl onSameTeam
	cmpwi 0,3,0
	bc 4,2,.L138
	mr 3,30
	mr 4,31
	bl alternateRestoreKill
.L138:
	lis 9,.LC90@ha
	lis 27,ctf@ha
	la 9,.LC90@l(9)
	lfs 31,0(9)
	lwz 9,ctf@l(27)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L139
	mr 3,31
	mr 4,29
	mr 5,30
	bl ExpertCTFScoring
.L139:
	lis 28,flagtrack@ha
	lwz 9,flagtrack@l(28)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L140
	mr 4,29
	mr 3,31
	mr 5,30
	bl FlagTrackScoring
.L140:
	mr 3,31
	bl TossClientWeapon
	lwz 9,ctf@l(27)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L141
	mr 3,31
	bl CTFDeadDropFlag
.L141:
	lwz 9,flagtrack@l(28)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L142
	mr 4,30
	mr 3,31
	bl FlagTrackDeadDropFlag
.L142:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L132
	lwz 9,84(31)
	lwz 0,3728(9)
	cmpwi 0,0,0
	bc 4,2,.L132
	mr 3,31
	bl Cmd_Help_f
.L132:
	lwz 11,84(31)
	li 0,0
	li 4,0
	li 5,1024
	stw 0,3948(11)
	lwz 9,84(31)
	stw 0,3952(9)
	lwz 11,84(31)
	stw 0,3956(11)
	lwz 9,84(31)
	stw 0,3960(9)
	lwz 11,84(31)
	stw 0,3996(11)
	lwz 3,84(31)
	addi 3,3,744
	crxor 6,6,6
	bl memset
	lwz 0,480(31)
	cmpw 0,0,25
	bc 12,0,.L145
	lis 9,sv_arenaflags@ha
	lwz 11,sv_arenaflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 9,36(1)
	andi. 0,9,1
	bc 12,2,.L144
.L145:
	lis 29,gi@ha
	lis 3,.LC85@ha
	la 29,gi@l(29)
	la 3,.LC85@l(3)
	lwz 9,36(29)
	lis 28,.LC86@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC91@ha
	lwz 0,16(29)
	lis 11,.LC91@ha
	la 9,.LC91@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC91@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC90@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC90@l(9)
	lfs 3,0(9)
	blrl
.L149:
	mr 3,31
	la 4,.LC86@l(28)
	mr 5,26
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L149
	mr 4,26
	mr 3,31
	bl ThrowClientHead
	lwz 9,84(31)
	li 0,5
	stw 0,3936(9)
	lwz 11,84(31)
	stw 30,3932(11)
	stw 30,512(31)
	b .L151
.L144:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L151
	lis 8,i.39@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.39@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.39@l(8)
	stw 7,3936(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L153
	li 0,172
	li 9,177
	b .L164
.L153:
	cmpwi 0,10,1
	bc 12,2,.L157
	bc 12,1,.L161
	cmpwi 0,10,0
	bc 12,2,.L156
	b .L154
.L161:
	cmpwi 0,10,2
	bc 12,2,.L158
	b .L154
.L156:
	li 0,177
	li 9,183
	b .L164
.L157:
	li 0,183
	li 9,189
	b .L164
.L158:
	li 0,189
	li 9,197
.L164:
	stw 0,56(31)
	stw 9,3932(11)
.L154:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC87@ha
	srwi 0,0,30
	la 3,.LC87@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC91@ha
	lwz 0,16(29)
	lis 11,.LC91@ha
	la 9,.LC91@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC91@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC90@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC90@l(9)
	lfs 3,0(9)
	blrl
.L151:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 10,sv_arenaflags@ha
	lwz 9,sv_arenaflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 11,36(1)
	andi. 0,11,1
	bc 12,2,.L162
	mr 3,31
	bl arenaKilled
.L162:
	lwz 0,84(1)
	mtlr 0
	lmw 25,44(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 player_die,.Lfe4-player_die
	.section	".rodata"
	.align 2
.LC92:
	.string	"fweapon"
	.align 2
.LC93:
	.string	"Jacket Armor"
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-64(1)
	mflr 0
	stmw 22,24(1)
	stw 0,68(1)
	mr 31,3
	lis 4,.LC92@ha
	addi 29,31,188
	la 4,.LC92@l(4)
	mr 3,29
	lis 25,.LC77@ha
	bl Info_ValueForKey
	lis 30,0x38e3
	lis 26,sv_expflags@ha
	mr 24,3
	li 5,1620
	lwz 23,724(31)
	mr 3,29
	li 4,0
	crxor 6,6,6
	bl memset
	ori 30,30,36409
	addi 28,31,744
	la 3,.LC77@l(25)
	li 22,1
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 8,sv_expflags@l(26)
	la 27,itemlist@l(9)
	subf 0,27,29
	lis 10,0x1
	mullw 0,0,30
	ori 10,10,2
	srawi 0,0,3
	stw 0,740(31)
	slwi 9,0,2
	stwx 22,28,9
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	and 11,11,10
	cmpwi 0,11,2
	bc 4,2,.L166
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	bl FindItem
	subf 0,27,3
	li 9,50
	mullw 0,0,30
	la 3,.LC77@l(25)
	srawi 0,0,3
	slwi 0,0,2
	stwx 9,28,0
	bl FindItem
	mr 29,3
.L166:
	lwz 11,sv_expflags@l(26)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,4
	bc 12,2,.L167
	mr 3,31
	bl giveFreeGear
	mr 29,3
.L167:
	mr 3,24
	bl FindItem
	mr. 3,3
	bc 12,2,.L168
	subf 0,27,3
	mullw 0,0,30
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,28,0
	addic 9,9,-1
	subfe 9,9,9
	andc 0,3,9
	and 9,29,9
	or 29,9,0
.L168:
	lwz 11,sv_expflags@l(26)
	li 10,100
	stw 29,1796(31)
	stw 29,1792(31)
	stw 10,728(31)
	stw 10,732(31)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andis. 0,9,1
	bc 12,2,.L169
	li 0,130
	li 9,160
	stw 0,728(31)
	stw 9,732(31)
.L169:
	li 0,50
	li 9,200
	stw 23,724(31)
	stw 10,1772(31)
	stw 9,1784(31)
	stw 0,1788(31)
	stw 22,720(31)
	stw 9,1768(31)
	stw 0,1776(31)
	stw 0,1780(31)
	lwz 0,68(1)
	mtlr 0
	lmw 22,24(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 InitClientPersistant,.Lfe5-InitClientPersistant
	.section	".rodata"
	.align 2
.LC94:
	.long 0x4b18967f
	.align 2
.LC95:
	.long 0x3f800000
	.align 3
.LC96:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC97:
	.long 0x0
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
	lis 11,.LC95@ha
	lwz 10,maxclients@l(9)
	la 11,.LC95@l(11)
	mr 31,3
	lfs 13,0(11)
	li 30,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC94@ha
	lfs 31,.LC94@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L184
	lis 9,.LC96@ha
	lis 27,g_edicts@ha
	la 9,.LC96@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 29,916
.L186:
	lwz 0,g_edicts@l(27)
	add 11,0,29
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L185
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L185
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
	bc 4,0,.L185
	fmr 31,1
.L185:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 29,29,916
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L186
.L184:
	lis 9,.LC97@ha
	lis 11,flagtrack@ha
	la 9,.LC97@l(9)
	lfs 13,0(9)
	lwz 9,flagtrack@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L191
	li 30,0
	lis 29,flags@ha
	b .L192
.L195:
	lwz 3,flags@l(29)
	mr 4,30
	bl listElementAt
	mr 11,3
	lfs 13,4(31)
	lfs 0,4(11)
	addi 3,1,8
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
	bc 4,0,.L194
	fmr 31,1
.L194:
	addi 30,30,1
.L192:
	lis 9,flags@ha
	lwz 3,flags@l(9)
	bl listSize
	cmpw 0,30,3
	bc 12,0,.L195
.L191:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 PlayersRangeFromSpot,.Lfe6-PlayersRangeFromSpot
	.section	".rodata"
	.align 2
.LC99:
	.string	"info_player_deathmatch"
	.align 2
.LC98:
	.long 0x47c34f80
	.section	".text"
	.align 2
	.globl SelectRandomDeathmatchSpawnPoint
	.type	 SelectRandomDeathmatchSpawnPoint,@function
SelectRandomDeathmatchSpawnPoint:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 27,12(1)
	stw 0,52(1)
	lis 9,.LC98@ha
	li 31,0
	lfs 31,.LC98@l(9)
	li 30,0
	li 28,0
	li 29,0
	fmr 30,31
	lis 27,.LC99@ha
	b .L199
.L201:
	mr 3,30
	addi 31,31,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L202
	fmr 30,1
	mr 29,30
	b .L199
.L202:
	fcmpu 0,1,31
	bc 4,0,.L199
	fmr 31,1
	mr 28,30
.L199:
	lis 5,.LC99@ha
	mr 3,30
	la 5,.LC99@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L201
	cmpwi 0,31,0
	bc 4,2,.L206
	li 3,0
	b .L214
.L206:
	cmpwi 0,31,2
	bc 12,1,.L207
	li 28,0
	li 29,0
	b .L208
.L207:
	addi 31,31,-2
.L208:
	bl rand
	li 30,0
	divw 0,3,31
	mullw 0,0,31
	subf 31,0,3
.L213:
	mr 3,30
	li 4,280
	la 5,.LC99@l(27)
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
	bc 4,2,.L213
.L214:
	lwz 0,52(1)
	mtlr 0
	lmw 27,12(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe7-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC100:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC101:
	.long 0x0
	.align 2
.LC102:
	.long 0x41100000
	.section	".text"
	.align 2
	.globl SelectSpawnPoint
	.type	 SelectSpawnPoint,@function
SelectSpawnPoint:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 11,.LC101@ha
	lis 9,deathmatch@ha
	la 11,.LC101@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 31,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L243
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L244
	bl SelectCTFSpawnPoint
.L283:
	mr 31,3
	b .L256
.L244:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L246
	lis 9,.LC101@ha
	li 31,0
	la 9,.LC101@l(9)
	li 29,0
	lfs 31,0(9)
	b .L247
.L249:
	mr 3,31
	bl PlayersRangeFromSpot
	fcmpu 0,1,31
	bc 4,1,.L247
	fmr 31,1
	mr 29,31
.L247:
	lis 30,.LC99@ha
	mr 3,31
	li 4,280
	la 5,.LC99@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L249
	cmpwi 0,29,0
	bc 12,2,.L252
	mr 3,29
	b .L283
.L252:
	la 5,.LC99@l(30)
	li 3,0
	li 4,280
	bl G_Find
	b .L283
.L246:
	bl SelectRandomDeathmatchSpawnPoint
	b .L283
.L280:
	li 31,0
	b .L256
.L243:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L256
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xa434
	lwz 10,game+1028@l(11)
	ori 9,9,38101
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 30,0,2
	bc 12,2,.L256
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 31,game+1032@ha
.L262:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L280
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
	bc 4,2,.L262
	addic. 30,30,-1
	bc 4,2,.L262
	mr 31,29
.L256:
	cmpwi 0,31,0
	bc 4,2,.L268
	lis 29,.LC0@ha
	lis 30,game@ha
.L275:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L281
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L279
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L270
	b .L275
.L279:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L275
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L275
.L270:
	cmpwi 0,31,0
	bc 4,2,.L268
.L281:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L277
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L277:
	cmpwi 0,31,0
	bc 4,2,.L268
	lis 9,gi+28@ha
	lis 3,.LC100@ha
	lwz 0,gi+28@l(9)
	la 3,.LC100@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L268:
	lfs 0,4(31)
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
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
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 SelectSpawnPoint,.Lfe8-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC103:
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
	mulli 27,27,916
	addi 27,27,916
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
	lis 9,0x478b
	li 11,0
	ori 9,9,48365
	li 8,1
	subf 0,0,29
	lis 10,body_die@ha
	mullw 0,0,9
	la 10,body_die@l(10)
	mr 3,29
	srawi 0,0,2
	stwx 0,24,27
	stw 11,64(29)
	stw 11,68(29)
	lwz 0,184(28)
	stw 0,184(29)
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
	stw 8,248(29)
	stfs 0,244(29)
	lwz 0,252(28)
	stw 0,252(29)
	lwz 9,256(28)
	stw 9,256(29)
	lwz 0,260(28)
	stw 10,456(29)
	stw 0,260(29)
	stw 8,512(29)
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
.LC104:
	.string	"menu_loadgame\n"
	.align 2
.LC105:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC106:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC107:
	.string	"player"
	.align 2
.LC108:
	.string	"players/male/tris.md2"
	.align 2
.LC109:
	.string	"fov"
	.align 2
.LC110:
	.long 0x0
	.align 2
.LC111:
	.long 0x41400000
	.align 2
.LC112:
	.long 0x41000000
	.align 3
.LC113:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC114:
	.long 0x3f800000
	.align 2
.LC115:
	.long 0x43200000
	.align 2
.LC116:
	.long 0x47800000
	.align 2
.LC117:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4720(1)
	mflr 0
	stfd 31,4712(1)
	stmw 19,4660(1)
	stw 0,4724(1)
	lis 9,.LC105@ha
	lis 8,.LC106@ha
	lwz 0,.LC105@l(9)
	la 29,.LC106@l(8)
	addi 10,1,8
	la 9,.LC105@l(9)
	lwz 11,.LC106@l(8)
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
	lis 9,deathmatch@ha
	lis 8,.LC110@ha
	lwz 25,84(31)
	lwz 10,deathmatch@l(9)
	la 8,.LC110@l(8)
	lis 11,g_edicts@ha
	lfs 13,0(8)
	lis 0,0x478b
	lfs 0,20(10)
	ori 0,0,48365
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,-1
	bc 12,2,.L302
	addi 26,1,3608
	addi 29,25,188
	mulli 23,30,4596
	addi 27,1,1704
	li 5,512
	mr 4,29
	mr 3,26
	crxor 6,6,6
	bl memcpy
	addi 28,25,1808
	mr 24,29
	mr 3,25
	mr 20,27
	bl InitClientPersistant
	mr 29,28
	addi 21,25,20
	mr 4,26
	mr 3,31
	addi 30,1,72
	addi 26,25,3456
	bl ClientUserinfoChanged
	mr 3,27
	mr 4,28
	li 5,1892
	crxor 6,6,6
	bl memcpy
	b .L303
.L302:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L304
	addi 28,1,1704
	addi 27,25,1808
	mulli 23,30,4596
	addi 29,1,4120
	mr 4,27
	li 5,1892
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 22,29
	mr 20,28
	addi 0,25,188
	mr 3,29
	mr 4,0
	mr 24,0
	li 5,512
	mr 29,27
	crxor 6,6,6
	bl memcpy
	addi 21,25,20
	addi 26,25,3456
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	addi 30,1,72
	addi 9,9,56
	addi 10,1,2260
	addi 11,25,744
.L331:
	lwz 0,0(9)
	addi 9,9,72
	andi. 8,0,16
	bc 12,2,.L307
	lwz 0,0(11)
	stw 0,0(10)
.L307:
	addi 10,10,4
	addi 11,11,4
	bdnz .L331
	mr 4,20
	li 5,1620
	mr 3,24
	crxor 6,6,6
	bl memcpy
	mr 4,22
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3328(1)
	lwz 0,1804(25)
	cmpw 0,9,0
	bc 4,1,.L303
	stw 9,1804(25)
	b .L303
.L304:
	addi 29,1,1704
	li 4,0
	mulli 23,30,4596
	mr 3,29
	li 5,1892
	crxor 6,6,6
	bl memset
	mr 20,29
	addi 24,25,188
	addi 29,25,1808
	addi 30,1,72
	addi 21,25,20
	addi 26,25,3456
.L303:
	mr 4,24
	li 5,1620
	mr 3,30
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,4596
	mr 3,25
	crxor 6,6,6
	bl memset
	mr 4,30
	mr 3,24
	li 5,1620
	crxor 6,6,6
	bl memcpy
	lwz 0,728(25)
	cmpwi 0,0,0
	bc 12,1,.L313
	mr 3,25
	bl InitClientPersistant
.L313:
	mr 3,29
	mr 4,20
	li 5,1892
	crxor 6,6,6
	bl memcpy
	lwz 11,84(31)
	lwz 0,728(11)
	stw 0,480(31)
	lwz 9,732(11)
	stw 9,484(31)
	lwz 0,736(11)
	cmpwi 0,0,0
	bc 12,2,.L314
	lwz 0,264(31)
	ori 0,0,4096
	stw 0,264(31)
.L314:
	lis 9,coop@ha
	lis 8,.LC110@ha
	lwz 11,coop@l(9)
	la 8,.LC110@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L316
	lwz 9,84(31)
	lwz 0,1804(9)
	stw 0,3432(9)
.L316:
	lis 9,sv_arenaflags@ha
	lis 0,0x201
	lwz 10,sv_arenaflags@l(9)
	li 11,4
	li 30,2
	ori 0,0,3
	stw 11,260(31)
	stw 0,252(31)
	stw 30,248(31)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,4648(1)
	lwz 9,4652(1)
	andi. 11,9,1
	bc 12,2,.L317
	mr 3,31
	bl arenaSpawn
.L317:
	li 7,0
	lis 11,game+1028@ha
	lwz 6,264(31)
	stw 7,552(31)
	lis 9,.LC107@ha
	li 8,200
	lwz 3,game+1028@l(11)
	la 9,.LC107@l(9)
	li 0,22
	li 11,1
	stw 0,508(31)
	lis 29,level+4@ha
	stw 11,88(31)
	add 3,3,23
	lis 10,player_pain@ha
	lis 11,.LC111@ha
	stw 9,280(31)
	la 10,player_pain@l(10)
	stw 8,400(31)
	la 11,.LC111@l(11)
	lis 9,player_die@ha
	stw 3,84(31)
	la 9,player_die@l(9)
	rlwinm 6,6,0,21,19
	stw 7,492(31)
	li 4,0
	li 5,184
	stw 30,512(31)
	lfs 0,level+4@l(29)
	lfs 13,0(11)
	lfs 12,24(1)
	lis 11,.LC108@ha
	lfs 11,28(1)
	la 11,.LC108@l(11)
	fadds 0,0,13
	lfs 10,32(1)
	lfs 13,16(1)
	lfs 9,8(1)
	lfs 8,12(1)
	lwz 0,184(31)
	stfs 0,404(31)
	rlwinm 0,0,0,31,29
	stw 11,268(31)
	stw 10,452(31)
	stw 9,456(31)
	stw 0,184(31)
	stfs 13,196(31)
	stfs 12,200(31)
	stfs 11,204(31)
	stfs 10,208(31)
	stw 7,608(31)
	stw 6,264(31)
	stfs 9,188(31)
	stfs 8,192(31)
	stw 7,612(31)
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 8,.LC112@ha
	lfs 0,40(1)
	la 8,.LC112@l(8)
	mr 11,9
	lbz 0,16(25)
	lfs 10,0(8)
	mr 10,9
	andi. 0,0,191
	lis 8,deathmatch@ha
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4648(1)
	lwz 9,4652(1)
	sth 9,4(25)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4648(1)
	lwz 11,4652(1)
	sth 11,6(25)
	lfs 0,48(1)
	stb 0,16(25)
	lwz 9,deathmatch@l(8)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4648(1)
	lwz 10,4652(1)
	sth 10,8(25)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L318
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4648(1)
	lwz 11,4652(1)
	andi. 0,11,32768
	bc 4,2,.L332
.L318:
	lis 4,.LC109@ha
	mr 3,24
	la 4,.LC109@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4652(1)
	lis 0,0x4330
	lis 8,.LC113@ha
	la 8,.LC113@l(8)
	stw 0,4648(1)
	lis 11,.LC114@ha
	lfd 13,0(8)
	la 11,.LC114@l(11)
	lfd 0,4648(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(25)
	bc 4,0,.L320
.L332:
	lis 0,0x42b4
	stw 0,112(25)
	b .L319
.L320:
	lis 8,.LC115@ha
	la 8,.LC115@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L319
	stfs 13,112(25)
.L319:
	lis 9,gi+32@ha
	lwz 11,1792(25)
	li 29,0
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 10,g_edicts@ha
	lis 11,0x478b
	stw 3,88(25)
	lwz 9,g_edicts@l(10)
	ori 11,11,48365
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
	lis 9,.LC116@ha
	lfs 13,48(1)
	li 0,3
	la 9,.LC116@l(9)
	lfs 11,40(1)
	lis 11,.LC117@ha
	mtctr 0
	lfs 9,0(9)
	la 11,.LC117@l(11)
	mr 5,19
	lis 9,.LC114@ha
	lfs 12,44(1)
	mr 8,26
	la 9,.LC114@l(9)
	lfs 10,0(11)
	mr 10,21
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
.L330:
	lfsx 0,11,5
	lfsx 12,11,8
	addi 11,11,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4648(1)
	lwz 9,4652(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L330
	lfs 0,60(1)
	li 0,0
	mr 3,31
	stw 0,24(31)
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(25)
	lfs 0,20(31)
	stfs 0,32(25)
	lfs 13,24(31)
	stfs 13,36(25)
	lfs 0,16(31)
	stfs 0,3876(25)
	lfs 13,20(31)
	stfs 13,3880(25)
	lfs 0,24(31)
	stfs 0,3884(25)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1792(25)
	mr 3,31
	stw 0,3772(25)
	bl ChangeWeapon
	lis 11,sv_utilflags@ha
	li 0,-1
	lwz 10,sv_utilflags@l(11)
	stw 0,4004(25)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,4648(1)
	lwz 9,4652(1)
	andi. 0,9,16
	bc 4,2,.L329
	mr 3,31
	bl DisplayRespawnLine
.L329:
	lwz 0,4724(1)
	mtlr 0
	lmw 19,4660(1)
	lfd 31,4712(1)
	la 1,4720(1)
	blr
.Lfe10:
	.size	 PutClientInServer,.Lfe10-PutClientInServer
	.section	".rodata"
	.align 2
.LC118:
	.string	"%s entered the game\n"
	.align 2
.LC119:
	.string	"spectator"
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	bl G_InitEdict
	lwz 29,84(31)
	li 4,0
	li 5,1892
	addi 28,29,1808
	lwz 27,3476(29)
	lwz 26,3568(29)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	addi 4,29,188
	lwz 0,level@l(9)
	li 5,1620
	mr 3,28
	stw 0,3428(29)
	crxor 6,6,6
	bl memcpy
	li 0,1
	lis 9,gi@ha
	stw 27,3476(29)
	stw 0,3480(29)
	lis 4,.LC118@ha
	li 3,2
	stw 26,3568(29)
	la 4,.LC118@l(4)
	la 28,gi@l(9)
	lwz 0,gi@l(9)
	lwz 5,84(31)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	mr 3,31
	bl ExpertPlayerLevelInits
	mr 3,31
	bl PutClientInServer
	mr 3,31
	bl ClientEndServerFrame
	lwz 3,84(31)
	lis 4,.LC119@ha
	la 4,.LC119@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	bl atoi
	cmpwi 0,3,0
	bc 12,2,.L335
	mr 3,31
	bl PlayerToObserver
	b .L333
.L335:
	lwz 9,100(28)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x478b
	lwz 10,104(28)
	lwz 3,g_edicts@l(9)
	ori 0,0,48365
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(28)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(28)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L333:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 ClientBeginDeathmatch,.Lfe11-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC120:
	.long 0x0
	.align 2
.LC121:
	.long 0x47800000
	.align 2
.LC122:
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
	lis 0,0x478b
	lis 10,deathmatch@ha
	ori 0,0,48365
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC120@ha
	srawi 9,9,2
	la 10,.LC120@l(10)
	mulli 9,9,4596
	lfs 13,0(10)
	addi 9,9,-4596
	add 8,8,9
	stw 8,84(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L337
	bl ClientBeginDeathmatch
	b .L336
.L337:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L338
	lis 9,.LC121@ha
	lis 10,.LC122@ha
	li 11,3
	la 9,.LC121@l(9)
	la 10,.LC122@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L349:
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
	bdnz .L349
	b .L344
.L338:
	mr 3,31
	bl G_InitEdict
	lwz 29,84(31)
	lis 9,.LC107@ha
	li 4,0
	la 9,.LC107@l(9)
	li 5,1892
	stw 9,280(31)
	addi 28,29,1808
	lwz 27,3476(29)
	mr 3,28
	lwz 26,3568(29)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1620
	stw 0,3428(29)
	crxor 6,6,6
	bl memcpy
	li 0,1
	stw 27,3476(29)
	mr 3,31
	stw 0,3480(29)
	stw 26,3568(29)
	bl PutClientInServer
.L344:
	lis 10,.LC120@ha
	lis 9,level+200@ha
	la 10,.LC120@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L346
	mr 3,31
	bl MoveClientToIntermission
	b .L347
.L346:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L347
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x478b
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,48365
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
	lis 4,.LC118@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC118@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L347:
	mr 3,31
	bl ClientEndServerFrame
.L336:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 ClientBegin,.Lfe12-ClientBegin
	.section	".rodata"
	.align 2
.LC123:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC124:
	.string	"name"
	.align 2
.LC125:
	.string	"%s changed name to %s\n"
	.align 2
.LC126:
	.string	"%s\\%s"
	.align 2
.LC127:
	.string	"hand"
	.align 2
.LC128:
	.long 0x0
	.align 3
.LC129:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC130:
	.long 0x3f800000
	.align 2
.LC131:
	.long 0x43200000
	.section	".text"
	.align 2
	.globl ClientUserinfoChanged
	.type	 ClientUserinfoChanged,@function
ClientUserinfoChanged:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,g_edicts@ha
	mr 31,3
	lwz 0,g_edicts@l(9)
	lis 11,0x478b
	mr 27,4
	ori 11,11,48365
	mr 3,27
	subf 0,0,31
	mullw 0,0,11
	srawi 28,0,2
	bl Info_Validate
	addi 26,28,-1
	cmpwi 0,3,0
	bc 4,2,.L351
	lis 11,.LC123@ha
	lwz 0,.LC123@l(11)
	la 9,.LC123@l(11)
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
.L351:
	lis 4,.LC124@ha
	mr 3,27
	la 4,.LC124@l(4)
	bl Info_ValueForKey
	lwz 9,84(31)
	mr 30,3
	li 5,15
	mr 4,30
	addi 3,9,700
	bl strncpy
	lwz 3,84(31)
	addi 4,3,3484
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L352
	lwz 3,84(31)
	addi 3,3,3484
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L353
	lis 9,gi@ha
	lwz 6,84(31)
	lis 5,.LC125@ha
	la 9,gi@l(9)
	li 3,0
	lwz 0,8(9)
	addi 7,6,700
	li 4,2
	la 5,.LC125@l(5)
	addi 6,6,3484
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 3,84(31)
	addi 4,3,700
	addi 3,3,3484
	bl gsPlayerNameChange
.L353:
	mr 3,30
	addi 28,28,1567
	crxor 6,6,6
	bl va
	li 0,0
	lis 29,gi@ha
	stb 0,12(3)
	la 29,gi@l(29)
	bl greenText
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L352:
	lwz 3,84(31)
	mr 4,30
	li 5,15
	addi 3,3,3484
	bl strncpy
	lwz 3,84(31)
	li 5,511
	mr 4,27
	addi 3,3,188
	bl strncpy
	lis 4,.LC21@ha
	mr 3,27
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	mr 30,3
	bl teamplayEnabled
	cmpwi 0,3,0
	bc 12,2,.L354
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,256
	bc 12,2,.L354
	mr 3,31
	bl playerIsOnATeam
	cmpwi 0,3,0
	bc 12,2,.L356
	lwz 3,84(31)
	mr 4,30
	addi 3,3,3500
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L356
	mr 3,31
	bl enforceTeamModelSkin
	b .L356
.L354:
	lwz 4,84(31)
	lis 29,gi@ha
	lis 3,.LC126@ha
	la 29,gi@l(29)
	la 3,.LC126@l(3)
	addi 4,4,700
	mr 5,30
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,26,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L356:
	lwz 3,84(31)
	mr 4,30
	addi 3,3,3500
	bl strcpy
	lis 9,.LC128@ha
	lis 11,deathmatch@ha
	la 9,.LC128@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L357
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L357
	lwz 9,84(31)
	b .L363
.L357:
	lis 4,.LC109@ha
	mr 3,27
	la 4,.LC109@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(31)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC129@ha
	la 10,.LC129@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC130@ha
	la 10,.LC130@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(31)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L359
.L363:
	lis 0,0x42b4
	stw 0,112(9)
	b .L358
.L359:
	lis 11,.LC131@ha
	la 11,.LC131@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L358
	stfs 13,112(9)
.L358:
	lis 4,.LC127@ha
	mr 3,27
	la 4,.LC127@l(4)
	bl Info_ValueForKey
	mr 30,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L362
	mr 3,30
	bl atoi
	lwz 9,84(31)
	stw 3,716(9)
.L362:
	mr 3,31
	bl ShowGun
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 ClientUserinfoChanged,.Lfe13-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC132:
	.string	"ip"
	.align 2
.LC133:
	.string	"rejmsg"
	.align 2
.LC134:
	.string	"Banned."
	.align 2
.LC135:
	.string	"password"
	.align 2
.LC136:
	.string	"none"
	.align 2
.LC137:
	.string	"Reconnect detected!  Calling disconnect.\n"
	.align 2
.LC138:
	.string	"Player marked for forwarding.\n"
	.align 2
.LC139:
	.string	"%s connected\n"
	.align 3
.LC140:
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
	lis 4,.LC132@ha
	mr 3,30
	la 4,.LC132@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L365
	lis 4,.LC133@ha
	lis 5,.LC134@ha
	mr 3,30
	la 4,.LC133@l(4)
	la 5,.LC134@l(5)
	bl Info_SetValueForKey
	li 3,0
	b .L375
.L365:
	lis 4,.LC135@ha
	mr 3,30
	la 4,.LC135@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(29)
	mr 28,3
	lis 4,.LC136@ha
	la 4,.LC136@l(4)
	lwz 3,4(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L366
	lwz 9,password@l(29)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	lwz 3,4(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L366
	lwz 9,password@l(29)
	mr 4,28
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L366
	li 3,0
	b .L375
.L366:
	lis 11,g_edicts@ha
	lis 0,0x478b
	lwz 9,g_edicts@l(11)
	ori 0,0,48365
	lis 11,game@ha
	subf 9,9,31
	la 25,game@l(11)
	mullw 9,9,0
	lwz 11,1028(25)
	srawi 9,9,2
	mulli 9,9,4596
	addi 9,9,-4596
	add 11,11,9
	stw 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,1
	bc 4,2,.L368
	lis 9,gi+4@ha
	lis 3,.LC137@ha
	lwz 0,gi+4@l(9)
	la 3,.LC137@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl ClientDisconnect
.L368:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L369
	lwz 9,84(31)
	li 0,-1
	li 4,0
	li 5,1892
	stw 0,3476(9)
	lwz 29,84(31)
	addi 28,29,1808
	lwz 27,3476(29)
	lwz 26,3568(29)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1620
	stw 0,3428(29)
	crxor 6,6,6
	bl memcpy
	li 0,1
	stw 27,3476(29)
	stw 0,3480(29)
	stw 26,3568(29)
	lwz 0,1560(25)
	cmpwi 0,0,0
	bc 12,2,.L372
	lwz 9,84(31)
	lwz 0,1792(9)
	cmpwi 0,0,0
	bc 4,2,.L371
.L372:
	lwz 3,84(31)
	bl InitClientPersistant
.L371:
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,64
	bc 12,2,.L369
	lis 9,g_edicts@ha
	lis 11,0x478b
	lwz 0,g_edicts@l(9)
	ori 11,11,48365
	lis 7,0x4330
	lis 9,.LC140@ha
	subf 0,0,31
	la 9,.LC140@l(9)
	mullw 0,0,11
	lfd 13,0(9)
	lis 9,maxclients@ha
	srawi 0,0,2
	lwz 10,maxclients@l(9)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 7,24(1)
	lfd 0,24(1)
	lfs 12,20(10)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,2,.L369
	lis 9,gi+4@ha
	lis 3,.LC138@ha
	lwz 0,gi+4@l(9)
	la 3,.LC138@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	stw 0,3568(9)
.L369:
	mr 4,30
	mr 3,31
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L374
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC139@ha
	lwz 0,gi@l(9)
	la 4,.LC139@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L374:
	lwz 11,84(31)
	li 0,1
	li 3,1
	stw 0,720(11)
	lwz 9,84(31)
	stw 0,724(9)
.L375:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 ClientConnect,.Lfe14-ClientConnect
	.section	".rodata"
	.align 2
.LC141:
	.string	"%s disconnected\n"
	.align 2
.LC142:
	.string	"disconnected"
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L376
	lis 26,g_edicts@ha
	bl ExpertPlayerDisconnect
	lis 27,0x478b
	lis 25,.LC22@ha
	lis 28,gi@ha
	lwz 5,84(31)
	lis 4,.LC141@ha
	lwz 9,gi@l(28)
	la 4,.LC141@l(4)
	li 3,2
	addi 5,5,700
	la 28,gi@l(28)
	mtlr 9
	ori 27,27,48365
	crxor 6,6,6
	blrl
	lwz 9,100(28)
	li 3,1
	mtlr 9
	blrl
	lwz 3,g_edicts@l(26)
	lwz 9,104(28)
	subf 3,3,31
	mullw 3,3,27
	mtlr 9
	srawi 3,3,2
	blrl
	lwz 9,100(28)
	li 3,10
	mtlr 9
	blrl
	lwz 9,88(28)
	li 4,2
	addi 3,31,4
	mtlr 9
	blrl
	lwz 9,76(28)
	mr 3,31
	mtlr 9
	blrl
	lis 9,.LC142@ha
	lwz 29,g_edicts@l(26)
	li 0,0
	la 9,.LC142@l(9)
	lwz 11,84(31)
	li 10,2
	stw 9,280(31)
	subf 29,29,31
	la 4,.LC22@l(25)
	stw 0,40(31)
	mullw 29,29,27
	stw 0,248(31)
	stw 0,88(31)
	srawi 29,29,2
	stw 0,720(11)
	addi 3,29,1311
	lwz 9,84(31)
	stw 10,724(9)
	lwz 9,24(28)
	mtlr 9
	blrl
	lwz 0,24(28)
	addi 3,29,1567
	la 4,.LC22@l(25)
	mtlr 0
	blrl
.L376:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ClientDisconnect,.Lfe15-ClientDisconnect
	.section	".rodata"
	.align 2
.LC143:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC144:
	.string	"ucmd->angles:        %d %d %d\npmove->delta_angles: %d %d %d\nv_angle:             %.1f %.1f %.1f\n"
	.align 2
.LC145:
	.string	"kick"
	.align 2
.LC146:
	.string	"Proxy bots not allowed."
	.align 2
.LC147:
	.string	"Appears to be using a bot"
	.align 2
.LC148:
	.string	"WARNING: Client %s appears to be using a bot; sent impulse %d\nIP is %s\n"
	.align 2
.LC151:
	.string	"mutant/mutsght1.wav"
	.align 2
.LC152:
	.string	"*jump1.wav"
	.align 3
.LC149:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC150:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC153:
	.long 0x0
	.align 3
.LC154:
	.long 0x40140000
	.long 0x0
	.align 3
.LC155:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC156:
	.long 0x41000000
	.align 3
.LC157:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC158:
	.long 0x447a0000
	.align 2
.LC159:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-320(1)
	mflr 0
	stfd 31,312(1)
	stmw 22,272(1)
	stw 0,324(1)
	mr 30,3
	lis 9,level+292@ha
	stw 30,level+292@l(9)
	mr 25,4
	lbz 0,14(25)
	lwz 31,84(30)
	cmpwi 0,0,0
	bc 12,2,.L402
	lis 9,botaction@ha
	lis 4,.LC145@ha
	lwz 11,botaction@l(9)
	la 4,.LC145@l(4)
	lwz 3,4(11)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L403
	lis 4,.LC146@ha
	lis 5,.LC147@ha
	la 4,.LC146@l(4)
	la 5,.LC147@l(5)
	mr 3,30
	bl BootPlayer
.L403:
	lwz 28,84(30)
	lis 29,gi@ha
	lis 4,.LC132@ha
	la 29,gi@l(29)
	la 4,.LC132@l(4)
	lbz 27,14(25)
	addi 3,28,188
	addi 28,28,700
	bl Info_ValueForKey
	mr 6,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC148@ha
	mr 5,27
	la 3,.LC148@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L402:
	lis 9,level@ha
	lis 11,.LC153@ha
	la 11,.LC153@l(11)
	la 9,level@l(9)
	lfs 13,0(11)
	lfs 0,200(9)
	fcmpu 0,0,13
	bc 12,2,.L404
	li 0,4
	lis 11,.LC154@ha
	stw 0,0(31)
	la 11,.LC154@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L401
	lbz 0,1(25)
	andi. 11,0,128
	bc 12,2,.L401
	li 0,1
	stw 0,208(9)
	b .L401
.L404:
	lwz 0,4028(31)
	cmpwi 0,0,1
	bc 4,2,.L406
	mr 3,30
	bl Pull_Grapple
.L406:
	lwz 0,3564(31)
	cmpwi 0,0,0
	bc 4,2,.L407
	lis 9,level@ha
	lwz 11,3428(31)
	lwz 0,level@l(9)
	subf 0,11,0
	cmpwi 0,0,50
	bc 4,1,.L407
	mr 3,30
	bl ExpertPlayerDelayedInits
.L407:
	lis 9,pm_passent@ha
	mr 3,30
	stw 30,pm_passent@l(9)
	bl IsObserver
	cmpwi 0,3,0
	bc 12,2,.L408
	lbz 0,1(25)
	andi. 9,0,1
	bc 12,2,.L408
	lis 11,level@ha
	lwz 10,84(30)
	lis 9,.LC149@ha
	la 29,level@l(11)
	lfd 12,.LC149@l(9)
	lfs 13,4060(10)
	lfs 0,4(29)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L408
	mr 3,30
	bl ToggleChaseCam
	lfs 0,4(29)
	b .L469
.L408:
	lwz 9,84(30)
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L409
	lha 0,2(25)
	lis 8,0x4330
	lis 9,.LC155@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC155@l(9)
	stw 0,268(1)
	stw 8,264(1)
	lfd 12,0(9)
	lfd 0,264(1)
	lis 9,.LC150@ha
	lfd 13,.LC150@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3456(31)
	lha 0,4(25)
	xoris 0,0,0x8000
	stw 0,268(1)
	stw 8,264(1)
	lfd 0,264(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3460(31)
	lha 0,6(25)
	xoris 0,0,0x8000
	stw 0,268(1)
	stw 8,264(1)
	lfd 0,264(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3464(31)
	lha 0,12(25)
	cmpwi 0,0,9
	bc 4,1,.L401
	lis 11,level@ha
	lwz 10,84(30)
	lis 9,.LC149@ha
	la 31,level@l(11)
	lfd 12,.LC149@l(9)
	lfs 13,4060(10)
	lfs 0,4(31)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L401
	mr 3,30
	bl ChaseNext
	lfs 0,4(31)
.L469:
	lwz 9,84(30)
	stfs 0,4060(9)
	b .L401
.L409:
	addi 3,1,8
	li 4,0
	mr 28,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L417
	lwz 0,40(30)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L417
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L415
	li 0,2
	b .L417
.L415:
	lis 10,sv_paused@ha
	lwz 9,sv_paused@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
	cmpwi 0,11,1
	bc 4,2,.L417
	li 0,4
.L417:
	stw 0,0(31)
	lis 10,sv_paused@ha
	lwz 9,sv_paused@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
	cmpwi 0,11,0
	bc 12,2,.L419
	lwz 0,260(30)
	cmpwi 0,0,4
	bc 4,2,.L419
	lhz 0,4584(31)
	sth 0,2(25)
	lhz 9,4586(31)
	sth 9,4(25)
	lhz 0,4588(31)
	sth 0,6(25)
.L419:
	lhz 0,2(25)
	lwz 11,4028(31)
	sth 0,4584(31)
	lhz 9,4(25)
	cmpwi 0,11,0
	sth 9,4586(31)
	lhz 0,6(25)
	sth 0,4588(31)
	bc 12,2,.L420
	li 0,0
	sth 0,18(31)
	b .L421
.L420:
	lis 10,sv_gravity@ha
	lwz 9,sv_gravity@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
	sth 11,18(31)
.L421:
	lwz 0,0(31)
	addi 24,1,12
	addi 22,30,4
	lwz 9,4(31)
	addi 26,1,18
	addi 23,30,376
	lwz 11,8(31)
	mr 3,24
	mr 5,22
	lwz 10,12(31)
	mr 4,26
	mr 6,23
	stw 0,8(1)
	addi 29,31,3700
	addi 27,1,36
	stw 9,4(28)
	li 7,0
	li 8,0
	stw 11,8(28)
	lis 9,.LC156@ha
	la 9,.LC156@l(9)
	li 11,3
	stw 10,12(28)
	lfs 10,0(9)
	mtctr 11
	lwz 0,16(31)
	lwz 9,20(31)
	lwz 11,24(31)
	stw 0,16(28)
	stw 9,20(28)
	stw 11,24(28)
.L468:
	lfsx 13,7,5
	lfsx 0,7,6
	mr 9,11
	addi 7,7,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,264(1)
	lwz 11,268(1)
	stfd 11,264(1)
	lwz 9,268(1)
	sthx 11,8,3
	sthx 9,8,4
	addi 8,8,2
	bdnz .L468
	mr 3,29
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L427
	li 0,1
	stw 0,52(1)
.L427:
	lis 9,gi@ha
	lwz 7,0(25)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(25)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lwz 8,8(25)
	lwz 0,12(25)
	mtlr 5
	stw 7,36(1)
	lwz 10,52(9)
	stw 0,12(27)
	stw 6,4(27)
	stw 8,8(27)
	stw 11,240(1)
	stw 10,244(1)
	blrl
	lis 9,.LC155@ha
	lwz 11,8(1)
	mr 27,24
	la 9,.LC155@l(9)
	lwz 10,4(28)
	mr 3,26
	lfd 11,0(9)
	mr 4,22
	lis 6,0x4330
	lis 9,.LC157@ha
	lwz 0,8(28)
	mr 5,23
	la 9,.LC157@l(9)
	li 7,0
	lfd 12,0(9)
	li 8,0
	lwz 9,12(28)
	stw 11,0(31)
	li 11,3
	stw 10,4(31)
	stw 0,8(31)
	mtctr 11
	stw 9,12(31)
	lwz 0,16(28)
	lwz 9,20(28)
	lwz 11,24(28)
	stw 0,16(31)
	stw 9,20(31)
	stw 11,24(31)
	lwz 0,8(1)
	lwz 9,4(28)
	lwz 11,8(28)
	lwz 10,12(28)
	stw 0,3700(31)
	stw 9,4(29)
	stw 11,8(29)
	stw 10,12(29)
	lwz 0,24(28)
	lwz 9,16(28)
	lwz 11,20(28)
	stw 0,24(29)
	stw 9,16(29)
	stw 11,20(29)
.L467:
	lhax 0,7,27
	lhax 9,7,3
	mr 10,11
	xoris 0,0,0x8000
	addi 7,7,2
	stw 0,268(1)
	xoris 9,9,0x8000
	stw 6,264(1)
	lfd 13,264(1)
	stw 9,268(1)
	stw 6,264(1)
	lfd 0,264(1)
	fsub 13,13,11
	fsub 0,0,11
	fmul 13,13,12
	fmul 0,0,12
	frsp 13,13
	frsp 0,0
	stfsx 13,8,4
	stfsx 0,8,5
	addi 8,8,4
	bdnz .L467
	lfs 0,216(1)
	mr 9,11
	lis 7,0x4330
	lfs 13,220(1)
	lis 11,.LC155@ha
	lis 8,.LC150@ha
	lfs 9,204(1)
	la 11,.LC155@l(11)
	lfs 10,208(1)
	lfs 11,212(1)
	lfs 12,224(1)
	stfs 0,200(30)
	stfs 13,204(30)
	stfs 9,188(30)
	stfs 10,192(30)
	stfs 11,196(30)
	stfs 12,208(30)
	lha 0,2(25)
	lfd 8,0(11)
	xoris 0,0,0x8000
	lfd 13,.LC150@l(8)
	stw 0,268(1)
	mr 10,11
	stw 7,264(1)
	lfd 0,264(1)
	fsub 0,0,8
	fmul 0,0,13
	frsp 0,0
	stfs 0,3456(31)
	lha 0,4(25)
	xoris 0,0,0x8000
	stw 0,268(1)
	stw 7,264(1)
	lfd 0,264(1)
	fsub 0,0,8
	fmul 0,0,13
	frsp 0,0
	stfs 0,3460(31)
	lha 0,6(25)
	xoris 0,0,0x8000
	stw 0,268(1)
	stw 7,264(1)
	lfd 0,264(1)
	fsub 0,0,8
	fmul 0,0,13
	frsp 0,0
	stfs 0,3464(31)
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 12,2,.L433
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L433
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L433
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L433
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
	andi. 0,11,8
	bc 12,2,.L434
	lis 11,level@ha
	lwz 3,84(30)
	lwz 0,level@l(11)
	lfs 13,3952(3)
	xoris 0,0,0x8000
	stw 0,268(1)
	stw 7,264(1)
	lfd 0,264(1)
	fsub 0,0,8
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L434
	addi 29,1,248
	li 6,0
	mr 4,29
	addi 3,3,3876
	li 5,0
	bl AngleVectors
	lis 9,.LC158@ha
	mr 3,23
	la 9,.LC158@l(9)
	mr 5,3
	lfs 1,0(9)
	mr 4,29
	bl VectorMA
	lis 29,gi@ha
	lis 3,.LC151@ha
	la 29,gi@l(29)
	la 3,.LC151@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC159@ha
	lwz 0,16(29)
	lis 11,.LC159@ha
	la 9,.LC159@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC159@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC153@ha
	mr 3,30
	lfs 2,0(11)
	la 9,.LC153@l(9)
	lfs 3,0(9)
	blrl
	b .L435
.L434:
	lis 29,gi@ha
	lis 3,.LC152@ha
	la 29,gi@l(29)
	la 3,.LC152@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC159@ha
	lwz 0,16(29)
	lis 11,.LC159@ha
	la 9,.LC159@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC159@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC153@ha
	mr 3,30
	lfs 2,0(11)
	la 9,.LC153@l(9)
	lfs 3,0(9)
	blrl
.L435:
	mr 4,22
	mr 3,30
	li 5,0
	bl PlayerNoise
.L433:
	lis 10,sv_paused@ha
	lwz 9,sv_paused@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
	cmpwi 0,11,1
	bc 12,2,.L436
	lfs 0,200(1)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 9,268(1)
	stw 9,508(30)
.L436:
	lwz 11,228(1)
	lwz 0,236(1)
	lwz 9,232(1)
	cmpwi 0,11,0
	stw 0,612(30)
	stw 9,608(30)
	stw 11,552(30)
	bc 12,2,.L437
	lwz 0,92(11)
	stw 0,556(30)
.L437:
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L438
	lfs 0,3804(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L439
.L438:
	lfs 0,188(1)
	stfs 0,3876(31)
	lfs 13,192(1)
	stfs 13,3880(31)
	lfs 0,196(1)
	stfs 0,3884(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L439:
	lis 9,gi+72@ha
	mr 3,30
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 10,sv_paused@ha
	lwz 9,sv_paused@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
	cmpwi 0,11,1
	bc 4,2,.L440
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 4,2,.L401
.L440:
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L441
	mr 3,30
	bl G_TouchTriggers
.L441:
	lwz 0,56(1)
	li 28,0
	cmpw 0,28,0
	bc 4,0,.L443
	addi 27,1,60
.L445:
	li 11,0
	slwi 0,28,2
	cmpw 0,11,28
	lwzx 29,27,0
	addi 26,28,1
	bc 4,0,.L447
	lwz 0,0(27)
	cmpw 0,0,29
	bc 12,2,.L447
	mr 9,27
.L448:
	addi 11,11,1
	cmpw 0,11,28
	bc 4,0,.L447
	lwzu 0,4(9)
	cmpw 0,0,29
	bc 4,2,.L448
.L447:
	cmpw 0,11,28
	bc 4,2,.L444
	lwz 0,444(29)
	cmpwi 0,0,0
	bc 12,2,.L444
	mr 3,29
	mr 4,30
	mtlr 0
	li 5,0
	li 6,0
	blrl
.L444:
	lwz 0,56(1)
	mr 28,26
	cmpw 0,28,0
	bc 12,0,.L445
.L443:
	lwz 0,3756(31)
	mr 3,30
	lwz 11,3764(31)
	stw 0,3760(31)
	lbz 9,1(25)
	andc 0,9,0
	stw 9,3756(31)
	or 11,11,0
	stw 11,3764(31)
	bl spectatorStateChange
	mr 3,30
	bl IsObserver
	cmpwi 0,3,0
	bc 4,2,.L401
	lis 9,maxclients@ha
	lis 11,.LC153@ha
	lwz 10,maxclients@l(9)
	la 11,.LC153@l(11)
	li 28,0
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,g_edicts@ha
	lwz 9,g_edicts@l(11)
	fcmpu 0,13,0
	addi 29,9,916
	bc 4,0,.L457
	lis 9,.LC155@ha
	lis 27,0x4330
	la 9,.LC155@l(9)
	lfd 31,0(9)
.L459:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L460
	lwz 9,84(29)
	lwz 0,3988(9)
	cmpw 0,0,30
	bc 4,2,.L460
	mr 3,29
	bl UpdateChaseCam
.L460:
	addi 28,28,1
	lwz 11,maxclients@l(26)
	xoris 0,28,0x8000
	addi 29,29,916
	stw 0,268(1)
	stw 27,264(1)
	lfd 0,264(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L459
.L457:
	lbz 0,15(25)
	stw 0,640(30)
	lwz 9,3764(31)
	andi. 0,9,1
	bc 12,2,.L462
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L462
	lwz 0,3768(31)
	cmpwi 0,0,0
	bc 4,2,.L462
	li 0,1
	mr 3,30
	stw 0,3768(31)
	bl Think_Weapon
.L462:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
	andis. 0,11,0x3
	bc 12,2,.L464
	mr 3,30
	bl regen
.L464:
	lis 9,sv_expflags@ha
	lwz 11,sv_expflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 9,268(1)
	andi. 0,9,2080
	bc 12,2,.L465
	lwz 9,84(30)
	lwz 0,3756(9)
	andi. 9,0,2
	bc 12,2,.L465
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L465
	lis 9,level@ha
	lwz 11,4044(31)
	lwz 0,level@l(9)
	cmpw 0,11,0
	bc 12,1,.L465
	mr 3,30
	bl Throw_Grapple
.L465:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
	andi. 0,11,32
	bc 12,2,.L401
	mr 3,31
	bl Ended_Grappling
	cmpwi 0,3,0
	bc 12,2,.L401
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L401
	lwz 3,4020(31)
	cmpwi 0,3,0
	bc 12,2,.L401
	bl Release_Grapple
.L401:
	lwz 0,324(1)
	mtlr 0
	lmw 22,272(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe16:
	.size	 ClientThink,.Lfe16-ClientThink
	.section	".rodata"
	.align 2
.LC160:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC160@ha
	lis 9,level+200@ha
	la 11,.LC160@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L470
	lis 10,sv_paused@ha
	lwz 9,sv_paused@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	cmpwi 0,11,1
	bc 4,2,.L472
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L470
.L472:
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,32
	bc 4,2,.L473
	lwz 9,84(31)
	lwz 0,3564(9)
	cmpwi 0,0,0
	bc 12,2,.L473
	mr 3,31
	bl ExpertBotDetect
.L473:
	lwz 0,260(31)
	lwz 30,84(31)
	cmpwi 0,0,1
	bc 12,2,.L486
	lwz 0,3768(30)
	cmpwi 0,0,0
	bc 4,2,.L475
	mr 3,31
	bl Think_Weapon
	b .L476
.L475:
	li 0,0
	stw 0,3768(30)
.L476:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L477
	lis 9,level@ha
	lfs 13,3984(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L470
	lis 9,.LC160@ha
	lis 11,deathmatch@ha
	lwz 10,3764(30)
	la 9,.LC160@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L482
	bc 12,30,.L470
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L470
.L482:
	bc 4,30,.L483
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L484
.L483:
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
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
	lwz 9,level@l(11)
	lwz 10,84(31)
	addi 9,9,1
	stw 9,4044(10)
	lfs 0,4(29)
	lwz 11,84(31)
	stfs 0,3984(11)
	b .L486
.L484:
	lis 9,gi+168@ha
	lis 3,.LC104@ha
	lwz 0,gi+168@l(9)
	la 3,.LC104@l(3)
	mtlr 0
	blrl
	b .L488
.L477:
	lis 9,.LC160@ha
	lis 11,deathmatch@ha
	la 9,.LC160@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L486
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L486
	addi 3,31,28
	bl PlayerTrail_Add
.L488:
.L486:
	li 0,0
	stw 0,3764(30)
.L470:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientBeginServerFrame,.Lfe17-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC161:
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
	lis 11,.LC161@ha
	lis 9,deathmatch@ha
	la 11,.LC161@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L300
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L299
.L300:
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
	bl PutClientInServer
	lwz 11,84(31)
	li 0,6
	li 9,32
	stw 0,80(31)
	li 8,14
	lis 10,level@ha
	stb 9,16(11)
	la 7,level@l(10)
	lwz 11,84(31)
	stb 8,17(11)
	lwz 9,level@l(10)
	lwz 11,84(31)
	addi 9,9,1
	stw 9,4044(11)
	lfs 0,4(7)
	lwz 10,84(31)
	stfs 0,3984(10)
	b .L298
.L299:
	lis 9,gi+168@ha
	lis 3,.LC104@ha
	lwz 0,gi+168@l(9)
	la 3,.LC104@l(3)
	mtlr 0
	blrl
.L298:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 respawn,.Lfe18-respawn
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
	addi 28,29,1808
	lwz 27,3476(29)
	li 5,1892
	lwz 26,3568(29)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1620
	stw 0,3428(29)
	crxor 6,6,6
	bl memcpy
	li 0,1
	stw 27,3476(29)
	stw 0,3480(29)
	stw 26,3568(29)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 InitClientResp,.Lfe19-InitClientResp
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
	lis 11,.LC103@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC103@l(11)
.L288:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L288
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 InitBodyQue,.Lfe20-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe21:
	.size	 player_pain,.Lfe21-player_pain
	.section	".rodata"
	.align 2
.LC162:
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
	lis 9,.LC162@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC162@l(9)
	addi 10,10,916
	lfs 13,0(9)
.L175:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L174
	la 8,game@l(4)
	lwz 0,480(10)
	lwz 9,1028(8)
	add 9,7,9
	stw 0,728(9)
	lwz 11,1028(8)
	lwz 0,484(10)
	add 11,7,11
	stw 0,732(11)
	lwz 9,1028(8)
	lwz 0,264(10)
	add 9,7,9
	rlwinm 0,0,0,19,19
	stw 0,736(9)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L174
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3432(9)
	add 11,7,11
	stw 0,1804(11)
.L174:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,4596
	addi 10,10,916
	cmpw 0,6,0
	bc 12,0,.L175
	blr
.Lfe22:
	.size	 SaveClientData,.Lfe22-SaveClientData
	.section	".rodata"
	.align 2
.LC163:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lwz 11,84(3)
	lwz 0,728(11)
	stw 0,480(3)
	lwz 9,732(11)
	stw 9,484(3)
	lwz 0,736(11)
	cmpwi 0,0,0
	bc 12,2,.L180
	lwz 0,264(3)
	ori 0,0,4096
	stw 0,264(3)
.L180:
	lis 9,.LC163@ha
	lis 11,coop@ha
	la 9,.LC163@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bclr 12,2
	lwz 9,84(3)
	lwz 0,1804(9)
	stw 0,3432(9)
	blr
.Lfe23:
	.size	 FetchClientEntData,.Lfe23-FetchClientEntData
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.section	".rodata"
	.align 2
.LC164:
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
	lis 9,.LC164@ha
	mr 30,3
	la 9,.LC164@l(9)
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
	bl stricmp
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
.Lfe24:
	.size	 SP_FixCoopSpots,.Lfe24-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC165:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC166:
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
	lis 11,.LC166@ha
	lis 9,coop@ha
	la 11,.LC166@l(11)
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
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	lis 9,SP_CreateCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_CreateCoopSpots@l(9)
	lis 11,.LC165@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC165@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 SP_info_player_start,.Lfe25-SP_info_player_start
	.section	".rodata"
	.align 2
.LC167:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC167@ha
	lis 9,deathmatch@ha
	la 11,.LC167@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L22
	bl G_FreeEdict
	b .L21
.L22:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,1
	bc 4,2,.L21
	bl SP_misc_teleporter_dest
.L21:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 SP_info_player_deathmatch,.Lfe26-SP_info_player_deathmatch
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe27:
	.size	 SP_info_player_intermission,.Lfe27-SP_info_player_intermission
	.align 2
	.globl IsFemale
	.type	 IsFemale,@function
IsFemale:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L31
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
	b .L489
.L31:
	li 3,0
.L489:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 IsFemale,.Lfe28-IsFemale
	.section	".rodata"
	.align 3
.LC168:
	.long 0x404ca5dc
	.long 0x1a63c1f8
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
	bc 12,2,.L126
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L126
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L490
.L126:
	cmpwi 0,4,0
	bc 12,2,.L128
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L128
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L490:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L127
.L128:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3804(9)
	b .L125
.L127:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC168@ha
	lwz 11,84(31)
	lfd 0,.LC168@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3804(11)
.L125:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 LookAtKiller,.Lfe29-LookAtKiller
	.section	".rodata"
	.align 2
.LC169:
	.long 0x0
	.section	".text"
	.align 2
	.globl SelectFarthestDeathmatchSpawnPoint
	.type	 SelectFarthestDeathmatchSpawnPoint,@function
SelectFarthestDeathmatchSpawnPoint:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	lis 9,.LC169@ha
	li 31,0
	la 9,.LC169@l(9)
	li 29,0
	lfs 31,0(9)
	b .L216
.L218:
	mr 3,31
	bl PlayersRangeFromSpot
	fcmpu 0,1,31
	bc 4,1,.L216
	fmr 31,1
	mr 29,31
.L216:
	lis 30,.LC99@ha
	mr 3,31
	li 4,280
	la 5,.LC99@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L218
	cmpwi 0,29,0
	mr 3,29
	bc 4,2,.L491
	la 5,.LC99@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L491:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe30-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC170:
	.long 0x0
	.section	".text"
	.align 2
	.globl SelectDeathmatchSpawnPoint
	.type	 SelectDeathmatchSpawnPoint,@function
SelectDeathmatchSpawnPoint:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L223
	lis 9,.LC170@ha
	li 31,0
	la 9,.LC170@l(9)
	li 29,0
	lfs 31,0(9)
	b .L224
.L226:
	mr 3,31
	bl PlayersRangeFromSpot
	fcmpu 0,1,31
	bc 4,1,.L224
	fmr 31,1
	mr 29,31
.L224:
	lis 30,.LC99@ha
	mr 3,31
	li 4,280
	la 5,.LC99@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L226
	cmpwi 0,29,0
	bc 12,2,.L229
	mr 3,29
	b .L492
.L229:
	la 5,.LC99@l(30)
	li 3,0
	li 4,280
	bl G_Find
	b .L493
.L223:
	bl SelectRandomDeathmatchSpawnPoint
.L493:
.L492:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 SelectDeathmatchSpawnPoint,.Lfe31-SelectDeathmatchSpawnPoint
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
	lis 9,0xa434
	lwz 10,game+1028@l(11)
	ori 9,9,38101
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L494
.L236:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L237
	li 3,0
	b .L494
.L237:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L238
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L238:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L236
	addic. 31,31,-1
	bc 4,2,.L236
	mr 3,30
.L494:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 SelectCoopSpawnPoint,.Lfe32-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC171:
	.long 0x3f800000
	.align 2
.LC172:
	.long 0x0
	.align 2
.LC173:
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
	bc 4,0,.L291
	lis 29,gi@ha
	lis 3,.LC85@ha
	la 29,gi@l(29)
	la 3,.LC85@l(3)
	lwz 9,36(29)
	lis 27,.LC86@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC171@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC171@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC171@ha
	la 9,.LC171@l(9)
	lfs 2,0(9)
	lis 9,.LC172@ha
	la 9,.LC172@l(9)
	lfs 3,0(9)
	blrl
.L295:
	mr 3,31
	la 4,.LC86@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L295
	lis 9,.LC173@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC173@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L291:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 body_die,.Lfe33-body_die
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
	bc 4,1,.L379
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L378
.L379:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L378:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 PM_trace,.Lfe34-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L383
.L385:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L385
.L383:
	mr 3,11
	blr
.Lfe35:
	.size	 CheckBlock,.Lfe35-CheckBlock
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
.L496:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L496
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L495:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L495
	lis 3,.LC143@ha
	la 3,.LC143@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 PrintPmove,.Lfe36-PrintPmove
	.align 2
	.globl displayAngles
	.type	 displayAngles,@function
displayAngles:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lis 9,gi+4@ha
	lha 5,4(4)
	lis 3,.LC144@ha
	lfs 1,3876(11)
	la 3,.LC144@l(3)
	lfs 2,3880(11)
	mr 6,5
	lfs 3,3884(11)
	lwz 0,gi+4@l(9)
	lha 4,2(4)
	lha 9,24(11)
	mtlr 0
	lha 7,20(11)
	lha 8,22(11)
	creqv 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 displayAngles,.Lfe37-displayAngles
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
	bl stricmp
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
.Lfe38:
	.size	 SP_CreateCoopSpots,.Lfe38-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
