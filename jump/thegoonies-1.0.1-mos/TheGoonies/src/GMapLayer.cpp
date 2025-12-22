#ifdef KITSCHY_DEBUG_MEMORY 
#include "debug_memorymanager.h"
#endif

#ifdef _WIN32
#include <windows.h>
#endif

#include "stdio.h"
#include "string.h"
#include "stdlib.h"

#include "GL/gl.h"
#include "GL/glu.h"
#include "SDL.h"
#include "SDL_image.h"
#include "SDL_mixer.h"

#include "List.h"
#include "Symbol.h"
#include "keyboardstate.h"
#include "auxiliar.h"
#include "2DCMC.h"
#include "GLTile.h"
#include "GLTManager.h"
#include "SFXManager.h"
#include "VirtualController.h"

#include "GObject.h"
#include "GMap.h"
#include "GO_water.h"

#include "GObjectCreator.h"

#include "debug.h"


GMapLayer::GMapLayer()
{
} /*  GMapLayer::GMapLayer */ 


GMapLayer::GMapLayer(FILE *fp)
{
	int i,j;
	int nt,no,np,i_tmp,x,y;
	char tmp[256];
	GMapTilePlace *tp;
	GObjectPlace *op;
	float scale=20.0f/16.0f;

	fscanf(fp,"%i",&nt);
	for(i=0;i<nt;i++) {
		tp=new GMapTilePlace();
		fscanf(fp,"%i %i %s",&x,&y,tmp);
		tp->m_x=(int)(x*scale);
		tp->m_y=(int)(y*scale);
		tp->m_tile_name=new Symbol(tmp);
		m_tiles.Add(tp);
	} // for 

	fscanf(fp,"%i",&no);
	for(i=0;i<no;i++) {
		op=new GObjectPlace();
		fscanf(fp,"%i %i %s",&x,&y,tmp);
		op->m_x=(int)(x*scale);
		op->m_y=(int)(y*scale);
		op->m_object_name=new Symbol(tmp);
		fscanf(fp,"%i",&np);
		for(j=0;j<np;j++) {
			fscanf(fp,"%i",&i_tmp);
			op->m_parameters.Add(new int(i_tmp));
		} /* for */ 
		m_objects.Add(op);
	} // for 
} /* GMapLayer::GMapLayer */ 


GMapLayer::~GMapLayer()
{	
} /*  GMapLayer::~GMapLayer */ 


void GMapLayer::reset_first(int sfx_volume,GMap *map)
{
	GObject *o;
	GObjectPlace *po;

	m_running_objects.Delete();

	m_objects.Rewind();
	while(m_objects.Iterate(po)) {
		o=GObject_create(po->m_object_name,po->m_x,po->m_y,sfx_volume,&(po->m_parameters));
		m_running_objects.Add(o);

		// Water tiles need a pointer to the map to retrieve some data required for rendering water:
		if (o->is_a("GO_water") ||
			o->is_a("GO_lava")) {
			GO_water *ow=(GO_water *)o;
			ow->set_map(map);			
		} // if 
		
	} // while

} /* GMapLayer::reset_first */ 


void GMapLayer::reset(int sfx_volume)
{
	GObject *o;
	GObjectPlace *po;

	{
		List<GObject> to_delete;
		m_running_objects.Rewind();
		while(m_running_objects.Iterate(o)) {
			if (o->is_a("GO_enemy") && !o->is_a("GO_fratelli")) to_delete.Add(o);
		} // while 
		while(!to_delete.EmptyP()) {
			o=to_delete.ExtractIni();
			m_running_objects.DeleteElement(o);
			delete o;
		} // while 
	}

	m_objects.Rewind();
	while(m_objects.Iterate(po)) {
		o=GObject_create(po->m_object_name,po->m_x,po->m_y,sfx_volume,&(po->m_parameters));
		if (o->is_a("GO_enemy")) {
			m_running_objects.Add(o);
		} else {
			delete o;
		} // if 
	} // while 

} /* GMapLayer::reset */ 


void GMapLayer::cycle(VirtualController *v,GMap *m,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	List<GObject> to_delete;
	GObject *o;

//	output_debug_message("layer %i\n",layer);

	m_running_objects.Rewind();
	while(m_running_objects.Iterate(o)) {
		if (!o->cycle(v,m,layer,GLTM,SFXM)) to_delete.Add(o);
	} // while 

	while(!to_delete.EmptyP()) {
		o=to_delete.ExtractIni();
		m_running_objects.DeleteElement(o);
		delete o;
	} // while 

	m_auxiliar_objects.Rewind();
	while(m_auxiliar_objects.Iterate(o)) {
		if (!o->cycle(v,m,layer,GLTM,SFXM)) to_delete.Add(o);
	} // while 

	while(!to_delete.EmptyP()) {
		o=to_delete.ExtractIni();
		m_auxiliar_objects.DeleteElement(o);
		delete o;
	} // while 
} /* GMapLayer::cycle */ 


