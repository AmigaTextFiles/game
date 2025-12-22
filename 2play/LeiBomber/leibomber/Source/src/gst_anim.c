#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <assert.h>

#include "gst_anim.h"
#include "gst_divers.h"

static type_visage visage;

void
anim_cree_visage (int x, int y, SDL_Surface * screen)
{
  char nom_fic [26] = FICHIERS_VISAGE;
  int i;
  nom_fic [25] = 0;
  for (i = 0; i < 2; i++)
    {
      nom_fic [20] = 49 + i;
      visage.images [i] = img_secure_load (nom_fic);
      SDL_SetColorKey (visage.images [i], SDL_SRCCOLORKEY, SDL_MapRGB (visage.images [i]->format, 0, 255, 255));
    }
  sdl_rect_affecte (&(visage.pos), x, y, 0, 0);
  sdl_rect_affecte (&(visage.coord), 0, 0, visage.images [0]->w, visage.images [0]->h);
  visage.screen = screen;
  anim_allume_visage ();
}

void 
anim_gere_visage ()
{
  (visage.cpt)--;
  if (visage.cpt <= 49)
    {
      if (visage.cpt == 49)
	{
	  SDL_BlitSurface (visage.images [1], &(visage.coord), visage.screen, &(visage.pos));
	  SDL_UpdateRects (visage.screen, 1, &(visage.pos));
	}
      else if (visage.cpt == 0)
	{
	  SDL_BlitSurface (visage.images [0], &(visage.coord), visage.screen, &(visage.pos));
	  SDL_UpdateRects (visage.screen, 1, &(visage.pos));
	  visage.cpt = 300 + (int) (500.0 * rand () / (RAND_MAX + 1.0));
	}
    }
}

void
anim_allume_visage ()
{
  visage.cpt = 50;
}

static int
anim_survole (SDL_Rect * pos)
{
  int x, y;
  SDL_GetMouseState (&x, &y);
  return (x >= pos->x && x <= pos->x + pos->w &&
	  y >= pos->y && y <= pos->y + pos->h);
}

int
anim_survol_visage ()
{
  return anim_survole (&(visage.pos));
}
      
