	.file	"usa_guninfo.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 GlobalUserDLLList,@object
	.size	 GlobalUserDLLList,4
GlobalUserDLLList:
	.long 0
	.globl usaguninfo
	.section	".data"
	.align 2
	.type	 usaguninfo,@object
usaguninfo:
	.long 4
	.space	12
	.long 75
	.space	12
	.long 6
	.long 77
	.long 62
	.long 62
	.long .LC0
	.long 49
	.space	8
	.long .LC1
	.long 56
	.space	8
	.long .LC2
	.long 0
	.long 1
	.long 25
	.long 0x0
	.long 0
	.space	12
	.long 4
	.space	12
	.long 76
	.space	12
	.long 6
	.long 78
	.long 64
	.long 67
	.long .LC3
	.long 56
	.space	8
	.long .LC4
	.long 58
	.space	8
	.long .LC5
	.long .LC6
	.long 3
	.long 45
	.long 0x0
	.long 0
	.space	12
	.long 4
	.long 5
	.space	8
	.long 79
	.long 80
	.space	8
	.long 5
	.long 80
	.long 71
	.long 71
	.long .LC7
	.long 47
	.space	8
	.long .LC8
	.long 63
	.space	8
	.long .LC9
	.long 0
	.long 10
	.long 25
	.long 0x0
	.long 0
	.space	12
	.long 4
	.long 5
	.space	8
	.long 77
	.long 78
	.space	8
	.long 5
	.long 78
	.long 69
	.long 69
	.long .LC10
	.long 47
	.space	8
	.long .LC11
	.long 62
	.space	8
	.long .LC12
	.long 0
	.long 4
	.long 35
	.long 0x0
	.long 0
	.space	12
	.long 20
	.long 21
	.space	8
	.long 90
	.long 91
	.space	8
	.long 21
	.long 91
	.long 79
	.long 82
	.long .LC13
	.long 64
	.long 72
	.space	4
	.long .LC14
	.long 76
	.space	8
	.long .LC15
	.long 0
	.long 5
	.long 50
	.long 0x0
	.long 0
	.space	12
	.long 4
	.space	12
	.long 73
	.space	12
	.long 5
	.long 75
	.long 65
	.long 65
	.long .LC16
	.long 0
	.space	8
	.long .LC17
	.long 59
	.space	8
	.long .LC18
	.long 0
	.long 8
	.long 1000
	.long 0x43fa0000
	.long 0
	.space	12
	.long 4
	.space	12
	.long 52
	.long 60
	.long 75
	.long 80
	.long 26
	.long 80
	.long 43
	.long 43
	.long .LC19
	.long 28
	.space	8
	.long .LC20
	.long 38
	.space	8
	.long .LC21
	.long .LC22
	.long 11
	.long 100
	.long 0x0
	.long 0
	.long .LC23
	.long 66
	.space	4
	.section	".rodata"
	.align 2
.LC23:
	.string	"usa/m1903/bolt.wav"
	.align 2
.LC22:
	.string	"usa/m1903/lastround.wav"
	.align 2
.LC21:
	.string	"usa/m1903/fire.wav"
	.align 2
.LC20:
	.string	"usa/m1903/reload.wav"
	.align 2
.LC19:
	.string	"usa/m1903/unload.wav"
	.align 2
.LC18:
	.string	"usa/bazooka/fire.wav"
	.align 2
.LC17:
	.string	"usa/bazooka/reload.wav"
	.align 2
.LC16:
	.string	"usa/bazooka/unload.wav"
	.align 2
.LC15:
	.string	"usa/bhmg/fire.wav"
	.align 2
.LC14:
	.string	"usa/bhmg/reload.wav"
	.align 2
.LC13:
	.string	"usa/bhmg/unload.wav"
	.align 2
.LC12:
	.string	"usa/bar/fire.wav"
	.align 2
.LC11:
	.string	"usa/bar/reload.wav"
	.align 2
.LC10:
	.string	"usa/bar/unload.wav"
	.align 2
.LC9:
	.string	"usa/thompson/fire.wav"
	.align 2
.LC8:
	.string	"usa/thompson/reload.wav"
	.align 2
.LC7:
	.string	"usa/thompson/unload.wav"
	.align 2
.LC6:
	.string	"usa/m1/lastround.wav"
	.align 2
.LC5:
	.string	"usa/m1/fire.wav"
	.align 2
.LC4:
	.string	"usa/m1/reload.wav"
	.align 2
.LC3:
	.string	"usa/m1/unload.wav"
	.align 2
.LC2:
	.string	"usa/colt45/fire.wav"
	.align 2
.LC1:
	.string	"usa/colt45/reload.wav"
	.align 2
.LC0:
	.string	"usa/colt45/unload.wav"
	.size	 usaguninfo,812
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
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
