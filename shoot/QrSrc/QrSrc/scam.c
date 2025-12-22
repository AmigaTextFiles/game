
// SCAM functions (Camera & FakePlayer Code in P_VIEW.C)

#include "g_local.h"

void CarTouch (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf)
{ 
	if (other->client)
	{
		if (level.time < other->client->getincar_time) return;
		
   			 other->s.modelindex = gi.modelindex(ent->model);
    		 VectorCopy (ent->s.origin, other->s.origin);
             VectorCopy (ent->velocity, other->velocity);
             VectorCopy (ent->s.angles, other->s.angles);
  			 VectorCopy (ent->mins, other->mins);
             VectorCopy (ent->maxs, other->maxs);
			 other->s.origin[2] = other->s.origin[2] + 30;            
             other->client->incar = 1;
			 gi.linkentity(other);
			 G_FreeEdict(ent);
		
	}
}
		
void Cmd_GetInCar_f (edict_t *ent)
{
	ent->client->getincar_time = level.time + 0.2;
}
extern void DebugPoint(edict_t *ent);

void SP_NULL (edict_t *ent)
{
}

void BackToLast(edict_t *ent)
{
 ent = ent->owner;
 ent->client->adjust_time = level.time + 2;
 ent->velocity[0] = 0;
 ent->velocity[1] = 0;
 ent->velocity[2] = 0;
 ent->client->invis = 0;
 ent->client->explode = 0;
 ent->client->stop = 0;
 gi.WriteByte (svc_temp_entity);
 gi.WriteByte (TE_GRENADE_EXPLOSION);
 gi.WritePosition (ent->s.origin);
 gi.multicast (ent->s.origin, MULTICAST_PHS);
}

void MoveBack(edict_t *ent)
{
 vec3_t v2,dir;
 ent = ent->owner;
 VectorCopy(ent->client->point2,ent->s.origin);
 VectorSubtract (ent->client->point1,ent->s.origin, dir);
 v2[1] =  180/M_PI*atan2(dir[1], dir[0]);
 VectorCopy(v2,ent->s.angles);
 ent->s.origin[2] += 65;
 gi.linkentity(ent);
 ent->client->camwarp = 1;
 ent->client->temp->think = BackToLast;
 ent->client->temp->nextthink = level.time + 0.5;
}

void MoveBack2(edict_t *ent)
{
         int con;
         vec3_t v2,dir;
         ent = ent->owner;
         ent->client->explode = 0;
         VectorCopy(ent->client->point2,ent->s.origin);
         VectorSubtract (ent->client->point1,ent->s.origin, dir);
         v2[1] =  180/M_PI*atan2(dir[1], dir[0]);
		 VectorCopy(v2,ent->s.angles);
         ent->s.origin[2] += 85;
         con = gi.pointcontents(ent->s.origin);
         if (con & CONTENTS_SOLID) ent->s.origin[2] = 100;
         gi.linkentity(ent);
		 ent->client->camwarp = 1;
         ent->client->temp->think = BackToLast;
         ent->client->temp->nextthink = level.time + 0.5;
		 return;
	
 
}

void CheckTrack (edict_t *ent)
{
	vec3_t v,dist;
    edict_t *trackpoint = NULL;
	if (ent->client->explode == 1) return;
	while ((trackpoint = G_Find (trackpoint, FOFS(classname), "track_norm")) != NULL)
    {
        VectorSubtract (trackpoint->s.origin, ent->s.origin, v);
	    if (VectorLength(v) < 80)
		{
			
			VectorSubtract(ent->client->last_point,trackpoint->s.origin,dist);
			if (VectorLength(dist) > 300)   
			{
				gi.WriteByte (svc_temp_entity);
				gi.WriteByte (TE_GRENADE_EXPLOSION);
            	gi.WritePosition (ent->s.origin);
            	gi.multicast (ent->s.origin, MULTICAST_PHS);
				ent->client->temp->think = MoveBack;
				if (ent->client->explode == 0)
				ent->client->temp->nextthink = level.time + 0.7;
				ent->client->explode = 1;
				ent->client->invis = 1;
				gi.linkentity(ent);
				return;
			}
			else
			{
				VectorCopy(ent->client->point1,ent->client->point2);
				VectorCopy(trackpoint->s.origin,ent->client->point1);
                VectorCopy(trackpoint->s.origin,ent->client->last_point);
				gi.linkentity(ent);
				return;
			}
		}
	}
}
extern void EndDMLevel();

