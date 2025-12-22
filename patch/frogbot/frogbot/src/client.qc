// prototypes
void() W_SetCurrentAmmo;
void() player_run;
void(vector org, entity e) spawn_tfog;
void (vector org, entity death_owner) spawn_tdeath;
void(entity e) UpdateFrags;
void() SetScoreboard;
void() UpdateWeapons;
void() InvalidMap;
void() PrintRules;
float(float remove_name) RemoveBot;
void() RemoveAllBots;
void() ToggleFramerate;
void(float value, string str) ToggleGameMode;
void() RemoveFromAllLists;
void() Add_client;
void() ReadyTyped;
void() thud_touch;
void() ImpulseCommands;
void() SetAttribs;
void() PrintFramerate;
void() marker_touch;
void() PlayerDie;
entity(entity first_in_list) RemoveFromList;
void() LoadPlayer;
void() PlayerPain;
void() SetImpulses1;
void() SetImpulses2;

#ifdef QUAKE
void() obstruction;
float(float v) FixedAngle;
entity(entity start_entity, float index_) EntityAt;
#endif // QUAKE

// CTF ->
void() UnHookPlayer;

#ifdef QUAKEWORLD
void () Service_Grapple;
#endif // QUAKEWORLD
// CTF <-

/*
=============================================================================

				LEVEL CHANGING / INTERMISSION

=============================================================================
*/

/*QUAKED info_intermission (1 0.5 0.5) (-16 -16 -16) (16 16 16)
This is the camera point for the intermission.
Use mangle instead of angle, so you can set pitch or roll as well as yaw.  'pitch roll yaw'
*/
void() info_intermission = {};

void() SetChangeParms =
{
	parm2 = self.number_bots;
	parm3 = self.bot_skill;
	parm4 = self.teamcolor;
	parm5 = self.color_;
	parm6 = self.admin_code;
	parm7 = self.spawnbit0;
	parm8 = self.spawnbit1;
#ifdef QUAKE
	parm1 = self.flags & FL_FROGBOT_PLAYER_KASCAM;
	parm9 = self.spawn_skin;
	parm10 = self.skin;
	parm11 = self.msg_level_;
#endif // QUAKE

#ifdef QUAKEWORLD
	parm1 = self.flags & FL_PLAYER;
	parm9 = self.skin0;
	parm10 = self.skin1;
	parm11 = self.skin2;
#endif // QUAKEWORLD

	parm12 = self.preferences;
};

void() SetNewParms =
{
	parm1 = FL_PLAYER;
	parm2 = -1;			// number_bots
	parm3 = skill;		// default skill
	parm4 = -1;			// initialise teamcolor later
	parm5 = -1;			// initialise color_ later
	parm6 = 0;
	parm7 = 0;			// spawnbit0
	parm8 = 0;			// spawnbit1
#ifdef QUAKE
	parm9 = 0;			// default skin 0
	parm10 = 0;			// default skin 0
	parm11 = 0;			// default msg 0
#endif // QUAKE

#ifdef QUAKEWORLD
	parm9 = 0;			// default skin ""
	parm10 = 0;			//
	parm11 = 0;			//
#endif // QUAKEWORLD

	parm12 = PREF_FLASH;			// default preferences PREF_FLASH
};

/*
============
ResetItems

============
*/
void() ResetItems =
{
	test_enemy = first_client;
	while (test_enemy)
	{
		if (test_enemy.enemy == self)	// test_enemy must be frogbot
		{
			test_enemy.enemy = world;
			if (test_enemy.look_object.client_)	
				test_enemy.look_object = world;
			if (test_enemy.goalentity == self)
				test_enemy.goal_refresh_time = 0;
		}
		test_enemy = test_enemy.next;
	}

	self.enemy = world;

// CTF ->
	DropRune();
	TeamCaptureDropFlagOfPlayer();
	UnHookPlayer();
// CTF <-

	lose_artifact_invulnerability();
	lose_artifact_envirosuit();
	lose_artifact_invisibility();
	lose_artifact_super_damage();
};

void() NewItems =
{
	if (pre_game)
	{
		self.invincible_time = 1;
		self.ammo_nails = self.ammo_shells = self.ammo_rockets = self.ammo_cells = 255;
		self.armorvalue = self.armortype = 0;
		self.items = available_weapons;
		self.invincible_finished = 1000000;
		self.health = 999;
	}
	else if (deathmatch <= 3)
	{
		self.items = IT_AXE_SHOTGUN;
		self.armorvalue = self.ammo_nails = self.ammo_rockets = self.ammo_cells = self.armortype = 0;
		self.ammo_shells = 25;
		self.health = 100;
	}
	else
	{
		self.invincible_time = 1;
		self.armorvalue = 200;
		self.armortype = 0.8;

		self.items = available_weapons | IT_ARMOR3_INVULNERABILITY;
		self.invincible_finished = time + 3;

	#ifdef QUAKE
		self.effects = self.aiment.effects = self.effects | EF_DIMLIGHT;
	#endif // QUAKE

	#ifdef QUAKEWORLD
		self.effects = self.effects | EF_DIMLIGHT_RED;
	#endif // QUAKEWORLD

		if (deathmatch == 4)
		{
			self.ammo_nails = self.ammo_shells = self.ammo_rockets = self.ammo_cells = 255;
			self.health = 250;
		}
		else if (deathmatch == 5)
		{
			self.ammo_nails = 80;
			self.ammo_shells = 30;
			self.ammo_rockets = 10;
			self.ammo_cells = 30;
			self.health = 200;
		}
		else // (if deathmatch == 6)
		{
			self.ammo_nails = 200;
			self.ammo_shells = 100;
			self.ammo_rockets = 30;
			self.ammo_cells = 50;
			self.health = 100;
		}
	}

// CTF ->
	if (game_enable_hook)
		self.items = self.items | IT_HOOK;
// CTF <-

	UpdateTotalDamage(self);
	UpdateWeapons();
};

/*
============
FindIntermission

Returns the entity to view from
============
*/
void() FindIntermission =
{
// look for info_intermission first
	spawn_pos = find (world, classname, "info_intermission");
	// pick a random one
	rnd = random() * 4;
	while (rnd > 1)
	{
		spawn_pos = find (spawn_pos, classname, "info_intermission");
		if (!spawn_pos)
			spawn_pos = find (spawn_pos, classname, "info_intermission");
		rnd = rnd - 1;
	}
};

