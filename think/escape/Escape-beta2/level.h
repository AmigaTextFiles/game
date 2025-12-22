
#ifndef __LEVEL_H
#define __LEVEL_H

#include <string>

using namespace std;

#define LEVELMAGIC "ESXL"

#define LEVEL_MAX_HEIGHT 100
#define LEVEL_MAX_WIDTH  100
#define LEVEL_MAX_AREA   2048
#define LEVEL_MAX_ROBOTS 9

/* XXX we probably aren't going to support
   multiple different player characters */
enum whichguy {
  GUY_OFFICE,
};

typedef int dir;

enum {
  DIR_NONE, DIR_UP, DIR_DOWN, DIR_LEFT, DIR_RIGHT,
};

#define FIRST_DIR DIR_UP
#define LAST_DIR DIR_RIGHT

inline dir turnleft(dir d) {
  switch(d) {
  case DIR_UP: return DIR_LEFT;
  case DIR_DOWN: return DIR_RIGHT;
  case DIR_RIGHT: return DIR_UP;
  case DIR_LEFT: return DIR_DOWN;
  default:
  case DIR_NONE: return DIR_NONE; /* ? */
  }
}

inline dir turnright(dir d) {
  switch(d) {
  case DIR_UP: return DIR_RIGHT;
  case DIR_DOWN: return DIR_LEFT;
  case DIR_RIGHT: return DIR_DOWN;
  case DIR_LEFT: return DIR_UP;
  default:
  case DIR_NONE: return DIR_NONE; /* ? */
  }
}

inline void dirchange(dir d, int & dx, int & dy) {
  switch(d) {
  case DIR_UP:
    dx = 0;
    dy = -1;
    break;
  case DIR_LEFT:
    dx = -1;
    dy = 0;
    break;
  case DIR_RIGHT:
    dx = 1;
    dy = 0;
    break;
  case DIR_DOWN:
    dx = 0;
    dy = 1;
    break;
  }
}

inline string dirstring(dir d) {
  switch(d) {
  case DIR_UP: return "up";
  case DIR_LEFT: return "left";
  case DIR_RIGHT: return "right";
  case DIR_DOWN: return "down";
  case DIR_NONE: return "none";
  default:
    return "??";
  }
}

inline dir dir_reverse(dir d) {
  switch(d) {
  case DIR_UP: return DIR_DOWN;
  case DIR_LEFT: return DIR_RIGHT;
  case DIR_DOWN: return DIR_UP;
  case DIR_RIGHT: return DIR_LEFT;
  default:
  case DIR_NONE: return DIR_NONE;    
  }
}

/* panel colors */
enum {
  PANEL_REGULAR = 0,
  PANEL_BLUE = 1,
  PANEL_GREEN = 2,
  PANEL_RED = 3,
};

enum tflag {
  TF_NONE = 0, 

  /* panel under tile (ie, pushable block) */
  /* if HASPANEL is set,
     then TF_RPANELH * 2 + TF_RPANELL
     says what kind (see panel colors above) */
  TF_HASPANEL = 1, 

  TF_RPANELL = 4,
  TF_RPANELH = 8,

  /* panel under tile in bizarro world */
  /* same refinement */
  TF_OPANEL = 2,

  TF_ROPANELL = 16,
  TF_ROPANELH = 32,

  /* reserved for various purposes during
     move */
  TF_TEMP = 64,
};

enum tile {
  T_FLOOR, T_RED, T_BLUE, T_GREY, T_GREEN, T_EXIT, T_HOLE, T_GOLD, 
  T_LASER, T_PANEL, T_STOP, T_RIGHT, T_LEFT, T_UP, T_DOWN, T_ROUGH,
  T_ELECTRIC, T_ON, T_OFF, T_TRANSPORT, T_BROKEN, T_LR, T_UD, T_0,
  T_1, T_NS, T_NE, T_NW, T_SE, T_SW, T_WE, T_BUTTON, T_BLIGHT, 
  T_RLIGHT, T_GLIGHT, T_BLACK, T_BUP, T_BDOWN,
  T_RUP, T_RDOWN, T_GUP, T_GDOWN, 
  T_BSPHERE, T_RSPHERE, T_GSPHERE, T_SPHERE,
  T_TRAP2, T_TRAP1,
  
  T_BPANEL, T_RPANEL, T_GPANEL,
  
  T_STEEL, T_BSTEEL, T_RSTEEL, T_GSTEEL, 

  /*
  T_DIRRIGHT, T_DIRUP, T_DIRDOWN, T_DIRLEFT,
  */

