
#include "font.h"
#include "extent.h"

enum attr { COLOR, ALPHA, };

struct font_attrlist {
  attr what;
  int value;

  font_attrlist * next;

  font_attrlist(attr w, int h, font_attrlist * n) : what(w), value(h), next(n) {}

  static void set(font_attrlist * cs, int & c, int & a) {
    if (!cs) {
      c = 0;
      a = 0;
    } else {
      switch(cs->what) {
      case COLOR: c = cs->value; break;
      case ALPHA: a = cs->value; break;
      }
    }
  }

  static int pop(font_attrlist *& il) {
    if (il) {
      font_attrlist * tmp = il;
      int t = tmp->value;
      il = il->next;
      delete tmp;
      return t;
    } else return 0;
  }

};

struct fontreal : public font {

  /* data is an array of font images, differing in
     their alpha transparency */
  SDL_Surface ** data;
  int ndim;

  unsigned char chars[255];

  /* 9 x 16 */
  static fontreal * create(string file,
			   string charmap,
			   int width,
			   int height,
			   int styles=1,
			   int overlap=0,
			   int ndim_=2);
  virtual int sizex(const string &);

  virtual void draw(int x, int y, string s);
  virtual void drawto(SDL_Surface *, int x, int y, string s);

  virtual void destroy() {
    if (data) {
      for(int i = 0; i < ndim; i ++) {
	if (data[i]) SDL_FreeSurface(data[i]);
      }
      free (data);
    }
    delete this;
  }

  virtual int drawlines(int x, int y, string);

  virtual ~fontreal();
};

font::~font() {}
fontreal::~fontreal() {}

font * font::create(string f, string c,
		    int w, int h, int s, int o, int d) {
  return fontreal::create(f, c, w, h, s, o, d);
}

fontreal * fontreal::create (string file,
			     string charmap,
			     int width,
			     int height,
			     int styles,
			     int overlap,
			     int ndim) {

  fontreal * f = new fontreal();
  if (!f) return 0;
  extent<fontreal> fe(f);
  f->width = width;
  f->height = height;
  f->styles = styles;
  f->overlap = overlap;
  f->data = 0;
  f->ndim = ndim;

  if (!ndim) return 0;

  f->data = (SDL_Surface **)malloc(sizeof (SDL_Surface *) * ndim);
  if (!f->data) return 0;
  for(int z = 0; z < ndim; z++) f->data[z] = 0;

  f->data[0] = sdlutil::imgload(file.c_str());
  if (!f->data[0]) return 0;

  int last = 0;
  while(last < (ndim - 1)) {
    last ++;
    f->data[last] = sdlutil::alphadim(f->data[last - 1]);
    if (!f->data[last]) return 0;
  }

  for(int j = 0; j < 255; j ++) {
    f->chars[j] = 0;
  }

  for(unsigned int i = 0; i < charmap.length (); i ++) {
    int idx = (unsigned char)charmap[i];
    f->chars[idx] = i;
  }

  fe.release ();
  return f;
}

void fontreal::draw(int x, int y, string s) {
  drawto(screen, x, y, s);
}

void fontreal::drawto(SDL_Surface * surf, int x, int y, string s) {

  SDL_Rect src, dest;

  /* XXX can't init these once, since blit can side-effect fields
     (try drawing off the screen) */
  dest.x = x;
  dest.y = y;

  src.w = width;
  src.h = height;

  /* keep track of our color and alpha settings */
  font_attrlist * cstack = 0; 
  int color, alpha;
  font_attrlist::set(cstack, color, alpha);

  for(unsigned int i = 0; i < s.length(); i ++) {

    if ((unsigned char)s[i] == '^') {
      if (i < s.length()) {
	i++;
	switch((unsigned char)s[i]) {
	case '^': break; /* quoted... keep going */
	case '<': /* pop */
	  if (cstack) font_attrlist::pop(cstack);
	  font_attrlist::set(cstack, color, alpha);
	  continue;
	default:
	  if (s[i] >= '#' && s[i] <= '\'') {
	    /* alpha */
	    cstack =
	      new font_attrlist(ALPHA,
				abs((unsigned char)s[i] - '#') % ndim,
				cstack);
	  } else {
	    /* color */
	    cstack = 
	      new font_attrlist(COLOR,
				abs(((unsigned char)s[i] - '0')
				    % styles),
				cstack);
	  }

	  font_attrlist::set(cstack, color, alpha);
	  continue;
	}
      }
    }

    /* current color */

    int idx = (unsigned char)s[i];
    src.x = chars[idx] * width;
    src.y = color * height;
  
    SDL_BlitSurface(data[alpha], &src, surf, &dest);

    dest.x += (width - overlap);
  }

  /* empty list */
  while(cstack) font_attrlist::pop(cstack);

}

