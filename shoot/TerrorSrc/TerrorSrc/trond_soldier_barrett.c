/*
==============================================================================

SOLDIER

==============================================================================
*/

#include "g_local.h"
#include "m_soldier.h"

void SelectSpawnPoint (edict_t *ent, vec3_t origin, vec3_t angles);//TROND 14/3
void SP_monster_soldier_barrett_x (edict_t *self);//TROND 14/3
void DM_Respawn_Barrett (edict_t *self);//TROND 17/3
void monster_fire_barrett (edict_t *self, vec3_t start, vec3_t dir, int damage, int kick, int hspread, int vspread, int flashtype);//TROND 17/3

static int	sound_idle;
static int	sound_sight1;
static int	sound_sight2;
static int	sound_pain_light;
static int	sound_pain;
static int	sound_pain_ss;
static int	sound_death_light;
static int	sound_death;
static int	sound_death_ss;
static int	sound_cock;


void soldier_idle_barrett (edict_t *self)
{
	if (random() > 0.8)
		gi.sound (self, CHAN_VOICE, sound_idle, 1, ATTN_IDLE, 0);
}

void soldier_cock_barrett (edict_t *self)
{
	if (self->s.frame == 0)
		gi.sound (self, CHAN_WEAPON, sound_cock, 1, ATTN_IDLE, 0);
	else
		gi.sound (self, CHAN_WEAPON, sound_cock, 1, ATTN_NORM, 0);
}


// STAND

void soldier_stand_barrett (edict_t *self);

mframe_t soldier_frames_stand1_barrett [] =
{
	ai_stand, 0, soldier_idle_barrett,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,

	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL
};
mmove_t soldier_move_stand1_barrett = {0, 19, soldier_frames_stand1_barrett, soldier_stand_barrett};

mframe_t soldier_frames_stand3_barrett [] =
{
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,

	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL
};
mmove_t soldier_move_stand3_barrett = {20, 39, soldier_frames_stand3_barrett, soldier_stand_barrett};

#if 0
mframe_t soldier_frames_stand4 [] =
{
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,

	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,

	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,

	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,

	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 0, NULL,
	ai_stand, 4, NULL,
	ai_stand, 1, NULL,
	ai_stand, -1, NULL,
	ai_stand, -2, NULL,

	ai_stand, 0, NULL,
	ai_stand, 0, NULL
};
mmove_t soldier_move_stand4 = {FRAME_stand401, FRAME_stand452, soldier_frames_stand4, NULL};
#endif

void soldier_stand_barrett (edict_t *self)
{	
//	self->classname = "police";

	if ((self->monsterinfo.currentmove == &soldier_move_stand3_barrett) || (random() < 0.8))
		self->monsterinfo.currentmove = &soldier_move_stand1_barrett;
	else
		self->monsterinfo.currentmove = &soldier_move_stand3_barrett;
}


//
// WALK
//

void soldier_walk1_random_barrett (edict_t *self)
{
	if (random() > 0.1)
		self->monsterinfo.nextframe = 40;
}

mframe_t soldier_frames_walk1_barrett [] =
{
	ai_walk, 6,  NULL,
	ai_walk, 2,  NULL,
	ai_walk, 5,  NULL,
	ai_walk, 3,  NULL,
	ai_walk, -1, soldier_walk1_random_barrett,
	ai_walk, 0,  NULL
};
mmove_t soldier_move_walk1_barrett = {40, 45, soldier_frames_walk1_barrett, NULL};

mframe_t soldier_frames_walk2_barrett [] =
{
	ai_walk, 6,  NULL,
	ai_walk, 2,  NULL,
	ai_walk, 5,  NULL,
	ai_walk, 3,  NULL,
	ai_walk, -1, soldier_walk1_random_barrett,
	ai_walk, 0,  NULL
};
mmove_t soldier_move_walk2_barrett = {40, 45, soldier_frames_walk2_barrett, NULL};

