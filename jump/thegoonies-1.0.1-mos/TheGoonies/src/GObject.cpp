#ifdef KITSCHY_DEBUG_MEMORY 
#include "debug_memorymanager.h"
#endif


#ifdef _WIN32
#include "windows.h"
#endif

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
#include "GObject.h"


GObject::GObject(int x,int y,int sfx_volume)
{
	m_class=new Symbol("GObject");
	m_sfx_volume=sfx_volume;
	m_x=x;
	m_y=y;
	m_last_tile_used=0;
	m_state=0;
	m_state_cycle=0;
} /* GObject::GObject */ 


GObject::~GObject()
{
	delete m_class;
} /* GObject::~GObject */ 


bool GObject::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	return true;
} /* GObject::cycle */ 


void GObject::draw(GLTManager *GLTM)
{
} /* GObject::draw */ 


bool GObject::is_a(Symbol *c)
{
	return c->cmp("GObject");
} /* GObject::is_a */ 


bool GObject::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GObject::is_a */ 


bool GObject::collision(GObject *o)
{
	if (m_last_tile_used==0) return false;
	return o->collision(m_last_tile_used,(int)m_x,(int)m_y);
} /* GObject::collision */ 


bool GObject::collision(GLTile *t,int x,int y)
{
	if (m_last_tile_used==0) return false;
	return m_last_tile_used->get_cmc()->collision(m_x,m_y,0,t->get_cmc(),x,y,0);
} /* GObject::collision */ 


bool GObject::collision(C2DCMC *c,int x,int y)
{
	if (m_last_tile_used==0) return false;
	return m_last_tile_used->get_cmc()->collision(m_x,m_y,0,c,x,y,0);
} /* GObject::collision */ 



bool GObject::collision(int xoffs,int yoffs,GLTile *t,int x,int y)
{
	if (m_last_tile_used==0) return false;
	return m_last_tile_used->get_cmc()->collision(m_x+xoffs,m_y+yoffs,0,t->get_cmc(),x,y,0);
} /* GObject::collision */ 


void GObject::pause_continuous_sfx(void)
{
} /* GObject::pause_continuous_sfx */ 


void GObject::stop_continuous_sfx(void)
{
} /* GObject::stop_continuous_sfx */ 


void GObject::resume_continuous_sfx(void)
{
} /* GObject::resume_continuous_sfx */ 

