	.file	"g_faith.c"
gcc2_compiled.:
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
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
	.long JoinSatan
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC3
	.long 0
	.long 0
	.long JoinGod
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC4
	.long 0
	.long 0
	.long 0
	.long .LC5
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
	.section	".rodata"
	.align 2
.LC7:
	.string	"(TAB to Return)"
	.align 2
.LC6:
	.string	"ESC to Exit Menu"
	.align 2
.LC5:
	.string	"ENTER to select"
	.align 2
.LC4:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC3:
	.string	"Join Christian Belief"
	.align 2
.LC2:
	.string	"Join Satanic Belief"
	.align 2
.LC1:
	.string	"*Faith Betrayer"
	.align 2
.LC0:
	.string	"*Quake II"
	.size	 joinmenu,192
	.align 2
.LC8:
	.string	"%s joined the legions of God\n"
	.align 2
.LC9:
	.string	"%s joined the minions of Satan\n"
	.align 2
.LC10:
	.string	"DEMON"
	.align 2
.LC11:
	.string	"DEVIL"
	.align 2
.LC12:
	.string	"HELL FIEND"
	.align 2
.LC13:
	.string	"SUCCUBUS"
	.align 2
.LC14:
	.string	"INCUBUS"
	.align 2
.LC15:
	.string	"LORD OF HELL"
	.align 2
.LC16:
	.string	"ARCHANGEL"
	.align 2
.LC17:
	.string	"VIRTUE"
	.align 2
.LC18:
	.string	"PRINCIPALITY"
	.align 2
.LC19:
	.string	"DOMINION"
	.align 2
.LC20:
	.string	"CHERUBUM"
	.align 2
.LC21:
	.string	"SERAPHIM"
	.align 2
.LC22:
	.string	"You are now a %s\n"
	.section	".text"
	.align 2
	.globl holylevel
	.type	 holylevel,@function
holylevel:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 0,0x6666
	lwz 8,84(31)
	ori 0,0,26215
	lwz 10,3448(8)
	mulhw 0,10,0
	srawi 11,10,31
	srawi 0,0,1
	subf 0,11,0
	slwi 9,0,2
	add 9,9,0
	cmpw 0,10,9
	bc 4,2,.L10
	cmpwi 0,10,30
	bc 12,1,.L10
	lwz 7,3464(8)
	cmpwi 0,7,1
	bc 4,2,.L11
	cmpwi 0,10,5
	bc 4,2,.L12
	lis 9,.LC10@ha
	la 11,.LC10@l(9)
	lwz 0,.LC10@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
	stw 7,3468(8)
.L12:
	lwz 7,84(31)
	lwz 0,3448(7)
	cmpwi 0,0,10
	bc 4,2,.L13
	lis 9,.LC11@ha
	li 8,2
	la 11,.LC11@l(9)
	lwz 0,.LC11@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
	stw 8,3468(7)
.L13:
	lwz 5,84(31)
	lwz 0,3448(5)
	cmpwi 0,0,15
	bc 4,2,.L14
	lis 9,.LC12@ha
	addi 11,1,8
	lwz 7,.LC12@l(9)
	li 6,3
	la 9,.LC12@l(9)
	lbz 0,10(9)
	lwz 10,4(9)
	lhz 8,8(9)
	stw 7,8(1)
	stb 0,10(11)
	stw 10,4(11)
	sth 8,8(11)
	stw 6,3468(5)
.L14:
	lwz 6,84(31)
	lwz 0,3448(6)
	cmpwi 0,0,20
	bc 4,2,.L15
	lis 9,.LC13@ha
	addi 8,1,8
	lwz 10,.LC13@l(9)
	li 7,4
	la 9,.LC13@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
	stw 7,3468(6)
.L15:
	lwz 7,84(31)
	lwz 0,3448(7)
	cmpwi 0,0,25
	bc 4,2,.L16
	lis 9,.LC14@ha
	li 8,5
	la 11,.LC14@l(9)
	lwz 0,.LC14@l(9)
	lwz 10,4(11)
	stw 0,8(1)
	stw 10,12(1)
	stw 8,3468(7)
.L16:
	lwz 5,84(31)
	lwz 0,3448(5)
	cmpwi 0,0,30
	bc 4,2,.L11
	lis 9,.LC15@ha
	addi 11,1,8
	lwz 7,.LC15@l(9)
	li 6,6
	la 9,.LC15@l(9)
	lbz 0,12(9)
	lwz 10,4(9)
	lwz 8,8(9)
	stw 7,8(1)
	stb 0,12(11)
	stw 10,4(11)
	stw 8,8(11)
	stw 6,3468(5)
.L11:
	lwz 6,84(31)
	lwz 0,3464(6)
	cmpwi 0,0,0
	bc 4,2,.L18
	lwz 0,3448(6)
	cmpwi 0,0,5
	bc 4,2,.L19
	lis 9,.LC16@ha
	addi 8,1,8
	lwz 10,.LC16@l(9)
	li 7,1
	la 9,.LC16@l(9)
	lhz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	sth 0,8(8)
	stw 11,4(8)
	stw 7,3468(6)
.L19:
	lwz 6,84(31)
	lwz 0,3448(6)
	cmpwi 0,0,10
	bc 4,2,.L20
	lis 9,.LC17@ha
	addi 8,1,8
	lwz 10,.LC17@l(9)
	li 7,2
	la 9,.LC17@l(9)
	lbz 0,6(9)
	lhz 11,4(9)
	stw 10,8(1)
	stb 0,6(8)
	sth 11,4(8)
	stw 7,3468(6)
.L20:
	lwz 5,84(31)
	lwz 0,3448(5)
	cmpwi 0,0,15
	bc 4,2,.L21
	lis 9,.LC18@ha
	addi 11,1,8
	lwz 7,.LC18@l(9)
	li 6,3
	la 9,.LC18@l(9)
	lbz 0,12(9)
	lwz 10,4(9)
	lwz 8,8(9)
	stw 7,8(1)
	stb 0,12(11)
	stw 10,4(11)
	stw 8,8(11)
	stw 6,3468(5)
.L21:
	lwz 6,84(31)
	lwz 0,3448(6)
	cmpwi 0,0,20
	bc 4,2,.L22
	lis 9,.LC19@ha
	addi 8,1,8
	lwz 10,.LC19@l(9)
	li 7,4
	la 9,.LC19@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
	stw 7,3468(6)
.L22:
	lwz 6,84(31)
	lwz 0,3448(6)
	cmpwi 0,0,25
	bc 4,2,.L23
	lis 9,.LC20@ha
	addi 8,1,8
	lwz 10,.LC20@l(9)
	li 7,5
	la 9,.LC20@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
	stw 7,3468(6)
