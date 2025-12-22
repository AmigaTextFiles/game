#include "g_local.h"
#include "m_player.h"

void ClientUserinfoChanged (edict_t *ent, char *userinfo);
void weapon_grenade_fire (edict_t *ent, qboolean held);//TROND
void Decide_Score (edict_t *self, edict_t *attacker);//TROND
void SP_Values (edict_t *ent);//TROND 15/3
void CTFOpenSkinMenu(edict_t *ent);//TROND 28/3
void CTFOpenWepMenu(edict_t *ent);//TROND 28/3
void LMS_PlayerCount ( void );//TROND 23/4

void SP_misc_teleporter_dest (edict_t *ent);

//
// Gross, ugly, disgustuing hack section
//

// this function is an ugly as hell hack to fix some map flaws
//
// the coop spawn spots on some maps are SNAFU.  There are coop spots
// with the wrong targetname as well as spots with no name at all
//
// we use carnal knowledge of the maps to fix the coop spot targetnames to match
// that of the nearest named single player spot

static void SP_FixCoopSpots (edict_t *self)
{
	edict_t	*spot;
	vec3_t	d;

	spot = NULL;

	while(1)
	{
		spot = G_Find(spot, FOFS(classname), "info_player_start");
		if (!spot)
			return;
		if (!spot->targetname)
			continue;
		VectorSubtract(self->s.origin, spot->s.origin, d);
		if (VectorLength(d) < 384)
		{
			if ((!self->targetname) || Q_stricmp(self->targetname, spot->targetname) != 0)
			{
//				gi.dprintf("FixCoopSpots changed %s at %s targetname from %s to %s\n", self->classname, vtos(self->s.origin), self->targetname, spot->targetname);
				self->targetname = spot->targetname;
			}
			return;
		}
	}
}

// now if that one wasn't ugly enough for you then try this one on for size
// some maps don't have any coop spots at all, so we need to create them
// where they should have been

static void SP_CreateCoopSpots (edict_t *self)
{
	edict_t	*spot;

	if(Q_stricmp(level.mapname, "security") == 0)
	{
		spot = G_Spawn();
		spot->classname = "info_player_coop";
		spot->s.origin[0] = 188 - 64;
		spot->s.origin[1] = -164;
		spot->s.origin[2] = 80;
		spot->targetname = "jail3";
		spot->s.angles[1] = 90;

		spot = G_Spawn();
		spot->classname = "info_player_coop";
		spot->s.origin[0] = 188 + 64;
		spot->s.origin[1] = -164;
		spot->s.origin[2] = 80;
		spot->targetname = "jail3";
		spot->s.angles[1] = 90;

		spot = G_Spawn();
		spot->classname = "info_player_coop";
		spot->s.origin[0] = 188 + 128;
		spot->s.origin[1] = -164;
		spot->s.origin[2] = 80;
		spot->targetname = "jail3";
		spot->s.angles[1] = 90;

		return;
	}
}


/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 32)
The normal starting point for a level.
*/
void SP_info_player_start(edict_t *self)
{
	if (!coop->value)
		return;
	if(Q_stricmp(level.mapname, "security") == 0)
	{
		// invoke one of our gross, ugly, disgusting hacks
		self->think = SP_CreateCoopSpots;
		self->nextthink = level.time + FRAMETIME;
	}
}

/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 32)
potential spawning position for deathmatch games
*/
void SP_info_player_deathmatch(edict_t *self)
{
	if (!deathmatch->value)
	{
		G_FreeEdict (self);
		return;
	}
	SP_misc_teleporter_dest (self);
}

/*QUAKED info_player_coop (1 0 1) (-16 -16 -24) (16 16 32)
potential spawning position for coop games
*/

void SP_info_player_coop(edict_t *self)
{
	if (!coop->value)
	{
		G_FreeEdict (self);
		return;
	}

	if((Q_stricmp(level.mapname, "jail2") == 0)   ||
	   (Q_stricmp(level.mapname, "jail4") == 0)   ||
	   (Q_stricmp(level.mapname, "mine1") == 0)   ||
	   (Q_stricmp(level.mapname, "mine2") == 0)   ||
	   (Q_stricmp(level.mapname, "mine3") == 0)   ||
	   (Q_stricmp(level.mapname, "mine4") == 0)   ||
	   (Q_stricmp(level.mapname, "lab") == 0)     ||
	   (Q_stricmp(level.mapname, "boss1") == 0)   ||
	   (Q_stricmp(level.mapname, "fact3") == 0)   ||
	   (Q_stricmp(level.mapname, "biggun") == 0)  ||
	   (Q_stricmp(level.mapname, "space") == 0)   ||
	   (Q_stricmp(level.mapname, "command") == 0) ||
	   (Q_stricmp(level.mapname, "power2") == 0) ||
	   (Q_stricmp(level.mapname, "strike") == 0))
	{
		// invoke one of our gross, ugly, disgusting hacks
		self->think = SP_FixCoopSpots;
		self->nextthink = level.time + FRAMETIME;
	}
}


/*QUAKED info_player_intermission (1 0 1) (-16 -16 -24) (16 16 32)
The deathmatch intermission point will be at one of these
Use 'angles' instead of 'angle', so you can set pitch or roll as well as yaw.  'pitch yaw roll'
*/
void SP_info_player_intermission(void)
{
}


//=======================================================================


void player_pain (edict_t *self, edict_t *other, float kick, int damage)
{
	// player pain is handled at the end of the frame in P_DamageFeedback
}


qboolean IsFemale (edict_t *ent)
{
	char		*info;

	if (!ent->client)
		return false;

	info = Info_ValueForKey (ent->client->pers.userinfo, "gender");
	if (info[0] == 'f' || info[0] == 'F')
		return true;
	return false;
}

qboolean IsNeutral (edict_t *ent)
{
	char		*info;

	if (!ent->client)
		return false;

	info = Info_ValueForKey (ent->client->pers.userinfo, "gender");
	if (info[0] != 'f' && info[0] != 'F' && info[0] != 'm' && info[0] != 'M')
		return true;
	return false;
}

void ClientObituary (edict_t *self, edict_t *inflictor, edict_t *attacker)
{
	int			mod;
	char		*message;
	char		*message2;
	qboolean	ff;

	if (coop->value && attacker->client)
		meansOfDeath |= MOD_FRIENDLY_FIRE;

	if (deathmatch->value || coop->value)
	{
		ff = meansOfDeath & MOD_FRIENDLY_FIRE;
		mod = meansOfDeath & ~MOD_FRIENDLY_FIRE;
		message = NULL;
		message2 = "";

		switch (mod)
		{
		case MOD_SUICIDE:
			message = "suicides";
			break;
		case MOD_FALLING:
			message = "cratered";
			break;
		case MOD_CRUSH:
			message = "was squished";
			break;
		case MOD_WATER:
			message = "sank like a rock";
			break;
		case MOD_SLIME:
			message = "melted";
			break;
		case MOD_LAVA:
			message = "does a back flip into the lava";
			break;
		case MOD_EXPLOSIVE:
		case MOD_BARREL:
			message = "blew up";
			break;
		case MOD_EXIT:
			message = "found a way out";
			break;
		case MOD_TARGET_LASER:
			message = "saw the light";
			break;
		case MOD_TARGET_BLASTER:
			message = "got blasted";
			break;
		case MOD_BOMB:
		case MOD_SPLASH:
		case MOD_TRIGGER_HURT:
			message = "was in the wrong place";
			break;
		}
		if (attacker == self)
		{
			switch (mod)
			{
			case MOD_HELD_GRENADE:
				message = "tried to put the pin back in";
				break;
			case MOD_HG_SPLASH:
			case MOD_G_SPLASH:
				if (IsNeutral(self))
					message = "forgot to take cover";
				else if (IsFemale(self))
					message = "forgot to take cover";
				else
					message = "forgot to take cover";
				break;
			case MOD_R_SPLASH:
				if (IsNeutral(self))
					message = "blew itself up";
				else if (IsFemale(self))
					message = "blew herself up";
				else
					message = "blew himself up";
				break;
			case MOD_BFG_BLAST:
				message = "should have used a smaller gun";
				break;
			default:
				if (IsNeutral(self) && self->client->bleeding == 0)//TROND lagt til self->client->bleeding == 0
					message = "killed itself";
				else if (IsFemale(self) && self->client->bleeding == 0)//TROND lagt til self->client->bleeding == 0
					message = "killed herself";
				else if (self->client->bleeding == 0)//TROND lagt til self->client->bleeding == 0
					message = "killed himself";
				//TROND
				else if (self->client->bleeding == 1)
					message = "bled to death cuz of the wounds he caused himself";
				//TROND slutt
				break;
			}
		}
		if (message)
		{
			gi.bprintf (PRINT_MEDIUM, "%s %s.\n", self->client->pers.netname, message);
			if (deathmatch->value)
				self->client->resp.score--;
			self->enemy = NULL;
			return;
		}

		self->enemy = attacker;
		if (attacker && attacker->client)
		{
			switch (mod)
			{
			case MOD_BLASTER:
				message = "was humiliated by";
				break;
			case MOD_SHOTGUN:
				message = "looks like a Swiss cheese after meeting";
				break;
			case MOD_SSHOTGUN:
				message = "was blown away by";
				message2 = "'s super shotgun";
				break;
			case MOD_MACHINEGUN:
				message = "unfortunately met";
				message2 = " carrying his trusty automatic";
				break;
			case MOD_AK47:
				message = "tried to defend himself from";
				message2 = "'s AK47";
				break;
			case MOD_GLOCK:
				message = "was killed by";
				message2 = "'s silenced Glock";
				break;
			case MOD_BUSH_HEAD:
				message = "lost his head to";
				message2 = "'s sharp Bush Knife";
				break;
			case MOD_BUSH_CHEST:
				message = "is left in pieces by";
				message2 = "'s sharp Bush Knife";
				break;
			case MOD_BUSH_LEG:
				message = "`s legs are half as long as they used to be, cuz of";
				message2 = "'s sharp Bush Knife";
				break;
			case MOD_BLEEDING:
				message = "bled to death thanks to the wounds";
				message2 = " caused";
				break;
			case MOD_CHAINGUN:
				message = "was cut in half by";
				message2 = "'s chaingun";
				break;
			case MOD_GRENADE:
				message = "was popped by";
				message2 = "'s grenade";
				break;
			case MOD_G_SPLASH:
				message = "was shredded by";
				message2 = "'s shrapnel";
				break;
			case MOD_ROCKET:
				message = "ate";
				message2 = "'s rocket";
				break;
			case MOD_R_SPLASH:
				message = "almost dodged";
				message2 = "'s rocket";
				break;
			case MOD_HYPERBLASTER:
				message = "was melted by";
				message2 = "'s hyperblaster";
				break;
			case MOD_RAILGUN:
				message = "was sniped by";
				break;
			case MOD_BFG_LASER:
				message = "saw the pretty lights from";
				message2 = "'s BFG";
				break;
			case MOD_BFG_BLAST:
				message = "was disintegrated by";
				message2 = "'s BFG blast";
				break;
			case MOD_BFG_EFFECT:
				message = "couldn't hide from";
				message2 = "'s BFG";
				break;
			case MOD_HANDGRENADE:
				message = "happened to be too close";
				message2 = "'s explosive";
				break;
			case MOD_HG_SPLASH:
				message = "didn't see";
				message2 = "'s explosive";
				break;
			case MOD_HELD_GRENADE:
				message = "feels";
				message2 = "'s pain";
				break;
			}
			if (message)
			{
				gi.bprintf (PRINT_MEDIUM,"%s %s %s%s\n", self->client->pers.netname, message, attacker->client->pers.netname, message2);
				if (deathmatch->value)
				{
					if (ff)
						attacker->client->resp.score--;
					else
					{
						if (!ctf->value)
						{
							//attacker->client->resp.score++;
							attacker->client->kills += 1;//TROND linje staying alive...
							//STAYING ALIVE
							if (attacker->client->kills < 4)
							{
								attacker->client->resp.score += 1;
								gi.cprintf (attacker, PRINT_HIGH, "You have %i kills in a row\n", attacker->client->kills);
							}
							else if (attacker->client->kills >= 4
								&& attacker->client->kills < 8)
							{
								gi.bprintf (PRINT_HIGH, "%s has %i kills in a row, he now gets 2 frags per kill\n", attacker->client->pers.netname, attacker->client->kills);
								attacker->client->resp.score += 2;
							}
							else if (attacker->client->kills >= 8
								&& attacker->client->kills < 12)
							{
								gi.bprintf (PRINT_HIGH, "%s has %i kills in a row, he now gets 4 frags per kill\n", attacker->client->pers.netname, attacker->client->kills);
								attacker->client->resp.score += 4;
							}
							else if (attacker->client->kills >= 12
								&& attacker->client->kills < 16)
							{
								gi.bprintf (PRINT_HIGH, "%s has %i kills in a row, he now gets 6 frags per kill\n", attacker->client->pers.netname, attacker->client->kills);
								attacker->client->resp.score += 6;
							}
							else if (attacker->client->kills >= 16)
							{
								gi.bprintf (PRINT_HIGH, "%s has %i kills in a row, he now gets 8 frags per kill\n", attacker->client->pers.netname, attacker->client->kills);
								attacker->client->resp.score += 8;
							}
						}
						else
						{
							if (attacker->client
								&& (attacker != self)
								&& (attacker->client->resp.ctf_team != self->client->resp.ctf_team)
								&& attacker->client->resp.ctf_team != CTF_NOTEAM
								&& ctf->value)
							{
								if (attacker->client->resp.ctf_team == CTF_TEAM1)
									ctfgame.team1++;
								else
									ctfgame.team2++;
							}
						}
					}
				}
				return;
			}
		}
	}

	gi.bprintf (PRINT_MEDIUM,"%s died.\n", self->client->pers.netname);
	if (deathmatch->value)
		self->client->resp.score--;
}


