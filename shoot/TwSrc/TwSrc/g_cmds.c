#include "g_local.h"
#include "m_player.h"
#include "scanner.h"
char *ClientTeam (edict_t *ent)
{
/*
	char		*p;
	static char	value[512];

	value[0] = 0;

	if (!ent->client)
		return value;

	strcpy(value, Info_ValueForKey (ent->client->pers.userinfo, "skin"));
	p = strchr(value, '/');
	if (!p)
		return value;

	if ((int)(dmflags->value) & DF_MODELTEAMS)
	{
		*p = 0;
		return value;
	}

	// if ((int)(dmflags->value) & DF_SKINTEAMS)
	return ++p;
*/
}

qboolean OnSameTeam (edict_t *ent1, edict_t *ent2)
{

        if (ent1->tw_team == ent2->tw_team) {
		return true;
        }
        else
	return false;
}


void SelectNextItem (edict_t *ent, int itflags)
{
	gclient_t	*cl;
	int			i, index;
	gitem_t		*it;

	cl = ent->client;

	// scan  for the next valid one
	for (i=1 ; i<=MAX_ITEMS ; i++)
	{
		index = (cl->pers.selected_item + i)%MAX_ITEMS;
		if (!cl->pers.inventory[index])
			continue;
		it = &itemlist[index];
		if (!it->use)
			continue;
		if (!(it->flags & itflags))
			continue;

		cl->pers.selected_item = index;
		return;
	}

	cl->pers.selected_item = -1;
}

void SelectPrevItem (edict_t *ent, int itflags)
{
	gclient_t	*cl;
	int			i, index;
	gitem_t		*it;

	cl = ent->client;

	// scan  for the next valid one
	for (i=1 ; i<=MAX_ITEMS ; i++)
	{
		index = (cl->pers.selected_item + MAX_ITEMS - i)%MAX_ITEMS;
		if (!cl->pers.inventory[index])
			continue;
		it = &itemlist[index];
		if (!it->use)
			continue;
		if (!(it->flags & itflags))
			continue;

		cl->pers.selected_item = index;
		return;
	}

	cl->pers.selected_item = -1;
}

void ValidateSelectedItem (edict_t *ent)
{
	gclient_t	*cl;

	cl = ent->client;

	if (cl->pers.inventory[cl->pers.selected_item])
		return;		// valid

	SelectNextItem (ent, -1);
}

//=================================================================================


void Cmd_DetPipes_f (edict_t *ent)
{
      edict_t *blip = NULL;

       while ((blip = findradius(blip, ent->s.origin, 1000)) != NULL)
       {
               if (!strcmp(blip->classname, "detpipe") && blip->owner == ent)
               {
                       blip->think = Grenade_Explode;
                       blip->nextthink = level.time + .2;
               }
       }
}


/*
==================
Cmd_Give_f

Give items to a client
==================
*/
void Cmd_Give_f (edict_t *ent)
{
	char		*name;
	gitem_t		*it;
	int			index;
	int			i;
	qboolean	give_all;
	edict_t		*it_ent;

	if (deathmatch->value && !sv_cheats->value)
	{
		gi.cprintf (ent, PRINT_HIGH, "You must run the server with '+set cheats 1' to enable this command.\n");
		return;
	}

	name = gi.args();

	if (Q_stricmp(name, "all") == 0)
		give_all = true;
	else
		give_all = false;

	if (give_all || Q_stricmp(gi.argv(1), "health") == 0)
	{
		if (gi.argc() == 3)
			ent->health = atoi(gi.argv(2));
		else
			ent->health = ent->max_health;
		if (!give_all)
			return;
	}

	if (give_all || Q_stricmp(name, "weapons") == 0)
	{
		for (i=0 ; i<game.num_items ; i++)
		{
			it = itemlist + i;
			if (!it->pickup)
				continue;
			if (!(it->flags & IT_WEAPON))
				continue;
			ent->client->pers.inventory[i] += 1;
		}
		if (!give_all)
			return;
	}

	if (give_all || Q_stricmp(name, "ammo") == 0)
	{
		for (i=0 ; i<game.num_items ; i++)
		{
			it = itemlist + i;
			if (!it->pickup)
				continue;
			if (!(it->flags & IT_AMMO))
				continue;
			Add_Ammo (ent, it, 1000);
		}
		if (!give_all)
			return;
	}

	if (give_all || Q_stricmp(name, "armor") == 0)
	{
		gitem_armor_t	*info;

		it = FindItem("Jacket Armor");
		ent->client->pers.inventory[ITEM_INDEX(it)] = 0;

		it = FindItem("Combat Armor");
		ent->client->pers.inventory[ITEM_INDEX(it)] = 0;

		it = FindItem("Body Armor");
		info = (gitem_armor_t *)it->info;
		ent->client->pers.inventory[ITEM_INDEX(it)] = info->max_count;

		if (!give_all)
			return;
	}

	if (give_all || Q_stricmp(name, "Power Shield") == 0)
	{
		it = FindItem("Power Shield");
		it_ent = G_Spawn();
		it_ent->classname = it->classname;
		SpawnItem (it_ent, it);
		Touch_Item (it_ent, ent, NULL, NULL);
		if (it_ent->inuse)
			G_FreeEdict(it_ent);

		if (!give_all)
			return;
	}

	if (give_all)
	{
		for (i=0 ; i<game.num_items ; i++)
		{
			it = itemlist + i;
			if (!it->pickup)
				continue;
			if (it->flags & (IT_ARMOR|IT_WEAPON|IT_AMMO))
				continue;
			ent->client->pers.inventory[i] = 1;
		}
		return;
	}

	it = FindItem (name);
	if (!it)
	{
		name = gi.argv(1);
		it = FindItem (name);
		if (!it)
		{
			gi.dprintf ("unknown item\n");
			return;
		}
	}

	if (!it->pickup)
	{
		gi.dprintf ("non-pickup item\n");
		return;
	}

	index = ITEM_INDEX(it);

	if (it->flags & IT_AMMO)
	{
		if (gi.argc() == 3)
			ent->client->pers.inventory[index] = atoi(gi.argv(2));
		else
			ent->client->pers.inventory[index] += it->quantity;
	}
	else
	{
		it_ent = G_Spawn();
		it_ent->classname = it->classname;
		SpawnItem (it_ent, it);
		Touch_Item (it_ent, ent, NULL, NULL);
		if (it_ent->inuse)
			G_FreeEdict(it_ent);
	}
}



