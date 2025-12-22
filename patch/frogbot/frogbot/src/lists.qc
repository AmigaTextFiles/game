void() thud_touch;
void() FrogbotPostPhysics;
void() LoadMarkers;

#ifdef QUAKEWORLD
void(float to, entity client) WriteQWSkin;
#endif // QUAKEWORLD

/*
============
Add_client

============
*/
entity(entity first_in_list) AddToList =
{
	self.next = first_in_list;
	self.previous = first_in_list.previous;
	if (first_in_list)
	{
		if (first_in_list.previous)
			first_in_list.previous.next = self;
		first_in_list.previous = self;
	}
	return self;
};

entity(entity first_in_list) RemoveFromList =
{
	if (first_in_list == self)
		first_in_list = first_in_list.next;
	if (self.previous)
		self.previous.next = self.next;
	if (self.next)
		self.next.previous = self.previous;
	return first_in_list;
};

void() Add_takedamage =
{
	self.takedamage = DAMAGE_YES;
	first_takedamage = AddToList(first_takedamage);
	takedamage_exists = TRUE;
};

void() UpdateRadiusDamage =
{
	if (takedamage_exists)
	{
		if (numberofclients)
			return;
		test_enemy = first_takedamage;
		while (test_enemy.next)
			test_enemy = test_enemy.next;
		test_enemy.next = first_client;
		first_client.previous = test_enemy;
	}
	else
	{
		first_takedamage = first_client;
	}
};

void() Add_client =
{
	if (self.client_)
		return;

	self.client_ = TRUE;
	self.flags = self.flags | FL_CLIENT;

	first_client = AddToList(first_client);
	UpdateRadiusDamage();
	numberofclients = numberofclients + 1;

	if (teamplay)
		self.realteam = self.team;
	else
	{
		current_team = current_team + 1;
		self.realteam = current_team;
	}
};

void() RemoveFromAllLists =
{
	if (self.client_)
	{

#ifdef QUAKE
		other = first_kascam;
		while (other)
		{
			if (other.enemy == self)
			{
				lists_self = self;
				self = other;
				CamGoIdle();
				self = lists_self;
			}
			if (other.movetarget == self)
				other.movetarget = world;
			other = other.next;
		}
#endif // QUAKE

		self.client_ = FALSE;
		self.flags = self.flags - FL_CLIENT - (self.flags & FL_FROGBOT);
		first_client = RemoveFromList(first_client);
		UpdateRadiusDamage();
		numberofclients = numberofclients - 1;
	}

#ifdef QUAKE
	if (self.flags & FL_KASCAM)
	{
		self.flags = self.flags - FL_KASCAM;
		first_kascam = RemoveFromList(first_kascam);
	}
#endif // QUAKE
};

/*
============
EntityAt

============
*/
entity(entity start_entity, float index_) EntityAt =
{
	test_enemy = start_entity;
	while (index_ > 0)
	{
		test_enemy = nextent(test_enemy);
		index_ = index_ - 1;
	}
	return test_enemy;
};

/*
============
InitFrogbots

============
*/
void() InitFrogbots =
{
	frogbot_number = 0;
	while (frogbot_number < maxplayers)
	{
		new_bot = spawn();
		if (!first_frogbot)
			first_frogbot = new_bot;
		new_bot.score_pos = frogbot_number;
		frogbot_number = frogbot_number + 1;
		new_bot.colormap = frogbot_number;
	}

	postphysics = frogbot_spawned = spawn();
	postphysics.think = FrogbotPostPhysics;

	test_enemy = find(world, classname, "path_corner");
	while (test_enemy)
	{
		if (!test_enemy.admin_code)
			remove_apply(test_enemy);
		test_enemy = find(test_enemy, classname, "path_corner");
	}

	SpawnRunes();

	LoadMarkers();
};

/*
============
UpdateFrags

============
*/
void(entity e) UpdateFrags =
{
	if (fraglimit)
		if (e.frags >= fraglimit)
			NextLevel ();

	if (e.flags & FL_PLAYER)
		return;

	WriteByte(MSG_ALL, MSG_UPDATEFRAGS);
	WriteByte(MSG_ALL, e.score_pos);
	WriteShort(MSG_ALL, e.frags);
};

/*
============
ClearName

============
*/
void(float to, entity client) ClearName =
{
#ifdef QUAKE
	WriteByte(to, MSG_UPDATENAME);
	WriteByte(to, client.score_pos);
	WriteByte(to, 0);
#endif // QUAKE

#ifdef QUAKEWORLD
	WriteByte(to, SVC_UPDATEUSERINFO);            // update userinfo
	WriteByte(to, client.score_pos);      // client number
	WriteLong(to, 0);      // client userid

	WriteByte(to, 92); // \
	WriteByte(to, _n);
	WriteByte(to, _a);
	WriteByte(to, _m);
	WriteByte(to, _e);
	WriteByte(to, 92); // \

	WriteByte(to, 0);
#endif // QUAKEWORLD
};

