	.file	"debug.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".text"
	.align 2
	.globl NodeDebug
	.type	 NodeDebug,@function
NodeDebug:
	stwu 1,-112(1)
	stw 4,12(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L15
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L15:
	la 1,112(1)
	blr
.Lfe1:
	.size	 NodeDebug,.Lfe1-NodeDebug
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.align 2
	.globl OptimizeRouteCache
	.type	 OptimizeRouteCache,@function
OptimizeRouteCache:
	blr
.Lfe2:
	.size	 OptimizeRouteCache,.Lfe2-OptimizeRouteCache
	.align 2
	.globl CalcRoutes
	.type	 CalcRoutes,@function
CalcRoutes:
	blr
.Lfe3:
	.size	 CalcRoutes,.Lfe3-CalcRoutes
	.align 2
	.globl ClosestNodeToEnt
	.type	 ClosestNodeToEnt,@function
ClosestNodeToEnt:
	li 3,0
	blr
.Lfe4:
	.size	 ClosestNodeToEnt,.Lfe4-ClosestNodeToEnt
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.section	".text"
	.align 2
	.globl PathToEnt
	.type	 PathToEnt,@function
PathToEnt:
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	lfs 1,0(9)
	blr
.Lfe5:
	.size	 PathToEnt,.Lfe5-PathToEnt
	.align 2
	.globl Debug_ShowPathToGoal
	.type	 Debug_ShowPathToGoal,@function
Debug_ShowPathToGoal:
	blr
.Lfe6:
	.size	 Debug_ShowPathToGoal,.Lfe6-Debug_ShowPathToGoal
	.align 2
	.globl matching_trail
	.type	 matching_trail,@function
matching_trail:
	li 3,0
	blr
.Lfe7:
	.size	 matching_trail,.Lfe7-matching_trail
	.align 2
	.globl AddTrailToPortals
	.type	 AddTrailToPortals,@function
AddTrailToPortals:
	blr
.Lfe8:
	.size	 AddTrailToPortals,.Lfe8-AddTrailToPortals
	.align 2
	.globl GetGridPortal
	.type	 GetGridPortal,@function
GetGridPortal:
	li 3,0
	blr
.Lfe9:
	.size	 GetGridPortal,.Lfe9-GetGridPortal
	.align 2
	.globl CheckMoveForNodes
	.type	 CheckMoveForNodes,@function
CheckMoveForNodes:
	blr
.Lfe10:
	.size	 CheckMoveForNodes,.Lfe10-CheckMoveForNodes
	.align 2
	.globl CalcItemPaths
	.type	 CalcItemPaths,@function
CalcItemPaths:
	blr
.Lfe11:
	.size	 CalcItemPaths,.Lfe11-CalcItemPaths
	.align 2
	.globl WriteTrail
	.type	 WriteTrail,@function
WriteTrail:
	blr
.Lfe12:
	.size	 WriteTrail,.Lfe12-WriteTrail
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
