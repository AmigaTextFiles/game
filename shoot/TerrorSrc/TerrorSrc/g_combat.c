// g_combat.c

#include "g_local.h"

void NPC_Painskin (edict_t *ent);//TROND NPC painskin

/*
============
CanDamage

Returns true if the inflictor can directly damage the target.  Used for
explosions and melee attacks.
============
*/
qboolean CanDamage (edict_t *targ, edict_t *inflictor)
{
	vec3_t	dest;
	trace_t	trace;

// bmodels need special checking because their origin is 0,0,0
	if (targ->movetype == MOVETYPE_PUSH)
	{
		VectorAdd (targ->absmin, targ->absmax, dest);
		VectorScale (dest, 0.5, dest);
		trace = gi.trace (inflictor->s.origin, vec3_origin, vec3_origin, dest, inflictor, MASK_SOLID);
		if (trace.fraction == 1.0)
			return true;
		if (trace.ent == targ)
			return true;
		return false;
	}

	trace = gi.trace (inflictor->s.origin, vec3_origin, vec3_origin, targ->s.origin, inflictor, MASK_SOLID);
	if (trace.fraction == 1.0)
		return true;

	VectorCopy (targ->s.origin, dest);
	dest[0] += 15.0;
	dest[1] += 15.0;
	trace = gi.trace (inflictor->s.origin, vec3_origin, vec3_origin, dest, inflictor, MASK_SOLID);
	if (trace.fraction == 1.0)
		return true;

	VectorCopy (targ->s.origin, dest);
	dest[0] += 15.0;
	dest[1] -= 15.0;
	trace = gi.trace (inflictor->s.origin, vec3_origin, vec3_origin, dest, inflictor, MASK_SOLID);
	if (trace.fraction == 1.0)
		return true;

	VectorCopy (targ->s.origin, dest);
	dest[0] -= 15.0;
	dest[1] += 15.0;
	trace = gi.trace (inflictor->s.origin, vec3_origin, vec3_origin, dest, inflictor, MASK_SOLID);
	if (trace.fraction == 1.0)
		return true;

	VectorCopy (targ->s.origin, dest);
	dest[0] -= 15.0;
	dest[1] -= 15.0;
	trace = gi.trace (inflictor->s.origin, vec3_origin, vec3_origin, dest, inflictor, MASK_SOLID);
	if (trace.fraction == 1.0)
		return true;


	return false;
}


/*
============
Killed
============
*/
void Killed (edict_t *targ, edict_t *inflictor, edict_t *attacker, int damage, vec3_t point)
{
	if (targ->health < -999)
		targ->health = -999;

	//TROND forsøk på bug fix
	if (attacker->client
		&& targ->client
		&& targ != attacker)
		targ->enemy = attacker;
	//TROND slutt

	if ((targ->svflags & SVF_MONSTER) && (targ->deadflag != DEAD_DEAD))
	{
//		targ->svflags |= SVF_DEADMONSTER;	// now treat as a different content type
		if (!(targ->monsterinfo.aiflags & AI_GOOD_GUY))
		{
			level.killed_monsters++;
			if (coop->value && attacker->client)
				attacker->client->resp.score++;
			// medics won't heal monsters that they kill themselves
			if (strcmp(attacker->classname, "monster_medic") == 0)
				targ->owner = attacker;
		}
	}

	if (targ->movetype == MOVETYPE_PUSH || targ->movetype == MOVETYPE_STOP || targ->movetype == MOVETYPE_NONE)
	{	// doors, triggers, etc
		targ->die (targ, inflictor, attacker, damage, point);
		return;
	}

	if ((targ->svflags & SVF_MONSTER) && (targ->deadflag != DEAD_DEAD))
	{
		targ->touch = NULL;
		monster_death_use (targ);
	}

	targ->die (targ, inflictor, attacker, damage, point);
}


/*
================
SpawnDamage
================
*/
void SpawnDamage (int type, vec3_t origin, vec3_t normal, int damage)
{
	if (damage > 255)
		damage = 255;
	gi.WriteByte (svc_temp_entity);
	gi.WriteByte (type);
//	gi.WriteByte (damage);
	gi.WritePosition (origin);
	gi.WriteDir (normal);
	gi.multicast (origin, MULTICAST_PVS);
}

