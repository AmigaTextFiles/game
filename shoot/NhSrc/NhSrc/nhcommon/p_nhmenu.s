	.file	"p_nhmenu.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.globl NHMenu
	.section	".data"
	.align 2
	.type	 NHMenu,@object
NHMenu:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC1
	.long 0
	.long 0
	.long ShowNHInfoMenu
	.long .LC2
	.long 0
	.long 0
	.long ShowNHHelpMenu
	.long .LC3
	.long 0
	.long 0
	.long ShowNHMOTD
	.long .LC4
	.long 0
	.long 0
	.long ShowNHModelsMenu
	.long .LC5
	.long 0
	.long 0
	.long ShowNHCreditsMenu
	.long .LC6
	.long 0
	.long 0
	.long ObserveGame
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC7
	.long 1
	.long 0
	.long 0
	.long .LC8
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC9
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
	.long 1
	.long 0
	.long 0
	.long .LC12
	.long 1
	.long 0
	.long 0
	.long .LC13
	.long 1
	.long 0
	.long 0
	.long .LC14
	.long 1
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC14:
	.string	"ESC closes menu"
	.align 2
.LC13:
	.string	"TAB key twice displays menu"
	.align 2
.LC12:
	.string	"ENTER key to select option"
	.align 2
.LC11:
	.string	"[ and ] to scroll up/down"
	.align 2
.LC10:
	.string	"*set default bindings"
	.align 2
.LC9:
	.string	"*Type SETUP at console to"
	.align 2
.LC8:
	.string	"*to Enter game"
	.align 2
.LC7:
	.string	"*Press your flashlight key"
	.align 2
.LC6:
	.string	"Spectator/chase mode"
	.align 2
.LC5:
	.string	"Credits"
	.align 2
.LC4:
	.string	"Models used"
	.align 2
.LC3:
	.string	"MOTD"
	.align 2
.LC2:
	.string	"Help/Bindings"
	.align 2
.LC1:
	.string	"Server Info"
	.align 2
.LC0:
	.string	"* Night Hunters 1.51"
	.size	 NHMenu,304
	.globl NHHelpMenu
	.section	".data"
	.align 2
	.type	 NHHelpMenu,@object
NHHelpMenu:
	.long .LC15
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC16
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC17
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC18
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC19
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC20
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
	.long .LC21
	.long 1
	.long 0
	.long ShowNHHelpMenu2
	.long 0
	.long 1
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC21:
	.string	"Next"
	.align 2
.LC20:
	.string	"to become the Predator"
	.align 2
.LC19:
	.string	"code named: Predator,"
	.align 2
.LC18:
	.string	"the Mutant-Marine,"
	.align 2
.LC17:
	.string	"you hunt"
	.align 2
.LC16:
	.string	"As Marine"
	.align 2
.LC15:
	.string	"*Help Menu - Page 1 of 5"
	.size	 NHHelpMenu,288
	.globl NHHelpMenu2
	.section	".data"
	.align 2
	.type	 NHHelpMenu2,@object
NHHelpMenu2:
	.long .LC22
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC23
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC24
	.long 1
	.long 0
	.long 0
	.long 0
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
	.long 0
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
	.long 0
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
	.long 1
	.long 0
	.long 0
	.long .LC21
	.long 1
	.long 0
	.long ShowNHHelpMenu3
	.long 0
	.long 1
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC28:
	.string	"for models used in game!"
	.align 2
.LC27:
	.string	"See the Models Used menu"
	.align 2
.LC26:
	.string	"other -Marines- !!!"
	.align 2
.LC25:
	.string	"or shoot"
	.align 2
.LC24:
	.string	"do NOT kill"
	.align 2
.LC23:
	.string	"If you are a Marine,"
	.align 2
.LC22:
	.string	"*Help Menu - Page 2 of 5"
	.size	 NHHelpMenu2,288
	.globl NHHelpMenu3
	.section	".data"
	.align 2
	.type	 NHHelpMenu3,@object