void soldier_walk_barrett (edict_t *self)
{	
//	self->classname = "police";

	if (random() < 0.5)
		self->monsterinfo.currentmove = &soldier_move_walk1_barrett;
	else
		self->monsterinfo.currentmove = &soldier_move_walk2_barrett;
}


//
// RUN
//

void soldier_run_barrett (edict_t *self);

mframe_t soldier_frames_start_run_barrett [] =
{
	ai_run, 10, NULL,
	ai_run, 11, NULL,
	ai_run, 11, NULL,
	ai_run, 16, NULL,
	ai_run, 10, NULL,
	ai_run, 15, NULL
};
mmove_t soldier_move_start_run_barrett = {40, 45, soldier_frames_start_run_barrett, soldier_run_barrett};

mframe_t soldier_frames_run_barrett [] =
{
	ai_run, 10, NULL,
	ai_run, 11, NULL,
	ai_run, 11, NULL,
	ai_run, 16, NULL,
	ai_run, 10, NULL,
	ai_run, 15, NULL
};
mmove_t soldier_move_run_barrett = {40, 45, soldier_frames_run_barrett, NULL};

void soldier_run_barrett (edict_t *self)
{	
//	self->classname = "police";

	if (self->monsterinfo.aiflags & AI_STAND_GROUND)
	{
		self->monsterinfo.currentmove = &soldier_move_stand1_barrett;
		return;
	}

	if (self->monsterinfo.currentmove == &soldier_move_walk1_barrett ||
		self->monsterinfo.currentmove == &soldier_move_walk2_barrett ||
		self->monsterinfo.currentmove == &soldier_move_start_run_barrett)
	{
		self->monsterinfo.currentmove = &soldier_move_run_barrett;
	}
	else
	{
		self->monsterinfo.currentmove = &soldier_move_start_run_barrett;
	}
}


//
// PAIN
//

mframe_t soldier_frames_pain1_barrett [] =
{
	ai_move, -3, NULL,
	ai_move, 4,  NULL,
	ai_move, 1,  NULL,
	ai_move, 0,  NULL
};
mmove_t soldier_move_pain1_barrett = {58, 61, soldier_frames_pain1_barrett, soldier_run_barrett};

mframe_t soldier_frames_pain2_barrett [] =
{
	ai_move, -13, NULL,
	ai_move, -1,  NULL,
	ai_move, 4,   NULL,
	ai_move, 3,   NULL
};
mmove_t soldier_move_pain2_barrett = {54, 57, soldier_frames_pain2_barrett, soldier_run_barrett};

mframe_t soldier_frames_pain3_barrett [] =
{
	ai_move, -8, NULL,
	ai_move, -3, NULL,
	ai_move, 3,  NULL,
	ai_move, 4,  NULL
};
mmove_t soldier_move_pain3_barrett = {62, 65, soldier_frames_pain3_barrett, soldier_run_barrett};

mframe_t soldier_frames_pain4_barrett [] =
{
	ai_move, -8, NULL,
	ai_move, -3, NULL,
	ai_move, 3,  NULL,
	ai_move, 4,  NULL
};
mmove_t soldier_move_pain4_barrett = {62, 65, soldier_frames_pain4_barrett, soldier_run_barrett};

void soldier_pain_barrett (edict_t *self, edict_t *other, float kick, int damage)
{
	float	r;
	int		n;

	//TROND tatt vekk 13/3
	/*
	if (self->health < (self->max_health / 2))
			self->s.skinnum |= 1;
	*/

	if (level.time < self->pain_debounce_time)
	{
		if ((self->velocity[2] > 100) && ( (self->monsterinfo.currentmove == &soldier_move_pain1_barrett) || (self->monsterinfo.currentmove == &soldier_move_pain2_barrett) || (self->monsterinfo.currentmove == &soldier_move_pain3_barrett)))
			self->monsterinfo.currentmove = &soldier_move_pain4_barrett;
		return;
	}

	self->pain_debounce_time = level.time + 3;

	n = self->s.skinnum | 1;
	if (n == 1)
		gi.sound (self, CHAN_VOICE, sound_pain_light, 1, ATTN_NORM, 0);
	else if (n == 3)
		gi.sound (self, CHAN_VOICE, sound_pain, 1, ATTN_NORM, 0);
	else
		gi.sound (self, CHAN_VOICE, sound_pain_ss, 1, ATTN_NORM, 0);

	if (self->velocity[2] > 100)
	{
		self->monsterinfo.currentmove = &soldier_move_pain4_barrett;
		return;
	}

	if (skill->value == 3)
		return;		// no pain anims in nightmare

	r = random();

	if (r < 0.33)
		self->monsterinfo.currentmove = &soldier_move_pain1_barrett;
	else if (r < 0.66)
		self->monsterinfo.currentmove = &soldier_move_pain2_barrett;
	else
		self->monsterinfo.currentmove = &soldier_move_pain3_barrett;
}


