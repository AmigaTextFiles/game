#include "g_local.h"
#include "m_player.h"

//TROND
void NoAmmoWeaponChange (edict_t *ent);
void Drop_General (edict_t *ent, gitem_t *item);//TROND 20/3
qboolean Pickup_Ammo (edict_t *ent, edict_t *other);//TROND 21/3
qboolean Pickup_Key (edict_t *ent, edict_t *other);//TROND 23/3
qboolean Pickup_Item (edict_t *ent, edict_t *other);//TROND 24/3
qboolean Pickup_Weapon (edict_t *ent, edict_t *other);//TROND 27/3
void Cmd_InvUse_f (edict_t *ent);//TROND 27/3

//DROP KEY
void Cmd_Drop_Key_f (edict_t *ent)
{
	gitem_t *item;

	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Airstrike Marker"))])
	{
		ent->client->item = 0;
		item = FindItem("Airstrike Marker");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("blue key"))])
	{
		ent->client->item = 0;
		item = FindItem("blue key");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Commander's Head"))])
	{
		ent->client->item = 0;
		item = FindItem("Commander's Head");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Red Key"))])
	{
		ent->client->item = 0;
		item = FindItem("Red Key");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Security Pass"))])
	{
		ent->client->item = 0;
		item = FindItem("Security Pass");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Data Spinner"))])
	{
		ent->client->item = 0;
		item = FindItem("Data Spinner");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Pyramid Key"))])
	{
		ent->client->item = 0;
		item = FindItem("Pyramid Key");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Power Cube"))])
	{
		ent->client->item = 0;
		item = FindItem("Power Cube");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Data CD"))])
	{
		ent->client->item = 0;
		item = FindItem("Data CD");
		Drop_General (ent, item);
		ent->client->weight += 2;
	}
	else
	{
		gi.cprintf (ent, PRINT_HIGH, "No key to drop\n");
		ent->client->item = 0;
	}
}
//TROND slutt

//USE SPECIAL
static void Cmd_UseSpecial_f (edict_t *ent)
{
	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("UZI"))]
		&& ent->client->pers.weapon != FindItem("UZI"))
		ent->client->newweapon = FindItem("UZI");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINER"))]
		&& ent->client->pers.weapon != FindItem("mariner"))
		ent->client->newweapon = FindItem("MARINER");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("AK 47"))]
		&& ent->client->pers.weapon != FindItem("ak 47"))
		ent->client->newweapon = FindItem("AK 47");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("BARRETT"))]
		&& ent->client->pers.weapon != FindItem("barrett"))
		ent->client->newweapon = FindItem("BARRETT");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("glock"))]
		&& ent->client->pers.weapon != FindItem("glock"))
		ent->client->newweapon = FindItem("glock");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("casull"))]
		&& ent->client->pers.weapon != FindItem("casull"))
		ent->client->newweapon = FindItem("casull");
	//BERETTA 27/3
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("beretta"))]
		&& ent->client->pers.weapon != FindItem("beretta"))
		ent->client->newweapon = FindItem("beretta");
/*	else
		gi.cprintf (ent, PRINT_HIGH, "You have no special weapon\n");*/
}

//TROND
//OPNE DØR
void Cmd_PlaceC4_f (edict_t *ent);

void Cmd_PlaceC4_f (edict_t *ent)
{
	vec3_t		checkwall, forward;

	edict_t		*c4;

	trace_t		tr;

	VectorCopy (ent->s.origin, checkwall);

	AngleVectors (ent->client->v_angle, forward, NULL, NULL);

	checkwall[0] = ent->s.origin[0] + forward[0]*50;
	checkwall[1] = ent->s.origin[1] + forward[1]*50;
	checkwall[2] = ent->s.origin[2] + forward[2]*50;

	tr = gi.trace (ent->s.origin, NULL, NULL, checkwall, ent, MASK_SOLID);
	//Er døra innen rekkevidde?
	if (tr.fraction == 1.0)
	{
		gi.cprintf (ent, PRINT_HIGH, "Can`t place C4 here\n");
		return;
	}

	gi.cprintf (ent, PRINT_HIGH, "C4 placed\n");

	c4 = G_Spawn ();
	VectorCopy (tr.endpos, c4->s.origin);
	vectoangles (tr.plane.normal, c4->s.angles);

	c4->s.modelindex = gi.modelindex ("models/slat/world_c4/world_c4.md2");

	c4->nextthink = level.time + 30;
	c4->think = G_FreeEdict;
	c4->classname = "c4";

	gi.linkentity (c4);
}
//TROND slutt

//TROND
//DROP ITEM
void Cmd_Drop_Item_f (edict_t *ent)
{
	gitem_t *item;

	//TROND 10/4
	if (ent->movetype == MOVETYPE_NOCLIP)
		return;
	//TROND slutt

	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("IR Goggles"))])
	{
		ent->client->item = 0;
		item = FindItem("IR goggles");
		Drop_SpecialItem (ent, item);
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Helmet"))])
	{
		ent->client->item = 0;
		item = FindItem("Helmet");
		Drop_SpecialItem (ent, item);
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))])
	{
		ent->client->item = 0;
		item = FindItem("Bullet Proof Vest");
		Drop_SpecialItem (ent, item);
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("MedKit"))])
	{
		ent->client->item = 0;
		item = FindItem("MedKit");
		Drop_SpecialItem (ent, item);
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Scuba Gear"))])
	{
		ent->client->item = 0;
		item = FindItem("Scuba Gear");
		Drop_SpecialItem (ent, item);
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("Head Light"))])
	{
		ent->client->item = 0;
		item = FindItem("Head Light");
		Drop_SpecialItem (ent, item);
	}
	else
	{
		gi.cprintf (ent, PRINT_HIGH, "No special item to drop\n");
		ent->client->item = 0;
	}
}
//TROND slutt

