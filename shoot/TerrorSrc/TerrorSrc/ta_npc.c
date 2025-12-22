#include "g_local.h"
#include "m_player.h"
#include "ta_npc.h"


//TROND
//NPC
void npc_dead (edict_t *NPC, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point);
void npc_idle(edict_t *ent);

static void NPC_Respawn (edict_t *self)
{	
	edict_t *NPC;

	NPC = G_Spawn();
	VectorCopy (self->s.old_origin, NPC->s.origin);
	gi.setmodel (NPC, "players/team2/tris.md2");
//	VectorCopy (self->s.old_origin, NPC->s.origin);
	NPC->s.origin[2] += 3;
	NPC->mass = 200;
	NPC->movetype = MOVETYPE_STEP;	

	NPC->s.modelindex2 = 0;		
	NPC->s.frame = 0;	
	NPC->waterlevel = 0;	
	NPC->watertype = 0;

	NPC->takedamage = DAMAGE_YES;
	NPC->deadflag = DEAD_NO;
	NPC->classname = "bot";
	NPC->mass = 200;
	NPC->s.skinnum = 0;
	NPC->skinnum_head = 0;
	NPC->skinnum_chest = 0;
	NPC->skinnum_stomach = 0;
	NPC->skinnum_leg = 0;

	NPC->die = npc_dead;
	NPC->health = 100;	
	NPC->max_health = 100;	
	NPC->gib_health = -9999;
	NPC->enemy = NULL;

	NPC->solid = SOLID_BBOX;

	NPC->think = npc_idle;
	NPC->s.renderfx |= RF_IR_VISIBLE;

	NPC->nextthink = level.time + 0.1;
	VectorSet (NPC->mins, -16, -16, -24);	
	VectorSet (NPC->maxs, 16, 16, 32);

	NPC->monsterinfo.aiflags |= AI_DUCKED;
	
	gi.linkentity (NPC);
}

