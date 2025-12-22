#include "g_local.h"

qboolean	Pickup_Weapon (edict_t *ent, edict_t *other);
qboolean	Pickup_NoAmmo_Weapon (edict_t *ent, edict_t *other);//TROND 20/3
void		Use_Weapon (edict_t *ent, gitem_t *inv);
void		Drop_Weapon (edict_t *ent, gitem_t *inv);

void Weapon_Blaster (edict_t *ent);
void Weapon_Shotgun (edict_t *ent);
void Weapon_SuperShotgun (edict_t *ent);
void Weapon_Machinegun (edict_t *ent);
void Weapon_Chaingun (edict_t *ent);
void Weapon_HyperBlaster (edict_t *ent);
void Weapon_RocketLauncher (edict_t *ent);
void Weapon_Grenade (edict_t *ent);
void Weapon_GrenadeLauncher (edict_t *ent);
void Weapon_Railgun (edict_t *ent);
void Weapon_BFG (edict_t *ent);
//TROND
//NYE VÅPEN I TERROR
void Visible_Items (edict_t *self);//TROND 19/3 Visible Items
void Weapon_C4 (edict_t *ent);
void Weapon_Detonator (edict_t *ent);
void Weapon_AK (edict_t *ent);
void Weapon_Kick (edict_t *ent);
void Weapon_Glock (edict_t *ent);
void Weapon_Bush (edict_t *ent);
void Weapon_Mine (edict_t *ent);
void Weapon_Casull (edict_t *ent);
void Weapon_Beretta (edict_t *ent);
void Weapon_MP5 (edict_t *ent);
void Weapon_M60 (edict_t *ent);
void Weapon_MSG90 (edict_t *ent);
//TROND slutt

gitem_armor_t jacketarmor_info	= { 25,  50, .30, .00, ARMOR_JACKET};
gitem_armor_t combatarmor_info	= { 50, 100, .60, .30, ARMOR_COMBAT};
gitem_armor_t bodyarmor_info	= {100, 200, .80, .60, ARMOR_BODY};

int	jacket_armor_index;
int	combat_armor_index;
int	body_armor_index;
static int	power_screen_index;
static int	power_shield_index;

#define HEALTH_IGNORE_MAX	1
#define HEALTH_TIMED		2

void Use_Quad (edict_t *ent, gitem_t *item);
static int	quad_drop_timeout_hack;

//======================================================================

/*
===============
GetItemByIndex
===============
*/
gitem_t	*GetItemByIndex (int index)
{
	if (index == 0 || index >= game.num_items)
		return NULL;

	return &itemlist[index];
}


/*
===============
FindItemByClassname

===============
*/
gitem_t	*FindItemByClassname (char *classname)
{
	int		i;
	gitem_t	*it;

	it = itemlist;
	for (i=0 ; i<game.num_items ; i++, it++)
	{
		if (!it->classname)
			continue;
		if (!Q_stricmp(it->classname, classname))
			return it;
	}

	return NULL;
}

/*
===============
FindItem

===============
*/
gitem_t	*FindItem (char *pickup_name)
{
	int		i;
	gitem_t	*it;

	it = itemlist;
	for (i=0 ; i<game.num_items ; i++, it++)
	{
		if (!it->pickup_name)
			continue;
		if (!Q_stricmp(it->pickup_name, pickup_name))
			return it;
	}

	return NULL;
}

//======================================================================
void DoRespawn (edict_t *ent)
{
	if (ent->team)
	{
		edict_t	*master;
		int	count;
		int choice;

		master = ent->teammaster;

//ZOID
//in ctf, when we are weapons stay, only the master of a team of weapons
//is spawned
		if (ctf->value &&
			((int)dmflags->value & DF_WEAPONS_STAY) &&
			master->item && (master->item->flags & IT_WEAPON))
			ent = master;
		else {
//ZOID

			for (count = 0, ent = master; ent; ent = ent->chain, count++)
				;

			choice = rand() % count;

			for (count = 0, ent = master; count < choice; ent = ent->chain, count++)
				;
		}
	}

	ent->svflags &= ~SVF_NOCLIENT;
	ent->solid = SOLID_TRIGGER;
	gi.linkentity (ent);

	// send an effect
	ent->s.event = EV_ITEM_RESPAWN;
}

void SetRespawn (edict_t *ent, float delay)
{
	ent->flags |= FL_RESPAWN;
	ent->svflags |= SVF_NOCLIENT;
	ent->solid = SOLID_NOT;
	ent->nextthink = level.time + delay;
	ent->think = DoRespawn;
	gi.linkentity (ent);
}


//======================================================================

qboolean Pickup_Powerup (edict_t *ent, edict_t *other)
{
	int		quantity;

	quantity = other->client->pers.inventory[ITEM_INDEX(ent->item)];
	if ((skill->value == 1 && quantity >= 2) || (skill->value >= 2 && quantity >= 1))
		return false;

	if ((coop->value) && (ent->item->flags & IT_STAY_COOP) && (quantity > 0))
		return false;

	other->client->pers.inventory[ITEM_INDEX(ent->item)]++;

	if (deathmatch->value)
	{
		if (!(ent->spawnflags & DROPPED_ITEM) )
			SetRespawn (ent, ent->item->quantity);
		if (((int)dmflags->value & DF_INSTANT_ITEMS) || ((ent->item->use == Use_Quad) && (ent->spawnflags & DROPPED_PLAYER_ITEM)))
		{
			if ((ent->item->use == Use_Quad) && (ent->spawnflags & DROPPED_PLAYER_ITEM))
				quad_drop_timeout_hack = (ent->nextthink - level.time) / FRAMETIME;
			ent->item->use (other, ent->item);
		}
	}

	return true;
}

void Drop_General (edict_t *ent, gitem_t *item)
{
	Drop_Item (ent, item);
	ent->client->pers.inventory[ITEM_INDEX(item)]--;
	ValidateSelectedItem (ent);
}


//======================================================================

qboolean Pickup_Adrenaline (edict_t *ent, edict_t *other)
{
	if (!deathmatch->value)
		other->max_health += 1;

	if (other->health < other->max_health)
		other->health = other->max_health;

	if (!(ent->spawnflags & DROPPED_ITEM) && (deathmatch->value))
		SetRespawn (ent, ent->item->quantity);

	return true;
}

qboolean Pickup_AncientHead (edict_t *ent, edict_t *other)
{
	other->max_health += 2;

	/*TROND
	//TATT VEKK SP DET IKKJE RESPAWNER
	if (!(ent->spawnflags & DROPPED_ITEM) && (deathmatch->value))
		SetRespawn (ent, ent->item->quantity);
	//TROND slutt*/

	return true;
}

qboolean Pickup_Bandolier (edict_t *ent, edict_t *other)
{
	gitem_t	*item;
	int		index;

	if (other->client->pers.max_UZIclip < 250)
		other->client->pers.max_UZIclip = 250;
	//TROND
	//RELOAD 1911
	if (other->client->pers.max_1911rounds < 250)
		other->client->pers.max_1911rounds = 250;
	//TROND slutt

	//TROND
	//RELOAD UZI
	if (other->client->pers.max_9mm < 250)
		other->client->pers.max_9mm = 250;
	//TROND slutt

	//TROND
	//RELOAD SNIPER
	if (other->client->pers.max_50cal < 250)
		other->client->pers.max_50cal = 250;
	//TROND slutt

	//TROND
	//RELOAD HAGLE
	if (other->client->pers.max_MARINERrounds < 250)
		other->client->pers.max_MARINERrounds = 250;
	//TROND slutt

	if (other->client->pers.max_shells < 150)
		other->client->pers.max_shells = 150;
	if (other->client->pers.max_cells < 250)
		other->client->pers.max_cells = 250;
	if (other->client->pers.max_slugs < 75)
		other->client->pers.max_slugs = 75;

	item = FindItem("UZIclip");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_UZIclip)
			other->client->pers.inventory[index] = other->client->pers.max_UZIclip;
	}

	//TROND
	//RELOAD 1911
	item = FindItem("1911rounds");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_1911rounds)
			other->client->pers.inventory[index] = other->client->pers.max_1911rounds;
	}
	//TROND slutt

	//TROND
	//RELOAD UZI
	item = FindItem("UZIrounds");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_9mm)
			other->client->pers.inventory[index] = other->client->pers.max_9mm;
	}
	//TROND slutt

	//TROND
	//RELOAD RIFLE
	item = FindItem("50cal");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_50cal)
			other->client->pers.inventory[index] = other->client->pers.max_50cal;
	}
	//TROND slutt

	//TROND
	//RELOAD HAGLE
	item = FindItem("MARINERrounds");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_MARINERrounds)
			other->client->pers.inventory[index] = other->client->pers.max_MARINERrounds;
	}
	//TROND slutt

	item = FindItem("MARINERshells");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_shells)
			other->client->pers.inventory[index] = other->client->pers.max_shells;
	}

	if (!(ent->spawnflags & DROPPED_ITEM) && (deathmatch->value))
		SetRespawn (ent, ent->item->quantity);

	return true;
}

qboolean Pickup_Pack (edict_t *ent, edict_t *other)
{
	gitem_t	*item;
	int		index;

	if (other->client->pers.max_UZIclip < 300)
		other->client->pers.max_UZIclip = 300;
	//TROND
	//RELOAD UZI
	if (other->client->pers.max_9mm < 300)
		other->client->pers.max_9mm = 300;
	//TROND slutt

	//TROND
	//RELOAD 1911
	if (other->client->pers.max_1911rounds < 300)
		other->client->pers.max_1911rounds = 300;
	//TROND slutt

	//TROND
	//RELOAD SNIPER
	if (other->client->pers.max_50cal < 300)
		other->client->pers.max_50cal = 300;
	//TROND slutt

	//TROND
	//RELOAD HAGLE
	if (other->client->pers.max_MARINERrounds < 300)
		other->client->pers.max_MARINERrounds = 300;
	//TROND slutt

	if (other->client->pers.max_shells < 200)
		other->client->pers.max_shells = 200;
	if (other->client->pers.max_rockets < 100)
		other->client->pers.max_rockets = 100;
	if (other->client->pers.max_grenades < 100)
		other->client->pers.max_grenades = 100;
	if (other->client->pers.max_cells < 300)
		other->client->pers.max_cells = 300;
	if (other->client->pers.max_slugs < 100)
		other->client->pers.max_slugs = 100;

	item = FindItem("UZIclip");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_UZIclip)
			other->client->pers.inventory[index] = other->client->pers.max_UZIclip;
	}

	//TROND
	//RELOAD 1911
	item = FindItem("1911rounds");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_1911rounds)
			other->client->pers.inventory[index] = other->client->pers.max_1911rounds;
	}
	//TROND slutt

	//TROND
	//RELOAD UZI
	item = FindItem("UZIrounds");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_9mm)
			other->client->pers.inventory[index] = other->client->pers.max_9mm;
	}
	//TROND slutt

	//TROND
	//RELOAD RIFLE
	item = FindItem("50cal");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_50cal)
			other->client->pers.inventory[index] = other->client->pers.max_50cal;
	}
	//TROND slutt

	//TROND
	//RELOAD HAGLE
	item = FindItem("MARINERrounds");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_MARINERrounds)
			other->client->pers.inventory[index] = other->client->pers.max_MARINERrounds;
	}
	//TROND slutt

	item = FindItem("MARINERshells");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_shells)
			other->client->pers.inventory[index] = other->client->pers.max_shells;
	}

	item = FindItem("1911clip");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_cells)
			other->client->pers.inventory[index] = other->client->pers.max_cells;
	}

	item = FindItem("Grenades");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_grenades)
			other->client->pers.inventory[index] = other->client->pers.max_grenades;
	}

	item = FindItem("Rockets");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_rockets)
			other->client->pers.inventory[index] = other->client->pers.max_rockets;
	}

	item = FindItem("BARRETTclip");
	if (item)
	{
		index = ITEM_INDEX(item);
		other->client->pers.inventory[index] += item->quantity;
		if (other->client->pers.inventory[index] > other->client->pers.max_slugs)
			other->client->pers.inventory[index] = other->client->pers.max_slugs;
	}

	if (!(ent->spawnflags & DROPPED_ITEM) && (deathmatch->value))
		SetRespawn (ent, ent->item->quantity);


	return true;
}

