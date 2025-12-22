entity(vector org) LocateMarker;
float() ExistsPath;
void() CheckNewWeapon;
void() DoFriction;
void() VelocityForArrow;
void() AvoidHazards;
void() frogbot_marker_touch;
void() UpdateGoal;
void() SetFireButton;
void() SelectWeapon;
void() UpdateWeapons;
float() Visible_360;
float() Visible_infront;
void() BestEnemy;
void() BestLook;
void() PlayerPreThink_apply;
void() PlayerDeathThink;
void() BestArrowForDirection;

#ifdef QUAKE
float() DoubleFriction;
#endif // QUAKE

/*
============
EvalLook

============
*/
void() EvalLook =
{
	if (description)
	{
		if (description & NO_LOOK)
			return;
		if (description & DM6_DOOR)
		{
			if (dm6_door.takedamage)
				return;	// door closed
		}
	}

	if (from_marker == dm6_door)
	{
		if (!dm6_door.takedamage)
			return;	// door open
	}

	look_score = (dir_look * normalize((from_marker.absmin + from_marker.view_ofs) - linked_marker_origin));
	look_score = look_score + random();

	if (look_score > best_score)
	{
		best_score = look_score;
		look_object_ = from_marker;
	}
};

/*
============
check_sound

============
*/
void() check_sound =
{
	if (enemy_.client_)
	{
		self_sound = self;
		self = first_client;
		while (self)
		{
			if (!(self.state & NOTARGET_ENEMY))
				if (enemy_ == self.enemy)
					if (enemy_ != self.look_object)
						if (vlen(enemy_.origin - self.origin) < 1000)	// ear shot
						{
							visible_object = enemy_;
							if (Visible_360())
								self.look_object = enemy_;
						}
			self = self.next;
		}
		self = self_sound;
	}
};

/*
============
sound

============
*/
void(float chan, string samp, float vol, float atten) sound =
{
	sound_apply(msg_entity, chan, samp, vol, atten);
	enemy_ = msg_entity;
	check_sound();
};

/*
============
BestEnemy

============
*/
void() BestEnemy =
{
// initialise
	predict_time = best_score = 10000000;

	test_enemy = first_client;
	while (test_enemy)
	{
		if (realteam_ != test_enemy.realteam)
		{
			to_marker = test_enemy.touch_marker;
			if (to_marker)
			{
				from_marker = touch_marker_;
				to_marker.zone_marker();
				to_marker.sub_arrival_time();
				if (traveltime > 5)
					enemy_score = 5 + random();
				else
					enemy_score = traveltime;
				if (enemy_score < predict_time)
					predict_time = enemy_score;

				if (test_enemy != enemy_)
				{
					traceline(origin_ + '0 0 22', test_enemy.origin + '0 0 22', TRUE, self);
					if (trace_fraction != 1)
					{
						from_marker = test_enemy.touch_marker;
						touch_marker_.zone_marker();
						touch_marker_.sub_arrival_time();
						if (traveltime > 5)
							traveltime = 5 + random();
						if (traveltime < predict_time)
							predict_time = traveltime;
						enemy_score = enemy_score + traveltime;
					}
				}

				if (enemy_score < best_score)
				{
					best_score = enemy_score;
					enemy_ = test_enemy;
				}
			}
		}

		test_enemy = test_enemy.next;
	}

	self.visible_object_time = 0;
	self.enemy_time = time + 1;
	self.enemy = enemy_;
	if (enemy_)
		self.enemy_dist = predict_time * half_sv_maxspeed;
	else
		self.enemy_dist = 600;
};

/*
============
EvalGoal

============
*/
void() EvalGoal =
{
	goal_entity.desire();
	goal_entity.saved_goal_desire = goal_desire;
	if (goal_desire > 0)
	{
		if (time < goal_entity.touchPlayerTime)
		if (goal_entity.nextthink > 0)
		if (goal_entity.touchPlayer.realteam == realteam_)
		if (goal_entity.touchPlayer != self)
		{
			goal_entity.saved_goal_desire = 0;
			return;
		}

		from_marker = touch_marker_;
		to_marker = goal_entity.touch_marker;
		to_marker.zone_marker();
		to_marker.sub_arrival_time();
		goal_time = traveltime;

		if (enemy_repel)
		{
			from_marker = enemy_touch_marker;
			to_marker.zone_marker();
			to_marker.sub_arrival_time();
			if (traveltime <= (goal_time - 1.25))
			{
				goal_desire = goal_desire + enemy_repel;
				goal_entity.saved_goal_desire = goal_desire;
				if (goal_desire <= 0)
					return;
			}
		}

		if (goal_entity.Z_ == 1)
		if (touch_marker_.Z1_task & DM6_DOOR)
		if (dm6_door.takedamage)
		if (enemy_ == look_object_)
		if (enemy_.firepower >= 50)
		{
			goal_entity.saved_goal_desire = 0;
			return;
		}

		goal_entity.saved_respawn_time = goal_entity.goal_respawn_time + (goal_time * prediction_error_ * random()) - time;

		if (goal_time < goal_entity.saved_respawn_time)
			goal_time = goal_entity.saved_respawn_time;

		goal_entity.saved_goal_time = goal_time;

		if (goal_time < lookahead_time_)
		{
			goal_score = goal_desire * (lookahead_time_ - goal_time) / (goal_time + 5);

			if (goal_score > best_score)
			{
				best_score = goal_score;
				best_goal = goal_entity;
			}
		}
	}
};

/*
============
EvalGoal2

============
*/
void() EvalGoal2 =
{
	goal_desire = goal_entity.saved_goal_desire;
	if (goal_desire > 0)
	{
		goal_time2 = goal_entity.saved_goal_time;

		if (goal_time2 <= 5)
		{
			goal_marker2 = goal_entity.touch_marker;

		// first goal_entity, then best_goal

			from_marker = goal_marker2;
			best_goal_marker.zone_marker();
			best_goal_marker.sub_arrival_time();
			traveltime2 = goal_time2 + traveltime;
			if (traveltime2 < best_respawn_time)
				traveltime2 = best_respawn_time;

			if (traveltime2 < lookahead_time_)
			{
				goal_score2 = (goal_desire * (lookahead_time_ - goal_time2) / (goal_time2 + 5))
				+ (best_goal_desire * (lookahead_time_ - traveltime2) / (traveltime2 + 5));
					if (goal_score2 > best_score2)
				{
					best_score2 = goal_score2;
					best_goal2 = goal_entity;
				}
			}

		// first best_goal, then goal_entity

			from_marker = best_goal_marker;
			goal_marker2.zone_marker();
			goal_marker2.sub_arrival_time();
			traveltime2 = best_goal_time + traveltime;
			if (traveltime2 < goal_entity.saved_respawn_time)
				traveltime2 = goal_entity.saved_respawn_time;

			if (traveltime2 < lookahead_time_)
			{
				goal_score2 = best_score + (goal_desire * (lookahead_time_ - traveltime2) / (traveltime2 + 5));

				if (goal_score2 > best_score2)
				{
					best_score2 = goal_score2;
					best_goal2 = best_goal;
				}
			}
		}
	}
};