.L23:
	lwz 6,84(31)
	lwz 0,3448(6)
	cmpwi 0,0,30
	bc 4,2,.L18
	lis 9,.LC21@ha
	addi 8,1,8
	lwz 10,.LC21@l(9)
	li 7,6
	la 9,.LC21@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
	stw 7,3468(6)
.L18:
	lis 9,gi+12@ha
	lis 4,.LC22@ha
	lwz 0,gi+12@l(9)
	la 4,.LC22@l(4)
	mr 3,31
	addi 5,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L10:
	lwz 11,84(31)
	lwz 9,3472(11)
	addi 9,9,1
	stw 9,3472(11)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 holylevel,.Lfe1-holylevel
	.globl RedMenu
	.section	".data"
	.align 2
	.type	 RedMenu,@object
RedMenu:
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
	.long .LC23
	.long 0
	.long 0
	.long SpellOne
	.long .LC24
	.long 0
	.long 0
	.long SpellTwo
	.long .LC25
	.long 0
	.long 0
	.long SpellThree
	.long .LC26
	.long 0
	.long 0
	.long SpellFour
	.long .LC27
	.long 0
	.long 0
	.long SpellFive
	.long .LC28
	.long 0
	.long 0
	.long SpellSix
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC4
	.long 0
	.long 0
	.long 0
	.long .LC5
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
	.section	".rodata"
	.align 2
.LC28:
	.string	"Cast Summon Hellspawn"
	.align 2
.LC27:
	.string	"Cast Wrath of Satan"
	.align 2
.LC26:
	.string	"Cast Vampiric Nature"
	.align 2
.LC25:
	.string	"Cast Shockwave"
	.align 2
.LC24:
	.string	"Cast Unholy Darkness"
	.align 2
.LC23:
	.string	"Cast Dark Energy"
	.size	 RedMenu,224
	.globl BlueMenu
	.section	".data"
	.align 2
	.type	 BlueMenu,@object
BlueMenu:
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
	.long .LC29
	.long 0
	.long 0
	.long SpellOne
	.long .LC30
	.long 0
	.long 0
	.long SpellTwo
	.long .LC31
	.long 0
	.long 0
	.long SpellThree
	.long .LC32
	.long 0
	.long 0
	.long SpellFour
	.long .LC33
	.long 0
	.long 0
	.long SpellFive
	.long .LC34
	.long 0
	.long 0
	.long SpellSix
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC4
	.long 0
	.long 0
	.long 0
	.long .LC5
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
	.section	".rodata"
	.align 2
.LC34:
	.string	"Cast Eyes of Justice"
	.align 2
.LC33:
	.string	"Cast Starburst"
	.align 2
.LC32:
	.string	"Cast Life Well"
	.align 2
.LC31:
	.string	"Cast Gift of God"
	.align 2
.LC30:
	.string	"Cast Light of Faith"
	.align 2
.LC29:
	.string	"Cast Prayer Heal"
	.size	 BlueMenu,224
	.align 2
.LC35:
	.string	"You do not know this spell\nlevel %s.\n"
	.align 2
.LC36:
	.string	"You do not have enough mana %s.\n"
	.align 2
.LC37:
	.string	"misc/tele_up.wav"
	.align 2
.LC38:
	.string	"items/m_health.wav"
	.align 2
.LC39:
	.long 0x3f800000
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpellOne
	.type	 SpellOne,@function
SpellOne:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl PMenu_Close
	lwz 5,84(31)
	lwz 0,3468(5)
	cmpwi 0,0,0
	bc 12,1,.L29
	lis 9,gi+12@ha
	lis 4,.LC35@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC35@l(4)
	b .L33
.L29:
	lwz 9,3472(5)
	cmpwi 0,9,0
	bc 4,2,.L30
	lis 9,gi+12@ha
	lis 4,.LC36@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC36@l(4)
