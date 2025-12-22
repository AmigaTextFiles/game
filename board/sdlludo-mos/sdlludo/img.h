/*********************************************
 * Title: Kitten's Fishing Game
 * Desc: Image handling class layout
 * Authors: GBiatch & Qte
 *
 * $Id: img.h,v 1.3 2002/07/21 17:43:32 qte Exp $
 *********************************************/

#ifndef IMG_H
#define IMG_H

#include "SDL/SDL.h"

extern SDL_Surface *screen;

class IMG {
 public: // Public members
  IMG(const char* path, int R, int G, int B);
  IMG(const char* path);
  IMG();
  ~IMG();
  void draw(int x, int y);
  void drawTrans(int x, int y);
  void load(const char* path);
  void setTrans(Uint32 transcolor);

 private: // Private members
  void sulock();
  void slock();
  SDL_Surface *surface;
  Uint32 transparent;
};
#endif
