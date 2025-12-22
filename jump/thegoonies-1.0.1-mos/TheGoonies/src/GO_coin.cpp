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
#include "GO_coin.h"

#include "GMap.h"

#include "TheGooniesCtnt.h"


GO_coin::GO_coin(int x,int y,int sfx_volume) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_coin");

	m_facing=0;
	m_state=0;
	m_state_cycle=0;
} /* GO_coin::GO_coin */ 


bool GO_coin::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{

	m_state_cycle++;
	return true;
} /* GO_coin::cycle */ 


void GO_coin::draw(GLTManager *GLTM)
{
	int s=(m_state_cycle/8)%4;

	if (s==0) m_last_tile_used=GLTM->get("ob_coin1");
	if (s==1) m_last_tile_used=GLTM->get("ob_coin2");
	if (s==2) m_last_tile_used=GLTM->get("ob_coin3");
	if (s==3) m_last_tile_used=GLTM->get("ob_coin4");

	if (m_last_tile_used!=0) m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_coin::draw */ 


bool GO_coin::is_a(Symbol *c)
{
	if (c->cmp("GO_coin")) return true;

	return GObject::is_a(c);
} /* GO_coin::is_a */ 


bool GO_coin::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_coin::is_a */ 


