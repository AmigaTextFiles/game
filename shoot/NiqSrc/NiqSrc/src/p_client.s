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
	.globl num_dm_spots
	.section	".sdata","aw"
	.align 2
	.type	 num_dm_spots,@object
	.size	 num_dm_spots,4
num_dm_spots:
	.long 0
	.section	".rodata"
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
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC6@ha
	la 3,level+72@l(31)
	la 4,.LC6@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC7@ha
	la 3,level+72@l(31)
	la 4,.LC7@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC8@ha
	la 3,level+72@l(31)
	la 4,.LC8@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC9@ha
	la 3,level+72@l(31)
	la 4,.LC9@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC10@ha
	la 3,level+72@l(31)
	la 4,.LC10@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC11@ha
	la 3,level+72@l(31)
	la 4,.LC11@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC12@ha
	la 3,level+72@l(31)
	la 4,.LC12@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC13@ha
	la 3,level+72@l(31)
	la 4,.LC13@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC14@ha
	la 3,level+72@l(31)
	la 4,.LC14@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC15@ha
	la 3,level+72@l(31)
	la 4,.LC15@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC16@ha
	la 3,level+72@l(31)
	la 4,.LC16@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC17@ha
	la 3,level+72@l(31)
	la 4,.LC17@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC18@ha
	la 3,level+72@l(31)
	la 4,.LC18@l(4)
	bl stricmp
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
	.align 2
.LC77:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 11,.LC76@ha
	lis 9,coop@ha
	la 11,.LC76@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 29,5
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L33
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L33
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L33:
	lis 11,.LC76@ha
	lis 9,deathmatch@ha
	la 11,.LC76@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L35
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L34
.L35:
	lis 9,meansOfDeath@ha
	lis 11,.LC22@ha
	lwz 0,meansOfDeath@l(9)
	la 30,.LC22@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	rlwinm 27,0,0,4,4
	addi 10,28,-17
	cmplwi 0,10,16
	bc 12,1,.L36
	lis 11,.L51@ha
	slwi 10,10,2
	la 11,.L51@l(11)
	lis 9,.L51@ha
	lwzx 0,10,11
	la 9,.L51@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L51:
	.long .L40-.L51
	.long .L41-.L51
	.long .L42-.L51
	.long .L39-.L51
	.long .L36-.L51
	.long .L38-.L51
	.long .L37-.L51
	.long .L36-.L51
	.long .L44-.L51
	.long .L44-.L51
	.long .L50-.L51
	.long .L45-.L51
	.long .L50-.L51
	.long .L46-.L51
	.long .L50-.L51
	.long .L36-.L51
	.long .L47-.L51
.L37:
	lis 9,.LC23@ha
	la 6,.LC23@l(9)
	b .L36
.L38:
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
	b .L36
.L39:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L36
.L40:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L36
.L41:
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L36
.L42:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L36
.L44:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L36
.L45:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L36
.L46:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L36
.L47:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L36
.L50:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
.L36:
	cmpw 0,29,31
	bc 4,2,.L53
	addi 10,28,-7
	cmplwi 0,10,17
	bc 12,1,.L70
	lis 11,.L76@ha
	slwi 10,10,2
	la 11,.L76@l(11)
	lis 9,.L76@ha
	lwzx 0,10,11
	la 9,.L76@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L76:
	.long .L57-.L76
	.long .L70-.L76
	.long .L63-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L69-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L57-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L70-.L76
	.long .L55-.L76
.L55:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L53
.L57:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L59
	li 0,0
	b .L60
.L59:
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
.L60:
	cmpwi 0,0,0
	bc 12,2,.L58
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L53
.L58:
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L53
.L63:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L65
	li 0,0
	b .L66
.L65:
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
.L66:
	cmpwi 0,0,0
	bc 12,2,.L64
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L53
.L64:
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L53
.L69:
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L53
.L70:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L72
	li 0,0
	b .L73
.L72:
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
.L73:
	cmpwi 0,0,0
	bc 12,2,.L71
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L53
.L71:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
.L53:
	cmpwi 0,6,0
	bc 12,2,.L77
	lwz 5,84(31)
	lis 4,.LC42@ha
	li 3,1
	la 4,.LC42@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 13,0(9)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L78
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L79
	mr 3,31
	bl niq_suicide
	b .L78
.L79:
	lwz 9,84(31)
	lis 11,.LC77@ha
	la 11,.LC77@l(11)
	lfs 0,3512(9)
	lfs 13,0(11)
	fsubs 0,0,13
	stfs 0,3512(9)
	lwz 11,84(31)
	lwz 9,3880(11)
	cmpwi 0,9,0
	bc 12,2,.L78
	lfs 0,144(9)
	fsubs 0,0,13
	stfs 0,144(9)
.L78:
	li 0,0
	stw 0,540(31)
	b .L32
.L77:
	cmpwi 0,29,0
	stw 29,540(31)
	bc 12,2,.L34
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L34
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
	la 30,.LC46@l(11)
	b .L83
.L87:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L83
.L88:
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 6,.LC48@l(9)
	la 30,.LC49@l(11)
	b .L83
.L89:
	lis 9,.LC50@ha
	lis 11,.LC51@ha
	la 6,.LC50@l(9)
	la 30,.LC51@l(11)
	b .L83
.L90:
	lis 9,.LC52@ha
	lis 11,.LC53@ha
	la 6,.LC52@l(9)
	la 30,.LC53@l(11)
	b .L83
.L91:
	lis 9,.LC54@ha
	lis 11,.LC55@ha
	la 6,.LC54@l(9)
	la 30,.LC55@l(11)
	b .L83
.L92:
	lis 9,.LC56@ha
	lis 11,.LC55@ha
	la 6,.LC56@l(9)
	la 30,.LC55@l(11)
	b .L83
.L93:
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 6,.LC57@l(9)
	la 30,.LC58@l(11)
	b .L83
.L94:
	lis 9,.LC59@ha
	la 6,.LC59@l(9)
	b .L83
.L95:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 30,.LC61@l(11)
	b .L83
.L96:
	lis 9,.LC62@ha
	lis 11,.LC63@ha
	la 6,.LC62@l(9)
	la 30,.LC63@l(11)
	b .L83
.L97:
	lis 9,.LC64@ha
	lis 11,.LC61@ha
	la 6,.LC64@l(9)
	la 30,.LC61@l(11)
	b .L83
.L98:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 6,.LC65@l(9)
	la 30,.LC66@l(11)
	b .L83
.L99:
	lis 9,.LC67@ha
	lis 11,.LC66@ha
	la 6,.LC67@l(9)
	la 30,.LC66@l(11)
	b .L83
.L100:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 6,.LC68@l(9)
	la 30,.LC69@l(11)
	b .L83
.L101:
	lis 9,.LC70@ha
	lis 11,.LC71@ha
	la 6,.LC70@l(9)
	la 30,.LC71@l(11)
	b .L83
.L102:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 6,.LC72@l(9)
	la 30,.LC73@l(11)
.L83:
	cmpwi 0,6,0
	bc 12,2,.L34
	lis 11,.LC76@ha
	lis 9,niq_enable@ha
	la 11,.LC76@l(11)
	lfs 31,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L106
	mr 3,31
	mr 4,29
	mr 5,27
	mr 7,30
	bl niq_kill
	b .L32
.L106:
	lwz 5,84(31)
	lis 4,.LC74@ha
	addi 7,7,700
	la 4,.LC74@l(4)
	mr 8,30
	addi 5,5,700
	li 3,1
	crxor 6,6,6
	bl my_bprintf
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L32
	cmpwi 0,27,0
	bc 12,2,.L109
	lwz 9,84(29)
	lis 11,.LC77@ha
	la 11,.LC77@l(11)
	lfs 13,0(11)
	lfs 0,3512(9)
	fsubs 0,0,13
	stfs 0,3512(9)
	lwz 11,84(29)
	lwz 4,3880(11)
	cmpwi 0,4,0
	bc 12,2,.L32
	lfs 0,144(4)
	fsubs 0,0,13
	stfs 0,144(4)
	b .L32
.L109:
	lwz 9,84(29)
	lis 11,.LC77@ha
	la 11,.LC77@l(11)
	lfs 13,0(11)
	lfs 0,3512(9)
	fadds 0,0,13
	stfs 0,3512(9)
	lwz 11,84(29)
	lwz 4,3880(11)
	cmpwi 0,4,0
	bc 12,2,.L32
	lfs 0,144(4)
	fadds 0,0,13
	stfs 0,144(4)
	b .L32
