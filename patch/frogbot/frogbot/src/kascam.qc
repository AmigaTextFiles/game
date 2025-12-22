entity(entity first_in_list) AddToList;

#ifdef QUAKE

void() PrepareToObserve;
float(float v) FixedAngle2;


//Kasuha's DeathMatch Camera QC patch version 1.5

/////////////////////////////////////////////////////////////////////////////
// KasCam definitions
/////////////////////////////////////////////////////////////////////////////

// KasCam constants

float CAM_IDLE      = 0;   // Camera idle, nobody to look at
float CAM_FIXED     = 1;   // Fixed-position camera
float CAM_FLYBY     = 2;   // Fly-by camera
float CAM_FOLLOW    = 3;   // Camera following a player
float CAM_NOCLIP    = 6;   // No-clipping flying blabla

// KasCam variables

// how the standard fields are used:
// .enemy ........... targeted entity (player, monster, robot, ...)
// .movetarget ...... previous targeted entity
// .goalentity ...... targeted entity if locked on it
// .attack_state .... global camera state
// .dest ............ current expected camera position
// .pos1 ........... current expected targeted point
// .pos2 ........... next target for IDLE mode
// .mangle .......... angle speed
// .state ........... local camera state
// .pausetime ....... delay measure
// .delay ........... how long to keep current target / idle mode
// .search_time ..... when drop from current mode
// .lip ............. max distance for flyby mode
// .cnt ............. entity passing counter

/////////////////////////////////////////////////////////////////////////////
// internal KasCam functions
/////////////////////////////////////////////////////////////////////////////


// simple now, but there can be differences
// for various target entity classnames

void(entity ent) CamVectors =
{
	makevectors(ent.v_angle);
};


void(entity ent) CamReport =
{
	local string s2, s3;

	if (ent.flags & FL_PLAYER)
	{
		if (ent.frags < 1)
			s2 = "no";
		else
			s2 = ftos(ent.frags);

		if (ent.frags != 1)
			s3 = " frags";
		else
			s3 = " frag";

		centerprint6(self, "Now tracking", "\n\n\n", ent.netname, " - ", s2, s3);
	}
	else
	{
		msg_entity = self;
		WriteByte(MSG_ONE, SVC_CENTERPRINT);
		WriteByte(MSG_ONE, _N);
		WriteByte(MSG_ONE, _o);
		WriteByte(MSG_ONE, _w);
		WriteByte(MSG_ONE, space);
		WriteByte(MSG_ONE, _t);
		WriteByte(MSG_ONE, _r);
		WriteByte(MSG_ONE, _a);
		WriteByte(MSG_ONE, _c);
		WriteByte(MSG_ONE, _k);
		WriteByte(MSG_ONE, _i);
		WriteByte(MSG_ONE, _n);
		WriteByte(MSG_ONE, _g);
		WriteByte(MSG_ONE, enter);
		WriteByte(MSG_ONE, enter);
		WriteByte(MSG_ONE, enter);
		WriteName_apply(MSG_ONE, ent);
		WriteByte(MSG_ONE, space);
		WriteByte(MSG_ONE, minus);
		WriteByte(MSG_ONE, space);

		if (ent.frags < 1) {
			WriteByte(MSG_ONE, _n);
			WriteByte(MSG_ONE, _o);
		} else {
			NumberToString(MSG_ONE, ent.frags);
		}

		WriteByte(MSG_ONE, space);
		WriteByte(MSG_ONE, _f);
		WriteByte(MSG_ONE, _r);
		WriteByte(MSG_ONE, _a);
		WriteByte(MSG_ONE, _g);
		if (ent.frags != 1)
			WriteByte(MSG_ONE, _s);

		WriteByte(MSG_ONE, 0);
	}
};

// There is NO square root ?!   :-(((

float(float num) CamSqrt =
{
	local float apr;
	local float apr2;

	if (num < 0.001)
		return 0;

	if (num>1) {
		apr = num;
	} else {
		apr = 1;
	}
	apr2 = apr * apr;

	do {
		apr = (num + apr2) / (2 * apr);
		apr2 = apr * apr;
	} while ((fabs(apr2) - num) > (num * 0.001));
	return apr;
};

