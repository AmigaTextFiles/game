#include "gst_directions.h"

/* Pour chacune des directions, indique le signe en x et y du vecteur */
type_position valeurs_directions [nbre_de_directions] = { { 0, 1 }, { -1, 0 }, { 0, -1}, { 1, 0} };
/*
void
update_element (SDL_Rect * pos, SDL_Rect * ancien_pos, SDL_Surface * screen)
{
  int x = pos->x;
  int y = pos->y;
  int w = coords->w;
  int h = coords->h;
  if (etre->ancien_posX > x)
    {
      w += etre->ancien_posX - x;
    }
  else
    {
      w += x - etre->ancien_posX;
      x = etre->ancien_posX;
    }
  if (etre->ancien_posY > y)
    {
      h += etre->ancien_posY - y; 
    }
  else
    {
      h += y - etre->ancien_posY; 
      y = etre->ancien_posY;
    }
  SDL_UpdateRect (screen, x, y, w, h);
}
*/
