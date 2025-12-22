
#include "escapex.h"
#include "level.h"
#include "sdlutil.h"
#include "load.h"
#include "md5.h"

#include <string.h>
#include <sys/stat.h>

#include "dirent.h"

#include "extent.h"
#include "dircache.h"
#include "util.h"
#include "chars.h"

#include "message.h"
#include "upload.h"
#include "prompt.h"

#include "commenting.h"

#include "dirindex.h"
#include "optimize.h"
#include "smanage.h"


#ifdef LINUX
/* just used for debugging */
#  include <sys/time.h>
#endif

/* how frequently to make a move in solution playback */
#define LOADFRAME_TICKS 100
#define STEPS_BEFORE_SOL 5

/* how often to show progress */
#define PROGRESS_TICKS 100

/* XXX these color constants depend on byte order, right? */
#define PROGRESS_DONECOLOR 0xFF99CCAA
#define PROGRESS_RESTCOLOR 0xFF555555
#define PROGRESS_BACKCOLOR 0xFF000000

/* XXX rationalize ".." stuff.
   Currently we disallow it completely, which
   seems like a good solution.

   But there is still something strange about entering
   .. from the "root" directory (see TODO)
*/

/* XXX this has gotten pretty big.
   move it to another file */
/* XXX normalize these by pulling
   sizex, sizey, author (at least)
   out of lev */
struct llentry {
  string fname;
  string name;
  string md5;
  int isdir;
  
  string author;
  int sizex;
  int sizey;

  int solved;
  int total;

  bool corrupted;

  /* always owned by player; don't free */
  rating * myrating;
  ratestatus votes;
  int date;
  int speedrecord;

  level * lev;

  static int height() { return fon->height; }
  string display(bool selected);
  void draw(int x, int y, bool sel);
  string convert() { return fname; }
  bool matches(char k);

  ~llentry() { if (lev) lev->destroy(); }
  llentry() { lev = 0; }
  
  static void swap(llentry * l, llentry * r) {
#   define SWAP(t,f) {t f ## _tmp = l->f; l->f = r->f; r->f = f ## _tmp; }
    SWAP(string, md5);
    SWAP(string, fname);
    SWAP(string, name);
    SWAP(int, date);
    SWAP(int, speedrecord);
    SWAP(int, isdir);
    SWAP(string, author);
    SWAP(bool, corrupted);
    SWAP(int, sizex);
    SWAP(int, sizey);
    SWAP(int, solved);
    SWAP(int, total);
    SWAP(level *, lev);
    SWAP(rating *, myrating);
    SWAP(ratestatus, votes);
#   undef SWAP
  }

  string actualfile(stringlist * p) {
    string file = fname;
    stringlist * pathtmp = stringlist::copy(p);
    while (pathtmp) {
      file = stringpop(pathtmp) + 
	     string(DIRSEP) + file;
    }
    return file;
  }

  /* default: directories are first */
  static bool default_dirs(int & ret,
			  const llentry & l,
			  const llentry & r) {

    /* make this appear first */
    if (l.fname == ".." && r.fname != "..") {
      ret = -1; return true; 
    }
    if (l.fname != ".." && r.fname == "..") {
      ret = 1; return true;
    }
  
    /* then directories */
    if (l.isdir && !r.isdir) { ret = -1; return true; }
    if (!l.isdir && r.isdir) { ret = 1; return true; }
    
    /* if one is a dir, both are. sort by
       number of levels first. */
    if (l.isdir) {
      ret = 1;
      if (l.total > r.total) ret = -1;
      if (l.total == r.total) ret = 0; 
      return true;
    }

    return false;

  }

  /* newest first -- only if webindex */
  static int cmp_bydate(const llentry & l,
			const llentry & r) {

    int order;
    if (default_dirs(order, l, r)) return order;
    
    if (l.date > r.date) return -1;
    else if (l.date < r.date) return 1;
    /* or by solved? */
    else return cmp_byname(l, r);
  }

  static int cmp_bysolved(const llentry & l,
			  const llentry & r) {
    int order;
    if (default_dirs(order, l, r)) return order;

    if (l.solved < r.solved) return -1;
    else if (l.solved == r.solved) return cmp_byname(l, r);
    else return 1;

  }

  /* descending sort by personal rating field */
# define MINE(letter, field) \
  static int cmp_bymy ## letter(const llentry & l, \
		                const llentry & r) { \
    int order; \
    if (default_dirs(order, l, r)) return order; \
                                                  \
    int nl = (l.myrating)?(l.myrating-> field):-1; \
    int nr = (r.myrating)?(r.myrating-> field):-1; \
                                                   \
    if (nl < nr) return 1;                         \
    else if (nl == nr) return cmp_byname(l, r);    \
    else return -1;                                \
  }

  MINE(d, difficulty)
  MINE(s, style)
  MINE(r, rigidity)
