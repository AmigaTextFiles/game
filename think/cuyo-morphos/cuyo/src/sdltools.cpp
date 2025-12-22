/***************************************************************************
                          sdltools.cpp  -  description
                             -------------------
    begin                : Fri Jul 21 2000
    copyright            : (C) 2006 by Immi
    email                : cuyo@pcpool.mathematik.uni-freiburg.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <cstdlib>

#include "stringzeug.h"
#include "sdltools.h"
#include "global.h"
#include "fehler.h"

namespace SDLTools {


/* A 32-Bit-surface, to copy the pixel format from */
SDL_Surface * gSampleSurface32 = 0;

/* The pixel format used for maskedDisplayFormat() */
SDL_PixelFormat gMaskedFormat;
/* The replacement colour for the ColourKey, if neccessary */
Uint8 gColkeyErsatz;



void myQuitSDL() {
  if (gSampleSurface32)
    SDL_FreeSurface(gSampleSurface32);
  if (gMaskedFormat.palette) {
    delete[] gMaskedFormat.palette->colors;
    delete gMaskedFormat.palette;
  }
  SDL_Quit();
}



void initSDL(int w, int h) {

  /* Initialize the SDL library */
  /* Audio will be initialized by our sound system */
  SDLASSERT(SDL_Init(SDL_INIT_VIDEO/* | SDL_INIT_AUDIO*/) == 0);
  
  /* Clean up on exit */
  atexit(myQuitSDL);

  /* Set the name of the window (and the icon) */
  SDL_WM_SetCaption(gDebug ? "Cuyo - debug mode" : "Cuyo", "Cuyo");
  
  SDL_EventState(SDL_KEYUP, SDL_IGNORE);
  SDL_EventState(SDL_ACTIVEEVENT, SDL_IGNORE);
  
  if (gKlein) {
    w = w * 3 / 4;
    h = h * 3 / 4;
  }

  /* Initialize the display
     requesting a software surface
     BitsPerPixel = 0: Take the current BitsPerPixel
     SDL_ANYFORMAT: Other pixel depths are ok, too. */
  SDL_Surface * screen = SDL_SetVideoMode(w, h, 0,
		 SDL_SWSURFACE/*|SDL_DOUBLEBUF*/|SDL_ANYFORMAT);
  SDLASSERT(screen);
    
  gSampleSurface32 = createSurface32(1, 1);
  SDLASSERT(gSampleSurface32);

  gMaskedFormat = *(screen->format);
  if (gMaskedFormat.palette) {
    int ncolours = gMaskedFormat.palette->ncolors;

    /* Erst mal eine Kopie der Palette anlegen. Bˆse Dinge kˆnnten passieren,
       wenn das displaysurface sie ‰ndert. */
    SDL_Color * neufarben = new SDL_Color[ncolours];
    memcpy((void*) neufarben, (void*) gMaskedFormat.palette->colors,
	   ncolours * sizeof(SDL_Color));
    SDL_Palette * neupal = new SDL_Palette;
    neupal->ncolors = ncolours;
    neupal->colors = neufarben;
    gMaskedFormat.palette = neupal;

    if (ncolours < 255) {
      gMaskedFormat.colorkey = ncolours + 1;
      gColkeyErsatz = 0;  // Wird eh nicht benutzt...
    }
    else {
      /* Jetzt m¸ssen wir eine entbehrliche Farbe suchen */
      int dmin = 1000;
      int c1best=0, c2best=0;
        // Initialisierung ist unnˆtig, spart aber Warnungen

      SDL_Color * colours = gMaskedFormat.palette->colors;

      #ifdef DIST
        Vorsicht, DIST gibt es schon!
        (Wˆrter, die nur mit Leerzeichen getrennt sind
	  => Keine Chance, daﬂ C hier keinen Fehler wirft)
      #endif
      #define DIST(dim) (colours[c1].dim<colours[c2].dim \
        ? colours[c2].dim-colours[c1].dim                \
	: colours[c1].dim-colours[c2].dim)

      for (int c1=0; c1<ncolours; c1++)
	for (int c2=c1+1; c2<ncolours; c2++) {
	  int d = DIST(r)+DIST(g)+DIST(b);
	  if (d<dmin) {
	    dmin=d;
	    c1best=c1;
	    c2best=c2;
	  }
	}

      #undef DIST

      gMaskedFormat.colorkey = c2best;
      gColkeyErsatz = c1best;
    }
  }
  else
    gMaskedFormat = *(gSampleSurface32->format);

  /* We need the characters corresponding to key-events for the menus:
     For example, on a French keyboard, shift-& is 1 */
  SDL_EnableUNICODE(1);
}




