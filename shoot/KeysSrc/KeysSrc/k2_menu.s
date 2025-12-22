	.file	"k2_menu.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl k2joinmenu
	.align 2
	.type	 k2joinmenu,@object
k2joinmenu:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long .LC1
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
	.long .LC2
	.long 0
	.long 0
	.long K2EnterGame
	.long .LC3
	.long 0
	.long 0
	.long K2MenuCameraCommand
	.long .LC4
	.long 0
	.long 0
	.long K2_OpenHelpMenu
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC5
	.long 0
	.long 0
	.long K2Credits
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC6
	.long 0
	.long 0
	.long 0
	.long .LC7
	.long 0
	.long 0
	.long 0
	.long .LC8
	.long 0
	.long 0
	.long 0
	.long .LC9
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC9:
	.string	"(TAB to Return)"
	.align 2
.LC8:
	.string	"ESC to Exit Menu"
	.align 2
.LC7:
	.string	"ENTER to select"
	.align 2
.LC6:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC5:
	.string	"Credits"
	.align 2
.LC4:
	.string	"Help/Info"
	.align 2
.LC3:
	.string	"Q2 Camera"
	.align 2
.LC2:
	.string	"Enter the Fragfest"
	.align 2
.LC1:
	.string	"*Keys2 1.94"
	.align 2
.LC0:
	.string	"*Quake II"
	.size	 k2joinmenu,240
	.globl k2creditsmenu
	.section	".data"
	.align 2
	.type	 k2creditsmenu,@object
k2creditsmenu:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long .LC10
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC11
	.long 0
	.long 0
	.long 0
	.long .LC12
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC13
	.long 0
	.long 0
	.long 0
	.long .LC14
	.long 0
	.long 0
	.long 0
	.long .LC15
	.long 0
	.long 0
	.long 0
	.long .LC16
	.long 0
	.long 0
	.long 0
	.long .LC17
	.long 0
	.long 0
	.long 0
	.long .LC18
	.long 0
	.long 0
	.long 0
	.long .LC19
	.long 0
	.long 0
	.long 0
	.long .LC20
	.long 0
	.long 0
	.long 0
	.long .LC21
	.long 0
	.long 0
	.long 0
	.long .LC22
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC23
	.long 1
	.long 0
	.long K2ReturnToMain
	.section	".rodata"
	.align 2
.LC23:
	.string	"Return to Main Menu"
	.align 2
.LC22:
	.string	"'Ridah' (Eraser)"
	.align 2
.LC21:
	.string	"Expert DM (Hook)"
	.align 2
.LC20:
	.string	"'Zoid' (CTF)"
	.align 2
.LC19:
	.string	"id Software (Quake2)"
	.align 2
.LC18:
	.string	"*Additional Credits"
	.align 2
.LC17:
	.string	"Galactus and Capt. Sky"
	.align 2
.LC16:
	.string	"Viking and Bambi"
	.align 2
.LC15:
	.string	"K2 Klan"
	.align 2
.LC14:
	.string	"Fuk'n_Hostile_K2 and the"
	.align 2
.LC13:
	.string	"*Playtesting"
	.align 2
.LC12:
	.string	"Rich 'K2Guy' Shetina"
	.align 2
.LC11:
	.string	"*Programming"
	.align 2
.LC10:
	.string	"*Keys2 Credits"
	.size	 k2creditsmenu,288
	.globl k2welcomemenu
	.section	".data"
	.align 2
	.type	 k2welcomemenu,@object
k2welcomemenu:
	.long .LC24
	.long 1
	.long 0
	.long 0
	.long .LC25
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC26
	.long 1
	.long 0
	.long 0
	.long .LC1
	.long 1
	.long 0
	.long 0
	.long .LC27
	.long 1
	.long 0
	.long 0
	.long 0
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
	.long .LC33
	.long 1
	.long 0
	.long 0
	.long .LC34
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC35
	.long 1
	.long 0
	.long K2ReturnToMain
	.section	".rodata"
	.align 2
.LC35:
	.string	"Go To Join Menu"
	.align 2
.LC34:
	.string	"motd7"
	.align 2
.LC33:
	.string	"motd6"
	.align 2
.LC32:
	.string	"motd5"
	.align 2
.LC31:
	.string	"motd4"
	.align 2
.LC30:
	.string	"motd3"
	.align 2
.LC29:
	.string	"motd2"
	.align 2
.LC28:
	.string	"motd1"
	.align 2
.LC27:
	.string	"*www.planetquake.com/keys2"
	.align 2
.LC26:
	.string	"*This server is running"
	.align 2
.LC25:
	.string	"mode"
	.align 2
.LC24:
	.string	"*Welcome to Keys2!"
	.size	 k2welcomemenu,256
	.globl k2helpmenu
	.section	".data"
	.align 2
	.type	 k2helpmenu,@object