# undef MINE

  /* descending sort by global rating field */
# define GLOB(letter, field) \
  static int cmp_byglobal ## letter(const llentry & l, \
			            const llentry & r) { \
    int order; \
    if (default_dirs(order, l, r)) return order; \
                                                 \
    float nl = l.votes.nvotes?(l.votes. field / \
			       (float)l.votes.nvotes):-1.0f; \
    float nr = r.votes.nvotes?(r.votes. field / \
			       (float)r.votes.nvotes):-1.0f; \
    if (nl < nr) return 1; \
    else if (nl > nr) return -1; \
    else return cmp_byname(l, r); \
  }

  GLOB(d, difficulty)
  GLOB(s, style)
  GLOB(r, rigidity)
# undef GLOB

  static int cmp_byauthor(const llentry & l,
			  const llentry & r) {
    
    int order;
    if (default_dirs(order, l, r)) return order;

    int c = util::natural_compare(l.author, r.author);

    if (!c) return cmp_byname(l, r);
    else return c;
  }

  static int cmp_byname(const llentry & l,
			const llentry & r) {

    int order;
    if (default_dirs(order, l, r)) return order;

    /* XXX filter color codes here */
    /* XXX ignore case -- strcasecmp is not available on win32? */  
    
    /* then, sort by names. */
    if (l.name == r.name) {
      /* they might both be empty -- then
	 use filenames. */
      if (l.name == "") {
	if (l.fname == r.fname) return 0;
	
	/* we assume filenames are unique */
	return util::natural_compare(l.fname, r.fname);
      } else return 0;
    }

    /* this also includes the case where one has a
       name and the other doesn't */
    return util::library_compare(l.name, r.name);
  }

  static int cmp_none(const llentry & l,
		      const llentry & r) {
    return 0;
  }


  static string none() { return ""; }
};

typedef selector<llentry, string> selor;

struct loadlevelreal : public loadlevel {

  virtual void draw ();
  virtual void screenresize() {}

  virtual void destroy() {
    if (showlev) showlev->destroy();
    sel->destroy ();
    if (cache) cache->destroy();
    while(path) stringpop(path);
    delete this;
  }

  virtual bool first_unsolved(string & file, string & title);

  virtual ~loadlevelreal() {}

  virtual string selectlevel();
  
  loadlevelreal() : helppos(0), sortby(SORT_DATE) {}

  static loadlevelreal * create(player * p, string dir, 
				bool inexact, bool ac);


  private:
  /* rep inv:
     always of the form (../)*(realdir)* */
  /* XXX I think I now require/maintain that
     there be no .. at all in the path */
  stringlist * path;

  int helppos;
  static const int numhelp;
  static string helptexts(int);

  enum sortstyle {
    SORT_DATE,
    SORT_ALPHA, SORT_SOLVED,
    SORT_PD, SORT_PS, SORT_PR,
    SORT_GD, SORT_GS, SORT_GR,
    SORT_AUTHOR,
  };

  /* getsort returns a comparison function. C++
     syntax for this is ridiculous */
  static int (*getsort(sortstyle s)) (const llentry & l,
				      const llentry & r) {
    switch(s) {
    default:
    case SORT_DATE: return llentry::cmp_bydate;
    case SORT_ALPHA: return llentry::cmp_byname;
    case SORT_SOLVED: return llentry::cmp_bysolved;
    case SORT_PD: return llentry::cmp_bymyd;
    case SORT_PS: return llentry::cmp_bymys;
    case SORT_PR: return llentry::cmp_bymyr;
    case SORT_GD: return llentry::cmp_byglobald;
    case SORT_GS: return llentry::cmp_byglobals;
    case SORT_GR: return llentry::cmp_byglobalr;
    case SORT_AUTHOR: return llentry::cmp_byauthor;
    }
  }

  sortstyle sortby;

  struct dircache * cache;

  player * plr;
  bool allow_corrupted;

  /* save last dir we entered */
  static string lastdir;
  /* and last filename we selected */
  static string lastfile;

  string locate(string);
  int changedir(string, bool remember = true);

  /* this for solution preview */
  Uint32 showstart;
  level * showlev;
  int solstep;
  solution * showsol;
  /* if this isn't the same as sel->selected,
     then we are out of sync. */
  int showidx;

  selor * sel;
  string loop();

  static void dc_progress(void *, int n, int tot, const string &);

  /* if possible, select the last file seen here */
  void select_lastfile();
  
  /* called a few times a second, advancing through
     a solution if one exists. */
  void step();
  void fix_show(bool force = false);
  void drawsmall ();

};

string loadlevelreal :: lastdir;
string loadlevelreal :: lastfile;