//======================================================================

void Use_Quad (edict_t *ent, gitem_t *item)
{
	int		timeout;

	ent->client->pers.inventory[ITEM_INDEX(item)]--;
	ValidateSelectedItem (ent);

	if (quad_drop_timeout_hack)
	{
		timeout = quad_drop_timeout_hack;
		quad_drop_timeout_hack = 0;
	}
	else
	{
		timeout = 300;
	}

	if (ent->client->quad_framenum > level.framenum)
		ent->client->quad_framenum += timeout;
	else
		ent->client->quad_framenum = level.framenum + timeout;

	gi.sound(ent, CHAN_ITEM, gi.soundindex("items/damage.wav"), 1, ATTN_NORM, 0);
}

//======================================================================

void Use_Breather (edict_t *ent, gitem_t *item)
{
	ent->client->pers.inventory[ITEM_INDEX(item)]--;
	ValidateSelectedItem (ent);

	if (ent->client->breather_framenum > level.framenum)
		ent->client->breather_framenum += 300;
	else
		ent->client->breather_framenum = level.framenum + 300;

//	gi.sound(ent, CHAN_ITEM, gi.soundindex("items/damage.wav"), 1, ATTN_NORM, 0);
}

//======================================================================

void Use_Envirosuit (edict_t *ent, gitem_t *item)
{
	ent->client->pers.inventory[ITEM_INDEX(item)]--;
	ValidateSelectedItem (ent);

	if (ent->client->enviro_framenum > level.framenum)
		ent->client->enviro_framenum += 300;
	else
		ent->client->enviro_framenum = level.framenum + 300;

//	gi.sound(ent, CHAN_ITEM, gi.soundindex("items/damage.wav"), 1, ATTN_NORM, 0);
}

//======================================================================

void	Use_Invulnerability (edict_t *ent, gitem_t *item)
{
	ent->client->pers.inventory[ITEM_INDEX(item)]--;
	ValidateSelectedItem (ent);

	if (ent->client->invincible_framenum > level.framenum)
		ent->client->invincible_framenum += 300;
	else
		ent->client->invincible_framenum = level.framenum + 300;

	gi.sound(ent, CHAN_ITEM, gi.soundindex("items/protect.wav"), 1, ATTN_NORM, 0);
}

//======================================================================

void	Use_Silencer (edict_t *ent, gitem_t *item)
{
	ent->client->pers.inventory[ITEM_INDEX(item)]--;
	ValidateSelectedItem (ent);
	ent->client->silencer_shots += 30;

//	gi.sound(ent, CHAN_ITEM, gi.soundindex("items/damage.wav"), 1, ATTN_NORM, 0);
}

//======================================================================

qboolean Pickup_Key (edict_t *ent, edict_t *other)
{
	//TROND 20/3 sjekk om spiller dukker før plukk opp
	if (other->client->ps.pmove.pm_flags & PMF_DUCKED
		&& other->client->weight >= 2)
	{//TROND 
		if (coop->value)
		{
			if (strcmp(ent->classname, "key_power_cube") == 0)
			{
				if (other->client->pers.power_cubes & ((ent->spawnflags & 0x0000ff00)>> 8))
					return false;
				other->client->pers.inventory[ITEM_INDEX(ent->item)]++;
				other->client->pers.power_cubes |= ((ent->spawnflags & 0x0000ff00) >> 8);
			}
			else
			{
				if (other->client->pers.inventory[ITEM_INDEX(ent->item)])
					return false;
				other->client->pers.inventory[ITEM_INDEX(ent->item)] = 1;
			}
			return true;
		}
		other->client->pers.inventory[ITEM_INDEX(ent->item)]++;

		other->client->weight -= 2;//TROND vekt 20/3
		return true;
	}//TROND
	else
		return false;
	//TROND slutt
}

//TROND
//PICKUP IR
qboolean Pickup_Item (edict_t *ent, edict_t *other)
{
	if (other->client->ps.pmove.pm_flags & PMF_DUCKED
/*		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("IR goggles"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("Helmet"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("MedKit"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("Scuba Gear"))])
		&& !(other->client->pers.inventory[ITEM_INDEX(FindItem("Head Light"))])*/)
	{
		if (ent->item == FindItem("ir goggles"))
		{
			if (other->client->weight < 3
				|| other->client->head_item)
				return false;
			else
				other->client->weight -= 3;
			other->client->head_item = 1;
		}
		if (ent->item == FindItem("helmet"))
		{
			if (other->client->weight < 2
				|| other->client->head_item)
				return false;
			else
				other->client->weight -= 2;
			other->client->head_item = 1;
		}
		if (ent->item == FindItem("bullet proof vest"))
		{
			if (other->client->weight < 4
				|| other->client->torso_item)
				return false;
			else
				other->client->weight -= 4;
			other->client->torso_item = 1;
		}
		if (ent->item == FindItem("medkit"))
		{
			if (other->client->weight < 2
				|| other->client->torso_item)
				return false;
			else
				other->client->weight -= 2;
			other->client->torso_item = 1;
		}
		if (ent->item == FindItem("scuba gear"))
		{
			if (other->client->weight < 5
				|| other->client->torso_item)
				return false;
			else
				other->client->weight -= 5;
			other->client->torso_item = 1;
		}
		if (ent->item == FindItem("head light"))
		{
			if (other->client->weight < 2
				|| other->client->head_item)
				return false;
			else
				other->client->weight -= 2;
			other->client->head_item = 1;
		}

		other->client->pers.inventory[ITEM_INDEX(ent->item)]++;
		ShowItem (other);
		ShowTorso (other);
		return true;
	}
	else
		return false;
}
//TROND slutt

