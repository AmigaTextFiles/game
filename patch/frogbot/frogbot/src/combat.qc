void() ClientObituary;


//============================================================================

/*
============
CanDamage

Returns true if the inflictor can directly damage the target.  Used for
explosions and melee attacks.
============
*/
float() CanDamage =
{
	targ_origin = targ.origin;
	traceline(inflictor_origin, targ_origin, TRUE, inflictor);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor_origin, targ_origin + '15 15 0', TRUE, inflictor);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor_origin, targ_origin + '-15 -15 0', TRUE, inflictor);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor_origin, targ_origin + '-15 15 0', TRUE, inflictor);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor_origin, targ_origin + '15 -15 0', TRUE, inflictor);
	if (trace_fraction == 1)
		return TRUE;
	return FALSE;
};

/*
================
TeamArmorDam

Return TRUE if the target's armor can take damage from this attacker.
================
*/

float() TeamArmorDam =
{
	if (armorplay)
	if (attacker.realteam == targ.realteam)
	if (attacker != targ)
		return FALSE;	// Armor is protected

	return TRUE;
};

/*
============
T_Damage

The damage is coming from inflictor, but get mad at attacker
This should be the only function that ever reduces health.
============
*/
void() T_Damage =
{
	axhitme_ = axhitme;
	axhitme = 0;

// check for quad damage powerup on the attacker
	if (attacker.super_damage_finished > time)
		damage = damage * quad_factor;

	if ((attacker != targ) || (game_not_rune_rj))
	{
	// check for double damage for rune of Black Magic powerup
		if (attacker.player_flag & ITEM_RUNE2_FLAG)
			damage = damage * 2;

	// check if target has rune of Earth Magic (half damage)
		else if (targ.player_flag & ITEM_RUNE1_FLAG)
		{
			damage = damage * 0.5;
			// play resistance sound if needed
			if (targ.invincible_sound < time)
			{
				targ.invincible_sound = time + 1;
				msg_entity = targ;
				if (game_capture_custom)
					sound(CHAN_BODY, "rune/rune1.wav", 1, ATTN_NORM);
				else
					sound(CHAN_BODY, "items/protect3.wav", 1, ATTN_NORM);
			}
		}
	}

// save damage based on the target's armor level

// team play armor damage avoidance
// TeamArmorDam returns true iff the attacker can damage the target's armor
	if (TeamArmorDam())
	{
		save = ceil(targ.armortype*damage);
		if (save >= targ.armorvalue)
		{
			save = targ.armorvalue;
			targ.armortype = 0;	// lost all armor
			targ.items = targ.items & IT_NOT_ARMOR;
		}
		targ.armorvalue = targ.armorvalue - save;
	}
	else
		save = 0;

	take = ceil(damage-save);

// add to the damage total for clients, which will be sent as a single
// message at the end of the frame
// FIXME: remove after combining shotgun blasts?
	if (targ.client_)
	{
		if (targ.preferences & PREF_FLASH)
		{
			targ.dmg_take = targ.dmg_take + take;
			targ.dmg_save = targ.dmg_save + save;
			targ.dmg_inflictor = inflictor;
		}

		// figure momentum add
		if (inflictor)
		{
			direction = normalize(targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5) * damage;
		#ifdef QUAKE
			if (game_qwphysics)
			{
		#endif // QUAKE
				if ((damage < 60) && (attacker.client_) && (attacker != targ)) 
					targ.velocity = targ.velocity + direction * 11;
				else                        
					targ.velocity = targ.velocity + direction * 8;
		#ifdef QUAKE
			}
			else
				targ.velocity = targ.velocity + direction * 8;
		#endif // QUAKE
		}

		if (targ.look_object.firepower < attacker.firepower)
		{	// attacker must be FL_CLIENT
			targ.look_object = attacker;
			if (attacker.realteam != targ.realteam)
			{
				if (targ.goalentity == targ.enemy)
					targ.goal_refresh_time = 0;
				targ.enemy_time = time + 1;
				targ.enemy = attacker;
			}
			else if (attacker != targ)
			{
				targ.enemy_time = time + 2.5;
				targ.friend = attacker;	// being shot by this friend
			}
		}

	#ifdef QUAKE
		targ.postvelocity = targ.velocity;
	#endif // QUAKE

	// check for invincibility
		if (targ.invincible_finished >= time)
		{
			if (targ.invincible_sound < time)
			{
				if (pre_game)
				{
					if (!start_time)
					{
						if (targ.flags & FL_FROGBOT)
						{
							if (targ.touch_marker.T & UNREACHABLE)
								targ.impulse = CLIENTKILL;	// suicide
						}
					}
				}
				else
				{
					msg_entity = targ;
					sound (CHAN_ITEM, "items/protect3.wav", 1, ATTN_NORM);
					targ.invincible_sound = time + 2;
				}
			}
			UpdateTotalDamage(targ);
			return;
		}

	// team play health damage avoidance
		if (teamplay)
		{
			if (attacker.realteam == targ.realteam)
			{
				if (healthplay == TEAM_HEALTH_PROTECT)
				if (targ != attacker)
				{
					UpdateTotalDamage(targ);
					return;
				}

				if (healthplay == TEAM_TOTAL_HEALTH_PROTECT)
				{
					UpdateTotalDamage(targ);
					return;
				}
			}
		}
	}

#ifdef MANUAL
	if (manual_mode)
		return;
#endif // MANUAL

	killed_self = self;
	self = targ;

// do the damage
	targ.health = targ.health - take;
			
	if (targ.health <= 0)
	{
		if (targ.health < -99)
			targ.health = -99;		// don't let sbar look bad if a player

		self.th_die();
	}
	else
	{
	// react to the damage
		UpdateTotalDamage(self);
		self.th_pain ();
	}

	self = killed_self;
};

/*
============
T_RadiusDamage

============
*/
void() T_RadiusDamage =
{
	attacker_damaged = FALSE;
	inflictor_origin = inflictor.origin;
	damage_radius = t_radius_damage + 40;

	targ = first_takedamage;
	while (targ)
	{
		if (targ.takedamage)
		{
			if (targ != ignore)
			{
				targ_centre = (targ.absmin + targ.absmax) * 0.5;
				inflictor_dist = vlen(inflictor_origin - targ_centre);
				if (inflictor_dist <= damage_radius)
				{
					damage = t_radius_damage - 0.5 * inflictor_dist;
					if (damage > 0)	// only used if t_radius_damage < 40
					{
						if (targ.movetype == MOVETYPE_PUSH)
						{
							traceline(inflictor_origin, targ_centre, TRUE, inflictor);
							if ((trace_fraction == 1) || (trace_ent == targ))
							{
								T_Damage ();
							}
						}
						else
						{
							if (CanDamage())
							{
								if (targ == attacker)
								{
									attacker_damaged = TRUE;
									attacker_damage = damage * 0.5;
								}
								else
									T_Damage ();
							}
						}
					}
				}
			}
		}
		targ = targ.next;
	}
	if (attacker_damaged)
	{
		targ = attacker;
		damage = attacker_damage;
		T_Damage ();
	}
};
