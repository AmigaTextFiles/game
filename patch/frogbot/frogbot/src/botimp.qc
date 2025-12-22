void() GameSettings;
void() LetterCodes;
void() LoadTemp1;
void() AddBot;
void() AddRandomBot;
void() AddBotError;
void() AddBots;
void() DoCountDown;

#ifdef QUAKEWORLD
	void() not_supported =
	{
		msg_entity = self;
		msg_level = PRINT_HIGH;
		sprint("This mode is only supported in normal Quake.\n");
	};
#endif // QUAKEWORLD

#ifdef MANUAL

	void() ToggleManualMode;
	void() ManualImpulseCommands;

#endif // MANUAL

/*
============
SetAttribs

============
*/
void() SetAttribs =
{
	skill_ = self.bot_skill;

	if (game_show_rules)
	{
		msg_level = PRINT_HIGH;
		bprint("(skill ");
		bprint_ftos(skill_);
		bprint(")\n");
	}

	if (skill_ <= 100)
	{
		self.cheat_aim = 0;
		self.accuracy = 45 - (skill_ * 0.225);	// 45 to 22.5
	}
	else
	{
		self.cheat_aim = (skill_ - 100) * 0.01;	// 0 to 1
		skill_ = 100;
	}

	self.mouse_accel = 2 + (skill_ * 0.08);	// 2 to 10
	self.dodge_amount = skill_ * 0.01;		// 0 to 1
	self.mouse_vel = skill_ * 0.5729578;	// 0 to 57.29578
	// ( 57.29578 = 180 / PI )

	self.look_anywhere = skill_ * 0.01;	// 0 to 1

	self.stop_turn_speed = 135 + (skill_ * 4.05);	// 135 to 540

	self.lookahead_time = 5 + (skill_ * 0.25);		// 5 to 30
	self.prediction_error = 1 - (skill_ * 0.01);	// 1 to 0

	self.firing_reflex = 1 / (2 + (skill_ * 0.08));		// 0.5 to 0.1
};

void() SetGame =
{
	game_disable_powerups = (!(gamemode & GAME_ENABLE_POWERUPS));
	game_enable_runes = gamemode & GAME_ENABLE_RUNES;
	game_enable_hook = gamemode & GAME_ENABLE_HOOK;
	game_enable_ctf = gamemode & GAME_ENABLE_CTF;
	game_capture_custom = gamemode & GAME_CAPTURE_CUSTOM;
	game_not_rune_rj = (!(gamemode & GAME_RUNE_RJ));
	game_rl_pref = gamemode & GAME_RL_PREF;
	game_not_match = (!(gamemode & GAME_MATCH));
	game_lava_cheat = gamemode & GAME_LAVA_CHEAT;
	game_look_cheat = gamemode & GAME_LOOK_CHEAT;
	game_show_rules = (!(gamemode & GAME_HIDE_RULES));

#ifdef QUAKE
	game_qwphysics = gamemode & GAME_QWPHYSICS;
	game_skins = (!(gamemode & GAME_NOSKINS));
	game_qwaim = gamemode & GAME_QWAIM;
	game_skinfix = gamemode & GAME_SKINFIX;
#endif // QUAKE

#ifdef QUAKEWORLD
	game_qizmo = (stof(infokey(world, "proxy")));
#endif // QUAKEWORLD
};

/*
============
InitParameters

============
*/
void() InitParameters =
{
	first_ent = nextent(world);
	test_enemy = first_ent;
	while(test_enemy)
	{
		maxplayers = maxplayers + 1;
		test_enemy = nextent(test_enemy);
	}

#ifdef QUAKE
	temp1 = cvar("temp1");
#endif // QUAKE

#ifdef QUAKEWORLD
	temp1 = stof(infokey(world, "temp1"));
	deathmatch = cvar("deathmatch");

	if (maxplayers > 24)
		maxplayers = 24;
#endif // QUAKEWORLD

	dropper = spawn();
	setsize (dropper, VEC_HULL_MIN, VEC_HULL_MAX);

	dropper.desire = goal_NULL;
	dropper.virtual_goal = dropper;

	self = dropper;
	NewItems();

	platform = spawn();	// also used for NULL values
	setsize (platform, '-16 -16 -25', '16 16 -24');

	InitBodyQue ();

	nextmap = mapname;
	pre_game = TRUE;

	gamemode = cvar("samelevel");

	SetGame();

	teamplay = cvar("teamplay");
	if (teamplay == 1)
		healthplay = TEAM_TOTAL_HEALTH_PROTECT;
	else if (teamplay == 2)
		healthplay = TEAM_FRAG_PENALTY;
	else if (teamplay == 3)
		healthplay = TEAM_HEALTH_PROTECT;
	else if (teamplay == 4)
	{
		healthplay = TEAM_HEALTH_PROTECT;
		armorplay = TRUE;
	}
	else if (teamplay == 5)
	{
		healthplay = TEAM_TOTAL_HEALTH_PROTECT;
		armorplay = TRUE;
	}
	else
	{
		teamplay = 0;
		cvar_set("teamplay", "0");
	}

	next_teamplay = teamplay;

	if (!temp1)
	{
		skill = 100;
		localcmd("\n");	// flush buffer (early Quake versions)
		localsave(0, 1, 0);
		localsave(1, 1, 1);
	}
	else
		LoadTemp1();

	SetSkill();

	sv_accelerate = cvar("sv_accelerate");
	sv_friction = cvar("sv_friction");

	numberofbots = -1;

	if ((deathmatch != floor(deathmatch)) || (deathmatch < 1) || (deathmatch > MAX_DEATHMATCH))
	{
		deathmatch = 1;
		cvar_set("deathmatch", "1");
	}

	next_deathmatch = deathmatch;

	if (game_not_match)
		GameSettings();

	if (deathmatch <= 3)
		available_weapons = IT_AXE_SHOTGUN;
	else
	{
		if (deathmatch == 4)
			available_weapons = IT_ALL_BUT_GRENADE;
		else
			available_weapons = IT_ALL;
	}

	if (deathmatch != 4)
		quad_factor = 4;
	else
		quad_factor = 8;
};