.L33:
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L28
.L30:
	lwz 11,3464(5)
	cmpwi 0,11,1
	bc 4,2,.L31
	addi 0,9,-1
	lis 29,gi@ha
	stw 0,3472(5)
	la 29,gi@l(29)
	lis 3,.LC37@ha
	lwz 9,84(31)
	la 3,.LC37@l(3)
	stw 11,3520(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC39@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC39@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 2,0(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 3,0(9)
	blrl
	b .L28
.L31:
	addi 0,9,-1
	lis 29,gi@ha
	stw 0,3472(5)
	la 29,gi@l(29)
	lis 3,.LC38@ha
	lwz 0,484(31)
	la 3,.LC38@l(3)
	stw 0,480(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC39@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC39@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 2,0(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 3,0(9)
	blrl
.L28:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 SpellOne,.Lfe2-SpellOne
	.section	".rodata"
	.align 2
.LC41:
	.string	"weapons/Bfg__x1b.wav"
	.align 2
.LC42:
	.string	"tank/thud.wav"
	.align 2
.LC43:
	.string	"world/lite_on3.wav"
	.align 2
.LC44:
	.long 0x3f800000
	.align 2
.LC45:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpellThree
	.type	 SpellThree,@function
SpellThree:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl PMenu_Close
	lwz 5,84(31)
	lwz 0,3468(5)
	cmpwi 0,0,2
	bc 12,1,.L38
	lis 9,gi+12@ha
	lis 4,.LC35@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC35@l(4)
	b .L42
.L38:
	lwz 0,3472(5)
	cmpwi 0,0,0
	bc 4,2,.L39
	lis 9,gi+12@ha
	lis 4,.LC36@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC36@l(4)
.L42:
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L37
.L39:
	lwz 0,3464(5)
	cmpwi 0,0,1
	bc 4,2,.L40
	mr 3,31
	bl Shockwave
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	b .L43
.L40:
	mr 3,31
	bl RandomPowerUp
	lis 29,gi@ha
	lis 3,.LC43@ha
	la 29,gi@l(29)
	la 3,.LC43@l(3)
.L43:
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC44@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC44@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 2,0(9)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(31)
	lwz 9,3472(11)
	addi 9,9,-1
	stw 9,3472(11)
.L37:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SpellThree,.Lfe3-SpellThree
	.section	".rodata"
	.align 2
.LC46:
	.string	"world/lite_out.wav"
	.align 2
.LC47:
	.string	"world/airhiss2.wav"
	.align 2
.LC48:
	.long 0x3f800000
	.align 2
.LC49:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpellFour
	.type	 SpellFour,@function
SpellFour:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl PMenu_Close
	lwz 5,84(31)
	lwz 0,3468(5)
	cmpwi 0,0,3
	bc 12,1,.L45
	lis 9,gi+12@ha
	lis 4,.LC35@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC35@l(4)
	b .L49
.L45:
	lwz 0,3472(5)
	cmpwi 0,0,0
	bc 4,2,.L46
	lis 9,gi+12@ha
	lis 4,.LC36@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC36@l(4)
.L49:
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L44
.L46:
	lwz 0,3464(5)
	cmpwi 0,0,0
	bc 4,2,.L47
	mr 3,31
	bl Lightning
	lwz 11,84(31)
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	lwz 9,3472(11)
	addi 9,9,-1
	stw 9,3472(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC48@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC48@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 2,0(9)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 3,0(9)
	blrl
	b .L44
.L47:
	mr 3,31
	bl Vampire
	lwz 11,84(31)
	lis 29,gi@ha
	lis 3,.LC47@ha
	la 29,gi@l(29)
	la 3,.LC47@l(3)
	lwz 9,3472(11)
	addi 9,9,-1
	stw 9,3472(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC48@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC48@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 2,0(9)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 3,0(9)
	blrl
.L44:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 SpellFour,.Lfe4-SpellFour
	.section	".rodata"
	.align 2
.LC51:
	.string	"You are blinded by a spell!!!\n"
	.align 2
.LC52:
	.string	"%s is blinded by your spell!\n"
	.align 3
.LC50:
	.long 0x4052c000
	.long 0x0
	.align 2
.LC53:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl Flash_Explode
	.type	 Flash_Explode,@function
Flash_Explode:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 31,0
	b .L61
.L63:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L61
	mr 3,28
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L61
	mr 3,31
	mr 4,28
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L61
	lwz 9,84(28)
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 4,2,.L67
	lwz 9,84(31)
	b .L70
.L67:
	lwz 9,84(31)
	li 0,0
.L70:
	stw 0,3836(9)
	lwz 11,84(31)
	lis 9,.LC50@ha
	lis 0,0x4248
	lfd 13,.LC50@l(9)
	lis 29,gi@ha
	lis 5,.LC51@ha
	lfs 0,3828(11)
	la 29,gi@l(29)
	la 5,.LC51@l(5)
	mr 3,31
	li 4,2
	fadd 0,0,13
	frsp 0,0
	stfs 0,3828(11)
	lwz 9,84(31)
	stw 0,3832(9)
	lwz 9,8(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 6,84(31)
	lis 5,.LC52@ha
	li 4,2
	lwz 0,8(29)
	la 5,.LC52@l(5)
	addi 6,6,700
	lwz 3,256(28)
	mtlr 0
	crxor 6,6,6
	blrl
.L61:
	lis 9,.LC53@ha
	addi 30,28,4
	la 9,.LC53@l(9)
	mr 3,31
	lfs 1,0(9)
	mr 4,30
	bl findradius
	mr. 31,3
	bc 4,2,.L63
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,21
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Flash_Explode,.Lfe5-Flash_Explode
	.section	".rodata"
	.align 2
.LC56:
	.string	"Quad Damage"
	.align 2
.LC58:
	.string	"Invulnerability"
	.align 2
.LC59:
	.string	"BFG10K"
	.align 2
.LC54:
	.long 0x46fffe00
	.align 3
.LC55:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC57:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 3
.LC60:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl RandomPowerUp
	.type	 RandomPowerUp,@function
RandomPowerUp:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC60@ha
	lis 10,.LC54@ha
	la 11,.LC60@l(11)
	stw 0,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC55@ha
	lfs 11,.LC54@l(10)
	lfd 13,.LC55@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L72
	lis 3,.LC56@ha
	la 3,.LC56@l(3)
	b .L76
.L72:
	lis 9,.LC57@ha
	lfd 0,.LC57@l(9)
	fcmpu 0,12,0
	bc 4,0,.L74
	lis 3,.LC58@ha
	la 3,.LC58@l(3)
	b .L76
.L74:
	lis 3,.LC59@ha
	la 3,.LC59@l(3)
.L76:
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	li 10,1
	srawi 3,3,2
	slwi 0,3,2
	stwx 10,11,0
	lwz 9,84(31)
	stw 3,736(9)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 RandomPowerUp,.Lfe6-RandomPowerUp
	.section	".rodata"
	.align 2
.LC61:
	.long 0x46fffe00
	.align 3
.LC62:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC63:
	.long 0x42c80000
	.align 2
.LC64:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl ShockwaveExplode
	.type	 ShockwaveExplode,@function
ShockwaveExplode:
	stwu 1,-128(1)
	mflr 0
	stfd 27,88(1)
	stfd 28,96(1)
	stfd 29,104(1)
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 26,64(1)
	stw 0,132(1)
	lis 9,.LC61@ha
	mr 30,3
	lfs 27,.LC61@l(9)
	lis 11,gi@ha
	addi 26,30,4
	lis 9,.LC62@ha
	la 29,gi@l(11)
	la 9,.LC62@l(9)
	li 31,0
	lfd 29,0(9)
	addi 27,1,32
	lis 28,0x4330
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 28,0(9)
.L81:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,60(1)
	stw 28,56(1)
	lfd 0,56(1)
	fsub 0,0,29
	frsp 0,0
	fdivs 30,0,27
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,60(1)
	stw 28,56(1)
	lfd 0,56(1)
	fsub 0,0,29
	fmuls 30,30,28
	frsp 0,0
	fdivs 31,0,27
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	li 3,3
	stw 0,60(1)
	stw 28,56(1)
	andi. 0,31,1
	lfd 0,56(1)
	addi 31,31,1
	fsub 0,0,29
	fmuls 31,31,28
	frsp 0,0
	fdivs 11,0,27
	fmuls 11,11,28
	bc 4,2,.L82
	fneg 30,30
	fneg 31,31
	fneg 11,11
.L82:
	lfs 0,4(30)
	lfs 12,8(30)
	lfs 13,12(30)
	fadds 30,30,0
	lwz 9,100(29)
	fadds 31,31,12
	fadds 11,11,13
	mtlr 9
	stfs 30,32(1)
	stfs 31,36(1)
	stfs 11,40(1)
	blrl
	lwz 9,100(29)
	li 3,7
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,88(29)
	addi 3,30,4
	li 4,1
	mtlr 9
	blrl
	cmpwi 0,31,5
	bc 4,1,.L81
	li 31,0
	li 27,4
	li 28,0
	lis 29,vec3_origin@ha
	b .L84
.L86:
	lwz 0,512(31)
	li 10,1
	cmpwi 0,0,0
	bc 12,2,.L84
	lfs 0,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 0,8(31)
	fsubs 12,12,0
	stfs 12,20(1)
	lfs 0,12(31)
	stw 27,8(1)
	stw 28,12(1)
	fsubs 11,11,0
	stfs 11,24(1)
	bl T_Damage
.L84:
	lis 9,.LC64@ha
	mr 3,31
	la 9,.LC64@l(9)
	mr 4,26
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	mr 4,30
	mr 5,30
	addi 6,1,16
	la 8,vec3_origin@l(29)
	li 9,40
	mr 3,31
	addi 7,31,4
	bc 4,2,.L86
	lwz 0,132(1)
	mtlr 0
	lmw 26,64(1)
	lfd 27,88(1)
	lfd 28,96(1)
	lfd 29,104(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe7:
	.size	 ShockwaveExplode,.Lfe7-ShockwaveExplode
	.section	".rodata"
	.align 2
.LC67:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC69:
	.string	"models/objects/gibs/sm_metal/tris.md2"
	.align 2
.LC71:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl LightningExplode
	.type	 LightningExplode,@function
LightningExplode:
	stwu 1,-64(1)
	mflr 0
	stmw 26,40(1)
	stw 0,68(1)
	mr 30,3
	lis 9,gi@ha
	la 28,gi@l(9)
	addi 27,30,4
	li 31,0
	li 26,4
	b .L98
.L100:
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L98
	bl CanDamage
	addi 29,31,4
	cmpwi 0,3,0
	lis 8,vec3_origin@ha
	li 0,0
	la 8,vec3_origin@l(8)
	mr 5,30
	addi 6,1,16
	mr 7,29
	li 9,40
	li 10,1
	mr 3,31
	mr 4,30
	bc 12,2,.L98
	lfs 0,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 0,8(31)
	fsubs 12,12,0
	stfs 12,20(1)
	lfs 0,12(31)
	stw 0,12(1)
	stw 26,8(1)
	fsubs 11,11,0
	stfs 11,24(1)
	bl T_Damage
	lwz 9,100(28)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,19
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x8765
	lwz 10,104(28)
	lwz 3,g_edicts@l(9)
	ori 0,0,17185
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,120(28)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,88(28)
	mr 3,29
	li 4,2
	mtlr 9
	blrl
.L98:
	lis 9,.LC71@ha
	mr 3,31
	la 9,.LC71@l(9)
	mr 4,27
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	mr 3,30
	mr 4,31
	bc 4,2,.L100
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 LightningExplode,.Lfe8-LightningExplode
	.section	".rodata"
	.align 2
.LC72:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Vampire
	.type	 Vampire,@function
Vampire:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lis 9,gi@ha
	mr 31,3
	la 28,gi@l(9)
	li 30,0
	b .L105
.L107:
	bc 12,30,.L105
	lwz 0,512(30)
	mr 4,30
	mr 3,31
	cmpwi 0,0,0
	bc 12,2,.L105
	bl CanDamage
	addi 29,30,4
	cmpwi 0,3,0
	lis 8,vec3_origin@ha
	li 0,4
	li 11,0
	mr 4,31
	la 8,vec3_origin@l(8)
	mr 5,31
	addi 6,1,16
	mr 7,29
	li 9,30
	li 10,1
	mr 3,30
	bc 12,2,.L105
	lfs 0,4(30)
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 0,8(30)
	fsubs 12,12,0
	stfs 12,20(1)
	lfs 0,12(30)
	stw 0,8(1)
	stw 11,12(1)
	fsubs 11,11,0
	stfs 11,24(1)
	bl T_Damage
	lwz 11,484(31)
	li 3,3
	lwz 9,480(31)
	addi 0,11,-20
	cmpw 0,9,0
	addi 9,9,20
	bc 4,1,.L111
	stw 11,480(31)
	b .L112
.L111:
	stw 9,480(31)
.L112:
	lwz 9,100(28)
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,19
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x8765
	lwz 10,104(28)
	lwz 3,g_edicts@l(9)
	ori 0,0,17185
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,120(28)
	addi 3,31,4
	mtlr 9
	blrl
	lwz 9,120(28)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,88(28)
	mr 3,29
	li 4,2
	mtlr 9
	blrl
.L105:
	lis 9,.LC72@ha
	mr 3,30
	la 9,.LC72@l(9)
	addi 4,31,4
	lfs 1,0(9)
	bl findradius
	mr. 30,3
	cmpw 7,30,31
	bc 4,2,.L107
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 Vampire,.Lfe9-Vampire
	.section	".rodata"
	.align 2
.LC74:
	.string	"world/quake.wav"
	.align 2
.LC75:
	.long 0x46fffe00
	.align 3
.LC76:
	.long 0x4062c000
	.long 0x0
	.align 3
.LC77:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC78:
	.long 0x3f800000
	.align 2
.LC79:
	.long 0x0
	.align 3
.LC80:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC81:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC82:
	.long 0x40590000
	.long 0x0
	.section	".text"
	.align 2
	.globl Spell_earthquake_think
	.type	 Spell_earthquake_think,@function
Spell_earthquake_think:
	stwu 1,-80(1)
	mflr 0
	stfd 27,40(1)
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,16(1)
	stw 0,84(1)
	lis 9,level@ha
	mr 30,3
	la 31,level@l(9)
	lfs 13,476(30)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L116
	lis 9,gi+20@ha
	addi 3,30,4
	lwz 6,576(30)
	lwz 0,gi+20@l(9)
	mr 4,30
	li 5,0
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
	lfs 2,0(9)
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
	lfs 3,0(9)
	blrl
	lfs 0,4(31)
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,476(30)
.L116:
	lis 9,globals@ha
	li 29,1
	la 10,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,29,0
	addi 31,9,900
	bc 4,0,.L118
	lis 9,.LC75@ha
	lis 11,.LC76@ha
	lfs 28,.LC75@l(9)
	mr 26,10
	li 27,0
	lis 9,.LC81@ha
	lfd 29,.LC76@l(11)
	lis 28,0x4330
	la 9,.LC81@l(9)
	lfd 31,0(9)
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	lfd 30,0(9)
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfd 27,0(9)
.L120:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L119
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L119
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L119
	stw 27,552(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,376(31)
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 28,8(1)
	lfd 13,8(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,400(31)
	xoris 3,3,0x8000
	mr 11,9
	lfs 11,380(31)
	stw 3,12(1)
	xoris 0,0,0x8000
	stw 28,8(1)
	lfd 13,8(1)
	stw 0,12(1)
	stw 28,8(1)
	fsub 13,13,31
	lfd 12,8(1)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,28
	fdiv 12,27,12
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,11
	frsp 0,0
	stfs 0,380(31)
	lfs 13,328(30)
	fmul 13,13,12
	frsp 13,13
	stfs 13,384(31)
.L119:
	lwz 0,72(26)
	addi 29,29,1
	addi 31,31,900
	cmpw 0,29,0
	bc 12,0,.L120
.L118:
	lis 9,level+4@ha
	lfs 0,288(30)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L125
	fmr 0,13
	lis 9,.LC77@ha
	lfd 13,.LC77@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	b .L126
.L125:
	mr 3,30
	bl G_FreeEdict
.L126:
	lwz 0,84(1)
	mtlr 0
	lmw 26,16(1)
	lfd 27,40(1)
	lfd 28,48(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe10:
	.size	 Spell_earthquake_think,.Lfe10-Spell_earthquake_think
	.section	".rodata"
	.align 2
.LC83:
	.string	"weapons/laser2.wav"
	.align 2
.LC84:
	.long 0x0
	.align 2
.LC85:
	.long 0x41200000
	.align 2
.LC86:
	.long 0x41000000
	.align 2
.LC87:
	.long 0xc1000000
	.align 2
.LC88:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Starburst
	.type	 Starburst,@function
Starburst:
	stwu 1,-416(1)
	mflr 0
	stmw 28,400(1)
	stw 0,420(1)
	lis 9,.LC84@ha
	lis 0,0xc120
	la 9,.LC84@l(9)
	stw 0,124(1)
	mr 28,3
	lfs 0,0(9)
	addi 4,1,264
	addi 5,1,8
	lis 9,.LC85@ha
	stw 0,24(1)
	la 9,.LC85@l(9)
	stw 0,60(1)
	li 6,50
	lfs 13,0(9)
	li 7,700
	lis 9,.LC86@ha
	stw 0,88(1)
	la 9,.LC86@l(9)
	stw 0,92(1)
	lfs 9,0(9)
	lis 9,.LC87@ha
	stw 0,104(1)
	la 9,.LC87@l(9)
	stfs 13,8(1)
	lfs 8,0(9)
	stfs 0,12(1)
	stfs 0,16(1)
	stfs 0,28(1)
	stfs 0,32(1)
	stfs 0,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	stfs 0,56(1)
	stfs 0,64(1)
	stfs 13,72(1)
	stfs 13,76(1)
	stfs 0,80(1)
	stfs 0,96(1)
	stfs 13,108(1)
	stfs 0,112(1)
	stfs 13,120(1)
	stfs 0,128(1)
	stfs 9,136(1)
	stfs 0,140(1)
	stfs 13,144(1)
	stfs 8,152(1)
	stfs 0,156(1)
	stfs 13,160(1)
	stfs 0,168(1)
	stfs 9,172(1)
	stfs 13,176(1)
	stfs 0,184(1)
	lfs 11,4(28)
	lfs 10,8(28)
	lfs 12,12(28)
	fadds 7,11,9
	stfs 8,188(1)
	fadds 5,10,8
	stfs 13,192(1)
	fadds 6,10,9
	stfs 9,200(1)
	fadds 4,11,0
	stfs 9,204(1)
	fadds 12,12,13
	stfs 13,208(1)
	fadds 11,11,8
	stfs 8,216(1)
	fadds 10,10,0
	stfs 4,312(1)
	stfs 8,220(1)
	stfs 13,224(1)
	stfs 10,284(1)
	stfs 8,232(1)
	stfs 9,236(1)
	stfs 13,240(1)
	stfs 9,248(1)
	stfs 8,252(1)
	stfs 13,256(1)
	stfs 7,264(1)
	stfs 10,268(1)
	stfs 12,272(1)
	stfs 11,280(1)
	stfs 12,288(1)
	stfs 4,296(1)
	stfs 6,300(1)
	stfs 12,304(1)
	stfs 5,316(1)
	stfs 12,320(1)
	stfs 7,328(1)
	stfs 6,332(1)
	stfs 12,336(1)
	stfs 11,344(1)
	stfs 5,348(1)
	stfs 11,360(1)
	stfs 6,364(1)
	stfs 7,376(1)
	stfs 5,380(1)
	stfs 12,384(1)
	stfs 12,352(1)
	stfs 12,368(1)
	bl fire_starburst
	addi 4,1,280
	addi 5,1,24
	mr 3,28
	li 6,50
	li 7,700
	bl fire_starburst
	addi 4,1,296
	addi 5,1,40
	mr 3,28
	li 6,50
	li 7,700
	bl fire_starburst
	addi 4,1,312
	addi 5,1,56
	mr 3,28
	li 6,50
	li 7,700
	bl fire_starburst
	addi 4,1,328
	addi 5,1,72
	mr 3,28
	li 6,50
	li 7,700
	bl fire_starburst
	addi 4,1,344
	addi 5,1,88
	mr 3,28
	li 6,50
	li 7,700
	bl fire_starburst
	addi 4,1,360
	addi 5,1,104
	mr 3,28
	li 6,50
	li 7,700
	bl fire_starburst
	addi 4,1,376
	addi 5,1,120
	mr 3,28
	li 6,50
	li 7,700
	bl fire_starburst
	lis 29,gi@ha
	lis 3,.LC83@ha
	la 29,gi@l(29)
	la 3,.LC83@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC88@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC88@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,28
	mtlr 0
	lis 9,.LC88@ha
	la 9,.LC88@l(9)
	lfs 2,0(9)
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,420(1)
	mtlr 0
	lmw 28,400(1)
	la 1,416(1)
	blr
.Lfe11:
	.size	 Starburst,.Lfe11-Starburst
	.section	".rodata"
	.align 2
.LC89:
	.string	"models/objects/laser/tris.md2"
	.align 2
.LC90:
	.string	"misc/lasfly.wav"
	.align 2
.LC91:
	.string	"bolt"
	.align 3
.LC92:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC93:
	.long 0x40000000
	.align 3
.LC94:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC95:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl fire_starburst
	.type	 fire_starburst,@function
fire_starburst:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	mr 30,5
	mr 27,3
	mr 29,4
	mr 26,6
	mr 28,7
	mr 3,30
	bl VectorNormalize
	bl G_Spawn
	lfs 0,0(29)
	mr 31,3
	mr 3,30
	addi 4,31,16
	addi 25,31,4
	stfs 0,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,28(31)
	lfs 13,4(29)
	stfs 13,32(31)
	lfs 0,8(29)
	stfs 0,36(31)
	bl vectoangles
	xoris 28,28,0x8000
	stw 28,92(1)
	lis 0,0x4330
	lis 11,.LC92@ha
	stw 0,88(1)
	la 11,.LC92@l(11)
	addi 4,31,376
	lfd 1,88(1)
	mr 3,30
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	li 9,0
	ori 0,0,3
	li 8,2
	stw 9,200(31)
	li 10,8
	oris 11,11,0x10
	stw 0,252(31)
	lis 29,gi@ha
	stw 8,248(31)
	lis 3,.LC89@ha
	la 29,gi@l(29)
	stw 10,260(31)
	la 3,.LC89@l(3)
	stw 11,64(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	stw 3,40(31)
	lwz 9,36(29)
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	mtlr 9
	blrl
	lis 11,starburst_touch@ha
	lis 9,.LC93@ha
	stw 3,76(31)
	la 11,starburst_touch@l(11)
	lis 10,level+4@ha
	stw 27,256(31)
	stw 11,444(31)
	la 9,.LC93@l(9)
	mr 3,31
	lfs 0,level+4@l(10)
	lis 11,.LC91@ha
	lfs 13,0(9)
	la 11,.LC91@l(11)
	lis 9,G_FreeEdict@ha
	stw 11,280(31)
	la 9,G_FreeEdict@l(9)
	stw 26,516(31)
	fadds 0,0,13
	stw 9,436(31)
	stfs 0,428(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 0,48(29)
	lis 9,0x600
	addi 4,27,4
	ori 9,9,3
	addi 3,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 7,25
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC94@ha
	la 9,.LC94@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L129
	lis 11,.LC95@ha
	mr 3,25
	la 11,.LC95@l(11)
	mr 5,3
	lfs 1,0(11)
	mr 4,30
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L129:
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe12:
	.size	 fire_starburst,.Lfe12-fire_starburst
	.section	".rodata"
	.align 2
.LC96:
	.string	"monster_mutant"
	.align 2
.LC97:
	.string	"monster_eyes"
	.align 2
.LC98:
	.string	"models/objects/gibs/head/tris.md2"
	.align 2
.LC101:
	.string	"%s is the Betrayer\npurge him!!!!"
	.section	".text"
	.align 2
	.globl OpenTeamMenu
	.type	 OpenTeamMenu,@function
OpenTeamMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 4,joinmenu@ha
	li 5,0
	la 4,joinmenu@l(4)
	li 6,12
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 OpenTeamMenu,.Lfe13-OpenTeamMenu
	.align 2
	.globl JoinGod
	.type	 JoinGod,@function
JoinGod:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC8@ha
	lwz 0,gi@l(9)
	la 4,.LC8@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	li 0,0
	li 10,1
	stw 0,3464(11)
	lwz 9,84(29)
	stw 0,3468(9)
	lwz 11,84(29)
	stw 10,3472(11)
	stw 0,64(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 JoinGod,.Lfe14-JoinGod
	.align 2
	.globl JoinSatan
	.type	 JoinSatan,@function
JoinSatan:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC9@ha
	lwz 0,gi@l(9)
	la 4,.LC9@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	li 0,1
	li 10,0
	stw 0,3464(11)
	lwz 9,84(29)
	stw 10,3468(9)
	lwz 11,84(29)
	stw 0,3472(11)
	stw 10,64(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 JoinSatan,.Lfe15-JoinSatan
	.align 2
	.globl SpellMenu
	.type	 SpellMenu,@function
SpellMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 4,2,.L26
	lis 4,RedMenu@ha
	li 5,0
	la 4,RedMenu@l(4)
	li 6,14
	bl PMenu_Open
	b .L27
.L26:
	lis 4,BlueMenu@ha
	li 5,0
	la 4,BlueMenu@l(4)
	li 6,14
	bl PMenu_Open
.L27:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 SpellMenu,.Lfe16-SpellMenu
	.section	".rodata"
	.align 2
.LC102:
	.long 0x3f800000
	.align 2
.LC103:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpellTwo
	.type	 SpellTwo,@function
SpellTwo:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl PMenu_Close
	lwz 5,84(31)
	lwz 0,3468(5)
	cmpwi 0,0,1
	bc 12,1,.L35
	lis 9,gi+12@ha
	lis 4,.LC35@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC35@l(4)
	b .L188
.L35:
	lwz 0,3472(5)
	cmpwi 0,0,0
	bc 4,2,.L36
	lis 9,gi+12@ha
	lis 4,.LC36@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC36@l(4)
.L188:
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L34
.L36:
	mr 3,31
	bl Flash_Explode
	lis 29,gi@ha
	lis 3,.LC41@ha
	la 29,gi@l(29)
	la 3,.LC41@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC102@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC102@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	lfs 2,0(9)
	lis 9,.LC103@ha
	la 9,.LC103@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(31)
	lwz 9,3472(11)
	addi 9,9,-1
	stw 9,3472(11)
.L34:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 SpellTwo,.Lfe17-SpellTwo
	.align 2
	.globl SpellFive
	.type	 SpellFive,@function
SpellFive:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	lwz 5,84(31)
	lwz 0,3468(5)
	cmpwi 0,0,4
	bc 12,1,.L51
	lis 9,gi+12@ha
	lis 4,.LC35@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC35@l(4)
	b .L189
.L51:
	lwz 9,3472(5)
	cmpwi 0,9,0
	bc 4,2,.L52
	lis 9,gi+12@ha
	lis 4,.LC36@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC36@l(4)
.L189:
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L50
.L52:
	lwz 0,3464(5)
	cmpwi 0,0,1
	bc 4,2,.L53
	addi 0,9,-1
	mr 3,31
	stw 0,3472(5)
	bl Spell_earthquake
	b .L50
.L53:
	addi 0,9,-1
	mr 3,31
	stw 0,3472(5)
	bl Starburst
.L50:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 SpellFive,.Lfe18-SpellFive
	.align 2
	.globl SpellSix
	.type	 SpellSix,@function
SpellSix:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	lwz 5,84(31)
	lwz 0,3468(5)
	cmpwi 0,0,5
	bc 12,1,.L56
	lis 9,gi+12@ha
	lis 4,.LC35@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC35@l(4)
	b .L190
.L56:
	lwz 9,3472(5)
	cmpwi 0,9,0
	bc 4,2,.L57
	lis 9,gi+12@ha
	lis 4,.LC36@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC36@l(4)
.L190:
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L55
.L57:
	lwz 0,3464(5)
	cmpwi 0,0,1
	bc 4,2,.L58
	addi 0,9,-1
	mr 3,31
	stw 0,3472(5)
	bl Hellspawn
	b .L55
.L58:
	addi 0,9,-1
	mr 3,31
	stw 0,3472(5)
	bl Eyes
.L55:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 SpellSix,.Lfe19-SpellSix
	.section	".rodata"
	.align 3
.LC104:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC105:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Shockwave
	.type	 Shockwave,@function
Shockwave:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 27,3
	bl G_Spawn
	lfs 0,4(27)
	mr 29,3
	lis 9,.LC105@ha
	la 9,.LC105@l(9)
	lis 0,0x4040
	lfs 13,0(9)
	lis 10,level@ha
	lis 11,ShockwaveThink@ha
	stfs 0,4(29)
	la 10,level@l(10)
	la 11,ShockwaveThink@l(11)
	lfs 0,8(27)
	lis 9,.LC104@ha
	lis 28,gi@ha
	lfd 12,.LC104@l(9)
	la 28,gi@l(28)
	lis 3,.LC67@ha
	la 3,.LC67@l(3)
	stfs 0,8(29)
	lfs 0,12(27)
	stw 0,596(29)
	fadds 0,0,13
	stfs 0,12(29)
	lfs 13,4(10)
	stw 11,436(29)
	stfs 13,288(29)
	lfs 0,4(10)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 Shockwave,.Lfe20-Shockwave
	.section	".rodata"
	.align 3
.LC106:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl ShockwaveThink
	.type	 ShockwaveThink,@function
ShockwaveThink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 0,288(31)
	lfs 13,596(31)
	lfs 12,level+4@l(9)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L90
	bl ShockwaveExplode
	mr 3,31
	bl G_FreeEdict
	b .L91
.L90:
	lis 9,.LC106@ha
	fmr 0,12
	lfd 13,.LC106@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L91:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 ShockwaveThink,.Lfe21-ShockwaveThink
	.section	".rodata"
	.align 3
.LC107:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC108:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Lightning
	.type	 Lightning,@function
Lightning:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 27,3
	bl G_Spawn
	lfs 0,4(27)
	mr 29,3
	lis 9,.LC108@ha
	la 9,.LC108@l(9)
	lwz 0,64(29)
	lis 8,0x40a0
	lfs 13,0(9)
	lis 11,level@ha
	lis 10,.LC107@ha
	stfs 0,4(29)
	oris 0,0,0x88
	la 11,level@l(11)
	lfs 0,8(27)
	lis 9,LightningThink@ha
	lis 28,gi@ha
	la 9,LightningThink@l(9)
	lfd 12,.LC107@l(10)
	la 28,gi@l(28)
	lis 3,.LC69@ha
	stfs 0,8(29)
	la 3,.LC69@l(3)
	lfs 0,12(27)
	stw 0,64(29)
	stw 8,596(29)
	fadds 0,0,13
	stfs 0,12(29)
	lfs 13,4(11)
	stw 9,436(29)
	stfs 13,288(29)
	lfs 0,4(11)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 Lightning,.Lfe22-Lightning
	.section	".rodata"
	.align 3
.LC109:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl LightningThink
	.type	 LightningThink,@function
LightningThink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 0,288(31)
	lfs 13,596(31)
	lfs 12,level+4@l(9)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L95
	bl LightningExplode
	mr 3,31
	bl G_FreeEdict
	b .L96
.L95:
	lis 9,.LC109@ha
	fmr 0,12
	lfd 13,.LC109@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L96:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 LightningThink,.Lfe23-LightningThink
	.section	".rodata"
	.align 3
.LC110:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC111:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Spell_earthquake
	.type	 Spell_earthquake,@function
Spell_earthquake:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	bl G_Spawn
	mr 29,3
	li 9,5
	lwz 0,184(29)
	lis 11,Spell_earthquake_think@ha
	lis 8,0x4416
	stw 9,532(29)
	la 11,Spell_earthquake_think@l(11)
	lis 10,level@ha
	ori 0,0,1
	lis 9,.LC111@ha
	stw 11,436(29)
	stw 0,184(29)
	la 10,level@l(10)
	la 9,.LC111@l(9)
	stw 8,328(29)
	li 0,0
	lis 11,gi+36@ha
	lfs 13,4(10)
	lis 3,.LC74@ha
	lfs 0,0(9)
	la 3,.LC74@l(3)
	lis 9,.LC110@ha
	lfd 12,.LC110@l(9)
	fadds 13,13,0
	stfs 13,288(29)
	lfs 0,4(10)
	stw 0,476(29)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(29)
	lwz 0,gi+36@l(11)
	mtlr 0
	blrl
	stw 3,576(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 Spell_earthquake,.Lfe24-Spell_earthquake
	.align 2
	.globl starburst_touch
	.type	 starburst_touch,@function
starburst_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	mr 31,4
	lwz 0,256(30)
	mr 28,5
	cmpw 0,31,0
	bc 12,2,.L130
	cmpwi 0,6,0
	bc 12,2,.L132
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L132
	bl G_FreeEdict
	b .L130
.L132:
	lwz 3,256(30)
	addi 29,30,4
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L133
	mr 4,29
	li 5,2
	bl PlayerNoise
.L133:
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L134
	lwz 5,256(30)
	li 11,1
	li 0,4
	lwz 9,516(30)
	mr 3,31
	mr 7,29
	stw 0,8(1)
	mr 8,28
	mr 4,30
	stw 11,12(1)
	addi 6,30,376
	li 10,1
	bl T_Damage
	b .L135
.L134:
	lis 9,gi@ha
	li 3,3
	la 31,gi@l(9)
	lwz 9,100(31)
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,2
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,29
	mtlr 9
	blrl
	cmpwi 0,28,0
	bc 4,2,.L136
	lwz 0,124(31)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L137
.L136:
	lwz 0,124(31)
	mr 3,28
	mtlr 0
	blrl
.L137:
	lis 9,gi+88@ha
	mr 3,29
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L135:
	mr 3,30
	bl G_FreeEdict
.L130:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 starburst_touch,.Lfe25-starburst_touch
	.section	".rodata"
	.align 2
.LC112:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl Hellspawn
	.type	 Hellspawn,@function
Hellspawn:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 29,3
	lwz 3,896(29)
	cmpwi 0,3,0
	bc 12,2,.L139
	bl G_FreeEdict
	b .L138
.L139:
	bl G_Spawn
	lwz 9,84(29)
	mr 28,3
	addi 4,1,8
	li 6,0
	li 5,0
	addi 3,9,3660
	bl AngleVectors
	lis 9,.LC112@ha
	addi 4,1,8
	la 9,.LC112@l(9)
	addi 5,28,4
	lfs 1,0(9)
	addi 3,29,4
	bl VectorMA
	lis 9,.LC96@ha
	stw 29,892(28)
	mr 3,28
	la 9,.LC96@l(9)
	stw 9,280(28)
	stw 28,896(29)
	crxor 6,6,6
	bl ED_CallSpawn
	lis 29,gi@ha
	mr 3,28
	la 29,gi@l(29)
	lwz 9,76(29)
	mtlr 9
	blrl
	mr 3,28
	bl KillBox
	lwz 0,72(29)
	mr 3,28
	mtlr 0
	blrl
.L138:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 Hellspawn,.Lfe26-Hellspawn
	.section	".rodata"
	.align 3
.LC113:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC114:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl Eyes
	.type	 Eyes,@function
Eyes:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 3,896(31)
	cmpwi 0,3,0
	bc 12,2,.L141
	bl G_FreeEdict
	b .L140
.L141:
	bl G_Spawn
	mr 29,3
	lis 9,.LC97@ha
	stw 31,892(29)
	la 9,.LC97@l(9)
	lis 11,.LC114@ha
	stw 29,896(31)
	la 11,.LC114@l(11)
	lis 28,gi@ha
	stw 9,280(29)
	la 28,gi@l(28)
	lis 3,.LC98@ha
	lfs 0,12(31)
	la 3,.LC98@l(3)
	lfs 11,0(11)
	lfs 13,8(31)
	lfs 12,4(31)
	fadds 0,0,11
	stfs 13,12(1)
	stfs 12,8(1)
	stfs 0,16(1)
	stfs 12,4(29)
	lfs 0,12(1)
	stfs 0,8(29)
	lfs 13,16(1)
	stfs 13,12(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 0,0x8
	lis 11,Eyes_think@ha
	stw 3,40(29)
	lis 9,0xc2b4
	ori 0,0,32768
	la 11,Eyes_think@l(11)
	stw 9,24(29)
	lis 10,level+4@ha
	stw 0,64(29)
	lis 9,.LC113@ha
	mr 3,29
	stw 11,436(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC113@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
.L140:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 Eyes,.Lfe27-Eyes
	.section	".rodata"
	.align 2
.LC115:
	.long 0x46fffe00
	.align 3
.LC116:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC117:
	.long 0x41200000
	.align 2
.LC118:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl Eyes_think
	.type	 Eyes_think,@function
Eyes_think:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 29,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC116@ha
	lis 11,.LC115@ha
	stw 0,16(1)
	la 10,.LC116@l(10)
	mr 3,29
	lfd 13,0(10)
	lfd 31,16(1)
	lis 10,.LC117@ha
	lfs 0,.LC115@l(11)
	la 10,.LC117@l(10)
	lfs 12,0(10)
	fsub 31,31,13
	lis 10,.LC118@ha
	la 10,.LC118@l(10)
	lfs 11,0(10)
	frsp 31,31
	fdivs 31,31,0
	fmuls 31,31,12
	fmuls 31,31,11
	bl Starburst
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,31
	stfs 0,428(29)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 Eyes_think,.Lfe28-Eyes_think
	.align 2
	.globl CheckforIt
	.type	 CheckforIt,@function
CheckforIt:
	lis 9,globals+72@ha
	li 10,1
	lwz 0,globals+72@l(9)
	lis 11,g_edicts@ha
	lwz 9,g_edicts@l(11)
	cmpw 0,10,0
	addi 9,9,900
	bc 4,0,.L145
	mr 8,0
.L147:
	lwz 11,84(9)
	cmpwi 0,11,0
	bc 12,2,.L146
	lwz 0,3840(11)
	cmpwi 0,0,0
	bc 12,2,.L146
	li 3,1
	blr
.L146:
	addi 10,10,1
	addi 9,9,900
	cmpw 0,10,8
	bc 12,0,.L147
.L145:
	li 3,0
	blr
.Lfe29:
	.size	 CheckforIt,.Lfe29-CheckforIt
	.align 2
	.globl SetIt
	.type	 SetIt,@function
SetIt:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 3,0
	bl random_player
	cmpwi 0,3,0
	bc 12,2,.L152
	li 3,0
	bl random_player
	bl SetItEffects
.L152:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 SetIt,.Lfe30-SetIt
	.section	".rodata"
	.align 2
.LC119:
	.long 0x3f800000
	.align 3
.LC120:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SetItEffects
	.type	 SetItEffects,@function
SetItEffects:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	lis 11,.LC119@ha
	mr 29,3
	la 11,.LC119@l(11)
	lis 9,maxclients@ha
	lwz 10,84(29)
	lfs 13,0(11)
	li 0,1
	li 30,1
	lwz 11,maxclients@l(9)
	lis 24,maxclients@ha
	stw 0,3840(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L155
	lis 9,gi@ha
	lis 25,g_edicts@ha
	la 26,gi@l(9)
	lis 27,.LC101@ha
	lis 9,.LC120@ha
	lis 28,0x4330
	la 9,.LC120@l(9)
	li 31,900
	lfd 31,0(9)
.L157:
	lwz 0,g_edicts@l(25)
	add. 3,0,31
	bc 12,2,.L156
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L156
	lwz 5,84(29)
	la 4,.LC101@l(27)
	lwz 9,12(26)
	addi 5,5,700
	mtlr 9
	crxor 6,6,6
	blrl
.L156:
	addi 30,30,1
	lwz 11,maxclients@l(24)
	xoris 0,30,0x8000
	addi 31,31,900
	stw 0,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L157
.L155:
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe31:
	.size	 SetItEffects,.Lfe31-SetItEffects
	.align 2
	.globl Rules
	.type	 Rules,@function
Rules:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	mr 29,4
	lwz 9,84(30)
	lwz 0,3840(9)
	cmpwi 0,0,0
	bc 12,2,.L161
	li 31,3
.L165:
	lwz 11,84(30)
	mr 3,30
	lwz 9,3448(11)
	addi 9,9,1
	stw 9,3448(11)
	bl holylevel
	addic. 31,31,-1
	bc 4,2,.L165
	b .L160
.L161:
	lwz 9,84(29)
	lwz 0,3840(9)
	cmpwi 0,0,0
	bc 12,2,.L160
	li 31,5
.L171:
	lwz 11,84(30)
	mr 3,30
	lwz 9,3448(11)
	addi 9,9,1
	stw 9,3448(11)
	bl holylevel
	addic. 31,31,-1
	bc 4,2,.L171
	mr 3,29
	bl RemoveItEffects
	li 3,0
	bl random_player
	cmpwi 0,3,0
	bc 12,2,.L160
	li 3,0
	bl random_player
	bl SetItEffects
.L160:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 Rules,.Lfe32-Rules
	.align 2
	.globl RemoveItEffects
	.type	 RemoveItEffects,@function
RemoveItEffects:
	lwz 9,84(3)
	li 0,0
	stw 0,3840(9)
	blr
.Lfe33:
	.size	 RemoveItEffects,.Lfe33-RemoveItEffects
	.section	".rodata"
	.align 2
.LC121:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl Check
	.type	 Check,@function
Check:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,globals+72@ha
	li 10,1
	lwz 0,globals+72@l(9)
	lis 11,g_edicts@ha
	mr 31,3
	lwz 9,g_edicts@l(11)
	cmpw 0,10,0
	addi 9,9,900
	bc 4,0,.L184
	mr 8,0
.L179:
	lwz 11,84(9)
	cmpwi 0,11,0
	bc 12,2,.L181
	lwz 0,3840(11)
	cmpwi 0,0,0
	bc 12,2,.L181
	li 0,1
	b .L183
.L181:
	addi 10,10,1
	addi 9,9,900
	cmpw 0,10,8
	bc 12,0,.L179
.L184:
	li 0,0
.L183:
	cmpwi 0,0,0
	bc 4,2,.L185
	li 3,0
	bl random_player
	cmpwi 0,3,0
	bc 12,2,.L185
	li 3,0
	bl random_player
	bl SetItEffects
.L185:
	lis 11,.LC121@ha
	lis 9,level+4@ha
	la 11,.LC121@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 Check,.Lfe34-Check
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
