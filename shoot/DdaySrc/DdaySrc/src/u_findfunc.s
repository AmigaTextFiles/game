	.file	"u_findfunc.c"
gcc2_compiled.:
	.globl GlobalGameFunctionArray
	.section	".data"
	.align 2
	.type	 GlobalGameFunctionArray,@object
GlobalGameFunctionArray:
	.long .LC0
	.long AI_SetSightClient
	.long .LC1
	.long AddPointToBounds
	.long .LC2
	.long Add_Ammo
	.long .LC3
	.long AngleMove_Begin
	.long .LC4
	.long AngleMove_Calc
	.long .LC5
	.long AngleMove_Done
	.long .LC6
	.long AngleMove_Final
	.long .LC7
	.long AngleVectors
	.long .LC8
	.long AnglesNormalize
	.long .LC9
	.long ApplyFirstAid
	.long .LC10
	.long ArmorIndex
	.long .LC11
	.long AttackFinished
	.long .LC12
	.long BecomeExplosion1
	.long .LC13
	.long BecomeExplosion2
	.long .LC14
	.long BeginIntermission
	.long .LC15
	.long BigFloat
	.long .LC16
	.long BigLong
	.long .LC17
	.long Blade_touch
	.long .LC18
	.long BoxOnPlaneSide
	.long .LC18
	.long BoxOnPlaneSide
	.long .LC19
	.long BoxOnPlaneSide2
	.long .LC20
	.long COM_DefaultExtension
	.long .LC21
	.long COM_FileBase
	.long .LC22
	.long COM_FileExtension
	.long .LC23
	.long COM_FilePath
	.long .LC24
	.long COM_Parse
	.long .LC25
	.long COM_SkipPath
	.long .LC26
	.long COM_StripExtension
	.long .LC27
	.long CanDamage
	.long .LC28
	.long ChangeWeapon
	.long .LC29
	.long CheckDMRules
	.long .LC30
	.long CheckTeamDamage
	.long .LC31
	.long M_ChooseMOS
	.long .LC32
	.long ChooseTeam
	.long .LC33
	.long CleanUpCmds
	.long .LC34
	.long ClearBounds
	.long .LC35
	.long ClearUserDLLs
	.long .LC36
	.long ClientBegin
	.long .LC37
	.long ClientBeginDeathmatch
	.long .LC38
	.long ClientBeginServerFrame
	.long .LC39
	.long ClientCommand
	.long .LC40
	.long ClientConnect
	.long .LC41
	.long ClientDisconnect
	.long .LC42
	.long ClientEndServerFrame
	.long .LC43
	.long ClientEndServerFrames
	.long .LC44
	.long ClientObituary
	.long .LC45
	.long ClientTeam
	.long .LC46
	.long ClientThink
	.long .LC47
	.long ClientUserinfoChanged
	.long .LC48
	.long ClipGibVelocity
	.long .LC49
	.long ClipVelocity
	.long .LC50
	.long Cmd_AliciaMode_f
	.long .LC51
	.long Cmd_Arty_f
	.long .LC52
	.long Cmd_Drop_f
	.long .LC53
	.long Cmd_GameVersion_f
	.long .LC54
	.long Cmd_Give_f
	.long .LC55
	.long Cmd_God_f
	.long .LC56
	.long Cmd_Help_f
	.long .LC57
	.long Cmd_InvDrop_f
	.long .LC58
	.long Cmd_InvUse_f
	.long .LC59
	.long Cmd_Inven_f
	.long .LC60
	.long Cmd_Kill_f
	.long .LC61
	.long Cmd_Noclip_f
	.long .LC62
	.long Cmd_Notarget_f
	.long .LC63
	.long Cmd_Players_f
	.long .LC64
	.long Cmd_PutAway_f
	.long .LC65
	.long Cmd_Reload_f
	.long .LC66
	.long Cmd_Say_f
	.long .LC67
	.long Cmd_Scope_f
	.long .LC68
	.long Cmd_Score_f
	.long .LC69
	.long Cmd_SexPistols_f
	.long .LC70
	.long Cmd_Shout_f
	.long .LC71
	.long Cmd_Stance
	.long .LC72
	.long Cmd_Use_f
	.long .LC73
	.long Cmd_Wave_f
	.long .LC74
	.long Cmd_WeapLast_f
	.long .LC75
	.long Cmd_WeapNext_f
	.long .LC76
	.long Cmd_WeapPrev_f
	.long .LC77
	.long Com_PageInMemory
	.long .LC78
	.long Com_Printf
	.long .LC79
	.long Com_sprintf
	.long .LC80
	.long CopyToBodyQue
	.long .LC81
	.long CrossProduct
	.long .LC82
	.long Damage_Loc
	.long .LC83
	.long DeathmatchScoreboard
	.long .LC84
	.long DDayScoreboardMessage
	.long .LC85
	.long DoAnarchyStuff
	.long .LC86
	.long DoEndOM
	.long .LC87
	.long DoRespawn
	.long .LC88
	.long Drop_Ammo
	.long .LC89
	.long Drop_General
	.long .LC90
	.long Drop_Item
	.long .LC91
	.long Drop_PowerArmor
	.long .LC92
	.long Drop_Weapon
	.long .LC93
	.long ED_CallSpawn
	.long .LC94
	.long ED_NewString
	.long .LC95
	.long ED_ParseEdict
	.long .LC96
	.long ED_ParseField
	.long .LC97
	.long EndDMLevel
	.long .LC98
	.long EndObserverMode
	.long .LC99
	.long ExitLevel
	.long .LC100
	.long FacingIdeal
	.long .LC101
	.long FetchClientEntData
	.long .LC102
	.long FindCommand
	.long .LC103
	.long FindItem
	.long .LC104
	.long FindItemByClassname
	.long .LC105
	.long FindNextPickup
	.long .LC106
	.long Find_Mission_Start_Point
	.long .LC107
	.long FloatNoSwap
	.long .LC108
	.long FloatSwap
	.long .LC109
	.long G_CopyString
	.long .LC110
	.long G_Find
	.long .LC111
	.long G_FindTeams
	.long .LC112
	.long G_FreeEdict
	.long .LC113
	.long G_InitEdict
	.long .LC114
	.long G_PickTarget
	.long .LC115
	.long G_ProjectSource
	.long .LC116
	.long G_RunEntity
	.long .LC117
	.long G_RunFrame
	.long .LC118
	.long G_SetClientEffects
	.long .LC119
	.long G_SetClientEvent
	.long .LC120
	.long G_SetClientFrame
	.long .LC121
	.long G_SetClientSound
	.long .LC122
	.long G_SetMovedir
	.long .LC123
	.long G_SetStats
	.long .LC124
	.long G_Spawn
	.long .LC125
	.long G_TouchSolids
	.long .LC126
	.long G_TouchTriggers
	.long .LC127
	.long G_UseTargets
	.long .LC128
	.long GetGameAPI
	.long .LC129
	.long GetItemByIndex
	.long .LC130
	.long Give_Class_Ammo
	.long .LC131
	.long Give_Class_Weapon
	.long .LC132
	.long HelpComputer
	.long .LC133
	.long HuntTarget
	.long .LC134
	.long In_Vector_Range
	.long .LC135
	.long Info_RemoveKey
	.long .LC136
	.long Info_SetValueForKey
	.long .LC137
	.long Info_Validate
	.long .LC138
	.long Info_ValueForKey
	.long .LC139
	.long InitBodyQue
	.long .LC140
	.long InitClientPersistant
	.long .LC141
	.long InitClientResp
	.long .LC142
	.long InitGame
	.long .LC143
	.long InitItems
	.long .LC144
	.long InitMOS_List
	.long .LC145
	.long InitTrigger
	.long .LC146
	.long InitializeUserDLLs
	.long .LC147
	.long InsertCmds
	.long .LC148
	.long InsertEntity
	.long .LC149
	.long InsertItem
	.long .LC150
	.long IsFemale
	.long .LC151
	.long KillBox
	.long .LC152
	.long Killed
	.long .LC153
	.long Knife_Throw
	.long .LC154
	.long LerpAngle
	.long .LC155
	.long LevelExitUserDLLs
	.long .LC156
	.long LevelStartUserDLLs
	.long .LC157
	.long LittleFloat
	.long .LC158
	.long LittleLong
	.long .LC159
	.long LoadUserDLLs
	.long .LC160
	.long LongNoSwap
	.long .LC161
	.long LongSwap
	.long .LC162
	.long LookAtKiller
	.long .LC163
	.long M_MOS_Join
	.long .LC164
	.long M_CatagorizePosition
	.long .LC165
	.long M_ChangeYaw
	.long .LC166
	.long M_CheckAttack
	.long .LC167
	.long M_CheckBottom
	.long .LC168
	.long M_CheckGround
	.long .LC169
	.long M_FlyCheck
	.long .LC170
	.long M_MoveFrame
	.long .LC171
	.long M_MoveToGoal
	.long .LC172
	.long M_ReactToDamage
	.long .LC173
	.long M_SetEffects
	.long .LC174
	.long M_WorldEffects
	.long .LC175
	.long M_droptofloor
	.long .LC176
	.long M_walkmove
	.long .LC177
	.long MegaHealth_think
	.long .LC178
	.long MoveClientToIntermission
	.long .LC179
	.long Move_Begin
	.long .LC180
	.long Move_Calc
	.long .LC181
	.long Move_Done
	.long .LC182
	.long Move_Final
	.long .LC183
	.long NoAmmoWeaponChange
	.long .LC184
	.long PBM_ActivePowerArmor
	.long .LC185
	.long PBM_BecomeSmallExplosion
	.long .LC186
	.long PBM_BecomeSmoke
	.long .LC187
	.long PBM_BecomeSteam
	.long .LC188
	.long PBM_Burn
	.long .LC189
	.long PBM_BurnDamage
	.long .LC190
	.long PBM_BurnRadius
	.long .LC191
	.long PBM_CheckFire
	.long .LC192
	.long PBM_CheckMaster
	.long .LC193
	.long PBM_CloudBurst
	.long .LC194
	.long PBM_CloudBurstDamage
	.long .LC195
	.long PBM_EasyFireDrop
	.long .LC196
	.long PBM_FireAngleSpread
	.long .LC197
	.long PBM_FireDrop
	.long .LC198
	.long PBM_FireDropTouch
	.long .LC199
	.long PBM_FireFlameThrower
	.long .LC200
	.long PBM_FireFlamer
	.long .LC201
	.long PBM_FireResistant
	.long .LC202
	.long PBM_FireSpot
	.long .LC203
	.long PBM_FireballTouch
	.long .LC204
	.long PBM_FlameCloud
	.long .LC205
	.long PBM_FlameOut
	.long .LC206
	.long PBM_FlameThrowerThink
	.long .LC207
	.long PBM_FlameThrowerTouch
	.long .LC208
	.long PBM_Ignite
	.long .LC209
	.long PBM_InWater
	.long .LC210
	.long PBM_Inflammable
	.long .LC211
	.long PBM_KillAllFires
	.long .LC212
	.long PBM_SmallExplodeThink
	.long .LC213
	.long PBM_StartSmallExplosion
	.long .LC214
	.long PM_trace
	.long .LC215
	.long P_DamageFeedback
	.long .LC216
	.long P_FallingDamage
	.long .LC217
	.long P_ProjectSource
	.long .LC218
	.long P_WorldEffects
	.long .LC219
	.long PerpendicularVector
	.long .LC220
	.long Pickup_Adrenaline
	.long .LC221
	.long Pickup_Ammo
	.long .LC222
	.long Pickup_Armor
	.long .LC223
	.long Pickup_Bandolier
	.long .LC224
	.long Pickup_Health
	.long .LC225
	.long Pickup_Key
	.long .LC226
	.long Pickup_Pack
	.long .LC227
	.long Pickup_PowerArmor
	.long .LC228
	.long Pickup_Powerup
	.long .LC229
	.long Pickup_Weapon
	.long .LC230
	.long PlayerDiesUserDLLs
	.long .LC231
	.long PlayerNoise
	.long .LC232
	.long PlayerSort
	.long .LC233
	.long PlayerSpawnUserDLLs
	.long .LC234
	.long PlayerTrail_Add
	.long .LC235
	.long PlayerTrail_Init
	.long .LC236
	.long PlayerTrail_LastSpot
	.long .LC237
	.long PlayerTrail_New
	.long .LC238
	.long PlayerTrail_PickFirst
	.long .LC239
	.long PlayerTrail_PickNext
	.long .LC240
	.long PlayersRangeFromSpot
	.long .LC241
	.long PowerArmorType
	.long .LC242
	.long PrecacheItem
	.long .LC243
	.long PrintCmds
	.long .LC244
	.long PrintPmove
	.long .LC245
	.long ProjectPointOnPlane
	.long .LC246
	.long PutClientInServer
	.long .LC247
	.long Q_fabs
	.long .LC248
	.long Q_log2
	.long .LC249
	.long Q_strcasecmp
	.long .LC250
	.long Q_stricmp
	.long .LC251
	.long Q_strncasecmp
	.long .LC252
	.long R_ConcatRotations
	.long .LC253
	.long R_ConcatTransforms
	.long .LC254
	.long ReadClient
	.long .LC255
	.long ReadEdict
	.long .LC256
	.long ReadField
	.long .LC257
	.long ReadGame
	.long .LC258
	.long ReadLevel
	.long .LC259
	.long ReadLevelLocals
	.long .LC260
	.long RemoveEntity
	.long .LC261
	.long RotatePointAroundVector
	.long .LC262
	.long SP_func_areaportal
	.long .LC263
	.long SP_func_button
	.long .LC264
	.long SP_func_clock
	.long .LC265
	.long SP_func_conveyor
	.long .LC266
	.long SP_func_door
	.long .LC267
	.long SP_func_door_rotating
	.long .LC268
	.long SP_func_door_secret
	.long .LC269
	.long SP_func_explosive
	.long .LC270
	.long SP_func_killbox
	.long .LC271
	.long SP_func_object
	.long .LC272
	.long SP_func_plat
	.long .LC273
	.long SP_func_rotating
	.long .LC274
	.long SP_func_timer
	.long .LC275
	.long SP_func_train
	.long .LC276
	.long SP_func_wall
	.long .LC277
	.long SP_func_water
	.long .LC278
	.long SP_info_Engineer_Start
	.long .LC279
	.long SP_info_Flamethrower_Start
	.long .LC280
	.long SP_info_H_Gunner_Start
	.long .LC281
	.long SP_info_Infantry_Start
	.long .LC282
	.long SP_info_L_Gunner_Start
	.long .LC283
	.long SP_info_Officer_Start
	.long .LC284
	.long SP_info_Medic_Start
	.long .LC285
	.long SP_info_Mission_Results
	.long .LC286
	.long SP_info_Sniper_Start
	.long .LC287
	.long SP_info_Special_Start
	.long .LC288
	.long SP_info_notnull
	.long .LC289
	.long SP_info_null
	.long .LC290
	.long SP_info_player_coop
	.long .LC291
	.long SP_info_player_deathmatch
	.long .LC292
	.long SP_info_player_intermission
	.long .LC293
	.long SP_info_player_start
	.long .LC294
	.long SP_info_reinforcement_start
	.long .LC295
	.long SP_info_team_start
	.long .LC296
	.long SP_item_ammo_grenades
	.long .LC297
	.long SP_item_ammo_napalm
	.long .LC298
	.long SP_item_armor_body
	.long .LC299
	.long SP_item_armor_combat
	.long .LC300
	.long SP_item_armor_jacket
	.long .LC301
	.long SP_item_armor_shard
	.long .LC302
	.long SP_item_health
	.long .LC303
	.long SP_item_health_large
	.long .LC304
	.long SP_item_health_mega
	.long .LC305
	.long SP_item_health_small
	.long .LC306
	.long SP_item_key_blue_key
	.long .LC307
	.long SP_item_key_red_key
	.long .LC308
	.long SP_item_powerup_adrenaline
	.long .LC309
	.long SP_item_powerup_bandolier
	.long .LC310
	.long SP_item_powerup_breather
	.long .LC311
	.long SP_item_powerup_enviro
	.long .LC312
	.long SP_item_powerup_pack
	.long .LC313
	.long SP_item_powerup_silencer
	.long .LC314
	.long SP_item_weapon_flamethrower
	.long .LC315
	.long SP_item_weapon_mine
	.long .LC316
	.long SP_light
	.long .LC317
	.long SP_light_mine1
	.long .LC318
	.long SP_light_mine2
	.long .LC319
	.long SP_misc_actor
	.long .LC320
	.long SP_misc_banner
	.long .LC321
	.long SP_misc_banner_x
	.long .LC322
	.long SP_misc_banner_1
	.long .LC323
	.long SP_misc_banner_2
	.long .LC324
	.long SP_misc_banner_3
	.long .LC325
	.long SP_misc_banner_4
	.long .LC326
	.long SP_misc_bigviper
	.long .LC327
	.long SP_misc_blackhole
	.long .LC328
	.long SP_misc_deadsoldier
	.long .LC329
	.long SP_misc_easterchick
	.long .LC330
	.long SP_misc_easterchick2
	.long .LC331
	.long SP_misc_eastertank
	.long .LC332
	.long SP_misc_explobox
	.long .LC333
	.long SP_misc_gib_arm
	.long .LC334
	.long SP_misc_gib_head
	.long .LC335
	.long SP_misc_gib_leg
	.long .LC336
	.long SP_misc_insane
	.long .LC337
	.long SP_misc_satellite_dish
	.long .LC338
	.long SP_misc_strogg_ship
	.long .LC339
	.long SP_misc_teleporter
	.long .LC340
	.long SP_misc_teleporter_dest
	.long .LC341
	.long SP_misc_viper
	.long .LC342
	.long SP_misc_viper_bomb
	.long .LC343
	.long SP_monster_boss2
	.long .LC344
	.long SP_monster_boss3_stand
	.long .LC345
	.long SP_monster_brain
	.long .LC346
	.long SP_monster_chick
	.long .LC347
	.long SP_monster_commander_body
	.long .LC348
	.long SP_monster_flipper
	.long .LC349
	.long SP_monster_floater
	.long .LC350
	.long SP_monster_flyer
	.long .LC351
	.long SP_monster_hover
	.long .LC352
	.long SP_monster_jorg
	.long .LC353
	.long SP_monster_mutant
	.long .LC354
	.long SP_monster_supertank
	.long .LC355
	.long SP_monster_tank
	.long .LC356
	.long SP_path_corner
	.long .LC357
	.long SP_point_combat
	.long .LC358
	.long SP_target_actor
	.long .LC359
	.long SP_target_blaster
	.long .LC360
	.long SP_target_changelevel
	.long .LC361
	.long SP_target_character
	.long .LC362
	.long SP_target_crosslevel_target
	.long .LC363
	.long SP_target_crosslevel_trigger
	.long .LC364
	.long SP_target_earthquake
	.long .LC365
	.long SP_target_explosion
	.long .LC366
	.long SP_target_goal
	.long .LC367
	.long SP_target_help
	.long .LC368
	.long SP_target_laser
	.long .LC369
	.long SP_target_lightramp
	.long .LC370
	.long SP_target_objective
	.long .LC371
	.long SP_target_secret
	.long .LC372
	.long SP_target_spawner
	.long .LC373
	.long SP_target_speaker
	.long .LC374
	.long SP_target_splash
	.long .LC375
	.long SP_target_string
	.long .LC376
	.long SP_target_temp_entity
	.long .LC377
	.long SP_trigger_always
	.long .LC378
	.long SP_trigger_counter
	.long .LC379
	.long SP_trigger_elevator
	.long .LC380
	.long SP_trigger_enough_troops
	.long .LC381
	.long SP_trigger_gravity
	.long .LC382
	.long SP_trigger_hurt
	.long .LC383
	.long SP_trigger_key
	.long .LC384
	.long SP_trigger_monsterjump
	.long .LC385
	.long SP_trigger_multiple
	.long .LC386
	.long SP_trigger_once
	.long .LC387
	.long SP_trigger_push
	.long .LC388
	.long SP_trigger_relay
	.long .LC389
	.long SP_turret_base
	.long .LC390
	.long SP_turret_breach
	.long .LC391
	.long SP_viewthing
	.long .LC392
	.long SP_worldspawn
	.long .LC393
	.long SV_AddBlend
	.long .LC394
	.long SV_AddGravity
	.long .LC395
	.long SV_AddRotationalFriction
	.long .LC396
	.long SV_CalcBlend
	.long .LC397
	.long SV_CalcGunOffset
	.long .LC398
	.long SV_CalcRoll
	.long .LC399
	.long SV_CalcViewOffset
	.long .LC400
	.long SV_CheckVelocity
	.long .LC401
	.long SV_CloseEnough
	.long .LC402
	.long SV_FixCheckBottom
	.long .LC403
	.long SV_FlyMove
	.long .LC404
	.long SV_Impact
	.long .LC405
	.long SV_NewChaseDir
	.long .LC406
	.long SV_Physics_Noclip
	.long .LC407
	.long SV_Physics_None
	.long .LC408
	.long SV_Physics_Pusher
	.long .LC409
	.long SV_Physics_Step
	.long .LC410
	.long SV_Physics_Toss
	.long .LC411
	.long SV_Push
	.long .LC412
	.long SV_PushEntity
	.long .LC413
	.long SV_RunThink
	.long .LC414
	.long SV_StepDirection
	.long .LC415
	.long SV_TestEntityPosition
	.long .LC416
	.long SV_movestep
	.long .LC417
	.long SaveClientData
	.long .LC418
	.long SelectCoopSpawnPoint
	.long .LC419
	.long SelectDeathmatchSpawnPoint
	.long .LC420
	.long SelectFarthestDeathmatchSpawnPoint
	.long .LC421
	.long SelectNextItem
	.long .LC422
	.long SelectPrevItem
	.long .LC423
	.long SelectRandomDeathmatchSpawnPoint
	.long .LC424
	.long SelectSpawnPoint
	.long .LC425
	.long ServerCommand
	.long .LC426
	.long SetItemNames
	.long .LC427
	.long SetRespawn
	.long .LC428
	.long Show_Mos
	.long .LC429
	.long Shrapnel_Explode
	.long .LC430
	.long Shrapnel_Explode
	.long .LC431
	.long ShutdownGame
	.long .LC432
	.long SnapToEights
	.long .LC433
	.long SpawnDamage
	.long .LC434
	.long SpawnEntities
	.long .LC435
	.long SpawnItem
	.long .LC436
	.long Svcmd_Test_f
	.long .LC437
	.long Swap_Init
	.long .LC438
	.long SwitchToObserver
	.long .LC439
	.long Sys_Error
	.long .LC440
	.long TH_viewthing
	.long .LC441
	.long T_Damage
	.long .LC442
	.long T_RadiusDamage
	.long .LC443
	.long M_Team_Join
	.long .LC444
	.long Think_AccelMove
	.long .LC445
	.long Think_Arty
	.long .LC446
	.long Think_CalcMoveSpeed
	.long .LC447
	.long Think_Delay
	.long .LC448
	.long Think_SpawnDoorTrigger
	.long .LC449
	.long Think_Weapon
	.long .LC450
	.long ThrowClientHead
	.long .LC451
	.long ThrowDebris
	.long .LC452
	.long ThrowGib
	.long .LC453
	.long ThrowHead
	.long .LC454
	.long TossClientWeapon
	.long .LC455
	.long Touch_DoorTrigger
	.long .LC456
	.long Touch_Item
	.long .LC457
	.long Touch_Multi
	.long .LC458
	.long Touch_Plat_Center
	.long .LC459
	.long Use_Areaportal
	.long .LC460
	.long Use_Breather
	.long .LC461
	.long Use_Envirosuit
	.long .LC462
	.long Use_Item
	.long .LC463
	.long Use_Multi
	.long .LC464
	.long Use_Plat
	.long .LC465
	.long Use_PowerArmor
	.long .LC466
	.long Use_Silencer
	.long .LC467
	.long Use_Target_Help
	.long .LC468
	.long Use_Target_Speaker
	.long .LC469
	.long Use_Target_Tent
	.long .LC470
	.long Use_Weapon
	.long .LC471
	.long ValidateSelectedItem
	.long .LC472
	.long VectorCompare
	.long .LC473
	.long VectorInverse
	.long .LC474
	.long VectorLength
	.long .LC475
	.long VectorMA
	.long .LC476
	.long VectorNormalize
	.long .LC477
	.long VectorNormalize2
	.long .LC478
	.long VectorScale
	.long .LC479
	.long VelocityForDamage
	.long .LC480
	.long Weapon_Antidote
	.long .LC481
	.long Weapon_Antidote_Use
	.long .LC482
	.long Weapon_Bandage
	.long .LC483
	.long Weapon_Bandage_Use
	.long .LC484
	.long Weapon_Binoculars
	.long .LC485
	.long Weapon_Binoculars_Look
	.long .LC486
	.long Weapon_Flamethrower
	.long .LC487
	.long Weapon_Generic
	.long .LC488
	.long Weapon_Grenade
	.long .LC489
	.long Weapon_HMG_Fire
	.long .LC490
	.long Weapon_Knife
	.long .LC491
	.long Weapon_Knife_Fire
	.long .LC492
	.long Weapon_LMG_Fire
	.long .LC493
	.long Weapon_Mine
	.long .LC494
	.long Weapon_Morphine
	.long .LC495
	.long Weapon_Morphine_Use
	.long .LC496
	.long Weapon_Pistol_Fire
	.long .LC497
	.long Weapon_Rifle_Fire
	.long .LC498
	.long Weapon_Rocket_Fire
	.long .LC499
	.long Weapon_Sniper_Fire
	.long .LC500
	.long Weapon_Submachinegun_Fire
	.long .LC501
	.long WriteClient
	.long .LC502
	.long WriteEdict
	.long .LC503
	.long WriteField1
	.long .LC504
	.long WriteField2
	.long .LC505
	.long WriteGame
	.long .LC506
	.long WriteLevel
	.long .LC507
	.long WriteLevelLocals
	.long .LC508
	.long _DotProduct
	.long .LC509
	.long _VectorAdd
	.long .LC510
	.long _VectorCopy
	.long .LC511
	.long _VectorSubtract
	.long .LC512
	.long actorMachineGun
	.long .LC513
	.long actor_attack
	.long .LC514
	.long actor_dead
	.long .LC515
	.long actor_die
	.long .LC516
	.long actor_fire
	.long .LC517
	.long actor_pain
	.long .LC518
	.long actor_run
	.long .LC519
	.long actor_stand
	.long .LC520
	.long actor_use
	.long .LC521
	.long actor_walk
	.long .LC522
	.long anglemod
	.long .LC523
	.long barrel_delay
	.long .LC524
	.long barrel_explode
	.long .LC525
	.long barrel_touch
	.long .LC526
	.long blaster_touch
	.long .LC527
	.long body_die
	.long .LC528
	.long booldummy
	.long .LC529
	.long button_done
	.long .LC530
	.long button_fire
	.long .LC531
	.long button_killed
	.long .LC532
	.long button_return
	.long .LC533
	.long button_touch
	.long .LC534
	.long button_use
	.long .LC535
	.long button_wait
	.long .LC536
	.long calcVspread
	.long .LC537
	.long change_stance
	.long .LC538
	.long check_firedodge
	.long .LC539
	.long commander_body_drop
	.long .LC540
	.long commander_body_think
	.long .LC541
	.long commander_body_use
	.long .LC542
	.long debris_die
	.long .LC543
	.long door_blocked
	.long .LC544
	.long door_go_down
	.long .LC545
	.long door_go_up
	.long .LC546
	.long door_hit_bottom
	.long .LC547
	.long door_hit_top
	.long .LC548
	.long door_killed
	.long .LC549
	.long door_secret_blocked
	.long .LC550
	.long door_secret_die
	.long .LC551
	.long door_secret_done
	.long .LC552
	.long door_secret_move1
	.long .LC553
	.long door_secret_move2
	.long .LC554
	.long door_secret_move3
	.long .LC555
	.long door_secret_move4
	.long .LC556
	.long door_secret_move5
	.long .LC557
	.long door_secret_move6
	.long .LC558
	.long door_secret_use
	.long .LC559
	.long door_touch
	.long .LC560
	.long door_use
	.long .LC561
	.long door_use_areaportals
	.long .LC562
	.long droptofloor
	.long .LC563
	.long dummy1
	.long .LC564
	.long dummy2
	.long .LC565
	.long findradius
	.long .LC566
	.long fire_Knife
	.long .LC567
	.long fire_blaster
	.long .LC568
	.long fire_bullet
	.long .LC569
	.long fire_flamegrenade
	.long .LC570
	.long fire_flamegrenade2
	.long .LC571
	.long fire_flamerocket
	.long .LC572
	.long fire_fragment
	.long .LC573
	.long fire_grenade2
	.long .LC574
	.long fire_hit
	.long .LC575
	.long fire_rifle
	.long .LC576
	.long fire_rocket
	.long .LC577
	.long fire_shell
	.long .LC578
	.long fire_tracer
	.long .LC579
	.long firerocket_touch
	.long .LC580
	.long flymonster_start
	.long .LC581
	.long flymonster_start_go
	.long .LC582
	.long func_clock_think
	.long .LC583
	.long func_clock_use
	.long .LC584
	.long func_conveyor_use
	.long .LC585
	.long func_explosive_explode
	.long .LC586
	.long func_explosive_spawn
	.long .LC587
	.long func_explosive_use
	.long .LC588
	.long func_object_release
	.long .LC589
	.long func_object_touch
	.long .LC590
	.long func_object_use
	.long .LC591
	.long func_timer_think
	.long .LC592
	.long func_timer_use
	.long .LC593
	.long func_train_find
	.long .LC594
	.long func_wall_use
	.long .LC595
	.long gib_die
	.long .LC596
	.long gib_think
	.long .LC597
	.long gib_touch
	.long .LC598
	.long hurt_touch
	.long .LC599
	.long hurt_use
	.long .LC600
	.long ifchangewep
	.long .LC601
	.long infront
	.long .LC602
	.long insane_checkdown
	.long .LC603
	.long insane_checkup
	.long .LC604
	.long insane_cross
	.long .LC605
	.long insane_dead
	.long .LC606
	.long insane_die
	.long .LC607
	.long insane_fist
	.long .LC608
	.long insane_moan
	.long .LC609
	.long insane_onground
	.long .LC610
	.long insane_pain
	.long .LC611
	.long insane_run
	.long .LC612
	.long insane_scream
	.long .LC613
	.long insane_shake
	.long .LC614
	.long insane_stand
	.long .LC615
	.long insane_walk
	.long .LC616
	.long misc_banner_think
	.long .LC617
	.long misc_banner_x_think
	.long .LC618
	.long misc_blackhole_think
	.long .LC619
	.long misc_blackhole_use
	.long .LC620
	.long misc_deadsoldier_die
	.long .LC621
	.long misc_easterchick2_think
	.long .LC622
	.long misc_easterchick_think
	.long .LC623
	.long misc_eastertank_think
	.long .LC624
	.long misc_satellite_dish_think
	.long .LC625
	.long misc_satellite_dish_use
	.long .LC626
	.long misc_strogg_ship_use
	.long .LC627
	.long misc_viper_bomb_prethink
	.long .LC628
	.long misc_viper_bomb_touch
	.long .LC629
	.long misc_viper_bomb_use
	.long .LC630
	.long misc_viper_use
	.long .LC631
	.long monster_death_use
	.long .LC632
	.long monster_start
	.long .LC633
	.long monster_start_go
	.long .LC634
	.long monster_think
	.long .LC635
	.long monster_triggered_spawn
	.long .LC636
	.long monster_triggered_spawn_use
	.long .LC637
	.long monster_triggered_start
	.long .LC638
	.long monster_use
	.long .LC639
	.long multi_trigger
	.long .LC640
	.long multi_wait
	.long .LC641
	.long path_corner_touch
	.long .LC642
	.long plat_Accelerate
	.long .LC643
	.long plat_CalcAcceleratedMove
	.long .LC644
	.long plat_blocked
	.long .LC645
	.long plat_go_down
	.long .LC646
	.long plat_go_up
	.long .LC647
	.long plat_hit_bottom
	.long .LC648
	.long plat_hit_top
	.long .LC649
	.long plat_spawn_inside_trigger
	.long .LC650
	.long player_die
	.long .LC651
	.long player_pain
	.long .LC652
	.long point_combat_touch
	.long .LC653
	.long range
	.long .LC654
	.long reinforcement_think
	.long .LC655
	.long respawn
	.long .LC656
	.long rocket_touch
	.long .LC657
	.long rotating_blocked
	.long .LC658
	.long rotating_touch
	.long .LC659
	.long rotating_use
	.long .LC660
	.long stuffcmd
	.long .LC661
	.long swimmonster_start
	.long .LC662
	.long swimmonster_start_go
	.long .LC663
	.long target_actor_touch
	.long .LC664
	.long target_crosslevel_target_think
	.long .LC665
	.long target_earthquake_think
	.long .LC666
	.long target_earthquake_use
	.long .LC667
	.long target_explosion_explode
	.long .LC668
	.long target_laser_off
	.long .LC669
	.long target_laser_on
	.long .LC670
	.long target_laser_start
	.long .LC671
	.long target_laser_think
	.long .LC672
	.long target_laser_use
	.long .LC673
	.long target_lightramp_think
	.long .LC674
	.long target_lightramp_use
	.long .LC675
	.long target_objective_use
	.long .LC676
	.long target_string_use
	.long .LC677
	.long teleporter_touch
	.long .LC678
	.long tracer_touch
	.long .LC679
	.long train_blocked
	.long .LC680
	.long train_next
	.long .LC681
	.long train_resume
	.long .LC682
	.long train_use
	.long .LC683
	.long train_wait
	.long .LC684
	.long trigger_counter_use
	.long .LC685
	.long trigger_crosslevel_trigger_use
	.long .LC686
	.long trigger_elevator_init
	.long .LC687
	.long trigger_elevator_use
	.long .LC688
	.long trigger_enable
	.long .LC689
	.long trigger_enough_troops_use
	.long .LC690
	.long trigger_gravity_touch
	.long .LC691
	.long trigger_key_use
	.long .LC692
	.long trigger_monsterjump_touch
	.long .LC693
	.long trigger_push_touch
	.long .LC694
	.long trigger_relay_use
	.long .LC695
	.long turret_blocked
	.long .LC696
	.long turret_breach_finish_init
	.long .LC697
	.long turret_breach_fire
	.long .LC698
	.long turret_breach_think
	.long .LC699
	.long turret_driver_die
	.long .LC700
	.long turret_driver_link
	.long .LC701
	.long turret_driver_think
	.long .LC702
	.long tv
	.long .LC703
	.long use_killbox
	.long .LC704
	.long use_target_blaster
	.long .LC705
	.long use_target_changelevel
	.long .LC706
	.long use_target_explosion
	.long .LC707
	.long use_target_goal
	.long .LC708
	.long use_target_secret
	.long .LC709
	.long use_target_spawner
	.long .LC710
	.long use_target_splash
	.long .LC711
	.long va
	.long .LC712
	.long vectoangles
	.long .LC713
	.long vectoyaw
	.long .LC714
	.long visible
	.long .LC715
	.long vtos
	.long .LC716
	.long walkmonster_start
	.long .LC717
	.long walkmonster_start_go
	.long .LC718
	.long weapon_flame_fire
	.long .LC719
	.long weapon_grenade_fire
	.long .LC720
	.long weapon_grenadelauncher_fire
	.long .LC721
	.long 0
	.section	".rodata"
	.align 2