loadlevel * loadlevel :: create(player * p, string dir,
				bool td, bool ac) {
  return loadlevelreal::create (p, dir, td, ac);
}

loadlevel :: ~loadlevel () {}

void loadlevelreal::select_lastfile() {
  for(int i = 0; i < sel->number; i ++) {
    if (sel->items[i].fname == lastfile) sel->selected = i;
  }
}

void loadlevelreal::fix_show(bool force) {
  /* if we notice that we are out of sync with the selected
     level, switch to it. */
  
  if (force || (sel->selected != showidx)) {
    showidx = sel->selected;
    if (showlev) showlev->destroy();
    showlev = 0;
    showsol = 0;

    if (!sel->items[showidx].isdir) {
      showlev = sel->items[showidx].lev->clone();
      if ( (showsol = plr->getsol(sel->items[showidx].md5)) ) {
	solstep = 0;
	showstart = STEPS_BEFORE_SOL;
      }
    }
  }

}

void loadlevelreal::step() {

  fix_show ();

  /* now, if we have a lev, maybe make a move */
  if (showlev && showsol) {
    if (!showstart) {
      /* step */
      if (solstep < showsol->length) {
	dir d = showsol->dirs[solstep];
	showlev->move(d);
	solstep ++;
      }

    } else showstart --;
  }
}

void loadlevelreal::dc_progress(void * vepoch, int n, int tot, const string & cdir) {
  Uint32 * epoch = (Uint32*) vepoch;
  if (tot > 50 && !(n % 5)) {
    Uint32 ti = SDL_GetTicks();
    if (*epoch < ti) {

      int w = screen->w - 4;
      int wd = (int)(((float)n / (float)tot) * (float)w);

      SDL_Rect rect;
      rect.y = 2;
      rect.h = 4;

      /* done part */
      rect.x = 2;
      rect.w = wd;
      SDL_FillRect(screen, &rect, PROGRESS_DONECOLOR);

      /* undone part */
      rect.x = wd + 2;
      rect.w = w - wd;
      SDL_FillRect(screen, &rect, PROGRESS_RESTCOLOR);

#     if 0 /* text version */
      string s = itos(n) + (string)" / " + itos(tot);
      SDL_Rect blank;
      blank.x = 0; blank.y = 0;
      blank.w = screen->w; blank.h = fon->height * 2;
      SDL_FillRect(screen, &blank, 0);
      fon->draw(0, fon->height, s.c_str());
#     endif

      rect.x = 2;
      rect.w = w;
      
      rect.y = fonsmall->height * 2 - 2;
      rect.h = fonsmall->height + 3;
      SDL_FillRect(screen, &rect, PROGRESS_BACKCOLOR);

      fonsmall->draw(6, fonsmall->height * 2, cdir);


      SDL_Flip(screen);

      *epoch = ti + PROGRESS_TICKS;

    }
  }
}

/* PERF could precompute most of this */
void llentry::draw (int x, int y, bool selected) {
  fon->draw(x, y, display(selected));
}

string llentry::display(bool selected) {
  string color = WHITE;
  if (selected) color = YELLOW;

  unsigned int ns = 32;
  unsigned int ss = 6;
  unsigned int as = 24;

  if (isdir) {

    if (fname == "..") {
      return (string)"   " + color + (string)"[..]" POP;
    } else {
      string pre = "   ";
      if (total > 0 && total == solved) pre = YELLOW LCHECKMARK " " POP;

      string so = "";
      if (total > 0) {
	so = itos(solved) + (string)"/" + itos(total);
      } else {
	if (!selected) color = GREY;
	so = "(no levels)";
      }

      string showname = "";
      if (name != "") showname = name;
      else showname = fname;

      return pre + 
	color + (string)"[" + showname + (string)" " + so + "]" POP;
    }
  } else {
    string pre = "   ";
    if (solved) pre = YELLOW LCHECKMARK " " POP;

    string myr = "  " "  " "  ";

    if (myrating) {
      myr = 
	(string)RED   BARSTART + (char)(BAR_0[0] + (int)(myrating->difficulty)) +
	(string)GREEN BARSTART + (char)(BAR_0[0] + (int)(myrating->style)) +
	(string)BLUE  BARSTART + (char)(BAR_0[0] + (int)(myrating->rigidity));
    }

    /* shows alpha-dimmed if there are fewer than 3(?) votes */
    string ratings;
    if (votes.nvotes > 0) {
      ratings = 
	(string)((votes.nvotes <= 2)? ((votes.nvotes <= 1) ? ALPHA25 : ALPHA50) : "") +
	(string)RED   BARSTART + (char)(BAR_0[0] + (int)(votes.difficulty / votes.nvotes)) +
	(string)GREEN BARSTART + (char)(BAR_0[0] + (int)(votes.style / votes.nvotes)) +
	(string)BLUE  BARSTART + (char)(BAR_0[0] + (int)(votes.rigidity / votes.nvotes));
      /* XXX cooked, solved, nvotes */
    }

    return 
      pre + color + font::pad(name, ns) + (string)" " POP + 
      (string)(corrupted?RED:GREEN) + 
      font::pad(itos(sizex) + (string)GREY "x" POP +
		itos(sizey), ss) + POP +
      (string)" " BLUE + font::pad(author, as) + POP + myr + (string)" " + ratings;
  }
}

