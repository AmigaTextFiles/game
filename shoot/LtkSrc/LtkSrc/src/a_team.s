	.file	"a_team.c"
gcc2_compiled.:
	.globl team_game_going
	.section	".sdata","aw"
	.align 2
	.type	 team_game_going,@object
	.size	 team_game_going,4
team_game_going:
	.long 0
	.globl team_round_going
	.align 2
	.type	 team_round_going,@object
	.size	 team_round_going,4
team_round_going:
	.long 0
	.globl team_round_countdown
	.align 2
	.type	 team_round_countdown,@object
	.size	 team_round_countdown,4
team_round_countdown:
	.long 0
	.globl rulecheckfrequency
	.align 2
	.type	 rulecheckfrequency,@object
	.size	 rulecheckfrequency,4
rulecheckfrequency:
	.long 0
	.globl lights_camera_action
	.align 2
	.type	 lights_camera_action,@object
	.size	 lights_camera_action,4
lights_camera_action:
	.long 0
	.globl holding_on_tie_check
	.align 2
	.type	 holding_on_tie_check,@object
	.size	 holding_on_tie_check,4
holding_on_tie_check:
	.long 0
	.globl current_round_length
	.align 2
	.type	 current_round_length,@object
	.size	 current_round_length,4
current_round_length:
	.long 0
	.globl team1_score
	.align 2
	.type	 team1_score,@object
	.size	 team1_score,4
team1_score:
	.long 0
	.globl team2_score
	.align 2
	.type	 team2_score,@object
	.size	 team2_score,4
team2_score:
	.long 0
	.globl team1_total
	.align 2
	.type	 team1_total,@object
	.size	 team1_total,4
team1_total:
	.long 0
	.globl team2_total
	.align 2
	.type	 team2_total,@object
	.size	 team2_total,4
team2_total:
	.long 0
	.globl num_teams
	.align 2
	.type	 num_teams,@object
	.size	 num_teams,4
num_teams:
	.long 2
	.globl transparent_list
	.align 2
	.type	 transparent_list,@object
	.size	 transparent_list,4
transparent_list:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"Out of memory\n"
	.align 2
.LC1:
	.string	"Warning: attempt to RemoveFromTransparentList when not in it\n"
	.align 2
.LC2:
	.string	"MP5/10 Submachinegun"
	.align 2
.LC3:
	.string	"M3 Super 90 Assault Shotgun"
	.align 2
.LC4:
	.string	"Handcannon"
	.align 2
.LC5:
	.string	"Sniper Rifle"
	.align 2
.LC6:
	.string	"M4 Assault Rifle"
	.align 2
.LC7:
	.string	"Combat Knife"
	.align 2
.LC8:
	.string	"Dual MK23 Pistols"
	.align 2
.LC9:
	.string	"Kevlar Vest"
	.align 2
.LC10:
	.string	"Lasersight"
	.align 2
.LC11:
	.string	"Stealth Slippers"
	.align 2
.LC12:
	.string	"Silencer"
	.align 2
.LC13:
	.string	"Bandolier"
	.globl creditsmenu
	.section	".data"
	.align 2
	.type	 creditsmenu,@object
creditsmenu:
	.long .LC14
	.long 1
	.long 0
	.long 0
	.long .LC15
	.long 1
	.long 0
	.long 0
	.long .LC16
	.long 1
	.long 0
	.long 0
	.long .LC17
	.long 1
	.long 0
	.long 0
	.long .LC18
	.long 1
	.long 0
	.long 0
	.long .LC19
	.long 1
	.long 0
	.long 0
	.long .LC20
	.long 1
	.long 0
	.long 0
	.long .LC21
	.long 1
	.long 0
	.long 0
	.long .LC22
	.long 1
	.long 0
	.long 0
	.long .LC23
	.long 1
	.long 0
	.long 0
	.long .LC24
	.long 1
	.long 0
	.long 0
	.long .LC25
	.long 1
	.long 0
	.long 0
	.long .LC26
	.long 1
	.long 0
	.long 0
	.long .LC27
	.long 1
	.long 0
	.long 0
	.long .LC28
	.long 1
	.long 0
	.long 0
	.long .LC29
	.long 1
	.long 0
	.long 0
	.long .LC30
	.long 1
	.long 0
	.long 0
	.long .LC31
	.long 1
	.long 0
	.long 0
	.long .LC32
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC33
	.long 0
	.long 0
	.long CreditsReturnToMain
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC34
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC35
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC35:
	.string	"v1.52"
	.align 2
.LC34:
	.string	"TAB to exit menu"
	.align 2
.LC33:
	.string	"Return to main menu"
	.align 2
.LC32:
	.string	"Bob 'Fireblade' Farmer"
	.align 2
.LC31:
	.string	"Carl 'Zucchini' Schedvin"
	.align 2
.LC30:
	.string	"*Action 1.5 ('Axshun') Programming"
	.align 2
.LC29:
	.string	"Dallas 'Suislide' Frank"
	.align 2
.LC28:
	.string	"Minh 'Gooseman' Le"
	.align 2
.LC27:
	.string	"*Models, Skins, Etc"
	.align 2
.LC26:
	.string	"Evan 'Ace12GA' Prentice"
	.align 2
.LC25:
	.string	"*Levels"
	.align 2
.LC24:
	.string	"Jon 'Vain' Delee"
	.align 2
.LC23:
	.string	"*Skins, Etc"
	.align 2
.LC22:
	.string	"Michael 'Siris' Taylor"
	.align 2
.LC21:
	.string	"Nathan 'Pietro' Kovner"
	.align 2
.LC20:
	.string	"*Original Programming"
	.align 2
.LC19:
	.string	"Patrick 'Bartender' Mills"
	.align 2
.LC18:
	.string	"*Sounds, Second-In-Command"
	.align 2
.LC17:
	.string	"Sam 'Cail' Thompson"
	.align 2
.LC16:
	.string	"*Head Design, Original Programming"
	.align 2
.LC15:
	.string	"--------------"
	.align 2
.LC14:
	.string	"*Action Quake 2"
	.size	 creditsmenu,400
	.globl weapmenu
	.section	".data"
	.align 2
	.type	 weapmenu,@object
weapmenu:
	.long .LC14
	.long 1
	.long 0
	.long 0
	.long .LC15
	.long 1
	.long 0
	.long 0
	.long .LC36
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC2
	.long 0
	.long 0
	.long SelectWeapon2
	.long .LC37
	.long 0
	.long 0
	.long SelectWeapon3
	.long .LC4
	.long 0
	.long 0
	.long SelectWeapon4
	.long .LC38
	.long 0
	.long 0
	.long SelectWeapon5
	.long .LC6
	.long 0
	.long 0
	.long SelectWeapon6
	.long .LC39
	.long 0
	.long 0
	.long SelectWeapon0
	.long .LC40
	.long 0
	.long 0
	.long SelectWeapon9
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC41
	.long 0
	.long 0
	.long 0
	.long .LC42
	.long 0
	.long 0
	.long 0
	.long .LC34
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC35
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC42:
	.string	"ENTER to select"
	.align 2
.LC41:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC40:
	.string	"Akimbo Pistols"
	.align 2
.LC39:
	.string	"Combat Knives"
	.align 2
.LC38:
	.string	"SSG 3000 Sniper Rifle"
	.align 2
.LC37:
	.string	"M3 Super90 Assault Shotgun"
	.align 2
.LC36:
	.string	"Select your weapon"
	.size	 weapmenu,272
	.globl itemmenu
	.section	".data"
	.align 2
	.type	 itemmenu,@object
itemmenu:
	.long .LC14
	.long 1
	.long 0
	.long 0
	.long .LC15
	.long 1
	.long 0
	.long 0
	.long .LC43
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC9
	.long 0
	.long 0
	.long SelectItem1
	.long .LC44
	.long 0
	.long 0
	.long SelectItem2
	.long .LC11
	.long 0
	.long 0
	.long SelectItem3
	.long .LC12
	.long 0
	.long 0
	.long SelectItem4
	.long .LC13
	.long 0
	.long 0
	.long SelectItem5
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC41
	.long 0
	.long 0
	.long 0
	.long .LC42
	.long 0
	.long 0
	.long 0
	.long .LC34
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC35
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC44:
	.string	"Laser Sight"
	.align 2
.LC43:
	.string	"Select your item"
	.size	 itemmenu,240
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
	.long .LC14
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long JoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long JoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC45
	.long 0
	.long 0
	.long ReprintMOTD
	.long .LC46
	.long 0
	.long 0
	.long CreditsMenu
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC41
	.long 0
	.long 0
	.long 0
	.long .LC42
	.long 0
	.long 0
	.long 0
	.long .LC34
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC35
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC46:
	.string	"Credits"
	.align 2
.LC45:
	.string	"MOTD"
	.size	 joinmenu,256
	.align 2
.LC47:
	.string	"None"
	.align 2
.LC48:
	.string	"%s\\%s"
	.align 2
.LC49:
	.string	"You are on %s.\n"
	.align 2
.LC50:
	.string	"You must wait 5 seconds before changing teams again.\n"
	.align 2
.LC51:
	.string	"none"
	.align 2
.LC52:
	.string	"You're not on a team.\n"
	.align 2
.LC53:
	.string	"1"
	.align 2
.LC54:
	.string	"2"
	.align 2
.LC55:
	.string	"Unknown team %s.\n"
	.align 2
.LC56:
	.string	"You are already on %s.\n"
	.section	".text"
	.align 2
	.globl Team_f
	.type	 Team_f,@function
Team_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+164@ha
	mr 30,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 31,3
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L63
	lwz 9,84(30)
	lwz 0,3488(9)
	cmpwi 0,0,1
	bc 4,2,.L64
	lis 9,team1_name@ha
	la 6,team1_name@l(9)
	b .L65
.L64:
	cmpwi 0,0,2
	bc 4,2,.L67
	lis 9,team2_name@ha
	la 6,team2_name@l(9)
	b .L65
.L67:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
.L65:
	lis 5,.LC49@ha
	mr 3,30
	la 5,.LC49@l(5)
	b .L87
.L63:
	lwz 10,84(30)
	lis 11,level@ha
	lwz 0,level@l(11)
	lwz 9,3492(10)
	addi 9,9,50
	cmpw 0,0,9
	bc 4,0,.L69
	lis 5,.LC50@ha
	mr 3,30
	la 5,.LC50@l(5)
	b .L88
.L69:
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L70
	lwz 9,84(30)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 4,2,.L71
	lis 5,.LC52@ha
	mr 3,30
	la 5,.LC52@l(5)
.L88:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L62
.L71:
	mr 3,30
	bl LeaveTeam
	b .L62
.L70:
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	li 4,1
	bc 12,2,.L74
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	li 4,2
	bc 12,2,.L74
	lis 4,team1_name@ha
	mr 3,31
	la 4,team1_name@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	li 4,1
	bc 12,2,.L74
	lis 4,team2_name@ha
	mr 3,31
	la 4,team2_name@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L79
	lis 5,.LC55@ha
	mr 3,30
	la 5,.LC55@l(5)
	mr 6,31
	b .L87
.L79:
	li 4,2
.L74:
	lwz 9,84(30)
	lwz 0,3488(9)
	cmpw 0,0,4
	bc 4,2,.L81
	cmpwi 0,4,1
	bc 4,2,.L82
	lis 9,team1_name@ha
	la 6,team1_name@l(9)
	b .L83
.L82:
	cmpwi 0,4,2
	bc 4,2,.L85
	lis 9,team2_name@ha
	la 6,team2_name@l(9)
	b .L83
.L85:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
.L83:
	lis 5,.LC56@ha
	mr 3,30
	la 5,.LC56@l(5)
.L87:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L62
.L81:
	mr 3,30
	li 5,1
	bl JoinTeam
.L62:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 Team_f,.Lfe1-Team_f
	.section	".rodata"
	.align 2
.LC57:
	.string	"Your team now has %d more player%s than %s.\n"
	.align 2
.LC58:
	.string	""
	.align 2
.LC59:
	.string	"s"
	.align 2
.LC60:
	.string	"play misc/comp_up.wav"
	.align 2
.LC61:
	.long 0x3f800000
	.align 3
.LC62:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CheckForUnevenTeams
	.type	 CheckForUnevenTeams,@function
CheckForUnevenTeams:
	stwu 1,-96(1)
	mflr 0
	mfcr 12
	stfd 31,88(1)
	stmw 20,40(1)
	stw 0,100(1)
	stw 12,36(1)
	lis 9,num_teams@ha
	li 8,0
	lwz 0,num_teams@l(9)
	li 6,0
	cmpwi 0,0,2
	bc 12,1,.L99
	lis 9,maxclients@ha
	lis 4,.LC61@ha
	lwz 11,maxclients@l(9)
	la 4,.LC61@l(4)
	li 7,1
	lfs 0,0(4)
	lis 21,maxclients@ha
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L102
	lis 9,g_edicts@ha
	fmr 12,13
	lis 5,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	addi 10,11,996
	lfd 13,0(9)
.L104:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L103
	lwz 9,84(10)
	lwz 11,3488(9)
	cmpwi 0,11,1
	bc 4,2,.L106
	addi 8,8,1
	b .L103
.L106:
	xori 11,11,2
	addi 9,6,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,6,0
	or 6,0,9
.L103:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,996
	stw 0,28(1)
	stw 5,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L104
.L102:
	cmpw 0,8,6
	bc 4,1,.L110
	lis 9,maxclients@ha
	lis 11,.LC61@ha
	lwz 10,maxclients@l(9)
	la 11,.LC61@l(11)
	subf 29,6,8
	lfs 13,0(11)
	li 28,1
	lfs 0,20(10)
	lis 11,team2_name@ha
	la 20,team2_name@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L99
	lis 4,.LC62@ha
	cmpwi 4,29,1
	la 4,.LC62@l(4)
	lis 22,g_edicts@ha
	lfd 31,0(4)
	lis 23,.LC58@ha
	lis 24,.LC59@ha
	lis 25,.LC57@ha
	lis 26,.LC60@ha
	lis 27,0x4330
	li 30,996
