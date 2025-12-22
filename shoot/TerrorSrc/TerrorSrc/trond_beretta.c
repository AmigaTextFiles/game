//TROND
#include "g_local.h"
#include "m_player.h"

void NoAmmoWeaponChange (edict_t *ent);
void P_ProjectSource (gclient_t *client, vec3_t point, vec3_t distance, vec3_t forward, vec3_t right, vec3_t result);
void Weapon_Generic (edict_t *ent, int FRAME_ACTIVATE_LAST, int FRAME_FIRE_LAST, int FRAME_IDLE_LAST, int FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/int FRAME_RELOAD_LAST, int FRAME_ENDMAG_LAST,/*TROND slutt*/ int *pause_frames, int *fire_frames, void (*fire)(edict_t *ent));

//CASULL
void Weapon_Beretta_Fire (edict_t *ent)
{
	vec3_t		start;
	vec3_t		forward, right;
	int			damage = 40;
	int			kick = 175;
	vec3_t		offset;

	ent->client->ps.gunframe++;


	if (ent->client->pers.inventory[ent->client->ammo_index] < 1)
	{
		gi.sound(ent, CHAN_VOICE, gi.soundindex("weapons/noammo.wav"), 1, ATTN_NORM, 0);
		ent->pain_debounce_time = level.time + 1;
	}
	
	gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/beretta_fire.wav"), 1, ATTN_NORM, 0);

	gi.WriteByte (svc_muzzleflash);
	gi.WriteShort (ent-g_edicts);
	gi.WriteByte (MZ_SILENCED);
	gi.multicast (ent->s.origin, MULTICAST_PVS);

	PlayerNoise(ent, ent->s.origin, PNOISE_WEAPON);

	ent->client->pers.inventory[ent->client->ammo_index]--;

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -2, ent->client->kick_origin);
	ent->client->kick_angles[0] = -3;

	VectorSet(offset, 0, 0,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);

	if (ent->velocity[0] || ent->velocity[1])
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_GLOCK);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.5, DEFAULT_BULLET_VSPREAD*1.5, MOD_GLOCK);
	}
	else if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
		fire_bullet (ent, start, forward, damage, kick, 80, 80, MOD_GLOCK);
	else
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, MOD_GLOCK);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*0.5, DEFAULT_BULLET_VSPREAD*0.5, MOD_GLOCK);
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
}

void Weapon_Beretta (edict_t *ent)
{
	static int	pause_frames[]	= {12, 30, 38};
	static int	fire_frames[]	= {10};

	if (ent->client->ps.gunframe == 2)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/beretta_reload2.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 45)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/beretta_reload1.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 58)
		gi.sound(ent, CHAN_AUTO, gi.soundindex("slat/weapons/beretta_reload3.wav"), 1, ATTN_NORM, 0);//TROND lyd

	Weapon_Generic (ent, 9, 11, 38, 40, 40, 60, pause_frames, fire_frames, Weapon_Beretta_Fire);
}