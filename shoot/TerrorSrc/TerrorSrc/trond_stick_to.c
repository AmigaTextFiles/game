//TROND
#include	"g_local.h"


//Objekter setter seg fast på mål... C4, piler osv. Laggete for kulehol.
void VectorRotate (vec3_t in, vec3_t angles, vec3_t out)
{
	float	cv, sv, angle, tv;

	VectorCopy (in, out);

	angle = (-angles[PITCH]) * M_PI/180;
	cv = cos(angle);
	sv = sin(angle);
	tv = (out[0]*cv) - (out[2]*sv);
	out[2] = (out[2]*cv) + (out[0]*sv);
	out[0] = tv;

	angle = (angles[YAW])*M_PI/180;
	cv = cos(angle);
	sv = sin(angle);
	tv = (out[0]*cv) + (out[0]*sv);
	out[1] = (out[1]*cv) + (out[0]*sv);
	out[0] = tv;

	angle = (angles[ROLL])*M_PI/180;
	cv = cos(angle);
	sv = sin(angle);
	tv = (out[1]*cv) - (out[2]*sv);
	out[2] = (out[2]*cv) + (out[1]*sv);
	out[1] = tv;
}

void VectorUnrotate(vec3_t in, vec3_t angles, vec3_t out) 
{
	float cv, sv, angle, tv;

	VectorCopy(in, out);

 	angle = (-angles[ROLL]) * M_PI / 180;
	cv = cos(angle);
	sv = sin(angle);
	tv = (out[1] * cv) - (out[2] * sv);
	out[2] = (out[2] * cv) + (out[1] * sv);
	out[1] = tv;

 	angle = (-angles[YAW]) * M_PI / 180;
	cv = cos(angle);
	sv = sin(angle);
	tv = (out[0] * cv) - (out[1] * sv);
	out[1] = (out[1] * cv) + (out[0] * sv);
	out[0] = tv;

	angle = (angles[PITCH]) * M_PI / 180;
	cv = cos(angle);
	sv = sin(angle);
	tv = (out[0] * cv) - (out[2] * sv);
	out[2] = (out[2] * cv) + (out[0] * sv);
	out[0] = tv;
}

void stuck_prethink (edict_t *self)
{
	vec3_t temp, new;
	edict_t *other;

 	other = self->goalentity;

 	if (!other->inuse) 
	{
	}

 	VectorRotate(self->pos1, other->s.angles, temp);
	VectorRotate(self->pos2, other->s.angles, new);
	VectorAdd(other->s.origin, temp, self->s.origin);
	VectorSubtract(new, temp, new);

	vectoangles(new, self->s.angles);
}

void Calc_StuckOffset(edict_t *self, edict_t *other) 
{
	vec3_t forward;

	VectorSubtract(self->s.origin, other->s.origin, forward);
	VectorUnrotate(forward, other->s.angles, self->pos1);
	AngleVectors(self->s.angles, forward, NULL, NULL);

	VectorMA(self->s.origin, 64, forward, forward);
	VectorSubtract(forward, other->s.origin, forward);
	VectorUnrotate(forward, other->s.angles, self->pos2);
}

 

void stick(edict_t *projectile, edict_t *object) 
{

//	projectile->solid = SOLID_NOT;
	projectile->movetype = MOVETYPE_FLY;

	VectorClear(projectile->velocity);
	VectorClear(projectile->avelocity);

	if (object != g_edicts) 
	{
		Calc_StuckOffset(projectile, object);
		projectile->goalentity = object;
		projectile->prethink = stuck_prethink;
	} 
	else
		projectile->prethink = NULL;

}

void dart_prethink (edict_t *ent) 
{
	vec3_t move;

	vectoangles(ent->velocity, move);
	VectorSubtract(move, ent->s.angles, move);

	move[0] = fmod((move[0] + 180), 360) - 180;
	move[1] = fmod((move[1] + 180), 360) - 180;
	move[2] = fmod((move[2] + 180), 360) - 180;

	VectorScale(move, 1/FRAMETIME, ent->avelocity);
}