/*
=================
Cmd_Airstrike_f
CCH: new function to call in airstrikes
JDB: modified 5/4/98
=================
*/
void Cmd_Airstrike_f (edict_t *ent)
{
       vec3_t  start;
       vec3_t  forward;
       vec3_t world_up;
       vec3_t  end;
       trace_t tr;


        // cancel airstrike if it's already been called
        if ( ent->client->airstrike_called )
        {
                ent->client->airstrike_called = 0;
                gi.cprintf(ent, PRINT_HIGH, "The airstrike has been called off!!\n");
                gi.sound(ent, CHAN_ITEM, gi.soundindex("world/pilot1.wav"), 0.4, ATTN_NORM, 0);
                ent->client->pers.airstrike = 0;
                return;
        }
       if (ent->client->pers.airstrike == 1) {return;}
       ent->client->pers.airstrike = 1;

       // see if we're pointed at the sky
       VectorCopy(ent->s.origin, start);
       start[2] += ent->viewheight;
       AngleVectors(ent->client->v_angle, forward, NULL, NULL);
       VectorMA(start, 8192, forward, end);
       tr = gi.trace(start, NULL, NULL, end, ent, MASK_SHOT|CONTENTS_SLIME|CONTENTS_LAVA);
       if ( tr.surface && !(tr.surface->flags & SURF_SKY) )
       {
        // We hit something but it wasn't sky, so let's see if there is sky above it!
                VectorCopy(tr.endpos,start);
                VectorSet(world_up, 0, 0, 1);
                VectorMA(start, 8192, world_up, end);
                tr = gi.trace(start, NULL, NULL, end, ent, MASK_SHOT|CONTENTS_SLIME|CONTENTS_LAVA);
                if ( tr.surface && !(tr.surface->flags & SURF_SKY))  // No sky above it either!!
                {
                        gi.cprintf(ent, PRINT_HIGH, "Airstrikes have to come from the sky!!!\n");
                        gi.sound(ent, CHAN_ITEM, gi.soundindex("world/pilot1.wav"), 0.4, ATTN_NORM, 0);
                        ent->client->pers.airstrike = 0;
                        return;
                }
        }

       // set up for the airstrike
       VectorCopy(tr.endpos, ent->client->airstrike_entry);
       ent->client->airstrike_called = 1;
       ent->client->airstrike_time = level.time + 14;
       gi.cprintf(ent, PRINT_HIGH, "Airstrike on it's way! Light on the target. ETA 15 seconds.\n");
       gi.sound(ent, CHAN_ITEM, gi.soundindex("world/pilot3.wav"), 0.8, ATTN_NORM, 0);
}



/*
==================
Cmd_God_f

Sets client to godmode

argv(0) god
==================
*/
void Cmd_God_f (edict_t *ent)
{
	char	*msg;

	if (deathmatch->value && !sv_cheats->value)
	{
		gi.cprintf (ent, PRINT_HIGH, "You must run the server with '+set cheats 1' to enable this command.\n");
		return;
	}

	ent->flags ^= FL_GODMODE;
	if (!(ent->flags & FL_GODMODE) )
		msg = "godmode OFF\n";
	else
		msg = "godmode ON\n";

	gi.cprintf (ent, PRINT_HIGH, msg);
}







/*
==================
Cmd_Notarget_f

Sets client to notarget

argv(0) notarget
==================
*/
void Cmd_Notarget_f (edict_t *ent)
{
	char	*msg;

	if (deathmatch->value && !sv_cheats->value)
	{
		gi.cprintf (ent, PRINT_HIGH, "You must run the server with '+set cheats 1' to enable this command.\n");
		return;
	}

	ent->flags ^= FL_NOTARGET;
	if (!(ent->flags & FL_NOTARGET) )
		msg = "notarget OFF\n";
	else
		msg = "notarget ON\n";

	gi.cprintf (ent, PRINT_HIGH, msg);
}


/*
==================
Cmd_Noclip_f

argv(0) noclip
==================
*/
void Cmd_Noclip_f (edict_t *ent)
{
	char	*msg;

	if (deathmatch->value && !sv_cheats->value)
	{
		gi.cprintf (ent, PRINT_HIGH, "You must run the server with '+set cheats 1' to enable this command.\n");
		return;
	}

	if (ent->movetype == MOVETYPE_NOCLIP)
	{
		ent->movetype = MOVETYPE_WALK;
		msg = "noclip OFF\n";
	}
	else
	{
		ent->movetype = MOVETYPE_NOCLIP;
		msg = "noclip ON\n";
	}

	gi.cprintf (ent, PRINT_HIGH, msg);
}


/*
==================
Cmd_Use_f

Use an inventory item
==================
*/
void Cmd_Use_f (edict_t *ent)
{
	int			index;
	gitem_t		*it;
	char		*s;
    
        s = gi.args();
	it = FindItem (s);
	if (!it)
	{
		gi.cprintf (ent, PRINT_HIGH, "unknown item: %s\n", s);
		return;
	}
	if (!it->use)
	{
		gi.cprintf (ent, PRINT_HIGH, "Item is not usable.\n");
		return;
	}
	index = ITEM_INDEX(it);
	if (!ent->client->pers.inventory[index])
	{
		gi.cprintf (ent, PRINT_HIGH, "Out of item: %s\n", s);
		return;
	}


	it->use (ent, it);
}


/*
==================
Cmd_Drop_f

Drop an inventory item
==================
*/
void Cmd_Drop_f (edict_t *ent)
{
	int			index;
	gitem_t		*it;
	char		*s;

	s = gi.args();
	it = FindItem (s);
	if (!it)
	{
		gi.cprintf (ent, PRINT_HIGH, "unknown item: %s\n", s);
		return;
	}
	if (!it->drop)
	{
		gi.cprintf (ent, PRINT_HIGH, "Item is not dropable.\n");
		return;
	}
	index = ITEM_INDEX(it);
	if (!ent->client->pers.inventory[index])
	{
		gi.cprintf (ent, PRINT_HIGH, "Out of item: %s\n", s);
		return;
	}

	it->drop (ent, it);
}


/*
=================
Cmd_Inven_f
=================
*/
void Cmd_Inven_f (edict_t *ent)
{
	int			i;
	gclient_t	*cl;

	cl = ent->client;

	cl->showscores = false;
	cl->showhelp = false;

	if (cl->showinventory)
	{
		cl->showinventory = false;
		return;
	}

	cl->showinventory = true;

	gi.WriteByte (svc_inventory);
	for (i=0 ; i<MAX_ITEMS ; i++)
	{
		gi.WriteShort (cl->pers.inventory[i]);
	}
	gi.unicast (ent, true);
	if (cl->pers.scanner_active & 1)
		cl->pers.scanner_active = 2;

        if (cl->pers.classes_active & 1)
                cl->pers.classes_active = 2;


}


