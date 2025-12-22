#include "g_local.h"
#include "q_devels.h"

void Zylon_Grenade(edict_t *ent); 

            qboolean G_EntExists(edict_t *ent) { 
            return ((ent) && (ent->client) && (ent->inuse)); 
            } 

/*
=================
check_dodge

This is a support routine used when a client is firing
a non-instant attack weapon.  It checks to see if a
monster's dodge function should be called.
=================
*/
static void check_dodge (edict_t *self, vec3_t start, vec3_t dir, int speed)
{
	vec3_t	end;
	vec3_t	v;
	trace_t	tr;
	float	eta;

	// easy mode only ducks one quarter the time
	if (skill->value == 0)
	{
		if (random() > 0.25)
			return;
	}
	VectorMA (start, 8192, dir, end);
	tr = gi.trace (start, NULL, NULL, end, self, MASK_SHOT);
	if ((tr.ent) && (tr.ent->svflags & SVF_MONSTER) && (tr.ent->health > 0) && (tr.ent->monsterinfo.dodge) && infront(tr.ent, self))
	{
		VectorSubtract (tr.endpos, start, v);
		eta = (VectorLength(v) - tr.ent->maxs[0]) / speed;
		tr.ent->monsterinfo.dodge (tr.ent, self, eta);
	}
}


/*
=================
fire_hit

Used for all impact (hit/punch/slash) attacks
=================
*/
qboolean fire_hit (edict_t *self, vec3_t aim, int damage, int kick)
{
	trace_t		tr;
	vec3_t		forward, right, up;
	vec3_t		v;
	vec3_t		point;
	float		range;
	vec3_t		dir;

	//see if enemy is in range
	VectorSubtract (self->enemy->s.origin, self->s.origin, dir);
	range = VectorLength(dir);
	if (range > aim[0])
		return false;

	if (aim[1] > self->mins[0] && aim[1] < self->maxs[0])
	{
		// the hit is straight on so back the range up to the edge of their bbox
		range -= self->enemy->maxs[0];
	}
	else
	{
		// this is a side hit so adjust the "right" value out to the edge of their bbox
		if (aim[1] < 0)
			aim[1] = self->enemy->mins[0];
		else
			aim[1] = self->enemy->maxs[0];
	}

	VectorMA (self->s.origin, range, dir, point);

	tr = gi.trace (self->s.origin, NULL, NULL, point, self, MASK_SHOT);
	if (tr.fraction < 1)
	{
		if (!tr.ent->takedamage)
			return false;
		// if it will hit any client/monster then hit the one we wanted to hit
		if ((tr.ent->svflags & SVF_MONSTER) || (tr.ent->client))
			tr.ent = self->enemy;
	}

	AngleVectors(self->s.angles, forward, right, up);
	VectorMA (self->s.origin, range, forward, point);
	VectorMA (point, aim[1], right, point);
	VectorMA (point, aim[2], up, point);
	VectorSubtract (point, self->enemy->s.origin, dir);

	// do the damage
	T_Damage (tr.ent, self, self, dir, point, vec3_origin, damage, kick/2, DAMAGE_NO_KNOCKBACK, MOD_HIT);

	if (!(tr.ent->svflags & SVF_MONSTER) && (!tr.ent->client))
		return false;

	// do our special form of knockback here
	VectorMA (self->enemy->absmin, 0.5, self->enemy->size, v);
	VectorSubtract (v, point, v);
	VectorNormalize (v);
	VectorMA (self->enemy->velocity, kick, v, self->enemy->velocity);
	if (self->enemy->velocity[2] > 0)
		self->enemy->groundentity = NULL;
	return true;
}


/*
=================
fire_lead

This is an internal support routine used for bullet/pellet based weapons.
=================
*/
static void fire_lead (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int kick, int te_impact, int hspread, int vspread, int mod)
{
	trace_t		tr;
	vec3_t		dir;
	vec3_t		forward, right, up;
	vec3_t		end;
	float		r;
	float		u;
	vec3_t		water_start;
	qboolean	water = false;
	int			content_mask = MASK_SHOT | MASK_WATER;

	tr = gi.trace (self->s.origin, NULL, NULL, start, self, MASK_SHOT);
	if (!(tr.fraction < 1.0))
	{
		vectoangles (aimdir, dir);
		AngleVectors (dir, forward, right, up);

		r = crandom()*hspread;
		u = crandom()*vspread;
		VectorMA (start, 8192, forward, end);
		VectorMA (end, r, right, end);
		VectorMA (end, u, up, end);

		if (gi.pointcontents (start) & MASK_WATER)
		{
			water = true;
			VectorCopy (start, water_start);
			content_mask &= ~MASK_WATER;
		}

		tr = gi.trace (start, NULL, NULL, end, self, content_mask);

		// see if we hit water
		if (tr.contents & MASK_WATER)
		{
			int		color;

			water = true;
			VectorCopy (tr.endpos, water_start);

			if (!VectorCompare (start, tr.endpos))
			{
				if (tr.contents & CONTENTS_WATER)
				{
					if (strcmp(tr.surface->name, "*brwater") == 0)
						color = SPLASH_BROWN_WATER;
					else
						color = SPLASH_BLUE_WATER;
				}
				else if (tr.contents & CONTENTS_SLIME)
					color = SPLASH_SLIME;
				else if (tr.contents & CONTENTS_LAVA)
					color = SPLASH_LAVA;
				else
					color = SPLASH_UNKNOWN;

				if (color != SPLASH_UNKNOWN)
				{
					gi.WriteByte (svc_temp_entity);
					gi.WriteByte (TE_SPLASH);
					gi.WriteByte (8);
					gi.WritePosition (tr.endpos);
					gi.WriteDir (tr.plane.normal);
					gi.WriteByte (color);
					gi.multicast (tr.endpos, MULTICAST_PVS);
				}

				// change bullet's course when it enters water
				VectorSubtract (end, start, dir);
				vectoangles (dir, dir);
				AngleVectors (dir, forward, right, up);
				r = crandom()*hspread*2;
				u = crandom()*vspread*2;
				VectorMA (water_start, 8192, forward, end);
				VectorMA (end, r, right, end);
				VectorMA (end, u, up, end);
			}

			// re-trace ignoring water this time
			tr = gi.trace (water_start, NULL, NULL, end, self, MASK_SHOT);
		}
	}

	// send gun puff / flash
	if (!((tr.surface) && (tr.surface->flags & SURF_SKY)))
	{
		if (tr.fraction < 1.0)
		{
			if (tr.ent->takedamage)
			{
				T_Damage (tr.ent, self, self, aimdir, tr.endpos, tr.plane.normal, damage, kick, DAMAGE_BULLET, mod);
			}
			else
			{
				if (strncmp (tr.surface->name, "sky", 3) != 0)
				{
					gi.WriteByte (svc_temp_entity);
					gi.WriteByte (te_impact);
					gi.WritePosition (tr.endpos);
					gi.WriteDir (tr.plane.normal);
					gi.multicast (tr.endpos, MULTICAST_PVS);

					if (self->client)
						PlayerNoise(self, tr.endpos, PNOISE_IMPACT);
				}
			}
		}
	}

	// if went through water, determine where the end and make a bubble trail
	if (water)
	{
		vec3_t	pos;

		VectorSubtract (tr.endpos, water_start, dir);
		VectorNormalize (dir);
		VectorMA (tr.endpos, -2, dir, pos);
		if (gi.pointcontents (pos) & MASK_WATER)
			VectorCopy (pos, tr.endpos);
		else
			tr = gi.trace (pos, NULL, NULL, water_start, tr.ent, MASK_WATER);

		VectorAdd (water_start, tr.endpos, pos);
		VectorScale (pos, 0.5, pos);

		gi.WriteByte (svc_temp_entity);
		gi.WriteByte (TE_BUBBLETRAIL);
		gi.WritePosition (water_start);
		gi.WritePosition (tr.endpos);
		gi.multicast (pos, MULTICAST_PVS);
	}
}