//
// ATTACK
//

static int blaster_flash [] = {MZ2_SOLDIER_BLASTER_1, MZ2_SOLDIER_BLASTER_2, MZ2_SOLDIER_BLASTER_3, MZ2_SOLDIER_BLASTER_4, MZ2_SOLDIER_BLASTER_5, MZ2_SOLDIER_BLASTER_6, MZ2_SOLDIER_BLASTER_7, MZ2_SOLDIER_BLASTER_8};
static int shotgun_flash [] = {MZ2_SOLDIER_SHOTGUN_1, MZ2_SOLDIER_SHOTGUN_2, MZ2_SOLDIER_SHOTGUN_3, MZ2_SOLDIER_SHOTGUN_4, MZ2_SOLDIER_SHOTGUN_5, MZ2_SOLDIER_SHOTGUN_6, MZ2_SOLDIER_SHOTGUN_7, MZ2_SOLDIER_SHOTGUN_8};
static int machinegun_flash [] = {MZ2_SOLDIER_MACHINEGUN_1, MZ2_SOLDIER_MACHINEGUN_2, MZ2_SOLDIER_MACHINEGUN_3, MZ2_SOLDIER_MACHINEGUN_4, MZ2_SOLDIER_MACHINEGUN_5, MZ2_SOLDIER_MACHINEGUN_6, MZ2_SOLDIER_MACHINEGUN_7, MZ2_SOLDIER_MACHINEGUN_8};

void soldier_fire_barrett (edict_t *self, int flash_number)
{
	vec3_t	start;
	vec3_t	forward, right, up;
	vec3_t	aim;
	vec3_t	dir;
	vec3_t	end;
	float	r, u;
	int		flash_index;

	//TROND tatt vekk 13/3
	/*
	if (self->s.skinnum < 2)
		flash_index = blaster_flash[flash_number];
	else if (self->s.skinnum < 4)
		flash_index = shotgun_flash[flash_number];
	else
		flash_index = machinegun_flash[flash_number];
	*/
	flash_index = blaster_flash[flash_number];

	AngleVectors (self->s.angles, forward, right, NULL);
	G_ProjectSource (self->s.origin, monster_flash_offset[flash_index], forward, right, start);

	if (flash_number == 5 || flash_number == 6)
	{
		VectorCopy (forward, aim);
	}
	else
	{
		VectorCopy (self->enemy->s.origin, end);
		end[2] += self->enemy->viewheight;
		VectorSubtract (end, start, aim);
		vectoangles (aim, dir);
		AngleVectors (dir, forward, right, up);

		r = crandom()*1000;
		u = crandom()*500;
		VectorMA (start, 8192, forward, end);
		VectorMA (end, r, right, end);
		VectorMA (end, u, up, end);

		VectorSubtract (end, start, aim);
		VectorNormalize (aim);
	}

	//TROND mekk 13/3
//	if (self->s.skinnum <= 1)
//	{
	if (deathmatch->value)
	{
		monster_fire_barrett (self, start, aim, 200, 150, 200, 200, flash_index);
	}
	else
	{
		monster_fire_barrett (self, start, aim, 2000, 150, 700, 700, flash_index);
	}
	//		monster_fire_blaster (self, start, aim, 5, 600, flash_index, EF_BLASTER);
/*	}
	else if (self->s.skinnum <= 3)
	{
		monster_fire_shotgun (self, start, aim, 2, 1, DEFAULT_SHOTGUN_HSPREAD, DEFAULT_SHOTGUN_VSPREAD, DEFAULT_SHOTGUN_COUNT, flash_index);
	}
	else
	{
		if (!(self->monsterinfo.aiflags & AI_HOLD_FRAME))
			self->monsterinfo.pausetime = level.time + (3 + rand() % 8) * FRAMETIME;

		monster_fire_bullet (self, start, aim, 2, 4, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, flash_index);

		if (level.time >= self->monsterinfo.pausetime)
			self->monsterinfo.aiflags &= ~AI_HOLD_FRAME;
		else
			self->monsterinfo.aiflags |= AI_HOLD_FRAME;
	}*/
}

