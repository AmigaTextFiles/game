//TROND
#include "g_local.h"
#include "m_player.h"

void NoAmmoWeaponChange (edict_t *ent);
void P_ProjectSource (gclient_t *client, vec3_t point, vec3_t distance, vec3_t forward, vec3_t right, vec3_t result);
void Weapon_Generic (edict_t *ent, int FRAME_ACTIVATE_LAST, int FRAME_FIRE_LAST, int FRAME_IDLE_LAST, int FRAME_DEACTIVATE_LAST, /*TROND RELOAD*/int FRAME_RELOAD_LAST, int FRAME_ENDMAG_LAST,/*TROND slutt*/ int *pause_frames, int *fire_frames, void (*fire)(edict_t *ent));
void fire_msg90 (edict_t *self, vec3_t start, vec3_t aimdir, int damage, int kick);

//MP5
void MSG90_Fire (edict_t *ent)
{
	vec3_t		start;
	vec3_t		forward, right;
	vec3_t		offset;
	int			damage = 100;
	int			kick = 250;

	gi.sound (ent, CHAN_WEAPON, gi.soundindex ("slat/weapons/msg90_fire.wav"), 1, ATTN_STATIC, 0);//TROND linje

	ent->client->ps.gunframe++;

	ent->client->pers.inventory[ent->client->ammo_index]--;

	AngleVectors (ent->client->v_angle, forward, right, NULL);

	VectorScale (forward, -3, ent->client->kick_origin);
	ent->client->kick_angles[0] = -5;//TROND var -3;

	VectorSet(offset, 0, 7,  ent->viewheight-8);
	P_ProjectSource (ent->client, ent->s.origin, offset, forward, right, start);
	//TROND
	//RIFLE TREFFSIKKER
	if (ent->client->zoom > 0)
	{
		fire_msg90 (ent, start, forward, damage, kick);
	}
	else if (ent->velocity[0] || ent->velocity[1])
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2.5, DEFAULT_BULLET_VSPREAD*2.5, MOD_RAILGUN);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*2, DEFAULT_BULLET_VSPREAD*2, MOD_RAILGUN);
	}
	else if (ent->client->ps.pmove.pm_flags & PMF_DUCKED)
	{
		fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*0.5, DEFAULT_BULLET_VSPREAD*0.5, MOD_RAILGUN);
	}
	else
	{
		if (ent->client->bleeding)
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD*1.5, DEFAULT_BULLET_VSPREAD*1.5, MOD_RAILGUN);
		else
			fire_bullet (ent, start, forward, damage, kick, DEFAULT_BULLET_HSPREAD, DEFAULT_BULLET_VSPREAD, MOD_RAILGUN);
	}
	//TROND slutt
}

void Weapon_MSG90 (edict_t *ent)
{
	static int	pause_frames[]	= {11, 31, 48};
	static int	fire_frames[]	= {9};//TROND 12 lagt til pga animasjon

	if (ent->client->ps.gunframe == 3)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/msg90_reload1.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 52)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/msg90_reload2.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 57)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/msg90_reload3.wav"), 1, ATTN_NORM, 0);//TROND lyd
	if (ent->client->ps.gunframe == 62)
		gi.sound(ent, CHAN_WEAPON, gi.soundindex("slat/weapons/msg90_reload4.wav"), 1, ATTN_NORM, 0);//TROND lyd

	if (ent->client->weaponstate != WEAPON_READY
		&& ent->client->weaponstate != WEAPON_FIRING
		&& ent->client->zoom)
	{
		ent->client->ps.fov = 90;
		ent->client->zoom = 0;
		ent->client->ps.gunindex = gi.modelindex(ent->client->pers.weapon->view_model);
		ent->client->infrared = 0;
		ent->client->ps.rdflags &= ~RDF_IRGOGGLES;
	}

	Weapon_Generic (ent, 8, 13, 40, 44, 0, 0, pause_frames, fire_frames, MSG90_Fire);
}