#ifdef KITSCHY_DEBUG_MEMORY 
#include "debug_memorymanager.h"
#endif


#ifdef _WIN32
#include "windows.h"
#endif

#include "GL/gl.h"
#include "GL/glu.h"
#include "SDL.h"
#include "SDL_image.h"

#include "stdlib.h"
#include "string.h"
#include "List.h"

#include "auxiliar.h"
#include "2DCMC.h"
#include "Symbol.h"
#include "GLTile.h"

#include "GLTManager.h"


GLTManager::GLTManager()
{
	m_hash=new List<GLTManagerNode>[SYMBOL_HASH_SIZE];
	m_hash_smooth=new List<GLTManagerNode>[SYMBOL_HASH_SIZE];
} /* GLTManager::GLTManager */ 


GLTManager::~GLTManager()
{
	delete []m_hash;
	m_hash=0;
	delete []m_hash_smooth;
	m_hash_smooth=0;
} /* GLTManager::~GLTManager */ 


GLTile *GLTManager::get(char *name)
{
	Symbol *s=new Symbol(name);
	GLTile *t=get(s);
	delete s;
	return t;
} /* GLTManager::get */ 


GLTile *GLTManager::get(Symbol *name)
{
	GLTManagerNode *n;
	int h=name->hash_function();

	m_hash[h].Rewind();
	while(m_hash[h].Iterate(n)) {
		if (n->m_name->cmp(name)) return n->m_tile;
	} /* while */ 

	// load the tile:
	{
		char filename[256];
		GLTile *t;

		sprintf(filename,"graphics/%s.png",name->get());
		t=new GLTile(filename);	
		t->set_clamp();
		n=new GLTManagerNode();
		n->m_tile=t;
		n->m_name=new Symbol(name);
		m_hash[h].Add(n);

		// change the size of the graphics (so that 16x16 becomes 20x20:
		// this is a "THE GOONIES" only piece of code (remove if for other applications!)
		bool rescale=false;
		int dx=20,dy=20;
		int i,j;
		float si,sj;
		float fx=1.0f,fy=1.0f;
		Uint32 c;

		if (t->get_dx()==16 && t->get_dy()==16) {
			dx=20;
			dy=20;
			rescale=true;
		} // if 
		if (t->get_dx()==32 && t->get_dy()==16) {
			dx=40;
			dy=20;
			rescale=true;
		} // if 
		if (t->get_dx()==16 && t->get_dy()==32) {
			dx=20;
			dy=40;
			rescale=true;
		} // if 
		if (t->get_dx()==16 && t->get_dy()==64) {
			dx=20;
			dy=80;
			rescale=true;
		} // if 
		if (t->get_dx()==32 && t->get_dy()==32) {
			dx=40;
			dy=40;
			rescale=true;
		} // if 
		if (t->get_dx()==34 && t->get_dy()==32) {
			dx=42;
			dy=42;
			rescale=true;
		} // if 
		if (t->get_dx()==32 && t->get_dy()==48) {
			dx=40;
			dy=60;
			rescale=true;
		} // if 
		if (t->get_dx()==36 && t->get_dy()==48) {
			dx=45;
			dy=60;
			rescale=true;
		} // if 
		if (t->get_dx()==48 && t->get_dy()==48) {
			dx=60;
			dy=60;
			rescale=true;
		} // if 
		if (t->get_dx()==48 && t->get_dy()==64) {
			dx=60;
			dy=80;
			rescale=true;
		} // if 
		if (t->get_dx()==32 && t->get_dy()==64) {
			dx=40;
			dy=80;
			rescale=true;
		} // if 

		if (rescale) {
			SDL_Surface *s=SDL_CreateRGBSurface(SDL_SWSURFACE,dx,dy,32,RMASK,GMASK,BMASK,AMASK);
			fx=float(t->get_dx())/float(dx);
			fy=float(t->get_dy())/float(dy);
			for(i=0;i<dy;i++) {
				si=i*fx;
				for(j=0;j<dx;j++) {
					sj=j*fy;
					c=getpixel(t->get_tile(0),(int)sj,(int)si);
					putpixel(s,j,i,c);
				} // for 
			} // for 
			delete t;
			n->m_tile=t=new GLTile(s);
		} // if

		sprintf(filename,"graphics/%s.nfo",name->get());
		{
			FILE *fp;
			fp=fopen(filename,"r");
			if (fp!=0) {
				char tmp[80],tmp2[80];
				while(!feof(fp)) {
					fgets(tmp,80,fp);
					if (1==sscanf(tmp,"%s",tmp2)) {
						if (strcmp(tmp2,"hs")==0 ||
							strcmp(tmp2,"HS")==0) {
							int hx,hy;
							sscanf(tmp,"%s %i %i",tmp2,&hx,&hy);
							t->set_hotspot((int)((hx/fx)+0.5F),(int)((hy/fy)+0.5F));
						} // if 
						if (strcmp(tmp2,"bb")==0 ||
							strcmp(tmp2,"BB")==0) {
							int x1,y1,x2,y2;
							sscanf(tmp,"%s %i %i %i %i",tmp2,&x1,&y1,&x2,&y2);
							t->set_cmc((int)((x1/fx)+0.5F),(int)((y1/fy)+0.5F),(int)((x2/fx)+0.5F),(int)((y2/fy)+0.5F));
						} // if 
					} // if 
				} // while 
				fclose(fp);
			} // if 
		}

		return t;
	}
} /* GLTManager::get */ 



GLTile *GLTManager::get_smooth(char *name)
{
	Symbol *s=new Symbol(name);
	GLTile *t=get_smooth(s);
	delete s;
	return t;
} /* GLTManager::get_smooth */ 


GLTile *GLTManager::get_smooth(Symbol *name)
{
	GLTManagerNode *n;
	int h=name->hash_function();

	m_hash_smooth[h].Rewind();
	while(m_hash_smooth[h].Iterate(n)) {
		if (n->m_name->cmp(name)) return n->m_tile;
	} /* while */ 

	// load the tile:
	{
		char filename[256];
		GLTile *t;

		sprintf(filename,"graphics/%s.png",name->get());
		t=new GLTile(filename);
		t->set_smooth();
//		t->set_clamp();
		n=new GLTManagerNode();
		n->m_tile=t;
		n->m_name=new Symbol(name);
		m_hash_smooth[h].Add(n);
		return t;
	}
} /* GLTManager::get_smooth */ 