#ifdef QUAKE
void() GotoNextMap =
{
	changelevel (nextmap);
};
#endif // QUAKE

#ifdef QUAKEWORLD
void() GotoNextMap =
{
	local string newmap;

	// configurable map lists, see if the current map exists as a
	// serverinfo/localinfo var
	newmap = infokey(world, mapname);
	if (newmap != "")
		changelevel (newmap);
	else
		changelevel (nextmap);
};
#endif // QUAKEWORLD

/*
============
IntermissionThink

When the player presses attack or jump, change to the next level
============
*/
void() IntermissionThink =
{
	if (time < intermission_exittime)
		return;

	if (!self.button0 && !self.button1 && !self.button2)
		return;
	
	GotoNextMap();
};

void() execute_changelevel =
{
	intermission_running = 1;
	remove_apply(postphysics);
	
// enforce a wait time before allowing changelevel
	intermission_exittime = time + 5;

	WriteByte (MSG_ALL, SVC_CDTRACK);
	WriteByte (MSG_ALL, 3);

#ifdef QUAKE
	WriteByte (MSG_ALL, 3);
#endif // QUAKE

	FindIntermission ();

	other = first_client;
	while (other)
	{
		other.takedamage = other.solid = other.movetype = 0;
	#ifdef QUAKE
		other.modelindex = other.aiment.modelindex = 0;
	#endif // QUAKE

	#ifdef QUAKEWORLD
		other.modelindex = 0;
	#endif // QUAKEWORLD

		other.view_ofs_z = 0;
		other = other.next;
	}

#ifdef QUAKE
	other = find(world, classname, "player");
	while (other)
	{
		other.takedamage = other.solid = other.movetype = other.modelindex = 0;
		other.aiment.modelindex = 0;
		other.view_ofs_z = 0;
		other.angles = other.v_angle = spawn_pos.mangle;
		other.fixangle = TRUE;		// turn this way immediately
		other.nextthink = 0;
		setorigin (other, spawn_pos.origin);
		other = find(other, classname, "player");
	}
#endif // QUAKE


	WriteByte (MSG_ALL, SVC_INTERMISSION);

#ifdef QUAKEWORLD
	WriteCoord (MSG_ALL, spawn_pos.origin_x);
	WriteCoord (MSG_ALL, spawn_pos.origin_y);
	WriteCoord (MSG_ALL, spawn_pos.origin_z);
	WriteAngle (MSG_ALL, spawn_pos.mangle_x);
	WriteAngle (MSG_ALL, spawn_pos.mangle_y);
	WriteAngle (MSG_ALL, spawn_pos.mangle_z);
#endif // QUAKEWORLD
};

/*QUAKED trigger_changelevel (0.5 0.5 0.5) ? NO_INTERMISSION
When the player touches this, he gets sent to the map listed in the "map" variable.  Unless the NO_INTERMISSION flag is set, the view will go to the info_intermission spot and display stats.
*/
void() check_trigger =
{
	SUB_DelayRemove();
	targ_centre = (self.absmin + self.absmax) * 0.5;
	self = first_teleport;
	while (self)
	{
		if (vlen(targ_centre - (self.absmin + self.absmax) * 0.5) <= 128)
		{
			first_teleport = RemoveFromList(first_teleport);
			SUB_DelayRemove();
		}
		self = self.next;
	}
};

void() trigger_changelevel =
{
// put on save que
	AddToQue();

	InitTrigger ();
	self.nextthink = time + 0.1;
	self.think = check_trigger;
};


/*
=============================================================================

				PLAYER GAME EDGE FUNCTIONS

=============================================================================
*/

void() set_suicide_frame;

// called by ClientKill and PlayerDeathThink
void() respawn =
{
	// make a copy of the dead body for appearances sake
	CopyToBodyQue ();
	// respawn		
	PutClientInServer ();
};


/*
============
ClientKill

Player entered the suicide command
============
*/
void() ClientKill =
{
	if (self.client_)
	{
		msg_level = PRINT_MEDIUM;
		bprint_netname (self);
		bprint (" suicides\n");
		ResetItems ();
		set_suicide_frame ();
		self.frags = self.frags - 2;	// extra penalty
		UpdateFrags (self);
		respawn ();
	}
};

/*
============
ForceGib

============
*/
void() ForceGib =
{
	if (self.takedamage)
	{
		lose_artifact_invulnerability();

		inflictor = attacker = world;
		targ = self;
		damage = 50000;
		deathtype = "forcegib";
		T_Damage ();
	}

	self.frags = 0;
	UpdateFrags (self);
};

/*
============
ChangeTeam

============
*/
void() ChangeTeam =
{
	if (self.client_)
	{
		ForceGib();

		msg_level = PRINT_HIGH;
		bprint_netname (self);
		bprint (" changed team\n");
	}
};

/*
============
PrepareToObserve

============
*/
void() PrepareToObserve =
{
	RemoveFromAllLists();
	ResetItems();

	if (!self.modelindex)
	{
		msg_entity = self;
		WriteByte(MSG_ONE, SVC_SETVIEWPORT);
		WriteEntity(MSG_ONE, self);
	}

	self.modelindex = modelindex_player;
	self.weaponmodel = self.model = "";
	self.takedamage = self.deadflag = self.solid = self.nextthink = 0;
	self.frags = -99;
	setorigin(self, self.origin + self.view_ofs);
	self.velocity = '0 0 0';
	self.view_ofs_z = 0;
};

/*
============
PrepareToClient

============
*/
void() PrepareToClient =
{
	self.movetarget = world;	// clear shot rocket
	RemoveFromAllLists();
	Add_client();
	self.frags = 0;
	PutClientInServer();
};