  NUM_TILES,
};

enum bot {
  B_BROKEN,
  B_DALEK,
  B_HUGBOT,
  NUM_ROBOTS,

  /* can't place on map, but is used to identify
     the type of an entity in general */
  B_PLAYER = -1,
  /* deleted bots arise from destruction. They
     are invisible and inert. We can't rearrange
     the bot list because their indices are used
     in an essential way as identities. */
  B_DELETED = -2,
};

/* optional, since the Escape server wants to be able to
   validate solutions without knowing anything about
   animation. */
#ifndef NOANIMATION
# include "util.h"
# include "aevent.h"
#endif


/* a solution is just a list of moves */
struct solution {
  int length;
  int allocated;

  /* true if verified in this run of the program. 
     XXX this is a little awkward, since we don't
     have the level that this is purportedly a
     solution for handy. perhaps this should be in
     the player instead. */
  bool verified;
  
  dir * dirs;

  string tostring();

  static solution * fromstring(string s);

  solution * clone() {
    solution * s = new solution();
    s->length = length;
    s->allocated = allocated;
    s->dirs = (dir*) malloc(allocated * sizeof (dir));
    s->verified = verified;
    /* PERF memcpy */
    for(int i = 0; i < length; i ++) {
      s->dirs[i] = dirs[i];
    }
    return s;
  }

  void destroy() {
    free(dirs);
    delete this;
  }

  static solution * empty() {
    solution * s = new solution();
    s->length = 0;
    s->allocated = 32;
    s->dirs = (dir*) malloc(32 * sizeof (dir));
    s->verified = false;
    return s;
  }

  void clear() {
    length = 0;
  }

  void append(dir d) {
    if (length == allocated) {
      dir * tmp = dirs;
      allocated <<= 1;
      dirs = (dir*) malloc(allocated * sizeof (dir));
      memcpy(dirs, tmp, length * sizeof (dir));
      free(tmp);
    }
    dirs[length++] = d;
    verified = false;
  }

  struct iter {
    int pos;
    solution * sol;
  
    iter(solution * s) : pos(0), sol(s) {}
    bool hasnext() { return pos < sol->length; }
    void next() { pos ++; }
    dir item () { return sol->dirs[pos]; }

  };

  void appends(solution * s) {
    for (iter i(s); i.hasnext(); i.next()) {
      append(i.item());
    }
  }


};

#ifndef NOANIMATION
/* disambiguation context.
   used only within animation; keeps track
   of where action has occurred on the
   grid -- if two actions interfere, then
   we serialize them. 
   
   Disambiguation contexts are associated with
   a particular level and cannot be mixed up!
*/
struct disamb {
  /* array of serial numbers. */
  int w, h;
  unsigned int * map;
  
  /* last serial in which the player was updated */
  unsigned int player;
  /* same, bots */
  unsigned int bots[LEVEL_MAX_ROBOTS];

  /* keep track of current serial */
  unsigned int serial;

  static disamb * create(struct level *);
  void destroy();

  /* sets everything to serial 0 */
  void clear();

  /* affect a location. This might
     cause the serial to increase. Call this
     before creating the associated animation. */
  void affect(int x, int y, level * l, ptrlist<aevent> **& etail);
  void affecti(int idx, level * l, ptrlist<aevent> **& etail);

  /* should be paired with calls to 'affect' 
     for the squares that these things live in */
  void affectplayer(level * l, ptrlist<aevent> **& etail);
  void affectbot(int i, level * l, ptrlist<aevent> **& etail);

  void serialup(level * l, ptrlist<aevent> **& etail);

};
#endif


struct level {
  
  string title;
  string author;

  int w;
  int h;

  int guyx;
  int guyy;
  dir guyd;

  /* robots */
  int nbots;
  /* locations (as indices) */
  int * boti;
  bot * bott;
  /* not saved with file; just presentational. putting the player
     direction in drawing just barely works; it should probably
     be here, too. */
  dir * botd;

  /* shown */
  int * tiles;
  /* "other" (tiles swapped into bizarro world by panels) */
  int * otiles;
  /* destinations for transporters and panels (as index into tiles) */
  int * dests;
  /* has a panel (under a pushable block)? etc. */
  int * flags;

  /* true if corrupted on load. never saved */
  bool corrupted;

  bool iscorrupted() {
    return corrupted;
  }

  /* go straight to the target. no animation */
  void warp(int & entx, int & enty, int targx, int targy) {
    int target = tileat(targx, targy);

    checkstepoff(entx, enty);
    entx = targx;
    enty = targy;

    switch(target) {
    case T_PANEL:
      swapo(destat(targx,targy));
      break;
    default:;
    }
  }

