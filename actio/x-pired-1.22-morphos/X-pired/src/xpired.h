/*-------------------------------------------------------------------------*/
/*	Added by HAK																				*/
/*	so that the sources of xpired.c and xpiredit.c are a little bit more		*/
/*	conform																						*/
/*-------------------------------------------------------------------------*/
#ifndef _XPIRED_H_
#define _XPIRED_H_

#ifdef __MORPHOS__
	char *SHARE_DIR="Progdir:";
#else
#ifdef UNIX
	char *SHARE_DIR=SHARE_PREFIX;
#else
	char *SHARE_DIR=".";
#endif
#endif


// pridame konstanty...
#define MaxStrLenXLong 1024
#define MaxLevel 100
#define MaxLvlSize 20
#define MaxRecLength 5120
#define MaxSpr 256
#define MaxStrLenLong 256
#define MaxStrLenShort 51
#define MaxText 10

char GAME_HOME[MaxStrLenXLong];

Uint8	BPP=8;
char	FULLSCR=0;
Uint8	Shades=128;

SDL_Surface *screen,*swapscreen,*TitleS,*Sh=NULL,*PlayerV,*PlayerH,*Player[3][4][20],*SLevel,*SLives,*STime,*SNumbers;
char Sound=1,Quit=0,PAlive=20,Left=0,Right=0,Up=0,Down=0,Fire=0,Alt=0,Ctrl=0,Space=0,Setup=0,Passwd[11]="",BEM,Shift=0;


typedef struct T_Spr{
	SDL_Surface *img,*sha;
}T_Spr;

T_Spr Spr[MaxSpr];

typedef struct T_LElem{
	unsigned char	FSpr,FTyp,BSpr,BTyp;
	char				x,y,px,py,f,txt;
}T_LElem;	

typedef struct T_Lev{
	T_LElem			M[MaxLvlSize][MaxLvlSize];
	char				Name[MaxStrLenShort],BgFile[MaxStrLenLong],Pw[MaxStrLenShort];
	unsigned int	DL;
	SDL_Surface		*Bg;
	char				Text[MaxText][MaxStrLenShort];
}T_Lev;

T_Lev Lvl[MaxLevel];

typedef struct T_Txt{
	int x,y,a;
	char t[MaxStrLenShort];
}T_Txt;
T_Txt Text[MaxText];

T_Lev ALvl;

typedef struct T_RecKey{
	Uint32	Tick;
	unsigned char	Left:1;
	unsigned char	Right:1;
	unsigned char	Up:1;
	unsigned char	Down:1;
	unsigned char	Fire:1;
	unsigned char	Quit:3;
}T_RecKey;

T_RecKey Rec[MaxRecLength];

char ConfFName[MaxStrLenLong];



#endif // _XPIRED_H_