/* Convert Qt-Key into SDL-Key; don't use Qt constants: we don't want to depend on
   Qt just to be able to read old .cuyo files. */
SDLKey qtKey2sdlKey(int qtk) {

  /* Letters are uppercase in Qt and lowercase in SDL */
  if (qtk >= 'A' && qtk <= 'Z')
    return (SDLKey) (qtk - 'A' + 'a');
  
  /* Don't change other Ascii Characters.
     (Maybe ƒ, ÷, ‹, etc are a problem) */
  if (qtk <= 255)
    return (SDLKey) qtk;

  /* Other important keys */
  switch (qtk) {
    case 0x1000: return SDLK_ESCAPE;
    case 0x1001: return SDLK_TAB;
    case 0x1003: return SDLK_BACKSPACE;
    case 0x1004: return SDLK_RETURN;
    case 0x1006: return SDLK_INSERT;
    case 0x1007: return SDLK_DELETE;
    case 0x1008: return SDLK_PAUSE;
    case 0x1009: return SDLK_PRINT;
    case 0x100a: return SDLK_SYSREQ;
    case 0x100b: return SDLK_CLEAR;
    case 0x1010: return SDLK_HOME;
    case 0x1011: return SDLK_END;
    case 0x1012: return SDLK_LEFT;
    case 0x1013: return SDLK_UP;
    case 0x1014: return SDLK_RIGHT;
    case 0x1015: return SDLK_DOWN;
    case 0x1016: return SDLK_PAGEUP;
    case 0x1017: return SDLK_PAGEDOWN;

    case 0x1030: return SDLK_F1;
    case 0x1031: return SDLK_F2;
    case 0x1032: return SDLK_F3;
    case 0x1033: return SDLK_F4;
    case 0x1034: return SDLK_F5;
    case 0x1035: return SDLK_F6;
    case 0x1036: return SDLK_F7;
    case 0x1037: return SDLK_F8;
    case 0x1038: return SDLK_F9;
    case 0x1039: return SDLK_F10;
    case 0x103a: return SDLK_F11;
    case 0x103b: return SDLK_F12;
    case 0x103c: return SDLK_F13;
    case 0x103d: return SDLK_F14;
    case 0x103e: return SDLK_F15;

    case 0x1055: return SDLK_MENU;
    case 0x1058: return SDLK_HELP;
    //case : return SDLK_BREAK;
    //case : return SDLK_POWER;
    //case : return SDLK_EURO;
    //case : return SDLK_UNDO;
    default: return SDLK_UNKNOWN;
  }
  
  /* Modifier keys are missing */
}



SDL_Rect rect(int x, int y, int w, int h) {
  SDL_Rect ret;
  ret.x = x; ret.y = y; ret.w = w; ret.h = h;
  return ret;
}

bool intersection(const SDL_Rect & a, const SDL_Rect & b, SDL_Rect & ret) {
  ret.x = a.x > b.x ? a.x : b.x;
  ret.y = a.y > b.y ? a.y : b.y;
  int xplusw = a.x + a.w < b.x + b.w ? a.x + a.w : b.x + b.w;
  int yplush = a.y + a.h < b.y + b.h ? a.y + a.h : b.y + b.h;
  if (xplusw<=ret.x || yplush<=ret.y)
    return false;
  ret.w = xplusw-ret.x;
  ret.h = yplush-ret.y;
  return true;
}



/* Creates a 32-bit-surface with alpha. After filling it with your
   data, you should convert it to screen format */
SDL_Surface * createSurface32(int w, int h) {

  union { Uint32 f; Uint8 k[4];} rmask, gmask, bmask, amask;
  
  /* Die richtigen Bits der Masken auf 1 setzen; das Problem ist, dass
     welches die richtigen Bits sind von der Enianness abhaengen.
     Das folgende macht's richtig: */
  rmask.f = gmask.f = bmask.f = amask.f = 0;
  rmask.k[0] = gmask.k[1] = bmask.k[2] = amask.k[3] = 0xff;

  SDL_Surface * s = SDL_CreateRGBSurface(SDL_HWSURFACE, w, h, 32, rmask.f, gmask.f, bmask.f, amask.f);
  SDLASSERT(s);
  return s;
}