//TROND
//BLØ
static void Cmd_Bleed_f (edict_t *ent)
{
	ent->client->bleeding = 1;
	ent->client->limp = 1;
	ent->client->pain_head == 1;
}
static void Cmd_Bandage_f (edict_t *ent)
{
	if (ent->deadflag == DEAD_DEAD)
		return;
	if (ent->client->bandaging)
		return;

	if (ent->client->bleeding == 1 || ent->client->limp == 1)
	{
		gi.cprintf (ent, PRINT_HIGH, "Bandaging...\n");
		ent->client->weaponstate = WEAPON_HOLSTERED;
		ent->client->bandaging = 1;
		ent->client->ps.fov = 90;
		if (ent->client->zoom
			&& ent->client->pers.weapon == FindItem("msg90"))
		{
			ent->client->ps.rdflags &= ~RDF_IRGOGGLES;
			ent->client->infrared = 0;
		}
		ent->client->zoom = 0;
		ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);
	}
	else
	{
		ent->client->bandaging = 0;
	}
}
//TROND slutt

//TROND
//ZOOM
static void Cmd_Zoom_f (edict_t *ent)
{
	//TROND lagt til 9/4
	if (!ent->client)
		return;

//	TROND tatt vekk 13/4
//	if (ent->client->weaponstate != WEAPON_READY)
//		return;
	//TROND slutt

	if (ent->client->pers.weapon == FindItem("BARRETT")
		&& ent->client->bandaging == 0)
	{
		if (ent->client->zoom == 4)
		{
			ent->client->zoom = 0;
			ent->client->ps.fov = 90;
//			gi.cprintf (ent, PRINT_HIGH, "ZOOM set back to o\n");
//			gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/barrett_scope.wav"), 1, ATTN_NORM, 0);
			ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);

		}
		else if (ent->client->zoom == 3)
		{
			ent->client->zoom = 4;
			ent->client->ps.fov = 7;
//			gi.cprintf (ent, PRINT_HIGH, "ZOOM set 4\n");
//			gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/barrett_scope.wav"), 1, ATTN_NORM, 0);
			ent->client->ps.gunindex = 0;
		}
		else if (ent->client->zoom == 2)
		{
			ent->client->zoom = 3;
			ent->client->ps.fov = 15;	
//			gi.cprintf (ent, PRINT_HIGH, "ZOOM set 3\n");
//			gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/barrett_scope.wav"), 1, ATTN_NORM, 0);
			ent->client->ps.gunindex = 0;
		}
		else if (ent->client->zoom == 1)
		{
			ent->client->zoom = 2;
			ent->client->ps.fov = 30;
//			gi.cprintf (ent, PRINT_HIGH, "ZOOM set 2\n");
//			gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/barrett_scope.wav"), 1, ATTN_NORM, 0);
			ent->client->ps.gunindex = 0;
		}
		else
		{
			ent->client->zoom = 1;
			ent->client->ps.fov = 60;
//			gi.cprintf (ent, PRINT_HIGH, "ZOOM set 1\n");
//			gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/barrett_scope.wav"), 1, ATTN_NORM, 0);
			ent->client->ps.gunindex = 0;
		}
	}
	if (ent->client->pers.weapon == FindItem("glock")
		&& ent->client->bandaging == 0)
	{
		if (ent->client->ls_on == 0)
		{
			SP_LaserSight (ent);
			ent->client->ls_on = 1;
//			gi.cprintf (ent, PRINT_HIGH, "Laser Sight on\n");
		}
		else if (ent->client->ls_on == 1)
		{
			SP_LaserSight (ent);
			ent->client->ls_on = 0;
//			gi.cprintf (ent, PRINT_HIGH, "Laser Sight off\n");
		}
	}
	if (ent->client->pers.weapon == FindItem("grenades")
		&& ent->client->bandaging == 0)
	{
		if (ent->client->distance == 2)
		{
			gi.cprintf (ent, PRINT_HIGH, "Throw grenade short range\n");
			ent->client->distance = 0;
		}
		else if (ent->client->distance == 1)
		{
			gi.cprintf (ent, PRINT_HIGH, "Throw grenade long range\n");
			ent->client->distance = 2;
		}
		else if (ent->client->distance == 0)
		{
			gi.cprintf (ent, PRINT_HIGH, "Throw grenade medium range\n");
			ent->client->distance = 1;
		}
	}
	
	if (ent->client->pers.weapon == FindItem("msg90")
		&& ent->client->bandaging == 0)
	{
		if (ent->client->zoom == 1)
		{
			ent->client->zoom = 0;
			ent->client->ps.fov = 90;
//			gi.cprintf (ent, PRINT_HIGH, "ZOOM set back to o\n");
			gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/barrett_scope.wav"), 1, ATTN_NORM, 0);
			ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);
			ent->client->infrared = 0;
			ent->client->ps.rdflags &= ~RDF_IRGOGGLES;
		}
		else if (ent->client->zoom == 0)
		{
			ent->client->zoom = 1;
			ent->client->ps.fov = 35;
//			gi.cprintf (ent, PRINT_HIGH, "ZOOM set back to o\n");
			gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/barrett_scope.wav"), 1, ATTN_NORM, 0);
			ent->client->ps.gunindex = 0;
			ent->client->infrared = 1;
			ent->client->ps.rdflags |= RDF_IRGOGGLES;
		}
	}
	else
		return;

}
//TROND slutt

