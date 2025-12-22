	.file	"rus_spawn.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 GlobalUserDLLList,@object
	.size	 GlobalUserDLLList,4
GlobalUserDLLList:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"weapon_tt33"
	.align 2
.LC1:
	.string	"weapon_m9130"
	.align 2
.LC2:
	.string	"weapon_ppsh41"
	.align 2
.LC3:
	.string	"weapon_pps43"
	.align 2
.LC4:
	.string	"weapon_dpm"
	.align 2
.LC5:
	.string	"weapon_panzer"
	.align 2
.LC6:
	.string	"weapon_m9130s"
	.align 2
.LC7:
	.string	"ammo_grenades_rus"
	.align 2
.LC8:
	.string	"ammo_tt33"
	.align 2
.LC9:
	.string	"ammo_m9130"
	.align 2
.LC10:
	.string	"ammo_ppsh41"
	.align 2
.LC11:
	.string	"ammo_pps43"
	.align 2
.LC12:
	.string	"ammo_dpm"
	.align 2
.LC13:
	.string	"ammo_rocketsG"
	.globl sp_rus
	.section	".data"
	.align 2
	.type	 sp_rus,@object
sp_rus:
	.long .LC0
	.long SP_item_weapon_tt33
	.long .LC1
	.long SP_item_weapon_m9130
	.long .LC2
	.long SP_item_weapon_ppsh41
	.long .LC3
	.long SP_item_weapon_pps43
	.long .LC4
	.long SP_item_weapon_dpm
	.long .LC5
	.long SP_item_weapon_panzer
	.long .LC6
	.long SP_item_weapon_m9130s
	.long .LC8
	.long SP_item_ammo_tt33
	.long .LC9
	.long SP_item_ammo_m9130
	.long .LC10
	.long SP_item_ammo_ppsh41
	.long .LC11
	.long SP_item_ammo_pps43
	.long .LC12
	.long SP_item_ammo_dpm
	.long .LC13
	.long SP_item_ammo_rocketsG
	.long .LC7
	.long SP_item_ammo_grenades_rus
	.size	 sp_rus,112
	.comm	g_edicts,4,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.lcomm	UserDLLImports,48,4
	.comm	rus_index,4,4
	.comm	is_silenced,4,4
	.comm	Pickup_Weapon,4,4
	.comm	Drop_Weapon,4,4
	.comm	Use_Weapon,4,4
	.comm	Pickup_Ammo,4,4
	.comm	Drop_Ammo,4,4
	.comm	ptrgi,4,4
	.comm	ptrGlobals,4,4
	.comm	ptrlevel,4,4
	.comm	ptrGame,4,4
	.comm	PlayerInsertCommands,4,4
	.comm	PlayerFindFunction,4,4
	.comm	PlayerInsertItem,4,4
	.comm	FindItem,4,4
	.comm	SpawnItem,4,4
	.comm	FindItemByClassname,4,4
	.comm	Weapon_Generic,4,4
	.comm	Weapon_Grenade,4,4
	.comm	ifchangewep,4,4
	.comm	fire_bullet,4,4
	.comm	AngleVectors,4,4
	.comm	P_ProjectSource,4,4
	.comm	PlayerNoise,4,4
	.comm	Cmd_Reload_f,4,4
	.comm	fire_rifle,4,4
	.comm	VectorScale,4,4
	.comm	fire_rocket,4,4
	.comm	PBM_FireFlameThrower,4,4
	.comm	Weapon_Pistol_Fire,4,4
	.comm	Weapon_Rifle_Fire,4,4
	.comm	Weapon_Submachinegun_Fire,4,4
	.comm	Weapon_LMG_Fire,4,4
	.comm	Weapon_HMG_Fire,4,4
	.comm	Weapon_Rocket_Fire,4,4
	.comm	Weapon_Sniper_Fire,4,4
	.comm	Play_WepSound,4,4
	.comm	fire_gun,4,4
	.section	".text"
	.align 2
	.globl SP_item_weapon_tt33
	.type	 SP_item_weapon_tt33,@function
SP_item_weapon_tt33:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItem@ha
	mr 28,3
	lwz 0,FindItem@l(9)
	lis 3,.LC0@ha
	lis 29,SpawnItem@ha
	la 3,.LC0@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 SP_item_weapon_tt33,.Lfe1-SP_item_weapon_tt33
	.align 2
	.globl SP_item_weapon_m9130
	.type	 SP_item_weapon_m9130,@function
