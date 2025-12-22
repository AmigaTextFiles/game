// g_weapon.c

#include "g_local.h"
#include "m_player.h"

//void Drop_Weapon (edict_t *ent, gitem_t *item, int FRAME_DEACTIVATE_LAST);//TROND linje
//TROND
void muzzleflash (edict_t *self, vec3_t start);
//TROND slutt

qboolean	is_quad;
static byte		is_silenced;


void weapon_grenade_fire (edict_t *ent, qboolean held);


void P_ProjectSource (gclient_t *client, vec3_t point, vec3_t distance, vec3_t forward, vec3_t right, vec3_t result)
{
	vec3_t	_distance;

	VectorCopy (distance, _distance);
	if (client->pers.hand == LEFT_HANDED)
//		_distance[1] *= -1;
		_distance[1] = 0;//TROND linje
	else if (client->pers.hand == CENTER_HANDED)
		_distance[1] = 0;
	else				 //TROND linje
		_distance[1] = 0;//TROND linje
	G_ProjectSource (point, _distance, forward, right, result);
}


/*
===============
PlayerNoise

Each player can have two noise objects associated with it:
a personal noise (jumping, pain, weapon firing), and a weapon
target noise (bullet wall impacts)

Monsters that don't directly see the player can move
to a noise in hopes of seeing the player from there.
===============
*/
void PlayerNoise(edict_t *who, vec3_t where, int type)
{
	edict_t		*noise;
	//TROND 14/3
/*
	if (type == PNOISE_WEAPON)
	{
		if (who->client->silencer_shots)
		{
			who->client->silencer_shots--;
			return;
		}
	}
*/

	//TROND tatt vekk KAN vere crash bug 2
	/*
	if (who->flags & FL_NOTARGET)
		return;
	*/
	//TROND slutt


	if (!who->mynoise)
	{
		noise = G_Spawn();
		noise->classname = "player_noise";
		VectorSet (noise->mins, -8, -8, -8);
		VectorSet (noise->maxs, 8, 8, 8);
		noise->owner = who;
		noise->svflags = SVF_NOCLIENT;
		who->mynoise = noise;

		noise = G_Spawn();
		noise->classname = "player_noise";
		VectorSet (noise->mins, -8, -8, -8);
		VectorSet (noise->maxs, 8, 8, 8);
		noise->owner = who;
		noise->svflags = SVF_NOCLIENT;
		who->mynoise2 = noise;
	}

	if (type == PNOISE_SELF || type == PNOISE_WEAPON)
	{
		noise = who->mynoise;
		level.sound_entity = noise;
		level.sound_entity_framenum = level.framenum;
	}
	else // type == PNOISE_IMPACT
	{
		noise = who->mynoise2;
		level.sound2_entity = noise;
		level.sound2_entity_framenum = level.framenum;
	}

	VectorCopy (where, noise->s.origin);
	VectorSubtract (where, noise->maxs, noise->absmin);
	VectorAdd (where, noise->maxs, noise->absmax);
	noise->teleport_time = level.time;
	gi.linkentity (noise);
}