/*
============
SelectSpawnPoint

Returns the entity to spawn at
============
*/
void() SelectSpawnPoint =
{
	spots = world;

// choose a info_player_deathmatch point
// ok, find all spots that don't have players nearby

	spawn_pos = find (world, classname, "info_player_deathmatch");       
	while (spawn_pos)
	{
		if (spawn_pos != previous_spot)
		{
			pcount = FALSE;
			totalspots = totalspots + 1;

			thing = first_client;
			while (thing)
			{
				if (thing.takedamage)
					if (vlen(thing.origin - spawn_pos.origin) <= 84)
						pcount = TRUE;
				thing = thing.next;      
			}
			if (!pcount)
			{
				spawn_pos.goalentity = spots;
				spots = spawn_pos;
				numspots = numspots + 1;
			}
		}
		// Get the next spot in the chain
		spawn_pos = find (spawn_pos, classname, "info_player_deathmatch");                
	}

	if (numspots)
	{
		numspots = floor(random() * numspots);

		spawn_pos = spots;
		while (numspots > 0) {
			spawn_pos = spawn_pos.goalentity;
			numspots = numspots - 1;
		}
	}
	else
	{
		// ack, they are all full, just pick one at random
		totalspots = random() * totalspots;
		totalspots = floor(totalspots);
		spawn_pos = find (world, classname, "info_player_deathmatch");       
		while (totalspots) {
			if (spawn_pos != previous_spot)
				totalspots = totalspots - 1;
			spawn_pos = find (spawn_pos, classname, "info_player_deathmatch");
		}
	}
};

/*
===========
PutClientInServer

called each time a player is spawned
============
*/
void() PutClientInServer =
{
	SelectSpawnPoint ();
	previous_spot = spawn_pos;

	self.origin = spawn_pos.origin + '0 0 1';
	self.angles = spawn_pos.angles;

#ifdef QUAKE
	self.model = self.aiment.model = "/";
	self.effects = self.aiment.effects = 0;
#endif // QUAKE

#ifdef QUAKEWORLD
	self.modelindex = modelindex_player;
	self.effects = 0;

	if (game_qizmo)
	{
		if (self.flags & FL_PLAYER)
			self.model = "/";
	}
	else
		self.model = "/";
#endif // QUAKEWORLD

	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);

	setorigin(self, self.origin);
	self.oldorigin = self.origin;

#ifdef QUAKE
	self.flags = self.flags & FL_CLIENT_FROGBOT_PLAYER_KASCAM_QWPHYSICS;
#endif // QUAKE

#ifdef QUAKEWORLD
	self.flags = self.flags & FL_CLIENT_FROGBOT_PLAYER;
#endif // QUAKEWORLD

	if (self.flags & FL_PLAYER)
	{
	#ifdef QUAKE
		self.modelindex = modelindex_player;
		self.aiment.modelindex = 0;

		if ((self.netname == "") || (self.flags & FL_KASCAM))
		{
			self.flags = self.flags - (self.flags & FL_KASCAM);
			CamClientInit();
			return;
		}
	#endif // QUAKE

		self.movetype = MOVETYPE_WALK;
		self.fixangle = TRUE;		// turn this way immediately
	}
	else
	{
	#ifdef QUAKE
		self.aiment.modelindex = modelindex_player;
		self.modelindex = 0;
	#endif // QUAKE

		self.movetype = MOVETYPE_STEP;
		self.touch = thud_touch;

		self.oldwaterlevel = self.oldwatertype = 0;
	}

	if (self.flags & FL_FROGBOT)
	{
	// self.angles holds crosshair position
		self.real_pitch = self.angles_x;
		self.real_yaw = self.angles_y;
	}

	self.state = 0;
	self.takedamage = DAMAGE_AIM;
	self.solid = SOLID_SLIDEBOX;
	self.air_finished = time_12;
	self.dmg = 2;   		// initial water damage

	self.weapon = IT_SHOTGUN;

	NewItems();

	W_SetCurrentAmmo ();

	self.th_die = PlayerDie;
	self.th_pain = PlayerPain;
	self.attack_finished = 0;
	self.touch_distance = 0;
	self.touch_marker = spawn_pos;
	self.Z_ = spawn_pos.Z_;
	self.touch_marker_time = time + 5;

	self.view_ofs_z = 22;

	self.oldvelocity = self.velocity = '0 0 0';

	self.deadflag = DEAD_NO;

	self.jump_flag = 0;

	makevectors(self.angles);
	spawn_tfog (self.origin + (v_forward * 20), self);

	spawn_tdeath (self.origin, self);
};


/*
=============================================================================

				QUAKED FUNCTIONS

=============================================================================
*/


/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 24)
The normal starting point for a level.
*/
void() info_player_start =
{
	remove();
};


/*QUAKED info_player_start2 (1 0 0) (-16 -16 -24) (16 16 24)
Only used on start map for the return point from an episode.
*/
void() info_player_start2 =
{
	remove();
};

/*
saved out by quaked in region mode
*/
void() testplayerstart = {remove();};

/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for deathmatch games
*/
void() info_player_deathmatch =
{
// put on save que
	AddToQue();

	self.solid = SOLID_TRIGGER;
	self.touch = marker_touch;
	setsize (self, '-80 -80 -24', '80 80 32');

	self.view_ofs = '81 81 25';
	self.flags = FL_MARKER;

// CTF ->
	if (game_enable_runes)
	{
		precache_model ("progs/end1.mdl");
		precache_model ("progs/end2.mdl");
		precache_model ("progs/end3.mdl");
		precache_model ("progs/end4.mdl");

		if (game_capture_custom)
		{
			precache_sound("rune/rune1.wav");
			precache_sound("rune/rune2.wav");
			precache_sound("rune/rune22.wav"); // special rune and quad combo
			precache_sound("rune/rune3.wav");
			precache_sound("rune/rune4.wav");
		}
		else
		{
			precache_sound("boss1/sight1.wav");
			precache_sound("items/r_item1.wav");
			precache_sound("items/damage3.wav");
			precache_sound("items/protect3.wav");
		}
	}
// CTF <-
};

/*QUAKED info_player_coop (1 0 1) (-16 -16 -24) (16 16 24)
potential spawning position for coop games
*/
void() info_player_coop = {remove();};

/*
===============================================================================

RULES

===============================================================================
*/

