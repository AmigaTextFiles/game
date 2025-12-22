/*************************************************
*
* Module:		oak.c
*
* Author:		John Crickett
*				john@crickett.demon.co.uk
*
* Date:			12/12/97
*
* Version:		0.0
*
*
* Module description:
* -------------------
*
* Oak main code (spawning etc)
*
*
* Version History:
* ----------------
*
* 0.0 - intitial release
*
************************************************/

/************************************************
*
* Includes
*
************************************************/

#include "g_local.h"
#include "oak.h"

/************************************************
*
* Function:	Oak_Check_SP
*
* Description: checks wether it is ok to spawn a oak
*
* Arguements:
* void
*
* Returns:
* void
*
*************************************************/

void OAK_Check_SP(edict_t *ent)
{
	// only spawn a bot in deathmatch
	if (deathmatch->value)
	{
                SP_Oak();
	}
	else
	{
		gi.cprintf (ent, PRINT_HIGH, "Sorry Oak II is a deathmatch only bot.\n");
	}
}

/************************************************
*
* Function:	SP_Oak
*
* Description: spawns a oak bot
*
* Arguements:	
* void
*
* Returns:
* void
*
*************************************************/

void SP_Oak(void)
{
	edict_t *newOak;
	vec3_t	spawn_origin, spawn_angles;

	// spawn the bot on a spawn spot
	newOak = G_Spawn();
	SelectSpawnPoint (spawn_origin, spawn_angles);
	VectorCopy (spawn_origin, newOak->s.origin);
        newOak->s.origin[2] += 32;       // make sure off ground
	
        newOak->classname = "player";
	newOak->takedamage = DAMAGE_AIM;
        newOak->movetype = MOVETYPE_STEP;
	newOak->mass = 200;
	newOak->solid = SOLID_BBOX;
	newOak->deadflag = DEAD_NO;
	newOak->clipmask = MASK_PLAYERSOLID;
	newOak->model = "players/male/tris.md2";
	newOak->s.modelindex = 255;
	newOak->s.modelindex2 = 255;		// custom gun model
	newOak->s.frame = 0;
	newOak->waterlevel = 0;
	newOak->watertype = 0;
	newOak->health = 100;
	newOak->max_health = 100;
	newOak->gib_health = -40;
	/* FIXME err we need to set these!!!
	newOak->max_bullets = 200;
	newOak->max_shells = 100;
	newOak->max_rockets = 50;
	newOak->max_grenades = 50;
	newOak->max_cells = 200;
	newOak->max_slugs = 50;
	newOak->inuse = true;
	*/ 

	// think functions?
	newOak->pain = oak_pain;
	newOak->die = oak_die;

	//newOak->nextthink = 0;
	newOak->think = oak_stand;
	newOak->nextthink = level.time + 0.1;

	newOak->yaw_speed = 20;
	newOak->s.angles[PITCH] = 0;
	newOak->s.angles[YAW] = spawn_angles[YAW];
	newOak->s.angles[ROLL] = 0;

        VectorSet (newOak->mins, -16, -16, -24);
	VectorSet (newOak->maxs, 16, 16, 32);
	VectorClear (newOak->velocity);

	KillBox(newOak);

	gi.linkentity (newOak);
	gi.bprintf (PRINT_HIGH, "A Oak bot has entered the game\n");

}

void OAK_Respawn(edict_t *self)
{
	vec3_t	spawn_origin, spawn_angles;

	// spawn the bot on a spawn spot
	SelectSpawnPoint(spawn_origin, spawn_angles);
	VectorCopy (spawn_origin, self->s.origin);
        self->s.origin[2] += 32; // make sure off ground

	self->deadflag = DEAD_NO;
	self->takedamage = DAMAGE_AIM;

	self->model = "players/male/tris.md2";
	self->s.modelindex = 255;
	self->s.modelindex2 = 255;		// custom gun model
	self->s.frame = 0;
	self->waterlevel = 0;
	self->watertype = 0;
	self->health = 100;
	self->max_health = 100;
	self->gib_health = -40;

	self->pain = oak_pain;
	self->die = oak_die;
	self->monsterinfo.stand = oak_stand;

        VectorSet(self->mins, -16, -16, -24);
	VectorSet(self->maxs, 16, 16, 32);
	VectorClear(self->velocity);

	self->think = oak_stand;
	self->nextthink = level.time + 0.1;

	KillBox(self);

	gi.linkentity(self);
        gi.bprintf(PRINT_HIGH, "A Drone has respawned\n");

}