//TROND
//DROP IR
void Drop_SpecialItem (edict_t *ent, gitem_t *item)
{
	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("IR goggles"))])
	{
//		ent->client->pers.inventory[ITEM_INDEX(FindItem("IR goggles"))] = 0;
		if (ent->client->zoom == 0)//TROND 9/4
		{
			ent->client->ps.rdflags &= ~RDF_IRGOGGLES;
			ent->client->infrared = 0;
		}
		else if (ent->client->pers.weapon == FindItem("barrett"))
		{
			ent->client->ps.rdflags &= ~RDF_IRGOGGLES;
			ent->client->infrared = 0;
		}
		Drop_General (ent, item);
		ent->client->weight += 3;
		ent->client->head_item = 0;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Helmet"))])
	{
//		ent->client->pers.inventory[ITEM_INDEX(FindItem("Helmet"))] = 0;
		Drop_General (ent, item);
		ent->client->weight += 2;
		ent->client->head_item = 0;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))])
	{
//		ent->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))] = 0;
		Drop_General (ent, item);
		ent->client->weight += 4;
		ent->client->torso_item = 0;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("MedKit"))])
	{
//		ent->client->pers.inventory[ITEM_INDEX(FindItem("MedKit"))] = 0;
		Drop_General (ent, item);
		ent->client->weight += 2;
		ent->client->torso_item = 0;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Scuba Gear"))])
	{
//		ent->client->pers.inventory[ITEM_INDEX(FindItem("Scuba Gear"))] = 0;
		Drop_General (ent, item);
		ent->client->weight += 5;
		ent->client->torso_item = 0;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Head Light"))])
	{
//		ent->client->pers.inventory[ITEM_INDEX(FindItem("Head Light"))] = 0;
		if (ent->client->fl_on == 1)
			SP_FlashLight (ent);
		ent->client->fl_on = 0;
		Drop_General (ent, item);
		ent->client->weight += 2;
		ent->client->head_item = 0;
	}
	if (!ent->client)
		return;
	ShowItem (ent);
	ShowTorso (ent);
}
//TROND slutt


//======================================================================

qboolean Add_Ammo (edict_t *ent, gitem_t *item, int count)
{
	int			index;
	int			max;

	if (!ent->client)
		return false;

	if (item->tag == AMMO_UZI)
		max = ent->client->pers.max_UZIclip;
	//TROND
	//RELOAD 1911
	else if (item->tag == AMMO_1911ROUNDS)
		max = ent->client->pers.max_1911rounds;
	//TROND slutt

	//TROND
	//RELOAD UZI
	else if (item->tag == AMMO_9MM)
		max = ent->client->pers.max_9mm;
	//TROND slutt

	//TROND
	//RELOAD RIFLE
	else if (item->tag == AMMO_50CAL)
		max = ent->client->pers.max_50cal;
	//TROND slutt

	//TROND
	//RELOAD HAGLE
	else if (item->tag == AMMO_MARINERROUNDS)
		max = ent->client->pers.max_MARINERrounds;
	//TROND slutt

	//TROND
	//RELOAD AK47
	else if (item->tag == AMMO_AK47ROUNDS)
		max = ent->client->pers.max_ak47rounds;
	else if (item->tag == AMMO_AKCLIP)
		max = ent->client->pers.max_akclip;
	//TROND slutt

	//TROND
	//RELOAD GLOCK
	else if (item->tag == AMMO_GLOCKROUNDS)
		max = ent->client->pers.max_glockrounds;
	else if (item->tag == AMMO_GLOCKCLIP)
		max = ent->client->pers.max_glockclip;
	//RELOAD CASULL
	else if (item->tag == AMMO_CASULLROUNDS)
		max = ent->client->pers.max_casullrounds;
	//TROND slutt

	else if (item->tag == AMMO_SHELLS)
		max = ent->client->pers.max_shells;
	else if (item->tag == AMMO_ROCKETS)
		max = ent->client->pers.max_rockets;
	else if (item->tag == AMMO_GRENADES)
		max = ent->client->pers.max_grenades;
	else if (item->tag == AMMO_CELLS)
		max = ent->client->pers.max_cells;
	else if (item->tag == AMMO_SLUGS)
		max = ent->client->pers.max_slugs;
	else
		return false;

	index = ITEM_INDEX(item);

	if (ent->client->pers.inventory[index] == max)
		return false;

	ent->client->pers.inventory[index] += count;

	if (ent->client->pers.inventory[index] > max)
		ent->client->pers.inventory[index] = max;

	return true;
}

void Cmd_Reload_f (edict_t *ent);
void Drop_Ammo (edict_t *ent, gitem_t *item);//TROND 11/4

qboolean Pickup_Ammo (edict_t *ent, edict_t *other)
{
	int			oldcount;
	int			count;
	qboolean	weapon;

	//TROND lagt til 30/3
	if (!other->client)
		return false;

	if (other->client->ps.pmove.pm_flags & PMF_DUCKED)//TROND linje plukk opp ammo hack
	{//TROND linje

		//TROND vekt system
		//TROND 1/4
		if (other->client->weight < 10
			&& ent->item == FindItem("m60ammo")
			&& other->client->ammotype == 0)
			return false;
		if (ent->item == FindItem("m60ammo")
			&& other->client->torso_item == 1
			&& other->client->ammotype == 0)
			return false;
		//TROND slutt
		if (other->client->weight < 2
			&& (other->client->ammotype == 0)//TROND 20/3
			)
		{
			return false;
		}
		else
		{
			//TROND reload funk 30/3
			if ((other->client->ammotype == 1 && ent->item != FindItem("1911clip"))
				|| (other->client->ammotype == 2 && ent->item != FindItem("uziclip"))
				|| (other->client->ammotype == 3 && ent->item != FindItem("barrettclip"))
				|| (other->client->ammotype == 4 && ent->item != FindItem("ak47 clip"))
				|| (other->client->ammotype == 5 && ent->item != FindItem("glockclip"))
				|| (other->client->ammotype == 6 && ent->item != FindItem("berettaclip"))
				|| (other->client->ammotype == 7 && ent->item != FindItem("mp5clip"))
				|| (other->client->ammotype == 8 && ent->item != FindItem("m60ammo"))
				|| (other->client->ammotype == 9 && ent->item != FindItem("msg90clip"))
				|| (other->client->ammotype == 10 && ent->item != FindItem("casullbullets"))
				|| (other->client->ammotype == 11 && ent->item != FindItem("marinershells")))//TROND 11/4 off ground
				return false;
			//TROND slutt

			if (ent->item == FindItem("mine")
				|| ent->item == FindItem("c4 detpack")
				|| ent->item == FindItem("grenades"))
			{
				if (other->client->weight < 5)
					return false;
				other->client->weight -= 5;
			}
			else
			{
//				if (ent->item != FindItem("marinershells"))
				if (other->client->ammotype == 0)
					other->client->weight -= 2;
				//TROND 1/4
				if (ent->item == FindItem("m60ammo"))
				{
					other->client->torso_item = 1;
					if (other->client->ammotype == 0)
						other->client->weight -= 8;
				}
				//TROND slutt
			}
		}
		//TROND slutt

		weapon = (ent->item->flags & IT_WEAPON);
		if ( (weapon) && ( (int)dmflags->value & DF_INFINITE_AMMO ) )
			count = 1000;
		else if (ent->count)
			count = ent->count;
		else
			count = ent->item->quantity;

		oldcount = other->client->pers.inventory[ITEM_INDEX(ent->item)];

		if (!Add_Ammo (other, ent->item, count))
			return false;

		//TROND 10/5 tatt vekk
		/*
		if (weapon && !oldcount)
		{
			if (other->client->pers.weapon != ent->item && ( !deathmatch->value || other->client->pers.weapon == FindItem("1911") ) )//TROND var Blaster
				other->client->newweapon = ent->item;
		}
		*/

		if (!(ent->spawnflags & (DROPPED_ITEM | DROPPED_PLAYER_ITEM)) && (deathmatch->value))
			SetRespawn (ent, 40);//TROND mekk


		if (other->client->pers.inventory[ITEM_INDEX(ent->item)]
			&& other->client->ammotype != 0
			&& other->client->weaponstate != WEAPON_READY)
			other->client->pers.inventory[ITEM_INDEX(ent->item)] = 0;

		if (other->client->ammotype)
			Cmd_Reload_f (other);

		if (ent->item == FindItem("m60ammo"))//TROND	5/4
			ShowTorso(other);//TROND	5/4

		//TROND 11/4 off ground reloading
		if (ent->item == FindItem("casullbullets")
			&& other->client->ammotype == 10)//TROND	11/4
		{
			if (other->client->pers.inventory[ITEM_INDEX(FindItem("casullbullets"))])
			{
				Drop_Ammo (other, ent->item);//TROND	11/4
				ent->count == other->client->pers.inventory[ITEM_INDEX(FindItem("casullbullets"))] - 1;
				other->client->casull_bullets -= 1;
			}
		}

		if (ent->item == FindItem("marinershells")
			&& other->client->ammotype == 11)//TROND	11/4
		{
			if (other->client->pers.inventory[ITEM_INDEX(FindItem("marinershells"))])
			{
				Drop_Ammo (other, ent->item);//TROND	11/4
				ent->count == other->client->pers.inventory[ITEM_INDEX(FindItem("marinershells"))] - 1;
				other->client->shotgun_shells -= 1;
			}
		}
		//TROND slutt

		return true;
	}//TROND linje
	else//TROND linje
		return false;//TROND slinje
}

void Drop_Ammo (edict_t *ent, gitem_t *item)
{
	edict_t	*dropped;
	int		index;

	index = ITEM_INDEX(item);
	//TROND bug fix
	if (ent->item == FindItem("C4 Detpack")
		|| ent->item == FindItem("Mine")
		|| ent->item == FindItem("grenades"))
		return;
	//TROND slutt
	dropped = Drop_Item (ent, item);
	if (ent->client->pers.inventory[index] >= item->quantity)
		dropped->count = item->quantity;
	else
		dropped->count = ent->client->pers.inventory[index];

	//TROND 11/4 visible count
	if (dropped->item == FindItem("casullbullets"))
	{
		if(dropped->count == 10)
			dropped->s.frame = 0;
		else if(dropped->count == 9)
			dropped->s.frame = 1;
		else if(dropped->count == 8)
			dropped->s.frame = 2;
		else if(dropped->count == 7)
			dropped->s.frame = 3;
		else if(dropped->count == 6)
			dropped->s.frame = 4;
		else if(dropped->count == 5)
			dropped->s.frame = 5;
		else if(dropped->count == 4)
			dropped->s.frame = 6;
		else if(dropped->count == 3)
			dropped->s.frame = 7;
		else if(dropped->count == 2)
			dropped->s.frame = 8;
		else if(dropped->count == 1)
			dropped->s.frame = 9;
	}
	//TROND slutt

	if (ent->client->pers.weapon &&
		ent->client->pers.weapon->tag == AMMO_GRENADES &&
		item->tag == AMMO_GRENADES &&
		ent->client->pers.inventory[index] - dropped->count <= 0) {
		gi.cprintf (ent, PRINT_HIGH, "Can't drop current weapon\n");
		G_FreeEdict(dropped);
		return;
	}

	ent->client->pers.inventory[index] -= dropped->count;
	ValidateSelectedItem (ent);
}


//======================================================================

void MegaHealth_think (edict_t *self)
{
	if (self->owner->health > self->owner->max_health
//ZOID
		&& !CTFHasRegeneration(self->owner)
//ZOID
		)
	{
		self->nextthink = level.time + 1;
		self->owner->health -= 1;
		return;
	}

	if (!(self->spawnflags & DROPPED_ITEM) && (deathmatch->value))
		SetRespawn (self, 20);
	else
		G_FreeEdict (self);
}

qboolean Pickup_Health (edict_t *ent, edict_t *other)
{
	if (!(ent->style & HEALTH_IGNORE_MAX))
		if (other->health >= other->max_health)
			return false;

//ZOID
	if (other->health >= 250 && ent->count > 25)
		return false;
//ZOID

	other->health += ent->count;

//ZOID
	if (other->health > 250 && ent->count > 25)
		other->health = 250;
//ZOID

	if (!(ent->style & HEALTH_IGNORE_MAX))
	{
		if (other->health > other->max_health)
			other->health = other->max_health;
	}

//ZOID
	if ((ent->style & HEALTH_TIMED)
		&& !CTFHasRegeneration(other)
//ZOID
	)
	{
		ent->think = MegaHealth_think;
		ent->nextthink = level.time + 5;
		ent->owner = other;
		ent->flags |= FL_RESPAWN;
		ent->svflags |= SVF_NOCLIENT;
		ent->solid = SOLID_NOT;
	}
	else
	{
		if (!(ent->spawnflags & DROPPED_ITEM) && (deathmatch->value))
			SetRespawn (ent, 30);
	}

	return true;
}

//======================================================================

int ArmorIndex (edict_t *ent)
{
	if (!ent->client)
		return 0;

	if (ent->client->pers.inventory[jacket_armor_index] > 0)
		return jacket_armor_index;

	if (ent->client->pers.inventory[combat_armor_index] > 0)
		return combat_armor_index;

	if (ent->client->pers.inventory[body_armor_index] > 0)
		return body_armor_index;

	return 0;
}

qboolean Pickup_Armor (edict_t *ent, edict_t *other)
{
	int				old_armor_index;
	gitem_armor_t	*oldinfo;
	gitem_armor_t	*newinfo;
	int				newcount;
	float			salvage;
	int				salvagecount;

	// get info on new armor
	newinfo = (gitem_armor_t *)ent->item->info;

	old_armor_index = ArmorIndex (other);

	// handle armor shards specially
	if (ent->item->tag == ARMOR_SHARD)
	{
		if (!old_armor_index)
			other->client->pers.inventory[jacket_armor_index] = 2;
		else
			other->client->pers.inventory[old_armor_index] += 2;
	}

	// if player has no armor, just use it
	else if (!old_armor_index)
	{
		other->client->pers.inventory[ITEM_INDEX(ent->item)] = newinfo->base_count;
	}

	// use the better armor
	else
	{
		// get info on old armor
		if (old_armor_index == jacket_armor_index)
			oldinfo = &jacketarmor_info;
		else if (old_armor_index == combat_armor_index)
			oldinfo = &combatarmor_info;
		else // (old_armor_index == body_armor_index)
			oldinfo = &bodyarmor_info;

		if (newinfo->normal_protection > oldinfo->normal_protection)
		{
			// calc new armor values
			salvage = oldinfo->normal_protection / newinfo->normal_protection;
			salvagecount = salvage * other->client->pers.inventory[old_armor_index];
			newcount = newinfo->base_count + salvagecount;
			if (newcount > newinfo->max_count)
				newcount = newinfo->max_count;

			// zero count of old armor so it goes away
			other->client->pers.inventory[old_armor_index] = 0;

			// change armor to new item with computed value
			other->client->pers.inventory[ITEM_INDEX(ent->item)] = newcount;
		}
		else
		{
			// calc new armor values
			salvage = newinfo->normal_protection / oldinfo->normal_protection;
			salvagecount = salvage * newinfo->base_count;
			newcount = other->client->pers.inventory[old_armor_index] + salvagecount;
			if (newcount > oldinfo->max_count)
				newcount = oldinfo->max_count;

			// if we're already maxed out then we don't need the new armor
			if (other->client->pers.inventory[old_armor_index] >= newcount)
				return false;

			// update current armor value
			other->client->pers.inventory[old_armor_index] = newcount;
		}
	}

	if (!(ent->spawnflags & DROPPED_ITEM) && (deathmatch->value))
		SetRespawn (ent, 20);

	return true;
}

//======================================================================

int PowerArmorType (edict_t *ent)
{
	if (!ent->client)
		return POWER_ARMOR_NONE;

	if (!(ent->flags & FL_POWER_ARMOR))
		return POWER_ARMOR_NONE;

	if (ent->client->pers.inventory[power_shield_index] > 0)
		return POWER_ARMOR_SHIELD;

	if (ent->client->pers.inventory[power_screen_index] > 0)
		return POWER_ARMOR_SCREEN;

	return POWER_ARMOR_NONE;
}

void Use_PowerArmor (edict_t *ent, gitem_t *item)
{
	int		index;

	if (ent->flags & FL_POWER_ARMOR)
	{
		ent->flags &= ~FL_POWER_ARMOR;
		gi.sound(ent, CHAN_AUTO, gi.soundindex("misc/power2.wav"), 1, ATTN_NORM, 0);
	}
	else
	{
		index = ITEM_INDEX(FindItem("1911clip"));
		if (!ent->client->pers.inventory[index])
		{
			gi.cprintf (ent, PRINT_HIGH, "No cells for power armor.\n");
			return;
		}
		ent->flags |= FL_POWER_ARMOR;
		gi.sound(ent, CHAN_AUTO, gi.soundindex("misc/power1.wav"), 1, ATTN_NORM, 0);
	}
}

qboolean Pickup_PowerArmor (edict_t *ent, edict_t *other)
{
	int		quantity;

	quantity = other->client->pers.inventory[ITEM_INDEX(ent->item)];

	other->client->pers.inventory[ITEM_INDEX(ent->item)]++;

	if (deathmatch->value)
	{
		/*TROND
		//TATT VEKK SÅ DET IKKJE RESPAWNER
		if (!(ent->spawnflags & DROPPED_ITEM) )
			SetRespawn (ent, ent->item->quantity);
		//TROND slutt*/
		// auto-use for DM only if we didn't already have one
		if (!quantity)
			ent->item->use (other, ent->item);
	}

	return true;
}

void Drop_PowerArmor (edict_t *ent, gitem_t *item)
{
	if ((ent->flags & FL_POWER_ARMOR) && (ent->client->pers.inventory[ITEM_INDEX(item)] == 1))
		Use_PowerArmor (ent, item);
	Drop_General (ent, item);
}

//======================================================================

/*
===============
Touch_Item
===============
*/
void Touch_Item (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf)
{
	qboolean	taken;

	if (!other->client)
		return;
	if (other->health < 1)
		return;		// dead people can't pickup
	if (!ent->item->pickup)
		return;		// not a grabbable item?

	taken = ent->item->pickup(ent, other);

	if (taken)
	{
		// flash the screen
		other->client->bonus_alpha = 0.5;

		// show icon and name on status bar
		other->client->ps.stats[STAT_PICKUP_ICON] = gi.imageindex(ent->item->icon);
		other->client->ps.stats[STAT_PICKUP_STRING] = CS_ITEMS+ITEM_INDEX(ent->item);
		other->client->pickup_msg_time = level.time + 3.0;

		// change selected item
		if (ent->item->use)
			other->client->pers.selected_item = other->client->ps.stats[STAT_SELECTED_ITEM] = ITEM_INDEX(ent->item);

		if (ent->item->pickup == Pickup_Health)
		{
			if (ent->count == 2)
				gi.sound(other, CHAN_ITEM, gi.soundindex("items/s_health.wav"), 1, ATTN_NORM, 0);
			else if (ent->count == 10)
				gi.sound(other, CHAN_ITEM, gi.soundindex("items/n_health.wav"), 1, ATTN_NORM, 0);
			else if (ent->count == 25)
				gi.sound(other, CHAN_ITEM, gi.soundindex("items/l_health.wav"), 1, ATTN_NORM, 0);
			else // (ent->count == 100)
				gi.sound(other, CHAN_ITEM, gi.soundindex("items/m_health.wav"), 1, ATTN_NORM, 0);
		}
		else if (ent->item->pickup_sound)
		{
			gi.sound(other, CHAN_ITEM, gi.soundindex(ent->item->pickup_sound), 1, ATTN_NORM, 0);
		}
	}

	if (!(ent->spawnflags & ITEM_TARGETS_USED))
	{
		G_UseTargets (ent, other);
		ent->spawnflags |= ITEM_TARGETS_USED;
	}

	if (!taken)
		return;

	if (!((coop->value) &&  (ent->item->flags & IT_STAY_COOP)) || (ent->spawnflags & (DROPPED_ITEM | DROPPED_PLAYER_ITEM)))
	{
		if (ent->flags & FL_RESPAWN)
			ent->flags &= ~FL_RESPAWN;
		else
			G_FreeEdict (ent);
	}

	//TROND
	//SNODIG BUG
	//G_FreeEdict (ent);
	//TROND slutt
}

//======================================================================

static void drop_temp_touch (edict_t *ent, edict_t *other, cplane_t *plane, csurface_t *surf)
{
	if (other == ent->owner)
		return;

	Touch_Item (ent, other, plane, surf);
}

static void drop_make_touchable (edict_t *ent)
{
	ent->touch = Touch_Item;

//TROND		9/3 får ammo til å forsvinne etter 30 sek etter utkast...
	if ((ent->item->pickup == Pickup_Ammo
		|| ent->item == FindItem("1911"))
		&& deathmatch->value)//I sp blir ammo liggande 19/3
	{
		ent->nextthink = level.time + 30;
		ent->think = G_FreeEdict;
	}
//TROND slutt

/*	if (deathmatch->value)
	{
		//TROND
		//TATT VEKK SLIK AT VÅPEN BLIR LIGGANDE FOR ALLTID NÅR DEI BLIR KASTA UT
		//ent->nextthink = level.time + 29;
		//ent->think = G_FreeEdict;
		//TROND slutt
	}*/
}

edict_t *Drop_Item (edict_t *ent, gitem_t *item)
{
	edict_t	*dropped;
	vec3_t	forward, right;
	vec3_t	offset;

	dropped = G_Spawn();

	dropped->classname = item->classname;
	dropped->item = item;
	dropped->spawnflags = DROPPED_ITEM;
	dropped->s.effects = item->world_model_flags;
	//TROND
//	dropped->s.renderfx = RF_GLOW;
	//TROND slutt
	VectorSet (dropped->mins, -15, -15, -15);
	VectorSet (dropped->maxs, 15, 15, 15);
	gi.setmodel (dropped, dropped->item->world_model);
	dropped->solid = SOLID_TRIGGER;
	dropped->movetype = MOVETYPE_TOSS;
	dropped->touch = drop_temp_touch;
	dropped->owner = ent;
	dropped->s.angles[YAW] = ent->s.angles[YAW];//TROND reting på tossa ting :^)

	if (ent->client)
	{
		trace_t	trace;

		AngleVectors (ent->client->v_angle, forward, right, NULL);
		VectorSet(offset, 24, 0, -16);
		G_ProjectSource (ent->s.origin, offset, forward, right, dropped->s.origin);
		trace = gi.trace (ent->s.origin, dropped->mins, dropped->maxs,
			dropped->s.origin, ent, CONTENTS_SOLID);
		VectorCopy (trace.endpos, dropped->s.origin);
	}
	else
	{
		AngleVectors (ent->s.angles, forward, right, NULL);
		VectorCopy (ent->s.origin, dropped->s.origin);
	}

	VectorScale (forward, 100, dropped->velocity);
	dropped->velocity[2] = 300;

	dropped->think = drop_make_touchable;
	dropped->nextthink = level.time + 1;

	gi.linkentity (dropped);

	return dropped;
}

void Use_Item (edict_t *ent, edict_t *other, edict_t *activator)
{
	ent->svflags &= ~SVF_NOCLIENT;
	ent->use = NULL;

	if (ent->spawnflags & ITEM_NO_TOUCH)
	{
		ent->solid = SOLID_BBOX;
		ent->touch = NULL;
	}
	else
	{
		ent->solid = SOLID_TRIGGER;
		ent->touch = Touch_Item;
	}

	gi.linkentity (ent);
}

//======================================================================

/*
================
droptofloor
================
*/
void droptofloor (edict_t *ent)
{
	trace_t		tr;
	vec3_t		dest;
	float		*v;

	v = tv(-15,-15,-15);
	VectorCopy (v, ent->mins);
	v = tv(15,15,15);
	VectorCopy (v, ent->maxs);

	if (ent->model)
		gi.setmodel (ent, ent->model);
	else
		gi.setmodel (ent, ent->item->world_model);
	ent->solid = SOLID_TRIGGER;
	ent->movetype = MOVETYPE_TOSS;
	ent->touch = Touch_Item;

	v = tv(0,0,-128);
	VectorAdd (ent->s.origin, v, dest);

	tr = gi.trace (ent->s.origin, ent->mins, ent->maxs, dest, ent, MASK_SOLID);
	if (tr.startsolid)
	{
		gi.dprintf ("droptofloor: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin));
		G_FreeEdict (ent);
		return;
	}

	VectorCopy (tr.endpos, ent->s.origin);

	if (ent->team)
	{
		ent->flags &= ~FL_TEAMSLAVE;
		ent->chain = ent->teamchain;
		ent->teamchain = NULL;

		ent->svflags |= SVF_NOCLIENT;
		ent->solid = SOLID_NOT;
		/*TROND
		//TATT VEKK
		if (ent == ent->teammaster)
		{
			ent->nextthink = level.time + FRAMETIME;
			ent->think = DoRespawn;
		}
		//TROND slutt*/
	}

	if (ent->spawnflags & ITEM_NO_TOUCH)
	{
		ent->solid = SOLID_BBOX;
		ent->touch = NULL;
		ent->s.effects &= ~EF_ROTATE;
		ent->s.renderfx &= ~RF_GLOW;
	}

	if (ent->spawnflags & ITEM_TRIGGER_SPAWN)
	{
		ent->svflags |= SVF_NOCLIENT;
		ent->solid = SOLID_NOT;
		ent->use = Use_Item;
	}

	gi.linkentity (ent);
}


/*
===============
PrecacheItem

Precaches all data needed for a given item.
This will be called for each item spawned in a level,
and for each item in each client's inventory.
===============
*/
void PrecacheItem (gitem_t *it)
{
	char	*s, *start;
	char	data[MAX_QPATH];
	int		len;
	gitem_t	*ammo;

	if (!it)
		return;

	if (it->pickup_sound)
		gi.soundindex (it->pickup_sound);
	if (it->world_model)
		gi.modelindex (it->world_model);
	if (it->view_model)
		gi.modelindex (it->view_model);
	if (it->icon)
		gi.imageindex (it->icon);

	// parse everything for its ammo
	if (it->ammo && it->ammo[0])
	{
		ammo = FindItem (it->ammo);
		if (ammo != it)
			PrecacheItem (ammo);
	}

	// parse the space seperated precache string for other items
	s = it->precaches;
	if (!s || !s[0])
		return;

	while (*s)
	{
		start = s;
		while (*s && *s != ' ')
			s++;

		len = s-start;
		if (len >= MAX_QPATH || len < 5)
			gi.error ("PrecacheItem: %s has bad precache string", it->classname);
		memcpy (data, start, len);
		data[len] = 0;
		if (*s)
			s++;

		// determine type based on extension
		if (!strcmp(data+len-3, "md2"))
			gi.modelindex (data);
		else if (!strcmp(data+len-3, "sp2"))
			gi.modelindex (data);
		else if (!strcmp(data+len-3, "wav"))
			gi.soundindex (data);
		if (!strcmp(data+len-3, "pcx"))
			gi.imageindex (data);
	}
}

/*
============
SpawnItem

Sets the clipping size and plants the object on the floor.

Items can't be immediately dropped to floor, because they might
be on an entity that hasn't spawned yet.
============
*/
void SpawnItem (edict_t *ent, gitem_t *item)
{
	PrecacheItem (item);

	//TROND 20/3 hindrer våpen/ammo å spawne i SP
	//tatt vekk 29/3
/*	if (!deathmatch->value
		&& (item->pickup == Pickup_Weapon
		|| item->pickup == Pickup_Ammo
		|| item->pickup == Pickup_NoAmmo_Weapon
		|| item->pickup == Pickup_Item))
	{
		G_FreeEdict (ent);
		return;
	}*/
	//TROND slutt


	if (ent->spawnflags)
	{
		if (strcmp(ent->classname, "key_power_cube") != 0)
		{
			ent->spawnflags = 0;
			gi.dprintf("%s at %s has invalid spawnflags set\n", ent->classname, vtos(ent->s.origin));
		}
	}

	// some items will be prevented in deathmatch
	if (deathmatch->value)
	{
		if ( (int)dmflags->value & DF_NO_ARMOR )
		{
			if (item->pickup == Pickup_Armor || item->pickup == Pickup_PowerArmor)
			{
				G_FreeEdict (ent);
				return;
			}
		}
		if ( (int)dmflags->value & DF_NO_ITEMS )
		{
			if (item->pickup == Pickup_Powerup)
			{
				G_FreeEdict (ent);
				return;
			}
		}
		if ( (int)dmflags->value & DF_NO_HEALTH )
		{
			if (item->pickup == Pickup_Health || item->pickup == Pickup_Adrenaline || item->pickup == Pickup_AncientHead)
			{
				G_FreeEdict (ent);
				return;
			}
		}
		if ( (int)dmflags->value & DF_INFINITE_AMMO )
		{
			if ( (item->flags == IT_AMMO) || (strcmp(ent->classname, "weapon_bfg") == 0) )
			{
				G_FreeEdict (ent);
				return;
			}
		}
	}

	if (coop->value && (strcmp(ent->classname, "key_power_cube") == 0))
	{
		ent->spawnflags |= (1 << (8 + level.power_cubes));
		level.power_cubes++;
	}

	// don't let them drop items that stay in a coop game
	if ((coop->value) && (item->flags & IT_STAY_COOP))
	{
		item->drop = NULL;
	}

//ZOID
//Don't spawn the flags unless enabled
	if (!ctf->value && (strcmp(ent->classname, "item_flag_team1") == 0 || strcmp(ent->classname, "item_flag_team2") == 0)) 
	{
		G_FreeEdict(ent);
		return;
	}
//ZOID

//TROND ATL 9/4
//Don't spawn the flags unless enabled
	if (leader->value && (strcmp(ent->classname, "item_flag_team1") == 0 || strcmp(ent->classname, "item_flag_team2") == 0)) 
	{
		G_FreeEdict(ent);
		return;
	}
//TROND slutt

	//TROND anti-eksplosiv 11/4
	if (!explosives->value)
	{
		if ((strcmp(ent->classname, "item_detonator") == 0)
			|| (strcmp(ent->classname, "ammo_grenades") == 0)
			|| (strcmp(ent->classname, "weapon_mine") == 0)
			|| (strcmp(ent->classname, "weapon_c4") == 0))
		{
			G_FreeEdict (ent);
			return;
		}
	}

	//TROND slutt

	ent->item = item;
	ent->nextthink = level.time + 2 * FRAMETIME;    // items start after other solids
	ent->think = droptofloor;
	ent->s.effects = item->world_model_flags;
	//TROND
	ent->s.renderfx = 0;
	//TROND slutt
	if (ent->model)
		gi.modelindex (ent->model);

//ZOID
//flags are server animated and have special handling
	//TROND
	//TURBOMEKK PÅ FLAGG
//	if (strcmp(ent->classname, "item_flag_team1") == 0 ||
//		strcmp(ent->classname, "item_flag_team2") == 0) 
//	{
//		ent->think = CTFFlagSetup;
//	}

	if (strcmp(ent->classname, "item_flag_team1") == 0)
		ent->think = CTFFlagSetup;//CTFTerrorFlagSetup;

	if (strcmp(ent->classname, "item_flag_team2") == 0)
		ent->think = CTFFlagSetup;

//ZOID
}

//======================================================================

gitem_t	itemlist[] =
{
	{
		NULL
	},	// leave index 0 alone

	//
	// ARMOR
	//

/*QUAKED item_armor_body (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "item_armor_body",
		Pickup_Armor,
		NULL,
		NULL,
		NULL,
		"misc/ar1_pkup.wav",
		"models/items/armor/body/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"i_bodyarmor",
/* pickup */	"Body Armor",
/* width */		3,
		0,
		NULL,
		IT_ARMOR,
		0,
		&bodyarmor_info,
		ARMOR_BODY,
/* precache */ ""
	},

/*QUAKED item_armor_combat (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "item_armor_combat",
		Pickup_Armor,
		NULL,
		NULL,
		NULL,
		"misc/ar1_pkup.wav",
		"models/items/armor/combat/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"i_combatarmor",
/* pickup */	"Combat Armor",
/* width */		3,
		0,
		NULL,
		IT_ARMOR,
		0,
		&combatarmor_info,
		ARMOR_COMBAT,
/* precache */ ""
	},

	//TROND
	//IR Briller
	{
		"item_ir",//TROND var "item_armor_combat",
		Pickup_Item,
		NULL,
		Drop_SpecialItem,
		NULL,
		"misc/ar1_pkup.wav",
		"models/slat/irgoggles/irgoggles.md2", 0,
		NULL,
/* icon */		"i_irgoggles",
/* pickup */	"IR Goggles",
/* width */		3,
		0,
		NULL,
		IT_ARMOR,
		0,
		NULL,
		ARMOR_JACKET,
/* precache */ ""
	},
	//TROND slutt

/*QUAKED item_armor_jacket (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"NULL",//TROND var "item_armor_jacket",
		Pickup_Armor,
		NULL,
		NULL,
		NULL,
		"misc/ar1_pkup.wav",
		"models/items/armor/jacket/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"i_jacketarmor",
/* pickup */	"Jacket Armor",
/* width */		3,
		0,
		NULL,
		IT_ARMOR,
		0,
		&jacketarmor_info,
		ARMOR_JACKET,
/* precache */ ""
	},