// ATTACK1 (blaster/shotgun)

void soldier_fire1_barrett (edict_t *self)
{
	soldier_fire_barrett (self, 0);
}

void soldier_attack1_refire1_barrett (edict_t *self)
{
	//TROND mekk 13/3
//	if (self->s.skinnum > 1)
//	if (self->classname != "police")
		return;

	if (self->enemy->health <= 0)
		return;

	if ( ((skill->value == 3) && (random() < 0.5)) || (range(self, self->enemy) == RANGE_MELEE) )
		self->monsterinfo.nextframe = 46;
	else
		self->monsterinfo.nextframe = 46;
}

void soldier_attack1_refire2_barrett (edict_t *self)
{
	//TROND mekk 13/3
//	if (self->s.skinnum < 2)
//		return;

	if (self->enemy->health <= 0)
		return;

	if ( ((skill->value == 3) && (random() < 0.5)) || (range(self, self->enemy) == RANGE_MELEE) )
		self->monsterinfo.nextframe = 46;
}

mframe_t soldier_frames_attack1_barrett [] =
{
	ai_charge, 0,  NULL,
	ai_charge, 0,  soldier_fire1_barrett,
	ai_charge, 0,  NULL,
	ai_charge, 0,  NULL,
	ai_charge, 0,  NULL,
	ai_charge, 0,  NULL,
	ai_charge, 0,  NULL,
	ai_charge, 0,  NULL
};
mmove_t soldier_move_attack1_barrett = {46, 53, soldier_frames_attack1_barrett, soldier_run_barrett};

// ATTACK2 (blaster/shotgun)

void soldier_fire2_barrett (edict_t *self)
{
	soldier_fire_barrett (self, 1);
}

void soldier_attack2_refire1_barrett (edict_t *self)
{
//TROND mekk 13/3
//	if (self->s.skinnum > 1)
//		return;

	if (self->enemy->health <= 0)
		return;

	if ( ((skill->value == 3) && (random() < 0.5)) || (range(self, self->enemy) == RANGE_MELEE) )
		self->monsterinfo.nextframe = 46;
	else
		self->monsterinfo.nextframe = 48;
}

void soldier_attack2_refire2_barrett (edict_t *self)
{
//TROND mekk 13/3
//	if (self->s.skinnum < 2)
//		return;

	if (self->enemy->health <= 0)
		return;

	if ( ((skill->value == 3) && (random() < 0.5)) || (range(self, self->enemy) == RANGE_MELEE) )
		self->monsterinfo.nextframe = 50;
}

mframe_t soldier_frames_attack2_barrett [] =
{
	ai_charge, 0, NULL,
	ai_charge, 0, soldier_fire2_barrett,
	ai_charge, 0, NULL,
	ai_charge, 0, NULL,
	ai_charge, 0, NULL,
	ai_charge, 0, soldier_fire2_barrett,
	ai_charge, 0, NULL,
	ai_charge, 0, NULL
};
mmove_t soldier_move_attack2_barrett = {46, 53, soldier_frames_attack2_barrett, soldier_run_barrett};

// ATTACK3 (duck and shoot)