.L34:
	lwz 5,84(31)
	lis 4,.LC75@ha
	li 3,1
	la 4,.LC75@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 13,0(9)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L32
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L114
	mr 3,31
	bl niq_die
	b .L32
.L114:
	lwz 9,84(31)
	lis 11,.LC77@ha
	la 11,.LC77@l(11)
	lfs 13,0(11)
	lfs 0,3512(9)
	fsubs 0,0,13
	stfs 0,3512(9)
	lwz 11,84(31)
	lwz 3,3880(11)
	cmpwi 0,3,0
	bc 12,2,.L32
	lfs 0,144(3)
	fsubs 0,0,13
	stfs 0,144(3)
.L32:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
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
	lis 9,niq_enable@ha
	lis 10,.LC81@ha
	lwz 11,niq_enable@l(9)
	la 10,.LC81@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L117
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L117
	lwz 9,84(30)
	lwz 11,3592(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L122
	lwz 3,40(31)
	lis 4,.LC78@ha
	la 4,.LC78@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L122:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L123
	li 29,0
	b .L124
.L123:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC82@ha
	lfs 12,3788(8)
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
.L124:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC81@ha
	and. 10,0,29
	la 9,.LC81@l(9)
	lfs 31,0(9)
	bc 12,2,.L125
	lis 11,.LC83@ha
	la 11,.LC83@l(11)
	lfs 31,0(11)
.L125:
	cmpwi 0,31,0
	bc 12,2,.L127
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3720(9)
	fsubs 0,0,31
	stfs 0,3720(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3720(9)
	fadds 0,0,31
	stfs 0,3720(9)
	stw 0,284(3)
.L127:
	cmpwi 0,29,0
	bc 12,2,.L117
	lwz 9,84(30)
	lis 3,.LC79@ha
	la 3,.LC79@l(3)
	lfs 0,3720(9)
	fadds 0,0,31
	stfs 0,3720(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC82@ha
	lis 11,Touch_Item@ha
	la 9,.LC82@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3720(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC80@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC80@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3720(7)
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
	lfs 0,3788(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L117:
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
.LC86:
	.string	"misc/udeath.wav"
	.align 2
.LC87:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.39:
	.space	4
	.size	 i.39,4
	.section	".rodata"
	.align 2
.LC88:
	.string	"*death%i.wav"
	.align 3
.LC85:
	.long 0x404ca5dc
	.long 0x1a63c1f8
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
	stwu 1,-352(1)
	mflr 0
	stmw 26,328(1)
	stw 0,356(1)
	mr 31,3
	li 0,0
	li 10,0
	li 9,1
	lwz 8,84(31)
	li 11,7
	stw 9,512(31)
	lis 7,0xc100
	stw 0,24(31)
	mr 30,4
	mr 28,5
	stw 0,396(31)
	mr 26,6
	stw 0,392(31)
	stw 0,388(31)
	stw 0,16(31)
	stw 11,260(31)
	stw 10,44(31)
	stw 10,48(31)
	stw 10,76(31)
	stw 10,3816(8)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 7,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L135
	lis 9,level+4@ha
	lis 11,.LC89@ha
	lfs 0,level+4@l(9)
	la 11,.LC89@l(11)
	cmpwi 0,28,0
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3824(11)
	bc 12,2,.L136
	lis 9,g_edicts@ha
	xor 11,28,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,28,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L136
	lfs 11,4(31)
	lfs 13,4(28)
	lfs 12,8(28)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(28)
	b .L161
.L136:
	cmpwi 0,30,0
	bc 12,2,.L138
	lis 9,g_edicts@ha
	xor 11,30,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,30,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L138
	lfs 11,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(30)
.L161:
	lfs 11,12(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	b .L137
.L138:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3644(9)
	b .L140
.L137:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC85@ha
	lwz 11,84(31)
	lfd 0,.LC85@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3644(11)
.L140:
	lwz 9,84(31)
	li 0,2
	mr 3,31
	mr 4,30
	mr 5,28
	stw 0,0(9)
	lis 27,gi@ha
	bl ClientObituary
	lis 9,.LC90@ha
	la 9,.LC90@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L141
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L141
	addi 29,1,24
	lis 4,level@ha
	la 4,level@l(4)
	li 5,304
	mr 3,29
	crxor 6,6,6
	bl memcpy
	la 3,gi@l(27)
	mr 4,29
	mr 5,31
	mr 6,30
	mr 7,28
	bl sl_WriteStdLogDeath
.L141:
	mr 4,30
	mr 5,28
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
	lis 9,.LC90@ha
	lis 11,deathmatch@ha
	la 9,.LC90@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L135
	mr 3,31
	bl Cmd_Help_f
.L135:
	lwz 11,84(31)
	li 0,0
	li 4,0
	li 5,1024
	stw 0,3788(11)
	lwz 9,84(31)
	stw 0,3792(9)
	lwz 11,84(31)
	stw 0,3796(11)
	lwz 9,84(31)
	stw 0,3800(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,0,.L143
	lis 29,gi@ha
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	lis 28,.LC87@ha
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
.L147:
	mr 3,31
	la 4,.LC87@l(28)
	mr 5,26
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L147
	mr 4,26
	mr 3,31
	bl ThrowClientHead
	lwz 9,84(31)
	li 0,5
	stw 0,3776(9)
	lwz 11,84(31)
	stw 30,3772(11)
	stw 30,512(31)
	b .L149
.L143:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L149
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
	stw 7,3776(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L151
	li 0,172
	li 9,177
	b .L162
.L151:
	cmpwi 0,10,1
	bc 12,2,.L155
	bc 12,1,.L159
	cmpwi 0,10,0
	bc 12,2,.L154
	b .L152
.L159:
	cmpwi 0,10,2
	bc 12,2,.L156
	b .L152
.L154:
	li 0,177
	li 9,183
	b .L162
.L155:
	li 0,183
	li 9,189
	b .L162
.L156:
	li 0,189
	li 9,197
.L162:
	stw 0,56(31)
	stw 9,3772(11)
.L152:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC88@ha
	srwi 0,0,30
	la 3,.LC88@l(3)
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
.L149:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,.LC90@ha
	lis 11,niq_enable@ha
	la 9,.LC90@l(9)
	lfs 13,0(9)
	lwz 9,niq_enable@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L160
	mr 3,31
	bl niq_removeallweapons
.L160:
	lwz 0,356(1)
	mtlr 0
	lmw 26,328(1)
	la 1,352(1)
	blr
.Lfe4:
	.size	 player_die,.Lfe4-player_die
	.section	".rodata"
	.align 2
.LC92:
	.string	"Grapple"
	.align 2
.LC93:
	.string	"Hook"
	.align 2
.LC94:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 11,.LC94@ha
	lis 9,niq_enable@ha
	la 11,.LC94@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L164
	bl niq_InitClientPersistant
	b .L165
.L164:
	li 4,0
	li 5,1636
	addi 3,31,188
	lis 30,0x38e3
	crxor 6,6,6
	bl memset
	ori 30,30,36409
	addi 29,31,740
	lis 3,.LC78@ha
	li 27,1
	la 3,.LC78@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 11,grapple@ha
	la 28,itemlist@l(9)
	lwz 10,grapple@l(11)
	subf 0,28,3
	mullw 0,0,30
	srawi 0,0,3
	stw 0,736(31)
	slwi 9,0,2
	stwx 27,29,9
	stw 3,1792(31)
	stw 3,1788(31)
	lfs 0,20(10)
	fcmpu 0,0,31
	bc 12,2,.L166
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	bl FindItem
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	stwx 27,29,3
.L166:
	lis 9,niq_tractor@ha
	lwz 11,niq_tractor@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L167
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	bl FindItem
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	stwx 27,29,3
.L167:
	li 0,100
	li 9,50
	stw 27,720(31)
	li 11,200
	stw 0,1768(31)
	stw 11,1780(31)
	stw 9,1784(31)
	stw 0,724(31)
	stw 0,728(31)
	stw 11,1764(31)
	stw 9,1772(31)
	stw 9,1776(31)
.L165:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 InitClientPersistant,.Lfe5-InitClientPersistant
	.globl is_bot
	.section	".sdata","aw"
	.align 2
	.type	 is_bot,@object
	.size	 is_bot,4
is_bot:
	.long 0
	.section	".rodata"
	.align 2
.LC96:
	.long 0x47c34f80
	.align 2
.LC97:
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
	lis 11,.LC96@ha
	lwz 0,num_dm_spots@l(9)
	li 28,0
	li 24,0
	lfs 30,.LC96@l(11)
	li 25,0
	lis 21,num_dm_spots@ha
	cmpwi 0,0,0
	fmr 29,30
	bc 4,1,.L195
	lis 9,dm_spots@ha
	lis 22,.LC97@ha
	la 27,dm_spots@l(9)
	lis 26,num_players@ha
	lis 23,players@ha
.L196:
	lwz 0,num_players@l(26)
	li 29,0
	addi 28,28,1
	lwz 31,0(27)
	cmpw 0,29,0
	addi 27,27,4
	lfs 31,.LC97@l(22)
	bc 4,0,.L204
	la 30,players@l(23)
.L199:
	lwz 9,0(30)
	addi 30,30,4
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L201
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L201
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
	bc 4,0,.L201
	fmr 31,1
.L201:
	lwz 0,num_players@l(26)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L199
.L204:
	fcmpu 0,31,29
	bc 4,0,.L206
	fmr 29,31
	mr 25,31
	b .L194
.L206:
	fcmpu 0,31,30
	bc 4,0,.L194
	fmr 30,31
	mr 24,31
.L194:
	lwz 0,num_dm_spots@l(21)
	cmpw 0,28,0
	bc 12,0,.L196
.L195:
	cmpwi 0,28,0
	bc 4,2,.L210
	li 3,0
	b .L218
.L210:
	cmpwi 0,28,2
	bc 12,1,.L211
	li 24,0
	li 25,0
	b .L212
.L211:
	addi 28,28,-2
.L212:
	bl rand
	divw 0,3,28
	lis 9,dm_spots@ha
	la 10,dm_spots@l(9)
	mullw 0,0,28
	subf 3,0,3
.L217:
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
	bc 4,2,.L217
	mr 3,31
.L218:
	lwz 0,100(1)
	mtlr 0
	lmw 21,28(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe6:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe6-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC98:
	.long 0x4b18967f
	.align 2
.LC99:
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
	lis 9,.LC99@ha
	cmpw 0,25,0
	la 9,.LC99@l(9)
	lfs 30,0(9)
	bc 4,0,.L221
	lis 9,dm_spots@ha
	lis 23,.LC98@ha
	la 28,dm_spots@l(9)
	lis 26,num_players@ha
	lis 24,players@ha
.L222:
	lwz 0,num_players@l(26)
	li 29,0
	addi 27,27,1
	lwz 30,0(28)
	cmpw 0,29,0
	addi 28,28,4
	lfs 31,.LC98@l(23)
	bc 4,0,.L230
	la 31,players@l(24)
.L225:
	lwz 9,0(31)
	addi 31,31,4
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L227
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L227
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
	bc 4,0,.L227
	fmr 31,1
.L227:
	lwz 0,num_players@l(26)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L225
.L230:
	fcmpu 0,31,30
	bc 4,1,.L220
	fmr 30,31
	mr 25,30
.L220:
	lwz 0,num_dm_spots@l(22)
	cmpw 0,27,0
	bc 12,0,.L222
.L221:
	cmpwi 0,25,0
	bc 4,2,.L234
	lis 9,dm_spots@ha
	lwz 3,dm_spots@l(9)
	b .L235
.L234:
	mr 3,25
.L235:
	lwz 0,84(1)
	mtlr 0
	lmw 22,24(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe7:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe7-SelectFarthestDeathmatchSpawnPoint
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
	stmw 25,36(1)
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
	bc 12,2,.L250
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L251
	bl SelectCTFSpawnPoint
	mr 31,3
	b .L256
.L251:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L253
	bl SelectFarthestDeathmatchSpawnPoint
	mr 31,3
	b .L256
.L253:
	bl SelectRandomDeathmatchSpawnPoint
	mr 31,3
	b .L256
.L280:
	li 31,0
	b .L256
.L250:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L256
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xbdef
	lwz 10,game+1028@l(11)
	ori 9,9,31711
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 30,0,7
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
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 SelectSpawnPoint,.Lfe8-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC103:
	.string	"bodyque"
	.align 3
.LC104:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC105:
	.long 0xc1700000
	.align 2
.LC106:
	.long 0xc1c00000
	.align 2
.LC107:
	.long 0x41700000
	.align 2
.LC108:
	.long 0x0
	.align 2
.LC109:
	.long 0xc3000000
	.align 2
.LC110:
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
	lis 9,.LC105@ha
	lis 10,.LC105@ha
	la 9,.LC105@l(9)
	la 10,.LC105@l(10)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC106@ha
	lfs 2,0(10)
	la 9,.LC106@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC107@ha
	lfs 13,0(11)
	la 9,.LC107@l(9)
	lis 10,.LC107@ha
	lfs 1,0(9)
	la 10,.LC107@l(10)
	lis 9,.LC107@ha
	lfs 2,0(10)
	stfs 13,188(31)
	la 9,.LC107@l(9)
	lfs 0,4(11)
	lfs 3,0(9)
	stfs 0,192(31)
	lfs 13,8(11)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lis 9,.LC108@ha
	lfs 13,0(11)
	la 9,.LC108@l(9)
	lis 10,.LC108@ha
	lfs 1,0(9)
	la 10,.LC108@l(10)
	lis 9,.LC109@ha
	lfs 2,0(10)
	stfs 13,200(31)
	la 9,.LC109@l(9)
	lfs 0,4(11)
	lfs 3,0(9)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 10,.LC110@ha
	lfs 0,0(11)
	la 10,.LC110@l(10)
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
	bc 12,2,.L289
	lis 9,level+4@ha
	lis 11,.LC104@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC104@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L289:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe9:
	.size	 Body_droptofloor,.Lfe9-Body_droptofloor
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
	mulli 27,27,1332
	addi 27,27,1332
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
	lis 9,0xf3b3
	lis 11,body_die@ha
	ori 9,9,8069
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
.Lfe10:
	.size	 CopyToBodyQue,.Lfe10-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC111:
	.string	"menu_loadgame\n"
	.align 2
.LC112:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC113:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC114:
	.string	"player"
	.align 2
.LC115:
	.string	"players/male/tris.md2"
	.align 2
.LC116:
	.string	"fov"
	.align 2
.LC117:
	.long 0x0
	.align 2
.LC118:
	.long 0x41400000
	.align 2
.LC119:
	.long 0x41000000
	.align 3
.LC120:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC121:
	.long 0x3f800000
	.align 2
.LC122:
	.long 0x43200000
	.align 2
.LC123:
	.long 0x47800000
	.align 2
.LC124:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4560(1)
	mflr 0
	stfd 31,4552(1)
	stmw 17,4492(1)
	stw 0,4564(1)
	lis 9,.LC112@ha
	lis 30,the_client@ha
	lwz 4,.LC112@l(9)
	lis 11,.LC113@ha
	addi 8,1,8
	lwz 0,the_client@l(30)
	la 9,.LC112@l(9)
	la 7,.LC113@l(11)
	lwz 29,8(9)
	addi 5,1,24
	mr 31,3
	lwz 6,4(9)
	cmpwi 0,0,0
	stw 4,8(1)
	lwz 10,.LC113@l(11)
	stw 29,8(8)
	stw 6,4(8)
	lwz 0,8(7)
	lwz 9,4(7)
	stw 10,24(1)
	stw 0,8(5)
	stw 9,4(5)
	bc 4,2,.L302
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L302
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpwi 0,0,1
	bc 12,1,.L302
	stw 31,the_client@l(30)
.L302:
	addi 5,1,56
	mr 3,31
	mr 17,5
	addi 4,1,40
	bl SelectSpawnPoint
	lis 9,deathmatch@ha
	lis 8,.LC117@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	la 8,.LC117@l(8)
	lis 11,g_edicts@ha
	lfs 13,0(8)
	lis 0,0xf3b3
	lfs 0,20(10)
	ori 0,0,8069
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,2
	addi 18,9,-1
	bc 12,2,.L303
	addi 28,1,1720
	addi 27,30,1824
	addi 26,1,3448
	mr 4,27
	li 5,1716
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 19,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 24,27
	crxor 6,6,6
	bl memcpy
	mr 23,29
	addi 20,30,20
	mr 3,30
	addi 25,1,72
	bl niq_handleclientinit
	addi 21,30,3492
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L304
.L303:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L305
	addi 27,1,1720
	addi 26,30,1824
	addi 29,1,3960
	mr 4,26
	li 5,1716
	mr 3,27
	crxor 6,6,6
	bl memcpy
	addi 28,30,188
	mr 22,29
	mr 3,29
	mr 4,28
	li 5,512
	mr 19,27
	crxor 6,6,6
	bl memcpy
	mr 24,26
	mr 23,28
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	addi 25,1,72
	addi 20,30,20
	addi 9,9,56
	addi 21,30,3492
	addi 10,1,2272
	addi 11,30,740
.L343:
	lwz 0,0(9)
	addi 9,9,72
	andi. 8,0,16
	bc 12,2,.L308
	lwz 0,0(11)
	stw 0,0(10)
.L308:
	addi 10,10,4
	addi 11,11,4
	bdnz .L343
	mr 4,19
	li 5,1636
	mr 3,23
	crxor 6,6,6
	bl memcpy
	mr 4,22
	mr 3,31
	bl ClientUserinfoChanged
	lfs 13,3408(1)
	lfs 0,1800(30)
	fcmpu 0,13,0
	bc 4,1,.L304
	stfs 13,1800(30)
	b .L304
.L305:
	addi 29,1,1720
	li 4,0
	mr 3,29
	li 5,1716
	crxor 6,6,6
	bl memset
	mr 19,29
	addi 24,30,1824
	addi 23,30,188
	addi 25,1,72
	addi 20,30,20
	addi 21,30,3492
.L304:
	mr 4,23
	li 5,1636
	mr 3,25
	crxor 6,6,6
	bl memcpy
	lwz 27,3880(30)
	li 4,0
	li 5,3968
	lwz 28,3892(30)
	mr 3,30
	lwz 29,3896(30)
	lfs 31,3888(30)
	crxor 6,6,6
	bl memset
	mr 4,25
	li 5,1636
	mr 3,23
	crxor 6,6,6
	bl memcpy
	mr 3,24
	mr 4,19
	li 5,1716
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	stw 27,3880(30)
	cmpwi 0,0,0
	stw 28,3892(30)
	stw 29,3896(30)
	stfs 31,3888(30)
	bc 12,1,.L314
	mr 3,30
	bl InitClientPersistant
.L314:
	lwz 11,84(31)
	lwz 0,724(11)
	stw 0,480(31)
	lwz 9,728(11)
	stw 9,484(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L315
	lwz 0,264(31)
	ori 0,0,4096
	stw 0,264(31)
.L315:
	lis 9,coop@ha
	lis 8,.LC117@ha
	lwz 11,coop@l(9)
	la 8,.LC117@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L317
	lwz 9,84(31)
	lfs 0,1800(9)
	stfs 0,3512(9)
.L317:
	lwz 0,968(31)
	li 29,0
	stw 29,552(31)
	cmpwi 0,0,0
	bc 4,2,.L318
	lis 9,game+1028@ha
	mulli 11,18,3968
	lwz 0,game+1028@l(9)
	add 0,0,11
	stw 0,84(31)
.L318:
	li 9,22
	lis 11,.LC114@ha
	stw 29,492(31)
	stw 9,508(31)
	li 6,2
	la 11,.LC114@l(11)
	li 0,4
	li 10,1
	stw 11,280(31)
	li 8,200
	lis 9,.LC118@ha
	stw 0,260(31)
	la 9,.LC118@l(9)
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
	lis 9,.LC115@ha
	la 9,.LC115@l(9)
	stw 0,252(31)
	fadds 0,0,13
	cmpwi 0,11,0
	stw 9,268(31)
	stfs 0,404(31)
	bc 4,2,.L319
	lis 9,player_pain@ha
	lis 11,player_die@ha
	la 9,player_pain@l(9)
	la 11,player_die@l(11)
	stw 9,452(31)
	stw 11,456(31)
.L319:
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
	lis 8,.LC119@ha
	lfs 0,40(1)
	la 8,.LC119@l(8)
	mr 11,9
	lbz 0,16(30)
	lfs 10,0(8)
	mr 10,9
	andi. 0,0,191
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4480(1)
	lwz 9,4484(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4480(1)
	lwz 11,4484(1)
	sth 11,6(30)
	lfs 0,48(1)
	stb 0,16(30)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4480(1)
	lwz 10,4484(1)
	sth 10,8(30)
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L320
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L321
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4480(1)
	lwz 11,4484(1)
	andi. 0,11,32768
	bc 4,2,.L344
.L321:
	lis 4,.LC116@ha
	mr 3,23
	la 4,.LC116@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4484(1)
	lis 0,0x4330
	lis 8,.LC120@ha
	la 8,.LC120@l(8)
	stw 0,4480(1)
	lis 11,.LC121@ha
	lfd 13,0(8)
	la 11,.LC121@l(11)
	lfd 0,4480(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L323
.L344:
	lis 0,0x42b4
	stw 0,112(30)
	b .L322
.L323:
	lis 8,.LC122@ha
	la 8,.LC122@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L322
	stfs 13,112(30)
.L322:
	lis 9,.LC117@ha
	lis 11,niq_enable@ha
	la 9,.LC117@l(9)
	lfs 13,0(9)
	lwz 9,niq_enable@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L320
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	stw 3,88(30)
.L320:
	lis 11,g_edicts@ha
	lis 10,0xf3b3
	lwz 9,g_edicts@l(11)
	ori 10,10,8069
	li 29,0
	lis 11,niq_enable@ha
	li 0,255
	subf 9,9,31
	lwz 8,niq_enable@l(11)
	mullw 9,9,10
	lis 11,.LC117@ha
	stw 0,40(31)
	la 11,.LC117@l(11)
	stw 29,64(31)
	srawi 9,9,2
	lfs 13,0(11)
	addi 9,9,-1
	stw 9,60(31)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 4,2,.L327
	mr 3,31
	bl ShowGun
.L327:
	lis 8,.LC121@ha
	lfs 0,48(1)
	lis 9,.LC123@ha
	la 8,.LC121@l(8)
	li 0,3
	lfs 11,40(1)
	lfs 13,0(8)
	la 9,.LC123@l(9)
	lis 11,.LC124@ha
	mtctr 0
	lfs 12,44(1)
	la 11,.LC124@l(11)
	mr 5,17
	lfs 9,0(9)
	mr 8,21
	mr 10,20
	fadds 0,0,13
	lfs 10,0(11)
	stw 29,56(31)
	li 11,0
	stfs 11,28(31)
	stfs 12,32(31)
	stfs 0,36(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 0,12(31)
.L342:
	lfsx 0,11,5
	lfsx 12,11,8
	addi 11,11,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4480(1)
	lwz 9,4484(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L342
	lis 8,.LC117@ha
	lfs 0,60(1)
	mr 3,31
	la 8,.LC117@l(8)
	lfs 31,0(8)
	stfs 0,20(31)
	stfs 31,24(31)
	stfs 31,16(31)
	stfs 31,28(30)
	lfs 0,20(31)
	stfs 0,32(30)
	lfs 13,24(31)
	stfs 13,36(30)
	lfs 0,16(31)
	stfs 0,3716(30)
	lfs 13,20(31)
	stfs 13,3720(30)
	lfs 0,24(31)
	stfs 0,3724(30)
	bl NIQStartClient
	cmpwi 0,3,0
	bc 4,2,.L301
	mr 3,31
	bl CTFStartClient
	cmpwi 0,3,0
	bc 4,2,.L301
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L335
	mr 3,31
	bl niq_updatescreen
.L335:
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,504(31)
	cmpwi 0,0,0
	bc 4,2,.L337
	lwz 3,84(31)
	addi 3,3,700
	bl G_CopyString
	stw 3,504(31)
.L337:
	lwz 0,1788(30)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	stw 0,3612(30)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L338
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L338
	mr 3,31
	bl ChangeWeapon
.L338:
	lis 9,niq_enable@ha
	lis 8,.LC117@ha
	lwz 11,niq_enable@l(9)
	la 8,.LC117@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L340
	mr 3,30
	bl niq_settimers
	mr 3,31
	bl ShowGun
.L340:
	lis 9,niq_tractor@ha
	lwz 11,niq_tractor@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L301
	lwz 3,3956(30)
	cmpwi 0,3,0
	bc 12,2,.L301
	bl hook_reset
	li 0,0
	stw 0,3964(30)
.L301:
	lwz 0,4564(1)
	mtlr 0
	lmw 17,4492(1)
	lfd 31,4552(1)
	la 1,4560(1)
	blr
.Lfe11:
	.size	 PutClientInServer,.Lfe11-PutClientInServer
	.section	".rodata"
	.align 2
.LC125:
	.string	"%s joins NIQ, %d client(s)\n"
	.align 2
.LC126:
	.string	"alias +hook \"cmd hook\"\n"
	.align 2
.LC127:
	.string	"alias -hook \"cmd unhook\"\n"
	.align 2
.LC128:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-352(1)
	mflr 0
	stfd 31,344(1)
	stmw 27,324(1)
	stw 0,356(1)
	mr 30,3
	bl G_InitEdict
	lis 9,.LC128@ha
	lis 11,ctf@ha
	la 9,.LC128@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L346
	lwz 9,84(30)
	li 0,0
	stw 0,3880(9)
.L346:
	lwz 31,84(30)
	li 4,0
	li 5,1716
	lwz 29,3464(31)
	addi 3,31,1824
	crxor 6,6,6
	bl memset
	lis 9,is_bot@ha
	stw 29,3464(31)
	lwz 0,is_bot@l(9)
	cmpwi 0,0,0
	bc 4,2,.L347
	lwz 0,1820(31)
	cmpwi 0,0,0
	bc 12,2,.L348
.L347:
	li 0,0
	b .L357
.L348:
	li 0,1
.L357:
	stw 0,3536(31)
	lis 9,level@ha
	addi 3,31,1824
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1636
	stw 0,3460(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC128@ha
	lis 11,ctf@ha
	la 9,.LC128@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L351
	lwz 0,3464(31)
	cmpwi 0,0,0
	bc 12,1,.L351
	lis 9,is_bot@ha
	mr 3,31
	lwz 4,is_bot@l(9)
	bl CTFAssignTeam
.L351:
	lis 9,.LC128@ha
	lis 27,niq_enable@ha
	la 9,.LC128@l(9)
	lfs 31,0(9)
	lwz 9,niq_enable@l(27)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L352
	mr 3,30
	bl niq_removeallweapons
.L352:
	mr 3,30
	lis 28,gi@ha
	bl PutClientInServer
	la 31,gi@l(28)
	mr 3,30
	bl EntityListAdd
	lwz 9,100(31)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xf3b3
	lwz 10,104(31)
	lwz 3,g_edicts@l(9)
	ori 0,0,8069
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,2
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
	lwz 0,184(30)
	andi. 9,0,1
	bc 4,2,.L353
	lwz 29,84(30)
	addi 29,29,700
	bl niq_getnumclients
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC125@ha
	la 4,.LC125@l(4)
	mr 5,29
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L353:
	lwz 9,niq_enable@l(27)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L354
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L354
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L355
	lwz 29,84(30)
	lwz 3,3464(29)
	addi 29,29,700
	bl CTFTeamName
	lis 9,level+4@ha
	mr 5,3
	lfs 1,level+4@l(9)
	mr 3,31
	mr 4,29
	bl sl_LogPlayerConnect
	b .L354
.L355:
	addi 29,1,8
	lis 4,level@ha
	la 4,level@l(4)
	li 5,304
	mr 3,29
	crxor 6,6,6
	bl memcpy
	mr 3,31
	mr 4,29
	mr 5,30
	bl sl_WriteStdLogPlayerEntered
.L354:
	mr 3,30
	bl ClientEndServerFrame
	lis 4,.LC126@ha
	mr 3,30
	la 4,.LC126@l(4)
	bl stuffcmd
	lis 4,.LC127@ha
	mr 3,30
	la 4,.LC127@l(4)
	bl stuffcmd
	lwz 0,356(1)
	mtlr 0
	lmw 27,324(1)
	lfd 31,344(1)
	la 1,352(1)
	blr
.Lfe12:
	.size	 ClientBeginDeathmatch,.Lfe12-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC129:
	.long 0x0
	.align 2
.LC130:
	.long 0x47800000
	.align 2
.LC131:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,g_edicts@ha
	mr 30,3
	lwz 9,g_edicts@l(11)
	lis 0,0xf3b3
	lis 4,num_players@ha
	lis 11,game+1028@ha
	ori 0,0,8069
	lwz 10,num_players@l(4)
	subf 9,9,30
	lwz 7,game+1028@l(11)
	lis 6,num_clients@ha
	mullw 9,9,0
	lis 11,deathmatch@ha
	lis 8,players@ha
	lwz 5,deathmatch@l(11)
	slwi 0,10,2
	la 8,players@l(8)
	srawi 9,9,2
	lis 11,.LC129@ha
	mulli 9,9,3968
	la 11,.LC129@l(11)
	addi 10,10,1
	lfs 13,0(11)
	addi 9,9,-3968
	lwz 11,num_clients@l(6)
	add 7,7,9
	stw 7,84(30)
	addi 11,11,1
	stwx 30,8,0
	lfs 0,20(5)
	stw 10,num_players@l(4)
	stw 11,num_clients@l(6)
	fcmpu 0,0,13
	bc 12,2,.L359
	bl ClientBeginDeathmatch
	b .L358
.L359:
	lwz 0,88(30)
	cmpwi 0,0,1
	bc 4,2,.L360
	lis 9,.LC130@ha
	lis 11,.LC131@ha
	li 0,3
	la 9,.LC130@l(9)
	la 11,.LC131@l(11)
	mtctr 0
	lfs 11,0(9)
	li 8,0
	lfs 12,0(11)
	li 7,0
.L376:
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
	stfd 13,24(1)
	lwz 11,28(1)
	sthx 11,10,0
	bdnz .L376
	b .L366
.L360:
	mr 3,30
	bl G_InitEdict
	lis 9,.LC114@ha
	lwz 31,84(30)
	li 4,0
	la 9,.LC114@l(9)
	li 5,1716
	stw 9,280(30)
	addi 3,31,1824
	lwz 29,3464(31)
	crxor 6,6,6
	bl memset
	lis 9,is_bot@ha
	stw 29,3464(31)
	lwz 0,is_bot@l(9)
	cmpwi 0,0,0
	bc 4,2,.L367
	lwz 0,1820(31)
	cmpwi 0,0,0
	bc 12,2,.L368
.L367:
	li 0,0
	b .L377
.L368:
	li 0,1
.L377:
	stw 0,3536(31)
	lis 9,level@ha
	addi 3,31,1824
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1636
	stw 0,3460(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC129@ha
	lis 11,ctf@ha
	la 9,.LC129@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L371
	lwz 0,3464(31)
	cmpwi 0,0,0
	bc 12,1,.L371
	lis 9,is_bot@ha
	mr 3,31
	lwz 4,is_bot@l(9)
	bl CTFAssignTeam
.L371:
	mr 3,30
	bl PutClientInServer
.L366:
	lis 11,.LC129@ha
	lis 9,level+200@ha
	la 11,.LC129@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L372
	mr 3,30
	bl MoveClientToIntermission
	b .L373
.L372:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L373
	lis 31,gi@ha
	li 3,1
	la 29,gi@l(31)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xf3b3
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,8069
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,2
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
	lwz 0,184(30)
	andi. 9,0,1
	bc 4,2,.L373
	lwz 29,84(30)
	addi 29,29,700
	bl niq_getnumclients
	lwz 0,gi@l(31)
	mr 6,3
	lis 4,.LC125@ha
	la 4,.LC125@l(4)
	mr 5,29
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L373:
	mr 3,30
	bl ClientEndServerFrame
.L358:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 ClientBegin,.Lfe13-ClientBegin
	.section	".rodata"
	.align 2
.LC132:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC133:
	.string	"name"
	.align 2
.LC134:
	.string	"%s\\%s"
	.align 2
.LC135:
	.string	"hand"
	.align 2
.LC136:
	.long 0x0
	.align 3
.LC137:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC138:
	.long 0x3f800000
	.align 2
.LC139:
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
	bc 4,2,.L379
	lis 11,.LC132@ha
	lwz 0,.LC132@l(11)
	la 9,.LC132@l(11)
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
.L379:
	lis 4,.LC133@ha
	mr 3,27
	la 4,.LC133@l(4)
	bl Info_ValueForKey
	lis 9,.LC136@ha
	mr 31,3
	la 9,.LC136@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L380
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L380
	lwz 3,84(30)
	addi 3,3,700
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L380
	lwz 3,84(30)
	mr 4,31
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L380
	lis 9,level+4@ha
	lwz 4,84(30)
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	la 3,gi@l(3)
	mr 5,31
	addi 4,4,700
	bl sl_LogPlayerRename
.L380:
	lwz 3,84(30)
	mr 4,31
	li 5,15
	addi 3,3,700
	bl strncpy
	lwz 9,84(30)
	lwz 9,3880(9)
	cmpwi 0,9,0
	bc 12,2,.L384
	lwz 3,8(9)
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L383
.L384:
	lis 4,.LC21@ha
	mr 3,27
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lis 9,ctf@ha
	lis 11,g_edicts@ha
	lwz 10,ctf@l(9)
	mr 31,3
	lis 9,.LC136@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC136@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,30
	lis 9,0xf3b3
	ori 9,9,8069
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,2
	bc 12,2,.L385
	mr 4,31
	mr 3,30
	bl CTFAssignSkin
	b .L387
.L385:
	lwz 4,84(30)
	lis 29,gi@ha
	lis 3,.LC134@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC134@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	b .L387
.L383:
	lwz 9,84(30)
	lwz 11,3880(9)
	lwz 3,8(11)
	bl G_CopyString
	lis 9,g_edicts@ha
	lis 0,0xf3b3
	lwz 4,84(30)
	lwz 29,g_edicts@l(9)
	ori 0,0,8069
	mr 31,3
	lis 28,gi@ha
	lis 3,.LC134@ha
	subf 29,29,30
	la 28,gi@l(28)
	mullw 29,29,0
	addi 4,4,700
	mr 5,31
	la 3,.LC134@l(3)
	srawi 29,29,2
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
.L387:
	lis 9,.LC136@ha
	lis 11,deathmatch@ha
	la 9,.LC136@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L388
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L388
	lwz 9,84(30)
	b .L394
.L388:
	lis 4,.LC116@ha
	mr 3,27
	la 4,.LC116@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(30)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC137@ha
	la 10,.LC137@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC138@ha
	la 10,.LC138@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(30)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L390
.L394:
	lis 0,0x42b4
	stw 0,112(9)
	b .L389
.L390:
	lis 11,.LC139@ha
	la 11,.LC139@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L389
	stfs 13,112(9)
.L389:
	lis 4,.LC135@ha
	mr 3,27
	la 4,.LC135@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L393
	mr 3,31
	bl atoi
	lwz 9,84(30)
	stw 3,716(9)
.L393:
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
.Lfe14:
	.size	 ClientUserinfoChanged,.Lfe14-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC140:
	.string	"ip"
	.align 2
.LC141:
	.string	"password"
	.align 2
.LC142:
	.string	"%s connected\n"
	.align 2
.LC143:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 26,4
	mr 31,3
	lis 4,.LC140@ha
	mr 3,26
	la 4,.LC140@l(4)
	bl Info_ValueForKey
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L396
	lis 4,.LC141@ha
	mr 3,26
	la 4,.LC141@l(4)
	bl Info_ValueForKey
	lis 9,passwd@ha
	mr 4,3
	lwz 11,passwd@l(9)
	lwz 3,4(11)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L396
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L396
	li 3,0
	b .L413
.L396:
	lis 11,g_edicts@ha
	lis 0,0xf3b3
	lwz 27,88(31)
	lwz 9,g_edicts@l(11)
	ori 0,0,8069
	lis 11,game+1028@ha
	cmpwi 0,27,0
	subf 9,9,31
	lwz 10,game+1028@l(11)
	mullw 9,9,0
	srawi 9,9,2
	mulli 9,9,3968
	addi 9,9,-3968
	add 10,10,9
	stw 10,84(31)
	bc 4,2,.L398
	li 0,-1
	lis 28,is_bot@ha
	stw 0,3464(10)
	li 4,0
	li 5,1716
	lwz 30,84(31)
	lwz 0,968(31)
	lwz 29,3464(30)
	addi 3,30,1824
	stw 0,is_bot@l(28)
	crxor 6,6,6
	bl memset
	lwz 0,is_bot@l(28)
	stw 29,3464(30)
	cmpwi 0,0,0
	bc 4,2,.L399
	lwz 0,1820(30)
	cmpwi 0,0,0
	bc 12,2,.L400
.L399:
	stw 27,3536(30)
	b .L401
.L400:
	li 0,1
	stw 0,3536(30)
.L401:
	lis 9,level@ha
	addi 3,30,1824
	lwz 0,level@l(9)
	addi 4,30,188
	li 5,1636
	stw 0,3460(30)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC143@ha
	lis 11,ctf@ha
	la 9,.LC143@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L403
	lwz 0,3464(30)
	cmpwi 0,0,0
	bc 12,1,.L403
	lis 9,is_bot@ha
	mr 3,30
	lwz 4,is_bot@l(9)
	bl CTFAssignTeam
.L403:
	lis 9,game+1560@ha
	lis 11,is_bot@ha
	lwz 10,game+1560@l(9)
	li 0,0
	stw 0,is_bot@l(11)
	cmpwi 0,10,0
	bc 12,2,.L405
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L398
.L405:
	lwz 3,84(31)
	bl InitClientPersistant
.L398:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L406
	lwz 9,84(31)
	lis 29,gi@ha
	li 4,765
	la 29,gi@l(29)
	li 3,120
	stw 0,3880(9)
	lwz 9,132(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	li 4,765
	stw 3,3892(9)
	lwz 0,132(29)
	li 3,120
	mtlr 0
	blrl
	li 0,10
	lwz 9,84(31)
	li 10,0
	mtctr 0
	stw 3,3896(9)
.L414:
	lwz 11,84(31)
	lfs 0,4(31)
	lwz 9,3892(11)
	stfsx 0,10,9
	lwz 11,84(31)
	lfs 0,8(31)
	lwz 9,3892(11)
	add 9,10,9
	stfs 0,4(9)
	lwz 11,84(31)
	lfs 0,12(31)
	lwz 9,3892(11)
	add 9,10,9
	stfs 0,8(9)
	lwz 11,84(31)
	lfs 0,3716(11)
	lwz 9,3896(11)
	stfsx 0,10,9
	lwz 11,84(31)
	lwz 9,3896(11)
	lfs 0,3720(11)
	add 9,10,9
	stfs 0,4(9)
	lwz 11,84(31)
	lwz 9,3896(11)
	lfs 0,3724(11)
	add 9,10,9
	addi 10,10,12
	stfs 0,8(9)
	bdnz .L414
.L406:
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L412
	lis 9,gi+4@ha
	lwz 4,84(31)
	lis 3,.LC142@ha
	lwz 0,gi+4@l(9)
	la 3,.LC142@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L412:
	lwz 9,84(31)
	li 0,1
	mr 3,31
	stw 0,720(9)
	bl niq_initdefaults
	li 3,1
.L413:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 ClientConnect,.Lfe15-ClientConnect
	.section	".rodata"
	.align 2
.LC144:
	.string	"%s exits NIQ, %d client(s)\n"
	.align 2
.LC145:
	.string	"disconnected"
	.align 2
.LC146:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-336(1)
	mflr 0
	stmw 27,316(1)
	stw 0,340(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L415
	lis 28,gi@ha
	bl EntityListRemove
	la 27,gi@l(28)
	lwz 29,84(31)
	addi 29,29,700
	bl niq_getnumclients
	lwz 0,gi@l(28)
	addi 6,3,-1
	lis 4,.LC144@ha
	la 4,.LC144@l(4)
	mr 5,29
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC146@ha
	la 9,.LC146@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L417
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L417
	addi 29,1,8
	lis 4,level@ha
	la 4,level@l(4)
	li 5,304
	mr 3,29
	crxor 6,6,6
	bl memcpy
	mr 3,27
	mr 4,29
	mr 5,31
	bl sl_LogPlayerDisconnect
.L417:
	mr 3,31
	lis 27,g_edicts@ha
	bl CTFDeadDropFlag
	lis 28,0xf3b3
	mr 3,31
	ori 28,28,8069
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
	lis 9,.LC145@ha
	li 0,0
	la 9,.LC145@l(9)
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
.L415:
	lwz 0,340(1)
	mtlr 0
	lmw 27,316(1)
	la 1,336(1)
	blr
.Lfe16:
	.size	 ClientDisconnect,.Lfe16-ClientDisconnect
	.section	".rodata"
	.align 2
.LC147:
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
.LC149:
	.string	"*jump1.wav"
	.align 3
.LC148:
	.long 0x3f768000
	.long 0x0
	.align 3
.LC150:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC151:
	.long 0x0
	.align 3
.LC152:
	.long 0x40140000
	.long 0x0
	.align 3
.LC153:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC154:
	.long 0x41000000
	.align 3
.LC155:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC156:
	.long 0x3f800000
	.align 2
.LC157:
	.long 0x447a0000
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
	lis 9,niq_tractor@ha
	mr 28,3
	lwz 10,niq_tractor@l(9)
	lis 11,level+292@ha
	mr 26,4
	lis 9,.LC151@ha
	stw 28,level+292@l(11)
	la 9,.LC151@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	lwz 31,84(28)
	fcmpu 0,0,13
	bc 12,2,.L441
	lwz 0,3964(31)
	cmpwi 0,0,1
	bc 4,2,.L441
	lwz 3,3956(31)
	cmpwi 0,3,0
	bc 12,2,.L441
	bl hook_service
.L441:
	lis 9,level@ha
	lis 10,.LC151@ha
	la 10,.LC151@l(10)
	la 9,level@l(9)
	lfs 13,0(10)
	lfs 0,200(9)
	fcmpu 0,0,13
	bc 12,2,.L442
	li 0,4
	lis 11,.LC152@ha
	stw 0,0(31)
	la 11,.LC152@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L440
	lbz 0,1(26)
	andi. 20,0,128
	bc 12,2,.L440
	li 0,1
	stw 0,208(9)
	b .L440
.L442:
	lwz 9,84(28)
	lwz 0,3828(9)
	cmpwi 0,0,0
	bc 12,2,.L444
	mr 3,28
	mr 4,26
	bl CameraThink
	b .L440
.L444:
	lwz 0,968(28)
	cmpwi 0,0,0
	bc 4,2,.L440
	lwz 0,3940(9)
	lis 9,pm_passent@ha
	cmpwi 0,0,0
	stw 28,pm_passent@l(9)
	bc 12,2,.L446
	lha 0,2(26)
	lis 8,0x4330
	lis 9,.LC153@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC153@l(9)
	stw 0,260(1)
	stw 8,256(1)
	lfd 12,0(9)
	lfd 0,256(1)
	lis 9,.LC148@ha
	lfd 13,.LC148@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3492(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3496(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3500(31)
	b .L440
.L446:
	addi 3,1,8
	li 4,0
	mr 30,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L451
	lwz 0,40(28)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L451
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L451
	li 0,2
.L451:
	stw 0,0(31)
	lis 9,sv_gravity@ha
	lwz 7,0(31)
	lwz 10,sv_gravity@l(9)
	li 20,3
	addi 23,1,12
	lwz 0,8(31)
	mtctr 20
	addi 24,28,4
	addi 25,1,18
	lfs 0,20(10)
	addi 22,28,376
	mr 12,23
	lwz 9,12(31)
	lis 10,.LC154@ha
	mr 4,24
	lwz 8,4(31)
	la 10,.LC154@l(10)
	mr 3,25
	lfs 10,0(10)
	mr 5,22
	addi 29,31,3540
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
.L500:
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
	bdnz .L500
	mr 3,29
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L458
	li 0,1
	stw 0,52(1)
.L458:
	lis 9,gi@ha
	lwz 7,0(26)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(26)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lis 20,.LC155@ha
	lwz 8,8(26)
	la 20,.LC155@l(20)
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
	lis 9,.LC153@ha
	lwz 11,8(1)
	mr 27,23
	la 9,.LC153@l(9)
	lwz 10,4(30)
	mr 3,25
	lfd 11,0(9)
	mr 4,24
	lis 6,0x4330
	lwz 0,8(30)
	mr 5,22
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
	stw 0,3540(31)
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
.L499:
	lhax 0,7,27
	lhax 9,7,3
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
	stfsx 13,8,4
	stfsx 0,8,5
	addi 8,8,4
	bdnz .L499
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 20,.LC153@ha
	lis 7,.LC148@ha
	lfs 8,204(1)
	la 20,.LC153@l(20)
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
	lfd 13,.LC148@l(7)
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3492(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3496(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3500(31)
	lwz 0,552(28)
	cmpwi 0,0,0
	bc 12,2,.L464
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L464
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L464
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L464
	lis 29,gi@ha
	lis 3,.LC149@ha
	la 29,gi@l(29)
	la 3,.LC149@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC156@ha
	lis 10,.LC151@ha
	lis 11,.LC156@ha
	mr 5,3
	la 9,.LC156@l(9)
	la 10,.LC151@l(10)
	mtlr 0
	la 11,.LC156@l(11)
	li 4,2
	lfs 2,0(9)
	mr 3,28
	lfs 3,0(10)
	lfs 1,0(11)
	blrl
	mr 4,24
	mr 3,28
	li 5,0
	bl PlayerNoise
.L464:
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
	bc 12,2,.L465
	lwz 0,92(10)
	stw 0,556(28)
.L465:
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L466
	lfs 0,3644(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L467
.L466:
	lfs 0,188(1)
	stfs 0,3716(31)
	lfs 13,192(1)
	stfs 13,3720(31)
	lfs 0,196(1)
	stfs 0,3724(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L467:
	lwz 3,3912(31)
	cmpwi 0,3,0
	bc 12,2,.L468
	bl CTFGrapplePull
.L468:
	lis 9,gi+72@ha
	mr 3,28
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L469
	mr 3,28
	bl G_TouchTriggers
.L469:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L471
	addi 30,1,60
.L473:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,30,0
	addi 27,29,1
	bc 4,0,.L475
	lwz 0,0(30)
	cmpw 0,0,3
	bc 12,2,.L475
	mr 9,30
.L476:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L475
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L476
.L475:
	cmpw 0,11,29
	bc 4,2,.L472
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L472
	mr 4,28
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L472:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L473
.L471:
	lwz 0,184(28)
	andi. 9,0,1
	bc 12,2,.L483
	lwz 0,3596(31)
	andi. 10,0,1
	bc 4,2,.L483
	lbz 0,1(26)
	andi. 11,0,1
	bc 12,2,.L483
	mr 3,28
	bl niq_putaway
.L483:
	lis 9,.LC151@ha
	lfs 11,3888(31)
	la 9,.LC151@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L484
	lwz 0,3596(31)
	andi. 10,0,1
	bc 4,2,.L484
	lbz 0,1(26)
	andi. 11,0,1
	bc 12,2,.L484
	lis 11,level@ha
	lfs 0,3884(31)
	lis 9,.LC150@ha
	la 11,level@l(11)
	lfd 13,.LC150@l(9)
	lfs 12,4(11)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,1,.L485
	lis 20,.LC157@ha
	la 20,.LC157@l(20)
	lfs 0,0(20)
	fdivs 0,11,0
	fadds 0,12,0
	stfs 0,3884(31)
.L485:
	lfs 13,4(11)
	lfs 0,3884(31)
	fcmpu 0,0,13
	bc 4,1,.L484
	lbz 0,1(26)
	rlwinm 9,0,0,24,30
	andi. 0,9,128
	stb 9,1(26)
	bc 12,2,.L484
	addi 0,9,128
	stb 0,1(26)
.L484:
	lis 9,.LC151@ha
	lfs 13,3888(31)
	la 9,.LC151@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L488
	lbz 0,1(26)
	andi. 10,0,1
	bc 4,2,.L488
	lis 9,level+4@ha
	lis 11,.LC150@ha
	lfs 10,3884(31)
	lfs 11,level+4@l(9)
	lfd 13,.LC150@l(11)
	fmr 12,10
	fmr 0,11
	fsub 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L488
	fcmpu 0,10,11
	cror 3,2,0
	bc 4,3,.L488
	ori 0,0,1
	stb 0,1(26)
.L488:
	lwz 0,3596(31)
	lwz 11,3604(31)
	stw 0,3600(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3596(31)
	or 11,11,0
	stw 11,3604(31)
	lbz 0,15(26)
	stw 0,640(28)
	lwz 9,3604(31)
	andi. 11,9,1
	bc 12,2,.L489
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L489
	lwz 0,3608(31)
	cmpwi 0,0,0
	bc 4,2,.L489
	li 0,1
	mr 3,28
	stw 0,3608(31)
	bl Think_Weapon
.L489:
	mr 3,28
	li 29,1
	bl CTFApplyRegeneration
	lis 9,.LC156@ha
	lis 11,maxclients@ha
	la 9,.LC156@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L492
	lis 10,.LC153@ha
	lis 26,g_edicts@ha
	la 10,.LC153@l(10)
	lis 27,0x4330
	lfd 31,0(10)
	li 30,1332
.L494:
	lwz 0,g_edicts@l(26)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L493
	lwz 9,84(3)
	lwz 0,3940(9)
	cmpw 0,0,28
	bc 4,2,.L493
	bl UpdateChaseCam
.L493:
	addi 29,29,1
	lwz 11,maxclients@l(21)
	xoris 0,29,0x8000
	addi 30,30,1332
	stw 0,260(1)
	stw 27,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L494
.L492:
	lis 9,niq_enable@ha
	lis 10,.LC151@ha
	lwz 11,niq_enable@l(9)
	la 10,.LC151@l(10)
	lfs 31,0(10)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L497
	mr 3,28
	bl niq_checktimers
.L497:
	lis 9,niq_tractor@ha
	lwz 11,niq_tractor@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L440
	lwz 0,3964(31)
	cmpwi 0,0,1
	bc 4,2,.L440
	mr 3,22
	bl VectorLength
	lis 9,.LC156@ha
	la 9,.LC156@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L440
	li 0,0
	sth 0,18(31)
.L440:
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
.LC158:
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
	mr 31,3
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L501
	lis 11,.LC158@ha
	lis 9,level+200@ha
	la 11,.LC158@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L501
	lwz 30,84(31)
	lwz 0,3828(30)
	cmpwi 0,0,0
	bc 4,2,.L501
	lwz 0,3608(30)
	cmpwi 0,0,0
	bc 4,2,.L505
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L505
	bl Think_Weapon
	b .L506
.L505:
	li 0,0
	stw 0,3608(30)
.L506:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L507
	lis 9,level@ha
	lfs 13,3824(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L501
	lis 9,.LC158@ha
	lis 11,deathmatch@ha
	lwz 10,3604(30)
	la 9,.LC158@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L512
	bc 12,30,.L501
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L501
.L512:
	bc 4,30,.L513
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L514
.L513:
	mr 3,31
	bl CopyToBodyQue
	lwz 9,84(31)
	li 0,0
	mr 3,31
	stw 0,3536(9)
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
	stfs 0,3824(11)
	b .L515
.L514:
	lis 9,gi+168@ha
	lis 3,.LC111@ha
	lwz 0,gi+168@l(9)
	la 3,.LC111@l(3)
	mtlr 0
	blrl
.L515:
	li 0,0
.L507:
	stw 0,3604(30)
.L501:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 ClientBeginServerFrame,.Lfe18-ClientBeginServerFrame
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".rodata"
	.align 2
.LC159:
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
	lis 11,.LC159@ha
	lis 9,deathmatch@ha
	la 11,.LC159@l(11)
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
	lwz 9,84(31)
	li 0,0
	mr 3,31
	stw 0,3536(9)
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
	stfs 0,3824(11)
	b .L298
.L299:
	lis 9,gi+168@ha
	lis 3,.LC111@ha
	lwz 0,gi+168@l(9)
	la 3,.LC111@l(3)
	mtlr 0
	blrl
.L298:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 respawn,.Lfe19-respawn
	.section	".rodata"
	.align 2
.LC160:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 4,0
	lwz 29,3464(31)
	addi 3,31,1824
	li 5,1716
	crxor 6,6,6
	bl memset
	lis 9,is_bot@ha
	stw 29,3464(31)
	lwz 0,is_bot@l(9)
	cmpwi 0,0,0
	bc 4,2,.L170
	lwz 0,1820(31)
	cmpwi 0,0,0
	bc 12,2,.L169
.L170:
	li 0,0
	b .L516
.L169:
	li 0,1
.L516:
	stw 0,3536(31)
	lis 9,level@ha
	addi 3,31,1824
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1636
	stw 0,3460(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC160@ha
	lis 11,ctf@ha
	la 9,.LC160@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L172
	lwz 0,3464(31)
	cmpwi 0,0,0
	bc 12,1,.L172
	lis 9,is_bot@ha
	mr 3,31
	lwz 4,is_bot@l(9)
	bl CTFAssignTeam
.L172:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
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
	lis 11,.LC103@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC103@l(11)
.L286:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L286
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 InitBodyQue,.Lfe21-InitBodyQue
	.comm	last_trail_time,4,4
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe22:
	.size	 player_pain,.Lfe22-player_pain
	.section	".rodata"
	.align 2
.LC161:
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
	lis 9,.LC161@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC161@l(9)
	addi 10,10,1332
	lfs 13,0(9)
.L177:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L176
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
	bc 12,2,.L176
	lwz 9,84(10)
	lwz 11,1028(8)
	lfs 0,3512(9)
	add 11,7,11
	stfs 0,1800(11)
.L176:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3968
	addi 10,10,1332
	cmpw 0,6,0
	bc 12,0,.L177
	blr
.Lfe23:
	.size	 SaveClientData,.Lfe23-SaveClientData
	.section	".rodata"
	.align 2
.LC162:
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
	bc 12,2,.L182
	lwz 0,264(3)
	ori 0,0,4096
	stw 0,264(3)
.L182:
	lis 9,.LC162@ha
	lis 11,coop@ha
	la 9,.LC162@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bclr 12,2
	lwz 9,84(3)
	lfs 0,1800(9)
	stfs 0,3512(9)
	blr
.Lfe24:
	.size	 FetchClientEntData,.Lfe24-FetchClientEntData
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
	.comm	pTempFind,4,4
	.section	".rodata"
	.align 2
.LC163:
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
	lis 9,.LC163@ha
	mr 30,3
	la 9,.LC163@l(9)
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
.Lfe25:
	.size	 SP_FixCoopSpots,.Lfe25-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC164:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC165:
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
	lis 11,.LC165@ha
	lis 9,coop@ha
	la 11,.LC165@l(11)
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
	lis 11,.LC164@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC164@l(11)
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
	.comm	dm_spots,256,4
	.section	".rodata"
	.align 2
.LC166:
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
	lis 11,.LC166@ha
	lis 9,deathmatch@ha
	la 11,.LC166@l(11)
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
	b .L517
.L30:
	li 3,0
.L517:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 IsFemale,.Lfe29-IsFemale
	.section	".rodata"
	.align 3
.LC167:
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
	bc 12,2,.L130
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L130
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L518
.L130:
	cmpwi 0,4,0
	bc 12,2,.L132
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L132
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L518:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L131
.L132:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3644(9)
	b .L129
.L131:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC167@ha
	lwz 11,84(31)
	lfd 0,.LC167@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3644(11)
.L129:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 LookAtKiller,.Lfe30-LookAtKiller
	.section	".rodata"
	.align 2
.LC168:
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
	lis 11,.LC168@ha
	mr 31,3
	lfs 31,.LC168@l(11)
	lis 28,num_players@ha
	cmpw 0,30,0
	bc 4,0,.L186
	lis 9,players@ha
	la 29,players@l(9)
.L188:
	lwz 9,0(29)
	addi 29,29,4
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L187
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L187
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
	bc 4,0,.L187
	fmr 31,1
.L187:
	lwz 0,num_players@l(28)
	addi 30,30,1
	cmpw 0,30,0
	bc 12,0,.L188
.L186:
	fmr 1,31
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
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
	bc 4,2,.L237
	bl SelectRandomDeathmatchSpawnPoint
	b .L520
.L237:
	bl SelectFarthestDeathmatchSpawnPoint
.L520:
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
	lis 9,0xbdef
	lwz 10,game+1028@l(11)
	ori 9,9,31711
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,7
	bc 12,2,.L521
.L243:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L244
	li 3,0
	b .L521
.L244:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L245
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L245:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L243
	addic. 31,31,-1
	bc 4,2,.L243
	mr 3,30
.L521:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe33:
	.size	 SelectCoopSpawnPoint,.Lfe33-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC169:
	.long 0x3f800000
	.align 2
.LC170:
	.long 0x0
	.align 2
.LC171:
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
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	lis 27,.LC87@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC169@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC169@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC169@ha
	la 9,.LC169@l(9)
	lfs 2,0(9)
	lis 9,.LC170@ha
	la 9,.LC170@l(9)
	lfs 3,0(9)
	blrl
.L295:
	mr 3,31
	la 4,.LC87@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L295
	lis 9,.LC171@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC171@l(9)
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
.Lfe34:
	.size	 body_die,.Lfe34-body_die
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
	bc 4,1,.L419
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L418
.L419:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L418:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 PM_trace,.Lfe35-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L423
.L425:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L425
.L423:
	mr 3,11
	blr
.Lfe36:
	.size	 CheckBlock,.Lfe36-CheckBlock
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
.L523:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L523
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L522:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L522
	lis 3,.LC147@ha
	la 3,.LC147@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 PrintPmove,.Lfe37-PrintPmove
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
