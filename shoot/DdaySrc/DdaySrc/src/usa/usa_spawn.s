	.file	"usa_spawn.c"
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
	.string	"colt45"
	.align 2
.LC1:
	.string	"weapon_m1"
	.align 2
.LC2:
	.string	"weapon_thompson"
	.align 2
.LC3:
	.string	"weapon_BAR"
	.align 2
.LC4:
	.string	"weapon_30cal"
	.align 2
.LC5:
	.string	"weapon_bazooka"
	.align 2
.LC6:
	.string	"weapon_sniper"
	.align 2
.LC7:
	.string	"ammo_grenades_usa"
	.align 2
.LC8:
	.string	"ammo_colt45"
	.align 2
.LC9:
	.string	"ammo_thompson"
	.align 2
.LC10:
	.string	"ammo_BAR"
	.align 2
.LC11:
	.string	"ammo_rockets"
	.align 2
.LC12:
	.string	"ammo_M1"
	.align 2
.LC13:
	.string	"ammo_m1903"
	.align 2
.LC14:
	.string	"ammo_HMG"
	.align 2
.LC15:
	.string	"models/objects/banner/usa/tris.md2"
	.globl sp_usa
	.section	".data"
	.align 2
	.type	 sp_usa,@object
sp_usa:
	.long .LC16
	.long SP_item_weapon_colt45
	.long .LC1
	.long SP_item_weapon_m1
	.long .LC2
	.long SP_item_weapon_thompson
	.long .LC3
	.long SP_item_weapon_BAR
	.long .LC4
	.long SP_item_weapon_30cal
	.long .LC5
	.long SP_item_weapon_bazooka
	.long .LC6
	.long SP_item_weapon_sniper
	.long .LC7
	.long SP_item_ammo_grenades_usa
	.long .LC8
	.long SP_item_ammo_colt45
	.long .LC17
	.long SP_item_ammo_m1
	.long .LC9
	.long SP_item_ammo_thompson
	.long .LC10
	.long SP_item_ammo_BAR
	.long .LC14
	.long SP_item_ammo_HMG
	.long .LC11
	.long SP_item_ammo_rockets
	.long .LC13
	.long SP_item_ammo_m1903
	.long .LC18
	.long SP_misc_banner_usa
	.long .LC19
	.long SP_misc_banner_brit
	.long .LC20
	.long SP_misc_flag_usa
	.long .LC21
	.long SP_misc_flag_brit
	.section	".rodata"
	.align 2
.LC21:
	.string	"misc_flag_brit"
	.align 2
.LC20:
	.string	"misc_flag_usa"
	.align 2
.LC19:
	.string	"misc_banner_brit"
	.align 2
.LC18:
	.string	"misc_banner_usa"
	.align 2
.LC17:
	.string	"ammo_m1"
	.align 2
.LC16:
	.string	"weapon_colt45"
	.size	 sp_usa,152
	.comm	g_edicts,4,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.lcomm	UserDLLImports,48,4
	.comm	usa_index,4,4
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
	.comm	Weapon_Grenade,4,4
	.comm	SP_misc_banner_generic,4,4
	.section	".text"
	.align 2
	.globl SP_item_weapon_colt45
	.type	 SP_item_weapon_colt45,@function
SP_item_weapon_colt45:
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
	.size	 SP_item_weapon_colt45,.Lfe1-SP_item_weapon_colt45
	.align 2
	.globl SP_item_weapon_m1
	.type	 SP_item_weapon_m1,@function
SP_item_weapon_m1:
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
	.size	 SP_item_weapon_m1,.Lfe2-SP_item_weapon_m1
	.align 2
	.globl SP_item_weapon_thompson
	.type	 SP_item_weapon_thompson,@function
SP_item_weapon_thompson:
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
	.size	 SP_item_weapon_thompson,.Lfe3-SP_item_weapon_thompson
	.align 2
	.globl SP_item_weapon_BAR
	.type	 SP_item_weapon_BAR,@function
SP_item_weapon_BAR:
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
	.size	 SP_item_weapon_BAR,.Lfe4-SP_item_weapon_BAR
	.align 2
	.globl SP_item_weapon_30cal
	.type	 SP_item_weapon_30cal,@function