/*QUAKED item_armor_shard (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "item_armor_shard",
		Pickup_Armor,
		NULL,
		NULL,
		NULL,
		"misc/ar2_pkup.wav",
		"models/items/armor/shard/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"i_jacketarmor",
/* pickup */	"Armor Shard",
/* width */		3,
		0,
		NULL,
		IT_ARMOR,
		0,
		NULL,
		ARMOR_SHARD,
/* precache */ ""
	},

	//TROND
	//HJELM
	{
		"item_helmet",//TROND var "item_armor_shard",
		Pickup_Item,
		NULL,
		Drop_SpecialItem,
		NULL,
		"misc/ar2_pkup.wav",
		"models/slat/helmet/helmet.md2", 0,
		NULL,
/* icon */		"i_helmet",
/* pickup */	"Helmet",
/* width */		3,
		0,
		NULL,
		IT_ARMOR,
		0,
		NULL,
		ARMOR_SHARD,
/* precache */ ""
	},
	//TROND slutt


/*QUAKED item_power_screen (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"NULL",//TROND var "item_power_screen",
		Pickup_PowerArmor,
		Use_PowerArmor,
		Drop_PowerArmor,
		NULL,
		"misc/ar3_pkup.wav",
		"models/items/armor/screen/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"i_powerscreen",
/* pickup */	"Power Screen",
/* width */		0,
		60,
		NULL,
		IT_ARMOR,
		0,
		NULL,
		0,
