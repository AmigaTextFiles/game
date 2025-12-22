	.file	"rus_main.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 GlobalUserDLLList,@object
	.size	 GlobalUserDLLList,4
GlobalUserDLLList:
	.long 0
	.globl rus_MOS_List
	.section	".data"
	.align 2
	.type	 rus_MOS_List,@object
rus_MOS_List:
	.long 0
	.space	64
	.long .LC0
	.long .LC1
	.long .LC2
	.long 8
	.long 0
	.long 0
	.long .LC3
	.long 2
	.long 0
	.long 0
	.long 1
	.long 99
	.long 0x41f00000
	.long 0x42700000
	.long 0x3f59999a
	.long 0x3f000000
	.long .LC4
	.long .LC5
	.long .LC6
	.long .LC7
	.long 5
	.long .LC8
	.long 3
	.long .LC3
	.long 2
	.long .LC9
	.long 1
	.long 2
	.long 1
	.long 0x41f00000
	.long 0x42700000
	.long 0x3f43d70a
	.long 0x3f000000
	.long .LC10
	.long .LC11
	.long .LC12
	.long .LC13
	.long 5
	.long 0
	.long 0
	.long .LC3
	.long 2
	.long 0
	.long 0
	.long 3
	.long 2
	.long 0x41f00000
	.long 0x42700000
	.long 0x3f38f5c3
	.long 0x3f000000
	.long .LC14
	.long .LC15
	.long .LC16
	.long .LC17
	.long 5
	.long 0
	.long 0
	.long .LC3
	.long 2
	.long 0
	.long 0
	.long 4
	.long 2
	.long 0x42340000
	.long 0x42820000
	.long 0x3f2e147b
	.long 0x3f0ccccd
	.long .LC18
	.long .LC19
	.long .LC20
	.long .LC21
	.long 5
	.long .LC8
	.long 3
	.long .LC3
	.long 2
	.long 0
	.long 0
	.long 5
	.long 2
	.long 0x41a00000
	.long 0x42480000
	.long 0x3f6f5c29
	.long 0x0
	.long .LC22
	.long .LC23
	.long .LC24
	.long .LC7
	.long 5
	.long 0
	.long 0
	.long .LC3
	.long 2
	.long 0
	.long 0
	.long 6
	.long 1
	.long 0x42200000
	.long 0x42820000
	.long 0x3f4eb852
	.long 0x3ea8f5c3
	.long .LC25
	.long .LC26
	.long .LC27
	.long .LC28
	.long 5
	.long .LC8
	.long 3
	.long .LC3
	.long 2
	.long .LC29
	.long 1
	.long 7
	.long 1
	.long 0x41f00000
	.long 0x42700000
	.long 0x3f38f5c3
	.long 0x3f19999a
	.long .LC30
	.long .LC31
	.long .LC32
	.long .LC33
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 8
	.long 4
	.long 0x41700000
	.long 0x42700000
	.long 0x3f6f5c29
	.long 0x3f4ccccd
	.long .LC34
	.long .LC35
	.long .LC36
	.long .LC35
	.long 0
	.long 0
	.long 0
	.long .LC3
	.long 2
	.long 0
	.long 0
	.long 9
	.long 1
	.long 0x420c0000
	.long 0x42700000
	.long 0x3f2e147b
	.long 0x3f333333
	.long .LC37
	.section	".rodata"
	.align 2
.LC37:
	.string	"info_flamethrower_start"
	.align 2
.LC36:
	.string	"class_flamethrower"
	.align 2
.LC35:
	.string	"Flamethrower"
	.align 2
.LC34:
	.string	"info_medic_start"
	.align 2
.LC33:
	.string	"Morphine"
	.align 2
.LC32:
	.string	"class_medic"
	.align 2
.LC31:
	.string	"Medic"
	.align 2
.LC30:
	.string	"info_engineer_start"
	.align 2
.LC29:
	.string	"TNT"
	.align 2