k2helpmenu:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long .LC36
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
	.long .LC37
	.long 0
	.long 0
	.long K2_OpenKeysMenu
	.long .LC38
	.long 0
	.long 0
	.long K2_OpenWeaponsMenu
	.long .LC39
	.long 0
	.long 0
	.long K2_OpenCommandsMenu
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC6
	.long 0
	.long 0
	.long 0
	.long .LC7
	.long 0
	.long 0
	.long 0
	.long .LC23
	.long 0
	.long 0
	.long K2ReturnToMain
	.long 0
	.long 0
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC39:
	.string	"Client Commands"
	.align 2
.LC38:
	.string	"The Weapons"
	.align 2
.LC37:
	.string	"The Keys"
	.align 2
.LC36:
	.string	"*Keys2 Help Menu"
	.size	 k2helpmenu,208
	.globl k2keysmenu
	.section	".data"
	.align 2
	.type	 k2keysmenu,@object
k2keysmenu:
	.long .LC40
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
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
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC43
	.long 0
	.long 0
	.long 0
	.long .LC44
	.long 0
	.long 0
	.long 0
	.long .LC45
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC46
	.long 0
	.long 0
	.long 0
	.long .LC47
	.long 0
	.long 0
	.long 0
	.long .LC48
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC49
	.long 1
	.long 0
	.long K2_OpenKeysMenu2
	.long .LC50
	.long 1
	.long 0
	.long K2ReturnToHelp
	.long .LC23
	.long 1
	.long 0
	.long K2ReturnToMain
	.section	".rodata"
	.align 2
.LC50:
	.string	"Return to Help Menu"
	.align 2
.LC49:
	.string	"Next Page"
	.align 2
.LC48:
	.string	"times the normal damage"
	.align 2
.LC47:
	.string	"Weapons do three"
	.align 2
.LC46:
	.string	"*Infliction"
	.align 2
.LC45:
	.string	"times the normal rate"
	.align 2
.LC44:
	.string	"Weapons fire three"
	.align 2
.LC43:
	.string	"*Haste"
	.align 2
.LC42:
	.string	"Health/Armor Regenerate"
	.align 2
.LC41:
	.string	"*Regeneration"
	.align 2
.LC40:
	.string	"*Keys2 - The Keys"
	.size	 k2keysmenu,256
	.globl k2keysmenu2
	.section	".data"
	.align 2
	.type	 k2keysmenu2,@object
k2keysmenu2:
	.long .LC40
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC51
	.long 0
	.long 0
	.long 0
	.long .LC52
	.long 0
	.long 0
	.long 0
	.long .LC53
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC54
	.long 0
	.long 0
	.long 0
	.long .LC55
	.long 0
	.long 0
	.long 0
	.long .LC56
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC57
	.long 0
	.long 0
	.long 0
	.long .LC58
	.long 0
	.long 0
	.long 0
	.long .LC59
	.long 0
	.long 0
	.long 0
	.long .LC60
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC49
	.long 1
	.long 0
	.long K2_OpenKeysMenu3
	.long .LC50
	.long 1
	.long 0
	.long K2ReturnToHelp
	.long .LC23
	.long 1
	.long 0
	.long K2ReturnToMain
	.section	".rodata"
	.align 2
.LC60:
	.string	"Immune from Homing"
	.align 2
.LC59:
	.string	"Virtually Silent,"
	.align 2
.LC58:
	.string	"Virtually Invisible,"
	.align 2
.LC57:
	.string	"*Stealth"
	.align 2
.LC56:
	.string	"GibGun home in on targets"
	.align 2
.LC55:
	.string	"Rockets,Lasers,and"
	.align 2
.LC54:
	.string	"*Homing"
	.align 2
.LC53:
	.string	"the normal damage"
	.align 2
.LC52:
	.string	"You take only 1/4"
	.align 2
.LC51:
	.string	"*Futility"
	.size	 k2keysmenu2,288
	.globl k2keysmenu3
	.section	".data"
	.align 2
	.type	 k2keysmenu3,@object
k2keysmenu3:
	.long .LC40
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC61
	.long 0
	.long 0
	.long 0
	.long .LC62
	.long 0
	.long 0
	.long 0
	.long .LC63
	.long 0
	.long 0
	.long 0
	.long .LC64
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC65
	.long 0
	.long 0
	.long 0
	.long .LC66
	.long 0
	.long 0
	.long 0
	.long .LC67
	.long 0
	.long 0
	.long 0
	.long .LC68
	.long 0
	.long 0
	.long 0
	.long .LC69
	.long 0
	.long 0
	.long 0
	.long .LC70
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC50
	.long 1
	.long 0
	.long K2ReturnToHelp
	.long .LC23
	.long 1
	.long 0
	.long K2ReturnToMain
	.long 0
	.long 0
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC70:
	.string	"you hurt others"
	.align 2