void Sitescores(edict_t *ent)
{
     gi.cprintf (ent->owner,PRINT_HIGH, "Your position was: %i\nTotal Race Time: %i:%i:%i \n\n\n",ent->owner->client->pos,ent->owner->client->tot_mins,ent->owner->client->tot_secs,ent->owner->client->tot_mils);
     ent->think = Sitescores;
	 ent->nextthink = level.time + 2;
}

void Site2(edict_t *ent)
{
    char	command [256];
    Cmd_Score_f(ent->owner); 
    ent->think = Sitescores;
	ent->nextthink = level.time + 2;
    if (deathmatch->value) EndDMLevel();
	else
	{
			Com_sprintf (command, sizeof(command), "map \"%s\"\n", level.mapname);
	        gi.AddCommandString (command);
			return;
	}

}

void Site(edict_t *ent)
{
     gi.centerprintf (ent->owner, "Your position was: %i\nTotal Race Time: %i:%i:%i \n",ent->owner->client->pos,ent->owner->client->tot_mins,ent->owner->client->tot_secs,ent->owner->client->tot_mils);
     ent->think = Site2;
	 ent->nextthink = level.time + 2;
}

void Site0(edict_t *ent)
{
     gi.centerprintf (ent->owner, "Your position was: %i\nTotal Race Time: %i:%i:%i \n",ent->owner->client->pos,ent->owner->client->tot_mins,ent->owner->client->tot_secs,ent->owner->client->tot_mils);
     ent->think = Site;
	 ent->nextthink = level.time + 2;
}
void Site9(edict_t *ent)
{
     gi.centerprintf (ent->owner, "Your position was: %i\nTotal Race Time: %i:%i:%i \n",ent->owner->client->pos,ent->owner->client->tot_mins,ent->owner->client->tot_secs,ent->owner->client->tot_mils);
 ent->think = Site0;
	 ent->nextthink = level.time + 2;
}

void Invite(edict_t *ent)
{
     gi.centerprintf (ent->owner, "Your position was: %i\nTotal Race Time: %i:%i:%i \n",ent->owner->client->pos,ent->owner->client->tot_mins,ent->owner->client->tot_secs,ent->owner->client->tot_mils);
     ent->think = Site9;
	 ent->nextthink = level.time + 2;
}

void FinishRace (edict_t *ent)
{
 edict_t *trackpoint = NULL;
 edict_t *fin = NULL;
 int p;
 VectorClear(ent->velocity);
 while ((trackpoint = G_Find (trackpoint, FOFS(classname), "track_finish2")) != NULL)
 {
	  trackpoint->spawnflags++;
	 ent->client->pos = trackpoint->spawnflags;
	 p = ent->client->pos;
 }
		if (p == 1)
		{
			while ((fin = G_Find (fin, FOFS(classname), "fin_one")) != NULL)
            {
	            VectorCopy(fin->s.origin,ent->s.origin);
			}
		}
        else if (p == 2)
		{
			while ((fin = G_Find (fin, FOFS(classname), "fin_two")) != NULL)
            {
	            VectorCopy(fin->s.origin,ent->s.origin);
			}
		}
        else if (p == 3)
		{
			while ((fin = G_Find (fin, FOFS(classname), "fin_three")) != NULL)
            {
	            VectorCopy(fin->s.origin,ent->s.origin);
			}
		}
        else 
		{
			while ((fin = G_Find (fin, FOFS(classname), "fin_four")) != NULL)
            {
	            VectorCopy(fin->s.origin,ent->s.origin);
			}
		}
 ent->s.origin[2] = ent->s.origin[2] + 10;
 gi.cprintf (ent,PRINT_HIGH, "*** Race Over ***\n");
 ent->client->clock->nextthink = level.time + 999999;
 gi.cprintf (ent,PRINT_HIGH, "Your position was: %i\n",ent->client->pos);
 ent->client->resp.score = ent->client->pos;
 gi.cprintf (ent,PRINT_HIGH, "Total Race Time: %i:%i:%i \n",ent->client->tot_mins,ent->client->tot_secs,ent->client->tot_mils);
 gi.centerprintf (ent, "Your position was: %i\nTotal Race Time: %i:%i:%i \n",ent->client->pos,ent->client->tot_mins,ent->client->tot_secs,ent->client->tot_mils);
 ent->client->stop = 1;
 gi.sound(ent, CHAN_VOICE, gi.soundindex("crowd.wav"), 1, ATTN_NORM, 0);
 gi.AddCommandString("stop\n");
 ent->client->temp2->think = Invite;
 ent->client->temp2->nextthink = level.time + 2;

}

