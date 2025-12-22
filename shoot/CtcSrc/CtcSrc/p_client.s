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
	.string	"got pecked to death"
	.align 2
.LC34:
	.string	"was in the wrong place"
	.align 2
.LC35:
	.string	"tried to put the pin back in"
	.align 2
.LC36:
	.string	"tripped on her own grenade"
	.align 2
.LC37:
	.string	"tripped on his own grenade"
	.align 2
.LC38:
	.string	"blew herself up"
	.align 2
.LC39:
	.string	"blew himself up"
	.align 2
.LC40:
	.string	"should have used a smaller gun"
	.align 2
.LC41:
	.string	"killed herself"
	.align 2
.LC42:
	.string	"killed himself"
	.align 2
.LC43:
	.string	"%s %s.\n"
	.align 2
.LC44:
	.string	"was blasted by"
	.align 2
.LC45:
	.string	"was gunned down by"
	.align 2
.LC46:
	.string	"was blown away by"
	.align 2
.LC47:
	.string	"'s super shotgun"
	.align 2
.LC48:
	.string	"was machinegunned by"
	.align 2
.LC49:
	.string	"was cut in half by"
	.align 2
.LC50:
	.string	"'s chaingun"
	.align 2
.LC51:
	.string	"was popped by"
	.align 2
.LC52:
	.string	"'s grenade"
	.align 2
.LC53:
	.string	"was shredded by"
	.align 2
.LC54:
	.string	"'s shrapnel"
	.align 2
.LC55:
	.string	"ate"
	.align 2
.LC56:
	.string	"'s rocket"
	.align 2
.LC57:
	.string	"almost dodged"
	.align 2
.LC58:
	.string	"was melted by"
	.align 2
.LC59:
	.string	"'s hyperblaster"
	.align 2
.LC60:
	.string	"was railed by"
	.align 2
.LC61:
	.string	"saw the pretty lights from"
	.align 2
.LC62:
	.string	"'s BFG"
	.align 2
.LC63:
	.string	"was disintegrated by"
	.align 2
.LC64:
	.string	"'s BFG blast"
	.align 2
.LC65:
	.string	"couldn't hide from"
	.align 2
.LC66:
	.string	"caught"
	.align 2
.LC67:
	.string	"'s handgrenade"
	.align 2
.LC68:
	.string	"didn't see"
	.align 2
.LC69:
	.string	"feels"
	.align 2
.LC70:
	.string	"'s pain"
	.align 2
.LC71:
	.string	"tried to invade"
	.align 2
.LC72:
	.string	"'s personal space"
	.align 2
.LC73:
	.string	"%s %s %s%s\n"
	.align 2
.LC74:
	.string	"%s died.\n"
	.align 2
.LC75:
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
	lis 9,meansOfDeath@ha
	mr 30,3
	mr 29,5
	lwz 6,meansOfDeath@l(9)
	bl Chicken_PlayerDie
	cmpwi 0,3,0
	lis 10,meansOfDeath@ha
	bc 4,2,.L32
	lis 9,.LC75@ha
	lis 11,coop@ha
	la 9,.LC75@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L34
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L34
	lwz 0,meansOfDeath@l(10)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(10)
.L34:
	lis 11,.LC75@ha
	lis 9,deathmatch@ha
	la 11,.LC75@l(11)
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
	cmplwi 0,10,17
	bc 12,1,.L37
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
	.long .L41-.L53
	.long .L42-.L53
	.long .L43-.L53
	.long .L40-.L53
	.long .L37-.L53
	.long .L39-.L53
	.long .L38-.L53
	.long .L37-.L53
	.long .L45-.L53
	.long .L45-.L53
	.long .L52-.L53
	.long .L46-.L53
	.long .L52-.L53
	.long .L47-.L53
	.long .L52-.L53
	.long .L37-.L53
	.long .L48-.L53
	.long .L49-.L53
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
.L49:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
	b .L37
.L52:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
.L37:
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
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
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
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L55
.L60:
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
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
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L55
.L66:
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L55
.L71:
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
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
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
	b .L55
.L73:
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
.L55:
	cmpwi 0,6,0
	bc 12,2,.L79
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC43@ha
	lwz 0,gi@l(9)
	la 4,.LC43@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC75@ha
	lis 11,deathmatch@ha
	la 9,.LC75@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L80
	lwz 11,84(30)
	lwz 9,3424(11)
	addi 9,9,-1
	stw 9,3424(11)
.L80:
	li 0,0
	stw 0,540(30)
	b .L32
.L79:
	cmpwi 0,29,0
	stw 29,540(30)
	bc 12,2,.L35
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L35
	addi 0,28,-1
	cmplwi 0,0,23
	bc 12,1,.L82
	lis 11,.L101@ha
	slwi 10,0,2
	la 11,.L101@l(11)
	lis 9,.L101@ha
	lwzx 0,10,11
	la 9,.L101@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L101:
	.long .L83-.L101
	.long .L84-.L101
	.long .L85-.L101
	.long .L86-.L101
	.long .L87-.L101
	.long .L88-.L101
	.long .L89-.L101
	.long .L90-.L101
	.long .L91-.L101
	.long .L92-.L101
	.long .L93-.L101
	.long .L94-.L101
	.long .L95-.L101
	.long .L96-.L101
	.long .L97-.L101
	.long .L98-.L101
	.long .L82-.L101
	.long .L82-.L101
	.long .L82-.L101
	.long .L82-.L101
	.long .L100-.L101
	.long .L82-.L101
	.long .L82-.L101
	.long .L99-.L101
.L83:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L82
.L84:
	lis 9,.LC45@ha
	la 6,.LC45@l(9)
	b .L82
.L85:
	lis 9,.LC46@ha
	lis 11,.LC47@ha
	la 6,.LC46@l(9)
	la 31,.LC47@l(11)
	b .L82
.L86:
	lis 9,.LC48@ha
	la 6,.LC48@l(9)
	b .L82
.L87:
	lis 9,.LC49@ha
	lis 11,.LC50@ha
	la 6,.LC49@l(9)
	la 31,.LC50@l(11)
	b .L82