.LC69:
	.string	"You get health when"
	.align 2
.LC68:
	.string	"Enemies feel your pain"
	.align 2
.LC67:
	.string	"Immune from Homing,"
	.align 2
.LC66:
	.string	"You can take someone's key"
	.align 2
.LC65:
	.string	"*AntiKey"
	.align 2
.LC64:
	.string	"and Futility"
	.align 2
.LC63:
	.string	"Haste,Infliction,Regen,"
	.align 2
.LC62:
	.string	"Combined powers of"
	.align 2
.LC61:
	.string	"*BFK"
	.size	 k2keysmenu3,272
	.globl k2weaponsmenu
	.section	".data"
	.align 2
	.type	 k2weaponsmenu,@object
k2weaponsmenu:
	.long .LC71
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC72
	.long 0
	.long 0
	.long 0
	.long .LC73
	.long 0
	.long 0
	.long 0
	.long .LC74
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long 0
	.long 0
	.long 0
	.long .LC76
	.long 0
	.long 0
	.long 0
	.long .LC77
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long 0
	.long 0
	.long 0
	.long .LC78
	.long 0
	.long 0
	.long 0
	.long .LC79
	.long 0
	.long 0
	.long 0
	.long .LC75
	.long 0
	.long 0
	.long 0
	.long .LC80
	.long 0
	.long 0
	.long 0
	.long .LC81
	.long 0
	.long 0
	.long 0
	.long .LC82
	.long 0
	.long 0
	.long 0
	.long .LC83
	.long 0
	.long 0
	.long 0
	.long .LC50
	.long 1
	.long 0
	.long K2ReturnToHelp
	.long .LC23
	.long 1
	.long 0
	.long K2ReturnToMain
	.section	".rodata"
	.align 2
.LC83:
	.string	"Launcher or drunk command"
	.align 2
.LC82:
	.string	"Toggle with Rocket"
	.align 2
.LC81:
	.string	"*Fire and Drunk Rockets"
	.align 2
.LC80:
	.string	"Launcher or freeze command"
	.align 2
.LC79:
	.string	"*Freeze Grenades"
	.align 2
.LC78:
	.string	"Launcher"
	.align 2
.LC77:
	.string	"*Fire Grenades"
	.align 2
.LC76:
	.string	"Launcher or flash command"
	.align 2
.LC75:
	.string	"Toggle with Grenade"
	.align 2
.LC74:
	.string	"*Flash Grenades"
	.align 2
.LC73:
	.string	"Toggle with Blaster"
	.align 2
.LC72:
	.string	"*Gibgun"
	.align 2
.LC71:
	.string	"*Keys2 - The Weapons"
	.size	 k2weaponsmenu,288
	.globl k2commandsmenu
	.section	".data"
	.align 2
	.type	 k2commandsmenu,@object
k2commandsmenu:
	.long .LC84
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC85
	.long 0
	.long 0
	.long 0
	.long .LC86
	.long 0
	.long 0
	.long 0
	.long .LC87
	.long 0
	.long 0
	.long 0
	.long .LC88
	.long 0
	.long 0
	.long 0
	.long .LC89
	.long 0
	.long 0
	.long 0
	.long .LC90
	.long 0
	.long 0
	.long 0
	.long .LC91
	.long 0
	.long 0
	.long 0
	.long .LC92
	.long 0
	.long 0
	.long 0
	.long .LC93
	.long 0
	.long 0
	.long 0
	.long .LC94
	.long 0
	.long 0
	.long 0
	.long .LC95
	.long 0
	.long 0
	.long 0
	.long .LC96
	.long 0
	.long 0
	.long 0
	.long .LC97
	.long 0
	.long 0
	.long 0
	.long .LC98
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC50
	.long 1
	.long 0
	.long K2ReturnToHelp
	.section	".rodata"
	.align 2
.LC98:
	.string	"Display Keys2 Help/Info"
	.align 2
.LC97:
	.string	"*keys2 help"
	.align 2
.LC96:
	.string	"Toggle player id"
	.align 2
.LC95:
	.string	"*id"
	.align 2
.LC94:
	.string	"Toggle flash handgrenades"
	.align 2
.LC93:
	.string	"*flash"
	.align 2
.LC92:
	.string	"Take someone's key"
	.align 2
.LC91:
	.string	"*take_key (or take)"
	.align 2
.LC90:
	.string	"Drop your current key"
	.align 2
.LC89:
	.string	"*drop key"
	.align 2
.LC88:
	.string	"Pretend to die"
	.align 2
.LC87:
	.string	"*+feign (or feign)"
	.align 2
.LC86:
	.string	"Grappling Hook"
	.align 2
.LC85:
	.string	"*+hook"
	.align 2