//TROND
//INFRA RED GOGGLES
static void Cmd_InfraRed_f (edict_t *ent)
{
	if (ent->client->infrared
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("IR goggles"))])
	{ 
		if (ent->client->pers.weapon == FindItem("msg90")
			&& ent->client->zoom)
			return;

		ent->client->infrared = 0;
		ent->client->ps.rdflags &= ~RDF_IRGOGGLES;
//		gi.cprintf (ent, PRINT_HIGH, "IR Goggles off\n");
	}
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("IR goggles"))])
	{  
		if (ent->client->pers.weapon == FindItem("msg90")
			&& ent->client->zoom)
			return;

		ent->client->infrared = 1;
		ent->client->ps.rdflags |= RDF_IRGOGGLES;
//		gi.cprintf (ent, PRINT_HIGH, "IR Goggles on\n");
	}
/*	else
	{
		gi.cprintf (ent, PRINT_HIGH, "You don`t have the IR goggles\n");
		ent->client->infrared = 0;
	}*/
	if (ent->client->fl_on == 0
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("Head Light"))])
	{
		SP_FlashLight (ent);
		ent->client->fl_on = 1;
//		gi.cprintf (ent, PRINT_HIGH, "Head Light on\n");
	}
	else if (ent->client->fl_on == 1)
	{
		SP_FlashLight (ent);
		ent->client->fl_on = 0;
//		gi.cprintf (ent, PRINT_HIGH, "Head Light off\n");
	}
}
//TROND slutt

//TROND
//DETONERE DETPACK
void Cmd_Detpack_f (edict_t *ent)
{
	edict_t *blip = NULL;

	while ((blip = findradius(blip, ent->s.origin, 1000)) != NULL)
	{
		if(!strcmp(blip->classname, "grenade") && blip->owner == ent)
		{
			gi.sound (ent, CHAN_VOICE, gi.soundindex ("weapons/grenlb1b.wav"), 1, ATTN_NORM, 0);
			blip->think = Grenade_Explode;
			blip->nextthink = level.time + 0.1;
		}
	}
}
/*
//TROND
//OPNE DØR
void Cmd_Door_f (edict_t *ent)
{
	vec3_t	checkwall, forward;

	trace_t	tr;

	VectorCopy (ent->s.origin, checkwall);

	AngleVectors (ent->client->v_angle, forward, NULL, NULL);

	checkwall[0] = ent->s.origin[0] + forward[0]*50;
	checkwall[1] = ent->s.origin[1] + forward[1]*50;
	checkwall[2] = ent->s.origin[2] + forward[2]*50;

	tr = gi.trace (ent->s.origin, NULL, NULL, checkwall, ent, MASK_SOLID);
	//Er døra innen rekkevidde?
	if (tr.fraction == 1.0)
	{
		//Nei...
		return;
	}

	if (tr.ent->use, "door_use")
	{
//		gi.cprintf (ent, PRINT_HIGH, "I`ve BASED (read BASED) this Open Door code on Defcon-X`s...\n");
		ent->client->dooropen = 1;
//		ent->client->pickupweap = 1;//TROND plukk opp
	}
}*/

static void Cmd_Door_f (edict_t *ent)
{
	ent->client->dooropen = 1;
	return;
}
//TROND slutt


char *ClientTeam (edict_t *ent)
{
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
}

qboolean OnSameTeam (edict_t *ent1, edict_t *ent2)
{
	char	ent1Team [512];
	char	ent2Team [512];

	if (!((int)(dmflags->value) & (DF_MODELTEAMS | DF_SKINTEAMS)))
		return false;

	strcpy (ent1Team, ClientTeam (ent1));
	strcpy (ent2Team, ClientTeam (ent2));

	if (strcmp(ent1Team, ent2Team) == 0)
		return true;
	return false;
}

//TROND 27/3
void SelectNextSpecial (edict_t *ent, int itflags)
{
	gclient_t	*cl;
	int			i, index;
	gitem_t		*it;

	cl = ent->client;

//ZOID
	if (cl->menu) {
		PMenu_Next(ent);
		return;
	}
//ZOID

	if (cl->chase_target) {
		ChaseNext(ent);
		return;
	}

	// scan  for the next valid one
	for (i=1 ; i<=MAX_ITEMS ; i++)
	{
		index = (cl->pers.selected_item + i)%MAX_ITEMS;
		if (!cl->pers.inventory[index])
			continue;
		it = &itemlist[index];
		if (!it->use
			|| it->pickup != Pickup_Weapon)
			continue;

		cl->pers.selected_item = index;
		return;
	}

	cl->pers.selected_item = -1;
}
//TROND slutt

//TROND 18/4
void SelectNextSpecialItem (edict_t *ent, int itflags)
{
	gclient_t	*cl;
	int			i, index;
	gitem_t		*it;

	cl = ent->client;

//ZOID
	if (cl->menu) {
		PMenu_Next(ent);
		return;
	}
//ZOID

	if (cl->chase_target) {
		ChaseNext(ent);
		return;
	}

	// scan  for the next valid one
	for (i=1 ; i<=MAX_ITEMS ; i++)
	{
		index = (cl->pers.selected_item + i)%MAX_ITEMS;
		if (!cl->pers.inventory[index])
			continue;
		it = &itemlist[index];
		if (it != FindItem("m60ammo"))
		{
			if (it->drop != Drop_SpecialItem)
				continue;
		}

		cl->pers.selected_item = index;
		return;
	}

	cl->pers.selected_item = -1;
}
//TROND slutt

