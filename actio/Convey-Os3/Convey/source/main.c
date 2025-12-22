#include <SDL.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>


#include <SDL_Mixer.h>
static int soundv = 2;

Mix_Chunk *blob_sound;
Mix_Chunk *jump_sound;
Mix_Chunk *died_sound;
Mix_Chunk *move_sound;


#define DATA_PREFIX ""

/* bits */
SDL_Surface *screen;

SDL_Surface *bletters;
SDL_Surface *letters[100];
SDL_Surface *tiles[9];
SDL_Surface *btiles;
SDL_Surface *blob;
SDL_Surface *jblob;
SDL_Surface *bb;
SDL_Surface *fh;
SDL_Surface *bh;
SDL_Surface *bb2;
SDL_Surface *levelbm;
SDL_Surface *comp;
SDL_Surface *ps;
SDL_Surface *go;
SDL_Surface *ll;
SDL_Surface *conveybm;






SDL_MouseMotionEvent mmevent;

int mousex,mousey;

Uint32 sec, cents;

FILE *file_ptr;


int bpointx,bpointy,pointx,pointy,jug,death,goose,jump,jumpf,blibs,spr[1000][8],leveldone,level,lives,totallevels,blobx[7],bloby[7],blobp[7],score,bak,bok,buk,bik,start,blibo,blibs,die,jumpoo=12,speed=4,arse,highscore;
/* Keys */
int quit = 0;
int spacebar = 0;
int b_pressed = 0;
int left_down = 0, right_down = 0, jump_down = 0, s_down = 0;



void imageplot(SDL_Surface *image, int x, int y)
{
	SDL_Rect pos;
	pos.x = x;
	pos.y = y;
	SDL_BlitSurface(image, NULL, screen, &pos);
}

int playsound(soundnum)
{
  #ifdef ENABLE_SOUND
  if (soundv>0)
  {
    if (soundnum==1) Mix_PlayChannel(1,died_sound,0);
    if (soundnum==2) Mix_PlayChannel(2,blob_sound,0);
    if (soundnum==3) Mix_PlayChannel(3,jump_sound,0);
    if (soundnum==4) Mix_PlayChannel(4,move_sound,0);
  }
  #endif
  return 1;
}

static void volume(void)
{
  #ifdef ENABLE_SOUND
  if (soundv==1)
  {
    Mix_VolumeChunk(blob_sound, MIX_MAX_VOLUME/3);
    Mix_VolumeChunk(move_sound, MIX_MAX_VOLUME/2);
    Mix_VolumeChunk(jump_sound, MIX_MAX_VOLUME/3);
    Mix_VolumeChunk(died_sound, MIX_MAX_VOLUME/3);
  }
  if (soundv==2)
  {
    Mix_VolumeChunk(blob_sound, MIX_MAX_VOLUME-40);
    Mix_VolumeChunk(move_sound, MIX_MAX_VOLUME-10);
    Mix_VolumeChunk(jump_sound, MIX_MAX_VOLUME-40);
    Mix_VolumeChunk(died_sound, MIX_MAX_VOLUME-40);

  }
  #endif
}






static void init(void)
{
  char path[256];
  int i;
  bpointx=200;bpointy=400;pointx=200;pointy=400;jug=1;death=0;score=0;
  blobx[1]=264;bloby[1]=323;
  for ( i=2 ; i<8 ; i++ ) { blobx[i]=blobx[i-1]-16 ; bloby[i]=bloby[i-1]-8;}
  blobx[0]=blobx[1]+16;bloby[0]=bloby[1]+8;
  level=1;leveldone=3;start=0;

/* load dat stuff */
   strcpy(path, DATA_PREFIX);
   strcat(path, "levels/info");
 file_ptr = fopen(path,"r") ;
 /* this tells us how many levels there are avaliable */
 bak = fgetc( file_ptr ) ;
 bak = bak-48;
 bak = bak*100;
 bok = fgetc( file_ptr ) ;
 bok = bok-48;
 bok = bok*10;
 buk = fgetc( file_ptr ) ;
 buk = buk-48;
 totallevels = bak+bok+buk+1;
 fclose(file_ptr);
}