.LC721:
	.string	""
	.align 2
.LC720:
	.string	"weapon_grenadelauncher_fire"
	.align 2
.LC719:
	.string	"weapon_grenade_fire"
	.align 2
.LC718:
	.string	"weapon_flame_fire"
	.align 2
.LC717:
	.string	"walkmonster_start_go"
	.align 2
.LC716:
	.string	"walkmonster_start"
	.align 2
.LC715:
	.string	"vtos"
	.align 2
.LC714:
	.string	"visible"
	.align 2
.LC713:
	.string	"vectoyaw"
	.align 2
.LC712:
	.string	"vectoangles"
	.align 2
.LC711:
	.string	"va"
	.align 2
.LC710:
	.string	"use_target_splash"
	.align 2
.LC709:
	.string	"use_target_spawner"
	.align 2
.LC708:
	.string	"use_target_secret"
	.align 2
.LC707:
	.string	"use_target_goal"
	.align 2
.LC706:
	.string	"use_target_explosion"
	.align 2
.LC705:
	.string	"use_target_changelevel"
	.align 2
.LC704:
	.string	"use_target_blaster"
	.align 2
.LC703:
	.string	"use_killbox"
	.align 2
.LC702:
	.string	"tv"
	.align 2
.LC701:
	.string	"turret_driver_think"
	.align 2