/*
============
UpdateGoal

============
*/
void() UpdateGoal =
{
	self.goal_refresh_time = time + 2 + random();

	prediction_error_ = self.prediction_error;

	best_score = 0;
	best_goal = world;

	enemy_ = self.enemy;
	enemy_touch_marker = enemy_.touch_marker;
	items_ = self.items;

	enemy_desire = enemy_repel = 0;
	if (enemy_touch_marker)
	{
		virtual_enemy = enemy_;

	//
	// EvalClient
	//

		enemy_.desire();
		if (enemy_desire > 0)
		{
			from_marker = touch_marker_;
			enemy_touch_marker.zone_marker();
			enemy_touch_marker.sub_arrival_time();

			enemy_.saved_respawn_time = 0;
			enemy_.saved_goal_time = traveltime;

			if (traveltime < lookahead_time_)
			{
				goal_score = enemy_desire * (lookahead_time_ - traveltime) / (traveltime + 5);

				if (goal_score > best_score)
				{
					best_score = goal_score;
					best_goal = enemy_;
					enemy_.saved_goal_desire = enemy_desire;
				}
			}
		}
		else
		{
			if (enemy_.enemy == self)
				enemy_repel = enemy_desire;
		}
	}
	else
		virtual_enemy = dropper;

	goal_entity = touch_marker_.G1_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G2_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G3_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G4_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G5_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G6_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G7_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G8_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G9_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G10_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G11_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G12_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G13_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G14_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G15_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G16_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G17_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G18_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G19_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G20_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G21_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G22_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G23_.virtual_goal;
	EvalGoal();
	goal_entity = touch_marker_.G24_.virtual_goal;
	EvalGoal();

	goal_entity = find(world, classname, "dynamic_item");
	while (goal_entity)
	{
		if (goal_entity.touch_marker)
			EvalGoal();
		goal_entity = find(goal_entity, classname, "dynamic_item");
	}

	if (best_goal)
	{
		best_goal_desire = best_goal.saved_goal_desire;
		best_goal.saved_goal_desire = 0;	// don't pick twice
		best_goal_time = best_goal.saved_goal_time;
		best_goal_marker = best_goal.touch_marker;
		best_respawn_time = best_goal.saved_respawn_time;

		best_score2 = best_score;
		best_goal2 = best_goal;

		if (enemy_desire > 0)
		{
		//
		// EvalClient2
		//

			goal_time2 = enemy_.saved_goal_time;
			if (goal_time2 <= 5)
			{
				goal_marker2 = enemy_.touch_marker;

			// first enemy_, then best_goal

				from_marker = goal_marker2;
				best_goal_marker.zone_marker();
				best_goal_marker.sub_arrival_time();
				traveltime2 = goal_time2 + traveltime;
				if (traveltime2 < best_respawn_time)
					traveltime2 = best_respawn_time;

				if (traveltime2 < lookahead_time_)
				{
					goal_score2 = (enemy_desire * (lookahead_time_ - goal_time2) / (goal_time2 + 5))
					+ (best_goal_desire * (lookahead_time_ - traveltime2) / (traveltime2 + 5));

					if (goal_score2 > best_score2)
					{
						best_score2 = goal_score2;
						best_goal2 = enemy_;
					}
				}

			// first best_goal, then enemy_

				from_marker = best_goal_marker;
				goal_marker2.zone_marker();
				goal_marker2.sub_arrival_time();
				traveltime2 = best_goal_time + traveltime;
				if (traveltime2 < enemy_.saved_respawn_time)
					traveltime2 = enemy_.saved_respawn_time;

				if (traveltime2 < lookahead_time_)
				{
					goal_score2 = best_score + (enemy_desire * (lookahead_time_ - traveltime2) / (traveltime2 + 5));

					if (goal_score2 > best_score2)
					{
						best_score2 = goal_score2;
						best_goal2 = best_goal;
					}
				}
			}
		}

		goal_entity = touch_marker_.G1_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G2_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G3_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G4_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G5_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G6_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G7_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G8_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G9_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G10_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G11_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G12_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G13_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G14_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G15_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G16_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G17_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G18_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G19_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G20_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G21_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G22_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G23_.virtual_goal;
		EvalGoal2();
		goal_entity = touch_marker_.G24_.virtual_goal;
		EvalGoal2();

		goal_entity = find(world, classname, "dynamic_item");
		while (goal_entity)
		{
			if (goal_entity.touch_marker)
				EvalGoal2();
			goal_entity = find(goal_entity, classname, "dynamic_item");
		}

		goalentity_ = self.goalentity = best_goal2;
		self.goal_respawn_time = time + best_goal2.saved_respawn_time;
	}
	else
		goalentity_ = self.goalentity = world;
};

/*
============
UpdateGoalEntity

============
*/
void() UpdateGoalEntity =
{
	test_enemy = first_client;
	while (test_enemy)
	{
		if (test_enemy.goalentity == self)
			test_enemy.goal_refresh_time = 0;
		test_enemy = test_enemy.next;
	}
};

/*
============
UpdateTotalDamage

============
*/
void(entity client) UpdateTotalDamage =
{
	client.total_armor = client.armortype * client.armorvalue;
	min_first = client.health / (1 - client.armortype);
	min_second = client.health + client.armorvalue;
	if (min_first <= min_second)
		client.total_damage = min_first;
	else
		client.total_damage = min_second;

	if (client.total_armor == 160)
	{
		client.desire_armor1 = client.desire_armor2 = client.desire_armorInv = 0;
	}
	else
	{
		min_first = client.health / 0.2 ;
		min_second = client.health + 200;
		if (min_first <= min_second)
			client.desire_armorInv = min_first - client.total_damage;
		else
			client.desire_armorInv = min_second - client.total_damage;

		if (client.total_armor >= 90)
		{
			client.desire_armor1 = client.desire_armor2 = 0;
		}
		else
		{
			min_first = client.health / 0.4;
			min_second = client.health + 150;
			if (min_first <= min_second)
				client.desire_armor2 = min_first - client.total_damage;
			else
				client.desire_armor2 = min_second - client.total_damage;

			if (client.desire_armor2 < 0)
				client.desire_armor2 = 0;

			if (client.total_armor >= 30)
				client.desire_armor1 = 0;
			else
			{
				min_first = client.health / 0.7;
				min_second = client.health + 100;
				if (min_first <= min_second)
					client.desire_armor1 = 2 * (min_first - client.total_damage);
				else
					client.desire_armor1 = 2 * (min_second - client.total_damage);

				if (client.desire_armor1 < 0)
					client.desire_armor1 = 0;
			}
		}
	}

	if (client.health < 250)
	{
		if (client.health < 150)
			new_health = client.health + 100;
		else
			new_health = 250;

		min_first = new_health / (1 - client.armortype);
		min_second = new_health + client.armorvalue;
		if (min_first <= min_second)
			client.desire_health2 = min_first - client.total_damage;
		else
			client.desire_health2 = min_second - client.total_damage;

		if (client.health < 100)
		{
			if (client.health < 75)
				new_health = client.health + 25;
			else
				new_health = 100;

			min_first = new_health / (1 - client.armortype);
			min_second = new_health + client.armorvalue;
			if (min_first <= min_second)
				client.desire_health0 = 2 * (min_first - client.total_damage);
			else
				client.desire_health0 = 2 * (min_second - client.total_damage);
		}
		else
			client.desire_health0 = 0;
	}
	else
		client.desire_health0 = client.desire_health2 = 0;

	if (client.player_flag & ITEM_RUNE1_FLAG)
		client.total_damage = client.total_damage * 2;
};

