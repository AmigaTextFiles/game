#ifndef MYLIB_H
#define MYLIB_H

#define	SCREEN_WIDTH	480
#define	SCREEN_HEIGHT	272
#define	SCREEN_PITCH	512

extern unsigned short *vramtop;

void g_init(void);
void g_flip(void);

unsigned short* g_vramaddr(int x,int y);
int g_getpad(void);
int g_gettick(void);


#endif
