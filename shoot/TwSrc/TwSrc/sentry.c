    #include "g_local.h"
    #include "m_player.h"

    static int	sound_idle;
    static int	sound_sight1;
    static int	sound_sight2;
    static int	sound_pain;
    static int	sound_death;

// STAND frames
void sentry_idle (edict_t *self)
{
	if (random() > 0.8)
		gi.sound (self, CHAN_VOICE, sound_idle, 1, ATTN_IDLE, 0);
}

void sentry_stand (edict_t *self);

mframe_t sentry_frames_stand1 [] =
{
    ai_stand, 0, sentry_idle,
    ai_stand, 0, NULL,
};
mmove_t sentry_move_stand1 = {FRAME_stand01, FRAME_stand01, sentry_frames_stand1, sentry_stand};

void sentry_stand (edict_t *self)
{
    self->monsterinfo.currentmove = &sentry_move_stand1;
}


// TAUNT frames
void sentry_taunt (edict_t *self);

mframe_t sentry_frames_taunt1 [] =
{
    ai_stand, 0, sentry_idle,
    ai_stand, 0, NULL,
};
mmove_t sentry_move_taunt1 = {FRAME_taunt01, FRAME_taunt01, sentry_frames_taunt1, sentry_taunt};

void sentry_taunt (edict_t *self)
{
    self->monsterinfo.currentmove = &sentry_move_taunt1;
}


//
// RUN frames
//
void sentry_run (edict_t *self);
mframe_t sentry_frames_run [] =
{
    ai_run, 0, NULL,
};
mmove_t sentry_move_run = {FRAME_run1, FRAME_run1, sentry_frames_run, sentry_run};

void sentry_run (edict_t *self)
{
    if (self->monsterinfo.aiflags & AI_STAND_GROUND)
    {
        self->monsterinfo.currentmove = &sentry_move_stand1;
        return;
    }

    self->monsterinfo.currentmove = &sentry_move_run;
}


//
// PAIN frames
//
mframe_t sentry_frames_pain1 [] =
{
        ai_move, 0, NULL,
        ai_move, 0,  NULL,
        ai_move, 0,  NULL,
	ai_move, 0,  NULL
};
mmove_t sentry_move_pain1 = {FRAME_pain101, FRAME_pain102, sentry_frames_pain1, sentry_run};

void sentry_pain (edict_t *self, edict_t *other, float kick, int damage)
{
return;
    if (level.time < self->pain_debounce_time)
        return;

    self->pain_debounce_time = level.time + 3;
    gi.sound (self, CHAN_VOICE, sound_pain, 1, ATTN_NORM, 0);
//      return;
    self->monsterinfo.currentmove = &sentry_move_pain1;
}


//
// ATTACK frames
//
static int blaster_flash [] = {MZ2_SOLDIER_BLASTER_1, MZ2_SOLDIER_BLASTER_2, MZ2_SOLDIER_BLASTER_3, MZ2_SOLDIER_BLASTER_4, MZ2_SOLDIER_BLASTER_5, MZ2_SOLDIER_BLASTER_6, MZ2_SOLDIER_BLASTER_7, MZ2_SOLDIER_BLASTER_8};
static int shotgun_flash [] = {MZ2_SOLDIER_SHOTGUN_1, MZ2_SOLDIER_SHOTGUN_2, MZ2_SOLDIER_SHOTGUN_3, MZ2_SOLDIER_SHOTGUN_4, MZ2_SOLDIER_SHOTGUN_5, MZ2_SOLDIER_SHOTGUN_6, MZ2_SOLDIER_SHOTGUN_7, MZ2_SOLDIER_SHOTGUN_8};
static int machinegun_flash [] = {MZ2_SOLDIER_MACHINEGUN_1, MZ2_SOLDIER_MACHINEGUN_2, MZ2_SOLDIER_MACHINEGUN_3, MZ2_SOLDIER_MACHINEGUN_4, MZ2_SOLDIER_MACHINEGUN_5, MZ2_SOLDIER_MACHINEGUN_6, MZ2_SOLDIER_MACHINEGUN_7, MZ2_SOLDIER_MACHINEGUN_8};



