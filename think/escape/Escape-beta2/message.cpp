
#include "message.h"
#include "font.h"
#include "sdlutil.h"
#include "draw.h"
#include "util.h"
#include "chars.h"

struct mreal : public message {

  static mreal * create();
  virtual void destroy();

  /*  enter: true
     escape: false */
  virtual bool ask();

  virtual void draw();
  virtual void screenresize();
  virtual ~mreal();

  SDL_Surface * alpharect;
  bool loop ();

  int nlines;
  int posx;
};

mreal * mreal::create() {
  mreal * pp = new mreal();
  pp->below = 0;
  pp->alpharect = 0;
  pp->posx = 0;
  pp->nlines = 0;
  return pp;
}

void mreal::destroy() {
  if (alpharect) SDL_FreeSurface(alpharect);
  delete this;
}

mreal::~mreal() {}
message::~message() {}
message * message::create() {
  return mreal::create();
}

bool mreal::ask() {

  /* find longest line */
  int ll = 0;
  { string titlen = title + "\n";
  int cl = 0;
  for(unsigned int i = 0; i < titlen.length(); i ++) {
    if (titlen[i] == '\n') {
      ll = util::maximum(fon->sizex(titlen.substr(cl, i - cl)), ll);
      cl = i;
    } else if (titlen[cl] == '\n') cl = i;
  }
  }

  int w = 
    (2 * fon->width) +
    util::maximum(ll,
		  fon->sizex("ESCAPE: ") +
		  util::maximum(fon->sizex(ok),
				fon->sizex(cancel)));

  nlines = font::lines(title);

  int h;
  if (cancel == "") {
    h = ((3 + nlines) * fon->height);
  } else {
    h = ((4 + nlines) * fon->height);
  }

  /* now center */
  posx = (screen->w - w) / 2;
  
  /* and y, if desired */
  if (posy < 0) {
    posy = (screen->h - h) / 2;
  }

  /* XXX make these values setable */
  /* create alpha rectangle */
  alpharect = sdlutil::makealpharect(w, h, 90, 90, 90, 200);

  sdlutil::outline(alpharect, 2, 36, 36, 36, 200);

  return loop();
}

void mreal::screenresize() {
  if (below) below->screenresize();
}

void mreal::draw() {

  /* clear back */
  if (!below) {
    sdlutil::clearsurface(screen, BGCOLOR);
  } else {
    below->draw();
  }

  /* draw alpha-transparent box */
  SDL_Rect dest;

  dest.x = posx;
  dest.y = posy;

  SDL_BlitSurface(alpharect, 0, screen, &dest);

  /* draw text */
  fon->drawlines(posx + fon->width, posy + fon->height, title);
  fon->draw(posx + fon->width, posy + ((1 + nlines) * fon->height),
	    (string)YELLOW "ENTER" POP ":  " + ok);
  if (cancel != "") 
    fon->draw(posx + fon->width, posy + ((2 + nlines) * fon->height),
	      (string)YELLOW "ESCAPE" POP ": " + cancel);
}

bool mreal::loop() {

  draw();
  SDL_Flip(screen);

  SDL_Event e;

  while ( SDL_WaitEvent(&e) >= 0 ) {

    int key;

    switch(e.type) {
    case SDL_QUIT:
      return false; /* XXX ? */
    case SDL_KEYDOWN:
      key = e.key.keysym.sym;
      switch(key) {
      case SDLK_ESCAPE:
	return false;
      case SDLK_RETURN:
	return true;

      default:;
	/* XXX might flash screen or something */
      }
      break;
    case SDL_VIDEORESIZE: {
      SDL_ResizeEvent * eventp = (SDL_ResizeEvent*)&e;
      screen = sdlutil::makescreen(eventp->w, 
				   eventp->h);
      screenresize();
      draw();
      SDL_Flip(screen);
      break;
    }
    case SDL_VIDEOEXPOSE:
      draw();
      SDL_Flip(screen);
      break;
    default: break;
    }
  }
  return false; /* XXX ??? */
}