/*
=================
fire_bullet

Fires a single round.  Used for machinegun and chaingun.  Would be fine for
pistols, rifles, etc....
=================
*/
void fire_bullet (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int kick, int hspread, int vspread, int mod)
{
	fire_lead (self, start, aimdir, damage, kick, TE_GUNSHOT, hspread, vspread, mod);
}


/*
=================
fire_shotgun

Shoots shotgun pellets.  Used by shotgun and super shotgun.
=================
*/
void fire_shotgun (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int kick, int hspread, int vspread, int count, int mod)
{
	int		i;

	for (i = 0; i < count; i++)
		fire_lead (self, start, aimdir, damage, kick, TE_SHOTGUN, hspread, vspread, mod);
}


/*
=================
fire_blaster

Fires a single blaster bolt.  Used by the blaster and hyper blaster.
=================
*/
void blaster_touch (edict_t *self, edict_t *other, cplane_t *plane, csurface_t *surf)
{
	int		mod;

	if (other == self->owner)
		return;

	if (surf && (surf->flags & SURF_SKY))
	{
		G_FreeEdict (self);
		return;
	}

	if (self->owner->client)
		PlayerNoise(self->owner, self->s.origin, PNOISE_IMPACT);

	if (other->takedamage)
	{
		if (self->spawnflags & 1)
			mod = MOD_HYPERBLASTER;
		else
			mod = MOD_BLASTER;
		T_Damage (other, self, self->owner, self->velocity, self->s.origin, plane->normal, self->dmg, 1, DAMAGE_ENERGY, mod);
	}
	else
	{
		return;
		gi.WriteByte (svc_temp_entity);
		gi.WriteByte (TE_BLASTER);
		gi.WritePosition (self->s.origin);
		if (!plane)
			gi.WriteDir (vec3_origin);
		else
			gi.WriteDir (plane->normal);
		gi.multicast (self->s.origin, MULTICAST_PVS);
	}

	G_FreeEdict (self);
}


void fire_blaster (edict_t *self, vec3_t start, vec3_t dir, int damage, int speed, int effect, qboolean hyper)
{
	edict_t	*bolt;
	trace_t	tr;
	VectorNormalize (dir);

	bolt = G_Spawn();
	VectorCopy (start, bolt->s.origin);
	VectorCopy (start, bolt->s.old_origin);
	vectoangles (dir, bolt->s.angles);
	VectorScale (dir, speed, bolt->velocity);
        bolt->movetype = MOVETYPE_FLYRICOCHET;
	bolt->clipmask = MASK_SHOT;
	bolt->solid = SOLID_BBOX;
	bolt->s.effects |= effect;
	VectorClear (bolt->mins);
	VectorClear (bolt->maxs);
	bolt->s.modelindex = gi.modelindex ("models/objects/laser/tris.md2");
	bolt->s.sound = gi.soundindex ("misc/lasfly.wav");
	bolt->owner = self;
	bolt->touch = blaster_touch;
	bolt->nextthink = level.time + 2;
	bolt->think = G_FreeEdict;
	bolt->dmg = damage;
	bolt->classname = "bolt";
	if (hyper)
		bolt->spawnflags = 1;
	gi.linkentity (bolt);

	if (self->client)
		check_dodge (self, bolt->s.origin, dir, speed);

	tr = gi.trace (self->s.origin, NULL, NULL, bolt->s.origin, bolt, MASK_SHOT);
	if (tr.fraction < 1.0)
	{
		VectorMA (bolt->s.origin, -10, dir, bolt->s.origin);
		bolt->touch (bolt, tr.ent, NULL, NULL);
	}
}	

static void Cluster_Explode (edict_t *ent)
{
	vec3_t		origin;

	//Sean added these 4 vectors

	vec3_t   grenade1;
	vec3_t   grenade2;
	vec3_t   grenade3;
	vec3_t   grenade4;
        vec3_t   grenade5;

	if (ent->owner->client)
		PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

	//FIXME: if we are onground then raise our Z just a bit since we are a point?
   
     T_RadiusDamage(ent, ent->owner, ent->dmg, ent->enemy, ent->dmg_radius, MOD_HELD_GRENADE);

	VectorMA (ent->s.origin, -0.02, ent->velocity, origin);
	gi.WriteByte (svc_temp_entity);
	if (ent->waterlevel)
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION_WATER);
		else
			gi.WriteByte (TE_ROCKET_EXPLOSION_WATER);
	}
	else
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION);
		else
                        gi.WriteByte (TE_ROCKET_EXPLOSION);
	}
	gi.WritePosition (origin);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	// SumFuka did this bit : give grenades up/outwards velocities
        VectorSet(grenade1,20,20,40);
        VectorSet(grenade2,20,-20,40);
        VectorSet(grenade3,-20,20,40);
        VectorSet(grenade4,-20, -20,40);
        VectorSet(grenade5,0,0,40);

        fire_grenade2(ent->owner, origin, grenade1, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade2, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade3, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade4, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade5, 120, 10, 1.8, 120, 140);
	G_FreeEdict (ent);
}

static void LaserBomb_Explode (edict_t *ent)
{
	vec3_t		origin;


	vec3_t   grenade1;
	vec3_t   grenade2;
	vec3_t   grenade3;
	vec3_t   grenade4;
        vec3_t   grenade5;
        vec3_t   grenade6;
        vec3_t   grenade7;
        vec3_t   grenade8;
        vec3_t   grenade9;
        vec3_t   grenade10;

        vec3_t   grenade11;
        vec3_t   grenade12;
        vec3_t   grenade13;
        vec3_t   grenade14;
        vec3_t   grenade15;
        vec3_t   grenade16;

	if (ent->owner->client)
		PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

	//FIXME: if we are onground then raise our Z just a bit since we are a point?
     T_RadiusDamage(ent, ent->owner, ent->dmg, ent->enemy, ent->dmg_radius, MOD_HELD_GRENADE);

	VectorMA (ent->s.origin, -0.02, ent->velocity, origin);
	gi.WriteByte (svc_temp_entity);
	if (ent->waterlevel)
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION_WATER);
		else
			gi.WriteByte (TE_ROCKET_EXPLOSION_WATER);
	}
	else
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION);
		else
                        gi.WriteByte (TE_ROCKET_EXPLOSION);
	}
	gi.WritePosition (origin);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

        VectorSet(grenade1,20,20,20);
        VectorSet(grenade2,20,-20,20);
        VectorSet(grenade3,-20,20,20);
        VectorSet(grenade4,-20,-20,20);
        VectorSet(grenade5,0,20,20);
        VectorSet(grenade6,0,-20,20);
        VectorSet(grenade7,20,0,20);
        VectorSet(grenade8,-20,0,20);
        VectorSet(grenade9,15,20,15);
        VectorSet(grenade10,25,-30,20);
        VectorSet(grenade11,-10,30,20);
        VectorSet(grenade12,-23,-40,10);
        VectorSet(grenade13,42,24,30);
        VectorSet(grenade14,30,-15,40);
        VectorSet(grenade15,20,15,10);
        VectorSet(grenade16,-15,0,5);

        fire_blaster (ent->owner, origin, grenade1, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade2, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade3, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade4, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade5, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade6, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade7, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade8, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade11, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade12, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade13, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade14, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade15, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade16, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade9, 30, 2000, EF_BLASTER, false);
        fire_blaster (ent->owner, origin, grenade10, 30, 2000, EF_BLASTER, false);

	G_FreeEdict (ent);
}