.LC28:
	.string	"Panzerschreck"
	.align 2
.LC27:
	.string	"class_engineer"
	.align 2
.LC26:
	.string	"Engineer"
	.align 2
.LC25:
	.string	"info_special_start"
	.align 2
.LC24:
	.string	"class_special"
	.align 2
.LC23:
	.string	"Airborne"
	.align 2
.LC22:
	.string	"info_sniper_start"
	.align 2
.LC21:
	.string	"M91/30 Sniper"
	.align 2
.LC20:
	.string	"class_sniper"
	.align 2
.LC19:
	.string	"Sniper"
	.align 2
.LC18:
	.string	"info_hgunner_start"
	.align 2
.LC17:
	.string	"dpm"
	.align 2
.LC16:
	.string	"class_hmg"
	.align 2
.LC15:
	.string	"Heavy Gunner"
	.align 2
.LC14:
	.string	"info_lgunner_start"
	.align 2
.LC13:
	.string	"PPS43"
	.align 2
.LC12:
	.string	"class_lmg"
	.align 2
.LC11:
	.string	"Light Gunner"
	.align 2
.LC10:
	.string	"info_officer_start"
	.align 2
.LC9:
	.string	"Binoculars"
	.align 2
.LC8:
	.string	"Tokarev TT33"
	.align 2
.LC7:
	.string	"ppsh41"
	.align 2
.LC6:
	.string	"class_officer"
	.align 2
.LC5:
	.string	"Officer"
	.align 2
.LC4:
	.string	"info_infantry_start"
	.align 2
.LC3:
	.string	"F1 Grenade"
	.align 2
.LC2:
	.string	"M91/30"
	.align 2
.LC1:
	.string	"class_infantry"
	.align 2
.LC0:
	.string	"Infantry"
	.size	 rus_MOS_List,680
	.section	".sdata","aw"
	.align 2
	.type	 AlreadyInit,@object
	.size	 AlreadyInit,4
AlreadyInit:
	.long 0
	.align 2
	.type	 AlreadyLoad,@object
	.size	 AlreadyLoad,4
AlreadyLoad:
	.long 0
	.section	".rodata"
	.align 2
.LC38:
	.string	"fire_bullet"
	.align 2
.LC39:
	.string	"ifchangewep"
	.align 2
.LC40:
	.string	"Weapon_Generic"
	.align 2
.LC41:
	.string	"FindItem"
	.align 2
.LC42:
	.string	"SpawnItem"
	.align 2
.LC43:
	.string	"FindItemByClassname"
	.align 2
.LC44:
	.string	"Use_Weapon"
	.align 2
.LC45:
	.string	"AngleVectors"
	.align 2
.LC46:
	.string	"P_ProjectSource"
	.align 2
.LC47:
	.string	"PlayerNoise"
	.align 2
.LC48:
	.string	"Cmd_Reload_f"
	.align 2
.LC49:
	.string	"Pickup_Weapon"
	.align 2
.LC50:
	.string	"Drop_Weapon"
	.align 2
.LC51:
	.string	"fire_rifle"
	.align 2
.LC52:
	.string	"VectorScale"
	.align 2
.LC53:
	.string	"fire_rocket"
	.align 2
.LC54:
	.string	"PBM_FireFlameThrower"
	.align 2
.LC55:
	.string	"Pickup_Ammo"
	.align 2
.LC56:
	.string	"Drop_Ammo"
	.align 2
.LC57:
	.string	"Weapon_Pistol_Fire"
	.align 2
.LC58:
	.string	"Weapon_Rifle_Fire"
	.align 2
.LC59:
	.string	"Weapon_Submachinegun_Fire"
	.align 2
.LC60:
	.string	"Weapon_LMG_Fire"
	.align 2
.LC61:
	.string	"Weapon_HMG_Fire"
	.align 2
.LC62:
	.string	"Weapon_Rocket_Fire"
	.align 2
