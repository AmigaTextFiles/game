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
	.globl ORIGINAL_ClientObituary
	.type	 ORIGINAL_ClientObituary,@function
ORIGINAL_ClientObituary:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 11,.LC76@ha
	lis 9,coop@ha
	la 11,.LC76@l(11)
	mr 30,3
	lfs 13,0(11)
	mr 29,5
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L34
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L34
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L34:
	lis 11,.LC76@ha
	lis 9,deathmatch@ha
	la 11,.LC76@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L36
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L35
.L36:
	lis 9,meansOfDeath@ha
	lis 11,.LC22@ha
	lwz 0,meansOfDeath@l(9)
	la 31,.LC22@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	rlwinm 27,0,0,4,4
	addi 10,28,-17
	cmplwi 0,10,16
	bc 12,1,.L37
	lis 11,.L52@ha
	slwi 10,10,2
	la 11,.L52@l(11)
	lis 9,.L52@ha
	lwzx 0,10,11
	la 9,.L52@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L52:
	.long .L41-.L52
	.long .L42-.L52
	.long .L43-.L52
	.long .L40-.L52
	.long .L37-.L52
	.long .L39-.L52
	.long .L38-.L52
	.long .L37-.L52
	.long .L45-.L52
	.long .L45-.L52
	.long .L51-.L52
	.long .L46-.L52
	.long .L51-.L52
	.long .L47-.L52
	.long .L51-.L52
	.long .L37-.L52
	.long .L48-.L52
.L38:
	lis 9,.LC23@ha
	la 6,.LC23@l(9)
	b .L37
.L39:
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
	b .L37
.L40:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L37
.L41:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L37
.L42:
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L37
.L43:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L37
.L45:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L37
.L46:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L37
.L47:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L37
.L48:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L37
.L51:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
.L37:
	cmpw 0,29,30
	bc 4,2,.L54
	addi 10,28,-7
	cmplwi 0,10,17
	bc 12,1,.L71
	lis 11,.L77@ha
	slwi 10,10,2
	la 11,.L77@l(11)
	lis 9,.L77@ha
	lwzx 0,10,11
	la 9,.L77@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L77:
	.long .L58-.L77
	.long .L71-.L77
	.long .L64-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L70-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L58-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L71-.L77
	.long .L56-.L77
.L56:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L54
.L58:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L60
	li 0,0
	b .L61
.L60:
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
.L61:
	cmpwi 0,0,0
	bc 12,2,.L59
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L54
.L59:
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L54
.L64:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L66
	li 0,0
	b .L67
.L66:
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
.L67:
	cmpwi 0,0,0
	bc 12,2,.L65
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L54
.L65:
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L54
.L70:
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L54
.L71:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L73
	li 0,0
	b .L74
.L73:
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
.L74:
	cmpwi 0,0,0
	bc 12,2,.L72
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L54
.L72:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
.L54:
	cmpwi 0,6,0
	bc 12,2,.L78
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
	bc 12,2,.L79
	lwz 10,84(30)
	lis 11,QWLOG@ha
	lwz 0,QWLOG@l(11)
	lwz 9,3424(10)
	cmpwi 0,0,1
	addi 9,9,-1
	stw 9,3424(10)
	bc 4,2,.L79
	lwz 3,84(30)
	addi 3,3,700
	mr 4,3
	bl logFrag
.L79:
	li 0,0
	stw 0,540(30)
	b .L33
.L78:
	cmpwi 0,29,0
	stw 29,540(30)
	bc 12,2,.L35
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L35
	addi 0,28,-1
	cmplwi 0,0,33
	bc 12,1,.L82
	lis 11,.L102@ha
	slwi 10,0,2
	la 11,.L102@l(11)
	lis 9,.L102@ha
	lwzx 0,10,11
	la 9,.L102@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L102:
	.long .L83-.L102
	.long .L84-.L102
	.long .L85-.L102
	.long .L86-.L102
	.long .L87-.L102
	.long .L88-.L102
	.long .L89-.L102
	.long .L90-.L102
	.long .L91-.L102
	.long .L92-.L102
	.long .L93-.L102
	.long .L94-.L102
	.long .L95-.L102
	.long .L96-.L102
	.long .L97-.L102
	.long .L98-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L100-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L99-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L82-.L102
	.long .L101-.L102
.L83:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L82
.L84:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L82
.L85:
	lis 9,.LC45@ha
	lis 11,.LC46@ha
	la 6,.LC45@l(9)
	la 31,.LC46@l(11)
	b .L82
.L86:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L82
.L87:
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 6,.LC48@l(9)
	la 31,.LC49@l(11)
	b .L82
.L88:
	lis 9,.LC50@ha
	lis 11,.LC51@ha
	la 6,.LC50@l(9)
	la 31,.LC51@l(11)
	b .L82
.L89:
	lis 9,.LC52@ha
	lis 11,.LC53@ha
	la 6,.LC52@l(9)
	la 31,.LC53@l(11)
	b .L82
.L90:
	lis 9,.LC54@ha
	lis 11,.LC55@ha
	la 6,.LC54@l(9)
	la 31,.LC55@l(11)
	b .L82
.L91:
	lis 9,.LC56@ha
	lis 11,.LC55@ha
	la 6,.LC56@l(9)
	la 31,.LC55@l(11)
	b .L82
.L92:
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 6,.LC57@l(9)
	la 31,.LC58@l(11)
	b .L82
.L93:
	lis 9,.LC59@ha
	la 6,.LC59@l(9)
	b .L82
.L94:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 31,.LC61@l(11)
	b .L82
.L95:
	lis 9,.LC62@ha
	lis 11,.LC63@ha
	la 6,.LC62@l(9)
	la 31,.LC63@l(11)
	b .L82
.L96:
	lis 9,.LC64@ha
	lis 11,.LC61@ha
	la 6,.LC64@l(9)
	la 31,.LC61@l(11)
	b .L82
.L97:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 6,.LC65@l(9)
	la 31,.LC66@l(11)
	b .L82
.L98:
	lis 9,.LC67@ha
	lis 11,.LC66@ha
	la 6,.LC67@l(9)
	la 31,.LC66@l(11)
	b .L82
.L99:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 6,.LC68@l(9)
	la 31,.LC69@l(11)
	b .L82
.L100:
	lis 9,.LC70@ha
	lis 11,.LC71@ha
	la 6,.LC70@l(9)
	la 31,.LC71@l(11)
	b .L82
.L101:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 6,.LC72@l(9)
	la 31,.LC73@l(11)
.L82:
	cmpwi 0,6,0
	bc 12,2,.L35
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
	bc 12,2,.L33
	cmpwi 0,27,0
	bc 12,2,.L106
	lwz 10,84(29)
	lis 11,QWLOG@ha
	lwz 0,QWLOG@l(11)
	lwz 9,3424(10)
	cmpwi 0,0,1
	addi 9,9,-1
	b .L111
.L106:
	lwz 10,84(29)
	lis 11,QWLOG@ha
	lwz 0,QWLOG@l(11)
	lwz 9,3424(10)
	cmpwi 0,0,1
	addi 9,9,1
.L111:
	stw 9,3424(10)
	bc 4,2,.L33
	lwz 3,84(29)
	lwz 4,84(30)
	addi 3,3,700
	addi 4,4,700
	bl logFrag
	b .L33
.L35:
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
	lwz 11,84(30)
	lwz 9,3424(11)
	addi 9,9,-1
	stw 9,3424(11)