static void Mirv_Explode (edict_t *ent)
{
	vec3_t		origin;

	//Sean added these 4 vectors

	vec3_t   grenade1;
	vec3_t   grenade2;
	vec3_t   grenade3;
	vec3_t   grenade4;
        vec3_t   grenade5;
        vec3_t   grenade6;
        vec3_t   grenade7;
        vec3_t   grenade8;
        vec3_t   grenade9;
        vec3_t   grenade10;

	if (ent->owner->client)
		PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

	//FIXME: if we are onground then raise our Z just a bit since we are a point?
     T_RadiusDamage(ent, ent->owner, ent->dmg, ent->enemy, ent->dmg_radius, MOD_HELD_GRENADE);

	VectorMA (ent->s.origin, -0.02, ent->velocity, origin);
	gi.WriteByte (svc_temp_entity);
	if (ent->waterlevel)
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION_WATER);
		else
			gi.WriteByte (TE_ROCKET_EXPLOSION_WATER);
	}
	else
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION);
		else
			gi.WriteByte (TE_ROCKET_EXPLOSION);
	}
	gi.WritePosition (origin);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	// SumFuka did this bit : give grenades up/outwards velocities
	VectorSet(grenade1,20,20,40);
	VectorSet(grenade2,20,-20,40);
	VectorSet(grenade3,-20,20,40);
	VectorSet(grenade4,-20,-20,40);
        VectorSet(grenade5,0,0,40);
        VectorSet(grenade6,40,40,60);
        VectorSet(grenade7,40,-40,60);
        VectorSet(grenade8,-40,40,60);
        VectorSet(grenade9,-40,-40,60);
        VectorSet(grenade10,0,0,60);

	// Sean : explode the four grenades outwards
        fire_grenade2(ent->owner, origin, grenade1, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade2, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade3, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade4, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade5, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade6, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade7, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade8, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade9, 120, 10, 1.8, 120, 140);
        fire_grenade2(ent->owner, origin, grenade10, 120, 10, 1.8, 120, 140);

	G_FreeEdict (ent);
}



/*
=================
fire_grenade
=================
*/
void Grenade_Explode (edict_t *ent)
{
	vec3_t		origin;

	int			mod;

            // Zylon Grenades only if activated by real Player.. 
            if (G_EntExists(ent->owner)) 
            if (ent->owner->client->pers.class == 10)
            if (ent->owner->client->pers.grenadevalue == 1) {
            ent->Zylon_timer = level.time+10+(random()*10);
            Zylon_Grenade(ent); 
            return; } 

	if (ent->owner->client)
		PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

	//FIXME: if we are onground then raise our Z just a bit since we are a point?
	if (ent->enemy)
	{
		float	points;
		vec3_t	v;
		vec3_t	dir;

		VectorAdd (ent->enemy->mins, ent->enemy->maxs, v);
		VectorMA (ent->enemy->s.origin, 0.5, v, v);
		VectorSubtract (ent->s.origin, v, v);
		points = ent->dmg - 0.5 * VectorLength (v);
		VectorSubtract (ent->enemy->s.origin, ent->s.origin, dir);
		if (ent->spawnflags & 1)
			mod = MOD_HANDGRENADE;
		else
			mod = MOD_GRENADE;
                if (ent->classname == "detpack") mod = MOD_DETPACK;
                T_Damage (ent->enemy, ent, ent->owner, dir, ent->s.origin, vec3_origin, (int)points, (int)points, DAMAGE_RADIUS, mod);
	}

	if (ent->spawnflags & 2)
		mod = MOD_HELD_GRENADE;
	else if (ent->spawnflags & 1)
		mod = MOD_HG_SPLASH;
	else
		mod = MOD_G_SPLASH;
                if (ent->classname == "detpack") mod = MOD_DETPACK;
	T_RadiusDamage(ent, ent->owner, ent->dmg, ent->enemy, ent->dmg_radius, mod);

	VectorMA (ent->s.origin, -0.02, ent->velocity, origin);
	gi.WriteByte (svc_temp_entity);
	if (ent->waterlevel)
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION_WATER);
		else
			gi.WriteByte (TE_ROCKET_EXPLOSION_WATER);
	}
	else
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION);
		else
			gi.WriteByte (TE_ROCKET_EXPLOSION);
	}
	gi.WritePosition (origin);
	gi.multicast (ent->s.origin, MULTICAST_PHS);

	G_FreeEdict (ent);
}
void Napalm_Burn (edict_t *ent)
{
		float	points;
		vec3_t	v;
		vec3_t	dir;
	int			mod;

//if (ent->napalmtime < level.time)
//       G_FreeEdict (ent);


		VectorAdd (ent->enemy->mins, ent->enemy->maxs, v);
		VectorMA (ent->enemy->s.origin, 0.5, v, v);
		VectorSubtract (ent->s.origin, v, v);
                ent->dmg = 5;
                //points = ent->dmg - 0.5 * VectorLength (v);
                points = ent->dmg;
                VectorSubtract (ent->enemy->s.origin, ent->enemy->s.origin, dir);
                mod = MOD_NAPALM;
                T_Damage (ent->enemy, ent, ent->owner, dir, ent->s.origin, vec3_origin, (int)points, (int)points, DAMAGE_ENERGY, mod);

        ent->think = Napalm_Burn;
        ent->nextthink = 1;

}
void Napalm_Explode (edict_t *ent)
{
                edict_t *blip;
                edict_t *napalm;
	vec3_t		origin;

	int			mod;


	if (ent->owner->client)
		PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

	//FIXME: if we are onground then raise our Z just a bit since we are a point?
	if (ent->enemy)
	{
		float	points;
		vec3_t	v;
		vec3_t	dir;

		VectorAdd (ent->enemy->mins, ent->enemy->maxs, v);
		VectorMA (ent->enemy->s.origin, 0.5, v, v);
		VectorSubtract (ent->s.origin, v, v);
		points = ent->dmg - 0.5 * VectorLength (v);
                ent->dmg += -20;
                VectorSubtract (ent->enemy->s.origin, ent->s.origin, dir);
                mod = MOD_NAPALM;
                T_Damage (ent->enemy, ent, ent->owner, dir, ent->s.origin, vec3_origin, (int)points, (int)points, DAMAGE_RADIUS, mod);
       // centerprint_all("LOPPUUN PAAS\n");
        }

	if (ent->spawnflags & 2)
		mod = MOD_HELD_GRENADE;
	else if (ent->spawnflags & 1)
		mod = MOD_HG_SPLASH;
	else
		mod = MOD_G_SPLASH;

  /*
        while ((blip = findradius(blip, ent->s.origin, 220)) != NULL)
       {

               if (!blip->client)
                       continue;
//centerprint_all("---<<< muttei mee tasta >>>---\n");
               if (!blip->takedamage)
                       continue;
               if (blip->health <= 0)
                       continue;
    //           if (!visible(ent, blip))
    //                   continue;

        napalm = G_Spawn();
        napalm->napalmtime += (ent->napalmtime * 5) + level.time;
        napalm->enemy = blip;
        napalm->owner = ent->owner;
        napalm->think = Napalm_Burn;
        napalm->nextthink = 1;

//               break;
       }
*/
        T_RadiusDamage(ent, ent->owner, ent->dmg, ent->enemy, ent->dmg_radius, mod);


        VectorMA (ent->s.origin, -0.02, ent->velocity, origin);
	gi.WriteByte (svc_temp_entity);
	if (ent->waterlevel)
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION_WATER);
		else
			gi.WriteByte (TE_ROCKET_EXPLOSION_WATER);
	}
	else
	{
		if (ent->groundentity)
			gi.WriteByte (TE_GRENADE_EXPLOSION);
		else
			gi.WriteByte (TE_ROCKET_EXPLOSION);
	}
	gi.WritePosition (origin);
	gi.multicast (ent->s.origin, MULTICAST_PHS);

       if (ent->napalmtime > level.time) {
       ent->nextthink = level.time + 1.5;
       ent->think = Napalm_Explode;
       }
       else
       G_FreeEdict (ent);
       
}

