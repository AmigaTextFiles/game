#include "g_local.h"
/*
============================
In your autoexec.cfg file put:

// Laser Hook
alias +shrink2 "hook2 shrink"
alias -shrink2 "hook2 stop"
alias +grow2 "hook2 grow"
alias -grow2 "hook2 stop"
alias +hook2 "hook2 action; wait; hook2 shrink"
alias -hook2 "hook2 stop"
bind F2 +hook2
bind F3 +shrink2
bind F4 +grow2
*/
// Grappling Hook Sounds
#define HOOK_HIT_SOUND gi.soundindex("misc/menu1.wav")
#define HOOK_SMACK_SOUND gi.soundindex("misc/menu3.wav")
#define HOOK_MOTOR1_SOUND gi.soundindex("misc/am_pkup.wav")
#define HOOK_MOTOR2_SOUND gi.soundindex("rotate/h_rot1.wav")
#define HOOK_MOTOR3_SOUND gi.soundindex("plats/pt1_strt.wav")
#define HOOK_RETRACT_SOUND gi.soundindex("items/respawn1.wav")
#define HOOK_LAUNCH_SOUND gi.soundindex("items/respawn1.wav")
#define HOOK_MODEL "models/weapons/grapple/hook/tris.md2"
#define GRAPPLE_BOUNCE2_SOUND gi.soundindex("grapple/bounce2.wav")
#define GRAPPLE_CHAIN1_SOUND gi.soundindex("grapple/chain1.wav")
#define GRAPPLE_CHAIN3_SOUND gi.soundindex("grapple/chain3.wav")
#define ENTS_HOOKSTATE ent->client->hookstate
#define ENTS_HOOKTYPE ent->client->hooktype
#define HOOK_OWNERS_HOOKSTATE hook->owner->client->hookstate
#define HOOK_OWNERS_HOOKTYPE hook->owner->client->hooktype
// edict->sounds constants
#define MOTOR_OFF 0 // motor sound has not been triggered
#define MOTOR_START 1 // motor start sound has been triggered
#define MOTOR_ON 2 // motor running sound has been triggered

