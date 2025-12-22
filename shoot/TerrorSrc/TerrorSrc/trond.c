//TROND
#include "g_local.h"

void PMenu_Close(edict_t *ent);//28/3

//SP VALUES
void SP_Values (edict_t *ent)
{
	if (!ent->client)
		return;

	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("bullet proof vest"))]
		|| ent->client->pers.inventory[ITEM_INDEX(FindItem("medkit"))]
		|| ent->client->pers.inventory[ITEM_INDEX(FindItem("scuba gear"))])
	{
		ent->client->torso_item = 1;
	}
	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("helmet"))]
		|| ent->client->pers.inventory[ITEM_INDEX(FindItem("ir goggles"))]
		|| ent->client->pers.inventory[ITEM_INDEX(FindItem("head light"))])
	{
		ent->client->head_item = 1;
	}
	if (ent->client->pers.inventory[ITEM_INDEX(FindItem("weight"))] == 0)
		return;

	ent->client->weight = (ent->client->pers.inventory[ITEM_INDEX(FindItem("weight"))]);
	ent->client->pers.inventory[ITEM_INDEX(FindItem("weight"))] = 0;
}

//PAIN SKIN
void painskin (edict_t *player)
{
	int		playernum = player-g_edicts-1;
	char	model[64];//28/3
	char	model2[64];//10/4

	if (!player->client)
		return;
	PMenu_Close(player);

	if (player->client->resp.skins == 1)
		strcpy(model, "team1/");
	else if (player->client->resp.skins == 2)
		strcpy(model, "messiah/");
	else if (player->client->resp.skins == 3)
		strcpy(model, "team2/");
	else if (player->client->resp.skins == 4)
		strcpy(model, "crakhor/");
	else
		strcpy(model, "team1/");
	if (ctf->value)
	{
		strcpy(model, "team1/");
		strcpy(model2, "team2/");//TROND 10/4
	}

	//10/4 ATL
	if (player->client->t_leader == 1)
		strcpy(model, "messiah/");
	else if (player->client->s_leader == 1)
		strcpy(model2, "crakhor/");
	
	if (player->client->resp.ctf_team == CTF_TEAM2)
	{
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "no_damage") );

		//alt som har med hove skade å gjør
		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "h") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "hc") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "hs") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "hl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "hcs") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "hcl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "hsl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "hcsl") );
		//alt som he med bryst å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "c") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "cs") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "cl") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "csl") );
		//alt som he med mage å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "s") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "sl") );
		//alt som he med bein å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model2, "l") );
	}
	else
	{
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "no_damage") );

		//alt som har med hove skade å gjør
		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "h") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "hc") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "hs") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "hl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "hcs") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "hcl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "hsl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "hcsl") );
		//alt som he med bryst å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "c") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "cs") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "cl") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "csl") );
		//alt som he med mage å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "s") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "sl") );
		//alt som he med bein å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, model, "l") );
	}
	//gi.bprintf (PRINT_HIGH, "DEBUG: pain skin function passed\n");
	//TROND slutt
}

//TROND safe
/*
void painskin (edict_t *player)
{
	int		playernum = player-g_edicts-1;

	if (!player->client)
		return;
	PMenu_Close(player);

	if (player->client->resp.ctf_team == CTF_TEAM2)
	{
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "no_damage") );

		//alt som har med hove skade å gjør
		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "h") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "hc") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "hs") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "hl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "hcs") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "hcl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "hsl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "hcsl") );
		//alt som he med bryst å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "c") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "cs") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "cl") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "csl") );
		//alt som he med mage å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "s") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "sl") );
		//alt som he med bein å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team2/", "l") );
	}
	else
	{
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "no_damage") );

		//alt som har med hove skade å gjør
		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "h") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "hc") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "hs") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "hl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "hcs") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "hcl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "hsl") );

		if (player->client->pain_head == 1
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "hcsl") );
		//alt som he med bryst å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "c") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "cs") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "cl") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 1
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "csl") );
		//alt som he med mage å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 0)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "s") );

		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 1
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "sl") );
		//alt som he med bein å gjør
		if (player->client->pain_head == 0
			&& player->client->pain_chest == 0
			&& player->client->pain_stomach == 0
			&& player->client->pain_leg == 1)
			gi.configstring (CS_PLAYERSKINS+playernum, va("%s\\%s%s", 
			player->client->pers.netname, "team1/", "l") );
	}
	//gi.bprintf (PRINT_HIGH, "DEBUG: pain skin function passed\n");
	//TROND slutt
}
*/
/*
//SJEKK KÅ MANGE SPILLERE
void player_count (edict_t *player)
{
	int		numplayers = 0;
	int		i;

		for (i = 1; i <= game.maxclients; i++) 
	{
		player = g_edicts + i;
		if (player->inuse)
			numplayers++;
	}

	gi.bprintf (PRINT_HIGH, "There is/are %i player(s) on the server", numplayers);

	return;
}
*/