bool llentry::matches(char k) {
  if (name.length() > 0) return util::library_matches(k, name);
  else return (fname.length () > 0 && (fname[0] | 32) == k);
}

bool loadlevelreal::first_unsolved(string & file, string & title) {
  /* should use this natural sort, since this is used for the
     tutorials */
  sortby = SORT_ALPHA;
  sel->sort(getsort(sortby));

  for(int i = 0; i < sel->number; i ++) {
    if ((!sel->items[i].isdir) &&
	(!sel->items[i].solved)) {
      file = sel->items[i].actualfile(path);
      title = sel->items[i].name;
      return true;
    }
  }
  /* all solved */
  return false;
}

/* measuring load times -- debugging only. */
#if 0  // ifdef LINUX
#  define DBTIME_INIT long seclast, useclast; { struct timeval tv; gettimeofday(&tv, 0); seclast = tv.tv_sec; useclast = tv.tv_usec; }
#  define DBTIME(s) do { struct timeval tv; gettimeofday(&tv, 0); int nsec = tv.tv_sec - seclast; int usec = nsec * 1000000 + tv.tv_usec - useclast; printf("%d usec " s "\n", usec); useclast = tv.tv_usec; seclast = tv.tv_sec; } while (0)
#else
#  define DBTIME_INIT ;
#  define DBTIME(s) ;
#endif

loadlevelreal * loadlevelreal::create(player * p, string default_dir,
				      bool inexact,
				      bool allow_corrupted_) {
  DBTIME_INIT;

  loadlevelreal * ll = new loadlevelreal();
  ll->cache = dircache::create(p);
  if (!ll->cache) return 0;
  
  DBTIME("created dircache");

  /* might want this to persist across loads, who knows... */
  /* would be good, except that the directory structure can
     change because of 'edit' or because of 'update.' (or
     because of another process!) */
  /* also, there are now multiple views because of corrupted flag */
  /* Nonetheless, a global cache with a ::refresh method
     and a key to call refresh would probably be a better
     user experience. */

  ll->allow_corrupted = allow_corrupted_;
  ll->plr = p;
  ll->sel = 0;
  ll->path = 0;

  ll->showstart = 0;
  ll->showlev = 0;
  ll->solstep = 0;
  ll->showsol = 0;
  ll->showidx = -1; /* start outside array */

  /* recover 'last dir' */
  string dir = default_dir;

  if (inexact) {
    if (lastdir != "") dir = lastdir;
    
    /* XXX should fall back (to argument?) if this fails;
       maybe the last directory was deleted? */
    do {
      if (ll->changedir(dir)) goto chdir_ok;
      dir = util::cdup(dir);
    } while (dir != ".");

    return 0;	

  chdir_ok:
    /* try to find lastfile in this dir, if possible */
    ll->select_lastfile();
  } else {
    if (!ll->changedir(dir, false)) return 0;
  }

  DBTIME("done");

  return ll;
}


string loadlevelreal :: selectlevel () {
  return loop();
}


/* prepend current path onto filename */
string loadlevelreal::locate(string filename) {
  
  stringlist * pp = path;
  
  string out = filename;
  while(pp) {
    if (out == "") out = pp->head;
    else out = pp->head + string(DIRSEP) + out;
    pp = pp -> next;
  }

  if (out == "") return ".";
  else return out;
}