static void getlevel(void)
{
  char path[256],jib[50];
  int lvspx,lvspy;
  bpointx=200;bpointy=400;pointx=200;pointy=400;jug=1;death=0;jump=0;jumpf=0;jug=0;blibs=0;blibo=0;die=0;speed=4;
  strcpy(path, DATA_PREFIX);
  sprintf(jib,"levels/level%d",level);
  strcat(path, jib);
  file_ptr = fopen(path,"r") ;
  /* load info on how much more we have to load */
  bak = fgetc( file_ptr ) ;
  bak = bak-48;
  bak = bak*100;
  bok = fgetc( file_ptr ) ;
  bok = bok-48;
  bok = bok*10;
  buk = fgetc( file_ptr ) ;
  buk = buk-48;
  arse = bak+bok+buk+1;
  /* load the actual level data */
  bik = fgetc( file_ptr ) ;
  for ( lvspx=1 ; lvspx < arse+1 ; lvspx++ )
  {
    for ( lvspy=1 ; lvspy < 7 ; lvspy++ )
    {
      bik = fgetc( file_ptr ) ;
      bik = bik-48;
      spr[lvspx][lvspy] = bik ;
      if ( bik==3 ) { blibs+=1; }
    }
    bik = fgetc( file_ptr ) ;
  }
  fclose(file_ptr);
}

static void blobc(void)
{

  if ( jump==0 )
  {
    if (left_down==1 && right_down==0) { goose+=1 ; }
    if (left_down==0 && right_down==1) { goose-=1 ; }
    if (jumpf==0 && jump_down==1 && jumpoo>0 ) { jump=1 ; jumpf=1 ; }
  }

  if ( goose==7 ) { goose=6 ; }

  if ( goose==0 ) { goose=1 ; }

  if ( goose<7 && goose>0 )
  {
  if ( jump==0 ) { imageplot( blob , blobx[goose] , bloby[goose] ) ; }

  if ( jump==1 ) { imageplot( jblob , blobx[goose] , bloby[goose] ) ; }
  }

  if ( jump == 0 )
  {
    if (spr[jug+6][goose]==9 && speed<=4 ) {playsound(4);speed=speed*2;spr[jug+6][goose]=1;}
    if (spr[jug+6][goose]==0 && speed>1 ) {playsound(4);speed=speed/2;spr[jug+6][goose]=1;}
    if (spr[jug+6][goose]==2) {death=1;die=1;}
    if (spr[jug+6][goose]==8) {death=1;die=1;spr[jug+6][goose]=2;}
    if (spr[jug+6][goose]==5) {jump=1;jumpf=1;}
    if (spr[jug+6][goose]==6) {goose-=1;}
    if (spr[jug+6][goose]==7) {goose+=1;}
    if (spr[jug+6][goose]==3) {spr[jug+6][goose]=1;blibo+=1;score+=50; playsound(2);}
  }

  if ( spr[jug+6][goose]==4 && blibs==blibo ) { leveldone=1; }

  if ( jumpf>0 )
  {
    if ( jumpf==1  ) { playsound(3);}
    jumpf+=1;
    if (jumpf==jumpoo) { jump=0; }
    if (jumpf==jumpoo*2) { jumpf=0; }
  }
  score+=speed;
  /*crap*/
}

static void plotfloor(void)
{
  int nob,nx,nobx=48,ek,ej,el;
  bpointx-=speed*2;
  bpointy+=speed;
  pointx=bpointx;
  pointy=bpointy;
  imageplot(bb, blobx[6], bloby[6] );
  for ( nob = jug ; nob<(jug+25) ; nob++ )
  {

    for ( nx = 6 ; nx>0 ; nx-- )
    {
      nobx=nx*16;
      el=pointx-nobx;
      ej=pointy-nobx/2;
      ek=spr[nob][nx];
      imageplot( tiles[ ek ] , el , ej );
    }
    pointx+=16;
    pointy-=8;
  }

  if (bpointy==408) { jug+=1; bpointy=400 ; bpointx=200 ;}

  if ( jug==arse-24 ) { jug=1; }
}


int randoon(int num)
{
  	/* Seed random number generator */
	int seed = (int)time(NULL);
	srand( seed+(rand()%seed) );
	return (rand()%num+1);
}