/*
============
SaveTemp1

============
*/
void() SaveTemp1 =
{
#ifdef QUAKE
	cvar_set_("temp1", skill + 1);
#endif // QUAKE

#ifdef QUAKEWORLD
	localcmd("localinfo temp1 ");
	localcmd_ftos(skill + 1);
	localcmd("\n");
#endif // QUAKEWORLD
};

/*
============
SetSkill

============
*/
void() SetSkill =
{
#ifdef QUAKE
	cvar_set_("skill", skill);
	old_skill = skill;
#endif // QUAKE

	first_ent.bot_skill = skill;
	SaveTemp1();
};

/*
============
LoadTemp1

============
*/
void() LoadTemp1 =
{
	skill = temp1 - 1;
};

/*
============
localsave

============
*/
void(float frogbot_pos, float index_, float value) localsave =
{
	#ifdef QUAKE
		localcmd("alias ");
		localcmd_ftos(frogbot_pos * 7 + index_);
		localcmd(" registered ");
		localcmd_ftos(value);
		localcmd("\n");
	#endif // QUAKE

	#ifdef QUAKEWORLD
		localcmd("localinfo ");
		localcmd_ftos(frogbot_pos * 9 + index_);
		localcmd(" ");
		localcmd_ftos(value);
		localcmd("\n");
	#endif // QUAKEWORLD
};

/*
============
localload

============
*/
void(float frogbot_pos) localload =
{
	#ifdef QUAKE
		localcmd_ftos(frogbot_pos * 7 + frogbot_load_stage);
		localcmd("\n");
	#endif // QUAKE

	#ifdef QUAKEWORLD
		str = ftos(frogbot_pos * 9 + frogbot_load_stage);
		registered = stof(infokey(world, str));
	#endif // QUAKEWORLD
};

/*
============
SaveFrogbot

============
*/
void() SaveFrogbot =
{
	localsave(numberofbots, 1, 2 + self.color_+ self.teamcolor * 256 + self.bot_skill * 65536);
	localsave(numberofbots, 2, self.block0);
	localsave(numberofbots, 3, self.block1);
	localsave(numberofbots, 4, self.block2);
	localsave(numberofbots, 5, self.block3);
	localsave(numberofbots, 6, self.block4);

#ifdef QUAKE
	localsave(numberofbots, 7, self_aiment.skin);
#endif // QUAKE

#ifdef QUAKEWORLD
	localsave(numberofbots, 7, self.skin0);
	localsave(numberofbots, 8, self.skin1);
	localsave(numberofbots, 9, self.skin2);
#endif // QUAKEWORLD

	localsave(numberofbots + 1, 1, 1);
};

/*
============
LoadFrogbot

============
*/
void() LoadFrogbot =
{
	self = postphysics;

	if (frogbot_load_stage)
	{
		#ifdef QUAKE
			registered = cvar("registered");
		#endif // QUAKE

		if (numberofbots == -1)
		{
			first_ent.admin_code = self.admin_code = registered;
			numberofbots = 0;
			if (invalid_map)
			{
				#ifdef QUAKE
					cvar_set("registered", "1");
				#endif // QUAKE
				load_frogbots = FALSE;
				return;
			}
		}
		else
		{
			if (frogbot_load_stage == 1)
			{
				if (registered == 1)
				{
					load_frogbots = FALSE;
					return;
				}
				registered = registered - 2;
				self.color_ = registered & 255;
				self.teamcolor = floor(registered / 256) & 255;
				self.bot_skill = floor(registered / 65536) & 255;
			}
			else if (frogbot_load_stage == 2)
				self.block0 = registered;
			else if (frogbot_load_stage == 3)
				self.block1 = registered;
			else if (frogbot_load_stage == 4)
				self.block2 = registered;
			else if (frogbot_load_stage == 5)
				self.block3 = registered;
			else if (frogbot_load_stage == 6)
				self.block4 = registered;
		#ifdef QUAKE
			else
				self.spawn_skin = registered;
		#endif // QUAKE

		#ifdef QUAKEWORLD
			else if (frogbot_load_stage == 7)
				self.skin0 = registered;
			else if (frogbot_load_stage == 8)
				self.skin1 = registered;
			else
				self.skin2 = registered;
		#endif // QUAKEWORLD

			if (frogbot_load_stage <= NUMBER_LOAD_STAGE)
			{
				frogbot_load_stage = frogbot_load_stage + 1;
				localload(numberofbots + 1);
				return;
			}

			AddBot();
		}
	}

	frogbot_load_stage = 1;
	localload(numberofbots + 1);
};

