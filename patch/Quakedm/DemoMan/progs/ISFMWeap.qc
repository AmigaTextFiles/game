/*
	ISForce Multi Weapons Patch.. It's just a joke....
*/

void() T_MultiRocketTouch =
{
	local float	damg;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	damg = (100 + random()*20)*5; // Hey, there are FIVE Rockets!!!!
	
	if (other.health)
	{
		if (other.classname == "monster_shambler")
			damg = damg * 0.5;	// mostly immune
		T_Damage (other, self, self.owner, damg );
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact
	T_RadiusDamage (self, self.owner, 240, other);	// More Rockets, more
							// Blast...       

//	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
	self.origin = self.origin - 8*normalize(self.velocity);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();

};

void() MMissileJoin1 =
{
	self.velocity_x = self.velocity_x + 75;
	self.velocity_y = self.velocity_y + 75;
	self.velocity_z = self.velocity_z + 75;
	self.nextthink = time + 4.8;
	self.think = SUB_Remove;
};

void() MMissileSplit1 =
{
	self.velocity_x = self.velocity_x - 150;
	self.velocity_y = self.velocity_y - 150;
	self.velocity_z = self.velocity_z - 150;
	self.nextthink = time + 0.2;
	self.think = MMissileJoin1;
};

void() MMissileJoin2 =
{
	self.velocity_x = self.velocity_x + 75;
	self.velocity_y = self.velocity_y + 75;
	self.velocity_z = self.velocity_z - 75;
	self.nextthink = time + 4.8;
	self.think = SUB_Remove;
};

void() MMissileSplit2 =
{
	self.velocity_x = self.velocity_x - 100;
	self.velocity_y = self.velocity_y - 100;
	self.velocity_z = self.velocity_z + 100;
	self.nextthink = time + 0.2;
	self.think = MMissileJoin2;
};

void() MMissileJoin3 =
{
	self.velocity_x = self.velocity_x - 75;
	self.velocity_y = self.velocity_y - 75;
	self.velocity_z = self.velocity_z + 75;
	self.nextthink = time + 4.8;
	self.think = SUB_Remove;
};

void() MMissileSplit3 =
{
	self.velocity_x = self.velocity_x + 100;
	self.velocity_y = self.velocity_y + 100;
	self.velocity_z = self.velocity_z - 100;
	self.nextthink = time + 0.2;
	self.think = MMissileJoin3;
};

void() MMissileJoin4 =
{
	self.velocity_x = self.velocity_x - 75;
	self.velocity_y = self.velocity_y - 75;
	self.velocity_z = self.velocity_z - 75;
	self.nextthink = time + 4.8;
	self.think = SUB_Remove;
};

void() MMissileSplit4 =
{
	self.velocity_x = self.velocity_x + 100;
	self.velocity_y = self.velocity_y + 100;
	self.velocity_z = self.velocity_z + 100;
	self.nextthink = time + 0.2;
	self.think = MMissileJoin4;
};

void() W_FireMultiRocket =
{
	local entity Split1, Split2, Split3, Split4, Split5, mpuff;
	if (self.ammo_rockets>4)
	{
	self.currentammo = self.ammo_rockets = self.ammo_rockets - 5;
	
	sound (self, CHAN_WEAPON, "weapons/mrocket.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

// Due to a matter of fact, quake c doesn't accept arrays :-(
	Split1 = spawn ();
	Split2 = spawn ();
	Split3 = spawn ();
	Split4 = spawn ();
	Split5 = spawn ();
	Split1.owner = self;
	Split1.movetype = MOVETYPE_FLYMISSILE;
	Split1.solid = SOLID_BBOX;
	Split2.owner = self;
	Split2.movetype = MOVETYPE_FLYMISSILE;
	Split2.solid = SOLID_BBOX;
	Split3.owner = self;
	Split3.movetype = MOVETYPE_FLYMISSILE;
	Split3.solid = SOLID_BBOX;
	Split4.owner = self;
	Split4.movetype = MOVETYPE_FLYMISSILE;
	Split4.solid = SOLID_BBOX;
	Split5.owner = self;
	Split5.movetype = MOVETYPE_FLYMISSILE;
	Split5.solid = SOLID_BBOX;
		
// set Splittage speed	

	makevectors (self.v_angle);
	Split1.velocity = aim(self, 1000);
	Split1.velocity = Split1.velocity * 750;
	Split1.angles = vectoangles(Split1.velocity);
	Split1.touch = T_MissileTouch;
	Split2.velocity = aim(self, 1000);
	Split2.velocity = Split2.velocity * 750;
	Split2.angles = vectoangles(Split2.velocity);
	Split2.touch = T_MissileTouch;
	Split3.velocity = aim(self, 1000);
	Split3.velocity = Split3.velocity * 750;
	Split3.angles = vectoangles(Split3.velocity);
	Split3.touch = T_MissileTouch;
	Split4.velocity = aim(self, 1000);
	Split4.velocity = Split4.velocity * 750;
	Split4.angles = vectoangles(Split4.velocity);
	Split4.touch = T_MissileTouch;
	Split5.velocity = aim(self, 1000);
	Split5.velocity = Split5.velocity * 750;
	Split5.angles = vectoangles(Split5.velocity);
	Split5.touch = T_MissileTouch;

// set missile duration
	Split1.nextthink = time + 0.1;
	Split1.think = MMissileSplit1;
	setmodel (Split1, "progs/missile.mdl");
	setsize (Split1, '0 0 0', '0 0 0');		
	setorigin (Split1, self.origin + v_forward*8 + '0 0 16');
	Split2.nextthink = time + 0.15;
	Split2.think = MMissileSplit2;
	setmodel (Split2, "progs/missile.mdl");
	setsize (Split2, '0 0 0', '0 0 0');		
	setorigin (Split2, self.origin + v_forward*8 + '0 0 16');
	Split3.nextthink = time + 0.2;
	Split3.think = MMissileSplit3;
	setmodel (Split3, "progs/missile.mdl");
	setsize (Split3, '0 0 0', '0 0 0');		
	setorigin (Split3, self.origin + v_forward*8 + '0 0 16');
	Split4.nextthink = time + 0.25;
	Split4.think = MMissileSplit4;
	setmodel (Split4, "progs/missile.mdl");
	setsize (Split4, '0 0 0', '0 0 0');		
	setorigin (Split4, self.origin + v_forward*8 + '0 0 16');
	Split5.nextthink = time + 5.15;
	Split5.think = SUB_Remove;
	setmodel (Split5, "progs/missile.mdl");
	setsize (Split5, '0 0 0', '0 0 0');		
	setorigin (Split5, self.origin + v_forward*8 + '0 0 16');

	}
};


//=============================================================================


void() MultiGrenadeExplode =
{
	local entity grenade;
	grenade=self;
	BecomeExplosion ();
	sound(grenade, CHAN_AUTO, "weapons/mgrenabl.wav",1,ATTN_NORM);
	local	entity Split1, Split2, Split3, Split4, Split5, mpuff;
	local entity grenade;
	grenade=self;
	Split1 = spawn ();
	Split1.owner = self;
	Split1.movetype = MOVETYPE_BOUNCE;
	Split1.solid = SOLID_BBOX;
	Split1.classname = "grenade";
	Split2 = spawn ();
	Split2.owner = self;
	Split2.movetype = MOVETYPE_BOUNCE;
	Split2.solid = SOLID_BBOX;
	Split2.classname = "grenade";
	Split3 = spawn ();
	Split3.owner = self;
	Split3.movetype = MOVETYPE_BOUNCE;
	Split3.solid = SOLID_BBOX;
	Split3.classname = "grenade";
	Split4 = spawn ();
	Split4.owner = self;
	Split4.movetype = MOVETYPE_BOUNCE;
	Split4.solid = SOLID_BBOX;
	Split4.classname = "grenade";
	Split5 = spawn ();
	Split5.owner = self;
	Split5.movetype = MOVETYPE_BOUNCE;
	Split5.solid = SOLID_BBOX;
	Split5.classname = "grenade";
		
// set missile speed	

	makevectors (grenade.v_angle);

	if (grenade.v_angle_x)
	{
		Split1.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
		Split2.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
		Split3.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
		Split4.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
		Split5.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	}
	else
	{
		Split1.velocity = aim(grenade, 10000);
		Split1.velocity_z = 200;
		Split1.velocity_x = Split1.velocity_x + 200;
		Split1.velocity_y = Split1.velocity_y + 200;
		Split2.velocity = aim(grenade, 10000);
		Split2.velocity_z = 200;
		Split2.velocity_x = Split2.velocity_x - 200;
		Split2.velocity_y = Split2.velocity_y + 200;
		Split3.velocity = aim(grenade, 10000);
		Split3.velocity_z = 200;
		Split3.velocity_x = Split3.velocity_x + 200;
		Split3.velocity_y = Split3.velocity_y - 200;
		Split4.velocity = aim(grenade, 10000);
		Split4.velocity_z = 200;
		Split4.velocity_x = Split4.velocity_x - 200;
		Split4.velocity_y = Split4.velocity_y - 200;
		Split5.velocity = aim(grenade, 10000);
		Split5.velocity_z = 200;
		Split5.velocity_x = Split5.velocity_x + 100 - (crandom()*200);
		Split5.velocity_y = Split5.velocity_y + 100 - (crandom()*200);
	}

	Split1.avelocity = '300 300 300';
	Split1.angles = vectoangles(Split1.velocity);
	Split1.touch = GrenadeTouch;
	Split2.avelocity = '300 300 300';
	Split2.angles = vectoangles(Split1.velocity);
	Split2.touch = GrenadeTouch;
	Split3.avelocity = '300 300 300';
	Split3.angles = vectoangles(Split1.velocity);
	Split3.touch = GrenadeTouch;
	Split4.avelocity = '300 300 300';
	Split4.angles = vectoangles(Split1.velocity);
	Split4.touch = GrenadeTouch;
	Split5.avelocity = '300 300 300';
	Split5.angles = vectoangles(Split1.velocity);
	Split5.touch = GrenadeTouch;
	
// set missile duration
	Split1.nextthink = time + 0.5+(crandom()*2);
	Split1.think = GrenadeExplode;
	setmodel (Split1, "progs/grenade.mdl");
	setsize (Split1, '0 0 0', '0 0 0');		
	setorigin (Split1, self.origin);
	Split2.nextthink = time + 0.5+(crandom()*2);
	Split2.think = GrenadeExplode;
	setmodel (Split2, "progs/grenade.mdl");
	setsize (Split2, '0 0 0', '0 0 0');		
	setorigin (Split2, self.origin);
	Split3.nextthink = time + 0.5+(crandom()*2);
	Split3.think = GrenadeExplode;
	setmodel (Split3, "progs/grenade.mdl");
	setsize (Split3, '0 0 0', '0 0 0');		
	setorigin (Split3, self.origin);
	Split4.nextthink = time + 0.5+(crandom()*2);
	Split4.think = GrenadeExplode;
	setmodel (Split4, "progs/grenade.mdl");
	setsize (Split4, '0 0 0', '0 0 0');		
	setorigin (Split4, self.origin);
	Split5.nextthink = time + 0.5+(crandom()*2);
	Split5.think = GrenadeExplode;
	setmodel (Split5, "progs/grenade.mdl");
	setsize (Split5, '0 0 0', '0 0 0');		
	setorigin (Split5, self.origin);


};

void() MultiGrenadeTouch =
{
	local entity grenade;
	grenade=self;
	if (other == grenade.owner)
		return;		// don't explode on owner
	if (other.takedamage == DAMAGE_AIM)
	{
		MultiGrenadeExplode;
		return;
	}
	sound (grenade, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);	// bounce sound
	if (grenade.velocity == '0 0 0')
		grenade.avelocity = '0 0 0';
};

/*
================
W_FireMultiGrenade
================
*/
void() W_FireMultiGrenade =
{
	local	entity missile, mpuff;
	if (self.ammo_rockets>4)
	{
	self.currentammo = self.ammo_rockets = self.ammo_rockets - 5;
	
	sound (self, CHAN_WEAPON, "weapons/mgrenade.wav", 1, ATTN_NORM);

	self.punchangle_x = -2;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	missile.classname = "grenade";
		
// set missile speed	

	makevectors (self.v_angle);

	if (self.v_angle_x)
		missile.velocity = v_forward*600 + v_up * 200 + crandom()*v_right*10 + crandom()*v_up*10;
	else
	{
		missile.velocity = aim(self, 10000);
		missile.velocity = missile.velocity * 600;
		missile.velocity_z = 200;
	}

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
	
	missile.touch = MultiGrenadeTouch;
	
// set missile duration
	missile.nextthink = time + 2;
	missile.think = MultiGrenadeExplode;

	setmodel (missile, "progs/grenade.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
	setorigin (missile, self.origin);
	}
};


//=============================================================================