int SameLevel(int one, int two)
{
	int gap;
 	gap =  one - two;
	if ((gap > -5) && (gap < 5)) return 1;
	else return 0;
}

void CheckPoints (edict_t *ent)
{
    vec3_t v;
	int dist,gap;
	edict_t *trackpoint = NULL;
    
	while ((trackpoint = G_Find (trackpoint, FOFS(classname), "track_point")) != NULL)
    {
        
	    VectorSubtract(ent->s.origin,trackpoint->s.origin,v);
		dist = VectorLength(v);
		if (dist < 300) 
		{
          	gap = ent->s.origin[2] - trackpoint->s.origin[2];
			if ((gap > -10) && (gap < 10))
			{
    		   if (ent->client->tp == trackpoint->spawnflags) return;
			   ent->client->prev = ent->client->tp;
			   ent->client->tp = trackpoint->spawnflags;
			   if ((ent->client->tp == 1) && (ent->client->prev == 0)) ent->client->finish_valid = 1;
			   return;
			}
		}
	}
}
void BotCheckPoints (edict_t *ent)
{
    vec3_t v;
	int dist;
	edict_t *trackpoint = NULL;
    
	while ((trackpoint = G_Find (trackpoint, FOFS(classname), "track_point")) != NULL)
    {
        
	    VectorSubtract(ent->s.origin,trackpoint->s.origin,v);
		dist = VectorLength(v);
		if (dist < 100) 
		{
			
    		   if (trackpoint->spawnflags == 2) ent->gib_health = 1;
		/*if (ent->dmg == trackpoint->spawnflags) return;
			   ent->radius_dmg = ent->dmg;
			   ent->dmg = trackpoint->spawnflags;
			   if ((ent->dmg == 2) && (ent->radius_dmg == 1)) ent->gib_health = 1;
			   return;*/
		
		}
	}
}

void PrintStats (edict_t *ent)
{
	if (ent->client->stop) return;
	if (ent->client->timer == 1) return;
	if (level.time < ent->client->showprevtime)
	{
     if (ent->client->flash == 1)
	 {
		 ent->client->flash = 0;
         gi.cprintf(ent,PRINT_HIGH,"Lap Time   : %i:%i:%i \n",ent->client->last_mins,ent->client->last_secs,ent->client->last_mils);
	 }

	 else 
	 {
		 ent->client->flash = 1;
		 gi.cprintf(ent,PRINT_HIGH,"Lap Time   :\n");
	 }
	}
	 else
 	 gi.cprintf(ent,PRINT_HIGH,"Lap Time   : %i:%i:%i \n",ent->client->lap_mins,ent->client->lap_secs,ent->client->lap_mils);
	gi.cprintf(ent,PRINT_HIGH,"Total Time : %i:%i:%i \n",ent->client->tot_mins,ent->client->tot_secs,ent->client->tot_mils);
    gi.cprintf(ent,PRINT_HIGH,"Laps Done  : %i\\%i \n\n",ent->client->laps,ent->client->maxlaps);
}

void ClockThink (edict_t *ent)
{
	ent = ent->owner;
	ent->client->tot_mils = ent->client->tot_mils++;
	if (ent->client->tot_mils == 10)
	{
		ent->client->tot_mils = 0;
		ent->client->tot_secs++;
		if (ent->client->tot_secs == 60)
		{
			ent->client->tot_secs = 0;
            ent->client->tot_mins++;
		}
	}
    
    ent->client->lap_mils = ent->client->lap_mils++;
	if (ent->client->lap_mils == 10)
	{
		ent->client->lap_mils = 0;
		ent->client->lap_secs++;
		if (ent->client->lap_secs == 60)
		{
			ent->client->lap_secs = 0;
            ent->client->lap_mins++;
		}
	}
		PrintStats(ent);
        ent->client->clock->think = ClockThink;
		ent->client->clock->nextthink = level.time + 0.1;
}
void AI_car_finishthink(edict_t *ent);