/*
============
CheckParameters

============
*/
void() CheckParameters =
{
	real_time = check_parm_time - start_time;
	timelimit = cvar("timelimit") * 60;

	if (start_time)
		DoCountDown();

	if (timelimit)
		if (real_time >= timelimit)
			if (!pre_game)
				NextLevel ();

	check_parm_time = floor(time) + 1;

	if (sv_accelerate != cvar("sv_accelerate"))
	{
		sv_accelerate = cvar("sv_accelerate");

		if (sv_accelerate < 10)
			sv_accelerate = 10;

		cvar_log("sv_accelerate", sv_accelerate);
	}


	if (next_deathmatch != cvar("deathmatch"))
	{
		next_deathmatch = cvar("deathmatch");
		bprintold("\"deathmatch\" changed to \"");
		bprintold_ftos(next_deathmatch);
		bprintold("\"\n");
		bprintold("(enabled next level)\n");
	}

	if (next_teamplay != cvar("teamplay"))
	{
		next_teamplay = cvar("teamplay");
	#ifdef QUAKEWORLD
		bprintold("\"teamplay\" changed to \"");
		bprintold_ftos(next_teamplay);
		bprintold("\"\n");
	#endif // QUAKEWORLD
		bprintold("(enabled next level)\n");
	}


#ifdef QUAKE
	if (cvar("sys_ticrate") > 0.025)
		cvar_set("sys_ticrate", "0.025");

	if (game_qwphysics)
		sv_maxfriction = sv_accelerate;
	else
		sv_maxfriction = sv_accelerate * 0.5;

	if (sv_maxfriction > 10)
		sv_maxfriction = 10;

	if (sv_friction > sv_maxfriction)
		cvar_set_("sv_friction", sv_maxfriction);

	if (sv_friction != cvar("sv_friction"))
	{
		sv_friction = cvar("sv_friction");
		if (sv_friction < 0)
		{
			sv_friction = 0;
			cvar_set_("sv_friction", 0);
		}
	}

	skill = cvar("skill");
	skill = floor(skill);
	if (skill < 0)
		skill = 0;
	if (skill > MAX_SKILL)
		skill = MAX_SKILL;

	if (skill != old_skill)
		SetSkill();

	if (host_framerate != cvar("host_framerate"))
	{
		host_framerate = cvar("host_framerate");
		bprintold("\"host_framerate\" changed to \"");
		bprintold_ftos(host_framerate * 1000000);
		bprintold("/1000000\"\n");
	}
#endif // QUAKE

#ifdef QUAKEWORLD
	if (sv_accelerate > 10)
		sv_maxfriction = 10;
	else
		sv_maxfriction = sv_accelerate;

	if (sv_friction > sv_maxfriction)
		cvar_set_("sv_friction", sv_maxfriction);

	if (sv_friction != cvar("sv_friction"))
	{
		sv_friction = cvar("sv_friction");
		if (sv_friction < 0)
			sv_friction = 0;
		cvar_log("sv_friction", sv_friction);
	}
#endif // QUAKEWORLD

	fraglimit = cvar("fraglimit");

	sv_maxspeed = cvar("sv_maxspeed");

	if (sv_maxspeed >= 346.666666)
	{
		if (sv_maxspeed > 400)
		{
			cvar_set("sv_maxspeed", "400");
			sv_maxspeed = 400;
		}
		sv_maxstrafespeed = 346.666666;
	}
	else
	{
		if (sv_maxspeed < 320)
		{
			cvar_set("sv_maxspeed", "320");
			sv_maxspeed = 320;
		}
		sv_maxstrafespeed = sv_maxspeed;
	}

	half_sv_maxspeed = sv_maxspeed * 0.5;
	inv_sv_maxspeed = 1 / sv_maxspeed;

	if (cvar("sv_gravity") != 800)
		cvar_set("sv_gravity", "800");
};

/*
============
BotExists

============
*/
float() BotExists =
{
	bot = frogbot_spawned;
	while (bot != postphysics)
	{
		if (bot != self)
		{
			if (NamesEqual(bot, self))
				return TRUE;
		}
		bot = nextent(bot);
	}
};

/*
============
HCFrogbot

============
*/
void(float value0, float value2, float value3, float value4, float value5, float value6) HCFrogbot =
{
	self.color_ = value0;
	self.block0 = value2;
	self.block1 = value3;
	self.block2 = value4;
	self.block3 = value5;
	self.block4 = value6;
};

/*
============
BeenSpawned

============
*/
float(entity client, float value) BeenSpawned =
{
	if (value < 48)
	{
		spawnbit0_ = 1;
		spawnbit1_ = 0;

		while (value > 0)
		{
			spawnbit0_ = spawnbit0_ * 2;
			value = value - 1;
		}

		if (spawnbit0_ >= 16777216)
		{
			spawnbit1_ = spawnbit0_ / 16777216;
			spawnbit0_ = 0;
		}

		if (client.spawnbit0 & spawnbit0_)
			return TRUE;
		if (client.spawnbit1 & spawnbit1_)
			return TRUE;
		client.spawnbit0 = client.spawnbit0 | spawnbit0_;
		client.spawnbit1 = client.spawnbit1 | spawnbit1_;
		client.number_spawnbits = client.number_spawnbits + 1;
	}
	return FALSE;
};