.LC700:
	.string	"turret_driver_link"
	.align 2
.LC699:
	.string	"turret_driver_die"
	.align 2
.LC698:
	.string	"turret_breach_think"
	.align 2
.LC697:
	.string	"turret_breach_fire"
	.align 2
.LC696:
	.string	"turret_breach_finish_init"
	.align 2
.LC695:
	.string	"turret_blocked"
	.align 2
.LC694:
	.string	"trigger_relay_use"
	.align 2
.LC693:
	.string	"trigger_push_touch"
	.align 2
.LC692:
	.string	"trigger_monsterjump_touch"
	.align 2
.LC691:
	.string	"trigger_key_use"
	.align 2
.LC690:
	.string	"trigger_gravity_touch"
	.align 2
.LC689:
	.string	"trigger_enough_troops_use"
	.align 2
.LC688:
	.string	"trigger_enable"
	.align 2
.LC687:
	.string	"trigger_elevator_use"
	.align 2
.LC686:
	.string	"trigger_elevator_init"
	.align 2
.LC685:
	.string	"trigger_crosslevel_trigger_use"
	.align 2
.LC684:
	.string	"trigger_counter_use"
	.align 2
.LC683:
	.string	"train_wait"
	.align 2
.LC682:
	.string	"train_use"
	.align 2