void soldier_duck_down_barrett (edict_t *self)
{
	if (self->monsterinfo.aiflags & AI_DUCKED)
		return;
	self->monsterinfo.aiflags |= AI_DUCKED;
	self->maxs[2] -= 32;
	self->takedamage = DAMAGE_YES;
	self->monsterinfo.pausetime = level.time + 1;
	gi.linkentity (self);
}

void soldier_duck_up_barrett (edict_t *self)
{
	self->monsterinfo.aiflags &= ~AI_DUCKED;
	self->maxs[2] += 32;
	self->takedamage = DAMAGE_AIM;
	gi.linkentity (self);
}

void soldier_fire3_barrett (edict_t *self)
{
	soldier_duck_down_barrett (self);
	soldier_fire_barrett (self, 2);
}

void soldier_attack3_refire_barrett (edict_t *self)
{
	if ((level.time + 0.4) < self->monsterinfo.pausetime)
		self->monsterinfo.nextframe = 46;
}

mframe_t soldier_frames_attack3_barrett [] =
{
	ai_charge, 0, soldier_fire3_barrett,
	ai_charge, 0, NULL,
	ai_charge, 0, soldier_fire3_barrett,
	ai_charge, 0, soldier_duck_up_barrett
};
mmove_t soldier_move_attack3_barrett = {46, 49, soldier_frames_attack3_barrett, soldier_run_barrett};

// ATTACK4 (machinegun)

void soldier_fire4_barrett (edict_t *self)
{
	soldier_fire_barrett (self, 3);
//
//	if (self->enemy->health <= 0)
//		return;
//
//	if ( ((skill->value == 3) && (random() < 0.5)) || (range(self, self->enemy) == RANGE_MELEE) )
//		self->monsterinfo.nextframe = FRAME_attak402;
}

mframe_t soldier_frames_attack4_barrett [] =
{
	ai_charge, 0, soldier_fire4_barrett,
	ai_charge, 0, NULL
};
mmove_t soldier_move_attack4_barrett = {46, 47, soldier_frames_attack4_barrett, soldier_run_barrett};

#if 0
// ATTACK5 (prone)

void soldier_fire5 (edict_t *self)
{
	soldier_fire (self, 4);
}

void soldier_attack5_refire (edict_t *self)
{
	if (self->enemy->health <= 0)
		return;

	if ( ((skill->value == 3) && (random() < 0.5)) || (range(self, self->enemy) == RANGE_MELEE) )
		self->monsterinfo.nextframe = 46;
}

mframe_t soldier_frames_attack5 [] =
{
	ai_charge, 8, NULL,
	ai_charge, 8, NULL,
	ai_charge, 0, NULL,
	ai_charge, 0, NULL,
	ai_charge, 0, soldier_fire5,
	ai_charge, 0, NULL,
	ai_charge, 0, NULL,
	ai_charge, 0, soldier_attack5_refire
};
mmove_t soldier_move_attack5 = {46, 53, soldier_frames_attack5, soldier_run};
#endif

// ATTACK6 (run & shoot)

void soldier_fire8_barrett (edict_t *self)
{
	soldier_fire_barrett (self, 7);
}

void soldier_attack6_refire_barrett (edict_t *self)
{
	if (self->enemy->health <= 0)
		return;

	if (range(self, self->enemy) < RANGE_MID)
		return;

	if (skill->value == 3)
		self->monsterinfo.nextframe = 46;
}

mframe_t soldier_frames_attack6_barrett [] =
{
	ai_charge, 12, NULL,
	ai_charge, 11, soldier_fire8_barrett,
	ai_charge, 12, NULL,
	ai_charge, 17, soldier_attack6_refire_barrett
};
mmove_t soldier_move_attack6_barrett = {46, 49, soldier_frames_attack6_barrett, soldier_run_barrett};