SP_item_weapon_m9130:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC1@ha
	lis 29,SpawnItem@ha
	la 3,.LC1@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 SP_item_weapon_m9130,.Lfe2-SP_item_weapon_m9130
	.align 2
	.globl SP_item_weapon_ppsh41
	.type	 SP_item_weapon_ppsh41,@function
SP_item_weapon_ppsh41:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC2@ha
	lis 29,SpawnItem@ha
	la 3,.LC2@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SP_item_weapon_ppsh41,.Lfe3-SP_item_weapon_ppsh41
	.align 2
	.globl SP_item_weapon_pps43
	.type	 SP_item_weapon_pps43,@function
SP_item_weapon_pps43:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC3@ha
	lis 29,SpawnItem@ha
	la 3,.LC3@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 SP_item_weapon_pps43,.Lfe4-SP_item_weapon_pps43
	.align 2
	.globl SP_item_weapon_dpm
	.type	 SP_item_weapon_dpm,@function
SP_item_weapon_dpm:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC4@ha
	lis 29,SpawnItem@ha
	la 3,.LC4@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 SP_item_weapon_dpm,.Lfe5-SP_item_weapon_dpm
	.align 2
	.globl SP_item_weapon_panzer
	.type	 SP_item_weapon_panzer,@function
SP_item_weapon_panzer:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC5@ha
	lis 29,SpawnItem@ha
	la 3,.LC5@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_item_weapon_panzer,.Lfe6-SP_item_weapon_panzer
	.align 2
	.globl SP_item_weapon_m9130s
	.type	 SP_item_weapon_m9130s,@function
SP_item_weapon_m9130s:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC6@ha
	lis 29,SpawnItem@ha
	la 3,.LC6@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 SP_item_weapon_m9130s,.Lfe7-SP_item_weapon_m9130s
	.align 2
	.globl SP_item_ammo_grenades_rus
	.type	 SP_item_ammo_grenades_rus,@function
SP_item_ammo_grenades_rus:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC7@ha
	lis 29,SpawnItem@ha
	la 3,.LC7@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 SP_item_ammo_grenades_rus,.Lfe8-SP_item_ammo_grenades_rus
	.align 2
	.globl SP_item_ammo_tt33
	.type	 SP_item_ammo_tt33,@function
SP_item_ammo_tt33:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC8@ha
	lis 29,SpawnItem@ha
	la 3,.LC8@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 SP_item_ammo_tt33,.Lfe9-SP_item_ammo_tt33
	.align 2
	.globl SP_item_ammo_m9130
	.type	 SP_item_ammo_m9130,@function
SP_item_ammo_m9130:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC9@ha
	lis 29,SpawnItem@ha
	la 3,.LC9@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 SP_item_ammo_m9130,.Lfe10-SP_item_ammo_m9130
	.align 2
	.globl SP_item_ammo_ppsh41
	.type	 SP_item_ammo_ppsh41,@function
SP_item_ammo_ppsh41:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC10@ha
	lis 29,SpawnItem@ha
	la 3,.LC10@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 SP_item_ammo_ppsh41,.Lfe11-SP_item_ammo_ppsh41
	.align 2
	.globl SP_item_ammo_pps43
	.type	 SP_item_ammo_pps43,@function
SP_item_ammo_pps43:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC11@ha
	lis 29,SpawnItem@ha
	la 3,.LC11@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 SP_item_ammo_pps43,.Lfe12-SP_item_ammo_pps43
	.align 2
	.globl SP_item_ammo_dpm
	.type	 SP_item_ammo_dpm,@function
SP_item_ammo_dpm:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC12@ha
	lis 29,SpawnItem@ha
	la 3,.LC12@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 SP_item_ammo_dpm,.Lfe13-SP_item_ammo_dpm
	.align 2
	.globl SP_item_ammo_rocketsG
	.type	 SP_item_ammo_rocketsG,@function
SP_item_ammo_rocketsG:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC13@ha
	lis 29,SpawnItem@ha
	la 3,.LC13@l(3)
	mtlr 0
	blrl
	lwz 0,SpawnItem@l(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 SP_item_ammo_rocketsG,.Lfe14-SP_item_ammo_rocketsG
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
