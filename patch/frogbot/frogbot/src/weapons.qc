void () T_Damage;
void () player_run;
void() T_RadiusDamage;
void() SuperDamageSound;
// CTF ->
void() HasteSound;
// CTF <-
void() GrenadeAlert1;
void() RocketAlert;
float() W_BestWeapon;

// called by worldspawn
void() W_Precache =
{
	precache_sound ("weapons/r_exp3.wav");	// new rocket explosion
	precache_sound ("weapons/rocket1i.wav");	// spike gun
	precache_sound ("weapons/sgun1.wav");
	precache_sound ("weapons/guncock.wav");	// player shotgun
	precache_sound ("weapons/ric1.wav");	// ricochet (used in c code)
	precache_sound ("weapons/ric2.wav");	// ricochet (used in c code)
	precache_sound ("weapons/ric3.wav");	// ricochet (used in c code)
	precache_sound ("weapons/spike2.wav");	// super spikes
	precache_sound ("weapons/tink1.wav");	// spikes tink (used in c code)
	precache_sound ("weapons/grenade.wav");	// grenade launcher
	precache_sound ("weapons/bounce.wav");	// grenade bounce
	precache_sound ("weapons/shotgn2.wav");	// super shotgun

// CTF ->
	precache_sound2 ("blob/land1.wav");     // chain go splorch!
	if (game_capture_custom) {
		precache_sound ("weapons/chain1.wav");
		precache_sound ("weapons/chain2.wav");
		precache_sound ("weapons/chain3.wav");
		precache_sound ("weapons/bounce2.wav");
	}
// CTF <-
};

float() crandom =
{
	return 2*(random() - 0.5);
};

/*
================
SpawnBlood
================
*/
#ifdef QUAKE
void(vector org, vector vel) SpawnBlood =
{
	particle (org, vel*0.1, 73, damage*2);
};
#endif // QUAKE

#ifdef QUAKEWORLD
void(vector org) SpawnBlood =
{
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_BLOOD);
	WriteByte (MSG_MULTICAST, 1);
	WriteCoord (MSG_MULTICAST, org_x);
	WriteCoord (MSG_MULTICAST, org_y);
	WriteCoord (MSG_MULTICAST, org_z);
	multicast (org, MULTICAST_PVS);
};
#endif // QUAKEWORLD

/*
================
W_FireAxe
================
*/
void() W_FireAxe =
{
	local	vector org;

	makevectors(self.v_angle);
	src = self.origin + '0 0 16';
	traceline (src, src + v_forward*64, FALSE, self);
	if (trace_fraction != 1)
	{
		org = trace_endpos - v_forward*4;

		if (trace_ent.takedamage)
		{
		#ifdef QUAKE
			damage = 20;
			SpawnBlood (org, '0 0 0');
		#endif // QUAKE

		#ifdef QUAKEWORLD
			SpawnBlood (org);
		#endif // QUAKEWORLD

			axhitme = 1;
			deathtype = "axe";
			inflictor = self;
			attacker = self;
			targ = trace_ent;
			if (deathmatch > 3)
			{
				damage = 75;
				T_Damage ();
			}
			else
			{
				damage = 20;
				T_Damage ();
			}
		}
		else
		{	// hit wall
			msg_entity = self;
			sound (CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);

		#ifdef QUAKE
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_GUNSHOT);
			WriteCoord (MSG_BROADCAST, org_x);
			WriteCoord (MSG_BROADCAST, org_y);
			WriteCoord (MSG_BROADCAST, org_z);
		#endif // QUAKE

		#ifdef QUAKEWORLD
			WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
			WriteByte (MSG_MULTICAST, TE_GUNSHOT);
			WriteByte (MSG_MULTICAST, 3);
			WriteCoord (MSG_MULTICAST, org_x);
			WriteCoord (MSG_MULTICAST, org_y);
			WriteCoord (MSG_MULTICAST, org_z);
			multicast (org, MULTICAST_PVS);
		#endif // QUAKEWORLD
		}
	}
};


//============================================================================


/*
================
spawn_touchblood
================
*/
void() spawn_touchblood =
{
	weapons_vel = normalize (self.velocity);
	weapons_vel = (normalize(weapons_vel + v_up*(random()- 0.5) + v_right*(random()- 0.5)) + 2*trace_plane_normal) * 40;

#ifdef QUAKE
	SpawnBlood (self.origin + weapons_vel*0.01, weapons_vel);
#endif // QUAKE

#ifdef QUAKEWORLD
	SpawnBlood (self.origin + weapons_vel*0.01);
#endif // QUAKEWORLD
};

/*
==============================================================================

MULTI-DAMAGE

Collects multiple small damages into a single damage

==============================================================================
*/


/*
==============================================================================

BULLETS

==============================================================================
*/