void Touch_Item (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf);

void TossClientWeapon (edict_t *self)
{
	//TROND
	//KASTE ALLE VÅPEN
//	int			idx;
	//TROND slutt
	gitem_t		*item;
	edict_t		*drop;
	qboolean	quad;
	float		spread;

//TROND 14/3 tatt vekk
	/*
	if (!deathmatch->value)
		return;
//TROND slutt*/

	item = self->client->pers.weapon;
	if (! self->client->pers.inventory[self->client->ammo_index] )
		item = NULL;
	//TROND
/*	if (item && (strcmp (item->pickup_name,"Blaster") == 0))// "Blaster") == 0))
	//TROND slutt
		item = NULL;*/

	if (!((int)(dmflags->value) & DF_QUAD_DROP))
		quad = false;
	else
		quad = (self->client->quad_framenum > (level.framenum + 10));

	if (item && quad)
		spread = 22.5;
	else
		spread = 0.0;
/*TROND bugfix med tossing av våpen
	if (item)
	{
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
		drop->spawnflags = DROPPED_PLAYER_ITEM;
	}
	//TROND slutt */

/*	//TROND
	//KASTE ALLE VÅPEN
	for(idx=WEAP_SHOTGUN; idx<=WEAP_BFG; idx++)//TROND ta med BLASTER i stedet for SHOTGUN om 1911 skal droppes
	{
		if(!HasWeaponInInventory(self, idx)) continue;
		spread += rand()*10;
		self->client->v_angle[YAW] -= spread;
		drop=Drop_Item(self, WeaponItem(idx));
		self->client->v_angle[YAW] += spread;
		drop->spawnflags=DROPPED_PLAYER_ITEM;
	}

	if (quad)
	{
		self->client->v_angle[YAW] += spread;
		drop = Drop_Item (self, FindItemByClassname ("item_quad"));
		self->client->v_angle[YAW] -= spread;
		drop->spawnflags |= DROPPED_PLAYER_ITEM;

		drop->touch = Touch_Item;
		drop->nextthink = level.time + (self->client->quad_framenum - level.framenum) * FRAMETIME;
		drop->think = G_FreeEdict;
	}*/

	//TROND
	//TOSS ITEM NÅR DØD
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("IR goggles"))])
	{
		spread += rand()*10;
		item = FindItem("IR Goggles");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))])
	{
		spread += rand()*10;
		item = FindItem("Bullet Proof Vest");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("Helmet"))])
	{
		spread += rand()*10;
		item = FindItem("Helmet");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("C4 Detpack"))])
	{
		spread += rand()*10;
		item = FindItem("C4 Detpack");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("Mine"))])
	{
		spread += rand()*10;
		item = FindItem("mine");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("detonator"))])
	{
		spread += rand()*10;
		item = FindItem("detonator");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("medkit"))])
	{
		spread += rand()*10;
		item = FindItem("medkit");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("scuba gear"))])
	{
		spread += rand()*10;
		item = FindItem("scuba gear");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("ak 47"))])
	{
		spread += rand()*10;
		item = FindItem("ak 47");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("ak47rounds"))];
//		drop->spawnflags = DROPPED_PLAYER_ITEM;
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("glock"))])
	{
		spread += rand()*10;
		item = FindItem("glock");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))];
		//TROND lagt til 9/4 sluttstykke
		if (drop->ammo == 0)
			drop->s.frame = 1;
		//TROND slutt
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("casull"))])
	{
		spread += rand()*10;
		item = FindItem("casull");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))];
	}
	//TROND BERETTA 27/3
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("beretta"))])
	{
		spread += rand()*10;
		item = FindItem("beretta");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))];
		//TROND lagt til 9/4 sluttstykke
		if (drop->ammo == 0)
			drop->s.frame = 1;
		//TROND slutt
	}
	//TROND slutt
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("uzi"))])
	{
		spread += rand()*10;
		item = FindItem("uzi");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("uzirounds"))];
	}
	//MP5	27/3
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("mp5"))])
	{
		spread += rand()*10;
		item = FindItem("mp5");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))];
	}
	//M60	
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("m60"))])
	{
		spread += rand()*10;
		item = FindItem("m60");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))];
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("barrett"))])
	{
		spread += rand()*10;
		item = FindItem("barrett");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))];
	}
	//MSG90	3/4
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("msg90"))])
	{
		spread += rand()*10;
		item = FindItem("msg90");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))];
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("mariner"))])
	{
		spread += rand()*10;
		item = FindItem("mariner");
		self->client->v_angle[YAW] -= spread;
		drop = Drop_Item(self, item);
		self->client->v_angle[YAW] += spread;
		drop->ammo = self->client->pers.inventory[ITEM_INDEX(FindItem("marinerrounds"))];
	}
	if (self->client->pers.inventory[ITEM_INDEX(FindItem("head light"))])
	{
		spread += rand()*10;
		item = FindItem("head light");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}

//	gi.cprintf (self, PRINT_HIGH, "%i pin pulled\n", self->client->pin_pulled);
	if (self->client->pin_pulled == 1)
	{
		vec3_t	forward;
		self->client->pin_pulled = 0;
		fire_grenade2 (self, self->s.origin, forward, 400, 0, 1, 480, false);
	}
	else if (self->client->pers.inventory[ITEM_INDEX(FindItem("grenades"))])
	{
		spread += rand()*10;
		item = FindItem("grenades");
		self->client->v_angle[YAW] -= spread;
		Drop_Item (self, item);
		self->client->v_angle[YAW] += spread;
	}
	//TROND slutt
}


/*
==================
LookAtKiller
==================
*/
void LookAtKiller (edict_t *self, edict_t *inflictor, edict_t *attacker)
{
	vec3_t		dir;

	if (attacker && attacker != world && attacker != self)
	{
		VectorSubtract (attacker->s.origin, self->s.origin, dir);
	}
	else if (inflictor && inflictor != world && inflictor != self)
	{
		VectorSubtract (inflictor->s.origin, self->s.origin, dir);
	}
	else
	{
		self->client->killer_yaw = self->s.angles[YAW];
		return;
	}

	if (dir[0])
		self->client->killer_yaw = 180/M_PI*atan2(dir[1], dir[0]);
	else {
		self->client->killer_yaw = 0;
		if (dir[1] > 0)
			self->client->killer_yaw = 90;
		else if (dir[1] < 0)
			self->client->killer_yaw = -90;
	}
	if (self->client->killer_yaw < 0)
		self->client->killer_yaw += 360;


}

/*
==================
player_die
==================
*/
void CheckLMSRules ( void );//TROND 25/4