// point visibility test

float(vector vec) CamVisible =
{
	traceline(self.origin,vec,TRUE,self);
	return ((trace_fraction == 1) && !((trace_inopen && trace_inwater)));
};

// entity visibility test
// suited for players and player size bots; may vary for various classnames

float(entity ent) CamVisibleEnt =
{
	local vector vec;

// Three points: origin, bottom and eyes
	if (CamVisible(ent.origin)) return TRUE;
	vec = ent.origin;
	vec_z = ent.absmin_z;
	if (CamVisible(vec))
		return TRUE;
	vec_z = ent.absmax_z - 8;
	return CamVisible(vec);
};

// smooth position movement

float(float d, float a) CamHurry =
{
	local float dd,tt;

	tt = CamSqrt(d / a);
	if (frametime > tt) {
		return d;
	} else {
		return (a * frametime * ((2 * tt) - frametime));
	}
};

// Watch out! This is probably the most sophisticated routine ;-)
// I spent 5 hours developing the algorithm
// If you understand how it works in 3 minutes you're a guru :-)))

// smooth viewing angle movement
// return value is not a vector - this is a hack to return
// two floats at once :-)
// parameters are: current position, current velocity, acceleration
// returns new position and new velocity

vector(float s_, float v, float a) CamSmooth =
{
	local float dt,t1,t2,v2,as,sv2,b;
	local vector vec;

	if (s_ >= 180)
		s_ = s_ - 360;
	else if (s_ < -180)
		s_ = s_ + 360;

	v2 = v / 2;
	as = a * s_;
	sv2 = v2 * v2;
	dt = frametime;
	if (fabs(as) < sv2) {
		b = v > 0;
	} else {
		b = s_ > 0;
	}
	if (b) {
		t2 = CamSqrt((sv2 + as) / 2) / a;
		a = 0 - a;
	} else {
		t2 = CamSqrt((sv2 - as) / 2) / a;
	}
	t1 = t2 - (v2 / a);
	if (t1 > dt) {
		s_ = (a * dt + v) * dt + s_;
		v = a * dt * 2 + v;
	} else {
		s_ = (a * t1 + v) * t1 + s_;
		v = a * t1 * 2 + v;
		t1 = dt - t1;
		if (t1 < t2) {
			s_ = (v - (a * t1)) * t1 + s_;
			v = v - (a * t1 * 2);
		} else {
			s_ = 0;
			v = 0;
		}
	}
	vec_x = s_;
	vec_y = v;
	return vec;
};

// Check a flyby vector if it is usable
// returns vector length
// 1111 is a sentinel - flyby vectors are taken
// only if shorter than 1000
// vector is passed from player's eyes
// may vary for various classnames

float(vector vec) TryFlybyVector =
{
	local vector orig,vec1;
	local float vl;

	vec1 = 5 * normalize(vec);
	vec = 140 * vec1;
	orig = self.enemy.origin;
	orig_z = self.enemy.absmax_z - 8; // .................. eye level
	traceline(orig,orig+vec,FALSE,self.enemy);
	if (trace_ent != world)
		return 1111;
	if (trace_inopen)
		if (trace_inwater)
		return 1111;
	trace_endpos = trace_endpos - vec1;
	if (pointcontents(trace_endpos) == CONTENT_SOLID)
		return 1111;
	vl = vlen(self.enemy.origin - trace_endpos);
	if (vl<50)
		return 1111;
	return fabs(333 - vl);
};

// Move camera towards ideal position (or just skip there)
// parameters are position and angle speed factor
// 0 means to skip

