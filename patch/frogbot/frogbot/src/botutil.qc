/*
============
BestArrowForDirection

Precondition: makevectors(self.v_angle); must have been called beforehand
============
*/
void() BestArrowForDirection =
{
	best_dotproduct = best_arrow = 0;

	test_forward = v_forward * dir_move;
	if (test_forward > best_dotproduct)
	{
		best_dotproduct = test_forward;
		best_arrow = FORWARD;
	}

	test_forward_left = normalize(v_forward - (v_right * 0.875)) * dir_move;
	if (test_forward_left > best_dotproduct)
	{
		best_dotproduct = test_forward_left;
		best_arrow = FORWARD_LEFT;
	}

	test_forward_right = normalize(v_forward + (v_right * 0.875)) * dir_move;
	if (test_forward_right > best_dotproduct)
	{
		best_dotproduct = test_forward_right;
		best_arrow = FORWARD_RIGHT;
	}

	test_right = v_right * dir_move;
	if (test_right > best_dotproduct)
	{
		best_dotproduct = test_right;
		best_arrow = RIGHT;
	}

	test_left = 0 - test_right;
	if (test_left > best_dotproduct)
	{
		best_dotproduct = test_left;
		best_arrow = LEFT;
	}

#ifdef QUAKE
	if (time >= self.teleport_time)
	{
#endif // QUAKE
		test_back = 0 - test_forward;
		if (test_back > best_dotproduct)
		{
			best_dotproduct = test_back;
			best_arrow = BACK;
		}

		test_back_left = 0 - test_forward_right;
		if (test_back_left > best_dotproduct)
		{
			best_dotproduct = test_back_left;
			best_arrow = BACK_LEFT;
		}

		test_back_right = 0 - test_forward_left;
		if (test_back_right > best_dotproduct)
		{
			best_dotproduct = test_back_right;
			best_arrow = BACK_RIGHT;
		}
#ifdef QUAKE
	}
#endif // QUAKE
};

/*
============
NonTeleport

============
*/
void() NonTeleport =
{
	from_marker = visible_object.touch_marker;
	if (from_marker)
	{
		if (self.touch_marker)
		{
			self.touch_marker.zone_marker();
			return(middle_marker.touch != teleport_touch);
		}
	}
	return FALSE;
};

/*
============
Visible_360

============
*/
float() Visible_360 =
{
	if (visible_object.takedamage)
	{
		if (time < visible_object.invisible_finished)
		{
			if (time >= visible_object.attack_finished)
				return FALSE;	// invisible and not shooting
		}

		if (game_look_cheat)
		{
			if (NonTeleport())
				return TRUE;
		}

		traceline(self.origin + '0 0 22', visible_object.origin + '0 0 22', TRUE, self);
		if (trace_fraction == 1)
		{
			self.visible_object_time = time + 3;
			return TRUE;
		}
	}
	return FALSE;
};

/*
============
Visible_infront

120 degree fov
============
*/
float() Visible_infront =
{
	if (visible_object.takedamage)
	{
		if (time < visible_object.invisible_finished)
		{
			if (time >= visible_object.attack_finished)
				return FALSE;	// invisible and not shooting
		}

		if (game_look_cheat)
		{
			if (NonTeleport())
				return TRUE;
		}

		traceline(self.origin + '0 0 22', visible_object.origin + '0 0 22', TRUE, self);
		if (trace_fraction == 1)
		{
			makevectors(self.v_angle);
			if ((v_forward * normalize(visible_object.origin - self.origin)) > 0.5)
			{
				self.visible_object_time = time + 3;
				return TRUE;
			}
			if (time < self.visible_object_time)
			{
				self.visible_object_time = time + 3;
				return TRUE;
			}
		}
	}
	return FALSE;
};

/*
============
FallSpot

============
*/
void() FallSpot =
{
	fallspot_self = self;
	self = dropper;
	self.origin = testplace;

	if (!(droptofloor()))
	{
		platform.solid = SOLID_SLIDEBOX;
		setorigin(platform, testplace + '0 0 -1');
		if (droptofloor())
		{
			platform.solid = SOLID_NOT;
			self.origin = testplace + '0 0 -256';
			if (!(droptofloor()))
			{
				fall = FALL_DEATH;	// too far to fall (no need further check)
				self = fallspot_self;
				return;
			}
		}
		else
		{
			platform.solid = SOLID_NOT;
			fall = FALL_BLOCKED;
			self = fallspot_self;
			return;
		}
	}

	content = pointcontents(self.origin + '0 0 -24');

	if (content == CONTENT_LAVA)
		fall = FALL_DEATH;
	else if (self.origin_z < fallheight)
		fall = FALL_LAND;
	else
		fall = FALL_FALSE;
	self = fallspot_self;
};

/*
============
TestTopBlock

============
*/
void() TestTopBlock =
{
	traceline(last_clear_point + '-16 -16 32', testplace + '-16 -16 32', TRUE, self);
	if (trace_fraction != 1)
	{
		if (trace_plane_normal_z <= 0)
		{
			if (first_trace_fraction > trace_fraction)
			{
				first_trace_fraction = trace_fraction;
				first_trace_plane_normal = trace_plane_normal;
			}
		}
	}

	traceline(last_clear_point + '16 -16 32', testplace + '16 -16 32', TRUE, self);
	if (trace_fraction != 1)
	{
		if (trace_plane_normal_z <= 0)
		{
			if (first_trace_fraction > trace_fraction)
			{
				first_trace_fraction = trace_fraction;
				first_trace_plane_normal = trace_plane_normal;
			}
		}
	}

	traceline(last_clear_point + '-16 16 32', testplace + '-16 16 32', TRUE, self);
	if (trace_fraction != 1)
	{
		if (trace_plane_normal_z <= 0)
		{
			if (first_trace_fraction > trace_fraction)
			{
				first_trace_fraction = trace_fraction;
				first_trace_plane_normal = trace_plane_normal;
			}
		}
	}

	traceline(last_clear_point + '16 16 32', testplace + '16 16 32', TRUE, self);
	if (trace_fraction != 1)
	{
		if (trace_plane_normal_z <= 0)
		{
			if (first_trace_fraction > trace_fraction)
			{
				first_trace_fraction = trace_fraction;
				first_trace_plane_normal = trace_plane_normal;
			}
		}
	}
};

