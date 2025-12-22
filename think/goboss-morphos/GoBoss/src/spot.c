#include "spot.h"
#include "const.h"

#include <SDL.h>

extern SDL_Surface *screen,*bgoban;

/** spots **/
Spot *spot_new (Case cible, int color) {
  static int id = 0;
  Spot *spot = (Spot*)malloc(sizeof(Spot));
  spot->id = id++;
  spot->cible = cible;
  spot->color = color;
  spot->x1 = cible.x * WIDTH + LEFT - WIDTH / 2;
  spot->x2 = cible.x * WIDTH + LEFT + 3 * WIDTH / 2;
  spot->y1 = cible.y * HEIGHT + UP - HEIGHT / 2;
  spot->y2 = cible.y * HEIGHT + UP + 3 * HEIGHT / 2;
  spot->px1 = spot->px2 = spot->py1 = spot->py2 = -1;
  spot->centerx = cible.x * WIDTH + LEFT + WIDTH/2;
  spot->centery = cible.y * HEIGHT + UP + HEIGHT/2;
  return spot;
}

void spot_free (Spot *spot) {
  free (spot);
}

void spot_approche_cible (Spot *spot) {
  #define mspeed 10

  spot->px1 = spot->x1;
  spot->py1 = spot->y1;
  spot->px2 = spot->x2;
  spot->py2 = spot->y2;

  spot->x1 = (spot->x1 * mspeed + ((spot->cible.x) * WIDTH + LEFT + WIDTH / 2)) / (mspeed+1);
  spot->x2 = (spot->x2 * mspeed + ((spot->cible.x) * WIDTH + LEFT + WIDTH / 2)) / (mspeed+1);
  spot->y1 = (spot->y1 * mspeed + ((spot->cible.y) * HEIGHT + UP + HEIGHT / 2)) / (mspeed+1);
  spot->y2 = (spot->y2 * mspeed + ((spot->cible.y) * HEIGHT + UP + HEIGHT / 2)) / (mspeed+1);

  if ((spot->x1 - ((spot->cible.x) * WIDTH + LEFT + WIDTH / 2) < 2)
    && (spot->x2 - ((spot->cible.x) * WIDTH + LEFT + WIDTH / 2) < 2)
    && (spot->y1 - ((spot->cible.y) * HEIGHT + UP + HEIGHT / 2) < 2)
    && (spot->y2 - ((spot->cible.y) * HEIGHT + UP + HEIGHT / 2) < 2))
      spot->x1 = spot->x2 = spot->y1 = spot->y2 = -1;
}


SDL_Rect hline (int py, int centerx) {
  SDL_Rect r;
  r.y = py;
  r.x = centerx - WIDTH;
  r.h = 1;
  r.w = 2 * WIDTH;
  return r;
}

SDL_Rect vline (int px, int centery) {
  SDL_Rect r;
  r.x = px;
  r.y = centery - HEIGHT;
  r.w = 1;
  r.h = 2 * HEIGHT;
  return r;
}


void spot_draw (Spot *spot) {
  // redessiner dans les positions P, le background
  SDL_Rect r[8];
  int nb = 0;
  if (spot->py1>=0) {
    r[nb] = hline (spot->py1, spot->centerx);
    SDL_BlitSurface (bgoban,&(r[nb]),screen,&(r[nb]));
    nb++;
  }
  if (spot->py2>=0) {
    r[nb] = hline (spot->py2, spot->centerx);
    SDL_BlitSurface (bgoban,&(r[nb]),screen,&(r[nb]));
    nb++;
  }
  if (spot->px1>=0) {
    r[nb] = vline (spot->px1, spot->centery);
    SDL_BlitSurface (bgoban,&(r[nb]),screen,&(r[nb]));
    nb++;
  }
  if (spot->px2>=0) {
    r[nb] = vline (spot->px2, spot->centery);
    SDL_BlitSurface (bgoban,&(r[nb]),screen,&(r[nb]));
    nb++;
  }

  if (spot->y1>=0) {
    r[nb] = hline (spot->y1, spot->centerx);
    SDL_FillRect (screen,&(r[nb]),spot->color);
    nb++;
  }
  if (spot->y2>=0) {
    r[nb] = hline (spot->y2, spot->centerx);
    SDL_FillRect (screen,&(r[nb]),spot->color);
    nb++;
  }
  if (spot->x1>=0) {
    r[nb] = vline (spot->x1, spot->centery);
    SDL_FillRect (screen,&(r[nb]),spot->color);
    nb++;
  }
  if (spot->x2>=0) {
    r[nb] = vline (spot->x2, spot->centery);
    SDL_FillRect (screen,&(r[nb]),spot->color);
    nb++;
  }
  SDL_UpdateRects (screen, nb, r);
}
