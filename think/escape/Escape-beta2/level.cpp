
#include "level.h"
#include <assert.h>
#include "extent.h"

/* This code is non-SDL, so it
   should be portable! */

string solution::tostring () {
  return sizes(length) + level::rleencode(length, (int*)dirs);
}

solution * solution::fromstring(string s) {

  unsigned int idx = 0;
  if (s.length () < 4) return 0;
  int len = shout(4, s, idx);

  dir * dd = level::rledecode(s, idx, len);

  if (!dd) return 0;

  solution * sol = new solution();

  sol->allocated = 
    sol->length = len;

  sol->dirs = dd;
  sol->verified = false;

  return sol;
}

/* Return true if a laser can 'see' the player.
   set tilex,y to that laser, d to the direction it
   fires in. */
/* also now checks for cohabitation with bots, which
   is deadly */
bool level::isdead(int & tilex, int & tiley, dir & d) {
  
  /* are we in the same square as a bot? Then we die. */
  if (botat(guyx, guyy)) {
    tilex = guyx;
    tiley = guyy;
    d = DIR_NONE;
    return true;
  }

  /* no? look for lasers. the easiest way is to look 
     for lasers from the current dude outward. */
  
  for(dir dd = FIRST_DIR; dd <= LAST_DIR; dd ++) {
    int lx = guyx, ly = guyy;

    while (travel(lx, ly, dd, lx, ly)) {
      if (tileat(lx, ly) == T_LASER) {
	tilex = lx;
	tiley = ly;
	d = dir_reverse(dd);
	return true;
      }
      int tt = tileat(lx, ly);
      if (tt != T_FLOOR &&
	  tt != T_ELECTRIC &&
	  tt != T_ROUGH &&
	  tt != T_RDOWN &&
	  tt != T_GDOWN &&
	  tt != T_BDOWN &&
	  tt != T_TRAP2 &&
	  tt != T_TRAP1 &&
	  tt != T_PANEL &&
	  tt != T_BPANEL &&
	  tt != T_GPANEL &&
	  tt != T_RPANEL &&
	  tt != T_BLACK &&
	  tt != T_HOLE) break;
      /* all robots also block lasers. */
      if (botat(lx, ly)) break;
    }
  }

  return false;
}


void level::swapo(int idx) {
  int tmp = tiles[idx];
  tiles[idx] = otiles[idx];
  otiles[idx] = tmp;

  /* swap haspanel/opanel and their refinements as well */
  flags[idx] = 
    
    /* panel bits */
    ((flags[idx]&TF_HASPANEL) ? TF_OPANEL : TF_NONE) |
    ((flags[idx]&TF_OPANEL) ? TF_HASPANEL : TF_NONE) |

    /* refinement */
    ((flags[idx]&TF_RPANELL) ? TF_ROPANELL : TF_NONE) |
    ((flags[idx]&TF_RPANELH) ? TF_ROPANELH : TF_NONE) |

    /* orefinement */
    ((flags[idx]&TF_ROPANELL) ? TF_RPANELL : TF_NONE) |
    ((flags[idx]&TF_ROPANELH) ? TF_RPANELH : TF_NONE) |

    /* erase old */
    (flags[idx] & ~(TF_HASPANEL | TF_OPANEL |
		    TF_RPANELL | TF_RPANELH |
		    TF_ROPANELL | TF_ROPANELH));
}


static tile realpanel(int f) {
  if (f & TF_RPANELH) {
    if (f & TF_RPANELL) return T_RPANEL;
    else return T_GPANEL;
  } else {
    if (f & TF_RPANELL) return T_BPANEL;
    else return T_PANEL;
  }
}

bool level::issphere(int t) {
  return (t == T_SPHERE ||
	  t == T_RSPHERE ||
	  t == T_GSPHERE ||
	  t == T_BSPHERE);
}

bool level::issteel(int t) {
  return (t == T_STEEL ||
	  t == T_RSTEEL ||
	  t == T_GSTEEL ||
	  t == T_BSTEEL);
}

bool level::ispanel(int t) {
  return (t == T_PANEL ||
	  t == T_RPANEL ||
	  t == T_GPANEL ||
	  t == T_BPANEL);
}

