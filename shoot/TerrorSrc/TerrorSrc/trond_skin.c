#include "g_local.h"

void CTFCredits(edict_t *ent, pmenu_t *p);
void CTFOpenWepMenu(edict_t *ent);//TROND 10/4

//SKIN bytte  28/3
void ChangeSkin1(edict_t *ent, pmenu_t *p)
{
	if (!ent->client)
		return;
	ent->client->resp.skins = 1;
	painskin (ent);
}
void ChangeSkin2(edict_t *ent, pmenu_t *p)
{
	if (!ent->client)
		return;
	ent->client->resp.skins = 2;
	painskin (ent);
}
void ChangeSkin3(edict_t *ent, pmenu_t *p)
{
	if (!ent->client)
		return;
	ent->client->resp.skins = 3;
	painskin (ent);
}
void ChangeSkin4(edict_t *ent, pmenu_t *p)
{
	if (!ent->client)
		return;
	ent->client->resp.skins = 4;
	painskin (ent);
}

pmenu_t skinmenu[] = 
{
	//TROND
	//MEKKA PÅ MENYOPPSETT
	{ "*SLAT Software`s Terror Quake",	PMENU_ALIGN_CENTER, NULL, NULL },
	{ NULL,					PMENU_ALIGN_CENTER, NULL, NULL },
	{ "*What do you wanna play as?",PMENU_ALIGN_CENTER, NULL, NULL },
	{ NULL,					PMENU_ALIGN_CENTER, NULL, NULL },
	{ "Terrorist",		PMENU_ALIGN_LEFT, NULL, ChangeSkin1 },
	{ "Terminator",	PMENU_ALIGN_LEFT, NULL, ChangeSkin2 },
	{ "SWAT",		PMENU_ALIGN_LEFT, NULL, ChangeSkin3 },
	{ "Police Woman",		PMENU_ALIGN_LEFT, NULL, ChangeSkin4 },
	{ NULL,					PMENU_ALIGN_LEFT, NULL, NULL },
//	{ "Chase Camera",		PMENU_ALIGN_LEFT, NULL, CTFChaseCam },
	{ NULL,					PMENU_ALIGN_LEFT, NULL, NULL },
	{ NULL,					PMENU_ALIGN_LEFT, NULL, NULL },
	{ "Use [ and ] to move cursor",	PMENU_ALIGN_LEFT, NULL, NULL },
	{ "ENTER to select",	PMENU_ALIGN_LEFT, NULL, NULL },
	{ NULL,					PMENU_ALIGN_LEFT, NULL, NULL },
	{ NULL,					PMENU_ALIGN_LEFT, NULL, NULL },
	{ NULL,					PMENU_ALIGN_LEFT, NULL, NULL },
	{ NULL,			PMENU_ALIGN_RIGHT, NULL, NULL },
//	{ "v" CTF_STRING_VERSION,	PMENU_ALIGN_RIGHT, NULL, NULL },
	//TROND slutt
};

int CTFUpdateSkinMenu(edict_t *ent)
{
	static char levelname[32];
	static char team1players[32];
	static char team2players[32];
	int num1, num2, i;

	//TROND
	//MEKKA PÅ LAGNAVN
	skinmenu[4].text = "Terrorist";
//	skinmenu[5].SelectFunc = CTFJoinTeam1;
	skinmenu[5].text = "Terminator";
	skinmenu[6].text = "SWAT";
	skinmenu[7].text = "Police Woman";
//	skinmenu[7].SelectFunc = CTFJoinTeam2;
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

void CTFOpenSkinMenu(edict_t *ent)
{
	int team;

	ent->client->resp.skin_chosen = 1;
	team = CTFUpdateSkinMenu(ent);
	if (ent->client->chase_target)
		team = 8;
	else if (team == CTF_TEAM1)
		team = 4;
	else
		team = 6;
	PMenu_Open(ent, skinmenu, team, sizeof(skinmenu) / sizeof(pmenu_t));
}