void player_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
	int		n;

	VectorClear (self->avelocity);

	self->takedamage = DAMAGE_NO;//TROND var YES;
	self->movetype = MOVETYPE_TOSS;

	self->s.modelindex2 = 0;	// remove linked weapon model
	self->s.modelindex3 = 0;	//TROND
	self->s.modelindex4 = 0;	//TROND

	if (self->health < -99)
		self->health = -99;

	//TROND
	if (self->client->fl_on == 1)
	{
		self->client->fl_on = 0;
		SP_FlashLight(self);
	}
	if (self->client->ls_on == 1)
	{
		self->client->ls_on = 0;
		SP_LaserSight(self);
	}

	//TROND 24/4
	if (lms->value)
	{
		self->client->resp.lms_dead = 1;
/*		CheckLMSRules ();
		if (lms_dead_players == 1)
		{
			attacker->client->resp.lms_dead = 1;
			attacker->client->resp.score += 10;

			//TROND 30/4
			TossClientWeapon (attacker);
			attacker->client->ps.gunindex = 0;
			attacker->client->weaponstate = WEAPON_HOLSTERED;

			if (attacker->client->fl_on == 1)
			{
				attacker->client->fl_on = 0;
				SP_FlashLight(attacker);
			}
			if (attacker->client->ls_on == 1)
			{
				attacker->client->ls_on = 0;
				SP_LaserSight(attacker);
			}

			gi.bprintf (PRINT_HIGH, "%s is the Last Man Standing\n", attacker->client->pers.netname);
		}
		else
			gi.bprintf (PRINT_CHAT, "%d\n", lms_dead_players);*/
	}
	
	//TROND slutt

	self->s.angles[0] = 0;
	self->s.angles[2] = 0;

	self->s.sound = 0;
	self->client->weapon_sound = 0;

	self->maxs[2] = -8;

	self->solid = SOLID_NOT;//TROND var utkommentert
	self->svflags |= SVF_DEADMONSTER;

	if (!self->deadflag)
	{
		if (ctf->value)
		{
			self->client->respawn_time = level.time + 3.0;
//			gi.cprintf (self, PRINT_HIGH, "You will remain dead for 20 secs...\n");
		}
		else
			self->client->respawn_time = level.time + 3.0;
		//TROND slutt
//		LookAtKiller (self, inflictor, attacker);
		self->client->ps.pmove.pm_type = PM_DEAD;

//TROND tatt vekk		10/3
//		ClientObituary (self, inflictor, attacker);
		Decide_Score (self, attacker);

		//TROND slutt
		//TROND
		if (attacker->client
			&& (attacker != self)
			&& (attacker->client->resp.ctf_team == self->client->resp.ctf_team)
			&& attacker->client->resp.ctf_team != CTF_NOTEAM
			&& ctf->value)
		{
			gi.bprintf (PRINT_HIGH, "%s is a traitor, he has killed a teammate\n", attacker->client->pers.netname);
//			attacker->client->resp.score -= 5;
			if (self->client->resp.ctf_team == CTF_TEAM1)
				ctfgame.team1 -= 3;
			if (self->client->resp.ctf_team == CTF_TEAM2)
				ctfgame.team2 -= 3;
			attacker->client->kills = 0;
			//gi.cprintf (attacker, PRINT_HIGH, "Your kills in a row has been set back to zero\n");
		}
	
		if (self->client->resp.ctf_team == CTF_TEAM1)
		{
			if (attacker != self				
				&& attacker->client
				&& attacker->client->resp.ctf_team == CTF_TEAM2)
				gi.bprintf (PRINT_HIGH, "The Terrorists couldn`t cover %s`s ass from %s`s nasty attack...\n", self->client->pers.netname, attacker->client->pers.netname);
//			ctfgame.team1--;
		}
		if (self->client->resp.ctf_team == CTF_TEAM2)
		{
			if (attacker != self
				&& attacker->client
				&& attacker->client->resp.ctf_team == CTF_TEAM1)
				gi.bprintf (PRINT_HIGH, "The Force couldn`t cover %s`s ass from %s`s nasty attack...\n", self->client->pers.netname, attacker->client->pers.netname);
//			ctfgame.team2--;
		}
/*		if (self->enemy
			&& self->enemy->client)
			gi.bprintf (PRINT_HIGH, "%s`s enemy is %s\n", self->client->pers.netname, self->enemy->client->pers.netname);//TROND DEBUG MSG
*/		
		//TROND tatt vekk 13/5
		/*
		if (!ctf->value)//TROND 29/3
			self->client->resp.score -= 1;
			*/

		//TROND ATL 9/4
		if (self->client->t_leader == 1
			&& self->client->resp.ctf_team == CTF_TEAM1
			&& leader->value)
		{
			terror_l = 0;
//			self->client->t_leader = 0;//TROND 10/4 skummelt...
			gi.bprintf (PRINT_HIGH, "**The terrorist leader has been assassinated**\n");
			ctfgame.team2 += 15;
		}
		if (self->client->s_leader == 1
			&& self->client->resp.ctf_team == CTF_TEAM2
			&& leader->value)
		{
			swat_l = 0;
//			self->client->s_leader = 0;//TROND 10/4 skummelt
			gi.bprintf (PRINT_HIGH, "**The SWAT leader has been assassinated**\n");
			ctfgame.team1 += 15;
		}
		//TROND slutt
//ZOID	
//		CTFFragBonuses(self, inflictor, attacker);//TROND tatt vekk
//ZOID	
		TossClientWeapon (self);
//		gi.bprintf (PRINT_HIGH, "DEBUG: tossed client weapons/items\n");//TROND 11/3
//ZOID
//		CTFPlayerResetGrapple(self);//TROND 10/3 tatt vekk
		CTFDeadDropFlag(self);
//		CTFDeadDropTech(self);//TROND 10/3 tatt vekk
//ZOID
//		if (deathmatch->value)//TROND 10/3 tatt vekk
//			Cmd_Help_f (self);		// show scores//TROND 10/3 tatt vekk

		// clear inventory
		// this is kind of ugly, but it's how we want to handle keys in coop
		for (n = 0; n < game.num_items; n++)
		{
			if (coop->value && itemlist[n].flags & IT_KEY)
				self->client->resp.coop_respawn.inventory[n] = self->client->pers.inventory[n];
			self->client->pers.inventory[n] = 0;
		}
	}

//TROND tatt vekk   10/3
	/*
	// remove powerups
	self->client->quad_framenum = 0;
	self->client->invincible_framenum = 0;
	self->client->breather_framenum = 0;
	self->client->enviro_framenum = 0;
	self->flags &= ~FL_POWER_ARMOR;
*/
//TROND slutt

	if (self->health < -700)//inflictor->classname == "mine")//TROND var -40, satt opp pga gibbing
	{	// gib
		gi.sound (self, CHAN_BODY, gi.soundindex ("misc/udeath.wav"), 1, ATTN_NORM, 0);
		for (n= 0; n < 4; n++)
			ThrowGib (self, "models/objects/gibs/sm_meat/tris.md2", 0, GIB_ORGANIC);
		ThrowClientHead (self, 0);
//ZOID
		self->client->anim_priority = ANIM_DEATH;
		self->client->anim_end = 0;
//ZOID

		self->takedamage = DAMAGE_NO;
	}
	else
	{	// normal death
		if (!self->deadflag)
		{
//			static int i;//TROND 10/3 tatt vekk

//			i = (i+1)%3;//TROND 10/3 tatt vekk
			// start a death animation
			self->client->anim_priority = ANIM_DEATH;
			if (self->client->ps.pmove.pm_flags & PMF_DUCKED)
			{
				self->s.frame = FRAME_crdeath1-1;
				self->client->anim_end = FRAME_crdeath5;
				self->client->dead_frame = 1;//TROND pga død gubbe
			}
//TROND PAIN SKIN TILLEGG DEAD FRAMES
			if (self->client->die_frame == 1
				&& !(self->client->ps.pmove.pm_flags & PMF_DUCKED))
			{
				self->s.frame = FRAME_death301-1;
				self->client->anim_end = FRAME_death308;
				self->client->dead_frame = 4;//TROND pga død gubbe
			}
			else if (self->client->die_frame == 2
				&& !(self->client->ps.pmove.pm_flags & PMF_DUCKED))
			{
				self->s.frame = FRAME_death201-1;
				self->client->anim_end = FRAME_death206;
				self->client->dead_frame = 3;//TROND pga død gubbe
			}
			else if (self->client->die_frame == 3
				&& !(self->client->ps.pmove.pm_flags & PMF_DUCKED))
			{
				self->s.frame = FRAME_death101-1;
				self->client->anim_end = FRAME_death106;
				self->client->dead_frame = 2;//TROND pga død gubbe
			}
			else
			{
				self->s.frame = FRAME_death201-1;
				self->client->anim_end = FRAME_death206;
				self->client->dead_frame = 3;//TROND pga død gubbe
			}
			//TROND slutt
			/*
			else switch (i)
			{
			case 0:
				self->s.frame = FRAME_death101-1;
				self->client->anim_end = FRAME_death106;
				self->client->dead_frame = 2;//TROND pga død gubbe
				break;
			case 1:
				self->s.frame = FRAME_death201-1;
				self->client->anim_end = FRAME_death206;
				self->client->dead_frame = 3;//TROND pga død gubbe
				break;
			case 2:
				self->s.frame = FRAME_death301-1;
				self->client->anim_end = FRAME_death308;
				self->client->dead_frame = 4;//TROND pga død gubbe
				break;
			}
			*/
//TROND 10/3 tatt vekk
//TROND 12/3 tatt inn igjen
			gi.sound (self, CHAN_VOICE, gi.soundindex(va("*death%i.wav", (rand()%4)+1)), 1, ATTN_NORM, 0);
		}
	}

	self->deadflag = DEAD_DEAD;

	gi.linkentity (self);

//	gi.bprintf (PRINT_HIGH, "DEBUG: player_die() done\n");//TROND 10/3
}
/*
void player_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
	int		n;

	VectorClear (self->avelocity);

	self->takedamage = DAMAGE_YES;
	self->movetype = MOVETYPE_TOSS;

	self->s.modelindex2 = 0;	// remove linked weapon model
//ZOID
	self->s.modelindex3 = 0;	// remove linked ctf flag
//ZOID

	//TROND
	//Visible Items
	self->s.modelindex4 = 0;	// tar vekk linka item model
	//TROND slutt

	self->s.angles[0] = 0;
	self->s.angles[2] = 0;

	self->s.sound = 0;
	self->client->weapon_sound = 0;

	self->maxs[2] = -8;

//	self->solid = SOLID_NOT;
	self->svflags |= SVF_DEADMONSTER;

	if (!self->deadflag)
	{
		//TROND
		//NÅ RESPAWNER SPILLEREN ETTER 30 sek
		gi.centerprintf (self, "You`re dead.\n To try to add the stragic feel\n I want this mod to have, you`re\n not allowed to respawn within\n the next 30 secs...\n\nUse your time to figure out what you\n did wrong.\n");
		self->client->respawn_time = level.time + 0.1;// + 30.0;
		//TROND slutt
		LookAtKiller (self, inflictor, attacker);
		self->client->ps.pmove.pm_type = PM_DEAD;
		ClientObituary (self, inflictor, attacker);
//ZOID
		CTFFragBonuses(self, inflictor, attacker);
//ZOID
		TossClientWeapon (self);
//ZOID
		CTFPlayerResetGrapple(self);
		CTFDeadDropFlag(self);
		CTFDeadDropTech(self);
//ZOID
		if (deathmatch->value)
			Cmd_Help_f (self);		// show scores

		// clear inventory
		// this is kind of ugly, but it's how we want to handle keys in coop
		for (n = 0; n < game.num_items; n++)
		{
			if (coop->value && itemlist[n].flags & IT_KEY)
				self->client->resp.coop_respawn.inventory[n] = self->client->pers.inventory[n];
			self->client->pers.inventory[n] = 0;
		}
	}

	// remove powerups
	self->client->quad_framenum = 0;
	self->client->invincible_framenum = 0;
	self->client->breather_framenum = 0;
	self->client->enviro_framenum = 0;
	self->flags &= ~FL_POWER_ARMOR;

	//TROND
	//HINDRER GIBBING
	if (self->health < -40)
	{   //gib
		gi.sound (self, CHAN_BODY, gi.soundindex ("misc/udeath.wav"), 1, ATTN_NORM, 0);
		for (n= 0; n < 4; n++)
			ThrowGib (self, "models/objects/gibs/sm_meat/tris.md2", damage, GIB_ORGANIC);
		ThrowClientHead (self, damage);
//ZOID
		self->client->anim_priority = ANIM_DEATH;
		self->client->anim_end = 0;
//ZOID
		//TROND slutt
		self->takedamage = DAMAGE_NO;
	}
	
	else
	{	// normal death
		if (!self->deadflag)
		{
			static int i;

			i = (i+1)%3;
			// start a death animation
			self->client->anim_priority = ANIM_DEATH;
			if (self->client->ps.pmove.pm_flags & PMF_DUCKED)
			{
				self->s.frame = FRAME_crdeath1-1;
				self->client->anim_end = FRAME_crdeath5;
			}
			else switch (i)
			{
			case 0:
				self->s.frame = FRAME_death101-1;
				self->client->anim_end = FRAME_death106;
				break;
			case 1:
				self->s.frame = FRAME_death201-1;
				self->client->anim_end = FRAME_death206;
				break;
			case 2:
				self->s.frame = FRAME_death301-1;
				self->client->anim_end = FRAME_death308;
				break;
			}
			gi.sound (self, CHAN_VOICE, gi.soundindex(va("*death%i.wav", (rand()%4)+1)), 1, ATTN_NORM, 0);
		}
	}

	self->deadflag = DEAD_DEAD;

	gi.linkentity (self);
}
*/
//=======================================================================

