# include <stdio.h>
# include <stdlib.h>
# include <string.h>

#ifndef NULL
#define NULL ((void*)0L)
#endif

#define TRUE  1
#define FALSE 0

/* Structs */
struct gameenemies {
	float x[7];
	float y[7];
	
	short int type[7];
	short int direction[7];
	short int tilex[7];
	short int tiley[7];
	short int animation[7];
	short int limleft[7];
	short int limright[7];
	short int speed[7];
	short int fire[7];
	short int adjustx1[7];
	short int adjustx2[7];
	short int adjusty1[7];
	short int adjusty2[7];
	short int padding;
};

struct gamehero {
	float x;
	float y;
	float height;		/* Limit of jump */
	float gravity;
	
	short int direction;
	short int jump;				/* 1-Up, 2-Down */
	short int animation;
	short int points[8];		/* Points of collision */
	short int ground;			/* Pixel where is ground */
	short int collision[4];		/* Collisions, in 4 directions */
	short int ducking;
	short int checkpoint[4];
	short int lifes,crosses;	/* Vidas y cruces */
	short int flags[7];
	short int death;
	short int push[4];			/* Pulsaciones de teclas */
	short int temp;
};

struct gamejoystick{
char up,down,left,right,up2,down2,left2,right2,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,num,pad,pad2,pad3;
};

struct gamemap{
	short int stagedata[25][22][32];
	short int enemydata[25][ 7][15];
};	

struct game{
	struct gamemap  map;
	struct gamehero jean;
	struct gameenemies enemies;
	
	float proyec[24]; 				/* Enemiess shoots */

	short int coordx,coordy;				/* Coord X and Y */

	unsigned short int flag;
	unsigned short int chapter; 			/* 0-intro,1-history,2-game */
	unsigned short int grapset; 			/* 0-8bits, 1-16bits */
	unsigned short int fullscreen; 		/* 0-Windowed,1-Fullscreen */
	unsigned short int room,prevroom; 	/* Room, previous room */
	unsigned short int screenchange;		/* Screen change */
	unsigned short int counter[3];		/* Counters */
	unsigned short int key;
	unsigned short int keypressed;
	unsigned short int parchment;
	unsigned short int trainer;
/* not saved part */	
	struct gamejoystick joystick;
	void* screen;
	void* renderer;	
	void* tiles;	
	void* fonts;	

	void* bso[8];		/* Sounds */
	void* fx[7];		/* Sounds */
};

typedef struct _AB_Rect
{
	short int x,y,w,h;
}AB_Rect;

void drawscreen (struct game *G);
void statusbar (struct game *G);
void drawrope (struct game *G);
void drawshoots (struct game *G);
void showparchment (struct game *G);
void redparchment (struct game *G);
void blueparchment (struct game *G);

void ending (struct game *G);

void searchenemies (struct game *G);
void drawenemies (struct game *G);
void movenemies (struct game *G);
void plants (struct game *G);
void crusaders (struct game *G);
void death (struct game *G);
void dragon (struct game *G);
void satan (struct game *G);
void fireball (struct game *G);

void game(struct game *G);
void animation (struct game *G);
void counters (struct game *G);
void control (struct game *G);
void events (struct game *G);
void music (struct game *G);
void changescreen (struct game *G);
void keybpause (struct game *G);

void gameover (struct game *G);

void history(struct game *G);

void movejean (struct game *G);
void drawjean (struct game *G);
void collisions (struct game *G);
void touchobj (struct game *G);
void contact (struct game *G);

void loaddata(struct game *G);
void loadingmusic(struct game *G);

void startscreen(struct game *G);

/* OS dependant functions */
void  AB_Clear(struct game *G);			
void  AB_CloseGame(struct game *G);			
void  AB_DestroyTexture(struct game *G,void* tex);			
void  AB_DrawSprite(struct game *G,void* tex,AB_Rect *src,AB_Rect *dst);			
void  AB_Drawtexture(struct game *G,char *filename);			
void  AB_Events(struct game *G);			
void  AB_FreeMusic(struct game *G,void* mus);			
void  AB_FreeSound(struct game *G,void* fx);			
void  AB_HaltMusic(struct game *G);			
int   AB_InitGame(struct game *G,int w,int h,char *name);
void  AB_NewMusicN(struct game *G,int n,int loops);			
void  AB_PauseMusic(struct game *G);			
void  AB_PlayMusic(struct game *G,void* mus,int loops);			
void  AB_PlaySound(struct game *G,void* fx,int loops);			
void  AB_PlaySoundN(struct game *G,int n,int loops);			
void  AB_ResumeMusic(struct game *G);			
void  AB_Update(struct game *G);			
void* AB_LoadMusic(struct game *G,char *filename);			
void* AB_LoadSound(struct game *G,char *filename);			
void* AB_LoadTexture(struct game *G,char *filename);			