/* precache */ ""
	},

	//TROND
	//VEST
	{
		"item_vest",//TROND var "item_power_screen",
		Pickup_Item,
		NULL,
		Drop_SpecialItem,
		NULL,
		"misc/ar3_pkup.wav",
		"models/slat/vest/vest.md2", 0,
		NULL,
/* icon */		"i_vest",
/* pickup */	"Bullet Proof Vest",
/* width */		0,
		0,
		NULL,
		IT_ARMOR,
		0,
		NULL,
		0,
/* precache */ ""
	},
	//TROND slutt

/*QUAKED item_power_shield (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "item_power_shield",
		Pickup_PowerArmor,
		Use_PowerArmor,
		Drop_PowerArmor,
		NULL,
		"misc/ar3_pkup.wav",
		"models/items/armor/shield/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"i_powershield",
/* pickup */	"Power Shield",
/* width */		0,
		60,
		NULL,
		IT_ARMOR,
		0,
		NULL,
		0,
/* precache */ "misc/power2.wav misc/power1.wav"
	},
	//TROND
	//TERROR ITEMS
	//MEDKIT
	{
		"item_medkit",//TROND var "item_armor_body",
		Pickup_Item,
		NULL,
		Drop_SpecialItem,
		NULL,
		"misc/ar1_pkup.wav",
		"models/slat/medkit/medkit.md2", 0,
		NULL,
/* icon */		"i_medkit",
/* pickup */	"MedKit",
/* width */		3,
		0,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},

	//FLASHLIGHT
	{
		"item_light",//TROND var "item_armor_body",
		Pickup_Item,
		NULL,
		Drop_SpecialItem,
		NULL,
		"misc/ar1_pkup.wav",
		"models/slat/flashlight/flashlight.md2", 0,
		NULL,
/* icon */		"i_headlight",
/* pickup */	"Head Light",
/* width */		3,
		0,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},

	//SCUBA GEAR
	{
		"item_scuba",//TROND var "item_armor_body",
		Pickup_Item,
		NULL,
		Drop_SpecialItem,
		NULL,
		"misc/ar1_pkup.wav",
		"models/slat/scuba/scuba.md2", 0,
		NULL,
/* icon */		"i_scuba",
/* pickup */	"Scuba Gear",
/* width */		3,
		0,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},
	//TROND slutt

	//VEKT I SP
	{
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		"misc/ar1_pkup.wav",
		"models/slat/scuba/scuba.md2", 0,
		NULL,
/* icon */		"i_scuba",
/* pickup */	"Weight",
/* width */		3,
		0,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},
	//TROND slutt


	//
	// WEAPONS
	//

/* weapon_grapple (.3 .3 1) (-16 -16 -16) (16 16 16)
always owned, never in the world
*/
	{
		"weapon_grapple",
		NULL,
		Use_Weapon,
		NULL,
		CTFWeapon_Grapple,
		"misc/w_pkup.wav",
		NULL, 0,
		"models/weapons/grapple/tris.md2",
/* icon */		"w_grapple",
/* pickup */	"Grapple",
		0,
		0,
		NULL,
		IT_WEAPON|IT_STAY_COOP,
		WEAP_GRAPPLE,
		NULL,
		0,
/* precache */ "weapons/grapple/grfire.wav weapons/grapple/grpull.wav weapons/grapple/grhang.wav weapons/grapple/grreset.wav weapons/grapple/grhit.wav"
	},

/* weapon_blaster (.3 .3 1) (-16 -16 -16) (16 16 16)
always owned, never in the world
*/
	{
		"weapon_1911",
		//TROND
		//MEKKA SLIK AT DET GÅR AN Å KASTE/PLUKKE OPP BLASTER
		Pickup_Weapon,//TROND skal vere Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,//TROND skal vere Drop_Weapon,
		Weapon_Blaster,
		"misc/w_pkup.wav",
		"models/slat/world_t1911/world_t1911.md2", 0,//BYTTA UT EF_ROTATE MED NULL
		"models/slat/t1911/t1911.md2",
/* icon */		"w_1911",
//TROND
/* pickup */	"1911",//"Blaster",
//TROND slutt
		0,
		1,
		"1911rounds",//ammo?
		//TROND slutt
		IT_WEAPON|IT_STAY_COOP,
		2,//WEAP_BLASTER,//TROND 19/3 VWEP nummer
		NULL,
		0,
/* precache */ "weapons/blastf1a.wav misc/lasfly.wav"
	},

/*QUAKED weapon_shotgun (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"weapon_shotgun",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Shotgun,
		"misc/w_pkup.wav",
		"models/slat/world_mossberg/world_mossberg.md2", 0,
		"models/slat/mossberg/mossberg.md2",
/* icon */		"w_mariner",
/* pickup */	"MARINER",
		0,
		1,
		"MARINERrounds",
		IT_WEAPON|IT_STAY_COOP,
		3,//WEAP_SHOTGUN,
		NULL,
		0,
/* precache */ "weapons/shotgf1b.wav weapons/shotgr1b.wav"
	},

/*QUAKED weapon_supershotgun (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "weapon_supershotgun",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_SuperShotgun,
		"misc/w_pkup.wav",
		"models/weapons/g_shotg2/tris.md2", 0,
		"models/weapons/v_shotg2/tris.md2",
/* icon */		"w_sshotgun",
/* pickup */	"Super Shotgun",
		0,
		2,
		"MARINERshells",
		IT_WEAPON|IT_STAY_COOP,
		WEAP_SUPERSHOTGUN,
		NULL,
		0,
/* precache */ "weapons/sshotf1b.wav"
	},

/*QUAKED weapon_machinegun (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"weapon_machinegun",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Machinegun,
		"misc/w_pkup.wav",
		"models/slat/world_uzi/world_uzi.md2", 0,
		"models/slat/uzi/uzi.md2",
/* icon */		"w_uzi",
/* pickup */	"UZI",
		0,
		1,
		"UZIrounds",
		IT_WEAPON|IT_STAY_COOP,
		4,//WEAP_MACHINEGUN,
		NULL,
		0,
/* precache */ "slat/weapons/uzi_fire.wav"
	},

/*QUAKED weapon_chaingun (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "weapon_chaingun",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Chaingun,
		"misc/w_pkup.wav",
		"models/weapons/g_chain/tris.md2", 0,
		"models/weapons/v_chain/tris.md2",
/* icon */		"w_chaingun",
/* pickup */	"Chaingun",
		0,
		1,
		"UZIclip",//kuler
		IT_WEAPON|IT_STAY_COOP,
		WEAP_CHAINGUN,
		NULL,
		0,
/* precache */ "weapons/chngnu1a.wav weapons/chngnl1a.wav weapons/machgf3b.wav` weapons/chngnd1a.wav"
	},

/*QUAKED ammo_grenades (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"ammo_grenades",
		Pickup_Ammo,
		Use_Weapon,
		Drop_Ammo,
		Weapon_Grenade,
		"misc/am_pkup.wav",
		"models/slat/world_grenade/world_grenade.md2", 0,
		"models/slat/grenade/grenade.md2",
/* icon */		"a_grenades",
/* pickup */	"Grenades",
/* width */		3,
		1,//TROND var 5
		"grenades",
		IT_AMMO|IT_WEAPON,
		11,//WEAP_GRENADES,
		NULL,
		AMMO_GRENADES,