/*
============
UpdateWeapons

============
*/
void() UpdateWeapons =
{
	self.state = self.state & NOT_UPDATE_WEAPONS_DELAY_UPDATE_WEAPONS;

	if (deathmatch != 4)
	{
		attackbonus = 0;
		items_ = self.items;
		if (items_ & IT_ROCKET_LAUNCHER)
		{
			firepower_ = self.ammo_rockets * 8;
			if (self.ammo_rockets)
				attackbonus = 50;
		}
		else if (items_ & IT_GRENADE_LAUNCHER)
		{
			firepower_ = self.ammo_rockets * 6;
			if (firepower_ > 50)
				firepower_ = 50;
		}
		else
			firepower_ = 0;

		if (items_ & IT_LIGHTNING)
		{
			firepower_ = firepower_ + self.ammo_cells;
			if (self.ammo_cells >= 10)
				attackbonus = attackbonus + 50;
		}

		if (items_ & IT_EITHER_NAILGUN)
			firepower_ = firepower_ + (self.ammo_nails * 0.1);

		if (items_ & IT_SUPER_SHOTGUN)
		{
			if (self.ammo_shells >= 50)
				firepower_ = firepower_ + 20;
			else
				firepower_ = firepower_ + self.ammo_shells * 0.4;
		}
		else
		{
			if (self.ammo_shells >= 25)
				firepower_ = firepower_ + 10;
			else
				firepower_ = firepower_ + self.ammo_shells * 0.4;
		}

		if (firepower_ > 100)
			firepower_ = 100;

		if (self.ammo_rockets >= 15)
			self.desire_rockets = 5;
		else
			self.desire_rockets = 20 - self.ammo_rockets;

		if (self.ammo_cells >= 37.5)
			self.desire_cells = 2.5;
		else
			self.desire_cells = (50 - self.ammo_cells) * 0.2;

		self.desire_rocketlauncher = 100 - firepower_;

		if (self.desire_rocketlauncher < self.desire_rockets)
			self.desire_rocketlauncher = self.desire_rockets;

		if (self.desire_rocketlauncher >= self.desire_cells)
			self.desire_lightning = self.desire_rocketlauncher;
		else
			self.desire_lightning = self.desire_cells;
		
		if (items_ & IT_ROCKET_LAUNCHER)
			self.desire_rockets = self.desire_grenadelauncher = self.desire_rocketlauncher;
		else
		{
			if (firepower_ >= 50)
				self.desire_grenadelauncher = 0;
			else
				self.desire_grenadelauncher = 50 - firepower_;

			if (self.desire_grenadelauncher < self.desire_rockets)
				self.desire_grenadelauncher = self.desire_rockets;

			if (items_ & IT_GRENADE_LAUNCHER)
				self.desire_rockets = self.desire_grenadelauncher;
		}

		if (items_ & IT_LIGHTNING)
			self.desire_cells = self.desire_lightning;

		if (firepower_ < 20)
		{
			self.desire_nails = 2.5 - (self.ammo_nails * 0.0125);
			if (self.ammo_shells >= 50)
				self.desire_shells = 0;
			else
				self.desire_shells = 2.5 - (self.ammo_shells * 0.05);
		}
		else
			self.desire_nails = self.desire_shells = 0;

		if (firepower_ >= 20)
			self.desire_supershotgun = 0;
		else
			self.desire_supershotgun = 20 - firepower_;

		if (self.desire_supershotgun >= self.desire_nails)
			self.desire_nailgun = self.desire_supernailgun = self.desire_supershotgun;
		else
			self.desire_nailgun = self.desire_supernailgun = self.desire_nails;

		if (self.desire_supershotgun < self.desire_shells)
			self.desire_supershotgun = self.desire_shells;

		if (items_ & IT_EITHER_NAILGUN)
			self.desire_nails = self.desire_supernailgun;

		if (items_ & IT_SUPER_SHOTGUN)
			self.desire_shells = self.desire_supershotgun;

		firepower_ = firepower_ + attackbonus;
		if (firepower_ > 100)
			firepower_ = 100;

		if (self.super_damage_finished > time)
			firepower_ = firepower_ * 4;
		if (self.player_flag & ITEM_RUNE2_FLAG)
			firepower_ = firepower_ * 2;
		self.firepower = firepower_;
	}
	else
	{
		if (self.super_damage_finished > time)
			self.firepower = 800;
		else
			self.firepower = 100;
		if (self.player_flag & ITEM_RUNE2_FLAG)
			self.firepower = self.firepower * 2;
	}
};

/*
============
EvalPath

============
*/
void() EvalPath =
{
	if (from_marker == dm6_door)
	{
		if (!dm6_door.takedamage)
			return;	// door open
	}

	test_marker = from_marker;

	marker_pos = from_marker.absmin + from_marker.view_ofs;

	if (description)
	{
		if (description & DM6_DOOR)
		{
			if (dm6_door.origin_x > -64)
				return;	// door not open enough
		}

		if (description & HIGH_ENOUGH)
		{
			if ((self.origin_z + 18) < (touch_marker_.absmin_z + touch_marker_.view_ofs_z))
				return;
		}

		if (description & LOOKAHEAD)
		{	// look ahead unless testing goalentity_marker
			if (from_marker != goalentity_marker)
				from_marker = from_marker.P0;
		}
	}

	same_dir = self_dir * normalize(marker_pos - origin_);
	path_score = same_dir + random();

	if (time < from_marker.arrow_time)
	{
		avoid = TRUE;
	}
	else
	{
		avoid = FALSE;
		if (rocket_alert)
		{
			if (vlen(marker_pos - rocket_endpos) < 200)
			{
				traceline(rocket_endpos, marker_pos, TRUE, self);
				if (trace_fraction == 1)
					avoid = TRUE;
			}
		}
	}

	if (avoid)
	{
		path_score = path_score - 2.5;
	}
	else
	{
		if (goalentity_marker)
		{
			goalentity_marker.zone_marker();
			goalentity_marker.sub_arrival_time();
			total_goal_time = path_time + traveltime;
			if (total_goal_time > goal_late_time)
			{
				if (traveltime < current_goal_time)	// improve position
					path_score = path_score + lookahead_time_ - total_goal_time;
				else if (total_goal_time > current_goal_time_125) // don't go way off track
					path_score = path_score - total_goal_time;
			}
		}
	}

	if (path_score > best_score)
	{
		best_score = path_score;
		linked_marker_ = test_marker;
		new_path_state = description;
	}
};

