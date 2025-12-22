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
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
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
	la 31,.LC22@l(11)
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
	cmpw 0,29,30
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
	lwz 3,84(30)
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
	lwz 3,84(30)
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
	lwz 3,84(30)
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
	bc 12,2,.L78
	lwz 11,84(30)
	lwz 9,3424(11)
	addi 9,9,-1
	stw 9,3424(11)
.L78:
	li 0,0
	stw 0,540(30)
	b .L32
.L77:
	cmpwi 0,29,0
	stw 29,540(30)
	bc 12,2,.L34
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L34
	addi 0,28,-1
	cmplwi 0,0,33
	bc 12,1,.L80
	lis 11,.L100@ha
	slwi 10,0,2
	la 11,.L100@l(11)
	lis 9,.L100@ha
	lwzx 0,10,11
	la 9,.L100@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L100:
	.long .L81-.L100
	.long .L82-.L100
	.long .L83-.L100
	.long .L84-.L100
	.long .L85-.L100
	.long .L86-.L100
	.long .L87-.L100
	.long .L88-.L100
	.long .L89-.L100
	.long .L90-.L100
	.long .L91-.L100
	.long .L92-.L100
	.long .L93-.L100
	.long .L94-.L100
	.long .L95-.L100
	.long .L96-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L98-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L97-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L80-.L100
	.long .L99-.L100
.L81:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L80
.L82:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L80
.L83:
	lis 9,.LC45@ha
	lis 11,.LC46@ha
	la 6,.LC45@l(9)
	la 31,.LC46@l(11)
	b .L80
.L84:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L80
.L85:
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 6,.LC48@l(9)
	la 31,.LC49@l(11)
	b .L80
.L86:
	lis 9,.LC50@ha
	lis 11,.LC51@ha
	la 6,.LC50@l(9)
	la 31,.LC51@l(11)
	b .L80
.L87:
	lis 9,.LC52@ha
	lis 11,.LC53@ha
	la 6,.LC52@l(9)
	la 31,.LC53@l(11)
	b .L80
.L88:
	lis 9,.LC54@ha
	lis 11,.LC55@ha
	la 6,.LC54@l(9)
	la 31,.LC55@l(11)
	b .L80
.L89:
	lis 9,.LC56@ha
	lis 11,.LC55@ha
	la 6,.LC56@l(9)
	la 31,.LC55@l(11)
	b .L80
.L90:
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 6,.LC57@l(9)
	la 31,.LC58@l(11)
	b .L80
.L91:
	lis 9,.LC59@ha
	la 6,.LC59@l(9)
	b .L80
.L92:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 31,.LC61@l(11)
	b .L80
.L93:
	lis 9,.LC62@ha
	lis 11,.LC63@ha
	la 6,.LC62@l(9)
	la 31,.LC63@l(11)
	b .L80
.L94:
	lis 9,.LC64@ha
	lis 11,.LC61@ha
	la 6,.LC64@l(9)
	la 31,.LC61@l(11)
	b .L80
.L95:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 6,.LC65@l(9)
	la 31,.LC66@l(11)
	b .L80
.L96:
	lis 9,.LC67@ha
	lis 11,.LC66@ha
	la 6,.LC67@l(9)
	la 31,.LC66@l(11)
	b .L80
.L97:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 6,.LC68@l(9)
	la 31,.LC69@l(11)
	b .L80
.L98:
	lis 9,.LC70@ha
	lis 11,.LC71@ha
	la 6,.LC70@l(9)
	la 31,.LC71@l(11)
	b .L80
.L99:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 6,.LC72@l(9)
	la 31,.LC73@l(11)
.L80:
	cmpwi 0,6,0
	bc 12,2,.L34
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
	bc 12,2,.L32
	cmpwi 0,27,0
	bc 12,2,.L104
	lwz 11,84(29)
	lwz 9,3424(11)
	addi 9,9,-1
	b .L107
.L104:
	lwz 11,84(29)
	lwz 9,3424(11)
	addi 9,9,1
.L107:
	stw 9,3424(11)
	lwz 9,84(29)
	li 0,1
	mr 3,29
	stw 0,3464(9)
	bl CheckforDivine
	b .L32
.L34:
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
	bc 12,2,.L32
	lwz 11,84(30)
	lwz 9,3424(11)
	addi 9,9,-1
	stw 9,3424(11)
