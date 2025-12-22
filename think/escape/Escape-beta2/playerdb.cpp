
#include "playerdb.h"
#include "util.h"
#include "extent.h"
#include "prompt.h"
#include "chars.h"
#include "message.h"
#include "prefs.h"

#include "draw.h"

#define PLAYERDB_MAGIC "ESXD"

#define PDBTITLE YELLOW "Welcome to Escape!" POP \
                 " Select a player with the " \
                 BLUE "arrow keys" POP " and " BLUE "enter" POP ".\n" \
                 "To delete a player, press " BLUE "ctrl-d" POP ".\n \n"

#define MENUITEMS 3
enum pdbkind { K_PLAYER, K_NEW, K_IMPORT, K_QUIT, };

/* entries in the selector */
struct pdbentry {
  pdbkind kind;

  string name;
  string fname;

  int solved;

  static int height() { return TILEH + 8; }
  void draw(int x, int y, bool sel);
  string display(bool sel);
  player * convert();

  bool matches(char k);
  static player * none() { return 0; }

  static void swap (pdbentry * l, pdbentry * r) {
#   define SWAP(t,f) {t f ## _tmp = l->f; l->f = r->f; r->f = f ## _tmp; }
    SWAP(pdbkind, kind);
    SWAP(string, name);
    SWAP(string, fname);
    SWAP(int, solved);
#   undef SWAP
  }
  
  static int cmp_bysolved(const pdbentry & l,
			  const pdbentry & r) {
    if (l.kind < r.kind) return -1;
    if (l.kind > r.kind) return 1;
    if (l.solved > r.solved) return -1;
    else if (l.solved == r.solved) {
      if (l.name > r.name) return -1;
      else if (l.name == r.name) return 0;
      else return 1;
    }
    else return 1;
  }

};

struct playerdb_ : public playerdb {

  static playerdb_ * fromstring(string);
  virtual string tostring();

  /* make db with one player, 'Default' */
  static playerdb_ * create();

  virtual void destroy();

  virtual player * chooseplayer();

  virtual ~playerdb_() {}

  private:

  selector<pdbentry, player *> * sel;
  void addplayer(string);
  void delplayer(int);
  void insertmenu(int);
  void promptnew();
  void promptimport();

  static string makefilename(string name);
  static string safeify(string name);

};

/* assumes there's enough room! */
void playerdb_::insertmenu(int start) {
  sel->items[start++].kind = K_QUIT;
  sel->items[start++].kind = K_NEW;
  sel->items[start++].kind = K_IMPORT;
}

void pdbentry::draw (int x, int y, bool selected) {

  int ix = x + 4;
  int iy = y + 4;

  int tx = x + TILEW + 8;
  int ty = y + ((TILEW + 8) >> 1) - (fon->height >> 1);

  switch (kind) {

  default:
    fon->draw(tx, ty, "???");
    break;

  case K_IMPORT:
    drawing::drawtileu(ix, iy, TU_I, 0, screen);
    fon->draw(tx, ty, BLUE "Import / Recover Player");
    break;

  case K_NEW:
    drawing::drawtileu(ix, iy, TU_N, 0, screen);
    fon->draw(tx, ty, BLUE "New Player");
    break;

  case K_QUIT:
    drawing::drawtileu(ix, iy, TU_X, 0, screen);
    fon->draw(tx, ty, BLUE "Quit");
    break;

  case K_PLAYER:
    /* Draw the player graphic. XXX This should be grabbed from
       the player file, once we have multiple different
       players! Once we have animation, the player should be
       animated when he is selected. */
    drawing::drawguy(GUY_OFFICE, DIR_DOWN, ix, iy,
		     0, screen);
    
    fon->draw(tx, ty, display(selected));
    break;
  }
}

string pdbentry::display(bool sel) {
  string color = "";
  if (sel) color = BLUE;
  return color + name + (string)" " POP 
         "(" YELLOW + itos(solved) + (string)POP ")";
}

player * pdbentry::convert() {
  player * ret = player::fromfile(fname);

  if (!ret) {
    message::no(0, "Couldn't read player " + fname);
    return 0;
  } else {
    /* ensure that this player (which may be from an older version)
       has at least defaults for any new prefs */
    prefs::defaults(ret);
    return ret;
  }
}

bool pdbentry::matches(char k) {
  if (kind == K_PLAYER) 
    return (name.length() > 0) && ((name[0]|32) == k);
  else if (kind == K_NEW) return ((k | 32) == 'n');
  else if (kind == K_QUIT) return ((k | 32) == 'x' ||
				   (k | 32) == 'q');
  /* ?? */
  else return false;
}

