#include "g_local.h"

void basethink (edict_t *self)
{
	self->nextthink = level.time + FRAMETIME;
//self->s.angles[YAW] = self->owner->s.angles[YAW];
//self->owner->avelocity[0] = self->avelocity[0];
//self->owner->avelocity[1] = self->avelocity[1];
if (self->owner->s.angles[YAW] < self->s.angles[YAW]){
self->avelocity[1] = -10;
}
if (self->owner->s.angles[YAW] > self->s.angles[YAW]){
self->avelocity[1] = 10;
}

}

void seatthink (edict_t *self)
{

 self->nextthink = level.time + FRAMETIME;

}

void vechile_blocked(edict_t *self, edict_t *other)
{
	edict_t	*attacker;

	if (other->takedamage)
	{
		if (self->teammaster->owner)
			attacker = self->teammaster->owner;
		else
			attacker = self->teammaster;
                T_Damage (other, self, attacker, vec3_origin, other->s.origin, vec3_origin, self->teammaster->dmg, 10, 0,MOD_HIT);
	}
}

void vechile_seat_finish_init (edict_t *self)
{
	// get and save info for muzzle location
	if (!self->target)
	{
		gi.dprintf("%s at %s needs a target\n", self->classname, vtos(self->s.origin));
	}
	else
	{
		self->target_ent = G_PickTarget (self->target);
		VectorSubtract (self->target_ent->s.origin, self->s.origin, self->move_origin);
                self->target_ent->owner = self;
                self->target_ent->teammaster->owner = self;
       //         G_FreeEdict(self->target_ent);
	}

	self->teammaster->dmg = self->dmg;
        self->think = seatthink;
	self->think (self);
}


void vechile_seat_touch (edict_t *self, edict_t *other, cplane_t *plane, csurface_t *surf)
{                       
	vec3_t	f, r, u;
        vec3_t  start, right;
	vec3_t		angles;
	vec3_t		offset;
        int		damage;
	int		speed;
        int             radius;
	int		flash_number;
			float	angle;
			float	diff;
			float	target_z;
			vec3_t	dir;
			vec3_t	target;
                        vec3_t  forward;
                        int     i;
gi.bprintf (PRINT_HIGH, "Vechile base touched\n");
//        self->s.angles[PITCH] = other->s.angles[PITCH] ;
if (self->s.angles[YAW] == other->s.angles[YAW]){
}
else
if (self->s.angles[YAW] < other->s.angles[YAW]){
self->avelocity[1] = 10;
}
if (self->s.angles[YAW] > other->s.angles[YAW]){
self->avelocity[1] = -10;
}

//self->owner->avelocity[0] = other->avelocity[0];
//self->owner->avelocity[1] = other->avelocity[1];

//        self->s.angles[ROLL] = other->s.angles[ROLL];
//         self->move_angles[0] = 90;
if (self->owner)
{
        self->s.angles[YAW] = self->owner->s.angles[YAW];
}

self->mounted = 1;
}

void SP_vechile_base (edict_t *self)
{
	self->solid = SOLID_BSP;
	self->movetype = MOVETYPE_PUSH;
	gi.setmodel (self, self->model);
        self->blocked = vechile_blocked;

//        self->touch = vechile_base_touch;
	if (!self->dmg)
		self->dmg = 10;

        self->think = basethink;
	self->nextthink = level.time + FRAMETIME;
       

	gi.linkentity (self);
}

void SP_vechile_seat (edict_t *self)
{
	self->solid = SOLID_BSP;
	self->movetype = MOVETYPE_PUSH;
	gi.setmodel (self, self->model);
        self->blocked = vechile_blocked;
        self->think = vechile_seat_finish_init;
	self->nextthink = level.time + FRAMETIME;
        self->touch = vechile_seat_touch;


	gi.linkentity (self);
}


/*
void SP_vechile_breach (edict_t *self)
{
	self->solid = SOLID_BSP;
        self->movetype = MOVETYPE_WALK;
	gi.setmodel (self, self->model);

	if (!self->speed)
		self->speed = 50;
	if (!self->dmg)
		self->dmg = 10;

	if (!st.minpitch)
		st.minpitch = -30;
	if (!st.maxpitch)
		st.maxpitch = 30;
	if (!st.maxyaw)
		st.maxyaw = 360;

      	self->pos1[PITCH] = -1 * st.minpitch;
	self->pos1[YAW]   = st.minyaw;
	self->pos2[PITCH] = -1 * st.maxpitch;
	self->pos2[YAW]   = st.maxyaw;

	self->ideal_yaw = self->s.angles[YAW];
	self->move_angles[YAW] = self->ideal_yaw;

        self->blocked = vechile_blocked;

        self->think = vechile_breach_finish_init;
	self->nextthink = level.time + FRAMETIME;
	gi.linkentity (self);
}
*/