void soldier_attack_barrett(edict_t *self)
{
//TROND mekk 13/3
//	if (self->s.skinnum < 4)
//	{
//		if (random() < 0.5)
	if (rand ()& 1)
		self->monsterinfo.currentmove = &soldier_move_attack1_barrett;
	else if (rand ()& 2)
		self->monsterinfo.currentmove = &soldier_move_attack2_barrett;
	else
		self->monsterinfo.currentmove = &soldier_move_attack4_barrett;
//	}
//	else
//	{
//		self->monsterinfo.currentmove = &soldier_move_attack4;
//	}
}


//
// SIGHT
//

void soldier_sight_barrett(edict_t *self, edict_t *other)
{
	if (random() < 0.5)
		gi.sound (self, CHAN_VOICE, sound_sight1, 1, ATTN_NORM, 0);
	else
		gi.sound (self, CHAN_VOICE, sound_sight2, 1, ATTN_NORM, 0);

	if ((skill->value > 0) && (range(self, self->enemy) >= RANGE_MID))//TROND 17/3 var _MID))
	{
//		if (random() > 0.5)//TROND 17/3 var 0.5
		if (random() > 0.5)
			self->monsterinfo.currentmove = &soldier_move_attack6_barrett;//TROND 17/3 var _attack6;
	}
}

//
// DUCK
//

void soldier_duck_hold_barrett (edict_t *self)
{
	if (level.time >= self->monsterinfo.pausetime)
		self->monsterinfo.aiflags &= ~AI_HOLD_FRAME;
	else
		self->monsterinfo.aiflags |= AI_HOLD_FRAME;
}

mframe_t soldier_frames_duck_barrett [] =
{
	ai_move, 5, soldier_duck_down_barrett,
	ai_move, -1, soldier_duck_hold_barrett,
	ai_move, 1,  NULL,
	ai_move, 0,  soldier_duck_up_barrett,
	ai_move, 5,  NULL
};
mmove_t soldier_move_duck_barrett = {135, 139, soldier_frames_duck_barrett, soldier_run_barrett};

void soldier_dodge_barrett (edict_t *self, edict_t *attacker, float eta)
{
	float	r;

	r = random();
	if (r > 0.25)
		return;

	if (!self->enemy)
		self->enemy = attacker;

	if (skill->value == 0)
	{
		self->monsterinfo.currentmove = &soldier_move_duck_barrett;
		return;
	}

	self->monsterinfo.pausetime = level.time + eta + 0.3;
	r = random();

	if (skill->value == 1)
	{
		if (r > 0.33)
			self->monsterinfo.currentmove = &soldier_move_duck_barrett;
		else
			self->monsterinfo.currentmove = &soldier_move_attack3_barrett;
		return;
	}

	if (skill->value >= 2)
	{
		if (r > 0.66)
			self->monsterinfo.currentmove = &soldier_move_duck_barrett;
		else
			self->monsterinfo.currentmove = &soldier_move_attack3_barrett;
		return;
	}

	self->monsterinfo.currentmove = &soldier_move_attack3_barrett;
}


//
// DEATH
//
//TROND 14/3 DM respawn rutine
void DM_Respawn_Barrett (edict_t *soldier)
{
	edict_t		*self;
	edict_t		*target = NULL;
	vec3_t		spawn_origin;
	vec3_t		spawn_angles;

	self = G_Spawn();

	SelectSpawnPoint (self, spawn_origin, spawn_angles);
	VectorCopy (spawn_origin, self->s.origin);
	gi.linkentity(self);

	SP_monster_soldier_barrett_x (self);

	sound_pain_light = gi.soundindex ("soldier/solpain2.wav");

	sound_death_light =	gi.soundindex ("soldier/soldeth2.wav");
	gi.modelindex ("models/objects/laser/tris.md2");
	gi.soundindex ("misc/lasfly.wav");
	gi.soundindex ("soldier/solatck2.wav");

	self->classname = "police";
	self->s.renderfx |= RF_IR_VISIBLE;
	self->s.skinnum = 0;
	self->health = 100;
	self->gib_health = -999999;
	self->s.modelindex2 = gi.modelindex("players/team2/w_barrett.md2");
	self->s.modelindex3 = gi.modelindex("players/team2/i_vest.md2");
	self->s.modelindex4 = gi.modelindex("players/team2/i_helmet.md2");

	self->monsterinfo.walk (self);

	if (deathmatch->value)
	{
		while ((target = findradius (target, self->s.origin, 8000)) != NULL)
		{
			if (target->client)
			{
				self->enemy = target;
//				gi.cprintf (target, PRINT_HIGH, "You are an UZI bot`s enemy, have fun\n");
			}
		}
	}
}
//TROND slutt