void BotFinish(edict_t *ent)
{
 edict_t *trackpoint = NULL;
 edict_t *fin = NULL;
 int p;
 gi.sound(ent, CHAN_VOICE, gi.soundindex("crowd.wav"), 1, ATTN_NORM, 0);
 while ((trackpoint = G_Find (trackpoint, FOFS(classname), "track_finish2")) != NULL)
    {
	    trackpoint->spawnflags++;
		p = trackpoint->spawnflags;
		if (p == 1)
		{
			while ((fin = G_Find (fin, FOFS(classname), "fin_one")) != NULL)
            {
	            VectorCopy(fin->s.origin,ent->s.origin);
				ent->nextthink = level.time + 999999;
				goto end;
			}
		}
        else if (p == 2)
		{
			while ((fin = G_Find (fin, FOFS(classname), "fin_two")) != NULL)
            {
	            VectorCopy(fin->s.origin,ent->s.origin);
				ent->nextthink = level.time + 999999;
				goto end;
			}
		}
        else if (p == 3)
		{
			while ((fin = G_Find (fin, FOFS(classname), "fin_three")) != NULL)
            {
	            VectorCopy(fin->s.origin,ent->s.origin);
				ent->nextthink = level.time + 999999;
				goto end;
			}
		}
        else 
		{
			while ((fin = G_Find (fin, FOFS(classname), "bot_lap")) != NULL)
            {
	            VectorCopy(fin->s.origin,ent->s.origin);
				ent->nextthink = level.time + 999999;
				goto end;
			}
		}
end:
        VectorClear (ent->velocity);
		ent->fin = 1;
		ent->stop = 1;
	}
}

void BotFinishCross (edict_t *ent)
{
  gi.sound(ent, CHAN_VOICE, gi.soundindex("crowd.wav"), 1, ATTN_NORM, 0);
  if (ent->gib_health == 1)
	{
	 ent->count++;
	 if (ent->count == fraglimit->value) {BotFinish(ent);goto end;}
	 else
	 {
	     AI_car_finishthink(ent);
	 }
	 ent->gib_health = 0;
	}
end:
	ent->waterlevel = 0;
}

void FinishCross (edict_t *ent)
{
    if (ent->client->finish_valid)
	{
     	gi.sound(ent, CHAN_VOICE, gi.soundindex("crowd.wav"), 1, ATTN_NORM, 0);
 		ent->client->laps++;
		ent->client->last_mins = ent->client->lap_mins;
        ent->client->last_secs = ent->client->lap_secs;
        ent->client->last_mils = ent->client->lap_mils;
        ent->client->lap_mils = 0;
		ent->client->lap_secs = 0;
		ent->client->lap_mins = 0;
		ent->client->showprevtime = level.time + 5;
		ent->client->finish_valid = 0;
	    if (ent->client->laps == ent->client->maxlaps) {FinishRace(ent);return;}
	}
	return;
}

void CheckFinish (edict_t *ent)
{
    edict_t *fin2 = NULL;
	edict_t *fin1 = NULL;
    edict_t *fin3 = NULL;
    int dist1,dist2,dist3;
	vec3_t v;
	while ((fin1 = G_Find (fin1, FOFS(classname), "track_finish1")) != NULL)
    {
     	while ((fin2 = G_Find (fin2, FOFS(classname), "track_finish2")) != NULL)
        {
      	while ((fin3 = G_Find (fin3, FOFS(classname), "track_finish3")) != NULL)
        {
		  VectorSubtract(ent->s.origin,fin1->s.origin,v);
		  dist1 = VectorLength(v);
          VectorSubtract(ent->s.origin,fin2->s.origin,v);
		  dist2 = VectorLength(v);
		  VectorSubtract(ent->s.origin,fin3->s.origin,v);
		  dist3 = VectorLength(v);
		  if (((dist1 < 100) || (dist2 < 100)) && (dist3 < 100)) FinishCross(ent);
		}
		}
	}
}
void BotCheckFinish (edict_t *ent)
{
    edict_t *fin2 = NULL;
	edict_t *fin1 = NULL;
    edict_t *fin3 = NULL;
    int dist1,dist2,dist3;
	vec3_t v;
	while ((fin1 = G_Find (fin1, FOFS(classname), "track_finish1")) != NULL)
    {
     	while ((fin2 = G_Find (fin2, FOFS(classname), "track_finish2")) != NULL)
        {
      	while ((fin3 = G_Find (fin3, FOFS(classname), "track_finish3")) != NULL)
        {
		  VectorSubtract(ent->s.origin,fin1->s.origin,v);
		  dist1 = VectorLength(v);
          VectorSubtract(ent->s.origin,fin2->s.origin,v);
		  dist2 = VectorLength(v);
		  VectorSubtract(ent->s.origin,fin3->s.origin,v);
		  dist3 = VectorLength(v);
		  if (((dist1 < 100) || (dist2 < 100)) && (dist3 < 100)) BotFinishCross(ent);
		}
		}
	}
}
void BotPhysics (edict_t *ent)
{
	int speed,old;
    
	
	// Control Acceleration & Grip
	speed = VectorLength(ent->velocity);
	old = VectorLength(ent->oldvel);
	if (ent->groundentity)
	{
	if (old > speed) 
	{
	     ent->velocity[0] = ent->velocity[0] * 2.7; 
         ent->velocity[1] = ent->velocity[1] * 2.7; 
	     ent->velocity[2] = ent->velocity[2] * 0; 
	}
	else
	{
	     ent->velocity[0] = ent->velocity[0] * 1.0; 
         ent->velocity[1] = ent->velocity[1] * 1.0; 
	     ent->velocity[2] = ent->velocity[2] * 0; 
	}
	
	VectorCopy(ent->velocity,ent->client->oldvel);
	}
}

