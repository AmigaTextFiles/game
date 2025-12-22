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
#include "GMap.h"

#include "GO_enemy.h"
#include "GO_drop.h"
#include "GO_dropgenerator.h"

#include "GObjectCreator.h"

GO_dropgenerator::GO_dropgenerator(int x,int y,int sfx_volume) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_dropgenerator");

	m_state_cycle=96;
} /* GObject::GObject */ 


bool GO_dropgenerator::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	m_state_cycle++;

	if (m_state_cycle>128) {
		// generate a new drop:
		Symbol *s=new Symbol("GO_drop");
		GObject *o=GObject_create(s,(int)m_x,(int)(m_y+16),m_sfx_volume,0);
		delete s;
		map->add_object(o,layer);
		m_state_cycle=0;
	} // if 
	return true;
} /* GO_dropgenerator::cycle */ 



bool GO_dropgenerator::is_a(Symbol *c)
{
	if (c->cmp("GO_dropgenerator")) return true;

	return GObject::is_a(c);
} /* GO_dropgenerator::is_a */ 


bool GO_dropgenerator::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_dropgenerator::is_a */ 