static void EMP_Explode (edict_t *ent)
{
	vec3_t		origin;

	int			mod;

	if (ent->owner->client)
		PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

	//FIXME: if we are onground then raise our Z just a bit since we are a point?
	if (ent->enemy)
	{
		float	points;
		vec3_t	v;
		vec3_t	dir;

		VectorAdd (ent->enemy->mins, ent->enemy->maxs, v);
		VectorMA (ent->enemy->s.origin, 0.5, v, v);
		VectorSubtract (ent->s.origin, v, v);
		points = ent->dmg - 0.5 * VectorLength (v);
		VectorSubtract (ent->enemy->s.origin, ent->s.origin, dir);
		if (ent->spawnflags & 1)
			mod = MOD_HANDGRENADE;
		else
			mod = MOD_GRENADE;
		T_Damage (ent->enemy, ent, ent->owner, dir, ent->s.origin, vec3_origin, (int)points, (int)points, DAMAGE_RADIUS, mod);
	}

	if (ent->spawnflags & 2)
		mod = MOD_HELD_GRENADE;
	else if (ent->spawnflags & 1)
		mod = MOD_HG_SPLASH;
	else
		mod = MOD_G_SPLASH;
        T_RadiusDamage(ent, ent->owner, 175, ent->enemy, 1500, mod);

	VectorMA (ent->s.origin, -0.02, ent->velocity, origin);
	gi.WriteByte (svc_temp_entity);
	if (ent->waterlevel)
	{
		if (ent->groundentity)
                        gi.WriteByte (TE_BFG_BIGEXPLOSION);
		else
                        gi.WriteByte (TE_BFG_BIGEXPLOSION);
	}
	else
	{
		if (ent->groundentity)
                        gi.WriteByte (TE_BFG_BIGEXPLOSION);
		else
                        gi.WriteByte (TE_BFG_BIGEXPLOSION);
	}
	gi.WritePosition (origin);
	gi.multicast (ent->s.origin, MULTICAST_PHS);

	G_FreeEdict (ent);
}





static void Grenade_Touch (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf)
{
	if (other == ent->owner)
		return;

	if (surf && (surf->flags & SURF_SKY))
	{
		G_FreeEdict (ent);
		return;
	}

	if (!other->takedamage)
	{
		if (ent->spawnflags & 1)
		{
			if (random() > 0.5)
				gi.sound (ent, CHAN_VOICE, gi.soundindex ("weapons/hgrenb1a.wav"), 1, ATTN_NORM, 0);
			else
				gi.sound (ent, CHAN_VOICE, gi.soundindex ("weapons/hgrenb2a.wav"), 1, ATTN_NORM, 0);
		}
		else
		{
			gi.sound (ent, CHAN_VOICE, gi.soundindex ("weapons/grenlb1b.wav"), 1, ATTN_NORM, 0);
		}
		return;
	}

	ent->enemy = other;
	Grenade_Explode (ent);
}

static void Concussion_Touch (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf)
{
	if (other == ent->owner)
		return;

	if (surf && (surf->flags & SURF_SKY))
	{
		G_FreeEdict (ent);
		return;
	}

	if (!other->takedamage)
	{
		if (ent->spawnflags & 1)
		{
			if (random() > 0.5)
				gi.sound (ent, CHAN_VOICE, gi.soundindex ("weapons/hgrenb1a.wav"), 1, ATTN_NORM, 0);
			else
				gi.sound (ent, CHAN_VOICE, gi.soundindex ("weapons/hgrenb2a.wav"), 1, ATTN_NORM, 0);
		}
		else
		{
			gi.sound (ent, CHAN_VOICE, gi.soundindex ("weapons/grenlb1b.wav"), 1, ATTN_NORM, 0);
		}
		return;
	}

	ent->enemy = other;
        Concussion_Explode (ent);
}


        #define         FLASH_RADIUS                    200
        #define         BLIND_FLASH                     50      // Time of blindness in FRAMES
        
        void Flash_Explode (edict_t *ent)
        {
                vec3_t      offset, origin;
                edict_t *target;

                // Move it off the ground so people are sure to see it
                VectorSet(offset, 0, 0, 10);    
                VectorAdd(ent->s.origin, offset, ent->s.origin);

                if (ent->owner->client)
                        PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

                target = NULL;
                while ((target = findradius(target, ent->s.origin, FLASH_RADIUS)) != NULL)
                {
                        if (target == ent->owner)
                                continue;       // You know when to close your eyes, don't you?
                        if (!target->client)
                                continue;       // It's not a player
                        if (!visible(ent, target))
                                continue;       // The grenade can't see it
                        if (!infront(target, ent))
                                continue;       // It's not facing it

                        // Increment the blindness counter
                      target->client->blindTime += BLIND_FLASH * 1.5;
                      target->client->blindBase = BLIND_FLASH;

                        // Let the player know what just happened
                        // (It's just as well, he won't see the message immediately!)
                      gi.cprintf(target, PRINT_HIGH, 
                                "You are blinded by a flash grenade!!!\n");

                        // Let the owner of the grenade know it worked
                      gi.cprintf(ent->owner, PRINT_HIGH, 
                                "%s is blinded by your flash grenade!\n",
                                target->client->pers.netname);
                }

                // Blow up the grenade
                BecomeExplosion1(ent);
        }

        void Flash_Touch (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf)
        {
                if (other == ent->owner)
                        return;

                // If it goes in to orbit, it's gone...
                if (surf && (surf->flags & SURF_SKY))
                {
                        G_FreeEdict (ent);
                        return;
                }

                // All this does is make the bouncing noises when it hits something...
                if (!other->takedamage)
                {
                        if (ent->spawnflags & 1)
                        {
                                if (random() > 0.5)
                                        gi.sound (ent, CHAN_VOICE, gi.soundindex("weapons/hgrenb1a.wav"),
                                                1, ATTN_NORM, 0);
                                else
                                        gi.sound (ent, CHAN_VOICE, gi.soundindex("weapons/hgrenb2a.wav"),
                                                1, ATTN_NORM, 0);
                        }
                        else
                                gi.sound (ent, CHAN_VOICE, gi.soundindex("weapons/grenlb1b.wav"),
                                        1, ATTN_NORM, 0);
                        }
                        return;
                }




/*
===========================
Concussion Grenades
===========================
*/
void Concussion_Explode (edict_t *ent)
   {
     vec3_t      offset,v;
     edict_t *target;
     float Distance, DrunkTimeAdd;

    // Move it off the ground so people are sure to see it
    VectorSet(offset, 0, 0, 10);    
    VectorAdd(ent->s.origin, offset, ent->s.origin);

    if (ent->owner->client)
       PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

    target = NULL;
    while ((target = findradius(target, ent->s.origin, 520)) != NULL)
    {
        if (!target->client)
            continue;       // It's not a player
        if (!visible(ent, target))
            continue;       // The grenade can't see it
		// Find distance
		VectorSubtract(ent->s.origin, target->s.origin, v);
		Distance = VectorLength(v);
		// Calculate drunk factor
		if(Distance < 520/10)
                        DrunkTimeAdd = 10; //completely drunk
        else
            DrunkTimeAdd = 1.5 * 10 * ( 1 / ( ( Distance - 520*2 ) / (520*2) - 2 ) + 1 ); //partially drunk
        if ( DrunkTimeAdd < 0 )
            DrunkTimeAdd = 0; // Do not make drunk at all.
    
        // Increment the drunk time
        if(target->DrunkTime < level.time)
			target->DrunkTime = DrunkTimeAdd+level.time;
		else
			target->DrunkTime += DrunkTimeAdd;               
	}

   // Blow up the grenade
   BecomeExplosion1(ent);
}