.LC681:
	.string	"train_resume"
	.align 2
.LC680:
	.string	"train_next"
	.align 2
.LC679:
	.string	"train_blocked"
	.align 2
.LC678:
	.string	"tracer_touch"
	.align 2
.LC677:
	.string	"teleporter_touch"
	.align 2
.LC676:
	.string	"target_string_use"
	.align 2
.LC675:
	.string	"target_objective_use"
	.align 2
.LC674:
	.string	"target_lightramp_use"
	.align 2
.LC673:
	.string	"target_lightramp_think"
	.align 2
.LC672:
	.string	"target_laser_use"
	.align 2
.LC671:
	.string	"target_laser_think"
	.align 2
.LC670:
	.string	"target_laser_start"
	.align 2
.LC669:
	.string	"target_laser_on"
	.align 2
.LC668:
	.string	"target_laser_off"
	.align 2
.LC667:
	.string	"target_explosion_explode"
	.align 2
.LC666:
	.string	"target_earthquake_use"
	.align 2
.LC665:
	.string	"target_earthquake_think"
	.align 2
.LC664:
	.string	"target_crosslevel_target_think"
	.align 2
.LC663:
	.string	"target_actor_touch"
	.align 2
.LC662:
	.string	"swimmonster_start_go"
	.align 2
.LC661:
	.string	"swimmonster_start"
	.align 2
.LC660:
	.string	"stuffcmd"
	.align 2
.LC659:
	.string	"rotating_use"
	.align 2
.LC658:
	.string	"rotating_touch"
	.align 2
.LC657:
	.string	"rotating_blocked"
	.align 2
.LC656:
	.string	"rocket_touch"
	.align 2
.LC655:
	.string	"respawn"
	.align 2
.LC654:
	.string	"reinforcement_think"
	.align 2
.LC653:
	.string	"range"
	.align 2
.LC652:
	.string	"point_combat_touch"
	.align 2
.LC651:
	.string	"player_pain"
	.align 2
.LC650:
	.string	"player_die"
	.align 2
.LC649:
	.string	"plat_spawn_inside_trigger"
	.align 2
.LC648:
	.string	"plat_hit_top"
	.align 2
.LC647:
	.string	"plat_hit_bottom"
	.align 2
.LC646:
	.string	"plat_go_up"
	.align 2
.LC645:
	.string	"plat_go_down"
	.align 2
.LC644:
	.string	"plat_blocked"
	.align 2
.LC643:
	.string	"plat_CalcAcceleratedMove"
	.align 2
.LC642:
	.string	"plat_Accelerate"
	.align 2
.LC641:
	.string	"path_corner_touch"
	.align 2
.LC640:
	.string	"multi_wait"
	.align 2
.LC639:
	.string	"multi_trigger"
	.align 2
.LC638:
	.string	"monster_use"
	.align 2
.LC637:
	.string	"monster_triggered_start"
	.align 2
.LC636:
	.string	"monster_triggered_spawn_use"
	.align 2
.LC635:
	.string	"monster_triggered_spawn"
	.align 2
.LC634:
	.string	"monster_think"
	.align 2
.LC633:
	.string	"monster_start_go"
	.align 2
.LC632:
	.string	"monster_start"
	.align 2
.LC631:
	.string	"monster_death_use"
	.align 2
.LC630:
	.string	"misc_viper_use"
	.align 2
.LC629:
	.string	"misc_viper_bomb_use"
	.align 2
.LC628:
	.string	"misc_viper_bomb_touch"
	.align 2
.LC627:
	.string	"misc_viper_bomb_prethink"
	.align 2
.LC626:
	.string	"misc_strogg_ship_use"
	.align 2
.LC625:
	.string	"misc_satellite_dish_use"
	.align 2
.LC624:
	.string	"misc_satellite_dish_think"
	.align 2
.LC623:
	.string	"misc_eastertank_think"
	.align 2
.LC622:
	.string	"misc_easterchick_think"
	.align 2
.LC621:
	.string	"misc_easterchick2_think"
	.align 2
.LC620:
	.string	"misc_deadsoldier_die"
	.align 2
