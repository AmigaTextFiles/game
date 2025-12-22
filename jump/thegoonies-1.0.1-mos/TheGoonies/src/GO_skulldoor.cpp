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

#include "GO_skulldoor.h"


GO_skulldoor::GO_skulldoor(int x,int y,int sfx_volume) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_skulldoor");

	m_state_cycle=0;
	m_destination_x=0;
	m_destination_y=0;
	m_destination_door=0;
} /* GObject::GObject */ 


GO_skulldoor::GO_skulldoor(int x,int y,int sfx_volume,int dx,int dy,int dd) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_skulldoor");

	m_state_cycle=0;
	m_destination_x=dx;
	m_destination_y=dy;
	m_destination_door=dd;
} /* GObject::GObject */ 


bool GO_skulldoor::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	m_state_cycle++;

	return true;
} /* GO_skulldoor::cycle */ 


void GO_skulldoor::draw(GLTManager *GLTM)
{
	m_last_tile_used=GLTM->get("ob_skull-entrance");
	m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_skulldoor::draw */ 


bool GO_skulldoor::is_a(Symbol *c)
{
	if (c->cmp("GO_skulldoor")) return true;

	return GObject::is_a(c);
} /* GO_skulldoor::is_a */ 


bool GO_skulldoor::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_skulldoor::is_a */ 