void soldier_fire6_barrett (edict_t *self)
{
	soldier_fire_barrett (self, 5);
}

void soldier_fire7_barrett (edict_t *self)
{
	soldier_fire_barrett (self, 6);
}

void soldier_dead_barrett (edict_t *self)
{
	VectorSet (self->mins, -16, -16, -24);
	VectorSet (self->maxs, 16, 16, -8);
	self->movetype = MOVETYPE_TOSS;
	self->svflags |= SVF_DEADMONSTER;
	//TROND 17/3
	//self->nextthink = 0;
	if (deathmatch->value)
	{
		self->nextthink = level.time + 30;
		self->think = G_FreeEdict;
		DM_Respawn_Barrett (self);
	}
	else
		self->nextthink = 0;
	//TROND slutt
	gi.linkentity (self);
}

mframe_t soldier_frames_death1_barrett [] =
{
	ai_move, -10, NULL,
	ai_move, -5,  NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL
};
mmove_t soldier_move_death1_barrett = {178, 183, soldier_frames_death1_barrett, soldier_dead_barrett};

mframe_t soldier_frames_death2_barrett [] =
{
	ai_move, -5,  NULL,
	ai_move, -5,  NULL,
	ai_move, -5,  NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL
};
mmove_t soldier_move_death2_barrett = {184, 189, soldier_frames_death2_barrett, soldier_dead_barrett};

mframe_t soldier_frames_death3_barrett [] =
{
	ai_move, -5,  NULL,
	ai_move, -5,  NULL,
	ai_move, -5,  NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL,
	ai_move, 0,   NULL
};
mmove_t soldier_move_death3_barrett = {190, 197, soldier_frames_death3_barrett, soldier_dead_barrett};

void soldier_die_barrett (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
	int		n;
	gitem_t		*item;
	edict_t		*drop;
/*	edict_t *spot;

	spot = NULL;
*/
// check for gib
	if (self->health <= self->gib_health)
	{
		gi.sound (self, CHAN_VOICE, gi.soundindex ("misc/udeath.wav"), 1, ATTN_NORM, 0);
		for (n= 0; n < 3; n++)
			ThrowGib (self, "models/objects/gibs/sm_meat/tris.md2", damage, GIB_ORGANIC);
		ThrowGib (self, "models/objects/gibs/chest/tris.md2", damage, GIB_ORGANIC);
		ThrowHead (self, "models/objects/gibs/head2/tris.md2", damage, GIB_ORGANIC);
		self->deadflag = DEAD_DEAD;
		return;
	}

	if (self->deadflag == DEAD_DEAD)
		return;

// regular death
	self->deadflag = DEAD_DEAD;
	self->takedamage = DAMAGE_NO;//TROND 13/3 var YES
	self->solid = SOLID_NOT;//TROND lnije 13/3
//	self->s.skinnum |= 1;

	if (rand ()& 2)
		gi.sound (self, CHAN_VOICE, sound_death_light, 1, ATTN_NORM, 0);
	else if (rand ()& 1)
		gi.sound (self, CHAN_VOICE, sound_death, 1, ATTN_NORM, 0);
	else // (self->s.skinnum == 5)
		gi.sound (self, CHAN_VOICE, sound_death_ss, 1, ATTN_NORM, 0);

/*	if (fabs((self->s.origin[2] + self->viewheight) - point[2]) <= 4)
	{
		// head shot
		self->monsterinfo.currentmove = &soldier_move_death3;
		return;
	}*/

	if (self->skinnum_frame == 3)
		self->monsterinfo.currentmove = &soldier_move_death1_barrett;
	else if (self->skinnum_frame == 2)
		self->monsterinfo.currentmove = &soldier_move_death2_barrett;
	else
		self->monsterinfo.currentmove = &soldier_move_death3_barrett;
/*
	spot = G_Find(spot, FOFS(classname), "player");
	VectorCopy (spot->s.origin, self->s.origin);
	self->s.origin[2] += 40;
	gi.linkentity (self);*/

	if (!deathmatch->value)
	{
		if (self->s.modelindex3)
		{
			item = FindItem("bullet proof vest");
			drop = Drop_Item (self, item);
		}
		if (self->s.modelindex4)
		{
			item = FindItem("helmet");
			drop = Drop_Item (self, item);
		}
		if (self->s.modelindex2)
		{
			item = FindItem("barrett");
			drop = Drop_Item (self, item);
			drop->ammo = 6;
		}
	}
	self->s.modelindex4 = 0;
	self->s.modelindex3 = 0;
	self->s.modelindex2 = 0;
	if (deathmatch->value)
	{
		if (self->enemy
			&& self->enemy->client)
			self->enemy->client->resp.score++;
	}
}


