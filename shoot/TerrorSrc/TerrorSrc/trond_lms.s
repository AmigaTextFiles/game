	.file	"trond_lms.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"players/team2/"
	.align 2
.LC1:
	.string	"players/team1/"
	.align 2
.LC2:
	.string	"players/messiah/"
	.align 2
.LC3:
	.string	"players/crakhor/"
	.align 2
.LC4:
	.string	"helmet"
	.align 2
.LC5:
	.string	"i_helmet.md2"
	.align 2
.LC6:
	.string	"ir goggles"
	.align 2
.LC7:
	.string	"i_ir.md2"
	.align 2
.LC8:
	.string	"head light"
	.align 2
.LC9:
	.string	"i_light.md2"
	.align 2
.LC10:
	.string	"null.md2"
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl ShowItem
	.type	 ShowItem,@function
ShowItem:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 28,3
	lwz 10,84(28)
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 4,2,.L7
	stw 0,52(28)
	b .L6
.L7:
	lis 9,.LC11@ha
	lis 11,ctf@ha
	la 9,.LC11@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L8
	lwz 0,3532(10)
	cmpwi 0,0,2
	bc 4,2,.L8
	lis 9,.LC0@ha
	addi 11,1,8
	lwz 7,.LC0@l(9)
	mr 5,11
	la 9,.LC0@l(9)
	b .L33
.L8:
	lwz 9,84(28)
	lwz 0,3580(9)
	cmpwi 0,0,1
	bc 12,2,.L16
	cmpwi 0,0,2
	bc 4,2,.L12
	lis 9,.LC2@ha
	addi 11,1,8
	lwz 7,.LC2@l(9)
	mr 5,11
	la 9,.LC2@l(9)
	b .L34
.L12:
	cmpwi 0,0,3
	bc 4,2,.L14
	lis 9,.LC0@ha
	addi 11,1,8
	lwz 7,.LC0@l(9)
	mr 5,11
	la 9,.LC0@l(9)
	b .L33
.L14:
	cmpwi 0,0,4
	bc 4,2,.L16
	lis 9,.LC3@ha
	addi 11,1,8
	lwz 7,.LC3@l(9)
	mr 5,11
	la 9,.LC3@l(9)
.L34:
	lbz 6,16(9)
	lwz 0,4(9)
	lwz 10,8(9)
	lwz 8,12(9)
	stw 7,8(1)
	stw 0,4(11)
	stw 10,8(11)
	stw 8,12(11)
	stb 6,16(11)
	b .L9
.L16:
	lis 9,.LC1@ha
	addi 11,1,8
	lwz 7,.LC1@l(9)
	mr 5,11
	la 9,.LC1@l(9)
.L33:
	lbz 6,14(9)
	lwz 0,4(9)
	lwz 10,8(9)
	lhz 8,12(9)
	stw 7,8(1)
	stw 0,4(11)
	stw 10,8(11)
	sth 8,12(11)
	stb 6,14(11)
.L9:
	lis 9,.LC11@ha
	lis 11,ctf@ha
	la 9,.LC11@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L18
	lwz 9,84(28)
	lwz 0,4064(9)
	cmpwi 0,0,1
	bc 4,2,.L18
	lis 9,.LC3@ha
	lwz 8,.LC3@l(9)
	la 9,.LC3@l(9)
	b .L35
.L18:
	lis 9,.LC11@ha
	lis 11,ctf@ha
	la 9,.LC11@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L19
	lwz 9,84(28)
	lwz 0,4060(9)
	cmpwi 0,0,1
	bc 4,2,.L19
	lis 9,.LC2@ha
	lwz 8,.LC2@l(9)
	la 9,.LC2@l(9)
.L35:
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	stw 8,8(1)
	stw 0,4(5)
	stw 11,8(5)
	stw 10,12(5)
	lbz 0,16(9)
	stb 0,16(5)
.L19:
	mr 11,5
	li 9,8
	lbzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L22
	li 8,0
	mr 10,11
.L24:
	lbzx 0,10,9
	cmpwi 0,0,47
	bc 4,2,.L23
	addi 9,9,1
	stbx 8,11,9
.L23:
	addi 9,9,1
	lbzx 0,10,9
	cmpwi 0,0,0
	bc 4,2,.L24
.L22:
	lis 3,.LC4@ha
	lwz 29,84(28)
	lis 31,0x286b
	la 3,.LC4@l(3)
	ori 31,31,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 30,itemlist@l(9)
	subf 3,30,3
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L27
	lis 4,.LC5@ha
	addi 3,1,8
	la 4,.LC5@l(4)
	bl strcat
	b .L28
.L27:
	lis 3,.LC6@ha
	lwz 29,84(28)
	la 3,.LC6@l(3)
	bl FindItem
	subf 3,30,3
	addi 29,29,740
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L29
	lis 4,.LC7@ha
	addi 3,1,8
	la 4,.LC7@l(4)
	bl strcat
	b .L28
.L29:
	lis 3,.LC8@ha
	lwz 29,84(28)
	la 3,.LC8@l(3)
	bl FindItem
	subf 3,30,3
	addi 29,29,740
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L31
	lis 4,.LC9@ha
	addi 3,1,8
	la 4,.LC9@l(4)
	bl strcat
	b .L28
.L31:
	lis 4,.LC10@ha
	addi 3,1,8
	la 4,.LC10@l(4)
	bl strcat