.LC619:
	.string	"misc_blackhole_use"
	.align 2
.LC618:
	.string	"misc_blackhole_think"
	.align 2
.LC617:
	.string	"misc_banner_x_think"
	.align 2
.LC616:
	.string	"misc_banner_think"
	.align 2
.LC615:
	.string	"insane_walk"
	.align 2
.LC614:
	.string	"insane_stand"
	.align 2
.LC613:
	.string	"insane_shake"
	.align 2
.LC612:
	.string	"insane_scream"
	.align 2
.LC611:
	.string	"insane_run"
	.align 2
.LC610:
	.string	"insane_pain"
	.align 2
.LC609:
	.string	"insane_onground"
	.align 2
.LC608:
	.string	"insane_moan"
	.align 2
.LC607:
	.string	"insane_fist"
	.align 2
.LC606:
	.string	"insane_die"
	.align 2
.LC605:
	.string	"insane_dead"
	.align 2
.LC604:
	.string	"insane_cross"
	.align 2
.LC603:
	.string	"insane_checkup"
	.align 2
.LC602:
	.string	"insane_checkdown"
	.align 2
.LC601:
	.string	"infront"
	.align 2
.LC600:
	.string	"ifchangewep"
	.align 2
.LC599:
	.string	"hurt_use"
	.align 2
.LC598:
	.string	"hurt_touch"
	.align 2
.LC597:
	.string	"gib_touch"
	.align 2
.LC596:
	.string	"gib_think"
	.align 2
.LC595:
	.string	"gib_die"
	.align 2
.LC594:
	.string	"func_wall_use"
	.align 2
.LC593:
	.string	"func_train_find"
	.align 2
.LC592:
	.string	"func_timer_use"
	.align 2
.LC591:
	.string	"func_timer_think"
	.align 2
.LC590:
	.string	"func_object_use"
	.align 2
.LC589:
	.string	"func_object_touch"
	.align 2
.LC588:
	.string	"func_object_release"
	.align 2
.LC587:
	.string	"func_explosive_use"
	.align 2
.LC586:
	.string	"func_explosive_spawn"
	.align 2
.LC585:
	.string	"func_explosive_explode"
	.align 2
.LC584:
	.string	"func_conveyor_use"
	.align 2
.LC583:
	.string	"func_clock_use"
	.align 2
.LC582:
	.string	"func_clock_think"
	.align 2
.LC581:
	.string	"flymonster_start_go"
	.align 2
.LC580:
	.string	"flymonster_start"
	.align 2
.LC579:
	.string	"firerocket_touch"
	.align 2
.LC578:
	.string	"fire_tracer"
	.align 2
.LC577:
	.string	"fire_shell"
	.align 2
.LC576:
	.string	"fire_rocket"
	.align 2
.LC575:
	.string	"fire_rifle"
	.align 2
.LC574:
	.string	"fire_hit"
	.align 2
.LC573:
	.string	"fire_grenade2"
	.align 2
.LC572:
	.string	"fire_fragment"
	.align 2
.LC571:
	.string	"fire_flamerocket"
	.align 2
.LC570:
	.string	"fire_flamegrenade2"
	.align 2
.LC569:
	.string	"fire_flamegrenade"
	.align 2
.LC568:
	.string	"fire_bullet"
	.align 2
.LC567:
	.string	"fire_blaster"
	.align 2
.LC566:
	.string	"fire_Knife"
	.align 2
.LC565:
	.string	"findradius"
	.align 2
.LC564:
	.string	"dummy2"
	.align 2
.LC563:
	.string	"dummy1"
	.align 2
.LC562:
	.string	"droptofloor"
	.align 2
.LC561:
	.string	"door_use_areaportals"
	.align 2
.LC560:
	.string	"door_use"
	.align 2
.LC559:
	.string	"door_touch"
	.align 2
.LC558:
	.string	"door_secret_use"
	.align 2
.LC557:
	.string	"door_secret_move6"
	.align 2
.LC556:
	.string	"door_secret_move5"
	.align 2
.LC555:
	.string	"door_secret_move4"
	.align 2
.LC554:
	.string	"door_secret_move3"
	.align 2
.LC553:
	.string	"door_secret_move2"
	.align 2
.LC552:
	.string	"door_secret_move1"
	.align 2
.LC551:
	.string	"door_secret_done"
	.align 2
.LC550:
	.string	"door_secret_die"
	.align 2
.LC549:
	.string	"door_secret_blocked"
	.align 2
.LC548:
	.string	"door_killed"
	.align 2
.LC547:
	.string	"door_hit_top"
	.align 2
.LC546:
	.string	"door_hit_bottom"
	.align 2
.LC545:
	.string	"door_go_up"
	.align 2
.LC544:
	.string	"door_go_down"
	.align 2
.LC543:
	.string	"door_blocked"
	.align 2
.LC542:
	.string	"debris_die"
	.align 2
.LC541:
	.string	"commander_body_use"
	.align 2
.LC540:
	.string	"commander_body_think"
	.align 2
.LC539:
	.string	"commander_body_drop"
	.align 2
.LC538:
	.string	"check_firedodge"
	.align 2
.LC537:
	.string	"change_stance"
	.align 2
.LC536:
	.string	"calcVspread"
	.align 2
.LC535:
	.string	"button_wait"
	.align 2
.LC534:
	.string	"button_use"
	.align 2
.LC533:
	.string	"button_touch"
	.align 2
.LC532:
	.string	"button_return"
	.align 2
.LC531:
	.string	"button_killed"
	.align 2
.LC530:
	.string	"button_fire"
	.align 2
.LC529:
	.string	"button_done"
	.align 2
.LC528:
	.string	"booldummy"
	.align 2
.LC527:
	.string	"body_die"
	.align 2
.LC526:
	.string	"blaster_touch"
	.align 2
.LC525:
	.string	"barrel_touch"
	.align 2
.LC524:
	.string	"barrel_explode"
	.align 2
.LC523:
	.string	"barrel_delay"
	.align 2
.LC522:
	.string	"anglemod"
	.align 2
.LC521:
	.string	"actor_walk"
	.align 2
.LC520:
	.string	"actor_use"
	.align 2
.LC519:
	.string	"actor_stand"
	.align 2
.LC518:
	.string	"actor_run"
	.align 2
.LC517:
	.string	"actor_pain"
	.align 2
.LC516:
	.string	"actor_fire"
	.align 2
.LC515:
	.string	"actor_die"
	.align 2
.LC514:
	.string	"actor_dead"
	.align 2
.LC513:
	.string	"actor_attack"
	.align 2
.LC512:
	.string	"actorMachineGun"
	.align 2
.LC511:
	.string	"_VectorSubtract"
	.align 2
.LC510:
	.string	"_VectorCopy"
	.align 2
.LC509:
	.string	"_VectorAdd"
	.align 2
.LC508:
	.string	"_DotProduct"
	.align 2
.LC507:
	.string	"WriteLevelLocals"
	.align 2
.LC506:
	.string	"WriteLevel"
	.align 2
.LC505:
	.string	"WriteGame"
	.align 2
.LC504:
	.string	"WriteField2"
	.align 2
.LC503:
	.string	"WriteField1"
	.align 2
.LC502:
	.string	"WriteEdict"
	.align 2
.LC501:
	.string	"WriteClient"
	.align 2
.LC500:
	.string	"Weapon_Submachinegun_Fire"
	.align 2
.LC499:
	.string	"Weapon_Sniper_Fire"
	.align 2
.LC498:
	.string	"Weapon_Rocket_Fire"
	.align 2
.LC497:
	.string	"Weapon_Rifle_Fire"
	.align 2
.LC496:
	.string	"Weapon_Pistol_Fire"
	.align 2
.LC495:
	.string	"Weapon_Morphine_Use"
	.align 2
.LC494:
	.string	"Weapon_Morphine"
	.align 2
.LC493:
	.string	"Weapon_Mine"
	.align 2
.LC492:
	.string	"Weapon_LMG_Fire"
	.align 2
.LC491:
	.string	"Weapon_Knife_Fire"
	.align 2
.LC490:
	.string	"Weapon_Knife"
	.align 2
.LC489:
	.string	"Weapon_HMG_Fire"
	.align 2
.LC488:
	.string	"Weapon_Grenade"
	.align 2
.LC487:
	.string	"Weapon_Generic"
	.align 2
.LC486:
	.string	"Weapon_Flamethrower"
	.align 2
.LC485:
	.string	"Weapon_Binoculars_Look"
	.align 2
.LC484:
	.string	"Weapon_Binoculars"
	.align 2
.LC483:
	.string	"Weapon_Bandage_Use"
	.align 2
.LC482:
	.string	"Weapon_Bandage"
	.align 2
.LC481:
	.string	"Weapon_Antidote_Use"
	.align 2
.LC480:
	.string	"Weapon_Antidote"
	.align 2
.LC479:
	.string	"VelocityForDamage"
	.align 2
.LC478:
	.string	"VectorScale"
	.align 2
.LC477:
	.string	"VectorNormalize2"
	.align 2
.LC476:
	.string	"VectorNormalize"
	.align 2
.LC475:
	.string	"VectorMA"
	.align 2
.LC474:
	.string	"VectorLength"
	.align 2
.LC473:
	.string	"VectorInverse"
	.align 2
.LC472:
	.string	"VectorCompare"
	.align 2
.LC471:
	.string	"ValidateSelectedItem"
	.align 2
.LC470:
	.string	"Use_Weapon"
	.align 2
.LC469:
	.string	"Use_Target_Tent"
	.align 2
.LC468:
	.string	"Use_Target_Speaker"
	.align 2
.LC467:
	.string	"Use_Target_Help"
	.align 2
.LC466:
	.string	"Use_Silencer"
	.align 2
.LC465:
	.string	"Use_PowerArmor"
	.align 2
.LC464:
	.string	"Use_Plat"
	.align 2
.LC463:
	.string	"Use_Multi"
	.align 2
.LC462:
	.string	"Use_Item"
	.align 2
.LC461:
	.string	"Use_Envirosuit"
	.align 2
.LC460:
	.string	"Use_Breather"
	.align 2
.LC459:
	.string	"Use_Areaportal"
	.align 2
.LC458:
	.string	"Touch_Plat_Center"
	.align 2
.LC457:
	.string	"Touch_Multi"
	.align 2
.LC456:
	.string	"Touch_Item"
	.align 2
.LC455:
	.string	"Touch_DoorTrigger"
	.align 2
.LC454:
	.string	"TossClientWeapon"
	.align 2
.LC453:
	.string	"ThrowHead"
	.align 2
.LC452:
	.string	"ThrowGib"
	.align 2
.LC451:
	.string	"ThrowDebris"
	.align 2