NHHelpMenu3:
	.long .LC29
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC30
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC31
	.long 0
	.long 0
	.long 0
	.long .LC32
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC33
	.long 0
	.long 0
	.long 0
	.long .LC34
	.long 0
	.long 0
	.long 0
	.long .LC35
	.long 0
	.long 0
	.long 0
	.long .LC36
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC37
	.long 0
	.long 0
	.long 0
	.long .LC38
	.long 0
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
	.long .LC21
	.long 1
	.long 0
	.long ShowNHHelpMenu4
	.long 0
	.long 1
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC38:
	.string	"*q report   (marine)"
	.align 2
.LC37:
	.string	"*f flare    (marine)"
	.align 2
.LC36:
	.string	"*r recall   (pred teleport)"
	.align 2
.LC35:
	.string	"*e anchor   (pred teleport)"
	.align 2
.LC34:
	.string	"*o overload (pred)"
	.align 2
.LC33:
	.string	"*v gunscope (pred)"
	.align 2
.LC32:
	.string	"*m menu"
	.align 2
.LC31:
	.string	"*g flashlight"
	.align 2
.LC30:
	.string	"Default bindings:"
	.align 2
.LC29:
	.string	"*Help Menu - Page 3 of 5"
	.size	 NHHelpMenu3,288
	.globl NHHelpMenu4
	.section	".data"
	.align 2
	.type	 NHHelpMenu4,@object
NHHelpMenu4:
	.long .LC39
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC40
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
	.long 1
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
	.long .LC49
	.long 0
	.long 0
	.long 0
	.long .LC50
	.long 0
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
	.long .LC21
	.long 1
	.long 0
	.long ShowNHHelpMenu5
	.long 0
	.long 1
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC50:
	.string	"bind q report"
	.align 2
.LC49:
	.string	"bind home gunscope"
	.align 2
.LC48:
	.string	"bind alt flare"
	.align 2
.LC47:
	.string	"bind kp_ins flashlight"
	.align 2
.LC46:
	.string	"bind kp_minus overload"
	.align 2
.LC45:
	.string	"key) and type:"
	.align 2
.LC44:
	.string	"(it's under the ESCape"
	.align 2
.LC43:
	.string	"hitting the ~ <tilde> key"
	.align 2
.LC42:
	.string	"the Quake2 console by"
	.align 2
.LC41:
	.string	"To bind your keys, open"
	.align 2
.LC40:
	.string	"For EXAMPLE:"
	.align 2
.LC39:
	.string	"*Help Menu - Page 4 of 5"
	.size	 NHHelpMenu4,288
	.globl NHHelpMenu5
	.section	".data"
	.align 2
	.type	 NHHelpMenu5,@object
NHHelpMenu5:
	.long .LC51
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC52
	.long 1
	.long 0
	.long 0
	.long .LC53
	.long 1
	.long 0
	.long 0
	.long .LC54
	.long 1
	.long 0
	.long 0
	.long .LC55
	.long 1
	.long 0
	.long 0
	.long .LC56
	.long 1
	.long 0
	.long 0
	.long .LC57
	.long 1
	.long 0
	.long 0
	.long .LC55
	.long 1
	.long 0
	.long 0
	.long .LC58
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC59
	.long 1
	.long 0
	.long 0
	.long .LC60
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
	.long .LC61
	.long 1
	.long 0
	.long ReturnToNHMainMenu
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC62
	.long 1
	.long 0
	.long SetupBindings
	.section	".rodata"
	.align 2
.LC62:
	.string	"SET BINDINGS"
	.align 2
.LC61:
	.string	"Back to Main Menu"
	.align 2
.LC60:
	.string	"*press your FLASHLIGHT key!!!"
	.align 2
.LC59:
	.string	"*To join the game"
	.align 2
.LC58:
	.string	"bind them yourself by hand"
	.align 2
.LC57:
	.string	"below"
	.align 2
.LC56:
	.string	"choose SET BINDINGS"
	.align 2
.LC55:
	.string	"*OR"
	.align 2
.LC54:
	.string	"bindings shown on page 3"
	.align 2
.LC53:
	.string	"console for the default"
	.align 2
.LC52:
	.string	"Type SETUP at the Quake2"
	.align 2
.LC51:
	.string	"*Help Menu - Page 5 of 5"
	.size	 NHHelpMenu5,288
	.globl NHAdminMenu
	.section	".data"
	.align 2
	.type	 NHAdminMenu,@object