void playerdb_::destroy() {
  sel->destroy();
  delete this;
}

string playerdb_::tostring() {
  string ou;

  ou = PLAYERDB_MAGIC;

  int numplayers = 0;
  {
    for(int i = 0; i < sel->number; i ++) {
      if (sel->items[i].kind == K_PLAYER) numplayers ++;
    }
  }

  ou += sizes(numplayers);
  for(int i = 0; i < sel->number; i++) {
    if (sel->items[i].kind == K_PLAYER) {
      ou += sizes(sel->items[i].fname.length());
      ou += sel->items[i].fname;
    }
  }

  return ou;
}

playerdb_ * playerdb_::fromstring(string s) {
  /* check magic! */
  if (s.substr(0, ((string)PLAYERDB_MAGIC).length()) != PLAYERDB_MAGIC) 
    return 0;

  unsigned int idx = ((string)PLAYERDB_MAGIC).length();

  if (idx + 4 > s.length()) return 0;
  int n = shout(4, s, idx);
  
  playerdb_ * pdb = new playerdb_();
  extent<playerdb_> ep(pdb);

  pdb->sel = selector<pdbentry, player *>::create(n + MENUITEMS);
  if (!pdb->sel) return 0;

  pdb->sel->title = PDBTITLE;

  for(int i = 0; i < n; i ++) {
    if (idx + 4 > s.length()) return 0;
    int m = shout(4, s, idx);
    if (idx + m > s.length()) return 0;
    pdb->sel->items[i].kind = K_PLAYER;
    string fname = s.substr(idx, m);
    pdb->sel->items[i].fname = fname;
    idx += m;
    
    player * him = player::fromfile(pdb->sel->items[i].fname);

    if (him) {
      pdb->sel->items[i].name = him->name;
      pdb->sel->items[i].solved = him->num_solutions();

      him->destroy();
    } else {
      pdb->sel->items[i].name = fname + "  **" RED "ERROR" POP "**";
      pdb->sel->items[i].solved = -1;
    }

  }

  pdb->insertmenu(n);

  ep.release();
  return pdb;
}

/* XXX some repeated code between here and fromstring.
   consolidate or make sure that both behave the same! */
playerdb_ * playerdb_::create() {
  playerdb_ * pdb = new playerdb_();
  if (!pdb) return 0;
  extent<playerdb_> ep(pdb);

  pdb->sel = selector<pdbentry, player *>::create(3);

  if (!pdb->sel) return 0;

  pdb->sel->title = PDBTITLE;

  pdb->insertmenu(0);

  pdb->addplayer("Default");

  ep.release();
  return pdb;
}

string playerdb_::safeify(string name) {
  /* names can only contain certain characters. */

  string ou;
  
  for(unsigned int i = 0;
      i < name.length() &&
      ou.length () < 32;
      i++) {
    
    if ((name[i] >= 'A' &&
	 name[i] <= 'Z') ||
	(name[i] >= 'a' &&
	 name[i] <= 'z') ||
	(name[i] >= '0' &&
	 name[i] <= '9') ||
	name[i] == '_' ||
	name[i] == '-' ||
	name[i] == ' ' ||
	name[i] == '.' ||
	name[i] == '(' ||
	name[i] == ')' ||
	name[i] == '!' ||
	name[i] == '@') ou += (char)name[i];
  }

  return ou;
}

string playerdb_::makefilename(string name) {
  /* shorten to 8 chars, strip special characters,
     add .esp */

  string ou;
  
  for(unsigned int i = 0;
      i < name.length() && ou.length() <= 8;
      i++) {
    
    if ((name[i] >= 'A' &&
	 name[i] <= 'Z') ||
	(name[i] >= 'a' &&
	 name[i] <= 'z') ||
	(name[i] >= '0' &&
	 name[i] <= '9') ||
	name[i] == '_') ou += (char)name[i];
    else if (name[i] == ' ') ou += '_';
  }
  
  if (ou == "") ou = "player";

  ou += ".esp";

  /* XXX test if the file exists,
     and if it does, change the
     player filename. */

  if (util::existsfile(ou)) return "";

  return ou;
}

void playerdb_::addplayer(string name) {
  player * plr = player::create(name);
  if(plr) {

    /* can fail, for example, if the file exists */
    string fname = makefilename(name);
    if (fname != "") {

      sel->resize(sel->number + 1);

      plr->fname = fname;
      plr->writefile();

      /* one slack spot; initialize it */
      sel->items[sel->number - 1].kind = K_PLAYER;
      sel->items[sel->number - 1].solved = 0;
      sel->items[sel->number - 1].name = name;
      sel->items[sel->number - 1].fname = fname;

      return;
    } else {
      plr->destroy();
    }

  } 

  /* failed if we got here */
  message::quick(0, "Couldn't create player. Does file already exist?",
		 "OK", "", PICS XICON POP);

}

