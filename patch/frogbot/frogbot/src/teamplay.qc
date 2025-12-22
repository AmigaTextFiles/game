void(entity e) UpdateFrags;

/****************************************************************************
 * ThreeWave Capture The Flag
 ****************************************************************************
 * Based on John Spikles Complete Enhanced Teamplay
 ****************************************************************************
 * Version 4.0 rewrite Mar 21, 1997
 ****************************************************************************/

/** Defs **/

/** MODIFIABLE CONSTANTS **/

// Allowed team colors
// -1 indicates no color

float TEAM_COLOR1       =       5;
float TEAM_COLOR2       =       14;

float team1shirt;
float team2shirt;

/** End of MODIFIABLE CONSTANTS **/

// Globals

entity team1_lastspawn;
entity team2_lastspawn;
float	nextteamupdtime;	// time until next team update
float last_flag_capture;	// time of last capture
float last_capture_team;	// last team that captured

// Teamplay bitfield entries

float TEAM_TOTAL_HEALTH_PROTECT =	1;      // No health damage from friendly fire (including self)
float TEAM_FRAG_PENALTY =		2;      // One frag penalty for killing teammate
float TEAM_HEALTH_PROTECT =		3;      // No health damage from friendly fire (excluding self)
float TEAM_HEALTH_MASK = 		3;
float TEAM_ARMOR_PROTECT =		4;      // No armor or health damage from friendly fire

float TEAM_CAPTURE_CAPTURE_BONUS = 15; // what you get for capture
float TEAM_CAPTURE_TEAM_BONUS = 10; // what your team gets for capture
float TEAM_CAPTURE_RECOVERY_BONUS = 1; // what you get for recovery
float TEAM_CAPTURE_FRAG_CARRIER_BONUS = 2; // what you get for fragging
	//enemy flag carrier
float TEAM_CAPTURE_FLAG_RETURN_TIME = 40; // seconds until auto return

// XXX EXPERT CTF Additional scoring system

// bonuses

float TEAM_CAPTURE_CARRIER_DANGER_PROTECT_BONUS = 2; // bonus for fraggin someone
// who has recently hurt your flag carrier
float TEAM_CAPTURE_CARRIER_PROTECT_BONUS = 1; // bonus for fraggin someone while
// either you or your target are near your flag carrier
float TEAM_CAPTURE_FLAG_DEFENSE_BONUS = 1; // bonus for fraggin someone while
// either you or your target are near your flag
float TEAM_CAPTURE_RETURN_FLAG_ASSIST_BONUS = 1; // awarded for returning a flag that causes a
// capture to happen almost immediately
float TEAM_CAPTURE_FRAG_CARRIER_ASSIST_BONUS = 2; // award for fragging a flag carrier if a
// capture happens almost immediately

// radii

float TEAM_CAPTURE_TARGET_PROTECT_RADIUS = 550; // the radius around an object being
// defended where a target will be worth extra frags
float TEAM_CAPTURE_ATTACKER_PROTECT_RADIUS = 550; // the radius around an object being
// defended where an attacker will get extra frags when making kills

// timeouts

float TEAM_CAPTURE_CARRIER_DANGER_PROTECT_TIMEOUT = 4;
float TEAM_CAPTURE_CARRIER_FLAG_SINCE_TIMEOUT = 2;
float TEAM_CAPTURE_FRAG_CARRIER_ASSIST_TIMEOUT = 6;
float TEAM_CAPTURE_RETURN_FLAG_ASSIST_TIMEOUT = 4;

float TEAM_CAPTURE_UPDATE_TIME = 120;

// END EXPERT CTF

// flag status used in aflag field of flag
float FLAG_AT_BASE = 0;
float FLAG_CARRIED = 1;
float FLAG_DROPPED = 2;