.L33:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ORIGINAL_ClientObituary,.Lfe2-ORIGINAL_ClientObituary
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
	bc 12,2,.L114
	lwz 9,84(30)
	lwz 11,3532(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L117
	lwz 3,40(31)
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L117:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L118
	li 29,0
	b .L119
.L118:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC81@ha
	lfs 12,3728(8)
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
.L119:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC80@ha
	and. 10,0,29
	la 9,.LC80@l(9)
	lfs 31,0(9)
	bc 12,2,.L120
	lis 11,.LC82@ha
	la 11,.LC82@l(11)
	lfs 31,0(11)
.L120:
	cmpwi 0,31,0
	bc 12,2,.L122
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3660(9)
	fsubs 0,0,31
	stfs 0,3660(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3660(9)
	fadds 0,0,31
	stfs 0,3660(9)
	stw 0,284(3)
.L122:
	cmpwi 0,29,0
	bc 12,2,.L114
	lwz 9,84(30)
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	lfs 0,3660(9)
	fadds 0,0,31
	stfs 0,3660(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC81@ha
	lis 11,Touch_Item@ha
	la 9,.LC81@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3660(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC79@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC79@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3660(7)
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
	lfs 0,3728(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L114:
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
i.45:
	.space	4
	.size	 i.45,4
	.section	".rodata"
	.align 2
.LC87:
	.string	"*death%i.wav"
	.align 3
.LC84:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 3
.LC88:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC89:
	.long 0x0
	.align 2
.LC90:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-352(1)
	mflr 0
	stmw 27,332(1)
	stw 0,356(1)
	mr 31,3
	mr 28,4
	lwz 9,84(31)
	mr 30,5
	mr 27,6
	lwz 3,3860(9)
	cmpwi 0,3,0
	bc 12,2,.L130
	bl Release_Grapple
.L130:
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
	stw 11,76(31)
	stw 11,3756(7)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 8,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L131
	lis 9,level+4@ha
	lis 11,.LC88@ha
	lfs 0,level+4@l(9)
	la 11,.LC88@l(11)
	cmpwi 0,30,0
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3812(11)
	bc 12,2,.L132
	lis 9,g_edicts@ha
	xor 11,30,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,30,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L132
	lfs 11,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(30)
	b .L157
.L132:
	cmpwi 0,28,0
	bc 12,2,.L134
	lis 9,g_edicts@ha
	xor 11,28,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,28,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L134
	lfs 11,4(31)
	lfs 13,4(28)
	lfs 12,8(28)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(28)
.L157:
	lfs 11,12(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	b .L133
.L134:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3584(9)
	b .L136
.L133:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC84@ha
	lwz 11,84(31)
	lfd 0,.LC84@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3584(11)
.L136:
	lwz 9,84(31)
	li 0,2
	mr 3,31
	mr 4,28
	mr 5,30
	stw 0,0(9)
	bl ServObitClientObituary
	cmpwi 0,3,0
	bc 4,2,.L138
	mr 3,31
	mr 4,28
	mr 5,30
	bl ORIGINAL_ClientObituary
.L138:
	addi 29,1,24
	lis 4,level@ha
	la 4,level@l(4)
	li 5,304
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lis 3,gi@ha
	mr 7,30
	la 3,gi@l(3)
	mr 4,29
	mr 6,28
	mr 5,31
	bl sl_WriteStdLogDeath
	mr 3,31
	bl TossClientWeapon
	lis 9,.LC89@ha
	lis 11,deathmatch@ha
	la 9,.LC89@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L131
	mr 3,31
	bl Cmd_Help_f
.L131:
	lwz 11,84(31)
	li 0,0
	li 4,0
	li 5,1024
	stw 0,3728(11)
	lwz 9,84(31)
	stw 0,3732(9)
	lwz 11,84(31)
	stw 0,3736(11)
	lwz 9,84(31)
	stw 0,3740(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,0,.L140
	lis 29,gi@ha
	lis 3,.LC85@ha
	la 29,gi@l(29)
	la 3,.LC85@l(3)
	lwz 9,36(29)
	lis 28,.LC86@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC90@ha
	lwz 0,16(29)
	lis 11,.LC90@ha
	la 9,.LC90@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC90@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC89@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC89@l(9)
	lfs 3,0(9)
	blrl
.L144:
	mr 3,31
	la 4,.LC86@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L144
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	stw 30,512(31)
	b .L146
.L140:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L146
	lis 8,i.45@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.45@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.45@l(8)
	stw 7,3716(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L148
	li 0,172
	li 9,177
	b .L158
.L148:
	cmpwi 0,10,1
	bc 12,2,.L152
	bc 12,1,.L156
	cmpwi 0,10,0
	bc 12,2,.L151
	b .L149
.L156:
	cmpwi 0,10,2
	bc 12,2,.L153
	b .L149
.L151:
	li 0,177
	li 9,183
	b .L158
.L152:
	li 0,183
	li 9,189
	b .L158
.L153:
	li 0,189
	li 9,197
.L158:
	stw 0,56(31)
	stw 9,3712(11)
.L149:
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
	lis 9,.LC90@ha
	lwz 0,16(29)
	lis 11,.LC90@ha
	la 9,.LC90@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC90@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC89@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC89@l(9)
	lfs 3,0(9)
	blrl
.L146:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,356(1)
	mtlr 0
	lmw 27,332(1)
	la 1,352(1)
	blr
.Lfe4:
	.size	 player_die,.Lfe4-player_die
	.section	".rodata"
	.align 2
.LC91:
	.string	"Quad Damage"
	.align 2
.LC92:
	.string	"Invulnerability"
	.align 2
.LC93:
	.string	"Silencer"
	.align 2
.LC94:
	.string	"Rebreather"
	.align 2
.LC95:
	.string	"Environment Suit"
	.align 2
.LC96:
	.string	"Power Screen"
	.align 2
.LC97:
	.string	"Power Shield"
	.align 2
.LC98:
	.string	"shotgun"
	.align 2
.LC99:
	.string	"super shotgun"
	.align 2
.LC100:
	.string	"machinegun"
	.align 2
.LC101:
	.string	"chaingun"
	.align 2
.LC102:
	.string	"grenade launcher"
	.align 2
.LC103:
	.string	"rocket launcher"
	.align 2
.LC104:
	.string	"hyperblaster"
	.align 2
.LC105:
	.string	"railgun"
	.align 2
.LC106:
	.string	"BFG10K"
	.align 2
.LC107:
	.string	"bullets"
	.align 2
.LC108:
	.string	"shells"
	.align 2
.LC109:
	.string	"cells"
	.align 2
.LC110:
	.string	"grenades"
	.align 2
.LC111:
	.string	"rockets"
	.align 2
.LC112:
	.string	"slugs"
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	mr 30,3
	li 4,0
	li 5,1616
	addi 3,30,188
	crxor 6,6,6
	bl memset
	lis 24,0x38e3
	addi 25,30,740
	lis 3,.LC77@ha
	ori 24,24,36409
	la 3,.LC77@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 31,3
	la 23,itemlist@l(9)
	lis 11,SI_QuadDamage@ha
	lis 9,CF_StartHealth@ha
	lis 10,MA_Bullets@ha
	lwz 28,SI_QuadDamage@l(11)
	subf 0,23,31
	lwz 26,CF_StartHealth@l(9)
	lis 8,MA_Shells@ha
	lwz 29,MA_Bullets@l(10)
	lis 7,MA_Grenades@ha
	mullw 0,0,24
	lis 11,CF_MaxHealth@ha
	lwz 4,MA_Shells@l(8)
	lis 9,MA_Rockets@ha
	lis 6,MA_Cells@ha
	lwz 5,MA_Grenades@l(7)
	lis 10,MA_Slugs@ha
	srawi 0,0,3
	lwz 27,CF_MaxHealth@l(11)
	cmpwi 0,28,1
	lwz 3,MA_Rockets@l(9)
	slwi 11,0,2
	lwz 8,MA_Cells@l(6)
	li 9,1
	lwz 7,MA_Slugs@l(10)
	stw 0,736(30)
	stwx 9,25,11
	stw 26,724(30)
	stw 27,728(30)
	stw 29,1764(30)
	stw 4,1768(30)
	stw 3,1772(30)
	stw 5,1776(30)
	stw 8,1780(30)
	stw 7,1784(30)
	stw 31,1788(30)
	bc 4,2,.L163
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	bl FindItem
	mr 31,3
	subf 0,23,31
	mullw 0,0,24
	srawi 0,0,3
	slwi 11,0,2
	stw 0,736(30)
	lwzx 9,25,11
	addi 9,9,1
	stwx 9,25,11
.L163:
	lis 9,RegenInvulnerability@ha
	lwz 0,RegenInvulnerability@l(9)
	cmpwi 0,0,1
	bc 4,2,.L164
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	bl FindItem
	mr 31,3
	subf 0,23,31
	mullw 0,0,24
	srawi 0,0,3
	stw 0,736(30)
.L164:
	lis 9,SI_Invulnerability@ha
	lwz 0,SI_Invulnerability@l(9)
	cmpwi 0,0,1
	bc 4,2,.L165
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	bl FindItem
	mr 31,3
	subf 0,23,31
	mullw 0,0,24
	srawi 0,0,3
	slwi 11,0,2
	stw 0,736(30)
	lwzx 9,25,11
	addi 9,9,1
	stwx 9,25,11
.L165:
	lis 9,SI_Silencer@ha
	lwz 0,SI_Silencer@l(9)
	cmpwi 0,0,1
	bc 4,2,.L166
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	bl FindItem
	mr 31,3
	subf 0,23,31
	mullw 0,0,24
	srawi 0,0,3
	slwi 11,0,2
	stw 0,736(30)
	lwzx 9,25,11
	addi 9,9,1
	stwx 9,25,11
.L166:
	lis 9,SI_Rebreather@ha
	lwz 0,SI_Rebreather@l(9)
	cmpwi 0,0,1
	bc 4,2,.L167
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	bl FindItem
	mr 31,3
	subf 0,23,31
	mullw 0,0,24
	srawi 0,0,3
	slwi 11,0,2
	stw 0,736(30)
	lwzx 9,25,11
	addi 9,9,1
	stwx 9,25,11
.L167:
	lis 9,SI_EnvironmentSuit@ha
	lwz 0,SI_EnvironmentSuit@l(9)
	cmpwi 0,0,1
	bc 4,2,.L168
	lis 3,.LC95@ha
	la 3,.LC95@l(3)
	bl FindItem
	mr 31,3
	subf 0,23,31
	mullw 0,0,24
	srawi 0,0,3
	slwi 11,0,2
	stw 0,736(30)
	lwzx 9,25,11
	addi 9,9,1
	stwx 9,25,11
.L168:
	lis 9,SI_PowerScreen@ha
	lwz 0,SI_PowerScreen@l(9)
	cmpwi 0,0,1
	bc 4,2,.L169
	lis 3,.LC96@ha
	la 3,.LC96@l(3)
	bl FindItem
	mr 31,3
	subf 0,23,31
	mullw 0,0,24
	srawi 0,0,3
	slwi 11,0,2
	stw 0,736(30)
	lwzx 9,25,11
	addi 9,9,1
	stwx 9,25,11
.L169:
	lis 9,SI_PowerShield@ha
	lwz 0,SI_PowerShield@l(9)
	cmpwi 0,0,1
	bc 4,2,.L170
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	bl FindItem
	mr 31,3
	subf 0,23,31
	mullw 0,0,24
	srawi 0,0,3
	slwi 11,0,2
	stw 0,736(30)
	lwzx 9,25,11
	addi 9,9,1
	stwx 9,25,11
.L170:
	lis 9,SW_ShotGun@ha
	lwz 0,SW_ShotGun@l(9)
	cmpwi 0,0,1
	bc 4,2,.L171
	lis 5,.LC98@ha
	mr 3,30
	la 5,.LC98@l(5)
	mr 4,31
	bl startWeapon
.L171:
	lis 9,SW_SuperShotGun@ha
	lwz 0,SW_SuperShotGun@l(9)
	cmpwi 0,0,1
	bc 4,2,.L172
	lis 5,.LC99@ha
	mr 3,30
	la 5,.LC99@l(5)
	mr 4,31
	bl startWeapon
.L172:
	lis 9,SW_MachineGun@ha
	lwz 0,SW_MachineGun@l(9)
	cmpwi 0,0,1
	bc 4,2,.L173
	lis 5,.LC100@ha
	mr 3,30
	la 5,.LC100@l(5)
	mr 4,31
	bl startWeapon
.L173:
	lis 9,SW_ChainGun@ha
	lwz 0,SW_ChainGun@l(9)
	cmpwi 0,0,1
	bc 4,2,.L174
	lis 5,.LC101@ha
	mr 3,30
	la 5,.LC101@l(5)
	mr 4,31
	bl startWeapon
.L174:
	lis 9,SW_GrenadeLauncher@ha
	lwz 0,SW_GrenadeLauncher@l(9)
	cmpwi 0,0,1
	bc 4,2,.L175
	lis 5,.LC102@ha
	mr 3,30
	la 5,.LC102@l(5)
	mr 4,31
	bl startWeapon
.L175:
	lis 9,SW_RocketLauncher@ha
	lwz 0,SW_RocketLauncher@l(9)
	cmpwi 0,0,1
	bc 4,2,.L176
	lis 5,.LC103@ha
	mr 3,30
	la 5,.LC103@l(5)
	mr 4,31
	bl startWeapon
.L176:
	lis 9,SW_HyperBlaster@ha
	lwz 0,SW_HyperBlaster@l(9)
	cmpwi 0,0,1
	bc 4,2,.L177
	lis 5,.LC104@ha
	mr 3,30
	la 5,.LC104@l(5)
	mr 4,31
	bl startWeapon
.L177:
	lis 9,SW_RailGun@ha
	lwz 0,SW_RailGun@l(9)
	cmpwi 0,0,1
	bc 4,2,.L178
	lis 5,.LC105@ha
	mr 3,30
	la 5,.LC105@l(5)
	mr 4,31
	bl startWeapon
.L178:
	lis 9,SW_BFG10K@ha
	lwz 0,SW_BFG10K@l(9)
	cmpwi 0,0,1
	bc 4,2,.L179
	lis 5,.LC106@ha
	mr 3,30
	la 5,.LC106@l(5)
	mr 4,31
	bl startWeapon
.L179:
	lis 9,SA_Bullets@ha
	lwz 6,SA_Bullets@l(9)
	cmpwi 0,6,0
	bc 4,1,.L180
	lis 9,MA_Bullets@ha
	lwz 0,MA_Bullets@l(9)
	cmpw 0,6,0
	bc 12,1,.L180
	lis 5,.LC107@ha
	mr 3,30
	la 5,.LC107@l(5)
	mr 4,31
	bl startAmmo
.L180:
	lis 9,SA_Shells@ha
	lwz 6,SA_Shells@l(9)
	cmpwi 0,6,0
	bc 4,1,.L181
	lis 9,MA_Shells@ha
	lwz 0,MA_Shells@l(9)
	cmpw 0,6,0
	bc 12,1,.L181
	lis 5,.LC108@ha
	mr 3,30
	la 5,.LC108@l(5)
	mr 4,31
	bl startAmmo
.L181:
	lis 9,SA_Cells@ha
	lwz 6,SA_Cells@l(9)
	cmpwi 0,6,0
	bc 4,1,.L182
	lis 9,MA_Cells@ha
	lwz 0,MA_Cells@l(9)
	cmpw 0,6,0
	bc 12,1,.L182
	lis 5,.LC109@ha
	mr 3,30
	la 5,.LC109@l(5)
	mr 4,31
	bl startAmmo
.L182:
	lis 9,SA_Grenades@ha
	lwz 6,SA_Grenades@l(9)
	cmpwi 0,6,0
	bc 4,1,.L183
	lis 9,MA_Grenades@ha
	lwz 0,MA_Grenades@l(9)
	cmpw 0,6,0
	bc 12,1,.L183
	lis 5,.LC110@ha
	mr 3,30
	la 5,.LC110@l(5)
	mr 4,31
	bl startAmmo
.L183:
	lis 9,SA_Rockets@ha
	lwz 6,SA_Rockets@l(9)
	cmpwi 0,6,0
	bc 4,1,.L184
	lis 9,MA_Rockets@ha
	lwz 0,MA_Rockets@l(9)
	cmpw 0,6,0
	bc 12,1,.L184
	lis 5,.LC111@ha
	mr 3,30
	la 5,.LC111@l(5)
	mr 4,31
	bl startAmmo
.L184:
	lis 9,SA_Slugs@ha
	lwz 6,SA_Slugs@l(9)
	cmpwi 0,6,0
	bc 4,1,.L185
	lis 9,MA_Slugs@ha
	lwz 0,MA_Slugs@l(9)
	cmpw 0,6,0
	bc 12,1,.L185
	lis 5,.LC112@ha
	mr 4,31
	la 5,.LC112@l(5)
	mr 3,30
	bl startAmmo
.L185:
	li 0,1
	stw 0,720(30)
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 InitClientPersistant,.Lfe5-InitClientPersistant
	.section	".rodata"
	.align 2
.LC115:
	.string	"info_player_deathmatch"
	.align 2
.LC114:
	.long 0x47c34f80
	.align 2
.LC116:
	.long 0x4b18967f
	.align 2
.LC117:
	.long 0x3f800000
	.align 3
.LC118:
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
	lis 9,.LC114@ha
	li 28,0
	lfs 29,.LC114@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC115@ha
	b .L211
.L213:
	lis 10,.LC117@ha
	lis 9,maxclients@ha
	la 10,.LC117@l(10)
	lis 11,.LC116@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC116@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L221
	lis 11,.LC118@ha
	lis 26,g_edicts@ha
	la 11,.LC118@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,892
.L216:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L218
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L218
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
	bc 4,0,.L218
	fmr 31,1
.L218:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,892
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L216
.L221:
	fcmpu 0,31,28
	bc 4,0,.L223
	fmr 28,31
	mr 24,30
	b .L211
.L223:
	fcmpu 0,31,29
	bc 4,0,.L211
	fmr 29,31
	mr 23,30
.L211:
	lis 5,.LC115@ha
	mr 3,30
	la 5,.LC115@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L213
	cmpwi 0,28,0
	bc 4,2,.L227
	li 3,0
	b .L235
.L227:
	cmpwi 0,28,2
	bc 12,1,.L228
	li 23,0
	li 24,0
	b .L229
.L228:
	addi 28,28,-2
.L229:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L234:
	mr 3,30
	li 4,280
	la 5,.LC115@l(22)
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
	bc 4,2,.L234
.L235:
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
.LC119:
	.long 0x4b18967f
	.align 2
.LC120:
	.long 0x0
	.align 2
.LC121:
	.long 0x3f800000
	.align 3
.LC122:
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
	lis 9,.LC120@ha
	li 31,0
	la 9,.LC120@l(9)
	li 25,0
	lfs 29,0(9)
	b .L237
.L239:
	lis 9,maxclients@ha
	lis 11,.LC121@ha
	lwz 10,maxclients@l(9)
	la 11,.LC121@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC119@ha
	lfs 31,.LC119@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L247
	lis 9,.LC122@ha
	lis 27,g_edicts@ha
	la 9,.LC122@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,892
.L242:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L244
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L244
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
	bc 4,0,.L244
	fmr 31,1
.L244:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,892
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L242
.L247:
	fcmpu 0,31,29
	bc 4,1,.L237
	fmr 29,31
	mr 25,31
.L237:
	lis 30,.LC115@ha
	mr 3,31
	li 4,280
	la 5,.LC115@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L239
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L252
	la 5,.LC115@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L252:
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
.LC123:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC124:
	.long 0x0
	.align 2
.LC125:
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
	lis 11,.LC124@ha
	lis 9,deathmatch@ha
	la 11,.LC124@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 30,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L267
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L268
	bl SelectFarthestDeathmatchSpawnPoint
	mr 30,3
	b .L271
.L268:
	bl SelectRandomDeathmatchSpawnPoint
	mr 30,3
	b .L271
.L295:
	li 30,0
	b .L271
.L267:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L271
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xd2b3
	lwz 10,game+1028@l(11)
	ori 9,9,6203
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,4
	bc 12,2,.L271
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 30,game+1032@ha
.L277:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L295
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
	bc 4,2,.L277
	addic. 31,31,-1
	bc 4,2,.L277
	mr 30,29
.L271:
	cmpwi 0,30,0
	bc 4,2,.L283
	lis 29,.LC0@ha
	lis 31,game@ha
.L290:
	mr 3,30
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 30,3
	bc 12,2,.L296
	la 3,game@l(31)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L294
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L285
	b .L290
.L294:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 12,2,.L290
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L290
.L285:
	cmpwi 0,30,0
	bc 4,2,.L283
.L296:
	lis 9,game@ha
	la 31,game@l(9)
	lbz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L292
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L292:
	cmpwi 0,30,0
	bc 4,2,.L283
	lis 9,gi+28@ha
	lis 3,.LC123@ha
	lwz 0,gi+28@l(9)
	la 3,.LC123@l(3)
	addi 4,31,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L283:
	lfs 0,4(30)
	lis 9,.LC125@ha
	la 9,.LC125@l(9)
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
.LC126:
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
	mulli 27,27,892
	addi 27,27,892
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
	lis 9,0xdb43
	lis 11,body_die@ha
	ori 9,9,47903
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
.LC127:
	.string	"menu_loadgame\n"
	.align 2
.LC128:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC129:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC130:
	.string	"player"
	.align 2
.LC131:
	.string	"players/male/tris.md2"
	.align 2
.LC132:
	.string	"fov"
	.align 2
.LC133:
	.string	"rate"
	.align 2
.LC134:
	.string	"items/protect.wav"
	.align 2
.LC135:
	.long 0x0
	.align 2
.LC136:
	.long 0x41400000
	.align 2
.LC137:
	.long 0x41000000
	.align 3
.LC138:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC139:
	.long 0x3f800000
	.align 2
.LC140:
	.long 0x43200000
	.align 2
.LC141:
	.long 0x47800000
	.align 2
.LC142:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4464(1)
	mflr 0
	stfd 31,4456(1)
	stmw 18,4400(1)
	stw 0,4468(1)
	lis 9,.LC128@ha
	lis 8,.LC129@ha
	lwz 0,.LC128@l(9)
	la 29,.LC129@l(8)
	addi 10,1,8
	la 9,.LC128@l(9)
	lwz 11,.LC129@l(8)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 18,5
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
	lis 8,.LC135@ha
	lwz 25,84(31)
	lwz 10,deathmatch@l(9)
	la 8,.LC135@l(8)
	lis 11,g_edicts@ha
	lfs 13,0(8)
	lis 0,0xdb43
	lfs 0,20(10)
	ori 0,0,47903
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,-1
	bc 12,2,.L315
	addi 28,1,1688
	addi 27,25,1804
	mulli 24,30,3888
	addi 26,1,3368
	mr 4,27
	li 5,1676
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,25,188
	mr 20,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 28,29
	crxor 6,6,6
	bl memcpy
	lis 19,.LC133@ha
	addi 21,25,20
	mr 3,25
	addi 30,1,72
	bl InitClientPersistant
	addi 23,25,3432
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L316
.L315:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L317
	addi 27,1,1688
	addi 26,25,1804
	mulli 24,30,3888
	addi 29,1,3880
	mr 4,26
	li 5,1676
	mr 3,27
	crxor 6,6,6
	bl memcpy
	addi 28,25,188
	mr 20,27
	mr 3,29
	mr 4,28
	li 5,512
	mr 22,29
	crxor 6,6,6
	bl memcpy
	mr 27,26
	lis 19,.LC133@ha
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	addi 30,1,72
	addi 9,9,56
	addi 21,25,20
	addi 23,25,3432
	addi 10,1,2240
	addi 11,25,740
.L368:
	lwz 0,0(9)
	addi 9,9,72
	andi. 8,0,16
	bc 12,2,.L320
	lwz 0,0(11)
	stw 0,0(10)
.L320:
	addi 10,10,4
	addi 11,11,4
	bdnz .L368
	mr 4,20
	li 5,1616
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 4,22
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3308(1)
	lwz 0,1800(25)
	cmpw 0,9,0
	bc 4,1,.L316
	stw 9,1800(25)
	b .L316
.L317:
	addi 29,1,1688
	li 4,0
	mulli 24,30,3888
	mr 3,29
	li 5,1676
	crxor 6,6,6
	bl memset
	mr 20,29
	addi 27,25,1804
	addi 28,25,188
	addi 30,1,72
	lis 19,.LC133@ha
	addi 21,25,20
	addi 23,25,3432
.L316:
	mr 4,28
	li 5,1616
	mr 3,30
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3888
	mr 3,25
	crxor 6,6,6
	bl memset
	mr 4,30
	mr 3,28
	li 5,1616
	crxor 6,6,6
	bl memcpy
	lwz 0,724(25)
	cmpwi 0,0,0
	bc 12,1,.L326
	mr 3,25
	bl InitClientPersistant
.L326:
	mr 3,27
	mr 4,20
	li 5,1676
	crxor 6,6,6
	bl memcpy
	lwz 11,84(31)
	lwz 0,724(11)
	stw 0,480(31)
	lwz 9,728(11)
	stw 9,484(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L327
	lwz 0,264(31)
	ori 0,0,4096
	stw 0,264(31)
.L327:
	lis 9,coop@ha
	lis 8,.LC135@ha
	lwz 11,coop@l(9)
	la 8,.LC135@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L329
	lwz 9,84(31)
	lwz 0,1800(9)
	stw 0,3424(9)
.L329:
	li 7,0
	lis 11,game+1028@ha
	lwz 6,264(31)
	stw 7,552(31)
	li 0,4
	lis 9,.LC130@ha
	lwz 3,game+1028@l(11)
	li 5,2
	la 9,.LC130@l(9)
	li 11,22
	stw 0,260(31)
	li 10,1
	stw 11,508(31)
	add 3,3,24
	li 0,200
	lis 11,.LC136@ha
	stw 10,88(31)
	lis 29,level+4@ha
	stw 9,280(31)
	la 11,.LC136@l(11)
	lis 10,0x201
	stw 0,400(31)
	lis 8,.LC131@ha
	lis 9,player_pain@ha
	stw 5,248(31)
	la 8,.LC131@l(8)
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
	lis 8,.LC137@ha
	lfs 0,40(1)
	la 8,.LC137@l(8)
	mr 10,11
	lfs 10,0(8)
	lis 9,deathmatch@ha
	mr 8,11
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4392(1)
	lwz 11,4396(1)
	sth 11,4(25)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4392(1)
	lwz 10,4396(1)
	sth 10,6(25)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4392(1)
	lwz 8,4396(1)
	sth 8,8(25)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L330
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4392(1)
	lwz 11,4396(1)
	andi. 9,11,32768
	bc 4,2,.L369
.L330:
	lis 4,.LC132@ha
	mr 3,28
	la 4,.LC132@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4396(1)
	lis 0,0x4330
	lis 8,.LC138@ha
	la 8,.LC138@l(8)
	stw 0,4392(1)
	lis 11,.LC139@ha
	lfd 13,0(8)
	la 11,.LC139@l(11)
	lfd 0,4392(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(25)
	bc 4,0,.L332
.L369:
	lis 0,0x42b4
	stw 0,112(25)
	b .L331
.L332:
	lis 8,.LC140@ha
	la 8,.LC140@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L331
	stfs 13,112(25)
.L331:
	lis 29,.LC133@ha
	mr 3,28
	la 4,.LC133@l(29)
	bl Info_ValueForKey
	mr 30,3
	la 4,.LC133@l(29)
	mr 3,28
	bl Info_ValueForKey
	bl atoi
	lis 9,MAX_CLIENT_RATE@ha
	lwz 0,MAX_CLIENT_RATE@l(9)
	cmpw 0,3,0
	bc 4,1,.L335
	lis 5,MAX_CLIENT_RATE_STRING@ha
	mr 3,28
	la 4,.LC133@l(19)
	la 5,MAX_CLIENT_RATE_STRING@l(5)
	bl Info_SetValueForKey
	b .L336
.L335:
	mr 3,28
	la 4,.LC133@l(19)
	mr 5,30
	bl Info_SetValueForKey
.L336:
	lis 9,gi+32@ha
	lwz 11,1788(25)
	li 29,0
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 10,g_edicts@ha
	lis 11,0xdb43
	stw 3,88(25)
	lwz 9,g_edicts@l(10)
	ori 11,11,47903
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
	lis 9,.LC141@ha
	lfs 13,48(1)
	li 0,3
	la 9,.LC141@l(9)
	lfs 11,40(1)
	lis 11,.LC142@ha
	mtctr 0
	lfs 9,0(9)
	la 11,.LC142@l(11)
	mr 5,18
	lis 9,.LC139@ha
	lfs 12,44(1)
	mr 8,23
	la 9,.LC139@l(9)
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
.L367:
	lfsx 0,11,5
	lfsx 12,11,8
	addi 11,11,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4392(1)
	lwz 9,4396(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L367
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
	stfs 0,3656(25)
	lfs 13,20(31)
	stfs 13,3660(25)
	lfs 0,24(31)
	stfs 0,3664(25)
	bl CTFStartClient
	cmpwi 0,3,0
	bc 4,2,.L314
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1788(25)
	mr 3,31
	stw 0,3552(25)
	bl ChangeWeapon
	lis 9,AutoUseQuad@ha
	lwz 0,AutoUseQuad@l(9)
	cmpwi 0,0,1
	bc 4,2,.L344
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L344
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L344
	lwz 0,8(3)
	mr 4,3
	mr 3,31
	mtlr 0
	blrl
.L344:
	lis 9,AutoUseInvulnerability@ha
	lwz 0,AutoUseInvulnerability@l(9)
	cmpwi 0,0,1
	bc 4,2,.L348
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L348
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L348
	lwz 0,8(3)
	mr 4,3
	mr 3,31
	mtlr 0
	blrl
.L348:
	lis 9,EnvironmentSuitTime@ha
	lwz 0,EnvironmentSuitTime@l(9)
	cmpwi 0,0,0
	bc 4,1,.L352
	lis 3,.LC95@ha
	la 3,.LC95@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L352
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L352
	lwz 0,8(3)
	mr 4,3
	mr 3,31
	mtlr 0
	blrl
.L352:
	lis 9,RebreatherTime@ha
	lwz 0,RebreatherTime@l(9)
	cmpwi 0,0,0
	bc 4,1,.L356
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L356
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L356
	lwz 0,8(3)
	mr 4,3
	mr 3,31
	mtlr 0
	blrl
.L356:
	lis 9,SilencerShots@ha
	lwz 0,SilencerShots@l(9)
	cmpwi 0,0,0
	bc 4,1,.L360
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L360
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L360
	lwz 0,8(3)
	mr 4,3
	mr 3,31
	mtlr 0
	blrl
.L360:
	lis 9,RegenInvulnerability@ha
	lwz 0,RegenInvulnerability@l(9)
	cmpwi 0,0,1
	bc 4,2,.L314
	lis 11,level@ha
	lwz 10,84(31)
	lwz 8,level@l(11)
	lis 7,0x4330
	lis 11,.LC138@ha
	lfs 12,3732(10)
	xoris 0,8,0x8000
	la 11,.LC138@l(11)
	stw 0,4396(1)
	stw 7,4392(1)
	lfd 13,0(11)
	lfd 0,4392(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L365
	lis 11,RegenInvulnerabilityTime@ha
	lwz 0,RegenInvulnerabilityTime@l(11)
	xoris 0,0,0x8000
	stw 0,4396(1)
	stw 7,4392(1)
	lfd 0,4392(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	b .L370
.L365:
	lis 11,RegenInvulnerabilityTime@ha
	lwz 0,RegenInvulnerabilityTime@l(11)
	add 0,8,0
	xoris 0,0,0x8000
	stw 0,4396(1)
	stw 7,4392(1)
	lfd 0,4392(1)
	fsub 0,0,13
	frsp 0,0
.L370:
	stfs 0,3732(10)
	lis 29,gi@ha
	lis 3,.LC134@ha
	la 29,gi@l(29)
	la 3,.LC134@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC139@ha
	lis 9,.LC139@ha
	lis 11,.LC135@ha
	mr 5,3
	la 8,.LC139@l(8)
	la 9,.LC139@l(9)
	mtlr 0
	la 11,.LC135@l(11)
	li 4,3
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L314:
	lwz 0,4468(1)
	mtlr 0
	lmw 18,4400(1)
	lfd 31,4456(1)
	la 1,4464(1)
	blr
.Lfe10:
	.size	 PutClientInServer,.Lfe10-PutClientInServer
	.section	".rodata"
	.align 2
.LC143:
	.string	"%s entered the game\n"
	.align 2
.LC144:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-368(1)
	mflr 0
	stmw 23,332(1)
	stw 0,372(1)
	mr 27,3
	lis 24,gi@ha
	la 25,gi@l(24)
	bl G_InitEdict
	lwz 29,84(27)
	addi 23,1,8
	li 4,0
	li 5,1676
	addi 28,29,1804
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 26,level@ha
	li 5,1616
	lwz 0,level@l(26)
	addi 4,29,188
	mr 3,28
	la 26,level@l(26)
	stw 0,3420(29)
	crxor 6,6,6
	bl memcpy
	mr 3,27
	bl PutClientInServer
	lis 9,.LC144@ha
	lfs 0,4(26)
	la 9,.LC144@l(9)
	lwz 10,84(27)
	li 0,3
	lfs 12,0(9)
	li 3,1
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,320(1)
	lwz 11,324(1)
	stw 11,3464(10)
	lwz 9,84(27)
	stw 0,3472(9)
	lwz 9,100(25)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdb43
	lwz 10,104(25)
	lwz 3,g_edicts@l(9)
	ori 0,0,47903
	mtlr 10
	subf 3,3,27
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(25)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(25)
	li 4,2
	addi 3,27,4
	mtlr 9
	blrl
	lwz 0,gi@l(24)
	lis 4,.LC143@ha
	li 3,2
	lwz 5,84(27)
	la 4,.LC143@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	mr 4,26
	li 5,304
	mr 3,23
	crxor 6,6,6
	bl memcpy
	mr 3,25
	mr 4,23
	mr 5,27
	bl sl_WriteStdLogPlayerEntered
	mr 3,27
	bl ClientEndServerFrame
	lwz 0,372(1)
	mtlr 0
	lmw 23,332(1)
	la 1,368(1)
	blr
.Lfe11:
	.size	 ClientBeginDeathmatch,.Lfe11-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC145:
	.string	"alias +hook +use; alias -hook -use;\n"
	.align 2
.LC146:
	.long 0x0
	.align 2
.LC147:
	.long 0x47800000
	.align 2
.LC148:
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
	lis 0,0xdb43
	lis 10,game+1028@ha
	ori 0,0,47903
	lis 11,allowgrapple@ha
	subf 9,9,31
	lwz 8,allowgrapple@l(11)
	mullw 9,9,0
	lwz 11,game+1028@l(10)
	cmpwi 0,8,1
	srawi 9,9,2
	mulli 9,9,3888
	addi 9,9,-3888
	add 11,11,9
	stw 11,84(31)
	bc 4,2,.L374
	lis 28,gi@ha
	li 3,11
	la 28,gi@l(28)
	lis 29,.LC145@ha
	lwz 9,100(28)
	la 29,.LC145@l(29)
	mtlr 9
	blrl
	lwz 9,116(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 0,92(28)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
.L374:
	lis 9,.LC146@ha
	lis 11,deathmatch@ha
	la 9,.LC146@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L376
	mr 3,31
	bl ClientBeginDeathmatch
	b .L373
.L376:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L377
	lis 9,.LC147@ha
	lis 11,.LC148@ha
	li 0,3
	la 9,.LC147@l(9)
	la 11,.LC148@l(11)
	mtctr 0
	lfs 11,0(9)
	li 8,0
	lfs 12,0(11)
	li 7,0
.L388:
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
	bdnz .L388
	b .L383
.L377:
	mr 3,31
	bl G_InitEdict
	lwz 28,84(31)
	lis 9,.LC130@ha
	li 4,0
	la 9,.LC130@l(9)
	li 5,1676
	addi 29,28,1804
	stw 9,280(31)
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,28,188
	li 5,1616
	stw 0,3420(28)
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl PutClientInServer
.L383:
	lis 11,.LC146@ha
	lis 9,level+200@ha
	la 11,.LC146@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L385
	mr 3,31
	bl MoveClientToIntermission
	b .L386
.L385:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L386
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdb43
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,47903
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
	lis 4,.LC143@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC143@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L386:
	mr 3,31
	bl ClientEndServerFrame
.L373:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ClientBegin,.Lfe12-ClientBegin
	.section	".rodata"
	.align 2
.LC149:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC150:
	.string	"name"
	.align 2
.LC151:
	.string	"%sbanlist.txt"
	.align 2
.LC152:
	.string	"r"
	.align 2
.LC153:
	.string	"That name is banned!\n"
	.align 2
.LC154:
	.string	"%s tried to change name to banned match of %s\n"
	.align 2
.LC155:
	.string	"name "
	.align 2
.LC156:
	.string	"berserk/sight.wav"
	.align 2
.LC158:
	.string	"Can't open %s\n"
	.align 2
.LC159:
	.string	"%s\\%s"
	.align 2
.LC160:
	.string	"%s"
	.align 2
.LC161:
	.string	"hand"
	.align 2
.LC157:
	.long 0x3e4ccccd
	.align 2
.LC162:
	.long 0x40000000
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
	stwu 1,-272(1)
	mflr 0
	stmw 18,216(1)
	stw 0,276(1)
	li 7,50
	addi 26,1,136
	mtctr 7
	addi 29,1,72
	mr 8,26
	mr 10,29
	mr 30,3
	mr 27,4
	li 19,0
	li 9,0
	lis 18,.LC133@ha
	li 0,0
	addi 11,1,8
.L419:
	stbx 0,11,9
	stbx 0,8,9
	stbx 0,10,9
	addi 9,9,1
	bdnz .L419
	mr 3,27
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L395
	lis 11,.LC149@ha
	lwz 0,.LC149@l(11)
	la 9,.LC149@l(11)
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
.L395:
	lis 4,.LC150@ha
	mr 3,27
	la 4,.LC150@l(4)
	bl Info_ValueForKey
	lis 9,ingamenamebanningstate@ha
	mr 31,3
	lwz 0,ingamenamebanningstate@l(9)
	cmpwi 0,0,1
	bc 4,2,.L396
	lis 4,.LC151@ha
	lis 5,bandirectory@ha
	la 4,.LC151@l(4)
	la 5,bandirectory@l(5)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC152@ha
	addi 3,1,8
	la 4,.LC152@l(4)
	bl fopen
	mr. 25,3
	bc 12,2,.L397
	lis 9,gi@ha
	mr 28,29
	la 29,gi@l(9)
	lis 20,.LC153@ha
	lis 21,.LC154@ha
	lis 22,.LC155@ha
	lis 23,.LC156@ha
	lis 24,.LC157@ha
	b .L398
.L400:
	mr 3,26
	bl strlen
	lis 9,matchfullnamevalue@ha
	addi 3,3,-1
	lwz 11,matchfullnamevalue@l(9)
	li 0,0
	stbx 0,26,3
	cmpwi 0,11,1
	bc 4,2,.L401
	mr 3,31
	mr 4,26
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L398
	lwz 9,12(29)
	la 4,.LC153@l(20)
	mr 3,30
	li 19,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	mr 5,31
	la 3,.LC154@l(21)
	lwz 4,84(30)
	mtlr 9
	addi 4,4,700
	crxor 6,6,6
	blrl
	la 4,.LC155@l(22)
	mr 3,28
	bl strcat
	lwz 4,84(30)
	mr 3,28
	addi 4,4,700
	bl strcat
	lwz 9,100(29)
	li 3,11
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,92(29)
	li 4,1
	mr 3,30
	mtlr 9
	blrl
	lwz 9,36(29)
	la 3,.LC156@l(23)
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 7,.LC162@ha
	lis 9,.LC163@ha
	mr 5,3
	la 7,.LC162@l(7)
	lfs 1,.LC157@l(24)
	la 9,.LC163@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 11
	mr 3,30
	lfs 3,0(9)
	blrl
	b .L398
.L401:
	mr 3,31
	mr 4,26
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L398
	lwz 9,12(29)
	la 4,.LC153@l(20)
	mr 3,30
	li 19,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(29)
	mr 5,31
	la 3,.LC154@l(21)
	lwz 4,84(30)
	mtlr 9
	addi 4,4,700
	crxor 6,6,6
	blrl
	la 4,.LC155@l(22)
	mr 3,28
	bl strcat
	lwz 4,84(30)
	mr 3,28
	addi 4,4,700
	bl strcat
	lwz 9,100(29)
	li 3,11
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,92(29)
	li 4,1
	mr 3,30
	mtlr 9
	blrl
	lwz 9,36(29)
	la 3,.LC156@l(23)
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 7,.LC162@ha
	lis 9,.LC163@ha
	mr 5,3
	la 7,.LC162@l(7)
	lfs 1,.LC157@l(24)
	la 9,.LC163@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 11
	mr 3,30
	lfs 3,0(9)
	blrl
.L398:
	mr 3,26
	li 4,50
	mr 5,25
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L400
	mr 3,25
	bl fclose
	cmpwi 0,19,0
	bc 4,2,.L410
	lwz 3,84(30)
	mr 4,31
	li 5,15
	addi 3,3,700
	bl strncpy
	b .L410
.L397:
	lis 9,gi+4@ha
	lis 3,.LC158@ha
	lwz 0,gi+4@l(9)
	la 3,.LC158@l(3)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	b .L410
.L396:
	lwz 3,84(30)
	mr 4,31
	li 5,15
	addi 3,3,700
	bl strncpy
.L410:
	lis 4,.LC21@ha
	mr 3,27
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lis 9,g_edicts@ha
	lis 0,0xdb43
	lwz 4,84(30)
	lwz 29,g_edicts@l(9)
	ori 0,0,47903
	mr 31,3
	lis 28,gi@ha
	lis 3,.LC159@ha
	subf 29,29,30
	mr 5,31
	mullw 29,29,0
	la 28,gi@l(28)
	addi 4,4,700
	la 3,.LC159@l(3)
	srawi 29,29,2
	crxor 6,6,6
	bl va
	lwz 11,24(28)
	addi 0,29,1311
	mr 4,3
	mr 3,0
	addi 29,29,1823
	mtlr 11
	blrl
	lwz 4,84(30)
	lis 3,.LC160@ha
	la 3,.LC160@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl va
	lwz 0,24(28)
	mr 4,3
	mr 3,29
	mtlr 0
	blrl
	lis 11,deathmatch@ha
	lis 7,.LC163@ha
	lwz 9,deathmatch@l(11)
	la 7,.LC163@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L411
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,208(1)
	lwz 11,212(1)
	andi. 9,11,32768
	bc 12,2,.L411
	lwz 9,84(30)
	b .L420
.L411:
	lis 4,.LC132@ha
	mr 3,27
	la 4,.LC132@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(30)
	stw 3,212(1)
	lis 0,0x4330
	lis 7,.LC164@ha
	stw 0,208(1)
	la 7,.LC164@l(7)
	lis 10,.LC165@ha
	lfd 0,208(1)
	la 10,.LC165@l(10)
	lfd 13,0(7)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(30)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L413
.L420:
	lis 0,0x42b4
	stw 0,112(9)
	b .L412
.L413:
	lis 11,.LC166@ha
	la 11,.LC166@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L412
	stfs 13,112(9)
.L412:
	lis 4,.LC161@ha
	mr 3,27
	la 4,.LC161@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L416
	mr 3,31
	bl atoi
	lwz 9,84(30)
	stw 3,716(9)
.L416:
	lis 29,.LC133@ha
	mr 3,27
	la 4,.LC133@l(29)
	bl Info_ValueForKey
	mr 31,3
	la 4,.LC133@l(29)
	mr 3,27
	bl Info_ValueForKey
	bl atoi
	lis 9,MAX_CLIENT_RATE@ha
	lwz 0,MAX_CLIENT_RATE@l(9)
	cmpw 0,3,0
	bc 4,1,.L417
	lis 5,MAX_CLIENT_RATE_STRING@ha
	la 4,.LC133@l(18)
	la 5,MAX_CLIENT_RATE_STRING@l(5)
	mr 3,27
	bl Info_SetValueForKey
	b .L418
.L417:
	la 4,.LC133@l(18)
	mr 5,31
	mr 3,27
	bl Info_SetValueForKey
.L418:
	lwz 3,84(30)
	mr 4,27
	li 5,511
	addi 3,3,188
	bl strncpy
	lwz 0,276(1)
	mtlr 0
	lmw 18,216(1)
	la 1,272(1)
	blr
.Lfe13:
	.size	 ClientUserinfoChanged,.Lfe13-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC167:
	.string	"ip"
	.align 2
.LC168:
	.string	"password"
	.align 2
.LC169:
	.string	"User with name of %s refused connection due to match with %s in banlist.\n"
	.align 2
.LC170:
	.string	"%s connected\n"
	.align 2
.LC171:
	.string	"a"
	.align 2
.LC172:
	.string	"Connect,,%s,,"
	.align 2
.LC173:
	.string	"%s,,%s,,%s\n"
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-224(1)
	mflr 0
	stmw 23,188(1)
	stw 0,228(1)
	addi 29,1,168
	mr 30,3
	mr 27,4
	mr 3,29
	bl time
	addi 28,1,72
	mr 3,29
	bl localtime
	li 8,50
	mr 23,3
	mtctr 8
	li 0,0
	addi 11,1,8
	mr 10,28
	li 9,0
.L448:
	stbx 0,11,9
	stbx 0,10,9
	addi 9,9,1
	bdnz .L448
	lis 4,.LC167@ha
	mr 3,27
	la 4,.LC167@l(4)
	bl Info_ValueForKey
	lis 4,.LC168@ha
	mr 3,27
	la 4,.LC168@l(4)
	bl Info_ValueForKey
	lis 9,password@ha
	mr 31,3
	lwz 11,password@l(9)
	mr 4,31
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L427
	li 3,0
	b .L446
.L427:
	lis 11,g_edicts@ha
	lis 0,0xdb43
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,47903
	lis 11,game@ha
	cmpwi 0,10,0
	subf 9,9,30
	la 26,game@l(11)
	mullw 9,9,0
	lwz 11,1028(26)
	srawi 9,9,2
	mulli 9,9,3888
	addi 9,9,-3888
	add 31,11,9
	stw 31,84(30)
	bc 4,2,.L428
	addi 29,31,1804
	li 4,0
	li 5,1676
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1616
	stw 0,3420(31)
	crxor 6,6,6
	bl memcpy
	lwz 0,1560(26)
	cmpwi 0,0,0
	bc 12,2,.L431
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L428
.L431:
	lwz 3,84(30)
	bl InitClientPersistant
.L428:
	mr 3,30
	mr 4,27
	bl ClientUserinfoChanged
	lis 9,namebanning@ha
	lwz 0,namebanning@l(9)
	cmpwi 0,0,1
	bc 4,2,.L432
	lis 4,.LC151@ha
	lis 5,bandirectory@ha
	la 4,.LC151@l(4)
	la 5,bandirectory@l(5)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC152@ha
	addi 3,1,8
	la 4,.LC152@l(4)
	bl fopen
	mr. 31,3
	bc 12,2,.L433
	lis 9,gi@ha
	li 25,0
	la 24,gi@l(9)
	lis 29,matchfullnamevalue@ha
	lis 26,.LC169@ha
	b .L434
.L436:
	mr 3,28
	bl strlen
	lwz 0,matchfullnamevalue@l(29)
	addi 3,3,-1
	stbx 25,28,3
	cmpwi 0,0,1
	bc 4,2,.L437
	lwz 3,84(30)
	mr 4,28
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L434
	lwz 4,84(30)
	la 3,.LC169@l(26)
	mr 5,28
	lwz 0,4(24)
	b .L449
.L437:
	lwz 3,84(30)
	mr 4,28
	addi 3,3,700
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L447
.L434:
	mr 3,28
	li 4,50
	mr 5,31
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L436
	mr 3,31
	bl fclose
	b .L432
.L447:
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC169@ha
	lwz 0,gi+4@l(9)
	la 3,.LC169@l(3)
	mr 5,28
.L449:
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L446
.L433:
	lis 9,gi+4@ha
	lis 3,.LC158@ha
	lwz 0,gi+4@l(9)
	la 3,.LC158@l(3)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L432:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L443
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC170@ha
	lwz 0,gi+4@l(9)
	la 3,.LC170@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L443:
	lis 9,namebanning@ha
	lwz 11,84(30)
	li 0,1
	lwz 10,namebanning@l(9)
	stw 0,720(11)
	cmpwi 0,10,1
	bc 4,2,.L444
	lis 9,ingamenamebanningstate@ha
	stw 10,ingamenamebanningstate@l(9)
.L444:
	lis 4,.LC167@ha
	addi 28,1,136
	la 4,.LC167@l(4)
	mr 3,27
	bl Info_ValueForKey
	mr 31,3
	lis 4,.LC133@ha
	la 4,.LC133@l(4)
	mr 3,27
	bl Info_ValueForKey
	mr 27,3
	mr 3,23
	bl asctime
	mr 4,3
	mr 3,28
	bl strcpy
	li 0,0
	lis 3,PLAYERS_LOGFILE@ha
	lis 4,.LC171@ha
	stb 0,160(1)
	la 3,PLAYERS_LOGFILE@l(3)
	la 4,.LC171@l(4)
	bl fopen
	mr. 29,3
	bc 12,2,.L445
	lis 4,.LC172@ha
	mr 5,28
	la 4,.LC172@l(4)
	mr 3,29
	crxor 6,6,6
	bl fprintf
	lwz 5,84(30)
	lis 4,.LC173@ha
	mr 6,31
	mr 7,27
	mr 3,29
	la 4,.LC173@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl fprintf
	mr 3,29
	bl fclose
.L445:
	li 3,1
.L446:
	lwz 0,228(1)
	mtlr 0
	lmw 23,188(1)
	la 1,224(1)
	blr
.Lfe14:
	.size	 ClientConnect,.Lfe14-ClientConnect
	.section	".rodata"
	.align 2
.LC174:
	.string	"%s tried to connect with a BOT, disconnected\n"
	.align 2
.LC175:
	.string	"%s disconnected\n"
	.align 2
.LC176:
	.string	"Disconnect,,%s,,"
	.align 2
.LC177:
	.string	"%s,,%s,,BOT_THROWN_OUT\n"
	.align 2
.LC178:
	.string	"%s,,%s\n"
	.align 2
.LC179:
	.string	"disconnected"
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-400(1)
	mflr 0
	stmw 24,368(1)
	stw 0,404(1)
	addi 29,1,344
	mr 31,3
	mr 3,29
	bl time
	mr 3,29
	bl localtime
	lwz 5,84(31)
	mr 27,3
	cmpwi 0,5,0
	bc 12,2,.L450
	lis 9,wasbot@ha
	lwz 0,wasbot@l(9)
	cmpwi 0,0,1
	bc 4,2,.L452
	lis 9,gi@ha
	lis 4,.LC174@ha
	lwz 0,gi@l(9)
	la 4,.LC174@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L453
.L452:
	lis 9,gi@ha
	lis 4,.LC175@ha
	lwz 0,gi@l(9)
	la 4,.LC175@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L453:
	addi 29,1,40
	lis 4,level@ha
	la 4,level@l(4)
	li 5,304
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lis 3,gi@ha
	mr 5,31
	mr 4,29
	la 3,gi@l(3)
	bl sl_LogPlayerDisconnect
	lwz 3,84(31)
	lis 4,.LC167@ha
	la 4,.LC167@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	mr 28,3
	mr 3,27
	bl asctime
	mr 4,3
	addi 3,1,8
	bl strcpy
	li 0,0
	lis 3,PLAYERS_LOGFILE@ha
	lis 4,.LC171@ha
	stb 0,32(1)
	la 3,PLAYERS_LOGFILE@l(3)
	la 4,.LC171@l(4)
	bl fopen
	mr. 29,3
	bc 12,2,.L454
	lis 4,.LC176@ha
	mr 3,29
	la 4,.LC176@l(4)
	addi 5,1,8
	crxor 6,6,6
	bl fprintf
	lis 9,wasbot@ha
	lwz 0,wasbot@l(9)
	cmpwi 0,0,1
	bc 4,2,.L455
	lwz 5,84(31)
	lis 4,.LC177@ha
	mr 6,28
	la 4,.LC177@l(4)
	mr 3,29
	addi 5,5,700
	crxor 6,6,6
	bl fprintf
	b .L456
.L455:
	lwz 5,84(31)
	lis 4,.LC178@ha
	mr 6,28
	la 4,.LC178@l(4)
	mr 3,29
	addi 5,5,700
	crxor 6,6,6
	bl fprintf
.L456:
	mr 3,29
	bl fclose
.L454:
	lis 28,gi@ha
	li 3,1
	la 28,gi@l(28)
	li 27,0
	lwz 11,100(28)
	lis 9,wasbot@ha
	lis 25,g_edicts@ha
	stw 27,wasbot@l(9)
	lis 26,0xdb43
	lis 24,.LC22@ha
	mtlr 11
	ori 26,26,47903
	blrl
	lwz 3,g_edicts@l(25)
	lwz 9,104(28)
	subf 3,3,31
	mullw 3,3,26
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
	lis 9,.LC179@ha
	lwz 11,84(31)
	li 0,1
	la 9,.LC179@l(9)
	stw 27,40(31)
	la 4,.LC22@l(24)
	stw 9,280(31)
	stw 27,248(31)
	stw 27,88(31)
	stw 27,720(11)
	lwz 9,84(31)
	lwz 29,g_edicts@l(25)
	stw 0,3816(9)
	lwz 9,84(31)
	subf 29,29,31
	mullw 29,29,26
	stw 27,3820(9)
	lwz 9,24(28)
	srawi 29,29,2
	addi 3,29,1311
	mtlr 9
	blrl
	lwz 0,24(28)
	addi 3,29,1823
	la 4,.LC22@l(24)
	mtlr 0
	blrl
.L450:
	lwz 0,404(1)
	mtlr 0
	lmw 24,368(1)
	la 1,400(1)
	blr
.Lfe15:
	.size	 ClientDisconnect,.Lfe15-ClientDisconnect
	.section	".rodata"
	.align 2
.LC180:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC182:
	.string	"*jump1.wav"
	.align 2
.LC183:
	.string	"Cells"
	.align 2
.LC184:
	.string	"misc/comp_up.wav"
	.align 2
.LC186:
	.string	"No more cells, motion cloaking disabled!\n"
	.align 3
.LC181:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC185:
	.long 0x3d75c28f
	.align 2
.LC187:
	.long 0x0
	.align 3
.LC188:
	.long 0x40140000
	.long 0x0
	.align 3
.LC189:
	.long 0x40240000
	.long 0x0
	.align 3
.LC190:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC191:
	.long 0x41000000
	.align 3
.LC192:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC193:
	.long 0x3f800000
	.align 2
.LC194:
	.long 0x40400000
	.align 3
.LC195:
	.long 0x3ff80000
	.long 0x0
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
	lis 9,fraghit@ha
	lis 11,level@ha
	lwz 0,fraghit@l(9)
	mr 31,3
	la 30,level@l(11)
	stw 31,292(30)
	mr 26,4
	cmpwi 0,0,0
	lwz 28,84(31)
	bc 4,2,.L480
	lis 9,.LC187@ha
	lfs 13,200(30)
	la 9,.LC187@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L481
	lis 10,.LC188@ha
	lfs 0,4(30)
	la 10,.LC188@l(10)
	lfd 12,0(10)
	fadd 13,13,12
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L481
	li 0,4
	stw 0,0(28)
	lfs 0,200(30)
	lfs 13,4(30)
	fadd 0,0,12
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L482
	lwz 0,3824(28)
	cmpwi 0,0,0
	bc 4,2,.L482
	bl endLevelshowTop10
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	li 0,1
	stw 0,3824(28)
.L482:
	lis 9,level@ha
	lis 10,.LC189@ha
	la 9,level@l(9)
	la 10,.LC189@l(10)
	lfs 0,200(9)
	lfd 12,0(10)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L479
	lbz 0,1(26)
	andi. 11,0,128
	bc 12,2,.L479
	li 0,1
	stw 0,208(9)
	b .L479
.L481:
	lis 9,level@ha
	lis 20,.LC187@ha
	la 20,.LC187@l(20)
	la 9,level@l(9)
	lfs 0,0(20)
	lfs 13,200(9)
	fcmpu 0,13,0
	bc 12,2,.L486
	fmr 0,13
	lfs 13,4(9)
	lis 9,.LC188@ha
	la 9,.LC188@l(9)
	lfd 12,0(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L486
	lis 9,timehud@ha
	lwz 0,timehud@l(9)
	cmpwi 0,0,1
	bc 4,2,.L485
	lis 3,GlobalTimeLimit@ha
	la 3,GlobalTimeLimit@l(3)
	bl atoi
	lwz 9,84(31)
	sth 3,152(9)
.L485:
	li 0,4
	stw 0,0(28)
	b .L479
.L480:
	lis 9,.LC187@ha
	lfs 13,200(30)
	la 9,.LC187@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L486
	lis 9,timehud@ha
	lwz 0,timehud@l(9)
	cmpwi 0,0,1
	bc 4,2,.L488
	lis 3,GlobalTimeLimit@ha
	la 3,GlobalTimeLimit@l(3)
	bl atoi
	lwz 9,84(31)
	sth 3,152(9)
.L488:
	li 0,4
	lis 9,.LC188@ha
	stw 0,0(28)
	la 9,.LC188@l(9)
	lfs 0,200(30)
	lfd 12,0(9)
	lfs 13,4(30)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L479
	lbz 0,1(26)
	andi. 10,0,128
	bc 12,2,.L479
	li 0,1
	stw 0,208(30)
	b .L479
.L486:
	lwz 0,3868(28)
	cmpwi 0,0,1
	bc 4,2,.L490
	mr 3,31
	bl Pull_Grapple
.L490:
	lwz 9,84(31)
	lis 11,pm_passent@ha
	stw 31,pm_passent@l(11)
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L491
	lha 0,2(26)
	lis 8,0x4330
	lis 9,.LC190@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC190@l(9)
	stw 0,260(1)
	stw 8,256(1)
	lfd 12,0(9)
	lfd 0,256(1)
	lis 9,.LC181@ha
	lfd 13,.LC181@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3432(28)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3436(28)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3440(28)
	b .L479
.L491:
	addi 3,1,8
	li 4,0
	mr 30,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L496
	lwz 0,40(31)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L496
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L496
	li 0,2
.L496:
	stw 0,0(28)
	lis 9,sv_gravity@ha
	lwz 7,0(28)
	lwz 10,sv_gravity@l(9)
	li 20,3
	addi 23,1,12
	lwz 0,8(28)
	mtctr 20
	addi 24,31,4
	addi 22,1,18
	lfs 0,20(10)
	addi 25,31,376
	mr 12,23
	lwz 9,12(28)
	lis 10,.LC191@ha
	mr 4,24
	lwz 8,4(28)
	la 10,.LC191@l(10)
	mr 3,22
	lfs 10,0(10)
	mr 5,25
	addi 29,28,3480
	addi 27,1,36
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
.L568:
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
	bdnz .L568
	mr 3,29
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L503
	li 0,1
	stw 0,52(1)
.L503:
	lis 9,gi@ha
	lwz 7,0(26)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(26)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lis 20,.LC192@ha
	lwz 8,8(26)
	la 20,.LC192@l(20)
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
	lis 9,.LC190@ha
	lwz 11,8(1)
	mr 27,23
	la 9,.LC190@l(9)
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
	stw 0,3480(28)
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
.L567:
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
	bdnz .L567
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 20,.LC190@ha
	lis 7,.LC181@ha
	lfs 8,204(1)
	la 20,.LC190@l(20)
	lfs 9,208(1)
	lfs 10,212(1)
	lfs 11,224(1)
	stfs 0,200(31)
	stfs 13,204(31)
	stfs 8,188(31)
	stfs 9,192(31)
	stfs 10,196(31)
	stfs 11,208(31)
	lha 0,2(26)
	lfd 12,0(20)
	xoris 0,0,0x8000
	lfd 13,.LC181@l(7)
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3432(28)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3436(28)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3440(28)
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L509
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L509
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L509
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L509
	lis 29,gi@ha
	lis 3,.LC182@ha
	la 29,gi@l(29)
	la 3,.LC182@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC193@ha
	lis 10,.LC193@ha
	lis 11,.LC187@ha
	mr 5,3
	la 9,.LC193@l(9)
	la 10,.LC193@l(10)
	mtlr 0
	la 11,.LC187@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	mr 4,24
	mr 3,31
	li 5,0
	bl PlayerNoise
.L509:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(31)
	stw 11,608(31)
	fctiwz 13,0
	stw 10,552(31)
	stfd 13,256(1)
	lwz 9,260(1)
	stw 9,508(31)
	bc 12,2,.L510
	lwz 0,92(10)
	stw 0,556(31)
.L510:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L511
	lfs 0,3584(28)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(28)
	stw 9,28(28)
	stfs 0,32(28)
	b .L512
.L511:
	lfs 0,188(1)
	stfs 0,3656(28)
	lfs 13,192(1)
	stfs 13,3660(28)
	lfs 0,196(1)
	stfs 0,3664(28)
	lfs 13,188(1)
	stfs 13,28(28)
	lfs 0,192(1)
	stfs 0,32(28)
	lfs 13,196(1)
	stfs 13,36(28)
.L512:
	lis 9,cloaking@ha
	lwz 30,cloaking@l(9)
	cmpwi 0,30,1
	bc 4,2,.L513
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L566
	lis 9,cloakgrapple@ha
	lwz 0,cloakgrapple@l(9)
	cmpwi 0,0,1
	bc 4,2,.L514
	lwz 29,84(31)
	lwz 0,3840(29)
	cmpwi 0,0,0
	bc 12,2,.L540
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,2,.L517
	lha 27,10(26)
	cmpwi 0,27,0
	bc 12,2,.L516
.L517:
	lwz 0,184(31)
	li 9,0
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 9,3844(29)
	b .L540
.L516:
	lwz 11,184(31)
	andi. 10,11,1
	bc 12,2,.L519
	lis 24,.LC183@ha
	lis 30,0x38e3
	la 3,.LC183@l(24)
	ori 30,30,36409
	bl FindItem
	lis 9,itemlist@ha
	addi 11,29,740
	la 25,itemlist@l(9)
	subf 3,25,3
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,1,.L569
	b .L533
.L519:
	lwz 0,3844(29)
	cmpwi 0,0,0
	bc 12,2,.L524
	lis 9,level+4@ha
	lfs 13,3852(29)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L540
	ori 0,11,1
	stw 0,184(31)
	stw 10,3856(29)
	b .L540
.L524:
	lis 9,level+4@ha
	lis 10,.LC195@ha
	lfs 0,level+4@l(9)
	la 10,.LC195@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3852(29)
	b .L570
.L514:
	lwz 3,84(31)
	lwz 0,3840(3)
	cmpwi 0,0,0
	bc 12,2,.L540
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,2,.L530
	lha 0,10(26)
	cmpwi 0,0,0
	bc 4,2,.L530
	bl Is_Grappling
	mr. 27,3
	bc 12,2,.L529
.L530:
	lwz 0,184(31)
	li 11,0
	lwz 9,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 11,3844(9)
	b .L540
.L529:
	lwz 11,184(31)
	andi. 8,11,1
	bc 12,2,.L532
	lis 24,.LC183@ha
	lwz 29,84(31)
	lis 30,0x38e3
	la 3,.LC183@l(24)
	ori 30,30,36409
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 25,itemlist@l(9)
	subf 3,25,3
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,1,.L533
.L569:
	lwz 11,84(31)
	lis 29,gi@ha
	lis 3,.LC184@ha
	la 29,gi@l(29)
	la 3,.LC184@l(3)
	lwz 9,3856(11)
	addi 9,9,1
	stw 9,3856(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC185@ha
	lwz 0,16(29)
	lis 10,.LC187@ha
	lfs 1,.LC185@l(9)
	la 10,.LC187@l(10)
	mr 5,3
	lis 9,.LC194@ha
	lfs 3,0(10)
	mtlr 0
	mr 3,31
	la 9,.LC194@l(9)
	li 4,0
	lfs 2,0(9)
	blrl
	lwz 10,84(31)
	lis 9,CLOAK_DRAIN@ha
	lwz 11,CLOAK_DRAIN@l(9)
	lwz 0,3856(10)
	cmpw 0,0,11
	bc 4,2,.L540
	la 3,.LC183@l(24)
	bl FindItem
	subf 3,25,3
	lwz 10,84(31)
	mullw 3,3,30
	addi 10,10,740
	srawi 3,3,3
	slwi 3,3,2
	lwzx 9,10,3
	addi 9,9,-1
	stwx 9,10,3
	lwz 11,84(31)
	stw 27,3856(11)
	b .L540
.L533:
	lwz 0,184(31)
	lis 10,gi+12@ha
	lis 4,.LC186@ha
	lwz 11,84(31)
	la 4,.LC186@l(4)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 27,3844(11)
	lwz 9,84(31)
	stw 27,3840(9)
	lwz 0,gi+12@l(10)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L540
.L532:
	lwz 10,84(31)
	lwz 0,3844(10)
	cmpwi 0,0,0
	bc 12,2,.L537
	lis 9,level+4@ha
	lfs 13,3852(10)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L540
	ori 0,11,1
	stw 0,184(31)
	stw 8,3856(10)
	b .L540
.L537:
	lis 9,level+4@ha
	lis 11,.LC195@ha
	lfs 0,level+4@l(9)
	la 11,.LC195@l(11)
	lfd 13,0(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3852(10)
.L570:
	lwz 9,84(31)
	stw 30,3844(9)
	b .L540
.L513:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L540
.L566:
	lwz 11,84(31)
	li 0,0
	stw 0,3840(11)
	lwz 9,84(31)
	stw 0,3844(9)
	lwz 11,84(31)
	sth 0,162(11)
.L540:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L542
	mr 3,31
	bl G_TouchTriggers
.L542:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L544
	addi 30,1,60
.L546:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,30,0
	addi 27,29,1
	bc 4,0,.L548
	lwz 0,0(30)
	cmpw 0,0,3
	bc 12,2,.L548
	mr 9,30
.L549:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L548
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L549
.L548:
	cmpw 0,11,29
	bc 4,2,.L545
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L545
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L545:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L546
.L544:
	lwz 0,3536(28)
	lwz 11,3544(28)
	stw 0,3540(28)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3536(28)
	or 11,11,0
	stw 11,3544(28)
	lbz 0,15(26)
	stw 0,640(31)
	lwz 9,3544(28)
	andi. 0,9,1
	bc 12,2,.L556
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L556
	lwz 0,3548(28)
	cmpwi 0,0,0
	bc 4,2,.L556
	li 0,1
	mr 3,31
	stw 0,3548(28)
	bl Think_Weapon
.L556:
	lis 9,maxclients@ha
	lis 10,.LC193@ha
	lwz 11,maxclients@l(9)
	la 10,.LC193@l(10)
	li 29,1
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L559
	lis 11,.LC190@ha
	lis 26,g_edicts@ha
	la 11,.LC190@l(11)
	lis 27,0x4330
	lfd 31,0(11)
	li 30,892
.L561:
	lwz 0,g_edicts@l(26)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L560
	lwz 9,84(3)
	lwz 0,3832(9)
	cmpw 0,0,31
	bc 4,2,.L560
	bl UpdateChaseCam
.L560:
	addi 29,29,1
	lwz 11,maxclients@l(21)
	xoris 0,29,0x8000
	addi 30,30,892
	stw 0,260(1)
	stw 27,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L561
.L559:
	lis 9,allowgrapple@ha
	lwz 0,allowgrapple@l(9)
	cmpwi 0,0,1
	bc 4,2,.L479
	lwz 9,84(31)
	lwz 0,3536(9)
	andi. 9,0,2
	bc 12,2,.L564
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L564
	lis 9,level@ha
	lwz 11,3884(28)
	lwz 0,level@l(9)
	cmpw 0,11,0
	bc 12,1,.L564
	mr 3,31
	bl Throw_Grapple
.L564:
	lis 9,allowgrapple@ha
	lwz 0,allowgrapple@l(9)
	cmpwi 0,0,1
	bc 4,2,.L479
	mr 3,28
	bl Ended_Grappling
	cmpwi 0,3,0
	bc 12,2,.L479
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L479
	lwz 3,3860(28)
	cmpwi 0,3,0
	bc 12,2,.L479
	bl Release_Grapple
.L479:
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
.LC196:
	.string	"!zbot\n"
	.align 2
.LC197:
	.string	"#zbot\n"
	.align 2
.LC198:
	.string	"NO BOTS ALLOWED...\n"
	.align 2
.LC199:
	.string	"disconnect\n"
	.align 2
.LC200:
	.long 0x0
	.align 3
.LC201:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC202:
	.long 0x40800000
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,level@ha
	lis 10,.LC200@ha
	la 10,.LC200@l(10)
	la 26,level@l(9)
	lfs 13,0(10)
	mr 31,3
	lfs 0,200(26)
	fcmpu 0,0,13
	bc 4,2,.L574
	lwz 30,84(31)
	lwz 11,3464(30)
	cmpwi 0,11,0
	bc 4,1,.L576
	xoris 11,11,0x8000
	lfs 12,4(26)
	stw 11,20(1)
	lis 0,0x4330
	lis 11,.LC201@ha
	stw 0,16(1)
	la 11,.LC201@l(11)
	lfd 0,16(1)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L576
	li 27,0
	lis 28,gi@ha
	la 28,gi@l(28)
	stw 27,3464(30)
	li 3,11
	lwz 9,100(28)
	lis 29,.LC196@ha
	la 29,.LC196@l(29)
	mtlr 9
	blrl
	lwz 9,116(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,92(28)
	li 4,1
	mr 3,31
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,11
	lis 29,.LC197@ha
	la 29,.LC197@l(29)
	mtlr 9
	blrl
	lwz 9,116(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 0,92(28)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 9,.LC202@ha
	la 9,.LC202@l(9)
	stw 27,3476(11)
	lfs 12,0(9)
	lfs 0,4(26)
	lwz 11,84(31)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,3468(11)
.L576:
	lwz 8,84(31)
	lwz 0,3468(8)
	cmpwi 0,0,0
	bc 4,1,.L580
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC201@ha
	la 10,.LC201@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,level@ha
	la 26,level@l(10)
	lfs 12,4(26)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L580
	li 27,0
	stw 27,3468(8)
	lwz 11,84(31)
	lwz 0,3476(11)
	cmpwi 0,0,0
	bc 12,2,.L586
	lwz 9,3472(11)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,3472(11)
	bc 12,1,.L586
	lis 28,gi@ha
	lis 5,.LC198@ha
	la 28,gi@l(28)
	li 4,2
	lwz 9,8(28)
	la 5,.LC198@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,100(28)
	li 3,11
	li 0,1
	lis 9,wasbot@ha
	lis 29,.LC199@ha
	mtlr 11
	stw 0,wasbot@l(9)
	la 29,.LC199@l(29)
	blrl
	lwz 9,116(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 0,92(28)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L580
.L586:
	lis 28,gi@ha
	li 3,11
	la 28,gi@l(28)
	lis 29,.LC196@ha
	lwz 9,100(28)
	la 29,.LC196@l(29)
	mtlr 9
	blrl
	lwz 9,116(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,92(28)
	li 4,1
	mr 3,31
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,11
	lis 29,.LC197@ha
	la 29,.LC197@l(29)
	mtlr 9
	blrl
	lwz 9,116(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 0,92(28)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 9,.LC202@ha
	la 9,.LC202@l(9)
	stw 27,3476(11)
	lfs 12,0(9)
	lfs 0,4(26)
	lwz 11,84(31)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,3468(11)
.L580:
	lwz 0,3548(30)
	cmpwi 0,0,0
	bc 4,2,.L592
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L592
	mr 3,31
	bl Think_Weapon
	b .L593
.L592:
	li 0,0
	stw 0,3548(30)
.L593:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L594
	lis 9,level@ha
	lfs 13,3812(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L574
	lis 9,.LC200@ha
	lis 11,deathmatch@ha
	lwz 10,3544(30)
	la 9,.LC200@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L599
	bc 12,30,.L574
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1024
	bc 12,2,.L574
.L599:
	bc 4,30,.L600
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L601
.L600:
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
	bl PutClientInServer
	lwz 8,84(31)
	li 0,6
	li 11,2
	stw 0,80(31)
	li 10,32
	stw 11,3816(8)
	li 0,14
	lwz 9,84(31)
	stb 10,16(9)
	lwz 11,84(31)
	lis 10,level@ha
	stb 0,17(11)
	lwz 9,level@l(10)
	lwz 11,84(31)
	addi 9,9,1
	stw 9,3884(11)
	lfs 0,4(29)
	lwz 10,84(31)
	stfs 0,3812(10)
	b .L603
.L601:
	lis 9,gi+168@ha
	lis 3,.LC127@ha
	lwz 0,gi+168@l(9)
	la 3,.LC127@l(3)
	mtlr 0
	blrl
	b .L605
.L594:
	lis 9,.LC200@ha
	lis 11,deathmatch@ha
	la 9,.LC200@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L603
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L603
	addi 3,31,28
	bl PlayerTrail_Add
.L605:
.L603:
	li 0,0
	stw 0,3544(30)
.L574:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientBeginServerFrame,.Lfe17-ClientBeginServerFrame
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.section	".rodata"
	.align 2
.LC203:
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
	lis 11,.LC203@ha
	lis 9,deathmatch@ha
	la 11,.LC203@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L313
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L312
.L313:
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
	bl PutClientInServer
	lwz 11,84(31)
	li 0,6
	li 9,2
	stw 0,80(31)
	li 8,32
	lis 10,level@ha
	stw 9,3816(11)
	li 0,14
	la 7,level@l(10)
	lwz 9,84(31)
	stb 8,16(9)
	lwz 11,84(31)
	stb 0,17(11)
	lwz 9,level@l(10)
	lwz 11,84(31)
	addi 9,9,1
	stw 9,3884(11)
	lfs 0,4(7)
	lwz 10,84(31)
	stfs 0,3812(10)
	b .L311
.L312:
	lis 9,gi+168@ha
	lis 3,.LC127@ha
	lwz 0,gi+168@l(9)
	la 3,.LC127@l(3)
	mtlr 0
	blrl
.L311:
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
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 4,0
	addi 28,29,1804
	li 5,1676
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1616
	stw 0,3420(29)
	crxor 6,6,6
	bl memcpy
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
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
	lis 11,.LC126@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC126@l(11)
.L301:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L301
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
.LC204:
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
	lis 9,.LC204@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC204@l(9)
	addi 10,10,892
	lfs 13,0(9)
.L194:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L193
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
	bc 12,2,.L193
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3424(9)
	add 11,7,11
	stw 0,1800(11)
.L193:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3888
	addi 10,10,892
	cmpw 0,6,0
	bc 12,0,.L194
	blr
.Lfe22:
	.size	 SaveClientData,.Lfe22-SaveClientData
	.section	".rodata"
	.align 2
.LC205:
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
	bc 12,2,.L199
	lwz 0,264(3)
	ori 0,0,4096
	stw 0,264(3)
.L199:
	lis 9,.LC205@ha
	lis 11,coop@ha
	la 9,.LC205@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bclr 12,2
	lwz 9,84(3)
	lwz 0,1800(9)
	stw 0,3424(9)
	blr
.Lfe23:
	.size	 FetchClientEntData,.Lfe23-FetchClientEntData
	.comm	configloc,50,4
	.comm	cycleloc,50,4
	.comm	scoreboard,4,4
	.comm	GlobalFragLimit,5,4
	.comm	GlobalTimeLimit,5,4
	.comm	GlobalGravity,5,4
	.comm	QWLOG,4,4
	.comm	directory,40,4
	.comm	recordLOG,2,4
	.comm	ModelGenDir,50,4
	.comm	obitsDir,50,4
	.comm	HIGHSCORE_DIR,50,4
	.comm	PLAYERS_LOGFILE,50,4
	.comm	MAX_CLIENT_RATE_STRING,10,4
	.comm	MAX_CLIENT_RATE,4,4
	.comm	clientlog,4,4
	.comm	showed,4,4
	.comm	rankhud,4,4
	.comm	playershud,4,4
	.comm	timehud,4,4
	.comm	cloakgrapple,4,4
	.comm	hookcolor,4,4
	.comm	allowgrapple,4,4
	.comm	HOOK_TIME,4,4
	.comm	HOOK_SPEED,4,4
	.comm	EXPERT_SKY_SOLID,4,4
	.comm	HOOK_DAMAGE,4,4
	.comm	PULL_SPEED,4,4
	.comm	LoseQ,4,4
	.comm	LoseQ_Fragee,4,4
	.comm	ConfigRD,4,4
	.comm	CRD,4,4
	.comm	rocketSpeed,4,4
	.comm	Q_Killer,4,4
	.comm	Q_Killee,4,4
	.comm	CF_StartHealth,4,4
	.comm	CF_MaxHealth,4,4
	.comm	MA_Bullets,4,4
	.comm	MA_Shells,4,4
	.comm	MA_Cells,4,4
	.comm	MA_Grenades,4,4
	.comm	MA_Rockets,4,4
	.comm	MA_Slugs,4,4
	.comm	SA_Bullets,4,4
	.comm	SA_Shells,4,4
	.comm	SA_Cells,4,4
	.comm	SA_Grenades,4,4
	.comm	SA_Rockets,4,4
	.comm	SA_Slugs,4,4
	.comm	SI_QuadDamage,4,4
	.comm	SI_Invulnerability,4,4
	.comm	SI_Silencer,4,4
	.comm	SI_Rebreather,4,4
	.comm	SI_EnvironmentSuit,4,4
	.comm	SI_PowerScreen,4,4
	.comm	SI_PowerShield,4,4
	.comm	QuadDamageTime,4,4
	.comm	RebreatherTime,4,4
	.comm	EnvironmentSuitTime,4,4
	.comm	InvulnerabilityTime,4,4
	.comm	SilencerShots,4,4
	.comm	RegenInvulnerability,4,4
	.comm	RegenInvulnerabilityTime,4,4
	.comm	AutoUseQuad,4,4
	.comm	AutoUseInvulnerability,4,4
	.comm	SW_Blaster,4,4
	.comm	SW_ShotGun,4,4
	.comm	SW_SuperShotGun,4,4
	.comm	SW_MachineGun,4,4
	.comm	SW_ChainGun,4,4
	.comm	SW_GrenadeLauncher,4,4
	.comm	SW_RocketLauncher,4,4
	.comm	SW_HyperBlaster,4,4
	.comm	SW_RailGun,4,4
	.comm	SW_BFG10K,4,4
	.comm	rocketspeed,4,4
	.comm	RadiusDamage,4,4
	.comm	DamageRadius,4,4
	.comm	GLauncherTimer,4,4
	.comm	GLauncherFireDistance,4,4
	.comm	GLauncherDamage,4,4
	.comm	GLauncherRadius,4,4
	.comm	GRENADE_TIMER,4,4
	.comm	GRENADE_MINSPEED,4,4
	.comm	GRENADE_MAXSPEED,4,4
	.comm	GrenadeTimer,4,4
	.comm	GrenadeMinSpeed,4,4
	.comm	GrenadeMaxSpeed,4,4
	.comm	GrenadeDamage,4,4
	.comm	GrenadeRadius,4,4
	.comm	HyperBlasterDamage,4,4
	.comm	BlasterProjectileSpeed,4,4
	.comm	BlasterDamage,4,4
	.comm	MachinegunDamage,4,4
	.comm	MachinegunKick,4,4
	.comm	ChaingunDamage,4,4
	.comm	ChaingunKick,4,4
	.comm	ShotgunDamage,4,4
	.comm	ShotgunKick,4,4
	.comm	SuperShotgunDamage,4,4
	.comm	SuperShotgunKick,4,4
	.comm	RailgunDamage,4,4
	.comm	RailgunKick,4,4
	.comm	BFGDamage,4,4
	.comm	BFGDamageRadius,4,4
	.comm	BFGProjectileSpeed,4,4
	.comm	namebanning,4,4
	.comm	bandirectory,50,4
	.comm	ingamenamebanningstate,4,4
	.comm	wasbot,4,4
	.comm	ban_BFG,4,4
	.comm	ban_hyperblaster,4,4
	.comm	ban_rocketlauncher,4,4
	.comm	ban_railgun,4,4
	.comm	ban_chaingun,4,4
	.comm	ban_machinegun,4,4
	.comm	ban_shotgun,4,4
	.comm	ban_supershotgun,4,4
	.comm	ban_grenadelauncher,4,4
	.comm	matchfullnamevalue,4,4
	.comm	fullnamevalue,4,4
	.comm	fastrailgun,4,4
	.comm	fastrocketfire,4,4
	.comm	cloaking,4,4
	.comm	CLOAK_DRAIN,4,4
	.comm	chasekeepscore,4,4
	.comm	fastchange,4,4
	.comm	fraghit,4,4
	.comm	somevar0,30,4
	.comm	somevar1,30,4
	.comm	somevar2,30,4
	.comm	somevar3,30,4
	.comm	somevar4,30,4
	.comm	somevar5,30,4
	.comm	somevar6,30,4
	.comm	somevar7,30,4
	.comm	somevar8,30,4
	.comm	somevar9,30,4
	.comm	somevar10,30,4
	.comm	somevar11,30,4
	.comm	somevar12,30,4
	.comm	somevar13,30,4
	.comm	somevar14,30,4
	.comm	totalrank,4,4
	.comm	hi_head1,60,4
	.comm	hi_head2,60,4
	.comm	hi_line1,60,4
	.comm	hi_line2,60,4
	.comm	hi_line3,60,4
	.comm	hi_line4,60,4
	.comm	hi_line5,60,4
	.comm	hi_line6,60,4
	.comm	hi_line7,60,4
	.comm	hi_line8,60,4
	.comm	hi_line9,60,4
	.comm	hi_line10,60,4
	.comm	hi_line11,60,4
	.comm	hi_line12,60,4
	.comm	hi_line13,60,4
	.comm	hi_line14,60,4
	.comm	hi_line15,60,4
	.align 2
	.globl stuffcmd2
	.type	 stuffcmd2,@function
stuffcmd2:
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
.Lfe24:
	.size	 stuffcmd2,.Lfe24-stuffcmd2
	.section	".rodata"
	.align 2
.LC206:
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
	lis 9,.LC206@ha
	mr 30,3
	la 9,.LC206@l(9)
	li 31,0
	lfs 31,0(9)
	lis 29,.LC0@ha
.L10:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L7
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L10
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
	bc 4,0,.L10
	lwz 3,300(30)
	cmpwi 0,3,0
	bc 12,2,.L15
	lwz 4,300(31)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L7
.L15:
	lwz 0,300(31)
	stw 0,300(30)
.L7:
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
.LC207:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC208:
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
	lis 11,.LC208@ha
	lis 9,coop@ha
	la 11,.LC208@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L19
	lis 3,level+72@ha
	lis 4,.LC1@ha
	la 3,level+72@l(3)
	la 4,.LC1@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L19
	lis 9,SP_CreateCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_CreateCoopSpots@l(9)
	lis 11,.LC207@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC207@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L19:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 SP_info_player_start,.Lfe26-SP_info_player_start
	.section	".rodata"
	.align 2
.LC209:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC209@ha
	lis 9,deathmatch@ha
	la 11,.LC209@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L23
	bl G_FreeEdict
	b .L22
.L23:
	bl SP_misc_teleporter_dest
.L22:
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
	b .L606
.L31:
	li 3,0
.L606:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 IsFemale,.Lfe29-IsFemale
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	mr 29,5
	bl ServObitClientObituary
	cmpwi 0,3,0
	bc 4,2,.L113
	mr 3,31
	mr 4,30
	mr 5,29
	bl ORIGINAL_ClientObituary
.L113:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 ClientObituary,.Lfe30-ClientObituary
	.section	".rodata"
	.align 3
.LC210:
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
	bc 12,2,.L125
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L125
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L607
.L125:
	cmpwi 0,4,0
	bc 12,2,.L127
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L127
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L607:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L126
.L127:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3584(9)
	b .L124
.L126:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC210@ha
	lwz 11,84(31)
	lfd 0,.LC210@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3584(11)
.L124:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 LookAtKiller,.Lfe31-LookAtKiller
	.align 2
	.globl UseMe
	.type	 UseMe,@function
UseMe:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	mr 3,4
	bl FindItem
	mr. 10,3
	bc 12,2,.L159
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L159
	lwz 0,8(10)
	mr 3,31
	mr 4,10
	mtlr 0
	blrl
.L159:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 UseMe,.Lfe32-UseMe
	.align 2
	.globl startWeapon
	.type	 startWeapon,@function
startWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	mr 3,5
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	addi 10,29,740
	mullw 9,9,0
	li 11,1
	srawi 9,9,3
	slwi 0,9,2
	stw 9,736(29)
	stwx 11,10,0
	stw 3,1788(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 startWeapon,.Lfe33-startWeapon
	.align 2
	.globl startAmmo
	.type	 startAmmo,@function
startAmmo:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,6
	mr 3,5
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,29,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,11,3
	add 0,0,28
	stwx 0,11,3
	lwz 9,1780(29)
	cmpw 0,0,9
	bc 4,1,.L188
	stwx 9,11,3
.L188:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 startAmmo,.Lfe34-startAmmo
	.section	".rodata"
	.align 2
.LC211:
	.long 0x4b18967f
	.align 2
.LC212:
	.long 0x3f800000
	.align 3
.LC213:
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
	lis 11,.LC212@ha
	lwz 10,maxclients@l(9)
	la 11,.LC212@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC211@ha
	lfs 31,.LC211@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L203
	lis 9,.LC213@ha
	lis 27,g_edicts@ha
	la 9,.LC213@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,892
.L205:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L204
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L204
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
	bc 4,0,.L204
	fmr 31,1
.L204:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,892
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L205
.L203:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe35:
	.size	 PlayersRangeFromSpot,.Lfe35-PlayersRangeFromSpot
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
	bc 4,2,.L254
	bl SelectRandomDeathmatchSpawnPoint
	b .L609
.L254:
	bl SelectFarthestDeathmatchSpawnPoint
.L609:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 SelectDeathmatchSpawnPoint,.Lfe36-SelectDeathmatchSpawnPoint
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
	lis 9,0xd2b3
	lwz 10,game+1028@l(11)
	ori 9,9,6203
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,4
	bc 12,2,.L610
.L260:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L261
	li 3,0
	b .L610
.L261:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L262
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L262:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L260
	addic. 31,31,-1
	bc 4,2,.L260
	mr 3,30
.L610:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 SelectCoopSpawnPoint,.Lfe37-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC214:
	.long 0x3f800000
	.align 2
.LC215:
	.long 0x0
	.align 2
.LC216:
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
	bc 4,0,.L304
	lis 29,gi@ha
	lis 3,.LC85@ha
	la 29,gi@l(29)
	la 3,.LC85@l(3)
	lwz 9,36(29)
	lis 27,.LC86@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC214@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC214@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC214@ha
	la 9,.LC214@l(9)
	lfs 2,0(9)
	lis 9,.LC215@ha
	la 9,.LC215@l(9)
	lfs 3,0(9)
	blrl
.L308:
	mr 3,31
	la 4,.LC86@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L308
	lis 9,.LC216@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC216@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L304:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 body_die,.Lfe38-body_die
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
	bc 4,1,.L458
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L457
.L458:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L457:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe39:
	.size	 PM_trace,.Lfe39-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L462
.L464:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L464
.L462:
	mr 3,11
	blr
.Lfe40:
	.size	 CheckBlock,.Lfe40-CheckBlock
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
.L612:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L612
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L611:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L611
	lis 3,.LC180@ha
	la 3,.LC180@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 PrintPmove,.Lfe41-PrintPmove
	.section	".rodata"
	.align 2
.LC217:
	.long 0x40800000
	.section	".text"
	.align 2
	.globl ZBOT_StartScan
	.type	 ZBOT_StartScan,@function
ZBOT_StartScan:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 28,gi@ha
	mr 27,3
	la 28,gi@l(28)
	li 3,11
	lwz 9,100(28)
	lis 29,.LC196@ha
	la 29,.LC196@l(29)
	mtlr 9
	blrl
	lwz 9,116(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,92(28)
	li 4,1
	mr 3,27
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,11
	lis 29,.LC197@ha
	la 29,.LC197@l(29)
	mtlr 9
	blrl
	lwz 9,116(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 0,92(28)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 10,84(27)
	li 0,0
	lis 9,.LC217@ha
	la 9,.LC217@l(9)
	lis 11,level+4@ha
	stw 0,3476(10)
	lfs 12,0(9)
	lfs 0,level+4@l(11)
	lwz 10,84(27)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,3468(10)
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe42:
	.size	 ZBOT_StartScan,.Lfe42-ZBOT_StartScan
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
	bc 4,2,.L18
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
.L18:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe43:
	.size	 SP_CreateCoopSpots,.Lfe43-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