.L113:
	lwz 0,g_edicts@l(22)
	add 31,0,30
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L118
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpwi 0,0,1
	bc 4,2,.L118
	la 7,.LC58@l(23)
	bc 12,18,.L117
	la 7,.LC59@l(24)
.L117:
	mr 3,31
	li 4,2
	la 5,.LC57@l(25)
	mr 6,29
	mr 8,20
	crxor 6,6,6
	bl safe_cprintf
	mr 3,31
	la 4,.LC60@l(26)
	bl stuffcmd
.L118:
	addi 28,28,1
	lwz 11,maxclients@l(21)
	xoris 0,28,0x8000
	addi 30,30,996
	stw 0,28(1)
	stw 27,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L113
	b .L99
.L110:
	cmpw 0,6,8
	bc 4,1,.L99
	lis 9,maxclients@ha
	lis 4,.LC61@ha
	lwz 10,maxclients@l(9)
	la 4,.LC61@l(4)
	lis 11,team1_name@ha
	lfs 13,0(4)
	subf 29,8,6
	la 20,team1_name@l(11)
	lfs 0,20(10)
	li 28,1
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L99
	lis 9,.LC62@ha
	cmpwi 4,29,1
	la 9,.LC62@l(9)
	lis 22,g_edicts@ha
	lfd 31,0(9)
	lis 23,.LC58@ha
	lis 24,.LC59@ha
	lis 25,.LC57@ha
	lis 26,.LC60@ha
	lis 27,0x4330
	li 30,996
.L125:
	lwz 0,g_edicts@l(22)
	add 31,0,30
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L130
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpwi 0,0,2
	bc 4,2,.L130
	la 7,.LC58@l(23)
	bc 12,18,.L129
	la 7,.LC59@l(24)
.L129:
	mr 3,31
	li 4,2
	la 5,.LC57@l(25)
	mr 6,29
	mr 8,20
	crxor 6,6,6
	bl safe_cprintf
	mr 3,31
	la 4,.LC60@l(26)
	bl stuffcmd
.L130:
	addi 28,28,1
	lwz 11,maxclients@l(21)
	xoris 0,28,0x8000
	addi 30,30,996
	stw 0,28(1)
	stw 27,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L125