/*
void() RegenFlag =
{
	self.movetype = MOVETYPE_TOSS;
	self.solid = SOLID_TRIGGER;
	sound (self, CHAN_VOICE, "items/itembk2.wav", 1, ATTN_NORM);	// play respawn sound
	setorigin(self, self.oldorigin);
	self.angles = self.mangle;
	self.aflag = FLAG_AT_BASE; // it's at home base
	self.owner = world;
};

void() TeamCaptureReturnFlag =
{
	RegenFlag();

	test_enemy = first_client;
	while (test_enemy) {
		if (test_enemy.team != self.team)
			centerprint(test_enemy, "Enemy flag has been returned to base!");
		else if (test_enemy.team == self.team)
			centerprint(test_enemy, "Your flag has been returned to base!");
		test_enemy = test_enemy.next;
	}
};
*/
/*
void() TeamDropFlag =
{
	test_enemy = self.owner;

	bprint_netname(test_enemy);
	if (test_enemy.team == TEAM_COLOR1)
		bprint(" ÏÔÛÙ the ¬Ã’≈ flag!\n"); // blue
	else
		bprint(" ÏÔÛÙ the “≈ƒ flag!\n"); // red

	self.origin = test_enemy.origin - '0 0 24';
	self.aflag = FLAG_DROPPED;
	self.velocity = '300 0 0';
	self.flags = FL_ITEM;
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_TOSS;
	if (game_capture_custom)
		setsize(self, '-16 -16 0', '16 16 74');
	else
		setsize(self, '-16 -16 -24', '16 16 32');
	// return it after so long
	self.super_time = time + TEAM_CAPTURE_FLAG_RETURN_TIME;
};
*/

void() TeamCaptureDropFlagOfPlayer =
{
/*
	if (self.player_flag & ITEM_ENEMY_FLAG)
	{
		self.player_flag = self.player_flag - ITEM_ENEMY_FLAG;
		flag_self = self;
		if (self.team == TEAM_COLOR1) 
			self = find(world, classname, "item_flag_team2");
		else
			self = find(world, classname, "item_flag_team1");
		TeamDropFlag();
		self = flag_self;
		if (!(self.items & IT_INVULNERABILITY))
			if (!(self.items & IT_QUAD))
				self.owner.effects = self.owner.effects - EF_DIMLIGHT;
	}
*/
};

