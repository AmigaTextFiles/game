#define abs(x) ((x)<0?-(x):(x))
#define sign(x) ((x)<0?-(1):(1))

#define LAST 2

#define LEFT 1
#define RIGHT 2

#define L   0x31
#define Lup 0xb1
#define R   0x32
#define Rup 0xb2

#define T   0x38
#define Tup 0xb8

#define F   0x39
#define P   0x3a

#define SPACE 0x40
#define ESC 0x45
#define RET 0x44

#define M   0x37


#define F1 0x50
#define F2 0x51
#define F3 0x52
#define F4 0x53
#define F5 0x54
#define F6 0x55
#define F7 0x56
#define F8 0x57
#define F9 0x58
#define F10 0x59

#define SEEKING 0
#define DIRECT 1
#define BARRAGE 2

typedef struct imagelocation
{
 UWORD player,player2;
 UWORD photon;
 UWORD explosion;
 UWORD shield;
 UWORD asteroid[3];
 UWORD box,line,diamond,mine;
 UWORD asaucer,saucer;
 UWORD battleship;
 UWORD elight;
 UWORD eheavy;
 UWORD xcruiser;
 UWORD fighter;
 UWORD triangle;
 UWORD debris;
 UWORD minelayer;
 UWORD dreadnought;
 UWORD magnetic;
 UWORD expander;
 UWORD displacer;
 UWORD sauphot;
 UWORD dreadshield;
 UWORD rectangle;
 UWORD carrier;
 UWORD hold2;
 UWORD hold3;
 UWORD hold4;
};

	
typedef struct gameinput
{
 BOOL LT[3],RT[3];
 BOOL FI[3],FIUP[3],HY[3];
 BOOL TH[3],THUP[3];
 BOOL PAUSE,EXIT,KEY,NEXT;
};


typedef struct gameinfo
{
 WORD he,wi,de;
 WORD x1,y1;
 WORD x2,y2;
 WORD dx,dy;
 WORD processor;
 WORD largefontheight;
 WORD mediumfontheight;
 WORD smallfontheight;
ULONG screentype;
};

typedef struct shotI
{
 BOOL flight;
 WORD vx,vy;
 WORD xp,yp;
 WORD dx,dy;
 WORD oxp,oyp;
 WORD opos;
 WORD pos;
 WORD len;
 WORD range;
};

typedef struct photI
{
 BOOL flight;
 WORD vx,vy;
 WORD xp,yp;
 WORD oxp,oyp;
 BYTE pos,rot;
 WORD range;
 BYTE turn;
 WORD delay;
 BYTE type;
 BYTE wrap;
 WORD image;
};

typedef struct highscorelist
{
 UBYTE name[30];
 LONG score,level;
};


#define HUMAN 0
#define COMPUTER 1
#define DESTROYED 2


typedef struct box
{
WORD x,y;
WORD ox,oy;
WORD pos;
WORD length;
WORD type;
WORD image;
BYTE rots;
};

typedef struct explosion
{
WORD x,y;
BYTE frame,length;
BOOL flag;
};

typedef struct asteroid
{
 WORD x,y;
 WORD ox,oy;
 WORD vx,vy;
 BYTE rot,dir;
 WORD size;
 WORD flag;
};

typedef struct saucer
{
WORD x,y;
WORD ox,oy;
WORD vx,vy;
WORD flag;
BYTE rot;
BYTE delay;
BYTE fnum;
BYTE type;
BOOL haltfire;
UBYTE image;
struct photI photI[20];
};

typedef struct fighter
{
 WORD x,y,pos;
 WORD ox,oy;
 WORD vmax;
 BYTE aim;
 WORD ax,ay;
 WORD flight;
 WORD x1,y1,x2,y2;
 WORD ox1,oy1,ox2,oy2;
 WORD delay,fdelay;
 BOOL fire;
};


typedef struct hyper
{
 WORD x,y;
 WORD ox,oy;
 WORD destx,desty;
 WORD vx,vy;
 BYTE rot;
 BOOL flag;
 WORD image;
};


typedef struct debris
{
 WORD x,y;
 WORD ox,oy;
 WORD pos,vmax;
 WORD length,vdelay;
 BYTE rot;
 WORD image;
 WORD delay;
};