static void proxim_think (edict_t *ent)
{
       edict_t *blip = NULL;

       if (level.time > ent->delay)
       {
               Concussion_Explode(ent);
               return;
       }
 
       ent->think = proxim_think;
       while ((blip = findradius(blip, ent->s.origin, 100)) != NULL)
       {
               if (!(blip->svflags & SVF_MONSTER) && !blip->client)
                       continue;
               if (blip == ent->owner)
                       continue;
               if (!blip->takedamage)
                       continue;
               if (blip->health <= 0)
                       continue;
               if (!visible(ent, blip))
                       continue;
               if (blip->tw_team == ent->tw_team)
                       continue;
               ent->think = Concussion_Explode;
               break;
       }

       ent->nextthink = level.time + .1;
}


static void flare_think (edict_t *ent)
{
       edict_t *blip = NULL;
	ent->s.effects |= EF_HYPERBLASTER;	//Lots of fun with green lights
	ent->s.effects |= EF_COLOR_SHELL; 	//Green shell... fun!

              ent->s.renderfx |= RF_SHELL_GREEN;      //It's a GREEN shell!!!

       if (level.time > ent->delay)
       {
		G_FreeEdict (ent);
                return;
       }
       ent->nextthink = level.time + .1;
}



void fire_concussiongrenade (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int speed, float timer, float damage_radius)
{
	edict_t	*grenade;
	vec3_t	dir;
	vec3_t	forward, right, up;

	vectoangles (aimdir, dir);
	AngleVectors (dir, forward, right, up);

	grenade = G_Spawn();
	VectorCopy (start, grenade->s.origin);
	VectorScale (aimdir, speed, grenade->velocity);
	VectorMA (grenade->velocity, 200 + crandom() * 30.0, up, grenade->velocity);
	VectorMA (grenade->velocity, crandom() * 10.0, right, grenade->velocity);
	VectorSet (grenade->avelocity, 300, 300, 300);
	grenade->movetype = MOVETYPE_BOUNCE;
	grenade->clipmask = MASK_SHOT;
	grenade->solid = SOLID_BBOX;
	grenade->s.effects |= EF_GRENADE;
	VectorClear (grenade->mins);
	VectorClear (grenade->maxs);
	grenade->s.modelindex = gi.modelindex ("models/objects/grenade/tris.md2");
	grenade->owner = self;
	grenade->touch = Grenade_Touch; //Stuff for cluster grenades when they explode
	grenade->nextthink = level.time + timer;
        grenade->think = Concussion_Explode; //stuff for cluster grenades exploding
	grenade->dmg = damage;
	grenade->dmg_radius = damage_radius;
	grenade->classname = "concussion";
	VectorSet(grenade->mins, -3, -3, 0);
	VectorSet(grenade->maxs, 3, 3, 6);
	grenade->mass = 2;
	grenade->health = 10;
     //   grenade->die = Grenade_Die;
	grenade->takedamage = DAMAGE_YES;
	grenade->monsterinfo.aiflags = AI_NOSTEP;

	gi.linkentity (grenade);
}

void fire_clustergrenade (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int speed, float timer, float damage_radius)
{
	edict_t	*grenade;
	vec3_t	dir;
	vec3_t	forward, right, up;

	vectoangles (aimdir, dir);
	AngleVectors (dir, forward, right, up);

	grenade = G_Spawn();
	VectorCopy (start, grenade->s.origin);
	VectorScale (aimdir, speed, grenade->velocity);
	VectorMA (grenade->velocity, 200 + crandom() * 10.0, up, grenade->velocity);
	VectorMA (grenade->velocity, crandom() * 10.0, right, grenade->velocity);
	VectorSet (grenade->avelocity, 300, 300, 300);
	grenade->movetype = MOVETYPE_BOUNCE;
	grenade->clipmask = MASK_SHOT;
	grenade->solid = SOLID_BBOX;
	grenade->s.effects |= EF_GRENADE;
	VectorClear (grenade->mins);
	VectorClear (grenade->maxs);
	grenade->s.modelindex = gi.modelindex ("models/objects/grenade/tris.md2");
	grenade->owner = self;
	grenade->touch = Grenade_Touch;
	grenade->nextthink = level.time + timer;
        //grenade->think = Grenade_Explode;
        grenade->GrenadeVal = 0;
	grenade->classname = "grenade";
        grenade->tw_team = self->tw_team;
        grenade->think = Cluster_Explode;
        grenade->dmg = damage;
	grenade->dmg_radius = damage_radius;
	gi.linkentity (grenade);
}

void fire_napalmgrenade (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int speed, float timer, float damage_radius)
{
	edict_t	*grenade;
	vec3_t	dir;
	vec3_t	forward, right, up;

	vectoangles (aimdir, dir);
	AngleVectors (dir, forward, right, up);

	grenade = G_Spawn();
	VectorCopy (start, grenade->s.origin);
	VectorScale (aimdir, speed, grenade->velocity);
	VectorMA (grenade->velocity, 200 + crandom() * 10.0, up, grenade->velocity);
	VectorMA (grenade->velocity, crandom() * 10.0, right, grenade->velocity);
	VectorSet (grenade->avelocity, 300, 300, 300);
	grenade->movetype = MOVETYPE_BOUNCE;
	grenade->clipmask = MASK_SHOT;
	grenade->solid = SOLID_BBOX;
	grenade->s.effects |= EF_GRENADE;
	VectorClear (grenade->mins);
	VectorClear (grenade->maxs);
	grenade->s.modelindex = gi.modelindex ("models/objects/grenade/tris.md2");
	grenade->owner = self;
	grenade->touch = Grenade_Touch;
	grenade->nextthink = level.time + timer;
        grenade->napalmtime = level.time + timer + 10;
        //grenade->think = Grenade_Explode;
        grenade->GrenadeVal = 0;
	grenade->classname = "grenade";
        grenade->tw_team = self->tw_team;
        grenade->think = Napalm_Explode;
        grenade->dmg = damage;
	grenade->dmg_radius = damage_radius;
	gi.linkentity (grenade);
}


void fire_grenade (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int speed, float timer, float damage_radius)
{
	edict_t	*grenade;
	vec3_t	dir;
	vec3_t	forward, right, up;

	vectoangles (aimdir, dir);
	AngleVectors (dir, forward, right, up);

	grenade = G_Spawn();
	VectorCopy (start, grenade->s.origin);
	VectorScale (aimdir, speed, grenade->velocity);
	VectorMA (grenade->velocity, 200 + crandom() * 10.0, up, grenade->velocity);
	VectorMA (grenade->velocity, crandom() * 10.0, right, grenade->velocity);
	VectorSet (grenade->avelocity, 300, 300, 300);
	grenade->movetype = MOVETYPE_BOUNCE;
	grenade->clipmask = MASK_SHOT;
	grenade->solid = SOLID_BBOX;
	grenade->s.effects |= EF_GRENADE;
	VectorClear (grenade->mins);
	VectorClear (grenade->maxs);
	grenade->s.modelindex = gi.modelindex ("models/objects/grenade/tris.md2");
	grenade->owner = self;
	grenade->touch = Grenade_Touch;
	grenade->nextthink = level.time + timer;
        grenade->think = Grenade_Explode;
        grenade->GrenadeVal = 0;
	grenade->classname = "grenade";
        grenade->tw_team = self->tw_team;
        if (!self->mounted) {
        if (self->client->pers.grenadevalue == 2)
        {
        grenade->touch = NULL;
        grenade->think = Mirv_Explode;
        }
        if (self->client->pers.grenadevalue == 1)
        {
        grenade->touch = NULL;
        grenade->think = Cluster_Explode;
        }
        if (self->client->pers.grenadevalue == 3) {
        grenade->nextthink = level.time + 60;
        grenade->classname = "detpipe";
        grenade->touch = NULL;
        }
        }
        grenade->dmg = damage;
	grenade->dmg_radius = damage_radius;
	gi.linkentity (grenade);
}