.L28:
	lis 9,gi+32@ha
	addi 3,1,8
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	stw 3,52(28)
.L6:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe1:
	.size	 ShowItem,.Lfe1-ShowItem
	.section	".rodata"
	.align 2
.LC12:
	.string	"bullet proof vest"
	.align 2
.LC13:
	.string	"i_vest.md2"
	.align 2
.LC14:
	.string	"scuba gear"
	.align 2
.LC15:
	.string	"i_scuba.md2"
	.align 2
.LC16:
	.string	"medkit"
	.align 2
.LC17:
	.string	"i_medkit.md2"
	.align 2
.LC18:
	.string	"m60ammo"
	.align 2
.LC19:
	.string	"m60"
	.align 2
.LC20:
	.string	"i_m60ammo.md2"
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl ShowTorso
	.type	 ShowTorso,@function
ShowTorso:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 30,3
	lwz 10,84(30)
	lwz 0,3992(10)
	cmpwi 0,0,0
	bc 4,2,.L37
	stw 0,48(30)
	b .L36
.L37:
	lis 9,.LC21@ha
	lis 11,ctf@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L38
	lwz 0,3532(10)
	cmpwi 0,0,2
	bc 4,2,.L38
	lis 9,.LC0@ha
	addi 11,1,8
	lwz 7,.LC0@l(9)
	mr 5,11
	la 9,.LC0@l(9)
	b .L66
.L38:
	lwz 9,84(30)
	lwz 0,3580(9)
	cmpwi 0,0,1
	bc 12,2,.L46
	cmpwi 0,0,2
	bc 4,2,.L42
	lis 9,.LC2@ha
	addi 11,1,8
	lwz 7,.LC2@l(9)
	mr 5,11
	la 9,.LC2@l(9)
	b .L67
.L42:
	cmpwi 0,0,3
	bc 4,2,.L44
	lis 9,.LC0@ha
	addi 11,1,8
	lwz 7,.LC0@l(9)
	mr 5,11
	la 9,.LC0@l(9)
	b .L66
.L44:
	cmpwi 0,0,4
	bc 4,2,.L46
	lis 9,.LC3@ha
	addi 11,1,8
	lwz 7,.LC3@l(9)
	mr 5,11
	la 9,.LC3@l(9)
.L67:
	lbz 6,16(9)
	lwz 0,4(9)
	lwz 10,8(9)
	lwz 8,12(9)
	stw 7,8(1)
	stw 0,4(11)
	stw 10,8(11)
	stw 8,12(11)
	stb 6,16(11)
	b .L39
.L46:
	lis 9,.LC1@ha
	addi 11,1,8
	lwz 7,.LC1@l(9)
	mr 5,11
	la 9,.LC1@l(9)
.L66:
	lbz 6,14(9)
	lwz 0,4(9)
	lwz 10,8(9)
	lhz 8,12(9)
	stw 7,8(1)
	stw 0,4(11)
	stw 10,8(11)
	sth 8,12(11)
	stb 6,14(11)
.L39:
	lis 9,.LC21@ha
	lis 11,ctf@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L48
	lwz 9,84(30)
	lwz 0,4064(9)
	cmpwi 0,0,1
	bc 4,2,.L48
	lis 9,.LC3@ha
	lwz 8,.LC3@l(9)
	la 9,.LC3@l(9)
	b .L68
.L48:
	lis 9,.LC21@ha
	lis 11,ctf@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L49
	lwz 9,84(30)
	lwz 0,4060(9)
	cmpwi 0,0,1
	bc 4,2,.L49
	lis 9,.LC2@ha
	lwz 8,.LC2@l(9)
	la 9,.LC2@l(9)
.L68:
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	stw 8,8(1)
	stw 0,4(5)
	stw 11,8(5)
	stw 10,12(5)
	lbz 0,16(9)
	stb 0,16(5)
.L49:
	mr 11,5
	li 9,8
	lbzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L52
	li 8,0
	mr 10,11
.L54:
	lbzx 0,10,9
	cmpwi 0,0,47
	bc 4,2,.L53
	addi 9,9,1
	stbx 8,11,9
.L53:
	addi 9,9,1
	lbzx 0,10,9
	cmpwi 0,0,0
	bc 4,2,.L54
.L52:
	lis 3,.LC12@ha
	lwz 29,84(30)
	lis 31,0x286b
	la 3,.LC12@l(3)
	ori 31,31,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L57
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	bl strcat
	b .L58
.L57:
	lis 3,.LC14@ha
	lwz 29,84(30)
	la 3,.LC14@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L59
	lis 4,.LC15@ha
	addi 3,1,8
	la 4,.LC15@l(4)
	bl strcat
	b .L58
.L59:
	lis 3,.LC16@ha
	lwz 29,84(30)
	la 3,.LC16@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L61
	lis 4,.LC17@ha
	addi 3,1,8
	la 4,.LC17@l(4)
	bl strcat
	b .L58
.L61:
	lis 3,.LC18@ha
	lwz 29,84(30)
	la 3,.LC18@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,2,.L64
	lis 3,.LC19@ha
	lwz 29,84(30)
	la 3,.LC19@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L63
.L64:
	lis 4,.LC20@ha
	addi 3,1,8
	la 4,.LC20@l(4)
	bl strcat
	b .L58
.L63:
	lis 4,.LC10@ha
	addi 3,1,8
	la 4,.LC10@l(4)
	bl strcat
.L58:
	lis 9,gi+32@ha
	addi 3,1,8
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	stw 3,48(30)
.L36:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 ShowTorso,.Lfe2-ShowTorso
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
