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

#include "GO_lava.h"


GO_lava::GO_lava(int x,int y,int sfx_volume) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_lava");

} /* GObject::GObject */ 


bool GO_lava::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	m_state_cycle++;
	return true;
} /* GO_lava::cycle */ 


void GO_lava::draw(GLTManager *GLTM)
{
	bool tmp,tmp2;
	GLuint tname=m_map->get_water_info_texture();

	tmp2=(glIsEnabled(GL_COLOR_MATERIAL) ? true:false);
	if (!tmp2) glEnable(GL_COLOR_MATERIAL);

	glColor4f(1.0f,0.0f,0.0f,0.75f);
	glNormal3f(0.0,0.0,1.0);
	glBegin(GL_QUADS);
	{
		glVertex3f(m_x,m_y,0);
		glVertex3f(m_x,m_y+20,0);
		glVertex3f(m_x+20,m_y+20,0);
		glVertex3f(m_x+20,m_y,0);
	}
	glEnd();

	glColor4f(1.0f,0.3f,0.3f,0.25f);
	tmp=(glIsEnabled(GL_TEXTURE_2D) ? true:false);
	if (!tmp) glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D,tname);
	glBegin(GL_QUADS);
	{
		float fx=m_x/640.0f,fy=(400-(400-m_y)*3)/400.0f;
		float fdx=20/640.0f,fdy=20/133.33f;

		float fsx=float(sin(m_x+m_state_cycle*0.025)*0.01f);
		float fsx2=float(sin(m_x+20+m_state_cycle*0.025)*0.01f);
		float fsy=float(sin(m_x+m_state_cycle*0.0375)*0.005f);
		float fsy2=float(sin(m_x+20+m_state_cycle*0.0375)*0.005f);

		glTexCoord2f(fx+fsx,fy+fsy);
		glVertex3f(m_x,m_y,0);
		
		glTexCoord2f(fx+fsx,fy+fdy+fsy2);
		glVertex3f(m_x,m_y+20,0);

		glTexCoord2f(fx+fdx+fsx2,fy+fdy+fsy2);
		glVertex3f(m_x+20,m_y+20,0);

		glTexCoord2f(fx+fdx+fsx2,fy+fsy);
		glVertex3f(m_x+20,m_y,0);
	}
	glEnd();

	if (!tmp) glDisable(GL_TEXTURE_2D);
	if (!tmp2) glDisable(GL_COLOR_MATERIAL);
} /* GO_lava::draw */ 


bool GO_lava::is_a(Symbol *c)
{
	if (c->cmp("GO_lava")) return true;

	return GObject::is_a(c);
} /* GO_lava::is_a */ 


bool GO_lava::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_lava::is_a */ 
