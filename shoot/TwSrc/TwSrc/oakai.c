#include "g_local.h"
#include "m_player.h"
#include "oak.h"

void oak_stand(edict_t *self)
{
	edict_t	*target;

//	gi.bprintf(PRINT_HIGH, "Oak: in oak_stand\n");

	self->enemy = NULL;

	// look for a target
	target = findradius(NULL, self->s.origin, OAK_FIND_RANGE);
	while(target)
	{
		if (visible(self, target))
		{
			if (infront(self, target))
			{
				if (strcmp(target->classname, "player") == 0)
				{
					//gi.bprintf(PRINT_HIGH, "Oak: in oak_stand selecting you as target\n");
					self->enemy = target;
				}
			}
		}

		// next taget
		target = findradius(target, self->s.origin, OAK_FIND_RANGE);
	}
	
	if (self->enemy != NULL)
	{
		//gi.bprintf(PRINT_HIGH, "Oak: in oak_stand turning to face you\n");	
		OakAI_FaceEnemy(self);
               OakAI_RunFrames(self, FRAME_run1, FRAME_run6);
       //         self->think = oak_run;
	}
	else
	{
		// run the anim frames
		OakAI_RunFrames(self, FRAME_stand01, FRAME_stand40);
	}
	self->nextthink = level.time + 0.1;
}

/************************************************
*
* Function:	oak_run
*
* Description: the gneral runaround think function
*
* Arguements:	
* self 
*
* Returns:
* void
*
*************************************************/

void oak_run(edict_t *self)
{
	OakAI_RunFrames(self, FRAME_run1, FRAME_run6);

	OakAI_FaceEnemy(self);
       
	self->nextthink = level.time + 0.1;
}

/************************************************
*
* Function:	oak_pain
*
* Description: what to do when hurt
*
* Arguements:	
* self
* other - who hurt you
* kick 
* damage 
*
* Returns:
* void
*
*************************************************/

void oak_pain (edict_t *self, edict_t *other, float kick, int damage)
{
	gi.bprintf(PRINT_HIGH, "Oak: in oak_pain ouch!\n");
	OakAI_RunFrames(self, FRAME_pain101, FRAME_pain104);
	self->enemy = other;
	self->think = oak_painthink;
	self->nextthink = level.time + 0.1;
	self->monsterinfo.idle_time = level.time + 0.3;
}

void oak_painthink(edict_t *self)
{
	gi.bprintf(PRINT_HIGH, "Oak: in oak_painthink running anim\n");
	if (self->monsterinfo.idle_time >= level.time)
	{
		OakAI_RunFrames(self, FRAME_pain101, FRAME_pain104);
	}
	else
	{
		self->think = oak_run;
	}
	self->nextthink = level.time + 0.1;
}

/************************************************
*
* Function:	oak_die
*
* Description: how to die
*
* Arguements:	
* self
* inflictor
* attacker
* damage
* point 
*
* Returns:
* void
*
*************************************************/

void oak_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
	int i;

	// throw the weapon

	
//	if (self->health < self.gib_health)
//	{	// gib
		gi.sound (self, CHAN_BODY, gi.soundindex ("misc/udeath.wav"), 1, ATTN_NORM, 0);
		for (i= 0; i < 4; i++)
			ThrowGib (self, "models/objects/gibs/sm_meat/tris.md2", damage, GIB_ORGANIC);

		self->takedamage = DAMAGE_NO;

		// respawn the bot
		OAK_Respawn(self);
//	}
//	else
//	{	// normal death


//	}
}

/************************************************
*
* Function:	OakAI_FaceEnemy
*
* Description: turn to face a enemy
*
* Arguements:	
* self 
*
* Returns:
* void
*
*************************************************/

void OakAI_FaceEnemy(edict_t *self)
{
	vec3_t	v;

	VectorSubtract (self->enemy->s.origin, self->s.origin, v);
	self->ideal_yaw = vectoyaw(v);
	M_ChangeYaw (self);
}

/************************************************
*
* Function:	OakAI_MoveToEnemy
*
* Description: moves bot towards a enemy assumes enemy dead ahead
*
* Arguements:	
* self
* dist
*
* Returns:
* void
*
*************************************************/

void oak_standclose(edict_t *self)
{
	float i;

	if (self->enemy &&  SV_CloseEnough (self, self->enemy, OAK_RUN) )
	{
		if (((i = random()) < 0.9) && (self->monsterinfo.idle_time < level.time))
		{
			OakAI_RunFrames(self, FRAME_stand01, FRAME_stand40);
		}
		else
		{
			if (self->monsterinfo.idle_time < level.time)
			{
				self->monsterinfo.idle_time = level.time + 1.0;
			}
			OakAI_Wave(self);
		}
	}
	else
	{
		self->think = oak_stand;
	}
	self->nextthink = level.time + 0.1;
}

/************************************************
*
* Animation Functions 
*
************************************************/
/************************************************
*
* Function:	OakAI_RunFrames
*
* Description: runs the anim frames
*
* Arguements:	
* start
* end 
*
* Returns:
* void
*
*************************************************/

void OakAI_RunFrames(edict_t *self, int start, int end)
{
	if ((self->s.frame < end) && (self->s.frame >= start))
	{
		self->s.frame++;
	}
	else 
	{
		self->s.frame = start;
	}

}

/************************************************
*
* Function:	OakAI_Finger
*
* Description: runs the anim frames
*
* Arguements:	
* start
* end 
*
* Returns:
* void
*
*************************************************/

void OakAI_Finger(edict_t *self)
{
	OakAI_RunFrames(self, FRAME_flip01, FRAME_flip12);	
}

/************************************************
*
* Function:	OakAI_Taunt
*
* Description: runs the anim frames
*
* Arguements:	
* start
* end 
*
* Returns:
* void
*
*************************************************/

void OakAI_Taunt(edict_t *self)
{
	OakAI_RunFrames(self, FRAME_taunt01, FRAME_taunt17);	
}

/************************************************
*
* Function:	OakAI_Wave
*
* Description: runs the anim frames
*
* Arguements:	
* start
* end 
*
* Returns:
* void
*
*************************************************/

void OakAI_Wave(edict_t *self)
{
	OakAI_RunFrames(self, FRAME_wave01, FRAME_wave11);	
}

/************************************************
*
* Function:	OakAI_Salute
*
* Description: runs the anim frames
*
* Arguements:	
* start
* end 
*
* Returns:
* void
*
*************************************************/

void OakAI_Salute(edict_t *self)
{
	OakAI_RunFrames(self, FRAME_salute01, FRAME_salute11);	
}

/************************************************
*
* Function:	OakAI_Point
*
* Description: runs the anim frames
*
* Arguements:	
* start
* end 
*
* Returns:
* void
*
*************************************************/

void OakAI_Point(edict_t *self)
{
	OakAI_RunFrames(self, FRAME_point01, FRAME_point12);	
}