/*
============
SpawnHardBot

============
*/
void() SpawnHardBot =
{
	do
	{
		if (other.number_spawnbits >= (NUMBERHARDBOTS + other.number_bots))
		{
			self.block0 = 7303750;	// Fro
			self.block1 = 7299687;	// gbo
			self.block2 = 2302068;	// t #
			self.block3 = self.block4 = 0;
			current_frogbot = current_frogbot + 1;
			NumberToString_apply(self, current_frogbot);
			return;
		}
		rnd = random();
		rnd = floor(rnd * NUMBERHARDBOTS);
	} while (BeenSpawned(other, rnd + other.number_bots));

	if (rnd == 0)
		HCFrogbot(45, 13656538, 0, 0, 0, 0);
	else if (rnd == 1)
		HCFrogbot(59, 7303746, 0, 0, 0, 0);
	else if (rnd == 2)
		HCFrogbot(19, 4313702, 6790343, 25807, 0, 0);
	else if (rnd == 3)
		HCFrogbot(196, 15918237, 9627617, 40942, 0, 0);
	else if (rnd == 4)
		HCFrogbot(33, 7497940, 15233893, 0, 0, 0);
	else if (rnd == 5)
		HCFrogbot(203, 15527911, 15656420, 7958370, 0, 0);
	else if (rnd == 6)
		HCFrogbot(43, 15787474, 7104884, 101, 0, 0);
	else if (rnd == 7)
		HCFrogbot(205, 13551047, 12702405, 6724812, 7115713, 6672981);
	else if (rnd == 8)
		HCFrogbot(60, 15727005, 10478052, 0, 0, 0);
	else if (rnd == 9)
		HCFrogbot(160, 6583652, 101, 0, 0, 0);
	else if (rnd == 10)
		HCFrogbot(168, 14313828, 31194, 0, 0, 0);
	else if (rnd == 11)
		HCFrogbot(212, 15791443, 15594213, 61153, 0, 0);
	else if (rnd == 12)
		HCFrogbot(70, 7498087, 6646124, 0, 0, 0);
	else if (rnd == 13)
		HCFrogbot(4, 9585564, 15945970, 4693189, 5149682, 40164);
	else if (rnd == 14)
		HCFrogbot(75, 13421003, 13552076, 13475015, 13157313, 12963529);
	else
		HCFrogbot(13, 6603873, 13919177, 9749605, 12703185, 50635);
};

/*
============
SpawnBot

============
*/
float() SpawnBot =
{
	do
	{
		if (self.number_spawnbits >= self.number_bots)
			return FALSE;
		rnd = random();
		rnd = floor(rnd * self.number_bots);
	} while (BeenSpawned(self, rnd));

	msg_entity = self;
	stuffcmd("bot");
	stuffcmd_ftos(rnd + 1);
	stuffcmd("\n");

	return TRUE;
};

/*
============
AddRandomBot

============
*/
void() AddRandomBot =
{
	if (self.number_bots < 0)
	{
		if (self.number_bots == -1)
		{
			msg_entity = self;
			stuffcmd("wait;init\n");
			self.number_bots = 0 - time;
		}
		else if (self.number_bots != (0 - time))
			self.number_bots = 0;

		if (self.number_bots)
		{
			msg_entity = self;
			stuffcmd("wait;addbot\n");
			return TRUE;
		}
	}

	return (SpawnBot());
};

/*
============
ServerFull

============
*/
void() ServerFull =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;

#ifdef QUAKE
	if (maxplayers == 16)
		sprint("Server is full.\n");
	else
		sprint("Server is full: increase maxplayers with the -listen parameter.\n");
#endif // QUAKE

#ifdef QUAKEWORLD
	sprint("Server is full.\n");
#endif // QUAKEWORLD
};

/*
============
AddBot

Note: color = (shirt_color * 16) + pants_color
      team = pants_color + 1
	colors: 0 to 13
============
*/
void() AddBot =
{
	if (self.flags & FL_PLAYER)
	{
		if (load_frogbots)
			return;
		if (invalid_map)
		{
			InvalidMap();
			impulse_ = 0;
		}
	}

	if (markers_loaded)
	{
		if (scoreboardsize >= maxplayers)
		{
			ServerFull();
		}
		else
		{
			if (!self.block0)
			{
				if (AddRandomBot())
					return;
			}
			else if (BotExists())
			{
				CopyName(self, platform);	// NULL
				if (AddRandomBot())
					return;
			}

			other = self;

			numberofbots = numberofbots + 1;
			self = frogbot_spawned = EntityAt(first_frogbot, maxplayers - numberofbots);
			self.flags = FL_FROGBOT;
			self.classname = "frogbot";

		#ifdef QUAKE
			self_aiment = self.aiment = EntityAt(world, self.colormap);
			self_aiment.colormap = self.colormap;
			self_aiment.flags = FL_PLAYER;
			self_aiment.movetype = self_aiment.modelindex = 0;
			if (game_skins)
				self_aiment.skin = other.spawn_skin;
			else
				self_aiment.skin = 0;
		#endif // QUAKE

			self.waterlevel = self.watertype = self.frags = self.deadflag = self.arrow = self.button0_
			= self.jump_flag = self.effects = 0;

			self.color_ = other.color_;
			self.teamcolor = other.teamcolor;
			self.bot_skill = other.bot_skill;

			CopyName(self, other);
			CopyName(other, platform);	// NULL

		#ifdef QUAKEWORLD
			CopyQWSkin(self, other);
		#endif // QUAKEWORLD

			scoreboardsize = scoreboardsize + 1;

			if (!self.block0)
			{
				do
				{
					SpawnHardBot();
				} while (BotExists());
			}

			if (other.flags & FL_PLAYER)
				SaveFrogbot();

			if (teamplay)
				self.color_ = self.teamcolor;

			self.team = (self.color_ & 15) + 1;

			UpdateFrags (self);

			SetColorName(MSG_ALL, self);
			ClientConnect_apply();
			SetAttribs();
			PutClientInServer();
			self.oldorigin = self.origin;

			self = other;
		}
	}
};