/*
============
frogbot_marker_touch

============
*/
void() frogbot_marker_touch =
{
	if (self.path_state & WAIT_GROUND)
	if (self.waterlevel <= 1)
	if (!(self.flags & FL_ONGROUND))
		return;

	goalentity_marker = goalentity_.touch_marker;

	if (linked_marker_ == touch_marker_)
	{
		if (goalentity_ == touch_marker_)
		{
			if (!touch_marker_.nextthink)
			// item hasn't been touched yet
				return;
		}
		else if (goalentity_marker == touch_marker_)
		{
			if (goalentity_.classname == "dynamic_item")
			{
				linked_marker_ = self.linked_marker = goalentity_;
				self.linked_marker_time = time + 5;
				self.old_linked_marker = touch_marker_;
				return;
			}
		}
	}
	else
	{
		from_marker = self.old_linked_marker;
		to_marker = touch_marker_;
		if (ExistsPath())
		{
			from_marker = touch_marker_;
			to_marker = linked_marker_;
			if (ExistsPath())
				return;	// intermediate marker
		}

		self.state = self.state & NOT_HURT_SELF;
	}

//
// best path
//
	best_score = -1000000;


	self_dir = normalize(self.velocity);

	rocket_alert = FALSE;
	if (enemy_.items & IT_ROCKET_LAUNCHER)
	{
		if (enemy_.attack_finished <= time + 0.2)
		{
			if (enemy_.ammo_rockets)
			{
				if (random() < 0.5)
				{
					src = enemy_.origin + '0 0 16';
					traceline(src, origin_, TRUE, self);
					if (trace_fraction != 1)
					{
						rocket_alert = TRUE;
						makevectors(enemy_.v_angle);
						traceline(src, src + (v_forward * 500), TRUE, self);
						rocket_endpos = trace_endpos;
					}
				}
			}
		}
	}


	if (goalentity_marker)
	{
		from_marker = touch_marker_;
		goalentity_marker.zone_marker();
		goalentity_marker.sub_arrival_time();
		current_goal_time = traveltime;
		current_goal_time_125 = current_goal_time + 1.25;
		if (current_goal_time < 2.5)
			goal_late_time = (self.goal_respawn_time - (random() * 5)) - time;
		else
			goal_late_time = (self.goal_respawn_time - (random() * 10))- time;


		from_marker = touch_marker_;
		if (from_marker)
		{
			description = 0;
			path_time = 0;
			EvalPath();
		}
	}

	from_marker = touch_marker_.P0;
	if (from_marker)
	{
		description = touch_marker_.D0;
		path_time = touch_marker_.P0_time;
		EvalPath();
	}

	from_marker = touch_marker_.P1;
	if (from_marker)
	{
		description = touch_marker_.D1;
		path_time = touch_marker_.P1_time;
		EvalPath();
	}

	from_marker = touch_marker_.P2;
	if (from_marker)
	{
		description = touch_marker_.D2;
		path_time = touch_marker_.P2_time;
		EvalPath();
	}

	from_marker = touch_marker_.P3;
	if (from_marker)
	{
		description = touch_marker_.D3;
		path_time = touch_marker_.P3_time;
		EvalPath();
	}

	from_marker = touch_marker_.P4;
	if (from_marker)
	{
		description = touch_marker_.D4;
		path_time = touch_marker_.P4_time;
		EvalPath();
	}

	from_marker = touch_marker_.P5;
	if (from_marker)
	{
		description = touch_marker_.D5;
		path_time = touch_marker_.P5_time;
		EvalPath();
	}

	self.linked_marker = linked_marker_;
	self.path_state = new_path_state;

	if (touch_marker_ == linked_marker_)
		self.linked_marker_time = time + 0.3;
	else
		self.linked_marker_time = time + 5;


//
// CheckTasks
//

	if (goalentity_marker.Z_ == 1)	// task zone
	{
		if (touch_marker_.Z1_task & DM6_DOOR)
		{
			if (dm6_door.takedamage)
			{
				direction = normalize(dm6_door.absmin + dm6_door.view_ofs - origin_ - '0 0 40');
				src = origin_ + '0 0 16';

				traceline (src, src + direction*2048, FALSE, self);
				if (trace_ent == dm6_door)
					self.path_state = self.path_state | DM6_DOOR;
			}
			else
				self.path_state = self.path_state - (self.path_state & DM6_DOOR);
		}
	}


	self.state = self.state & NOT_NOTARGET_ENEMY;

	if (self.path_state)
	{
		if (self.path_state & DIFFICULT)
		{
			self.state = self.state | NOTARGET_ENEMY;
			look_object_ = linked_marker_;
			self.look_object = look_object_;
		}
		else if (self.path_state & DM6_DOOR)
		{
			self.state = self.state | NOTARGET_ENEMY;
			look_object_ = dm6_door;
			self.look_object = look_object_;
		}
	}
	else if (!look_object_.client_)
		BestLook();

	self.old_linked_marker = touch_marker_;
};

/*
============
BestLook

============
*/
void() BestLook =
{
	if (random() < self.look_anywhere)
	{
		best_score = -1000000;

		linked_marker_origin = linked_marker_.absmin + linked_marker_.view_ofs;

		if (enemy_)
		{
			traceline(origin_ + '0 0 22', enemy_.origin + '0 0 22', TRUE, self);
			if (trace_fraction == 1)
				look_for_enemy = TRUE;
			else
			{
				traceline(linked_marker_origin + '0 0 22', enemy_.origin + '0 0 22', TRUE, self);
				if (trace_fraction == 1)
					look_for_enemy = TRUE;
				else
					look_for_enemy = FALSE;
			}
		}
		else
			look_for_enemy = FALSE;

		if (look_for_enemy)
		{
			dir_look = normalize((enemy_.origin - linked_marker_origin));
		}
		else
		{
			makevectors(self.v_angle);
			dir_look = normalize((self.velocity * inv_sv_maxspeed) + v_forward);
		}

		from_marker = linked_marker_.P0;
		if (from_marker)
		{
			description = linked_marker_.D0;
			EvalLook();
		}

		from_marker = linked_marker_.P1;
		if (from_marker)
		{
			description = linked_marker_.D1;
			EvalLook();
		}

		from_marker = linked_marker_.P2;
		if (from_marker)
		{
			description = linked_marker_.D2;
			EvalLook();
		}

		from_marker = linked_marker_.P3;
		if (from_marker)
		{
			description = linked_marker_.D3;
			EvalLook();
		}

		from_marker = linked_marker_.P4;
		if (from_marker)
		{
			description = linked_marker_.D4;
			EvalLook();
		}

		from_marker = linked_marker_.P5;
		if (from_marker)
		{
			description = linked_marker_.D5;
			EvalLook();
		}
	}
	else
		look_object_ = linked_marker_;

	self.look_object = look_object_;
};