.LC84:
	.string	"*Keys2 - Client Commands"
	.size	 k2commandsmenu,288
	.align 2
.LC99:
	.string	"warning, ent already has a menu\n"
	.align 2
.LC100:
	.string	"warning:  ent has no menu\n"
	.align 2
.LC101:
	.string	"xv 32 yv 8 picn inventory "
	.align 2
.LC102:
	.string	"yv %d "
	.align 2
.LC103:
	.string	"xv %d "
	.align 2
.LC104:
	.string	"string2 \"\r%s\" "
	.align 2
.LC105:
	.string	"string2 \"%s\" "
	.align 2
.LC106:
	.string	"string \"%s\" "
	.section	".text"
	.align 2
	.globl K2Menu_Update
	.type	 K2Menu_Update,@function
K2Menu_Update:
	stwu 1,-1456(1)
	mflr 0
	stmw 24,1424(1)
	stw 0,1460(1)
	lwz 9,84(3)
	li 24,0
	lwz 27,3560(9)
	cmpwi 0,27,0
	bc 4,2,.L26
	lis 9,gi+4@ha
	lis 3,.LC100@ha
	lwz 0,gi+4@l(9)
	la 3,.LC100@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L25
.L26:
	lis 9,.LC101@ha
	addi 11,1,8
	lwz 4,.LC101@l(9)
	li 26,0
	mr 30,11
	la 9,.LC101@l(9)
	lwz 0,4(9)
	lbz 3,26(9)
	lwz 10,8(9)
	lwz 8,12(9)
	lwz 7,16(9)
	lwz 6,20(9)
	lhz 5,24(9)
	stw 4,8(1)
	stw 0,4(11)
	stw 10,8(11)
	stw 8,12(11)
	stw 7,16(11)
	stw 6,20(11)
	sth 5,24(11)
	stb 3,26(11)
	lwz 0,8(27)
	lwz 28,0(27)
	cmpw 0,26,0
	bc 4,0,.L28
	li 25,32
.L30:
	lwz 3,0(28)
	cmpwi 0,3,0
	bc 12,2,.L29
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L29
	cmpwi 0,0,42
	mr 31,3
	bc 4,2,.L33
	li 24,1
	addi 31,31,1
.L33:
	addi 3,1,8
	bl strlen
	lis 4,.LC102@ha
	add 3,30,3
	la 4,.LC102@l(4)
	mr 5,25
	crxor 6,6,6
	bl sprintf
	lwz 0,4(28)
	cmpwi 0,0,1
	bc 4,2,.L34
	mr 3,31
	bl strlen
	slwi 3,3,2
	subfic 29,3,162
	b .L35
.L34:
	cmpwi 0,0,2
	bc 4,2,.L36
	mr 3,31
	bl strlen
	slwi 3,3,3
	subfic 29,3,260
	b .L35
.L36:
	li 29,64
.L35:
	addi 3,1,8
	bl strlen
	lwz 5,4(27)
	lis 4,.LC103@ha
	add 3,30,3
	la 4,.LC103@l(4)
	xor 5,5,26
	subfic 0,5,0
	adde 5,0,5
	slwi 5,5,3
	subf 5,5,29
	crxor 6,6,6
	bl sprintf
	lwz 0,4(27)
	cmpw 0,0,26
	bc 4,2,.L38
	mr 3,30
	bl strlen
	lis 4,.LC104@ha
	mr 5,31
	la 4,.LC104@l(4)
	b .L43
.L38:
	cmpwi 0,24,0
	bc 12,2,.L40
	mr 3,30
	bl strlen
	lis 4,.LC105@ha
	mr 5,31
	la 4,.LC105@l(4)
.L43:
	add 3,30,3
	crxor 6,6,6
	bl sprintf
	b .L39
.L40:
	mr 3,30
	bl strlen
	lis 4,.LC106@ha
	mr 5,31
	la 4,.LC106@l(4)
	add 3,30,3
	crxor 6,6,6
	bl sprintf
.L39:
	li 24,0
.L29:
	lwz 0,8(27)
	addi 26,26,1
	addi 25,25,8
	addi 28,28,16
	cmpw 0,26,0
	bc 12,0,.L30
.L28:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	addi 3,1,8
	mtlr 0
	blrl
.L25:
	lwz 0,1460(1)
	mtlr 0
	lmw 24,1424(1)
	la 1,1456(1)
	blr
.Lfe1:
	.size	 K2Menu_Update,.Lfe1-K2Menu_Update
	.align 2
	.globl K2_OpenHelpMenu
	.type	 K2_OpenHelpMenu,@function