/*
go to the next level for deathmatch
only called if a time or frag limit has expired
*/
void() NextLevel =
{
	if (gameover)	// someone else quit the game already
		return;

	think_ent = spawn();
	gameover = TRUE;
	
	think_ent.think = execute_changelevel;
	think_ent.nextthink = 0.001;
};

//============================================================================

void() PlayerDeathThink =
{
	if ((self.flags & FL_ONGROUND))
	{
		forward = vlen (self.velocity) - 20;
		if (forward <= 0)
			self.velocity = '0 0 0';
		else	
			self.velocity = forward * normalize(self.velocity);
	}

// wait for all buttons released
	if (self.deadflag == DEAD_DEAD)
	{
		if (self.button2 || self.button1 || self.button0)
			return;
		self.deadflag = DEAD_RESPAWNABLE;
	}
	else
	{
	// wait for any button down
		if (self.button2 || self.button1 || self.button0)
		{
			self.button0 = 0;
			self.button1 = 0;
			self.button2 = 0;
			respawn();
		}
	}
};

/*
================
PlayerPreThink

Called every frame before physics are run
================
*/
void() PlayerPreThink_apply =
{
//
// WaterMove
//

	if (self.waterlevel)
	{
		if (self.waterlevel != 3)
		{
			if (self.air_finished < time + 9)
			{
				msg_entity = self;
				if (self.air_finished < time)
					sound (CHAN_VOICE, "player/gasp2.wav", 1, ATTN_NORM);
				else
					sound (CHAN_VOICE, "player/gasp1.wav", 1, ATTN_NORM);
			}
			self.air_finished = time_12;
			self.dmg = 2;

		#ifdef QUAKEWORLD
			if (!(self.flags & FL_PLAYER))
		#endif // QUAKEWORLD
			if (self.waterlevel == 2)
			{
			//
			// CheckWaterJump
			//

			// check for a jump-out-of-water
				makevectors (self.v_angle);
				start = self.origin;
				start_z = start_z + 8; 
				v_forward_z = 0;
				v_forward = normalize(v_forward) * 24;
				end = start + v_forward;
				traceline (start, end, TRUE, self);
				if (trace_fraction < 1)
				{	// solid at waist
					start_z = self.origin_z + self.maxs_z;
					end = start + v_forward;
					self.movedir = trace_plane_normal * -50;
					traceline (start, end, TRUE, self);
					if (trace_fraction == 1)
					{	// open at eye level
						self.flags = (self.flags | FL_WATERJUMP) & FL_NOT_JUMPRELEASED;
						self.velocity_z = 225;
						self.teleport_time = time + 2;	// safety net
					}
				}
			}
		}
		else if (self.air_finished < time)
		{	// drown!
			if (self.pain_finished < time)
			{
				self.pain_finished = time + 1;
				self.dmg = self.dmg + 2;
				if (self.dmg > 15)
					self.dmg = 10;
				deathtype = "";
				inflictor = world;
				attacker = world;
				targ = self;
				damage = self.dmg;
				T_Damage ();
				if (self.deadflag)
					return;
			}
		}

		if (self.dmgtime < time)
		{
			if (self.watertype == CONTENT_LAVA)
			{	// do damage
				if (self.radsuit_finished <= time)
					self.dmgtime = time + 0.2;
				else
					self.dmgtime = time + 1;

				deathtype = "";
				inflictor = world;
				attacker = world;
				targ = self;
				damage = 10 * self.waterlevel;
				T_Damage ();
				if (self.deadflag)
					return;
			}
			else if (self.watertype == CONTENT_SLIME)
			{	// do damage
				if (self.radsuit_finished <= time)
				{
					self.dmgtime = time + 1;
					deathtype = "";
					inflictor = world;
					attacker = world;
					targ = self;
					damage = 4 * self.waterlevel;
					T_Damage ();
					if (self.deadflag)
						return;
				}
			}
		}

		if (!(self.flags & FL_INWATER))
		{
		// player enter water sound
			msg_entity = self;
			if (self.watertype == CONTENT_WATER)
				sound (CHAN_BODY, "player/inh2o.wav", 1, ATTN_NORM);
			else if (self.watertype == CONTENT_LAVA)
				sound (CHAN_BODY, "player/inlava.wav", 1, ATTN_NORM);
			else if (self.watertype == CONTENT_SLIME)
				sound (CHAN_BODY, "player/slimbrn2.wav", 1, ATTN_NORM);

			self.flags = self.flags + FL_INWATER;
			self.dmgtime = 0;
		}

	#ifdef QUAKEWORLD
		if (!(self.flags & FL_PLAYER))
	#endif // QUAKEWORLD
			if (!(self.flags & FL_WATERJUMP))
				self.velocity = self.velocity - 0.8*self.waterlevel*real_frametime*self.velocity;
	}
	else
	{
		if (self.flags & FL_INWATER)
		{	
			// play leave water sound
			msg_entity = self;
			sound (CHAN_BODY, "misc/outwater.wav", 1, ATTN_NORM);
			self.flags = self.flags - FL_INWATER;
		}
		self.air_finished = time_12;
	}

	if (self.button2)
	{
	//
	// PlayerJump
	//
		if (!(self.flags & FL_WATERJUMP))
		{
			if (self.waterlevel >= 2)
			{
			#ifdef QUAKEWORLD
				if (!(self.flags & FL_PLAYER))
				{
			#endif // QUAKEWORLD
					if (self.watertype == CONTENT_WATER)
						self.velocity_z = 100;
					else if (self.watertype == CONTENT_SLIME)
						self.velocity_z = 80;
					else
						self.velocity_z = 50;
			#ifdef QUAKEWORLD
				}
			#endif // QUAKEWORLD

		// play swiming sound
				if (self.swim_flag < time)
				{
					self.swim_flag = time + 1;
					msg_entity = self;
					if (random() < 0.5)
						sound (CHAN_BODY, "misc/water1.wav", 1, ATTN_NORM);
					else
						sound (CHAN_BODY, "misc/water2.wav", 1, ATTN_NORM);
				}
			}
			else
			{
				if (self.flags & FL_ONGROUND)
				{
					if (self.flags & FL_JUMPRELEASED)		// don't pogo stick
					{
						self.flags = self.flags - FL_JUMPRELEASED;

					#ifdef QUAKEWORLD
						if (!(self.flags & FL_PLAYER))
					#endif // QUAKEWORLD
							self.flags = self.flags - FL_ONGROUND;	// don't stairwalk

						self.button2 = 0;
					// player jumping sound
						msg_entity = self;
						sound (CHAN_BODY, "player/plyrjmp8.wav", 1, ATTN_NORM);

					#ifdef QUAKEWORLD
						if (!(self.flags & FL_PLAYER))
					#endif // QUAKEWORLD
							self.velocity_z = self.velocity_z + JUMPSPEED;
					}
				}
			}
		}
	}
	else
		self.flags = self.flags | FL_JUMPRELEASED;

// CTF ->
// RUNE: If player has rune of elder magic (4), regeneration
	if (self.player_flag & ITEM_RUNE4_FLAG)
	{
		if (self.regen_time < time)
		{
			self.regen_time = time;
			if (self.health < 150)
			{
				self.health = self.health + 5;
				if (self.health > 150)
					self.health = 150;
				UpdateTotalDamage(self);
				self.regen_time = self.regen_time + 0.5;
				RegenerationSound();
			}
			if (self.armorvalue < 150)
			{
				if (self.armortype)
				{
					self.armorvalue = self.armorvalue + 5;
					if (self.armorvalue > 150)
						self.armorvalue = 150;
					UpdateTotalDamage(self);
					self.regen_time = self.regen_time + 0.5;
					RegenerationSound();
				}
			}
		}
	}
// RUNE
// CTF <-

#ifdef QUAKEWORLD
	// Do grapple stuff if I'm on a hook
	if (self.on_hook)
		Service_Grapple ();
#endif // QUAKEWORLD

	self.oldvelocity = self.velocity;

// clear touch marker
	self.touch_distance = 1000000;
};

