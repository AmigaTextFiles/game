void() SetSkill;
void(float frogbot_pos, float index_, float value) localsave;

/*
============
CopyName

============
*/
void(entity e, entity f) CopyName =
{
	e.block0 = f.block0;
	e.block1 = f.block1;
	e.block2 = f.block2;
	e.block3 = f.block3;
	e.block4 = f.block4;
};

#ifdef QUAKEWORLD
/*
============
CopyQWSkin

============
*/
void(entity e, entity f) CopyQWSkin =
{
	e.skin0 = f.skin0;
	e.skin1 = f.skin1;
	e.skin2 = f.skin2;
};
#endif // QUAKEWORLD

/*
============
NamesEqual

============
*/
float(entity e, entity f) NamesEqual =
{
	if (e.block0 == f.block0)
		if (e.block1 == f.block1)
			if (e.block2 == f.block2)
				if (e.block3 == f.block3)
					if (e.block4 == f.block4)
						return TRUE;
	return FALSE;
};

/*
============
insert_block

return 0 if fail
============
*/
float(float block, float insert_character) insert_block =
{
	character = block & 255;
	if (character)
	{
		character = floor(block / 256) & 255;
		if (character)
		{
			character = floor(block / 65536);
			if (character)
				return 0;
			else
				return (block + insert_character * 65536);
		}
		else
			return (block + insert_character * 256);
	}
	else
		return insert_character;
};

/*
============
insert_netname

============
*/
void(entity client, float insert_character) insert_netname =
{
	block_ = insert_block(client.block0, insert_character);
	if (block_)
		client.block0 = block_;
	else
	{
		block_ = insert_block(client.block1, insert_character);
		if (block_)
			client.block1 = block_;
		else
		{
			block_ = insert_block(client.block2, insert_character);
			if (block_)
				client.block2 = block_;
			else
			{
				block_ = insert_block(client.block3, insert_character);
				if (block_)
					client.block3 = block_;
				else
				{
					block_ = insert_block(client.block4, insert_character);
					if (block_)
						client.block4 = block_;
				}
			}
		}
	}
};

#ifdef QUAKEWORLD
/*
============
insert_qwskin

============
*/
void(entity client, float insert_character) insert_qwskin =
{
	block_ = insert_block(client.skin0, insert_character);
	if (block_)
		client.skin0 = block_;
	else
	{
		block_ = insert_block(client.skin1, insert_character);
		if (block_)
			client.skin1 = block_;
		else
		{
			block_ = insert_block(client.skin2, insert_character);
			if (block_)
				client.skin2 = block_;
		}
	}
};
#endif // QUAKEWORLD

/*
============
print_block

============
*/
float(float to, float block) print_block =
{
	character = block & 255;
	if (character)
	{
		WriteByte(to, character);
		character = floor(block / 256) & 255;
		if (character)
		{
			WriteByte(to, character);
			character = floor(block / 65536);
			if (character)
			{
				WriteByte(to, character);
				return TRUE;
			}
		}
	}
};

/*
============
WriteName_apply

============
*/
void(float to, entity client) WriteName_apply =
{
	if (print_block(to, client.block0))
		if (print_block(to, client.block1))
			if (print_block(to, client.block2))
				if (print_block(to, client.block3))
					print_block(to, client.block4);
};

#ifdef QUAKEWORLD
/*
============
WriteQWSkin

============
*/
void(float to, entity client) WriteQWSkin =
{
	if (print_block(to, client.skin0))
		if (print_block(to, client.skin1))
			print_block(to, client.skin2);
};
#endif // QUAKEWORLD

/*
============
WriteName

============
*/
void(float to, entity client) WriteName =
{
	if (client.flags & FL_PLAYER)
		WriteString(to, client.netname);
	else
	{
		WriteName_apply(to, client);
		WriteByte(to, 0);
	}
};