/*
================
FireBullets

Used by shotgun, super shotgun, and enemy soldier firing
Go to the trouble of combining multiple pellets into a single damage call.
================
*/
void(float shotcount, vector spread) FireBullets =
{
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.origin_z + 14.2;

	multi_ent = world;
	multi_damage = 0;

#ifdef QUAKEWORLD
	blood_count = puff_count = 0;

	traceline (src, src + v_forward*2048, FALSE, self);
	puff_org = trace_endpos - v_forward*4;
#endif // QUAKEWORLD

	while (shotcount > 0)
	{
		direction = v_forward + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		traceline (src, src + direction * 2048, FALSE, self);
		if (trace_fraction != 1)
		{
			weapons_vel = (normalize(direction + v_up*crandom() + v_right*crandom()) + (2 * trace_plane_normal)) * 200;

			blood_org = trace_endpos - direction * 4;

			if (trace_ent.takedamage)
			{
#ifdef QUAKE
				damage = 4;
				SpawnBlood (blood_org, weapons_vel*0.2);
#endif // QUAKE

#ifdef QUAKEWORLD
				blood_count = blood_count + 1;
#endif // QUAKEWORLD

				if (trace_ent != multi_ent)
				{
					if (multi_ent)
					{
						targ = multi_ent;
						damage = multi_damage;
						T_Damage ();
					}
					multi_damage = 4;
					multi_ent = trace_ent;
				}
				else
					multi_damage = multi_damage + 4;
			}
			else
			{
#ifdef QUAKE
				WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
				WriteByte (MSG_BROADCAST, TE_GUNSHOT);
				WriteCoord (MSG_BROADCAST, blood_org_x);
				WriteCoord (MSG_BROADCAST, blood_org_y);
				WriteCoord (MSG_BROADCAST, blood_org_z);
#endif // QUAKE

#ifdef QUAKEWORLD
				puff_count = puff_count + 1;
#endif // QUAKEWORLD
			}
		}

		shotcount = shotcount - 1;
	}
	if (multi_ent)
	{
		targ = multi_ent;
		damage = multi_damage;
		T_Damage ();
	}

#ifdef QUAKEWORLD
	if (puff_count)
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_GUNSHOT);
		WriteByte (MSG_MULTICAST, puff_count);
		WriteCoord (MSG_MULTICAST, puff_org_x);
		WriteCoord (MSG_MULTICAST, puff_org_y);
		WriteCoord (MSG_MULTICAST, puff_org_z);
		multicast (puff_org, MULTICAST_PVS);
	}

	if (blood_count)
	{
		WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
		WriteByte (MSG_MULTICAST, TE_BLOOD);
		WriteByte (MSG_MULTICAST, blood_count);
		WriteCoord (MSG_MULTICAST, blood_org_x);
		WriteCoord (MSG_MULTICAST, blood_org_y);
		WriteCoord (MSG_MULTICAST, blood_org_z);
		multicast (puff_org, MULTICAST_PVS);
	}
#endif // QUAKEWORLD
};

/*
================
W_FireShotgun
================
*/
void() W_FireShotgun =
{
	msg_entity = self;
	sound (CHAN_WEAPON, "weapons/guncock.wav", 1, ATTN_NORM);	

#ifdef QUAKE
	self.punchangle_x = -2;
#endif // QUAKE

#ifdef QUAKEWORLD
	if (self.flags & FL_PLAYER)
	{
		msg_entity = self;
		WriteByte (MSG_ONE, SVC_SMALLKICK);
	}
#endif // QUAKEWORLD

	if (use_ammo)
	{
		self.state = self.state | DELAY_UPDATE_WEAPONS;	
		self.currentammo = self.ammo_shells = self.ammo_shells - 1;
	}
	deathtype = "shell";
	inflictor = self;
	attacker = self;
	FireBullets (6, '0.04 0.04 0');
};

/*
==============================================================================

ROCKETS

==============================================================================
*/

void()	s_explode1	=	[0,		s_explode2] {};
void()	s_explode2	=	[1,		s_explode3] {};
void()	s_explode3	=	[2,		s_explode4] {};
void()	s_explode4	=	[3,		s_explode5] {};
void()	s_explode5	=	[4,		s_explode6] {};
void()	s_explode6	=	[5,		SUB_Remove] {};

#ifdef QUAKE

void() BecomeExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = platform.touch;	// NULL
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

#endif // QUAKE

void() Missile_Remove =
{
	self.owner = world;
	remove();
};