void() PlayerPreThink =
{
	if (self.takedamage)
	{
		PlayerPreThink_apply();
		if (self.flags & FL_ONGROUND)
		{
			if (self.velocity_z < 0)
				self.oldvelocity_z = 0;
		}
		else
		{
			if (self.velocity_z < -300)
				self.jump_flag = self.velocity_z;
			else
				self.jump_flag = 0;
		}
	}
	else
	{
		if (intermission_running)
			IntermissionThink ();	// otherwise a button could be missed between the think tics
		else if (self.deadflag >= DEAD_DEAD)
			PlayerDeathThink ();
#ifdef QUAKE
		else if (self.flags & FL_KASCAM)
		{
			if (self.attack_state == CAM_NOCLIP)
				ObserverPreThink();
		}
#endif // QUAKE
	}
};

/*
================
PlayerPostThink

Called every frame after physics are run
================
*/
void() PlayerPostThink_apply =
{
// do weapon stuff

	if (time >= self.attack_finished)
	{
		if (!self.currentammo)
		{
			if (!(self.weapon & IT_AXE_HOOK))
			{
				self.weapon = W_BestWeapon ();
				W_SetCurrentAmmo ();
			}
		}

	// impulse commands
		if (self.impulse)
		{
			if (!self.spawnflags)
			{
				impulse_ = self.impulse;
				self.impulse = 0;
				if (impulse_ <= 12)
				{
					if (impulse_ <= 9)
						W_ChangeWeapon ();
					else if (impulse_ == 10)
						CycleWeaponCommand ();
					else if (impulse_ == 11)
					{
						ClientKill();
						return;
					}
					else // if (impulse_ == 12)
						CycleWeaponReverseCommand ();
				}
			}
		}
	
	// check for attack
		if (self.button0)
		{
			SuperDamageSound ();
			W_Attack ();
		}
	}

// check to see if player landed and play landing sound
	if (self.jump_flag)
	{
		if (self.flags & FL_ONGROUND)
		{
			msg_entity = self;
			if (self.watertype == CONTENT_WATER)
				sound (CHAN_BODY, "player/h2ojump.wav", 1, ATTN_NORM);
			else if (self.jump_flag < -650)
			{
				deathtype = "falling";
				inflictor = world;
				attacker = world;
				targ = self;
				damage = 5;
				T_Damage ();
				sound (CHAN_VOICE, "player/land2.wav", 1, ATTN_NORM);
				if (self.deadflag)
					return;
			}
			else
				sound (CHAN_VOICE, "player/land.wav", 1, ATTN_NORM);
			self.jump_flag = 0;
		}
	}


//
// CheckPowerups
//

	if (self.items & IT_POWERUP)
	{
	// invisibility
		if (self.invisible_finished)
		{
	// sound and screen flash when items starts to run out
			if (self.invisible_sound < time)
			{
				msg_entity = self;
				sound (CHAN_AUTO, "items/inv3.wav", 0.5, ATTN_IDLE);
				self.invisible_sound = time + ((random() * 3) + 1);
			}

			if (self.invisible_finished < time + 3)
			{
				if (self.invisible_time == 1)
				{
					msg_entity = self;
					msg_level = PRINT_HIGH;
					sprint ("Ring of Shadows magic is fading\n");
					stuffcmd("bf\n");
					sound (CHAN_AUTO, "items/inv2.wav", 1, ATTN_NORM);
					self.invisible_time = time + 1;
				}
				else if (self.invisible_time < time)
				{
					self.invisible_time = time + 1;
					msg_entity = self;
					stuffcmd("bf\n");
				}

				if (self.invisible_finished < time)		// just stopped
					lose_artifact_invisibility();
			}
		}

	// invincibility
		if (self.invincible_finished)
		{
	// sound and screen flash when items starts to run out
			if (self.invincible_finished < time + 3)
			{
				if (self.invincible_time == 1)
				{
					msg_entity = self;
					msg_level = PRINT_HIGH;
					sprint ("Protection is almost burned out\n");
					stuffcmd("bf\n");
					sound (CHAN_AUTO, "items/protect2.wav", 1, ATTN_NORM);
					self.invincible_time = time + 1;
				}
				else if (self.invincible_time < time)
				{
					self.invincible_time = time + 1;
					msg_entity = self;
					stuffcmd("bf\n");
				}

				if (self.invincible_finished < time)	// just stopped
					lose_artifact_invulnerability();
			}
		}

	// super damage
		if (self.super_damage_finished)
		{
	// sound and screen flash when items starts to run out
			if (self.super_damage_finished < time + 3)
			{
				if (self.super_time == 1)
				{
					msg_entity = self;
					msg_level = PRINT_HIGH;
					if (quad_factor == 8)
						sprint ("OctaPower is wearing off\n");
					else
						sprint ("Quad Damage is wearing off\n");
					stuffcmd("bf\n");
					sound (CHAN_AUTO, "items/damage2.wav", 1, ATTN_NORM);
					self.super_time = time + 1;
				}
				else if (self.super_time < time)
				{
					self.super_time = time + 1;
					msg_entity = self;
					stuffcmd("bf\n");
				}

				if (self.super_damage_finished < time)	// just stopped
					lose_artifact_super_damage();
			}
		}	

	// suit	
		if (self.radsuit_finished)
		{
			self.air_finished = time_12;		// don't drown

	// sound and screen flash when items starts to run out
			if (self.radsuit_finished < time + 3)
			{
				if (self.rad_time == 1)
				{
					msg_entity = self;
					msg_level = PRINT_HIGH;
					sprint ("Air supply in Biosuit expiring\n");
					stuffcmd("bf\n");
					sound (CHAN_AUTO, "items/suit2.wav", 1, ATTN_NORM);
					self.rad_time = time + 1;
				}
				else if (self.rad_time < time)
				{
					self.rad_time = time + 1;
					msg_entity = self;
					stuffcmd("bf\n");
				}

				if (self.radsuit_finished < time)	// just stopped
					lose_artifact_envirosuit();
			}
		}
	}

//
// end CheckPowerups
//


	if (self.flags & FL_FROGBOT)
	{
	// pitch
		pitchspeed_ = self.pitchspeed + self.pitchaccel * real_frametime;

		if (pitchspeed_ > 0)
		{
			pitchspeed_ = pitchspeed_ - mouse_friction;
			if (pitchspeed_ < 0)
				pitchspeed_ = 0;
		}
		else
		{
			pitchspeed_ = pitchspeed_ + mouse_friction;
			if (pitchspeed_ > 0)
				pitchspeed_ = 0;
		}
		total_pitchspeed = pitchspeed_ + self.track_pitchspeed - self.velocity * self.pitch_tangent;
		self.pitchspeed = pitchspeed_;

		if (total_pitchspeed > 450)
			total_pitchspeed = 450;
		else if (total_pitchspeed < -450)
			total_pitchspeed = -450;

		real_pitch_ = self.real_pitch + total_pitchspeed * real_frametime;

		if (real_pitch_ > 78.75)
			real_pitch_ = 78.75;
		else if (real_pitch_ < -71.71875)
			real_pitch_ = -71.71875;

		new_pitch = (rint(real_pitch_ / 1.40625)) * 1.40625;
		self.real_pitch = real_pitch_;

	// yaw
		yawspeed_ = self.yawspeed + self.yawaccel * real_frametime;

		if (yawspeed_ > 0)
		{
			yawspeed_ = yawspeed_ - mouse_friction;
			if (yawspeed_ < 0)
				yawspeed_ = 0;
		}
		else
		{
			yawspeed_ = yawspeed_ + mouse_friction;
			if (yawspeed_ > 0)
				yawspeed_ = 0;
		}
		total_yawspeed = yawspeed_ + self.track_yawspeed - self.velocity * self.yaw_tangent;
		if (fabs(total_yawspeed) > self.stop_turn_speed)
		{
			self.arrow = 0;
			self.arrow_time = time + real_frametime;
			if (total_yawspeed > 540)
				total_yawspeed = 540;
			else if (total_yawspeed < -540)
				total_yawspeed = -540;
		}
		self.yawspeed = yawspeed_;

		real_yaw_ = self.real_yaw + total_yawspeed * real_frametime;
		if (real_yaw_ >= 180)
			real_yaw_ = real_yaw_ - 360;
		else if (real_yaw_ < -180)
			real_yaw_ = real_yaw_ + 360;
		self.v_angle_y = self.angles_y = (rint(real_yaw_ / 1.40625)) * 1.40625;
		self.real_yaw = real_yaw_;

	// self.angles holds crosshair position
		if (new_pitch < 0)
		{
			if (new_pitch < -2.8125)
				new_pitch = new_pitch + 2.8125;	// crosshair
			else
				new_pitch = 0;
		}

		self.v_angle_x = new_pitch;

		#ifdef QUAKE
		if (self.flags & FL_PLAYER)
		{
			self.angles_z = 0;	// stop incorrect roll

			self.stored_angle = self.v_angle;	// used for frogbots

			self.angles_x = FixedAngle(new_pitch);
			self.angles_y = FixedAngle(self.v_angle_y);
			self.fixangle = TRUE;
		}
		else
		{
			self.angles_x = new_pitch / -3;
		}
		#endif // QUAKE

		#ifdef QUAKEWORLD
		self.angles_x = new_pitch / -3;
		#endif // QUAKEWORLD
	}
};