int loadlevelreal::changedir(string what, bool remember) {

  DBTIME_INIT;

  /* printf("changedir '%s' with path %p\n", what.c_str(), path); */
  {
    stringlist * pp = path;
    while (pp) {
      /* printf("  '%s'\n", pp->head.c_str()); */
      pp = pp -> next;
    }
  }

  string where;

  /* Special case directory traversals. */
  if (what == "..") {
    if (path) {
      /* does the wrong thing after descending past cwd. */
      stringpop(path);
      where = locate("");
    } else return 0;
  } else if (what == ".") {
    /* no change, but do reload */
    where = locate("");
  } else {
    /* n.b.
       if cwd is c:\escapex\goodesc,
       and path is ..\..\
       and we enter escapex,
       we should change to ..\,
       not ..\..\escapex.

       .. since we don't allow the path
       to descend beneath the 'root'
       (which is the cwd of escape), this
       scenario never arises.
    */

    where = locate(what);
    path = new stringlist(what, path);
  }

# if 0
  printf ("where: '%s'\n", where.c_str());
  {
    stringlist * pp = path;
    while (pp) {
      printf("  '%s'\n", pp->head.c_str());
      pp = pp -> next;
    }
  }
# endif

  DBTIME("cd got where");

  int n = dirsize(where.c_str());

  DBTIME("cd counted");

  /* printf("Dir \"%s\" has %d entries\n", where.c_str(), n); */

  if (!n) return 0;

  /* save this dir */
  if (remember) lastdir = where;

  selor * nsel = selor::create(n);

  nsel->botmargin = drawing::smallheight() + 16 ;

  nsel->below = this;

  nsel->title = helptexts(helppos);


  DBTIME("cd get index");

  /* get index for this dir, which allows us to look up
     ratings. note that there may be no index. */
  dirindex * thisindex = 0;
  {
    int dummy_unused;
    int dcp = SDL_GetTicks() + (PROGRESS_TICKS * 2);
    cache->get(where, thisindex, dummy_unused, dummy_unused,
	       dc_progress, (void*)&dcp);
  }

  DBTIME("cd got index");

  /* now read all of the files */

  /* init array */
  DIR * d = opendir(where.c_str());
  if (!d) return 0;
  dirent * de;

  int i;
  for(i = 0; i < n;) {
    de = readdir(d);
    if (!de) break;

    string ldn = locate(de->d_name);

    if (isdir(ldn)) {

      string dn = de->d_name;

      /* senseless to include current dir,
	 CVS dirs... */
      if (!(dn == "." ||
	    dn == "CVS" ||
	    /* for now, don't even allow the user
	       to go above the home directory,
	       since we don't handle that
	       properly. */
	    (dn == ".." && !path))) {

	if (dn == "..") {
	  /* don't report completions for parent */
	  nsel->items[i].fname = dn;
	  nsel->items[i].isdir = 1;
	  nsel->items[i].solved = 0;
	  i++;
	} else {
	  int ttt, sss;
	  dirindex * iii = 0;

	  int dcp = SDL_GetTicks() + (PROGRESS_TICKS * 2);
	  if (cache->get(ldn, iii, ttt, sss, dc_progress,
			 (void*) &dcp)) {

	    /* only show if it has levels,
	       or at least has an index 
	       (in corrupted mode we show everything) */
	    if (iii || ttt || allow_corrupted) {
	    
	      nsel->items[i].fname = dn;
	      nsel->items[i].isdir = 1;
	      nsel->items[i].solved = sss;
	      nsel->items[i].total = ttt;
	      
	      /* no need to save the index, just the title */
	      nsel->items[i].name = iii?(iii->title):dn;
	      
	      i++;
	    }
	  }
	}
      }

    } else {

      string contents = readfilemagic(ldn, LEVELMAGIC);

      /* try to read it, passing along corruption flag */
      level * l = level::fromstring(contents, allow_corrupted);

      if (l) {
	string md5c = md5::hash(contents);

	solution * s;
	if ((s = plr->getsol(md5c)) && (s->verified || level::verify(l,s))) {
	  s->verified = true;
	  nsel->items[i].solved = s->length;
	  // nsel->items[i].sol = s;
	} else { 
	  nsel->items[i].solved = 0;
	  // nsel->items[i].sol = 0;
	}

	nsel->items[i].isdir = 0;
	nsel->items[i].md5 = md5c;
	nsel->items[i].fname = de->d_name;
	nsel->items[i].name = l->title;
	nsel->items[i].author = l->author;
	nsel->items[i].corrupted = l->iscorrupted();
	nsel->items[i].sizex = l->w;
	nsel->items[i].sizey = l->h;
	nsel->items[i].lev = l;
	nsel->items[i].myrating = plr->getrating(md5c);
	nsel->items[i].speedrecord = 0;
	nsel->items[i].date = 0;

	/* failure result is ignored, because the
	   votes are initialized to 0 anyway */
	if (thisindex) {
	  thisindex->getentry(de->d_name, 
			      nsel->items[i].votes,
			      nsel->items[i].date,
			      nsel->items[i].speedrecord);
	}

	i++;
      }
    }
  }

  /* some of the entries we saw may have been
     non-escape files, so now shrink nsel */
  nsel->number = i;

  closedir(d);

  DBTIME("cd got everything");
  
  nsel->sort(getsort(sortby));

  DBTIME("cd sorted");

  if (sel) sel->destroy();
  sel = nsel;

  return 1;
}

void loadlevelreal::draw() {

  sdlutil::clearsurface(screen, BGCOLOR);

  drawsmall ();
}