void GMapLayer::cycle_clock(VirtualController *v,GMap *m,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	List<GObject> to_delete;
	GObject *o;

//	output_debug_message("layer %i\n",layer);

	m_running_objects.Rewind();
	while(m_running_objects.Iterate(o)) {
		if (o->is_a("GO_character") ||
			o->is_a("GO_item") ||
			o->is_a("GO_key") ||
			o->is_a("GO_cagedoor") ||
			o->is_a("GO_entrydoor") ||
			o->is_a("GO_exitdoor")) {
			if (!o->cycle(v,m,layer,GLTM,SFXM)) to_delete.Add(o);
		} // if
	} // while 

	while(!to_delete.EmptyP()) {
		o=to_delete.ExtractIni();
		m_running_objects.DeleteElement(o);
		delete o;
	} // while 

	m_auxiliar_objects.Rewind();
	while(m_auxiliar_objects.Iterate(o)) {
		if (o->is_a("GO_character") ||
			o->is_a("GO_item") ||
			o->is_a("GO_key") ||
			o->is_a("GO_cagedoor") ||
			o->is_a("GO_entrydoor") ||
			o->is_a("GO_exitdoor")) {
			if (!o->cycle(v,m,layer,GLTM,SFXM)) to_delete.Add(o);
		} // if
	} // while 

	while(!to_delete.EmptyP()) {
		o=to_delete.ExtractIni();
		m_auxiliar_objects.DeleteElement(o);
		delete o;
	} // while 
} /* GMapLayer::cycle_clock */ 


void GMapLayer::draw(GLTManager *GLTM)
{
	GMapTilePlace *tp;
	GObject *o;

	m_tiles.Rewind();
	while(m_tiles.Iterate(tp)) {
		GLTM->get(tp->m_tile_name)->draw(float(tp->m_x),float(tp->m_y),0,0,1);
	} /* while */ 

	m_running_objects.Rewind();
	while(m_running_objects.Iterate(o)) o->draw(GLTM);
	
	m_auxiliar_objects.Rewind();
	while(m_auxiliar_objects.Iterate(o)) o->draw(GLTM);
} /* GMapLayer::draw */ 


void GMapLayer::add_object(GObject *o)
{
	if (!m_running_objects.MemberRefP(o)) m_running_objects.Add(o);
} /* GMapLayer::add_object */ 


void GMapLayer::add_auxiliar_object(GObject *o)
{
	if (!m_auxiliar_objects.MemberRefP(o)) m_auxiliar_objects.Add(o);
} /* GMapLayer::add_object */ 


bool GMapLayer::remove_object(GObject *o)
{
	return m_running_objects.DeleteElement(o);
} /* GMapLayer::remove_object */ 


void GMapLayer::add_tile(char *name,int x,int y)
{
	GMapTilePlace *t;

	t=new GMapTilePlace();
	t->m_tile_name=new Symbol(name);
	t->m_x=x;
	t->m_y=y;
	
	m_tiles.Add(t);
} /* GMapLayer::add_tile */ 


bool GMapLayer::collision(GObject *o2,GLTManager *GLTM)
{
	GMapTilePlace *tp;
	GObject *o;
	List<GObject> l;

	m_tiles.Rewind();
	while(m_tiles.Iterate(tp)) {
		if (o2->collision(GLTM->get(tp->m_tile_name),tp->m_x,tp->m_y)) return true;
	} /* while */ 

	l.Instance(m_running_objects);
	l.Rewind();
	while(l.Iterate(o)) if (o!=o2 &&  o2->collision(o)) return true;

	return false;
} /* GMapLayer::collision */ 


bool GMapLayer::collision_with_background(GObject *o2,GLTManager *GLTM)
{
	GMapTilePlace *tp;
	GObject *o;
	List<GObject> l;

	m_tiles.Rewind();
	while(m_tiles.Iterate(tp)) {
		if (o2->collision(GLTM->get(tp->m_tile_name),tp->m_x,tp->m_y)) return true;
	} // while 

	// The big rock is part of the background:
	l.Instance(m_running_objects);
	l.Rewind();
	while(l.Iterate(o)) if (o->is_a("GO_bigrock") && o!=o2 && o2->collision(o)) return true;

	return false;
} /* GMapLayer::collision_with_background */ 