void npc_idle(edict_t *ent)
{
//	edict_t		*body;
	vec3_t		dir;//, end;
	float		dist = 10;
	float		b_dist = 99999;
	edict_t		*player = NULL;
	vec3_t		muzzleflash;
//	trace_t		tr;

	muzzleflash[1] = ent->s.origin[1];
	muzzleflash[2] = ent->s.origin[2];
	muzzleflash[0] = ent->s.origin[0]+20;

	if (ent->enemy
		&& ent->health > 0)
	{
		VectorSubtract (ent->enemy->s.origin, ent->s.origin, dir);
		vectoangles (dir, dir);
		VectorCopy (dir, ent->s.angles);
	}
/*	if (ent->s.frame == 2
		|| ent->s.frame == 5
		|| ent->s.frame == 8
		|| ent->s.frame == 11)
	{*/
/*		VectorMA (ent->s.origin, 10, ent->s.angles, end);
		tr = gi.trace (ent->s.origin, NULL, NULL, end, ent, MASK_SHOT);
		if (tr.fraction < 1.0)
		{
		gi.WriteByte (svc_temp_entity);
		gi.WriteByte (TE_BFG_LASER);
		gi.WritePosition (ent->s.origin);
		gi.WritePosition (tr.endpos);
		gi.multicast (ent->s.origin, MULTICAST_PHS);
		}*/
//	}

	if (!(level.framenum % 10))
	{
		ent->bot_move = 0;
		ent->enemy = NULL;
	}

	while ((player = findradius (player, ent->s.origin, 200)) != NULL)
	{
		if (player->client)
			ent->enemy = player;
	}
	while ((player = findradius (player, ent->s.origin, 60)) != NULL)
	{
		if (player->client)
		{
			ent->bot_move = 0;
			ent->enemy = NULL;
		}
	}
	ent->s.angles[2] = 0;

	if (ent->enemy)
	{
		ent->bot_move = 1;
		M_walkmove(ent, ent->s.angles[YAW], dist);
	}

	if (ent->bot_move == 1
		&& ent->health > 0)
	{
		if (ent->s.frame < 40
			|| ent->s.frame == 45)
			ent->s.frame = 40;
		ent->s.frame++;
	}
	else if (!ent->velocity[0]
		&& ent->health > 0)
	{
		if (ent->s.frame > 38)
			ent->s.frame = 0;
		ent->s.frame++;
	}
	else
	{
		if (ent->skinnum_frame == 1)
		{
			ent->skinnum_frame = 100;
			ent->s.frame = 190;
		}
		if (ent->skinnum_frame == 2)
		{
			ent->skinnum_frame = 100;
			ent->s.frame = 184;
		}
		if (ent->skinnum_frame == 3)
		{
			ent->skinnum_frame = 100;
			ent->s.frame = 178;
		}
		if (ent->skinnum_frame == 0)
		{
			ent->skinnum_frame = 100;
			ent->s.frame = 178;
		}
		if (ent->skinnum_frame == 4)
		{
			ent->skinnum_frame = 100;
			ent->s.frame = 178;
		}
		if (ent->skinnum_frame == 5)
		{
			ent->skinnum_frame = 100;
			ent->s.frame = 178;
		}
		if (ent->skinnum_frame == 6)
		{
			ent->skinnum_frame = 100;
			ent->s.frame = 178;
		}
		ent->s.frame++;
	}

	if (ent->s.frame == 197
		|| ent->s.frame == 189
		|| ent->s.frame == 183)
	{
		ent->s.renderfx &= ~RF_IR_VISIBLE;
		return;
	}
	ent->nextthink = level.time + FRAMETIME;
/*	else
	{
		body = G_Spawn();
		VectorCopy (ent->s.origin, body->s.origin);
		body->s.modelindex = gi.modelindex ("players/team2/tris.md2");
		body->s.angles[YAW] = ent->s.angles[YAW];
		body->s.skinnum = ent->s.skinnum;
		body->s.frame = ent->s.frame;

		gi.linkentity (body);

		NPC_respawn (ent);
	}*/
}

void npc_dead (edict_t *NPC, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
/*	NPC->skinnum_head = 0;
	NPC->skinnum_chest = 0;
	NPC->skinnum_stomach = 0;
	NPC->skinnum_leg = 0;
	bot_pain (NPC);*/
	VectorCopy (NPC->s.old_origin, NPC->s.origin);
	attacker->client->resp.score += 1;
	attacker->client->kills += 1;
//	VectorCopy (NPC->s.origin, NPC->s.old_origin);
	NPC->solid = SOLID_NOT;
	NPC->nextthink = level.time + 5;
	NPC->think = NPC_Respawn;
//	NPC_Respawn (NPC);
}

void Cmd_NPC_f (edict_t *NPC)
{	
	gi.setmodel (NPC, "players/team2/tris.md2");
	VectorCopy (NPC->s.origin, NPC->s.old_origin);
	NPC->s.origin[2] += 30;
//	NPC->classname = "bot";
//	NPC->takedamage = DAMAGE_YES;
	NPC->mass = 200;
	NPC->movetype = MOVETYPE_STEP;	
//	NPC->solid = SOLID_BBOX;	
//	NPC->deadflag = DEAD_NO;
//	NPC->clipmask = MASK_PLAYERSOLID;

	NPC->s.modelindex2 = 0;//gi.modelindex("players/team2/w_mine.md2");		
	NPC->s.frame = 0;	
	NPC->waterlevel = 0;	
	NPC->watertype = 0;

	NPC->takedamage = DAMAGE_YES;
	NPC->deadflag = DEAD_NO;
	NPC->classname = "bot";
	NPC->mass = 200;
	NPC->solid = SOLID_BBOX;
	NPC->s.skinnum = 0;
	NPC->skinnum_head = 0;
	NPC->skinnum_chest = 0;
	NPC->skinnum_stomach = 0;
	NPC->skinnum_leg = 0;

	NPC->die = npc_dead;
	NPC->health = 100;	
	NPC->max_health = 100;	
	NPC->gib_health = -9999;

	NPC->think = npc_idle;
	NPC->s.renderfx |= RF_IR_VISIBLE;

	NPC->nextthink = level.time + 0.1;
	VectorSet (NPC->mins, -16, -16, -24);	
	VectorSet (NPC->maxs, 16, 16, 32);
	
	gi.linkentity (NPC);
}