void() T_MissileTouch =
{
	if (other != self.owner)
	{
		if (pointcontents(self.origin) == CONTENT_SKY)
		{
			remove();
		}
		else
		{
			if (other.takedamage)
			{
				damage = 100 + random()*20;
				deathtype = "rocket";
				inflictor = self;
				attacker = self.owner;
				targ = other;
				T_Damage ();
			}

		// don't do radius damage to the other, because all the damage
		// was done in the impact
			deathtype = "rocket";
			inflictor = self;
			attacker = self.owner;
			t_radius_damage = 120;
			ignore = other;
			T_RadiusDamage ();

			self.origin = self.origin - 8 * normalize(self.velocity);
			self.owner = world;

		#ifdef QUAKE
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_EXPLOSION);
			WriteCoord (MSG_BROADCAST, self.origin_x);
			WriteCoord (MSG_BROADCAST, self.origin_y);
			WriteCoord (MSG_BROADCAST, self.origin_z);

			BecomeExplosion ();
		#endif // QUAKE

		#ifdef QUAKEWORLD
			WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
			WriteByte (MSG_MULTICAST, TE_EXPLOSION);
			WriteCoord (MSG_MULTICAST, self.origin_x);
			WriteCoord (MSG_MULTICAST, self.origin_y);
			WriteCoord (MSG_MULTICAST, self.origin_z);
			multicast (self.origin, MULTICAST_PHS);
			remove();
		#endif // QUAKEWORLD
		}
	}
};

/*
===============================================================================

LIGHTNING

===============================================================================
*/

void(entity from) LightningHit =
{
#ifdef QUAKE
	particle (trace_endpos, '0 0 100', 225, damage*4);
#endif // QUAKE

#ifdef QUAKEWORLD
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_LIGHTNINGBLOOD);
	WriteCoord (MSG_MULTICAST, trace_endpos_x);
	WriteCoord (MSG_MULTICAST, trace_endpos_y);
	WriteCoord (MSG_MULTICAST, trace_endpos_z);
	multicast (trace_endpos, MULTICAST_PVS);
#endif // QUAKEWORLD

	deathtype = "cell";
	inflictor = from;
	attacker = from;
	targ = trace_ent;
	T_Damage ();
};


/*
=================
LightningDamage
=================
*/
void(vector p1, vector p2, entity from) LightningDamage =
{
	vec_ = normalize(p2 - p1) * 16;
	vec__x = 0 - vec__y;
	vec__y = vec__x;
	vec__z = 0;

	traceline (p1, p2, FALSE, self);
	if (trace_ent.takedamage)
		LightningHit (from);
	trace_ent1 = trace_ent;

	traceline (p1 + vec_, p2 + vec_, FALSE, self);
	if (trace_ent != trace_ent1)
	{
		if (trace_ent.takedamage)
			LightningHit (from);
	}
	trace_ent2 = trace_ent;

	traceline (p1 - vec_, p2 - vec_, FALSE, self);
	if (trace_ent != trace_ent1)
	{
		if (trace_ent != trace_ent2)
		{
			if (trace_ent.takedamage)
				LightningHit (from);
		}
	}
};


void() W_FireLightning =
{
	if (self.ammo_cells < 1)
	{
		self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
	}
	else
	{
	// explode if under water
		if ((!pre_game) && (self.waterlevel > 1))
		{
			if (deathmatch > 3)
			{
				if (random() <= 0.5)
				{
					deathtype = "selfwater";
					inflictor = self;
					attacker = self.owner;
					targ = self;
					damage = 4000;
					T_Damage ();
					return;
				}
			}

			t_radius_damage = 35 * self.ammo_cells;
			self.ammo_cells = 0;
			W_SetCurrentAmmo ();
			self.state = self.state | DELAY_UPDATE_WEAPONS;
			deathtype = "cell";
			inflictor = self;
			attacker = self;
			ignore = world;
			T_RadiusDamage ();
		}
		else
		{
			if (self.t_width < time)
			{
				msg_entity = self;
				sound (CHAN_WEAPON, "weapons/lhit.wav", 1, ATTN_NORM);
				self.t_width = time + 0.6;
			}

		#ifdef QUAKE
			self.punchangle_x = -2;
		#endif // QUAKE

		#ifdef QUAKEWORLD
			if (self.flags & FL_PLAYER)
			{
				msg_entity = self;
				WriteByte (MSG_ONE, SVC_SMALLKICK);
			}
		#endif // QUAKEWORLD

			if (use_ammo)
			{
				self.state = self.state | DELAY_UPDATE_WEAPONS;
				self.currentammo = self.ammo_cells = self.ammo_cells - 1;
			}

			org_ = self.origin + '0 0 16';

			makevectors(self.v_angle);
			traceline (org_, org_ + v_forward*600, TRUE, self);

		#ifdef QUAKE
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_LIGHTNING2);
			WriteEntity (MSG_BROADCAST, self);
			WriteCoord (MSG_BROADCAST, org__x);
			WriteCoord (MSG_BROADCAST, org__y);
			WriteCoord (MSG_BROADCAST, org__z);
			WriteCoord (MSG_BROADCAST, trace_endpos_x);
			WriteCoord (MSG_BROADCAST, trace_endpos_y);
			WriteCoord (MSG_BROADCAST, trace_endpos_z);
		#endif // QUAKE

		#ifdef QUAKEWORLD
			WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
			WriteByte (MSG_MULTICAST, TE_LIGHTNING2);
			WriteEntity (MSG_MULTICAST, self);
			WriteCoord (MSG_MULTICAST, org__x);
			WriteCoord (MSG_MULTICAST, org__y);
			WriteCoord (MSG_MULTICAST, org__z);
			WriteCoord (MSG_MULTICAST, trace_endpos_x);
			WriteCoord (MSG_MULTICAST, trace_endpos_y);
			WriteCoord (MSG_MULTICAST, trace_endpos_z);
			multicast (org_, MULTICAST_PHS);
		#endif // QUAKEWORLD

			damage = 30;
			LightningDamage (org_, trace_endpos + v_forward*4, self);
		}
	}
};