/*
============
SetColorName

============
*/
void(float to, entity client) SetColorName =
{
#ifdef QUAKEWORLD
	WriteByte(to, SVC_UPDATEPING);            // update ping
	WriteByte(to, self.score_pos);      // client number
	WriteShort(to, 0);   // client ping

	WriteByte(to, SVC_UPDATETIME);	// update time
	WriteByte(to, self.score_pos);      // client number
	WriteLong(to, time);   // client enter time
#endif // QUAKEWORLD

#ifdef QUAKE
	WriteByte(to, MSG_UPDATECOLORS);
	WriteByte(to, client.score_pos);
	WriteByte(to, client.color_);
	WriteByte(to, MSG_UPDATENAME);
	WriteByte(to, client.score_pos);
	WriteName(to, client);
#endif // QUAKE

#ifdef QUAKEWORLD
	clientshirt = floor(client.color_ / 16);
	clientpants = client.color_ - (clientshirt * 16);

	WriteByte(to, SVC_UPDATEUSERINFO);            // update userinfo
	WriteByte(to, client.score_pos);      // client number
	WriteLong(to, 0);      // client userid

	WriteByte(to, 92); // \
	WriteByte(to, _b);
	WriteByte(to, _o);
	WriteByte(to, _t);
	WriteByte(to, _t);
	WriteByte(to, _o);
	WriteByte(to, _m);
	WriteByte(to, _c);
	WriteByte(to, _o);
	WriteByte(to, _l);
	WriteByte(to, _o);
	WriteByte(to, _r);
	WriteByte(to, 92); // \

	if (clientpants > 9)
	{
		WriteByte(to, 49);
		WriteByte(to, 38 + clientpants);
	}
	else
		WriteByte(to, 48 + clientpants);

	WriteByte(to, 92); // \
	WriteByte(to, _t);
	WriteByte(to, _o);
	WriteByte(to, _p);
	WriteByte(to, _c);
	WriteByte(to, _o);
	WriteByte(to, _l);
	WriteByte(to, _o);
	WriteByte(to, _r);
	WriteByte(to, 92); // \

	if (clientshirt > 9)
	{
		WriteByte(to, 49);
		WriteByte(to, 38 + clientshirt);
	}
	else
		WriteByte(to, 48 + clientshirt);

	WriteByte(to, 92); // \
	WriteByte(to, _t);
	WriteByte(to, _e);
	WriteByte(to, _a);
	WriteByte(to, _m);
	WriteByte(to, 92); // \

	WriteByte(to, 92); // \
	WriteByte(to, _s);
	WriteByte(to, _k);
	WriteByte(to, _i);
	WriteByte(to, _n);
	WriteByte(to, 92); // \
	WriteQWSkin(to, client);
	WriteByte(to, 92); // \
	WriteByte(to, _n);
	WriteByte(to, _a);
	WriteByte(to, _m);
	WriteByte(to, _e);
	WriteByte(to, 92); // \

	WriteName(to, client);
#endif // QUAKEWORLD
};

/*
============
SetScoreboard

============
*/
void() SetScoreboard =
{
	msg_entity = self;
	msg_level = PRINT_HIGH;
	score_count = 0;
	
	test_enemy = other.enemy;
	while (score_count < SPAWN_SIZE)
	{
		if (test_enemy.flags & FL_FROGBOT)
		{
		#ifdef QUAKEWORLD
			WriteByte(MSG_ONE, SVC_UPDATEPING);            // update ping
			WriteByte(MSG_ONE, test_enemy.score_pos);      // client number
			WriteShort(MSG_ONE, 0);   // client ping

			WriteByte(MSG_ONE, SVC_UPDATETIME);	// update time
			WriteByte(MSG_ONE, self.score_pos);      // client number
			WriteLong(MSG_ONE, time);   // client enter time
		#endif // QUAKEWORLD

			WriteByte(MSG_ONE, MSG_UPDATEFRAGS);
			WriteByte(MSG_ONE, test_enemy.score_pos);
			WriteShort(MSG_ONE, test_enemy.frags);
			SetColorName(MSG_ONE, test_enemy);

			if (game_show_rules)
			{
				sprint_netname(test_enemy);
				sprint(" (skill ");
				sprint_ftos(test_enemy.bot_skill);
				sprint(")\n");
			}
		}
		test_enemy = nextent(test_enemy);
		score_count = score_count + 1;
	}
	other.enemy = test_enemy;
};

#ifdef QUAKEWORLD
void() SetPlayerInfo =
{
	WriteByte(MSG_BROADCAST, SVC_PLAYERINFO);
	WriteByte(MSG_BROADCAST, self.score_pos);
	if (self.modelindex == modelindex_player)
	{
		if (self.effects)
			WriteShort(MSG_BROADCAST, 4254);		// mask = 4254 = 158 + 4096
		else
			WriteShort(MSG_BROADCAST, 4126);		// mask = 4126 = 30 + 4096
	}
	else
	{
		if (self.effects)
			WriteShort(MSG_BROADCAST, 4286);		// mask = 4286 = 190 + 4096
		else
			WriteShort(MSG_BROADCAST, 4158);		// mask = 4158 = 62 + 4096
	}
	WriteCoord(MSG_BROADCAST, self.origin_x);
	WriteCoord(MSG_BROADCAST, self.origin_y);
	WriteCoord(MSG_BROADCAST, self.origin_z);
	WriteByte(MSG_BROADCAST, self.frame);

	WriteByte(MSG_BROADCAST, 129);		// mask2 = 129
	WriteShort(MSG_BROADCAST, self.v_angle_x * 182.0444444);	// 182.0444444 = 65536 / 360
	WriteShort(MSG_BROADCAST, self.v_angle_y * 182.0444444);	// 182.0444444 = 65536 / 360

	WriteByte(MSG_BROADCAST, real_frametime);

	WriteShort(MSG_BROADCAST, self.velocity_x);
	WriteShort(MSG_BROADCAST, self.velocity_y);
	WriteShort(MSG_BROADCAST, self.velocity_z);

	if (self.modelindex != modelindex_player)
		WriteByte(MSG_BROADCAST, self.modelindex);

	if (self.effects)
		WriteByte(MSG_BROADCAST, self.effects);
};
#endif // QUAKEWORLD
