	.file	"m_berserk.c"
gcc2_compiled.:
	.globl berserk_frames_stand
	.section	".data"
	.align 2
	.type	 berserk_frames_stand,@object
berserk_frames_stand:
	.long ai_stand
	.long 0x0
	.long berserk_fidget
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 berserk_frames_stand,60
	.globl berserk_move_stand
	.align 2
	.type	 berserk_move_stand,@object
	.size	 berserk_move_stand,16
berserk_move_stand:
	.long 0
	.long 4
	.long berserk_frames_stand
	.long 0
	.globl berserk_frames_stand_fidget
	.align 2
	.type	 berserk_frames_stand_fidget,@object
berserk_frames_stand_fidget:
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 berserk_frames_stand_fidget,240
	.globl berserk_move_stand_fidget
	.align 2
	.type	 berserk_move_stand_fidget,@object
	.size	 berserk_move_stand_fidget,16
berserk_move_stand_fidget:
	.long 5
	.long 24
	.long berserk_frames_stand_fidget
	.long berserk_stand
	.globl berserk_frames_walk
	.align 2
	.type	 berserk_frames_walk,@object
berserk_frames_walk:
	.long ai_walk
	.long 0x4111999a
	.long 0
	.long ai_walk
	.long 0x40c9999a
	.long 0
	.long ai_walk
	.long 0x409ccccd
	.long 0
	.long ai_walk
	.long 0x40d66666
	.long 0
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x41033333
	.long 0
	.long ai_walk
	.long 0x40e66666
	.long 0
	.long ai_walk
	.long 0x40c33333
	.long 0
	.long ai_walk
	.long 0x409ccccd
	.long 0
	.long ai_walk
	.long 0x40966666
	.long 0
	.long ai_walk
	.long 0x40966666
	.long 0
	.long ai_walk
	.long 0x4099999a
	.long 0
	.size	 berserk_frames_walk,144
	.globl berserk_move_walk
	.align 2
	.type	 berserk_move_walk,@object
	.size	 berserk_move_walk,16
berserk_move_walk:
	.long 25
	.long 35
	.long berserk_frames_walk
	.long 0
	.globl berserk_frames_run1
	.align 2
	.type	 berserk_frames_run1,@object
berserk_frames_run1:
	.long ai_run
	.long 0x41a80000
	.long 0
	.long ai_run
	.long 0x41300000
	.long 0
	.long ai_run
	.long 0x41a80000
	.long 0
	.long ai_run
	.long 0x41c80000
	.long 0
	.long ai_run
	.long 0x41900000
	.long 0
	.long ai_run
	.long 0x41980000
	.long 0
	.size	 berserk_frames_run1,72
	.globl berserk_move_run1
	.align 2
	.type	 berserk_move_run1,@object
	.size	 berserk_move_run1,16
berserk_move_run1:
	.long 36
	.long 41
	.long berserk_frames_run1
	.long 0
	.align 2
	.type	 aim.24,@object
	.size	 aim.24,12
aim.24:
	.long 0x42a00000
	.long 0x0
	.long 0xc1c00000
	.globl berserk_frames_attack_spike
	.align 2
	.type	 berserk_frames_attack_spike,@object
berserk_frames_attack_spike:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long berserk_swing
	.long ai_charge
	.long 0x0
	.long berserk_attack_spike
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 berserk_frames_attack_spike,96
	.globl berserk_move_attack_spike
	.align 2
	.type	 berserk_move_attack_spike,@object
	.size	 berserk_move_attack_spike,16
berserk_move_attack_spike:
	.long 76
	.long 83
	.long berserk_frames_attack_spike
	.long berserk_run
	.globl berserk_frames_attack_club
	.align 2
	.type	 berserk_frames_attack_club,@object
berserk_frames_attack_club:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long berserk_swing
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long berserk_attack_club
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 berserk_frames_attack_club,144
	.globl berserk_move_attack_club
	.align 2
	.type	 berserk_move_attack_club,@object
	.size	 berserk_move_attack_club,16
berserk_move_attack_club:
	.long 84
	.long 95
	.long berserk_frames_attack_club
	.long berserk_run
	.globl berserk_frames_attack_strike
	.align 2
	.type	 berserk_frames_attack_strike,@object