//=============================================================================

void() GrenadeExplode =
{
	deathtype = "grenade";
	inflictor = self;
	attacker = self.owner;
	t_radius_damage = 120;
	ignore = world;
	T_RadiusDamage ();

#ifdef QUAKE
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	BecomeExplosion ();
#endif // QUAKE

#ifdef QUAKEWORLD
	WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
	WriteByte (MSG_MULTICAST, TE_EXPLOSION);
	WriteCoord (MSG_MULTICAST, self.origin_x);
	WriteCoord (MSG_MULTICAST, self.origin_y);
	WriteCoord (MSG_MULTICAST, self.origin_z);
	multicast (self.origin, MULTICAST_PHS);
	remove ();
#endif // QUAKEWORLD
};

void() GrenadeTouch =
{
	if (other != self.owner)
	{
		if (other.takedamage == DAMAGE_AIM)
		{
			GrenadeExplode();
		}
		else
		{
			msg_entity = self;
			sound (CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);	// bounce sound
			if (self.velocity == '0 0 0')
				self.avelocity = '0 0 0';
		}
	}
};


//=============================================================================

void() spike_touch;
void() superspike_touch;

/*
===============
launch_spike

===============
*/
void(vector org, vector dir) launch_spike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;

	newmis.angles = vectoangles(dir);
	
	newmis.touch = spike_touch;
	newmis.classname = "missile";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	setorigin (newmis, org);

	newmis.velocity = dir;
};