qboolean Pickup_Weapon (edict_t *ent, edict_t *other)
{
	int			index;
	gitem_t		*ammo;
	//TROND
	//PLUKK OPP VÅPEN HACK
	if ( /*  !(other->client->pers.inventory[ITEM_INDEX(FindItem("UZI"))]) 
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("MARINER"))])//TROND var Shotgun 
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("super shotgun"))])  
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("BARRETT"))]) 
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("rocket launcher"))]) 
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("grenade launcher"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("bfg10k"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("hyperblaster"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("chaingun"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("ak 47"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("glock"))])
		&& */(other->client->ps.pmove.pm_flags & PMF_DUCKED))
		//TROND slutt
	{//TROND linje

		index = ITEM_INDEX(ent->item);

		//TROND VEKT
		if (ent->item == FindItem("mariner"))
		{
			if (other->client->weight < 9
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("mariner"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 9;
			}

		}
		if (ent->item == FindItem("barrett"))
		{
			if (other->client->weight < 17
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("barrett"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 17;
			}

		}
		if (ent->item == FindItem("uzi"))
		{
			if (other->client->weight < 8
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("uzi"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 8;
			}

		}
		if (ent->item == FindItem("glock"))
		{
			if (other->client->weight < 5
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("glock"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 5;
			}

		}
		if (ent->item == FindItem("ak 47"))
		{
			if (other->client->weight < 11
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("ak 47"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 11;
			}

		}
		if (ent->item == FindItem("casull"))
		{
			if (other->client->weight < 6
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("casull"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 6;
			}

		}
		//BERETTA 27/3
		if (ent->item == FindItem("beretta"))
		{
			if (other->client->weight < 4
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("beretta"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 4;
			}

		}
		//MP5 27/3
		if (ent->item == FindItem("mp5"))
		{
			if (other->client->weight < 8
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("mp5"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 8;
			}

		}
		//M60 1/4
		if (ent->item == FindItem("m60"))
		{
			if (other->client->weight < 22
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("m60"))]
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("m60ammo"))]
				|| other->client->torso_item == 1)
			{
				return false;
			}
			else
			{
				other->client->torso_item = 1;
				other->client->weight -= 22;
			}

		}
		//MSG90	3/4
		if (ent->item == FindItem("msg90"))
		{
			if (other->client->weight < 10
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("msg90"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 10;
			}

		}
		if (ent->item == FindItem("1911"))
		{
			if (other->client->weight < 3
				|| other->client->pers.inventory[ITEM_INDEX(FindItem("1911"))])
			{
				return false;
			}
			else
			{
				other->client->weight -= 3;
			}

		}
		//TROND slutt

		//TROND eg har nå monster, ikkje la våpen bli i coop  13/3
		/*
		if ( ( ((int)(dmflags->value) & DF_WEAPONS_STAY) || coop->value) 
		&& other->client->pers.inventory[index])
		{
			if (!(ent->spawnflags & (DROPPED_ITEM | DROPPED_PLAYER_ITEM) ) )
			return false;	// leave the weapon for others to pickup
		}
		*/
		//TROND slutt
		other->client->pers.inventory[index]++;
		if (ent->item == FindItem("m60"))//TROND 5/4
			ShowTorso(other);//TROND 5/4
		//TROND
		ammo = FindItem (ent->item->ammo);
		Add_Ammo (other, ammo, ent->ammo);

		if (!(ent->spawnflags & DROPPED_PLAYER_ITEM)
			&& !(ent->spawnflags & DROPPED_ITEM))
		{
			Add_Ammo (other, ammo, ammo->quantity);
		}
		//TROND slutt

		if (!(ent->spawnflags & DROPPED_ITEM) )
		{
		// give them some ammo with it
			ammo = FindItem (ent->item->ammo);
/*			if ( (int)dmflags->value & DF_INFINITE_AMMO )
				Add_Ammo (other, ammo, 1000);
			else
				Add_Ammo (other, ammo, ammo->quantity);*/
			//TROND 14/3 tatt vekk
			/*
			if (! (ent->spawnflags & DROPPED_PLAYER_ITEM) )
			{
				if (deathmatch->value)
				{
					if ((int)(dmflags->value) & DF_WEAPONS_STAY)
					ent->flags |= FL_RESPAWN;

					//TROND
					//HINDRER VÅPEN Å RESPAWNE I DET HEILE TATT
					//else
					//SetRespawn (ent, 30);
					//TROND slutt

				}
				//TROND 14/3 tatt vekk
				/*
				if (coop->value)
				ent->flags |= FL_RESPAWN;
				*/
				//TROND slutt
//			}//TROND slutt
		}
		return true;
	}//TROND linje
	else//TROND linje
		return false;//TROND linje
}

//TROND
//PICKUP NOAMMO WEAPON
qboolean Pickup_NoAmmo_Weapon (edict_t *ent, edict_t *other)
{
	int			index;

	if (other->client->ps.pmove.pm_flags & PMF_DUCKED
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("detonator"))]))
	{
		//VEKT mekk
		if (ent->item == FindItem("detonator"))
		{
			if (other->client->weight < 2)
				return false;
			other->client->weight -= 2;
		}
		//VEKT mekk slutt
		index = ITEM_INDEX(ent->item);

/*		if ( ( ((int)(dmflags->value) & DF_WEAPONS_STAY) || coop->value) 
		&& other->client->pers.inventory[index])
		{
			if (!(ent->spawnflags & (DROPPED_ITEM | DROPPED_PLAYER_ITEM) ) )
			return false;	// leave the weapon for others to pickup
		}*/
	
		other->client->pers.inventory[index]++;

/*		if (!(ent->spawnflags & DROPPED_ITEM) )
			{

			if (! (ent->spawnflags & DROPPED_PLAYER_ITEM) )
			{
				if (deathmatch->value)
				{
					if ((int)(dmflags->value) & DF_WEAPONS_STAY)
					ent->flags |= FL_RESPAWN;

				}
				if (coop->value)
				ent->flags |= FL_RESPAWN;
			}
		}*/

		return true;
	}
	else
		return false;
}
//TROND slutt

/*
===============
ChangeWeapon

The old weapon has been dropped all the way, so make the new one
current
===============
*/
void ChangeWeapon (edict_t *ent)
{
	int i;
/*//TROND GRANAT BUG FIX NÅR DØD
	if (ent->client->grenade_time)
	{
		ent->client->grenade_time = level.time;
		ent->client->weapon_sound = 0;
		weapon_grenade_fire (ent, false);
		ent->client->grenade_time = 0;
	}
*///TROND slutt
	ent->client->pers.lastweapon = ent->client->pers.weapon;
	ent->client->pers.weapon = ent->client->newweapon;
	ent->client->newweapon = NULL;
	ent->client->machinegun_shots = 0;

	// set visible model
	if (ent->s.modelindex == 255) {
		if (ent->client->pers.weapon)
			i = ((ent->client->pers.weapon->weapmodel & 0xff) << 8);
		else
			i = 0;
		ent->s.skinnum = (ent - g_edicts - 1) | i;
	}

	if (ent->client->pers.weapon && ent->client->pers.weapon->ammo)
		ent->client->ammo_index = ITEM_INDEX(FindItem(ent->client->pers.weapon->ammo));
	else
		ent->client->ammo_index = 0;

	if (!ent->client->pers.weapon)
	{	// dead
		ent->client->ps.gunindex = 0;
		return;
	}

	ent->client->weaponstate = WEAPON_ACTIVATING;
	ent->client->ps.gunframe = 0;
	ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);

	ent->client->anim_priority = ANIM_PAIN;
	if(ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
			ent->s.frame = FRAME_crpain1;
			ent->client->anim_end = FRAME_crpain4;
	}
	else
	{
			ent->s.frame = FRAME_pain301;
			ent->client->anim_end = FRAME_pain304;

	}
	//TROND VWEP
	//ent->s.modelindex2 = gi.modelindex ("players/team1/w_mariner.md2");
}

/*
=================
NoAmmoWeaponChange
=================
*/
void NoAmmoWeaponChange (edict_t *ent)
{
	//TROND bugfix
/*	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("slugs"))]
		&&  ent->client->pers.inventory[ITEM_INDEX(FindItem("railgun"))] )
	{
		ent->client->newweapon = FindItem ("railgun");
		return;
	}
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("1911clip"))]
		&&  ent->client->pers.inventory[ITEM_INDEX(FindItem("hyperblaster"))] )
	{
		ent->client->newweapon = FindItem ("hyperblaster");
		return;
	}
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))]//TROND RELOAD var bullets
		&&  ent->client->pers.inventory[ITEM_INDEX(FindItem("chaingun"))] )
	{
		ent->client->newweapon = FindItem ("chaingun");
		return;
	}
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))]//TROND RELOAD var bullets
		&&  ent->client->pers.inventory[ITEM_INDEX(FindItem("UZI"))] )
	{
		ent->client->newweapon = FindItem ("machinegun");
		return;
	}
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERshells"))] > 1
		&&  ent->client->pers.inventory[ITEM_INDEX(FindItem("super shotgun"))] )
	{
		ent->client->newweapon = FindItem ("super shotgun");
		return;
	}
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERshells"))]
		&&  ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINER"))] )//TROND var Shotgun
	{
		ent->client->newweapon = FindItem ("shotgun");
		return;
	}*/
	//TROND slutt
	//TROND tatt vekk 16/4
/*	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("1911"))])
		ent->client->newweapon = FindItem("1911");
	else*/
		ent->client->newweapon = FindItem("Bush Knife");
}

/*
=================
Think_Weapon

Called by ClientBeginServerFrame and ClientThink
=================
*/
void Think_Weapon (edict_t *ent)
{
	// if just died, put the weapon away
	if (ent->health < 1)
	{
		ent->client->newweapon = NULL;
		ChangeWeapon (ent);
	}

	// call active weapon think routine
	if (ent->client->pers.weapon && ent->client->pers.weapon->weaponthink)
	{
		is_quad = (ent->client->quad_framenum > level.framenum);
		if (ent->client->silencer_shots)
			is_silenced = MZ_SILENCED;
		else
			is_silenced = 0;
		ent->client->pers.weapon->weaponthink (ent);
	}
}


/*
================
Use_Weapon

Make the weapon ready if there is ammo
================
*/
void Use_Weapon (edict_t *ent, gitem_t *item)
{
	int			ammo_index;
	gitem_t		*ammo_item;

	// see if we're already using it
	if (item == ent->client->pers.weapon)
		return;

	if (item->ammo && !g_select_empty->value && !(item->flags & IT_AMMO))
	{
		ammo_item = FindItem(item->ammo);
		ammo_index = ITEM_INDEX(ammo_item);

		//TROND
		//SLIK AT DET GÅR AN Å VELGE VÅPEN SOM ER TOMME FOR AMMO
		//if (!ent->client->pers.inventory[ammo_index])
		//{
		//	gi.cprintf (ent, PRINT_HIGH, "No %s for %s.\n", ammo_item->pickup_name, item->pickup_name);
		//	return;
		//}

		//if (ent->client->pers.inventory[ammo_index] < item->quantity)
		//{
		//	gi.cprintf (ent, PRINT_HIGH, "Not enough %s for %s.\n", ammo_item->pickup_name, item->pickup_name);
		//	return;
		//}
		//TROND slutt
	}

	// change to this weapon when down
	ent->client->newweapon = item;
}



/*
================
Drop_Weapon
================
*/
//TROND
//SLEPP VÅPEN HACK
/*
void Drop_Weapon (edict_t *ent, gitem_t *item)
{
	int		index;

	if ((int)(dmflags->value) & DF_WEAPONS_STAY)
		return;

	index = ITEM_INDEX(item);
	// see if we're already using it
	if ( ((item == ent->client->pers.weapon) || (item == ent->client->newweapon)) && (ent->client->pers.inventory[index] == 1) )
	{
		gi.cprintf (ent, PRINT_HIGH, "No can do, I`m using this weapon!\n");
		return;
	}

	Drop_Item (ent, item);
	ent->client->pers.inventory[index]--;
}
*/
void Drop_Weapon (edict_t *ent, gitem_t *item, int FRAME_DEACTIVATE_LAST)
{
	int		index;

	if ((int)(dmflags->value) & DF_WEAPONS_STAY)
		return;

	index = ITEM_INDEX(item);
	// see if we're already using it
	if ( ((item == ent->client->pers.weapon) || (item == ent->client->newweapon))&& (ent->client->pers.inventory[index] == 1) && ent->client->weaponstate == WEAPON_READY)
	{
		ent->client->ps.gunframe == 0;
		ent->client->ps.gunindex = 0;
		ent->client->zoom = 0;
		ent->client->newweapon = FindItem ("1911");
		Drop_Item (ent, item);
		ent->client->pers.inventory[index]--;
		return;
	}

}
//TROND slutt*/

/*
================
Weapon_Generic

A generic function to handle the basics of weapon thinking
================
*/
#define FRAME_FIRE_FIRST		(FRAME_ACTIVATE_LAST + 1)
#define FRAME_IDLE_FIRST		(FRAME_FIRE_LAST + 1)
#define FRAME_DEACTIVATE_FIRST	(FRAME_IDLE_LAST + 1)

//TROND
//RELOAD
#define FRAME_RELOAD_FIRST		(FRAME_DEACTIVATE_LAST + 1)
#define FRAME_ENDMAG_FIRST		(FRAME_RELOAD_LAST + 1)
//TROND slutt

void Weapon_Generic2 (edict_t *ent, int FRAME_ACTIVATE_LAST, int FRAME_FIRE_LAST, int FRAME_IDLE_LAST, int FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/int FRAME_RELOAD_LAST, int FRAME_ENDMAG_LAST,/*TROND slutt*/ int *pause_frames, int *fire_frames, void (*fire)(edict_t *ent))
{
	int		n;

	//TROND
	//BLØ
	if (ent->client->weaponstate == WEAPON_HOLSTERED)
	{
		if (ent->client->ps.gunframe < FRAME_DEACTIVATE_FIRST && ent->client->ps.gunframe > 2) 
		{
			ent->client->ps.gunframe = FRAME_DEACTIVATE_FIRST;
			return;
		}
		
		if (ent->client->ps.gunframe > FRAME_DEACTIVATE_LAST - 1)
		{
			ent->client->ps.gunframe = FRAME_DEACTIVATE_LAST;
			return;
		}

		ent->client->ps.gunframe++;
	}
	//TROND slutt

	//TROND
	//RELOAD	

	if (ent->client->weaponstate == WEAPON_RELOADING)
	{
		//1911
		if (ent->client->pers.weapon == FindItem("1911"))//TROND var Blaster
		{
			if (ent->client->ps.gunframe < FRAME_RELOAD_FIRST || ent->client->ps.gunframe > FRAME_RELOAD_FIRST + 21)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = FRAME_RELOAD_FIRST;
			}
				
			if (ent->client->ps.gunframe > FRAME_RELOAD_FIRST + 20 && ent->client->ps.gunframe < FRAME_RELOAD_FIRST + 22)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))] = 8;
				ent->client->ps.gunframe = FRAME_IDLE_FIRST;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}

		//UZI
		else if (ent->client->pers.weapon == FindItem("UZI"))
		{
			if (ent->client->ps.gunframe < 52 || ent->client->ps.gunframe > 71)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 52;
			}
				
			if (ent->client->ps.gunframe > 69 && ent->client->ps.gunframe < 71)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIrounds"))] = 30;
				ent->client->ps.gunframe = 13;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}

		//HAGLE
		else if (ent->client->pers.weapon == FindItem("MARINER"))//TROND var Shotgun
		{
			if (ent->client->ps.gunframe < 42 || ent->client->ps.gunframe > 53)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 42;
			}
				
			if (ent->client->ps.gunframe > 52 && ent->client->ps.gunframe < 58)
			{
				if (ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERrounds"))] < 9)
					ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERrounds"))] += 1;
				ent->client->ps.gunframe = 16;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}

		//RIFLE
		else if (ent->client->pers.weapon == FindItem("BARRETT"))
		{
			if (ent->client->ps.gunframe < 42 || ent->client->ps.gunframe > 58)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 42;
			}
				
			if (ent->client->ps.gunframe == 58)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))] = 10;
				ent->client->ps.gunframe = 22;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}

		//AK47
		else if (ent->client->pers.weapon == FindItem("AK 47"))
		{
			if (ent->client->ps.gunframe < 45 || ent->client->ps.gunframe > 63)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 45;
			}
				
			if (ent->client->ps.gunframe > 62 && ent->client->ps.gunframe < 64)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("AK47rounds"))] = 40;
				ent->client->ps.gunframe = 13;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->machinegun_shots = 0;//TROND hev våpen

			ent->client->ps.gunframe++;
			return;
		}

		//GLOCK
		else if (ent->client->pers.weapon == FindItem("glock"))//TROND var Blaster
		{
			if (ent->client->ps.gunframe < 41 || ent->client->ps.gunframe > 41 + 21)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 41;
			}
				
			if (ent->client->ps.gunframe > 41 + 20 && ent->client->ps.gunframe < 41 + 22)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))] = 17;
				ent->client->ps.gunframe = FRAME_IDLE_FIRST;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}

		//CASULL
		else if (ent->client->pers.weapon == FindItem("casull"))//TROND var Blaster
		{
			if (ent->client->ps.gunframe < 38 || ent->client->ps.gunframe > 58)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 38;
			}
				
			if (ent->client->ps.gunframe > 57 && ent->client->ps.gunframe < 59)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))] += 1;
				ent->client->ps.gunframe = FRAME_IDLE_FIRST;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}

		//BERETTA
		else if (ent->client->pers.weapon == FindItem("beretta"))//TROND var Blaster
		{
			if (ent->client->ps.gunframe < 41 || ent->client->ps.gunframe > 41 + 21)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 41;
			}
				
			if (ent->client->ps.gunframe > 41 + 20 && ent->client->ps.gunframe < 41 + 22)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))] = 15;
				ent->client->ps.gunframe = FRAME_IDLE_FIRST;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}
		//MP5
		else if (ent->client->pers.weapon == FindItem("mp5"))
		{
			if (ent->client->ps.gunframe < 52 || ent->client->ps.gunframe > 71)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 52;
			}
				
			if (ent->client->ps.gunframe > 69 && ent->client->ps.gunframe < 71)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))] = 32;
				ent->client->ps.gunframe = 13;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}
		//M60
		else if (ent->client->pers.weapon == FindItem("m60"))
		{
			if (ent->client->ps.gunframe < 42 || ent->client->ps.gunframe > 82)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 42;
			}
				
			if (ent->client->ps.gunframe == 82)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))] = ent->client->pers.inventory[ITEM_INDEX(FindItem("m60ammo"))];
				ent->client->pers.inventory[ITEM_INDEX(FindItem("m60ammo"))] = 0;
				ent->client->ps.gunframe = 13;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}
		//MSG90
		else if (ent->client->pers.weapon == FindItem("msg90"))
		{
			if (ent->client->ps.gunframe < 45 || ent->client->ps.gunframe > 69)// || ent->client->ps.gunframe > FRAME_END_MAG)
			{	
				ent->client->ps.gunframe = 45;
			}
				
			if (ent->client->ps.gunframe == 69)
			{
				ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))] = 20;
				ent->client->ps.gunframe = 13;
				ent->client->weaponstate = WEAPON_READY;
				return;
			}

			ent->client->ps.gunframe++;
			return;
		}
	}
	//TROND slutt

	if(ent->deadflag || ent->s.modelindex != 255) // VWep animations screw up corpses
	{
		return;
	}

	if (ent->client->weaponstate == WEAPON_DROPPING)
	{
		if (ent->client->ps.gunframe == FRAME_DEACTIVATE_LAST)
		{
			ChangeWeapon (ent);
			return;
		}
		else if ((FRAME_DEACTIVATE_LAST - ent->client->ps.gunframe) == 4)
		{
			ent->client->anim_priority = ANIM_REVERSE;
			if(ent->client->ps.pmove.pm_flags & PMF_DUCKED)
			{
				ent->s.frame = FRAME_crpain4+1;
				ent->client->anim_end = FRAME_crpain1;
			}
			else
			{
				ent->s.frame = FRAME_pain304+1;
				ent->client->anim_end = FRAME_pain301;

			}
		}

		ent->client->ps.gunframe++;
		return;
	}

	if (ent->client->weaponstate == WEAPON_ACTIVATING)
	{
		//TROND
		//RELOAD
	
		//1911
		if (ent->client->pers.weapon == FindItem("1911") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))]))//TROND var Blaster
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST - 3)
			{
				ent->client->ps.gunframe = 68;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}

		//UZI
		if (ent->client->pers.weapon == FindItem("UZI") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIrounds"))]))
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
			{
				ent->client->ps.gunframe = 77;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}

		//HAGLE							TROND var Shotgun
		if (ent->client->pers.weapon == FindItem("MARINER") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERrounds"))]))
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
			{
				ent->client->ps.gunframe = 60;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}

		//RIFLE
		if (ent->client->pers.weapon == FindItem("BARRETT") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))]))
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
			{
				ent->client->ps.gunframe = 59;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}

		//AK 47
		if (ent->client->pers.weapon == FindItem("AK 47") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("AK47rounds"))]))
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
			{
				ent->client->ps.gunframe = 71;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}

		//GLOCK
		if (ent->client->pers.weapon == FindItem("glock") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))]))//TROND var Blaster
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST - 3)
			{
				ent->client->ps.gunframe = 65;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}

		//CASULL
		if (ent->client->pers.weapon == FindItem("casull") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))]))//TROND var Blaster
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
			{
				ent->client->ps.gunframe = 60;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}

		//BERETTA
		if (ent->client->pers.weapon == FindItem("beretta") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))]))//TROND var Blaster
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST - 2)
			{
				ent->client->ps.gunframe = 65;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}
		//MP5
		if (ent->client->pers.weapon == FindItem("mp5") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))]))
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
			{
				ent->client->ps.gunframe = 77;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}
		//M60
		if (ent->client->pers.weapon == FindItem("m60") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))]))
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
			{
				ent->client->ps.gunframe = 83;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}
		//MSG90
		if (ent->client->pers.weapon == FindItem("msg90") && !(ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))]))
		{
			if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
			{
				ent->client->ps.gunframe = 77;
				ent->client->weaponstate = WEAPON_READY;
//				ent->client->ps.gunframe++;
				return;
			}
		}
		
		//TROND slutt

			
		if (ent->client->ps.gunframe == FRAME_ACTIVATE_LAST)
		{	
			ent->client->weaponstate = WEAPON_READY;
			ent->client->ps.gunframe = FRAME_IDLE_FIRST;
			return;
		}
		

		ent->client->ps.gunframe++;
		return;	
	}

	if ((ent->client->newweapon) && (ent->client->weaponstate != WEAPON_FIRING))
	{
		ent->client->weaponstate = WEAPON_DROPPING;
		ent->client->ps.gunframe = FRAME_DEACTIVATE_FIRST;

		if ((FRAME_DEACTIVATE_LAST - FRAME_DEACTIVATE_FIRST) < 4)
		{
			ent->client->anim_priority = ANIM_REVERSE;
			if(ent->client->ps.pmove.pm_flags & PMF_DUCKED)
			{
				ent->s.frame = FRAME_crpain4+1;
				ent->client->anim_end = FRAME_crpain1;
			}
			else
			{
				ent->s.frame = FRAME_pain304+1;
				ent->client->anim_end = FRAME_pain301;

			}
		}
		return;
	}

	if (ent->client->weaponstate == WEAPON_READY)
	{
		//TROND
		//RELOAD
		//1911
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))])
			&& ent->client->pers.weapon == FindItem("1911"))
		{
			ent->client->ps.gunframe = 68;
//			return;
		}
		//UZI
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIrounds"))])
			&& ent->client->pers.weapon == FindItem("UZI"))
		{
			ent->client->ps.gunframe = 77;
//			return;
		}
		//HAGLE
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERrounds"))])
			&& ent->client->pers.weapon == FindItem("MARINER"))
		{
			ent->client->ps.gunframe = 60;
//			return;
		}
		//RIFLE
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))])
			&& ent->client->pers.weapon == FindItem("BARRETT"))
		{
			ent->client->ps.gunframe = 59;
//			return;
		}
		//AK 47
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47rounds"))])
			&& ent->client->pers.weapon == FindItem("AK 47"))
		{
			ent->client->ps.gunframe = 71;
//			return;
		}
		//GLOCK
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))])
			&& ent->client->pers.weapon == FindItem("glock"))
		{
			ent->client->ps.gunframe = 65;
//			return;
		}
		//CASULL
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))])
			&& ent->client->pers.weapon == FindItem("casull"))
		{
			ent->client->ps.gunframe = 60;
//			return;
		}
		//BERETTA
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))])
			&& ent->client->pers.weapon == FindItem("beretta"))
		{
			ent->client->ps.gunframe = 65;
//			return;
		}
		//MP5
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))])
			&& ent->client->pers.weapon == FindItem("mp5"))
		{
			ent->client->ps.gunframe = 77;
//			return;
		}
		//M60
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))])
			&& ent->client->pers.weapon == FindItem("m60"))
		{
			ent->client->ps.gunframe = 83;
//			return;
		}
		//MSG90
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))])
			&& ent->client->pers.weapon == FindItem("msg90"))
		{
			ent->client->ps.gunframe = 77;
//			return;
		}

		//TROND slutt

		if ( ((ent->client->latched_buttons|ent->client->buttons) & BUTTON_ATTACK) )
		{
			ent->client->latched_buttons &= ~BUTTON_ATTACK;
			if ((!ent->client->ammo_index) ||
				( ent->client->pers.inventory[ent->client->ammo_index] >= ent->client->pers.weapon->quantity))
			{
				ent->client->ps.gunframe = FRAME_FIRE_FIRST;
				ent->client->weaponstate = WEAPON_FIRING;

				// start the animation
				ent->client->anim_priority = ANIM_ATTACK;
				if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
				{
					ent->s.frame = FRAME_crattak1-1;
					ent->client->anim_end = FRAME_crattak9;
				}
				else
				{
					ent->s.frame = FRAME_attack1-1;
					ent->client->anim_end = FRAME_attack8;
				}
			}
			else
			{
				if (level.time >= ent->pain_debounce_time)
				{
					gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
					ent->pain_debounce_time = level.time + 0.7;//1; TROND
				}
				//TROND
				//SLIK AT EIN MÅ BYTTE VÅPEN MANUELT
				//NoAmmoWeaponChange (ent);
				//TROND slutt
			}
		}
		else
		{
			if (ent->client->ps.gunframe == FRAME_IDLE_LAST)
			{
				ent->client->ps.gunframe = FRAME_IDLE_FIRST;
				return;
			}

			if (pause_frames)
			{
				for (n = 0; pause_frames[n]; n++)
				{
					if (ent->client->ps.gunframe == pause_frames[n])
					{
						if (rand()&15)
							return;
					}
				}
			}
//TROND reload bug fix idle frames
			if (ent->client->pers.inventory[ent->client->ammo_index] > 0
				|| (ent->client->pers.weapon == FindItem("Bush Knife") 
				|| ent->client->pers.weapon == FindItem("Detonator")))
//TROND slutt
				ent->client->ps.gunframe++;
			return;
		}
	}

	if (ent->client->weaponstate == WEAPON_FIRING)
	{
		for (n = 0; fire_frames[n]; n++)
		{
			if (ent->client->ps.gunframe == fire_frames[n])
			{
//ZOID
				if (!CTFApplyStrengthSound(ent))
//ZOID
					if (ent->client->quad_framenum > level.framenum)
						gi.sound(ent, CHAN_ITEM, gi.soundindex("items/damage3.wav"), 1, ATTN_NORM, 0);

//ZOID
				CTFApplyHasteSound(ent);
//ZOID

				fire (ent);
				break;
			}
		}

		if (!fire_frames[n])
			ent->client->ps.gunframe++;

		//TROND
		//RELOAD
		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))]))
		{
			//1911
			if (ent->client->pers.weapon == FindItem("1911"))//TROND var Blaster
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST - 1)
				{
					ent->client->ps.gunframe = 68;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIrounds"))]))
		{
			//UZI
			if (ent->client->pers.weapon == FindItem("UZI"))
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST - 1)
				{
					ent->client->ps.gunframe = 77;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERrounds"))]))
		{
			//HAGLE
			if (ent->client->pers.weapon == FindItem("MARINER"))//TROND var Shotgun
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST - 1)
				{
					ent->client->ps.gunframe = 60;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))]))
		{
			//RIFLE
			if (ent->client->pers.weapon == FindItem("BARRETT"))
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST - 1)
				{
					ent->client->ps.gunframe = 59;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47rounds"))]))
		{
			//AK 47
			if (ent->client->pers.weapon == FindItem("AK 47"))
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST - 1)
				{
					ent->client->ps.gunframe = 71;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))]))
		{
			//GLOCK
			if (ent->client->pers.weapon == FindItem("glock"))//TROND var Blaster
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST)
				{
					ent->client->ps.gunframe = 65;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))]))
		{
			//CASULL
			if (ent->client->pers.weapon == FindItem("casull"))//TROND var Blaster
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST)
				{
					ent->client->ps.gunframe = 60;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))]))
		{
			//BERETTA
			if (ent->client->pers.weapon == FindItem("beretta"))//TROND var Blaster
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST + 1)
				{
					ent->client->ps.gunframe = 65;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))]))
		{
			//MP5
			if (ent->client->pers.weapon == FindItem("mp5"))
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST - 1)
				{
					ent->client->ps.gunframe = 77;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))]))
		{
			//M60
			if (ent->client->pers.weapon == FindItem("m60"))
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST - 1)
				{
					ent->client->ps.gunframe = 83;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}

		if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))]))
		{
			//MSG90
			if (ent->client->pers.weapon == FindItem("msg90"))
			{
				if (ent->client->ps.gunframe == FRAME_FIRE_LAST - 1)
				{
					ent->client->ps.gunframe = 77;
					ent->client->weaponstate = WEAPON_READY;
				}
			}
		}
		//TROND slutt

		if (ent->client->ps.gunframe == FRAME_IDLE_FIRST+1)
			ent->client->weaponstate = WEAPON_READY;
	}
}

