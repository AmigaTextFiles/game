//TROND
#include "g_local.h"
#include "m_player.h"

void NoAmmoWeaponChange (edict_t *ent);
void P_ProjectSource (gclient_t *client, vec3_t point, vec3_t distance, vec3_t forward, vec3_t right, vec3_t result);
void Weapon_Generic (edict_t *ent, int FRAME_ACTIVATE_LAST, int FRAME_FIRE_LAST, int FRAME_IDLE_LAST, int FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/int FRAME_RELOAD_LAST, int FRAME_ENDMAG_LAST,/*TROND slutt*/ int *pause_frames, int *fire_frames, void (*fire)(edict_t *ent));

//MP5
void M60_Fire (edict_t *ent)
{
	int	i;
	vec3_t		start;
	vec3_t		forward, right;
	vec3_t		angles;
	int			kick = 250;
	vec3_t		offset;
	int			damage = 100;
	
	if (!(ent->client->buttons & BUTTON_ATTACK))
	{
		ent->client->ps.gunframe++;
		return;
	}

	//TROND
	//ANIMERE SKYTING
	if (ent->client->ps.gunframe == 10)
		ent->client->ps.gunframe = 9;
	else
		ent->client->ps.gunframe = 10;
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

		return;
	}
/*	if (random() > 0.8)
	{
		gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
		ent->client->pers.inventory[ent->client->ammo_index]--;
		return;
	}*/

	//TROND
	//SNODIG: detta måtte flyttast opp frå bunnen... ellers bug, gjelder RAILGUN og...????
	gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/m60_fire.wav"), 1, ATTN_NORM, 0);//TROND skytelyc

	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_SILENCED);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, ent->s.origin, PNOISE_WEAPON);

	ent->client->pers.inventory[ent->client->ammo_index]--;
  
	for (i=1 ; i<3 ; i++)
	{
		ent->client->kick_origin[i] = crandom() * 3.35;
		ent->client->kick_angles[i] = crandom() * 2.5;
	}

	// get start / end positions
	VectorAdd (ent->client->v_angle, ent->client->kick_angles, angles);
	AngleVectors (angles, forward, right, NULL);
	VectorSet(offset, 0, 8, ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	if (ent->velocity[0] || ent->velocity[1])
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*4, DEFAULT_BULLET_VSPREAD*4, MOD_MACHINEGUN);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*3, DEFAULT_BULLET_VSPREAD*3, MOD_MACHINEGUN);
	}
	else if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
		fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.6, DEFAULT_BULLET_VSPREAD*1.6, MOD_MACHINEGUN);
	else
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2.5, DEFAULT_BULLET_VSPREAD*2.5, MOD_MACHINEGUN);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2.2, DEFAULT_BULLET_VSPREAD*2.2, MOD_MACHINEGUN);
	}

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

void Weapon_M60 (edict_t *ent)
{
	static int	pause_frames[]	= {11, 31, 48};
	static int	fire_frames[]	= {9, 10};//TROND 12 lagt til pga animasjon

	if (ent->client->ps.gunframe == 45)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/m60_reload1.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 55)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/m60_reload2.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 61)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/m60_reload3.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 68)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/m60_reload4.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 73)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/m60_reload5.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 79)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/m60_reload6.wav"), 1, ATTN_NORM, 0);//TROND lyd

	Weapon_Generic (ent, 8, 13, 32, 41, 0, 0, pause_frames, fire_frames, M60_Fire);
}