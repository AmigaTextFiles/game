/*
==============================================================================

FLIPPER

==============================================================================
*/

#include "g_local.h"
#include "m_flipper.h"


static int	sound_chomp;
static int	sound_attack;
static int	sound_pain1;
static int	sound_pain2;
static int	sound_death;
static int	sound_idle;
static int	sound_search;
static int	sound_sight;


void flipper_stand (edict_t *self);

mframe_t flipper_frames_stand [] =
{
	ai_stand, 0, NULL
};
	
mmove_t	flipper_move_stand = {FRAME_flphor01, FRAME_flphor01, flipper_frames_stand, NULL};

void flipper_stand (edict_t *self)
{
		self->monsterinfo.currentmove = &flipper_move_stand;
}

#define FLIPPER_RUN_SPEED	24

mframe_t flipper_frames_run [] =
{
	ai_run, FLIPPER_RUN_SPEED, NULL,	// 6
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,	// 10

	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,	// 20

	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL,
	ai_run, FLIPPER_RUN_SPEED, NULL		// 29
};
mmove_t flipper_move_run_loop = {FRAME_flpver06, FRAME_flpver29, flipper_frames_run, NULL};

void flipper_run_loop (edict_t *self)
{
	self->monsterinfo.currentmove = &flipper_move_run_loop;
}

mframe_t flipper_frames_run_start [] =
{
	ai_run, 8, NULL,
	ai_run, 8, NULL,
	ai_run, 8, NULL,
	ai_run, 8, NULL,
	ai_run, 8, NULL,
	ai_run, 8, NULL
};
mmove_t flipper_move_run_start = {FRAME_flpver01, FRAME_flpver06, flipper_frames_run_start, flipper_run_loop};

void flipper_run (edict_t *self)
{
	self->monsterinfo.currentmove = &flipper_move_run_start;
}

/* Standard Swimming */ 
mframe_t flipper_frames_walk [] =
{
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL,
	ai_walk, 4, NULL
};
mmove_t flipper_move_walk = {FRAME_flphor01, FRAME_flphor24, flipper_frames_walk, NULL};

void flipper_walk (edict_t *self)
{
	self->monsterinfo.currentmove = &flipper_move_walk;
}

mframe_t flipper_frames_start_run [] =
{
	ai_run, 8, NULL,
	ai_run, 8, NULL,
	ai_run, 8, NULL,
	ai_run, 8, NULL,
	ai_run, 8, flipper_run
};
mmove_t flipper_move_start_run = {FRAME_flphor01, FRAME_flphor05, flipper_frames_start_run, NULL};

void flipper_start_run (edict_t *self)
{
	self->monsterinfo.currentmove = &flipper_move_start_run;
}

mframe_t flipper_frames_pain2 [] =
{
	ai_move, 0, NULL,
	ai_move, 0, NULL,
	ai_move, 0,	NULL,
	ai_move, 0,	NULL,
	ai_move, 0, NULL
};
mmove_t flipper_move_pain2 = {FRAME_flppn101, FRAME_flppn105, flipper_frames_pain2, flipper_run};

mframe_t flipper_frames_pain1 [] =
{
	ai_move, 0, NULL,
	ai_move, 0, NULL,
	ai_move, 0,	NULL,
	ai_move, 0,	NULL,
	ai_move, 0, NULL
};
mmove_t flipper_move_pain1 = {FRAME_flppn201, FRAME_flppn205, flipper_frames_pain1, flipper_run};

qboolean fire_hit2 (edict_t *self, vec3_t aim, int damage, int kick)
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
        T_Damage (tr.ent, self, self, dir, point, vec3_origin, damage, kick/2, DAMAGE_NO_KNOCKBACK, MOD_FISH);

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



void flipper_bite (edict_t *self)
{
	vec3_t	aim;

	VectorSet (aim, MELEE_DISTANCE, 0, 0);
        fire_hit2 (self, aim, 15, 0);
}

void flipper_preattack (edict_t *self)
{
	gi.sound (self, CHAN_WEAPON, sound_chomp, 1, ATTN_NORM, 0);
}

mframe_t flipper_frames_attack [] =
{
	ai_charge, 0,	flipper_preattack,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	flipper_bite,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	NULL,
	ai_charge, 0,	flipper_bite,
	ai_charge, 0,	NULL
};
mmove_t flipper_move_attack = {FRAME_flpbit01, FRAME_flpbit20, flipper_frames_attack, flipper_run};

