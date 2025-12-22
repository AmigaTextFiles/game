#include "g_local.h"
#include "scanner.h"

void	ClearScanner(gclient_t *client)
{
	client->pers.scanner_active = 0;
}

void    ClearClasses(gclient_t *client)
{
        client->pers.classes_active = 0;
}

void Toggle_Scanner (edict_t *ent)
{
	if ((!ent->client) || (ent->health<=0))
		return;

	// toggle low on/off bit (and clear scores/inventory display if required)
	if ((ent->client->pers.scanner_active ^= 1) & 1)
	{
		ent -> client -> showinventory	= 0;
		ent -> client -> showscores		= 0;
	}

	// set "just changed" bit
	ent->client->pers.scanner_active |= 2;
}

void Toggle_Classes (edict_t *ent)
{
	if ((!ent->client) || (ent->health<=0))
		return;

	// toggle low on/off bit (and clear scores/inventory display if required)
        if ((ent->client->pers.classes_active ^= 1) & 1)
	{
		ent -> client -> showinventory	= 0;
		ent -> client -> showscores		= 0;
	}

	// set "just changed" bit
        ent->client->pers.classes_active |= 2;
}
void ShowClasses (edict_t *ent,char *layout)
{
        char    entry[1024];
        char    *temp,*scout,*sniper,*soldier,*demoman,*hwguy,*energyguy,*engineer,*commando;
        char    *berserk,*spy;
        scout = "Scout";
        sniper = "Assasin";
        soldier = "Soldier";
        demoman = "Demolition Man";
        hwguy = "Heavy Weapons Guy";
        energyguy = "Energy trooper";
        engineer = "Engineer";
        commando = "Commando";
        berserk = "Berserk";
        spy = "Spy";
   //             "xv 0 yv 0 cstring2 \"Select Your Class:\" "
if (ent->client->pers.selected == 0) ent->client->pers.selected = 1;
if (ent->client->pers.selected == 1) {
scout = "-> Scout <-";
}
if (ent->client->pers.selected == 2) {
sniper = "-> Assasin <-";
}
if (ent->client->pers.selected == 3) {
soldier = "-> Soldier <-";
}
if (ent->client->pers.selected == 4) {
demoman = "-> Demolition Man <-";
}
if (ent->client->pers.selected == 5) {
hwguy = "-> Heavy Weapons Guy <-";
}
if (ent->client->pers.selected == 6) {
energyguy = "-> Energy Trooper <-";
}
if (ent->client->pers.selected == 7) {
engineer = "-> Engineer <-";
}
if (ent->client->pers.selected == 8) {
commando = "-> Commando <-";
}
if (ent->client->pers.selected == 9) {
berserk = "-> Berserk <-";
}
if (ent->client->pers.selected == 10) {
spy = "-> Spy <-";

}
        Com_sprintf (entry, sizeof(entry),
                "xv 0 yv 16 cstring2 \"%20s\" "
                "xv 0 yv 24 cstring2 \"%20s\" " 
                "xv 0 yv 32 cstring2 \"%20s\" " 
                "xv 0 yv 40 cstring2 \"%20s\" " 
                "xv 0 yv 48 cstring2 \"%20s\" " 
                "xv 0 yv 56 cstring2 \"%20s\" "
                "xv 0 yv 64 cstring2 \"%20s\" " 
                "xv 0 yv 72 cstring2 \"%20s\" " 
                "xv 0 yv 80 cstring2 \"%20s\" "
                "xv 0 yv 88 cstring2 \"%20s\" "
                "xv 0 yv 96 cstring2 \"press your use button to spawn\" "
                ,scout,sniper,soldier,demoman,hwguy,energyguy,engineer,commando,berserk,spy);

//        gi.bprintf (PRINT_MEDIUM,"%s died.\n", ent->client->pers.netname);
SAFE_STRCAT(layout,entry,LAYOUT_MAX_LENGTH);

}


void ShowScanner(edict_t *ent,char *layout)
{
	int	i;

	edict_t	*player = g_edicts;

	char	stats[64],
			*tag;

	vec3_t	v;

	// Main scanner graphic draw
	Com_sprintf (stats, sizeof(stats),"xv 80 yv 40 picn %s ", PIC_SCANNER_TAG);
	SAFE_STRCAT(layout,stats,LAYOUT_MAX_LENGTH);

	// Players dots
	for (i=0 ; i < game.maxclients ; i++)
	{
		float	len;

		int		hd;

		// move to player edict
		player++;

		// in use 
                if (!player->inuse || !player->client || (player == ent) || (player -> health <= 0))
			continue;

                if (player->client->pers.class == 8) continue;

		// calc player to enemy vector
		VectorSubtract (ent->s.origin, player->s.origin, v);

		// save height differential
		hd = v[2] / SCANNER_UNIT;

		// remove height component
		v[2] = 0;

		// calc length of distance from top down view (no z)
		len = VectorLength (v) / SCANNER_UNIT;

		// in range ?
		if (len <= SCANNER_RANGE)
		{
			int		sx,
					sy;

			vec3_t	dp;

			vec3_t	normal = {0,0,-1};


			// normal vector to enemy
			VectorNormalize(v);

			// rotate round player view angle (yaw)
			RotatePointAroundVector( dp, normal, v, ent->s.angles[1]);

			// scale to fit scanner range (80 = pixel range of scanner)
			VectorScale(dp,len*80/SCANNER_RANGE,dp);

			// calc screen (x,y) (2 = half dot width)
			sx = (160 + dp[1]) - 2;
			sy = (120 + dp[0]) - 2;

			// setup dot graphic
			tag = PIC_DOT_TAG;

                        if (player->tw_team == 1)
				tag = PIC_QUADDOT_TAG;

			if (player->client->invincible_framenum > level.framenum)
				tag = PIC_INVDOT_TAG;

                        if (player->IS_KAMIKAZE == 1)
				tag = PIC_INVDOT_TAG;

			// Set output ...
			Com_sprintf (stats, sizeof(stats),"xv %i yv %i picn %s ",
					sx,
					sy,
					tag);

			SAFE_STRCAT(layout,stats,LAYOUT_MAX_LENGTH);

			// clear stats
			*stats = 0;

			// set up/down arrow
			if (hd < 0)
				Com_sprintf (stats, sizeof(stats),"yv %i picn %s ",
					sy - 5,PIC_UP_TAG);
			else if (hd > 0)
				Com_sprintf (stats, sizeof(stats),"yv %i picn %s ",
					sy + 5,PIC_DOWN_TAG);

			// any up/down ?
			if (*stats)
				SAFE_STRCAT(layout,stats,LAYOUT_MAX_LENGTH);
		}
	}
}
