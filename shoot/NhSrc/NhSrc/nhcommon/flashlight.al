//===========================================================================
// flashlight.c
//
// Various methods. 
// Some oriented around flashlight code.
// Originally coded by majoon
//
// Copyright (c), 1999 The BatCave. All Rights Reserved.
//===========================================================================

#include "g_local.h"

/*----------------------------------------
  SP_Flashlight

  Create/remove the flashlight entity
-----------------------------------------*/

#define fl self->flashlight

//majoon: This one clears the Flashlight variable
void ClearFlashlight(edict_t *self) {

   if ( fl ) {
      G_FreeEdict(fl);
      fl = NULL;
	self->client->ps.stats[STAT_NHFLASHLIGHT] = 0; // Alex

      return;
      
   }
}

void SP_Flashlight(edict_t *self) {

   vec3_t  start,forward,right,end;

   //***** Spectator *****
   if (self->inWaiting || self->isObserving)
	   return;

   // Also don't allow this if dead.
   if (self->deadflag)
     return ;

   if ( fl ) {
      G_FreeEdict(fl);
      fl = NULL;
	  if (self->isPredator)
	  {
		// gi.cprintf (self, PRINT_HIGH, "Light scope off.\n");
	  	self->client->ps.stats[STAT_NHFLASHLIGHT] = 0; // Alex
	  }
	  else
	  {
		// gi.cprintf (self, PRINT_HIGH, "Flashlight off.\n");
	  	gi.sound(self, CHAN_VOICE, gi.soundindex("world/spark1.wav"), 1, ATTN_NORM, 0);
		self->client->ps.stats[STAT_NHFLASHLIGHT] = 0;
	  }

      return;
   }

   if (self->isPredator)
   {
   	// gi.cprintf (self, PRINT_HIGH, "Light scope on.\n");
	self->client->ps.stats[STAT_NHFLASHLIGHT] = gi.imageindex ("nhflash");
   }
   else
   {
   	// gi.cprintf (self, PRINT_HIGH, "Flashlight on.\n");
	gi.sound(self, CHAN_VOICE, gi.soundindex("world/spark3.wav"), 1, ATTN_NORM, 0);
	self->client->ps.stats[STAT_NHFLASHLIGHT] = gi.imageindex ("nhflash");
   }

   AngleVectors (self->client->v_angle, forward, right, NULL);

   VectorSet(end,100 , 0, 0);
   G_ProjectSource (self->s.origin, end, forward, right, start);

   fl = G_Spawn ();
   fl->owner = self;
   fl->movetype = MOVETYPE_NOCLIP;
   fl->solid = SOLID_NOT;
   fl->classname = "flashlight";
   fl->s.modelindex = gi.modelindex ("sprites/s_bubble.sp2");
   fl->s.skinnum = 0;
   if (self->isPredator)
	   fl->s.effects = EF_FLAG2;
   else
	   fl->s.effects = EF_BFG;
		fl->s.renderfx |= RF_TRANSLUCENT;
		fl->s.renderfx |= RF_FULLBRIGHT;

   fl->think = FlashlightThink;
   fl->nextthink = level.time + 0.1;
}


/*---------------------------------------------
  FlashlightThink

  Updates the sights position, angle, and shape
  <self> is the lasersight entity
---------------------------------------------*/

void FlashlightThink (edict_t *self)
{
   vec3_t start,end,endp,offset;
   vec3_t forward,right,up;
   trace_t tr;

   AngleVectors (self->owner->client->v_angle, forward, right, up);

   VectorSet(offset,24 , 6, self->owner->viewheight-7);
   G_ProjectSource (self->owner->s.origin, offset, forward, right, start);
   VectorMA(start,8192,forward,end);

   tr = gi.trace (start,NULL,NULL, end,self->owner,CONTENTS_SOLID|CONTENTS_MONSTER|CONTENTS_DEADMONSTER);

   if (tr.fraction != 1) {
      VectorMA(tr.endpos,-4,forward,endp);
      VectorCopy(endp,tr.endpos);
   }

   if ((tr.ent->svflags & SVF_MONSTER) || (tr.ent->client)){
      if ((tr.ent->takedamage) && (tr.ent != self->owner)) {
         self->s.skinnum = 1;
      }
   }
   else
      self->s.skinnum = 0;

   vectoangles(tr.plane.normal,self->s.angles);
   VectorCopy(tr.endpos,self->s.origin);

   gi.linkentity (self);
   self->nextthink = level.time + 0.1;
}