void sentry_fire (edict_t *self, int flash_number)
{
    vec3_t  start;
    vec3_t  forward, right, up;
    vec3_t  aim;
    vec3_t  dir;
    vec3_t  end;
    float   r, u;
    int     flash_index;

    flash_index = shotgun_flash[flash_number];

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
//       if (!(self->monsterinfo.aiflags & AI_HOLD_FRAME))
 //   self->monsterinfo.pausetime = level.time + (3 + rand() % 8) * FRAMETIME;
  self->monsterinfo.pausetime = level.time + 0;

 monster_fire_shotgun (self, start, aim, 2, 1, DEFAULT_SHOTGUN_HSPREAD, DEFAULT_SHOTGUN_VSPREAD, 6, flash_index);

}


void sentry2_fire (edict_t *self)
{
        sentry_fire (self,0);
        sentry_fire (self,0);

        if (level.time >= self->monsterinfo.pausetime)
                self->monsterinfo.aiflags &= ~AI_HOLD_FRAME;
        else
                self->monsterinfo.aiflags |= AI_HOLD_FRAME;
}

vec3_t	aimangles[] =
{
	0.0, 5.0, 0.0,
	10.0, 15.0, 0.0,
	20.0, 25.0, 0.0,
	25.0, 35.0, 0.0,
	30.0, 40.0, 0.0,
	30.0, 45.0, 0.0,
	25.0, 50.0, 0.0,
	20.0, 40.0, 0.0,
	15.0, 35.0, 0.0,
	40.0, 35.0, 0.0,
	70.0, 35.0, 0.0,
	90.0, 35.0, 0.0
};
/*
void SentryMachineGun (edict_t *self, int flash_number)
{
    vec3_t  start;
    vec3_t  forward, right, up;
    vec3_t  aim;
    vec3_t  dir;
    vec3_t  end;
    float   r, u;
    int     flash_index;
    int     flash_number;
    flash_index = shotgun_flash[flash_number];

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

 monster_fire_shotgun (self, start, aim, 2, 1, DEFAULT_SHOTGUN_HSPREAD, DEFAULT_SHOTGUN_VSPREAD, DEFAULT_SHOTGUN_COUNT, flash_index);

}
*/

void SentryMachineGun (edict_t *self)
{
    float   r, u;
	vec3_t	start, target;
	vec3_t	forward, right;
        vec3_t  vec,up;
        vec3_t  end;
    vec3_t  dir;
    vec3_t  aim;
	int		flash_number;
    int     flash_index;

    flash_index = shotgun_flash[flash_number];


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




        fire_bullet (self, start, aim, 3, 4, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, flash_number);
}

mframe_t sentry_frames_attack1 [] =
{
    ai_charge, 0,  sentry2_fire
};
mmove_t sentry_move_attack1 = {FRAME_attack1, FRAME_attack1, sentry_frames_attack1, sentry_run};