void fire_grenade2 (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int speed, float timer, float damage_radius, qboolean held)
{
	edict_t	*grenade;
	vec3_t	dir;
	vec3_t	forward, right, up;

	vectoangles (aimdir, dir);
	AngleVectors (dir, forward, right, up);

	grenade = G_Spawn();
	VectorCopy (start, grenade->s.origin);
	VectorScale (aimdir, speed, grenade->velocity);
	VectorMA (grenade->velocity, 200 + crandom() * 10.0, up, grenade->velocity);
	VectorMA (grenade->velocity, crandom() * 10.0, right, grenade->velocity);
	VectorSet (grenade->avelocity, 300, 300, 300);
	grenade->movetype = MOVETYPE_BOUNCE;
	grenade->clipmask = MASK_SHOT;
	grenade->solid = SOLID_BBOX;
	grenade->s.effects |= EF_GRENADE;
	VectorClear (grenade->mins);
	VectorClear (grenade->maxs);
	grenade->s.modelindex = gi.modelindex ("models/objects/grenade2/tris.md2");
	grenade->owner = self;
        grenade->tw_team = self->tw_team;
        grenade->touch = Grenade_Touch;
	grenade->nextthink = level.time + timer;
        grenade->think = Grenade_Explode;

	if (held)
		grenade->spawnflags = 3;
	else
		grenade->spawnflags = 1;
	grenade->s.sound = gi.soundindex("weapons/hgrenc1b.wav");


        if (grenade->owner->classname == "grenade")
        {
        }
        else
        {
        if (self->client->pers.class == 1) 
        {
        if (self->client->pers.grenadevalue == 1) {
        grenade->think = Concussion_Explode;
        grenade->touch = Concussion_Touch;
        }
        if (self->client->pers.grenadevalue == 2)
        {
        grenade->nextthink = level.time + 1;
        grenade->think = proxim_think;
        grenade->delay = level.time + 60;
        grenade->s.sound = gi.soundindex("");
        grenade->touch = Concussion_Touch;
        }
        }

        if (self->client->pers.class == 2)
        {
        if (self->client->pers.grenadevalue == 1) {
        grenade->touch = NULL;
        grenade->nextthink = level.time + 1;
        grenade->think = flare_think;
        grenade->delay = level.time + 60;
        grenade->s.effects |= EF_FLAG2 | EF_COLOR_SHELL;
        grenade->s.renderfx |= RF_SHELL_RED;
        grenade->s.sound = gi.soundindex("");
        grenade->s.modelindex = gi.modelindex ("models/objects/laser/tris.md2");
        }
        }

        if (self->client->pers.class == 3)
        {
        if (self->client->pers.grenadevalue == 1) {
        grenade->think = LaserBomb_Explode;
        grenade->touch = NULL;
        }
        }
        if (self->client->pers.class == 7)
        {
        if (self->client->pers.grenadevalue == 1) {
        grenade->think = EMP_Explode;
        grenade->touch = NULL;
        grenade->s.sound = gi.soundindex("");
        }
        }
        }
        grenade->dmg = damage;
	grenade->dmg_radius = damage_radius;
	grenade->classname = "hgrenade";

	if (timer <= 0.0)
		Grenade_Explode (grenade);
	else
	{
		gi.sound (self, CHAN_WEAPON, gi.soundindex ("weapons/hgrent1a.wav"), 1, ATTN_NORM, 0);
		gi.linkentity (grenade);
	}
}

static void detpack_think (edict_t *ent)
{
       edict_t *blip = NULL;

       if (level.time > ent->delay)
       {
               Grenade_Explode(ent);
               return;
       }
 
       ent->think = detpack_think;
       while ((blip = findradius(blip, ent->s.origin, 100)) != NULL)
       {
               if (!(blip->svflags & SVF_MONSTER) && !blip->client)
                       continue;
               if (blip == ent->owner)
                       continue;
               if (!blip->takedamage)
                       continue;
               if (blip->health <= 0)
                       continue;
               if (!visible(ent, blip))
                       continue;
               if (blip->tw_team == ent->tw_team)
                       continue;
               if (blip->client->pers.class == 1) ent->think = G_FreeEdict;
               break;
       }

       ent->nextthink = level.time + .1;
}


void fire_detpack (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int speed, float timer, float damage_radius, qboolean held)
{
	edict_t	*grenade;
	vec3_t	dir;
	vec3_t	forward, right, up;

	vectoangles (aimdir, dir);
	AngleVectors (dir, forward, right, up);

	grenade = G_Spawn();
	VectorCopy (start, grenade->s.origin);
	VectorScale (aimdir, speed, grenade->velocity);
        VectorMA (grenade->velocity, 10 + crandom() * 5.0, up, grenade->velocity);
        VectorMA (grenade->velocity, crandom() * 5.0, right, grenade->velocity);
        VectorSet (grenade->avelocity, 0, 0, 0);
        grenade->movetype = MOVETYPE_TOSS;
	grenade->clipmask = MASK_SHOT;
	grenade->solid = SOLID_BBOX;
	grenade->s.effects |= EF_GRENADE;
	VectorClear (grenade->mins);
	VectorClear (grenade->maxs);
        grenade->s.modelindex = gi.modelindex ("models/items/ammo/nuke/tris.md2");
	grenade->owner = self;
        grenade->tw_team = self->tw_team;
        grenade->touch = NULL;
        grenade->nextthink = level.time + 60;
        grenade->think = detpack_think;
        grenade->classname = "detpack";
	if (held)
		grenade->spawnflags = 3;
	else
		grenade->spawnflags = 1;
	grenade->s.sound = gi.soundindex("weapons/hgrenc1b.wav");


        grenade->dmg = damage;
	grenade->dmg_radius = damage_radius;

	if (timer <= 0.0)
		Grenade_Explode (grenade);
	else
	{
		gi.sound (self, CHAN_WEAPON, gi.soundindex ("weapons/hgrent1a.wav"), 1, ATTN_NORM, 0);
		gi.linkentity (grenade);
	}
}


 
void guideThink (edict_t *self)
            { 
            vec3_t offset; 
            vec3_t forward; 
            vec3_t tvect; 
            float dist; 
            VectorSet (offset, 0, 0, self->owner->viewheight); 
            VectorAdd (self->owner->s.origin, offset, tvect); 
            VectorSubtract (tvect, self->s.origin, tvect); 
            dist = VectorLength (tvect) + 500.0; 
            AngleVectors (self->owner->client->v_angle, forward, NULL, NULL); 
            VectorScale (forward, dist, forward); 
            VectorAdd (forward, tvect, tvect); 
            dist = VectorNormalize (tvect); 
            VectorScale (tvect, 450.0, forward); 
            VectorCopy (forward, self->velocity); 
            vectoangles (tvect, self->s.angles); 
            self->nextthink = level.time + FRAMETIME; 
            } 