/*
==============
InitClientPersistant

This is only called when the game first initializes in single player,
but is called after each death and level change in deathmatch
==============
*/
void InitClientPersistant (gclient_t *client)
{
	gitem_t		*item;

	memset (&client->pers, 0, sizeof(client->pers));

	//TROND
	//	7/3 ta vekk GLOCK og 1911 pga bug test
	//	8/3	tatt inn igjen
	item = FindItem("1911");//("Blaster");
//	item = FindItem("uzi");//("Blaster");
	//TROND slutt

	client->pers.selected_item = ITEM_INDEX(item);
	client->pers.inventory[client->pers.selected_item] = 1;

	client->pers.weapon = item;
//ZOID
	client->pers.lastweapon = item;
//ZOID

//ZOID
	//TROND
	//TAR VEKK GRAPPLE, DEN KRASJER SPILLET
	//item = FindItem("Grapple");
	//client->pers.inventory[ITEM_INDEX(item)] = 1;

	//LEGGER TIL BUSH KNIFE
	item = FindItem("Bush Knife");
	client->pers.inventory[ITEM_INDEX(item)] = 1;
	//	15/3 lagt til ammo og vekt her
	item = FindItem("1911clip");
	client->pers.inventory[ITEM_INDEX(item)] = 2;
	item = FindItem("1911rounds");
	client->pers.inventory[ITEM_INDEX(item)] = 8;

	if (!deathmatch->value)
	{
/*		if (skill->value)
		{
			item = FindItem("glock");
			client->pers.inventory[ITEM_INDEX(item)] = 1;
			item = FindItem("glockclip");
			client->pers.inventory[ITEM_INDEX(item)] = 1;
			item = FindItem("glockrounds");
			client->pers.inventory[ITEM_INDEX(item)] = 17;
			item = FindItem("weight");
			client->pers.inventory[ITEM_INDEX(item)] = 13;
		}
		else
		{
			item = FindItem("uzi");
			client->pers.inventory[ITEM_INDEX(item)] = 1;
			item = FindItem("uziclip");
			client->pers.inventory[ITEM_INDEX(item)] = 1;
			item = FindItem("uzirounds");
			client->pers.inventory[ITEM_INDEX(item)] = 30;
			item = FindItem("helmet");
			client->pers.inventory[ITEM_INDEX(item)] = 1;
			item = FindItem("weight");
			client->pers.inventory[ITEM_INDEX(item)] = 8;
		}*/
		item = FindItem("weight");
		client->pers.inventory[ITEM_INDEX(item)] = 20;
	}
	//TROND slutt
//ZOID

	//TROND
	//MEKKA PÅ MAX AMMO OG LIV
	client->pers.health				= 100;
	client->pers.max_health			= 100;

	client->pers.max_UZIclip		= 200;//UZI magasin (var bullets)
	client->pers.max_shells			= 1000;//HAGLE magasin
	client->pers.max_rockets		= 100;
	client->pers.max_grenades		= 100;
	client->pers.max_cells			= 200;//1911 magasin
	client->pers.max_slugs			= 100;//RIFLE magasin
	client->pers.max_1911rounds		= 8;//1911 kuler i magasinet
	client->pers.max_9mm			= 30;//UZI kuler i magasinet
	client->pers.max_50cal			= 10;//RIFLE kuler i magasinet
	client->pers.max_MARINERrounds	= 9;//HAGLE kuler i magasinet
	client->pers.max_ak47rounds		= 40;//AK47 kuler i magasinet
	client->pers.max_akclip			= 100;//AK47 magasin
	client->pers.max_glockrounds	= 17;//GLOCK kuler i magasinet
	client->pers.max_glockclip		= 100;//GLOCK magasin
	client->pers.max_casullrounds	= 5;//CASULL kuler i magasinet
	//TROND slutt

	client->pers.connected = true;
}


void InitClientResp (gclient_t *client)
{
//ZOID
	int ctf_team = client->resp.ctf_team;
//ZOID

	memset (&client->resp, 0, sizeof(client->resp));

//ZOID
	client->resp.ctf_team = ctf_team;
//ZOID

	client->resp.enterframe = level.framenum;
	client->resp.coop_respawn = client->pers;

//ZOID
	if (ctf->value && client->resp.ctf_team < CTF_TEAM1)
		CTFAssignTeam(client);
//ZOID
}

/*
==================
SaveClientData

Some information that should be persistant, like health,
is still stored in the edict structure, so it needs to
be mirrored out to the client structure before all the
edicts are wiped.
==================
*/
void SaveClientData (void)
{
	int		i;
	edict_t	*ent;

	for (i=0 ; i<game.maxclients ; i++)
	{
		ent = &g_edicts[1+i];
		if (!ent->inuse)
			continue;
		game.clients[i].pers.health = ent->health;
		game.clients[i].pers.max_health = ent->max_health;
		game.clients[i].pers.savedFlags = (ent->flags & (FL_GODMODE|FL_NOTARGET|FL_POWER_ARMOR));
		if (coop->value)
			game.clients[i].pers.score = ent->client->resp.score;
	}
}

void FetchClientEntData (edict_t *ent)
{
	ent->health = ent->client->pers.health;
	ent->max_health = ent->client->pers.max_health;
	ent->flags |= ent->client->pers.savedFlags;
	if (coop->value)
		ent->client->resp.score = ent->client->pers.score;
}



/*
=======================================================================

  SelectSpawnPoint

=======================================================================
*/

/*
================
PlayersRangeFromSpot

Returns the distance to the nearest player from the given spot
================
*/
float	PlayersRangeFromSpot (edict_t *spot)
{
	edict_t	*player;
	float	bestplayerdistance;
	vec3_t	v;
	int		n;
	float	playerdistance;


	bestplayerdistance = 9999999;

	for (n = 1; n <= maxclients->value; n++)
	{
		player = &g_edicts[n];

		if (!player->inuse)
			continue;

		if (player->health <= 0)
			continue;

		VectorSubtract (spot->s.origin, player->s.origin, v);
		playerdistance = VectorLength (v);

		if (playerdistance < bestplayerdistance)
			bestplayerdistance = playerdistance;
	}

	return bestplayerdistance;
}

/*
================
SelectRandomDeathmatchSpawnPoint

go to a random point, but NOT the two points closest
to other players
================
*/
edict_t *SelectRandomDeathmatchSpawnPoint (void)
{
	edict_t	*spot, *spot1, *spot2;
	int		count = 0;
	int		selection;
	float	range, range1, range2;

	spot = NULL;
	range1 = range2 = 99999;
	spot1 = spot2 = NULL;

	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL)
	{
		count++;
		range = PlayersRangeFromSpot(spot);
		if (range < range1)
		{
			range1 = range;
			spot1 = spot;
		}
		else if (range < range2)
		{
			range2 = range;
			spot2 = spot;
		}
	}

	if (!count)
		return NULL;

	if (count <= 2)
	{
		spot1 = spot2 = NULL;
	}
	else
		count -= 2;

	selection = rand() % count;

	spot = NULL;
	do
	{
		spot = G_Find (spot, FOFS(classname), "info_player_deathmatch");
		if (spot == spot1 || spot == spot2)
			selection++;
	} while(selection--);

	return spot;
}

/*
================
SelectFarthestDeathmatchSpawnPoint

================
*/
edict_t *SelectFarthestDeathmatchSpawnPoint (void)
{
	edict_t	*bestspot;
	float	bestdistance, bestplayerdistance;
	edict_t	*spot;


	spot = NULL;
	bestspot = NULL;
	bestdistance = 0;
	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL)
	{
		bestplayerdistance = PlayersRangeFromSpot (spot);

		if (bestplayerdistance > bestdistance)
		{
			bestspot = spot;
			bestdistance = bestplayerdistance;
		}
	}

	if (bestspot)
	{
		return bestspot;
	}

	// if there is a player just spawned on each and every start spot
	// we have no choice to turn one into a telefrag meltdown
	spot = G_Find (NULL, FOFS(classname), "info_player_deathmatch");

	return spot;
}

edict_t *SelectDeathmatchSpawnPoint (void)
{
	if ( (int)(dmflags->value) & DF_SPAWN_FARTHEST)
		return SelectFarthestDeathmatchSpawnPoint ();
	else
		return SelectRandomDeathmatchSpawnPoint ();
}


edict_t *SelectCoopSpawnPoint (edict_t *ent)
{
	int		index;
	edict_t	*spot = NULL;
	char	*target;

	index = ent->client - game.clients;

	// player 0 starts in normal player spawn point
	if (!index)
		return NULL;

	spot = NULL;

	// assume there are four coop spots at each spawnpoint
	while (1)
	{
		spot = G_Find (spot, FOFS(classname), "info_player_coop");
		if (!spot)
			return NULL;	// we didn't have enough...

		target = spot->targetname;
		if (!target)
			target = "";
		if ( Q_stricmp(game.spawnpoint, target) == 0 )
		{	// this is a coop spawn point for one of the clients here
			index--;
			if (!index)
				return spot;		// this is it
		}
	}


	return spot;
}


/*
===========
SelectSpawnPoint

Chooses a player start, deathmatch start, coop start, etc
============
*/
void	SelectSpawnPoint (edict_t *ent, vec3_t origin, vec3_t angles)
{
	edict_t	*spot = NULL;

	if (deathmatch->value)
//ZOID
		if (ctf->value)
			spot = SelectCTFSpawnPoint(ent);
		else
//ZOID
			spot = SelectRandomDeathmatchSpawnPoint ();//TROND var SelectDeathmatchSpawnPoint
	else if (coop->value)
		spot = SelectCoopSpawnPoint (ent);

	// find a single player start spot
	if (!spot)
	{
		while ((spot = G_Find (spot, FOFS(classname), "info_player_start")) != NULL)
		{
			if (!game.spawnpoint[0] && !spot->targetname)
				break;

			if (!game.spawnpoint[0] || !spot->targetname)
				continue;

			if (Q_stricmp(game.spawnpoint, spot->targetname) == 0)
				break;
		}

		if (!spot)
		{
			if (!game.spawnpoint[0])
			{	// there wasn't a spawnpoint without a target, so use any
				spot = G_Find (spot, FOFS(classname), "info_player_start");
			}
			if (!spot)
				gi.error ("Couldn't find spawn point %s\n", game.spawnpoint);
		}
	}

	VectorCopy (spot->s.origin, origin);
	origin[2] += 9;
	VectorCopy (spot->s.angles, angles);
}

//======================================================================


void InitBodyQue (void)
{
	int		i;
	edict_t	*ent;

	level.body_que = 0;
	for (i=0; i<BODY_QUEUE_SIZE ; i++)
	{
		ent = G_Spawn();
		ent->classname = "bodyque";
	}
}