//ZOID
void Weapon_Generic (edict_t *ent, int FRAME_ACTIVATE_LAST, int FRAME_FIRE_LAST, int FRAME_IDLE_LAST, int FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/int FRAME_RELOAD_LAST, int FRAME_ENDMAG_LAST,/*TROND slutt*/int *pause_frames, int *fire_frames, void (*fire)(edict_t *ent))
{
	int oldstate = ent->client->weaponstate;

	Weapon_Generic2 (ent, FRAME_ACTIVATE_LAST, FRAME_FIRE_LAST,
		FRAME_IDLE_LAST, FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/FRAME_RELOAD_LAST, FRAME_ENDMAG_LAST,/*TROND slutt*/ pause_frames,
		fire_frames, fire);

	// run the weapon frame again if hasted
	if (strcmp(ent->client->pers.weapon->pickup_name, "Grapple") == 0 &&
		ent->client->weaponstate == WEAPON_FIRING)
		return;

	if ((CTFApplyHaste(ent) ||
		(Q_stricmp(ent->client->pers.weapon->pickup_name, "Grapple") == 0 &&
		ent->client->weaponstate != WEAPON_FIRING))
		&& oldstate == ent->client->weaponstate) {
		Weapon_Generic2 (ent, FRAME_ACTIVATE_LAST, FRAME_FIRE_LAST,
			FRAME_IDLE_LAST, FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/FRAME_RELOAD_LAST, FRAME_ENDMAG_LAST,/*TROND slutt*/ pause_frames,
			fire_frames, fire);
	}
}
//ZOID

