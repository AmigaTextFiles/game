#ifdef KITSCHY_DEBUG_MEMORY
#include "debug_memorymanager.h"
#endif


#ifdef _WIN32
#include "windows.h"
#endif

#include "math.h"
#include "stdlib.h"
#include "string.h"

#include "GL/gl.h"
#include "GL/glu.h"
#include "SDL.h"
#include "SDL_image.h"
#include "SDL_mixer.h"

#include "List.h"

#include "auxiliar.h"
#include "2DCMC.h"
#include "Symbol.h"
#include "GLTile.h"
#include "keyboardstate.h"
#include "VirtualController.h"
#include "sound.h"

#include "GLTManager.h"
#include "SFXManager.h"
#include "GObject.h"
#include "GO_character.h"
#include "GO_enemy.h"
#include "GO_skulldoor.h"
#include "GO_item.h"

#include "GMap.h"

#include "TheGooniesCtnt.h"

// #include "debug.h"

extern int difficulty;

GO_character::GO_character(int x,int y,int sfx_volume,int facing) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_character");

	if (facing==0) m_state=CSTATE_STANDING_LEFT;
			  else m_state=CSTATE_STANDING_RIGHT;
	m_last_state=m_state;
	m_state_cycle=0;
	m_punch_cycle=0;
	m_layer=2;

	m_walking_channel=-1;
	m_climbing_channel=-1;
	
	m_facebefore_vine=0;

	m_requested_room=false;
	m_requested_room_x=0;
	m_requested_room_y=0;
	m_requested_room_door=0;

	m_player_hit_counter=0;

	m_walking_speed=PLAYER_SPEED;

	m_energy=64;
	m_experience=0;
	m_key=false;
	m_goonies_rescued=0;
	m_score=0;

	m_last_pick=0;
	m_last_hit=0;
	m_last_hit_by=0;
	m_camefrom=0;

	// item variables:
	m_yellowhelmet_status=m_yellowhelmet_timmer=0;
	m_greycoat_status=m_greycoat_timmer=0;
	m_yellowcoat_timmer=0;
	m_hammer_status=0;
	m_greenbook_status=0;
	m_redbook_status=0;
	m_lightbluebook_status=0;
	m_bluebook_status=m_bluebook_timmer=0;
	m_greencoat_timmer=0;
	m_whitebook_status=0;
	m_yellowshield_status=m_yellowshield_timmer=0;
	m_lightbluecoat_timmer=0;
	m_whiteshield_status=m_whiteshield_timmer=0;
	m_lightbluehelmet_status=m_lightbluehelmet_timmer=0;
	m_yellowbook_status=m_yellowbook_timmer=0;
	m_purpleshield_status=m_purpleshield_timmer=0;
	m_clock_timmer=0;
	m_bluebadbook_nghosts=0;

//	m_items.Add(new Symbol("GO_clock"));
//	m_clock_timmer=1500;
} /* GO_character::GO_character */ 


GO_character::~GO_character()
{
	stop_continuous_sfx();

	if (m_last_pick!=0) delete m_last_pick;
	if (m_last_hit!=0) delete m_last_hit;
	if (m_last_hit_by!=0) delete m_last_hit_by;
	if (m_camefrom!=0) delete m_camefrom;
} /* GO_character::~GO_character */ 


void GO_character::stop_continuous_sfx(void)
{
	if (m_walking_channel!=-1) {
		Mix_HaltChannel(m_walking_channel);
		m_walking_channel=-1;
	} // if 
	if (m_climbing_channel!=-1) {
		Mix_HaltChannel(m_climbing_channel);
		m_climbing_channel=-1;
	} // if 
} /* GO_character::stop_continuous_sfx */ 


void GO_character::pause_continuous_sfx(void)
{
	if (m_walking_channel!=-1) {
		Mix_Pause(m_walking_channel);
	} // if 
	if (m_climbing_channel!=-1) {
		Mix_Pause(m_climbing_channel);
	} // if 
} /* GO_character::pause_continuous_sfx */ 


void GO_character::resume_continuous_sfx(void)
{
	if (m_walking_channel!=-1) {
		Mix_Resume(m_walking_channel);
	} // if 
	if (m_climbing_channel!=-1) {
		Mix_Resume(m_climbing_channel);
	} // if 
} /* GO_character::resume_continuous_sfx */ 