K2_OpenHelpMenu:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L79
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L79:
	lwz 11,84(31)
	lis 9,k2helpmenu@ha
	la 30,k2helpmenu@l(9)
	cmpwi 0,11,0
	bc 12,2,.L81
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L82
	lis 9,gi@ha
	lis 3,.LC99@ha
	la 9,gi@l(9)
	la 3,.LC99@l(3)
	lwz 0,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl K2Menu_Close
.L82:
	li 3,12
	bl malloc
	lwz 9,12(30)
	mr 10,3
	li 0,13
	stw 0,8(10)
	cmpwi 0,9,0
	stw 30,0(10)
	bc 4,2,.L84
	mr 9,30
	li 11,0
.L88:
	addi 11,11,1
	addi 9,9,16
	cmpwi 0,11,13
	bc 4,0,.L95
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 12,2,.L88
	b .L91
.L84:
	li 11,0
.L91:
	cmpwi 0,11,13
	bc 12,0,.L92
.L95:
	li 0,-1
	stw 0,4(10)
	b .L93
.L92:
	stw 11,4(10)
.L93:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3552(11)
	lwz 9,84(31)
	stw 0,3556(9)
	lwz 11,84(31)
	stw 10,3560(11)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L81:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 K2_OpenHelpMenu,.Lfe2-K2_OpenHelpMenu
	.align 2
	.globl K2_OpenKeysMenu
	.type	 K2_OpenKeysMenu,@function
K2_OpenKeysMenu:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L98
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L98:
	lwz 11,84(31)
	lis 9,k2keysmenu@ha
	la 30,k2keysmenu@l(9)
	cmpwi 0,11,0
	bc 12,2,.L100
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L101
	lis 9,gi@ha
	lis 3,.LC99@ha
	la 9,gi@l(9)
	la 3,.LC99@l(3)
	lwz 0,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl K2Menu_Close
.L101:
	li 3,12
	bl malloc
	lwz 9,12(30)
	mr 10,3
	li 0,16
	stw 0,8(10)
	cmpwi 0,9,0
	stw 30,0(10)
	bc 4,2,.L103
	mr 9,30
	li 11,0
.L107:
	addi 11,11,1
	addi 9,9,16
	cmpwi 0,11,16
	bc 4,0,.L114
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 12,2,.L107
	b .L110
.L103:
	li 11,0
.L110:
	cmpwi 0,11,16
	bc 12,0,.L111
.L114:
	li 0,-1
	stw 0,4(10)
	b .L112
.L111:
	stw 11,4(10)
.L112:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3552(11)
	lwz 9,84(31)
	stw 0,3556(9)
	lwz 11,84(31)
	stw 10,3560(11)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L100:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 K2_OpenKeysMenu,.Lfe3-K2_OpenKeysMenu
	.align 2
	.globl K2_OpenWeaponsMenu
	.type	 K2_OpenWeaponsMenu,@function
K2_OpenWeaponsMenu:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L117
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L117:
	lwz 11,84(31)
	lis 9,k2weaponsmenu@ha
	la 30,k2weaponsmenu@l(9)
	cmpwi 0,11,0
	bc 12,2,.L119
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L120
	lis 9,gi@ha
	lis 3,.LC99@ha
	la 9,gi@l(9)
	la 3,.LC99@l(3)
	lwz 0,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl K2Menu_Close
.L120:
	li 3,12
	bl malloc
	lwz 9,12(30)
	mr 10,3
	li 0,18
	stw 0,8(10)
	cmpwi 0,9,0
	stw 30,0(10)
	bc 4,2,.L122
	mr 9,30
	li 11,0
.L126:
	addi 11,11,1
	addi 9,9,16
	cmpwi 0,11,18
	bc 4,0,.L133
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 12,2,.L126
	b .L129
.L122:
	li 11,0
.L129:
	cmpwi 0,11,18
	bc 12,0,.L130
.L133:
	li 0,-1
	stw 0,4(10)
	b .L131
.L130:
	stw 11,4(10)
.L131:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3552(11)
	lwz 9,84(31)
	stw 0,3556(9)
	lwz 11,84(31)
	stw 10,3560(11)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L119:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 K2_OpenWeaponsMenu,.Lfe4-K2_OpenWeaponsMenu
	.align 2
	.globl K2_OpenCommandsMenu
	.type	 K2_OpenCommandsMenu,@function
K2_OpenCommandsMenu:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L136
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L136:
	lwz 11,84(31)
	lis 9,k2commandsmenu@ha
	la 30,k2commandsmenu@l(9)
	cmpwi 0,11,0
	bc 12,2,.L138
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L139
	lis 9,gi@ha
	lis 3,.LC99@ha
	la 9,gi@l(9)
	la 3,.LC99@l(3)
	lwz 0,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl K2Menu_Close
.L139:
	li 3,12
	bl malloc
	lwz 9,12(30)
	mr 10,3
	li 0,18
	stw 0,8(10)
	cmpwi 0,9,0
	stw 30,0(10)
	bc 4,2,.L141
	mr 9,30
	li 11,0
