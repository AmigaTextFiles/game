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
#include "GMap.h"

#include "GO_wateropening.h"
#include "GO_fallingwater.h"

#include "sound.h"

GO_wateropening::GO_wateropening(int x,int y,int sfx_volume,int color) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_wateropening");

	m_color=color;

	// random waterfall sfx
	if (rand() % 2 == 0) {
		watersfx = "sfx/waterfall";
	} else {
		watersfx = "sfx/waterfall2";
	} // if
	m_water_channel=-1;
} /* GO_wateropening::GO_wateropening */ 

GO_wateropening::~GO_wateropening()
{
	stop_continuous_sfx();
} /* GO_wateropening::~GO_wateropening */ 


bool GO_wateropening::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	m_state_cycle++;

#ifdef __MORPHOS__
	// Decrease number of created "waterdrops" as this is too much strain for the machine
	if ((m_state_cycle>150) && ((m_state_cycle % 5) == 0)) {
#else
	if (m_state_cycle>150) {
#endif
		int i;

		if (m_water_channel==-1) m_water_channel=Sound_play_continuous(SFXM->get(watersfx),m_sfx_volume);
		for(i=0;i<2;i++) {
			int x1=0,x2=0;
			int dy=(rand()%8)*8;
			if (dy>m_state_cycle-150) dy=m_state_cycle-150;
			while(x1==x2) {
				x1=rand()%36;
				x2=rand()%36;
				if (x2<x1) {
					int tmp=x1;
					x1=x2;
					x2=tmp;
				} // if 
			} // while 
			if (x1>0) x1-=2;
			if (x2<7) x2+=2;
			GO_fallingwater *o=new GO_fallingwater((int)(m_x+8+x1),(int)(m_y+16),(x2-x1),8+dy,m_sfx_volume);
			o->set_map(map);
			map->add_object(o,4);
		} // for
	} else {
		if (map->get_object("GO_fallingwater")==0) {
			if (m_water_channel!=-1) {
				Mix_HaltChannel(m_water_channel);
				m_water_channel=-1;
			} // if 
		} // if 
	} // if 	
	if (m_state_cycle>300) m_state_cycle=rand()%10*5;
	return true;
} /* GO_wateropening::cycle */ 


void GO_wateropening::draw(GLTManager *GLTM)
{
	if (m_color==0) m_last_tile_used=GLTM->get("ob_water-opening");
	if (m_color==1) m_last_tile_used=GLTM->get("ob_water-opening-blue");
	if (m_color==2) m_last_tile_used=GLTM->get("ob_water-opening-green");
	if (m_color==3) m_last_tile_used=GLTM->get("ob_water-opening-yellow");

	m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_wateropening::draw */ 


bool GO_wateropening::is_a(Symbol *c)
{
	if (c->cmp("GO_wateropening")) return true;

	return GObject::is_a(c);
} /* GO_wateropening::is_a */ 


bool GO_wateropening::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_wateropening::is_a */ 


void GO_wateropening::stop_continuous_sfx(void)
{
	if (m_water_channel!=-1) {
		Mix_HaltChannel(m_water_channel);
		m_water_channel=-1;
	} // if 
} /* GO_wateropening::stop_continuous_sfx */ 


void GO_wateropening::pause_continuous_sfx(void)
{
	if (m_water_channel!=-1) {
		Mix_Pause(m_water_channel);
	} // if 
} /* GO_wateropening::pause_continuous_sfx */ 


void GO_wateropening::resume_continuous_sfx(void)
{
	if (m_water_channel!=-1) {
		Mix_Resume(m_water_channel);
	} // if 
} /* GO_wateropening::resume_continuous_sfx */ 