/*
======================================================================

GRENADE

======================================================================
*/

#define GRENADE_TIMER		1.5//TROND var 3.0
#define GRENADE_MINSPEED	300//TROND var 400
#define GRENADE_MAXSPEED	400//TROND var 800

void weapon_grenade_fire (edict_t *ent, qboolean held)
{
	vec3_t	offset;
	vec3_t	forward, right;
	vec3_t	start;
	int		damage = 400;//TROND var 125
	float	timer;
	int		speed;
	float	radius;

	radius = damage+80;//TROND var 40
//	if (is_quad)//TROND tatt vekk
//		damage *= 4;//TROND tatt vekk

	VectorSet(offset, 8, 8, ent->viewheight-8);
	AngleVectors (ent->client->v_angle, forward, right, NULL);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	timer = ent->client->grenade_time - level.time;
	speed = GRENADE_MINSPEED + (GRENADE_TIMER - timer) * ((GRENADE_MAXSPEED - GRENADE_MINSPEED) / GRENADE_TIMER);
	//TROND granat distanse
	if (ent->client->distance == 0)
		fire_grenade2 (ent, start, forward, damage, 300, timer, radius, held);
	else if (ent->client->distance == 1)
		fire_grenade2 (ent, start, forward, damage, 450, timer, radius, held);
	else if (ent->client->distance == 2)
		fire_grenade2 (ent, start, forward, damage, 600, timer, radius, held);
//	fire_grenade2 (ent, start, forward, damage, speed, timer, radius, held);
	//TROND slutt
	ent->client->pin_pulled = 0;//TROND
//	gi.cprintf (ent, PRINT_HIGH, "%i pin pulled\n", ent->client->pin_pulled);

	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index]--;

	ent->client->grenade_time = level.time + 1.0;

	if(ent->deadflag || ent->s.modelindex != 255) // VWep animations screw up corpses
	{
		return;
	}

	if (ent->health <= 0)
		return;

	if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		ent->client->anim_priority = ANIM_ATTACK;
		ent->s.frame = FRAME_crattak1-1;
		ent->client->anim_end = FRAME_crattak3;
	}
	else
	{
		ent->client->anim_priority = ANIM_REVERSE;
		ent->s.frame = FRAME_wave08;
		ent->client->anim_end = FRAME_wave01;
	}

	NoAmmoWeaponChange (ent);//TROND granat mekk
}

//TROND
//HEILT NY GRANAT FUNKSJON
void Weapon_Grenade (edict_t *ent)
{
	if ((ent->client->newweapon) && (ent->client->weaponstate == WEAPON_READY))
	{
		ChangeWeapon (ent);
		return;
	}

	if (ent->client->weaponstate == WEAPON_ACTIVATING)
	{
		ent->client->weaponstate = WEAPON_READY;
		ent->client->ps.gunframe = 1;
		return;
	}
	
	if (ent->client->weaponstate == WEAPON_READY)
	{
		ent->client->ps.gunframe++;
		if (ent->client->ps.gunframe >= 1
			&& ent->client->ps.gunframe < 10) 
			ent->client->ps.gunframe = 10;
		if (ent->client->ps.gunframe >= 10
			&& ent->client->ps.gunframe < 40)
		{
			ent->client->ps.gunframe++;
		}
		if (ent->client->ps.gunframe >= 38 
			&& ent->client->ps.gunframe < 40)
		{
			ent->client->ps.gunframe = 10;
		}
//		ent->client->ps.gunframe = 10;
//		ent->client->ps.gunframe++;
		if ( ((ent->client->latched_buttons|ent->client->buttons) & BUTTON_ATTACK) 
			&& ent->client->ps.gunframe > 10)
		{
			ent->client->latched_buttons &= ~BUTTON_ATTACK;
			if (ent->client->pers.inventory[ent->client->ammo_index])
			{
				ent->client->ps.gunframe = 72;
				ent->client->weaponstate = WEAPON_FIRING;
				ent->client->grenade_time = 0;
				return;
			}
		}
	}

	if(ent->client->ps.gunframe == 75)
	{
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/grenade_pinout.wav"), 1, ATTN_NORM, 0);
//		gi.cprintf(ent, PRINT_HIGH, "Pin pulled\n");
		ent->client->pin_pulled = 1;
	}

	if (ent->client->weaponstate == WEAPON_FIRING)
	{
		if (ent->client->ps.gunframe >= 72)
			ent->client->ps.gunframe++;
		if (ent->client->ps.gunframe >= 79)
		{
			ent->client->ps.gunframe = 40;
		}
		if (( ((ent->client->latched_buttons|ent->client->buttons) & BUTTON_ATTACK))  
			&& (ent->client->ps.gunframe >= 40) 
			&& ent->client->ps.gunframe < 72)
		{
			ent->client->ps.gunframe++;
		}

		if (( ((ent->client->latched_buttons|ent->client->buttons) & BUTTON_ATTACK))  
			&& (ent->client->ps.gunframe == 69) )
		{
			ent->client->ps.gunframe = 40;
		}

		if (!( ((ent->client->latched_buttons|ent->client->buttons) & BUTTON_ATTACK))  
			&& (ent->client->ps.gunframe >= 40) 
			&& ent->client->ps.gunframe < 72)
		{
			ent->client->ps.gunframe = 4;
		}

	//	if (!( ((ent->client->latched_buttons|ent->client->buttons) & BUTTON_ATTACK))  
		if	((ent->client->ps.gunframe >= 4) 
			&& ent->client->ps.gunframe < 72)
		{
			if ((ent->client->ps.gunframe > 40
				&& ent->client->ps.gunframe < 70)
				|| (ent->client->ps.gunframe >= 4
				&& ent->client->ps.gunframe < 10))
				ent->client->ps.gunframe++;
			if (ent->client->ps.gunframe == 69)
				ent->client->ps.gunframe = 40;

			if (!ent->client->grenade_time)
			{
				ent->client->grenade_time = level.time + GRENADE_TIMER + 0.2;
			}

/*
			if (ent->client->buttons & BUTTON_ATTACK)
				return;

			if (ent->client->grenade_blew_up)
			{
				if (level.time >= ent->client->grenade_time)
				{
	//				ent->client->ps.gunframe = 6;
						ent->client->ps.gunframe++;
					ent->client->grenade_blew_up = false;
				}
				else
				{
					return;
				}
			}*/
		}

		if (ent->client->ps.gunframe == 7)
		{
			ent->client->weapon_sound = 0;
			weapon_grenade_fire (ent, false);
			ent->client->ps.gunframe++;
			ent->client->weight += 5;
			return;
		}

		if ((ent->client->ps.gunframe == 9) && (level.time < ent->client->grenade_time))
			return;

//		ent->client->ps.gunframe++;

		if (ent->client->ps.gunframe == 10)
		{
			ent->client->grenade_time = 0;
			ent->client->weaponstate = WEAPON_READY;
		}
	}
	if (ent->client->weaponstate == WEAPON_HOLSTERED)
	{
		ent->client->ps.gunframe = 71;
	}
}

/*		if (!( ((ent->client->latched_buttons|ent->client->buttons) & BUTTON_ATTACK))  
			&& (ent->client->ps.gunframe == 40))
		{
				ent->client->ps.gunframe = 4;
		}
		if (ent->client->ps.gunframe >= 4 
			&& ent->client->ps.gunframe < 10)
		{
			if (ent->client->ps.gunframe == 6)
				weapon_grenade_fire (ent, false);
			ent->client->ps.gunframe++;
			return;
		}
		else if (ent->client->ps.gunframe == 10)
			ent->client->weaponstate = WEAPON_READY;
	}
}
//TROND slutt*/

void Weapon_Grenade_Old (edict_t *ent)
{
	if ((ent->client->newweapon) && (ent->client->weaponstate == WEAPON_READY))
	{
		ChangeWeapon (ent);
		return;
	}

	if (ent->client->weaponstate == WEAPON_ACTIVATING)
	{
		ent->client->weaponstate = WEAPON_READY;
		ent->client->ps.gunframe = 16;
		return;
	}

	if (ent->client->weaponstate == WEAPON_READY)
	{
		if ( ((ent->client->latched_buttons|ent->client->buttons) & BUTTON_ATTACK) )
		{
			ent->client->latched_buttons &= ~BUTTON_ATTACK;
			if (ent->client->pers.inventory[ent->client->ammo_index])
			{
				ent->client->ps.gunframe = 1;
				ent->client->weaponstate = WEAPON_FIRING;
				ent->client->grenade_time = 0;
			}
			else
			{
				if (level.time >= ent->pain_debounce_time)
				{
					gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
					ent->pain_debounce_time = level.time + 1;
				}
				NoAmmoWeaponChange (ent);
			}
			return;
		}

		if ((ent->client->ps.gunframe == 29) || (ent->client->ps.gunframe == 34) || (ent->client->ps.gunframe == 39) || (ent->client->ps.gunframe == 48))
		{
			if (rand()&15)
				return;
		}

		if (++ent->client->ps.gunframe > 48)
			ent->client->ps.gunframe = 16;
		return;
	}

	if (ent->client->weaponstate == WEAPON_FIRING)
	{
		if (ent->client->ps.gunframe == 5)
			gi.sound(ent, CHAN_WEAPON, gi.soundindex("weapons/hgrena1b.wav"), 1, ATTN_NORM, 0);

		if (ent->client->ps.gunframe == 11)
		{
			if (!ent->client->grenade_time)
			{
				ent->client->grenade_time = level.time + GRENADE_TIMER + 0.2;
//				ent->client->weapon_sound = gi.soundindex("weapons/hgrenc1b.wav");//TROND tatt vekk pga kul lyd
			}

			/*TROND
			//GRANATEN SPRENGER IKKJE I HÅNDA DI
			// they waited too long, detonate it in their hand
			if (!ent->client->grenade_blew_up && level.time >= ent->client->grenade_time)
			{
				ent->client->weapon_sound = 0;
				weapon_grenade_fire (ent, true);
				ent->client->grenade_blew_up = true;
			}
			//TROND slutt*/

			if (ent->client->buttons & BUTTON_ATTACK)
				return;

			if (ent->client->grenade_blew_up)
			{
				if (level.time >= ent->client->grenade_time)
				{
					ent->client->ps.gunframe = 15;
					ent->client->grenade_blew_up = false;
				}
				else
				{
					return;
				}
			}
		}

		if (ent->client->ps.gunframe == 12)
		{
			ent->client->weapon_sound = 0;
			weapon_grenade_fire (ent, false);
		}

		if ((ent->client->ps.gunframe == 15) && (level.time < ent->client->grenade_time))
			return;

		ent->client->ps.gunframe++;

		if (ent->client->ps.gunframe == 16)
		{
			ent->client->grenade_time = 0;
			ent->client->weaponstate = WEAPON_READY;
		}
	}
}

/*
======================================================================

GRENADE LAUNCHER

======================================================================
*/