.LC450:
	.string	"ThrowClientHead"
	.align 2
.LC449:
	.string	"Think_Weapon"
	.align 2
.LC448:
	.string	"Think_SpawnDoorTrigger"
	.align 2
.LC447:
	.string	"Think_Delay"
	.align 2
.LC446:
	.string	"Think_CalcMoveSpeed"
	.align 2
.LC445:
	.string	"Think_Arty"
	.align 2
.LC444:
	.string	"Think_AccelMove"
	.align 2
.LC443:
	.string	"M_Team_Join"
	.align 2
.LC442:
	.string	"T_RadiusDamage"
	.align 2
.LC441:
	.string	"T_Damage"
	.align 2
.LC440:
	.string	"TH_viewthing"
	.align 2
.LC439:
	.string	"Sys_Error"
	.align 2
.LC438:
	.string	"SwitchToObserver"
	.align 2
.LC437:
	.string	"Swap_Init"
	.align 2
.LC436:
	.string	"Svcmd_Test_f"
	.align 2
.LC435:
	.string	"SpawnItem"
	.align 2
.LC434:
	.string	"SpawnEntities"
	.align 2
.LC433:
	.string	"SpawnDamage"
	.align 2
.LC432:
	.string	"SnapToEights"
	.align 2
.LC431:
	.string	"ShutdownGame"
	.align 2
.LC430:
	.string	"TNT_Explode"
	.align 2
.LC429:
	.string	"Shrapnel_Explode"
	.align 2
.LC428:
	.string	"Show_Mos"
	.align 2
.LC427:
	.string	"SetRespawn"
	.align 2
.LC426:
	.string	"SetItemNames"
	.align 2
.LC425:
	.string	"ServerCommand"
	.align 2
.LC424:
	.string	"SelectSpawnPoint"
	.align 2
.LC423:
	.string	"SelectRandomDeathmatchSpawnPoint"
	.align 2
.LC422:
	.string	"SelectPrevItem"
	.align 2
.LC421:
	.string	"SelectNextItem"
	.align 2
.LC420:
	.string	"SelectFarthestDeathmatchSpawnPoint"
	.align 2
.LC419:
	.string	"SelectDeathmatchSpawnPoint"
	.align 2
.LC418:
	.string	"SelectCoopSpawnPoint"
	.align 2
.LC417:
	.string	"SaveClientData"
	.align 2
.LC416:
	.string	"SV_movestep"
	.align 2
.LC415:
	.string	"SV_TestEntityPosition"
	.align 2
.LC414:
	.string	"SV_StepDirection"
	.align 2
.LC413:
	.string	"SV_RunThink"
	.align 2
.LC412:
	.string	"SV_PushEntity"
	.align 2
.LC411:
	.string	"SV_Push"
	.align 2
.LC410:
	.string	"SV_Physics_Toss"
	.align 2
.LC409:
	.string	"SV_Physics_Step"
	.align 2
.LC408:
	.string	"SV_Physics_Pusher"
	.align 2
.LC407:
	.string	"SV_Physics_None"
	.align 2
.LC406:
	.string	"SV_Physics_Noclip"
	.align 2
.LC405:
	.string	"SV_NewChaseDir"
	.align 2
.LC404:
	.string	"SV_Impact"
	.align 2
.LC403:
	.string	"SV_FlyMove"
	.align 2
.LC402:
	.string	"SV_FixCheckBottom"
	.align 2
.LC401:
	.string	"SV_CloseEnough"
	.align 2
.LC400:
	.string	"SV_CheckVelocity"
	.align 2
.LC399:
	.string	"SV_CalcViewOffset"
	.align 2
.LC398:
	.string	"SV_CalcRoll"
	.align 2
.LC397:
	.string	"SV_CalcGunOffset"
	.align 2
.LC396:
	.string	"SV_CalcBlend"
	.align 2
.LC395:
	.string	"SV_AddRotationalFriction"
	.align 2
.LC394:
	.string	"SV_AddGravity"
	.align 2
.LC393:
	.string	"SV_AddBlend"
	.align 2
.LC392:
	.string	"SP_worldspawn"
	.align 2
.LC391:
	.string	"SP_viewthing"
	.align 2
.LC390:
	.string	"SP_turret_breach"
	.align 2
.LC389:
	.string	"SP_turret_base"
	.align 2
.LC388:
	.string	"SP_trigger_relay"
	.align 2
.LC387:
	.string	"SP_trigger_push"
	.align 2
.LC386:
	.string	"SP_trigger_once"
	.align 2
.LC385:
	.string	"SP_trigger_multiple"
	.align 2
.LC384:
	.string	"SP_trigger_monsterjump"
	.align 2
.LC383:
	.string	"SP_trigger_key"
	.align 2
.LC382:
	.string	"SP_trigger_hurt"
	.align 2
.LC381:
	.string	"SP_trigger_gravity"
	.align 2
.LC380:
	.string	"SP_trigger_enough_troops"
	.align 2
.LC379:
	.string	"SP_trigger_elevator"
	.align 2
.LC378:
	.string	"SP_trigger_counter"
	.align 2
.LC377:
	.string	"SP_trigger_always"
	.align 2
.LC376:
	.string	"SP_target_temp_entity"
	.align 2
.LC375:
	.string	"SP_target_string"
	.align 2
.LC374:
	.string	"SP_target_splash"
	.align 2
.LC373:
	.string	"SP_target_speaker"
	.align 2
.LC372:
	.string	"SP_target_spawner"
	.align 2
.LC371:
	.string	"SP_target_secret"
	.align 2
.LC370:
	.string	"SP_target_objective"
	.align 2
.LC369:
	.string	"SP_target_lightramp"
	.align 2
.LC368:
	.string	"SP_target_laser"
	.align 2
.LC367:
	.string	"SP_target_help"
	.align 2
.LC366:
	.string	"SP_target_goal"
	.align 2
.LC365:
	.string	"SP_target_explosion"
	.align 2
.LC364:
	.string	"SP_target_earthquake"
	.align 2
.LC363:
	.string	"SP_target_crosslevel_trigger"
	.align 2
.LC362:
	.string	"SP_target_crosslevel_target"
	.align 2
.LC361:
	.string	"SP_target_character"
	.align 2
.LC360:
	.string	"SP_target_changelevel"
	.align 2
.LC359:
	.string	"SP_target_blaster"
	.align 2
.LC358:
	.string	"SP_target_actor"
	.align 2
.LC357:
	.string	"SP_point_combat"
	.align 2
.LC356:
	.string	"SP_path_corner"
	.align 2
.LC355:
	.string	"SP_monster_tank"
	.align 2
.LC354:
	.string	"SP_monster_supertank"
	.align 2
.LC353:
	.string	"SP_monster_mutant"
	.align 2
.LC352:
	.string	"SP_monster_jorg"
	.align 2
.LC351:
	.string	"SP_monster_hover"
	.align 2
.LC350:
	.string	"SP_monster_flyer"
	.align 2
.LC349:
	.string	"SP_monster_floater"
	.align 2
.LC348:
	.string	"SP_monster_flipper"
	.align 2
.LC347:
	.string	"SP_monster_commander_body"
	.align 2
.LC346:
	.string	"SP_monster_chick"
	.align 2
.LC345:
	.string	"SP_monster_brain"
	.align 2
.LC344:
	.string	"SP_monster_boss3_stand"
	.align 2
.LC343:
	.string	"SP_monster_boss2"
	.align 2
.LC342:
	.string	"SP_misc_viper_bomb"
	.align 2
.LC341:
	.string	"SP_misc_viper"
	.align 2
.LC340:
	.string	"SP_misc_teleporter_dest"
	.align 2
.LC339:
	.string	"SP_misc_teleporter"
	.align 2
.LC338:
	.string	"SP_misc_strogg_ship"
	.align 2
.LC337:
	.string	"SP_misc_satellite_dish"
	.align 2
.LC336:
	.string	"SP_misc_insane"
	.align 2
.LC335:
	.string	"SP_misc_gib_leg"
	.align 2
.LC334:
	.string	"SP_misc_gib_head"
	.align 2
.LC333:
	.string	"SP_misc_gib_arm"
	.align 2
.LC332:
	.string	"SP_misc_explobox"
	.align 2
.LC331:
	.string	"SP_misc_eastertank"
	.align 2
.LC330:
	.string	"SP_misc_easterchick2"
	.align 2
.LC329:
	.string	"SP_misc_easterchick"
	.align 2
.LC328:
	.string	"SP_misc_deadsoldier"
	.align 2
.LC327:
	.string	"SP_misc_blackhole"
	.align 2
.LC326:
	.string	"SP_misc_bigviper"
	.align 2
.LC325:
	.string	"SP_misc_banner_4"
	.align 2
.LC324:
	.string	"SP_misc_banner_3"
	.align 2
.LC323:
	.string	"SP_misc_banner_2"
	.align 2
.LC322:
	.string	"SP_misc_banner_1"
	.align 2
.LC321:
	.string	"SP_misc_banner_x"
	.align 2
.LC320:
	.string	"SP_misc_banner"
	.align 2
.LC319:
	.string	"SP_misc_actor"
	.align 2
.LC318:
	.string	"SP_light_mine2"
	.align 2
.LC317:
	.string	"SP_light_mine1"
	.align 2
.LC316:
	.string	"SP_light"
	.align 2
.LC315:
	.string	"SP_item_weapon_mine"
	.align 2
.LC314:
	.string	"SP_item_weapon_flamethrower"
	.align 2
.LC313:
	.string	"SP_item_powerup_silencer"
	.align 2
.LC312:
	.string	"SP_item_powerup_pack"
	.align 2
.LC311:
	.string	"SP_item_powerup_enviro"
	.align 2
.LC310:
	.string	"SP_item_powerup_breather"
	.align 2
.LC309:
	.string	"SP_item_powerup_bandolier"
	.align 2
.LC308:
	.string	"SP_item_powerup_adrenaline"
	.align 2
.LC307:
	.string	"SP_item_key_red_key"
	.align 2
.LC306:
	.string	"SP_item_key_blue_key"
	.align 2
.LC305:
	.string	"SP_item_health_small"
	.align 2
.LC304:
	.string	"SP_item_health_mega"
	.align 2
.LC303:
	.string	"SP_item_health_large"
	.align 2
.LC302:
	.string	"SP_item_health"
	.align 2
.LC301:
	.string	"SP_item_armor_shard"
	.align 2
.LC300:
	.string	"SP_item_armor_jacket"
	.align 2
.LC299:
	.string	"SP_item_armor_combat"
	.align 2
.LC298:
	.string	"SP_item_armor_body"
	.align 2