void body_die (edict_t *self, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
	int	n;

	if (self->health < -999999)//TROND var -40
	{
		gi.sound (self, CHAN_BODY, gi.soundindex ("misc/udeath.wav"), 1, ATTN_NORM, 0);
		for (n= 0; n < 4; n++)
			ThrowGib (self, "models/objects/gibs/sm_meat/tris.md2", damage, GIB_ORGANIC);
		self->s.origin[2] -= 48;
		ThrowClientHead (self, damage);
		self->takedamage = DAMAGE_NO;
	}
}

void CopyToBodyQue (edict_t *ent)
{
	edict_t		*body;

	// grab a body que and cycle to the next one
	body = &g_edicts[(int)maxclients->value + level.body_que + 1];
	level.body_que = (level.body_que + 1) % BODY_QUEUE_SIZE;

	// FIXME: send an effect on the removed body

	gi.unlinkentity (ent);

	gi.unlinkentity (body);
	body->s = ent->s;
	body->s.number = body - g_edicts;

	body->svflags = ent->svflags;
	VectorCopy (ent->mins, body->mins);
	VectorCopy (ent->maxs, body->maxs);
	VectorCopy (ent->absmin, body->absmin);
	VectorCopy (ent->absmax, body->absmax);
	VectorCopy (ent->size, body->size);
	body->solid = ent->solid;
	body->clipmask = ent->clipmask;
	body->owner = ent->owner;
	body->movetype = ent->movetype;

	body->die = body_die;
	//TROND
	body->s.solid = SOLID_NOT;
	//TROND slutt
	body->takedamage = DAMAGE_NO;//TROND var YES

	gi.linkentity (body);
}

//TROND respawn funksjon fjerna... se lenger ned etter mekka versjon
/*
void respawn (edict_t *self)
{
	if (deathmatch->value || coop->value)
	{
		// spectator's don't leave bodies
//		if (self->movetype != MOVETYPE_NOCLIP)//TROND tatt vekk
//			CopyToBodyQue (self);			  //TROND tatt vekk
		self->svflags &= ~SVF_NOCLIENT;
		PutClientInServer (self);
	
		// add a teleportation effect
		self->s.event = EV_PLAYER_TELEPORT;

		// hold in place briefly
		self->client->ps.pmove.pm_flags = PMF_TIME_TELEPORT;
		self->client->ps.pmove.pm_time = 14;

		self->client->respawn_time = level.time;

		return;
	}

	// restart the entire server
	gi.AddCommandString ("menu_loadgame\n");
}
*/
//TROND
//RESPAWN FUNKSJON
void respawn (edict_t *self)
{
	if (deathmatch->value || coop->value)
	{
		edict_t		*body;
		// spectator's don't leave bodies
		if (self->movetype != MOVETYPE_NOCLIP)
		{
			body = G_Spawn();

			VectorCopy (self->s.origin, body->s.origin);
//			VectorCopy(self->client->v_angle, body->s.angles);

			if (self->client->resp.ctf_team == CTF_TEAM2)
				body->s.modelindex = gi.modelindex ("players/team2/tris.md2");
			else if (self->client->resp.ctf_team == CTF_TEAM1)
				body->s.modelindex = gi.modelindex ("players/team1/tris.md2");
			else
			{
				if (self->client->resp.skins == 1)
					body->s.modelindex = gi.modelindex ("players/team1/tris.md2");
				else if (self->client->resp.skins == 2)
					body->s.modelindex = gi.modelindex ("players/messiah/tris.md2");
				else if (self->client->resp.skins == 3)
					body->s.modelindex = gi.modelindex ("players/team2/tris.md2");
				else if (self->client->resp.skins == 4)
					body->s.modelindex = gi.modelindex ("players/crakhor/tris.md2");
				else
					body->s.modelindex = gi.modelindex ("players/team1/tris.md2");
			}

			//TROND ATL 10/4
			if (self->client->s_leader == 1)
				body->s.modelindex = gi.modelindex ("players/crakhor/tris.md2");
			else if (self->client->t_leader == 1)
				body->s.modelindex = gi.modelindex ("players/messiah/tris.md2");
			//TROND slutt

			if (self->client->dead_frame == 1)
				body->s.frame = 177;
			else if (self->client->dead_frame == 2)
				body->s.frame = FRAME_death106;
			else if (self->client->dead_frame == 3)
				body->s.frame = FRAME_death206;
			else
				body->s.frame = FRAME_death308;

			body->s.angles[YAW] = self->s.angles[YAW];
			body->s.renderfx = RF_IR_VISIBLE;

			//HER KJEM SLITET
			
			//alt som he med bein å gjør
			if (self->client->pain_head == 0
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 0)
				body->s.skinnum = 0;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 0)
				body->s.skinnum = 1;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 0)
				body->s.skinnum = 2;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 0)
				body->s.skinnum = 3;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 1)
				body->s.skinnum = 4;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 0)
				body->s.skinnum = 5;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 1)
				body->s.skinnum = 6;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 1)
				body->s.skinnum = 7;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 1)
				body->s.skinnum = 8;
			//chest
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 0)
				body->s.skinnum = 9;
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 0)
				body->s.skinnum = 10;
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 1)
				body->s.skinnum = 11;
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 1)
				body->s.skinnum = 12;
			//stomach
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 0)
				body->s.skinnum = 13;
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 1)
				body->s.skinnum = 14;
			//leg
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 1)
				body->s.skinnum = 15;
			//SLIT SLUTT

			body->nextthink = level.time + 60;
			body->think = G_FreeEdict;

			gi.linkentity (body);
		}

		//TROND slutt
//TROND
//		if (self->client->lms_alive == 1)
//		{
//TROND slutt
			self->svflags &= ~SVF_NOCLIENT;
			PutClientInServer (self);
//TROND
/*		}
		else
		{
			LMS_Dead (self);
		}
//TROND slutt*/
	
		// add a teleportation effect
		self->s.event = EV_PLAYER_TELEPORT;

		// hold in place briefly
		self->client->ps.pmove.pm_flags = PMF_TIME_TELEPORT;
		self->client->ps.pmove.pm_time = 14;

		self->client->respawn_time = level.time;

		return;
	}

	// restart the entire server
	gi.AddCommandString ("menu_loadgame\n");
}
//TROND slutt
//TROND safe 28/3
/*
void respawn (edict_t *self)
{
	if (deathmatch->value || coop->value)
	{
		edict_t		*body;
		// spectator's don't leave bodies
		if (self->movetype != MOVETYPE_NOCLIP)
		{
			body = G_Spawn();

			VectorCopy (self->s.origin, body->s.origin);
//			VectorCopy(self->client->v_angle, body->s.angles);
			if (self->client->resp.ctf_team == CTF_TEAM2)
				body->s.modelindex = gi.modelindex ("players/team2/tris.md2");
			else
				body->s.modelindex = gi.modelindex ("players/team1/tris.md2");

			if (self->client->dead_frame == 1)
				body->s.frame = 177;
			else if (self->client->dead_frame == 2)
				body->s.frame = FRAME_death106;
			else if (self->client->dead_frame == 3)
				body->s.frame = FRAME_death206;
			else
				body->s.frame = FRAME_death308;

			body->s.angles[YAW] = self->s.angles[YAW];
			body->s.renderfx = RF_IR_VISIBLE;

			//HER KJEM SLITET
			
			//alt som he med bein å gjør
			if (self->client->pain_head == 0
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 0)
				body->s.skinnum = 0;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 0)
				body->s.skinnum = 1;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 0)
				body->s.skinnum = 2;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 0)
				body->s.skinnum = 3;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 1)
				body->s.skinnum = 4;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 0)
				body->s.skinnum = 5;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 1)
				body->s.skinnum = 6;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 1)
				body->s.skinnum = 7;
			else if (self->client->pain_head == 1
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 1)
				body->s.skinnum = 8;
			//chest
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 0)
				body->s.skinnum = 9;
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 0)
				body->s.skinnum = 10;
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 1)
				body->s.skinnum = 11;
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 1
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 1)
				body->s.skinnum = 12;
			//stomach
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 0)
				body->s.skinnum = 13;
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 1
				&& self->client->pain_leg == 1)
				body->s.skinnum = 14;
			//leg
			else if (self->client->pain_head == 0
				&& self->client->pain_chest == 0
				&& self->client->pain_stomach == 0
				&& self->client->pain_leg == 1)
				body->s.skinnum = 15;
			//SLIT SLUTT

			body->nextthink = level.time + 60;
			body->think = G_FreeEdict;

			gi.linkentity (body);
		}

		//TROND slutt
//TROND
//		if (self->client->lms_alive == 1)
//		{
//TROND slutt
			self->svflags &= ~SVF_NOCLIENT;
			PutClientInServer (self);
//TROND
/*		}
		else
		{
			LMS_Dead (self);
		}
//TROND slutt*/
	
/*		// add a teleportation effect
		self->s.event = EV_PLAYER_TELEPORT;

		// hold in place briefly
		self->client->ps.pmove.pm_flags = PMF_TIME_TELEPORT;
		self->client->ps.pmove.pm_time = 14;

		self->client->respawn_time = level.time;

		return;
	}

	// restart the entire server
	gi.AddCommandString ("menu_loadgame\n");
}*/
//TROND slutt

/*
 * only called when pers.spectator changes
 * note that resp.spectator should be the opposite of pers.spectator here
 */
void spectator_respawn (edict_t *ent)
{
	int i, numspec;

	// if the user wants to become a spectator, make sure he doesn't
	// exceed max_spectators

	//TROND bug fix 10/4 ATL
	if (ent->client->t_leader == 1)
	{
		ent->client->t_leader = 0;
		terror_l = 0;
		gi.bprintf (PRINT_HIGH, "%s, the terrorist leader, left the match.\n", ent->client->pers.netname);
	}
	if (ent->client->s_leader == 1)
	{
		ent->client->s_leader = 0;
		swat_l = 0;
		gi.bprintf (PRINT_HIGH, "%s, the SWAT leader, left the match.\n", ent->client->pers.netname);
	}
		//TROND slutt

	if (ent->client->pers.spectator) 
	{
		char *value = Info_ValueForKey (ent->client->pers.userinfo, "spectator");
		if (*spectator_password->string &&
			strcmp(spectator_password->string, "none") &&
			strcmp(spectator_password->string, value)) {
			gi.cprintf(ent, PRINT_HIGH, "Spectator password incorrect.\n");
			ent->client->pers.spectator = false;
			gi.WriteByte (svc_stufftext);
			gi.WriteString ("spectator 0\n");
			gi.unicast(ent, true);
			return;
		}

		// count spectators
		for (i = 1, numspec = 0; i <= maxclients->value; i++)
			if (g_edicts[i].inuse && g_edicts[i].client->pers.spectator)
				numspec++;

		if (numspec >= maxspectators->value) {
			gi.cprintf(ent, PRINT_HIGH, "Server spectator limit is full.");
			ent->client->pers.spectator = false;
			// reset his spectator var
			gi.WriteByte (svc_stufftext);
			gi.WriteString ("spectator 0\n");
			gi.unicast(ent, true);
			return;
		}
	} else {
		// he was a spectator and wants to join the game
		// he must have the right password
		char *value = Info_ValueForKey (ent->client->pers.userinfo, "password");
		if (*password->string && strcmp(password->string, "none") &&
			strcmp(password->string, value)) {
			gi.cprintf(ent, PRINT_HIGH, "Password incorrect.\n");
			ent->client->pers.spectator = true;
			gi.WriteByte (svc_stufftext);
			gi.WriteString ("spectator 1\n");
			gi.unicast(ent, true);
			return;
		}
	}

	// clear client on respawn
	ent->client->resp.score = ent->client->pers.score = 0;

	ent->svflags &= ~SVF_NOCLIENT;
	PutClientInServer (ent);

	// add a teleportation effect
	if (!ent->client->pers.spectator)  {
		// send effect
		gi.WriteByte (svc_muzzleflash);
		gi.WriteShort (ent-g_edicts);
		gi.WriteByte (MZ_LOGIN);
		gi.multicast (ent->s.origin, MULTICAST_PVS);

		// hold in place briefly
		ent->client->ps.pmove.pm_flags = PMF_TIME_TELEPORT;
		ent->client->ps.pmove.pm_time = 14;
	}

	ent->client->respawn_time = level.time;

	if (ent->client->pers.spectator)
	{
		gi.bprintf (PRINT_HIGH, "%s has moved to the sidelines\n", ent->client->pers.netname);
	}
	else
		gi.bprintf (PRINT_HIGH, "%s joined the game\n", ent->client->pers.netname);
}