.LC63:
	.string	"Weapon_Sniper_Fire"
	.align 2
.LC64:
	.string	"Weapon_Grenade"
	.section	".text"
	.align 2
	.globl InitFunctions
	.type	 InitFunctions,@function
InitFunctions:
	stwu 1,-80(1)
	mflr 0
	stmw 14,8(1)
	stw 0,84(1)
	lis 29,PlayerFindFunction@ha
	lis 3,.LC38@ha
	lwz 9,PlayerFindFunction@l(29)
	la 3,.LC38@l(3)
	lis 28,fire_bullet@ha
	lis 27,ifchangewep@ha
	lis 26,Weapon_Generic@ha
	mtlr 9
	lis 25,FindItem@ha
	lis 24,SpawnItem@ha
	lis 23,FindItemByClassname@ha
	lis 22,Use_Weapon@ha
	lis 21,AngleVectors@ha
	lis 20,P_ProjectSource@ha
	lis 19,Cmd_Reload_f@ha
	lis 18,Pickup_Weapon@ha
	blrl
	lis 17,Drop_Weapon@ha
	lis 16,fire_rifle@ha
	stw 3,fire_bullet@l(28)
	lis 15,VectorScale@ha
	lis 14,fire_rocket@ha
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC39@ha
	lis 28,PlayerNoise@ha
	la 3,.LC39@l(3)
	lis 31,PBM_FireFlameThrower@ha
	mtlr 9
	lis 30,Pickup_Ammo@ha
	blrl
	stw 3,ifchangewep@l(27)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC40@ha
	lis 27,Weapon_Pistol_Fire@ha
	la 3,.LC40@l(3)
	mtlr 9
	blrl
	stw 3,Weapon_Generic@l(26)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
	mtlr 9
	blrl
	stw 3,FindItem@l(25)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC42@ha
	la 3,.LC42@l(3)
	mtlr 9
	blrl
	stw 3,SpawnItem@l(24)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC43@ha
	la 3,.LC43@l(3)
	mtlr 9
	blrl
	stw 3,FindItemByClassname@l(23)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC44@ha
	la 3,.LC44@l(3)
	mtlr 9
	blrl
	stw 3,Use_Weapon@l(22)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	mtlr 9
	blrl
	stw 3,AngleVectors@l(21)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	mtlr 9
	blrl
	stw 3,P_ProjectSource@l(20)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	mtlr 9
	blrl
	stw 3,PlayerNoise@l(28)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
	mtlr 9
	blrl
	stw 3,Cmd_Reload_f@l(19)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 9
	blrl
	stw 3,Pickup_Weapon@l(18)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC50@ha
	la 3,.LC50@l(3)
	mtlr 9
	blrl
	stw 3,Drop_Weapon@l(17)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	mtlr 9
	blrl
	stw 3,fire_rifle@l(16)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	mtlr 9
	blrl
	stw 3,VectorScale@l(15)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC53@ha
	la 3,.LC53@l(3)
	mtlr 9
	blrl
	stw 3,fire_rocket@l(14)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC54@ha
	la 3,.LC54@l(3)
	mtlr 9
	blrl
	stw 3,PBM_FireFlameThrower@l(31)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC55@ha
	la 3,.LC55@l(3)
	mtlr 9
	blrl
	stw 3,Pickup_Ammo@l(30)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC56@ha
	la 3,.LC56@l(3)
	mtlr 9
	blrl
	lis 9,Drop_Ammo@ha
	stw 3,Drop_Ammo@l(9)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	mtlr 9
	blrl
	stw 3,Weapon_Pistol_Fire@l(27)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC58@ha
	la 3,.LC58@l(3)
	mtlr 9
	blrl
	lis 9,Weapon_Rifle_Fire@ha
	stw 3,Weapon_Rifle_Fire@l(9)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC59@ha
	la 3,.LC59@l(3)
	mtlr 9
	blrl
	lis 9,Weapon_Submachinegun_Fire@ha
	stw 3,Weapon_Submachinegun_Fire@l(9)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC60@ha
	la 3,.LC60@l(3)
	mtlr 9
	blrl
	lis 9,Weapon_LMG_Fire@ha
	stw 3,Weapon_LMG_Fire@l(9)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC61@ha
	la 3,.LC61@l(3)
	mtlr 9
	blrl
	lis 9,Weapon_HMG_Fire@ha
	stw 3,Weapon_HMG_Fire@l(9)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC62@ha
	la 3,.LC62@l(3)
	mtlr 9
	blrl
	lis 9,Weapon_Rocket_Fire@ha
	stw 3,Weapon_Rocket_Fire@l(9)
	lwz 9,PlayerFindFunction@l(29)
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	mtlr 9
	blrl
	lis 9,Weapon_Sniper_Fire@ha
	lwz 0,PlayerFindFunction@l(29)
	stw 3,Weapon_Sniper_Fire@l(9)
	lis 3,.LC64@ha
	mtlr 0
	la 3,.LC64@l(3)
	blrl
	lis 9,Weapon_Grenade@ha
	stw 3,Weapon_Grenade@l(9)
	lwz 0,84(1)
	mtlr 0
	lmw 14,8(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 InitFunctions,.Lfe1-InitFunctions
	.globl vec3_origin
	.section	".data"
	.align 2
	.type	 vec3_origin,@object
	.size	 vec3_origin,12
vec3_origin:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 2
.LC65:
	.string	"scope_rus"
	.align 2
.LC66:
	.string	"victory_rus"
	.align 2
.LC67:
	.string	"rus/victory.wav"
	.align 2
.LC68:
	.string	"players/rus/tris.md2"
	.align 2
.LC69:
	.string	"players/rus/w_tt33.md2"
	.align 2
.LC70:
	.string	"players/rus/w_m9130.md2"
	.align 2
.LC71:
	.string	"players/rus/w_ppsh41.md2"
	.align 2
.LC72:
	.string	"players/rus/w_pps43.md2"
	.align 2
.LC73:
	.string	"players/rus/w_dpm.md2"
	.align 2
.LC74:
	.string	"players/rus/w_panzer.md2"
	.align 2
.LC75:
	.string	"players/rus/w_m9130s.md2"
	.align 2
.LC76:
	.string	"players/rus/a_f1grenade.md2"
	.align 2
.LC77:
	.string	"players/rus/w_colt45.md2"
	.align 2
.LC78:
	.string	"players/rus/w_m1.md2"
	.align 2
.LC79:
	.string	"players/rus/w_thompson.md2"
	.align 2
.LC80:
	.string	"players/rus/w_bar.md2"
	.align 2
.LC81:
	.string	"players/rus/w_bhmg.md2"
	.align 2
.LC82:
	.string	"players/rus/w_bazooka.md2"
	.align 2
.LC83:
	.string	"players/rus/w_m1903.md2"
	.align 2
.LC84:
	.string	"players/rus/a_grenade.md2"
	.align 2
.LC85:
	.string	"players/rus/w_flame.md2"
	.align 2
.LC86:
	.string	"players/rus/w_morphine.md2"
	.align 2
.LC87:
	.string	"players/rus/w_knife.md2"
	.align 2
.LC88:
	.string	"players/rus/w_binoc.md2"
	.section	".text"
	.align 2
	.globl UserPrecache
	.type	 UserPrecache,@function
UserPrecache:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,ptrgi@ha
	lis 3,.LC65@ha
	lwz 9,ptrgi@l(29)
	la 3,.LC65@l(3)
	lwz 0,40(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	lwz 0,40(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC67@ha
	la 3,.LC67@l(3)
	lwz 0,36(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC68@ha
	la 3,.LC68@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC69@ha
	la 3,.LC69@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC70@ha
	la 3,.LC70@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC71@ha
	la 3,.LC71@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC72@ha
	la 3,.LC72@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC73@ha
	la 3,.LC73@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC74@ha
	la 3,.LC74@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC77@ha
	la 3,.LC77@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC79@ha
	la 3,.LC79@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC81@ha
	la 3,.LC81@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC82@ha
	la 3,.LC82@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC83@ha
	la 3,.LC83@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC84@ha
	la 3,.LC84@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC85@ha
	la 3,.LC85@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC86@ha
	la 3,.LC86@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC87@ha
	la 3,.LC87@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 9,ptrgi@l(29)
	lis 3,.LC88@ha
	la 3,.LC88@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 UserPrecache,.Lfe2-UserPrecache
	.section	".rodata"
	.align 2
.LC89:
	.string	" += UserDLLInit reached <%s>\n"
	.align 2
.LC90:
	.string	"RUS"
	.section	".data"
	.align 2
	.type	 userdll_export,@object
	.size	 userdll_export,116
userdll_export:
	.long 1
	.string	"Unofficial"
	.space	21
	.long UserDLLMD5
	.long UserDLLInit
	.long UserDLLStop
	.long UserDLLStartLevel
	.long UserDLLEndLevel
	.long UserDLLPlayerRespawns
	.long UserDLLPlayerDies
	.long rus_MOS_List
	.string	"rus"
	.space	12
	.string	"rus"
	.space	28
	.section	".rodata"
	.align 2
.LC91:
	.string	" += GetAPI reached <%s>\n"
	.globl DLL_ExportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ExportSymbols,@object
DLL_ExportSymbols:
	.long dllFindResource
	.long .LC92
	.long dllLoadResource
	.long .LC93
	.long dllFreeResource
	.long .LC94
	.long RUSGetAPI
	.long .LC95
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC95:
	.string	"RUSGetAPI"
	.align 2
.LC94:
	.string	"dllFreeResource"
	.align 2
.LC93:
	.string	"dllLoadResource"
	.align 2
.LC92:
	.string	"dllFindResource"
	.size	 DLL_ExportSymbols,40
	.globl DLL_ImportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ImportSymbols,@object
DLL_ImportSymbols:
	.long 0
	.long 0
	.long 0
	.long 0
	.size	 DLL_ImportSymbols,16
	.comm	g_edicts,4,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.section	".text"
	.align 2
	.globl DLL_Init
	.type	 DLL_Init,@function
DLL_Init:
	li 3,1
	blr
.Lfe3:
	.size	 DLL_Init,.Lfe3-DLL_Init
	.align 2
	.globl DLL_DeInit
	.type	 DLL_DeInit,@function
DLL_DeInit:
	blr
.Lfe4:
	.size	 DLL_DeInit,.Lfe4-DLL_DeInit
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
	.align 2
	.globl UserDLLMD5
	.type	 UserDLLMD5,@function
UserDLLMD5:
	li 0,0
	stb 0,0(3)
	blr
.Lfe5:
	.size	 UserDLLMD5,.Lfe5-UserDLLMD5
	.align 2
	.globl UserDLLInit
	.type	 UserDLLInit,@function
UserDLLInit:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 10,AlreadyInit@ha
	lwz 0,AlreadyInit@l(10)
	cmpwi 0,0,0
	bc 4,2,.L9
	lis 9,ptrgi@ha
	lis 3,.LC89@ha
	lwz 11,ptrgi@l(9)
	lis 4,.LC90@ha
	la 3,.LC89@l(3)
	la 4,.LC90@l(4)
	li 0,1
	lwz 9,4(11)
	stw 0,AlreadyInit@l(10)
	mtlr 9
	crxor 6,6,6
	blrl
	bl InitFunctions
	bl InitItems
	bl UserPrecache
.L9:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 UserDLLInit,.Lfe6-UserDLLInit
	.align 2
	.globl UserDLLStop
	.type	 UserDLLStop,@function
UserDLLStop:
	blr
.Lfe7:
	.size	 UserDLLStop,.Lfe7-UserDLLStop
	.align 2
	.globl UserDLLStartLevel
	.type	 UserDLLStartLevel,@function
UserDLLStartLevel:
	blr
.Lfe8:
	.size	 UserDLLStartLevel,.Lfe8-UserDLLStartLevel
	.align 2
	.globl UserDLLEndLevel
	.type	 UserDLLEndLevel,@function
UserDLLEndLevel:
	blr
.Lfe9:
	.size	 UserDLLEndLevel,.Lfe9-UserDLLEndLevel
	.align 2
	.globl UserDLLPlayerRespawns
	.type	 UserDLLPlayerRespawns,@function
UserDLLPlayerRespawns:
	blr
.Lfe10:
	.size	 UserDLLPlayerRespawns,.Lfe10-UserDLLPlayerRespawns
	.align 2
	.globl UserDLLPlayerDies
	.type	 UserDLLPlayerDies,@function
UserDLLPlayerDies:
	blr
.Lfe11:
	.size	 UserDLLPlayerDies,.Lfe11-UserDLLPlayerDies
	.align 2
	.globl RUSGetAPI
	.type	 RUSGetAPI,@function
RUSGetAPI:
	stwu 1,-80(1)
	mflr 0
	stmw 16,16(1)
	stw 0,84(1)
	mr 9,4
	mr 17,3
	lwz 19,8(9)
	lis 3,.LC91@ha
	lis 4,.LC90@ha
	la 4,.LC90@l(4)
	la 3,.LC91@l(3)
	lwz 16,24(9)
	lwz 12,4(19)
	lis 5,g_edicts@ha
	lis 21,PlayerInsertItem@ha
	lwz 23,36(9)
	lis 20,PlayerInsertCommands@ha
	lis 22,PlayerFindFunction@ha
	mtlr 12
	lwz 28,28(9)
	lis 18,ptrgi@ha
	lis 25,ptrGlobals@ha
	lwz 6,32(9)
	lis 24,ptrlevel@ha
	lis 27,ptrGame@ha
	lwz 7,12(9)
	lis 26,is_silenced@ha
	lis 29,rus_index@ha
	lwz 0,4(9)
	lwz 11,0(9)
	lwz 10,20(9)
	lwz 8,16(9)
	stw 6,PlayerFindFunction@l(22)
	stw 8,g_edicts@l(5)
	stw 7,ptrGlobals@l(25)
	stw 0,ptrlevel@l(24)
	stw 11,ptrGame@l(27)
	stw 10,is_silenced@l(26)
	stw 23,PlayerInsertItem@l(21)
	stw 28,PlayerInsertCommands@l(20)
	stw 16,rus_index@l(29)
	stw 19,ptrgi@l(18)
	crxor 6,6,6
	blrl
	lis 4,userdll_export@ha
	mr 3,17
	la 4,userdll_export@l(4)
	li 5,116
	crxor 6,6,6
	bl memcpy
	mr 3,17
	lwz 0,84(1)
	mtlr 0
	lmw 16,16(1)
	la 1,80(1)
	blr
.Lfe12:
	.size	 RUSGetAPI,.Lfe12-RUSGetAPI
	.align 2
	.globl dllFindResource
	.type	 dllFindResource,@function
dllFindResource:
	li 3,0
	blr
.Lfe13:
	.size	 dllFindResource,.Lfe13-dllFindResource
	.align 2
	.globl dllLoadResource
	.type	 dllLoadResource,@function
dllLoadResource:
	li 3,0
	blr
.Lfe14:
	.size	 dllLoadResource,.Lfe14-dllLoadResource
	.align 2
	.globl dllFreeResource
	.type	 dllFreeResource,@function
dllFreeResource:
	blr
.Lfe15:
	.size	 dllFreeResource,.Lfe15-dllFreeResource
	.comm	SegList,4,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
