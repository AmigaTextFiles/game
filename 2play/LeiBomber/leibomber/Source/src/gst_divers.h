#ifndef GST_DIVERS_H
#define GST_DIVERS_H

#include <SDL/SDL.h>
#include <SDL/SDL_mixer.h>

#define RECT_AFFECTE(RECT, X, Y, W, H) \
  (RECT).x = X; \
  (RECT).y = Y; \
  (RECT).w = W; \
  (RECT).h = H;


#define RINT(valeur) \
  ((valeur) - (int) (valeur)) >= 0.5 ? (int) (valeur) + 1 : (int) (valeur)

extern void sdl_rect_affecte (SDL_Rect * rect, Sint16 x, Sint16 y, Uint16 w, Uint16 h);

extern SDL_Surface * img_secure_load (char * chemin);

extern Mix_Chunk * mix_secure_load (char * chemin);


#endif /* GST_DIVERS_H */