//==============================================================


/*
===========
PutClientInServer

Called when a player connects to a server or respawns in
a deathmatch.
============
*/

void PutClientInServer (edict_t *ent)
{
	vec3_t	mins = {-16, -16, -24};
	vec3_t	maxs = {16, 16, 32};
	int		index;
	vec3_t	spawn_origin, spawn_angles;
	gclient_t	*client;
	int		i;
	client_persistant_t	saved;
	client_respawn_t	resp;

	// find a spawn point
	// do it before setting health back up, so farthest
	// ranging doesn't count this client
	SelectSpawnPoint (ent, spawn_origin, spawn_angles);

	//TROND 31/3
	if (!ent->client)
		return;
	//TROND slutt

	index = ent-g_edicts-1;
	client = ent->client;

	// deathmatch wipes most client data every spawn
	if (deathmatch->value)
	{
		char		userinfo[MAX_INFO_STRING];

		resp = client->resp;
		memcpy (userinfo, client->pers.userinfo, sizeof(userinfo));
		InitClientPersistant (client);
		ClientUserinfoChanged (ent, userinfo);
	}
	else if (coop->value
		|| (deathmatch->value == 0
		&& ctf->value == 0))
	{
//		int			n;
		char		userinfo[MAX_INFO_STRING];

		resp = client->resp;
		memcpy (userinfo, client->pers.userinfo, sizeof(userinfo));
		// this is kind of ugly, but it's how we want to handle keys in coop
//		for (n = 0; n < game.num_items; n++)
//		{
//			if (itemlist[n].flags & IT_KEY)
//				resp.coop_respawn.inventory[n] = client->pers.inventory[n];
//		}
		resp.coop_respawn.game_helpchanged = client->pers.game_helpchanged;
		resp.coop_respawn.helpchanged = client->pers.helpchanged;
		client->pers = resp.coop_respawn;
		ClientUserinfoChanged (ent, userinfo);
		if (resp.score > client->pers.score)
			client->pers.score = resp.score;
	}
	else
	{
		memset (&resp, 0, sizeof(resp));
	}

	// clear everything but the persistant data
	saved = client->pers;
	memset (client, 0, sizeof(*client));
	client->pers = saved;
	if (client->pers.health <= 0)
		InitClientPersistant(client);
	client->resp = resp;

	// copy some data from the client to the entity
	FetchClientEntData (ent);

	// clear entity values
	ent->groundentity = NULL;
	ent->client = &game.clients[index];
	ent->takedamage = DAMAGE_AIM;
	ent->movetype = MOVETYPE_WALK;
	ent->viewheight = 22;
	ent->inuse = true;
	ent->classname = "player";
	ent->enemy = NULL;//TROND linje
	ent->mass = 200;
	ent->solid = SOLID_BBOX;
	ent->deadflag = DEAD_NO;
	ent->air_finished = level.time + 12;
	ent->clipmask = MASK_PLAYERSOLID;
	ent->model = "players/male/tris.md2";
	ent->pain = player_pain;
	//TROND tatt vekk 11/3
	//ent->die = player_die;
	//TROND slutt
	ent->waterlevel = 0;
	ent->watertype = 0;
	ent->flags &= ~FL_NO_KNOCKBACK;
	ent->svflags &= ~SVF_DEADMONSTER;

	if (deathmatch->value)//TROND pga SP 15/3
	{
	//TROND
	//PAIN SKINS
	client->die_frame = 0;
	client->dead_frame = 0;
	client->pain_head = 0;
	client->pain_chest = 0;
	client->pain_stomach = 0;
	client->pain_leg = 0;
//	painskin (ent);
	client->kills = 0;
	//VEKT
	client->weight = 20;
	//OPNE DØR
	client->dooropen = 0;
	//INFRARED
	client->fl_on = 0;
	client->ls_on = 0;
	client->infrared = 0;
	//ITEM PICKUP
	client->head_item = 0;
	client->torso_item = 0;
	client->feet_item = 0;

	client->item = 0;
	//LIMP
	client->limping = 0;
	client->limp = 0;
	//BLØ
	client->bandaging = 0;
	client->bleeding = 0;
	//GRANAT
	client->pin_pulled = 0;
	//ZOOM
	client->zoom = 0;
	client->casull_bullets = 0;
	client->shotgun_shells = 0;
	//TROND ATL	9/4
	if (ctf->value
		&& terror_l == 0
		&& client->resp.ctf_team == CTF_TEAM1
		&& leader->value
		&& !client->pers.spectator//TROND 10/4 ATL
		)
	{
		client->t_leader = 1;
		terror_l = 1;
		gi.bprintf (PRINT_HIGH, "**SWAT, kill the terrorist leader, %s!**\n", client->pers.netname);
	}
	if (ctf->value
		&& swat_l == 0
		&& client->resp.ctf_team == CTF_TEAM2
		&& leader->value
		&& !client->pers.spectator//TROND 10/4 ATL
		)
	{
		client->s_leader = 1;
		swat_l = 1;
		gi.bprintf (PRINT_HIGH, "**Terrorists, kill the SWAT leader, %s!**\n", client->pers.netname);
	}
	painskin (ent);//TROND flytta hit 9/4
	//TROND slutt
	}//TROND pga SP 15/3
	else
	{
		painskin (ent);//TROND	3/4
		SP_Values(ent);
//		CTFOpenWepMenu(ent);
	}
/*	//TROND 10/4 vaapen meny
	if (wepmenu->value)
	{
		if (client->resp.weapon_menu == 0)
		{
			ent->movetype = MOVETYPE_NOCLIP;
			ent->svflags |= SVF_NOCLIENT;
			CTFOpenWepMenu(ent);
			client->resp.weapon_menu = 1;
		}
	}
	//TROND slutt*/

	VectorCopy (mins, ent->mins);
	VectorCopy (maxs, ent->maxs);
	VectorClear (ent->velocity);

	// clear playerstate values
	memset (&ent->client->ps, 0, sizeof(client->ps));

	client->ps.pmove.origin[0] = spawn_origin[0]*8;
	client->ps.pmove.origin[1] = spawn_origin[1]*8;
	client->ps.pmove.origin[2] = spawn_origin[2]*8;
//ZOID
	client->ps.pmove.pm_flags &= ~PMF_NO_PREDICTION;
//ZOID

	//TROND mekk 3/4
	//TROND fix 11/4 hmmmm.......
//	if (deathmatch->value && ((int)dmflags->value & DF_FIXED_FOV))
//	{
		client->ps.fov = 90;
/*	}
	else
	{
		client->ps.fov = atoi(Info_ValueForKey(client->pers.userinfo, "fov"));
		if (client->ps.fov < 1)
			client->ps.fov = 90;
		else if (client->ps.fov > 160)
			client->ps.fov = 160;
	}*/
	//TROND slutt

	client->ps.gunindex = gi.modelindex(client->pers.weapon->view_model);

	// clear entity state values
	ent->s.effects = 0;
	ent->s.modelindex = 255;		// will use the skin specified model
	ent->s.modelindex2 = 255;		// custom gun model
	// sknum is player num and weapon number
	// weapon number will be added in changeweapon
	ent->s.skinnum = ent - g_edicts - 1;

	ent->s.frame = 0;
	VectorCopy (spawn_origin, ent->s.origin);
	ent->s.origin[2] += 1;	// make sure off ground
	VectorCopy (ent->s.origin, ent->s.old_origin);

	// set the delta angle
	for (i=0 ; i<3 ; i++)
	{
		client->ps.pmove.delta_angles[i] = ANGLE2SHORT(spawn_angles[i] - client->resp.cmd_angles[i]);
	}

	ent->s.angles[PITCH] = 0;
	ent->s.angles[YAW] = spawn_angles[YAW];
	ent->s.angles[ROLL] = 0;
	VectorCopy (ent->s.angles, client->ps.viewangles);
	VectorCopy (ent->s.angles, client->v_angle);

//ZOID
	if (CTFStartClient(ent))
		return;
//ZOID

	// spawn a spectator
	if (client->pers.spectator) 
	{
		client->chase_target = NULL;

		client->resp.spectator = true;

		ent->movetype = MOVETYPE_NOCLIP;
		ent->solid = SOLID_NOT;
		ent->svflags |= SVF_NOCLIENT;
		ent->client->ps.gunindex = 0;
		gi.linkentity (ent);
		return;
	} 
	else
		client->resp.spectator = false;

	if (!KillBox (ent))
	{	// could't spawn in?
	}

	gi.linkentity (ent);

	//TROND gi ammo i starten
	//	7/3 TATT VEKK PGA BUG TEST
	//	8/3 TATT TILBAKE
	//	15/3 TATT VEKK IGJEN pga intermissiontime

	//client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))] = 8;
	//client->pers.inventory[ITEM_INDEX(FindItem("1911clip"))] = 2;
	//client->pers.inventory[ITEM_INDEX(FindItem("uziclip"))] = 2;
	//client->pers.inventory[ITEM_INDEX(FindItem("uzirounds"))] = 30;

	//client->pers.inventory[ITEM_INDEX(FindItem("grapple"))] = 1;
	//TROND slutt

	// force the current weapon up
	client->newweapon = client->pers.weapon;
	ChangeWeapon (ent);

	//TROND 24/4
	if (lms->value)
	{
		ent->client->lms_winner = 0;
		if (lms_round == 0
			|| lms_players < 2
			|| ent->client->resp.lms_dead == 1
			|| lms_delay > level.time//TROND 30/4
			)
		{
			ent->movetype = MOVETYPE_NOCLIP;
			ent->svflags |= SVF_NOCLIENT;
			ent->solid = SOLID_NOT;

			//TROND 28/4
			CheckLMSRules();
			if (lms_players < 2)
				gi.centerprintf (ent, "You are alone\n");
		}
		else
		{
			ent->svflags &= ~SVF_NOCLIENT;
			ent->solid = SOLID_BBOX;
		}
	}
	//TROND slutt
}