/*
============
AddBots

============
*/
void() AddBots =
{
	min_second = maxplayers - scoreboardsize + 1;
	if (impulse_ > min_second)
		impulse_ = min_second;

	while (impulse_ > 0)
	{
		impulse_ = impulse_ - 1;
		AddBot();
	}
};

/*
============
ClearSpawnBits

============
*/
void() ClearSpawnBits =
{
	test_enemy = find(world, classname, "player");
	while (test_enemy)
	{
		test_enemy.spawnbit0 = test_enemy.spawnbit1 = test_enemy.number_spawnbits = 0;
		test_enemy = find(test_enemy, classname, "player");
	}
};

/*
============
RemoveBot

============
*/
float(float remove_name) RemoveBot =
{
	if (numberofbots)
	{
		if (load_frogbots)
			return 0;
		if (time >= frogbot_removetime)
		{
			frogbot_removetime = time + 0.1;

			ClearSpawnBits();

			removebot_self = self;
			self = frogbot_spawned;

			scoreboardsize = scoreboardsize - 1;

			if (self.client_)
				ClientDisconnect();
			self.nextthink = 0;
			self.touch = platform.touch;
			if (remove_name)
				ClearName(MSG_ALL, self);
			self.modelindex = 0;

			localsave(numberofbots, 1, 1);
			numberofbots = numberofbots - 1;
			frogbot_spawned = nextent(frogbot_spawned);

			self = removebot_self;
		}
	}
	return numberofbots;
};

void() AutoRemoveBot =
{
	if (RemoveBot(TRUE))
		self.nextthink = time + 0.1;
	else
		remove();
};

void() RemoveAllBots =
{
	test_enemy = spawn();
	test_enemy.think = AutoRemoveBot;
	test_enemy.nextthink = 0.001;
};

/*
============
BecomeBot

============
*/
void() BecomeBot =
{
#ifdef QUAKE
	if (invalid_map)
	{
		InvalidMap();
	}
	else
	{
		if (markers_loaded)
		{
			if (game_show_rules)
			{
				msg_level = PRINT_HIGH;
				bprint(self.netname);
				bprint(" has become a frogbot\n");
			}
			else
			{
				if (!self.client_)
				{
					msg_level = PRINT_HIGH;
					bprint(self.netname);
					bprint(" is playing\n");
				}
			}

			if (!self.client_)
				PrepareToClient();

			self.flags = self.flags | FL_FROGBOT;

			SetAttribs();

			if (self.deadflag == DEAD_NO)
			{
				if (self.v_angle_x < 0)
					self.angles_x = self.v_angle_x - 2.8125;	// crosshair
				else
					self.angles_x = self.v_angle_x;
				self.angles_z = 0;

				self.real_pitch = self.angles_x;
				self.real_yaw = self.angles_y;

				self.state = 0;
				self.path_state = 0;
			}
		}
	}
#endif // QUAKE

#ifdef QUAKEWORLD
	not_supported();
#endif // QUAKEWORLD
};

/*
============
BecomePlayer

============
*/
void() BecomePlayer =
{
	if (self.netname != "")
	{
		if ((game_show_rules) || (!self.client_))
		{
			msg_level = PRINT_HIGH;
			bprint(self.netname);
			bprint(" is playing\n");
		}

		if (self.client_)
			self.flags = self.flags - FL_FROGBOT;
		else
			PrepareToClient();

		self.lookahead_time = 30;
		self.prediction_error = 0;

		self.arrow = self.button0_ = self.linked_marker_time = 0;

		self.look_object = self.linked_marker = self.old_linked_marker = self.enemy = world;
	}
};

/*
============
ToggleFrogbot

============
*/
void() ToggleFrogbot =
{
	if (self.flags & FL_FROGBOT)
		BecomePlayer();
	else
		BecomeBot();
};

/*
============
ToggleKascam

============
*/
#ifdef QUAKE
void() ToggleKascam =
{
	if (self.flags & FL_KASCAM)
		BecomePlayer();
	else
		CamClientInit();
};
#endif // QUAKE

/*
============
ToggleFlash

============
*/
void() ToggleFlash =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;

	if (self.preferences & PREF_FLASH)
	{
		sprint("flashs off\n");
		self.preferences = self.preferences - PREF_FLASH;
	}
	else
	{
		sprint("flashs on\n");
		self.preferences = self.preferences | PREF_FLASH;
	}
};

/*
============
ToggleFramerate

============
*/
void() ToggleFramerate =
{
	if (self.print_framerate)
		self.print_framerate = FALSE;
	else
		self.print_framerate = TRUE;
};

/*
============
ToggleGameMode

============
*/
void(float value, string s) ToggleGameMode =
{
	new_gamemode = cvar("samelevel");

	msg_level = PRINT_HIGH;
	if (new_gamemode & value)
	{
		new_gamemode = new_gamemode - value;
		bprint(s);
		bprint(" disabled next level\n");
	}
	else
	{
		new_gamemode = new_gamemode | value;
		bprint(s);
		bprint(" enabled next level\n");
	}

	cvar_set_("samelevel", new_gamemode);
};