void flipper_melee(edict_t *self)
{
	self->monsterinfo.currentmove = &flipper_move_attack;
}

void flipper_pain (edict_t *self, edict_t *other, float kick, int damage)
{
	int		n;

	if (self->health < (self->max_health / 2))
		self->s.skinnum = 1;

	if (level.time < self->pain_debounce_time)
		return;

	self->pain_debounce_time = level.time + 3;
	
	if (skill->value == 3)
		return;		// no pain anims in nightmare

	n = (rand() + 1) % 2;
	if (n == 0)
	{
		gi.sound (self, CHAN_VOICE, sound_pain1, 1, ATTN_NORM, 0);
		self->monsterinfo.currentmove = &flipper_move_pain1;
	}
	else
	{
		gi.sound (self, CHAN_VOICE, sound_pain2, 1, ATTN_NORM, 0);
		self->monsterinfo.currentmove = &flipper_move_pain2;
	}
}

void flipper_dead (edict_t *self)
{
	VectorSet (self->mins, -16, -16, -24);
	VectorSet (self->maxs, 16, 16, -8);
	self->movetype = MOVETYPE_TOSS;
	self->svflags |= SVF_DEADMONSTER;
	self->nextthink = 0;
	gi.linkentity (self);
}

mframe_t flipper_frames_death [] =
{
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,

	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,

	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,

	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,

	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,

	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL,
	ai_move, 0,	 NULL
};
mmove_t flipper_move_death = {FRAME_flpdth01, FRAME_flpdth56, flipper_frames_death, flipper_dead};

void flipper_sight (edict_t *self, edict_t *other)
{
	gi.sound (self, CHAN_VOICE, sound_sight, 1, ATTN_NORM, 0);
}

void flipper_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
	int		n;

// check for gib
	if (self->health <= self->gib_health)
	{
		gi.sound (self, CHAN_VOICE, gi.soundindex ("misc/udeath.wav"), 1, ATTN_NORM, 0);
		for (n= 0; n < 2; n++)
			ThrowGib (self, "models/objects/gibs/bone/tris.md2", damage, GIB_ORGANIC);
		for (n= 0; n < 2; n++)
			ThrowGib (self, "models/objects/gibs/sm_meat/tris.md2", damage, GIB_ORGANIC);
		ThrowHead (self, "models/objects/gibs/sm_meat/tris.md2", damage, GIB_ORGANIC);
		self->deadflag = DEAD_DEAD;
		return;
	}

	if (self->deadflag == DEAD_DEAD)
		return;

// regular death
	gi.sound (self, CHAN_VOICE, sound_death, 1, ATTN_NORM, 0);
	self->deadflag = DEAD_DEAD;
	self->takedamage = DAMAGE_YES;
	self->monsterinfo.currentmove = &flipper_move_death;
        if (self->creator)
        self->creator->monstercount = self->creator->monstercount - 1;
}

/*QUAKED monster_flipper (1 .5 0) (-16 -16 -24) (16 16 32) Ambush Trigger_Spawn Sight
*/
void SP_monster_flipper (edict_t *self)
{

	sound_pain1		= gi.soundindex ("flipper/flppain1.wav");	
	sound_pain2		= gi.soundindex ("flipper/flppain2.wav");	
	sound_death		= gi.soundindex ("flipper/flpdeth1.wav");	
	sound_chomp		= gi.soundindex ("flipper/flpatck1.wav");
	sound_attack	= gi.soundindex ("flipper/flpatck2.wav");
	sound_idle		= gi.soundindex ("flipper/flpidle1.wav");
	sound_search	= gi.soundindex ("flipper/flpsrch1.wav");
	sound_sight		= gi.soundindex ("flipper/flpsght1.wav");

	self->movetype = MOVETYPE_STEP;
	self->solid = SOLID_BBOX;
	self->s.modelindex = gi.modelindex ("models/monsters/flipper/tris.md2");
	VectorSet (self->mins, -16, -16, 0);
	VectorSet (self->maxs, 16, 16, 32);

	self->health = 50;
	self->gib_health = -30;
	self->mass = 100;

	self->pain = flipper_pain;
	self->die = flipper_die;

	self->monsterinfo.stand = flipper_stand;
	self->monsterinfo.walk = flipper_walk;
	self->monsterinfo.run = flipper_start_run;
	self->monsterinfo.melee = flipper_melee;
	self->monsterinfo.sight = flipper_sight;

	gi.linkentity (self);

	self->monsterinfo.currentmove = &flipper_move_stand;	
	self->monsterinfo.scale = MODEL_SCALE;

	swimmonster_start (self);
}