/*
=================
fire_rocket
=================
*/
void rocket_touch (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf)
{
	vec3_t		origin;
	int			n;

	if (other == ent->owner)
		return;

	if (surf && (surf->flags & SURF_SKY))
	{
		G_FreeEdict (ent);
		return;
	}

	if (ent->owner->client)
		PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);

	// calculate position for the explosion entity
	VectorMA (ent->s.origin, -0.02, ent->velocity, origin);

	if (other->takedamage)
	{
		T_Damage (other, ent, ent->owner, ent->velocity, ent->s.origin, plane->normal, ent->dmg, 0, 0, MOD_ROCKET);
	}
	else
	{
		// don't throw any debris in net games
		if (!deathmatch->value && !coop->value)
		{
			if ((surf) && !(surf->flags & (SURF_WARP|SURF_TRANS33|SURF_TRANS66|SURF_FLOWING)))
			{
				n = rand() % 5;
				while(n--)
					ThrowDebris (ent, "models/objects/debris2/tris.md2", 2, ent->s.origin);
			}
		}
	}

	T_RadiusDamage(ent, ent->owner, ent->radius_dmg, other, ent->dmg_radius, MOD_R_SPLASH);

	gi.WriteByte (svc_temp_entity);
	if (ent->waterlevel)
		gi.WriteByte (TE_ROCKET_EXPLOSION_WATER);
	else
		gi.WriteByte (TE_ROCKET_EXPLOSION);
	gi.WritePosition (origin);
	gi.multicast (ent->s.origin, MULTICAST_PHS);

	G_FreeEdict (ent);
}

void fire_rocket (edict_t *self, vec3_t start, vec3_t dir, int damage, int speed, float damage_radius, int radius_damage)
{
	edict_t	*rocket;

	rocket = G_Spawn();
	VectorCopy (start, rocket->s.origin);
	VectorCopy (dir, rocket->movedir);
	vectoangles (dir, rocket->s.angles);
	VectorScale (dir, speed, rocket->velocity);
	rocket->movetype = MOVETYPE_FLYMISSILE;
	rocket->clipmask = MASK_SHOT;
	rocket->solid = SOLID_BBOX;
	rocket->s.effects |= EF_ROCKET;
	VectorClear (rocket->mins);
	VectorClear (rocket->maxs);
	rocket->s.modelindex = gi.modelindex ("models/objects/rocket/tris.md2");
	rocket->owner = self;
	rocket->touch = rocket_touch;
	rocket->nextthink = level.time + 8000/speed;
	rocket->think = G_FreeEdict;
	rocket->dmg = damage;
	rocket->radius_dmg = radius_damage;
	rocket->dmg_radius = damage_radius;
	rocket->s.sound = gi.soundindex ("weapons/rockfly.wav");
	rocket->classname = "rocket";

        if (self->client)
		check_dodge (self, rocket->s.origin, dir, speed);
        
        if (self->client->pers.grenadevalue == 2) {
            if (self->client->pers.class == 3)
            if (self->client)
            { 
            // check_dodge (self, rocket->s.origin, dir, speed); 
            VectorScale (dir, 450.0, rocket->velocity); 
            rocket->nextthink = level.time + 0.2; 
            rocket->think = guideThink; 
            } 
            }
	gi.linkentity (rocket);
}



// tranquilizer



void tranquilizer_touch (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf)
{
	vec3_t		origin;
	int			n;

	if (other == ent->owner)
		return;

        if (other->client) {
        other->client->pers.ClassSpeed = other->client->pers.ClassSpeed / 2;
        other->tranquilized = 1;
        other->tq_time = level.time + 30;
        }

	if (surf && (surf->flags & SURF_SKY))
	{
		G_FreeEdict (ent);
		return;
	}

	if (ent->owner->client)
		PlayerNoise(ent->owner, ent->s.origin, PNOISE_IMPACT);
       /*
	// calculate position for the explosion entity
	VectorMA (ent->s.origin, -0.02, ent->velocity, origin);
       
	if (other->takedamage)
	{
		T_Damage (other, ent, ent->owner, ent->velocity, ent->s.origin, plane->normal, ent->dmg, 0, 0, MOD_ROCKET);
	}
	else
	{
		// don't throw any debris in net games
		if (!deathmatch->value && !coop->value)
		{
			if ((surf) && !(surf->flags & (SURF_WARP|SURF_TRANS33|SURF_TRANS66|SURF_FLOWING)))
			{
				n = rand() % 5;
				while(n--)
					ThrowDebris (ent, "models/objects/debris2/tris.md2", 2, ent->s.origin);
			}
		}
	}

	T_RadiusDamage(ent, ent->owner, ent->radius_dmg, other, ent->dmg_radius, MOD_R_SPLASH);

	gi.WriteByte (svc_temp_entity);
	if (ent->waterlevel)
		gi.WriteByte (TE_ROCKET_EXPLOSION_WATER);
	else
		gi.WriteByte (TE_ROCKET_EXPLOSION);
	gi.WritePosition (origin);
	gi.multicast (ent->s.origin, MULTICAST_PHS);
         */

	G_FreeEdict (ent);
}

void fire_tranquilizer (edict_t *self, vec3_t start, vec3_t dir, int damage, int speed, float damage_radius, int radius_damage)
{
	edict_t	*rocket;

	rocket = G_Spawn();
	VectorCopy (start, rocket->s.origin);
	VectorCopy (dir, rocket->movedir);
	vectoangles (dir, rocket->s.angles);
	VectorScale (dir, speed, rocket->velocity);
        rocket->movetype = MOVETYPE_FLYMISSILE;
	rocket->clipmask = MASK_SHOT;
	rocket->solid = SOLID_BBOX;
        // rocket->s.effects |= EF_ROCKET;
	VectorClear (rocket->mins);
	VectorClear (rocket->maxs);
        rocket->s.modelindex = gi.modelindex ("models/dart/tris.md2");
	rocket->owner = self;
        rocket->touch = tranquilizer_touch;
        rocket->nextthink = level.time + 8000/speed;
	rocket->think = G_FreeEdict;
	rocket->dmg = damage;
       // rocket->radius_dmg = radius_damage;
       // rocket->dmg_radius = NULL;
       // rocket->s.sound = gi.soundindex ("weapons/rockfly.wav");
        rocket->classname = "dart";

	if (self->client)
		check_dodge (self, rocket->s.origin, dir, speed);

	gi.linkentity (rocket);
}




/*
=================
fire_rail
=================
*/
void fire_rail (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int kick)
{
	vec3_t		from;
	vec3_t		end;
	trace_t		tr;
	edict_t		*ignore;
	int			mask;
	qboolean	water;

	VectorMA (start, 8192, aimdir, end);
	VectorCopy (start, from);
	ignore = self;
	water = false;
	mask = MASK_SHOT|CONTENTS_SLIME|CONTENTS_LAVA;
	while (ignore)
	{
		tr = gi.trace (from, NULL, NULL, end, ignore, mask);

		if (tr.contents & (CONTENTS_SLIME|CONTENTS_LAVA))
		{
			mask &= ~(CONTENTS_SLIME|CONTENTS_LAVA);
			water = true;
		}
		else
		{
			if ((tr.ent->svflags & SVF_MONSTER) || (tr.ent->client))
				ignore = tr.ent;
			else
				ignore = NULL;

			if ((tr.ent != self) && (tr.ent->takedamage))
				T_Damage (tr.ent, self, self, aimdir, tr.endpos, tr.plane.normal, damage, kick, 0, MOD_RAILGUN);
		}

		VectorCopy (tr.endpos, from);
	}

	// send gun puff / flash
	gi.WriteByte (svc_temp_entity);
        gi.WriteByte (TE_BFG_LASER);
	gi.WritePosition (start);
	gi.WritePosition (tr.endpos);
	gi.multicast (self->s.origin, MULTICAST_PHS);
//	gi.multicast (start, MULTICAST_PHS);
	if (water)
	{
		gi.WriteByte (svc_temp_entity);
		gi.WriteByte (TE_RAILTRAIL);
		gi.WritePosition (start);
		gi.WritePosition (tr.endpos);
		gi.multicast (tr.endpos, MULTICAST_PHS);
	}

	if (self->client)
		PlayerNoise(self, tr.endpos, PNOISE_IMPACT);
}