void weapon_grenadelauncher_fire (edict_t *ent)
{
	vec3_t	offset;
	vec3_t	forward, right;
	vec3_t	start;
	int		damage = 120;
	float	radius;

	radius = damage+40;
	if (is_quad)
		damage *= 4;

	VectorSet(offset, 8, 8, ent->viewheight-8);
	AngleVectors (ent->client->v_angle, forward, right, NULL);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	VectorScale (forward, -2, ent->client->kick_origin);
	ent->client->kick_angles[0] = -1;

	fire_grenade (ent, start, forward, damage, 600, 2.5, radius);

	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_GRENADE | is_silenced);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	ent->client->ps.gunframe++;

	PlayerNoise(ent, start, PNOISE_WEAPON);

	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index]--;
}

void Weapon_GrenadeLauncher (edict_t *ent)
{
	static int	pause_frames[]	= {34, 51, 59, 0};
	static int	fire_frames[]	= {6, 0};

	Weapon_Generic (ent, 5, 16, 59, 64,/*TROND RELOAD*/0, 0, pause_frames, fire_frames, weapon_grenadelauncher_fire);
}

/*
======================================================================

ROCKET

======================================================================
*/

void Weapon_RocketLauncher_Fire (edict_t *ent)
{
	vec3_t	offset, start;
	vec3_t	forward, right;
	int		damage;
	float	damage_radius;
	int		radius_damage;
	//TROND
	//GÅR IKKJE AN Å AVFYRE I FART
	if ((ent->client->ps.pmove.pm_flags & PMF_DUCKED) && !(ent->velocity[0] || ent->velocity[1]))
	{

	damage = 200 + (int)(random() * 20.0);//TROND damage = 100 + etc
	radius_damage = 120;
	damage_radius = 120;
	if (is_quad)
	{
		damage *= 4;
		radius_damage *= 4;
	}

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -2, ent->client->kick_origin);
	ent->client->kick_angles[0] = -1;

	VectorSet(offset, 8, 8, ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

		fire_rocket (ent, start, forward, damage, 650, damage_radius, radius_damage);
	
		// send muzzle flash
		gi.WriteByte (svc_muzzleflash);
		gi.WriteShort (ent-g_edicts);
		gi.WriteByte (MZ_ROCKET | is_silenced);
		gi.multicast (ent->s.origin, MULTICAST_PVS);

		ent->client->ps.gunframe++;
	
		PlayerNoise(ent, start, PNOISE_WEAPON);

		if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
			ent->client->pers.inventory[ent->client->ammo_index]--;
	}
	else
	{
		gi.centerprintf (ent, "I don`t think firing this at speed\n would be such a great idea\n");
		ent->client->weaponstate = WEAPON_READY;
		ent->client->ps.gunframe = 12;
		ent->client->ps.gunframe++;
	}
	//TROND slutt

}

void Weapon_RocketLauncher (edict_t *ent)
{
	static int	pause_frames[]	= {25, 33, 42, 50, 0};
	static int	fire_frames[]	= {5, 0};

	Weapon_Generic (ent, 4, 12, 50, 54, 0, 0, pause_frames, fire_frames, Weapon_RocketLauncher_Fire);
}


/*
======================================================================

BLASTER / HYPERBLASTER

======================================================================
*/

void Blaster_Fire (edict_t *ent, vec3_t g_offset, int damage, qboolean hyper, int effect)
{
	vec3_t	forward, right;
	vec3_t	start;
	vec3_t	offset;

	if (is_quad)
		damage *= 4;
	AngleVectors (ent->client->v_angle, forward, right, NULL);
	VectorSet(offset, 24, 8, ent->viewheight-8);
	VectorAdd (offset, g_offset, offset);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	VectorScale (forward, -2, ent->client->kick_origin);
	ent->client->kick_angles[0] = -1;

	fire_blaster (ent, start, forward, damage, 1000, effect, hyper);

	/*TROND
	//PIL OG BUE tar vekk muzzleflash
	// send muzzle flash
	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	if (hyper)
		gi.WriteByte (MZ_HYPERBLASTER | is_silenced);
	else
		gi.WriteByte (MZ_BLASTER | is_silenced);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, start, PNOISE_WEAPON);
	//TROND slutt */
}


void Weapon_Blaster_Fire (edict_t *ent)
//TROND
//BYTTER UT BLASTERKULER MED MASKINGEVÆRKULER
{
//	int	i;
	vec3_t		start;
	vec3_t		forward, right;
//	vec3_t		angles;
	//TROND
	//TAR VEKK DAMAGE PGA LOCAL DAMAGE
	int			damage = 51;//VAR FØR "damage = 8"
	//TROND slutt
	int			kick = 145;
	vec3_t		offset;

	ent->client->ps.gunframe++;


	if (ent->client->pers.inventory[ent->client->ammo_index] < 1)
	{
		gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
		ent->pain_debounce_time = level.time + 1;
	}

//	8/3 tatt vekk pga crash bug
/*
	for (i=1 ; i<3 ; i++)
	{
		ent->client->kick_origin[i] = crandom() * 0.35;
		ent->client->kick_angles[i] = crandom() * 0.7;
	}
	ent->client->kick_origin[0] = crandom() * 0.35;
	ent->client->kick_angles[0] = ent->client->machinegun_shots * -1.5;

	// raise the gun as it is firing
	if (!deathmatch->value)
	{
		ent->client->machinegun_shots++;
		if (ent->client->machinegun_shots > 9)
			ent->client->machinegun_shots = 9;
	}

	// get start / end positions
	VectorAdd (ent->client->v_angle, ent->client->kick_angles, angles);
	AngleVectors (angles, forward, right, NULL);
	
	for (i=1 ; i<3 ; i++)
	{
		ent->client->kick_origin[i] = crandom() * 0.35;
		ent->client->kick_angles[i] = crandom() * 0.7;
	}
	VectorAdd (ent->client->v_angle, ent->client->kick_angles, angles);
	AngleVectors (angles, forward, right, NULL);
	
	VectorSet(offset, 0, 8, ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);
//TROND slutt*/

	//TROND	8/3 flytta opp frå under fire_bullet
	//TROND
	//SKYTELYD
	gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/1911_fire.wav"), 1, ATTN_NORM, 0);
	//TROND slutt

	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_SILENCED | is_silenced);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, ent->s.origin, PNOISE_WEAPON);

	//UENDELIG AMMO SJEKK
	//	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index]--;
	//TROND slutt

//TROND  8/3 lagt til
	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -2, ent->client->kick_origin);
	ent->client->kick_angles[0] = -2;

	VectorSet(offset, 0, 0,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);
//TROND slutt

	//TROND
	//SIKTER DÅRLIGERE UNDER FART OG OM HELSA ER DÅRLIG
	if (ent->velocity[0] || ent->velocity[1])
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_BLASTER);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.5, DEFAULT_BULLET_VSPREAD*1.5, MOD_BLASTER);
	}

	else if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD/9, DEFAULT_BULLET_VSPREAD/9, MOD_BLASTER);
	}
	else
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, MOD_BLASTER);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD/3, DEFAULT_BULLET_VSPREAD/3, MOD_BLASTER);
	}

/*	else
	{
		if (ent->health < 20)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_BLASTER);
		}

		if (ent->health < 50 && ent->health > 19)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.5, DEFAULT_BULLET_VSPREAD*1.5, MOD_BLASTER);
		}

		if (ent->health < 70 && ent->health > 49)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, MOD_BLASTER);
		}

		if (ent->health < 90 && ent->health > 69)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD/1.5, DEFAULT_BULLET_VSPREAD/1.5, MOD_BLASTER);
		}

		if (ent->health > 89)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD/2, DEFAULT_BULLET_VSPREAD/2, MOD_BLASTER);
		}
	}
*/
	//TROND slutt

	ent->client->anim_priority = ANIM_ATTACK;
	if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		ent->s.frame = FRAME_crattak1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_crattak9;
	}
	else
	{
		ent->s.frame = FRAME_attack1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_attack8;
	}

//	muzzleflash (ent, start);
}

void Weapon_Blaster (edict_t *ent)
{
	static int	pause_frames[]	= {13, 32, 42};
	static int	fire_frames[]	= {10, 0};

	if (ent->client->ps.gunframe == 2)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/1911_reload2.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 46)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/1911_reload1.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 60)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/1911_reload3.wav"), 1, ATTN_NORM, 0);//TROND lyd

	Weapon_Generic (ent, 9, 14, 39, 42, 41, 64, pause_frames, fire_frames, Weapon_Blaster_Fire);
}

void Weapon_HyperBlaster_Fire (edict_t *ent)
{
	float	rotation;
	vec3_t	offset;
	int		effect;
	int		damage;

	ent->client->weapon_sound = gi.soundindex("weapons/hyprbl1a.wav");

	if (!(ent->client->buttons & BUTTON_ATTACK))
	{
		ent->client->ps.gunframe++;
	}
	else
	{
		if (! ent->client->pers.inventory[ent->client->ammo_index] )
		{
			if (level.time >= ent->pain_debounce_time)
			{
				gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
				ent->pain_debounce_time = level.time + 1;
			}
			//TROND
			//NÅ BYTTAR IKKJE VÅPEN OM DET GÅR TOMT
			//NoAmmoWeaponChange (ent);
			//TROND slutt
		}
		else
		{
			rotation = (ent->client->ps.gunframe - 5) * 2*M_PI/6;
			offset[0] = -4 * sin(rotation);
			offset[1] = 0;
			offset[2] = 4 * cos(rotation);

			if ((ent->client->ps.gunframe == 6) || (ent->client->ps.gunframe == 9))
				effect = EF_HYPERBLASTER;
			else
				effect = 0;
			if (deathmatch->value)
				damage = 15;
			else
				damage = 20;
			Blaster_Fire (ent, offset, damage, true, effect);
			if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
				ent->client->pers.inventory[ent->client->ammo_index]--;

			ent->client->anim_priority = ANIM_ATTACK;
			if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
			{
				ent->s.frame = FRAME_crattak1 - 1;
				ent->client->anim_end = FRAME_crattak9;
			}
			else
			{
				ent->s.frame = FRAME_attack1 - 1;
				ent->client->anim_end = FRAME_attack8;
			}
		}

		ent->client->ps.gunframe++;
		if (ent->client->ps.gunframe == 12 && ent->client->pers.inventory[ent->client->ammo_index])
			ent->client->ps.gunframe = 6;
	}

	if (ent->client->ps.gunframe == 12)
	{
		gi.sound(ent, CHAN_AUTO, gi.soundindex("weapons/hyprbd1a.wav"), 1, ATTN_NORM, 0);
		ent->client->weapon_sound = 0;
	}

}

void Weapon_HyperBlaster (edict_t *ent)
{
	static int	pause_frames[]	= {0};
	static int	fire_frames[]	= {6, 7, 8, 9, 10, 11, 0};

	Weapon_Generic (ent, 5, 20, 49, 53, 0, 0, pause_frames, fire_frames, Weapon_HyperBlaster_Fire);
}

/*
======================================================================

MACHINEGUN / CHAINGUN

======================================================================
*/