/*
=====================
ClientBeginDeathmatch

A client has just connected to the server in
deathmatch mode, so clear everything out before starting them.
=====================
*/
void ClientBeginDeathmatch (edict_t *ent)
{
	G_InitEdict (ent);

	InitClientResp (ent->client);

	//TROND	3/5
	if (lms->value)
	{
		ent->client->lms_winner = 0;
		ent->deadflag = 0;
	}

	// locate ent at a spawn point
	PutClientInServer (ent);

	if (level.intermissiontime)
	{
		MoveClientToIntermission (ent);
	}
	else
	{
		// send effect
		gi.WriteByte (svc_muzzleflash);
		gi.WriteShort (ent-g_edicts);
		gi.WriteByte (MZ_LOGIN);
		gi.multicast (ent->s.origin, MULTICAST_PVS);
	}

	gi.bprintf (PRINT_HIGH, "%s entered the game\n", ent->client->pers.netname);

	// make sure all view stuff is valid
	ClientEndServerFrame (ent);
}


/*
===========
ClientBegin

called when a client has finished connecting, and is ready
to be placed into the game.  This will happen every level load.
============
*/
void ClientBegin (edict_t *ent)
{
	int		i;

	ent->client = game.clients + (ent - g_edicts - 1);

	if (deathmatch->value)
	{
		ClientBeginDeathmatch (ent);
		return;
	}

	// if there is already a body waiting for us (a loadgame), just
	// take it, otherwise spawn one from scratch
	if (ent->inuse == true)
	{
		// the client has cleared the client side viewangles upon
		// connecting to the server, which is different than the
		// state when the game is saved, so we need to compensate
		// with deltaangles
		for (i=0 ; i<3 ; i++)
			ent->client->ps.pmove.delta_angles[i] = ANGLE2SHORT(ent->client->ps.viewangles[i]);
	}
	else
	{
		// a spawn point will completely reinitialize the entity
		// except for the persistant data that was initialized at
		// ClientConnect() time
		G_InitEdict (ent);
		ent->classname = "player";
		InitClientResp (ent->client);
		PutClientInServer (ent);
	}

	if (level.intermissiontime)
	{		
		MoveClientToIntermission (ent);
	}
	else
	{
		// send effect if in a multiplayer game
		if (game.maxclients > 1)
		{
			gi.WriteByte (svc_muzzleflash);
			gi.WriteShort (ent-g_edicts);
			gi.WriteByte (MZ_LOGIN);
			gi.multicast (ent->s.origin, MULTICAST_PVS);

			gi.bprintf (PRINT_HIGH, "%s entered the game\n", ent->client->pers.netname);
		}
	}

	// make sure all view stuff is valid
	ClientEndServerFrame (ent);
}

/*
===========
ClientUserInfoChanged

called whenever the player updates a userinfo variable.

The game can override any of the settings in place
(forcing skins or names, etc) before copying it off.
============
*/
void ClientUserinfoChanged (edict_t *ent, char *userinfo)
{
	char	*s;
	int		playernum;

	// check for malformed or illegal info strings
	if (!Info_Validate(userinfo))
	{
		strcpy (userinfo, "\\name\\badinfo\\skin\\male/grunt");
	}

	// set name
	s = Info_ValueForKey (userinfo, "name");
	strncpy (ent->client->pers.netname, s, sizeof(ent->client->pers.netname)-1);

	// set spectator
	s = Info_ValueForKey (userinfo, "spectator");
	// spectators are only supported in deathmatch
	if (deathmatch->value && *s && strcmp(s, "0"))
		ent->client->pers.spectator = true;
	else
		ent->client->pers.spectator = false;

	// set skin
	s = Info_ValueForKey (userinfo, "skin");

	playernum = ent-g_edicts-1;

	// combine name and skin into a configstring
	/*TROND tatt vekk
//ZOID
	if (ctf->value)
		CTFAssignSkin(ent, s);//TROND tatt vekk
	else
//ZOID
	//TROND */
//TROND vekk		gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s", ent->client->pers.netname, s) );

	// fov
	//TROND fix 3/4
//	if (deathmatch->value && ((int)dmflags->value & DF_FIXED_FOV))
//	{
//		ent->client->ps.fov = 90;//TROND tatt vekk 11/4
/*	}
	else
	{
		ent->client->ps.fov = atoi(Info_ValueForKey(userinfo, "fov"));
		if (ent->client->ps.fov < 1)
			ent->client->ps.fov = 90;
//		else if (ent->client->ps.fov > 160)//TROND
//			ent->client->ps.fov = 160;//TROND
	}*/

	// handedness
	s = Info_ValueForKey (userinfo, "hand");
	if (strlen(s))
	{
		ent->client->pers.hand = atoi(s);
	}

	// save off the userinfo in case we want to check something later
	strncpy (ent->client->pers.userinfo, userinfo, sizeof(ent->client->pers.userinfo)-1);
}


/*
===========
ClientConnect

Called when a player begins connecting to the server.
The game can refuse entrance to a client by returning false.
If the client is allowed, the connection process will continue
and eventually get to ClientBegin()
Changing levels will NOT cause this to be called again, but
loadgames will.
============
*/
qboolean ClientConnect (edict_t *ent, char *userinfo)
{
	char	*value;

	// check to see if they are on the banned IP list
	value = Info_ValueForKey (userinfo, "ip");
	if (SV_FilterPacket(value)) {
		Info_SetValueForKey(userinfo, "rejmsg", "Banned.");
		return false;
	}

	// check for a spectator
	value = Info_ValueForKey (userinfo, "spectator");
	if (deathmatch->value && *value && strcmp(value, "0")) {
		int i, numspec;

		if (*spectator_password->string &&
			strcmp(spectator_password->string, "none") &&
			strcmp(spectator_password->string, value)) {
			Info_SetValueForKey(userinfo, "rejmsg", "Spectator password required or incorrect.");
			return false;
		}

		// count spectators
		for (i = numspec = 0; i < maxclients->value; i++)
			if (g_edicts[i+1].inuse && g_edicts[i+1].client->pers.spectator)
				numspec++;

		if (numspec >= maxspectators->value) {
			Info_SetValueForKey(userinfo, "rejmsg", "Server spectator limit is full.");
			return false;
		}
	} else {
		// check for a password
		value = Info_ValueForKey (userinfo, "password");
		if (*password->string && strcmp(password->string, "none") &&
			strcmp(password->string, value)) {
			Info_SetValueForKey(userinfo, "rejmsg", "Password required or incorrect.");
			return false;
		}
	}


	// they can connect
	ent->client = game.clients + (ent - g_edicts - 1);

	// if there is already a body waiting for us (a loadgame), just
	// take it, otherwise spawn one from scratch
	if (ent->inuse == false)
	{
		// clear the respawning variables
//ZOID -- force team join
		ent->client->resp.ctf_team = -1;
//ZOID
		InitClientResp (ent->client);
		if (!game.autosaved || !ent->client->pers.weapon)
			InitClientPersistant (ent->client);
	}

	ClientUserinfoChanged (ent, userinfo);

	if (game.maxclients > 1)
		gi.dprintf ("%s connected\n", ent->client->pers.netname);

	ent->svflags = 0; // make sure we start with known default
	ent->client->pers.connected = true;
	return true;
}

/*
===========
ClientDisconnect

Called when a player drops from the server.
Will not be called between levels.
============
*/
void ClientDisconnect (edict_t *ent)
{
	int		playernum;

	if (!ent->client)
		return;

	gi.bprintf (PRINT_HIGH, "%s disconnected\n", ent->client->pers.netname);

	//TROND
	TossClientWeapon (ent);

	//TROND ATL 9/4
	if (ent->client->t_leader == 1
		&& ent->client->resp.ctf_team == CTF_TEAM1
		&& leader->value)
	{
		terror_l = 0;
		ent->client->t_leader = 0;
		gi.bprintf (PRINT_HIGH, "The terrorist disconnected\n");
	}
	if (ent->client->s_leader == 1
		&& ent->client->resp.ctf_team == CTF_TEAM2
		&& leader->value)
	{
		swat_l = 0;
		ent->client->s_leader = 0;
		gi.bprintf (PRINT_HIGH, "The SWAT leader disconnected\n");
	}

	//TROND slutt

//ZOID
	CTFDeadDropFlag(ent);
	CTFDeadDropTech(ent);
//ZOID

	// send effect
	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_LOGOUT);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	gi.unlinkentity (ent);
	ent->s.modelindex = 0;
	ent->solid = SOLID_NOT;
	ent->inuse = false;
	ent->classname = "disconnected";
	ent->client->pers.connected = false;

	playernum = ent-g_edicts-1;
	gi.configstring (CS_PLAYERSKINS+playernum, "");
}


//==============================================================


edict_t	*pm_passent;

// pmove doesn't need to know about passent and contentmask
trace_t	PM_trace (vec3_t start, vec3_t mins, vec3_t maxs, vec3_t end)
{
	if (pm_passent->health > 0)
		return gi.trace (start, mins, maxs, end, pm_passent, MASK_PLAYERSOLID);
	else
		return gi.trace (start, mins, maxs, end, pm_passent, MASK_DEADSOLID);
}

unsigned CheckBlock (void *b, int c)
{
	int	v,i;
	v = 0;
	for (i=0 ; i<c ; i++)
		v+= ((byte *)b)[i];
	return v;
}
void PrintPmove (pmove_t *pm)
{
	unsigned	c1, c2;

	c1 = CheckBlock (&pm->s, sizeof(pm->s));
	c2 = CheckBlock (&pm->cmd, sizeof(pm->cmd));
	Com_Printf ("sv %3i:%i %i\n", pm->cmd.impulse, c1, c2);
}

/*
==============
ClientThink

This will be called once for each client frame, which will
usually be a couple times for each server frame.
==============
*/
//TROND	ATL 9/4
static edict_t *FindTerrorLeader(void)
{
	edict_t *player = NULL;
//	int i = rand() % 16;
	int i = rand() % 20;

	while (i--)
		player = G_Find (player, FOFS(classname), "player");
	if (!player)
		player = G_Find (player, FOFS(classname), "player");
	return player;
}
//TROND slutt