/*
============
ToggleGameModeNow

============
*/
void(float value, string s) ToggleGameModeNow =
{
	new_gamemode = cvar("samelevel");

	msg_level = PRINT_HIGH;
	if (gamemode & value)
	{
		gamemode = gamemode - value;
		new_gamemode = new_gamemode - (new_gamemode & value);
		bprint(s);
		bprint(" disabled\n");
	}
	else
	{
		gamemode = gamemode | value;
		new_gamemode = new_gamemode | value;
		bprint(s);
		bprint(" enabled\n");
	}

	cvar_set_("samelevel", new_gamemode);
	SetGame();
};

/*
============
print_boolean

============
*/
void(float value, string s) print_boolean =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;
	sprint(s);
	if (gamemode & value)
		sprint("enabled\n");
	else
		sprint("disabled\n");
};

/*
============
PrintRules

============
*/
void() PrintRules =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;
	sprint("deathmatch  ");
	sprint_(deathmatch);
	sprint("\nteamplay    ");
	sprint_(teamplay);
	sprint("\n");
	print_boolean(GAME_ENABLE_POWERUPS, "powerup     ");
	print_boolean(GAME_ENABLE_RUNES, "rune        ");
	print_boolean(GAME_RUNE_RJ, "rune_rj     ");
	print_boolean(GAME_ENABLE_HOOK, "hook        ");
//	print_boolean(GAME_ENABLE_CTF, "ctf         ");
	print_boolean(GAME_CAPTURE_CUSTOM, "custom      ");
	print_boolean(GAME_MATCH, "match       ");
	print_boolean(GAME_RL_PREF, "rl_pref     ");
	print_boolean(GAME_LAVA_CHEAT, "lavacheat   ");
	print_boolean(GAME_LOOK_CHEAT, "lookcheat   ");
	print_boolean(GAME_HIDE_RULES, "hide        ");
#ifdef QUAKE
	print_boolean(GAME_NOSKINS, "noskins     ");
	print_boolean(GAME_QWPHYSICS, "qwphysics   ");
	print_boolean(GAME_QWAIM, "qwaim       ");
	print_boolean(GAME_SKINFIX, "skinfix     ");
#endif // QUAKE
	sprint("\n");

	if (sv_accelerate != 10)
	{
		sprint("\"sv_accelerate\" is \"");
		sprint_ftos(sv_accelerate);
		sprint("\"\n");
	}
	if (sv_friction != 4)
	{
		sprint("\"sv_friction\" is \"");
		sprint_ftos(sv_friction);
		sprint("\"\n");
	}

#ifdef QUAKE
	if (host_framerate)
	{
		sprint("\"host_framerate\" is \"");
		sprint_ftos(host_framerate * 1000000);
		sprint("/1000000\"\n");
	}
#endif // QUAKE
};

/*
============
PrintFramerate

============
*/
void() PrintFramerate =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;
	sprint_(1/real_frametime);
	sprint(" ");
	sprint_(1/average_frametime);
	sprint(" ");
	sprint_((framecount - framecount_start) / (time - time_start));
	sprint("\n");
};

/*
============
PrintTime

============
*/
void() PrintTime =
{
	if (pre_game)
		return;

	msg_entity = self;
	msg_level = PRINT_HIGH;

	time_to_print = time - start_time;
	sprint("Time : ");
	minutes = floor (time_to_print / 60);
	if (minutes < 10)
		sprint(" ");		// add extra space in minutes
	sprint_ftos(minutes);		// minutes
	sprint(":");
	seconds = floor (time_to_print - (minutes * 60));
	if (seconds < 10)
		sprint("0");		// add extra 0 in seconds
	sprint_ftos(seconds);		// seconds
	sprint("\n");
};

/*
============
SetSkin

============
*/
#ifdef QUAKE
void() SetSkin =
{
	if (game_skins)
		self.skin = self.spawn_skin;
};
#endif // QUAKE

/*
============
AddBotError

============
*/
void() AddBotError =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;
	sprint("addbot error - don't panic\n");
	self.spawnflags = self.impulse = self.lines = 0;
	self.input_time = time + 2;

	self.spawnbit0 = self.spawnbit1 = self.number_spawnbits = 0;
	CopyName(self, platform);	// NULL

#ifdef QUAKEWORLD
	CopyQWSkin(self, platform);	// NULL
#endif // QUAKEWORLD
};

/*
============
NoAdmin

============
*/
void() NoAdmin =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;
	sprint("You don't have admin privileges\n");
};

/*
============
SetImpulses

============
*/
void(string s, float value) alias =
{
	stuffcmd("alias ");
	stuffcmd(s);
	stuffcmd(" impulse ");
	stuffcmd_ftos(value);
	stuffcmd("\n");
};