void(float speedv, float speeda) CamUpdatePos =
{
	local vector vec, v1;
	local float vl;

// Check destination visibility
// if invisible, just skip there
	traceline(self.origin,self.dest,TRUE,self);
	if (trace_fraction != 1) {
		speedv = 0;
		speeda = 0;
	}

// first do camera movement
	if (speedv == 0) {
		setorigin(self,self.dest);
	} else {
		vec = self.dest - self.origin;
		vl = vlen(vec);
		vl = CamHurry(vl,speedv);
		vec = vl * normalize(vec);
		setorigin(self,self.origin + vec);
	}

// then view angle
// in death mode look exactly at the target even if camera moves
// in other modes look like camera is in its ideal position
	vec = vectoangles(self.pos1 - self.dest);

	if (vec_x > 180)
		vec_x = 360 - vec_x;
	else
		vec_x = 0 - vec_x ;

	if (vec_y >= 180)
		vec_y = vec_y - 360;
	else if (vec_y < -180)
		vec_y = vec_y + 360;

	if (vec_x > 70)
		vec_x = 70;
	else if (vec_x < -70)
		vec_x = -70;

	if (speeda == 0) {
		self.angles = vec;
		self.mangle = '0 0 0';
	} else {
		v1 = CamSmooth(self.angles_x - vec_x,self.mangle_x,speeda);
		self.mangle_x = v1_y;
		self.angles_x = vec_x + v1_x;
		v1 = CamSmooth(self.angles_y - vec_y,self.mangle_y,speeda);
		self.mangle_y = v1_y;
		self.angles_y = vec_y + v1_x;

		if (self.angles_x >= 180)
			self.angles_x = self.angles_x - 360;
		else if (self.angles_x < -180)
			self.angles_x = self.angles_x + 360;

		if (self.angles_y >= 180)
			self.angles_y = self.angles_y - 360;
		else if (self.angles_y < -180)
			self.angles_y = self.angles_y + 360;
	}
	self.angles_x = FixedAngle2 (self.angles_x);
	self.angles_y = FixedAngle2 (self.angles_y);
	self.fixangle = TRUE;
};

// go to idle state

void() CamGoIdle =
{
	self.dest = self.origin;
	makevectors(self.v_angle);
	self.pos1 = self.origin+v_forward;
	CamUpdatePos(0,0);
	self.state = CAM_IDLE;
	self.pausetime = time + 2;
	self.search_time = time;
	self.pos2 = self.pos1;
	self.enemy = self;
};

// Get target point for flyby

vector(entity ent) CamFlybyTarget =
{
	local vector vec;
	vec = ent.origin;
	vec_z = ent.absmax_z - 8;
	return vec;
};

// FlyBy mode initialization
// Targeted player is in self.enemy