/*
void() TeamCaptureFlagTouch =
{
	if (!other.client_)
		return;
	if (other.health <= 0)
		return;

	if (self.team == other.team) {
		// same team, if the flag is *not* at the base, return
		// it to base.  we overload the 'aflag' field for this
		if (self.aflag == FLAG_AT_BASE) {
			// the flag is at home base.  if the player has the enemy
			// flag, he's just won!

			if (other.player_flag & ITEM_ENEMY_FLAG) {
				bprint_netname(other);
				if (other.team == TEAM_COLOR1)
					bprint(" „·ÙıÚÂ‰ the ¬Ã’≈ flag!\n"); // blue
				else
					bprint(" „·ÙıÚÂ‰ the “≈ƒ flag!\n"); // red
				other.items = other.items - (other.items & (IT_KEY1 | IT_KEY2));

				last_flag_capture = time;
				last_capture_team = other.team;

				if (game_capture_custom)
					sound (other, CHAN_VOICE, "misc/flagcap.wav", 1, ATTN_NONE);
				else
					sound (other, CHAN_VOICE, "doors/meduse.wav", 1, ATTN_NONE);

				// Ok, let's do the player loop, hand out the bonuses
				self = first_client;
				while (self) {
					if (self.team == other.team) {
						if (self == other)
						// other gets another 10 frag bonus
							self.frags = self.frags + TEAM_CAPTURE_CAPTURE_BONUS;
						else
							self.frags = self.frags + TEAM_CAPTURE_TEAM_BONUS;

						// done to all players on the capturing team
						// *XXX* EXPERT CTF
	
						// award extra points for capture assists
						if (self.last_returned_flag + TEAM_CAPTURE_RETURN_FLAG_ASSIST_TIMEOUT > time) {
							bprint_netname(self);
							bprint(" gets an assist for returning his flag!\n");
							self.frags = self.frags + TEAM_CAPTURE_RETURN_FLAG_ASSIST_BONUS;
						}
						if (self.last_fragged_carrier + TEAM_CAPTURE_FRAG_CARRIER_ASSIST_TIMEOUT > time) {
							bprint_netname(self);
							bprint(" gets an assist for fragging the flag carrier!\n");
							self.frags = self.frags + TEAM_CAPTURE_FRAG_CARRIER_ASSIST_BONUS;
						}

						UpdateFrags (self);

					} else {
						// *XXX* EXPERT CTF
						// reset the last_hurt_carrier variable in all enemy players, so that you don't get
						// bonuses for defending the flag carrier if the flag carrier has already
						// completed a capture
						self.last_hurt_carrier = -5;
					}

					if ((self.team == TEAM_COLOR1 && other.team == TEAM_COLOR2) ||
						(self.team == TEAM_COLOR2 && other.team == TEAM_COLOR1))
						centerprint(self, "Your flag was captured!");
					else if (self.team == other.team)
						centerprint(self, "Your team captured the flag!");

					self = self.next;
				}

				other.player_flag = other.player_flag - ITEM_ENEMY_FLAG;
				if (!(other.items & IT_INVULNERABILITY))
					if (!(other.items & IT_QUAD))
						other.owner.effects = other.owner.effects - EF_DIMLIGHT;

				// respawn flags

				self = find(world, classname, "item_flag_team1");
				RegenFlag();
				self = find(world, classname, "item_flag_team2");
				RegenFlag();
			}
			return; // its at home base already
		}	
		// hey, its not home.  return it by teleporting it back
		bprint_netname(other);
		if (other.team == TEAM_COLOR1)
			bprint(" ÚÂÙıÚÓÂ‰ the “≈ƒ flag!\n"); // red
		else
			bprint(" ÚÂÙıÚÓÂ‰ the ¬Ã’≈ flag!\n"); // blue
		other.frags = other.frags + TEAM_CAPTURE_RECOVERY_BONUS;
		UpdateFrags (other);
		// *XXX* EXPERT CTF set time when player last returned his flag
		other.last_returned_flag = time;
		sound (other, CHAN_ITEM, self.noise1, 1, ATTN_NORM);
		TeamCaptureReturnFlag();
		return;
	}

	// hey, its not our flag, pick it up
	bprint_netname(other);
	if (other.team == TEAM_COLOR1)
		bprint(" ÁÔÙ the ¬Ã’≈ flag!\n"); // blue
	else
		bprint(" ÁÔÙ the “≈ƒ flag!\n"); // red
//	centerprint(other, "YOU GOT THE ENEMY FLAG!  RETURN TO BASE!");
	centerprint(other, "Ÿœ’ «œ‘ ‘»≈ ≈Œ≈ÕŸ ∆Ã¡«  “≈‘’“Œ ‘œ ¬¡”≈");
	sound (other, CHAN_ITEM, self.noise, 1, ATTN_NORM);

	other.player_flag = other.player_flag | ITEM_ENEMY_FLAG;
	other.items = other.items | self.items;
	other.owner.effects = other.owner.effects | EF_DIMLIGHT;

	// *XXX* EXPERT CTF set the time at which the carrier picked up the flag
	other.flag_since = time;

	// pick up the flag
	self.aflag = FLAG_CARRIED;
	self.movetype = MOVETYPE_NOCLIP;
	self.solid = SOLID_NOT;
	self.owner = other;

	self = first_client;
	while (self) {
		if (self != other) {
			if ((self.team == TEAM_COLOR1 && other.team == TEAM_COLOR2) ||
				(self.team == TEAM_COLOR2 && other.team == TEAM_COLOR1))
				centerprint(self, "Your flag has been taken!");
			else if (self.team == other.team)
				centerprint(self, "Your team has the enemy flag!");
		}
		self = self.next;
	}
};

void() TeamCaptureFlagThink =
{
	self.nextthink = time + 0.1;

	if (self.aflag == FLAG_AT_BASE)
		return; // just sitting around waiting to be picked up

	if (self.aflag == FLAG_DROPPED) {
		if (time - self.super_time > TEAM_CAPTURE_FLAG_RETURN_TIME)
			TeamCaptureReturnFlag();
		return;
	}

	test_enemy = self.owner;
	if ((!test_enemy.client_) || (test_enemy.deadflag) ||
		(!(test_enemy.player_flag & ITEM_ENEMY_FLAG))) {
		TeamDropFlag();
		return;
	}
	makevectors (test_enemy.angles);
	v_forward_z = 0 - v_forward_z; // reverse z component

	flag_pos = 14;
	if (self.owner.frame >= 29 && self.owner.frame <= 40) {
		if (self.owner.frame >= 29 && self.owner.frame <= 34) { //axpain
			if (self.owner.frame == 29)
				flag_pos = 16; 
			else if (self.owner.frame == 30)
				flag_pos = 22;
			else if (self.owner.frame == 31)
				flag_pos = 26;
			else if (self.owner.frame == 32)
				flag_pos = 25;
			else if (self.owner.frame == 33)
				flag_pos = 24;
			else if (self.owner.frame == 34)
				flag_pos = 18;
		} else if (self.owner.frame >= 35 && self.owner.frame <= 40) { // pain
			if (self.owner.frame == 35)
				flag_pos = 16; 
			else if (self.owner.frame == 36)
				flag_pos = 24;
			else if (self.owner.frame == 37)
				flag_pos = 24;
			else if (self.owner.frame == 38)
				flag_pos = 22;
			else if (self.owner.frame == 39)
				flag_pos = 18;
			else if (self.owner.frame == 40)
				flag_pos = 16;
		}
	} else if (self.owner.frame >= 103 && self.owner.frame <= 118) {
		if (self.owner.frame >= 103 && self.owner.frame <= 104)
			flag_pos = 20;  //nailattack
		else if (self.owner.frame >= 105 && self.owner.frame <= 106)
			flag_pos = 20;  //light 
		else if (self.owner.frame >= 107 && self.owner.frame <= 112)
			flag_pos = 21;  //rocketattack
		else if (self.owner.frame >= 112 && self.owner.frame <= 118)
			flag_pos = 21;  //shotattack
	}
	self.origin = test_enemy.origin + '0 0 -16' - flag_pos * v_forward + v_right * 22;
	self.angles = test_enemy.angles + '0 0 -45';
	setorigin (self, self.origin);
	self.nextthink = time + 0.01;
};

// self is player
entity() TeamCaptureSpawn =
{
	if (self.team == TEAM_COLOR1) {
		team1_lastspawn = find(team1_lastspawn, classname, "info_player_team1");
		if (team1_lastspawn == world)
			team1_lastspawn = find(team1_lastspawn, classname, "info_player_team1");
		return team1_lastspawn;
	} else if (self.team == TEAM_COLOR2) {
		team2_lastspawn = find(team2_lastspawn, classname, "info_player_team2");
		if (team2_lastspawn == world)
			team2_lastspawn = find(team2_lastspawn, classname, "info_player_team2");
		return team2_lastspawn;
	}
	return world;
};
*/
/*
	From byron@caseware.com Wed Oct 16 18:57:44 1996
	Date: Wed, 16 Oct 1996 21:22:37 -0400
	From: Byron Long <byron@caseware.com>
	To: zoid@mindlink.net
	Subject: Team Status Command (source code included) :-)

	A co-worker of mine wondered if it was possible to add a function to
	your capture the flag code that would give a status report on an
	impulse. I think he may have mailed you, but I wrote a quick version
	myself, which your welcome to use if you like the feature (it offsets
	some of the problems with the chat capabilities in Quake so it seems
	like a worthwhile feature). Feel free to change it
	as necessary.
*/
/*
// *Capture The Flag - Status report by Wonko
void() TeamFlagStatusReport =
{
	// Find the flags at home base
	flag1 = find (world,classname, "item_flag_team1");
	flag2 = find (world,classname, "item_flag_team2");

	// If on team 2 switch meanings of flags
	if (self.team != TEAM_COLOR1) {
		test_enemy = flag1;
		flag1 = flag2;
		flag2 = test_enemy;
	}

	if (flag1 != world && flag1.aflag == FLAG_CARRIED) {
		sprint_netname(self, flag1.owner);
		sprint(self, " has your flag. ");
	} else {
		sprint(self, "Your flag is ");
		if (flag1 == world)
			sprint(self, "missing! ");
		if (flag1.aflag == FLAG_AT_BASE)
			sprint(self, "in your base. ");
		else if (flag1.aflag == FLAG_DROPPED)
			sprint(self, "lying about. ");
		else
			sprint(self, " corrupt. ");
	}

	if (flag2 != world && flag2.aflag == FLAG_CARRIED) {
		if (self == flag2.owner) 
			sprint(self, "You have the enemy flag.\n");
		else {
			sprint_netname(self, flag2.owner);
			sprint(self, " has the enemy flag.\n");
		}
	} else {
		sprint(self, "The enemy flag is ");
		if (flag2 == world)
			sprint(self, "missing!\n");
		if (flag2.aflag == FLAG_AT_BASE)
			sprint(self, "in their base.\n");
		else if (flag2.aflag == FLAG_DROPPED)
			sprint(self, "lying about.\n");
		else
			sprint(self, " corrupt.\n");
	}
};
*/
/////////////////////////////////////////////////////////////////////////
/*
$cd id1/models/flag
$base base
$skin skin

void() place_flag = {
	self.mdl = self.model;		// so it can be restored on respawn
	self.flags = FL_ITEM;		// make extra wide
	self.solid = SOLID_TRIGGER;
	self.movetype = MOVETYPE_TOSS;	
	self.velocity = '0 0 0';
	self.origin_z = self.origin_z + 6;
	self.think = TeamCaptureFlagThink;
	self.touch = TeamCaptureFlagTouch;
	self.nextthink = time + 0.1;
	self.aflag = FLAG_AT_BASE;
	self.mangle = self.angles;
	self.effects = self.effects | EF_DIMLIGHT;
	if (!droptofloor()) {
		dprint ("Flag fell out of level at ");
		dprint (vtos(self.origin));
		dprint ("\n");
		remove(self);
		return;
	}
	self.oldorigin = self.origin; // save for flag return
};

// ZOID Capture the flag
void() item_flag_team1 =
{
	self.team = TEAM_COLOR1;
	self.items = IT_KEY2;
	if (game_capture_custom) {
		precache_model ("progs/flag.mdl");
		setmodel (self, "progs/flag.mdl");
		self.skin = 0;
		precache_sound ("misc/flagtk.wav");			// flag taken
		precache_sound ("misc/flagcap.wav");			// flag capture
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/flagtk.wav";
		self.noise1 = "doors/runetry.wav";
		setsize(self, '-16 -16 0', '16 16 74');
	} else {
		precache_model ("progs/w_g_key.mdl");
		setmodel (self, "progs/w_g_key.mdl");
		precache_sound ("misc/medkey.wav");
		precache_sound ("doors/meduse.wav");
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/medkey.wav";
		self.noise1 = "doors/runetry.wav";
		self.origin_z = self.origin_z + 24;
		setsize(self, '-16 -16 -24', '16 16 32');
	}
	self.nextthink = time + 0.2;	// items start after other solids
	self.think = place_flag;
};

void() item_flag_team2 =
{
	self.team = TEAM_COLOR2;
	self.items = IT_KEY1;
	if (game_capture_custom) {
		precache_model ("progs/flag.mdl");
		setmodel (self, "progs/flag.mdl");
		self.skin = 1;
		precache_sound ("misc/flagtk.wav");			// flag taken
		precache_sound ("misc/flagcap.wav");			// flag capture
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/flagtk.wav";
		self.noise1 = "doors/runetry.wav";
		setsize(self, '-16 -16 0', '16 16 74');
	} else {
		precache_model ("progs/w_s_key.mdl");
		setmodel (self, "progs/w_s_key.mdl");
		precache_sound ("misc/medkey.wav");
		precache_sound ("doors/meduse.wav");
		precache_sound ("doors/runetry.wav");
		self.noise = "misc/medkey.wav";
		self.noise1 = "doors/runetry.wav";
		self.origin_z = self.origin_z + 24;
		setsize(self, '-16 -16 -24', '16 16 32');
	}
	// make it glow
	self.nextthink = time + 0.2;	// items start after other solids
	self.think = place_flag;
};
*/