void bot_pain (edict_t *ent)
{
		if (ent->skinnum_head == 0
		&& ent->skinnum_chest == 0
		&& ent->skinnum_stomach == 0
		&& ent->skinnum_leg == 0)
		ent->s.skinnum = 0;
	else if (ent->skinnum_head == 1
		&& ent->skinnum_chest == 0
		&& ent->skinnum_stomach == 0
		&& ent->skinnum_leg == 0)
		ent->s.skinnum = 1;
	else if (ent->skinnum_head == 1
		&& ent->skinnum_chest == 1
		&& ent->skinnum_stomach == 0
		&& ent->skinnum_leg == 0)
		ent->s.skinnum = 2;
	else if (ent->skinnum_head == 1
		&& ent->skinnum_chest == 0
		&& ent->skinnum_stomach == 1
		&& ent->skinnum_leg == 0)
		ent->s.skinnum = 3;
	else if (ent->skinnum_head == 1
		&& ent->skinnum_chest == 0
		&& ent->skinnum_stomach == 0
		&& ent->skinnum_leg == 1)
		ent->s.skinnum = 4;
	else if (ent->skinnum_head == 1
		&& ent->skinnum_chest == 1
		&& ent->skinnum_stomach == 1
		&& ent->skinnum_leg == 0)
		ent->s.skinnum = 5;
	else if (ent->skinnum_head == 1
		&& ent->skinnum_chest == 0
		&& ent->skinnum_stomach == 1
		&& ent->skinnum_leg == 1)
		ent->s.skinnum = 6;
	else if (ent->skinnum_head == 1
		&& ent->skinnum_chest == 1
		&& ent->skinnum_stomach == 0
		&& ent->skinnum_leg == 1)
		ent->s.skinnum = 7;
	else if (ent->skinnum_head == 1
		&& ent->skinnum_chest == 1
		&& ent->skinnum_stomach == 1
		&& ent->skinnum_leg == 1)
		ent->s.skinnum = 8;
	else if (ent->skinnum_head == 0
		&& ent->skinnum_chest == 1
		&& ent->skinnum_stomach == 0
		&& ent->skinnum_leg == 0)
		ent->s.skinnum = 9;
	else if (ent->skinnum_head == 0
		&& ent->skinnum_chest == 1
		&& ent->skinnum_stomach == 1
		&& ent->skinnum_leg == 0)
		ent->s.skinnum = 10;
	else if (ent->skinnum_head == 0
		&& ent->skinnum_chest == 1
		&& ent->skinnum_stomach == 0
		&& ent->skinnum_leg == 1)
		ent->s.skinnum = 11;
	else if (ent->skinnum_head == 0
		&& ent->skinnum_chest == 1
		&& ent->skinnum_stomach == 1
		&& ent->skinnum_leg == 1)
		ent->s.skinnum = 12;
	else if (ent->skinnum_head == 0
		&& ent->skinnum_chest == 0
		&& ent->skinnum_stomach == 1
		&& ent->skinnum_leg == 0)
		ent->s.skinnum = 13;
	else if (ent->skinnum_head == 0
		&& ent->skinnum_chest == 0
		&& ent->skinnum_stomach == 1
		&& ent->skinnum_leg == 1)
		ent->s.skinnum = 14;
	else if (ent->skinnum_head == 0
		&& ent->skinnum_chest == 0
		&& ent->skinnum_stomach == 0
		&& ent->skinnum_leg == 1)
		ent->s.skinnum = 15;
}