NHAdminMenu:
	.long .LC63
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC64
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC65
	.long 1
	.long 0
	.long ReturnToNHMainMenu
	.section	".rodata"
	.align 2
.LC65:
	.string	"Back"
	.align 2
.LC64:
	.string	"Restricted access"
	.align 2
.LC63:
	.string	"*Admin Menu"
	.size	 NHAdminMenu,80
	.globl NHCreditsMenu
	.section	".data"
	.align 2
	.type	 NHCreditsMenu,@object
NHCreditsMenu:
	.long .LC66
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC67
	.long 1
	.long 0
	.long 0
	.long .LC68
	.long 1
	.long 0
	.long 0
	.long .LC69
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC67
	.long 1
	.long 0
	.long 0
	.long .LC70
	.long 1
	.long 0
	.long 0
	.long .LC71
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC72
	.long 1
	.long 0
	.long 0
	.long .LC73
	.long 1
	.long 0
	.long 0
	.long .LC74
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC75
	.long 1
	.long 0
	.long 0
	.long .LC76
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC77
	.long 1
	.long 0
	.long ShowNHCreditsMenu2
	.section	".rodata"
	.align 2
.LC77:
	.string	"More Credits"
	.align 2
.LC76:
	.string	"*Majoon"
	.align 2
.LC75:
	.string	"Original mod by"
	.align 2
.LC74:
	.string	"*batcat@fragit.net"
	.align 2
.LC73:
	.string	"*Dug Rodger"
	.align 2
.LC72:
	.string	"Instigator:"
	.align 2
.LC71:
	.string	"*batmax@fragit.net"
	.align 2
.LC70:
	.string	"*Alex Burger"
	.align 2
.LC69:
	.string	"*dingbat@fragit.net"
	.align 2
.LC68:
	.string	"*Bruce Rennie"
	.align 2
.LC67:
	.string	"Programmer:"
	.align 2
.LC66:
	.string	"*Credits"
	.size	 NHCreditsMenu,288
	.globl NHCreditsMenu2
	.section	".data"
	.align 2
	.type	 NHCreditsMenu2,@object
NHCreditsMenu2:
	.long .LC66
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC78
	.long 1
	.long 0
	.long 0
	.long .LC79
	.long 1
	.long 0
	.long 0
	.long .LC80
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC81
	.long 1
	.long 0
	.long 0
	.long .LC82
	.long 1
	.long 0
	.long 0
	.long .LC83
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC84
	.long 1
	.long 0
	.long 0
	.long .LC85
	.long 1
	.long 0
	.long 0
	.long .LC86
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC87
	.long 1
	.long 0
	.long 0
	.long .LC88
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC65
	.long 1
	.long 0
	.long ReturnToNHMainMenu
	.section	".rodata"
	.align 2
.LC88:
	.string	"/nighthunters"
	.align 2
.LC87:
	.string	"www.planetquake.com"
	.align 2
.LC86:
	.string	"*soulwound@hotmail.com"
	.align 2
.LC85:
	.string	"*Kyle Heitman (^^o^^ FaTaL)"
	.align 2
.LC84:
	.string	"NH Demo by:"
	.align 2
.LC83:
	.string	"*jdcooke@ionsys.com"
	.align 2
.LC82:
	.string	"*Joseph Cooke (Maru-Ki)"
	.align 2
.LC81:
	.string	"NH IR Model by:"
	.align 2
.LC80:
	.string	"*conan@aw.sgi.com"
	.align 2
.LC79:
	.string	"*Conan David Hunter"
	.align 2
.LC78:
	.string	"Predator Model by:"
	.size	 NHCreditsMenu2,288
	.align 2
.LC89:
	.string	"nhunters/info.txt"
	.align 2
.LC90:
	.string	"r"
	.section	".text"
	.align 2
	.globl ShowNHInfoMenu
	.type	 ShowNHInfoMenu,@function
ShowNHInfoMenu:
	stwu 1,-624(1)
	mflr 0
	stmw 27,604(1)
	stw 0,628(1)
	mr 27,3
	lis 4,.LC90@ha
	lis 3,.LC89@ha
	la 4,.LC90@l(4)
	la 3,.LC89@l(3)
	li 30,0
	bl fopen
	mr. 28,3
	bc 12,2,.L10
	addi 3,1,8
	li 4,500
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L11
	addi 31,1,520
	b .L12
