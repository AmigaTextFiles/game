//TROND
#include "g_local.h"
#include "m_player.h"

//VITEMS
void ShowItem(edict_t *ent)
{
	char heldmodel[128];
	int len;

	if(!ent->client->head_item)
	{
		ent->s.modelindex4 = 0;
//		gi.cprintf (ent, PRINT_HIGH, "Killed modelindex4\n");
		return;
	}

	if (ctf->value
		&& ent->client->resp.ctf_team == CTF_TEAM2)
		strcpy(heldmodel, "players/team2/");
	else
	{
		if (ent->client->resp.skins == 1)
			strcpy(heldmodel, "players/team1/");
		else if (ent->client->resp.skins == 2)
			strcpy(heldmodel, "players/messiah/");
		else if (ent->client->resp.skins == 3)
			strcpy(heldmodel, "players/team2/");
		else if (ent->client->resp.skins == 4)
			strcpy(heldmodel, "players/crakhor/");
		else
			strcpy(heldmodel, "players/team1/");
	}

	//TROND ATL 10/4
	if (ctf->value
		&& ent->client->s_leader == 1)
		strcpy(heldmodel, "players/crakhor/");
	else if (ctf->value
		&& ent->client->t_leader == 1)
		strcpy(heldmodel, "players/messiah/");
	//TROND slutt

//	strcat(heldmodel, Info_ValueForKey (ent->client->pers.userinfo, "skin"));

	for(len = 8; heldmodel[len]; len++)
	{
		if(heldmodel[len] == '/')
			heldmodel[++len] = '\0';
	}
//	strcat(heldmodel, ent->client->pers.weapon->icon);	
	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("helmet"))])
		strcat(heldmodel, "i_helmet.md2");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("ir goggles"))])
		strcat(heldmodel, "i_ir.md2");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("head light"))])
		strcat(heldmodel, "i_light.md2");
	else
		strcat(heldmodel, "null.md2");
//	gi.cprintf (ent, PRINT_HIGH, "%s\n", heldmodel);
	ent->s.modelindex4 = gi.modelindex(heldmodel);	// Hentai's custom gun models

}
void ShowTorso(edict_t *ent)
{
	char heldmodel[128];
	int len;

	if(!ent->client->torso_item)
	{
		ent->s.modelindex3 = 0;
//		gi.cprintf (ent, PRINT_HIGH, "Killed modelindex3\n");
		return;
	}

	if (ctf->value
		&& ent->client->resp.ctf_team == CTF_TEAM2)
		strcpy(heldmodel, "players/team2/");
	else
	{
		if (ent->client->resp.skins == 1)
			strcpy(heldmodel, "players/team1/");
		else if (ent->client->resp.skins == 2)
			strcpy(heldmodel, "players/messiah/");
		else if (ent->client->resp.skins == 3)
			strcpy(heldmodel, "players/team2/");
		else if (ent->client->resp.skins == 4)
			strcpy(heldmodel, "players/crakhor/");
		else
			strcpy(heldmodel, "players/team1/");
	}

	//TROND ATL 10/4
	if (ctf->value
		&& ent->client->s_leader == 1)
		strcpy(heldmodel, "players/crakhor/");
	else if (ctf->value
		&& ent->client->t_leader == 1)
		strcpy(heldmodel, "players/messiah/");
	//TROND slutt

	for(len = 8; heldmodel[len]; len++)
	{
		if(heldmodel[len] == '/')
			heldmodel[++len] = '\0';
	}

	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("bullet proof vest"))])
		strcat(heldmodel, "i_vest.md2");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("scuba gear"))])
		strcat(heldmodel, "i_scuba.md2");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("medkit"))])
		strcat(heldmodel, "i_medkit.md2");
	else if (ent->client->pers.inventory[ITEM_INDEX(FindItem("m60ammo"))]
		|| ent->client->pers.inventory[ITEM_INDEX(FindItem("m60"))])
		strcat(heldmodel, "i_m60ammo.md2");
	else
		strcat(heldmodel, "null.md2");
//	gi.cprintf (ent, PRINT_HIGH, "%s\n", heldmodel);
	ent->s.modelindex3 = gi.modelindex(heldmodel);	// Hentai's custom gun models

}
//TROND slutt