// NOTE: YOU MAY ALREADY HAVE THIS PROJECT FUNCTION FROM ONE
// OF MY PREVIOUS TUTORIALS!
//==========================================================
// this is the same as function P_ProjectSource in p_weapons.c
// except it projects the offset distance in reverse since hook
// is launched with player's free hand
//==========================================================
void P_ProjectSource_Reverse(gclient_t *client,
vec3_t point,
vec3_t distance,
vec3_t forward,
vec3_t right,
vec3_t result)
{
vec3_t dist={0,0,0};
VectorCopy(distance, dist);
if (client->pers.hand == RIGHT_HANDED)
dist[1] *= -1; // Left Hand already defaulted
else if (client->pers.hand == CENTER_HANDED)
dist[1]= 0;
G_ProjectSource(point, dist, forward, right, result);
}
//==========================================================
void get_start_position(edict_t *ent, vec3_t start) {
vec3_t offset, forward, right;
// Get forward and right (direction) vectors
AngleVectors(ent->owner->client->v_angle, forward, right, NULL);
// Add global offset of the world
VectorSet(offset, 8, 8, ent->owner->viewheight-8);
// Get start vector
P_ProjectSource_Reverse(ent->owner->client, ent->owner->s.origin, offset, 
forward, right, start);
}
//==========================================================
void play_moving_chain_sound(edict_t *hook, qboolean chain_moving) {
// determine sound played if climbing or sliding
if (chain_moving)
switch (hook->sounds) {
case MOTOR_OFF:
// play start of chain climbing motor sound
gi.sound(hook->owner, CHAN_HOOK, HOOK_MOTOR1_SOUND, 1, ATTN_IDLE, 0);
hook->sounds = MOTOR_START;
break;
case MOTOR_START:
// play repetitive chain climbing sound
gi.sound(hook->owner, CHAN_HOOK, HOOK_MOTOR2_SOUND, 1, ATTN_IDLE, 0);
hook->sounds = MOTOR_ON;
break;
} // end switch
else
if (hook->sounds != MOTOR_OFF) {
gi.sound(hook->owner, CHAN_HOOK, HOOK_MOTOR3_SOUND, 1, ATTN_IDLE, 0);
hook->sounds = MOTOR_OFF; }
}
//==========================================================
void DropHook(edict_t *hook) {
HOOK_OWNERS_HOOKSTATE = HOOK_OFF;
gi.sound(hook->owner, CHAN_HOOK, HOOK_RETRACT_SOUND, 1, ATTN_IDLE, 0);
// removes hook
G_FreeEdict(hook);
}
//==========================================================
void Hook_Behavior(edict_t *hook) {
vec3_t start={0,0,0};
vec3_t chainvec={0,0,0}; // chain's vector
float chainlen; // length of extended chain
vec3_t velpart={0,0,0}; // player's velocity in relation to hook
float f1, f2, dprod; // restrainment forces
qboolean chain_moving=false;
int state;
state=HOOK_OWNERS_HOOKSTATE;
// Decide when to disconnect hook
// if hook is not ON OR
// if target is no longer solid OR
// (i.e. hook broke glass; exploded barrels, gibs)
// if player has died OR
// if player goes through teleport
if ((!(state & HOOK_ON))
||(hook->enemy->solid == SOLID_NOT)
||(hook->owner->deadflag)
||(hook->owner->s.event == EV_PLAYER_TELEPORT)){
DropHook(hook);
return; }
// gives hook same velocity as the entity it stuck to
VectorCopy(hook->enemy->velocity, hook->velocity);
// Grow the length of the chain
if (state & GROW_ON) {
chain_moving = true;
hook->angle += 20; }
else
// Shrink the length of the chain to Minimum
if (state & SHRINK_ON)
if (hook->angle > 10) {
chain_moving = true;
hook->angle -= 60;}
if (hook->angle < 10) {
hook->angle = 10;
chain_moving = false;}
// Make some chain sound occur..
play_moving_chain_sound(hook, chain_moving);
chain_moving=false; // chain not always moving..
//================
// chain physics
//================
// Get chain start position
get_start_position(hook, start);
VectorSubtract(hook->s.origin, start, chainvec); // get chain's vector
chainlen = VectorLength(chainvec); // get Chain Length at Vector
f1=0; // default state
// if player's location is beyond the chain's reach
if (chainlen > hook->angle) {
// determine player's velocity component of chain vector
dprod=DotProduct(hook->owner->velocity, chainvec)/DotProduct(chainvec, 
chainvec);
VectorScale(chainvec, dprod, velpart);
// restrainment default force
f2 =(chainlen-hook->angle)*5;
// if player's velocity heading is away from the hook
if (DotProduct(hook->owner->velocity, chainvec) < 0) {
// if chain has streched for 25 units
if (chainlen > hook->angle + 25)
// remove player's velocity component moving away from hook
VectorSubtract(hook->owner->velocity, velpart, hook->owner->velocity);
f1 = f2; }
else
// if player's velocity heading is towards the hook
if (VectorLength(velpart) < f2)
f1 = f2 - VectorLength(velpart);
} // end if
// applies chain restrainment
VectorNormalize(chainvec);
VectorMA(hook->owner->velocity, f1, chainvec, hook->owner->velocity);
G_Spawn_Trails(TE_BFG_LASER, start, hook->s.origin, hook->s.origin);
// set next think time
hook->nextthink = level.time + 0.1;
}
//==========================================================
void Hook_Airborne(edict_t *hook) {
vec3_t start={0,0,0};
int state;
state=HOOK_OWNERS_HOOKSTATE;
// if hook not ON then exit..
if (!(state & HOOK_ON)) {
DropHook(hook);
return; }
//
//if (hook->owner->health < 1) {
//DropHook(hook);
//return;
//}
get_start_position(hook, start);
G_Spawn_Trails(TE_BFG_LASER, start, hook->s.origin, hook->s.origin);
hook->nextthink = level.time+0.1;
}
//==========================================================
void Hook_Touch(edict_t *hook, edict_t *other, cplane_t *plane, csurface_t 
*surf){
vec3_t start={0,0,0}; // chain's start vector
vec3_t chainvec={0,0,0}; // chain's end vector
float chainlen;
int state;
state=HOOK_OWNERS_HOOKSTATE;
// if hook not ON or been fired at self then exit..
if (!(state & HOOK_ON) ||(hook == other)) {
DropHook(hook);
return; }
	if (surf && (surf->flags & SURF_SKY))
	{
                DropHook(hook);
		return;
	}
// Get chain start position
get_start_position(hook, start);
VectorSubtract(hook->s.origin,start,chainvec);
chainlen = VectorLength(chainvec);
// member angle is used to store the length of the chain
hook->angle = chainlen;
switch (other->solid) {
case SOLID_BBOX:
if (other->client) {
gi.sound(hook, CHAN_VOICE, HOOK_SMACK_SOUND, 1, ATTN_IDLE, 0);
// Show spurts of blood upon impact with player.
G_Spawn_Sparks(TE_BLOOD, hook->s.origin, plane->normal, hook->s.origin);}
break;
case SOLID_BSP:
// Show some sparks upon impact.
G_Spawn_Sparks(TE_SPARKS, hook->s.origin, plane->normal, hook->s.origin);
// Play chain hit 'clink'
gi.sound(hook, CHAN_VOICE, HOOK_HIT_SOUND, 1, ATTN_IDLE, 0);
// Clear the velocity vector
VectorClear(hook->avelocity);
break;
} // end switch
// inflict damage on damageable items
if (other->takedamage)
T_Damage(other, hook, hook->owner, hook->velocity, hook->s.origin, 
plane->normal, hook->dmg, 100, 0, MOD_HIT);
// hook gets the same velocity as the item it attached to
VectorCopy(other->velocity, hook->velocity);
// Automatic hook pulling upon contact.
HOOK_OWNERS_HOOKSTATE |= SHRINK_ON;
hook->enemy = other;
hook->touch = NULL;
hook->think = Hook_Behavior;
hook->nextthink = level.time + 0.1;
}
//==========================================================
void Fire_Grapple_Hook(edict_t *ent) {
edict_t *hook=NULL;
vec3_t offset, start, forward, right;
int *hookstate=NULL;
hookstate = &ENTS_HOOKSTATE;
*hookstate = HOOK_ON;
AngleVectors(ent->client->v_angle, forward, right, NULL);
VectorSet(offset, 8, 8, ent->viewheight-8);
P_ProjectSource_Reverse(ent->client, ent->s.origin, offset, forward, right, 
start);
// spawn hook
hook = G_Spawn();
VectorCopy(start, hook->s.origin);
VectorCopy(forward, hook->movedir);
vectoangles(forward, hook->s.angles);
VectorScale(forward, 1600, hook->velocity);
hook->movetype = MOVETYPE_FLY;
hook->clipmask = MASK_SHOT;
hook->solid = SOLID_BBOX;
VectorClear(hook->mins);
VectorClear(hook->maxs);
hook->owner = ent;
hook->dmg = 20; // 20 Units of damage at impact.
hook->sounds = MOTOR_OFF; // keeps track of motor chain sound played
hook->touch = Hook_Touch; // Called upon impact
hook->think = Hook_Airborne; // Called while hook in air
hook->nextthink = level.time + 0.1;
gi.linkentity(hook);
}
//==========================================================
void Cmd_Hook_f(edict_t *ent, char *s) {
int *hookstate=NULL;
//if (!G_ClientInGame(ent)) return;
// create intermediate value
hookstate = &ent->client->hookstate;
if ((!(*hookstate & HOOK_ON))
&& (Q_stricmp(s, "action") == 0)) {
Fire_Grapple_Hook(ent);
return; }
if (*hookstate & HOOK_ON) {
if (Q_stricmp(s, "action") == 0) {
*hookstate = HOOK_OFF; // release hook
return; }
// deactivate chain growth or shrink
if (Q_stricmp(s, "stop") == 0) {
*hookstate -= *hookstate & (GROW_ON|SHRINK_ON);
return; }
// activate chain growth
if (Q_stricmp(s, "grow") == 0) {
*hookstate |= GROW_ON;
*hookstate -= *hookstate & SHRINK_ON;
return; }
// activate chain shrinking
if (Q_stricmp(s, "shrink") == 0) {
*hookstate |= SHRINK_ON;
*hookstate -= *hookstate & GROW_ON; }
} // endif
}