.L14:
	mulli 29,30,50
	lis 9,infotext@ha
	mr 4,31
	la 9,infotext@l(9)
	add 29,29,9
	mr 3,29
	bl strcpy
	lis 9,NHInfoMenu@ha
	slwi 0,30,4
	la 9,NHInfoMenu@l(9)
	li 7,0
	stwx 29,9,0
	addi 10,9,12
	addi 8,9,4
	stwx 7,10,0
	li 11,1
	addi 9,9,8
	stwx 11,8,0
	addi 30,30,1
	stwx 7,9,0
.L12:
	mr 3,31
	li 4,80
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L11
	cmpwi 0,30,19
	bc 4,1,.L14
.L11:
	mr 3,28
	bl fclose
	b .L17
.L10:
	lis 9,NHInfoMenu@ha
	li 0,0
	la 9,NHInfoMenu@l(9)
	li 10,1
	addi 11,9,320
.L20:
	stw 0,0(9)
	stw 10,4(9)
	stw 0,8(9)
	stw 0,12(9)
	addi 9,9,16
	cmpw 0,9,11
	bc 4,1,.L20
	li 30,1
.L17:
	lis 9,.LC65@ha
	mulli 8,30,50
	lis 11,infotext@ha
	lwz 7,.LC65@l(9)
	la 11,infotext@l(11)
	lis 29,NHInfoMenu@ha
	la 9,.LC65@l(9)
	la 29,NHInfoMenu@l(29)
	lbz 4,4(9)
	slwi 0,30,4
	addi 5,29,4
	stwx 7,8,11
	addi 6,29,8
	li 9,0
	add 8,8,11
	li 7,1
	stb 4,4(8)
	lis 10,ReturnToNHMainMenu@ha
	addi 11,29,12
	stwx 7,5,0
	la 10,ReturnToNHMainMenu@l(10)
	mr 3,27
	stwx 9,6,0
	stwx 10,11,0
	stwx 8,29,0
	bl PMenu_Close
	mr 3,27
	mr 4,29
	li 5,-1
	li 6,20
	bl PMenu_Open
	lwz 0,628(1)
	mtlr 0
	lmw 27,604(1)
	la 1,624(1)
	blr
.Lfe1:
	.size	 ShowNHInfoMenu,.Lfe1-ShowNHInfoMenu
	.section	".rodata"
	.align 2
.LC91:
	.string	"*Models used"
	.align 2
.LC92:
	.string	" "
	.align 2
.LC93:
	.string	"Predator model is:"
	.align 2
.LC94:
	.string	"Marine model is:"
	.align 2
.LC95:
	.string	"Marines can choose any"
	.align 2
.LC96:
	.string	"model except for"
	.align 2
.LC97:
	.long 0x0
	.section	".text"
	.align 2
	.globl ShowNHModelsMenu
	.type	 ShowNHModelsMenu,@function