berserk_frames_attack_strike:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long berserk_swing
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long berserk_strike
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x411b3333
	.long 0
	.long ai_move
	.long 0x4159999a
	.long 0
	.size	 berserk_frames_attack_strike,168
	.globl berserk_move_attack_strike
	.align 2
	.type	 berserk_move_attack_strike,@object
	.size	 berserk_move_attack_strike,16
berserk_move_attack_strike:
	.long 96
	.long 109
	.long berserk_frames_attack_strike
	.long berserk_run
	.globl berserk_frames_pain1
	.align 2
	.type	 berserk_frames_pain1,@object
berserk_frames_pain1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 berserk_frames_pain1,48
	.globl berserk_move_pain1
	.align 2
	.type	 berserk_move_pain1,@object
	.size	 berserk_move_pain1,16
berserk_move_pain1:
	.long 199
	.long 202
	.long berserk_frames_pain1
	.long berserk_run
	.globl berserk_frames_pain2
	.align 2
	.type	 berserk_frames_pain2,@object
berserk_frames_pain2:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 berserk_frames_pain2,240
	.globl berserk_move_pain2
	.align 2
	.type	 berserk_move_pain2,@object
	.size	 berserk_move_pain2,16
berserk_move_pain2:
	.long 203
	.long 222
	.long berserk_frames_pain2
	.long berserk_run
	.globl berserk_frames_death1
	.align 2
	.type	 berserk_frames_death1,@object
berserk_frames_death1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 berserk_frames_death1,156
	.globl berserk_move_death1
	.align 2
	.type	 berserk_move_death1,@object
	.size	 berserk_move_death1,16
berserk_move_death1:
	.long 223
	.long 235
	.long berserk_frames_death1
	.long berserk_dead
	.globl berserk_frames_death2
	.align 2
	.type	 berserk_frames_death2,@object
berserk_frames_death2:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 berserk_frames_death2,96
	.globl berserk_move_death2
	.align 2
	.type	 berserk_move_death2,@object
	.size	 berserk_move_death2,16
berserk_move_death2:
	.long 236
	.long 243
	.long berserk_frames_death2
	.long berserk_dead
	.section	".rodata"
	.align 2
.LC3:
	.string	"misc/udeath.wav"
	.align 2
.LC4:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC5:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC6:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC7:
	.string	"berserk/berpain2.wav"
	.align 2
.LC8:
	.string	"berserk/berdeth2.wav"
	.align 2
.LC9:
	.string	"berserk/beridle1.wav"
	.align 2
.LC10:
	.string	"berserk/attack.wav"
	.align 2
.LC11:
	.string	"berserk/bersrch1.wav"
	.align 2
.LC12:
	.string	"berserk/sight.wav"
	.align 2
.LC13:
	.string	"models/monsters/berserk/tris.md2"
	.section	".text"
	.align 2
	.globl SP_monster_berserk
	.type	 SP_monster_berserk,@function