.L99:
	lwz 0,100(1)
	lwz 12,36(1)
	mtlr 0
	lmw 20,40(1)
	lfd 31,88(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe2:
	.size	 CheckForUnevenTeams,.Lfe2-CheckForUnevenTeams
	.section	".rodata"
	.align 2
.LC63:
	.string	"joined"
	.align 2
.LC64:
	.string	"changed to"
	.align 2
.LC65:
	.string	"skin"
	.align 2
.LC66:
	.string	"%s %s %s.\n"
	.section	".text"
	.align 2
	.globl JoinTeam
	.type	 JoinTeam,@function
JoinTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr. 27,5
	mr 31,3
	mr 30,4
	bc 4,2,.L134
	bl PMenu_Close
.L134:
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpw 0,0,30
	bc 12,2,.L133
	cmpwi 0,0,0
	bc 4,2,.L136
	lis 9,.LC63@ha
	la 26,.LC63@l(9)
	b .L137
.L136:
	lis 9,.LC64@ha
	la 26,.LC64@l(9)
.L137:
	lwz 9,84(31)
	lis 4,.LC65@ha
	la 4,.LC65@l(4)
	stw 30,3488(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	lis 9,g_edicts@ha
	lwz 4,84(31)
	lis 0,0xe64
	lwz 11,g_edicts@l(9)
	ori 0,0,49481
	mr 5,3
	lwz 9,3488(4)
	subf 11,11,31
	mullw 11,11,0
	cmpwi 0,9,1
	srawi 11,11,2
	addi 28,11,-1
	bc 12,2,.L138
	cmpwi 0,9,2
	bc 12,2,.L139
	b .L140
.L138:
	lis 29,gi@ha
	lis 3,.LC48@ha
	lis 5,team1_skin@ha
	la 29,gi@l(29)
	addi 28,11,1311
	addi 4,4,700
	la 3,.LC48@l(3)
	la 5,team1_skin@l(5)
	b .L150
.L139:
	lis 29,gi@ha
	lis 3,.LC48@ha
	lis 5,team2_skin@ha
	la 29,gi@l(29)
	addi 28,11,1311
	addi 4,4,700
	la 3,.LC48@l(3)
	la 5,team2_skin@l(5)
.L150:
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	b .L142
.L140:
	lwz 4,84(31)
	lis 29,gi@ha
	lis 3,.LC48@ha
	la 29,gi@l(29)
	addi 28,28,1312
	addi 4,4,700
	la 3,.LC48@l(3)
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L142:
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L143
	li 0,0
	lis 6,0x1
	lis 7,vec3_origin@ha
	stw 0,480(31)
	mr 3,31
	la 7,vec3_origin@l(7)
	mr 4,31
	mr 5,31
	ori 6,6,34464
	bl player_die
	li 0,2
	stw 0,492(31)
.L143:
	lwz 9,84(31)
	cmpwi 0,30,1
	addi 5,9,700
	bc 4,2,.L144
	lis 9,team1_name@ha
	la 7,team1_name@l(9)
	b .L145
.L144:
	cmpwi 0,30,2
	bc 4,2,.L147
	lis 9,team2_name@ha
	la 7,team2_name@l(9)
	b .L145
.L147:
	lis 9,.LC47@ha
	la 7,.LC47@l(9)
.L145:
	lis 4,.LC66@ha
	mr 6,26
	la 4,.LC66@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	lis 9,level@ha
	lwz 11,84(31)
	lwz 0,level@l(9)
	stw 0,3492(11)
	bl CheckForUnevenTeams
	cmpwi 0,27,0
	bc 4,2,.L133
	mr 3,31
	bl OpenWeaponMenu
.L133:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 JoinTeam,.Lfe3-JoinTeam
	.section	".rodata"
	.align 2
.LC67:
	.string	"its"
	.align 2
.LC68:
	.string	"her"
	.align 2
.LC69:
	.string	"his"
	.align 2
.LC70:
	.string	"%s left %s team.\n"
	.lcomm	levelname.99,32,4
	.lcomm	team1players.100,32,4
	.lcomm	team2players.101,32,4
	.align 2
.LC71:
	.string	"  (%d players)"
	.align 2
.LC72:
	.long 0x0
	.align 3
.LC73:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl UpdateJoinMenu
	.type	 UpdateJoinMenu,@function
UpdateJoinMenu:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,joinmenu@ha
	lis 9,team1_name@ha
	lis 8,g_edicts@ha
	la 11,joinmenu@l(11)
	lwz 5,g_edicts@l(8)
	la 9,team1_name@l(9)
	lis 10,JoinTeam1@ha
	lis 7,JoinTeam2@ha
	stw 9,48(11)
	la 10,JoinTeam1@l(10)
	la 7,JoinTeam2@l(7)
	lis 9,levelname.99@ha
	stw 10,60(11)
	stw 7,92(11)
	lis 6,team2_name@ha
	li 0,42
	stb 0,levelname.99@l(9)
	la 6,team2_name@l(6)
	la 3,levelname.99@l(9)
	stw 6,80(11)
	lwz 4,276(5)
	cmpwi 0,4,0
	bc 12,2,.L162
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L163
.L162:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L163:
	lis 9,maxclients@ha
	lis 11,levelname.99+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	stb 0,levelname.99+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L165
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC73@ha
	li 8,0
	la 9,.LC73@l(9)
	addi 10,10,1084
	lfd 13,0(9)
.L167:
	lwz 0,0(10)
	addi 10,10,996
	cmpwi 0,0,0
	bc 12,2,.L166
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,3488(9)
	cmpwi 0,11,1
	bc 4,2,.L169
	addi 30,30,1
	b .L166
.L169:
	xori 11,11,2
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L166:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,4564
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L167
.L165:
	lis 29,.LC71@ha
	lis 3,team1players.100@ha
	la 4,.LC71@l(29)
	mr 5,30
	la 3,team1players.100@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.101@ha
	la 4,.LC71@l(29)
	la 3,team2players.101@l(3)
	mr 5,31
	crxor 6,6,6
	bl sprintf
	lis 11,joinmenu@ha
	lis 9,levelname.99@ha
	la 11,joinmenu@l(11)
	la 9,levelname.99@l(9)
	lwz 0,48(11)
	stw 9,16(11)
	cmpwi 0,0,0
	bc 12,2,.L173
	lis 9,team1players.100@ha
	la 9,team1players.100@l(9)
	stw 9,64(11)
	b .L174
.L173:
	stw 0,64(11)
.L174:
	lis 9,joinmenu@ha
	la 11,joinmenu@l(9)
	lwz 0,80(11)
	cmpwi 0,0,0
	bc 12,2,.L175
	lis 9,team2players.101@ha
	la 9,team2players.101@l(9)
	stw 9,96(11)
	b .L176
.L175:
	stw 0,96(11)
.L176:
	cmpw 0,30,31
	bc 12,1,.L181
	cmpw 0,31,30
	bc 4,1,.L179
	li 3,1
	b .L185
.L179:
	lis 9,team1_score@ha
	lis 11,team2_score@ha
	lwz 0,team1_score@l(9)
	lwz 9,team2_score@l(11)
	cmpw 0,0,9
	li 3,1
	bc 4,1,.L185
.L181:
	li 3,2
.L185:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 UpdateJoinMenu,.Lfe4-UpdateJoinMenu
	.section	".rodata"
	.align 2
.LC74:
	.string	"weapon_Mk23"
	.align 2
.LC75:
	.string	"weapon_MP5"
	.align 2
.LC76:
	.string	"weapon_M4"
	.align 2
.LC77:
	.string	"weapon_M3"
	.align 2
.LC78:
	.string	"weapon_HC"
	.align 2
.LC79:
	.string	"weapon_Sniper"
	.align 2
.LC80:
	.string	"weapon_Dual"
	.align 2
.LC81:
	.string	"weapon_Knife"
	.align 2
.LC82:
	.string	"weapon_Grenade"
	.align 2
.LC83:
	.string	"ammo_sniper"
	.align 2
.LC84:
	.string	"ammo_clip"
	.align 2
.LC85:
	.string	"ammo_mag"
	.align 2
.LC86:
	.string	"ammo_m4"
	.align 2
.LC87:
	.string	"ammo_m3"
	.align 2
.LC88:
	.string	"item_quiet"
	.align 2
.LC89:
	.string	"item_slippers"
	.align 2
.LC90:
	.string	"item_band"
	.align 2
.LC91:
	.string	"item_lasersight"
	.align 2
.LC92:
	.string	"item_vest"
	.align 2
.LC93:
	.string	"thrown_knife"
	.align 2
.LC94:
	.string	"hgrenade"
	.align 2
.LC95:
	.long .LC74
	.long .LC75
	.long .LC76
	.long .LC77
	.long .LC78
	.long .LC79
	.long .LC80
	.long .LC81
	.long .LC82
	.long .LC83
	.long .LC84
	.long .LC85
	.long .LC86
	.long .LC87
	.long .LC88
	.long .LC89
	.long .LC90
	.long .LC91
	.long .LC92
	.long .LC93
	.long .LC94
	.align 2
.LC96:
	.long 0x3f800000
	.align 2
.LC97:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl CleanLevel
	.type	 CleanLevel,@function
CleanLevel:
	stwu 1,-144(1)
	mflr 0
	stmw 24,112(1)
	stw 0,148(1)
	addi 3,1,8
	lis 4,.LC95@ha
	mr 24,3
	la 4,.LC95@l(4)
	li 5,84
	crxor 6,6,6
	bl memcpy
	lis 9,maxclients@ha
	lis 11,.LC96@ha
	lwz 10,maxclients@l(9)
	la 11,.LC96@l(11)
	lis 8,g_edicts@ha
	lfs 11,0(11)
	lis 9,.LC97@ha
	lfs 0,20(10)
	la 9,.LC97@l(9)
	lis 11,globals@ha
	lfs 12,0(9)
	la 11,globals@l(11)
	lwz 0,g_edicts@l(8)
	fadds 0,0,11
	lwz 10,72(11)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,104(1)
	lwz 9,108(1)
	mr 8,9
	mulli 9,9,996
	cmpw 0,8,10
	add 29,0,9
	bc 4,0,.L198
	mr 25,11
.L200:
	lwz 28,280(29)
	addi 27,8,1
	addi 26,29,996
	cmpwi 0,28,0
	bc 12,2,.L199
	li 30,0
	mr 31,24
.L205:
	lwz 4,0(31)
	mr 3,28
	addi 31,31,4
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L208
	mr 0,30
	b .L207
.L208:
	addi 30,30,1
	cmpwi 0,30,21
	bc 12,0,.L205
	li 0,-1
.L207:
	cmpwi 0,0,-1
	bc 4,1,.L199
	mr 3,29
	bl G_FreeEdict
.L199:
	lwz 0,72(25)
	mr 8,27
	mr 29,26
	cmpw 0,8,0
	bc 12,0,.L200
.L198:
	bl CleanBodies
	bl CGF_SFX_RebuildAllBrokenGlass
	lwz 0,148(1)
	mtlr 0
	lmw 24,112(1)
	la 1,144(1)
	blr
.Lfe5:
	.size	 CleanLevel,.Lfe5-CleanLevel
	.section	".rodata"
	.align 2
.LC98:
	.string	"%s"
	.section	".text"
	.align 2
	.globl CheckForWinner
	.type	 CheckForWinner,@function
CheckForWinner:
	lis 9,game@ha
	li 8,0
	la 11,game@l(9)
	li 7,0
	lwz 0,1544(11)
	li 4,0
	cmpw 0,8,0
	bc 4,0,.L232
	lis 9,g_edicts@ha
	mr 3,11
	lwz 11,g_edicts@l(9)
	mr 12,0
	li 5,0
	li 6,0
	addi 11,11,996
.L234:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L233
	lwz 9,1028(3)
	mr 10,5
	add 9,6,9
	lwz 0,3488(9)
	cmpwi 0,0,1
	bc 4,2,.L236
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L236
	addi 7,7,1
	b .L233
.L236:
	lwz 9,1028(3)
	add 9,10,9
	lwz 0,3488(9)
	cmpwi 0,0,2
	bc 4,2,.L233
	lwz 0,248(11)
	addi 9,8,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L233:
	addi 4,4,1
	addi 5,5,4564
	cmpw 0,4,12
	addi 6,6,4564
	addi 11,11,996
	bc 12,0,.L234
.L232:
	srawi 9,7,31
	srawi 0,8,31
	subf 9,7,9
	subf 0,8,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 12,2,.L240
	li 3,0
	blr
.L240:
	subfic 11,7,0
	adde 0,11,7
	subfic 11,8,0
	adde 3,11,8
	and. 11,0,3
	bc 4,2,.L242
	and 3,9,3
	neg 3,3
	srawi 3,3,31
	nor 0,3,3
	rlwinm 3,3,0,31,31
	rlwinm 0,0,0,30,30
	or 3,3,0
	blr
.L242:
	li 3,3
	blr
.Lfe6:
	.size	 CheckForWinner,.Lfe6-CheckForWinner
	.align 2
	.globl CheckForForcedWinner
	.type	 CheckForForcedWinner,@function
CheckForForcedWinner:
	stwu 1,-16(1)
	stmw 30,8(1)
	lis 9,game@ha
	li 8,0
	la 11,game@l(9)
	li 3,0
	lwz 0,1544(11)
	li 4,0
	li 12,0
	li 5,0
	cmpw 0,8,0
	bc 4,0,.L249
	lis 9,g_edicts@ha
	mr 31,11
	lwz 11,g_edicts@l(9)
	mr 30,0
	li 6,0
	li 7,0
	addi 11,11,996
.L251:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L250
	lwz 9,1028(31)
	mr 10,6
	add 9,7,9
	lwz 0,3488(9)
	cmpwi 0,0,1
	bc 4,2,.L253
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L253
	lwz 0,480(11)
	addi 3,3,1
	add 8,8,0
	b .L250
.L253:
	lwz 9,1028(31)
	add 9,10,9
	lwz 0,3488(9)
	cmpwi 0,0,2
	bc 4,2,.L250
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L250
	lwz 0,480(11)
	addi 4,4,1
	add 12,12,0
.L250:
	addi 5,5,1
	addi 6,6,4564
	cmpw 0,5,30
	addi 7,7,4564
	addi 11,11,996
	bc 12,0,.L251
.L249:
	cmpw 0,3,4
	bc 12,1,.L261
	cmpw 0,4,3
	bc 4,1,.L259
	li 3,2
	b .L265
.L259:
	cmpw 0,8,12
	bc 12,1,.L261
	cmpw 7,12,8
	cror 31,30,28
	mfcr 3
	rlwinm 3,3,0,1
	neg 3,3
	rlwinm 3,3,0,30,31
	ori 3,3,2
	b .L265
.L261:
	li 3,1
.L265:
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 CheckForForcedWinner,.Lfe7-CheckForForcedWinner
	.section	".rodata"
	.align 2
.LC99:
	.string	"bot"
	.section	".text"
	.align 2
	.globl SpawnPlayers
	.type	 SpawnPlayers,@function
SpawnPlayers:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	bl GetSpawnPoints
	lis 28,transparent_list@ha
	lis 27,game@ha
	bl SetupTeamSpawnPoints
	lis 9,transparent_list@ha
	lwz 3,transparent_list@l(9)
	cmpwi 0,3,0
	bc 12,2,.L272
	lis 9,gi@ha
	mr 29,3
	la 31,gi@l(9)
.L270:
	lwz 9,136(31)
	mr 3,29
	lwz 29,4(29)
	mtlr 9
	blrl
	mr. 29,29
	bc 4,2,.L270
	lis 9,transparent_list@ha
	stw 29,transparent_list@l(9)
.L272:
	lis 9,game+1544@ha
	li 30,0
	lwz 0,game+1544@l(9)
	cmpw 0,30,0
	bc 4,0,.L274
	lis 25,g_edicts@ha
	lis 26,.LC99@ha
.L276:
	mulli 9,30,996
	lwz 11,g_edicts@l(25)
	addi 10,30,1
	addi 9,9,996
	add 29,11,9
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L275
	lwz 9,84(29)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L275
	lwz 3,280(29)
	la 4,.LC99@l(26)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L278
	lwz 9,84(29)
	mr 3,29
	li 4,1
	lwz 5,3488(9)
	bl ACESP_PutClientInServer
	b .L279
.L278:
	mr 3,29
	bl PutClientInServer
.L279:
	lis 9,gi@ha
	li 3,8
	la 31,gi@l(9)
	li 4,765
	lwz 9,132(31)
	mtlr 9
	blrl
	mr. 3,3
	bc 4,2,.L280
	lwz 0,4(31)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	bl exit
.L280:
	lwz 9,transparent_list@l(28)
	li 0,0
	stw 29,0(3)
	cmpwi 0,9,0
	stw 0,4(3)
	bc 4,2,.L281
	stw 3,transparent_list@l(28)
	addi 10,30,1
	b .L275
.L281:
	lwz 0,4(9)
	addi 10,30,1
	cmpwi 0,0,0
	bc 12,2,.L286
.L285:
	lwz 9,4(9)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 4,2,.L285
.L286:
	stw 3,4(9)
.L275:
	la 9,game@l(27)
	mr 30,10
	lwz 0,1544(9)
	cmpw 0,30,0
	bc 12,0,.L276
.L274:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 SpawnPlayers,.Lfe8-SpawnPlayers
	.section	".rodata"
	.align 2
.LC100:
	.string	"LIGHTS...\n"
	.align 2
.LC101:
	.string	"atl/lights.wav"
	.align 2
.LC102:
	.long 0xc2820000
	.align 2
.LC103:
	.long 0x42820000
	.align 2
.LC104:
	.long 0xc2040000
	.align 2
.LC105:
	.long 0x42040000
	.section	".text"
	.align 2
	.globl FindOverlap
	.type	 FindOverlap,@function
FindOverlap:
	stwu 1,-32(1)
	mr. 4,4
	mr 10,3
	bc 12,2,.L299
	lis 11,g_edicts@ha
	lis 9,0xe64
	lwz 0,g_edicts@l(11)
	ori 9,9,49481
	subf 0,0,4
	mullw 0,0,9
	srawi 4,0,2
	b .L300
.L299:
	li 4,0
.L300:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpw 0,4,0
	bc 4,0,.L302
	lis 9,g_edicts@ha
	mr 8,0
	mulli 11,4,996
	lwz 0,g_edicts@l(9)
	lis 9,.LC102@ha
	addi 11,11,996
	la 9,.LC102@l(9)
	add 3,11,0
	lfs 8,0(9)
	lis 9,.LC103@ha
	la 9,.LC103@l(9)
	lfs 9,0(9)
.L304:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L303
	lwz 9,84(3)
	xor 11,3,10
	subfic 0,11,0
	adde 11,0,11
	lwz 0,3488(9)
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 4,2,.L303
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 12,2,.L303
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 12,2,.L303
	lfs 0,4(10)
	lis 9,.LC104@ha
	lfs 13,4(3)
	la 9,.LC104@l(9)
	lfs 12,8(10)
	lfs 11,12(10)
	fsubs 13,0,13
	lfs 10,0(9)
	stfs 13,8(1)
	fcmpu 0,13,10
	lfs 0,8(3)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(3)
	fsubs 11,11,0
	stfs 11,16(1)
	cror 3,2,1
	bc 4,3,.L303
	lis 9,.LC105@ha
	la 9,.LC105@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L303
	fcmpu 0,12,10
	cror 3,2,1
	bc 4,3,.L303
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L303
	fcmpu 0,11,8
	cror 3,2,1
	bc 4,3,.L303
	fcmpu 0,11,9
	cror 3,2,0
	bc 12,3,.L309
.L303:
	addi 4,4,1
	addi 3,3,996
	cmpw 0,4,8
	bc 12,0,.L304
.L302:
	li 3,0
.L309:
	la 1,32(1)
	blr
.Lfe9:
	.size	 FindOverlap,.Lfe9-FindOverlap
	.section	".rodata"
	.align 2
.LC106:
	.string	"CAMERA...\n"
	.align 2
.LC107:
	.string	"atl/camera.wav"
	.align 2
.LC108:
	.string	"ACTION!\n"
	.align 2
.LC109:
	.string	"atl/action.wav"
	.align 2
.LC110:
	.long 0x3f800000
	.align 2
.LC111:
	.long 0x0
	.section	".text"
	.align 2
	.globl ContinueLCA
	.type	 ContinueLCA,@function
ContinueLCA:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,21
	bc 4,2,.L312
	lis 9,.LC106@ha
	li 3,0
	la 31,.LC106@l(9)
	li 4,2
	mr 5,31
	li 29,0
	crxor 6,6,6
	bl safe_cprintf
	lis 26,g_edicts@ha
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,29,0
	bc 4,0,.L319
	mr 27,9
	lis 30,.LC98@ha
	li 28,996
.L315:
	lwz 0,g_edicts@l(26)
	add 3,0,28
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L317
	la 4,.LC98@l(30)
	mr 5,31
	crxor 6,6,6
	bl safe_centerprintf
.L317:
	lwz 0,1544(27)
	addi 29,29,1
	addi 28,28,996
	cmpw 0,29,0
	bc 12,0,.L315
.L319:
	lis 29,gi@ha
	lis 3,.LC107@ha
	la 29,gi@l(29)
	la 3,.LC107@l(3)
	lwz 11,36(29)
	lis 9,g_edicts@ha
	lwz 28,g_edicts@l(9)
	mtlr 11
	blrl
	lis 9,.LC110@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC110@l(9)
	li 4,10
	lfs 1,0(9)
	mr 3,28
	mtlr 0
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 2,0(9)
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 3,0(9)
	blrl
	b .L320
.L312:
	cmpwi 0,0,1
	bc 4,2,.L320
	lis 9,.LC108@ha
	li 3,0
	la 31,.LC108@l(9)
	li 4,2
	mr 5,31
	li 29,0
	crxor 6,6,6
	bl safe_cprintf
	lis 26,g_edicts@ha
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,29,0
	bc 4,0,.L328
	mr 27,9
	lis 30,.LC98@ha
	li 28,996
.L324:
	lwz 0,g_edicts@l(26)
	add 3,0,28
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L326
	la 4,.LC98@l(30)
	mr 5,31
	crxor 6,6,6
	bl safe_centerprintf
.L326:
	lwz 0,1544(27)
	addi 29,29,1
	addi 28,28,996
	cmpw 0,29,0
	bc 12,0,.L324
.L328:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 11,36(29)
	lis 9,g_edicts@ha
	lwz 28,g_edicts@l(9)
	mtlr 11
	blrl
	lis 9,.LC110@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC110@l(9)
	li 4,10
	lfs 1,0(9)
	mtlr 0
	mr 3,28
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 2,0(9)
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 3,0(9)
	blrl
	lis 10,team_round_going@ha
	li 9,1
	lis 11,current_round_length@ha
	li 0,0
	stw 9,team_round_going@l(10)
	stw 0,current_round_length@l(11)
.L320:
	lis 11,lights_camera_action@ha
	lwz 9,lights_camera_action@l(11)
	addi 9,9,-1
	stw 9,lights_camera_action@l(11)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 ContinueLCA,.Lfe10-ContinueLCA
	.section	".rodata"
	.align 2
.LC112:
	.string	"The round is over:\n"
	.align 2
.LC113:
	.string	"It was a tie, no points awarded!\n"
	.align 2
.LC114:
	.string	"%s won!\n"
	.align 2
.LC115:
	.string	"Timelimit hit.\n"
	.align 2
.LC116:
	.string	"Roundlimit hit.\n"
	.align 2
.LC117:
	.long 0x0
	.align 2
.LC118:
	.long 0x42700000
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl WonGame
	.type	 WonGame,@function
WonGame:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 4,.LC112@ha
	la 4,.LC112@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	cmpwi 0,31,3
	bc 4,2,.L339
	lis 4,.LC113@ha
	li 3,2
	la 4,.LC113@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L340
.L339:
	cmpwi 0,31,1
	bc 4,2,.L341
	lis 5,team1_name@ha
	lis 4,.LC114@ha
	la 4,.LC114@l(4)
	la 5,team1_name@l(5)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	lis 11,team1_score@ha
	lwz 9,team1_score@l(11)
	addi 9,9,1
	stw 9,team1_score@l(11)
	b .L340
.L341:
	lis 5,team2_name@ha
	lis 4,.LC114@ha
	la 4,.LC114@l(4)
	la 5,team2_name@l(5)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	lis 11,team2_score@ha
	lwz 9,team2_score@l(11)
	addi 9,9,1
	stw 9,team2_score@l(11)
.L340:
	lis 11,.LC117@ha
	lis 9,timelimit@ha
	la 11,.LC117@l(11)
	lfs 0,0(11)
	lwz 11,timelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L353
	lis 9,.LC118@ha
	la 9,.LC118@l(9)
	lfs 0,0(9)
	lis 9,level+4@ha
	fmuls 0,13,0
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L353
	lis 4,.LC115@ha
	li 3,2
	la 4,.LC115@l(4)
	b .L359
.L353:
	lis 11,.LC117@ha
	lis 9,roundlimit@ha
	la 11,.LC117@l(11)
	lfs 0,0(11)
	lwz 11,roundlimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L355
	lis 11,team1_score@ha
	lwz 0,team1_score@l(11)
	lis 10,0x4330
	lis 11,.LC119@ha
	xoris 0,0,0x8000
	la 11,.LC119@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L357
	lis 11,team2_score@ha
	lwz 0,team2_score@l(11)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L355
.L357:
	lis 4,.LC116@ha
	li 3,2
	la 4,.LC116@l(4)
.L359:
	crxor 6,6,6
	bl safe_bprintf
	bl EndDMLevel
	li 0,0
	lis 11,team_round_going@ha
	lis 10,team_round_countdown@ha
	lis 9,team_game_going@ha
	stw 0,team_round_going@l(11)
	stw 0,team_game_going@l(9)
	li 3,1
	stw 0,team_round_countdown@l(10)
	b .L358
.L355:
	li 3,0
.L358:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 WonGame,.Lfe11-WonGame
	.section	".rodata"
	.align 2
.LC120:
	.string	"Not enough players to play!\n"
	.align 2
.LC121:
	.string	"The round will begin in 20 seconds!\n"
	.align 2
.LC122:
	.string	"Round timelimit hit.\n"
	.align 2
.LC123:
	.long 0x3f800000
	.align 2
.LC124:
	.long 0x0
	.align 2
.LC125:
	.long 0x42700000
	.align 3
.LC126:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC127:
	.long 0x44160000
	.section	".text"
	.align 2
	.globl CheckTeamRules
	.type	 CheckTeamRules,@function
CheckTeamRules:
	stwu 1,-64(1)
	mflr 0
	mfcr 12
	stmw 24,32(1)
	stw 0,68(1)
	stw 12,28(1)
	lis 9,lights_camera_action@ha
	li 7,0
	lwz 10,lights_camera_action@l(9)
	cmpwi 0,10,0
	bc 12,2,.L361
	bl ContinueLCA
	b .L360
.L361:
	lis 9,team_round_going@ha
	lis 24,team_round_going@ha
	lwz 0,team_round_going@l(9)
	cmpwi 0,0,0
	bc 12,2,.L362
	lis 11,current_round_length@ha
	lwz 9,current_round_length@l(11)
	addi 9,9,1
	stw 9,current_round_length@l(11)
.L362:
	lis 9,holding_on_tie_check@ha
	lis 11,holding_on_tie_check@ha
	lwz 9,holding_on_tie_check@l(9)
	cmpwi 0,9,0
	bc 12,2,.L363
	addi 0,9,-1
	cmpwi 0,0,0
	stw 0,holding_on_tie_check@l(11)
	bc 12,1,.L360
	stw 7,holding_on_tie_check@l(11)
	li 7,1
.L363:
	lis 9,team_round_countdown@ha
	lis 11,team_round_countdown@ha
	lwz 9,team_round_countdown@l(9)
	cmpwi 0,9,1
	bc 4,2,.L365
	lis 9,game@ha
	stw 10,team_round_countdown@l(11)
	li 8,0
	la 11,game@l(9)
	cmpwi 4,7,0
	lwz 0,1544(11)
	li 6,0
	cmpw 0,8,0
	bc 4,0,.L375
	lis 9,g_edicts@ha
	mr 5,11
	mtctr 0
	lwz 11,g_edicts@l(9)
	li 7,0
	addi 10,11,1084
.L369:
	lwz 0,0(10)
	addi 10,10,996
	cmpwi 0,0,0
	bc 12,2,.L371
	lwz 9,1028(5)
	add 9,7,9
	lwz 11,3488(9)
	cmpwi 0,11,1
	bc 4,2,.L372
	addi 6,6,1
	b .L371
.L372:
	xori 11,11,2
	addi 9,8,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L371:
	addi 7,7,4564
	bdnz .L369
.L375:
	srawi 9,6,31
	srawi 0,8,31
	subf 9,6,9
	subf 0,8,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 12,2,.L366
	li 0,1
	lis 9,team_game_going@ha
	stw 0,team_game_going@l(9)
	li 31,0
	lis 26,g_edicts@ha
	bl CleanLevel
	lis 9,.LC100@ha
	li 3,0
	la 30,.LC100@l(9)
	li 4,2
	mr 5,30
	crxor 6,6,6
	bl safe_cprintf
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 4,0,.L383
	mr 27,9
	lis 28,.LC98@ha
	li 29,996
.L379:
	lwz 0,g_edicts@l(26)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L381
	la 4,.LC98@l(28)
	mr 5,30
	crxor 6,6,6
	bl safe_centerprintf
.L381:
	lwz 0,1544(27)
	addi 31,31,1
	addi 29,29,996
	cmpw 0,31,0
	bc 12,0,.L379
.L383:
	lis 29,gi@ha
	lis 3,.LC101@ha
	la 29,gi@l(29)
	la 3,.LC101@l(3)
	lwz 11,36(29)
	lis 9,g_edicts@ha
	lwz 28,g_edicts@l(9)
	mtlr 11
	blrl
	lis 4,.LC123@ha
	lwz 0,16(29)
	lis 9,.LC124@ha
	la 4,.LC123@l(4)
	lis 11,.LC124@ha
	la 9,.LC124@l(9)
	lfs 1,0(4)
	la 11,.LC124@l(11)
	mtlr 0
	mr 5,3
	lfs 2,0(9)
	li 4,10
	lfs 3,0(11)
	mr 3,28
	blrl
	lis 9,lights_camera_action@ha
	li 0,41
	stw 0,lights_camera_action@l(9)
	bl SpawnPlayers
	b .L401
.L366:
	lis 9,.LC120@ha
	li 3,0
	la 31,.LC120@l(9)
	li 4,2
	mr 5,31
	li 29,0
	crxor 6,6,6
	bl safe_cprintf
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,29,0
	bc 4,0,.L392
	mr 26,9
	lis 27,g_edicts@ha
	lis 30,.LC98@ha
	li 28,996
.L388:
	lwz 0,g_edicts@l(27)
	add 3,0,28
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L390
	la 4,.LC98@l(30)
	mr 5,31
	crxor 6,6,6
	bl safe_centerprintf
.L390:
	lwz 0,1544(26)
	addi 29,29,1
	addi 28,28,996
	cmpw 0,29,0
	bc 12,0,.L388
.L392:
	lis 9,game@ha
	li 31,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 4,0,.L401
	mr 25,9
	lis 26,g_edicts@ha
	li 27,0
	li 30,996
.L395:
	lwz 0,g_edicts@l(26)
	add 28,0,30
	lwz 9,88(28)
	cmpwi 0,9,0
	bc 12,2,.L398
	lwz 0,248(28)
	cmpwi 0,0,0
	bc 12,2,.L398
	lwz 9,84(28)
	mr 3,28
	lwz 29,3488(9)
	stw 27,3488(9)
	bl PutClientInServer
	lwz 9,84(28)
	stw 29,3488(9)
.L398:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,996
	cmpw 0,31,0
	bc 12,0,.L395
	b .L401
.L365:
	cmpwi 0,9,0
	cmpwi 4,7,0
	bc 12,2,.L401
	addi 0,9,-1
	stw 0,team_round_countdown@l(11)
.L401:
	lis 8,rulecheckfrequency@ha
	lis 9,0x8888
	lwz 11,rulecheckfrequency@l(8)
	ori 9,9,34953
	mfcr 7
	rlwinm 7,7,19,1
	addi 11,11,1
	mulhw 9,11,9
	srawi 10,11,31
	stw 11,rulecheckfrequency@l(8)
	add 9,9,11
	srawi 9,9,3
	subf 9,10,9
	slwi 0,9,4
	subf 0,9,0
	subf 11,0,11
	addic 0,11,-1
	subfe 9,0,11
	and. 4,9,7
	bc 4,2,.L360
	lis 9,team_round_going@ha
	lwz 31,team_round_going@l(9)
	cmpwi 0,31,0
	bc 4,2,.L404
	lis 11,.LC124@ha
	lis 9,timelimit@ha
	la 11,.LC124@l(11)
	lfs 0,0(11)
	lwz 11,timelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L405
	lis 4,.LC125@ha
	lis 9,level+4@ha
	la 4,.LC125@l(4)
	lfs 0,0(4)
	fmuls 0,13,0
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L405
	lis 4,.LC115@ha
	li 3,2
	la 4,.LC115@l(4)
	crxor 6,6,6
	bl safe_bprintf
	bl EndDMLevel
	lis 11,team_round_countdown@ha
	lis 9,team_game_going@ha
	stw 31,team_round_going@l(24)
	stw 31,team_game_going@l(9)
	stw 31,team_round_countdown@l(11)
	b .L360
.L405:
	lis 9,team_round_countdown@ha
	lwz 0,team_round_countdown@l(9)
	cmpwi 0,0,0
	bc 4,2,.L360
	lis 9,game@ha
	li 8,0
	la 11,game@l(9)
	li 6,0
	lwz 0,1544(11)
	cmpw 0,8,0
	bc 4,0,.L417
	lis 9,g_edicts@ha
	mr 5,11
	mtctr 0
	lwz 11,g_edicts@l(9)
	li 7,0
	addi 10,11,1084
.L411:
	lwz 0,0(10)
	addi 10,10,996
	cmpwi 0,0,0
	bc 12,2,.L413
	lwz 9,1028(5)
	add 9,7,9
	lwz 11,3488(9)
	cmpwi 0,11,1
	bc 4,2,.L414
	addi 6,6,1
	b .L413
.L414:
	xori 11,11,2
	addi 9,8,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L413:
	addi 7,7,4564
	bdnz .L411
.L417:
	srawi 9,6,31
	srawi 0,8,31
	subf 9,6,9
	subf 0,8,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 12,2,.L360
	lis 9,.LC121@ha
	li 3,0
	la 31,.LC121@l(9)
	li 4,2
	mr 5,31
	li 29,0
	crxor 6,6,6
	bl safe_cprintf
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,29,0
	bc 4,0,.L425
	mr 26,9
	lis 27,g_edicts@ha
	lis 30,.LC98@ha
	li 28,996
.L421:
	lwz 0,g_edicts@l(27)
	add 3,0,28
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L423
	la 4,.LC98@l(30)
	mr 5,31
	crxor 6,6,6
	bl safe_centerprintf
.L423:
	lwz 0,1544(26)
	addi 29,29,1
	addi 28,28,996
	cmpw 0,29,0
	bc 12,0,.L421
.L425:
	lis 9,team_round_countdown@ha
	li 0,201
	stw 0,team_round_countdown@l(9)
	b .L360
.L404:
	bl CheckForWinner
	mr. 3,3
	bc 12,2,.L427
	bc 4,18,.L432
	lis 9,holding_on_tie_check@ha
	li 0,50
	stw 0,holding_on_tie_check@l(9)
	b .L360
.L427:
	lis 9,roundtimelimit@ha
	lis 4,.LC124@ha
	lwz 11,roundtimelimit@l(9)
	la 4,.LC124@l(4)
	lfs 0,0(4)
	lfs 11,20(11)
	fcmpu 0,11,0
	bc 12,2,.L360
	lis 9,current_round_length@ha
	lwz 0,current_round_length@l(9)
	lis 10,0x4330
	lis 4,.LC127@ha
	lis 9,.LC126@ha
	la 4,.LC127@l(4)
	xoris 0,0,0x8000
	la 9,.LC126@l(9)
	lfs 13,0(4)
	stw 0,20(1)
	stw 10,16(1)
	lfd 12,0(9)
	fmuls 13,11,13
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L360
	lis 4,.LC122@ha
	li 3,2
	la 4,.LC122@l(4)
	crxor 6,6,6
	bl safe_bprintf
	bl CheckForForcedWinner
.L432:
	bl WonGame
	mr. 3,3
	bc 4,2,.L360
	lis 10,lights_camera_action@ha
	lis 11,holding_on_tie_check@ha
	stw 3,team_round_going@l(24)
	lis 9,team_round_countdown@ha
	li 0,71
	stw 3,holding_on_tie_check@l(11)
	stw 0,team_round_countdown@l(9)
	stw 3,lights_camera_action@l(10)
.L360:
	lwz 0,68(1)
	lwz 12,28(1)
	mtlr 0
	lmw 24,32(1)
	mtcrf 8,12
	la 1,64(1)
	blr
.Lfe12:
	.size	 CheckTeamRules,.Lfe12-CheckTeamRules
	.section	".rodata"
	.align 2
.LC128:
	.long 0x0
	.section	".text"
	.align 2
	.globl A_Scoreboard
	.type	 A_Scoreboard,@function
A_Scoreboard:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 10,84(31)
	lwz 0,3912(10)
	cmpwi 0,0,0
	bc 12,2,.L434
	lwz 0,3920(10)
	cmpwi 0,0,1
	bc 4,2,.L434
	lis 9,.LC128@ha
	lis 11,level@ha
	la 9,.LC128@l(9)
	lfs 0,0(9)
	la 9,level@l(11)
	lfs 13,200(9)
	fcmpu 0,13,0
	bc 12,2,.L435
	lwz 0,level@l(11)
	andi. 9,0,8
	bc 12,2,.L435
	lis 9,team1_score@ha
	lis 11,team2_score@ha
	lwz 9,team1_score@l(9)
	lwz 0,team2_score@l(11)
	cmpw 0,9,0
	bc 12,1,.L445
	cmpw 0,0,9
	bc 12,1,.L446
	lis 9,team1_total@ha
	lis 11,team2_total@ha
	lwz 9,team1_total@l(9)
	lwz 0,team2_total@l(11)
	cmpw 0,9,0
	bc 4,1,.L440
.L445:
	li 0,0
	sth 0,168(10)
	b .L444
.L440:
	cmpw 0,0,9
	bc 4,1,.L442
.L446:
	li 0,0
	sth 0,170(10)
	b .L444
.L442:
	li 0,0
	sth 0,168(10)
	lwz 9,84(31)
	sth 0,170(9)
	b .L444
.L435:
	lis 29,gi@ha
	lis 3,team1_skin_index@ha
	la 29,gi@l(29)
	la 3,team1_skin_index@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,team2_skin_index@ha
	sth 3,168(9)
	lwz 0,40(29)
	la 3,team2_skin_index@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,170(9)
.L444:
	lis 11,team1_score+2@ha
	lwz 8,84(31)
	lis 9,team2_score+2@ha
	lhz 0,team1_score+2@l(11)
	lhz 10,team2_score+2@l(9)
	sth 0,172(8)
	lwz 9,84(31)
	sth 10,174(9)
.L434:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 A_Scoreboard,.Lfe13-A_Scoreboard
	.section	".rodata"
	.align 2
.LC129:
	.string	"tag3"
	.align 2
.LC130:
	.ascii	"if 24 xv 0 yv 8"
	.string	" pic 24 endif if 22 xv 32 yv 8 pic 22 endif xv 32 yv 28 string \"%4d/%-3d\" xv 90 yv 12 num 2 26 xv %d yv 0 string \"%s\" if 25 xv 160 yv 8 pic 25 endif if 22 xv 192 yv 8 pic 22 endif xv 192 yv 28 string \"%4d/%-3d\" xv 248 yv 12 num 2 27 xv %d yv 0 string \"%s\" "
	.align 2
.LC131:
	.string	"xv 0 yv %d string%s \"%s\" "
	.align 2
.LC132:
	.string	"xv 160 yv %d string%s \"%s\" "
	.align 2
.LC133:
	.string	"xv 0 yv %d string \"..and %d more\" "
	.align 2
.LC134:
	.string	"xv 160 yv %d string \"..and %d more\" "
	.align 2
.LC135:
	.string	"xv 0 yv %d string%s \"..and %d/%d more\" "
	.align 2
.LC136:
	.string	"xv 160 yv %d string%s \"..and %d/%d more\" "
	.align 2
.LC137:
	.string	"xv 0 yv 32 string2 \"Player          Time Ping\" xv 0 yv 40 string2 \"--------------- ---- ----\" "
	.align 2
.LC138:
	.string	"xv 0 yv 32 string2 \"Frags Player          Time Ping Damage\" xv 0 yv 40 string2 \"----- --------------- ---- ---- ------\" "
	.align 2
.LC139:
	.string	"xv 0 yv %d string \"%-15s %4d %4d\" "
	.align 2
.LC140:
	.string	"%d"
	.align 2
.LC141:
	.string	"******"
	.align 2
.LC142:
	.string	"xv 0 yv %d string \"%5d %-15s %4d %4d %6s\" "
	.align 2
.LC143:
	.string	"Warning: scoreboard string neared or exceeded max length\nDump:\n%s\n---\n"
	.align 2
.LC144:
	.long 0x0
	.section	".text"
	.align 2
	.globl A_ScoreboardMessage
	.type	 A_ScoreboardMessage,@function
A_ScoreboardMessage:
	stwu 1,-7792(1)
	mflr 0
	stmw 16,7728(1)
	stw 0,7796(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3920(9)
	cmpwi 0,0,1
	bc 4,2,.L448
	lwz 0,248(31)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L450
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L450
	lis 9,team_round_going@ha
	lwz 0,team_round_going@l(9)
	cmpwi 0,0,0
	bc 4,2,.L449
.L450:
	li 30,1
.L449:
	lis 9,gi+40@ha
	lis 3,.LC129@ha
	lwz 0,gi+40@l(9)
	cmpwi 0,30,0
	la 3,.LC129@l(3)
	li 26,0
	mtlr 0
	mfcr 20
	blrl
	lwz 11,84(31)
	lis 9,game@ha
	li 0,0
	la 10,game@l(9)
	sth 3,164(11)
	lwz 9,1544(10)
	stw 0,7636(1)
	cmpw 0,26,9
	stw 0,7656(1)
	stw 0,7652(1)
	stw 0,7672(1)
	stw 0,7668(1)
	stw 0,7640(1)
	bc 4,0,.L452
	lis 9,g_edicts@ha
	lis 11,noscore@ha
	lwz 17,g_edicts@l(9)
	mr 21,10
	addi 22,1,7632
	lis 9,.LC144@ha
	lwz 18,noscore@l(11)
	addi 23,1,7664
	la 9,.LC144@l(9)
	addi 19,1,4560
	lfs 13,0(9)
.L454:
	mulli 9,26,996
	addi 24,26,1
	addi 9,9,996
	add 31,17,9
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L453
	lwz 9,1028(21)
	mulli 0,26,4564
	add 9,0,9
	lwz 11,3488(9)
	cmpwi 0,11,0
	bc 12,2,.L453
	lfs 0,20(18)
	lwz 25,3440(9)
	fcmpu 0,0,13
	bc 12,2,.L458
	slwi 0,11,2
	slwi 3,11,10
	mr 29,0
	lwzx 5,22,0
	addi 27,1,7632
	addi 6,1,4560
	addi 4,1,1488
	addi 30,1,7648
	b .L459
.L458:
	slwi 0,11,2
	li 5,0
	lwzx 9,22,0
	mr 29,0
	slwi 3,11,10
	addi 27,1,7632
	addi 6,1,4560
	cmpw 0,5,9
	addi 4,1,1488
	addi 30,1,7648
	bc 4,0,.L461
	lwzx 0,19,3
	cmpw 0,25,0
	bc 12,1,.L461
	lwzx 11,27,29
	add 9,3,6
.L462:
	addi 5,5,1
	cmpw 0,5,11
	bc 4,0,.L461
	lwzu 0,4(9)
	cmpw 0,25,0
	bc 4,1,.L462
.L461:
	lwzx 10,27,29
	cmpw 0,10,5
	bc 4,1,.L459
	addi 11,4,-4
	slwi 9,10,2
	add 11,3,11
	addi 0,6,-4
	add 0,3,0
	add 8,9,11
	mr 28,4
	add 7,9,0
	add 11,9,3
	mr 12,6
.L469:
	lwz 9,0(8)
	addi 10,10,-1
	cmpw 0,10,5
	addi 8,8,-4
	stwx 9,11,28
	lwz 0,0(7)
	addi 7,7,-4
	stwx 0,11,12
	addi 11,11,-4
	bc 12,1,.L469
.L459:
	slwi 9,5,2
	add 9,9,3
	stwx 26,4,9
	stwx 25,6,9
	lwzx 0,30,29
	add 0,0,25
	stwx 0,30,29
	lwzx 9,27,29
	addi 9,9,1
	stwx 9,27,29
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L453
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L453
	lwzx 9,23,29
	addi 9,9,1
	stwx 9,23,29
.L453:
	lwz 0,1544(21)
	mr 26,24
	cmpw 0,26,0
	bc 12,0,.L454
.L452:
	lis 3,team1_name@ha
	la 3,team1_name@l(3)
	bl strlen
	subfic 3,3,20
	rlwinm 3,3,2,0,28
	cmpwi 0,3,0
	stw 3,7716(1)
	bc 4,0,.L473
	li 0,0
	stw 0,7716(1)
.L473:
	lis 3,team2_name@ha
	la 3,team2_name@l(3)
	bl strlen
	subfic 3,3,20
	rlwinm 3,3,2,0,28
	cmpwi 0,3,0
	stw 3,7720(1)
	bc 4,0,.L474
	li 0,0
	stw 0,7720(1)
.L474:
	lwz 11,7720(1)
	lis 29,team2_name@ha
	lis 4,.LC130@ha
	lwz 9,7656(1)
	la 29,team2_name@l(29)
	lis 8,team1_name@ha
	addi 11,11,160
	lwz 5,7652(1)
	la 4,.LC130@l(4)
	lwz 6,7636(1)
	la 8,team1_name@l(8)
	addi 3,1,16
	lwz 7,7716(1)
	li 26,0
	lwz 10,7640(1)
	stw 11,8(1)
	stw 29,12(1)
	crxor 6,6,6
	bl sprintf
	addi 3,1,16
	bl strlen
	lwz 11,7636(1)
	li 0,0
	li 9,-1
	stw 0,7684(1)
	cmpw 0,26,11
	stw 9,7700(1)
	stw 0,7688(1)
	stw 9,7704(1)
	b .L545
.L479:
	cmpwi 0,3,800
	bc 4,1,.L480
	lwz 9,7636(1)
	addi 9,9,-1
	cmpw 0,26,9
	bc 4,0,.L481
	stw 26,7700(1)
.L481:
	lwz 9,7640(1)
	addi 9,9,-1
	cmpw 0,26,9
	bc 4,0,.L480
	stw 26,7704(1)
.L480:
	cmpwi 0,26,8
	bc 4,2,.L483
	lwz 0,7636(1)
	cmpwi 0,0,9
	bc 4,1,.L484
	stw 26,7700(1)
.L484:
	lwz 0,7640(1)
	cmpwi 0,0,9
	bc 4,1,.L483
	stw 26,7704(1)
.L483:
	lwz 0,7636(1)
	cmpw 0,26,0
	bc 4,0,.L486
	lwz 0,7700(1)
	cmpwi 0,0,-1
	bc 4,2,.L486
	slwi 0,26,2
	addi 10,1,2512
	lwzx 9,10,0
	lis 11,g_edicts@ha
	mr 29,0
	lwz 8,g_edicts@l(11)
	mr 30,10
	mulli 9,9,996
	addi 9,9,996
	add 31,8,9
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L487
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L487
	lwz 9,7684(1)
	addi 9,9,1
	stw 9,7684(1)
.L487:
	addi 3,1,16
	bl strlen
	addi 0,1,16
	slwi 9,26,3
	add 3,0,3
	addi 5,9,42
	mtcrf 128,20
	bc 12,2,.L488
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L488
	lis 9,.LC54@ha
	la 6,.LC54@l(9)
	b .L489
.L488:
	lis 9,.LC58@ha
	la 6,.LC58@l(9)
.L489:
	lwzx 0,30,29
	lis 9,game+1028@ha
	lis 4,.LC131@ha
	lwz 7,game+1028@l(9)
	la 4,.LC131@l(4)
	mulli 0,0,4564
	add 7,7,0
	addi 7,7,700
	crxor 6,6,6
	bl sprintf
.L486:
	lwz 0,7640(1)
	cmpw 0,26,0
	bc 4,0,.L492
	lwz 0,7704(1)
	cmpwi 0,0,-1
	bc 4,2,.L492
	slwi 0,26,2
	addi 11,1,3536
	lwzx 10,11,0
	mr 30,11
	lis 9,g_edicts@ha
	lwz 11,g_edicts@l(9)
	mr 29,0
	mulli 10,10,996
	addi 10,10,996
	add 31,11,10
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L493
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L493
	lwz 9,7688(1)
	addi 9,9,1
	stw 9,7688(1)
.L493:
	addi 3,1,16
	bl strlen
	addi 0,1,16
	slwi 9,26,3
	add 3,0,3
	addi 5,9,42
	mtcrf 128,20
	bc 12,2,.L494
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L494
	lis 9,.LC54@ha
	la 6,.LC54@l(9)
	b .L495
.L494:
	lis 9,.LC58@ha
	la 6,.LC58@l(9)
.L495:
	lwzx 0,30,29
	lis 9,game+1028@ha
	lis 4,.LC132@ha
	lwz 7,game+1028@l(9)
	la 4,.LC132@l(4)
	mulli 0,0,4564
	add 7,7,0
	addi 7,7,700
	crxor 6,6,6
	bl sprintf
.L492:
	addi 3,1,16
	addi 26,26,1
	bl strlen
	cmpwi 0,26,9
	bc 12,1,.L476
	lwz 0,7636(1)
	cmpw 0,26,0
.L545:
	bc 12,0,.L479
	lwz 0,7640(1)
	cmpw 0,26,0
	bc 12,0,.L479
.L476:
	mtcrf 128,20
	bc 4,2,.L499
	lwz 0,7700(1)
	cmpwi 0,0,-1
	bc 4,1,.L500
	addi 3,1,16
	bl strlen
	lwz 9,7700(1)
	addi 0,1,16
	lis 4,.LC133@ha
	lwz 6,7636(1)
	add 3,0,3
	la 4,.LC133@l(4)
	slwi 5,9,3
	subf 6,9,6
	addi 5,5,42
	crxor 6,6,6
	bl sprintf
.L500:
	lwz 0,7704(1)
	cmpwi 0,0,-1
	bc 4,1,.L509
	addi 3,1,16
	bl strlen
	lwz 9,7704(1)
	addi 0,1,16
	lis 4,.LC134@ha
	lwz 6,7640(1)
	add 3,0,3
	la 4,.LC134@l(4)
	slwi 5,9,3
	subf 6,9,6
	addi 5,5,42
	crxor 6,6,6
	bl sprintf
	b .L509
.L499:
	lwz 0,7700(1)
	cmpwi 0,0,-1
	bc 4,1,.L503
	addi 3,1,16
	bl strlen
	lwz 10,7668(1)
	addi 0,1,16
	lwz 11,7684(1)
	add 3,0,3
	lwz 9,7700(1)
	cmpw 0,10,11
	slwi 9,9,3
	addi 5,9,42
	bc 12,2,.L504
	lis 9,.LC54@ha
	la 6,.LC54@l(9)
	b .L505
.L504:
	lis 9,.LC58@ha
	la 6,.LC58@l(9)
.L505:
	lwz 9,7668(1)
	lis 4,.LC135@ha
	lwz 7,7684(1)
	la 4,.LC135@l(4)
	lwz 0,7636(1)
	lwz 8,7700(1)
	subf 7,7,9
	subf 8,8,0
	crxor 6,6,6
	bl sprintf
.L503:
	lwz 0,7704(1)
	cmpwi 0,0,-1
	bc 4,1,.L509
	addi 3,1,16
	bl strlen
	lwz 10,7672(1)
	addi 0,1,16
	lwz 11,7688(1)
	add 3,0,3
	lwz 9,7704(1)
	cmpw 0,10,11
	slwi 9,9,3
	addi 5,9,42
	bc 12,2,.L507
	lis 9,.LC54@ha
	la 6,.LC54@l(9)
	b .L508
.L507:
	lis 9,.LC58@ha
	la 6,.LC58@l(9)
.L508:
	lwz 9,7672(1)
	lis 4,.LC136@ha
	lwz 7,7688(1)
	la 4,.LC136@l(4)
	lwz 0,7640(1)
	lwz 8,7704(1)
	subf 7,7,9
	subf 8,8,0
	crxor 6,6,6
	bl sprintf
	b .L509
.L448:
	cmpwi 0,0,2
	bc 4,2,.L509
	lis 9,game@ha
	li 28,0
	la 11,game@l(9)
	li 26,0
	lwz 0,1544(11)
	lis 16,noscore@ha
	addi 25,1,16
	cmpw 0,28,0
	bc 4,0,.L512
	lis 9,g_edicts@ha
	lwz 21,noscore@l(16)
	mr 27,11
	lwz 22,g_edicts@l(9)
	addi 23,1,1488
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	lfs 13,0(9)
.L514:
	mulli 9,26,996
	addi 24,26,1
	add 31,9,22
	lwz 0,1084(31)
	cmpwi 0,0,0
	bc 12,2,.L513
	lfs 0,20(21)
	mulli 9,26,4564
	mr 5,28
	addi 4,1,1488
	lwz 0,1028(27)
	addi 30,1,2512
	addi 29,28,1
	fcmpu 0,0,13
	add 9,9,0
	lwz 3,3440(9)
	bc 4,2,.L517
	li 5,0
	cmpw 0,5,28
	bc 4,0,.L519
	lwz 0,0(23)
	cmpw 0,3,0
	bc 12,1,.L519
	mr 9,4
.L520:
	addi 5,5,1
	cmpw 0,5,28
	bc 4,0,.L519
	lwzu 0,4(9)
	cmpw 0,3,0
	bc 4,1,.L520
.L519:
	cmpw 0,28,5
	mr 10,28
	bc 4,1,.L517
	slwi 9,28,2
	mr 7,30
	mr 11,9
	mr 8,4
	addi 6,9,-4
.L527:
	lwzx 9,6,7
	addi 10,10,-1
	cmpw 0,10,5
	stwx 9,11,7
	lwzx 0,6,8
	addi 6,6,-4
	stwx 0,11,8
	addi 11,11,-4
	bc 12,1,.L527
.L517:
	slwi 0,5,2
	mr 28,29
	stwx 26,30,0
	stwx 3,4,0
.L513:
	lwz 0,1544(27)
	mr 26,24
	cmpw 0,26,0
	bc 12,0,.L514
.L512:
	lis 9,.LC144@ha
	lis 11,noscore@ha
	la 9,.LC144@l(9)
	lfs 13,0(9)
	lwz 9,noscore@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L530
	lis 4,.LC137@ha
	mr 3,25
	la 4,.LC137@l(4)
	li 5,95
	crxor 6,6,6
	bl memcpy
	b .L531
.L544:
	addi 3,1,16
	bl strlen
	subf 6,26,28
	slwi 5,26,3
	lis 4,.LC133@ha
	add 3,25,3
	la 4,.LC133@l(4)
	addi 5,5,56
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
	b .L509
.L530:
	lis 4,.LC138@ha
	mr 3,25
	la 4,.LC138@l(4)
	li 5,121
	crxor 6,6,6
	bl memcpy
.L531:
	li 26,0
	cmpw 0,26,28
	bc 4,0,.L509
	lis 9,game@ha
	lis 27,0x1b4e
	lis 17,.LC141@ha
	la 20,game@l(9)
	la 18,.LC141@l(17)
	lis 19,level@ha
	ori 27,27,33205
	addi 24,1,1424
	addi 31,1,2512
	li 21,0
	li 22,48
	li 23,48
.L535:
	lwz 0,0(31)
	lis 9,.LC144@ha
	lwz 11,1028(20)
	la 9,.LC144@l(9)
	mulli 0,0,4564
	lfs 13,0(9)
	lwz 9,noscore@l(16)
	add 5,0,11
	lwz 29,184(5)
	lfs 0,20(9)
	cmpwi 7,29,1000
	fcmpu 6,0,13
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,29,0
	andi. 9,9,999
	or 29,0,9
	bc 12,26,.L537
	addi 3,1,16
	bl strlen
	lwz 11,0(31)
	lis 4,.LC139@ha
	mr 8,29
	lwz 6,1028(20)
	la 4,.LC139@l(4)
	add 3,25,3
	mulli 11,11,4564
	lwz 0,level@l(19)
	mr 5,23
	add 6,6,11
	lwz 9,3436(6)
	addi 6,6,700
	subf 0,9,0
	mulhw 7,0,27
	srawi 0,0,31
	srawi 7,7,6
	subf 7,0,7
	crxor 6,6,6
	bl sprintf
	b .L538
.L537:
	lwz 5,3472(5)
	lis 0,0xf
	ori 0,0,16959
	cmpw 0,5,0
	bc 12,1,.L539
	lis 4,.LC140@ha
	addi 3,1,1424
	la 4,.LC140@l(4)
	crxor 6,6,6
	bl sprintf
	addi 30,1,1424
	b .L540
.L539:
	lwz 0,.LC141@l(17)
	addi 30,1,1424
	lhz 9,4(18)
	lbz 11,6(18)
	stw 0,1424(1)
	sth 9,4(24)
	stb 11,6(24)
.L540:
	addi 3,1,16
	bl strlen
	lwz 8,0(31)
	addi 5,1,1488
	lis 4,.LC142@ha
	lwz 7,1028(20)
	la 4,.LC142@l(4)
	mr 9,29
	mulli 8,8,4564
	lwz 11,level@l(19)
	mr 10,30
	add 3,25,3
	lwzx 6,5,21
	add 7,7,8
	mr 5,22
	lwz 0,3436(7)
	addi 7,7,700
	subf 11,0,11
	mulhw 8,11,27
	srawi 11,11,31
	srawi 8,8,6
	subf 8,11,8
	crxor 6,6,6
	bl sprintf
.L538:
	addi 3,1,16
	bl strlen
	cmplwi 0,3,800
	bc 4,1,.L534
	addi 0,28,-2
	cmpw 0,26,0
	bc 12,0,.L544
.L534:
	addi 26,26,1
	addi 31,31,4
	cmpw 0,26,28
	addi 21,21,4
	addi 22,22,8
	addi 23,23,8
	bc 12,0,.L535
.L509:
	addi 3,1,16
	bl strlen
	cmplwi 0,3,1300
	bc 4,1,.L543
	lis 9,gi+4@ha
	lis 3,.LC143@ha
	lwz 0,gi+4@l(9)
	la 3,.LC143@l(3)
	addi 4,1,16
	mtlr 0
	crxor 6,6,6
	blrl
.L543:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	addi 3,1,16
	mtlr 0
	blrl
	lwz 0,7796(1)
	mtlr 0
	lmw 16,7728(1)
	la 1,7792(1)
	blr
.Lfe14:
	.size	 A_ScoreboardMessage,.Lfe14-A_ScoreboardMessage
	.section	".rodata"
	.align 2
.LC145:
	.long 0x0
	.align 3
.LC146:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl TallyEndOfLevelTeamScores
	.type	 TallyEndOfLevelTeamScores,@function
TallyEndOfLevelTeamScores:
	stwu 1,-16(1)
	lis 9,maxclients@ha
	lis 11,.LC145@ha
	lwz 10,maxclients@l(9)
	la 11,.LC145@l(11)
	li 0,0
	lfs 0,0(11)
	lis 9,team1_total@ha
	li 5,0
	lfs 13,20(10)
	lis 11,team2_total@ha
	stw 0,team1_total@l(9)
	stw 0,team2_total@l(11)
	fcmpu 0,0,13
	bc 4,0,.L548
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 11,game@l(11)
	lis 4,0x4330
	lis 9,.LC146@ha
	li 6,0
	la 9,.LC146@l(9)
	addi 10,10,1084
	lfd 13,0(9)
	li 7,0
	li 8,0
.L550:
	lwz 0,0(10)
	addi 10,10,996
	cmpwi 0,0,0
	bc 12,2,.L549
	lwz 0,1028(11)
	add 9,8,0
	lwz 0,3488(9)
	cmpwi 0,0,1
	bc 4,2,.L552
	lwz 0,3440(9)
	add 6,6,0
	b .L549
.L552:
	cmpwi 0,0,2
	bc 4,2,.L549
	lwz 0,3440(9)
	add 7,7,0
.L549:
	addi 5,5,1
	xoris 0,5,0x8000
	addi 8,8,4564
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L550
	lis 9,team2_total@ha
	lis 11,team1_total@ha
	stw 7,team2_total@l(9)
	stw 6,team1_total@l(11)
.L548:
	la 1,16(1)
	blr
.Lfe15:
	.size	 TallyEndOfLevelTeamScores,.Lfe15-TallyEndOfLevelTeamScores
	.section	".rodata"
	.align 2
.LC147:
	.string	"info_player_deathmatch"
	.align 2
.LC148:
	.string	"Warning: MAX_SPAWNS exceeded\n"
	.align 2
.LC153:
	.string	"Out-of-range teams value in SelectFarTeamplaySpawnPoint, skipping...\n"
	.align 2
.LC151:
	.long 0x4eee6b28
	.align 2
.LC152:
	.long 0x46fffe00
	.align 2
.LC154:
	.long 0x0
	.align 3
.LC155:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectFarTeamplaySpawnPoint
	.type	 SelectFarTeamplaySpawnPoint,@function
SelectFarTeamplaySpawnPoint:
	stwu 1,-128(1)
	mflr 0
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 14,40(1)
	stw 0,132(1)
	lis 29,num_potential_spawns@ha
	mr 14,3
	lis 9,gi+132@ha
	lwz 3,num_potential_spawns@l(29)
	mr 20,4
	lwz 0,gi+132@l(9)
	li 4,765
	li 25,0
	slwi 3,3,3
	lis 15,num_potential_spawns@ha
	mtlr 0
	blrl
	lwz 0,num_potential_spawns@l(29)
	mr 22,3
	li 10,0
	cmpw 0,25,0
	bc 4,0,.L575
	lis 9,potential_spawns@ha
	lis 16,.LC151@ha
	la 17,potential_spawns@l(9)
	lis 21,num_teams@ha
	lis 9,.LC154@ha
	lis 18,potential_spawns@ha
	la 9,.LC154@l(9)
	lis 19,teamplay_spawns@ha
	lfs 30,0(9)
.L577:
	lwz 0,num_teams@l(21)
	li 31,0
	addi 27,10,1
	lfs 31,.LC151@l(16)
	slwi 30,10,2
	addi 26,25,1
	cmpw 0,31,0
	slwi 28,10,3
	bc 4,0,.L579
	la 23,potential_spawns@l(18)
	la 24,teamplay_spawns@l(19)
	li 29,0
.L581:
	lwzx 0,29,20
	cmpwi 0,0,0
	bc 12,2,.L580
	lwzx 11,23,30
	addi 3,1,8
	lwzx 9,29,24
	lfs 0,4(11)
	lfs 13,4(9)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 0,8(9)
	lfs 13,8(11)
	fsubs 13,13,0
	stfs 13,12(1)
	lfs 0,12(11)
	lfs 13,12(9)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L580
	fmr 31,1
.L580:
	lwz 0,num_teams@l(21)
	addi 31,31,1
	addi 29,29,4
	cmpw 0,31,0
	bc 12,0,.L581
.L579:
	fcmpu 7,31,30
	lwzx 0,17,30
	add 9,28,22
	mr 10,27
	lwz 11,num_potential_spawns@l(15)
	stw 0,4(9)
	cmpw 0,10,11
	stfsx 31,28,22
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,26,0
	and 0,25,0
	or 25,0,9
	bc 12,0,.L577
.L575:
	lis 29,num_potential_spawns@ha
	lis 6,compare_spawn_distances@ha
	lwz 4,num_potential_spawns@l(29)
	la 6,compare_spawn_distances@l(6)
	mr 3,22
	li 5,8
	bl qsort
	lwz 0,num_potential_spawns@l(29)
	subf 0,25,0
	cmpwi 0,0,4
	bc 12,1,.L588
	li 31,1
	b .L589
.L588:
	cmpwi 7,0,10
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	rlwinm 0,0,0,30,31
	ori 31,0,2
.L589:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 11,36(1)
	andi. 0,11,512
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	addi 0,9,1
	and 9,31,9
	or 31,9,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,0x4330
	stw 3,36(1)
	lis 9,.LC155@ha
	lis 10,.LC152@ha
	stw 8,32(1)
	la 9,.LC155@l(9)
	xoris 0,31,0x8000
	lfd 12,0(9)
	mr 7,11
	cmplwi 0,14,1
	lfd 13,32(1)
	mr 9,11
	lfs 10,.LC152@l(10)
	stw 0,36(1)
	fsub 13,13,12
	stw 8,32(1)
	lfd 0,32(1)
	frsp 13,13
	fsub 0,0,12
	fdivs 13,13,10
	frsp 0,0
	fmuls 13,13,0
	fmr 12,13
	fctiwz 11,12
	stfd 11,32(1)
	lwz 8,36(1)
	bc 4,1,.L594
	lis 9,gi+4@ha
	lis 3,.LC153@ha
	lwz 0,gi+4@l(9)
	la 3,.LC153@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L595
.L594:
	lis 11,num_potential_spawns@ha
	slwi 10,14,2
	lwz 9,num_potential_spawns@l(11)
	li 0,1
	stwx 0,10,20
	lis 11,teamplay_spawns@ha
	subf 9,8,9
	la 11,teamplay_spawns@l(11)
	slwi 9,9,3
	add 9,9,22
	lwz 0,-4(9)
	stwx 0,10,11
.L595:
	lis 9,gi+136@ha
	mr 3,22
	lwz 0,gi+136@l(9)
	mtlr 0
	blrl
	lwz 0,132(1)
	mtlr 0
	lmw 14,40(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe16:
	.size	 SelectFarTeamplaySpawnPoint,.Lfe16-SelectFarTeamplaySpawnPoint
	.section	".rodata"
	.align 2
.LC157:
	.string	"Warning: attempt to setup spawns for out-of-range team (%d)\n"
	.align 2
.LC156:
	.long 0x46fffe00
	.align 3
.LC158:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SetupTeamSpawnPoints
	.type	 SetupTeamSpawnPoints,@function
SetupTeamSpawnPoints:
	stwu 1,-112(1)
	mflr 0
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 19,44(1)
	stw 0,116(1)
	lis 9,num_teams@ha
	lis 19,num_teams@ha
	lwz 3,num_teams@l(9)
	addi 30,1,8
	cmpwi 0,3,0
	bc 4,1,.L598
	lis 9,teamplay_spawns@ha
	mr 31,3
	la 9,teamplay_spawns@l(9)
	li 0,0
	mr 10,30
	li 11,0
.L600:
	stwx 0,11,9
	addic. 31,31,-1
	stwx 0,11,10
	addi 11,11,4
	bc 4,2,.L600
.L598:
	lis 9,num_teams@ha
	li 26,1
	lwz 29,num_teams@l(9)
	lis 20,.LC157@ha
	lis 21,num_potential_spawns@ha
	bl rand
	lis 27,0x4330
	li 25,1
	lis 9,.LC158@ha
	rlwinm 3,3,0,17,31
	la 9,.LC158@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 0,0x4330
	lis 11,.LC158@ha
	la 11,.LC158@l(11)
	stw 3,36(1)
	mr 10,9
	xoris 29,29,0x8000
	stw 0,32(1)
	mr 8,9
	lfd 13,0(11)
	lfd 12,32(1)
	lis 11,.LC156@ha
	lfs 10,.LC156@l(11)
	lis 9,gi@ha
	stw 29,36(1)
	la 22,gi@l(9)
	lis 11,teamplay_spawns@ha
	fsub 12,12,13
	stw 0,32(1)
	lis 9,potential_spawns@ha
	la 23,teamplay_spawns@l(11)
	lfd 0,32(1)
	fmr 30,10
	la 24,potential_spawns@l(9)
	frsp 12,12
	fsub 0,0,13
	fdivs 12,12,10
	frsp 0,0
	fmuls 12,12,0
	fmr 13,12
	fctiwz 11,13
	stfd 11,32(1)
	lwz 31,36(1)
	mr 28,31
.L612:
	cmplwi 0,31,1
	mr 4,31
	la 3,.LC157@l(20)
	bc 4,1,.L606
	lwz 9,4(22)
	mtlr 9
	crxor 6,6,6
	blrl
.L606:
	cmpwi 0,26,0
	mr 3,31
	mr 4,30
	bc 12,2,.L607
	lwz 29,num_potential_spawns@l(21)
	li 26,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	mr 11,9
	stw 3,36(1)
	xoris 29,29,0x8000
	mr 10,9
	stw 27,32(1)
	slwi 8,31,2
	lfd 13,32(1)
	stw 29,36(1)
	stw 27,32(1)
	fsub 13,13,31
	lfd 12,32(1)
	stwx 25,8,30
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,30
	frsp 12,12
	fmuls 13,13,12
	fmr 0,13
	fctiwz 11,0
	stfd 11,32(1)
	lwz 10,36(1)
	slwi 10,10,2
	lwzx 0,24,10
	stwx 0,8,23
	b .L610
.L607:
	bl SelectFarTeamplaySpawnPoint
.L610:
	lwz 9,num_teams@l(19)
	addi 31,31,1
	xor 9,31,9
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and 31,31,0
	cmpw 0,31,28
	bc 4,2,.L612
	lwz 0,116(1)
	mtlr 0
	lmw 19,44(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe17:
	.size	 SetupTeamSpawnPoints,.Lfe17-SetupTeamSpawnPoints
	.align 2
	.globl SelectTeamplaySpawnPoint
	.type	 SelectTeamplaySpawnPoint,@function
SelectTeamplaySpawnPoint:
	lwz 10,84(3)
	lis 11,teamplay_spawns@ha
	la 11,teamplay_spawns@l(11)
	lwz 9,3488(10)
	addi 9,9,-1
	slwi 9,9,2
	lwzx 3,9,11
	blr
.Lfe18:
	.size	 SelectTeamplaySpawnPoint,.Lfe18-SelectTeamplaySpawnPoint
	.align 2
	.globl OpenJoinMenu
	.type	 OpenJoinMenu,@function
OpenJoinMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl UpdateJoinMenu
	xori 3,3,1
	lis 4,joinmenu@ha
	srawi 9,3,31
	la 4,joinmenu@l(4)
	xor 0,9,3
	li 6,16
	subf 0,0,9
	mr 3,29
	srawi 0,0,31
	nor 5,0,0
	andi. 0,0,5
	rlwinm 5,5,0,30,31
	or 5,0,5
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 OpenJoinMenu,.Lfe19-OpenJoinMenu
	.align 2
	.globl OpenWeaponMenu
	.type	 OpenWeaponMenu,@function
OpenWeaponMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 4,weapmenu@ha
	li 5,4
	la 4,weapmenu@l(4)
	li 6,17
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 OpenWeaponMenu,.Lfe20-OpenWeaponMenu
	.align 2
	.globl OpenItemMenu
	.type	 OpenItemMenu,@function
OpenItemMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 4,itemmenu@ha
	li 5,4
	la 4,itemmenu@l(4)
	li 6,15
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 OpenItemMenu,.Lfe21-OpenItemMenu
	.align 2
	.globl StartClient
	.type	 StartClient,@function
StartClient:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 7,84(10)
	lwz 8,3488(7)
	cmpwi 0,8,0
	bc 4,2,.L212
	lwz 0,184(10)
	li 9,1
	lis 11,gi+72@ha
	stw 9,260(10)
	ori 0,0,1
	stw 8,248(10)
	stw 0,184(10)
	stw 8,3488(7)
	lwz 9,84(10)
	stw 8,88(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	li 3,1
	b .L613
.L212:
	li 3,0
.L613:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 StartClient,.Lfe22-StartClient
	.align 2
	.globl AssignSkin
	.type	 AssignSkin,@function
AssignSkin:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,g_edicts@ha
	lwz 10,84(3)
	lis 9,0xe64
	lwz 0,g_edicts@l(11)
	ori 9,9,49481
	mr 5,4
	lwz 11,3488(10)
	subf 0,0,3
	mullw 0,0,9
	cmpwi 0,11,1
	srawi 28,0,2
	addi 9,28,-1
	bc 12,2,.L58
	cmpwi 0,11,2
	bc 12,2,.L59
	b .L60
.L58:
	lis 29,gi@ha
	lis 3,.LC48@ha
	lis 5,team1_skin@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,10,700
	la 3,.LC48@l(3)
	la 5,team1_skin@l(5)
	b .L614
.L59:
	lis 29,gi@ha
	lis 3,.LC48@ha
	lis 5,team2_skin@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,10,700
	la 3,.LC48@l(3)
	la 5,team2_skin@l(5)
.L614:
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	b .L57
.L60:
	lwz 4,84(3)
	lis 29,gi@ha
	addi 28,9,1312
	lis 3,.LC48@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC48@l(3)
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L57:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 AssignSkin,.Lfe23-AssignSkin
	.align 2
	.globl GetSpawnPoints
	.type	 GetSpawnPoints,@function
GetSpawnPoints:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 3,0
	lis 9,num_potential_spawns@ha
	stw 3,num_potential_spawns@l(9)
	b .L560
.L562:
	lis 10,num_potential_spawns@ha
	lis 11,potential_spawns@ha
	lwz 9,num_potential_spawns@l(10)
	la 11,potential_spawns@l(11)
	addi 0,9,1
	slwi 9,9,2
	cmpwi 0,0,999
	stwx 3,11,9
	stw 0,num_potential_spawns@l(10)
	bc 4,1,.L560
	lis 9,gi+4@ha
	lis 3,.LC148@ha
	lwz 0,gi+4@l(9)
	la 3,.LC148@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L559
.L560:
	lis 5,.LC147@ha
	li 4,280
	la 5,.LC147@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L562
.L559:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 GetSpawnPoints,.Lfe24-GetSpawnPoints
	.align 2
	.globl LeaveTeam
	.type	 LeaveTeam,@function
LeaveTeam:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L151
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L153
	li 0,0
	lis 6,0x1
	lis 7,vec3_origin@ha
	stw 0,480(31)
	la 7,vec3_origin@l(7)
	mr 4,31
	mr 5,31
	ori 6,6,34464
	bl player_die
	li 0,2
	stw 0,492(31)
.L153:
	mr 3,31
	bl IsNeutral
	cmpwi 0,3,0
	bc 12,2,.L154
	lis 9,.LC67@ha
	la 6,.LC67@l(9)
	b .L155
.L154:
	mr 3,31
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L156
	lis 9,.LC68@ha
	la 6,.LC68@l(9)
	b .L155
.L156:
	lis 9,.LC69@ha
	la 6,.LC69@l(9)
.L155:
	lwz 5,84(31)
	lis 4,.LC70@ha
	li 3,2
	la 4,.LC70@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(31)
	li 0,0
	stw 0,3492(11)
	lwz 9,84(31)
	stw 0,3488(9)
	bl CheckForUnevenTeams
.L151:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 LeaveTeam,.Lfe25-LeaveTeam
	.section	".rodata"
	.align 2
.LC159:
	.long 0x46fffe00
	.align 3
.LC160:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl newrand
	.type	 newrand,@function
newrand:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 9,.LC160@ha
	lis 10,.LC159@ha
	la 9,.LC160@l(9)
	stw 0,24(1)
	xoris 29,29,0x8000
	lfd 12,0(9)
	mr 3,11
	lfd 0,24(1)
	mr 9,11
	lfs 10,.LC159@l(10)
	stw 29,28(1)
	fsub 0,0,12
	stw 0,24(1)
	lfd 13,24(1)
	frsp 0,0
	fsub 13,13,12
	fdivs 0,0,10
	frsp 13,13
	fmuls 0,0,13
	fmr 12,0
	fctiwz 11,12
	stfd 11,24(1)
	lwz 3,28(1)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 newrand,.Lfe26-newrand
	.align 2
	.globl InitTransparentList
	.type	 InitTransparentList,@function
InitTransparentList:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,transparent_list@ha
	lwz 3,transparent_list@l(9)
	cmpwi 0,3,0
	bc 12,2,.L7
	lis 9,gi@ha
	mr 29,3
	la 31,gi@l(9)
.L10:
	lwz 9,136(31)
	mr 3,29
	lwz 29,4(29)
	mtlr 9
	blrl
	mr. 29,29
	bc 4,2,.L10
	lis 9,transparent_list@ha
	stw 29,transparent_list@l(9)
.L7:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 InitTransparentList,.Lfe27-InitTransparentList
	.align 2
	.globl AddToTransparentList
	.type	 AddToTransparentList,@function
AddToTransparentList:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	li 3,8
	lwz 9,132(30)
	li 4,765
	mtlr 9
	blrl
	mr. 3,3
	bc 4,2,.L13
	lwz 0,4(30)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	bl exit
.L13:
	lis 11,transparent_list@ha
	li 0,0
	stw 31,0(3)
	lwz 9,transparent_list@l(11)
	stw 0,4(3)
	cmpwi 0,9,0
	bc 4,2,.L615
	stw 3,transparent_list@l(11)
	b .L15
.L18:
	lwz 9,4(9)
.L615:
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 4,2,.L18
	stw 3,4(9)
.L15:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe28:
	.size	 AddToTransparentList,.Lfe28-AddToTransparentList
	.align 2
	.globl RemoveFromTransparentList
	.type	 RemoveFromTransparentList,@function
RemoveFromTransparentList:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 31,transparent_list@ha
	lwz 11,transparent_list@l(31)
	cmpwi 0,11,0
	bc 12,2,.L21
	lwz 0,0(11)
	cmpw 0,0,3
	bc 4,2,.L22
	lis 9,gi@ha
	mr 3,11
	lwz 29,4(11)
	la 9,gi@l(9)
	lwz 0,136(9)
	mtlr 0
	blrl
	stw 29,transparent_list@l(31)
	b .L20
.L616:
	lis 9,gi+136@ha
	mr 3,29
	lwz 0,gi+136@l(9)
	lwz 29,4(29)
	mtlr 0
	blrl
	stw 29,4(31)
	b .L20
.L22:
	mr 31,11
	b .L617
.L26:
	lwz 0,0(29)
	cmpw 0,0,3
	bc 12,2,.L616
	lwz 31,4(31)
.L617:
	lwz 29,4(31)
	cmpwi 0,29,0
	bc 4,2,.L26
.L21:
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L20:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 RemoveFromTransparentList,.Lfe29-RemoveFromTransparentList
	.comm	trace_t_temp,56,4
	.align 2
	.globl TransparentListSet
	.type	 TransparentListSet,@function
TransparentListSet:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,transparent_list@ha
	mr 30,3
	lwz 31,transparent_list@l(9)
	cmpwi 0,31,0
	bc 12,2,.L31
	lis 9,gi@ha
	la 29,gi@l(9)
.L32:
	lwz 9,0(31)
	stw 30,248(9)
	lwz 9,72(29)
	lwz 3,0(31)
	mtlr 9
	blrl
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L32
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 TransparentListSet,.Lfe30-TransparentListSet
	.comm	potential_spawns,4000,4
	.comm	num_potential_spawns,4,4
	.comm	teamplay_spawns,8,4
	.align 2
	.globl CreditsMenu
	.type	 CreditsMenu,@function
CreditsMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,creditsmenu@ha
	mr 3,29
	la 4,creditsmenu@l(4)
	li 5,4
	li 6,25
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 CreditsMenu,.Lfe31-CreditsMenu
	.align 2
	.globl ReprintMOTD
	.type	 ReprintMOTD,@function
ReprintMOTD:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl PrintMOTD
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 ReprintMOTD,.Lfe32-ReprintMOTD
	.align 2
	.globl JoinTeam1
	.type	 JoinTeam1,@function
JoinTeam1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,1
	li 5,0
	bl JoinTeam
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 JoinTeam1,.Lfe33-JoinTeam1
	.align 2
	.globl JoinTeam2
	.type	 JoinTeam2,@function
JoinTeam2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,2
	li 5,0
	bl JoinTeam
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 JoinTeam2,.Lfe34-JoinTeam2
	.align 2
	.globl SelectWeapon2
	.type	 SelectWeapon2,@function
SelectWeapon2:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3484(9)
	mr 3,29
	bl PMenu_Close
	mr 3,29
	bl OpenItemMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 SelectWeapon2,.Lfe35-SelectWeapon2
	.align 2
	.globl SelectWeapon3
	.type	 SelectWeapon3,@function
SelectWeapon3:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3484(9)
	mr 3,29
	bl PMenu_Close
	mr 3,29
	bl OpenItemMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 SelectWeapon3,.Lfe36-SelectWeapon3
	.align 2
	.globl SelectWeapon4
	.type	 SelectWeapon4,@function
SelectWeapon4:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3484(9)
	mr 3,29
	bl PMenu_Close
	mr 3,29
	bl OpenItemMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 SelectWeapon4,.Lfe37-SelectWeapon4
	.align 2
	.globl SelectWeapon5
	.type	 SelectWeapon5,@function
SelectWeapon5:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3484(9)
	mr 3,29
	bl PMenu_Close
	mr 3,29
	bl OpenItemMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 SelectWeapon5,.Lfe38-SelectWeapon5
	.align 2
	.globl SelectWeapon6
	.type	 SelectWeapon6,@function
SelectWeapon6:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3484(9)
	mr 3,29
	bl PMenu_Close
	mr 3,29
	bl OpenItemMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 SelectWeapon6,.Lfe39-SelectWeapon6
	.align 2
	.globl SelectWeapon0
	.type	 SelectWeapon0,@function
SelectWeapon0:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3484(9)
	mr 3,29
	bl PMenu_Close
	mr 3,29
	bl OpenItemMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 SelectWeapon0,.Lfe40-SelectWeapon0
	.align 2
	.globl SelectWeapon9
	.type	 SelectWeapon9,@function
SelectWeapon9:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3484(9)
	mr 3,29
	bl PMenu_Close
	mr 3,29
	bl OpenItemMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe41:
	.size	 SelectWeapon9,.Lfe41-SelectWeapon9
	.align 2
	.globl SelectItem1
	.type	 SelectItem1,@function
SelectItem1:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC9@ha
	la 3,.LC9@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3480(9)
	mr 3,29
	bl PMenu_Close
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 SelectItem1,.Lfe42-SelectItem1
	.align 2
	.globl SelectItem2
	.type	 SelectItem2,@function
SelectItem2:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3480(9)
	mr 3,29
	bl PMenu_Close
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 SelectItem2,.Lfe43-SelectItem2
	.align 2
	.globl SelectItem3
	.type	 SelectItem3,@function
SelectItem3:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3480(9)
	mr 3,29
	bl PMenu_Close
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe44:
	.size	 SelectItem3,.Lfe44-SelectItem3
	.align 2
	.globl SelectItem4
	.type	 SelectItem4,@function
SelectItem4:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3480(9)
	mr 3,29
	bl PMenu_Close
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 SelectItem4,.Lfe45-SelectItem4
	.align 2
	.globl SelectItem5
	.type	 SelectItem5,@function
SelectItem5:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	bl FindItem
	lwz 9,84(29)
	stw 3,3480(9)
	mr 3,29
	bl PMenu_Close
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 SelectItem5,.Lfe46-SelectItem5
	.align 2
	.globl CreditsReturnToMain
	.type	 CreditsReturnToMain,@function
CreditsReturnToMain:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl OpenJoinMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe47:
	.size	 CreditsReturnToMain,.Lfe47-CreditsReturnToMain
	.align 2
	.globl TeamName
	.type	 TeamName,@function
TeamName:
	cmpwi 0,3,1
	bc 4,2,.L52
	lis 3,team1_name@ha
	la 3,team1_name@l(3)
	blr
.L52:
	cmpwi 0,3,2
	bc 12,2,.L54
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	blr
.L54:
	lis 3,team2_name@ha
	la 3,team2_name@l(3)
	blr
.Lfe48:
	.size	 TeamName,.Lfe48-TeamName
	.section	".rodata"
	.align 2
.LC161:
	.long 0x3f800000
	.align 3
.LC162:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl UnevenTeamsMsg
	.type	 UnevenTeamsMsg,@function
UnevenTeamsMsg:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stfd 31,72(1)
	stmw 19,20(1)
	stw 0,84(1)
	stw 12,16(1)
	lis 11,.LC161@ha
	lis 9,maxclients@ha
	la 11,.LC161@l(11)
	mr 26,3
	lfs 13,0(11)
	mr 29,4
	mr 27,5
	lwz 11,maxclients@l(9)
	li 28,1
	lis 19,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L91
	lis 9,.LC162@ha
	cmpwi 4,29,1
	la 9,.LC162@l(9)
	lis 20,g_edicts@ha
	lfd 31,0(9)
	lis 21,.LC58@ha
	lis 22,.LC59@ha
	lis 23,.LC57@ha
	lis 24,.LC60@ha
	lis 25,0x4330
	li 30,996
.L93:
	lwz 0,g_edicts@l(20)
	add 31,0,30
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L92
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpw 0,0,26
	bc 4,2,.L92
	la 7,.LC58@l(21)
	bc 12,18,.L97
	la 7,.LC59@l(22)
.L97:
	mr 3,31
	li 4,2
	la 5,.LC57@l(23)
	mr 6,29
	mr 8,27
	crxor 6,6,6
	bl safe_cprintf
	mr 3,31
	la 4,.LC60@l(24)
	bl stuffcmd
.L92:
	addi 28,28,1
	lwz 11,maxclients@l(19)
	xoris 0,28,0x8000
	addi 30,30,996
	stw 0,12(1)
	stw 25,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L93
.L91:
	lwz 0,84(1)
	lwz 12,16(1)
	mtlr 0
	lmw 19,20(1)
	lfd 31,72(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe49:
	.size	 UnevenTeamsMsg,.Lfe49-UnevenTeamsMsg
	.align 2
	.globl ReturnToMain
	.type	 ReturnToMain,@function
ReturnToMain:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl OpenJoinMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 ReturnToMain,.Lfe50-ReturnToMain
	.align 2
	.globl member_array
	.type	 member_array,@function
member_array:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,5
	li 30,0
	cmpw 0,30,29
	mr 28,3
	bc 4,0,.L191
	mr 31,4
.L193:
	lwz 4,0(31)
	mr 3,28
	addi 31,31,4
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L192
	mr 3,30
	b .L619
.L192:
	addi 30,30,1
	cmpw 0,30,29
	bc 12,0,.L193
.L191:
	li 3,-1
.L619:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe51:
	.size	 member_array,.Lfe51-member_array
	.align 2
	.globl CenterPrintAll
	.type	 CenterPrintAll,@function
CenterPrintAll:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 29,3
	li 4,2
	li 3,0
	mr 5,29
	crxor 6,6,6
	bl safe_cprintf
	li 31,0
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,31,0
	bc 4,0,.L215
	mr 26,9
	lis 27,g_edicts@ha
	lis 28,.LC98@ha
	li 30,996
.L217:
	lwz 0,g_edicts@l(27)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L216
	la 4,.LC98@l(28)
	mr 5,29
	crxor 6,6,6
	bl safe_centerprintf
.L216:
	lwz 0,1544(26)
	addi 31,31,1
	addi 30,30,996
	cmpw 0,31,0
	bc 12,0,.L217
.L215:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe52:
	.size	 CenterPrintAll,.Lfe52-CenterPrintAll
	.align 2
	.globl BothTeamsHavePlayers
	.type	 BothTeamsHavePlayers,@function
BothTeamsHavePlayers:
	lis 9,game@ha
	li 8,0
	la 11,game@l(9)
	li 6,0
	lwz 0,1544(11)
	cmpw 0,8,0
	bc 4,0,.L222
	lis 9,g_edicts@ha
	mr 5,11
	mtctr 0
	lwz 11,g_edicts@l(9)
	li 7,0
	addi 10,11,1084
.L224:
	lwz 0,0(10)
	addi 10,10,996
	cmpwi 0,0,0
	bc 12,2,.L223
	lwz 9,1028(5)
	add 9,7,9
	lwz 11,3488(9)
	cmpwi 0,11,1
	bc 4,2,.L226
	addi 6,6,1
	b .L223
.L226:
	xori 11,11,2
	addi 9,8,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L223:
	addi 7,7,4564
	bdnz .L224
.L222:
	srawi 0,6,31
	srawi 3,8,31
	subf 0,6,0
	subf 3,8,3
	srwi 0,0,31
	srwi 3,3,31
	and 3,0,3
	blr
.Lfe53:
	.size	 BothTeamsHavePlayers,.Lfe53-BothTeamsHavePlayers
	.align 2
	.globl StartRound
	.type	 StartRound,@function
StartRound:
	lis 10,team_round_going@ha
	li 9,1
	lis 11,current_round_length@ha
	li 0,0
	stw 9,team_round_going@l(10)
	stw 0,current_round_length@l(11)
	blr
.Lfe54:
	.size	 StartRound,.Lfe54-StartRound
	.section	".rodata"
	.align 2
.LC163:
	.long 0x3f800000
	.align 2
.LC164:
	.long 0x0
	.section	".text"
	.align 2
	.globl StartLCA
	.type	 StartLCA,@function
StartLCA:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	bl CleanLevel
	li 28,0
	lis 26,g_edicts@ha
	lis 9,.LC100@ha
	li 3,0
	la 31,.LC100@l(9)
	li 4,2
	mr 5,31
	crxor 6,6,6
	bl safe_cprintf
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,28,0
	bc 4,0,.L297
	mr 27,9
	lis 30,.LC98@ha
	li 29,996
.L293:
	lwz 0,g_edicts@l(26)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L295
	la 4,.LC98@l(30)
	mr 5,31
	crxor 6,6,6
	bl safe_centerprintf
.L295:
	lwz 0,1544(27)
	addi 28,28,1
	addi 29,29,996
	cmpw 0,28,0
	bc 12,0,.L293
.L297:
	lis 29,gi@ha
	lis 3,.LC101@ha
	la 29,gi@l(29)
	la 3,.LC101@l(3)
	lwz 11,36(29)
	lis 9,g_edicts@ha
	lwz 28,g_edicts@l(9)
	mtlr 11
	blrl
	lis 9,.LC163@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC163@l(9)
	mr 3,28
	lfs 1,0(9)
	mtlr 0
	li 4,10
	lis 9,.LC164@ha
	la 9,.LC164@l(9)
	lfs 2,0(9)
	lis 9,.LC164@ha
	la 9,.LC164@l(9)
	lfs 3,0(9)
	blrl
	lis 9,lights_camera_action@ha
	li 0,41
	stw 0,lights_camera_action@l(9)
	bl SpawnPlayers
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe55:
	.size	 StartLCA,.Lfe55-StartLCA
	.align 2
	.globl MakeAllLivePlayersObservers
	.type	 MakeAllLivePlayersObservers,@function
MakeAllLivePlayersObservers:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,30,0
	bc 4,0,.L332
	mr 25,9
	lis 26,g_edicts@ha
	li 27,0
	li 28,996
.L334:
	lwz 0,g_edicts@l(26)
	add 31,0,28
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L333
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L333
	lwz 9,84(31)
	mr 3,31
	lwz 29,3488(9)
	stw 27,3488(9)
	bl PutClientInServer
	lwz 9,84(31)
	stw 29,3488(9)
.L333:
	lwz 0,1544(25)
	addi 30,30,1
	addi 28,28,996
	cmpw 0,30,0
	bc 12,0,.L334
.L332:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe56:
	.size	 MakeAllLivePlayersObservers,.Lfe56-MakeAllLivePlayersObservers
	.align 2
	.globl SpawnPointDistance
	.type	 SpawnPointDistance,@function
SpawnPointDistance:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	mr 9,3
	lfs 11,12(4)
	lfs 12,12(9)
	addi 3,1,8
	lfs 13,4(9)
	lfs 10,4(4)
	fsubs 12,12,11
	lfs 0,8(9)
	lfs 11,8(4)
	fsubs 13,13,10
	stfs 12,16(1)
	fsubs 0,0,11
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorLength
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe57:
	.size	 SpawnPointDistance,.Lfe57-SpawnPointDistance
	.align 2
	.globl compare_spawn_distances
	.type	 compare_spawn_distances,@function
compare_spawn_distances:
	lfs 13,0(3)
	lfs 0,0(4)
	fcmpu 0,13,0
	li 3,-1
	bclr 12,0
	mfcr 3
	rlwinm 3,3,2,1
	blr
.Lfe58:
	.size	 compare_spawn_distances,.Lfe58-compare_spawn_distances
	.section	".rodata"
	.align 2
.LC165:
	.long 0x46fffe00
	.align 3
.LC166:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectRandomTeamplaySpawnPoint
	.type	 SelectRandomTeamplaySpawnPoint,@function
SelectRandomTeamplaySpawnPoint:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,num_potential_spawns@ha
	mr 28,3
	lwz 29,num_potential_spawns@l(9)
	mr 27,4
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC166@ha
	lis 7,.LC165@ha
	stw 0,16(1)
	la 11,.LC166@l(11)
	mr 10,9
	lfd 13,0(11)
	xoris 29,29,0x8000
	lis 8,potential_spawns@ha
	lfd 12,16(1)
	mr 11,9
	la 8,potential_spawns@l(8)
	lfs 10,.LC165@l(7)
	lis 9,teamplay_spawns@ha
	slwi 28,28,2
	stw 29,20(1)
	la 9,teamplay_spawns@l(9)
	li 7,1
	fsub 12,12,13
	stw 0,16(1)
	lfd 0,16(1)
	frsp 12,12
	fsub 0,0,13
	fdivs 12,12,10
	frsp 0,0
	fmuls 12,12,0
	fmr 13,12
	fctiwz 11,13
	stfd 11,16(1)
	lwz 11,20(1)
	slwi 11,11,2
	lwzx 0,8,11
	stwx 0,28,9
	stwx 7,28,27
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe59:
	.size	 SelectRandomTeamplaySpawnPoint,.Lfe59-SelectRandomTeamplaySpawnPoint
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