void AI_car_think (edict_t *ent)
{
    edict_t *point = NULL;
	vec3_t forward,right,up;
	vec3_t endpos,v,v2,v3,result;
    int dist1,move,side;
	if (ent->stop == 1) goto end;
	while ((point = G_Find (point, FOFS(classname), "track_norm")) != NULL)
    {
       VectorSubtract(ent->s.origin,point->s.origin,v3);
       dist1 = VectorLength(v3);
	   if (dist1 < 90)
	   {
            if (point->wait < level.time)
	        {
			 point->wait = level.time + 1;
			 ent->enemy = point;
			 ent->s.origin[2] = point->s.origin[2];
			}
	   }
	}
    VectorSubtract (ent->enemy->s.origin, ent->s.origin, v2);
	ent->ideal_yaw = vectoyaw(v2);
	M_ChangeYaw (ent);
    AngleVectors (ent->s.angles, forward, right, up);
    side = random() * 30;
	side = 250;

	VectorMA (ent->s.origin, side , forward, endpos);
    if (ent->teleport_time > level.time) {VectorCopy(endpos,result);goto end;}
    side = random() * 120;
	if (random() < 0.5) move = 0 - side;
	else move = side;
	VectorMA (endpos,move,right,result);
   	ent->teleport_time = level.time + 0.2;
end:
	VectorSubtract(result,ent->s.origin,v);
	VectorCopy(v,ent->velocity);
	BotPhysics(ent);
	BotCheckPoints(ent);
    BotCheckFinish(ent);
	if (ent->fin == 1) goto end2;
	ent->think = AI_car_think;
    ent->nextthink = level.time + 0.1;
end2:
ent->waterlevel = 0;
}

void AI_car_finishthink (edict_t *ent)
{
    edict_t *point = NULL;
  	gi.dprintf("*********************\n");
	while ((point = G_Find (point, FOFS(classname), "bot_lap")) != NULL)
    {
	 ent->enemy = point;
	 VectorCopy(point->s.origin, ent->s.origin);
	 ent->think = AI_car_think;
     ent->nextthink = level.time + 0.1;
	}
	
}