void ClientThink (edict_t *ent, usercmd_t *ucmd)
{
	gclient_t	*client;
	edict_t	*other;
	int		i, j;
	pmove_t	pm;
	edict_t	*player;//TROND ATL 9/4

	level.current_entity = ent;
	client = ent->client;

	//TROND
	//LIMP
	if (client->limp == 1)
	{
		if (ent->velocity[2] > 10)
			ent->velocity[2] = 0;
		if (level.framenum % 6  <= 2)
		{
			ent->velocity[1] *= 0.2;
			ent->velocity[0] *= 0.2; 
		}
	}
	//TROND ATL 9/4
	if (!(level.framenum % 30)
		&& leader->value
		&& !level.intermissiontime)
	{
		if (terror_l == 0
			&& client->resp.ctf_team == CTF_TEAM1
			&& client
			&& ent->deadflag == 0
			&& !client->pers.spectator//TROND 10/4 ATL
			)
		{
			if ((player = FindTerrorLeader()) != NULL)
			{
				gi.bprintf (PRINT_HIGH, "**The new terrorist leader is %s**\n", ent->client->pers.netname);
				client->t_leader = 1;
				terror_l = 1;
				painskin (ent);
				ShowTorso(ent);
				ShowItem (ent);
			}
		}
		if (swat_l == 0
			&& client->resp.ctf_team == CTF_TEAM2
			&& client
			&& ent->deadflag == 0
			&& !client->pers.spectator//TROND 10/4 ATL
			)
		{
			if ((player = FindTerrorLeader()) != NULL)
			{
				gi.bprintf (PRINT_HIGH, "**The new SWAT leader is %s**\n", ent->client->pers.netname);
				client->s_leader = 1;
				swat_l = 1;
				painskin (ent);
				ShowTorso(ent);
				ShowItem (ent);
			}
		}
	}

	//TROND 24/4
	if (lms->value)
	{
		if (lms_round == 1
			&& level.time > lms_delay
			&& ent->client->lms_allowed == 0)
		{
			TossClientWeapon (ent);//		3/5
			PutClientInServer (ent);
			ent->client->lms_allowed = 1;
			ent->deadflag = 0;//		3/5
			ent->client->lms_winner = 0;
		}

		//gi.dprintf ("%d\n", lms_alive_players);
//		gi.cprintf (ent, PRINT_HIGH, "winner - %d  deadflag - %d  alive ppl - %d  round - %d\n", ent->client->lms_winner, ent->deadflag, lms_alive_players, lms_round);
		//		3/5
		if (ent->client->lms_winner == 0
			&& lms_alive_players == 1
			&& ent->movetype != MOVETYPE_NOCLIP
			&& ent->deadflag == 0
			&& lms_delay > level.time)
		{
			ent->client->lms_winner = 1;
			gi.bprintf (PRINT_CHAT, "%s is the Last Man Standing\n", ent->client->pers.netname);
			ent->client->resp.score += 10;

			if (ent->client->fl_on == 1)
			{
				ent->client->fl_on = 0;
				SP_FlashLight(ent);
			}
			if (ent->client->ls_on == 1)
			{
				ent->client->ls_on = 0;
				SP_LaserSight(ent);
			}

		}
	}

	//TROND slutt

//PSYKOTIK
	if (ctf->value && client->resp.ctf_team == CTF_NOTEAM && !client->menu) 
	{
		client->showscores = false;
		client->showhelp = false;
		CTFOpenJoinMenu(ent);
	}
// PSYKOTIK


	//TROND		28/3
	if (!ctf->value
		&& deathmatch->value
		&& client->resp.skin_chosen == 0
		&& client->pers.skin == 0
//		&& !wepmenu->value//TROND 10/4
		)
	{
		client->pers.skin = 1;
		CTFOpenSkinMenu (ent);
	}
	//TROND 28/3
/*	if (!ctf->value
		&& deathmatch->value
		&& !client->skin)
	{
		client->showscores = false;
		client->showhelp = false;
		CTFOpenSkinMenu(ent);
	}*/
	//TROND slutt

	if (level.intermissiontime)
	{
		if (!deathmatch->value)//TROND 15/3
			ent->client->pers.inventory[ITEM_INDEX(FindItem("weight"))] = ent->client->weight;//TROND 15/3
		
		client->ps.pmove.pm_type = PM_FREEZE;
		// can exit intermission after five seconds
		if (level.time > level.intermissiontime + 5.0
			&& (ucmd->buttons & BUTTON_ANY) )
			level.exitintermission = true;
		return;
	}

	pm_passent = ent;

	if (ent->client->chase_target) 
	{
		client->resp.cmd_angles[0] = SHORT2ANGLE(ucmd->angles[0]);
		client->resp.cmd_angles[1] = SHORT2ANGLE(ucmd->angles[1]);
		client->resp.cmd_angles[2] = SHORT2ANGLE(ucmd->angles[2]);

	} 
	else 
	{

		// set up for pmove
		memset (&pm, 0, sizeof(pm));

		if (ent->movetype == MOVETYPE_NOCLIP)
			client->ps.pmove.pm_type = PM_SPECTATOR;
		else if (ent->s.modelindex != 255)
			client->ps.pmove.pm_type = PM_GIB;
		else if (ent->deadflag)
			client->ps.pmove.pm_type = PM_DEAD;
		else
			client->ps.pmove.pm_type = PM_NORMAL;

		client->ps.pmove.gravity = sv_gravity->value;
		pm.s = client->ps.pmove;

		for (i=0 ; i<3 ; i++)
		{
			pm.s.origin[i] = ent->s.origin[i]*8;
			pm.s.velocity[i] = ent->velocity[i]*8;
		}

		if (memcmp(&client->old_pmove, &pm.s, sizeof(pm.s)))
		{
			pm.snapinitial = true;
	//		gi.dprintf ("pmove changed!\n");
		}

		pm.cmd = *ucmd;

		pm.trace = PM_trace;	// adds default parms
		pm.pointcontents = gi.pointcontents;

		// perform a pmove
		gi.Pmove (&pm);

		// save results of pmove
		client->ps.pmove = pm.s;
		client->old_pmove = pm.s;

		for (i=0 ; i<3 ; i++)
		{
			ent->s.origin[i] = pm.s.origin[i]*0.125;
			ent->velocity[i] = pm.s.velocity[i]*0.125;
		}

		VectorCopy (pm.mins, ent->mins);
		VectorCopy (pm.maxs, ent->maxs);

		client->resp.cmd_angles[0] = SHORT2ANGLE(ucmd->angles[0]);
		client->resp.cmd_angles[1] = SHORT2ANGLE(ucmd->angles[1]);
		client->resp.cmd_angles[2] = SHORT2ANGLE(ucmd->angles[2]);

		if (ent->groundentity && !pm.groundentity && (pm.cmd.upmove >= 10) && (pm.waterlevel == 0))
		{
	//		gi.sound(ent, CHAN_VOICE, gi.soundindex("*jump1.wav"), 1, ATTN_NORM, 0);//TROND tatt vekk KUL hoppelyd
			PlayerNoise(ent, ent->s.origin, PNOISE_SELF);
		}

		ent->viewheight = pm.viewheight;
		ent->waterlevel = pm.waterlevel;
		ent->watertype = pm.watertype;
		ent->groundentity = pm.groundentity;
		if (pm.groundentity)
			ent->groundentity_linkcount = pm.groundentity->linkcount;

		if (ent->deadflag)
		{
			client->ps.viewangles[ROLL] = 40;
			client->ps.viewangles[PITCH] = -15;
			client->ps.viewangles[YAW] = client->killer_yaw;
		}
		else
		{
			VectorCopy (pm.viewangles, client->v_angle);
			VectorCopy (pm.viewangles, client->ps.viewangles);
		}

//ZOID
	if (client->ctf_grapple)
		CTFGrapplePull(client->ctf_grapple);
//ZOID

		gi.linkentity (ent);

		if (ent->movetype != MOVETYPE_NOCLIP)
			G_TouchTriggers (ent);
	
		//TROND
		//DOOROPEN
		ent->client->dooropen = 0;
		//TROND slutt

		// touch other objects
		for (i=0 ; i<pm.numtouch ; i++)
		{
			other = pm.touchents[i];
			for (j=0 ; j<i ; j++)
				if (pm.touchents[j] == other)
					break;
			if (j != i)
				continue;	// duplicated
			if (!other->touch)
				continue;
			other->touch (other, ent, NULL, NULL);
		}
		
		//TROND 30/3 reload funk
		client->ammotype = 0;
		//TROND slutt
	}

	client->oldbuttons = client->buttons;
	client->buttons = ucmd->buttons;
	client->latched_buttons |= client->buttons & ~client->oldbuttons;

	// save light level the player is standing on for
	// monster sighting AI
	ent->light_level = ucmd->lightlevel;

	// fire weapon from final position if needed
	if (client->latched_buttons & BUTTON_ATTACK
//ZOID
		&& ent->movetype != MOVETYPE_NOCLIP
//ZOID
		)
	{
		if (client->resp.spectator) {

			client->latched_buttons = 0;

			if (client->chase_target) {
				client->chase_target = NULL;
				client->ps.pmove.pm_flags &= ~PMF_NO_PREDICTION;
			} else
				GetChaseTarget(ent);

		} else if (!client->weapon_thunk) {
			client->weapon_thunk = true;
			Think_Weapon (ent);
		}
	}

//ZOID
//regen tech
	CTFApplyRegeneration(ent);
//ZOID

	if (client->resp.spectator) 
	{
		if (ucmd->upmove >= 10) 
		{
			if (!(client->ps.pmove.pm_flags & PMF_JUMP_HELD)) 
			{
				client->ps.pmove.pm_flags |= PMF_JUMP_HELD;
				if (client->chase_target)
					ChaseNext(ent);
				else
					GetChaseTarget(ent);
			}
		} 
		else
			client->ps.pmove.pm_flags &= ~PMF_JUMP_HELD;
	}

	// update chase cam if being followed
	for (i = 1; i <= maxclients->value; i++) 
	{
		other = g_edicts + i;
		if (other->inuse && other->client->chase_target == ent)
			UpdateChaseCam(other);
	}
}


/*
==============
ClientBeginServerFrame

This will be called once for each server frame, before running
any other entities in the world.
==============
*/
void ClientBeginServerFrame (edict_t *ent)
{
	gclient_t	*client;
	int			buttonMask;

	if (level.intermissiontime)
		return;

	client = ent->client;

	if (deathmatch->value &&
		client->pers.spectator != client->resp.spectator &&
		(level.time - client->respawn_time) >= 5) 
	{
		spectator_respawn(ent);
		return;
	}

	// run weapon animations if it hasn't been done by a ucmd_t
	if (!client->weapon_thunk && !client->resp.spectator
//ZOID
		&& ent->movetype != MOVETYPE_NOCLIP
//ZOID
		)
		Think_Weapon (ent);
	else
		client->weapon_thunk = false;

	if (ent->deadflag)
	{
		// wait for any button just going down
		if ( level.time > client->respawn_time)
		{
			// in deathmatch, only wait for attack button
			if (deathmatch->value)
				buttonMask = BUTTON_ATTACK;
			else
				buttonMask = -1;

			if ( ( client->latched_buttons & buttonMask ) ||
				(deathmatch->value && ((int)dmflags->value & DF_FORCE_RESPAWN) ) )
			{
				respawn (ent);
				client->latched_buttons = 0;
			}
		}
		return;
	}

/*	//TROND
	//LMS DØD
	if (ent->client->lms_alive == 1
		&& ent->svflags == SVF_NOCLIENT
		&& ent->client->resp.spectator == true
		&& ent->movetype == MOVETYPE_NOCLIP)			
	{
		ent->svflags &= ~SVF_NOCLIENT;
		ent->client->resp.spectator = false;
		respawn (ent);
		ent->movetype = MOVETYPE_STEP;
	}
	//TROND slutt*/

	// add player trail so monsters can follow

//TROND tatt vekk 10/3
/*
	if (!deathmatch->value)
		if (!visible (ent, PlayerTrail_LastSpot() ) )
			PlayerTrail_Add (ent->s.old_origin);
*/
//TROND slutt

	client->latched_buttons = 0;
}
