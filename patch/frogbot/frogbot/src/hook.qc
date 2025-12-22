#ifdef QUAKE
/*********\
* LinkPos *
\*********/

void () LinkPos =
{
        makevectors (self.enemy.angles);
        setorigin (self, self.owner.origin + ( ( ( self.enemy.origin + 
                (v_up * 16 * (!self.enemy.button2)) + (v_forward * 16) ) - self.owner.origin ) *
                ( self.weapon ) ) );
        self.nextthink = time + 0.1;
};

/************\
* HookVanish *
\************/

void () HookVanish =
{
	self.owner.hook_out = FALSE;
	if (game_capture_custom)
	{
		msg_entity = self.owner;
		sound(CHAN_WEAPON, "weapons/bounce2.wav", 1, ATTN_NORM);
	}

	do
	{
		remove ();
		self = self.hookentity;
	} while (self);
};

void() UnHookPlayer =
{
	if (self.hook_out) {
		unhook_self = self;
		self = self.hookentity;
		HookVanish();
		self = unhook_self;
	}
};

/**********\
* HookPull *
\**********/

void () HookPull =
{
        local vector vel, spray;
        local float v;

	if ((!self.owner.button0 && (self.owner.weapon == IT_HOOK)) ||
		(self.owner.teleport_time > time ) || self.owner.deadflag ) {
		HookVanish();
	} else {
		 if (self.enemy.takedamage) {
			// 4.1, if we can't see our enemy, unlock
			targ = self.enemy;
			inflictor = self.owner;
			inflictor_origin = inflictor.origin;
			if (!CanDamage()) {
				HookVanish();
				return;
			}

			if (self.enemy.client_) {
					self.velocity = '0 0 0';
					setorigin (self, self.enemy.origin +
							self.enemy.mins +
							(self.enemy.size * 0.5));
			} else {
					self.velocity = self.enemy.velocity;
			}

			msg_entity = self;
			sound (CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NORM);
			deathtype = "hook";
			inflictor = self;
			attacker = self.owner;
			targ = self.enemy;
			damage = 1;
			T_Damage ();
			makevectors (self.v_angle);
			spray_x = 100 * crandom();
			spray_y = 100 * crandom();
			spray_z = 100 * crandom() + 50;
			damage = 20;
			SpawnBlood (self.origin, spray);
		} else {
				self.velocity = self.enemy.velocity;
		}
		if (self.enemy.solid == SOLID_NOT) {
			HookVanish();
		}
		else {
			makevectors (self.owner.angles);
			vel = self.origin - ( self.owner.origin + (v_up * 16 *
					(!self.owner.button2)) + (v_forward * 16));
			v = vlen (vel);
			if (v <= 100)
					vel = normalize(vel) * v * 10;  
			if ( v > 100 )
					vel = normalize(vel) * 1000;  

			if (game_capture_custom) {
				msg_entity = self.owner;
				if (vlen(msg_entity.origin - self.dest) > 10) {
					if (self.style == 3) {
						sound(CHAN_WEAPON, "weapons/chain2.wav", 1, ATTN_NORM);
						self.style = 2;
					}
				} else {
					if (self.style == 2) {
						sound(CHAN_WEAPON, "weapons/chain3.wav", 1, ATTN_NORM);
						self.style = 3;
					}
				}
			}

			self.owner.velocity = vel;
			self.dest = self.owner.origin;
			self.nextthink = time + 0.1;
		}
	}
};

/**************\
* T_ChainTouch *
\**************/