  void where(int idx, int & x, int & y) {
    x = idx % w;
    y = idx / w;
  }

  int index(int x, int y) {
    return (y * w) + x;
  }

  int tileat(int x, int y) {
    return tiles[y * w + x];
  }

  int otileat(int x, int y) {
    return otiles[y * w + x];
  }

  void settile(int x, int y, int t) {
    tiles[y * w + x] = t;
  }

  void osettile(int x, int y, int t) {
    otiles[y * w + x] = t;
  }

  void setdest(int x, int y, int xd, int yd) {
    dests[y * w + x] = yd * w + xd;
  }

  int destat(int x, int y) {
    return dests[y * w + x];
  }


  void getdest(int x, int y, int & xd, int & yd) {
    xd = dests[y * w + x] % w;
    yd = dests[y * w + x] / w;
  }

  void swapo(int idx);

  int flagat(int x, int y) {
    return flags[y * w + x];
  }

  void setflag(int x, int y, int f) {
    flags[y * w + x] = f;
  }

  bool iswon() {
    return tileat(guyx, guyy) == T_EXIT;
  }

  bool travel(int x, int y, dir d, int & nx, int & ny) {
    switch(d) {
    case DIR_UP:
      if (y == 0) return false;
      nx = x;
      ny = y - 1;
      break;
    case DIR_DOWN:
      if (y == (h - 1)) return false;
      nx = x;
      ny = y + 1;
      break;
    case DIR_LEFT:
      if (x == 0) return false;
      nx = x - 1;
      ny = y;
      break;
    case DIR_RIGHT:
      if (x == (w - 1)) return false;
      nx = x + 1;
      ny = y;
      break;
    default: return false; /* ?? */
    }
    return true;
  }

  /* shot by laser at (tilex, tiley) in direction (dir) */
  /* XXX now overloaded for bot death. */
  bool isdead(int & tilex, int & tiley, dir & d);

  /* returns true if move had effect. */
  bool move(dir);
  /* pass the entity index, or -1 for the player */
  bool moveent(dir, int enti, unsigned int, int &, int &);

# ifndef NOANIMATION
  /* see animation.h for documentation */
  bool move_animate(dir, disamb * ctx, ptrlist<aevent> *& events);
  bool moveent_animate(dir, int enti, unsigned int, int &, int &, 
		       ptrlist<aevent> *&,
                       disamb * ctx, ptrlist<aevent> **&);
# endif

  /* create clone of current state. */
  level * clone();

  /* writes current state into a string */
  string tostring();

  /* 0 on error. if allow_corrupted is true, it returns a
     valid level with as much data from the original as
     possible (but may still return 0) */
  static level * fromstring(string s, bool allow_corrupted = false);
  
  /* 0 on error */
  static level * fromoldstring(string s);

  static level * blank(int w, int h);
  static level * defboard(int w, int h);

  /* correct a level (bad tiles, bad destinations). returns
     true if the level was already sane. */
  bool sanitize();

  void destroy ();

  /* play to see if it wins, does not
     modify level */
  static bool verify(level * lev, solution * s);

  /* execute solution. returns true if we win at any stage, 
     false otherwise */
  bool play(solution *);

  static int * rledecode(string s, unsigned int & idx, int n);
  static string rleencode(int n, int * a);

  void resize(int neww, int newh);

  static bool issphere(int t);
  static bool issteel(int t);
  static bool ispanel(int t);
  static bool triggers(int tile, int panel);

  /* return the lowest index bot at a specific location
     (if there's one there). We count B_DELETED as not
     a bot. */
  bool botat(int x, int y, int & i) {
    int z = index(x, y);
    for(int m = 0; m < nbots; m ++) {
      if (bott[m] != B_DELETED && boti[m] == z) {
	i = m;
	return true;
      }
    }
    return false;
  }

  bool botat(int x, int y) {
    int dummy;
    return botat(x, y, dummy);
  }

  bool playerat(int x, int y) {
    return ((x == guyx) && (y == guyy));
  }

  private:
  /* solution wants access to rleencoding and decoding */
  friend struct solution;

  void checkstepoff(int, int);
  void checkleavepanel(int, int);
  static int newtile(int old);
  void swaptiles(int t1, int t2);
  void clearflag(int fl) {
    for(int i = 0; i < w * h; i++) {
      flags[i] &= ~fl;
    }
  }
};


#endif