/* precache */ "models/slat/world_grenade/world_grenade_pinout.md2 weapons/hgrent1a.wav weapons/hgrena1b.wav weapons/hgrenc1b.wav weapons/hgrenb1a.wav weapons/hgrenb2a.wav "
	},

/*QUAKED weapon_grenadelauncher (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "weapon_grenadelauncher",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_GrenadeLauncher,
		"misc/w_pkup.wav",
		"models/weapons/g_launch/tris.md2", 0,
		"models/weapons/v_launch/tris.md2",
/* icon */		"w_glauncher",
/* pickup */	"Grenade Launcher",
		0,
		1,
		"grenades",
		IT_WEAPON|IT_STAY_COOP,
		WEAP_GRENADELAUNCHER,
		NULL,
		0,
/* precache */ "models/objects/grenade/tris.md2 weapons/grenlf1a.wav weapons/grenlr1b.wav weapons/grenlb1b.wav"
	},

/*QUAKED weapon_rocketlauncher (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "weapon_rocketlauncher",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_RocketLauncher,
		"misc/w_pkup.wav",
		"models/weapons/g_rocket/tris.md2", 0,
		"models/weapons/v_rocket/tris.md2",
/* icon */		"w_rlauncher",
/* pickup */	"Rocket Launcher",
		0,
		1,
		"Rockets",
		IT_WEAPON|IT_STAY_COOP,
		WEAP_ROCKETLAUNCHER,
		NULL,
		0,
/* precache */ "models/objects/rocket/tris.md2 weapons/rockfly.wav weapons/rocklf1a.wav weapons/rocklr1b.wav models/objects/debris2/tris.md2"
	},

/*QUAKED weapon_hyperblaster (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "weapon_hyperblaster",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_HyperBlaster,
		"misc/w_pkup.wav",
		"models/slat/world_c4/world_c4.md2", 0,
		"models/slat/c4/c4.md2",
/* icon */		"w_hyperblaster",
/* pickup */	"HyperBlaster",
		0,
		1,
		"Grenades",
		IT_WEAPON|IT_STAY_COOP,
		WEAP_HYPERBLASTER,
		NULL,
		0,
/* precache */ "weapons/hyprbu1a.wav weapons/hyprbl1a.wav weapons/hyprbf1a.wav weapons/hyprbd1a.wav misc/lasfly.wav"
	},

/*QUAKED weapon_railgun (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"weapon_chaingun",//TROND var "weapon_railgun",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Railgun,
		"misc/w_pkup.wav",
		"models/slat/world_barrett/world_barrett.md2", 0,
		"models/slat/barrett/barrett.md2",
/* icon */		"w_barrett",
/* pickup */	"BARRETT",
		0,
		1,
		//TROND
		"50cal",
		//TROND slutt
		IT_WEAPON|IT_STAY_COOP,
		7,//WEAP_RAILGUN,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED weapon_bfg (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "weapon_bfg",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_BFG,
		"misc/w_pkup.wav",
		"models/weapons/g_bfg/tris.md2", 0,
		"models/weapons/v_bfg/tris.md2",
/* icon */		"w_bfg",
/* pickup */	"BFG10K",
		0,
		50,
		"1911clip",
		IT_WEAPON|IT_STAY_COOP,
		WEAP_BFG,
		NULL,
		0,
/* precache */ ""//"sprites/s_bfg1.sp2 sprites/s_bfg2.sp2 sprites/s_bfg3.sp2 weapons/bfg__f1y.wav weapons/bfg__l1a.wav weapons/bfg__x1b.wav weapons/bfg_hum.wav"
	},

	//TROND
	//NYE VÅPEN I TERROR
	//TROND c4 detpack
	{
		"weapon_c4",
		Pickup_Ammo,
		Use_Weapon,
		Drop_Weapon,
		Weapon_C4,
		"misc/w_pkup.wav",
		"models/slat/world_c4/world_c4.md2", 0,
		"models/slat/c4/c4.md2",
/* icon */		"a_detpack",
/* pickup */	"C4 Detpack",
		0,
		1,
		"c4 detpack",
		IT_WEAPON|IT_STAY_COOP,
		8,
		NULL,
		0,
/* precache */ ""
	},

	//TROND detonator
	{
		"item_detonator",
		Pickup_NoAmmo_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Detonator,
		"misc/w_pkup.wav",
		"models/slat/world_detonator/world_detonator.md2", 0,
		"models/slat/detonator/detonator.md2",
/* icon */		"w_detonator",
/* pickup */	"Detonator",
		0,
		0,
		NULL,
		IT_WEAPON|IT_STAY_COOP,
		10,
		NULL,
		0,
/* precache */ ""
	},

	//TROND AK47
	{
		"weapon_bfg",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_AK,
		"misc/w_pkup.wav",
		"models/slat/world_ak47/world_ak47.md2", 0,
		"models/slat/ak47/ak47.md2",
/* icon */		"w_ak47",
/* pickup */	"AK 47",
		0,
		1,
		"ak47rounds",
		IT_WEAPON|IT_STAY_COOP,
		5,
		NULL,
		0,
/* precache */ ""
	},

	//TROND GLOCK
	{
		//	7/3 tatt vekk pga crash bug
		//	8/3 tatt med igjen
		"weapon_glock",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Glock,
		"misc/w_pkup.wav",
		"models/slat/world_glock/world_glock.md2", 0,
		"models/slat/glock/glock.md2",
/* icon */		"w_glock",
/* pickup */	"Glock",
		0,
		1,
		"glockrounds",
		IT_WEAPON|IT_STAY_COOP,
		6,
		NULL,
		0,
/* precache */ ""
	},

	//TROND CASULL
	{
		//	7/3 tatt vekk pga crash bug
		//	8/3 tatt med igjen
		"weapon_casull",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Casull,
		"misc/w_pkup.wav",
		"models/slat/world_casull/world_casull.md2", 0,
		"models/slat/casull/casull.md2",
/* icon */		"w_casull",
/* pickup */	"CASULL",
		0,
		1,
		"casullrounds",
		IT_WEAPON|IT_STAY_COOP,
		12,
		NULL,
		0,
/* precache */ ""
	},

	//TROND BERETTA
	{
		"weapon_beretta",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Beretta,
		"misc/w_pkup.wav",
		"models/slat/world_beretta/world_beretta.md2", 0,
		"models/slat/beretta/beretta.md2",
/* icon */		"w_beretta",
/* pickup */	"BERETTA",
		0,
		1,
		"berettarounds",
		IT_WEAPON|IT_STAY_COOP,
		13,
		NULL,
		0,
/* precache */ ""
	},

	//TROND MP5   27/3
	{
		"weapon_mp5",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_MP5,
		"misc/w_pkup.wav",
		"models/slat/world_mp5/world_mp5.md2", 0,
		"models/slat/mp5/mp5.md2",
/* icon */		"w_mp5",
/* pickup */	"MP5",
		0,
		1,
		"mp5rounds",
		IT_WEAPON|IT_STAY_COOP,
		14,
		NULL,
		0,
/* precache */ ""
	},

	//TROND M60   1/4
	{
		"weapon_m60",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_M60,
		"misc/w_pkup.wav",
		"models/slat/world_m60/world_m60.md2", 0,
		"models/slat/m60/m60.md2",
/* icon */		"w_m60",
/* pickup */	"M60",
		0,
		1,
		"m60rounds",
		IT_WEAPON|IT_STAY_COOP,
		15,
		NULL,
		0,
/* precache */ ""
	},

	//TROND MSG90   3/4
	{
		"weapon_msg90",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_MSG90,
		"misc/w_pkup.wav",
		"models/slat/world_msg90/world_msg90.md2", 0,
		"models/slat/msg90/msg90.md2",
/* icon */		"w_msg90",
/* pickup */	"MSG90",
		0,
		1,
		"msg90rounds",
		IT_WEAPON|IT_STAY_COOP,
		16,
		NULL,
		0,
/* precache */ ""
	},

	//TROND kick
	{
		"weapon_kick",
		NULL,
		Use_Weapon,
		NULL,
		Weapon_Kick,
		"misc/w_pkup.wav",
		NULL, 0,
		"models/slat/leg/leg.md2",
/* icon */		"w_hyperblaster",
/* pickup */	"Trusty Leg",
		0,
		0,
		NULL,
		IT_WEAPON|IT_STAY_COOP,
		0,
		NULL,
		0,
/* precache */ ""
	},

	//TROND BUSHKNIFE
	{
		"weapon_bushknife",
		NULL,
		Use_Weapon,
		NULL,
		Weapon_Bush,
		"misc/w_pkup.wav",
		NULL, 0,
		"models/slat/bushknife/bushknife.md2",
/* icon */		"w_bushknife",
/* pickup */	"Bush Knife",
		0,
		0,
		NULL,
		IT_WEAPON|IT_STAY_COOP,
		1,
		NULL,
		0,
/* precache */ ""
	},

	//TROND mine
	{
		"weapon_mine",
		Pickup_Ammo,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Mine,
		"misc/w_pkup.wav",
		"models/slat/world_mine/world_mine.md2", 0,
		"models/slat/mine/mine.md2",
/* icon */		"a_mine",
/* pickup */	"Mine",
		0,
		1,
		"mine",
		IT_WEAPON|IT_STAY_COOP,
		9,
		NULL,
		0,
/* precache */ ""
	},
	//TROND slutt

#if 0
//ZOID
/*QUAKED weapon_laser (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"weapon_laser",
		Pickup_Weapon,
		Use_Weapon,
		Drop_Weapon,
		Weapon_Laser,
		"misc/w_pkup.wav",
		"models/weapons/g_laser/tris.md2", 0,
		"models/weapons/v_laser/tris.md2",
/* icon */		"w_bfg",
/* pickup */	"Flashlight Laser",
		0,
		1,
		"1911clip",
		IT_WEAPON,
		NULL,
		0,
/* precache */ ""
	},
#endif

	//
	// AMMO ITEMS
	//

/*QUAKED ammo_shells (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"ammo_shells",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_mossberg/mossberg_clip.md2", 0,
		NULL,
/* icon */		"a_shells",
/* pickup */	"MARINERshells",
/* width */		3,
		9,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_SHELLS,
/* precache */ ""
	},

