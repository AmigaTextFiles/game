/*
============
obstruction

Sets self.obstruction_normal to be horizontal normal direction into wall obstruction encountered
during quake physics (ie. between PlayerPreThink and PlayerPostThink)
============
*/
void() obstruction =
{
	if (fabs(self.velocity_x - self.oldvelocity_x) < 0.1)
	{
		if (fabs(self.velocity_y - self.oldvelocity_y) < 0.1)
		{
			self.obstruction_normal = '0 0 0';
			return;
		}
	}
	if ((self.flags & FL_ONGROUND) || (self.waterlevel >= 2) || (self.flags & FL_WATERJUMP))
	{
		if (fabs(self.velocity_z - self.oldvelocity_z) >= 0.1)
		{
			self.obstruction_normal = '0 0 0';
			return;
		}
	}
	else
	{
		if (fabs(self.velocity_z + (800 * real_frametime) - self.oldvelocity_z) >= 0.1)	// 800 = sv_gravity
		{
			self.obstruction_normal = '0 0 0';
			return;
		}
	}

	hor_velocity = self.velocity;
	hor_velocity_z = 0;

	if (hor_velocity != '0 0 0')
	{
		if (self.flags & FL_PLAYER)
		{
			hor_direction = normalize(hor_velocity);
			hor_velocity = hor_direction * (hor_direction * self.oldvelocity);
			self.velocity_x = hor_velocity_x;
			self.velocity_y = hor_velocity_y;
		}

		self.velocity_normal = self.oldvelocity - hor_velocity;
		self.velocity_normal_z = 0;
		self.obstruction_normal = normalize(self.velocity_normal);
	}
	else
	{
		hor_velocity = self.oldvelocity;
		hor_velocity_z = 0;
		if (hor_velocity != '0 0 0')
		{
			self.velocity_normal = self.oldvelocity - (self.obstruction_normal * (self.obstruction_normal * self.oldvelocity));
			self.velocity_normal_z = 0;
			self.obstruction_normal = normalize(self.velocity_normal);
		}
		else
			self.obstruction_normal = '0 0 0';
	}
};

/*
============
VelocityForArrow

self is a Frogbot.
Sets self.velocity according to current state and the value of self.arrow.
============
*/
void() VelocityForArrow =
{
	turning_speed = 0;

#ifdef QUAKE
	if (time >= self.teleport_time)
	{
#endif // QUAKE

		// first check air circle turning
		if (self.path_state & DIFFICULT)
		if (!self.waterlevel)
		{
			if (time > self.arrow_time2)
			{
				hor_normal_vec_x = 0 - self.velocity_y;
				hor_normal_vec_y = self.velocity_x;
				// (hor_normal_vec_z = 0;)
				hor_normal_vec = normalize(hor_normal_vec);

				rel_pos = (self.linked_marker.absmin + self.linked_marker.view_ofs) - self.origin;
				rel_pos_z = 0;

				hor_velocity = self.velocity;
				hor_velocity_z = 0;
				hor_speed = vlen(hor_velocity);

				radian_turning_speed = 2 * hor_speed * (rel_pos * hor_normal_vec) / (rel_pos * rel_pos);

				turning_speed = 57.29578 * radian_turning_speed;	// 57.29578 = 180 / PI

				if (!(self.flags & FL_ONGROUND))
				{
					velocity_hor_angle_y = vectoyaw(hor_velocity) + (turning_speed * real_frametime);
					makevectors(velocity_hor_angle);

					desired_accel = (v_forward * hor_speed) - hor_velocity;

					dir_forward = normalize(desired_accel);
					accel_forward = vlen(desired_accel);
					max_accel_forward = sv_accelerate_frametime * sv_maxspeed;

					if (accel_forward > max_accel_forward)
						accel_forward = max_accel_forward;

					velocity_forward = self.velocity * dir_forward;

					if ((velocity_forward + accel_forward) > 30)
					{
						accel_forward = 30 - velocity_forward;
						if (accel_forward < 0)
							accel_forward = 0;
					}

					self.velocity = self.velocity + (accel_forward * dir_forward);
					return;
				}
			}
		}

		arrow_ = self.arrow;
#ifdef QUAKE
	}
	else
	{
		if (self.flags & FL_WATERJUMP)
			return;
		arrow_ = self.arrow - (self.arrow & BACK);
	}
#endif // QUAKE

	if (!arrow_)
	{
		if (self.waterlevel <= 1)
		{
			return;
		}
		else
		{
			if (self.swim_arrow)
			{
				if (self.swim_arrow == UP)
					dir_forward = '0 0 1';
				else
					dir_forward = '0 0 -1';

				current_maxspeed = 200;
			}
			else
			{
				dir_forward = '0 0 -1';
				current_maxspeed = 42;
			}
		}
	}
	else
	{
		makevectors(self.v_angle);

		if (arrow_ & FORWARD)
		{
			if (arrow_ == FORWARD)
				dir_forward = v_forward;
			else if (arrow_ == FORWARD_LEFT)
				dir_forward = (v_forward * 0.7525767) - (v_right * 0.6585046);
			else	// (arrow_ == FORWARD_RIGHT)
				dir_forward = (v_forward * 0.7525767) + (v_right * 0.6585046);

			current_maxspeed = sv_maxspeed;
		}
		else if (arrow_ & BACK)
		{
			if (arrow_ == BACK)
				dir_forward = '0 0 0' - v_forward;
			else if (arrow_ == BACK_LEFT)
				dir_forward = '0 0 0' - (v_forward * 0.7525767) - (v_right * 0.6585046);
			else	// (arrow_ == BACK_RIGHT)
				dir_forward = (v_right * 0.6585046) - (v_forward * 0.7525767);

			current_maxspeed = sv_maxspeed;
		}
		else
		{
			if (arrow_ == LEFT)
				dir_forward = '0 0 0' - v_right;
			else	// (arrow_ == RIGHT)
				dir_forward = v_right;

			current_maxspeed = sv_maxstrafespeed;
		}

		if (self.waterlevel <= 1)
		{
			dir_forward_z = 0;
			dir_forward = normalize(dir_forward);
		}
		else
		{
			if (self.swim_arrow)
			{
				if (self.swim_arrow == UP)
					dir_forward = normalize(dir_forward + '0 0 0.5');
				else
					dir_forward = normalize(dir_forward + '0 0 -0.5');
			}

			current_maxspeed = 0.7 * current_maxspeed;
		}
	}

	accel_forward = sv_accelerate_frametime * current_maxspeed;

	velocity_forward = self.velocity * dir_forward;

	if (!(self.flags & FL_ONGROUND))
		if (self.waterlevel <= 1)
			if (current_maxspeed > 30)
				current_maxspeed = 30;

	if ((velocity_forward + accel_forward) > (current_maxspeed))
	{
		accel_forward = current_maxspeed - velocity_forward;
		if (accel_forward < 0)
			accel_forward = 0;
	}

	self.velocity = self.velocity + (accel_forward * dir_forward);
};