/*
============
sprint_netname

============
*/
void(entity name_client) sprint_netname =
{
	if (msg_entity.flags & FL_PLAYER)
	{
	#ifdef QUAKE
		if (msg_entity.msg_level_ <= msg_level)
	#endif // QUAKE

	#ifdef QUAKEWORLD
		if ((stof(infokey(msg_entity,"msg"))) <= msg_level)
	#endif // QUAKEWORLD
		{
			WriteByte(MSG_ONE, MSG_PRINT);
		#ifdef QUAKEWORLD
			WriteByte(MSG_ONE, msg_level);
		#endif // QUAKEWORLD
		WriteName(MSG_ONE, name_client);
		}
	}
};

/*
============
bprint_netname

============
*/
void(entity name_client) bprint_netname =
{
	local entity client;

	msg_entity = find(world, classname, "player");
	while (msg_entity)
	{
		sprint_netname(name_client);
		msg_entity = find(msg_entity, classname, "player");
	}
};


/*
============
LetterCodes

============
*/
void() LetterCodes =
{
	char_count = word_count = 0;

	if (!self.letter_index)
		self.letter_index = 32;

	msg_entity = self;

	WriteByte(MSG_ONE, MSG_PRINT);

	while (char_count < 45)
	{
		if (self.letter_index == 255)
		{
			self.letter_index = 0;
			char_count = 45;
		}
		else
		{
			char_count = char_count + 1;
			WriteByte(MSG_ONE, self.letter_index);
			WriteByte(MSG_ONE, space);
			NumberToString(MSG_ONE, self.letter_index);
			if (self.letter_index < 100)
				WriteByte(MSG_ONE, space);
			word_count = word_count + 1;
			if (word_count < 5)
			{
				WriteByte(MSG_ONE, space);
				WriteByte(MSG_ONE, space);
			}
			else if (char_count < 45)
			{
				WriteByte(MSG_ONE, enter);
				word_count = 0;
			}

			self.letter_index = self.letter_index + 1;
		}
	}
	WriteByte(MSG_ONE, enter);
	WriteByte(MSG_ONE, 0);
};