/*
=================
Cmd_Info_f
=================
*/
void Cmd_Info_f (edict_t *ent)
{
if (ent->client->pers.class == 0) {
  gi.centerprintf (ent, "You are now in Spectator mode, type one\nof following commands to get out\nScout          = Spawn as scout\nAssasin        = Spawn as assasin\nSoldier        = Spawn as soldier\nDemoman        = Spawn as Demolition man\nHwguy          = Spawn as Heavy Weapons Guy\nEnergyguy      = Spawn as Energy Trooper\nEngineer       = Spawn as Engineer\nCommando       = Spawn as Commando\nBerserk        = Spawn as Berserk\n");

}
if (ent->client->pers.class == 1) {
  gi.centerprintf (ent, "You are now Scout, your commands are:\n\nBoots = Toggle on/off antigrav boots\n\nGtype = Toggle between grenades\n\n Scanner = Toggle Scanner On/Off\n");
}
if (ent->client->pers.class == 2) {
  gi.centerprintf (ent, "You are now Assasin, your commands are:\n\nLaserSight = Toggle on/off LaserSight\n");
  }
if (ent->client->pers.class == 3) {
  gi.centerprintf (ent, "You are now Soldier, your commands are:\n\nAirStrike = Call Airstrike\n\nGtype = Toggle Between grenade types");
  }
if (ent->client->pers.class == 4) {
  gi.centerprintf (ent, "You are now Demoman, your commands are:\n\nGtype = Toggle between grenade types\n\nAirStrike = Call Airstrike\nDetpipe = Detonate PipeBombs\n");
  }
if (ent->client->pers.class == 5) {
  gi.centerprintf (ent, "You are now Hwguy, your commands are:\n\nAirStrike = Call Airstrike\n");
 }
if (ent->client->pers.class == 6) {
  gi.centerprintf (ent, "You are now EnergyTrooper, your commands are:\n\nPush = Push player\n\n Pull = Pull player\n");
 }
if (ent->client->pers.class == 7) {
  gi.centerprintf (ent, "You are now Engineer, your commands are:\n\nLaser = Create Laser Trap\n\nDog = Create parasite");
   }
if (ent->client->pers.class == 8) {
  gi.centerprintf (ent, "You are now Commando, your commands are:\n\nHook2 = Use Grappling hook\n");
   }
if (ent->client->pers.class == 9) {
  gi.centerprintf (ent, "You are now Berserk, your commands are:\n\nSword = Activate Sword\n\nKamikaze = Blow Yourself to pieces\n\nCloak = Become invisible\n");
   }
if (ent->client->pers.class == 10) {
  gi.centerprintf (ent, "You are now Spy, your commands are:\n\nSword = Activate Sword\n\nDisguise = Go to undercover\n\n Scanner = Toggle Scanner On/Off\n\n Gtype = Toggle between gas & normal grenades\n");
   }


}