.L88:
	lis 9,.LC51@ha
	lis 11,.LC52@ha
	la 6,.LC51@l(9)
	la 31,.LC52@l(11)
	b .L82
.L89:
	lis 9,.LC53@ha
	lis 11,.LC54@ha
	la 6,.LC53@l(9)
	la 31,.LC54@l(11)
	b .L82
.L90:
	lis 9,.LC55@ha
	lis 11,.LC56@ha
	la 6,.LC55@l(9)
	la 31,.LC56@l(11)
	b .L82
.L91:
	lis 9,.LC57@ha
	lis 11,.LC56@ha
	la 6,.LC57@l(9)
	la 31,.LC56@l(11)
	b .L82
.L92:
	lis 9,.LC58@ha
	lis 11,.LC59@ha
	la 6,.LC58@l(9)
	la 31,.LC59@l(11)
	b .L82
.L93:
	lis 9,.LC60@ha
	la 6,.LC60@l(9)
	b .L82
.L94:
	lis 9,.LC61@ha
	lis 11,.LC62@ha
	la 6,.LC61@l(9)
	la 31,.LC62@l(11)
	b .L82
.L95:
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	la 6,.LC63@l(9)
	la 31,.LC64@l(11)
	b .L82
.L96:
	lis 9,.LC65@ha
	lis 11,.LC62@ha
	la 6,.LC65@l(9)
	la 31,.LC62@l(11)
	b .L82
.L97:
	lis 9,.LC66@ha
	lis 11,.LC67@ha
	la 6,.LC66@l(9)
	la 31,.LC67@l(11)
	b .L82
.L98:
	lis 9,.LC68@ha
	lis 11,.LC67@ha
	la 6,.LC68@l(9)
	la 31,.LC67@l(11)
	b .L82
.L99:
	lis 9,.LC69@ha
	lis 11,.LC70@ha
	la 6,.LC69@l(9)
	la 31,.LC70@l(11)
	b .L82
.L100:
	lis 9,.LC71@ha
	lis 11,.LC72@ha
	la 6,.LC71@l(9)
	la 31,.LC72@l(11)
.L82:
	cmpwi 0,6,0
	bc 12,2,.L35
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC73@ha
	lwz 0,gi@l(9)
	la 4,.LC73@l(4)
	addi 7,7,700
	addi 5,5,700
	mr 8,31
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC75@ha
	lis 11,deathmatch@ha
	la 9,.LC75@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L32
	cmpwi 0,27,0
	bc 12,2,.L105
	lwz 11,84(29)
	b .L108
.L105:
	lwz 11,84(29)
	lwz 9,3424(11)
	addi 9,9,1
	b .L109
.L35:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC74@ha
	lwz 0,gi@l(9)
	la 4,.LC74@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC75@ha
	lis 11,deathmatch@ha
	la 9,.LC75@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L32
	lwz 11,84(30)
.L108:
	lwz 9,3424(11)
	addi 9,9,-1
.L109:
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
.LC76:
	.string	"Blaster"
	.align 2
.LC77:
	.string	"item_quad"
	.align 3
.LC78:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC79:
	.long 0x0
	.align 3
