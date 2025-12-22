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

#include "GLTManager.h"
#include "SFXManager.h"
#include "GObject.h"
#include "GO_enemy.h"
#include "GO_pipe_water.h"

#include "sound.h"

GO_pipe_water::GO_pipe_water(int x,int y,int sfx_volume,int facing) : GO_enemy(x,y,sfx_volume)
{
	m_class=new Symbol("GO_pipe_water");

	m_facing=facing;
	m_state=0;
	m_state_cycle=0;
	m_wait_cycles=100;
	m_pipe_channel=-1;
} /* GO_pipe_water::GO_pipe_water */ 

GO_pipe_water::~GO_pipe_water()
{
	stop_continuous_sfx();
}

bool GO_pipe_water::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	m_state_cycle++;
	switch(m_state) {
	case 0: if (m_state_cycle>m_wait_cycles) {
				m_state=1;
				m_state_cycle=0;
			} // if 
			break;
	case 1: 
			if (m_pipe_channel==-1) {
				m_pipe_channel=Sound_play_continuous(SFXM->get("sfx/water_vent"),m_sfx_volume);
			}				
			if (m_state_cycle>100) {
				m_state=2;
				m_state_cycle=0;
			} // if 
			break;
	case 2: 
			if (m_state_cycle>100) {
				m_state=3;
				m_state_cycle=0;
			} // if 
			break;
	case 3: if (m_state_cycle>100) {
				if (m_pipe_channel!=-1) {
					Mix_HaltChannel(m_pipe_channel);
					m_pipe_channel=-1;
				}
				m_state=0;
				m_state_cycle=0;
				m_wait_cycles=100+(rand()%4)*50;
			} // if 
			break;
	} // switch 
	return true;
} /* GO_pipe_water::cycle */ 


void GO_pipe_water::draw(GLTManager *GLTM)
{
	int s=(m_state_cycle/8)%2;

	switch(m_state) {
	case 0: m_last_tile_used=0;
			break;
	case 1:
	case 3:
			if (m_facing==0) {
				if (s==0) m_last_tile_used=GLTM->get("ob_pipe-water-l1");
					 else m_last_tile_used=GLTM->get("ob_pipe-water-l2");
				m_last_tile_used->draw(m_x+20,m_y,0,0,1);
			} else {
				if (s==0) m_last_tile_used=GLTM->get("ob_pipe-water-r1");
					 else m_last_tile_used=GLTM->get("ob_pipe-water-r2");
				m_last_tile_used->draw(m_x,m_y,0,0,1);
			} // if
			break;
	case 2:
			if (m_facing==0) {
				if (s==0) m_last_tile_used=GLTM->get("ob_pipe-water-l3");
					 else m_last_tile_used=GLTM->get("ob_pipe-water-l4");
			} else {
				if (s==0) m_last_tile_used=GLTM->get("ob_pipe-water-r3");
					 else m_last_tile_used=GLTM->get("ob_pipe-water-r4");
			} // if
			m_last_tile_used->draw(m_x,m_y,0,0,1);
			break;
	} // switch
	
} /* GO_pipe_water::draw */ 


bool GO_pipe_water::is_a(Symbol *c)
{
	if (c->cmp("GO_pipe_water")) return true;

	return GO_enemy::is_a(c);
} /* GO_pipe_water::is_a */ 


bool GO_pipe_water::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_pipe_water::is_a */ 


bool GO_pipe_water::player_hit(int *experience, int *score)
{
	return false;
} /* GO_pipe_water::player_hit */ 


int GO_pipe_water::enemy_hit(void)
{
	if (m_state==2)	return 2;
	return 0;
} /* GO_pipe_water::enemy_hit */ 

void GO_pipe_water::stop_continuous_sfx(void)
{
	if (m_pipe_channel!=-1) {
		Mix_HaltChannel(m_pipe_channel);
		m_pipe_channel=-1;
	}
}