void SelectNextItem (edict_t *ent, int itflags)
{
	gclient_t	*cl;
	int			i, index;
	gitem_t		*it;

	cl = ent->client;

//ZOID
	if (cl->menu) {
		PMenu_Next(ent);
		return;
	}
//ZOID

	if (cl->chase_target) {
		ChaseNext(ent);
		return;
	}

	// scan  for the next valid one
	for (i=1 ; i<=MAX_ITEMS ; i++)
	{
		index = (cl->pers.selected_item + i)%MAX_ITEMS;
		if (!cl->pers.inventory[index])
			continue;
		it = &itemlist[index];
		//TROND mekk 21/3
/*		if (!it->use)
			continue;
		if (!(it->flags & itflags))
			continue;*/
		//TROND slutt

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

//ZOID
	if (cl->menu) {
		PMenu_Prev(ent);
		return;
	}
//ZOID

	if (cl->chase_target) {
		ChasePrev(ent);
		return;
	}

	// scan  for the next valid one
	for (i=1 ; i<=MAX_ITEMS ; i++)
	{
		index = (cl->pers.selected_item + MAX_ITEMS - i)%MAX_ITEMS;
		if (!cl->pers.inventory[index])
			continue;
		it = &itemlist[index];
		//TROND mekk 21/3
/*		if (!it->use)
			continue;
		if (!(it->flags & itflags))
			continue;*/
		//TROND slutt

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
			gi.cprintf (ent, PRINT_HIGH, "unknown item\n");
			return;
		}
	}

	if (!it->pickup)
	{
		gi.cprintf (ent, PRINT_HIGH, "non-pickup item\n");
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
	//TROND 27/3
	if (Q_stricmp(gi.args(), "special") == 0)
	{
		if (ent->client->weaponstate == WEAPON_READY)
		{
			SelectNextSpecial (ent, +1);
			Cmd_InvUse_f (ent);
//		Cmd_UseSpecial_f (ent);
		}
		return;
	}
	//TROND slutt
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

	//TROND 10/4
	if (ent->movetype == MOVETYPE_NOCLIP)
		return;
	//TROND slutt

//ZOID--special case for tech powerups
	if (Q_stricmp(gi.args(), "tech") == 0 && (it = CTFWhat_Tech(ent)) != NULL) 
	{
		it->drop (ent, it);
		return;
	}
//ZOID

	s = gi.args();

	it = FindItem (s);

	//TROND vekt system
	if (Q_stricmp(gi.args(), "weapon") == 0)
	{
//		if (ent->client->weaponstate == WEAPON_READY)
		Cmd_Drop_Weapon_f (ent);
		return;
	}

	if (Q_stricmp(gi.args(), "item") == 0)
	{
		Cmd_Drop_Item_f (ent);
		return;
	}
	//TROND 20/3
	if (Q_stricmp(gi.args(), "key") == 0)
	{
		Cmd_Drop_Key_f (ent);
		return;
	}

	if (Q_stricmp(gi.args(), "grenades") == 0
		|| Q_stricmp(gi.args(), "c4 detpack") == 0
		|| Q_stricmp(gi.args(), "mine") == 0)
		return;
	if (Q_stricmp(gi.args(), "uziclip") == 0
		|| Q_stricmp(gi.args(), "barrettclip") == 0
		|| Q_stricmp(gi.args(), "1911clip") == 0
		|| Q_stricmp(gi.args(), "ak47 clip") == 0
		|| Q_stricmp(gi.args(), "marinershells") == 0
		|| Q_stricmp(gi.args(), "glockclip") == 0
		|| Q_stricmp(gi.args(), "casullbullets") == 0
		|| Q_stricmp(gi.args(), "mp5clip") == 0
		|| Q_stricmp(gi.args(), "berettaclip") == 0
		|| Q_stricmp(gi.args(), "m60ammo") == 0
		|| Q_stricmp(gi.args(), "msg90clip") == 0)
/*		|| it->drop == FindItem("barrettclip"
		|| it->drop == FindItem("marinershells"
		|| it->drop == FindItem("1911clip"
		|| it->drop == FindItem("ak47 clip"
		|| it->drop == FindItem("glockclip")*/
	{
		if (!ent->client->pers.inventory[ITEM_INDEX(FindItem(s))])
			return;
//		if (!(Q_stricmp(gi.args(), "marinershells") == 0))
			ent->client->weight += 2;

		//TROND		1/4
		if ((Q_stricmp(gi.args(), "m60ammo") == 0))
		{
			ent->client->torso_item = 0;
			ShowTorso(ent);
			ent->client->weight += 8;
		}
	}
/*	else if (Q_stricmp(gi.args(), "c4 detpack") == 0
		|| Q_stricmp(gi.args(), "mine") == 0
		|| Q_stricmp(gi.args(), "grenades") == 0)
	{
		if (!ent->client->pers.inventory[ITEM_INDEX(FindItem(s))])
			return;
		ent->client->weight += 5;
	}*/
	else
	{
		return;
	}
	//TROND slutt

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

//TROND
//DROP WEAPON
void Cmd_Drop_Weapon_f (edict_t *ent)
{
	int			index;
	gitem_t		*it;
	edict_t		*drop;//TROND
	char		*s;

	//TROND 10/4
	if (ent->movetype == MOVETYPE_NOCLIP)
		return;
	//TROND slutt

	//TROND bugfix 24/3
	if (ent->client->weaponstate != WEAPON_READY)
	{
//		gi.cprintf (ent, PRINT_HIGH, "DEBUG: weaponstate not WEAPON_READY\n");
		return;
	}

	//TROND bug fix 14/4
	if (ent->client->pers.weapon == FindItem ("bush knife"))
	{
		gi.cprintf (ent, PRINT_HIGH, "ARE YOU NUTS? Then you`ll have NOTHING to defend yourself with!\n");
		return;
	}

	//DENNE LNIJA KRASJER SPILLET OM DET IKKJE ER SJEKK FOR BUSH KNIFE
//	ent->client->weaponstate = WEAPON_DROPPING;//TROND bug fix 14/4
	//TROND slutt

//ZOID--special case for tech powerups
	if (Q_stricmp(gi.args(), "tech") == 0 && (it = CTFWhat_Tech(ent)) != NULL) {
		it->drop (ent, it);
		return;
	}
//ZOID

	s = gi.args();
	if (ent->client->pers.weapon == FindItem ("1911")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("1911"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("1911"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("1911");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("1911rounds"))] = 0;
		ent->client->weight += 3;
		//TROND lagt til 9/4 sluttstykke
		if (drop->ammo == 0)
			drop->s.frame = 1;
		//TROND slutt
//		gi.cprintf (ent, PRINT_HIGH, "Don`t drop your trusty sidearm!\n");
		return;
	}
	//TROND tatt vekk 16/4
/*	else if (ent->client->pers.weapon == FindItem ("Bush Knife"))
	{
		gi.cprintf (ent, PRINT_HIGH, "ARE YOU NUTS? Then you`ll have NOTHING to defend yourself with!\n");
		return;
	}*/
	else if (ent->client->pers.weapon == FindItem ("MARINER")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINER"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINER"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("MARINER");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERrounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINERrounds"))] = 0;
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("MARINER"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		ent->client->weight += 9;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("UZI")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("UZI"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("UZI"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("UZI");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIrounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("UZIrounds"))] = 0;
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("UZI"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		ent->client->weight += 8;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("m60")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("m60"))])
	{
		ent->client->torso_item = 0;
		ShowTorso (ent);

		ent->client->pers.inventory[ITEM_INDEX(FindItem("m60"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("m60");
		ent->client->zoom = 0;
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("m60rounds"))] = 0;
		ent->client->weight += 22;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("BARRETT")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("BARRETT"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("BARRETT"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("BARRETT");
		ent->client->zoom = 0;
		ent->client->ps.fov = 90;
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))] = 0;
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("BARRETT"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		ent->client->weight += 17;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("C4 detpack")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("C4 detpack"))])
	{		
		ent->client->pers.inventory[ITEM_INDEX(FindItem("C4 detpack"))] -= 1;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("C4 detpack");
		drop = Drop_Item(ent, it);
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("C4 detpack"))] -= 1;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		ent->client->weight += 5;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("detonator")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("detonator"))])
	{
		it = FindItem ("detonator");
		drop = Drop_Item(ent, it);
		ent->client->pers.inventory[ITEM_INDEX(FindItem("detonator"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		ent->client->weight += 2;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("mine")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("mine"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("mine"))] -= 1;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("mine");
		drop = Drop_Item(ent, it);
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("mine"))] -= 1;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		ent->client->weight += 5;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("ak 47")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("ak 47"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("ak 47"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);	
		it = FindItem ("ak 47");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47rounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47rounds"))] = 0;
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("ak 47"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		ent->client->weight += 11;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("glock")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("glock"))])
	{
		if (ent->client->ls_on == 1)
		{
			ent->client->ls_on = 0;
			SP_LaserSight (ent);
		}
		ent->client->pers.inventory[ITEM_INDEX(FindItem("glock"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("glock");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))] = 0;
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("glock"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		//TROND lagt til 9/4 sluttstykke
		if (drop->ammo == 0)
			drop->s.frame = 1;
		//TROND slutt
		ent->client->weight += 5;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("casull")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("casull"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("casull"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("casull");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))] = 0;
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("casull"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		ent->client->weight += 6;
		return;//TROND 16/4
	}
	//27/3 BERETTA
	else if (ent->client->pers.weapon == FindItem ("beretta")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("beretta"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("beretta"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("beretta");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))] = 0;
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("casull"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		//TROND lagt til 9/4 sluttstykke
		if (drop->ammo == 0)
			drop->s.frame = 1;
		//TROND slutt
		ent->client->weight += 4;
		return;//TROND 16/4
	}
	//MP5	27/3
	else if (ent->client->pers.weapon == FindItem ("mp5")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("mp5");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))] = 0;
		ent->client->weight += 8;
		return;//TROND 16/4
	}
	//MSG90		3/4
	else if (ent->client->pers.weapon == FindItem ("msg90")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90"))])
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90"))] = 0;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);		
		ent->client->zoom = 0;
		ent->client->ps.fov = 90;
		ent->client->ps.rdflags &= ~RDF_IRGOGGLES;
		ent->client->infrared = 0;
		it = FindItem ("msg90");
		drop = Drop_Item(ent, it);
		drop->ammo = ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))];
		ent->client->pers.inventory[ITEM_INDEX(FindItem("msg90rounds"))] = 0;
		ent->client->weight += 10;
		return;//TROND 16/4
	}
	else if (ent->client->pers.weapon == FindItem ("grenades")
		&& ent->client->pers.inventory[ITEM_INDEX(FindItem("grenades"))])//TROND 16/4
	{
		ent->client->pers.inventory[ITEM_INDEX(FindItem("grenades"))] -= 1;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);
		it = FindItem ("grenades");
		drop = Drop_Item(ent, it);
