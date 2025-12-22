#ifndef _THE_GOONIES_OBJECT_WATEROPENING
#define _THE_GOONIES_OBJECT_WATEROPENING

class GO_wateropening : public GObject {
public:
	GO_wateropening(int x,int y,int sfx_volume,int color);
	~GO_wateropening();
	
	virtual bool cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM);
	virtual void draw(GLTManager *GLTM);

	virtual bool is_a(Symbol *c);
	virtual bool is_a(char *c);

	virtual void pause_continuous_sfx(void);
	virtual void stop_continuous_sfx(void);
	virtual void resume_continuous_sfx(void);


protected:

	int m_color;
	char *watersfx;
	int m_water_channel;
};

#endif

