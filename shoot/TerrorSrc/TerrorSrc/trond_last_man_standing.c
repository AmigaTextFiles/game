//TROND Last Man Standing

#include "g_local.h"

void CheckLMSRules ( void )
{
	int		i;
	int		players = 0;
	int		dead_players = 0;//Egentlig ALIVE men.... :^)
	int		alive_players = 0;
	edict_t	*ppl;

	for (i=0 ; i<maxclients->value ; i++)
	{
		if (!g_edicts[i+1].inuse)
			continue;

		players++;
	}
	lms_players = players;
	if (lms_players > 1
		&& lms_round == 0)
	{
		lms_round = 1;
		lms_delay = level.time + 7;
//		gi.bprintf (PRINT_CHAT, "10 seconds left\n");
	}

	for (i=0 ; i<maxclients->value ; i++)
	{
		if (!g_edicts[i+1].inuse)
			continue;
		if (g_edicts[i+1].client->resp.lms_dead)
			continue;

		dead_players++;
	}
	lms_dead_players = dead_players;

	//		3/5
	for (i=0 ; i<maxclients->value ; i++)
	{
		if (!g_edicts[i+1].inuse)
			continue;
		if (g_edicts[i+1].client->resp.lms_dead)
			continue;
		if (g_edicts[i+1].movetype == MOVETYPE_NOCLIP)
			continue;
		if (g_edicts[i+1].deadflag != 0)
			continue;

		alive_players++;
	}
	lms_alive_players = alive_players;
	//		3/5 slutt

	//gi.bprintf (PRINT_HIGH, "%i\n", lms_alive_players);

	if (lms_dead_players == 1
		&& lms_players > 1)
	{
//		gi.bprintf (PRINT_CHAT, "Round over\n");
		lms_round = 0;

		for (i=0 ; i<maxclients->value ; i++)
		{
			ppl = g_edicts + 1 + i; //selects next player
			if(ppl->inuse && ppl->client) 
			{ 
				ppl->client->lms_allowed = 0;
				ppl->client->resp.lms_dead = 0;
			}
		}
	}

	//TROND 3/5
	if (lms_dead_players == 0
		&& lms_players > 1)
	{
		lms_round = 0;

		for (i=0 ; i<maxclients->value ; i++)
		{
			ppl = g_edicts + 1 + i; //selects next player
			if(ppl->inuse && ppl->client) 
			{ 
				ppl->client->lms_allowed = 0;
				ppl->client->resp.lms_dead = 0;			
			}
		}
	}
}

void LMS_PlayerCount ( void )
{
	int		i;
	int		players = 0;
	int		dead_players = 0;
	edict_t	*ppl = NULL;

	for (i=0 ; i<maxclients->value ; i++)
	{
		if (!g_edicts[i+1].inuse)
			continue;

		players++;
	}
	lms_players = players;

	for (i=0 ; i<maxclients->value ; i++)
	{
		if (!g_edicts[i+1].inuse)
			continue;
		if (!g_edicts[i+1].client->resp.lms_dead)
			continue;

		dead_players++;
	}
	if (dead_players == 1
		&& players > 1)
	{
		lms_delay2 = level.time + 5;
		lms_round_over = 1;
		lms_round = 0;
		gi.bprintf (PRINT_HIGH, "5 secs till next round\n");
	}
}