.L145:
	addi 11,11,1
	addi 9,9,16
	cmpwi 0,11,18
	bc 4,0,.L152
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 12,2,.L145
	b .L148
.L141:
	li 11,0
.L148:
	cmpwi 0,11,18
	bc 12,0,.L149
.L152:
	li 0,-1
	stw 0,4(10)
	b .L150
.L149:
	stw 11,4(10)
.L150:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3552(11)
	lwz 9,84(31)
	stw 0,3556(9)
	lwz 11,84(31)
	stw 10,3560(11)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L138:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 K2_OpenCommandsMenu,.Lfe5-K2_OpenCommandsMenu
	.align 2
	.globl K2_OpenKeysMenu2
	.type	 K2_OpenKeysMenu2,@function
K2_OpenKeysMenu2:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L155
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L155:
	lwz 11,84(31)
	lis 9,k2keysmenu2@ha
	la 30,k2keysmenu2@l(9)
	cmpwi 0,11,0
	bc 12,2,.L157
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L158
	lis 9,gi@ha
	lis 3,.LC99@ha
	la 9,gi@l(9)
	la 3,.LC99@l(3)
	lwz 0,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl K2Menu_Close
.L158:
	li 3,12
	bl malloc
	lwz 9,12(30)
	mr 10,3
	li 0,18
	stw 0,8(10)
	cmpwi 0,9,0
	stw 30,0(10)
	bc 4,2,.L160
	mr 9,30
	li 11,0
.L164:
	addi 11,11,1
	addi 9,9,16
	cmpwi 0,11,18
	bc 4,0,.L171
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 12,2,.L164
	b .L167
.L160:
	li 11,0
.L167:
	cmpwi 0,11,18
	bc 12,0,.L168
.L171:
	li 0,-1
	stw 0,4(10)
	b .L169
.L168:
	stw 11,4(10)
.L169:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3552(11)
	lwz 9,84(31)
	stw 0,3556(9)
	lwz 11,84(31)
	stw 10,3560(11)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L157:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 K2_OpenKeysMenu2,.Lfe6-K2_OpenKeysMenu2
	.align 2
	.globl K2_OpenKeysMenu3
	.type	 K2_OpenKeysMenu3,@function
K2_OpenKeysMenu3:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L174
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L174:
	lwz 11,84(31)
	lis 9,k2keysmenu3@ha
	la 30,k2keysmenu3@l(9)
	cmpwi 0,11,0
	bc 12,2,.L176
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L177
	lis 9,gi@ha
	lis 3,.LC99@ha
	la 9,gi@l(9)
	la 3,.LC99@l(3)
	lwz 0,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl K2Menu_Close
.L177:
	li 3,12
	bl malloc
	lwz 9,12(30)
	mr 10,3
	li 0,17
	stw 0,8(10)
	cmpwi 0,9,0
	stw 30,0(10)
	bc 4,2,.L179
	mr 9,30
	li 11,0
.L183:
	addi 11,11,1
	addi 9,9,16
	cmpwi 0,11,17
	bc 4,0,.L190
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 12,2,.L183
	b .L186
.L179:
	li 11,0
.L186:
	cmpwi 0,11,17
	bc 12,0,.L187
.L190:
	li 0,-1
	stw 0,4(10)
	b .L188
.L187:
	stw 11,4(10)
.L188:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3552(11)
	lwz 9,84(31)
	stw 0,3556(9)
	lwz 11,84(31)
	stw 10,3560(11)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L176:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 K2_OpenKeysMenu3,.Lfe7-K2_OpenKeysMenu3
	.section	".rodata"
	.align 2
.LC107:
	.string	"(CTF Mode)"
	.align 2
.LC108:
	.string	"(DM Mode)"
	.lcomm	levelname.60,32,4
	.align 2
.LC109:
	.string	"off"
	.align 2
.LC110:
	.string	"on"
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
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
	.section	".text"
	.align 2
	.globl K2Menu_Open
	.type	 K2Menu_Open,@function
K2Menu_Open:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 28,4
	lwz 9,84(31)
	mr 30,5
	mr 29,6
	cmpwi 0,9,0
	bc 12,2,.L9
	lwz 0,3560(9)
	cmpwi 0,0,0
	bc 12,2,.L11
	lis 9,gi@ha
	lis 3,.LC99@ha
	la 9,gi@l(9)
	la 3,.LC99@l(3)
	lwz 0,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl K2Menu_Close
.L11:
	li 3,12
	bl malloc
	cmpwi 0,30,0
	mr 10,3
	stw 28,0(10)
	stw 29,8(10)
	bc 12,0,.L13
	slwi 9,30,4
	add 9,9,28
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 4,2,.L12
.L13:
	li 5,0
	mr 4,28
	cmpw 0,5,29
	bc 4,0,.L203
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L20
.L16:
	addi 5,5,1
	addi 4,4,16
	cmpw 0,5,29
	bc 4,0,.L203
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 12,2,.L16
	b .L20