.L32:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
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
	bc 12,2,.L108
	lwz 9,84(30)
	lwz 11,3544(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L111
	lwz 3,40(31)
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L111:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L112
	li 29,0
	b .L113
.L112:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC81@ha
	lfs 12,3740(8)
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
.L113:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC80@ha
	and. 10,0,29
	la 9,.LC80@l(9)
	lfs 31,0(9)
	bc 12,2,.L114
	lis 11,.LC82@ha
	la 11,.LC82@l(11)
	lfs 31,0(11)
.L114:
	cmpwi 0,31,0
	bc 12,2,.L116
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3672(9)
	fsubs 0,0,31
	stfs 0,3672(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3672(9)
	fadds 0,0,31
	stfs 0,3672(9)
	stw 0,284(3)
.L116:
	cmpwi 0,29,0
	bc 12,2,.L108
	lwz 9,84(30)
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	lfs 0,3672(9)
	fadds 0,0,31
	stfs 0,3672(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC81@ha
	lis 11,Touch_Item@ha
	la 9,.LC81@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3672(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC79@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC79@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3672(7)
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
	lfs 0,3740(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L108:
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
	.align 2
.LC88:
	.string	"body"
	.align 3
.LC84:
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
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
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
	mr 29,5
	stw 0,396(31)
	mr 27,6
	stw 0,392(31)
	stw 0,388(31)
	stw 0,16(31)
	stw 11,260(31)
	stw 10,44(31)
	stw 10,48(31)
	stw 10,76(31)
	stw 10,3768(8)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 7,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L124
	lis 9,level+4@ha
	lis 11,.LC89@ha
	lfs 0,level+4@l(9)
	la 11,.LC89@l(11)
	cmpwi 0,29,0
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3776(11)
	bc 12,2,.L125
	lis 9,g_edicts@ha
	xor 11,29,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,29,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L125
	lfs 11,4(31)
	lfs 13,4(29)
	lfs 12,8(29)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(29)
	b .L148
.L125:
	cmpwi 0,30,0
	bc 12,2,.L127
	lis 9,g_edicts@ha
	xor 11,30,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,30,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L127
	lfs 11,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(30)
.L148:
	lfs 11,12(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	b .L126
.L127:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3596(9)
	b .L129
.L126:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC84@ha
	lwz 11,84(31)
	lfd 0,.LC84@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3596(11)
.L129:
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
	lis 9,.LC90@ha
	lis 11,deathmatch@ha
	la 9,.LC90@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L124
	lwz 9,84(31)
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 4,2,.L124
	mr 3,31
	bl Cmd_Help_f
.L124:
	lwz 11,84(31)
	li 0,0
	li 4,0
	li 5,1024
	stw 0,3740(11)
	lwz 9,84(31)
	stw 0,3744(9)
	lwz 11,84(31)
	stw 0,3748(11)
	lwz 9,84(31)
	stw 0,3752(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,0,.L131
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
.L135:
	mr 3,31
	la 4,.LC86@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L135
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	lwz 9,84(31)
	li 0,5
	stw 0,3728(9)
	lwz 11,84(31)
	stw 30,3724(11)
	stw 30,512(31)
	b .L137
.L131:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L137
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
	stw 7,3728(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L139
	li 0,172
	li 9,177
	b .L149
.L139:
	cmpwi 0,10,1
	bc 12,2,.L143
	bc 12,1,.L147
	cmpwi 0,10,0
	bc 12,2,.L142
	b .L140
.L147:
	cmpwi 0,10,2
	bc 12,2,.L144
	b .L140
.L142:
	li 0,177
	li 9,183
	b .L149
.L143:
	li 0,183
	li 9,189
	b .L149
.L144:
	li 0,189
	li 9,197
.L149:
	stw 0,56(31)
	stw 9,3724(11)
.L140:
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
	lis 9,.LC88@ha
	la 9,.LC88@l(9)
	stw 9,280(31)
.L137:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 player_die,.Lfe4-player_die
	.section	".rodata"
	.align 2
.LC92:
	.string	"Holy Fire"
	.align 2
.LC93:
	.string	"Grapple"
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	mr 31,3
	li 4,0
	li 5,1616
	lwz 30,728(31)
	addi 3,31,188
	lwz 25,1764(31)
	lis 28,0x38e3
	addi 26,31,740
	lwz 24,1768(31)
	ori 28,28,36409
	li 27,1
	lwz 23,1772(31)
	lwz 22,1776(31)
	lwz 21,1780(31)
	lwz 20,1784(31)
	crxor 6,6,6
	bl memset
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	bl FindItem
	lis 29,itemlist@ha
	mr 11,3
	la 29,itemlist@l(29)
	lis 3,.LC93@ha
	subf 0,29,11
	la 3,.LC93@l(3)
	mullw 0,0,28
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(31)
	stwx 27,26,9
	stw 11,1792(31)
	stw 11,1788(31)
	bl FindItem
	subf 3,29,3
	cmpwi 0,30,0
	mullw 3,3,28
	srawi 3,3,3
	slwi 3,3,2
	stwx 27,26,3
	bc 4,2,.L151
	li 0,75
	stw 0,728(31)
	b .L152
.L151:
	stw 30,728(31)
.L152:
	stw 30,724(31)
	lis 9,level+4@ha
	cmpwi 0,25,0
	lfs 0,level+4@l(9)
	stfs 0,3824(31)
	bc 4,2,.L153
	li 0,100
	stw 0,1764(31)
	b .L154
.L153:
	stw 25,1764(31)
.L154:
	cmpwi 0,24,0
	bc 4,2,.L155
	li 0,50
	stw 0,1768(31)
	b .L156
.L155:
	stw 24,1768(31)
.L156:
	cmpwi 0,23,0
	bc 4,2,.L157
	li 0,5
	stw 0,1772(31)
	b .L158
.L157:
	stw 23,1772(31)
.L158:
	cmpwi 0,22,0
	bc 4,2,.L159
	li 0,5
	stw 0,1776(31)
	b .L160
.L159:
	stw 22,1776(31)
.L160:
	cmpwi 0,21,0
	bc 4,2,.L161
	li 0,100
	stw 0,1780(31)
	b .L162
.L161:
	stw 21,1780(31)
.L162:
	cmpwi 0,20,0
	bc 4,2,.L163
	li 0,5
	stw 0,1784(31)
	b .L164
.L163:
	stw 20,1784(31)
.L164:
	li 0,1
	stw 0,720(31)
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 InitClientPersistant,.Lfe5-InitClientPersistant
	.section	".rodata"
	.align 2
.LC96:
	.string	"info_player_deathmatch"
	.align 2
.LC95:
	.long 0x47c34f80
	.align 2
.LC97:
	.long 0x4b18967f
	.align 2
.LC98:
	.long 0x3f800000
	.align 3
.LC99:
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
	lis 9,.LC95@ha
	li 28,0
	lfs 29,.LC95@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC96@ha
	b .L188
.L190:
	lis 10,.LC98@ha
	lis 9,maxclients@ha
	la 10,.LC98@l(10)
	lis 11,.LC97@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC97@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L198
	lis 11,.LC99@ha
	lis 26,g_edicts@ha
	la 11,.LC99@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,904
.L193:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L195
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L195
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
	bc 4,0,.L195
	fmr 31,1
.L195:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,904
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L193
.L198:
	fcmpu 0,31,28
	bc 4,0,.L200
	fmr 28,31
	mr 24,30
	b .L188
.L200:
	fcmpu 0,31,29
	bc 4,0,.L188
	fmr 29,31
	mr 23,30
.L188:
	lis 5,.LC96@ha
	mr 3,30
	la 5,.LC96@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L190
	cmpwi 0,28,0
	bc 4,2,.L204
	li 3,0
	b .L212
.L204:
	cmpwi 0,28,2
	bc 12,1,.L205
	li 23,0
	li 24,0
	b .L206
.L205:
	addi 28,28,-2
.L206:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L211:
	mr 3,30
	li 4,280
	la 5,.LC96@l(22)
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
	bc 4,2,.L211
.L212:
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
.LC100:
	.long 0x4b18967f
	.align 2
.LC101:
	.long 0x0
	.align 2
.LC102:
	.long 0x3f800000
	.align 3
.LC103:
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
	lis 9,.LC101@ha
	li 31,0
	la 9,.LC101@l(9)
	li 25,0
	lfs 29,0(9)
	b .L214
.L216:
	lis 9,maxclients@ha
	lis 11,.LC102@ha
	lwz 10,maxclients@l(9)
	la 11,.LC102@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC100@ha
	lfs 31,.LC100@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L224
	lis 9,.LC103@ha
	lis 27,g_edicts@ha
	la 9,.LC103@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,904
.L219:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L221
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L221
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
	bc 4,0,.L221
	fmr 31,1
.L221:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,904
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L219
.L224:
	fcmpu 0,31,29
	bc 4,1,.L214
	fmr 29,31
	mr 25,31
.L214:
	lis 30,.LC96@ha
	mr 3,31
	li 4,280
	la 5,.LC96@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L216
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L229
	la 5,.LC96@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L229:
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
.LC104:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC105:
	.long 0x0
	.align 2
.LC106:
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
	lis 11,.LC105@ha
	lis 9,deathmatch@ha
	la 11,.LC105@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 31,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L244
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L245
	bl SelectCTFSpawnPoint
	mr 31,3
	b .L250
.L245:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L247
	bl SelectFarthestDeathmatchSpawnPoint
	mr 31,3
	b .L250
.L247:
	bl SelectRandomDeathmatchSpawnPoint
	mr 31,3
	b .L250
.L274:
	li 31,0
	b .L250
.L244:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L250
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xc458
	lwz 10,game+1028@l(11)
	ori 9,9,53141
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 30,0,2
	bc 12,2,.L250
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 31,game+1032@ha
.L256:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L274
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
	bc 4,2,.L256
	addic. 30,30,-1
	bc 4,2,.L256
	mr 31,29
.L250:
	cmpwi 0,31,0
	bc 4,2,.L262
	lis 29,.LC0@ha
	lis 30,game@ha
.L269:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L275
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L273
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L264
	b .L269
.L273:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L269
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L269
.L264:
	cmpwi 0,31,0
	bc 4,2,.L262
.L275:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L271
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L271:
	cmpwi 0,31,0
	bc 4,2,.L262
	lis 9,gi+28@ha
	lis 3,.LC104@ha
	lwz 0,gi+28@l(9)
	la 3,.LC104@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L262:
	lfs 0,4(31)
	lis 9,.LC106@ha
	la 9,.LC106@l(9)
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
.LC107:
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
	mulli 27,27,904
	addi 27,27,904
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
	lis 9,0xfdb
	lis 10,.LC88@ha
	ori 9,9,49297
	la 10,.LC88@l(10)
	subf 0,0,29
	lis 11,body_die@ha
	mullw 0,0,9
	la 11,body_die@l(11)
	li 8,1
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
	stw 10,280(29)
	stw 0,256(29)
	lwz 9,260(28)
	stw 11,456(29)
	stw 9,260(29)
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
.LC108:
	.string	"menu_loadgame\n"
	.align 2
.LC109:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC110:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC111:
	.string	"player"
	.align 2
.LC112:
	.string	"players/male/tris.md2"
	.align 2
.LC113:
	.string	"fov"
	.align 2
.LC114:
	.long 0x0
	.align 2
.LC115:
	.long 0x41400000
	.align 2
.LC116:
	.long 0x41000000
	.align 3
.LC117:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC118:
	.long 0x3f800000
	.align 2
.LC119:
	.long 0x43200000
	.align 2
.LC120:
	.long 0x47800000
	.align 2
.LC121:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4480(1)
	mflr 0
	stfd 31,4472(1)
	stmw 20,4424(1)
	stw 0,4484(1)
	lis 9,.LC109@ha
	lis 8,.LC110@ha
	lwz 0,.LC109@l(9)
	la 29,.LC110@l(8)
	addi 10,1,8
	la 9,.LC109@l(9)
	lwz 11,.LC110@l(8)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 20,5
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
	lis 8,.LC114@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	la 8,.LC114@l(8)
	lis 11,g_edicts@ha
	lfs 13,0(8)
	lis 0,0xfdb
	lfs 0,20(10)
	ori 0,0,49297
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,3
	addi 25,9,-1
	bc 12,2,.L294
	addi 28,1,1688
	addi 27,30,1804
	mulli 25,25,3828
	addi 26,1,3384
	mr 4,27
	li 5,1688
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 21,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 28,29
	crxor 6,6,6
	bl memcpy
	addi 23,30,20
	addi 24,30,3472
	mr 3,30
	addi 29,1,72
	bl InitClientPersistant
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L295
.L294:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L296
	addi 27,1,1688
	addi 26,30,1804
	mulli 25,25,3828
	addi 29,1,3896
	mr 4,26
	li 5,1688
	mr 3,27
	crxor 6,6,6
	bl memcpy
	addi 28,30,188
	mr 22,29
	mr 3,29
	mr 4,28
	li 5,512
	mr 21,27
	crxor 6,6,6
	bl memcpy
	mr 27,26
	addi 23,30,20
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	addi 29,1,72
	addi 9,9,56
	addi 24,30,3472
	addi 10,1,2240
	addi 11,30,740
.L322:
	lwz 0,0(9)
	addi 9,9,72
	andi. 8,0,16
	bc 12,2,.L299
	lwz 0,0(11)
	stw 0,0(10)
.L299:
	addi 10,10,4
	addi 11,11,4
	bdnz .L322
	mr 4,21
	li 5,1616
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 4,22
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3308(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L295
	stw 9,1800(30)
	b .L295
.L296:
	addi 29,1,1688
	li 4,0
	mulli 25,25,3828
	mr 3,29
	li 5,1688
	crxor 6,6,6
	bl memset
	mr 21,29
	addi 27,30,1804
	addi 28,30,188
	addi 29,1,72
	addi 23,30,20
	addi 24,30,3472
.L295:
	mr 4,28
	li 5,1616
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3828
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,28
	li 5,1616
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L305
	mr 3,30
	bl InitClientPersistant
.L305:
	mr 3,27
	mr 4,21
	li 5,1688
	crxor 6,6,6
	bl memcpy
	lwz 11,84(31)
	lwz 0,724(11)
	stw 0,480(31)
	lwz 9,728(11)
	stw 9,484(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L306
	lwz 0,264(31)
	ori 0,0,4096
	stw 0,264(31)
.L306:
	lis 9,coop@ha
	lis 8,.LC114@ha
	lwz 11,coop@l(9)
	la 8,.LC114@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L308
	lwz 9,84(31)
	lwz 0,1800(9)
	stw 0,3424(9)
.L308:
	li 7,0
	lis 11,game+1028@ha
	lwz 6,264(31)
	stw 7,552(31)
	li 0,4
	lis 9,.LC111@ha
	lwz 3,game+1028@l(11)
	li 5,2
	la 9,.LC111@l(9)
	li 11,22
	stw 0,260(31)
	li 10,1
	stw 11,508(31)
	add 3,3,25
	li 0,200
	lis 11,.LC115@ha
	stw 10,88(31)
	lis 29,level+4@ha
	stw 9,280(31)
	la 11,.LC115@l(11)
	lis 10,0x201
	stw 0,400(31)
	lis 8,.LC112@ha
	lis 9,player_pain@ha
	stw 5,248(31)
	la 8,.LC112@l(8)
	la 9,player_pain@l(9)
	stw 5,512(31)
	ori 10,10,3
	rlwinm 6,6,0,21,19
	stw 3,84(31)
	li 4,0
	li 5,184
	stw 7,492(31)
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
	stw 0,184(31)
	stfs 10,188(31)
	stfs 13,196(31)
	stfs 12,200(31)
	stw 7,608(31)
	stw 6,264(31)
	stfs 9,192(31)
	stfs 11,204(31)
	stw 7,612(31)
	stfs 8,208(31)
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 8,.LC116@ha
	lfs 0,40(1)
	la 8,.LC116@l(8)
	mr 11,9
	lbz 0,16(30)
	lfs 10,0(8)
	mr 10,9
	andi. 0,0,191
	lis 8,deathmatch@ha
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4416(1)
	lwz 9,4420(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4416(1)
	lwz 11,4420(1)
	sth 11,6(30)
	lfs 0,48(1)
	stb 0,16(30)
	lwz 9,deathmatch@l(8)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4416(1)
	lwz 10,4420(1)
	sth 10,8(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L309
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4416(1)
	lwz 11,4420(1)
	andi. 0,11,32768
	bc 4,2,.L323
.L309:
	lis 4,.LC113@ha
	mr 3,28
	la 4,.LC113@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4420(1)
	lis 0,0x4330
	lis 8,.LC117@ha
	la 8,.LC117@l(8)
	stw 0,4416(1)
	lis 11,.LC118@ha
	lfd 13,0(8)
	la 11,.LC118@l(11)
	lfd 0,4416(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L311
.L323:
	lis 0,0x42b4
	stw 0,112(30)
	b .L310
.L311:
	lis 8,.LC119@ha
	la 8,.LC119@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L310
	stfs 13,112(30)
.L310:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	li 29,0
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 10,g_edicts@ha
	lis 11,0xfdb
	stw 3,88(30)
	lwz 9,g_edicts@l(10)
	ori 11,11,49297
	li 0,255
	stw 0,40(31)
	mr 3,31
	subf 9,9,31
	stw 29,64(31)
	mullw 9,9,11
	stw 29,68(31)
	srawi 9,9,3
	addi 9,9,-1
	stw 9,60(31)
	bl ShowGun
	lis 9,.LC120@ha
	lfs 13,48(1)
	li 0,3
	la 9,.LC120@l(9)
	lfs 11,40(1)
	lis 11,.LC121@ha
	mtctr 0
	lfs 9,0(9)
	la 11,.LC121@l(11)
	mr 5,20
	lis 9,.LC118@ha
	lfs 12,44(1)
	mr 8,24
	la 9,.LC118@l(9)
	lfs 10,0(11)
	mr 10,23
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
.L321:
	lfsx 0,11,5
	lfsx 12,11,8
	addi 11,11,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4416(1)
	lwz 9,4420(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L321
	lfs 0,60(1)
	li 0,0
	mr 3,31
	stw 0,24(31)
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(30)
	lfs 0,20(31)
	stfs 0,32(30)
	lfs 13,24(31)
	stfs 13,36(30)
	lfs 0,16(31)
	stfs 0,3668(30)
	lfs 13,20(31)
	stfs 13,3672(30)
	lfs 0,24(31)
	stw 0,3812(30)
	stw 0,3816(30)
	stfs 0,3676(30)
	bl CTFStartClient
	cmpwi 0,3,0
	bc 4,2,.L293
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1788(30)
	mr 3,31
	stw 0,3564(30)
	bl ChangeWeapon
.L293:
	lwz 0,4484(1)
	mtlr 0
	lmw 20,4424(1)
	lfd 31,4472(1)
	la 1,4480(1)
	blr
.Lfe10:
	.size	 PutClientInServer,.Lfe10-PutClientInServer
	.section	".rodata"
	.align 2
.LC122:
	.string	"%s entered the game\n"
	.align 2
.LC123:
	.string	"faith/motd.txt"
	.align 2
.LC124:
	.string	"r"
	.align 2
.LC125:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-624(1)
	mflr 0
	stmw 26,600(1)
	stw 0,628(1)
	mr 30,3
	bl G_InitEdict
	lwz 31,84(30)
	li 4,0
	li 5,1688
	addi 28,31,1804
	lwz 29,3428(31)
	lwz 27,3456(31)
	mr 3,28
	lwz 26,3460(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3428(31)
	mr 3,28
	stw 27,3456(31)
	addi 4,31,188
	li 5,1616
	stw 26,3460(31)
	lwz 0,level@l(9)
	stw 0,3420(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC125@ha
	lis 11,ctf@ha
	la 9,.LC125@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L326
	lwz 0,3428(31)
	cmpwi 0,0,0
	bc 12,1,.L326
	mr 3,31
	bl CTFAssignTeam
.L326:
	mr 3,30
	lis 28,gi@ha
	bl PutClientInServer
	la 29,gi@l(28)
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfdb
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49297
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
	lwz 0,gi@l(28)
	lis 4,.LC122@ha
	li 3,2
	lwz 5,84(30)
	la 4,.LC122@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 3,.LC123@ha
	lis 4,.LC124@ha
	la 3,.LC123@l(3)
	la 4,.LC124@l(4)
	bl fopen
	mr. 29,3
	bc 12,2,.L327
	addi 3,1,8
	li 4,500
	mr 5,29
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L328
	addi 31,1,520
	b .L329
.L331:
	addi 3,1,8
	mr 4,31
	bl strcat
.L329:
	mr 3,31
	li 4,80
	mr 5,29
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L331
	lis 9,gi+12@ha
	mr 3,30
	lwz 0,gi+12@l(9)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L328:
	mr 3,29
	bl fclose
.L327:
	mr 3,30
	bl ClientEndServerFrame
	lwz 0,628(1)
	mtlr 0
	lmw 26,600(1)
	la 1,624(1)
	blr
.Lfe11:
	.size	 ClientBeginDeathmatch,.Lfe11-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC126:
	.long 0x0
	.align 2
.LC127:
	.long 0x47800000
	.align 2
.LC128:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,g_edicts@ha
	mr 30,3
	lwz 9,g_edicts@l(11)
	lis 0,0xfdb
	lis 10,deathmatch@ha
	ori 0,0,49297
	lis 11,game+1028@ha
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC126@ha
	srawi 9,9,3
	la 10,.LC126@l(10)
	mulli 9,9,3828
	lfs 31,0(10)
	addi 9,9,-3828
	add 8,8,9
	stw 8,84(30)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L334
	bl ClientBeginDeathmatch
	b .L333
.L334:
	lwz 0,88(30)
	cmpwi 0,0,1
	bc 4,2,.L335
	lis 9,.LC127@ha
	lis 10,.LC128@ha
	li 11,3
	la 9,.LC127@l(9)
	la 10,.LC128@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L347:
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
	stfd 13,8(1)
	lwz 11,12(1)
	sthx 11,10,0
	bdnz .L347
	b .L341
.L335:
	mr 3,30
	bl G_InitEdict
	lwz 31,84(30)
	lis 9,.LC111@ha
	li 4,0
	la 9,.LC111@l(9)
	li 5,1688
	stw 9,280(30)
	addi 28,31,1804
	lwz 29,3428(31)
	mr 3,28
	lwz 27,3456(31)
	lwz 26,3460(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3428(31)
	mr 3,28
	stw 27,3456(31)
	addi 4,31,188
	li 5,1616
	stw 26,3460(31)
	lwz 0,level@l(9)
	stw 0,3420(31)
	crxor 6,6,6
	bl memcpy
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L343
	lwz 0,3428(31)
	cmpwi 0,0,0
	bc 12,1,.L343
	mr 3,31
	bl CTFAssignTeam
.L343:
	mr 3,30
	bl PutClientInServer
.L341:
	lis 10,.LC126@ha
	lis 9,level+200@ha
	la 10,.LC126@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L344
	mr 3,30
	bl MoveClientToIntermission
	b .L345
.L344:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L345
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfdb
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49297
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
	lis 4,.LC122@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC122@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L345:
	mr 3,30
	bl ClientEndServerFrame
.L333:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 ClientBegin,.Lfe12-ClientBegin
	.section	".rodata"
	.align 2
.LC129:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC130:
	.string	"name"
	.align 2
.LC131:
	.string	"%s\\%s"
	.align 2
.LC132:
	.string	"hand"
	.align 2
.LC133:
	.long 0x0
	.align 3
.LC134:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC135:
	.long 0x3f800000
	.align 2
.LC136:
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
	bc 4,2,.L349
	lis 11,.LC129@ha
	lwz 0,.LC129@l(11)
	la 9,.LC129@l(11)
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
.L349:
	lis 4,.LC130@ha
	mr 3,30
	la 4,.LC130@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC21@ha
	mr 3,30
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lis 9,ctf@ha
	lis 11,g_edicts@ha
	lwz 10,ctf@l(9)
	mr 31,3
	lis 9,.LC133@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC133@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,27
	lis 9,0xfdb
	ori 9,9,49297
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,3
	bc 12,2,.L350
	mr 4,31
	mr 3,27
	bl CTFAssignSkin
	b .L351
.L350:
	lwz 4,84(27)
	lis 29,gi@ha
	lis 3,.LC131@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC131@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L351:
	lis 9,.LC133@ha
	lis 11,deathmatch@ha
	la 9,.LC133@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L352
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L352
	lwz 9,84(27)
	b .L358
.L352:
	lis 4,.LC113@ha
	mr 3,30
	la 4,.LC113@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC134@ha
	la 10,.LC134@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC135@ha
	la 10,.LC135@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L354
.L358:
	lis 0,0x42b4
	stw 0,112(9)
	b .L353
.L354:
	lis 11,.LC136@ha
	la 11,.LC136@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L353
	stfs 13,112(9)
.L353:
	lis 4,.LC132@ha
	mr 3,30
	la 4,.LC132@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L357
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L357:
	lwz 3,84(27)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
	mr 3,27
	bl ShowGun
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 ClientUserinfoChanged,.Lfe13-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC137:
	.string	"ip"
	.align 2
.LC138:
	.string	"password"
	.align 2
.LC139:
	.string	"%s connected\n"
	.align 2
.LC140:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 25,4
	mr 30,3
	lis 4,.LC137@ha
	mr 3,25
	la 4,.LC137@l(4)
	bl Info_ValueForKey
	lis 4,.LC138@ha
	mr 3,25
	la 4,.LC138@l(4)
	bl Info_ValueForKey
	lis 9,password@ha
	mr 4,3
	lwz 11,password@l(9)
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L360
	li 3,0
	b .L367
.L360:
	lis 11,g_edicts@ha
	lis 0,0xfdb
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,49297
	lis 11,game+1028@ha
	cmpwi 0,10,0
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	srawi 9,9,3
	mulli 9,9,3828
	addi 9,9,-3828
	add 8,8,9
	stw 8,84(30)
	bc 4,2,.L361
	li 0,-1
	li 4,0
	stw 0,3428(8)
	li 5,1688
	lwz 31,84(30)
	addi 28,31,1804
	lwz 29,3428(31)
	lwz 27,3456(31)
	mr 3,28
	lwz 26,3460(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3428(31)
	mr 3,28
	stw 27,3456(31)
	addi 4,31,188
	li 5,1616
	stw 26,3460(31)
	lwz 0,level@l(9)
	stw 0,3420(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC140@ha
	lis 11,ctf@ha
	la 9,.LC140@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L363
	lwz 0,3428(31)
	cmpwi 0,0,0
	bc 12,1,.L363
	mr 3,31
	bl CTFAssignTeam
.L363:
	lis 9,game+1560@ha
	lwz 0,game+1560@l(9)
	cmpwi 0,0,0
	bc 12,2,.L365
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L361
.L365:
	lwz 3,84(30)
	bl InitClientPersistant
.L361:
	mr 4,25
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L366
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC139@ha
	lwz 0,gi+4@l(9)
	la 3,.LC139@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L366:
	lwz 9,84(30)
	li 0,1
	li 3,1
	stw 0,720(9)
.L367:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
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
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L368
	lis 29,gi@ha
	lis 4,.LC141@ha
	lwz 9,gi@l(29)
	addi 5,5,700
	la 4,.LC141@l(4)
	li 3,2
	la 29,gi@l(29)
	mtlr 9
	lis 27,g_edicts@ha
	lis 28,0xfdb
	ori 28,28,49297
	crxor 6,6,6
	blrl
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
	lwz 9,100(29)
	li 3,1
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
	lis 9,.LC142@ha
	li 0,0
	la 9,.LC142@l(9)
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
.L368:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 ClientDisconnect,.Lfe15-ClientDisconnect
	.section	".rodata"
	.align 2
.LC143:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC145:
	.string	"*jump1.wav"
	.align 3
.LC144:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC146:
	.long 0x0
	.align 3
.LC147:
	.long 0x40140000
	.long 0x0
	.align 3
.LC148:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC149:
	.long 0x3f800000
	.align 3
.LC150:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC151:
	.long 0x41000000
	.align 3
.LC152:
	.long 0x3fc00000
	.long 0x0
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
	lis 11,.LC146@ha
	la 9,level@l(9)
	la 11,.LC146@l(11)
	lfs 11,0(11)
	mr 28,3
	mr 26,4
	lfs 0,200(9)
	stw 28,292(9)
	lwz 31,84(28)
	fcmpu 0,0,11
	bc 12,2,.L393
	li 0,4
	lis 11,.LC147@ha
	stw 0,0(31)
	la 11,.LC147@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L392
	lbz 0,1(26)
	andi. 11,0,128
	bc 12,2,.L392
	li 0,1
	stw 0,208(9)
	b .L392
.L393:
	lwz 0,3804(31)
	lis 9,pm_passent@ha
	stw 28,pm_passent@l(9)
	cmpwi 0,0,0
	bc 12,2,.L395
	lha 0,2(26)
	lis 8,0x4330
	lis 9,.LC148@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC148@l(9)
	stw 0,260(1)
	stw 8,256(1)
	lfd 12,0(9)
	lfd 0,256(1)
	lis 9,.LC144@ha
	lfd 13,.LC144@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3472(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3476(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3480(31)
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,0,.L396
	lis 11,.LC149@ha
	lfs 0,328(28)
	la 11,.LC149@l(11)
	lfs 13,0(11)
	fsubs 0,0,13
	fcmpu 0,0,11
	stfs 0,328(28)
	bc 4,0,.L392
	stfs 11,328(28)
	b .L392
.L396:
	bc 4,1,.L392
	lis 9,.LC149@ha
	lfs 0,328(28)
	la 9,.LC149@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,328(28)
	b .L392
.L395:
	addi 3,1,8
	li 4,0
	mr 29,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L404
	lwz 0,40(28)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L404
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L404
	li 0,2
.L404:
	stw 0,0(31)
	lwz 9,84(28)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L406
	lis 10,sv_gravity@ha
	lis 9,.LC150@ha
	lwz 11,sv_gravity@l(10)
	la 9,.LC150@l(9)
	lfd 12,0(9)
	lfs 0,20(11)
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,256(1)
	lwz 9,260(1)
	sth 9,18(31)
	b .L407
.L406:
	lis 10,sv_gravity@ha
	lwz 9,sv_gravity@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,256(1)
	lwz 11,260(1)
	sth 11,18(31)
.L407:
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
	addi 30,31,3492
	addi 27,1,36
	stw 9,4(29)
	lis 21,maxclients@ha
	li 7,0
	stw 11,8(29)
	lis 9,.LC151@ha
	li 8,0
	la 9,.LC151@l(9)
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
.L447:
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
	bdnz .L447
	mr 3,30
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L413
	li 0,1
	stw 0,52(1)
.L413:
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
	lis 9,.LC148@ha
	lwz 11,8(1)
	mr 27,24
	la 9,.LC148@l(9)
	lwz 10,4(29)
	mr 3,25
	lfd 11,0(9)
	mr 4,23
	mr 5,22
	lis 9,.LC152@ha
	lwz 0,8(29)
	lis 6,0x4330
	la 9,.LC152@l(9)
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
	stw 0,3492(31)
	stw 9,4(30)
	stw 11,8(30)
	stw 10,12(30)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	stw 0,24(30)
	stw 9,16(30)
	stw 11,20(30)
.L446:
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
	bdnz .L446
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 11,.LC148@ha
	lis 7,.LC144@ha
	lfs 8,204(1)
	la 11,.LC148@l(11)
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
	lfd 13,.LC144@l(7)
	stw 0,260(1)
	mr 10,11
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3472(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3476(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3480(31)
	lwz 0,552(28)
	cmpwi 0,0,0
	bc 12,2,.L419
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L419
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L419
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L419
	lis 29,gi@ha
	lis 3,.LC145@ha
	la 29,gi@l(29)
	la 3,.LC145@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC149@ha
	lwz 0,16(29)
	lis 11,.LC149@ha
	la 9,.LC149@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC149@l(11)
	mr 3,28
	mtlr 0
	lis 9,.LC146@ha
	li 4,2
	lfs 2,0(11)
	la 9,.LC146@l(9)
	lfs 3,0(9)
	blrl
	mr 4,22
	mr 3,28
	li 5,0
	bl PlayerNoise
.L419:
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
	bc 12,2,.L420
	lwz 0,92(10)
	stw 0,556(28)
.L420:
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L421
	lfs 0,3596(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L422
.L421:
	lfs 0,188(1)
	stfs 0,3668(31)
	lfs 13,192(1)
	stfs 13,3672(31)
	lfs 0,196(1)
	stfs 0,3676(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L422:
	lwz 3,3780(31)
	cmpwi 0,3,0
	bc 12,2,.L423
	bl CTFGrapplePull
.L423:
	lis 9,gi+72@ha
	mr 3,28
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L424
	mr 3,28
	bl G_TouchTriggers
.L424:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L426
	addi 30,1,60
.L428:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,30,0
	addi 27,29,1
	bc 4,0,.L430
	lwz 0,0(30)
	cmpw 0,0,3
	bc 12,2,.L430
	mr 9,30
.L431:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L430
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L431
.L430:
	cmpw 0,11,29
	bc 4,2,.L427
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L427
	mr 4,28
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L427:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L428
.L426:
	lwz 0,3548(31)
	lwz 11,3556(31)
	stw 0,3552(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3548(31)
	or 11,11,0
	stw 11,3556(31)
	lbz 0,15(26)
	stw 0,640(28)
	lwz 9,3556(31)
	andi. 0,9,1
	bc 12,2,.L438
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L438
	lwz 0,3560(31)
	cmpwi 0,0,0
	bc 4,2,.L438
	li 0,1
	mr 3,28
	stw 0,3560(31)
	bl Think_Weapon
.L438:
	mr 3,28
	li 29,1
	bl CTFApplyRegeneration
	lis 9,.LC149@ha
	lis 11,maxclients@ha
	la 9,.LC149@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L392
	lis 11,.LC148@ha
	lis 27,g_edicts@ha
	la 11,.LC148@l(11)
	lis 30,0x4330
	lfd 31,0(11)
	li 31,904
.L443:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L442
	lwz 9,84(3)
	lwz 0,3804(9)
	cmpw 0,0,28
	bc 4,2,.L442
	bl UpdateChaseCam
.L442:
	addi 29,29,1
	lwz 11,maxclients@l(21)
	xoris 0,29,0x8000
	addi 31,31,904
	stw 0,260(1)
	stw 30,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L443
.L392:
	lwz 0,324(1)
	mtlr 0
	lmw 21,268(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe16:
	.size	 ClientThink,.Lfe16-ClientThink
	.section	".rodata"
	.align 2
.LC153:
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
	lis 11,.LC153@ha
	lis 9,level+200@ha
	la 11,.LC153@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L448
	lwz 30,84(31)
	lwz 0,3560(30)
	cmpwi 0,0,0
	bc 4,2,.L450
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L450
	bl Think_Weapon
	b .L451
.L450:
	li 0,0
	stw 0,3560(30)
.L451:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L452
	lis 9,level@ha
	lfs 13,3776(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L448
	lis 9,.LC153@ha
	lis 11,deathmatch@ha
	lwz 10,3556(30)
	la 9,.LC153@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L457
	bc 12,30,.L448
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L448
.L457:
	bc 4,30,.L458
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L459
.L458:
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
	stb 10,17(9)
	lfs 0,4(29)
	lwz 11,84(31)
	stfs 0,3776(11)
	b .L461
.L459:
	lis 9,gi+168@ha
	lis 3,.LC108@ha
	lwz 0,gi+168@l(9)
	la 3,.LC108@l(3)
	mtlr 0
	blrl
	b .L463
.L452:
	lis 9,.LC153@ha
	lis 11,deathmatch@ha
	la 9,.LC153@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L461
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L461
	addi 3,31,28
	bl PlayerTrail_Add
.L463:
.L461:
	li 0,0
	stw 0,3556(30)
.L448:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientBeginServerFrame,.Lfe17-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC154:
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
	lis 11,.LC154@ha
	lis 9,deathmatch@ha
	la 11,.LC154@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L292
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L291
.L292:
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
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
	stfs 0,3776(11)
	b .L290
.L291:
	lis 9,gi+168@ha
	lis 3,.LC108@ha
	lwz 0,gi+168@l(9)
	la 3,.LC108@l(3)
	mtlr 0
	blrl
.L290:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 respawn,.Lfe18-respawn
	.section	".rodata"
	.align 2
.LC155:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	li 4,0
	addi 29,31,1804
	lwz 28,3428(31)
	li 5,1688
	lwz 27,3456(31)
	mr 3,29
	lwz 26,3460(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 28,3428(31)
	mr 3,29
	stw 27,3456(31)
	addi 4,31,188
	li 5,1616
	stw 26,3460(31)
	lwz 0,level@l(9)
	stw 0,3420(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC155@ha
	lis 11,ctf@ha
	la 9,.LC155@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L166
	lwz 0,3428(31)
	cmpwi 0,0,0
	bc 12,1,.L166
	mr 3,31
	bl CTFAssignTeam
.L166:
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
	lis 11,.LC107@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC107@l(11)
.L280:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L280
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
.LC156:
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
	lis 9,.LC156@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC156@l(9)
	addi 10,10,904
	lfs 13,0(9)
.L171:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L170
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
	bc 12,2,.L170
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3424(9)
	add 11,7,11
	stw 0,1800(11)
.L170:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3828
	addi 10,10,904
	cmpw 0,6,0
	bc 12,0,.L171
	blr
.Lfe22:
	.size	 SaveClientData,.Lfe22-SaveClientData
	.section	".rodata"
	.align 2
.LC157:
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
	bc 12,2,.L176
	lwz 0,264(3)
	ori 0,0,4096
	stw 0,264(3)
.L176:
	lis 9,.LC157@ha
	lis 11,coop@ha
	la 9,.LC157@l(9)
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
	.comm	maplist,292,4
	.section	".rodata"
	.align 2
.LC158:
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
	lis 9,.LC158@ha
	mr 30,3
	la 9,.LC158@l(9)
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
.LC159:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC160:
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
	lis 11,.LC160@ha
	lis 9,coop@ha
	la 11,.LC160@l(11)
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
	lis 11,.LC159@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC159@l(11)
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
.LC161:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC161@ha
	lis 9,deathmatch@ha
	la 11,.LC161@l(11)
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
	b .L464
.L30:
	li 3,0
.L464:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 IsFemale,.Lfe28-IsFemale
	.section	".rodata"
	.align 3
.LC162:
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
	bc 12,2,.L119
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L119
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L465
.L119:
	cmpwi 0,4,0
	bc 12,2,.L121
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L121
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L465:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L120
.L121:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3596(9)
	b .L118
.L120:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC162@ha
	lwz 11,84(31)
	lfd 0,.LC162@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3596(11)
.L118:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 LookAtKiller,.Lfe29-LookAtKiller
	.section	".rodata"
	.align 2
.LC163:
	.long 0x4b18967f
	.align 2
.LC164:
	.long 0x3f800000
	.align 3
.LC165:
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
	lis 11,.LC164@ha
	lwz 10,maxclients@l(9)
	la 11,.LC164@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC163@ha
	lfs 31,.LC163@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L180
	lis 9,.LC165@ha
	lis 27,g_edicts@ha
	la 9,.LC165@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,904
.L182:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L181
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L181
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
	bc 4,0,.L181
	fmr 31,1
.L181:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,904
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L182
.L180:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe30:
	.size	 PlayersRangeFromSpot,.Lfe30-PlayersRangeFromSpot
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
	bc 4,2,.L231
	bl SelectRandomDeathmatchSpawnPoint
	b .L467
.L231:
	bl SelectFarthestDeathmatchSpawnPoint
.L467:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
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
	lis 9,0xc458
	lwz 10,game+1028@l(11)
	ori 9,9,53141
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L468
.L237:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L238
	li 3,0
	b .L468
.L238:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L239
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L239:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L237
	addic. 31,31,-1
	bc 4,2,.L237
	mr 3,30
.L468:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 SelectCoopSpawnPoint,.Lfe32-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC166:
	.long 0x3f800000
	.align 2
.LC167:
	.long 0x0
	.align 2
.LC168:
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
	bc 4,0,.L283
	lis 29,gi@ha
	lis 3,.LC85@ha
	la 29,gi@l(29)
	la 3,.LC85@l(3)
	lwz 9,36(29)
	lis 27,.LC86@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC166@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC166@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC166@ha
	la 9,.LC166@l(9)
	lfs 2,0(9)
	lis 9,.LC167@ha
	la 9,.LC167@l(9)
	lfs 3,0(9)
	blrl
.L287:
	mr 3,31
	la 4,.LC86@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L287
	lis 9,.LC168@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC168@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L283:
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
	bc 4,1,.L371
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L370
.L371:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L370:
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
	bc 4,0,.L375
.L377:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L377
.L375:
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
.L470:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L470
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L469:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L469
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
.Lfe37:
	.size	 SP_CreateCoopSpots,.Lfe37-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