/*
============
MakeFrogbot

============
*/
void() MakeFrogbot =
{
	spawnflags_ = self.spawnflags;

	if (impulse_ == 255)
		impulse_ = 0;

	if (spawnflags_ == START_NAME)
	{
		if (!impulse_)
			self.spawnflags = 0;
		else
		{
			if (impulse_ >= 32)
				insert_netname(self, impulse_);
		}
	}
	else if (spawnflags_ == START_QWSKIN)
	{
		if (!impulse_)
			self.spawnflags = 0;
	#ifdef QUAKEWORLD
		else
		{
			if (impulse_ >= 32)
				insert_qwskin(self, impulse_);
		}
	#endif // QUAKEWORLD
	}
	else if (spawnflags_ == START_ADMIN1)
	{
		self.admin_code = impulse_;
		self.spawnflags = START_ADMIN2;
	}
	else if (spawnflags_ == START_ADMIN2)
	{
		self.admin_code = self.admin_code + impulse_ * 256;
		self.spawnflags = START_ADMIN3;
	}
	else
	{
		self.spawnflags = 0;

		if (spawnflags_ == START_ADMIN3)
		{
			self.admin_code = self.admin_code + impulse_ * 65536;
			if (self == first_ent)
			{
				localsave(0, 0, self.admin_code);
				dropper.admin_code = self.admin_code;
				msg_level = PRINT_HIGH;
				if (self.admin_code)
					bprint("admin set by ");
				else
					bprint("admin cleared by ");
				bprint(self.netname);
				bprint("\n");
			}
		}
		else if (spawnflags_ == START_TEAMPLAY)
		{
			if (impulse_ <= MAX_TEAMPLAY)
				cvar_set_("teamplay", impulse_);
		}
		else if (spawnflags_ == START_DEATHMATCH)
		{
			if (impulse_ && impulse_ <= MAX_DEATHMATCH)
			{
				cvar_set_("deathmatch", impulse_);
				msg_level = PRINT_HIGH;
				bprint("\"deathmatch\" changed to \"");
				bprint_ftos(impulse_);
				bprint("\" next level\n");
			}
		}
		else if (spawnflags_ == START_TIMELIMIT)
			cvar_set_("timelimit", impulse_);
		else if (spawnflags_ == START_FRAGLIMIT)
			cvar_set_("fraglimit", impulse_);
		else if (spawnflags_ == START_SKILL)
		{
			if (impulse_ <= MAX_SKILL)
			{
				self.bot_skill = impulse_;
				if (self == first_ent)
					skill = impulse_;
				SetSkill();
			}
		}
	#ifdef QUAKE
		else if (spawnflags_ == START_SKIN)
			self.spawn_skin = impulse_;
	#endif // QUAKE
		else if (spawnflags_ == START_BOTS)
			self.number_bots = impulse_;
		else if (spawnflags_ == START_LINES)
			self.lines = impulse_;
		else if (spawnflags_ == START_MSG)
		{
		#ifdef QUAKE
			self.msg_level_ = impulse_;
		#endif // QUAKE

		#ifdef QUAKEWORLD
			msg_entity = self;
			stuffcmd("msg ");
			stuffcmd_ftos(impulse_);
			stuffcmd("\n");
		#endif // QUAKEWORLD
		}
		else // (if (spawnflags_ == START_SHIRT or START_PANTS or START_TEAMSHIRT or START_TEAMPANTS))
		{
			if (impulse_ == 14)
			{
				impulse_ = random();
				impulse_ = floor(impulse_ * 14);
			}
			if (impulse_ <= 13)
			{
				if (spawnflags_ == START_SHIRT)
					self.color_ = impulse_ * 16 + (self.color_ & 15);
				else if (spawnflags_ == START_PANTS)
					self.color_ = (self.color_ & 240) + impulse_;
				else if (spawnflags_ == START_TEAMSHIRT)
					self.teamcolor = impulse_ * 16 + (self.teamcolor & 15);
				else if (spawnflags_ == START_TEAMPANTS)
					self.teamcolor = (self.teamcolor & 240) + impulse_;
			}
		}
	}
};

/*
============
NumberToString_apply

============
*/
void(entity client, float value) NumberToString_apply =
{
	if (value == 0)
	{
		insert_netname(client, _0);
	}
	else
	{
		if (value < 0)
		{
			insert_netname(client, minus);
			value = 0 - value;
		}

		previous_exponent = 0;

		while (value)
		{
			digit = value;
			exponent = 1;

			while (floor(digit * 0.1))
			{
				digit = floor(digit * 0.1);
				exponent = exponent * 10;
			}

			if (previous_exponent)
			{
				while ((previous_exponent * 0.1) != exponent)
				{
					insert_netname(client, _0);
					previous_exponent = previous_exponent * 0.1;
				}
			}

			insert_netname(client, _0 + digit);
			previous_exponent = exponent;
			value = value - digit * exponent;
		}

		while (exponent != 1)
		{
			insert_netname(client, _0);
			exponent = exponent * 0.1;
		}
	}
};

/*
============
NumberToString

============
*/
void(float to, float value) NumberToString =
{
	CopyName(dropper, platform);
	NumberToString_apply(dropper, value);
	WriteName_apply(to, dropper);
};

/*
============
SetName

============
*/
void() SetName =
{
	msg_entity = self;
	WriteByte(MSG_ONE, MSG_STUFFCMD);
	WriteByte(MSG_ONE, _n);
	WriteByte(MSG_ONE, _a);
	WriteByte(MSG_ONE, _m);
	WriteByte(MSG_ONE, _e);
	WriteByte(MSG_ONE, space);
	WriteByte(MSG_ONE, quote);
	WriteName_apply(MSG_ONE, self);
	WriteByte(MSG_ONE, quote);
	WriteByte(MSG_ONE, 0);
	CopyName(self, platform);	// NULL
};