void(float ox) W_FireSpikes =
{
	if (self.weapon == IT_SUPER_NAILGUN)
	{
		if (self.ammo_nails >= 2)
		{
			msg_entity = self;
			sound (CHAN_WEAPON, "weapons/spike2.wav", 1, ATTN_NORM);
			self.attack_finished = time + 0.2;
			if (use_ammo)
			{
				self.state = self.state | DELAY_UPDATE_WEAPONS;
				self.currentammo = self.ammo_nails = self.ammo_nails - 2;
			}
			makevectors(self.v_angle);
// CTF ->
			if (self.player_flag & ITEM_RUNE3_FLAG)
			{
				HasteSound();
				launch_spike (self.origin + '0 0 16', v_forward * 2000);
			}
			else
				launch_spike (self.origin + '0 0 16', v_forward * 1000);
// CTF <-
			newmis.touch = superspike_touch;
			setmodel (newmis, "progs/s_spike.mdl");
			setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		

#ifdef QUAKE
			self.punchangle_x = -2;
#endif // QUAKE

#ifdef QUAKEWORLD
			if (self.flags & FL_PLAYER)
			{
				msg_entity = self;
				WriteByte (MSG_ONE, SVC_SMALLKICK);
			}
#endif // QUAKEWORLD

			return;
		}
	}

	if (self.ammo_nails < 1)
	{
		self.weapon = W_BestWeapon ();
		W_SetCurrentAmmo ();
	}
	else
	{
		msg_entity = self;
		sound (CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
		self.attack_finished = time + 0.2;
		if (use_ammo)
		{
			self.state = self.state | DELAY_UPDATE_WEAPONS;
			self.currentammo = self.ammo_nails = self.ammo_nails - 1;
		}
		makevectors(self.v_angle);
	// CTF ->
		if (self.player_flag & ITEM_RUNE3_FLAG)
		{
			HasteSound();
			launch_spike (self.origin + '0 0 16' + v_right*ox, v_forward * 2000);
		}
		else
			launch_spike (self.origin + '0 0 16' + v_right*ox, v_forward * 1000);
	// CTF <-

	#ifdef QUAKE
		self.punchangle_x = -2;
	#endif // QUAKE

	#ifdef QUAKEWORLD
		if (self.flags & FL_PLAYER)
		{
			msg_entity = self;
			WriteByte (MSG_ONE, SVC_SMALLKICK);
		}
	#endif // QUAKEWORLD
	}
};

void() spike_touch =
{
	if (other != self.owner)
	{
		if (other.solid != SOLID_TRIGGER)
		{
			if (pointcontents(self.origin) == CONTENT_SKY)
			{
				remove();
			}
			else
			{
			// hit something that bleeds
				if (other.takedamage)
				{
					damage = 9;
					spawn_touchblood ();
					deathtype = "nail";
					inflictor = self;
					attacker = self.owner;
					targ = other;
					T_Damage ();
				}
				else
				{
				#ifdef QUAKE
					WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
					WriteByte (MSG_BROADCAST, TE_SPIKE);
					WriteCoord (MSG_BROADCAST, self.origin_x);
					WriteCoord (MSG_BROADCAST, self.origin_y);
					WriteCoord (MSG_BROADCAST, self.origin_z);
				#endif // QUAKE

				#ifdef QUAKEWORLD
					WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
					WriteByte (MSG_MULTICAST, TE_SPIKE);
					WriteCoord (MSG_MULTICAST, self.origin_x);
					WriteCoord (MSG_MULTICAST, self.origin_y);
					WriteCoord (MSG_MULTICAST, self.origin_z);
					multicast (self.origin, MULTICAST_PHS);
				#endif // QUAKEworld
				}

				remove();
			}
		}
	}
};

void() superspike_touch =
{
	if (other != self.owner)
	{
		if (other.solid != SOLID_TRIGGER)
		{
			if (pointcontents(self.origin) == CONTENT_SKY)
			{
				remove();
			}
			else
			{
			// hit something that bleeds
				if (other.takedamage)
				{
					damage = 18;
					spawn_touchblood ();
					deathtype = "supernail";
					inflictor = self;
					attacker = self.owner;
					targ = other;
					T_Damage ();
				}
				else
				{
				#ifdef QUAKE
					WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
					WriteByte (MSG_BROADCAST, TE_SUPERSPIKE);
					WriteCoord (MSG_BROADCAST, self.origin_x);
					WriteCoord (MSG_BROADCAST, self.origin_y);
					WriteCoord (MSG_BROADCAST, self.origin_z);
				#endif // QUAKE

				#ifdef QUAKEWORLD
					WriteByte (MSG_MULTICAST, SVC_TEMPENTITY);
					WriteByte (MSG_MULTICAST, TE_SUPERSPIKE);
					WriteCoord (MSG_MULTICAST, self.origin_x);
					WriteCoord (MSG_MULTICAST, self.origin_y);
					WriteCoord (MSG_MULTICAST, self.origin_z);
					multicast (self.origin, MULTICAST_PHS);
				#endif // QUAKEWORLD
				}

				remove();
			}
		}
	}
};

/*
===============================================================================

PLAYER WEAPON USE

===============================================================================
*/

void() W_SetCurrentAmmo =
{
	weapon_ = self.weapon;

	player_run ();		// get out of any weapon firing states

	self.items = self.items & IT_NOT_AMMO;

	if (weapon_ == IT_AXE)
	{
		self.currentammo = 0;
		self.weaponmodel = "progs/v_axe.mdl";
	}
// CTF ->
	else if (weapon_ == IT_HOOK)
	{
		self.currentammo = 0;
		if (game_capture_custom) 
			self.weaponmodel = "progs/v_star.mdl";
		else
			self.weaponmodel = "progs/v_axe.mdl";
	}
// CTF <-
	else if (weapon_ == IT_SHOTGUN)
	{
		self.currentammo = self.ammo_shells;
		self.weaponmodel = "progs/v_shot.mdl";
		self.items = self.items | IT_SHELLS;
	}
	else if (weapon_ == IT_SUPER_SHOTGUN)
	{
		self.currentammo = self.ammo_shells;
		self.weaponmodel = "progs/v_shot2.mdl";
		self.items = self.items | IT_SHELLS;
	}
	else if (weapon_ == IT_NAILGUN)
	{
		self.currentammo = self.ammo_nails;
		self.weaponmodel = "progs/v_nail.mdl";
		self.items = self.items | IT_NAILS;
	}
	else if (weapon_ == IT_SUPER_NAILGUN)
	{
		self.currentammo = self.ammo_nails;
		self.weaponmodel = "progs/v_nail2.mdl";
		self.items = self.items | IT_NAILS;
	}
	else if (weapon_ == IT_GRENADE_LAUNCHER)
	{
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "progs/v_rock.mdl";
		self.items = self.items | IT_ROCKETS;
	}
	else if (weapon_ == IT_ROCKET_LAUNCHER)
	{
		self.currentammo = self.ammo_rockets;
		self.weaponmodel = "progs/v_rock2.mdl";
		self.items = self.items | IT_ROCKETS;
	}
	else	// if (weapon_ == IT_LIGHTNING)
	{
		self.currentammo = self.ammo_cells;
		self.weaponmodel = "progs/v_light.mdl";
		self.items = self.items | IT_CELLS;
	}
};

float() W_BestWeapon =
{
	items_ = self.items;

	if (items_ & IT_LIGHTNING)
		if (self.ammo_cells >= 1)
			if (self.waterlevel <= 1)
				return IT_LIGHTNING;
	if (items_ & IT_SUPER_NAILGUN)
		if (self.ammo_nails >= 2)
			return IT_SUPER_NAILGUN;
	if (items_ & IT_SUPER_SHOTGUN)
		if (self.ammo_shells >= 2)
			return IT_SUPER_SHOTGUN;
	if (items_ & IT_NAILGUN)
		if (self.ammo_nails >= 1)
			return IT_NAILGUN;
	if (items_ & IT_SHOTGUN)
		if (self.ammo_shells >= 1)
			return IT_SHOTGUN;
	return IT_AXE;
};

/*
============
W_Attack

An attack impulse can be triggered now
============
*/
void()	player_axe1;
void()	player_axeb1;
void()	player_axec1;
void()	player_axed1;
void()	player_shot1;
void()	player_nail1;
void()	player_light1;
void()	player_rocket1;
// CTF ->
void()	player_chain1;
// CTF <-

void() W_Attack =
{
	weapon_ = self.weapon;

	if (self.currentammo <= 0)
	{
		if (!(weapon_ & IT_AXE_HOOK))
		{
			self.weapon = W_BestWeapon ();
			W_SetCurrentAmmo ();
		// drop the weapon down
			return;
		}
	}

	if (weapon_ == IT_AXE)
	{
		msg_entity = self;
		sound (CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
		rnd = random();
		if (rnd < 0.25)
			player_axe1 ();
		else if (rnd < 0.5)
			player_axeb1 ();
		else if (rnd < 0.75)
			player_axec1 ();
		else
			player_axed1 ();
	// CTF ->
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG)
		{
			self.attack_finished = time + 0.3;
			HasteSound();
		}
		else
			self.attack_finished = time + 0.5;
	// CTF <-
	}
	else if (weapon_ == IT_SHOTGUN)
	{
		player_shot1 ();
		W_FireShotgun ();
	// CTF ->
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG)
		{
			self.attack_finished = time + 0.3;
			HasteSound();
		}
		else
			self.attack_finished = time + 0.5;
	// CTF <-
	}
	else if (weapon_ == IT_SUPER_SHOTGUN)
	{
		player_shot1 ();

		if (self.currentammo == 1)
		{
			W_FireShotgun ();
		}
		else
		{
			msg_entity = self;
			sound (CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM);	

#ifdef QUAKE
			self.punchangle_x = -4;
#endif // QUAKE

#ifdef QUAKEWORLD
			if (self.flags & FL_PLAYER)
			{
				msg_entity = self;
				WriteByte (MSG_ONE, SVC_BIGKICK);
			}
#endif // QUAKEWORLD

			if (use_ammo)
			{
				self.state = self.state | DELAY_UPDATE_WEAPONS;
				self.currentammo = self.ammo_shells = self.ammo_shells - 2;
			}
			deathtype = "supershell";
			inflictor = self;
			attacker = self;
			FireBullets (14, '0.14 0.08 0');
		}

	// CTF ->
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG)
		{
			self.attack_finished = time + 0.4;
			HasteSound();
		}
		else
			self.attack_finished = time + 0.7;
	// CTF <-
	}
	else if (weapon_ == IT_NAILGUN)
	{
		player_nail1 ();
	}
	else if (weapon_ == IT_SUPER_NAILGUN)
	{
		player_nail1 ();
	}
	else if (weapon_ == IT_GRENADE_LAUNCHER)
	{
		player_rocket1();

		if (use_ammo)
		{
			self.state = self.state | DELAY_UPDATE_WEAPONS;
			self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
		}

		msg_entity = self;
		sound (CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

#ifdef QUAKE
		self.punchangle_x = -2;
#endif // QUAKE

#ifdef QUAKEWORLD
		if (self.flags & FL_PLAYER)
		{
			msg_entity = self;
			WriteByte (MSG_ONE, SVC_SMALLKICK);
		}
#endif // QUAKEWORLD

		missile = spawn ();
		missile.owner = self;
		missile.movetype = MOVETYPE_BOUNCE;
		missile.solid = SOLID_BBOX;
		missile.classname = "missile";
		
	// set missile speed	

		makevectors(self.v_angle);

		if (self.v_angle_x)
			missile.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
		else
		{
			missile.velocity = v_forward * 600;
			missile.velocity_z = 200;
		}

		missile.avelocity = '300 300 300';

		missile.angles = vectoangles(missile.velocity);
	
		missile.touch = GrenadeTouch;
	
	// set missile duration
		missile.nextthink = time + 1;
		missile.think = GrenadeAlert1;
		missile.frogbot_nextthink = time + 2.5;

		setmodel (missile, "progs/grenade.mdl");
		setsize (missile, '0 0 0', '0 0 0');		
		setorigin (missile, self.origin);

	// CTF ->
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG)
		{
			self.attack_finished = time + 0.3;
			HasteSound();
		}
		else
			self.attack_finished = time + 0.6;
	// CTF <-
	}
	else if (weapon_ == IT_ROCKET_LAUNCHER)
	{
		player_rocket1();

		if (use_ammo)
		{
			self.state = self.state | DELAY_UPDATE_WEAPONS;
			self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
		}

		msg_entity = self;
		sound (CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);

#ifdef QUAKE
		self.punchangle_x = -2;
#endif // QUAKE

#ifdef QUAKEWORLD
		if (self.flags & FL_PLAYER)
		{
			msg_entity = self;
			WriteByte (MSG_ONE, SVC_SMALLKICK);
		}
#endif // QUAKEWORLD

		missile = spawn ();
		missile.owner = self;
		self.movetarget = missile;
		missile.movetype = MOVETYPE_FLYMISSILE;
		missile.solid = SOLID_BBOX;
		missile.classname = "missile";
		
	// set missile speed	

		makevectors(self.v_angle);

		missile.velocity = v_forward * 1000;
		missile.angles = vectoangles(missile.velocity);
	
		missile.touch = T_MissileTouch;
	
	// set missile duration
		missile.think = RocketAlert;
		missile.frogbot_nextthink = time + 5;
		missile.nextthink = 0.001;

		setmodel (missile, "progs/missile.mdl");
		setsize (missile, '0 0 0', '0 0 0');		
		setorigin (missile, self.origin + v_forward*8 + '0 0 16');

	// CTF ->
		// RUNE: rune of hell magic
		if (self.player_flag & ITEM_RUNE3_FLAG)
		{
			self.attack_finished = time + 0.4;
			HasteSound();
		}
		else
			self.attack_finished = time + 0.8;
	// CTF <-
	}
	else if (weapon_ == IT_LIGHTNING)
	{
		player_light1();
		self.attack_finished = time + 0.1;
		msg_entity = self;
		sound (CHAN_AUTO, "weapons/lstart.wav", 1, ATTN_NORM);
	}
	// CTF ->
	else	// if (weapon_ == IT_HOOK)
	{
		if (!self.hook_out)
			player_chain1();
		self.attack_finished = time + 0.1;
	}
	// CTF <-
};