bool GMapLayer::collision_with_background(GObject *o2,int x_offs,int y_offs,GLTManager *GLTM)
{
	GMapTilePlace *tp;
	GObject *o;
	List<GObject> l;

	m_tiles.Rewind();
	while(m_tiles.Iterate(tp)) {
		if (o2->collision(x_offs,y_offs,GLTM->get(tp->m_tile_name),tp->m_x,tp->m_y)) return true;
	} /* while */ 

	// the big rock is part of the background:
	o2->set_x(o2->get_x()+x_offs);
	o2->set_y(o2->get_y()+y_offs);
	l.Instance(m_running_objects);
	l.Rewind();
	while(l.Iterate(o)) 
		if (o->is_a("GO_bigrock") && o!=o2 && o2->collision(o)) {
			o2->set_x(o2->get_x()-x_offs);
			o2->set_y(o2->get_y()-y_offs);
			return true;
		} // if 

	o2->set_x(o2->get_x()-x_offs);
	o2->set_y(o2->get_y()-y_offs);

	return false;
} /* GMapLayer::collision_with_background */ 


bool GMapLayer::collision_with_background(GLTile *t,int x,int y,GLTManager *GLTM)
{
	GMapTilePlace *tp;

	m_tiles.Rewind();
	while(m_tiles.Iterate(tp)) {
		if (t->get_cmc()->collision(float(x),float(y),0,GLTM->get(tp->m_tile_name)->get_cmc(),float(tp->m_x),float(tp->m_y),0)) return true;
	} /* while */ 

	return false;
} /* GMapLayer::collision_with_background */ 


bool GMapLayer::collision_with_background_wo_bigrocks(GObject *o2,int x_offs,int y_offs,GLTManager *GLTM)
{
	GMapTilePlace *tp;
	List<GObject> l;

	m_tiles.Rewind();
	while(m_tiles.Iterate(tp)) {
		if (o2->collision(x_offs,y_offs,GLTM->get(tp->m_tile_name),tp->m_x,tp->m_y)) return true;
	} /* while */ 

	return false;
} /* GMapLayer::collision_with_background */ 


GObject *GMapLayer::collision_with_object(GObject *o2,GLTManager *GLTM)
{
	GObject *o;
	List<GObject> l;

	l.Instance(m_running_objects);
	l.Rewind();
	while(l.Iterate(o)) if (o->collision(o2)) return o;

	return 0;
} /* GMapLayer::collision_with_object */ 


GObject *GMapLayer::collision_with_object(GObject *o2,GLTManager *GLTM,char *type)
{
	GObject *o;
	List<GObject> l;

	l.Instance(m_running_objects);
	l.Rewind();
	while(l.Iterate(o)) if (o!=o2 && o->is_a(type) && o->collision(o2)) return o;

	return 0;
} /* GMapLayer::collision_with_object */ 


GObject *GMapLayer::collision_with_object(GLTile *t,int x,int y,GLTManager *GLTM,char *type)
{
	GObject *o;
	List<GObject> l;

	l.Instance(m_running_objects);
	l.Rewind();
	while(l.Iterate(o)) 
		if (o->is_a(type) && o->collision(0,0,t,x,y)) return o;

	return 0;
} /* GMapLayer::collision_with_object */ 


GObject *GMapLayer::get_object(char *type)
{
	GObject *o;
	List<GObject> l;

	l.Instance(m_running_objects);
	l.Rewind();
	while(l.Iterate(o)) if (o->is_a(type)) return o;

	return 0;
} /* GMapLayer::get_object */ 


void GMapLayer::get_objects(List<GObject> *res,char *type)
{
	GObject *o;
	List<GObject> l;

	l.Instance(m_running_objects);
	l.Rewind();
	while(l.Iterate(o)) if (o->is_a(type)) res->Add(o);
} /* GMapLayer::get_objects */ 


void GMapLayer::pause_continuous_sfx(void)
{
	GObject *o;

	m_running_objects.Rewind();
	while(m_running_objects.Iterate(o)) o->pause_continuous_sfx();
} /* GMapLayer::pause_continuous_sfx */ 


void GMapLayer::stop_continuous_sfx(void)
{
	GObject *o;

	m_running_objects.Rewind();
	while(m_running_objects.Iterate(o)) o->stop_continuous_sfx();
} /* GMapLayer::stop_continuous_sfx */ 


void GMapLayer::resume_continuous_sfx(void)
{
	GObject *o;

	m_running_objects.Rewind();
	while(m_running_objects.Iterate(o)) o->resume_continuous_sfx();
} /* GMapLayer::resume_continuous_sfx */ 
