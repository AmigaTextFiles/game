	.file	"trond_misc.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"helmet"
	.align 2
.LC1:
	.string	"players/team2/w_helmet.md2"
	.align 2
.LC2:
	.string	"players/team1/w_helmet.md2"
	.align 2
.LC3:
	.string	"You have %d kills in a row\n"
	.align 2
.LC4:
	.string	"%s has %d kills in a row, he now gets 2 frags per kill\n"
	.align 2
.LC5:
	.string	"%s has %d kills in a row, he now gets 4 frags per kill\n"
	.align 2
.LC6:
	.string	"%s has %d kills in a row, he now gets 6 frags per kill\n"
	.align 2
.LC7:
	.string	"%s has %d kills in a row, he now gets 8 frags per kill\n"
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl Decide_Score
	.type	 Decide_Score,@function
Decide_Score:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,4
	cmpw 0,31,3
	bc 4,2,.L13
	lis 9,ctf@ha
	lis 8,.LC8@ha
	lwz 11,ctf@l(9)
	la 8,.LC8@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L13
	lwz 11,84(31)
	lwz 9,3528(11)
	addi 9,9,-1
	stw 9,3528(11)
	b .L14
.L13:
	lis 9,.LC8@ha
	lis 11,ctf@ha
	la 9,.LC8@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	bc 4,30,.L15
	lwz 11,84(31)
	lwz 9,3984(11)
	addi 9,9,1
	stw 9,3984(11)
	lwz 5,84(31)
	lwz 6,3984(5)
	cmpwi 0,6,3
	bc 12,1,.L16
	lwz 9,3528(5)
	addi 9,9,1
	stw 9,3528(5)
	lwz 11,84(31)
	lwz 6,3984(11)
	cmpwi 0,6,1
	bc 4,1,.L14
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC3@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L14
.L16:
	addi 0,6,-4
	cmplwi 0,0,3
	bc 12,1,.L19
	lis 9,gi@ha
	lis 4,.LC4@ha
	lwz 0,gi@l(9)
	la 4,.LC4@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,3528(11)
	addi 9,9,2
	stw 9,3528(11)
	b .L14
.L19:
	addi 0,6,-8
	cmplwi 0,0,3
	bc 12,1,.L21
	lis 9,gi@ha
	lis 4,.LC5@ha
	lwz 0,gi@l(9)
	la 4,.LC5@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,3528(11)
	addi 9,9,4
	stw 9,3528(11)
	b .L14
.L21:
	addi 0,6,-12
	cmplwi 0,0,3
	bc 12,1,.L23
	lis 9,gi@ha
	lis 4,.LC6@ha
	lwz 0,gi@l(9)
	la 4,.LC6@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,3528(11)
	addi 9,9,6
	stw 9,3528(11)
	b .L14
.L23:
	cmpwi 0,6,15
	bc 4,1,.L14
	lis 9,gi@ha
	lis 4,.LC7@ha
	lwz 0,gi@l(9)
	la 4,.LC7@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,3528(11)
	addi 9,9,8
	stw 9,3528(11)
	b .L14
.L15:
	lwz 9,84(31)
	xor 0,31,3
	addic 8,0,-1
	subfe 11,8,0
	mr 10,9
	addic 8,9,-1
	subfe 0,8,9
	and. 9,0,11
	bc 12,2,.L27
	lwz 9,84(3)
	lwz 11,3532(10)
	lwz 0,3532(9)
	cmpw 0,11,0
	bc 12,2,.L27
	cmpwi 0,11,0
	bc 12,2,.L27
	bc 12,30,.L27
	cmpwi 0,11,1
	bc 4,2,.L28
	lis 11,ctfgame@ha
	lwz 9,ctfgame@l(11)
	addi 9,9,1
	stw 9,ctfgame@l(11)
	b .L14
.L28:
	lis 11,ctfgame@ha
	la 11,ctfgame@l(11)
	lwz 9,4(11)
	addi 9,9,1
	b .L34
.L27:
	cmpwi 0,10,0
	bc 12,2,.L14
	lwz 0,84(3)
	xor 11,3,31
	subfic 8,11,0
	adde 11,8,11
	addic 8,0,-1
	subfe 9,8,0
	and. 0,9,11
	bc 12,2,.L14
	lis 11,ctf@ha
	lis 8,.LC8@ha
	lwz 9,ctf@l(11)
	la 8,.LC8@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L14
	lwz 0,3532(10)
	cmpwi 0,0,1
	bc 4,2,.L32
	lis 11,ctfgame@ha
	lwz 9,ctfgame@l(11)
	addi 9,9,-1
	stw 9,ctfgame@l(11)
	b .L14
.L32:
	lis 11,ctfgame@ha
	la 11,ctfgame@l(11)
	lwz 9,4(11)
	addi 9,9,-1
.L34:
	stw 9,4(11)
.L14:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 Decide_Score,.Lfe1-Decide_Score
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
	.section	".rodata"
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl Visible_Items
	.type	 Visible_Items,@function
Visible_Items:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 30,84(31)
	cmpwi 0,30,0
	bc 12,2,.L6
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,30,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 11,11,3
	cmpwi 0,11,0
	bc 12,2,.L8
	lis 9,.LC9@ha
	lis 11,ctf@ha
	la 9,.LC9@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L9
	lwz 9,84(31)
	lwz 0,3532(9)
	cmpwi 0,0,2
	bc 4,2,.L9
	lis 9,gi+32@ha
	lis 3,.LC1@ha
	lwz 0,gi+32@l(9)
	la 3,.LC1@l(3)
	b .L35
.L9:
	lis 9,gi+32@ha
	lis 3,.LC2@ha
	lwz 0,gi+32@l(9)
	la 3,.LC2@l(3)
.L35:
	mtlr 0
	blrl
	stw 3,52(31)
	b .L6
.L8:
	stw 11,52(31)
.L6:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 Visible_Items,.Lfe2-Visible_Items
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
