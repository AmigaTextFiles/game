//TROND
#include "g_local.h"
#include "m_player.h"

void Visible_Items (edict_t *self)
{
	if (!self->client)
		return;

	if (self->client->pers.inventory[ITEM_INDEX(FindItem("helmet"))])
	{
		if (ctf->value
			&& self->client->resp.ctf_team == CTF_TEAM2)
			self->s.modelindex4 = gi.modelindex("players/team2/w_helmet.md2");
		else
			self->s.modelindex4 = gi.modelindex("players/team1/w_helmet.md2");
	}
	else
		self->s.modelindex4 = 0;
}

void Decide_Score (edict_t *self, edict_t *attacker)
{
	//TROND slutt
	if (attacker == self
		&& !ctf->value)
		attacker->client->resp.score--;
	else
	{
		if (!ctf->value)
		{
			attacker->client->kills += 1;//TROND linje staying alive...
			if (attacker->client->kills < 4)
			{
				attacker->client->resp.score += 1;
				if (attacker->client->kills > 1)
				gi.cprintf (attacker, PRINT_HIGH, "You have %d kills in a row\n", attacker->client->kills);
			}
			else if (attacker->client->kills >= 4
					&& attacker->client->kills < 8)
			{
				gi.bprintf (PRINT_HIGH, "%s has %d kills in a row, he now gets 2 frags per kill\n", attacker->client->pers.netname, attacker->client->kills);
				attacker->client->resp.score += 2;
			}
			else if (attacker->client->kills >= 8
					&& attacker->client->kills < 12)
			{
				gi.bprintf (PRINT_HIGH, "%s has %d kills in a row, he now gets 4 frags per kill\n", attacker->client->pers.netname, attacker->client->kills);
				attacker->client->resp.score += 4;
			}
			else if (attacker->client->kills >= 12
					&& attacker->client->kills < 16)
			{
				gi.bprintf (PRINT_HIGH, "%s has %d kills in a row, he now gets 6 frags per kill\n", attacker->client->pers.netname, attacker->client->kills);
				attacker->client->resp.score += 6;
			}
			else if (attacker->client->kills >= 16)
			{
				gi.bprintf (PRINT_HIGH, "%s has %d kills in a row, he now gets 8 frags per kill\n", attacker->client->pers.netname, attacker->client->kills);
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
			else if (attacker->client
				&& self->client
				&& self == attacker
				&& ctf->value)
			{
				if (attacker->client->resp.ctf_team == CTF_TEAM1)
					ctfgame.team1--;
				else
					ctfgame.team2--;
			}
		}
	}
}