SDL_Surface *loadimage(char *name)
{
	SDL_Surface *surface;
	SDL_Surface *image;
	char path[256];

	strcpy(path, DATA_PREFIX);
	strcat(path, "gfx/");
	strcat(path, name);
	strcat(path,".bmp");

	surface = SDL_LoadBMP(path);
	if (surface == NULL)
	{
		fprintf(stderr, "Can't load image %s", path);
		return NULL;
	}
	SDL_SetColorKey(surface, SDL_SRCCOLORKEY, SDL_MapRGB(surface->format, 255,255,255));
	image = SDL_DisplayFormat(surface);
	SDL_FreeSurface(surface);

	return image;
}

static int loadimages()
{
  int i;
  SDL_Rect rect, tile;
  Uint32 rmask, gmask, bmask, amask;

#if SDL_BYTEORDER == SDL_BIG_ENDIAN
rmask = 0xff000000;gmask = 0x00ff0000;bmask = 0x0000ff00;amask = 0x000000ff;
#else
rmask = 0x000000ff;gmask = 0x0000ff00;bmask = 0x00ff0000;amask = 0xff000000;
#endif


  bletters = loadimage( "letters" );
  btiles = loadimage( "tiles" );
  jblob  = loadimage( "jblob" );
  blob   = loadimage( "blob"  );
  bb     = loadimage( "bb" );
  bh     = loadimage( "bh" );
  fh     = loadimage( "fh" );
  bb2    = loadimage( "bb2");
  comp    = loadimage( "comp");
  levelbm    = loadimage( "level");
  ll    = loadimage( "ll");
  go   = loadimage( "go");
  ps    = loadimage( "ps");
  conveybm = loadimage( "convey" );




      tile.x = 0 ;
      tile.y = 0 ;
      rect.x=0;rect.y=0;rect.w=32;rect.h=16;
    for (i=0 ; i<10 ; i++)
    {
      tiles[i] = SDL_CreateRGBSurface(SDL_SWSURFACE, 32, 16, 32, rmask, gmask, bmask, amask);
      SDL_BlitSurface(btiles,&rect,tiles[i],&tile);
      rect.y+=16;
    }
      rect.x=0;rect.y=0;rect.w=8;rect.h=8;
    for (i=48 ; i<59 ; i++)
    {
       letters[i] = SDL_CreateRGBSurface(SDL_SWSURFACE, 8, 8, 32, rmask, gmask, bmask, amask);
      SDL_BlitSurface(bletters,&rect,letters[i],&tile);
      rect.y+=8;
    }
    rect.y-=8;
    for (i=65 ; i<91 ; i++)
    {
       letters[i] = SDL_CreateRGBSurface(SDL_SWSURFACE, 8, 8, 32, rmask, gmask, bmask, amask);
      SDL_BlitSurface(bletters,&rect,letters[i],&tile);
      rect.y+=8;
    }




    return 1;
}




#ifdef ENABLE_SOUND

static void initandloadsounds()
{
  if ( Mix_OpenAudio(22050, AUDIO_S16, 2, 2048) < 0 )
  {
    /* Can open sound so just run in quiet mode */
    soundv=0;
  } else
  {
    char path[256];

    strcpy(path, DATA_PREFIX "sounds/blob.wav");
    blob_sound = Mix_LoadWAV_RW(SDL_RWFromFile(path, "rb"), 1);
    strcpy(path, DATA_PREFIX "sounds/jump.wav");
    jump_sound = Mix_LoadWAV_RW(SDL_RWFromFile(path, "rb"), 1);
    strcpy(path, DATA_PREFIX "sounds/laff.wav");
    died_sound = Mix_LoadWAV_RW(SDL_RWFromFile(path, "rb"), 1);
    strcpy(path, DATA_PREFIX "sounds/move.wav");
    move_sound = Mix_LoadWAV_RW(SDL_RWFromFile(path, "rb"), 1);



  }
}

#endif


static void plotstring(char strinplot[], int x,int y)
{
  int i,j,str;
  j=strlen(strinplot);
  for ( i=0 ; i< j ; i++ )
  {
    str=strinplot[i];
    imageplot(letters[ str ],i*8+x,y);
  }
}