/* Converts a surface to a 32-bit-surface with alpha. The original surface
   is deleted. */  
void convertSurface32(SDL_Surface *& s) {
  /* Silly: The only way I know to create a SDL_PixelFormat is using
     SDL_CreateRGBSurface; so we need a "sample surface" to get the
     format from... */
  SDL_Surface * tmp = SDL_ConvertSurface(s, gSampleSurface32->format, SDL_SWSURFACE);
  SDLASSERT(tmp);
  SDL_FreeSurface(s);
  s = tmp;
}


/* Return a reference to the pixel at (x, y);
   assumes that the surface is 32-Bit.
   NOTE: The surface must be locked before calling this! */
Uint32 & getPixel32(SDL_Surface *surface, int x, int y) {
  int bpp = surface->format->BytesPerPixel;
  return *(Uint32 *) ((Uint8 *)surface->pixels + y * surface->pitch + x * bpp);
}


/* Converts the surface to a format suitable for fast blitting onto the
   display surface. Contrary to SDL_DisplayFormat, transparency is
   respected, at least where it is full transparency. Contrary to
   SDL_DisplayFormatAlpha, it uses ColourKey for paletted surfaces. */
SDL_Surface * maskedDisplayFormat(SDL_Surface * src) {
  SDL_Surface * ret = SDL_ConvertSurface(src,&gMaskedFormat,0);
  SDLASSERT(ret);

  if (gMaskedFormat.palette) {
    /* SDL sieht nicht vor, daﬂ Alpha zu ColourKey konvertiert wird.
       Seufz. Also selber nachbearbeiten. */
    SDLASSERT(!SDL_MUSTLOCK(src) && !SDL_MUSTLOCK(ret));

    ret->flags |= SDL_SRCCOLORKEY;
    Uint8 colkey = gMaskedFormat.colorkey;
    ret->format->colorkey = colkey;
    Uint32 amask = src->format->Amask;
    Uint8 * srcrow = (Uint8 *) src->pixels;
    Uint8 * retrow = (Uint8 *) ret->pixels;
    int w = src->w;
    int p1 = src->pitch;
    int p2 = ret->pitch;
    for (int i=src->h; i; i--, srcrow+=p1, retrow+=p2) {
      Uint32 * srcpix = (Uint32 *) srcrow;
      Uint8 * retpix = retrow;
      for (int j=w; j; j--, srcpix++, retpix++)
	if (((*srcpix) & amask)==0)
	  *retpix = colkey;
	else if ((*retpix)==colkey)
	  *retpix = gColkeyErsatz;
    }
  }
  return ret;
}



}  // namespace SDLTools

/**************************************************************************/

#define max_area_depth 5

namespace Area {

  /* The bounds of each area in the area stack.
     mBounds[0] is always the whole window.
     In tiny-mode, mBounds is already scaled */
  SDL_Rect mBounds[5];
  /* mBounds[mActDepth] are the present bounds */
  int mActDepth;
  
  /* I don't use a stl-vector for the updateRects, because:
     a) I don't want the vector to be resized to a small one
        each time the updateRects are cleared
     b) I need direct access to the memory area with the rects
        to pass them to SDL
     In tiny-mode, the mUpdateRects are already scaled
  */
  SDL_Rect * mUpdateRects;
  int mNumUpdateRects;
  int mReservedUpdateRects;
  bool mUpdateAll;
  
  /*** Private functions ***/


  void needMoreUpdateRects() {
    mReservedUpdateRects *= 2;
    mUpdateRects = (SDL_Rect *) realloc(mUpdateRects,
                   sizeof(SDL_Rect) * mReservedUpdateRects);
  }
  
  
  void transform(int & x, int & y) {
    if (gKlein) {
      x = x * 3 / 4;
      y = y * 3 / 4;
    }
    x += mBounds[mActDepth].x;
    y += mBounds[mActDepth].y;
  }
  
  void scale(SDL_Rect & r) {
    if (gKlein) {
      int right = r.x + r.w;
      int bot = r.y + r.h;
      r.x = r.x * 3 / 4;
      r.y = r.y * 3 / 4;
      right = right * 3 / 4;
      bot = bot * 3 / 4;
      r.w = right - r.x;
      r.h = bot - r.y;
    }
  }
  
