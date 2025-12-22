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
#include "sound.h"

#include "GLTManager.h"
#include "SFXManager.h"
#include "GObject.h"
#include "GO_enemy.h"
#include "GO_skeleton.h"
#include "GO_character.h"

#include "GObjectCreator.h"

#include "GMap.h"

#include "TheGooniesCtnt.h"

#include "debug.h"

extern int difficulty;

GO_skeleton::GO_skeleton(int x,int y,int sfx_volume,int facing) : GO_enemy(x,y,sfx_volume)
{
	m_class=new Symbol("GO_skeleton");

	m_facing=facing;
	m_state=5;
	m_state_cycle=0;
	m_time_since_last_bone=0;

	m_walking_channel=-1;
} /* GO_skeleton::GO_skeleton */ 


GO_skeleton::~GO_skeleton()
{
	stop_continuous_sfx();
} /* GO_skeleton::~GO_skeleton */ 




bool GO_skeleton::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{

#ifdef __DEBUG_MESSAGES
	output_debug_message("Skeleton %i,%i -> %g,%g\n",m_state,m_state_cycle,m_x,m_y);
#endif

	GO_character *c=(GO_character *)map->get_object("GO_character");
	bool has_purplebadbook=false;
	if (c!=0 && c->player_has("GO_purplebadbook")!=0) has_purplebadbook=true;

	switch(m_state) {
	case 0: // appearing
			if (m_state_cycle>64) {
				m_state=1;
				m_state_cycle=0;
			} // if 
			break;
	case 1: // moving
			if (m_walking_channel==-1) {
				m_walking_channel=Sound_play_continuous(SFXM->get("sfx/skeleton_walk"),m_sfx_volume);
			} // if 
			if (m_facing==0) {
				m_x-=(has_purplebadbook ? SKELETON_SPEED-(100/150-difficulty/150):(SKELETON_SPEED-(100/150-difficulty/150))*1.25f);
				if (m_x<0 ||
					map->collision_with_background_wo_bridges(this,-2,0,GLTM) ||
					(map->collision_with_background_wo_bridges(this,-15,32,GLTM) &&
					!map->collision_with_background_wo_bridges(this,-20,32,GLTM))) {
					m_x+=(has_purplebadbook ? SKELETON_SPEED-(100/150-difficulty/150):(SKELETON_SPEED-(100/150-difficulty/150))*1.25f);
					m_facing=1;
				} // if
			} else {
				m_x+=(has_purplebadbook ? SKELETON_SPEED-(100/150-difficulty/150):(SKELETON_SPEED-(100/150-difficulty/150))*1.25f);
				if (m_x+16>map->get_dx() ||
					map->collision_with_background_wo_bridges(this,2,0,GLTM) ||
					(map->collision_with_background_wo_bridges(this,15,32,GLTM) &&
					!map->collision_with_background_wo_bridges(this,20,32,GLTM))) {
					m_x-=(has_purplebadbook ? SKELETON_SPEED-(100/150-difficulty/150):(SKELETON_SPEED-(100/150-difficulty/150))*1.25f);
					m_facing=0;
				} // if
			} // if 
			// if player on sight, shoot:

			if (m_state_cycle>25 && m_time_since_last_bone>150) {
				GO_character *c=(GO_character *)map->get_object("GO_character");
				if (c!=0) {
					if (m_facing==0) {
						if (c->get_x()<m_x && c->get_y()-40>m_y-32 && c->get_y()-40<m_y+32) {
							m_state=3;
							m_state_cycle=0;
						} // if 
					} else {
						if (c->get_x()>m_x && c->get_y()-40>m_y-32 && c->get_y()-40<m_y+32) {
							m_state=3;
							m_state_cycle=0;
						} // if 
					} // if 
				} // if 
			} // if 

			break;
	case 2: // dying
			if (m_walking_channel!=-1) {
				Mix_HaltChannel(m_walking_channel);
				m_walking_channel=-1;
			} // if 
			if (m_state_cycle==0) Sound_play(SFXM->get("sfx/skeleton_dead"),m_sfx_volume);

			if (m_state_cycle>32) {
				m_state=4;
				m_state_cycle=0;
			} // if 
			break;
	case 3: // shooting:
			if (m_walking_channel!=-1) {
				Mix_HaltChannel(m_walking_channel);
				m_walking_channel=-1;
			} // if 
			if (m_state_cycle==32) {
				// shoot:
				Symbol *s=new Symbol("GO_bone");
				List<int> l;
				l.Add(new int(m_facing));
				if (m_facing==0) map->add_object(GObject_create(s,(int)(m_x-16),(int)(m_y),m_sfx_volume,&l),2);
							else map->add_object(GObject_create(s,(int)(m_x+28),(int)(m_y),m_sfx_volume,&l),2);
				delete s;
				Sound_play(SFXM->get("sfx/skeleton_attack"),m_sfx_volume);
			} // if 

			if (m_state_cycle>64) {							
				m_time_since_last_bone=0;
				m_state=1;
				m_state_cycle=0;
			} // if 
			break;
	case 4: // pause before reapearing:
			if (m_state_cycle>500) {
				m_state=0;
				m_state_cycle=0;
				Sound_play(SFXM->get("sfx/enemy_appear"),m_sfx_volume);
			} // if 
			break;
	case 5: // standing and looking to both sides:
			if (map->collision_with_background(this,0,0,GLTM)) m_y--;
			if (m_state_cycle>50) {
				m_state=1;
				m_state_cycle=0;
			} // if 
			break;
	} // switch	

	m_state_cycle++;
	m_time_since_last_bone++;
	return true;
} /* GO_skeleton::cycle */ 