static void checkkeys(void)
{
	SDL_Event event;

	while (SDL_PollEvent(&event) != 0)
	{
		switch(event.type)
		{
		case SDL_KEYDOWN:
			switch(event.key.keysym.sym)
			{
			case SDLK_q: quit = 1; break;
			case SDLK_LEFT: left_down = 1; break;
			case SDLK_RIGHT: right_down = 1; break;
			case SDLK_SPACE: jump_down = 1; break;
			case SDLK_s: s_down=1 ; break;

			default: /* Stops gcc warning */ break;
			}
			break;

		case SDL_KEYUP:
			switch(event.key.keysym.sym)
			{
			case SDLK_LEFT: left_down = 0; break;
			case SDLK_RIGHT: right_down = 0; break;
			case SDLK_SPACE: jump_down = 0; break;
			case SDLK_s:     s_down  = 0; break;
			default: /* Stops gcc warning */ break;
			}
			break;

		case SDL_QUIT:
			quit = 1;
			break;
		}
	}
	if (s_down==1) { soundv+=1; volume(); if (soundv>=3) {soundv=0;} }
}

static void died(void)
{
  if (die==1) { playsound(1) ;}
  die+=1;
}

static void blankscreen()
{
  int x,y;
  for (x=0 ; x<640 ; x+=64)
  {
    for (y=0 ; y<480 ; y+=64 )
    {
      imageplot(bb,x,y);
    }
  }
  SDL_Flip(screen);
}

static void fore(void)
{
  imageplot ( fh , 72  , 332 );
  imageplot ( bh , 448 , 141 );
}

static void info(void)
{
  int monkey=70,munk;
  char scoremonkey[10];
  if (lives>1) {
    for (munk=1 ; munk<lives ; munk++ )
    {
      imageplot ( blob , monkey , 20 );
      monkey+=32;
    }
  }
  plotstring("LIVES",10,50);

  sprintf(scoremonkey,"SCORE %d",score);
  imageplot(bb2,48,80);
  plotstring(scoremonkey,10,80);
}

static void introscreen(void)
{
  level=1;
  getlevel();
   blankscreen();
  do {
    imageplot(conveybm,148,8);
  plotstring("CONVEY SDL C 2003 2004 2005 CLOUDSPRINTER DOT COM",140,85);
  plotstring("USE LEFT RIGHT ARROW KEYS AND SPACE TO JUMP",140,100);
  plotstring("COLLECT ALL THE BLUE BALLS AND CROSS THE FINISH",140,115);
  plotstring("LINE TO COMPLETE THE LEVEL IF YOU MISS ANY YOU",140,130);
  plotstring("WILL HAVE TO GO ROUND AGAIN",140,145);
  plotstring("TILES",160,194);
  plotstring("SAFE TILES",160,224);
  plotstring("AVOID HOLES",160,244);
  plotstring("COLLECT THESE",160,264);
  plotstring("FINISH LINE",160,284);
  plotstring("SPEED UP",160,304);

  plotstring("JUMP PADS",360,194);
  plotstring("SHIFT RIGHT",360,244);
  plotstring("SHIFT LEFT",360,264);
  plotstring("AVOID CRACK",360,284);
  plotstring("SLOW DOWN",360,304);



  imageplot(tiles[1],120,220);
  imageplot(tiles[2],120,240);
  imageplot(tiles[3],120,260);
  imageplot(tiles[4],120,280);
  imageplot(tiles[5],320,220);
  imageplot(tiles[6],320,240);
  imageplot(tiles[7],320,260);
  imageplot(tiles[8],320,280);
  imageplot(tiles[9],120,300);
  imageplot(tiles[0],320,300);

  plotstring("S CHANGE SOUND VOLUME",184,320);
 #ifdef ENABLE_SOUND
 imageplot(bb2,280,340);
 if (soundv==0) { plotstring("SOUND IS OFF",230,340);    }
 if (soundv==1) { plotstring("SOUND IS QUIET",230,340);  }
 if (soundv==2) { plotstring("SOUND IS LOUD",230,340);   }
 #else
  plotstring("SOUND IS DISABLED",230,340);
 #endif

 imageplot(ps,100,400);


  checkkeys();
  SDL_Flip(screen);
  if (quit>0) break;
  }
  while ( jump_down==0  );
  leveldone=0;
  lives=3;
   blankscreen();
}

