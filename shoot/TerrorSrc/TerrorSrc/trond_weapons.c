//TROND
//WEAPONS
#include "g_local.h"
#include "m_player.h"

void NoAmmoWeaponChange (edict_t *ent);
void Weapon_Glock_Fire (edict_t *ent);
void P_ProjectSource (gclient_t *client, vec3_t point, vec3_t distance, vec3_t forward, vec3_t right, vec3_t result);
void Weapon_Generic (edict_t *ent, int FRAME_ACTIVATE_LAST, int FRAME_FIRE_LAST, int FRAME_IDLE_LAST, int FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/int FRAME_RELOAD_LAST, int FRAME_ENDMAG_LAST,/*TROND slutt*/ int *pause_frames, int *fire_frames, void (*fire)(edict_t *ent));

void stick(edict_t *projectile, edict_t *object);

//MINE
static void Mine_Blow (edict_t *ent)
{
	Grenade_Explode (ent) ;
/*	if (ent->health < ent->max_health)
	{
		gi.WriteByte (svc_temp_entity);
		gi.WriteByte (TE_ROCKET_EXPLOSION);
		gi.WritePosition (ent->s.origin);
		gi.multicast (ent->s.origin, MULTICAST_PHS);
	}*/
}


static void Mine_Think (edict_t *ent)
{
	edict_t	*player = NULL;

	while ((player = findradius (player, ent->s.origin, 40)) != NULL)
	{
		if (player->client
			|| player->classname == "hgrenade"
			|| player->classname == "police")
		{
			ent->nextthink = level.time + 0.1;
			ent->think = Mine_Blow;
			return;
		}
	}

	ent->nextthink = level.time + 0.2;
}

static void mine_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
	G_FreeEdict (self);
}

static void Weapon_Mine_Placed (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int kick, float damage_radius)
{
	trace_t		tr;
	edict_t		*mine;

	mine = G_Spawn();
	VectorCopy (self->s.origin, mine->s.origin);
	vectoangles (tr.plane.normal, mine->s.angles);
	mine->s.modelindex = gi.modelindex ("models/slat/world_mine/world_mine_placed.md2");
	mine->owner = self;
	mine->movetype = MOVETYPE_TOSS;

	mine->solid = SOLID_BBOX;
//	VectorClear (mine->mins);
//	VectorClear (mine->maxs);
	mine->s.renderfx |= RF_IR_VISIBLE;
	mine->dmg = damage;
	mine->dmg_radius = damage_radius;
	mine->classname = "mine";
	VectorSet (mine->mins, -4, -4, -6);	
	VectorSet (mine->maxs, 4, 4, 8);
	mine->nextthink = level.time + 1.5;
	mine->think = Mine_Think;
	
//	mine->takedamage = DAMAGE_YES;
//	mine->max_health = 350;
//	mine->health = 350;
//	mine->die = mine_die;

	self->client->pers.inventory[self->client->ammo_index] -= 1;
	self->client->weight += 5;

	gi.linkentity (mine);
	gi.sound(self, CHAN_WEAPON, gi.soundindex("slat/weapons/bush_hit.wav"), 1, ATTN_NORM, 0);
	self->client->ps.gunindex = 0;
	NoAmmoWeaponChange (self);
	return;
}

static void Weapon_Mine_Place (edict_t *ent)//, int damage)
{
	vec3_t          start;
    vec3_t          forward, right;

    vec3_t          offset;
    int             damage = 300;
    int             kick = 500;

	ent->client->ps.gunframe++;

    AngleVectors (ent->client->v_angle, forward, right, NULL);

    VectorScale (forward, -2, ent->client->kick_origin);
    ent->client->kick_angles[0] = -2;

    VectorSet(offset, 0, 0,  ent->viewheight);
    P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	if (ent->client->pers.inventory[ent->client->ammo_index] > 0)
		Weapon_Mine_Placed (ent, start, forward, damage, kick, 300);
}