/*
============
SetFireButton

============
*/
void() SetFireButton =
{
	if ((self.weapon & IT_CONTINUOUS) && (self.button0_))
	{
		if (random() < 0.666667)
			return;
	}
	else
	{
		if (time < self.attack_finished)
			return;
	}

	self.button0_ = FALSE;

	if (self.impulse)
		return;	// trying to change weapon

	look_object_ = self.look_object;

	if (look_object_)
	{
		if (look_object_.realteam != self.realteam)
		{
			if (self.path_state & DM6_DOOR)
			{
				items_ = self.items;
				if (self.ammo_shells)
					desired_weapon = IT_SHOTGUN;
				else if ((items_ & IT_NAILGUN) && (self.ammo_nails))
					desired_weapon = IT_NAILGUN;
				else if ((items_ & IT_SUPER_NAILGUN) && (self.ammo_nails))
					desired_weapon = IT_SUPER_NAILGUN;
				else if ((items_ & IT_LIGHTNING) && (self.ammo_cells))
					desired_weapon = IT_LIGHTNING;
				CheckNewWeapon();
			}

			if (self.state & HURT_SELF)
			{
				if (self.weapon == IT_ROCKET_LAUNCHER)
				if (self.real_pitch == 78.75)
				{
					self.button0_ = TRUE;
					self.state = self.state & NOT_HURT_SELF;
				}
				return;
			}

			if (self.state & CLEAR_SHOT)
			{
				origin_ = self.origin;
				rel_pos = look_object_.absmin + look_object_.view_ofs - origin_;
				if (self.state & SHOOT_GROUND)
					rel_pos = rel_pos - '0 0 39';

				rel_dist = vlen(rel_pos) - 16;

				desired_angle = vectoangles(rel_pos);

				if (desired_angle_x > 180)
					desired_angle_x = 360 - desired_angle_x;
				else
					desired_angle_x = 0 - desired_angle_x;

				angle_error = desired_angle - self.v_angle;

				if (angle_error_y >= 180)
					angle_error_y = angle_error_y - 360;
				else if (angle_error_y < -180)
					angle_error_y = angle_error_y + 360;

				if (angle_error_x < 0)
					angle_error_x = 0 - angle_error_x;

				if (angle_error_y < 0)
					angle_error_y = 0 - angle_error_y;

				risk_factor = 1;

				if (look_object_.client_)
				{
					if (self.weapon & IT_VELOCITY)
					{
						if (self.weapon == IT_GRENADE_LAUNCHER)
							weapon_speed = 600;
						else
						{
							weapon_speed = 1000;

							if (self.weapon == IT_ROCKET_LAUNCHER)
							{
								rocket_origin = origin_ + '0 0 16';
								makevectors(self.v_angle);
								traceline(rocket_origin, rocket_origin + (v_forward * 600), FALSE, self);
								if (trace_fraction != 1)
								{
									rocket_endpos = trace_endpos;
									risk_strength = trace_fraction;
									traceline(rocket_endpos, look_object_.origin, TRUE, self);
									if (trace_fraction != 1)
										return;

									realteam_ = self.realteam;
									test_enemy = first_client;
									while (test_enemy)
									{
										if (test_enemy.takedamage)
											if (vlen(test_enemy.origin - rocket_endpos) <= 160)
											{
												traceline(test_enemy.origin, rocket_endpos, TRUE, self);
												if (trace_fraction == 1)
												{
													if (test_enemy.realteam != realteam_)
													{
														risk_factor = risk_factor / risk_strength;
													}
													else
													{
														if (test_enemy != self)
															return;
														else
															risk_factor = risk_factor * risk_strength;
													}
												}
											}
										test_enemy = test_enemy.next;
									}
								}
							}
							else
							{
								if (self.player_flag & ITEM_RUNE3_FLAG)
									weapon_speed = 2000;
							}
						}

						predict_desired_yaw = vectoyaw(rel_pos + (look_object_.velocity * (rel_dist / weapon_speed)));

						predict_yaw_error = predict_desired_yaw - self.v_angle_y;

						if (predict_yaw_error >= 180)
							predict_yaw_error = predict_yaw_error - 360;
						else if (predict_yaw_error < -180)
							predict_yaw_error = predict_yaw_error + 360;

						if (predict_yaw_error < 0)
							predict_yaw_error = 0 - predict_yaw_error;

						if (predict_yaw_error < angle_error_y)
						{
							angle_error_y = predict_yaw_error;
							desired_angle_y = predict_desired_yaw;
						}
					}
				}

				risk = random();
				risk = risk * risk * (self.accuracy + (1440 / rel_dist));	// 1440 = 90 * 16

				if (self.cheat_aim)
				{
					risk = (risk + ((22.5 + (360 / rel_dist)) - risk) * self.cheat_aim) * risk_factor;	// 360 = 22.5 * 16

					if (angle_error_x > risk)
						return;
					if (angle_error_y > risk)
						return;

					self.v_angle_x = self.v_angle_x + (desired_angle_x - self.v_angle_x) * self.cheat_aim;
					desired_angle_y =  desired_angle_y - self.v_angle_y;

					if (desired_angle_y >= 180)
						desired_angle_y = desired_angle_y - 360;
					else if (desired_angle_y < -180)
						desired_angle_y = desired_angle_y + 360;

					self.v_angle_y = self.v_angle_y + desired_angle_y * self.cheat_aim;
				}
				else
				{
					risk = risk * risk_factor;

					if (angle_error_x > risk)
						return;
					if (angle_error_y > risk)
						return;
				}

				self.button0_ = TRUE;
			}
		}
	}
};

/*
============
RocketSafe

============
*/
float() RocketSafe =
{
	splash_damage = 80 - (0.25 * self.enemy_dist);
	if (splash_damage <= 0)
		return TRUE;
	if (healthplay == TEAM_TOTAL_HEALTH_PROTECT)
		return TRUE;

	if (self.super_damage_finished > time)
	{
		splash_damage = splash_damage * quad_factor;

		if (self.player_flag & ITEM_RUNE_MASK)
		{
			if (self.player_flag & ITEM_RUNE2_FLAG)
				splash_damage = splash_damage * 2;
			else if (self.player_flag & ITEM_RUNE1_FLAG)
				splash_damage = splash_damage * 0.5;
		}
	}

	if (self.total_damage > splash_damage)
		return TRUE;
	return FALSE;
};

/*
============
DesiredWeapon

============
*/
float() DesiredWeapon =
{
	avoid_rockets = FALSE;
	items_ = self.items;

	if (game_rl_pref)
	{
		if (items_ & IT_ROCKET_LAUNCHER)
		{
			if (self.ammo_rockets)
			{
				if (RocketSafe())
				{
					desired_weapon = IT_ROCKET_LAUNCHER;
					return FALSE;
				}
				avoid_rockets = TRUE;
			}
		}
	}

	shaft_available = FALSE;

	if (items_ & IT_LIGHTNING)
	{
		if (self.ammo_cells)
		{
			if (self.enemy_dist <= 600)
			{
				if (look_object_ == enemy_)
				{
					enemy_angles = vectoangles(look_object_.origin - origin_);
					if (enemy_angles_x < 15)
					if (enemy_angles_x > -15)
					{
						desired_weapon = IT_LIGHTNING;
						return FALSE;
					}
				}
				else
				{
					desired_weapon = IT_LIGHTNING;
					return FALSE;
				}
				shaft_available = TRUE;
			}
		}
	}

	if (!avoid_rockets)
	{
		if (items_ & IT_ROCKET_LAUNCHER)
		{
			if (self.ammo_rockets)
			{
				if (RocketSafe())
				{
					desired_weapon = IT_ROCKET_LAUNCHER;
					return FALSE;
				}
				avoid_rockets = TRUE;
			}
		}
	}

	if (shaft_available)
	{
		desired_weapon = IT_LIGHTNING;
		return FALSE;
	}

	if (self.enemy_dist <= 600)
	{
		if (!avoid_rockets)
		if (items_ & IT_GRENADE_LAUNCHER)
		if (self.ammo_rockets)
		if (RocketSafe())
		{
			desired_weapon = IT_GRENADE_LAUNCHER;
			return FALSE;
		}
		if (items_ & IT_SUPER_NAILGUN)
		if (self.ammo_nails)
		{
			desired_weapon = IT_SUPER_NAILGUN;
			return FALSE;
		}
		if (items_ & IT_SUPER_SHOTGUN)
		if (self.ammo_shells)
		{
			desired_weapon = IT_SUPER_SHOTGUN;
			return FALSE;
		}
		if (items_ & IT_NAILGUN)
		if (self.ammo_nails)
		{
			desired_weapon = IT_NAILGUN;
			return FALSE;
		}
	}
	if (self.ammo_shells)
	{
		desired_weapon = IT_SHOTGUN;
		return FALSE;
	}
};