void Machinegun_Fire (edict_t *ent)
{
	int	i;
	vec3_t		start;
	vec3_t		forward, right;
	vec3_t		angles;
	int			kick = 150;
	vec3_t		offset;
	int			damage = 25;
	
	if (!(ent->client->buttons & BUTTON_ATTACK))
	{
//TROND		8/3 tatt vekk
//		ent->client->machinegun_shots = 0;
		ent->client->ps.gunframe++;
		return;
	}

	//TROND
	//ANIMERE SKYTING
	if (ent->client->ps.gunframe == 12)
		ent->client->ps.gunframe = 11;
	else
		ent->client->ps.gunframe = 12;
	//TROND slutt

/*
	if (ent->client->ps.gunframe == 5)
		ent->client->ps.gunframe = 4;
	else
		ent->client->ps.gunframe = 5;
*/
	if (ent->client->pers.inventory[ent->client->ammo_index] < 1)
	{
//		ent->client->ps.gunframe = 6;//TROND slutt
		if (level.time >= ent->pain_debounce_time)
		{
			gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
			ent->pain_debounce_time = level.time + 1;
		}

		//TROND
		//NÅ BYTTAR IKKJE VÅPEN OM DET GÅR TOMT
		//NoAmmoWeaponChange (ent);
		//TROND slutt

		return;
	}

	//TROND
	//SNODIG: detta måtte flyttast opp frå bunnen... ellers bug, gjelder RAILGUN og...????
	gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/uzi_fire.wav"), 1, ATTN_NORM, 0);//TROND skytelyc

	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_SILENCED | is_silenced);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, ent->s.origin, PNOISE_WEAPON);

	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index]--;
	//TROND slutt

//TROND
//TAR VEKK QUAD DAMAGE
/*	if (is_quad)
	{
		damage *= 4;
		kick *= 4;
	}
*/
//TROND SLUTT

//TROND tatt vekk 8/3 pga crash bug
	/*
	for (i=1 ; i<3 ; i++)
	{
		ent->client->kick_origin[i] = crandom() * 0.35;
		ent->client->kick_angles[i] = crandom() * 0.7;
	}
	ent->client->kick_origin[0] = crandom() * 0.35;
	ent->client->kick_angles[0] = ent->client->machinegun_shots * -1.5;

	// raise the gun as it is firing
	if (!deathmatch->value)
	{
		ent->client->machinegun_shots++;
		if (ent->client->machinegun_shots > 9)
			ent->client->machinegun_shots = 9;
	}
//TROND slutt*/
  
	for (i=1 ; i<3 ; i++)
	{
		ent->client->kick_origin[i] = crandom() * 0.35;
		ent->client->kick_angles[i] = crandom() * 1.5;
	}

	// get start / end positions
	VectorAdd (ent->client->v_angle, ent->client->kick_angles, angles);
	AngleVectors (angles, forward, right, NULL);
	VectorSet(offset, 0, 8, ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

/*
	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -2, ent->client->kick_origin);
	ent->client->kick_angles[0] = -2;

	VectorSet(offset, 0, 0,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);*/

	//TROND
	//SKYTER VERRE I FART ELLER DÅRLIG HELSE

	if (ent->velocity[0] || ent->velocity[1])
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*3.3, DEFAULT_BULLET_VSPREAD*3.3, MOD_MACHINEGUN);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2.7, DEFAULT_BULLET_VSPREAD*2.7, MOD_MACHINEGUN);
	}
	else if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
		fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, MOD_MACHINEGUN);
	else
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2.5, DEFAULT_BULLET_VSPREAD*2.5, MOD_MACHINEGUN);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.5, DEFAULT_BULLET_VSPREAD*1.5, MOD_MACHINEGUN);
	}
/*	else
	{
		if (ent->health < 20)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*3, DEFAULT_BULLET_VSPREAD*3, MOD_MACHINEGUN);
		}

		if (ent->health < 50 && ent->health > 19)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2.5, DEFAULT_BULLET_VSPREAD*2.5, MOD_MACHINEGUN);
		}

		if (ent->health < 70 && ent->health > 49)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_MACHINEGUN);
		}

		if (ent->health < 90 && ent->health > 69)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.75, DEFAULT_BULLET_VSPREAD*1.75, MOD_MACHINEGUN);
		}

		if (ent->health > 89)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.5, DEFAULT_BULLET_VSPREAD*1.5, MOD_MACHINEGUN);
		}
	}*/
	//TROND slutt

	ent->client->anim_priority = ANIM_ATTACK;
	if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		ent->s.frame = FRAME_crattak1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_crattak9;
	}
	else
	{
		ent->s.frame = FRAME_attack1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_attack8;
	}

//	muzzleflash (ent, start);
}

void Weapon_Machinegun (edict_t *ent)
{
	static int	pause_frames[]	= {13, 32, 45};
	static int	fire_frames[]	= {11, 12};//TROND 12 lagt til pga animasjon

	if (ent->client->ps.gunframe == 3)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/uzi_reload1.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 54)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/uzi_reload2.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 64)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/uzi_reload3.wav"), 1, ATTN_NORM, 0);//TROND lyd

	Weapon_Generic (ent, 10, 13, 47, 51, 0, 0, pause_frames, fire_frames, Machinegun_Fire);
}
/*static int	pause_frames[]	= {13, 32, 42};
	static int	fire_frames[]	= {10, 0};

	Weapon_Generic (ent, 9, 14, 39, 42, 41, 64, p*/

void Chaingun_Fire (edict_t *ent)
{
	int			i;
	int			shots;
	vec3_t		start;
	vec3_t		forward, right, up;
	float		r, u;
	vec3_t		offset;
	int			damage;
	int			kick = 2;

	if (deathmatch->value)
		damage = 6;
	else
		damage = 8;

	if (ent->client->ps.gunframe == 5)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("weapons/chngnu1a.wav"), 1, ATTN_IDLE, 0);

	if ((ent->client->ps.gunframe == 14) && !(ent->client->buttons & BUTTON_ATTACK))
	{
		ent->client->ps.gunframe = 32;
		ent->client->weapon_sound = 0;
		return;
	}
	else if ((ent->client->ps.gunframe == 21) && (ent->client->buttons & BUTTON_ATTACK)
		&& ent->client->pers.inventory[ent->client->ammo_index])
	{
		ent->client->ps.gunframe = 15;
	}
	else
	{
		ent->client->ps.gunframe++;
	}

	if (ent->client->ps.gunframe == 22)
	{
		ent->client->weapon_sound = 0;
		gi.sound(ent, CHAN_AUTO, gi.soundindex("weapons/chngnd1a.wav"), 1, ATTN_IDLE, 0);
	}
	else
	{
		ent->client->weapon_sound = gi.soundindex("weapons/chngnl1a.wav");
	}

	ent->client->anim_priority = ANIM_ATTACK;
	if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		ent->s.frame = FRAME_crattak1 - (ent->client->ps.gunframe & 1);
		ent->client->anim_end = FRAME_crattak9;
	}
	else
	{
		ent->s.frame = FRAME_attack1 - (ent->client->ps.gunframe & 1);
		ent->client->anim_end = FRAME_attack8;
	}

	if (ent->client->ps.gunframe <= 9)
		shots = 1;
	else if (ent->client->ps.gunframe <= 14)
	{
		if (ent->client->buttons & BUTTON_ATTACK)
			shots = 2;
		else
			shots = 1;
	}
	else
		shots = 3;

	if (ent->client->pers.inventory[ent->client->ammo_index] < shots)
		shots = ent->client->pers.inventory[ent->client->ammo_index];

	if (!shots)
	{
		if (level.time >= ent->pain_debounce_time)
		{
			gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
			ent->pain_debounce_time = level.time + 1;
		}

		//TROND
		//NÅ BYTTAR IKKJE VÅPEN OM DET GÅR TOMT
		//NoAmmoWeaponChange (ent);
		//TROND slutt
		return;
	}

	if (is_quad)
	{
		damage *= 4;
		kick *= 4;
	}

	for (i=0 ; i<3 ; i++)
	{
		ent->client->kick_origin[i] = crandom() * 0.35;
		ent->client->kick_angles[i] = crandom() * 0.7;
	}

	for (i=0 ; i<shots ; i++)
	{
		// get start / end positions
		AngleVectors (ent->client->v_angle, forward, right, up);
		r = 7 + crandom()*4;
		u = crandom()*4;
		VectorSet(offset, 0, r, u + ent->viewheight-8);
		P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

		fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, MOD_CHAINGUN);
	}

	// send muzzle flash
	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte ((MZ_CHAINGUN1 + shots - 1) | is_silenced);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, start, PNOISE_WEAPON);

	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index] -= shots;
}


void Weapon_Chaingun (edict_t *ent)
{
	static int	pause_frames[]	= {38, 43, 51, 61, 0};
	static int	fire_frames[]	= {5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 0};

	Weapon_Generic (ent, 4, 31, 61, 64, 0, 0, pause_frames, fire_frames, Chaingun_Fire);
}


/*
======================================================================

SHOTGUN / SUPERSHOTGUN

======================================================================
*/
//TROND 22/3 mekka ny shotgun funk
void weapon_shotgun_fire (edict_t *ent)
{
	vec3_t		start;
	vec3_t		forward, right;
	int			damage = 20;
	int			kick = 75;
	vec3_t		offset;

	ent->client->ps.gunframe++;


	if (ent->client->pers.inventory[ent->client->ammo_index] < 1)
	{
		gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
		ent->pain_debounce_time = level.time + 1;
	}
	
	gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/shotgun_fire.wav"), 1, ATTN_NORM, 0);

	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_SILENCED);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, ent->s.origin, PNOISE_WEAPON);

	ent->client->pers.inventory[ent->client->ammo_index]--;

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, 0, ent->client->kick_origin);
	ent->client->kick_angles[0] = -10;

	VectorSet(offset, 0, 0,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	if (ent->velocity[0] || ent->velocity[1])
	{
		fire_shotgun (ent, start, forward, damage, kick, 300, 300, 7, MOD_SHOTGUN);
	}
	else
		fire_shotgun (ent, start, forward, damage, kick, 300, 300, 7, MOD_SHOTGUN);

	ent->client->anim_priority = ANIM_ATTACK;
	if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		ent->s.frame = FRAME_crattak1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_crattak9;
	}
	else
	{
		ent->s.frame = FRAME_attack1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_attack8;
	}
}
//TROND slutt
void weapon_shotgun_fire_old (edict_t *ent)
{
	vec3_t		start;
	vec3_t		forward, right;
	vec3_t		offset;
	int			damage = 20;
	int			kick = 75;

/*	if (ent->client->ps.gunframe == 9)
	{
		ent->client->ps.gunframe++;
		return;
	}*/
	ent->client->ps.gunframe++;

	ent->client->pers.inventory[ent->client->ammo_index]--;

	//TROND 21/3 flytta opp frå bunnen
	
	gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/shotgun_fire.wav"), 1, ATTN_NORM, 0);//TROND lyd

	// send muzzle flash
	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_SILENCED | is_silenced);//TROND var MZ_SHOTGUN
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, ent->s.origin, PNOISE_WEAPON);

//	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
	//TROND slutt

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, 0, ent->client->kick_origin);
	ent->client->kick_angles[0] = -9;

	VectorSet(offset, 0, 0,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);
//TROND  8/3 tatt vekk
	/*
	if (is_quad)
	{
		damage *= 4;
		kick *= 4;
	}
*/
/*	if (deathmatch->value)
		fire_shotgun (ent, start, forward, damage, kick, 200, 200, 7, MOD_SHOTGUN);
	else*/
	fire_shotgun (ent, start, forward, damage, kick, 200, 200, 7, MOD_SHOTGUN);
}