void playerdb_::delplayer(int i) {

  /* XXX delete player file from disk? */
  if (sel->items[i].kind == K_PLAYER) {
    int n = 0;
    for(int m = 0; m < sel->number; m ++) {
      if (m != i) {
	sel->items[n++] = sel->items[m];
      } 
    }
    
    sel->number = n;
    sel->selected = 0;
  }
}


typedef selector<pdbentry, player *> selor;

player * playerdb_::chooseplayer() {

  sel->sort(pdbentry::cmp_bysolved);

  sel->redraw();

  SDL_Event event;

  while ( SDL_WaitEvent(&event) >= 0 ) {

    /* control-something is handled 
       separately. */

    if (event.type == SDL_KEYDOWN &&
	(event.key.keysym.mod & KMOD_CTRL))
      switch(event.key.keysym.sym) {

      default:
	break;

	/* delete selected */
      case SDLK_d: {
	/* XXX use a more robust method here to detect the default player. */
	if (sel->items[sel->selected].name != "Default"
	    && sel->items[sel->selected].kind == K_PLAYER) {
	  prompt * pp = prompt::create();
	  extent<prompt> ep(pp);
	  pp->title = ((string)PICS QICON POP " Really delete " BLUE +
		       sel->items[sel->selected].name +
		       (string)" " POP "(" YELLOW +
		       itos(sel->items[sel->selected].solved) +
		       (string)" " POP "solved)? (y/N) ");

	  pp->posx = 30;
	  pp->posy = 30;

	  string answer = pp->select();
	
	  if (answer.length() > 0 && (answer[0]|32) == 'y') {
	    delplayer(sel->selected);
	  }

	  sel->sort(pdbentry::cmp_bysolved);
	  sel->redraw();
	} else {

	  /* XXX should we even do anything here? */
	  message::no(0, "Can't delete default player or menu items!");
	  sel->redraw();

	}
	continue;
      }
	/* create new */
      case SDLK_n: {
	promptnew ();
	continue;
      }
      }
     

    /* otherwise, handle via default selector */
    selor::peres pr = sel->doevent(event);
    switch(pr.type) {
    case selor::PE_SELECTED:
      switch(sel->items[sel->selected].kind) {
      case K_PLAYER:
	return sel->items[sel->selected].convert();
      case K_QUIT:
	return 0; /* XXX? */
      case K_IMPORT:
	promptimport();
	continue;

      case K_NEW:
	promptnew();
	continue;
      }
      /* ??? */
      break;
      /* FALLTHROUGH */
    case selor::PE_EXIT: /* XXX */
    case selor::PE_CANCEL:
      return 0;
    default:
    case selor::PE_NONE:
      ;
    }
  }

  return 0;
}

void playerdb_ :: promptnew () {
  prompt * pp = prompt::create();
  extent<prompt> ep(pp);

  pp->title = "Enter name for new player: ";
  pp->posx = 30;
  pp->posy = 30;

  string ssss = safeify(pp->select());
	
  if (ssss != "") {
    addplayer(ssss);
  }

  sel->sort(pdbentry::cmp_bysolved);
  sel->redraw();
}

/* XXX this would be much nicer if it actually let
   you browse the directory for a player file */
void playerdb_ :: promptimport () {
  prompt * pp = prompt::create();
  extent<prompt> ep(pp);

  pp->title = "Enter filename (" BLUE "*.esp" POP "): ";
  pp->posx = 30;
  pp->posy = 30;

  string ss = pp->select();
  /* XXX we should probably make a copy of the player file.
     if importing from an old version, we don't want the
     player file to still live in the previous version's
     directory! */
  player * pa = player::fromfile(ss);

  if (pa) {

    sel->resize(sel->number + 1);

    /* one slack spot; initialize it */
    sel->items[sel->number - 1].kind = K_PLAYER;
    sel->items[sel->number - 1].solved = pa->num_solutions();
    sel->items[sel->number - 1].name = pa->name;
    sel->items[sel->number - 1].fname = pa->fname;
    
    pa->destroy ();

    sel->sort(pdbentry::cmp_bysolved);
  } else if (ss != "") {
    message::no(0, "Can't read " RED + ss + POP ".");
  }

  sel->redraw();
}

playerdb * playerdb :: create() {
  return playerdb_ :: create();
}

playerdb * playerdb :: fromstring (string s) {
  return playerdb_ :: fromstring(s);
}