SP_monster_berserk:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	bl G_IsDeathmatch
	mr. 27,3
	bc 4,2,.L46
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_pain@ha
	lis 11,.LC8@ha
	stw 3,sound_pain@l(9)
	mtlr 10
	la 3,.LC8@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_die@ha
	lis 11,.LC9@ha
	stw 3,sound_die@l(9)
	mtlr 10
	la 3,.LC9@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle@ha
	lis 11,.LC10@ha
	stw 3,sound_idle@l(9)
	mtlr 10
	la 3,.LC10@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_punch@ha
	lis 11,.LC11@ha
	stw 3,sound_punch@l(9)
	mtlr 10
	la 3,.LC11@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_search@ha
	lis 11,.LC12@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC12@l(11)
	blrl
	lwz 10,32(29)
	lis 9,sound_sight@ha
	lis 11,.LC13@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC13@l(11)
	blrl
	lis 9,berserk_pain@ha
	lis 11,berserk_die@ha
	stw 27,812(31)
	lis 10,berserk_stand@ha
	lis 8,berserk_walk@ha
	stw 27,808(31)
	lis 7,berserk_run@ha
	la 9,berserk_pain@l(9)
	stw 3,40(31)
	la 11,berserk_die@l(11)
	la 10,berserk_stand@l(10)
	stw 9,452(31)
	la 8,berserk_walk@l(8)
	la 7,berserk_run@l(7)
	stw 11,456(31)
	lis 0,0xc1c0
	stw 10,788(31)
	lis 28,berserk_melee@ha
	stw 8,800(31)
	lis 6,berserk_sight@ha
	lis 5,berserk_search@ha
	stw 7,804(31)
	lis 4,berserk_move_stand@ha
	la 28,berserk_melee@l(28)
	stw 0,196(31)
	la 6,berserk_sight@l(6)
	la 5,berserk_search@l(5)
	la 4,berserk_move_stand@l(4)
	lis 26,0xc180
	stw 28,816(31)
	lis 25,0x4180
	lis 8,0x4200
	stw 26,192(31)
	li 9,5
	li 7,2
	stw 25,204(31)
	li 11,240
	li 10,-60
	stw 8,208(31)
	li 0,250
	lis 27,0x3f80
	stw 9,260(31)
	stw 7,248(31)
	mr 3,31
	stw 11,480(31)
	stw 10,488(31)
	stw 0,400(31)
	stw 6,820(31)
	stw 5,796(31)
	stw 4,772(31)
	stw 27,784(31)
	stw 26,188(31)
	stw 25,200(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	mr 3,31
	bl walkmonster_start
.L46:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 SP_monster_berserk,.Lfe1-SP_monster_berserk
	.comm	lights,4,4
	.comm	saved_client,780,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_blaster,4,4
	.comm	item_shotgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_supershotgun,4,4
	.comm	item_chaingun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_railgun,4,4
	.comm	item_bfg,4,4
	.comm	item_jacketarmor,4,4
	.comm	item_combatarmor,4,4
	.comm	item_bodyarmor,4,4
	.comm	item_armorshard,4,4
	.comm	item_powerscreen,4,4
	.comm	item_powershield,4,4
	.comm	item_adrenaline,4,4
	.comm	item_health,4,4
	.comm	item_stimpak,4,4
	.comm	item_health_large,4,4
	.comm	item_health_mega,4,4
	.comm	item_quad,4,4
	.comm	item_invulnerability,4,4
	.comm	item_silencer,4,4
	.comm	item_breather,4,4
	.comm	item_enviro,4,4
	.comm	item_pack,4,4
	.comm	item_bandolier,4,4
	.comm	item_ancient_head,4,4
	.comm	key_data_cd,4,4
	.comm	key_power_cube,4,4
	.comm	key_pyramid,4,4
	.comm	key_data_spinner,4,4
	.comm	key_pass,4,4
	.comm	key_blue_key,4,4
	.comm	key_red_key,4,4
	.comm	key_commander_head,4,4
	.comm	key_airstrike_target,4,4
	.section	".sbss","aw",@nobits
	.align 2
sound_pain:
	.space	4
	.size	 sound_pain,4
	.align 2
sound_die:
	.space	4
	.size	 sound_die,4
	.align 2
sound_idle:
	.space	4
	.size	 sound_idle,4
	.align 2
sound_punch:
	.space	4
	.size	 sound_punch,4
	.align 2
sound_sight:
	.space	4
	.size	 sound_sight,4
	.align 2
sound_search:
	.space	4
	.size	 sound_search,4
	.section	".rodata"
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
	.long 0x0
	.section	".text"
	.align 2
	.globl berserk_sight
	.type	 berserk_sight,@function
berserk_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC14@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC14@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 2,0(9)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 berserk_sight,.Lfe2-berserk_sight
	.section	".rodata"
	.align 2
.LC16:
	.long 0x3f800000
	.align 2
.LC17:
	.long 0x0
	.section	".text"
	.align 2
	.globl berserk_search
	.type	 berserk_search,@function
berserk_search:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_search@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC16@ha
	lwz 5,sound_search@l(11)
	la 9,.LC16@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 2,0(9)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 berserk_search,.Lfe3-berserk_search
	.section	".rodata"
	.align 2
.LC18:
	.long 0x46fffe00
	.align 3
.LC19:
	.long 0x3fc33333
	.long 0x33333333
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC21:
	.long 0x3f800000
	.align 2
.LC22:
	.long 0x40000000
	.align 2
.LC23:
	.long 0x0
	.section	".text"
	.align 2
	.globl berserk_fidget
	.type	 berserk_fidget,@function
berserk_fidget:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,776(31)
	andi. 9,0,1
	bc 4,2,.L9
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC20@ha
	lis 10,.LC18@ha
	la 11,.LC20@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC19@ha
	lfs 11,.LC18@l(10)
	lfd 12,.LC19@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,1,.L9
	lis 9,berserk_move_stand_fidget@ha
	lis 11,gi+16@ha
	la 9,berserk_move_stand_fidget@l(9)
	lis 10,sound_idle@ha
	stw 9,772(31)
	mr 3,31
	li 4,1
	lis 9,.LC21@ha
	lwz 0,gi+16@l(11)
	la 9,.LC21@l(9)
	lis 11,.LC22@ha
	lwz 5,sound_idle@l(10)
	lfs 1,0(9)
	la 11,.LC22@l(11)
	mtlr 0
	lis 9,.LC23@ha
	lfs 2,0(11)
	la 9,.LC23@l(9)
	lfs 3,0(9)
	blrl
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 berserk_fidget,.Lfe4-berserk_fidget
	.align 2
	.globl berserk_stand
	.type	 berserk_stand,@function
berserk_stand:
	lis 9,berserk_move_stand@ha
	la 9,berserk_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe5:
	.size	 berserk_stand,.Lfe5-berserk_stand
	.align 2
	.globl berserk_walk
	.type	 berserk_walk,@function
berserk_walk:
	lis 9,berserk_move_walk@ha
	la 9,berserk_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe6:
	.size	 berserk_walk,.Lfe6-berserk_walk
	.align 2
	.globl berserk_run
	.type	 berserk_run,@function
berserk_run:
	lwz 0,776(3)
	andi. 9,0,1
	bc 12,2,.L14
	lis 9,berserk_move_stand@ha
	la 9,berserk_move_stand@l(9)
	stw 9,772(3)
	blr
.L14:
	lis 9,berserk_move_run1@ha
	la 9,berserk_move_run1@l(9)
	stw 9,772(3)
	blr
.Lfe7:
	.size	 berserk_run,.Lfe7-berserk_run
	.align 2
	.globl berserk_attack_spike
	.type	 berserk_attack_spike,@function
berserk_attack_spike:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl rand
	lis 0,0x2aaa
	mr 5,3
	ori 0,0,43691
	srawi 9,5,31
	mulhw 0,5,0
	lis 4,aim.24@ha
	mr 3,29
	la 4,aim.24@l(4)
	li 6,400
	subf 0,9,0
	mulli 0,0,6
	subf 5,0,5
	addi 5,5,15
	bl fire_hit
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 berserk_attack_spike,.Lfe8-berserk_attack_spike
	.section	".rodata"
	.align 2
.LC24:
	.long 0x3f800000
	.align 2
.LC25:
	.long 0x0
	.section	".text"
	.align 2
	.globl berserk_swing
	.type	 berserk_swing,@function
berserk_swing:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_punch@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC24@ha
	lwz 5,sound_punch@l(11)
	la 9,.LC24@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 2,0(9)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 berserk_swing,.Lfe9-berserk_swing
	.align 2
	.globl berserk_attack_club
	.type	 berserk_attack_club,@function
berserk_attack_club:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lis 0,0x42a0
	lfs 0,188(29)
	lis 9,0xc080
	stw 0,8(1)
	stw 9,16(1)
	stfs 0,12(1)
	bl rand
	lis 0,0x2aaa
	mr 5,3
	ori 0,0,43691
	srawi 9,5,31
	mulhw 0,5,0
	mr 3,29
	addi 4,1,8
	li 6,400
	subf 0,9,0
	mulli 0,0,6
	subf 5,0,5
	addi 5,5,5
	bl fire_hit
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 berserk_attack_club,.Lfe10-berserk_attack_club
	.align 2
	.globl berserk_strike
	.type	 berserk_strike,@function
berserk_strike:
	blr
.Lfe11:
	.size	 berserk_strike,.Lfe11-berserk_strike
	.align 2
	.globl berserk_melee
	.type	 berserk_melee,@function
berserk_melee:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl rand
	andi. 0,3,1
	bc 4,2,.L21
	lis 9,berserk_move_attack_spike@ha
	la 9,berserk_move_attack_spike@l(9)
	b .L48
.L21:
	lis 9,berserk_move_attack_club@ha
	la 9,berserk_move_attack_club@l(9)
.L48:
	stw 9,772(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 berserk_melee,.Lfe12-berserk_melee
	.section	".rodata"
	.align 2
.LC26:
	.long 0x46fffe00
	.align 2
.LC27:
	.long 0x40400000
	.align 2
.LC28:
	.long 0x3f800000
	.align 2
.LC29:
	.long 0x0
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC31:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl berserk_pain
	.type	 berserk_pain,@function
berserk_pain:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,5
	lwz 0,484(31)
	lwz 11,480(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L24
	li 0,1
	stw 0,60(31)
.L24:
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L23
	lis 9,.LC27@ha
	lis 10,.LC28@ha
	la 9,.LC27@l(9)
	la 10,.LC28@l(10)
	lfs 31,0(9)
	lis 11,gi+16@ha
	mr 3,31
	lis 9,sound_pain@ha
	lfs 1,0(10)
	li 4,2
	lwz 5,sound_pain@l(9)
	lis 10,.LC29@ha
	fadds 0,13,31
	lis 9,.LC28@ha
	la 10,.LC29@l(10)
	la 9,.LC28@l(9)
	lfs 3,0(10)
	lfs 2,0(9)
	stfs 0,464(31)
	lwz 0,gi+16@l(11)
	mtlr 0
	blrl
	lis 9,skill@ha
	lwz 11,skill@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L23
	cmpwi 0,30,19
	bc 4,1,.L28
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,12(1)
	lis 10,.LC30@ha
	lis 11,.LC26@ha
	la 10,.LC30@l(10)
	stw 0,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	lis 10,.LC31@ha
	lfs 12,.LC26@l(11)
	la 10,.LC31@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L27
.L28:
	lis 9,berserk_move_pain1@ha
	la 9,berserk_move_pain1@l(9)
	b .L49
.L27:
	lis 9,berserk_move_pain2@ha
	la 9,berserk_move_pain2@l(9)
.L49:
	stw 9,772(31)
.L23:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 berserk_pain,.Lfe13-berserk_pain
	.align 2
	.globl berserk_dead
	.type	 berserk_dead,@function
berserk_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,0xc1c0
	lwz 0,184(9)
	lis 5,0xc180
	lis 6,0x4180
	stw 11,196(9)
	lis 8,0xc100
	li 7,7
	ori 0,0,2
	li 10,0
	stw 5,192(9)
	stw 6,204(9)
	lis 11,gi+72@ha
	stw 8,208(9)
	stw 7,260(9)
	stw 0,184(9)
	stw 10,428(9)
	stw 5,188(9)
	stw 6,200(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 berserk_dead,.Lfe14-berserk_dead
	.section	".rodata"
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl berserk_die
	.type	 berserk_die,@function
berserk_die:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	mr 28,6
	lwz 9,480(31)
	lwz 0,488(31)
	cmpw 0,9,0
	bc 12,1,.L32
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	lis 27,.LC4@ha
	lis 26,.LC5@ha
	li 30,2
	mtlr 9
	blrl
	lis 9,.LC32@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC32@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 2,0(9)
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
.L36:
	mr 3,31
	la 4,.LC4@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L36
	li 30,4
.L41:
	mr 3,31
	la 4,.LC5@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L41
	lis 4,.LC6@ha
	mr 5,28
	la 4,.LC6@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(31)
	b .L31
.L32:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L31
	lis 9,gi+16@ha
	lis 11,sound_die@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC32@ha
	lwz 5,sound_die@l(11)
	la 9,.LC32@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 2,0(9)
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
	cmpwi 0,28,49
	li 0,2
	li 9,1
	stw 0,492(31)
	stw 9,512(31)
	bc 4,1,.L44
	lis 9,berserk_move_death1@ha
	la 9,berserk_move_death1@l(9)
	b .L50
.L44:
	lis 9,berserk_move_death2@ha
	la 9,berserk_move_death2@l(9)
.L50:
	stw 9,772(31)
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 berserk_die,.Lfe15-berserk_die
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