/*		ent->client->pers.inventory[ITEM_INDEX(FindItem("grenades"))] -= 1;
		ent->client->ps.gunindex = 0;
		NoAmmoWeaponChange (ent);*/
		ent->client->weight += 5;
		return;//TROND 16/4
	}
	else
		return;

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
//TROND tatt vekk
//		gi.cprintf (ent, PRINT_HIGH, "Out of item: %s\n", s);
		return;
	}

//TROND tatt vekk
//	it->drop (ent, it);
}
//TROND slutt
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

//ZOID
	if (ctf->value && cl->resp.ctf_team == CTF_NOTEAM) 
	{
		CTFOpenJoinMenu(ent);
		return;
	}

	if (ent->client->menu) {
		PMenu_Close(ent);
		ent->client->update_chase = true;
		return;
	}
//ZOID

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
}

/*
=================
Cmd_InvUse_f
=================
*/
void Cmd_InvUse_f (edict_t *ent)
{
	gitem_t		*it;

//ZOID
	if (ent->client->menu) {
		PMenu_Select(ent);
		return;
	}
//ZOID

	//TROND big fix 10/4
	if (ent->movetype == MOVETYPE_NOCLIP)
		return;
	//TROND slutt

	ValidateSelectedItem (ent);

	if (ent->client->pers.selected_item == -1)
	{
		gi.cprintf (ent, PRINT_HIGH, "No item to use.\n");
		return;
	}

	it = &itemlist[ent->client->pers.selected_item];
	if (!it->use)
	{
		//TROND 24/3
		if (ent->client->pers.inventory[ITEM_INDEX(it)] == 0)
		{
			SelectNextItem (ent, -1);
			return;
		}
		//TROND kul mekk 21/3
		if (it->drop)
		{
			if (it->pickup == Pickup_Ammo
				|| it->pickup == Pickup_Key)
			{
				it->drop (ent, it);
	//		Drop_Item (ent, it);
	//		ent->client->pers.selected_item = -1;
				SelectNextItem (ent, -1);
				ent->client->weight += 2;
				//TROND 1/4
				if (it == FindItem("m60ammo"))
				{
					ent->client->torso_item = 0;
					ShowTorso(ent);
					ent->client->weight += 8;
				}
				//TROND slutt
				return;
			}
			if (it->pickup == Pickup_Item)
			{
				if (it == FindItem("ir goggles"))
				{
					ent->client->ps.rdflags &= ~RDF_IRGOGGLES;
					ent->client->infrared = 0;
					ent->client->head_item = 0;
					Drop_Item (ent, it);
					SelectNextItem (ent, -1);
					ent->client->weight += 3;
					ent->client->pers.inventory[ITEM_INDEX(it)] = 0;

					ShowItem (ent);//TROND	5/4
					ShowTorso (ent);//TROND	5/4

					return;
				}
				if (it == FindItem("head light")
					|| it == FindItem("helmet"))
				{
					if (ent->client->fl_on == 1)
						SP_FlashLight (ent);
					ent->client->fl_on = 0;
					ent->client->head_item = 0;
					Drop_Item (ent, it);
					SelectNextItem (ent, -1);
					ent->client->weight += 2;
					ent->client->pers.inventory[ITEM_INDEX(it)] = 0;

					ShowItem (ent);//TROND	5/4
					ShowTorso (ent);//TROND	5/4

					return;
				}
				if (it == FindItem("bullet proof vest"))
				{
					ent->client->torso_item = 0;
					Drop_Item (ent, it);
					SelectNextItem (ent, -1);
					ent->client->weight += 4;
					ent->client->pers.inventory[ITEM_INDEX(it)] = 0;

					ShowItem (ent);//TROND	5/4
					ShowTorso (ent);//TROND	5/4

					return;
				}
				if (it == FindItem("scuba gear"))
				{
					ent->client->torso_item = 0;
					Drop_Item (ent, it);
					SelectNextItem (ent, -1);
					ent->client->weight += 5;
					ent->client->pers.inventory[ITEM_INDEX(it)] = 0;

					ShowItem (ent);//TROND	5/4
					ShowTorso (ent);//TROND	5/4

					return;
				}
				if (it == FindItem("medkit"))
				{
					ent->client->torso_item = 0;
					Drop_Item (ent, it);
					SelectNextItem (ent, -1);
					ent->client->weight += 2;
					ent->client->pers.inventory[ITEM_INDEX(it)] = 0;

					ShowItem (ent);//TROND	5/4
					ShowTorso (ent);//TROND	5/4

					return;
				}
			}
			return;
		}
		//TROND slutt
//		gi.cprintf (ent, PRINT_HIGH, "Item is not usable.\n");//TROND tatt vekk 24/3
		return;
	}
	it->use (ent, it);
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

	//TROND 10/4
	if (ent->movetype == MOVETYPE_NOCLIP)
		return;
	//TROND slutt

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
//ZOID
	if (ent->solid == SOLID_NOT)
		return;
//ZOID

	if((level.time - ent->client->respawn_time) < 5)
		return;
	ent->flags &= ~FL_GODMODE;
	ent->health = 0;
	meansOfDeath = MOD_SUICIDE;
	player_die (ent, ent, ent, 100000, vec3_origin);
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

//ZOID
	if (ent->client->menu)
		PMenu_Close(ent);
	ent->client->update_chase = true;
//ZOID
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

/*
==================
Cmd_Say_f
==================
*/
void Cmd_Say_f (edict_t *ent, qboolean team, qboolean arg0)
{
	int		i, j;
	edict_t	*other;
	char	*p;
	char	text[2048];
	gclient_t *cl;

	if (gi.argc () < 2 && !arg0)
		return;

	if (!((int)(dmflags->value) & (DF_MODELTEAMS | DF_SKINTEAMS)))
		team = false;

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

	if (flood_msgs->value) {
		cl = ent->client;

        if (level.time < cl->flood_locktill) {
			gi.cprintf(ent, PRINT_HIGH, "You can't talk for %d more seconds\n",
				(int)(cl->flood_locktill - level.time));
            return;
        }
        i = cl->flood_whenhead - flood_msgs->value + 1;
        if (i < 0)
            i = (sizeof(cl->flood_when)/sizeof(cl->flood_when[0])) + i;
		if (cl->flood_when[i] &&
			level.time - cl->flood_when[i] < flood_persecond->value) {
			cl->flood_locktill = level.time + flood_waitdelay->value;
			gi.cprintf(ent, PRINT_CHAT, "Flood protection:  You can't talk for %d seconds.\n",
				(int)flood_waitdelay->value);
            return;
        }
		cl->flood_whenhead = (cl->flood_whenhead + 1) %
			(sizeof(cl->flood_when)/sizeof(cl->flood_when[0]));
		cl->flood_when[cl->flood_whenhead] = level.time;
	}

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
			if (!OnSameTeam(ent, other)
	//			|| (ent->client->resp.ctf_team != other->client->resp.ctf_team)//TROND linje 27/3
				)
				continue;
			//TROND 10/4
//			if (ent->client->resp.ctf_team != other->client->resp.ctf_team)
//				continue;
			//TROND slutt
		}
		//TROND 10/4
//		if (ent->client->resp.ctf_team != other->client->resp.ctf_team)
//			continue;
		//TROND slutt
		gi.cprintf(other, PRINT_CHAT, "%s", text);
	}
}