void loadlevelreal::drawsmall() {
  Uint32 color = 
    SDL_MapRGBA(screen->format, 0x22, 0x22, 0x44, 0xFF);

  int y = (screen->h - sel->botmargin) + 4 ;

  SDL_Rect dst;

  /* clear bottom */
  dst.x = 0;
  dst.y = y;
  dst.h = sel->botmargin - 4;
  dst.w = screen->w;
  SDL_FillRect(screen, &dst, BGCOLOR);

  /* now draw separator */
  dst.x = 8;
  dst.y = y;
  dst.h = 2;
  dst.w = screen->w - 16;
  SDL_FillRect(screen, &dst, color);

  if (sel->items[sel->selected].isdir) {
    fon->draw(16, y + 8, WHITE "(" BLUE "Directory" POP ")" POP);
  } else {
    if (!showlev) fix_show();
    drawing::drawsmall(y,
		       sel->botmargin,
		       color,
		       showlev,
		       sel->items[sel->selected].solved,
		       sel->items[sel->selected].fname,
		       &sel->items[sel->selected].votes,
		       sel->items[sel->selected].myrating,
		       sel->items[sel->selected].date,
		       sel->items[sel->selected].speedrecord);
  }
}

string loadlevelreal::loop() {

  sel->redraw();

  SDL_Event event;

  Uint32 nextframe = SDL_GetTicks() + LOADFRAME_TICKS;

  /* last recovery file */
  string lastrecover;

  for(;;) {
    SDL_Delay(1);

    Uint32 now = SDL_GetTicks();
  
    if (now > nextframe) {
      step (); 
      nextframe = now + LOADFRAME_TICKS;
      /* only draw the part that changed */
      drawsmall ();
      SDL_Flip(screen);
    }
  
    while (SDL_PollEvent(&event)) {

      if ( event.type == SDL_KEYDOWN ) {
	int key = event.key.keysym.sym;
	/* breaking from here will allow the key to be
	   treated as a search */

	switch(key) {

	  /* XXX move to smanage */
#if 0
	case SDLK_9:
	  if ((event.key.keysym.mod & KMOD_CTRL) &&
	      sel->items[sel->selected].sol) {
	    solution * sol = sel->items[sel->selected].sol;
	    solution * tmp =
	      optimize::opt(sel->items[sel->selected].lev, sol);
	    if (tmp->length < sol->length) {
	      printf("putting sol!\n");
	      plr->putsol(sel->items[sel->selected].md5, tmp);
	      sel->items[sel->selected].sol = tmp;
	      plr->writefile ();
	    }
	    /* reset our little show, which would now be totally messed up */
	    fix_show (true);
	    sel->redraw();
	  }
	  break;
#endif
	case SDLK_DELETE: {
	  string file = 
	    sel->items[sel->selected].actualfile(path);

	  if (message::quick(this,
			     PICS TRASHCAN POP " Really delete " BLUE +
			     file + POP "?",
			     "Yes",
			     "Cancel", PICS QICON POP)) {
	    if (!util::remove(file)) {
	      message::no(this, "Error deleting!");
	    }
	  }
	  /* need to reload this dir. save lastfile
	     as the file after or before the one we just
	     deleted */
	  if (sel->selected + 1 < sel->number)
	    lastfile = sel->items[sel->selected + 1].fname;
	  else if (sel->selected - 1 >= 0)
	    lastfile = sel->items[sel->selected - 1].fname;

	  changedir(".");

	  select_lastfile();
	  sel->redraw ();
	  break;
	}

	  /* sorting options */
	case SDLK_t:
	case SDLK_s:
	case SDLK_d:
	case SDLK_g:
	case SDLK_a:
	case SDLK_v: {
	  int resort = 0;

	  /* XXX allow other sorts */
	  if (event.key.keysym.mod & KMOD_CTRL) {
	    resort = 1;
	    switch (key) {
	    default:
	    case SDLK_n: sortby = SORT_DATE; break;
	    case SDLK_a: sortby = SORT_ALPHA; break;
	    case SDLK_v: sortby = SORT_SOLVED; break;

	    case SDLK_d: sortby = SORT_GD; break;
	    case SDLK_s: sortby = SORT_GS; break;
	    case SDLK_g: sortby = SORT_GR; break;

	    case SDLK_t: sortby = SORT_AUTHOR; break;

	    }
	  } else if (event.key.keysym.mod & KMOD_ALT) {
	    switch (key) {
	    default: sortby = SORT_ALPHA; break;
	    case SDLK_d: sortby = SORT_PD; break;
	    case SDLK_s: sortby = SORT_PS; break;
	    case SDLK_g: sortby = SORT_PR; break;
	    }
	    resort = 1;
	  }

	  if (resort) {
	    /* XXX should follow the currently
	       selected file */
	    sel->sort(getsort(sortby));
	    sel->redraw();
	    continue;
	  } else break;
	}
	case SDLK_BACKSPACE:
	  /* might fail, but that's okay */
	  changedir("..");
	  sel->redraw();
	  continue;
	case SDLK_SLASH:
	case SDLK_QUESTION:
	  helppos ++;
	  helppos %= numhelp;
	  sel->title = helptexts(helppos);
	  sel->redraw ();
	  continue;

	case SDLK_m:
	  if ((event.key.keysym.mod & KMOD_CTRL) &&
	      !sel->items[sel->selected].isdir) {

	    if (sel->items[sel->selected].solved) {
	      /* ctrl-m: manage solutions */
	      
	      string file = 
		sel->items[sel->selected].actualfile(path);
	      
	      /* XXX the md5 should really be stored with the llentry 
		 ... note: it is!! use it!
	      */
	      FILE * f = fopen(file.c_str(), "rb");
	      if (!f) {
		message::bug(this, "Couldn't open level for solution management");
	      } else {
		string md = md5::hashf(f);
		fclose(f);
		smanage::manage(plr, md, sel->items[sel->selected].lev);
	      }
	    } else message::no(this, "You must solve this level first.");

	    /* we probably messed this up */
	    fix_show (true);
	    sel->redraw();
	    continue;
	  } else break;
	  continue;
	case SDLK_c:
	  if ((event.key.keysym.mod & KMOD_CTRL) &&
	      plr->webid &&
	      !sel->items[sel->selected].isdir &&
	      sel->items[sel->selected].lev) {
	    /* ctrl-c: comment on a level */
	  
	    level * l = sel->items[sel->selected].lev;

	    lastfile = sel->items[sel->selected].fname;

	    string file = 
	      sel->items[sel->selected].actualfile(path);
	  
	    FILE * f = fopen(file.c_str(), "rb");
	    if (!f) {
	      message::bug(this, "Couldn't open file to comment on");
	    
	    } else {

	      string md = md5::hashf(f);
	      fclose(f);
	    
	      /* This does its own error reporting */
	      commentscreen::comment(plr, l, md);

	    }

	    sel->redraw();
	  } else break;
	  continue;

	case SDLK_r:
	  if ((event.key.keysym.mod & KMOD_CTRL) &&
	      plr->webid &&
	      !sel->items[sel->selected].isdir &&
	      sel->items[sel->selected].lev) {
	    /* ctrl-r: rate a level */
	  
	    level * l = sel->items[sel->selected].lev;

	    lastfile = sel->items[sel->selected].fname;

	    string file = 
	      sel->items[sel->selected].actualfile(path);

	    /* XXX now in llentry, also comment */
	    FILE * f = fopen(file.c_str(), "rb");
	    if (!f) {
	      message::bug(this, "Couldn't open file to rate");
	    
	    } else {

	      /* first remove its rating. it will be
		 invalidated */
	      sel->items[sel->selected].myrating = 0;
	    
	      string md = md5::hashf(f);
	      fclose(f);
				   
	      ratescreen * rs = ratescreen::create(plr, l, md);
	      if (rs) {
		extent<ratescreen> re(rs);

		rs->rate();
	      } else {
		message::bug(this, "Couldn't create rate object!");
	      }

	      /* now restore the rating */
	      sel->items[sel->selected].myrating = plr->getrating(md);
	      /* XX resort? */

	    }


	    sel->redraw();
	  } else break;
	  continue;
	case SDLK_0:
	  if (event.key.keysym.mod & KMOD_CTRL) {
	    string recp = prompt::ask(this, "Recover solutions from file: ",
				      lastrecover);
	  
	    player * rp = player::fromfile(recp);

	    if (!rp) {
	      message::quick(this, 
			     "Couldn't open/understand that player file.",
			     "OK", "", PICS XICON POP);
	      sel->redraw ();
	      continue;
	    }

	    extent<player> erp(rp);

	    int nsolved = 0;

	    /* for each unsolved level, try to recover solution */
	    for(int i = 0; i < sel->number; i ++) {
	      if ((!sel->items[i].isdir) &&
		  (!sel->items[i].solved)) {
		
		/* check every solution in rp. */

		ptrlist<solution> * all = rp->all_solutions();

		/* we don't need to delete these solutions */
		while (all) {
		  solution * s = ptrlist<solution>::pop(all);

		  level * l = sel->items[i].lev->clone();

		  /* printf("try %p on %p\n", s, l); */
		  if (level::verify(l, s)) {

		    sel->items[i].solved = 1;
		    string af = sel->items[i].actualfile(path);

		    FILE * f = fopen(af.c_str(), "rb");
		    if (!f) {
		      message::bug(this, "couldn't open in recovery");
		      sel->redraw ();
		      continue;
		    }
		    string md5 = md5::hashf(f);

		    fclose(f);

		    nsolved +=
		      plr->putsol(md5, s->clone())?1:0;

		    /* then don't bother looking at the tail */
		    ptrlist<solution>::diminish(all);
		  }

		  l->destroy();
		}
	      }
	    }


	    if (nsolved > 0) {

	      plr->writefile();

	    } else message::quick(this,
				  "Couldn't recover any new solutions.",
				  "OK", "", PICS EXCICON POP);


	    fix_show ();
	    sel->redraw();
	  } else break;
	  continue;
	case SDLK_u:
	  /* holding ctrl, has registererd */
	  if ((event.key.keysym.mod & KMOD_CTRL) &&
	      plr->webid) {
	    /* ctrl-u */
	    /* could show message if not solved */
	    if (!sel->items[sel->selected].isdir &&
		sel->items[sel->selected].solved) {

	      if (!message::quick(this,
				  "Really upload to the internet? "
				  "Only do this when the level's really done.",
				  "Upload", "Cancel", PICS QICON POP)) {
		sel->redraw();
		continue;
	      }

	      upload * uu = upload::create();

	      if (!uu) {
		message::bug(this,
			     "Can't create upload object!");
		sel->redraw();
		continue;
	      }
	      extent<upload> eu(uu);

	      /* save spot */
	      lastfile = sel->items[sel->selected].fname;

	      string file = 
		sel->items[sel->selected].actualfile(path);

	      /* don't bother with message; upload does it */
	      switch(uu->up(plr, file)) {
	      case UL_OK:
		break;
	      default:
		break;
	      }
	      sel->redraw();
	      continue;
	    } else {
	      message::no(this, 
			  "Can't upload dirs or unsolved levels.");
	      sel->redraw();
	      continue;
	    }
	    continue;
	  } else break;
	default:
	  break;
	}
      }
    
#ifndef __amigaos4__
      selor::peres pr = sel->doevent(event);
#else /* __amigaos4__ */
      selor::peres pr = sel->doevent_nomouse(event);
#endif /* __amigaos4__ */
      switch(pr.type) {
      case selor::PE_SELECTED:
	if (sel->items[pr.u.i].isdir) {
	  /* XXX test if changedir failed, if so,
	     display message. but why would it
	     fail? */
	  /* printf("chdir '%s'\n", sel->items[pr.u.i].fname.c_str()); */
	  if (!changedir(sel->items[pr.u.i].fname)) {
	    message::quick(0, "Couldn't change to " BLUE +
			   sel->items[pr.u.i].fname,
			   "Sorry", "", PICS XICON POP);
	  }
	  /* printf("chdir success.\n"); */
	  sel->redraw();
	  break;
	} else {
	  string out = sel->items[pr.u.i].fname;
	  lastfile = out;
	  while (path) {
	    out = stringpop(path) + string(DIRSEP) + out;
	  }
	  return out;
	}
      case selor::PE_EXIT: /* XXX */
      case selor::PE_CANCEL:
	return "";
      default:
      case selor::PE_NONE:
	;
      }
    
    }

  } /* unreachable */

}