/*
=================
fire_bfg
=================
*/
void bfg_explode (edict_t *self)
{
	edict_t	*ent;
	float	points;
	vec3_t	v;
	float	dist;

	if (self->s.frame == 0)
	{
		// the BFG effect
		ent = NULL;
		while ((ent = findradius(ent, self->s.origin, self->dmg_radius)) != NULL)
		{
			if (!ent->takedamage)
				continue;
			if (ent == self->owner)
				continue;
			if (!CanDamage (ent, self))
				continue;
			if (!CanDamage (ent, self->owner))
				continue;

			VectorAdd (ent->mins, ent->maxs, v);
			VectorMA (ent->s.origin, 0.5, v, v);
			VectorSubtract (self->s.origin, v, v);
			dist = VectorLength(v);
			points = self->radius_dmg * (1.0 - sqrt(dist/self->dmg_radius));
			if (ent == self->owner)
				points = points * 0.5;

			gi.WriteByte (svc_temp_entity);
			gi.WriteByte (TE_BFG_EXPLOSION);
			gi.WritePosition (ent->s.origin);
			gi.multicast (ent->s.origin, MULTICAST_PHS);
			T_Damage (ent, self, self->owner, self->velocity, ent->s.origin, vec3_origin, (int)points, 0, DAMAGE_ENERGY, MOD_BFG_EFFECT);
		}
	}

	self->nextthink = level.time + FRAMETIME;
	self->s.frame++;
	if (self->s.frame == 5)
		self->think = G_FreeEdict;
}

void bfg_touch (edict_t *self, edict_t *other, cplane_t *plane, csurface_t *surf)
{
	if (other == self->owner)
		return;

	if (surf && (surf->flags & SURF_SKY))
	{
		G_FreeEdict (self);
		return;
	}

	if (self->owner->client)
		PlayerNoise(self->owner, self->s.origin, PNOISE_IMPACT);

	// core explosion - prevents firing it into the wall/floor
	if (other->takedamage)
		T_Damage (other, self, self->owner, self->velocity, self->s.origin, plane->normal, 200, 0, 0, MOD_BFG_BLAST);
        T_RadiusDamage(self, self->owner, 150, other, 75, MOD_BFG_BLAST);

	gi.sound (self, CHAN_VOICE, gi.soundindex ("weapons/bfg__x1b.wav"), 1, ATTN_NORM, 0);
	self->solid = SOLID_NOT;
	self->touch = NULL;
	VectorMA (self->s.origin, -1 * FRAMETIME, self->velocity, self->s.origin);
	VectorClear (self->velocity);
	self->s.modelindex = gi.modelindex ("sprites/s_bfg3.sp2");
	self->s.frame = 0;
	self->s.sound = 0;
	self->s.effects &= ~EF_ANIM_ALLFAST;
	self->think = bfg_explode;
	self->nextthink = level.time + FRAMETIME;
	self->enemy = other;

	gi.WriteByte (svc_temp_entity);
	gi.WriteByte (TE_BFG_BIGEXPLOSION);
	gi.WritePosition (self->s.origin);
	gi.multicast (self->s.origin, MULTICAST_PVS);
}


void bfg_think (edict_t *self)
{
	edict_t	*ent;
	edict_t	*ignore;
	vec3_t	point;
	vec3_t	dir;
	vec3_t	start;
	vec3_t	end;
	int		dmg;
	trace_t	tr;

	if (deathmatch->value)
		dmg = 5;
	else
		dmg = 10;

	ent = NULL;
	while ((ent = findradius(ent, self->s.origin, 256)) != NULL)
	{
		if (ent == self)
			continue;

		if (ent == self->owner)
			continue;

		if (!ent->takedamage)
			continue;

		if (!(ent->svflags & SVF_MONSTER) && (!ent->client) && (strcmp(ent->classname, "misc_explobox") != 0))
			continue;

		VectorMA (ent->absmin, 0.5, ent->size, point);

		VectorSubtract (point, self->s.origin, dir);
		VectorNormalize (dir);

		ignore = self;
		VectorCopy (self->s.origin, start);
		VectorMA (start, 2048, dir, end);
		while(1)
		{
			tr = gi.trace (start, NULL, NULL, end, ignore, CONTENTS_SOLID|CONTENTS_MONSTER|CONTENTS_DEADMONSTER);

			if (!tr.ent)
				break;

			// hurt it if we can
			if ((tr.ent->takedamage) && !(tr.ent->flags & FL_IMMUNE_LASER) && (tr.ent != self->owner))
				T_Damage (tr.ent, self, self->owner, dir, tr.endpos, vec3_origin, dmg, 1, DAMAGE_ENERGY, MOD_BFG_LASER);

			// if we hit something that's not a monster or player we're done
			if (!(tr.ent->svflags & SVF_MONSTER) && (!tr.ent->client))
			{
				gi.WriteByte (svc_temp_entity);
				gi.WriteByte (TE_LASER_SPARKS);
				gi.WriteByte (4);
				gi.WritePosition (tr.endpos);
				gi.WriteDir (tr.plane.normal);
				gi.WriteByte (self->s.skinnum);
				gi.multicast (tr.endpos, MULTICAST_PVS);
				break;
			}

			ignore = tr.ent;
			VectorCopy (tr.endpos, start);
		}

		gi.WriteByte (svc_temp_entity);
		gi.WriteByte (TE_BFG_LASER);
		gi.WritePosition (self->s.origin);
		gi.WritePosition (tr.endpos);
		gi.multicast (self->s.origin, MULTICAST_PHS);
	}

	self->nextthink = level.time + FRAMETIME;
}


void fire_bfg (edict_t *self, vec3_t start, vec3_t dir, int damage, int speed, float damage_radius)
{
	edict_t	*bfg;

	bfg = G_Spawn();
	VectorCopy (start, bfg->s.origin);
	VectorCopy (dir, bfg->movedir);
	vectoangles (dir, bfg->s.angles);
	VectorScale (dir, speed, bfg->velocity);
	bfg->movetype = MOVETYPE_FLYMISSILE;
	bfg->clipmask = MASK_SHOT;
	bfg->solid = SOLID_BBOX;
	bfg->s.effects |= EF_BFG | EF_ANIM_ALLFAST;
	VectorClear (bfg->mins);
	VectorClear (bfg->maxs);
	bfg->s.modelindex = gi.modelindex ("sprites/s_bfg1.sp2");
	bfg->owner = self;
	bfg->touch = bfg_touch;
	bfg->nextthink = level.time + 8000/speed;
	bfg->think = G_FreeEdict;
	bfg->radius_dmg = damage;
	bfg->dmg_radius = damage_radius;
	bfg->classname = "bfg blast";
	bfg->s.sound = gi.soundindex ("weapons/bfg__l1a.wav");

	bfg->think = bfg_think;
	bfg->nextthink = level.time + FRAMETIME;
	bfg->teammaster = bfg;
	bfg->teamchain = NULL;

	if (self->client)
		check_dodge (self, bfg->s.origin, dir, speed);

	gi.linkentity (bfg);
}