//majoon: The player will glow a tad, if he's using the flashlight, as to
//not give an unfair advantage!
//Oooooor, the predator is partially transparent and does NOT glow when
//using the flashlight (or, in his case, the light scope)
void playerEffects (edict_t *player)
{
	if (player->flashlight && !player->isPredator)
		player->s.effects = EF_FLAG1;
	if (player->isPredator)
		player->s.renderfx = RF_TRANSLUCENT;
}

/*
==============
initPredator
majoon: this is for setting
the predator weapons
==============
*/
void initPredator (edict_t *ent)
{
	int playernum = ent-g_edicts-1;

	ent->isPredator = true;

	VectorClear (ent->avelocity);

	ent->takedamage = DAMAGE_NO;
	ent->movetype = MOVETYPE_TOSS;

	ent->s.modelindex2 = 0;	// remove linked weapon model
	ent->s.modelindex = 0;

	ent->s.angles[0] = 0;
	ent->s.angles[2] = 0;

	ent->s.sound = 0;
	ent->client->weapon_sound = 0;

	ent->maxs[2] = -8;

	ent->solid = SOLID_NOT;
	ent->svflags |= SVF_DEADMONSTER;

	ent->client->respawn_time = level.time + 1.0;
	ent->client->ps.pmove.pm_type = PM_DEAD;

	// remove powerups
	ent->client->quad_framenum = 0;
	ent->client->invincible_framenum = 0;
	ent->client->breather_framenum = 0;
	ent->client->enviro_framenum = 0;

	// clear inventory
	memset(ent->client->pers.inventory, 0, sizeof(ent->client->pers.inventory));
	ent->client->pers.selected_item = 0;

	ent->deadflag = DEAD_DEAD;

	gi.linkentity (ent);

// add a teleportation effect
	ent->s.event = EV_PLAYER_TELEPORT;

	level.be_pred_time = level.time + 5;
//	level.be_pred_time = level.time + 15;

	ent->inWaiting = true;

//	ent->movetype = MOVETYPE_NOCLIP;
	gi.centerprintf (ent, "You will become the predator in\n5 seconds...so get READY!!\n");
	level.be_pred_countdown[1]=0;
	level.be_pred_countdown[2]=0;
	level.be_pred_countdown[3]=0;
	level.be_pred_countdown[4]=0;
	
	if ( ent->flashlight ) {
	//	G_FreeEdict(ent->flashlight);
	//	ent->flashlight = NULL;
		ClearFlashlight(ent);	
	}

	gi.configstring (CS_PLAYERSKINS+(ent-g_edicts-1), va("%s\\female/jungle", ent->client->pers.netname) );

	// Set pred hud.
	setPredStartHud(ent) ;
        ent->client->ps.stats[STAT_PREDATOR] = gi.imageindex ("h_pred");

}																		 


/*
===================
LookforPredator
majoon: this LOOKS to
see if there is a predator,
every 10 seconds.
===================
*/
void LookforPredator (edict_t *player)
{
  qboolean	found = false;
  int		i;
	

  for_each_player(player, i) {
    if (player->isPredator)
      found = true;
  }
  
  // not found ?
  if (!found) {
    for_each_player(player, i) {

	// Bruce's changes.
	// Added check for chase mode.
#if 0
	if ((player->inuse) && 
	    (!player->isObserving))

	  //***** Spectator fix *****
	  gi.bprintf(PRINT_HIGH, "Looking for predator. Spectator = %d %d\n",
		     player->client->resp.spectator,
		     player->client->pers.spectator) ;
#endif
//	  printf("isObserving is %d\n",player->isObserving);
	  if ((player->inuse) &&
	      (!player->isObserving)) {

	    initPredator(player);
	    return;
	  }
    }
  }
}