void() SetImpulses1 =
{
	msg_entity = self;

	alias("use_hook", 9);
//---------------------------
	alias("skill=", IMP_SKILL);		// command value, during loading
	alias("skin=", IMP_SKIN);
	alias("shirt=", IMP_SHIRT);
	alias("pants=", IMP_PANTS);
	alias("teamshirt=", IMP_TEAMSHIRT);
	alias("teampants=", IMP_TEAMPANTS);
//---------------------------
	alias("name=", IMP_NAME);		// sequence, during loading
	alias("qwskin=", IMP_QWSKIN);
//---------------------------
	alias("setname", IMP_SETNAME);	// end of loading
	alias("lines=", IMP_LINES);
//---------------------------
	alias("addbot", IMP_ADDBOT);		// requires admin, end of loading
	alias("add2bots", IMP_ADD2BOTS);
	alias("add3bots", IMP_ADD3BOTS);
	alias("add4bots", IMP_ADD4BOTS);
	alias("addbot0", IMP_ADDBOT0);
	alias("addbot1", IMP_ADDBOT1);
	alias("addbot2", IMP_ADDBOT2);
	alias("addbot3", IMP_ADDBOT3);
	alias("addbot4", IMP_ADDBOT4);
	alias("addbot5", IMP_ADDBOT5);
	alias("addbot6", IMP_ADDBOT6);
	alias("addbot7", IMP_ADDBOT7);
	alias("addbot8", IMP_ADDBOT8);
	alias("addbot9", IMP_ADDBOT9);
	alias("addbot10", IMP_ADDBOT10);
	alias("addbot11", IMP_ADDBOT11);
	alias("addbot12", IMP_ADDBOT12);
	alias("addbot13", IMP_ADDBOT13);
//---------------------------
	alias("msg=", IMP_MSG);			// command value, not in loading
	alias("bots=", IMP_BOTS);
//---------------------------
	alias("admin=", IMP_ADMIN);
//---------------------------
	alias("kascam", IMP_KASCAM);		// not in loading
	alias("lettercodes", IMP_LETTERCODES);
	alias("time", IMP_TIME);
	alias("rules", IMP_RULES);
	alias("setskin", IMP_SETSKIN);
	alias("noflash", IMP_FLASH);
//---------------------------
};

void() SetImpulses2 =
{
	msg_entity = self;

//---------------------------
	alias("teamplay=", IMP_TEAMPLAY);	// requires admin, command value
	alias("deathmatch=", IMP_DEATHMATCH);
	alias("timelimit=", IMP_TIMELIMIT);
	alias("fraglimit=", IMP_FRAGLIMIT);
//---------------------------
	alias("hide", IMP_HIDE);		// requires admin, not in loading
	alias("removebot", IMP_REMOVEBOT);
	alias("removeallbots", IMP_REMOVEALLBOTS);
	alias("frogbot", IMP_FROGBOT);
	alias("lavacheat", IMP_LAVACHEAT);
	alias("lookcheat", IMP_LOOKCHEAT);
	alias("framerate", IMP_FRAMERATE);
	alias("powerup", IMP_POWERUP);
	alias("rune", IMP_RUNE);
	alias("hook", IMP_HOOK);
	alias("ctf", IMP_CTF);
	alias("custom", IMP_CUSTOM);
	alias("ready", IMP_READY);
	alias("match", IMP_MATCH);
	alias("rl_pref", IMP_RL_PREF);
	alias("rune_rj", IMP_RUNE_RJ);
	alias("qwphysics", IMP_QWPHYSICS);
#ifdef QUAKE
	alias("noskins", IMP_NOSKINS);
#endif // QUAKE
	alias("qwaim", IMP_QWAIM);
	alias("skinfix", IMP_SKINFIX);
	alias("map_dm4", IMP_MAP_DM4);
	alias("map_dm6", IMP_MAP_DM6);
	alias("map_ztndm3", IMP_MAP_ZTNDM3);
//---------------------------
// misc impulses
	alias("random", IMP_RANDOM);
	alias("impulse_0", IMP_IMPULSE_0);
//---------------------------
};