void Weapon_Shotgun (edict_t *ent)
{
	static int	pause_frames[]	= {22, 28, 34, 0};
	static int	fire_frames[]	= {8, 0};

	if (ent->client->ps.gunframe == 12)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/shotgun_cock.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 46)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/shotgun_reload.wav"), 1, ATTN_NORM, 0);//TROND lyd

	Weapon_Generic (ent, 7, 15, 36, 39, 0, 0, pause_frames, fire_frames, weapon_shotgun_fire);
}


void weapon_supershotgun_fire (edict_t *ent)
{
	vec3_t		start;
	vec3_t		forward, right;
	vec3_t		offset;
	vec3_t		v;
	int			damage = 3;
	int			kick = 30;

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -2, ent->client->kick_origin);
	ent->client->kick_angles[0] = -2;

	VectorSet(offset, 0, 8,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	if (is_quad)
	{
		damage *= 4;
		kick *= 4;
	}

	v[PITCH] = ent->client->v_angle[PITCH];
	v[YAW]   = ent->client->v_angle[YAW] - 5;
	v[ROLL]  = ent->client->v_angle[ROLL];
	AngleVectors (v, forward, NULL, NULL);
	fire_shotgun (ent, start, forward, damage, kick, DEFAULT_SHOTGUN_HSPREAD, DEFAULT_SHOTGUN_VSPREAD, DEFAULT_SSHOTGUN_COUNT/2, MOD_SSHOTGUN);
	v[YAW]   = ent->client->v_angle[YAW] + 5;
	AngleVectors (v, forward, NULL, NULL);
	fire_shotgun (ent, start, forward, damage, kick, DEFAULT_SHOTGUN_HSPREAD, DEFAULT_SHOTGUN_VSPREAD, DEFAULT_SSHOTGUN_COUNT/2, MOD_SSHOTGUN);

	// send muzzle flash
	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_SSHOTGUN | is_silenced);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	ent->client->ps.gunframe++;
	PlayerNoise(ent, start, PNOISE_WEAPON);

	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index] -= 2;
}

void Weapon_SuperShotgun (edict_t *ent)
{
	static int	pause_frames[]	= {29, 42, 57, 0};
	static int	fire_frames[]	= {7, 0};

	Weapon_Generic (ent, 6, 17, 57, 61, 0, 0, pause_frames, fire_frames, weapon_supershotgun_fire);
}



/*
======================================================================

RAILGUN

======================================================================
*/

void weapon_railgun_fire (edict_t *ent)
{
	vec3_t		start;
	vec3_t		forward, right;
	vec3_t		offset;
	int			damage = 1000;
	int			kick = 700;

	gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/barrett_fire.wav"), 1, ATTN_NORM, 0);//TROND linje

	// send muzzle flash
	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_IONRIPPER | is_silenced);//TROND var RAILGUN
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	ent->client->ps.gunframe++;
	PlayerNoise(ent, ent->s.origin, PNOISE_WEAPON);

//TROND 8/3 tatt vekk
//	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index]--;

/*	if (deathmatch->value)
	{	// normal damage is too extreme in dm
		damage = 300;
		kick = 500;
	}
	else
	{
		damage = 300;
		kick = 500;
	}

	if (is_quad)
	{
		damage *= 4;
		kick *= 4;
	}*/

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -3, ent->client->kick_origin);
	ent->client->kick_angles[0] = -20;//TROND var -3;

	VectorSet(offset, 0, 7,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);
	//TROND
	//RIFLE TREFFSIKKER
	if (ent->velocity[0] || ent->velocity[1])
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2.3, DEFAULT_BULLET_VSPREAD*2.3, MOD_RAILGUN);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_RAILGUN);
	}
	else if (ent->client->ps.pmove.pm_flags & PMF_DUCKED
		&& ent->client->zoom == 0)
	{
		fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*0.5, DEFAULT_BULLET_VSPREAD*0.5, MOD_RAILGUN);
	}
	else if (ent->client->zoom > 0
		&& ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		fire_rail (ent, start, forward, damage, kick);
	}
	else
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.4, DEFAULT_BULLET_VSPREAD*1.4, MOD_RAILGUN);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, MOD_RAILGUN);
	}
	//TROND slutt
}


void Weapon_Railgun (edict_t *ent)
{
	static int	pause_frames[]	= {22, 32};
	static int	fire_frames[]	= {9};

	if (ent->client->ps.gunframe == 45)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/barrett_reload1.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 50)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/barrett_reload2.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 55)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/barrett_reload3.wav"), 1, ATTN_NORM, 0);//TROND lyd

/*	if (ent->client->ps.gunframe == 0
		&& ent->client->pers.weapon == FindItem("railgun"))
		SP_LaserSight (ent);
	else if (ent->client->ps.gunframe == 50
		&& ent->client->pers.weapon == FindItem("railgun"))
		SP_LaserSight (ent);*/

	if (ent->client->weaponstate != WEAPON_READY
		&& ent->client->weaponstate != WEAPON_FIRING
		&& ent->client->zoom)
	{
		ent->client->ps.fov = 90;
		ent->client->zoom = 0;
		ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);
	}/*

	if ((ent->client->weaponstate == WEAPON_RELOADING
		&& ent->client->zoom != 0))
	{
		ent->client->zoom = 0;
		ent->client->ps.fov = 90;
		ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);
	}
	if ((ent->client->weaponstate == WEAPON_DROPPING
		&& ent->client->zoom != 0))
	{
		ent->client->zoom = 0;
		ent->client->ps.fov = 90;
		ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);
	}*/

	Weapon_Generic (ent, 8, 17, 32, 41, 0, 0, pause_frames, fire_frames, weapon_railgun_fire);
}


/*
======================================================================

BFG10K

======================================================================
*/

void weapon_bfg_fire (edict_t *ent)
{
	vec3_t	offset, start;
	vec3_t	forward, right;
	int		damage;
	float	damage_radius = 1000;

	if (deathmatch->value)
		damage = 200;
	else
		damage = 500;

	if (ent->client->ps.gunframe == 9)
	{
		// send muzzle flash
		gi.WriteByte (svc_muzzleflash);
		gi.WriteShort (ent-g_edicts);
		gi.WriteByte (MZ_BFG | is_silenced);
		gi.multicast (ent->s.origin, MULTICAST_PVS);

		ent->client->ps.gunframe++;

		PlayerNoise(ent, start, PNOISE_WEAPON);
		return;
	}

	// cells can go down during windup (from power armor hits), so
	// check again and abort firing if we don't have enough now
	if (ent->client->pers.inventory[ent->client->ammo_index] < 50)
	{
		ent->client->ps.gunframe++;
		return;
	}

	if (is_quad)
		damage *= 4;

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -2, ent->client->kick_origin);

	// make a big pitch kick with an inverse fall
	ent->client->v_dmg_pitch = -40;
	ent->client->v_dmg_roll = crandom()*8;
	ent->client->v_dmg_time = level.time + DAMAGE_TIME;

	VectorSet(offset, 8, 8, ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);
	fire_bfg (ent, start, forward, damage, 400, damage_radius);

	ent->client->ps.gunframe++;

	PlayerNoise(ent, start, PNOISE_WEAPON);

	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index] -= 50;
}

void Weapon_BFG (edict_t *ent)
{
	static int	pause_frames[]	= {39, 45, 50, 55, 0};
	static int	fire_frames[]	= {9, 17, 0};

	Weapon_Generic (ent, 8, 32, 55, 58, 0, 0, pause_frames, fire_frames, weapon_bfg_fire);
}

//TROND
//NYE VÅPEN I TERROR
/*
//C4
static void C4_Place (edict_t *self, int damage, float damage_radius)
{
	vec3_t		checkwall, forward;

	edict_t		*c4;

	trace_t		tr;

	VectorCopy (self->s.origin, checkwall);

	AngleVectors (self->client->v_angle, forward, NULL, NULL);

	checkwall[0] = self->s.origin[0] + forward[0]*20;
	checkwall[1] = self->s.origin[1] + forward[1]*20;
	checkwall[2] = self->s.origin[2] + forward[2]*20;

	tr = gi.trace (self->s.origin, NULL, NULL, checkwall, self, MASK_SOLID);

	if (tr.fraction == 1.0)
	{
		gi.cprintf (self, PRINT_HIGH, "Can`t place C4 here\n");
		self->client->ps.gunframe = 10;
		self->client->weaponstate = WEAPON_READY;
		NoAmmoWeaponChange (self);
		return;
	}

	c4 = G_Spawn();
	VectorCopy (tr.endpos, c4->s.origin);
	vectoangles (tr.plane.normal, c4->s.angles);
	c4->s.modelindex = gi.modelindex ("models/slat/world_c4/world_c4_placed.md2");
	c4->owner = self;
	c4->solid = SOLID_BBOX;
	VectorClear (c4->mins);
	VectorClear (c4->maxs);
	c4->s.renderfx |= RF_IR_VISIBLE;
	c4->dmg = damage;
	c4->dmg_radius = damage_radius;
	c4->classname = "explosive";

	self->client->pers.inventory[self->client->ammo_index] -= 1;

	gi.linkentity (c4);

	self->client->ps.gunframe++;
	NoAmmoWeaponChange (self);//TROND granat mekk
}

static void Weapon_C4_Place (edict_t *ent)
{
	ent->client->ps.gunframe++;
	if (ent->client->pers.inventory[ent->client->ammo_index] > 0)
	{
			C4_Place (ent, 300, 300);
	}
}


void Weapon_C4 (edict_t *ent)
{
	static int	pause_frames[]	= {34, 51, 59, 0};
	static int	fire_frames[]	= {6, 0};

	if (ent->client->ps.gunframe == 6)
	{
		ent->client->ps.gunindex = 0;
//		player->client->ps.gunindex = gi.modelindex(player->client->pers.weapon->view_model);
	}

	Weapon_Generic (ent, 4, 10, 18, 20,/*TROND RELOAD*//*0, 0, pause_frames, fire_frames, Weapon_C4_Place);
}
*/
//DETONATOR
static void Weapon_Detonated (edict_t *ent)
{
	edict_t *blip = NULL;

	while ((blip = findradius(blip, ent->s.origin, 3000)) != NULL)
	{
		if(!strcmp(blip->classname, "explosive"))//TROND tatt vekk 29/3 && blip->owner == ent)
		{
	//		gi.sound (ent, CHAN_VOICE, gi.soundindex ("weapons/grenlb1b.wav"), 1, ATTN_NORM, 0);
			blip->think = Grenade_Explode;
			blip->nextthink = level.time + 0.1;
		}
	}
	ent->client->ps.gunframe++;
}

static void Weapon_Detonate (edict_t *ent)
{
	Weapon_Detonated (ent);
	ent->client->ps.gunframe++;
}


void Weapon_Detonator (edict_t *ent)
{
	static int	pause_frames[]	= {34, 51, 59, 0};
	static int	fire_frames[]	= {14, 0};

	Weapon_Generic (ent, 9, 19, 44, 46,/*TROND RELOAD*/0, 0, pause_frames, fire_frames, Weapon_Detonate);
}