/*
============
T_Damage

targ		entity that is being damaged
inflictor	entity that is causing the damage
attacker	entity that caused the inflictor to damage targ
	example: targ=monster, inflictor=rocket, attacker=player

dir			direction of the attack
point		point at which the damage is being inflicted
normal		normal vector from that point
damage		amount of damage being inflicted
knockback	force to be applied against targ as a result of the damage

dflags		these flags are used to control how T_Damage works
	DAMAGE_RADIUS			damage was indirect (from a nearby explosion)
	DAMAGE_NO_ARMOR			armor does not protect from this damage
	DAMAGE_ENERGY			damage is from an energy based weapon
	DAMAGE_NO_KNOCKBACK		do not affect velocity, just view angles
	DAMAGE_BULLET			damage is from a bullet (used for ricochets)
	DAMAGE_NO_PROTECTION	kills godmode, armor, everything
============
*/
static int CheckPowerArmor (edict_t *ent, vec3_t point, vec3_t normal, int damage, int dflags)
{
	gclient_t	*client;
	int			save;
	int			power_armor_type;
	int			index;
	int			damagePerCell;
	int			pa_te_type;
	int			power;
	int			power_used;

	if (!damage)
		return 0;

	client = ent->client;

	if (dflags & DAMAGE_NO_ARMOR)
		return 0;

	if (client)
	{
		power_armor_type = PowerArmorType (ent);
		if (power_armor_type != POWER_ARMOR_NONE)
		{
			index = ITEM_INDEX(FindItem("1911clip"));
			power = client->pers.inventory[index];
		}
	}
	else if (ent->svflags & SVF_MONSTER)
	{
		power_armor_type = ent->monsterinfo.power_armor_type;
		power = ent->monsterinfo.power_armor_power;
	}
	else
		return 0;

	if (power_armor_type == POWER_ARMOR_NONE)
		return 0;
	if (!power)
		return 0;

	if (power_armor_type == POWER_ARMOR_SCREEN)
	{
		vec3_t		vec;
		float		dot;
		vec3_t		forward;

		// only works if damage point is in front
		AngleVectors (ent->s.angles, forward, NULL, NULL);
		VectorSubtract (point, ent->s.origin, vec);
		VectorNormalize (vec);
		dot = DotProduct (vec, forward);
		if (dot <= 0.3)
			return 0;

		damagePerCell = 1;
		pa_te_type = TE_SCREEN_SPARKS;
		damage = damage / 3;
	}
	else
	{
		damagePerCell = 2;
		pa_te_type = TE_SHIELD_SPARKS;
		damage = (2 * damage) / 3;
	}

	save = power * damagePerCell;
	if (!save)
		return 0;
	if (save > damage)
		save = damage;

	SpawnDamage (pa_te_type, point, normal, save);
	ent->powerarmor_time = level.time + 0.2;

	power_used = save / damagePerCell;

	if (client)
		client->pers.inventory[index] -= power_used;
	else
		ent->monsterinfo.power_armor_power -= power_used;
	return save;
}

static int CheckArmor (edict_t *ent, vec3_t point, vec3_t normal, int damage, int te_sparks, int dflags)
{
	gclient_t	*client;
	int			save;
	int			index;
	gitem_t		*armor;

	if (!damage)
		return 0;

	client = ent->client;

	if (!client)
		return 0;

	if (dflags & DAMAGE_NO_ARMOR)
		return 0;

	index = ArmorIndex (ent);
	if (!index)
		return 0;

	armor = GetItemByIndex (index);

	if (dflags & DAMAGE_ENERGY)
		save = ceil(((gitem_armor_t *)armor->info)->energy_protection*damage);
	else
		save = ceil(((gitem_armor_t *)armor->info)->normal_protection*damage);
	if (save >= client->pers.inventory[index])
		save = client->pers.inventory[index];

	if (!save)
		return 0;

	client->pers.inventory[index] -= save;
	SpawnDamage (te_sparks, point, normal, save);

	return save;
}