bool GO_character::cycle(VirtualController *v,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	if (m_last_tile_used==0) m_last_tile_used=GLTM->get("ob_character-l1");

	// reset the variables for script conditions:
	m_last_state=m_state;
	if (m_last_pick!=0) delete m_last_pick;
	m_last_pick=0;
	if (m_last_hit!=0) delete m_last_hit;
	m_last_hit=0;
	if (m_last_hit_by!=0) delete m_last_hit_by;
	m_last_hit_by=0;

//	output_debug_message("character: %g %g %i\n",m_x,m_y,m_state);

#ifdef __DEBUG_MESSAGES
	output_debug_message("Character, %i (%f,%f)\n",m_state,m_x,m_y);
#endif

	if (player_has("GO_shoes")) {
		m_walking_speed=PLAYER_SPEED*1.25;
	} else {
		m_walking_speed=PLAYER_SPEED;
	} // if 

	switch(m_state) {
	case CSTATE_STANDING_LEFT:	
	case CSTATE_STANDING_RIGHT:
								if (v->m_joystick[VC_UP] && !v->m_old_joystick[VC_UP]) {
									GObject *o;
									o=map->collision_with_object(this,GLTM,"GO_rope");
									if (o!=0) {
										// climb a rope!
										if (m_state==CSTATE_STANDING_LEFT) m_facebefore_vine=0;
																	  else m_facebefore_vine=1;
										m_state=CSTATE_CLIMBING_UP;
										m_x=o->get_x()+10;
									} else {
										// check for skulldoors:
										GO_skulldoor *sd=(GO_skulldoor *)map->collision_with_object(this,GLTM,"GO_skulldoor");

										if (sd!=0) {
											// Room change request:
											if (sd->get_destination_x()!=-1 ||
												m_goonies_rescued>=7) {
												m_requested_room_x=sd->get_destination_x();
												m_requested_room_y=sd->get_destination_y();
												m_requested_room_door=sd->get_destination_door();
												m_state=CSTATE_ENTERING_DOOR;
												m_state_cycle=0;
												m_x=sd->get_x()+26;
												m_y=sd->get_y()+72;
											} // if 
										} else {
											Sound_play(SFXM->get("sfx/player_jump"),m_sfx_volume);
											if (m_state==CSTATE_STANDING_LEFT) {
												m_state=CSTATE_JUMPING_LEFT;
												m_state_cycle=0;
											} else {
												m_state=CSTATE_JUMPING_RIGHT;
												m_state_cycle=0;
											} // if 									
										} // if 
									} // if 

								} else {
									if (v->m_joystick[VC_LEFT]) {
										m_state_cycle=0;
										m_state=CSTATE_WALKING_LEFT;
									} /* if */ 
									if (v->m_joystick[VC_RIGHT]) {
										m_state_cycle=0;
										m_state=CSTATE_WALKING_RIGHT;
									} /* if */ 

									// down an rope:
									if (v->m_joystick[VC_DOWN] && !v->m_old_joystick[VC_DOWN]) {
										m_y+=50;
										GObject *o;
										o=map->collision_with_object(this,GLTM,"GO_rope");
										if (o!=0) {
											set_layer(3,map);
											if (m_state==CSTATE_STANDING_LEFT) m_facebefore_vine=0;
																		  else m_facebefore_vine=1;
											m_state=CSTATE_CLIMBING_DOWN;
											m_x=o->get_x()+10;	
											m_y-=28;
										} else {
											m_y-=50;
										} // if 
									} // if 

									// punch:
									if (v->m_button[0] && !v->m_old_button[0]) {
										int e_gained=0;
										int points_gained;
										if (m_state==CSTATE_STANDING_LEFT || m_state==CSTATE_WALKING_LEFT) {								
											m_state=CSTATE_PUNCH_LEFT;
											m_punch_cycle=0;
											GO_enemy *e=(GO_enemy *)map->collision_with_object(GLTM->get("ob_character-punch-mask-l"),(int)m_x,(int)m_y,GLTM,"GO_enemy");
											if (e!=0 && e->player_hit(&e_gained,&points_gained)) {	
												if (m_last_hit!=0) delete m_last_hit;
												m_last_hit=new Symbol(e->get_class());
												Sound_play(SFXM->get("sfx/player_hit_enemy"),m_sfx_volume);
												m_experience+=e_gained;
												m_score+=points_gained;
											} else {
												Sound_play(SFXM->get("sfx/player_attack"),m_sfx_volume);
											} // if 
										} else {
											m_state=CSTATE_PUNCH_RIGHT;
											m_punch_cycle=0;
											GO_enemy *e=(GO_enemy *)map->collision_with_object(GLTM->get("ob_character-punch-mask-r"),(int)m_x,(int)m_y,GLTM,"GO_enemy");
											if (e!=0 && e->player_hit(&e_gained,&points_gained)) {
												if (m_last_hit!=0) delete m_last_hit;
												m_last_hit=new Symbol(e->get_class());
												Sound_play(SFXM->get("sfx/player_hit_enemy"),m_sfx_volume);
												m_experience+=e_gained;
												m_score+=points_gained;
											} else {
												Sound_play(SFXM->get("sfx/player_attack"),m_sfx_volume);
											} // if 
										} // if 
									} // if 
								} // if 

								// test for fall:
								if (m_state!=CSTATE_ENTERING_DOOR) {
									m_y++;
									if (!map->collision_with_background(this,GLTM)) {
										if (m_state==CSTATE_STANDING_LEFT) m_state=CSTATE_FALLING_LEFT;
																	  else m_state=CSTATE_FALLING_RIGHT;
										m_state_cycle=0;
									} // if 
									m_y--;
								} // if 


								break;
	case CSTATE_WALKING_LEFT:	m_state_cycle++;
								m_x-=m_walking_speed;
								if (v->m_joystick[VC_UP] && !v->m_old_joystick[VC_UP]) {
									GObject *o;
									o=map->collision_with_object(this,GLTM,"GO_rope");
									if (o!=0) {
										// climb a rope!
										m_facebefore_vine=0;
										m_state=CSTATE_CLIMBING_UP;
										m_x=o->get_x()+10;
									} else {
										// check for skulldoors:
										GO_skulldoor *sd=(GO_skulldoor *)map->collision_with_object(this,GLTM,"GO_skulldoor");

										if (sd!=0) {
											// Room change request:
											if (sd->get_destination_x()!=-1 ||
												m_goonies_rescued>=7) {
												m_requested_room_x=sd->get_destination_x();
												m_requested_room_y=sd->get_destination_y();
												m_requested_room_door=sd->get_destination_door();
												m_state=CSTATE_ENTERING_DOOR;
												m_state_cycle=0;
												m_x=sd->get_x()+26;
												m_y=sd->get_y()+72;
											} // if 
										} else {
											Sound_play(SFXM->get("sfx/player_jump"),m_sfx_volume);
											m_state=CSTATE_JUMPING_LEFT_LEFT;
											m_state_cycle=0;
										} // if 
									} // if 
								} else {
									if (!v->m_joystick[VC_LEFT]) {
										m_state_cycle=0;
										m_state=CSTATE_STANDING_LEFT;
									} /* if */ 
									if (v->m_joystick[VC_RIGHT] && !v->m_old_joystick[VC_RIGHT]) {
										m_state_cycle=0;
										m_state=CSTATE_WALKING_RIGHT;
									} /* if */ 

									// down an rope:
									if (v->m_joystick[VC_DOWN] && !v->m_old_joystick[VC_DOWN]) {
										m_y+=50;
										GObject *o;
										o=map->collision_with_object(this,GLTM,"GO_rope");
										if (o!=0) {
											set_layer(3,map);
											m_facebefore_vine=0;
											m_state=CSTATE_CLIMBING_DOWN;
											m_x=o->get_x()+10;	
											m_y-=28;
										} else {
											m_y-=50;
										} // if 
									} // if 

									// punch:
									if (v->m_button[0] && !v->m_old_button[0]) {
										int e_gained=0;
										int points_gained=0;
										if (m_state==CSTATE_STANDING_LEFT || m_state==CSTATE_WALKING_LEFT) {
											m_state=CSTATE_PUNCH_LEFT;
											m_punch_cycle=0;
											GO_enemy *e=(GO_enemy *)map->collision_with_object(GLTM->get("ob_character-punch-mask-l"),(int)m_x,(int)m_y,GLTM,"GO_enemy");
											if (e!=0 && e->player_hit(&e_gained,&points_gained)) {
												if (m_last_hit!=0) delete m_last_hit;
												m_last_hit=new Symbol(e->get_class());
												Sound_play(SFXM->get("sfx/player_hit_enemy"),m_sfx_volume);
												m_experience+=e_gained;
												m_score+=points_gained;
											} else {
												Sound_play(SFXM->get("sfx/player_attack"),m_sfx_volume);
											} // if 
										} else {
											m_state=CSTATE_PUNCH_RIGHT;
											m_punch_cycle=0;
											GO_enemy *e=(GO_enemy *)map->collision_with_object(GLTM->get("ob_character-punch-mask-r"),(int)m_x,(int)m_y,GLTM,"GO_enemy");
											if (e!=0 && e->player_hit(&e_gained,&points_gained)) {
												if (m_last_hit!=0) delete m_last_hit;
												m_last_hit=new Symbol(e->get_class());
												Sound_play(SFXM->get("sfx/player_hit_enemy"),m_sfx_volume);
												m_experience+=e_gained;
												m_score+=points_gained;
											} else {
												Sound_play(SFXM->get("sfx/player_attack"),m_sfx_volume);
											} // if 
										} // if 
									} // if 
								} // if 

								// test for fall:
								if (m_state!=CSTATE_ENTERING_DOOR) {
									m_y++;
									if (!map->collision_with_background(this,GLTM)) {
										m_state=CSTATE_FALLING_LEFT;
										m_state_cycle=0;
									} // if 
									m_y--;
								} // if 

//								if (v->m_joystick[VC_UP]) m_y--;
//								if (v->m_joystick[VC_DOWN]) m_y++;

								break;
	case CSTATE_WALKING_RIGHT:	m_state_cycle++;
								m_x+=m_walking_speed;
								if (v->m_joystick[VC_UP] && !v->m_old_joystick[VC_UP]) {
									GObject *o;
									o=map->collision_with_object(this,GLTM,"GO_rope");
									if (o!=0) {
										// climb a rope!
										m_facebefore_vine=1;
										m_state=CSTATE_CLIMBING_UP;
										m_x=o->get_x()+10;
									} else {
										// check for skulldoors:
										GO_skulldoor *sd=(GO_skulldoor *)map->collision_with_object(this,GLTM,"GO_skulldoor");

										if (sd!=0) {
											// Room change request:
											if (sd->get_destination_x()!=-1 ||
												m_goonies_rescued>=7) {
												m_requested_room_x=sd->get_destination_x();
												m_requested_room_y=sd->get_destination_y();
												m_requested_room_door=sd->get_destination_door();
												m_state=CSTATE_ENTERING_DOOR;
												m_state_cycle=0;
												m_x=sd->get_x()+26;
												m_y=sd->get_y()+72;
											} // if 
										} else {
											Sound_play(SFXM->get("sfx/player_jump"),m_sfx_volume);
											m_state=CSTATE_JUMPING_RIGHT_RIGHT;
											m_state_cycle=0;
										} // if
									} // if
								} else {
									if (v->m_joystick[VC_LEFT] && !v->m_old_joystick[VC_LEFT]) {
										m_state_cycle=0;
										m_state=CSTATE_WALKING_LEFT;
									} /* if */ 
									if (!v->m_joystick[VC_RIGHT]) {
										m_state_cycle=0;
										m_state=CSTATE_STANDING_RIGHT;
									} /* if */ 

									// down an rope:
									if (v->m_joystick[VC_DOWN] && !v->m_old_joystick[VC_DOWN]) {
										m_y+=50;
										GObject *o;
										o=map->collision_with_object(this,GLTM,"GO_rope");
										if (o!=0) {
											set_layer(3,map);
											m_facebefore_vine=1;
											m_state=CSTATE_CLIMBING_DOWN;
											m_x=o->get_x()+10;	
											m_y-=28;
										} else {
											m_y-=50;
										} // if 
									} // if 

									// punch:
									if (v->m_button[0] && !v->m_old_button[0]) {
										int e_gained=0;
										int points_gained=0;
										if (m_state==CSTATE_STANDING_LEFT || m_state==CSTATE_WALKING_LEFT) {
											m_state=CSTATE_PUNCH_LEFT;
											m_punch_cycle=0;
											GO_enemy *e=(GO_enemy *)map->collision_with_object(GLTM->get("ob_character-punch-mask-l"),(int)m_x,(int)m_y,GLTM,"GO_enemy");
											if (e!=0 && e->player_hit(&e_gained,&points_gained)) {
												if (m_last_hit!=0) delete m_last_hit;
												m_last_hit=new Symbol(e->get_class());
												Sound_play(SFXM->get("sfx/player_hit_enemy"),m_sfx_volume);
												m_experience+=e_gained;
												m_score+=points_gained;
											} else {
												Sound_play(SFXM->get("sfx/player_attack"),m_sfx_volume);
											} // if 
										} else {
											m_state=CSTATE_PUNCH_RIGHT;
											m_punch_cycle=0;
											GO_enemy *e=(GO_enemy *)map->collision_with_object(GLTM->get("ob_character-punch-mask-r"),(int)m_x,(int)m_y,GLTM,"GO_enemy");
											if (e!=0 && e->player_hit(&e_gained,&points_gained)) {
												if (m_last_hit!=0) delete m_last_hit;
												m_last_hit=new Symbol(e->get_class());
												Sound_play(SFXM->get("sfx/player_hit_enemy"),m_sfx_volume);
												m_experience+=e_gained;
												m_score+=points_gained;
											} else {
												Sound_play(SFXM->get("sfx/player_attack"),m_sfx_volume);
											} // if 
										} // if 
									} // if 
								} // if 

								// test for fall:
								if (m_state!=CSTATE_ENTERING_DOOR) {
									m_y++;
									if (!map->collision_with_background(this,GLTM)) {
										m_state=CSTATE_FALLING_RIGHT;
										m_state_cycle=0;
									} // if 
									m_y--;
								} // if

								break;
	case CSTATE_FALLING_LEFT:	{
									int i,j=1;
									if (m_state_cycle>4) j++;
									if (m_state_cycle>16) j++;

									for(i=0;i<j;i++) {
										m_y++;
										if (map->collision_with_background(this,GLTM)) {
											m_state=CSTATE_STANDING_LEFT;
											m_state_cycle=0;
											m_y--;
											Sound_play(SFXM->get("sfx/player_land"),m_sfx_volume);
										} // if 
									} // for 

									m_state_cycle++;									
								}
								break;
	case CSTATE_FALLING_RIGHT:	{
									int i,j=1;
									if (m_state_cycle>4) j++;
									if (m_state_cycle>16) j++;

									for(i=0;i<j;i++) {
										m_y++;
										if (map->collision_with_background(this,GLTM)) {
											m_state=CSTATE_STANDING_RIGHT;
											m_state_cycle=0;
											m_y--;
											Sound_play(SFXM->get("sfx/player_land"),m_sfx_volume);
										} // if 
									} // for 
									
									m_state_cycle++;
								}
								break;
	case CSTATE_PUNCH_LEFT:		m_punch_cycle++;
								if (m_punch_cycle>=8) {
									m_state=CSTATE_STANDING_LEFT;
									m_state_cycle=0;
								} // if 
								break;
	case CSTATE_PUNCH_RIGHT:	m_punch_cycle++;
								if (m_punch_cycle>=8) {
									m_state=CSTATE_STANDING_RIGHT;
									m_state_cycle=0;
								} // if 								
								break;

	case CSTATE_JUMPING_LEFT:
	case CSTATE_JUMPING_RIGHT:
	case CSTATE_JUMPING_LEFT_LEFT:
	case CSTATE_JUMPING_RIGHT_RIGHT:
								{
									int i,y_move=3;
									if (m_state_cycle<39) y_move=2;
									if (m_state_cycle<33) y_move=1;
									if (m_state_cycle<27) y_move=0;
									if (m_state_cycle<21) y_move=-1;
									if (m_state_cycle<15) y_move=-2;
									if (m_state_cycle<9) y_move=-3;
									if (m_state_cycle<4) y_move=-4;
									
									if (y_move>0) {
										for(i=0;i<y_move;i++) {
											m_y++;
											if (map->collision_with_background(this,0,1,GLTM)) {
												Sound_play(SFXM->get("sfx/player_land"),m_sfx_volume);
												if (m_state==CSTATE_JUMPING_LEFT ||
													m_state==CSTATE_JUMPING_LEFT_LEFT) {
													m_state=CSTATE_STANDING_LEFT;
													y_move=0;
												} // if 
												if (m_state==CSTATE_JUMPING_RIGHT ||
													m_state==CSTATE_JUMPING_RIGHT_RIGHT) {
													m_state=CSTATE_STANDING_RIGHT;
													y_move=0;
												} // if 
												m_state_cycle=0;
											} // if 
										} // for 
									} // if 
									if (y_move<0) {
										y_move=-y_move;
										for(i=0;i<y_move;i++) {
											m_y--;
											if (map->collision_with_background(this,GLTM)) {
												m_y++;
												m_state_cycle=22;
											} // if 
										} // for 
									} // if 

									if (m_state==CSTATE_JUMPING_LEFT_LEFT) {
										m_x-=(m_walking_speed*1.25f);
										if (map->collision_with_background(this,GLTM)) {
											m_x+=(m_walking_speed*1.25f);
											if (m_state_cycle>25) m_state=CSTATE_JUMPING_LEFT;
										} // if
									} // if 

									if (m_state==CSTATE_JUMPING_RIGHT_RIGHT) {
										m_x+=(m_walking_speed*1.25f);
										if (map->collision_with_background(this,GLTM)) {
											m_x-=(m_walking_speed*1.25f);
											if (m_state_cycle>25) m_state=CSTATE_JUMPING_RIGHT;
										} // if
									} // if 

									{
										// punch:
										if (v->m_button[0] && !v->m_old_button[0]) {
											int e_gained=0;
											int points_gained;
											if (m_state==CSTATE_JUMPING_LEFT || m_state==CSTATE_JUMPING_LEFT_LEFT) {
												GO_enemy *e=(GO_enemy *)map->collision_with_object(GLTM->get("ob_character-punchjump-mask-l"),(int)m_x,(int)m_y,GLTM,"GO_enemy");
												if (e!=0 && e->player_hit(&e_gained, &points_gained)) {
													if (m_last_hit!=0) delete m_last_hit;
													m_last_hit=new Symbol(e->get_class());
													Sound_play(SFXM->get("sfx/player_hit_enemy"),m_sfx_volume);
													m_experience+=e_gained;
													m_score+=points_gained;
												} else {
													Sound_play(SFXM->get("sfx/player_attack"),m_sfx_volume);
												} // if 
											} else {
												GO_enemy *e=(GO_enemy *)map->collision_with_object(GLTM->get("ob_character-punchjump-mask-r"),(int)m_x,(int)m_y,GLTM,"GO_enemy");
												if (e!=0 && e->player_hit(&e_gained,&points_gained)) {
													if (m_last_hit!=0) delete m_last_hit;
													m_last_hit=new Symbol(e->get_class());
													Sound_play(SFXM->get("sfx/player_hit_enemy"),m_sfx_volume);
													m_experience+=e_gained;
													m_score+=points_gained;
												} else {
													Sound_play(SFXM->get("sfx/player_attack"),m_sfx_volume);
												} // if 
											} // if 

											m_punch_cycle=0;
											if (m_state==CSTATE_JUMPING_LEFT) m_state=CSTATE_JUMPPUNCH_LEFT;
											if (m_state==CSTATE_JUMPING_RIGHT) m_state=CSTATE_JUMPPUNCH_RIGHT;
											if (m_state==CSTATE_JUMPING_LEFT_LEFT) m_state=CSTATE_JUMPPUNCH_LEFT_LEFT;
											if (m_state==CSTATE_JUMPING_RIGHT_RIGHT) m_state=CSTATE_JUMPPUNCH_RIGHT_RIGHT;										
										} // if 
									} // if 
									m_state_cycle++;
								}
								break;
	case CSTATE_JUMPPUNCH_LEFT:
	case CSTATE_JUMPPUNCH_RIGHT:
	case CSTATE_JUMPPUNCH_LEFT_LEFT:
	case CSTATE_JUMPPUNCH_RIGHT_RIGHT:
								{
									int i,y_move=3;
									if (m_state_cycle<39) y_move=2;
									if (m_state_cycle<33) y_move=1;
									if (m_state_cycle<27) y_move=0;
									if (m_state_cycle<21) y_move=-1;
									if (m_state_cycle<15) y_move=-2;
									if (m_state_cycle<9) y_move=-3;
									if (m_state_cycle<4) y_move=-4;

									if (m_state==CSTATE_JUMPPUNCH_LEFT_LEFT) {
										m_x-=(m_walking_speed*1.25f);
										if (map->collision_with_background(this,GLTM)) {
											m_x+=(m_walking_speed*1.25f);
											if (m_state_cycle>25) m_state=CSTATE_JUMPPUNCH_LEFT;
										} // if
									} // if 

									if (m_state==CSTATE_JUMPPUNCH_RIGHT_RIGHT) {
										m_x+=(m_walking_speed*1.25f);
										if (map->collision_with_background(this,GLTM)) {
											m_x-=(m_walking_speed*1.25f);
											if (m_state_cycle>25) m_state=CSTATE_JUMPPUNCH_RIGHT;
										} // if
									} // if 
									
									if (y_move>0) {
										for(i=0;i<y_move;i++) {
											m_y++;
											if (map->collision_with_background(this,0,1,GLTM)) {
												Sound_play(SFXM->get("sfx/player_land"),m_sfx_volume);
												if (m_state==CSTATE_JUMPPUNCH_LEFT ||
													m_state==CSTATE_JUMPPUNCH_LEFT_LEFT) {
													m_state=CSTATE_STANDING_LEFT;
													y_move=0;
												} // if 
												if (m_state==CSTATE_JUMPPUNCH_RIGHT ||
													m_state==CSTATE_JUMPPUNCH_RIGHT_RIGHT) {
													m_state=CSTATE_STANDING_RIGHT;
													y_move=0;
												} // if 
												m_state_cycle=0;
											} // if 
										} // for 
									} // if 
									if (y_move<0) {
										y_move=-y_move;
										for(i=0;i<y_move;i++) {
											m_y--;
											if (map->collision_with_background(this,GLTM)) {
												m_y++;
												m_state_cycle=22;
											} // if 
										} // for 
									} // if 
									m_state_cycle++;
									m_punch_cycle++;
									if (m_punch_cycle>=8) {
										if (m_state==CSTATE_JUMPPUNCH_LEFT)	m_state=CSTATE_JUMPING_LEFT;
										if (m_state==CSTATE_JUMPPUNCH_RIGHT) m_state=CSTATE_JUMPING_RIGHT;
										if (m_state==CSTATE_JUMPPUNCH_LEFT_LEFT) m_state=CSTATE_JUMPING_LEFT_LEFT;
										if (m_state==CSTATE_JUMPPUNCH_RIGHT_RIGHT) m_state=CSTATE_JUMPING_RIGHT_RIGHT;
									} // if
								}
								break;

	case CSTATE_CLIMBING_UP:	set_layer(3,map);
								m_y--;
								
								// test if end of rope:
								if (m_y>8) {
									m_y-=8;
									if (!map->collision_with_object(this,GLTM,"GO_rope")) {
										set_layer(2,map);
										if (m_facebefore_vine==0) m_state=CSTATE_STANDING_LEFT;
															 else m_state=CSTATE_STANDING_RIGHT;
										m_state_cycle=0;
										do{
											m_y--;
										}while(m_y>=0 && map->collision_with_background(this,GLTM));
									} else {
										m_y+=8;
									} // if 

									// check for reaching a platform:
									if (m_state==CSTATE_CLIMBING_UP &&
										!map->collision_with_background(this,GLTM) &&
										map->collision_with_background(this,0,1,GLTM)) {
										set_layer(2,map);
										if (m_facebefore_vine==0) m_state=CSTATE_STANDING_LEFT;
															 else m_state=CSTATE_STANDING_RIGHT;
										m_state_cycle=0;
									} // if
								} // if 

								m_state_cycle++;
								if (!v->m_joystick[VC_UP]) {
									m_state=CSTATE_CLIMBING;
								} /* if */ 
								if (v->m_joystick[VC_DOWN] && !v->m_old_joystick[VC_DOWN]) {
									m_state=CSTATE_CLIMBING_DOWN;
								} /* if */ 
								break;
	case CSTATE_CLIMBING:		set_layer(3,map);	
								if (v->m_joystick[VC_UP]) {
									m_state=CSTATE_CLIMBING_UP;
								} /* if */ 
								if (v->m_joystick[VC_DOWN]) {
									m_state=CSTATE_CLIMBING_DOWN;
								} /* if */ 
								break;
	case CSTATE_CLIMBING_DOWN:	set_layer(3,map);
								m_y++;								
								if (map->collision_with_background(this,GLTM)) {
									m_y--;
									if (!map->collision_with_background(this,GLTM)) {
										set_layer(2,map);
										if (m_facebefore_vine==0) m_state=CSTATE_STANDING_LEFT;
															 else m_state=CSTATE_STANDING_RIGHT;
										m_state_cycle=0;
									} else {
										m_y++;
									} // if 
								} // if 

								m_state_cycle++;
								if (!v->m_joystick[VC_DOWN]) {
									m_state=CSTATE_CLIMBING;
								} /* if */ 
								if (v->m_joystick[VC_UP] && !v->m_old_joystick[VC_UP]) {
									m_state=CSTATE_CLIMBING_UP;
								} /* if */ 
								break;

	case CSTATE_ENTERING_DOOR:  if (m_state_cycle==0) Sound_play(SFXM->get("sfx/skulldoor"),m_sfx_volume);
								m_state_cycle++;
								if (m_state_cycle>50) {
									m_requested_room=true;
									m_state=CSTATE_STANDING_RIGHT;
								} // if 
								break;
	case CSTATE_DYING:	m_state_cycle++;
						if (m_state_cycle>100) m_state=CSTATE_DEAD;
						break;
	case CSTATE_DEAD:	
						break;
	} // switch

	// continuous SFX:
	switch(m_state) {
	case CSTATE_STANDING_LEFT:
	case CSTATE_STANDING_RIGHT:
	case CSTATE_JUMPING_LEFT:
	case CSTATE_JUMPING_RIGHT:
	case CSTATE_JUMPING_LEFT_LEFT:
	case CSTATE_JUMPING_RIGHT_RIGHT:
	case CSTATE_FALLING_LEFT:
	case CSTATE_FALLING_RIGHT:
	case CSTATE_PUNCH_LEFT:
	case CSTATE_PUNCH_RIGHT:
	case CSTATE_JUMPPUNCH_LEFT:
	case CSTATE_JUMPPUNCH_RIGHT:
	case CSTATE_JUMPPUNCH_LEFT_LEFT:
	case CSTATE_JUMPPUNCH_RIGHT_RIGHT:
	case CSTATE_CLIMBING:
								if (m_walking_channel!=-1) {
									Mix_HaltChannel(m_walking_channel);
									m_walking_channel=-1;
								} // if 
								if (m_climbing_channel!=-1) {
									Mix_HaltChannel(m_climbing_channel);
									m_climbing_channel=-1;
								} // if 
								break;
	case CSTATE_WALKING_LEFT:	
	case CSTATE_WALKING_RIGHT:
								if (m_climbing_channel!=-1) {
									Mix_HaltChannel(m_climbing_channel);
									m_climbing_channel=-1;
								} // if 
								if (m_walking_channel==-1) {
									m_walking_channel=Sound_play_continuous(SFXM->get("sfx/player_walk"),m_sfx_volume);
								} // if 
								break;
	case CSTATE_CLIMBING_UP:
	case CSTATE_CLIMBING_DOWN:
								if (m_walking_channel!=-1) {
									Mix_HaltChannel(m_walking_channel);
									m_walking_channel=-1;
								} // if 
								if (m_climbing_channel==-1) {
									m_climbing_channel=Sound_play_continuous(SFXM->get("sfx/player_climb"),m_sfx_volume);
								} // if 
								break;
	} // switch 


	if (m_layer!=3 &&
		map->collision_with_background(this,GLTM)) {
		int i,j;
		bool found=false;

		for(i=1;i<5 && !found;i++) {
			for(j=0;j<i && !found;j++) {
				// x = j
				// y = i-j
				if (!found && !map->collision_with_background(this,j,i-j,GLTM)) {
					m_x+=j;
					m_y+=i-j;
					found=true;
				} // if 
				if (!found && (i-j)!=0) {
					if (!map->collision_with_background(this,j,-(i-j),GLTM)) {
						m_x+=j;
						m_y+=-(i-j);
						found=true;
					} // if 
				} // if 
				if (!found && j!=0) {
					if (!map->collision_with_background(this,-j,i-j,GLTM)) {
						m_x+=-j;
						m_y+=i-j;
						found=true;
					} // if 
				} // if 
				if (!found && j!=0 && (i-j)!=0) {
					if (!map->collision_with_background(this,-j,-(i-j),GLTM)) {
						m_x+=-j;
						m_y+=-(i-j);
						found=true;
					} // if 
				} // if 
			} // for 
		} // for 

		if (!found && m_player_hit_counter==0) {
			m_energy=0;
			m_player_hit_counter=64;
			Sound_play(SFXM->get("sfx/player_dead"),m_sfx_volume);
		} // if 
	} // if 

	// check for keys:
	if (!m_key) {
		GObject *o=map->collision_with_object(this,GLTM,"GO_key");
		if (o!=0) {
			if (o->get_state()==0) {
				Sound_play(SFXM->get("sfx/player_pickup_key"),m_sfx_volume);
				o->set_state(1);
				m_key=true;
				m_score+=200;

				if (m_last_pick!=0) delete m_last_pick;
				m_last_pick=new Symbol("GO_key");
			} // if 
		} // if 
	} // if

	// check for other items:
	{
		GO_item *o=(GO_item *)map->collision_with_object(this,GLTM,"GO_item");
		if (o!=0) {
			if (o->get_state()==0) {				
				o->set_state(1);
				if (m_last_pick!=0) delete m_last_pick;
				m_last_pick=new Symbol("GO_item");

				// Pick up the object: update the internal status:
				switch(o->get_type()) {
				case 0:	Sound_play(SFXM->get("sfx/rescue_goonie"),m_sfx_volume);
						m_goonies_rescued++;
						m_score+=2000;
						break;
				case 1: Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_energy+=6;
						if (m_energy>PLAYER_MAX_ENERGY) m_energy=PLAYER_MAX_ENERGY;
						break;
				case 2: m_items.Add(new Symbol("GO_yellowhelmet"));
						m_yellowhelmet_status=5;
						m_yellowhelmet_timmer=0;
						m_last_pick=new Symbol("GO_yellowhelmet");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 3: m_items.Add(new Symbol("GO_shoes"));
						if (m_last_pick!=0) delete m_last_pick;
						m_last_pick=new Symbol("GO_shoes");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 4: m_items.Add(new Symbol("GO_greycoat"));
						m_greycoat_status=5;
						m_greycoat_timmer=0;
						m_last_pick=new Symbol("GO_greycoat");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 5: m_items.Add(new Symbol("GO_yellowcoat"));
						if (m_last_pick!=0) delete m_last_pick;
						m_last_pick=new Symbol("GO_yellowcoat");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						m_yellowcoat_timmer=500;
						break;
				case 6: m_items.Add(new Symbol("GO_hammer"));
						if (m_last_pick!=0) delete m_last_pick;
						m_last_pick=new Symbol("GO_hammer");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 7: // energy increasing bag
						m_energy+=8;
						if (m_energy>=PLAYER_MAX_ENERGY) m_energy=PLAYER_MAX_ENERGY;
						break;
				case 8: m_items.Add(new Symbol("GO_lamp"));
						if (m_last_pick!=0) delete m_last_pick;
						m_last_pick=new Symbol("GO_lamp");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 9: m_items.Add(new Symbol("GO_greenbook"));
						m_greenbook_status=5;
						m_last_pick=new Symbol("GO_greenbook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;	
				case 10:m_items.Add(new Symbol("GO_redbook"));
						m_redbook_status=4;
						m_last_pick=new Symbol("GO_redbook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 11:m_items.Add(new Symbol("GO_lightbluebook"));
						m_lightbluebook_status=5;
						m_last_pick=new Symbol("GO_lightbluebook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 12:m_items.Add(new Symbol("GO_bluebook"));
						m_bluebook_status=5;
						m_last_pick=new Symbol("GO_bluebook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 13:m_items.Add(new Symbol("GO_greencoat"));
						m_greencoat_timmer=500;
						m_last_pick=new Symbol("GO_greencoat");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 14:m_items.Add(new Symbol("GO_whitebook"));
						m_whitebook_status=5;
						m_last_pick=new Symbol("GO_whitebook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 15:m_items.Add(new Symbol("GO_yellowshield"));
						m_yellowshield_status=5;
						m_last_pick=new Symbol("GO_yellowshield");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 16:m_experience++;
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						break;
				case 17:m_items.Add(new Symbol("GO_lightbluecoat"));
						m_lightbluecoat_timmer=500;
						m_last_pick=new Symbol("GO_lightbluecoat");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 18:m_items.Add(new Symbol("GO_whiteshield"));
						m_yellowshield_status=5;
						m_last_pick=new Symbol("GO_whiteshield");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 19:m_items.Add(new Symbol("GO_redbadbook"));
						m_last_pick=new Symbol("GO_redbadbook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 20:m_items.Add(new Symbol("GO_purplebook"));
						m_last_pick=new Symbol("GO_purplebook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 21:m_items.Add(new Symbol("GO_lightbluehelmet"));
						m_lightbluehelmet_status=5;
						m_last_pick=new Symbol("GO_lightbluehelmet");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 22:m_items.Add(new Symbol("GO_yellowbook"));
						m_yellowbook_status=5;
						m_last_pick=new Symbol("GO_yellowbook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 23:m_items.Add(new Symbol("GO_purplebadbook"));
						m_last_pick=new Symbol("GO_purplebadbook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 24:m_items.Add(new Symbol("GO_purpleshield"));
						m_purpleshield_status=5;
						m_last_pick=new Symbol("GO_purpleshield");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 25:m_items.Add(new Symbol("GO_clock"));
						m_clock_timmer=1500;
						m_last_pick=new Symbol("GO_clock");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;
				case 26:m_items.Add(new Symbol("GO_bluebadbook"));
						m_bluebadbook_nghosts=2;
						m_last_pick=new Symbol("GO_bluebadbook");
						Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						m_score+=1000;
						break;						
				default:Sound_play(SFXM->get("sfx/player_pickup_item"),m_sfx_volume);
						break;
				} // switch 
			} // if 
		} // if 
	} // if

	// check for enemies:
	if (m_player_hit_counter>0) {
		m_player_hit_counter--;
	} else {
		if (m_state!=CSTATE_ENTERING_DOOR && !m_requested_room) {
			bool saved=false;
			int energy_taken=0;
			GO_enemy *e=(GO_enemy *)map->collision_with_object(this,GLTM,"GO_enemy");
			if (e!=0) energy_taken=(int)(e->enemy_hit()*difficulty/100);
			if (energy_taken!=0) {
				if (e->get_class()->cmp("GO_bat")) Sound_play(SFXM->get("sfx/bat_attack"),m_sfx_volume);
				if (e->get_class()->cmp("GO_fallingrock")) {
					if (player_has("GO_yellowhelmet") && (m_yellowhelmet_status>0 || m_yellowhelmet_timmer>0)) {
						if (m_yellowhelmet_timmer==0) {
							m_yellowhelmet_timmer=32;
							m_yellowhelmet_status--;
						} // if
						saved=true;
					} // if 
				} // if 
				if (e->get_class()->cmp("GO_bullet")) {
					if (player_has("GO_yellowshield") && (m_yellowshield_status>0 || m_yellowshield_timmer>0)) {
						if (m_yellowshield_timmer==0) {
							m_yellowshield_timmer=32;
							m_yellowshield_status--;
						} // if
						saved=true;
					} // if 
				} // if 
				if (e->get_class()->cmp("GO_musicalnote")) {
					if (player_has("GO_whiteshield") && (m_whiteshield_status>0 || m_whiteshield_timmer>0)) {
						if (m_whiteshield_timmer==0) {
							m_whiteshield_timmer=32;
							m_whiteshield_status--;
						} // if
						saved=true;
					} // if 
				} // if 
				if (e->get_class()->cmp("GO_bone")) {
					if (player_has("GO_purpleshield") && (m_purpleshield_status>0 || m_purpleshield_timmer>0)) {
						if (m_purpleshield_timmer==0) {
							m_purpleshield_timmer=32;
							m_purpleshield_status--;
						} // if
						saved=true;
					} // if 
				} // if 
				if (e->get_class()->cmp("GO_drop")) {
					if (player_has("GO_greycoat") && (m_greycoat_status>0 || m_greycoat_timmer>0)) {
						if (m_greycoat_timmer==0) {
							m_greycoat_timmer=32;
							m_greycoat_status--;
						} // if
						saved=true;
					} // if 
				} // if 
				if (e->is_a("GO_skull")) {
					int exp;
					int score;
					if (player_has("GO_greenbook") && m_greenbook_status>0) {
						m_greenbook_status--;
						e->player_hit(&exp,&score);
						m_experience+=exp;
						saved=true;
					} // if 

					if (!saved) {
						if (player_has("GO_bluebook") && (m_bluebook_status>0 || m_bluebook_timmer>0)) {
							if (m_bluebook_timmer==0) {
								m_bluebook_timmer=32;
								m_bluebook_status--;
							} // if
							saved=true;
						} // if 
					} // if
				} // if 
				if (e->get_class()->cmp("GO_bat")) {
					int exp;
					int score;
					if (player_has("GO_lightbluebook") && m_lightbluebook_status>0) {
						m_lightbluebook_status--;
						e->player_hit(&exp,&score);
						m_experience+=exp;
						saved=true;
					} // if 

					if (!saved) {
						if (player_has("GO_lightbluehelmet") && (m_lightbluehelmet_status>0 || m_lightbluehelmet_timmer>0)) {
							if (m_lightbluehelmet_timmer==0) {
								m_lightbluehelmet_timmer=32;
								m_lightbluehelmet_status--;
							} // if
							saved=true;
						} // if 
					} // if
				} // if 
				if (e->get_class()->cmp("GO_skeleton")) {
					int exp;
					int score;
					if (player_has("GO_whitebook") && m_whitebook_status>0) {
						m_whitebook_status--;
						e->player_hit(&exp,&score);
						m_experience+=exp;
						saved=true;
					} // if 

					if (!saved) {
						if (player_has("GO_yellowbook") && (m_yellowbook_status>0 || m_yellowbook_timmer>0)) {
							if (m_yellowbook_timmer==0) {
								m_yellowbook_timmer=32;
								m_yellowbook_status--;
							} // if
							saved=true;
						} // if 
					} // if
				} // if 
				if (e->get_class()->cmp("GO_pipe_water")) {
					if (player_has("GO_yellowcoat") && m_yellowcoat_timmer>0) {
						saved=true;
						m_yellowcoat_timmer--;
					} // if 
				} // if 
				if (e->get_class()->cmp("GO_flame")) {
					if (player_has("GO_greencoat") && m_greencoat_timmer>0) {
						saved=true;
						m_greencoat_timmer--;
					} // if 
				} // if 
				if (e->get_class()->cmp("GO_fallingwater")) {
					if (player_has("GO_lightbluecoat") && m_lightbluecoat_timmer>0) {
						saved=true;
						m_lightbluecoat_timmer--;
					} // if 
				} // if 
				if (m_last_hit_by!=0) delete m_last_hit_by;
				m_last_hit_by=new Symbol(e->get_class());			
				if (!saved) {
					m_energy-=energy_taken;
					m_player_hit_counter=64;
					if (e->is_a("GO_fallingwater")) m_player_hit_counter=8;
					if (e->is_a("GO_flame")) m_player_hit_counter=8;
					if (e->is_a("GO_pipe_water")) m_player_hit_counter=8;
					if (m_energy>0) Sound_play(SFXM->get("sfx/player_hit"),m_sfx_volume);
							   else Sound_play(SFXM->get("sfx/player_dead"),m_sfx_volume);
				} // if
			} // if 
		} // if
	} // if 

	// check for experience:
	if (m_experience>=PLAYER_MAX_EXPERIENCE) {
		m_experience=0;
		m_energy+=8;
		if (m_energy>=PLAYER_MAX_ENERGY) m_energy=PLAYER_MAX_ENERGY;
	} // if 

	if (m_energy<=0 && m_state!=CSTATE_DYING && m_state!=CSTATE_DEAD) {
		m_player_hit_counter=512;
		m_energy=0;
		m_state=CSTATE_DYING;
		m_state_cycle=0;
		pause_continuous_sfx();
	} // if 

	if (m_yellowhelmet_timmer>0) m_yellowhelmet_timmer--;
	if (m_greycoat_timmer>0) m_greycoat_timmer--;
	if (m_bluebook_timmer>0) m_bluebook_timmer--;
	if (m_yellowshield_timmer>0) m_yellowshield_timmer--;
	if (m_whiteshield_timmer>0) m_whiteshield_timmer--;
	if (m_lightbluehelmet_timmer>0) m_lightbluehelmet_timmer--;
	if (m_yellowbook_timmer>0) m_yellowbook_timmer--;
	if (m_purpleshield_timmer>0) m_purpleshield_timmer--;
	if (m_clock_timmer>0) m_clock_timmer--;

	return true;
} /* GO_character::cycle */ 


void GO_character::draw(GLTManager *GLTM)
{
	int s=(m_state_cycle/8)%4;
	float xo=0,yo=0;

	switch(m_state) {
	case CSTATE_STANDING_LEFT:  m_last_tile_used=GLTM->get("ob_character-l1");
								break;
	case CSTATE_STANDING_RIGHT: m_last_tile_used=GLTM->get("ob_character-r1");
								break;
	case CSTATE_WALKING_LEFT:   if (s==0) m_last_tile_used=GLTM->get("ob_character-l2");
								if (s==1) m_last_tile_used=GLTM->get("ob_character-l1");
								if (s==2) m_last_tile_used=GLTM->get("ob_character-l3");
								if (s==3) m_last_tile_used=GLTM->get("ob_character-l1");
								break;
	case CSTATE_WALKING_RIGHT:	if (s==0) m_last_tile_used=GLTM->get("ob_character-r2");
								if (s==1) m_last_tile_used=GLTM->get("ob_character-r1");
								if (s==2) m_last_tile_used=GLTM->get("ob_character-r3");
								if (s==3) m_last_tile_used=GLTM->get("ob_character-r1");
								break;
	case CSTATE_PUNCH_LEFT:     m_last_tile_used=GLTM->get("ob_character-punch-l");								
								break;
	case CSTATE_PUNCH_RIGHT:    m_last_tile_used=GLTM->get("ob_character-punch-r");
								break;
	case CSTATE_FALLING_LEFT:   m_last_tile_used=GLTM->get("ob_character-l1");
								break;
	case CSTATE_FALLING_RIGHT:  m_last_tile_used=GLTM->get("ob_character-r1");
								break;
	case CSTATE_JUMPING_LEFT:	
	case CSTATE_JUMPING_LEFT_LEFT:
								m_last_tile_used=GLTM->get("ob_character-jump-l");
								break;
	case CSTATE_JUMPING_RIGHT:	
	case CSTATE_JUMPING_RIGHT_RIGHT:
								m_last_tile_used=GLTM->get("ob_character-jump-r");
								break;
	case CSTATE_JUMPPUNCH_LEFT:	
	case CSTATE_JUMPPUNCH_LEFT_LEFT:
								m_last_tile_used=GLTM->get("ob_character-punchjump-l");
								break;
	case CSTATE_JUMPPUNCH_RIGHT:	
	case CSTATE_JUMPPUNCH_RIGHT_RIGHT:
								m_last_tile_used=GLTM->get("ob_character-punchjump-r");
								break;
	case CSTATE_CLIMBING_UP:
	case CSTATE_CLIMBING:		
	case CSTATE_CLIMBING_DOWN:	
								if (s==0 || s==2) m_last_tile_used=GLTM->get("ob_character-climbing-1");
								if (s==1 || s==3) m_last_tile_used=GLTM->get("ob_character-climbing-2");
								break;
	case CSTATE_ENTERING_DOOR: 
								if (s==0) m_last_tile_used=GLTM->get("ob_character-r2");
								if (s==1) m_last_tile_used=GLTM->get("ob_character-r1");
								if (s==2) m_last_tile_used=GLTM->get("ob_character-r3");
								if (s==3) m_last_tile_used=GLTM->get("ob_character-r1");
								xo=-(m_state_cycle/75.0F);
								yo=0.0;
								break;
	} // switch

	if (m_player_hit_counter>0) {
		int bufi;
		float TexColorArray[4],bufvf[4];
		float f=float(0.5F+0.5F*sin(m_player_hit_counter*((m_state==CSTATE_DYING || m_state==CSTATE_DEAD) ? 0.8f:0.4f)));
		
#ifdef __MORPHOS__
		bufi = GL_MODULATE;
		bufvf[0] = 0.0f;
		bufvf[1] = 0.0f;
		bufvf[2] = 0.0f;
		bufvf[3] = 0.0f;
#else
		glGetTexEnviv(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,&bufi);
		glGetTexEnvfv(GL_TEXTURE_ENV,GL_TEXTURE_ENV_COLOR,bufvf);
#endif

		glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_BLEND);
		TexColorArray[0]=1.0f;
		TexColorArray[1]=1.0f;
		TexColorArray[2]=1.0f;
		TexColorArray[3]=0.0f;
		glTexEnvfv(GL_TEXTURE_ENV,GL_TEXTURE_ENV_COLOR,TexColorArray);

		if (xo==0 && yo==0) m_last_tile_used->draw(1,1,1,1,m_x,m_y,0,0,1);
					   else m_last_tile_used->draw_toffs(1,1,1,1,m_x,m_y,0,0,1,xo,yo);

		glColor4f(1,1,1,1); 
		glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,bufi);
		glTexEnvfv(GL_TEXTURE_ENV,GL_TEXTURE_ENV_COLOR,bufvf);

		glBindTexture(GL_TEXTURE_2D,0);	// I really don't understand this line of code, but if I don't add it,
										// I don't get the desired effect (I found this after like 2 hours of random guessing!)

		if (xo==0 && yo==0) m_last_tile_used->draw(1,1,1,f,m_x,m_y,0,0,1);
					   else m_last_tile_used->draw_toffs(1,1,1,f,m_x,m_y,0,0,1,xo,yo);
	} else {
		if (xo==0 && yo==0) m_last_tile_used->draw(1,1,1,1,m_x,m_y,0,0,1);
					   else m_last_tile_used->draw_toffs(1,1,1,1,m_x,m_y,0,0,1,xo,yo);
	} // if 

//	GLTM->get("ob_character-punch-mask-l")->draw(1,1,1,1,m_x,m_y,0,0,1);
//	GLTM->get("ob_character-punch-mask-r")->draw(1,1,1,1,m_x,m_y,0,0,1);

} /* GO_character::draw */ 


bool GO_character::is_a(Symbol *c)
{
	if (c->cmp("GO_character")) return true;

	return GObject::is_a(c);
} /* GO_character::is_a */ 


bool GO_character::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_character::is_a */ 


void GO_character::set_layer(int layer,GMap *map)
{
	if (layer!=m_layer) {
//		output_debug_message("%i -> %i\n",m_layer,layer);
		if (map!=0)	map->remove_object(this,m_layer);
		m_layer=layer;
		if (map!=0) map->add_object(this,m_layer);
	} // if 
} /* GO_character::set_layer */ 

void GO_character::inc_score(int score)
{
	m_score+=score;
}