/*
============
CheckNewWeapon

============
*/
void() CheckNewWeapon =
{
	if (self.weapon != desired_weapon)
	{
		if (desired_weapon == IT_LIGHTNING)
			self.impulse = 8;
		else if (desired_weapon == IT_ROCKET_LAUNCHER)
			self.impulse = 7;
		else if (desired_weapon == IT_GRENADE_LAUNCHER)
			self.impulse = 6;
		else if (desired_weapon == IT_SUPER_NAILGUN)
			self.impulse = 5;
		else if (desired_weapon == IT_NAILGUN)
			self.impulse = 4;
		else if (desired_weapon == IT_SUPER_SHOTGUN)
			self.impulse = 3;
		else if (desired_weapon == IT_SHOTGUN)
			self.impulse = 2;
		else if (desired_weapon == IT_AXE)
			self.impulse = 1;
	}
};

/*
============
SelectWeapon

============
*/
void() SelectWeapon =
{
	if (self.path_state & DM6_DOOR)
		return;

	if (self.state & HURT_SELF)
	{
		if (self.items & IT_ROCKET_LAUNCHER)
		if (self.ammo_rockets)
		if (self.health >= 50)
		if (self.super_damage_finished <= time)
		{
			if (self.weapon != IT_ROCKET_LAUNCHER)
				self.impulse = 7;
			return;
		}
		self.state = self.state & NOT_HURT_SELF;
	}

	DesiredWeapon();
	CheckNewWeapon();
};

/*
============
ExplodeAlert

============
*/
void(vector org) ExplodeAlert =
{
	grenade_marker = findradius(org, 200);

	while (grenade_marker)
	{
		if (grenade_marker.flags & FL_MARKER)
		{
			traceline(org, grenade_marker.absmin + grenade_marker.view_ofs, TRUE, grenade_marker);
			if (trace_fraction == 1)
			{
				if (grenade_marker.arrow_time < nextthink_)
					grenade_marker.arrow_time = nextthink_;

				test_enemy = first_teleport;
				while (test_enemy)
				{
					if (test_enemy.enemy == grenade_marker)
					{
						if (test_enemy.arrow_time < nextthink_)
							test_enemy.arrow_time = nextthink_;
					}
					test_enemy = test_enemy.next;
				}
			}
		}

		grenade_marker = grenade_marker.chain;
	}
};

void() GrenadeAlert2 =
{
	nextthink_ = self.nextthink = self.frogbot_nextthink;
	self.think = GrenadeExplode;
	ExplodeAlert(self.origin);
};

void() GrenadeAlert1 =
{
	nextthink_ = self.nextthink = time + 0.75;
	self.think = GrenadeAlert2;
	ExplodeAlert(self.origin);
};

void() RocketAlert =
{
	nextthink_ = self.nextthink = time + 0.5;
	if (nextthink_ >= self.frogbot_nextthink)
		self.think = Missile_Remove;

	src = self.origin;
	traceline(src, src + (self.velocity * 600), TRUE, self.owner);
	ExplodeAlert(trace_endpos);
};

