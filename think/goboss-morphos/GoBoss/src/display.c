#include "display.h"
#include "const.h"

#include <SDL.h>
#include <SDL_thread.h>
#include <SDL_ttf.h>

int goban [19][19];

#include "spot.h"
unsigned int line_anim_callback (unsigned int interval, Spot *spot);

#include <proto/exec.h>
struct Library *PowerSDLBase;

void quitsdl(void)
{
  CloseLibrary(PowerSDLBase);
}

/* affichage */

SDL_Surface *screen;
SDL_Surface *bgoban;
SDL_Surface *bempty;
SDL_Surface *bblack;
SDL_Surface *bwhite;

//TTF_Font *notepad;

void init_sdl_stuff (GameParams params) {

  int x,y;
  Uint32 rmask, gmask, bmask, amask, flags;

  PowerSDLBase = OpenLibrary("powersdl.library", 11);

  if (!PowerSDLBase)
    exit(20);

  atexit(quitsdl);

  SDL_Init (SDL_INIT_VIDEO|SDL_INIT_TIMER);
  flags = SDL_HWSURFACE;
  if (params.fullscreen)
    flags |= SDL_FULLSCREEN;

  screen = SDL_SetVideoMode (SCREEN_WIDTH,SCREEN_HEIGHT,
                             32,flags);

  /* SDL interprets each pixel as a 32-bit number, so our masks must depend
     on the endianness (byte order) of the machine */
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
    rmask = 0xff000000;
    gmask = 0x00ff0000;
    bmask = 0x0000ff00;
    amask = 0x000000ff;
#else
    rmask = 0x000000ff;
    gmask = 0x0000ff00;
    bmask = 0x00ff0000;
    amask = 0xff000000;
#endif

  bgoban = SDL_CreateRGBSurface(SDL_HWSURFACE, 768, 768, 32,
                                rmask, gmask, bmask, amask);

  bempty = SDL_LoadBMP ("board_empty.bmp");
  bwhite = SDL_LoadBMP ("board_white.bmp");
  bblack = SDL_LoadBMP ("board_black.bmp");

  for (x=0;x<19;x++) for (y=0;y<19;y++) goban [x][y] = -1;

  SDL_BlitSurface (bempty, NULL, screen, NULL);
  SDL_BlitSurface (bempty, NULL, bgoban, NULL);
  SDL_Flip (screen);
}


void effacerGroupeALEcran (Case c);
int couleursConcordes (Case c, ComPipe *pipe)
  {return getCouleurALEcran (c) == getCouleurDansGG (c, pipe);}

/** **/

void poserPionALEcran (int coul, Case c, int flip) {

  SDL_Surface *surf = (coul == -1) ? bempty : ((coul==0) ? bblack : bwhite);
  SDL_Rect rect;

  rect.x = LEFT + c.x * WIDTH;
  rect.y = UP + c.y * HEIGHT;
  rect.w = (WIDTH+1);
  rect.h = (HEIGHT+1);
  SDL_BlitSurface (surf, &rect, screen, &rect);
  SDL_BlitSurface (surf, &rect, bgoban, &rect);
  if (flip)
    SDL_Flip (screen);
  goban [c.x][c.y] = coul;
  if ((coul!=-1) && (flip))
    SDL_AddTimer(1, line_anim_callback, spot_new (c,coul?0xdddddddd:0x22222222));
}


Case getCase (float x, float y) {

  float left = LEFT;
//  float right = 735;
  float width = WIDTH;

  float up = UP;
//  float down = 737;
  float height = HEIGHT;

  Case c = {-1,-1};
  left = (x-left);
  up = (y-up);

  if ((left<0) || (up<0))
    return c;

  c.x = (int)(left / width);
  c.y = (int)(up / height);

  return c;
}


void effacerGroupeALEcran (Case c) {

  int coul = getCouleurALEcran (c);
  poserPionALEcran (-1, c, 0);

  if (getCouleurALEcran (caseAGaucheDe(c)) == coul)
    effacerGroupeALEcran (caseAGaucheDe(c));

  if (getCouleurALEcran (caseADroiteDe(c)) == coul)
    effacerGroupeALEcran (caseADroiteDe(c));

  if (getCouleurALEcran (caseAuDessusDe(c)) == coul)
    effacerGroupeALEcran (caseAuDessusDe(c));

  if (getCouleurALEcran (caseAuDessousDe(c)) == coul)
    effacerGroupeALEcran (caseAuDessousDe(c));
}


void faireLeMenageAutourDe (Case c, ComPipe *pipe) {
  if (!couleursConcordes (caseAGaucheDe(c), pipe))
    effacerGroupeALEcran (caseAGaucheDe(c));
  if (!couleursConcordes (caseADroiteDe(c), pipe))
    effacerGroupeALEcran (caseADroiteDe(c));
  if (!couleursConcordes (caseAuDessusDe(c), pipe))
    effacerGroupeALEcran (caseAuDessusDe(c));
  if (!couleursConcordes (caseAuDessousDe(c), pipe))
    effacerGroupeALEcran (caseAuDessousDe(c));
  SDL_Flip (screen);
}


int getCouleurALEcran (Case c) {

  if (caseNulle (c))
    return -1;
  return goban [c.x][c.y];
}


void redrawGoban (ComPipe *pipe) {

  Case c;
  for (c.x=0;c.x<19;c.x++) for (c.y=0;c.y<19;c.y++) {
    poserPionALEcran (getCouleurDansGG (c,pipe), c, 0);
  }
  SDL_Flip (screen);
}