void M_ReactToDamage (edict_t *targ, edict_t *attacker)
{
	if (!(attacker->client) && !(attacker->svflags & SVF_MONSTER))
		return;

	if (attacker == targ || attacker == targ->enemy)
		return;

	// if we are a good guy monster and our attacker is a player
	// or another good guy, do not get mad at them
	if (targ->monsterinfo.aiflags & AI_GOOD_GUY)
	{
		if (attacker->client || (attacker->monsterinfo.aiflags & AI_GOOD_GUY))
			return;
	}

	// we now know that we are not both good guys

	// if attacker is a client, get mad at them because he's good and we're not
	if (attacker->client)
	{
		targ->monsterinfo.aiflags &= ~AI_SOUND_TARGET;

		// this can only happen in coop (both new and old enemies are clients)
		// only switch if can't see the current enemy
		if (targ->enemy && targ->enemy->client)
		{
			if (visible(targ, targ->enemy))
			{
				targ->oldenemy = attacker;
				return;
			}
			targ->oldenemy = targ->enemy;
		}
		targ->enemy = attacker;
		if (!(targ->monsterinfo.aiflags & AI_DUCKED))
			FoundTarget (targ);
		return;
	}

	// it's the same base (walk/swim/fly) type and a different classname and it's not a tank
	// (they spray too much), get mad at them
	if (((targ->flags & (FL_FLY|FL_SWIM)) == (attacker->flags & (FL_FLY|FL_SWIM))) &&
		 (strcmp (targ->classname, attacker->classname) != 0) &&
		 (strcmp(attacker->classname, "monster_tank") != 0) &&
		 (strcmp(attacker->classname, "monster_supertank") != 0) &&
		 (strcmp(attacker->classname, "monster_makron") != 0) &&
		 (strcmp(attacker->classname, "monster_jorg") != 0) )
	{
		if (targ->enemy && targ->enemy->client)
			targ->oldenemy = targ->enemy;
		targ->enemy = attacker;
		if (!(targ->monsterinfo.aiflags & AI_DUCKED))
			FoundTarget (targ);
	}
	// if they *meant* to shoot us, then shoot back
	else if (attacker->enemy == targ)
	{
		if (targ->enemy && targ->enemy->client)
			targ->oldenemy = targ->enemy;
		targ->enemy = attacker;
		if (!(targ->monsterinfo.aiflags & AI_DUCKED))
			FoundTarget (targ);
	}
	// otherwise get mad at whoever they are mad at (help our buddy) unless it is us!
	else if (attacker->enemy && attacker->enemy != targ)
	{
		if (targ->enemy && targ->enemy->client)
			targ->oldenemy = targ->enemy;
		targ->enemy = attacker->enemy;
		if (!(targ->monsterinfo.aiflags & AI_DUCKED))
			FoundTarget (targ);
	}
}

qboolean CheckTeamDamage (edict_t *targ, edict_t *attacker)
{
//ZOID
	if (ctf->value && targ->client && attacker->client)
		if (targ->client->resp.ctf_team == attacker->client->resp.ctf_team && targ != attacker)
				return true;
//ZOID

		//FIXME make the next line real and uncomment this block
		// if ((ability to damage a teammate == OFF) && (targ's team == attacker's team))
	return false;
}
//TROND locational damage 2
#define LEG_DAMAGE (height/2) - abs(targ->mins[2]) - 3
#define STOMACH_DAMAGE (height/1.6) - abs(targ->mins[2])
#define CHEST_DAMAGE (height/1.34) - abs(targ->mins[2])
//TROND slutt

