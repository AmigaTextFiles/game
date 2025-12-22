void() ObserverTeleporter =
{
	vec1 = normalize(((test_enemy.absmax + test_enemy.absmin) * 0.5) - self.origin);
	vec2 = normalize(self.velocity);
	if ((vec1 * vec2) <= 0.1)
		return;
  
	t = find (world, targetname, test_enemy.target);
	makevectors (t.mangle);
	setorigin (self, t.origin + '0 0 22');
	self.angles = t.mangle;
	self.fixangle = TRUE; // turn this way immediately
	self.teleport_time = time + 0.7;
	self.velocity = v_forward * 300;
};

#ifdef QUAKE

void () ObserverPreThink =
{
	local float invcos,nv,nvp,nvpmax,nvs,nsp,sp,svz;
	local vector f,vp,vs;
	local float accel_up;

	svz = self.velocity_z * 0.75;
	self.velocity_z = 0;

	makevectors (self.v_angle);

	// v_forward is already normalized
	f_x = v_forward_x; 
	f_y = v_forward_y; 
	f_z = 0;
	invcos = 1 / vlen(f);

	f = f * invcos; // normalize f

	sp = f * self.velocity;
	vp = sp*f;
	nvp = vlen(vp);
	if (sp<0)
		nvp = 0 - nvp;
	vs = self.velocity - vp;

	vp = v_forward * (nvp * invcos);
	vp_z = vp_z + svz;
	nvp = vlen(vp);
	nvpmax = 320 - 100 * v_forward_z;
	if (nvp > nvpmax)
		vp = vp * (nvpmax/nvp);

	self.velocity = vp + vs;

	if (self.button2)
		self.velocity_z = 200;
  
	// look for doors, etc.
	test_enemy = first_teleport;
	while (test_enemy)
	{
		if (vlen(self.origin - (test_enemy.absmin + test_enemy.absmax) * 0.5) <= 75)
		{
			ObserverTeleporter();
			return;
		}
		test_enemy = test_enemy.next;
	}
};

#endif // QUAKE

#ifdef QUAKEWORLD
// Spectator functions
// Added Aug11'97 by Zoid <zoid@idsoftware.com>
//
// These functions are called from the server if they exist.
// Note that Spectators only have one think since they movement code doesn't
// track them much.  Impulse commands work as usual, but don't call
// the regular ImpulseCommand handler in weapons.qc since Spectators don't
// have any weapons and things can explode.
//
//   --- Zoid.

float(float remove_name) RemoveBot;
void() IntermissionThink;
void() SelectSpawnPoint;
void() ImpulseCommands;
void() LoadPlayer;

/*
===========
SpectatorConnect

called when a spectator connects to a server
============
*/
void() SpectatorConnect =
{
	if (scoreboardsize == maxplayers)
		RemoveBot(FALSE);

	self.classname = "spectator";
	self.flags = FL_PLAYER;

	msg_level = PRINT_MEDIUM;
	bprint ("Spectator ");
	bprint_netname (self);
	bprint (" entered the game\n");

	scoreboardsize = scoreboardsize + 1;

	LoadPlayer();

	self.classname = "player";

	SelectSpawnPoint ();
	setorigin(self, spawn_pos.origin);
	self.angles = spawn_pos.angles;
	self.fixangle = TRUE;           // turn this way immediately

	if (intermission_running)
		changelevel (nextmap);
};

/*
===========
SpectatorDisconnect

called when a spectator disconnects from a server
============
*/
void() SpectatorDisconnect =
{
	msg_level = PRINT_MEDIUM;
	bprint ("Spectator ");
	bprint_netname (self);
	bprint (" left the game\n");
};

/*
================
SpectatorThink

Called every frame after physics are run
================
*/
void() SpectatorThink =
{
	if (intermission_running)
		IntermissionThink ();

	ImpulseCommands();

	// look for doors, etc.
	test_enemy = first_teleport;
	while (test_enemy)
	{
		if (vlen(self.origin - (test_enemy.absmin + test_enemy.absmax) * 0.5) <= 75)
		{
			ObserverTeleporter();
			return;
		}
		test_enemy = test_enemy.next;
	}
};
#endif // QUAKEWORLD
