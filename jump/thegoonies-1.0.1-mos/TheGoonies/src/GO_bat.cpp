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
#include "GO_bat.h"
#include "GO_character.h"

#include "GMap.h"

#include "TheGooniesCtnt.h"

extern int difficulty;

GO_bat::GO_bat(int x,int y,int sfx_volume) : GO_enemy(x,y,sfx_volume)
{
	m_class=new Symbol("GO_bat");

	m_cave_x=x;
	m_cave_y=y;
	m_original_y=y;
	m_state=0;
	m_state_cycle=0;

	m_flying_channel=-1;
} /* GO_bat::GO_bat */ 


GO_bat::~GO_bat()
{
	stop_continuous_sfx();
} /* GO_bat::~GO_bat */ 


bool GO_bat::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	m_state_cycle++;

	switch(m_state) {
	case 0: {
				GO_character *c=(GO_character *)map->get_object("GO_character");
				m_x=float(m_cave_x);
				m_y=float(m_cave_y);
				m_original_y=m_cave_y;
				if (c!=0) {
					if (c->get_x()>=m_x+120 && c->get_x()<m_x+180 &&
						c->get_y()>=m_y-40 && c->get_y()<m_y+40) {
						m_state=1;
						m_state_cycle=0;
					} // if
					if (c->get_x()>=m_x-180 && c->get_x()<m_x-120 &&
						c->get_y()>=m_y-40 && c->get_y()<m_y+40) {
						m_state=1;
						m_state_cycle=0;
					} // if

				} // if
			}
			break;

	case 1:	// initial pause
			if (m_flying_channel==-1) {
				m_flying_channel=Sound_play_continuous(SFXM->get("sfx/bat_fly"),m_sfx_volume);
			} // if 
			if (m_state_cycle>=128) {
				m_state_cycle=0;
				m_original_y-=2;
				GObject *o=map->get_object("GO_character");
				if (o!=0) {
					if (o->get_x()<m_x) m_state=2;
								   else m_state=3;
				} else {
					m_state=2;
				} // if 
			} // if
			break;
	case 2:	// left
			{
				float s=float(sin(m_state_cycle*0.06));
				m_y=(m_original_y)-20*s;
			}
			m_x-=BAT_SPEED-(100/150-difficulty/150);

			if (m_x<0 ||
				map->collision_with_background_wo_bridges(this,-2,(int)(m_original_y-m_y),GLTM)) m_state=3;
			
			if (m_state_cycle>=512 && 
				!map->collision_with_background_wo_bridges(this,0,-12,GLTM) &&
				!map->collision_with_background_wo_bridges(this,0,+12,GLTM)) {
				m_state_cycle=0;
				m_original_y=(int)m_y;
				GObject *o=map->get_object("GO_character");
				if (o!=0) {
					if (o->get_y()<m_y) m_state=4;
								   else m_state=5;
				} // if 
			} // if 
			break;
	case 3: // right
			{
				float s=float(sin(m_state_cycle*0.06));
				m_y=(m_original_y)-20*s;
			}
			m_x+=BAT_SPEED-(100/150-difficulty/150);

			if (m_x+16>map->get_dx() ||
				map->collision_with_background_wo_bridges(this,2,(int)(m_original_y-m_y),GLTM)) m_state=2;

			if (m_state_cycle>=512 && 
				!map->collision_with_background_wo_bridges(this,0,-12,GLTM) &&
				!map->collision_with_background_wo_bridges(this,0,+12,GLTM)) {
				m_state_cycle=0;
				m_original_y=(int)m_y;
				GObject *o=map->get_object("GO_character");
				if (o!=0) {
					if (o->get_y()<m_y) m_state=4;
								   else m_state=5;
				} // if 
			} // if 
			break;
	case 4:	// up
			m_y-=1;
			m_original_y-=1;
			if (m_state_cycle>=64 ||
				map->collision_with_background_wo_bridges(this,0,-12,GLTM)) {
				GObject *o=map->get_object("GO_character");
				m_state_cycle=0;
				if (o!=0) {
					if (o->get_x()<m_x) m_state=2;
								   else m_state=3;
				} else {
					m_state=2;
				} // if 
			} // if 
			break;
	case 5:	// down
			m_y+=1;
			m_original_y+=1;
			if (m_state_cycle>=64 ||
				map->collision_with_background_wo_bridges(this,0,12,GLTM)) {
				GObject *o=map->get_object("GO_character");
				m_state_cycle=0;
				if (o!=0) {
					if (o->get_x()<m_x) m_state=2;
								   else m_state=3;
				} else {
					m_state=2;
				} // if 
			} // if 
			break;
	case 6:	// dying
			if (m_flying_channel!=-1) {
				Mix_HaltChannel(m_flying_channel);
				m_flying_channel=-1;
			} // if 
			if (m_state_cycle>32) {
				m_state=0;
				m_state_cycle=0;
			} // if
			break;
	} // switch 
	return true;
} /* GO_bat::cycle */ 


void GO_bat::draw(GLTManager *GLTM)
{
	if (m_state==0) {
		m_last_tile_used=0;
		return;
	} // if
	if (m_state==6) {
		m_last_tile_used=GLTM->get("ob_bat-death");
	} else {
		int s=(m_state_cycle/8)%2;

		if (s==0) m_last_tile_used=GLTM->get("ob_bat1");
			 else m_last_tile_used=GLTM->get("ob_bat2");
	} // if 
	m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_bat::draw */ 


bool GO_bat::is_a(Symbol *c)
{
	if (c->cmp("GO_bat")) return true;

	return GO_enemy::is_a(c);
} /* GO_bat::is_a */ 


bool GO_bat::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_bat::is_a */ 


bool GO_bat::player_hit(int *experience, int *score)
{
	if (m_state!=6) {
		m_state=6;
		m_state_cycle=0;
		*experience=1;
		*score=100;
		return true;
	} // if 
	return false;
} /* GO_bat::player_hit */ 


int GO_bat::enemy_hit(void)
{
	if (m_state!=6 && m_state!=0) return 8;
	return 0;
} /* GO_bat::enemy_hit */ 



void GO_bat::stop_continuous_sfx(void)
{
	if (m_flying_channel!=-1) {
		Mix_HaltChannel(m_flying_channel);
		m_flying_channel=-1;
	} // if 
} /* GO_bat::stop_continuous_sfx */ 


void GO_bat::pause_continuous_sfx(void)
{
	if (m_flying_channel!=-1) {
		Mix_Pause(m_flying_channel);
	} // if 
} /* GO_bat::pause_continuous_sfx */ 


void GO_bat::resume_continuous_sfx(void)
{
	if (m_flying_channel!=-1) {
		Mix_Resume(m_flying_channel);
	} // if 
} /* GO_bat::resume_continuous_sfx */ 