void Weapon_Mine (edict_t *ent)
{
	static int	pause_frames[]	= {14, 0};
	static int	fire_frames[]	= {11, 0};

/*	if (ent->client->weaponstate == WEAPON_READY)		
		ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);*/
/*
	if (ent->client->ps.gunframe == 6)
	{
		ent->client->ps.gunindex = 0;
	}
*/
	Weapon_Generic (ent, 4, 12, 22, 24,/*TROND RELOAD*/0, 0, pause_frames, fire_frames, Weapon_Mine_Place);
}

//C4 Detpack
static void Weapon_C4_Placed (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int kick, float damage_radius)
{
	trace_t		tr; 
    vec3_t		end, forward;
	edict_t		*c4;

	//KULA GÅR FRÅ MIDTEN AV SKJERMEN
	vec3_t		center_screen;
	//kula går frå midten av skjermen
	VectorScale (forward, 2, center_screen);
	VectorAdd (center_screen, self->s.origin, center_screen);
	center_screen[2] += self->viewheight;
	//TROND slutt
    
    VectorMA (start, 60, aimdir, end);

    tr = gi.trace (start, NULL, NULL, end, self, MASK_SHOT);

        // don't need to check for water
    if (!((tr.surface) && (tr.surface->flags & SURF_SKY)))    
    {
        if (tr.fraction < 1.0)        
        {  
			if (!tr.ent->takedamage)
			{
				gi.WriteByte (svc_temp_entity);
				gi.WriteByte (TE_SPARKS);
				gi.WritePosition (tr.endpos);
				gi.WriteDir (tr.plane.normal);
				gi.multicast (tr.endpos, MULTICAST_PVS);

				c4 = G_Spawn();
				VectorCopy (tr.endpos, c4->s.origin);
				vectoangles (tr.plane.normal, c4->s.angles);
				c4->s.modelindex = gi.modelindex ("models/slat/world_c4/world_c4_placed.md2");
				c4->owner = self;
				c4->solid = SOLID_BBOX;
				VectorClear (c4->mins);
				VectorClear (c4->maxs);
				c4->s.renderfx |= RF_IR_VISIBLE;
				c4->dmg = damage;
				c4->dmg_radius = damage_radius;
				c4->classname = "explosive";

//				c4->takedamage = DAMAGE_YES;
//				c4->max_health = 350;
//				c4->health = 350;
//				c4->die = mine_die;

				self->client->pers.inventory[self->client->ammo_index] -= 1;
				self->client->weight += 5;

				gi.linkentity (c4);
				stick (c4, tr.ent);
				gi.sound(self, CHAN_WEAPON, gi.soundindex("slat/weapons/bush_hit.wav"), 1, ATTN_NORM, 0);
				self->client->ps.gunindex = 0;
				NoAmmoWeaponChange (self);
				return;
			}
			else
			{
//				gi.cprintf (self, PRINT_HIGH, "Can`t place C4 here\n");
				self->client->ps.gunframe == 0;
				self->client->ps.gunframe++;
				self->client->weaponstate = WEAPON_READY;
				return;
			}
		}
		if (tr.fraction == 1.0)
		{
//			gi.cprintf (self, PRINT_HIGH, "Can`t place C4 here\n");
			self->client->ps.gunframe == 0;
			self->client->ps.gunframe++;
			self->client->weaponstate = WEAPON_READY;
			return;
		}
	}
}

static void Weapon_C4_Place (edict_t *ent)//, int damage)
{
	vec3_t          start;
    vec3_t          forward, right;

    vec3_t          offset;
    int             damage = 300;
    int             kick = 500;

	ent->client->ps.gunframe++;

    AngleVectors (ent->client->v_angle, forward, right, NULL);

    VectorScale (forward, -2, ent->client->kick_origin);
    ent->client->kick_angles[0] = -2;

    VectorSet(offset, 0, 0,  ent->viewheight);
    P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	if (ent->client->pers.inventory[ent->client->ammo_index] > 0)
		Weapon_C4_Placed (ent, start, forward, damage, kick, 300);
}