.LC297:
	.string	"SP_item_ammo_napalm"
	.align 2
.LC296:
	.string	"SP_item_ammo_grenades"
	.align 2
.LC295:
	.string	"SP_info_team_start"
	.align 2
.LC294:
	.string	"SP_info_reinforcement_start"
	.align 2
.LC293:
	.string	"SP_info_player_start"
	.align 2
.LC292:
	.string	"SP_info_player_intermission"
	.align 2
.LC291:
	.string	"SP_info_player_deathmatch"
	.align 2
.LC290:
	.string	"SP_info_player_coop"
	.align 2
.LC289:
	.string	"SP_info_null"
	.align 2
.LC288:
	.string	"SP_info_notnull"
	.align 2
.LC287:
	.string	"SP_info_Special_Start"
	.align 2
.LC286:
	.string	"SP_info_Sniper_Start"
	.align 2
.LC285:
	.string	"SP_info_Mission_Results"
	.align 2
.LC284:
	.string	"SP_info_Medic_Start"
	.align 2
.LC283:
	.string	"SP_info_Officer_Start"
	.align 2
.LC282:
	.string	"SP_info_L_Gunner_Start"
	.align 2
.LC281:
	.string	"SP_info_Infantry_Start"
	.align 2
.LC280:
	.string	"SP_info_H_Gunner_Start"
	.align 2
.LC279:
	.string	"SP_info_Flamethrower_Start"
	.align 2
.LC278:
	.string	"SP_info_Engineer_Start"
	.align 2
.LC277:
	.string	"SP_func_water"
	.align 2
.LC276:
	.string	"SP_func_wall"
	.align 2
.LC275:
	.string	"SP_func_train"
	.align 2
.LC274:
	.string	"SP_func_timer"
	.align 2
.LC273:
	.string	"SP_func_rotating"
	.align 2
.LC272:
	.string	"SP_func_plat"
	.align 2
.LC271:
	.string	"SP_func_object"
	.align 2
.LC270:
	.string	"SP_func_killbox"
	.align 2
.LC269:
	.string	"SP_func_explosive"
	.align 2
.LC268:
	.string	"SP_func_door_secret"
	.align 2
.LC267:
	.string	"SP_func_door_rotating"
	.align 2
.LC266:
	.string	"SP_func_door"
	.align 2
.LC265:
	.string	"SP_func_conveyor"
	.align 2
.LC264:
	.string	"SP_func_clock"
	.align 2
.LC263:
	.string	"SP_func_button"
	.align 2
.LC262:
	.string	"SP_func_areaportal"
	.align 2
.LC261:
	.string	"RotatePointAroundVector"
	.align 2
.LC260:
	.string	"RemoveEntity"
	.align 2
.LC259:
	.string	"ReadLevelLocals"
	.align 2
.LC258:
	.string	"ReadLevel"
	.align 2
.LC257:
	.string	"ReadGame"
	.align 2
.LC256:
	.string	"ReadField"
	.align 2
.LC255:
	.string	"ReadEdict"
	.align 2
.LC254:
	.string	"ReadClient"
	.align 2
.LC253:
	.string	"R_ConcatTransforms"
	.align 2
.LC252:
	.string	"R_ConcatRotations"
	.align 2
.LC251:
	.string	"Q_strncasecmp"
	.align 2
.LC250:
	.string	"Q_stricmp"
	.align 2
.LC249:
	.string	"Q_strcasecmp"
	.align 2
.LC248:
	.string	"Q_log2"
	.align 2
.LC247:
	.string	"Q_fabs"
	.align 2
.LC246:
	.string	"PutClientInServer"
	.align 2
.LC245:
	.string	"ProjectPointOnPlane"
	.align 2
.LC244:
	.string	"PrintPmove"
	.align 2
.LC243:
	.string	"PrintCmds"
	.align 2
.LC242:
	.string	"PrecacheItem"
	.align 2
.LC241:
	.string	"PowerArmorType"
	.align 2
.LC240:
	.string	"PlayersRangeFromSpot"
	.align 2
.LC239:
	.string	"PlayerTrail_PickNext"
	.align 2
.LC238:
	.string	"PlayerTrail_PickFirst"
	.align 2
.LC237:
	.string	"PlayerTrail_New"
	.align 2
.LC236:
	.string	"PlayerTrail_LastSpot"
	.align 2
.LC235:
	.string	"PlayerTrail_Init"
	.align 2
.LC234:
	.string	"PlayerTrail_Add"
	.align 2
.LC233:
	.string	"PlayerSpawnUserDLLs"
	.align 2
.LC232:
	.string	"PlayerSort"
	.align 2
.LC231:
	.string	"PlayerNoise"
	.align 2
.LC230:
	.string	"PlayerDiesUserDLLs"
	.align 2
.LC229:
	.string	"Pickup_Weapon"
	.align 2
.LC228:
	.string	"Pickup_Powerup"
	.align 2
.LC227:
	.string	"Pickup_PowerArmor"
	.align 2
.LC226:
	.string	"Pickup_Pack"
	.align 2
.LC225:
	.string	"Pickup_Key"
	.align 2
.LC224:
	.string	"Pickup_Health"
	.align 2
.LC223:
	.string	"Pickup_Bandolier"
	.align 2
.LC222:
	.string	"Pickup_Armor"
	.align 2
.LC221:
	.string	"Pickup_Ammo"
	.align 2
.LC220:
	.string	"Pickup_Adrenaline"
	.align 2
.LC219:
	.string	"PerpendicularVector"
	.align 2
.LC218:
	.string	"P_WorldEffects"
	.align 2
.LC217:
	.string	"P_ProjectSource"
	.align 2
.LC216:
	.string	"P_FallingDamage"
	.align 2
.LC215:
	.string	"P_DamageFeedback"
	.align 2
.LC214:
	.string	"PM_trace"
	.align 2
.LC213:
	.string	"PBM_StartSmallExplosion"
	.align 2
.LC212:
	.string	"PBM_SmallExplodeThink"
	.align 2
.LC211:
	.string	"PBM_KillAllFires"
	.align 2
.LC210:
	.string	"PBM_Inflammable"
	.align 2
.LC209:
	.string	"PBM_InWater"
	.align 2
.LC208:
	.string	"PBM_Ignite"
	.align 2
.LC207:
	.string	"PBM_FlameThrowerTouch"
	.align 2
.LC206:
	.string	"PBM_FlameThrowerThink"
	.align 2
.LC205:
	.string	"PBM_FlameOut"
	.align 2
.LC204:
	.string	"PBM_FlameCloud"
	.align 2
.LC203:
	.string	"PBM_FireballTouch"
	.align 2
.LC202:
	.string	"PBM_FireSpot"
	.align 2
.LC201:
	.string	"PBM_FireResistant"
	.align 2
.LC200:
	.string	"PBM_FireFlamer"
	.align 2
.LC199:
	.string	"PBM_FireFlameThrower"
	.align 2
.LC198:
	.string	"PBM_FireDropTouch"
	.align 2
.LC197:
	.string	"PBM_FireDrop"
	.align 2
.LC196:
	.string	"PBM_FireAngleSpread"
	.align 2
.LC195:
	.string	"PBM_EasyFireDrop"
	.align 2
.LC194:
	.string	"PBM_CloudBurstDamage"
	.align 2
.LC193:
	.string	"PBM_CloudBurst"
	.align 2
.LC192:
	.string	"PBM_CheckMaster"
	.align 2
.LC191:
	.string	"PBM_CheckFire"
	.align 2
.LC190:
	.string	"PBM_BurnRadius"
	.align 2
.LC189:
	.string	"PBM_BurnDamage"
	.align 2
.LC188:
	.string	"PBM_Burn"
	.align 2
.LC187:
	.string	"PBM_BecomeSteam"
	.align 2
.LC186:
	.string	"PBM_BecomeSmoke"
	.align 2
.LC185:
	.string	"PBM_BecomeSmallExplosion"
	.align 2
.LC184:
	.string	"PBM_ActivePowerArmor"
	.align 2
.LC183:
	.string	"NoAmmoWeaponChange"
	.align 2
.LC182:
	.string	"Move_Final"
	.align 2
.LC181:
	.string	"Move_Done"
	.align 2
.LC180:
	.string	"Move_Calc"
	.align 2
.LC179:
	.string	"Move_Begin"
	.align 2
.LC178:
	.string	"MoveClientToIntermission"
	.align 2
.LC177:
	.string	"MegaHealth_think"
	.align 2
.LC176:
	.string	"M_walkmove"
	.align 2
.LC175:
	.string	"M_droptofloor"
	.align 2
.LC174:
	.string	"M_WorldEffects"
	.align 2
.LC173:
	.string	"M_SetEffects"
	.align 2
.LC172:
	.string	"M_ReactToDamage"
	.align 2
.LC171:
	.string	"M_MoveToGoal"
	.align 2
.LC170:
	.string	"M_MoveFrame"
	.align 2
.LC169:
	.string	"M_FlyCheck"
	.align 2
.LC168:
	.string	"M_CheckGround"
	.align 2
.LC167:
	.string	"M_CheckBottom"
	.align 2
.LC166:
	.string	"M_CheckAttack"
	.align 2
.LC165:
	.string	"M_ChangeYaw"
	.align 2
.LC164:
	.string	"M_CatagorizePosition"
	.align 2
.LC163:
	.string	"M_MOS_Join"
	.align 2
.LC162:
	.string	"LookAtKiller"
	.align 2
.LC161:
	.string	"LongSwap"
	.align 2
.LC160:
	.string	"LongNoSwap"
	.align 2
.LC159:
	.string	"LoadUserDLLs"
	.align 2
.LC158:
	.string	"LittleLong"
	.align 2
.LC157:
	.string	"LittleFloat"
	.align 2
.LC156:
	.string	"LevelStartUserDLLs"
	.align 2
.LC155:
	.string	"LevelExitUserDLLs"
	.align 2
.LC154:
	.string	"LerpAngle"
	.align 2
.LC153:
	.string	"Knife_Throw"
	.align 2
.LC152:
	.string	"Killed"
	.align 2
.LC151:
	.string	"KillBox"
	.align 2
.LC150:
	.string	"IsFemale"
	.align 2
.LC149:
	.string	"InsertItem"
	.align 2
.LC148:
	.string	"InsertEntity"
	.align 2
.LC147:
	.string	"InsertCmds"
	.align 2
.LC146:
	.string	"InitializeUserDLLs"
	.align 2
.LC145:
	.string	"InitTrigger"
	.align 2
.LC144:
	.string	"InitMOS_List"
	.align 2
.LC143:
	.string	"InitItems"
	.align 2
.LC142:
	.string	"InitGame"
	.align 2
