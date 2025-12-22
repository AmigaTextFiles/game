#ifndef _THE_GOONIES_OBJECT_FLAME
#define _THE_GOONIES_OBJECT_FLAME

class GO_flame : public GO_enemy {
public:
	GO_flame(int x,int y,int sfx_volume);
	~GO_flame(void);

	virtual bool cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM);
	virtual void draw(GLTManager *GLTM);

	virtual int enemy_hit(void);

	virtual bool is_a(Symbol *c);
	virtual bool is_a(char *c);

	virtual void pause_continuous_sfx(void);
	virtual void stop_continuous_sfx(void);
	virtual void resume_continuous_sfx(void);

protected:
		int m_flame_channel;
};

#endif