/* previously we only showed certain options when
   they were available. It might be good to do that
   still. */
const int loadlevelreal::numhelp = 2;
string loadlevelreal::helptexts(int i) {
  switch(i) {
  case 0:
    return 
      WHITE
      "Use the " BLUE "arrow keys" POP " to select a level and "
      "press " BLUE "enter" POP " or " BLUE "esc" POP " to cancel."
                     "      " BLUE "?" POP " for more options.\n"
      WHITE
      "Press " BLUE "ctrl-u" POP
      " to upload a level you've created to the internet.\n"
      
      WHITE
      "Press " BLUE "ctrl-r" POP " to adjust your rating of a level,"
      " or "   BLUE "ctrl-c" POP " to publish a comment.\n";

  case 1:
    return
      WHITE "Sorting options: " BLUE "ctrl-" 
            RED "d" POP "," 
            GREEN "s" POP ","
            BLUE "g" POP POP
            " sorts by global " RED "difficulty" POP ","
                                GREEN "style" POP ","
                                BLUE "rigidity" POP ".\n"

      WHITE BLUE "alt-" RED "d" POP "," GREEN "s" POP "," BLUE "g" POP POP
      " sorts by personal. "
      BLUE "ctrl-m" POP " manages solutions (upload/download/view).\n"

      WHITE BLUE "ctrl-a" POP " sorts alphabetically, " BLUE "ctrl-t" POP " by author. " 
            BLUE "ctrl-v" POP " shows unsolved levels first.";

  }

  return RED "help index too high";
}