.L12:
	mr 5,30
.L20:
	cmpw 0,5,29
	bc 12,0,.L21
.L203:
	li 0,-1
	stw 0,4(10)
	b .L22
.L21:
	stw 5,4(10)
.L22:
	lwz 11,84(31)
	li 0,1
	mr 3,31
	stw 0,3552(11)
	lwz 9,84(31)
	stw 0,3556(9)
	lwz 11,84(31)
	stw 10,3560(11)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L9:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 K2Menu_Open,.Lfe8-K2Menu_Open
	.align 2
	.globl K2Menu_Close
	.type	 K2Menu_Close,@function
K2Menu_Close:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L23
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L23:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 K2Menu_Close,.Lfe9-K2Menu_Close
	.align 2
	.globl K2Menu_Next
	.type	 K2Menu_Next,@function
K2Menu_Next:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 10,3560(9)
	cmpwi 0,10,0
	bc 4,2,.L45
	lis 9,gi+4@ha
	lis 3,.LC100@ha
	lwz 0,gi+4@l(9)
	la 3,.LC100@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L44
.L45:
	lwz 9,4(10)
	cmpwi 0,9,0
	bc 12,0,.L44
	lwz 0,0(10)
	mr 11,9
	slwi 9,11,4
	lwz 7,8(10)
	mr 8,0
	add 9,0,9
.L52:
	addi 11,11,1
	addi 9,9,16
	cmpw 0,11,7
	bc 4,2,.L50
	li 11,0
	mr 9,8
.L50:
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 4,2,.L48
	lwz 0,4(10)
	cmpw 0,11,0
	bc 4,2,.L52
.L48:
	mr 3,31
	stw 11,4(10)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L44:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 K2Menu_Next,.Lfe10-K2Menu_Next
	.align 2
	.globl K2Menu_Prev
	.type	 K2Menu_Prev,@function
K2Menu_Prev:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 10,3560(9)
	cmpwi 0,10,0
	bc 4,2,.L54
	lis 9,gi+4@ha
	lis 3,.LC100@ha
	lwz 0,gi+4@l(9)
	la 3,.LC100@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L53
.L54:
	lwz 0,4(10)
	cmpwi 0,0,0
	bc 12,0,.L53
	mr 11,0
	lwz 0,0(10)
	slwi 9,11,4
	mr 8,0
	add 9,0,9
.L62:
	cmpwi 0,11,0
	bc 4,2,.L59
	lwz 9,8(10)
	addi 11,9,-1
	slwi 0,11,4
	add 9,8,0
	b .L60
.L59:
	addi 11,11,-1
	addi 9,9,-16
.L60:
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 4,2,.L57
	lwz 0,4(10)
	cmpw 0,11,0
	bc 4,2,.L62
.L57:
	mr 3,31
	stw 11,4(10)
	bl K2Menu_Update
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L53:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 K2Menu_Prev,.Lfe11-K2Menu_Prev
	.align 2
	.globl K2Menu_Select
	.type	 K2Menu_Select,@function
K2Menu_Select:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 9,3560(9)
	cmpwi 0,9,0
	bc 4,2,.L64
	lis 9,gi+4@ha
	lis 3,.LC100@ha
	lwz 0,gi+4@l(9)
	la 3,.LC100@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L63
.L64:
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,0,.L63
	lwz 9,0(9)
	slwi 0,0,4
	add 4,9,0
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 12,2,.L63
	mtlr 0
	blrl
.L63:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 K2Menu_Select,.Lfe12-K2Menu_Select
	.align 2
	.globl K2_OpenJoinMenu
	.type	 K2_OpenJoinMenu,@function
K2_OpenJoinMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl K2UpdateJoinMenu
	lis 4,k2joinmenu@ha
	mr 3,29
	la 4,k2joinmenu@l(4)
	li 5,0
	li 6,15
	bl K2Menu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 K2_OpenJoinMenu,.Lfe13-K2_OpenJoinMenu
	.align 2
	.globl K2Credits
	.type	 K2Credits,@function
K2Credits:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl K2Menu_Close
	lis 4,k2creditsmenu@ha
	mr 3,29
	la 4,k2creditsmenu@l(4)
	li 5,-1
	li 6,18
	bl K2Menu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 K2Credits,.Lfe14-K2Credits
	.section	".rodata"
	.align 2
.LC111:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2ReturnToMain
	.type	 K2ReturnToMain,@function