void SP_monster_flipper2 (edict_t *owner)
{

	vec3_t		forward,
				wallp;

	trace_t		tr;
	gitem_t		*item;
      edict_t *self;


	// valid ent ?
        if ((!owner->client) || (owner->health<=0))
	   return;


	// Setup "little look" to close wall
        VectorCopy(owner->s.origin,wallp);         

	// Cast along view angle
        AngleVectors (owner->client->v_angle, forward, NULL, NULL);

	// Setup end point
        wallp[0]=owner->s.origin[0]+forward[0]*150;
        wallp[1]=owner->s.origin[1]+forward[1]*150;
        wallp[2]=owner->s.origin[2]+forward[2]*150;  

	// trace
        tr = gi.trace (owner->s.origin, NULL, NULL, wallp, owner, MASK_SOLID);

	// Line complete ? (ie. no collision)
        if (tr.fraction != 1.0)
	{
                gi.cprintf (owner, PRINT_HIGH, "Too close to wall.\n");
        item = FindItem("Cells");
        owner->client->pers.selected_item = ITEM_INDEX(item);
        owner->client->pers.inventory[owner->client->pers.selected_item] = owner->client->pers.inventory[owner->client->pers.selected_item] + 20;
		return;
	}

	// Hit sky ?
	if (tr.surface)
		if (tr.surface->flags & SURF_SKY)
			return;
    

      //it's ok to spawn it now

      self = G_Spawn();
        if (self->owner)
      owner->monstercount = owner->monstercount  + 1;

      //Link two entities together
      self->creator = owner;    //for the decoy, this is a pointer to the owner

      AngleVectors(owner->client->v_angle, forward, NULL, NULL);
      VectorMA(owner->s.origin, 100, forward, self->s.origin);
      self->tw_team = owner->tw_team;
      self->s.angles[PITCH] = owner->s.angles[PITCH];
      self->s.angles[YAW] = owner->s.angles[YAW];
      self->s.angles[ROLL] = owner->s.angles[ROLL];
	gi.WriteByte (svc_muzzleflash);
        gi.WriteShort (self-g_edicts);
	gi.WriteByte (MZ_LOGIN);
        gi.multicast (self->s.origin, MULTICAST_PVS);

	sound_pain1		= gi.soundindex ("flipper/flppain1.wav");	
	sound_pain2		= gi.soundindex ("flipper/flppain2.wav");	
	sound_death		= gi.soundindex ("flipper/flpdeth1.wav");	
	sound_chomp		= gi.soundindex ("flipper/flpatck1.wav");
	sound_attack	= gi.soundindex ("flipper/flpatck2.wav");
	sound_idle		= gi.soundindex ("flipper/flpidle1.wav");
	sound_search	= gi.soundindex ("flipper/flpsrch1.wav");
	sound_sight		= gi.soundindex ("flipper/flpsght1.wav");

	self->movetype = MOVETYPE_STEP;
	self->solid = SOLID_BBOX;
	self->s.modelindex = gi.modelindex ("models/monsters/flipper/tris.md2");
	VectorSet (self->mins, -16, -16, 0);
	VectorSet (self->maxs, 16, 16, 32);

	self->health = 50;
	self->gib_health = -30;
	self->mass = 100;

	self->pain = flipper_pain;
	self->die = flipper_die;

	self->monsterinfo.stand = flipper_stand;
	self->monsterinfo.walk = flipper_walk;
	self->monsterinfo.run = flipper_start_run;
	self->monsterinfo.melee = flipper_melee;
	self->monsterinfo.sight = flipper_sight;

	gi.linkentity (self);

	self->monsterinfo.currentmove = &flipper_move_stand;	
	self->monsterinfo.scale = MODEL_SCALE;

	swimmonster_start (self);
}