//AK47
static void AK_Fire (edict_t *ent)
{
	int	i;
	vec3_t		start;
	vec3_t		forward, right;
	vec3_t		angles;
	int			kick = 175;
	vec3_t		offset;
	int			damage = 45;

	if (!(ent->client->buttons & BUTTON_ATTACK))
	{
		ent->client->machinegun_shots = 0;
		ent->client->ps.gunframe++;
		return;
	}

	if (ent->client->ps.gunframe == 12)
		ent->client->ps.gunframe = 11;
	else
		ent->client->ps.gunframe = 12;

	if (ent->client->pers.inventory[ent->client->ammo_index] < 1)
	{
		if (level.time >= ent->pain_debounce_time)
		{
			gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
			ent->pain_debounce_time = level.time + 1;
		}

		return;
	}

	for (i=1 ; i<3 ; i++)
	{
		ent->client->kick_origin[i] = crandom() * 0.35;
		ent->client->kick_angles[i] = crandom() * 2;//TROND var 0.7;
	}
	ent->client->kick_origin[0] = crandom() * 0.35;
	ent->client->kick_angles[0] = ent->client->machinegun_shots * -1.5;

	//TROND
	//HEV VÅPEN UNDER SKYTING

	if (deathmatch->value)
	{
		ent->client->machinegun_shots++;
		if (ent->client->machinegun_shots > 15)
			ent->client->machinegun_shots = 15;
	}
	//TROND slutt

	//TROND
	//måtte flyttast opp her pga bug med fyste kule kommer ikkje... HÆ? KOFFOR?
	gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/ak47_fire.wav"), 1, ATTN_NORM, 0);//TROND skytelyc

	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_SILENCED | is_silenced);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, ent->s.origin, PNOISE_WEAPON);

//TROND	8/3 tatt vekk
//	if (! ( (int)dmflags->value & DF_INFINITE_AMMO ) )
		ent->client->pers.inventory[ent->client->ammo_index]--;
	//TROND slutt


	// get start / end positions
	VectorAdd (ent->client->v_angle, ent->client->kick_angles, angles);
	AngleVectors (angles, forward, right, NULL);
	VectorSet(offset, 0, 8, ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);
	//TROND
	//SKYTER VERRE I FART ELLER DÅRLIG HELSE

	if (ent->velocity[0] || ent->velocity[1])
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*3, DEFAULT_BULLET_VSPREAD*3, MOD_AK47);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_AK47);
	}

	else if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
		fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*0.7, DEFAULT_BULLET_VSPREAD*0.7, MOD_AK47);
	else
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_AK47);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.3, DEFAULT_BULLET_VSPREAD*1.3, MOD_AK47);
	}
/*	else
	{
		if (ent->health < 20)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*3, DEFAULT_BULLET_VSPREAD*3, MOD_AK47);
		}

		if (ent->health < 50 && ent->health > 19)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_AK47);
		}

		if (ent->health < 70 && ent->health > 49)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.75, DEFAULT_BULLET_VSPREAD*1.75, MOD_AK47);
		}

		if (ent->health < 90 && ent->health > 69)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.5, DEFAULT_BULLET_VSPREAD*1.5, MOD_AK47);
		}

		if (ent->health > 89)
		{
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.5, DEFAULT_BULLET_VSPREAD*1.5, MOD_AK47);
		}
	}*/
	//TROND slutt

	ent->client->anim_priority = ANIM_ATTACK;
	if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		ent->s.frame = FRAME_crattak1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_crattak9;
	}
	else
	{
		ent->s.frame = FRAME_attack1 - (int) (random()+0.25);
		ent->client->anim_end = FRAME_attack8;
	}
}

void Weapon_AK (edict_t *ent)
{
	static int	pause_frames[]	= {39, 40};
	static int	fire_frames[]	= {11, 12, 0};

	if (ent->client->ps.gunframe == 3)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/ak47_reload1.wav"), 1, ATTN_NORM, 0);//TROND skytelyd
	if (ent->client->ps.gunframe == 51)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/ak47_reload2.wav"), 1, ATTN_NORM, 0);//TROND skytelyd
	if (ent->client->ps.gunframe == 57)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/ak47_reload3.wav"), 1, ATTN_NORM, 0);//TROND skytelyd

	Weapon_Generic (ent, 10, 13, 39, 44, 0, 0, pause_frames, fire_frames, AK_Fire);
}

//kick
static void Weapon_Kicking (edict_t *self)
{
	vec3_t		checkwall, forward, aimdir;

	trace_t		tr;

	VectorCopy (self->s.origin, checkwall);

	AngleVectors (self->client->v_angle, forward, NULL, NULL);

	checkwall[0] = self->s.origin[0] + forward[0]*50;
	checkwall[1] = self->s.origin[1] + forward[1]*50;
	checkwall[2] = self->s.origin[2] + forward[2]*50;

	tr = gi.trace (self->s.origin, NULL, NULL, checkwall, self, MASK_SOLID);

	if (tr.fraction == 1.0)
	{
		gi.cprintf (self, PRINT_HIGH, "Can`t place C4 here\n");
		return;
	}

	gi.WriteByte(svc_temp_entity);
	gi.WriteByte(TE_BULLET_SPARKS);
	gi.WritePosition(tr.endpos);
	gi.WriteDir(aimdir);
	gi.multicast(tr.endpos, MULTICAST_PVS);

	self->client->ps.gunframe++;
}

void Weapon_Kick (edict_t *ent)
{
	static int	pause_frames[]	= {39, 40};
	static int	fire_frames[]	= {11, 12, 0};

	Weapon_Generic (ent, 10, 13, 39, 44, 0, 0, pause_frames, fire_frames, Weapon_Kicking);
}

//TROND slutt

//TROND
//RELOAD
void Cmd_Reload_f (edict_t *ent)
{
	if (!ent->client)
		return;

	if (!ent->client->weaponstate == WEAPON_READY)
		return;

	if (ent->client->pers.weapon == FindItem("1911")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))] < 8
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("1911clip"))] == 0)
		ent->client->ammotype = 1;
	else if (ent->client->pers.weapon == FindItem("uzi")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("uzirounds"))] < 30
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("uziclip"))] == 0)
		ent->client->ammotype = 2;
	else if (ent->client->pers.weapon == FindItem("barrett")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))] < 10
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("barrettclip"))] == 0)
		ent->client->ammotype = 3;
	else if (ent->client->pers.weapon == FindItem("ak 47")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47rounds"))] < 40
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47 clip"))] == 0)
		ent->client->ammotype = 4;
	else if (ent->client->pers.weapon == FindItem("glock")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))] < 17
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("glockclip"))] == 0)
		ent->client->ammotype = 5;
	else if (ent->client->pers.weapon == FindItem("beretta")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))] < 15
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("berettaclip"))] == 0)
		ent->client->ammotype = 6;
	else if (ent->client->pers.weapon == FindItem("mp5")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))] < 32
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5clip"))] == 0)
		ent->client->ammotype = 7;
	else if (ent->client->pers.weapon == FindItem("m60")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))] < 200
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("m60ammo"))] == 0)
		ent->client->ammotype = 8;
	else if (ent->client->pers.weapon == FindItem("msg90")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))] < 20
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90clip"))] == 0)
		ent->client->ammotype = 9;
	else if (ent->client->pers.weapon == FindItem("casull")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))] < 5
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("casullbullets"))] == 0)
		ent->client->ammotype = 10;
	else if (ent->client->pers.weapon == FindItem("mariner")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("marinerrounds"))] < 9
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("marinershells"))] == 0)
		ent->client->ammotype = 11;
//	gi.cprintf (ent, PRINT_HIGH, "%d ammotype\n", ent->client->ammotype);

	//1911
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("1911clip"))] && ent->client->pers.weapon == FindItem("1911"))//TROND var Blaster
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))] < 8 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");
			if (ent->client->ammotype == 0)
				ent->client->weight += 2;

			ent->client->pers.inventory[ITEM_INDEX(FindItem("1911clip"))] -= 1;
		}
		return;
	}

	//UZI
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIclip"))] && ent->client->pers.weapon == FindItem("UZI"))
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIrounds"))] < 30 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");
			if (ent->client->ammotype == 0)
				ent->client->weight += 2;

			ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIclip"))] -= 1;
		}
		return;
	}

	//HAGLE
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERshells"))] && ent->client->pers.weapon == FindItem("MARINER"))//TROND var Shotgun
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERrounds"))] < 9 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");

			ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERshells"))] -= 1;

//			if (ent->client->ammotype != 11)//TROND 11/4
				ent->client->shotgun_shells += 1;

			if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERshells"))])
				|| ent->client->shotgun_shells == 9)
			{
				ent->client->shotgun_shells = 0;
				ent->client->weight += 2;

				if (ent->client->ammotype == 11)
					ent->client->weight -= 2;
			}
		}
		return;
	}

	//RIFLE
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("BARRETTclip"))] && ent->client->pers.weapon == FindItem("BARRETT"))
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))] < 10 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");

			if (ent->client->ammotype == 0)
				ent->client->weight += 2;

			ent->client->pers.inventory[ITEM_INDEX(FindItem("BARRETTclip"))] -= 1;
		}
		return;
	}

	//AK47
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47 clip"))] && ent->client->pers.weapon == FindItem("AK 47"))
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47rounds"))] < 40 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

			if (ent->client->ammotype == 0)
				ent->client->weight += 2;

			ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47 clip"))] -= 1;
		}
		return;
	}

	//GLOCK
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("glockclip"))] && ent->client->pers.weapon == FindItem("glock"))//TROND var Blaster
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))] < 17 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");

			if (ent->client->ammotype == 0)
				ent->client->weight += 2;

			ent->client->pers.inventory[ITEM_INDEX(FindItem("glockclip"))] -= 1;
		}
		return;
	}

	//CASULL
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("casullbullets"))] && ent->client->pers.weapon == FindItem("casull"))//TROND var Blaster
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))] < 5 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");

			ent->client->pers.inventory[ITEM_INDEX(FindItem("casullbullets"))] -= 1;
			
//			if (ent->client->ammotype != 10)//TROND 11/4
				ent->client->casull_bullets += 1;

			if (!(ent->client->pers.inventory[ITEM_INDEX(FindItem("casullbullets"))])
				|| ent->client->casull_bullets == 10)
			{
				ent->client->casull_bullets = 0;
				ent->client->weight += 2;

				if (ent->client->ammotype == 10)
					ent->client->weight -= 2;
			}
		}
		return;
	}
	//BERETTA
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("berettaclip"))] && ent->client->pers.weapon == FindItem("beretta"))//TROND var Blaster
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))] < 17 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");

			if (ent->client->ammotype == 0)
				ent->client->weight += 2;

			ent->client->pers.inventory[ITEM_INDEX(FindItem("berettaclip"))] -= 1;
		}
		return;
	}
	//MP5
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5clip"))] && ent->client->pers.weapon == FindItem("mp5"))//TROND var Blaster
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))] < 32 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");

			if (ent->client->ammotype == 0)
				ent->client->weight += 2;

			ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5clip"))] -= 1;
		}
		return;
	}
	//M60    1/4
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("m60ammo"))] && ent->client->pers.weapon == FindItem("m60"))//TROND var Blaster
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))] < 200 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

//			gi.centerprintf (ent, "Gimme bug reports/feedback\n on this reload function\n");
			if (ent->client->ammotype == 0)
				ent->client->weight += 10;

		}
		return;
	}
	//MSG90
	if ( ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90clip"))] && ent->client->pers.weapon == FindItem("msg90"))//TROND var Blaster
	{
		if (ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))] < 20 && ent->client->weaponstate == WEAPON_READY)
		{
			ent->client->weaponstate = WEAPON_RELOADING;

			if (ent->client->ammotype == 0)
				ent->client->weight += 2;

			ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90clip"))] -= 1;
		}
		return;
	}

	else
		return;//gi.centerprintf (ent, "Go fetch a clip for this weapon\n before you try to reload, or\n maybe reloading isn`t \nsupported by this gun yet!\n");
}
//TROND slutt