.LC141:
	.string	"InitClientResp"
	.align 2
.LC140:
	.string	"InitClientPersistant"
	.align 2
.LC139:
	.string	"InitBodyQue"
	.align 2
.LC138:
	.string	"Info_ValueForKey"
	.align 2
.LC137:
	.string	"Info_Validate"
	.align 2
.LC136:
	.string	"Info_SetValueForKey"
	.align 2
.LC135:
	.string	"Info_RemoveKey"
	.align 2
.LC134:
	.string	"In_Vector_Range"
	.align 2
.LC133:
	.string	"HuntTarget"
	.align 2
.LC132:
	.string	"HelpComputer"
	.align 2
.LC131:
	.string	"Give_Class_Weapon"
	.align 2
.LC130:
	.string	"Give_Class_Ammo"
	.align 2
.LC129:
	.string	"GetItemByIndex"
	.align 2
.LC128:
	.string	"GetGameAPI"
	.align 2
.LC127:
	.string	"G_UseTargets"
	.align 2
.LC126:
	.string	"G_TouchTriggers"
	.align 2
.LC125:
	.string	"G_TouchSolids"
	.align 2
.LC124:
	.string	"G_Spawn"
	.align 2
.LC123:
	.string	"G_SetStats"
	.align 2
.LC122:
	.string	"G_SetMovedir"
	.align 2
.LC121:
	.string	"G_SetClientSound"
	.align 2
.LC120:
	.string	"G_SetClientFrame"
	.align 2
.LC119:
	.string	"G_SetClientEvent"
	.align 2
.LC118:
	.string	"G_SetClientEffects"
	.align 2
.LC117:
	.string	"G_RunFrame"
	.align 2
.LC116:
	.string	"G_RunEntity"
	.align 2
.LC115:
	.string	"G_ProjectSource"
	.align 2
.LC114:
	.string	"G_PickTarget"
	.align 2
.LC113:
	.string	"G_InitEdict"
	.align 2
.LC112:
	.string	"G_FreeEdict"
	.align 2
.LC111:
	.string	"G_FindTeams"
	.align 2
.LC110:
	.string	"G_Find"
	.align 2
.LC109:
	.string	"G_CopyString"
	.align 2
.LC108:
	.string	"FloatSwap"
	.align 2
.LC107:
	.string	"FloatNoSwap"
	.align 2
.LC106:
	.string	"Find_Mission_Start_Point"
	.align 2
.LC105:
	.string	"FindNextPickup"
	.align 2
.LC104:
	.string	"FindItemByClassname"
	.align 2
.LC103:
	.string	"FindItem"
	.align 2
.LC102:
	.string	"FindCommand"
	.align 2
.LC101:
	.string	"FetchClientEntData"
	.align 2
.LC100:
	.string	"FacingIdeal"
	.align 2
.LC99:
	.string	"ExitLevel"
	.align 2
.LC98:
	.string	"EndObserverMode"
	.align 2
.LC97:
	.string	"EndDMLevel"
	.align 2
.LC96:
	.string	"ED_ParseField"
	.align 2
.LC95:
	.string	"ED_ParseEdict"
	.align 2
.LC94:
	.string	"ED_NewString"
	.align 2
.LC93:
	.string	"ED_CallSpawn"
	.align 2
.LC92:
	.string	"Drop_Weapon"
	.align 2
.LC91:
	.string	"Drop_PowerArmor"
	.align 2
.LC90:
	.string	"Drop_Item"
	.align 2
.LC89:
	.string	"Drop_General"
	.align 2
.LC88:
	.string	"Drop_Ammo"
	.align 2
.LC87:
	.string	"DoRespawn"
	.align 2
.LC86:
	.string	"DoEndOM"
	.align 2
.LC85:
	.string	"DoAnarchyStuff"
	.align 2
.LC84:
	.string	"DDayScoreboardMessage"
	.align 2
.LC83:
	.string	"DeathmatchScoreboard"
	.align 2
.LC82:
	.string	"Damage_Loc"
	.align 2
.LC81:
	.string	"CrossProduct"
	.align 2
.LC80:
	.string	"CopyToBodyQue"
	.align 2
.LC79:
	.string	"Com_sprintf"
	.align 2
.LC78:
	.string	"Com_Printf"
	.align 2
.LC77:
	.string	"Com_PageInMemory"
	.align 2
.LC76:
	.string	"Cmd_WeapPrev_f"
	.align 2
.LC75:
	.string	"Cmd_WeapNext_f"
	.align 2
.LC74:
	.string	"Cmd_WeapLast_f"
	.align 2
.LC73:
	.string	"Cmd_Wave_f"
	.align 2
.LC72:
	.string	"Cmd_Use_f"
	.align 2
.LC71:
	.string	"Cmd_Stance"
	.align 2
.LC70:
	.string	"Cmd_Shout_f"
	.align 2
.LC69:
	.string	"Cmd_SexPistols_f"
	.align 2
.LC68:
	.string	"Cmd_Score_f"
	.align 2
.LC67:
	.string	"Cmd_Scope_f"
	.align 2
.LC66:
	.string	"Cmd_Say_f"
	.align 2
.LC65:
	.string	"Cmd_Reload_f"
	.align 2
.LC64:
	.string	"Cmd_PutAway_f"
	.align 2
.LC63:
	.string	"Cmd_Players_f"
	.align 2
.LC62:
	.string	"Cmd_Notarget_f"
	.align 2
.LC61:
	.string	"Cmd_Noclip_f"
	.align 2
.LC60:
	.string	"Cmd_Kill_f"
	.align 2
.LC59:
	.string	"Cmd_Inven_f"
	.align 2
.LC58:
	.string	"Cmd_InvUse_f"
	.align 2
.LC57:
	.string	"Cmd_InvDrop_f"
	.align 2
.LC56:
	.string	"Cmd_Help_f"
	.align 2
.LC55:
	.string	"Cmd_God_f"
	.align 2
.LC54:
	.string	"Cmd_Give_f"
	.align 2
.LC53:
	.string	"Cmd_GameVersion_f"
	.align 2
.LC52:
	.string	"Cmd_Drop_f"
	.align 2
.LC51:
	.string	"Cmd_Arty_f"
	.align 2
.LC50:
	.string	"Cmd_AliciaMode_f"
	.align 2
.LC49:
	.string	"ClipVelocity"
	.align 2
.LC48:
	.string	"ClipGibVelocity"
	.align 2
.LC47:
	.string	"ClientUserinfoChanged"
	.align 2
.LC46:
	.string	"ClientThink"
	.align 2
.LC45:
	.string	"ClientTeam"
	.align 2
.LC44:
	.string	"ClientObituary"
	.align 2
.LC43:
	.string	"ClientEndServerFrames"
	.align 2
.LC42:
	.string	"ClientEndServerFrame"
	.align 2
.LC41:
	.string	"ClientDisconnect"
	.align 2
.LC40:
	.string	"ClientConnect"
	.align 2
.LC39:
	.string	"ClientCommand"
	.align 2
.LC38:
	.string	"ClientBeginServerFrame"
	.align 2
.LC37:
	.string	"ClientBeginDeathmatch"
	.align 2
.LC36:
	.string	"ClientBegin"
	.align 2
.LC35:
	.string	"ClearUserDLLs"
	.align 2
.LC34:
	.string	"ClearBounds"
	.align 2
.LC33:
	.string	"CleanUpCmds"
	.align 2
.LC32:
	.string	"ChooseTeam"
	.align 2
.LC31:
	.string	"M_ChooseMOS"
	.align 2
.LC30:
	.string	"CheckTeamDamage"
	.align 2
.LC29:
	.string	"CheckDMRules"
	.align 2
.LC28:
	.string	"ChangeWeapon"
	.align 2
.LC27:
	.string	"CanDamage"
	.align 2
.LC26:
	.string	"COM_StripExtension"
	.align 2
.LC25:
	.string	"COM_SkipPath"
	.align 2
.LC24:
	.string	"COM_Parse"
	.align 2
.LC23:
	.string	"COM_FilePath"
	.align 2
.LC22:
	.string	"COM_FileExtension"
	.align 2
.LC21:
	.string	"COM_FileBase"
	.align 2
.LC20:
	.string	"COM_DefaultExtension"
	.align 2
.LC19:
	.string	"BoxOnPlaneSide2"
	.align 2
.LC18:
	.string	"BoxOnPlaneSide"
	.align 2
.LC17:
	.string	"Blade_touch"
	.align 2
.LC16:
	.string	"BigLong"
	.align 2
.LC15:
	.string	"BigFloat"
	.align 2
.LC14:
	.string	"BeginIntermission"
	.align 2
.LC13:
	.string	"BecomeExplosion2"
	.align 2
.LC12:
	.string	"BecomeExplosion1"
	.align 2
.LC11:
	.string	"AttackFinished"
	.align 2
.LC10:
	.string	"ArmorIndex"
	.align 2
.LC9:
	.string	"ApplyFirstAid"
	.align 2
.LC8:
	.string	"AnglesNormalize"
	.align 2
.LC7:
	.string	"AngleVectors"
	.align 2
.LC6:
	.string	"AngleMove_Final"
	.align 2
.LC5:
	.string	"AngleMove_Done"
	.align 2
.LC4:
	.string	"AngleMove_Calc"
	.align 2
.LC3:
	.string	"AngleMove_Begin"
	.align 2
.LC2:
	.string	"Add_Ammo"
	.align 2
.LC1:
	.string	"AddPointToBounds"
	.align 2
.LC0:
	.string	"AI_SetSightClient"
	.size	 GlobalGameFunctionArray,5784
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.section	".text"
	.align 2
	.globl FindGameFunction
	.type	 FindGameFunction,@function
FindGameFunction:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,GlobalGameFunctionArray@ha
	mr 27,3
	la 26,GlobalGameFunctionArray@l(9)
	li 28,-1
	li 29,0
	li 30,760
	li 31,380
	b .L7
.L10:
	bc 4,0,.L12
	addi 30,31,-1
	b .L11
.L12:
	addi 29,31,1
.L11:
	add 0,30,29
	srwi 9,0,31
	add 0,0,9
	srawi 31,0,1
.L7:
	cmpw 0,29,30
	bc 12,1,.L8
	slwi 0,31,3
	mr 3,27
	lwzx 4,26,0
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L10
	mr 28,31
.L8:
	cmpwi 0,28,-1
	bc 4,2,.L15
	li 3,0
	b .L17
.L15:
	lis 9,GlobalGameFunctionArray@ha
	slwi 0,28,3
	la 9,GlobalGameFunctionArray@l(9)
	addi 9,9,4
	lwzx 3,9,0
.L17:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 FindGameFunction,.Lfe1-FindGameFunction
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