/*
============
FrameAI

============
*/
void() FrameAI =
{
//
// FrogbotPrePhysics
//

	//
	// FrogbotVelocity
	//


	// Remove_Obstacles for AvoidHazards
	test_enemy = first_client;
	while (test_enemy)
	{
		test_enemy.oldsolid = test_enemy.solid;
		test_enemy.solid = SOLID_NOT;
		test_enemy = test_enemy.next;
	}

	self = first_client;
	while (self)
	{
		if (self.flags & FL_FROGBOT)
		{
			self.button2 = FALSE;

			if (self.movetype == MOVETYPE_STEP)
			{
			#ifdef QUAKE
				if (game_qwphysics)
					double_friction = FALSE;
				else
					double_friction = DoubleFriction();
			#endif // QUAKE

				if (self.waterlevel <= 1)
					DoFriction();
				else	// do water friction
					self.velocity = self.velocity * inv_sv_friction_framtime;

				if (self.flags & FL_WATERJUMP)
				{
					self.velocity_x = self.movedir_x;
					self.velocity_y = self.movedir_y;

					if ((!self.waterlevel) || (time >= self.teleport_time))
					{
						self.flags = self.flags - FL_WATERJUMP;
						self.teleport_time = 0;
					}
				}
			}
			#ifdef QUAKE
			else if (self.flags & FL_PLAYER)
			{
				self.v_angle = self.stored_angle;
				if (game_qwphysics)
				{
					if (self.waterlevel <= 1)
					{
						if (DoubleFriction())
						{
							self.velocity = self.postvelocity;
							double_friction = FALSE;
							DoFriction();
						}
					}
				}
			}
			#endif // QUAKE

			if (self.takedamage)
			{
				oldvelocity_ = self.velocity;
				VelocityForArrow();
				AvoidHazards();
			}
		}
		#ifdef QUAKE
		else
		{
			if (game_qwphysics)
			{
				if (self.waterlevel <= 1)
				{
					if (DoubleFriction())
					{
						arrow_velocity = self.velocity;

						self.velocity = self.postvelocity;
						double_friction = TRUE;
						DoFriction();

						arrow_velocity = arrow_velocity - self.velocity;

						self.velocity = self.postvelocity;
						double_friction = FALSE;
						DoFriction();

						self.velocity = self.velocity + arrow_velocity;
					}
				}
			}
		}

		if (game_qwaim)
		{
			if (self.v_angle_x > 0)
				self.v_angle = self.v_angle + '1.40625 0.703125 0';
			else
				self.v_angle_y = self.v_angle_y + 0.703125;
		}
		#endif // QUAKE

		self = self.next;
	}

	// Restore_Obstacles for AvoidHazards

	test_enemy = first_client;
	while (test_enemy)
	{
		test_enemy.solid = test_enemy.oldsolid;
		test_enemy = test_enemy.next;
	}

	//
	// ThinkTime
	//

	self = first_client;
	while (self)
	{
		if (time >= self.frogbot_nextthink)
		{
			//
			// FrogbotThink();
			//

			#ifdef MANUAL
				if (manual_mode) FrogbotManual(); else {
			#endif // MANUAL

			// think every 0.19 to 0.21 seconds

			self.frogbot_nextthink = self.frogbot_nextthink + 0.19 + (0.02 * random());
			if (self.frogbot_nextthink <= time)
				self.frogbot_nextthink = time + 0.2;

			if (self.state & DELAY_UPDATE_WEAPONS)
			{
				if (random() < 0.2)
					self.state = self.state | UPDATE_WEAPONS;
			}

			if (self.state & UPDATE_WEAPONS)
				UpdateWeapons();

			if (self.takedamage)
			{
				if (time >= self.touch_marker_time)
				{
					self.touch_marker = LocateMarker(self.origin);
					self.Z_ = self.touch_marker.Z_;
				}

			//	assertion: self.touch_marker != world


				
				if (self.state & AWARE_SURROUNDINGS)
				{
					if (self.flags & FL_FROGBOT)
					{
						enemy_ = self.enemy;
						look_object_ = self.look_object;
						realteam_ = self.realteam;
						touch_marker_ = self.touch_marker;
						lookahead_time_ = self.lookahead_time;
						linked_marker_ = self.linked_marker;
						origin_ = self.origin;
						goalentity_ = self.goalentity;

					//
					// SetEnemy
					//

						if (!(self.state & NOTARGET_ENEMY))
						{
							if (look_object_.client_)
							{
								visible_object = look_object_;
								if (Visible_360())
								{
									if (look_object_ == enemy_)
									{
										self.enemy_dist = vlen(look_object_.origin - origin_);
									}
									else
									{
										if (time >= self.enemy_time)
											look_object_ = world;	// stop looking at friend
									}
								}
								else
									look_object_ = world;
							}
							else if (enemy_)
							{
								visible_object = enemy_;
								if (goalentity_ == enemy_)
								{
									if (Visible_360())
										look_object_ = self.look_object = enemy_;
									else
									{
										if (time >= self.enemy_time)
										{
											enemy_ = world;
											BestEnemy();
											if (enemy_ != goalentity_)
												self.goal_refresh_time = 0;
										}
									}
								}
								else
								{
									if (Visible_infront())
										look_object_ = self.look_object = enemy_;
									else
									{
										if (time >= self.enemy_time)
										{
											enemy_ = world;
											BestEnemy();
										}
									}
								}
							}
							else
								BestEnemy();
						}

					//
					// SetGoalentity
					//

						if (time >= self.goal_refresh_time)
							UpdateGoal();

					//
					// SetPath
					//

						if (self.old_linked_marker != touch_marker_)
							frogbot_marker_touch();

					//
					// SetArrows
					//

						if (time < self.arrow_time)
						{
							if (time < self.arrow_time2)
							{
								if (self.path_state & DIFFICULT)
								{
									if (random() < 0.5)
									{
										self.old_linked_marker = self.linked_marker = touch_marker_;
										self.path_state = 0;
										self.linked_marker_time = time + 0.3;
									}
								}
								else
									self.path_state = self.path_state | DIFFICULT;
							}
						}
						else if (time < self.linked_marker_time)
						{
							makevectors(self.v_angle);

							dir_move = normalize(linked_marker_.absmin + linked_marker_.view_ofs - origin_);

							if (linked_marker_ == touch_marker_)
							{
								if (goalentity_ == touch_marker_)
								{
									if (touch_marker_.nextthink)
									// item not spawned
										dir_move = '0 0 0';
								}
								else
									dir_move = '0 0 0';
							}

							if (self.flags & FL_ONGROUND)
							if (look_object_.client_)
							if (!(self.path_state & DIFFICULT))
							{
								desired_yaw = vectoyaw(origin_ - look_object_.origin);
								yawerror = desired_yaw - look_object_.v_angle_y;

								if (yawerror >= 180)
									yawerror = yawerror - 360;
								else if (yawerror < -180)
									yawerror = yawerror + 360;

								if (fabs(yawerror) < 90)
								{
									if (self.obstruction_normal == '0 0 0')
									{
										if (yawerror < 0)
											dir_move = dir_move - (random() * v_right * self.dodge_amount * look_object_.firepower * 0.01);
										else
											dir_move = dir_move + (random() * v_right * self.dodge_amount * look_object_.firepower * 0.01);
									}
									else
										dir_move = dir_move - (random() * self.obstruction_normal);
								}
							}

							if (self.waterlevel <= 1)
								dir_move_z = 0;
							BestArrowForDirection();
							self.arrow = best_arrow;
						}
						else
						{
						// lost way or pause finished
							self.old_linked_marker = world;
							linked_marker_ = self.linked_marker = LocateMarker(origin_);
							self.linked_marker_time = time + 5;
							self.path_state = 0;
						}

					//
					// SetMouse
					//

						self.state = self.state & NOT_SHOOT_GROUND_CLEAR_SHOT;

						if (!look_object_)
							BestLook();

						try_shoot = FALSE;

						if (look_object_ == enemy_)
						{
							try_shoot = TRUE;
							rel_pos = look_object_.origin - '0 0 1' - origin_;

							if (self.weapon == IT_ROCKET_LAUNCHER)
							{
								if (vlen(rel_pos) > 96)
								{
									traceline(origin_ + '0 0 16', origin_ + rel_pos - '0 0 22', TRUE, self);
									if (trace_fraction == 1)
									{
										self.state = self.state | SHOOT_GROUND;
										rel_pos_z = rel_pos_z - 38;
									}
								}
							}
						}
						else
						{
							rel_pos = look_object_.absmin + look_object_.view_ofs - '0 0 1' - origin_;

							if (self.path_state & DM6_DOOR)
							{
								if (dm6_door.takedamage)
								{
									try_shoot = TRUE;
									self.state = self.state | SHOOT_GROUND;
									rel_pos_z = rel_pos_z - 38;
								}
								else
								{
									self.path_state = self.path_state - DM6_DOOR;
									self.state = self.state & NOT_NOTARGET_ENEMY;
								}
							}
							else
							{
								if (vlen(rel_pos) <= 320)
								{
									rel_pos2_x = rel_pos_x;
									rel_pos2_y = rel_pos_y;
									rel_pos2 = 320 * normalize(rel_pos2);
									rel_pos_x = rel_pos2_x;
									rel_pos_y = rel_pos2_y;
								}

								if (self.weapon == IT_ROCKET_LAUNCHER)
								{
									self.state = self.state | SHOOT_GROUND;
									rel_pos_z = rel_pos_z - 38;
								}
							}
						}

						traceline(origin_ + '0 0 16', origin_ + '0 0 16' + rel_pos, FALSE, self);
						if (trace_fraction == 1)
						{
							if (try_shoot)
								self.state = self.state | CLEAR_SHOT;
						}
						else if (trace_ent == look_object_)
						{
							self.state = self.state | CLEAR_SHOT;
						}
						else if (trace_ent.client_)
						{
							if (realteam_ != trace_ent.realteam)
							{
								enemy_ = self.enemy = look_object_ = self.look_object = trace_ent;	// change enemy if necessary
								self.state = self.state | CLEAR_SHOT;
							}
						}

						desired_angle = vectoangles(rel_pos);
						if (desired_angle_x > 180)
							desired_angle_x = 360 - desired_angle_x;
						else
							desired_angle_x = 0 - desired_angle_x;
						if (self.state & HURT_SELF)
							desired_angle_x = 180;
						rel_dist = vlen(rel_pos);
						rel_dir = normalize(rel_pos);
						rel_hor_dir_x = rel_pos_x;
						rel_hor_dir_y = rel_pos_y;
						// ( rel_hor_dir_z = 0 )
						rel_hor_dir = normalize(rel_hor_dir);
						hor_component = rel_dir * rel_hor_dir;
						mouse_vel_ = self.mouse_vel / rel_dist;

						// rel_hor_dir and '0 0 1' are an orthogonal axis
						// hor_component is the rel_hor_dir (horizontal) component of rel_dir
						// rel_dir_z is the '0 0 1' (vertical) component of rel_dir

						pitch_tangent_ = rel_dir_z * rel_hor_dir;
						pitch_tangent__z = 0 - hor_component;

						// self.pitch_tangent is the tangent normal vector to pitch angular velocity

						self.pitch_tangent = pitch_tangent_ * mouse_vel_;

						// self.pitch_tangent has been scaled according to view object distance
						// self.mouse_vel is a skill factor from 0 to 1 (from skill 0 to skill 100)

						yaw_tangent__x = 0 - rel_hor_dir_y;
						yaw_tangent__y = rel_hor_dir_x;
						// ( yaw_tangent__z = 0 )

						// self.yaw_tangent is the tangent normal vector to yaw angular velocity

						self.yaw_tangent = yaw_tangent_ * mouse_vel_;

						// self.yaw_tangent has been scaled according to view object distance
						// self.mouse_vel is a skill factor from 0 to 1 (from skill 0 to skill 100)

						self.track_pitchspeed = look_object_.velocity * self.pitch_tangent;
						self.track_yawspeed = look_object_.velocity * self.yaw_tangent;

						if (look_object_ == enemy_)
						{
							if (self.state & CLEAR_SHOT)
							{
								if (self.weapon & IT_VELOCITY)
								{
									if (self.weapon & IT_GRENADE_LAUNCHER)
										rel_dist = rel_dist / 600;
									else
									{
										rel_dist = rel_dist / 1000;
										if (self.player_flag & ITEM_RUNE3_FLAG)
										{
											if (self.weapon & IT_EITHER_NAILGUN)
												rel_dist = rel_dist / 2;
										}
									}

									desired_angle_x = desired_angle_x + (self.track_pitchspeed * rel_dist);
									desired_angle_y = desired_angle_y + (self.track_yawspeed * rel_dist);
								}
							}
						}

						angle_error = desired_angle - self.v_angle;
						angle_error_x = angle_error_x - (self.pitchspeed * 0.1);
						angle_error_y = angle_error_y - (self.yawspeed * 0.1);

						if (angle_error_y >= 180)
							angle_error_y = angle_error_y - 360;
						else if (angle_error_y < -180)
							angle_error_y = angle_error_y + 360;

						self.pitchaccel = angle_error_x * self.mouse_accel;
						self.yawaccel = angle_error_y * self.mouse_accel;

						if (self.pitchaccel > 0)
							self.pitchaccel = self.pitchaccel + 5400;
						else if (self.pitchaccel < 0)
							self.pitchaccel = self.pitchaccel - 5400;

						if (self.yawaccel > 0)
							self.yawaccel = self.yawaccel + 5400;
						else if (self.yawaccel < 0)
							self.yawaccel = self.yawaccel - 5400;

					//
					// SelectWeapon
					//

						if (random() < 0.4)
							SelectWeapon();
					}
					else
					{
						if (time >= self.enemy_time)
						{
							enemy_ = world;
							realteam_ = self.realteam;
							touch_marker_ = self.touch_marker;
							origin_ = self.origin;
							BestEnemy();
						}
					}
				}
				else
				{
					if (self.flags & FL_FROGBOT)
					{
						self.look_object = self.linked_marker = self.old_linked_marker = self.goalentity = world;
						self.goal_refresh_time = 0;
						self.linked_marker_time = self.path_state = 0;
						self.state = self.state | AWARE_SURROUNDINGS;
					}
					else
					{
						if (markers_loaded)
						{
							self.goalentity = world;
							self.goal_refresh_time = 0;
							self.state = self.state | AWARE_SURROUNDINGS;
						}
					}
				}
			}
			else
			{
				if (self.flags & FL_FROGBOT)
				{
					self.button0_ = FALSE;
					if (random() < 0.5)
						self.button2 = FALSE;
					else
						self.button2 = TRUE;

					self.pitch_tangent = self.yaw_tangent = '0 0 0';
					self.arrow = self.track_pitchspeed = self.track_yawspeed = self.pitchaccel = self.yawaccel = 0;
				}
			}

			#ifdef MANUAL
				}
			#endif // MANUAL

		}

		if (self.flags & FL_FROGBOT)
		{
			if (self.takedamage)
			{
				if (time >= self.fire_nextthink)
				{
				// fire think every self.firing_reflex seconds

					self.fire_nextthink = self.fire_nextthink + self.firing_reflex;
					if (self.fire_nextthink <= time)
						self.fire_nextthink = time + self.firing_reflex;
					SetFireButton();
				}
				else
				{
					if (!(self.weapon & IT_CONTINUOUS))
						self.button0_ = FALSE;
				}
			}
			self.button0 = self.button0_;
		}
		self = self.next;
	}

	no_bots_stuck = TRUE;

	self = first_client;
	while (self)
	{
		if (!(self.flags & FL_PLAYER))
		{
			content1 = pointcontents(self.origin + '0 0 -24');
			if (content1 == CONTENT_EMPTY)
			{
				self.oldwaterlevel = 0;
				self.oldwatertype = CONTENT_EMPTY;
			}
			else if (content1 == CONTENT_SOLID)
			{
				unstick_time = unstick_time + real_frametime;
				if (unstick_time <= numberofclients)
				{
					no_bots_stuck = FALSE;
					self.velocity_z = JUMPSPEED;
				}
				else
					self.impulse = CLIENTKILL;
			}
			else
			{
				content2 = pointcontents(self.origin + '0 0 4');
				if (content2 == CONTENT_EMPTY)
				{
					self.oldwaterlevel = 1;
					self.oldwatertype = content1;
				}
				else
				{
					content3 = pointcontents(self.origin + '0 0 22');
					if (content3 == CONTENT_EMPTY)
					{
						self.oldwaterlevel = 2;
						self.oldwatertype = content2;
					}
					else
					{
						self.oldwaterlevel = 3;
						self.oldwatertype = content3;
					}
				}
			}

			if (self.takedamage)
			{
				PlayerPreThink_apply();

				if (self.flags & FL_ONGROUND)
				{
					if (self.velocity_z < 0)
						self.oldvelocity_z = self.velocity_z = 0;

					if (self.flags & FL_ONTRAIN)
						self.flags = (self.flags | FL_WASONGROUND) - FL_ONTRAIN;
					else
						self.flags = (self.flags | FL_WASONGROUND) - FL_ONGROUND;
				}
				else
				{
					if (self.velocity_z < -300)
						self.jump_flag = self.velocity_z;

					self.flags = self.flags & FL_NOT_WASONGROUND_ONTRAIN;
				}

				if ((self.oldwaterlevel >= 2) || (self.flags & FL_WATERJUMP))
					self.velocity_z = self.velocity_z + (800 * real_frametime);	// 800 = sv_gravity

				self.oldorigin = self.origin;
				self.waterlevel = self.watertype = 0;
			}
			else
			{
				if (!intermission_running)
				if (self.deadflag >= DEAD_DEAD)
					PlayerDeathThink ();
			}
		}

		self = self.next;
	}

	if (no_bots_stuck)
		unstick_time = 0;
};