bool level::triggers(int tile, int panel) {
  /* "anything" triggers grey panels */
  if (panel == T_PANEL) return true;
  if (panel == T_RPANEL) {
    return tile == T_RSPHERE || tile == T_RSTEEL;
  }
  if (panel == T_GPANEL) {
    return tile == T_GSPHERE || tile == T_GSTEEL;
  }
  if (panel == T_BPANEL) {
    return tile == T_BSPHERE || tile == T_BSTEEL;
  }
  /* ? */
  return false;
}


/* two copies of the move function */
#undef  ANIMATING_MOVE
#include "move.h"

#ifndef NOANIMATION
# define ANIMATING_MOVE
# include "move.h"
# undef  ANIMATING_MOVE
#endif

/* disambiguation context implementation */
#ifndef NOANIMATION
disamb * disamb::create(level * l) {
  disamb * d = new disamb();
  if (!d) return 0;
  d->w = l->w;
  d->h = l->h;
  d->map = (unsigned int *)malloc(d->w * d->h * sizeof(unsigned int));
  if (!d->map) return 0;
  d->clear();
  return d;
}

void disamb::destroy() {
  free(map);
  delete this;
}

void disamb::clear() {
  serial = 1;
  player = 0; /* or 0? */
  {
    for(int i = 0; i < LEVEL_MAX_ROBOTS; i++) {
      bots[i] = 0; /* 0? */
    }
  }
  
  {
    for(int i = 0; i < (w * h); i ++) {
      map[i] = 0;
    }
  }
}

void disamb::affect(int x, int y, level * l, ptrlist<aevent> **& etail) {
  affecti(y * w + x, l, etail);
}

void disamb::affecti(int i, level * l, ptrlist<aevent> **& etail) {
  /* was this last updated in this same
     serial? if so, we need to move to
     the next serial. */

  if (map[i] == serial) {
    serialup(l, etail);
  }

  map[i] = serial;
}

