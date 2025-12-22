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
#include "GO_drop.h"

#include "GMap.h"


GO_drop::GO_drop(int x,int y,int sfx_volume) : GO_enemy(x,y,sfx_volume)
{
	m_class=new Symbol("GO_drop");

	m_state=0;
	m_state_cycle=0;
} /* GO_drop::GO_drop */ 


bool GO_drop::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	m_state_cycle++;

	switch(m_state) {
	case 0: if (m_state_cycle>32) {
				m_state=1;
				m_state_cycle=0;
			} /* if */ 
			break;
	case 1:	m_y+=2;
			
			if (map->collision_with_background(this,0,2,GLTM)) {
				switch(rand()%3) {
				case 0: Sound_play(SFXM->get("sfx/waterdrop"),m_sfx_volume);
						break;
				case 1: Sound_play(SFXM->get("sfx/waterdrop2"),m_sfx_volume);
						break;
				case 2: Sound_play(SFXM->get("sfx/waterdrop3"),m_sfx_volume);
						break;
				} // switch
				m_state=2;
				m_state_cycle=0;
			} // if 
			break;
	case 2:	if (m_state_cycle>16) return false;
			break;
	} // switch
	return true;
} /* GO_drop::cycle */ 


void GO_drop::draw(GLTManager *GLTM)
{
	switch(m_state) {
	case 0: {
				int s=m_state_cycle/16;
				if (s==0) m_last_tile_used=GLTM->get("ob_drop1");
				if (s==1) m_last_tile_used=GLTM->get("ob_drop2");
				if (s==2) m_last_tile_used=GLTM->get("ob_drop3");
			}
			break;
	case 1: m_last_tile_used=GLTM->get("ob_drop3");
			break;
	case 2: m_last_tile_used=GLTM->get("ob_drop4");
			break;
	} // switch

	m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_drop::draw */ 


bool GO_drop::is_a(Symbol *c)
{
	if (c->cmp("GO_drop")) return true;

	return GO_enemy::is_a(c);
} /* GO_drop::is_a */ 


bool GO_drop::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_drop::is_a */ 


int GO_drop::enemy_hit(void)
{
	if (m_state==0 || m_state==1) {
		m_state=2;
		m_state_cycle=0;
		return 8;
	} // if
	return 0; 
} /* GO_drop::enemy_hit */ 

