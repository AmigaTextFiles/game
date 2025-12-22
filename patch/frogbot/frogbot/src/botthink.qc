void() RunAlongEdge;
void() AvoidEdge;

#ifdef MANUAL

void() MarkerDisplay;
void(entity marker) manual_marker_touch;
void() FrogbotManual;

#endif // MANUAL


/*
============
NewVelocityForArrow

============
*/
void() NewVelocityForArrow =
{
	if (self.arrow != best_arrow)
	{
		self.arrow_time = time + 0.15;
		self.arrow = best_arrow;
		self.velocity = oldvelocity_;
		VelocityForArrow();
	}
};

/*
============
AvoidHazards

============
*/
void() AvoidHazards =
{
	new_velocity = self.velocity;

	if (self.path_state & JUMP_LEDGE)
	{
		if (time > self.arrow_time2)
		if (self.flags & FL_ONGROUND)
		{
			rel_pos = (self.linked_marker.absmin + self.linked_marker.view_ofs) - self.origin;

			if (rel_pos_z > 18)
			{
				hor_normal_vec_x = 0 - rel_pos_y;
				hor_normal_vec_y = rel_pos_x;
				hor_normal_vec = normalize(hor_normal_vec);

				jumpspeed = new_velocity_z + JUMPSPEED;

				if ((jumpspeed * jumpspeed * 0.000625) >= rel_pos_z)	// 0.000625 = 0.5 / sv_gravity
				{
					self.button2 = TRUE;
					return;
				}
			}
		}
	}
	else if (self.obstruction_normal != '0 0 0')
	{
		if (time > self.arrow_time)
		{
			if (self.flags & FL_WATERJUMP)
				return;

			if (vlen(oldvelocity_) <= 32)
			{
				dir_move = new_velocity - (self.obstruction_normal * (self.obstruction_normal * new_velocity));

				if ((dir_move_x == 0) && (dir_move_y == 0))
					dir_move = (-1) * self.obstruction_normal;
				else if ((oldvelocity__x == 0) && (oldvelocity__y == 0))
				{
				// maybe stuck in a corner
					if (random() < 0.5)
						dir_move = (-1) * dir_move;
				}
				else
				{
					dir_move = normalize(dir_move);
					dir_move = dir_move + normalize(new_velocity);
				}

				dir_move_z = 0;
				makevectors(self.v_angle);
				BestArrowForDirection();
				NewVelocityForArrow();
			}
		}

		new_velocity = new_velocity - (self.obstruction_normal * (self.obstruction_normal * new_velocity));
	}

	if (self.waterlevel)
		return;

	hor_velocity = new_velocity;
	hor_velocity_z = 0;
	hor_speed = vlen(hor_velocity);
	if (!hor_speed)
		return;
	dir_forward = normalize(hor_velocity);

	fallheight = self.origin_z - 36;

	if (self.linked_marker)
	{
		min_second = self.linked_marker.absmin_z + self.linked_marker.view_ofs_z - 36;
		if (fallheight > min_second)
			fallheight = min_second;
	}

	if (self.flags & FL_ONGROUND)
	{
		if (new_velocity_z < 0)
			new_velocity_z = 0;

		last_clear_point = self.origin + '0 0 18';
		testplace = last_clear_point + new_velocity * (16 / hor_speed);
		FallSpot();

		if (fall == FALL_BLOCKED)
		{
			first_trace_fraction = 1;
			TestTopBlock();

			if (first_trace_fraction != 1)
			{
				testplace = last_clear_point + new_velocity * (16 / hor_speed) * first_trace_fraction;
				new_velocity = new_velocity - (first_trace_plane_normal * (first_trace_plane_normal * new_velocity));
				hor_velocity = new_velocity;
				hor_velocity_z = 0;
				hor_speed = vlen(hor_velocity);
				testplace = testplace + (new_velocity * (16 / hor_speed) * (1 - first_trace_fraction));
			}

			FallSpot();
		}

		if (fall >= FALL_LAND)
		{
			new_fall = fall;
			testplace = self.origin;
			FallSpot();
			if (new_fall > fall)
			{
				if (time > self.arrow_time2)
				{
					current_fallspot = fall;
					new_origin = self.origin;
					if (CanJumpOver())
						return;
					new_velocity_z = new_velocity_z + JUMPSPEED;
					if (CanJumpOver())
					{
						self.button2 = TRUE;
						return;
					}
				}

				AvoidEdge();
			}
			return;
		}

		testplace = testplace + new_velocity * (16 / hor_speed);
		FallSpot();
		if (fall >= FALL_LAND)
		{
			new_fall = fall;
			new_origin = testplace - '0 0 18';
			testplace = self.origin;
			FallSpot();
			if (new_fall > fall)
				RunAlongEdge();
		}
	}
	else
	{
		new_origin = self.origin;
		testplace = new_origin + new_velocity * (32 / hor_speed);
		FallSpot();
		if (fall >= FALL_LAND)
		{
			new_fall = fall;
			testplace = new_origin;
			FallSpot();
			if (new_fall > fall)
			{
				testplace = new_origin + new_velocity * (16 / hor_speed);
				FallSpot();
				if (new_fall > fall)
				{
					current_fallspot = fall;
					if (CanJumpOver())
						return;

					AvoidEdge();
				}
			}
		}
	}
};

/*
============
AvoidEdge

============
*/
void() AvoidEdge =
{
	dir_forward = oldvelocity_;
	dir_forward_z = 0;

	if (dir_forward != '0 0 0')
	{
		if (game_lava_cheat)
			oldvelocity__x = oldvelocity__y = 0;
		dir_move = (-1) * dir_forward;
		makevectors(self.v_angle);
		BestArrowForDirection();
		NewVelocityForArrow();
		self.arrow_time2 = self.arrow_time;
	}
};

/*
============
RunAlongEdge

============
*/
void() RunAlongEdge =
{
	if (time > self.arrow_time2)
	{
		current_fallspot = fall;
		if (CanJumpOver())
			return;
		new_velocity_z = new_velocity_z + JUMPSPEED;
		if (CanJumpOver())
			return;
	}

	traceline(self.origin + (dir_forward * 32) + '0 0 -24.1', self.origin - (dir_forward * 16) + '0 0 -24.1', TRUE, world);
	trace_plane_normal_z = 0;

	if (trace_plane_normal == '0 0 0')
	{
		AvoidEdge();
		return;
	}
	else
		edge_normal = normalize(trace_plane_normal);

	normal_comp = edge_normal * dir_forward;

	if (normal_comp <= 0)
	{
		AvoidEdge();
		return;
	}

	dir_move = dir_forward - (2 * edge_normal * normal_comp);
	dir_move_z = 0;
	makevectors(self.v_angle);
	BestArrowForDirection();
	NewVelocityForArrow();
	if (normal_comp > 0.5)
		self.arrow_time2 = self.arrow_time;
};
