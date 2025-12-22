* host call opcodes
Call_SetExceptionHandler	equ	$0
Call_MemSet		equ	$1
Call_MemSetBlue		equ	$2
Call_BlitCursor		equ	$3
Call_RestoreUnderCursor	equ	$4
Call_BlitBmp		equ	$5
Call_OldHLine		equ	$6
Call_HostUpdate		equ	$7
Call_Memcpy		equ	$8
Call_PutPix		equ	$9
Call_BackHLine		equ	$a
Call_FillLine		equ	$b
Call_SetMainPalette	equ	$c
Call_SetCtrlPalette	equ	$d
Call_SetScreenBase	equ	$e
Call_DumpRegs		equ	$10
Call_MakeExtPalette	equ	$11
Call_PlaySFX		equ	$12
Call_GetMouseInput	equ	$13
Call_GetKeyboardEvent	equ	$14
Call_HLine		equ	$16
Call_NotifyMousePos	equ	$18
Call_InformScreens	equ	$19
Call_DrawStrShadowed	equ	$1b
Call_DrawStr		equ	$1c
Call_PlayMusic		equ	$1d
Call_StopMusic		equ	$1e
Call_Idle		equ	$1f
Call_DumpDebug		equ	$20
Call_IsMusicPlaying	equ	$21
Call_Fread		equ	$22
Call_Fwrite		equ	$23
Call_Fdelete		equ	$24
Call_Fopendir		equ	$25
Call_Freaddir		equ	$26
Call_Fclosedir		equ	$27
Nu_PutTriangle		equ	$60
Nu_PutQuad		equ	$61
Nu_PutLine		equ	$62
Nu_PutPoint		equ	$63
Nu_PutTwinklyCircle	equ	$64
Nu_PutColoredPoint	equ	$65
Nu_PutBezierLine	equ	$66
Nu_ComplexStart		equ	$67
Nu_ComplexSNext		equ	$68
Nu_ComplexSBegin	equ	$69
Nu_ComplexEnd		equ	$6a
Nu_3DViewInit		equ	$6b
Nu_InsertZNode		equ	$6c
Nu_ComplexStartInner	equ	$6d
Nu_ComplexBezier	equ	$6e
Nu_DrawScreen		equ	$6f
Nu_PutTeardrop		equ	$70
Nu_PutCircle		equ	$71
Nu_PutOval		equ	$72
Nu_IsGLRenderer		equ	$73
Nu_GLClearArea		equ	$74
Nu_QueueDrawStr		equ	$75
Nu_PutCylinder		equ	$76
Nu_PutBlob		equ	$77
Nu_PutPlanet		equ	$78
Nu_Draw2DLine		equ	$79

* don't change. it won't work yet.
SCR_W			equ	320
SCR_H			equ	200

* There are a pile of 'modules', each of which consists of a jump table.
* Some things observed:
* fn offset 24 - called every game tick. Physics.
* fn offset 28 - called every second.

A6_mod_starsystemview	equ	28
A6_mod_player		equ	36
A6_mod_panel		equ	44
A6_mod_intro		equ	76
A6_mod_randnames	equ	84
A6_mod_faces		equ	116
A6_mod_shipscreen	equ	124
A6_mod_police		equ	132
A6_mod_mining		equ	148
* counts from 0 (0:00) to (2^32)-1 (23:59.9999)
A6_time_of_day		equ	524
A6_day_since_epoch	equ	528
A6_do_clr_2_space_cols	equ	536
A6_hblank_do_pal	equ	537
A6_gameloop_iter	equ	538
A6_optdetail1		equ	540
A6_optdetail2		equ	542
A6_optdetail3		equ	544
A6_plr_in_atmosphere	equ	546
A6_rng_seed1		equ	548
A6_rng_seed2		equ	552
A6_lighting_vector	equ	556
A6_light_tint_table	equ	576
A6_plr_3dview_mode	equ	706
A6_plr_speed_set	equ	848
A6_galmap_posx		equ	914
A6_galmap_posy		equ	918

A6_opt_shape_detail	equ	10434
A6_opt_black_space	equ	10438
A6_opt_dust_n_clouds	equ	10440
A6_opt_bg_stars		equ	10441
A6_opt_lock_ext_view	equ	10442
A6_opt_rev_x_controls	equ	10443
A6_opt_rev_y_controls	equ	10444
A6_opt_elite_controls	equ	10445
A6_opt_target_tunnls	equ	10446
A6_opt_tunnls_4_ships	equ	10447
A6_opt_filename_exts	equ	10448
A6_opt_sfx_on		equ	10449
A6_opt_unknown1		equ	10450
A6_opt_joystick_ctrl	equ	10451
A6_opt_unknown2		equ	10452
A6_opt_icon_beeps	equ	10453
A6_opt_music_on		equ	10454
A6_opt_music_hyperspace	equ	10455
A6_opt_docking_music	equ	10456
A6_opt_battle_music	equ	10457
A6_opt_contin_music	equ	10458
A6_opt_selected_music	equ	10459

A6_num_asteroids	equ	13352
A6_max_asteroids	equ	13353
A6_UNUSED_music_playing	equ	13880
A6_commander_name	equ	14400
* nice name... it is 32k or so of nothingness used for something
A6_big_space		equ	14466
A6_game_data		equ	14470
A6_game_strings		equ	14474
A6_stack_base		equ	14478
* Used when controlling the ship
A6_mouse_motion_ctrl_x	equ	14488
A6_mouse_motion_ctrl_y	equ	14490
A6_mouse_ctrl_buttons	equ	14492
A6_mouse_abs_x		equ	14494
A6_mouse_abs_y		equ	14496
A6_mouse_int_motion_x	equ	14500
A6_mouse_int_motion_y	equ	14502
A6_mouse_buttons	equ	14504
A6_joystick_state	equ	14506
A6_icon_positions	equ	14514
A6_vblank_palette1	equ	15812
* unused now
*A6_vblank_palette2	equ	15844
A6_main_palette1	equ	15876
A6_main_pal1_col1	equ	15878
A6_main_pal1_col12	equ	15900
A6_main_pal1_col14	equ	15904
A6_main_palette2	equ	15908
A6_panel_palette	equ	15940
A6_scancode_for_GetAscii equ	16336
A6_pushed_ascii_key	equ	16337
A6_scancode_for_GetAscii2 equ	16339
A6_keystates_base	equ	16342
A6_keystate_return	equ	16370
A6_keystate_lshift	equ	16384
A6_keystate_rshift	equ	16396
A6_keystate_spacebar	equ	16399
A6_keystate_cursdown	equ	16414
A6_keystate_cursleft	equ	16417
A6_keystate_cursright	equ	16419
A6_keystate_cursup	equ	16422
* no longer used
A6_bmp_under_mouse	equ	16480
A6_mouse_last_draw_pos	equ	16736
A6_current_dir		equ	16748
A6_dir_list_len		equ	17448
A6_dir_list_entries	equ	17454
* ^^ Each size 28 bytes,
* 0 (word) - type (see AddToFsel)
* 2 (long) - size (if is a file)
* 6 (string) - name, len 22

A5_VectorLen		equ	6
A5_2RandInts		equ	24
A5_RandInt		equ	30
A5_GetAsciiKey		equ	42
A5_PushAsciiKey		equ	48
A5_GetAsciiKey2		equ	54
A5_ClrAsciiKey2		equ	60
A5_ZProjectCentred	equ	72
A5_PutGameData3DObj	equ	84
A5_Put3DGamedata2Obj	equ	90
A5_Put3DGamedata2Obj2	equ	96
A5_MatrixMulWTF		equ	114
A5_DrawScannerLines	equ	120
A5_BlitBmp		equ	126
A5_BlitBmpToBothBuffers	equ	132
A5_UISetIconPositions	equ	144
A5_SetMainIconPositions	equ	162
A5_GetFmtStr		equ	180
A5_FmtDrawStr		equ	186
A5_FmtDrawStrToPhys	equ	198
A5_DrawStrToPhys	equ	204
A5_DrawStr		equ	210
A5_DrawStrShadowed	equ	216
A5_FmtDrawStrShadowed	equ	222
A5_DrawCircle		equ	234
A5_DrawLineClipped	equ	240
A5_DrawLine		equ	246
A5_DrawQuad		equ	252
A5_AllocDynCol		equ	258
A5_GetDynCol		equ	264
A5_ReturnScrLineInA6	equ	270
A5_SetMainPalette	equ	288
A5_SetDefaultPalette	equ	294
A5_FillBlueLogscreen	equ	300
A5_WipeLogscreen	equ	306
A5_RedrawMouse2		equ	312
A5_SetPanelPalette	equ	318
A5_BlitPanel		equ	324
A5_SetBGCol		equ	330
A5_RedrawMouse		equ	336
A5_PhysToLog2		equ	342
A5_LogToLog2		equ	348
A5_WaitVBlankWaits	equ	354
A5_BlitPhys2Log		equ	360
A5_WaitVBlank		equ	366
A5_CopyFmtStr		equ	372
A5_PlayEffect		equ	378
A5_StopMusic		equ	414
A5_StartMusic		equ	420
A5_SetGameData		equ	438
A5_UseMainGameData	equ	444
A5_AddObject		equ	462
A5_Copy3DObj_a0_a1	equ	504
A5_GetMouseCtrl		equ	534
A5_SetMouseCtrlMotion	equ	540
A5_MakeRotXYMatrix	equ	546
A5_MakeRotXZMatrix	equ	552
A5_DoPhysics		equ	606
A5_DrawBGStars		equ	612
A5_InvMatrixVectorMult	equ	636
A5_MatrixVectorMult	equ	642
A5_RotateAxisPair	equ	666
A5_32BitDotProduct	equ	834
A5_GetGameDataObj	equ	840
A5_TombstoneLoop	equ	846

A4_GetStringsBase	equ	40

		* Welcome to howdydoodyland
		jmp	L426e2_main

* play an effect (d0, d1)
L22_PlayEffect:
		hcall	#Call_PlaySFX
		rts

L54_StopMusic:
		hcall	#Call_StopMusic
		rts

L6c_rts:
		rts

L6e_rts:
		rts

L70_StartMusic:
		* d0:
		* -1 = random
		* -2 = fuck knows
		* >=0 = index
		movem.l	d1-2,-(a7)
		movem.l	A6_opt_selected_music(a6),d1-2
		hcall	#Call_PlayMusic
		movem.l	(a7)+,d1-2
		rts

* These names are not too helpful & originated when i wasn't so
* sure what was going on.

* Screen buffer not currently being displayed
L5d9e_logscreen:
		ds.b	4
* Screen buffer currently being displayed
L5da2_physcreen:
		ds.b	4
* Screen buffer the low-level drawing routines draw to (usually == logscreen)
L5da6_logscreen2:
		ds.b	4
* Screen buffer the mouse pointer is crapping on. could remove now mouse is hardware.
L5daa_physcreen2:
		ds.b	4

L5dae_dyn_cols:
		dc.b	$0,$0

L5db0:
		ds.b	254

L5eae:
		ds.b	4

L5eb2_vblank_waits:
		ds.b	4

L5eb6_a6_base:
		ds.b	537

L60cf_hblank_do_pal:
		dc.b	$0

L60d0_gameloop_iter:
		dc.b	$0,$0

L60d2_optdetail1:
		dc.b	$0,$0

L60d4_optdetail2:
		dc.b	$0,$0

L60d6_optdetail3:
		dc.b	$0,$0

L60d8_plr_in_atmosphere:
		dc.b	$0,$0

L60da_rng_seed1:
		ds.b	4

L60de_rng_seed2:
		ds.b	4

L60e2_lighting_vector:
		ds.b	6

L60e8:
		ds.b	14

L60f6_light_tint_table:
		ds.b	9862

L877c_opt_black_space:
		ds.b	4024

L9734_fucking_game_objs:
		ds.b	8

L973c_game_data:
		ds.b	1434

L9cd6_main_pal1_col14:
		ds.b	32

L9cf6_main_pal2_col14:
		ds.b	4

L9cfa_panel_palette:
		ds.b	64

L9d3a:
		ds.b	37244

* also known as A6_big_space(a6)
* size 33006
L12eb6_big_space:
		ds.b	312
	l12fee:	ds.b	274
	l13100:	ds.b	206
	l131ce:	ds.b	42
	l131f8:	ds.b	194
	l132ba:	ds.b	212
	l1338e:	ds.b	236
	l1347a:	ds.b	72
	l134c2:	ds.b	70
	l13508:	ds.b	62
	l13546:	ds.b	206
	l13614:	ds.b	384
	l13794:	ds.b	144
	l13824:	ds.b	670
	l13ac2:	ds.b	520
	l13cca:	ds.b	314
	l13e04:	ds.b	490
	l13fee:	ds.b	202
	l140b8:	ds.b	68
	l140fc:	ds.b	68
	l14140:	ds.b	136
	l141c8:	ds.b	170
	l14272:	ds.b	154
	l1430c:	ds.b	80
	l1435c:	ds.b	742
	l14642:	ds.b	242
	l14734:	ds.b	158
	l147d2:	ds.b	142
	l14860:	ds.b	276
	l14974:	ds.b	264
	l14a7c:	ds.b	208
	l14b4c:	ds.b	168
	l14bf4:	ds.b	70
	l14c3a:	ds.b	976
	l1500a:	ds.b	72
	l15052:	ds.b	72
	l1509a:	ds.b	72
	l150e2:	ds.b	62
	l15120:	ds.b	62
	l1515e:	ds.b	62
	l1519c:	ds.b	72
	l151e4:	ds.b	62
	l15222:	ds.b	62
	l15260:	ds.b	62
	l1529e:	ds.b	822
	l155d4:	ds.b	134
	l1565a:	ds.b	122
	l156d4:	ds.b	60
	l15710:	ds.b	60
	l1574c:	ds.b	606
	l159aa:	ds.b	138
	l15a34:	ds.b	138
	l15abe:	ds.b	348
	l15c1a:	ds.b	58
	l15c54:	ds.b	714
	l15f1e:	ds.b	202
	l15fe8:	ds.b	212
	l160bc:	ds.b	148
	l16150:	ds.b	82
	l161a2:	ds.b	64
	l161e2:	ds.b	86
	l16238:	ds.b	266
	l16342:	ds.b	86
	l16398:	ds.b	70
	l163de:	ds.b	192
	l1649e:	ds.b	50
	l164d0:	ds.b	80
	l16520:	ds.b	130
	l165a2:	ds.b	314
	l166dc:	ds.b	108
	l16748:	ds.b	200
	l16810:	ds.b	214
	l168e6:	ds.b	440
	l16a9e:	ds.b	146
	l16b30:	ds.b	112
	l16ba0:	ds.b	142
	l16c2e:	ds.b	240
	l16d1e:	ds.b	122
	l16d98:	ds.b	58
	l16dd2:	ds.b	98
	l16e34:	ds.b	76
	l16e80:	ds.b	484
	l17064:	ds.b	152
	l170fc:	ds.b	112
	l1716c:	ds.b	70
	l171b2:	ds.b	396
	l1733e:	ds.b	268
	l1744a:	ds.b	776
	l17752:	ds.b	202
	l1781c:	ds.b	934
	l17bc2:	ds.b	200
	l17c8a:	ds.b	88
	l17ce2:	ds.b	266
	l17dec:	ds.b	330
	l17f36:	ds.b	482
	l18118:	ds.b	424
	l182c0:	ds.b	422
	l18466:	ds.b	250
	l18560:	ds.b	176
	l18610:	ds.b	706
	l188d2:	ds.b	178
	l18984:	ds.b	170
	l18a2e:	ds.b	54
	l18a64:	ds.b	122
	l18ade:	ds.b	770
	l18de0:	ds.b	312
	l18f18:	ds.b	200
	l18fe0:	ds.b	98
	l19042:	ds.b	632
	l192ba:	ds.b	138
	l19344:	ds.b	130
	l193c6:	ds.b	146
	l19458:	ds.b	132
	l194dc:	ds.b	132
	l19560:	ds.b	562
	l19792:	ds.b	178
	l19844:	ds.b	378
	l199be:	ds.b	536
	l19bd6:	ds.b	462
	l19da4:	ds.b	186
	l19e5e:	ds.b	242
	l19f50:	ds.b	204
	l1a01c:	ds.b	204
	l1a0e8:	ds.b	192
	l1a1a8:	ds.b	126
	l1a226:	ds.b	104
	l1a28e:	ds.b	310
	l1a3c4:	ds.b	680
	l1a66c:	ds.b	140
	l1a6f8:	ds.b	202
	l1a7c2:	ds.b	558
	l1a9f0:	ds.b	176
	l1aaa0:	ds.b	214
	l1ab76:	ds.b	186
	l1ac30:	ds.b	70
	l1ac76:	ds.b	178
	l1ad28:	ds.b	366
	l1ae96:	ds.b	128
	l1af16:	ds.b	44
	l1af42:	ds.b	98

L1afa4:
		dc.b	$0

L1afa5:
		dc.b	$0

L1afa6_old_kbhandler:
		ds.b	6
		dc.b	$ff,$d2

* 3d objects
L1afae_gamedata1:
L1afae:
		* $0
		dc.w	L1afae-L1afae
		dc.w	L1afae-L1afae
		dc.w	l1b18e-L1afae
		dc.w	l1b2b2-L1afae
		dc.w	l1b43c-L1afae
		dc.w	l1b488-L1afae
		dc.w	l1b4d8-L1afae
		dc.w	l1b528-L1afae
		* $10
		dc.w	l1b578-L1afae
		dc.w	l1b5c8-L1afae
		dc.w	l1b65e_ship_shuttle-L1afae
		dc.w	l1b836-L1afae
		dc.w	l1bb42-L1afae
		dc.w	l1beee-L1afae
		dc.w	l1c210-L1afae
		dc.w	l1c29a-L1afae
		* $20
		dc.w	l1c84c_ship_eagle_i-L1afae
		dc.w	l1cb86-L1afae
		dc.w	l1cbe2-L1afae
		dc.w	l1cc3e-L1afae
		dc.w	l1ced4-L1afae
		dc.w	l1d1c8-L1afae
		dc.w	l1d48a-L1afae
		dc.w	l1d76c-L1afae
		dc.w	l1da22-L1afae
		dc.w	l1dd16-L1afae
		dc.w	l1e000-L1afae
		dc.w	l1e36c-L1afae
		dc.w	l1e686-L1afae
		dc.w	l1e99c-L1afae
		dc.w	l1ec46-L1afae
		dc.w	l1f700-L1afae
		dc.w	l1fa0c-L1afae
		dc.w	l1fe78-L1afae
		dc.w	l1fe16-L1afae
		dc.w	l201ba-L1afae
		dc.w	l1f0b8-L1afae
		dc.w	l2045e-L1afae
		dc.w	l2072c-L1afae
		dc.w	l20f48-L1afae
		dc.w	l207a0-L1afae
		dc.w	l21020-L1afae
		dc.w	l21210-L1afae
		dc.w	l214a8-L1afae
		dc.w	l21dec-L1afae
		dc.w	l22542-L1afae
		dc.w	l226d0-L1afae
		dc.w	l227f4-L1afae
		dc.w	l229ca-L1afae
		dc.w	l22ed2-L1afae
		dc.w	l22ad2-L1afae
		dc.w	l22f30-L1afae
		dc.w	l12fee-L1afae
		dc.w	l13100-L1afae
		dc.w	l131f8-L1afae
		dc.w	l1338e-L1afae
		dc.w	l1347a-L1afae
		dc.w	l134c2-L1afae
		dc.w	l13508-L1afae
		dc.w	l13546-L1afae
		dc.w	l13614-L1afae
		dc.w	l13794-L1afae
		dc.w	l13824-L1afae
		dc.w	l13ac2-L1afae
		dc.w	l13cca-L1afae
		dc.w	l13fee-L1afae
		dc.w	l140b8-L1afae
		dc.w	l140fc-L1afae
		dc.w	l14140-L1afae
		dc.w	l141c8-L1afae
		dc.w	l14272-L1afae
		dc.w	l1430c-L1afae
		dc.w	l1435c-L1afae
		dc.w	l14860-L1afae
		dc.w	l14974-L1afae
		dc.w	l14a7c-L1afae
		dc.w	l14b4c-L1afae
		dc.w	l1509a-L1afae
		dc.w	l1519c-L1afae
		dc.w	l15052-L1afae
		dc.w	l1500a-L1afae
		dc.w	l150e2-L1afae
		dc.w	l15120-L1afae
		dc.w	l1515e-L1afae
		dc.w	l151e4-L1afae
		dc.w	l15222-L1afae
		dc.w	l15260-L1afae
		dc.w	l14bf4-L1afae
		dc.w	l1529e-L1afae
		dc.w	l1565a-L1afae
		dc.w	l156d4-L1afae
		dc.w	l15710-L1afae
		dc.w	l1574c-L1afae
		dc.w	l15abe-L1afae
		dc.w	l15c54-L1afae
		dc.w	l163de-L1afae
		dc.w	l164d0-L1afae
		dc.w	l16520-L1afae
		dc.w	l165a2-L1afae
		dc.w	l16748-L1afae
		dc.w	l16810-L1afae
		dc.w	l168e6-L1afae
		dc.w	l16a9e-L1afae
		dc.w	l16b30-L1afae
		dc.w	l16ba0-L1afae
		dc.w	L1afae-L1afae
		dc.w	l1b7de-L1afae
		dc.w	l1bac4-L1afae
		dc.w	l1be0a-L1afae
		dc.w	l1c750-L1afae
		dc.w	l1bd8c-L1afae
		dc.w	l1f522-L1afae
		dc.w	l16c2e-L1afae
		dc.w	l1c36c-L1afae
		dc.w	l1c452-L1afae
		dc.w	l1c554-L1afae
		dc.w	l1c5aa-L1afae
		dc.w	l1c4f4-L1afae
		dc.w	l1c642-L1afae
		dc.w	l1c7ba-L1afae
		dc.w	l16d1e-L1afae
		dc.w	l16d98-L1afae
		dc.w	l16dd2-L1afae
		dc.w	l16e80-L1afae
		dc.w	l16e34-L1afae
		dc.w	l17064-L1afae
		dc.w	l170fc-L1afae
		dc.w	l1f682-L1afae
		dc.w	l1f5e0-L1afae
		dc.w	l1fc1e-L1afae
		dc.w	l1fd9c-L1afae
		dc.w	l209ea-L1afae
		dc.w	l20868-L1afae
		dc.w	l20936-L1afae
		dc.w	l20ca0-L1afae
		dc.w	l20db6-L1afae
		dc.w	l20e66-L1afae
		dc.w	l1716c-L1afae
		dc.w	l21af8-L1afae
		dc.w	l219da-L1afae
		dc.w	l21d46-L1afae
		dc.w	l22186-L1afae
		dc.w	l21a44-L1afae
		dc.w	l21a80-L1afae
		dc.w	l21cb2-L1afae
		dc.w	l21be2-L1afae
		dc.w	l1733e-L1afae
		dc.w	l21c3e-L1afae
		dc.w	l1744a-L1afae
		dc.w	l223de-L1afae
		dc.w	l21f08-L1afae
		dc.w	l21fb4-L1afae
		dc.w	l1781c-L1afae
		dc.w	l17dec-L1afae
		dc.w	l17f36-L1afae
		dc.w	l18118-L1afae
		dc.w	l182c0-L1afae
		dc.w	l18466-L1afae
		dc.w	l18560-L1afae
		dc.w	l2269e-L1afae
		dc.w	l18610-L1afae
		dc.w	l22786-L1afae
		dc.w	l18ade-L1afae
		dc.w	l19042-L1afae
		dc.w	l19560-L1afae
		dc.w	l22934-L1afae
		dc.w	l18de0-L1afae
		dc.w	l22bc6-L1afae
		dc.w	l19844-L1afae
		dc.w	l199be-L1afae
		dc.w	l22dee-L1afae
		dc.w	l19bd6-L1afae
		dc.w	l19da4-L1afae
		dc.w	l19f50-L1afae
		dc.w	l1a01c-L1afae
		dc.w	l1a0e8-L1afae
		dc.w	l1a1a8-L1afae
		dc.w	l1a226-L1afae
		dc.w	l22e78-L1afae
		dc.w	l1a28e-L1afae
		dc.w	l1a3c4-L1afae
		dc.w	l1a66c-L1afae
		dc.w	l1a9f0-L1afae
		dc.w	l1aaa0-L1afae
		dc.w	l131ce-L1afae
		dc.w	l132ba-L1afae
		dc.w	l17bc2-L1afae
		dc.w	l13e04-L1afae
		dc.w	l14642-L1afae
		dc.w	l147d2-L1afae
		dc.w	l14734-L1afae
		dc.w	l14c3a-L1afae
		dc.w	l155d4-L1afae
		dc.w	l159aa-L1afae
		dc.w	l15a34-L1afae
		dc.w	l15c1a-L1afae
		dc.w	l15fe8-L1afae
		dc.w	l16238-L1afae
		dc.w	l16398-L1afae
		dc.w	l160bc-L1afae
		dc.w	l15f1e-L1afae
		dc.w	l16342-L1afae
		dc.w	l161e2-L1afae
		dc.w	l16150-L1afae
		dc.w	l161a2-L1afae
		dc.w	l1649e-L1afae
		dc.w	l166dc-L1afae
		dc.w	l171b2-L1afae
		dc.w	l17752-L1afae
		dc.w	l17c8a-L1afae
		dc.w	l17ce2-L1afae
		dc.w	l1ab76-L1afae
		dc.w	l1ac30-L1afae
		dc.w	l1ac76-L1afae
		dc.w	l1ad28-L1afae
		dc.w	l18984-L1afae
		dc.w	l18a2e-L1afae
		dc.w	l188d2-L1afae
		dc.w	l18a64-L1afae
		dc.w	l18fe0-L1afae
		dc.w	l18f18-L1afae
		dc.w	l19458-L1afae
		dc.w	l194dc-L1afae
		dc.w	l193c6-L1afae
		dc.w	l19344-L1afae
		dc.w	l192ba-L1afae
		dc.w	l19792-L1afae
		dc.w	l19e5e-L1afae
		dc.w	l1a7c2-L1afae
		dc.w	l1a6f8-L1afae
		dc.w	l1ae96-L1afae
		dc.w	l1af42-L1afae
		dc.w	l1af16-L1afae
		dc.w	L1afae-L1afae
		dc.w	L1afae-L1afae
		dc.w	L1afae-L1afae
		dc.w	L1afae-L1afae
		dc.w	L1afae-L1afae
		dc.w	L1afae-L1afae
		dc.w	L1afae-L1afae
	l1b18e:	dc.b	$0,$78,$0,$10,$4,$40,$0,$54,$0,$28,$0,$7,$0,$0,$0,$75
		dc.b	$1,$0,$0,$1c,$1,$2,$2,$15,$1,$2,$fe,$15,$1,$2,$2,$f
		dc.b	$1,$2,$fe,$f,$1,$4,$4,$f,$1,$4,$fc,$f,$b,$1,$2,$16
		dc.b	$b,$1,$4,$18,$1,$4,$4,$eb,$1,$4,$fc,$eb,$1,$2,$2,$eb
		dc.b	$1,$2,$fe,$eb,$1,$0,$0,$e7,$1,$0,$0,$8b,$7,$17,$0,$1c
		dc.b	$13,$c3,$1a,$1e,$0,$0,$78,$28,$0,$0,$88,$28,$0,$78,$0,$28
		dc.b	$2,$7f,$0,$0,$2,$0,$7f,$0,$4,$0,$81,$0,$16,$0,$0,$81
		dc.b	$0,$59,$59,$0,$0,$59,$a7,$0,$0,$73,$7,$c1,$0,$6e,$30,$ff
		dc.b	$0,$0,$1,$b4,$0,$c0,$1,$74,$10,$8f,$1,$33,$0,$8f,$c3,$5d
		dc.b	$1,$8f,$c3,$bd,$45,$c3,$0,$73,$0,$c3,$1e,$e9,$20,$1a,$3,$84
		dc.b	$16,$1a,$c1,$0,$1,$60,$9,$88,$7,$0,$7,$0,$1,$60,$1,$60
		dc.b	$1,$60,$0,$6c,$3,$34,$1,$2,$18,$0,$0,$0,$ff,$e6,$1,$8
		dc.b	$16,$4,$18,$2,$0,$8,$1,$4,$16,$3,$17,$2,$0,$a,$1,$4
		dc.b	$18,$5,$19,$4,$0,$c,$10,$4,$17,$18,$19,$16,$0,$e,$0,$b
		dc.b	$2,$48,$1,$3,$0,$2,$3,$2,$1,$3,$0,$4,$5,$4,$1,$7
		dc.b	$0,$2,$4,$6,$16,$1a,$c1,$0,$1,$60,$7,$0,$9,$88,$7,$0
		dc.b	$1,$60,$1,$60,$1,$60,$1,$7,$e,$12,$16,$10,$1,$7,$10,$14
		dc.b	$18,$12,$0,$b,$1,$a4,$1,$7,$2,$a,$6,$10,$1,$7,$4,$c
		dc.b	$8,$12,$0,$0
	l1b2b2:	dc.b	$0,$c6,$0,$1e,$4,$80,$0,$66,$0,$64,$0,$5,$0,$0,$0,$41
		dc.b	$0,$10,$6,$66,$0,$7,$25,$80,$25,$80,$0,$0,$1,$6a,$1,$0
		dc.b	$9,$0,$1,$0,$bf,$0,$1,$0,$e4,$25,$1,$25,$e4,$0,$1,$0
		dc.b	$e4,$db,$1,$15,$fa,$15,$1,$15,$cf,$15,$1,$15,$fa,$eb,$1,$15
		dc.b	$cf,$eb,$1,$1a,$e4,$1a,$1,$1a,$e4,$e6,$1,$0,$ff,$1a,$1,$0
		dc.b	$ca,$1a,$1,$1a,$ff,$0,$1,$1a,$ca,$0,$1,$0,$ff,$e6,$1,$0
		dc.b	$ca,$e6,$1,$0,$1c,$0,$4,$23,$2e,$70,$4,$23,$d2,$70,$4,$2e
		dc.b	$23,$70,$4,$2e,$dd,$70,$0,$23,$70,$2e,$2,$23,$90,$2e,$0,$2e
		dc.b	$70,$23,$2,$2e,$90,$23,$6,$70,$23,$2e,$6,$70,$dd,$2e,$6,$70
		dc.b	$2e,$23,$6,$70,$d2,$23,$0,$2e,$70,$dd,$2,$2e,$90,$dd,$0,$23
		dc.b	$70,$d2,$2,$23,$90,$d2,$e,$70,$2e,$dd,$10,$70,$d2,$dd,$e,$70
		dc.b	$23,$d2,$10,$70,$dd,$d2,$e,$23,$2e,$90,$10,$23,$d2,$90,$e,$2e
		dc.b	$23,$90,$10,$2e,$dd,$90,$0,$8c,$7,$52,$66,$61,$80,$25,$22,$0
		dc.b	$0,$0,$ff,$e6,$0,$7,$4,$a,$16,$2,$88,$87,$4,$a,$12,$6
		dc.b	$0,$7,$0,$16,$a,$a,$88,$87,$0,$a,$1a,$e,$0,$7,$6,$a
		dc.b	$12,$12,$88,$87,$6,$1a,$a,$16,$0,$7,$0,$e,$1a,$1a,$88,$87
		dc.b	$0,$e,$1e,$1e,$0,$7,$e,$1a,$6,$22,$88,$87,$e,$14,$6,$26
		dc.b	$0,$7,$e,$1e,$8,$2a,$88,$87,$e,$8,$14,$2e,$4,$94,$0,$c0
		dc.b	$88,$87,$4,$c,$18,$4,$0,$7,$4,$c,$12,$8,$88,$87,$2,$18
		dc.b	$c,$c,$0,$7,$2,$c,$1c,$10,$88,$87,$6,$c,$12,$14,$0,$7
		dc.b	$6,$1c,$c,$18,$88,$87,$2,$10,$1c,$1c,$0,$7,$2,$10,$20,$20
		dc.b	$88,$87,$10,$1c,$6,$24,$0,$7,$10,$14,$6,$28,$88,$87,$10,$20
		dc.b	$8,$2c,$0,$7,$10,$8,$14,$30,$0,$0,$0,$0,$0,$0,$0,$1
		dc.b	$0,$1,$0,$0,$0,$c,$0,$64,$40,$4,$0,$1,$0,$0,$b,$2
		dc.b	$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	l1b43c:	dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$4,$0,$0,$0,$5d
		dc.b	$0,$f,$6,$66,$0,$6,$4b,$0,$4b,$0,$0,$0,$0,$2c,$1,$0
		dc.b	$0,$0,$c0,$1d,$1,$40,$0,$6e,$0,$0,$0,$0,$0,$0,$0,$0
		dc.b	$0,$1,$0,$1,$0,$0,$0,$c,$0,$64,$40,$5,$0,$1,$0,$0
		dc.b	$b,$2,$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	l1b488:	dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$7,$0,$0,$0,$75
		dc.b	$0,$12,$6,$66,$0,$9,$10,$68,$10,$68,$0,$0,$0,$30,$1,$0
		dc.b	$0,$0,$c1,$d,$40,$2,$c0,$1d,$1,$40,$0,$4e,$0,$0,$0,$0
		dc.b	$7f,$bc,$e6,$74,$0,$1,$0,$1,$0,$0,$0,$c,$0,$64,$40,$6
		dc.b	$0,$1,$0,$0,$b,$2,$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	l1b4d8:	dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$7,$0,$0,$0,$75
		dc.b	$0,$12,$6,$66,$0,$9,$10,$68,$10,$68,$0,$0,$0,$30,$1,$0
		dc.b	$0,$0,$c1,$d,$40,$3,$c0,$1d,$1,$40,$0,$4e,$0,$0,$0,$0
		dc.b	$7f,$bc,$e6,$74,$0,$1,$0,$1,$0,$0,$0,$c,$0,$64,$40,$7
		dc.b	$0,$1,$0,$0,$b,$2,$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	l1b528:	dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$7,$0,$0,$0,$75
		dc.b	$0,$12,$6,$66,$0,$9,$10,$68,$10,$68,$0,$0,$0,$30,$1,$0
		dc.b	$0,$0,$c1,$d,$40,$4,$c0,$1d,$1,$40,$0,$4e,$0,$0,$0,$0
		dc.b	$7f,$bc,$e6,$74,$0,$1,$0,$1,$0,$0,$0,$c,$0,$64,$40,$8
		dc.b	$0,$1,$0,$0,$b,$2,$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	l1b578:	dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$7,$0,$0,$0,$75
		dc.b	$0,$12,$6,$66,$0,$9,$10,$68,$10,$68,$0,$0,$0,$30,$1,$0
		dc.b	$0,$0,$c1,$d,$40,$5,$c0,$1d,$1,$40,$0,$4e,$0,$0,$0,$0
		dc.b	$7f,$bc,$e6,$74,$0,$1,$0,$1,$0,$0,$0,$c,$0,$64,$40,$9
		dc.b	$0,$1,$0,$0,$b,$2,$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	l1b5c8:	dc.b	$0,$42,$0,$1e,$1,$80,$0,$36,$0,$10,$0,$5,$0,$0,$0,$75
		dc.b	$0,$19,$6,$66,$0,$7,$5d,$c0,$2e,$e0,$0,$6e,$0,$76,$1,$0
		dc.b	$0,$75,$1,$2e,$e9,$d2,$1,$0,$2e,$d2,$b,$1,$0,$4,$b,$1
		dc.b	$6,$4,$b,$1,$2,$6,$0,$68,$45,$13,$0,$0,$83,$11,$2,$0
		dc.b	$0,$81,$ff,$e6,$88,$7,$0,$2,$4,$2,$88,$3,$0,$2,$3,$4
		dc.b	$0,$3,$2,$3,$4,$6,$0,$6b,$5b,$8c,$0,$7,$6,$8,$a,$2
		dc.b	$0,$93,$4,$80,$0,$6,$fe,$1,$e0,$2e,$4,$82,$0,$0,$10,$80
		dc.b	$2,$3,$4,$6,$0,$0,$6,$63,$fb,$be,$0,$0,$0,$5,$0,$4
		dc.b	$0,$b,$0,$28,$40,$a,$0,$1,$0,$0,$80,$1,$1,$0,$0,$0
		dc.b	$0,$5d,$0,$bb,$0,$0
	l1b65e_ship_shuttle:
		dc.b	$0,$86,$0,$1e,$4,$0,$0,$5e,$0,$2c,$0,$6,$0,$0,$0,$4b
		dc.b	$0,$11,$6,$66,$0,$8,$4b,$0,$1e,$0,$1,$52,$1,$60,$1,$1f
		dc.b	$19,$32,$1,$1f,$19,$bc,$1,$25,$0,$4b,$1,$25,$0,$b5,$1,$1f
		dc.b	$f4,$44,$1,$1f,$f4,$bc,$1,$1c,$17,$33,$1,$20,$8,$42,$1,$22
		dc.b	$c,$bf,$1,$de,$c,$34,$1,$12,$f4,$19,$1,$1f,$e7,$19,$1,$12
		dc.b	$f4,$e7,$1,$1f,$e7,$e7,$1,$1f,$e7,$32,$1,$1f,$e7,$ce,$0,$0
		dc.b	$7f,$0,$0,$0,$59,$59,$2,$7b,$1e,$0,$2,$0,$1e,$85,$4,$0
		dc.b	$c8,$71,$4,$71,$c8,$0,$6,$0,$c8,$8f,$8,$0,$81,$0,$14,$0
		dc.b	$0,$7f,$14,$1e,$85,$0,$ff,$e6,$88,$84,$9,$a,$b,$8,$0,$10
		dc.b	$5,$b,$3,$e8,$3,$b,$1,$f4,$88,$90,$16,$14,$2,$14,$2,$0
		dc.b	$88,$90,$1a,$18,$2,$14,$2,$0,$88,$90,$1e,$1c,$2,$12,$2,$0
		dc.b	$88,$90,$17,$15,$2,$15,$2,$0,$88,$90,$1b,$19,$2,$15,$2,$0
		dc.b	$88,$90,$1f,$1d,$2,$13,$2,$0,$1,$8c,$1,$f4,$88,$82,$14,$16
		dc.b	$88,$82,$18,$1a,$88,$82,$1c,$1e,$88,$82,$15,$17,$88,$82,$19,$1b
		dc.b	$88,$82,$1d,$1f,$88,$84,$1,$2,$3,$0,$0,$2,$88,$84,$1,$4
		dc.b	$5,$0,$0,$4,$0,$8b,$5,$dc,$0,$4,$d,$e,$f,$c,$0,$4
		dc.b	$88,$88,$4,$2,$6,$0,$0,$6,$2,$b,$3,$6a,$19,$1c,$0,$0
		dc.b	$83,$3c,$fd,$44,$0,$a,$6,$6,$46,$10,$30,$16,$19,$1c,$0,$40
		dc.b	$83,$3c,$fd,$44,$0,$a,$6,$7,$46,$12,$30,$16,$88,$84,$3,$6
		dc.b	$7,$2,$0,$8,$88,$84,$5,$8,$9,$4,$0,$a,$88,$88,$8,$6
		dc.b	$a,$4,$0,$c,$88,$84,$7,$a,$b,$6,$0,$e,$0,$0,$c,$84
		dc.b	$3e,$80,$10,$80,$2,$4,$6,$7,$8,$a,$c,$d,$e,$10,$0,$0
		dc.b	$a,$a5,$f9,$9d,$0,$0,$0,$8,$0,$4,$0,$e,$0,$28,$40,$b
		dc.b	$0,$1,$0,$0,$80,$1,$1,$0,$1,$90,$0,$64,$1,$e0,$0,$64
	l1b7de:	dc.b	$0,$2c,$0,$10,$1,$40,$0,$24,$0,$c,$0,$3,$0,$0,$0,$4b
		dc.b	$1,$c,$f4,$0,$1,$c,$f4,$4b,$13,$81,$ff,$0,$13,$81,$fe,$2
		dc.b	$1,$c,$0,$4b,$2,$0,$0,$7f,$0,$c8,$8f,$0,$1,$ab,$1,$f4
		dc.b	$88,$90,$4,$ff,$2,$5,$2,$0,$88,$90,$6,$fe,$2,$5,$2,$0
		dc.b	$88,$90,$6,$4,$2,$2,$2,$0,$0,$0,$88,$82,$ff,$4,$88,$82
		dc.b	$fe,$6,$88,$82,$4,$6,$0,$0
	l1b836:	dc.b	$0,$e6,$0,$1e,$8,$c0,$0,$aa,$0,$40,$0,$7,$0,$0,$0,$44
		dc.b	$0,$12,$6,$66,$0,$9,$44,$c0,$12,$c0,$2,$60,$2,$6e,$1,$20
		dc.b	$8,$22,$1,$20,$8,$1c,$1,$6,$8,$f,$1,$6,$8,$f1,$1,$17
		dc.b	$8,$e4,$1,$17,$8,$de,$1,$20,$3,$22,$1,$20,$3,$1c,$1,$6
		dc.b	$3,$f,$1,$6,$3,$f1,$1,$17,$3,$e4,$1,$17,$3,$de,$1,$6
		dc.b	$8,$d2,$1,$6,$3,$d2,$1,$6,$8,$2e,$1,$6,$3,$2e,$1,$20
		dc.b	$5,$1f,$1,$17,$5,$e1,$1,$0,$fa,$e1,$1,$0,$fa,$1f,$1,$0
		dc.b	$fa,$0,$b,$1,$0,$f,$b,$1,$8,$17,$1,$9,$f7,$38,$1,$f
		dc.b	$fd,$2e,$1,$f,$fd,$3e,$b,$1,$32,$33,$b,$1,$6,$12,$1,$e3
		dc.b	$8,$1f,$1,$c,$0,$3b,$1,$9,$2,$36,$1,$d,$0,$39,$1,$a
		dc.b	$2,$34,$1,$d,$0,$32,$b,$1,$5,$11,$4,$0,$7f,$0,$10,$0
		dc.b	$81,$0,$6,$4a,$0,$66,$2,$36,$0,$8e,$4,$7e,$0,$0,$0,$36
		dc.b	$0,$72,$a,$4a,$0,$9a,$32,$63,$4f,$0,$30,$59,$a7,$0,$1c,$0
		dc.b	$0,$81,$30,$0,$97,$ba,$2e,$0,$a7,$59,$32,$0,$65,$4c,$18,$0
		dc.b	$0,$81,$2e,$0,$81,$0,$ff,$e6,$44,$48,$6,$10,$12,$4,$0,$a
		dc.b	$44,$44,$6,$5,$7,$4,$0,$2,$44,$44,$12,$11,$13,$10,$0,$4
		dc.b	$1,$b,$1,$38,$88,$8a,$5,$b,$6a,$44,$30,$16,$88,$8a,$5,$a
		dc.b	$42,$36,$30,$16,$45,$46,$44,$45,$12,$2,$4,$0,$0,$2,$6,$4
		dc.b	$6,$5,$6,$3,$6,$1,$6,$1d,$6,$1c,$0,$0,$44,$45,$12,$4
		dc.b	$4,$c,$0,$e,$6,$10,$6,$11,$6,$f,$6,$d,$6,$1f,$6,$1e
		dc.b	$0,$0,$1,$8b,$2,$70,$44,$48,$4,$e,$10,$2,$0,$8,$44,$48
		dc.b	$1c,$c,$1e,$0,$0,$c,$88,$8a,$6,$2,$41,$38,$30,$16,$45,$86
		dc.b	$44,$48,$8,$12,$14,$6,$0,$6,$44,$45,$12,$2,$4,$6,$0,$8
		dc.b	$6,$a,$6,$18,$6,$19,$6,$b,$6,$9,$6,$7,$0,$0,$44,$45
		dc.b	$12,$4,$4,$12,$0,$14,$6,$16,$6,$1a,$6,$1b,$6,$17,$6,$15
		dc.b	$6,$13,$0,$0,$44,$48,$18,$16,$1a,$a,$0,$e,$44,$44,$19,$1a
		dc.b	$1b,$18,$0,$1c,$46,$86,$44,$47,$1c,$30,$32,$10,$44,$47,$30,$32
		dc.b	$2e,$12,$44,$44,$1d,$30,$31,$1c,$0,$14,$44,$44,$2e,$31,$2f,$30
		dc.b	$0,$16,$44,$44,$2f,$32,$33,$2e,$0,$18,$44,$44,$33,$1c,$1d,$32
		dc.b	$0,$1a,$1,$2b,$2,$50,$0,$4,$3b,$3c,$3d,$3a,$0,$1a,$0,$6b
		dc.b	$1,$96,$0,$7,$3e,$40,$42,$10,$0,$b,$12,$4e,$0,$6,$c2,$d
		dc.b	$83,$82,$c1,$fd,$1f,$c2,$b,$8e,$b,$24,$c2,$4d,$5,$c2,$c1,$fd
		dc.b	$1f,$c2,$b,$8e,$b,$26,$c2,$4d,$5,$c2,$c1,$fd,$1f,$c2,$b,$8e
		dc.b	$b,$28,$c2,$d,$40,$50,$c1,$cd,$60,$8f,$1,$93,$0,$81,$c2,$1d
		dc.b	$81,$40,$c2,$4d,$2,$c2,$c3,$cd,$60,$8e,$c1,$dd,$c2,$8f,$c3,$ed
		dc.b	$c2,$c3,$c1,$d,$c3,$c1,$c1,$7d,$42,$c1,$c1,$5d,$5,$c1,$c1,$bd
		dc.b	$46,$c1,$0,$bc,$0,$c2,$d,$6e,$6,$20,$d,$6e,$6,$22,$10,$bc
		dc.b	$0,$c2,$d,$6e,$6,$21,$d,$6e,$6,$23,$0,$0,$9,$64,$38,$40
		dc.b	$10,$80,$2,$1c,$1e,$1a,$18,$10,$11,$12,$13,$0,$0,$0,$8,$84
		dc.b	$fb,$be,$0,$0,$0,$a,$0,$7,$0,$10,$0,$28,$40,$c,$0,$1
		dc.b	$0,$0,$80,$1,$1,$0,$4,$1a,$0,$0,$2,$58,$0,$0
	l1bac4:	dc.b	$0,$44,$0,$10,$2,$0,$0,$30,$0,$18,$0,$6,$0,$0,$0,$7d
		dc.b	$1,$6,$0,$c,$1,$c,$0,$fa,$1,$0,$f,$fa,$1,$0,$6,$fa
		dc.b	$1,$0,$6,$d5,$1,$0,$6,$83,$7,$16,$0,$a,$13,$c1,$8,$c
		dc.b	$0,$5f,$4c,$1f,$0,$0,$61,$51,$2,$0,$0,$81,$0,$0,$81,$0
		dc.b	$8,$0,$0,$81,$40,$c6,$44,$47,$0,$2,$4,$2,$44,$43,$0,$4
		dc.b	$1,$4,$44,$43,$2,$4,$3,$6,$44,$44,$2,$1,$3,$0,$0,$8
		dc.b	$0,$6,$0,$73,$0,$c1,$1e,$e9,$e,$8,$7,$d0,$0,$b,$5,$5e
		dc.b	$44,$51,$6,$8,$a,$8a,$4,$6,$1,$0,$0,$0,$0,$0
	l1bb42:	dc.b	$0,$c6,$0,$1e,$7,$0,$0,$8e,$0,$3c,$0,$8,$0,$0,$0,$75
		dc.b	$0,$13,$6,$66,$0,$a,$27,$10,$14,$50,$2,$c,$2,$26,$1,$0
		dc.b	$0,$27,$1,$3,$0,$23,$1,$6,$0,$17,$1,$7,$0,$f,$1,$1
		dc.b	$3,$23,$1,$3,$3,$17,$1,$3,$4,$f,$1,$3,$fc,$eb,$1,$5
		dc.b	$f1,$0,$1,$0,$fc,$f,$1,$7,$0,$d9,$1,$0,$5,$e5,$1,$0
		dc.b	$4,$f,$1,$3,$6,$d9,$1,$0,$5,$0,$1,$1,$fd,$23,$1,$3
		dc.b	$fd,$17,$1,$3,$fc,$f,$1,$6,$0,$0,$13,$c1,$28,$2c,$1,$0
		dc.b	$0,$cd,$1,$0,$0,$8b,$7,$15,$0,$2a,$1,$3,$fa,$d9,$1,$a
		dc.b	$fd,$0,$1,$4,$0,$d2,$1,$3,$2,$d2,$1,$3,$fe,$d2,$0,$0
		dc.b	$7c,$18,$0,$5e,$4e,$1f,$2e,$0,$8f,$c8,$0,$5e,$b2,$1f,$32,$0
		dc.b	$0,$81,$0,$0,$84,$18,$c,$0,$7e,$3,$6,$61,$51,$2,$14,$65
		dc.b	$c1,$d7,$6,$61,$af,$2,$14,$65,$3f,$d7,$22,$0,$82,$3,$1a,$0
		dc.b	$71,$c8,$14,$65,$3f,$d7,$1,$b4,$10,$8f,$1,$73,$0,$8f,$c1,$7d
		dc.b	$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$26,$28,$2,$bc,$ff,$e6,$88,$84,$c,$1b,$d,$1a,$0,$e,$88,$88
		dc.b	$6,$1a,$c,$14,$0,$10,$0,$8,$6,$2e,$22,$14,$0,$14,$0,$4
		dc.b	$22,$2f,$23,$2e,$0,$18,$a,$cb,$3,$a8,$0,$5,$e,$2,$2,$0
		dc.b	$0,$8,$a,$c,$6,$d,$8,$b,$9,$0,$0,$0,$0,$5,$e,$4
		dc.b	$2,$0,$0,$2,$4,$6,$6,$c,$8,$a,$8,$0,$0,$0,$0,$5
		dc.b	$e,$5,$2,$0,$0,$3,$5,$7,$6,$d,$8,$b,$9,$0,$0,$0
		dc.b	$0,$5,$e,$8,$2,$0,$0,$2,$4,$6,$6,$22,$8,$20,$1e,$0
		dc.b	$0,$0,$0,$5,$e,$9,$2,$0,$0,$3,$5,$7,$6,$23,$8,$21
		dc.b	$1f,$0,$0,$0,$0,$5,$e,$c,$2,$0,$0,$1e,$20,$22,$6,$23
		dc.b	$8,$21,$1f,$0,$0,$0,$0,$4c,$80,$18,$d,$ae,$23,$18,$88,$84
		dc.b	$34,$1b,$35,$1a,$0,$1a,$88,$88,$32,$1a,$34,$14,$0,$1c,$0,$8
		dc.b	$32,$2e,$36,$14,$0,$12,$0,$4,$36,$2f,$37,$2e,$0,$6,$1e,$e5
		dc.b	$e,$a,$4,$34,$0,$32,$6,$36,$6,$37,$6,$33,$6,$35,$0,$0
		dc.b	$43,$86,$d,$ce,$0,$16,$d,$8e,$30,$25,$d,$8e,$10,$24,$4,$4b
		dc.b	$1,$d4,$2,$4b,$80,$18,$0,$f3,$10,$9d,$c1,$4d,$8,$9d,$0,$6
		dc.b	$6,$15,$0,$4e,$0,$30,$f0,$15,$0,$f3,$8,$9d,$c1,$4d,$40,$9d
		dc.b	$0,$6,$6,$35,$0,$4e,$0,$31,$f0,$15,$1,$93,$0,$81,$0,$6
		dc.b	$2,$15,$d,$fb,$0,$e,$f4,$44,$d,$fb,$0,$f,$f4,$44,$e,$1b
		dc.b	$8,$12,$4,$44,$f0,$15,$0,$0,$3,$ec,$23,$28,$80,$80,$0,$6c
		dc.b	$30,$24,$80,$80,$0,$6c,$10,$25,$10,$80,$10,$15,$11,$14,$26,$e
		dc.b	$18,$2,$c,$0,$0,$0,$39,$7b,$ee,$f8,$0,$1,$0,$f,$0,$b
		dc.b	$0,$2d,$0,$3c,$40,$d,$0,$1,$0,$2,$80,$a,$1,$0,$2,$71
		dc.b	$0,$83,$fe,$a2,$0,$af,$4,$e2,$0,$0
	l1bd8c:	dc.b	$0,$3c,$0,$10,$1,$c0,$0,$2c,$0,$14,$0,$5,$0,$0,$0,$5d
		dc.b	$1,$6,$0,$5d,$1,$3,$c,$1f,$1,$1,$4b,$0,$1,$0,$4b,$c2
		dc.b	$1,$1,$4b,$a9,$1,$3,$c,$a9,$1,$6,$0,$a3,$0,$7e,$a,$0
		dc.b	$1,$82,$a,$0,$0,$0,$72,$36,$c,$0,$30,$8b,$88,$85,$c,$2
		dc.b	$2,$0,$0,$2,$4,$6,$8,$8,$a,$c,$0,$0,$88,$85,$c,$4
		dc.b	$2,$1,$1,$3,$5,$6,$8,$9,$b,$d,$0,$0,$88,$85,$c,$6
		dc.b	$2,$0,$0,$2,$4,$6,$8,$5,$3,$1,$0,$0,$88,$85,$c,$8
		dc.b	$2,$c,$c,$a,$8,$6,$8,$9,$b,$d,$0,$0,$0,$0
	l1be0a:	dc.b	$0,$6a,$0,$1e,$3,$c0,$0,$5a,$0,$14,$0,$7,$0,$0,$0,$4e
		dc.b	$0,$12,$6,$66,$0,$9,$4e,$20,$4e,$20,$0,$dc,$0,$0,$1,$0
		dc.b	$0,$1f,$1,$7,$0,$0,$1,$2e,$6,$f9,$1,$36,$1a,$e1,$1,$36
		dc.b	$1a,$c2,$1,$2e,$6,$ba,$1,$7,$0,$ba,$1,$0,$0,$b2,$1,$0
		dc.b	$fd,$b2,$1,$7,$fd,$ba,$1,$2e,$4,$ba,$1,$2e,$4,$f9,$1,$7
		dc.b	$fd,$0,$1,$0,$fd,$1f,$1,$1f,$fa,$0,$12,$18,$84,$0,$2,$ec
		dc.b	$7d,$0,$2,$18,$0,$7c,$a,$0,$0,$81,$1,$2c,$6,$1a,$44,$44
		dc.b	$6,$10,$8,$0,$0,$2,$44,$44,$6,$10,$8,$0,$0,$4,$0,$0
		dc.b	$ff,$e6,$44,$45,$e,$2,$2,$1a,$1a,$18,$16,$6,$6,$8,$8,$14
		dc.b	$12,$10,$0,$0,$44,$45,$e,$4,$2,$0,$0,$2,$4,$6,$6,$8
		dc.b	$8,$a,$c,$e,$0,$0,$44,$45,$c,$6,$2,$0,$0,$2,$4,$6
		dc.b	$8,$16,$18,$1a,$0,$0,$44,$45,$c,$8,$2,$e,$e,$c,$a,$8
		dc.b	$8,$14,$12,$10,$0,$0,$0,$b,$3,$c,$19,$1c,$0,$0,$83,$3c
		dc.b	$5,$24,$88,$8a,$6,$2,$46,$12,$30,$16,$0,$0,$d0,$80,$2,$4
		dc.b	$6,$8,$0,$0
	l1beee:	dc.b	$1,$1a,$0,$1e,$9,$80,$0,$b6,$0,$68,$0,$8,$0,$0,$0,$77
		dc.b	$0,$13,$6,$66,$0,$a,$10,$bc,$45,$10,$2,$de,$2,$fe,$1,$0
		dc.b	$0,$45,$1,$3,$fb,$2f,$1,$6,$fd,$2f,$1,$6,$3,$2f,$1,$3
		dc.b	$5,$2f,$1,$0,$1,$3a,$1,$0,$4,$35,$1,$3,$fb,$d9,$1,$6
		dc.b	$fd,$d9,$1,$6,$3,$d9,$1,$3,$5,$d9,$1,$6,$fd,$12,$1,$6
		dc.b	$3,$12,$1,$f,$0,$7,$1,$6,$3,$fe,$1,$6,$fd,$f9,$1,$d
		dc.b	$0,$db,$1,$2a,$0,$f5,$1,$2a,$ff,$0,$1,$2a,$1,$6,$1,$2a
		dc.b	$0,$b,$1,$0,$5,$d9,$1,$0,$f,$e1,$1,$0,$f,$eb,$1,$0
		dc.b	$5,$0,$1,$2,$5,$f9,$1,$16,$fb,$0,$b,$1,$24,$30,$1,$3
		dc.b	$0,$d9,$b,$1,$16,$18,$b,$1,$4,$6,$1,$2,$0,$d3,$1,$2
		dc.b	$0,$89,$7,$16,$0,$40,$13,$c1,$3e,$42,$1,$14,$0,$e6,$b,$1
		dc.b	$2,$3,$1,$0,$fd,$0,$0,$0,$7d,$12,$0,$79,$0,$25,$0,$4b
		dc.b	$a2,$25,$0,$0,$85,$1e,$8,$46,$57,$3b,$8,$0,$7e,$c,$6,$4f
		dc.b	$63,$0,$8,$0,$7f,$0,$2,$0,$81,$0,$2,$4f,$9d,$0,$4,$7e
		dc.b	$0,$fe,$16,$5d,$0,$56,$18,$27,$78,$0,$16,$27,$88,$0,$1c,$36
		dc.b	$72,$0,$1e,$36,$8e,$0,$1e,$8,$82,$f5,$1c,$8,$7e,$f7,$1a,$fc
		dc.b	$78,$27,$1a,$1,$84,$18,$22,$7f,$0,$0,$2e,$63,$46,$24,$2a,$7d
		dc.b	$12,$f6,$20,$2f,$0,$8b,$10,$0,$0,$81,$2,$14,$10,$8f,$1,$d3
		dc.b	$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3
		dc.b	$0,$c1,$1e,$e9,$44,$3e,$3,$30,$1e,$e9,$45,$3f,$3,$30,$2,$13
		dc.b	$0,$81,$0,$1c,$0,$2,$6,$95,$e,$e,$6,$46,$f0,$15,$0,$6
		dc.b	$6,$b5,$e,$e,$6,$47,$f0,$15,$0,$6,$9,$55,$e,$e,$28,$48
		dc.b	$f0,$15,$0,$93,$10,$9d,$c1,$4d,$8,$9d,$0,$4e,$0,$34,$0,$93
		dc.b	$8,$9d,$c1,$4d,$40,$9d,$0,$4e,$0,$35,$40,$46,$4,$3,$0,$6
		dc.b	$7,$2,$44,$47,$0,$6,$4,$4,$6,$67,$0,$2,$4,$6,$6,$63
		dc.b	$0,$2,$3,$8,$41,$6,$0,$8,$c,$6,$a,$8,$0,$a,$0,$3
		dc.b	$8,$9,$c,$c,$ff,$e6,$4,$8,$12,$8,$14,$6,$0,$e,$4,$4
		dc.b	$14,$9,$15,$8,$0,$10,$6,$64,$e,$3,$f,$2,$0,$12,$6,$68
		dc.b	$e,$4,$10,$2,$0,$14,$44,$48,$16,$6,$18,$4,$0,$16,$1,$b
		dc.b	$1,$a8,$88,$8a,$6,$17,$7a,$3d,$30,$16,$88,$8a,$6,$16,$52,$3a
		dc.b	$30,$16,$46,$c6,$10,$3,$16,$18,$1a,$18,$4,$3,$18,$1a,$1c,$1a
		dc.b	$6,$63,$16,$1a,$1e,$1c,$4,$3,$1c,$20,$12,$1e,$6,$63,$1e,$20
		dc.b	$10,$20,$6,$64,$20,$24,$22,$1e,$0,$22,$4,$4,$20,$26,$22,$1c
		dc.b	$0,$24,$4,$4,$28,$1c,$26,$1a,$0,$26,$6,$64,$28,$1e,$24,$1a
		dc.b	$0,$28,$44,$44,$24,$26,$28,$22,$0,$2a,$46,$e6,$10,$3,$17,$19
		dc.b	$1b,$19,$4,$3,$19,$1b,$1d,$1b,$6,$63,$17,$1b,$1f,$1d,$4,$3
		dc.b	$1d,$21,$13,$1f,$6,$63,$1f,$21,$11,$21,$6,$64,$21,$25,$23,$1f
		dc.b	$0,$23,$4,$4,$21,$27,$23,$1d,$0,$25,$4,$4,$29,$1d,$27,$1b
		dc.b	$0,$27,$6,$64,$29,$1f,$25,$1b,$0,$29,$44,$44,$25,$27,$29,$23
		dc.b	$0,$2b,$46,$6,$4,$7,$2e,$30,$32,$2c,$4,$8,$2c,$32,$2e,$2a
		dc.b	$0,$2e,$0,$b,$8,$4c,$42,$46,$44,$47,$20,$12,$10,$30,$2,$4b
		dc.b	$2,$12,$44,$45,$12,$32,$4,$14,$0,$12,$6,$10,$6,$e,$6,$f
		dc.b	$6,$11,$6,$13,$6,$15,$0,$0,$1e,$e5,$a,$32,$c,$38,$3,$32
		dc.b	$c,$39,$3,$32,$0,$0,$1,$6c,$2,$12,$1e,$e5,$12,$32,$4,$14
		dc.b	$0,$12,$6,$10,$6,$e,$6,$f,$6,$11,$6,$13,$6,$15,$0,$0
		dc.b	$0,$0,$1,$51,$29,$2c,$1,$50,$29,$2c,$2,$ac,$42,$68,$d0,$80
		dc.b	$16,$17,$10,$12,$e,$f,$14,$15,$2,$4,$6,$5,$7,$8,$32,$0
		dc.b	$d0,$80,$2a,$2b,$24,$28,$25,$29,$22,$23,$26,$27,$0,$0,$3f,$de
		dc.b	$ec,$d7,$0,$1,$0,$10,$0,$b,$0,$2e,$0,$64,$40,$e,$0,$1
		dc.b	$0,$2,$80,$a,$1,$0,$7,$4e,$0,$7f,$5,$25,$0,$7f,$8,$a2
		dc.b	$0,$0
	l1c210:	dc.b	$0,$2a,$0,$1e,$0,$c0,$0,$2a,$0,$4,$0,$7,$0,$0,$0,$69
		dc.b	$0,$12,$6,$66,$0,$9,$69,$78,$24,$ea,$0,$54,$0,$6a,$1,$0
		dc.b	$0,$0,$1,$2a,$0,$0,$1,$8,$5,$ff,$ff,$e6,$e,$2e,$0,$0
		dc.b	$0,$6,$e,$4e,$0,$2,$e,$4e,$20,$3,$0,$b,$6,$dc,$e,$6e
		dc.b	$0,$4,$e,$6e,$20,$5,$e,$8e,$0,$2,$e,$8e,$20,$3,$0,$0
		dc.b	$5,$dc,$63,$9c,$80,$80,$0,$71,$0,$0,$80,$80,$0,$72,$0,$2
		dc.b	$80,$80,$0,$72,$20,$3,$50,$80,$0,$0,$39,$7b,$f3,$3a,$0,$1
		dc.b	$0,$12,$0,$7,$0,$30,$0,$46,$40,$f,$0,$1,$0,$2,$80,$a
		dc.b	$1,$0,$5,$7e,$0,$83,$fc,$b5,$0,$9f
	l1c29a:	dc.b	$0,$3a,$0,$1e,$1,$80,$0,$36,$0,$8,$0,$8,$0,$0,$0,$40
		dc.b	$0,$13,$6,$66,$0,$a,$40,$74,$12,$75,$0,$90,$0,$b2,$1,$0
		dc.b	$0,$d,$1,$26,$0,$0,$1,$12,$3,$0,$1,$14,$0,$0,$1,$b
		dc.b	$0,$0,$1,$b,$fe,$0,$0,$0,$81,$0,$40,$6,$e,$2e,$0,$0
		dc.b	$0,$6,$e,$4e,$0,$2,$e,$4e,$20,$3,$e,$ae,$0,$8,$e,$ae
		dc.b	$20,$9,$0,$b,$4,$92,$e,$ce,$0,$6,$e,$ce,$0,$7,$0,$b
		dc.b	$3,$6e,$e,$6e,$20,$4,$e,$6e,$0,$5,$0,$b,$2,$48,$0,$b
		dc.b	$80,$2,$0,$93,$10,$9d,$c1,$4d,$8,$9d,$0,$4e,$0,$a,$0,$93
		dc.b	$8,$9d,$c1,$4d,$40,$9d,$0,$4e,$0,$b,$0,$0,$2,$ec,$37,$aa
		dc.b	$80,$80,$0,$71,$0,$0,$80,$80,$0,$72,$0,$2,$80,$80,$0,$72
		dc.b	$20,$3,$80,$80,$0,$75,$0,$8,$80,$80,$0,$75,$20,$9,$50,$80
		dc.b	$0,$0,$35,$39,$f3,$3a,$0,$1,$0,$14,$0,$9,$0,$32,$0,$5a
		dc.b	$40,$10,$0,$1,$0,$2,$80,$a,$1,$0,$7,$53,$0,$83,$fc,$57
		dc.b	$0,$9f
	l1c36c:	dc.b	$0,$6e,$0,$1e,$2,$80,$0,$46,$0,$2c,$0,$7,$0,$0,$0,$75
		dc.b	$0,$12,$6,$66,$0,$9,$75,$30,$75,$30,$0,$d8,$0,$0,$1,$0
		dc.b	$0,$75,$1,$e,$0,$5d,$1,$5,$8,$57,$1,$5,$fc,$52,$1,$e
		dc.b	$0,$ba,$1,$5,$8,$cc,$1,$5,$fc,$cc,$2,$0,$8,$4f,$2,$0
		dc.b	$fc,$0,$2,$0,$fc,$34,$0,$44,$61,$2b,$0,$22,$88,$15,$0,$0
		dc.b	$79,$24,$0,$0,$83,$10,$2,$59,$59,$0,$2,$3b,$90,$0,$4,$0
		dc.b	$7f,$0,$6,$0,$81,$0,$8,$0,$71,$c8,$8,$0,$86,$e0,$22,$28
		dc.b	$8,$4,$a,$2,$0,$a,$6,$68,$8,$6,$c,$2,$0,$c,$22,$24
		dc.b	$a,$5,$b,$4,$0,$e,$6,$64,$c,$7,$d,$6,$0,$10,$0,$b
		dc.b	$b,$70,$22,$24,$9,$a,$b,$8,$0,$12,$6,$64,$9,$c,$d,$8
		dc.b	$0,$14,$1,$6b,$4,$92,$0,$4b,$80,$e,$d,$ae,$3,$e,$0,$6
		dc.b	$2,$15,$28,$9a,$0,$10,$e,$e,$20,$12,$f0,$15,$40,$6,$22,$27
		dc.b	$0,$2,$4,$2,$6,$67,$0,$2,$6,$4,$22,$23,$0,$4,$5,$6
		dc.b	$6,$63,$0,$6,$7,$8,$0,$0,$d0,$80,$e,$10,$a,$b,$c,$d
		dc.b	$12,$14,$2,$3,$0,$0
	l1c452:	dc.b	$0,$46,$0,$1e,$1,$80,$0,$36,$0,$14,$0,$7,$0,$0,$0,$57
		dc.b	$0,$12,$6,$66,$0,$9,$57,$e4,$57,$e4,$0,$9a,$0,$0,$1,$e3
		dc.b	$0,$57,$1,$df,$4,$34,$1,$1d,$0,$1d,$1,$1d,$0,$d5,$1,$11
		dc.b	$0,$d5,$1,$11,$0,$d9,$0,$1b,$7b,$c,$2,$0,$7e,$fb,$0,$0
		dc.b	$81,$0,$0,$a7,$a7,$0,$ff,$e6,$22,$23,$2,$6,$7,$4,$6,$65
		dc.b	$a,$6,$2,$0,$0,$5,$4,$6,$6,$7,$0,$0,$0,$b,$9,$26
		dc.b	$22,$25,$a,$2,$2,$0,$0,$5,$4,$6,$6,$2,$0,$0,$0,$b
		dc.b	$4,$92,$88,$8a,$6,$4,$65,$b,$30,$16,$0,$a,$6,$6,$55,$b
		dc.b	$30,$16,$0,$b,$2,$e,$44,$44,$9,$a,$b,$8,$0,$4,$28,$84
		dc.b	$9,$a,$b,$8,$0,$6,$0,$6,$0,$0,$d0,$80,$4,$6,$2,$8
		dc.b	$0,$0
	l1c4f4:	dc.b	$0,$3a,$0,$1e,$0,$c0,$0,$2a,$0,$14,$0,$7,$0,$0,$0,$52
		dc.b	$0,$12,$6,$66,$0,$9,$52,$8,$52,$8,$0,$56,$0,$0,$1,$a
		dc.b	$0,$52,$1,$e,$4,$3a,$1,$a,$0,$d5,$0,$0,$7c,$17,$0,$0
		dc.b	$81,$0,$4,$0,$7e,$fb,$0,$59,$a7,$0,$ff,$e6,$22,$24,$1,$2
		dc.b	$3,$0,$0,$2,$6,$64,$1,$4,$5,$0,$0,$4,$22,$24,$5,$2
		dc.b	$3,$4,$0,$6,$0,$0,$d0,$80,$2,$4,$6,$8,$9,$0,$0,$0
	l1c554:	dc.b	$0,$34,$0,$10,$1,$40,$0,$24,$0,$14,$0,$6,$0,$0,$0,$75
		dc.b	$1,$0,$0,$0,$1,$17,$23,$d2,$1,$17,$23,$a3,$1,$0,$0,$8b
		dc.b	$1,$1,$0,$e9,$0,$6c,$bf,$5,$0,$9a,$4b,$5,$8,$6b,$bd,$0
		dc.b	$9,$98,$48,$0,$ff,$e6,$44,$43,$0,$2,$8,$2,$44,$43,$0,$2
		dc.b	$9,$4,$44,$44,$6,$2,$4,$8,$0,$6,$44,$44,$6,$2,$4,$9
		dc.b	$0,$8,$0,$6,$0,$0
	l1c5aa:	dc.b	$0,$48,$0,$10,$2,$80,$0,$38,$0,$14,$0,$7,$0,$0,$0,$69
		dc.b	$1,$5,$0,$14,$1,$5,$fb,$e,$1,$5,$0,$dd,$1,$5,$fb,$dd
		dc.b	$2,$0,$fc,$0,$2,$0,$fb,$0,$1,$0,$fe,$cc,$1,$0,$fe,$97
		dc.b	$7,$16,$0,$e,$13,$c1,$c,$10,$0,$0,$a7,$59,$0,$7f,$0,$0
		dc.b	$2,$0,$81,$0,$4,$0,$0,$81,$41,$6,$10,$4,$1,$2,$3,$0
		dc.b	$0,$2,$28,$88,$4,$2,$6,$0,$0,$4,$28,$84,$6,$3,$7,$2
		dc.b	$0,$6,$10,$4,$5,$6,$7,$4,$0,$8,$0,$6,$1,$b4,$10,$8f
		dc.b	$1,$73,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1
		dc.b	$0,$73,$0,$c1,$1e,$e9,$12,$c,$4,$1a,$1,$55,$6,$7a,$0,$6
		dc.b	$e,$e,$8,$a,$f0,$15,$0,$0
	l1c642:	dc.b	$0,$78,$0,$10,$4,$0,$0,$50,$0,$2c,$0,$7,$0,$0,$0,$6f
		dc.b	$1,$0,$0,$6f,$1,$9,$0,$60,$1,$4,$7,$60,$f,$e,$e,$5
		dc.b	$1,$9,$0,$c3,$1,$4,$7,$c3,$1,$4,$f9,$c3,$2,$0,$0,$60
		dc.b	$b,$1,$4,$e,$b,$1,$2,$e,$b,$1,$6,$e,$1,$0,$f9,$0
		dc.b	$1,$0,$fe,$c3,$1,$0,$fe,$91,$7,$16,$0,$1a,$13,$c1,$18,$1c
		dc.b	$2,$6c,$42,$0,$2,$6c,$be,$0,$4,$0,$7f,$0,$c,$0,$81,$0
		dc.b	$2,$0,$0,$7f,$8,$0,$0,$81,$0,$68,$40,$21,$0,$68,$c0,$21
		dc.b	$0,$0,$7a,$1f,$0,$0,$86,$1f,$ff,$e6,$22,$28,$8,$4,$a,$2
		dc.b	$0,$2,$6,$68,$8,$6,$c,$2,$0,$4,$22,$24,$a,$5,$b,$4
		dc.b	$0,$6,$6,$64,$6,$d,$7,$c,$0,$8,$0,$b,$6,$dc,$10,$4
		dc.b	$3,$4,$5,$2,$0,$a,$10,$4,$3,$6,$7,$2,$0,$a,$10,$4
		dc.b	$9,$a,$b,$8,$0,$c,$10,$4,$9,$c,$d,$8,$0,$c,$0,$b
		dc.b	$4,$92,$40,$6,$88,$87,$0,$10,$12,$e,$88,$87,$0,$12,$14,$10
		dc.b	$0,$b,$3,$34,$88,$83,$0,$10,$11,$12,$88,$83,$0,$14,$15,$14
		dc.b	$0,$6,$1,$b4,$10,$8f,$1,$73,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$1e,$18,$4,$1a
		dc.b	$2,$d5,$66,$7a,$0,$8,$e,$e,$8,$16,$f0,$15,$0,$0
	l1c750:	dc.b	$0,$2c,$0,$10,$1,$c0,$0,$2c,$0,$4,$0,$4,$0,$0,$0,$46
		dc.b	$1,$23,$18,$0,$1,$46,$0,$38,$1,$46,$0,$c8,$b,$1,$2,$4
		dc.b	$1,$26,$0,$dd,$1,$26,$0,$23,$1,$f2,$0,$0,$10,$5,$c,$0
		dc.b	$2,$6,$6,$4,$5,$7,$8,$3,$2,$6,$0,$0,$0,$b,$15,$f8
		dc.b	$76,$62,$0,$1,$0,$b,$10,$7a,$76,$62,$0,$8,$76,$62,$0,$a
		dc.b	$0,$b,$d,$ba,$76,$62,$1,$9,$76,$62,$1,$b,$76,$62,$1,$7
		dc.b	$76,$62,$0,$6,$e,$ee,$3,$c,$0,$0
	l1c7ba:	dc.b	$0,$40,$0,$10,$2,$0,$0,$30,$0,$14,$0,$3,$0,$0,$0,$4b
		dc.b	$1,$1e,$12,$0,$1,$25,$0,$ee,$1,$25,$0,$1e,$1,$0,$1a,$0
		dc.b	$1,$f,$1e,$f,$1,$f,$12,$f,$1,$0,$1e,$1a,$1,$2d,$b,$4b
		dc.b	$0,$75,$2f,$0,$0,$0,$59,$a7,$0,$0,$6b,$43,$8,$0,$0,$7e
		dc.b	$1,$6b,$d,$2e,$54,$7,$0,$2,$4,$2,$54,$4,$1,$2,$3,$0
		dc.b	$0,$4,$54,$4,$1,$4,$5,$0,$0,$6,$f0,$1a,$82,$0,$1,$e0
		dc.b	$f,$e0,$1,$e,$f,$ee,$f,$80,$f,$e,$1,$ee,$11,$1,$a0,$14
		dc.b	$6,$0,$0,$b,$a,$40,$1e,$a,$3,$0,$7c,$e,$40,$11,$0,$b
		dc.b	$7,$52,$10,$4,$9,$a,$b,$8,$0,$8,$fe,$e3,$8,$9,$c,$8
		dc.b	$0,$0
	l1c84c_ship_eagle_i:
		dc.b	$0,$ea,$0,$1e,$a,$0,$0,$be,$0,$30,$0,$8,$0,$0,$0,$7d
		dc.b	$0,$13,$6,$66,$0,$a,$28,$a0,$14,$50,$3,$8,$3,$12,$1,$0
		dc.b	$0,$28,$1,$0,$6,$e7,$1,$0,$fa,$e7,$1,$1f,$0,$9,$1,$3
		dc.b	$0,$f4,$1,$9,$0,$25,$1,$1f,$0,$19,$1,$1f,$1,$f7,$1,$22
		dc.b	$0,$0,$1,$1f,$6,$fd,$1,$1f,$fa,$fd,$1,$1f,$0,$ee,$1,$1f
		dc.b	$ff,$f7,$1,$0,$1,$19,$1,$1,$5,$ef,$1,$6,$4,$f1,$1,$1
		dc.b	$4,$fc,$1,$6,$3,$fe,$1,$f,$0,$ef,$1,$3,$2,$e9,$1,$3
		dc.b	$fd,$e9,$1,$7,$0,$de,$1,$7,$0,$83,$7,$15,$0,$2c,$13,$c1
		dc.b	$2a,$2e,$1,$7,$fd,$fa,$1,$0,$fc,$0,$1,$0,$f7,$0,$1,$0
		dc.b	$b9,$0,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$f,$fa,$fa,$1,$6
		dc.b	$fd,$6,$1,$1f,$0,$1f,$1,$1f,$0,$3e,$7,$16,$0,$44,$13,$c1
		dc.b	$42,$46,$1,$1f,$0,$0,$1,$9,$4,$ed,$1,$f7,$1,$9,$2,$c
		dc.b	$7d,$b,$4,$c,$83,$b,$2,$38,$0,$8f,$10,$73,$d0,$ed,$c,$81
		dc.b	$0,$0,$c,$6e,$3d,$d,$10,$73,$30,$ed,$c,$6e,$c3,$d,$c,$0
		dc.b	$0,$7f,$16,$0,$0,$81,$6,$7f,$0,$0,$2,$14,$10,$8f,$1,$d3
		dc.b	$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3
		dc.b	$0,$c1,$1e,$e9,$30,$2a,$4,$b0,$1e,$e9,$31,$2b,$4,$b0,$1,$d3
		dc.b	$10,$8f,$c1,$1d,$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3
		dc.b	$0,$c1,$1e,$e9,$48,$42,$3,$20,$1e,$e9,$49,$43,$3,$20,$7,$cb
		dc.b	$8,$8a,$6,$95,$1,$74,$10,$8e,$1,$33,$0,$8e,$c1,$5d,$4,$8e
		dc.b	$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$3c,$36,$4,$10,$0,$d3
		dc.b	$0,$81,$d,$fb,$0,$32,$f3,$33,$d,$fb,$0,$33,$f3,$33,$0,$cb
		dc.b	$80,$4,$0,$93,$10,$9d,$c1,$4d,$8,$9d,$0,$4e,$0,$3e,$2,$b
		dc.b	$80,$5,$0,$93,$8,$9d,$c1,$4d,$40,$9d,$0,$4e,$0,$3f,$0,$73
		dc.b	$4,$97,$f,$3b,$70,$40,$f0,$80,$0,$73,$8,$97,$f,$5b,$70,$41
		dc.b	$f0,$80,$f0,$15,$1,$6b,$80,$2,$1,$33,$3,$97,$c3,$5d,$9,$80
		dc.b	$e4,$6,$ff,$e1,$0,$3c,$0,$c3,$f,$7b,$6,$22,$f0,$80,$ff,$e6
		dc.b	$90,$1a,$82,$0,$1,$8,$1,$60,$9,$80,$1,$0,$5,$44,$9,$40
		dc.b	$9,$88,$1,$5,$c,$2,$2,$0,$0,$a,$8,$6,$6,$e,$6,$2
		dc.b	$0,$0,$1,$5,$c,$3,$2,$0,$0,$b,$9,$7,$6,$f,$6,$2
		dc.b	$0,$0,$98,$9a,$82,$0,$9,$88,$9,$88,$1,$0,$9,$88,$9,$80
		dc.b	$1,$0,$9,$0,$2,$8b,$3,$c,$0,$8,$20,$1e,$22,$1c,$0,$2
		dc.b	$12,$9c,$0,$7e,$83,$3c,$0,$7c,$1,$a,$6,$2,$46,$4c,$30,$16
		dc.b	$6,$9c,$0,$2,$83,$3c,$0,$7c,$1,$a,$6,$3,$46,$4e,$30,$16
		dc.b	$1,$5,$c,$4,$2,$0,$0,$a,$8,$6,$6,$18,$6,$4,$0,$0
		dc.b	$1,$5,$c,$5,$2,$0,$0,$b,$9,$7,$6,$19,$6,$4,$0,$0
		dc.b	$0,$8b,$80,$2,$0,$4b,$1,$96,$d,$ae,$3,$1a,$1,$f3,$10,$81
		dc.b	$1,$b3,$6,$80,$1,$73,$5,$80,$0,$6,$0,$73,$4,$80,$1e,$1
		dc.b	$e0,$1,$10,$80,$0,$74,$4,$80,$f0,$1,$e0,$1,$11,$80,$e6,$86
		dc.b	$ff,$fd,$66,$68,$e,$4,$18,$2,$0,$6,$0,$b,$4,$92,$1e,$e7
		dc.b	$24,$26,$28,$6,$4,$74,$0,$c0,$49,$46,$88,$84,$14,$12,$16,$c
		dc.b	$0,$a,$88,$83,$c,$10,$12,$c,$88,$83,$10,$12,$16,$e,$88,$83
		dc.b	$c,$10,$14,$10,$88,$83,$10,$14,$16,$8,$49,$66,$88,$84,$15,$13
		dc.b	$17,$d,$0,$b,$88,$83,$d,$11,$13,$d,$88,$83,$11,$13,$17,$f
		dc.b	$88,$83,$d,$11,$15,$11,$88,$83,$11,$15,$17,$9,$0,$0,$1,$14
		dc.b	$0,$c2,$88,$87,$6,$e,$18,$16,$88,$82,$6,$c,$88,$82,$7,$d
		dc.b	$0,$0,$49,$46,$1,$11,$16,$c,$2,$92,$2,$94,$1,$ee,$8,$88
		dc.b	$49,$66,$1,$11,$17,$d,$2,$92,$2,$94,$1,$ee,$8,$88,$0,$0
		dc.b	$4,$b0,$1f,$40,$4,$b1,$1f,$40,$10,$80,$2,$3,$4,$5,$6,$7
		dc.b	$0,$0,$35,$39,$ea,$b6,$0,$1,$0,$19,$0,$14,$0,$26,$0,$34
		dc.b	$40,$12,$0,$1,$0,$2,$b,$2,$1,$0,$5,$dc,$0,$1e,$fe,$c
		dc.b	$0,$fa,$5,$14,$0,$0,$3,$20,$0,$0
	l1cb86:	dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$8,$0,$0,$0,$7d
		dc.b	$0,$13,$6,$66,$0,$a,$28,$a0,$14,$50,$0,$2c,$0,$34,$1,$0
		dc.b	$0,$0,$c2,$d,$40,$40,$2,$e,$0,$0,$0,$0,$80,$80,$0,$10
		ds.b	4
		dc.b	$3b,$9c,$f7,$7c,$0,$1,$0,$1c,$0,$16,$0,$29,$0,$37,$40,$13
		dc.b	$0,$1,$0,$2,$b,$2,$1,$0,$5,$dc,$0,$32,$fe,$c,$0,$fa
		dc.b	$5,$14,$0,$0,$3,$20,$0,$0
	l1cbe2:	dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$8,$0,$0,$0,$7d
		dc.b	$0,$13,$6,$66,$0,$a,$28,$a0,$14,$50,$0,$2c,$0,$34,$1,$0
		dc.b	$0,$0,$c2,$1d,$1,$40,$2,$e,$0,$0,$0,$0,$80,$80,$0,$10
		ds.b	4
		dc.b	$3b,$9c,$e0,$11,$0,$1,$0,$1e,$0,$16,$0,$2b,$0,$37,$40,$14
		dc.b	$0,$1,$0,$2,$b,$2,$1,$0,$5,$dc,$0,$32,$fe,$c,$1,$3
		dc.b	$5,$14,$0,$0,$3,$20,$0,$0
	l1cc3e:	dc.b	$0,$ba,$0,$1e,$8,$80,$0,$a6,$0,$18,$0,$9,$0,$0,$0,$61
		dc.b	$0,$14,$6,$66,$0,$b,$41,$a,$9,$1b,$2,$5e,$2,$72,$1,$d
		dc.b	$0,$d,$1,$1a,$0,$f3,$1,$0,$6,$f3,$1,$0,$fa,$f3,$1,$4
		dc.b	$1,$f3,$1,$4,$ff,$f3,$1,$0,$0,$d,$1,$0,$4,$fa,$1,$0
		dc.b	$ff,$6,$b,$1,$0,$4,$13,$c1,$36,$3a,$1,$0,$0,$f0,$1,$0
		dc.b	$0,$a5,$7,$15,$0,$18,$13,$c1,$16,$1a,$1,$0,$6,$0,$1,$0
		dc.b	$2a,$0,$7,$16,$0,$20,$13,$c1,$1e,$22,$1,$a,$0,$f,$1,$a
		dc.b	$0,$25,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$16,$0,$0,$1,$34
		dc.b	$0,$0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$fa,$0,$1,$0
		dc.b	$d4,$0,$7,$15,$0,$38,$1,$16,$0,$f4,$1,$7,$fc,$f6,$1,$d
		dc.b	$0,$6,$1,$6,$ed,$0,$0,$0,$7b,$1e,$2,$1e,$86,$f,$2,$1e
		dc.b	$7a,$f,$0,$0,$85,$1e,$2,$0,$0,$82,$1,$b4,$10,$8f,$1,$73
		dc.b	$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$1c,$16,$2,$46,$1,$d3,$10,$8f,$c1,$1d,$8f,$40
		dc.b	$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$2c,$26
		dc.b	$1,$4d,$1e,$e9,$2d,$27,$1,$4d,$1,$74,$10,$8d,$1,$33,$0,$8d
		dc.b	$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f
		dc.b	$1,$4d,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$34,$2e,$1,$4d,$1,$74,$10,$8e
		dc.b	$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$14,$36,$1,$4d,$1,$73,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$24,$1e,$1,$f3
		dc.b	$90,$1a,$82,$0,$1,$8,$1,$60,$9,$80,$1,$0,$5,$44,$9,$40
		dc.b	$9,$88,$ff,$e6,$1,$3,$0,$1,$4,$2,$1,$7,$0,$2,$4,$6
		dc.b	$1,$4,$6,$4,$3,$2,$0,$a,$1,$d3,$0,$81,$1,$8b,$1,$86
		dc.b	$48,$46,$d,$5b,$80,$3e,$40,$8,$7f,$7f,$7f,$40,$48,$66,$d,$5b
		dc.b	$94,$3f,$40,$8,$7f,$7f,$7f,$41,$ff,$e6,$98,$9a,$82,$0,$9,$88
		dc.b	$9,$88,$1,$0,$9,$88,$9,$80,$1,$0,$9,$0,$1,$3,$0,$1
		dc.b	$6,$8,$1,$7,$0,$2,$6,$4,$1,$b,$1,$44,$19,$1c,$72,$9
		dc.b	$83,$3c,$72,$5a,$1,$a,$6,$6,$46,$3c,$30,$16,$1e,$e4,$a,$9
		dc.b	$b,$8,$0,$a,$0,$d3,$5,$97,$0,$8b,$80,$8,$0,$1c,$0,$7c
		dc.b	$f,$e,$6,$10,$0,$93,$4,$97,$0,$4b,$80,$2,$f,$2e,$40,$12
		dc.b	$0,$93,$8,$97,$0,$4b,$80,$2,$f,$4e,$40,$13,$1,$13,$3,$97
		dc.b	$0,$cb,$80,$2,$c3,$5d,$9,$80,$10,$3c,$0,$c3,$f,$6e,$6,$e
		dc.b	$0,$6,$0,$f3,$10,$9b,$c1,$4d,$8,$9b,$c2,$fd,$7,$c1,$f,$9b
		dc.b	$0,$c,$28,$80,$1,$d3,$10,$81,$1,$93,$6,$80,$1,$53,$5,$80
		dc.b	$0,$73,$4,$80,$1e,$1,$f3,$1,$2,$80,$0,$74,$4,$80,$f0,$1
		dc.b	$f3,$1,$3,$80,$0,$0,$1,$f0,$18,$10,$1,$f0,$e7,$f0,$a0,$80
		dc.b	$17,$8d,$0,$78,$0,$10,$10,$80,$2,$4,$5,$6,$7,$8,$a,$0
		dc.b	$0,$0,$30,$f7,$e6,$74,$1,$1,$0,$21,$0,$19,$0,$2c,$0,$96
		dc.b	$40,$15,$0,$1,$0,$0,$b,$2,$1,$0,$1,$a0,$0,$68,$3,$40
		dc.b	$1,$a0,$3,$40,$0,$0
	l1ced4:	dc.b	$0,$d6,$0,$1e,$a,$0,$0,$be,$0,$1c,$0,$9,$0,$0,$0,$7b
		dc.b	$0,$14,$6,$66,$0,$b,$25,$48,$9,$ab,$2,$c6,$2,$d0,$1,$0
		dc.b	$0,$1a,$1,$1a,$0,$0,$1,$0,$7,$f3,$1,$17,$0,$0,$1,$0
		dc.b	$f9,$f3,$1,$3,$4,$f5,$1,$a,$0,$f9,$1,$3,$fc,$f5,$1,$1a
		dc.b	$0,$1a,$1,$17,$0,$0,$b,$1,$0,$4,$1,$ff,$4,$3,$1,$9
		dc.b	$3,$0,$1,$c,$fc,$2,$b,$1,$4,$16,$1,$7,$0,$ee,$1,$7
		dc.b	$0,$8a,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$e,$0,$15,$1,$e
		dc.b	$0,$34,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$1e,$0,$0,$1,$46
		dc.b	$0,$0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f8,$1,$1,$0
		dc.b	$c3,$1,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$d,$0,$1,$0
		dc.b	$41,$0,$7,$16,$0,$40,$13,$c1,$3e,$42,$1,$11,$fd,$0,$1,$16
		dc.b	$1,$ff,$1,$6,$fc,$fa,$1,$2,$ff,$e,$1,$8,$e6,$0,$2,$15
		dc.b	$7b,$15,$2,$15,$85,$15,$2,$38,$0,$8f,$10,$82,$0,$c,$10,$10
		dc.b	$83,$0,$10,$10,$7d,$0,$2,$14,$10,$8f,$1,$d3,$0,$8f,$c1,$7d
		dc.b	$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9
		dc.b	$24,$1e,$3,$13,$1e,$e9,$25,$1f,$3,$13,$1,$d3,$10,$8f,$c1,$1d
		dc.b	$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9
		dc.b	$2c,$26,$1,$c2,$1e,$e9,$2d,$27,$1,$c2,$1,$74,$10,$8d,$1,$33
		dc.b	$0,$8d,$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$35,$2f,$1,$c2,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1
		dc.b	$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$34,$2e,$1,$c2,$1,$74
		dc.b	$10,$8e,$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$3c,$36,$1,$c2,$1,$73,$10,$8e,$c1,$1d,$8e,$40
		dc.b	$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$44,$3e
		dc.b	$2,$a3,$90,$1a,$82,$0,$1,$8,$1,$60,$9,$80,$1,$0,$5,$44
		dc.b	$9,$40,$9,$88,$1,$d3,$0,$81,$1,$8b,$2,$e,$49,$c6,$d,$5b
		dc.b	$80,$4a,$40,$8,$7f,$7f,$7f,$4c,$49,$e6,$d,$5b,$94,$4b,$40,$8
		dc.b	$7f,$7f,$7f,$4d,$ff,$e6,$1,$7,$2,$8,$0,$4,$1,$7,$2,$4
		dc.b	$0,$2,$2,$13,$8,$82,$0,$cb,$80,$4,$0,$1a,$0,$4,$f,$ae
		dc.b	$c0,$0,$7f,$8,$7f,$2,$0,$cb,$80,$5,$0,$1a,$0,$5,$f,$ae
		dc.b	$c0,$1,$7f,$9,$7f,$3,$0,$b,$2,$be,$98,$9a,$82,$0,$9,$88
		dc.b	$9,$88,$1,$0,$9,$88,$9,$80,$1,$0,$9,$0,$1,$7,$14,$16
		dc.b	$18,$2,$1,$b,$80,$2,$0,$d3,$3,$97,$c3,$5d,$9,$80,$10,$3c
		dc.b	$0,$c3,$f,$6e,$6,$1c,$19,$1c,$0,$10,$83,$3c,$fb,$5a,$1,$a
		dc.b	$7,$2,$46,$48,$30,$16,$1,$7,$2,$8,$4,$6,$1e,$e7,$a,$c
		dc.b	$e,$6,$0,$93,$4,$97,$0,$4b,$80,$2,$f,$2e,$40,$18,$0,$93
		dc.b	$8,$97,$0,$4b,$80,$3,$f,$4e,$40,$19,$0,$6,$6,$d5,$1,$8b
		dc.b	$80,$4,$0,$93,$10,$9d,$c1,$4d,$8,$9d,$0,$4e,$0,$46,$0,$93
		dc.b	$10,$9e,$c1,$4d,$8,$9e,$0,$4e,$0,$1a,$1,$8b,$80,$5,$0,$93
		dc.b	$8,$9d,$c1,$4d,$40,$9d,$0,$4e,$0,$47,$0,$93,$8,$9e,$c1,$4d
		dc.b	$40,$9e,$0,$4e,$0,$1b,$f0,$15,$0,$6,$1,$7,$10,$12,$2,$a
		dc.b	$1,$7,$10,$6,$2,$c,$1,$7,$10,$12,$6,$8,$1,$d3,$10,$81
		dc.b	$1,$93,$6,$80,$1,$53,$5,$80,$0,$73,$4,$80,$1e,$1,$a3,$2
		dc.b	$2,$80,$0,$74,$4,$80,$f0,$1,$a3,$2,$3,$80,$0,$0,$4,$60
		dc.b	$11,$94,$4,$60,$ee,$6c,$10,$80,$2,$3,$4,$5,$6,$7,$0,$0
		dc.b	$2a,$94,$ea,$b6,$0,$1,$0,$23,$0,$1b,$0,$32,$0,$5f,$40,$16
		dc.b	$0,$1,$0,$4,$b,$2,$1,$0,$2,$32,$1,$c2,$3,$4b,$3,$4b
		dc.b	$6,$97,$0,$0
	l1d1c8:	dc.b	$0,$d2,$0,$1e,$9,$c0,$0,$ba,$0,$1c,$0,$9,$0,$0,$0,$5e
		dc.b	$0,$14,$6,$66,$0,$b,$1a,$4,$a,$68,$2,$8c,$2,$9a,$1,$9
		dc.b	$0,$13,$1,$d,$6,$ed,$1,$16,$0,$f3,$1,$d,$fa,$ed,$1,$1
		dc.b	$1,$d,$1,$4,$5,$f3,$1,$8,$5,$f3,$1,$6,$3,$ed,$1,$6
		dc.b	$fd,$ed,$1,$e,$2,$ee,$1,$e,$fe,$ee,$1,$13,$0,$f1,$b,$1
		dc.b	$0,$1,$1,$8,$fb,$f0,$1,$0,$fe,$3,$1,$0,$0,$ec,$1,$0
		dc.b	$0,$a2,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$8,$0,$14,$1,$8
		dc.b	$0,$2b,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$15,$0,$f0,$1,$32
		dc.b	$0,$f0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$fa,$0,$1,$0
		dc.b	$d3,$0,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$6,$0,$1,$0
		dc.b	$2d,$0,$7,$16,$0,$40,$13,$c1,$3e,$42,$1,$0,$fb,$f3,$1,$0
		dc.b	$fa,$1,$1,$12,$2,$f3,$1,$f3,$2,$0,$0,$0,$7d,$14,$2,$46
		dc.b	$0,$97,$6,$0,$83,$14,$0,$3a,$92,$17,$2,$0,$0,$82,$4,$3a
		dc.b	$6e,$17,$1,$b4,$10,$8f,$1,$73,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$24,$1e,$2,$46
		dc.b	$1,$d3,$10,$8f,$c1,$1d,$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1
		dc.b	$0,$d3,$0,$c1,$1e,$e9,$2c,$26,$1,$4d,$1e,$e9,$2d,$27,$1,$4d
		dc.b	$1,$74,$10,$8d,$1,$33,$0,$8d,$c1,$5d,$4,$8d,$c1,$bd,$45,$c1
		dc.b	$0,$73,$0,$c1,$1e,$e9,$35,$2f,$1,$4d,$1,$73,$10,$8d,$c1,$1d
		dc.b	$8d,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$34,$2e,$1,$4d,$1,$74,$10,$8e,$1,$33,$0,$8e,$c1,$5d,$4,$8e
		dc.b	$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$3c,$36,$1,$4d,$1,$73
		dc.b	$10,$8e,$c1,$1d,$8e,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$44,$3e,$1,$f3,$98,$1a,$82,$0,$9,$88,$5,$44
		dc.b	$3,$22,$1,$6,$1,$40,$1,$0,$9,$0,$2,$ab,$2,$ca,$9,$15
		dc.b	$1,$33,$0,$81,$d,$fb,$8,$1c,$f0,$8,$d,$fb,$0,$1a,$e0,$8
		dc.b	$d,$fb,$0,$1b,$e0,$8,$0,$cb,$80,$6,$0,$93,$10,$9d,$c1,$4d
		dc.b	$8,$9d,$0,$4e,$0,$46,$f0,$15,$ff,$e6,$1,$4,$1,$2,$3,$0
		dc.b	$0,$2,$1,$7,$0,$2,$4,$c,$1,$4,$1,$6,$7,$0,$0,$6
		dc.b	$1,$7,$0,$6,$4,$8,$4,$ab,$2,$48,$94,$1a,$82,$0,$9,$0
		dc.b	$9,$88,$9,$88,$1,$66,$1,$80,$7,$60,$1,$0,$19,$1c,$c0,$7
		dc.b	$83,$3c,$7e,$55,$1,$a,$6,$c,$46,$4a,$30,$16,$19,$1c,$3f,$38
		dc.b	$83,$3c,$7e,$55,$1,$a,$6,$d,$46,$4c,$30,$16,$0,$73,$5,$82
		dc.b	$1,$7,$8,$a,$c,$2,$1,$4,$6,$3,$7,$2,$0,$a,$1,$7
		dc.b	$2,$4,$6,$4,$1e,$e4,$10,$f,$11,$e,$0,$a,$1e,$e7,$12,$14
		dc.b	$16,$4,$0,$b3,$4,$97,$0,$6b,$80,$2,$f,$3b,$40,$a,$f2,$22
		dc.b	$0,$b3,$8,$97,$0,$6b,$80,$2,$f,$5b,$40,$b,$f2,$22,$1,$33
		dc.b	$3,$97,$0,$eb,$80,$2,$c3,$5d,$9,$80,$10,$3c,$0,$c3,$f,$7b
		dc.b	$6,$8,$f2,$22,$0,$6,$1,$d3,$10,$81,$1,$93,$6,$80,$1,$53
		dc.b	$5,$80,$0,$73,$4,$80,$1e,$1,$f3,$1,$4,$80,$0,$74,$4,$80
		dc.b	$f0,$1,$f3,$1,$5,$80,$0,$0,$3,$e4,$f,$9c,$10,$80,$2,$4
		dc.b	$5,$6,$8,$9,$a,$c,$d,$0,$0,$0,$22,$10,$ec,$d7,$0,$2
		dc.b	$0,$2d,$0,$22,$0,$42,$0,$4b,$40,$17,$0,$1,$0,$1,$c,$3
		dc.b	$1,$0,$1,$a0,$0,$a6,$4,$b7,$1,$a0,$4,$e0,$0,$0,$4,$e0
		dc.b	$1,$4d
	l1d48a:	dc.b	$0,$ea,$0,$1e,$a,$80,$0,$c6,$0,$28,$0,$9,$0,$0,$0,$6d
		dc.b	$0,$14,$6,$66,$0,$b,$22,$2e,$d,$ac,$2,$a6,$2,$be,$1,$d
		dc.b	$6,$d,$1,$d,$0,$22,$1,$d,$6,$e5,$1,$11,$0,$8,$1,$11
		dc.b	$0,$e5,$1,$d,$fa,$d,$1,$d,$fa,$e5,$1,$2,$6,$ec,$1,$6
		dc.b	$6,$ef,$1,$2,$6,$fa,$1,$6,$3,$e5,$1,$6,$fd,$e5,$1,$9
		dc.b	$4,$13,$1,$9,$3,$17,$13,$c1,$3e,$42,$1,$0,$0,$e1,$1,$0
		dc.b	$0,$93,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$a,$0,$1b,$1,$a
		dc.b	$0,$33,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$11,$0,$0,$1,$2f
		dc.b	$0,$0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f6,$f6,$1,$0
		dc.b	$d1,$f6,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$a,$f6,$1,$0
		dc.b	$2f,$f6,$7,$16,$0,$40,$1,$0,$fa,$9,$1,$8,$fa,$f1,$1,$0
		dc.b	$fd,$17,$1,$6,$6,$fd,$1,$0,$fa,$f6,$1,$0,$fa,$0,$b,$1
		dc.b	$4,$8,$1,$f1,$3,$9,$0,$0,$78,$28,$a,$0,$88,$28,$0,$0
		dc.b	$7f,$0,$a,$0,$81,$0,$0,$71,$38,$0,$a,$71,$c8,$0,$0,$75
		dc.b	$2e,$f,$a,$75,$d2,$f,$4,$0,$0,$81,$1,$b4,$10,$8f,$1,$73
		dc.b	$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$24,$1e,$2,$64,$1,$d3,$10,$8f,$c1,$1d,$8f,$40
		dc.b	$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$2c,$26
		dc.b	$1,$5e,$1e,$e9,$2d,$27,$1,$5e,$1,$74,$10,$8d,$1,$33,$0,$8d
		dc.b	$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f
		dc.b	$1,$5e,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$34,$2e,$1,$5e,$1,$74,$10,$8e
		dc.b	$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$3c,$36,$1,$5e,$1,$73,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$1c,$3e,$2,$d
		dc.b	$32,$3a,$82,$0,$5,$44,$7,$0,$1,$60,$5,$44,$1,$8,$9,$40
		dc.b	$3,$22,$1,$ab,$2,$88,$1,$73,$0,$81,$9,$d5,$e,$1b,$8,$44
		dc.b	$1,$19,$d,$fb,$0,$46,$f1,$19,$d,$fb,$0,$47,$f1,$19,$f0,$15
		dc.b	$ff,$e6,$1,$4,$2,$1,$3,$0,$0,$2,$1,$4,$2,$b,$3,$a
		dc.b	$0,$4,$1,$4,$4,$1,$5,$0,$0,$6,$1,$4,$c,$b,$d,$a
		dc.b	$0,$8,$1,$8,$6,$4,$8,$0,$0,$a,$1,$8b,$2,$22,$2,$bc
		dc.b	$0,$12,$88,$8a,$7,$a,$46,$50,$30,$16,$16,$bc,$0,$12,$88,$8a
		dc.b	$7,$b,$46,$52,$30,$16,$1,$8,$6,$c,$8,$a,$0,$c,$1,$7
		dc.b	$0,$2,$6,$e,$1,$7,$a,$2,$6,$10,$1,$5,$e,$12,$4,$4
		dc.b	$0,$5,$6,$9,$6,$d,$6,$c,$6,$8,$0,$0,$1e,$e4,$16,$15
		dc.b	$17,$14,$0,$12,$10,$4,$1a,$19,$1b,$18,$0,$2,$0,$93,$5,$97
		dc.b	$0,$4b,$80,$8,$f,$e,$0,$4c,$0,$b3,$4,$97,$0,$6b,$80,$6
		dc.b	$f,$3b,$40,$4a,$f2,$22,$0,$b3,$8,$97,$0,$6b,$80,$6,$f,$5b
		dc.b	$40,$4b,$f2,$22,$1,$33,$3,$97,$0,$eb,$80,$4,$c3,$5d,$9,$80
		dc.b	$18,$3c,$0,$c3,$f,$7b,$6,$48,$f2,$22,$0,$6,$1,$d3,$10,$81
		dc.b	$1,$93,$6,$80,$1,$53,$5,$80,$0,$73,$4,$80,$1e,$1,$d,$2
		dc.b	$6,$80,$0,$74,$4,$80,$f0,$1,$d,$2,$7,$80,$0,$0,$5,$7c
		dc.b	$19,$fa,$5,$7c,$ee,$e9,$a0,$80,$17,$8d,$0,$78,$0,$4c,$10,$80
		dc.b	$2,$4,$6,$8,$a,$c,$e,$f,$10,$11,$12,$0,$0,$0,$26,$52
		dc.b	$ee,$f8,$1,$1,$0,$37,$0,$28,$0,$49,$0,$5a,$40,$18,$0,$1
		dc.b	$0,$0,$c,$3,$1,$0,$6,$d6,$0,$da,$7,$1,$1,$5e,$8,$8b
		dc.b	$0,$0
	l1d76c:	dc.b	$0,$c2,$0,$1e,$8,$c0,$0,$aa,$0,$1c,$0,$a,$0,$0,$0,$3f
		dc.b	$0,$15,$6,$66,$0,$c,$1a,$db,$7,$d0,$2,$7c,$2,$92,$1,$0
		dc.b	$5,$8,$1,$0,$0,$1a,$1,$7,$5,$f2,$1,$f,$0,$f2,$1,$7
		dc.b	$fb,$f2,$1,$0,$fb,$8,$1,$2,$3,$f2,$1,$2,$fd,$f2,$b,$1
		dc.b	$0,$6,$b,$1,$a,$6,$1,$2,$6,$f7,$1,$4,$6,$f7,$b,$1
		dc.b	$0,$4,$1,$0,$5,$0,$1,$9,$0,$f2,$1,$4,$0,$ef,$1,$4
		dc.b	$0,$c1,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$7,$0,$9,$1,$7
		dc.b	$0,$1a,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$e,$0,$fc,$1,$1f
		dc.b	$0,$fc,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f9,$fc,$1,$0
		dc.b	$e3,$fc,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$c,$2,$f3,$1,$ff
		dc.b	$2,$e,$1,$0,$fb,$f9,$1,$0,$fb,$0,$6,$4a,$63,$1b,$0,$0
		dc.b	$7f,$0,$a,$50,$a3,$1e,$a,$0,$81,$0,$4,$0,$0,$81,$4,$0
		dc.b	$0,$81,$2,$14,$10,$8f,$1,$d3,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$24,$1e,$1,$b5
		dc.b	$1e,$e9,$25,$1f,$1,$b5,$1,$d3,$10,$8f,$c1,$1d,$8f,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$2c,$26,$0,$fa
		dc.b	$1e,$e9,$2d,$27,$0,$fa,$1,$74,$10,$8d,$1,$33,$0,$8d,$c1,$5d
		dc.b	$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f,$0,$fa
		dc.b	$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1
		dc.b	$0,$73,$0,$c1,$1e,$e9,$34,$2e,$0,$fa,$1,$74,$10,$8e,$1,$33
		dc.b	$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$3c,$36,$0,$fa,$10,$9a,$82,$0,$1,$8,$9,$0,$1,$0,$9,$40
		dc.b	$1,$60,$7,$6,$7,$0,$ff,$e6,$88,$88,$4,$2,$6,$0,$0,$2
		dc.b	$1,$8,$8,$2,$6,$a,$0,$6,$1,$3,$0,$4,$5,$4,$88,$83
		dc.b	$a,$8,$9,$8,$88,$87,$4,$6,$8,$a,$88,$85,$e,$c,$4,$4
		dc.b	$0,$6,$6,$8,$6,$9,$6,$7,$6,$5,$0,$0,$1e,$e7,$c,$e
		dc.b	$1c,$c,$2,$b,$1,$54,$19,$1c,$4b,$7,$83,$3c,$3e,$52,$1,$a
		dc.b	$8,$2,$46,$3e,$30,$16,$19,$1c,$b4,$38,$83,$3c,$3e,$52,$1,$a
		dc.b	$8,$3,$46,$40,$30,$16,$0,$93,$4,$97,$0,$4b,$80,$2,$f,$2e
		dc.b	$40,$18,$0,$93,$8,$97,$0,$4b,$80,$3,$f,$4e,$40,$19,$0,$93
		dc.b	$5,$97,$0,$4b,$80,$8,$f,$e,$0,$42,$1,$b3,$0,$81,$1,$6b
		dc.b	$1,$24,$48,$86,$d,$5b,$80,$8,$40,$8,$7f,$7f,$7f,$a,$d,$5b
		dc.b	$94,$9,$40,$8,$7f,$7f,$7f,$a,$0,$6,$4,$4b,$80,$4,$3,$55
		dc.b	$0,$d3,$3,$97,$c3,$5d,$9,$80,$10,$3c,$0,$c3,$f,$6e,$6,$1a
		dc.b	$0,$93,$10,$9d,$c1,$4d,$8,$9d,$0,$4e,$30,$14,$0,$93,$8,$9d
		dc.b	$c1,$4d,$40,$9d,$0,$4e,$30,$15,$0,$93,$10,$9e,$c1,$4d,$8,$9e
		dc.b	$0,$4e,$30,$16,$0,$93,$8,$9e,$c1,$4d,$40,$9e,$0,$4e,$30,$17
		dc.b	$f0,$15,$1,$d3,$10,$81,$1,$93,$6,$80,$1,$53,$5,$80,$0,$73
		dc.b	$4,$80,$1e,$1,$77,$1,$6,$80,$0,$74,$4,$80,$f0,$1,$77,$1
		dc.b	$7,$80,$0,$0,$7,$d4,$9,$c4,$7,$d4,$f6,$3c,$a0,$80,$17,$8d
		dc.b	$0,$78,$0,$42,$10,$80,$2,$3,$4,$6,$7,$8,$a,$b,$c,$0
		dc.b	$0,$0,$33,$18,$ea,$b6,$1,$1,$0,$41,$0,$32,$0,$57,$0,$82
		dc.b	$40,$19,$0,$1,$0,$4,$c,$3,$1,$0,$7,$53,$1,$77,$9,$e3
		dc.b	$2,$ee,$b,$5a,$0,$0
	l1da22:	dc.b	$0,$e2,$0,$1e,$a,$0,$0,$be,$0,$28,$0,$9,$0,$0,$0,$71
		dc.b	$0,$14,$6,$66,$0,$b,$43,$30,$e,$10,$2,$b2,$2,$cc,$1,$7
		dc.b	$0,$17,$1,$0,$7,$0,$1,$13,$7,$ed,$1,$1f,$0,$7,$1,$1f
		dc.b	$0,$f1,$1,$f,$f9,$ed,$1,$a,$3,$ed,$1,$2,$3,$ed,$1,$9
		dc.b	$fe,$ed,$b,$1,$4,$5,$b,$1,$0,$1,$b,$1,$0,$4,$b,$1
		dc.b	$2,$12,$1,$0,$fb,$f9,$1,$7,$fc,$3,$1,$7,$0,$e8,$1,$7
		dc.b	$0,$8f,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$c,$0,$17,$1,$c
		dc.b	$0,$32,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$23,$0,$f7,$1,$46
		dc.b	$0,$f7,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f7,$0,$1,$0
		dc.b	$c9,$0,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$f,$0,$1,$0
		dc.b	$3a,$0,$7,$16,$0,$40,$13,$c1,$3e,$42,$1,$1c,$1,$f0,$1,$e4
		dc.b	$1,$0,$1,$0,$0,$15,$1,$9,$fb,$f6,$1,$0,$f9,$1,$4,$0
		dc.b	$0,$81,$0,$0,$79,$24,$4,$0,$7e,$5,$0,$17,$79,$1c,$4,$46
		dc.b	$69,$0,$4,$22,$f8,$87,$a,$0,$84,$16,$0,$10,$85,$19,$6,$38
		dc.b	$8f,$0,$2,$14,$10,$8f,$1,$d3,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$24,$1e,$2,$bc
		dc.b	$1e,$e9,$25,$1f,$2,$bc,$1,$d3,$10,$8f,$c1,$1d,$8f,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$2c,$26,$1,$90
		dc.b	$1e,$e9,$2d,$27,$1,$90,$1,$74,$10,$8d,$1,$33,$0,$8d,$c1,$5d
		dc.b	$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f,$1,$90
		dc.b	$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1
		dc.b	$0,$73,$0,$c1,$1e,$e9,$34,$2e,$1,$90,$1,$74,$10,$8e,$1,$33
		dc.b	$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$3c,$36,$1,$90,$1,$73,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d,$4,$c1
		dc.b	$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$44,$3e,$2,$58,$70,$1a
		dc.b	$82,$0,$1,$6,$5,$44,$1,$60,$9,$40,$1,$0,$7,$6,$5,$44
		dc.b	$c2,$d,$40,$83,$4,$4b,$2,$e6,$9,$d5,$1,$33,$0,$81,$4,$1c
		dc.b	$0,$4,$e,$1b,$6,$4a,$11,$19,$e,$e,$6,$4c,$e,$e,$6,$4d
		dc.b	$2,$6b,$80,$e,$0,$93,$10,$9d,$c1,$4d,$8,$9d,$0,$4e,$0,$1c
		dc.b	$0,$93,$8,$9d,$c1,$4d,$40,$9d,$0,$4e,$0,$1d,$0,$b3,$5,$97
		dc.b	$ff,$e6,$0,$1c,$0,$7c,$f,$e,$6,$1a,$f0,$15,$ff,$e6,$1,$4
		dc.b	$5,$a,$b,$4,$0,$2,$1e,$e7,$c,$e,$10,$2,$1,$3,$0,$1
		dc.b	$2,$4,$1,$3,$4,$5,$2,$6,$1,$8,$6,$2,$4,$0,$0,$8
		dc.b	$1,$7,$4,$6,$8,$a,$2,$b,$1,$86,$19,$1c,$0,$0,$83,$3c
		dc.b	$5,$54,$88,$8a,$6,$a,$46,$46,$30,$16,$19,$1c,$0,$40,$83,$3c
		dc.b	$5,$54,$88,$8a,$6,$b,$46,$48,$30,$16,$1,$7,$4,$8,$a,$c
		dc.b	$1,$4,$1,$a,$b,$0,$0,$e,$1,$7,$0,$6,$a,$10,$1,$7
		dc.b	$6,$8,$a,$12,$0,$b3,$4,$97,$0,$6b,$80,$8,$f,$3b,$40,$16
		dc.b	$f2,$22,$0,$b3,$8,$97,$0,$6b,$80,$9,$f,$5b,$40,$17,$f2,$22
		dc.b	$1,$33,$3,$97,$0,$eb,$80,$6,$c3,$5d,$9,$80,$10,$3c,$0,$c3
		dc.b	$f,$7b,$6,$18,$f2,$22,$0,$6,$1,$d3,$10,$81,$1,$93,$6,$80
		dc.b	$1,$53,$5,$80,$0,$73,$4,$80,$1e,$1,$58,$2,$6,$80,$0,$74
		dc.b	$4,$80,$f0,$1,$58,$2,$7,$80,$0,$0,$b,$b8,$13,$88,$b,$b8
		dc.b	$ec,$78,$a0,$80,$17,$8d,$0,$78,$0,$1a,$10,$80,$2,$4,$6,$8
		dc.b	$9,$a,$b,$c,$d,$e,$10,$11,$12,$13,$0,$0,$22,$10,$f3,$3a
		dc.b	$1,$2,$0,$4b,$0,$3c,$0,$61,$0,$64,$40,$1a,$0,$1,$0,$2
		dc.b	$c,$3,$1,$0,$2,$ee,$0,$fa,$4,$e2,$1,$f4,$5,$dc,$0,$0
		dc.b	$4,$e2,$1,$f4
	l1dd16:	dc.b	$0,$ca,$0,$1e,$9,$0,$0,$ae,$0,$20,$0,$a,$0,$0,$0,$6b
		dc.b	$0,$15,$6,$66,$0,$c,$2a,$f8,$a,$be,$2,$b2,$2,$c6,$1,$4
		dc.b	$fc,$f0,$1,$a,$4,$5,$1,$15,$fc,$5,$1,$0,$fc,$10,$1,$4
		dc.b	$2,$7,$b,$1,$2,$6,$1,$2,$fe,$f0,$b,$1,$2,$4,$1,$0
		dc.b	$fc,$fb,$1,$d,$fc,$5,$1,$8,$fc,$8,$1,$11,$fe,$5,$1,$8
		dc.b	$fd,$fd,$1,$0,$fd,$a,$13,$c1,$3e,$42,$1,$0,$fc,$ee,$1,$0
		dc.b	$fc,$c4,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$a,$fe,$d,$1,$a
		dc.b	$fe,$22,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$10,$0,$0,$1,$25
		dc.b	$0,$0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f8,$0,$1,$0
		dc.b	$d8,$0,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$8,$0,$1,$0
		dc.b	$25,$0,$7,$16,$0,$40,$1,$0,$fb,$0,$1,$0,$6,$4,$2,$0
		dc.b	$63,$4f,$c,$1b,$73,$d3,$0,$46,$58,$c8,$4,$31,$3d,$63,$0,$0
		dc.b	$81,$0,$0,$0,$0,$81,$c,$0,$75,$cf,$1,$b4,$10,$8f,$1,$73
		dc.b	$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$24,$1e,$1,$e1,$1,$d3,$10,$8f,$c1,$1d,$8f,$40
		dc.b	$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$2c,$26
		dc.b	$1,$13,$1e,$e9,$2d,$27,$1,$13,$1,$74,$10,$8d,$1,$33,$0,$8d
		dc.b	$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f
		dc.b	$1,$13,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$34,$2e,$1,$13,$1,$74,$10,$8e
		dc.b	$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$3c,$36,$1,$13,$1,$73,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$1c,$3e,$1,$9c
		dc.b	$90,$1a,$82,$0,$1,$8,$1,$60,$9,$80,$1,$0,$5,$44,$9,$40
		dc.b	$9,$88,$c2,$d,$40,$83,$1,$ab,$1,$fe,$1,$73,$0,$81,$8,$95
		dc.b	$e,$1b,$8,$1a,$11,$19,$d,$fb,$0,$18,$1,$19,$d,$fb,$0,$19
		dc.b	$1,$19,$f0,$15,$ff,$e6,$1,$4,$6,$46,$3,$2,$0,$2,$1,$8
		dc.b	$0,$46,$2,$c,$0,$4,$1e,$e4,$c,$1,$d,$0,$0,$c,$1,$7
		dc.b	$0,$2,$4,$6,$1,$7,$2,$4,$6,$8,$1,$5,$c,$a,$4,$0
		dc.b	$0,$4,$6,$6,$6,$5,$6,$1,$0,$0,$98,$9a,$82,$0,$9,$88
		dc.b	$9,$88,$1,$0,$9,$88,$9,$80,$1,$0,$9,$0,$1,$3,$c,$d
		dc.b	$46,$e,$1,$b,$1,$c,$19,$1c,$8d,$16,$83,$3c,$62,$4a,$1,$a
		dc.b	$7,$8,$46,$16,$30,$16,$fe,$4,$a,$9,$b,$8,$0,$2,$0,$d3
		dc.b	$5,$97,$0,$8b,$80,$a,$0,$1c,$0,$7c,$f,$e,$6,$10,$0,$b3
		dc.b	$4,$97,$0,$6c,$80,$a,$f,$3b,$40,$e,$f2,$22,$0,$b3,$8,$97
		dc.b	$0,$6c,$80,$a,$f,$5b,$40,$f,$f2,$22,$1,$13,$3,$97,$0,$cc
		dc.b	$80,$a,$c3,$5d,$9,$80,$10,$3c,$0,$c3,$f,$6e,$6,$46,$0,$6
		dc.b	$2,$15,$3,$b,$80,$a,$0,$93,$10,$9d,$c1,$4d,$8,$9d,$0,$4e
		dc.b	$0,$12,$0,$93,$8,$9d,$c1,$4d,$40,$9d,$0,$4e,$0,$14,$0,$93
		dc.b	$10,$9e,$c1,$4d,$8,$9e,$0,$4e,$0,$13,$0,$93,$8,$9e,$c1,$4d
		dc.b	$40,$9e,$0,$4e,$0,$15,$f0,$15,$1,$d3,$10,$81,$1,$93,$6,$80
		dc.b	$1,$53,$5,$80,$0,$73,$4,$80,$1e,$1,$9c,$1,$4,$80,$0,$74
		dc.b	$4,$80,$f0,$1,$9c,$1,$5,$80,$0,$0,$2,$a8,$10,$1d,$2,$a8
		dc.b	$ef,$e3,$a0,$80,$17,$8d,$0,$78,$0,$10,$10,$80,$2,$c,$e,$6
		dc.b	$7,$8,$9,$a,$0,$0,$1d,$ce,$f3,$3a,$1,$1,$0,$57,$0,$46
		dc.b	$0,$6d,$0,$91,$40,$1b,$0,$1,$0,$4,$c,$3,$1,$0,$5,$5f
		dc.b	$0,$0,$2,$af,$0,$0,$8,$e,$fd,$da
	l1e000:	dc.b	$0,$f6,$0,$1e,$b,$80,$0,$d6,$0,$24,$0,$9,$0,$0,$0,$6d
		dc.b	$0,$17,$6,$66,$0,$b,$46,$50,$12,$c0,$3,$2a,$3,$44,$1,$c
		dc.b	$0,$1d,$1,$2e,$ff,$0,$1,$31,$fd,$f1,$1,$22,$6,$f1,$1,$0
		dc.b	$a,$f1,$1,$0,$a,$9,$1,$c,$f7,$f1,$1,$3,$5,$f1,$1,$e
		dc.b	$3,$f1,$1,$3,$fb,$f1,$1,$e,$fd,$f1,$1,$1e,$1,$f1,$1,$22
		dc.b	$0,$f1,$1,$1e,$ff,$f1,$1,$13,$0,$f1,$1,$8,$0,$ec,$1,$8
		dc.b	$0,$93,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$c,$0,$23,$1,$c
		dc.b	$0,$3e,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$23,$0,$ef,$1,$46
		dc.b	$0,$e5,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f4,$0,$1,$0
		dc.b	$c6,$0,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$f,$0,$1,$0
		dc.b	$3a,$0,$7,$16,$0,$40,$13,$c1,$3e,$42,$1,$1e,$fc,$f8,$1,$0
		dc.b	$0,$1c,$1,$0,$0,$f1,$1,$0,$fc,$7,$1,$d,$8,$f7,$1,$0
		dc.b	$fc,$1,$1,$13,$ff,$10,$1,$0,$f9,$fa,$1,$27,$fc,$fd,$1,$1f
		dc.b	$fc,$0,$1,$19,$5,$fc,$0,$0,$71,$38,$0,$21,$76,$20,$6,$26
		dc.b	$74,$22,$2,$43,$6b,$0,$8,$e,$7e,$0,$0,$0,$84,$19,$c,$14
		dc.b	$86,$19,$e,$0,$0,$82,$2,$14,$10,$8f,$1,$d3,$0,$8f,$c1,$7d
		dc.b	$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9
		dc.b	$24,$1e,$2,$bc,$1e,$e9,$25,$1f,$2,$bc,$1,$d3,$10,$8f,$c1,$1d
		dc.b	$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9
		dc.b	$2c,$26,$1,$90,$1e,$e9,$2d,$27,$1,$90,$1,$74,$10,$8d,$1,$33
		dc.b	$0,$8d,$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$35,$2f,$1,$90,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1
		dc.b	$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$34,$2e,$1,$90,$1,$74
		dc.b	$10,$8e,$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$3c,$36,$1,$90,$1,$73,$10,$8e,$c1,$1d,$8e,$40
		dc.b	$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$44,$3e
		dc.b	$2,$58,$1,$d3,$0,$81,$1,$93,$6,$80,$1,$53,$5,$80,$0,$73
		dc.b	$4,$80,$1e,$1,$58,$2,$4,$80,$0,$74,$4,$80,$f0,$1,$58,$2
		dc.b	$5,$80,$ff,$e6,$66,$63,$0,$a,$1,$2,$66,$67,$0,$2,$6,$4
		dc.b	$88,$87,$0,$6,$a,$6,$66,$67,$2,$4,$6,$8,$66,$67,$6,$8
		dc.b	$a,$a,$88,$84,$c,$1,$d,$0,$0,$c,$66,$68,$4,$0,$2,$c
		dc.b	$0,$e,$66,$65,$10,$10,$4,$4,$0,$6,$6,$8,$6,$7,$6,$5
		dc.b	$6,$d,$6,$c,$0,$0,$0,$b,$4,$92,$1e,$e8,$12,$10,$14,$e
		dc.b	$0,$10,$0,$b,$2,$48,$2,$13,$6,$82,$0,$cb,$80,$4,$0,$1a
		dc.b	$0,$4,$f,$ae,$c0,$0,$7f,$6,$7f,$2,$0,$cb,$80,$5,$0,$1a
		dc.b	$0,$5,$f,$ae,$c0,$1,$7f,$7,$7f,$3,$0,$ab,$80,$10,$1e,$e7
		dc.b	$16,$18,$1a,$0,$f,$ce,$d,$1c,$19,$1c,$f0,$e,$83,$3c,$7d,$57
		dc.b	$0,$a,$7,$6,$46,$5a,$30,$16,$0,$d3,$5,$97,$0,$8b,$80,$c
		dc.b	$0,$1c,$72,$7c,$f,$e,$6,$4c,$0,$93,$4,$97,$0,$4b,$80,$a
		dc.b	$f,$2e,$40,$4e,$0,$93,$8,$97,$0,$4b,$80,$b,$f,$4e,$40,$4f
		dc.b	$1,$93,$3,$97,$c3,$5d,$9,$80,$18,$3c,$0,$c3,$0,$4b,$80,$e
		dc.b	$f,$6e,$6,$46,$0,$4b,$80,$f,$f,$6e,$6,$47,$0,$b,$2,$48
		dc.b	$0,$6,$0,$f3,$10,$9b,$c1,$4d,$8,$9b,$c2,$fd,$7,$c1,$f,$9b
		dc.b	$0,$48,$28,$80,$0,$f3,$8,$9b,$c1,$4d,$40,$9b,$c2,$fd,$7,$c1
		dc.b	$f,$9b,$2c,$4a,$28,$80,$a,$15,$1,$b3,$0,$81,$14,$1c,$8e,$3
		dc.b	$44,$5a,$0,$c,$e,$1b,$6,$54,$0,$88,$e,$1b,$6,$52,$10,$88
		dc.b	$e,$1b,$6,$53,$10,$88,$1,$8b,$80,$e,$0,$93,$10,$9d,$c1,$4d
		dc.b	$8,$9d,$0,$4e,$0,$56,$0,$93,$10,$9e,$c1,$4d,$8,$9e,$0,$4e
		dc.b	$0,$58,$1,$8b,$80,$f,$0,$93,$8,$9d,$c1,$4d,$40,$9d,$0,$4e
		dc.b	$0,$57,$0,$93,$8,$9e,$c1,$4d,$40,$9e,$0,$4e,$0,$59,$f0,$15
		dc.b	$0,$0,$5,$78,$33,$90,$5,$79,$33,$90,$a0,$80,$17,$8d,$0,$78
		dc.b	$0,$4c,$10,$80,$2,$10,$c,$4,$5,$6,$7,$8,$9,$a,$b,$e
		dc.b	$f,$0,$0,$0,$2a,$94,$f1,$19,$1,$2,$0,$64,$0,$50,$0,$7c
		dc.b	$0,$96,$40,$1c,$0,$1,$0,$4,$c,$3,$0,$2,$6,$d6,$0,$c8
		dc.b	$3,$e8,$1,$f4,$8,$ca,$0,$0,$4,$b0,$0,$0
	l1e36c:	dc.b	$0,$d6,$0,$1e,$9,$c0,$0,$ba,$0,$20,$0,$b,$0,$0,$0,$4b
		dc.b	$0,$16,$6,$66,$0,$d,$30,$d4,$9,$c4,$2,$dc,$2,$f2,$1,$0
		dc.b	$fe,$18,$1,$7,$4,$4,$1,$7,$4,$ef,$1,$e,$fe,$9,$1,$e
		dc.b	$fe,$f7,$1,$4,$fe,$ef,$1,$3,$3,$ef,$1,$2,$0,$ef,$b,$1
		dc.b	$0,$2,$b,$1,$4,$5,$1,$3,$4,$f7,$b,$1,$4,$3,$b,$1
		dc.b	$8,$0,$1,$0,$fe,$f7,$1,$c,$0,$f7,$1,$0,$1,$ec,$1,$0
		dc.b	$1,$b5,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$7,$fe,$11,$1,$7
		dc.b	$fe,$22,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$11,$fe,$0,$1,$27
		dc.b	$fe,$0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$fc,$0,$1,$0
		dc.b	$df,$0,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$7,$0,$1,$0
		dc.b	$22,$0,$7,$16,$0,$40,$13,$c1,$3e,$42,$1,$f4,$0,$5,$1,$8
		dc.b	$fe,$f9,$1,$0,$fe,$e,$1,$0,$fc,$0,$4,$0,$0,$81,$4,$0
		dc.b	$7f,$0,$8,$59,$59,$0,$0,$0,$76,$2c,$2,$3a,$60,$3a,$4,$4a
		dc.b	$e8,$9d,$6,$0,$81,$0,$1,$b4,$10,$8f,$1,$73,$0,$8f,$c1,$7d
		dc.b	$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$24,$1e,$1,$b5,$1,$d3,$10,$8f,$c1,$1d,$8f,$40,$c1,$5d,$4,$c1
		dc.b	$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$2c,$26,$0,$fa,$1e,$e9
		dc.b	$2d,$27,$0,$fa,$1,$74,$10,$8d,$1,$33,$0,$8d,$c1,$5d,$4,$8d
		dc.b	$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f,$0,$fa,$1,$73
		dc.b	$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$34,$2e,$0,$fa,$1,$74,$10,$8e,$1,$33,$0,$8e
		dc.b	$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$3c,$36
		dc.b	$0,$fa,$1,$73,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$44,$3e,$1,$77,$c2,$d,$40,$83
		dc.b	$3,$eb,$1,$ce,$9,$95,$1,$33,$0,$81,$e,$1b,$8,$4a,$21,$19
		dc.b	$d,$fb,$0,$48,$11,$19,$d,$fb,$0,$49,$11,$19,$2,$b,$80,$e
		dc.b	$0,$53,$5,$97,$f,$e,$0,$1a,$0,$93,$10,$9d,$c1,$4d,$8,$9d
		dc.b	$0,$4e,$0,$18,$0,$93,$8,$9d,$c1,$4d,$40,$9d,$0,$4e,$0,$19
		dc.b	$f0,$15,$ff,$e6,$70,$1a,$82,$0,$1,$6,$5,$44,$1,$60,$9,$40
		dc.b	$1,$0,$7,$6,$5,$44,$1,$5,$10,$e,$4,$0,$0,$6,$6,$8
		dc.b	$6,$a,$6,$b,$6,$9,$6,$7,$0,$0,$1,$4,$5,$a,$b,$4
		dc.b	$0,$2,$1e,$e4,$d,$e,$f,$c,$0,$2,$1,$4,$3,$4,$5,$2
		dc.b	$0,$4,$1,$8,$6,$4,$8,$2,$0,$6,$2,$b,$0,$f4,$19,$1c
		dc.b	$0,$0,$83,$3c,$0,$50,$88,$8a,$8,$6,$46,$1c,$30,$16,$19,$1c
		dc.b	$0,$40,$83,$3c,$0,$50,$88,$8a,$8,$7,$46,$46,$30,$16,$1,$b3
		dc.b	$9,$82,$1,$3,$0,$10,$11,$8,$88,$84,$10,$3,$11,$2,$0,$8
		dc.b	$1,$7,$2,$6,$10,$a,$88,$87,$0,$6,$10,$a,$3,$14,$9,$82
		dc.b	$1,$3,$0,$2,$3,$8,$1,$7,$0,$2,$6,$a,$2,$13,$7,$82
		dc.b	$0,$cb,$80,$a,$0,$1a,$0,$a,$f,$ae,$c0,$0,$7f,$6,$7f,$2
		dc.b	$0,$cb,$80,$b,$0,$1a,$0,$b,$f,$ae,$c0,$1,$7f,$7,$7f,$3
		dc.b	$88,$87,$4,$8,$a,$c,$2,$2b,$80,$4,$0,$53,$4,$97,$f,$2e
		dc.b	$40,$14,$0,$53,$8,$97,$f,$4e,$40,$15,$0,$f3,$3,$97,$c3,$5d
		dc.b	$9,$80,$10,$3c,$0,$c3,$f,$7b,$6,$16,$12,$22,$0,$6,$1,$d3
		dc.b	$10,$81,$1,$93,$6,$80,$1,$53,$5,$80,$0,$73,$4,$80,$1e,$1
		dc.b	$77,$1,$6,$80,$0,$74,$4,$80,$f0,$1,$77,$1,$7,$80,$0,$0
		dc.b	$7,$54,$0,$0,$7,$54,$11,$17,$7,$54,$f6,$3c,$a0,$80,$17,$8d
		dc.b	$0,$78,$0,$1a,$10,$80,$2,$4,$6,$7,$8,$a,$b,$c,$d,$e
		dc.b	$0,$0,$2e,$d6,$ea,$b6,$1,$2,$0,$78,$0,$5a,$0,$8f,$0,$eb
		dc.b	$40,$1d,$0,$2,$0,$2,$c,$3,$0,$3,$9,$c4,$3,$6b,$11,$17
		dc.b	$4,$e2,$18,$6a,$fd,$a8,$11,$17,$4,$e2
	l1e686:	dc.b	$0,$e2,$0,$1e,$a,$40,$0,$c2,$0,$24,$0,$9,$0,$0,$0,$75
		dc.b	$0,$14,$6,$66,$0,$b,$6d,$60,$13,$88,$2,$d6,$2,$ee,$1,$0
		dc.b	$e,$0,$1,$14,$5,$39,$1,$21,$a,$15,$1,$21,$0,$dd,$1,$35
		dc.b	$2,$0,$1,$0,$7,$dd,$1,$21,$f6,$15,$1,$0,$f9,$dd,$1,$0
		dc.b	$3,$dd,$1,$d,$0,$dd,$1,$0,$fd,$dd,$1,$0,$5,$39,$1,$1b
		dc.b	$7,$0,$1,$0,$f9,$1f,$1,$0,$f7,$f9,$1,$0,$0,$d9,$1,$0
		dc.b	$0,$8b,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$f,$0,$3a,$1,$f
		dc.b	$0,$5d,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$36,$2,$0,$1,$59
		dc.b	$2,$0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f6,$f9,$1,$0
		dc.b	$c8,$f9,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$f,$fd,$1,$0
		dc.b	$3a,$fd,$7,$16,$0,$40,$13,$c1,$3e,$42,$b,$1,$0,$a,$1,$3
		dc.b	$7,$e0,$b,$1,$5,$9,$1,$13,$f7,$b,$1,$0,$f9,$e9,$1,$0
		dc.b	$f9,$0,$2,$0,$7d,$13,$0,$1a,$79,$e9,$2,$53,$54,$2c,$2,$0
		dc.b	$8d,$35,$2,$63,$ce,$3d,$6,$33,$8e,$eb,$c,$0,$82,$f8,$6,$0
		dc.b	$0,$81,$1,$b4,$10,$8f,$1,$73,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$24,$1e,$2,$bc
		dc.b	$1,$d3,$10,$8f,$c1,$1d,$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1
		dc.b	$0,$d3,$0,$c1,$1e,$e9,$2c,$26,$1,$90,$1e,$e9,$2d,$27,$1,$90
		dc.b	$1,$74,$10,$8d,$1,$33,$0,$8d,$c1,$5d,$4,$8d,$c1,$bd,$45,$c1
		dc.b	$0,$73,$0,$c1,$1e,$e9,$35,$2f,$1,$90,$1,$73,$10,$8d,$c1,$1d
		dc.b	$8d,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$34,$2e,$1,$90,$1,$74,$10,$8e,$1,$33,$0,$8e,$c1,$5d,$4,$8e
		dc.b	$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$3c,$36,$1,$90,$1,$73
		dc.b	$10,$8e,$c1,$1d,$8e,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$44,$3e,$2,$58,$c2,$d,$40,$83,$1,$ab,$2,$e6
		dc.b	$1,$73,$0,$81,$a,$15,$d,$fb,$8,$4e,$f5,$55,$d,$fb,$0,$4c
		dc.b	$f5,$55,$d,$fb,$0,$4d,$f5,$55,$f0,$15,$ff,$e6,$88,$85,$c,$2
		dc.b	$4,$2,$0,$4,$6,$0,$6,$5,$6,$3,$0,$0,$88,$85,$c,$4
		dc.b	$4,$4,$0,$0,$6,$a,$6,$6,$6,$8,$0,$0,$88,$85,$c,$5
		dc.b	$4,$5,$0,$1,$6,$b,$6,$7,$6,$9,$0,$0,$2,$b,$3,$c
		dc.b	$19,$1c,$4c,$71,$83,$3c,$3e,$5a,$80,$a,$8,$4,$46,$48,$30,$16
		dc.b	$19,$1c,$b3,$4e,$83,$3c,$3e,$5a,$80,$a,$8,$5,$46,$4a,$30,$16
		dc.b	$0,$7,$2,$4,$8,$6,$0,$4,$3,$c,$d,$2,$0,$8,$88,$87
		dc.b	$2,$8,$c,$a,$0,$8,$e,$8,$c,$6,$0,$c,$88,$83,$c,$d
		dc.b	$e,$e,$0,$5,$c,$10,$4,$6,$0,$a,$6,$7,$6,$f,$6,$e
		dc.b	$0,$0,$1e,$e4,$13,$12,$14,$10,$0,$10,$0,$d3,$5,$97,$0,$8b
		dc.b	$80,$8,$0,$1c,$0,$78,$f,$e,$6,$1a,$0,$b3,$4,$97,$0,$6b
		dc.b	$80,$4,$f,$3b,$40,$18,$f2,$22,$0,$b3,$8,$97,$0,$6b,$80,$5
		dc.b	$f,$5b,$40,$19,$f2,$22,$1,$33,$3,$97,$0,$ec,$80,$e,$c3,$5d
		dc.b	$9,$80,$10,$3c,$0,$c3,$f,$7b,$6,$46,$f2,$22,$0,$6,$0,$f3
		dc.b	$10,$9b,$c1,$4d,$8,$9b,$c2,$fd,$7,$c1,$f,$9b,$0,$16,$28,$80
		dc.b	$3,$95,$0,$cb,$80,$e,$0,$93,$10,$9d,$c1,$4d,$8,$9d,$0,$4e
		dc.b	$0,$1c,$f0,$15,$1,$d3,$10,$81,$1,$93,$6,$80,$1,$53,$5,$80
		dc.b	$0,$73,$4,$80,$1e,$1,$58,$2,$8,$80,$0,$74,$4,$80,$f0,$1
		dc.b	$58,$2,$9,$80,$0,$0,$7,$d0,$26,$48,$7,$d0,$d9,$b8,$7,$d4
		dc.b	$29,$68,$7,$d4,$ec,$78,$a0,$80,$17,$8d,$0,$78,$0,$1a,$10,$80
		dc.b	$2,$4,$5,$6,$7,$8,$a,$b,$c,$d,$e,$10,$0,$0,$2e,$d6
		dc.b	$f1,$19,$1,$2,$0,$96,$0,$78,$0,$bb,$0,$b4,$40,$1e,$0,$2
		dc.b	$0,$1,$c,$4,$1,$0,$b,$b8,$2,$ee,$8,$ca,$1,$f4,$10,$36
		dc.b	$1,$5e,$8,$ca,$0,$fa
	l1e99c:	dc.b	$0,$fe,$0,$1e,$c,$0,$0,$de,$0,$24,$0,$a,$0,$0,$0,$75
		dc.b	$0,$15,$6,$66,$0,$c,$20,$d0,$f,$a0,$2,$6e,$2,$7e,$1,$0
		dc.b	$7,$f,$1,$0,$7,$e9,$1,$5,$0,$1f,$1,$13,$0,$f,$1,$13
		dc.b	$0,$e9,$1,$5,$f9,$1f,$1,$13,$f9,$f,$1,$13,$f9,$e9,$1,$3
		dc.b	$6,$0,$1,$f,$1,$0,$1,$3,$6,$1,$1,$f,$1,$1,$1,$3
		dc.b	$6,$f9,$1,$f,$1,$f9,$1,$9,$3,$f9,$1,$9,$3,$f5,$1,$fd
		dc.b	$6,$f5,$1,$f1,$1,$f5,$1,$f7,$3,$0,$1,$f7,$3,$3,$1,$5
		dc.b	$2,$e9,$1,$5,$fe,$e9,$1,$0,$0,$e4,$1,$0,$0,$8b,$7,$15
		dc.b	$0,$2e,$13,$c1,$2c,$30,$1,$7,$fd,$1f,$1,$7,$fd,$3a,$7,$16
		dc.b	$0,$36,$13,$c1,$34,$38,$1,$17,$fd,$0,$1,$3a,$fd,$0,$7,$16
		dc.b	$0,$3e,$13,$c1,$3c,$40,$1,$0,$f5,$0,$1,$0,$ca,$0,$7,$15
		dc.b	$0,$46,$13,$c1,$44,$48,$1,$0,$9,$0,$1,$0,$34,$0,$7,$16
		dc.b	$0,$4e,$13,$c1,$4c,$50,$1,$13,$fd,$ed,$1,$ed,$fd,$5,$1,$f
		dc.b	$f9,$f1,$1,$0,$f9,$13,$1,$0,$f9,$0,$1,$0,$6,$f1,$0,$2f
		dc.b	$75,$0,$0,$0,$71,$38,$0,$2c,$6f,$28,$4,$0,$0,$7e,$4,$5e
		dc.b	$0,$54,$8,$7f,$0,$0,$2,$0,$0,$81,$c,$0,$81,$0,$1,$b4
		dc.b	$10,$8f,$1,$73,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$32,$2c,$2,$bc,$1,$d3,$10,$8f
		dc.b	$c1,$1d,$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1
		dc.b	$1e,$e9,$3a,$34,$1,$90,$1e,$e9,$3b,$35,$1,$90,$1,$74,$10,$8d
		dc.b	$1,$33,$0,$8d,$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$43,$3d,$1,$90,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$42,$3c,$1,$90
		dc.b	$1,$74,$10,$8e,$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1
		dc.b	$0,$73,$0,$c1,$1e,$e9,$4a,$44,$1,$90,$1,$73,$10,$8e,$c1,$1d
		dc.b	$8e,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$52,$4c,$2,$58,$1,$6b,$2,$e6,$1,$33,$0,$81,$b,$95,$e,$1b
		dc.b	$8,$5a,$13,$33,$d,$ee,$0,$58,$d,$ee,$0,$59,$f0,$15,$ff,$e6
		dc.b	$44,$44,$0,$8,$2,$6,$0,$2,$88,$84,$14,$12,$16,$10,$0,$2
		dc.b	$88,$83,$18,$1c,$1e,$2,$88,$83,$1a,$1c,$1e,$2,$44,$44,$0,$9
		dc.b	$2,$7,$0,$3,$0,$3,$20,$22,$1d,$3,$0,$3,$24,$26,$11,$3
		dc.b	$0,$3,$24,$26,$13,$3,$44,$43,$0,$4,$5,$4,$44,$47,$0,$4
		dc.b	$6,$6,$44,$44,$a,$5,$b,$4,$0,$8,$44,$48,$6,$a,$c,$4
		dc.b	$0,$a,$44,$48,$c,$8,$e,$6,$0,$c,$0,$4b,$80,$2,$f,$ee
		dc.b	$0,$5e,$1,$b,$1,$86,$88,$8a,$8,$c,$42,$54,$30,$16,$88,$8a
		dc.b	$8,$d,$6a,$56,$30,$16,$44,$45,$c,$e,$4,$2,$0,$8,$6,$e
		dc.b	$6,$f,$6,$9,$0,$0,$1e,$e4,$29,$2a,$2b,$28,$0,$e,$44,$45
		dc.b	$e,$10,$4,$a,$0,$c,$6,$e,$6,$f,$6,$d,$6,$b,$0,$0
		dc.b	$0,$0,$b,$bc,$0,$0,$b,$bc,$13,$88,$b,$bc,$f4,$48,$10,$80
		dc.b	$2,$3,$4,$6,$7,$8,$a,$b,$c,$d,$e,$10,$0,$0,$13,$29
		dc.b	$f7,$7c,$0,$3,$0,$c8,$0,$a0,$0,$f1,$0,$b4,$40,$1f,$0,$3
		dc.b	$0,$2,$5,$4,$1,$0,$e,$d8,$1,$f4,$c,$80,$3,$e8,$f,$a0
		dc.b	$0,$0,$b,$b8,$3,$20,$f8,$30,$3,$e8
	l1ec46:	dc.b	$1,$3e,$0,$1e,$e,$40,$1,$2,$0,$40,$0,$a,$0,$0,$0,$7d
		dc.b	$0,$15,$6,$66,$0,$c,$75,$30,$9,$21,$4,$18,$4,$46,$1,$0
		dc.b	$0,$3a,$1,$8,$b,$27,$1,$13,$1,$27,$1,$8,$b,$e3,$1,$13
		dc.b	$1,$e3,$1,$23,$1,$4,$1,$23,$1,$e3,$1,$24,$10,$fa,$1,$24
		dc.b	$10,$e3,$1,$13,$ff,$27,$1,$24,$ff,$4,$1,$24,$ff,$e3,$1,$13
		dc.b	$ff,$e3,$1,$8,$1,$3a,$1,$13,$1,$35,$1,$5,$6,$3a,$1,$6
		dc.b	$8,$30,$1,$0,$e,$27,$1,$0,$e,$e3,$1,$15,$3,$0,$1,$1d
		dc.b	$1,$9,$1,$15,$ff,$0,$1,$1d,$ff,$9,$1,$10,$0,$f7,$1,$0
		dc.b	$0,$1d,$1,$5,$b,$29,$1,$5,$8,$2a,$1,$0,$8,$e3,$1,$0
		dc.b	$8,$e1,$1,$0,$4,$db,$1,$0,$4,$83,$7,$15,$0,$3c,$13,$c1
		dc.b	$3a,$3e,$1,$24,$0,$9,$1,$24,$0,$4e,$7,$16,$0,$44,$13,$c1
		dc.b	$42,$46,$1,$32,$0,$4,$1,$61,$0,$4,$7,$16,$0,$4c,$13,$c1
		dc.b	$4a,$4e,$1,$20,$f8,$0,$1,$20,$b7,$0,$7,$15,$0,$54,$13,$c1
		dc.b	$52,$56,$1,$20,$8,$4,$1,$20,$49,$4,$7,$16,$0,$5c,$13,$c1
		dc.b	$5a,$5e,$1,$0,$fd,$0,$1,$8,$b,$1d,$1,$0,$d,$f7,$1,$0
		dc.b	$d,$4,$1,$24,$2,$e4,$1,$dc,$2,$1,$1,$0,$d,$e3,$1,$0
		dc.b	$d,$27,$2,$0,$6d,$40,$0,$47,$48,$4b,$a,$82,$8,$0,$0,$16
		dc.b	$88,$20,$0,$0,$82,$a,$4,$0,$7f,$0,$6,$0,$7f,$0,$2,$58
		dc.b	$5a,$0,$4,$72,$0,$36,$12,$0,$81,$0,$14,$7f,$0,$0,$a,$6f
		dc.b	$20,$33,$6,$0,$0,$81,$2,$1c,$7b,$0,$e,$0,$7e,$0,$1,$b4
		dc.b	$10,$8f,$1,$73,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$40,$3a,$3,$e8,$1,$d3,$10,$8f
		dc.b	$c1,$1d,$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1
		dc.b	$1e,$e9,$48,$42,$1,$f4,$1e,$e9,$49,$43,$1,$f4,$1,$74,$10,$8d
		dc.b	$1,$33,$0,$8d,$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$51,$4b,$1,$f4,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$50,$4a,$1,$f4
		dc.b	$1,$d4,$10,$8e,$1,$93,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1
		dc.b	$0,$d3,$0,$c1,$1e,$e9,$58,$52,$1,$f4,$1e,$e9,$59,$53,$1,$f4
		dc.b	$1,$d3,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1
		dc.b	$0,$d3,$0,$c1,$1e,$e9,$60,$5a,$2,$ee,$1e,$e9,$61,$5b,$2,$ee
		dc.b	$ff,$e6,$88,$88,$6,$4,$8,$2,$0,$10,$88,$83,$0,$12,$13,$a
		dc.b	$88,$85,$12,$14,$2,$14,$14,$2c,$2a,$12,$6,$13,$8,$2b,$2d,$15
		dc.b	$6,$17,$6,$16,$0,$0,$5,$8c,$3,$6e,$88,$83,$0,$2,$3,$2
		dc.b	$88,$87,$0,$2,$4,$4,$88,$87,$0,$12,$4,$8,$88,$84,$3,$6
		dc.b	$7,$2,$0,$e,$88,$84,$7,$18,$19,$6,$0,$1a,$45,$c6,$88,$84
		dc.b	$c,$4,$8,$a,$0,$c,$88,$84,$e,$c,$10,$a,$0,$6,$88,$84
		dc.b	$e,$16,$10,$14,$0,$16,$45,$e6,$88,$84,$d,$5,$9,$b,$0,$c
		dc.b	$88,$84,$f,$d,$11,$b,$0,$7,$88,$84,$f,$17,$11,$15,$0,$17
		dc.b	$0,$0,$40,$6,$2,$b,$80,$2,$88,$85,$10,$2,$2,$0,$0,$1e
		dc.b	$20,$2,$8,$22,$22,$3,$8,$21,$1f,$0,$0,$0,$0,$8b,$1,$54
		dc.b	$0,$4,$33,$34,$35,$32,$0,$2,$88,$85,$e,$4,$2,$0,$0,$1a
		dc.b	$1c,$4,$6,$2,$8,$20,$1e,$0,$0,$0,$88,$85,$e,$5,$2,$0
		dc.b	$0,$1b,$1d,$5,$6,$3,$8,$21,$1f,$0,$0,$0,$88,$85,$a,$8
		dc.b	$2,$0,$0,$1a,$1c,$4,$6,$12,$0,$0,$88,$85,$a,$9,$2,$0
		dc.b	$0,$1b,$1d,$5,$6,$13,$0,$0,$ff,$e6,$88,$88,$70,$6,$6e,$2
		dc.b	$0,$1c,$0,$4b,$80,$e,$f,$ee,$0,$68,$88,$85,$e,$12,$2,$4
		dc.b	$4,$26,$28,$a,$6,$14,$8,$2c,$2a,$12,$0,$0,$88,$85,$e,$13
		dc.b	$2,$5,$5,$27,$29,$b,$6,$15,$8,$2d,$2b,$13,$0,$0,$2,$b
		dc.b	$80,$14,$0,$6,$c,$55,$0,$d3,$0,$81,$d,$ee,$0,$2e,$d,$ee
		dc.b	$0,$2f,$d,$ee,$0,$30,$0,$73,$5,$97,$4c,$46,$f,$e,$0,$62
		dc.b	$f0,$15,$45,$c6,$88,$85,$c,$c,$2,$a,$a,$28,$26,$4,$6,$8
		dc.b	$6,$c,$0,$0,$88,$84,$e,$c,$10,$a,$0,$6,$88,$84,$e,$16
		dc.b	$10,$14,$0,$16,$88,$83,$a,$e,$14,$18,$0,$8a,$8,$16,$42,$6a
		dc.b	$30,$16,$0,$73,$0,$81,$1e,$1,$fa,$0,$e,$80,$45,$e6,$88,$85
		dc.b	$c,$c,$2,$b,$b,$29,$27,$5,$6,$9,$6,$d,$0,$0,$88,$84
		dc.b	$f,$d,$11,$b,$0,$7,$88,$84,$f,$17,$11,$15,$0,$17,$88,$83
		dc.b	$b,$f,$15,$19,$0,$8a,$8,$17,$6a,$6c,$30,$16,$0,$73,$0,$81
		dc.b	$f0,$1,$fa,$0,$f,$80,$2,$eb,$80,$1a,$46,$c6,$88,$85,$1c,$1a
		dc.b	$4,$18,$0,$16,$6,$10,$6,$c,$6,$8,$6,$6,$8,$24,$24,$7
		dc.b	$6,$9,$6,$d,$6,$11,$6,$17,$6,$19,$0,$0,$88,$91,$38,$36
		dc.b	$2,$1a,$4,$9a,$0,$0,$1,$ee,$ff,$e6,$0,$93,$4,$97,$0,$4b
		dc.b	$80,$e,$f,$2e,$40,$64,$0,$93,$8,$97,$0,$4b,$80,$e,$f,$4e
		dc.b	$40,$65,$1,$13,$3,$97,$0,$cb,$80,$e,$c3,$5d,$9,$80,$10,$3c
		dc.b	$0,$c3,$f,$6e,$6,$66,$0,$0,$1,$f0,$22,$2e,$1,$f0,$dd,$d2
		dc.b	$1,$f4,$38,$a4,$1,$f4,$e2,$b4,$a0,$80,$17,$8d,$0,$78,$0,$62
		dc.b	$d0,$80,$e,$10,$11,$2,$4,$5,$1a,$0,$d0,$80,$c,$14,$12,$13
		dc.b	$1a,$0,$d0,$80,$14,$6,$16,$18,$1a,$1e,$0,$d0,$80,$14,$7,$17
		dc.b	$19,$1a,$1e,$0,$0,$0,$a,$a5,$f9,$9d,$1,$3,$1,$2c,$0,$eb
		dc.b	$1,$5c,$1,$2c,$40,$20,$0,$4,$0,$8,$6,$4,$1,$0,$1d,$4c
		dc.b	$0,$0,$11,$94,$5,$cf,$0,$0,$0,$0,$0,$0,$0,$0,$2,$71
		dc.b	$6,$a4
	l1f0b8:	dc.b	$1,$32,$0,$1e,$f,$0,$1,$e,$0,$28,$0,$b,$0,$0,$0,$61
		dc.b	$0,$16,$6,$66,$0,$d,$1a,$db,$a,$be,$4,$20,$4,$3a,$1,$0
		dc.b	$0,$15,$1,$3,$3,$e,$1,$8,$0,$e,$1,$3,$fd,$e,$1,$7
		dc.b	$7,$ed,$1,$e,$0,$ed,$1,$7,$f9,$ed,$1,$3,$3,$ed,$1,$3
		dc.b	$3,$ec,$1,$3,$fd,$ed,$1,$3,$fd,$ec,$1,$1a,$0,$ef,$1,$d
		dc.b	$0,$f2,$1,$a,$0,$0,$1,$1,$1,$15,$1,$2,$2,$11,$1,$3
		dc.b	$0,$15,$1,$5,$0,$13,$1,$0,$ff,$15,$1,$2,$fe,$11,$1,$9
		dc.b	$6,$ed,$1,$e,$3,$ed,$1,$9,$fa,$ed,$1,$e,$fd,$ed,$1,$4
		dc.b	$fa,$f7,$1,$0,$fd,$7,$1,$1,$3,$f,$1,$1,$2,$10,$13,$c1
		dc.b	$5a,$5e,$1,$3,$3,$ea,$1,$3,$3,$c2,$7,$15,$0,$3c,$13,$c1
		dc.b	$3a,$3e,$1,$b,$0,$0,$1,$b,$0,$22,$7,$16,$0,$44,$13,$c1
		dc.b	$42,$46,$1,$d,$0,$fe,$1,$27,$0,$fe,$7,$16,$0,$4c,$13,$c1
		dc.b	$4a,$4e,$1,$b,$fe,$fe,$1,$b,$dc,$fe,$7,$15,$0,$54,$13,$c1
		dc.b	$52,$56,$1,$b,$2,$fe,$1,$b,$24,$fe,$7,$16,$0,$5c,$1,$3
		dc.b	$fd,$ea,$1,$3,$fd,$c2,$7,$15,$0,$62,$13,$c1,$60,$64,$1,$0
		dc.b	$fb,$fe,$b,$1,$2,$8,$b,$1,$6a,$6b,$1,$b,$4,$ee,$1,$0
		dc.b	$6,$f2,$1,$0,$fa,$f4,$1,$0,$f2,$0,$1,$fb,$2,$d,$2,$0
		dc.b	$73,$35,$0,$39,$5a,$44,$8,$0,$0,$81,$0,$39,$a6,$44,$c,$0
		dc.b	$82,$e,$0,$0,$8d,$35,$8,$0,$7e,$e,$2,$43,$69,$13,$4,$59
		dc.b	$a7,$f,$2,$d4,$10,$8f,$2,$93,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$1,$93,$0,$c1,$1e,$e9,$40,$3a,$1,$b5
		dc.b	$1e,$e9,$41,$3b,$1,$b5,$1e,$e9,$66,$60,$1,$b5,$1e,$e9,$67,$61
		dc.b	$1,$b5,$1,$d3,$10,$8f,$c1,$1d,$8f,$40,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$48,$42,$0,$fa,$1e,$e9,$49,$43
		dc.b	$0,$fa,$1,$74,$10,$8d,$1,$33,$0,$8d,$c1,$5d,$4,$8d,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$51,$4b,$0,$fa,$1,$73,$10,$8d
		dc.b	$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$50,$4a,$0,$fa,$1,$d4,$10,$8e,$1,$93,$0,$8e,$c1,$5d
		dc.b	$4,$8e,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$58,$52,$0,$fa
		dc.b	$1e,$e9,$59,$53,$0,$fa,$1,$d3,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$38,$5a,$1,$77
		dc.b	$1e,$e9,$39,$5b,$1,$77,$3,$b,$1,$6e,$e,$95,$0,$f3,$0,$81
		dc.b	$d,$ee,$0,$30,$d,$ee,$0,$31,$d,$fb,$0,$32,$12,$22,$1,$6b
		dc.b	$80,$a,$10,$1c,$27,$3d,$4e,$46,$f,$ee,$6,$72,$0,$93,$5,$97
		dc.b	$0,$1c,$28,$7d,$f,$e,$6,$68,$f0,$15,$ff,$e6,$6,$4b,$80,$6
		dc.b	$1,$2c,$1,$e8,$44,$45,$e,$6,$4,$8,$0,$a,$6,$c,$6,$d
		dc.b	$6,$b,$6,$9,$0,$0,$4,$ab,$1,$e8,$44,$45,$16,$6,$2,$8
		dc.b	$8,$28,$2a,$a,$8,$2e,$2c,$c,$6,$d,$8,$2d,$2f,$b,$8,$2b
		dc.b	$29,$9,$0,$0,$44,$51,$10,$e,$1,$6,$2,$86,$0,$0,$1,$ee
		dc.b	$44,$51,$11,$f,$1,$6,$2,$86,$0,$0,$1,$ee,$44,$51,$14,$12
		dc.b	$1,$6,$2,$86,$0,$0,$1,$ee,$44,$51,$15,$13,$1,$6,$2,$86
		dc.b	$0,$0,$1,$ee,$44,$44,$7,$c,$d,$6,$0,$a,$3,$2c,$1,$3c
		dc.b	$44,$43,$0,$2,$3,$2,$44,$47,$0,$2,$4,$4,$44,$47,$0,$4
		dc.b	$6,$8,$44,$43,$0,$6,$7,$c,$44,$44,$3,$8,$9,$2,$0,$e
		dc.b	$44,$48,$8,$4,$a,$2,$0,$10,$44,$48,$c,$4,$a,$6,$0,$12
		dc.b	$0,$0,$44,$45,$c,$2,$2,$2,$2,$1e,$1c,$0,$8,$1d,$1f,$3
		dc.b	$0,$0,$0,$8b,$0,$aa,$10,$4,$35,$36,$37,$34,$0,$2,$44,$45
		dc.b	$c,$4,$2,$2,$2,$1e,$1c,$0,$8,$20,$22,$4,$0,$0,$44,$45
		dc.b	$c,$5,$2,$3,$3,$1f,$1d,$0,$8,$21,$23,$5,$0,$0,$44,$45
		dc.b	$c,$8,$2,$4,$4,$22,$20,$0,$8,$24,$26,$6,$0,$0,$44,$45
		dc.b	$c,$9,$2,$5,$5,$23,$21,$0,$8,$25,$27,$7,$0,$0,$44,$45
		dc.b	$c,$c,$2,$6,$6,$26,$24,$0,$8,$25,$27,$7,$0,$0,$2,$b
		dc.b	$80,$10,$44,$45,$c,$10,$2,$a,$a,$2a,$28,$8,$6,$2,$6,$4
		dc.b	$0,$0,$d,$1c,$d2,$45,$83,$3c,$11,$54,$88,$8a,$8,$10,$46,$6e
		dc.b	$30,$16,$2,$b,$80,$11,$44,$45,$c,$11,$2,$b,$b,$2b,$29,$9
		dc.b	$6,$3,$6,$5,$0,$0,$19,$1c,$2d,$3a,$83,$3c,$11,$54,$88,$8a
		dc.b	$8,$11,$46,$76,$30,$16,$44,$44,$3,$8,$9,$2,$0,$e,$44,$45
		dc.b	$c,$12,$2,$a,$a,$2e,$2c,$c,$6,$6,$6,$4,$0,$0,$44,$45
		dc.b	$c,$13,$2,$b,$b,$2f,$2d,$d,$6,$7,$6,$5,$0,$0,$5,$cb
		dc.b	$1,$e8,$2,$8b,$80,$e,$0,$53,$4,$97,$f,$2e,$40,$6a,$0,$53
		dc.b	$8,$97,$f,$4e,$40,$6b,$0,$d3,$3,$97,$c3,$5d,$9,$80,$10,$3c
		dc.b	$0,$c3,$f,$6e,$6,$6c,$10,$1c,$d8,$2,$f,$ee,$6,$70,$43,$46
		dc.b	$44,$45,$8,$0,$2,$a,$a,$16,$18,$1a,$0,$0,$0,$73,$0,$81
		dc.b	$1e,$1,$7d,$0,$1a,$80,$43,$66,$44,$45,$8,$0,$2,$b,$b,$17
		dc.b	$19,$1b,$0,$0,$0,$73,$0,$81,$f0,$1,$7d,$0,$1b,$80,$0,$0
		dc.b	$4,$e4,$e,$a6,$7,$54,$f1,$5a,$2,$70,$e,$a6,$2,$70,$f1,$5a
		dc.b	$a0,$80,$17,$8d,$0,$78,$0,$68,$10,$80,$a,$e,$10,$11,$12,$13
		dc.b	$6,$2,$4,$5,$8,$9,$c,$0,$0,$0,$c,$c6,$f9,$9d,$1,$4
		dc.b	$3,$e8,$3,$39,$4,$f1,$1,$4,$40,$21,$0,$9,$0,$8,$8,$7
		dc.b	$1,$0,$13,$88,$2,$71,$15,$7c,$5,$dc,$15,$f9,$0,$0,$13,$88
		dc.b	$0,$0,$f1,$5a,$7,$21,$f3,$cb,$f8,$df
	l1f522:	dc.b	$0,$58,$0,$10,$4,$0,$0,$50,$0,$c,$0,$6,$0,$0,$0,$75
		dc.b	$1,$1b,$0,$b2,$1,$1b,$0,$4e,$1,$0,$0,$b2,$1,$0,$0,$4e
		dc.b	$13,$c4,$4,$0,$13,$c4,$6,$2,$1,$7,$0,$0,$1,$7,$8b,$0
		dc.b	$13,$c3,$c,$e,$1,$7,$0,$3a,$1,$7,$8b,$3a,$13,$c3,$12,$14
		dc.b	$1,$7,$0,$c6,$1,$7,$8b,$c6,$13,$c3,$18,$1a,$b,$1,$e,$f
		dc.b	$12,$7f,$0,$0,$0,$0,$81,$0,$c1,$7d,$4f,$81,$c4,$5d,$2,$c1
		dc.b	$ff,$e6,$10,$4,$9,$a,$b,$8,$0,$4,$c3,$6d,$48,$81,$c3,$1d
		dc.b	$48,$c3,$0,$13,$0,$c3,$43,$c6,$10,$11,$11,$10,$13,$82,$13,$83
		dc.b	$4,$44,$4,$44,$10,$11,$17,$16,$13,$82,$13,$83,$4,$44,$4,$44
		dc.b	$10,$11,$1d,$1c,$13,$82,$13,$83,$4,$44,$4,$44,$1,$cb,$10,$c8
		dc.b	$41,$c6,$fe,$e2,$1c,$16,$fe,$e2,$12,$10,$fe,$e2,$18,$10,$41,$e6
		dc.b	$fe,$e2,$1d,$17,$fe,$e2,$13,$11,$fe,$e2,$19,$11,$0,$0
	l1f5e0:	dc.b	$0,$58,$0,$10,$4,$80,$0,$58,$0,$4,$0,$6,$0,$0,$0,$75
		dc.b	$1,$27,$e1,$b2,$1,$27,$e1,$4e,$1,$0,$e1,$b2,$1,$0,$e1,$4e
		dc.b	$13,$c4,$4,$0,$13,$c4,$6,$2,$1,$b,$ed,$0,$1,$b,$8b,$0
		dc.b	$13,$c3,$c,$e,$1,$b,$ed,$3a,$1,$b,$8b,$3a,$13,$c3,$12,$14
		dc.b	$1,$b,$ed,$c6,$1,$b,$8b,$c6,$13,$c3,$18,$1a,$1,$3,$f9,$46
		dc.b	$1,$3,$97,$46,$13,$c3,$1e,$20,$0,$13,$0,$81,$c1,$7d,$4f,$81
		dc.b	$c4,$5d,$2,$c1,$10,$4,$9,$a,$b,$8,$0,$0,$c3,$6d,$48,$81
		dc.b	$c3,$1d,$48,$c3,$0,$13,$0,$c3,$fe,$e4,$17,$1c,$1d,$16,$0,$0
		dc.b	$fe,$e4,$17,$22,$23,$16,$0,$0,$0,$b,$16,$e2,$fe,$e2,$12,$10
		dc.b	$fe,$e2,$18,$10,$0,$b,$9,$26,$fe,$e2,$13,$11,$fe,$e2,$19,$11
		dc.b	$0,$0
	l1f682:	dc.b	$0,$44,$0,$10,$1,$c0,$0,$2c,$0,$1c,$0,$6,$0,$0,$0,$46
		dc.b	$1,$0,$b,$1f,$1,$1f,$0,$2e,$1,$3e,$0,$f1,$1,$0,$0,$ba
		dc.b	$1,$b,$17,$f,$1,$17,$17,$fd,$1,$0,$17,$e5,$8,$0,$7f,$0
		dc.b	$2,$0,$65,$4c,$2,$3f,$67,$25,$4,$31,$6a,$cf,$5,$cf,$6a,$cf
		dc.b	$3,$c1,$67,$25,$44,$45,$c,$2,$4,$8,$0,$a,$6,$c,$6,$b
		dc.b	$6,$9,$0,$0,$44,$44,$3,$8,$9,$2,$0,$4,$44,$44,$4,$8
		dc.b	$a,$2,$0,$6,$44,$44,$6,$a,$c,$4,$0,$8,$44,$44,$6,$b
		dc.b	$c,$5,$0,$a,$44,$44,$5,$9,$b,$3,$0,$c,$0,$0
	l1f700:	dc.b	$0,$ea,$0,$1e,$a,$80,$0,$c6,$0,$28,$0,$a,$0,$0,$0,$7e
		dc.b	$0,$15,$6,$66,$0,$c,$58,$de,$13,$b,$2,$c6,$2,$e0,$1,$0
		dc.b	$f,$fa,$1,$13,$0,$19,$1,$19,$c,$0,$1,$1f,$0,$da,$1,$2c
		dc.b	$0,$0,$1,$0,$6,$da,$1,$19,$f4,$0,$1,$c,$f4,$da,$1,$0
		dc.b	$6,$da,$1,$6,$0,$da,$1,$0,$fa,$da,$1,$0,$0,$19,$1,$17
		dc.b	$8,$f3,$1,$0,$f6,$6,$1,$0,$f3,$ed,$1,$6,$0,$d3,$1,$6
		dc.b	$0,$83,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$0,$0,$1b,$1,$0
		dc.b	$0,$48,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$32,$0,$0,$1,$6b
		dc.b	$0,$0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f0,$f4,$1,$0
		dc.b	$a5,$f4,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$19,$fa,$1,$0
		dc.b	$5f,$fa,$7,$16,$0,$40,$13,$c1,$3e,$42,$b,$1,$0,$a,$1,$1f
		dc.b	$2,$e4,$1,$d9,$2,$0,$1,$13,$f4,$fa,$1,$0,$f4,$e1,$1,$0
		dc.b	$f4,$0,$1,$0,$e,$fa,$2,$0,$71,$38,$0,$15,$77,$dc,$4,$45
		dc.b	$67,$e9,$2,$3d,$5c,$3d,$2,$0,$8f,$38,$2,$3d,$a4,$3d,$6,$45
		dc.b	$99,$e9,$c,$0,$82,$0,$6,$0,$0,$81,$2,$14,$10,$8f,$1,$d3
		dc.b	$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3
		dc.b	$0,$c1,$1e,$e9,$24,$1e,$4,$71,$1e,$e9,$25,$1f,$4,$71,$1,$73
		dc.b	$10,$8f,$c1,$1d,$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$2c,$26,$2,$8a,$1,$74,$10,$8d,$1,$33,$0,$8d
		dc.b	$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f
		dc.b	$2,$8a,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$34,$2e,$2,$8a,$1,$74,$10,$8e
		dc.b	$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$3c,$36,$2,$8a,$1,$73,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$44,$3e,$3,$cf
		dc.b	$54,$5a,$82,$0,$1,$60,$1,$0,$1,$4,$3,$22,$7,$0,$5,$44
		dc.b	$9,$40,$1,$ab,$4,$b6,$1,$73,$0,$81,$a,$15,$d,$fb,$8,$4e
		dc.b	$f0,$8,$d,$fb,$0,$4c,$f0,$8,$d,$fb,$0,$4d,$f0,$8,$f0,$15
		dc.b	$ff,$e6,$1,$5,$c,$2,$4,$2,$0,$4,$6,$0,$6,$5,$6,$3
		dc.b	$0,$0,$1,$8,$0,$6,$a,$4,$0,$4,$1,$7,$4,$8,$6,$6
		dc.b	$1,$7,$2,$4,$8,$8,$1,$4,$3,$c,$d,$2,$0,$a,$1,$7
		dc.b	$2,$8,$c,$c,$1,$8,$e,$8,$c,$6,$0,$e,$1,$4,$e,$d
		dc.b	$f,$c,$0,$10,$1,$5,$c,$12,$4,$6,$0,$a,$6,$7,$6,$f
		dc.b	$6,$e,$0,$0,$0,$b,$2,$7a,$d,$1c,$72,$39,$83,$3c,$85,$53
		dc.b	$88,$8a,$8,$6,$46,$48,$30,$16,$d,$1c,$8d,$6,$83,$3c,$85,$53
		dc.b	$88,$8a,$8,$7,$46,$4a,$30,$16,$1e,$e5,$a,$12,$c,$12,$4,$12
		dc.b	$c,$13,$4,$12,$0,$0,$0,$d3,$5,$97,$0,$8b,$80,$a,$0,$1c
		dc.b	$0,$78,$f,$e,$6,$1a,$0,$93,$4,$97,$0,$4b,$80,$4,$f,$2e
		dc.b	$40,$18,$1,$8b,$80,$5,$0,$53,$8,$97,$f,$4e,$40,$19,$0,$d3
		dc.b	$3,$97,$c3,$5d,$9,$80,$10,$3c,$0,$c3,$f,$6e,$6,$46,$0,$6
		dc.b	$0,$4c,$80,$10,$f,$ee,$0,$52,$1,$b,$80,$10,$3,$95,$0,$93
		dc.b	$10,$9d,$c1,$4d,$8,$9d,$0,$4e,$0,$1c,$f0,$15,$1,$d3,$10,$81
		dc.b	$1,$93,$6,$80,$1,$53,$5,$80,$0,$73,$4,$80,$1e,$1,$cf,$3
		dc.b	$8,$80,$0,$74,$4,$80,$f0,$1,$cf,$3,$9,$80,$0,$0,$c,$b0
		dc.b	$1f,$bd,$c,$b0,$e0,$43,$a0,$80,$17,$8d,$0,$78,$0,$1a,$10,$80
		dc.b	$2,$4,$5,$6,$7,$8,$9,$a,$c,$d,$e,$f,$10,$12,$0,$0
		dc.b	$19,$8c,$f5,$5b,$1,$3,$1,$90,$1,$40,$1,$d8,$1,$4,$40,$22
		dc.b	$0,$5,$0,$1,$7,$5,$1,$0,$6,$59,$3,$cf,$14,$50,$6,$59
		dc.b	$c,$b2,$0,$0,$13,$b,$5,$14,$fc,$d4,$7,$ce
	l1fa0c:	dc.b	$0,$9e,$0,$1e,$6,$40,$0,$82,$0,$20,$0,$a,$0,$0,$0,$4e
		dc.b	$0,$16,$6,$66,$0,$c,$46,$50,$f,$a0,$1,$c2,$1,$ee,$1,$0
		dc.b	$0,$0,$1,$0,$fd,$27,$1,$7,$fd,$27,$1,$0,$fe,$2a,$1,$0
		dc.b	$0,$0,$1,$33,$ee,$f2,$1,$fa,$0,$0,$1,$17,$fd,$0,$11,$1
		dc.b	$6,$4,$1,$0,$f9,$e9,$1,$0,$7,$e5,$1,$17,$fd,$f9,$1,$b
		dc.b	$fd,$e9,$1,$0,$fd,$13,$1,$1f,$fe,$fd,$1,$0,$3,$19,$13,$81
		dc.b	$a,$1c,$11,$1,$20,$c,$1,$0,$6,$f5,$1,$0,$b,$e0,$1,$0
		dc.b	$12,$db,$1,$17,$fc,$0,$1,$0,$0,$20,$1,$0,$0,$1b,$1,$3
		dc.b	$0,$16,$16,$d,$83,$b,$e,$0,$82,$0,$e,$5b,$4b,$d3,$e,$4f
		dc.b	$56,$2f,$16,$47,$e7,$9b,$17,$b9,$e7,$9b,$30,$e9,$7c,$8,$c2,$cd
		dc.b	$60,$8f,$45,$46,$66,$65,$12,$2,$2,$12,$12,$1a,$1a,$2,$8,$4
		dc.b	$1a,$e,$6,$16,$8,$18,$18,$12,$0,$0,$45,$66,$44,$45,$12,$3
		dc.b	$2,$12,$12,$1a,$1a,$2,$8,$5,$1a,$f,$6,$17,$8,$19,$19,$12
		dc.b	$0,$0,$41,$c6,$66,$65,$12,$6,$2,$2,$2,$4,$1a,$e,$6,$16
		dc.b	$8,$18,$18,$14,$8,$1e,$1e,$2,$0,$0,$1,$6c,$80,$6,$66,$65
		dc.b	$12,$8,$2,$2,$2,$4,$1a,$e,$6,$16,$8,$18,$18,$14,$8,$1e
		dc.b	$1e,$2,$0,$0,$41,$e6,$44,$45,$12,$7,$2,$2,$2,$5,$1a,$f
		dc.b	$6,$17,$8,$19,$19,$14,$8,$1e,$1e,$2,$0,$0,$1,$6c,$80,$7
		dc.b	$44,$45,$12,$9,$2,$2,$2,$5,$1a,$f,$6,$17,$8,$19,$19,$14
		dc.b	$8,$1e,$1e,$2,$0,$0,$0,$6,$66,$65,$e,$a,$4,$12,$0,$14
		dc.b	$8,$18,$18,$16,$8,$18,$18,$12,$0,$0,$66,$65,$e,$b,$4,$12
		dc.b	$0,$14,$8,$19,$19,$17,$8,$19,$19,$12,$0,$0,$1,$8b,$1,$a0
		dc.b	$22,$25,$8,$a,$2,$12,$12,$18,$18,$14,$0,$0,$22,$25,$8,$b
		dc.b	$2,$12,$12,$19,$19,$14,$0,$0,$c1,$d,$40,$4,$0,$93,$0,$c0
		dc.b	$10,$2e,$90,$28,$26,$14,$7f,$24,$0,$cb,$1,$a0,$e6,$6,$ff,$e1
		dc.b	$0,$7,$30,$2e,$2c,$e,$0,$6,$c4,$5d,$a,$80,$0,$53,$0,$81
		dc.b	$c4,$d,$40,$0,$0,$5c,$0,$c4,$10,$2e,$86,$20,$22,$16,$7f,$e
		dc.b	$10,$5c,$0,$c4,$10,$2e,$86,$21,$23,$17,$7f,$f,$0,$0,$7,$d4
		dc.b	$1f,$40,$a0,$80,$1,$8f,$0,$81,$0,$1c,$a0,$80,$1,$f,$0,$81
		dc.b	$0,$a,$a0,$80,$1,$8f,$0,$81,$20,$1d,$a0,$80,$1,$f,$0,$81
		dc.b	$20,$b,$d0,$80,$a,$6,$8,$7,$9,$2,$3,$b,$0,$0,$22,$10
		dc.b	$f3,$3a,$0,$1,$1,$e0,$1,$5e,$2,$61,$1,$36,$40,$23,$0,$1
		dc.b	$0,$6,$80,$6,$1,$0,$11,$94,$3,$e8,$b,$b8,$0,$0,$13,$88
		dc.b	$0,$64
	l1fc1e:	dc.b	$0,$76,$0,$1e,$3,$80,$0,$56,$0,$24,$0,$9,$0,$0,$0,$7d
		dc.b	$0,$14,$6,$66,$0,$b,$7d,$0,$7d,$0,$1,$6c,$0,$0,$1,$0
		dc.b	$0,$0,$1,$0,$0,$d2,$1,$0,$e,$0,$1,$c,$7,$0,$1,$c
		dc.b	$f9,$0,$1,$0,$f2,$0,$1,$0,$11,$7,$1,$e,$8,$f,$1,$e
		dc.b	$f8,$17,$1,$0,$ef,$f,$1,$0,$0,$4e,$1,$0,$0,$7d,$1,$0
		dc.b	$0,$f6,$11,$1,$fc,$18,$0,$0,$0,$7f,$2,$0,$0,$81,$6,$47
		dc.b	$66,$ea,$8,$7d,$fa,$f2,$a,$46,$99,$ec,$14,$32,$71,$1b,$14,$7a
		dc.b	$e,$1f,$14,$30,$8f,$1f,$0,$6,$0,$15,$66,$71,$2,$0,$c,$2
		dc.b	$7,$84,$0,$0,$1,$ee,$66,$64,$fd,$fc,$fe,$1a,$0,$0,$44,$48
		dc.b	$4,$e,$c,$6,$0,$6,$44,$48,$6,$10,$e,$8,$0,$8,$66,$68
		dc.b	$8,$12,$10,$a,$0,$a,$66,$67,$14,$c,$e,$c,$44,$47,$14,$e
		dc.b	$10,$e,$44,$47,$14,$10,$12,$10,$0,$53,$1,$82,$88,$82,$14,$16
		dc.b	$9,$8b,$2,$70,$4,$93,$2,$82,$22,$65,$8,$6,$2,$6,$6,$e
		dc.b	$c,$4,$0,$0,$22,$65,$8,$7,$2,$7,$7,$f,$d,$5,$0,$0
		dc.b	$22,$65,$8,$8,$2,$8,$8,$10,$e,$6,$0,$0,$22,$65,$8,$9
		dc.b	$2,$9,$9,$11,$f,$7,$0,$0,$22,$65,$8,$a,$2,$a,$a,$12
		dc.b	$10,$8,$0,$0,$22,$65,$8,$b,$2,$b,$b,$13,$11,$9,$0,$0
		dc.b	$4,$93,$3,$82,$22,$65,$8,$c,$2,$14,$14,$c,$e,$14,$0,$0
		dc.b	$60,$5,$8,$d,$2,$14,$14,$d,$f,$14,$0,$0,$60,$5,$8,$e
		dc.b	$2,$14,$14,$e,$10,$14,$0,$0,$22,$65,$8,$f,$2,$14,$14,$f
		dc.b	$11,$14,$0,$0,$22,$65,$8,$10,$2,$14,$14,$10,$12,$14,$0,$0
		dc.b	$60,$5,$8,$11,$2,$14,$14,$11,$13,$14,$0,$0,$f0,$15,$c3,$bd
		dc.b	$44,$c2,$0,$53,$0,$c3,$10,$4e,$48,$2,$0,$0,$d0,$80,$4,$c
		dc.b	$d,$e,$f,$10,$11,$6,$7,$8,$9,$a,$b,$0,$0,$0
	l1fd9c:	dc.b	$0,$38,$0,$10,$2,$80,$0,$38,$0,$4,$0,$e,$0,$0,$0,$61
		dc.b	$1,$0,$0,$0,$1,$0,$0,$3,$13,$c4,$0,$2,$b,$1,$0,$4
		dc.b	$b,$1,$0,$6,$b,$1,$0,$8,$1,$0,$0,$61,$13,$c4,$0,$c
		dc.b	$7,$12,$0,$6,$13,$c4,$6,$10,$c3,$fd,$3,$80,$c3,$d,$1c,$c3
		dc.b	$c4,$4d,$5,$c2,$c4,$2d,$c3,$c4,$ff,$e6,$10,$e3,$12,$e,$13,$0
		dc.b	$c4,$4d,$5,$c4,$10,$e1,$0,$c4,$4,$0,$c4,$4d,$1,$c4,$54,$e1
		dc.b	$0,$c4,$6,$0,$c4,$4d,$1,$c4,$98,$e1,$0,$c4,$8,$0,$c4,$4d
		dc.b	$1,$c4,$dc,$e1,$0,$c4,$a,$80,$0,$0
	l1fe16:	dc.b	$0,$26,$0,$1e,$0,$80,$0,$26,$0,$4,$0,$a,$0,$0,$0,$46
		dc.b	$0,$16,$6,$66,$0,$c,$46,$50,$f,$a0,$0,$30,$0,$3e,$1,$0
		dc.b	$0,$0,$1,$0,$ee,$db,$4,$e,$0,$0,$0,$0,$7,$d4,$1f,$40
		dc.b	$80,$80,$0,$81,$10,$2,$80,$80,$0,$20,$0,$0,$0,$0,$13,$29
		dc.b	$f7,$7c,$0,$1,$2,$bc,$2,$d,$3,$b5,$1,$8b,$40,$24,$0,$1
		dc.b	$0,$6,$80,$7,$1,$0,$11,$94,$3,$e8,$b,$b8,$0,$0,$13,$88
		dc.b	$0,$64
	l1fe78:	dc.b	$0,$ea,$0,$1e,$a,$80,$0,$c6,$0,$28,$0,$b,$0,$0,$0,$65
		dc.b	$0,$16,$6,$66,$0,$d,$22,$e9,$9,$85,$2,$f4,$3,$1a,$1,$0
		dc.b	$9,$0,$1,$0,$1,$26,$1,$0,$9,$f7,$1,$0,$6,$e7,$1,$13
		dc.b	$1,$f4,$1,$c,$1,$e7,$1,$0,$fb,$0,$1,$0,$fb,$f7,$1,$0
		dc.b	$fe,$e7,$1,$0,$5,$e7,$1,$6,$1,$e7,$1,$0,$ff,$e7,$b,$1
		dc.b	$0,$8,$b,$1,$c,$8,$b,$1,$2,$18,$1,$0,$1,$e3,$1,$0
		dc.b	$1,$9b,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$c,$1,$c,$1,$c
		dc.b	$1,$22,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$11,$1,$0,$1,$2d
		dc.b	$1,$0,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$f6,$fa,$1,$0
		dc.b	$d0,$fa,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$e,$fa,$1,$0
		dc.b	$34,$fa,$7,$16,$0,$40,$13,$c1,$3e,$42,$b,$1,$0,$2,$b,$1
		dc.b	$2,$1a,$1,$e,$3,$f9,$1,$fd,$3,$15,$1,$6,$fd,$f6,$1,$6
		dc.b	$fd,$fc,$1,$6,$ef,$0,$8,$3a,$6e,$16,$8,$2f,$75,$0,$8,$2a
		dc.b	$75,$e9,$8,$29,$76,$ec,$8,$3a,$92,$16,$c,$2f,$8b,$0,$8,$2a
		dc.b	$8b,$e9,$8,$29,$8a,$ec,$6,$0,$0,$81,$1,$b4,$10,$8f,$1,$73
		dc.b	$0,$8f,$c1,$7d,$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$24,$1e,$2,$38,$1,$d3,$10,$8f,$c1,$1d,$8f,$40
		dc.b	$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$2c,$26
		dc.b	$1,$45,$1e,$e9,$2d,$27,$1,$45,$1,$74,$10,$8d,$1,$33,$0,$8d
		dc.b	$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f
		dc.b	$1,$45,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$34,$2e,$1,$45,$1,$74,$10,$8e
		dc.b	$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$3c,$36,$1,$45,$1,$73,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$44,$3e,$1,$e7
		dc.b	$1,$d3,$0,$81,$1,$8b,$1,$7c,$4a,$46,$d,$5b,$80,$4e,$72,$22
		dc.b	$7f,$7f,$7f,$50,$4a,$66,$d,$5b,$94,$4f,$72,$22,$7f,$7f,$7f,$51
		dc.b	$ff,$e6,$44,$47,$8,$c,$2,$a,$44,$47,$8,$e,$10,$e,$0,$7
		dc.b	$8,$c,$e,$c,$44,$47,$8,$0,$2,$2,$0,$7,$8,$0,$4,$4
		dc.b	$44,$47,$8,$4,$6,$6,$88,$87,$8,$a,$6,$8,$88,$87,$8,$a
		dc.b	$10,$10,$88,$84,$b,$a,$10,$6,$0,$12,$1e,$e4,$15,$14,$16,$12
		dc.b	$0,$12,$0,$b,$1,$3c,$2,$13,$6,$82,$0,$cb,$80,$a,$0,$1a
		dc.b	$0,$a,$f,$ae,$c0,$2,$7f,$8,$7f,$c,$0,$cb,$80,$b,$0,$1a
		dc.b	$0,$b,$f,$ae,$c0,$3,$7f,$9,$7f,$d,$19,$1c,$4f,$7,$83,$3c
		dc.b	$73,$55,$88,$8a,$9,$2,$46,$4a,$30,$16,$19,$1c,$b0,$38,$83,$3c
		dc.b	$73,$55,$88,$8a,$9,$3,$46,$4c,$30,$16,$2,$13,$5,$97,$0,$cb
		dc.b	$80,$a,$0,$1c,$0,$7c,$83,$5c,$0,$8,$f,$e,$6,$48,$0,$cb
		dc.b	$80,$b,$0,$1c,$0,$7c,$83,$5c,$0,$78,$f,$e,$6,$49,$0,$93
		dc.b	$4,$97,$0,$4b,$80,$4,$f,$2e,$40,$1c,$0,$93,$8,$97,$0,$4b
		dc.b	$80,$5,$f,$4e,$40,$1d,$0,$6,$0,$d3,$3,$97,$c3,$5d,$9,$80
		dc.b	$10,$3c,$0,$c3,$f,$6e,$6,$46,$0,$cb,$80,$4,$0,$93,$10,$9d
		dc.b	$c1,$4d,$8,$9d,$0,$4e,$0,$18,$0,$cb,$80,$c,$0,$93,$8,$9d
		dc.b	$c1,$4d,$40,$9d,$0,$4e,$0,$1a,$0,$cb,$80,$5,$0,$93,$10,$9e
		dc.b	$c1,$4d,$8,$9e,$0,$4e,$0,$19,$0,$cb,$80,$d,$0,$93,$8,$9e
		dc.b	$c1,$4d,$40,$9e,$0,$4e,$0,$1b,$0,$6,$1,$d3,$10,$81,$1,$93
		dc.b	$6,$80,$1,$53,$5,$80,$0,$73,$4,$80,$1e,$1,$e7,$1,$8,$80
		dc.b	$0,$74,$4,$80,$f0,$1,$e7,$1,$9,$80,$0,$0,$3,$2c,$1a,$a9
		dc.b	$3,$cc,$f4,$93,$a0,$80,$17,$8d,$0,$78,$0,$48,$a0,$80,$17,$8d
		dc.b	$0,$78,$0,$49,$10,$80,$2,$3,$4,$5,$6,$7,$8,$9,$a,$b
		dc.b	$c,$d,$e,$f,$10,$11,$12,$0,$0,$0,$15,$4a,$f7,$7c,$1,$2
		dc.b	$1,$f4,$1,$90,$2,$3f,$1,$90,$40,$25,$0,$7,$0,$4,$7,$5
		dc.b	$0,$4,$16,$37,$0,$a2,$19,$64,$2,$8a,$26,$16,$fe,$19,$19,$64
		dc.b	$2,$8a
	l201ba:	dc.b	$0,$d6,$0,$1e,$a,$0,$0,$be,$0,$1c,$0,$c,$0,$0,$0,$3f
		dc.b	$0,$17,$6,$66,$0,$e,$27,$10,$7,$53,$2,$66,$2,$7c,$1,$0
		dc.b	$0,$13,$1,$9,$3,$ed,$1,$e,$0,$f2,$1,$7,$fc,$f2,$1,$4
		dc.b	$0,$ef,$1,$3,$ff,$f0,$1,$3,$1,$3,$1,$2,$1,$5,$1,$2
		dc.b	$1,$7,$1,$1,$0,$9,$b,$1,$2,$3,$1,$4,$2,$f9,$1,$0
		dc.b	$1,$0,$1,$0,$ff,$9,$1,$0,$fd,$f9,$1,$0,$ff,$ec,$1,$0
		dc.b	$ff,$c1,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$4,$0,$a,$1,$4
		dc.b	$0,$20,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$9,$0,$fc,$1,$1f
		dc.b	$0,$fc,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$fd,$fc,$1,$0
		dc.b	$dd,$fc,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$2,$fc,$1,$0
		dc.b	$1f,$fc,$7,$16,$0,$40,$13,$c1,$3e,$42,$b,$1,$2,$4,$1,$fa
		dc.b	$1,$fe,$1,$8,$fd,$f4,$1,$3,$0,$8,$1,$4,$f9,$0,$2,$0
		dc.b	$7e,$b,$2,$0,$c1,$92,$2,$39,$6e,$18,$4,$44,$9a,$1d,$6,$0
		dc.b	$83,$11,$2,$2d,$bc,$a0,$1,$b4,$10,$8f,$1,$73,$0,$8f,$c1,$7d
		dc.b	$44,$8f,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$24,$1e,$1,$b5,$1,$d3,$10,$8f,$c1,$1d,$8f,$40,$c1,$5d,$4,$c1
		dc.b	$c1,$bd,$45,$c1,$0,$d3,$0,$c1,$1e,$e9,$2c,$26,$0,$fa,$1e,$e9
		dc.b	$2d,$27,$0,$fa,$1,$74,$10,$8d,$1,$33,$0,$8d,$c1,$5d,$4,$8d
		dc.b	$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$35,$2f,$0,$fa,$1,$73
		dc.b	$10,$8d,$c1,$1d,$8d,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73
		dc.b	$0,$c1,$1e,$e9,$34,$2e,$0,$fa,$1,$74,$10,$8e,$1,$33,$0,$8e
		dc.b	$c1,$5d,$4,$8e,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$3c,$36
		dc.b	$0,$fa,$1,$73,$10,$8e,$c1,$1d,$8e,$40,$c1,$5d,$4,$c1,$c1,$bd
		dc.b	$45,$c1,$0,$73,$0,$c1,$1e,$e9,$44,$3e,$1,$77,$1,$d3,$0,$81
		dc.b	$1,$8b,$1,$24,$49,$c6,$d,$5b,$80,$4a,$74,$44,$7f,$7f,$7f,$4c
		dc.b	$49,$e6,$d,$5b,$94,$4b,$74,$44,$7f,$7f,$7f,$4d,$ff,$e6,$88,$87
		dc.b	$4,$6,$0,$8,$88,$83,$2,$3,$0,$2,$3,$6b,$80,$2,$0,$4
		dc.b	$e,$d,$f,$c,$0,$2,$0,$4,$12,$11,$13,$10,$0,$2,$0,$73
		dc.b	$4,$97,$f,$3b,$40,$16,$f2,$22,$0,$73,$8,$97,$f,$5b,$40,$17
		dc.b	$f2,$22,$0,$f3,$3,$97,$c3,$5d,$9,$80,$10,$3c,$0,$c3,$f,$7b
		dc.b	$6,$18,$12,$22,$88,$87,$2,$4,$0,$6,$2,$b,$0,$f4,$2,$dc
		dc.b	$0,$8,$83,$3c,$0,$8,$0,$a,$9,$6,$46,$46,$30,$16,$16,$dc
		dc.b	$0,$78,$83,$3c,$0,$8,$0,$a,$9,$7,$46,$48,$30,$16,$88,$83
		dc.b	$6,$7,$0,$a,$0,$7,$2,$4,$6,$c,$0,$4,$3,$6,$7,$2
		dc.b	$0,$4,$1e,$e4,$9,$a,$b,$8,$0,$4,$0,$d3,$5,$97,$0,$8b
		dc.b	$80,$a,$0,$1c,$80,$7b,$f,$e,$6,$1a,$0,$6,$1,$d3,$10,$81
		dc.b	$1,$93,$6,$80,$1,$53,$5,$80,$0,$73,$4,$80,$1e,$1,$77,$1
		dc.b	$4,$80,$0,$74,$4,$80,$f0,$1,$77,$1,$5,$80,$0,$0,$0,$7c
		dc.b	$13,$b,$4,$e4,$f1,$5a,$a0,$80,$17,$8d,$0,$78,$0,$1a,$10,$80
		dc.b	$2,$4,$6,$7,$8,$9,$a,$c,$d,$0,$0,$0,$c,$c6,$f9,$9d
		dc.b	$1,$2,$3,$20,$2,$8a,$4,$24,$1,$a4,$40,$26,$0,$8,$0,$8
		dc.b	$8,$7,$0,$5,$13,$88,$4,$e2,$22,$2e,$9,$c4,$27,$10,$0,$0
		dc.b	$27,$10,$e,$a6
	l2045e:	dc.b	$0,$e2,$0,$1e,$a,$c0,$0,$ca,$0,$1c,$0,$a,$0,$0,$0,$7e
		dc.b	$0,$15,$6,$66,$0,$c,$44,$5c,$13,$88,$2,$8a,$2,$9e,$1,$0
		dc.b	$0,$4e,$1,$13,$f,$d9,$1,$27,$0,$c6,$1,$13,$f1,$ed,$1,$6
		dc.b	$d,$ed,$1,$b,$d,$ed,$1,$2,$5,$27,$1,$f,$f9,$d6,$1,$0
		dc.b	$f9,$d6,$b,$1,$2,$3,$1,$7,$a,$0,$1,$0,$5,$27,$1,$0
		dc.b	$f9,$27,$1,$1,$f5,$4,$1,$1d,$7,$d9,$1,$f,$f9,$c4,$1,$f
		dc.b	$f9,$82,$7,$15,$0,$20,$13,$c1,$1e,$22,$1,$13,$0,$1d,$1,$13
		dc.b	$0,$61,$7,$16,$0,$28,$13,$c1,$26,$2a,$1,$27,$0,$ed,$1,$7e
		dc.b	$0,$ed,$7,$16,$0,$30,$13,$c1,$2e,$32,$1,$0,$e4,$ed,$1,$0
		dc.b	$a3,$ed,$7,$15,$0,$38,$13,$c1,$36,$3a,$1,$0,$17,$ed,$1,$0
		dc.b	$55,$ed,$7,$16,$0,$40,$13,$c1,$3e,$42,$1,$ed,$7,$f7,$1,$13
		dc.b	$d2,$1,$1,$16,$f5,$ea,$1,$e,$fd,$13,$b,$1,$1e,$1f,$b,$1
		dc.b	$24,$25,$1,$0,$e,$e1,$1,$0,$f2,$ef,$2,$0,$7d,$10,$2,$0
		dc.b	$63,$b1,$0,$5c,$52,$1a,$4,$6c,$c6,$1f,$4,$0,$8b,$d1,$6,$0
		dc.b	$83,$14,$2,$74,$10,$8f,$2,$33,$0,$8f,$c1,$7d,$44,$8f,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$1,$33,$0,$c1,$1e,$e9,$24,$1e,$5,$dc
		dc.b	$1e,$e9,$25,$1f,$5,$dc,$1e,$e9,$50,$4e,$5,$dc,$1,$d3,$10,$8f
		dc.b	$c1,$1d,$8f,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$d3,$0,$c1
		dc.b	$1e,$e9,$2c,$26,$3,$e8,$1e,$e9,$2d,$27,$3,$e8,$1,$74,$10,$8d
		dc.b	$1,$33,$0,$8d,$c1,$5d,$4,$8d,$c1,$bd,$45,$c1,$0,$73,$0,$c1
		dc.b	$1e,$e9,$35,$2f,$3,$e8,$1,$73,$10,$8d,$c1,$1d,$8d,$40,$c1,$5d
		dc.b	$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9,$34,$2e,$3,$e8
		dc.b	$1,$74,$10,$8e,$1,$33,$0,$8e,$c1,$5d,$4,$8e,$c1,$bd,$45,$c1
		dc.b	$0,$73,$0,$c1,$1e,$e9,$3c,$36,$3,$e8,$1,$73,$10,$8e,$c1,$1d
		dc.b	$8e,$40,$c1,$5d,$4,$c1,$c1,$bd,$45,$c1,$0,$73,$0,$c1,$1e,$e9
		dc.b	$44,$3e,$5,$dc,$1,$d3,$0,$81,$1,$8b,$4,$92,$49,$6,$d,$5b
		dc.b	$80,$4a,$64,$44,$7f,$7f,$7f,$4c,$49,$26,$d,$5b,$94,$4b,$64,$44
		dc.b	$7f,$7f,$7f,$4d,$ff,$e6,$88,$87,$4,$6,$0,$8,$88,$83,$0,$2
		dc.b	$3,$2,$44,$47,$8,$a,$c,$2,$0,$73,$4,$97,$f,$3b,$40,$14
		dc.b	$f2,$22,$0,$73,$8,$97,$f,$5b,$40,$15,$f2,$22,$0,$d3,$3,$97
		dc.b	$c3,$5d,$9,$80,$10,$3c,$0,$c3,$f,$6e,$6,$16,$88,$84,$3,$4
		dc.b	$5,$2,$0,$4,$44,$47,$0,$2,$4,$6,$88,$84,$6,$5,$7,$4
		dc.b	$0,$a,$88,$83,$0,$6,$7,$c,$4,$2b,$3,$d0,$19,$1c,$ab,$5
		dc.b	$83,$3c,$73,$4e,$88,$8a,$8,$6,$46,$1c,$30,$16,$19,$1c,$54,$3a
		dc.b	$83,$3c,$73,$4e,$88,$8a,$8,$7,$46,$46,$30,$16,$1e,$e5,$e,$a
		dc.b	$c,$e,$6,$a,$c,$f,$6,$a,$c,$10,$6,$a,$0,$0,$0,$4b
		dc.b	$80,$2,$f,$ee,$0,$52,$0,$4b,$80,$c,$f,$ee,$18,$54,$0,$d3
		dc.b	$5,$97,$0,$8b,$80,$c,$0,$1c,$0,$7c,$f,$e,$6,$18,$0,$6
		dc.b	$1,$d3,$10,$81,$1,$93,$6,$80,$1,$53,$5,$80,$0,$73,$4,$80
		dc.b	$1e,$1,$dc,$5,$4,$80,$0,$74,$4,$80,$f0,$1,$dc,$5,$5,$80
		dc.b	$0,$0,$3,$ec,$3c,$8c,$5,$dc,$d1,$20,$a0,$80,$17,$8d,$0,$78
		dc.b	$0,$18,$10,$80,$2,$4,$6,$7,$8,$9,$a,$c,$0,$0,$11,$8
		dc.b	$f7,$7c,$1,$4,$5,$dc,$5,$14,$9,$aa,$1,$90,$40,$27,$0,$a
		dc.b	$0,$6,$80,$9,$1,$0,$22,$2e,$3,$e8,$13,$88,$9,$c4,$27,$10
		dc.b	$0,$0,$13,$88,$9,$c4,$f0,$60,$7,$1c,$f7,$36,$f8,$bc
	l2072c:	dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$a,$0,$0,$0,$75
		dc.b	$0,$15,$6,$66,$0,$c,$46,$50,$15,$18,$0,$3c,$0,$44,$1,$0
		dc.b	$0,$0,$c1,$4d,$2,$81,$c2,$d,$40,$3,$10,$6e,$0,$0,$0,$0
		dc.b	$f,$38,$16,$44,$f,$38,$e9,$bc,$a,$8c,$34,$bc,$80,$80,$0,$83
		ds.b	4
		dc.b	$c,$c6,$f9,$9d,$0,$4,$6,$ef,$7,$d0,$a,$c1,$1,$d6,$40,$28
		dc.b	$0,$c,$0,$8,$80,$9,$0,$a,$1d,$4c,$7,$8,$11,$94,$8,$ca
		dc.b	$23,$28,$0,$0,$12,$c0,$0,$0,$fa,$24,$8,$ca,$fa,$24,$f7,$36
	l207a0:	dc.b	$0,$42,$0,$1e,$2,$40,$0,$42,$0,$4,$0,$c,$0,$0,$0,$49
		dc.b	$0,$17,$6,$66,$0,$e,$2a,$7b,$5,$dc,$0,$86,$0,$a8,$1,$0
		dc.b	$0,$1e,$1,$0,$0,$e2,$1,$0,$0,$e,$1,$0,$0,$0,$1,$0
		dc.b	$0,$f2,$1,$4,$0,$d6,$1,$4,$0,$b7,$7,$15,$0,$c,$13,$c3
		dc.b	$a,$e,$10,$8e,$4,$4,$10,$8e,$0,$6,$10,$8e,$4,$8,$c2,$d
		dc.b	$40,$1,$10,$6e,$0,$0,$c2,$d,$40,$40,$10,$6e,$0,$2,$0,$6
		dc.b	$2,$14,$10,$8f,$1,$d3,$0,$8f,$c3,$7d,$44,$8f,$c3,$5d,$4,$c3
		dc.b	$c3,$bd,$45,$c3,$0,$d3,$0,$c3,$1e,$e9,$10,$a,$2,$d,$1e,$e9
		dc.b	$11,$b,$2,$d,$0,$0,$80,$80,$0,$83,$0,$0,$80,$80,$0,$83
		dc.b	$0,$2,$80,$80,$0,$84,$4,$4,$80,$80,$0,$84,$0,$6,$80,$80
		dc.b	$0,$84,$4,$8,$50,$80,$0,$0,$6,$63,$fd,$df,$0,$0,$1c,$20
		dc.b	$17,$70,$1c,$3c,$3,$20,$40,$29,$0,$14,$0,$0,$b,$2,$1,$0
		dc.b	$52,$8,$7,$8,$4c,$2c,$8,$ca
	l20868:	dc.b	$0,$66,$0,$1e,$2,$c0,$0,$4a,$0,$20,$0,$a,$0,$0,$0,$75
		dc.b	$0,$15,$6,$66,$0,$c,$75,$30,$75,$30,$0,$b8,$0,$0,$1,$4
		dc.b	$4,$1d,$1,$4,$fc,$1d,$1,$4,$4,$e3,$1,$4,$fc,$e3,$1,$4
		dc.b	$4,$13,$1,$4,$fc,$13,$1,$1d,$4,$13,$1,$1d,$fc,$13,$1,$19
		dc.b	$4,$a,$1,$19,$fc,$a,$1,$3a,$0,$fc,$4,$0,$7f,$0,$0,$2d
		dc.b	$0,$76,$8,$cd,$0,$8c,$4,$7f,$0,$0,$6,$0,$81,$0,$0,$0
		dc.b	$0,$7f,$4,$0,$0,$81,$44,$44,$5,$8,$9,$4,$0,$2,$44,$44
		dc.b	$1,$8,$9,$0,$0,$2,$44,$48,$c,$8,$10,$0,$0,$2,$44,$48
		dc.b	$2,$c,$e,$0,$0,$4,$44,$48,$a,$10,$12,$8,$0,$6,$44,$48
		dc.b	$6,$8,$a,$4,$0,$8,$44,$44,$7,$a,$b,$6,$0,$a,$44,$44
		dc.b	$3,$a,$b,$2,$0,$a,$44,$48,$e,$a,$12,$2,$0,$a,$10,$ae
		dc.b	$14,$14,$10,$ae,$24,$15,$0,$0,$80,$80,$0,$85,$14,$14,$80,$80
		dc.b	$0,$85,$24,$15,$d0,$80,$2,$a,$8,$9,$c,$e,$0,$0
	l20936:	dc.b	$0,$4e,$0,$1e,$1,$80,$0,$36,$0,$1c,$0,$9,$0,$0,$0,$4c
		dc.b	$0,$14,$6,$66,$0,$b,$4c,$9c,$4c,$9c,$0,$a8,$0,$0,$1,$11
		dc.b	$b4,$ff,$1,$23,$c0,$1a,$1,$11,$cb,$37,$1,$11,$35,$c9,$1,$23
		dc.b	$40,$e6,$1,$11,$4c,$1,$0,$0,$8b,$30,$6,$0,$75,$d0,$0,$6d
		dc.b	$e8,$c6,$4,$6d,$18,$3a,$0,$0,$d0,$8b,$4,$0,$30,$75,$40,$c6
		dc.b	$88,$85,$e,$2,$4,$0,$0,$2,$6,$4,$6,$5,$6,$3,$6,$1
		dc.b	$0,$0,$88,$85,$e,$4,$4,$6,$0,$8,$6,$a,$6,$b,$6,$9
		dc.b	$6,$7,$0,$0,$88,$88,$6,$2,$8,$0,$0,$6,$88,$88,$a,$2
		dc.b	$8,$4,$0,$8,$88,$84,$1,$6,$7,$0,$0,$a,$88,$84,$5,$a
		dc.b	$b,$4,$0,$c,$0,$cb,$1,$5e,$14,$1c,$0,$68,$0,$a,$5,$4
		dc.b	$46,$7,$40,$2a,$0,$6,$0,$0,$d0,$80,$2,$4,$6,$7,$8,$9
		dc.b	$a,$c,$0,$0
	l209ea:	dc.b	$0,$e6,$0,$1e,$9,$40,$0,$b2,$0,$38,$0,$a,$0,$0,$0,$75
		dc.b	$0,$15,$6,$66,$0,$c,$75,$30,$75,$30,$2,$a0,$0,$0,$1,$17
		dc.b	$11,$23,$1,$17,$11,$dd,$1,$23,$9,$23,$5,$1,$0,$9,$1,$23
		dc.b	$f7,$23,$5,$1,$0,$5,$1,$17,$ef,$23,$5,$1,$0,$1,$1,$11
		dc.b	$3,$46,$1,$11,$fd,$46,$1,$b,$11,$15,$1,$7,$11,$15,$1,$7
		dc.b	$11,$eb,$1,$b,$11,$eb,$1,$b,$ef,$15,$1,$7,$ef,$15,$1,$7
		dc.b	$ef,$eb,$1,$b,$ef,$eb,$1,$5,$0,$46,$1,$b,$0,$46,$1,$5
		dc.b	$0,$5d,$1,$b,$0,$54,$1,$a,$e,$2a,$1,$9,$d,$2d,$1,$0
		dc.b	$11,$0,$5,$1,$0,$30,$1,$11,$0,$dd,$1,$11,$0,$da,$1,$27
		dc.b	$0,$13,$1,$27,$0,$ed,$1,$27,$0,$0,$1,$23,$0,$e9,$1,$dd
		dc.b	$0,$17,$1,$e3,$0,$dd,$1,$9,$b,$31,$1,$0,$11,$f5,$1,$0
		dc.b	$ef,$f5,$0,$0,$7f,$0,$0,$48,$68,$0,$4,$7f,$0,$0,$8,$48
		dc.b	$98,$0,$c,$0,$81,$0,$2,$0,$0,$81,$10,$0,$0,$7f,$0,$0
		dc.b	$75,$2f,$0,$43,$5f,$31,$10,$71,$0,$38,$c,$43,$a1,$31,$c,$0
		dc.b	$8b,$2f,$0,$0,$0,$7f,$ff,$e6,$44,$44,$1,$2,$3,$0,$0,$2
		dc.b	$44,$48,$4,$2,$6,$0,$0,$4,$44,$48,$8,$6,$a,$4,$0,$6
		dc.b	$44,$48,$c,$a,$e,$8,$0,$8,$44,$44,$d,$e,$f,$c,$0,$a
		dc.b	$0,$8,$1a,$16,$18,$14,$0,$2,$0,$8,$22,$1e,$20,$1c,$0,$a
		dc.b	$22,$25,$12,$c,$4,$2,$0,$6,$6,$a,$6,$e,$6,$f,$6,$b
		dc.b	$6,$7,$6,$3,$0,$0,$3,$d3,$0,$81,$3,$93,$6,$80,$1,$d3
		dc.b	$5,$80,$0,$b3,$4,$80,$0,$6b,$80,$6,$1e,$1,$84,$3,$4,$80
		dc.b	$0,$b4,$4,$80,$0,$6b,$80,$7,$f0,$1,$84,$3,$5,$80,$1,$54
		dc.b	$5,$80,$0,$6b,$80,$2,$f8,$1,$58,$2,$30,$82,$0,$6b,$80,$a
		dc.b	$f8,$1,$58,$2,$32,$82,$f,$b3,$1,$c2,$22,$24,$11,$12,$13,$10
		dc.b	$0,$e,$44,$47,$0,$4,$10,$12,$44,$48,$12,$4,$8,$10,$0,$14
		dc.b	$44,$47,$c,$8,$12,$16,$44,$44,$d,$12,$13,$c,$0,$18,$1,$4b
		dc.b	$80,$10,$44,$44,$1,$10,$11,$0,$0,$10,$fe,$4,$2d,$2e,$2f,$2c
		dc.b	$0,$0,$fe,$2,$44,$45,$6,$d3,$2,$c2,$88,$8a,$9,$c,$4c,$42
		dc.b	$30,$16,$0,$4b,$80,$2,$f,$ee,$0,$46,$0,$4b,$80,$a,$f,$ee
		dc.b	$30,$48,$0,$6,$7,$95,$1,$b3,$0,$c1,$c3,$1d,$c1,$40,$0,$1c
		dc.b	$0,$c3,$47,$6,$10,$ce,$6,$38,$47,$46,$10,$ce,$6,$3a,$47,$86
		dc.b	$10,$ee,$0,$3c,$0,$54,$0,$c1,$11,$e,$0,$3c,$f0,$15,$0,$6
		dc.b	$7,$b5,$1,$73,$0,$c1,$10,$1c,$0,$c3,$47,$26,$10,$ce,$6,$39
		dc.b	$47,$66,$10,$ce,$6,$3b,$47,$a6,$10,$ee,$20,$3d,$0,$54,$0,$c1
		dc.b	$11,$e,$20,$3d,$f0,$15,$4,$8b,$2,$48,$1,$34,$2,$c2,$ff,$e6
		dc.b	$0,$a,$9,$6,$42,$3e,$30,$16,$0,$a,$9,$7,$6a,$40,$30,$16
		dc.b	$45,$26,$0,$d3,$5,$82,$0,$11,$28,$24,$2,$8c,$2,$8e,$4,$44
		dc.b	$4,$44,$0,$d3,$6,$82,$0,$11,$29,$25,$1,$8c,$1,$8e,$4,$44
		dc.b	$4,$44,$0,$d3,$7,$82,$0,$11,$2a,$26,$1,$8c,$1,$8e,$4,$44
		dc.b	$4,$44,$0,$0,$2,$54,$1,$c2,$22,$25,$12,$1a,$4,$0,$0,$4
		dc.b	$6,$8,$6,$c,$6,$d,$6,$9,$6,$5,$6,$1,$0,$0,$1e,$e5
		dc.b	$a,$c,$c,$34,$b,$c,$c,$35,$b,$c,$0,$0,$0,$6,$0,$0
		dc.b	$d0,$80,$2,$4,$5,$6,$7,$8,$9,$a,$c,$e,$10,$12,$13,$14
		dc.b	$15,$16,$17,$18,$0,$0
	l20ca0:	dc.b	$0,$60,$0,$10,$3,$80,$0,$48,$0,$1c,$0,$a,$0,$0,$0,$75
		dc.b	$1,$fc,$9,$f,$1,$fc,$9,$f1,$1,$4,$9,$8,$1,$fc,$f7,$f
		dc.b	$1,$fc,$f7,$f1,$1,$4,$f7,$8,$1,$fc,$0,$ed,$1,$4,$0,$c
		dc.b	$1,$fc,$0,$13,$1,$0,$0,$e3,$1,$0,$0,$8b,$7,$15,$0,$14
		dc.b	$13,$c1,$12,$16,$1,$4,$0,$f7,$0,$81,$0,$0,$0,$0,$7f,$0
		dc.b	$6,$0,$81,$0,$2,$0,$0,$81,$0,$4c,$0,$65,$4,$7f,$0,$0
		dc.b	$4,$cb,$2,$48,$44,$45,$e,$2,$2,$2,$2,$c,$c,$8,$6,$6
		dc.b	$8,$10,$10,$0,$0,$0,$44,$45,$e,$c,$2,$3,$3,$d,$d,$9
		dc.b	$6,$a,$8,$e,$e,$4,$0,$0,$1e,$e5,$e,$8,$2,$2,$2,$c
		dc.b	$c,$8,$6,$9,$8,$d,$d,$3,$0,$0,$0,$5,$e,$a,$2,$a
		dc.b	$a,$e,$e,$4,$6,$0,$8,$10,$10,$6,$0,$0,$f,$ce,$14,$1a
		dc.b	$2,$c,$2,$48,$44,$44,$6,$2,$8,$0,$0,$2,$44,$44,$a,$3
		dc.b	$9,$4,$0,$c,$1e,$e4,$8,$3,$9,$2,$0,$8,$0,$4,$6,$4
		dc.b	$a,$0,$0,$a,$44,$44,$4,$2,$3,$0,$0,$4,$44,$44,$a,$8
		dc.b	$9,$6,$0,$6,$c2,$1d,$81,$40,$c2,$4d,$2,$c2,$c3,$cd,$60,$8e
		dc.b	$c1,$dd,$c2,$8f,$c3,$ed,$c2,$c3,$c1,$d,$c3,$c1,$c1,$7d,$42,$c1
		dc.b	$c1,$5d,$4,$c1,$c1,$bd,$46,$c1,$0,$93,$0,$c1,$0,$6,$1e,$e9
		dc.b	$18,$12,$4,$1a,$0,$0
	l20db6:	dc.b	$0,$48,$0,$10,$2,$40,$0,$34,$0,$18,$0,$7,$0,$0,$0,$5d
		dc.b	$1,$db,$4b,$25,$1,$db,$4b,$db,$1,$25,$4b,$a3,$1,$db,$b5,$25
		dc.b	$1,$db,$b5,$db,$1,$25,$b5,$a3,$1,$db,$0,$c8,$1,$25,$0,$0
		dc.b	$1,$db,$0,$0,$4,$7f,$0,$0,$0,$0,$7f,$0,$6,$0,$81,$0
		dc.b	$2,$b4,$0,$9b,$0,$0,$0,$7f,$3,$6b,$12,$4e,$44,$45,$e,$2
		dc.b	$2,$4,$4,$d,$d,$a,$6,$7,$8,$e,$e,$1,$0,$0,$0,$5
		dc.b	$e,$8,$2,$2,$2,$10,$10,$8,$6,$a,$8,$d,$d,$4,$0,$0
		dc.b	$0,$5,$e,$a,$2,$0,$0,$f,$f,$6,$6,$7,$8,$e,$e,$1
		dc.b	$0,$0,$1,$8c,$12,$4e,$44,$44,$a,$1,$7,$4,$0,$2,$0,$4
		dc.b	$8,$4,$a,$2,$0,$8,$0,$4,$6,$1,$7,$0,$0,$a,$44,$44
		dc.b	$1,$2,$4,$0,$0,$4,$44,$44,$7,$8,$a,$6,$0,$6,$0,$0
	l20e66:	dc.b	$0,$5c,$0,$10,$3,$40,$0,$44,$0,$1c,$0,$b,$0,$0,$0,$57
		dc.b	$1,$fe,$4,$11,$1,$fe,$4,$ef,$1,$2,$4,$e,$1,$fe,$fc,$11
		dc.b	$1,$fe,$fc,$ef,$1,$2,$fc,$e,$1,$fe,$0,$ed,$1,$2,$0,$10
		dc.b	$1,$fe,$0,$13,$1,$0,$0,$ec,$1,$0,$0,$c6,$7,$15,$0,$14
		dc.b	$13,$c3,$12,$16,$4,$7f,$0,$0,$0,$0,$7f,$0,$6,$0,$81,$0
		dc.b	$2,$0,$0,$81,$0,$4c,$0,$65,$4,$7f,$0,$0,$3,$6b,$1,$24
		dc.b	$44,$45,$e,$2,$2,$3,$3,$d,$d,$9,$6,$a,$8,$e,$e,$4
		dc.b	$0,$0,$1e,$e5,$e,$8,$2,$2,$2,$c,$c,$8,$6,$9,$8,$d
		dc.b	$d,$3,$0,$0,$0,$5,$e,$a,$2,$a,$a,$e,$e,$4,$6,$0
		dc.b	$8,$10,$10,$6,$0,$0,$1,$8c,$1,$24,$44,$44,$a,$3,$9,$4
		dc.b	$0,$c,$1e,$e4,$8,$3,$9,$2,$0,$8,$0,$4,$6,$4,$a,$0
		dc.b	$0,$a,$44,$44,$4,$2,$3,$0,$0,$4,$44,$44,$a,$8,$9,$6
		dc.b	$0,$6,$1,$b4,$10,$8f,$1,$73,$0,$8f,$c3,$7d,$44,$8f,$c3,$5d
		dc.b	$4,$c3,$c3,$bd,$45,$c3,$0,$73,$0,$c3,$1e,$e9,$18,$12,$3,$39
		dc.b	$0,$0
	l20f48:	dc.b	$0,$62,$0,$1e,$2,$80,$0,$46,$0,$20,$0,$b,$0,$0,$0,$7e
		dc.b	$0,$16,$6,$66,$0,$d,$7e,$f4,$7e,$f4,$0,$ca,$0,$0,$1,$1d
		dc.b	$6,$44,$1,$44,$6,$1d,$1,$44,$6,$e3,$1,$1d,$6,$bc,$1,$30
		dc.b	$f3,$7e,$1,$7e,$f3,$30,$1,$7e,$f3,$d0,$1,$30,$f3,$82,$1,$3a
		dc.b	$f3,$4e,$1,$3a,$f3,$b2,$0,$0,$7f,$0,$8,$0,$81,$0,$0,$0
		dc.b	$78,$28,$0,$1d,$77,$1d,$2,$28,$78,$0,$4,$1d,$77,$e3,$6,$0
		dc.b	$78,$d8,$ff,$e6,$80,$85,$12,$2,$4,$0,$0,$2,$6,$4,$6,$6
		dc.b	$6,$7,$6,$5,$6,$3,$6,$1,$0,$0,$80,$85,$12,$4,$4,$8
		dc.b	$0,$a,$6,$c,$6,$e,$6,$f,$6,$d,$6,$b,$6,$9,$0,$0
		dc.b	$88,$84,$8,$1,$9,$0,$0,$6,$88,$88,$8,$2,$a,$0,$0,$8
		dc.b	$88,$88,$a,$4,$c,$2,$0,$a,$88,$88,$c,$6,$e,$4,$0,$c
		dc.b	$88,$84,$e,$7,$f,$6,$0,$e,$0,$8b,$80,$4,$88,$82,$10,$12
		dc.b	$88,$82,$11,$13,$0,$0,$3a,$9c,$0,$0,$10,$80,$2,$4,$6,$8
		dc.b	$9,$a,$b,$c,$d,$e,$0,$0
	l21020:	dc.b	$0,$ce,$0,$1e,$7,$40,$0,$92,$0,$40,$0,$f,$0,$0,$0,$64
		dc.b	$0,$1a,$6,$66,$0,$11,$64,$b5,$9,$27,$1,$c2,$1,$d0,$1,$12
		dc.b	$9,$24,$1,$12,$f7,$24,$1,$12,$9,$a5,$1,$12,$f7,$a5,$b,$1
		dc.b	$0,$4,$1,$12,$f7,$e5,$1,$9,$9,$dc,$1,$9,$f7,$dc,$1,$9
		dc.b	$9,$d3,$1,$9,$f7,$d3,$1,$12,$9,$ca,$1,$12,$f7,$ca,$1,$9
		dc.b	$0,$40,$1,$f,$3,$aa,$1,$f,$fd,$aa,$1,$8,$3,$aa,$1,$8
		dc.b	$fd,$aa,$b,$1,$1a,$1f,$b,$1,$1c,$21,$1,$6,$9,$a5,$1,$6
		dc.b	$f7,$a5,$1,$0,$9,$12,$1,$0,$9,$f4,$b,$1,$0,$2,$b,$1
		dc.b	$8,$a,$1,$0,$9,$b7,$1,$0,$f7,$12,$1,$0,$f7,$f4,$1,$0
		dc.b	$f7,$b7,$0,$0,$7f,$0,$2,$0,$81,$0,$14,$7f,$0,$0,$c,$59
		dc.b	$0,$a7,$c,$7f,$0,$0,$10,$59,$0,$59,$4,$0,$0,$81,$0,$78
		dc.b	$0,$28,$0,$0,$78,$28,$2,$0,$88,$28,$6,$0,$59,$a7,$4,$0
		dc.b	$a7,$a7,$4,$8f,$0,$c8,$26,$71,$0,$c8,$26,$8f,$0,$c8,$20,$6
		dc.b	$ff,$1,$ff,$2,$ff,$3,$ff,$4,$ff,$5,$ff,$6,$0,$7,$66,$68
		dc.b	$8,$e,$a,$c,$0,$8,$66,$68,$e,$10,$12,$c,$0,$a,$66,$68
		dc.b	$12,$14,$16,$10,$0,$c,$3,$b,$80,$e,$0,$4,$7,$1c,$1d,$6
		dc.b	$0,$16,$0,$4,$5,$1a,$1b,$4,$0,$18,$1e,$e4,$1b,$1c,$1d,$1a
		dc.b	$0,$0,$0,$8,$6,$1a,$1c,$4,$0,$1a,$0,$8,$1e,$28,$20,$26
		dc.b	$0,$1c,$0,$8,$22,$28,$24,$26,$0,$1e,$66,$67,$0,$2,$18,$10
		dc.b	$66,$64,$1,$18,$19,$0,$0,$12,$66,$64,$3,$18,$19,$2,$0,$14
		dc.b	$66,$68,$16,$4,$6,$14,$0,$6,$66,$68,$8,$2,$a,$0,$0,$6
		dc.b	$66,$65,$1a,$2,$4,$0,$0,$1,$6,$9,$6,$d,$6,$11,$6,$15
		dc.b	$6,$5,$6,$4,$6,$14,$6,$10,$6,$c,$6,$8,$0,$0,$66,$65
		dc.b	$1a,$4,$4,$2,$0,$3,$6,$b,$6,$f,$6,$13,$6,$17,$6,$7
		dc.b	$6,$6,$6,$16,$6,$12,$6,$e,$6,$a,$0,$0,$0,$b,$2,$dc
		dc.b	$0,$cb,$80,$2,$11,$2e,$0,$2a,$11,$2e,$b,$2c,$11,$2e,$0,$32
		dc.b	$0,$cb,$80,$4,$11,$2e,$18,$34,$11,$2e,$13,$36,$11,$2e,$18,$38
		dc.b	$88,$8a,$e,$6,$4a,$2e,$30,$16,$88,$8a,$e,$7,$62,$31,$30,$16
		dc.b	$0,$0,$10,$80,$2,$4,$6,$7,$e,$10,$11,$12,$14,$0,$0,$0
		dc.b	$6,$63,$fd,$df,$0,$1,$3e,$80,$3a,$98,$3e,$ee,$0,$64,$40,$2b
		dc.b	$0,$64,$0,$0,$b,$2,$1,$0,$0,$0,$0,$0,$0,$0,$0,$0
	l21210:	dc.b	$0,$ba,$0,$1e,$7,$80,$0,$96,$0,$28,$0,$c,$0,$0,$0,$75
		dc.b	$0,$16,$6,$66,$0,$e,$75,$30,$75,$30,$2,$7c,$0,$0,$1,$0
		dc.b	$30,$30,$1,$30,$0,$30,$1,$0,$d0,$30,$5,$1,$0,$4,$1,$30
		dc.b	$0,$d0,$5,$1,$0,$0,$1,$30,$30,$0,$5,$1,$0,$d,$1,$e
		dc.b	$6,$30,$1,$e,$fa,$30,$1,$0,$0,$18,$1,$27,$d0,$e,$1,$e
		dc.b	$30,$24,$1,$30,$ed,$29,$1,$0,$55,$0,$1,$0,$24,$30,$1,$0
		dc.b	$dc,$30,$1,$24,$0,$30,$1,$15,$ee,$30,$1,$24,$0,$d0,$1,$e
		dc.b	$2,$c6,$1,$9,$e,$c6,$1,$f4,$fc,$c6,$1,$30,$0,$30,$1,$e
		dc.b	$0,$30,$13,$81,$10,$12,$1,$55,$0,$0,$1,$0,$ab,$0,$1,$19
		dc.b	$18,$30,$1,$19,$e8,$30,$0,$0,$0,$7f,$0,$0,$7f,$0,$4,$0
		dc.b	$81,$0,$2,$7f,$0,$0,$8,$0,$0,$81,$0,$49,$49,$49,$2,$49
		dc.b	$b7,$49,$c,$49,$49,$b7,$8,$49,$b7,$b7,$c1,$d,$1,$81,$2,$8b
		dc.b	$2,$aa,$e2,$86,$0,$30,$1,$8b,$0,$30,$1,$4c,$80,$2,$1,$13
		dc.b	$0,$81,$76,$64,$32,$11,$33,$10,$0,$0,$f0,$a,$a,$0,$7c,$32
		dc.b	$40,$2c,$11,$4e,$80,$14,$12,$11,$13,$10,$a,$4b,$80,$2,$0,$cc
		dc.b	$1,$e8,$0,$94,$0,$81,$dc,$84,$11,$12,$13,$10,$0,$0,$43,$c6
		dc.b	$1,$53,$0,$81,$80,$4,$32,$11,$33,$10,$0,$2,$0,$8b,$1,$e8
		dc.b	$f0,$a,$a,$0,$7c,$32,$40,$2d,$44,$45,$c,$2,$4,$0,$0,$38
		dc.b	$6,$10,$6,$11,$6,$39,$0,$0,$11,$7b,$50,$1e,$d0,$80,$44,$6
		dc.b	$44,$45,$c,$2,$4,$4,$0,$3a,$6,$12,$6,$13,$6,$3b,$0,$0
		dc.b	$11,$7b,$40,$20,$d0,$80,$88,$8a,$a,$2,$64,$24,$30,$22,$44,$46
		dc.b	$44,$45,$c,$2,$4,$2,$0,$3a,$6,$12,$6,$10,$6,$38,$0,$0
		dc.b	$11,$7b,$64,$22,$d0,$80,$44,$66,$44,$45,$c,$2,$4,$3,$0,$3b
		dc.b	$6,$13,$6,$11,$6,$39,$0,$0,$11,$7b,$44,$23,$d0,$80,$1,$14
		dc.b	$0,$81,$64,$46,$0,$23,$f8,$1a,$0,$0,$11,$8e,$c0,$30,$2f,$2e
		dc.b	$7f,$31,$1,$33,$f,$82,$0,$6,$c2,$d,$40,$1,$11,$bb,$0,$34
		dc.b	$d0,$80,$11,$bb,$20,$35,$d0,$80,$1,$33,$10,$82,$0,$6,$c2,$d
		dc.b	$40,$1,$11,$bb,$c,$1c,$d0,$80,$11,$bb,$3c,$36,$d0,$80,$e2,$86
		dc.b	$ff,$f7,$44,$44,$d,$c,$6,$0,$0,$4,$44,$44,$f,$e,$a,$4
		dc.b	$0,$6,$44,$48,$e,$c,$8,$2,$0,$8,$44,$44,$6,$a,$9,$8
		dc.b	$0,$a,$44,$47,$0,$2,$c,$c,$44,$47,$2,$4,$e,$e,$44,$47
		dc.b	$c,$6,$8,$10,$44,$47,$8,$a,$e,$12,$0,$b,$2,$ab,$3,$2b
		dc.b	$80,$a,$c3,$5d,$9,$80,$6,$bc,$0,$c3,$11,$7b,$64,$26,$d0,$80
		dc.b	$11,$7b,$44,$27,$d0,$80,$11,$db,$d,$29,$0,$0,$11,$db,$d,$2a
		dc.b	$0,$0,$11,$db,$d,$2d,$0,$0,$11,$db,$d,$2b,$0,$0,$f,$7b
		dc.b	$6,$29,$22,$22,$1,$8b,$80,$4,$44,$5a,$0,$4,$11,$fb,$28,$18
		dc.b	$f0,$8,$c3,$5d,$9,$80,$10,$3c,$0,$c3,$f,$7b,$6,$18,$42,$22
		dc.b	$0,$ab,$80,$6,$44,$5a,$0,$6,$11,$fb,$2b,$16,$f0,$8,$0,$ab
		dc.b	$80,$8,$44,$5a,$0,$8,$11,$fb,$2c,$1a,$f0,$8,$0,$ab,$80,$9
		dc.b	$44,$5a,$0,$9,$11,$fb,$2c,$1b,$f0,$8,$0,$0,$80,$80,$0,$8a
		dc.b	$0,$14,$10,$80,$2,$4,$6,$8,$9,$a,$c,$e,$10,$12,$d,$f
		dc.b	$11,$13,$0,$d0,$80,$2,$0,$0
	l214a8:	dc.b	$1,$16,$0,$1e,$a,$0,$0,$be,$0,$5c,$0,$d,$0,$0,$0,$7b
		dc.b	$0,$18,$1,$e0,$0,$10,$7b,$4a,$7b,$4a,$5,$2,$0,$0,$1,$25
		dc.b	$74,$18,$1,$62,$47,$18,$1,$7a,$0,$18,$1,$62,$b9,$18,$1,$25
		dc.b	$8c,$18,$1,$20,$62,$18,$1,$53,$3c,$18,$1,$67,$0,$18,$1,$53
		dc.b	$c4,$18,$1,$20,$9e,$18,$1,$25,$74,$e8,$5,$1,$0,$7,$5,$1
		dc.b	$0,$5,$5,$1,$0,$3,$5,$1,$0,$1,$5,$1,$0,$13,$5,$1
		dc.b	$0,$11,$5,$1,$0,$f,$5,$1,$0,$d,$5,$1,$0,$b,$1,$8
		dc.b	$9e,$8,$5,$1,$0,$31,$5,$1,$0,$35,$1,$c,$15,$18,$1,$8
		dc.b	$9e,$f8,$5,$1,$0,$2f,$1,$c,$15,$e8,$5,$1,$0,$29,$1,$0
		dc.b	$78,$0,$1,$0,$88,$0,$1,$18,$0,$18,$5,$1,$0,$3d,$1,$7
		dc.b	$3,$18,$1,$7,$fd,$18,$1,$0,$0,$c,$1,$0,$9,$1d,$1,$0
		dc.b	$f7,$18,$1,$7,$4,$18,$1,$a,$f8,$18,$13,$81,$40,$42,$0,$0
		dc.b	$0,$7f,$14,$0,$0,$81,$a,$0,$81,$0,$a,$b6,$9a,$0,$e,$88
		dc.b	$d9,$0,$e,$88,$27,$0,$12,$b6,$66,$0,$12,$0,$7f,$0,$0,$0
		dc.b	$7f,$0,$0,$4a,$66,$0,$4,$78,$27,$0,$4,$78,$d9,$0,$8,$4a
		dc.b	$9a,$0,$8,$0,$81,$0,$28,$0,$e7,$7c,$2e,$0,$19,$7c,$30,$0
		dc.b	$e7,$84,$34,$0,$19,$84,$28,$7e,$fb,$0,$2e,$7e,$5,$0,$3c,$6d
		dc.b	$3f,$0,$3c,$6d,$c1,$0,$3c,$eb,$47,$86,$e8,$86,$0,$67,$22,$24
		dc.b	$b,$1e,$1f,$a,$0,$6,$22,$28,$c,$1e,$20,$a,$0,$8,$22,$28
		dc.b	$c,$22,$20,$e,$0,$a,$22,$28,$10,$22,$24,$e,$0,$c,$22,$28
		dc.b	$10,$26,$24,$12,$0,$e,$22,$24,$13,$26,$27,$12,$0,$10,$c1,$d
		dc.b	$1,$81,$2,$8b,$1,$ce,$1,$8b,$0,$48,$1,$4c,$80,$2,$1,$13
		dc.b	$0,$81,$76,$64,$4e,$41,$4f,$40,$0,$0,$f0,$a,$a,$0,$7c,$4e
		dc.b	$40,$2e,$11,$4e,$80,$44,$42,$41,$43,$40,$e8,$86,$0,$33,$1a,$cb
		dc.b	$e,$4e,$22,$28,$30,$2c,$32,$28,$0,$26,$22,$28,$34,$2a,$36,$2e
		dc.b	$0,$28,$22,$28,$3e,$2e,$34,$3c,$0,$2a,$22,$28,$3e,$2c,$32,$3c
		dc.b	$0,$2c,$5,$8b,$4,$c5,$1,$2b,$80,$2a,$12,$1c,$0,$40,$83,$5c
		dc.b	$55,$35,$22,$3a,$0,$2a,$11,$fb,$6,$2e,$f0,$8,$1,$2b,$80,$2b
		dc.b	$a,$1c,$0,$40,$83,$5c,$aa,$4a,$22,$3a,$0,$2b,$11,$fb,$6,$3d
		dc.b	$f0,$8,$1,$2b,$80,$2c,$12,$1c,$0,$40,$83,$5c,$aa,$4a,$22,$3a
		dc.b	$0,$2c,$11,$fb,$6,$3c,$f0,$8,$1,$2b,$80,$2d,$a,$1c,$0,$40
		dc.b	$83,$5c,$55,$35,$22,$3a,$0,$2d,$11,$fb,$6,$2d,$f0,$8,$22,$24
		dc.b	$29,$2c,$2d,$28,$0,$1e,$22,$24,$2f,$2a,$2b,$2e,$0,$20,$22,$24
		dc.b	$31,$32,$33,$30,$0,$22,$22,$24,$35,$36,$37,$34,$0,$24,$22,$25
		dc.b	$e,$4,$4,$34,$0,$3e,$6,$32,$6,$33,$6,$3f,$6,$35,$0,$0
		dc.b	$88,$8a,$b,$4,$4c,$35,$40,$2f,$e,$2b,$80,$2,$10,$1a,$0,$0
		dc.b	$1,$b,$2,$92,$0,$d4,$6,$80,$32,$3a,$0,$0,$0,$53,$0,$81
		dc.b	$30,$1a,$0,$0,$0,$cc,$1,$ce,$0,$93,$0,$c1,$dc,$84,$41,$42
		dc.b	$43,$40,$0,$2,$1,$53,$0,$81,$e8,$86,$ff,$f3,$45,$44,$4e,$41
		dc.b	$4f,$40,$0,$2,$f0,$a,$a,$2,$7c,$4e,$40,$30,$6,$8b,$80,$2
		dc.b	$48,$c6,$23,$25,$e,$2,$4,$2e,$0,$3c,$6,$40,$6,$41,$6,$3d
		dc.b	$6,$2f,$0,$0,$0,$cb,$0,$7b,$f0,$a,$8,$2,$64,$4a,$40,$31
		dc.b	$11,$ce,$5,$46,$1,$54,$6,$80,$0,$74,$0,$81,$fe,$e1,$38,$1
		dc.b	$46,$80,$0,$73,$0,$81,$f0,$1,$38,$1,$46,$80,$49,$6,$23,$25
		dc.b	$e,$2,$4,$42,$0,$3c,$6,$2c,$6,$2d,$6,$3d,$6,$43,$0,$0
		dc.b	$1,$4b,$1,$87,$88,$8a,$a,$2,$64,$4c,$30,$22,$0,$8b,$0,$7b
		dc.b	$f0,$a,$8,$2,$64,$42,$40,$32,$0,$6,$23,$25,$8,$2,$4,$3c
		dc.b	$0,$40,$6,$42,$0,$0,$23,$25,$8,$2,$4,$3d,$0,$41,$6,$43
		dc.b	$0,$0,$1,$94,$0,$81,$49,$6,$f8,$1a,$0,$0,$11,$8e,$c0,$42
		dc.b	$2d,$2c,$7f,$43,$48,$c6,$11,$8e,$c0,$40,$2f,$2e,$7f,$41,$10,$1a
		dc.b	$0,$0,$0,$8b,$2,$92,$0,$53,$6,$80,$12,$1a,$0,$0,$ff,$e6
		dc.b	$22,$28,$2,$14,$16,$0,$0,$14,$22,$28,$2,$18,$16,$4,$0,$16
		dc.b	$22,$28,$6,$18,$1a,$4,$0,$18,$22,$28,$6,$1c,$1a,$8,$0,$1a
		dc.b	$23,$24,$1,$14,$15,$0,$0,$12,$23,$24,$9,$1c,$1d,$8,$0,$1c
		dc.b	$d,$b,$7,$a1,$0,$8b,$80,$12,$23,$3a,$0,$12,$11,$ee,$b,$1
		dc.b	$0,$8b,$80,$1c,$23,$3a,$0,$1c,$11,$ee,$1b,$9,$1,$b,$80,$14
		dc.b	$0,$dc,$0,$40,$83,$1c,$cc,$2c,$22,$3a,$0,$14,$11,$ee,$6,$0
		dc.b	$1,$b,$80,$15,$c,$dc,$0,$0,$83,$1c,$33,$53,$22,$3a,$0,$15
		dc.b	$11,$ee,$6,$3,$1,$b,$80,$16,$0,$dc,$0,$40,$83,$1c,$99,$39
		dc.b	$22,$3a,$0,$16,$11,$ee,$6,$2,$1,$b,$80,$17,$c,$dc,$0,$0
		dc.b	$83,$1c,$66,$46,$22,$3a,$0,$17,$11,$ee,$6,$5,$1,$b,$80,$18
		dc.b	$0,$dc,$0,$40,$83,$1c,$66,$46,$22,$3a,$0,$18,$11,$ee,$6,$4
		dc.b	$1,$b,$80,$19,$c,$dc,$0,$0,$83,$1c,$99,$39,$22,$3a,$0,$19
		dc.b	$11,$ee,$6,$7,$1,$b,$80,$1a,$0,$dc,$0,$40,$83,$1c,$33,$53
		dc.b	$22,$3a,$0,$1a,$11,$ee,$6,$6,$1,$b,$80,$1b,$c,$dc,$0,$0
		dc.b	$83,$1c,$cc,$2c,$22,$3a,$0,$1b,$11,$ee,$6,$9,$1,$54,$6,$80
		dc.b	$10,$1a,$0,$0,$0,$4b,$80,$12,$11,$ce,$0,$38,$0,$4b,$80,$1c
		dc.b	$11,$ce,$10,$3a,$22,$25,$2c,$2,$4,$0,$0,$2,$6,$4,$6,$6
		dc.b	$6,$8,$6,$9,$6,$7,$6,$5,$6,$3,$6,$1,$a,$0,$4,$a
		dc.b	$0,$c,$6,$e,$6,$10,$6,$12,$6,$13,$6,$11,$6,$f,$6,$d
		dc.b	$6,$b,$0,$0,$22,$25,$2c,$4,$4,$14,$0,$16,$6,$18,$6,$1a
		dc.b	$6,$1c,$6,$1d,$6,$1b,$6,$19,$6,$17,$6,$15,$a,$0,$4,$1e
		dc.b	$0,$20,$6,$22,$6,$24,$6,$26,$6,$27,$6,$25,$6,$23,$6,$21
		dc.b	$6,$1f,$0,$0,$5,$b,$3,$d1,$2,$4b,$80,$2,$0,$5c,$9a,$79
		dc.b	$11,$6e,$46,$9,$0,$5c,$33,$13,$11,$6e,$46,$6,$0,$5c,$cc,$2c
		dc.b	$11,$6e,$46,$2,$0,$5c,$66,$46,$11,$6e,$46,$1,$11,$6e,$44,$5
		dc.b	$2,$4b,$80,$4,$0,$5c,$9a,$79,$11,$6e,$46,$1d,$0,$5c,$33,$13
		dc.b	$11,$6e,$46,$1a,$0,$5c,$cc,$2c,$11,$6e,$46,$16,$0,$5c,$66,$46
		dc.b	$11,$6e,$46,$15,$11,$6e,$44,$19,$1,$53,$6,$80,$0,$6c,$80,$6
		dc.b	$1e,$1,$e2,$4,$38,$80,$0,$6c,$80,$10,$1e,$1,$e2,$4,$3a,$80
		dc.b	$0,$0,$80,$80,$0,$8a,$0,$44,$10,$80,$2,$4,$12,$14,$15,$16
		dc.b	$17,$18,$19,$1a,$1b,$1c,$0,$50,$80,$28,$8,$e,$a,$6,$c,$26
		dc.b	$10,$0,$50,$80,$29,$9,$f,$b,$6,$d,$27,$10,$0,$d0,$80,$2
		dc.b	$0,$0
	l219da:	dc.b	$0,$38,$0,$10,$2,$80,$0,$38,$0,$4,$0,$d,$0,$0,$0,$3f
		dc.b	$1,$5,$5,$0,$1,$3f,$18,$0,$b,$1,$0,$2,$b,$1,$2,$4
		dc.b	$1,$e,$b,$0,$1,$2e,$16,$0,$1,$9,$d,$0,$1,$37,$1c,$0
		dc.b	$b,$1,$c,$e,$b,$1,$c,$10,$dc,$82,$c,$12,$dc,$82,$10,$e
		dc.b	$dc,$82,$d,$13,$dc,$82,$11,$f,$0,$b,$2,$63,$dc,$82,$0,$4
		dc.b	$dc,$82,$6,$2,$dc,$82,$1,$5,$dc,$82,$7,$3,$0,$b,$1,$cf
		dc.b	$dc,$82,$9,$b,$dc,$82,$8,$a,$0,$0
	l21a44:	dc.b	$0,$28,$0,$10,$0,$c0,$0,$1c,$0,$10,$0,$9,$0,$0,$0,$4e
		dc.b	$1,$f,$b2,$f,$1,$f,$b2,$f1,$1,$0,$0,$0,$2,$7c,$18,$0
		dc.b	$0,$0,$18,$7c,$2,$0,$18,$84,$45,$47,$2,$0,$4,$2,$45,$43
		dc.b	$0,$1,$4,$4,$45,$43,$2,$3,$4,$6,$0,$0
	l21a80:	dc.b	$0,$50,$0,$10,$4,$0,$0,$50,$0,$4,$0,$d,$0,$0,$0,$46
		dc.b	$1,$7,$0,$7,$b,$1,$0,$6,$b,$1,$2,$6,$1,$7,$0,$2e
		dc.b	$1,$1f,$0,$2e,$1,$13,$0,$1b,$1,$1f,$0,$7,$1,$b,$0,$2a
		dc.b	$1,$17,$0,$2a,$1,$b,$0,$42,$1,$17,$0,$42,$1,$f,$0,$3a
		dc.b	$1,$f,$0,$46,$1,$1b,$0,$46,$1,$1b,$0,$3a,$1,$13,$0,$25
		dc.b	$33,$25,$12,$0,$4,$0,$0,$2,$6,$a,$6,$1e,$6,$4,$6,$6
		dc.b	$6,$8,$6,$c,$0,$0,$55,$44,$12,$10,$14,$e,$0,$0,$33,$24
		dc.b	$1c,$18,$1a,$16,$0,$0,$0,$0
	l21af8:	dc.b	$0,$4a,$0,$1e,$1,$80,$0,$36,$0,$18,$0,$b,$0,$0,$0,$44
		dc.b	$0,$16,$6,$66,$0,$d,$44,$5c,$44,$5c,$0,$d8,$0,$0,$1,$1d
		dc.b	$c,$bc,$1,$1d,$f4,$bc,$b,$1,$0,$2,$1,$1d,$0,$30,$13,$81
		dc.b	$0,$2,$1,$1d,$4,$d0,$0,$81,$0,$0,$0,$0,$81,$0,$2,$0
		dc.b	$7f,$0,$0,$0,$0,$7f,$6,$0,$d,$82,$1,$14,$0,$c1,$ba,$a4
		dc.b	$8,$1,$9,$0,$0,$8,$f0,$a,$a,$8,$7c,$8,$40,$33,$dc,$84
		dc.b	$fe,$2,$fc,$0,$0,$2,$dc,$84,$fd,$3,$fb,$1,$0,$3,$98,$84
		dc.b	$fe,$1,$fd,$0,$0,$4,$98,$84,$fc,$3,$fb,$2,$0,$6,$1,$cb
		dc.b	$0,$c2,$76,$7a,$0,$0,$0,$8b,$80,$2,$c2,$d,$b,$82,$12,$4e
		dc.b	$6a,$a,$0,$8b,$80,$3,$c2,$d,$a,$82,$12,$4e,$42,$b,$2,$53
		dc.b	$0,$c1,$ba,$a4,$2,$1,$3,$0,$0,$8,$0,$b,$1,$25,$f0,$a
		dc.b	$a,$8,$7c,$2,$40,$34,$0,$d4,$0,$81,$f0,$1a,$0,$0,$11,$8e
		dc.b	$c0,$7,$4,$5,$7f,$6,$fe,$ea,$a,$6,$41,$fb,$40,$35,$fe,$ea
		dc.b	$a,$4,$71,$fe,$40,$36,$0,$0,$40,$62,$a,$2,$3,$4,$6,$8
		dc.b	$0,$40,$22,$2,$3,$4,$6,$8,$0,$0
	l21be2:	dc.b	$0,$24,$0,$10,$1,$40,$0,$24,$0,$4,$0,$c,$0,$0,$0,$50
		dc.b	$1,$e,$6,$50,$1,$e,$fa,$50,$1,$0,$0,$38,$1,$0,$0,$0
		dc.b	$1,$0,$fa,$3e,$c1,$d,$40,$40,$ff,$e6,$12,$6e,$0,$6,$1,$f3
		dc.b	$1,$84,$40,$6,$76,$64,$2,$1,$3,$0,$0,$0,$f0,$a,$a,$0
		dc.b	$7c,$2,$40,$37,$40,$86,$11,$4e,$80,$4,$2,$1,$3,$0,$0,$0
		dc.b	$40,$86,$c0,$1d,$2,$40,$12,$8e,$0,$8,$0,$0
	l21c3e:	dc.b	$0,$2c,$0,$10,$1,$80,$0,$28,$0,$8,$0,$a,$0,$0,$0,$58
		dc.b	$1,$3a,$18,$58,$1,$3a,$e8,$58,$5,$1,$0,$3,$5,$1,$0,$1
		dc.b	$13,$81,$0,$2,$1,$13,$11,$a8,$0,$0,$0,$81,$ff,$e6,$f0,$4
		dc.b	$8,$1,$9,$0,$0,$2,$fe,$a,$a,$2,$7c,$8,$40,$38,$98,$88
		dc.b	$4,$2,$6,$0,$0,$0,$dc,$84,$5,$6,$7,$4,$0,$0,$ba,$a4
		dc.b	$4,$1,$5,$0,$0,$0,$ba,$a4,$6,$3,$7,$2,$0,$0,$76,$7a
		dc.b	$0,$0,$c2,$d,$e,$82,$12,$4e,$64,$a,$c2,$d,$f,$82,$12,$4e
		dc.b	$64,$b,$0,$0
	l21cb2:	dc.b	$0,$2c,$0,$10,$1,$c0,$0,$2c,$0,$4,$0,$a,$0,$0,$0,$61
		dc.b	$1,$3a,$18,$61,$1,$3a,$e8,$61,$5,$1,$0,$3,$5,$1,$0,$1
		dc.b	$1,$3a,$11,$0,$1,$13,$11,$61,$b,$1,$1,$3,$ff,$e6,$76,$68
		dc.b	$4,$2,$6,$0,$0,$0,$98,$84,$1,$2,$3,$0,$0,$0,$54,$44
		dc.b	$4,$1,$5,$0,$0,$0,$54,$44,$6,$3,$7,$2,$0,$0,$fe,$ea
		dc.b	$b,$0,$4c,$c,$30,$16,$c2,$d,$40,$82,$76,$7a,$0,$0,$12,$4e
		dc.b	$4c,$b,$c2,$d,$1,$82,$12,$4e,$4c,$a,$c2,$d,$2,$82,$12,$4e
		dc.b	$6a,$8,$c2,$d,$3,$82,$12,$4e,$42,$9,$fe,$a,$1a,$0,$42,$7
		dc.b	$40,$39,$fe,$a,$1a,$0,$42,$6,$40,$3a,$fe,$a,$1a,$0,$4c,$3
		dc.b	$40,$3b,$0,$0
	l21d46:	dc.b	$0,$2c,$0,$10,$1,$c0,$0,$2c,$0,$4,$0,$13,$0,$0,$0,$4c
		dc.b	$b,$1,$ff,$fd,$b,$1,$0,$fd,$b,$1,$0,$ff,$b,$1,$2,$fd
		dc.b	$b,$1,$0,$2,$b,$1,$0,$4,$b,$1,$4,$ff,$3,$94,$5,$80
		dc.b	$1,$94,$4,$80,$11,$1,$1,$0,$fd,$80,$11,$1,$1,$0,$fc,$80
		dc.b	$11,$1,$1,$0,$0,$80,$11,$1,$1,$0,$1,$80,$1,$93,$4,$80
		dc.b	$11,$1,$1,$0,$6,$80,$11,$1,$1,$0,$7,$80,$11,$1,$1,$0
		dc.b	$a,$80,$11,$1,$1,$0,$b,$80,$3,$93,$5,$80,$1,$94,$4,$80
		dc.b	$11,$1,$1,$0,$2,$80,$11,$1,$1,$0,$3,$80,$11,$1,$1,$0
		dc.b	$4,$80,$11,$1,$1,$0,$5,$80,$1,$93,$4,$80,$11,$1,$1,$0
		dc.b	$8,$80,$11,$1,$1,$0,$9,$80,$11,$1,$1,$0,$c,$80,$11,$1
		dc.b	$1,$0,$d,$80,$0,$0
	l21dec:	dc.b	$0,$52,$0,$1e,$3,$0,$0,$4e,$0,$8,$0,$10,$0,$0,$0,$5a
		dc.b	$0,$1b,$6,$66,$0,$12,$5a,$ba,$5a,$ba,$0,$a8,$0,$0,$1,$0
		dc.b	$0,$a6,$1,$0,$d6,$a6,$1,$1b,$1b,$a6,$1,$0,$2a,$a6,$1,$1b
		dc.b	$e5,$a6,$1,$2a,$0,$a6,$1,$4f,$0,$a6,$1,$1b,$0,$da,$1,$0
		dc.b	$0,$e9,$1,$0,$0,$fb,$1,$0,$1e,$fe,$1,$0,$e2,$fe,$12,$0
		dc.b	$0,$7e,$0,$d3,$1,$82,$12,$ee,$30,$6,$12,$ce,$23,$4,$12,$ce
		dc.b	$3,$5,$0,$d3,$2,$82,$12,$ee,$0,$2,$12,$ce,$33,$8,$12,$ce
		dc.b	$13,$9,$12,$ee,$14,$a,$12,$ee,$14,$b,$0,$d3,$3,$82,$c2,$d
		dc.b	$40,$1,$11,$ae,$0,$c,$11,$ae,$20,$d,$12,$ce,$c,$e,$12,$ce
		dc.b	$2c,$f,$12,$ee,$3d,$10,$12,$ae,$0,$12,$c2,$d,$40,$1,$11,$ae
		dc.b	$4,$14,$11,$ae,$14,$16,$0,$0,$80,$80,$0,$95,$0,$12,$80,$80
		dc.b	$0,$96,$c,$e,$80,$80,$0,$96,$2c,$f,$80,$80,$0,$97,$3d,$10
		dc.b	$80,$80,$0,$8d,$4,$14,$80,$80,$0,$8d,$14,$16,$80,$80,$0,$97
		dc.b	$14,$a,$80,$80,$0,$97,$14,$b,$a0,$80,$2,$80,$0,$97,$30,$6
		dc.b	$a0,$80,$2,$80,$0,$96,$23,$4,$a0,$80,$2,$80,$0,$96,$3,$5
		dc.b	$a0,$80,$2,$81,$0,$97,$0,$2,$a0,$80,$2,$81,$0,$96,$33,$8
		dc.b	$a0,$80,$2,$81,$0,$96,$13,$9,$a0,$80,$2,$82,$0,$8d,$0,$c
		dc.b	$a0,$80,$2,$82,$0,$8d,$20,$d,$50,$80,$0,$0
	l21f08:	dc.b	$0,$4e,$0,$1e,$1,$80,$0,$36,$0,$1c,$0,$e,$0,$0,$0,$55
		dc.b	$0,$19,$6,$66,$0,$10,$55,$73,$55,$73,$0,$a2,$0,$0,$1,$18
		dc.b	$c3,$ab,$1,$18,$24,$3d,$1,$18,$c3,$dc,$1,$18,$55,$3d,$1,$3
		dc.b	$c3,$c3,$5,$1,$0,$9,$0,$7f,$0,$0,$1,$81,$0,$0,$0,$0
		dc.b	$59,$a7,$4,$0,$a7,$59,$2,$0,$0,$7f,$0,$0,$81,$0,$ff,$e6
		dc.b	$66,$65,$10,$2,$2,$0,$0,$8,$a,$6,$6,$2,$8,$a,$8,$4
		dc.b	$a,$0,$0,$0,$66,$65,$10,$4,$2,$1,$1,$9,$b,$7,$6,$3
		dc.b	$8,$b,$9,$5,$a,$0,$0,$0,$22,$25,$10,$6,$2,$0,$0,$8
		dc.b	$a,$6,$6,$7,$8,$b,$9,$1,$a,$0,$0,$0,$22,$25,$e,$8
		dc.b	$2,$4,$4,$8,$a,$2,$6,$3,$8,$b,$9,$5,$0,$0,$0,$6
		dc.b	$0,$0,$d0,$80,$2,$4,$6,$8,$a,$c,$0,$0
	l21fb4:	dc.b	$0,$a2,$0,$1e,$4,$0,$0,$5e,$0,$48,$0,$f,$0,$0,$0,$49
		dc.b	$0,$1a,$6,$66,$0,$11,$49,$3e,$49,$3e,$1,$b4,$0,$0,$1,$18
		dc.b	$c,$f4,$1,$18,$c,$c,$1,$c,$c,$b7,$1,$c,$c,$49,$5,$1
		dc.b	$0,$3,$5,$1,$0,$1,$5,$1,$0,$7,$1,$c,$f4,$49,$5,$1
		dc.b	$0,$1b,$1,$8,$24,$4,$1,$4,$24,$e8,$5,$1,$0,$1d,$5,$1
		dc.b	$0,$13,$1,$8,$dc,$4,$1,$4,$dc,$e8,$5,$1,$0,$15,$0,$7f
		dc.b	$0,$0,$4,$0,$0,$81,$6,$0,$0,$7f,$0,$7c,$0,$e8,$2,$7c
		dc.b	$0,$18,$2,$69,$46,$0,$4,$0,$71,$c8,$6,$0,$71,$38,$0,$65
		dc.b	$4a,$ec,$2,$65,$4a,$14,$1a,$69,$ba,$0,$1c,$0,$8f,$c8,$e,$0
		dc.b	$8f,$38,$1c,$65,$b6,$ec,$1a,$65,$b6,$14,$14,$0,$7f,$0,$1c,$0
		dc.b	$81,$0,$ff,$e6,$22,$28,$8,$2,$a,$0,$0,$2,$22,$24,$5,$c
		dc.b	$d,$4,$0,$4,$22,$24,$e,$7,$f,$6,$0,$6,$66,$68,$4,$8
		dc.b	$c,$0,$0,$8,$66,$68,$a,$6,$e,$2,$0,$a,$22,$28,$12,$0
		dc.b	$10,$2,$0,$c,$22,$24,$14,$5,$15,$4,$0,$e,$22,$24,$16,$7
		dc.b	$17,$6,$0,$10,$66,$68,$10,$4,$14,$0,$0,$12,$66,$68,$6,$12
		dc.b	$16,$2,$0,$14,$22,$28,$a,$18,$8,$1a,$0,$16,$22,$24,$c,$1d
		dc.b	$d,$1c,$0,$18,$22,$24,$1e,$f,$1f,$e,$0,$1a,$66,$68,$18,$c
		dc.b	$8,$1c,$0,$1c,$66,$68,$1e,$a,$e,$1a,$0,$1e,$66,$65,$12,$20
		dc.b	$4,$10,$0,$14,$6,$15,$6,$11,$6,$13,$6,$17,$6,$16,$6,$12
		dc.b	$0,$0,$66,$65,$12,$22,$4,$18,$0,$1c,$6,$1d,$6,$19,$6,$1b
		dc.b	$6,$1f,$6,$1e,$6,$1a,$0,$0,$6,$4b,$1,$6e,$ba,$7a,$0,$0
		dc.b	$0,$cb,$0,$b6,$dc,$5a,$0,$0,$0,$4b,$0,$5a,$fe,$1a,$0,$0
		dc.b	$1,$b,$80,$8,$d,$1c,$fa,$3b,$83,$3c,$0,$40,$11,$a,$1b,$8
		dc.b	$46,$4,$40,$3c,$1,$b,$80,$a,$19,$1c,$5,$4,$83,$3c,$0,$40
		dc.b	$11,$a,$1b,$a,$46,$2,$40,$3d,$1,$b,$80,$9,$d,$1c,$5,$4
		dc.b	$83,$3c,$0,$40,$11,$a,$1b,$9,$46,$1,$40,$3e,$1,$b,$80,$b
		dc.b	$19,$1c,$fa,$3b,$83,$3c,$0,$40,$11,$a,$1b,$b,$46,$7,$40,$3f
		dc.b	$0,$6,$0,$0,$d0,$80,$2,$4,$6,$3,$20,$22,$8,$9,$a,$b
		dc.b	$c,$d,$e,$10,$12,$13,$14,$15,$16,$17,$18,$1a,$1c,$1d,$1e,$1f
		dc.b	$0,$0
	l22186:	dc.b	$0,$92,$0,$1e,$4,$c0,$0,$6a,$0,$2c,$0,$e,$0,$0,$0,$49
		dc.b	$0,$19,$6,$66,$0,$10,$49,$3e,$49,$3e,$2,$4e,$0,$0,$1,$49
		dc.b	$4,$a,$1,$49,$8,$f6,$1,$49,$f8,$f6,$1,$49,$0,$a,$b,$1
		dc.b	$2,$3,$b,$1,$4,$5,$b,$1,$6,$7,$b,$1,$2,$8,$b,$1
		dc.b	$4,$a,$b,$1,$6,$c,$b,$1,$e,$8,$b,$1,$10,$a,$b,$1
		dc.b	$12,$c,$b,$1,$e,$2,$b,$1,$10,$4,$b,$1,$12,$6,$13,$c3
		dc.b	$6,$7,$1,$49,$a,$fb,$1,$49,$f6,$fb,$2,$0,$0,$81,$2,$0
		dc.b	$76,$2e,$4,$0,$8a,$2e,$2,$7f,$0,$0,$2,$0,$79,$db,$4,$0
		dc.b	$87,$db,$6,$0,$0,$7f,$2,$0,$87,$25,$4,$0,$79,$25,$6,$0
		dc.b	$0,$81,$ff,$e6,$1,$8b,$1,$c8,$22,$24,$22,$3,$23,$2,$0,$10
		dc.b	$22,$24,$24,$5,$25,$4,$0,$12,$22,$24,$0,$7,$1,$6,$0,$14
		dc.b	$10,$b,$7,$26,$32,$3a,$0,$0,$1,$4b,$3,$92,$54,$5a,$0,$0
		dc.b	$0,$cb,$1,$c8,$54,$5a,$0,$0,$0,$4b,$0,$e4,$76,$7a,$0,$0
		dc.b	$1,$2,$2,$4,$1,$2,$4,$6,$1,$2,$6,$2,$1,$2,$8,$a
		dc.b	$1,$2,$a,$c,$1,$2,$c,$8,$1,$2,$e,$10,$1,$2,$10,$12
		dc.b	$1,$2,$12,$e,$1,$2,$14,$16,$1,$2,$16,$18,$1,$2,$18,$14
		dc.b	$1,$2,$1a,$1c,$1,$2,$1c,$1e,$1,$2,$1e,$1a,$1,$2,$3,$5
		dc.b	$1,$2,$5,$7,$1,$2,$7,$3,$1,$2,$f,$11,$1,$2,$11,$13
		dc.b	$1,$2,$13,$f,$1,$2,$15,$17,$1,$2,$17,$19,$1,$2,$19,$15
		dc.b	$1,$2,$1b,$1d,$1,$2,$1d,$1f,$1,$2,$1f,$1b,$7,$4b,$3,$92
		dc.b	$10,$1a,$0,$0,$0,$cb,$1,$c8,$32,$3a,$0,$0,$0,$4b,$0,$e4
		dc.b	$32,$3a,$0,$0,$1,$2,$2,$1c,$1,$2,$1a,$10,$1,$2,$e,$16
		dc.b	$1,$2,$14,$a,$1,$2,$6,$1a,$1,$2,$1e,$e,$1,$2,$12,$14
		dc.b	$1,$2,$18,$8,$1,$2,$4,$1e,$1,$2,$1c,$12,$1,$2,$10,$18
		dc.b	$1,$2,$16,$c,$1,$2,$3,$1d,$1,$2,$1b,$11,$1,$2,$f,$17
		dc.b	$1,$2,$15,$b,$1,$2,$7,$1b,$1,$2,$1f,$f,$1,$2,$13,$15
		dc.b	$1,$2,$19,$9,$1,$2,$5,$1f,$1,$2,$1d,$13,$1,$2,$11,$19
		dc.b	$1,$2,$17,$d,$1,$8c,$1,$c8,$54,$5a,$0,$0,$0,$4b,$7,$26
		dc.b	$76,$7a,$0,$0,$1,$2,$2,$3,$1,$2,$4,$5,$1,$2,$6,$7
		dc.b	$1,$8b,$1,$c8,$88,$84,$22,$3,$23,$2,$0,$a,$88,$84,$24,$5
		dc.b	$25,$4,$0,$c,$88,$84,$0,$7,$1,$6,$0,$e,$5,$b3,$1,$c2
		dc.b	$c4,$5d,$a,$80,$c3,$5d,$1,$c4,$2,$b3,$10,$c4,$20,$c6,$0,$7
		dc.b	$f0,$1,$35,$c,$20,$0,$0,$4b,$80,$e,$60,$c6,$0,$7,$0,$4c
		dc.b	$80,$e,$20,$c6,$0,$7,$fe,$1,$d,$3,$20,$80,$0,$6b,$1,$c8
		dc.b	$6,$1,$71,$2,$6,$0,$2,$14,$10,$c4,$20,$c6,$0,$7,$18,$1
		dc.b	$6a,$18,$6,$0,$0,$4b,$80,$8,$60,$c6,$0,$7,$0,$4c,$80,$8
		dc.b	$20,$c6,$0,$7,$1e,$1,$11,$4,$6,$80,$0,$6,$0,$0,$d0,$80
		dc.b	$2,$4,$6,$8,$9,$0,$0,$0
	l223de:	dc.b	$0,$7a,$0,$1e,$3,$40,$0,$52,$0,$2c,$0,$d,$0,$0,$0,$44
		dc.b	$0,$18,$6,$66,$0,$f,$44,$5c,$44,$5c,$1,$48,$0,$0,$1,$d
		dc.b	$b,$44,$1,$18,$20,$0,$1,$4,$41,$0,$1,$d,$f5,$44,$5,$1
		dc.b	$0,$3,$5,$1,$0,$5,$b,$1,$0,$12,$b,$1,$0,$6,$b,$1
		dc.b	$14,$12,$1,$7,$3,$3d,$1,$7,$fd,$3d,$1,$0,$0,$31,$13,$81
		dc.b	$12,$14,$0,$0,$0,$7f,$0,$0,$b0,$62,$14,$0,$50,$62,$0,$9f
		dc.b	$0,$51,$0,$0,$63,$4e,$6,$0,$9d,$4e,$0,$7d,$0,$14,$0,$67
		dc.b	$40,$25,$6,$67,$c0,$25,$4,$0,$0,$81,$c1,$d,$1,$81,$3,$cb
		dc.b	$3,$d0,$e2,$c6,$0,$18,$1,$8b,$0,$48,$1,$4c,$80,$2,$1,$13
		dc.b	$0,$81,$76,$64,$18,$13,$19,$12,$0,$0,$f0,$a,$a,$0,$7c,$18
		dc.b	$40,$40,$11,$4e,$80,$16,$14,$13,$15,$12,$1,$13,$0,$81,$f0,$4
		dc.b	$18,$13,$19,$12,$0,$2,$f0,$a,$a,$2,$7c,$18,$40,$41,$8,$4b
		dc.b	$e,$4e,$66,$64,$1,$12,$13,$0,$0,$4,$66,$64,$6,$15,$7,$14
		dc.b	$0,$6,$66,$68,$12,$6,$14,$0,$0,$8,$4,$b,$80,$2,$3,$cb
		dc.b	$3,$d,$19,$1c,$0,$20,$83,$3c,$3,$32,$88,$8a,$9,$4,$46,$c
		dc.b	$30,$16,$1,$8b,$0,$f5,$f0,$a,$8,$4,$46,$c,$40,$42,$19,$1c
		dc.b	$0,$20,$83,$3c,$fc,$4d,$f0,$a,$8,$6,$46,$14,$40,$43,$0,$d4
		dc.b	$0,$81,$f8,$1a,$0,$0,$11,$8e,$c0,$10,$f,$e,$7f,$11,$e2,$c6
		dc.b	$ff,$f9,$22,$24,$4,$1,$5,$0,$0,$a,$22,$24,$a,$7,$b,$6
		dc.b	$0,$c,$22,$28,$6,$2,$8,$0,$0,$e,$66,$67,$0,$2,$4,$10
		dc.b	$66,$67,$6,$8,$a,$12,$0,$0,$80,$80,$0,$8a,$0,$16,$50,$80
		dc.b	$4,$6,$8,$9,$0,$d0,$80,$2,$14,$a,$c,$e,$f,$10,$11,$12
		dc.b	$13,$0,$0,$0
	l22542:	dc.b	$0,$9e,$0,$1e,$8,$0,$0,$9e,$0,$4,$0,$11,$0,$0,$0,$4c
		dc.b	$0,$15,$9,$88,$0,$11,$4c,$4b,$4c,$4b,$1,$52,$0,$0,$1,$0
		dc.b	$0,$0,$1,$7,$0,$16,$1,$16,$0,$7,$1,$16,$0,$16,$1,$ea
		dc.b	$0,$16,$1,$1b,$0,$2f,$1,$cb,$0,$0,$1,$1b,$0,$2c,$1,$ce
		dc.b	$0,$3,$1,$44,$0,$35,$1,$b4,$0,$1e,$1,$0,$0,$26,$1,$0
		dc.b	$0,$23,$1,$1e,$0,$1e,$1,$35,$0,$1e,$1,$3d,$0,$26,$1,$3d
		dc.b	$0,$44,$1,$2d,$0,$4c,$1,$1e,$0,$44,$1,$d0,$0,$35,$1,$2f
		dc.b	$0,$6,$1,$27,$0,$0,$1,$30,$0,$fc,$1,$26,$0,$f6,$1,$21
		dc.b	$0,$eb,$1,$2d,$0,$e7,$1,$16,$0,$da,$1,$21,$0,$d7,$1,$24
		dc.b	$0,$df,$1,$12,$0,$d3,$1,$eb,$0,$15,$1,$e8,$0,$18,$c2,$d
		dc.b	$40,$82,$c1,$fd,$7,$c2,$2,$d4,$0,$c1,$41,$6,$0,$85,$20,$0
		dc.b	$2,$a,$a,$16,$16,$3e,$8,$10,$10,$14,$8,$c,$c,$3c,$8,$18
		dc.b	$18,$e,$8,$1a,$1c,$1e,$8,$12,$12,$20,$8,$22,$24,$a,$0,$0
		dc.b	$13,$5b,$b,$8,$42,$22,$ff,$e6,$c1,$4d,$3,$c2,$c1,$fd,$7,$c1
		dc.b	$0,$74,$0,$c1,$13,$7b,$23,$37,$20,$30,$13,$8e,$0,$28,$13,$8e
		dc.b	$0,$2a,$13,$8e,$0,$2c,$13,$8e,$0,$2e,$13,$8e,$0,$30,$13,$8e
		dc.b	$0,$32,$13,$8e,$0,$34,$13,$8e,$0,$36,$13,$8e,$0,$38,$13,$8e
		dc.b	$0,$3a,$13,$ae,$20,$b,$13,$7b,$23,$26,$10,$30,$13,$6e,$20,$1b
		dc.b	$13,$ae,$28,$1d,$13,$ce,$0,$1f,$13,$6e,$20,$13,$13,$ae,$23,$21
		dc.b	$13,$ce,$28,$23,$13,$6e,$0,$25,$13,$e,$0,$0,$13,$ee,$0,$2
		dc.b	$c2,$4d,$1,$83,$13,$ee,$28,$4,$c2,$4d,$2,$82,$13,$ee,$b,$6
		dc.b	$0,$0,$80,$80,$0,$98,$0,$0,$50,$80,$0,$0
	l2269e:	dc.b	$0,$18,$0,$10,$0,$80,$0,$18,$0,$4,$0,$c,$0,$0,$0,$7a
		dc.b	$1,$7a,$0,$7a,$5,$1,$0,$0,$c1,$d,$82,$c2,$0,$53,$2,$c2
		dc.b	$11,$2e,$0,$0,$0,$53,$3,$c2,$14,$e,$b,$2,$14,$e,$28,$3
		dc.b	$0,$0
	l226d0:	dc.b	$0,$56,$0,$1e,$3,$80,$0,$56,$0,$4,$0,$11,$0,$0,$0,$66
		dc.b	$0,$15,$9,$88,$0,$11,$66,$ff,$66,$ff,$0,$ac,$0,$0,$1,$0
		dc.b	$0,$0,$1,$de,$0,$22,$1,$de,$0,$b,$1,$c7,$0,$22,$1,$c7
		dc.b	$0,$b,$1,$c7,$0,$f5,$1,$b0,$0,$f5,$1,$c7,$0,$de,$1,$b0
		dc.b	$0,$de,$1,$19,$0,$d0,$1,$ea,$0,$ba,$1,$12,$0,$a7,$1,$bc
		dc.b	$fe,$66,$1,$22,$fe,$50,$13,$e,$0,$0,$c2,$d,$40,$82,$14,$2e
		dc.b	$28,$2,$c2,$4d,$1,$82,$14,$2e,$23,$4,$c2,$4d,$2,$82,$14,$2e
		dc.b	$b,$6,$c2,$4d,$3,$82,$14,$2e,$0,$8,$0,$b,$e,$4e,$13,$ae
		dc.b	$0,$7,$13,$ce,$0,$9,$13,$6e,$0,$d,$13,$ae,$0,$11,$14,$4e
		dc.b	$0,$f,$0,$b,$8,$a,$c,$ee,$0,$18,$c,$ee,$0,$1a,$c,$ce
		dc.b	$0,$12,$c,$ce,$0,$14,$c,$ce,$0,$16,$0,$0,$80,$80,$0,$98
		dc.b	$0,$0,$50,$80,$0,$0
	l22786:	dc.b	$0,$28,$0,$10,$1,$80,$0,$28,$0,$4,$0,$d,$0,$0,$0,$78
		dc.b	$1,$0,$0,$0,$1,$78,$0,$0,$1,$0,$0,$78,$5,$1,$0,$4
		dc.b	$1,$78,$0,$78,$5,$1,$0,$9,$c1,$d,$40,$83,$14,$e,$28,$0
		dc.b	$0,$53,$2,$c2,$14,$e,$23,$3,$0,$53,$3,$c2,$11,$2e,$0,$2
		dc.b	$0,$54,$3,$c2,$14,$6e,$0,$2,$0,$53,$4,$c2,$11,$2e,$0,$6
		dc.b	$14,$e,$0,$4,$0,$53,$6,$c2,$14,$e,$b,$8,$0,$53,$7,$c2
		dc.b	$14,$e,$0,$9,$0,$53,$8,$c2,$14,$e,$0,$a,$0,$0
	l227f4:	dc.b	$0,$8a,$0,$1e,$6,$c0,$0,$8a,$0,$4,$0,$12,$0,$0,$0,$4c
		dc.b	$0,$15,$9,$88,$0,$12,$4c,$4b,$4c,$4b,$1,$36,$0,$0,$1,$0
		dc.b	$0,$0,$1,$7,$0,$12,$1,$7,$0,$21,$1,$16,$0,$21,$1,$7
		dc.b	$0,$30,$1,$16,$0,$30,$1,$7,$0,$40,$1,$26,$0,$7,$1,$35
		dc.b	$0,$7,$1,$cb,$0,$b4,$1,$c3,$0,$d3,$1,$c7,$0,$d3,$1,$da
		dc.b	$0,$d9,$1,$da,$0,$dc,$1,$b4,$0,$e2,$1,$b7,$0,$e2,$1,$0
		dc.b	$0,$d0,$1,$0,$0,$cd,$1,$7,$0,$b4,$1,$b4,$0,$1e,$1,$35
		dc.b	$0,$c3,$1,$2d,$0,$e2,$1,$f,$0,$e2,$1,$bf,$0,$fc,$1,$c2
		dc.b	$0,$fc,$1,$e2,$0,$41,$1,$c3,$0,$4c,$6,$b,$5,$f4,$c1,$fd
		dc.b	$7,$82,$2,$74,$0,$c1,$e0,$6,$0,$4c,$0,$85,$c,$0,$2,$30
		dc.b	$30,$1e,$16,$12,$8,$14,$1c,$2e,$0,$0,$0,$85,$c,$0,$2,$30
		dc.b	$30,$f,$7,$32,$8,$34,$26,$2e,$0,$0,$0,$6,$c1,$4d,$3,$82
		dc.b	$c1,$fd,$7,$c1,$2,$74,$0,$c1,$e0,$6,$0,$4c,$0,$85,$c,$0
		dc.b	$2,$20,$20,$1a,$1a,$12,$8,$18,$18,$22,$0,$0,$0,$85,$c,$0
		dc.b	$2,$22,$22,$24,$13,$28,$8,$2a,$2c,$20,$0,$0,$0,$6,$c1,$4d
		dc.b	$6,$83,$c1,$fd,$3,$c1,$0,$74,$0,$c1,$13,$7b,$b,$27,$30,$30
		dc.b	$14,$8e,$0,$0,$c2,$d,$40,$82,$14,$ae,$0,$2,$c2,$4d,$1,$82
		dc.b	$14,$ae,$23,$3,$c2,$4d,$2,$82,$14,$ae,$b,$4,$c2,$4d,$3,$82
		dc.b	$14,$ae,$28,$5,$c2,$4d,$4,$82,$14,$ae,$28,$6,$14,$4e,$0,$e
		dc.b	$14,$ce,$0,$10,$0,$0,$80,$80,$0,$a4,$0,$0,$50,$80,$0,$0
	l22934:	dc.b	$0,$2c,$0,$10,$1,$c0,$0,$2c,$0,$4,$0,$e,$0,$0,$0,$5b
		dc.b	$1,$1e,$0,$1e,$1,$5b,$0,$1e,$1,$1e,$0,$5b,$1,$5b,$0,$5b
		dc.b	$5,$1,$0,$1,$5,$1,$0,$3,$5,$1,$0,$5,$c1,$d,$40,$83
		dc.b	$14,$e,$28,$0,$0,$53,$1,$c2,$11,$2e,$23,$1,$14,$e,$0,$2
		dc.b	$0,$53,$2,$c2,$11,$2e,$0,$3,$11,$2e,$23,$4,$0,$53,$3,$c2
		dc.b	$11,$2e,$0,$5,$0,$53,$4,$c2,$14,$e,$0,$6,$0,$53,$5,$c2
		dc.b	$14,$e,$0,$7,$0,$53,$6,$c2,$14,$e,$0,$8,$0,$53,$7,$c2
		dc.b	$14,$e,$0,$9,$0,$53,$8,$c2,$14,$e,$28,$a,$0,$53,$9,$c2
		dc.b	$14,$e,$0,$b,$0,$53,$a,$c2,$14,$e,$23,$c,$0,$53,$b,$c2
		dc.b	$14,$e,$23,$d,$0,$0
	l229ca:	dc.b	$0,$8e,$0,$1e,$7,$0,$0,$8e,$0,$4,$0,$12,$0,$0,$0,$75
		dc.b	$0,$15,$9,$88,$0,$14,$75,$df,$75,$df,$0,$fe,$0,$0,$1,$0
		dc.b	$0,$0,$1,$1a,$0,$18,$1,$d6,$0,$11,$1,$d6,$0,$5c,$1,$f8
		dc.b	$0,$68,$1,$f8,$0,$67,$1,$25,$0,$73,$1,$25,$0,$73,$1,$1e
		dc.b	$0,$2a,$1,$1e,$0,$2a,$1,$18,$0,$5,$1,$18,$0,$5,$1,$31
		dc.b	$0,$eb,$1,$30,$0,$eb,$1,$25,$0,$b8,$1,$25,$0,$b6,$1,$4c
		dc.b	$0,$b8,$1,$4c,$0,$b6,$1,$53,$0,$eb,$1,$63,$0,$eb,$1,$6f
		dc.b	$0,$bd,$1,$5e,$0,$8f,$1,$48,$0,$8f,$1,$6a,$0,$68,$1,$71
		dc.b	$0,$51,$1,$75,$0,$2e,$1,$bf,$0,$4a,$1,$b4,$0,$33,$3,$6b
		dc.b	$8,$f0,$e0,$6,$0,$89,$0,$85,$c,$80,$2,$12,$12,$e,$a,$6
		dc.b	$8,$8,$c,$10,$0,$0,$0,$85,$e,$80,$2,$14,$14,$18,$1c,$20
		dc.b	$6,$22,$8,$1e,$1a,$16,$0,$0,$0,$85,$c,$80,$2,$20,$20,$24
		dc.b	$26,$28,$8,$2a,$2c,$22,$0,$0,$14,$8e,$0,$0,$14,$ee,$0,$2
		dc.b	$0,$b,$7,$26,$c,$ee,$0,$2f,$c,$ee,$0,$31,$0,$b,$5,$5c
		dc.b	$c,$ee,$0,$33,$c,$ee,$0,$34,$c,$fb,$0,$36,$10,$80,$c4,$fd
		dc.b	$f,$83,$0,$74,$0,$c4,$13,$7b,$0,$2e,$40,$80,$0,$0,$80,$80
		dc.b	$0,$a4,$0,$0,$50,$4,$0,$0
	l22ad2:	dc.b	$0,$7a,$0,$1e,$5,$80,$0,$76,$0,$8,$0,$12,$0,$0,$0,$79
		dc.b	$0,$15,$9,$88,$0,$14,$79,$4e,$79,$4e,$0,$ea,$0,$0,$1,$0
		dc.b	$0,$0,$1,$16,$0,$16,$1,$ea,$ff,$5b,$1,$3d,$ff,$79,$1,$72
		dc.b	$ff,$66,$1,$72,$ff,$a5,$1,$32,$ff,$95,$1,$ea,$ff,$bc,$1,$e3
		dc.b	$ff,$c7,$1,$dc,$ff,$b,$1,$f5,$0,$36,$1,$f7,$0,$39,$1,$f5
		dc.b	$0,$3b,$1,$36,$ff,$25,$1,$32,$ff,$f3,$1,$29,$ff,$d7,$1,$22
		dc.b	$0,$39,$1,$22,$0,$38,$1,$1b,$0,$29,$1,$1b,$0,$29,$1,$22
		dc.b	$0,$39,$1,$21,$0,$39,$4,$0,$7f,$0,$e0,$6,$8,$f0,$26,$25
		dc.b	$16,$2,$4,$4,$0,$6,$6,$8,$6,$a,$6,$c,$6,$e,$6,$10
		dc.b	$6,$12,$6,$14,$6,$18,$0,$0,$2,$2b,$8,$7e,$0,$85,$e,$2
		dc.b	$2,$14,$14,$2a,$2a,$26,$6,$24,$8,$28,$28,$18,$0,$0,$0,$85
		dc.b	$c,$2,$2,$14,$14,$22,$22,$1a,$8,$20,$20,$18,$0,$0,$0,$b
		dc.b	$11,$e0,$e0,$6,$0,$e4,$14,$8e,$0,$0,$14,$ee,$0,$2,$0,$b
		dc.b	$7,$26,$13,$5b,$23,$16,$52,$22,$c,$ee,$23,$1a,$c,$ee,$b,$1c
		dc.b	$0,$3c,$0,$70,$c,$ee,$6,$1e,$0,$0,$80,$80,$0,$a4,$0,$0
		dc.b	$50,$80,$0,$0
	l22bc6:	dc.b	$0,$b0,$0,$10,$a,$0,$0,$b0,$0,$4,$0,$10,$0,$0,$0,$63
		dc.b	$1,$7,$0,$7,$1,$16,$0,$7,$1,$26,$0,$7,$1,$35,$0,$7
		dc.b	$1,$7,$0,$16,$1,$16,$0,$16,$1,$26,$0,$16,$1,$35,$0,$16
		dc.b	$1,$7,$0,$26,$1,$16,$0,$26,$1,$26,$0,$26,$1,$7,$0,$35
		dc.b	$1,$16,$0,$35,$1,$16,$0,$44,$5,$1,$0,$1,$5,$1,$0,$3
		dc.b	$5,$1,$0,$5,$5,$1,$0,$7,$5,$1,$0,$9,$5,$1,$0,$b
		dc.b	$5,$1,$0,$d,$5,$1,$0,$11,$5,$1,$0,$13,$5,$1,$0,$15
		dc.b	$5,$1,$0,$17,$5,$1,$0,$19,$1,$26,$0,$cb,$1,$7,$0,$bc
		dc.b	$5,$1,$0,$1b,$1,$cb,$0,$da,$1,$da,$0,$bc,$1,$da,$0,$ad
		dc.b	$1,$bc,$0,$da,$1,$ad,$0,$da,$1,$cb,$0,$9d,$1,$bc,$0,$cb
		dc.b	$1,$ad,$0,$cb,$1,$cb,$0,$cb,$1,$cb,$0,$bc,$1,$cb,$0,$ad
		dc.b	$1,$8c,$2,$fa,$54,$45,$12,$0,$4,$1a,$0,$e,$6,$22,$6,$34
		dc.b	$6,$35,$6,$23,$6,$f,$6,$1b,$0,$0,$0,$0,$c2,$d,$40,$82
		dc.b	$c1,$d,$40,$83,$e0,$6,$0,$5b,$5,$eb,$1,$7c,$15,$e,$b,$1a
		dc.b	$15,$2e,$b,$18,$15,$e,$0,$16,$15,$2e,$23,$17,$15,$2e,$b,$11
		dc.b	$15,$2e,$23,$13,$15,$e,$b,$b,$15,$2e,$28,$3,$15,$2e,$0,$1
		dc.b	$15,$2e,$b,$1d,$15,$2e,$23,$1f,$15,$e,$23,$27,$15,$2e,$28,$2d
		dc.b	$15,$e,$0,$2b,$15,$2e,$b,$2a,$15,$2e,$23,$24,$15,$2e,$0,$26
		dc.b	$15,$e,$23,$2c,$15,$2e,$b,$32,$15,$2e,$23,$30,$15,$2e,$b,$36
		dc.b	$15,$2e,$23,$37,$0,$6,$15,$4e,$0,$25,$14,$6e,$23,$0,$14,$6e
		dc.b	$b,$1c,$14,$e,$0,$8,$14,$e,$23,$9,$14,$e,$0,$a,$11,$2e
		dc.b	$0,$2,$14,$e,$0,$1e,$14,$e,$28,$20,$14,$e,$b,$21,$14,$e
		dc.b	$23,$4,$14,$e,$0,$5,$14,$e,$28,$c,$14,$e,$23,$d,$0,$53
		dc.b	$1,$c2,$14,$e,$b,$14,$0,$53,$2,$c2,$14,$e,$0,$15,$14,$e
		dc.b	$28,$12,$14,$e,$0,$10,$0,$53,$3,$c2,$11,$2e,$0,$38,$11,$2e
		dc.b	$23,$39,$14,$e,$28,$33,$0,$53,$5,$c2,$14,$e,$23,$34,$14,$e
		dc.b	$b,$35,$0,$53,$7,$c2,$14,$e,$28,$2e,$14,$e,$0,$2f,$0,$53
		dc.b	$9,$c2,$14,$e,$23,$29,$0,$53,$a,$c2,$14,$e,$28,$22,$0,$53
		dc.b	$b,$c2,$14,$e,$0,$23,$0,$53,$c,$c2,$11,$2e,$28,$6,$0,$53
		dc.b	$d,$c2,$11,$2e,$23,$7,$0,$53,$e,$c2,$11,$2e,$0,$e,$0,$53
		dc.b	$f,$c2,$11,$2e,$b,$f,$0,$53,$10,$c2,$14,$e,$28,$1b,$0,$53
		dc.b	$4,$c2,$14,$e,$0,$3a,$14,$e,$0,$3c,$14,$e,$b,$3e,$14,$e
		dc.b	$28,$40,$14,$e,$23,$42,$14,$e,$0,$44,$14,$e,$b,$46,$14,$e
		dc.b	$28,$48,$14,$e,$23,$4a,$0,$53,$6,$c2,$14,$e,$28,$4c,$0,$53
		dc.b	$8,$c2,$14,$e,$23,$4e,$0,$0
	l22dee:	dc.b	$0,$14,$0,$10,$0,$40,$0,$14,$0,$4,$0,$c,$0,$0,$0,$44
		dc.b	$1,$0,$0,$0,$c2,$fd,$7,$c2,$0,$74,$0,$c2,$15,$6e,$0,$ff
		dc.b	$0,$0,$c2,$1d,$1,$c2,$0,$74,$0,$c2,$15,$8e,$0,$ff,$0,$0
		dc.b	$c2,$1d,$1,$c2,$0,$74,$0,$c2,$15,$ae,$0,$ff,$0,$0,$c2,$1d
		dc.b	$1,$c2,$0,$74,$0,$c2,$15,$ce,$0,$ff,$0,$0,$c2,$1d,$1,$c2
		dc.b	$0,$74,$0,$c2,$15,$ee,$0,$ff,$0,$0,$c2,$1d,$1,$c2,$0,$74
		dc.b	$0,$c2,$16,$e,$0,$ff,$0,$0,$c2,$1d,$1,$c2,$0,$74,$0,$c2
		dc.b	$16,$2e,$0,$ff,$0,$0,$c2,$1d,$1,$c2,$0,$74,$0,$c2,$16,$e
		dc.b	$0,$ff,$0,$0,$c2,$1d,$1,$c2,$0,$0
	l22e78:	dc.b	$0,$28,$0,$10,$1,$80,$0,$28,$0,$4,$0,$f,$0,$0,$0,$5b
		dc.b	$1,$1e,$0,$1e,$1,$5b,$0,$1e,$1,$1e,$0,$5b,$5,$1,$0,$1
		dc.b	$5,$1,$0,$3,$5,$1,$0,$5,$14,$4e,$0,$0,$14,$ce,$28,$2
		dc.b	$14,$4e,$b,$4,$14,$ce,$23,$6,$14,$4e,$0,$8,$14,$ce,$28,$a
		dc.b	$14,$4e,$b,$1,$14,$ce,$23,$3,$14,$4e,$0,$5,$14,$ce,$28,$7
		dc.b	$14,$4e,$b,$9,$14,$ce,$23,$b,$0,$0
	l22ed2:	dc.b	$0,$2e,$0,$1e,$1,$0,$0,$2e,$0,$4,$0,$10,$0,$0,$0,$44
		dc.b	$0,$17,$6,$66,$0,$12,$44,$aa,$44,$aa,$0,$54,$0,$0,$1,$0
		dc.b	$0,$0,$1,$b,$0,$f3,$1,$6,$0,$1b,$1,$20,$0,$44,$16,$6e
		dc.b	$0,$0,$16,$9b,$0,$2,$34,$44,$16,$9b,$0,$3,$44,$44,$c1,$d
		dc.b	$40,$5,$16,$bb,$0,$5,$1c,$44,$c1,$d,$40,$6,$16,$bb,$0,$6
		dc.b	$1c,$44,$0,$0,$80,$80,$0,$b3,$0,$0,$50,$80,$0,$0
	l22f30:	dc.b	$0,$42,$0,$1e,$2,$40,$0,$42,$0,$4,$0,$10,$0,$0,$0,$7a
		dc.b	$0,$15,$9,$88,$0,$10,$7a,$12,$7a,$12,$0,$a4,$0,$0,$1,$0
		dc.b	$0,$0,$1,$f,$0,$2d,$1,$15,$0,$55,$1,$2d,$0,$f,$1,$6a
		dc.b	$0,$a5,$1,$4c,$0,$f1,$1,$7a,$0,$f,$1,$5b,$0,$3d,$1,$1e
		dc.b	$12,$4c,$12,$8e,$0,$0,$16,$9b,$0,$2,$64,$44,$16,$9b,$0,$3
		dc.b	$44,$44,$c1,$d,$40,$4,$16,$bb,$0,$4,$44,$44,$16,$9b,$0,$6
		dc.b	$54,$44,$c,$bb,$0,$8,$50,$0,$d,$1b,$0,$9,$1,$11,$c,$bb
		dc.b	$0,$a,$0,$0,$c,$bb,$0,$b,$33,$33,$c,$bb,$0,$c,$20,$0
		dc.b	$16,$db,$0,$d,$43,$33,$c,$bb,$0,$e,$40,$0,$c,$bb,$0,$f
		dc.b	$23,$33,$0,$d3,$a,$82,$c2,$d,$40,$1,$11,$ae,$2,$10,$11,$ae
		dc.b	$2,$11,$0,$0,$80,$80,$0,$94,$0,$0,$a0,$80,$2,$89,$0,$8d
		dc.b	$2,$10,$a0,$80,$2,$89,$0,$8d,$2,$11,$50,$80,$0,$0,$0,$4e
		dc.b	$0,$1e,$3,$0,$0,$4e,$0,$4,$0,$11,$0,$0,$0,$5b,$0,$16
		dc.b	$9,$88,$0,$11,$5b,$8d,$5b,$8d,$0,$e8,$0,$0,$1,$0,$0,$0
		dc.b	$1,$22,$0,$b,$1,$24,$0,$22,$1,$c,$0,$29,$1,$16,$0,$39
		dc.b	$1,$22,$0,$de,$1,$50,$0,$6,$1,$44,$0,$50,$1,$29,$0,$b0
		dc.b	$1,$a5,$0,$d3,$1,$b,$9,$ea,$1,$22,$9,$ea,$12,$8e,$0,$0
		dc.b	$16,$9b,$0,$2,$64,$44,$16,$9b,$0,$3,$44,$44,$1,$53,$a,$82
		dc.b	$c2,$d,$40,$1,$11,$ae,$2,$14,$11,$ae,$2,$15,$11,$ae,$2,$16
		dc.b	$11,$ae,$2,$17,$0,$b,$23,$c2,$c1,$d,$40,$5,$16,$bb,$0,$4
		dc.b	$1c,$44,$c1,$d,$40,$6,$16,$bb,$0,$5,$1c,$44,$16,$9b,$0,$6
		dc.b	$64,$44,$16,$9b,$0,$7,$64,$44,$16,$9b,$0,$8,$44,$44,$16,$9b
		dc.b	$0,$9,$54,$44,$1,$33,$5,$82,$c,$bb,$0,$a,$52,$20,$c,$bb
		dc.b	$0,$b,$32,$20,$c,$bb,$0,$c,$52,$20,$14,$4e,$0,$d,$c,$bb
		dc.b	$0,$e,$52,$20,$0,$3c,$0,$30,$d,$1b,$6,$f,$2,$20,$1,$33
		dc.b	$7,$82,$16,$fb,$0,$10,$52,$20,$c,$bb,$b,$11,$52,$20,$c,$bb
		dc.b	$0,$12,$22,$20,$0,$0,$80,$80,$0,$94,$0,$0,$a0,$80,$2,$89
		dc.b	$0,$8d,$2,$14,$a0,$80,$2,$89,$0,$8d,$2,$15,$a0,$80,$2,$89
		dc.b	$0,$8d,$2,$16,$a0,$80,$2,$89,$0,$8d,$2,$17,$50,$80,$0,$0
		dc.b	$0,$56,$0,$1e,$3,$80,$0,$56,$0,$4,$0,$12,$0,$0,$0,$44
		dc.b	$0,$16,$9,$88,$0,$13,$44,$aa,$44,$aa,$0,$c4,$0,$0,$1,$0
		dc.b	$0,$0,$1,$9,$0,$16,$1,$18,$0,$7,$1,$f,$0,$f6,$1,$6
		dc.b	$0,$e2,$1,$3,$0,$f0,$1,$2d,$0,$6,$1,$3d,$0,$cb,$1,$0
		dc.b	$0,$c3,$1,$2d,$0,$ea,$1,$39,$0,$21,$1,$19,$0,$29,$1,$36
		dc.b	$0,$40,$1,$fa,$0,$44,$12,$8e,$0,$0,$16,$9b,$0,$2,$74,$44
		dc.b	$16,$9b,$0,$3,$44,$44,$c1,$d,$40,$5,$16,$bb,$0,$4,$1c,$44
		dc.b	$c1,$d,$40,$6,$16,$bb,$0,$5,$1c,$44,$16,$9b,$0,$6,$64,$44
		dc.b	$c1,$d,$40,$4,$16,$bb,$0,$8,$1c,$44,$11,$2e,$0,$9,$14,$4e
		dc.b	$0,$a,$14,$ce,$0,$b,$17,$e,$0,$c,$16,$db,$0,$d,$52,$20
		dc.b	$0,$3c,$0,$c,$d,$1b,$6,$e,$2,$20,$d,$1b,$0,$f,$12,$20
		dc.b	$c,$bb,$0,$12,$52,$20,$c,$bb,$0,$16,$62,$20,$c,$bb,$0,$19
		dc.b	$12,$20,$0,$0,$80,$80,$0,$94,$0,$0,$50,$80,$0,$0,$0,$18
		dc.b	$0,$10,$0,$80,$0,$18,$0,$4,$0,$d,$0,$0,$0,$7a,$1,$7a
		dc.b	$0,$7a,$5,$1,$0,$1,$14,$4e,$0,$0,$14,$ce,$b,$1,$14,$ce
		dc.b	$28,$2,$14,$ce,$23,$3,$0,$0,$0,$4a,$0,$1e,$2,$c0,$0,$4a
		dc.b	$0,$4,$0,$12,$0,$0,$0,$66,$0,$15,$9,$88,$0,$13,$66,$ff
		dc.b	$66,$ff,$0,$b8,$0,$0,$1,$0,$0,$0,$1,$1b,$0,$1b,$1,$5b
		dc.b	$0,$5b,$1,$39,$0,$66,$1,$4,$0,$5b,$1,$3d,$0,$f5,$1,$50
		dc.b	$0,$d3,$1,$16,$0,$d7,$1,$b,$0,$de,$1,$44,$0,$a5,$1,$12
		dc.b	$0,$aa,$16,$db,$0,$4,$52,$22,$c,$bb,$b,$5,$72,$22,$16,$fb
		dc.b	$0,$6,$40,$0,$c,$bb,$23,$7,$52,$22,$0,$b,$8,$f0,$12,$8e
		dc.b	$0,$0,$17,$2e,$0,$2,$16,$4e,$0,$3,$0,$3c,$0,$38,$d,$1b
		dc.b	$6,$8,$1,$11,$c,$bb,$0,$a,$40,$0,$c,$bb,$0,$b,$52,$22
		dc.b	$c,$bb,$23,$c,$40,$0,$c,$bb,$28,$d,$52,$22,$c1,$d,$40,$6
		dc.b	$16,$bb,$0,$e,$1c,$44,$16,$bb,$0,$11,$1c,$44,$16,$fb,$28,$12
		dc.b	$40,$0,$c,$bb,$0,$14,$52,$22,$16,$9b,$0,$10,$42,$22,$0,$0
		dc.b	$80,$80,$0,$94,$0,$0,$50,$80,$0,$0,$0,$44,$0,$10,$3,$40
		dc.b	$0,$44,$0,$4,$0,$10,$0,$0,$0,$66,$1,$0,$0,$0,$1,$16
		dc.b	$0,$22,$1,$2d,$0,$12,$1,$44,$0,$2d,$1,$b,$0,$39,$5,$1
		dc.b	$0,$5,$5,$1,$0,$2,$1,$fc,$0,$c7,$1,$66,$0,$b,$1,$5b
		dc.b	$0,$b,$5,$1,$0,$11,$5,$1,$0,$13,$1,$a5,$0,$ea,$16,$9b
		dc.b	$0,$0,$64,$44,$c1,$d,$40,$6,$16,$bb,$0,$7,$1c,$44,$16,$9b
		dc.b	$0,$a,$64,$44,$0,$b,$4,$79,$16,$9b,$0,$2,$54,$44,$16,$9b
		dc.b	$0,$3,$54,$44,$16,$9b,$0,$4,$54,$44,$16,$9b,$0,$6,$54,$44
		dc.b	$16,$9b,$0,$e,$54,$44,$0,$b,$2,$3,$16,$9b,$0,$5,$44,$44
		dc.b	$16,$9b,$0,$8,$44,$44,$16,$9b,$0,$9,$44,$44,$16,$9b,$0,$c
		dc.b	$44,$44,$c1,$d,$40,$4,$16,$bb,$0,$10,$1c,$44,$16,$bb,$0,$11
		dc.b	$1c,$44,$16,$bb,$0,$12,$1c,$44,$16,$bb,$0,$13,$1c,$44,$16,$bb
		dc.b	$0,$14,$1c,$44,$16,$bb,$0,$15,$1c,$44,$16,$bb,$0,$16,$1c,$44
		dc.b	$16,$bb,$0,$17,$1c,$44,$16,$bb,$0,$18,$1c,$44,$0,$0,$0,$4a
		dc.b	$0,$1e,$2,$80,$0,$46,$0,$8,$0,$f,$0,$0,$0,$4c,$0,$15
		dc.b	$9,$88,$0,$12,$4c,$4b,$4c,$4b,$0,$c6,$0,$0,$1,$2d,$24,$f1
		dc.b	$1,$f,$0,$2d,$1,$9,$0,$bd,$1,$2d,$0,$f,$1,$f,$0,$d3
		dc.b	$1,$f,$0,$f1,$1,$2d,$24,$f,$1,$2d,$24,$d3,$1,$2d,$24,$b4
		dc.b	$1,$33,$0,$d3,$2,$0,$7f,$0,$16,$9b,$0,$2,$54,$44,$16,$9b
		dc.b	$0,$3,$44,$44,$16,$9b,$0,$6,$44,$44,$11,$2e,$0,$8,$11,$2e
		dc.b	$0,$9,$11,$2e,$0,$a,$c2,$1d,$1,$40,$17,$4e,$0,$12,$c2,$d
		dc.b	$40,$40,$11,$ae,$2,$d,$11,$ae,$2,$f,$11,$ae,$2,$1,$0,$53
		dc.b	$9,$82,$11,$ae,$2,$11,$0,$53,$a,$82,$11,$ae,$2,$10,$41,$66
		dc.b	$88,$8a,$f,$2,$69,$b,$30,$16,$c3,$5d,$7,$80,$0,$3c,$0,$c3
		dc.b	$c4,$d,$8,$40,$f,$7b,$6,$b,$48,$80,$40,$86,$c3,$5d,$a,$80
		dc.b	$0,$3c,$0,$c3,$f,$7b,$6,$4,$70,$80,$40,$a6,$f,$7b,$6,$5
		dc.b	$70,$80,$0,$0,$80,$80,$0,$8d,$2,$d,$80,$80,$0,$8d,$2,$f
		dc.b	$80,$80,$0,$8d,$2,$1,$a0,$80,$2,$88,$0,$8d,$2,$11,$a0,$80
		dc.b	$2,$89,$0,$8d,$2,$10,$50,$80,$0,$0,$0,$26,$0,$1e,$0,$80
		dc.b	$0,$26,$0,$4,$0,$f,$0,$0,$0,$7a,$0,$15,$9,$88,$0,$12
		dc.b	$7a,$12,$7a,$12,$0,$40,$0,$0,$1,$0,$0,$0,$1,$21,$0,$86
		dc.b	$6,$ee,$0,$0,$40,$46,$c3,$5d,$5,$80,$0,$3c,$0,$c3,$c4,$d
		dc.b	$9,$40,$f,$7b,$6,$2,$48,$80,$0,$0,$80,$80,$0,$37,$0,$0
		dc.b	$0,$0,$0,$26,$0,$1e,$0,$80,$0,$26,$0,$4,$0,$f,$0,$0
		dc.b	$0,$61,$0,$15,$9,$88,$0,$12,$61,$a8,$61,$a8,$0,$3e,$0,$0
		dc.b	$1,$0,$0,$0,$1,$24,$0,$9f,$6,$ee,$0,$0,$0,$6,$c1,$d
		dc.b	$40,$4,$16,$bb,$0,$2,$44,$44,$16,$bb,$0,$3,$44,$44,$0,$0
		dc.b	$80,$80,$0,$37,$0,$0,$0,$0,$0,$26,$0,$1e,$0,$80,$0,$26
		dc.b	$0,$4,$0,$f,$0,$0,$0,$61,$0,$15,$9,$88,$0,$12,$61,$a8
		dc.b	$61,$a8,$0,$36,$0,$0,$1,$0,$0,$0,$1,$9,$1,$9f,$6,$ee
		dc.b	$0,$0,$0,$6,$4,$ee,$0,$2,$4,$ee,$30,$3,$0,$0,$80,$80
		dc.b	$0,$37,$0,$0,$0,$0,$0,$46,$0,$1e,$2,$80,$0,$46,$0,$4
		dc.b	$0,$13,$0,$0,$0,$7c,$0,$14,$6,$66,$0,$15,$7c,$28,$7c,$28
		ds.b	4
		dc.b	$1,$1e,$e9,$75,$1,$12,$f2,$1f,$1,$2d,$9f,$da,$1,$21,$5,$e7
		dc.b	$1,$2e,$cc,$e3,$1,$56,$46,$16,$1,$22,$ec,$d1,$1,$1a,$f0,$6
		dc.b	$1,$18,$11,$5,$1,$40,$24,$b0,$ff,$c6,$1,$c,$0,$c8,$98,$98
		dc.b	$0,$40,$0,$2,$4,$6,$1,$3,$5,$7,$7f,$7f,$0,$0,$1,$cc
		dc.b	$0,$8e,$ba,$b8,$0,$40,$0,$2,$4,$6,$1,$3,$5,$7,$7f,$7f
		dc.b	$98,$98,$0,$40,$8,$a,$c,$9,$b,$d,$7f,$7f,$0,$0,$1,$ec
		dc.b	$0,$38,$dc,$d8,$0,$40,$0,$2,$4,$6,$1,$3,$5,$7,$7f,$7f
		dc.b	$ba,$b8,$0,$40,$8,$a,$c,$e,$9,$b,$d,$f,$7f,$7f,$0,$0
		dc.b	$98,$98,$1,$40,$0,$2,$4,$6,$1,$3,$5,$7,$7f,$7f,$dc,$d8
		dc.b	$0,$40,$0,$2,$4,$6,$8,$a,$c,$e,$1,$3,$5,$7,$9,$b
		dc.b	$7f,$7f,$ba,$b8,$0,$40,$10,$12,$d,$f,$11,$13,$7f,$7f,$0,$0
		dc.b	$0,$c2,$0,$1e,$7,$c0,$0,$9a,$0,$2c,$0,$7,$0,$0,$0,$61
		dc.b	$0,$1b,$f,$e0,$0,$e,$30,$d4,$21,$34,$1,$56,$1,$60,$1,$29
		dc.b	$13,$29,$1,$29,$13,$d7,$1,$29,$ed,$29,$5,$1,$0,$1,$1,$0
		dc.b	$13,$13,$1,$13,$13,$0,$1,$0,$13,$ed,$1,$0,$61,$0,$13,$81
		dc.b	$36,$e,$1,$1b,$13,$1e,$1,$1b,$49,$1e,$13,$81,$12,$14,$1,$e5
		dc.b	$30,$1e,$13,$81,$13,$18,$1,$0,$13,$29,$1,$9,$0,$29,$1,$0
		dc.b	$ed,$61,$13,$81,$38,$20,$1,$0,$13,$d7,$1,$9,$0,$d7,$1,$0
		dc.b	$ed,$9f,$13,$81,$3c,$28,$1,$29,$0,$9,$1,$29,$13,$0,$1,$29
		dc.b	$0,$f7,$1,$61,$ed,$0,$13,$81,$3a,$32,$1,$0,$13,$0,$1,$0
		dc.b	$0,$29,$1,$29,$0,$0,$5,$1,$0,$38,$0,$0,$7f,$0,$0,$7f
		ds.b	5
		dc.b	$7f,$2,$0,$0,$81,$24,$65,$32,$c8,$8,$0,$7e,$0,$c,$0,$7e
		dc.b	$0,$1c,$6c,$36,$24,$2c,$44,$d1,$a1,$30,$44,$2f,$a1,$ff,$e6,$60
		dc.b	$4,$1,$2,$3,$0,$0,$2,$88,$8,$4,$2,$6,$0,$0,$4,$88
		dc.b	$4,$1,$4,$5,$0,$0,$6,$88,$4,$3,$6,$7,$2,$0,$8,$1
		dc.b	$b,$6,$1a,$0,$a,$7,$6,$64,$0,$40,$44,$0,$a,$7,$8,$4c
		dc.b	$3,$40,$45,$0,$13,$0,$81,$42,$6,$88,$7,$8,$a,$10,$c,$88
		dc.b	$7,$c,$a,$10,$e,$0,$73,$4,$80,$fe,$1,$88,$13,$10,$80,$44
		dc.b	$6,$60,$7,$1c,$1e,$22,$10,$46,$46,$60,$3,$2c,$2e,$34,$12,$60
		dc.b	$3,$30,$2e,$34,$14,$46,$66,$60,$3,$2d,$2f,$35,$13,$60,$3,$31
		dc.b	$2f,$35,$15,$45,$6,$60,$7,$24,$26,$2a,$a,$43,$6,$60,$11,$1a
		dc.b	$13,$5,$2,$5,$82,$0,$0,$6,$0,$42,$86,$88,$2,$12,$16,$0
		dc.b	$0,$10,$80,$4,$5,$2,$6,$8,$0,$0,$0,$6,$63,$fd,$df,$0
		dc.b	$1,$0,$1e,$0,$a,$0,$29,$0,$64,$40,$2b,$0,$1,$0,$0,$b
		dc.b	$2,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$22,$0,$1e,$0
		dc.b	$40,$0,$22,$0,$4,$0,$14,$0,$0,$0,$5f,$0,$22,$9,$88,$0
		dc.b	$13,$5f,$5e,$5f,$5e,$0,$0,$0,$0,$1,$0,$0,$0,$6,$7f,$5e
		dc.b	$9f,$0,$0,$e2,$22,$4,$44,$6,$66,$8,$88,$0,$0,$cc,$f7,$40
		dc.b	$6e,$16,$4,$f9,$fe,$31,$29,$12,$20,$34,$fd,$b,$3e,$e7,$1d,$32
		dc.b	$0,$8,$f8,$fd,$3a,$1a,$1f,$24,$29,$ff,$fd,$3f,$d7,$22,$22,$0
		dc.b	$c4,$f5,$6e,$c1,$f,$4,$f9,$ff,$3f,$f9,$f2,$39,$e9,$f5,$29,$d1
		dc.b	$6,$35,$de,$0,$cc,$5a,$a6,$0,$11,$4,$fa,$37,$e1,$3,$23,$cd
		dc.b	$f2,$1d,$c7,$ff,$2b,$d6,$12,$0,$8,$f9,$3c,$ec,$4,$20,$cd,$ec
		dc.b	$12,$c3,$0,$27,$d6,$19,$0,$0,$0,$0,$0,$1,$22,$0,$1e,$6
		dc.b	$40,$0,$82,$0,$a4,$0,$b,$0,$0,$0,$61,$0,$15,$6,$66,$0
		dc.b	$d,$61,$a8,$61,$a8,$2,$54,$2,$7e,$1,$0,$0,$61,$1,$30,$0
		dc.b	$49,$1,$24,$0,$0,$1,$24,$0,$b7,$1,$0,$0,$9f,$1,$c8,$0
		dc.b	$b7,$1,$dc,$0,$e8,$1,$e8,$0,$0,$1,$d0,$0,$49,$1,$e8,$d6
		dc.b	$49,$1,$18,$2a,$49,$1,$12,$1f,$0,$1,$12,$1f,$b7,$1,$f4,$eb
		dc.b	$0,$1,$e4,$d0,$b7,$1,$ee,$e1,$e8,$1,$35,$0,$18,$1,$1a,$2e
		dc.b	$18,$1,$1d,$0,$e8,$1,$e,$19,$e8,$1,$dc,$0,$18,$1,$ee,$e1
		dc.b	$18,$1,$4,$d8,$d0,$1,$0,$0,$30,$1,$0,$0,$d0,$0,$36,$1f
		dc.b	$6d,$0,$0,$3f,$6d,$0,$ca,$1f,$6d,$0,$ca,$e1,$6d,$0,$0,$c1
		dc.b	$6d,$0,$36,$e1,$6d,$2,$6d,$3f,$a,$14,$0,$7e,$a,$15,$93,$3f
		dc.b	$a,$10,$95,$c2,$e6,$12,$0,$84,$e6,$2,$6d,$c1,$a,$4,$5e,$36
		dc.b	$bf,$16,$0,$6c,$bf,$17,$90,$17,$cb,$e,$9c,$c6,$ce,$1a,$0,$8c
		dc.b	$ce,$4,$4a,$aa,$c9,$4,$6a,$3d,$e1,$16,$0,$7a,$e1,$c,$a7,$4d
		dc.b	$2c,$e,$9c,$c6,$32,$1a,$0,$8c,$32,$1b,$4a,$aa,$37,$6,$6d,$3e
		dc.b	$10,$18,$0,$7d,$10,$19,$a1,$52,$11,$a,$99,$c4,$29,$1c,$0,$88
		dc.b	$29,$6,$79,$eb,$1f,$8,$43,$26,$9c,$8,$0,$4d,$9c,$8,$d3,$36
		dc.b	$97,$8,$cf,$e4,$8f,$8,$0,$c8,$8f,$8,$46,$f4,$97,$17,$86,$17
		dc.b	$e8,$24,$73,$d9,$de,$2b,$52,$a5,$e2,$28,$88,$19,$e2,$45,$c6,$44
		dc.b	$3,$0,$2,$14,$2,$44,$3,$0,$14,$15,$4,$44,$3,$0,$15,$10
		dc.b	$6,$44,$3,$0,$12,$10,$8,$44,$3,$0,$12,$13,$a,$44,$3,$0
		dc.b	$2,$13,$c,$44,$4,$14,$20,$22,$2,$0,$e,$44,$4,$22,$15,$23
		dc.b	$14,$0,$10,$44,$3,$15,$23,$10,$12,$44,$3,$28,$23,$10,$50,$44
		dc.b	$4,$12,$28,$2a,$10,$0,$14,$44,$4,$2a,$13,$2b,$12,$0,$16,$44
		dc.b	$3,$2,$13,$20,$18,$44,$3,$2b,$13,$20,$4e,$44,$4,$16,$20,$22
		dc.b	$4,$0,$1a,$44,$4,$22,$17,$23,$16,$0,$1c,$44,$4,$e,$23,$28
		dc.b	$17,$0,$1e,$44,$4,$1a,$28,$2a,$e,$0,$20,$44,$4,$2a,$1b,$2b
		dc.b	$1a,$0,$22,$44,$4,$20,$1b,$2b,$4,$0,$24,$0,$6,$44,$4,$16
		dc.b	$24,$26,$4,$0,$26,$44,$4,$26,$17,$27,$16,$0,$28,$44,$3,$c
		dc.b	$27,$e,$2a,$44,$3,$17,$27,$e,$4a,$44,$4,$1a,$c,$1e,$e,$0
		dc.b	$2c,$44,$4,$1e,$1b,$1f,$1a,$0,$2e,$44,$3,$1b,$1f,$4,$30,$44
		dc.b	$3,$24,$1f,$4,$4c,$46,$6,$44,$4,$18,$24,$26,$6,$0,$32,$44
		dc.b	$4,$26,$19,$27,$18,$0,$34,$44,$4,$a,$27,$c,$19,$0,$36,$44
		dc.b	$4,$1c,$c,$1e,$a,$0,$38,$44,$4,$1e,$1d,$1f,$1c,$0,$3a,$44
		dc.b	$4,$24,$1d,$1f,$6,$0,$3c,$44,$3,$8,$6,$18,$3e,$44,$3,$8
		dc.b	$18,$19,$40,$44,$3,$8,$19,$a,$42,$44,$3,$8,$1c,$a,$44,$44
		dc.b	$3,$8,$1c,$1d,$46,$44,$3,$8,$6,$1d,$48,$0,$eb,$9,$88,$0
		dc.b	$ab,$80,$3a,$9,$dc,$0,$78,$c,$bb,$6,$2c,$d2,$20,$0,$0,$d0
		dc.b	$80,$2,$4,$6,$8,$a,$c,$e,$10,$12,$50,$14,$16,$18,$4e,$1a
		dc.b	$1c,$1e,$20,$22,$24,$0,$d0,$80,$32,$34,$36,$38,$3a,$3c,$3e,$40
		dc.b	$42,$44,$46,$48,$0,$50,$80,$0,$0,$6,$63,$fd,$df,$0,$1,$3f
		dc.b	$ff,$0,$0,$40,$a,$0,$64,$40,$2b,$0,$1,$0,$0,$b,$2,$0
		ds.b	10
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$3,$0,$42,$0
		dc.b	$26,$6,$66,$0,$1b,$42,$c1,$42,$c1,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$0,$8c,$6,$fc,$44,$41,$c1,$42,$0,$0,$0,$0,$1d,$3f,$42
		dc.b	$3b,$0,$0,$94,$44,$2,$22,$6,$66,$4,$44,$0,$82,$2,$22,$0
		dc.b	$0,$6,$66,$4,$44,$4,$42,$2,$20,$6,$64,$4,$42,$6,$62,$4
		dc.b	$40,$8,$86,$6,$64,$6,$66,$4,$44,$8,$88,$6,$66,$2,$22,$0
		dc.b	$0,$4,$44,$2,$22,$4,$22,$2,$0,$6,$42,$4,$20,$2,$24,$0
		dc.b	$2,$4,$46,$2,$24,$0,$0,$4,$fa,$1c,$29,$28,$c,$3e,$5,$2d
		dc.b	$2d,$3,$3b,$10,$10,$24,$fb,$34,$27,$e0,$27,$a,$f0,$3c,$f,$13
		dc.b	$3a,$2,$19,$3a,$2,$21,$36,$f6,$19,$3a,$e9,$20,$32,$e9,$29,$2b
		dc.b	$f9,$31,$28,$1,$29,$30,$e,$2f,$28,$0,$4,$fb,$20,$1f,$2d,$24
		dc.b	$15,$30,$1c,$15,$35,$0,$4,$fa,$e5,$c6,$0,$e3,$ca,$f0,$c6,$ed
		dc.b	$f1,$cc,$5,$dc,$c3,$10,$fb,$c1,$fb,$5,$ca,$f8,$1f,$ca,$e0,$9
		dc.b	$0,$4,$f9,$f9,$3c,$ec,$df,$24,$d8,$1,$0,$c1,$1a,$b,$c7,$4
		dc.b	$20,$c9,$8,$34,$dd,$0,$4,$fb,$f2,$c7,$e7,$f9,$ca,$df,$ea,$cd
		dc.b	$e1,$0,$c4,$99,$25,$40,$15,$c4,$34,$9e,$c1,$11,$c4,$b4,$57,$cb
		dc.b	$11,$c4,$15,$ea,$84,$e,$c4,$a0,$16,$af,$13,$c4,$11,$7e,$f2,$c
		dc.b	$88,$14,$b7,$66,$9,$8,$0,$6,$e0,$37,$fd,$8,$3f,$d,$e1,$36
		dc.b	$30,$fd,$29,$10,$dd,$32,$31,$d8,$0,$d,$d9,$30,$1,$c1,$a,$7
		dc.b	$d7,$30,$f1,$cd,$22,$4,$db,$33,$dc,$e4,$2c,$0,$88,$2b,$16,$76
		dc.b	$7,$8,$0,$1a,$d,$38,$2c,$7,$2c,$19,$8,$39,$1b,$f8,$38,$14
		dc.b	$8,$3b,$8,$fb,$3f,$12,$a,$3c,$2,$e,$3e,$13,$e,$3b,$9,$24
		dc.b	$33,$16,$f,$39,$21,$1b,$2f,$0,$c4,$6e,$c0,$f9,$24,$84,$6e,$c0
		dc.b	$f9,$2d,$4,$fb,$38,$e2,$0,$38,$e3,$f8,$34,$dd,$fa,$35,$de,$0
		dc.b	$0,$88,$b2,$bb,$b7,$9,$8,$0,$db,$e0,$d7,$da,$f5,$cf,$d6,$e1
		dc.b	$dc,$c1,$fd,$fa,$d6,$dd,$e1,$d8,$d8,$1c,$d9,$d9,$e1,$ed,$c6,$ed
		dc.b	$de,$d7,$dd,$fa,$cd,$db,$df,$db,$d9,$5,$e4,$c7,$0,$84,$68,$2b
		dc.b	$c4,$22,$88,$60,$16,$af,$8,$8,$0,$2c,$d,$d4,$1a,$7,$c7,$2d
		dc.b	$8,$d4,$2c,$f8,$d3,$31,$8,$d9,$38,$fb,$e3,$32,$a,$da,$39,$e
		dc.b	$e9,$31,$e,$da,$2d,$24,$e6,$2e,$f,$d8,$21,$1b,$d1,$0,$88,$c8
		dc.b	$72,$f1,$8,$8,$0,$e8,$3a,$f8,$1,$3f,$0,$e9,$3b,$fc,$ed,$3c
		dc.b	$7,$e4,$39,$fd,$d5,$2e,$3,$e1,$36,$f8,$dc,$31,$ee,$e4,$37,$f5
		dc.b	$ee,$39,$eb,$0,$0,$0,$0,$0,$62,$0,$1e,$1,$40,$0,$32,$0
		dc.b	$34,$0,$16,$0,$2,$0,$59,$0,$27,$2,$22,$0,$17,$59,$68,$59
		dc.b	$68,$0,$0,$0,$0,$1,$0,$59,$0,$1,$0,$a7,$0,$1,$2f,$27
		dc.b	$c0,$1,$2f,$d9,$40,$1,$0,$0,$0,$0,$2d,$64,$3e,$0,$49,$64
		dc.b	$e9,$0,$0,$64,$b3,$6,$49,$17,$64,$4,$76,$17,$da,$4,$0,$17
		dc.b	$84,$6,$0,$e9,$7c,$6,$76,$e9,$26,$4,$49,$e9,$9c,$2,$0,$9c
		dc.b	$4d,$2,$49,$9c,$17,$2,$2d,$9c,$c2,$0,$df,$58,$b5,$0,$8,$e2
		dc.b	$22,$2,$22,$2,$22,$2,$22,$0,$0,$0,$0,$0,$b,$d,$f8,$0
		dc.b	$cb,$80,$2,$0,$dc,$cc,$2c,$83,$1c,$49,$2d,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$6,$0,$dc,$0,$60,$83,$1c,$49,$2d,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$8,$c,$dc,$33,$53,$83,$1c,$d7,$43,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$a,$c,$dc,$99,$39,$83,$1c,$d7,$43,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$b,$c,$dc,$66,$6,$83,$1c,$d7,$43,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$e,$0,$dc,$0,$20,$83,$1c,$d7,$43,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$10,$0,$dc,$99,$39,$83,$1c,$d7,$43,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$12,$0,$dc,$33,$53,$83,$1c,$d7,$43,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$13,$0,$dc,$cc,$6c,$83,$1c,$d7,$43,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$14,$c,$dc,$0,$60,$83,$1c,$49,$2d,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$18,$c,$dc,$cc,$2c,$83,$1c,$49,$2d,$17,$6e,$6,$8,$0
		dc.b	$cb,$80,$19,$c,$dc,$33,$13,$83,$1c,$49,$2d,$17,$6e,$6,$8,$0
		dc.b	$0,$0,$b0,$0,$10,$8,$c0,$0,$9c,$0,$18,$0,$16,$0,$2,$0
		dc.b	$5d,$1,$e,$54,$e8,$1,$c,$53,$e2,$1,$0,$59,$7,$1,$7,$59
		dc.b	$0,$1,$0,$59,$f9,$1,$7,$59,$fc,$1,$4,$59,$f9,$1,$7,$59
		dc.b	$4,$1,$4,$59,$7,$1,$6,$59,$3,$1,$3,$59,$6,$1,$6,$59
		dc.b	$fd,$1,$3,$59,$fa,$1,$0,$59,$6,$1,$0,$59,$fa,$1,$6,$59
		dc.b	$0,$1,$17,$56,$0,$1,$3,$57,$ed,$1,$fd,$56,$15,$1,$e,$57
		dc.b	$e,$1,$d,$58,$fc,$1,$b,$57,$ec,$1,$10,$55,$14,$1,$14,$55
		dc.b	$e,$1,$10,$56,$d,$1,$e,$55,$14,$1,$13,$54,$13,$1,$d,$56
		dc.b	$10,$1,$14,$55,$10,$1,$13,$51,$e0,$1,$15,$52,$e7,$1,$12,$54
		dc.b	$e9,$1,$f,$51,$e0,$1,$c,$54,$e6,$1,$16,$51,$e4,$4,$c4,$5e
		dc.b	$c4,$6,$c4,$5e,$3c,$4,$1e,$75,$24,$6,$1c,$79,$e9,$1a,$0,$7e
		dc.b	$0,$1,$ac,$4,$a8,$0,$5,$14,$a,$2,$24,$24,$26,$26,$20,$8
		dc.b	$28,$2a,$22,$8,$2b,$21,$21,$8,$27,$27,$24,$0,$0,$0,$0,$0
		dc.b	$5,$e,$6,$2,$24,$24,$26,$26,$20,$6,$6,$8,$e,$10,$4,$0
		dc.b	$0,$0,$5,$e,$8,$2,$20,$20,$28,$2a,$22,$6,$8,$8,$c,$a
		dc.b	$6,$0,$0,$0,$5,$e,$9,$2,$22,$22,$2b,$21,$21,$6,$7,$8
		dc.b	$b,$d,$8,$0,$0,$0,$5,$e,$7,$2,$21,$21,$27,$27,$24,$6
		dc.b	$4,$8,$11,$f,$7,$0,$0,$0,$16,$44,$3c,$3c,$3e,$0,$2,$0
		dc.b	$16,$40,$3a,$3a,$44,$0,$4,$0,$16,$42,$2,$2,$40,$0,$5,$0
		dc.b	$16,$3e,$0,$0,$42,$0,$3,$0,$16,$45,$3d,$3d,$3f,$0,$3,$0
		dc.b	$16,$41,$3b,$3b,$45,$0,$5,$0,$16,$43,$3,$3,$41,$0,$4,$0
		dc.b	$16,$3f,$1,$1,$43,$0,$2,$2,$b,$2,$54,$0,$16,$39,$35,$35
		dc.b	$2d,$0,$3,$0,$16,$31,$2f,$2f,$39,$0,$5,$0,$16,$2d,$33,$33
		dc.b	$37,$0,$2,$0,$16,$37,$27,$27,$31,$0,$4,$2,$2c,$1,$64,$0
		dc.b	$16,$6,$10,$e,$4,$0,$2,$0,$16,$8,$a,$c,$6,$0,$4,$0
		dc.b	$16,$7,$11,$f,$5,$0,$3,$0,$16,$9,$b,$d,$7,$0,$5,$0
		dc.b	$0,$0,$5,$e,$2,$2,$4,$4,$10,$e,$6,$6,$1e,$8,$12,$14
		dc.b	$1a,$0,$0,$0,$5,$e,$4,$2,$6,$6,$a,$c,$8,$6,$1c,$8
		dc.b	$18,$16,$1e,$0,$0,$0,$5,$e,$3,$2,$4,$4,$11,$f,$7,$6
		dc.b	$1f,$8,$13,$15,$1a,$0,$0,$0,$5,$e,$5,$2,$7,$7,$b,$d
		dc.b	$8,$6,$1c,$8,$19,$17,$1f,$0,$0,$0,$0,$0,$22,$0,$1e,$0
		dc.b	$40,$0,$22,$0,$4,$0,$16,$0,$2,$0,$6c,$0,$24,$9,$88,$0
		dc.b	$17,$6c,$7a,$6c,$7a,$0,$0,$0,$0,$1,$0,$0,$0,$a,$1f,$6b
		dc.b	$a1,$0,$0,$88,$20,$8,$60,$0,$0,$8,$84,$0,$0,$0,$0,$0
		ds.b	5
		dc.b	$c4,$f7,$40,$6e,$b,$8,$fa,$fe,$2c,$2d,$b,$20,$36,$fd,$13,$3c
		dc.b	$eb,$20,$32,$0,$4,$f9,$fb,$3a,$1a,$28,$24,$21,$3,$f9,$3f,$d5
		dc.b	$22,$1e,$0,$4,$fa,$ff,$3f,$f9,$f2,$39,$e9,$f5,$29,$d1,$6,$35
		dc.b	$de,$0,$c4,$5a,$a6,$0,$8,$8,$fa,$37,$e1,$3,$23,$cd,$f2,$1d
		dc.b	$c7,$ff,$2b,$d6,$12,$0,$4,$f9,$3f,$f6,$4,$1c,$cd,$e7,$7,$c1
		dc.b	$0,$22,$d6,$20,$0,$cc,$f5,$6e,$c1,$e,$cc,$8a,$d5,$ec,$b,$4
		dc.b	$f8,$29,$2d,$ef,$5,$10,$c3,$2c,$e3,$dd,$3a,$e,$15,$0,$4,$f8
		dc.b	$e3,$35,$ec,$c3,$d,$d,$ca,$ed,$e5,$ef,$19,$c8,$0,$c,$f9,$c4
		dc.b	$ec,$6,$ef,$c7,$16,$3,$c1,$0,$df,$ce,$eb,$0,$0,$0,$0,$0
		dc.b	$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$4,$0,$5a
		dc.b	$0,$25,$8,$88,$0,$19,$5a,$26,$5a,$26,$0,$0,$0,$0,$1,$0
		dc.b	$0,$0,$1,$bf,$59,$71,$0,$0,$e8,$88,$8,$88,$8,$88,$8,$88
		dc.b	$2,$20,$40,$1a,$8,$86,$40,$34,$6,$64,$40,$68,$4,$42,$0,$0
		ds.b	5
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$3,$0,$5a,$0
		dc.b	$24,$8,$64,$0,$18,$5a,$26,$5a,$26,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$1,$bf,$59,$71,$0,$0,$e8,$64,$8,$64,$8,$64,$8,$64,$6
		dc.b	$0,$40,$20,$8,$64,$40,$31,$6,$42,$40,$62,$6,$20,$0,$0,$0
		ds.b	4
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$3,$0,$66,$0
		dc.b	$26,$6,$66,$0,$18,$65,$53,$66,$57,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$5,$ff,$64,$88,$0,$0,$80,$40,$0,$4,$4,$44,$4,$44,$0
		dc.b	$40,$0,$40,$0,$40,$0,$40,$0,$8,$40,$1d,$8,$88,$40,$2c,$6
		dc.b	$68,$40,$44,$4,$48,$40,$68,$2,$28,$0,$0,$cc,$0,$7f,$0,$41
		dc.b	$4,$fa,$15,$10,$3a,$5,$1b,$39,$fc,$22,$35,$f5,$29,$2f,$a,$31
		dc.b	$27,$23,$20,$2a,$0,$4,$fa,$d3,$d9,$eb,$de,$d7,$de,$e9,$e0,$ce
		dc.b	$dc,$f5,$cd,$cd,$f3,$dd,$ca,$eb,$e7,$0,$c4,$ac,$52,$cf,$16,$c4
		dc.b	$73,$f5,$cb,$22,$0,$0,$0,$0,$22,$0,$1e,$0,$40,$0,$22,$0
		dc.b	$4,$0,$16,$0,$4,$0,$5b,$0,$28,$2,$62,$0,$19,$5a,$e5,$5b
		dc.b	$ce,$0,$0,$0,$0,$1,$0,$0,$0,$8,$1f,$5a,$2f,$0,$0,$82
		dc.b	$62,$2,$26,$6,$66,$6,$66,$2,$62,$2,$62,$2,$62,$2,$62,$0
		dc.b	$8,$40,$1d,$8,$88,$40,$2c,$6,$68,$40,$44,$4,$48,$40,$68,$2
		dc.b	$28,$0,$0,$4,$fa,$f7,$3f,$fb,$df,$31,$e9,$2,$3e,$f3,$1c,$39
		dc.b	$5,$1,$3f,$b,$0,$4,$fa,$eb,$3c,$fd,$dd,$31,$14,$f6,$37,$1e
		dc.b	$f7,$20,$36,$eb,$f5,$3b,$cf,$eb,$22,$cb,$22,$0,$0,$4,$fa,$1
		dc.b	$21,$ca,$15,$f3,$c6,$3a,$e9,$f6,$28,$cf,$7,$25,$d7,$1f,$28,$f5
		dc.b	$30,$36,$b,$1f,$2d,$24,$e6,$0,$4,$fa,$ca,$e0,$9,$ec,$c9,$18
		dc.b	$f6,$c1,$ff,$1,$c1,$0,$9,$c6,$e7,$df,$d5,$df,$0,$0,$0,$0
		dc.b	$0,$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$4,$0
		dc.b	$4c,$0,$28,$6,$66,$0,$19,$4b,$fe,$4c,$c1,$0,$0,$0,$0,$1
		dc.b	$0,$0,$0,$7,$1f,$4b,$66,$0,$0,$86,$66,$2,$26,$6,$66,$6
		dc.b	$66,$6,$66,$6,$66,$6,$66,$6,$66,$0,$8,$40,$1d,$8,$88,$40
		dc.b	$2c,$6,$68,$40,$44,$4,$48,$40,$68,$2,$28,$0,$0,$4,$fc,$ec
		dc.b	$15,$38,$1,$b,$3f,$f6,$f5,$3e,$d8,$fb,$30,$d1,$e,$28,$0,$4
		dc.b	$fb,$c9,$fe,$1f,$c2,$f5,$a,$c5,$eb,$f6,$d0,$f9,$d8,$c5,$7,$eb
		dc.b	$0,$4,$fc,$1,$b,$c1,$d0,$6,$d8,$d9,$ed,$d2,$f6,$e6,$c7,$0
		dc.b	$4,$fa,$2a,$15,$d6,$15,$f5,$c5,$36,$f8,$e1,$3c,$f0,$a,$a,$b
		dc.b	$3e,$36,$e,$1f,$3e,$8,$f5,$0,$0,$0,$0,$0,$22,$0,$1e,$0
		dc.b	$40,$0,$22,$0,$4,$0,$16,$0,$4,$0,$60,$0,$28,$2,$26,$0
		dc.b	$19,$5f,$11,$60,$5,$0,$0,$0,$0,$1,$0,$0,$0,$2,$7f,$5e
		dc.b	$52,$0,$0,$82,$26,$2,$26,$2,$26,$2,$26,$2,$26,$2,$26,$2
		dc.b	$26,$2,$26,$0,$8,$40,$1d,$6,$68,$40,$2c,$4,$48,$40,$44,$2
		dc.b	$28,$40,$68,$0,$8,$0,$0,$0,$0,$0,$0,$0,$9a,$0,$1e,$4
		dc.b	$0,$0,$5e,$0,$40,$0,$16,$0,$4,$0,$60,$0,$27,$2,$26,$0
		dc.b	$19,$5f,$11,$60,$5,$0,$0,$0,$0,$1,$0,$0,$0,$1,$0,$5f
		dc.b	$0,$1,$0,$a1,$0,$1,$0,$2a,$55,$1,$30,$d6,$45,$1,$4d,$2a
		dc.b	$22,$1,$54,$d6,$f8,$1,$54,$1c,$df,$1,$1d,$d6,$b1,$1,$0,$2a
		dc.b	$ab,$1,$29,$50,$1c,$1,$1e,$0,$59,$1,$19,$50,$d5,$1,$5f,$0
		dc.b	$0,$1,$35,$18,$b6,$1,$2b,$b0,$e7,$2,$0,$7f,$0,$4,$0,$81
		dc.b	$0,$6,$0,$38,$71,$8,$41,$c8,$5d,$a,$67,$38,$2e,$c,$70,$c8
		dc.b	$f5,$e,$70,$26,$d3,$10,$26,$c8,$96,$12,$0,$38,$8f,$14,$37,$6b
		dc.b	$26,$16,$29,$0,$78,$18,$21,$6b,$c6,$1a,$7f,$0,$0,$1c,$48,$20
		dc.b	$9d,$1e,$3a,$95,$df,$17,$5f,$5e,$52,$0,$0,$82,$26,$2,$62,$6
		dc.b	$66,$6,$66,$2,$26,$2,$26,$2,$26,$2,$26,$0,$8,$40,$1d,$8
		dc.b	$88,$40,$2c,$6,$68,$40,$44,$4,$48,$40,$68,$2,$28,$0,$0,$cc
		dc.b	$0,$7f,$0,$38,$4,$fc,$1,$32,$27,$0,$5,$1,$33,$25,$2,$31
		dc.b	$28,$fe,$32,$27,$1,$36,$20,$1,$36,$21,$0,$4,$fc,$6,$33,$25
		dc.b	$4,$33,$26,$3,$35,$23,$6,$35,$23,$0,$84,$13,$73,$34,$7,$4
		dc.b	$fb,$fe,$2e,$2b,$0,$5,$ea,$35,$1c,$0,$b,$f5,$3c,$10,$fc,$35
		dc.b	$22,$f8,$34,$23,$f5,$3a,$18,$f3,$33,$23,$fd,$31,$28,$3,$2d,$2d
		dc.b	$1,$2b,$2e,$7,$2b,$2e,$7,$26,$32,$1,$28,$31,$f9,$2d,$2c,$e2
		dc.b	$26,$28,$e9,$24,$2e,$d4,$e,$2c,$ce,$1b,$1d,$c7,$15,$12,$c3,$8
		dc.b	$e,$c5,$17,$0,$c4,$b,$f0,$cc,$1b,$e8,$e3,$31,$e3,$1,$3a,$e5
		dc.b	$f0,$3d,$0,$0,$4,$fa,$e3,$20,$2e,$7,$24,$33,$f,$1b,$37,$6
		dc.b	$8,$3f,$f5,$5,$3e,$f3,$d9,$30,$e0,$e1,$2d,$d0,$b,$28,$0,$4
		dc.b	$fc,$d0,$f4,$28,$d7,$eb,$2b,$d6,$e3,$26,$0,$4,$fc,$d9,$ed,$d2
		dc.b	$d5,$f5,$d3,$ce,$f3,$dc,$ca,$eb,$e8,$d2,$d9,$ee,$d7,$de,$de,$ea
		dc.b	$dc,$d1,$e5,$e5,$cd,$da,$f5,$cf,$0,$4,$fc,$a,$3f,$3,$16,$37
		dc.b	$16,$3,$3f,$a,$0,$4,$fc,$c8,$7,$e4,$c4,$fc,$ec,$c8,$fa,$e4
		dc.b	$0,$4,$fc,$d3,$fe,$d3,$e1,$f5,$ca,$de,$fd,$cb,$0,$4,$fc,$e1
		dc.b	$29,$db,$d8,$23,$de,$d6,$20,$dd,$e0,$24,$d8,$0,$4,$fc,$a,$37
		dc.b	$e2,$14,$37,$e8,$28,$29,$e4,$38,$15,$ec,$3e,$b,$5,$3d,$8,$e
		dc.b	$3e,$f8,$9,$38,$eb,$14,$23,$cc,$a,$21,$cc,$f,$2a,$d7,$18,$24
		dc.b	$fb,$34,$30,$fe,$29,$32,$5,$27,$39,$b,$1a,$3e,$b,$a,$3a,$19
		dc.b	$3,$3b,$15,$f9,$37,$20,$fa,$39,$1a,$a,$24,$2d,$1a,$19,$3a,$9
		dc.b	$26,$32,$6,$1f,$37,$fd,$15,$3c,$3,$7,$3c,$ec,$0,$0,$0,$0
		dc.b	$b,$11,$76,$1,$b,$80,$6,$0,$dc,$0,$20,$83,$1c,$8d,$36,$88
		dc.b	$9a,$0,$6,$17,$8e,$6,$0,$1,$b,$80,$c,$0,$dc,$22,$42,$83
		dc.b	$1c,$72,$49,$88,$9a,$0,$c,$17,$8e,$6,$0,$1,$b,$80,$12,$0
		dc.b	$dc,$0,$60,$83,$1c,$8d,$36,$88,$9a,$0,$12,$17,$8e,$6,$0,$1
		dc.b	$b,$80,$1d,$0,$dc,$cc,$6c,$83,$1c,$aa,$3a,$88,$9a,$0,$1d,$17
		dc.b	$ae,$6,$0,$7,$8b,$8,$26,$1,$b,$80,$9,$0,$dc,$8e,$13,$83
		dc.b	$1c,$72,$49,$88,$9a,$0,$9,$17,$ce,$6,$0,$1,$b,$80,$b,$0
		dc.b	$dc,$88,$8,$83,$1c,$8d,$36,$88,$9a,$0,$b,$17,$ce,$6,$0,$1
		dc.b	$b,$80,$14,$18,$dc,$71,$c,$83,$1c,$9f,$54,$88,$9a,$0,$14,$17
		dc.b	$ce,$6,$0,$1,$b,$80,$15,$0,$dc,$71,$c,$83,$1c,$60,$2b,$88
		dc.b	$9a,$0,$15,$17,$ce,$6,$0,$1,$b,$80,$19,$0,$dc,$aa,$6a,$83
		dc.b	$1c,$60,$2b,$88,$9a,$0,$19,$17,$ce,$6,$0,$1,$b,$80,$1f,$0
		dc.b	$dc,$55,$75,$83,$1c,$9f,$54,$88,$9a,$0,$1f,$17,$ce,$6,$0,$0
		dc.b	$0,$0,$78,$0,$10,$6,$80,$0,$78,$0,$4,$0,$16,$0,$4,$0
		dc.b	$63,$1,$0,$5e,$9,$1,$8,$5e,$fc,$1,$ef,$5d,$3,$1,$b,$5d
		dc.b	$d,$1,$5,$5d,$f0,$1,$0,$5d,$e,$1,$c,$5d,$f9,$1,$5,$5d
		dc.b	$d,$1,$8,$5d,$f5,$1,$f2,$5d,$ff,$1,$f,$5d,$5,$1,$fe,$5d
		dc.b	$f0,$1,$f4,$5d,$a,$1,$b,$5d,$f3,$1,$ef,$5d,$fd,$1,$6,$5d
		dc.b	$10,$1,$f6,$5c,$eb,$1,$ef,$5b,$ef,$1,$f7,$5c,$ee,$1,$12,$5c
		dc.b	$f7,$1,$13,$5b,$f2,$1,$14,$5c,$f8,$1,$14,$5c,$ff,$1,$16,$5c
		dc.b	$0,$1,$16,$5c,$f9,$1,$2,$5c,$15,$0,$8c,$5,$3c,$11,$3,$4
		dc.b	$6,$8,$0,$0,$0,$11,$5,$34,$0,$2,$0,$0,$e,$6,$6,$8
		dc.b	$6,$1e,$a,$8,$18,$12,$3,$8,$12,$4,$4,$8,$4,$1c,$d,$8
		dc.b	$16,$10,$2,$8,$10,$8,$8,$8,$8,$1a,$c,$8,$14,$e,$0,$a
		dc.b	$0,$2,$16,$16,$24,$24,$22,$8,$20,$20,$16,$0,$0,$0,$b,$2
		dc.b	$54,$11,$5,$2c,$0,$2,$1d,$1d,$26,$26,$28,$8,$2a,$2a,$1d,$a
		dc.b	$0,$2,$14,$14,$2c,$2c,$30,$8,$2e,$2e,$14,$a,$0,$2,$27,$27
		dc.b	$2b,$31,$31,$a,$0,$2,$1f,$1f,$1f,$33,$32,$8,$33,$33,$1f,$0
		ds.b	4
		dc.b	$38,$0,$10,$2,$80,$0,$38,$0,$4,$0,$16,$0,$4,$0,$63,$1
		dc.b	$0,$5e,$f5,$1,$f0,$5b,$ed,$1,$f8,$5e,$3,$1,$ed,$5c,$f5,$1
		dc.b	$f6,$5c,$11,$1,$1a,$5a,$9,$1,$24,$56,$f3,$1,$19,$5b,$fb,$1
		dc.b	$ff,$5d,$ef,$1,$8,$5b,$17,$0,$ac,$4,$a8,$11,$2,$2,$3,$11
		dc.b	$2,$8,$a,$0,$0,$1,$ec,$2,$8,$11,$2,$2,$10,$11,$2,$10
		dc.b	$3,$11,$2,$8,$9,$11,$2,$9,$a,$11,$2,$6,$5,$11,$2,$7
		dc.b	$e,$11,$2,$e,$c,$0,$0,$11,$5,$30,$0,$2,$2,$2,$0,$0
		dc.b	$3,$8,$10,$10,$2,$a,$0,$2,$6,$6,$4,$4,$5,$8,$4,$6
		dc.b	$6,$a,$0,$2,$8,$8,$9,$9,$a,$8,$12,$12,$8,$a,$0,$2
		dc.b	$c,$c,$e,$e,$7,$8,$7,$e,$c,$0,$0,$0,$0,$0,$40,$0
		dc.b	$10,$3,$0,$0,$40,$0,$4,$0,$16,$0,$4,$0,$5f,$1,$c,$5c
		dc.b	$12,$1,$15,$5a,$ed,$1,$c,$5a,$e7,$1,$8,$5d,$f0,$1,$8,$5c
		dc.b	$eb,$1,$fd,$5e,$f7,$1,$fe,$5d,$f2,$1,$ff,$5d,$ee,$1,$0,$5b
		dc.b	$e5,$1,$e7,$5b,$1,$1,$ee,$5d,$2,$1,$f0,$5d,$fe,$0,$8c,$5
		dc.b	$86,$11,$3,$0,$a,$16,$0,$0,$0,$11,$5,$1c,$0,$2,$0,$0
		dc.b	$16,$6,$2,$8,$4,$6,$6,$8,$8,$8,$4,$8,$e,$a,$a,$8
		dc.b	$c,$c,$e,$8,$12,$1,$0,$0,$0,$0,$b,$2,$e8,$11,$5,$18
		dc.b	$0,$2,$1,$1,$14,$14,$3,$8,$12,$12,$1,$a,$0,$2,$16,$16
		dc.b	$3,$5,$10,$8,$10,$3,$16,$0,$0,$0,$0,$0,$22,$0,$1e,$0
		dc.b	$40,$0,$22,$0,$4,$0,$16,$0,$9,$0,$76,$0,$2e,$9,$88,$0
		dc.b	$22,$1c,$67,$1c,$b0,$0,$0,$0,$0,$1,$0,$0,$0,$1,$8c,$3
		dc.b	$d0,$74,$1a,$82,$0,$5,$40,$7,$62,$3,$66,$3,$64,$7,$20,$1
		dc.b	$62,$1,$46,$1,$1,$67,$1c,$0,$0,$b,$2b,$3,$d0,$a,$df,$1c
		dc.b	$2e,$0,$0,$94,$0,$6,$42,$4,$20,$6,$20,$0,$82,$4,$42,$2
		dc.b	$20,$4,$42,$2,$20,$6,$22,$6,$44,$6,$22,$6,$44,$2,$66,$4
		dc.b	$66,$2,$46,$0,$44,$2,$64,$6,$66,$2,$64,$2,$42,$6,$42,$0
		dc.b	$0,$4,$20,$4,$22,$2,$44,$4,$44,$2,$44,$2,$42,$2,$46,$2
		dc.b	$44,$2,$46,$2,$24,$4,$22,$40,$1d,$8,$88,$40,$2c,$8,$66,$40
		dc.b	$44,$6,$44,$40,$68,$6,$22,$0,$0,$4,$f9,$1,$1b,$3a,$d7,$1b
		dc.b	$29,$c6,$1b,$0,$d7,$1b,$d7,$1,$1b,$c6,$29,$1b,$d7,$3a,$1b,$0
		dc.b	$29,$1b,$29,$0,$4,$f9,$16,$e5,$35,$35,$e5,$15,$35,$e5,$ea,$15
		dc.b	$e5,$cb,$ea,$e5,$cb,$cb,$e5,$eb,$cb,$e5,$16,$eb,$e5,$35,$0,$cc
		dc.b	$0,$7f,$0,$71,$8c,$0,$7f,$0,$f4,$c,$fc,$10,$10,$3b,$7,$b
		dc.b	$3e,$f9,$b,$3e,$f0,$10,$3b,$f9,$15,$3b,$7,$15,$3b,$0,$0,$c1
		dc.b	$4d,$e,$82,$0,$13,$0,$c1,$0,$3c,$0,$0,$0,$39,$10,$1a,$0
		dc.b	$0,$c1,$d,$40,$82,$c2,$d,$40,$40,$17,$ee,$6,$0,$0,$0,$0
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$8,$0,$76,$0
		dc.b	$2c,$9,$88,$0,$21,$1c,$67,$1c,$b0,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$1,$8c,$3,$d0,$36,$7a,$82,$0,$5,$40,$3,$2,$5,$0,$3
		dc.b	$64,$1,$0,$1,$62,$1,$6,$1,$1,$67,$1c,$0,$0,$a,$4b,$3
		dc.b	$d0,$9,$ff,$1c,$2e,$0,$0,$d2,$66,$0,$0,$2,$66,$6,$66,$0
		dc.b	$82,$4,$40,$0,$0,$4,$40,$0,$0,$2,$2,$4,$44,$2,$2,$4
		dc.b	$44,$4,$0,$4,$44,$4,$0,$4,$44,$2,$64,$6,$66,$2,$64,$6
		dc.b	$66,$0,$0,$4,$20,$0,$0,$4,$20,$0,$62,$6,$66,$0,$62,$0
		dc.b	$0,$0,$6,$2,$26,$0,$6,$2,$26,$2,$42,$40,$1d,$8,$88,$40
		dc.b	$2c,$6,$86,$40,$44,$4,$64,$40,$68,$2,$62,$0,$0,$4,$fc,$12
		dc.b	$13,$39,$9,$e,$3d,$f7,$e,$3d,$ee,$13,$39,$f7,$19,$3a,$9,$19
		dc.b	$3a,$0,$c,$0,$c7,$f5,$1a,$c2,$f1,$0,$c7,$f5,$e6,$c1,$fa,$0
		dc.b	$0,$4,$0,$f1,$eb,$c6,$13,$e5,$ca,$31,$eb,$de,$15,$f0,$c6,$0
		dc.b	$c,$0,$31,$0,$d7,$3b,$f9,$15,$b,$0,$3f,$3b,$7,$15,$0,$cc
		dc.b	$0,$7f,$0,$63,$0,$c3,$4d,$e,$82,$0,$13,$0,$c3,$0,$3c,$0
		dc.b	$0,$0,$39,$10,$1a,$0,$0,$c1,$d,$40,$82,$c2,$d,$40,$40,$17
		dc.b	$fb,$6,$0,$f0,$8,$0,$0,$0,$22,$0,$1e,$0,$40,$0,$22,$0
		dc.b	$4,$0,$16,$0,$a,$0,$76,$0,$2e,$9,$88,$0,$23,$1c,$67,$1c
		dc.b	$b0,$0,$0,$0,$0,$1,$0,$0,$0,$1,$8c,$1,$f4,$36,$7a,$82
		dc.b	$0,$5,$40,$3,$2,$5,$0,$3,$64,$1,$0,$1,$62,$1,$6,$1
		dc.b	$1,$67,$1c,$0,$0,$6,$cb,$1,$f4,$6,$7f,$1c,$2e,$0,$0,$d2
		dc.b	$66,$0,$0,$2,$66,$6,$66,$0,$82,$4,$40,$0,$0,$4,$40,$0
		dc.b	$0,$2,$2,$4,$44,$2,$2,$4,$44,$4,$0,$4,$44,$4,$0,$4
		dc.b	$44,$2,$64,$6,$66,$2,$64,$6,$66,$0,$0,$4,$20,$0,$0,$4
		dc.b	$20,$0,$62,$6,$66,$0,$62,$0,$0,$0,$6,$2,$26,$0,$6,$2
		dc.b	$26,$0,$4,$40,$1d,$8,$88,$40,$2c,$6,$66,$40,$44,$4,$44,$40
		dc.b	$68,$2,$24,$0,$0,$c4,$0,$7f,$0,$55,$84,$0,$7f,$0,$e3,$cc
		dc.b	$0,$7f,$0,$aa,$0,$c3,$4d,$e,$82,$0,$13,$0,$c3,$0,$3c,$0
		dc.b	$0,$0,$39,$10,$1a,$0,$0,$c1,$d,$40,$82,$c2,$d,$40,$40,$17
		dc.b	$fb,$6,$0,$10,$8,$0,$0,$0,$22,$0,$1e,$0,$40,$0,$22,$0
		dc.b	$4,$0,$16,$0,$b,$0,$76,$0,$32,$9f,$0,$0,$22,$1c,$67,$1c
		dc.b	$b0,$0,$0,$0,$0,$1,$0,$0,$0,$0,$6c,$1,$dc,$f0,$1,$67
		dc.b	$1c,$0,$80,$6,$b,$1,$dc,$5,$bf,$1c,$2e,$0,$0,$e,$0,$6
		dc.b	$66,$6,$66,$6,$66,$6,$66,$6,$66,$6,$66,$6,$66,$0,$0,$4
		dc.b	$fc,$12,$13,$39,$9,$e,$3d,$f7,$e,$3d,$ee,$13,$39,$f7,$19,$3a
		dc.b	$9,$19,$3a,$0,$4,$0,$c7,$f5,$1a,$c2,$f1,$0,$c7,$f5,$e6,$c1
		dc.b	$fa,$0,$0,$4,$0,$f1,$eb,$c6,$13,$e5,$ca,$31,$eb,$de,$15,$f0
		dc.b	$c6,$0,$4,$0,$31,$0,$d7,$3b,$f9,$15,$b,$0,$3f,$3b,$7,$15
		dc.b	$0,$c4,$0,$7f,$0,$55,$0,$c3,$4d,$d,$82,$0,$13,$0,$c3,$c1
		dc.b	$d,$40,$82,$c2,$d,$40,$1,$17,$fb,$0,$0,$21,$80,$0,$0,$0
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$b,$0,$76,$0
		dc.b	$3a,$d7,$be,$0,$23,$5,$ae,$5,$ae,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$7d,$e1,$ae,$5,$0,$80,$c2,$d,$40,$1,$c1,$d,$83,$82,$c1
		dc.b	$5d,$3,$c1,$17,$fb,$0,$0,$0,$82,$c1,$5d,$2,$c1,$17,$fb,$0
		dc.b	$0,$10,$92,$0,$0,$0,$d4,$0,$10,$c,$40,$0,$d4,$0,$4,$0
		dc.b	$16,$0,$9,$0,$70,$1,$1d,$0,$e3,$1,$d,$0,$d3,$1,$2d,$0
		dc.b	$f4,$1,$2d,$0,$d,$1,$c,$0,$2c,$1,$1c,$0,$1d,$1,$22,$0
		dc.b	$de,$1,$f,$0,$cb,$1,$37,$0,$f4,$1,$34,$0,$15,$1,$b,$0
		dc.b	$33,$1,$1c,$0,$27,$1,$28,$0,$d8,$1,$12,$0,$c2,$1,$43,$0
		dc.b	$f3,$1,$3d,$0,$1e,$1,$b,$0,$3b,$1,$1c,$0,$31,$1,$2d,$0
		dc.b	$d3,$1,$14,$0,$b9,$1,$4d,$0,$f3,$1,$45,$0,$26,$1,$b,$0
		dc.b	$42,$1,$1c,$0,$3a,$1,$33,$0,$cd,$1,$17,$0,$b0,$1,$58,$0
		dc.b	$f2,$1,$4c,$0,$2e,$1,$b,$0,$4a,$1,$1c,$0,$43,$b,$1,$c
		dc.b	$16,$1,$2b,$0,$d5,$1,$13,$0,$bd,$1,$48,$0,$f3,$1,$41,$0
		dc.b	$22,$1,$b,$0,$3f,$1,$1c,$0,$36,$1,$25,$0,$db,$1,$10,$0
		dc.b	$c6,$1,$3d,$0,$f3,$1,$39,$0,$1a,$1,$b,$0,$37,$1,$1c,$0
		dc.b	$2c,$1,$37,$0,$c9,$1,$18,$0,$aa,$1,$60,$0,$f2,$1,$52,$0
		dc.b	$34,$1,$b,$0,$50,$1,$1c,$0,$49,$11,$1a,$c1,$0,$3,$30,$1
		dc.b	$10,$1,$10,$1,$30,$1,$10,$3,$32,$1,$12,$46,$46,$6,$13,$10
		dc.b	$c1,$4,$6b,$a,$0,$1,$33,$c,$c1,$44,$45,$e,$80,$2,$19,$19
		dc.b	$1b,$1a,$18,$6,$c,$8,$e,$f,$d,$0,$0,$2,$cb,$3,$a2,$1
		dc.b	$33,$d,$c1,$0,$5,$e,$80,$2,$d,$d,$f,$e,$c,$6,$0,$8
		dc.b	$2,$3,$1,$0,$0,$1,$34,$c,$c1,$1,$5,$e,$80,$2,$19,$19
		dc.b	$1b,$1a,$18,$6,$24,$8,$26,$27,$25,$0,$0,$1,$33,$b,$c1,$45
		dc.b	$45,$e,$80,$2,$31,$31,$33,$32,$30,$6,$24,$8,$26,$27,$25,$0
		dc.b	$0,$6,$4b,$3,$75,$3,$53,$f,$c1,$1,$4b,$2,$1,$1,$13,$a
		dc.b	$c1,$44,$56,$3e,$41,$40,$3f,$0,$0,$45,$56,$4a,$4d,$4c,$4b,$0
		dc.b	$0,$1,$93,$9,$c1,$0,$94,$7,$c1,$45,$56,$56,$59,$58,$57,$0
		dc.b	$0,$0,$93,$7,$c1,$0,$16,$56,$59,$58,$57,$0,$0,$2,$94,$10
		dc.b	$c1,$0,$93,$8,$c1,$45,$56,$30,$33,$32,$31,$0,$0,$1,$93,$e
		dc.b	$c1,$0,$94,$7,$c1,$0,$16,$c,$f,$e,$d,$0,$0,$0,$93,$7
		dc.b	$c1,$45,$56,$c,$f,$e,$d,$0,$0,$47,$a6,$6,$13,$10,$c1,$4
		dc.b	$6b,$a,$0,$1,$33,$c,$c1,$44,$45,$e,$80,$2,$23,$23,$1f,$1d
		dc.b	$19,$6,$d,$8,$11,$13,$17,$0,$0,$2,$cb,$3,$a2,$1,$33,$d
		dc.b	$c1,$0,$5,$e,$80,$2,$17,$17,$13,$11,$d,$6,$1,$8,$5,$7
		dc.b	$b,$0,$0,$1,$34,$c,$c1,$1,$5,$e,$80,$2,$23,$23,$1f,$1d
		dc.b	$19,$6,$25,$8,$29,$2b,$2f,$0,$0,$1,$33,$b,$c1,$45,$45,$e
		dc.b	$80,$2,$3b,$3b,$37,$35,$31,$6,$25,$8,$29,$2b,$2f,$0,$0,$4
		dc.b	$4b,$3,$75,$2,$53,$f,$c1,$1,$4b,$2,$1,$1,$13,$a,$c1,$44
		dc.b	$56,$3f,$45,$43,$49,$0,$0,$45,$56,$4b,$51,$4f,$55,$0,$0,$0
		dc.b	$93,$9,$c1,$45,$56,$57,$5d,$5b,$61,$0,$0,$1,$94,$10,$c1,$0
		dc.b	$93,$8,$c1,$45,$56,$31,$37,$35,$3b,$0,$0,$0,$93,$e,$c1,$0
		dc.b	$16,$d,$13,$11,$17,$0,$0,$47,$86,$6,$13,$10,$c1,$4,$6b,$a
		dc.b	$0,$1,$33,$c,$c1,$44,$45,$e,$80,$2,$18,$18,$1c,$1e,$22,$6
		dc.b	$16,$8,$12,$10,$c,$0,$0,$2,$cb,$3,$a2,$1,$33,$d,$c1,$0
		dc.b	$5,$e,$80,$2,$c,$c,$10,$12,$16,$6,$a,$8,$6,$4,$0,$0
		dc.b	$0,$1,$34,$c,$c1,$1,$5,$e,$80,$2,$18,$18,$1c,$1e,$22,$6
		dc.b	$2e,$8,$2a,$28,$24,$0,$0,$1,$33,$b,$c1,$45,$45,$e,$80,$2
		dc.b	$30,$30,$34,$36,$3a,$6,$2e,$8,$2a,$28,$24,$0,$0,$4,$8b,$3
		dc.b	$75,$2,$93,$f,$c1,$1,$4b,$2,$1,$1,$13,$a,$c1,$44,$56,$48
		dc.b	$42,$44,$3e,$0,$0,$45,$56,$54,$4e,$50,$4a,$0,$0,$0,$d3,$9
		dc.b	$c1,$0,$94,$7,$c1,$45,$56,$60,$5a,$5c,$56,$0,$0,$1,$94,$10
		dc.b	$c1,$0,$93,$8,$c1,$45,$56,$3a,$34,$36,$30,$0,$0,$0,$93,$e
		dc.b	$c1,$0,$16,$16,$10,$12,$c,$0,$0,$0,$94,$0,$c2,$0,$b,$2
		dc.b	$ba,$10,$1a,$0,$80,$47,$6,$6,$13,$10,$c1,$4,$6b,$4,$8c,$1
		dc.b	$33,$c,$c1,$44,$45,$e,$80,$2,$22,$22,$20,$21,$23,$6,$17,$8
		dc.b	$15,$14,$16,$0,$0,$2,$cb,$2,$8a,$1,$33,$d,$c1,$0,$5,$e
		dc.b	$80,$2,$16,$16,$14,$15,$17,$6,$b,$8,$9,$8,$a,$0,$0,$1
		dc.b	$34,$c,$c1,$1,$5,$e,$80,$2,$22,$22,$20,$21,$23,$6,$2f,$8
		dc.b	$2d,$2c,$2e,$0,$0,$1,$33,$b,$c1,$45,$45,$e,$80,$2,$3a,$3a
		dc.b	$38,$39,$3b,$6,$2f,$8,$2d,$2c,$2e,$0,$0,$4,$4b,$3,$75,$2
		dc.b	$53,$f,$c1,$1,$4b,$2,$1,$1,$13,$a,$c1,$44,$56,$49,$46,$47
		dc.b	$48,$0,$0,$45,$56,$55,$52,$53,$54,$0,$0,$0,$93,$9,$c1,$45
		dc.b	$56,$61,$5e,$5f,$60,$0,$0,$1,$94,$10,$c1,$0,$93,$8,$c1,$45
		dc.b	$56,$3b,$38,$39,$3a,$0,$0,$0,$93,$e,$c1,$0,$16,$17,$14,$15
		dc.b	$16,$0,$0,$0,$0,$0,$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0
		dc.b	$16,$0,$c,$0,$4c,$0,$40,$bf,$f6,$0,$21,$4b,$ab,$4c,$40,$0
		dc.b	$0,$0,$0,$1,$0,$0,$0,$1,$ff,$4b,$13,$0,$0,$e,$e6,$e
		dc.b	$e6,$e,$e6,$e,$e6,$e,$e6,$e,$e6,$e,$e6,$e,$e6,$8,$60,$40
		dc.b	$93,$8,$86,$40,$15,$8,$84,$0,$0,$0,$0,$0,$0,$0,$22,$0
		dc.b	$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$b,$0,$75,$0,$3f,$af
		dc.b	$b4,$0,$20,$74,$6a,$75,$94,$0,$0,$0,$0,$1,$0,$0,$0,$1
		dc.b	$ff,$73,$81,$0,$0,$e,$a4,$e,$a4,$e,$a4,$e,$a4,$e,$a4,$e
		dc.b	$a4,$e,$a4,$e,$a4,$8,$0,$40,$93,$8,$60,$40,$15,$8,$80,$0
		ds.b	6
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$b,$0,$52,$0
		dc.b	$3f,$9f,$50,$0,$20,$51,$7d,$52,$4e,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$1,$ff,$50,$da,$0,$0,$e,$40,$e,$40,$e,$40,$e,$40,$e
		dc.b	$40,$e,$40,$e,$40,$e,$40,$8,$0,$40,$93,$8,$60,$40,$15,$8
		dc.b	$40,$0,$0,$0,$0,$0,$0,$0,$22,$0,$1e,$0,$40,$0,$22,$0
		dc.b	$4,$0,$16,$0,$c,$0,$75,$0,$40,$8f,$fe,$0,$21,$74,$6a,$75
		dc.b	$94,$0,$0,$0,$0,$1,$0,$0,$0,$1,$5f,$73,$81,$0,$0,$e
		dc.b	$ee,$e,$ee,$e,$ee,$e,$ee,$e,$ee,$e,$ee,$e,$ee,$e,$ee,$0
		ds.b	6
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$e,$0,$49,$0
		dc.b	$42,$8d,$fe,$0,$23,$48,$c2,$49,$7c,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$1,$5f,$48,$30,$0,$0,$c,$ee,$c,$ee,$c,$ee,$c,$ee,$c
		dc.b	$ee,$c,$ee,$c,$ee,$c,$ee,$0,$0,$0,$0,$0,$0,$0,$22,$0
		dc.b	$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$f,$0,$75,$0,$43,$cb
		dc.b	$fe,$0,$24,$74,$6a,$75,$94,$0,$0,$0,$0,$1,$0,$0,$0,$1
		dc.b	$5f,$73,$81,$0,$0,$a,$ee,$a,$ee,$a,$ee,$a,$ee,$a,$ee,$a
		dc.b	$ee,$a,$ee,$a,$ee,$0,$0,$0,$0,$0,$0,$0,$22,$0,$1e,$0
		dc.b	$40,$0,$22,$0,$4,$0,$16,$0,$11,$0,$5b,$0,$45,$9f,$70,$0
		dc.b	$26,$5a,$f3,$5b,$db,$0,$0,$0,$0,$1,$0,$0,$0,$1,$ff,$5a
		dc.b	$3d,$0,$0,$e,$60,$e,$60,$e,$60,$e,$60,$e,$60,$e,$60,$e
		dc.b	$60,$e,$60,$8,$0,$40,$93,$8,$60,$40,$15,$8,$40,$0,$0,$0
		ds.b	4
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$13,$0,$44,$0
		dc.b	$47,$af,$b4,$0,$28,$44,$36,$44,$e4,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$1,$5f,$43,$ad,$0,$0,$e,$a4,$e,$a4,$e,$a4,$e,$a4,$e
		dc.b	$a4,$e,$a4,$e,$a4,$e,$a4,$0,$0,$0,$0,$0,$0,$0,$22,$0
		dc.b	$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$14,$0,$44,$0,$48,$af
		dc.b	$92,$0,$29,$44,$36,$44,$e4,$0,$0,$0,$0,$1,$0,$0,$0,$1
		dc.b	$5f,$43,$ad,$0,$0,$e,$82,$e,$82,$e,$82,$e,$82,$e,$82,$e
		dc.b	$82,$e,$82,$e,$82,$0,$0,$0,$0,$0,$0,$0,$22,$0,$1e,$0
		dc.b	$40,$0,$22,$0,$4,$0,$16,$0,$11,$0,$5b,$0,$45,$cb,$fe,$0
		dc.b	$26,$5a,$f3,$5b,$db,$0,$0,$0,$0,$1,$0,$0,$0,$1,$5f,$5a
		dc.b	$3d,$0,$0,$a,$ee,$a,$ee,$a,$ee,$a,$ee,$a,$ee,$a,$ee,$a
		dc.b	$ee,$a,$ee,$0,$0,$0,$0,$0,$0,$1,$28,$0,$10,$f,$c0,$1
		dc.b	$c,$0,$20,$0,$a,$0,$0,$0,$40,$1,$4,$0,$c1,$1,$f5,$6
		dc.b	$c2,$1,$dd,$fa,$cc,$1,$d1,$4,$d6,$1,$c1,$fc,$fb,$5,$1,$0
		dc.b	$9,$d,$1,$6,$a,$d,$1,$8,$c,$d,$1,$2,$4,$d,$1,$4
		dc.b	$6,$d,$1,$8,$a,$1,$c3,$f6,$d,$d,$1,$a,$20,$1,$db,$3
		dc.b	$33,$d,$1,$8,$18,$d,$1,$16,$1a,$d,$1,$1a,$1e,$d,$1,$16
		dc.b	$1c,$1,$d5,$5,$2e,$1,$d8,$b,$30,$1,$f6,$f,$3d,$1,$9,$4
		dc.b	$3f,$d,$1,$24,$2a,$d,$1,$1a,$28,$1,$d5,$f5,$2d,$d,$1,$1a
		dc.b	$30,$1,$0,$f7,$3f,$d,$1,$2a,$34,$d,$1,$1a,$34,$d,$1,$1a
		dc.b	$32,$d,$1,$3a,$34,$d,$1,$40,$34,$d,$1,$30,$32,$d,$1,$1a
		dc.b	$2e,$d,$1,$31,$34,$d,$1,$36,$44,$1,$30,$3,$29,$d,$1,$29
		dc.b	$2a,$d,$1,$46,$1b,$d,$1,$b,$17,$1,$2f,$fb,$2a,$1,$38,$9
		dc.b	$1c,$1,$0,$0,$0,$1,$da,$22,$25,$1,$0,$40,$0,$1,$0,$c0
		dc.b	$0,$1,$d9,$22,$dc,$1,$dd,$35,$ff,$1,$1,$35,$22,$1,$0,$36
		dc.b	$df,$1,$c8,$1d,$fd,$1,$e1,$d7,$db,$1,$cb,$fd,$de,$1,$d8,$dc
		dc.b	$21,$1,$c9,$e1,$fe,$1,$4,$20,$ca,$1,$0,$dd,$cb,$1,$4,$24
		dc.b	$34,$1,$2,$e1,$37,$1,$dc,$cc,$1,$1,$ff,$cb,$22,$1,$f9,$c7
		dc.b	$e4,$1,$3,$d0,$d7,$54,$0,$0,$81,$54,$a7,$0,$a7,$54,$81,$0
		dc.b	$0,$54,$0,$7f,$0,$54,$0,$59,$59,$54,$59,$59,$0,$54,$0,$59
		dc.b	$a7,$ff,$c6,$4,$4c,$80,$2,$1,$cc,$80,$4,$1,$c,$80,$e,$10
		dc.b	$65,$c,$8a,$2,$0,$0,$2,$10,$6,$8,$4,$10,$0,$0,$0,$18
		dc.b	$e,$c0,$4,$66,$5c,$7f,$2,$0,$8c,$80,$5,$18,$e,$c0,$5,$67
		dc.b	$5d,$7f,$0,$0,$8c,$80,$e,$18,$e,$c0,$6e,$5d,$5c,$7f,$0,$0
		dc.b	$8b,$80,$a,$18,$e,$c0,$70,$67,$66,$7f,$2,$6,$8c,$80,$6,$1
		dc.b	$cc,$80,$4,$1,$c,$80,$d,$10,$65,$c,$8c,$2,$12,$12,$c,$e
		dc.b	$a,$8,$8,$e,$12,$0,$0,$18,$e,$c0,$68,$66,$5c,$7f,$8,$2
		dc.b	$cb,$80,$5,$2,$c,$80,$d,$10,$65,$1c,$8c,$2,$24,$24,$24,$20
		dc.b	$18,$8,$a,$14,$14,$8,$8,$8,$1c,$8,$18,$16,$20,$a,$0,$2
		dc.b	$22,$22,$8,$16,$22,$0,$0,$18,$e,$c0,$53,$6a,$56,$7f,$a,$0
		dc.b	$8c,$80,$d,$18,$e,$c0,$64,$56,$5c,$7f,$a,$0,$8b,$80,$c,$18
		dc.b	$e,$c0,$6c,$6a,$66,$7f,$8,$7,$ab,$80,$2,$3,$b,$80,$5,$2
		dc.b	$4c,$80,$a,$10,$65,$20,$e,$2,$20,$20,$1a,$24,$2c,$8,$2a,$28
		dc.b	$2e,$8,$1a,$26,$24,$a,$0,$2,$34,$34,$34,$30,$32,$8,$1a,$38
		dc.b	$38,$8,$34,$36,$36,$0,$0,$18,$e,$c0,$1a,$6a,$56,$7f,$28,$2
		dc.b	$ab,$80,$4,$1,$ec,$80,$a,$10,$65,$1a,$8e,$2,$36,$36,$2a,$46
		dc.b	$4c,$8,$1b,$44,$48,$6,$50,$8,$44,$46,$34,$a,$0,$2,$4a,$4a
		dc.b	$2a,$27,$4a,$0,$0,$18,$e,$c0,$1b,$6b,$57,$7f,$2a,$0,$8c,$80
		dc.b	$a,$18,$e,$c0,$72,$57,$56,$7f,$2a,$0,$8b,$80,$e,$18,$e,$c0
		dc.b	$74,$6b,$6a,$7f,$2a,$5,$cb,$80,$6,$1,$cb,$80,$4,$1,$c,$80
		dc.b	$c,$10,$65,$c,$8d,$2,$48,$48,$52,$4e,$9,$8,$17,$b,$50,$0
		dc.b	$0,$18,$e,$c0,$52,$6b,$57,$7f,$b,$2,$c,$80,$5,$1,$4b,$80
		dc.b	$d,$1,$c,$80,$c,$10,$65,$c,$80,$2,$f,$f,$d,$7,$13,$8
		dc.b	$5,$f,$f,$0,$0,$18,$e,$c0,$69,$67,$5d,$7f,$9,$0,$8c,$80
		dc.b	$c,$18,$e,$c0,$65,$57,$5d,$7f,$b,$0,$8b,$80,$d,$18,$e,$c0
		dc.b	$6d,$6b,$67,$7f,$9,$3,$c,$80,$8,$0,$8c,$80,$d,$18,$e,$c0
		dc.b	$5e,$5c,$56,$7f,$58,$0,$8c,$80,$c,$18,$e,$c0,$5f,$57,$5d,$7f
		dc.b	$58,$0,$8c,$80,$a,$18,$e,$c0,$60,$56,$57,$7f,$58,$0,$8c,$80
		dc.b	$e,$18,$e,$c0,$62,$5d,$5c,$7f,$58,$4,$b,$80,$8,$0,$8b,$80
		dc.b	$c,$18,$e,$c0,$76,$66,$6a,$7f,$5a,$0,$8b,$80,$e,$18,$e,$c0
		dc.b	$78,$6a,$6b,$7f,$5a,$0,$8b,$80,$d,$18,$e,$c0,$77,$6b,$67,$7f
		dc.b	$5a,$1,$8b,$80,$a,$0,$8b,$80,$c,$18,$e,$c0,$7a,$66,$7c,$7f
		dc.b	$5a,$0,$8b,$80,$d,$18,$e,$c0,$7b,$5a,$67,$7f,$7c,$0,$0,$0
		dc.b	$4c,$0,$10,$3,$c0,$0,$4c,$0,$4,$0,$8,$0,$0,$0,$40,$b
		dc.b	$1,$ff,$fd,$b,$1,$fe,$fd,$3,$1,$0,$2,$3,$1,$ff,$4,$3
		dc.b	$1,$fd,$4,$3,$1,$fe,$4,$3,$1,$a,$fe,$3,$1,$ff,$c,$3
		dc.b	$1,$4,$e,$b,$1,$fd,$fc,$d,$1,$ff,$12,$3,$1,$12,$8,$3
		dc.b	$1,$12,$16,$d,$1,$0,$14,$d,$1,$3,$19,$76,$78,$1,$40,$fc
		dc.b	$2,$8,$b,$d,$11,$14,$1c,$4,$0,$7,$9,$a,$f,$12,$19,$7f
		dc.b	$7f,$ba,$b8,$0,$40,$fc,$2,$8,$b,$d,$11,$14,$1c,$4,$0,$7
		dc.b	$9,$a,$f,$12,$19,$ff,$5,$c,$e,$18,$3,$fd,$e,$17,$6,$16
		dc.b	$1a,$7f,$7f,$0,$0,$0,$4a,$0,$1e,$2,$c0,$0,$4a,$0,$4,$0
		dc.b	$13,$0,$0,$0,$52,$0,$11,$6,$66,$0,$15,$52,$c0,$52,$c0,$0
		dc.b	$0,$0,$0,$1,$2d,$0,$d3,$1,$14,$0,$ba,$1,$52,$0,$f9,$1
		dc.b	$3f,$0,$35,$1,$b,$0,$3f,$1,$0,$0,$0,$13,$c1,$a,$0,$13
		dc.b	$c1,$a,$2,$13,$c1,$a,$4,$13,$c1,$a,$6,$13,$c1,$a,$8,$0
		dc.b	$c,$0,$40,$c1,$5d,$1,$8a,$40,$c6,$1c,$16,$c,$12,$10,$14,$0
		dc.b	$0,$0,$b,$a,$1,$40,$46,$1a,$16,$d,$e,$f,$c,$0,$0,$0
		dc.b	$b,$6,$41,$40,$e6,$18,$16,$15,$11,$13,$d,$0,$0,$0,$0,$0
		dc.b	$22,$0,$1e,$0,$40,$0,$22,$0,$4,$0,$16,$0,$8,$0,$5d,$0
		dc.b	$50,$f,$ee,$0,$50,$5d,$21,$5d,$21,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$10,$fa,$81,$0,$1,$e0,$f,$e,$f,$0,$f,$80,$f,$e0,$b
		dc.b	$aa,$f,$ee,$1,$18,$1,$40,$0,$7f,$0,$0,$0,$22,$0,$1e,$0
		dc.b	$40,$0,$22,$0,$4,$0,$16,$0,$8,$0,$5d,$0,$50,$f,$ee,$0
		dc.b	$50,$5d,$21,$5d,$21,$0,$0,$0,$0,$1,$0,$0,$0,$f0,$fa,$81
		dc.b	$0,$1,$e,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$1
		dc.b	$18,$2,$40,$0,$7f,$0,$0,$0,$7a,$0,$1e,$3,$c0,$0,$5a,$0
		dc.b	$24,$0,$4,$0,$0,$0,$68,$0,$f,$6,$66,$0,$6,$68,$ff,$34
		dc.b	$7f,$2,$34,$2,$3e,$1,$34,$34,$68,$1,$0,$0,$68,$1,$34,$cc
		dc.b	$68,$1,$34,$34,$98,$5,$1,$0,$3,$5,$1,$0,$1,$b,$1,$0
		dc.b	$6,$b,$1,$4,$a,$1,$0,$0,$34,$5,$1,$0,$10,$1,$0,$0
		dc.b	$a,$5,$1,$0,$14,$1,$34,$0,$a3,$1,$cc,$0,$5d,$1,$0,$0
		ds.b	4
		dc.b	$7f,$6,$0,$0,$81,$0,$7f,$0,$0,$0,$0,$7f,$0,$4,$0,$81
		dc.b	$0,$6,$0,$7b,$1e,$7,$a7,$a7,$0,$6,$7b,$0,$1e,$0,$54,$0
		dc.b	$c0,$c1,$d,$40,$81,$c4,$d,$40,$40,$c2,$1d,$40,$c1,$0,$54,$0
		dc.b	$c2,$c4,$d,$40,$1,$c2,$1d,$1,$c1,$0,$54,$0,$c2,$c4,$d,$40
		dc.b	$2,$c2,$1d,$13,$c1,$0,$54,$0,$c2,$c4,$d,$40,$3,$c2,$1d,$14
		dc.b	$c1,$0,$54,$0,$c2,$c4,$d,$8,$4,$c2,$1d,$1d,$c1,$0,$54,$0
		dc.b	$c2,$c4,$d,$8,$5,$c2,$1d,$12,$c1,$0,$54,$0,$c2,$c4,$d,$10
		dc.b	$40,$c2,$1d,$f,$c1,$0,$54,$0,$c2,$c4,$d,$10,$1,$c2,$1d,$10
		dc.b	$c1,$0,$54,$0,$c2,$c4,$d,$10,$2,$98,$1a,$c2,$0,$1,$66,$5
		dc.b	$40,$1,$0,$1,$60,$7,$6,$7,$0,$5,$44,$4,$54,$0,$c4,$ff
		dc.b	$e6,$1,$4,$1,$4,$5,$0,$0,$2,$1,$4,$7,$a,$b,$6,$0
		dc.b	$4,$1,$8,$4,$6,$a,$0,$0,$6,$1,$4,$1,$6,$7,$0,$0
		dc.b	$8,$1,$4,$5,$a,$b,$4,$0,$a,$0,$b,$5,$dc,$1,$14,$0
		dc.b	$c0,$88,$8a,$4,$6,$42,$18,$30,$22,$88,$8a,$4,$7,$6a,$1a,$30
		dc.b	$22,$0,$0,$1,$d3,$5,$c4,$ff,$e6,$1,$3,$6,$7,$a,$4,$1
		dc.b	$3,$6,$7,$2,$c,$1,$3,$7,$a,$2,$e,$1,$3,$6,$a,$2
		dc.b	$10,$0,$0,$0,$6,$3,$95,$0,$1a,$c4,$0,$1,$6,$1,$66,$9
		dc.b	$88,$1,$60,$7,$60,$0,$0,$0,$0,$2,$74,$4,$c4,$ff,$e6,$1
		dc.b	$11,$8,$2,$34,$82,$34,$84,$0,$10,$0,$10,$1,$4b,$5,$dc,$1
		dc.b	$14,$0,$c0,$88,$8a,$4,$6,$42,$18,$30,$16,$88,$8a,$4,$7,$6a
		dc.b	$1a,$30,$16,$4,$93,$4,$c4,$3,$4b,$4,$e2,$1,$74,$1,$c4,$42
		dc.b	$6,$18,$2e,$0,$10,$42,$46,$18,$2e,$0,$12,$ff,$e6,$1,$10,$16
		dc.b	$14,$1a,$2,$1a,$0,$1,$73,$1,$c4,$42,$6,$18,$4e,$0,$10,$42
		dc.b	$46,$18,$4e,$0,$12,$ff,$e6,$1,$10,$16,$14,$1a,$2,$1a,$0,$0
		dc.b	$cc,$4,$e2,$1,$1,$7f,$34,$10,$0,$1,$1,$7f,$34,$12,$0,$40
		dc.b	$46,$1,$2,$0,$4,$1,$2,$0,$1,$1,$2,$1,$5,$1,$2,$4
		dc.b	$5,$41,$6,$1,$2,$6,$a,$1,$2,$6,$7,$1,$2,$7,$b,$1
		dc.b	$2,$a,$b,$41,$86,$1,$2,$0,$6,$41,$c6,$1,$2,$4,$a,$41
		dc.b	$a6,$1,$2,$1,$7,$41,$e6,$1,$2,$5,$b,$f0,$15,$0,$0,$34
		dc.b	$7c,$34,$7f,$34,$7c,$cb,$81,$10,$80,$2,$4,$6,$7,$8,$a,$0
		dc.b	$0,$6,$63,$fd,$df,$0,$1,$0,$1,$0,$0,$0,$c,$0,$64,$40
		dc.b	$2b,$0,$1,$0,$0,$b,$2,$0,$0,$0,$0,$0,$0,$0,$0,$0
		dc.b	$0,$0,$14,$0,$10,$0,$40,$0,$14,$0,$4,$0,$3,$0,$0,$0
		dc.b	$68,$1,$0,$0,$0,$6,$ff,$68,$2d,$0,$0,$80,$60,$0,$0,$0
		dc.b	$60,$0,$60,$0,$60,$0,$60,$0,$60,$0,$60,$0,$60,$40,$0,$0
		dc.b	$60,$40,$0,$0,$60,$40,$0,$0,$60,$40,$0,$0,$60,$0,$0,$4
		dc.b	$ff,$cb,$20,$f2,$cb,$20,$e,$c1,$0,$0,$0,$4,$ff,$cb,$e0,$f2
		dc.b	$c9,$0,$e0,$c1,$0,$0,$0,$4,$ff,$cb,$e0,$e,$c1,$0,$0,$c9
		dc.b	$0,$1f,$0,$4,$ff,$35,$20,$f2,$35,$20,$e,$3f,$0,$0,$0,$4
		dc.b	$ff,$35,$e0,$f2,$37,$0,$e0,$3f,$0,$0,$0,$4,$ff,$35,$e0,$e
		dc.b	$3f,$0,$0,$37,$0,$1f,$0,$0,$0,$0,$0,$0,$14,$0,$10,$0
		dc.b	$40,$0,$14,$0,$4,$0,$3,$0,$0,$0,$68,$1,$0,$0,$0,$6
		dc.b	$ff,$68,$2d,$0,$0,$86,$60,$0,$0,$6,$60,$6,$60,$6,$60,$6
		dc.b	$60,$6,$60,$6,$60,$6,$60,$40,$0,$6,$60,$40,$0,$6,$60,$40
		dc.b	$0,$6,$60,$40,$0,$6,$60,$0,$0,$4,$ff,$cb,$20,$f2,$cb,$20
		dc.b	$e,$c1,$0,$0,$0,$4,$ff,$cb,$e0,$f2,$c9,$0,$e0,$c1,$0,$0
		dc.b	$0,$4,$ff,$cb,$e0,$e,$c1,$0,$0,$c9,$0,$1f,$0,$4,$ff,$35
		dc.b	$20,$f2,$35,$20,$e,$3f,$0,$0,$0,$4,$ff,$35,$e0,$f2,$37,$0
		dc.b	$e0,$3f,$0,$0,$0,$4,$ff,$35,$e0,$e,$3f,$0,$0,$37,$0,$1f
		ds.b	6
		dc.b	$36,$0,$1e,$1,$80,$0,$36,$0,$4,$0,$7,$0,$0,$0,$5d,$0
		dc.b	$2f,$8b,$de,$0,$a,$5d,$c0,$5d,$c0,$0,$0,$0,$0,$1,$0,$0
		dc.b	$0,$7,$16,$0,$0,$7,$13,$0,$0,$7,$12,$0,$0,$7,$11,$0
		dc.b	$0,$7,$10,$0,$0,$e0,$6,$3d,$8,$c2,$5d,$d,$80,$c2,$4d,$5
		dc.b	$c2,$c1,$4d,$2,$84,$c1,$d,$c2,$c1,$5,$f4,$10,$81,$56,$f8,$0
		dc.b	$c1,$0,$7f,$5,$4b,$9,$26,$c1,$4d,$1,$c1,$c2,$4d,$2,$c1,$c1
		dc.b	$d,$c2,$c1,$78,$f8,$0,$c1,$0,$7f,$3,$eb,$7,$52,$c1,$4d,$1
		dc.b	$c1,$c2,$4d,$2,$c1,$c1,$d,$c2,$c1,$9a,$f8,$0,$c1,$0,$7f,$2
		dc.b	$8b,$5,$7e,$c1,$4d,$1,$c1,$c2,$4d,$2,$c1,$c1,$d,$c2,$c1,$bc
		dc.b	$f8,$0,$c1,$0,$7f,$1,$2b,$4,$64,$c1,$4d,$1,$c1,$c2,$4d,$2
		dc.b	$c1,$c1,$d,$c2,$c1,$de,$f8,$0,$c1,$0,$7f,$5,$f3,$10,$81,$f4
		dc.b	$18,$0,$c1,$0,$7f,$5,$4b,$9,$26,$c1,$4d,$1,$c1,$c2,$4d,$2
		dc.b	$c1,$c1,$d,$c2,$c1,$f6,$18,$0,$c1,$0,$7f,$3,$eb,$7,$52,$c1
		dc.b	$4d,$1,$c1,$c2,$4d,$2,$c1,$c1,$d,$c2,$c1,$f8,$18,$0,$c1,$0
		dc.b	$7f,$2,$8b,$5,$7e,$c1,$4d,$1,$c1,$c2,$4d,$2,$c1,$c1,$d,$c2
		dc.b	$c1,$fa,$58,$0,$c1,$0,$7f,$1,$2b,$4,$64,$c1,$4d,$1,$c1,$c2
		dc.b	$4d,$2,$c1,$c1,$d,$c2,$c1,$fc,$98,$0,$c1,$0,$7f,$c2,$bd,$70
		dc.b	$84,$4,$53,$0,$c2,$0,$93,$3,$80,$18,$6e,$c0,$4,$7f,$7f,$7f
		dc.b	$2,$c2,$bd,$78,$84,$3,$13,$0,$c2,$0,$93,$5,$80,$18,$6e,$c0
		dc.b	$6,$7f,$7f,$7f,$2,$c2,$bd,$7c,$84,$1,$d3,$0,$c2,$0,$93,$6
		dc.b	$80,$18,$6e,$c0,$8,$7f,$7f,$7f,$2,$c2,$bd,$7e,$84,$0,$93,$0
		dc.b	$c2,$18,$6e,$c0,$a,$7f,$7f,$7f,$2,$0,$0,$0,$28,$0,$10,$1
		dc.b	$80,$0,$28,$0,$4,$0,$a,$0,$0,$0,$61,$b,$1,$ff,$fe,$7
		dc.b	$14,$0,$0,$b,$1,$ff,$2,$b,$1,$2,$fe,$7,$15,$0,$4,$7
		dc.b	$15,$0,$6,$1e,$e2,$ff,$8,$1e,$e2,$8,$2,$1e,$e2,$2,$a,$1e
		dc.b	$e2,$a,$fe,$0,$0,$0,$7a,$0,$1e,$5,$40,$0,$72,$0,$c,$0
		dc.b	$e,$0,$0,$0,$64,$0,$12,$6,$66,$0,$10,$64,$0,$64,$0,$0
		dc.b	$0,$0,$0,$1,$0,$0,$0,$1,$0,$0,$0,$b,$1,$0,$0,$1
		dc.b	$44,$b,$45,$13,$c3,$0,$6,$1,$d5,$e8,$cf,$13,$c3,$0,$a,$1
		dc.b	$22,$f4,$c0,$13,$c3,$0,$e,$1,$d0,$f8,$54,$13,$c3,$0,$12,$1
		dc.b	$23,$23,$31,$13,$c3,$0,$16,$1,$f4,$b7,$3e,$13,$c3,$0,$1a,$1
		dc.b	$f2,$8,$60,$13,$c3,$0,$1e,$1,$da,$20,$c5,$13,$c3,$0,$22,$1
		dc.b	$e9,$41,$c,$13,$c3,$0,$26,$0,$ed,$b,$7d,$0,$c2,$34,$9f,$c5
		dc.b	$4d,$7,$81,$c6,$1d,$84,$40,$c2,$bd,$41,$c6,$c2,$cd,$50,$c2,$2
		dc.b	$93,$0,$c2,$c2,$1d,$41,$c2,$c2,$3d,$10,$c2,$c4,$5d,$4,$c2,$c1
		dc.b	$2d,$c5,$3c,$c3,$dd,$c4,$c1,$c2,$4d,$2,$c2,$c4,$d,$c4,$c4,$c1
		dc.b	$dd,$c4,$c1,$c3,$4d,$5,$c2,$18,$8e,$46,$4,$c2,$bd,$41,$c6,$c2
		dc.b	$cd,$4f,$c2,$2,$f3,$0,$c2,$c2,$1d,$41,$c2,$c2,$3d,$f,$c2,$c4
		dc.b	$5d,$4,$c2,$c1,$2d,$c5,$19,$c3,$dd,$c4,$c1,$c2,$4d,$2,$c2,$c4
		dc.b	$d,$c4,$c4,$c1,$dd,$c4,$c1,$ff,$e6,$18,$ae,$46,$0,$18,$bb,$46
		dc.b	$0,$4,$c4,$0,$6,$c2,$bd,$44,$c6,$c2,$cd,$67,$c2,$2,$d3,$0
		dc.b	$c2,$c2,$1d,$44,$c2,$c2,$3d,$24,$c2,$c4,$5d,$4,$c2,$c1,$2d,$c5
		dc.b	$16,$c3,$dd,$c4,$c1,$c2,$4d,$2,$c2,$c4,$d,$c4,$c4,$c1,$dd,$c4
		dc.b	$c1,$18,$ce,$c6,$8,$7f,$7f,$7f,$0,$18,$ee,$46,$8,$c2,$bd,$44
		dc.b	$c6,$c2,$cd,$77,$c2,$2,$d3,$0,$c2,$c2,$1d,$44,$c2,$c2,$3d,$34
		dc.b	$c2,$c4,$5d,$4,$c2,$c1,$2d,$c5,$28,$c3,$dd,$c4,$c1,$c2,$4d,$2
		dc.b	$c2,$c4,$d,$c4,$c4,$c1,$dd,$c4,$c1,$18,$ce,$c6,$c,$7f,$7f,$7f
		dc.b	$0,$18,$ee,$46,$c,$c2,$bd,$44,$c6,$c2,$cd,$63,$c2,$2,$d3,$0
		dc.b	$c2,$c2,$1d,$44,$c2,$c2,$3d,$20,$c2,$c4,$5d,$4,$c2,$c1,$2d,$c5
		dc.b	$26,$c3,$dd,$c4,$c1,$c2,$4d,$2,$c2,$c4,$d,$c4,$c4,$c1,$dd,$c4
		dc.b	$c1,$18,$ce,$c6,$10,$7f,$7f,$7f,$0,$19,$e,$46,$10,$c2,$bd,$44
		dc.b	$c6,$c2,$cd,$5c,$c2,$2,$d3,$0,$c2,$c2,$1d,$44,$c2,$c2,$3d,$19
		dc.b	$c2,$c4,$5d,$4,$c2,$c1,$2d,$c5,$20,$c3,$dd,$c4,$c1,$c2,$4d,$2
		dc.b	$c2,$c4,$d,$c4,$c4,$c1,$dd,$c4,$c1,$18,$ce,$c6,$14,$7f,$7f,$7f
		dc.b	$0,$19,$e,$46,$14,$c2,$bd,$44,$c6,$c2,$cd,$67,$c2,$2,$13,$0
		dc.b	$c2,$c2,$1d,$44,$c2,$c2,$3d,$24,$c2,$c4,$5d,$4,$c2,$c1,$2d,$c5
		dc.b	$18,$c3,$dd,$c4,$c1,$c2,$4d,$2,$c2,$19,$2e,$c6,$18,$7f,$7f,$7f
		dc.b	$0,$c2,$bd,$44,$c6,$c2,$cd,$73,$c2,$2,$53,$0,$c2,$c2,$1d,$44
		dc.b	$c2,$c2,$3d,$30,$c2,$c4,$5d,$4,$c2,$c1,$2d,$c5,$20,$c3,$dd,$c4
		dc.b	$c1,$c2,$4d,$2,$c2,$19,$2e,$c6,$1c,$7f,$7f,$7f,$0,$19,$4e,$46
		dc.b	$1c,$c2,$bd,$44,$c6,$c2,$cd,$77,$c2,$2,$d3,$0,$c2,$c2,$1d,$44
		dc.b	$c2,$c2,$3d,$34,$c2,$c4,$5d,$4,$c2,$c1,$2d,$c5,$18,$c3,$dd,$c4
		dc.b	$c1,$c2,$4d,$2,$c2,$19,$2e,$c6,$20,$7f,$7f,$7f,$0,$5,$bc,$e9
		dc.b	$5c,$83,$1c,$3a,$3e,$19,$4e,$46,$20,$c2,$bd,$45,$c6,$c2,$cd,$53
		dc.b	$c2,$2,$d3,$0,$c2,$c2,$1d,$45,$c2,$c2,$3d,$f,$c2,$c4,$5d,$4
		dc.b	$c2,$c1,$2d,$c5,$1e,$c3,$dd,$c4,$c1,$c2,$4d,$2,$c2,$18,$ce,$c6
		dc.b	$24,$7f,$7f,$7f,$0,$5,$bc,$a3,$2b,$83,$1c,$52,$37,$19,$4e,$46
		dc.b	$24,$c2,$bd,$44,$c6,$c2,$cd,$5b,$c2,$2,$13,$0,$c2,$c2,$1d,$44
		dc.b	$c2,$c2,$3d,$18,$c2,$c4,$5d,$4,$c2,$c1,$2d,$c5,$23,$c3,$dd,$c4
		dc.b	$c1,$c2,$4d,$2,$c2,$19,$2e,$c6,$28,$7f,$7f,$7f,$0,$0,$0,$0
		dc.b	$14,$0,$10,$0,$40,$0,$14,$0,$4,$0,$9,$0,$0,$0,$4e,$1
		dc.b	$0,$0,$0,$c3,$4d,$5,$c2,$ff,$e6,$50,$da,$c3,$0,$7,$2c,$7
		dc.b	$6c,$9,$8c,$9,$8c,$7,$6c,$7,$2c,$5,$c,$19,$6e,$0,$0,$9
		dc.b	$4b,$43,$22,$72,$da,$c3,$0,$7,$6c,$9,$8c,$b,$ce,$b,$ce,$9
		dc.b	$8c,$7,$6c,$7,$2c,$c1,$4d,$1,$c1,$c4,$4d,$1,$c1,$c1,$d,$c4
		dc.b	$c1,$19,$6e,$0,$0,$6,$eb,$30,$d4,$76,$da,$c3,$0,$9,$8c,$b
		dc.b	$ce,$d,$ee,$d,$ee,$b,$ce,$9,$8c,$7,$6c,$c1,$4d,$1,$c1,$c4
		dc.b	$4d,$1,$c1,$c1,$d,$c4,$c1,$19,$6e,$0,$0,$4,$8b,$24,$9e,$98
		dc.b	$da,$c3,$0,$b,$ce,$d,$ee,$f,$ee,$f,$ee,$d,$ee,$b,$ce,$9
		dc.b	$8c,$c1,$4d,$1,$c1,$c4,$4d,$1,$c1,$c1,$d,$c4,$c1,$19,$6e,$0
		dc.b	$0,$2,$2b,$1d,$4c,$bc,$fa,$c3,$0,$d,$ee,$f,$ee,$f,$ee,$f
		dc.b	$ee,$f,$ee,$d,$ee,$b,$ce,$c1,$4d,$1,$c1,$c4,$4d,$1,$c1,$c1
		dc.b	$d,$c4,$c1,$19,$6e,$0,$0,$0,$0,$0,$14,$0,$10,$0,$40,$0
		dc.b	$14,$0,$4,$0,$a,$0,$0,$0,$4e,$1,$0,$0,$0,$c3,$4d,$5
		dc.b	$c2,$ff,$e6,$f0,$1a,$c3,$0,$f,$40,$f,$82,$f,$c4,$f,$c4,$f
		dc.b	$82,$f,$40,$f,$0,$11,$1,$0,$c1,$0,$0,$9,$cb,$43,$22,$f4
		dc.b	$1a,$c3,$0,$f,$82,$f,$c4,$f,$e4,$f,$e4,$f,$c4,$f,$82,$f
		dc.b	$40,$c1,$4d,$1,$c1,$c4,$4d,$1,$c1,$c1,$d,$c4,$c1,$11,$1,$0
		dc.b	$c1,$0,$0,$7,$4b,$30,$d4,$f8,$3a,$c3,$0,$f,$c4,$f,$e4,$f
		dc.b	$e6,$f,$e6,$f,$e4,$f,$c4,$f,$82,$c1,$4d,$1,$c1,$c4,$4d,$1
		dc.b	$c1,$c1,$d,$c4,$c1,$11,$1,$0,$c1,$0,$0,$4,$cb,$24,$9e,$fc
		dc.b	$5a,$c3,$0,$f,$e4,$f,$e6,$f,$ea,$f,$ea,$f,$e6,$f,$e4,$f
		dc.b	$c4,$c1,$4d,$1,$c1,$c4,$4d,$1,$c1,$c1,$d,$c4,$c1,$11,$1,$0
		dc.b	$c1,$0,$0,$2,$4b,$1d,$4c,$fe,$5a,$c3,$0,$f,$e6,$f,$ea,$f
		dc.b	$ee,$f,$ee,$f,$ea,$f,$e6,$f,$e4,$c1,$4d,$1,$c1,$c4,$4d,$1
		dc.b	$c1,$c1,$d,$c4,$c1,$11,$1,$0,$c1,$0,$0,$0,$0,$0,$14,$0
		dc.b	$10,$0,$40,$0,$14,$0,$4,$0,$9,$0,$0,$0,$4e,$1,$0,$0
		dc.b	$0,$c3,$4d,$5,$c2,$ff,$e6,$c5,$4d,$5,$c1,$c4,$fd,$7,$c2,$c4
		dc.b	$d,$10,$c4,$c1,$2d,$c5,$c4,$f8,$3a,$c3,$0,$f,$c4,$f,$e4,$f
		dc.b	$e6,$f,$e6,$f,$e4,$f,$c4,$f,$82,$11,$1,$0,$c1,$0,$0,$4
		dc.b	$cb,$43,$22,$fc,$5a,$c3,$0,$f,$e4,$f,$e6,$f,$ea,$f,$ea,$f
		dc.b	$e6,$f,$e4,$f,$c4,$c1,$4d,$1,$c1,$11,$1,$0,$c1,$0,$0,$2
		dc.b	$cb,$30,$d4,$fe,$5a,$c3,$0,$f,$e6,$f,$ea,$f,$ee,$f,$ee,$f
		dc.b	$ea,$f,$e6,$f,$e4,$c1,$4d,$1,$c1,$c4,$4d,$1,$c1,$c5,$4d,$1
		dc.b	$c4,$c4,$d,$c5,$c4,$c1,$d,$c4,$c1,$11,$1,$0,$c1,$0,$0,$0
		dc.b	$0,$0,$2c,$0,$10,$1,$c0,$0,$2c,$0,$4,$0,$a,$0,$0,$0
		dc.b	$5d,$1,$0,$0,$0,$1,$5d,$0,$0,$1,$0,$46,$0,$1,$0,$ba
		dc.b	$0,$13,$c1,$0,$2,$13,$c1,$0,$4,$13,$c1,$0,$6,$c3,$5d,$b
		dc.b	$c2,$80,$19,$83,$5c,$0,$c3,$c0,$1e,$11,$5,$14,$0,$2,$8,$8
		dc.b	$0,$0,$a,$8,$0,$0,$9,$8,$0,$0,$c,$8,$0,$0,$8,$0
		ds.b	4
		dc.b	$2c,$0,$10,$1,$c0,$0,$2c,$0,$4,$0,$4,$0,$0,$0,$7d,$1
		dc.b	$0,$0,$0,$1,$0,$3e,$7d,$1,$0,$c2,$7d,$1,$1f,$0,$7d,$1
		dc.b	$0,$3e,$83,$1,$0,$c2,$83,$1,$1f,$0,$83,$c3,$5d,$9,$c2,$0
		dc.b	$5c,$0,$c3,$c0,$1e,$44,$48,$8,$6,$c,$2,$0,$0,$0,$0,$0
		dc.b	$2c,$0,$10,$1,$c0,$0,$2c,$0,$4,$0,$a,$0,$0,$0,$7d,$1
		dc.b	$0,$0,$0,$1,$1f,$3e,$0,$13,$c3,$0,$2,$1,$2e,$d8,$f1,$13
		dc.b	$c3,$0,$6,$1,$c,$9,$c2,$13,$c3,$0,$a,$c3,$5d,$8,$c2,$c3
		dc.b	$1d,$c3,$40,$0,$5c,$0,$c3,$c0,$1e,$c6,$5d,$6,$c2,$c3,$ed,$c6
		dc.b	$c1,$66,$67,$c,$4,$8,$0,$44,$43,$c,$4,$5,$0,$44,$43,$c
		dc.b	$8,$9,$0,$0,$0,$0,$98,$0,$10,$8,$80,$0,$98,$0,$4,$0
		dc.b	$9,$0,$0,$0,$7d,$1,$0,$0,$0,$1,$7d,$0,$0,$1,$3e,$6c
		dc.b	$0,$1,$3e,$94,$0,$7,$10,$0,$2,$7,$10,$0,$4,$7,$10,$0
		dc.b	$5,$7,$10,$0,$3,$7,$10,$0,$7,$7,$10,$0,$6,$1,$0,$1f
		dc.b	$0,$1,$1b,$f,$0,$1,$1b,$f1,$0,$1,$0,$e1,$0,$13,$c1,$0
		dc.b	$8,$13,$c1,$0,$a,$13,$c1,$0,$c,$13,$c1,$0,$e,$13,$c1,$0
		dc.b	$10,$13,$c1,$0,$12,$13,$c1,$0,$14,$13,$c1,$0,$16,$13,$c1,$0
		dc.b	$18,$13,$c1,$0,$1a,$b,$1,$0,$1c,$b,$1,$0,$1e,$b,$1,$0
		dc.b	$20,$b,$1,$0,$22,$b,$1,$0,$24,$b,$1,$0,$26,$b,$1,$0
		dc.b	$28,$b,$1,$0,$2a,$b,$1,$0,$2c,$b,$1,$0,$2e,$c3,$5d,$b
		dc.b	$c2,$80,$19,$83,$5c,$0,$c3,$c0,$1e,$c3,$4d,$5,$c2,$f0,$1a,$c3
		dc.b	$0,$f,$40,$f,$82,$f,$82,$f,$82,$f,$82,$f,$40,$f,$0,$11
		dc.b	$5,$1a,$0,$4,$1c,$0,$2a,$6,$1e,$6,$28,$6,$20,$6,$2b,$6
		dc.b	$22,$6,$2d,$6,$24,$6,$2e,$6,$26,$6,$2c,$0,$0,$fc,$5a,$c3
		dc.b	$0,$f,$e4,$f,$e6,$f,$ea,$f,$ea,$f,$e6,$f,$e4,$f,$c4,$11
		dc.b	$5,$1a,$0,$4,$30,$0,$3e,$6,$32,$6,$3c,$6,$34,$6,$3f,$6
		dc.b	$36,$6,$41,$6,$38,$6,$42,$6,$3a,$6,$40,$0,$0,$0,$0,$0
		dc.b	$20,$0,$10,$1,$0,$0,$20,$0,$4,$0,$8,$0,$0,$0,$7d,$1
		dc.b	$0,$0,$0,$1,$64,$0,$0,$13,$c4,$0,$fe,$13,$c3,$0,$2,$c5
		dc.b	$fd,$3,$80,$c5,$d,$4,$c5,$c3,$5d,$c,$c5,$c6,$5d,$6,$c2,$c4
		dc.b	$ed,$c6,$c3,$c4,$d,$c4,$c4,$c3,$ed,$c6,$c1,$ff,$e6,$36,$e3,$6
		dc.b	$4,$7,$0,$36,$e1,$0,$c3,$0,$0,$c3,$4d,$1,$c3,$fe,$e1,$0
		dc.b	$c3,$0,$0,$0,$0,$0,$20,$0,$10,$1,$0,$0,$20,$0,$4,$0
		dc.b	$8,$0,$0,$0,$7d,$1,$0,$0,$0,$1,$64,$0,$0,$13,$c4,$0
		dc.b	$fe,$13,$c3,$0,$2,$c5,$fd,$3,$80,$c5,$d,$4,$c5,$c3,$5d,$c
		dc.b	$c5,$c6,$5d,$6,$c2,$c4,$ed,$c6,$c3,$c4,$d,$c4,$c4,$c3,$ed,$c6
		dc.b	$c1,$ff,$e6,$76,$e3,$6,$4,$7,$0,$0,$0,$0,$46,$0,$1e,$2
		dc.b	$80,$0,$46,$0,$4,$0,$11,$0,$0,$0,$40,$0,$12,$6,$66,$0
		dc.b	$13,$40,$81,$40,$81,$0,$0,$0,$0,$1,$0,$0,$0,$1,$0,$0
		dc.b	$40,$7,$12,$0,$2,$13,$a4,$0,$4,$1,$6,$c,$0,$1,$fa,$f4
		dc.b	$0,$13,$c4,$0,$8,$13,$c4,$0,$a,$11,$1,$c,$6,$11,$1,$e
		dc.b	$6,$c1,$4d,$3,$84,$c4,$d,$7,$40,$ff,$e6,$1,$93,$4,$c1,$c1
		dc.b	$fd,$3,$c1,$c4,$5d,$3,$c4,$1e,$e8,$10,$e,$12,$c,$0,$0,$19
		dc.b	$bb,$40,$0,$18,$80,$0,$0,$f0,$1a,$c1,$0,$f,$0,$f,$e0,$1
		dc.b	$e,$f,$0,$f,$80,$f,$ee,$1,$e,$c5,$d,$40,$40,$0,$93,$2
		dc.b	$c1,$c4,$5d,$1,$c4,$c5,$d,$40,$1,$11,$4,$10,$e,$12,$c,$0
		dc.b	$0,$c1,$4d,$1,$41,$c2,$d,$40,$80,$0,$eb,$0,$6,$11,$4,$11
		dc.b	$f,$13,$d,$0,$0,$18,$bb,$40,$0,$58,$80,$c3,$d,$1,$a4,$0
		dc.b	$73,$0,$c3,$18,$bb,$40,$6,$50,$80,$0,$0,$0,$1c,$0,$10,$0
		dc.b	$c0,$0,$1c,$0,$4,$0,$9,$0,$0,$0,$4e,$1,$0,$0,$4e,$b
		dc.b	$1,$ff,$0,$b,$1,$ff,$2,$ff,$e6,$e,$e9,$0,$ff,$5,$dc,$8e
		dc.b	$e9,$2,$ff,$3,$e8,$ee,$e9,$4,$ff,$2,$ee,$0,$0,$0,$22,$0
		dc.b	$1e,$0,$40,$0,$22,$0,$4,$0,$0,$0,$0,$0,$46,$0,$6,$1
		dc.b	$0,$0,$6,$46,$0,$46,$0,$0,$0,$0,$0,$1,$0,$0,$0,$be
		dc.b	$fa,$0,$0,$c1,$1d,$a1,$a2,$1,$b3,$0,$c1,$c1,$4d,$3,$a2,$c1
		dc.b	$3d,$c1,$a1,$90,$1a,$c1,$0,$d,$0,$d,$40,$d,$80,$d,$a4,$d
		dc.b	$c8,$d,$cc,$b,$ce,$11,$1,$0,$46,$0,$0,$0,$0,$0,$42,$0
		dc.b	$1e,$2,$40,$0,$42,$0,$4,$0,$7,$0,$0,$0,$46,$0,$12,$6
		dc.b	$66,$0,$9,$0,$0,$0,$0,$0,$0,$0,$0,$1,$0,$0,$0,$1
		dc.b	$17,$27,$36,$1,$3e,$e9,$e1,$1,$7,$46,$d9,$1,$27,$d2,$27,$13
		dc.b	$84,$2,$0,$13,$84,$4,$0,$13,$84,$6,$0,$13,$84,$8,$0,$c2
		dc.b	$4d,$d,$84,$33,$3a,$c2,$0,$5,$44,$5,$54,$7,$66,$7,$76,$9
		dc.b	$88,$9,$98,$b,$aa,$c1,$1d,$84,$40,$c3,$bd,$70,$c1,$0,$d3,$0
		dc.b	$c3,$c3,$1d,$70,$c1,$c3,$5d,$2,$c3,$c1,$1d,$c3,$c1,$c1,$4d,$2
		dc.b	$c1,$1,$18,$0,$c1,$a,$c,$d,$e,$10,$11,$7f,$7f,$0,$0,$0
		dc.b	$74,$0,$10,$5,$40,$0,$64,$0,$14,$0,$d,$0,$0,$0,$61,$1
		dc.b	$0,$0,$f4,$1,$0,$0,$61,$1,$15,$0,$8,$1,$18,$0,$12,$1
		dc.b	$1a,$0,$30,$1,$12,$0,$24,$1,$13,$0,$3d,$1,$e,$0,$5b,$1
		dc.b	$c,$14,$f,$1,$f7,$0,$24,$1,$ed,$0,$5b,$1,$fe,$12,$fa,$1
		dc.b	$2,$15,$8,$1,$3,$24,$e,$1,$7,$1e,$1a,$1,$6,$18,$24,$1
		dc.b	$2,$20,$33,$1,$fd,$15,$4b,$1,$ff,$1c,$55,$1,$0,$9,$60,$1
		dc.b	$c,$12,$45,$6,$0,$81,$0,$6,$69,$45,$c,$0,$58,$39,$ba,$2
		dc.b	$5f,$42,$32,$ff,$e6,$1,$6c,$4,$4a,$88,$88,$19,$c,$22,$6,$0
		dc.b	$4,$88,$87,$0,$6,$19,$6,$88,$87,$2,$c,$22,$8,$0,$0,$88
		dc.b	$85,$18,$84,$2,$6,$6,$8,$a,$c,$8,$28,$28,$22,$8,$20,$20
		dc.b	$1e,$8,$1c,$1a,$18,$8,$10,$10,$6,$0,$0,$88,$85,$18,$85,$2
		dc.b	$7,$7,$b,$12,$d,$8,$29,$29,$22,$8,$20,$20,$1e,$8,$1c,$1a
		dc.b	$18,$8,$11,$11,$7,$0,$0,$98,$85,$1c,$82,$2,$0,$0,$4,$4
		dc.b	$6,$8,$8,$a,$c,$8,$e,$e,$2,$8,$14,$14,$d,$8,$12,$b
		dc.b	$7,$8,$5,$5,$0,$0,$0,$88,$85,$10,$86,$2,$6,$6,$10,$10
		dc.b	$18,$8,$16,$16,$0,$8,$4,$4,$6,$0,$0,$88,$85,$10,$87,$2
		dc.b	$7,$7,$11,$11,$18,$8,$16,$16,$0,$8,$5,$5,$7,$0,$0,$88
		dc.b	$85,$10,$88,$2,$c,$c,$28,$28,$22,$8,$24,$26,$2,$8,$e,$e
		dc.b	$c,$0,$0,$88,$85,$10,$89,$2,$d,$d,$29,$29,$22,$8,$24,$26
		dc.b	$2,$8,$14,$14,$d,$0,$0,$0,$0,$0,$38,$0,$10,$2,$80,$0
		dc.b	$38,$0,$4,$0,$d,$0,$0,$0,$61,$1,$0,$fd,$f4,$1,$0,$fd
		dc.b	$61,$1,$15,$fd,$8,$1,$18,$fd,$12,$1,$1a,$fd,$30,$1,$12,$fd
		dc.b	$24,$1,$13,$fd,$3d,$1,$e,$fd,$5b,$1,$f7,$fd,$24,$1,$ed,$fd
		dc.b	$5b,$e2,$6,$2,$62,$0,$ac,$5,$3e,$11,$4,$9,$8,$2,$0,$0
		dc.b	$0,$0,$0,$11,$5,$1c,$0,$2,$0,$0,$4,$4,$6,$8,$8,$a
		dc.b	$c,$8,$e,$e,$2,$8,$12,$12,$d,$8,$10,$b,$7,$8,$5,$5
		ds.b	6
		dc.b	$46,$0,$1e,$2,$80,$0,$46,$0,$4,$0,$10,$0,$0,$0,$5b,$0
		dc.b	$1b,$6,$66,$0,$12,$0,$0,$0,$0,$0,$0,$0,$0,$1,$2d,$1e
		dc.b	$ee,$1,$22,$1e,$44,$1,$9,$1e,$5b,$1,$4,$1e,$0,$1,$3b,$1e
		dc.b	$ca,$1,$2d,$0,$ee,$1,$22,$0,$44,$1,$9,$0,$5b,$1,$4,$0
		dc.b	$0,$1,$3b,$0,$ca,$c,$5b,$0,$6,$20,$80,$19,$db,$40,$10,$22
		dc.b	$a2,$0,$d3,$2,$82,$c,$5b,$0,$2,$20,$80,$19,$db,$40,$c,$22
		dc.b	$a2,$0,$d3,$5,$82,$c,$5b,$0,$9,$20,$80,$19,$db,$40,$13,$22
		dc.b	$a2,$0,$b,$6,$ca,$0,$d3,$7,$82,$c,$5b,$0,$1,$10,$80,$19
		dc.b	$db,$40,$b,$12,$a2,$0,$d3,$3,$82,$c,$5b,$0,$3,$10,$80,$19
		dc.b	$db,$40,$d,$12,$a2,$0,$d3,$4,$82,$c,$5b,$0,$8,$10,$80,$19
		dc.b	$db,$40,$12,$12,$a2,$0,$b,$3,$64,$0,$b3,$8,$82,$c,$4e,$0
		dc.b	$0,$19,$db,$40,$a,$2,$a2,$0,$b3,$6,$82,$c,$4e,$0,$4,$19
		dc.b	$db,$40,$e,$2,$a2,$0,$0,$0,$4e,$0,$1e,$3,$0,$0,$4e,$0
		dc.b	$4,$0,$9,$0,$0,$0,$61,$0,$10,$6,$66,$0,$b,$61,$a8,$61
		dc.b	$a8,$0,$0,$0,$0,$1,$15,$cf,$51,$1,$14,$ca,$4d,$1,$40,$22
		dc.b	$40,$1,$42,$1c,$42,$1,$5e,$fd,$19,$1,$5d,$f6,$19,$1,$45,$bf
		dc.b	$ee,$1,$41,$ba,$ef,$1,$45,$1,$bb,$1,$44,$fb,$bc,$1,$13,$c3
		dc.b	$b7,$1,$12,$be,$bb,$2,$f3,$7,$81,$c1,$4d,$1,$41,$c2,$d,$40
		dc.b	$80,$18,$bb,$40,$0,$40,$80,$18,$bb,$40,$5,$40,$80,$18,$bb,$40
		dc.b	$8,$40,$80,$18,$bb,$40,$d,$40,$80,$18,$bb,$40,$10,$40,$80,$18
		dc.b	$bb,$40,$15,$40,$80,$0,$0,$41,$6,$1e,$e5,$16,$0,$4,$0,$0
		dc.b	$4,$6,$8,$6,$c,$6,$10,$6,$12,$6,$e,$6,$a,$6,$6,$6
		dc.b	$2,$0,$0,$40,$a6,$1e,$e5,$16,$0,$4,$0,$0,$1,$6,$5,$6
		dc.b	$9,$6,$d,$6,$f,$6,$b,$6,$7,$6,$3,$6,$2,$0,$0,$42
		dc.b	$a6,$1e,$e5,$16,$0,$4,$10,$0,$14,$6,$15,$6,$11,$6,$d,$6
		dc.b	$f,$6,$13,$6,$17,$6,$16,$6,$12,$0,$0,$0,$0,$0,$92,$0
		dc.b	$1e,$5,$0,$0,$6e,$0,$28,$0,$9,$0,$0,$0,$7d,$0,$15,$6
		dc.b	$66,$0,$b,$7d,$0,$7d,$0,$0,$0,$0,$0,$1,$0,$2,$0,$1
		dc.b	$32,$14,$32,$1,$32,$11,$ce,$1,$4b,$0,$52,$1,$52,$0,$b5,$1
		dc.b	$28,$2,$20,$1,$20,$2,$d8,$1,$e7,$0,$64,$1,$32,$0,$57,$1
		dc.b	$64,$0,$32,$1,$70,$0,$e7,$1,$0,$0,$83,$1,$4b,$15,$0,$1
		dc.b	$0,$12,$43,$1,$19,$12,$b5,$1,$e7,$13,$c2,$1,$c2,$12,$19,$1
		dc.b	$4b,$12,$e7,$1,$4b,$0,$4d,$1,$4d,$0,$ab,$0,$0,$77,$d7,$0
		dc.b	$d9,$78,$fd,$0,$0,$79,$24,$0,$27,$78,$fd,$2,$0,$6c,$42,$2
		dc.b	$51,$61,$fe,$4,$0,$68,$b8,$3,$af,$61,$fe,$2,$0,$7e,$fd,$ff
		dc.b	$e6,$2,$cc,$27,$10,$44,$4,$3,$4,$5,$2,$0,$12,$44,$4,$3
		dc.b	$6,$7,$2,$0,$a,$44,$4,$6,$4,$8,$2,$0,$c,$44,$4,$5
		dc.b	$8,$9,$4,$0,$e,$44,$4,$7,$5,$9,$3,$0,$10,$0,$6,$0
		dc.b	$0,$3,$cc,$13,$a,$44,$3,$0,$2,$3,$2,$44,$3,$0,$2,$4
		dc.b	$4,$44,$3,$0,$4,$5,$6,$44,$3,$0,$3,$5,$8,$44,$4,$3
		dc.b	$6,$7,$2,$0,$a,$44,$4,$6,$4,$8,$2,$0,$c,$44,$4,$5
		dc.b	$8,$9,$4,$0,$e,$44,$4,$7,$5,$9,$3,$0,$10,$0,$6,$0
		dc.b	$0,$44,$5,$10,$2,$2,$2,$2,$a,$a,$0,$8,$b,$b,$3,$8
		dc.b	$1a,$1a,$2,$0,$0,$44,$5,$10,$4,$2,$2,$2,$a,$a,$0,$8
		dc.b	$c,$c,$4,$8,$22,$18,$2,$0,$0,$44,$5,$10,$6,$2,$4,$4
		dc.b	$c,$c,$0,$8,$d,$d,$5,$8,$1e,$1c,$4,$0,$0,$44,$5,$10
		dc.b	$8,$2,$5,$5,$d,$d,$0,$8,$b,$b,$3,$8,$20,$19,$5,$0
		dc.b	$0,$44,$5,$14,$a,$2,$2,$2,$1a,$1a,$3,$8,$25,$25,$7,$8
		dc.b	$e,$10,$6,$8,$24,$24,$2,$0,$0,$44,$5,$14,$c,$2,$2,$2
		dc.b	$18,$22,$4,$8,$26,$26,$8,$8,$14,$12,$6,$8,$24,$24,$2,$0
		dc.b	$0,$44,$5,$14,$e,$2,$4,$4,$1c,$1e,$5,$8,$27,$27,$9,$8
		dc.b	$16,$16,$8,$8,$26,$26,$4,$0,$0,$44,$5,$14,$10,$2,$3,$3
		dc.b	$19,$20,$5,$8,$27,$27,$9,$8,$15,$13,$7,$8,$25,$25,$3,$0
		dc.b	$0,$0,$6,$0,$0,$0,$3e,$0,$1e,$2,$0,$0,$3e,$0,$4,$0
		dc.b	$f,$0,$0,$0,$66,$0,$1b,$6,$66,$0,$11,$66,$ff,$66,$ff,$0
		dc.b	$0,$0,$0,$1,$1b,$0,$22,$1,$66,$0,$1b,$1,$29,$0,$59,$1
		dc.b	$59,$0,$60,$5,$1,$0,$1,$5,$1,$0,$3,$5,$1,$0,$5,$5
		dc.b	$1,$0,$7,$e0,$6,$0,$cd,$0,$ac,$a,$ba,$16,$4,$7,$e,$f
		dc.b	$6,$0,$0,$0,$0,$13,$8e,$0,$0,$13,$8e,$0,$1,$13,$8e,$0
		dc.b	$2,$13,$8e,$0,$3,$13,$8e,$0,$4,$13,$8e,$0,$5,$13,$8e,$0
		dc.b	$6,$13,$8e,$0,$7,$13,$8e,$0,$8,$13,$8e,$0,$9,$13,$8e,$0
		dc.b	$a,$13,$8e,$0,$b,$13,$8e,$0,$c,$13,$8e,$0,$d,$13,$8e,$0
		dc.b	$e,$13,$8e,$0,$f,$0,$0,$0,$3e,$0,$1e,$1,$c0,$0,$3a,$0
		dc.b	$8,$0,$11,$0,$0,$0,$50,$0,$1d,$6,$66,$0,$13,$50,$1b,$50
		dc.b	$1b,$0,$0,$0,$0,$1,$13,$0,$f,$1,$b0,$0,$f1,$1,$44,$0
		dc.b	$7,$1,$da,$0,$f9,$1,$40,$0,$16,$1,$c7,$0,$ea,$1,$13,$ea
		dc.b	$f,$c,$0,$7f,$0,$0,$ac,$7,$72,$58,$44,$b,$9,$a,$8,$0
		dc.b	$2,$0,$0,$0,$b,$80,$2,$13,$7b,$0,$0,$10,$80,$13,$ce,$28
		dc.b	$1,$13,$ae,$28,$3,$13,$6e,$28,$5,$13,$ce,$0,$7,$13,$6e,$23
		dc.b	$8,$13,$ce,$28,$9,$0,$0,$0,$36,$0,$1e,$1,$80,$0,$36,$0
		dc.b	$4,$0,$11,$0,$0,$0,$4c,$0,$1d,$6,$66,$0,$13,$4c,$e7,$4c
		dc.b	$e7,$0,$0,$0,$0,$1,$12,$ff,$12,$1,$b4,$ff,$ee,$1,$41,$ff
		dc.b	$9,$1,$dc,$ff,$f7,$1,$3e,$ff,$1b,$1,$ca,$ff,$e5,$0,$ac,$8
		dc.b	$58,$1,$4,$b,$9,$a,$8,$0,$0,$0,$0,$16,$fb,$0,$0,$41
		dc.b	$19,$16,$db,$28,$1,$32,$2a,$16,$db,$23,$2,$31,$18,$16,$fb,$28
		dc.b	$3,$31,$18,$16,$fb,$b,$4,$31,$19,$16,$db,$28,$5,$31,$19,$16
		dc.b	$fb,$0,$6,$41,$19,$16,$db,$0,$7,$31,$19,$16,$fb,$23,$8,$42
		dc.b	$2a,$16,$db,$28,$9,$32,$2a,$16,$db,$0,$a,$31,$18,$16,$fb,$b
		dc.b	$b,$31,$19,$0,$0,$0,$54,$0,$10,$3,$c0,$0,$4c,$0,$c,$0
		dc.b	$6,$0,$0,$0,$41,$1,$a,$0,$0,$1,$a,$0,$41,$1,$a,$f6
		dc.b	$0,$1,$a,$f6,$41,$b,$1,$0,$1,$b,$1,$2,$3,$13,$c4,$8
		dc.b	$4,$13,$c4,$a,$6,$b,$1,$0,$8,$1,$5,$0,$20,$13,$c3,$10
		dc.b	$12,$1,$5,$c9,$20,$1,$5,$3,$37,$13,$c3,$18,$16,$b,$1,$14
		dc.b	$1a,$0,$0,$81,$0,$12,$7f,$0,$0,$0,$b4,$0,$81,$11,$4,$1
		dc.b	$2,$3,$0,$0,$2,$0,$0,$c1,$7d,$4f,$81,$c4,$5d,$2,$c1,$c3
		dc.b	$6d,$48,$81,$c3,$1d,$48,$c3,$0,$d3,$0,$c4,$20,$6,$0,$1,$10
		dc.b	$4,$2,$1,$3,$0,$0,$2,$0,$6,$11,$8,$c,$2,$e,$0,$0
		dc.b	$0,$5,$f3,$0,$c3,$0,$cc,$3,$f6,$10,$1,$28,$a,$1a,$0,$fe
		dc.b	$e2,$1a,$14,$0,$0,$42,$6,$fe,$e2,$14,$1a,$1,$4b,$3,$2c,$fe
		dc.b	$e2,$2,$1c,$0,$cb,$1,$8,$fe,$e1,$8,$2,$1c,$0,$fe,$e1,$8
		dc.b	$2,$1a,$0,$42,$26,$fe,$e2,$15,$1b,$fe,$e2,$3,$1d,$0,$cb,$1
		dc.b	$8,$fe,$e1,$8,$2,$1d,$0,$fe,$e1,$8,$2,$1b,$0,$41,$6,$0
		dc.b	$4b,$2,$c6,$fe,$e2,$1c,$1d,$10,$11,$1b,$1a,$8,$84,$8,$85,$4
		dc.b	$44,$4,$44,$0,$0,$0,$4e,$0,$1e,$1,$c0,$0,$3a,$0,$18,$0
		dc.b	$6,$0,$0,$0,$46,$0,$11,$6,$66,$0,$8,$46,$50,$46,$50,$0
		dc.b	$72,$0,$0,$1,$38,$0,$2e,$1,$2a,$e9,$2c,$1,$25,$0,$ba,$1
		dc.b	$20,$ee,$15,$1,$1e,$fc,$d1,$1,$4,$fc,$d1,$1,$7,$ee,$15,$0
		dc.b	$6c,$c1,$ef,$2,$0,$84,$e7,$0,$0,$f4,$7e,$0,$0,$81,$0,$0
		dc.b	$94,$3f,$11,$44,$47,$0,$2,$4,$2,$44,$44,$4,$3,$5,$2,$0
		dc.b	$4,$10,$4,$1,$2,$3,$0,$0,$6,$0,$13,$e,$97,$88,$88,$c
		dc.b	$8,$a,$6,$0,$4,$0,$0,$40,$10,$a,$b,$8,$0,$0,$0,$0
		dc.b	$24,$0,$10,$1,$40,$0,$24,$0,$4,$0,$6,$0,$0,$0,$5d,$1
		dc.b	$0,$f,$5d,$1,$0,$f,$0,$1,$1f,$f,$17,$1,$17,$f,$2e,$1
		dc.b	$f,$f,$46,$88,$82,$ff,$2,$88,$82,$0,$2,$88,$82,$4,$5,$88
		dc.b	$82,$6,$7,$88,$82,$8,$9,$0,$0,$0,$3c,$0,$10,$2,$c0,$0
		dc.b	$3c,$0,$4,$0,$6,$0,$0,$0,$7d,$1,$0,$19,$7d,$1,$0,$19
		dc.b	$0,$1,$1f,$19,$1f,$1,$17,$19,$3e,$1,$f,$19,$5d,$1,$0,$3
		dc.b	$2b,$1,$0,$9,$4b,$1,$0,$f,$6a,$1,$0,$2e,$2b,$1,$0,$28
		dc.b	$4b,$1,$0,$22,$6a,$88,$82,$ff,$2,$88,$82,$0,$2,$88,$82,$4
		dc.b	$5,$88,$82,$6,$7,$88,$82,$8,$9,$0,$b,$6,$1a,$88,$82,$a
		dc.b	$10,$88,$82,$c,$12,$88,$82,$e,$14,$0,$0,$0,$28,$0,$10,$1
		dc.b	$0,$0,$20,$0,$c,$0,$5,$0,$0,$0,$5d,$1,$0,$0,$0,$1
		dc.b	$0,$0,$5d,$1,$b,$0,$0,$1,$b,$0,$2e,$0,$0,$0,$81,$2
		dc.b	$0,$0,$7f,$0,$6c,$9,$26,$44,$42,$0,$2,$0,$0,$44,$51,$2
		dc.b	$0,$3,$2,$3,$84,$0,$0,$1,$0,$0,$93,$6,$c1,$44,$42,$6
		dc.b	$4,$44,$42,$7,$5,$0,$0,$0,$90,$0,$10,$4,$c0,$0,$5c,$0
		dc.b	$38,$0,$5,$0,$0,$0,$4e,$1,$0,$4e,$f7,$1,$27,$3e,$6,$1
		dc.b	$d9,$1f,$25,$1,$0,$f,$35,$1,$0,$1f,$0,$1,$0,$3e,$1f,$1
		dc.b	$0,$0,$0,$1,$17,$4e,$fc,$1,$1f,$46,$1,$1,$2e,$36,$e,$1
		dc.b	$2e,$27,$1d,$1,$1f,$17,$2a,$1,$17,$f,$30,$1,$0,$3e,$f7,$1
		dc.b	$0,$2e,$ef,$1,$0,$17,$f,$1,$0,$f,$1f,$1,$17,$2a,$fc,$1
		dc.b	$17,$1a,$f,$0,$da,$17,$76,$2,$b9,$4a,$4a,$8,$df,$75,$22,$8
		dc.b	$21,$75,$22,$3,$47,$4a,$4a,$3,$26,$17,$76,$0,$26,$e9,$8a,$2
		dc.b	$47,$b6,$b6,$8,$21,$8b,$de,$8,$df,$8b,$de,$3,$b9,$b6,$b6,$3
		dc.b	$da,$e9,$8a,$8,$0,$7f,$0,$5,$2c,$3,$c,$88,$82,$8,$c,$22
		dc.b	$23,$0,$2,$8,$2,$22,$23,$2,$5,$8,$4,$22,$23,$8,$5,$6
		dc.b	$6,$22,$23,$8,$4,$6,$8,$22,$23,$3,$4,$8,$a,$22,$23,$3
		dc.b	$0,$8,$c,$fe,$e2,$8,$a,$22,$23,$0,$2,$8,$e,$22,$23,$2
		dc.b	$5,$8,$10,$22,$23,$8,$5,$6,$12,$22,$23,$8,$4,$6,$14,$22
		dc.b	$23,$3,$4,$8,$16,$22,$23,$3,$0,$8,$18,$0,$0,$22,$30,$c
		dc.b	$8,$3,$1a,$3,$0,$22,$25,$10,$2,$2,$0,$0,$e,$10,$2,$8
		dc.b	$22,$22,$8,$8,$1c,$1a,$0,$0,$0,$22,$25,$10,$4,$2,$2,$2
		dc.b	$12,$14,$5,$8,$24,$24,$8,$8,$22,$22,$2,$0,$0,$22,$25,$10
		dc.b	$6,$2,$5,$5,$16,$18,$6,$8,$20,$1e,$8,$8,$24,$24,$5,$0
		dc.b	$0,$22,$25,$10,$8,$2,$6,$6,$19,$17,$4,$8,$25,$25,$8,$8
		dc.b	$1e,$20,$6,$0,$0,$22,$25,$10,$a,$2,$4,$4,$15,$13,$3,$8
		dc.b	$23,$23,$8,$8,$25,$25,$4,$0,$0,$22,$25,$10,$c,$2,$3,$3
		dc.b	$11,$f,$0,$8,$1a,$1c,$8,$8,$23,$23,$3,$0,$0,$fe,$e2,$8
		dc.b	$a,$22,$25,$10,$e,$2,$0,$0,$e,$10,$2,$8,$22,$22,$8,$8
		dc.b	$1c,$1a,$0,$0,$0,$22,$25,$10,$10,$2,$2,$2,$12,$14,$5,$8
		dc.b	$24,$24,$8,$8,$22,$22,$2,$0,$0,$22,$25,$10,$12,$2,$5,$5
		dc.b	$16,$18,$6,$8,$20,$1e,$8,$8,$24,$24,$5,$0,$0,$22,$25,$10
		dc.b	$14,$2,$6,$6,$19,$17,$4,$8,$25,$25,$8,$8,$1e,$20,$6,$0
		dc.b	$0,$22,$25,$10,$16,$2,$4,$4,$15,$13,$3,$8,$23,$23,$8,$8
		dc.b	$25,$25,$4,$0,$0,$22,$25,$10,$18,$2,$3,$3,$11,$f,$0,$8
		dc.b	$1a,$1c,$8,$8,$23,$23,$3,$0,$0,$0,$0,$0,$58,$0,$10,$4
		dc.b	$80,$0,$58,$0,$4,$0,$0,$0,$0,$0,$0,$b,$1,$c,$1c,$b
		dc.b	$1,$16,$1c,$b,$1,$18,$1e,$b,$1,$ff,$fd,$b,$1,$ff,$fe,$b
		dc.b	$1,$fe,$6,$b,$1,$6,$8,$b,$1,$6,$c,$b,$1,$8,$c,$b
		dc.b	$1,$a,$e,$b,$1,$a,$10,$b,$1,$ff,$e,$b,$1,$ff,$10,$b
		dc.b	$1,$e,$16,$b,$1,$10,$18,$b,$1,$ff,$16,$b,$1,$ff,$18,$b
		dc.b	$1,$c,$1a,$91,$4,$10,$e,$a,$ff,$0,$0,$99,$83,$a,$12,$14
		dc.b	$0,$99,$83,$e,$c,$12,$0,$99,$83,$10,$c,$14,$0,$99,$83,$1a
		dc.b	$22,$e,$0,$99,$83,$10,$0,$1c,$0,$99,$83,$2,$18,$1c,$0,$99
		dc.b	$83,$2,$16,$1a,$0,$99,$83,$4,$16,$1e,$0,$99,$83,$4,$18,$20
		ds.b	4
		dc.b	$30,$0,$10,$1,$c0,$0,$2c,$0,$8,$0,$3,$0,$0,$0,$6a,$1
		dc.b	$44,$0,$6a,$5,$1,$0,$1,$1,$3e,$0,$44,$1,$32,$0,$ee,$1
		dc.b	$28,$0,$e1,$1,$2e,$0,$d5,$1,$28,$0,$c8,$0,$0,$7e,$0,$3
		dc.b	$ab,$80,$2,$88,$84,$2,$1,$3,$0,$0,$2,$0,$b,$11,$16,$80
		dc.b	$a,$3,$2,$41,$5,$40,$46,$1,$ac,$2,$32,$0,$1a,$0,$2,$11
		dc.b	$2,$6,$7,$11,$2,$c,$d,$0,$8b,$c,$34,$11,$2,$8,$9,$11
		dc.b	$2,$a,$b,$0,$0,$0,$a,$1,$2,$41,$7,$40,$47,$0,$0,$0
		dc.b	$24,$0,$10,$1,$0,$0,$20,$0,$8,$0,$c,$0,$0,$0,$7a,$1
		dc.b	$3d,$0,$3d,$5,$1,$0,$0,$1,$7a,$0,$7a,$5,$1,$0,$5,$4
		dc.b	$0,$7e,$0,$0,$ac,$e,$c8,$44,$44,$5,$6,$7,$4,$0,$2,$0
		dc.b	$0,$19,$ee,$0,$0,$19,$ee,$b,$1,$19,$ee,$28,$2,$19,$ee,$23
		dc.b	$3,$0,$6,$0,$0,$0,$a0,$0,$10,$8,$0,$0,$90,$0,$14,$0
		dc.b	$b,$0,$0,$0,$7a,$1,$30,$0,$3a,$5,$1,$0,$0,$1,$30,$18
		dc.b	$3a,$1,$d0,$18,$c6,$1,$6b,$0,$7a,$1,$c1,$13,$f7,$1,$6b,$e
		dc.b	$7a,$1,$95,$e,$f7,$1,$6b,$0,$86,$1,$95,$e,$9,$1,$6b,$e
		dc.b	$86,$1,$c1,$13,$9,$1,$30,$0,$75,$1,$d0,$0,$53,$1,$30,$9
		dc.b	$75,$1,$d0,$9,$53,$1,$18,$0,$a4,$1,$e8,$0,$86,$1,$18,$13
		dc.b	$a4,$1,$e8,$13,$86,$1,$4e,$0,$86,$1,$c1,$0,$86,$1,$4e,$e
		dc.b	$86,$1,$c1,$13,$86,$1,$4e,$0,$7a,$1,$c1,$0,$7a,$1,$4e,$e
		dc.b	$7a,$1,$c1,$13,$7a,$1,$3f,$0,$9,$1,$3f,$0,$f7,$1,$6b,$0
		dc.b	$9,$1,$6b,$0,$f7,$4,$0,$7f,$0,$4,$0,$0,$7f,$4,$7f,$0
		dc.b	$0,$6,$0,$0,$81,$ff,$e6,$6,$8b,$4,$c4,$44,$44,$30,$2c,$28
		dc.b	$34,$0,$7,$44,$44,$21,$24,$20,$25,$0,$4,$44,$44,$1a,$1f,$1b
		dc.b	$1e,$0,$8,$44,$44,$3b,$2e,$2a,$a,$0,$6,$44,$44,$32,$16,$39
		dc.b	$36,$0,$6,$44,$44,$0,$5,$1,$4,$0,$4,$44,$48,$0,$7,$3
		dc.b	$4,$0,$6,$44,$44,$2,$7,$3,$6,$0,$8,$44,$48,$18,$1f,$1b
		dc.b	$1c,$0,$6,$44,$44,$3d,$16,$39,$12,$0,$8,$44,$44,$3f,$a,$3b
		dc.b	$e,$0,$4,$44,$44,$20,$27,$23,$24,$0,$6,$44,$44,$21,$26,$22
		dc.b	$25,$0,$7,$4,$8b,$9,$88,$44,$44,$18,$1d,$19,$1c,$0,$4,$66
		dc.b	$64,$32,$d,$9,$36,$0,$4,$88,$84,$8,$34,$30,$c,$0,$4,$22
		dc.b	$24,$8,$14,$10,$c,$0,$6,$44,$44,$28,$14,$10,$2c,$0,$8,$66
		dc.b	$64,$22,$27,$23,$26,$0,$8,$88,$84,$11,$2e,$2a,$15,$0,$8,$22
		dc.b	$24,$3f,$15,$11,$e,$0,$7,$44,$44,$9,$12,$3d,$d,$0,$7,$44
		dc.b	$44,$7,$5,$6,$4,$0,$2,$66,$64,$14,$34,$2c,$c,$0,$2,$88
		dc.b	$84,$1f,$1d,$1e,$1c,$0,$2,$22,$24,$27,$25,$26,$24,$0,$2,$44
		dc.b	$44,$12,$36,$16,$d,$0,$2,$66,$64,$e,$2e,$a,$15,$0,$2,$0
		dc.b	$0,$0,$28,$0,$10,$1,$80,$0,$28,$0,$4,$0,$8,$0,$0,$0
		dc.b	$7d,$1,$c2,$7d,$0,$1,$f9,$7,$0,$1,$f9,$7d,$0,$1,$c2,$7
		dc.b	$0,$b,$1,$2,$6,$1,$e9,$7,$0,$0,$ac,$f,$42,$99,$84,$6
		dc.b	$4,$2,$0,$0,$0,$0,$0,$c2,$fd,$7,$c2,$1,$34,$0,$c2,$99
		dc.b	$84,$6,$4,$2,$0,$0,$0,$11,$a,$7,$0,$40,$a,$40,$48,$0
		dc.b	$0,$c2,$1d,$1,$c2,$1,$74,$0,$c2,$71,$4,$6,$4,$2,$0,$0
		dc.b	$0,$0,$5c,$24,$7a,$99,$8a,$8,$0,$46,$8,$40,$49,$0,$0,$c2
		dc.b	$1d,$1,$c2,$1,$34,$0,$c2,$11,$4,$6,$4,$2,$0,$0,$0,$99
		dc.b	$8a,$8,$0,$40,$8,$40,$4a,$0,$0,$c2,$1d,$1,$c2,$1,$34,$0
		dc.b	$c2,$99,$84,$6,$4,$2,$0,$0,$0,$11,$6a,$9,$0,$40,$8,$40
		dc.b	$4b,$0,$0,$c2,$1d,$1,$c2,$1,$34,$0,$c2,$99,$84,$6,$4,$2
		dc.b	$0,$0,$0,$71,$a,$7,$0,$40,$a,$40,$4c,$0,$0,$c2,$1d,$1
		dc.b	$c2,$1,$34,$0,$c2,$fe,$4,$6,$4,$2,$0,$0,$0,$11,$a,$9
		dc.b	$0,$40,$8,$40,$4d,$0,$0,$c2,$1d,$1,$c2,$1,$34,$0,$c2,$11
		dc.b	$64,$6,$4,$2,$0,$0,$0,$99,$8a,$8,$0,$40,$8,$40,$4e,$0
		dc.b	$0,$c2,$1d,$1,$c2,$1,$34,$0,$c2,$17,$4,$6,$4,$2,$0,$0
		dc.b	$0,$99,$8a,$8,$0,$40,$a,$40,$4f,$0,$0,$0,$0,$0,$e6,$0
		dc.b	$1e,$9,$c0,$0,$ba,$0,$30,$0,$e,$0,$0,$0,$7a,$0,$19,$6
		dc.b	$66,$0,$10,$7a,$12,$7a,$12,$2,$f8,$0,$0,$1,$0,$4,$0,$1
		dc.b	$6,$4,$a,$1,$c,$4,$0,$1,$6,$4,$f6,$b,$1,$2,$3,$13
		dc.b	$c2,$8,$0,$13,$c2,$4,$a,$13,$c2,$6,$c,$13,$c2,$7,$e,$13
		dc.b	$c2,$5,$10,$13,$c2,$3,$12,$13,$c2,$2,$14,$1,$0,$4,$ee,$1
		dc.b	$3d,$0,$e0,$1,$12,$0,$30,$1,$24,$0,$34,$5,$1,$0,$1b,$5
		dc.b	$1,$0,$1d,$5,$1,$0,$1f,$1,$6,$0,$a,$1,$c,$0,$0,$5
		dc.b	$1,$0,$27,$1,$1e,$0,$1f,$1,$61,$0,$ab,$1,$3,$0,$f6,$1
		dc.b	$f,$0,$1a,$1,$1e,$0,$0,$5,$1,$0,$33,$1,$6,$4,$e8,$1
		dc.b	$f,$0,$d6,$1,$0,$0,$7a,$1,$0,$0,$30,$1,$7a,$0,$0,$1
		dc.b	$30,$0,$0,$5,$1,$0,$3c,$5,$1,$0,$3e,$1,$3,$3,$f6,$13
		dc.b	$81,$48,$30,$b,$1,$6,$48,$2c,$0,$7f,$0,$2,$93,$0,$c1,$4
		dc.b	$93,$0,$3f,$6,$0,$0,$7f,$2,$0,$0,$81,$6,$3b,$70,$0,$6
		dc.b	$0,$7f,$0,$2,$20,$79,$12,$34,$20,$79,$ee,$38,$0,$7a,$e0,$3
		dc.b	$0,$79,$25,$c2,$d,$40,$81,$0,$53,$10,$c0,$c2,$1d,$1,$40,$1
		dc.b	$54,$0,$c2,$f0,$1a,$0,$0,$11,$8e,$c0,$46,$3c,$44,$7f,$3e,$11
		dc.b	$8e,$c0,$43,$40,$41,$7f,$42,$90,$1a,$82,$0,$9,$0,$1,$8,$1
		dc.b	$0,$9,$0,$1,$80,$9,$8,$9,$0,$a,$ab,$1,$30,$e0,$6,$0
		dc.b	$c,$54,$45,$e,$2,$4,$26,$0,$28,$6,$2a,$6,$2b,$6,$29,$6
		dc.b	$27,$0,$0,$88,$88,$26,$4,$28,$2,$0,$4,$1,$8,$28,$6,$2a
		dc.b	$4,$0,$6,$1,$4,$26,$3,$27,$2,$0,$a,$1,$14,$10,$c0,$1
		dc.b	$4,$48,$31,$49,$30,$0,$8,$f0,$a,$a,$8,$7c,$30,$40,$50,$1
		dc.b	$13,$10,$c0,$1,$4,$4a,$49,$4b,$48,$0,$8,$f0,$a,$a,$8,$7c
		dc.b	$4a,$40,$51,$88,$85,$14,$8,$4,$6,$0,$7,$6,$2b,$6,$2a,$a
		dc.b	$0,$4,$30,$0,$31,$6,$49,$6,$48,$0,$0,$3,$8b,$0,$3c,$1
		dc.b	$a,$9,$8,$64,$4c,$30,$16,$fe,$a,$1a,$a,$4c,$27,$40,$52,$88
		dc.b	$8a,$9,$a,$4c,$3,$40,$53,$d,$1c,$55,$75,$83,$3c,$0,$40,$fe
		dc.b	$a,$1a,$6,$46,$28,$40,$54,$d,$1c,$aa,$4a,$83,$3c,$0,$40,$fe
		dc.b	$a,$1a,$7,$46,$2b,$40,$55,$3,$13,$0,$c2,$0,$1a,$0,$82,$40
		dc.b	$6,$88,$83,$2,$4,$16,$0,$88,$83,$4,$16,$c,$0,$1,$3,$4
		dc.b	$6,$c,$0,$88,$83,$6,$7,$e,$0,$1,$3,$5,$7,$10,$0,$88
		dc.b	$83,$3,$5,$12,$0,$1,$3,$2,$3,$14,$0,$0,$14,$10,$c0,$0
		dc.b	$6,$1,$8,$4,$32,$34,$2,$0,$10,$88,$84,$2,$33,$32,$3,$0
		dc.b	$16,$88,$88,$4,$36,$6,$34,$0,$12,$43,$6,$1,$8,$36,$38,$3a
		dc.b	$6,$0,$c,$88,$84,$39,$3a,$3b,$38,$0,$14,$1,$4,$7,$38,$39
		dc.b	$6,$0,$e,$1a,$e,$0,$18,$0,$b,$3,$d0,$45,$c6,$c3,$5d,$5
		dc.b	$80,$c4,$fd,$1,$83,$c4,$d,$7,$c4,$0,$3c,$0,$c3,$f,$7b,$6
		dc.b	$2e,$48,$80,$0,$73,$d,$82,$16,$9b,$0,$1a,$44,$44,$0,$b3,$e
		dc.b	$82,$c1,$d,$40,$4,$16,$bb,$0,$1b,$1c,$44,$0,$73,$4,$82,$16
		dc.b	$9b,$0,$1d,$30,$8,$0,$b3,$5,$82,$c1,$d,$40,$3,$16,$bb,$0
		dc.b	$1e,$1c,$44,$e5,$86,$0,$18,$88,$8a,$c,$2,$69,$2c,$30,$16,$0
		dc.b	$b,$2,$dc,$0,$73,$7,$82,$16,$9b,$0,$20,$34,$44,$0,$b3,$8
		dc.b	$82,$c1,$d,$40,$3,$16,$bb,$0,$21,$1c,$44,$0,$b,$1,$6e,$0
		dc.b	$73,$3,$82,$16,$9b,$0,$1c,$24,$44,$0,$73,$a,$82,$16,$9b,$0
		dc.b	$23,$24,$44,$0,$b3,$c,$82,$c1,$d,$40,$2,$16,$bb,$0,$25,$1c
		dc.b	$44,$0,$73,$b,$82,$16,$9b,$0,$24,$20,$8,$0,$b,$0,$f4,$0
		dc.b	$73,$9,$82,$16,$9b,$0,$22,$14,$44,$0,$73,$6,$82,$16,$9b,$0
		dc.b	$1f,$14,$44,$0,$0,$80,$80,$0,$d0,$0,$18,$40,$20,$4,$5,$6
		dc.b	$7,$8,$a,$0,$0,$0,$5a,$0,$1e,$1,$c0,$0,$3a,$0,$24,$0
		dc.b	$b,$0,$0,$0,$41,$0,$16,$6,$66,$0,$d,$41,$eb,$41,$eb,$0
		dc.b	$c0,$0,$0,$1,$6,$0,$6,$5,$1,$0,$1,$1,$6,$30,$6,$1
		dc.b	$6,$30,$fa,$1,$c,$3d,$c,$1,$c,$3d,$f4,$1,$0,$41,$0,$0
		dc.b	$7f,$0,$0,$0,$0,$0,$7f,$6,$0,$c8,$8f,$7,$0,$0,$81,$4
		dc.b	$71,$c8,$0,$4,$0,$c8,$71,$5,$8f,$c8,$0,$8,$0,$7f,$0,$0
		dc.b	$cc,$6,$ac,$88,$82,$ff,$c,$f0,$1,$e2,$4,$c,$80,$0,$0,$44
		dc.b	$48,$4,$2,$6,$0,$0,$2,$44,$44,$4,$1,$5,$0,$0,$4,$44
		dc.b	$44,$3,$6,$2,$7,$0,$8,$6,$64,$8,$6,$a,$4,$0,$a,$6
		dc.b	$64,$8,$5,$9,$4,$0,$c,$6,$64,$9,$7,$b,$5,$0,$e,$6
		dc.b	$64,$a,$7,$b,$6,$0,$6,$0,$b4,$c,$81,$44,$44,$9,$a,$b
		dc.b	$8,$0,$10,$0,$0,$80,$4,$9,$a,$b,$8,$0,$10,$f0,$1,$e2
		dc.b	$4,$c,$80,$0,$0,$d0,$80,$2,$3,$4,$8,$10,$0,$0,$0,$0
		dc.b	$fe,$0,$1e,$c,$0,$0,$de,$0,$24,$0,$e,$0,$0,$0,$5b,$0
		dc.b	$19,$6,$66,$0,$10,$5b,$8d,$5b,$8d,$3,$50,$0,$0,$1,$c,$3
		dc.b	$4c,$1,$e,$7,$38,$1,$c,$0,$4c,$1,$12,$0,$33,$1,$12,$5
		dc.b	$ca,$1,$12,$5,$ae,$1,$12,$0,$ca,$1,$12,$0,$ae,$1,$c,$0
		dc.b	$33,$1,$12,$0,$28,$1,$1d,$0,$2b,$1,$1b,$0,$3a,$1,$1,$0
		dc.b	$17,$1,$15,$0,$24,$1,$1b,$0,$28,$1,$1d,$0,$2b,$1,$26,$0
		dc.b	$24,$1,$1,$0,$e5,$1,$1,$0,$e1,$1,$1,$0,$d8,$1,$9,$0
		dc.b	$dc,$1,$9,$0,$d8,$1,$2d,$0,$ec,$1,$38,$0,$f2,$1,$3c,$0
		dc.b	$f4,$1,$3a,$0,$fb,$1,$2d,$0,$e9,$1,$38,$0,$ec,$1,$3c,$0
		dc.b	$f2,$1,$43,$0,$eb,$1,$54,$0,$ca,$1,$58,$0,$cc,$1,$11,$0
		dc.b	$5b,$1,$b,$0,$59,$1,$40,$0,$33,$1,$50,$0,$12,$1,$1d,$0
		dc.b	$fd,$1,$33,$0,$ca,$1,$1b,$0,$f9,$1,$2f,$0,$ca,$1,$4c,$0
		dc.b	$31,$b,$1,$40,$42,$1,$0,$0,$0,$1,$1b,$0,$15,$1,$43,$0
		dc.b	$c6,$1,$7,$0,$ee,$1,$0,$0,$d3,$1,$33,$0,$a5,$8,$0,$7e
		dc.b	$0,$0,$0,$7c,$16,$0,$0,$0,$7f,$0,$75,$2c,$12,$2,$0,$4c
		dc.b	$9b,$8,$0,$0,$7f,$8,$7f,$0,$0,$a,$0,$0,$81,$c1,$d,$40
		dc.b	$82,$0,$ac,$7,$26,$54,$44,$41,$3c,$3d,$40,$0,$0,$0,$0,$ea
		dc.b	$86,$47,$86,$1a,$2e,$0,$48,$1a,$2e,$0,$49,$1a,$2e,$0,$4a,$1a
		dc.b	$2e,$0,$4b,$1,$ac,$5,$0,$54,$42,$40,$3e,$54,$42,$41,$3f,$54
		dc.b	$45,$c,$0,$4,$10,$0,$1c,$6,$18,$6,$1d,$6,$11,$0,$0,$0
		dc.b	$0,$54,$45,$3c,$0,$4,$16,$0,$42,$6,$40,$6,$3e,$6,$3c,$6
		dc.b	$3a,$8,$38,$36,$34,$6,$2c,$8,$2e,$30,$32,$6,$20,$8,$1e,$1c
		dc.b	$1a,$a,$0,$2,$1b,$1b,$1d,$1f,$21,$6,$33,$8,$31,$2f,$2d,$6
		dc.b	$35,$8,$37,$39,$3b,$6,$3d,$6,$3f,$6,$41,$6,$43,$6,$17,$0
		dc.b	$0,$4,$4c,$2,$24,$54,$42,$18,$24,$54,$42,$2c,$24,$54,$42,$2d
		dc.b	$25,$54,$42,$4a,$48,$54,$42,$48,$49,$54,$42,$4b,$49,$54,$45,$12
		dc.b	$0,$4,$10,$0,$16,$6,$1a,$6,$18,$6,$19,$6,$1b,$6,$17,$6
		dc.b	$11,$0,$0,$44,$44,$1,$2,$3,$0,$0,$4,$0,$93,$1,$82,$44
		dc.b	$44,$9,$a,$b,$8,$0,$2,$0,$0,$54,$45,$2e,$0,$2,$10,$10
		dc.b	$12,$14,$16,$6,$1a,$6,$18,$6,$22,$8,$24,$26,$28,$6,$2c,$6
		dc.b	$34,$6,$2a,$6,$2b,$6,$35,$6,$2d,$6,$29,$8,$27,$25,$23,$6
		dc.b	$19,$6,$1b,$6,$17,$8,$15,$13,$11,$0,$0,$54,$45,$12,$0,$4
		dc.b	$4e,$0,$4a,$6,$48,$6,$49,$6,$4b,$6,$4f,$6,$4d,$6,$4c,$0
		dc.b	$0,$88,$8a,$e,$0,$41,$51,$40,$56,$1a,$4e,$0,$54,$8,$4b,$0
		dc.b	$b6,$0,$1c,$0,$60,$83,$5c,$90,$76,$c2,$d,$40,$80,$1,$93,$2
		dc.b	$c2,$0,$93,$1,$c2,$fe,$a,$b,$0,$46,$52,$40,$57,$0,$94,$1
		dc.b	$c2,$fe,$a,$b,$0,$46,$52,$40,$58,$1,$94,$2,$c2,$0,$93,$1
		dc.b	$c2,$fe,$a,$b,$0,$46,$52,$40,$59,$0,$94,$1,$c2,$fe,$a,$b
		dc.b	$0,$46,$52,$40,$5a,$0,$1c,$0,$60,$83,$5c,$70,$9,$1,$93,$2
		dc.b	$c2,$0,$93,$1,$c2,$fe,$a,$b,$0,$46,$53,$40,$5b,$0,$94,$1
		dc.b	$c2,$fe,$a,$b,$0,$46,$53,$40,$5c,$1,$94,$2,$c2,$0,$93,$1
		dc.b	$c2,$fe,$a,$b,$0,$46,$53,$40,$5d,$0,$94,$1,$c2,$fe,$a,$b
		dc.b	$0,$46,$53,$40,$5e,$40,$c6,$44,$44,$1,$4,$5,$0,$0,$6,$44
		dc.b	$48,$4,$2,$6,$0,$0,$8,$44,$44,$3,$6,$7,$2,$0,$a,$44
		dc.b	$44,$1,$2,$3,$0,$0,$4,$2,$33,$1,$82,$41,$86,$22,$24,$9
		dc.b	$c,$d,$8,$0,$c,$66,$68,$c,$a,$e,$8,$0,$e,$22,$24,$b
		dc.b	$e,$f,$a,$0,$10,$44,$44,$9,$a,$b,$8,$0,$2,$0,$6,$1a
		dc.b	$e,$0,$5c,$c2,$d,$40,$40,$17,$4e,$23,$44,$17,$4e,$23,$46,$17
		dc.b	$4e,$b,$45,$17,$4e,$b,$47,$c2,$d,$a1,$40,$17,$4e,$0,$5e,$17
		dc.b	$4e,$0,$5f,$0,$6,$1,$4e,$28,$12,$1,$4e,$0,$24,$0,$d3,$e
		dc.b	$c1,$4a,$c6,$1a,$6e,$28,$56,$4a,$e6,$1a,$6e,$0,$57,$0,$d3,$f
		dc.b	$c1,$4b,$6,$1a,$6e,$23,$58,$4b,$26,$1a,$6e,$b,$59,$0,$d3,$10
		dc.b	$c1,$4b,$46,$1a,$6e,$23,$5a,$4b,$66,$1a,$6e,$b,$5b,$0,$0,$80
		dc.b	$80,$0,$d0,$0,$5c,$80,$80,$0,$ba,$23,$44,$80,$80,$0,$ba,$23
		dc.b	$46,$80,$80,$0,$ba,$b,$45,$80,$80,$0,$ba,$b,$47,$80,$80,$0
		dc.b	$ba,$0,$5e,$80,$80,$0,$ba,$0,$5f,$d0,$80,$6,$8,$9,$a,$4
		dc.b	$0,$f0,$80,$2,$80,$f4,$e,$f,$10,$2,$0,$82,$22,$0,$d1,$0
		dc.b	$48,$81,$22,$0,$d1,$0,$49,$84,$22,$0,$d1,$0,$4a,$83,$22,$0
		dc.b	$d1,$0,$4b,$0,$0,$0,$5a,$0,$1e,$2,$c0,$0,$4a,$0,$14,$0
		dc.b	$b,$0,$0,$0,$57,$0,$16,$6,$66,$0,$d,$57,$e4,$57,$e4,$0
		dc.b	$be,$0,$0,$1,$3a,$0,$57,$5,$1,$0,$1,$1,$24,$33,$57,$1
		dc.b	$24,$33,$a9,$1,$1d,$24,$57,$1,$0,$0,$57,$1,$0,$24,$57,$13
		dc.b	$c2,$a,$0,$13,$c2,$c,$8,$1,$d6,$26,$57,$1,$2a,$26,$a9,$0
		dc.b	$0,$0,$7f,$6,$0,$0,$81,$0,$74,$32,$0,$4,$0,$7f,$0,$ff
		dc.b	$e6,$44,$45,$e,$2,$4,$0,$0,$4,$6,$5,$6,$1,$6,$9,$6
		dc.b	$8,$0,$0,$0,$68,$0,$10,$8,$e,$0,$2,$10,$4,$f,$10,$11
		dc.b	$e,$0,$2,$44,$44,$2,$7,$3,$6,$0,$4,$44,$48,$4,$2,$6
		dc.b	$0,$0,$6,$2,$b,$8,$94,$5,$1c,$0,$0,$83,$3c,$c0,$37,$88
		dc.b	$8a,$b,$7,$46,$12,$30,$22,$11,$1c,$0,$0,$83,$3c,$c0,$37,$88
		dc.b	$8a,$b,$6,$46,$14,$30,$22,$44,$44,$5,$6,$7,$4,$0,$8,$0
		dc.b	$6,$0,$0,$d0,$80,$2,$4,$6,$7,$8,$0,$0,$0,$0,$3a,$0
		dc.b	$1e,$0,$c0,$0,$2a,$0,$14,$0,$c,$0,$0,$0,$50,$0,$17,$6
		dc.b	$66,$0,$e,$50,$91,$50,$91,$0,$4e,$0,$0,$1,$24,$0,$49,$1
		dc.b	$50,$0,$0,$1,$24,$0,$b7,$2,$95,$0,$bd,$2,$bf,$0,$6c,$4
		dc.b	$0,$0,$7f,$0,$0,$0,$81,$54,$45,$e,$0,$4,$0,$0,$2,$6
		dc.b	$4,$6,$5,$6,$3,$6,$1,$0,$0,$0,$0,$40,$22,$2,$3,$4
		dc.b	$5,$6,$8,$0,$0,$0,$58,$0,$10,$4,$80,$0,$58,$0,$4,$0
		dc.b	$e,$0,$0,$0,$73,$1,$0,$0,$47,$1,$0,$0,$73,$1,$63,$0
		dc.b	$8d,$1,$1,$0,$47,$1,$1,$0,$6a,$1,$1,$0,$72,$1,$73,$0
		dc.b	$8d,$1,$9,$0,$72,$1,$63,$0,$72,$1,$73,$0,$9d,$1,$72,$0
		dc.b	$72,$1,$72,$0,$63,$5,$1,$0,$11,$5,$1,$0,$13,$5,$1,$0
		dc.b	$15,$5,$1,$0,$17,$5,$1,$0,$5,$5,$1,$0,$d,$0,$b,$5
		dc.b	$6e,$1,$6c,$3,$9e,$54,$42,$0,$2,$54,$42,$23,$22,$54,$42,$22
		dc.b	$c,$54,$42,$c,$d,$54,$42,$d,$23,$0,$0,$2,$6c,$1,$5a,$54
		dc.b	$42,$0,$2,$54,$42,$21,$20,$54,$42,$20,$1a,$54,$42,$1a,$12,$54
		dc.b	$42,$12,$4,$54,$42,$4,$5,$54,$42,$5,$13,$54,$42,$13,$1b,$54
		dc.b	$42,$1b,$21,$0,$0,$54,$45,$1a,$0,$4,$6,$0,$8,$8,$a,$a
		dc.b	$e,$6,$10,$6,$20,$6,$21,$6,$11,$6,$f,$8,$b,$b,$9,$6
		dc.b	$7,$0,$0,$54,$45,$12,$0,$2,$10,$10,$14,$14,$16,$6,$1e,$6
		dc.b	$12,$6,$1a,$8,$22,$22,$20,$0,$0,$54,$45,$1a,$0,$2,$1e,$1e
		dc.b	$1c,$1c,$18,$6,$19,$8,$1d,$1d,$1f,$6,$13,$8,$d,$d,$5,$6
		dc.b	$4,$8,$c,$c,$12,$0,$0,$54,$45,$12,$0,$2,$11,$11,$15,$15
		dc.b	$17,$6,$1f,$6,$13,$6,$1b,$8,$23,$23,$21,$0,$0,$0,$0,$0
		dc.b	$7c,$0,$10,$5,$0,$0,$60,$0,$20,$0,$8,$0,$0,$0,$75,$1
		dc.b	$75,$0,$27,$1,$61,$ed,$27,$1,$4e,$ed,$27,$1,$3a,$fd,$27,$1
		dc.b	$27,$ed,$27,$1,$13,$ed,$27,$1,$0,$fd,$27,$1,$75,$0,$d9,$1
		dc.b	$61,$ed,$d9,$1,$4e,$ed,$d9,$1,$3a,$fd,$d9,$1,$27,$ed,$d9,$1
		dc.b	$13,$ed,$d9,$1,$0,$fd,$d9,$1,$0,$0,$27,$1,$0,$0,$d9,$1
		dc.b	$75,$0,$23,$1,$75,$fd,$23,$1,$75,$0,$dd,$1,$75,$fd,$dd,$22
		dc.b	$0,$7f,$0,$0,$0,$0,$7f,$e,$0,$0,$81,$20,$0,$0,$82,$24
		dc.b	$0,$0,$7e,$2,$59,$a7,$0,$3,$a7,$a7,$0,$2,$8b,$3,$d0,$76
		dc.b	$64,$21,$22,$23,$20,$0,$8,$76,$64,$25,$26,$27,$24,$0,$a,$54
		dc.b	$44,$23,$26,$27,$22,$0,$2,$76,$64,$1,$20,$21,$0,$0,$2,$76
		dc.b	$64,$f,$24,$25,$e,$0,$2,$0,$8c,$3,$d0,$54,$44,$1,$e,$f
		dc.b	$0,$0,$2,$5,$8b,$7,$a0,$76,$65,$14,$4,$4,$0,$0,$2,$6
		dc.b	$4,$8,$6,$6,$8,$6,$a,$8,$c,$c,$b,$6,$1c,$0,$0,$76
		dc.b	$65,$10,$4,$4,$1c,$0,$b,$6,$9,$8,$7,$7,$5,$6,$3,$6
		dc.b	$1,$0,$0,$76,$65,$14,$6,$4,$e,$0,$10,$6,$12,$8,$14,$14
		dc.b	$16,$6,$18,$8,$1a,$1a,$19,$6,$1e,$0,$0,$76,$65,$10,$6,$4
		dc.b	$1e,$0,$19,$6,$17,$8,$15,$15,$13,$6,$11,$6,$f,$0,$0,$1
		dc.b	$c,$7,$a0,$76,$64,$1,$2,$3,$0,$0,$4,$76,$64,$f,$10,$11
		dc.b	$e,$0,$6,$0,$b,$3,$d0,$76,$64,$22,$0,$20,$2,$0,$c,$76
		dc.b	$64,$26,$e,$24,$10,$0,$c,$76,$64,$23,$1,$21,$3,$0,$e,$76
		dc.b	$64,$27,$f,$25,$11,$0,$e,$0,$0,$0,$90,$0,$10,$5,$0,$0
		dc.b	$60,$0,$34,$0,$9,$0,$0,$0,$4e,$1,$1d,$27,$9,$1,$1d,$0
		dc.b	$9,$1,$1c,$0,$a,$1,$1e,$0,$a,$1,$1d,$9,$9,$1,$9,$9
		dc.b	$9,$1,$27,$9,$9,$1,$4e,$0,$9,$1,$1d,$27,$f7,$1,$1d,$0
		dc.b	$f7,$1,$1c,$0,$f6,$1,$1e,$0,$f6,$1,$1d,$9,$f7,$1,$9,$9
		dc.b	$f7,$1,$27,$9,$f7,$1,$4e,$0,$f7,$1,$1c,$9,$a,$1,$1e,$9
		dc.b	$a,$1,$1c,$9,$f6,$1,$1e,$9,$f6,$2,$a7,$0,$a7,$4,$0,$0
		dc.b	$7f,$2,$59,$0,$a7,$12,$a7,$0,$59,$14,$0,$0,$81,$12,$59,$0
		dc.b	$59,$3,$59,$0,$a7,$5,$0,$0,$7f,$3,$a7,$0,$a7,$13,$59,$0
		dc.b	$59,$15,$0,$0,$81,$13,$a7,$0,$59,$ff,$e6,$4,$ac,$2,$48,$54
		dc.b	$44,$f,$1e,$1f,$e,$0,$0,$44,$42,$0,$2,$44,$42,$1,$3,$44
		dc.b	$42,$10,$12,$44,$42,$11,$13,$44,$56,$1,$a,$b,$0,$0,$0,$44
		dc.b	$56,$11,$1a,$1b,$10,$0,$0,$44,$56,$e,$c,$c,$0,$0,$0,$44
		dc.b	$56,$f,$d,$d,$1,$0,$0,$44,$56,$1e,$1c,$1c,$10,$0,$0,$44
		dc.b	$56,$1f,$1d,$1d,$11,$0,$0,$0,$0,$44,$44,$4,$8,$20,$2,$0
		dc.b	$2,$44,$44,$20,$6,$22,$4,$0,$4,$44,$44,$8,$6,$22,$2,$0
		dc.b	$6,$44,$44,$14,$18,$24,$12,$0,$8,$44,$44,$24,$16,$26,$14,$0
		dc.b	$a,$44,$44,$18,$16,$26,$12,$0,$c,$44,$44,$5,$9,$21,$3,$0
		dc.b	$e,$44,$44,$21,$7,$23,$5,$0,$10,$44,$44,$9,$7,$23,$3,$0
		dc.b	$12,$44,$44,$15,$19,$25,$13,$0,$14,$44,$44,$25,$17,$27,$15,$0
		dc.b	$16,$44,$44,$19,$17,$27,$13,$0,$18,$54,$44,$9,$18,$19,$8,$0
		dc.b	$0,$54,$44,$1e,$8,$18,$e,$0,$0,$54,$44,$1f,$9,$19,$f,$0
		dc.b	$0,$44,$42,$0,$18,$44,$42,$10,$8,$44,$42,$1,$19,$44,$42,$11
		dc.b	$9,$44,$43,$0,$8,$20,$2,$44,$43,$0,$20,$22,$4,$44,$43,$0
		dc.b	$8,$22,$6,$44,$43,$10,$18,$24,$8,$44,$43,$10,$24,$26,$a,$44
		dc.b	$43,$10,$18,$26,$c,$44,$43,$1,$9,$21,$e,$44,$43,$1,$21,$23
		dc.b	$10,$44,$43,$1,$9,$23,$12,$44,$43,$11,$19,$25,$14,$44,$43,$11
		dc.b	$25,$27,$16,$44,$43,$11,$19,$27,$18,$44,$56,$1,$a,$b,$0,$0
		dc.b	$0,$44,$56,$11,$1a,$1b,$10,$0,$0,$44,$56,$e,$c,$c,$0,$0
		dc.b	$0,$44,$56,$f,$d,$d,$1,$0,$0,$44,$56,$1e,$1c,$1c,$10,$0
		dc.b	$0,$44,$56,$1f,$1d,$1d,$11,$0,$0,$0,$0,$0,$80,$0,$10,$6
		dc.b	$0,$0,$70,$0,$14,$0,$e,$0,$0,$0,$5b,$1,$a,$17,$a,$1
		dc.b	$36,$ff,$36,$1,$24,$ff,$ca,$1,$24,$ff,$ee,$1,$12,$ff,$b7,$1
		dc.b	$ca,$ff,$ca,$1,$49,$ff,$12,$1,$12,$ff,$24,$1,$dc,$ff,$49,$1
		dc.b	$ee,$18,$12,$1,$ee,$ff,$9,$1,$1b,$18,$12,$1,$24,$ff,$24,$1
		dc.b	$12,$15,$ee,$1,$24,$ff,$dc,$1,$ee,$18,$ee,$1,$f7,$ff,$d3,$1
		dc.b	$b,$16,$f5,$1,$0,$1e,$0,$1,$0,$1c,$0,$1,$9,$19,$9,$1
		dc.b	$9,$19,$f7,$1,$12,$14,$12,$1,$12,$14,$ee,$0,$0,$6e,$3e,$0
		dc.b	$47,$68,$f5,$23,$0,$6e,$c2,$23,$b4,$64,$f4,$44,$86,$1,$ac,$5
		dc.b	$f4,$4,$3,$2,$3,$24,$2,$4,$3,$2,$4,$24,$4,$4,$3,$4
		dc.b	$5,$24,$6,$4,$3,$3,$5,$24,$8,$0,$0,$5,$2c,$2,$62,$4
		dc.b	$5,$a,$2,$4,$1,$0,$3,$6,$2,$6,$0,$0,$0,$4,$5,$a
		dc.b	$4,$4,$0,$0,$2,$6,$4,$6,$22,$0,$0,$4,$5,$a,$6,$4
		dc.b	$22,$0,$4,$6,$5,$6,$23,$0,$0,$4,$5,$a,$8,$4,$23,$0
		dc.b	$5,$6,$3,$6,$1,$0,$0,$88,$83,$0,$1,$24,$2,$88,$83,$0
		dc.b	$22,$24,$4,$88,$83,$22,$23,$24,$6,$88,$83,$23,$1,$24,$8,$0
		dc.b	$0,$4,$5,$14,$2,$2,$1,$1,$12,$14,$3,$8,$10,$e,$2,$8
		dc.b	$18,$16,$0,$8,$2c,$2d,$1,$0,$0,$4,$5,$14,$4,$2,$0,$0
		dc.b	$16,$18,$2,$8,$c,$6,$4,$8,$1c,$1a,$22,$8,$2e,$2c,$0,$0
		dc.b	$0,$4,$5,$14,$6,$2,$22,$22,$1a,$1c,$4,$8,$8,$9,$5,$8
		dc.b	$20,$1e,$23,$8,$2f,$2e,$22,$0,$0,$4,$5,$14,$8,$2,$23,$23
		dc.b	$1e,$20,$5,$8,$a,$7,$3,$8,$14,$12,$1,$8,$2d,$2f,$23,$0
		dc.b	$0,$88,$85,$10,$2,$2,$1,$1,$26,$29,$24,$8,$28,$26,$0,$8
		dc.b	$2c,$2d,$1,$0,$0,$88,$85,$10,$4,$2,$0,$0,$26,$28,$24,$8
		dc.b	$2a,$26,$22,$8,$2e,$2c,$0,$0,$0,$88,$85,$10,$6,$2,$22,$22
		dc.b	$26,$2a,$24,$8,$2b,$26,$23,$8,$2f,$2e,$22,$0,$0,$88,$85,$10
		dc.b	$8,$2,$23,$23,$26,$2b,$24,$8,$29,$26,$1,$8,$2d,$2f,$23,$0
		ds.b	4
		dc.b	$86,$0,$1e,$6,$80,$0,$86,$0,$4,$0,$d,$0,$0,$0,$5a,$0
		dc.b	$19,$6,$66,$0,$f,$5a,$55,$5a,$55,$0,$0,$0,$0,$1,$e,$0
		dc.b	$9,$1,$1f,$2,$11,$1,$41,$3,$7,$1,$4e,$1,$c,$1,$c,$1
		dc.b	$2b,$1,$27,$fe,$1f,$1,$35,$0,$27,$1,$57,$1,$22,$1,$7,$2
		dc.b	$44,$1,$1d,$fe,$38,$1,$3f,$ff,$3d,$1,$e,$0,$50,$1,$2b,$0
		dc.b	$5a,$5,$1,$0,$1,$5,$1,$0,$3,$5,$1,$0,$5,$5,$1,$0
		dc.b	$7,$5,$1,$0,$9,$5,$1,$0,$b,$5,$1,$0,$d,$5,$1,$0
		dc.b	$f,$5,$1,$0,$11,$5,$1,$0,$13,$5,$1,$0,$15,$5,$1,$0
		dc.b	$17,$5,$1,$0,$19,$e0,$6,$0,$92,$0,$ac,$e,$4e,$36,$24,$15
		dc.b	$2e,$2f,$14,$0,$0,$0,$0,$3,$2c,$4,$c4,$12,$3,$18,$19,$f
		dc.b	$0,$34,$23,$18,$f,$0,$0,$38,$23,$18,$e,$28,$0,$12,$3,$18
		dc.b	$28,$0,$0,$36,$23,$0,$28,$32,$0,$34,$23,$0,$32,$33,$0,$38
		dc.b	$23,$0,$f,$29,$0,$36,$23,$0,$29,$33,$0,$0,$0,$12,$3,$16
		dc.b	$19,$13,$0,$58,$43,$16,$13,$11,$0,$34,$23,$14,$16,$18,$0,$36
		dc.b	$23,$8,$14,$16,$0,$12,$3,$8,$16,$11,$0,$38,$23,$11,$13,$5
		dc.b	$0,$34,$23,$11,$5,$8,$0,$58,$43,$19,$13,$5,$0,$12,$3,$19
		dc.b	$5,$f,$0,$12,$3,$2,$8,$14,$0,$34,$23,$2,$6,$e,$0,$58
		dc.b	$43,$2,$e,$14,$0,$36,$23,$f,$5,$1f,$0,$38,$23,$f,$1f,$29
		dc.b	$0,$38,$23,$8,$5,$1f,$0,$34,$23,$8,$1f,$1b,$0,$58,$43,$2
		dc.b	$8,$1b,$0,$36,$23,$2,$1b,$23,$0,$12,$3,$2,$6,$28,$0,$36
		dc.b	$23,$2,$28,$1c,$0,$34,$23,$2,$1c,$2c,$0,$38,$23,$2,$2c,$23
		dc.b	$0,$36,$23,$1f,$1b,$23,$0,$12,$3,$1f,$23,$2f,$0,$38,$23,$1c
		dc.b	$28,$2c,$0,$58,$43,$23,$2f,$33,$0,$36,$23,$23,$33,$31,$0,$12
		dc.b	$3,$23,$31,$32,$0,$38,$23,$23,$32,$2c,$0,$34,$23,$28,$2c,$32
		dc.b	$0,$36,$23,$1f,$29,$2f,$0,$0,$b,$2,$62,$40,$6,$1a,$8e,$0
		dc.b	$0,$44,$46,$1a,$ae,$0,$22,$44,$66,$1a,$8e,$0,$23,$42,$46,$1a
		dc.b	$ae,$0,$12,$0,$0,$0,$74,$0,$10,$5,$40,$0,$64,$0,$14,$0
		dc.b	$e,$0,$0,$0,$5b,$1,$0,$18,$0,$1,$36,$ff,$36,$1,$24,$ff
		dc.b	$ca,$1,$24,$ff,$ee,$1,$12,$ff,$b7,$1,$ca,$ff,$ca,$1,$49,$ff
		dc.b	$12,$1,$12,$ff,$24,$1,$dc,$ff,$49,$1,$ee,$18,$12,$1,$ee,$ff
		dc.b	$9,$1,$1b,$18,$9,$1,$24,$ff,$24,$1,$12,$15,$ee,$1,$24,$ff
		dc.b	$dc,$1,$f7,$18,$f7,$1,$f7,$ff,$d3,$b,$1,$2,$3,$b,$1,$2
		dc.b	$4,$b,$1,$4,$5,$b,$1,$3,$5,$0,$0,$73,$35,$0,$3d,$6e
		dc.b	$f6,$0,$0,$73,$cb,$0,$c3,$6e,$f6,$ff,$e6,$1,$ac,$5,$f4,$4
		dc.b	$3,$2,$3,$0,$2,$4,$3,$2,$4,$0,$4,$4,$3,$4,$5,$0
		dc.b	$6,$4,$3,$3,$5,$0,$8,$0,$0,$ff,$e6,$4,$5,$10,$2,$2
		dc.b	$0,$0,$12,$14,$3,$8,$10,$e,$2,$8,$18,$16,$0,$0,$0,$4
		dc.b	$5,$10,$4,$2,$0,$0,$16,$18,$2,$8,$c,$6,$4,$8,$1c,$1a
		dc.b	$0,$0,$0,$4,$5,$10,$6,$2,$0,$0,$1a,$1c,$4,$8,$8,$9
		dc.b	$5,$8,$20,$1e,$0,$0,$0,$4,$5,$10,$8,$2,$0,$0,$1e,$20
		dc.b	$5,$8,$a,$7,$3,$8,$14,$12,$0,$0,$0,$1a,$ae,$68,$22,$1a
		dc.b	$ae,$63,$24,$1a,$ae,$40,$26,$1a,$ae,$4b,$28,$0,$6,$0,$0,$0
		dc.b	$58,$0,$10,$3,$c0,$0,$4c,$0,$10,$0,$e,$0,$0,$0,$49,$1
		dc.b	$0,$12,$0,$1,$36,$ff,$36,$1,$0,$ff,$b7,$1,$49,$ff,$ee,$1
		dc.b	$24,$ff,$b7,$1,$ca,$ff,$ca,$1,$b7,$ff,$12,$1,$ee,$ff,$24,$1
		dc.b	$1b,$ff,$49,$1,$ee,$12,$1b,$1,$ee,$ff,$9,$1,$12,$f,$12,$1
		dc.b	$24,$ff,$1b,$1,$ee,$12,$ee,$1,$12,$ff,$d3,$0,$0,$77,$2a,$0
		dc.b	$41,$69,$e4,$0,$bf,$69,$e4,$ff,$e6,$1,$4c,$5,$f4,$4,$3,$2
		dc.b	$3,$0,$2,$4,$3,$2,$4,$0,$4,$4,$3,$4,$3,$0,$6,$0
		dc.b	$0,$4,$5,$10,$2,$2,$0,$0,$12,$14,$3,$8,$e,$10,$2,$8
		dc.b	$18,$16,$0,$0,$0,$4,$5,$10,$4,$2,$0,$0,$16,$18,$2,$8
		dc.b	$6,$8,$4,$8,$1c,$1a,$0,$0,$0,$4,$5,$10,$6,$2,$0,$0
		dc.b	$1a,$1c,$4,$8,$a,$c,$3,$8,$14,$12,$0,$0,$0,$0,$0,$0
		dc.b	$f8,$0,$10,$e,$80,$0,$f8,$0,$4,$0,$c,$0,$0,$0,$7a,$1
		dc.b	$2,$0,$7a,$1,$fe,$0,$86,$1,$7a,$0,$2,$5,$1,$0,$4,$1
		dc.b	$c,$0,$6d,$1,$f4,$0,$93,$1,$c,$0,$55,$1,$f4,$0,$ab,$1
		dc.b	$c,$0,$3d,$1,$f4,$0,$c3,$1,$c,$0,$24,$1,$f4,$0,$dc,$1
		dc.b	$c,$0,$c,$1,$f4,$0,$f4,$1,$24,$0,$c,$1,$dc,$0,$f4,$1
		dc.b	$3d,$0,$c,$1,$c3,$0,$f4,$1,$55,$0,$c,$1,$ab,$0,$f4,$1
		dc.b	$6d,$0,$c,$1,$93,$0,$f4,$1,$6d,$0,$55,$1,$93,$0,$ab,$1
		dc.b	$6d,$0,$6d,$1,$93,$0,$93,$1,$24,$0,$6d,$1,$dc,$0,$93,$1
		dc.b	$30,$0,$24,$1,$d0,$0,$dc,$1,$50,$0,$50,$1,$b0,$0,$b0,$1
		dc.b	$64,$0,$0,$1,$5f,$0,$0,$1,$33,$0,$0,$1,$2e,$0,$0,$1
		dc.b	$0,$0,$27,$5,$1,$0,$48,$1,$0,$0,$24,$5,$1,$0,$4c,$1
		dc.b	$3f,$0,$7a,$5,$1,$0,$50,$1,$18,$0,$61,$5,$1,$0,$54,$1
		dc.b	$18,$0,$30,$5,$1,$0,$58,$1,$24,$0,$18,$5,$1,$0,$5c,$1
		dc.b	$55,$0,$24,$5,$1,$0,$60,$1,$7a,$0,$3f,$5,$1,$0,$64,$1
		dc.b	$30,$0,$49,$5,$1,$0,$68,$1,$7a,$0,$3a,$5,$1,$0,$6c,$1
		dc.b	$3a,$0,$7a,$5,$1,$0,$70,$e3,$6,$5f,$5e,$3,$8c,$1,$6e,$54
		dc.b	$42,$0,$3,$54,$42,$4,$5,$0,$b,$9,$88,$54,$42,$40,$6c,$54
		dc.b	$42,$6c,$70,$0,$b,$7,$a0,$54,$42,$44,$6f,$54,$42,$73,$4a,$0
		dc.b	$b,$5,$b8,$54,$42,$4a,$6e,$54,$42,$6e,$72,$54,$42,$6e,$41,$54
		dc.b	$42,$45,$51,$54,$42,$48,$65,$16,$5,$e,$0,$4,$70,$0,$54,$6
		dc.b	$58,$6,$5c,$6,$60,$6,$6c,$0,$0,$0,$53,$b,$c1,$1a,$ee,$0
		dc.b	$3b,$0,$53,$c,$c1,$1a,$ee,$0,$3f,$0,$b,$3,$d0,$e3,$6,$5f
		dc.b	$5e,$16,$4,$51,$59,$69,$55,$0,$0,$16,$3,$56,$6a,$52,$0,$0
		dc.b	$b,$2,$dc,$0,$53,$d,$c1,$1b,$e,$40,$61,$5,$8b,$1,$6e,$54
		dc.b	$44,$3,$1,$2,$0,$0,$0,$54,$44,$7,$5,$6,$4,$0,$0,$54
		dc.b	$44,$6c,$42,$64,$40,$0,$0,$54,$44,$50,$6c,$70,$64,$0,$0,$54
		dc.b	$44,$6f,$46,$67,$44,$0,$0,$54,$44,$4e,$73,$4a,$53,$0,$0,$54
		dc.b	$44,$66,$4e,$6e,$4a,$0,$0,$54,$44,$52,$6e,$72,$66,$0,$0,$54
		dc.b	$44,$43,$6e,$41,$66,$0,$0,$54,$44,$51,$47,$71,$45,$0,$0,$54
		dc.b	$44,$65,$4c,$6d,$48,$0,$0,$0,$b,$1,$30,$1,$13,$1,$c1,$1b
		dc.b	$2e,$0,$8,$1b,$2e,$0,$9,$1b,$2e,$0,$a,$1b,$2e,$0,$b,$1
		dc.b	$13,$2,$c1,$1b,$2e,$0,$c,$1b,$2e,$0,$d,$1a,$6e,$b,$e,$1b
		dc.b	$2e,$0,$f,$1,$13,$3,$c1,$1b,$2e,$0,$10,$1b,$2e,$0,$11,$1b
		dc.b	$2e,$0,$12,$1b,$2e,$0,$13,$1,$13,$4,$c1,$1b,$2e,$0,$14,$1b
		dc.b	$2e,$0,$15,$1b,$2e,$0,$16,$1b,$2e,$0,$17,$1,$13,$5,$c1,$1b
		dc.b	$2e,$0,$18,$1b,$2e,$0,$19,$1b,$2e,$0,$1a,$1b,$2e,$0,$1b,$1
		dc.b	$13,$6,$c1,$1b,$2e,$0,$1c,$1b,$2e,$0,$1d,$1b,$2e,$0,$1e,$1b
		dc.b	$2e,$0,$1f,$1,$13,$7,$c1,$1b,$2e,$0,$20,$1b,$2e,$0,$21,$1a
		dc.b	$6e,$0,$22,$1b,$2e,$0,$23,$1,$13,$8,$c1,$1b,$2e,$0,$24,$1b
		dc.b	$2e,$0,$25,$1b,$2e,$0,$26,$1b,$2e,$0,$27,$1,$13,$9,$c1,$1b
		dc.b	$2e,$0,$28,$1b,$2e,$0,$29,$1b,$2e,$0,$2a,$1b,$2e,$0,$2b,$1
		dc.b	$13,$a,$c1,$1b,$2e,$0,$2c,$1b,$2e,$0,$2d,$1b,$2e,$0,$2e,$1b
		dc.b	$2e,$0,$2f,$0,$53,$d,$c1,$1b,$4e,$0,$38,$0,$93,$e,$c1,$0
		dc.b	$3c,$d0,$7,$1a,$ce,$6,$3d,$0,$53,$f,$c1,$1a,$8e,$40,$68,$0
		dc.b	$0,$0,$3c,$0,$10,$1,$40,$0,$24,$0,$1c,$0,$8,$0,$0,$0
		dc.b	$4e,$1,$13,$f,$13,$1,$13,$f,$ed,$5,$1,$0,$0,$5,$1,$0
		dc.b	$2,$1,$f,$1f,$0,$0,$0,$0,$7f,$0,$7f,$0,$0,$0,$7b,$1e
		dc.b	$0,$2,$0,$0,$81,$0,$0,$63,$4f,$2,$0,$63,$b1,$0,$ac,$f
		dc.b	$42,$88,$84,$2,$1,$3,$0,$0,$0,$0,$0,$ff,$e6,$88,$84,$7
		dc.b	$1,$6,$0,$0,$2,$88,$88,$7,$2,$5,$0,$0,$4,$88,$84,$5
		dc.b	$3,$4,$2,$0,$8,$60,$4,$8,$1,$9,$0,$0,$a,$60,$4,$8
		dc.b	$3,$9,$2,$0,$c,$60,$7,$0,$2,$8,$6,$3,$b,$3,$d,$0
		dc.b	$8b,$80,$2,$0,$a,$18,$2,$4c,$1,$40,$5f,$0,$8b,$80,$4,$0
		dc.b	$a,$18,$4,$42,$2,$40,$60,$0,$8b,$80,$5,$0,$a,$18,$6,$52
		dc.b	$3,$40,$61,$0,$8b,$80,$8,$0,$a,$18,$8,$4c,$3,$40,$62,$0
		dc.b	$6,$0,$0,$0,$3c,$0,$10,$1,$c0,$0,$2c,$0,$14,$0,$a,$0
		dc.b	$0,$0,$44,$1,$44,$1d,$30,$1,$44,$1d,$d0,$1,$bc,$fd,$d0,$1
		dc.b	$bc,$fd,$30,$1,$44,$18,$0,$1,$fc,$18,$d0,$1,$e,$18,$30,$0
		dc.b	$7f,$0,$0,$0,$0,$0,$7f,$2,$0,$0,$81,$0,$0,$7f,$0,$ff
		dc.b	$e6,$88,$84,$1,$2,$3,$0,$0,$8,$5,$cb,$b,$70,$88,$88,$7
		dc.b	$2,$5,$0,$0,$2,$88,$84,$7,$1,$6,$0,$0,$4,$88,$84,$5
		dc.b	$3,$4,$2,$0,$6,$4,$b,$1,$87,$0,$cb,$80,$2,$c2,$d,$40
		dc.b	$c1,$0,$1a,$0,$2,$12,$4e,$42,$8,$0,$cb,$80,$4,$c2,$d,$2
		dc.b	$c1,$0,$1a,$0,$4,$12,$4e,$64,$c,$0,$cb,$80,$6,$c2,$d,$1
		dc.b	$c1,$0,$1a,$0,$6,$12,$4e,$4c,$a,$0,$cb,$80,$3,$c2,$d,$3
		dc.b	$c1,$0,$1a,$0,$3,$12,$4e,$6a,$9,$0,$6,$0,$0,$0,$18,$0
		dc.b	$10,$0,$80,$0,$18,$0,$4,$0,$a,$0,$0,$0,$61,$1,$61,$0
		dc.b	$30,$5,$1,$0,$1,$0,$84,$1,$2,$3,$0,$0,$0,$0,$b,$3
		dc.b	$d0,$98,$82,$0,$2,$98,$82,$1,$3,$98,$82,$2,$3,$98,$82,$0
		dc.b	$1,$0,$0,$0,$44,$0,$10,$1,$c0,$0,$2c,$0,$1c,$0,$8,$0
		dc.b	$0,$0,$4e,$1,$0,$4e,$0,$1,$b,$0,$7,$1,$f5,$0,$0,$1
		dc.b	$3,$0,$f5,$1,$17,$f5,$f,$1,$e9,$f5,$0,$1,$7,$f5,$e9,$4
		dc.b	$bf,$41,$a9,$2,$da,$26,$72,$2,$61,$47,$da,$0,$d8,$6,$78,$0
		dc.b	$b5,$b,$9b,$0,$75,$c,$d2,$0,$6c,$7,$a0,$44,$42,$0,$2,$0
		dc.b	$0,$44,$44,$a,$6,$c,$4,$0,$2,$44,$44,$8,$4,$a,$2,$0
		dc.b	$4,$44,$44,$8,$6,$c,$2,$0,$6,$44,$43,$0,$2,$4,$8,$44
		dc.b	$43,$0,$4,$6,$a,$44,$43,$0,$2,$6,$c,$0,$0,$1,$48,$0
		dc.b	$10,$d,$40,$0,$e4,$0,$68,$0,$d,$0,$0,$0,$7a,$1,$1a,$49
		dc.b	$30,$1,$30,$49,$0,$1,$1a,$49,$d0,$1,$1a,$0,$30,$1,$30,$0
		dc.b	$0,$1,$1a,$0,$d0,$1,$c,$30,$30,$1,$1f,$18,$6d,$1,$c,$0
		dc.b	$30,$1,$1f,$0,$6d,$1,$1f,$24,$e1,$1,$66,$24,$b2,$1,$70,$24
		dc.b	$cb,$1,$2b,$24,$f9,$1,$1f,$0,$e1,$1,$66,$0,$b2,$1,$70,$0
		dc.b	$cb,$1,$2b,$0,$f9,$1,$18,$18,$b7,$1,$18,$18,$93,$1,$18,$0
		dc.b	$b7,$1,$18,$0,$93,$1,$44,$1d,$13,$1,$68,$2b,$29,$1,$57,$2b
		dc.b	$53,$1,$35,$1d,$3a,$1,$44,$0,$13,$1,$68,$0,$29,$1,$57,$0
		dc.b	$53,$1,$35,$0,$3a,$1,$30,$e,$86,$1,$61,$e,$9f,$1,$61,$e
		dc.b	$86,$1,$d0,$e,$b7,$1,$30,$0,$86,$1,$61,$0,$9f,$1,$61,$0
		dc.b	$86,$1,$d0,$0,$b7,$1,$b7,$9,$e8,$1,$93,$9,$f9,$1,$9f,$9
		dc.b	$6d,$1,$c3,$9,$61,$1,$ab,$9,$c,$1,$bf,$9,$0,$1,$b7,$0
		dc.b	$e8,$1,$93,$0,$f9,$1,$9f,$0,$6d,$1,$c3,$0,$61,$1,$ab,$0
		dc.b	$c,$1,$bf,$0,$0,$1,$0,$24,$49,$1,$c,$18,$9f,$1,$27,$0
		dc.b	$1a,$0,$0,$7f,$0,$0,$0,$0,$7f,$0,$73,$0,$34,$2,$73,$f8
		dc.b	$cd,$4,$0,$0,$81,$5,$8d,$fb,$cc,$24,$0,$7f,$0,$c,$0,$75
		dc.b	$2f,$c,$78,$0,$da,$3c,$c8,$0,$71,$14,$bb,$0,$96,$3f,$c8,$0
		dc.b	$71,$18,$47,$0,$69,$3d,$7f,$0,$0,$24,$7f,$0,$0,$3f,$81,$0
		dc.b	$0,$24,$0,$0,$7f,$2c,$41,$0,$94,$30,$b7,$0,$67,$2c,$8a,$0
		dc.b	$d4,$4c,$79,$0,$dc,$4c,$cb,$0,$8d,$4e,$82,$0,$d,$52,$7a,$0
		dc.b	$de,$54,$43,$0,$6b,$e0,$c6,$0,$f4,$44,$44,$48,$5c,$49,$5d,$0
		dc.b	$2,$0,$6,$0,$b,$2f,$ae,$1b,$6e,$0,$64,$1b,$6e,$0,$66,$1b
		dc.b	$6e,$0,$69,$0,$b,$17,$d6,$ff,$e6,$44,$44,$1,$c,$d,$0,$0
		dc.b	$4,$22,$28,$6,$2,$8,$0,$0,$6,$44,$44,$1a,$4,$14,$2,$0
		dc.b	$8,$22,$24,$5,$a,$b,$4,$0,$a,$44,$44,$15,$3,$1b,$5,$0
		dc.b	$c,$44,$48,$0,$10,$c,$6,$0,$4,$44,$48,$2,$22,$1a,$8,$0
		dc.b	$8,$44,$48,$4,$1c,$14,$a,$0,$8,$22,$25,$e,$2,$4,$0,$0
		dc.b	$2,$6,$4,$6,$5,$6,$3,$6,$1,$0,$0,$0,$b,$11,$2a,$2
		dc.b	$f,$45,$6,$44,$44,$25,$26,$27,$24,$0,$e,$66,$64,$25,$28,$29
		dc.b	$24,$0,$22,$66,$64,$27,$2a,$2b,$26,$0,$a,$22,$28,$28,$26,$2a
		dc.b	$24,$0,$1e,$49,$46,$44,$44,$42,$41,$3d,$3f,$0,$e,$66,$64,$47
		dc.b	$42,$4a,$3f,$0,$18,$22,$24,$45,$42,$4a,$3d,$0,$1c,$66,$64,$45
		dc.b	$41,$49,$3d,$0,$a,$22,$24,$47,$41,$49,$3f,$0,$20,$48,$86,$66
		dc.b	$63,$3c,$3e,$40,$e,$44,$44,$44,$3e,$46,$3c,$0,$14,$44,$44,$46
		dc.b	$40,$48,$3e,$0,$1e,$44,$44,$44,$40,$48,$3c,$0,$a,$46,$86,$66
		dc.b	$64,$32,$2e,$30,$2c,$0,$e,$22,$24,$36,$30,$38,$2e,$0,$6,$44
		dc.b	$44,$34,$2e,$36,$2c,$0,$24,$44,$44,$38,$32,$3a,$30,$0,$26,$66
		dc.b	$64,$34,$32,$3a,$2c,$0,$28,$0,$b,$b,$70,$4c,$6,$44,$45,$e
		dc.b	$e,$4,$4c,$0,$4e,$6,$50,$6,$52,$6,$54,$6,$56,$0,$0,$66
		dc.b	$64,$58,$56,$62,$4c,$0,$2a,$66,$64,$5e,$54,$60,$52,$0,$30,$44
		dc.b	$44,$60,$56,$62,$54,$0,$32,$22,$24,$58,$4e,$5a,$4c,$0,$2c,$66
		dc.b	$64,$5a,$50,$5c,$4e,$0,$2e,$22,$24,$5c,$52,$5e,$50,$0,$4,$43
		dc.b	$6,$44,$44,$1a,$16,$18,$14,$0,$e,$66,$64,$1e,$18,$20,$16,$0
		dc.b	$8,$22,$24,$1c,$16,$1e,$14,$0,$16,$22,$24,$20,$1a,$22,$18,$0
		dc.b	$1a,$43,$26,$44,$44,$1b,$17,$19,$15,$0,$e,$66,$64,$1f,$19,$21
		dc.b	$17,$0,$9,$22,$24,$1d,$17,$1f,$15,$0,$17,$22,$24,$21,$1b,$23
		dc.b	$19,$0,$1b,$42,$6,$66,$64,$d,$e,$f,$c,$0,$10,$22,$28,$10
		dc.b	$e,$12,$c,$0,$12,$44,$44,$f,$12,$13,$e,$0,$4,$0,$0,$0
		dc.b	$88,$0,$10,$5,$80,$0,$68,$0,$24,$0,$d,$0,$0,$0,$7a,$1
		dc.b	$0,$0,$53,$1,$49,$0,$53,$1,$0,$0,$ad,$1,$24,$0,$49,$1
		dc.b	$24,$11,$24,$1,$24,$11,$dc,$1,$24,$0,$24,$1,$24,$0,$dc,$1
		dc.b	$30,$18,$18,$1,$3d,$18,$9f,$1,$6d,$18,$c3,$1,$7a,$18,$24,$1
		dc.b	$30,$0,$18,$1,$3d,$0,$9f,$1,$6d,$0,$c3,$1,$7a,$0,$24,$1
		dc.b	$a4,$18,$9f,$1,$a4,$18,$18,$1,$c3,$18,$18,$1,$a4,$0,$9f,$1
		dc.b	$a4,$0,$18,$1,$c3,$0,$18,$8,$0,$7f,$0,$8,$0,$0,$7f,$8
		dc.b	$7f,$0,$0,$a,$0,$0,$81,$9,$81,$0,$0,$10,$82,$0,$f4,$12
		dc.b	$4c,$0,$9b,$10,$ec,$0,$7d,$0,$8c,$7,$a0,$44,$44,$27,$3,$26
		dc.b	$2,$0,$2,$0,$b,$f,$42,$1b,$6e,$0,$6,$1b,$6e,$0,$7,$1b
		dc.b	$6e,$0,$27,$0,$b,$7,$a0,$ff,$e6,$4,$b,$5,$b8,$22,$24,$18
		dc.b	$12,$1a,$10,$0,$c,$66,$64,$28,$24,$2a,$22,$0,$4,$44,$44,$18
		dc.b	$16,$1e,$10,$0,$10,$44,$44,$1b,$24,$2a,$13,$0,$6,$22,$24,$9
		dc.b	$c,$d,$8,$0,$4,$66,$64,$c,$a,$e,$8,$0,$6,$22,$24,$b
		dc.b	$e,$f,$a,$0,$8,$66,$64,$d,$b,$f,$9,$0,$a,$44,$44,$9
		dc.b	$a,$b,$8,$0,$2,$66,$64,$16,$12,$14,$10,$0,$2,$22,$24,$24
		dc.b	$20,$22,$13,$0,$2,$44,$44,$1a,$14,$1c,$12,$0,$e,$22,$24,$1c
		dc.b	$16,$1e,$14,$0,$6,$66,$64,$1b,$20,$26,$13,$0,$8,$44,$44,$26
		dc.b	$22,$28,$20,$0,$a,$1b,$8e,$20,$0,$1b,$8e,$0,$2,$1b,$8e,$0
		dc.b	$3,$1b,$8e,$28,$4,$0,$0,$0,$68,$0,$10,$1,$c0,$0,$2c,$0
		dc.b	$40,$0,$c,$0,$0,$0,$49,$1,$0,$49,$f9,$1,$0,$24,$30,$1
		dc.b	$30,$24,$0,$1,$18,$24,$d0,$1,$0,$0,$e1,$1,$13,$0,$f4,$1
		dc.b	$e,$0,$e,$0,$3c,$5d,$3c,$0,$4c,$5e,$da,$0,$0,$5f,$ac,$0
		dc.b	$b4,$5e,$da,$0,$c4,$5d,$3c,$2,$54,$d4,$54,$4,$62,$c2,$cf,$6
		dc.b	$0,$cb,$8d,$7,$9e,$c2,$cf,$2,$ac,$d4,$54,$2,$0,$aa,$5c,$4
		dc.b	$5f,$ae,$11,$6,$46,$b1,$ba,$7,$ba,$b1,$ba,$5,$a1,$ae,$11,$66
		dc.b	$63,$0,$2,$4,$2,$44,$43,$0,$4,$6,$4,$66,$63,$0,$6,$7
		dc.b	$6,$44,$43,$0,$5,$7,$8,$22,$23,$0,$2,$5,$a,$0,$b,$3
		dc.b	$d0,$22,$23,$2,$4,$c,$c,$66,$63,$4,$6,$a,$e,$22,$23,$6
		dc.b	$7,$8,$10,$66,$63,$7,$5,$b,$12,$44,$43,$2,$5,$d,$14,$66
		dc.b	$63,$2,$c,$d,$16,$44,$43,$4,$a,$c,$18,$44,$43,$6,$8,$a
		dc.b	$1a,$44,$43,$7,$8,$b,$1c,$22,$23,$5,$b,$d,$1e,$0,$0,$0
		dc.b	$38,$0,$10,$1,$c0,$0,$2c,$0,$10,$0,$e,$0,$0,$0,$43,$1
		dc.b	$0,$0,$ff,$1,$0,$2a,$ff,$1,$0,$30,$0,$1,$0,$43,$0,$7
		dc.b	$10,$0,$6,$1,$1,$0,$1,$1,$1,$2a,$1,$0,$71,$0,$c8,$0
		dc.b	$8f,$0,$c8,$b,$0,$0,$7f,$f8,$9,$8,$4,$2,$71,$0,$6c,$2
		dc.b	$62,$44,$42,$0,$c,$0,$0,$44,$44,$a,$2,$c,$0,$0,$2,$44
		dc.b	$44,$b,$2,$d,$0,$0,$4,$44,$44,$a,$d,$c,$b,$0,$6,$0
		dc.b	$0,$0,$80,$0,$10,$7,$0,$0,$80,$0,$4,$0,$c,$0,$0,$0
		dc.b	$7a,$1,$2,$0,$7a,$1,$fe,$0,$86,$1,$7a,$0,$2,$1,$86,$0
		dc.b	$fe,$1,$7a,$0,$3f,$1,$86,$0,$c1,$1,$7a,$0,$3d,$1,$86,$0
		dc.b	$c3,$1,$3f,$0,$7a,$1,$c1,$0,$86,$1,$3d,$0,$7a,$1,$c3,$0
		dc.b	$86,$1,$e,$9,$e,$1,$f2,$9,$f2,$1,$24,$9,$e,$1,$dc,$9
		dc.b	$f2,$1,$11,$9,$24,$1,$ef,$9,$dc,$1,$29,$9,$29,$1,$d7,$9
		dc.b	$d7,$1,$41,$0,$24,$1,$dc,$0,$bf,$1,$61,$c,$61,$1,$9f,$c
		dc.b	$9f,$1,$5a,$c,$1f,$1,$a6,$c,$e1,$1,$1f,$c,$61,$1,$e1,$c
		dc.b	$9f,$c1,$d,$82,$40,$0,$ac,$d,$58,$54,$44,$2f,$2d,$2e,$2c,$0
		dc.b	$0,$0,$0,$e3,$6,$5f,$5e,$1,$8c,$1,$6e,$54,$42,$0,$3,$54
		dc.b	$42,$4,$5,$54,$42,$10,$13,$54,$42,$11,$12,$54,$42,$8,$9,$54
		dc.b	$42,$e,$f,$2,$8b,$1,$6e,$54,$44,$3,$1,$2,$0,$0,$0,$54
		dc.b	$44,$5,$7,$6,$4,$0,$0,$54,$48,$13,$14,$17,$10,$0,$0,$54
		dc.b	$44,$9,$c,$d,$8,$0,$0,$54,$44,$b,$e,$f,$a,$0,$0,$0
		dc.b	$b,$7,$a0,$0,$d3,$9,$c1,$45,$86,$1b,$ae,$23,$2c,$45,$a6,$1b
		dc.b	$ce,$0,$2d,$0,$d3,$a,$c1,$45,$c6,$1b,$ae,$0,$2e,$45,$e6,$1b
		dc.b	$ce,$23,$2f,$0,$d3,$b,$c1,$46,$6,$1b,$ae,$0,$30,$46,$26,$1b
		dc.b	$ce,$0,$31,$0,$d3,$c,$c1,$46,$46,$1b,$ae,$23,$32,$46,$66,$1b
		dc.b	$ce,$0,$33,$0,$d3,$d,$c1,$46,$86,$1b,$ae,$0,$34,$46,$a6,$1b
		dc.b	$ce,$0,$35,$0,$d3,$e,$c1,$46,$c6,$1b,$ae,$0,$36,$46,$e6,$1b
		dc.b	$ce,$23,$37,$1,$f3,$1,$c1,$54,$5a,$83,$0,$7,$66,$3,$22,$3
		dc.b	$22,$7,$66,$7,$66,$5,$44,$7,$66,$43,$6,$1b,$ee,$0,$18,$43
		dc.b	$26,$1c,$e,$b,$19,$1,$f3,$2,$c1,$76,$7a,$83,$0,$5,$44,$7
		dc.b	$66,$3,$22,$7,$66,$7,$66,$3,$22,$5,$44,$43,$46,$1b,$ee,$0
		dc.b	$1a,$43,$66,$1c,$2e,$23,$1b,$1,$f3,$3,$c1,$54,$5a,$83,$0,$7
		dc.b	$66,$5,$44,$7,$66,$3,$22,$5,$44,$7,$66,$7,$66,$43,$86,$1b
		dc.b	$ee,$b,$1c,$43,$a6,$1c,$2e,$0,$1d,$0,$b,$5,$b8,$1,$f3,$4
		dc.b	$c1,$32,$3a,$83,$0,$5,$44,$7,$66,$7,$66,$7,$66,$3,$22,$5
		dc.b	$44,$7,$66,$43,$c6,$1c,$2e,$23,$1e,$43,$e6,$1c,$e,$0,$1f,$1
		dc.b	$f3,$5,$c1,$76,$7a,$83,$0,$3,$22,$5,$44,$7,$66,$5,$44,$7
		dc.b	$66,$3,$22,$5,$44,$44,$6,$1c,$2e,$0,$20,$44,$26,$1b,$ee,$28
		dc.b	$21,$1,$f3,$6,$c1,$76,$7a,$83,$0,$3,$22,$3,$22,$5,$44,$7
		dc.b	$66,$5,$44,$7,$66,$3,$22,$44,$46,$1c,$e,$0,$22,$44,$66,$1c
		dc.b	$2e,$0,$23,$1,$f3,$7,$c1,$32,$3a,$83,$0,$7,$66,$7,$66,$3
		dc.b	$22,$5,$44,$7,$66,$5,$44,$7,$66,$44,$86,$1c,$2e,$23,$24,$44
		dc.b	$a6,$1c,$e,$0,$25,$1,$f3,$8,$c1,$76,$7a,$83,$0,$7,$66,$5
		dc.b	$44,$3,$22,$3,$22,$5,$44,$7,$66,$5,$44,$44,$c6,$1b,$ee,$0
		dc.b	$26,$44,$e6,$1c,$2e,$23,$27,$0,$d3,$f,$c1,$45,$6,$1a,$6e,$23
		dc.b	$28,$45,$26,$1a,$6e,$b,$29,$0,$d3,$10,$c1,$45,$46,$1a,$6e,$28
		dc.b	$2a,$45,$66,$1a,$6e,$0,$2b,$0,$0,$0,$34,$0,$10,$1,$0,$0
		dc.b	$20,$0,$18,$0,$9,$0,$0,$0,$4e,$1,$27,$4e,$27,$1,$27,$4e
		dc.b	$d9,$5,$1,$0,$0,$5,$1,$0,$2,$0,$0,$0,$7f,$0,$7f,$0
		dc.b	$0,$1,$81,$0,$0,$2,$0,$0,$81,$0,$0,$7f,$0,$1,$4,$7
		dc.b	$1,$6,$0,$0,$2,$1,$4,$7,$2,$5,$0,$0,$4,$1,$4,$6
		dc.b	$3,$4,$1,$0,$6,$1,$4,$5,$3,$4,$2,$0,$8,$1,$4,$2
		dc.b	$1,$3,$0,$0,$a,$2,$8b,$3,$d1,$0,$cb,$80,$4,$c2,$d,$1
		dc.b	$c1,$0,$1a,$0,$4,$12,$4e,$42,$2,$fe,$a,$19,$2,$64,$0,$40
		dc.b	$63,$fe,$a,$19,$6,$6a,$1,$40,$64,$fe,$a,$19,$8,$4c,$3,$40
		dc.b	$65,$0,$0,$0,$34,$0,$10,$1,$0,$0,$20,$0,$18,$0,$a,$0
		dc.b	$0,$0,$4e,$1,$b,$4e,$17,$1,$b,$4e,$e9,$1,$f5,$d9,$e9,$1
		dc.b	$f5,$d9,$17,$0,$0,$0,$7f,$0,$7f,$0,$0,$1,$81,$0,$0,$2
		dc.b	$0,$0,$81,$0,$0,$7f,$0,$1,$4,$7,$1,$6,$0,$0,$2,$1
		dc.b	$4,$7,$2,$5,$0,$0,$4,$1,$4,$6,$3,$4,$1,$0,$6,$1
		dc.b	$4,$5,$3,$4,$2,$0,$8,$1,$4,$2,$1,$3,$0,$0,$a,$2
		dc.b	$b,$1,$e9,$1,$4b,$80,$4,$c2,$d,$5,$c1,$0,$1a,$0,$4,$12
		dc.b	$4e,$42,$2,$fe,$a,$19,$4,$42,$2,$40,$66,$fe,$a,$19,$6,$6a
		dc.b	$1,$40,$67,$0,$0,$0,$34,$0,$10,$1,$0,$0,$20,$0,$18,$0
		dc.b	$9,$0,$0,$0,$4e,$1,$46,$1f,$2e,$1,$46,$1f,$d2,$1,$ba,$b2
		dc.b	$d2,$1,$ba,$b2,$2e,$0,$0,$0,$7e,$0,$7f,$0,$0,$1,$81,$0
		dc.b	$0,$2,$0,$0,$82,$0,$0,$7f,$0,$1,$4,$7,$1,$6,$0,$0
		dc.b	$2,$1,$4,$7,$2,$5,$0,$0,$4,$1,$4,$6,$3,$4,$1,$0
		dc.b	$6,$1,$4,$5,$3,$4,$2,$0,$8,$1,$4,$2,$1,$3,$0,$0
		dc.b	$a,$3,$b,$3,$d1,$fe,$a,$19,$2,$64,$0,$40,$68,$0,$cb,$80
		dc.b	$4,$c2,$d,$a,$40,$0,$1a,$0,$4,$12,$4e,$42,$2,$0,$cb,$80
		dc.b	$6,$c2,$d,$b,$c1,$0,$1a,$0,$6,$12,$4e,$6a,$1,$fe,$a,$19
		dc.b	$8,$4c,$3,$40,$69,$0,$0,$0,$30,$0,$10,$1,$0,$0,$20,$0
		dc.b	$14,$0,$a,$0,$0,$0,$5c,$1,$5c,$ed,$4e,$1,$5c,$ed,$b2,$1
		dc.b	$a4,$d0,$b2,$1,$a4,$d0,$4e,$0,$0,$0,$7e,$0,$7f,$0,$0,$2
		dc.b	$0,$0,$82,$0,$0,$7f,$0,$0,$ac,$9,$88,$1,$4,$2,$1,$3
		dc.b	$0,$0,$8,$0,$0,$1,$4,$7,$1,$6,$0,$0,$2,$1,$8,$7
		dc.b	$2,$5,$0,$0,$4,$1,$4,$5,$3,$4,$2,$0,$6,$1,$4,$2
		dc.b	$1,$3,$0,$0,$8,$2,$b,$1,$e9,$0,$cb,$80,$2,$c2,$d,$d
		dc.b	$c1,$0,$1a,$0,$2,$12,$4e,$64,$0,$0,$cb,$80,$6,$c2,$d,$e
		dc.b	$c1,$0,$1a,$0,$6,$12,$4e,$4c,$3,$0,$0,$0,$30,$0,$10,$1
		dc.b	$0,$0,$20,$0,$14,$0,$a,$0,$0,$0,$44,$1,$44,$e3,$30,$1
		dc.b	$44,$e3,$d0,$1,$bc,$d0,$d0,$1,$bc,$d0,$30,$0,$0,$0,$7f,$0
		dc.b	$7f,$0,$0,$2,$0,$0,$81,$0,$0,$7f,$0,$0,$ac,$9,$88,$1
		dc.b	$4,$2,$1,$3,$0,$0,$8,$0,$0,$1,$4,$7,$1,$6,$0,$0
		dc.b	$2,$1,$8,$7,$2,$5,$0,$0,$4,$1,$4,$5,$3,$4,$2,$0
		dc.b	$6,$1,$4,$2,$1,$3,$0,$0,$8,$2,$b,$1,$e9,$0,$cb,$80
		dc.b	$2,$c2,$d,$3,$c1,$0,$1a,$0,$2,$12,$4e,$64,$0,$0,$cb,$80
		dc.b	$6,$c2,$d,$f,$c1,$0,$1a,$0,$6,$12,$4e,$4c,$3,$0,$0,$0
		dc.b	$9a,$0,$1e,$6,$80,$0,$86,$0,$18,$0,$f,$0,$0,$0,$46,$0
		dc.b	$1a,$6,$66,$0,$11,$46,$cd,$46,$cd,$1,$d8,$0,$0,$1,$0,$0
		dc.b	$24,$1,$1f,$0,$12,$1,$1f,$0,$ee,$1,$0,$0,$dc,$1,$1e,$0
		dc.b	$34,$1,$3d,$0,$0,$1,$1e,$0,$cc,$1,$f,$0,$1a,$1,$1e,$0
		dc.b	$0,$5,$1,$0,$f,$1,$0,$0,$c,$1,$a,$0,$6,$5,$1,$0
		dc.b	$17,$5,$1,$0,$14,$1,$3,$0,$6,$1,$7,$0,$0,$5,$1,$0
		dc.b	$1d,$1,$1,$3,$3,$1,$3,$3,$0,$1,$1,$3,$fd,$b,$1,$14
		dc.b	$16,$b,$1,$16,$18,$5,$1,$0,$29,$1,$46,$0,$36,$5,$1,$0
		dc.b	$2f,$1,$0,$3,$0,$1c,$0,$53,$60,$1c,$53,$53,$30,$1e,$53,$53
		dc.b	$d0,$26,$0,$53,$a0,$22,$0,$7f,$0,$c1,$d,$40,$82,$0,$3c,$aa
		dc.b	$a,$e1,$c6,$2f,$af,$1a,$2e,$6,$0,$1a,$2e,$6,$2,$1a,$2e,$6
		dc.b	$4,$1a,$2e,$6,$6,$1a,$2e,$6,$5,$1a,$2e,$6,$3,$1,$2c,$0
		dc.b	$7a,$54,$45,$e,$0,$4,$14,$0,$16,$6,$18,$6,$1a,$6,$19,$6
		dc.b	$17,$0,$0,$3,$8b,$0,$7a,$54,$45,$34,$0,$2,$14,$14,$28,$1c
		dc.b	$e,$8,$1c,$28,$16,$8,$2a,$1e,$10,$8,$1e,$2a,$18,$8,$2c,$20
		dc.b	$12,$8,$20,$2c,$1a,$8,$2d,$21,$13,$8,$21,$2d,$19,$8,$2b,$1f
		dc.b	$11,$8,$1f,$2b,$17,$8,$29,$1d,$f,$8,$1d,$29,$14,$0,$0,$1c
		dc.b	$4e,$6,$e,$ff,$e6,$c2,$d,$40,$a1,$17,$4e,$0,$d,$0,$3c,$0
		dc.b	$20,$e2,$6,$2f,$af,$1c,$4e,$6,$10,$ff,$e6,$c2,$d,$40,$40,$17
		dc.b	$4e,$b,$b,$0,$3c,$55,$35,$e2,$46,$2f,$af,$1c,$4e,$6,$12,$ff
		dc.b	$e6,$17,$4e,$28,$9,$0,$3c,$aa,$4a,$e2,$66,$2f,$af,$1c,$4e,$6
		dc.b	$13,$ff,$e6,$17,$4e,$28,$8,$0,$3c,$0,$60,$e2,$26,$2f,$af,$1c
		dc.b	$4e,$6,$11,$ff,$e6,$17,$4e,$23,$a,$0,$3c,$55,$75,$e1,$e6,$2f
		dc.b	$af,$1c,$4e,$6,$f,$e1,$c6,$2a,$ea,$88,$8a,$d,$0,$65,$d,$40
		dc.b	$6a,$ff,$e6,$c2,$d,$40,$a1,$17,$4e,$0,$c,$ff,$e6,$22,$24,$1d
		dc.b	$22,$23,$1c,$0,$2,$22,$28,$22,$1e,$24,$1c,$0,$4,$22,$28,$24
		dc.b	$20,$26,$1e,$0,$6,$22,$24,$27,$20,$21,$26,$0,$8,$66,$65,$e
		dc.b	$a,$4,$22,$0,$24,$6,$26,$6,$27,$6,$25,$6,$23,$0,$0,$1a
		dc.b	$e,$0,$32,$0,$6,$11,$2e,$0,$2e,$11,$2e,$0,$2f,$11,$2e,$0
		dc.b	$30,$11,$2e,$0,$31,$0,$0,$80,$80,$0,$d0,$0,$32,$80,$80,$0
		dc.b	$ba,$0,$d,$80,$80,$0,$ba,$b,$b,$80,$80,$0,$ba,$28,$9,$80
		dc.b	$80,$0,$ba,$28,$8,$80,$80,$0,$ba,$23,$a,$80,$80,$0,$ba,$0
		dc.b	$c,$d0,$80,$2,$4,$5,$6,$7,$8,$a,$0,$84,$22,$0,$d1,$0
		dc.b	$0,$86,$22,$0,$d1,$0,$2,$85,$22,$0,$d1,$0,$4,$83,$22,$0
		dc.b	$d1,$0,$6,$82,$22,$0,$d1,$0,$3,$81,$22,$0,$d1,$0,$5,$0
		dc.b	$0,$0,$50,$0,$10,$4,$0,$0,$50,$0,$4,$0,$e,$0,$0,$0
		dc.b	$61,$1,$61,$0,$15,$1,$61,$0,$1a,$1,$7,$0,$15,$1,$2,$0
		dc.b	$15,$1,$2,$0,$11,$1,$2,$0,$7,$1,$2,$0,$2,$1,$7,$0
		dc.b	$2,$1,$24,$0,$2,$1,$24,$0,$fe,$5,$1,$0,$f,$5,$1,$0
		dc.b	$d,$5,$1,$0,$b,$1,$2,$0,$d9,$1,$7,$0,$e8,$1,$1a,$0
		dc.b	$1f,$0,$ec,$4,$c4,$54,$42,$0,$1,$54,$42,$6,$1a,$54,$42,$12
		dc.b	$13,$0,$0,$54,$45,$3a,$0,$4,$2,$0,$0,$6,$4,$8,$6,$6
		dc.b	$8,$6,$a,$8,$c,$c,$e,$6,$10,$6,$12,$6,$14,$8,$16,$16
		dc.b	$18,$6,$1a,$6,$1b,$6,$19,$8,$17,$17,$15,$6,$13,$6,$11,$6
		dc.b	$f,$8,$d,$d,$b,$6,$9,$8,$7,$7,$5,$6,$1,$6,$3,$0
		dc.b	$0,$1a,$6e,$b,$1c,$1a,$6e,$23,$1d,$1a,$6e,$0,$1e,$1a,$6e,$28
		dc.b	$1f,$0,$0,$0,$c0,$0,$10,$b,$0,$0,$c0,$0,$4,$0,$c,$0
		dc.b	$0,$0,$7a,$1,$2,$0,$7a,$1,$2,$0,$86,$1,$0,$0,$3f,$5
		dc.b	$1,$0,$4,$1,$0,$0,$3d,$5,$1,$0,$8,$1,$3f,$0,$7a,$5
		dc.b	$1,$0,$c,$1,$3d,$0,$7a,$5,$1,$0,$10,$1,$7a,$0,$3f,$5
		dc.b	$1,$0,$14,$1,$7a,$0,$3d,$5,$1,$0,$18,$1,$3f,$0,$c,$1
		dc.b	$3f,$0,$e8,$1,$3d,$0,$c,$1,$3d,$0,$e8,$1,$0,$0,$de,$1
		dc.b	$0,$0,$18,$1,$2,$0,$7,$5,$1,$0,$29,$1,$0,$0,$0,$1
		dc.b	$18,$0,$24,$1,$e8,$0,$dc,$1,$c,$0,$55,$1,$f4,$0,$ab,$1
		dc.b	$61,$0,$24,$1,$9f,$0,$dc,$1,$55,$0,$55,$1,$ab,$0,$ab,$1
		dc.b	$18,$0,$6d,$1,$e8,$0,$93,$1,$30,$0,$55,$1,$d0,$0,$ab,$1
		dc.b	$49,$0,$6d,$1,$49,$0,$93,$1,$49,$0,$24,$1,$30,$0,$24,$1
		dc.b	$d0,$0,$dc,$1,$7a,$0,$4,$1,$7a,$0,$fc,$5,$1,$0,$26,$5
		dc.b	$1,$0,$24,$c1,$d,$82,$40,$0,$6c,$6,$ac,$0,$82,$50,$51,$0
		dc.b	$0,$0,$84,$51,$52,$53,$50,$0,$0,$1,$4b,$4,$18,$c3,$fd,$7
		dc.b	$c1,$0,$54,$0,$c3,$13,$4e,$b,$2c,$0,$53,$1,$c3,$13,$2e,$b
		dc.b	$2c,$0,$6c,$4,$c4,$54,$42,$0,$2,$0,$0,$54,$44,$28,$1,$29
		dc.b	$0,$0,$0,$54,$44,$2a,$3,$2b,$2,$0,$0,$2,$c,$1,$aa,$54
		dc.b	$42,$c,$f,$54,$42,$4,$14,$54,$42,$4,$d,$54,$42,$15,$28,$54
		dc.b	$42,$e,$16,$54,$42,$6,$16,$54,$42,$2,$17,$54,$42,$17,$1e,$4
		dc.b	$8b,$1,$aa,$54,$44,$1c,$10,$20,$c,$0,$0,$54,$44,$14,$8,$18
		dc.b	$4,$0,$0,$54,$44,$4,$d,$8,$11,$0,$0,$54,$44,$28,$19,$29
		dc.b	$15,$0,$0,$54,$44,$16,$12,$1a,$e,$0,$0,$54,$44,$16,$a,$1a
		dc.b	$6,$0,$0,$54,$44,$17,$3,$1b,$2,$0,$0,$54,$44,$22,$1b,$1e
		dc.b	$17,$0,$0,$54,$44,$1e,$13,$22,$f,$0,$0,$0,$0,$0,$c0,$0
		dc.b	$10,$b,$0,$0,$c0,$0,$4,$0,$c,$0,$0,$0,$7a,$1,$2,$0
		dc.b	$7a,$1,$4,$0,$86,$1,$7a,$0,$3f,$1,$7a,$0,$3d,$1,$3d,$0
		dc.b	$7a,$1,$3f,$0,$7a,$5,$1,$0,$9,$5,$1,$0,$b,$5,$1,$0
		dc.b	$7,$5,$1,$0,$5,$1,$7a,$0,$2,$5,$1,$0,$15,$1,$86,$0
		dc.b	$fc,$5,$1,$0,$19,$1,$c1,$0,$3d,$1,$c3,$0,$3d,$5,$1,$0
		dc.b	$1e,$5,$1,$0,$1c,$1,$d0,$0,$18,$1,$d0,$0,$e,$1,$1a,$0
		dc.b	$f4,$1,$24,$0,$f4,$1,$24,$0,$c,$1,$24,$0,$24,$1,$c,$0
		dc.b	$24,$1,$24,$0,$dc,$1,$24,$0,$c3,$1,$24,$0,$ab,$1,$24,$0
		dc.b	$93,$1,$ab,$0,$24,$1,$ab,$0,$dc,$1,$6d,$0,$dc,$1,$55,$0
		dc.b	$f4,$1,$55,$0,$c,$1,$6d,$0,$24,$1,$6d,$0,$55,$1,$55,$0
		dc.b	$55,$1,$55,$0,$6d,$1,$24,$0,$6d,$1,$c,$0,$55,$1,$55,$0
		dc.b	$ab,$1,$6d,$0,$ab,$1,$55,$0,$93,$1,$c3,$0,$24,$c1,$d,$82
		dc.b	$40,$0,$ec,$6,$ac,$0,$82,$18,$26,$0,$82,$26,$28,$0,$82,$28
		dc.b	$2,$0,$0,$0,$85,$e,$0,$2,$18,$18,$26,$28,$3,$6,$2,$8
		dc.b	$2a,$24,$1a,$0,$0,$0,$6c,$5,$3e,$54,$42,$0,$14,$0,$0,$54
		dc.b	$44,$14,$1,$16,$0,$0,$0,$1,$4c,$1,$aa,$54,$42,$8,$c,$54
		dc.b	$42,$4,$5,$54,$42,$d,$11,$54,$42,$10,$20,$54,$42,$9,$1e,$2
		dc.b	$8b,$1,$aa,$54,$44,$c,$a,$e,$8,$0,$0,$54,$44,$5,$6,$7
		dc.b	$4,$0,$0,$54,$44,$d,$13,$f,$11,$0,$0,$54,$44,$20,$12,$22
		dc.b	$10,$0,$0,$54,$44,$1e,$b,$1c,$9,$0,$0,$0,$b,$1,$e8,$0
		dc.b	$d3,$1,$c1,$1b,$2e,$0,$2c,$1b,$2e,$0,$2a,$1b,$2e,$0,$2b,$1
		dc.b	$13,$2,$c1,$1b,$2e,$0,$2e,$1b,$2e,$0,$2f,$1a,$6e,$b,$32,$1b
		dc.b	$2e,$0,$33,$0,$93,$3,$c1,$1b,$2e,$0,$34,$1b,$2e,$0,$35,$0
		dc.b	$93,$4,$c1,$1b,$2e,$0,$36,$1b,$2e,$0,$37,$0,$93,$5,$c1,$1b
		dc.b	$2e,$0,$38,$1b,$2e,$0,$39,$0,$53,$6,$c1,$1b,$2e,$0,$3a,$0
		dc.b	$93,$7,$c1,$1b,$2e,$0,$3c,$1b,$2e,$0,$3d,$0,$d3,$8,$c1,$1b
		dc.b	$2e,$0,$3e,$1b,$2e,$0,$3f,$1b,$2e,$0,$40,$0,$53,$9,$c1,$1b
		dc.b	$2e,$0,$42,$0,$93,$a,$c1,$1b,$2e,$0,$44,$1b,$2e,$0,$45,$1
		dc.b	$13,$b,$c1,$1b,$2e,$0,$46,$1b,$2e,$0,$47,$1b,$2e,$0,$4a,$1b
		dc.b	$2e,$0,$4b,$1,$13,$c,$c1,$1b,$2e,$0,$48,$1b,$2e,$0,$49,$1b
		dc.b	$2e,$0,$4c,$1b,$2e,$0,$4d,$0,$93,$d,$c1,$1b,$2e,$0,$4e,$1b
		dc.b	$2e,$0,$4f,$0,$93,$e,$c1,$1b,$2e,$0,$52,$1b,$2e,$0,$53,$0
		dc.b	$93,$f,$c1,$1b,$2e,$0,$50,$1b,$2e,$0,$54,$0,$53,$10,$c1,$1b
		dc.b	$4e,$0,$56,$0,$0,$0,$b0,$0,$10,$6,$c0,$0,$7c,$0,$38,$0
		dc.b	$c,$0,$0,$0,$49,$1,$0,$49,$0,$1,$2,$11,$3,$1,$3,$7
		dc.b	$5,$1,$7,$0,$9,$1,$3,$11,$2,$1,$5,$7,$3,$1,$9,$0
		dc.b	$7,$1,$fd,$11,$fe,$1,$fb,$7,$fd,$5,$1,$0,$c,$1,$fe,$11
		dc.b	$fd,$1,$fd,$7,$fb,$5,$1,$0,$6,$1,$4,$4,$6,$1,$5,$0
		dc.b	$7,$1,$6,$4,$4,$1,$7,$0,$5,$1,$2,$e,$3,$1,$3,$e
		dc.b	$2,$1,$0,$30,$0,$1,$fa,$4,$fc,$5,$1,$0,$20,$1,$fc,$4
		dc.b	$fa,$5,$1,$0,$1c,$1,$fd,$e,$fe,$1,$fe,$e,$fd,$1,$0,$3f
		dc.b	$0,$0,$58,$14,$58,$0,$a8,$14,$58,$0,$a8,$14,$a8,$0,$58,$14
		dc.b	$a8,$6,$a7,$2,$59,$c,$59,$2,$a7,$7,$59,$2,$59,$d,$a7,$2
		dc.b	$a7,$1a,$0,$7f,$0,$0,$0,$10,$7d,$0,$7d,$10,$0,$0,$0,$10
		dc.b	$83,$0,$83,$10,$0,$1,$ac,$2,$dc,$44,$43,$0,$6,$7,$14,$44
		dc.b	$43,$0,$c,$13,$16,$44,$43,$0,$18,$19,$18,$44,$43,$0,$12,$d
		dc.b	$1a,$0,$0,$44,$45,$18,$a,$2,$0,$0,$2,$4,$6,$6,$1c,$8
		dc.b	$1a,$22,$26,$8,$30,$28,$2a,$6,$12,$8,$10,$e,$0,$0,$0,$44
		dc.b	$45,$18,$c,$2,$0,$0,$8,$a,$c,$6,$20,$8,$1e,$24,$26,$8
		dc.b	$32,$2c,$2e,$6,$18,$8,$16,$14,$0,$0,$0,$44,$45,$18,$e,$2
		dc.b	$0,$0,$3,$5,$7,$6,$1d,$8,$1b,$23,$26,$8,$31,$29,$2b,$6
		dc.b	$13,$8,$11,$f,$0,$0,$0,$44,$45,$18,$10,$2,$0,$0,$9,$b
		dc.b	$d,$6,$21,$8,$1f,$25,$26,$8,$33,$2d,$2f,$6,$19,$8,$17,$15
		dc.b	$0,$0,$0,$44,$44,$5,$1a,$1b,$4,$0,$12,$44,$44,$11,$1e,$29
		dc.b	$a,$0,$12,$44,$44,$17,$2c,$2d,$16,$0,$12,$44,$44,$10,$1f,$28
		dc.b	$b,$0,$12,$44,$44,$3,$22,$23,$2,$0,$12,$44,$44,$f,$24,$31
		dc.b	$8,$0,$12,$44,$44,$15,$32,$33,$14,$0,$12,$44,$44,$e,$25,$30
		dc.b	$9,$0,$12,$44,$45,$e,$2,$2,$0,$0,$2,$4,$6,$6,$c,$8
		dc.b	$a,$8,$0,$0,$0,$44,$45,$e,$4,$2,$0,$0,$3,$5,$7,$6
		dc.b	$d,$8,$b,$9,$0,$0,$0,$44,$45,$e,$6,$2,$0,$0,$e,$10
		dc.b	$12,$6,$18,$8,$16,$14,$0,$0,$0,$44,$45,$e,$8,$2,$0,$0
		dc.b	$f,$11,$13,$6,$19,$8,$17,$15,$0,$0,$0,$44,$41,$71,$2,$34
		dc.b	$12,$0,$0,$0,$40,$0,$10,$1,$40,$0,$24,$0,$20,$0,$c,$0
		dc.b	$0,$0,$61,$1,$0,$61,$0,$1,$0,$0,$0,$1,$3,$0,$7,$1
		dc.b	$9,$0,$0,$5,$1,$0,$5,$0,$65,$a,$4b,$0,$65,$a,$b5,$0
		dc.b	$0,$a,$82,$0,$9b,$a,$b5,$0,$9b,$a,$4b,$0,$0,$a,$7e,$2
		dc.b	$0,$81,$0,$44,$45,$e,$2,$2,$0,$0,$2,$2,$4,$6,$6,$8
		dc.b	$2,$2,$0,$0,$0,$44,$45,$e,$4,$2,$0,$0,$2,$2,$6,$6
		dc.b	$8,$8,$2,$2,$0,$0,$0,$44,$45,$e,$6,$2,$0,$0,$2,$2
		dc.b	$8,$6,$9,$8,$2,$2,$0,$0,$0,$44,$45,$e,$8,$2,$0,$0
		dc.b	$2,$2,$9,$6,$7,$8,$2,$2,$0,$0,$0,$44,$45,$e,$a,$2
		dc.b	$0,$0,$2,$2,$7,$6,$5,$8,$2,$2,$0,$0,$0,$44,$45,$e
		dc.b	$c,$2,$0,$0,$2,$2,$5,$6,$4,$8,$2,$2,$0,$0,$0,$c3
		dc.b	$5d,$7,$80,$0,$3c,$0,$c3,$1c,$6e,$6,$0,$0,$0,$0,$78,$0
		dc.b	$10,$2,$0,$0,$30,$0,$4c,$0,$a,$0,$0,$0,$4e,$1,$0,$13
		dc.b	$0,$1,$4e,$3,$0,$1,$1f,$3,$3e,$1,$1f,$3,$c2,$5,$1,$0
		dc.b	$3,$5,$1,$0,$7,$5,$1,$0,$5,$1,$0,$ed,$0,$0,$18,$7b
		dc.b	$12,$0,$18,$7b,$ee,$0,$0,$7b,$1e,$0,$e8,$7b,$12,$0,$e8,$7b
		dc.b	$ee,$0,$0,$7b,$e2,$2,$65,$0,$4c,$2,$65,$0,$b4,$4,$0,$0
		dc.b	$7f,$3,$9b,$0,$4c,$3,$9b,$0,$b4,$6,$0,$0,$81,$e,$18,$85
		dc.b	$12,$e,$18,$85,$ee,$e,$0,$85,$1e,$e,$e8,$85,$12,$e,$e8,$85
		dc.b	$ee,$e,$0,$85,$e2,$44,$43,$0,$2,$4,$2,$44,$43,$0,$2,$6
		dc.b	$4,$44,$43,$0,$4,$5,$6,$44,$43,$0,$3,$5,$8,$44,$43,$0
		dc.b	$3,$7,$a,$44,$43,$0,$6,$7,$c,$fe,$4,$8,$4,$a,$2,$0
		dc.b	$e,$fe,$4,$8,$6,$c,$2,$0,$10,$fe,$4,$a,$5,$b,$4,$0
		dc.b	$12,$fe,$4,$9,$5,$b,$3,$0,$14,$fe,$4,$9,$7,$d,$3,$0
		dc.b	$16,$fe,$4,$7,$c,$d,$6,$0,$18,$44,$43,$e,$8,$a,$1a,$44
		dc.b	$43,$e,$8,$c,$1c,$44,$43,$e,$a,$b,$1e,$44,$43,$e,$9,$b
		dc.b	$20,$44,$43,$e,$9,$d,$22,$44,$43,$e,$c,$d,$24,$0,$0,$0
		dc.b	$4c,$0,$10,$2,$0,$0,$30,$0,$20,$0,$c,$0,$0,$0,$55,$1
		dc.b	$0,$49,$0,$1,$0,$18,$0,$1,$4,$55,$9,$1,$c,$55,$0,$1
		dc.b	$4,$55,$f7,$1,$9,$0,$13,$1,$18,$0,$0,$5,$1,$0,$b,$4
		dc.b	$64,$e,$4b,$6,$64,$e,$b5,$8,$0,$e,$82,$7,$9c,$e,$b5,$5
		dc.b	$9c,$e,$4b,$4,$0,$e,$7e,$4,$0,$7f,$0,$44,$45,$e,$2,$2
		dc.b	$4,$4,$0,$2,$a,$6,$c,$8,$2,$0,$6,$0,$0,$44,$45,$e
		dc.b	$4,$2,$6,$6,$0,$2,$c,$6,$e,$8,$2,$0,$8,$0,$0,$44
		dc.b	$45,$e,$6,$2,$8,$8,$0,$2,$e,$6,$f,$8,$2,$0,$9,$0
		dc.b	$0,$44,$45,$e,$8,$2,$9,$9,$0,$2,$f,$6,$d,$8,$2,$0
		dc.b	$7,$0,$0,$44,$45,$e,$a,$2,$7,$7,$0,$2,$d,$6,$b,$8
		dc.b	$2,$0,$5,$0,$0,$44,$45,$e,$c,$2,$5,$5,$0,$2,$b,$6
		dc.b	$a,$8,$2,$0,$4,$0,$0,$44,$45,$e,$e,$4,$4,$0,$6,$6
		dc.b	$8,$6,$9,$6,$7,$6,$5,$0,$0,$0,$0,$0,$4c,$0,$10,$2
		dc.b	$0,$0,$30,$0,$20,$0,$c,$0,$0,$0,$44,$1,$0,$44,$0,$1
		dc.b	$0,$0,$0,$1,$7,$44,$f,$1,$13,$44,$0,$1,$7,$44,$f1,$1
		dc.b	$3,$0,$7,$1,$9,$0,$0,$5,$1,$0,$b,$4,$64,$f2,$4b,$6
		dc.b	$64,$f2,$b5,$8,$0,$f2,$82,$7,$9c,$f2,$b5,$5,$9c,$f2,$4b,$4
		dc.b	$0,$f2,$7e,$4,$0,$7f,$0,$44,$45,$e,$2,$2,$4,$4,$0,$2
		dc.b	$a,$6,$c,$8,$2,$0,$6,$0,$0,$44,$45,$e,$4,$2,$6,$6
		dc.b	$0,$2,$c,$6,$e,$8,$2,$0,$8,$0,$0,$44,$45,$e,$6,$2
		dc.b	$8,$8,$0,$2,$e,$6,$f,$8,$2,$0,$9,$0,$0,$44,$45,$e
		dc.b	$8,$2,$9,$9,$0,$2,$f,$6,$d,$8,$2,$0,$7,$0,$0,$44
		dc.b	$45,$e,$a,$2,$7,$7,$0,$2,$d,$6,$b,$8,$2,$0,$5,$0
		dc.b	$0,$44,$45,$e,$c,$2,$5,$5,$0,$2,$b,$6,$a,$8,$2,$0
		dc.b	$4,$0,$0,$44,$45,$e,$e,$4,$4,$0,$6,$6,$8,$6,$9,$6
		dc.b	$7,$6,$5,$0,$0,$0,$0,$0,$4c,$0,$10,$2,$0,$0,$30,$0
		dc.b	$20,$0,$9,$0,$0,$0,$4e,$1,$0,$4e,$0,$1,$0,$3a,$0,$1
		dc.b	$9,$0,$12,$1,$17,$0,$0,$5,$1,$0,$5,$1,$3,$b,$6,$1
		dc.b	$7,$b,$0,$1,$3,$b,$fa,$0,$62,$1d,$4a,$0,$62,$1d,$b6,$0
		dc.b	$0,$1d,$85,$0,$9e,$1d,$b6,$0,$9e,$1d,$4a,$0,$0,$1d,$7b,$2
		dc.b	$7d,$14,$0,$44,$45,$e,$2,$2,$0,$0,$a,$a,$4,$6,$6,$8
		dc.b	$c,$c,$0,$0,$0,$44,$45,$e,$4,$2,$0,$0,$c,$c,$6,$6
		dc.b	$8,$8,$e,$e,$0,$0,$0,$44,$45,$e,$6,$2,$0,$0,$e,$e
		dc.b	$8,$6,$9,$8,$f,$f,$0,$0,$0,$44,$45,$e,$8,$2,$0,$0
		dc.b	$f,$f,$9,$6,$7,$8,$d,$d,$0,$0,$0,$44,$45,$e,$a,$2
		dc.b	$0,$0,$d,$d,$7,$6,$5,$8,$b,$b,$0,$0,$0,$44,$45,$e
		dc.b	$c,$2,$0,$0,$b,$b,$5,$6,$4,$8,$a,$a,$0,$0,$0,$44
		dc.b	$41,$b8,$b,$2,$e,$0,$0,$0,$44,$0,$10,$1,$40,$0,$24,$0
		dc.b	$24,$0,$c,$0,$0,$0,$61,$1,$0,$61,$0,$1,$9,$57,$9,$1
		dc.b	$9,$57,$f7,$1,$9,$0,$9,$5,$1,$0,$7,$0,$59,$59,$0,$0
		dc.b	$0,$59,$a7,$0,$a7,$59,$0,$0,$0,$59,$59,$2,$7f,$0,$0,$4
		dc.b	$0,$0,$81,$3,$81,$0,$0,$2,$0,$0,$7f,$44,$43,$0,$2,$4
		dc.b	$2,$44,$43,$0,$4,$5,$4,$44,$43,$0,$3,$5,$6,$44,$43,$0
		dc.b	$2,$3,$8,$44,$44,$6,$4,$8,$2,$0,$a,$44,$44,$8,$5,$9
		dc.b	$4,$0,$c,$44,$44,$7,$5,$9,$3,$0,$e,$44,$44,$6,$3,$7
		dc.b	$2,$0,$10,$0,$0,$0,$3c,$0,$10,$1,$40,$0,$24,$0,$1c,$0
		dc.b	$c,$0,$0,$0,$4e,$1,$f7,$0,$f7,$1,$0,$4e,$f7,$1,$f7,$4e
		dc.b	$0,$1,$0,$4e,$9,$1,$f7,$0,$9,$0,$a7,$b,$a7,$8,$a7,$b
		dc.b	$59,$2,$0,$7f,$0,$6,$0,$0,$7f,$2,$0,$0,$81,$4,$81,$0
		dc.b	$0,$ff,$e6,$44,$47,$0,$2,$4,$2,$44,$47,$8,$4,$6,$4,$44
		dc.b	$44,$5,$4,$6,$2,$0,$6,$88,$83,$2,$1,$0,$a,$88,$87,$4
		dc.b	$0,$8,$c,$88,$83,$6,$8,$9,$8,$0,$6,$0,$0,$0,$7a,$0
		dc.b	$1e,$4,$c0,$0,$6a,$0,$14,$0,$c,$0,$0,$0,$66,$0,$17,$6
		dc.b	$66,$0,$e,$66,$8a,$66,$8a,$1,$e,$0,$0,$1,$13,$0,$3d,$1
		dc.b	$2b,$0,$61,$1,$4e,$0,$61,$1,$66,$0,$3d,$1,$4e,$0,$18,$1
		dc.b	$2b,$0,$18,$1,$3d,$0,$e8,$1,$18,$0,$b7,$1,$29,$0,$9a,$1
		dc.b	$13,$c,$b2,$1,$29,$c,$9a,$1,$4,$0,$d0,$1,$c,$0,$30,$1
		dc.b	$0,$0,$24,$1,$c,$0,$c8,$1,$0,$0,$3d,$1,$3d,$0,$b7,$1
		dc.b	$3d,$0,$30,$1,$61,$0,$53,$e,$0,$2f,$75,$10,$0,$0,$82,$e
		dc.b	$6d,$0,$3f,$12,$0,$7f,$0,$e3,$46,$5f,$5e,$54,$45,$2e,$0,$4
		dc.b	$0,$0,$2,$6,$4,$6,$6,$6,$8,$6,$a,$8,$18,$18,$16,$8
		dc.b	$1c,$1c,$e,$6,$f,$8,$1d,$1d,$17,$8,$19,$19,$b,$6,$9,$6
		dc.b	$7,$6,$5,$6,$3,$6,$1,$8,$1a,$1a,$0,$0,$0,$88,$8a,$c
		dc.b	$0,$61,$20,$40,$6b,$0,$6,$22,$24,$12,$f,$13,$e,$0,$2,$66
		dc.b	$64,$14,$11,$15,$10,$0,$4,$66,$68,$12,$10,$14,$e,$0,$6,$66
		dc.b	$64,$14,$13,$15,$12,$0,$8,$c2,$d,$40,$a1,$17,$4e,$0,$d,$c2
		dc.b	$d,$40,$40,$17,$4e,$0,$c,$43,$c6,$1a,$e,$0,$1e,$0,$b,$4
		dc.b	$c4,$c1,$d,$40,$82,$0,$3c,$80,$11,$1a,$6e,$6,$24,$c1,$d,$40
		dc.b	$83,$0,$3c,$80,$6e,$1a,$6e,$6,$25,$0,$0,$80,$80,$0,$d0,$0
		dc.b	$1e,$80,$80,$0,$ba,$0,$d,$80,$80,$0,$ba,$0,$c,$d0,$80,$2
		dc.b	$4,$6,$7,$8,$0,$81,$22,$0,$d1,$0,$22,$82,$22,$0,$d1,$0
		dc.b	$23,$0,$0,$1,$34,$0,$10,$4,$40,$0,$54,$0,$e4,$0,$8,$0
		dc.b	$0,$0,$61,$1,$0,$0,$61,$1,$5c,$0,$1e,$1,$39,$0,$b1,$1
		dc.b	$b,$21,$21,$1,$23,$21,$0,$1,$b,$21,$df,$1,$0,$27,$0,$1
		dc.b	$39,$0,$4f,$1,$5c,$0,$e2,$1,$0,$0,$9f,$1,$16,$13,$45,$1
		dc.b	$3b,$13,$2b,$1,$49,$13,$0,$1,$3b,$13,$d5,$1,$16,$13,$bb,$1
		dc.b	$e4,$21,$15,$1,$e4,$21,$eb,$0,$1b,$5a,$55,$2,$48,$5a,$34,$2
		dc.b	$59,$5a,$0,$4,$48,$5a,$cc,$4,$1b,$5a,$ab,$5,$e5,$5a,$ab,$5
		dc.b	$b8,$5a,$cc,$3,$a7,$5a,$0,$3,$b8,$5a,$34,$0,$e5,$5a,$55,$0
		dc.b	$0,$68,$48,$e,$2a,$68,$3a,$2,$45,$68,$16,$10,$45,$68,$ea,$4
		dc.b	$2a,$68,$c6,$12,$0,$68,$b8,$5,$d6,$68,$c6,$11,$bb,$68,$ea,$3
		dc.b	$bb,$68,$16,$f,$d6,$68,$3a,$6,$0,$76,$2d,$6,$1a,$76,$24,$8
		dc.b	$2b,$76,$e,$8,$2b,$76,$f2,$a,$1a,$76,$dc,$a,$0,$76,$d3,$20
		dc.b	$e6,$76,$dc,$20,$d5,$76,$f2,$1e,$d5,$76,$e,$1e,$e6,$76,$24,$6
		dc.b	$1e,$79,$16,$8,$1e,$79,$ea,$a,$f5,$79,$dd,$1e,$db,$79,$0,$6
		dc.b	$f5,$79,$23,$c,$14,$7c,$e,$c,$14,$7c,$f2,$c,$f9,$7c,$e9,$c
		dc.b	$e7,$7c,$0,$c,$f9,$7c,$17,$0,$2c,$66,$3c,$2,$47,$66,$e9,$4
		dc.b	$0,$66,$b5,$3,$b9,$66,$e9,$0,$d4,$66,$3c,$2,$2f,$70,$22,$4
		dc.b	$2f,$70,$de,$5,$ee,$70,$c9,$3,$c6,$70,$0,$0,$ee,$70,$37,$6
		dc.b	$0,$7f,$0,$c,$21,$71,$2d,$c,$35,$71,$ef,$c,$0,$71,$c8,$c
		dc.b	$cb,$71,$ef,$c,$df,$71,$2d,$0,$b,$1e,$84,$ff,$e6,$2,$2c,$b
		dc.b	$70,$0,$3,$c,$0,$2,$68,$88,$83,$c,$2,$4,$6a,$0,$3,$c
		dc.b	$4,$5,$6c,$88,$83,$c,$3,$5,$6e,$0,$3,$c,$0,$3,$70,$0
		dc.b	$6,$0,$0,$5,$c,$7,$a0,$0,$3,$0,$2,$6,$52,$0,$3,$2
		dc.b	$4,$8,$54,$0,$3,$4,$5,$a,$56,$0,$3,$3,$5,$20,$58,$0
		dc.b	$3,$0,$3,$1e,$5a,$88,$83,$2,$6,$8,$5c,$88,$83,$4,$8,$a
		dc.b	$5e,$88,$83,$5,$a,$20,$60,$88,$83,$3,$1e,$20,$62,$88,$83,$0
		dc.b	$6,$1e,$64,$0,$5,$c,$66,$4,$6,$0,$8,$6,$a,$6,$20,$6
		dc.b	$1e,$0,$0,$0,$6,$0,$0,$0,$3,$0,$e,$14,$2,$0,$3,$2
		dc.b	$e,$16,$4,$0,$3,$2,$10,$18,$6,$0,$3,$4,$10,$1a,$8,$0
		dc.b	$3,$4,$12,$1c,$a,$0,$3,$5,$12,$1d,$c,$0,$3,$5,$11,$1b
		dc.b	$e,$0,$3,$3,$11,$19,$10,$0,$3,$3,$f,$17,$12,$0,$3,$0
		dc.b	$f,$15,$14,$88,$83,$0,$14,$15,$16,$88,$83,$e,$14,$16,$18,$88
		dc.b	$83,$2,$16,$18,$1a,$88,$83,$10,$18,$1a,$1c,$88,$83,$4,$1a,$1c
		dc.b	$1e,$88,$83,$12,$1c,$1d,$20,$88,$83,$5,$1b,$1d,$22,$88,$83,$11
		dc.b	$19,$1b,$24,$88,$83,$3,$17,$19,$26,$88,$83,$f,$15,$17,$28,$0
		dc.b	$3,$6,$14,$15,$2a,$0,$3,$6,$14,$16,$2c,$0,$3,$8,$16,$18
		dc.b	$2e,$0,$3,$8,$18,$1a,$30,$0,$3,$a,$1a,$1c,$32,$0,$3,$a
		dc.b	$1c,$1d,$34,$0,$3,$20,$1b,$1d,$36,$0,$3,$20,$19,$1b,$38,$0
		dc.b	$3,$1e,$17,$19,$3a,$0,$3,$1e,$15,$17,$3c,$88,$83,$6,$8,$16
		dc.b	$3e,$88,$83,$8,$a,$1a,$40,$88,$83,$a,$20,$1d,$42,$88,$83,$1e
		dc.b	$20,$19,$44,$88,$83,$6,$1e,$15,$46,$0,$3,$c,$6,$8,$48,$0
		dc.b	$3,$c,$8,$a,$4a,$0,$3,$c,$a,$20,$4c,$0,$3,$c,$1e,$20
		dc.b	$4e,$0,$3,$c,$6,$1e,$50,$0,$6,$0,$0,$0,$18,$0,$10,$0
		dc.b	$80,$0,$18,$0,$4,$0,$6,$0,$0,$0,$7a,$1,$7a,$0,$7a,$5
		dc.b	$1,$0,$0,$c2,$1d,$5,$c1,$2,$34,$0,$c2,$c2,$d,$40,$83,$c1
		dc.b	$d,$40,$82,$0,$6,$0,$53,$1,$c1,$14,$e,$0,$ff,$0,$54,$1
		dc.b	$c1,$14,$6e,$0,$ff,$1c,$9b,$0,$ff,$54,$44,$0,$0,$c2,$1d,$6
		dc.b	$c1,$3,$b4,$0,$c2,$c2,$d,$40,$83,$c1,$d,$40,$82,$0,$6,$1
		dc.b	$13,$1,$c1,$14,$6e,$0,$0,$14,$e,$28,$1,$14,$e,$b,$2,$14
		dc.b	$e,$23,$3,$1,$14,$1,$c1,$14,$e,$0,$0,$11,$2e,$28,$1,$14
		dc.b	$e,$b,$2,$14,$e,$23,$3,$1c,$9b,$0,$ff,$64,$44,$0,$0,$1c
		dc.b	$bb,$0,$ff,$1c,$44,$0,$0,$0,$78,$0,$10,$6,$80,$0,$78,$0
		dc.b	$4,$0,$8,$0,$0,$0,$44,$1,$9,$3,$9,$1,$9,$3,$f7,$1
		dc.b	$9,$3,$1d,$1,$9,$3,$e3,$1,$9,$3,$30,$1,$9,$3,$d0,$1
		dc.b	$9,$3,$44,$1,$9,$3,$bc,$1,$1d,$3,$9,$1,$1d,$3,$f7,$1
		dc.b	$1d,$3,$1d,$1,$1d,$3,$e3,$1,$1d,$3,$30,$1,$1d,$3,$d0,$1
		dc.b	$1d,$3,$44,$1,$1d,$3,$bc,$1,$30,$3,$9,$1,$30,$3,$f7,$1
		dc.b	$30,$3,$1d,$1,$30,$3,$e3,$1,$30,$3,$30,$1,$30,$3,$d0,$1
		dc.b	$44,$3,$9,$1,$44,$3,$f7,$1,$44,$3,$1d,$1,$44,$3,$e3,$4
		dc.b	$6b,$3,$c,$ff,$e6,$12,$18,$58,$2,$0,$3,$6,$9,$c,$f,$12
		dc.b	$15,$18,$1b,$1e,$21,$24,$27,$2a,$2d,$30,$33,$7f,$7f,$12,$18,$bb
		dc.b	$2,$1,$4,$7,$a,$d,$10,$13,$16,$19,$1c,$1f,$22,$25,$28,$2b
		dc.b	$2e,$31,$7f,$18,$18,$f4,$1,$2,$5,$8,$b,$e,$11,$14,$17,$1a
		dc.b	$1d,$20,$23,$26,$29,$2c,$2f,$32,$7f,$1c,$9b,$0,$ff,$18,$8,$0
		dc.b	$0,$0,$54,$0,$10,$4,$40,$0,$54,$0,$4,$0,$8,$0,$0,$0
		dc.b	$61,$1,$0,$0,$61,$1,$5c,$0,$1e,$1,$39,$0,$b1,$1,$b,$21
		dc.b	$21,$1,$23,$21,$0,$1,$b,$21,$df,$1,$0,$27,$0,$1,$39,$0
		dc.b	$4f,$1,$5c,$0,$e2,$1,$0,$0,$9f,$1,$16,$13,$45,$1,$3b,$13
		dc.b	$2b,$1,$49,$13,$0,$1,$3b,$13,$d5,$1,$16,$13,$bb,$1,$e4,$21
		dc.b	$15,$1,$e4,$21,$eb,$0,$b,$1e,$84,$4,$c,$b,$70,$e1,$86,$4c
		dc.b	$4b,$16,$5,$c,$0,$4,$0,$0,$2,$6,$4,$6,$5,$6,$3,$0
		dc.b	$0,$ff,$e6,$1,$2,$c,$0,$1,$2,$c,$2,$1,$2,$c,$4,$1
		dc.b	$2,$c,$5,$1,$2,$c,$3,$1,$2,$0,$2,$1,$2,$2,$4,$1
		dc.b	$2,$4,$5,$1,$2,$5,$3,$1,$2,$3,$0,$0,$0,$6,$8c,$7
		dc.b	$a0,$e1,$86,$4c,$4b,$16,$5,$c,$0,$4,$0,$0,$2,$6,$4,$6
		dc.b	$5,$6,$3,$0,$0,$ff,$e6,$1,$2,$0,$6,$1,$2,$2,$8,$1
		dc.b	$2,$4,$a,$1,$2,$5,$20,$1,$2,$3,$1e,$1,$2,$2,$6,$1
		dc.b	$2,$4,$8,$1,$2,$5,$a,$1,$2,$3,$20,$1,$2,$0,$1e,$1
		dc.b	$2,$6,$8,$1,$2,$8,$a,$1,$2,$a,$20,$1,$2,$20,$1e,$1
		dc.b	$2,$1e,$6,$1,$2,$0,$2,$1,$2,$2,$4,$1,$2,$4,$5,$1
		dc.b	$2,$5,$3,$1,$2,$3,$0,$0,$0,$e1,$86,$4c,$4b,$16,$5,$16
		dc.b	$0,$4,$0,$0,$e,$6,$2,$6,$10,$6,$4,$6,$12,$6,$5,$6
		dc.b	$11,$6,$3,$6,$f,$0,$0,$0,$6,$1,$2,$0,$e,$1,$2,$e
		dc.b	$2,$1,$2,$2,$10,$1,$2,$10,$4,$1,$2,$4,$12,$1,$2,$12
		dc.b	$5,$1,$2,$5,$11,$1,$2,$11,$3,$1,$2,$3,$f,$1,$2,$f
		dc.b	$0,$1,$2,$0,$14,$1,$2,$e,$16,$1,$2,$2,$18,$1,$2,$10
		dc.b	$1a,$1,$2,$4,$1c,$1,$2,$12,$1d,$1,$2,$5,$1b,$1,$2,$11
		dc.b	$19,$1,$2,$3,$17,$1,$2,$f,$15,$1,$2,$0,$15,$1,$2,$e
		dc.b	$14,$1,$2,$2,$16,$1,$2,$10,$18,$1,$2,$4,$1a,$1,$2,$12
		dc.b	$1c,$1,$2,$5,$1d,$1,$2,$11,$1b,$1,$2,$3,$19,$1,$2,$f
		dc.b	$17,$1,$2,$15,$14,$1,$2,$14,$16,$1,$2,$16,$18,$1,$2,$18
		dc.b	$1a,$1,$2,$1a,$1c,$1,$2,$1c,$1d,$1,$2,$1d,$1b,$1,$2,$1b
		dc.b	$19,$1,$2,$19,$17,$1,$2,$17,$15,$1,$2,$6,$15,$1,$2,$6
		dc.b	$14,$1,$2,$6,$16,$1,$2,$8,$16,$1,$2,$8,$18,$1,$2,$8
		dc.b	$1a,$1,$2,$a,$1a,$1,$2,$a,$1c,$1,$2,$a,$1d,$1,$2,$20
		dc.b	$1d,$1,$2,$20,$1b,$1,$2,$20,$19,$1,$2,$1e,$19,$1,$2,$1e
		dc.b	$17,$1,$2,$1e,$15,$1,$2,$6,$8,$1,$2,$8,$a,$1,$2,$a
		dc.b	$20,$1,$2,$1e,$20,$1,$2,$6,$1e,$1,$2,$c,$6,$1,$2,$c
		dc.b	$8,$1,$2,$c,$a,$1,$2,$c,$20,$1,$2,$c,$1e,$0,$0,$0
		dc.b	$58,$0,$10,$3,$c0,$0,$4c,$0,$10,$0,$a,$0,$0,$0,$75,$1
		dc.b	$0,$34,$0,$1,$57,$0,$57,$1,$0,$0,$8b,$1,$75,$0,$e3,$1
		dc.b	$3a,$0,$8b,$1,$a9,$0,$a9,$1,$8b,$0,$1d,$1,$e3,$0,$3a,$1
		dc.b	$2b,$0,$75,$1,$e3,$34,$2b,$1,$e3,$0,$e,$1,$1d,$2b,$1d,$1
		dc.b	$3a,$0,$2b,$1,$e3,$34,$e3,$1,$1d,$0,$b7,$0,$0,$6c,$42,$0
		dc.b	$58,$52,$db,$0,$a8,$52,$db,$ff,$e6,$1,$4c,$9,$88,$1,$3,$2
		dc.b	$3,$0,$2,$1,$3,$2,$4,$0,$4,$1,$3,$4,$3,$0,$6,$0
		dc.b	$0,$1,$5,$10,$2,$2,$0,$0,$12,$14,$3,$8,$e,$10,$2,$8
		dc.b	$18,$16,$0,$0,$0,$1,$5,$10,$4,$2,$0,$0,$16,$18,$2,$8
		dc.b	$6,$8,$4,$8,$1c,$1a,$0,$0,$0,$1,$5,$10,$6,$2,$0,$0
		dc.b	$1a,$1c,$4,$8,$a,$c,$3,$8,$14,$12,$0,$0,$0,$0,$0,$0
		dc.b	$64,$0,$10,$4,$40,$0,$54,$0,$14,$0,$b,$0,$0,$0,$49,$1
		dc.b	$0,$13,$0,$1,$2b,$0,$2b,$1,$1d,$0,$d5,$1,$1d,$0,$f2,$1
		dc.b	$e,$0,$c6,$1,$d5,$0,$d5,$1,$3a,$0,$e,$1,$e,$0,$1d,$1
		dc.b	$e3,$0,$3a,$1,$f2,$13,$e,$1,$f2,$0,$7,$1,$15,$13,$7,$1
		dc.b	$1d,$0,$1d,$1,$e,$11,$f2,$1,$1d,$0,$e3,$1,$f9,$13,$f9,$1
		dc.b	$f9,$0,$dc,$0,$0,$73,$34,$0,$3c,$6f,$f6,$0,$0,$73,$cc,$0
		dc.b	$c4,$6f,$f6,$ff,$e6,$1,$ac,$4,$c4,$1,$3,$2,$3,$0,$2,$1
		dc.b	$3,$2,$4,$0,$4,$1,$3,$4,$5,$0,$6,$1,$3,$3,$5,$0
		dc.b	$8,$0,$0,$1,$5,$10,$2,$2,$0,$0,$12,$14,$3,$8,$10,$e
		dc.b	$2,$8,$18,$16,$0,$0,$0,$1,$5,$10,$4,$2,$0,$0,$16,$18
		dc.b	$2,$8,$c,$6,$4,$8,$1c,$1a,$0,$0,$0,$1,$5,$10,$6,$2
		dc.b	$0,$0,$1a,$1c,$4,$8,$8,$9,$5,$8,$20,$1e,$0,$0,$0,$1
		dc.b	$5,$10,$8,$2,$0,$0,$1e,$20,$5,$8,$a,$7,$3,$8,$14,$12
		ds.b	6
		dc.b	$40,$0,$10,$1,$c0,$0,$2c,$0,$18,$0,$9,$0,$0,$0,$43,$1
		dc.b	$43,$23,$1,$1,$43,$23,$ff,$1,$43,$f9,$1,$1,$43,$f9,$ff,$1
		dc.b	$38,$0,$0,$1,$0,$23,$1,$1,$0,$23,$ff,$0,$0,$0,$7f,$2
		dc.b	$0,$0,$81,$0,$7f,$0,$0,$1,$81,$0,$0,$0,$0,$7f,$0,$ff
		dc.b	$e6,$4,$b,$6,$1a,$60,$5,$e,$2,$4,$0,$0,$1,$6,$5,$6
		dc.b	$9,$6,$8,$6,$4,$0,$0,$60,$5,$e,$4,$4,$2,$0,$3,$6
		dc.b	$7,$6,$9,$6,$8,$6,$6,$0,$0,$1,$8b,$1,$86,$54,$44,$4
		dc.b	$2,$6,$0,$0,$6,$54,$44,$5,$3,$7,$1,$0,$8,$54,$44,$2
		dc.b	$1,$3,$0,$0,$a,$1,$4b,$80,$2,$0,$1a,$0,$2,$c2,$d,$4
		dc.b	$c1,$12,$4e,$64,$0,$c2,$d,$5,$c1,$12,$4e,$64,$a,$1,$4b,$80
		dc.b	$4,$0,$1a,$0,$4,$c2,$d,$6,$c1,$12,$4e,$4c,$3,$c2,$d,$7
		dc.b	$c1,$12,$4e,$4c,$c,$0,$6,$0,$0,$0,$30,$0,$10,$2,$0,$0
		dc.b	$30,$0,$4,$0,$9,$0,$0,$0,$61,$1,$61,$1d,$3a,$1,$44,$9
		dc.b	$27,$1,$27,$1d,$13,$1,$1d,$9,$ed,$1,$44,$1d,$e3,$1,$30,$9
		dc.b	$b2,$1,$13,$1d,$d0,$1,$27,$9,$4e,$18,$18,$c4,$9,$0,$1,$4
		dc.b	$5,$8,$9,$c,$d,$6,$7,$a,$2,$3,$e,$7f,$7f,$0,$0,$0
		dc.b	$54,$0,$10,$4,$0,$0,$50,$0,$8,$0,$a,$0,$0,$0,$49,$1
		dc.b	$3a,$5,$3a,$1,$49,$f9,$c6,$1,$0,$0,$0,$b,$1,$0,$1,$b
		dc.b	$1,$2,$3,$b,$1,$0,$2,$b,$1,$0,$4,$b,$1,$2,$4,$1
		dc.b	$3a,$33,$3a,$1,$49,$24,$c6,$1,$0,$2b,$0,$b,$1,$10,$11,$b
		dc.b	$1,$12,$13,$b,$1,$10,$12,$b,$1,$10,$14,$b,$1,$12,$14,$0
		dc.b	$0,$82,$e,$0,$ac,$6,$dc,$34,$4,$2,$1,$3,$0,$0,$2,$0
		dc.b	$0,$24,$9,$10,$0,$a,$fc,$24,$9,$11,$1,$a,$fc,$24,$9,$12
		dc.b	$2,$a,$fc,$24,$9,$13,$3,$a,$fc,$24,$9,$14,$4,$a,$fc,$24
		dc.b	$9,$16,$6,$a,$fc,$24,$9,$18,$8,$a,$fc,$24,$9,$1a,$a,$a
		dc.b	$fc,$24,$9,$1b,$b,$a,$fc,$24,$9,$1c,$c,$a,$fc,$24,$9,$1d
		dc.b	$d,$a,$fc,$24,$9,$1e,$e,$a,$fc,$24,$9,$1f,$f,$a,$fc,$0
		dc.b	$0,$0,$70,$0,$10,$4,$0,$0,$50,$0,$24,$0,$8,$0,$0,$0
		dc.b	$6d,$1,$f,$0,$27,$1,$f,$0,$d9,$1,$0,$6d,$17,$1,$f,$3e
		dc.b	$27,$1,$f,$13,$7,$1,$0,$23,$7,$1,$0,$23,$d9,$1,$f,$3e
		dc.b	$7,$1,$f,$13,$d9,$1,$f,$2e,$17,$1,$0,$2e,$7,$1,$0,$2e
		dc.b	$27,$1,$1f,$0,$b2,$1,$f,$0,$ca,$1,$17,$0,$9b,$1,$36,$0
		dc.b	$ab,$0,$7f,$0,$0,$2,$0,$0,$81,$0,$0,$0,$7f,$8,$0,$0
		dc.b	$81,$6,$78,$28,$0,$6,$0,$28,$78,$4,$0,$28,$88,$c,$59,$59
		dc.b	$0,$41,$46,$60,$4,$9,$e,$f,$8,$0,$8,$60,$5,$e,$2,$4
		dc.b	$0,$0,$6,$6,$e,$6,$8,$6,$10,$6,$2,$0,$0,$60,$5,$e
		dc.b	$3,$4,$1,$0,$7,$6,$f,$6,$9,$6,$11,$6,$3,$0,$0,$60
		dc.b	$5,$c,$4,$4,$2,$0,$10,$6,$c,$6,$11,$6,$3,$0,$0,$60
		dc.b	$4,$1,$6,$7,$0,$0,$6,$22,$27,$6,$4,$e,$a,$22,$23,$6
		dc.b	$4,$7,$c,$22,$23,$4,$e,$f,$e,$8,$cb,$f,$42,$88,$85,$6
		dc.b	$2,$c,$12,$9,$2,$0,$0,$88,$85,$6,$3,$c,$13,$9,$3,$0
		dc.b	$0,$88,$85,$6,$8,$c,$14,$9,$8,$0,$0,$88,$85,$6,$6,$c
		dc.b	$16,$9,$6,$0,$0,$4,$b,$3,$a8,$0,$eb,$80,$2,$1c,$db,$69
		dc.b	$12,$10,$80,$0,$a,$8,$2,$42,$10,$40,$6c,$0,$eb,$80,$3,$1c
		dc.b	$db,$41,$13,$10,$80,$0,$a,$8,$3,$42,$11,$40,$6d,$0,$6b,$80
		dc.b	$8,$1c,$db,$65,$14,$10,$80,$0,$6b,$80,$6,$1c,$db,$4d,$16,$10
		dc.b	$80,$0,$a,$8,$4,$5c,$11,$40,$6e,$1c,$ee,$40,$18,$1c,$ee,$68
		dc.b	$1b,$1c,$ee,$4b,$1a,$1c,$ee,$63,$19,$1c,$ee,$63,$1c,$1c,$ee,$40
		dc.b	$1d,$1c,$ee,$63,$1e,$1c,$ee,$4b,$1f,$41,$86,$22,$24,$10,$a,$8
		dc.b	$c,$0,$10,$22,$24,$11,$a,$9,$c,$0,$11,$0,$6,$0,$0,$0
		dc.b	$30,$0,$10,$2,$0,$0,$30,$0,$4,$0,$3,$0,$0,$0,$6e,$1
		dc.b	$0,$0,$64,$1,$32,$0,$56,$1,$56,$0,$31,$1,$64,$0,$0,$1
		dc.b	$56,$0,$ce,$1,$32,$0,$aa,$1,$0,$0,$9c,$1,$6e,$0,$69,$c2
		dc.b	$1d,$86,$40,$c2,$5d,$1,$c2,$0,$3c,$0,$c2,$1d,$1b,$6,$ff,$0
		dc.b	$88,$c2,$2d,$c,$c2,$0,$3c,$0,$c2,$1d,$1b,$6,$ff,$10,$88,$c2
		dc.b	$4d,$4,$c2,$0,$34,$0,$c2,$2,$ef,$0,$b,$18,$6a,$1,$4c,$9
		dc.b	$c4,$11,$18,$bf,$3,$0,$2,$4,$6,$8,$a,$c,$b,$9,$7,$5
		dc.b	$3,$7f,$7f,$0,$0,$11,$a,$4,$0,$71,$e,$40,$6f,$0,$0,$0
		dc.b	$18,$0,$10,$0,$80,$0,$18,$0,$4,$0,$3,$0,$0,$0,$6e,$1
		dc.b	$0,$0,$6e,$1,$5,$0,$32,$0,$6c,$9,$c4,$11,$2,$ff,$0,$0
		dc.b	$0,$11,$4,$3,$2,$0,$ff,$0,$0,$0,$0,$0,$24,$0,$10,$1
		dc.b	$40,$0,$24,$0,$4,$0,$4,$0,$0,$0,$5d,$1,$17,$0,$5d,$1
		dc.b	$17,$0,$a3,$b,$1,$0,$1,$1,$0,$5d,$5d,$1,$17,$46,$5d,$ff
		dc.b	$e6,$10,$4,$1,$2,$3,$0,$0,$0,$0,$b,$24,$9e,$fe,$e2,$4
		dc.b	$6,$fe,$e2,$8,$9,$0,$0,$16,$54
		
L2af80_gamedata2:
L2af80:
		dc.w	l2b160-L2af80
		dc.w	l2bcd8-L2af80
		dc.w	l2c0f6-L2af80
		dc.w	l2c20a-L2af80
		dc.w	l2c296-L2af80
		dc.w	l2c320-L2af80
		dc.w	l2c398-L2af80
		dc.w	l2c3e4-L2af80
		dc.w	l2c436-L2af80
		dc.w	l2c474-L2af80
		dc.w	l2c4b2-L2af80
		dc.w	l2c4d6-L2af80
		dc.w	l2c4f4-L2af80
		dc.w	l2c584-L2af80
		ds.b	452
	l2b160:	dc.b	$1,$56,$0,$d6,$8,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$1a
		dc.b	$0,$b,$6,$66,$0,$2,$1a,$0,$1a,$0,$0,$0,$0,$0,$0,$3a
		dc.b	$1,$56,$1,$58,$1,$5e,$1,$64,$1,$80,$1,$82,$1,$94,$1,$9e
		dc.b	$1,$a6,$1,$cc,$1,$f2,$2,$e,$2,$36,$2,$42,$2,$4c,$2,$5a
		dc.b	$2,$64,$2,$a6,$2,$ba,$2,$f2,$3,$38,$3,$74,$3,$c0,$4,$a
		dc.b	$4,$38,$4,$92,$4,$dc,$4,$f2,$4,$f4,$4,$f6,$4,$f8,$4,$fa
		dc.b	$4,$fc,$5,$22,$5,$6a,$5,$c0,$5,$fa,$6,$3a,$6,$7e,$6,$b8
		dc.b	$6,$f4,$7,$34,$7,$48,$7,$84,$7,$c2,$7,$f0,$8,$34,$8,$70
		dc.b	$8,$b2,$8,$f2,$9,$3c,$9,$88,$9,$d8,$a,$a,$a,$44,$a,$72
		dc.b	$a,$b6,$a,$f2,$b,$2a,$b,$62,$b,$64,$b,$6e,$b,$70,$b,$72
		dc.b	$b,$74,$5,$22,$5,$6a,$5,$c0,$5,$fa,$6,$3a,$6,$7e,$6,$b8
		dc.b	$6,$f4,$7,$34,$7,$48,$7,$84,$7,$c2,$7,$f0,$8,$34,$8,$70
		dc.b	$8,$b2,$8,$f2,$9,$3c,$9,$88,$9,$d8,$a,$a,$a,$44,$a,$72
		dc.b	$a,$b6,$a,$f2,$b,$2a,$1,$f6,$3,$0,$1,$f6,$7,$0,$1,$f6
		dc.b	$f,$0,$1,$f6,$13,$0,$1,$f6,$17,$0,$1,$fa,$3,$0,$1,$fa
		dc.b	$7,$0,$1,$fa,$b,$0,$1,$fa,$13,$0,$1,$fe,$7,$0,$1,$fe
		dc.b	$f,$0,$1,$fe,$13,$0,$b,$1,$2,$3,$b,$1,$6,$7,$b,$1
		dc.b	$8,$9,$1,$2,$d,$0,$1,$fb,$d,$0,$1,$fa,$f,$0,$b,$1
		dc.b	$4,$5,$1,$f6,$ff,$0,$b,$1,$0,$6,$1,$fe,$b,$0,$1,$fe
		dc.b	$3,$0,$1,$fe,$17,$0,$1,$fe,$ff,$0,$b,$1,$10,$22,$b,$1
		dc.b	$12,$2a,$b,$1,$0,$1,$c,$1,$1a,$1c,$2,$e6,$0,$0,$1,$f2
		dc.b	$fb,$0,$1,$f2,$17,$0,$6,$20,$46,$9a,$0,$2,$d,$a0,$88,$9a
		dc.b	$0,$2,$d,$a0,$66,$4,$3e,$3d,$3f,$3c,$0,$2,$0,$5,$e,$2
		dc.b	$4,$2,$0,$7,$6,$1,$6,$4,$6,$2f,$6,$31,$0,$0,$7,$20
		dc.b	$6,$20,$11,$4,$2d,$14,$15,$2c,$0,$2,$11,$4,$d,$e,$f,$c
		dc.b	$0,$2,$7,$20,$fe,$4,$28,$29,$9,$26,$0,$2,$7,$20,$11,$3
		dc.b	$1,$3,$b,$0,$6,$20,$0,$2c,$5,$8c,$9,$20,$0,$ac,$2,$26
		dc.b	$11,$2,$c,$2d,$11,$2,$2d,$3,$9,$20,$11,$5,$c,$0,$2,$4
		dc.b	$4,$0,$1,$5,$8,$d,$c,$4,$0,$0,$9,$20,$0,$2c,$5,$8c
		dc.b	$9,$20,$0,$ac,$2,$26,$11,$2,$a,$13,$11,$2,$13,$1,$9,$20
		dc.b	$11,$5,$c,$0,$2,$0,$0,$4,$5,$1,$8,$f,$e,$0,$0,$0
		dc.b	$9,$20,$0,$2c,$4,$4c,$6,$a0,$66,$5,$10,$2,$4,$a,$0,$10
		dc.b	$6,$29,$a,$0,$4,$b,$0,$11,$6,$28,$0,$0,$6,$a0,$60,$4
		dc.b	$3d,$3e,$3f,$3c,$0,$2,$88,$84,$27,$6,$7,$26,$0,$2,$0,$2c
		dc.b	$3,$52,$7,$20,$0,$4,$2d,$14,$15,$2c,$0,$2,$0,$4,$d,$e
		dc.b	$f,$c,$0,$2,$7,$20,$0,$6b,$2,$58,$11,$3,$0,$a,$c,$0
		dc.b	$6,$20,$11,$4,$14,$2d,$15,$2c,$0,$0,$9,$20,$0,$8b,$2,$58
		dc.b	$11,$4,$2,$a,$c,$0,$0,$0,$6,$20,$11,$4,$2,$29,$5,$0
		dc.b	$0,$0,$9,$20,$0,$ac,$4,$b0,$11,$4,$4,$3,$5,$2,$0,$0
		dc.b	$6,$a0,$1,$2c,$2,$b2,$11,$2,$2d,$e,$11,$2,$e,$15,$11,$2
		dc.b	$15,$29,$11,$2,$29,$2d,$6,$a0,$11,$5,$18,$0,$2,$28,$28,$26
		dc.b	$27,$29,$8,$9,$8,$28,$a,$0,$2,$e,$e,$a,$b,$f,$8,$11
		dc.b	$10,$e,$0,$0,$6,$a0,$0,$6c,$2,$30,$11,$2,$1,$0,$6,$20
		dc.b	$11,$4,$2,$1,$3,$0,$0,$0,$6,$20,$0,$8c,$4,$b0,$11,$3
		dc.b	$0,$6,$29,$0,$6,$a0,$0,$ec,$2,$8a,$11,$2,$1,$5,$11,$2
		dc.b	$5,$a,$11,$2,$a,$22,$6,$a0,$11,$5,$14,$0,$4,$0,$0,$6
		dc.b	$6,$10,$6,$e,$8,$1c,$9,$1,$6,$b,$8,$23,$17,$a,$0,$0
		dc.b	$6,$a0,$0,$ac,$4,$7e,$11,$4,$22,$1,$23,$0,$0,$0,$6,$a0
		dc.b	$1,$2c,$2,$62,$11,$2,$1,$5,$11,$2,$5,$22,$11,$2,$22,$a
		dc.b	$11,$2,$2d,$15,$6,$a0,$11,$5,$1c,$0,$2,$a,$a,$22,$14,$2c
		dc.b	$6,$2d,$8,$15,$23,$b,$6,$1,$6,$29,$8,$7,$17,$24,$8,$16
		dc.b	$6,$28,$6,$0,$0,$0,$6,$a0,$0,$8c,$4,$a0,$11,$3,$a,$10
		dc.b	$5,$0,$9,$20,$0,$ec,$2,$5c,$11,$2,$28,$2b,$11,$2,$2a,$2c
		dc.b	$11,$2,$29,$2c,$9,$20,$11,$5,$18,$0,$4,$4,$0,$28,$6,$e
		dc.b	$6,$a,$6,$2c,$6,$29,$6,$5,$6,$12,$6,$2a,$6,$2b,$6,$15
		dc.b	$0,$0,$9,$20,$0,$ac,$4,$c4,$11,$4,$22,$1,$7,$0,$0,$0
		dc.b	$6,$a0,$1,$6c,$2,$6c,$11,$2,$2d,$1,$11,$2,$1,$5,$11,$2
		dc.b	$15,$22,$11,$2,$22,$a,$11,$2,$2d,$15,$6,$a0,$11,$5,$1e,$0
		dc.b	$4,$0,$0,$28,$8,$8,$2f,$2b,$6,$13,$6,$d,$6,$11,$6,$7
		dc.b	$6,$1,$6,$2c,$6,$2a,$8,$14,$22,$e,$6,$a,$0,$0,$6,$a0
		dc.b	$0,$8c,$4,$6a,$11,$3,$0,$4,$5,$0,$6,$a0,$1,$6c,$2,$62
		dc.b	$11,$2,$a,$2d,$11,$2,$2d,$5,$11,$2,$15,$22,$11,$2,$22,$a
		dc.b	$11,$2,$2d,$15,$6,$a0,$11,$5,$1e,$0,$4,$7,$0,$11,$6,$23
		dc.b	$8,$d,$13,$13,$6,$2b,$8,$2f,$8,$28,$8,$26,$27,$29,$a,$0
		dc.b	$2,$12,$12,$2,$2e,$2a,$0,$0,$6,$a0,$0,$8c,$5,$28,$11,$3
		dc.b	$1,$7,$2,$0,$6,$a0,$0,$ac,$2,$3a,$11,$2,$1,$5,$11,$2
		dc.b	$5,$a,$6,$a0,$11,$5,$e,$0,$4,$0,$0,$f,$6,$b,$6,$1
		dc.b	$6,$7,$6,$2,$0,$0,$6,$a0,$0,$ac,$4,$9c,$11,$4,$36,$1a
		dc.b	$28,$29,$0,$0,$e,$20,$1,$6c,$2,$58,$11,$2,$a,$1,$11,$2
		dc.b	$1,$5,$11,$2,$5,$22,$11,$2,$22,$a,$11,$2,$2d,$15,$e,$20
		dc.b	$11,$5,$2c,$0,$2,$28,$28,$26,$30,$36,$8,$31,$27,$29,$8,$9
		dc.b	$2f,$1a,$8,$2e,$8,$28,$a,$0,$2,$f,$f,$11,$17,$2b,$8,$2d
		dc.b	$b,$f,$a,$0,$2,$e,$e,$10,$16,$2a,$8,$2c,$a,$e,$0,$0
		dc.b	$e,$20,$0,$8c,$4,$7e,$11,$3,$1,$7,$2,$0,$6,$a0,$1,$6c
		dc.b	$2,$76,$11,$2,$2d,$1,$11,$2,$1,$5,$11,$2,$5,$15,$11,$2
		dc.b	$a,$15,$11,$2,$2d,$15,$6,$a0,$11,$5,$1e,$0,$4,$0,$0,$a
		dc.b	$6,$c,$8,$22,$14,$14,$6,$2a,$8,$30,$27,$29,$8,$9,$8,$28
		dc.b	$a,$0,$2,$15,$15,$5,$31,$2b,$0,$0,$6,$a0,$1,$b,$4,$56
		dc.b	$11,$4,$28,$a,$e,$0,$0,$0,$11,$4,$2b,$b,$f,$2d,$0,$0
		dc.b	$9,$20,$6,$20,$6,$20,$6,$20,$6,$20,$6,$20,$86,$25,$e,$2
		dc.b	$2,$f,$f,$2b,$13,$12,$6,$2c,$8,$2d,$13,$d,$0,$0,$82,$25
		dc.b	$e,$2,$2,$15,$15,$14,$2a,$e,$6,$c,$8,$12,$2a,$2b,$0,$0
		dc.b	$6,$a0,$0,$8c,$4,$e2,$11,$3,$0,$3,$4,$0,$6,$a0,$1,$2c
		dc.b	$2,$7a,$11,$2,$a,$1,$11,$2,$1,$5,$11,$2,$5,$22,$11,$2
		dc.b	$2d,$15,$6,$a0,$11,$5,$20,$0,$4,$0,$0,$2,$6,$c,$6,$22
		dc.b	$6,$4,$6,$6,$6,$16,$8,$7,$5,$29,$8,$3,$1,$2c,$a,$0
		dc.b	$2,$12,$12,$3,$5,$14,$0,$0,$6,$a0,$0,$ac,$5,$28,$11,$4
		dc.b	$4,$1,$5,$0,$0,$0,$6,$a0,$1,$6c,$2,$6c,$11,$2,$a,$1
		dc.b	$11,$2,$1,$5,$11,$2,$5,$22,$11,$2,$22,$a,$11,$2,$2d,$15
		dc.b	$6,$a0,$11,$5,$28,$0,$2,$29,$29,$7,$1a,$24,$8,$1a,$6,$28
		dc.b	$6,$0,$6,$1,$a,$0,$2,$f,$f,$23,$15,$2b,$6,$13,$6,$d
		dc.b	$a,$0,$2,$e,$e,$22,$14,$2a,$6,$12,$6,$c,$0,$0,$6,$a0
		dc.b	$0,$8c,$5,$40,$11,$3,$36,$29,$28,$0,$9,$20,$0,$ec,$2,$6c
		dc.b	$11,$2,$5,$b,$11,$2,$b,$2c,$11,$2,$2c,$22,$9,$20,$11,$5
		dc.b	$16,$0,$2,$3,$3,$27,$26,$2,$6,$4,$6,$22,$6,$e,$8,$a
		dc.b	$b,$f,$6,$23,$6,$5,$0,$0,$9,$20,$0,$8c,$5,$46,$11,$3
		dc.b	$0,$1,$1a,$0,$6,$a0,$1,$2c,$2,$76,$11,$2,$1,$a,$11,$2
		dc.b	$a,$14,$11,$2,$14,$23,$11,$2,$23,$1,$6,$a0,$11,$5,$18,$0
		dc.b	$2,$29,$29,$9,$8,$28,$6,$0,$6,$1,$a,$0,$2,$f,$f,$11
		dc.b	$10,$e,$6,$c,$6,$d,$0,$0,$6,$a0,$0,$ac,$5,$14,$11,$4
		dc.b	$4,$1,$5,$0,$0,$0,$6,$a0,$1,$2c,$2,$6c,$11,$2,$a,$1
		dc.b	$11,$2,$1,$5,$11,$2,$22,$a,$11,$2,$2d,$15,$6,$a0,$11,$5
		dc.b	$1a,$0,$4,$0,$0,$1,$6,$7,$6,$11,$6,$d,$6,$13,$6,$15
		dc.b	$6,$14,$6,$12,$6,$c,$6,$10,$6,$6,$0,$0,$6,$a0,$0,$8c
		dc.b	$4,$e2,$11,$3,$0,$1,$7,$0,$6,$a0,$0,$ec,$2,$66,$11,$2
		dc.b	$a,$1,$11,$2,$1,$5,$11,$2,$2d,$15,$6,$a0,$11,$5,$16,$0
		dc.b	$4,$0,$0,$1,$6,$7,$6,$11,$6,$d,$6,$13,$6,$15,$6,$14
		dc.b	$6,$12,$6,$2,$0,$0,$6,$a0,$0,$8c,$5,$14,$11,$3,$36,$29
		dc.b	$28,$0,$9,$20,$0,$ec,$2,$8e,$11,$2,$5,$b,$11,$2,$b,$2c
		dc.b	$11,$2,$2c,$22,$9,$20,$11,$5,$18,$0,$2,$3,$3,$27,$26,$2
		dc.b	$6,$4,$6,$14,$6,$2a,$6,$e,$8,$a,$b,$f,$6,$23,$6,$5
		dc.b	$0,$0,$9,$20,$0,$ac,$5,$3c,$11,$4,$6,$1,$7,$0,$0,$0
		dc.b	$6,$a0,$0,$ec,$2,$7a,$11,$2,$a,$1,$11,$2,$5,$22,$11,$2
		dc.b	$2d,$15,$6,$a0,$11,$5,$1a,$0,$4,$0,$0,$1,$6,$3,$6,$13
		dc.b	$6,$15,$6,$5,$6,$7,$6,$6,$6,$4,$6,$14,$6,$12,$6,$2
		dc.b	$0,$0,$6,$a0,$0,$6c,$2,$30,$11,$2,$1,$0,$6,$20,$11,$4
		dc.b	$2,$1,$3,$0,$0,$0,$6,$20,$0,$8c,$4,$7e,$11,$3,$1,$7
		dc.b	$2,$0,$6,$a0,$0,$ec,$2,$8a,$11,$2,$1,$5,$11,$2,$c,$3
		dc.b	$11,$2,$a,$c,$6,$a0,$11,$5,$18,$0,$2,$2,$2,$4,$4,$23
		dc.b	$6,$11,$6,$7,$6,$1,$6,$b,$6,$f,$8,$e,$e,$a,$6,$0
		dc.b	$0,$0,$6,$a0,$0,$ac,$5,$0,$11,$4,$4,$1,$23,$0,$0,$0
		dc.b	$6,$a0,$0,$ec,$2,$5c,$11,$2,$1,$0,$11,$2,$22,$2d,$11,$2
		dc.b	$5,$2d,$6,$a0,$11,$5,$18,$0,$4,$0,$0,$1,$6,$3,$6,$18
		dc.b	$6,$7,$6,$11,$6,$2a,$6,$6,$6,$4,$6,$12,$6,$2,$0,$0
		dc.b	$6,$a0,$0,$8c,$5,$46,$11,$3,$a,$1,$22,$0,$9,$20,$0,$ac
		dc.b	$2,$58,$11,$2,$a,$1,$11,$2,$22,$a,$9,$20,$11,$5,$e,$0
		dc.b	$4,$0,$0,$1,$6,$3,$6,$c,$6,$22,$6,$4,$0,$0,$9,$20
		dc.b	$0,$ac,$5,$6e,$11,$4,$8,$3,$7,$0,$0,$0,$7,$20,$1,$2c
		dc.b	$2,$62,$11,$2,$1,$0,$11,$2,$1,$1e,$11,$2,$1e,$7,$11,$2
		dc.b	$7,$6,$7,$20,$11,$5,$1a,$0,$4,$0,$0,$1,$6,$3,$6,$1e
		dc.b	$6,$7,$6,$9,$6,$8,$6,$6,$6,$17,$6,$20,$6,$13,$6,$2
		dc.b	$0,$0,$7,$20,$0,$ac,$5,$2c,$11,$4,$6,$1,$7,$0,$0,$0
		dc.b	$6,$a0,$0,$ec,$2,$44,$11,$2,$a,$1,$11,$2,$5,$22,$11,$2
		dc.b	$1,$22,$6,$a0,$11,$5,$16,$0,$4,$0,$0,$1,$6,$3,$6,$14
		dc.b	$6,$5,$6,$7,$6,$6,$6,$4,$6,$13,$6,$2,$0,$0,$6,$a0
		dc.b	$0,$ac,$4,$b0,$11,$4,$4,$3,$5,$2,$0,$0,$6,$a0,$1,$2c
		dc.b	$2,$b2,$11,$2,$2d,$e,$11,$2,$e,$15,$11,$2,$15,$29,$11,$2
		dc.b	$29,$2d,$6,$a0,$11,$5,$18,$0,$2,$28,$28,$26,$27,$29,$8,$9
		dc.b	$8,$28,$a,$0,$2,$e,$e,$a,$b,$f,$8,$11,$10,$e,$0,$0
		dc.b	$6,$a0,$0,$8c,$4,$50,$11,$3,$0,$1,$11,$0,$6,$a0,$1,$2c
		dc.b	$2,$4e,$11,$2,$a,$1,$11,$2,$1,$5,$11,$2,$5,$15,$11,$2
		dc.b	$2d,$15,$6,$a0,$11,$5,$18,$0,$2,$29,$29,$9,$2e,$2a,$6,$12
		dc.b	$6,$2,$6,$0,$6,$1,$a,$0,$2,$d,$d,$11,$17,$13,$0,$0
		dc.b	$6,$a0,$0,$ac,$4,$7e,$11,$4,$4,$3,$5,$2,$0,$0,$6,$a0
		dc.b	$1,$2c,$2,$bc,$11,$2,$2d,$e,$11,$2,$e,$15,$11,$2,$15,$29
		dc.b	$11,$2,$29,$2d,$6,$a0,$11,$5,$20,$0,$2,$28,$28,$26,$27,$29
		dc.b	$8,$9,$16,$16,$6,$32,$6,$6,$a,$0,$2,$e,$e,$a,$b,$f
		dc.b	$8,$11,$24,$24,$6,$2a,$6,$20,$0,$0,$6,$a0,$0,$8c,$4,$a6
		dc.b	$11,$3,$0,$1,$11,$0,$6,$a0,$1,$6c,$2,$4e,$11,$2,$a,$1
		dc.b	$11,$2,$1,$5,$11,$2,$5,$15,$11,$2,$2d,$15,$11,$2,$22,$2d
		dc.b	$6,$a0,$11,$5,$20,$0,$2,$29,$29,$9,$2e,$2a,$6,$6,$6,$4
		dc.b	$6,$12,$6,$2,$6,$0,$6,$1,$a,$0,$2,$f,$f,$11,$17,$2b
		dc.b	$6,$13,$6,$d,$0,$0,$6,$a0,$0,$ac,$4,$fa,$11,$4,$10,$b
		dc.b	$7,$0,$0,$0,$6,$a0,$1,$6c,$2,$48,$11,$2,$2d,$1,$11,$2
		dc.b	$1,$5,$11,$2,$15,$22,$11,$2,$22,$a,$11,$2,$2d,$15,$6,$a0
		dc.b	$11,$5,$22,$0,$4,$0,$0,$4,$8,$8,$2f,$15,$6,$13,$8,$2d
		dc.b	$b,$d,$6,$11,$6,$7,$6,$3,$8,$27,$30,$12,$6,$14,$8,$16
		dc.b	$10,$22,$6,$a,$0,$0,$6,$a0,$0,$8c,$4,$4c,$11,$3,$2,$1
		dc.b	$5,$0,$9,$20,$0,$ac,$2,$4e,$11,$2,$1,$5,$11,$2,$c,$3
		dc.b	$9,$20,$11,$5,$12,$0,$4,$2,$0,$d,$6,$b,$6,$1,$6,$5
		dc.b	$6,$23,$6,$f,$6,$28,$0,$0,$9,$20,$0,$ac,$4,$96,$11,$4
		dc.b	$4,$3,$5,$2,$0,$0,$6,$a0,$0,$ec,$2,$44,$11,$2,$a,$1
		dc.b	$11,$2,$5,$22,$11,$2,$22,$a,$6,$a0,$11,$5,$14,$0,$2,$1
		dc.b	$1,$0,$0,$28,$6,$6,$6,$7,$6,$5,$6,$22,$8,$c,$c,$3
		dc.b	$0,$0,$6,$a0,$0,$8c,$4,$82,$11,$3,$1,$7,$28,$0,$6,$a0
		dc.b	$0,$ac,$2,$3a,$11,$2,$1,$c,$11,$2,$c,$5,$6,$a0,$11,$5
		dc.b	$e,$0,$4,$1,$0,$28,$6,$7,$6,$5,$6,$2b,$6,$3,$0,$0
		dc.b	$6,$a0,$0,$ac,$4,$b0,$11,$4,$6,$1,$9,$2,$0,$0,$7,$20
		dc.b	$1,$2c,$2,$58,$11,$2,$1,$a,$11,$2,$a,$1e,$11,$2,$1e,$10
		dc.b	$11,$2,$10,$7,$7,$20,$11,$5,$1a,$0,$4,$1,$0,$0,$6,$2
		dc.b	$6,$1f,$6,$6,$6,$8,$6,$9,$6,$7,$6,$16,$6,$21,$6,$12
		dc.b	$6,$3,$0,$0,$7,$20,$0,$ac,$4,$4c,$11,$4,$4,$3,$5,$2
		dc.b	$0,$0,$6,$a0,$0,$ac,$2,$7a,$11,$2,$a,$5,$11,$2,$1,$22
		dc.b	$6,$a0,$11,$5,$1a,$0,$4,$0,$0,$18,$6,$1,$6,$3,$6,$2b
		dc.b	$6,$5,$6,$7,$6,$24,$6,$6,$6,$4,$6,$2a,$6,$2,$0,$0
		dc.b	$6,$a0,$0,$8c,$4,$96,$11,$3,$1,$5,$2,$0,$9,$20,$0,$ec
		dc.b	$2,$4e,$11,$2,$1,$13,$11,$2,$5,$13,$11,$2,$c,$13,$9,$20
		dc.b	$11,$5,$14,$0,$4,$2,$0,$12,$6,$1,$6,$3,$6,$35,$6,$29
		dc.b	$6,$5,$6,$2a,$6,$28,$0,$0,$9,$20,$0,$ac,$5,$14,$11,$4
		dc.b	$4,$3,$5,$2,$0,$0,$6,$a0,$0,$ec,$2,$8a,$11,$2,$1,$5
		dc.b	$11,$2,$5,$a,$11,$2,$a,$22,$6,$a0,$11,$5,$12,$0,$4,$0
		dc.b	$0,$f,$6,$b,$6,$1,$6,$7,$6,$e,$6,$10,$6,$6,$0,$0
		dc.b	$6,$a0,$6,$20,$11,$4,$2e,$2d,$2f,$2c,$0,$0,$7,$20,$6,$20
		dc.b	$6,$20,$6,$a0,$6,$20,$0,$0
	l2bcd8:	dc.b	$1,$6e,$0,$86,$e,$80,$0,$0,$0,$0,$0,$8,$0,$0,$0,$4e
		dc.b	$0,$13,$6,$66,$0,$a,$4e,$20,$4e,$20,$0,$0,$0,$0,$0,$26
		dc.b	$1,$6e,$1,$70,$1,$6e,$1,$6e,$1,$6e,$1,$6e,$1,$6e,$1,$6e
		dc.b	$1,$6e,$1,$6e,$1,$6e,$1,$6e,$1,$6e,$1,$6e,$1,$6e,$1,$6e
		dc.b	$1,$70,$1,$72,$1,$74,$1,$76,$1,$78,$1,$7a,$1,$7c,$1,$7e
		dc.b	$1,$80,$1,$82,$1,$84,$1,$6e,$1,$6e,$1,$6e,$1,$6e,$1,$6e
		dc.b	$1,$6e,$1,$84,$1,$cc,$2,$c,$2,$4c,$2,$84,$2,$b4,$2,$e4
		dc.b	$3,$c,$3,$24,$3,$3c,$3,$70,$3,$9c,$3,$c0,$3,$d4,$3,$e8
		dc.b	$4,$10,$4,$1a,$4,$1c,$1,$11,$e5,$0,$1,$11,$f5,$0,$1,$d
		dc.b	$f5,$0,$1,$d,$e5,$0,$5,$1,$0,$3,$5,$1,$0,$1,$5,$1
		dc.b	$0,$7,$5,$1,$0,$5,$b,$1,$0,$8,$b,$1,$2,$a,$b,$1
		dc.b	$6,$e,$b,$1,$4,$c,$b,$1,$0,$7,$b,$1,$2,$5,$b,$1
		dc.b	$10,$15,$5,$1,$0,$1d,$5,$1,$0,$1b,$5,$1,$0,$19,$1,$0
		dc.b	$3a,$0,$1,$d2,$0,$0,$1,$e1,$27,$0,$1,$e1,$29,$0,$1,$e1
		dc.b	$2a,$0,$1,$e1,$2b,$0,$1,$e1,$2d,$0,$1,$e1,$30,$0,$1,$e1
		dc.b	$34,$0,$1,$e1,$35,$0,$1,$e1,$37,$0,$1,$e1,$38,$0,$1,$0
		dc.b	$27,$0,$1,$0,$13,$0,$1,$b,$f5,$0,$1,$b,$fd,$0,$1,$3
		dc.b	$fd,$0,$1,$3,$f5,$0,$5,$1,$0,$43,$5,$1,$0,$41,$5,$1
		dc.b	$0,$47,$5,$1,$0,$45,$1,$f1,$13,$0,$1,$f,$0,$0,$1,$0
		dc.b	$0,$0,$1,$f,$3,$0,$1,$b,$7,$0,$1,$0,$7,$0,$1,$b
		dc.b	$1,$0,$1,$7,$1,$0,$1,$b,$5,$0,$1,$7,$5,$0,$1,$0
		dc.b	$f,$0,$1,$f,$fd,$0,$1,$b,$f9,$0,$1,$0,$f9,$0,$1,$b
		dc.b	$ff,$0,$1,$7,$ff,$0,$1,$b,$fb,$0,$1,$7,$fb,$0,$a,$20
		dc.b	$14,$20,$a,$a0,$b,$20,$b,$a0,$c,$20,$c,$a0,$d,$20,$d,$a0
		dc.b	$e,$20,$e,$a0,$1,$2c,$3,$c,$11,$2,$0,$a,$11,$2,$7,$d
		dc.b	$0,$4b,$4,$92,$11,$2,$18,$22,$9,$20,$11,$8,$6,$2,$4,$0
		dc.b	$0,$2,$11,$8,$e,$a,$c,$8,$0,$2,$11,$8,$14,$12,$16,$10
		dc.b	$0,$2,$11,$4,$19,$1a,$1b,$18,$0,$2,$11,$4,$1d,$1e,$1f,$1c
		dc.b	$0,$2,$11,$4,$21,$22,$23,$20,$0,$2,$9,$20,$1,$2c,$3,$c
		dc.b	$11,$2,$0,$a,$11,$2,$7,$d,$0,$4b,$4,$92,$11,$2,$1c,$22
		dc.b	$9,$20,$11,$8,$6,$2,$4,$0,$0,$2,$11,$8,$e,$a,$c,$8
		dc.b	$0,$2,$11,$8,$14,$12,$16,$10,$0,$2,$11,$4,$1d,$1e,$1f,$1c
		dc.b	$0,$2,$11,$4,$21,$22,$23,$20,$0,$2,$9,$20,$1,$2c,$3,$c
		dc.b	$11,$2,$0,$12,$11,$2,$7,$17,$0,$4b,$4,$92,$11,$2,$18,$22
		dc.b	$9,$20,$11,$8,$6,$2,$4,$0,$0,$2,$11,$8,$14,$12,$16,$10
		dc.b	$0,$2,$11,$4,$19,$1a,$1b,$18,$0,$2,$11,$4,$1d,$1e,$1f,$1c
		dc.b	$0,$2,$11,$4,$21,$22,$23,$20,$0,$2,$9,$20,$1,$2c,$3,$c
		dc.b	$11,$2,$0,$12,$11,$2,$7,$17,$0,$4b,$4,$92,$11,$2,$1c,$22
		dc.b	$9,$20,$11,$8,$6,$2,$4,$0,$0,$2,$11,$8,$14,$12,$16,$10
		dc.b	$0,$2,$11,$4,$1d,$1e,$1f,$1c,$0,$2,$11,$4,$21,$22,$23,$20
		dc.b	$0,$2,$9,$20,$1,$2c,$3,$c,$11,$2,$0,$12,$11,$2,$7,$17
		dc.b	$0,$4b,$4,$92,$11,$2,$20,$22,$9,$20,$11,$8,$e,$a,$c,$8
		dc.b	$0,$2,$11,$8,$14,$12,$16,$10,$0,$2,$11,$4,$21,$22,$23,$20
		dc.b	$0,$2,$9,$20,$1,$2c,$3,$c,$11,$2,$0,$2,$11,$2,$7,$5
		dc.b	$0,$4b,$4,$92,$11,$2,$1c,$22,$9,$20,$11,$8,$6,$2,$4,$0
		dc.b	$0,$2,$11,$4,$1d,$1e,$1f,$1c,$0,$2,$11,$4,$21,$22,$23,$20
		dc.b	$0,$2,$9,$20,$1,$2c,$3,$c,$11,$2,$0,$2,$11,$2,$7,$5
		dc.b	$0,$4b,$4,$92,$11,$2,$1c,$1e,$9,$20,$11,$8,$6,$2,$4,$0
		dc.b	$0,$2,$11,$4,$1d,$1e,$1f,$1c,$0,$2,$9,$20,$0,$ac,$3,$c
		dc.b	$11,$2,$8,$a,$11,$2,$f,$d,$9,$20,$11,$8,$e,$a,$c,$8
		dc.b	$0,$2,$9,$20,$0,$ac,$3,$c,$0,$4b,$4,$92,$11,$2,$1c,$1e
		dc.b	$9,$20,$11,$4,$1d,$1e,$1f,$1c,$0,$2,$9,$20,$0,$ec,$3,$c
		dc.b	$11,$2,$40,$4a,$0,$4b,$4,$92,$11,$2,$47,$4d,$f,$20,$11,$4
		dc.b	$46,$42,$44,$40,$0,$2,$11,$4,$4e,$4a,$4c,$48,$0,$2,$11,$4
		dc.b	$47,$43,$45,$41,$0,$2,$11,$4,$4f,$4b,$4d,$49,$0,$2,$f,$20
		dc.b	$0,$ec,$3,$c,$11,$2,$48,$4a,$0,$4b,$4,$92,$11,$2,$47,$4d
		dc.b	$f,$20,$11,$4,$4e,$4a,$4c,$48,$0,$2,$11,$4,$47,$43,$45,$41
		dc.b	$0,$2,$11,$4,$4f,$4b,$4d,$49,$0,$2,$f,$20,$0,$ec,$3,$c
		dc.b	$11,$2,$48,$4a,$0,$4b,$4,$92,$11,$2,$47,$45,$f,$20,$11,$4
		dc.b	$4e,$4a,$4c,$48,$0,$2,$11,$4,$47,$43,$45,$41,$0,$2,$f,$20
		dc.b	$0,$6c,$3,$c,$11,$2,$40,$42,$f,$20,$11,$4,$46,$42,$44,$40
		dc.b	$0,$2,$f,$20,$0,$6c,$3,$c,$11,$2,$1c,$1e,$f,$a0,$11,$4
		dc.b	$1d,$1e,$1f,$1c,$0,$2,$f,$a0,$54,$45,$e,$2,$4,$56,$0,$58
		dc.b	$6,$5a,$6,$6a,$6,$68,$6,$66,$0,$0,$10,$2,$52,$54,$11,$4
		dc.b	$60,$5e,$62,$5c,$0,$2,$11,$4,$70,$6e,$72,$6c,$0,$2,$19,$20
		dc.b	$11,$4,$70,$62,$72,$60,$0,$2,$19,$20,$19,$20,$0,$0
	l2c0f6:	dc.b	$1,$10,$0,$10,$10,$0,$1,$10,$0,$4,$0,$9,$0,$0,$0,$7e
		dc.b	$1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
		ds.b	236
		dc.b	$1,$0,$0,$0,$80,$1e,$0,$0
	l2c20a:	dc.b	$0,$38,$0,$10,$1,$80,$0,$28,$0,$14,$0,$7,$0,$0,$0,$6d
		dc.b	$1,$32,$4e,$7,$1,$32,$4e,$f9,$1,$32,$b2,$7,$1,$32,$b2,$f9
		dc.b	$1,$0,$6d,$7,$1,$0,$6d,$f9,$0,$0,$0,$7e,$2,$0,$0,$82
		dc.b	$0,$7f,$0,$0,$0,$42,$6c,$0,$ff,$e6,$88,$85,$c,$2,$4,$0
		dc.b	$0,$4,$6,$5,$6,$1,$6,$8,$0,$0,$88,$85,$c,$4,$4,$2
		dc.b	$0,$6,$6,$7,$6,$3,$6,$a,$0,$0,$88,$88,$4,$2,$6,$0
		dc.b	$0,$6,$88,$88,$8,$2,$a,$0,$0,$8,$0,$8a,$7,$2,$64,$0
		dc.b	$9c,$0,$0,$a,$6,$2,$64,$0,$9c,$1,$0,$8a,$7,$4,$4c,$3
		dc.b	$9c,$0,$0,$a,$6,$4,$4c,$3,$9c,$1,$0,$0
	l2c296:	dc.b	$0,$44,$0,$10,$3,$40,$0,$44,$0,$4,$0,$a,$0,$0,$0,$60
		dc.b	$1,$60,$0,$60,$1,$60,$0,$a0,$1,$20,$0,$60,$1,$20,$0,$a0
		dc.b	$1,$60,$0,$20,$b,$1,$2,$8,$b,$1,$4,$5,$b,$1,$0,$4
		dc.b	$b,$1,$2,$6,$b,$1,$6,$7,$b,$1,$0,$8,$b,$1,$8,$a
		dc.b	$b,$1,$2,$a,$0,$9c,$0,$0,$c0,$1e,$ff,$e6,$1e,$2,$0,$1
		dc.b	$1e,$2,$2,$3,$1e,$2,$8,$9,$1e,$2,$a,$b,$1e,$2,$0,$2
		dc.b	$1e,$2,$4,$6,$1e,$2,$5,$7,$1e,$2,$1,$3,$0,$b,$5,$1
		dc.b	$35,$22,$14,$15,$35,$22,$16,$17,$35,$22,$18,$19,$35,$22,$e,$10
		dc.b	$35,$22,$c,$12,$35,$22,$f,$11,$0,$0
	l2c320:	dc.b	$0,$44,$0,$10,$3,$40,$0,$44,$0,$4,$0,$a,$0,$0,$0,$42
		dc.b	$1,$e5,$8,$0,$1,$0,$0,$e0,$1,$e6,$e6,$f9,$1,$c1,$f7,$1d
		dc.b	$1,$c1,$14,$17,$1,$24,$19,$36,$1,$c1,$e3,$18,$1,$3f,$1a,$14
		dc.b	$1,$da,$6,$d3,$1,$3a,$f7,$de,$1,$3f,$f4,$ed,$1,$c1,$ee,$e5
		dc.b	$1,$f0,$f8,$42,$2,$13,$4,$81,$b0,$a2,$0,$4,$b0,$a2,$e,$a
		dc.b	$b0,$a2,$0,$6,$b0,$a2,$0,$18,$b0,$a2,$6,$c,$b0,$a2,$0,$10
		dc.b	$b0,$a2,$0,$16,$b0,$a2,$14,$12,$0,$b3,$7,$81,$ff,$e6,$70,$a
		dc.b	$9,$0,$52,$2,$40,$0,$0,$0
	l2c398:	dc.b	$0,$28,$0,$10,$1,$80,$0,$28,$0,$4,$0,$9,$0,$0,$0,$7f
		dc.b	$1,$e0,$ef,$5,$1,$48,$33,$ed,$1,$66,$3c,$43,$1,$42,$ae,$2
		dc.b	$1,$7f,$a4,$d,$1,$0,$0,$c0,$1,$13,$4,$81,$b0,$a2,$2,$4
		dc.b	$b0,$a2,$0,$2,$b0,$a2,$0,$6,$b0,$a2,$6,$8,$0,$b3,$7,$81
		dc.b	$ff,$e6,$70,$a,$9,$0,$42,$a,$40,$1,$0,$0
	l2c3e4:	dc.b	$0,$30,$0,$10,$2,$0,$0,$30,$0,$4,$0,$9,$0,$0,$0,$7f
		dc.b	$1,$b3,$c,$25,$1,$e6,$d9,$f5,$1,$5a,$28,$24,$1,$74,$ee,$3c
		dc.b	$1,$55,$cc,$2,$1,$7f,$f6,$f0,$1,$81,$c8,$bc,$1,$4f,$ad,$3e
		dc.b	$1,$d3,$4,$81,$b0,$a2,$0,$2,$b0,$a2,$2,$8,$b0,$a2,$8,$a
		dc.b	$b0,$a2,$a,$6,$b0,$a2,$a,$4,$b0,$a2,$2,$c,$b0,$a2,$8,$e
		dc.b	$0,$0
	l2c436:	dc.b	$0,$24,$0,$10,$1,$40,$0,$24,$0,$4,$0,$9,$0,$0,$0,$7f
		dc.b	$1,$e8,$d9,$e6,$1,$a9,$f0,$99,$1,$6b,$b1,$f,$1,$18,$95,$e2
		dc.b	$1,$7f,$96,$78,$1,$53,$4,$81,$b0,$a2,$0,$2,$b0,$a2,$0,$4
		dc.b	$b0,$a2,$0,$6,$b0,$a2,$4,$6,$b0,$a2,$4,$8,$0,$0
	l2c474:	dc.b	$0,$24,$0,$10,$1,$40,$0,$24,$0,$4,$0,$a,$0,$0,$0,$48
		dc.b	$1,$cb,$0,$fe,$1,$c1,$e4,$1e,$1,$f9,$29,$1,$1,$c1,$cf,$f4
		dc.b	$1,$d5,$b8,$c,$1,$53,$4,$81,$b0,$a2,$0,$2,$b0,$a2,$0,$4
		dc.b	$b0,$a2,$2,$6,$b0,$a2,$2,$8,$b0,$a2,$6,$8,$0,$0
	l2c4b2:	dc.b	$0,$14,$0,$10,$0,$40,$0,$14,$0,$4,$0,$9,$0,$0,$0,$40
		dc.b	$1,$0,$20,$c0,$0,$b3,$7,$81,$ff,$e6,$70,$a,$9,$0,$42,$0
		dc.b	$40,$2,$0,$0
	l2c4d6:	dc.b	$0,$14,$0,$10,$0,$40,$0,$14,$0,$4,$0,$9,$0,$0,$0,$64
		dc.b	$1,$0,$0,$0,$ff,$c6,$1c,$1,$0,$5,$0,$0,$0,$0
	l2c4f4:	dc.b	$0,$44,$0,$10,$3,$40,$0,$44,$0,$4,$0,$c,$0,$0,$0,$3f
		dc.b	$1,$3f,$0,$0,$1,$0,$0,$3f,$1,$3f,$0,$23,$1,$23,$0,$3f
		dc.b	$13,$84,$16,$0,$13,$84,$16,$4,$13,$84,$16,$6,$13,$84,$16,$2
		dc.b	$5,$1,$0,$b,$5,$1,$0,$d,$5,$1,$0,$e,$1,$0,$0,$0
		dc.b	$1,$0,$0,$fc,$ff,$c6,$b0,$b8,$60,$0,$16,$7f,$1,$53,$7,$81
		dc.b	$0,$4c,$0,$22,$b0,$a2,$16,$18,$0,$8b,$0,$22,$b0,$aa,$6,$0
		dc.b	$42,$18,$40,$3,$2,$73,$0,$84,$0,$bc,$0,$0,$c0,$1e,$b0,$b6
		dc.b	$e,$a,$c,$8,$0,$0,$b0,$b6,$9,$d,$b,$e,$0,$0,$b0,$b6
		dc.b	$14,$11,$13,$9,$0,$0,$b0,$b6,$8,$12,$10,$14,$0,$0,$0,$0
	l2c584:	dc.b	$0,$34,$0,$10,$2,$40,$0,$34,$0,$4,$0,$8,$0,$0,$0,$7e
		dc.b	$1,$0,$0,$c,$1,$c,$c,$26,$1,$e7,$e7,$26,$1,$c,$f4,$c
		dc.b	$1,$19,$0,$c,$1,$26,$c,$33,$1,$0,$e7,$f4,$1,$19,$f4,$c
		dc.b	$1,$0,$6,$6,$ff,$c6,$10,$78,$cc,$c,$0,$2,$4,$6,$8,$a
		dc.b	$c,$e,$7f,$7f,$10,$98,$ff,$7,$0,$10,$7f,$7f,$0,$0,$0,$8
		dc.b	$0,$9,$0,$a,$0,$b,$0,$0,$0,$0
		
L2c5de_sine_table:
		dc.b	$0,$0,$0,$32,$0,$64,$0,$96,$0,$c9,$0,$fb,$1,$2d,$1,$5f
		dc.b	$1,$92,$1,$c4,$1,$f6,$2,$28,$2,$5b,$2,$8d,$2,$bf,$2,$f1
		dc.b	$3,$24,$3,$56,$3,$88,$3,$ba,$3,$ed,$4,$1f,$4,$51,$4,$83
		dc.b	$4,$b6,$4,$e8,$5,$1a,$5,$4c,$5,$7e,$5,$b1,$5,$e3,$6,$15
		dc.b	$6,$47,$6,$7a,$6,$ac,$6,$de,$7,$10,$7,$42,$7,$74,$7,$a7
		dc.b	$7,$d9,$8,$b,$8,$3d,$8,$6f,$8,$a1,$8,$d4,$9,$6,$9,$38
		dc.b	$9,$6a,$9,$9c,$9,$ce,$a,$0,$a,$32,$a,$65,$a,$97,$a,$c9
		dc.b	$a,$fb,$b,$2d,$b,$5f,$b,$91,$b,$c3,$b,$f5,$c,$27,$c,$59
		dc.b	$c,$8b,$c,$bd,$c,$ef,$d,$21,$d,$53,$d,$85,$d,$b7,$d,$e9
		dc.b	$e,$1b,$e,$4d,$e,$7f,$e,$b1,$e,$e3,$f,$15,$f,$47,$f,$79
		dc.b	$f,$ab,$f,$dc,$10,$e,$10,$40,$10,$72,$10,$a4,$10,$d6,$11,$7
		dc.b	$11,$39,$11,$6b,$11,$9d,$11,$cf,$12,$0,$12,$32,$12,$64,$12,$96
		dc.b	$12,$c7,$12,$f9,$13,$2b,$13,$5d,$13,$8e,$13,$c0,$13,$f2,$14,$23
		dc.b	$14,$55,$14,$86,$14,$b8,$14,$ea,$15,$1b,$15,$4d,$15,$7e,$15,$b0
		dc.b	$15,$e1,$16,$13,$16,$44,$16,$76,$16,$a7,$16,$d9,$17,$a,$17,$3c
		dc.b	$17,$6d,$17,$9f,$17,$d0,$18,$1,$18,$33,$18,$64,$18,$95,$18,$c7
		dc.b	$18,$f8,$19,$29,$19,$5b,$19,$8c,$19,$bd,$19,$ee,$1a,$20,$1a,$51
		dc.b	$1a,$82,$1a,$b3,$1a,$e4,$1b,$15,$1b,$46,$1b,$78,$1b,$a9,$1b,$da
		dc.b	$1c,$b,$1c,$3c,$1c,$6d,$1c,$9e,$1c,$cf,$1d,$0,$1d,$31,$1d,$62
		dc.b	$1d,$93,$1d,$c3,$1d,$f4,$1e,$25,$1e,$56,$1e,$87,$1e,$b8,$1e,$e8
		dc.b	$1f,$19,$1f,$4a,$1f,$7b,$1f,$ab,$1f,$dc,$20,$d,$20,$3d,$20,$6e
		dc.b	$20,$9f,$20,$cf,$21,$0,$21,$30,$21,$61,$21,$91,$21,$c2,$21,$f2
		dc.b	$22,$23,$22,$53,$22,$84,$22,$b4,$22,$e4,$23,$15,$23,$45,$23,$75
		dc.b	$23,$a6,$23,$d6,$24,$6,$24,$36,$24,$67,$24,$97,$24,$c7,$24,$f7
		dc.b	$25,$27,$25,$57,$25,$87,$25,$b7,$25,$e7,$26,$17,$26,$47,$26,$77
		dc.b	$26,$a7,$26,$d7,$27,$7,$27,$37,$27,$67,$27,$97,$27,$c6,$27,$f6
		dc.b	$28,$26,$28,$56,$28,$85,$28,$b5,$28,$e5,$29,$14,$29,$44,$29,$73
		dc.b	$29,$a3,$29,$d2,$2a,$2,$2a,$31,$2a,$61,$2a,$90,$2a,$c0,$2a,$ef
		dc.b	$2b,$1e,$2b,$4e,$2b,$7d,$2b,$ac,$2b,$db,$2c,$b,$2c,$3a,$2c,$69
		dc.b	$2c,$98,$2c,$c7,$2c,$f6,$2d,$25,$2d,$54,$2d,$83,$2d,$b2,$2d,$e1
		dc.b	$2e,$10,$2e,$3f,$2e,$6e,$2e,$9d,$2e,$cc,$2e,$fa,$2f,$29,$2f,$58
		dc.b	$2f,$86,$2f,$b5,$2f,$e4,$30,$12,$30,$41,$30,$6f,$30,$9e,$30,$cc
		dc.b	$30,$fb,$31,$29,$31,$58,$31,$86,$31,$b4,$31,$e3,$32,$11,$32,$3f
		dc.b	$32,$6d,$32,$9c,$32,$ca,$32,$f8,$33,$26,$33,$54,$33,$82,$33,$b0
		dc.b	$33,$de,$34,$c,$34,$3a,$34,$68,$34,$96,$34,$c3,$34,$f1,$35,$1f
		dc.b	$35,$4d,$35,$7a,$35,$a8,$35,$d6,$36,$3,$36,$31,$36,$5e,$36,$8c
		dc.b	$36,$b9,$36,$e7,$37,$14,$37,$41,$37,$6f,$37,$9c,$37,$c9,$37,$f6
		dc.b	$38,$24,$38,$51,$38,$7e,$38,$ab,$38,$d8,$39,$5,$39,$32,$39,$5f
		dc.b	$39,$8c,$39,$b9,$39,$e6,$3a,$12,$3a,$3f,$3a,$6c,$3a,$99,$3a,$c5
		dc.b	$3a,$f2,$3b,$1f,$3b,$4b,$3b,$78,$3b,$a4,$3b,$d1,$3b,$fd,$3c,$29
		dc.b	$3c,$56,$3c,$82,$3c,$ae,$3c,$db,$3d,$7,$3d,$33,$3d,$5f,$3d,$8b
		dc.b	$3d,$b7,$3d,$e3,$3e,$f,$3e,$3b,$3e,$67,$3e,$93,$3e,$bf,$3e,$eb
		dc.b	$3f,$16,$3f,$42,$3f,$6e,$3f,$99,$3f,$c5,$3f,$f0,$40,$1c,$40,$47
		dc.b	$40,$73,$40,$9e,$40,$ca,$40,$f5,$41,$20,$41,$4c,$41,$77,$41,$a2
		dc.b	$41,$cd,$41,$f8,$42,$23,$42,$4e,$42,$79,$42,$a4,$42,$cf,$42,$fa
		dc.b	$43,$25,$43,$50,$43,$7a,$43,$a5,$43,$d0,$43,$fa,$44,$25,$44,$4f
		dc.b	$44,$7a,$44,$a4,$44,$cf,$44,$f9,$45,$23,$45,$4e,$45,$78,$45,$a2
		dc.b	$45,$cc,$45,$f6,$46,$20,$46,$4a,$46,$74,$46,$9e,$46,$c8,$46,$f2
		dc.b	$47,$1c,$47,$46,$47,$6f,$47,$99,$47,$c3,$47,$ec,$48,$16,$48,$3f
		dc.b	$48,$69,$48,$92,$48,$bc,$48,$e5,$49,$e,$49,$38,$49,$61,$49,$8a
		dc.b	$49,$b3,$49,$dc,$4a,$5,$4a,$2e,$4a,$57,$4a,$80,$4a,$a9,$4a,$d2
		dc.b	$4a,$fa,$4b,$23,$4b,$4c,$4b,$74,$4b,$9d,$4b,$c5,$4b,$ee,$4c,$16
		dc.b	$4c,$3f,$4c,$67,$4c,$8f,$4c,$b8,$4c,$e0,$4d,$8,$4d,$30,$4d,$58
		dc.b	$4d,$80,$4d,$a8,$4d,$d0,$4d,$f8,$4e,$20,$4e,$48,$4e,$6f,$4e,$97
		dc.b	$4e,$bf,$4e,$e6,$4f,$e,$4f,$35,$4f,$5d,$4f,$84,$4f,$ac,$4f,$d3
		dc.b	$4f,$fa,$50,$21,$50,$49,$50,$70,$50,$97,$50,$be,$50,$e5,$51,$c
		dc.b	$51,$33,$51,$59,$51,$80,$51,$a7,$51,$ce,$51,$f4,$52,$1b,$52,$41
		dc.b	$52,$68,$52,$8e,$52,$b5,$52,$db,$53,$1,$53,$28,$53,$4e,$53,$74
		dc.b	$53,$9a,$53,$c0,$53,$e6,$54,$c,$54,$32,$54,$58,$54,$7d,$54,$a3
		dc.b	$54,$c9,$54,$ef,$55,$14,$55,$3a,$55,$5f,$55,$85,$55,$aa,$55,$cf
		dc.b	$55,$f4,$56,$1a,$56,$3f,$56,$64,$56,$89,$56,$ae,$56,$d3,$56,$f8
		dc.b	$57,$1d,$57,$42,$57,$66,$57,$8b,$57,$b0,$57,$d4,$57,$f9,$58,$1d
		dc.b	$58,$42,$58,$66,$58,$8a,$58,$af,$58,$d3,$58,$f7,$59,$1b,$59,$3f
		dc.b	$59,$63,$59,$87,$59,$ab,$59,$cf,$59,$f3,$5a,$16,$5a,$3a,$5a,$5e
		dc.b	$5a,$81,$5a,$a5,$5a,$c8,$5a,$ec,$5b,$f,$5b,$32,$5b,$56,$5b,$79
		dc.b	$5b,$9c,$5b,$bf,$5b,$e2,$5c,$5,$5c,$28,$5c,$4b,$5c,$6d,$5c,$90
		dc.b	$5c,$b3,$5c,$d6,$5c,$f8,$5d,$1b,$5d,$3d,$5d,$5f,$5d,$82,$5d,$a4
		dc.b	$5d,$c6,$5d,$e9,$5e,$b,$5e,$2d,$5e,$4f,$5e,$71,$5e,$93,$5e,$b4
		dc.b	$5e,$d6,$5e,$f8,$5f,$1a,$5f,$3b,$5f,$5d,$5f,$7e,$5f,$a0,$5f,$c1
		dc.b	$5f,$e2,$60,$4,$60,$25,$60,$46,$60,$67,$60,$88,$60,$a9,$60,$ca
		dc.b	$60,$eb,$61,$c,$61,$2d,$61,$4d,$61,$6e,$61,$8e,$61,$af,$61,$cf
		dc.b	$61,$f0,$62,$10,$62,$30,$62,$51,$62,$71,$62,$91,$62,$b1,$62,$d1
		dc.b	$62,$f1,$63,$11,$63,$30,$63,$50,$63,$70,$63,$8f,$63,$af,$63,$ce
		dc.b	$63,$ee,$64,$d,$64,$2d,$64,$4c,$64,$6b,$64,$8a,$64,$a9,$64,$c8
		dc.b	$64,$e7,$65,$6,$65,$25,$65,$44,$65,$62,$65,$81,$65,$a0,$65,$be
		dc.b	$65,$dd,$65,$fb,$66,$19,$66,$38,$66,$56,$66,$74,$66,$92,$66,$b0
		dc.b	$66,$ce,$66,$ec,$67,$a,$67,$28,$67,$45,$67,$63,$67,$81,$67,$9e
		dc.b	$67,$bc,$67,$d9,$67,$f7,$68,$14,$68,$31,$68,$4e,$68,$6b,$68,$88
		dc.b	$68,$a5,$68,$c2,$68,$df,$68,$fc,$69,$19,$69,$35,$69,$52,$69,$6e
		dc.b	$69,$8b,$69,$a7,$69,$c4,$69,$e0,$69,$fc,$6a,$18,$6a,$34,$6a,$50
		dc.b	$6a,$6c,$6a,$88,$6a,$a4,$6a,$c0,$6a,$db,$6a,$f7,$6b,$13,$6b,$2e
		dc.b	$6b,$4a,$6b,$65,$6b,$80,$6b,$9c,$6b,$b7,$6b,$d2,$6b,$ed,$6c,$8
		dc.b	$6c,$23,$6c,$3e,$6c,$58,$6c,$73,$6c,$8e,$6c,$a8,$6c,$c3,$6c,$dd
		dc.b	$6c,$f8,$6d,$12,$6d,$2c,$6d,$47,$6d,$61,$6d,$7b,$6d,$95,$6d,$af
		dc.b	$6d,$c9,$6d,$e3,$6d,$fc,$6e,$16,$6e,$30,$6e,$49,$6e,$63,$6e,$7c
		dc.b	$6e,$95,$6e,$af,$6e,$c8,$6e,$e1,$6e,$fa,$6f,$13,$6f,$2c,$6f,$45
		dc.b	$6f,$5e,$6f,$76,$6f,$8f,$6f,$a8,$6f,$c0,$6f,$d9,$6f,$f1,$70,$9
		dc.b	$70,$22,$70,$3a,$70,$52,$70,$6a,$70,$82,$70,$9a,$70,$b2,$70,$ca
		dc.b	$70,$e1,$70,$f9,$71,$11,$71,$28,$71,$40,$71,$57,$71,$6e,$71,$86
		dc.b	$71,$9d,$71,$b4,$71,$cb,$71,$e2,$71,$f9,$72,$10,$72,$26,$72,$3d
		dc.b	$72,$54,$72,$6a,$72,$81,$72,$97,$72,$ae,$72,$c4,$72,$da,$72,$f0
		dc.b	$73,$6,$73,$1c,$73,$32,$73,$48,$73,$5e,$73,$74,$73,$89,$73,$9f
		dc.b	$73,$b5,$73,$ca,$73,$df,$73,$f5,$74,$a,$74,$1f,$74,$34,$74,$49
		dc.b	$74,$5e,$74,$73,$74,$88,$74,$9d,$74,$b1,$74,$c6,$74,$db,$74,$ef
		dc.b	$75,$3,$75,$18,$75,$2c,$75,$40,$75,$54,$75,$68,$75,$7c,$75,$90
		dc.b	$75,$a4,$75,$b8,$75,$cc,$75,$df,$75,$f3,$76,$6,$76,$1a,$76,$2d
		dc.b	$76,$40,$76,$53,$76,$67,$76,$7a,$76,$8d,$76,$a0,$76,$b2,$76,$c5
		dc.b	$76,$d8,$76,$ea,$76,$fd,$77,$10,$77,$22,$77,$34,$77,$47,$77,$59
		dc.b	$77,$6b,$77,$7d,$77,$8f,$77,$a1,$77,$b3,$77,$c4,$77,$d6,$77,$e8
		dc.b	$77,$f9,$78,$b,$78,$1c,$78,$2e,$78,$3f,$78,$50,$78,$61,$78,$72
		dc.b	$78,$83,$78,$94,$78,$a5,$78,$b6,$78,$c6,$78,$d7,$78,$e7,$78,$f8
		dc.b	$79,$8,$79,$19,$79,$29,$79,$39,$79,$49,$79,$59,$79,$69,$79,$79
		dc.b	$79,$89,$79,$98,$79,$a8,$79,$b8,$79,$c7,$79,$d7,$79,$e6,$79,$f5
		dc.b	$7a,$4,$7a,$14,$7a,$23,$7a,$32,$7a,$41,$7a,$4f,$7a,$5e,$7a,$6d
		dc.b	$7a,$7c,$7a,$8a,$7a,$99,$7a,$a7,$7a,$b5,$7a,$c4,$7a,$d2,$7a,$e0
		dc.b	$7a,$ee,$7a,$fc,$7b,$a,$7b,$18,$7b,$25,$7b,$33,$7b,$41,$7b,$4e
		dc.b	$7b,$5c,$7b,$69,$7b,$76,$7b,$83,$7b,$91,$7b,$9e,$7b,$ab,$7b,$b8
		dc.b	$7b,$c4,$7b,$d1,$7b,$de,$7b,$eb,$7b,$f7,$7c,$4,$7c,$10,$7c,$1c
		dc.b	$7c,$29,$7c,$35,$7c,$41,$7c,$4d,$7c,$59,$7c,$65,$7c,$70,$7c,$7c
		dc.b	$7c,$88,$7c,$93,$7c,$9f,$7c,$aa,$7c,$b6,$7c,$c1,$7c,$cc,$7c,$d7
		dc.b	$7c,$e2,$7c,$ed,$7c,$f8,$7d,$3,$7d,$e,$7d,$18,$7d,$23,$7d,$2e
		dc.b	$7d,$38,$7d,$42,$7d,$4d,$7d,$57,$7d,$61,$7d,$6b,$7d,$75,$7d,$7f
		dc.b	$7d,$89,$7d,$93,$7d,$9c,$7d,$a6,$7d,$b0,$7d,$b9,$7d,$c2,$7d,$cc
		dc.b	$7d,$d5,$7d,$de,$7d,$e7,$7d,$f0,$7d,$f9,$7e,$2,$7e,$b,$7e,$13
		dc.b	$7e,$1c,$7e,$25,$7e,$2d,$7e,$36,$7e,$3e,$7e,$46,$7e,$4e,$7e,$56
		dc.b	$7e,$5e,$7e,$66,$7e,$6e,$7e,$76,$7e,$7e,$7e,$85,$7e,$8d,$7e,$94
		dc.b	$7e,$9c,$7e,$a3,$7e,$aa,$7e,$b2,$7e,$b9,$7e,$c0,$7e,$c7,$7e,$ce
		dc.b	$7e,$d4,$7e,$db,$7e,$e2,$7e,$e8,$7e,$ef,$7e,$f5,$7e,$fc,$7f,$2
		dc.b	$7f,$8,$7f,$e,$7f,$14,$7f,$1a,$7f,$20,$7f,$26,$7f,$2c,$7f,$31
		dc.b	$7f,$37,$7f,$3c,$7f,$42,$7f,$47,$7f,$4c,$7f,$52,$7f,$57,$7f,$5c
		dc.b	$7f,$61,$7f,$66,$7f,$6a,$7f,$6f,$7f,$74,$7f,$78,$7f,$7d,$7f,$81
		dc.b	$7f,$86,$7f,$8a,$7f,$8e,$7f,$92,$7f,$96,$7f,$9a,$7f,$9e,$7f,$a2
		dc.b	$7f,$a6,$7f,$a9,$7f,$ad,$7f,$b0,$7f,$b4,$7f,$b7,$7f,$bb,$7f,$be
		dc.b	$7f,$c1,$7f,$c4,$7f,$c7,$7f,$ca,$7f,$cd,$7f,$cf,$7f,$d2,$7f,$d5
		dc.b	$7f,$d7,$7f,$d9,$7f,$dc,$7f,$de,$7f,$e0,$7f,$e2,$7f,$e4,$7f,$e6
		dc.b	$7f,$e8,$7f,$ea,$7f,$ec,$7f,$ee,$7f,$ef,$7f,$f1,$7f,$f2,$7f,$f3
		dc.b	$7f,$f5,$7f,$f6,$7f,$f7,$7f,$f8,$7f,$f9,$7f,$fa,$7f,$fb,$7f,$fb
		dc.b	$7f,$fc,$7f,$fd,$7f,$fd,$7f,$fe,$7f,$fe,$7f,$fe,$7f,$fe,$7f,$fe
		dc.b	$7f,$fe,$7f,$fe,$7f,$fe,$7f,$fe,$7f,$fe,$7f,$fe,$7f,$fd,$7f,$fd
		dc.b	$7f,$fc,$7f,$fb,$7f,$fb,$7f,$fa,$7f,$f9,$7f,$f8,$7f,$f7,$7f,$f6
		dc.b	$7f,$f5,$7f,$f3,$7f,$f2,$7f,$f1,$7f,$ef,$7f,$ee,$7f,$ec,$7f,$ea
		dc.b	$7f,$e8,$7f,$e6,$7f,$e4,$7f,$e2,$7f,$e0,$7f,$de,$7f,$dc,$7f,$d9
		dc.b	$7f,$d7,$7f,$d5,$7f,$d2,$7f,$cf,$7f,$cd,$7f,$ca,$7f,$c7,$7f,$c4
		dc.b	$7f,$c1,$7f,$be,$7f,$bb,$7f,$b7,$7f,$b4,$7f,$b0,$7f,$ad,$7f,$a9
		dc.b	$7f,$a6,$7f,$a2,$7f,$9e,$7f,$9a,$7f,$96,$7f,$92,$7f,$8e,$7f,$8a
		dc.b	$7f,$86,$7f,$81,$7f,$7d,$7f,$78,$7f,$74,$7f,$6f,$7f,$6a,$7f,$66
		dc.b	$7f,$61,$7f,$5c,$7f,$57,$7f,$52,$7f,$4c,$7f,$47,$7f,$42,$7f,$3c
		dc.b	$7f,$37,$7f,$31,$7f,$2c,$7f,$26,$7f,$20,$7f,$1a,$7f,$14,$7f,$e
		dc.b	$7f,$8,$7f,$2,$7e,$fc,$7e,$f5,$7e,$ef,$7e,$e8,$7e,$e2,$7e,$db
		dc.b	$7e,$d4,$7e,$ce,$7e,$c7,$7e,$c0,$7e,$b9,$7e,$b2,$7e,$aa,$7e,$a3
		dc.b	$7e,$9c,$7e,$94,$7e,$8d,$7e,$85,$7e,$7e,$7e,$76,$7e,$6e,$7e,$66
		dc.b	$7e,$5e,$7e,$56,$7e,$4e,$7e,$46,$7e,$3e,$7e,$36,$7e,$2d,$7e,$25
		dc.b	$7e,$1c,$7e,$13,$7e,$b,$7e,$2,$7d,$f9,$7d,$f0,$7d,$e7,$7d,$de
		dc.b	$7d,$d5,$7d,$cc,$7d,$c2,$7d,$b9,$7d,$b0,$7d,$a6,$7d,$9c,$7d,$93
		dc.b	$7d,$89,$7d,$7f,$7d,$75,$7d,$6b,$7d,$61,$7d,$57,$7d,$4d,$7d,$42
		dc.b	$7d,$38,$7d,$2e,$7d,$23,$7d,$18,$7d,$e,$7d,$3,$7c,$f8,$7c,$ed
		dc.b	$7c,$e2,$7c,$d7,$7c,$cc,$7c,$c1,$7c,$b6,$7c,$aa,$7c,$9f,$7c,$93
		dc.b	$7c,$88,$7c,$7c,$7c,$70,$7c,$65,$7c,$59,$7c,$4d,$7c,$41,$7c,$35
		dc.b	$7c,$29,$7c,$1c,$7c,$10,$7c,$4,$7b,$f7,$7b,$eb,$7b,$de,$7b,$d1
		dc.b	$7b,$c4,$7b,$b8,$7b,$ab,$7b,$9e,$7b,$91,$7b,$83,$7b,$76,$7b,$69
		dc.b	$7b,$5c,$7b,$4e,$7b,$41,$7b,$33,$7b,$25,$7b,$18,$7b,$a,$7a,$fc
		dc.b	$7a,$ee,$7a,$e0,$7a,$d2,$7a,$c4,$7a,$b5,$7a,$a7,$7a,$99,$7a,$8a
		dc.b	$7a,$7c,$7a,$6d,$7a,$5e,$7a,$4f,$7a,$41,$7a,$32,$7a,$23,$7a,$14
		dc.b	$7a,$4,$79,$f5,$79,$e6,$79,$d7,$79,$c7,$79,$b8,$79,$a8,$79,$98
		dc.b	$79,$89,$79,$79,$79,$69,$79,$59,$79,$49,$79,$39,$79,$29,$79,$19
		dc.b	$79,$8,$78,$f8,$78,$e7,$78,$d7,$78,$c6,$78,$b6,$78,$a5,$78,$94
		dc.b	$78,$83,$78,$72,$78,$61,$78,$50,$78,$3f,$78,$2e,$78,$1c,$78,$b
		dc.b	$77,$f9,$77,$e8,$77,$d6,$77,$c4,$77,$b3,$77,$a1,$77,$8f,$77,$7d
		dc.b	$77,$6b,$77,$59,$77,$47,$77,$34,$77,$22,$77,$10,$76,$fd,$76,$ea
		dc.b	$76,$d8,$76,$c5,$76,$b2,$76,$a0,$76,$8d,$76,$7a,$76,$67,$76,$53
		dc.b	$76,$40,$76,$2d,$76,$1a,$76,$6,$75,$f3,$75,$df,$75,$cc,$75,$b8
		dc.b	$75,$a4,$75,$90,$75,$7c,$75,$68,$75,$54,$75,$40,$75,$2c,$75,$18
		dc.b	$75,$3,$74,$ef,$74,$db,$74,$c6,$74,$b1,$74,$9d,$74,$88,$74,$73
		dc.b	$74,$5e,$74,$49,$74,$34,$74,$1f,$74,$a,$73,$f5,$73,$df,$73,$ca
		dc.b	$73,$b5,$73,$9f,$73,$89,$73,$74,$73,$5e,$73,$48,$73,$32,$73,$1c
		dc.b	$73,$6,$72,$f0,$72,$da,$72,$c4,$72,$ae,$72,$97,$72,$81,$72,$6a
		dc.b	$72,$54,$72,$3d,$72,$26,$72,$10,$71,$f9,$71,$e2,$71,$cb,$71,$b4
		dc.b	$71,$9d,$71,$86,$71,$6e,$71,$57,$71,$40,$71,$28,$71,$11,$70,$f9
		dc.b	$70,$e1,$70,$ca,$70,$b2,$70,$9a,$70,$82,$70,$6a,$70,$52,$70,$3a
		dc.b	$70,$22,$70,$9,$6f,$f1,$6f,$d9,$6f,$c0,$6f,$a8,$6f,$8f,$6f,$76
		dc.b	$6f,$5e,$6f,$45,$6f,$2c,$6f,$13,$6e,$fa,$6e,$e1,$6e,$c8,$6e,$af
		dc.b	$6e,$95,$6e,$7c,$6e,$63,$6e,$49,$6e,$30,$6e,$16,$6d,$fc,$6d,$e3
		dc.b	$6d,$c9,$6d,$af,$6d,$95,$6d,$7b,$6d,$61,$6d,$47,$6d,$2c,$6d,$12
		dc.b	$6c,$f8,$6c,$dd,$6c,$c3,$6c,$a8,$6c,$8e,$6c,$73,$6c,$58,$6c,$3e
		dc.b	$6c,$23,$6c,$8,$6b,$ed,$6b,$d2,$6b,$b7,$6b,$9c,$6b,$80,$6b,$65
		dc.b	$6b,$4a,$6b,$2e,$6b,$13,$6a,$f7,$6a,$db,$6a,$c0,$6a,$a4,$6a,$88
		dc.b	$6a,$6c,$6a,$50,$6a,$34,$6a,$18,$69,$fc,$69,$e0,$69,$c4,$69,$a7
		dc.b	$69,$8b,$69,$6e,$69,$52,$69,$35,$69,$19,$68,$fc,$68,$df,$68,$c2
		dc.b	$68,$a5,$68,$88,$68,$6b,$68,$4e,$68,$31,$68,$14,$67,$f7,$67,$d9
		dc.b	$67,$bc,$67,$9e,$67,$81,$67,$63,$67,$45,$67,$28,$67,$a,$66,$ec
		dc.b	$66,$ce,$66,$b0,$66,$92,$66,$74,$66,$56,$66,$38,$66,$19,$65,$fb
		dc.b	$65,$dd,$65,$be,$65,$a0,$65,$81,$65,$62,$65,$44,$65,$25,$65,$6
		dc.b	$64,$e7,$64,$c8,$64,$a9,$64,$8a,$64,$6b,$64,$4c,$64,$2d,$64,$d
		dc.b	$63,$ee,$63,$ce,$63,$af,$63,$8f,$63,$70,$63,$50,$63,$30,$63,$11
		dc.b	$62,$f1,$62,$d1,$62,$b1,$62,$91,$62,$71,$62,$51,$62,$30,$62,$10
		dc.b	$61,$f0,$61,$cf,$61,$af,$61,$8e,$61,$6e,$61,$4d,$61,$2d,$61,$c
		dc.b	$60,$eb,$60,$ca,$60,$a9,$60,$88,$60,$67,$60,$46,$60,$25,$60,$4
		dc.b	$5f,$e2,$5f,$c1,$5f,$a0,$5f,$7e,$5f,$5d,$5f,$3b,$5f,$1a,$5e,$f8
		dc.b	$5e,$d6,$5e,$b4,$5e,$93,$5e,$71,$5e,$4f,$5e,$2d,$5e,$b,$5d,$e9
		dc.b	$5d,$c6,$5d,$a4,$5d,$82,$5d,$5f,$5d,$3d,$5d,$1b,$5c,$f8,$5c,$d6
		dc.b	$5c,$b3,$5c,$90,$5c,$6d,$5c,$4b,$5c,$28,$5c,$5,$5b,$e2,$5b,$bf
		dc.b	$5b,$9c,$5b,$79,$5b,$56,$5b,$32,$5b,$f,$5a,$ec,$5a,$c8,$5a,$a5
		dc.b	$5a,$81,$5a,$5e,$5a,$3a,$5a,$16,$59,$f3,$59,$cf,$59,$ab,$59,$87
		dc.b	$59,$63,$59,$3f,$59,$1b,$58,$f7,$58,$d3,$58,$af,$58,$8a,$58,$66
		dc.b	$58,$42,$58,$1d,$57,$f9,$57,$d4,$57,$b0,$57,$8b,$57,$66,$57,$42
		dc.b	$57,$1d,$56,$f8,$56,$d3,$56,$ae,$56,$89,$56,$64,$56,$3f,$56,$1a
		dc.b	$55,$f4,$55,$cf,$55,$aa,$55,$85,$55,$5f,$55,$3a,$55,$14,$54,$ef
		dc.b	$54,$c9,$54,$a3,$54,$7d,$54,$58,$54,$32,$54,$c,$53,$e6,$53,$c0
		dc.b	$53,$9a,$53,$74,$53,$4e,$53,$28,$53,$1,$52,$db,$52,$b5,$52,$8e
		dc.b	$52,$68,$52,$41,$52,$1b,$51,$f4,$51,$ce,$51,$a7,$51,$80,$51,$59
		dc.b	$51,$33,$51,$c,$50,$e5,$50,$be,$50,$97,$50,$70,$50,$49,$50,$21
		dc.b	$4f,$fa,$4f,$d3,$4f,$ac,$4f,$84,$4f,$5d,$4f,$35,$4f,$e,$4e,$e6
		dc.b	$4e,$bf,$4e,$97,$4e,$6f,$4e,$48,$4e,$20,$4d,$f8,$4d,$d0,$4d,$a8
		dc.b	$4d,$80,$4d,$58,$4d,$30,$4d,$8,$4c,$e0,$4c,$b8,$4c,$8f,$4c,$67
		dc.b	$4c,$3f,$4c,$16,$4b,$ee,$4b,$c5,$4b,$9d,$4b,$74,$4b,$4c,$4b,$23
		dc.b	$4a,$fa,$4a,$d2,$4a,$a9,$4a,$80,$4a,$57,$4a,$2e,$4a,$5,$49,$dc
		dc.b	$49,$b3,$49,$8a,$49,$61,$49,$38,$49,$e,$48,$e5,$48,$bc,$48,$92
		dc.b	$48,$69,$48,$3f,$48,$16,$47,$ec,$47,$c3,$47,$99,$47,$6f,$47,$46
		dc.b	$47,$1c,$46,$f2,$46,$c8,$46,$9e,$46,$74,$46,$4a,$46,$20,$45,$f6
		dc.b	$45,$cc,$45,$a2,$45,$78,$45,$4e,$45,$23,$44,$f9,$44,$cf,$44,$a4
		dc.b	$44,$7a,$44,$4f,$44,$25,$43,$fa,$43,$d0,$43,$a5,$43,$7a,$43,$50
		dc.b	$43,$25,$42,$fa,$42,$cf,$42,$a4,$42,$79,$42,$4e,$42,$23,$41,$f8
		dc.b	$41,$cd,$41,$a2,$41,$77,$41,$4c,$41,$20,$40,$f5,$40,$ca,$40,$9e
		dc.b	$40,$73,$40,$47,$40,$1c,$3f,$f0,$3f,$c5,$3f,$99,$3f,$6e,$3f,$42
		dc.b	$3f,$16,$3e,$eb,$3e,$bf,$3e,$93,$3e,$67,$3e,$3b,$3e,$f,$3d,$e3
		dc.b	$3d,$b7,$3d,$8b,$3d,$5f,$3d,$33,$3d,$7,$3c,$db,$3c,$ae,$3c,$82
		dc.b	$3c,$56,$3c,$29,$3b,$fd,$3b,$d1,$3b,$a4,$3b,$78,$3b,$4b,$3b,$1f
		dc.b	$3a,$f2,$3a,$c5,$3a,$99,$3a,$6c,$3a,$3f,$3a,$12,$39,$e6,$39,$b9
		dc.b	$39,$8c,$39,$5f,$39,$32,$39,$5,$38,$d8,$38,$ab,$38,$7e,$38,$51
		dc.b	$38,$24,$37,$f6,$37,$c9,$37,$9c,$37,$6f,$37,$41,$37,$14,$36,$e7
		dc.b	$36,$b9,$36,$8c,$36,$5e,$36,$31,$36,$3,$35,$d6,$35,$a8,$35,$7a
		dc.b	$35,$4d,$35,$1f,$34,$f1,$34,$c3,$34,$96,$34,$68,$34,$3a,$34,$c
		dc.b	$33,$de,$33,$b0,$33,$82,$33,$54,$33,$26,$32,$f8,$32,$ca,$32,$9c
		dc.b	$32,$6d,$32,$3f,$32,$11,$31,$e3,$31,$b4,$31,$86,$31,$58,$31,$29
		dc.b	$30,$fb,$30,$cc,$30,$9e,$30,$6f,$30,$41,$30,$12,$2f,$e4,$2f,$b5
		dc.b	$2f,$86,$2f,$58,$2f,$29,$2e,$fa,$2e,$cc,$2e,$9d,$2e,$6e,$2e,$3f
		dc.b	$2e,$10,$2d,$e1,$2d,$b2,$2d,$83,$2d,$54,$2d,$25,$2c,$f6,$2c,$c7
		dc.b	$2c,$98,$2c,$69,$2c,$3a,$2c,$b,$2b,$db,$2b,$ac,$2b,$7d,$2b,$4e
		dc.b	$2b,$1e,$2a,$ef,$2a,$c0,$2a,$90,$2a,$61,$2a,$31,$2a,$2,$29,$d2
		dc.b	$29,$a3,$29,$73,$29,$44,$29,$14,$28,$e5,$28,$b5,$28,$85,$28,$56
		dc.b	$28,$26,$27,$f6,$27,$c6,$27,$97,$27,$67,$27,$37,$27,$7,$26,$d7
		dc.b	$26,$a7,$26,$77,$26,$47,$26,$17,$25,$e7,$25,$b7,$25,$87,$25,$57
		dc.b	$25,$27,$24,$f7,$24,$c7,$24,$97,$24,$67,$24,$36,$24,$6,$23,$d6
		dc.b	$23,$a6,$23,$75,$23,$45,$23,$15,$22,$e4,$22,$b4,$22,$84,$22,$53
		dc.b	$22,$23,$21,$f2,$21,$c2,$21,$91,$21,$61,$21,$30,$21,$0,$20,$cf
		dc.b	$20,$9f,$20,$6e,$20,$3d,$20,$d,$1f,$dc,$1f,$ab,$1f,$7b,$1f,$4a
		dc.b	$1f,$19,$1e,$e8,$1e,$b8,$1e,$87,$1e,$56,$1e,$25,$1d,$f4,$1d,$c3
		dc.b	$1d,$93,$1d,$62,$1d,$31,$1d,$0,$1c,$cf,$1c,$9e,$1c,$6d,$1c,$3c
		dc.b	$1c,$b,$1b,$da,$1b,$a9,$1b,$78,$1b,$46,$1b,$15,$1a,$e4,$1a,$b3
		dc.b	$1a,$82,$1a,$51,$1a,$20,$19,$ee,$19,$bd,$19,$8c,$19,$5b,$19,$29
		dc.b	$18,$f8,$18,$c7,$18,$95,$18,$64,$18,$33,$18,$1,$17,$d0,$17,$9f
		dc.b	$17,$6d,$17,$3c,$17,$a,$16,$d9,$16,$a7,$16,$76,$16,$44,$16,$13
		dc.b	$15,$e1,$15,$b0,$15,$7e,$15,$4d,$15,$1b,$14,$ea,$14,$b8,$14,$86
		dc.b	$14,$55,$14,$23,$13,$f2,$13,$c0,$13,$8e,$13,$5d,$13,$2b,$12,$f9
		dc.b	$12,$c7,$12,$96,$12,$64,$12,$32,$12,$0,$11,$cf,$11,$9d,$11,$6b
		dc.b	$11,$39,$11,$7,$10,$d6,$10,$a4,$10,$72,$10,$40,$10,$e,$f,$dc
		dc.b	$f,$ab,$f,$79,$f,$47,$f,$15,$e,$e3,$e,$b1,$e,$7f,$e,$4d
		dc.b	$e,$1b,$d,$e9,$d,$b7,$d,$85,$d,$53,$d,$21,$c,$ef,$c,$bd
		dc.b	$c,$8b,$c,$59,$c,$27,$b,$f5,$b,$c3,$b,$91,$b,$5f,$b,$2d
		dc.b	$a,$fb,$a,$c9,$a,$97,$a,$65,$a,$32,$a,$0,$9,$ce,$9,$9c
		dc.b	$9,$6a,$9,$38,$9,$6,$8,$d4,$8,$a1,$8,$6f,$8,$3d,$8,$b
		dc.b	$7,$d9,$7,$a7,$7,$74,$7,$42,$7,$10,$6,$de,$6,$ac,$6,$7a
		dc.b	$6,$47,$6,$15,$5,$e3,$5,$b1,$5,$7e,$5,$4c,$5,$1a,$4,$e8
		dc.b	$4,$b6,$4,$83,$4,$51,$4,$1f,$3,$ed,$3,$ba,$3,$88,$3,$56
		dc.b	$3,$24,$2,$f1,$2,$bf,$2,$8d,$2,$5b,$2,$28,$1,$f6,$1,$c4
		dc.b	$1,$92,$1,$5f,$1,$2d,$0,$fb,$0,$c9,$0,$96,$0,$64,$0,$32
		dc.b	$0,$0,$0,$51,$0,$a2,$0,$f4,$1,$45,$1,$97,$1,$e8,$2,$39
		dc.b	$2,$8b,$2,$dc,$3,$2d,$3,$7e,$3,$ce,$4,$1f,$4,$70,$4,$c0
		dc.b	$5,$11,$5,$61,$5,$b1,$6,$0,$6,$50,$6,$a0,$6,$ef,$7,$3e
		dc.b	$7,$8d,$7,$db,$8,$2a,$8,$78,$8,$c6,$9,$13,$9,$61,$9,$ae
		dc.b	$9,$fb,$a,$47,$a,$93,$a,$df,$b,$2b,$b,$76,$b,$c1,$c,$c
		dc.b	$c,$57,$c,$a1,$c,$ea,$d,$34,$d,$7d,$d,$c6,$e,$e,$e,$56
		dc.b	$e,$9d,$e,$e5,$f,$2c,$f,$72,$f,$b8,$f,$fe,$10,$43,$10,$88
		dc.b	$10,$cd,$11,$11,$11,$55,$11,$98,$11,$db,$12,$1e,$12,$60,$12,$a2
		dc.b	$12,$e3,$13,$24,$13,$65,$13,$a5,$13,$e5,$14,$24,$14,$63,$14,$a2
		dc.b	$14,$e0,$15,$1d,$15,$5b,$15,$98,$15,$d4,$16,$10,$16,$4c,$16,$87
		dc.b	$16,$c2,$16,$fc,$17,$36,$17,$70,$17,$a9,$17,$e2,$18,$1a,$18,$52
		dc.b	$18,$89,$18,$c1,$18,$f7,$19,$2e,$19,$64,$19,$99,$19,$ce,$1a,$3
		dc.b	$1a,$37,$1a,$6b,$1a,$9f,$1a,$d2,$1b,$5,$1b,$37,$1b,$69,$1b,$9b
		dc.b	$1b,$cc,$1b,$fd,$1c,$2e,$1c,$5e,$1c,$8d,$1c,$bd,$1c,$ec,$1d,$1b
		dc.b	$1d,$49,$1d,$77,$1d,$a5,$1d,$d2,$1d,$ff,$1e,$2b,$1e,$57,$1e,$83
		dc.b	$1e,$af,$1e,$da,$1f,$5,$1f,$30,$1f,$5a,$1f,$84,$1f,$ad,$1f,$d6

L2d6de_inv_table:
		dc.b	$3f,$ff,$3f,$5c,$3e,$b9,$3e,$16,$3d,$73,$3c,$cf,$3c,$2c,$3b,$88
		dc.b	$3a,$e4,$3a,$3f,$39,$9b,$38,$f5,$38,$50,$37,$aa,$37,$3,$36,$5c
		dc.b	$35,$b4,$35,$b,$34,$61,$33,$b7,$33,$c,$32,$60,$31,$b3,$31,$5
		dc.b	$30,$56,$2f,$a5,$2e,$f4,$2e,$41,$2d,$8c,$2c,$d6,$2c,$1e,$2b,$65
		dc.b	$2a,$aa,$29,$ed,$29,$2d,$28,$6c,$27,$a8,$26,$e2,$26,$18,$25,$4c
		dc.b	$24,$7d,$23,$ab,$22,$d5,$21,$fb,$21,$1d,$20,$3a,$1f,$52,$1e,$65
		dc.b	$1d,$72,$1c,$78,$1b,$77,$1a,$6d,$19,$5b,$18,$3e,$17,$15,$15,$de
		dc.b	$14,$96,$13,$3b,$11,$c8,$10,$36,$e,$7b,$c,$86,$a,$36,$7,$36
		dc.b	$7f,$fe,$78,$c8,$75,$c8,$73,$78,$71,$83,$6f,$c8,$6e,$36,$6c,$c3
		dc.b	$6b,$68,$6a,$20,$68,$e9,$67,$c0,$66,$a3,$65,$91,$64,$87,$63,$86
		dc.b	$62,$8c,$61,$99,$60,$ac,$5f,$c4,$5e,$e1,$5e,$3,$5d,$29,$5c,$53
		dc.b	$5b,$81,$5a,$b2,$59,$e6,$59,$1c,$58,$56,$57,$92,$56,$d1,$56,$11
		dc.b	$55,$54,$54,$99,$53,$e0,$53,$28,$52,$72,$51,$bd,$51,$a,$50,$59
		dc.b	$4f,$a8,$4e,$f9,$4e,$4b,$4d,$9e,$4c,$f2,$4c,$47,$4b,$9d,$4a,$f3
		dc.b	$4a,$4a,$49,$a2,$48,$fb,$48,$54,$47,$ae,$47,$9,$46,$63,$45,$bf
		dc.b	$45,$1a,$44,$76,$43,$d2,$43,$2f,$42,$8b,$41,$e8,$41,$45,$40,$a2

* This + L2e6f2 is 4096 bytes (num possible pallete cols)
* When dynamic colours are allocated these things are set
* to 0 (not allocated) or to the index in dyn_cols.
L2dc48_col_indices:
		dc.b	$ff,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
		ds.b	2714

L2e6f2:
		ds.b	1366

* Add dynamic colour (d6). returns allocated index in d6.
L2ec48_AllocDynCol:
		lea	L2dc48_col_indices,a5
		moveq	#0,d0
		move.b	0(a5,d6.w),d0
		beq.s	l2ec5e
		tst.w	d6
		beq.s	l2ec7e
		move.w	d0,d6
		bra.s	l2ec7e
	l2ec5e:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d0
		cmp.w	#$f8,d0
		blt.s	l2ec70
		moveq	#0,d6
		bra.s	l2ec7e
	l2ec70:	move.b	d0,0(a5,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l2ec7e:	rts

	l2ec80:	movea.l	(a7)+,a1
		movem.l	4(a0),d0-7
		movem.w	d0-7,2(a1)
		movem.l	36(a0),d0-4
		cmpi.w	#$34,16006(a6)
		bne.s	l2eca6
		movem.w	d0-4,18(a1)
		bra.w	L2eef8
	l2eca6:	cmpi.w	#$30,16006(a6)
		bne.s	l2ecb8
		movem.w	d0-3,18(a1)
		bra.w	L2eef8
	l2ecb8:	movem.w	d0-2,18(a1)
		bra.w	L2eef8

L2ecc2_MakePalette:
		movem.l	a5/a1,-(a7)
		lea	L5dae_dyn_cols,a0
		lea	L2dc48_col_indices(pc),a2
		move.w	(a0),d0
		
		subq.w	#8,d0
		bmi.s	l2ec80
		moveq	#0,d1
		* Unset the col_indices shit
	l2ecd8:	move.w	6(a0,d0.w),d2
		move.b	d1,0(a2,d2.w)
		subq.w	#4,d0
		bpl.s	l2ecd8
		move.w	(a0),d0
		* mostly 52
		move.w	16006(a6),d1
		addq.w	#4,d1
		cmp.w	d1,d0
		ble.w	l2ec80

		* allocate extended colours
		lea	L5dae_dyn_cols,a0
		move.l	a0,-(a7)
		hcall	#Call_MakeExtPalette
		addq.l	#4,a7
		movem.l	(a7)+,a5/a1

		rts

L2eef8:
		move.w	16006(a6),d0
		lsr.w	#2,d0
		movea.l	a1,a2
		lea	32(a1),a3
	l2ef66:	move.w	(a2),d1
		*lsr.w	#1,d1
		*andi.w	#$777,d1
		move.w	d1,(a2)+
		move.w	d1,(a3)+
		dbra	d0,l2ef66
		movea.l	(a7)+,a5
		
		rts

line_draw_col:
		dc.w	0
		
		* ($ffc8 in table)
:		move.w	line_draw_col(pc),-(a7)
		hcall	#Call_FillLine
		addq.l	#2,a7
		rts

		nop
		* ($ffd6 in table)
:		move.w	line_draw_col(pc),-(a7)
		hcall	#Call_BackHLine
		addq.l	#2,a7
		rts

		nop
		* $e bytes
:		move.w	line_draw_col(pc),-(a7)
		hcall	#Call_PutPix
		addq.l	#2,a7
		rts

		nop
		* $e bytes
:		move.w	line_draw_col(pc),-(a7)
		hcall	#Call_OldHLine
		addq.l	#2,a7
		rts

		nop
new_linecrap:
		dc.b	$ff,$e4,$ff,$e4,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2,$ff,$f2
		dc.b	$ff,$c8,$ff,$d6

N34154_WipeAllLogscreen:
		move.l	L5da6_logscreen2,-(a7)
		move.l	#64000,-(a7)
		hcall	#Call_MemSet
		lea	8(a7),a7
		rts

N3416a_WipeLogscreen:
		move.l	L5da6_logscreen2,-(a7)
		move.l	#53760,-(a7)
		hcall	#Call_MemSet
		lea	8(a7),a7
		rts

N34174_FillBlueLogscreen:
		move.l	L5da6_logscreen2,-(a7)
		move.l	#53760,-(a7)
		hcall	#Call_MemSetBlue
		lea	8(a7),a7
		rts

L3422e_DrawStrToPhys:
		movem.l	a0/d1-2,-(a7)
		jsr	L42452_RedrawUnderMouse
		jsr	L41b8c_PhysToLog2
		bsr.s	L34254_DrawStr
		movem.l	(a7)+,d1-2/a0
		jsr	L41b80_LogToLog2
		bsr.s	L34254_DrawStr
		jsr	L423d2_DrawMouse1
		rts

* x,y pos in 0(a0),1(a0)
L3425e_DrawStrXY:
		moveq	#0,d1
		move.b	(a0)+,d1
		add.w	d1,d1
		moveq	#0,d2
		move.b	(a0)+,d2

L34268_DrawStrCol15:
		moveq	#15,d0

* d0 = color, d1 = x, d2 = y, a0 = string
L34254_DrawStr:
		hcall	#Call_DrawStr
		rts

* d0 = color, d1 = x, d2 = y, a0 = string
L342fe_DrawStrShadowed:
		hcall	#Call_DrawStrShadowed
		rts

L343ac_DrawTriangle:
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
		cmp.w	d3,d1
		ble.s	l343c0
		exg	d0,d2
		exg	d1,d3
	l343c0:	cmp.w	d5,d1
		ble.s	l343c8
		exg	d0,d4
		exg	d1,d5
	l343c8:	cmp.w	d5,d3
		ble.s	l343d0
		exg	d2,d4
		exg	d3,d5
	l343d0:	movem.w	d2-5,-(a7)
		move.w	d4,d6
		sub.w	d0,d2
		sub.w	d1,d3
		beq.s	l343ee
		ext.l	d2
		asl.l	#8,d2
		divs	d3,d2
		bvc.s	l343f4
		asr.l	#2,d2
		divs	d3,d2
		ext.l	d2
		asl.l	#2,d2
		bra.s	l343f6
	l343ee:	ext.l	d2
		swap	d2
		bra.s	l34404
	l343f4:	ext.l	d2
	l343f6:	move.w	d0,d4
		swap	d4
		move.w	#$8000,d4
		asl.l	#7,d2
		sub.l	d2,d4
		add.l	d2,d2
	l34404:	movea.l	d2,a4
		exg	d0,d3
		sub.w	d3,d6
		sub.w	d1,d5
		beq.s	l34420
		ext.l	d6
		asl.l	#8,d6
		divs	d5,d6
		bvc.s	l34426
		asr.l	#2,d6
		divs	d5,d6
		ext.l	d6
		asl.l	#2,d6
		bra.s	l34428
	l34420:	ext.l	d6
		swap	d6
		bra.s	l34434
	l34426:	ext.l	d6
	l34428:	swap	d3
		move.w	#$8000,d3
		asl.l	#7,d6
		sub.l	d6,d3
		add.l	d6,d6
	l34434:	movea.l	d6,a5
		movea.l	L5da6_logscreen2,a6
		asl.w	#5,d1
		adda.w	d1,a6
		asl.w	#2,d1
		adda.w	d1,a6
		cmpa.l	a4,a5
		sgt	L1afa5
		bgt.s	l34460
		addi.l	#$8000,d4
		subi.l	#$8000,d3
		exg	a5,a4
		exg	d4,d3
		bra.s	l3446c
	l34460:	subi.l	#$8000,d4
		addi.l	#$8000,d3
	l3446c:	subq.w	#1,d0
		bmi.s	l34498
	l34470:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l3448e
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l3448e:	swap	d4
		lea	160(a6),a6
		dbra	d0,l34470
	l34498:	tst.b	L1afa5
		bmi.s	l344a4
		exg	a5,a4
		exg	d4,d3
	l344a4:	movem.w	(a7)+,d0-1/d6-7
		sub.w	d0,d6
		sub.w	d1,d7
		beq.s	l344c0
		ext.l	d6
		asl.l	#8,d6
		divs	d7,d6
		bvc.s	l344c6
		asr.l	#2,d6
		divs	d7,d6
		ext.l	d6
		asl.l	#2,d6
		bra.s	l344c8
	l344c0:	ext.l	d6
		swap	d6
		bra.s	l344d6
	l344c6:	ext.l	d6
	l344c8:	move.w	d0,d4
		swap	d4
		move.w	#$8000,d4
		asl.l	#7,d6
		sub.l	d6,d4
		add.l	d6,d6
	l344d6:	movea.l	d6,a4
		move.w	d7,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l344f0
		addi.l	#$8000,d4
		exg	a5,a4
		exg	d4,d3
		bra.s	l344f6
	l344f0:	subi.l	#$8000,d4
	l344f6:	subq.w	#1,d0
		bmi.s	l34522
	l344fa:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l34518
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34518:	swap	d4
		lea	160(a6),a6
		dbra	d0,l344fa
	l34522:	tst.b	L1afa5
		bmi.s	l3452e
		exg	a5,a4
		exg	d4,d3
	l3452e:	rts

* points: (d0,d1), (d2,d3), (d4,d5), (d6,d7)
* col: a0
L34530_DrawQuad:
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
	l3453c:	cmp.w	d3,d1
		bgt.s	l34548
		cmp.w	d5,d1
		bgt.s	l34548
		cmp.w	d7,d1
		ble.s	l3455e
	l34548:	movea.w	d0,a2
		movea.w	d1,a3
		move.w	d2,d0
		move.w	d3,d1
		move.w	d6,d2
		move.w	d7,d3
		move.w	d4,d6
		move.w	d5,d7
		move.w	a2,d4
		move.w	a3,d5
		bra.s	l3453c
	l3455e:	movem.w	d2-7,-(a7)
		move.w	d4,d6
		sub.w	d0,d2
		sub.w	d1,d3
		beq.s	l3457c
		ext.l	d2
		asl.l	#8,d2
		divs	d3,d2
		bvc.s	l34582
		asr.l	#2,d2
		divs	d3,d2
		ext.l	d2
		asl.l	#2,d2
		bra.s	l34584
	l3457c:	ext.l	d2
		swap	d2
		bra.s	l34592
	l34582:	ext.l	d2
	l34584:	move.w	d0,d4
		swap	d4
		move.w	#$8000,d4
		asl.l	#7,d2
		sub.l	d2,d4
		add.l	d2,d2
	l34592:	movea.l	d2,a4
		exg	d0,d3
		sub.w	d3,d6
		sub.w	d1,d5
		beq.s	l345ae
		ext.l	d6
		asl.l	#8,d6
		divs	d5,d6
		bvc.s	l345b4
		asr.l	#2,d6
		divs	d5,d6
		ext.l	d6
		asl.l	#2,d6
		bra.s	l345b6
	l345ae:	ext.l	d6
		swap	d6
		bra.s	l345c2
	l345b4:	ext.l	d6
	l345b6:	swap	d3
		move.w	#$8000,d3
		asl.l	#7,d6
		sub.l	d6,d3
		add.l	d6,d6
	l345c2:	movea.l	d6,a5
		movea.l	L5da6_logscreen2,a6
		asl.w	#5,d1
		adda.w	d1,a6
		asl.w	#2,d1
		adda.w	d1,a6
		cmp.w	d0,d5
		bgt.w	l3483a
		move.l	d5,d0
		cmpa.l	a4,a5
		sgt	L1afa5
		bgt.s	l345f6
		subi.l	#$8000,d3
		addi.l	#$8000,d4
		exg	a5,a4
		exg	d4,d3
		bra.s	l34602
	l345f6:	addi.l	#$8000,d3
		subi.l	#$8000,d4
	l34602:	subq.w	#1,d0
		bmi.s	l3462e
	l34606:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l34624
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34624:	swap	d4
		lea	160(a6),a6
		dbra	d0,l34606
	l3462e:	tst.b	L1afa5
		bmi.s	l3463a
		exg	a5,a4
		exg	d4,d3
	l3463a:	movem.w	(a7),d0-2/d5-7
		sub.w	d2,d6
		sub.w	d5,d7
		beq.s	l34656
		ext.l	d6
		asl.l	#8,d6
		divs	d7,d6
		bvc.s	l3465c
		asr.l	#2,d6
		divs	d7,d6
		ext.l	d6
		asl.l	#2,d6
		bra.s	l3465e
	l34656:	ext.l	d6
		swap	d6
		bra.s	l3466c
	l3465c:	ext.l	d6
	l3465e:	move.w	d2,d3
		swap	d3
		move.w	#$8000,d3
		asl.l	#7,d6
		sub.l	d6,d3
		add.l	d6,d6
	l3466c:	movea.l	d6,a5
		sub.w	d5,d1
		cmp.w	d1,d7
		bgt.w	l34758
		move.w	d7,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l3468e
		subi.l	#$8000,d3
		exg	a5,a4
		exg	d4,d3
		bra.s	l34694
	l3468e:	addi.l	#$8000,d3
	l34694:	subq.w	#1,d0
		bmi.s	l346c0
	l34698:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l346b6
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l346b6:	swap	d4
		lea	160(a6),a6
		dbra	d0,l34698
	l346c0:	tst.b	L1afa5
		bmi.s	l346cc
		exg	a5,a4
		exg	d4,d3
	l346cc:	movem.w	(a7)+,d0-2/d5-7
		sub.w	d6,d0
		sub.w	d7,d1
		beq.s	l346e8
		ext.l	d0
		asl.l	#8,d0
		divs	d1,d0
		bvc.s	l346ee
		asr.l	#2,d0
		divs	d1,d0
		ext.l	d0
		asl.l	#2,d0
		bra.s	l346f0
	l346e8:	ext.l	d0
		swap	d0
		bra.s	l346fe
	l346ee:	ext.l	d0
	l346f0:	move.w	d6,d3
		swap	d3
		move.w	#$8000,d3
		asl.l	#7,d0
		sub.l	d0,d3
		add.l	d0,d0
	l346fe:	movea.l	d0,a5
		move.w	d1,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l34718
		subi.l	#$8000,d3
		exg	a5,a4
		exg	d4,d3
		bra.s	l3471e
	l34718:	addi.l	#$8000,d3
	l3471e:	subq.w	#1,d0
		bmi.s	l3474a
	l34722:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l34740
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34740:	swap	d4
		lea	160(a6),a6
		dbra	d0,l34722
	l3474a:	tst.b	L1afa5
		bmi.s	l34756
		exg	a5,a4
		exg	d4,d3
	l34756:	rts

	l34758:	move.w	d1,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l34770
		subi.l	#$8000,d3
		exg	a5,a4
		exg	d4,d3
		bra.s	l34776
	l34770:	addi.l	#$8000,d3
	l34776:	subq.w	#1,d0
		bmi.s	l347a2
	l3477a:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l34798
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34798:	swap	d4
		lea	160(a6),a6
		dbra	d0,l3477a
	l347a2:	tst.b	L1afa5
		bmi.s	l347ae
		exg	a5,a4
		exg	d4,d3
	l347ae:	movem.w	(a7)+,d0-2/d5-7
		sub.w	d0,d6
		sub.w	d1,d7
		beq.s	l347ca
		ext.l	d6
		asl.l	#8,d6
		divs	d7,d6
		bvc.s	l347d0
		asr.l	#2,d6
		divs	d7,d6
		ext.l	d6
		asl.l	#2,d6
		bra.s	l347d2
	l347ca:	ext.l	d6
		swap	d6
		bra.s	l347e0
	l347d0:	ext.l	d6
	l347d2:	move.w	d0,d4
		swap	d4
		move.w	#$8000,d4
		asl.l	#7,d6
		sub.l	d6,d4
		add.l	d6,d6
	l347e0:	movea.l	d6,a4
		move.w	d7,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l347fa
		addi.l	#$8000,d4
		exg	a5,a4
		exg	d4,d3
		bra.s	l34800
	l347fa:	subi.l	#$8000,d4
	l34800:	subq.w	#1,d0
		bmi.s	l3482c
	l34804:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l34822
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34822:	swap	d4
		lea	160(a6),a6
		dbra	d0,l34804
	l3482c:	tst.b	L1afa5
		bmi.s	l34838
		exg	a5,a4
		exg	d4,d3
	l34838:	rts

	l3483a:	cmpa.l	a4,a5
		sgt	L1afa5
		bgt.s	l34856
		addi.l	#$8000,d4
		subi.l	#$8000,d3
		exg	a5,a4
		exg	d4,d3
		bra.s	l34862
	l34856:	subi.l	#$8000,d4
		addi.l	#$8000,d3
	l34862:	subq.w	#1,d0
		bmi.s	l3488e
	l34866:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l34884
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34884:	swap	d4
		lea	160(a6),a6
		dbra	d0,l34866
	l3488e:	tst.b	L1afa5
		bmi.s	l3489a
		exg	a5,a4
		exg	d4,d3
	l3489a:	movem.w	(a7),d0-2/d5-7
		sub.w	d0,d6
		sub.w	d1,d7
		beq.s	l348b6
		ext.l	d6
		asl.l	#8,d6
		divs	d7,d6
		bvc.s	l348bc
		asr.l	#2,d6
		divs	d7,d6
		ext.l	d6
		asl.l	#2,d6
		bra.s	l348be
	l348b6:	ext.l	d6
		swap	d6
		bra.s	l348cc
	l348bc:	ext.l	d6
	l348be:	move.w	d0,d4
		swap	d4
		move.w	#$8000,d4
		asl.l	#7,d6
		sub.l	d6,d4
		add.l	d6,d6
	l348cc:	movea.l	d6,a4
		sub.w	d1,d5
		cmp.w	d5,d7
		bgt.w	l349b8
		move.w	d7,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l348ee
		addi.l	#$8000,d4
		exg	a5,a4
		exg	d4,d3
		bra.s	l348f4
	l348ee:	subi.l	#$8000,d4
	l348f4:	subq.w	#1,d0
		bmi.s	l34920
	l348f8:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l34916
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34916:	swap	d4
		lea	160(a6),a6
		dbra	d0,l348f8
	l34920:	tst.b	L1afa5
		bmi.s	l3492c
		exg	a5,a4
		exg	d4,d3
	l3492c:	movem.w	(a7)+,d0-2/d5-7
		sub.w	d6,d2
		sub.w	d7,d5
		beq.s	l34948
		ext.l	d2
		asl.l	#8,d2
		divs	d5,d2
		bvc.s	l3494e
		asr.l	#2,d2
		divs	d5,d2
		ext.l	d2
		asl.l	#2,d2
		bra.s	l34950
	l34948:	ext.l	d2
		swap	d2
		bra.s	l3495e
	l3494e:	ext.l	d2
	l34950:	move.w	d6,d4
		swap	d4
		move.w	#$8000,d4
		asl.l	#7,d2
		sub.l	d2,d4
		add.l	d2,d2
	l3495e:	movea.l	d2,a4
		move.w	d5,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l34978
		addi.l	#$8000,d4
		exg	a5,a4
		exg	d4,d3
		bra.s	l3497e
	l34978:	subi.l	#$8000,d4
	l3497e:	subq.w	#1,d0
		bmi.s	l349aa
	l34982:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l349a0
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l349a0:	swap	d4
		lea	160(a6),a6
		dbra	d0,l34982
	l349aa:	tst.b	L1afa5
		bmi.s	l349b6
		exg	a5,a4
		exg	d4,d3
	l349b6:	rts

	l349b8:	move.w	d5,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l349d0
		addi.l	#$8000,d4
		exg	a5,a4
		exg	d4,d3
		bra.s	l349d6
	l349d0:	subi.l	#$8000,d4
	l349d6:	subq.w	#1,d0
		bmi.s	l34a02
	l349da:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l349f8
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l349f8:	swap	d4
		lea	160(a6),a6
		dbra	d0,l349da
	l34a02:	tst.b	L1afa5
		bmi.s	l34a0e
		exg	a5,a4
		exg	d4,d3
	l34a0e:	movem.w	(a7)+,d0-2/d5-7
		sub.w	d2,d6
		sub.w	d5,d7
		beq.s	l34a2a
		ext.l	d6
		asl.l	#8,d6
		divs	d7,d6
		bvc.s	l34a30
		asr.l	#2,d6
		divs	d7,d6
		ext.l	d6
		asl.l	#2,d6
		bra.s	l34a32
	l34a2a:	ext.l	d6
		swap	d6
		bra.s	l34a40
	l34a30:	ext.l	d6
	l34a32:	move.w	d2,d3
		swap	d3
		move.w	#$8000,d3
		asl.l	#7,d6
		sub.l	d6,d3
		add.l	d6,d6
	l34a40:	movea.l	d6,a5
		move.w	d7,d0
		cmp.l	d4,d3
		sgt	L1afa5
		bgt.s	l34a5a
		subi.l	#$8000,d3
		exg	a5,a4
		exg	d4,d3
		bra.s	l34a60
	l34a5a:	addi.l	#$8000,d3
	l34a60:	subq.w	#1,d0
		bmi.s	l34a8c
	l34a64:	add.l	a4,d4
		add.l	a5,d3
		swap	d4
		movea.l	a6,a3
		move.l	d3,d5
		swap	d5
		sub.w	d4,d5
		cmp.w	#$140,d5
		bhi.s	l34a82
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34a82:	swap	d4
		lea	160(a6),a6
		dbra	d0,l34a64
	l34a8c:	tst.b	L1afa5
		bmi.s	l34a98
		exg	a5,a4
		exg	d4,d3
	l34a98:	rts

	l34a9a:	rts

	l34a9c:	cmp.w	#$2,d0
		blt.s	l34a9a
		cmp.w	#$13e,d0
		bge.s	l34a9a
		cmp.w	#$2,d1
		blt.s	l34a9a
		cmp.w	#$a6,d1
		bge.s	l34a9a
		move.w	d1,d5
		movea.l	L5da6_logscreen2,a3
		asl.w	#5,d5
		adda.w	d5,a3
		asl.w	#2,d5
		adda.w	d5,a3
		move.w	d0,d4
		subq.w	#1,d4
		movea.l	a3,a6
		cmp.w	#$1,d2
		blt.w	l34b5a
		beq.s	l34b26
		cmp.w	#$3,d2
		blt.s	l34b3e
		beq.w	l34b62
		cmp.w	#$4,d2
		beq.w	l34b88
		subq.w	#1,d4
		moveq	#10,d5
		movea.w	10(a0),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a3
		addq.w	#1,d4
		moveq	#6,d5
		movea.w	6(a0),a2
		jsr	0(a0,a2.w)
		lea	160(a6),a3
		moveq	#6,d5
		movea.w	6(a0),a2
		jsr	0(a0,a2.w)
		lea	-320(a6),a3
		addq.w	#1,d4
		movea.w	(a0),a2
		jsr	0(a0,a2.w)
		lea	320(a6),a3
		movea.w	(a0),a2
		jmp	0(a0,a2.w)
	l34b26:	moveq	#4,d5
		movea.w	4(a0),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a3
		moveq	#4,d5
		movea.w	4(a0),a2
		jmp	0(a0,a2.w)
	l34b3e:	moveq	#6,d5
		movea.w	6(a0),a2
		jsr	0(a0,a2.w)
		lea	160(a6),a3
		addq.w	#1,d4
		movea.w	(a0),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a3
		subq.w	#1,d4
	l34b5a:	addq.w	#1,d4
		movea.w	(a0),a2
		jmp	0(a0,a2.w)
	l34b62:	moveq	#6,d5
		movea.w	6(a0),a2
		jsr	0(a0,a2.w)
		lea	160(a6),a3
		moveq	#6,d5
		movea.w	6(a0),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a3
		moveq	#6,d5
		movea.w	6(a0),a2
		jmp	0(a0,a2.w)
	l34b88:	subq.w	#1,d4
		moveq	#8,d5
		movea.w	8(a0),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a3
		moveq	#8,d5
		movea.w	8(a0),a2
		jsr	0(a0,a2.w)
		addq.w	#1,d4
		lea	-320(a6),a3
		moveq	#4,d5
		movea.w	4(a0),a2
		jsr	0(a0,a2.w)
		lea	160(a6),a3
		moveq	#4,d5
		movea.w	4(a0),a2
		jmp	0(a0,a2.w)
	l34bc0:	move.w	d2,d5
		lsr.w	#1,d5
		tst.w	d0
		bmi.s	l34bd4
		move.w	d0,d3
		sub.w	d5,d3
		cmp.w	#$140,d3
		blt.s	l34bfe
		rts

	l34bd4:	move.w	d0,d3
		add.w	d5,d3
		bgt.s	l34bfe
		rts

	l34bdc:	move.w	d2,d5
		lsr.w	#1,d5
		tst.w	d1
		bmi.s	l34bf0
		move.w	d1,d3
		sub.w	d5,d3
		cmp.w	#$a8,d3
		blt.s	L34c04_DrawCircle
		rts

	l34bf0:	move.w	d1,d3
		add.w	d5,d3
		bgt.s	L34c04_DrawCircle
	l34bf6:	rts

L34bf8_DrawCircleClipped:
		cmp.w	#$140,d0
		bcc.s	l34bc0
	l34bfe:	cmp.w	#$a8,d1
		bcc.s	l34bdc

L34c04_DrawCircle:
		move.w	a0,line_draw_col
		lea	new_linecrap,a0

L34c10:
		cmp.w	#$6,d2
		blt.w	l34a9c
		cmp.w	#$3f0,d2
		bcc.s	l34bf6
		move.l	a5,-(a7)
		lea	-4032(a7),a7
		move.w	d2,d5
		move.w	d2,d4
		add.w	d4,d4
		move.w	d4,d3
		bclr	#$1,d3
		lsr.w	#1,d2
		movea.w	d2,a2
		subq.w	#2,d5
		cmp.w	#$5,d5
		bne.s	l34c3e
		addq.w	#3,d5
	l34c3e:	neg.w	d5
		movea.l	a7,a3
		lea	0(a3,d3.w),a4
		movea.l	a4,a5
		lea	0(a4,d3.w),a6
		moveq	#0,d3
		movea.w	d3,a1
		bra.s	l34c66
	l34c52:	move.w	d0,d6
		sub.w	a2,d6
		swap	d6
		move.w	a2,d6
		add.w	d6,d6
		move.l	d6,-(a4)
		move.l	d6,(a5)+
		tst.w	d5
		bpl.w	l34d38
	l34c66:	add.w	d3,d5
		addq.w	#6,d5

L34c6a:
		addq.w	#4,d3
		addq.w	#1,a1
		cmp.w	d3,d4
		bgt.s	l34c52
		bne.s	l34c82
		move.w	d0,d6
		sub.w	a2,d6
		swap	d6
		move.w	a2,d6
		add.w	d6,d6
		move.l	d6,-(a4)
		move.l	d6,(a5)+
	l34c82:	movea.l	a7,a5
		move.w	d1,d7
		sub.w	d2,d7
		bpl.s	l34c98
		neg.w	d7
		add.w	d7,d7
		add.w	d7,d7
		adda.w	d7,a5
		moveq	#0,d7
	l34c98:	move.w	d7,d6
		movea.l	L5da6_logscreen2,a6
		asl.w	#5,d6
		adda.w	d6,a6
		asl.w	#2,d6
		adda.w	d6,a6
		cmp.w	d2,d0
		blt.s	l34ce4
		add.w	d2,d0
		cmp.w	#$140,d0
		bgt.s	l34ce4
		add.w	d1,d2
		cmp.w	#$a8,d2
		blt.s	l34cc0
		move.w	#$a8,d2
	l34cc0:	sub.w	d7,d2
		subq.w	#1,d2
	* this draws the cute circles like explosions and imp courier exhaust
	l34cc4:	movem.w	(a5)+,d4-5
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
		lea	160(a6),a6
		dbra	d2,l34cc4
		lea	4032(a7),a7
		movea.l	(a7)+,a5
		rts

	l34ce4:	add.w	d1,d2
		ble.s	l34d30
		cmp.w	#$a8,d2
		blt.s	l34cf2
		move.w	#$a8,d2
	l34cf2:	sub.w	d7,d2
		subq.w	#1,d2
	l34cf6:	movem.w	(a5)+,d4-5
		tst.w	d4
		bpl.s	l34d04
		add.w	d4,d5
		bmi.s	l34d28
		moveq	#0,d4
	l34d04:	move.w	d4,d0
		add.w	d5,d0
		cmp.w	#$140,d0
		blt.s	l34d16
		subi.w	#$140,d0
		sub.w	d0,d5
		ble.s	l34d28
	l34d16:	movea.l	a6,a3
		cmp.w	#$140,d5
		bhi.s	l34d28
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34d28:	lea	160(a6),a6
		dbra	d2,l34cf6
	l34d30:	lea	4032(a7),a7
		movea.l	(a7)+,a5
		rts

	l34d38:	move.w	d0,d6
		sub.w	a1,d6
		swap	d6
		move.w	a1,d6
		add.w	d6,d6
		move.l	d6,(a3)+
		move.l	d6,-(a6)
		add.w	d3,d5
		sub.w	d4,d5
		addi.w	#$a,d5
		subq.w	#4,d4
		subq.w	#1,a2
		bra.w	L34c6a

* (d0,d1) to (d2,d3)
L34d56_DrawStraightLine:
		move.w	a0,line_draw_col
		lea	new_linecrap,a0

L34d62_DrawStraightLine2:
		*tst.w	gl_renderer_on
		*beq.s	lermmm

		*move.w	d4,-(a7)
		*move.w	line_draw_col,d4
		*hcall	#Nu_Draw2DLine
		*move.w	(a7)+,d4
		*rts

	lermmm:
		move.w	d1,d4
		movea.l	L5da6_logscreen2,a6
		asl.w	#5,d4
		adda.w	d4,a6
		asl.w	#2,d4
		adda.w	d4,a6
		move.w	d0,d4
		sub.w	d0,d2
		bmi.w	l34e70
		move.w	d2,d0
		sub.w	d1,d3
		bmi.s	l34dfa
	l34d80:	movea.w	d2,a4
		movea.w	d3,a5
		cmp.w	d2,d3
		bgt.s	l34dc8
		subq.w	#1,d0
		bmi.s	l34dc6
		asr.w	#1,d2
		neg.w	d2
		moveq	#0,d5
	l34d92:	addq.w	#1,d5
		add.w	a5,d2
		ble.s	l34db6
		sub.w	a4,d2
		move.w	d5,d3
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
		add.w	d3,d4
		lea	160(a6),a6
		moveq	#0,d5
		dbra	d0,l34d92
		rts

	l34db6:	dbra	d0,l34d92
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34dc6:	rts

	l34dc8:	move.w	d3,d0
		subq.w	#1,d0
		bmi.s	l34dc6
		asr.w	#1,d3
		neg.w	d3
		moveq	#0,d5
	l34dd4:	movea.l	a6,a3
		movea.w	(a0),a2
		jsr	0(a0,a2.w)
		add.w	d5,d4
		lea	160(a6),a6
		add.w	a4,d3
		dbgt	d0,l34dd4
		ble.s	l34df2
		sub.w	a5,d3
		addq.w	#1,d4
		dbra	d0,l34dd4
	l34df2:	rts

	l34df4:	move.w	d2,d0
		tst.w	d3
		bpl.s	l34d80
	l34dfa:	neg.w	d3
		movea.w	d2,a4
		movea.w	d3,a5
		cmp.w	d2,d3
		bgt.s	l34e44
		subq.w	#1,d0
		bmi.s	l34e42
		asr.w	#1,d2
		neg.w	d2
		moveq	#0,d5
	l34e0e:	addq.w	#1,d5
		add.w	a5,d2
		ble.s	l34e32
		sub.w	a4,d2
		move.w	d5,d3
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
		add.w	d3,d4
		lea	-160(a6),a6
		moveq	#0,d5
		dbra	d0,l34e0e
		rts

	l34e32:	dbra	d0,l34e0e
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34e42:	rts

	l34e44:	move.w	d3,d0
		subq.w	#1,d0
		bmi.s	l34e42
		asr.w	#1,d3
		neg.w	d3
		moveq	#0,d5
	l34e50:	movea.l	a6,a3
		movea.w	(a0),a2
		jsr	0(a0,a2.w)
		add.w	d5,d4
		lea	-160(a6),a6
		add.w	a4,d3
		dbgt	d0,l34e50
		ble.s	l34e6e
		sub.w	a5,d3
		addq.w	#1,d4
		dbra	d0,l34e50
	l34e6e:	rts

	l34e70:	neg.w	d2
		move.w	d2,d0
		sub.w	d1,d3
		bmi.w	l34ef8
	l34e7a:	movea.w	d2,a4
		movea.w	d3,a5
		cmp.w	d2,d3
		bgt.s	l34ec0
		subq.w	#1,d0
		bmi.s	l34ebe
		asr.w	#1,d2
		neg.w	d2
		moveq	#0,d5
	l34e8c:	addq.w	#1,d5
		subq.w	#1,d4
		add.w	a5,d2
		ble.s	l34eae
		sub.w	a4,d2
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
		lea	160(a6),a6
		moveq	#0,d5
		dbra	d0,l34e8c
		rts

	l34eae:	dbra	d0,l34e8c
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34ebe:	rts

	l34ec0:	move.w	d3,d0
		subq.w	#1,d0
		bmi.s	l34ebe
		asr.w	#1,d3
		neg.w	d3
		moveq	#0,d5
	l34ecc:	movea.l	a6,a3
		movea.w	(a0),a2
		jsr	0(a0,a2.w)
		lea	160(a6),a6
		add.w	a4,d3
		dbgt	d0,l34ecc
		ble.s	l34ee8
		sub.w	a5,d3
		subq.w	#1,d4
		dbra	d0,l34ecc
	l34ee8:	rts

L34eea:
		tst.w	d2
		bpl.w	l34df4
		neg.w	d2
		move.w	d2,d0
		tst.w	d3
		bpl.s	l34e7a
	l34ef8:	neg.w	d3
		movea.w	d2,a4
		movea.w	d3,a5
		cmp.w	d2,d3
		bgt.s	l34f40
		subq.w	#1,d0
		bmi.s	l34f3e
		asr.w	#1,d2
		neg.w	d2
		moveq	#0,d5
	l34f0c:	addq.w	#1,d5
		subq.w	#1,d4
		add.w	a5,d2
		ble.s	l34f2e
		sub.w	a4,d2
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a6
		moveq	#0,d5
		dbra	d0,l34f0c
		rts

	l34f2e:	dbra	d0,l34f0c
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l34f3e:	rts

	l34f40:	move.w	d3,d0
		subq.w	#1,d0
		bmi.s	l34f3e
		asr.w	#1,d3
		neg.w	d3
		moveq	#0,d5
	l34f4c:	movea.l	a6,a3
		movea.w	(a0),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a6
		add.w	a4,d3
		dbgt	d0,l34f4c
		ble.s	l34f68
		sub.w	a5,d3
		subq.w	#1,d4
		dbra	d0,l34f4c
	l34f68:	rts

* draws unfilled circles?
L34f6a_DrawEllipse:
		lea	-50(a7),a7
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
		bsr.w	L37e22
		move.l	24(a7),d5
		swap	d5
		movea.l	L5da6_logscreen2,a6
		asl.w	#5,d5
		adda.w	d5,a6
		asl.w	#2,d5
		adda.w	d5,a6
	l34f92:	movem.l	12(a7),d0-3/d6-7/a2-3
		move.l	d2,d4
		move.l	d3,d5
		add.l	d6,d2
		add.l	d7,d3
		add.l	d0,d6
		add.l	d1,d7
		add.l	a2,d0
		add.l	a3,d1
		movem.l	d0-3/d6-7,12(a7)
		swap	d4
		swap	d5
		swap	d2
		swap	d3
		cmp.w	#$140,d4
		bcc.s	l34fe2
		cmp.w	#$a8,d5
		bcc.s	l34fe2
		cmp.w	#$140,d2
		bcc.s	l35006
		cmp.w	#$a8,d3
		bcc.s	l35006
		sub.w	d4,d2
		sub.w	d5,d3
		bsr.w	L34eea
		subq.w	#1,44(a7)
		bpl.s	l34f92
		lea	50(a7),a7
		rts

	l34fe2:	cmp.w	#$140,d2
		bcc.s	l34ffa
		cmp.w	#$a8,d3
		bcc.s	l34ffa
		move.w	d4,d0
		move.w	d5,d1
		bsr.w	L37c34
		bsr.w	L34d62_DrawStraightLine2
	l34ffa:	subq.w	#1,44(a7)
		bpl.s	l34f92
		lea	50(a7),a7
		rts

	l35006:	move.w	d2,d0
		move.w	d3,d1
		move.w	d4,d2
		move.w	d5,d3
		bsr.w	L37c34
		exg	d0,d2
		exg	d1,d3
		bsr.w	L34d62_DrawStraightLine2
		subq.w	#1,44(a7)
		bpl.w	l34f92
		lea	50(a7),a7
		rts

L35028:
		lea	-50(a7),a7
		bsr.w	L37e22
		movem.l	12(a7),d0-3/d6-7/a2-3
	l35036:	move.l	d2,d4
		move.l	d3,d5
		add.l	d6,d2
		add.l	d7,d3
		add.l	d0,d6
		add.l	d1,d7
		add.l	a2,d0
		add.l	a3,d1
		movem.l	d0-3/d6-7,12(a7)
		swap	d4
		swap	d5
		swap	d2
		swap	d3
		move.w	d4,d0
		move.w	d5,d1
		bsr.w	L350e2
		movem.l	12(a7),d0-3/d6-7
		subq.w	#1,44(a7)
		bpl.s	l35036
		lea	50(a7),a7
		rts

* makes 3702 byte stack frame. first 336 cleared
L3506e:
		movea.l	(a7)+,a5
		lea	-3366(a7),a7
		moveq	#0,d0
		moveq	#0,d1
		moveq	#0,d2
		moveq	#0,d3
		moveq	#0,d4
		moveq	#0,d5
		moveq	#0,d6
		moveq	#0,d7
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-7,-(a7)
		movem.l	d0-3,-(a7)
		movea.l	a7,a6
		move.w	#$a8,3698(a6)
		move.w	#$ffff,3700(a6)
		move.w	#$ffff,3696(a6)
		jmp	(a5)
	l350c6:	clr.w	3696(a6)
		bra.s	l350fa
	l350cc:	rts

	l350ce:	cmp.w	#$a9,d1
		bcs.s	l350da
		move.w	d1,d4
		eor.w	d3,d4
		bpl.s	l350cc
	l350da:	exg	d0,d2
		exg	d1,d3
	l350de:	bsr.w	L37d3e

L350e2:
		cmp.w	#$a9,d3
		bcc.s	l350ce
		cmp.w	#$a9,d1
		bcc.s	l350de
		cmp.w	#$140,d0
		bcc.s	l350c6
		cmp.w	#$140,d2
		bcc.s	l350c6
	l350fa:	cmp.w	d1,d3
		bpl.s	l35102
		exg	d0,d2
		exg	d1,d3
	l35102:	cmp.w	3700(a6),d3
		blt.s	l3510c
		move.w	d3,3700(a6)
	l3510c:	cmp.w	3698(a6),d1
		bgt.s	l35116
		move.w	d1,3698(a6)
	l35116:	sub.w	d1,d3
		move.w	d1,d4
		add.w	d4,d4
		lea	0(a6,d4.w),a1
		move.w	d0,d4
		move.w	d3,d0
		sub.w	d4,d2
		bmi.w	l351ba
		subq.w	#1,d0
		bmi.s	l35156
		movea.w	d2,a4
		movea.w	d3,a5
		cmp.w	d2,d3
		bgt.s	l35190
		asr.w	#1,d2
		cmp.w	d2,d3
		blt.s	l35158
		neg.w	d2
	l3513e:	addq.w	#1,d4
		add.w	a5,d2
		ble.s	l3513e
		sub.w	a4,d2
		move.w	(a1),d5
		addi.w	#$150,d5
		move.w	d4,0(a1,d5.w)
		move.w	d5,(a1)+
		dbra	d0,l3513e
	l35156:	rts

	l35158:	move.l	a4,d6
		divu	d3,d6
		move.w	d6,d3
		asr.w	#1,d3
		sub.w	d3,d4
		subq.w	#1,d6
		move.w	d6,d3
		move.w	a5,d7
		mulu	d7,d3
		move.w	d3,d7
		asr.w	#1,d7
		add.w	d7,d2
		neg.w	d2
	l35172:	add.w	d3,d2
		add.w	d6,d4
	l35176:	addq.w	#1,d4
		add.w	a5,d2
		ble.s	l35176
		sub.w	a4,d2
		move.w	(a1),d5
		addi.w	#$150,d5
		move.w	d4,0(a1,d5.w)
		move.w	d5,(a1)+
		dbra	d0,l35172
		rts

	l35190:	asr.w	#1,d3
		neg.w	d3
		add.w	a4,d3
		ble.s	l3519c
		sub.w	a5,d3
		addq.w	#1,d4
	l3519c:	move.w	(a1),d5
		addi.w	#$150,d5
		move.w	d4,0(a1,d5.w)
		move.w	d5,(a1)+
		add.w	a4,d3
		dbgt	d0,l3519c
		ble.s	l351b8
		sub.w	a5,d3
		addq.w	#1,d4
		dbra	d0,l3519c
	l351b8:	rts

	l351ba:	neg.w	d2
		subq.w	#1,d0
		bmi.s	l351e8
		movea.w	d2,a4
		movea.w	d3,a5
		cmp.w	d2,d3
		bgt.s	l35222
		asr.w	#1,d2
		cmp.w	d2,d3
		blt.s	l351ea
		neg.w	d2
	l351d0:	subq.w	#1,d4
		add.w	a5,d2
		ble.s	l351d0
		sub.w	a4,d2
		move.w	(a1),d5
		addi.w	#$150,d5
		move.w	d4,0(a1,d5.w)
		move.w	d5,(a1)+
		dbra	d0,l351d0
	l351e8:	rts

	l351ea:	move.l	a4,d6
		divu	d3,d6
		move.w	d6,d3
		asr.w	#1,d3
		add.w	d3,d4
		subq.w	#1,d6
		move.w	d6,d3
		move.w	a5,d7
		mulu	d7,d3
		move.w	d3,d7
		asr.w	#1,d7
		add.w	d7,d2
		neg.w	d2
	l35204:	add.w	d3,d2
		sub.w	d6,d4
	l35208:	subq.w	#1,d4
		add.w	a5,d2
		ble.s	l35208
		sub.w	a4,d2
		move.w	(a1),d5
		addi.w	#$150,d5
		move.w	d4,0(a1,d5.w)
		move.w	d5,(a1)+
		dbra	d0,l35204
		rts

	l35222:	asr.w	#1,d3
		neg.w	d3
		add.w	a4,d3
		ble.s	l3522e
		sub.w	a5,d3
		subq.w	#1,d4
	l3522e:	move.w	(a1),d5
		addi.w	#$150,d5
		move.w	d4,0(a1,d5.w)
		move.w	d5,(a1)+
		add.w	a4,d3
		dbgt	d0,l3522e
		ble.s	l3524a
		sub.w	a5,d3
		subq.w	#1,d4
		dbra	d0,l3522e
	l3524a:	rts

L3524c_DrawCurvybit:
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
		move.w	3704(a7),d0
		subq.w	#1,d0
		bmi.w	L35364
		move.w	d0,d1
		add.w	d1,d1
		lea	6(a7,d1.w),a5
		move.w	d0,d1
		movea.l	L5da6_logscreen2,a6
		asl.w	#5,d1
		adda.w	d1,a6
		asl.w	#2,d1
		adda.w	d1,a6
		tst.w	3700(a7)
		beq.w	l3536c
		move.w	-(a5),d3
		beq.s	l352b4
	l35286:	move.w	A5_RedrawMouse(a5),d4
		move.w	672(a5),d5
		cmp.w	d4,d5
		bgt.s	l35294
		exg	d4,d5
	l35294:	cmp.w	#$2a0,d3
		bgt.s	l352be

L3529a:
		sub.w	d4,d5
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l352a8:	lea	-160(a6),a6
		move.w	-(a5),d3
		dbeq	d0,l35286
		subq.w	#1,d0
	l352b4:	cmp.w	3702(a7),d0
		bgt.s	l352a8
		bra.w	L35364
	l352be:	move.w	1008(a5),d6
		move.w	1344(a5),d7
		cmp.w	d4,d6
		ble.s	l352d0
		cmp.w	d5,d6
		ble.s	l352d2
		bra.s	l352d4
	l352d0:	exg	d4,d6
	l352d2:	exg	d5,d6
	l352d4:	cmp.w	d4,d7
		ble.s	l352e2
		cmp.w	d5,d7
		ble.s	l352e4
		cmp.w	d6,d7
		ble.s	l352e6
		bra.s	l352e8
	l352e2:	exg	d4,d7
	l352e4:	exg	d5,d7
	l352e6:	exg	d6,d7
	l352e8:	cmp.w	#$540,d3
		bgt.s	l35308
		movem.w	d6-7,-(a7)

L352f2:
		sub.w	d4,d5
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
		movem.w	(a7)+,d4-5
		bra.w	L3529a
	l35308:	move.w	1680(a5),d1
		move.w	2016(a5),d2
		cmp.w	d4,d1
		ble.s	l35322
		cmp.w	d5,d1
		ble.s	l35324
		cmp.w	d6,d1
		ble.s	l35326
		cmp.w	d7,d1
		ble.s	l35328
		bra.s	l3532a
	l35322:	exg	d4,d1
	l35324:	exg	d5,d1
	l35326:	exg	d6,d1
	l35328:	exg	d7,d1
	l3532a:	cmp.w	d4,d2
		ble.s	l35340
		cmp.w	d5,d2
		ble.s	l35342
		cmp.w	d6,d2
		ble.s	l35344
		cmp.w	d7,d2
		ble.s	l35346
		cmp.w	d1,d2
		ble.s	l35348
		bra.s	l3534a
	l35340:	exg	d4,d2
	l35342:	exg	d5,d2
	l35344:	exg	d6,d2
	l35346:	exg	d7,d2
	l35348:	exg	d1,d2
	l3534a:	movem.w	d6-7/d1-2,-(a7)
		sub.w	d4,d5
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
		movem.w	(a7)+,d4-5
		bra.w	L352f2

L35364:
		movea.l	(a7)+,a6
		lea	3702(a7),a7
		jmp	(a6)
	l3536c:	move.w	-(a5),d3
		beq.s	l353b8
	l35370:	move.w	A5_RedrawMouse(a5),d4
		move.w	672(a5),d5
		cmp.w	d4,d5
		bgt.s	l3537e
		exg	d4,d5
	l3537e:	cmp.w	#$2a0,d3
		bgt.s	l353c2

L35384:
		cmp.w	#$140,d4
		bcs.s	l35390
		tst.w	d4
		bpl.s	l353ac
		moveq	#0,d4
	l35390:	cmp.w	#$141,d5
		bcs.s	l3539e
		tst.w	d5
		bmi.s	l353ac
		move.w	#$140,d5
	l3539e:	sub.w	d4,d5
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l353ac:	lea	-160(a6),a6
		move.w	-(a5),d3
		dbeq	d0,l35370
		subq.w	#1,d0
	l353b8:	cmp.w	3702(a7),d0
		bgt.s	l353ac
		bra.w	L35364
	l353c2:	move.w	1008(a5),d6
		move.w	1344(a5),d7
		cmp.w	d4,d6
		ble.s	l353d4
		cmp.w	d5,d6
		ble.s	l353d6
		bra.s	l353d8
	l353d4:	exg	d4,d6
	l353d6:	exg	d5,d6
	l353d8:	cmp.w	d4,d7
		ble.s	l353e6
		cmp.w	d5,d7
		ble.s	l353e8
		cmp.w	d6,d7
		ble.s	l353ea
		bra.s	l353ec
	l353e6:	exg	d4,d7
	l353e8:	exg	d5,d7
	l353ea:	exg	d6,d7
	l353ec:	cmp.w	#$540,d3
		bgt.s	l35426
		movem.w	d6-7,-(a7)

L353f6:
		cmp.w	#$140,d4
		bcs.s	l35402
		tst.w	d4
		bpl.s	l3541e
		moveq	#0,d4
	l35402:	cmp.w	#$141,d5
		bcs.s	l35410
		tst.w	d5
		bmi.s	l3541e
		move.w	#$140,d5
	l35410:	sub.w	d4,d5
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l3541e:	movem.w	(a7)+,d4-5
		bra.w	L35384
	l35426:	move.w	1680(a5),d1
		move.w	2016(a5),d2
		cmp.w	d4,d1
		ble.s	l35440
		cmp.w	d5,d1
		ble.s	l35442
		cmp.w	d6,d1
		ble.s	l35444
		cmp.w	d7,d1
		ble.s	l35446
		bra.s	l35448
	l35440:	exg	d4,d1
	l35442:	exg	d5,d1
	l35444:	exg	d6,d1
	l35446:	exg	d7,d1
	l35448:	cmp.w	d4,d2
		ble.s	l3545e
		cmp.w	d5,d2
		ble.s	l35460
		cmp.w	d6,d2
		ble.s	l35462
		cmp.w	d7,d2
		ble.s	l35464
		cmp.w	d1,d2
		ble.s	l35466
		bra.s	l35468
	l3545e:	exg	d4,d2
	l35460:	exg	d5,d2
	l35462:	exg	d6,d2
	l35464:	exg	d7,d2
	l35466:	exg	d1,d2
	l35468:	movem.w	d6-7/d1-2,-(a7)
		cmp.w	#$140,d4
		bcs.s	l35478
		tst.w	d4
		bpl.s	l35494
		moveq	#0,d4
	l35478:	cmp.w	#$141,d5
		bcs.s	l35486
		tst.w	d5
		bmi.s	l35494
		move.w	#$140,d5
	l35486:	sub.w	d4,d5
		movea.l	a6,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
	l35494:	movem.w	(a7)+,d4-5
		bra.w	L353f6
	l3549c:	rts

* d0=x_dest, d1=y_dest, a0=bmp (which starts with 2 words: width, height)
L3549e_BlitBmpToBothBuffers:
		movem.l	a0/d0-1,-(a7)
		jsr	L42452_RedrawUnderMouse
		jsr	L41b8c_PhysToLog2
		jsr	N354da_BlitBmp
		jsr	L41b80_LogToLog2
		movem.l	(a7)+,d0-1/a0
		jsr	N354da_BlitBmp
		jsr	L423d2_DrawMouse1
		rts

galaxy_color_table:
		dc.b	0,1,1,1,1,1,1,1,2,2,2,2,3,3,3,3
		dc.b	4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7
		dc.b	8,8,8,8,9,9,9,9,15,15,15,15,10,10,10,10
		dc.b	11,11,11,11,11,11,11,11,11,11,11,11,11
		dc.b	11,11,11

L35886_obsolete:
		rts

L3588c:
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
		rts

* Appears to be only used by the galaxy map (point plotty thing)
L3589a_ReturnScrLineInA6:
		movea.l	L5da6_logscreen2,a6
		asl.w	#6,d0
		adda.w	d0,a6
		ext.l	d0
		asl.l	#2,d0
		adda.l	d0,a6
		rts

L358aa:
		lea	21574(a6),a1
		add.w	d0,d0
		eor.w	d1,0(a1,d0.w)
		rts

L358b6:
		movea.l	(a7)+,a5
		lea	-21912(a7),a7
		movea.l	a7,a6
		lea	21910(a6),a1
		lea	70(a6),a2
		moveq	#0,d0
		moveq	#0,d1
		moveq	#0,d2
		moveq	#0,d3
		moveq	#20,d4
	l358d0:	move.w	d0,(a2)
		movem.l	d0-3,-(a1)
		move.w	d0,128(a2)
		move.w	d0,256(a2)
		move.w	d0,384(a2)
		move.w	d0,512(a2)
		move.w	d0,640(a2)
		move.w	d0,768(a2)
		move.w	d0,896(a2)
		lea	1024(a2),a2
		dbra	d4,l358d0
		move.w	#$a8,0(a6)
		move.w	#$ffff,2(a6)
		jmp	(a5)
	l35908:	rts

	l3590a:	cmp.w	#$a9,d1
		bcs.s	l35916
		move.w	d1,d4
		eor.w	d3,d4
		bpl.s	l35908
	l35916:	exg	d0,d2
		exg	d1,d3
	l3591a:	bsr.w	L37d3e

L3591e:
		cmp.w	#$a9,d3
		bcc.s	l3590a
		cmp.w	#$a9,d1
		bcc.s	l3591a
		cmp.w	d1,d3
		bpl.s	l35932
		exg	d0,d2
		exg	d1,d3
	l35932:	cmp.w	2(a6),d3
		blt.s	l3593c
		move.w	d3,2(a6)
	l3593c:	cmp.w	0(a6),d1
		bgt.s	l35946
		move.w	d1,0(a6)
	l35946:	sub.w	d1,d3
		move.w	d1,d4
		asl.w	#7,d4
		lea	70(a6,d4.w),a1
		move.w	d0,d4
		move.w	d3,d0
		sub.w	d4,d2
		bmi.w	l35a40
		subq.w	#1,d0
		bmi.s	l359a4
		movea.w	d2,a4
		movea.w	d3,a5
		cmp.w	d2,d3
		bgt.w	l359fa
		asr.w	#1,d2
		cmp.w	d2,d3
		blt.s	l359a6
		neg.w	d2
	l35970:	addq.w	#1,d4
		add.w	a5,d2
		ble.s	l35970
		sub.w	a4,d2
		move.w	(a1),d5
		beq.s	l35992
		cmp.w	#$7c,d5
		bge.s	l3599c
	l35982:	move.l	-2(a1,d5.w),d1
		cmp.w	d1,d4
		bge.s	l35992
		move.l	d1,2(a1,d5.w)
		subq.w	#4,d5
		bgt.s	l35982
	l35992:	move.w	a0,2(a1,d5.w)
		move.w	d4,4(a1,d5.w)
		addq.w	#4,(a1)
	l3599c:	lea	128(a1),a1
		dbra	d0,l35970
	l359a4:	rts

	l359a6:	move.l	a4,d6
		divu	d3,d6
		move.w	d6,d3
		asr.w	#1,d3
		sub.w	d3,d4
		subq.w	#1,d6
		move.w	d6,d3
		move.w	a5,d7
		mulu	d7,d3
		move.w	d3,d7
		asr.w	#1,d7
		add.w	d7,d2
		neg.w	d2
	l359c0:	add.w	d3,d2
		add.w	d6,d4
	l359c4:	addq.w	#1,d4
		add.w	a5,d2
		ble.s	l359c4
		sub.w	a4,d2
		move.w	(a1),d5
		beq.s	l359e6
		cmp.w	#$7c,d5
		bge.s	l359f0
	l359d6:	move.l	-2(a1,d5.w),d1
		cmp.w	d1,d4
		bge.s	l359e6
		move.l	d1,2(a1,d5.w)
		subq.w	#4,d5
		bgt.s	l359d6
	l359e6:	move.w	a0,2(a1,d5.w)
		move.w	d4,4(a1,d5.w)
		addq.w	#4,(a1)
	l359f0:	lea	128(a1),a1
		dbra	d0,l359c0
		rts

	l359fa:	asr.w	#1,d3
		neg.w	d3
		add.w	a4,d3
		ble.s	l35a06
		sub.w	a5,d3
		addq.w	#1,d4
	l35a06:	move.w	(a1),d5
		beq.s	l35a20
		cmp.w	#$7c,d5
		bge.s	l35a2a
	l35a10:	move.l	-2(a1,d5.w),d1
		cmp.w	d1,d4
		bge.s	l35a20
		move.l	d1,2(a1,d5.w)
		subq.w	#4,d5
		bgt.s	l35a10
	l35a20:	move.w	a0,2(a1,d5.w)
		move.w	d4,4(a1,d5.w)
		addq.w	#4,(a1)
	l35a2a:	lea	128(a1),a1
		add.w	a4,d3
		dbgt	d0,l35a06
		ble.s	l35a3e
		sub.w	a5,d3
		addq.w	#1,d4
		dbra	d0,l35a06
	l35a3e:	rts

	l35a40:	neg.w	d2
		subq.w	#1,d0
		bmi.s	l35a8c
		movea.w	d2,a4
		movea.w	d3,a5
		cmp.w	d2,d3
		bgt.w	l35ae2
		asr.w	#1,d2
		cmp.w	d2,d3
		blt.s	l35a8e
		neg.w	d2
	l35a58:	subq.w	#1,d4
		add.w	a5,d2
		ble.s	l35a58
		sub.w	a4,d2
		move.w	(a1),d5
		beq.s	l35a7a
		cmp.w	#$7c,d5
		bge.s	l35a84
	l35a6a:	move.l	-2(a1,d5.w),d1
		cmp.w	d1,d4
		bge.s	l35a7a
		move.l	d1,2(a1,d5.w)
		subq.w	#4,d5
		bgt.s	l35a6a
	l35a7a:	move.w	a0,2(a1,d5.w)
		move.w	d4,4(a1,d5.w)
		addq.w	#4,(a1)
	l35a84:	lea	128(a1),a1
		dbra	d0,l35a58
	l35a8c:	rts

	l35a8e:	move.l	a4,d6
		divu	d3,d6
		move.w	d6,d3
		asr.w	#1,d3
		add.w	d3,d4
		subq.w	#1,d6
		move.w	d6,d3
		move.w	a5,d7
		mulu	d7,d3
		move.w	d3,d7
		asr.w	#1,d7
		add.w	d7,d2
		neg.w	d2
	l35aa8:	add.w	d3,d2
		sub.w	d6,d4
	l35aac:	subq.w	#1,d4
		add.w	a5,d2
		ble.s	l35aac
		sub.w	a4,d2
		move.w	(a1),d5
		beq.s	l35ace
		cmp.w	#$7c,d5
		bge.s	l35ad8
	l35abe:	move.l	-2(a1,d5.w),d1
		cmp.w	d1,d4
		bge.s	l35ace
		move.l	d1,2(a1,d5.w)
		subq.w	#4,d5
		bgt.s	l35abe
	l35ace:	move.w	a0,2(a1,d5.w)
		move.w	d4,4(a1,d5.w)
		addq.w	#4,(a1)
	l35ad8:	lea	128(a1),a1
		dbra	d0,l35aa8
		rts

	l35ae2:	asr.w	#1,d3
		neg.w	d3
		add.w	a4,d3
		ble.s	l35aee
		sub.w	a5,d3
		subq.w	#1,d4
	l35aee:	move.w	(a1),d5
		beq.s	l35b08
		cmp.w	#$7c,d5
		bge.s	l35b12
	l35af8:	move.l	-2(a1,d5.w),d1
		cmp.w	d1,d4
		bge.s	l35b08
		move.l	d1,2(a1,d5.w)
		subq.w	#4,d5
		bgt.s	l35af8
	l35b08:	move.w	a0,2(a1,d5.w)
		move.w	d4,4(a1,d5.w)
		addq.w	#4,(a1)
	l35b12:	lea	128(a1),a1
		add.w	a4,d3
		dbgt	d0,l35aee
		ble.s	l35b26
		sub.w	a5,d3
		subq.w	#1,d4
		dbra	d0,l35aee
	l35b26:	rts

* this thing draws planets :-,
* mangled grotesquely for new linefuncs. we no longer need to
* find line functions for each colour so we just push the
* colours themselves, and set col in draw loop.
L35b28_DrawPlanet:
		movea.l	(a7)+,a4
		*lea	L33684_hlinefunc_table(pc),a1
		*move.l	0(a1,d0.w),d0
		*move.l	0(a1,d1.w),d1
		*move.l	0(a1,d2.w),d2
		*move.l	0(a1,d3.w),d3
		*move.l	0(a1,d4.w),d4
		*move.l	0(a1,d5.w),d5
		*move.l	0(a1,d6.w),d6
		*move.l	0(a1,d7.w),d7
		movem.l	d0-7,52(a7)
		movem.w	(a7)+,d0-7
		move.l	a4,-(a7)
	* Jumped to in a very rank way when drawing stars
L35b5e:
		lea	new_linecrap,a0
		*lea	L33684_hlinefunc_table(pc),a1
		*move.l	0(a1,d0.w),d0
		*move.l	0(a1,d1.w),d1
		*move.l	0(a1,d2.w),d2
		*move.l	0(a1,d3.w),d3
		*move.l	0(a1,d4.w),d4
		*move.l	0(a1,d5.w),d5
		*move.l	0(a1,d6.w),d6
		*move.l	0(a1,d7.w),d7
		movem.l	d0-7,8(a7)
		move.w	6(a7),d0
		subq.w	#1,d0
		bmi.w	l35c32
		move.w	d0,d1
		asl.w	#7,d1
		lea	74(a7,d1.w),a5
		lea	21578(a7),a4
		move.w	334(a4),72(a7)
		move.w	d0,d1
		add.w	d1,d1
		lea	2(a4,d1.w),a4
		move.w	d0,d1
		cmp.w	#$a7,d1
		blt.s	l35bbe
		move.w	#$0,72(a7)
	l35bbe:	movea.l	L5da6_logscreen2,a6
		asl.w	#6,d1
		adda.w	d1,a6
		ext.l	d1
		asl.l	#2,d1
		adda.l	d1,a6
	l35bcc:	move.w	-(a4),d2
		move.w	72(a7),d7
		eor.w	d2,72(a7)
		move.w	(a5),d3
		beq.s	l35c26
		lsr.w	#2,d3
		subq.w	#1,d3
		move.l	a5,-(a7)
	l35be0:	addq.l	#2,a5
		eor.w	d7,d2
		move.w	(a5)+,d7
		dbeq	d3,l35be0
		bne.s	l35c24
	l35bec:	move.w	(a5)+,d4
		bpl.s	l35bf2
		moveq	#0,d4
	l35bf2:	cmp.w	#$140,d4
		bge.s	l35c24
		move.w	2(a5),d5
		bmi.s	l35c1a
		cmp.w	#$140,d5
		blt.s	l35c08
		move.w	#$140,d5
	l35c08:	sub.w	d4,d5
		movea.l	a6,a3
		move.l	12(a7,d2.w),d1
		hcall	#Call_HLine
	l35c1a:	move.w	(a5)+,d7
		beq.s	l35c24
		eor.w	d7,d2
		dbra	d3,l35bec
	l35c24:	movea.l	(a7)+,a5
	l35c26:	lea	-128(a5),a5
		lea	-320(a6),a6
		dbra	d0,l35bcc
	l35c32:	movea.l	(a7)+,a6
		lea	21912(a7),a7
		jmp	(a6)

L35c3a:
		lea	-50(a7),a7
		bsr.w	L37e22
		movem.l	12(a7),d0-3/d6-7/a2-3
	l35c48:	move.l	d2,d4
		move.l	d3,d5
		add.l	d6,d2
		add.l	d7,d3
		add.l	d0,d6
		add.l	d1,d7
		add.l	a2,d0
		add.l	a3,d1
		movem.l	d0-3/d6-7,12(a7)
		swap	d4
		swap	d5
		swap	d2
		swap	d3
		move.w	d4,d0
		move.w	d5,d1
		bsr.w	L3591e
		movem.l	12(a7),d0-3/d6-7
		subq.w	#1,44(a7)
		bpl.s	l35c48
		lea	50(a7),a7
		rts

L35c80_DrawScannerLines:
		movem.l	a5-6,-(a7)
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
		tst.w	d2
		bmi.s	l35d02
		subq.w	#1,d0
		move.w	d0,d4
		move.w	d1,d7
		subi.w	#$a7,d7
		movea.l	L5da6_logscreen2,a6
		asl.w	#5,d1
		adda.w	d1,a6
		asl.w	#2,d1
		adda.w	d1,a6
		subq.w	#1,d2
		bmi.s	l35cd4
	l35cb0:	movea.l	a6,a3
		moveq	#4,d5
		movea.w	4(a0),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a6
		subq.w	#1,d7
		dbeq	d2,l35cb0
		bne.s	l35cd4
		tst.w	d3
		bne.s	l35cfc
		* colour 15 (15<<2)
		move.w	#60,line_draw_col
		dbra	d2,l35cb0
	l35cd4:	movea.l	a6,a3
		moveq	#8,d5
		movea.w	8(a0),a2
		jsr	0(a0,a2.w)
		subq.w	#1,d7
		bne.s	l35cec
		tst.w	d3
		bne.s	l35cfc
		* colour 15 (15<<2)
		move.w	#60,line_draw_col
	l35cec:	lea	-160(a6),a6
		movea.l	a6,a3
		moveq	#8,d5
		movea.w	8(a0),a2
		jsr	0(a0,a2.w)
	l35cfc:	movem.l	(a7)+,a5-6
		rts

	l35d02:	neg.w	d2
		addq.w	#1,d2
		movem.w	d0-2,-(a7)
		bsr.s	L35d20
		movem.w	(a7)+,d0-2
		add.w	d2,d1
		subq.w	#1,d1
		addq.w	#2,d0
		moveq	#1,d2
		bsr.s	L35d20
		movem.l	(a7)+,a5-6
		rts

	L35d20:
		move.w	d1,d4
		add.w	d2,d4
		subi.w	#$c6,d4
		bcs.s	l35d2e
		sub.w	d4,d2
		bmi.s	l35d80
	l35d2e:	move.w	d1,d3
		move.w	d0,d4
		movea.l	L5da6_logscreen2,a6
		asl.w	#5,d3
		adda.w	d3,a6
		asl.w	#2,d3
		adda.w	d3,a6
		andi.w	#$fff0,d4
		lsr.w	#1,d4
		adda.w	d4,a6
		andi.w	#$f,d0
		bne.s	l35d5e
		moveq	#1,d7
		movem.l	a6/a0/d2/d0,-(a7)
		lea	-8(a6),a6
		bsr.s	L35d64
		movem.l	(a7)+,d0/d2/a0/a6
	l35d5e:	add.w	d0,d0
		move.w	L35d82_scanner_draw_mask(pc,d0.w),d7

	L35d64:
		* Draw scanner 'below-plane' lines
		move.w	d0,d6
		move.w	6(a6),d6
		not.w	d6
		and.w	d7,d6
		movea.l	a6,a3
		* this is BackHLine
		move.w	642(a0),d3
		jsr	0(a0,d3.w)
		lea	160(a6),a6
		dbra	d2,L35d64
	l35d80:	rts

L35d82_scanner_draw_mask:
		dc.b	$80,$0,$c0,$0,$60,$0,$30,$0,$18,$0,$c,$0,$6,$0,$3,$0
		dc.b	$1,$80,$0,$c0,$0,$60,$0,$30,$0,$18,$0,$c,$0,$6,$0,$3

L35da2:
		muls	d2,d0
		muls	d2,d1
		add.l	d0,d0
		swap	d0
		add.l	d1,d1
		swap	d1
		tst.w	d0
		bpl.s	l35dbe
	l35db2:	cmp.w	#$e100,d0
		bgt.s	l35dca
		asr.w	#1,d0
		asr.w	#1,d1
		bra.s	l35db2
	l35dbe:	cmp.w	#$1f00,d0
		blt.s	l35dca
		asr.w	#1,d0
		asr.w	#1,d1
		bra.s	l35dbe
	l35dca:	tst.w	d1
		bpl.s	l35dda
	l35dce:	cmp.w	#$e100,d1
		bgt.s	l35de6
		asr.w	#1,d0
		asr.w	#1,d1
		bra.s	l35dce
	l35dda:	cmp.w	#$1f00,d1
		blt.s	l35de6
		asr.w	#1,d0
		asr.w	#1,d1
		bra.s	l35dda
	l35de6:	rts

L35de8:
		muls	d2,d0
		muls	d2,d1
		swap	d0
		asr.w	#1,d0
		swap	d1
		asr.w	#1,d1
		tst.w	d0
		bpl.s	l35e04
	l35df8:	cmp.w	#$e100,d0
		bgt.s	l35e10
		asr.w	#1,d0
		asr.w	#1,d1
		bra.s	l35df8
	l35e04:	cmp.w	#$1f00,d0
		blt.s	l35e10
		asr.w	#1,d0
		asr.w	#1,d1
		bra.s	l35e04
	l35e10:	tst.w	d1
		bpl.s	l35e20
	l35e14:	cmp.w	#$e100,d1
		bgt.s	l35e2c
		asr.w	#1,d0
		asr.w	#1,d1
		bra.s	l35e14
	l35e20:	cmp.w	#$1f00,d1
		blt.s	l35e2c
		asr.w	#1,d0
		asr.w	#1,d1
		bra.s	l35e20
	l35e2c:	rts

	l35e2e:	tst.l	d0
		bmi.s	l35e4a
		cmp.l	#$8000,d0
		bcs.s	l35eac
	l35e3a:	asr.l	#2,d0
		asr.l	#2,d1
		asr.l	#2,d2
		cmp.l	#$8000,d0
		bcc.s	l35e3a
		bra.s	l35eac
	l35e4a:	cmp.l	#$ffff8000,d0
		bcc.s	l35eac
	l35e52:	asr.l	#2,d0
		asr.l	#2,d1
		asr.l	#2,d2
		cmp.l	#$ffff8000,d0
		bcs.s	l35e52
		bra.s	l35eac
	l35e62:	neg.l	d2
		cmp.l	d1,d2
		bcs.s	l35eb8
		neg.l	d2
		cmp.l	d1,d2
		bcc.s	l35eba
	l35e6e:	tst.l	d1
		bmi.s	l35e8a
		cmp.l	#$8000,d1
		bcs.s	l35eba
	l35e7a:	asr.l	#2,d0
		asr.l	#2,d1
		asr.l	#2,d2
		cmp.l	#$8000,d1
		bcc.s	l35e7a
		bra.s	l35eba
	l35e8a:	cmp.l	#$ffff8000,d1
		bcc.s	l35eba
	l35e92:	asr.l	#2,d0
		asr.l	#2,d1
		asr.l	#2,d2
		cmp.l	#$ffff8000,d1
		bcs.s	l35e92
		bra.s	l35eba

L35ea2_ZProject:
	*	hcall	#$15
	*	rts

		cmp.l	d0,d2
		bcc.s	l35e62
		neg.l	d2
		cmp.l	d0,d2
		bcc.w	l35e2e
	l35eac:	cmp.l	d1,d2
		bcs.s	l35eb8
		neg.l	d2
		cmp.l	d1,d2
		bcs.s	l35e6e
		neg.l	d2
	l35eb8:	neg.l	d2
	l35eba:	cmp.l	#$4000,d2
		bcc.s	l35f00
		cmp.w	#$1000,d2
		bcc.s	l35ee4
		cmp.w	#$400,d2
		bcc.s	l35ed8
		add.w	d2,d2
		move.w	L35f1e_div_table(pc,d2.w),d2
		bra.w	L35da2
	l35ed8:	lsr.w	#2,d2
		add.w	d2,d2
		move.w	L35f1e_div_table(pc,d2.w),d2
		bra.w	L35de8
	l35ee4:	lsr.w	#4,d2
		add.w	d2,d2
		move.w	L35f1e_div_table(pc,d2.w),d2
		muls	d2,d0
		muls	d2,d1
		swap	d0
		asr.w	#3,d0
		swap	d1
		asr.w	#3,d1
		rts

	l35efa:	asr.l	#1,d0
		asr.l	#1,d1
		asr.l	#1,d2
	l35f00:	cmp.l	#$8000,d2
		bcc.s	l35efa
		lsr.w	#6,d2
		add.w	d2,d2
		move.w	L35f1e_div_table(pc,d2.w),d2
		muls	d2,d0
		muls	d2,d1
		swap	d0
		asr.w	#5,d0
		swap	d1
		asr.w	#5,d1
		rts

L35f1e_div_table:
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff,$7f,$ff
		dc.b	$7f,$ff,$7f,$80,$7f,$1,$7e,$84,$7e,$7,$7d,$8c,$7d,$11,$7c,$97
		dc.b	$7c,$1f,$7b,$a7,$7b,$30,$7a,$ba,$7a,$44,$79,$d0,$79,$5c,$78,$ea
		dc.b	$78,$78,$78,$7,$77,$97,$77,$28,$76,$b9,$76,$4b,$75,$de,$75,$72
		dc.b	$75,$7,$74,$9c,$74,$32,$73,$c9,$73,$61,$72,$f9,$72,$92,$72,$2c
		dc.b	$71,$c7,$71,$62,$70,$fe,$70,$9a,$70,$38,$6f,$d6,$6f,$74,$6f,$13
		dc.b	$6e,$b3,$6e,$54,$6d,$f5,$6d,$97,$6d,$3a,$6c,$dd,$6c,$80,$6c,$25
		dc.b	$6b,$ca,$6b,$6f,$6b,$15,$6a,$bc,$6a,$63,$6a,$b,$69,$b4,$69,$5d
		dc.b	$69,$6,$68,$b0,$68,$5b,$68,$6,$67,$b2,$67,$5e,$67,$b,$66,$b8
		dc.b	$66,$66,$66,$14,$65,$c3,$65,$72,$65,$22,$64,$d3,$64,$83,$64,$35
		dc.b	$63,$e7,$63,$99,$63,$4c,$62,$ff,$62,$b2,$62,$67,$62,$1b,$61,$d0
		dc.b	$61,$86,$61,$3c,$60,$f2,$60,$a9,$60,$60,$60,$18,$5f,$d0,$5f,$88
		dc.b	$5f,$41,$5e,$fa,$5e,$b4,$5e,$6e,$5e,$29,$5d,$e4,$5d,$9f,$5d,$5b
		dc.b	$5d,$17,$5c,$d3,$5c,$90,$5c,$4d,$5c,$b,$5b,$c9,$5b,$87,$5b,$46
		dc.b	$5b,$5,$5a,$c5,$5a,$84,$5a,$45,$5a,$5,$59,$c6,$59,$87,$59,$49
		dc.b	$59,$b,$58,$cd,$58,$8f,$58,$52,$58,$16,$57,$d9,$57,$9d,$57,$61
		dc.b	$57,$26,$56,$ea,$56,$b0,$56,$75,$56,$3b,$56,$1,$55,$c7,$55,$8e
		dc.b	$55,$55,$55,$1c,$54,$e4,$54,$ab,$54,$74,$54,$3c,$54,$5,$53,$ce
		dc.b	$53,$97,$53,$61,$53,$2a,$52,$f4,$52,$bf,$52,$89,$52,$54,$52,$20
		dc.b	$51,$eb,$51,$b7,$51,$83,$51,$4f,$51,$1b,$50,$e8,$50,$b5,$50,$82
		dc.b	$50,$50,$50,$1e,$4f,$ec,$4f,$ba,$4f,$88,$4f,$57,$4f,$26,$4e,$f5
		dc.b	$4e,$c4,$4e,$94,$4e,$64,$4e,$34,$4e,$4,$4d,$d5,$4d,$a6,$4d,$77
		dc.b	$4d,$48,$4d,$19,$4c,$eb,$4c,$bd,$4c,$8f,$4c,$61,$4c,$34,$4c,$7
		dc.b	$4b,$da,$4b,$ad,$4b,$80,$4b,$54,$4b,$27,$4a,$fb,$4a,$d0,$4a,$a4
		dc.b	$4a,$79,$4a,$4d,$4a,$22,$49,$f7,$49,$cd,$49,$a2,$49,$78,$49,$4e
		dc.b	$49,$24,$48,$fa,$48,$d1,$48,$a8,$48,$7e,$48,$55,$48,$2d,$48,$4
		dc.b	$47,$dc,$47,$b3,$47,$8b,$47,$63,$47,$3c,$47,$14,$46,$ed,$46,$c5
		dc.b	$46,$9e,$46,$78,$46,$51,$46,$2a,$46,$4,$45,$de,$45,$b8,$45,$92
		dc.b	$45,$6c,$45,$46,$45,$21,$44,$fc,$44,$d7,$44,$b2,$44,$8d,$44,$68
		dc.b	$44,$44,$44,$1f,$43,$fb,$43,$d7,$43,$b3,$43,$90,$43,$6c,$43,$49
		dc.b	$43,$25,$43,$2,$42,$df,$42,$bc,$42,$9a,$42,$77,$42,$54,$42,$32
		dc.b	$42,$10,$41,$ee,$41,$cc,$41,$aa,$41,$89,$41,$67,$41,$46,$41,$25
		dc.b	$41,$4,$40,$e3,$40,$c2,$40,$a1,$40,$81,$40,$60,$40,$40,$40,$20
		dc.b	$40,$0,$3f,$e0,$3f,$c0,$3f,$a0,$3f,$80,$3f,$61,$3f,$42,$3f,$23
		dc.b	$3f,$3,$3e,$e4,$3e,$c6,$3e,$a7,$3e,$88,$3e,$6a,$3e,$4b,$3e,$2d
		dc.b	$3e,$f,$3d,$f1,$3d,$d3,$3d,$b5,$3d,$98,$3d,$7a,$3d,$5d,$3d,$3f
		dc.b	$3d,$22,$3d,$5,$3c,$e8,$3c,$cb,$3c,$ae,$3c,$91,$3c,$75,$3c,$58
		dc.b	$3c,$3c,$3c,$1f,$3c,$3,$3b,$e7,$3b,$cb,$3b,$af,$3b,$94,$3b,$78
		dc.b	$3b,$5c,$3b,$41,$3b,$25,$3b,$a,$3a,$ef,$3a,$d4,$3a,$b9,$3a,$9e
		dc.b	$3a,$83,$3a,$68,$3a,$4e,$3a,$33,$3a,$19,$39,$ff,$39,$e4,$39,$ca
		dc.b	$39,$b0,$39,$96,$39,$7c,$39,$63,$39,$49,$39,$2f,$39,$16,$38,$fc
		dc.b	$38,$e3,$38,$ca,$38,$b1,$38,$98,$38,$7f,$38,$66,$38,$4d,$38,$34
		dc.b	$38,$1c,$38,$3,$37,$eb,$37,$d2,$37,$ba,$37,$a2,$37,$89,$37,$71
		dc.b	$37,$59,$37,$42,$37,$2a,$37,$12,$36,$fa,$36,$e3,$36,$cb,$36,$b4
		dc.b	$36,$9d,$36,$85,$36,$6e,$36,$57,$36,$40,$36,$29,$36,$12,$35,$fb
		dc.b	$35,$e5,$35,$ce,$35,$b7,$35,$a1,$35,$8a,$35,$74,$35,$5e,$35,$48
		dc.b	$35,$31,$35,$1b,$35,$5,$34,$ef,$34,$da,$34,$c4,$34,$ae,$34,$98
		dc.b	$34,$83,$34,$6d,$34,$58,$34,$42,$34,$2d,$34,$18,$34,$3,$33,$ee
		dc.b	$33,$d9,$33,$c4,$33,$af,$33,$9a,$33,$85,$33,$70,$33,$5c,$33,$47
		dc.b	$33,$33,$33,$1e,$33,$a,$32,$f6,$32,$e1,$32,$cd,$32,$b9,$32,$a5
		dc.b	$32,$91,$32,$7d,$32,$69,$32,$55,$32,$41,$32,$2e,$32,$1a,$32,$7
		dc.b	$31,$f3,$31,$e0,$31,$cc,$31,$b9,$31,$a6,$31,$92,$31,$7f,$31,$6c
		dc.b	$31,$59,$31,$46,$31,$33,$31,$20,$31,$d,$30,$fb,$30,$e8,$30,$d5
		dc.b	$30,$c3,$30,$b0,$30,$9e,$30,$8b,$30,$79,$30,$66,$30,$54,$30,$42
		dc.b	$30,$30,$30,$1e,$30,$c,$2f,$fa,$2f,$e8,$2f,$d6,$2f,$c4,$2f,$b2
		dc.b	$2f,$a0,$2f,$8f,$2f,$7d,$2f,$6b,$2f,$5a,$2f,$48,$2f,$37,$2f,$25
		dc.b	$2f,$14,$2f,$3,$2e,$f2,$2e,$e0,$2e,$cf,$2e,$be,$2e,$ad,$2e,$9c
		dc.b	$2e,$8b,$2e,$7a,$2e,$69,$2e,$59,$2e,$48,$2e,$37,$2e,$26,$2e,$16
		dc.b	$2e,$5,$2d,$f5,$2d,$e4,$2d,$d4,$2d,$c3,$2d,$b3,$2d,$a3,$2d,$93
		dc.b	$2d,$82,$2d,$72,$2d,$62,$2d,$52,$2d,$42,$2d,$32,$2d,$22,$2d,$12
		dc.b	$2d,$2,$2c,$f3,$2c,$e3,$2c,$d3,$2c,$c3,$2c,$b4,$2c,$a4,$2c,$95
		dc.b	$2c,$85,$2c,$76,$2c,$66,$2c,$57,$2c,$47,$2c,$38,$2c,$29,$2c,$1a
		dc.b	$2c,$b,$2b,$fb,$2b,$ec,$2b,$dd,$2b,$ce,$2b,$bf,$2b,$b0,$2b,$a1
		dc.b	$2b,$93,$2b,$84,$2b,$75,$2b,$66,$2b,$58,$2b,$49,$2b,$3a,$2b,$2c
		dc.b	$2b,$1d,$2b,$f,$2b,$0,$2a,$f2,$2a,$e3,$2a,$d5,$2a,$c7,$2a,$b8
		dc.b	$2a,$aa,$2a,$9c,$2a,$8e,$2a,$80,$2a,$72,$2a,$64,$2a,$55,$2a,$48
		dc.b	$2a,$3a,$2a,$2c,$2a,$1e,$2a,$10,$2a,$2,$29,$f4,$29,$e7,$29,$d9
		dc.b	$29,$cb,$29,$be,$29,$b0,$29,$a2,$29,$95,$29,$87,$29,$7a,$29,$6d
		dc.b	$29,$5f,$29,$52,$29,$44,$29,$37,$29,$2a,$29,$1d,$29,$10,$29,$2
		dc.b	$28,$f5,$28,$e8,$28,$db,$28,$ce,$28,$c1,$28,$b4,$28,$a7,$28,$9a
		dc.b	$28,$8d,$28,$81,$28,$74,$28,$67,$28,$5a,$28,$4e,$28,$41,$28,$34
		dc.b	$28,$28,$28,$1b,$28,$f,$28,$2,$27,$f6,$27,$e9,$27,$dd,$27,$d0
		dc.b	$27,$c4,$27,$b8,$27,$ab,$27,$9f,$27,$93,$27,$86,$27,$7a,$27,$6e
		dc.b	$27,$62,$27,$56,$27,$4a,$27,$3e,$27,$32,$27,$26,$27,$1a,$27,$e
		dc.b	$27,$2,$26,$f6,$26,$ea,$26,$de,$26,$d3,$26,$c7,$26,$bb,$26,$af
		dc.b	$26,$a4,$26,$98,$26,$8c,$26,$81,$26,$75,$26,$6a,$26,$5e,$26,$53
		dc.b	$26,$47,$26,$3c,$26,$30,$26,$25,$26,$1a,$26,$e,$26,$3,$25,$f8
		dc.b	$25,$ed,$25,$e1,$25,$d6,$25,$cb,$25,$c0,$25,$b5,$25,$aa,$25,$9f
		dc.b	$25,$93,$25,$88,$25,$7d,$25,$72,$25,$68,$25,$5d,$25,$52,$25,$47
		dc.b	$25,$3c,$25,$31,$25,$26,$25,$1c,$25,$11,$25,$6,$24,$fb,$24,$f1
		dc.b	$24,$e6,$24,$dc,$24,$d1,$24,$c6,$24,$bc,$24,$b1,$24,$a7,$24,$9c
		dc.b	$24,$92,$24,$87,$24,$7d,$24,$73,$24,$68,$24,$5e,$24,$54,$24,$49
		dc.b	$24,$3f,$24,$35,$24,$2a,$24,$20,$24,$16,$24,$c,$24,$2,$23,$f8
		dc.b	$23,$ee,$23,$e3,$23,$d9,$23,$cf,$23,$c5,$23,$bb,$23,$b1,$23,$a7
		dc.b	$23,$9e,$23,$94,$23,$8a,$23,$80,$23,$76,$23,$6c,$23,$62,$23,$59
		dc.b	$23,$4f,$23,$45,$23,$3c,$23,$32,$23,$28,$23,$1f,$23,$15,$23,$b
		dc.b	$23,$2,$22,$f8,$22,$ef,$22,$e5,$22,$dc,$22,$d2,$22,$c9,$22,$bf
		dc.b	$22,$b6,$22,$ac,$22,$a3,$22,$9a,$22,$90,$22,$87,$22,$7e,$22,$74
		dc.b	$22,$6b,$22,$62,$22,$59,$22,$4f,$22,$46,$22,$3d,$22,$34,$22,$2b
		dc.b	$22,$22,$22,$19,$22,$f,$22,$6,$21,$fd,$21,$f4,$21,$eb,$21,$e2
		dc.b	$21,$d9,$21,$d0,$21,$c8,$21,$bf,$21,$b6,$21,$ad,$21,$a4,$21,$9b
		dc.b	$21,$92,$21,$8a,$21,$81,$21,$78,$21,$6f,$21,$67,$21,$5e,$21,$55
		dc.b	$21,$4d,$21,$44,$21,$3b,$21,$33,$21,$2a,$21,$21,$21,$19,$21,$10
		dc.b	$21,$8,$20,$ff,$20,$f7,$20,$ee,$20,$e6,$20,$dd,$20,$d5,$20,$cd
		dc.b	$20,$c4,$20,$bc,$20,$b3,$20,$ab,$20,$a3,$20,$9a,$20,$92,$20,$8a
		dc.b	$20,$82,$20,$79,$20,$71,$20,$69,$20,$61,$20,$58,$20,$50,$20,$48
		dc.b	$20,$40,$20,$38,$20,$30,$20,$28,$20,$20,$20,$18,$20,$10,$20,$8

* Only used by the player's movement vector drawy code.
L3671e_ZProjectCentred:
		cmp.l	#$40,d2
		blt.w	l36738
		bsr.w	L35ea2_ZProject
		addi.w	#$a0,d0
		subi.w	#$54,d1
		neg.w	d1
		rts

	l36738:	move.w	#$8000,d0
		move.w	#$8000,d1
		rts

L36742_32BitDotProduct:
		movem.l	d3-5,-(a7)
		move.l	d3,d0
		bpl.s	l3674e
		neg.l	d3
		move.l	d3,d0
	l3674e:	
		swap	d3
		mulu	d3,d0
		add.l	d0,d0
		sub.w	d0,d0
		swap	d0
		mulu	d3,d3
		* d3.l = high 32 bits of 64-bit result (x*x)
		add.l	d0,d3
		
		move.l	d4,d0
		bpl.s	l36764
		neg.l	d4
		move.l	d4,d0
	l36764:	swap	d4
		mulu	d4,d0
		add.l	d0,d0
		sub.w	d0,d0
		swap	d0
		mulu	d4,d4
		* d4.l = high 32 bits of 64-bit result (y*y)
		add.l	d0,d4
		
		move.l	d5,d0
		bpl.s	l3677a
		neg.l	d5
		move.l	d5,d0
	l3677a:	swap	d5
		mulu	d5,d0
		add.l	d0,d0
		sub.w	d0,d0
		swap	d0
		mulu	d5,d5
		* d5.l = high 32 bits of 64-bit result (z*z)
		add.l	d0,d5

		move.l	d3,d0
		add.l	d4,d0
		add.l	d5,d0
		movem.l	(a7)+,d3-5

L36792:
		add.l	d0,d0
		move.l	d0,d1
		lsr.l	#1,d1
		addi.l	#$40000000,d1
	l3679e:	move.l	d0,d7
		moveq	#1,d2
	l367a2:	add.l	d7,d7
		sub.l	d1,d7
		bcc.s	l367aa
		add.l	d1,d7
	l367aa:	roxl.l	#1,d2
		bcc.s	l367a2
		eori.l	#$ffffffff,d2
		lsr.l	#1,d2
		add.l	d2,d1
		lsr.l	#1,d1
		sub.l	d1,d2
		cmp.l	#$ffff8000,d2
		blt.w	l3679e
		move.l	d3,d2
		bpl.s	l367cc
		neg.l	d3
	l367cc:	moveq	#1,d0
	l367ce:	add.l	d3,d3
		sub.l	d1,d3
		bcc.s	l367d6
		add.l	d1,d3
	l367d6:	roxl.l	#1,d0
		bcc.s	l367ce
		eori.l	#$ffffffff,d0
		lsr.l	#1,d0
		tst.l	d2
		bpl.s	l367e8
		neg.l	d0
	l367e8:	move.l	d0,d3
		move.l	d4,d2
		bpl.s	l367f0
		neg.l	d4
	l367f0:	moveq	#1,d0
	l367f2:	add.l	d4,d4
		sub.l	d1,d4
		bcc.s	l367fa
		add.l	d1,d4
	l367fa:	roxl.l	#1,d0
		bcc.s	l367f2
		eori.l	#$ffffffff,d0
		lsr.l	#1,d0
		tst.l	d2
		bpl.s	l3680c
		neg.l	d0
	l3680c:	move.l	d0,d4
		move.l	d5,d2
		bpl.s	l36814
		neg.l	d5
	l36814:	moveq	#1,d0
	l36816:	add.l	d5,d5
		sub.l	d1,d5
		bcc.s	l3681e
		add.l	d1,d5
	l3681e:	roxl.l	#1,d0
		bcc.s	l36816
		eori.l	#$ffffffff,d0
		lsr.l	#1,d0
		tst.l	d2
		bpl.s	l36830
		neg.l	d0
	l36830:	move.l	d0,d5
		move.l	d3,d2
		bpl.s	l36838
		neg.l	d3
	l36838:	move.l	d3,d0
		swap	d0
		move.l	d0,d1
		mulu	d6,d1
		swap	d6
		mulu	d6,d3
		add.l	d1,d3
		sub.w	d3,d3
		swap	d3
		mulu	d6,d0
		swap	d6
		add.l	d0,d3
		add.l	d3,d3
		tst.l	d2
		bpl.s	l36858
		neg.l	d3
	l36858:	move.l	d4,d2
		bpl.s	l3685e
		neg.l	d4
	l3685e:	move.l	d4,d0
		swap	d0
		move.l	d0,d1
		mulu	d6,d1
		swap	d6
		mulu	d6,d4
		add.l	d1,d4
		sub.w	d4,d4
		swap	d4
		mulu	d6,d0
		swap	d6
		add.l	d0,d4
		add.l	d4,d4
		tst.l	d2
		bpl.s	l3687e
		neg.l	d4
	l3687e:	move.l	d5,d2
		bpl.s	l36884
		neg.l	d5
	l36884:	move.l	d5,d0
		swap	d0
		move.l	d0,d1
		mulu	d6,d1
		swap	d6
		mulu	d6,d5
		add.l	d1,d5
		sub.w	d5,d5
		swap	d5
		mulu	d6,d0
		swap	d6
		add.l	d0,d5
		add.l	d5,d5
		tst.l	d2
		bpl.s	l368a4
		neg.l	d5
	l368a4:	rts

L368a6:
		add.l	d0,d0
		asr.w	#1,d1
		bcc.s	l368b0
		lsr.l	#1,d0
		addq.w	#1,d1
	l368b0:	bsr.s	L368e0_Sqrt
		lsr.w	#1,d0
		tst.w	d0
		beq.s	l368c2
	l368b8:	subq.w	#1,d1
		add.w	d0,d0
		bpl.s	l368b8
		addq.w	#1,d1
		lsr.w	#1,d0
	l368c2:	rts

L368c4:
		add.w	d0,d0
		asr.w	#1,d1
		bcc.s	l368ce
		lsr.w	#1,d0
		addq.w	#1,d1
	l368ce:	swap	d0
		bsr.s	L368e0_Sqrt
		lsr.w	#1,d0
		rts

L368d6_VectorLen:
		muls	d0,d0
		muls	d1,d1
		muls	d2,d2
		add.l	d1,d0
		add.l	d2,d0

L368e0_Sqrt:
		cmp.l	#$4000000,d0
		bcs.s	l3691c
		swap	d0
		cmp.w	#$4000,d0
		bcc.s	l36910
		cmp.w	#$1000,d0
		bcc.s	l36902
		andi.w	#$fffe,d0
		move.w	L3695a_sqrt_table(pc,d0.w),d0
		lsr.w	#2,d0
		rts

	l36902:	lsr.w	#2,d0
		andi.w	#$fffe,d0
		move.w	L3695a_sqrt_table(pc,d0.w),d0
		lsr.w	#1,d0
		rts

	l36910:	lsr.w	#4,d0
		andi.w	#$fffe,d0
		move.w	L3695a_sqrt_table(pc,d0.w),d0
		rts

	l3691c:	cmp.l	#$400000,d0
		bcc.s	l3693a
		cmp.l	#$40000,d0
		bcc.s	l3694a
		lsr.l	#6,d0
		andi.w	#$fffe,d0
		move.w	L3695a_sqrt_table(pc,d0.w),d0
		lsr.w	#7,d0
		rts

	l3693a:	swap	d0
		rol.l	#2,d0
		andi.w	#$fffe,d0
		move.w	L3695a_sqrt_table(pc,d0.w),d0
		lsr.w	#3,d0
		rts

	l3694a:	swap	d0
		rol.l	#6,d0
		andi.w	#$fffe,d0
		move.w	L3695a_sqrt_table(pc,d0.w),d0
		lsr.w	#5,d0
		rts

L3695a_sqrt_table:
		dc.b	$0,$0,$5,$a8,$8,$0,$9,$cc,$b,$50,$c,$a6,$d,$db,$e,$f7
		dc.b	$10,$0,$10,$f8,$11,$e3,$12,$c2,$13,$98,$14,$65,$15,$2a,$15,$e8
		dc.b	$16,$a0,$17,$52,$18,$0,$18,$a8,$19,$4c,$19,$ec,$1a,$88,$1b,$21
		dc.b	$1b,$b6,$1c,$48,$1c,$d8,$1d,$64,$1d,$ee,$1e,$76,$1e,$fb,$1f,$7e
		dc.b	$20,$0,$20,$7f,$20,$fc,$21,$77,$21,$f0,$22,$68,$22,$df,$23,$53
		dc.b	$23,$c6,$24,$38,$24,$a9,$25,$18,$25,$85,$25,$f2,$26,$5d,$26,$c8
		dc.b	$27,$31,$27,$99,$28,$0,$28,$65,$28,$ca,$29,$2e,$29,$91,$29,$f3
		dc.b	$2a,$54,$2a,$b5,$2b,$14,$2b,$73,$2b,$d1,$2c,$2e,$2c,$8a,$2c,$e6
		dc.b	$2d,$41,$2d,$9b,$2d,$f4,$2e,$4d,$2e,$a5,$2e,$fd,$2f,$54,$2f,$aa
		dc.b	$30,$0,$30,$55,$30,$a9,$30,$fd,$31,$50,$31,$a3,$31,$f5,$32,$47
		dc.b	$32,$98,$32,$e9,$33,$39,$33,$89,$33,$d8,$34,$27,$34,$75,$34,$c3
		dc.b	$35,$10,$35,$5d,$35,$aa,$35,$f6,$36,$42,$36,$8d,$36,$d8,$37,$22
		dc.b	$37,$6c,$37,$b6,$38,$0,$38,$48,$38,$91,$38,$d9,$39,$21,$39,$69
		dc.b	$39,$b0,$39,$f7,$3a,$3d,$3a,$83,$3a,$c9,$3b,$f,$3b,$54,$3b,$99
		dc.b	$3b,$dd,$3c,$22,$3c,$66,$3c,$a9,$3c,$ed,$3d,$30,$3d,$72,$3d,$b5
		dc.b	$3d,$f7,$3e,$39,$3e,$7b,$3e,$bc,$3e,$fd,$3f,$3e,$3f,$7f,$3f,$bf
		dc.b	$40,$0,$40,$3f,$40,$7f,$40,$be,$40,$fe,$41,$3c,$41,$7b,$41,$ba
		dc.b	$41,$f8,$42,$36,$42,$73,$42,$b1,$42,$ee,$43,$2b,$43,$68,$43,$a5
		dc.b	$43,$e1,$44,$1e,$44,$5a,$44,$95,$44,$d1,$45,$c,$45,$48,$45,$83
		dc.b	$45,$be,$45,$f8,$46,$33,$46,$6d,$46,$a7,$46,$e1,$47,$1b,$47,$54
		dc.b	$47,$8d,$47,$c7,$48,$0,$48,$38,$48,$71,$48,$a9,$48,$e2,$49,$1a
		dc.b	$49,$52,$49,$8a,$49,$c1,$49,$f9,$4a,$30,$4a,$67,$4a,$9e,$4a,$d5
		dc.b	$4b,$b,$4b,$42,$4b,$78,$4b,$ae,$4b,$e5,$4c,$1a,$4c,$50,$4c,$86
		dc.b	$4c,$bb,$4c,$f1,$4d,$26,$4d,$5b,$4d,$90,$4d,$c4,$4d,$f9,$4e,$2d
		dc.b	$4e,$62,$4e,$96,$4e,$ca,$4e,$fe,$4f,$32,$4f,$65,$4f,$99,$4f,$cc
		dc.b	$50,$0,$50,$33,$50,$66,$50,$99,$50,$cb,$50,$fe,$51,$30,$51,$63
		dc.b	$51,$95,$51,$c7,$51,$f9,$52,$2b,$52,$5d,$52,$8f,$52,$c0,$52,$f2
		dc.b	$53,$23,$53,$54,$53,$85,$53,$b6,$53,$e7,$54,$18,$54,$49,$54,$79
		dc.b	$54,$a9,$54,$da,$55,$a,$55,$3a,$55,$6a,$55,$9a,$55,$ca,$55,$fa
		dc.b	$56,$29,$56,$59,$56,$88,$56,$b7,$56,$e6,$57,$16,$57,$45,$57,$73
		dc.b	$57,$a2,$57,$d1,$58,$0,$58,$2e,$58,$5c,$58,$8b,$58,$b9,$58,$e7
		dc.b	$59,$15,$59,$43,$59,$71,$59,$9f,$59,$cc,$59,$fa,$5a,$27,$5a,$55
		dc.b	$5a,$82,$5a,$af,$5a,$dc,$5b,$9,$5b,$36,$5b,$63,$5b,$90,$5b,$bd
		dc.b	$5b,$e9,$5c,$16,$5c,$42,$5c,$6f,$5c,$9b,$5c,$c7,$5c,$f3,$5d,$1f
		dc.b	$5d,$4b,$5d,$77,$5d,$a3,$5d,$ce,$5d,$fa,$5e,$26,$5e,$51,$5e,$7c
		dc.b	$5e,$a8,$5e,$d3,$5e,$fe,$5f,$29,$5f,$54,$5f,$7f,$5f,$aa,$5f,$d5
		dc.b	$60,$0,$60,$2a,$60,$55,$60,$7f,$60,$aa,$60,$d4,$60,$fe,$61,$28
		dc.b	$61,$52,$61,$7d,$61,$a7,$61,$d0,$61,$fa,$62,$24,$62,$4e,$62,$77
		dc.b	$62,$a1,$62,$ca,$62,$f4,$63,$1d,$63,$47,$63,$70,$63,$99,$63,$c2
		dc.b	$63,$eb,$64,$14,$64,$3d,$64,$66,$64,$8e,$64,$b7,$64,$e0,$65,$8
		dc.b	$65,$31,$65,$59,$65,$82,$65,$aa,$65,$d2,$65,$fa,$66,$23,$66,$4b
		dc.b	$66,$73,$66,$9b,$66,$c3,$66,$ea,$67,$12,$67,$3a,$67,$61,$67,$89
		dc.b	$67,$b1,$67,$d8,$68,$0,$68,$27,$68,$4e,$68,$75,$68,$9d,$68,$c4
		dc.b	$68,$eb,$69,$12,$69,$39,$69,$60,$69,$86,$69,$ad,$69,$d4,$69,$fb
		dc.b	$6a,$21,$6a,$48,$6a,$6e,$6a,$95,$6a,$bb,$6a,$e2,$6b,$8,$6b,$2e
		dc.b	$6b,$54,$6b,$7a,$6b,$a1,$6b,$c7,$6b,$ed,$6c,$12,$6c,$38,$6c,$5e
		dc.b	$6c,$84,$6c,$aa,$6c,$cf,$6c,$f5,$6d,$1a,$6d,$40,$6d,$65,$6d,$8b
		dc.b	$6d,$b0,$6d,$d6,$6d,$fb,$6e,$20,$6e,$45,$6e,$6a,$6e,$8f,$6e,$b4
		dc.b	$6e,$d9,$6e,$fe,$6f,$23,$6f,$48,$6f,$6d,$6f,$92,$6f,$b6,$6f,$db
		dc.b	$70,$0,$70,$24,$70,$49,$70,$6d,$70,$91,$70,$b6,$70,$da,$70,$fe
		dc.b	$71,$23,$71,$47,$71,$6b,$71,$8f,$71,$b3,$71,$d7,$71,$fb,$72,$1f
		dc.b	$72,$43,$72,$67,$72,$8a,$72,$ae,$72,$d2,$72,$f5,$73,$19,$73,$3d
		dc.b	$73,$60,$73,$84,$73,$a7,$73,$ca,$73,$ee,$74,$11,$74,$34,$74,$58
		dc.b	$74,$7b,$74,$9e,$74,$c1,$74,$e4,$75,$7,$75,$2a,$75,$4d,$75,$70
		dc.b	$75,$93,$75,$b6,$75,$d8,$75,$fb,$76,$1e,$76,$41,$76,$63,$76,$86
		dc.b	$76,$a8,$76,$cb,$76,$ed,$77,$10,$77,$32,$77,$54,$77,$77,$77,$99
		dc.b	$77,$bb,$77,$dd,$78,$0,$78,$22,$78,$44,$78,$66,$78,$88,$78,$aa
		dc.b	$78,$cc,$78,$ee,$79,$f,$79,$31,$79,$53,$79,$75,$79,$96,$79,$b8
		dc.b	$79,$da,$79,$fb,$7a,$1d,$7a,$3e,$7a,$60,$7a,$81,$7a,$a3,$7a,$c4
		dc.b	$7a,$e5,$7b,$7,$7b,$28,$7b,$49,$7b,$6b,$7b,$8c,$7b,$ad,$7b,$ce
		dc.b	$7b,$ef,$7c,$10,$7c,$31,$7c,$52,$7c,$73,$7c,$94,$7c,$b5,$7c,$d5
		dc.b	$7c,$f6,$7d,$17,$7d,$38,$7d,$58,$7d,$79,$7d,$9a,$7d,$ba,$7d,$db
		dc.b	$7d,$fb,$7e,$1c,$7e,$3c,$7e,$5d,$7e,$7d,$7e,$9e,$7e,$be,$7e,$de
		dc.b	$7e,$fe,$7f,$1f,$7f,$3f,$7f,$5f,$7f,$7f,$7f,$9f,$7f,$bf,$7f,$df
		dc.b	$80,$0,$80,$1f,$80,$3f,$80,$5f,$80,$7f,$80,$9f,$80,$bf,$80,$df
		dc.b	$80,$ff,$81,$1e,$81,$3e,$81,$5e,$81,$7d,$81,$9d,$81,$bc,$81,$dc
		dc.b	$81,$fc,$82,$1b,$82,$3b,$82,$5a,$82,$79,$82,$99,$82,$b8,$82,$d7
		dc.b	$82,$f7,$83,$16,$83,$35,$83,$54,$83,$74,$83,$93,$83,$b2,$83,$d1
		dc.b	$83,$f0,$84,$f,$84,$2e,$84,$4d,$84,$6c,$84,$8b,$84,$aa,$84,$c9
		dc.b	$84,$e7,$85,$6,$85,$25,$85,$44,$85,$62,$85,$81,$85,$a0,$85,$be
		dc.b	$85,$dd,$85,$fc,$86,$1a,$86,$39,$86,$57,$86,$76,$86,$94,$86,$b3
		dc.b	$86,$d1,$86,$ef,$87,$e,$87,$2c,$87,$4a,$87,$69,$87,$87,$87,$a5
		dc.b	$87,$c3,$87,$e1,$88,$0,$88,$1e,$88,$3c,$88,$5a,$88,$78,$88,$96
		dc.b	$88,$b4,$88,$d2,$88,$f0,$89,$e,$89,$2b,$89,$49,$89,$67,$89,$85
		dc.b	$89,$a3,$89,$c0,$89,$de,$89,$fc,$8a,$19,$8a,$37,$8a,$55,$8a,$72
		dc.b	$8a,$90,$8a,$ad,$8a,$cb,$8a,$e8,$8b,$6,$8b,$23,$8b,$41,$8b,$5e
		dc.b	$8b,$7c,$8b,$99,$8b,$b6,$8b,$d4,$8b,$f1,$8c,$e,$8c,$2b,$8c,$49
		dc.b	$8c,$66,$8c,$83,$8c,$a0,$8c,$bd,$8c,$da,$8c,$f7,$8d,$14,$8d,$31
		dc.b	$8d,$4e,$8d,$6b,$8d,$88,$8d,$a5,$8d,$c2,$8d,$df,$8d,$fc,$8e,$19
		dc.b	$8e,$36,$8e,$52,$8e,$6f,$8e,$8c,$8e,$a9,$8e,$c5,$8e,$e2,$8e,$ff
		dc.b	$8f,$1b,$8f,$38,$8f,$54,$8f,$71,$8f,$8e,$8f,$aa,$8f,$c7,$8f,$e3
		dc.b	$90,$0,$90,$1c,$90,$38,$90,$55,$90,$71,$90,$8d,$90,$aa,$90,$c6
		dc.b	$90,$e2,$90,$ff,$91,$1b,$91,$37,$91,$53,$91,$6f,$91,$8c,$91,$a8
		dc.b	$91,$c4,$91,$e0,$91,$fc,$92,$18,$92,$34,$92,$50,$92,$6c,$92,$88
		dc.b	$92,$a4,$92,$c0,$92,$dc,$92,$f8,$93,$14,$93,$2f,$93,$4b,$93,$67
		dc.b	$93,$83,$93,$9f,$93,$ba,$93,$d6,$93,$f2,$94,$d,$94,$29,$94,$45
		dc.b	$94,$60,$94,$7c,$94,$97,$94,$b3,$94,$cf,$94,$ea,$95,$6,$95,$21
		dc.b	$95,$3c,$95,$58,$95,$73,$95,$8f,$95,$aa,$95,$c5,$95,$e1,$95,$fc
		dc.b	$96,$17,$96,$33,$96,$4e,$96,$69,$96,$84,$96,$a0,$96,$bb,$96,$d6
		dc.b	$96,$f1,$97,$c,$97,$27,$97,$42,$97,$5d,$97,$79,$97,$94,$97,$af
		dc.b	$97,$ca,$97,$e5,$98,$0,$98,$1a,$98,$35,$98,$50,$98,$6b,$98,$86
		dc.b	$98,$a1,$98,$bc,$98,$d6,$98,$f1,$99,$c,$99,$27,$99,$42,$99,$5c
		dc.b	$99,$77,$99,$92,$99,$ac,$99,$c7,$99,$e2,$99,$fc,$9a,$17,$9a,$31
		dc.b	$9a,$4c,$9a,$66,$9a,$81,$9a,$9b,$9a,$b6,$9a,$d0,$9a,$eb,$9b,$5
		dc.b	$9b,$20,$9b,$3a,$9b,$54,$9b,$6f,$9b,$89,$9b,$a3,$9b,$be,$9b,$d8
		dc.b	$9b,$f2,$9c,$d,$9c,$27,$9c,$41,$9c,$5b,$9c,$75,$9c,$90,$9c,$aa
		dc.b	$9c,$c4,$9c,$de,$9c,$f8,$9d,$12,$9d,$2c,$9d,$46,$9d,$60,$9d,$7a
		dc.b	$9d,$94,$9d,$ae,$9d,$c8,$9d,$e2,$9d,$fc,$9e,$16,$9e,$30,$9e,$4a
		dc.b	$9e,$64,$9e,$7e,$9e,$98,$9e,$b1,$9e,$cb,$9e,$e5,$9e,$ff,$9f,$18
		dc.b	$9f,$32,$9f,$4c,$9f,$66,$9f,$7f,$9f,$99,$9f,$b3,$9f,$cc,$9f,$e6
		dc.b	$a0,$0,$a0,$19,$a0,$33,$a0,$4c,$a0,$66,$a0,$7f,$a0,$99,$a0,$b2
		dc.b	$a0,$cc,$a0,$e5,$a0,$ff,$a1,$18,$a1,$32,$a1,$4b,$a1,$64,$a1,$7e
		dc.b	$a1,$97,$a1,$b0,$a1,$ca,$a1,$e3,$a1,$fc,$a2,$16,$a2,$2f,$a2,$48
		dc.b	$a2,$61,$a2,$7b,$a2,$94,$a2,$ad,$a2,$c6,$a2,$df,$a2,$f8,$a3,$12
		dc.b	$a3,$2b,$a3,$44,$a3,$5d,$a3,$76,$a3,$8f,$a3,$a8,$a3,$c1,$a3,$da
		dc.b	$a3,$f3,$a4,$c,$a4,$25,$a4,$3e,$a4,$57,$a4,$70,$a4,$89,$a4,$a2
		dc.b	$a4,$ba,$a4,$d3,$a4,$ec,$a5,$5,$a5,$1e,$a5,$37,$a5,$4f,$a5,$68
		dc.b	$a5,$81,$a5,$9a,$a5,$b2,$a5,$cb,$a5,$e4,$a5,$fc,$a6,$15,$a6,$2e
		dc.b	$a6,$46,$a6,$5f,$a6,$78,$a6,$90,$a6,$a9,$a6,$c1,$a6,$da,$a6,$f2
		dc.b	$a7,$b,$a7,$24,$a7,$3c,$a7,$54,$a7,$6d,$a7,$85,$a7,$9e,$a7,$b6
		dc.b	$a7,$cf,$a7,$e7,$a8,$0,$a8,$18,$a8,$30,$a8,$49,$a8,$61,$a8,$79
		dc.b	$a8,$92,$a8,$aa,$a8,$c2,$a8,$da,$a8,$f3,$a9,$b,$a9,$23,$a9,$3b
		dc.b	$a9,$53,$a9,$6c,$a9,$84,$a9,$9c,$a9,$b4,$a9,$cc,$a9,$e4,$a9,$fc
		dc.b	$aa,$15,$aa,$2d,$aa,$45,$aa,$5d,$aa,$75,$aa,$8d,$aa,$a5,$aa,$bd
		dc.b	$aa,$d5,$aa,$ed,$ab,$5,$ab,$1d,$ab,$35,$ab,$4d,$ab,$64,$ab,$7c
		dc.b	$ab,$94,$ab,$ac,$ab,$c4,$ab,$dc,$ab,$f4,$ac,$b,$ac,$23,$ac,$3b
		dc.b	$ac,$53,$ac,$6b,$ac,$82,$ac,$9a,$ac,$b2,$ac,$c9,$ac,$e1,$ac,$f9
		dc.b	$ad,$11,$ad,$28,$ad,$40,$ad,$57,$ad,$6f,$ad,$87,$ad,$9e,$ad,$b6
		dc.b	$ad,$cd,$ad,$e5,$ad,$fd,$ae,$14,$ae,$2c,$ae,$43,$ae,$5b,$ae,$72
		dc.b	$ae,$8a,$ae,$a1,$ae,$b8,$ae,$d0,$ae,$e7,$ae,$ff,$af,$16,$af,$2e
		dc.b	$af,$45,$af,$5c,$af,$74,$af,$8b,$af,$a2,$af,$ba,$af,$d1,$af,$e8
		dc.b	$b0,$0,$b0,$17,$b0,$2e,$b0,$45,$b0,$5c,$b0,$74,$b0,$8b,$b0,$a2
		dc.b	$b0,$b9,$b0,$d0,$b0,$e8,$b0,$ff,$b1,$16,$b1,$2d,$b1,$44,$b1,$5b
		dc.b	$b1,$72,$b1,$89,$b1,$a0,$b1,$b8,$b1,$cf,$b1,$e6,$b1,$fd,$b2,$14
		dc.b	$b2,$2b,$b2,$42,$b2,$59,$b2,$70,$b2,$86,$b2,$9d,$b2,$b4,$b2,$cb
		dc.b	$b2,$e2,$b2,$f9,$b3,$10,$b3,$27,$b3,$3e,$b3,$55,$b3,$6b,$b3,$82
		dc.b	$b3,$99,$b3,$b0,$b3,$c7,$b3,$dd,$b3,$f4,$b4,$b,$b4,$22,$b4,$38
		dc.b	$b4,$4f,$b4,$66,$b4,$7c,$b4,$93,$b4,$aa,$b4,$c1,$b4,$d7,$b4,$ee
		dc.b	$b5,$4,$b5,$1b,$b5,$32,$b5,$48,$b5,$5f,$b5,$75,$b5,$8c,$b5,$a3
		dc.b	$b5,$b9,$b5,$d0,$b5,$e6,$b5,$fd,$b6,$13,$b6,$2a,$b6,$40,$b6,$57
		dc.b	$b6,$6d,$b6,$84,$b6,$9a,$b6,$b0,$b6,$c7,$b6,$dd,$b6,$f4,$b7,$a
		dc.b	$b7,$20,$b7,$37,$b7,$4d,$b7,$63,$b7,$7a,$b7,$90,$b7,$a6,$b7,$bd
		dc.b	$b7,$d3,$b7,$e9,$b8,$0,$b8,$16,$b8,$2c,$b8,$42,$b8,$58,$b8,$6f
		dc.b	$b8,$85,$b8,$9b,$b8,$b1,$b8,$c7,$b8,$de,$b8,$f4,$b9,$a,$b9,$20
		dc.b	$b9,$36,$b9,$4c,$b9,$62,$b9,$78,$b9,$8f,$b9,$a5,$b9,$bb,$b9,$d1
		dc.b	$b9,$e7,$b9,$fd,$ba,$13,$ba,$29,$ba,$3f,$ba,$55,$ba,$6b,$ba,$81
		dc.b	$ba,$97,$ba,$ad,$ba,$c3,$ba,$d8,$ba,$ee,$bb,$4,$bb,$1a,$bb,$30
		dc.b	$bb,$46,$bb,$5c,$bb,$72,$bb,$88,$bb,$9d,$bb,$b3,$bb,$c9,$bb,$df
		dc.b	$bb,$f5,$bc,$a,$bc,$20,$bc,$36,$bc,$4c,$bc,$61,$bc,$77,$bc,$8d
		dc.b	$bc,$a3,$bc,$b8,$bc,$ce,$bc,$e4,$bc,$f9,$bd,$f,$bd,$25,$bd,$3a
		dc.b	$bd,$50,$bd,$66,$bd,$7b,$bd,$91,$bd,$a6,$bd,$bc,$bd,$d2,$bd,$e7
		dc.b	$bd,$fd,$be,$12,$be,$28,$be,$3d,$be,$53,$be,$68,$be,$7e,$be,$93
		dc.b	$be,$a9,$be,$be,$be,$d4,$be,$e9,$be,$ff,$bf,$14,$bf,$2a,$bf,$3f
		dc.b	$bf,$55,$bf,$6a,$bf,$7f,$bf,$95,$bf,$aa,$bf,$bf,$bf,$d5,$bf,$ea
		dc.b	$c0,$0,$c0,$15,$c0,$2a,$c0,$3f,$c0,$55,$c0,$6a,$c0,$7f,$c0,$95
		dc.b	$c0,$aa,$c0,$bf,$c0,$d4,$c0,$ea,$c0,$ff,$c1,$14,$c1,$29,$c1,$3e
		dc.b	$c1,$54,$c1,$69,$c1,$7e,$c1,$93,$c1,$a8,$c1,$bd,$c1,$d3,$c1,$e8
		dc.b	$c1,$fd,$c2,$12,$c2,$27,$c2,$3c,$c2,$51,$c2,$66,$c2,$7b,$c2,$90
		dc.b	$c2,$a5,$c2,$bb,$c2,$d0,$c2,$e5,$c2,$fa,$c3,$f,$c3,$24,$c3,$39
		dc.b	$c3,$4e,$c3,$63,$c3,$77,$c3,$8c,$c3,$a1,$c3,$b6,$c3,$cb,$c3,$e0
		dc.b	$c3,$f5,$c4,$a,$c4,$1f,$c4,$34,$c4,$49,$c4,$5d,$c4,$72,$c4,$87
		dc.b	$c4,$9c,$c4,$b1,$c4,$c6,$c4,$da,$c4,$ef,$c5,$4,$c5,$19,$c5,$2e
		dc.b	$c5,$42,$c5,$57,$c5,$6c,$c5,$81,$c5,$95,$c5,$aa,$c5,$bf,$c5,$d4
		dc.b	$c5,$e8,$c5,$fd,$c6,$12,$c6,$26,$c6,$3b,$c6,$50,$c6,$64,$c6,$79
		dc.b	$c6,$8e,$c6,$a2,$c6,$b7,$c6,$cb,$c6,$e0,$c6,$f5,$c7,$9,$c7,$1e
		dc.b	$c7,$32,$c7,$47,$c7,$5b,$c7,$70,$c7,$84,$c7,$99,$c7,$ae,$c7,$c2
		dc.b	$c7,$d7,$c7,$eb,$c8,$0,$c8,$14,$c8,$28,$c8,$3d,$c8,$51,$c8,$66
		dc.b	$c8,$7a,$c8,$8f,$c8,$a3,$c8,$b7,$c8,$cc,$c8,$e0,$c8,$f5,$c9,$9
		dc.b	$c9,$1d,$c9,$32,$c9,$46,$c9,$5a,$c9,$6f,$c9,$83,$c9,$97,$c9,$ac
		dc.b	$c9,$c0,$c9,$d4,$c9,$e9,$c9,$fd,$ca,$11,$ca,$26,$ca,$3a,$ca,$4e
		dc.b	$ca,$62,$ca,$76,$ca,$8b,$ca,$9f,$ca,$b3,$ca,$c7,$ca,$dc,$ca,$f0
		dc.b	$cb,$4,$cb,$18,$cb,$2c,$cb,$40,$cb,$55,$cb,$69,$cb,$7d,$cb,$91
		dc.b	$cb,$a5,$cb,$b9,$cb,$cd,$cb,$e1,$cb,$f5,$cc,$a,$cc,$1e,$cc,$32
		dc.b	$cc,$46,$cc,$5a,$cc,$6e,$cc,$82,$cc,$96,$cc,$aa,$cc,$be,$cc,$d2
		dc.b	$cc,$e6,$cc,$fa,$cd,$e,$cd,$22,$cd,$36,$cd,$4a,$cd,$5e,$cd,$72
		dc.b	$cd,$86,$cd,$99,$cd,$ad,$cd,$c1,$cd,$d5,$cd,$e9,$cd,$fd,$ce,$11
		dc.b	$ce,$25,$ce,$39,$ce,$4c,$ce,$60,$ce,$74,$ce,$88,$ce,$9c,$ce,$b0
		dc.b	$ce,$c3,$ce,$d7,$ce,$eb,$ce,$ff,$cf,$13,$cf,$26,$cf,$3a,$cf,$4e
		dc.b	$cf,$62,$cf,$75,$cf,$89,$cf,$9d,$cf,$b1,$cf,$c4,$cf,$d8,$cf,$ec
		dc.b	$d0,$0,$d0,$13,$d0,$27,$d0,$3b,$d0,$4e,$d0,$62,$d0,$76,$d0,$89
		dc.b	$d0,$9d,$d0,$b0,$d0,$c4,$d0,$d8,$d0,$eb,$d0,$ff,$d1,$12,$d1,$26
		dc.b	$d1,$3a,$d1,$4d,$d1,$61,$d1,$74,$d1,$88,$d1,$9b,$d1,$af,$d1,$c3
		dc.b	$d1,$d6,$d1,$ea,$d1,$fd,$d2,$11,$d2,$24,$d2,$38,$d2,$4b,$d2,$5f
		dc.b	$d2,$72,$d2,$85,$d2,$99,$d2,$ac,$d2,$c0,$d2,$d3,$d2,$e7,$d2,$fa
		dc.b	$d3,$d,$d3,$21,$d3,$34,$d3,$48,$d3,$5b,$d3,$6e,$d3,$82,$d3,$95
		dc.b	$d3,$a8,$d3,$bc,$d3,$cf,$d3,$e3,$d3,$f6,$d4,$9,$d4,$1c,$d4,$30
		dc.b	$d4,$43,$d4,$56,$d4,$6a,$d4,$7d,$d4,$90,$d4,$a3,$d4,$b7,$d4,$ca
		dc.b	$d4,$dd,$d4,$f0,$d5,$4,$d5,$17,$d5,$2a,$d5,$3d,$d5,$51,$d5,$64
		dc.b	$d5,$77,$d5,$8a,$d5,$9d,$d5,$b0,$d5,$c4,$d5,$d7,$d5,$ea,$d5,$fd
		dc.b	$d6,$10,$d6,$23,$d6,$37,$d6,$4a,$d6,$5d,$d6,$70,$d6,$83,$d6,$96
		dc.b	$d6,$a9,$d6,$bc,$d6,$cf,$d6,$e2,$d6,$f5,$d7,$8,$d7,$1b,$d7,$2f
		dc.b	$d7,$42,$d7,$55,$d7,$68,$d7,$7b,$d7,$8e,$d7,$a1,$d7,$b4,$d7,$c7
		dc.b	$d7,$da,$d7,$ed,$d8,$0,$d8,$12,$d8,$25,$d8,$38,$d8,$4b,$d8,$5e
		dc.b	$d8,$71,$d8,$84,$d8,$97,$d8,$aa,$d8,$bd,$d8,$d0,$d8,$e3,$d8,$f5
		dc.b	$d9,$8,$d9,$1b,$d9,$2e,$d9,$41,$d9,$54,$d9,$67,$d9,$79,$d9,$8c
		dc.b	$d9,$9f,$d9,$b2,$d9,$c5,$d9,$d8,$d9,$ea,$d9,$fd,$da,$10,$da,$23
		dc.b	$da,$35,$da,$48,$da,$5b,$da,$6e,$da,$81,$da,$93,$da,$a6,$da,$b9
		dc.b	$da,$cb,$da,$de,$da,$f1,$db,$4,$db,$16,$db,$29,$db,$3c,$db,$4e
		dc.b	$db,$61,$db,$74,$db,$86,$db,$99,$db,$ac,$db,$be,$db,$d1,$db,$e4
		dc.b	$db,$f6,$dc,$9,$dc,$1b,$dc,$2e,$dc,$41,$dc,$53,$dc,$66,$dc,$78
		dc.b	$dc,$8b,$dc,$9e,$dc,$b0,$dc,$c3,$dc,$d5,$dc,$e8,$dc,$fa,$dd,$d
		dc.b	$dd,$1f,$dd,$32,$dd,$44,$dd,$57,$dd,$69,$dd,$7c,$dd,$8e,$dd,$a1
		dc.b	$dd,$b3,$dd,$c6,$dd,$d8,$dd,$eb,$dd,$fd,$de,$10,$de,$22,$de,$35
		dc.b	$de,$47,$de,$59,$de,$6c,$de,$7e,$de,$91,$de,$a3,$de,$b5,$de,$c8
		dc.b	$de,$da,$de,$ed,$de,$ff,$df,$11,$df,$24,$df,$36,$df,$48,$df,$5b
		dc.b	$df,$6d,$df,$7f,$df,$92,$df,$a4,$df,$b6,$df,$c9,$df,$db,$df,$ed
		dc.b	$e0,$0,$e0,$12,$e0,$24,$e0,$36,$e0,$49,$e0,$5b,$e0,$6d,$e0,$7f
		dc.b	$e0,$92,$e0,$a4,$e0,$b6,$e0,$c8,$e0,$db,$e0,$ed,$e0,$ff,$e1,$11
		dc.b	$e1,$23,$e1,$36,$e1,$48,$e1,$5a,$e1,$6c,$e1,$7e,$e1,$90,$e1,$a3
		dc.b	$e1,$b5,$e1,$c7,$e1,$d9,$e1,$eb,$e1,$fd,$e2,$f,$e2,$21,$e2,$34
		dc.b	$e2,$46,$e2,$58,$e2,$6a,$e2,$7c,$e2,$8e,$e2,$a0,$e2,$b2,$e2,$c4
		dc.b	$e2,$d6,$e2,$e8,$e2,$fa,$e3,$c,$e3,$1f,$e3,$31,$e3,$43,$e3,$55
		dc.b	$e3,$67,$e3,$79,$e3,$8b,$e3,$9d,$e3,$af,$e3,$c1,$e3,$d3,$e3,$e5
		dc.b	$e3,$f7,$e4,$8,$e4,$1a,$e4,$2c,$e4,$3e,$e4,$50,$e4,$62,$e4,$74
		dc.b	$e4,$86,$e4,$98,$e4,$aa,$e4,$bc,$e4,$ce,$e4,$e0,$e4,$f2,$e5,$3
		dc.b	$e5,$15,$e5,$27,$e5,$39,$e5,$4b,$e5,$5d,$e5,$6f,$e5,$80,$e5,$92
		dc.b	$e5,$a4,$e5,$b6,$e5,$c8,$e5,$da,$e5,$eb,$e5,$fd,$e6,$f,$e6,$21
		dc.b	$e6,$33,$e6,$44,$e6,$56,$e6,$68,$e6,$7a,$e6,$8c,$e6,$9d,$e6,$af
		dc.b	$e6,$c1,$e6,$d3,$e6,$e4,$e6,$f6,$e7,$8,$e7,$1a,$e7,$2b,$e7,$3d
		dc.b	$e7,$4f,$e7,$60,$e7,$72,$e7,$84,$e7,$95,$e7,$a7,$e7,$b9,$e7,$cb
		dc.b	$e7,$dc,$e7,$ee,$e8,$0,$e8,$11,$e8,$23,$e8,$34,$e8,$46,$e8,$58
		dc.b	$e8,$69,$e8,$7b,$e8,$8d,$e8,$9e,$e8,$b0,$e8,$c1,$e8,$d3,$e8,$e5
		dc.b	$e8,$f6,$e9,$8,$e9,$19,$e9,$2b,$e9,$3c,$e9,$4e,$e9,$60,$e9,$71
		dc.b	$e9,$83,$e9,$94,$e9,$a6,$e9,$b7,$e9,$c9,$e9,$da,$e9,$ec,$e9,$fd
		dc.b	$ea,$f,$ea,$20,$ea,$32,$ea,$43,$ea,$55,$ea,$66,$ea,$78,$ea,$89
		dc.b	$ea,$9b,$ea,$ac,$ea,$be,$ea,$cf,$ea,$e0,$ea,$f2,$eb,$3,$eb,$15
		dc.b	$eb,$26,$eb,$38,$eb,$49,$eb,$5a,$eb,$6c,$eb,$7d,$eb,$8f,$eb,$a0
		dc.b	$eb,$b1,$eb,$c3,$eb,$d4,$eb,$e5,$eb,$f7,$ec,$8,$ec,$1a,$ec,$2b
		dc.b	$ec,$3c,$ec,$4e,$ec,$5f,$ec,$70,$ec,$82,$ec,$93,$ec,$a4,$ec,$b5
		dc.b	$ec,$c7,$ec,$d8,$ec,$e9,$ec,$fb,$ed,$c,$ed,$1d,$ed,$2e,$ed,$40
		dc.b	$ed,$51,$ed,$62,$ed,$74,$ed,$85,$ed,$96,$ed,$a7,$ed,$b8,$ed,$ca
		dc.b	$ed,$db,$ed,$ec,$ed,$fd,$ee,$f,$ee,$20,$ee,$31,$ee,$42,$ee,$53
		dc.b	$ee,$65,$ee,$76,$ee,$87,$ee,$98,$ee,$a9,$ee,$ba,$ee,$cc,$ee,$dd
		dc.b	$ee,$ee,$ee,$ff,$ef,$10,$ef,$21,$ef,$32,$ef,$43,$ef,$55,$ef,$66
		dc.b	$ef,$77,$ef,$88,$ef,$99,$ef,$aa,$ef,$bb,$ef,$cc,$ef,$dd,$ef,$ee
		dc.b	$f0,$0,$f0,$11,$f0,$22,$f0,$33,$f0,$44,$f0,$55,$f0,$66,$f0,$77
		dc.b	$f0,$88,$f0,$99,$f0,$aa,$f0,$bb,$f0,$cc,$f0,$dd,$f0,$ee,$f0,$ff
		dc.b	$f1,$10,$f1,$21,$f1,$32,$f1,$43,$f1,$54,$f1,$65,$f1,$76,$f1,$87
		dc.b	$f1,$98,$f1,$a9,$f1,$ba,$f1,$cb,$f1,$dc,$f1,$ec,$f1,$fd,$f2,$e
		dc.b	$f2,$1f,$f2,$30,$f2,$41,$f2,$52,$f2,$63,$f2,$74,$f2,$85,$f2,$96
		dc.b	$f2,$a6,$f2,$b7,$f2,$c8,$f2,$d9,$f2,$ea,$f2,$fb,$f3,$c,$f3,$1c
		dc.b	$f3,$2d,$f3,$3e,$f3,$4f,$f3,$60,$f3,$71,$f3,$81,$f3,$92,$f3,$a3
		dc.b	$f3,$b4,$f3,$c5,$f3,$d6,$f3,$e6,$f3,$f7,$f4,$8,$f4,$19,$f4,$29
		dc.b	$f4,$3a,$f4,$4b,$f4,$5c,$f4,$6d,$f4,$7d,$f4,$8e,$f4,$9f,$f4,$b0
		dc.b	$f4,$c0,$f4,$d1,$f4,$e2,$f4,$f2,$f5,$3,$f5,$14,$f5,$25,$f5,$35
		dc.b	$f5,$46,$f5,$57,$f5,$67,$f5,$78,$f5,$89,$f5,$99,$f5,$aa,$f5,$bb
		dc.b	$f5,$cb,$f5,$dc,$f5,$ed,$f5,$fd,$f6,$e,$f6,$1f,$f6,$2f,$f6,$40
		dc.b	$f6,$51,$f6,$61,$f6,$72,$f6,$82,$f6,$93,$f6,$a4,$f6,$b4,$f6,$c5
		dc.b	$f6,$d6,$f6,$e6,$f6,$f7,$f7,$7,$f7,$18,$f7,$28,$f7,$39,$f7,$4a
		dc.b	$f7,$5a,$f7,$6b,$f7,$7b,$f7,$8c,$f7,$9c,$f7,$ad,$f7,$bd,$f7,$ce
		dc.b	$f7,$de,$f7,$ef,$f8,$0,$f8,$10,$f8,$21,$f8,$31,$f8,$42,$f8,$52
		dc.b	$f8,$63,$f8,$73,$f8,$83,$f8,$94,$f8,$a4,$f8,$b5,$f8,$c5,$f8,$d6
		dc.b	$f8,$e6,$f8,$f7,$f9,$7,$f9,$18,$f9,$28,$f9,$39,$f9,$49,$f9,$59
		dc.b	$f9,$6a,$f9,$7a,$f9,$8b,$f9,$9b,$f9,$ab,$f9,$bc,$f9,$cc,$f9,$dd
		dc.b	$f9,$ed,$f9,$fd,$fa,$e,$fa,$1e,$fa,$2f,$fa,$3f,$fa,$4f,$fa,$60
		dc.b	$fa,$70,$fa,$80,$fa,$91,$fa,$a1,$fa,$b1,$fa,$c2,$fa,$d2,$fa,$e2
		dc.b	$fa,$f3,$fb,$3,$fb,$13,$fb,$24,$fb,$34,$fb,$44,$fb,$55,$fb,$65
		dc.b	$fb,$75,$fb,$85,$fb,$96,$fb,$a6,$fb,$b6,$fb,$c7,$fb,$d7,$fb,$e7
		dc.b	$fb,$f7,$fc,$8,$fc,$18,$fc,$28,$fc,$38,$fc,$49,$fc,$59,$fc,$69
		dc.b	$fc,$79,$fc,$8a,$fc,$9a,$fc,$aa,$fc,$ba,$fc,$ca,$fc,$db,$fc,$eb
		dc.b	$fc,$fb,$fd,$b,$fd,$1b,$fd,$2c,$fd,$3c,$fd,$4c,$fd,$5c,$fd,$6c
		dc.b	$fd,$7c,$fd,$8d,$fd,$9d,$fd,$ad,$fd,$bd,$fd,$cd,$fd,$dd,$fd,$ed
		dc.b	$fd,$fd,$fe,$e,$fe,$1e,$fe,$2e,$fe,$3e,$fe,$4e,$fe,$5e,$fe,$6e
		dc.b	$fe,$7e,$fe,$8e,$fe,$9f,$fe,$af,$fe,$bf,$fe,$cf,$fe,$df,$fe,$ef
		dc.b	$fe,$ff,$ff,$f,$ff,$1f,$ff,$2f,$ff,$3f,$ff,$4f,$ff,$5f,$ff,$6f
		dc.b	$ff,$7f,$ff,$8f,$ff,$9f,$ff,$af,$ff,$bf,$ff,$cf,$ff,$df,$ff,$ef

L3795a_InvMatrixVectorMult:
		move.w	12(a0),d0
		muls	d5,d0
		move.w	6(a0),d6
		muls	d4,d6
		add.l	d6,d0
		move.w	(a0)+,d6
		muls	d3,d6
		add.l	d6,d0
		add.l	d0,d0
		move.w	12(a0),d1
		muls	d5,d1
		move.w	6(a0),d6
		muls	d4,d6
		add.l	d6,d1
		move.w	(a0)+,d6
		muls	d3,d6
		add.l	d6,d1
		add.l	d1,d1
		move.w	12(a0),d2
		muls	d5,d2
		move.w	6(a0),d6
		muls	d4,d6
		add.l	d6,d2
		move.w	(a0)+,d6
		muls	d3,d6
		add.l	d6,d2
		add.l	d2,d2
		rts

L3799e_MatrixVectorMult:
		move.w	(a0)+,d0
		muls	d3,d0
		move.w	(a0)+,d6
		muls	d4,d6
		add.l	d6,d0
		move.w	(a0)+,d6
		muls	d5,d6
		add.l	d6,d0
		add.l	d0,d0
		move.w	(a0)+,d1
		muls	d3,d1
		move.w	(a0)+,d6
		muls	d4,d6
		add.l	d6,d1
		move.w	(a0)+,d6
		muls	d5,d6
		add.l	d6,d1
		add.l	d1,d1
		move.w	(a0)+,d2
		muls	d3,d2
		move.w	(a0)+,d6
		muls	d4,d6
		add.l	d6,d2
		move.w	(a0)+,d6
		muls	d5,d6
		add.l	d6,d2
		add.l	d2,d2
		rts

* x,y angles in d0,d1.
* Make rotation matrix in (a1)
L379d6_MakeRotXYMatrix:
		move.l	a0,-(a7)
		movem.w	d0-1,-(a7)
		addi.w	#$4000,d0
		lea	L2c5de_sine_table,a0
		bclr	#$f,d0
		beq.s	l379fa
		lsr.w	#3,d0
		andi.w	#$fffe,d0
		move.w	0(a0,d0.w),d2
		neg.w	d2
		bra.s	l37a04
	l379fa:	lsr.w	#3,d0
		andi.w	#$fffe,d0
		move.w	0(a0,d0.w),d2
		* now d2 = cos (input d0)
	l37a04:	addi.w	#$4000,d1
		bclr	#$f,d1
		beq.s	l37a1c
		lsr.w	#3,d1
		andi.w	#$fffe,d1
		move.w	0(a0,d1.w),d3
		neg.w	d3
		bra.s	l37a26
	l37a1c:	lsr.w	#3,d1
		andi.w	#$fffe,d1
		move.w	0(a0,d1.w),d3
		* now d3 = cos (input d1)
	l37a26:	movem.w	(a7)+,d4-5
		bclr	#$f,d4
		beq.s	l37a3e
		lsr.w	#3,d4
		andi.w	#$fffe,d4
		move.w	0(a0,d4.w),d0
		neg.w	d0
		bra.s	l37a48
	l37a3e:	lsr.w	#3,d4
		andi.w	#$fffe,d4
		move.w	0(a0,d4.w),d0
		* now d0 = sin (input d0)
	l37a48:	bclr	#$f,d5
		beq.s	l37a5c
		lsr.w	#3,d5
		andi.w	#$fffe,d5
		move.w	0(a0,d5.w),d1
		neg.w	d1
		bra.s	l37a66
	l37a5c:	lsr.w	#3,d5
		andi.w	#$fffe,d5
		move.w	0(a0,d5.w),d1
		* now d1 = sin (input d1)
	l37a66:	movem.w	d0-3,-(a7)
		muls	d0,d1
		add.l	d1,d1
		swap	d1
		* 10(a1) = sin(d0)*sin(d1)
		move.w	d1,10(a1)
		muls	d2,d3
		add.l	d3,d3
		swap	d3
		* 0(a1) = cos(d0)*cos(d1)
		move.w	d3,0(a1)
		movem.w	(a7),d0-3
		muls	d2,d1
		add.l	d1,d1
		swap	d1
		neg.w	d1
		* 4(a1) = cos(d0)*sin(d1)
		move.w	d1,4(a1)
		muls	d0,d3
		add.l	d3,d3
		swap	d3
		neg.w	d3
		* 6(a1) = sin(d0)*cos(d1)
		move.w	d3,6(a1)
		movem.w	(a7)+,d0-3
		* 2(a1) = sin(d0)
		move.w	d0,2(a1)
		* 12(a1) = sin(d1)
		move.w	d1,12(a1)
		* 8(a1) = cos(d0)
		move.w	d2,8(a1)
		* 16(a1) = cos(d1)
		move.w	d3,16(a1)
		clr.w	14(a1)
		movea.l	(a7)+,a0
		rts

* x,z angles in d0,d1.
* Make rotation matrix in (a1)
L37ab6_MakeRotXZMatrix:
		move.l	a0,-(a7)
		movem.w	d0-1,-(a7)
		addi.w	#$4000,d0
		lea	L2c5de_sine_table,a0
		bclr	#$f,d0
		beq.s	l37ada
		lsr.w	#3,d0
		andi.w	#$fffe,d0
		move.w	0(a0,d0.w),d2
		neg.w	d2
		bra.s	l37ae4
	l37ada:	lsr.w	#3,d0
		andi.w	#$fffe,d0
		move.w	0(a0,d0.w),d2
		* d2 = cos(d0)
	l37ae4:	addi.w	#$4000,d1
		bclr	#$f,d1
		beq.s	l37afc
		lsr.w	#3,d1
		andi.w	#$fffe,d1
		move.w	0(a0,d1.w),d3
		neg.w	d3
		bra.s	l37b06
	l37afc:	lsr.w	#3,d1
		andi.w	#$fffe,d1
		move.w	0(a0,d1.w),d3
		* d3 = cos(d1)
	l37b06:	movem.w	(a7)+,d4-5
		bclr	#$f,d4
		beq.s	l37b1e
		lsr.w	#3,d4
		andi.w	#$fffe,d4
		move.w	0(a0,d4.w),d0
		neg.w	d0
		bra.s	l37b28
	l37b1e:	lsr.w	#3,d4
		andi.w	#$fffe,d4
		move.w	0(a0,d4.w),d0
		* d0 = sin (d0)
	l37b28:	bclr	#$f,d5
		beq.s	l37b3c
		lsr.w	#3,d5
		andi.w	#$fffe,d5
		move.w	0(a0,d5.w),d1
		neg.w	d1
		bra.s	l37b46
	l37b3c:	lsr.w	#3,d5
		andi.w	#$fffe,d5
		move.w	0(a0,d5.w),d1
		* d1 = sin (d1)
	l37b46:	movem.w	d0-3,-(a7)
		muls	d0,d1
		add.l	d1,d1
		swap	d1
		* 12(a1) = sin(d0)*sin(d1)
		move.w	d1,12(a1)
		muls	d2,d3
		add.l	d3,d3
		swap	d3
		* 2(a1) = cos(d0)*cos(d1)
		move.w	d3,2(a1)
		movem.w	(a7),d0-3
		muls	d2,d1
		add.l	d1,d1
		swap	d1
		neg.w	d1
		* 0(a1) = cos(d0)*sin(d1)
		move.w	d1,0(a1)
		muls	d0,d3
		add.l	d3,d3
		swap	d3
		neg.w	d3
		* 14(a1) = sin(d0)*cos(d1)
		move.w	d3,14(a1)
		movem.w	(a7)+,d0-3
		neg.w	d0
		* 4(a1) = -sin(d0)
		move.w	d0,4(a1)
		* 8(a1) = sin(d1)
		move.w	d1,8(a1)
		neg.w	d2
		* 16(a1) = -cos(d0)
		move.w	d2,16(a1)
		* 6(a1) = cos(d1)
		move.w	d3,6(a1)
		clr.w	10(a1)
		movea.l	(a7)+,a0
		rts

* in: d0, d1
* out:
* d0 = -cos (d0) . sin (d1)
* d1 =  sin (d0) . sin (d1)
* d2 =  cos (d1)
* d3 =  sin (d0)
L37b9a:
		move.w	d0,d3
		move.w	d1,d2
		addi.w	#$4000,d0
		lea	L2c5de_sine_table,a0
		bclr	#$f,d0
		beq.s	l37bbc
		lsr.w	#3,d0
		andi.w	#$fffe,d0
		move.w	0(a0,d0.w),d0
		neg.w	d0
		bra.s	l37bc6
	l37bbc:	lsr.w	#3,d0
		andi.w	#$fffe,d0
		move.w	0(a0,d0.w),d0
		* now d0 = cos (input d0)
	l37bc6:	bclr	#$f,d1
		beq.s	l37bda
		lsr.w	#3,d1
		andi.w	#$fffe,d1
		move.w	0(a0,d1.w),d1
		neg.w	d1
		bra.s	l37be4
	l37bda:	lsr.w	#3,d1
		andi.w	#$fffe,d1
		move.w	0(a0,d1.w),d1
		* now d1 = sin (input d1)
	l37be4:	addi.w	#$4000,d2
		bclr	#$f,d2
		beq.s	l37bfc
		lsr.w	#3,d2
		andi.w	#$fffe,d2
		move.w	0(a0,d2.w),d2
		neg.w	d2
		bra.s	l37c06
	l37bfc:	lsr.w	#3,d2
		andi.w	#$fffe,d2
		move.w	0(a0,d2.w),d2
		* now d2 = cos (input d1)
	l37c06:	bclr	#$f,d3
		beq.s	l37c1a
		lsr.w	#3,d3
		andi.w	#$fffe,d3
		move.w	0(a0,d3.w),d3
		neg.w	d3
		bra.s	l37c24
	l37c1a:	lsr.w	#3,d3
		andi.w	#$fffe,d3
		move.w	0(a0,d3.w),d3
		* now d3 = sin (input d0)
	l37c24:	muls	d1,d0
		add.l	d0,d0
		swap	d0
		neg.w	d0
		muls	d3,d1
		add.l	d1,d1
		swap	d1
		rts

L37c34:
		cmp.w	#$140,d0
		bcs.s	l37cb8
		ext.l	d0
		ext.l	d1
		move.w	d3,d5
		ext.l	d5
		sub.l	d1,d5
		move.w	d2,d4
		ext.l	d4
		sub.l	d0,d4
		asl.l	#8,d0
		move.b	#$80,d0
		asl.l	#8,d1
		move.b	#$80,d1
		asl.l	#8,d5
		asl.l	#8,d4
		bpl.s	l37c8c
		neg.l	d4
	l37c5e:	asr.l	#1,d5
		lsr.l	#1,d4
		add.l	d5,d1
		sub.l	d4,d0
		cmp.l	#$40,d4
		blt.s	l37c86
	l37c6e:	cmp.l	#$13fc0,d0
		bge.s	l37c5e
		asr.l	#1,d5
		lsr.l	#1,d4
		sub.l	d5,d1
		add.l	d4,d0
		cmp.l	#$40,d4
		bge.s	l37c6e
	l37c86:	asr.l	#8,d0
		asr.l	#8,d1
		bra.s	l37cb8
	l37c8c:	asr.l	#1,d5
		lsr.l	#1,d4
		add.l	d5,d1
		add.l	d4,d0
		cmp.l	#$40,d4
		blt.s	l37cb4
	l37c9c:	cmp.l	#$40,d0
		blt.s	l37c8c
		asr.l	#1,d5
		lsr.l	#1,d4
		sub.l	d5,d1
		sub.l	d4,d0
		cmp.l	#$40,d4
		bge.s	l37c9c
	l37cb4:	asr.l	#8,d0
		asr.l	#8,d1
	l37cb8:	cmp.w	#$a8,d1
		bcs.s	l37d3c
		ext.l	d0
		ext.l	d1
		move.w	d3,d5
		ext.l	d5
		sub.l	d1,d5
		move.w	d2,d4
		ext.l	d4
		sub.l	d0,d4
		asl.l	#8,d0
		move.b	#$80,d0
		asl.l	#8,d1
		move.b	#$80,d1
		asl.l	#8,d4
		asl.l	#8,d5
		bpl.s	l37d10
		neg.l	d5
	l37ce2:	asr.l	#1,d4
		lsr.l	#1,d5
		sub.l	d5,d1
		add.l	d4,d0
		cmp.l	#$40,d5
		blt.s	l37d0a
	l37cf2:	cmp.l	#$a7c0,d1
		bge.s	l37ce2
		asr.l	#1,d4
		lsr.l	#1,d5
		add.l	d5,d1
		sub.l	d4,d0
		cmp.l	#$40,d5
		bge.s	l37cf2
	l37d0a:	asr.l	#8,d1
		asr.l	#8,d0
		rts

	l37d10:	asr.l	#1,d4
		lsr.l	#1,d5
		add.l	d4,d0
		add.l	d5,d1
		cmp.l	#$40,d5
		blt.s	l37d38
	l37d20:	cmp.l	#$40,d1
		blt.s	l37d10
		asr.l	#1,d4
		lsr.l	#1,d5
		sub.l	d4,d0
		sub.l	d5,d1
		cmp.l	#$40,d5
		bge.s	l37d20
	l37d38:	asr.l	#8,d1
		asr.l	#8,d0
	l37d3c:	rts

L37d3e:
		cmp.w	#$a9,d1
		bcs.s	l37d3c
		ext.l	d0
		ext.l	d1
		move.w	d3,d5
		ext.l	d5
		sub.l	d1,d5
		move.w	d2,d4
		ext.l	d4
		sub.l	d0,d4
		asl.l	#8,d0
		move.b	#$80,d0
		asl.l	#8,d1
		move.b	#$80,d1
		asl.l	#8,d4
		asl.l	#8,d5
		bpl.s	l37d10
		neg.l	d5
	l37d68:	asr.l	#1,d4
		lsr.l	#1,d5
		sub.l	d5,d1
		add.l	d4,d0
		cmp.l	#$40,d5
		blt.s	l37d90
	l37d78:	cmp.l	#$a8c0,d1
		bgt.s	l37d68
		asr.l	#1,d4
		lsr.l	#1,d5
		add.l	d5,d1
		sub.l	d4,d0
		cmp.l	#$40,d5
		bge.s	l37d78
	l37d90:	asr.l	#8,d1
		asr.l	#8,d0
		rts

L37d96:
		sub.l	d0,d3
		sub.l	d1,d4
		sub.l	d2,d5
	l37d9c:	asr.l	#1,d3
		asr.l	#1,d4
		lsr.l	#1,d5
		beq.s	l37dc2
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
	l37daa:	cmp.l	#$40,d2
		ble.s	l37d9c
		asr.l	#1,d3
		asr.l	#1,d4
		lsr.l	#1,d5
		beq.s	l37dc2
		sub.l	d3,d0
		sub.l	d4,d1
		sub.l	d5,d2
		bra.s	l37daa
	l37dc2:	move.l	d0,d3
		asl.l	#2,d0
		bvc.s	l37dcc
		move.l	d3,d0
		bra.s	l37dd6
	l37dcc:	move.l	d1,d4
		asl.l	#2,d1
		bvc.s	l37dd6
		move.l	d3,d0
		move.l	d4,d1
	l37dd6:	tst.l	d0
		bpl.s	l37de8
	l37dda:	cmp.l	#$ffffe100,d0
		bgt.s	l37df6
		asr.l	#1,d0
		asr.l	#1,d1
		bra.s	l37dda
	l37de8:	cmp.l	#$1f00,d0
		blt.s	l37df6
		asr.l	#1,d0
		asr.l	#1,d1
		bra.s	l37de8
	l37df6:	tst.l	d1
		bpl.s	l37e08
	l37dfa:	cmp.l	#$ffffe100,d1
		bgt.s	l37e16
		asr.l	#1,d0
		asr.l	#1,d1
		bra.s	l37dfa
	l37e08:	cmp.l	#$1f00,d1
		blt.s	l37e16
		asr.l	#1,d0
		asr.l	#1,d1
		bra.s	l37e08
	l37e16:	addi.w	#$a0,d0
		subi.w	#$54,d1
		neg.w	d1
		rts

L37e22:
		movem.w	d2-7,4(a7)
		add.w	d0,d2
		add.w	d1,d3
		add.w	d4,d2
		add.w	d5,d3
		add.w	d6,d2
		add.w	d7,d3
		asr.w	#2,d2
		asr.w	#2,d3
		sub.w	d0,d2
		bpl.s	l37e3e
		neg.w	d2
	l37e3e:	sub.w	d1,d3
		bpl.s	l37e44
		neg.w	d3
	l37e44:	add.w	d2,d3
		move.w	d3,52(a7)
		movem.w	4(a7),d2-3
		sub.w	d0,d6
		sub.w	d1,d7
		add.w	d2,d6
		add.w	d3,d7
		add.w	d2,d2
		add.w	d3,d3
		add.w	d2,d6
		add.w	d3,d7
		sub.w	d4,d6
		sub.w	d5,d7
		add.w	d4,d4
		add.w	d5,d5
		sub.w	d4,d6
		sub.w	d5,d7
		swap	d6
		swap	d7
		sub.w	d6,d6
		sub.w	d7,d7
		movem.l	d6-7,40(a7)
		add.w	8(a7),d4
		add.w	10(a7),d5
		sub.w	d2,d4
		sub.w	d3,d5
		add.w	d2,d2
		add.w	d3,d3
		sub.w	d2,d4
		sub.w	d3,d5
		move.w	d0,d6
		move.w	d1,d7
		add.w	d6,d6
		add.w	d7,d7
		add.w	d0,d6
		add.w	d1,d7
		add.w	d6,d4
		add.w	d7,d5
		swap	d4
		swap	d5
		sub.w	d4,d4
		sub.w	d5,d5
		sub.w	4(a7),d2
		sub.w	6(a7),d3
		sub.w	d6,d2
		sub.w	d7,d3
		swap	d2
		swap	d3
		sub.w	d2,d2
		sub.w	d3,d3
		swap	d0
		swap	d1
		sub.w	d0,d0
		sub.w	d1,d1
		movem.l	d0-1,24(a7)
		move.w	52(a7),d7
		cmp.w	#$4,d7
		bcc.s	l37efc
		move.w	#$2,d6
		asr.l	d6,d2
		asr.l	d6,d3
		move.w	#$4,d6
		asr.l	d6,d4
		asr.l	d6,d5
		movem.l	40(a7),d0-1
		move.w	#$6,d6
		asr.l	d6,d0
		asr.l	d6,d1
		move.l	#$3000e,48(a7)
		bra.w	L37f7e
	l37efc:	cmp.w	#$1e,d7
		bcc.s	l37f2a
		move.w	#$3,d6
		asr.l	d6,d2
		asr.l	d6,d3
		move.w	#$6,d6
		asr.l	d6,d4
		asr.l	d6,d5
		movem.l	40(a7),d0-1
		move.w	#$9,d6
		asr.l	d6,d0
		asr.l	d6,d1
		move.l	#$7000d,48(a7)
		bra.s	L37f7e
	l37f2a:	cmp.w	#$61a8,d7
		bcc.s	l37f58
		move.w	#$4,d6
		asr.l	d6,d2
		asr.l	d6,d3
		move.w	#$8,d6
		asr.l	d6,d4
		asr.l	d6,d5
		movem.l	40(a7),d0-1
		move.w	#$c,d6
		asr.l	d6,d0
		asr.l	d6,d1
		move.l	#$f000c,48(a7)
		bra.s	L37f7e
	l37f58:	move.w	#$5,d6
		asr.l	d6,d2
		asr.l	d6,d3
		move.w	#$a,d6
		asr.l	d6,d4
		asr.l	d6,d5
		movem.l	40(a7),d0-1
		move.w	#$f,d6
		asr.l	d6,d0
		asr.l	d6,d1
		move.l	#$1f000b,48(a7)

L37f7e:
		add.l	d4,d2
		add.l	d5,d3
		add.l	d0,d2
		add.l	d1,d3
		movem.l	d2-3,32(a7)
		add.l	d4,d4
		add.l	d5,d5
		add.l	d0,d0
		add.l	d1,d1
		move.l	d0,d2
		move.l	d1,d3
		add.l	d2,d2
		add.l	d3,d3
		add.l	d2,d0
		add.l	d3,d1
		add.l	d0,d4
		add.l	d1,d5
		movem.l	d4-5,16(a7)
		movem.l	d0-1,40(a7)
		rts

L37fb2_ProjectOvalXYZ:
		hcall	#Nu_PutOval
		movem.l	d0-2,12(a7)
		movem.w	d3-5,4(a7)
		move.w	d3,d0
		muls	d0,d0
		move.w	d4,d1
		muls	d1,d1
		add.l	d1,d0
		cmp.l	#$9c40,d0
		bcs.w	l38132
		bsr.w	L368e0_Sqrt
		move.w	d0,10(a7)
		swap	d3
		asr.l	#2,d3
		divs	d0,d3
		add.w	d6,d6
		muls	d6,d3
		add.l	d3,d3
		swap	d3
		swap	d4
		asr.l	#2,d4
		divs	d0,d4
		muls	d6,d4
		add.l	d4,d4
		swap	d4
		neg.w	d4
		moveq	#0,d5
		exg	d3,d4
		movem.w	d3-5,24(a7)
		movem.w	4(a7),d0-2/d7
		move.w	d0,d3
		muls	d2,d3
		add.l	d3,d3
		swap	d3
		swap	d3
		asr.l	#1,d3
		divs	d7,d3
		move.w	d1,d4
		muls	d2,d4
		add.l	d4,d4
		swap	d4
		swap	d4
		asr.l	#1,d4
		divs	d7,d4
		move.w	d7,d5
		neg.w	d5
		mulu	#$5555,d6
		add.l	d6,d6
		swap	d6
		muls	d6,d3
		add.l	d3,d3
		swap	d3
		muls	d6,d4
		add.l	d4,d4
		swap	d4
		muls	d6,d5
		add.l	d5,d5
		swap	d5

L38040:
		movem.w	d3-5,54(a7)

L38046:
		movem.l	12(a7),d0-2
		movem.w	24(a7),d3-5
		ext.l	d3
		ext.l	d4
		ext.l	d5
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
		movem.l	d0-2,30(a7)
		bsr.w	L3810e
		movem.w	d0-1,92(a7)
		movem.w	d0-1,76(a7)
		movem.w	54(a7),d3-5
		ext.l	d3
		ext.l	d4
		ext.l	d5
		movem.l	30(a7),d0-2
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
		bsr.w	L3810e
		movem.w	d0-1,80(a7)
		movem.l	30(a7),d0-2
		sub.l	d3,d0
		sub.l	d4,d1
		sub.l	d5,d2
		bsr.s	L3810e
		movem.w	d0-1,96(a7)
		movem.l	12(a7),d0-2
		movem.w	24(a7),d3-5
		ext.l	d3
		ext.l	d4
		ext.l	d5
		sub.l	d3,d0
		sub.l	d4,d1
		sub.l	d5,d2
		movem.l	d0-2,42(a7)
		bsr.s	L3810e
		movem.w	d0-1,104(a7)
		movem.w	d0-1,88(a7)
		movem.w	54(a7),d3-5
		ext.l	d3
		ext.l	d4
		ext.l	d5
		movem.l	42(a7),d0-2
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
		bsr.s	L3810e
		movem.w	d0-1,84(a7)
		movem.l	42(a7),d0-2
		sub.l	d3,d0
		sub.l	d4,d1
		sub.l	d5,d2
		bsr.s	L3810e
		movem.w	d0-1,100(a7)
		moveq	#1,d0
		rts

L3810e:
		cmp.l	#$40,d2
		blt.w	l38128
		* some round objects and stuff
		bsr.w	L35ea2_ZProject
		addi.w	#$a0,d0
		subi.w	#$54,d1
		neg.w	d1
		rts

	l38128:	addq.l	#4,a7
		moveq	#0,d0
		rts

	l3812e:	move.w	60(a7),d6
	l38132:	move.w	d6,d3
		moveq	#0,d4
		moveq	#0,d5
		movem.w	d3-5,24(a7)
		moveq	#0,d3
		move.w	d6,d4
		mulu	#$aaaa,d4
		add.l	d4,d4
		swap	d4
		moveq	#0,d5
		bra.w	L38040

L38150_TubeEndShit:
		movem.l	d0-2,12(a7)
		movem.w	d3-5,4(a7)
		*hcall	#Nu_PutOval
		move.w	d6,60(a7)
		moveq	#0,d3
		move.l	#$4000,d5
		move.l	d2,d4
		bpl.s	l3816e
		neg.l	d4
	l3816e:	cmp.l	d5,d4
		blt.s	l3817a
	l38172:	addq.w	#1,d3
		lsr.l	#1,d4
		cmp.l	d5,d4
		bge.s	l38172
	l3817a:	move.l	d0,d4
		bpl.s	l38180
		neg.l	d4
	l38180:	lsr.l	d3,d4
		cmp.l	d5,d4
		blt.s	l3818e
	l38186:	addq.w	#1,d3
		lsr.l	#1,d4
		cmp.l	d5,d4
		bge.s	l38186
	l3818e:	move.l	d1,d4
		bpl.s	l38194
		neg.l	d4
	l38194:	lsr.l	d3,d4
		cmp.l	d5,d4
		blt.s	l381a2
	l3819a:	addq.w	#1,d3
		lsr.l	#1,d4
		cmp.l	d5,d4
		bge.s	l3819a
	l381a2:	asr.l	d3,d0
		asr.l	d3,d1
		asr.l	d3,d2
		movem.w	4(a7),d3-5
		move.w	d1,d6
		muls	d5,d6
		move.w	d4,d7
		muls	d2,d7
		sub.l	d7,d6
		add.l	d6,d6
		swap	d6
		move.w	d6,-(a7)
		move.w	d2,d6
		muls	d3,d6
		move.w	d5,d7
		muls	d0,d7
		sub.l	d7,d6
		add.l	d6,d6
		swap	d6
		move.w	d6,-(a7)
		move.w	d0,d2
		muls	d4,d2
		move.w	d3,d7
		muls	d1,d7
		sub.l	d7,d2
		add.l	d2,d2
		swap	d2
		move.w	(a7)+,d1
		move.w	(a7)+,d0
		movem.w	d0-2,24(a7)
		bsr.w	L368d6_VectorLen
		move.w	60(a7),d6
		tst.l	d0
		beq.w	l38132
		move.w	d0,10(a7)
		swap	d6
		asr.l	#1,d6
		divs	d0,d6
		bvs.w	l3812e
		movem.w	24(a7),d3-5
		muls	d6,d3
		add.l	d3,d3
		swap	d3
		muls	d6,d4
		add.l	d4,d4
		swap	d4
		muls	d6,d5
		add.l	d5,d5
		swap	d5
		movem.w	d3-5,24(a7)
		movem.w	4(a7),d0-2
		move.w	d1,d6
		muls	d5,d6
		move.w	d4,d7
		muls	d2,d7
		sub.l	d7,d6
		add.l	d6,d6
		swap	d6
		move.w	d6,-(a7)
		move.w	d2,d6
		muls	d3,d6
		move.w	d5,d7
		muls	d0,d7
		sub.l	d7,d6
		add.l	d6,d6
		swap	d6
		move.w	d6,-(a7)
		move.w	d0,d2
		muls	d4,d2
		move.w	d3,d7
		muls	d1,d7
		sub.l	d7,d2
		add.l	d2,d2
		swap	d2
		move.w	(a7)+,d1
		move.w	(a7)+,d0
		move.w	#$aaaa,d6
		muls	d6,d0
		add.l	d0,d0
		add.l	d0,d0
		swap	d0
		muls	d6,d1
		add.l	d1,d1
		add.l	d1,d1
		swap	d1
		muls	d6,d2
		add.l	d2,d2
		add.l	d2,d2
		swap	d2
		movem.w	d0-2,54(a7)
		bra.w	L38046

* angle in d7. Angles are in form of 32768 = 360 degrees.
* This is squished to the sin table's 4096 = 360 degrees. (2 bytes per value)
* Vectors v1 (in a0), v2 (in a1) are perpendicular. This fucking function
* rotates them about the 3rd perpendicular thingy in 3dness.
* 
* Does: v1' =  v2*sin(ang) + v1*cos(ang)
*       v2' = -v1*sin(ang) + v2*cos(ang)

L3827e_RotateAxisPair:
		move.w	d7,d6
		lea	L2c5de_sine_table,a2
		bclr	#$f,d7
		beq.s	l3829a
		lsr.w	#3,d7
		andi.w	#$fffe,d7
		move.w	0(a2,d7.w),d7
		neg.w	d7
		bra.s	l382a4
	l3829a:	lsr.w	#3,d7
		andi.w	#$fffe,d7
		move.w	0(a2,d7.w),d7
	l382a4:	addi.w	#$4000,d6
		bclr	#$f,d6
		beq.s	l382bc
		lsr.w	#3,d6
		andi.w	#$fffe,d6
		move.w	0(a2,d6.w),d6
		neg.w	d6
		bra.s	l382c6
	l382bc:	lsr.w	#3,d6
		andi.w	#$fffe,d6
		move.w	0(a2,d6.w),d6
		* So dandy. d7 = sin(ang), d6 = cos(ang)
	l382c6:	move.w	(a0),d0
		move.w	6(a0),d1
		move.w	12(a0),d2
		move.w	(a1),d3
		move.w	6(a1),d4
		move.w	12(a1),d5
		movem.w	d0-5,-(a7)
		muls	d6,d0
		muls	d6,d1
		muls	d6,d2
		muls	d7,d3
		muls	d7,d4
		muls	d7,d5
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
		add.l	d0,d0
		add.l	d1,d1
		add.l	d2,d2
		swap	d0
		swap	d1
		swap	d2
		move.w	d0,(a0)
		move.w	d1,6(a0)
		move.w	d2,12(a0)
		movem.w	(a7)+,d0-5
		muls	d7,d0
		muls	d7,d1
		muls	d7,d2
		muls	d6,d3
		muls	d6,d4
		muls	d6,d5
		sub.l	d0,d3
		sub.l	d1,d4
		sub.l	d2,d5
		add.l	d3,d3
		add.l	d4,d4
		add.l	d5,d5
		swap	d3
		swap	d4
		swap	d5
		move.w	d3,(a1)
		move.w	d4,6(a1)
		move.w	d5,12(a1)
		rts

L38594_InsertIntoZTree:
		move.l	L385d0_3dview_thing2,d5
	l3859a:	movea.l	d5,a0
		cmp.l	(a0),d4
		bhi.s	l385ac
		move.l	4(a0),d5
		bne.s	l3859a
		move.l	a1,4(a0)
		bra.s	l385b6
	l385ac:	move.l	8(a0),d5
		bne.s	l3859a
		move.l	a1,8(a0)
	l385b6:	move.l	d4,(a1)
		moveq	#0,d4
		move.l	d4,4(a1)
		move.l	d4,8(a1)
		lea	12(a1),a1
	l385c0:	rts

Fn_Draw3DView:
		tst.w	gl_renderer_on
		bne.s	l385c0
		bra.w	L3866e_Draw3DView

L385c8_primitives_end:
		ds.b	4

L385cc_primitives_base:
		ds.b	4

L385d0_3dview_thing2:
		ds.b	16

L385e0_3dview_thing3:
		ds.b	4

L385e4_3dview_word1:
		dc.b	$0,$0

L385e6_3dview_word2:
		dc.b	$0,$0

L385e8_3dview_word3:
		dc.b	$0,$0

L385ea_Clear3DView:
		clr.b	L385e8_3dview_word3
		movea.l	L385cc_primitives_base,a0
		move.l	a0,L385d0_3dview_thing2
		moveq	#0,d0
		moveq	#0,d1
		moveq	#0,d2
		movem.l	d0-2,(a0)
		lea	12(a0),a0
		move.w	#-8,(a0)+
		move.l	a0,L385c8_primitives_end
		move.w	#$4,L5dae_dyn_cols
		clr.l	L5db0
		move.b	#$fc,L2e6f2
		move.w	#$3c,L5eae
		move.w	L9d3a,L9cd6_main_pal1_col14
		move.w	L9d3a,L9cf6_main_pal2_col14
		
		hcall	#Nu_3DViewInit
		rts

L38648_Alloc3DViewMem:
		movea.l	a7,a0
		suba.l	#$ff9a,a0
		move.l	a0,L385c8_primitives_end
		move.l	a0,L385cc_primitives_base
		move.l	a0,L385d0_3dview_thing2
		rts

* prim2d -106
:		lea	14(a0),a0
		movem.l	a5-6,-(a7)
		bra.s	l38678

L3866e_Draw3DView:
		*rts

		*nop
		movem.l	a5-6,-(a7)
		movea.l	L385cc_primitives_base,a0
	l38678:	move.l	a0,d0
	l3867a:	movea.l	d0,a0
		move.l	a0,-(a7)
		move.l	8(a0),d0
		bne.s	l3867a
		move.w	12(a0),d0
		jsr	L386ce(pc,d0.w)
	l3868c:	movea.l	(a7)+,a0
		move.l	4(a0),d0
		bne.s	l3867a
		movea.l	(a7),a0
		move.w	12(a0),d0
		jsr	L386ce(pc,d0.w)
		bra.s	l3868c
		
:		movea.w	(a0)+,a1
		move.l	a0,L385e0_3dview_thing3
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,a1.w),a0
		bsr.w	L3524c_DrawCurvybit
		movea.l	L385e0_3dview_thing3,a0
		bsr.w	L3506e
		move.w	(a0)+,d0
		jmp	L386ce(pc,d0.w)

L386c6:
		addq.l	#8,a7
		movem.l	(a7)+,a5-6
		rts

L386ce:
		lea	2(a0),a0
	l386d2:	move.l	a0,-(a7)
		move.w	12(a0),d0
		jsr	L386c6(pc,d0.w)
		movea.l	(a7)+,a0
		adda.w	L385e6_3dview_word2(pc),a0
		bra.s	l386d2
		
:		move.w	#$0,L385e6_3dview_word2
		addq.l	#8,a7
		rts

:		nop
		nop
		nop
		nop
		
:		bsr.w	L3506e
		lea	14(a0),a0
	l38700:	move.w	(a0)+,d0
		jmp	L386ce(pc,d0.w)
		
:		movem.w	(a0)+,d0-3
		bsr.w	L350e2
		move.w	(a0)+,d0
		jmp	L386ce(pc,d0.w)
		
:		movem.w	-6(a0),d0-1
		movem.w	(a0)+,d2-3
		bsr.w	L350e2
	l38722:	move.w	(a0)+,d0
		jmp	L386ce(pc,d0.w)
	
* 2dprim 0x5a
:		movem.w	(a0)+,d0-7
		bsr.w	L35028
		bra.s	l38700
:		addq.l	#4,a0
		bra.s	l38700
:		movea.w	(a0)+,a1
		move.l	a0,L385e0_3dview_thing3
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,a1.w),a0
		bsr.w	L3524c_DrawCurvybit
		movea.l	L385e0_3dview_thing3,a0
		suba.l	4(a7),a0
		lea	-12(a0),a0
		move.w	a0,L385e6_3dview_word2
		rts

		
:		nop
		nop
		nop
		nop
		
* object drawer: planets and stars (the round thingy bit)
:		bsr.w	L358b6
		lea	14(a0),a0
		bra.s	l38722

:		movem.w	(a0)+,d0-3/a1
		move.l	a0,-(a7)
		movea.w	a1,a0
		bsr.w	L3591e
		movea.l	(a7)+,a0
		bra.s	l38722

:		movem.w	(a0)+,d0-7/a1
		move.l	a0,-(a7)
		movea.w	a1,a0
		bsr.w	L35c3a
		movea.l	(a7)+,a0
		bra.s	l38722

:		movem.w	(a0)+,d0-1
		bsr.w	L358aa
		bra.s	l38722

:		movem.w	(a0)+,d0-7
		move.l	a0,L385e0_3dview_thing3
		* dark side of planet
		lea	L5dae_dyn_cols,a0
		move.w	4(a0,d0.w),d0
		move.w	4(a0,d1.w),d1
		move.w	4(a0,d2.w),d2
		move.w	4(a0,d3.w),d3
		move.w	4(a0,d4.w),d4
		move.w	4(a0,d5.w),d5
		move.w	4(a0,d6.w),d6
		move.w	4(a0,d7.w),d7
		movea.l	L385e0_3dview_thing3,a0
		movem.w	d0-7,-(a7)
		lea	L35b28_DrawPlanet(pc),a1
	* phantom l387dc:
	l387dc:	movem.w	(a0)+,d0-7
		move.l	a0,L385e0_3dview_thing3
		* colours for light side of planet
		lea	L5dae_dyn_cols,a0
		move.w	4(a0,d0.w),d0
		move.w	4(a0,d1.w),d1
		move.w	4(a0,d2.w),d2
		move.w	4(a0,d3.w),d3
		move.w	4(a0,d4.w),d4
		move.w	4(a0,d5.w),d5
		move.w	4(a0,d6.w),d6
		move.w	4(a0,d7.w),d7
		jsr	(a1)
		movea.l	L385e0_3dview_thing3,a0
		suba.l	4(a7),a0
		lea	-12(a0),a0
		move.w	a0,L385e6_3dview_word2
		rts
:		lea	L35b5e(pc),a1
		* $60,$b2 is 'bra.s l387dc', but it overlaps with data label.
		bra.s	l387dc
		*dc.b	$60
		* XXX this bit is fucked up

*L38829:
*		dc.b	$b2,$0,$2,$2,$3,$4,$6,$7,$8
L38829:
		dc.b	$b2,$0,$2,$2,$3,$4,$6,$7

L38832:
		dc.b	$9,$2,$3,$5,$5,$6,$7,$8,$9,$a
:		move.w	#$c,L385e6_3dview_word2
:		movem.w	16(a0),d0-2/d6
		movem.l	a0/d0-2,-(a7)
		move.b	L38832(pc,d2.w),d2
		ext.w	d2
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,d6.w),a0
		bsr.w	L34bf8_DrawCircleClipped
		movem.l	(a7)+,d0-2/a0
		move.b	L38829(pc,d2.w),d2
		ext.w	d2
		move.w	14(a0),d6
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,d6.w),a0
		bra.w	L34bf8_DrawCircleClipped
	l3887e:	rts

	
:		move.w	#$c,L385e6_3dview_word2
:		movem.w	16(a0),d0/d3-4/d6
		asl.w	#5,d4
		movem.l	a0/d3-4/d0,-(a7)
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,d6.w),a0
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
		lea	L389fe(pc),a5
		lea	0(a5,d4.w),a5
		bsr.s	L388d2
		movem.l	(a7)+,d0/d3-4/a0
		move.w	14(a0),d6
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,d6.w),a0
		move.w	a0,line_draw_col
		lea	new_linecrap,a0

	* draws the twinkly distant object things
L388d2:
		subq.w	#7,d3
		addq.w	#2,d0
	l388d6:	addq.w	#1,d3
		move.b	(a5)+,d5
		beq.s	l388d6
		bmi.s	l3887e
		cmp.w	#$a8,d3
		bcc.s	l388d6
		ext.w	d5
		move.w	d0,d4
		sub.w	d5,d4
		bpl.s	l388ee
		moveq	#0,d4
	l388ee:	add.w	d5,d5
		subq.w	#1,d5
		move.w	d4,d1
		add.w	d5,d1
		cmp.w	#$140,d1
		blt.s	l38902
		move.w	#$13f,d5
		sub.w	d4,d5
	l38902:	move.w	d3,d1
		movea.l	L5da6_logscreen2,a3
		asl.w	#5,d1
		adda.w	d1,a3
		asl.w	#2,d1
		adda.w	d1,a3
		add.w	d5,d5
		movea.w	0(a0,d5.w),a2
		jsr	0(a0,a2.w)
		bra.s	l388d6
		ds.b	6
		dc.b	$1,$2,$1,$0,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$0
		dc.b	$0,$1,$0,$0,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$1
		dc.b	$1,$3,$1,$1,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$0
		dc.b	$0,$1,$0,$0,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$1
		dc.b	$0,$3,$0,$1,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$0
		dc.b	$1,$2,$1,$0,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$1,$1
		dc.b	$0,$4,$0,$1,$1,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$0
		dc.b	$1,$2,$1,$0,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$1,$1
		dc.b	$2,$4,$2,$1,$1,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$0
		dc.b	$1,$2,$1,$0,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$1,$0
		dc.b	$2,$4,$2,$0,$1,$0,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$1
		dc.b	$1,$3,$1,$1,$0,$0,$0,$0,$0,$ff,$0,$0,$0,$1,$1,$0
		dc.b	$2,$5,$2,$0,$1,$1,$0,$0,$0,$ff,$0,$0,$0,$0,$0,$1
		dc.b	$1,$3,$1,$1,$0,$0,$0,$0,$0,$ff

L389fe:
		dc.b	$0,$0,$0,$1,$1,$0,$0,$5,$0,$0,$1,$1,$0,$0,$0,$ff
		ds.b	5
		dc.b	$1,$2,$3,$2,$1,$0,$0,$0,$0,$0,$ff,$0,$0,$1,$1,$0
		dc.b	$2,$3,$6,$3,$2,$0,$1,$1,$0,$0,$ff,$0,$0,$0,$0,$1
		dc.b	$1,$2,$4,$2,$1,$1,$0,$0,$0,$0,$ff,$0,$1,$1,$0,$2
		dc.b	$0,$4,$7,$4,$0,$2,$0,$1,$1,$0,$ff,$0,$0,$0,$1,$1
		dc.b	$2,$3,$5,$3,$2,$1,$1,$0,$0,$0,$ff,$1,$1,$0,$0,$2
		dc.b	$3,$4,$8,$4,$3,$2,$0,$0,$1,$1,$ff,$0,$0,$1,$1,$1
		dc.b	$2,$3,$6,$3,$2,$1,$1,$1,$0,$0,$ff,$1,$1,$0,$2,$0
		dc.b	$0,$5,$8,$5,$0,$0,$2,$0,$1,$1,$ff,$0,$0,$1,$1,$2
		dc.b	$3,$4,$6,$4,$3,$2,$1,$1,$0,$0,$ff,$1,$0,$0,$2,$3
		dc.b	$4,$5,$8,$5,$4,$3,$2,$0,$0,$1,$ff,$0,$1,$1,$1,$2
		dc.b	$3,$4,$6,$4,$3,$2,$1,$1,$1,$0,$ff,$1,$0,$2,$0,$0
		dc.b	$0,$6,$8,$6,$0,$0,$0,$2,$0,$1,$ff,$0,$1,$1,$2,$3
		dc.b	$4,$5,$7,$5,$4,$3,$2,$1,$1,$0,$ff,$1,$0,$2,$3,$0
		dc.b	$5,$6,$8,$6,$5,$0,$3,$2,$0,$1,$ff,$0,$1,$1,$2,$4
		dc.b	$4,$5,$7,$5,$4,$4,$2,$1,$1,$0,$ff,$1,$0,$2,$0,$0
		dc.b	$0,$6,$8,$6,$0,$0,$0,$2,$0,$1,$ff,$0,$1,$1,$3,$4
		dc.b	$5,$5,$7,$5,$5,$4,$3,$1,$1,$0,$ff,$1,$0,$0,$4,$5
		dc.b	$0,$0,$8,$0,$0,$5,$4,$0,$0,$1,$ff,$0,$1,$2,$3,$4
		dc.b	$5,$6,$7,$6,$5,$4,$3,$2,$1,$0,$ff,$1,$0,$3,$0,$0
		dc.b	$6,$0,$8,$0,$6,$0,$0,$3,$0,$1,$ff,$0,$1,$2,$4,$5
		dc.b	$5,$6,$7,$6,$5,$5,$4,$2,$1,$0,$ff,$1,$2,$4,$0,$6
		dc.b	$0,$7,$8,$7,$0,$6,$0,$4,$2,$1,$ff,$0,$1,$3,$5,$5
		dc.b	$6,$6,$7,$6,$6,$5,$5,$3,$1,$0,$ff,$1,$3,$0,$0,$0
		dc.b	$7,$0,$8,$0,$7,$0,$0,$0,$3,$1,$ff,$0,$2,$4,$5,$6
		dc.b	$6,$7,$7,$7,$6,$6,$5,$4,$2,$0,$ff,$2,$4,$0,$0,$7
		dc.b	$0,$8,$8,$8,$0,$7,$0,$0,$4,$2,$ff,$0,$3,$5,$6,$6
		dc.b	$7,$7,$7,$7,$7,$6,$6,$5,$3,$0,$ff
	* Obj drawer: circles
:		move.w	#$a,L385e6_3dview_word2
:		move.w	14(a0),d6
		movem.w	16(a0),d0-2
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,d6.w),a0
		bra.w	L34bf8_DrawCircleClipped
	
	* 28 bytes span
	* Obj drawer: lines
:		move.w	#$c,L385e6_3dview_word2
:		movem.w	14(a0),d0-3/d6
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,d6.w),a0
		bra.w	L34d56_DrawStraightLine
		
	* 28 "" ""
	* Obj drawer: triangles
:		move.w	#$10,L385e6_3dview_word2
:		movem.w	14(a0),d0-6
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,d6.w),a0
		bra.w	L343ac_DrawTriangle
		
	* Obj drawer: quads
:		move.w	#$14,L385e6_3dview_word2
:		movem.w	14(a0),d0-7/a1
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,a1.w),a0
		bra.w	L34530_DrawQuad
	
	* Obj drawer: ellipses
:		move.w	#$14,L385e6_3dview_word2
:		movem.w	14(a0),d0-7/a1
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,a1.w),a0
		bra.w	L34f6a_DrawEllipse
		
:		nop
		nop
		nop
		nop
		
:		lea	14(a0),a5
		movem.w	(a5)+,d2/a1
		lea	L5dae_dyn_cols,a0
		movea.w	4(a0,a1.w),a0
		cmp.w	#$1,d2
		bge.s	l38cac
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
		move.w	(a5)+,d4
		bmi.s	l38c98
	l38c7e:	move.w	(a5)+,d1
		movea.l	L5da6_logscreen2,a3
		asl.w	#5,d1
		adda.w	d1,a3
		asl.w	#2,d1
		adda.w	d1,a3
		movea.w	(a0),a2
		* small bg stars and space dust
		jsr	0(a0,a2.w)
		move.w	(a5)+,d4
		bpl.s	l38c7e
	l38c98:	suba.l	4(a7),a5
		lea	-12(a5),a5
		move.w	a5,L385e6_3dview_word2
		rts

		
	l38ca8:	addq.l	#2,a5
		bra.s	l38cbe
	l38cac:	cmp.w	#$2,d2
		bne.s	l38d04
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
	l38cbe:	move.w	(a5)+,d4
		bmi.s	l38c98
	l38cc2:	beq.s	l38ca8
		subq.w	#1,d4
		move.w	(a5)+,d1
		beq.s	l38cbe
		movea.l	L5da6_logscreen2,a3
		asl.w	#5,d1
		adda.w	d1,a3
		asl.w	#2,d1
		adda.w	d1,a3
		movea.l	a3,a6
		moveq	#6,d5
		* big bg stars and space dust
		movea.w	6(a0),a2
		jsr	0(a0,a2.w)
		lea	-160(a6),a3
		addq.w	#1,d4
		movea.w	(a0),a2
		jsr	0(a0,a2.w)
		lea	160(a6),a3
		movea.w	(a0),a2
		jsr	0(a0,a2.w)
		move.w	(a5)+,d4
		bpl.s	l38cc2
		bra.s	l38c98
	l38d00:	addq.l	#2,a7
		bra.s	l38c98
		
	l38d04:	move.w	d2,-(a7)
		move.w	a0,line_draw_col
		lea	new_linecrap,a0
		move.w	(a5)+,d0
		bmi.s	l38d00
	l38d16:	move.w	(a5)+,d1
		move.w	(a7),d2
		bsr.w	L34c10
		move.w	(a5)+,d0
		bpl.s	l38d16
		bra.s	l38d00

:		move.w	#$2,L385e6_3dview_word2
		rts

		
		* Used to write system names in 3d starmap view
:		move.w	#$e,L385e6_3dview_word2
:		movem.w	14(a0),d0-5
		lea	-256(a7),a7
		lea	L5eb6_a6_base,a6
		lea	L45332_a5_jumptab,a5
		movea.l	a7,a0
		movem.w	d1-2,-(a7)
		bsr.w	L3e73a_GetFmtStr
		movem.w	(a7)+,d1-2
		movea.l	a7,a0
		bsr.w	L34268_DrawStrCol15
		lea	256(a7),a7
	l38d64:	rts

* (a0)+ matrix * returned L44ace
* result in 70(a0)+
L38d66_MatrixMulWTF:
		move.b	L60d0_gameloop_iter,d6
		cmp.b	92(a0),d6
		beq.s	l38d64
		moveq	#0,d0
		move.b	68(a0),d0
		move.l	a0,-(a7)
		jsr	L44ace
		movea.l	a0,a1
		movea.l	(a7)+,a0
		movem.w	0(a1),d0-2
		movea.l	a0,a2

		* 3x3 matrix * matrix mul.
		move.w	12(a2),d4
		muls	d2,d4
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d4
		add.l	d4,d4
		swap	d4
		move.w	12(a2),d5
		muls	d2,d5
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d5
		add.l	d5,d5
		swap	d5
		move.w	12(a2),d6
		muls	d2,d6
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d6
		add.l	d6,d6
		swap	d6

		movem.w	d4-6,70(a0)
		movem.w	6(a1),d0-2
		movea.l	a0,a2
		move.w	12(a2),d4
		muls	d2,d4
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d4
		add.l	d4,d4
		swap	d4
		move.w	12(a2),d5
		muls	d2,d5
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d5
		add.l	d5,d5
		swap	d5
		move.w	12(a2),d6
		muls	d2,d6
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d6
		add.l	d6,d6
		swap	d6
		
		movem.w	d4-6,76(a0)
		movem.w	12(a1),d0-2
		movea.l	a0,a2
		move.w	12(a2),d4
		muls	d2,d4
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d4
		add.l	d4,d4
		swap	d4
		move.w	12(a2),d5
		muls	d2,d5
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d5
		add.l	d5,d5
		swap	d5
		move.w	12(a2),d6
		muls	d2,d6
		move.w	6(a2),d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a2)+,d3
		muls	d0,d3
		add.l	d3,d6
		add.l	d6,d6
		swap	d6
		
		movem.w	d4-6,82(a0)
		move.b	L60d0_gameloop_iter,92(a0)
		rts

	l38e90:	movem.l	d0-5,-(a7)
		movem.l	44(a0),d0-5
		movem.l	d4-5/d1-2,-(a7)
		move.l	d0,d6
		move.l	d3,d7
		bpl.s	l38ea8
		not.l	d6
		not.l	d7
	l38ea8:	tst.l	d4
		bpl.s	l38eb0
		not.l	d1
		not.l	d4
	l38eb0:	tst.l	d5
		bpl.s	l38eb8
		not.l	d2
		not.l	d5
	l38eb8:	or.l	d1,d6
		or.l	d4,d7
		or.l	d2,d6
		or.l	d5,d7
		asl.l	#1,d6
		roxl.l	#1,d7
		beq.s	l38eee
		movem.l	(a7)+,d1-2/d4-5
		moveq	#0,d6
	l38ecc:	asr.l	#1,d3
		roxr.l	#1,d0
		asr.l	#1,d4
		roxr.l	#1,d1
		asr.l	#1,d5
		roxr.l	#1,d2
		addq.w	#1,d6
		lsr.l	#1,d7
		bne.s	l38ecc
		swap	d0
		asr.w	#1,d0
		swap	d1
		asr.w	#1,d1
		swap	d2
		asr.w	#1,d2
		moveq	#17,d7
		bra.s	l38f0c
	l38eee:	move.l	#$4000,d1
		cmp.l	d1,d6
		bcs.s	l38f00
	l38ef8:	addq.w	#1,d7
		lsr.l	#1,d6
		cmp.l	d1,d6
		bcc.s	l38ef8
	l38f00:	movem.l	(a7)+,d1-2/d4-5
		asr.l	d7,d0
		asr.l	d7,d1
		asr.l	d7,d2
		moveq	#0,d6
	l38f0c:	add.w	d6,d7
		move.w	(a2)+,d3
		muls	d0,d3
		move.w	(a2)+,d6
		muls	d1,d6
		add.l	d6,d3
		move.w	(a2)+,d6
		muls	d2,d6
		add.l	d6,d3
		add.l	d3,d3
		move.w	(a2)+,d4
		muls	d0,d4
		move.w	(a2)+,d6
		muls	d1,d6
		add.l	d6,d4
		move.w	(a2)+,d6
		muls	d2,d6
		add.l	d6,d4
		add.l	d4,d4
		move.w	(a2)+,d5
		muls	d0,d5
		move.w	(a2)+,d6
		muls	d1,d6
		add.l	d6,d5
		move.w	(a2)+,d6
		muls	d2,d6
		add.l	d6,d5
		add.l	d5,d5
		subi.w	#$30,d7
		neg.w	d7
		move.l	d3,d0
		move.l	d4,d1
		move.l	d5,d2
		move.w	d7,d6
		subi.w	#$20,d6
		bpl.s	l38f68
		asr.l	d7,d3
		asr.l	d7,d4
		asr.l	d7,d5
		neg.w	d6
		asl.l	d6,d0
		asl.l	d6,d1
		asl.l	d6,d2
		bra.s	l38f86
	l38f68:	swap	d3
		ext.l	d3
		swap	d3
		ext.l	d3
		swap	d4
		ext.l	d4
		swap	d4
		ext.l	d4
		swap	d5
		ext.l	d5
		swap	d5
		ext.l	d5
		asr.l	d6,d0
		asr.l	d6,d1
		asr.l	d6,d2
	l38f86:	add.l	(a7),d0
		move.l	d0,-(a7)
		movem.l	16(a7),d0/d6-7
		addx.l	d0,d3
		add.l	8(a7),d1
		addx.l	d6,d4
		add.l	12(a7),d2
		addx.l	d7,d5
		move.l	(a7)+,d0
		movem.l	d0-5,20(a0)
		move.b	L60d0_gameloop_iter,19(a0)
		lea	24(a7),a7
		rts

L38fb4:
		move.b	L60d0_gameloop_iter,d6

L38fba:
		moveq	#0,d0
		move.b	68(a0),d0
		beq.s	l39012
		cmp.b	19(a0),d6
		beq.s	l3900a
		move.l	a0,-(a7)
		jsr	L44ace
		bsr.s	L38fba
		movea.l	a0,a2
		movea.l	(a7)+,a0
		tst.b	69(a0)
		bne.w	l38e90
		add.l	44(a0),d0
		move.l	d0,-(a7)
		movem.l	56(a0),d0/d6-7
		addx.l	d0,d3
		add.l	48(a0),d1
		addx.l	d6,d4
		add.l	52(a0),d2
		addx.l	d7,d5
		move.l	(a7)+,d0
	l38ffa:	movem.l	d0-5,20(a0)
		move.b	L60d0_gameloop_iter,19(a0)
		rts

	l3900a:	movem.l	20(a0),d0-5
		rts

	l39012:	movem.l	44(a0),d0-5
		bra.s	l38ffa

L3901a:
		movea.l	a4,a0

L3901c:
		move.b	68(a3),d0
		cmp.b	68(a0),d0
		beq.s	l39050
		cmp.b	93(a0),d0
		beq.s	l3907e
	l3902c:	move.l	a2,-(a7)
		bsr.s	L38fb4
		movea.l	(a7)+,a2
		sub.l	20(a3),d0
		move.l	d0,-(a7)
		movem.l	32(a3),d0/d6-7
		subx.l	d0,d3
		sub.l	24(a3),d1
		subx.l	d6,d4
		sub.l	28(a3),d2
		subx.l	d7,d5
		move.l	(a7)+,d0
		rts

	l39050:	move.b	69(a0),d0
		cmp.b	69(a3),d0
		bne.s	l3902c
		movem.l	44(a0),d0-5
		sub.l	44(a3),d0
		move.l	d0,-(a7)
		movem.l	56(a3),d0/d6-7
		subx.l	d0,d3
		sub.l	48(a3),d1
		subx.l	d6,d4
		sub.l	52(a3),d2
		subx.l	d7,d5
		move.l	(a7)+,d0
		rts

	l3907e:	movem.l	44(a3),d0-5
		neg.l	d0
		negx.l	d3
		neg.l	d1
		negx.l	d4
		neg.l	d2
		negx.l	d5
		rts

	l39092:	move.l	-8(a6),d4
		move.w	14(a5),d2
		ext.l	d2
		move.w	-208(a6),d3
		asl.l	d3,d2
		add.l	d2,d2
		move.l	d2,-146(a6)
	l390a8:	cmp.l	#$8000,d4
		blt.s	l390b6
		asr.l	#1,d2
		lsr.l	#1,d4
		bra.s	l390a8
	l390b6:	asl.l	#8,d2
		divs	d4,d2
		move.w	18(a5),d6
		move.w	d6,d4
		lsr.w	#8,d4
		move.w	d4,-148(a6)
		andi.w	#$fff,d6
		lea	-20(a6),a0
		bsr.w	L3a68c
		unlk	a6
		rts

	l390d6:	moveq	#1,d0
		sub.w	16(a5),d7
		asl.b	d7,d0
		bvc.s	l390e2
		moveq	#127,d0
	l390e2:	move.b	d0,96(a4)
	l390e6:	move.l	#$80008000,110(a4)
		unlk	a6
		rts

L390f2:
		move.w	90(a6),d0
		movea.l	L973c_game_data,a5
		moveq	#0,d1
		move.w	0(a5,d0.w),d1
		adda.l	d1,a5
		movea.l	a6,a4
		link	a6,#-220
		bsr.w	L3901a
		movem.l	d4-5/d1-2,-(a7)
		move.l	d0,d6
		move.l	d3,d7
		bpl.s	l3911c
		not.l	d6
		not.l	d7
	l3911c:	tst.l	d4
		bpl.s	l39124
		not.l	d1
		not.l	d4
	l39124:	tst.l	d5
		bpl.s	l3912c
		not.l	d2
		not.l	d5
	l3912c:	or.l	d1,d6
		or.l	d4,d7
		or.l	d2,d6
		or.l	d5,d7
		asl.l	#1,d6
		roxl.l	#1,d7
		beq.s	l39162
		movem.l	(a7)+,d1-2/d4-5
		moveq	#0,d6
	l39140:	asr.l	#1,d3
		roxr.l	#1,d0
		asr.l	#1,d4
		roxr.l	#1,d1
		asr.l	#1,d5
		roxr.l	#1,d2
		addq.w	#1,d6
		lsr.l	#1,d7
		bne.s	l39140
		swap	d0
		asr.w	#1,d0
		swap	d1
		asr.w	#1,d1
		swap	d2
		asr.w	#1,d2
		moveq	#17,d7
		bra.s	l39180
	l39162:	move.l	#$4000,d1
		cmp.l	d1,d6
		bcs.s	l39174
	l3916c:	addq.w	#1,d7
		lsr.l	#1,d6
		cmp.l	d1,d6
		bcc.s	l3916c
	l39174:	movem.l	(a7)+,d1-2/d4-5
		asr.l	d7,d0
		asr.l	d7,d1
		asr.l	d7,d2
		moveq	#0,d6
	l39180:	add.w	d6,d7
		sub.w	88(a4),d7
		move.b	d7,95(a4)
		cmp.w	16(a5),d7
		bge.w	l390d6
		move.l	a4,-212(a6)
		clr.w	-156(a6)
		clr.b	96(a4)
		lea	0(a3),a0
		tst.b	69(a3)
		beq.s	l391cc
		movem.w	L60e8,d3-5
		movem.w	d3-5,-198(a6)
		tst.b	69(a4)
		bne.s	l391da
		move.b	68(a3),d6
		cmp.b	93(a4),d6
		beq.s	l391da
		lea	70(a3),a0
		bra.s	l391da
	l391cc:	movem.w	L60e2_lighting_vector,d3-5
		movem.w	d3-5,-198(a6)
	l391da:	movem.l	L60f6_light_tint_table,d3-6
		movem.l	d3-6,-104(a6)
		move.w	12(a0),d4
		muls	d2,d4
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d4
		add.l	d4,d4
		move.w	12(a0),d5
		muls	d2,d5
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d5
		add.l	d5,d5
		move.w	12(a0),d6
		muls	d2,d6
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d6
		add.l	d6,d6
		move.w	10(a5),-208(a6)
		move.w	12(a5),-192(a6)
		moveq	#16,d0
		sub.w	d7,d0
		add.w	12(a5),d0
		bpl.s	l3924a
		sub.w	d0,-192(a6)
		add.w	d0,-208(a6)
		moveq	#0,d0
	l3924a:	asr.l	d0,d4
		asr.l	d0,d5
		asr.l	d0,d6
		movem.l	d4-6,-16(a6)
		bsr.w	L39646_3DObjClipOffscreen
		bne.w	l390e6
		move.w	#$111,-154(a6)
		movem.l	-16(a6),d0-2
		cmp.l	#$40,d2
		blt.w	l3940e
		* Projection of little mini distant star twinkly things
		bsr.w	L35ea2_ZProject
		addi.w	#$a0,d0
		subi.w	#$54,d1
		neg.w	d1
		movem.w	d0-1,110(a4)
		cmp.w	20(a5),d7
		bge.w	l39092

L39290:
		tst.b	69(a3)
		beq.s	l392ba
		tst.b	69(a4)
		bne.s	l392ca
		move.b	68(a3),d0
		cmp.b	93(a4),d0
		bne.s	l392b4
		movem.w	(a3),d0-7/a0
		movem.w	d0-7/a0,-36(a6)
		bra.w	L393de
	l392b4:	lea	70(a3),a3
		bra.s	l392ca
	l392ba:	tst.b	69(a4)
		beq.s	l392ca
		movea.l	a4,a0
		bsr.w	L38d66_MatrixMulWTF
		lea	70(a4),a4
	l392ca:	move.w	0(a4),d0
		move.w	6(a4),d1
		move.w	12(a4),d2
		movea.l	a3,a0
		move.w	12(a0),d4
		muls	d2,d4
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d4
		add.l	d4,d4
		swap	d4
		move.w	12(a0),d5
		muls	d2,d5
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d5
		add.l	d5,d5
		swap	d5
		move.w	12(a0),d6
		muls	d2,d6
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d6
		add.l	d6,d6
		swap	d6
		movem.w	d4-6,-36(a6)
		move.w	2(a4),d0
		move.w	8(a4),d1
		move.w	14(a4),d2
		movea.l	a3,a0
		move.w	12(a0),d4
		muls	d2,d4
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d4
		add.l	d4,d4
		swap	d4
		move.w	12(a0),d5
		muls	d2,d5
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d5
		add.l	d5,d5
		swap	d5
		move.w	12(a0),d6
		muls	d2,d6
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d6
		add.l	d6,d6
		swap	d6
		movem.w	d4-6,-30(a6)
		move.w	4(a4),d0
		move.w	10(a4),d1
		move.w	16(a4),d2
		movea.l	a3,a0
		move.w	12(a0),d4
		muls	d2,d4
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d4
		add.l	d4,d4
		swap	d4
		move.w	12(a0),d5
		muls	d2,d5
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d5
		add.l	d5,d5
		swap	d5
		move.w	12(a0),d6
		muls	d2,d6
		move.w	6(a0),d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a0)+,d3
		muls	d0,d3
		add.l	d3,d6
		add.l	d6,d6
		swap	d6
		movem.w	d4-6,-24(a6)

L393de:
		clr.w	-64(a6)
		bsr.w	L39546_CalcRotViewNLight
		bsr.w	L3e14e_SetupNProjectObj
		tst.w	L385e4_3dview_word1
		beq.w	l394ae
		movea.l	L385c8_primitives_end,a0
		addq.l	#2,L385c8_primitives_end
		move.w	#$1e,(a0)
		clr.w	L385e4_3dview_word1
		unlk	a6
		rts

	l3940e:	move.l	#$80008000,110(a4)
		bra.w	L39290

* systems map radius and grid. other stuff?
L3941a_Put3DGamedata2Obj2:
		move.w	90(a6),d0
		lea	L2af80_gamedata2,a5
		bra.s	l39430

* This label is bullshit but i'll leave it for the moment
L39426_PutGameData3DObj:
		move.w	90(a6),d0
		movea.l	L973c_game_data,a5
	l39430:	moveq	#0,d1
		move.w	0(a5,d0.w),d1
		adda.l	d1,a5
		movem.l	0(a6),d0-7
		movea.l	a6,a4
		link	a6,#-220
		movem.l	d0-7,-36(a6)
		move.w	10(a5),-208(a6)
		move.l	a4,-212(a6)
		clr.w	-156(a6)
		clr.w	-192(a6)
		bsr.w	L39646_3DObjClipOffscreen
		bne.s	l394ae
		clr.w	-64(a6)
		move.w	#$111,-154(a6)
		movem.w	L60e2_lighting_vector,d0-2
		movem.w	d0-2,-198(a6)
		movem.l	L60f6_light_tint_table,d0-3
		movem.l	d0-3,-104(a6)
		bsr.w	L39546_CalcRotViewNLight
		bsr.w	L3e14e_SetupNProjectObj
		tst.w	L385e4_3dview_word1
		beq.s	l394ae
		movea.l	L385c8_primitives_end,a0
		addq.l	#2,L385c8_primitives_end
		move.w	#$1e,(a0)
		clr.w	L385e4_3dview_word1
	l394ae:	unlk	a6
		rts

L394b2_Put3DGamedata2Obj:
		move.w	90(a6),d0
		lea	L2af80_gamedata2,a5
		moveq	#0,d1
		move.w	0(a5,d0.w),d1
		adda.l	d1,a5
		movem.l	0(a6),d0-7
		movea.l	a6,a4
		link	a6,#-220
		movem.l	d0-7,-36(a6)
		move.w	10(a5),-208(a6)
		move.l	a4,-212(a6)
		clr.w	-156(a6)
		clr.w	-192(a6)
		bsr.w	L39646_3DObjClipOffscreen
		bne.s	l394ae
		clr.w	-64(a6)
		move.w	#$111,-154(a6)
		movem.w	L60e2_lighting_vector,d0-2
		movem.w	d0-2,-198(a6)
		movem.l	L60f6_light_tint_table,d0-3
		movem.l	d0-3,-104(a6)
		bsr.w	L39546_CalcRotViewNLight
		movea.l	a2,a0
		move.w	122(a4),d0
		asl.w	#6,d0
		bsr.w	L3e158_SetupNProjectObj2
		tst.w	L385e4_3dview_word1
		beq.s	l394ae
		movea.l	L385c8_primitives_end,a0
		addq.l	#2,L385c8_primitives_end
		move.w	#$1e,(a0)
		clr.w	L385e4_3dview_word1
		unlk	a6
		rts

* Vector to object is rotated by provided matrix
* as is the lightsource vector.
* Stored and used later to find backfaces and lightsource tinting respectively.
L39546_CalcRotViewNLight:
		* d0-2 = world x,y,z
		movem.l	-16(a6),d0-2
		moveq	#0,d3
		move.l	#$4000,d5
		move.l	d2,d4
		bpl.s	l3955a
		neg.l	d4
	l3955a:	cmp.l	d5,d4
		blt.s	l39566
	l3955e:	addq.w	#1,d3
		lsr.l	#1,d4
		cmp.l	d5,d4
		bge.s	l3955e
	l39566:	move.l	d0,d4
		bpl.s	l3956c
		neg.l	d4
	l3956c:	lsr.l	d3,d4
		cmp.l	d5,d4
		blt.s	l3957a
	l39572:	addq.w	#1,d3
		lsr.l	#1,d4
		cmp.l	d5,d4
		bge.s	l39572
	l3957a:	move.l	d1,d4
		bpl.s	l39580
		neg.l	d4
	l39580:	lsr.l	d3,d4
		cmp.l	d5,d4
		blt.s	l3958e
	l39586:	addq.w	#1,d3
		lsr.l	#1,d4
		cmp.l	d5,d4
		bge.s	l39586
	l3958e:	asr.l	d3,d0
		asr.l	d3,d1
		asr.l	d3,d2
		move.w	d3,-44(a6)
		addq.w	#7,d3
		sub.w	-208(a6),d3
		bge.s	l395ac
		neg.w	d3
		add.w	d3,-44(a6)
		asr.w	d3,d0
		asr.w	d3,d1
		asr.w	d3,d2
	l395ac:	neg.w	d0
		neg.w	d1
		neg.w	d2
		lea	-36(a6),a0
		move.w	(a0)+,d4
		muls	d0,d4
		move.w	(a0)+,d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a0)+,d3
		muls	d2,d3
		add.l	d3,d4
		add.l	d4,d4
		swap	d4
		move.w	(a0)+,d5
		muls	d0,d5
		move.w	(a0)+,d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a0)+,d3
		muls	d2,d3
		add.l	d3,d5
		add.l	d5,d5
		swap	d5
		move.w	(a0)+,d6
		muls	d0,d6
		move.w	(a0)+,d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a0)+,d3
		muls	d2,d3
		add.l	d3,d6
		add.l	d6,d6
		swap	d6
		movem.w	d4-6,-50(a6)
		movem.w	-198(a6),d0-2
		lea	-36(a6),a0
		move.w	(a0)+,d4
		muls	d0,d4
		move.w	(a0)+,d3
		muls	d1,d3
		add.l	d3,d4
		move.w	(a0)+,d3
		muls	d2,d3
		add.l	d3,d4
		add.l	d4,d4
		swap	d4
		move.w	(a0)+,d5
		muls	d0,d5
		move.w	(a0)+,d3
		muls	d1,d3
		add.l	d3,d5
		move.w	(a0)+,d3
		muls	d2,d3
		add.l	d3,d5
		add.l	d5,d5
		swap	d5
		move.w	(a0)+,d6
		muls	d0,d6
		move.w	(a0)+,d3
		muls	d1,d3
		add.l	d3,d6
		move.w	(a0)+,d3
		muls	d2,d3
		add.l	d3,d6
		add.l	d6,d6
		swap	d6
		movem.w	d4-6,-42(a6)
		rts

L39646_3DObjClipOffscreen:
		move.w	14(a5),d3
		move.w	-208(a6),d0
		ext.l	d3
		asl.l	d0,d3
		* viewing coords x,y,z
		movem.l	-16(a6),d0-2

* d0,1,2 are x,y,z
* d3 is the physical size of the object
L39658_3DClipOffscreen:
		add.l	d3,d2
		bmi.s	l39680
		tst.l	d0
		bpl.s	l39662
		neg.l	d0
	l39662:	tst.l	d1
		bpl.s	l39668
		neg.l	d1
	l39668:	sub.l	d3,d0
		bpl.s	l3966e
		moveq	#0,d0
	l3966e:	cmp.l	d2,d0
		bgt.s	l39680
		sub.l	d3,d1
		bpl.s	l39678
		moveq	#0,d1
	l39678:	add.l	d1,d1
		cmp.l	d2,d1
		bgt.s	l39680
		moveq	#0,d0
	l39680:	rts

L39682:
		move.w	4(a5),d0
		moveq	#0,d1
		movea.l	a4,a0
		adda.w	#$12,a0
		bra.s	l396ac

L39690_InitFuckframe:
		moveq	#0,d1
		movea.l	a4,a0
		adda.w	#$12,a0
		move.w	d1,-160(a0)
		move.w	d1,-128(a0)
		move.w	d1,-96(a0)
		move.w	d1,-64(a0)
		move.w	d1,-32(a0)
	l396ac:	lsr.w	#6,d0
		subq.w	#1,d0
		cmp.w	#$a,d0
		ble.s	l39712
	l396b6:	move.w	d1,(a0)
		move.w	d1,32(a0)
		move.w	d1,64(a0)
		move.w	d1,96(a0)
		move.w	d1,128(a0)
		move.w	d1,160(a0)
		move.w	d1,192(a0)
		move.w	d1,224(a0)
		move.w	d1,256(a0)
		move.w	d1,288(a0)
		move.w	d1,320(a0)
		move.w	d1,352(a0)
		move.w	d1,384(a0)
		move.w	d1,416(a0)
		move.w	d1,448(a0)
		move.w	d1,480(a0)
		move.w	d1,512(a0)
		move.w	d1,544(a0)
		move.w	d1,576(a0)
		move.w	d1,608(a0)
		lea	640(a0),a0
		subi.w	#$a,d0
		cmp.w	#$a,d0
		bgt.s	l396b6
	l39712:	move.w	d1,(a0)
		move.w	d1,32(a0)
		lea	64(a0),a0
		dbra	d0,l39712
		rts

L39722_LoadNTransformVertex:
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		beq.w	L397be_TransformModelCoords
		movem.l	20(a0),d3-5
		movem.l	-16(a6),d0-2
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
		movem.l	d0-2,4(a0)
		rts

	l3974a:	suba.l	a4,a0
		move.w	a0,d0
		asr.w	#3,d0
		movea.l	-68(a6,d0.w),a1
		movem.l	(a1),d0-4
		movem.l	-16(a6),d5-7
		sub.l	d1,d5
		neg.l	d5
		sub.l	d2,d6
		neg.l	d6
		sub.l	d3,d7
		neg.l	d7
		movea.l	8(a7),a0
		move.b	-152(a6),d4
		movem.l	d0-7,(a0)
		movem.l	(a7)+,d6-7/a0-1
		rts

L3977c_ProjectCoords:
		moveq	#1,d2
		tst.w	d5
		beq.s	l397c0_TransformModelCoords2
		* model coords
		movem.l	20(a0),d3-5
		* world coords
		movem.l	-16(a6),d0-2
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
		movem.l	d0-2,4(a0)
		cmp.l	#$40,d2
		blt.w	l398c8
		bsr.w	L35ea2_ZProject
		addi.w	#$a0,d0
		subi.w	#$54,d1
		neg.w	d1
		movem.w	d0-1,(a0)
		move.b	-152(a6),19(a0)
		rts

L397be_TransformModelCoords:
		moveq	#-1,d2
	l397c0_TransformModelCoords2:
		movem.l	d6-7/a0-1,-(a7)
		andi.w	#$ffdf,d0
		bmi.w	l3974a
		* a1 = pointer to gamedata start of vertex data
		movea.l	-216(a6),a1
		lea	0(a4,d0.w),a0
		lsr.w	#4,d0
		* load vertex data. d1.w = $ttxx, d3.w = $yyzz
		* where tt is type
		movem.w	0(a1,d0.w),d1/d3
		cmp.w	#$2ff,d1
		* type > 2
		bgt.w	L398e8_TransformModelCoords_T3_4
		
		move.w	d2,18(a0)
		move.w	d2,50(a0)
		asl.w	#8,d1
		move.w	d3,d2
		sub.b	d2,d2
		asl.w	#8,d3
		* vertex model coords in d1,d2,d3.w
		* this is the viewing matrix
		lea	-36(a6),a1
		move.w	12(a1),d4
		muls	d3,d4
		move.w	6(a1),d0
		muls	d2,d0
		add.l	d0,d4
		move.w	(a1)+,d0
		muls	d1,d0
		move.l	d0,-(a7)
		add.l	d0,d4
		
		move.w	12(a1),d5
		muls	d3,d5
		move.w	6(a1),d0
		muls	d2,d0
		add.l	d0,d5
		move.w	(a1)+,d0
		muls	d1,d0
		move.l	d0,-(a7)
		add.l	d0,d5
		
		move.w	12(a1),d6
		muls	d3,d6
		move.w	6(a1),d0
		muls	d2,d0
		add.l	d0,d6
		move.w	(a1)+,d0
		muls	d1,d0
		move.l	d0,-(a7)
		add.l	d0,d6
		
		movem.l	(a7)+,d1-3
		* some hideous scaling value
		moveq	#7,d7
		sub.w	-208(a6),d7
		blt.w	l398d6
		swap	d1
		ext.l	d1
		asr.w	d7,d1
		swap	d2
		ext.l	d2
		asr.w	d7,d2
		swap	d3
		ext.l	d3
		asr.w	d7,d3
		swap	d4
		ext.l	d4
		asr.w	d7,d4
		swap	d5
		ext.l	d5
		asr.w	d7,d5
		swap	d6
		ext.l	d6
		asr.w	d7,d6
	* save rotated model coords
	l3986a:	movem.l	d4-6,20(a0)
		sub.l	d3,d4
		sub.l	d3,d4
		sub.l	d2,d5
		sub.l	d2,d5
		sub.l	d1,d6
		sub.l	d1,d6

	L3987c:
		movem.l	d4-6,52(a0)
		movem.l	(a7)+,d6-7/a0-1

L39886_AddViewingTransformAndProject:
		movem.l	20(a0),d3-5

L3988c_AddViewingTransformAndProject_2:
		* viewing coords to transform vertex to
		movem.l	-16(a6),d0-2
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
		movem.l	d0-2,4(a0)
		tst.w	18(a0)
		bmi.s	l398c6
		cmp.l	#$40,d2
		blt.w	l398c8
		* yeah also lots.
		bsr.w	L35ea2_ZProject
		addi.w	#$a0,d0
		subi.w	#$54,d1
		neg.w	d1
		movem.w	d0-1,(a0)
		move.b	-152(a6),19(a0)
	l398c6:	rts

	l398c8:	move.l	#$80028002,(a0)
		move.b	-152(a6),19(a0)
		rts

	l398d6:	addi.w	#$10,d7
		asr.l	d7,d1
		asr.l	d7,d2
		asr.l	d7,d3
		asr.l	d7,d4
		asr.l	d7,d5
		asr.l	d7,d6
		bra.s	l3986a

* average viewing transformed model coords of 2 vertices
* specified in d3. put in 0(a0). put min model z of both in 12(a0).
* for 32(a0) vertex do above but with vertex ids eor 0x1.
* for vertex type 3,4
L398e8_TransformModelCoords_T3_4:	
		cmp.w	#$4ff,d1
		bgt.w	L399c0_TransformModelCoords_T5_6
		move.l	a2,-(a7)
		movea.l	a0,a2
		move.b	-152(a6),d2
		move.b	d2,19(a2)
		move.b	d2,51(a2)
		move.w	d3,d6
		move.w	d3,d0
		sub.b	d0,d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3991a
		bsr.w	L3977c_ProjectCoords
	l3991a:	movea.l	a0,a1
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l39934
		bsr.w	L3977c_ProjectCoords
	l39934:	movem.w	(a0),d0-1
		movem.w	(a1),d2-3
		add.l	d2,d0
		asr.l	#1,d0
		add.l	d3,d1
		asr.l	#1,d1
		movem.w	d0-1,(a2)
		
		movem.l	4(a0),d0-2
		movem.l	4(a1),d3-5

		add.l	d0,d3
		add.l	d1,d4
		asr.l	#1,d3
		asr.l	#1,d4

		cmp.l	d2,d5
		bgt.s	l39956
		exg	d2,d5
	l39956:	movem.l	d3-5,4(a2)
		eori.w	#$101,d6
		move.w	d6,d0
		sub.b	d0,d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l39976
		bsr.w	L3977c_ProjectCoords
	l39976:	movea.l	a0,a1
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l39990
		bsr.w	L3977c_ProjectCoords
	l39990:	movem.w	(a0),d0-1
		movem.w	(a1),d2-3
		add.l	d2,d0
		asr.l	#1,d0
		add.l	d3,d1
		asr.l	#1,d1
		movem.w	d0-1,32(a2)
		
		movem.l	4(a0),d0-2
		movem.l	4(a1),d3-5

		add.l	d0,d3
		add.l	d1,d4
		asr.l	#1,d3
		asr.l	#1,d4

		cmp.l	d2,d5
		bgt.s	l399b4
		exg	d2,d5
	l399b4:	movem.l	d3-5,36(a2)
		movea.l	(a7)+,a2
		movem.l	(a7)+,d6-7/a0-1
		rts

* used to transform bezier control points in one side of
* jump range circle, starmap. (symmetry)
* project d3 vertex, neg x,y,z model coords.
* do same with d3^1 vertex.
L399c0_TransformModelCoords_T5_6:
		cmp.w	#$6ff,d1
		bgt.s	L39a26_TransformModelCoords_T7_8
		movea.l	a0,a1
		move.w	d2,18(a1)
		move.w	d2,50(a1)
		move.w	d3,d0
		move.w	d3,d6
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l399e4
		bsr.w	L397be_TransformModelCoords
	l399e4:	movem.l	20(a0),d3-5
		neg.l	d3
		neg.l	d4
		neg.l	d5
		movem.l	d3-5,20(a1)
		move.w	d6,d0
		eori.w	#$1,d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39a0c
		bsr.w	L397be_TransformModelCoords
	l39a0c:	movem.l	20(a0),d3-5
		neg.l	d3
		neg.l	d4
		neg.l	d5
		movem.l	d3-5,52(a1)
		movem.l	(a7)+,d6-7/a0-1
		bra.w	L39886_AddViewingTransformAndProject

* used to transform hypercloud 'lightning' lines
L39a26_TransformModelCoords_T7_8:
		cmp.w	#$8ff,d1
		bgt.w	L39af2_TransformModelCoords_T9_a
		movea.l	a0,a1
		move.w	d2,18(a1)
		move.w	d2,50(a1)
		move.w	d3,d0
		move.w	d3,d6
		move.w	d1,-(a7)
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39a4e
		bsr.w	L397be_TransformModelCoords
	l39a4e:	move.w	(a7)+,d1
		andi.w	#$ff,d1
		move.l	L60da_rng_seed1,d3
		move.l	L60de_rng_seed2,d0
		add.l	d0,L60da_rng_seed1
		swap	d3
		move.l	d3,L60de_rng_seed2
		asr.l	d1,d3
		move.l	L60da_rng_seed1,d4
		move.l	L60de_rng_seed2,d0
		add.l	d0,L60da_rng_seed1
		swap	d4
		move.l	d4,L60de_rng_seed2
		asr.l	d1,d4
		move.l	L60da_rng_seed1,d5
		move.l	L60de_rng_seed2,d0
		add.l	d0,L60da_rng_seed1
		swap	d5
		move.l	d5,L60de_rng_seed2
		asr.l	d1,d5
		movem.l	20(a0),d0-2
		add.l	d3,d0
		add.l	d4,d1
		add.l	d5,d2
		movem.l	d0-2,20(a1)
		move.w	d6,d0
		eori.w	#$1,d0
		movem.l	d3-5,-(a7)
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39ad4
		bsr.w	L397be_TransformModelCoords
	l39ad4:	movem.l	20(a0),d0-2
		movem.l	(a7)+,d3-5
		add.l	d5,d0
		add.l	d3,d1
		add.l	d4,d2
		movem.l	d0-2,52(a1)
		movem.l	(a7)+,d6-7/a0-1
		bra.w	L39886_AddViewingTransformAndProject

* used to transform starmap stalks and blobs
L39af2_TransformModelCoords_T9_a:
		cmp.w	#$aff,d1
		bgt.s	L39b74_TransformModelCoords_Tb_c
		move.w	d2,18(a0)
		move.w	d2,50(a0)
		asl.w	#8,d1
		move.w	d3,d2
		sub.b	d2,d2
		asl.w	#8,d3
		* d1-3 = x,y,z model vertex
		lea	-36(a6),a1
		move.w	12(a1),d4
		muls	d3,d4
		move.w	6(a1),d0
		muls	d2,d0
		add.l	d0,d4
		move.w	(a1)+,d0
		muls	d1,d0
		move.l	d0,-(a7)
		add.l	d0,d4
		
		move.w	12(a1),d5
		muls	d3,d5
		move.w	6(a1),d0
		muls	d2,d0
		add.l	d0,d5
		move.w	(a1)+,d0
		muls	d1,d0
		move.l	d0,-(a7)
		add.l	d0,d5
		
		move.w	12(a1),d6
		muls	d3,d6
		move.w	6(a1),d0
		muls	d2,d0
		add.l	d0,d6
		move.w	(a1)+,d0
		muls	d1,d0
		move.l	d0,-(a7)
		add.l	d0,d6
		
		movem.l	(a7)+,d1-3
		* different scaling
		moveq	#23,d7
		sub.w	-208(a6),d7
		asr.l	d7,d1
		asr.l	d7,d2
		asr.l	d7,d3
		asr.l	d7,d4
		asr.l	d7,d5
		asr.l	d7,d6
		movem.l	d4-6,20(a0)
		sub.l	d3,d4
		sub.l	d2,d5
		sub.l	d1,d6
		bra.w	L3987c
	
* vertex type 0xb
* Project vertices indexed by d1 and d3.
* Return average of their viewing coords and project.
L39b74_TransformModelCoords_Tb_c:
		move.w	d3,d6
		move.w	d1,d7
		movea.l	8(a7),a1
		cmpa.l	a0,a1
		beq.s	l39b86
		eori.w	#$101,d6
		exg	a0,a1
	l39b86:	move.w	d2,18(a0)
		move.w	d6,d0
		cmp.w	#$cff,d1
		bgt.s	L39be0_TransformModelCoords_Td_e
		clr.b	d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39ba4
		bsr.w	L397be_TransformModelCoords
	l39ba4:	movea.l	a0,a1
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39bba
		bsr.w	L397be_TransformModelCoords
	l39bba:	movem.l	20(a0),d0-2
		movem.l	20(a1),d3-5
		add.l	d0,d3
		asr.l	#1,d3
		add.l	d1,d4
		asr.l	#1,d4
		add.l	d2,d5
		asr.l	#1,d5
		movem.l	(a7)+,d6-7/a0-1
		movem.l	d3-5,20(a0)
		bra.w	L3988c_AddViewingTransformAndProject_2

* Vertex type 0xd:
* Project d0 and d6 vertices.
* Return averaged 2d projection of the two.
* Return x,y viewing coords of 'd0' vertex and
* largest z viewing coordinate of the two.
L39be0_TransformModelCoords_Td_e:
		cmp.w	#$eff,d1
		bgt.s	L39c4c_TransformModelCoords_Tf_10
		sub.b	d0,d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l39bfc
		bsr.w	L3977c_ProjectCoords
	l39bfc:	movea.l	a0,a1
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l39c16
		bsr.w	L3977c_ProjectCoords
	l39c16:	movem.w	(a0),d0-1
		movem.w	(a1),d2-3
		add.l	d2,d0
		asr.l	#1,d0
		add.l	d3,d1
		asr.l	#1,d1
		movem.l	4(a0),d2-4
		movem.l	4(a1),d6-7
		add.l	d6,d2
		add.l	d7,d3
		asr.l	#1,d2
		asr.l	#1,d3
		move.l	12(a1),d5
		cmp.l	d4,d5
		bgt.s	l39c36
		exg	d4,d5
	l39c36:	movem.l	(a7)+,d6-7/a0-1
		movem.w	d0-1,(a0)
		movem.l	d2-4,4(a0)
		move.b	-152(a6),19(a0)
		rts

L39c4c_TransformModelCoords_Tf_10:
		cmp.w	#$10ff,d1
		bgt.s	L39cca_TransformModelCoords_T11_12
		cmpa.l	a0,a1
		beq.s	l39c5a
		eori.w	#$1,d7
	l39c5a:	clr.b	d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39c6c
		bsr.w	L397be_TransformModelCoords
	l39c6c:	movea.l	a0,a1
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39c82
		bsr.w	L397be_TransformModelCoords
	l39c82:	movem.l	20(a0),d0-2
		movem.l	20(a1),d3-5
		sub.l	d0,d3
		sub.l	d1,d4
		sub.l	d2,d5
		move.w	d7,d0
		movem.l	d3-5,-(a7)
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39cac
		bsr.w	L397be_TransformModelCoords
	l39cac:	movem.l	(a7)+,d3-5
		movem.l	20(a0),d0-2
		add.l	d0,d3
		add.l	d1,d4
		add.l	d2,d5
		movem.l	(a7)+,d6-7/a0-1
		movem.l	d3-5,20(a0)
		bra.w	L3988c_AddViewingTransformAndProject_2

L39cca_TransformModelCoords_T11_12:
		cmp.w	#$12ff,d1
		bgt.s	L39d18_TransformModelCoords_T13_14
		clr.b	d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39ce2
		bsr.w	L397be_TransformModelCoords
	l39ce2:	movea.l	a0,a1
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39cf8
		bsr.w	L397be_TransformModelCoords
	l39cf8:	movem.l	20(a0),d0-2
		movem.l	20(a1),d3-5
		add.l	d0,d3
		add.l	d1,d4
		add.l	d2,d5
		movem.l	(a7)+,d6-7/a0-1
		movem.l	d3-5,20(a0)
		bra.w	L3988c_AddViewingTransformAndProject_2

L39d18_TransformModelCoords_T13_14:
		cmp.w	#$14ff,d1
		bgt.w	L39e0a_TransformModelCoords_T15
		clr.b	d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39d32
		bsr.w	L397be_TransformModelCoords
	l39d32:	movea.l	a0,a1
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		bne.s	l39d48
		bsr.w	L397be_TransformModelCoords
	l39d48:	movem.l	20(a1),d0-2
		movem.l	20(a0),d3-5
		add.w	d7,d7
		andi.w	#$1fe,d7
		bclr	#$8,d7
		bne.s	l39d72
		move.w	d7,d6
		bclr	#$7,d7
		bne.s	l39d6c
		lsr.w	#1,d6
		bra.s	l39d86
	l39d6c:	asl.w	#8,d6
		asl.w	#1,d6
		bra.s	l39d86
	l39d72:	bclr	#$7,d7
		bne.s	l39d82
		movea.l	-212(a6),a0
		move.w	114(a0,d7.w),d6
		bra.s	l39d86
	l39d82:	move.w	-64(a6,d7.w),d6
	l39d86:	lsr.w	#1,d6
		move.w	d6,-(a7)
		sub.l	d0,d3
		sub.l	d1,d4
		sub.l	d2,d5
		moveq	#0,d7
		movea.l	#$4000,a1
		move.l	d5,d6
		bpl.s	l39d9e
		neg.l	d6
	l39d9e:	cmp.l	a1,d6
		blt.s	l39daa
	l39da2:	addq.w	#1,d7
		lsr.l	#1,d6
		cmp.l	a1,d6
		bge.s	l39da2
	l39daa:	move.l	d3,d6
		bpl.s	l39db0
		neg.l	d6
	l39db0:	lsr.l	d7,d6
		cmp.l	a1,d6
		blt.s	l39dbe
	l39db6:	addq.w	#1,d7
		lsr.l	#1,d6
		cmp.l	a1,d6
		bge.s	l39db6
	l39dbe:	move.l	d4,d6
		bpl.s	l39dc4
		neg.l	d6
	l39dc4:	lsr.l	d7,d6
		cmp.l	a1,d6
		blt.s	l39dd2
	l39dca:	addq.w	#1,d7
		lsr.l	#1,d6
		cmp.l	a1,d6
		bge.s	l39dca
	l39dd2:	asr.l	d7,d3
		asr.l	d7,d4
		asr.l	d7,d5
		move.w	(a7)+,d6
		muls	d6,d3
		muls	d6,d4
		muls	d6,d5
		subi.w	#$f,d7
		bmi.s	l39dee
		asl.l	d7,d3
		asl.l	d7,d4
		asl.l	d7,d5
		bra.s	l39df6
	l39dee:	neg.w	d7
		asr.l	d7,d3
		asr.l	d7,d4
		asr.l	d7,d5
	l39df6:	add.l	d0,d3
		add.l	d1,d4
		add.l	d2,d5
		movem.l	(a7)+,d6-7/a0-1
		movem.l	d3-5,20(a0)
		bra.w	L3988c_AddViewingTransformAndProject_2

L39e0a_TransformModelCoords_T15:
		cmp.w	d6,d3
		beq.s	l39e10
		exg	a1,a0
	l39e10:	move.w	d2,50(a0)
		asl.w	#8,d1
		move.w	d3,d2
		sub.b	d2,d2
		asl.w	#8,d3
		lea	-36(a6),a1
		move.w	12(a1),d0
		muls	d3,d0
		move.w	6(a1),d6
		muls	d2,d6
		add.l	d6,d0
		move.w	(a1)+,d6
		muls	d1,d6
		move.l	d6,-(a7)
		add.l	d6,d0
		move.w	12(a1),d4
		muls	d3,d4
		move.w	6(a1),d6
		muls	d2,d6
		add.l	d6,d4
		move.w	(a1)+,d6
		muls	d1,d6
		move.l	d6,-(a7)
		add.l	d6,d4
		move.w	12(a1),d5
		muls	d3,d5
		move.w	6(a1),d6
		muls	d2,d6
		add.l	d6,d5
		move.w	(a1)+,d6
		muls	d1,d6
		move.l	d6,-(a7)
		add.l	d6,d5
		lea	12(a7),a7
		moveq	#23,d7
		sub.w	-208(a6),d7
		move.l	d0,d3
		asr.l	d7,d3
		asr.l	d7,d4
		asr.l	d7,d5
		movea.l	-4(a6),a1
		moveq	#0,d6
		move.w	22(a1),d6
		mulu	#$7f00,d6
		lsr.l	d7,d6
		jsr	L36742_32BitDotProduct
		move.l	d5,d6
		move.l	d4,d5
		move.l	d3,d4
		movem.l	d4-6,20(a0)
		neg.l	d4
		neg.l	d5
		neg.l	d6
		bra.w	L3987c

L39ea0:
		asr.w	#4,d6
		bmi.s	l39ee2
		andi.w	#$1fe,d6
		bclr	#$8,d6
		bne.s	l39ec0
		move.w	d6,d0
		bclr	#$7,d6
		bne.s	l39eba
		lsr.w	#1,d0
		bra.s	l39ed4
	l39eba:	asl.w	#8,d0
		asl.w	#1,d0
		bra.s	l39ed4
	l39ec0:	bclr	#$7,d6
		bne.s	l39ed0
		movea.l	-212(a6),a0
		move.w	114(a0,d6.w),d0
		bra.s	l39ed4
	l39ed0:	move.w	-64(a6,d6.w),d0
	l39ed4:	asl.w	#2,d0
		ext.l	d0
		add.l	d0,-216(a6)
		asl.l	#4,d0
		adda.l	d0,a4
		rts

	l39ee2:	cmp.w	#$f801,d6
		beq.s	l39ef6
		movem.w	-122(a6),d0-7/a0
		movem.w	d0-7/a0,-36(a6)
		rts

	l39ef6:	movea.l	-212(a6),a0
		move.w	122(a0),-58(a6)
		move.w	116(a0),-62(a6)
		subq.w	#1,-58(a6)
		clr.w	-56(a6)
	l39f0e:	movea.l	-212(a6),a0
		move.w	-56(a6),d0
		add.w	d0,d0
		move.b	125(a0,d0.w),d2
		andi.w	#$7f,d2
		move.w	d2,-60(a6)
		addq.l	#4,-216(a6)
		lea	64(a4),a4
		btst	#$5,-61(a6)
		beq.s	l39f42
		move.w	-60(a6),d2
		move.w	L39f80(pc,d2.w),d6
		moveq	#1,d7
		bsr.w	L3ace2_project_line
	l39f42:	move.w	-60(a6),d2
		move.w	L39f9c(pc,d2.w),d6
		moveq	#0,d7
		move.w	L39fb8(pc,d2.w),d7
		ror.w	#8,d7
		swap	d7
		* starmap blobs?
		bsr.w	L3a55a_ProjectCircle_2
		move.w	-60(a6),d2
		add.w	d2,d2
		move.l	12(a4),d0
		cmp.l	L39fd4(pc,d2.w),d0
		bgt.s	l39f72
		moveq	#18,d6
		move.w	#$8400,d7
		bsr.w	L3c82a
	l39f72:	addq.w	#1,-56(a6)
		subq.w	#1,-58(a6)
		bne.w	l39f0e
		rts

L39f80:
		dc.b	$92,$22,$92,$22,$92,$22,$96,$22,$98,$22,$98,$82,$98,$82,$98,$82
		dc.b	$92,$22,$98,$82,$98,$82,$96,$22,$98,$82,$98,$22

L39f9c:
		dc.b	$d0,$1,$d0,$1,$d0,$1,$d8,$1,$dc,$1,$dc,$c1,$dc,$c1,$dc,$c1
		dc.b	$d0,$1,$dc,$c1,$bc,$e1,$d8,$1,$bc,$e1,$dc,$1

L39fb8:
		dc.b	$1,$2c,$1,$2c,$1,$5e,$1,$90,$1,$c2,$1,$f4,$1,$f4,$0,$c8
		dc.b	$2,$bc,$3,$84,$3,$20,$4,$4c,$5,$78,$2,$58

L39fd4:
		dc.b	$0,$3,$34,$50,$0,$2,$bf,$20,$0,$3,$e4,$18,$0,$4,$93,$e0
		dc.b	$0,$6,$dd,$d0,$0,$9,$27,$c0,$0,$9,$9c,$f0,$0,$4,$1e,$b0
		dc.b	$0,$b,$71,$b0,$0,$10,$5,$90,$0,$12,$4f,$80,$0,$12,$4f,$80
		dc.b	$0,$14,$99,$70,$0,$10,$5,$90

L3a00c_InitNormalFlags:
		move.w	#$8080,d0
		lea	4(a7),a0
		move.w	8(a5),d1
		* it seems no cunt cares about this except for
		* gas giant ring colours
		move.l	-98(a6),(a0)+
		lsr.w	#1,d1
		subq.w	#3,d1
		bmi.s	l3a028
	l3a022:	move.w	d0,(a0)+
		dbra	d1,l3a022
	l3a028:	rts

* Hidden face removal & lightsource colour tint in (a0)
L3a02a_3DPrimCullNLight:
		move.l	d6,-(a7)
		movea.l	-220(a6),a1
		bclr	#$1,d0
		beq.s	l3a060
		movem.w	-4(a1,d0.w),d1/d3
		move.w	d1,d0
		asl.w	#8,d1
		move.w	d3,d2
		sub.b	d2,d2
		asl.w	#8,d3
		neg.w	d1
		lsr.w	#7,d0
		andi.w	#$fffe,d0
		bclr	#$1,d0
		movea.l	-216(a6),a1
		movem.w	0(a1,d0.w),d4/d6
		beq.s	l3a086
		bra.s	l3a088
	l3a060:	movem.w	-4(a1,d0.w),d1/d3
		move.w	d1,d0
		asl.w	#8,d1
		move.w	d3,d2
		sub.b	d2,d2
		asl.w	#8,d3
		lsr.w	#7,d0
		andi.w	#$fffe,d0
		bclr	#$1,d0
		movea.l	-216(a6),a1
		movem.w	0(a1,d0.w),d4/d6
		beq.s	l3a088
	l3a086:	neg.b	d4
	l3a088:	ext.w	d4
		move.w	d6,d5
		asr.w	#8,d5
		ext.w	d6
		move.w	-208(a6),d0
		sub.w	-44(a6),d0
		bpl.s	l3a0a4
		neg.w	d0
		asr.w	d0,d4
		asr.w	d0,d5
		asr.w	d0,d6
		bra.s	l3a0ac
	l3a0a4:	beq.s	l3a0ac
		asl.w	d0,d4
		asl.w	d0,d5
		asl.w	d0,d6
	l3a0ac:	sub.w	-50(a6),d4
		sub.w	-48(a6),d5
		sub.w	-46(a6),d6
		muls	d1,d4
		muls	d2,d5
		add.l	d5,d4
		muls	d3,d6
		add.l	d6,d4
		bpl.s	l3a0e6
		movem.w	-42(a6),d0/d5-6
		muls	d1,d0
		muls	d2,d5
		add.l	d5,d0
		muls	d3,d6
		add.l	d6,d0
		add.l	d0,d0
		bpl.s	l3a0ee
		rol.l	#5,d0
		andi.w	#$e,d0
		* -104(a6) = L60f6_light_tint_table, lightsource tint table
		move.w	-104(a6,d0.w),(a0)
		move.l	(a7)+,d6
		rts

	l3a0e6:	move.w	#$8000,(a0)
		move.l	(a7)+,d6
		rts

	l3a0ee:	clr.w	(a0)
		move.l	(a7)+,d6
		rts

L3a0f4:
		lsr.w	#4,d6
		bclr	#$0,d6
		move.w	(a5)+,d7
		move.w	d7,d1
		lsr.w	#8,d1
		beq.s	l3a144
		lea	14(a5),a5
		add.w	d1,d1
		andi.w	#$1fe,d1
		bclr	#$8,d1
		bne.s	l3a124
		move.w	d1,d0
		bclr	#$7,d1
		bne.s	l3a11e
		lsr.w	#1,d0
		bra.s	l3a138
	l3a11e:	asl.w	#8,d0
		asl.w	#1,d0
		bra.s	l3a138
	l3a124:	bclr	#$7,d1
		bne.s	l3a134
		movea.l	-212(a6),a0
		move.w	114(a0,d1.w),d0
		bra.s	l3a138
	l3a134:	move.w	-64(a6,d1.w),d0
	l3a138:	andi.w	#$7,d0
		beq.s	l3a144
		add.w	d0,d0
		move.w	-16(a5,d0.w),d6
	l3a144:	move.b	d7,d0
		andi.w	#$7f,d0
		add.w	d0,d0
		lea	8(a7,d0.w),a0
		cmpi.w	#$8080,(a0)
		bne.s	l3a15a
		bsr.w	L3a02a_3DPrimCullNLight
	l3a15a:	move.w	(a0),d0
		bclr	#$4,d6
		beq.s	l3a174
		bclr	#$8,d6
		bne.s	l3a16e
		add.w	d0,d6
		andi.w	#$fff,d6
	l3a16e:	add.w	-154(a6),d6
		bra.s	l3a180
	l3a174:	bclr	#$8,d6
		bne.s	l3a180
		add.w	d0,d6
		andi.w	#$fff,d6
	l3a180:	btst	#$7,d7
		bne.s	l3a18c
		move.w	d6,-154(a6)
		rts

	l3a18c:	move.w	d6,8(a7)
		rts

	l3a192:	movea.l	L385c8_primitives_end,a1
		moveq	#-1,d4
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
		lea	2(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$0,(a1)
		rts

	
	l3a1ae:	movea.l	L385c8_primitives_end,a0
		addq.l	#2,L385c8_primitives_end
		move.w	#$1e,(a0)
		rts

L3a1c0_ZWTF:
		tst.w	L385e4_3dview_word1
		beq.s	l3a1d8
		movea.l	L385c8_primitives_end,a0
		addq.l	#2,L385c8_primitives_end
		move.w	#$1e,(a0)
	l3a1d8:	lsr.w	#5,d6
		move.w	d6,L385e4_3dview_word1
		beq.s	l3a1ae
		cmp.w	#$7fe,d6
		bgt.s	l3a25e
		beq.s	l3a192
		cmp.w	#$7fd,d6
		beq.w	l3a416
		move.w	d6,d0
		ext.w	d0
		bsr.w	L39722_LoadNTransformVertex
		btst	#$8,d6
		bne.w	l3a2ba

L3a202:
		movea.l	L385c8_primitives_end,a1
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3a228
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3a228
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3a24a
	l3a224:	moveq	#1,d4
		bra.s	l3a24a
	l3a228:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3a236
		neg.l	d4
	l3a236:	tst.l	d5
		bpl.s	l3a23c
		neg.l	d5
	l3a23c:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3a224
		lsr.l	d5,d4
		beq.s	l3a224
	l3a24a:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
		lea	2(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$0,(a1)
		rts

	l3a25e:	movea.l	L385c8_primitives_end,a1
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3a284
		addi.w	#$18,d5
		move.l	-8(a6),d4
		bmi.s	l3a284
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3a2a6
	l3a280:	moveq	#1,d4
		bra.s	l3a2a6
	l3a284:	move.w	d5,-(a7)
		movem.l	-16(a6),d4-5/a0
		tst.l	d4
		bpl.s	l3a292
		neg.l	d4
	l3a292:	tst.l	d5
		bpl.s	l3a298
		neg.l	d5
	l3a298:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3a280
		lsr.l	d5,d4
		beq.s	l3a280
	l3a2a6:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
		lea	2(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$0,(a1)
		rts

	l3a2ba:	btst	#$9,d6
		bne.w	l3a368
		move.w	-192(a6),d1
		subq.w	#3,d1
		neg.w	d1
		bgt.s	l3a2e2
		addi.w	#$18,d1
		move.l	12(a0),d0
		bmi.s	l3a2e2
		lsr.l	d1,d0
		bset	#$1f,d0
		bra.s	l3a304
	l3a2de:	moveq	#1,d0
		bra.s	l3a304
	l3a2e2:	move.w	d1,-(a7)
		movem.l	4(a0),d0-2
		tst.l	d0
		bpl.s	l3a2f0
		neg.l	d0
	l3a2f0:	tst.l	d1
		bpl.s	l3a2f6
		neg.l	d1
	l3a2f6:	add.l	d1,d0
		move.w	(a7)+,d1
		lsr.l	#3,d0
		add.l	d2,d0
		bmi.s	l3a2de
		lsr.l	d1,d0
		beq.s	l3a2de
	l3a304:	move.l	d0,d7
		movea.l	a0,a1
	l3a308:	move.w	(a5)+,d6
		move.w	d6,d0
		ext.w	d0
		bsr.w	L39722_LoadNTransformVertex
		move.w	-192(a6),d1
		subq.w	#3,d1
		neg.w	d1
		bgt.s	l3a332
		addi.w	#$18,d1
		move.l	12(a0),d0
		bmi.s	l3a332
		lsr.l	d1,d0
		bset	#$1f,d0
		bra.s	l3a354
	l3a32e:	moveq	#1,d0
		bra.s	l3a354
	l3a332:	move.w	d1,-(a7)
		movem.l	4(a0),d0-2
		tst.l	d0
		bpl.s	l3a340
		neg.l	d0
	l3a340:	tst.l	d1
		bpl.s	l3a346
		neg.l	d1
	l3a346:	add.l	d1,d0
		move.w	(a7)+,d1
		lsr.l	#3,d0
		add.l	d2,d0
		bmi.s	l3a32e
		lsr.l	d1,d0
		beq.s	l3a32e
	l3a354:	cmp.l	d0,d7
		bgt.s	l3a35c
		move.l	d0,d7
		movea.l	a0,a1
	l3a35c:	tst.w	d6
		bmi.s	l3a308
		move.l	d7,d1
		movea.l	a1,a0
		bra.w	L3a202
	l3a368:	btst	#$a,d6
		bne.w	l3a41e
		move.w	-192(a6),d1
		subq.w	#3,d1
		neg.w	d1
		bgt.s	l3a390
		addi.w	#$18,d1
		move.l	12(a0),d0
		bmi.s	l3a390
		lsr.l	d1,d0
		bset	#$1f,d0
		bra.s	l3a3b2
	l3a38c:	moveq	#1,d0
		bra.s	l3a3b2
	l3a390:	move.w	d1,-(a7)
		movem.l	4(a0),d0-2
		tst.l	d0
		bpl.s	l3a39e
		neg.l	d0
	l3a39e:	tst.l	d1
		bpl.s	l3a3a4
		neg.l	d1
	l3a3a4:	add.l	d1,d0
		move.w	(a7)+,d1
		lsr.l	#3,d0
		add.l	d2,d0
		bmi.s	l3a38c
		lsr.l	d1,d0
		beq.s	l3a38c
	l3a3b2:	move.l	d0,d7
		movea.l	a0,a1
	l3a3b6:	move.w	(a5)+,d6
		move.w	d6,d0
		ext.w	d0
		bsr.w	L39722_LoadNTransformVertex
		move.w	-192(a6),d1
		subq.w	#3,d1
		neg.w	d1
		bgt.s	l3a3e0
		addi.w	#$18,d1
		move.l	12(a0),d0
		bmi.s	l3a3e0
		lsr.l	d1,d0
		bset	#$1f,d0
		bra.s	l3a402
	l3a3dc:	moveq	#1,d0
		bra.s	l3a402
	l3a3e0:	move.w	d1,-(a7)
		movem.l	4(a0),d0-2
		tst.l	d0
		bpl.s	l3a3ee
		neg.l	d0
	l3a3ee:	tst.l	d1
		bpl.s	l3a3f4
		neg.l	d1
	l3a3f4:	add.l	d1,d0
		move.w	(a7)+,d1
		lsr.l	#3,d0
		add.l	d2,d0
		bmi.s	l3a3dc
		lsr.l	d1,d0
		beq.s	l3a3dc
	l3a402:	cmp.l	d0,d7
		blt.s	l3a40a
		move.l	d0,d7
		movea.l	a0,a1
	l3a40a:	tst.w	d6
		bmi.s	l3a3b6
		move.l	d7,d1
		movea.l	a1,a0
		bra.w	L3a202
	l3a416:	moveq	#0,d0
		moveq	#0,d1
		moveq	#0,d2
		bra.s	l3a424
	l3a41e:	movem.l	4(a0),d0-2
	l3a424:	move.w	(a5)+,d3
		ext.l	d3
		move.w	-208(a6),d4
		asl.l	d4,d3
		add.l	d3,d2
		movem.l	d0-2,-(a7)
		movea.l	L385c8_primitives_end,a1
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3a45a
		addi.w	#$18,d5
		move.l	8(a7),d4
		bmi.s	l3a45a
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3a47c
	l3a456:	moveq	#1,d4
		bra.s	l3a47c
	l3a45a:	move.w	d5,-(a7)
		movem.l	2(a7),d4-5/a0
		tst.l	d4
		bpl.s	l3a468
		neg.l	d4
	l3a468:	tst.l	d5
		bpl.s	l3a46e
		neg.l	d5
	l3a46e:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3a456
		lsr.l	d5,d4
		beq.s	l3a456
	l3a47c:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
		lea	2(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$0,(a1)
		lea	12(a7),a7
		rts

	* this is the detail of Z-sorting i have not implemented...
	l3a494:	lea	L385d0_3dview_thing2,a0
		move.l	4(a0),0(a0)
		move.l	8(a0),4(a0)
		move.l	12(a0),8(a0)
		move.l	-4(a0),12(a0)
		rts

* arse of imp courier engines, underside of eagle. wtf.
L3a4b4:
		tst.w	d6
		bmi.s	l3a494
		lsr.w	#5,d6
		move.w	d6,d0
		ext.w	d0
		bsr.w	L39722_LoadNTransformVertex
		movea.l	L385c8_primitives_end,a1
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3a4e8
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3a4e8
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3a50a
	l3a4e4:	moveq	#1,d4
		bra.s	l3a50a
	l3a4e8:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3a4f6
		neg.l	d4
	l3a4f6:	tst.l	d5
		bpl.s	l3a4fc
		neg.l	d5
	l3a4fc:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3a4e4
		lsr.l	d5,d4
		beq.s	l3a4e4
	l3a50a:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
		lea	2(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$ff96,(a1)+
		lea	L385d0_3dview_thing2,a2
		move.l	8(a2),12(a2)
		move.l	4(a2),8(a2)
		move.l	0(a2),4(a2)
		move.l	a1,L385d0_3dview_thing2
		moveq	#0,d0
		moveq	#0,d1
		moveq	#0,d2
		movem.l	d0-2,(a1)
		lea	12(a1),a1
		move.w	#$fff8,(a1)+
		move.l	a1,L385c8_primitives_end
		rts

	l3a554:	move.w	(a7)+,d6
	l3a556:	rts

		
L3a558_ProjectCircle:
		move.l	(a5)+,d7

L3a55a_ProjectCircle_2:
		lsr.w	#4,d6
		move.w	d7,d0
		sub.b	d0,d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3a574
		bsr.w	L3977c_ProjectCoords
	l3a574:	move.l	d7,d0
		move.w	d0,-148(a6)
		swap	d0
		bclr	#$7,d0
		bne.s	l3a588
		ror.w	#7,d0
		move.w	d0,d2
		bra.s	l3a59e
	l3a588:	add.w	d0,d0
		bclr	#$7,d0
		bne.s	l3a59a
		movea.l	-212(a6),a2
		move.w	114(a2,d0.w),d2
		bra.s	l3a59e
	l3a59a:	move.w	-64(a6,d0.w),d2
	l3a59e:	lsr.w	#1,d2
		ext.l	d2
		move.w	-208(a6),d0
		subq.w	#7,d0
		bmi.s	l3a5ae
		asl.l	d0,d2
		bra.s	l3a5b2
	l3a5ae:	neg.w	d0
		lsr.l	d0,d2
	l3a5b2:	move.l	12(a0),d4
		cmp.l	#$40,d4
		blt.s	l3a556
		move.l	d2,-146(a6)
		move.l	d4,d3
		lsr.l	#3,d3
		cmp.l	d2,d3
		ble.s	l3a5e6
	l3a5ca:	cmp.l	#$8000,d4
		blt.s	l3a5d8
		asr.l	#1,d2
		lsr.l	#1,d4
		bra.s	l3a5ca
	l3a5d8:	asl.l	#8,d2
		divs	d4,d2
		movem.w	0(a0),d0-1
		bra.w	L3a68c
	l3a5e6:	lsr.l	#1,d2
		cmp.l	d2,d4
		ble.w	l3a556
		movem.l	4(a0),d0-1/d7
		move.l	d2,d3
		move.l	d0,d4
		bpl.s	l3a5fc
		neg.l	d4
	l3a5fc:	or.l	d4,d3
		move.l	d1,d4
		bpl.s	l3a604
		neg.l	d4
	l3a604:	or.l	d4,d3
		move.l	d7,d4
		bpl.s	l3a60c
		neg.l	d4
	l3a60c:	or.l	d4,d3
		beq.s	l3a620
		moveq	#-1,d4
	l3a612:	addq.w	#1,d4
		asl.l	#1,d3
		bpl.s	l3a612
		asl.l	d4,d0
		asl.l	d4,d1
		asl.l	d4,d7
		asl.l	d4,d2
	l3a620:	move.w	d6,-(a7)
		move.l	d7,d4
		move.l	d0,d5
		move.l	d1,d6
		swap	d7
		muls	d7,d7
		add.l	d7,d7
		move.l	d2,d3
		swap	d3
		muls	d3,d3
		add.l	d3,d3
		sub.l	d3,d7
		swap	d7
		tst.w	d7
		beq.w	l3a554
		asr.l	#8,d4
		divu	d7,d4
		bvs.w	l3a554
		swap	d0
		muls	d4,d0
		add.l	d0,d0
		swap	d0
		swap	d1
		muls	d4,d1
		add.l	d1,d1
		swap	d1
		asr.l	#5,d2
		divu	d7,d2
		swap	d5
		muls	d5,d5
		add.l	d5,d5
		swap	d6
		muls	d6,d6
		add.l	d6,d6
		swap	d7
		add.l	d5,d7
		add.l	d6,d7
		lsr.l	#1,d7
		move.w	d0,-(a7)
		move.l	d7,d0
		bsr.w	L368e0_Sqrt
		lsr.w	#1,d0
		muls	d0,d2
		swap	d2
		move.w	(a7)+,d0
		move.w	(a7)+,d6
		addi.w	#$a0,d0
		subi.w	#$54,d1
		neg.w	d1

L3a68c:
		move.w	d2,d4
		lsr.w	#1,d2
		cmp.w	#$140,d0
		bcs.s	l3a6ac
		tst.w	d0
		bmi.s	l3a6a6
		move.w	d0,d3
		sub.w	d2,d3
		cmp.w	#$140,d3
		blt.s	l3a6ac
	l3a6a4:	rts

	l3a6a6:	move.w	d0,d3
		add.w	d2,d3
		bmi.s	l3a6a4
	l3a6ac:	cmp.w	#$a8,d1
		bcs.s	l3a6c8
		tst.w	d1
		bmi.s	l3a6c2
		move.w	d1,d3
		sub.w	d2,d3
		cmp.w	#$a8,d3
		blt.s	l3a6c8
		rts

	l3a6c2:	move.w	d1,d3
		add.w	d2,d3
		ble.s	l3a6a4
	l3a6c8:	btst	#$8,d6
		bne.w	l3a914
		andi.w	#$efe,d6
		bclr	#$4,d6
		beq.s	l3a6de
		add.w	-154(a6),d6
	l3a6de:	move.w	d6,-150(a6)
		move.w	-194(a6),d5
		cmp.w	#$9,d4
		blt.w	l3a908
		cmp.w	#$8300,d5
		blt.w	l3a922
		cmp.w	#$7d00,d5
		bgt.w	l3a90e
		movem.w	d0-1,-(a7)
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3a756
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3a730
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3a730
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3a752
	l3a72c:	moveq	#1,d4
		bra.s	l3a752
	l3a730:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3a73e
		neg.l	d4
	l3a73e:	tst.l	d5
		bpl.s	l3a744
		neg.l	d5
	l3a744:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3a72c
		lsr.l	d5,d4
		beq.s	l3a72c
	l3a752:	
		move.l	a0,vertex_a0
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
	l3a756:	
		move.l	vertex_a0,a0
		hcall	#Nu_PutCircle
		
		lea	82(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$2a,(a1)+
		move.w	#$5a,d0
		move.w	d0,(a1)+
		move.w	d0,16(a1)
		move.w	#$ffd2,34(a1)
		move.w	d0,38(a1)
		move.w	d0,56(a1)
		move.w	#$68,74(a1)
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3a798
		tst.w	d6
		beq.s	l3a7b8
		move.w	d0,d6
		bra.s	l3a7b8
	l3a798:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d0
		cmp.w	#$f8,d0
		blt.s	l3a7aa
		moveq	#0,d6
		bra.s	l3a7b8
	l3a7aa:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3a7b8:	move.w	d6,36(a1)
		move.w	-150(a6),d6
		add.w	-98(a6),d6
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3a7da
		tst.w	d6
		beq.s	l3a7fa
		move.w	d0,d6
		bra.s	l3a7fa
	l3a7da:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d0
		cmp.w	#$f8,d0
		blt.s	l3a7ec
		moveq	#0,d6
		bra.s	l3a7fa
	l3a7ec:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3a7fa:	move.w	d6,76(a1)
		movem.w	-198(a6),d3-5
		neg.w	d4
		move.w	d3,d0
		move.w	d4,d1
		muls	d0,d0
		muls	d1,d1
		add.l	d1,d0
		bsr.w	L368e0_Sqrt
		addq.w	#8,d0
		swap	d3
		asr.l	#1,d3
		divs	d0,d3
		bvc.s	l3a828
		swap	d3
		asr.w	#8,d3
		asr.w	#6,d3
		eori.w	#$7fff,d3
	l3a828:	swap	d4
		asr.l	#1,d4
		divs	d0,d4
		bvc.s	l3a83a
		swap	d4
		asr.w	#8,d4
		asr.w	#6,d4
		eori.w	#$7fff,d4
	l3a83a:	muls	d2,d3
		add.l	d3,d3
		swap	d3
		muls	d2,d4
		add.l	d4,d4
		swap	d4
		move.w	d4,d6
		move.w	d3,d7
		neg.w	d7
		move.w	#$aaaa,d2
		muls	d2,d3
		add.l	d3,d3
		add.l	d3,d3
		swap	d3
		muls	d2,d4
		add.l	d4,d4
		add.l	d4,d4
		swap	d4
		movem.w	(a7),d0-1
		add.w	d6,d0
		add.w	d7,d1
		movem.w	d0-1,(a1)
		movem.w	d0-1,30(a1)
		movem.w	d0-1,40(a1)
		movem.w	d0-1,70(a1)
		sub.w	d3,d0
		sub.w	d4,d1
		movem.w	d0-1,4(a1)
		add.w	d3,d0
		add.w	d3,d0
		add.w	d4,d1
		add.w	d4,d1
		movem.w	d0-1,44(a1)
		movem.w	(a7)+,d0-1
		sub.w	d6,d0
		sub.w	d7,d1
		movem.w	d0-1,12(a1)
		movem.w	d0-1,18(a1)
		movem.w	d0-1,52(a1)
		movem.w	d0-1,58(a1)
		sub.w	d3,d0
		sub.w	d4,d1
		movem.w	d0-1,8(a1)
		add.w	d3,d0
		add.w	d3,d0
		add.w	d4,d1
		add.w	d4,d1
		movem.w	d0-1,48(a1)
		neg.w	d5
		muls	d5,d3
		add.l	d3,d3
		swap	d3
		muls	d5,d4
		add.l	d4,d4
		swap	d4
		movem.w	(a1),d0-1
		add.w	d3,d0
		add.w	d4,d1
		movem.w	d0-1,26(a1)
		movem.w	d0-1,66(a1)
		movem.w	12(a1),d0-1
		add.w	d3,d0
		add.w	d4,d1
		movem.w	d0-1,22(a1)
		movem.w	d0-1,62(a1)
		rts

	l3a908:	cmp.w	#$9000,d5
		blt.s	l3a922
	l3a90e:	add.w	-104(a6),d6
		bra.s	l3a922
	l3a914:	andi.w	#$efe,d6
		bclr	#$4,d6
		beq.s	l3a922
		add.w	-154(a6),d6
	l3a922:	subq.w	#1,d0
		subq.w	#1,d1
		move.w	d4,d2
		beq.w	l3aa96
		cmp.w	#$d,d2
		bgt.w	l3aa9e
		cmp.w	#$9,d2
		bgt.w	l3aa9e

* this label is probably shite.
L3a93c_project_real_circle:
		move.l	a0,vertex_a0
		cmp.w	#$140,d0
		bcc.w	l3aa46
		cmp.w	#$a8,d1
		bcc.w	l3aa46
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3a9a0
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3a97a
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3a97a
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3a99c
	l3a976:	moveq	#1,d4
		bra.s	l3a99c
	l3a97a:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3a988
		neg.l	d4
	l3a988:	tst.l	d5
		bpl.s	l3a98e
		neg.l	d5
	l3a98e:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3a976
		lsr.l	d5,d4
		beq.s	l3a976
	l3a99c:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
	l3a9a0:	
		move.l	vertex_a0,a0
		btst	#$7,-147(a6)
		* have star twinkly spikes or not?
		beq.s	l3a9a1_no_twinkly
		hcall	#Nu_PutTwinklyCircle
		bra.s	l3a9a1_continue
	l3a9a1_no_twinkly:
		hcall	#Nu_PutCircle
	l3a9a1_continue:
		lea	12(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$176,(a1)
		btst	#$7,-147(a6)
		beq.s	l3a9be
		move.w	#$1ba,(a1)
		subq.w	#1,d0
		subq.w	#1,d1
	l3a9be:	movem.w	d0-2,4(a1)
		move.w	d6,d5
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3a9dc
		tst.w	d6
		beq.s	l3a9fc
		move.w	d0,d6
		bra.s	l3a9fc
	l3a9dc:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d0
		cmp.w	#$f8,d0
		blt.s	l3a9ee
		moveq	#0,d6
		bra.s	l3a9fc
	l3a9ee:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3a9fc:	move.w	d6,2(a1)
		move.w	d5,d6
		andi.w	#$eee,d6
		lsr.w	#1,d6
		addi.w	#$222,d6
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3aa22
		tst.w	d6
		beq.s	l3aa42
		move.w	d0,d6
		bra.s	l3aa42
	l3aa22:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d0
		cmp.w	#$f8,d0
		blt.s	l3aa34
		moveq	#0,d6
		bra.s	l3aa42
	l3aa34:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3aa42:	move.w	d6,10(a1)
	l3aa46:	rts

	l3aa48:	move.l	-146(a6),d2
		move.l	12(a0),d4
		asr.l	#8,d4
	l3aa52:	cmp.l	#$8000,d4
		blt.s	l3aa60
		asr.l	#1,d2
		lsr.l	#1,d4
		bra.s	l3aa52
	l3aa60:	asl.l	#8,d2
		divs	d4,d2
		tst.w	d2
		beq.s	l3aa9e
		lsr.w	#3,d2
		move.b	L3aa74(pc,d2.w),d2
		ext.w	d2
		bra.w	L3a93c_project_real_circle

* wobbly turd circles on imp courier
L3aa74:
		dc.b	$f9,$fa,$fb,$fb,$fb,$fb,$fc,$fc,$fc,$fc,$fd,$fd,$fd,$fd,$fe,$fe
		dc.b	$fe,$fe,$fe,$ff,$ff,$ff,$ff,$ff,$ff,$0,$0,$0,$0,$0,$0,$0
		dc.b	$0,$0
	l3aa96:	btst	#$7,-147(a6)
		bne.s	l3aa48
	l3aa9e:	
		move.l	a0,vertex_a0
	
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3aaf2
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3aacc
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3aacc
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3aaee
	l3aac8:	moveq	#1,d4
		bra.s	l3aaee
	l3aacc:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3aada
		neg.l	d4
	l3aada:	tst.l	d5
		bpl.s	l3aae0
		neg.l	d5
	l3aae0:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3aac8
		lsr.l	d5,d4
		beq.s	l3aac8
	l3aaee:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
	l3aaf2:
		move.l	vertex_a0,a0
		hcall	#Nu_PutCircle
		
		lea	10(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$4f8,(a1)
		movem.w	d0-2,4(a1)
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3ab1c
		tst.w	d6
		beq.s	l3ab3c
		move.w	d0,d6
		bra.s	l3ab3c
	l3ab1c:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d0
		cmp.w	#$f8,d0
		blt.s	l3ab2e
		moveq	#0,d6
		bra.s	l3ab3c
	l3ab2e:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3ab3c:	move.w	d6,2(a1)
		rts

blob_col:	ds.w	1
blob_rad:	ds.w	1

* BG stars, spacedust, blobs in starmap, hypercloud circles
L3ab42_ProjectBlobs:
		move.w	(a5)+,d7
		lsr.w	#4,d6
		andi.w	#$efe,d6
		bclr	#$4,d6
		beq.s	l3ab54
		add.w	-154(a6),d6
	l3ab54:	bclr	#$7,d7
		bne.s	l3ab5e
		ror.w	#7,d7
		bra.s	l3ab74
	l3ab5e:	add.w	d7,d7
		bclr	#$7,d7
		bne.s	l3ab70
		movea.l	-212(a6),a2
		move.w	114(a2,d7.w),d7
		bra.s	l3ab74
	l3ab70:	move.w	-64(a6,d7.w),d7
	l3ab74:	bclr	#$f,d7
		bne.s	l3aba6
		ext.l	d7
		move.w	-208(a6),d0
		subq.w	#7,d0
		bmi.s	l3ab88
		asl.l	d0,d7
		bra.s	l3ab8c
	l3ab88:	neg.w	d0
		asr.l	d0,d7
	l3ab8c:	move.l	-8(a6),d0
		ble.w	l3acd6
	l3ab94:	cmp.l	#$8000,d0
		blt.s	l3aba2
		asr.l	#1,d7
		lsr.l	#1,d0
		bra.s	l3ab94
	l3aba2:	asl.l	#8,d7
		divs	d0,d7
	l3aba6:	movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3ac00
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3abd4
		addi.w	#$18,d5
		move.l	-8(a6),d4
		bmi.s	l3abd4
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3abf6
	l3abd0:	moveq	#1,d4
		bra.s	l3abf6
	l3abd4:	move.w	d5,-(a7)
		movem.l	-16(a6),d4-5/a0
		tst.l	d4
		bpl.s	l3abe2
		neg.l	d4
	l3abe2:	tst.l	d5
		bpl.s	l3abe8
		neg.l	d5
	l3abe8:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3abd0
		lsr.l	d5,d4
		beq.s	l3abd0
	l3abf6:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
		move.l	a1,L385c8_primitives_end
	l3ac00:	
		movea.l	a1,a2
		move.w	#$588,(a1)+
		* radius to 2d prim
		move.w	d7,(a1)+
		move.w	d7,blob_rad
		lea	L2dc48_col_indices,a3
		move.w	d6,blob_col
		moveq	#0,d5
		move.b	0(a3,d6.w),d5
		beq.s	l3ac1e
		tst.w	d6
		beq.s	l3ac3e
		move.w	d5,d6
		bra.s	l3ac3e
	l3ac1e:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d5
		cmp.w	#$f8,d5
		blt.s	l3ac30
		moveq	#0,d6
		bra.s	l3ac3e
	l3ac30:	move.b	d5,0(a3,d6.w)
		swap	d6
		move.w	d5,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
		* col to 2d prim
	l3ac3e:	move.w	d6,(a1)+
		move.w	(a5)+,d6
	l3ac42:	move.w	d6,d0
		sub.b	d0,d0
		asr.w	#3,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3ac5a
		bsr.w	L3977c_ProjectCoords
	l3ac5a:	
		cmpi.l	#$40,12(a0)
		blt.s	l3ac7c
		
		* stardust, some other blobs eg. in starmap
		move.w	blob_col(pc),d0
		move.w	blob_rad(pc),d1
		hcall	#Nu_PutBlob
		
		movem.w	(a0),d0-1
		subq.w	#1,d0
		subq.w	#1,d1
		cmp.w	#$a7,d1
		bcc.s	l3ac7c
		cmp.w	#$13f,d0
		bcc.s	l3ac7c
		* x,y to old 2d prim
		move.w	d0,(a1)+
		move.w	d1,(a1)+
	l3ac7c:	move.b	d6,d0
		cmp.b	#$7f,d0
		beq.s	l3acc6
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3ac9a
		bsr.w	L3977c_ProjectCoords
	l3ac9a:	
		cmpi.l	#$40,12(a0)
		blt.s	l3acbc
		
		* stardust, (and that line of dots i don't want :(
		move.w	blob_col(pc),d0
		move.w	blob_rad(pc),d1
		hcall	#Nu_PutBlob
		
		movem.w	(a0),d0-1
		subq.w	#1,d0
		subq.w	#1,d1
		cmp.w	#$a7,d1
		bcc.s	l3acbc
		cmp.w	#$13f,d0
		bcc.s	l3acbc
		* x,y to old 2d prim
		move.w	d0,(a1)+
		move.w	d1,(a1)+
	l3acbc:	move.w	(a5)+,d6
		cmp.w	#$7f00,d6
		blt.w	l3ac42
	l3acc6:	move.w	#$ffff,(a1)+
		move.l	a1,d0
		sub.l	a2,d0
		add.l	d0,L385c8_primitives_end
		rts

	l3acd6:	move.w	(a5)+,d6
		cmp.b	#$7f,d6
		bne.s	l3acd6
		rts

		
L3ace0_ProjectLine_1:
		move.w	(a5)+,d7

L3ace2_project_line:
		lsr.w	#4,d6
		move.w	-98(a6),d0
		bclr	#$4,d6
		beq.s	l3ad00
		bclr	#$8,d6
		bne.s	l3acfa
		add.w	d0,d6
		andi.w	#$fff,d6
	l3acfa:	add.w	-154(a6),d6
		bra.s	l3ad0c
	l3ad00:	bclr	#$8,d6
		bne.s	l3ad0c
		add.w	d0,d6
		andi.w	#$fff,d6
	l3ad0c:	move.w	d7,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3ad24
		bsr.w	L3977c_ProjectCoords
	l3ad24:	movea.l	a0,a1
		asr.w	#8,d7
		move.w	d7,d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3ad3e
		bsr.w	L3977c_ProjectCoords
	l3ad3e:
		* d0,d1 d1,d2 projected x,y pair for 3d line
		movem.w	(a0),d0-1
		movem.w	(a1),d2-3
		cmp.w	#$140,d0
		bcc.w	l3ae06
		cmp.w	#$a8,d1
		bcc.w	l3ae06
		cmp.w	#$140,d2
		bcc.w	l3ae76
		cmp.w	#$a8,d3
		bcc.w	l3ae76

* Puts 2d line primitive of projected 3d line
* rgb 444 col in d6.
L3ad66_put_line_primitive:
		move.w	d6,prim_col
		move.l	a0,vertex_a0
		move.l	a1,vertex_a1
		
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3adba
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3ad94
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3ad94
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3adb6
	l3ad90:	moveq	#1,d4
		bra.s	l3adb6
	l3ad94:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3ada2
		neg.l	d4
	l3ada2:	tst.l	d5
		bpl.s	l3ada8
		neg.l	d5
	l3ada8:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3ad90
		lsr.l	d5,d4
		beq.s	l3ad90
	l3adb6:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
	l3adba:	
		movem.l	d6/a0-1,-(a7)
		move.l	vertex_a0,a0
		move.l	vertex_a1,a1
		move.w	prim_col,d6
		hcall	#Nu_PutLine
		movem.l	(a7)+,a0-1/d6
	
		lea	12(a1),a0
		move.l	a0,L385c8_primitives_end
		move.w	#$518,(a1)
		lea	L2dc48_col_indices,a2
		moveq	#0,d5
		move.b	0(a2,d6.w),d5
		beq.s	l3adde
		tst.w	d6
		beq.s	l3adfe
		move.w	d5,d6
		bra.s	l3adfe
	l3adde:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d5
		cmp.w	#$f8,d5
		blt.s	l3adf0
		moveq	#0,d6
		bra.s	l3adfe
	l3adf0:	move.b	d5,0(a2,d6.w)
		swap	d6
		move.w	d5,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3adfe:	movem.w	d0-3/d6,2(a1)
	l3ae04:	rts

	l3ae06:	cmp.w	#$140,d2
		bcc.s	l3ae3a
		cmp.w	#$a8,d3
		bcc.s	l3ae3a
		bsr.s	L3ae88
		bra.w	L3ad66_put_line_primitive
	l3ae18:	addq.l	#2,a7

L3ae1a:
		rts

		dc.b	$ff,$ff,$0,$0,$0,$0,$ff,$ff,$0,$0,$0,$0,$0,$0,$ff,$ff
		ds.b	14
	l3ae3a:	move.w	d6,-(a7)
		moveq	#0,d7
		move.w	d0,d6
		bsr.w	L3b2cc
		move.w	d2,d6
		bsr.w	L3b2cc
		move.w	L3ae1a(pc,d7.w),d7
		bne.s	l3ae18
		move.w	d1,d6
		bsr.w	L3b2e8
		move.w	d3,d6
		bsr.w	L3b2e8
		move.w	(a7)+,d6
		move.w	L3ae1a(pc,d7.w),d7
		bne.s	l3ae04
		cmpi.l	#$40,12(a1)
		bge.s	l3ae74
		exg	a1,a0
		exg	d0,d2
		exg	d1,d3
	l3ae74:	bsr.s	L3ae88
	l3ae76:	exg	d0,d2
		exg	d1,d3
		exg	a1,a0
		bsr.s	L3ae88
		exg	a1,a0
		exg	d0,d2
		exg	d1,d3
		bra.w	L3ad66_put_line_primitive

L3ae88:
		cmpi.l	#$40,12(a0)
		bge.s	l3aeb8
		cmpi.l	#$40,12(a1)
		bge.s	l3aea0
	l3ae9c:	addq.l	#4,a7
		rts

	l3aea0:	movem.w	d2-3,-(a7)
		movem.l	4(a0),d0-2
		movem.l	4(a1),d3-5
		bsr.w	L37d96
		movem.w	(a7)+,d2-3
	l3aeb8:	bsr.w	L37c34
		cmp.w	#$140,d0
		bcc.s	l3ae9c
		cmp.w	#$a8,d1
		bcc.s	l3ae9c
		rts

prim_col:	ds.w	1
vertex_a0:	ds.l	1
vertex_a1:	ds.l	1
vertex_a2:	ds.l	1
vertex_a3:	ds.l	1

L3aeca_ProjectTriangle_2:
		move.w	d6,-150(a6)
		move.l	(a7)+,-148(a6)
		move.l	(a5)+,d7
		eori.l	#$1010101,d7
		bsr.s	l3aee8
		move.w	-150(a6),d6
		move.l	-148(a6),-(a7)
		subq.l	#4,a5
		
L3aee6_ProjectTriangle_1:
		move.l	(a5)+,d7
	l3aee8:
		lsr.w	#4,d6
		moveq	#0,d0
		move.b	d7,d0
		add.w	d0,d0
		lea	8(a7,d0.w),a0
		cmpi.w	#$8080,(a0)
		bne.s	l3aefe
		bsr.w	L3a02a_3DPrimCullNLight
	l3aefe:	move.w	(a0),d0
		bmi.w	l3ae04
		bclr	#$4,d6
		beq.s	l3af1c
		bclr	#$8,d6
		bne.s	l3af16
		add.w	d0,d6
		andi.w	#$fff,d6
	l3af16:	add.w	-154(a6),d6
		bra.s	l3af28
	l3af1c:	bclr	#$8,d6
		bne.s	l3af28
		add.w	d0,d6
		andi.w	#$fff,d6
	l3af28:	move.l	d7,d0
		swap	d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3af42
		bsr.w	L3977c_ProjectCoords
	l3af42:	movea.l	a0,a1
		lsr.l	#8,d7
		move.w	d7,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3af5e
		bsr.w	L3977c_ProjectCoords
	l3af5e:	movea.l	a0,a2
		swap	d7
		move.w	d7,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3af7a
		bsr.w	L3977c_ProjectCoords
	l3af7a:	
		move.w	d6,prim_col
		move.l	a0,vertex_a0
		move.l	a1,vertex_a1
		move.l	a2,vertex_a2
		
		movem.w	(a0),d0-1
		movem.w	(a1),d2-3
		movem.w	(a2),d4-5
		
		tst.w	gl_renderer_on
		bne.s	l3afd0
		
		cmp.w	#$140,d0
		bcc.w	l3b05a
		cmp.w	#$a8,d1
		bcc.w	l3b05a
		cmp.w	#$140,d2
		bcc.w	l3b07e
		cmp.w	#$a8,d3
		bcc.w	l3b07e
		cmp.w	#$140,d4
		bcc.w	l3b07e
		cmp.w	#$a8,d5
		bcc.w	l3b07e
	l3afd0:
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3b00a
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3afe4
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3afe4
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3b006
	l3afe0:	moveq	#1,d4
		bra.s	l3b006
	l3afe4:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3aff2
		neg.l	d4
	l3aff2:	tst.l	d5
		bpl.s	l3aff8
		neg.l	d5
	l3aff8:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3afe0
		lsr.l	d5,d4
		beq.s	l3afe0
	l3b006:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
	l3b00a:
		movem.l	d6/a0-2,-(a7)
		move.l	vertex_a0,a0
		move.l	vertex_a1,a1
		move.l	vertex_a2,a2
		move.w	prim_col,d6
		hcall	#Nu_PutTriangle
		movem.l	(a7)+,a0-2/d6
	
		lea	16(a1),a0
		move.l	a0,L385c8_primitives_end
		* triangle primitive
		move.w	#$534,(a1)
		movem.w	(a2),d4-5
		lea	L2dc48_col_indices,a2
		moveq	#0,d7
		move.b	0(a2,d6.w),d7
		beq.s	l3b032
		tst.w	d6
		beq.s	l3b052
		move.w	d7,d6
		bra.s	l3b052
	l3b032:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d7
		cmp.w	#$f8,d7
		blt.s	l3b044
		moveq	#0,d6
		bra.s	l3b052
	l3b044:	move.b	d7,0(a2,d6.w)
		swap	d6
		move.w	d7,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3b052:	movem.w	d0-6,2(a1)
		
	l3b058:	rts

	l3b05a:	cmp.w	#$140,d2
		bcc.s	l3b066
		cmp.w	#$a8,d3
		bcs.s	l3b07e
	l3b066:	cmp.w	#$140,d4
		bcc.s	l3b072
		cmp.w	#$a8,d5
		bcs.s	l3b07e
	l3b072:	move.w	d6,-(a7)
		move.w	d4,d6
		move.w	d5,d7
		movea.l	a2,a3
		bra.w	L3b276
	l3b07e:	movea.l	a2,a3
		bra.w	L3b30a
		
L3b084_ProjectQuad_2:
		move.w	d6,-150(a6)
		move.l	(a7)+,-148(a6)
		move.l	(a5)+,d7
		eori.l	#$1010101,d7
		move.w	(a5)+,d0
		eori.w	#$1,d0
		bsr.s	l3b0aa
		move.w	-150(a6),d6
		move.l	-148(a6),-(a7)
		subq.l	#6,a5
		
L3b0a6_ProjectQuad_1:
		move.l	(a5)+,d7
		move.w	(a5)+,d0

	l3b0aa:
		lsr.w	#4,d6
		add.w	d0,d0
		lea	8(a7,d0.w),a0
		cmpi.w	#$8080,(a0)
		bne.s	l3b0bc
		bsr.w	L3a02a_3DPrimCullNLight
	l3b0bc:	move.w	(a0),d0
		bmi.s	l3b058
		bclr	#$4,d6
		beq.s	l3b0d8
		bclr	#$8,d6
		bne.s	l3b0d2
		add.w	d0,d6
		andi.w	#$fff,d6
	l3b0d2:	add.w	-154(a6),d6
		bra.s	l3b0e4
	l3b0d8:	bclr	#$8,d6
		bne.s	l3b0e4
		add.w	d0,d6
		andi.w	#$fff,d6
	l3b0e4:	move.w	d6,-(a7)
		move.w	d7,d6
		move.l	d7,d0
		swap	d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b102
		bsr.w	L3977c_ProjectCoords
	l3b102:	movea.l	a0,a1
		lsr.l	#8,d7
		move.w	d7,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b11e
		bsr.w	L3977c_ProjectCoords
	l3b11e:	movea.l	a0,a2
		swap	d7
		move.w	d7,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b13a
		bsr.w	L3977c_ProjectCoords
	l3b13a:	movea.l	a0,a3
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b154
		bsr.w	L3977c_ProjectCoords
	l3b154:	
		move.w	(a7),d6
		move.w	d6,prim_col
		move.l	a0,vertex_a0
		move.l	a1,vertex_a1
		move.l	a2,vertex_a2
		move.l	a3,vertex_a3
		
	
		movem.w	(a0),d0-1
		movem.w	(a1),d2-3
		movem.w	(a2),d6-7
		movem.w	(a3),d4-5
		
		tst.w	gl_renderer_on
		bne.s	l3b1a0
		
		cmp.w	#$140,d0
		bcc.w	l3b24c
		cmp.w	#$a8,d1
		bcc.w	l3b24c
		cmp.w	#$140,d2
		bcc.w	l3b308
		cmp.w	#$a8,d3
		bcc.w	l3b308
		cmp.w	#$140,d4
		bcc.w	l3b308
		cmp.w	#$a8,d5
		bcc.w	l3b308
		cmp.w	#$140,d6
		bcc.w	l3b308
		cmp.w	#$a8,d7
		bcc.w	l3b308
	l3b1a0:
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3b1f8
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3b1d2
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3b1d2
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3b1f4
	l3b1ce:	moveq	#1,d4
		bra.s	l3b1f4
	l3b1d2:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3b1e0
		neg.l	d4
	l3b1e0:	tst.l	d5
		bpl.s	l3b1e6
		neg.l	d5
	l3b1e6:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3b1ce
		lsr.l	d5,d4
		beq.s	l3b1ce
	l3b1f4:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
	l3b1f8:	
		movem.l	d6/a0-3,-(a7)
		move.l	vertex_a0,a0
		move.l	vertex_a1,a1
		move.l	vertex_a2,a2
		move.l	vertex_a3,a3
		move.w	prim_col,d6
		hcall	#Nu_PutQuad
		movem.l	(a7)+,a0-3/d6
	
		lea	20(a1),a0
		move.l	a0,L385c8_primitives_end
		* push quad primitive
		move.w	#$550,(a1)+
		movem.w	(a3),d4-5
		movem.w	d0-7,(a1)
		move.w	(a7)+,d6
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3b226
		tst.w	d6
		beq.s	l3b246
		move.w	d0,d6
		bra.s	l3b246
	l3b226:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d0
		cmp.w	#$f8,d0
		blt.s	l3b238
		moveq	#0,d6
		bra.s	l3b246
	l3b238:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3b246:	move.w	d6,16(a1)
		rts

	l3b24c:	cmp.w	#$140,d2
		bcc.s	l3b25a
		cmp.w	#$a8,d3
		bcs.w	l3b308
	l3b25a:	cmp.w	#$140,d4
		bcc.s	l3b268
		cmp.w	#$a8,d5
		bcs.w	l3b308
	l3b268:	cmp.w	#$140,d6
		bcc.s	L3b276
		cmp.w	#$a8,d7
		bcs.w	l3b308

L3b276:
		movem.w	d6-7,-(a7)
		moveq	#0,d7
		move.w	d0,d6
		bsr.s	L3b2cc
		move.w	d2,d6
		bsr.s	L3b2cc
		move.w	d4,d6
		bsr.s	L3b2cc
		move.w	(a7),d6
		bsr.s	L3b2cc
		move.w	L3b2ac(pc,d7.w),d7
		bne.s	l3b2aa
		move.w	d1,d6
		bsr.s	L3b2e8
		move.w	d3,d6
		bsr.s	L3b2e8
		move.w	d5,d6
		bsr.s	L3b2e8
		move.w	2(a7),d6
		bsr.s	L3b2e8
		move.w	L3b2ac(pc,d7.w),d7
		beq.s	l3b304
	l3b2aa:	addq.l	#6,a7

L3b2ac:
		rts

		dc.b	$ff,$ff,$0,$0,$0,$0,$ff,$ff,$0,$0,$0,$0,$0,$0,$ff,$ff
		ds.b	14

L3b2cc:
		cmp.w	#$8002,d6
		beq.s	l3b2fe
		cmp.w	#$140,d6
		bcs.s	l3b2e2
		tst.w	d6
		bmi.s	l3b2f8
	l3b2dc:	bset	#$3,d7
		rts

	l3b2e2:	bset	#$2,d7
		rts

L3b2e8:
		cmp.w	#$8002,d6
		beq.s	l3b2fe
		cmp.w	#$a8,d6
		bcs.s	l3b2e2
		tst.w	d6
		bpl.s	l3b2dc
	l3b2f8:	bset	#$1,d7
		rts

	l3b2fe:	bset	#$4,d7
		rts

	l3b304:	movem.w	(a7)+,d6-7
	l3b308:	move.w	(a7)+,d6

L3b30a:
		movem.l	a4-5,-(a7)
		move.w	d6,-(a7)
		exg	a4,a1
		movea.l	a0,a5
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3b36e
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3b342
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3b342
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3b364
	l3b33e:	moveq	#1,d4
		bra.s	l3b364
	l3b342:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3b350
		neg.l	d4
	l3b350:	tst.l	d5
		bpl.s	l3b356
		neg.l	d5
	l3b356:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3b33e
		lsr.l	d5,d4
		beq.s	l3b33e
	l3b364:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
		move.l	a1,L385c8_primitives_end
	l3b36e:	exg	a4,a1
		movea.l	a5,a0
		move.l	#$2a0038,(a4)
	l3b378:	cmpi.l	#$40,12(a0)
		bge.s	l3b38e
		movea.l	a0,a5
		movea.l	a1,a0
		movea.l	a2,a1
		movea.l	a3,a2
		movea.l	a5,a3
		bra.s	l3b378
	l3b38e:	lea	4(a4),a5
		cmpi.l	#$40,12(a1)
		bge.s	l3b3e2
		movem.l	4(a0),d3-5
		movem.l	4(a1),d0-2
		bsr.w	L37d96
		movem.w	(a0),d2-3
		movem.w	d2-3,(a5)
		movem.w	d0-1,4(a5)
		addq.l	#8,a5
		cmpi.l	#$40,12(a2)
		blt.s	l3b414
		move.w	#$46,(a5)+
		movem.l	4(a1),d0-2
		movem.l	4(a2),d3-5
		bsr.w	L37d96
		movem.w	d0-1,(a5)
		addq.l	#4,a5
		bra.s	l3b43a
	l3b3e2:	movem.w	(a0),d0-1
		movem.w	(a1),d2-3
		movem.w	d0-3,(a5)
		addq.l	#8,a5
		cmpi.l	#$40,12(a2)
		bge.s	l3b43a
		movem.l	4(a2),d0-2
		movem.l	4(a1),d3-5
		bsr.w	L37d96
		move.w	#$46,(a5)+
		movem.w	d0-1,(a5)
		addq.l	#4,a5
	l3b414:	cmpi.l	#$40,12(a3)
		blt.s	l3b46c
		move.w	#$46,(a5)+
		movem.l	4(a2),d0-2
		movem.l	4(a3),d3-5
		bsr.w	L37d96
		movem.w	d0-1,(a5)
		addq.l	#4,a5
		bra.s	l3b488
	l3b43a:	move.w	#$46,(a5)+
		movem.w	(a2),d0-1
		movem.w	d0-1,(a5)
		addq.l	#4,a5
		cmpi.l	#$40,12(a3)
		bge.s	l3b488
		movem.l	4(a3),d0-2
		movem.l	4(a2),d3-5
		bsr.w	L37d96
		move.w	#$46,(a5)+
		movem.w	d0-1,(a5)
		addq.l	#4,a5
	l3b46c:	move.w	#$46,(a5)+
		movem.l	4(a3),d0-2
		movem.l	4(a0),d3-5
		bsr.w	L37d96
		movem.w	d0-1,(a5)
		addq.l	#4,a5
		bra.s	l3b496
	l3b488:	move.w	#$46,(a5)+
		movem.w	(a3),d0-1
		movem.w	d0-1,(a5)
		addq.l	#4,a5
	l3b496:	move.w	#$46,(a5)+
		movem.w	(a0),d0-1
		movem.w	d0-1,(a5)
		addq.l	#4,a5
		move.w	#$68,(a5)+
		move.w	(a7)+,d6
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3b4c0
		tst.w	d6
		beq.s	l3b4e0
		move.w	d0,d6
		bra.s	l3b4e0
	l3b4c0:	lea	L5dae_dyn_cols,a1
		move.w	(a1),d0
		cmp.w	#$f8,d0
		blt.s	l3b4d2
		moveq	#0,d6
		bra.s	l3b4e0
	l3b4d2:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a1,d6.w)
		addq.w	#4,(a1)
	l3b4e0:	move.w	d6,(a5)+
		move.l	a5,d0
		sub.l	a4,d0
		add.l	d0,L385c8_primitives_end
		movem.l	(a7)+,a4-5
		rts

	l3b4f2:	lsr.w	#8,d7
		adda.w	d7,a5
		rts

* Start of '0x5' object (shape composed of arbitrary numbe
* of straight edges and bezier edges, also possibly with
* sub-objects cut from the main one. cool!
L3b4f8_ComplexBegin:
		move.w	(a5)+,d7
		lsr.w	#4,d6
		move.b	d7,d0
		andi.w	#$7f,d0
		add.w	d0,d0
		lea	8(a7,d0.w),a0
		cmpi.w	#$8080,(a0)
		bne.s	l3b512
		bsr.w	L3a02a_3DPrimCullNLight
	l3b512:	move.w	(a0),d0
		* back-face cull
		bmi.s	l3b4f2
		bclr	#$4,d6
		beq.s	l3b52e
		bclr	#$8,d6
		bne.s	l3b528
		add.w	d0,d6
		andi.w	#$fff,d6
	l3b528:	add.w	-154(a6),d6
		bra.s	l3b53a
	l3b52e:	bclr	#$8,d6
		bne.s	l3b53a
		add.w	d0,d6
		andi.w	#$fff,d6
	l3b53a:	move.w	d6,-160(a6)
		clr.w	-184(a6)
		move.b	d7,-186(a6)
		move.b	1(a5),d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b560
		bsr.w	L3977c_ProjectCoords
	l3b560:	
		hcall	#Nu_ComplexStart
		
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3b5b4
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3b58e
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3b58e
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3b5b0
	l3b58a:	moveq	#1,d4
		bra.s	l3b5b0
	l3b58e:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3b59c
		neg.l	d4
	l3b59c:	tst.l	d5
		bpl.s	l3b5a2
		neg.l	d5
	l3b5a2:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3b58a
		lsr.l	d5,d4
		beq.s	l3b58a
	l3b5b0:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
	l3b5b4:	lea	2(a1),a0
		move.l	a0,L385c8_primitives_end
		move.l	a1,-190(a6)
		move.w	#$2a,(a1)

		bsr.s	L3b5c6
		hcall	#Nu_ComplexEnd

		rts

L3b5c6:
		move.b	(a5)+,d7
		ext.w	d7
		move.w	L3b5ee(pc,d7.w),d7
		jsr	L3b5ee(pc,d7.w)
		move.b	(a5)+,d7
		ext.w	d7
		move.w	L3b5ee(pc,d7.w),d7
		jsr	L3b5ee(pc,d7.w)
		move.b	(a5)+,d7
		ext.w	d7
		pea	L3b5c6(pc)
		move.w	L3b5ee(pc,d7.w),d7
		jmp	L3b5ee(pc,d7.w)

* complex object turd fuck fuck cunt
L3b5ee:
		dc.w	L3b5fc_ComplexStraight-L3b5ee
		dc.w	L3b8e2_ComplexBezierBit-L3b5ee
		dc.w	L3b6b4-L3b5ee
		dc.w	L3b7de-L3b5ee
		dc.w	L3b8a8-L3b5ee
		dc.w	L3b680-L3b5ee
		dc.w	L3b9aa_FilledOvalThingy-L3b5ee

L3b5fc_ComplexStraight:
		addq.l	#1,a5
		tst.w	-162(a6)
		beq.s	l3b62e
		movea.l	-172(a6),a0
		bsr.w	L3b7f6
		tst.w	-168(a6)
		beq.s	l3b62e
		movem.w	-166(a6),d0-1
		movea.l	L385c8_primitives_end,a0
		addq.l	#6,L385c8_primitives_end
		move.w	#$46,(a0)
		movem.w	d0-1,2(a0)
	l3b62e:	movea.l	L385c8_primitives_end,a0
		addq.l	#4,L385c8_primitives_end
		move.w	#$68,(a0)
		move.w	-160(a6),d6
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3b658
		tst.w	d6
		beq.s	l3b678
		move.w	d0,d6
		bra.s	l3b678
	l3b658:	lea	L5dae_dyn_cols,a1
		move.w	(a1),d0
		cmp.w	#$f8,d0
		blt.s	l3b66a
		moveq	#0,d6
		bra.s	l3b678
	l3b66a:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a1,d6.w)
		addq.w	#4,(a1)
	l3b678:	move.w	d6,2(a0)
		addq.l	#4,a7
		rts

L3b680:
		addq.l	#1,a5
		tst.w	-162(a6)
		beq.s	l3b6b2
		movea.l	-172(a6),a0
		bsr.w	L3b7f6
		tst.w	-168(a6)
		beq.s	l3b6b2
		movem.w	-166(a6),d0-1
		movea.l	L385c8_primitives_end,a0
		addq.l	#6,L385c8_primitives_end
		move.w	#$46,(a0)
		movem.w	d0-1,2(a0)
	l3b6b2:	rts

L3b6b4:
		move.b	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b6cc
		bsr.w	L3977c_ProjectCoords
		* MARKER orange (see sirius logo)
		move.l	d0,-(a7)
		move.w	#$f70,d0
		hcall	#Nu_PutColoredPoint
		move.l	(a7)+,d0
	l3b6cc:	movea.l	a0,a1
		move.l	a1,-172(a6)
		move.w	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b6ea
		bsr.w	L3977c_ProjectCoords
	l3b6ea:	
		move.l	d6,-(a7)
		move.w	-160(a6),d6
		hcall	#Nu_ComplexSBegin
		move.l	(a7)+,d6
		
		move.l	a0,-176(a6)
		move.w	#$ffff,-162(a6)
		cmpi.l	#$40,12(a1)
		blt.s	l3b730
		cmpi.l	#$40,12(a0)
		blt.s	l3b75c
		clr.w	-168(a6)
		movem.w	(a1),d0-1

L3b710:
		movem.w	(a0),d2-3
	l3b714:	movea.l	L385c8_primitives_end,a0
		addi.l	#$a,L385c8_primitives_end
		move.w	#$38,(a0)
		movem.w	d0-3,2(a0)
		rts

	l3b730:	tst.b	-186(a6)
		bmi.s	L3b78e
		cmpi.l	#$40,12(a0)
		blt.s	l3b782
		movem.l	4(a1),d0-2
		movem.l	4(a0),d3-5
		bsr.w	L37d96
		movem.w	d0-1,-166(a6)
		clr.w	-168(a6)
		bra.s	L3b710
	l3b75c:	tst.b	-186(a6)
		bmi.s	L3b78e
		movem.l	4(a0),d0-2
		movem.l	4(a1),d3-5
		bsr.w	L37d96
		movem.w	(a1),d2-3
		exg	d0,d2
		exg	d1,d3
		move.w	#$ffff,-168(a6)
		bra.s	l3b714
	l3b782:	clr.w	-162(a6)
		move.w	#$ffff,-168(a6)
		rts

L3b78e:
		move.b	(a5)+,d7
		andi.w	#$e,d7
		pea	L3b78e(pc)
		move.w	L3b7ac(pc,d7.w),d7
		jmp	L3b7ac(pc,d7.w)

L3b7a0:
		addq.l	#1,a5
		rts
L3b7a4:
		addq.l	#3,a5
		rts
L3b7a8:
		addq.l	#5,a5
		rts

L3b7ac:
		dc.w	L3b7ba-L3b7ac
		dc.w	L3b7a8-L3b7ac
		dc.w	L3b7a4-L3b7ac
		dc.w	L3b7a0-L3b7ac
		dc.w	L3b7a4-L3b7ac
		dc.w	L3b7a0-L3b7ac
		dc.w	L3b7a4-L3b7ac

L3b7ba:
		addq.l	#1,a5
		move.l	-190(a6),L385c8_primitives_end
		movea.l	L385c8_primitives_end,a0
		move.w	#$65e,(a0)
		movea.l	L385c8_primitives_end,a0
		addq.l	#2,L385c8_primitives_end
		addq.l	#8,a7
		rts

L3b7de:
		move.b	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		* XXX erm. uncomment this
		*beq.s	L3b7f6
		bsr.w	L3977c_ProjectCoords

L3b7f6:
		move.l	d6,-(a7)
		move.w	-160(a6),d6
		hcall	#Nu_ComplexSNext
		move.l	(a7)+,d6

		tst.w	-168(a6)
		bne.s	l3b828
		cmpi.l	#$40,12(a0)
		blt.w	l3b87e
		move.l	a0,-176(a6)
	l3b80c:	movem.w	(a0),d0-1

L3b810:
		movea.l	L385c8_primitives_end,a0
		addq.l	#6,L385c8_primitives_end
		move.w	#$46,(a0)
		movem.w	d0-1,2(a0)
		rts

	l3b828:	cmpi.l	#$40,12(a0)
		blt.w	l3b8dc
	l3b834:	movea.l	-176(a6),a1
		move.l	a0,-176(a6)
		clr.w	-168(a6)
		movem.l	4(a1),d0-2
		movem.l	4(a0),d3-5
		bsr.w	L37d96
		tst.w	-162(a6)
		beq.s	l3b86e
		movea.l	L385c8_primitives_end,a2
		addq.l	#6,L385c8_primitives_end
		move.w	#$46,(a2)
		movem.w	d0-1,2(a2)
		bra.s	l3b80c
	l3b86e:	move.w	#$ffff,-162(a6)
		movem.w	d0-1,-166(a6)
		bra.w	L3b710
	l3b87e:	tst.b	-186(a6)
		bmi.w	L3b78e
		movem.l	4(a0),d0-2
		movea.l	-176(a6),a1
		movem.l	4(a1),d3-5
		bsr.w	L37d96
		move.l	a0,-176(a6)
		move.w	#$ffff,-168(a6)
		bra.w	L3b810

L3b8a8:
		movea.l	-176(a6),a1
		cmpi.l	#$40,12(a1)
		bge.s	l3b902
		addq.l	#2,a5
		move.b	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b8d0
		bsr.w	L3977c_ProjectCoords
	l3b8d0:	
		* MARKER red
		move.l	d0,-(a7)
		move.w	#$f00,d0
		hcall	#Nu_PutColoredPoint
		move.l	(a7)+,d0
		
		cmpi.l	#$40,12(a0)
		bge.w	l3b834
	l3b8dc:	move.l	a0,-176(a6)
		rts

L3b8e2_ComplexBezierBit:
		addq.l	#1,a5
		move.b	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b8fc
		bsr.w	L3977c_ProjectCoords
	l3b8fc:
		move.w	-160(a6),d6
		hcall	#Nu_ComplexStartInner
		
		movea.l	a0,a1
		move.l	a0,-172(a6)
	l3b902:	move.b	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b91a
		bsr.w	L3977c_ProjectCoords
	l3b91a:	movea.l	a0,a2
		move.b	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b934
		bsr.w	L3977c_ProjectCoords
	l3b934:	movea.l	a0,a3
		move.b	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b94e
		bsr.w	L3977c_ProjectCoords
	l3b94e:	moveq	#64,d0
		cmp.l	12(a0),d0
		bgt.w	l3b6ea
		cmp.l	12(a1),d0
		bgt.w	l3b6ea
		cmp.l	12(a2),d0
		bgt.w	l3b6ea
		cmp.l	12(a3),d0
		bgt.w	l3b6ea
		move.l	a0,-176(a6)
		clr.w	-168(a6)
		move.w	#$ffff,-162(a6)
		movem.w	(a1),d0-1
		movem.w	(a2),d2-3
		movem.w	(a3),d4-5
		movem.w	(a0),d6-7
	
		movem.l	d6/a0-3,-(a7)
		exg	a0,a1
		exg	a1,a2
		exg	a2,a3
		move.w	-160(a6),d6
		hcall	#Nu_ComplexBezier
		movem.l	(a7)+,d6/a0-3

		movea.l	L385c8_primitives_end,a0
		addi.l	#$12,L385c8_primitives_end
		move.w	#$5a,(a0)
		movem.w	d0-7,2(a0)
		rts

* intro, behind FRONTIER letters
L3b9aa_FilledOvalThingy:
		move.b	(a5)+,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3b9c2
		bsr.w	L3977c_ProjectCoords
	l3b9c2:	
		* MARKER dark green
		move.l	d0,-(a7)
		move.w	#$070,d0
		hcall	#Nu_PutColoredPoint
		move.l	(a7)+,d0
	
		cmpi.l	#$40,12(a0)
		ble.w	l3baaa
		moveq	#0,d6
		move.b	(a5)+,d6
		move.w	-208(a6),d3
		asl.w	d3,d6
		move.b	(a5)+,d0
		cmp.b	-184(a6),d0
		beq.w	l3bab0
		move.b	d0,-184(a6)
		ext.w	d0
		add.w	d0,d0
		movea.l	-220(a6),a1
		bclr	#$1,d0
		movem.w	-4(a1,d0.w),d0/d2
		beq.s	l3ba06
		asl.w	#8,d0
		move.w	d2,d1
		sub.b	d1,d1
		asl.w	#8,d2
		neg.w	d0
		bra.s	l3ba0e
	l3ba06:	asl.w	#8,d0
		move.w	d2,d1
		sub.b	d1,d1
		asl.w	#8,d2
	l3ba0e:	lea	-36(a6),a2
		move.w	12(a2),d3
		muls	d2,d3
		move.w	6(a2),d7
		muls	d1,d7
		add.l	d7,d3
		move.w	(a2)+,d7
		muls	d0,d7
		add.l	d7,d3
		add.l	d3,d3
		swap	d3
		move.w	12(a2),d4
		muls	d2,d4
		move.w	6(a2),d7
		muls	d1,d7
		add.l	d7,d4
		move.w	(a2)+,d7
		muls	d0,d7
		add.l	d7,d4
		add.l	d4,d4
		swap	d4
		move.w	12(a2),d5
		muls	d2,d5
		move.w	6(a2),d7
		muls	d1,d7
		add.l	d7,d5
		move.w	(a2)+,d7
		muls	d0,d7
		add.l	d7,d5
		add.l	d5,d5
		swap	d5
		movem.w	d3-5,-182(a6)
	l3ba60:	movem.l	4(a0),d0-2
		lea	-104(a7),a7
		bsr.w	L37fb2_ProjectOvalXYZ
		beq.s	l3baa0
		lea	72(a7),a7
		movea.l	L385c8_primitives_end,a1
		addi.l	#$24,L385c8_primitives_end
		move.w	#$5a,d0
		movem.w	(a7)+,d1-7/a0
		movem.w	d0-7/a0,(a1)
		movem.w	(a7)+,d1-7/a0
		movem.w	d0-7/a0,18(a1)
		clr.w	-162(a6)
		rts

	l3baa0:	lea	104(a7),a7
		clr.w	-162(a6)
	l3baa8:	rts

	l3baaa:	clr.w	-162(a6)
		addq.l	#2,a5
	l3bab0:	movem.w	-182(a6),d3-5
		bra.s	l3ba60

L3bab8_ProjectBezierLine:
		move.l	(a5)+,d7
		lsr.w	#4,d6
		move.w	(a5)+,d0
		add.w	d0,d0
		lea	8(a7,d0.w),a0
		cmpi.w	#$8080,(a0)
		bne.s	l3bace
		bsr.w	L3a02a_3DPrimCullNLight
	l3bace:	move.w	(a0),d0
		bmi.s	l3baa8
		bclr	#$0,d6
		bclr	#$4,d6
		beq.s	l3baee
		bclr	#$8,d6
		bne.s	l3bae8
		add.w	d0,d6
		andi.w	#$fff,d6
	l3bae8:	add.w	-154(a6),d6
		bra.s	l3bafa
	l3baee:	bclr	#$8,d6
		bne.s	l3bafa
		add.w	d0,d6
		andi.w	#$fff,d6
	l3bafa:	move.w	d6,-(a7)
		move.w	d7,d6
		move.l	d7,d0
		swap	d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3bb18
		bsr.w	L3977c_ProjectCoords
	l3bb18:	movea.l	a0,a1
		lsr.l	#8,d7
		move.w	d7,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3bb34
		bsr.w	L3977c_ProjectCoords
	l3bb34:	movea.l	a0,a2
		swap	d7
		move.w	d7,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3bb50
		bsr.w	L3977c_ProjectCoords
	l3bb50:	movea.l	a0,a3
		move.w	d6,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3bb6a
		bsr.w	L3977c_ProjectCoords
	l3bb6a:	moveq	#64,d0
		cmp.l	12(a0),d0
		bgt.w	l3bc42
		cmp.l	12(a1),d0
		bgt.w	l3bc42
		cmp.l	12(a2),d0
		bgt.w	l3bc42
		cmp.l	12(a3),d0
		bgt.w	l3bc42
		move.w	(a7),d6
		hcall	#Nu_PutBezierLine
		movem.w	(a0),d0-1
		movem.w	(a1),d2-3
		movem.w	(a3),d6-7
		movea.l	L385c8_primitives_end,a1
		tst.w	L385e4_3dview_word1
		bne.s	l3bbec
		move.w	-192(a6),d5
		subq.w	#3,d5
		neg.w	d5
		bgt.s	l3bbc6
		addi.w	#$18,d5
		move.l	12(a0),d4
		bmi.s	l3bbc6
		lsr.l	d5,d4
		bset	#$1f,d4
		bra.s	l3bbe8
	l3bbc2:	moveq	#1,d4
		bra.s	l3bbe8
	l3bbc6:	move.w	d5,-(a7)
		movem.l	4(a0),d4-5/a0
		tst.l	d4
		bpl.s	l3bbd4
		neg.l	d4
	l3bbd4:	tst.l	d5
		bpl.s	l3bbda
		neg.l	d5
	l3bbda:	add.l	d5,d4
		move.w	(a7)+,d5
		lsr.l	#3,d4
		add.l	a0,d4
		bmi.s	l3bbc2
		lsr.l	d5,d4
		beq.s	l3bbc2
	l3bbe8:	
		hcall	#Nu_InsertZNode
		bsr.w	L38594_InsertIntoZTree
	l3bbec:	lea	20(a1),a0
		move.l	a0,L385c8_primitives_end
		* push elipse primitive
		move.w	#$56c,(a1)
		movem.w	(a2),d4-5
		movem.w	d0-7,2(a1)
		move.w	(a7)+,d6
		lea	L2dc48_col_indices,a2
		moveq	#0,d0
		move.b	0(a2,d6.w),d0
		beq.s	l3bc1c
		tst.w	d6
		beq.s	l3bc3c
		move.w	d0,d6
		bra.s	l3bc3c
	l3bc1c:	lea	L5dae_dyn_cols,a0
		move.w	(a0),d0
		cmp.w	#$f8,d0
		blt.s	l3bc2e
		moveq	#0,d6
		bra.s	l3bc3c
	l3bc2e:	move.b	d0,0(a2,d6.w)
		swap	d6
		move.w	d0,d6
		move.l	d6,2(a0,d6.w)
		addq.w	#4,(a0)
	l3bc3c:	move.w	d6,18(a1)
		rts

	l3bc42:	addq.l	#2,a7
	l3bc44:	rts

L3bc46_ProjectThrust:
		move.l	(a5)+,d7
		lsr.w	#4,d6
		andi.w	#$efe,d6
		bclr	#$4,d6
		beq.s	l3bc58
		add.w	-154(a6),d6
	l3bc58:	move.l	d7,d0
		swap	d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3bc72
		bsr.w	L3977c_ProjectCoords
		* head of engine thrust 'drip'
	l3bc72:	movea.l	a0,a1
		cmpi.l	#$200,12(a1)
		ble.s	l3bc44
		move.l	d7,d0
		rol.l	#8,d0
		ext.w	d0
		asl.w	#5,d0
		lea	0(a4,d0.w),a0
		move.w	18(a0),d5
		cmp.b	-152(a6),d5
		beq.s	l3bc98
		bsr.w	L3977c_ProjectCoords
		* tail of engine thrust 
	l3bc98:	cmpi.l	#$200,12(a0)
		ble.s	l3bc44
		exg	a1,a0
		move.l	12(a0),