
#ifndef __MESSAGE_H
#define __MESSAGE_H

#include "escapex.h"
#include "drawable.h"
#include "chars.h"

struct message : public drawable {
  
  string title;
  string ok;
  string cancel;

  drawable * below;

  /* xpos, height and width will
     be computed automatically.
     If posy is below zero, center.
  */
  int posy;

  static message * create();
  virtual void destroy() = 0;

  /* ok: true
     cancel: false */
  virtual bool ask() = 0;

  virtual void draw() = 0;
  virtual void screenresize() = 0;
  virtual ~message();

  static bool quick(drawable * bbelow, string ttitle,
		    string ook, string ccancel, 
		    string icon = PICS EXCICON POP) {
    message * m = message::create();
    m->below = bbelow;
    m->posy = -1;
    m->title = icon + WHITE " " + ttitle;
    m->ok = ook;
    m->cancel = ccancel;
    
    bool x = m->ask();
    m->destroy();
    return x;
  }

  static bool quickv(drawable * bbelow, int posy, 
		     string ttitle,
		     string ook, string ccancel, 
		     string icon = PICS EXCICON POP) {
    message * m = message::create();
    m->below = bbelow;
    m->posy = posy;
    m->title = icon + WHITE " " + ttitle;
    m->ok = ook;
    m->cancel = ccancel;
    
    bool x = m->ask();
    m->destroy();
    return x;
  }

  static bool bug(drawable * bbelow, string ttitle) {
    message * m = message::create();
    m->below = bbelow;
    m->posy = -1;
    m->title = PICS BUGICON POP RED " BUG: " POP WHITE + ttitle;
    m->ok = RED "I'll file a bug report!" POP;
    m->cancel = "";
    
    bool x = m->ask();
    m->destroy();
    return x;
  }

  static bool no(drawable * bbelow, string ttitle) {
    message * m = message::create();
    m->below = bbelow;
    m->posy = -1;
    m->title = PICS XICON POP WHITE " " + ttitle;
    m->ok = "OK";
    m->cancel = "";
    
    bool x = m->ask();
    m->destroy();
    return x;
  }

};

#endif