// CTF ->
void() SetWeapon =
{
	self.weapon = weapon_;
	if (game_enable_hook)
	{
		msg_entity = self;
		msg_level = PRINT_HIGH;
		if (weapon_ == IT_AXE)
			sprint("Axe selected.\n");
		else if (weapon_ == IT_HOOK)
			sprint("Grappling hook selected.\n");
	}
};
// CTF <-

/*
============
W_ChangeWeapon

============
*/
void() W_ChangeWeapon =
{
	am = 0;

	if (impulse_ == 8)
	{
		weapon_ = IT_LIGHTNING;
		if (self.ammo_cells < 1)
			am = 1;
	}
	else if (impulse_ == 7)
	{
		weapon_ = IT_ROCKET_LAUNCHER;
		if (self.ammo_rockets < 1)
			am = 1;
	}
	else if (impulse_ == 6)
	{
		weapon_ = IT_GRENADE_LAUNCHER;
		if (self.ammo_rockets < 1)
			am = 1;
	}
	else if (impulse_ == 5)
	{
		weapon_ = IT_SUPER_NAILGUN;
		if (self.ammo_nails < 2)
			am = 1;
	}
	else if (impulse_ == 4)
	{
		weapon_ = IT_NAILGUN;
		if (self.ammo_nails < 1)
			am = 1;
	}
	else if (impulse_ == 3)
	{
		weapon_ = IT_SUPER_SHOTGUN;
		if (self.ammo_shells < 2)
			am = 1;
	}
	else if (impulse_ == 2)
	{
		weapon_ = IT_SHOTGUN;
		if (self.ammo_shells < 1)
			am = 1;
	}
	// CTF ->
	else if (impulse_ == 9)
	{
		weapon_ = IT_HOOK;
	}
	// CTF <-
	else	// if (impulse_ == 1)
	{
		if ((weapon_ == IT_AXE) && (game_enable_hook))
			weapon_ = IT_HOOK;
		else
			weapon_ = IT_AXE;
	}

	if (self.items & weapon_)
	{
		if (am)
		{	// don't have the ammo
			msg_entity = self;
			msg_level = PRINT_HIGH;
			sprint ("not enough ammo.\n");
		}
		else
		{
		//
		// set weapon, set ammo
		//
			SetWeapon();
			W_SetCurrentAmmo ();
		}
	}
	else
	{	// don't have the weapon or the ammo
		msg_entity = self;
		msg_level = PRINT_HIGH;
		sprint ("no weapon.\n");
	}
};