typedef struct mine
{
 WORD x,y;
 WORD ox,oy;
 BYTE rot;
 WORD mdelay;
 WORD type;
 WORD flight;
 WORD x1,y1,x2,y2;
 WORD ox1,oy1,ox2,oy2;
 WORD delay,fdelay;
 BOOL fire;
};


typedef struct battleship
{
 WORD x,y,pos;
 WORD ox,oy;
 WORD fx,fy;
 WORD vx,vy;
 WORD vmax,turn;
 WORD man;
 WORD shield;
 WORD fnum,fvmax,fdam;
 WORD ftype;
 WORD pnum,pvmax,pdam,pman,prange,pdelay;
 BYTE flight;
 WORD dnum;
 WORD x1[10],y1[10],x2[10],y2[10];
 WORD ox1[10],oy1[10],ox2[10],oy2[10];
 WORD fdelay[10];
 struct shotI shotI[40];

 BOOL lbox,rbox,line;
 BYTE lrot,rrot,lirot;
 LONG image;
};

typedef struct ship
{
 WORD x,y,pos;
 WORD modx,mody;
 WORD ox,oy;
 WORD vx,vy;
 WORD shield;
 WORD shieldstart;
 WORD vmax,turn;
 WORD man;
 WORD fnum,fvmax,fdam,flen,ftype,fdelay,frate;
 WORD pnum,pvmax,pdam,pman,prange,pdelay,pimage,prate;
 WORD blast;
 BYTE aim;
 LONG wait;
 WORD pilot;
 LONG shieldstat;
 LONG pointvalue;
 struct shotI shotI[40];
 struct photI photI[40];
 LONG image;
 LONG shIno;
 WORD exhlx[20],exhly[20];		/* thrust coordinates */
 WORD exhrx[20],exhry[20];		/* thrust coordinates */
 WORD exhd[20];
};


typedef struct control
{
 BYTE ship[10];
 BYTE boxnum;
 BYTE playernum;
 BYTE enemynum;
 BYTE maxenemynum;
 BYTE maxplayernum;
 BYTE availenemyships;
 WORD asteroidnum;
 BYTE explosionnum;
 BYTE hypernum;
 BYTE battleshipnum;
 BYTE thrustlength;
 BYTE player[2];
 LONG score[2];
 LONG lives[2];
 LONG wait[2];
 LONG input[2];
 LONG fire[2];
 LONG tech[2];
 LONG shield[2];
 LONG weapon[2];
 LONG hyper[2];
 LONG firecount[2];
 LONG firedelay[2];
 BYTE level;
 BYTE enemyonscreen;
 BOOL endgame;
 LONG endgamewait;
 WORD asize;
 LONG delay;
 BYTE playmode;
 UBYTE ftrnum;
 BOOL fighter;
 UBYTE minenum;
 UBYTE debrisnum;
 BOOL mines;
 BYTE game;
 BYTE pause;
 BYTE startlevel;
 BYTE difficulty;
 BYTE standarddebris;
 BOOL audio;
 BOOL firewrap;
 BOOL autofire;
 BYTE screentype;
 BYTE fontsize;
 WORD dlpos;
};

typedef struct saveoptions
{
BYTE input[2];
BYTE enemyonscreen;
UBYTE ftrnum;
LONG delay;
BYTE playmode;
BYTE game;
BYTE startlevel;
BYTE difficulty;
BYTE firewrap;
BYTE autofire;
BYTE playernum;
BYTE standarddebris;
BYTE screentype;
BYTE fontsize;
};

typedef struct keys
{ 
 WORD left,right;
 WORD fire,thrust;
 WORD hyperspace;
 WORD pause;
};

typedef struct imagedata
{
 WORD xc,yc;
 WORD wi,he,wo;
 ULONG length;
 BYTE color;
 UWORD mask;
 UWORD *data;
};

typedef struct vectordata
{
 WORD zero;
 WORD x[30],y[30],num;
 WORD pos,rots;
 UWORD mask;
 BYTE color;
};

typedef struct drawlist
{
 WORD x,y;
 WORD pic;
 BYTE color;
 UWORD mask;
};