# define DIS_PUSHMOVE(type, var)      \
    aevent * a ## var = new aevent;   \
    *etail = new alist(a ## var, 0);  \
    etail = &((*etail)->next);        \
    a ## var->serial = serial;        \
    a ## var->t = tag_ ## type;       \
    type ## _t * var = & (a ## var->u. type);

/* maintain the invariant that in every serial within the list
   etail, there is at least one animation for every active
   entity */
void disamb::serialup(level * l, ptrlist<aevent> **& etail) {

  // printf("serialup!\n");

  if (serial != player) {
    // printf("  (stand player)\n");
    { 
      DIS_PUSHMOVE(stand, e);
      e->x = l->guyx;
      e->y = l->guyy;
      e->d = l->guyd;
      e->entt = B_PLAYER;
    }
    player = serial;
  }

  for(int i = 0; i < l->nbots; i ++) {
    if (l->bott[i] != B_DELETED &&
	bots[i] != serial) {
      // printf("  stand bot %d\n", i);
      { 
	DIS_PUSHMOVE(stand, e);
	l->where(l->boti[i], e->x, e->y);
	e->d = l->botd[i];
	e->entt = l->bott[i];
      }

      bots[i] = serial;
    }
  }

  /* now we can increment the serial */
  serial ++;
}

/* XXX should these also do the same check that affecti does? */
void disamb::affectplayer(level * l, ptrlist<aevent> **& etail) {
  // printf("affectplayer %d -> %d\n", player, serial);
  if (player == serial) serialup(l, etail);
  player = serial;
}

void disamb::affectbot(int i, level * l, ptrlist<aevent> **& etail) {
  // printf("affectbot[%d] %d -> %d\n", i, bots[i], serial);
  if (bots[i] == serial) serialup(l, etail);
  bots[i] = serial;
}

#endif


#define FSDEBUG if (0)


/* nb: assumes reasonable dimensions, at least.
   should instead create empty level if the dimensions
   are that crazy/nonpositive
*/
bool level::sanitize() {
  bool was_sane = true;
  
  int len = w * h;

  {
  for (int i = 0; i < len; i ++) {
    
    /* a destination outside the level */
    if (dests[i] >= len) {
      FSDEBUG printf("insane: dest out of range: %d\n", dests[i]);
      was_sane = false;
      dests[i] = 0;
    }

    /* an illegal tile */
    if (tiles[i] >= NUM_TILES || tiles[i] < 0) {
      FSDEBUG printf("insane: bad tile: %d\n", tiles[i]);
      was_sane = false;
      tiles[i] = T_BLACK;
    }

    if (otiles[i] >= NUM_TILES || tiles[i] < 0) {
      FSDEBUG printf("insane: bad otile: %d\n", otiles[i]);
      was_sane = false;
      otiles[i] = T_BLACK;
    }

    /* FIXME: also flags */
  }
  }


  /* staring position outside the level */
  if (guyx >= w) { was_sane = false; guyx = w - 1; }
  if (guyy >= h) { was_sane = false; guyy = h - 1; }

  if (guyx < 0) { was_sane = false; guyx = 0; }
  if (guyy < 0) { was_sane = false; guyy = 0; }

  /* bots */
  {
    for(int i = 0; i < nbots; i++) {
      int x, y;
      where(boti[i], x, y);
      /* sort of crummy, since it puts all bad bots
	 on top of one another */
      if (x >= w || x < 0 || y >= h || y < 0)
	{ was_sane = false; boti[i] = 0; }
      
      if (bott[i] >= NUM_ROBOTS || bott[i] < 0) 
	{ was_sane = false; bott[i] = B_DALEK; }
    }
  }

  return was_sane;
}

level * level::fromstring(string s, bool allow_corrupted) {

  int sw, sh;

  /* check magic! */
  if (s.substr(0, ((string)LEVELMAGIC).length()) != LEVELMAGIC) return 0;

  
  FSDEBUG printf("magic ok...");

  unsigned int idx = ((string)LEVELMAGIC).length();

  if (idx + 12 > s.length()) return 0;
  sw = shout(4, s, idx);
  sh = shout(4, s, idx);

  FSDEBUG printf("%d x %d...\n", sw, sh);

  /* too big? */
  if (sw > LEVEL_MAX_WIDTH  || sw < 0 ||
      sh > LEVEL_MAX_HEIGHT || sh < 0 ||
      (sw * sh) > LEVEL_MAX_AREA) return 0;

  int ts = shout(4, s, idx);
  if (idx + ts > s.length()) return 0;
  string title = s.substr(idx, ts);

  idx += ts;

  if (idx + 4 > s.length()) return 0;
  int as = shout(4, s, idx);

  if (idx + as > s.length()) return 0;
  string author = s.substr(idx, as);

  idx += as;

  FSDEBUG printf("\"%s\" by \"%s\"...\n", title.c_str(), author.c_str());

  if (idx + 8 > s.length()) return 0;

  int gx = shout(4, s, idx);
  int gy = shout(4, s, idx);

  FSDEBUG printf("guy: %d,%d\n", gx, gy);

  /* at this point we will be able to return some kind of
     level, even if parts are corrupted */

  level * l = new level();
  l->w = sw;
  l->h = sh;

  l->corrupted = false; /* may change later */

  l->title = title;
  l->author = author;
  l->guyx = gx;
  l->guyy = gy;
  l->guyd = DIR_DOWN;
  
  FSDEBUG printf("tiles = rledecode(s, %d, %d)\n", idx, sw * sh);

  l->tiles  = rledecode(s, idx, sw * sh);

  FSDEBUG printf("result %p. now idx is %d\n", l->tiles, idx);

  l->otiles = rledecode(s, idx, sw * sh);
  l->dests  = rledecode(s, idx, sw * sh);
  l->flags  = rledecode(s, idx, sw * sh);

  if (idx + 4 > s.length()) {
    l->nbots = 0;
    l->boti = 0;
    l->bott = 0;
    l->botd = 0;
  } else {
    l->nbots = shout(4, s, idx);
    if (l->nbots < 0 ||
	l->nbots > LEVEL_MAX_ROBOTS) {
      l->nbots = 0;
      // l->corrupted = true;
      /* probably the reading frame is off
	 now, but what can we do when given
	 a ridiculous file? */
    }

    l->boti = rledecode(s, idx, l->nbots);
    l->bott = (bot*)rledecode(s, idx, l->nbots);

    /* presentational */
    l->botd = (dir*)malloc(l->nbots * sizeof(dir));
    for(int i = 0; i < l->nbots; i++) l->botd[i] = DIR_DOWN;
  }

  /* XXX support messages here. */


  if (l->tiles && l->otiles && l->dests && l->flags) {
    
    /* check level's sanity, one last time */
    l->corrupted = (!l->sanitize()) || l->corrupted;

    if (!l->corrupted || allow_corrupted) {
      FSDEBUG printf("success\n");
      return l;
    } else {
      l->destroy();
      return 0;
    }

  } else if (l->tiles && allow_corrupted) {
    /* for anything not found, replace with empty */
    if (!l->otiles) {
      l->otiles = (int*)malloc(sw * sh * sizeof (int));
      if (l->otiles) memset(l->otiles, 0, sw * sh * sizeof (int));
    }
  
    if (!l->dests) {
      l->dests = (int*)malloc(sw * sh * sizeof (int));
      if (l->dests) memset(l->dests, 0, sw * sh * sizeof (int));
    }

    if (!l->flags) {
      l->flags = (int*)malloc(sw * sh * sizeof (int));
      if (l->flags) memset(l->flags, 0, sw * sh * sizeof (int));
    }

    if (l->otiles && l->dests && l->flags) {
      l->sanitize();
      l->corrupted = true;
      return l;
    } else {
      /* out of memory? */
      l->destroy ();
      return 0;
    }

  } else {
    l->destroy();
    return 0;
  }
}



/* RLE compression of integer arrays.

   The first byte says how many bits are used to represent
   integers. 

   We can use any number of bits (0..32), with the following
   encoding:
   
   high bit 1: byte & 0b00111111 gives the bit count, which
               must be <= 32.

   high bit 0: then bit count is byte * 8.	       
     (this is for backwards compatibility with
      the old byte-based scheme)

   If the bit count is zero, then only the integer zero can
   be represented, and it is represented by the empty bit
   string.

   If the first and second highest bits are set, then the next 5 bits
   give us the number of bits we use to read frame headers (called
   'framebits' below). Otherwise, this value is assumed to be 8.

   Then, we have repeating frames to generate the expected
   number of ints.

   A frame is:

      framebits bits representing a run count 1-255, followed by an
      integer (written with some number of bits, depending on the
      count above) which means 'count' copies of the integer. The idea
      is that we can compress runs of equal values.

      or

      framebits of 0, followed by framebits bits giving an anti-run
      count 1-255, then 'count' integers each encoded as above. The
      idea here is to avoid counts of '1' when the values are
      continually different.
   
*/

/* idx a starting position (measured in bytes) in 'string' for the
   rle-encoded data, which is modified to point to the next byte after
   the data if the call is successful. n is the number of integers we
   sould expect out. */
int * level::rledecode(string s, unsigned int & idx_bytes, int n) {
  int * out = (int*)malloc(n * sizeof (int));
  int idx = idx_bytes * 8;

  if (!out) return 0;
  extentf<int> eo(out);

  /* number of bytes used to represent one integer. */
  unsigned int bytecount;
  if (!bitbuffer::nbits(s, 8, idx, bytecount)) return 0;
  int bits;
  
  unsigned int framebits = 8;
  if (bytecount & 128) {
    if (bytecount & 64) {
      if (!bitbuffer::nbits(s, 5, idx, framebits)) return 0;
    }
    bits = bytecount & 63;
  } else {
    if (bytecount > 4) { 
      printf ("Bad file bytecount %d\n", bytecount);
      return 0;
    }
    bits = bytecount * 8;
  }

  /* printf("bit count: %d\n", bits); */

  unsigned int run;
 
  /* out index */
  int oi = 0; 

  while (oi < n) {
    if (!bitbuffer::nbits(s, framebits, idx, run)) return 0;

    /* printf("[%d] run: %d\n", idx, run); */
    if (run == 0) {
      /* anti-run */
      if (!bitbuffer::nbits(s, framebits, idx, run)) return 0;

      /* printf("  .. [%d] anti %d\n", idx, run); */
      for(unsigned int m = 0; m < run; m ++) {
	unsigned int ch;
	if (!bitbuffer::nbits(s, bits, idx, ch)) return 0;
	if (oi >= n) return 0;
	out[oi++] = ch;
      }
    } else {
      unsigned int ch;
      if (!bitbuffer::nbits(s, bits, idx, ch)) return 0;

      for (unsigned int m = 0; m < run; m ++) {
	if (oi >= n) return 0;
	out[oi++] = ch;
      }
    }
  }
  eo.release ();
  idx_bytes = bitbuffer::ceil(idx);
  return out;
}

/* encode n ints in 'a', and return it as a string.
   This uses a greedy strategy that is probably not
   optimal.

   XXX this can be more efficient by using a reduced
   number of bits to write frame headers. There is
   already support for this in rledecode
*/
string level::rleencode(int n, int a[]) {
  int max = 0;
  for(int j = 0; j < n; j ++) {
    if (a[j] > max) max = a[j];
  }

  /* how many bytes to write a single item? 
     (see the discussion at rleencode)

     We avoid using "real" compression schemes
     (such as Huffman encoding) because the 
     overhead of dictionaries can often dwarf
     the size of what we're encoding (ie,
     200 move solutions).

  */

  int bits = 0;

  {
    unsigned int shift = max;
    for(int i = 0; i <= 32; i ++) {
      if (shift & 1) bits = i + 1;
      shift >>= 1;
    }
  }

  /* printf("bits needed: %d\n", bits); */

  bitbuffer ou;
  
  /* new format has high bit set (see rledecode) */
  ou.writebits(8, bits | 128);

  enum { 
    /* back == front */
    NOTHING,
    /* back points to beginning of run */
    RUN,
    /* back points to beginning of antirun */
    ANTIRUN,
    /* back points to char, front to next... */
    CHAR,
    /* done, exit on next loop */
    EXIT,
  };

  int mode = NOTHING;
  int back = 0, front = 0;

  while(mode != EXIT) {
    
    switch(mode) {
    case NOTHING:
      assert(back == front);

      if (front >= n) mode = EXIT; /* done, no backlog */
      else {
	mode = CHAR;
	front++;
      }
      break;
    case CHAR:
      assert(back == (front-1));

      if (front >= n) {
	/* write a single character */
	ou.writebits(8, 1);
	ou.writebits(bits, a[back]);
	mode = EXIT;
      } else {
	if (a[front] == a[back]) {
	  /* start run */
	  mode = RUN;
	  front ++;
	} else {
	  /* start antirun */
	  mode = ANTIRUN;
	  front ++;
	}
      }
      break;
    case RUN:
      
      assert((front - back) >= 2);
      /* from back to front should be same char */

      if (front >= n || a[front] != a[back]) {
	/* write run. */
	while ((front - back) > 0) {
	  int x = front - back;
	  if (x > 255) x = 255;

	  ou.writebits(8, x);
	  ou.writebits(bits, a[back]);

	  back += x;
	}
	if (front >= n) mode = EXIT;
	else mode = NOTHING;
      } else front++;

      break;
    case ANTIRUN:
      assert((front - back) >= 2);

      if (front >= n ||
	  ((front - back) >= 3 &&
	   (a[front] ==
	    a[front - 1]) &&
	   (a[front] == 
	    a[front - 2]))) {


	if (front >= n) {
	  /* will write tail anti-run below */
	  mode = EXIT;
	} else {
	  /* must be here because we saw a run of 3.
	     we don't want to include this
	     run in the anti-run */
	  front -= 2;
	  /* after writing anti-run, we will
	     be with back = front and in 
	     NOTHING state, but we will
	     detect a run. */
	  mode = NOTHING;
	}

	/* write anti-run, unless
	   there's just one character */
	while ((front - back) > 0) {
	  int x = front - back;
	  if (x > 255) x = 255;
	  
	  if (x == 1) {
	    ou.writebits(8, 1);
	    ou.writebits(bits, a[back]);

	    back++;
	  } else {
	    ou.writebits(8, 0);
	    ou.writebits(8, x);
	    
	    while(x--) {
	      ou.writebits(bits, a[back]);
	      back++;
	    }
	  }
	}
	break;
      } else front++;
    }
  }

  return ou.getstring();
}

string level::tostring() {

  string ou;

  /* magic */
  ou += (string)LEVELMAGIC;

  ou += sizes(w);
  ou += sizes(h);

  ou += sizes(title.length());
  ou += title;

  ou += sizes(author.length());
  ou += author;

  ou += sizes(guyx);
  ou += sizes(guyy);

  ou += rleencode(w * h, tiles);
  ou += rleencode(w * h, otiles);
  ou += rleencode(w * h, dests);
  ou += rleencode(w * h, flags);

  ou += sizes(nbots);
  ou += rleencode(nbots, boti);
  ou += rleencode(nbots, (int*)bott);
  return ou;
}

/* deprecated */
int level::newtile(int old) {
  switch(old) {
  case 0x0b: return T_STOP;
  case 0x0c: return T_RIGHT;
  case 0x0d: return T_LEFT;
  case 0x0e: return T_UP;
  case 0x0f: return T_DOWN;
  case 0x1A: return T_NS;
  case 0x1B: return T_NE;
  case 0x1C: return T_NW;
  case 0x1D: return T_SE;
  case 0x1E: return T_SW;
  case 0x1F: return T_WE;
  case 0x21: return T_BLIGHT;
  case 0x22: return T_RLIGHT;
  case 0x23: return T_GLIGHT;
  case 0x24: return T_BUP;
  case 0x25: return T_BDOWN;
  case 0x26: return T_RUP;
  case 0x27: return T_RDOWN;
  case 0x28: return T_GUP;
  case 0x29: return T_GDOWN;
  case 10: return T_PANEL;
  case 16: return T_ROUGH;
  case 17: return T_ELECTRIC;
  case 18: return T_ON;
  case 19: return T_OFF;
  case 1: return T_FLOOR;
  case 20: return T_TRANSPORT;
  case 21: return T_BROKEN;
  case 22: return T_LR;
  case 23: return T_UD;
  case 24: return T_0;
  case 25: return T_1;
  case 2: return T_RED;
  case 32: return T_BUTTON;
  case 3: return T_BLUE;
  case 4: return T_GREY;
  case 5: return T_GREEN;
  case 6: return T_EXIT;
  case 7: return T_HOLE;
  case 8: return T_GOLD;
  case 0x9: return T_LASER;
  default: return T_STOP; /* ? */
  }
}

/* deprecated */
level * level::fromoldstring(string s) {
  if (s.length() != 567) return 0;

  level * n = level::blank(18, 10);

  for(int i = 0; i < 180; i ++) {
    n->tiles[i] = level::newtile(s[i]);
    /* only regular panels */
    if (n->tiles[i] == T_PANEL)
      n->flags[i] = TF_HASPANEL;
    /* else already 0 */
  }

  /* otiles always floor */

  for(int j = 0; j < 180; j ++) {
    n->dests[j] = 18 * (-1 + (int)s[j+180+180]) + (-1 + (int)s[j+180]);
  }

  n->guyx = s[180+180+180] - 1;
  n->guyy = s[180+180+180+1] - 1;
  n->guyd = DIR_DOWN;

  n->title = s.substr(180+180+180+2, 25);

  /* chop trailing spaces from author */
  int v;
  for(v = n->title.length() - 1; v >= 0; v --) {
    if (n->title[v] != ' ') break;
  }
  n->title = n->title.substr(0, v + 1);

  n->author = "imported";

  n->sanitize();

  return n;
}

void level::destroy() {
  free(tiles);
  free(otiles);
  free(dests);
  free(flags);

  free(boti);
  free(bott);
  free(botd);
  delete this;
}

level * level::clone() {

  level * n = new level();

  n->title = title;
  n->author = author;

  n->corrupted = corrupted;

  n->h = h;
  n->w = w;
  n->guyx = guyx;
  n->guyy = guyy;
  n->guyd = guyd;

  int bytes = w * h * sizeof(int);

  n->tiles  = (int*)malloc(bytes);
  n->otiles = (int*)malloc(bytes);
  n->dests  = (int*)malloc(bytes);
  n->flags  = (int*)malloc(bytes);

  memcpy(n->tiles,  tiles,  bytes);
  memcpy(n->otiles, otiles, bytes);
  memcpy(n->dests,  dests,  bytes);
  memcpy(n->flags,  flags,  bytes);

  n->nbots = nbots;
  int bbytes = nbots * sizeof(int);
  n->boti = (int*)malloc(bbytes);
  n->bott = (bot*)malloc(bbytes);
  n->botd = (dir*)malloc(bbytes);
  
  memcpy(n->boti, boti, bbytes);
  memcpy(n->bott, bott, bbytes);
  memcpy(n->botd, botd, bbytes);

  return n;
}

level * level::blank(int w, int h) {
  level * n = new level();
  n->w = w;
  n->h = h;
  n->guyx = 1;
  n->guyy = 1;
  n->guyd = DIR_DOWN;

  n->corrupted = false;

  int bytes = w * h * sizeof(int);

  n->tiles  = (int*)malloc(bytes);
  n->otiles = (int*)malloc(bytes);
  n->dests  = (int*)malloc(bytes);
  n->flags  = (int*)malloc(bytes);

  /* no bots, no allocation */
  n->nbots  = 0;
  n->boti   = 0;
  n->bott   = 0;
  n->botd   = 0;

  for(int i = 0; i < w * h; i ++) {
    n->tiles[i]  = T_FLOOR;
    n->otiles[i] = T_FLOOR;
    n->dests[i]  = 0; /* 0,0 */
    n->flags[i]  = 0;
  }
  
  return n;
}

level * level::defboard(int w, int h) {
  level * n = blank(w, h);

  /* just draw blue around it. */

  /* top, bottom */
  for(int i = 0; i < w; i++) {
    n->tiles[i] = T_BLUE;
    n->tiles[(h-1) * w + i] = T_BLUE;
  }

  /* left, right */
  for(int j = 0; j < h; j++) {
    n->tiles[j * w] = T_BLUE;
    n->tiles[j * w + (w-1)] = T_BLUE;
  }

  return n;
}

bool level::verify(level * lev, solution * s) {
  level * l = lev->clone ();

  bool won = l->play(s);

  l->destroy();

  return won;
}

bool level::play(solution * s) {
  for(solution::iter i = solution::iter(s);
      i.hasnext();
      i.next()) {
   
    dir d = i.item ();
    
    if (move(d)) {
      /* potentially fail *after* each move */
      int dummy; dir dumb;
      if (isdead(dummy, dummy, dumb)) return false;
      if (iswon()) return true;
    }
    /* else perhaps a 'strict' mode where this
       solution is rejected */
  }
  /* solution is over, but we didn't win or die */
  return false;
}

/* must be called with sensible sizes (so that malloc won't fail) */
void level::resize(int neww, int newh) {

  int bytes = neww * newh * sizeof(int);

  int * nt, * no, * nd, * nf;

  nt = (int *)malloc(bytes);
  no = (int *)malloc(bytes);
  nd = (int *)malloc(bytes);
  nf = (int *)malloc(bytes);

  for(int x = 0; x < neww; x ++)
    for(int y = 0; y < newh; y ++) {

      if (x < w && y < h) {
	nt[y * neww + x] = tiles[y * w + x];
	no[y * neww + x] = otiles[y * w + x];
	nf[y * neww + x] = flags[y * w + x];

	/* set dests to point to the same place in
	   the new level, if possible. otherwise
	   just point it to 0,0 */
	int odx = dests[y * w + x] % w;
	int ody = dests[y * w + x] / w;
	if (odx < neww && ody < newh && odx >= 0 && ody >= 0) {
	  nd[y * neww + x] = odx + (ody * neww);
	} else {
	  nd[y * neww + x] = 0;
	}
      } else {
	nt[y * neww + x] = T_FLOOR;
	no[y * neww + x] = T_FLOOR;
	nd[y * neww + x] = 0;
	nf[y * neww + x] = 0;
      }

    }

  /* put bots back in level  */
  {
    int bi = 0;
    for(int b = 0; b < nbots; b++) {
      int bx, by;
      where(boti[b], bx, by);
      if (bx < neww && bx >= 0 &&
	  by < newh && by >= 0) {
	/* keep bot */
	boti[bi] = by * neww + bx;
	bott[bi] = bott[b];
	botd[bi] = botd[b];
	bi ++;
      }
    }
    nbots = bi;

  }

  free(tiles);
  free(otiles);
  free(dests);
  free(flags);

  tiles = nt;
  otiles = no;
  dests = nd;
  flags = nf;

  w = neww;
  h = newh;

  /* sanitization moves the guy back on the board,
     as well as making any destinations point within
     the level */
  sanitize();

}
