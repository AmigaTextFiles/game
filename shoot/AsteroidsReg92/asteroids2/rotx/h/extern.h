extern struct ship ship[7];
extern struct asteroid a[256];
extern struct saucer saucer;
extern struct RastPort *rp1[2],*rp2[2];
extern struct control control;
extern struct gameinfo gi;
extern struct gameinput in;
extern struct fighter f[200];
extern struct box b[40];
extern struct battleship bs[5];
extern struct mine m[40];
extern struct highscorelist hsl[20];
extern struct saveoptions so;
extern struct explosion e[32];
extern struct debris d[100];
extern struct hyper h[100];
extern struct keys k;

extern struct imagelocation il;
extern struct imagedata id[800];
extern struct drawlist dl[400];

extern BYTE VxINC[32];
extern BYTE VyINC[32];

extern UBYTE bit;

extern struct TextFont *basicfont,*fixplain7font,*hiresfont;
extern struct TextFont *lfont,*mfont,*sfont;

extern struct RastPort *rp1[2];
extern struct Screen *screen;
extern struct View *view[2];
extern struct RastPort *mwrp;
extern struct Window *masterwindow;