void Weapon_C4 (edict_t *ent)
{
	static int	pause_frames[]	= {34, 51, 59, 0};
	static int	fire_frames[]	= {6, 0};

/*	if (ent->client->weaponstate == WEAPON_READY)		
		ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);*/
/*
	if (ent->client->ps.gunframe == 6)
	{
		ent->client->ps.gunindex = 0;
	}
*/
	Weapon_Generic (ent, 4, 10, 18, 20,/*TROND RELOAD*/0, 0, pause_frames, fire_frames, Weapon_C4_Place);
}
//BUSH KNIFE
static void Weapon_Bush_Struck (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int kick)
{
	trace_t		tr; 
    vec3_t		end, forward;

	//KULA GÅR FRÅ MIDTEN AV SKJERMEN
	vec3_t		center_screen;
	//kula går frå midten av skjermen
	VectorScale (forward, 2, center_screen);
	VectorAdd (center_screen, self->s.origin, center_screen);
	center_screen[2] += self->viewheight;
	//TROND slutt
    
    VectorMA (start, 75, aimdir, end);

    tr = gi.trace (start, NULL, NULL, end, self, MASK_SHOT);

/*	gi.WriteByte (svc_temp_entity);
	gi.WriteByte (TE_RAILTRAIL);
	gi.WritePosition (start);
	gi.WritePosition (tr.endpos);
	gi.multicast (start, MULTICAST_PHS);*/

        // don't need to check for water
    if (!((tr.surface) && (tr.surface->flags & SURF_SKY)))    
    {
        if (tr.fraction < 1.0)        
        {            
            if (tr.ent->takedamage
				&& (tr.ent->classname == "police" || tr.ent->client))
			{
				if (tr.endpos[2] < ((tr.ent->s.origin[2] - 0)))
					T_Damage (tr.ent, self, self, aimdir, tr.endpos, tr.plane.normal, damage, kick, 0, MOD_BUSH_LEG);
				if (tr.endpos[2] < ((tr.ent->s.origin[2] + 20))
					&& tr.endpos[2] > ((tr.ent->s.origin[2] - 0)))
					T_Damage (tr.ent, self, self, aimdir, tr.endpos, tr.plane.normal, damage, kick, 0, MOD_BUSH_CHEST);
				if (tr.endpos[2] > ((tr.ent->s.origin[2] + 20)))
					T_Damage (tr.ent, self, self, aimdir, tr.endpos, tr.plane.normal, damage, kick, 0, MOD_BUSH_HEAD);
			}
			else
			{
				gi.WriteByte (svc_temp_entity);
				gi.WriteByte (TE_SPARKS);
				gi.WritePosition (tr.endpos);
				gi.WriteDir (tr.plane.normal);
				gi.multicast (tr.endpos, MULTICAST_PVS);

				gi.WriteByte (svc_temp_entity);
				gi.WriteByte (TE_SPARKS);
				gi.WritePosition (tr.endpos);
				gi.WriteDir (tr.plane.normal);
				gi.multicast (tr.endpos, MULTICAST_PVS);

				if (tr.surface->flags & SURF_TRANS66
					|| tr.surface->flags & SURF_TRANS33)
					gi.sound(self, CHAN_WEAPON, gi.soundindex("slat/world/vindu_knus.wav"), 1, ATTN_NORM, 0);
				else
					gi.sound(self, CHAN_WEAPON, gi.soundindex("slat/weapons/bush_hit.wav"), 1, ATTN_NORM, 0);
				
				return;
				/*
				debris = G_Spawn();
				VectorCopy (tr.endpos, debris->s.origin);
				vectoangles (tr.plane.normal, debris->s.angles);
				VectorMA (debris->velocity, 200 + crandom() * 10.0, up, debris->velocity);
				VectorMA (debris->velocity, crandom() * 10.0, right, debris->velocity);
				VectorSet (debris->avelocity, 300, 300, 300);
				debris->s.modelindex = gi.modelindex ("models/slat/debris/debris.md2");
	
				debris->s.effects |= EF_GRENADE;
				debris->s.renderfx = RF_TRANSLUCENT;

				debris->movetype = MOVETYPE_BOUNCE;
				debris->nextthink = level.time + 2;
				debris->think = G_FreeEdict;
	
				gi.linkentity (debris);
				gi.sound(debris, CHAN_WEAPON, gi.soundindex("slat/weapons/bush_hit.wav"), 1, ATTN_NORM, 0);
		*/	}
		}
	}
}