/*
==================
Cmd_ShowInfo_f

Display the current info
==================
*/
void Cmd_ShowInfo_f (edict_t *ent)
{
	ent->client->showinventory = false;
	ent->client->showscores = false;

	//ent->client->showhelp = true;
	//ent->client->resp.helpchanged = 0;
	InfoComputer (ent);
}

/*
==================
InfoComputer

Draw info computer.
==================
*/
void InfoComputer (edict_t *ent)
{
	char	string[1024];

	// send the layout
	Com_sprintf (string, sizeof(string),
		"xv 32 yv 8 picn help "		// background
//		"xv 202 yv 12 cstring2 \"Hello!!\" "		// skill
		/*and the end*/ );

	gi.WriteByte (svc_layout);
	gi.WriteString (string);
	gi.unicast (ent, true);
}


/*
===================
onPlayerConnect
majoon: this is just for
random messages and such
that might be nice to put
in when somone first connects.
===================
*/
void onPlayerConnect (edict_t *newplayer)
{
		FILE *motd_file;
		char motd[500];
		char line[80];

	if (motd_file = fopen("nhunters/motd.txt", "r"))
	{
		// we successfully opened the file "motd.txt"
		if ( fgets(motd, 500, motd_file) )		{
			// we successfully read a line from "motd.txt" into motd
			// ... read the remaining lines now
			while ( fgets(line, 80, motd_file) )
			{
			// add each new line to motd, to create a BIG message string.
			// we are using strcat: STRing conCATenation function here.
				strcat(motd, line);
			}
			// print our message.
			gi.centerprintf (newplayer, "Night Hunters %s\nhttp://nhunters.gameplex.net\n- - - - - - - - - - - - - -\n%s", NHVER, motd);
		}
		// be good now ! ... close the file
		fclose(motd_file);
	}
	//if the file wasn't there, we just make up our own motd
	else
		gi.centerprintf (newplayer, "Night Hunters %s\nhttp://nhunters.gameplex.net\n", NHVER);
	//	gi.centerprintf (newplayer, "Welcome to NightHunters beta 1.4!\nThis MOD is (c)opyright 1998 by majoon\nPlease visit:\nhttp://nhunters.gameplex.net\nto download the client-side files.\n");
}

/*
============
KickRadiusDamage
This was added to
edit the predator's
rocket's radius
kick
============
*/
void KickRadiusDamage (edict_t *targ, edict_t *inflictor, edict_t *attacker, float damage, edict_t *ignore, float radius, int knockback, int dflags, int mod)
{
	float	points;
	edict_t	*ent = NULL;
	vec3_t	v;
	vec3_t	dir;
	vec3_t	kvel;
	float	mass;


	while ((ent = findradius(ent, inflictor->s.origin, radius)) != NULL)
	{
		if (ent == ignore)
			continue;
		if (!ent->takedamage)
			continue;

		VectorAdd (ent->mins, ent->maxs, v);
		VectorMA (ent->s.origin, 0.5, v, v);
		VectorSubtract (inflictor->s.origin, v, v);
		points = damage - 0.5 * VectorLength (v);
		if (ent == attacker)
			points = points * 0.5;
		if (points > 0)
//		if (!(dflags & DAMAGE_NO_KNOCKBACK))
//		{
			if ((knockback) && (targ->movetype != MOVETYPE_NONE) && (targ->movetype != MOVETYPE_BOUNCE) && (targ->movetype != MOVETYPE_PUSH) && (targ->movetype != MOVETYPE_STOP))
			{

				if (targ->mass < 50)
				mass = 50;
				else
					mass = targ->mass;

//				if (targ->client  && attacker == targ)
//					VectorScale (dir, 1600.0 * (float)knockback / mass, kvel);	// the rocket jump hack...
//				else
					VectorScale (dir, 500.0 * (float)knockback / mass, kvel);

				VectorAdd (targ->velocity, kvel, targ->velocity);
			}
//		}
		{
			if (CanDamage (ent, inflictor))
			{
				VectorSubtract (ent->s.origin, inflictor->s.origin, dir);
				T_Damage (ent, inflictor, attacker, dir, inflictor->s.origin, vec3_origin, (int)points, (int)points, DAMAGE_RADIUS, mod);
			}
		}
	}
}