//
// SPAWN
//

void SP_monster_soldier_barrett_x (edict_t *self)
{

//	self->s.modelindex = gi.modelindex ("models/monsters/soldier/tris.md2");
	self->s.modelindex = gi.modelindex ("players/team2/tris.md2");
	self->monsterinfo.scale = MODEL_SCALE;
	VectorSet (self->mins, -16, -16, -24);
	VectorSet (self->maxs, 16, 16, 32);
	self->movetype = MOVETYPE_STEP;
	self->solid = SOLID_BBOX;

	sound_idle =	gi.soundindex ("soldier/solidle1.wav");
	sound_sight1 =	gi.soundindex ("soldier/solsght1.wav");
	sound_sight2 =	gi.soundindex ("soldier/solsrch1.wav");
	sound_cock =	gi.soundindex ("infantry/infatck3.wav");

	self->mass = 200;

	self->pain = soldier_pain_barrett;
	self->die = soldier_die_barrett;

	self->monsterinfo.stand = soldier_stand_barrett;
	self->monsterinfo.walk = soldier_walk_barrett;
	self->monsterinfo.run = soldier_run_barrett;
	self->monsterinfo.dodge = soldier_dodge_barrett;
	self->monsterinfo.attack = soldier_attack_barrett;
	self->monsterinfo.melee = NULL;
	self->monsterinfo.sight = soldier_sight_barrett;

	gi.linkentity (self);

	self->monsterinfo.stand (self);

	walkmonster_start (self);

	if (deathmatch->value)
		self->monsterinfo.run (self);
}


/*QUAKED monster_soldier_light (1 .5 0) (-16 -16 -24) (16 16 32) Ambush Trigger_Spawn Sight
*/
void SP_monster_soldier_barrett (edict_t *self)
{
//TROND tatt vekk 13/3
//tatt tilbake 16/3 pga spawn funk
	
	if (deathmatch->value)
	{
		G_FreeEdict (self);
		return;
	}
	
//TROND slutt

	SP_monster_soldier_barrett_x (self);

	sound_pain_light = gi.soundindex ("soldier/solpain2.wav");
	sound_death_light =	gi.soundindex ("soldier/soldeth2.wav");
	gi.modelindex ("models/objects/laser/tris.md2");
	gi.soundindex ("misc/lasfly.wav");
	gi.soundindex ("soldier/solatck2.wav");

//	self->classname = "police";
	self->s.renderfx |= RF_IR_VISIBLE;
	self->s.skinnum = 0;
	self->health = 100;
	self->gib_health = -999999;
	self->s.modelindex2 = gi.modelindex("players/team2/w_barrett.md2");
	self->s.modelindex3 = gi.modelindex("players/team2/i_vest.md2");
	self->s.modelindex4 = gi.modelindex("players/team2/i_helmet.md2");
//	self->s.modelindex4 = gi.modelindex("players/team2/w_helmet.md2");
}