void() PlayerPostThink =
{
#ifdef QUAKE
	self.postvelocity = self.velocity;
#endif // QUAKE

	ImpulseCommands();	

	if (self.print_framerate)
		PrintFramerate();

	if (teamplay)
	{
	#ifdef QUAKEWORLD
		self.team = stof(infokey(self, "bottomcolor")) + 1;
	#endif // QUAKEWORLD

		if (self.realteam != self.team)
		{
			self.realteam = self.team;
			ChangeTeam();
			return;
		}
	}

	if (self.takedamage)
	{
	#ifdef QUAKE
		if (self.flags & FL_FROGBOT_QWPHYSICS)
			obstruction();
	#endif // QUAKE
		PlayerPostThink_apply();
	}
};

/*
===========
ClientConnect

called when a player connects to a server
============
*/
void() LoadPlayer_apply =
{
	self.nextthink = time + 0.1;
	if (self.wait == framecount)
		return;
	self.wait = framecount;
	other = self;
	self = self.owner;

	if ((other.state * SPAWN_SIZE) < maxplayers)
	{
		SetScoreboard();
	}
	else
	{
		if (other.state <= 100)
		{
			other.state = 100;
			if (game_show_rules)
			{
				msg_entity = self;
				msg_level = PRINT_HIGH;
				sprint("\nServer running Frogbot v");
				sprint_version();
				sprint(".\nThis mod was developed by Robert `Frog' Field.\n\n");

				PrintRules();

				if (invalid_map)
					InvalidMap();
			}
		}
		else if (other.state == 101)
			SetImpulses1();
		else
		{
			SetImpulses2();
			remove_apply(other);
			return;
		}
	}
	other.state = other.state + 1;
};

