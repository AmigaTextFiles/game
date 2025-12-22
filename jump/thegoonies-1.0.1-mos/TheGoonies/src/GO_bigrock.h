#ifndef _THE_GOONIES_OBJECT_BIGROCK
#define _THE_GOONIES_OBJECT_BIGROCK

class GO_bigrock : public GObject {
public:
	GO_bigrock(int x,int y,int sfx_volume,int color);
	virtual ~GO_bigrock();

	virtual bool cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM);
	virtual void draw(GLTManager *GLTM);

	virtual bool is_a(Symbol *c);
	virtual bool is_a(char *c);

	virtual void pause_continuous_sfx(void);
	virtual void stop_continuous_sfx(void);
	virtual void resume_continuous_sfx(void);

protected:
	
	int m_color;

	int m_n_fall;			// counts how many times the rock has fallen
	int m_top_y,m_middle_y;
	int m_original_y;
	int m_chain_channel;
};

#endif

