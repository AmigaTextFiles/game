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
#include "GO_bone.h"

#include "GMap.h"

#include "TheGooniesCtnt.h"

extern int difficulty;

GO_bone::GO_bone(int x,int y,int sfx_volume,int facing) : GO_enemy(x,y,sfx_volume)
{
	m_class=new Symbol("GO_bone");

	m_state=0;
	m_state_cycle=0;

	m_facing=facing;
} /* GO_bone::GO_bone */ 


bool GO_bone::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	if (m_state==0) {
		if (m_facing==0) m_x-=BONE_SPEED-(100/150-difficulty/150);
					else m_x+=BONE_SPEED-(100/150-difficulty/150);
	} // if 
	m_state_cycle++;

	if (m_x<0 || m_x>map->get_dx()) return false;
	if (map->collision_with_background(this,GLTM)) return false;
	if (m_state==1 && m_state_cycle>32) m_state=2;
	if (m_state==2) return false;
	return true;
} /* GO_bone::cycle */ 


void GO_bone::draw(GLTManager *GLTM)
{
	int s=(m_state_cycle/8)%4;

	if (m_state==0) {
		switch(s) {
		case 0: m_last_tile_used=GLTM->get("ob_bone1");
				break;
		case 1: m_last_tile_used=GLTM->get("ob_bone2");
				break;
		case 2: m_last_tile_used=GLTM->get("ob_bone3");
				break;
		case 3: m_last_tile_used=GLTM->get("ob_bone4");
				break;
		} // switch
	} else {
		m_last_tile_used=GLTM->get("ob_skull-death");
	} // if 

	m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_bone::draw */ 


bool GO_bone::is_a(Symbol *c)
{
	if (c->cmp("GO_bone")) return true;

	return GO_enemy::is_a(c);
} /* GO_bone::is_a */ 


bool GO_bone::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_bone::is_a */ 


bool GO_bone::player_hit(int *experience, int *score)
{
	if (m_state==0) {
		m_state=1;
		m_state_cycle=0;
		*experience=1;
		return true;
	} // if 
	return false;
} /* GO_bone::player_hit */ 


int GO_bone::enemy_hit(void)
{
	if (m_state==0) {
		m_state=2;
		m_state_cycle=0;
		return 8;
	} // if 
	return 0;
} /* GO_bone::enemy_hit */ 

