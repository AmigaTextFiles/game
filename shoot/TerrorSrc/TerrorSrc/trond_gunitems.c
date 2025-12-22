//TROND
#include "g_local.h"

void P_ProjectSource (gclient_t *client, vec3_t point, vec3_t distance, vec3_t forward, vec3_t right, vec3_t result);
void Weapon_Generic (edict_t *ent, int FRAME_ACTIVATE_LAST, int FRAME_FIRE_LAST, int FRAME_IDLE_LAST, int FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/int FRAME_RELOAD_LAST, int FRAME_ENDMAG_LAST,/*TROND slutt*/ int *pause_frames, int *fire_frames, void (*fire)(edict_t *ent));

//TROND
//LOMMELYKT
#define fl self->flashlight

void SP_FlashLight (edict_t *self)
{
	vec3_t	forward, right, end, start;

	if (fl)
	{
		G_FreeEdict(fl);
		fl=NULL;
		self->client->fl_on = 0;
		return;
	}

	self->client->fl_on = 1;
	AngleVectors (self->client->v_angle, forward, right, NULL);

	VectorSet (end, 100, 0, 0);
	G_ProjectSource (self->s.origin, end, forward, right, start);

	fl = G_Spawn ();
	fl->owner = self;
	fl->movetype = MOVETYPE_NOCLIP;
	fl->solid = SOLID_NOT;
	fl->classname = "flashlight";
	fl->s.modelindex = gi.modelindex ("sprites/null.sp2");
	fl->s.skinnum = 0;

	fl->s.effects = EF_PLASMA;
//	fl->s.effects = TE_FLASHLIGHT;

	fl->s.renderfx = 0;

	fl->think = FlashLightThink;
	fl->nextthink = level.time + 0.1;
}

void FlashLightThink (edict_t *self)
{
	vec3_t	start, end, endp, offset;
	vec3_t	forward, right, up;
	trace_t	tr;

	AngleVectors (self->owner->client->v_angle, forward, right, up);

	VectorSet (offset, 24, 6, self->owner->viewheight-7);
	G_ProjectSource (self->owner->s.origin, offset, forward, right, start);
	VectorMA (start, 8192, forward, end);

	tr = gi.trace (start, NULL, NULL, end, self->owner, CONTENTS_SOLID|CONTENTS_MONSTER|CONTENTS_DEADMONSTER);

	if (tr.fraction != 1 )
	{
		VectorMA (tr.endpos, -4, forward, endp);
		VectorCopy (endp, tr.endpos);
	}

	if ((tr.ent->svflags & SVF_MONSTER) || (tr.ent->client))
	{
		if ((tr.ent->takedamage) && (tr.ent != self->owner))
		{
			self->s.skinnum = 1;
		}
	}
	else
		self->s.skinnum = 0;

	vectoangles (tr.plane.normal, self->s.angles);
	VectorCopy (tr.endpos, self->s.origin);

/*	if (self->owner->client->fl_on = 0)
	{
		G_FreeEdict (self);
		return;
	}*/
	gi.linkentity (self);


	//TROND 10/5
	if (self->owner->client->pers.inventory[ITEM_INDEX(FindItem("head light"))] == 0)
		G_FreeEdict (self);


	self->nextthink = level.time + 0.1;
}

//LASERSIKTE
# define lss self->lasersight

void SP_LaserSight (edict_t *self)
{
	vec3_t	forward, right, end, start;

	if (lss)
	{
		G_FreeEdict(lss);
		lss=NULL;
		self->client->ls_on = 0;
		return;
	}

	self->client->ls_on = 1;
	AngleVectors (self->client->v_angle, forward, right, NULL);

	VectorSet (end, 100, 0, 0);
	G_ProjectSource (start, end, forward, right, start);

	lss = G_Spawn ();
	lss->owner = self;
	lss->movetype = MOVETYPE_NOCLIP;
	lss->solid = SOLID_NOT;
	lss->classname = "lasersight";
	lss->s.modelindex = gi.modelindex ("sprites/lsight.sp2");
	lss->s.skinnum = 0;

//	lss->s.renderfx |= RF_FULLBRIGHT;
	lss->s.renderfx = RF_TRANSLUCENT;

	lss->think = LaserSightThink;
	lss->nextthink = level.time + 0.1;
}

void LaserSightThink (edict_t *self)
{
	vec3_t	start, end, endp, offset;
	vec3_t	forward, right, up;
	trace_t	tr;
	int		content_mask = MASK_SHOT | MASK_WATER;
	float	r;
	float	u;
	int		vspread, hspread;

	//SIKTET GÅR FRÅ MIDTEN AV SKJERMEN
	vec3_t		center_screen;

	VectorScale (forward, 0, center_screen);
	VectorAdd (center_screen, self->s.origin, center_screen);
	center_screen[2] += self->viewheight;

	if (self->owner->velocity[1]
		|| self->owner->velocity[0]
		|| self->owner->velocity[2])
	{
		vspread = 400;
		hspread = 200;
	}
	else if (self->owner->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		vspread = 50;
		hspread = 25;
	}
	else
	{
		vspread = 200;
		hspread = 100;
	}

	AngleVectors (self->owner->client->v_angle, forward, right, up);

	VectorSet (offset, 0, 0, self->owner->viewheight+1.5);//TROND var 24, 6, self->owner->viewheight-7
	G_ProjectSource (self->owner->s.origin, offset, forward, right, start);
//	VectorMA (center_screen, 8192, forward, end);
	r = crandom()*vspread;
	u = crandom()*hspread;
	VectorMA (center_screen, 8192, forward, end);//TROND
	VectorMA (end, r, right, end);
	VectorMA (end, u, up, end);

	tr = gi.trace (start, NULL, NULL, end, self->owner, CONTENTS_SOLID|CONTENTS_MONSTER|CONTENTS_DEADMONSTER);

	if (tr.fraction != 1 )
	{
		VectorMA (tr.endpos, -4, forward, endp);
		VectorCopy (endp, tr.endpos);
	}

	if ((tr.ent->svflags & SVF_MONSTER) || (tr.ent->client))
	{
		if ((tr.ent->takedamage) && (tr.ent != self->owner))
		{
			self->s.skinnum = 1;
		}
	}
	else
		self->s.skinnum = 0;

	vectoangles (tr.plane.normal, self->s.angles);
	VectorCopy (tr.endpos, self->s.origin);

	if (!((tr.surface) && (tr.surface->flags & SURF_SKY)))
		self->s.modelindex = gi.modelindex ("sprites/lsight.sp2");
	else
		self->s.modelindex = gi.modelindex ("sprites/null.sp2");

	gi.linkentity (self);

	//TROND 10/5
	if (self->owner->client->pers.weapon != FindItem("glock"))
		G_FreeEdict (self);


	self->nextthink = level.time + 0.1;
}
//TROND slutt