/*
============
CycleWeaponCommand

Go to the next weapon with ammo
============
*/
void() CycleWeaponCommand =
{
	items_ = self.items;
	weapon_ = self.weapon;
	
	while (1)
	{
		am = 1;

		if (weapon_ == IT_LIGHTNING)
		{
			weapon_ = IT_AXE;
		}
		else if (weapon_ == IT_AXE)
		{
			if (game_enable_hook)
				weapon_ = IT_HOOK;
			else
			{
				weapon_ = IT_SHOTGUN;
				if (self.ammo_shells < 1)
					am = 0;
			}
		}
		else if (weapon_ == IT_HOOK)
		{
			weapon_ = IT_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 0;
		}
		else if (weapon_ == IT_SHOTGUN)
		{
			weapon_ = IT_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 0;
		}		
		else if (weapon_ == IT_SUPER_SHOTGUN)
		{
			weapon_ = IT_NAILGUN;
			if (self.ammo_nails < 1)
				am = 0;
		}
		else if (weapon_ == IT_NAILGUN)
		{
			weapon_ = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 0;
		}
		else if (weapon_ == IT_SUPER_NAILGUN)
		{
			weapon_ = IT_GRENADE_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 0;
		}
		else if (weapon_ == IT_GRENADE_LAUNCHER)
		{
			weapon_ = IT_ROCKET_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 0;
		}
		else	// if (weapon_ == IT_ROCKET_LAUNCHER)
		{
			weapon_ = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 0;
		}

		if (items_ & weapon_)
		{
			if (am)
			{
				SetWeapon();
				W_SetCurrentAmmo ();
				return;
			}
		}
	}
};