void() T_ChainTouch =
{
	if (other != self.owner) {
		if (pointcontents(self.origin) == CONTENT_SKY) {
			HookVanish();
		} else {
			if (other.client_) {
				if (other.realteam == self.owner.realteam)
					return; // just pass through teammates
				axhitme = 1; // make axe noise
			} else {
				msg_entity = self;
				sound (CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
				self.avelocity = '0 0 0';
			}

			if (other.takedamage) {
				damage = 10;
				SpawnBlood (self.origin, self.velocity);
				deathtype = "hook";
				inflictor = self;
				attacker = self.owner;
				targ = other;
				T_Damage ();
			}
                
			if (self.owner.button0) {
				if (other.client_) {
					setorigin (self, other.origin + other.mins +
								(other.size * 0.5));
						self.velocity = '0 0 0';
				} else {
						self.velocity = other.velocity;
				}
				self.weapon = other.nextthink - time;
				if (game_capture_custom)
				{
					msg_entity = self.owner;
					sound (CHAN_WEAPON, "weapons/chain2.wav", 1, ATTN_NORM);
				}

				self.style = 2;
				self.enemy = other;
				self.nextthink = time + 0.1;
				self.think = HookPull;
				self.touch = platform.touch;	// NULL
			} else {
				HookVanish();
			}
		}
	}
};

/*************\
* W_FireChain *
\*************/

void() W_FireChain =
{
	self.hook_out = TRUE;
	hook_ = spawn ();
	hook_.owner = self;
	self.hookentity = hook_;
	hook_.movetype = MOVETYPE_FLY;
	hook_.solid = SOLID_BBOX;
		
// set hook speed 

	makevectors (self.v_angle);
	hook_.velocity = v_forward * 800;
	hook_.angles = vectoangles(hook_.velocity);
	hook_.avelocity = '0 0 -500';
	
	hook_.touch = T_ChainTouch;
	
// set hook sound
	hook_.nextthink = time + 5;
	hook_.think = HookVanish;

	msg_entity = self;
	if (game_capture_custom)
	{
		setmodel (hook_, "progs/star.mdl");
		sound (CHAN_WEAPON, "weapons/chain1.wav", 1, ATTN_NORM);	
	}
	else
	{
		setmodel (hook_, "progs/v_spike.mdl");
		sound (CHAN_WEAPON, "hknight/hit.wav", 1, ATTN_NORM);	
	}
	setsize (hook_, '0 0 0', '0 0 0');     
	setorigin (hook_, self.origin + (v_forward*16) + '0 0 16' );

	linknum = 3;
	prevlink = world;
	while (linknum)
	{
		link = spawn();

		link.hookentity = prevlink;
		prevlink = link;

		link.owner = hook_;
		link.enemy = self;
		link.weapon = linknum * 0.25;
		link.movetype = MOVETYPE_NOCLIP;
		link.solid = SOLID_NOT;
		link.angles_z = 51 * linknum;
		link.angles_y = 41 * linknum;
		link.angles_x = 31 * linknum;
		link.avelocity = '310 410 510';
		if (game_capture_custom)
			setmodel (link, "progs/bit.mdl");
		else
			setmodel (link, "progs/s_spike.mdl");
		setsize (link, '0 0 0', '0 0 0');
		makevectors (self.angles);
		setorigin (link, hook_.origin + ( ( ( self.origin 
		+ (v_up * 16 * (!self.button2)) + ( v_forward * 16 ) ) - hook_.origin )
		* ( link.weapon ) ) );
		link.nextthink = time + 0.1;
		link.think = LinkPos;
		linknum = linknum - 1;
	}
	hook_.hookentity = link;
};
#endif // QUAKE



#ifdef QUAKEWORLD
/*
===========================================================================
grapple.qc 12/29/96

Quakeworld-friendly grapple hook code by Wedge (Steve Bond)
           visit Quake Command http://www.nuc.net/quake 


Original 'Morning Star' (Grapple Hook) by "Mike" <amichael@asu.alasu.edu> 
I took care to preserve the speed and damage values of the original
Morning Star. Depending on latency, performance should be near exact.
===========================================================================
*/

//
// Reset_Grapple - Removes the hook and resets its owner's state.
//                 expects a pointer to the hook
//
void (entity rhook) Reset_Grapple =
{
	if (rhook.owner != world) {
		if (game_capture_custom)
		{
			msg_entity = rhook.owner;
			sound (CHAN_NO_PHS_ADD+CHAN_WEAPON, "weapons/bounce2.wav", 1, ATTN_NORM);
		}
		rhook.owner.on_hook = FALSE;
		rhook.owner.hook_out = FALSE;
		rhook.owner.weaponframe = 0;
		rhook.owner.attack_finished = time + 0.25;

		rhook.think = SUB_Remove;
		rhook.nextthink = time;
	}
};

void() UnHookPlayer =
{
	if (self.hook_out)
		Reset_Grapple(self.hook);
};

//
// Grapple_Track - Constantly updates the hook's position relative to
//                 what it's hooked to. Inflicts damage if attached to
//                 a player that is not on the same team as the hook's
//                 owner.
//
void () Grapple_Track =
{
	// Release dead targets
	if (self.enemy.health <= 0)
	{
		if (self.enemy.client_)
		{
			self.owner.on_hook = FALSE;
			self.owner.attack_finished = time +0.75;
		}
	}

	// drop the hook if owner is dead or has released the button
	if (!self.owner.on_hook || self.owner.health <= 0) {
		Reset_Grapple (self);
	} else {
		// bring the pAiN!
		if (self.enemy.takedamage)
		{
		// 4.1, if we can't see our enemy, unlock
			targ = self.enemy;
			inflictor = self.owner;
			inflictor_origin = inflictor.origin;
			if (!CanDamage()) {
				Reset_Grapple(self);
				return;
			}

			if (self.enemy.client_) {
				// move the hook along with the player.  It's invisible, but
				// we need this to make the sound come from the right spot
				setorigin(self, self.enemy.origin);
			} else {
				// If the hook is not attached to the player, constantly copy
				// copy the target's velocity. Velocity copying DOES NOT work properly
				// for a hooked client. 
				self.velocity = self.enemy.velocity;
			}

			msg_entity = self;
			sound (CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NORM);
			deathtype = "hook";
			inflictor = self;
			attacker = self.owner;
			targ = self.enemy;
			damage = 1;
			T_Damage ();
			makevectors (self.v_angle);
			SpawnBlood(self.enemy.origin);
		} else {
			self.velocity = self.enemy.velocity;
		}

		self.nextthink = time + 0.1;
	}
};

//
// MakeLink - spawns the chain link entities
//
entity () MakeLink =
{
	newmis = spawn ();

	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_NOT;
	newmis.owner = self;// SELF is the hook!

	newmis.avelocity = '200 200 200';

	if (game_capture_custom)
		setmodel (newmis, "progs/bit.mdl");
	else
		setmodel (newmis, "progs/s_spike.mdl");
	setorigin (newmis, self.origin);
	setsize (newmis, '0 0 0' , '0 0 0');
	return  newmis;
};

//
// Remove_Chain - Removes all chain link entities; this is a separate
//                function because CLIENT also needs to be able
//                to remove the chain. Only one function required to
//                remove all links.
//
void () Remove_Chain =
{
	self.think = SUB_Remove;
	self.nextthink = time;

	if (self.hookentity)
	{
		self.hookentity.think = SUB_Remove;
		self.hookentity.nextthink = time;

		if (self.hookentity.hookentity)
		{
			self.hookentity.hookentity.think = SUB_Remove;
			self.hookentity.hookentity.nextthink = time;
		}
	}
};

//
// Update_Chain - Repositions the chain links each frame. This single function
//                maintains the positions of all of the links. Only one link
//                is thinking every frame. 
//
void () Update_Chain =
{
	if (self.owner.hook_out)
	{
		rel_hook_origin = (self.owner.hook.origin - self.owner.origin);

		// These numbers are correct assuming 3 links.
		// 4 links would be *20 *40 *60 and *80
		setorigin (self, self.owner.origin + rel_hook_origin * 0.25);
		setorigin (self.hookentity, self.owner.origin + rel_hook_origin * 0.5);
		setorigin (self.hookentity.hookentity, self.owner.origin + rel_hook_origin * 0.75);

		self.nextthink = time + 0.1;
	}
	else
	{
		self.think = Remove_Chain;
		self.nextthink = time;
	}
};

//
// Build_Chain - Builds the chain (linked list)
//
void () Build_Chain =
{
	self.hookentity = MakeLink();
	self.hookentity.think = Update_Chain;
	self.hookentity.nextthink = time + 0.1;
	self.hookentity.owner = self.owner;

	self.hookentity.hookentity = MakeLink();
	self.hookentity.hookentity.hookentity = MakeLink();
};

//
// Check_Overhead - Makes sure there is sufficient headroom above the player
//                  so that setorigin doesn't stick them into a wall. I tried
//                  to compare pointcontents, but that was too flaky.
//
float () Check_Overhead =
{
	makevectors (self.owner.angles);

	// quick check right above head
	traceline (self.owner.origin - '0 0 24', self.owner.origin - '0 0 24', FALSE, self.owner);
	if (trace_fraction != 1.0)
		return FALSE;

	traceline (self.owner.origin - '0 0 24' - v_forward * 16, self.owner.origin - '0 0 24' - v_forward * 16 + '0 0 58', FALSE, self.owner);
	if (trace_fraction != 1.0)
		return FALSE;

	traceline (self.owner.origin - '0 0 24' + v_forward * 16, self.owner.origin - '0 0 24' + v_forward * 16 + '0 0 58', FALSE, self.owner);
	if (trace_fraction != 1.0)
		return FALSE;

	traceline (self.owner.origin - '0 0 24' - v_right * 16, self.owner.origin - '0 0 24' - v_right * 16 + '0 0 58', FALSE, self.owner);
	if (trace_fraction != 1.0)
		return FALSE;

	traceline (self.owner.origin - '0 0 24' + v_right * 16, self.owner.origin - '0 0 24' + v_right * 16 + '0 0 58', FALSE, self.owner);
	if (trace_fraction != 1.0)
		return FALSE;

	return TRUE;
};


//
// Anchor_Grapple - Tries to anchor the grapple to whatever it touches
//
void () Anchor_Grapple =
{
	local float test;

	if (other != self.owner)
	{
		// DO NOT allow the grapple to hook to any projectiles, no matter WHAT!
		// if you create new types of projectiles, make sure you use one of the
		// classnames below or write code to exclude your new classname so
		// grapples will not stick to them.
		if (other.classname != "missile") {
			if (other.classname != "hook") {
				// Don't stick the the sky.
				if (pointcontents(self.origin) == CONTENT_SKY)
				{
					Reset_Grapple (self);
				} else {
					if (other.client_) {
						if (other.realteam == self.owner.realteam)
							return; // just pass through teammates
						axhitme = 1; // make axe noise
	
						// make hook invisible since we will be pulling directly
						// towards the player the hook hit. Quakeworld makes it
						// too quirky to try to match hook's velocity with that of
						// the client that it hit. 
						setmodel (self, "");
					} else {
						msg_entity = self;
						sound (CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
						self.velocity = '0 0 0';
						self.avelocity = '0 0 0';
					}

					if (other.takedamage) {
						SpawnBlood (self.origin);
						deathtype = "hook";
						inflictor = self;
						attacker = self.owner;
						targ = other;
						damage = 10;
						T_Damage ();
					}

					// conveniently clears the sound channel of the CHAIN1 sound,
					// which is a looping sample and would continue to play. Tink1 is
					// the least offensive choice, ass NULL.WAV loops and clogs the
					// channel with silence
					msg_entity = self.owner;
					sound (CHAN_NO_PHS_ADD+CHAN_WEAPON, "weapons/tink1.wav", 1, ATTN_NORM);

					if (self.owner.button0) {
						if (self.owner.flags & FL_ONGROUND)
							self.owner.flags = self.owner.flags - FL_ONGROUND;

						self.owner.on_hook = TRUE;

						if (game_capture_custom)
						{
							msg_entity = self.owner;
							sound (CHAN_WEAPON, "weapons/chain2.wav", 1, ATTN_NORM);
						}

						// CHAIN2 is a looping sample. Use style as a flag so that client.qc
						// will know to only play the tink sound ONCE to clear the weapons
						// sound channel. (style is a leftover, so I reused it to
						// avoid adding a field)
						self.owner.style = TRUE;

						self.enemy = other;// remember this guy!
						self.think = Grapple_Track;
						self.nextthink = time;
						self.solid = SOLID_NOT;
						self.touch = platform.touch;	// NULL
					} else {
						Reset_Grapple (self);
					}
				}
			}
		}
	}
};


//
// W_FireChain - called from PLAYER.QC, 'fires' the grapple
//
void () W_FireChain =
{
	if (self.hook_out)// reject subsequent calls from player.qc
		return;

	msg_entity = self;
	WriteByte (MSG_ONE, SVC_SMALLKICK);

	newmis = spawn();
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.owner = self;// newmis belongs to me
	self.hook = newmis;// This is my newmis
	newmis.classname = "hook";

	makevectors (self.v_angle);
	newmis.velocity = v_forward * 800;
	newmis.avelocity = '0 0 -500';

	newmis.touch = Anchor_Grapple;
	newmis.think = Build_Chain;
	newmis.nextthink = time + 0.1;// don't jam newmis and links into same packet

	// chain out sound (loops)
	if (game_capture_custom)
	{
		msg_entity = self;
		sound (CHAN_WEAPON, "weapons/chain1.wav", 1, ATTN_NORM);
		setmodel (newmis, "progs/star.mdl");
	}
	else
	{
		setmodel (newmis, "progs/v_spike.mdl");
		msg_entity = self;
		sound (CHAN_WEAPON, "hknight/hit.wav", 1, ATTN_NORM);
	}
	setorigin (newmis, self.origin + v_forward * 16 + '0 0 16');
	setsize(newmis, '0 0 0' , '0 0 0');

	self.hook_out = TRUE;
};

//
// Service_Grapple - called each frame by CLIENT.QC if client is ON_HOOK
//
void () Service_Grapple =
{
	local vector hook_dir;

	// drop the hook if player lets go of button
	if (!self.button0)
	{
		if (self.weapon == IT_HOOK) {
			Reset_Grapple (self.hook);
			return;
		}
	}
	// If hooked to a player, track them directly!
	if (self.hook.enemy.client_)
		hook_dir = (self.hook.enemy.origin - self.origin);
	// else, track to hook
	else if (!self.hook.enemy.client_)
		hook_dir = (self.hook.origin - self.origin);

	self.velocity = normalize(hook_dir) * 750;
	if (self.style)
	{
		if (vlen(hook_dir) <= 100)// cancel chain sound
		{
			// If there is a chain, ditch it now. We're
			// close enough. Having extra entities lying around
			// is never a good idea.
			if (self.hook.hookentity)
			{ 
				self.hook.hookentity.think = Remove_Chain;
				self.hook.hookentity.nextthink = time;
			}

			if (game_capture_custom)
			{
				msg_entity = self;
				sound(CHAN_NO_PHS_ADD+CHAN_WEAPON, "weapons/chain3.wav", 1, ATTN_NORM);
			}
			self.style = FALSE;// we've reset the sound channel.
		}
	}
};
#endif // QUAKEWORLD