  void transform(SDL_Rect & r) {
    scale(r);
    r.x += mBounds[mActDepth].x;
    r.y += mBounds[mActDepth].y;
  }
    
  
  /*** Public functions ***/
  
  
  
  void init() {
    /* 20 updateRects will never be enough, but I prefer that
       needMoreUpdateRects is called early enough so I notice if
       there's a bug inside. */
    mReservedUpdateRects = 20;
    mUpdateRects = (SDL_Rect *) malloc(sizeof(SDL_Rect) * mReservedUpdateRects);
    mNumUpdateRects = 0;
    mUpdateAll = false;

    mActDepth = 0;
    SDL_Surface * s = SDL_GetVideoSurface();
    mBounds[mActDepth] = SDLTools::rect(0, 0, s->w, s->h);
  }
  
  void destroy() {
    free(mUpdateRects);
  }
  
  
  void enter(SDL_Rect r) {
    scale(r);
    
    mActDepth++;
    CASSERT(mActDepth < max_area_depth);
    SDLTools::intersection(mBounds[mActDepth - 1], r, mBounds[mActDepth]);
    SDL_SetClipRect(SDL_GetVideoSurface(), &mBounds[mActDepth]);
  }
  
  void leave() {
    CASSERT(mActDepth > 0);
    mActDepth--;
    SDL_SetClipRect(SDL_GetVideoSurface(), &mBounds[mActDepth]);
  }

  void setClip(SDL_Rect r) {
    scale(r);
    SDL_Rect schnitt;
    SDLTools::intersection(r,mBounds[mActDepth],schnitt);
    SDL_SetClipRect(SDL_GetVideoSurface(), &schnitt);
  }
  
  void noClip() {
    SDL_SetClipRect(SDL_GetVideoSurface(), &mBounds[mActDepth]);
  }
  

  void blitSurface(SDL_Surface *src, SDL_Rect srcrect, int dstx, int dsty) {
    transform(dstx, dsty);
    scale(srcrect);
    SDL_Rect dstrect = SDLTools::rect(dstx, dsty);
    SDL_BlitSurface(src, &srcrect, SDL_GetVideoSurface(), &dstrect);
  }
  
  void blitSurface(SDL_Surface *src, int dstx, int dsty) {
    transform(dstx, dsty);
    SDL_Rect dstrect = SDLTools::rect(dstx, dsty);
    SDL_BlitSurface(src, 0, SDL_GetVideoSurface(), &dstrect);
  }


  void fillRect(SDL_Rect dst, const Color & c) {
    SDL_Surface * s = SDL_GetVideoSurface();
    transform(dst);
    SDL_FillRect(s, &dst, c.getPixel(s->format));
  }
  
  void fillRect(int x, int y, int w, int h, const Color & c) {
    fillRect(SDLTools::rect(x, y, w, h), c);
  }


  /* You have to call the following methods to make your drawing operations
     really visible on the screen. (However, the update will take place only
     at the next call to doUpdate) */
  void updateRect(SDL_Rect dst) {
    if (!mUpdateAll) {
      SDL_Rect schnitt;
      transform(dst);
      if (SDLTools::intersection(dst,mBounds[mActDepth],schnitt)) {
	if (mNumUpdateRects >= mReservedUpdateRects)
	  needMoreUpdateRects();
	mUpdateRects[mNumUpdateRects++] = schnitt;
      }
    }
  }
  
  void updateRect(int x, int y, int w, int h) {
    updateRect(SDLTools::rect(x, y, w, h));
  }
  
  /* Better than calling updateRect(bigRect): Stops collecting small
     rectangles. All means really all, not only active area. */
  void updateAll() {
    mUpdateAll = true;
  }

  

  /* To be called only by ui.cpp */
  void doUpdate() {
    if (mUpdateAll)
      SDL_UpdateRect(SDL_GetVideoSurface(), 0, 0, 0, 0);
    else {
      //printf("%d\n", mNumUpdateRects);
      SDL_UpdateRects(SDL_GetVideoSurface(), mNumUpdateRects, mUpdateRects);
    }
    mUpdateAll = false;
    mNumUpdateRects = 0;
  }

}