static void gameoverscreen(void)
{
   blankscreen();
  do {

  imageplot(go,70,100);
 imageplot(ps,100,200);

  checkkeys();
  SDL_Flip(screen);
   if (quit>0) break;
  }
  while ( jump_down==0 );
  leveldone=3;
  speed=4;
   blankscreen();
}


static void nextlevelscreen(void)
{
   blankscreen();
  do {
  imageplot(levelbm,100,100);


  imageplot(comp,200,180);

  imageplot(ps,78,350);

  checkkeys();
  SDL_Flip(screen);
   if (quit>0) break;
  }
  while ( jump_down==0 );
  speed=4;
  lives+=1;
  level+=1;
  getlevel();
  leveldone=0;
  score+=500;
  bpointy=400 ; bpointx=200;
   blankscreen();
}



static void lostlifescreen(void)
{
   blankscreen();
  do {
 imageplot(ll,70,100);
 imageplot(ps,100,200);
  checkkeys();
  SDL_Flip(screen);
   if (quit>0) break;
  }
  while ( jump_down==0 );
  getlevel();
  lives-=1;
  if (lives==0) { leveldone=2; }
 blankscreen();
}

static void completedscreen(void)
{
   blankscreen();
  do {
  plotstring("COMPLETED SEE DOCS TO MAKE MORE LEVELS",100,100);
  checkkeys();
  SDL_Flip(screen);
   if (quit>0) break;
  }
  while ( jump_down==0 );
  leveldone=3;
  lives=3;
  if (lives==0) { leveldone=2; }
   blankscreen();

}





int main(int argc, char *argv[])
{
	int full_screen = 0;
	int j;

	for (j = 1; j < argc; j++)
	{
		if (strcmp(argv[j],"-f") == 0 || strcmp(argv[j], "-fullscreen") == 0) full_screen =  SDL_FULLSCREEN|SDL_DOUBLEBUF;

#ifdef ENABLE_SOUND
            else if (strcmp(argv[j],"-n") == 0 || strcmp(argv[j], "-nosound") == 0) soundv = 0;
#endif
	}

	/* Initialize SDL */
	if ( SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO) < 0 ) {
		fprintf(stderr, "Couldn't initialize SDL: %s\n",SDL_GetError());
		return EXIT_FAILURE;
	}
	atexit(SDL_Quit);

	/* Set video mode */
	if ( (screen=SDL_SetVideoMode(640,480,32, SDL_HWSURFACE|SDL_FULLSCREEN|SDL_DOUBLEBUF)) == NULL )
	{
		fprintf(stderr, "Couldn't set 640x480x32 video mode: %s\n", SDL_GetError());
		return EXIT_FAILURE;
	}

	if (!loadimages()) return EXIT_FAILURE;

#ifdef ENABLE_SOUND
       initandloadsounds();
#endif




    SDL_WM_SetCaption("Convey SDL", 0);

	SDL_ShowCursor( 0 );
        init();

	do
	{

			sec = SDL_GetTicks();
			do
			{
			 if (leveldone==1) nextlevelscreen();
			 if (leveldone==2) gameoverscreen();
			 if (leveldone==3) introscreen();

			do
			{
				cents = SDL_GetTicks();
				if (cents < sec + 80) SDL_Delay(sec + 80 - cents);
				sec = SDL_GetTicks();
                                checkkeys();
                                plotfloor();

                                if ( death==0) { blobc();}
                                else { died(); }
                                fore();
                                info();
                                if (die==31) lostlifescreen();


				SDL_Flip(screen);

				if (quit) { leveldone=3;quit=1;break; }
			}
			while (leveldone==0);
			if (leveldone==totallevels) { completedscreen(); }
                        }
			while (quit==0);

	}
	while (quit == 0);

#ifdef ENABLE_SOUND
    Mix_CloseAudio();
#endif

	return EXIT_SUCCESS;
}