/*
============
CycleWeaponReverseCommand

Go to the prev weapon with ammo
============
*/
void() CycleWeaponReverseCommand =
{
	items_ = self.items;
	weapon_ = self.weapon;

	while (1)
	{
		am = 1;

		if (weapon_ == IT_LIGHTNING)
		{
			weapon_ = IT_ROCKET_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 0;
		}
		else if (weapon_ == IT_ROCKET_LAUNCHER)
		{
			weapon_ = IT_GRENADE_LAUNCHER;
			if (self.ammo_rockets < 1)
				am = 0;
		}
		else if (weapon_ == IT_GRENADE_LAUNCHER)
		{
			weapon_ = IT_SUPER_NAILGUN;
			if (self.ammo_nails < 2)
				am = 0;
		}
		else if (weapon_ == IT_SUPER_NAILGUN)
		{
			weapon_ = IT_NAILGUN;
			if (self.ammo_nails < 1)
				am = 0;
		}
		else if (weapon_ == IT_NAILGUN)
		{
			weapon_ = IT_SUPER_SHOTGUN;
			if (self.ammo_shells < 2)
				am = 0;
		}		
		else if (weapon_ == IT_SUPER_SHOTGUN)
		{
			weapon_ = IT_SHOTGUN;
			if (self.ammo_shells < 1)
				am = 0;
		}
		else if (weapon_ == IT_SHOTGUN)
		{
			if (game_enable_hook)
				weapon_ = IT_HOOK;
			else
				weapon_ = IT_AXE;
		}
		else if (weapon_ == IT_HOOK)
		{
			weapon_ = IT_AXE;
		}
		else	// if (weapon_ == IT_AXE)
		{
			weapon_ = IT_LIGHTNING;
			if (self.ammo_cells < 1)
				am = 0;
		}

		if (items_ & weapon_)
		{
			if (am)
			{
				SetWeapon();
				W_SetCurrentAmmo ();
				return;
			}
		}
	}
};

// CTF ->
/*
========
SuperDamageSound

Plays sound if needed
========
*/
void() SuperDamageSound =
{
// RUNE play super damage sound if player has Black Magic, too

	msg_entity = self;

	if (self.player_flag & ITEM_RUNE2_FLAG)
	{
		if (game_capture_custom)
		{
			if (self.super_sound < time)
			{
				self.super_sound = time + 1;
				if (self.super_damage_finished > time)
					sound (CHAN_BODY, "rune/rune22.wav", 1, ATTN_NORM);
				else
					sound (CHAN_BODY, "rune/rune2.wav", 1, ATTN_NORM);
			}
			return;
		}
	}
	else
	{
		if (self.super_damage_finished <= time)
			return;
	}

	if (self.super_sound < time)
	{
		self.super_sound = time + 1;
		sound (CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
	}
};

/*
========
RegenerationSound

Plays sound if needed
========
*/
void() RegenerationSound =
{
	msg_entity = self;
// RUNE play healing sound if player has Elder Magic
	if (self.regeneration_sound <= time)
	{
		self.regeneration_sound = time + 1;
		if (game_capture_custom)
			sound(CHAN_BODY, "rune/rune4.wav", 1, ATTN_NORM);
		else
			sound(CHAN_BODY, "items/r_item1.wav", 1, ATTN_NORM);
	}
};

/*
========
HasteSound

Plays sound if needed
========
*/
void() HasteSound =
{
	msg_entity = self;
// RUNE play haste (Chthon's roar) sound if player has Hell Magic
	if (self.haste_sound <= time)
	{
		self.haste_sound = time + 1;
		if (game_capture_custom)
			sound(CHAN_BODY, "rune/rune3.wav", 1, ATTN_NORM);
		else
			sound(CHAN_BODY, "boss1/sight1.wav", 1, ATTN_NORM);
	}
};
// CTF <-
