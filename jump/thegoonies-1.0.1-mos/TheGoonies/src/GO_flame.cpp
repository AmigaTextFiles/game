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
#include "GO_character.h"
#include "GO_flame.h"

#include "GMap.h"

#include "TheGooniesCtnt.h"


GO_flame::GO_flame(int x,int y,int sfx_volume) : GO_enemy(x,y,sfx_volume)
{
	m_class=new Symbol("GO_flame");

	m_state=0;
	m_state_cycle=0;
	m_flame_channel=-1;
} /* GO_flame::GO_flame */ 

GO_flame::~GO_flame() 
{
	stop_continuous_sfx();
} /* GO_flame;;~GO_flame */ 


void GO_flame::stop_continuous_sfx(void)
{
	if (m_flame_channel!=-1) {
		Mix_HaltChannel(m_flame_channel);
		m_flame_channel=-1;
	} // if 
} /* GO_flame::stop_continuous_sfx */ 


void GO_flame::pause_continuous_sfx(void)
{
	if (m_flame_channel!=-1) {
		Mix_Pause(m_flame_channel);
	} // if 
} /* GO_flame::pause_continuous_sfx */ 


void GO_flame::resume_continuous_sfx(void)
{
	if (m_flame_channel!=-1) {
		Mix_Resume(m_flame_channel);
	} // if 
} /* GO_flame::resume_continuous_sfx */ 


bool GO_flame::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	switch(m_state) {
	case 0:	// waiting for the player
			{
				GO_character *c=(GO_character *)map->get_object("GO_character");
				if (c!=0) {
					if (c->get_x()>=m_x-60 && c->get_x()<m_x+80 &&
						c->get_y()>=m_y && c->get_y()<m_y+100) {
						m_state=1;
						m_state_cycle=0;
						if (m_flame_channel==-1) {
							m_flame_channel=Sound_play_continuous(SFXM->get("sfx/flame"),m_sfx_volume);
						}				
					} // if
				} // if
			}
			break;
	case 1: // flaming
			if (m_state_cycle>128) {
				m_state=2;
				m_state_cycle=0;
				if (m_flame_channel!=-1) {
					Mix_HaltChannel(m_flame_channel);
					m_flame_channel=-1;
				}
			} // if 
			break;
	case 2: // waiting for the player to be far
			{
				GO_character *c=(GO_character *)map->get_object("GO_character");
				if (c!=0) {
					if (c->get_x()>=m_x-60 && c->get_x()<m_x+80 &&
						c->get_y()>=m_y && c->get_y()<m_y+100) {
					} else {
						m_state=0;
					} // if
				} // if
			}
			break;
	} // switch
	m_state_cycle++;
	return true;
} /* GO_flame::cycle */ 


void GO_flame::draw(GLTManager *GLTM)
{
	int s=(m_state_cycle/4)%2;

	switch(m_state) {
	case 0: m_last_tile_used=0;
			break;
	case 1: if (m_state_cycle<8) {
				m_last_tile_used=GLTM->get("ob_flame1");
			} else {
				if (s==0) m_last_tile_used=GLTM->get("ob_flame2");
				     else m_last_tile_used=GLTM->get("ob_flame3");
			} // if
			break;
	case 2: m_last_tile_used=0;
			break;
	} // switch 

	if (m_last_tile_used!=0) m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_flame::draw */ 


bool GO_flame::is_a(Symbol *c)
{
	if (c->cmp("GO_flame")) return true;

	return GO_enemy::is_a(c);
} /* GO_flame::is_a */ 


bool GO_flame::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_flame::is_a */ 



int GO_flame::enemy_hit(void)
{
	if (m_state==1) return 2;
	return 0;
} /* GO_flame::enemy_hit */ 