void AI_car_spawn (edict_t *ent)
{
    if (deathmatch->value) return;
    if (coop->value) return;
    ent->s.modelindex = gi.modelindex ("models/bot/tris.md2");
	VectorSet (ent->mins, -16, -16, -24);
	VectorSet (ent->maxs, 16, 16, 32);
   	ent->s.skinnum = 0;
    ent->s.frame = 0;
   	ent->svflags &= ~SVF_MONSTER;
    ent->movetype = MOVETYPE_FLYMISSILE;
	ent->name = "Paul Matthews";
	ent->solid = SOLID_BBOX;
   	ent->mass = 50;
    ent->classname = "bot";
	ent->yaw_speed = 15;
	ent->think = AI_car_think;
	ent->nextthink = level.time + 11;
    gi.linkentity(ent);
}
void AI_car_spawntruck (edict_t *ent)
{
    if (deathmatch->value) return;
    if (coop->value) return;
    ent->s.modelindex = gi.modelindex ("models/bot2/tris.md2");
	VectorSet (ent->mins, -16, -16, -24);
	VectorSet (ent->maxs, 16, 16, 32);
   	ent->s.skinnum = 0;
    ent->s.frame = 0;
   	ent->svflags &= ~SVF_MONSTER;
    ent->movetype = MOVETYPE_FLYMISSILE;
	ent->name = "Paul Matthews";
	ent->solid = SOLID_BBOX;
   	ent->mass = 50;
    ent->classname = "bot";
	ent->yaw_speed = 15;
	ent->think = AI_car_think;
	ent->nextthink = level.time + 11;
    gi.linkentity(ent);
}
void AI_car_spawnviper (edict_t *ent)
{
	if (deathmatch->value) return;
	if (coop->value) return;
    ent->s.modelindex = gi.modelindex ("models/bot3/tris.md2");
	VectorSet (ent->mins, -16, -16, -24);
	VectorSet (ent->maxs, 16, 16, 32);
	ent->s.skinnum = 0;
    ent->s.frame = 0;
   	ent->svflags &= ~SVF_MONSTER;
    ent->movetype = MOVETYPE_FLYMISSILE;
	ent->name = "Paul Matthews";
	ent->solid = SOLID_BBOX;
   	ent->mass = 50;
    ent->classname = "bot";
	ent->yaw_speed = 15;
	ent->think = AI_car_think;
	ent->nextthink = level.time + 11;
    gi.linkentity(ent);
}
void AI_car_spawnpod (edict_t *ent)
{
	if (deathmatch->value) return;
	if (coop->value) return;
    ent->s.modelindex = gi.modelindex ("models/bot4/tris.md2");
	VectorSet (ent->mins, -16, -16, -24);
	VectorSet (ent->maxs, 16, 16, 32);
   	ent->s.skinnum = 0;
    ent->s.frame = 0;
   	ent->svflags &= ~SVF_MONSTER;
    ent->movetype = MOVETYPE_FLYMISSILE;
	ent->name = "Paul Matthews";
	ent->solid = SOLID_BBOX;
   	ent->mass = 50;
    ent->classname = "bot";
	ent->yaw_speed = 15;
	ent->think = AI_car_think;
	ent->nextthink = level.time + 11;
    gi.linkentity(ent);
}

void Credits5(edict_t *ent)
{
	gi.centerprintf (ent->owner, "Ladies & Gentlemen - START YOUR ENGINES!!!\n");
}

void Credits4(edict_t *ent)
{
	gi.centerprintf (ent->owner, " Design & Art by: \n\nSteven Cheetham\n");
}

void Credits3(edict_t *ent)
{
	gi.centerprintf (ent->owner, "Design & Art by:\n\nPaul Matthews\n");
    ent->think = Credits4;
	ent->nextthink = level.time + 2;
}

void Credits2(edict_t *ent)
{
	gi.centerprintf (ent->owner, "Programmed & Produced by:\n\nAdrian Flitcroft\n");
    ent->think = Credits3;
	ent->nextthink = level.time + 2;
}

void Credits15(edict_t *ent)
{
	 gi.centerprintf (ent->owner, "Q-Racing V2 COPYRIGHT(c) FLITSOFT 1999 \nwww.telefragged/flitsoft.com\nflitsoft@telefragged.com\n");
     ent->think = Credits2;
	 ent->nextthink = level.time + 2;
}

void PrintCredits(edict_t *ent)
{
	 gi.centerprintf (ent->owner, "Q-Racing V2 COPYRIGHT(c) FLITSOFT 1999 \nwww.telefragged/flitsoft.com\nflitsoft@telefragged.com\n");
     ent->think = Credits15;
	 ent->nextthink = level.time + 2;
}

void Handbrake(edict_t *ent)
{
		if (ent->client->phys == 3) return;
	    gi.sound(ent, CHAN_BODY, gi.soundindex("brake.wav"), 1, ATTN_NORM, 0);
        ent->client->handbrake_time = level.time + 0.3;
	 	gi.WriteByte (svc_temp_entity);
	    gi.WriteByte (TE_SPLASH);
	    gi.WriteByte (40);
	    gi.WritePosition (ent->s.origin);
	    gi.WriteDir (ent->s.origin);
	    gi.WriteByte (ent->sounds);
	    gi.multicast (ent->s.origin, MULTICAST_PVS);

}

void SP_powerup(edict_t *ent)
{
}

	