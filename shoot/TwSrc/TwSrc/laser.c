#include	"g_local.h"
#include	"laser.h"


void Laser_Explode (edict_t *ent)
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
	}
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



void    laser_die (edict_t *self)
{
        G_FreeEdict(self->owner);
        Laser_Explode(self);
   //     G_FreeEdict(self);
}

void laser_pain (edict_t *self, edict_t *other, float kick, int damage)
{

    if (level.time < self->pain_debounce_time)
        return;

    self->pain_debounce_time = level.time + 3;
 //   gi.sound (self, CHAN_VOICE, sound_pain, 1, ATTN_NORM, 0);
}



void	PlaceLaser (edict_t *ent)
{
	edict_t		*self,
				*grenade;

	vec3_t		forward,
				wallp;

	trace_t		tr;


	int		laser_colour[] = {
								0xf2f2f0f0,		// red
								0xd0d1d2d3,		// green
								0xf3f3f1f1,		// blue
								0xdcdddedf,		// yellow
								0xe0e1e2e3		// bitty yellow strobe
							};


	// valid ent ?
  	if ((!ent->client) || (ent->health<=0))
	   return;

	// cells for laser ?
	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Cells"))] < CELLS_FOR_LASER)
	{
 		gi.cprintf(ent, PRINT_HIGH, "Not enough cells for laser.\n");
		return;
	}

	// Setup "little look" to close wall
	VectorCopy(ent->s.origin,wallp);         

	// Cast along view angle
	AngleVectors (ent->client->v_angle, forward, NULL, NULL);

	// Setup end point
	wallp[0]=ent->s.origin[0]+forward[0]*50;
	wallp[1]=ent->s.origin[1]+forward[1]*50;
	wallp[2]=ent->s.origin[2]+forward[2]*50;  

	// trace
	tr = gi.trace (ent->s.origin, NULL, NULL, wallp, ent, MASK_SOLID);

	// Line complete ? (ie. no collision)
	if (tr.fraction == 1.0)
	{
	 	gi.cprintf (ent, PRINT_HIGH, "Too far from wall.\n");
		return;
	}

	// Hit sky ?
	if (tr.surface)
		if (tr.surface->flags & SURF_SKY)
			return;

	// Ok, lets stick one on then ...
	gi.cprintf (ent, PRINT_HIGH, "Laser attached.\n");

	ent->client->pers.inventory[ITEM_INDEX(FindItem("Cells"))] -= CELLS_FOR_LASER;

	// -----------
	// Setup laser
	// -----------
	self = G_Spawn();

	self -> movetype		= MOVETYPE_NONE;
	self -> solid			= SOLID_NOT;
	self -> s.renderfx		= RF_BEAM|RF_TRANSLUCENT;
	self -> s.modelindex	= 1;			// must be non-zero
	self -> s.sound			= gi.soundindex ("world/laser.wav");
	self -> classname		= "laser_yaya";
	self -> s.frame			= 2;	// beam diameter
        self -> owner                   = ent;
        self->tw_team = ent->tw_team;
        self -> s.skinnum		= laser_colour[((int) (random() * 1000)) % 5];
  	self -> dmg				= LASER_DAMAGE;
	self -> think			= pre_target_laser_think;
	self -> delay			= level.time + LASER_TIME;
        self ->tw_team = ent->tw_team;


        // Set orgin of laser to point of contact with wall
	VectorCopy(tr.endpos,self->s.origin);

	// convert normal at point of contact to laser angles
	vectoangles(tr.plane.normal,self -> s.angles);

	// setup laser movedir (projection of laser)
	G_SetMovedir (self->s.angles, self->movedir);

	VectorSet (self->mins, -8, -8, -8);
	VectorSet (self->maxs, 8, 8, 8);

	// link to world
	gi.linkentity (self);

	// start off ...
	target_laser_off (self);

	// ... but make automatically come on
	self -> nextthink = level.time + 2;

	grenade = G_Spawn();

	VectorClear (grenade->mins);
	VectorClear (grenade->maxs);
	VectorCopy (tr.endpos, grenade->s.origin);
	vectoangles(tr.plane.normal,grenade -> s.angles);

        grenade->health = 20;
        grenade->max_health = 20;
        grenade->tw_team = ent->tw_team;
        grenade->pain = laser_pain;
        grenade->die = laser_die;
	grenade -> movetype		= MOVETYPE_NONE;
	grenade -> clipmask		= MASK_SHOT;
        //grenade -> solid                = SOLID_NOT;
	grenade -> s.modelindex	= gi.modelindex ("models/objects/grenade2/tris.md2");
        grenade -> owner                = self;
	grenade -> nextthink	= level.time + LASER_TIME;
        grenade-> takedamage = DAMAGE_AIM;
	grenade -> think		= G_FreeEdict;
        grenade->clipmask = MASK_PLAYERSOLID;
        grenade ->solid = SOLID_BBOX;
    //  self->movetype = MOVETYPE_STEP;
    //  self->takedamage = DAMAGE_AIM;
   //   self->mass = 100;

	gi.linkentity (grenade);
}

void	pre_target_laser_think (edict_t *self)
{
	target_laser_on (self);

	self->think = target_laser_think;
}