.LC80:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC81:
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
	lis 10,.LC79@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC79@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L110
	lwz 9,84(30)
	lwz 11,3492(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L113
	lwz 3,40(31)
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L113:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L114
	li 29,0
	b .L115
.L114:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC80@ha
	lfs 12,3688(8)
	addi 9,9,10
	la 10,.LC80@l(10)
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
.L115:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC79@ha
	and. 10,0,29
	la 9,.LC79@l(9)
	lfs 31,0(9)
	bc 12,2,.L116
	lis 11,.LC81@ha
	la 11,.LC81@l(11)
	lfs 31,0(11)
.L116:
	cmpwi 0,31,0
	bc 12,2,.L118
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3620(9)
	fsubs 0,0,31
	stfs 0,3620(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3620(9)
	fadds 0,0,31
	stfs 0,3620(9)
	stw 0,284(3)
.L118:
	cmpwi 0,29,0
	bc 12,2,.L110
	lwz 9,84(30)
	lis 3,.LC77@ha
	la 3,.LC77@l(3)
	lfs 0,3620(9)
	fadds 0,0,31
	stfs 0,3620(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC80@ha
	lis 11,Touch_Item@ha
	la 9,.LC80@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3620(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC78@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC78@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3620(7)
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
	lfs 0,3688(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L110:
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
.LC84:
	.string	"misc/udeath.wav"
	.align 2
.LC85:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.39:
	.space	4
	.size	 i.39,4
	.section	".rodata"
	.align 2
.LC86:
	.string	"*death%i.wav"
	.align 3
.LC83:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 3
.LC87:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC88:
	.long 0x0
	.align 2
.LC89:
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
	li 9,0
	li 28,0
	lwz 8,84(31)
	li 11,7
	li 0,1
	stw 11,260(31)
	lis 10,0xc100
	stw 0,512(31)
	mr 30,4
	mr 29,5
	stw 9,24(31)
	mr 27,6
	stw 28,44(31)
	stw 28,76(31)
	stw 9,396(31)
	stw 9,392(31)
	stw 9,388(31)
	stw 9,16(31)
	stw 28,3716(8)
	lwz 0,184(31)
	stw 10,208(31)
	ori 0,0,2
	stw 0,184(31)
	bl Chicken_TossCheck
	lis 9,meansOfDeath@ha
	mr 28,3
	lwz 6,meansOfDeath@l(9)
	mr 3,31
	mr 4,30
	mr 5,29
	bl Chicken_ScoreCheck
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L126
	lis 9,level+4@ha
	lis 11,.LC87@ha
	lfs 0,level+4@l(9)
	la 11,.LC87@l(11)
	cmpwi 0,29,0
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3724(11)
	bc 12,2,.L127
	lis 9,g_edicts@ha
	xor 11,29,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,29,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L127
	lfs 11,4(31)
	lfs 13,4(29)
	lfs 12,8(29)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(29)
	b .L154
.L127:
	cmpwi 0,30,0
	bc 12,2,.L129
	lis 9,g_edicts@ha
	xor 11,30,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,30,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L129
	lfs 11,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(30)
.L154:
	lfs 11,12(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	b .L128
.L129:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3544(9)
	b .L131
.L128:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC83@ha
	lwz 11,84(31)
	lfd 0,.LC83@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3544(11)
.L131:
	lwz 9,84(31)
	li 0,2
	mr 4,30
	mr 5,29
	mr 3,31
	stw 0,0(9)
	bl ClientObituary
	cmpwi 0,28,0
	bc 4,2,.L132
	mr 3,31
	bl TossClientWeapon
.L132:
	lis 9,.LC88@ha
	lis 11,deathmatch@ha
	la 9,.LC88@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L126
	mr 3,31
	bl Cmd_Help_f
.L126:
	lwz 11,84(31)
	li 0,0
	li 4,0
	li 5,1024
	stw 0,3688(11)
	lwz 9,84(31)
	stw 0,3692(9)
	lwz 11,84(31)
	stw 0,3696(11)
	lwz 9,84(31)
	stw 0,3700(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 12,0,.L135
	lis 9,meansOfDeath@ha
	lwz 5,meansOfDeath@l(9)
	cmpwi 0,5,34
	bc 12,2,.L135
	lwz 6,84(31)
	lwz 0,3764(6)
	cmpwi 0,0,0
	bc 12,2,.L134
.L135:
	lis 29,gi@ha
	lis 3,.LC84@ha
	la 29,gi@l(29)
	la 3,.LC84@l(3)
	lwz 9,36(29)
	lis 28,.LC85@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC89@ha
	lwz 0,16(29)
	lis 11,.LC89@ha
	la 9,.LC89@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC89@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC88@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC88@l(9)
	lfs 3,0(9)
	blrl
.L139:
	mr 3,31
	la 4,.LC85@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L139
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	lwz 9,84(31)
	li 0,5
	stw 0,3676(9)
	lwz 11,84(31)
	stw 30,3672(11)
	stw 30,512(31)
	b .L141
.L134:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L141
	lis 8,i.39@ha
	lis 9,0x5555
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
	stw 7,3676(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L143
	cmpwi 0,5,23
	li 0,172
	bc 4,2,.L144
	li 0,177
.L144:
	stw 0,56(31)
	lwz 9,84(31)
	li 0,177
	stw 0,3672(9)
	b .L146
.L143:
	cmpwi 0,10,1
	bc 12,2,.L149
	bc 12,1,.L153
	cmpwi 0,10,0
	bc 12,2,.L148
	b .L146
.L153:
	cmpwi 0,10,2
	bc 12,2,.L150
	b .L146
.L148:
	li 0,177
	li 9,183
	b .L156
.L149:
	li 0,183
	li 9,189
	b .L156
.L150:
	li 0,189
	li 9,197
.L156:
	stw 0,56(31)
	stw 9,3672(11)
.L146:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC86@ha
	srwi 0,0,30
	la 3,.LC86@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC89@ha
	lwz 0,16(29)
	lis 11,.LC89@ha
	la 9,.LC89@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC89@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC88@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC88@l(9)
	lfs 3,0(9)
	blrl
.L141:
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
	.string	"info_player_deathmatch"
	.align 2
.LC91:
	.long 0x47c34f80
	.align 2
.LC93:
	.long 0x4b18967f
	.align 2
.LC94:
	.long 0x3f800000
	.align 3
.LC95:
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
	lis 9,.LC91@ha
	li 28,0
	lfs 29,.LC91@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC92@ha
	b .L180
.L182:
	lis 10,.LC94@ha
	lis 9,maxclients@ha
	la 10,.LC94@l(10)
	lis 11,.LC93@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC93@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L190
	lis 11,.LC95@ha
	lis 26,g_edicts@ha
	la 11,.LC95@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,896
.L185:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L187
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L187
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
	bc 4,0,.L187
	fmr 31,1
.L187:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,896
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L185
.L190:
	fcmpu 0,31,28
	bc 4,0,.L192
	fmr 28,31
	mr 24,30
	b .L180
.L192:
	fcmpu 0,31,29
	bc 4,0,.L180
	fmr 29,31
	mr 23,30
.L180:
	lis 5,.LC92@ha
	mr 3,30
	la 5,.LC92@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L182
	cmpwi 0,28,0
	bc 4,2,.L196
	li 3,0
	b .L204
.L196:
	cmpwi 0,28,2
	bc 12,1,.L197
	li 23,0
	li 24,0
	b .L198
.L197:
	addi 28,28,-2
.L198:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L203:
	mr 3,30
	li 4,280
	la 5,.LC92@l(22)
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
	bc 4,2,.L203
.L204:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe5:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe5-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC96:
	.long 0x4b18967f
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
	lis 9,.LC97@ha
	li 31,0
	la 9,.LC97@l(9)
	li 25,0
	lfs 29,0(9)
	b .L206
.L208:
	lis 9,maxclients@ha
	lis 11,.LC98@ha
	lwz 10,maxclients@l(9)
	la 11,.LC98@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC96@ha
	lfs 31,.LC96@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L216
	lis 9,.LC99@ha
	lis 27,g_edicts@ha
	la 9,.LC99@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,896
.L211:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L213
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L213
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
	bc 4,0,.L213
	fmr 31,1
.L213:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,896
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L211
.L216:
	fcmpu 0,31,29
	bc 4,1,.L206
	fmr 29,31
	mr 25,31
.L206:
	lis 30,.LC92@ha
	mr 3,31
	li 4,280
	la 5,.LC92@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L208
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L221
	la 5,.LC92@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L221:
	lwz 0,100(1)
	mtlr 0
	lmw 25,44(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe6:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe6-SelectFarthestDeathmatchSpawnPoint
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
	li 30,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L236
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L237
	bl SelectFarthestDeathmatchSpawnPoint
	mr 30,3
	b .L240
.L237:
	bl SelectRandomDeathmatchSpawnPoint
	mr 30,3
	b .L240
.L264:
	li 30,0
	b .L240
.L236:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L240
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xbf54
	lwz 10,game+1028@l(11)
	ori 9,9,64031
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,3
	bc 12,2,.L240
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 30,game+1032@ha
.L246:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L264
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
	bc 4,2,.L246
	addic. 31,31,-1
	bc 4,2,.L246
	mr 30,29
.L240:
	cmpwi 0,30,0
	bc 4,2,.L252
	lis 29,.LC0@ha
	lis 31,game@ha
.L259:
	mr 3,30
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 30,3
	bc 12,2,.L265
	la 3,game@l(31)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L263
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L254
	b .L259
.L263:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 12,2,.L259
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L259
.L254:
	cmpwi 0,30,0
	bc 4,2,.L252
.L265:
	lis 9,game@ha
	la 31,game@l(9)
	lbz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L261
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L261:
	cmpwi 0,30,0
	bc 4,2,.L252
	lis 9,gi+28@ha
	lis 3,.LC100@ha
	lwz 0,gi+28@l(9)
	la 3,.LC100@l(3)
	addi 4,31,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L252:
	lfs 0,4(30)
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
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
.Lfe7:
	.size	 SelectSpawnPoint,.Lfe7-SelectSpawnPoint
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
	mulli 27,27,896
	addi 27,27,896
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
	lis 9,0xb6db
	lis 11,body_die@ha
	ori 9,9,28087
	la 11,body_die@l(11)
	subf 0,0,29
	li 10,1
	mullw 0,0,9
	mr 3,29
	srawi 0,0,7
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
.Lfe8:
	.size	 CopyToBodyQue,.Lfe8-CopyToBodyQue
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
	stwu 1,-4432(1)
	mflr 0
	stfd 31,4424(1)
	stmw 18,4368(1)
	stw 0,4436(1)
	lis 9,.LC105@ha
	lis 8,.LC106@ha
	lwz 0,.LC105@l(9)
	addi 11,1,8
	la 29,.LC106@l(8)
	la 9,.LC105@l(9)
	lwz 10,.LC106@l(8)
	mr 31,3
	lwz 28,8(9)
	addi 6,1,24
	addi 5,1,56
	lwz 7,4(9)
	mr 18,5
	stw 0,8(1)
	addi 4,1,40
	stw 28,8(11)
	stw 7,4(11)
	stw 10,24(1)
	lwz 0,8(29)
	lwz 11,4(29)
	lwz 9,84(31)
	stw 0,8(6)
	stw 11,4(6)
	lwz 19,3760(9)
	bl SelectSpawnPoint
	lis 9,deathmatch@ha
	lis 8,.LC110@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	la 8,.LC110@l(8)
	lis 11,g_edicts@ha
	lfs 13,0(8)
	lis 0,0xb6db
	lfs 0,20(10)
	ori 0,0,28087
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,7
	addi 25,9,-1
	bc 12,2,.L284
	addi 28,1,1688
	addi 27,30,1804
	mulli 24,25,3832
	mr 4,27
	li 5,1644
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 20,28
	addi 21,30,20
	addi 26,1,3336
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	mr 28,29
	addi 22,30,3428
	li 4,0
	li 5,1616
	addi 25,1,72
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 5,3
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,5
	mullw 9,9,0
	li 6,1
	addi 8,30,740
	li 11,100
	li 10,50
	srawi 9,9,3
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
	b .L286
.L284:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L287
	addi 27,1,1688
	addi 26,30,1804
	mulli 24,25,3832
	addi 29,1,3848
	mr 4,26
	li 5,1644
	mr 3,27
	crxor 6,6,6
	bl memcpy
	addi 28,30,188
	mr 20,27
	mr 3,29
	mr 4,28
	li 5,512
	mr 23,29
	crxor 6,6,6
	bl memcpy
	mr 27,26
	addi 21,30,20
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	addi 25,1,72
	addi 9,9,56
	addi 22,30,3428
	addi 10,1,2240
	addi 11,30,740
.L315:
	lwz 0,0(9)
	addi 9,9,72
	andi. 8,0,16
	bc 12,2,.L290
	lwz 0,0(11)
	stw 0,0(10)
.L290:
	addi 10,10,4
	addi 11,11,4
	bdnz .L315
	mr 4,20
	li 5,1616
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 4,23
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3308(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L286
	stw 9,1800(30)
	b .L286
.L287:
	addi 29,1,1688
	li 4,0
	mulli 24,25,3832
	mr 3,29
	li 5,1644
	crxor 6,6,6
	bl memset
	mr 20,29
	addi 27,30,1804
	addi 28,30,188
	addi 25,1,72
	addi 21,30,20
	addi 22,30,3428
.L286:
	mr 4,28
	li 5,1616
	mr 3,25
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3832
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,25
	mr 3,28
	li 5,1616
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L296
	li 4,0
	li 5,1616
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	li 6,1
	mullw 9,9,0
	addi 8,30,740
	li 11,100
	li 10,50
	li 7,200
	srawi 9,9,3
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
.L296:
	mr 3,27
	mr 4,20
	li 5,1644
	crxor 6,6,6
	bl memcpy
	lwz 11,84(31)
	lwz 0,724(11)
	stw 0,480(31)
	lwz 9,728(11)
	stw 9,484(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L298
	lwz 0,264(31)
	ori 0,0,4096
	stw 0,264(31)
.L298:
	lis 9,coop@ha
	lis 8,.LC110@ha
	lwz 11,coop@l(9)
	la 8,.LC110@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L300
	lwz 9,84(31)
	lwz 0,1800(9)
	stw 0,3424(9)
.L300:
	li 7,0
	lis 11,game+1028@ha
	lwz 6,264(31)
	stw 7,552(31)
	li 0,4
	lis 9,.LC107@ha
	lwz 3,game+1028@l(11)
	li 5,2
	la 9,.LC107@l(9)
	li 11,22
	stw 0,260(31)
	li 10,1
	stw 11,508(31)
	add 3,3,24
	li 0,200
	lis 11,.LC111@ha
	stw 10,88(31)
	lis 29,level+4@ha
	stw 9,280(31)
	la 11,.LC111@l(11)
	lis 10,0x201
	stw 0,400(31)
	lis 8,.LC108@ha
	lis 9,player_pain@ha
	stw 5,248(31)
	la 8,.LC108@l(8)
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
	lis 8,.LC112@ha
	lfs 0,40(1)
	la 8,.LC112@l(8)
	mr 11,9
	lbz 0,16(30)
	lfs 10,0(8)
	mr 10,9
	andi. 0,0,191
	lis 8,deathmatch@ha
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4360(1)
	lwz 9,4364(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4360(1)
	lwz 11,4364(1)
	sth 11,6(30)
	lfs 0,48(1)
	stb 0,16(30)
	lwz 9,deathmatch@l(8)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4360(1)
	lwz 10,4364(1)
	sth 10,8(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L301
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4360(1)
	lwz 11,4364(1)
	andi. 0,11,32768
	bc 4,2,.L316
.L301:
	lis 4,.LC109@ha
	mr 3,28
	la 4,.LC109@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4364(1)
	lis 0,0x4330
	lis 8,.LC113@ha
	la 8,.LC113@l(8)
	stw 0,4360(1)
	lis 11,.LC114@ha
	lfd 13,0(8)
	la 11,.LC114@l(11)
	lfd 0,4360(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L303
.L316:
	lis 0,0x42b4
	stw 0,112(30)
	b .L302
.L303:
	lis 8,.LC115@ha
	la 8,.LC115@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L302
	stfs 13,112(30)
.L302:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 9,.LC117@ha
	lis 11,g_edicts@ha
	stw 3,88(30)
	la 9,.LC117@l(9)
	lfs 13,48(1)
	li 0,255
	lfs 10,0(9)
	lis 10,0xb6db
	lis 8,.LC116@ha
	lwz 9,g_edicts@l(11)
	ori 10,10,28087
	la 8,.LC116@l(8)
	lis 11,.LC114@ha
	lfs 11,40(1)
	mr 5,18
	la 11,.LC114@l(11)
	lfs 12,44(1)
	subf 9,9,31
	lfs 0,0(11)
	mullw 9,9,10
	mr 7,22
	stw 0,40(31)
	li 11,0
	li 10,0
	li 0,3
	srawi 9,9,7
	lfs 9,0(8)
	fadds 13,13,0
	mtctr 0
	addi 9,9,-1
	mr 8,21
	stw 11,56(31)
	stfs 11,28(31)
	stfs 12,32(31)
	stfs 13,36(31)
	stw 9,60(31)
	stw 11,64(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L314:
	lfsx 0,10,5
	lfsx 12,10,7
	addi 10,10,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4360(1)
	lwz 9,4364(1)
	sth 9,0(8)
	addi 8,8,2
	bdnz .L314
	lis 8,.LC110@ha
	lfs 0,60(1)
	mr 3,31
	la 8,.LC110@l(8)
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
	stfs 0,3616(30)
	lfs 13,20(31)
	stfs 13,3620(30)
	lfs 0,24(31)
	stfs 0,3624(30)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	stw 19,3760(10)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L312
	mr 3,31
	bl Chicken_CheckInPlayer
.L312:
	lwz 9,84(31)
	lis 11,teamWithChicken@ha
	li 0,-1
	lwz 4,teamWithChicken@l(11)
	mr 3,31
	stw 0,3776(9)
	bl Chicken_PlayerReadyEggGun
	cmpwi 0,3,0
	bc 12,2,.L313
	mr 3,31
	bl ChangeWeapon
.L313:
	mr 3,31
	bl ShowGun
	lwz 0,4436(1)
	mtlr 0
	lmw 18,4368(1)
	lfd 31,4424(1)
	la 1,4432(1)
	blr
.Lfe9:
	.size	 PutClientInServer,.Lfe9-PutClientInServer
	.section	".rodata"
	.align 2
.LC118:
	.string	"CamClient"
	.align 2
.LC119:
	.string	"%s entered the game\n"
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	bl G_InitEdict
	lwz 29,84(31)
	li 4,0
	li 5,1644
	addi 28,29,1804
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	addi 4,29,188
	lwz 0,level@l(9)
	li 5,1616
	mr 3,28
	stw 0,3420(29)
	crxor 6,6,6
	bl memcpy
	lwz 3,84(31)
	lis 4,.LC118@ha
	la 4,.LC118@l(4)
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L319
	mr 3,31
	bl MakeCamera
	lwz 9,84(31)
	li 0,1
	b .L321
.L319:
	mr 3,31
	bl PutClientInServer
	lwz 9,84(31)
	li 0,0
.L321:
	stw 0,3780(9)
	mr 3,31
	lis 28,gi@ha
	bl EntityListAdd
	la 29,gi@l(28)
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xb6db
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,28087
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,7
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
	lwz 0,gi@l(28)
	lis 4,.LC119@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC119@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	mr 3,31
	bl ClientEndServerFrame
	mr 3,31
	bl Chicken_ClientBegin
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 ClientBeginDeathmatch,.Lfe10-ClientBeginDeathmatch
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
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,g_edicts@ha
	mr 31,3
	lwz 9,g_edicts@l(11)
	lis 0,0xb6db
	lis 10,deathmatch@ha
	ori 0,0,28087
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC120@ha
	srawi 9,9,7
	la 10,.LC120@l(10)
	mulli 9,9,3832
	lfs 13,0(10)
	addi 9,9,-3832
	add 8,8,9
	stw 8,84(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L323
	bl ClientBeginDeathmatch
	b .L322
.L323:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L324
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
.L335:
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
	bdnz .L335
	b .L330
.L324:
	mr 3,31
	bl G_InitEdict
	lwz 28,84(31)
	lis 9,.LC107@ha
	li 4,0
	la 9,.LC107@l(9)
	li 5,1644
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
.L330:
	lis 10,.LC120@ha
	lis 9,level+200@ha
	la 10,.LC120@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L332
	mr 3,31
	bl MoveClientToIntermission
	b .L333
.L332:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L333
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xb6db
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,28087
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,7
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
	lis 4,.LC119@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC119@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L333:
	mr 3,31
	bl ClientEndServerFrame
.L322:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 ClientBegin,.Lfe11-ClientBegin
	.section	".rodata"
	.align 2
.LC123:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC124:
	.string	"name"
	.align 2
.LC125:
	.string	"%s\\%s"
	.align 2
.LC126:
	.string	"hand"
	.align 2
.LC127:
	.long 0x0
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
	bc 4,2,.L337
	lis 11,.LC123@ha
	lwz 0,.LC123@l(11)
	la 9,.LC123@l(11)
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
.L337:
	lis 4,.LC124@ha
	mr 3,30
	la 4,.LC124@l(4)
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
	lis 9,g_edicts@ha
	lis 0,0xb6db
	lwz 4,84(27)
	lwz 29,g_edicts@l(9)
	ori 0,0,28087
	mr 31,3
	lis 28,gi@ha
	lis 3,.LC125@ha
	subf 29,29,27
	la 28,gi@l(28)
	mullw 29,29,0
	addi 4,4,700
	mr 5,31
	la 3,.LC125@l(3)
	srawi 29,29,7
	addi 29,29,1311
	crxor 6,6,6
	bl va
	lwz 0,24(28)
	mr 4,3
	mr 3,29
	mtlr 0
	blrl
	lis 9,.LC127@ha
	lis 11,deathmatch@ha
	la 9,.LC127@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L338
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L338
	lwz 9,84(27)
	b .L345
.L338:
	lis 4,.LC109@ha
	mr 3,30
	la 4,.LC109@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC128@ha
	la 10,.LC128@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC129@ha
	la 10,.LC129@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L340
.L345:
	lis 0,0x42b4
	stw 0,112(9)
	b .L339
.L340:
	lis 11,.LC130@ha
	la 11,.LC130@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L339
	stfs 13,112(9)
.L339:
	lis 4,.LC126@ha
	mr 3,30
	la 4,.LC126@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L343
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L343:
	lwz 3,84(27)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
	lis 9,chickenGame@ha
	lwz 0,chickenGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L344
	mr 3,27
	bl Chicken_CheckPlayerModel
.L344:
	mr 3,27
	bl ShowGun
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 ClientUserinfoChanged,.Lfe12-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC131:
	.string	"ip"
	.align 2
.LC132:
	.string	"password"
	.align 2
.LC133:
	.string	"%s connected\n"
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,4
	mr 30,3
	lis 4,.LC131@ha
	mr 3,28
	la 4,.LC131@l(4)
	bl Info_ValueForKey
	lis 4,.LC132@ha
	mr 3,28
	la 4,.LC132@l(4)
	bl Info_ValueForKey
	lis 9,password@ha
	mr 4,3
	lwz 11,password@l(9)
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L347
	li 3,0
	b .L354
.L347:
	lis 11,g_edicts@ha
	lis 0,0xb6db
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,28087
	lis 11,game@ha
	cmpwi 0,10,0
	subf 9,9,30
	la 27,game@l(11)
	mullw 9,9,0
	lwz 11,1028(27)
	srawi 9,9,7
	mulli 9,9,3832
	addi 9,9,-3832
	add 31,11,9
	stw 31,84(30)
	bc 4,2,.L348
	addi 29,31,1804
	li 4,0
	li 5,1644
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
	lwz 0,1560(27)
	cmpwi 0,0,0
	bc 12,2,.L351
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L348
.L351:
	lwz 29,84(30)
	li 4,0
	li 5,1616
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	li 8,1
	mullw 9,9,0
	addi 7,29,740
	li 10,50
	li 0,100
	li 6,200
	srawi 9,9,3
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
.L348:
	mr 4,28
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L353
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC133@ha
	lwz 0,gi+4@l(9)
	la 3,.LC133@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L353:
	lwz 11,84(30)
	li 0,1
	li 10,-1
	li 3,1
	stw 0,720(11)
	lwz 9,84(30)
	stw 10,3760(9)
.L354:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 ClientConnect,.Lfe13-ClientConnect
	.section	".rodata"
	.align 2
.LC134:
	.string	"%s disconnected\n"
	.align 2
.LC135:
	.string	"disconnected"
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L355
	lis 29,gi@ha
	lis 4,.LC134@ha
	lwz 9,gi@l(29)
	addi 5,5,700
	la 4,.LC134@l(4)
	li 3,2
	la 29,gi@l(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xb6db
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,28087
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,7
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
	lwz 0,76(29)
	mr 3,31
	mtlr 0
	blrl
	lis 9,.LC135@ha
	li 0,0
	lwz 11,84(31)
	la 9,.LC135@l(9)
	stw 0,40(31)
	mr 3,31
	stw 9,280(31)
	stw 0,248(31)
	stw 0,88(31)
	stw 0,720(11)
	bl EntityListRemove
	mr 3,31
	bl Chicken_CheckOutPlayer
	lis 9,chickenItemIndex@ha
	lwz 10,84(31)
	lwz 0,chickenItemIndex@l(9)
	addi 11,10,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L357
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 4,2,.L357
	lis 9,chickenItem@ha
	mr 3,31
	lwz 4,chickenItem@l(9)
	bl Chicken_Drop
.L357:
	lis 9,g_edicts@ha
	lis 0,0xb6db
	lwz 3,g_edicts@l(9)
	ori 0,0,28087
	lis 4,.LC22@ha
	lis 9,gi+24@ha
	la 4,.LC22@l(4)
	subf 3,3,31
	lwz 9,gi+24@l(9)
	mullw 3,3,0
	mtlr 9
	srawi 3,3,7
	addi 3,3,1311
	blrl
.L355:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ClientDisconnect,.Lfe14-ClientDisconnect
	.section	".rodata"
	.align 2
.LC136:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC138:
	.string	"*jump1.wav"
	.align 3
.LC137:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC139:
	.long 0x0
	.align 3
.LC140:
	.long 0x40140000
	.long 0x0
	.align 2
.LC141:
	.long 0x41000000
	.align 3
.LC142:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC143:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC144:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-320(1)
	mflr 0
	stmw 21,276(1)
	stw 0,324(1)
	lis 9,level@ha
	mr 30,3
	la 9,level@l(9)
	mr 26,4
	stw 30,292(9)
	lwz 31,84(30)
	lwz 0,3780(31)
	cmpwi 0,0,0
	bc 12,2,.L381
	bl CameraThink
	b .L380
.L381:
	lis 10,.LC139@ha
	lfs 13,200(9)
	la 10,.LC139@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 12,2,.L382
	li 0,4
	lis 11,.LC140@ha
	stw 0,0(31)
	la 11,.LC140@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L380
	lbz 0,1(26)
	andi. 21,0,128
	bc 12,2,.L380
	li 0,1
	stw 0,208(9)
	b .L380
.L382:
	addi 3,1,8
	lis 9,pm_passent@ha
	mr 29,3
	stw 30,pm_passent@l(9)
	li 4,0
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L388
	lwz 0,40(30)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L388
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L388
	li 0,2
.L388:
	stw 0,0(31)
	lis 9,sv_gravity@ha
	lwz 7,0(31)
	lwz 10,sv_gravity@l(9)
	li 21,3
	addi 23,1,12
	lwz 0,8(31)
	mtctr 21
	addi 24,30,4
	addi 22,1,18
	lfs 0,20(10)
	addi 25,30,376
	mr 12,23
	lwz 9,12(31)
	lis 10,.LC141@ha
	mr 4,24
	lwz 8,4(31)
	la 10,.LC141@l(10)
	mr 3,22
	lfs 10,0(10)
	mr 5,25
	addi 28,31,3448
	addi 27,1,36
	li 6,0
	li 10,0
	fctiwz 13,0
	stfd 13,264(1)
	lwz 11,268(1)
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
.L422:
	lfsx 13,6,4
	lfsx 0,6,5
	mr 9,11
	addi 6,6,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,264(1)
	lwz 11,268(1)
	stfd 11,264(1)
	lwz 9,268(1)
	sthx 11,10,12
	sthx 9,10,3
	addi 10,10,2
	bdnz .L422
	mr 3,28
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L395
	li 0,1
	stw 0,52(1)
.L395:
	lis 9,gi@ha
	lwz 7,0(26)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(26)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lis 21,.LC143@ha
	lwz 8,8(26)
	la 21,.LC143@l(21)
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
	lis 9,.LC142@ha
	lwz 11,8(1)
	mr 27,23
	la 9,.LC142@l(9)
	lwz 10,4(29)
	mr 3,25
	lfd 11,0(9)
	mr 4,22
	mr 5,24
	lwz 0,8(29)
	lis 6,0x4330
	li 7,0
	lwz 9,12(29)
	li 8,0
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
	stw 0,3448(31)
	stw 9,4(28)
	stw 11,8(28)
	stw 10,12(28)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	lfd 12,0(21)
	stw 0,24(28)
	stw 9,16(28)
	stw 11,20(28)
.L421:
	lhax 0,7,27
	lhax 9,7,4
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
	stfsx 13,8,5
	stfsx 0,8,3
	addi 8,8,4
	bdnz .L421
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 21,.LC142@ha
	lis 7,.LC137@ha
	lfs 8,204(1)
	la 21,.LC142@l(21)
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
	lfd 12,0(21)
	xoris 0,0,0x8000
	lfd 13,.LC137@l(7)
	stw 0,268(1)
	stw 8,264(1)
	lfd 0,264(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3428(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,268(1)
	stw 8,264(1)
	lfd 0,264(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3432(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,268(1)
	stw 8,264(1)
	lfd 0,264(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3436(31)
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 12,2,.L401
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L401
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L401
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L401
	lis 29,gi@ha
	lis 3,.LC138@ha
	la 29,gi@l(29)
	la 3,.LC138@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC144@ha
	lis 10,.LC144@ha
	lis 11,.LC139@ha
	mr 5,3
	la 9,.LC144@l(9)
	la 10,.LC144@l(10)
	mtlr 0
	la 11,.LC139@l(11)
	mr 3,30
	lfs 1,0(9)
	li 4,2
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	mr 4,24
	mr 3,30
	li 5,0
	bl PlayerNoise
.L401:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(30)
	stw 11,608(30)
	fctiwz 13,0
	stw 10,552(30)
	stfd 13,264(1)
	lwz 9,268(1)
	stw 9,508(30)
	bc 12,2,.L402
	lwz 0,92(10)
	stw 0,556(30)
.L402:
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L403
	lfs 0,3544(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L404
.L403:
	lfs 0,188(1)
	stfs 0,3616(31)
	lfs 13,192(1)
	stfs 13,3620(31)
	lfs 0,196(1)
	stfs 0,3624(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L404:
	lis 9,gi+72@ha
	mr 3,30
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L405
	mr 3,30
	bl G_TouchTriggers
.L405:
	lwz 0,56(1)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L407
	addi 29,1,60
.L409:
	li 10,0
	slwi 0,11,2
	cmpw 0,10,11
	lwzx 3,29,0
	addi 28,11,1
	bc 4,0,.L411
	lwz 0,0(29)
	cmpw 0,0,3
	bc 12,2,.L411
	mr 9,29
.L412:
	addi 10,10,1
	cmpw 0,10,11
	bc 4,0,.L411
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L412
.L411:
	cmpw 0,10,11
	bc 4,2,.L408
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L408
	mr 4,30
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L408:
	lwz 0,56(1)
	mr 11,28
	cmpw 0,11,0
	bc 12,0,.L409
.L407:
	lwz 0,3496(31)
	lwz 11,3504(31)
	stw 0,3500(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3496(31)
	or 11,11,0
	stw 11,3504(31)
	lbz 0,15(26)
	stw 0,640(30)
	lwz 9,3504(31)
	andi. 0,9,1
	bc 12,2,.L380
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L380
	lwz 0,3508(31)
	cmpwi 0,0,0
	bc 4,2,.L380
	li 0,1
	mr 3,30
	stw 0,3508(31)
	bl Think_Weapon
.L380:
	lwz 0,324(1)
	mtlr 0
	lmw 21,276(1)
	la 1,320(1)
	blr
.Lfe15:
	.size	 ClientThink,.Lfe15-ClientThink
	.section	".rodata"
	.align 2
.LC145:
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
	lis 11,.LC145@ha
	lis 9,level+200@ha
	la 11,.LC145@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L423
	lwz 9,84(31)
	lwz 0,720(9)
	cmpwi 0,0,0
	bc 12,2,.L425
	bl Chicken_ShowMenu
	cmpwi 0,3,0
	bc 12,2,.L425
	mr 3,31
	bl Chicken_MenuDisplay
.L425:
	lwz 30,84(31)
	lwz 0,3508(30)
	cmpwi 0,0,0
	bc 4,2,.L426
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L426
	mr 3,31
	bl Think_Weapon
	b .L427
.L426:
	li 0,0
	stw 0,3508(30)
.L427:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L428
	lis 9,level@ha
	lfs 13,3724(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L423
	lis 9,.LC145@ha
	lis 11,deathmatch@ha
	lwz 10,3504(30)
	la 9,.LC145@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L433
	bc 12,30,.L423
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L423
.L433:
	bc 4,30,.L434
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L435
.L434:
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
	stfs 0,3724(11)
	b .L439
.L435:
	lis 9,gi+168@ha
	lis 3,.LC104@ha
	lwz 0,gi+168@l(9)
	la 3,.LC104@l(3)
	mtlr 0
	blrl
	b .L440
.L428:
	lis 9,.LC145@ha
	lis 11,deathmatch@ha
	la 9,.LC145@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L437
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L437
	addi 3,31,28
	bl PlayerTrail_Add
.L437:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3748(11)
	fcmpu 0,0,13
	bc 4,1,.L439
	mr 3,31
	bl Chicken_MOTD
.L440:
.L439:
	li 0,0
	stw 0,3504(30)
.L423:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 ClientBeginServerFrame,.Lfe16-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC146:
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
	lis 11,.LC146@ha
	lis 9,deathmatch@ha
	la 11,.LC146@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L282
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L281
.L282:
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
	stfs 0,3724(11)
	b .L280
.L281:
	lis 9,gi+168@ha
	lis 3,.LC104@ha
	lwz 0,gi+168@l(9)
	la 3,.LC104@l(3)
	mtlr 0
	blrl
.L280:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 respawn,.Lfe17-respawn
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 4,0
	li 5,1616
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	li 8,1
	mullw 9,9,0
	addi 7,29,740
	li 11,100
	li 10,50
	li 6,200
	srawi 9,9,3
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
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 InitClientPersistant,.Lfe18-InitClientPersistant
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
	li 5,1644
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
	lis 11,.LC103@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC103@l(11)
.L270:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L270
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
.LC147:
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
	lis 9,.LC147@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC147@l(9)
	addi 10,10,896
	lfs 13,0(9)
.L163:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L162
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
	bc 12,2,.L162
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3424(9)
	add 11,7,11
	stw 0,1800(11)
.L162:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3832
	addi 10,10,896
	cmpw 0,6,0
	bc 12,0,.L163
	blr
.Lfe22:
	.size	 SaveClientData,.Lfe22-SaveClientData
	.section	".rodata"
	.align 2
.LC148:
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
	bc 12,2,.L168
	lwz 0,264(3)
	ori 0,0,4096
	stw 0,264(3)
.L168:
	lis 9,.LC148@ha
	lis 11,coop@ha
	la 9,.LC148@l(9)
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
	.comm	pTempFind,4,4
	.section	".rodata"
	.align 2
.LC149:
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
	lis 9,.LC149@ha
	mr 30,3
	la 9,.LC149@l(9)
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
.LC150:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC151:
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
	lis 11,.LC151@ha
	lis 9,coop@ha
	la 11,.LC151@l(11)
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
	lis 11,.LC150@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC150@l(11)
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
.LC152:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC152@ha
	lis 9,deathmatch@ha
	la 11,.LC152@l(11)
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
	b .L441
.L30:
	li 3,0
.L441:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 IsFemale,.Lfe28-IsFemale
	.section	".rodata"
	.align 3
.LC153:
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
	bc 12,2,.L121
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L121
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L442
.L121:
	cmpwi 0,4,0
	bc 12,2,.L123
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L123
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L442:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L122
.L123:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3544(9)
	b .L120
.L122:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC153@ha
	lwz 11,84(31)
	lfd 0,.LC153@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3544(11)
.L120:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 LookAtKiller,.Lfe29-LookAtKiller
	.section	".rodata"
	.align 2
.LC154:
	.long 0x4b18967f
	.align 2
.LC155:
	.long 0x3f800000
	.align 3
.LC156:
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
	lis 11,.LC155@ha
	lwz 10,maxclients@l(9)
	la 11,.LC155@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC154@ha
	lfs 31,.LC154@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L172
	lis 9,.LC156@ha
	lis 27,g_edicts@ha
	la 9,.LC156@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,896
.L174:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L173
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L173
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
	bc 4,0,.L173
	fmr 31,1
.L173:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,896
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L174
.L172:
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
	bc 4,2,.L223
	bl SelectRandomDeathmatchSpawnPoint
	b .L444
.L223:
	bl SelectFarthestDeathmatchSpawnPoint
.L444:
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
	lis 9,0xbf54
	lwz 10,game+1028@l(11)
	ori 9,9,64031
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,3
	bc 12,2,.L445
.L229:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L230
	li 3,0
	b .L445
.L230:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L231
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L231:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L229
	addic. 31,31,-1
	bc 4,2,.L229
	mr 3,30
.L445:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 SelectCoopSpawnPoint,.Lfe32-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC157:
	.long 0x3f800000
	.align 2
.LC158:
	.long 0x0
	.align 2
.LC159:
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
	bc 4,0,.L273
	lis 29,gi@ha
	lis 3,.LC84@ha
	la 29,gi@l(29)
	la 3,.LC84@l(3)
	lwz 9,36(29)
	lis 27,.LC85@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC157@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC157@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC157@ha
	la 9,.LC157@l(9)
	lfs 2,0(9)
	lis 9,.LC158@ha
	la 9,.LC158@l(9)
	lfs 3,0(9)
	blrl
.L277:
	mr 3,31
	la 4,.LC85@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L277
	lis 9,.LC159@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC159@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L273:
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
	bc 4,1,.L359
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L358
.L359:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L358:
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
	bc 4,0,.L363
.L365:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L365
.L363:
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
.L447:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L447
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L446:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L446
	lis 3,.LC136@ha
	la 3,.LC136@l(3)
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