//TROND 10/4 messagemode2
void Cmd_Say_Team_f (edict_t *ent, qboolean team, qboolean arg0)
{
	int		i, j;
	edict_t	*other;
	char	*p;
	char	text[2048];
	gclient_t *cl;

	if (gi.argc () < 2 && !arg0)
		return;

	if (!((int)(dmflags->value) & (DF_MODELTEAMS | DF_SKINTEAMS)))
		team = false;

	//TROND leader 13/4
	if (leader->value
		&& (ent->client->t_leader == 1
		|| ent->client->s_leader == 1))
	{
		Com_sprintf (text, sizeof(text), "**LEADER (%s)**: ", ent->client->pers.netname);
	}
	else
		//TROND slutt
	Com_sprintf (text, sizeof(text), "**Teammate (%s)**: ", ent->client->pers.netname);

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

	if (flood_msgs->value) {
		cl = ent->client;

        if (level.time < cl->flood_locktill) {
			gi.cprintf(ent, PRINT_HIGH, "You can't talk for %d more seconds\n",
				(int)(cl->flood_locktill - level.time));
            return;
        }
        i = cl->flood_whenhead - flood_msgs->value + 1;
        if (i < 0)
            i = (sizeof(cl->flood_when)/sizeof(cl->flood_when[0])) + i;
		if (cl->flood_when[i] &&
			level.time - cl->flood_when[i] < flood_persecond->value) {
			cl->flood_locktill = level.time + flood_waitdelay->value;
			gi.cprintf(ent, PRINT_CHAT, "Flood protection:  You can't talk for %d seconds.\n",
				(int)flood_waitdelay->value);
            return;
        }
		cl->flood_whenhead = (cl->flood_whenhead + 1) %
			(sizeof(cl->flood_when)/sizeof(cl->flood_when[0]));
		cl->flood_when[cl->flood_whenhead] = level.time;
	}

	if (dedicated->value)
		gi.cprintf(NULL, PRINT_CHAT, "%s", text);

	for (j = 1; j <= game.maxclients; j++)
	{
		other = &g_edicts[j];
		if (!other->inuse)
			continue;
		if (!other->client)
			continue;
		if (ent->client->resp.ctf_team != other->client->resp.ctf_team)
			continue;
		//TROND slutt
		gi.cprintf(other, PRINT_CHAT, "%s", text);
	}
}
//TROND slutt

