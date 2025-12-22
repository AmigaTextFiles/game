#ifndef __GONNIES_MAP
#define __GONNIES_MAP


class GMapTilePlace {
public:
	Symbol *m_tile_name;
	int m_x,m_y;
};


class GMapCMCPlace {
public:
	C2DCMC *m_cmc;
	int m_x,m_y;
};

class GObjectPlace {
public:
	Symbol *m_object_name;
	int m_x,m_y;
	List<int> m_parameters;
};



class GMapLayer {
	friend class GMap;
public:
	GMapLayer();
	GMapLayer(FILE *fp);
	~GMapLayer();

	void reset(int sfx_volume);
	void reset_first(int sfx_volume,GMap *m);
	void cycle(class VirtualController *v,GMap *m,int layer,GLTManager *GLTM,SFXManager *SFXM);
	void cycle_clock(class VirtualController *v,GMap *m,int layer,GLTManager *GLTM,SFXManager *SFXM);
	void draw(GLTManager *GLTM);

	void add_object(GObject *o);
	void add_auxiliar_object(GObject *o);
	bool remove_object(GObject *o);

	void add_tile(char *name,int x,int y);

	bool collision(GObject *o,GLTManager *GLTM);
	bool collision_with_background(GObject *o,GLTManager *GLTM);
	bool collision_with_background(GObject *o,int x_offs,int y_offs,GLTManager *GLTM);
	bool collision_with_background(GLTile *t,int x,int y,GLTManager *GLTM);
	bool collision_with_background_wo_bigrocks(GObject *o,int x_offs,int y_offs,GLTManager *GLTM);
	GObject *collision_with_object(GObject *o,GLTManager *GLTM);
	GObject *collision_with_object(GObject *o,GLTManager *GLTM,char *type);
	GObject *collision_with_object(GLTile *t,int x,int y,GLTManager *GLTM,char *type);

	GObject *get_object(char *type);

	void get_objects(List<GObject> *l,char *type);

	void pause_continuous_sfx(void);
	void stop_continuous_sfx(void);
	void resume_continuous_sfx(void);

private:
	// specification loaded from a file:
	List<GMapTilePlace> m_tiles;
	List<GObjectPlace> m_objects;

	// objects currently running:
	List<GObject> m_running_objects;
	List<GObject> m_auxiliar_objects;
};


class GMap {
	friend class TheGoonies;
public:
	GMap(FILE *fp);
	~GMap();

	void reset(int sfx_volume);
	void reset_first(int sfx_volume);
	void cycle(VirtualController *k,GLTManager *GLTM,SFXManager *SFXM);
	void cycle_clock(VirtualController *k,GLTManager *GLTM,SFXManager *SFXM);
	void draw(GLTManager *GLTM,bool water);
	void draw(int layer,GLTManager *GLTM);

	void search_for_bridges(GLTManager *GLTM);

	void add_object(GObject *o,int layer);
	void add_auxiliar_object(GObject *o,int layer);
	bool remove_object(GObject *o,int layer);

	int get_dx(void) {return m_dx;};
	int get_dy(void) {return m_dy;};
	int get_n_layers(void) {return m_layers.Length();};

	GMapLayer *get_layer(int n) {return m_layers[n];};

	bool collision(GObject *o,GLTManager *GLTM);
	bool collision_with_background(GObject *o,GLTManager *GLTM);
	bool collision_with_background(GObject *o,int x_offs,int y_offs,GLTManager *GLTM);
	bool collision_with_background(GLTile *t,int x,int y,GLTManager *GLTM);
	bool collision_with_background_wo_bridges(GObject *o,GLTManager *GLTM);	
	bool collision_with_background_wo_bridges(GObject *o,int x_offs,int y_offs,GLTManager *GLTM);
	GObject *collision_with_object(GObject *o,GLTManager *GLTM);
	GObject *collision_with_object(GObject *o,GLTManager *GLTM,char *type);
	GObject *collision_with_object(GLTile *t,int x,int y,GLTManager *GLTM,char *type);

	GObject *get_object(char *type);

	List<GObject> *get_objects(char *type);

	void pause_continuous_sfx(void);
	void stop_continuous_sfx(void);
	void resume_continuous_sfx(void);

	void get_water_info(void);
	GLuint get_water_info_texture(void);
	void clear_water_info(void);
	int get_water_level(void);
	int get_lava_level(void);

	void set_shake(void) {m_shake_timmer=50;};

private:
	int m_dx,m_dy;
	List<GMapLayer> m_layers;
	List<GMapCMCPlace> m_extra_collisions;

	class GooniesScript *m_script;

	bool m_searched_for_bridges;

	// Screen shake:
	int m_shake_timmer;

	// Info for the water effect:
	bool m_water_info_captured;
	int m_water_level,m_lava_level;
	GLuint m_water_info_texture;


};

#endif