void GO_skeleton::draw(GLTManager *GLTM)
{
	int s=(m_state_cycle/8)%4;

	switch(m_state) {
	case 0: 
			if (s==0) m_last_tile_used=GLTM->get("ob_smoke1");
			if (s==1) m_last_tile_used=GLTM->get("ob_smoke1");
			if (s==2) m_last_tile_used=GLTM->get("ob_smoke2");
			if (s==3) m_last_tile_used=GLTM->get("ob_smoke2");
			break;
	case 1:
			if (m_facing==0) {
				if (s==0) m_last_tile_used=GLTM->get("ob_skeleton-l1");
				if (s==1) m_last_tile_used=GLTM->get("ob_skeleton-l2");
				if (s==2) m_last_tile_used=GLTM->get("ob_skeleton-l1");
				if (s==3) m_last_tile_used=GLTM->get("ob_skeleton-l3");
			} else {
				if (s==0) m_last_tile_used=GLTM->get("ob_skeleton-r1");
				if (s==1) m_last_tile_used=GLTM->get("ob_skeleton-r2");
				if (s==2) m_last_tile_used=GLTM->get("ob_skeleton-r1");
				if (s==3) m_last_tile_used=GLTM->get("ob_skeleton-r3");
			} /* if */ 
			break;
	case 2:
			m_last_tile_used=GLTM->get("ob_skull-death");
			break;
	case 3:
			if (m_facing==0) {
				m_last_tile_used=GLTM->get("ob_skeleton-l1");
			} else {
				m_last_tile_used=GLTM->get("ob_skeleton-r1");
			} /* if */ 
			break;
	case 4:
			m_last_tile_used=0;
			break;
	case 5:
			if (m_facing==0) {
				if (m_state_cycle<25) m_last_tile_used=GLTM->get("ob_skeleton-l1");
							     else m_last_tile_used=GLTM->get("ob_skeleton-r1");
			} else {
				if (m_state_cycle<25) m_last_tile_used=GLTM->get("ob_skeleton-r1");
							     else m_last_tile_used=GLTM->get("ob_skeleton-l1");
			} /* if */ 
			break;
	} // switch 
	if (m_last_tile_used!=0) m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_skeleton::draw */ 


bool GO_skeleton::is_a(Symbol *c)
{
	if (c->cmp("GO_skeleton")) return true;

	return GO_enemy::is_a(c);
} /* GO_skeleton::is_a */ 


bool GO_skeleton::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_skeleton::is_a */ 


bool GO_skeleton::player_hit(int *experience, int *score)
{
	if (m_state!=0 && m_state!=2 && m_state!=4) {
		m_state=2;
		m_state_cycle=0;
		*experience=1;
		*score=100;
		return true;
	} // if 
	return false;
} /* GO_skeleton::player_hit */ 



int GO_skeleton::enemy_hit(void)
{
	if (m_state!=0 && m_state!=2 && m_state!=4) return 8;
	return 0;
} /* GO_skeleton::enemy_hit */ 




void GO_skeleton::stop_continuous_sfx(void)
{
	if (m_walking_channel!=-1) {
		Mix_HaltChannel(m_walking_channel);
		m_walking_channel=-1;
	} // if 
} /* GO_skeleton::stop_continuous_sfx */ 


void GO_skeleton::pause_continuous_sfx(void)
{
	if (m_walking_channel!=-1) {
		Mix_Pause(m_walking_channel);
	} // if 
} /* GO_skeleton::pause_continuous_sfx */ 


void GO_skeleton::resume_continuous_sfx(void)
{
	if (m_walking_channel!=-1) {
		Mix_Resume(m_walking_channel);
	} // if 
} /* GO_skeleton::resume_continuous_sfx */ 