/*
=================
Cmd_InvUse_f
=================
*/
void Cmd_InvUse_f (edict_t *ent)
{
	gitem_t		*it;
                

        if (!ent->client->pers.classes_active & 1) {
	ValidateSelectedItem (ent);

	if (ent->client->pers.selected_item == -1)
	{
		gi.cprintf (ent, PRINT_HIGH, "No item to use.\n");
		return;
	}

	it = &itemlist[ent->client->pers.selected_item];
	if (!it->use)
	{
		gi.cprintf (ent, PRINT_HIGH, "Item is not usable.\n");
		return;
	}
	it->use (ent, it);
        }
        else {
        if (ent->client->pers.selected == 1) {
            ent->client->pers.nextclass = 1;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as scout\n");}
        if (ent->client->pers.selected == 2) {

            ent->client->pers.nextclass = 2;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as assasin\n");}
        if (ent->client->pers.selected == 3) {

            ent->client->pers.nextclass = 3;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as soldier\n");}
        if (ent->client->pers.selected == 4) {

            ent->client->pers.nextclass = 4;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as demolition man\n");}
        if (ent->client->pers.selected == 5) {

            ent->client->pers.nextclass = 5;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as heavy weapons guy\n");}
        if (ent->client->pers.selected == 6) {

            ent->client->pers.nextclass = 6;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as Energy Warrior\n");}
        if (ent->client->pers.selected == 7) {

            ent->client->pers.nextclass = 7;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as engineer\n");}
        if (ent->client->pers.selected == 8) {

            ent->client->pers.nextclass = 8;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as commando\n");}
            if (ent->client->pers.selected == 9) {

            ent->client->pers.nextclass = 9;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as berserk\n");}

            if (ent->client->pers.selected == 10) {

            ent->client->pers.nextclass = 10;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as spy\n");}


        }

}

/*
=================
Cmd_WeapPrev_f
=================
*/
void Cmd_WeapPrev_f (edict_t *ent)
{
	gclient_t	*cl;
	int			i, index;
	gitem_t		*it;
	int			selected_weapon;

	cl = ent->client;

	if (!cl->pers.weapon)
		return;

	selected_weapon = ITEM_INDEX(cl->pers.weapon);

	// scan  for the next valid one
	for (i=1 ; i<=MAX_ITEMS ; i++)
	{
		index = (selected_weapon + i)%MAX_ITEMS;
		if (!cl->pers.inventory[index])
			continue;
		it = &itemlist[index];
		if (!it->use)
			continue;
		if (! (it->flags & IT_WEAPON) )
			continue;
		it->use (ent, it);
		if (cl->pers.weapon == it)
			return;	// successful
	}
}

/*
=================
Cmd_WeapNext_f
=================
*/
void Cmd_WeapNext_f (edict_t *ent)
{
	gclient_t	*cl;
	int			i, index;
	gitem_t		*it;
	int			selected_weapon;

	cl = ent->client;

	if (!cl->pers.weapon)
		return;

	selected_weapon = ITEM_INDEX(cl->pers.weapon);

	// scan  for the next valid one
	for (i=1 ; i<=MAX_ITEMS ; i++)
	{
		index = (selected_weapon + MAX_ITEMS - i)%MAX_ITEMS;
		if (!cl->pers.inventory[index])
			continue;
		it = &itemlist[index];
		if (!it->use)
			continue;
		if (! (it->flags & IT_WEAPON) )
			continue;
		it->use (ent, it);
		if (cl->pers.weapon == it)
			return;	// successful
	}
}

/*
=================
Cmd_WeapLast_f
=================
*/
void Cmd_WeapLast_f (edict_t *ent)
{
	gclient_t	*cl;
	int			index;
	gitem_t		*it;

	cl = ent->client;

	if (!cl->pers.weapon || !cl->pers.lastweapon)
		return;

	index = ITEM_INDEX(cl->pers.lastweapon);
	if (!cl->pers.inventory[index])
		return;
	it = &itemlist[index];
	if (!it->use)
		return;
	if (! (it->flags & IT_WEAPON) )
		return;
	it->use (ent, it);
}

/*
=================
Cmd_InvDrop_f
=================
*/
void Cmd_InvDrop_f (edict_t *ent)
{
	gitem_t		*it;

	ValidateSelectedItem (ent);

	if (ent->client->pers.selected_item == -1)
	{
		gi.cprintf (ent, PRINT_HIGH, "No item to drop.\n");
		return;
	}

	it = &itemlist[ent->client->pers.selected_item];
	if (!it->drop)
	{
		gi.cprintf (ent, PRINT_HIGH, "Item is not dropable.\n");
		return;
	}
	it->drop (ent, it);
}

/*
=================
Cmd_Kill_f
=================
*/
void Cmd_Kill_f (edict_t *ent)
{
	if((level.time - ent->client->respawn_time) < 5)
		return;
	ent->flags &= ~FL_GODMODE;
	ent->health = 0;
	meansOfDeath = MOD_SUICIDE;
	player_die (ent, ent, ent, 100000, vec3_origin);
	// don't even bother waiting for death frames
	ent->deadflag = DEAD_DEAD;
	respawn (ent);
}


/*
=================
Cmd_Spawn_f
=================
*/
void Cmd_Spawn_f (edict_t *ent)
{
        
        if ((int)(dmflags->value) & DF_NOAUTOASSIGN)
        {
        if (ent->tw_team > 0) {
        if((level.time - ent->client->respawn_time) < 2)
		return;
	ent->flags &= ~FL_GODMODE;
	ent->health = 0;
	ent->deadflag = DEAD_DEAD;
	respawn (ent);
        }
        else
        gi.cprintf(ent, PRINT_HIGH, "You must first select your team, type:team 1 or team 2\n");
        }
        else {
        if((level.time - ent->client->respawn_time) < 2)
		return;
	ent->flags &= ~FL_GODMODE;
	ent->health = 0;
	ent->deadflag = DEAD_DEAD;
	respawn (ent);
}
}


/*
=================
Cmd_PutAway_f
=================
*/
void Cmd_PutAway_f (edict_t *ent)
{
	ent->client->showscores = false;
	ent->client->showhelp = false;
	ent->client->showinventory = false;
}


int PlayerSort (void const *a, void const *b)
{
	int		anum, bnum;

	anum = *(int *)a;
	bnum = *(int *)b;

	anum = game.clients[anum].ps.stats[STAT_FRAGS];
	bnum = game.clients[bnum].ps.stats[STAT_FRAGS];

	if (anum < bnum)
		return -1;
	if (anum > bnum)
		return 1;
	return 0;
}

void Cmd_Disguise_f (edict_t *ent)
{
        int                 index;
	gitem_t		*it;
	char		*s;
        char            userinfo[MAX_INFO_STRING];
	char		*name;
	name = gi.args();

if (ent->tw_team == 1) s = "Red Flag";
if (ent->tw_team == 2) s = "Blue Flag";

	it = FindItem (s);
	index = ITEM_INDEX(it);
	if (!ent->client->pers.inventory[index])
	{

        

if (Q_stricmp(name, "scout") == 0) {ent->disguised_class = 1;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Scout\n");
}
else if (Q_stricmp(name, "assasin") == 0) {ent->disguised_class = 2;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Assasin\n");
}
else if (Q_stricmp(name, "soldier") == 0) {ent->disguised_class = 3;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Soldier\n");
}
else if (Q_stricmp(name, "demoman") == 0) {ent->disguised_class = 4;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Demoman\n");
}
else if (Q_stricmp(name, "hwguy") == 0) {ent->disguised_class = 5;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Hwguy\n");
}
else if (Q_stricmp(name, "energyguy") == 0) {ent->disguised_class = 6;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Energy Trooper\n");
}
else if (Q_stricmp(name, "engineer") == 0) {ent->disguised_class = 7;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Engineer\n");
}
else if (Q_stricmp(name, "commando") == 0) {ent->disguised_class = 8;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Commando\n");
}
else if (Q_stricmp(name, "berserk") == 0) {ent->disguised_class = 9;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Berserk\n");
}
else if (Q_stricmp(name, "spy") == 0) {ent->disguised_class = 10;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as Spy\n");
}
else if (Q_stricmp(name, "red") == 0) {ent->disguised_team = 2;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as red team\n");
}
else if (Q_stricmp(name, "blue") == 0) {ent->disguised_team = 1;
gi.cprintf (ent, PRINT_HIGH, "You are now disguised as blue team\n");
}
else  {
gi.cprintf (ent, PRINT_HIGH, "You have to give parameters, for exam: disguise red, disguise assasin\n");
}
memcpy (userinfo, ent->client->pers.userinfo, sizeof(userinfo));
ClientUserinfoChanged (ent, userinfo);
	}
        else
        {
gi.cprintf (ent, PRINT_HIGH, "You can't disguise while glowing\n");

        }
}

/*
=================
Cmd_Players_f
=================
*/
void Cmd_Players_f (edict_t *ent)
{
	int		i;
	int		count;
	char	small[64];
	char	large[1280];
	int		index[256];

	count = 0;
	for (i = 0 ; i < maxclients->value ; i++)
		if (game.clients[i].pers.connected)
		{
			index[count] = i;
			count++;
		}

	// sort by frags
	qsort (index, count, sizeof(index[0]), PlayerSort);

	// print information
	large[0] = 0;

	for (i = 0 ; i < count ; i++)
	{
		Com_sprintf (small, sizeof(small), "%3i %s\n",
			game.clients[index[i]].ps.stats[STAT_FRAGS],
			game.clients[index[i]].pers.netname);
		if (strlen (small) + strlen(large) > sizeof(large) - 100 )
		{	// can't print all of them in one packet
			strcat (large, "...\n");
			break;
		}
		strcat (large, small);
	}

	gi.cprintf (ent, PRINT_HIGH, "%s\n%i players\n", large, count);
}

/*
=================
Cmd_Wave_f
=================
*/
void Cmd_Wave_f (edict_t *ent)
{
	int		i;

	i = atoi (gi.argv(1));

	// can't wave when ducked
	if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
		return;

	if (ent->client->anim_priority > ANIM_WAVE)
		return;

	ent->client->anim_priority = ANIM_WAVE;

	switch (i)
	{
	case 0:
		gi.cprintf (ent, PRINT_HIGH, "flipoff\n");
		ent->s.frame = FRAME_flip01-1;
		ent->client->anim_end = FRAME_flip12;
		break;
	case 1:
		gi.cprintf (ent, PRINT_HIGH, "salute\n");
		ent->s.frame = FRAME_salute01-1;
		ent->client->anim_end = FRAME_salute11;
		break;
	case 2:
		gi.cprintf (ent, PRINT_HIGH, "taunt\n");
		ent->s.frame = FRAME_taunt01-1;
		ent->client->anim_end = FRAME_taunt17;
		break;
	case 3:
		gi.cprintf (ent, PRINT_HIGH, "wave\n");
		ent->s.frame = FRAME_wave01-1;
		ent->client->anim_end = FRAME_wave11;
		break;
	case 4:
	default:
		gi.cprintf (ent, PRINT_HIGH, "point\n");
		ent->s.frame = FRAME_point01-1;
		ent->client->anim_end = FRAME_point12;
		break;
	}
}

void Cmd_Yell_f (edict_t *ent)
{
	int		i;

	i = atoi (gi.argv(1));

        if (i == 1)
        gi.sound (ent, CHAN_ITEM, gi.soundindex ("speech/watchit1.wav"), 1, ATTN_NORM, 0);
        else
        if (i == 2)
        gi.sound (ent, CHAN_ITEM, gi.soundindex ("speech/spy1.wav"), 1, ATTN_NORM, 0);
        else
        if (i == 3)
        gi.sound (ent, CHAN_ITEM, gi.soundindex ("speech/diedie.wav"), 1, ATTN_NORM, 0);
        else
        if (i == 4)
        gi.sound (ent, CHAN_ITEM, gi.soundindex ("speech/pathetic.wav"), 1, ATTN_NORM, 0);
        else
        if (i == 5)
        gi.sound (ent, CHAN_ITEM, gi.soundindex ("speech/problem.wav"), 1, ATTN_NORM, 0);
        else
        gi.cprintf (ent, PRINT_HIGH, "Parameters:1 'Watchit!' 2 'there is a spy'\n3-5 insults\n");

}

/*
==================
Cmd_Say_f
==================
*/
void Cmd_Say_f (edict_t *ent, qboolean team, qboolean arg0)
{
	int		j;
	edict_t	*other;
	char	*p;
	char	text[2048];
	if (gi.argc () < 2 && !arg0)
		return;

//        if (!((int)(dmflags->value) & (DF_MODELTEAMS | DF_SKINTEAMS)))
//                team = false;

	if (team)
		Com_sprintf (text, sizeof(text), "(%s): ", ent->client->pers.netname);
	else
		Com_sprintf (text, sizeof(text), "%s: ", ent->client->pers.netname);

	if (arg0)
	{
		strcat (text, gi.argv(0));
		strcat (text, " ");
		strcat (text, gi.args());
	}
	else
	{
		p = gi.args();

		if (*p == '"')
		{
			p++;
			p[strlen(p)-1] = 0;
		}
		strcat(text, p);
	}

	// don't let text be too long for malicious reasons
	if (strlen(text) > 150)
		text[150] = 0;

	strcat(text, "\n");

	if (dedicated->value)
		gi.cprintf(NULL, PRINT_CHAT, "%s", text);

	for (j = 1; j <= game.maxclients; j++)
	{
		other = &g_edicts[j];
		if (!other->inuse)
			continue;
		if (!other->client)
			continue;
		if (team)
		{
			if (!OnSameTeam(ent, other))
				continue;
		}
if (ent->floodtime < level.time) {ent->floodtime = level.time + 2; }
else
ent->floodtime = ent->floodtime + 2;
if (ent->floodtime > level.time + 15) {
   gi.cprintf(ent, PRINT_HIGH, "You flooded too much, wait for while.\n");
   ent->flooded = 1;
   return;
   }
if (ent->flooded == 1) if (ent->floodtime > level.time + 3) {
gi.cprintf(ent, PRINT_HIGH, "You flooded too much, wait for while.\n");
return;
}
else
ent->flooded = 0;
		gi.cprintf(other, PRINT_CHAT, "%s", text);
	}
}

void Cmd_Reduce_Cells (edict_t *ent, int amount)
{
        gitem_t         *item;
        item = FindItem("Cells");
        ent->client->pers.selected_item = ITEM_INDEX(item);
        ent->client->pers.inventory[ent->client->pers.selected_item] =ent->client->pers.inventory[ent->client->pers.selected_item] - amount;
}

qboolean Reduce_Cells (edict_t *ent, int amount)
{
        gitem_t         *item;
        item = FindItem("Cells");
        ent->client->pers.selected_item = ITEM_INDEX(item);
        if (ent->client->pers.inventory[ent->client->pers.selected_item] - amount > -1)
        {
Cmd_Reduce_Cells (ent, amount);
return true;
}
else {
gi.cprintf (ent, PRINT_HIGH, "You do not have enough cells, you need %i cells for it\n", amount);
return false;
}
}



/*
==================
Cmd_Say_Team_f
==================
*/
void Cmd_Say_Team_f (edict_t *ent, qboolean team, qboolean arg0)
{
	int		j;
	edict_t	*other;
	char	*p;
	char	text[2048];

	if (gi.argc () < 2 && !arg0)
		return;

		Com_sprintf (text, sizeof(text), "(%s): ", ent->client->pers.netname);

	if (arg0)
	{
		strcat (text, gi.argv(0));
		strcat (text, " ");
		strcat (text, gi.args());
	}
	else
	{
		p = gi.args();

		if (*p == '"')
		{
			p++;
			p[strlen(p)-1] = 0;
		}
		strcat(text, p);
	}

	// don't let text be too long for malicious reasons
	if (strlen(text) > 150)
		text[150] = 0;

	strcat(text, "\n");

	if (dedicated->value)
		gi.cprintf(NULL, PRINT_CHAT, "%s", text);

	for (j = 1; j <= game.maxclients; j++)
	{
		other = &g_edicts[j];
		if (!other->inuse)
			continue;
		if (!other->client)
			continue;
                if (ent->tw_team == other->tw_team) {
		gi.cprintf(other, PRINT_CHAT, "%s", text);
                }
	}
}

/*
=================
Cmd_id_f
=================
*/
void Cmd_id_f (edict_t *ent)
{
int j;
    char stats[500];
    vec3_t  start, forward, end;
trace_t tr;
    j = sprintf(stats, "     NAME              RANGE          TEAM\n\n");

VectorCopy(ent->s.origin, start);
    start[2] += ent->viewheight;
    AngleVectors(ent->client->v_angle, forward, NULL, NULL);
    VectorMA(start, 8192, forward, end);
    tr = gi.trace(start, NULL, NULL, end, ent,
MASK_SHOT|CONTENTS_SLIME|CONTENTS_LAVA);
    if (tr.ent->client)
{
j += sprintf(stats + j, "%16s          %i                %i\n",
tr.ent->client->pers.netname, (int)(tr.fraction * 512)), ent->tw_team;
gi.centerprintf(ent, "%s", stats);      
}

}
// End code

/*
=================
Cmd_Push_f
=================
*/
void Cmd_Push_f (edict_t *ent)
{
       vec3_t  start;
       vec3_t  forward;
       vec3_t  end;
       trace_t tr;

       VectorCopy(ent->s.origin, start);
       start[2] += ent->viewheight;
       AngleVectors(ent->client->v_angle, forward, NULL, NULL);
       VectorMA(start, 8192, forward, end);
       tr = gi.trace(start, NULL, NULL, end, ent, MASK_SHOT);
       if ( tr.ent && ((tr.ent->svflags & SVF_MONSTER) || (tr.ent->client)) )
       {
               VectorScale(forward, 5000, forward);
               VectorAdd(forward, tr.ent->velocity, tr.ent->velocity);
       }
}



void Cmd_Cloak_f (edict_t *ent)
{

	int			index;
	gitem_t		*it;
	char		*s;

if (ent->tw_team == 1) s = "Red Flag";
if (ent->tw_team == 2) s = "Blue Flag";

	it = FindItem (s);
	index = ITEM_INDEX(it);
        if (ent->client->pers.inventory[index])
	{
		return;
	}

                     if (ent->svflags & SVF_NOCLIENT) {
                       gi.cprintf (ent, PRINT_HIGH, "You are now visible!\n");
                       ent->client->pers.cloak = 0;
                       ent->svflags -= SVF_NOCLIENT;   }
               else    {
                       gi.cprintf (ent, PRINT_HIGH, "You are now cloaked!\n");
                       ent->client->pers.cloak = 1;
                       ent->svflags |= SVF_NOCLIENT;
                                  }

}
/*
=================
Cmd_Pull_f
=================
*/
void Cmd_Pull_f (edict_t *ent)
{
       vec3_t  start;
       vec3_t  forward;
       vec3_t  end;
       trace_t tr;

       VectorCopy(ent->s.origin, start);
       start[2] += ent->viewheight;
       AngleVectors(ent->client->v_angle, forward, NULL, NULL);
       VectorMA(start, 8192, forward, end);
       tr = gi.trace(start, NULL, NULL, end, ent, MASK_SHOT);
       if ( tr.ent && ((tr.ent->svflags & SVF_MONSTER) || (tr.ent->client)) )
       {
               VectorScale(forward, -5000, forward);
               VectorAdd(forward, tr.ent->velocity, tr.ent->velocity);
       }
}

/*
=================
Cmd_CheckStats_f
CCH: New function to print all players' stats
=================
*/
void Cmd_CheckStats_f (edict_t *ent)
{
       int             i, j;
       edict_t *player;
       char    stats[500];
       vec3_t  v;
       float   len;

       // use in coop mode only
//     if (!coop->value)
//             return;

       j = sprintf(stats, "            Name      Health Range Class NO:\n=============================\n");
       for (i=0 ; i <= game.maxclients ; i++)
       {
               player = g_edicts + 1 + i;
               if (ent->tw_team != player->tw_team || !player->inuse || !player->client)
                       continue; 
               VectorSubtract (ent->s.origin, player->s.origin, v);
               len = VectorLength (v);
               j += sprintf(stats + j, "%16s %6d %5.0f %6d\n", player->client->pers.netname, player->health, len, player->client->pers.class);
               if (j > 450)
                       break;
       }
       gi.centerprintf(ent, "%s", stats);
}



/*
=================
ClientCommand
=================
*/
void ClientCommand (edict_t *ent)
{
	gitem_t		*item;
	char	*cmd;

	if (!ent->client)
		return;		// not fully in game yet

	cmd = gi.argv(0);

	if (Q_stricmp (cmd, "players") == 0)
	{
		Cmd_Players_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "say") == 0)
	{
		Cmd_Say_f (ent, false, false);
		return;
	}
	if (Q_stricmp (cmd, "say_team") == 0)
	{
                Cmd_Say_Team_f (ent, true, false);
		return;
	}
	if (Q_stricmp (cmd, "score") == 0)
	{
		Cmd_Score_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "help") == 0)
	{
		Cmd_Help_f (ent);
		return;
	}

	if (level.intermissiontime)
		return;

	if (Q_stricmp (cmd, "use") == 0)
		Cmd_Use_f (ent);
	else if (Q_stricmp (cmd, "drop") == 0)
		Cmd_Drop_f (ent);
       else if (Q_stricmp (cmd, "push") == 0) {
       if (ent->client->pers.class == 6) 
               Cmd_Push_f (ent);
               }
       else if (Q_stricmp (cmd, "pull") == 0){
       if (ent->client->pers.class == 6)  
               Cmd_Pull_f (ent);
               }
	else if (Q_stricmp (cmd, "give") == 0)
		Cmd_Give_f (ent);
	else if (Q_stricmp (cmd, "god") == 0)
		Cmd_God_f (ent);
	else if (Q_stricmp (cmd, "notarget") == 0)
		Cmd_Notarget_f (ent);
        else if (Q_stricmp (cmd, "yell") == 0)
                Cmd_Yell_f (ent);
        else if (Q_stricmp(cmd, "hook2") == 0)   {
        if (ent->client->pers.class == 8){
                Cmd_Hook_f(ent, gi.argv(1));
                }  
                }
        else if (Q_stricmp (cmd, "noclip") == 0)
		Cmd_Noclip_f (ent);
	else if (Q_stricmp (cmd, "inven") == 0)
		Cmd_Inven_f (ent);
        else if (Q_stricmp (cmd, "team") == 0) {
        int teamcommand=atoi(gi.argv(1));
        if (teamcommand == 0) {
        if (ent->tw_team == 3) gi.cprintf (ent, PRINT_HIGH, "Your Team is civilian\n");
        if (ent->tw_team == 1) gi.cprintf (ent, PRINT_HIGH, "Your Team is BLUE\n"); 
        if (ent->tw_team == 2) gi.cprintf (ent, PRINT_HIGH, "Your Team is RED\n");
        if (ent->tw_team == 0) gi.cprintf (ent, PRINT_HIGH, "You have no team\n");
        }
        if ((int)(dmflags->value) & DF_NOAUTOASSIGN)
        if (teamcommand == 1) {
        if (ent->tw_team == 0) {
        gi.cprintf (ent, PRINT_HIGH, "You are now at BLUE team\n");
        ent->tw_team = 1;
        level.team1 = level.team1 + 1;
        }
        }
        if ((int)(dmflags->value) & DF_NOAUTOASSIGN)
        if (teamcommand == 2) {
        if (ent->tw_team == 0) {
        gi.cprintf (ent, PRINT_HIGH, "You are now at RED team\n"); 
        ent->tw_team = 2;
        level.team2 = level.team2 + 1;
        }
        }
        }

        else if (Q_stricmp (cmd, "helpme") == 0)
                Cmd_Info_f (ent);
        else if (Q_stricmp (cmd, "invnext") == 0) {
		SelectNextItem (ent, -1);
                ent->client->pers.selected = ent->client->pers.selected + 1;
                if (ent->client->pers.selected > 10) ent->client->pers.selected = 1;
                }
        else if (Q_stricmp (cmd, "invprev") == 0) {
		SelectPrevItem (ent, -1);
                ent->client->pers.selected = ent->client->pers.selected - 1;
                if (ent->client->pers.selected < 1) ent->client->pers.selected = 10;

        }
	else if (Q_stricmp (cmd, "invnextw") == 0)
		SelectNextItem (ent, IT_WEAPON);
	else if (Q_stricmp (cmd, "invprevw") == 0)
		SelectPrevItem (ent, IT_WEAPON);
	else if (Q_stricmp (cmd, "invnextp") == 0)
		SelectNextItem (ent, IT_POWERUP);
	else if (Q_stricmp (cmd, "invprevp") == 0)
		SelectPrevItem (ent, IT_POWERUP);
	else if (Q_stricmp (cmd, "invuse") == 0)
		Cmd_InvUse_f (ent);
	else if (Q_stricmp (cmd, "invdrop") == 0)
		Cmd_InvDrop_f (ent);
	else if (Q_stricmp (cmd, "weapprev") == 0)
		Cmd_WeapPrev_f (ent);
	else if (Q_stricmp (cmd, "weapnext") == 0)
		Cmd_WeapNext_f (ent);
	else if (Q_stricmp (cmd, "weaplast") == 0)
		Cmd_WeapLast_f (ent);
        else if (Q_stricmp (cmd, "kill") == 0){
                if (ent->client->pers.class > 0)
                Cmd_Kill_f (ent);
                }
        else if (Q_stricmp (cmd, "spawnme") == 0){
        if (ent->client->pers.class == 0) 
                Cmd_Spawn_f (ent);
                }
	else if (Q_stricmp (cmd, "putaway") == 0)
		Cmd_PutAway_f (ent);
        else if (Q_stricmp (cmd, "bot") == 0)
                 OAK_Check_SP(ent);

   else if (Q_stricmp (cmd, "lasersight") == 0){
   if (ent->client->pers.class == 2)
           SP_LaserSight (ent);
   }
      
else if (Q_stricmp (cmd, "airstrike") == 0) {
if (ent->client->pers.class == 3)
Cmd_Airstrike_f (ent); 
if (ent->client->pers.class == 4)
Cmd_Airstrike_f (ent); 
if (ent->client->pers.class == 5)
Cmd_Airstrike_f (ent); 
}
else if (Q_stricmp (cmd, "scout") == 0) {
            ent->client->pers.nextclass = 1;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as scout\n");}
        else if (Q_stricmp (cmd, "assasin") == 0) {
            ent->client->pers.nextclass = 2;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as assasin\n");}
        else if (Q_stricmp (cmd, "soldier") == 0) {
            ent->client->pers.nextclass = 3;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as soldier\n");}
        else if (Q_stricmp (cmd, "demoman") == 0) {
            ent->client->pers.nextclass = 4;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as demolition man\n");}
        else if (Q_stricmp (cmd, "hwguy") == 0) {
            ent->client->pers.nextclass = 5;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as heavy weapons guy\n");}
        else if (Q_stricmp (cmd, "energyguy") == 0) {
            ent->client->pers.nextclass = 6;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as Energy Warrior\n");}
        else if (Q_stricmp (cmd, "engineer") == 0) {
            ent->client->pers.nextclass = 7;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as engineer\n");}
        else if (Q_stricmp (cmd, "Commando") == 0) {
            ent->client->pers.nextclass = 8;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as Commando\n");}
        else if (Q_stricmp (cmd, "berserk") == 0) {
            ent->client->pers.nextclass = 9;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as berserk\n");}
              else if (Q_stricmp (cmd, "spy") == 0) {
            ent->client->pers.nextclass = 10;
             if (ent->client->pers.class == 0) Cmd_Spawn_f (ent);
             gi.cprintf (ent, PRINT_HIGH, "Next time you will respawn as spy\n");}
      
 /*
        else if (Q_stricmp (cmd, "spectator") == 0) {
            ent->client->pers.nextclass = 0;
             gi.cprintf (ent, PRINT_HIGH, "When you die, you will be transferred to spectator mode\n");}
 */
	else if (Q_stricmp (cmd, "wave") == 0)
		Cmd_Wave_f (ent);
        // check if turret switch is active  
        else if (Q_stricmp (cmd, "turret") == 0)
               Cmd_Turret_f (ent);
        else if (Q_stricmp (cmd, "detpipe") == 0)
                Cmd_DetPipes_f (ent);
        else if (Q_stricmp (cmd, "cloak") == 0) {
        if (ent->client->pers.class == 9) if (ent->health > 0) {
        Cmd_Cloak_f (ent);
             }
             }
       else if (Q_stricmp (cmd, "Gtype") == 0) {
               if (ent->client->pers.class == 4) 
               {ent->client->pers.grenadevalue = ent->client->pers.grenadevalue + 1;
               if (ent->client->pers.grenadevalue > 4) ent->client->pers.grenadevalue = 0;
                       
               if (ent->client->pers.grenadevalue == 0) gi.cprintf (ent, PRINT_HIGH, "Normal Grenades Selected\n");
               if (ent->client->pers.grenadevalue == 1) gi.cprintf (ent, PRINT_HIGH, "Cluster Grenades Selected\n");
               if (ent->client->pers.grenadevalue == 2) gi.cprintf (ent, PRINT_HIGH, "MegaCluster Grenades Selected\n");
               if (ent->client->pers.grenadevalue == 3) gi.cprintf (ent, PRINT_HIGH, "Pipebombs Selected\n");
               if (ent->client->pers.grenadevalue == 4) gi.cprintf (ent, PRINT_HIGH, "Detpack Selected\n");

                }
                if (ent->client->pers.class == 3){
               ent->client->pers.grenadevalue = ent->client->pers.grenadevalue + 1;
               if (ent->client->pers.grenadevalue > 2) ent->client->pers.grenadevalue = 0;
                            if (ent->client->pers.grenadevalue == 0) 
               gi.cprintf (ent, PRINT_HIGH, "Normal Grenades Selected\n");

               if (ent->client->pers.grenadevalue == 1) 
               gi.cprintf (ent, PRINT_HIGH, "Laser Grenades Selected\n");
               if (ent->client->pers.grenadevalue == 2) 
               gi.cprintf (ent, PRINT_HIGH, "Guided Rockets Selected\n");
               }

                if (ent->client->pers.class == 2){
               ent->client->pers.grenadevalue = ent->client->pers.grenadevalue + 1;
               if (ent->client->pers.grenadevalue > 1) ent->client->pers.grenadevalue = 0;
                            if (ent->client->pers.grenadevalue == 0) 
               gi.cprintf (ent, PRINT_HIGH, "Normal Grenades Selected\n");

               if (ent->client->pers.grenadevalue == 1) 
               gi.cprintf (ent, PRINT_HIGH, "Flares Selected\n");
               }

                if (ent->client->pers.class == 10){
               ent->client->pers.grenadevalue = ent->client->pers.grenadevalue + 1;
               if (ent->client->pers.grenadevalue > 1) ent->client->pers.grenadevalue = 0;
                            if (ent->client->pers.grenadevalue == 0) 
               gi.cprintf (ent, PRINT_HIGH, "Normal Grenades Selected\n");

               if (ent->client->pers.grenadevalue == 1) 
               gi.cprintf (ent, PRINT_HIGH, "Gas grenades selected\n");
               }

                if (ent->client->pers.class == 7){
               ent->client->pers.grenadevalue = ent->client->pers.grenadevalue + 1;
               if (ent->client->pers.grenadevalue > 1) ent->client->pers.grenadevalue = 0;
                            if (ent->client->pers.grenadevalue == 0) 
               gi.cprintf (ent, PRINT_HIGH, "Normal Grenades Selected\n");

               if (ent->client->pers.grenadevalue == 1) 
               gi.cprintf (ent, PRINT_HIGH, "Pulse Grenades Selected\n");
               }


                if (ent->client->pers.class == 1){
               ent->client->pers.grenadevalue = ent->client->pers.grenadevalue + 1;
               if (ent->client->pers.grenadevalue > 2) ent->client->pers.grenadevalue = 0;
                            if (ent->client->pers.grenadevalue == 0) 
               gi.cprintf (ent, PRINT_HIGH, "Normal Grenades Selected\n");

               if (ent->client->pers.grenadevalue == 1) 
               gi.cprintf (ent, PRINT_HIGH, "Concussion Grenades Selected\n");
               if (ent->client->pers.grenadevalue == 2) 
               gi.cprintf (ent, PRINT_HIGH, "Concussion Mines Selected\n");
               }
                }

         else if (Q_stricmp (cmd, "dog") == 0) {
                if (ent->client->pers.class == 7)
                if (ent->monstercount < 2) {
                if (Reduce_Cells(ent,50))
                SP_monster_parasite2 (ent);
                }
                }
        else if (Q_stricmp (cmd, "gameversion") == 0)       {
		gi.cprintf (ent, PRINT_HIGH, "%s : %s\n", GAMEVERSION, __DATE__);	}	// yaya
        else if (Q_stricmp (cmd, "zoom") == 0)
        {
               int zoomtype=atoi(gi.argv(1));
               if (zoomtype==0)
               {
                       ent->client->ps.fov = 90;
               }
               else if (zoomtype==1)
               {
                       if (ent->client->ps.fov == 90) ent->client->ps.fov = 40;
                       else if (ent->client->ps.fov == 40) ent->client->ps.fov = 20;
                       else if (ent->client->ps.fov == 20) ent->client->ps.fov = 10;
                       else ent->client->ps.fov = 90;
               }
        }


        else if (Q_stricmp (cmd, "laser") == 0)
        if (ent->client->pers.class == 7)  PlaceLaser (ent); else return; 


       else if (Q_stricmp (cmd, "atype") == 0) {
       ent->client->pers.airstrikevalue = ent->client->pers.airstrikevalue + 1;
               if (ent->client->pers.airstrikevalue > 2) ent->client->pers.airstrikevalue = 0;
                       
               if (ent->client->pers.airstrikevalue == 0) gi.cprintf (ent, PRINT_HIGH, "Normal Bombing Selected\n");
               if (ent->client->pers.airstrikevalue == 1) gi.cprintf (ent, PRINT_HIGH, "Cluster Bombing Selected\n");
               if (ent->client->pers.airstrikevalue == 2) gi.cprintf (ent, PRINT_HIGH, "Napalm Bombing Selected\n");

                }



        else if (Q_stricmp (cmd, "boots") == 0)
        {
        if (ent->client->pers.class == 1) {
               if (ent->flags & FL_BOOTS)
               {
                       gi.cprintf (ent, PRINT_HIGH, "Anti Gravity Boots off\n");
                       ent->flags -= FL_BOOTS;
               }
               else
               {
                       gi.cprintf (ent, PRINT_HIGH, "Anti Gravity Boots on\n");
                       ent->flags |= FL_BOOTS;
               }
        }
        }
   /*
     else if (Q_stricmp (cmd, "sentry") == 0) {
     SP_sentry (ent);
     }
   */  
        else if (Q_stricmp (cmd, "scanner") == 0) {
     if (ent->client->pers.class == 1) 
     {
		Toggle_Scanner (ent);
     }
     else
     if (ent->client->pers.class == 10) {
		Toggle_Scanner (ent);
     }
     }
     
       else if (Q_stricmp (cmd, "checkstats") == 0)
               Cmd_CheckStats_f (ent);
        else if (Q_stricmp (cmd, "id") == 0)
        Cmd_id_f (ent);
             else if (Q_stricmp (cmd, "disguise") == 0) {
        if (ent->client->pers.class == 10)
        Cmd_Disguise_f (ent);
        }
        else if (Q_stricmp (cmd, "classes2") == 0)
        ClassHelpMenu(ent);
        else if (Q_stricmp (cmd, "classes") == 0) 
        Toggle_Classes(ent);
     else if (Q_stricmp (cmd, "kamikaze") == 0) {
     if (ent->client->pers.class == 9)
     {
     Start_Kamikaze_Mode (ent);
     }
     }  



   	else	// anything that doesn't match a command will be a chat
		Cmd_Say_f (ent, false, true);
}
