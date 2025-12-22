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
#include "GO_skull.h"

#include "GMap.h"

#include "TheGooniesCtnt.h"

extern int difficulty;

GO_skull::GO_skull(int x,int y,int sfx_volume,int facing) : GO_enemy(x,y,sfx_volume)
{
	m_class=new Symbol("GO_skull");

	m_facing=facing;
	m_state=0;
	m_state_cycle=0;
} /* GO_skull::GO_skull */ 


bool GO_skull::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	switch(m_state) {
	case 0:	// initial pause
			if (m_state_cycle>5) {
				m_state=1;
				m_state_cycle=0;
				Sound_play(SFXM->get("sfx/enemy_appear"),m_sfx_volume);
			} // if 
			break;
	case 1: // appearing
			if (m_state_cycle>64) {
				m_state=2;
				m_state_cycle=0;
			} // if 
			break;
	case 2: // moving
			if (m_facing==0) {
				m_x-=SKULL_SPEED-(100/150-difficulty/150);
				if (m_x<0 ||
					map->collision_with_background_wo_bridges(this,-2,0,GLTM) ||
					(map->collision_with_background_wo_bridges(this,-18,24,GLTM) &&
					!map->collision_with_background_wo_bridges(this,-20,24,GLTM))) m_facing=1;
			} else {
				m_x+=SKULL_SPEED-(100/150-difficulty/150);

				if (m_x+16>map->get_dx() ||
					map->collision_with_background_wo_bridges(this,2,0,GLTM) ||
					(map->collision_with_background_wo_bridges(this,18,24,GLTM) &&
					!map->collision_with_background_wo_bridges(this,20,24,GLTM))) m_facing=0;
			} // if 
			break;
	case 3: // dying
			if (m_state_cycle==0) {
				Sound_play(SFXM->get("sfx/skull_dead"),m_sfx_volume);
			} // if 
			if (m_state_cycle>32) return false;
			break;
	} // switch
	m_state_cycle++;
	return true;
} /* GO_skull::cycle */ 


void GO_skull::draw(GLTManager *GLTM)
{
	int s=(m_state_cycle/8)%2;

	switch(m_state) {
	case 0: m_last_tile_used=0;
			break;
	case 1: 
			if (s==0) m_last_tile_used=GLTM->get("ob_smoke1");
			     else m_last_tile_used=GLTM->get("ob_smoke2");
			break;
	case 2:
			if (m_facing==0) {
				if (s==0) m_last_tile_used=GLTM->get("ob_skull-l1");
					 else m_last_tile_used=GLTM->get("ob_skull-l2");
			} else {
				if (s==0) m_last_tile_used=GLTM->get("ob_skull-r1");
					 else m_last_tile_used=GLTM->get("ob_skull-r2");
			} /* if */ 
			break;
	case 3:
			m_last_tile_used=GLTM->get("ob_skull-death");
			break;
	} // switch 

	if (m_last_tile_used!=0) m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_skull::draw */ 


bool GO_skull::is_a(Symbol *c)
{
	if (c->cmp("GO_skull")) return true;

	return GO_enemy::is_a(c);
} /* GO_skull::is_a */ 


bool GO_skull::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_skull::is_a */ 


bool GO_skull::player_hit(int *experience, int *score)
{
	if (m_state==2) {
		m_state=3;
		m_state_cycle=0;
		*experience=1;
		*score=50;
		return true;
	} // if 
	return false;
} /* GO_skull::player_hit */ 


int GO_skull::enemy_hit(void)
{
	if (m_state==2) return 8;
	return 0;
} /* GO_skull::enemy_hit */ 