#ifdef QUAKE
/*
============
DoubleFriction

============
*/
float() DoubleFriction =
{
	if (self.waterlevel <= 1)
	{
		if (self.flags & FL_ONGROUND)
		{
			if (!(checkbottom(self)))
			{
				test_point = self.origin + '0 0 -25' + normalize(self.postvelocity) * 16;
				return (pointcontents(test_point) != CONTENT_SOLID);
			}
		}
	}
	return FALSE;
};
#endif // QUAKE

/*
============
DoFriction

============
*/
void() DoFriction =
{
	if (self.flags & FL_ONGROUND)
	{
		hor_velocity = self.velocity;
		hor_velocity_z = 0;
		hor_speed = vlen(hor_velocity);

		// sv_stopspeed = 100

	#ifdef QUAKE
		if (hor_speed <= 100)
		{
			if (double_friction)
			{
				if (hor_speed > sv_friction_frametime_200)
					self.velocity = self.velocity - self.velocity * (sv_friction_frametime_200 / hor_speed);
				else
					self.velocity = '0 0 0';
			}
			else
			{
				if (hor_speed > sv_friction_frametime_100)
					self.velocity = self.velocity - self.velocity * (sv_friction_frametime_100 / hor_speed);
				else
					self.velocity = '0 0 0';
			}
		}
		else
		{
			if (double_friction)
				self.velocity = self.velocity * inv_sv_friction_framtime_2;
			else
				self.velocity = self.velocity * inv_sv_friction_framtime;
		}
	#endif // QUAKE

	#ifdef QUAKEWORLD
		if (hor_speed <= 100)
		{
			if (hor_speed > sv_friction_frametime_100)
				self.velocity = self.velocity - self.velocity * (sv_friction_frametime_100 / hor_speed);
			else
				self.velocity = '0 0 0';
		}
		else
			self.velocity = self.velocity * inv_sv_friction_framtime;
	#endif // QUAKEWORLD
	}
};

/*
============
thud_touch

Stops thud landing sound
============
*/
void() thud_touch =
{
	if (self.flags & FL_WASONGROUND)
		return;
	if (self.flags & FL_ONGROUND)
		self.flags = (self.flags | FL_THUD) - FL_ONGROUND;
};

/*
============
FrogbotPostPhysics

============
*/
void() FrogbotPostPhysics =
{
	self = first_client;
	while (self)
	{
		if (self.movetype == MOVETYPE_STEP)
		{
			if (self.flags & FL_THUD)
				self.flags = (self.flags | FL_ONGROUND) - FL_THUD;

			self.waterlevel = self.oldwaterlevel;
			self.watertype = self.oldwatertype;
			obstruction();

			//
			// CheckStep
			//

			if (self.obstruction_normal != '0 0 0')
			{
				if ((self.flags & FL_WASONGROUND) || (self.waterlevel <= 1))
				{
					new_velocity = self.velocity + self.velocity_normal;
					yaw = vectoyaw(self.obstruction_normal);
					dist = ((new_velocity * real_frametime) - (self.origin - self.oldorigin)) * self.obstruction_normal;
					oldflags = self.flags;
					self.flags = self.flags | FL_ONGROUND_PARTIALGROUND;
					if (walkmove(yaw, dist))
					{
						self.velocity = new_velocity;
						self.velocity_z = 0;
						self.obstruction_normal = '0 0 0';
					}
					else
						self.flags = oldflags;
				}
			}

			PlayerPostThink_apply();
		}

	#ifdef QUAKE
		self_aiment = self.aiment;
		if (self_aiment.modelindex)
		{
			setorigin(self_aiment, self.origin);
			self_aiment.angles = self.angles;
			self_aiment.frame = self.frame;
		}
	#endif // QUAKE

	#ifdef QUAKEWORLD
		if (game_qizmo)
		{
			if (!(self.flags & FL_PLAYER))
				SetPlayerInfo();
		}
	#endif // QUAKEWORLD

		self = self.next;
	}

#ifdef QUAKE
	self = first_bodyque;
	while (self)
	{
		self_aiment = self.aiment;
		if (self_aiment.modelindex > 1)
			setorigin(self_aiment, self.origin);
		self = self.next;
	}

	self = first_kascam;
	while (self)
	{
		CamThink();
		self = self.next;
	}
#endif // QUAKE
};