/*
============
ImpulseCommands

============
*/
void() ImpulseCommands =
{
	if (self.impulse)
	{
		if (intermission_running)
			return;

		if (time >= self.input_time)
		{
			if (self.lines)
			{
				self.lines = self.lines - 1;
				if (self.lines < 2)
				{
					AddBotError();
					return;
				}
			}

			impulse_ = self.impulse;

			if (self.spawnflags)
			{
				self.impulse = 0;
				MakeFrogbot();
			}
			else if (impulse_ < IMP_START1)
			{
				if (self.lines)
					AddBotError();
			}
			else
			{
				self.impulse = 0;

				if  (impulse_ > IMP_END4)
				{
					if (self.lines)
						AddBotError();

				#ifdef MANUAL
					if (impulse_ == 120)
						ToggleManualMode();
					if (manual_mode)
						ManualImpulseCommands();
				#endif // MANUAL
				}
				else if (impulse_ <= IMP_END2)
				{
					if (impulse_ <= IMP_END1)
						self.spawnflags = impulse_ - IMP_START1 + START_SKILL;
					else if (impulse_ == IMP_NAME)
					{
						self.spawnflags = START_NAME;
						CopyName(self, platform);
					}
					else if (impulse_ == IMP_QWSKIN)
					{
						self.spawnflags = START_QWSKIN;
					#ifdef QUAKEWORLD
						CopyQWSkin(self, platform);
					#endif // QUAKEWORLD
					}
					else
					{
						if (self.lines)
						{
							if (self.lines != 2)
							{
								AddBotError();
								return;
							}
							self.lines = 0;
						}
						if (impulse_ == IMP_SETNAME)
							SetName();
						else if (impulse_ == IMP_LINES)
							self.spawnflags = START_LINES;
						else if (self.admin_code != dropper.admin_code)
							NoAdmin();
						else if (impulse_ <= IMP_ADD4BOTS)
						{
							impulse_ = impulse_ - IMP_ADDBOT + 1;
							AddBots();
						}
						else
						{
							self.teamcolor = (impulse_ - IMP_ADDBOT0) * 17;
							AddBot();
						}
					}
				}
				else if (self.lines)
				{
					AddBotError();
				}
				else if (impulse_ == IMP_MSG)
					self.spawnflags = START_MSG;
				else if (impulse_ == IMP_BOTS)
					self.spawnflags = START_BOTS;
				else if (impulse_ == IMP_ADMIN)
					self.spawnflags = START_ADMIN1;
				else if (impulse_ == IMP_KASCAM)
				{
				#ifdef QUAKE
					ToggleKascam ();
				#endif // QUAKE

				#ifdef QUAKEWORLD
					not_supported();
				#endif // QUAKEWORLD
				}
				else if (impulse_ == IMP_LETTERCODES)
					LetterCodes();
				else if (impulse_ == IMP_TIME)
					PrintTime();
				else if (impulse_ == IMP_RULES)
					PrintRules();
				else if (impulse_ == IMP_SETSKIN)
				{
				#ifdef QUAKE
					SetSkin();
				#endif // QUAKE

				#ifdef QUAKEWORLD
					not_supported();
				#endif // QUAKEWORLD
				}
				else if (impulse_ == IMP_FLASH)
				{
					ToggleFlash();
				}
				else if (self.admin_code != dropper.admin_code)
					NoAdmin();
				else if (impulse_ <= IMP_END3)
					self.spawnflags = impulse_ - IMP_START3 + START_TEAMPLAY;
				else if (impulse_ == IMP_HIDE)
					ToggleGameModeNow(GAME_HIDE_RULES, "hide");
				else if (impulse_ == IMP_REMOVEBOT)
					RemoveBot(TRUE);
				else if (impulse_ == IMP_REMOVEALLBOTS)
					RemoveAllBots();
				else if (impulse_ == IMP_FROGBOT)
					ToggleFrogbot();
				else if (impulse_ == IMP_LAVACHEAT)
					ToggleGameModeNow(GAME_LAVA_CHEAT, "lavacheat");
				else if (impulse_ == IMP_LOOKCHEAT)
					ToggleGameModeNow(GAME_LOOK_CHEAT, "lookcheat");
				else if (impulse_ == IMP_FRAMERATE)
					ToggleFramerate();
				else if (impulse_ == IMP_POWERUP)
					ToggleGameMode(GAME_ENABLE_POWERUPS, "powerup");
				else if (impulse_ == IMP_RUNE)
					ToggleGameMode(GAME_ENABLE_RUNES, "rune");
				else if (impulse_ == IMP_HOOK)
					ToggleGameMode(GAME_ENABLE_HOOK, "hook");
				else if (impulse_ == IMP_CTF)
				{
					msg_entity = self;
					msg_level = PRINT_HIGH;
					sprint("ctf is not supported in this version.\n");
				}
//				ToggleGameMode(GAME_ENABLE_CTF, "ctf");
				else if (impulse_ == IMP_CUSTOM)
					ToggleGameMode(GAME_CAPTURE_CUSTOM, "custom");
				else if (impulse_ == IMP_READY)
					ReadyTyped();
				else if (impulse_ == IMP_MATCH)
					ToggleGameMode(GAME_MATCH, "match");
				else if (impulse_ == IMP_RL_PREF)
					ToggleGameModeNow(GAME_RL_PREF, "rl_pref");
				else if (impulse_ == IMP_RUNE_RJ)
					ToggleGameModeNow(GAME_RUNE_RJ, "rune_rj");
				else if (impulse_ == IMP_QWPHYSICS)
				{
				#ifdef QUAKE
					ToggleGameMode(GAME_QWPHYSICS, "qwphysics");
				#endif // QUAKE

				#ifdef QUAKEWORLD
					not_supported();
				#endif // QUAKEWORLD
				}
				else if (impulse_ == IMP_NOSKINS)
				{
				#ifdef QUAKE
					ToggleGameMode(GAME_NOSKINS, "noskins");
				#endif // QUAKE

				#ifdef QUAKEWORLD
					not_supported();
				#endif // QUAKEWORLD
				}
				else if (impulse_ == IMP_QWAIM)
				{
				#ifdef QUAKE
					ToggleGameModeNow(GAME_QWAIM, "qwaim");
				#endif // QUAKE

				#ifdef QUAKEWORLD
					not_supported();
				#endif // QUAKEWORLD
				}
				else if (impulse_ == IMP_SKINFIX)
				{
				#ifdef QUAKE
					ToggleGameMode(GAME_SKINFIX, "skinfix");
				#endif // QUAKE

				#ifdef QUAKEWORLD
					not_supported();
				#endif // QUAKEWORLD
				}
				else
				{
					if (impulse_ == IMP_MAP_DM4)
						nextmap = "dm4";
					else if (impulse_ == IMP_MAP_DM6)
						nextmap = "dm6";
					else // (if (impulse_ == IMP_MAP_ZTNDM3))
						nextmap = "ztndm3";
					NextLevel();
				}
			}
		}
		else
		{
			self.impulse = 0;
			self.input_time = time + 2;
		}
	}
};
