#include "g_local.h"

//VÅPEN i SP
void Beretta(edict_t *ent, pmenu_t *p)
{
	if (ent->client->weight < 4)
		return;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("beretta"))] = 1;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("berettarounds"))] = 15;
	ent->client->weight -= 4;
}
void Glock(edict_t *ent, pmenu_t *p)
{
	if (ent->client->weight < 5)
		return;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("glock"))] = 1;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("glockrounds"))] = 17;
	ent->client->weight -= 5;
}
void Casull(edict_t *ent, pmenu_t *p)
{
	if (ent->client->weight < 8)
		return;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("casull"))] = 1;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("casullrounds"))] = 5;
	ent->client->weight -= 8;
}
void MP5(edict_t *ent, pmenu_t *p)
{
	if (ent->client->weight < 8)
		return;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5"))] = 1;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("mp5rounds"))] = 32;
	ent->client->weight -= 8;
}
void Mariner(edict_t *ent, pmenu_t *p)
{
	if (ent->client->weight < 9)
		return;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("mariner"))] = 1;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("marinerrounds"))] = 9;
	ent->client->weight -= 9;
}
void AK47(edict_t *ent, pmenu_t *p)
{
	if (ent->client->weight < 11)
		return;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("ak 47"))] = 1;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("ak47rounds"))] = 40;
	ent->client->weight -= 11;
}
void Barrett(edict_t *ent, pmenu_t *p)
{
	if (ent->client->weight < 17)
		return;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("barrett"))] = 1;
	ent->client->pers.inventory[ITEM_INDEX(FindItem("50cal"))] = 10;
	ent->client->weight -= 17;
}

void Join(edict_t *ent, pmenu_t *p)
{
	PutClientInServer (ent);
}

pmenu_t weapmenu[] = 
{
	//TROND
	//MEKKA PÅ MENYOPPSETT
	{ "*SLAT Software`s Terror Quake",	PMENU_ALIGN_CENTER, NULL, NULL },
	{ NULL,					PMENU_ALIGN_CENTER, NULL, NULL },
	{ "*What weapon(s) do you want?",PMENU_ALIGN_CENTER, NULL, NULL },
	{ NULL,					PMENU_ALIGN_CENTER, NULL, NULL },
	{ "Beretta 92FS",		PMENU_ALIGN_LEFT, NULL, Beretta },
	{ "Glock 17 w/silencer",	PMENU_ALIGN_LEFT, NULL, Glock },
	{ "Casull .454",		PMENU_ALIGN_LEFT, NULL, Casull },
	{ "MP5 w/silencer",		PMENU_ALIGN_LEFT, NULL, MP5 },
	{ "Mariner shotgun",					PMENU_ALIGN_LEFT, NULL, Mariner },
//	{ "Chase Camera",		PMENU_ALIGN_LEFT, NULL, CTFChaseCam },
	{ "AK47",					PMENU_ALIGN_LEFT, NULL, AK47 },
	{ "Barrett",					PMENU_ALIGN_LEFT, NULL, Barrett },
	{ "Join game",					PMENU_ALIGN_LEFT, NULL, Join },
	{ NULL,					PMENU_ALIGN_LEFT, NULL, NULL },
	{ "Use [ and ] to move cursor",	PMENU_ALIGN_LEFT, NULL, NULL },
	{ "ENTER to select",	PMENU_ALIGN_LEFT, NULL, NULL },
	{ NULL,					PMENU_ALIGN_LEFT, NULL, NULL },
	{ NULL,			PMENU_ALIGN_RIGHT, NULL, NULL },
//	{ "v" CTF_STRING_VERSION,	PMENU_ALIGN_RIGHT, NULL, NULL },
	//TROND slutt
};

int CTFUpdateWepMenu(edict_t *ent)
{
	static char levelname[32];
	static char team1players[32];
	static char team2players[32];
	int num1, num2, i;

	//TROND
	//MEKKA PÅ LAGNAVN

	weapmenu[4].text = "Beretta 92FS";
	weapmenu[5].text = "Glock 17 w/silencer";
	weapmenu[6].text = "Casull .454";
	weapmenu[7].text = "MP5 w/silencer";
	weapmenu[8].text = "Mariner shotgun";
	weapmenu[9].text = "AK47";
	weapmenu[10].text = "Barrett";
	weapmenu[11].text = "Join game";
	//TROND slutt


	levelname[0] = '*';
	if (g_edicts[0].message)
		strncpy(levelname+1, g_edicts[0].message, sizeof(levelname) - 2);
	else
		strncpy(levelname+1, level.mapname, sizeof(levelname) - 2);
	levelname[sizeof(levelname) - 1] = 0;

	num1 = num2 = 0;
	for (i = 0; i < maxclients->value; i++) {
		if (!g_edicts[i+1].inuse)
			continue;
		if (game.clients[i].resp.ctf_team == CTF_TEAM1)
			num1++;
		else if (game.clients[i].resp.ctf_team == CTF_TEAM2)
			num2++;
	}

	//TROND
	//MEKKA PÅ LAGNAVN
	sprintf(team1players, "  (%d Terrorist(s))", num1);
	sprintf(team2players, "  (%d Police guy(s))", num2);
	//TROND slutt

//	skinmenu[2].text = levelname;

	if (num1 > num2)
		return CTF_TEAM1;
	else if (num2 > num1)
		return CTF_TEAM1;
	return (rand() & 1) ? CTF_TEAM1 : CTF_TEAM2;
}

void CTFOpenWepMenu(edict_t *ent)
{
	int team;

	team = CTFUpdateWepMenu(ent);
	if (ent->client->chase_target)
		team = 8;
	else if (team == CTF_TEAM1)
		team = 4;
	else
		team = 6;
	PMenu_Open(ent, weapmenu, team, sizeof(weapmenu) / sizeof(pmenu_t));
}