/*
============
TestBottomBlock

============
*/
void() TestBottomBlock =
{
	traceline(last_clear_point + '-16 -16 -24', testplace + '-16 -16 -24', TRUE, self);
	if (trace_fraction != 1)
	{
		if (trace_plane_normal_z >= 0)
		{
			if (first_trace_fraction > trace_fraction)
			{
				first_trace_fraction = trace_fraction;
				first_trace_plane_normal = trace_plane_normal;
			}
		}
	}

	traceline(last_clear_point + '16 -16 -24', testplace + '16 -16 -24', TRUE, self);
	if (trace_fraction != 1)
	{
		if (trace_plane_normal_z >= 0)
		{
			if (first_trace_fraction > trace_fraction)
			{
				first_trace_fraction = trace_fraction;
				first_trace_plane_normal = trace_plane_normal;
			}
		}
	}

	traceline(last_clear_point + '-16 16 -24', testplace + '-16 16 -24', TRUE, self);
	if (trace_fraction != 1)
	{
		if (trace_plane_normal_z >= 0)
		{
			if (first_trace_fraction > trace_fraction)
			{
				first_trace_fraction = trace_fraction;
				first_trace_plane_normal = trace_plane_normal;
			}
		}
	}

	traceline(last_clear_point + '16 16 -24', testplace + '16 16 -24', TRUE, self);
	if (trace_fraction != 1)
	{
		if (trace_plane_normal_z >= 0)
		{
			if (first_trace_fraction > trace_fraction)
			{
				first_trace_fraction = trace_fraction;
				first_trace_plane_normal = trace_plane_normal;
			}
		}
	}
};

/*
============
CanJumpOver

============
*/
float() CanJumpOver =
{
	tries = 0;
	dist_inc = 32;
	last_clear_point = new_origin;
	last_clear_velocity = new_velocity;
	last_clear_hor_speed = hor_speed;
	last_clear_velocity_z = new_velocity_z - (12800 / last_clear_hor_speed);	// 12800 = sv_gravity * 16

	while ((tries < 20) && (last_clear_point_z >= fallheight))
	{
		testplace = last_clear_point + (last_clear_velocity * (dist_inc / last_clear_hor_speed));

/*
		local entity marker;
		marker = spawn();
		setmodel (marker, "progs/player.mdl");
		setorigin(marker, testplace);
*/

		FallSpot();

		if (fall == FALL_BLOCKED)
		{
			first_trace_fraction = 1;
			TestTopBlock();
			TestBottomBlock();

			if (first_trace_fraction != 1)
			{
				testplace = last_clear_point + (last_clear_velocity * (first_trace_fraction * dist_inc / last_clear_hor_speed));
				last_clear_velocity = last_clear_velocity - (first_trace_plane_normal * (first_trace_plane_normal * last_clear_velocity));
				hor_velocity = last_clear_velocity;
				hor_velocity_z = 0;
				last_clear_hor_speed = vlen(hor_velocity);
				testplace = testplace + (last_clear_velocity * (dist_inc / last_clear_hor_speed) * (1 - first_trace_fraction));
			}

			FallSpot();
		}

		if (fall == FALL_BLOCKED)
		{
			if ((dist_inc == 8) || (!tries))
				return FALSE;
			dist_inc = 8;
			last_clear_velocity_z = last_clear_velocity_z + (9600 / last_clear_hor_speed);	// 9600 = sv_gravity * 12
		}
		else
		{
			if (fall > current_fallspot)
			{
				last_clear_velocity_z = last_clear_velocity_z - (800 * dist_inc / last_clear_hor_speed);	// 800 = sv_gravity
				last_clear_point = testplace;
			}
			else
			{
				do_jump = TRUE;

				if (self.flags & FL_ONGROUND)
				{
					// Restore_Obstacles

					test_enemy = first_client;
					while (test_enemy)
					{
						test_enemy.solid = test_enemy.oldsolid;
						test_enemy = test_enemy.next;
					}

					test_enemy = findradius(testplace, 84);
					while (test_enemy)
					{
						if (test_enemy.T & UNREACHABLE)	// includes clients and self
						{
							test_enemy = world;	// exit loop
							do_jump = FALSE;
						}
						test_enemy = test_enemy.chain;
					}

					// Remove_Obstacles
					test_enemy = first_client;
					while (test_enemy)
					{
						test_enemy.solid = SOLID_NOT;
						test_enemy = test_enemy.next;
					}
				}

				return do_jump;
			}
		}

		if (turning_speed)
		{
			last_clear_angle = vectoangles(last_clear_velocity);
			last_clear_angle_x = 0 - last_clear_angle_x;
			last_clear_angle_y = last_clear_angle_y + (turning_speed * dist_inc / last_clear_hor_speed);
			makevectors(last_clear_angle);
			last_clear_velocity = v_forward * vlen(last_clear_velocity);
		}

		tries = tries + 1;
	}

	return FALSE;
};