/*QUAKED ammo_bullets (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"ammo_rockets",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_uzi/uzi_clip.md2", 0,
		NULL,
/* icon */		"a_uziclp",
/* pickup */	"UZIclip",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_UZI,
/* precache */ ""
	},

	//TROND
	//RELOAD 1911
	{
		"1911rounds",
		NULL,
		NULL,
		NULL,
		NULL,
		"misc/am_pkup.wav",
		NULL, 0,//kuler
		NULL,
/* icon */		"a_1911rds",
/* pickup */	"1911rounds",
/* width */		3,
		30,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_1911ROUNDS,
/* precache */ ""
	},
	//TROND slutt

	//RELOAD AK47
	{
		"ak47rounds",
		NULL,
		NULL,
		NULL,
		NULL,
		"misc/am_pkup.wav",
		NULL, 0,//kuler
		NULL,
/* icon */		"a_ak47rds",
/* pickup */	"AK47rounds",
/* width */		3,
		40,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_AK47ROUNDS,
/* precache */ ""
	},

	{
		"ammo_cells",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_ak47/ak47_clip.md2", 0,
		NULL,
/* icon */		"a_ak47clp",
/* pickup */	"AK47 clip",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_AKCLIP,
/* precache */ ""
	},
	//TROND slutt

	//TROND
	//RELOAD GLOCK
	{
		"glockrounds",
		NULL,
		NULL,
		NULL,
		NULL,
		"misc/am_pkup.wav",
		NULL, 0,//kuler
		NULL,
/* icon */		"a_glockrds",
/* pickup */	"GLOCKrounds",
/* width */		3,
		17,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_GLOCKROUNDS,
/* precache */ ""
	},

	{
		//  7/3 tatt vekk pga crash bug
		//	8/3 tatt med igjen
		"ammo_glock",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_glock/glock_clip.md2", 0,
		NULL,
/* icon */		"a_glockclp",
/* pickup */	"GLOCKclip",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_GLOCKCLIP,
/* precache */ ""
	},
	//TROND slutt

	{
		"ammo_casull",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_casull/casull_clip.md2", 0,
		NULL,
/* icon */		"a_casullclp",
/* pickup */	"CASULLbullets",
/* width */		3,
		10,
		NULL,
		IT_AMMO,
		0,
		NULL,
		0,
/* precache */ ""
	},

	{
		"casull_rounds",
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL, 0,
		NULL,
/* icon */		"a_casullrds",
/* pickup */	"CASULLrounds",
/* width */		3,
		5,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_CASULLROUNDS,
/* precache */ ""
	},

	//27/3 BERETTA
	{
		"ammo_beretta",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_beretta/beretta_clip.md2", 0,
		NULL,
/* icon */		"a_berettaclp",
/* pickup */	"BERETTAclip",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		0,
/* precache */ ""
	},

	{
		"beretta_rounds",
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL, 0,
		NULL,
/* icon */		"a_berettards",
/* pickup */	"BERETTArounds",
/* width */		3,
		15,
		NULL,
		IT_AMMO,
		0,
		NULL,
		0,
/* precache */ ""
	},
	//SLUTT

	//27/3 MP5
	{
		"ammo_mp5",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_mp5/mp5_clip.md2", 0,
		NULL,
/* icon */		"a_mp5clp",
/* pickup */	"MP5clip",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		0,
/* precache */ ""
	},

	{
		"mp5_rounds",
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL, 0,
		NULL,
/* icon */		"a_mp5rds",
/* pickup */	"MP5rounds",
/* width */		3,
		32,
		NULL,
		IT_AMMO,
		0,
		NULL,
		0,
/* precache */ ""
	},
	//SLUTT

	//1/4 M60
	{
		"ammo_m60",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_m60/m60_clip.md2", 0,
		NULL,
/* icon */		"a_m60clp",
/* pickup */	"M60ammo",
/* width */		3,
		200,
		NULL,
		IT_AMMO,
		0,
		NULL,
		0,
/* precache */ ""
	},

	{
		"m60_rounds",
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL, 0,
		NULL,
/* icon */		"a_m60rds",
/* pickup */	"M60rounds",
/* width */		3,
		200,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},

	//3/4 MSG90
	{
		"ammo_msg90",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_msg90/msg90_clip.md2", 0,
		NULL,
/* icon */		"a_msg90clp",
/* pickup */	"MSG90clip",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		0,
/* precache */ ""
	},

	{
		"msg90_rounds",
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL, 0,
		NULL,
/* icon */		"a_msg90rds",
/* pickup */	"MSG90rounds",
/* width */		3,
		20,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},

	//TROND
	//RELOAD UZI
	{
		"uzi_rounds",
		NULL,
		NULL,
		NULL,
		NULL,
		"misc/am_pkup.wav",
		NULL, 0,//kuler
		NULL,
/* icon */		"a_uzirds",
/* pickup */	"UZIrounds",
/* width */		3,
		30,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_9MM,
/* precache */ ""
	},
	//TROND slutt

	//TROND
	//RELOAD RIFLE
	{
		"barrettrounds",
		NULL,
		NULL,
		NULL,
		NULL,
		"misc/am_pkup.wav",
		NULL, 0,//kuler
		NULL,
/* icon */		"a_barrettrds",
/* pickup */	"50cal",
/* width */		3,
		10,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_50CAL,
/* precache */ ""
	},
	//TROND slutt

	//TROND
	//RELOAD HAGLE
	{
		"ammo_MARINERrounds",
		NULL,
		NULL,
		NULL,
		NULL,
		"misc/am_pkup.wav",
		NULL, 0,//kuler
		NULL,
/* icon */		"a_marinerrds",
/* pickup */	"MARINERrounds",
/* width */		3,
		9,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_MARINERROUNDS,
/* precache */ ""
	},
	//TROND slutt

/*QUAKED ammo_cells (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		//  7/3 tatt vekk pga crash bug....
		//	8/3 tatt tilbake	
		"ammo_bullets",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_t1911/t1911_clip.md2", 0,
		NULL,
/* icon */		"a_1911clp",
/* pickup */	"1911clip",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_CELLS,
/* precache */ ""
	},

/*QUAKED ammo_rockets (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "ammo_rockets",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/items/ammo/rockets/medium/tris.md2", 0,
		NULL,
/* icon */		"a_rockets",
/* pickup */	"Rockets",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_ROCKETS,
/* precache */ ""
	},

/*QUAKED ammo_slugs (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"ammo_slugs",//TROND var "ammo_slugs",
		Pickup_Ammo,
		NULL,
		Drop_Ammo,
		NULL,
		"misc/am_pkup.wav",
		"models/slat/world_barrett/barrett_clip.md2", 0,
		NULL,
/* icon */		"a_barrettclp",
/* pickup */	"BARRETTclip",
/* width */		3,
		1,
		NULL,
		IT_AMMO,
		0,
		NULL,
		AMMO_SLUGS,
/* precache */ ""
	},


	//
	// POWERUP ITEMS
	//
/*QUAKED item_quad (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		NULL,//TROND var "item_quad",
		Pickup_Powerup,
		Use_Quad,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/items/quaddama/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"p_quad",
/* pickup */	"Quad Damage",
/* width */		2,
		60,
		NULL,
		IT_POWERUP,
		0,
		NULL,
		0,
/* precache */ "items/damage.wav items/damage2.wav items/damage3.wav"
	},

/*QUAKED item_invulnerability (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"NULL",//TROND var "item_invulnerability",
		Pickup_Powerup,
		Use_Invulnerability,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/items/invulner/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"p_invulnerability",
/* pickup */	"Invulnerability",
/* width */		2,
		300,
		NULL,
		IT_POWERUP,
		0,
		NULL,
		0,
/* precache */ "items/protect.wav items/protect2.wav items/protect4.wav"
	},

/*QUAKED item_silencer (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"NULL",//TROND var "item_silencer",
		Pickup_Powerup,
		Use_Silencer,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/items/silencer/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"p_silencer",
/* pickup */	"Silencer",
/* width */		2,
		60,
		NULL,
		IT_POWERUP,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED item_breather (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"NULL",//TROND var "item_breather",
		Pickup_Powerup,
		Use_Breather,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/items/breather/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"p_rebreather",
/* pickup */	"Rebreather",
/* width */		2,
		60,
		NULL,
		IT_STAY_COOP|IT_POWERUP,
		0,
		NULL,
		0,
/* precache */ "items/airout.wav"
	},

/*QUAKED item_enviro (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"NULL",//TROND var "item_enviro",
		Pickup_Powerup,
		Use_Envirosuit,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/items/enviro/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"p_envirosuit",
/* pickup */	"Environment Suit",
/* width */		2,
		60,
		NULL,
		IT_STAY_COOP|IT_POWERUP,
		0,
		NULL,
		0,
/* precache */ "items/airout.wav"
	},