void() LoadPlayer =
{
	local entity print_entity;

	print_entity = spawn();
	print_entity.nextthink = 0.001;
	print_entity.think = LoadPlayer_apply;
	print_entity.owner = self;
	print_entity.wait = framecount;
	print_entity.enemy = first_frogbot;
};

float() goal_client =
{
	if (time < virtual_enemy.invisible_finished)
		enemy_desire = 0;	// can't see so how chase?
	else if (time < virtual_enemy.invincible_finished)
		enemy_desire = 0;	// invincible
	else if (enemy_ == look_object_)
		enemy_desire = ((self.total_damage + 100) * self.firepower - virtual_enemy.total_damage * virtual_enemy.firepower) * 0.01;
	else
		enemy_desire = (self.total_damage * self.firepower - virtual_enemy.total_damage * virtual_enemy.firepower) * 0.01;
};

float() goal_client6 =
{
	if (time < virtual_enemy.invisible_finished)
		enemy_desire = 0;	// can't see so how chase?
	else if (time < virtual_enemy.invincible_finished)
		enemy_desire = 0;	// invincible
	else
		enemy_desire = (300 - virtual_enemy.total_damage);
};

void() ClientConnect_apply =
{
// KasCam ->
	if (! ((self.flags & FL_PLAYER) && (self.netname == "")) )
	{
		msg_level = PRINT_HIGH;
		bprint_netname (self);
		bprint (" entered the game\n");
	}
// <- KasCam

	Add_client();

	if (deathmatch <= 3)
		self.desire = goal_client;
	else
		self.desire = goal_client6;

	self.T = UNREACHABLE;	// don't jump onto/at other clients

// a client connecting during an intermission can cause problems
	if (intermission_running)
		GotoNextMap();

#ifdef QUAKE
	AssignClientBodyQue();
#endif // QUAKE
};

void() ClientConnect =
{
	if (scoreboardsize >= maxplayers)
		RemoveBot(FALSE);

	self.classname = "player";
	scoreboardsize = scoreboardsize + 1;

#ifdef QUAKE
	score_pos_ = 0;
	test_enemy = first_ent;
	while(test_enemy != self)
	{
		score_pos_ = score_pos_ + 1;
		test_enemy = nextent(test_enemy);
	}
	self.score_pos = score_pos_;

	self.aiment = EntityAt(first_frogbot, self.score_pos);
	self.colormap = self.score_pos + 1;
#endif // QUAKE

#ifdef QUAKEWORLD
	self.team = stof(infokey(self, "bottomcolor")) + 1;
#endif // QUAKEWORLD

	self.flags = parm1;
	self.number_bots = parm2;
	self.bot_skill = parm3;

	if (parm4 >= 0)
		self.teamcolor = parm4;
	else
		self.teamcolor = (self.team - 1) * 17;

	if (parm5 >= 0)
		self.color_ = parm5;
	else
		self.color_ = (self.team - 1) * 17;

	if (self == nextent(world))
		self.admin_code = dropper.admin_code;
	else
		self.admin_code = parm6;

	self.spawnbit0 = parm7;
	self.spawnbit1 = parm8;

#ifdef QUAKE
	self.spawn_skin = parm9;
	if (game_skins)
		self.skin = parm10;
	self.msg_level_ = parm11;
#endif // QUAKE

#ifdef QUAKEWORLD
	self.skin0 = parm9;
	self.skin1 = parm10;
	self.skin2 = parm11;
#endif // QUAKEWORLD

	self.preferences = parm12;

	if (self.flags & FL_FROGBOT)
	{
		self.impulse = IMP_FROGBOT;
		self.flags = self.flags - FL_FROGBOT;
	}

#ifdef QUAKE
	if (game_qwphysics)
		self.flags = self.flags | FL_QWPHYSICS;
#endif // QUAKE

	ClientConnect_apply();
	self.lookahead_time = 30;
	self.prediction_error = 0;

	LoadPlayer();
};

/*
===========
ClientDisconnect

called when a player disconnects from a server
============
*/
void() ClientDisconnect =
{
	if (self.flags & FL_PLAYER)
		scoreboardsize = scoreboardsize - 1;

	ResetItems();

	if (!gameover)
	{
	// KasCam ->
		if (self.client_)
		{
			msg_level = PRINT_HIGH;
			bprint_netname (self);
			bprint (" left the game with ");
			bprint_ftos (self.frags);
			bprint (" frags\n");
			msg_entity = self;
			sound (CHAN_BODY, "player/tornoff2.wav", 1, ATTN_NONE);
			set_suicide_frame ();
			// make a copy of the dead body for appearances sake
			CopyToBodyQue ();
		}
		else
		{
			if (! ((self.flags & FL_PLAYER) && (self.netname == "")) )
			{
				msg_level = PRINT_HIGH;
				bprint_netname (self);
				bprint (" left the game\n");
			}
		}
	// <- KasCam
	}

	RemoveFromAllLists();

#ifdef QUAKE
	self.flags = self.aiment.flags = 0;
	AssignClientBodyQue();
#endif // QUAKE
};