void T_Damage (edict_t *targ, edict_t *inflictor, edict_t *attacker, vec3_t dir, vec3_t point, vec3_t normal, int damage, int knockback, int dflags, int mod)
{
	//TROND locational damage 2
	float		z_rel;
	int			height;
	int			playernum = targ-g_edicts-1;
	//TROND slutt

	gclient_t	*client;
	int			take;
	int			save;
	int			asave;
	int			psave;
	int			te_sparks;

//	gi.bprintf (PRINT_HIGH, "DEBUG: starting damage function\n");

	if (!targ->takedamage)
		return;

	//TROND locational damage 2

	height = abs(targ->mins[2]) + targ->maxs[2];

	//TROND gir tar ein fiende
	if (attacker->client
		&& targ->client
		&& targ != attacker)
		targ->enemy = attacker;
	//TROND slutt

	if (targ->client)
	{
		if ((mod == MOD_BLASTER) ||
			(mod == MOD_MACHINEGUN) ||
			(mod == MOD_CHAINGUN) ||
			(mod == MOD_HYPERBLASTER) ||
			(mod == MOD_RAILGUN) ||
			(mod == MOD_AK47) ||
			(mod == MOD_GLOCK))
		{
			z_rel = point[2] - targ->s.origin[2];
			if (z_rel < LEG_DAMAGE)
			{
				//Leg damage
				damage *= 0.25;
//				gi.cprintf (targ, PRINT_HIGH, "Somebody wants to prevent you from escaping\n");
//				gi.cprintf (attacker, PRINT_HIGH, "%s got a bad limp\n", targ->client->pers.netname);
				targ->client->limp = 1;
				targ->client->bleeding = 1;
				targ->client->pain_leg = 1;
				targ->client->die_frame = 1;
				painskin (targ);
				SpawnDamage (TE_BLOOD, point, normal, damage);
			}
			else if (z_rel < STOMACH_DAMAGE)
			{
				if (targ->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))] == 0)
				{
					//Stomach damage
					damage *= 0.75;
//					gi.cprintf (targ, PRINT_HIGH, "Your guts are pouring out\n");
//					gi.cprintf (attacker, PRINT_HIGH, "%s lost some guts\n", targ->client->pers.netname);
					targ->client->bleeding = 1;
					targ->client->pain_stomach = 1;
					targ->client->die_frame = 2;
					painskin (targ);
					SpawnDamage (TE_BLOOD, point, normal, damage);
				}
				else
				{
					if (attacker->classname == "police"
						|| (attacker->client
						&& attacker->client->pers.weapon != FindItem("BARRETT")))
					{
//						gi.cprintf (attacker, PRINT_HIGH, "%s has a bullet proof vest\n", targ->client->pers.netname);
//						gi.cprintf (targ, PRINT_HIGH, "Thank the vest for your life\n");
						damage *= 0.4;
						
						gi.WriteByte(svc_temp_entity);
						gi.WriteByte(TE_BULLET_SPARKS);
						gi.WritePosition(point);
						gi.WriteDir(normal);
						gi.multicast(point, MULTICAST_PVS);
						gi.sound (targ, CHAN_AUTO, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
					}
					else
					{
						damage *= 0.75;
//						gi.cprintf (targ, PRINT_HIGH, "50cal bullet penetrated your poor vest\n");
//						gi.cprintf (attacker, PRINT_HIGH, "%s lost some guts, thanks to your 50cal round\n", targ->client->pers.netname);
						targ->client->bleeding = 1;
						targ->client->pain_stomach = 1;
						targ->client->die_frame = 2;
						painskin (targ);
						SpawnDamage(TE_BLOOD, point, normal, damage);
					}
				}
			}
			else if (z_rel < CHEST_DAMAGE)
			{
				//Chest damage
				if (targ->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))] == 0)
				{
					damage *= 1.1;
//					gi.cprintf (targ, PRINT_HIGH, "Feels like a lung blew up\n");
//					gi.cprintf (attacker, PRINT_HIGH, "%s`s ventilated...\n", targ->client->pers.netname);
					targ->client->bleeding = 1;
					targ->client->pain_chest = 1;
					targ->client->die_frame = 2;
					painskin (targ);
					SpawnDamage (TE_BLOOD, point, normal, damage);
				}
				else
				{
					if (attacker->classname == "police"
						|| (attacker->client
						&& attacker->client->pers.weapon != FindItem("BARRETT")))
					{
//						gi.cprintf (attacker, PRINT_HIGH, "%s has a bullet proof vest\n", targ->client->pers.netname);
//						gi.cprintf (targ, PRINT_HIGH, "Thank the vest for your life\n");
						damage *= 0.4;
						
						gi.WriteByte(svc_temp_entity);
						gi.WriteByte(TE_BULLET_SPARKS);
						gi.WritePosition(point);
						gi.WriteDir(normal);
						gi.multicast(point, MULTICAST_PVS);
						gi.sound (targ, CHAN_AUTO, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
					}
					else
					{
						damage *= 1.1;
//						gi.cprintf (targ, PRINT_HIGH, "Feels like a lung blew up, the vest didn`t help much against 50cal rounds\n");
//						gi.cprintf (attacker, PRINT_HIGH, "%s`s ventilated... Thank your 50cal round!\n", targ->client->pers.netname);
						targ->client->bleeding = 1;
						targ->client->pain_chest = 1;
						targ->client->die_frame = 2;
						painskin (targ);
						SpawnDamage (TE_BLOOD, point, normal, damage);
					}
				}
			}
			else
			{
				//Head damage
				if (targ->client->pers.inventory[ITEM_INDEX(FindItem("Helmet"))] == 0)
				{
					gi.sound(targ, CHAN_AUTO, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
					damage *= 2;
//					gi.cprintf (targ, PRINT_HIGH, "Someone blew your brains out\n");
//					gi.cprintf (attacker, PRINT_HIGH, "You blew %s`s brains out!\n", targ->client->pers.netname);
					targ->client->bleeding = 1;
					targ->client->pain_head = 1;
					targ->client->die_frame = 3;
					painskin (targ);
					SpawnDamage (TE_MOREBLOOD, point, normal, damage);
				}
				else
				{
					if (attacker->classname == "police"
						|| (attacker->client
						&& attacker->client->pers.weapon != FindItem("BARRETT")))
					{
//						gi.cprintf (targ, PRINT_HIGH, "Thank the helmet for your life\n");
//						gi.cprintf (attacker, PRINT_HIGH, "%s has a helmet\n", targ->client->pers.netname);
						damage *= 0.3;

						gi.WriteByte(svc_temp_entity);
						gi.WriteByte(TE_BULLET_SPARKS);
						gi.WritePosition(point);
						gi.WriteDir(normal);
						gi.multicast(point, MULTICAST_PVS);
						gi.sound (targ, CHAN_AUTO, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
					}
					else
					{
						gi.sound(targ, CHAN_AUTO, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
						damage *= 2;
//						gi.cprintf (targ, PRINT_HIGH, "50cal rounds are dangerous\n");
//						gi.cprintf (attacker, PRINT_HIGH, "You blew %s`s brains out, the 50cal did it`s job!\n", targ->client->pers.netname);
						targ->client->bleeding = 1;
						targ->client->pain_head = 1;
						targ->client->die_frame = 3;
						painskin (targ);
						SpawnDamage (TE_MOREBLOOD, point, normal, damage);
					}
				}
			}
		}
		else if ((mod == MOD_SHOTGUN)
			&& targ->client)
		{
			z_rel = point[2] - targ->s.origin[2];
			if (z_rel < LEG_DAMAGE)
			{
				damage *= 0.1;
				targ->client->pain_leg = 1;
				SpawnDamage (TE_BLOOD, point, normal, damage);
			}
			else if (z_rel < STOMACH_DAMAGE)
			{
				if (targ->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))] == 0)
				{
					targ->client->pain_stomach = 1;
					damage *= 0.75;
					SpawnDamage (TE_BLOOD, point, normal, damage);
				}
				else
				{
					damage *= 0.5;

					gi.WriteByte(svc_temp_entity);
					gi.WriteByte(TE_BULLET_SPARKS);
					gi.WritePosition(point);
					gi.WriteDir(normal);
					gi.multicast(point, MULTICAST_PVS);
					gi.sound (targ, CHAN_BODY, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
				}
			}
			else if (z_rel < CHEST_DAMAGE)
			{
				if (targ->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))] == 0)
				{
					targ->client->pain_chest = 1;
					damage *= 1.1;
					SpawnDamage (TE_BLOOD, point, normal, damage);
				}
				else
				{
					damage *= 0.5;

					gi.WriteByte(svc_temp_entity);
					gi.WriteByte(TE_BULLET_SPARKS);
					gi.WritePosition(point);
					gi.WriteDir(normal);
					gi.multicast(point, MULTICAST_PVS);
					gi.sound (targ, CHAN_BODY, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
				}
			}
			else
			{
				if (targ->client->pers.inventory[ITEM_INDEX(FindItem("helmet"))] == 0)
				{
					gi.sound (targ, CHAN_BODY, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
					targ->client->pain_head = 1;
					damage *= 2;
					targ->client->bleeding = 1;
					SpawnDamage (TE_BLOOD, point, normal, damage);
				}
				else
				{
					damage *= 0.5;

					gi.WriteByte(svc_temp_entity);
					gi.WriteByte(TE_BULLET_SPARKS);
					gi.WritePosition(point);
					gi.WriteDir(normal);
					gi.multicast(point, MULTICAST_PVS);
					gi.sound (targ, CHAN_BODY, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
				}
			}
/*			if (targ->classname != "bot") 
			{
				if (targ->client->pers.inventory[ITEM_INDEX(FindItem("Bullet Proof Vest"))] == 0)
				{
					targ->client->pain_stomach = 1;
					targ->client->pain_chest = 1;
					painskin (targ);
				}
				else
					damage *= 0.6;
				targ->client->die_frame = 2;
				targ->client->bleeding = 1;
			}*/
			targ->client->die_frame = 2;
			painskin (targ);
		}
		if (mod == MOD_BUSH_HEAD)
		{
			targ->client->pain_head = 1;
			gi.sound(targ, CHAN_BODY, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
			targ->client->die_frame = 4;
			painskin (targ);
			SpawnDamage (TE_BLOOD, point, normal, damage);
		}
		if (mod == MOD_BUSH_CHEST)
		{
			targ->client->pain_stomach = 1;
			targ->client->pain_chest = 1;
			gi.sound(targ, CHAN_BODY, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
			targ->client->die_frame = 5;
			painskin (targ);
			SpawnDamage (TE_BLOOD, point, normal, damage);
		}
		if (mod == MOD_BUSH_LEG)
		{
			targ->client->pain_leg = 1;
			gi.sound(targ, CHAN_BODY, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
			targ->client->die_frame = 6;
			painskin (targ);
			SpawnDamage (TE_BLOOD, point, normal, damage);
		}
		if ((mod == MOD_HANDGRENADE
			|| mod == MOD_G_SPLASH
			|| mod == MOD_HG_SPLASH)
			&& (targ->client->ps.pmove.pm_flags & PMF_DUCKED
			|| targ->client->pers.inventory[ITEM_INDEX(FindItem("bullet proof vest"))])
			&& inflictor->classname != "mine")
		{
			damage *= 0.5;
		}
	}
/*	else if (!targ->client
		&& targ->classname == "bot"
		&& attacker->client)
	{
		gi.cprintf (attacker, PRINT_HIGH, "You hit a civilian\n");
		if (targ->s.skinnum == 0)
			targ->s.skinnum = 8;
	}*/
	else if (!targ->client
	&& targ->classname == "police")
	{
		if ((mod == MOD_BLASTER) ||
			(mod == MOD_MACHINEGUN) ||
			(mod == MOD_CHAINGUN) ||
			(mod == MOD_HYPERBLASTER) ||
			(mod == MOD_RAILGUN) ||
			(mod == MOD_AK47) ||
			(mod == MOD_GLOCK))
		{
			z_rel = point[2] - targ->s.origin[2];
			if (z_rel < LEG_DAMAGE)
			{
				damage *= 0.1;
//				gi.cprintf (attacker, PRINT_HIGH, "leg\n");
				targ->skinnum_leg = 1;
				targ->skinnum_frame = 1;
				SpawnDamage (TE_BLOOD, point, normal, damage);
			}
			else if (z_rel < STOMACH_DAMAGE)
			{
				if (targ->s.modelindex3)
				{
					damage *= 0.3;
//					gi.cprintf (attacker, PRINT_HIGH, "stomach\n");
					targ->skinnum_frame = 2;
					gi.sound(targ, CHAN_AUTO, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
					SpawnDamage (TE_SPARKS, point, normal, damage);
				}
				else
				{
					damage *= 0.75;
//					gi.cprintf (attacker, PRINT_HIGH, "stomach\n");
					targ->skinnum_stomach = 1;
					targ->skinnum_frame = 2;
					SpawnDamage (TE_BLOOD, point, normal, damage);
				}
			}
			else if (z_rel < CHEST_DAMAGE)
			{
				if (targ->s.modelindex3)
				{
					damage *= 0.3;
//					gi.cprintf (attacker, PRINT_HIGH, "stomach\n");
					targ->skinnum_frame = 2;
					gi.sound(targ, CHAN_AUTO, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
					SpawnDamage (TE_SPARKS, point, normal, damage);
				}
				else
				{
					damage *= 1.1;
//					gi.cprintf (attacker, PRINT_HIGH, "stomach\n");
					targ->skinnum_chest = 1;
					targ->skinnum_frame = 2;
					SpawnDamage (TE_BLOOD, point, normal, damage);
				}
			}
			else
			{
				if (targ->s.modelindex4)
				{
					damage *= 0.6;
					targ->skinnum_frame = 3;
					gi.sound(targ, CHAN_AUTO, gi.soundindex("slat/body/vesthit.wav"), 1, ATTN_NORM, 0);
					SpawnDamage (TE_SPARKS, point, normal, damage);
				}
				else
				{
					damage *= 2;
					targ->skinnum_head = 1;
					targ->skinnum_frame = 3;
					gi.sound(targ, CHAN_AUTO, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
					SpawnDamage (TE_MOREBLOOD, point, normal, damage);
				}
			}
		}
		if (attacker->client)
			targ->enemy = attacker;
		if (mod == MOD_SHOTGUN)
		{
			targ->skinnum_chest = 1;
			targ->skinnum_stomach = 1;
			SpawnDamage (TE_BLOOD, point, normal, damage);
		}
		if (mod == MOD_BUSH_HEAD)
		{
			targ->skinnum_head = 1;
			targ->skinnum_frame = 4;
			gi.sound(targ, CHAN_BODY, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
		}
		if (mod == MOD_BUSH_CHEST)
		{
			targ->skinnum_chest = 1;
			targ->skinnum_stomach = 1;
			targ->skinnum_frame = 5;
			gi.sound(targ, CHAN_BODY, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
		}
		if (mod == MOD_BUSH_LEG)
		{
			targ->skinnum_leg = 1;
			targ->skinnum_frame = 6;
			gi.sound(targ, CHAN_BODY, gi.soundindex("slat/body/headshot.wav"), 1, ATTN_NORM, 0);
		}
		bot_pain (targ);
	}

	if (attacker->client
		&& (targ->client || targ->classname == "bot")
		&& selflove->value)
	{
		if (damage/5 <= 1)
			attacker->client->resp.score += 1;
		else
			attacker->client->resp.score += damage/5;
	}

	// END Locational damage
	//TROND slutt

	// friendly fire avoidance
	// if enabled you can't hurt teammates (but you can hurt yourself)
	// knockback still occurs
	if ((targ != attacker) && ((deathmatch->value && ((int)(dmflags->value) & (DF_MODELTEAMS | DF_SKINTEAMS))) || coop->value))
	{
		if (OnSameTeam (targ, attacker))
		{
			if ((int)(dmflags->value) & DF_NO_FRIENDLY_FIRE)
				damage = 0;
			else
				mod |= MOD_FRIENDLY_FIRE;
		}
	}
	meansOfDeath = mod;

	// easy mode takes half damage
	//TROND tatt vekk
/*	if (skill->value == 0 && deathmatch->value == 0 && targ->client)
	{
		damage *= 0.5;
		if (!damage)
			damage = 1;
	}*/

	client = targ->client;

	if (dflags & DAMAGE_BULLET)
		te_sparks = TE_BULLET_SPARKS;
	//TROND
	else if (targ->classname == "bot")
		te_sparks = TE_BLOOD;
	//TROND slutt
	else
		te_sparks = TE_SPARKS;

	VectorNormalize(dir);

// bonus damage for suprising a monster
	if (!(dflags & DAMAGE_RADIUS) && (targ->svflags & SVF_MONSTER) && (attacker->client) && (!targ->enemy) && (targ->health > 0))
		damage *= 2;

//ZOID
//strength tech
	damage = CTFApplyStrength(attacker, damage);
//ZOID

	if (targ->flags & FL_NO_KNOCKBACK)
		knockback = 0;

// figure momentum add
	if (!(dflags & DAMAGE_NO_KNOCKBACK))
	{
		if ((knockback) && (targ->movetype != MOVETYPE_NONE) && (targ->movetype != MOVETYPE_BOUNCE) && (targ->movetype != MOVETYPE_PUSH) && (targ->movetype != MOVETYPE_STOP))
		{
			vec3_t	kvel;
			float	mass;

			if (targ->mass < 50)
				mass = 50;
			else
				mass = targ->mass;

			if (targ->client  && attacker == targ)
				VectorScale (dir, 1600.0 * (float)knockback / mass, kvel);	// the rocket jump hack...
			else
				VectorScale (dir, 500.0 * (float)knockback / mass, kvel);

			VectorAdd (targ->velocity, kvel, targ->velocity);
		}
	}
	//TROND god mode 9/4
	if (targ->flags & FL_GODMODE
		&& targ->client)
	{
		targ->client->bleeding = 0;
		damage = 0;
	}

	//TROND team damage 11/4
	if (targ->client
		&& attacker->client
		&& targ->client->resp.ctf_team == attacker->client->resp.ctf_team
		&& !teamdmg->value
		&& ctf->value
		&& targ != attacker)
	{
		targ->client->bleeding = 0;
		damage = 0;
	}
/*	if (targ->client
		&& !teamdmg->value
		&& ctf->value)
	{
		targ->client->bleeding = 0;
		damage = 0;
	}*/
	//TROND slutt

	take = damage;
	save = 0;

	//TROND tatt vekk, KAN vere crash bug
/*	// check for godmode
	if ( (targ->flags & FL_GODMODE) && !(dflags & DAMAGE_NO_PROTECTION) )
	{
		take = 0;
		save = damage;
		SpawnDamage (TE_BLOOD, point, normal, save);//TROND var "te_sparks"
	}*/
	//TROND slutt

	//TROND tatt vekk, KAN vere crash bug
/*
	// check for invincibility
	if ((client && client->invincible_framenum > level.framenum ) && !(dflags & DAMAGE_NO_PROTECTION))
	{
		if (targ->pain_debounce_time < level.time)
		{
			gi.sound(targ, CHAN_ITEM, gi.soundindex("items/protect4.wav"), 1, ATTN_NORM, 0);
			targ->pain_debounce_time = level.time + 2;
		}
		take = 0;
		save = damage;
	}
*/
	//TROND slutt
//ZOID
//team armor protect
	if (ctf->value && targ->client && attacker->client &&
		targ->client->resp.ctf_team == attacker->client->resp.ctf_team &&
		targ != attacker && ((int)dmflags->value & DF_ARMOR_PROTECT)) {
		psave = asave = 0;
	} 
	else 
	{
//ZOID
		psave = CheckPowerArmor (targ, point, normal, take, dflags);
		take -= psave;

		asave = CheckArmor (targ, point, normal, take, te_sparks, dflags);
		take -= asave;

	}

	//treat cheat/powerup savings the same as armor
	asave += save;

//ZOID
//resistance tech
	take = CTFApplyResistance(targ, take);
//ZOID

	//TROND team damage er lov
/*	// team damage avoidance
	if (!(dflags & DAMAGE_NO_PROTECTION) && CheckTeamDamage (targ, attacker))
	{
		//TROND
		//return;//tatt vekk
		if (mod == MOD_SHOTGUN)
			attacker->client->resp.score -= 1;
		else
			attacker->client->resp.score -= 5;
		gi.cprintf (targ, PRINT_HIGH, "A TEAMMATE is trying to KILL you!!!!!\n");
		gi.cprintf (attacker, PRINT_HIGH, "STOP firing at your teammates!\n");
		gi.bprintf (PRINT_HIGH, "ATTENTION!!! %s is a traitor, he has fired upon a teammate\n", attacker->client->pers.netname);
	}
	//TROND slutt*/

//ZOID
	CTFCheckHurtCarrier(targ, attacker);
//ZOID

// do the damage
	if (take)
	{
//TROND mekk 12/3
		//TROND tatt vekk 3/4
		
/*		if (/*(targ->svflags & SVF_MONSTER) || (client) || *//*(targ->classname == "police"))//TROND lagt til "|| (targ->classname == "bot")"
//TROND slutt
/*		{
			SpawnDamage (TE_BLOOD, point, normal, take);
		}*/
		if (targ->classname != "police")
		{
			if (!targ->client)
				SpawnDamage (te_sparks, point, normal, take);
		}

		targ->health = targ->health - take;

		if (targ->health <= 0)
		{
			if ((targ->svflags & SVF_MONSTER) || (client))
				targ->flags |= FL_NO_KNOCKBACK;
//TROND			11/3   tatt vekk, den lager crash mest sannsynlig
//			Killed (targ, inflictor, attacker, take, point);
			if (attacker->client
				&& targ->client)
			{
//				gi.bprintf (PRINT_HIGH, "DEBUG: %s was killed by a client, %s\n", targ->client->pers.netname, attacker->client->pers.netname);
				player_die (targ, NULL, attacker, 100, vec3_origin);
			}
			else
			{
				if (targ->client)
				{
//					gi.bprintf (PRINT_HIGH, "DEBUG: %s was killed by the world\n", targ->client->pers.netname);
					player_die (targ, targ, targ, 100, vec3_origin);
				}
				else if (targ->classname == "police")
				{
					Killed (targ, inflictor, attacker, take, point);
				}
				else
				{
					if (!deathmatch->value
						&& targ->takedamage
						&& !targ->client
						&& targ->classname != "police")
						Killed (targ, inflictor, attacker, take, point);
				}
			}
//TROND slutt
			return;
		}
	}

	if (targ->svflags & SVF_MONSTER)
	{
		M_ReactToDamage (targ, attacker);
		if (!(targ->monsterinfo.aiflags & AI_DUCKED) && (take))
		{
			targ->pain (targ, attacker, knockback, take);
			// nightmare mode monsters don't go into pain frames often
			if (skill->value == 3)
				targ->pain_debounce_time = level.time + 5;
		}
	}
	else if (client)
	{
		if (!(targ->flags & FL_GODMODE) && (take))
			targ->pain (targ, attacker, knockback, take);
	}
	else if (take)
	{
		if (targ->pain)
			targ->pain (targ, attacker, knockback, take);
	}

	// add to the damage inflicted on a player this frame
	// the total will be turned into screen blends and view angle kicks
	// at the end of the frame
	if (client)
	{
		client->damage_parmor += psave;
		client->damage_armor += asave;
		client->damage_blood += take;
		client->damage_knockback += knockback;
		VectorCopy (point, client->damage_from);
	}
}


/*
============
T_RadiusDamage
============
*/
void T_RadiusDamage (edict_t *inflictor, edict_t *attacker, float damage, edict_t *ignore, float radius, int mod)
{
	float	points;
	edict_t	*ent = NULL;
	vec3_t	v;
	vec3_t	dir;

	while ((ent = findradius(ent, inflictor->s.origin, radius)) != NULL)
	{
		if (ent == ignore)
			continue;
		if (!ent->takedamage)
			continue;

		VectorAdd (ent->mins, ent->maxs, v);
		VectorMA (ent->s.origin, 0.5, v, v);
		VectorSubtract (inflictor->s.origin, v, v);
		points = damage - 0.5 * VectorLength (v);
		if (ent == attacker)
			points = points * 0.5;
		if (points > 0)
		{
			if (CanDamage (ent, inflictor))
			{
				VectorSubtract (ent->s.origin, inflictor->s.origin, dir);
				
				T_Damage (ent, inflictor, attacker, dir, inflictor->s.origin, vec3_origin, (int)points, (int)points, DAMAGE_RADIUS, mod);
				
				//TROND painskin
				if (ent->client)
				{
					if (rand() & 2)
					{
						ent->client->pain_head = 1;
						ent->client->pain_stomach = 1;
						ent->client->pain_leg = 1;
						ent->client->limp = 1;
					}
					else if (rand() & 1)
					{
						ent->client->pain_chest = 1;
						ent->client->pain_stomach = 1;
						ent->client->pain_leg = 1;
						ent->client->limp = 1;
					}
					else
					{
						ent->client->pain_chest = 1;
						ent->client->pain_leg = 1;
						ent->client->pain_head = 1;
						ent->client->limp = 1;
					}
					painskin (ent);
					ent->client->bleeding = 1;//TROND
					if (attacker->client)
						ent->enemy = attacker;
				}
				else if (!ent->client
					&& ent->classname == "police")
				{
					ent->skinnum_head = 1;
					ent->skinnum_chest = 1;
					ent->skinnum_stomach = 1;
					ent->skinnum_leg = 1;
					bot_pain (ent);
				}
				//TROND slutt
			}
		}
	}
}