static void Weapon_Bush_Strike (edict_t *ent)//, int damage)
{
	vec3_t          start;
    vec3_t          forward, right;

    vec3_t          offset;
    int             damage = 200;
    int             kick = 100;

	ent->client->ps.gunframe++;

    AngleVectors (ent->client->v_angle, forward, right, NULL);

    VectorScale (forward, -2, ent->client->kick_origin);
    ent->client->kick_angles[0] = -2;

    VectorSet(offset, 0, 0,  ent->viewheight);
    P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	Weapon_Bush_Struck (ent, start, forward, damage, kick);
}


void Weapon_Bush (edict_t *ent)
{
	static int	pause_frames[]	= {21, 36, 0};
	static int	fire_frames[]	= {11, 0};

	if (ent->client->ps.gunframe == 10)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/bush_swing.wav"), 1, ATTN_NORM, 0);
	
	Weapon_Generic (ent, 7, 15, 40, 48, 40, 48, pause_frames, fire_frames, Weapon_Bush_Strike);
}

//GLOCK m/lyddemper og lasersikte
void Weapon_Glock_Fire (edict_t *ent)
{
	vec3_t		start;
	vec3_t		forward, right;
	int			damage = 30;
	int			kick = 130;
	vec3_t		offset;

	ent->client->ps.gunframe++;


	if (ent->client->pers.inventory[ent->client->ammo_index] < 1)
	{
		gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
		ent->pain_debounce_time = level.time + 1;
	}
	
	gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/glock_fire.wav"), 1, ATTN_STATIC, 0);

//	PlayerNoise(ent, start, PNOISE_WEAPON);//TROND 14/3 fiender merker ikkje at denna blir avfyrt

	ent->client->pers.inventory[ent->client->ammo_index]--;

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -2, ent->client->kick_origin);
	ent->client->kick_angles[0] = -2;

	VectorSet(offset, 0, 0,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	if (ent->client
		&& ent->client->ls_on)
	{
		fire_bullet (ent, start, forward, damage, kick, 10, 10, MOD_GLOCK);
	}
	else
	{
		if (ent->velocity[0] || ent->velocity[1])
		{
			if (ent->client->bleeding)
				fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_GLOCK);
			else
				fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.6, DEFAULT_BULLET_VSPREAD*1.6, MOD_GLOCK);
		}
		else if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
			fire_bullet (ent, start, forward, damage, kick, 30, 30, MOD_GLOCK);
		else
		{
			if (ent->client->bleeding)
				fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, MOD_GLOCK);
			else
				fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD/2, DEFAULT_BULLET_VSPREAD/2, MOD_GLOCK);
		}
	}

	ent->client->anim_priority = ANIM_ATTACK;
	if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		ent->s.frame = FRAME_crattak1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_crattak9;
	}
	else
	{
		ent->s.frame = FRAME_attack1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_attack8;
	}
}

void Weapon_Glock (edict_t *ent)
{
	static int	pause_frames[]	= {13};
	static int	fire_frames[]	= {10};

	if (ent->client->ps.gunframe == 40
		&& ent->client->ls_on == 1)
	{
		SP_LaserSight (ent);
		ent->client->ls_on = 0;
	}

	if (ent->client->ps.gunframe == 2)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/glock_reload2.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 45)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/glock_reload1.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 58)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/glock_reload3.wav"), 1, ATTN_NORM, 0);//TROND lyd


	Weapon_Generic (ent, 9, 12, 38, 40, 40, 64, pause_frames, fire_frames, Weapon_Glock_Fire);
}