/*
===========
ClientObituary

called when a player dies
============
*/
void() ClientObituary =
{
	rnd = random();

	msg_level = PRINT_MEDIUM;

	if (self.client_)
	{
		if (deathtype == "selfwater")
		{
			bprint_netname (self);
			bprint (" electrocutes himself.\n");
			self.frags = self.frags - 1;
			UpdateFrags (self);
		}
		else if (deathtype == "teledeath")
		{
			bprint_netname (self);
			bprint (" was telefragged by ");
			bprint_netname (attacker.owner);
			bprint ("\n");

			if (attacker.owner.realteam == self.realteam)
				attacker.owner.frags = attacker.owner.frags - 1;
			else
				attacker.owner.frags = attacker.owner.frags + 1;
			UpdateFrags (attacker.owner);
		}
		else if (deathtype == "teledeath2")
		{
			bprint ("Satan's power deflects ");
			bprint_netname (self);
			bprint ("'s telefrag\n");

			self.frags = self.frags - 1;
			UpdateFrags (self);
		}
		else if (deathtype == "teledeath3") 
		{
			bprint_netname (self);
			bprint (" was telefragged by ");
			bprint_netname (attacker.owner);
			bprint ("'s Satan's power\n");

			if (attacker.owner.realteam == self.realteam)
				attacker.owner.frags = attacker.owner.frags - 1;
			else
				attacker.owner.frags = attacker.owner.frags + 1;
			UpdateFrags (attacker.owner);
		}
		else if (deathtype == "squish")
		{
			if (self.realteam == attacker.realteam && teamplay && self != attacker)
			{
				attacker.frags = attacker.frags - 1;
				UpdateFrags (attacker);
				bprint_netname (attacker);
				bprint (" squished a teammate\n");
			}
			else if ((attacker.client_) && attacker != self)
			{
				bprint_netname (attacker);
				bprint (" squishes ");
				bprint_netname (self);
				bprint ("\n");
				attacker.frags = attacker.frags + 1;
				UpdateFrags (attacker);
			}
			else
			{
				self.frags = self.frags - 1;            // killed self
				UpdateFrags (self);
				bprint_netname (self);
				bprint (" was squished\n");
			}
		}
		else if (attacker.client_)
		{
			if (self == attacker)
			{
				// killed self
				attacker.frags = attacker.frags - 1;
				UpdateFrags (attacker);
				bprint_netname (self);
				if (deathtype == "grenade")
					bprint (" tries to put the pin back in\n");
				else if (deathtype == "rocket")
					bprint (" becomes bored with life\n");
				else if (self.weapon == 64 && self.waterlevel > 1)
				{
					if (self.watertype == CONTENT_SLIME)
						bprint (" discharges into the slime\n");
					else if (self.watertype == CONTENT_LAVA)
						bprint (" discharges into the lava\n");
					else
						bprint (" discharges into the water.\n");
				}
				else
					bprint (" becomes bored with life\n");
			}
			else if ((healthplay == TEAM_FRAG_PENALTY) && (self.realteam == attacker.realteam) &&
				(teamplay))
			{
				if (rnd < 0.25)
					deathstring = " mows down a teammate\n";
				else if (rnd < 0.50)
					deathstring = " checks his glasses\n";
				else if (rnd < 0.75)
					deathstring = " gets a frag for the other team\n";
				else
					deathstring = " loses another friend\n";
				bprint_netname (attacker);
				bprint (deathstring);
				attacker.frags = attacker.frags - 1;
				UpdateFrags (attacker);
			}
			else
			{
				attacker.frags = attacker.frags + 1;
				UpdateFrags (attacker);

				if (deathtype == "shell")
				{
					deathstring = " chewed on ";
					deathstring2 = "'s boomstick\n";
				}
				else if (deathtype == "rocket")
				{
					if (attacker.super_damage_finished > 0 && self.health < -40)
					{
						if (rnd < 0.3)
							deathstring = " was brutalized by ";
						else if (rnd < 0.6)
							deathstring = " was smeared by ";
						else
						{
							bprint_netname (attacker);
							bprint (" rips ");
							bprint_netname (self);
							bprint (" a new one\n");
							return;
						}
						deathstring2 = "'s quad rocket\n";
					}
					else
					{
						deathstring = " rides ";
						deathstring2 = "'s rocket\n";
						if (self.health < -40)
						{
							deathstring = " was gibbed by ";
							deathstring2 = "'s rocket\n" ;
						}
					}
				}
				else if (deathtype == "cell")
				{
					deathstring = " accepts ";
					if (attacker.waterlevel > 1)
						deathstring2 = "'s discharge\n";
					else
						deathstring2 = "'s shaft\n";
				}
				else if (deathtype == "grenade")
				{
					deathstring = " eats ";
					deathstring2 = "'s pineapple\n";
					if (self.health < -40)
					{
						deathstring = " was gibbed by ";
						deathstring2 = "'s grenade\n";
					}
				}
				else if (deathtype == "supershell")
				{
					deathstring = " ate 2 loads of ";
					deathstring2 = "'s buckshot\n";
				}
				else
				{
					if (deathtype == "supernail")
						deathstring = " was punctured by ";
					else if (deathtype == "nail")
						deathstring = " was nailed by ";
					else if (deathtype == "hook")
					{
						if (random() < 0.5)
							deathstring = " was disembowled by ";
						else
							deathstring = " was hooked by ";
					}
					else	// if (deathtype == "axe")
						deathstring = " was ax-murdered by ";
					deathstring2 = "\n";
				}
				bprint_netname (self);
				bprint (deathstring);
				bprint_netname (attacker);
				bprint (deathstring2);
			}
		}
		else
		{
			if (deathtype != "forcegib")
			{
				self.frags = self.frags - 1;            // killed self
				UpdateFrags (self);
				bprint_netname (self);
				if (self.watertype == -3)
				{
					if (random() < 0.5)
						bprint (" sleeps with the fishes\n");
					else
						bprint (" sucks it down\n");
				}
				else if (self.watertype == -4)
				{
					if (random() < 0.5)
						bprint (" gulped a load of slime\n");
					else
						bprint (" can't exist on slime alone\n");
				}
				else if (self.watertype == -5)
				{
					if (self.health < -15)
						bprint (" burst into flames\n");
					else
					{
						if (random() < 0.5)
							bprint (" turned into hot slag\n");
						else
							bprint (" visits the Volcano God\n");
					}
				}
				else if (deathtype == "falling")
					bprint (" fell to his death\n");
				else if (deathtype == "nail" || deathtype == "supernail")
					bprint (" was spiked\n");
				else if (deathtype == "laser")
					bprint (" was zapped\n");
				else if (deathtype == "fireball")
					bprint (" ate a lavaball\n");
				else
					bprint (" died\n");
			}
		}
	}
};
