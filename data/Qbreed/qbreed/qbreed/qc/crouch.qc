//===================
//Chris
//Crouch for player '06
//===================

.float crouch, attemptcrouch;
float (entity targ) crouchcheck =
{

makevectors (self.v_angle);
tracebox (self.origin, VEC_HULL_MIN, VEC_HULL_MAX, self.origin + '0 0 16', FALSE, self); 

	/*
vector	VEC_HULL_MIN = '-16 -16 -24';
vector	VEC_HULL_MAX = '16 16 32';
	*/	


if (trace_fraction == 1)            //hits nothing go ahead
	return TRUE;

if (!trace_ent.takedamage)      //hits world or nondamagable object
	return FALSE;

	return FALSE;

};

void() crouch_on =
{

if ((!self.crouch) && (!self.velocity_z)) //crouch down
{
setsize (self, '-16 -16 -8', '16 16 8');
self.crouch = 1;
self.view_ofs = '0 0 14';
self.attemptcrouch = 1;
return;
}
self.attemptcrouch = 0;
};

void() crouch_off =
{
if (self.crouch && (!self.velocity_z) && (crouchcheck(self)))  //get up
{
setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
self.crouch = 0;
self.origin_z = self.origin_z + 16;
self.view_ofs = '0 0 22';
self.attemptcrouch = 0;
return;
}
self.attemptcrouch = 1;
};
