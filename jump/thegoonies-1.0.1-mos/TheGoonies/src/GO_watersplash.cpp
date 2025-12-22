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

#include "GO_watersplash.h"


GO_watersplash::GO_watersplash(int x,int y,float speed_x,float speed_y,int sfx_volume) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_watersplash");

	m_speed_x=speed_x;
	m_speed_y=speed_y;

} /* GObject::GObject */ 


bool GO_watersplash::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	m_state_cycle++;

	m_y+=m_speed_y;
	m_x+=m_speed_x;
	m_speed_x*=0.9f;
	m_speed_y*=0.9f;
//	if (m_speed_y<4) m_speed_y+=0.25;
//	if (m_speed<0.8f) m_speed+=0.025;

//	if (m_y>360) return false;
	if (m_state_cycle>25) return false;
	return true;
} /* GO_watersplash::cycle */ 


void GO_watersplash::draw(GLTManager *GLTM)
{
	bool tmp2;
	float f=(25-m_state_cycle)/50.0f;
	float f2=(10+m_state_cycle)/20.0f;

	tmp2=(glIsEnabled(GL_COLOR_MATERIAL) ? true:false);
	if (!tmp2) glEnable(GL_COLOR_MATERIAL);

	glColor4f(1.0f,1.0f,1.0f,f);
	glNormal3f(0.0,0.0,1.0);
	glPushMatrix();
	glTranslatef(m_x+2,m_y+2,0);
	glRotatef(float(m_state_cycle*8),0,0,1);
	glScalef(f2,f2,1);
	glBegin(GL_QUADS);
	{
		glVertex3f(-2,-2,0);
		glVertex3f(-2,2,0);
		glVertex3f(2,2,0);
		glVertex3f(2,-2,0);
	}
	glEnd();
	glPopMatrix();

	if (!tmp2) glDisable(GL_COLOR_MATERIAL);
} /* GO_watersplash::draw */ 


bool GO_watersplash::is_a(Symbol *c)
{
	if (c->cmp("GO_watersplash")) return true;

	return GObject::is_a(c);
} /* GO_watersplash::is_a */ 


bool GO_watersplash::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_watersplash::is_a */ 