void Cmd_PlayerList_f(edict_t *ent)
{
	int i;
	char st[80];
	char text[1400];
	edict_t *e2;

	// connect time, ping, score, name
	*text = 0;
	for (i = 0, e2 = g_edicts + 1; i < maxclients->value; i++, e2++) {
		if (!e2->inuse)
			continue;

		Com_sprintf(st, sizeof(st), "%02d:%02d %4d %3d %s%s\n",
			(level.framenum - e2->client->resp.enterframe) / 600,
			((level.framenum - e2->client->resp.enterframe) % 600)/10,
			e2->client->ping,
			e2->client->resp.score,
			e2->client->pers.netname,
			e2->client->resp.spectator ? " (spectator)" : "");
		if (strlen(text) + strlen(st) > sizeof(text) - 50) {
			sprintf(text+strlen(text), "And more...\n");
			gi.cprintf(ent, PRINT_HIGH, "%s", text);
			return;
		}
		strcat(text, st);
	}
	gi.cprintf(ent, PRINT_HIGH, "%s", text);
}


/*
=================
ClientCommand
=================
*/
void ClientCommand (edict_t *ent)
{
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
//		Cmd_Say_f (ent, true, false);//TROND mekk 10/4
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
	else if (Q_stricmp (cmd, "give") == 0)
		gi.cprintf (ent, PRINT_HIGH, "Hehe, no cheating around here, I can assure you that :^)\n");
//TROND 16/3
//		Cmd_Give_f (ent);
	else if (Q_stricmp (cmd, "god") == 0)
//		gi.cprintf (ent, PRINT_HIGH, "Hehe, no cheating around here, I can assure you that :^)\n");//TROND tatt vekk 9/4
//TROND 16/3
		Cmd_God_f (ent);//TROND tatt tilbake 9/4
	else if (Q_stricmp (cmd, "notarget") == 0)
		Cmd_Notarget_f (ent);
	else if (Q_stricmp (cmd, "noclip") == 0)
		Cmd_Noclip_f (ent);
	else if (Q_stricmp (cmd, "inven") == 0)
		Cmd_Inven_f (ent);
	else if (Q_stricmp (cmd, "invnext") == 0)
		SelectNextItem (ent, -1);
	else if (Q_stricmp (cmd, "invprev") == 0)
		SelectPrevItem (ent, -1);
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
	//TROND mekk
/*	else if (Q_stricmp (cmd, "invdrop") == 0)
		Cmd_InvDrop_f (ent);*/
	else if (Q_stricmp (cmd, "weapprev") == 0)
		Cmd_WeapPrev_f (ent);
	else if (Q_stricmp (cmd, "weapnext") == 0)
		Cmd_WeapNext_f (ent);
	else if (Q_stricmp (cmd, "weaplast") == 0)
		Cmd_WeapLast_f (ent);
	else if (Q_stricmp (cmd, "kill") == 0)
		Cmd_Kill_f (ent);
	else if (Q_stricmp (cmd, "putaway") == 0)
		Cmd_PutAway_f (ent);
	else if (Q_stricmp (cmd, "wave") == 0)
		Cmd_Wave_f (ent);

	//TROND
	//RELOAD
	else if (Q_stricmp(cmd, "reload") == 0)
		Cmd_Reload_f (ent);
	//TROND slutt

/*	//TROND
	//LASERSIKTE
	else if (Q_stricmp(cmd, "laser") == 0)
	{
//		if (ent->client->pers.weapon == FindItem("railgun"))
			SP_LaserSight (ent);
	}
	//TROND slutt

/*	//TROND
	//LOMMELYKT
	else if (Q_stricmp(cmd, "fl") == 0)
		SP_FlashLight (ent);
	//TROND slutt*/

	//TROND
	//OPNE DØR
	else if (Q_stricmp(cmd, "opendoor") == 0)
		Cmd_Door_f (ent);

	else if (Q_stricmp(cmd, "tq_version") == 0)
		gi.centerprintf (ent, "Terror Quake 2\nV. 1.0\n13. May 1999\n");
	//TROND slutt

/*	//TROND
	//NPC
	else if (Q_stricmp(cmd, "npc") == 0)
		Cmd_NPC_f (ent);
	//TROND slutt*/

	//TROND
	//DETONERE DETPACK
	else if (Q_stricmp(cmd, "detpack") == 0)
		Cmd_Detpack_f (ent);
	//TROND slutt

	//TROND
	//DETONERE DETPACK
	else if (Q_stricmp(cmd, "item") == 0)
		Cmd_InfraRed_f (ent);
	//TROND slutt

	//TROND
	//KAST VÅPEN
	else if (Q_stricmp(cmd, "weapondrop") == 0)
	{
		if (ent->client->weaponstate == WEAPON_READY)
			Cmd_Drop_Weapon_f (ent);
	}
	//TROND slutt

	//TROND
	//KAST ITEM
	else if (Q_stricmp(cmd, "itemdrop") == 0)
		Cmd_Drop_Item_f (ent);
	//TROND slutt

	//TROND
	//BLØ
	else if (Q_stricmp(cmd, "bandage") == 0)
		Cmd_Bandage_f (ent);
	//TROND slutt

	//TROND
	//ZOOM
	else if (Q_stricmp(cmd, "weapon") == 0)
	{
		//TROND lagt til 13/4
		if (ent->client->weaponstate == WEAPON_READY
			|| (ent->client->weaponstate == WEAPON_FIRING
			&& ent->client->pers.weapon == FindItem("grenades")))
			Cmd_Zoom_f (ent);
	}
	//TROND slutt

	//TROND
	//USE SPECIAL
	else if (Q_stricmp(cmd, "special") == 0)
	{
		if (ent->client->weaponstate == WEAPON_READY)
		{
			SelectNextSpecial (ent, +1);
			Cmd_InvUse_f (ent);
//		Cmd_UseSpecial_f (ent);
		}
//		Cmd_UseSpecial_f (ent);
	}

	//ITEM
	else if (Q_stricmp(cmd, "specialitem") == 0)
	{
		SelectNextSpecialItem (ent, +1);
	}
	//TROND slutt

	else if (Q_stricmp(cmd, "playerlist") == 0)
		Cmd_PlayerList_f(ent);
//ZOID
	//TROND tatt vekk 29/3
	/*
	else if (Q_stricmp (cmd, "team") == 0)
	{
		CTFTeam_f (ent);
	}
	*/
	//TROND slutt
//TROND tatt vekk
/*	else if (Q_stricmp(cmd, "id") == 0) 
	{
		CTFID_f (ent);
	}*/
//ZOID
	else	// anything that doesn't match a command will be a chat
		Cmd_Say_f (ent, false, true);
}
