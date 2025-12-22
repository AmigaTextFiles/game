/*
============
centerprint_all

============
*/
/*
void(string s) centerprint_all =
{
	msg_entity = find(world, classname, "player");
	while (msg_entity)
	{
		centerprint(msg_entity, s);
		msg_entity = find(msg_entity, classname, "player");
	}
};
*/

/*
============
DoCountDown

============
*/
void() DoCountDown =
{
	msg_level = PRINT_HIGH;
	if (real_time < 0)
	{
		if (real_time == -15)
			bprint("match starts in 15 seconds\n");
		else
		{
			bprint_ftos(0 - real_time);
			bprint("\n");
		}
		return;
	}

	if (real_time > 0)
	{
		time_left = timelimit - real_time;
		if (time_left <= 0)
			return;
		if (time_left <= 15)
		{
			if (time_left == 15)
				bprint("match ends in 15 seconds\n");
			else
			{
				bprint_ftos(time_left);
				bprint("\n");
			}
			return;
		}
		minutes_left = floor(time_left / 60);
		if (time_left == (minutes_left * 60))
		{
			bprint_ftos(minutes_left);
			bprint(" minute");
			if (minutes_left != 1)
				bprint("s");
			bprint(" remaining\n");
		}
		return;
	}

	self = find(world, classname, "missile");
	while (self)
	{
		remove();
		self = find(self, classname, "missile");
	}

	self = first_item;
	while (self)
	{
		self.think();
		self = self.next;
	}

	SpawnRunes();

	self = first_client;
	while (self)
	{
		ForceGib();
		self = self.next;
	}

	self = find(world, classname, "door");
	while (self)
	{
		setorigin (self, self.oldorigin);
		if (self.netname != "")
		{
			self.target = self.netname;
			self.nextthink = self.ltime + 0.1;
			self.think = train_next;
		}
		else
		{
			if (self.max_health)
			{
				self.health = self.max_health;
				self.takedamage = DAMAGE_YES;
				if (self.th_die == fd_secret_use)
					self.th_pain = fd_secret_use;
			}
			self.frame = 0;			// use normal textures (buttons)
			self.state = STATE_BOTTOM;	// non-secret doors/plats
			self.nextthink = 0;
		}
		self = find(self, classname, "door");
	}

	GameSettings();

	bprint("The match has begun!\n");
};

/*
============
ReadyTyped

============
*/
void() ReadyTyped =
{
	if (pre_game)
	{
		if (start_time)
			return;
		start_time = check_parm_time + 15;
	}
};

/*
============
MatchStartItem

============
*/
void() MatchStartItem =
{
	self.nextthink = 0;
	self.think = SUB_regen;
	AssignVirtualGoal();
};

/*
============
GameSettings

============
*/
void() GameSettings =
{
	pre_game = FALSE;

	if (deathmatch != 4)
		use_ammo = TRUE;
};