ShowNHModelsMenu:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,NHModelsMenu@ha
	lis 11,.LC91@ha
	la 31,NHModelsMenu@l(9)
	li 8,0
	la 11,.LC91@l(11)
	addi 30,31,12
	stwx 11,31,8
	addi 28,31,4
	li 26,1
	stwx 8,30,8
	addi 27,31,8
	li 29,0
	stwx 26,28,8
	li 0,16
	lis 9,.LC92@ha
	stwx 8,27,8
	la 25,.LC92@l(9)
	lis 10,.LC93@ha
	stwx 29,30,0
	li 8,1
	li 9,32
	stwx 8,28,0
	la 10,.LC93@l(10)
	li 11,48
	stwx 10,31,9
	mr 24,3
	stwx 29,30,9
	stwx 29,30,11
	stwx 25,31,0
	stwx 29,27,0
	stwx 26,28,9
	stwx 29,27,9
	stwx 25,31,11
	stwx 26,28,11
	stwx 29,27,11
	bl getPredatorModel
	bl strdup
	lis 11,marine_allow_custom@ha
	li 0,64
	lwz 10,marine_allow_custom@l(11)
	li 9,80
	stwx 3,31,0
	lis 11,.LC97@ha
	stwx 29,30,0
	la 11,.LC97@l(11)
	stwx 29,30,9
	stwx 26,28,0
	stwx 29,27,0
	stwx 25,31,9
	stwx 26,28,9
	stwx 29,27,9
	lfs 13,0(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L30
	li 0,96
	lis 9,.LC94@ha
	stwx 29,30,0
	la 9,.LC94@l(9)
	li 11,112
	stwx 9,31,0
	stwx 25,31,11
	stwx 29,30,11
	stwx 26,28,0
	stwx 29,27,0
	stwx 26,28,11
	stwx 29,27,11
	bl getMarineModel
	b .L32
.L30:
	lis 9,.LC95@ha
	li 0,96
	la 9,.LC95@l(9)
	lis 10,.LC96@ha
	stwx 9,31,0
	li 11,112
	la 10,.LC96@l(10)
	stwx 29,30,0
	stwx 10,31,11
	stwx 29,30,11
	stwx 26,28,0
	stwx 29,27,0
	stwx 26,28,11
	stwx 29,27,11
	bl getPredatorModel
.L32:
	bl strdup
	li 0,128
	li 8,9
	stwx 29,30,0
	stwx 3,31,0
	stwx 26,28,0
	stwx 29,27,0
	lis 29,NHModelsMenu@ha
	lis 9,.LC92@ha
	la 29,NHModelsMenu@l(29)
	slwi 10,8,4
	la 9,.LC92@l(9)
	addi 4,29,4
	stwx 9,29,10
	li 5,1
	li 8,0
	stwx 5,4,10
	addi 7,29,12
	addi 6,29,8
	stwx 8,7,10
	lis 9,ReturnToNHMainMenu@ha
	li 0,160
	stwx 8,6,10
	la 9,ReturnToNHMainMenu@l(9)
	lis 11,.LC65@ha
	stwx 9,7,0
	la 11,.LC65@l(11)
	mr 3,24
	stwx 5,4,0
	stwx 8,6,0
	stwx 11,29,0
	bl PMenu_Close
	mr 3,24
	mr 4,29
	li 5,-1
	li 6,20
	bl PMenu_Open
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ShowNHModelsMenu,.Lfe2-ShowNHModelsMenu
	.section	".rodata"
	.align 2
.LC98:
	.string	"spectator 1\n"
	.align 2
.LC99:
	.string	"Stuffing gl_dynamic settings.\n"
	.align 2
.LC100:
	.string	"set gl_dynamic 1; set sw_drawflat 0\n"
	.comm	showscores,4,4
	.section	".text"
	.align 2
	.globl ShowNHMenu
	.type	 ShowNHMenu,@function
ShowNHMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 11,3856(9)
	cmpwi 0,11,0
	bc 12,2,.L7
	bl PMenu_Close
	b .L6
.L7:
	lwz 0,3516(9)
	cmpwi 0,0,0
	bc 12,2,.L8
	stw 11,3516(9)
.L8:
	mr 3,31
	bl PMenu_Close
	lis 4,NHMenu@ha
	mr 3,31
	la 4,NHMenu@l(4)
	li 5,-1
	li 6,19
	bl PMenu_Open
.L6:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 ShowNHMenu,.Lfe3-ShowNHMenu
	.align 2
	.globl NHStartClient
	.type	 NHStartClient,@function
NHStartClient:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,1
	lis 4,.LC98@ha
	stw 28,916(29)
	la 4,.LC98@l(4)
	bl stuffcmd
	stw 28,932(29)
	mr 3,29
	crxor 6,6,6
	bl spectator_respawn
	lwz 4,84(29)
	li 0,0
	mr 3,29
	stw 0,948(29)
	addi 4,4,188
	stw 0,900(29)
	stw 28,928(29)
	bl checkMarineSkin
	lis 9,gi+4@ha
	lis 3,.LC99@ha
	lwz 0,gi+4@l(9)
	la 3,.LC99@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC100@ha
	mr 3,29
	la 4,.LC100@l(4)
	bl stuffcmd
	li 3,1
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 NHStartClient,.Lfe4-NHStartClient
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.align 2
	.globl ShowNHHelpMenu
	.type	 ShowNHHelpMenu,@function
ShowNHHelpMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHHelpMenu@ha
	mr 3,29
	la 4,NHHelpMenu@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 ShowNHHelpMenu,.Lfe5-ShowNHHelpMenu
	.align 2
	.globl ShowNHHelpMenu2
	.type	 ShowNHHelpMenu2,@function
ShowNHHelpMenu2:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHHelpMenu2@ha
	mr 3,29
	la 4,NHHelpMenu2@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 ShowNHHelpMenu2,.Lfe6-ShowNHHelpMenu2
	.align 2
	.globl ShowNHHelpMenu3
	.type	 ShowNHHelpMenu3,@function
ShowNHHelpMenu3:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHHelpMenu3@ha
	mr 3,29
	la 4,NHHelpMenu3@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 ShowNHHelpMenu3,.Lfe7-ShowNHHelpMenu3
	.align 2
	.globl ShowNHHelpMenu4
	.type	 ShowNHHelpMenu4,@function
ShowNHHelpMenu4:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHHelpMenu4@ha
	mr 3,29
	la 4,NHHelpMenu4@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 ShowNHHelpMenu4,.Lfe8-ShowNHHelpMenu4
	.align 2
	.globl ShowNHHelpMenu5
	.type	 ShowNHHelpMenu5,@function
ShowNHHelpMenu5:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHHelpMenu5@ha
	mr 3,29
	la 4,NHHelpMenu5@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 ShowNHHelpMenu5,.Lfe9-ShowNHHelpMenu5
	.align 2
	.globl ShowNHAdminMenu
	.type	 ShowNHAdminMenu,@function
ShowNHAdminMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHAdminMenu@ha
	mr 3,29
	la 4,NHAdminMenu@l(4)
	li 5,-1
	li 6,5
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 ShowNHAdminMenu,.Lfe10-ShowNHAdminMenu
	.align 2
	.globl ShowNHMOTD
	.type	 ShowNHMOTD,@function
ShowNHMOTD:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl ShowMOTD
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 ShowNHMOTD,.Lfe11-ShowNHMOTD
	.align 2
	.globl ShowNHCreditsMenu
	.type	 ShowNHCreditsMenu,@function
ShowNHCreditsMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHCreditsMenu@ha
	mr 3,29
	la 4,NHCreditsMenu@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ShowNHCreditsMenu,.Lfe12-ShowNHCreditsMenu
	.align 2
	.globl ShowNHCreditsMenu2
	.type	 ShowNHCreditsMenu2,@function
ShowNHCreditsMenu2:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHCreditsMenu2@ha
	mr 3,29
	la 4,NHCreditsMenu2@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 ShowNHCreditsMenu2,.Lfe13-ShowNHCreditsMenu2
	.align 2
	.globl ReturnToNHMainMenu
	.type	 ReturnToNHMainMenu,@function
ReturnToNHMainMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,NHMenu@ha
	mr 3,29
	la 4,NHMenu@l(4)
	li 5,-1
	li 6,19
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ReturnToNHMainMenu,.Lfe14-ReturnToNHMainMenu
	.align 2
	.globl CloseNHMenu
	.type	 CloseNHMenu,@function
CloseNHMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl PMenu_Close
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 CloseNHMenu,.Lfe15-CloseNHMenu
	.align 2
	.globl EnterGame
	.type	 EnterGame,@function
EnterGame:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,932(31)
	cmpwi 0,0,0
	bc 12,2,.L40
	bl PMenu_Close
	mr 3,31
	bl Start_Play_f
.L40:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 EnterGame,.Lfe16-EnterGame
	.align 2
	.globl ObserveGame
	.type	 ObserveGame,@function
ObserveGame:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl ClearFlashlight
	mr 3,29
	bl clearSafetyMode
	mr 3,29
	bl Cmd_Observe_f
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 ObserveGame,.Lfe17-ObserveGame
	.align 2
	.globl SetupBindings
	.type	 SetupBindings,@function
SetupBindings:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	crxor 6,6,6
	bl Cmd_Setup_f
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 SetupBindings,.Lfe18-SetupBindings
	.comm	NHInfoMenu,320,4
	.comm	NHModelsMenu,320,4
	.comm	infotext,2500,1
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