void(entity newtarg) CamInitFlybyMode =
{
	local float f, max_;
	local vector vec, vec2, trg;

// Keep camera at this point for some time...
	self.pausetime = time + 0.4;

// Report selected player
	if (self.enemy != newtarg) {
		self.enemy = newtarg;
		if (self.movetarget != self.enemy) {
			CamReport(self.enemy);
			self.movetarget = newtarg;
		}
	}
	vec = self.enemy.v_angle;
	vec_x = 0;
	makevectors (vec);

	v_forward = 3 * v_forward;
	max_ = 1000;
	f = TryFlybyVector(v_up + v_forward + v_right);
	if (f<max_) {
		max_ = f;
		vec = trace_endpos;
	}
	f = TryFlybyVector(v_up - v_forward + v_right);
	if (f<max_) {
		max_ = f;
		vec = trace_endpos;
	}
	f = TryFlybyVector(v_up + v_forward - v_right);
	if (f<max_) {
		max_ = f;
		vec = trace_endpos;
	}
	f = TryFlybyVector(v_up - v_forward - v_right);
	if (f<max_) {
		max_ = f;
		vec = trace_endpos;
	}
	if (max_ >= 1000) {
		f = TryFlybyVector(v_up + v_forward);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector(v_up - v_forward);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector(v_up + v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector(v_up - v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
	}
	if (max_>=1000) {
		f = TryFlybyVector(v_forward + v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector(v_forward - v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_forward + v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_forward - v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
	}
	if (max_>=1000) {
		f = TryFlybyVector(v_forward);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector(v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_forward);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
	}
	if (max_>=1000) {
		f = TryFlybyVector('0 0 0' - v_up + v_forward + v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_up - v_forward + v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_up + v_forward - v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_up - v_forward - v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
	}
	if (max_>=1000) {
		f = TryFlybyVector('0 0 0' - v_up + v_forward);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_up + v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_up - v_forward);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
		f = TryFlybyVector('0 0 0' - v_up - v_right);
		if (f<max_) {
			max_ = f;
			vec = trace_endpos;
		}
	}
	if (max_ >= 1000) {
		CamGoIdle();
		self.pausetime = time + 2;
		return;
	}
	self.pos1 = CamFlybyTarget(self.enemy);
	self.dest = vec;
	self.state = CAM_FLYBY;
	self.lip = 1.5 * vlen(self.dest - self.pos1);
	if (self.lip < 500)
		self.lip = 500;
	CamUpdatePos(0,0);
};

// get FOLLOW mode position

vector() GetFollowCam =
{
	local vector vec, vec2;

	CamVectors(self.enemy);
	vec = self.enemy.origin + (self.enemy.maxs_z + 4) * v_up;
	traceline(self.enemy.origin,vec,FALSE,self);
	vec = trace_endpos - normalize(vec);
	vec2 = -100 * v_forward;
	traceline(vec,vec+vec2,TRUE,self);
	vec2 = trace_endpos - normalize(vec2);
	if (CamVisible(vec2)) {
		return vec2;
	} else {
		return vec;
	}
};

// get FOLLOW mode targetting point

vector() GetFollowTrg =
{
	local vector vec;

	if (self.enemy.deadflag == DEAD_NO) {
		CamVectors(self.enemy);
		vec = self.enemy.origin + 2048 * v_forward;
	} else {
		vec = self.enemy.origin;
	}
	return vec;
};

// Update camera state according to current target

void() CamUpdValues =
{
	local float it;

	if (self.enemy != self)
		if (self.enemy.health > 0) {
		// Mask out items which change view color
			it = IT_INVISIBILITY | IT_INVULNERABILITY | IT_SUIT | IT_QUAD;
			self.items = (self.enemy.items | it) - it;
			self.health = self.enemy.health;
			self.armorvalue = self.enemy.armorvalue;
			self.ammo_shells = self.enemy.ammo_shells;
			self.ammo_nails = self.enemy.ammo_nails;
			self.ammo_rockets = self.enemy.ammo_rockets;
			self.ammo_cells = self.enemy.ammo_cells;
			self.weapon = self.enemy.weapon;
			return;
		}

	self.items = 0;
	self.health = self.armorvalue = self.ammo_shells = self.ammo_nails = self.ammo_rockets
	= self.ammo_cells = 111;
	self.weapon = IT_AXE;
};

// IDLE mode think routine

void() CamIdleThink =
{
	local entity ent2;
	local vector vec,vec2;
	local float p1,p2;
	local float pa,pb,pd;

// Prepare a sentinel
	ent2 = self;
	if (self.movetarget != world) {
		if (self.movetarget.deadflag == DEAD_NO) {
			ent2 = self.movetarget;
		}
	}
// try to find some interesting target
	if (self.goalentity != world) {
		if (self.goalentity.deadflag == DEAD_NO) {
			ent2 = self.goalentity;
		} else {
			ent2 = self;
		}
	} else {
		test_enemy = first_client;
		while (test_enemy) {
			if (test_enemy != self.movetarget) {
				if (test_enemy.deadflag == DEAD_NO) {
					traceline(self.origin, test_enemy.origin, TRUE, test_enemy);
					if (trace_fraction == 1) {
						toughness_ = test_enemy.firepower * test_enemy.total_damage;
						if (toughness_ > p1) {
							ent2 = test_enemy;
							p1 = toughness_;
						}
					}
				}
			}
			test_enemy = test_enemy.next;
		}

		if (ent2 == self) {
			test_enemy = first_client;
			while (test_enemy) {
				if (test_enemy != self.movetarget)
					if (test_enemy.deadflag == DEAD_NO) {
						p2 = p2 + 1;
				}
				test_enemy = test_enemy.next;
			}
			if (p2 > 0) {
				p2 = p2 * random();
				test_enemy = first_client;
				do {
					while ((test_enemy == self.movetarget) || (test_enemy.deadflag != DEAD_NO)) {
						test_enemy = test_enemy.next;
					} 
					p2 = p2 - 1;
				} while (p2 > 0);
				if (test_enemy)
					ent2 = test_enemy;
			}
		}
	}

	if (ent2 == self) {
// Idle moves
		self.enemy = self;
		traceline(self.dest, self.pos1, TRUE, self);
		self.pos1 = trace_endpos;
		vec_x = 40 * random () - 20;
		vec_y = 360 * random ();
		vec_z = 0;
		pa = vec_y;
		if (self.origin != self.dest) {
			vec2 = self.origin - self.dest;
			vec2 = vectoangles(vec2);
			pb = vec2_y;
		} else {
			pb = 0;
		}

		if (pa >= 180)
			pa = pa - 360;
		else if (pa < -180)
			pa = pa + 360;

		makevectors(vec);
		vec = 2000 * v_forward;
		p2 = vlen(self.pos2 - self.dest);

		pd = pa - pb;

		if (pd >= 180)
			pd = pd - 360;
		else if (pd < -180)
			pd = pd + 360;

		if (fabs(pd) > 60) {
			vec2 = self.dest + vec;
			traceline(self.dest, vec2, TRUE, self);
			vec2 = trace_endpos;
			p1 = vlen(vec2 - self.dest);
			if (p1 > p2) {
				self.pos2 = vec2;
				p2 = p1;
			}
		}

		if (pa >= 0)
			pa = pa - 180;
		else
			pa = pa + 180;

		pd = pa - pb;

		if (pd >= 180)
			pd = pd - 360;
		else if (pd < -180)
			pd = pd + 360;

		if (fabs(pd) > 60) {
			vec2 = self.dest - vec;
			traceline(self.dest, vec2, TRUE, self);
			vec2 = trace_endpos;
			p1 = vlen(vec2 - self.dest);
			if (p1 > p2) {
				self.pos2 = vec2;
				p2 = p1;
			}
		}
		if (self.pausetime < time) {
			self.pausetime = time + 3 + (2 * random());
			self.pos1 = self.pos2;
		}
		if (self.search_time < time) {
			vec = self.dest - self.pos1;
			vec = (5 + (50 * random())) * normalize(vec);
			vec = self.pos1 + vec;
			traceline(self.origin,vec, TRUE, self);
			if (trace_fraction == 1) {
				self.dest = vec;
				self.pos2 = self.pos1;
				self.search_time = time + 8 + (5 * random());
			} else {
				self.pos2 = self.dest;
				self.search_time = time + 1 + random();
			}
		}
	} else {	// If an interesting object found
// Go to FlyBy mode
		CamInitFlybyMode (ent2);
		self.delay = time + 10;
		self.search_time = time + 60;
	}
};

// FLYBY mode thinking routine

void() CamFlyByThink =
{
	local float p0,p1,grad,p;
	local vector vec;
	local float ok;

// self.pos1 is set to player
// Check if the player is not dead
	if (self.enemy.deadflag != DEAD_NO) {
		CamGoIdle();
		return;
	}
// All other restrictions apply after some time
// Test player visibility
// If player not visible place another camera
	p1 = vlen(self.dest - self.enemy.origin);
	if ((CamVisibleEnt(self.enemy) && (self.lip > p1)) || (self.pausetime > time)) {
		self.pos1 = CamFlybyTarget(self.enemy);
	} else {
		CamInitFlybyMode (self.enemy);
	}
// Check for FOLLOW mode change
// Player has to be near
// And looking away
// And the destination point must be visible
	if (self.attack_state == CAM_FOLLOW) {
		self.state = CAM_FOLLOW;
		return;
	} else {
		p1 = vlen(self.enemy.origin - self.origin);
		if (p1 < 170) {
// Player is near enough
// Now if it points away
			grad = fabs(self.enemy.v_angle_y - self.v_angle_y);
			if (grad > 180)
				grad = 360 - grad;
			if (grad < 30) {
// Calculate following point
				vec = GetFollowCam();
				if (CamVisible(vec)) {
					self.state = CAM_FOLLOW;
					return;
				}
			}
		}
	}
// check for FIXED mode change
	if (self.goalentity == world) {
		p0 = 0;
		p1 = 0;
		if (self.delay < time) {
			test_enemy = first_client;
			while (test_enemy) {
				p0 = p0 + 1;
				if (test_enemy.deadflag == DEAD_NO) {
					p = vlen(test_enemy.origin - self.origin);
					if (p < 1500) {
						if (CamVisible(test_enemy.origin)) {
							p1 = p1 + 1;
						}
					}
				}
				test_enemy = test_enemy.next;
			}
		}
		if (p0<4) {
			p0 = 2;
		} else if (p0<8) {
			p0 = 3;
		} else {
			p0 = 4;
		}
		if (p1 > p0) {
			self.enemy = self;
			self.movetarget = world;
			self.state = CAM_FIXED;
			self.search_time = time + 15;
			self.pausetime = time + 3;
			return;
		}
	}
	if (self.search_time < time) {
		CamGoIdle();
	}
};

// FOLLOW mode thinking routine

void() CamFollowThink =
{
	local vector vec;

// Check player death
	if (self.enemy.deadflag != DEAD_NO) {
		CamGoIdle();
		return;
	} else {
		if (CamVisibleEnt(self.enemy)) {
			self.dest = GetFollowCam();
			self.pos1 = GetFollowTrg();
			if (pointcontents(self.dest) == CONTENT_SOLID)
				CamInitFlybyMode(self.enemy);
		} else {
			CamInitFlybyMode(self.enemy);
		}
	}
	if (self.search_time < time) {
		CamGoIdle();
	}
};

// FIXED mode thinking routine

void() CamFixedThink =
{
	local vector vec;
	local float cang;
	local float a;
	local float cscr; // count of targets on screen
	local float maxscr; // minimum angle on screen
	local float minscr; // maximum angle on screen
	local float maxlo; // maximum angle of lowers
	local float minhi; // minimum angle of highers
	local vector scrv; // onscreen origin sum
	local vector hiv; // lower optimum
	local vector lov; // higher optimum
	local float c;

	cang = self.v_angle_y;
	cscr = 0;
	maxscr = -45;
	minscr = 45;
	maxlo = -181;
	minhi = 181;
	scrv = '0 0 0';
	c = 0;
	test_enemy = first_client;
	while (test_enemy) {
		if (test_enemy.deadflag == DEAD_NO) {
			a = vlen(test_enemy.origin - self.origin);
			if (a < 1500) {
				if (CamVisible(test_enemy.origin)) {
// Possible target is visible
// Look if it is "on screen"
					c = c + 1;
					vec = vectoangles(test_enemy.origin - self.origin);
					a = vec_y - cang;

					if (a >= 180)
						a = a - 360;
					else if (a < -180)
						a = a + 360;

					if (fabs(a)<45) {
// entity is "on screen"
						cscr = cscr + 1;
						scrv = scrv + test_enemy.origin;
						if (a < minscr)
							minscr = a;
						if (a > maxscr)
							maxscr = a;
					} else {
						if (a > 0) {
							if (a < minhi) {
								minhi = a;
								hiv = test_enemy.origin;
							}
						} else {
							if (a > maxlo) {
								maxlo = a;
								lov = test_enemy.origin;
							}
						}
					}
				}
			}
		}
		test_enemy = test_enemy.next;
	}
	if (c > 0) {
		if (c > 1)
			self.pausetime = time + 3;
		if (cscr < c) {
			if ((cscr == 0) || ((maxscr - maxlo) <= 90) || ((minhi - minscr) <= 90)) {
				cscr = cscr + 1;
				if ((maxscr - maxlo) > (minhi - minscr)) {
					scrv = scrv + hiv;
				} else {
					scrv = scrv + lov;
				}
			}
		}
		scrv_x = scrv_x / cscr;
		scrv_y = scrv_y / cscr;
		scrv_z = scrv_z / cscr;
		self.pos1 = scrv;
	}
	self.dest = self.origin;
	if ((self.pausetime < time) || (self.search_time < time)) {
		CamGoIdle();
	}
};

/////////////////////////////////////////////////////////////////////////////
// interface functions begin here
/////////////////////////////////////////////////////////////////////////////

// Main camera thinking routine
// Called every frame

void() CamThink =
{
// Update visible values (health, armor, ...)
	CamUpdValues();

// Status depending handlings
	if (self.state == CAM_IDLE) {
		CamIdleThink();
		CamUpdatePos(1,80);
	} else if (self.state == CAM_FLYBY) {
		CamFlyByThink();
		CamUpdatePos(0,500);
	} else if (self.state == CAM_FOLLOW) {
		CamFollowThink();
		CamUpdatePos(800,1000);
	} else if (self.state == CAM_FIXED) {
		CamFixedThink();
		CamUpdatePos(0,80);
	}

	if (self.button0) {
		if (!self.button0_) {
			self.button0_ = 1;
			if (self.attack_state == CAM_NOCLIP) {
				self.attack_state = CAM_FLYBY;
				self.movetype = MOVETYPE_NONE;
				self.dest = self.origin;
				makevectors(self.v_angle);
				self.pos1 = self.dest + 100 * v_forward;
				self.aflag = TRUE;
				self.mangle = self.velocity = '0 0 0';
				self.pausetime = self.delay = time;
				CamGoIdle();
			} else if (self.attack_state == CAM_FLYBY) {
				self.attack_state = CAM_FOLLOW;
			} else {
				self.state = self.attack_state = CAM_NOCLIP;
				self.movetype = MOVETYPE_NOCLIP;
				self.enemy = self;
			}
		}
	} else {
		self.button0_ = 0;
	}

	if (self.state != CAM_NOCLIP) {
		if (self.button2) {
			if (self.flags & FL_JUMPRELEASED) {	// Switch to next target
				self.flags = self.flags - FL_JUMPRELEASED;
				if (self.enemy)
					test_enemy = self.enemy.next;
				if (!test_enemy)
					test_enemy = first_client;
				if (test_enemy) {
					if (self.goalentity != world)
						self.goalentity = test_enemy;
					CamInitFlybyMode(test_enemy);
					self.delay = time + 10;
					self.search_time = time + 60;  // keep target max. 60 seconds
				}
			}
		} else {
			self.flags = self.flags | FL_JUMPRELEASED;
		}

		if (self.impulse == 1) {
			if (!self.spawnflags) {
				if (self.enemy != self) {
					msg_entity = self;
					msg_level = PRINT_HIGH;
					if (self.goalentity) {
						self.goalentity = world;
						sprint("Auto target\n");
					}
					else {
						self.goalentity = self.enemy;
						sprint("Lock target\n");
					}
				}
				self.impulse = 0;
			}
		}
	}
};

// camera initialization

void() CamClientInit =
{
	if (self.flags & FL_KASCAM)
		return;

	PrepareToObserve();
	self.flags = self.flags | FL_KASCAM;
	first_kascam = AddToList(first_kascam);
	self.enemy = self.goalentity = self.movetarget = world;
	self.state = self.attack_state = CAM_NOCLIP;
	self.movetype = MOVETYPE_NOCLIP;

	if (self.netname != "")
	{
		msg_level = PRINT_HIGH;
		bprint(self.netname);
		bprint(" is using Kascam\n");
	}
};

#endif // QUAKE