K2ReturnToMain:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L69
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L69:
	lwz 9,84(31)
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 4,2,.L67
	lis 9,.LC111@ha
	lis 11,ctf@ha
	la 9,.LC111@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L71
	mr 3,31
	bl CTFOpenJoinMenu
	b .L67
.L71:
	mr 3,31
	bl K2UpdateJoinMenu
	lis 4,k2joinmenu@ha
	mr 3,31
	la 4,k2joinmenu@l(4)
	li 5,0
	li 6,15
	bl K2Menu_Open
.L67:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 K2ReturnToMain,.Lfe15-K2ReturnToMain
	.align 2
	.globl K2ReturnToHelp
	.type	 K2ReturnToHelp,@function
K2ReturnToHelp:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 3,3560(9)
	cmpwi 0,3,0
	bc 12,2,.L76
	bl free
	lwz 9,84(31)
	li 0,0
	stw 0,3560(9)
	lwz 11,84(31)
	stw 0,3552(11)
.L76:
	mr 3,31
	mr 4,30
	bl K2_OpenHelpMenu
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 K2ReturnToHelp,.Lfe16-K2ReturnToHelp
	.align 2
	.globl K2UpdateJoinMenu
	.type	 K2UpdateJoinMenu,@function
K2UpdateJoinMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L195
	lis 9,k2joinmenu+80@ha
	li 0,0
	stw 0,k2joinmenu+80@l(9)
	b .L196
.L195:
	lis 9,.LC3@ha
	lis 11,k2joinmenu+80@ha
	la 9,.LC3@l(9)
	stw 9,k2joinmenu+80@l(11)
.L196:
	lis 9,g_edicts@ha
	lis 11,levelname.60@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.60@l(11)
	stb 0,levelname.60@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L197
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L198
.L197:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L198:
	lis 9,levelname.60@ha
	lis 11,k2joinmenu+32@ha
	la 9,levelname.60@l(9)
	li 0,0
	stw 9,k2joinmenu+32@l(11)
	li 3,1
	stb 0,31(9)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 K2UpdateJoinMenu,.Lfe17-K2UpdateJoinMenu
	.section	".rodata"
	.align 2
.LC112:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2UpdateWelcomeMenu
	.type	 K2UpdateWelcomeMenu,@function
K2UpdateWelcomeMenu:
	stwu 1,-32(1)
	stmw 28,16(1)
	lis 9,.LC112@ha
	lis 11,ctf@ha
	la 9,.LC112@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L192
	lis 9,.LC107@ha
	lis 11,k2welcomemenu+16@ha
	la 9,.LC107@l(9)
	b .L204
.L192:
	lis 9,.LC108@ha
	lis 11,k2welcomemenu+16@ha
	la 9,.LC108@l(9)
.L204:
	stw 9,k2welcomemenu+16@l(11)
	lis 9,motd1@ha
	lis 10,motd2@ha
	lwz 8,motd1@l(9)
	lis 11,k2welcomemenu@ha
	lis 6,motd4@ha
	lwz 5,motd2@l(10)
	lis 9,motd3@ha
	la 11,k2welcomemenu@l(11)
	lwz 10,4(8)
	lis 4,motd5@ha
	lis 29,motd6@ha
	lwz 7,motd3@l(9)
	lis 28,motd7@ha
	li 3,1
	stw 10,112(11)
	lwz 0,4(5)
	lwz 10,motd4@l(6)
	stw 0,128(11)
	lwz 9,4(7)
	lwz 8,motd5@l(4)
	stw 9,144(11)
	lwz 0,4(10)
	lwz 7,motd6@l(29)
	stw 0,160(11)
	lwz 9,4(8)
	lwz 10,motd7@l(28)
	stw 9,176(11)
	lwz 0,4(7)
	stw 0,192(11)
	lwz 9,4(10)
	stw 9,208(11)
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 K2UpdateWelcomeMenu,.Lfe18-K2UpdateWelcomeMenu
	.align 2
	.globl K2_OpenWelcomeMenu
	.type	 K2_OpenWelcomeMenu,@function
K2_OpenWelcomeMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl K2UpdateWelcomeMenu
	lis 4,k2welcomemenu@ha
	mr 3,29
	la 4,k2welcomemenu@l(4)
	li 5,0
	li 6,16
	bl K2Menu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 K2_OpenWelcomeMenu,.Lfe19-K2_OpenWelcomeMenu
	.align 2
	.globl K2MenuCameraCommand
	.type	 K2MenuCameraCommand,@function
K2MenuCameraCommand:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L200
	lis 4,.LC109@ha
	la 4,.LC109@l(4)
	crxor 6,6,6
	bl CameraCmd
	b .L201
.L200:
	lis 4,.LC110@ha
	la 4,.LC110@l(4)
	crxor 6,6,6
	bl CameraCmd
.L201:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 K2MenuCameraCommand,.Lfe20-K2MenuCameraCommand
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
