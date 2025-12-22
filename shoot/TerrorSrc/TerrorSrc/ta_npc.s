	.file	"ta_npc.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"players/team2/tris.md2"
	.align 2
.LC1:
	.string	"bot"
	.align 3
.LC2:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC3:
	.long 0x40400000
	.section	".text"
	.align 2
	.type	 NPC_Respawn,@function
NPC_Respawn:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 28,3
	bl G_Spawn
	lfs 0,28(28)
	mr 29,3
	lis 27,gi@ha
	la 27,gi@l(27)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	stfs 0,4(29)
	lfs 0,32(28)
	stfs 0,8(29)
	lfs 13,36(28)
	stfs 13,12(29)
	lwz 9,44(27)
	mtlr 9
	blrl
	lis 9,.LC3@ha
	lfs 0,12(29)
	lis 11,npc_dead@ha
	la 9,.LC3@l(9)
	lwz 8,68(29)
	la 11,npc_dead@l(11)
	lfs 13,0(9)
	lis 10,npc_idle@ha
	li 0,0
	lis 9,.LC1@ha
	stw 11,456(29)
	li 4,100
	la 9,.LC1@l(9)
	li 7,200
	stw 0,540(29)
	fadds 0,0,13
	stw 9,280(29)
	li 11,1
	la 10,npc_idle@l(10)
	li 9,5
	ori 8,8,32768
	stw 11,512(29)
	li 6,-9999
	li 5,2
	stw 9,260(29)
	stw 7,400(29)
	lis 26,level+4@ha
	lis 28,.LC2@ha
	stw 0,44(29)
	lis 11,0xc180
	lis 9,0x4180
	stw 0,56(29)
	lis 7,0xc1c0
	lis 25,0x4200
	stw 0,612(29)
	mr 3,29
	stw 0,608(29)
	stw 0,492(29)
	stw 0,60(29)
	stw 0,900(29)
	stw 0,904(29)
	stw 0,908(29)
	stw 0,912(29)
	stfs 0,12(29)
	stw 4,484(29)
	stw 6,488(29)
	stw 5,248(29)
	stw 10,436(29)
	stw 8,68(29)
	stw 4,480(29)
	lfs 0,level+4@l(26)
	lfd 13,.LC2@l(28)
	stw 11,192(29)
	stw 7,196(29)
	stw 9,204(29)
	stw 11,188(29)
	fadd 0,0,13
	stw 9,200(29)
	frsp 0,0
	stfs 0,428(29)
	stw 25,208(29)
	lwz 0,776(29)
	ori 0,0,2048
	stw 0,776(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 NPC_Respawn,.Lfe1-NPC_Respawn
	.section	".rodata"
	.align 3
.LC5:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x41a00000
	.align 2
.LC7:
	.long 0x43480000
	.align 2
.LC8:
	.long 0x42700000
	.align 2
.LC9:
	.long 0x41200000
	.align 2
.LC10:
	.long 0x0
	.section	".text"
	.align 2
	.globl npc_idle
	.type	 npc_idle,@function
npc_idle:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	lis 9,.LC6@ha
	mr 31,3
	la 9,.LC6@l(9)
	lfs 12,4(31)
	li 28,0
	lfs 0,0(9)
	lwz 9,540(31)
	lfs 11,8(31)
	lfs 10,12(31)
	fadds 0,12,0
	cmpwi 0,9,0
	stfs 11,28(1)
	stfs 10,32(1)
	stfs 0,24(1)
	bc 12,2,.L8
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L8
	lfs 13,4(9)
	addi 3,1,8
	mr 4,3
	fsubs 13,13,12
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,10
	stfs 13,16(1)
	bl vectoangles
	lfs 0,8(1)
	lfs 13,12(1)
	lfs 12,16(1)
	stfs 0,16(31)
	stfs 13,20(31)
	stfs 12,24(31)
.L8:
	lis 11,level@ha
	lis 0,0x6666
	lwz 9,level@l(11)
	ori 0,0,26215
	mulhw 0,9,0
	srawi 11,9,31
	srawi 0,0,2
	subf 0,11,0
	mulli 0,0,10
	subf. 9,0,9
	bc 4,2,.L9
	stw 9,540(31)
	stw 9,920(31)
.L9:
	addi 30,31,4
	b .L10
.L12:
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L10
	stw 28,540(31)
.L10:
	lis 9,.LC7@ha
	mr 3,28
	la 9,.LC7@l(9)
	mr 4,30
	lfs 1,0(9)
	bl findradius
	mr. 28,3
	bc 4,2,.L12
	li 29,0
	b .L15
.L17:
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L15
	stw 29,920(31)
	stw 29,540(31)
.L15:
	lis 9,.LC8@ha
	mr 3,28
	la 9,.LC8@l(9)
	mr 4,30
	lfs 1,0(9)
	bl findradius
	mr. 28,3
	bc 4,2,.L17
	lwz 9,540(31)
	li 0,0
	stw 0,24(31)
	cmpwi 0,9,0
	bc 12,2,.L20
	lis 9,.LC9@ha
	lfs 1,20(31)
	li 0,1
	la 9,.LC9@l(9)
	mr 3,31
	stw 0,920(31)
	lfs 2,0(9)
	bl M_walkmove
.L20:
	lwz 0,920(31)
	cmpwi 0,0,1
	bc 4,2,.L21
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L21
	lwz 0,56(31)
	cmpwi 7,0,39
	xori 0,0,45
	subfic 9,0,0
	adde 0,9,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	or. 10,9,0
	bc 12,2,.L33
	li 0,40
	stw 0,56(31)
	b .L33
.L21:
	lis 11,.LC10@ha
	lfs 13,376(31)
	la 11,.LC10@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L24
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L24
	lwz 0,56(31)
	cmpwi 0,0,38
	bc 4,1,.L33
	li 0,0
	stw 0,56(31)
	b .L33
.L24:
	lwz 0,916(31)
	cmpwi 0,0,1
	bc 4,2,.L27
	li 0,100
	li 9,190
	stw 0,916(31)
	stw 9,56(31)
.L27:
	lwz 0,916(31)
	cmpwi 0,0,2
	bc 4,2,.L28
	li 0,100
	li 9,184
	stw 0,916(31)
	stw 9,56(31)
.L28:
	lwz 0,916(31)
	cmpwi 0,0,3
	bc 4,2,.L29
	li 0,100
	li 9,178
	stw 0,916(31)
	stw 9,56(31)
.L29:
	lwz 0,916(31)
	cmpwi 0,0,0
	bc 4,2,.L30
	li 0,100
	li 9,178
	stw 0,916(31)
	stw 9,56(31)
.L30:
	lwz 0,916(31)
	cmpwi 0,0,4
	bc 4,2,.L31
	li 0,100
	li 9,178
	stw 0,916(31)
	stw 9,56(31)
.L31:
	lwz 0,916(31)
	cmpwi 0,0,5
	bc 4,2,.L32
	li 0,100
	li 9,178
	stw 0,916(31)
	stw 9,56(31)
.L32:
	lwz 0,916(31)
	cmpwi 0,0,6
	bc 4,2,.L33
	li 0,100
	li 9,178
	stw 0,916(31)
	stw 9,56(31)
.L33:
	lwz 9,56(31)
	addi 9,9,1
	stw 9,56(31)
	lwz 11,56(31)
	xori 9,11,197
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,189
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L35
	cmpwi 0,11,183
	bc 4,2,.L34
.L35:
	lwz 0,68(31)
	rlwinm 0,0,0,17,15
	stw 0,68(31)
	b .L7
.L34:
	lis 9,level+4@ha
	lis 11,.LC5@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC5@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L7:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 npc_idle,.Lfe2-npc_idle
	.section	".rodata"
	.align 3
.LC11:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC12:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Cmd_NPC_f
	.type	 Cmd_NPC_f,@function
Cmd_NPC_f:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 4,.LC0@ha
	lwz 9,44(28)
	la 4,.LC0@l(4)
	mtlr 9
	blrl
	lis 9,.LC12@ha
	lfs 11,12(29)
	lis 10,.LC1@ha
	la 9,.LC12@l(9)
	lwz 6,68(29)
	lis 8,npc_dead@ha
	lfs 0,0(9)
	lis 7,npc_idle@ha
	li 0,0
	lfs 13,4(29)
	la 10,.LC1@l(10)
	li 26,100
	lfs 12,8(29)
	li 9,5
	li 11,1
	fadds 0,11,0
	la 8,npc_dead@l(8)
	la 7,npc_idle@l(7)
	stw 9,260(29)
	ori 6,6,32768
	li 4,200
	stfs 13,28(29)
	li 5,2
	li 27,-9999
	stw 11,512(29)
	stw 10,280(29)
	lis 24,level+4@ha
	lis 25,.LC11@ha
	stw 0,912(29)
	lis 9,0xc180
	lis 11,0x4180
	stw 0,44(29)
	lis 10,0xc1c0
	lis 23,0x4200
	stw 0,56(29)
	mr 3,29
	stw 0,612(29)
	stw 0,608(29)
	stw 0,492(29)
	stw 0,60(29)
	stw 0,900(29)
	stw 0,904(29)
	stw 0,908(29)
	stfs 12,32(29)
	stfs 0,12(29)
	stw 4,400(29)
	stw 5,248(29)
	stw 8,456(29)
	stw 26,484(29)
	stw 27,488(29)
	stw 7,436(29)
	stw 6,68(29)
	stfs 11,36(29)
	stw 26,480(29)
	lfs 0,level+4@l(24)
	lfd 13,.LC11@l(25)
	stw 9,188(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	stw 9,192(29)
	stw 10,196(29)
	stw 11,204(29)
	stw 23,208(29)
	stw 11,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Cmd_NPC_f,.Lfe3-Cmd_NPC_f
	.align 2
	.globl bot_pain
	.type	 bot_pain,@function
bot_pain:
	lwz 0,900(3)
	cmpwi 0,0,0
	bc 4,2,.L39
	lwz 0,904(3)
	cmpwi 0,0,0
	bc 4,2,.L39
	lwz 0,908(3)
	cmpwi 0,0,0
	bc 4,2,.L39
	lwz 0,912(3)
	cmpwi 0,0,0
	bc 4,2,.L39
	stw 0,60(3)
	blr
.L39:
	lwz 0,900(3)
	cmpwi 0,0,1
	mr 9,0
	bc 4,2,.L55
	lwz 0,904(3)
	cmpwi 0,0,0
	mr 11,0
	bc 4,2,.L41
	lwz 0,908(3)
	cmpwi 0,0,0
	bc 4,2,.L41
	lwz 0,912(3)
	cmpwi 0,0,0
	bc 4,2,.L41
	stw 9,60(3)
	blr
.L41:
	cmpwi 0,9,1
	bc 4,2,.L55
	cmpwi 0,11,1
	bc 4,2,.L43
	lwz 0,908(3)
	cmpwi 0,0,0
	bc 4,2,.L43
	lwz 0,912(3)
	cmpwi 0,0,0
	bc 4,2,.L43
	li 0,2
	stw 0,60(3)
	blr
.L43:
	cmpwi 0,9,1
	bc 4,2,.L55
	cmpwi 0,11,0
	bc 4,2,.L45
	lwz 0,908(3)
	cmpwi 0,0,1
	bc 4,2,.L45
	lwz 0,912(3)
	cmpwi 0,0,0
	bc 4,2,.L45
	li 0,3
	stw 0,60(3)
	blr
.L45:
	cmpwi 0,9,1
	bc 4,2,.L55
	cmpwi 0,11,0
	bc 4,2,.L47
	lwz 0,908(3)
	cmpwi 0,0,0
	bc 4,2,.L47
	lwz 0,912(3)
	cmpwi 0,0,1
	bc 4,2,.L47
	li 0,4
	stw 0,60(3)
	blr
.L47:
	cmpwi 0,9,1
	bc 4,2,.L55
	cmpwi 0,11,1
	bc 4,2,.L49
	lwz 0,908(3)
	cmpwi 0,0,1
	bc 4,2,.L49
	lwz 0,912(3)
	cmpwi 0,0,0
	bc 4,2,.L49
	li 0,5
	stw 0,60(3)
	blr
.L49:
	cmpwi 0,9,1
	bc 4,2,.L55
	cmpwi 0,11,0
	bc 4,2,.L51
	lwz 0,908(3)
	cmpwi 0,0,1
	bc 4,2,.L51
	lwz 0,912(3)
	cmpwi 0,0,1
	bc 4,2,.L51
	li 0,6
	stw 0,60(3)
	blr
.L51:
	cmpwi 0,9,1
	bc 4,2,.L55
	cmpwi 0,11,1
	bc 4,2,.L53
	lwz 0,908(3)
	cmpwi 0,0,0
	bc 4,2,.L53
	lwz 0,912(3)
	cmpwi 0,0,1
	bc 4,2,.L53
	li 0,7
	stw 0,60(3)
	blr
.L53:
	cmpwi 0,9,1
	bc 4,2,.L55
	cmpwi 0,11,1
	bc 4,2,.L55
	lwz 0,908(3)
	cmpwi 0,0,1
	bc 4,2,.L55
	lwz 0,912(3)
	cmpwi 0,0,1
	bc 4,2,.L55
	li 0,8
	stw 0,60(3)
	blr
.L55:
	cmpwi 0,9,0
	bclr 4,2
	lwz 0,904(3)
	cmpwi 0,0,1
	mr 11,0
	bc 4,2,.L57
	lwz 0,908(3)
	cmpwi 0,0,0
	bc 4,2,.L57
	lwz 0,912(3)
	cmpwi 0,0,0
	bc 4,2,.L57
	li 0,9
	stw 0,60(3)
	blr
.L57:
	cmpwi 0,9,0
	bclr 4,2
	cmpwi 0,11,1
	bc 4,2,.L59
	lwz 0,908(3)
	cmpwi 0,0,1
	bc 4,2,.L59
	lwz 0,912(3)
	cmpwi 0,0,0
	bc 4,2,.L59
	li 0,10
	stw 0,60(3)
	blr
.L59:
	cmpwi 0,9,0
	bclr 4,2
	cmpwi 0,11,1
	bc 4,2,.L61
	lwz 0,908(3)
	cmpwi 0,0,0
	bc 4,2,.L61
	lwz 0,912(3)
	cmpwi 0,0,1
	bc 4,2,.L61
	li 0,11
	stw 0,60(3)
	blr
.L61:
	cmpwi 0,9,0
	bclr 4,2
	cmpwi 0,11,1
	bc 4,2,.L63
	lwz 0,908(3)
	cmpwi 0,0,1
	bc 4,2,.L63
	lwz 0,912(3)
	cmpwi 0,0,1
	bc 4,2,.L63
	li 0,12
	stw 0,60(3)
	blr
.L63:
	cmpwi 0,9,0
	bclr 4,2
	cmpwi 0,11,0
	bc 4,2,.L65
	lwz 0,908(3)
	cmpwi 0,0,1
	bc 4,2,.L65
	lwz 0,912(3)
	cmpwi 0,0,0
	bc 4,2,.L65
	li 0,13
	stw 0,60(3)
	blr
.L65:
	cmpwi 0,9,0
	bclr 4,2
	cmpwi 0,11,0
	bc 4,2,.L67
	lwz 0,908(3)
	cmpwi 0,0,1
	bc 4,2,.L67
	lwz 0,912(3)
	cmpwi 0,0,1
	bc 4,2,.L67
	li 0,14
	stw 0,60(3)
	blr
.L67:
	cmpwi 0,9,0
	bclr 4,2
	cmpwi 0,11,0
	bclr 4,2
	lwz 0,908(3)
	cmpwi 0,0,0
	bclr 4,2
	lwz 0,912(3)
	cmpwi 0,0,1
	bclr 4,2
	li 0,15
	stw 0,60(3)
	blr
.Lfe4:
	.size	 bot_pain,.Lfe4-bot_pain
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
.LC13:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl npc_dead
	.type	 npc_dead,@function
npc_dead:
	lfs 0,36(3)
	lis 9,.LC13@ha
	li 0,0
	lfs 12,28(3)
	la 9,.LC13@l(9)
	lis 7,level+4@ha
	lfs 13,32(3)
	lis 8,NPC_Respawn@ha
	stfs 0,12(3)
	la 8,NPC_Respawn@l(8)
	stfs 12,4(3)
	stfs 13,8(3)
	lwz 11,84(5)
	lfs 11,0(9)
	lwz 9,3528(11)
	addi 9,9,1
	stw 9,3528(11)
	lwz 10,84(5)
	lwz 9,3984(10)
	addi 9,9,1
	stw 9,3984(10)
	stw 0,248(3)
	lfs 0,level+4@l(7)
	stw 8,436(3)
	fadds 0,0,11
	stfs 0,428(3)
	blr
.Lfe5:
	.size	 npc_dead,.Lfe5-npc_dead
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