/*QUAKED item_ancient_head (.3 .3 1) (-16 -16 -16) (16 16 16)
Special item that gives +2 to maximum health
*/
	{
		"NULL",//TROND var "item_ancient_head",
		Pickup_AncientHead,
		NULL,
		NULL,
		NULL,
		"items/pkup.wav",
		"models/items/c_head/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"i_fixme",
/* pickup */	"Ancient Head",
/* width */		2,
		60,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED item_adrenaline (.3 .3 1) (-16 -16 -16) (16 16 16)
gives +1 to maximum health
*/
	{
		"NULL",//TROND var "item_adrenaline",
		Pickup_Adrenaline,
		NULL,
		NULL,
		NULL,
		"items/pkup.wav",
		"models/items/adrenal/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"p_adrenaline",
/* pickup */	"Adrenaline",
/* width */		2,
		60,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED item_bandolier (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"NULL",//TROND var "item_bandolier",
		Pickup_Bandolier,
		NULL,
		NULL,
		NULL,
		"items/pkup.wav",
		"models/items/band/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"p_bandolier",
/* pickup */	"Bandolier",
/* width */		2,
		60,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED item_pack (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
	{
		"NULL",//TROND var "item_pack",
		Pickup_Pack,
		NULL,
		NULL,
		NULL,
		"items/pkup.wav",
		"models/items/pack/tris.md2", EF_ROTATE,
		NULL,
/* icon */		"i_pack",
/* pickup */	"Ammo Pack",
/* width */		2,
		180,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ ""
	},

	//
	// KEYS
	//
/*QUAKED key_data_cd (0 .5 .8) (-16 -16 -16) (16 16 16)
key for computer centers
*/
	{
		"key_data_cd",//TROND var "key_data_cd",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_cd/key_cd.md2", 0,
		NULL,
		"k_datacd",
		"Data CD",
		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED key_power_cube (0 .5 .8) (-16 -16 -16) (16 16 16) TRIGGER_SPAWN NO_TOUCH
warehouse circuits
*/
	{
		"key_power_cube",//TROND var "key_power_cube",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_battery/key_battery.md2", 0,
		NULL,
		"k_powercube",
		"Power Cube",
		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED key_pyramid (0 .5 .8) (-16 -16 -16) (16 16 16)
key for the entrance of jail3
*/
	{
		"key_pyramid",//TROND var "key_pyramid",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_security/key_security.md2", 0,
		NULL,
		"k_pyramid",
		"Pyramid Key",
		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED key_data_spinner (0 .5 .8) (-16 -16 -16) (16 16 16)
key for the city computer
*/
	{
		"key_data_spinner",//TROND var "key_data_spinner",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_laptop/key_laptop.md2", 0,
		NULL,
		"k_dataspin",
		"Data Spinner",
		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED key_pass (0 .5 .8) (-16 -16 -16) (16 16 16)
security pass for the security level
*/
	{
		"key_pass",//TROND var "key_pass",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_pass/key_pass.md2", 0,
		NULL,
		"k_security",
		"Security Pass",
		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED key_blue_key (0 .5 .8) (-16 -16 -16) (16 16 16)
normal door key - blue
*/
	{
		"key_blue_key",//TROND var "key_blue_key",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_key2/key_key2.md2", 0,
		NULL,
		"k_bluekey",
		"Blue Key",
		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED key_red_key (0 .5 .8) (-16 -16 -16) (16 16 16)
normal door key - red
*/
	{
		"key_red_key",//TROND var "key_red_key",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_key/key_key.md2", 0,
		NULL,
		"k_redkey",
		"Red Key",
		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED key_commander_head (0 .5 .8) (-16 -16 -16) (16 16 16)
tank commander's head
*/
	{
		"key_commander_head",//TROND var "key_commander_head",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_id/key_id.md2", 0,
		NULL,
/* icon */		"k_comhead",
/* pickup */	"Commander's Head",
/* width */		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

/*QUAKED key_airstrike_target (0 .5 .8) (-16 -16 -16) (16 16 16)
tank commander's head
*/
	{
		"key_airstrike_target",//TROND var "key_airstrike_target",
		Pickup_Key,
		NULL,
		Drop_General,
		NULL,
		"items/pkup.wav",
		"models/slat/key_radio/key_radio.md2", 0,
		NULL,
/* icon */		"i_airstrike",
/* pickup */	"Airstrike Marker",
/* width */		2,
		0,
		NULL,
		IT_STAY_COOP|IT_KEY,
		0,
		NULL,
		0,
/* precache */ ""
	},

	{
		NULL,
		NULL, //TROND var Pickup_Health,
		NULL,
		NULL,
		NULL,
		"items/pkup.wav",
		NULL, 0,
		NULL,
/* icon */		"i_health",
/* pickup */	"Health",
/* width */		3,
		0,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ "items/s_health.wav items/n_health.wav items/l_health.wav items/m_health.wav"
	},

//ZOID
/*QUAKED item_flag_team1 (1 0.2 0) (-16 -16 -24) (16 16 32)
*/
	{
		"item_flag_team1",
		CTFPickup_Flag,//CTFPickup_Flag,
		NULL,
		CTFDrop_Flag, //Should this be null if we don't want players to drop it manually?
		NULL,
		"ctf/flagtk.wav",
		//TROND
		//LA TIL EF_ROTATE I STEDET FOR EF_FLAG1
		"models/slat/drug/drug.md2", 0,
		//TROND slutt
		NULL,
/* icon */		"i_ctf1",
/* pickup */	"Illegal Drugpack",
/* width */		2,
		0,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ "ctf/flagcap.wav"
	},

/*QUAKED item_flag_team2 (1 0.2 0) (-16 -16 -24) (16 16 32)
*/
	{
		"item_flag_team2",
		//TROND
		//TURBOMEKK PÅ FLAGG
		CTFPickup_Flag,//CTFPickup_Flag,
		//TROND slutt
		NULL,
		CTFDrop_Flag, //Should this be null if we don't want players to drop it manually?
		NULL,
		"ctf/flagtk.wav",
		//TROND
		//LA TIL EF_ROTATE I STEDET FOR EF_FLAG1
		"models/slat/drug/drug.md2", 0,
		//TROND slutt
		NULL,
/* icon */		"i_ctf2",
/* pickup */	"Confiscated Drugpack",
/* width */		2,
		0,
		NULL,
		0,
		0,
		NULL,
		0,
/* precache */ "ctf/flagcap.wav"
	},

//TROND
//TOK VEKK TECHER

/* Resistance Tech */
/*	{
		"item_tech1",
		CTFPickup_Tech,
		NULL,
		CTFDrop_Tech, //Should this be null if we don't want players to drop it manually?
		NULL,
		"items/pkup.wav",
		"models/ctf/resistance/tris.md2", EF_ROTATE,
		NULL,
/* icon *//*		"tech1",
/* pickup *//*	"Disruptor Shield",
/* width *//*		2,
		0,
		NULL,
		IT_TECH,
		0,
		NULL,
		0,
/* precache *//* "ctf/tech1.wav"
	},

/* Strength Tech */
/*	{
		"item_tech2",
		CTFPickup_Tech,
		NULL,
		CTFDrop_Tech, //Should this be null if we don't want players to drop it manually?
		NULL,
		"items/pkup.wav",
		"models/ctf/strength/tris.md2", EF_ROTATE,
		NULL,
/* icon */	/*	"tech2",
/* pickup *//*	"Power Amplifier",
/* width */	/*	2,
		0,
		NULL,
		IT_TECH,
		0,
		NULL,
		0,
/* precache *//* "ctf/tech2.wav ctf/tech2x.wav"
	},

/* Haste Tech */
/*	{
		"item_tech3",
		CTFPickup_Tech,
		NULL,
		CTFDrop_Tech, //Should this be null if we don't want players to drop it manually?
		NULL,
		"items/pkup.wav",
		"models/ctf/haste/tris.md2", EF_ROTATE,
		NULL,
/* icon */	/*	"tech3",
/* pickup *//*	"Time Accel",
/* width */	/*	2,
		0,
		NULL,
		IT_TECH,
		0,
		NULL,
		0,
/* precache */ /*"ctf/tech3.wav"
	},

/* Regeneration Tech */
/*	{
		"item_tech4",
		CTFPickup_Tech,
		NULL,
		CTFDrop_Tech, //Should this be null if we don't want players to drop it manually?
		NULL,
		"items/pkup.wav",
		"models/ctf/regeneration/tris.md2", EF_ROTATE,
		NULL,
/* icon */	/*	"tech4",
/* pickup *//*	"AutoDoc",
/* width */	/*	2,
		0,
		NULL,
		IT_TECH,
		0,
		NULL,
		0,
/* precache *//* "ctf/tech4.wav"
	},*/

//ZOID

	// end of list marker

	//TROND slutt
	{NULL}
};


/*QUAKED item_health (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
void SP_item_health (edict_t *self)
{
	if ( deathmatch->value && ((int)dmflags->value & DF_NO_HEALTH) )
	{
		G_FreeEdict (self);
		return;
	}

	self->model = "models/items/healing/medium/tris.md2";
	self->count = 10;
	SpawnItem (self, FindItem ("Health"));
	gi.soundindex ("items/n_health.wav");
}

/*QUAKED item_health_small (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
void SP_item_health_small (edict_t *self)
{
	if ( deathmatch->value && ((int)dmflags->value & DF_NO_HEALTH) )
	{
		G_FreeEdict (self);
		return;
	}

	self->model = "models/items/healing/stimpack/tris.md2";
	self->count = 2;
	SpawnItem (self, FindItem ("Health"));
	self->style = HEALTH_IGNORE_MAX;
	gi.soundindex ("items/s_health.wav");
}

/*QUAKED item_health_large (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
void SP_item_health_large (edict_t *self)
{
	if ( deathmatch->value && ((int)dmflags->value & DF_NO_HEALTH) )
	{
		G_FreeEdict (self);
		return;
	}

	self->model = "models/items/healing/large/tris.md2";
	self->count = 25;
	SpawnItem (self, FindItem ("Health"));
	gi.soundindex ("items/l_health.wav");
}

/*QUAKED item_health_mega (.3 .3 1) (-16 -16 -16) (16 16 16)
*/
void SP_item_health_mega (edict_t *self)
{
	if ( deathmatch->value && ((int)dmflags->value & DF_NO_HEALTH) )
	{
		G_FreeEdict (self);
		return;
	}

	self->model = "models/items/mega_h/tris.md2";
	self->count = 100;
	SpawnItem (self, FindItem ("Health"));
	gi.soundindex ("items/m_health.wav");
	self->style = HEALTH_IGNORE_MAX|HEALTH_TIMED;
}


void InitItems (void)
{
	game.num_items = sizeof(itemlist)/sizeof(itemlist[0]) - 1;
}



/*
===============
SetItemNames

Called by worldspawn
===============
*/
void SetItemNames (void)
{
	int		i;
	gitem_t	*it;

	for (i=0 ; i<game.num_items ; i++)
	{
		it = &itemlist[i];
		gi.configstring (CS_ITEMS+i, it->pickup_name);
	}

	//TROND
	//KASTE ALLE VÅPEN
	item_shells = FindItem("MARINERshells");
	item_cells = FindItem("1911clip");
	item_UZIclip = FindItem("UZIclip");
	item_rockets = FindItem("rockets");
	item_slugs = FindItem("BARRETTclip");
	item_grenades = FindItem("grenades");
	//legger til dei ammotypane eg har mekka sjøl
	item_9mm = FindItem("UZIrounds");
	item_1911rounds = FindItem("1911rounds");
	item_50cal = FindItem("50cal");
	item_MARINERrounds = FindItem("MARINERrounds");

	item_blaster = FindItem("1911");//TROND var Blaster
	item_shotgun = FindItem("MARINER");//TROND var shotgun
	item_sshotgun = FindItem("super shotgun");
	item_handgrenade = FindItem("Grenades");
	item_machinegun = FindItem("UZI");
	item_chaingun = FindItem("chaingun");
	item_grenadelauncher = FindItem("grenade launcher");
	item_rocketlauncher = FindItem("rocket launcher");
	item_railgun = FindItem("BARRETT");
	item_hyperblaster = FindItem("hyperblaster");
	item_bfg10k = FindItem("bfg10k");
	//TROND slutt

	jacket_armor_index = ITEM_INDEX(FindItem("Jacket Armor"));
	combat_armor_index = ITEM_INDEX(FindItem("Combat Armor"));
	body_armor_index   = ITEM_INDEX(FindItem("Body Armor"));
	power_screen_index = ITEM_INDEX(FindItem("Power Screen"));
	power_shield_index = ITEM_INDEX(FindItem("Power Shield"));
}

//TROND
//KASTE ALLE VÅPEN
gitem_t *NextWeaponItem(int idx)
{
	switch (idx)
	{
	case WEAP_BLASTER: return item_shotgun;
	case WEAP_SHOTGUN: return item_sshotgun;
	case WEAP_SUPERSHOTGUN: return item_machinegun;
	case WEAP_MACHINEGUN: return item_chaingun;
	case WEAP_CHAINGUN: return item_grenadelauncher;
	case WEAP_GRENADELAUNCHER: return item_rocketlauncher;
	case WEAP_ROCKETLAUNCHER: return item_railgun;
	case WEAP_RAILGUN: return item_hyperblaster;
	case WEAP_HYPERBLASTER: return item_bfg10k;
	case WEAP_BFG: return item_blaster;
	}

	gi.dprintf ("INVALID weapon index in WeaponItem\n");
	return item_blaster;
}

gitem_t *WeaponItem (int idx)
{
	switch (idx)
	{
	case WEAP_BLASTER: return item_blaster;
	case WEAP_SHOTGUN: return item_shotgun;
	case WEAP_SUPERSHOTGUN: return item_sshotgun;
	case WEAP_MACHINEGUN: return item_machinegun;
	case WEAP_CHAINGUN: return item_chaingun;
	case WEAP_GRENADES: return item_handgrenade;
	case WEAP_GRENADELAUNCHER: return item_grenadelauncher;
	case WEAP_ROCKETLAUNCHER: return item_rocketlauncher;
	case WEAP_RAILGUN: return item_railgun;
	case WEAP_HYPERBLASTER: return item_hyperblaster;
	case WEAP_BFG: return item_bfg10k;
	}

	gi.dprintf ("INVALID weapon index in WeaponItem\n");
	return item_blaster;
}

int WeaponIdx (gitem_t *weapon)
{
	if(weapon==item_blaster) return WEAP_BLASTER;
	if(weapon==item_shotgun) return WEAP_SHOTGUN;
	if(weapon==item_sshotgun) return WEAP_SUPERSHOTGUN;
	if(weapon==item_machinegun) return WEAP_MACHINEGUN;
	if(weapon==item_chaingun) return WEAP_CHAINGUN;
	if(weapon==item_handgrenade) return WEAP_BLASTER;
	if(weapon==item_grenadelauncher) return WEAP_GRENADELAUNCHER;
	if(weapon==item_rocketlauncher) return WEAP_ROCKETLAUNCHER;
	if(weapon==item_railgun) return WEAP_RAILGUN;
	if(weapon==item_hyperblaster) return WEAP_HYPERBLASTER;
	if(weapon==item_bfg10k) return WEAP_BFG;

	gi.dprintf ("INVALID weapon index in WeaponIdx\n");
	return WEAP_BLASTER;
}

int WeapIndex(gitem_t *weapon)
{
	return ITEM_INDEX(weapon);
}

int AmmoIndex(gitem_t *weapon)
{
	if(weapon == item_blaster)return 0;
	if(weapon == item_shotgun)return ITEM_INDEX(item_shells);
	if(weapon == item_sshotgun)return ITEM_INDEX(item_shells);
	if(weapon == item_machinegun)return ITEM_INDEX(item_UZIclip);
	if(weapon == item_chaingun)return ITEM_INDEX(item_UZIclip);
	if(weapon == item_handgrenade)return ITEM_INDEX(item_grenades);
	if(weapon == item_grenadelauncher)return ITEM_INDEX(item_grenades);
	if(weapon == item_rocketlauncher)return ITEM_INDEX(item_rockets);
	if(weapon == item_railgun)return ITEM_INDEX(item_slugs);
	if(weapon == item_hyperblaster)return ITEM_INDEX(item_cells);
	if(weapon == item_bfg10k)return ITEM_INDEX(item_cells);

	gi.dprintf("INVALID weapontype in AmmoIndex");
	return 0;
}

qboolean HasAmmoInInventory(edict_t *self, int idx)
{
	return(self->client->pers.inventory[AmmoIndex(WeaponItem(idx))]);
}

qboolean HasWeaponInInventory(edict_t *self, int idx)
{
	return(self->client->pers.inventory[WeapIndex(WeaponItem(idx))]);
}
//TROND slutt