int fontreal::sizex(const string & s) {

  int sz = 0;

  for(unsigned int i = 0; i < s.length(); i ++) {

    if ((unsigned char)s[i] == '^') {
      if (i < s.length()) {
	i++;
	if ((unsigned char)s[i] != '^') continue;
      }
    }
    sz += (width - overlap);
  }  

  return sz;
}

/* XXX doesn't handle color codes that span lines. */
int fontreal::drawlines(int x, int y, string s) {
  
  int start = 0;
  unsigned int idx = 0;
  /* draw every non-empty string delimited by \n */
  int offset = 0;
  int wroteany = 0;
  for(;;idx ++) {
  again:;
    if (idx >= s.length()) {
      if (wroteany) {
	draw(x, y + offset,
	     s.substr(start, idx - start));
	return offset + height;
      } else return offset;
    }
     
    if (s[idx] == '\n') {
      draw(x, y + offset,
	   s.substr(start, idx - start));
      offset += height;
      start = idx + 1;
      idx = idx + 1;
      wroteany = 0;
      goto again;
    } else wroteany = 1;
  }
}

/* by example:
   "" returns 0
   "\n" returns 1
   "hello" returns 1
   "hello\n" returns 1
   "hello\nworld" returns 2
   "hello\nworld\n" returns 2
*/
int font::lines(const string & s) {
  unsigned int idx = 0;
  int sofar = 0;

  enum mode { M_FINDANY, M_STEADY, };

  mode m = M_FINDANY;

  for(;;idx++) {
    if (idx >= s.length()) return sofar;
    switch(m) {
    case M_FINDANY:
      if (s[idx] == '\n') {
	sofar++;
	continue;
      } else {
	sofar++;
	m = M_STEADY;
	continue;
      }
    case M_STEADY:
      if (s[idx] == '\n') {
	m = M_FINDANY;
	continue;
      }
    }
  }
}

/* assume n <= s.length() */
string font::prefix(string s, unsigned int n) {
  unsigned int i = 0;
  unsigned int j = 0;

  for(; i < s.length() && j < n; i ++) {

    if ((unsigned char)s[i] == '^') {
      if (i < s.length()) {
	i++;
	if ((unsigned char)s[i] == '^') j++;
      } else j ++; /* ??? */
    } else j ++;

  }
  return s.substr(0, i);
}

unsigned int font::length(string s) {
  unsigned int i, n=0;
  for(i = 0; i < s.length(); i ++) {
    if ((unsigned char)s[i] == '^') {
      if (i < s.length()) {
	i++;
	if ((unsigned char)s[i] == '^') n++;
      } else n ++; /* ??? */
    } else n ++;
  }
  return n;
}

/* XXX should go to fontutil */
#include "chars.h"
string font::pad(string s, int ns) {
  unsigned int l = font::length(s);
    
  unsigned int n = abs(ns);

  if (l > n) {
    return font::prefix(s, n - 3) + (string)ALPHA50 "..." POP;
  } else {
    string ou;
    /* PERF there's definitely a faster way to do this */
    for(unsigned int j = 0; j < (n - l); j ++) ou += " ";
    if (ns > 0) {
      return s + ou;
    } else {
      return ou + s;
    }
  }
}

string font::truncate(string s, unsigned int n) {
  unsigned int l = font::length(s);
    
  if (l > n) {
    return font::prefix(s, n - 3) + (string)ALPHA50 "..." POP;
  } else return s;

}