SP_item_weapon_30cal:
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
	.size	 SP_item_weapon_30cal,.Lfe5-SP_item_weapon_30cal
	.align 2
	.globl SP_item_weapon_bazooka
	.type	 SP_item_weapon_bazooka,@function
SP_item_weapon_bazooka:
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
	.size	 SP_item_weapon_bazooka,.Lfe6-SP_item_weapon_bazooka
	.align 2
	.globl SP_item_weapon_sniper
	.type	 SP_item_weapon_sniper,@function
SP_item_weapon_sniper:
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
	.size	 SP_item_weapon_sniper,.Lfe7-SP_item_weapon_sniper
	.align 2
	.globl SP_item_ammo_grenades_usa
	.type	 SP_item_ammo_grenades_usa,@function
SP_item_ammo_grenades_usa:
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
	.size	 SP_item_ammo_grenades_usa,.Lfe8-SP_item_ammo_grenades_usa
	.align 2
	.globl SP_item_ammo_colt45
	.type	 SP_item_ammo_colt45,@function
SP_item_ammo_colt45:
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
	.size	 SP_item_ammo_colt45,.Lfe9-SP_item_ammo_colt45
	.align 2
	.globl SP_item_ammo_thompson
	.type	 SP_item_ammo_thompson,@function
SP_item_ammo_thompson:
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
	.size	 SP_item_ammo_thompson,.Lfe10-SP_item_ammo_thompson
	.align 2
	.globl SP_item_ammo_BAR
	.type	 SP_item_ammo_BAR,@function
SP_item_ammo_BAR:
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
	.size	 SP_item_ammo_BAR,.Lfe11-SP_item_ammo_BAR
	.align 2
	.globl SP_item_ammo_rockets
	.type	 SP_item_ammo_rockets,@function
SP_item_ammo_rockets:
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
	.size	 SP_item_ammo_rockets,.Lfe12-SP_item_ammo_rockets
	.align 2
	.globl SP_item_ammo_m1
	.type	 SP_item_ammo_m1,@function
SP_item_ammo_m1:
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
	.size	 SP_item_ammo_m1,.Lfe13-SP_item_ammo_m1
	.align 2
	.globl SP_item_ammo_m1903
	.type	 SP_item_ammo_m1903,@function
SP_item_ammo_m1903:
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
	.size	 SP_item_ammo_m1903,.Lfe14-SP_item_ammo_m1903
	.align 2
	.globl SP_item_ammo_HMG
	.type	 SP_item_ammo_HMG,@function
SP_item_ammo_HMG:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,FindItemByClassname@ha
	mr 28,3
	lwz 0,FindItemByClassname@l(9)
	lis 3,.LC14@ha
	lis 29,SpawnItem@ha
	la 3,.LC14@l(3)
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
.Lfe15:
	.size	 SP_item_ammo_HMG,.Lfe15-SP_item_ammo_HMG
	.align 2
	.globl SP_misc_banner_usa
	.type	 SP_misc_banner_usa,@function
SP_misc_banner_usa:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,SP_misc_banner_generic@ha
	lis 4,.LC15@ha
	lwz 0,SP_misc_banner_generic@l(9)
	la 4,.LC15@l(4)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 SP_misc_banner_usa,.Lfe16-SP_misc_banner_usa
	.align 2
	.globl SP_misc_banner_brit
	.type	 SP_misc_banner_brit,@function
SP_misc_banner_brit:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,SP_misc_banner_generic@ha
	lis 4,.LC15@ha
	lwz 0,SP_misc_banner_generic@l(9)
	la 4,.LC15@l(4)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 SP_misc_banner_brit,.Lfe17-SP_misc_banner_brit
	.align 2
	.globl SP_misc_flag_usa
	.type	 SP_misc_flag_usa,@function
SP_misc_flag_usa:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,SP_misc_banner_generic@ha
	lis 4,.LC15@ha
	lwz 0,SP_misc_banner_generic@l(9)
	la 4,.LC15@l(4)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 SP_misc_flag_usa,.Lfe18-SP_misc_flag_usa
	.align 2
	.globl SP_misc_flag_brit
	.type	 SP_misc_flag_brit,@function
SP_misc_flag_brit:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,SP_misc_banner_generic@ha
	lis 4,.LC15@ha
	lwz 0,SP_misc_banner_generic@l(9)
	la 4,.LC15@l(4)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 SP_misc_flag_brit,.Lfe19-SP_misc_flag_brit
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