void sentry_attack(edict_t *self)
{
    self->monsterinfo.currentmove = &sentry_move_attack1;
}

  //
  // SIGHT logic
  //
  void sentry_sight(edict_t *self, edict_t *other)
	{
	if (random() < 0.5)
		gi.sound (self, CHAN_VOICE, sound_sight1, 1, ATTN_NORM, 0);
	else
		gi.sound (self, CHAN_VOICE, sound_sight2, 1, ATTN_NORM, 0);
	}

  //
  // DEATH sequence
  //
  void sentry_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
	{
	//	int		n;

	if (self->deadflag == DEAD_DEAD)
		return;

	// regular death
	self->deadflag = DEAD_DEAD;
	self->takedamage = DAMAGE_YES;

	gi.sound (self, CHAN_VOICE, sound_death, 1, ATTN_NORM, 0);

        //do a BFG kind of explosion where the sentry was
	gi.WriteByte (svc_temp_entity);
        gi.WriteByte (TE_GRENADE_EXPLOSION);
	gi.WritePosition (self->s.origin);
	gi.multicast (self->s.origin, MULTICAST_PVS);
  
	//Clear pointer of owner
        self->creator->sentry = NULL;

	//Remove entity instead of playing death sequence
        G_FreeEdict (self);

	}

  //
  // SPAWN
  //
  void spawn_sentry (edict_t *owner)
  {
      edict_t *self;
      vec3_t forward;

      self = G_Spawn();

      // Place sentry 100 units forward of our position
      AngleVectors(owner->client->v_angle, forward, NULL, NULL);
      VectorMA(owner->s.origin, 100, forward, self->s.origin);
 
      //Link two entities together
      owner->sentry = self;      //for the owner, this is a pointer to the sentry
      self->creator = owner;    //for the sentry, this is a pointer to the owner

      //Use same model and skin as the person creating sentry
      //self->model = owner->model;
      self->s.skinnum = 0;
      self->s.modelindex = gi.modelindex("models/sentry/turret1/tris.md2");

      self->s.effects = 0;
      self->s.frame = 0;
      self->classname = "sentry";
      self->health = 20;
      self->max_health = 20;
      self->tw_team = owner->tw_team;

      self->monsterinfo.scale = MODEL_SCALE;
      VectorSet (self->mins, -16, -32, -24);
      VectorSet (self->maxs, 16, 8, 32);
      self->movetype = MOVETYPE_STEP;
      self->solid = SOLID_BBOX;
      self->clipmask = MASK_PLAYERSOLID;
      self->takedamage = DAMAGE_AIM;
      self->classname = "sentry";

      self->mass = 4000;
      self->pain = sentry_pain;
      self->die = sentry_die;
      self->monsterinfo.stand = sentry_stand;
      self->monsterinfo.walk = NULL;
      self->monsterinfo.run = sentry_attack;
      self->monsterinfo.dodge = NULL;
      self->monsterinfo.attack = sentry_attack;
      self->monsterinfo.melee = NULL;
      self->monsterinfo.sight = sentry_sight;

      //Dont attack anything to start with
      self->monsterinfo.aiflags & AI_GOOD_GUY;

      //Set up sounds
      //sound_idle =    gi.soundindex ("soldier/solidle1.wav");
      sound_sight1 =  gi.soundindex ("soldier/solsght1.wav");
      sound_sight2 =  gi.soundindex ("soldier/solsrch1.wav");
      sound_pain = gi.soundindex ("player/male/pain50_1.wav");
      sound_death = gi.soundindex ("misc/keyuse.wav");
      gi.soundindex ("soldier/solatck1.wav");

      self->health = 180;
      self->gib_health = -10;

      // Face the sentry the same direction as player
      self->s.angles[PITCH] = owner->s.angles[PITCH];
      self->s.angles[YAW] = owner->s.angles[YAW];
      self->s.angles[ROLL] = owner->s.angles[ROLL];

      gi.linkentity (self);

      // First animation sequence
      self->monsterinfo.stand (self);

      //Let monster code control this sentry
      walkmonster_start (self);
  }

  // SP_sentry - Handle sentry command
  void SP_sentry(edict_t *self) 
  {
    
      //See if we should sentry turn it on or off
      char    *string;
      int  turnon;

      string=gi.args();

      if (Q_stricmp ( string, "on") == 0) 
          turnon = true;
      else if (Q_stricmp ( string, "off") == 0) 
          turnon = false;
      else {  //toggle status
          if (self->sentry) turnon = false;
              else turnon = true;
      }


      //If they want to turn it on and it's already on, return
      if ( (turnon == true) && (self->sentry) ) return;

      //If they want to turn it off and it's already off, return
      if ( (turnon == false) && !(self->sentry) ) return;

      //Remove sentry if it exists
      if ( self->sentry ) 
      {
          G_FreeEdict(self->sentry);
          self->sentry = NULL;
          gi.cprintf (self, PRINT_HIGH, "sentry destroyed.\n");
          return;
          }

      //Create sentry
      spawn_sentry(self);

      gi.cprintf (self, PRINT_HIGH, "sentry created.\n");
      }


