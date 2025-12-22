
#include "smanage.h"
#include "extent.h"
#include "message.h"
#include "prompt.h"
#include "textscroll.h"
#include "client.h"
#include "http.h"
#include "md5.h"
#include "base64.h"
#include "menu.h"

typedef ptrlist<namedsolution> nslist;

/* entries in the selector */
struct nsentry {
  
  /* stays at the top */
  bool def;
  namedsolution ns;

  static int height() { return TILEH + 8; }
  void draw(int x, int y, bool sel) {
    int yy = ((TILEH + 8) - fon->height) >> 1;

    string color = sel?YELLOW:WHITE;

    /* XXX add date */
    /* PERF precompute */
    string s =
      color + font::pad(ns.name, 32) + POP
      + font::pad("(" GREEN + itos(ns.sol->length), -6) + POP + " moves)"
      "  " GREY "by " POP + font::pad(ns.author, 16);

    fon->draw(x, yy + y, s);
  }

  /* we're not really "selecting" anything here. */
  int convert() { return 0; }

  bool matches(char k) {
    return (ns.name.length () > 0 &&
	    (ns.name[0]|32) == (k|32));
  }

  static int none() { return 0; }

  static void swap (nsentry * l, nsentry * r) {
#   define SWAP(t,f) {t f ## _tmp = l->f; l->f = r->f; r->f = f ## _tmp; }
    SWAP(namedsolution, ns);
    SWAP(bool, def);
#   undef SWAP
  }
  
  static int cmp_default(const nsentry & l,
			 const nsentry & r) {
    if (l.def && !r.def) return -1;
    if (r.def && !l.def) return 1;

    if (l.ns.sol->length < r.ns.sol->length) return -1;
    else if (l.ns.sol->length == r.ns.sol->length) {
      if (l.ns.name < r.ns.name) return -1;
      else if (l.ns.name == r.ns.name) {
	if (l.ns.author < r.ns.author) return -1;
	else if (l.ns.author == r.ns.author) return 0;
	else return 1;
      } else return 1;
    } else return 1;
  }

};


typedef selector<nsentry, int> nsel;

struct smreal : public drawable {

  virtual ~smreal() {}
  void destroy() {
    sel->destroy ();
    delete this;
  }

  /* drawable */
  virtual void draw () {
    sdlutil::clearsurface(screen, BGCOLOR);
    /* XXX should drawsmall like load.
       need to move that stuff to some separate class
       so I can reuse it (also when rating, commenting) */
  }

  void resort () {
    sel->sort(nsentry::cmp_default);
  }

  virtual void screenresize () {}

  static smreal * create(player * p, string lmd5, level * lev) {
    /* get the solution set */

    nslist * solset = p->solutionset(lmd5);
    
    /* there are no solutions to manage! */
    if (!solset) return 0;


    smreal * sm = new smreal;
    if (!sm) return 0;
    int len = solset->length ();
    
    sm->sel = nsel::create(len);

    sm->sel->title =
      YELLOW "Managing solutions. " POP 
      RED "enter" POP " to watch solution. "
      BLUE "del" POP " to delete. "
      BLUE "ctrl-r" POP " to rename. "
      BLUE "ins" POP " makes default. ";
    
    if (p->webid)
      sm->sel->title += "\n"
      BLUE "ctrl-u" POP " to upload to server. "
      BLUE "ctrl-d" POP " to get new solutions from the server. "
      ;
    /* XXX add optimize */


    /* now initialize the nsentries  */
    for(int i = 0; i < len; i ++) {
      sm->sel->items[i].def = (i == 0);
      sm->sel->items[i].ns.name = solset->head->name;
      sm->sel->items[i].ns.author = solset->head->author;
      sm->sel->items[i].ns.date = solset->head->date;
      sm->sel->items[i].ns.sol = solset->head->sol->clone();

      solset = solset -> next;
    }

    sm->resort ();

    return sm;
  }

  nsel * sel;

  static void downloadsolutions(player * plr, smreal * sm, string lmd5);

};

/* need the drawable to draw background, too */
struct txdraw : public drawable {
  textscroll * tx;
  txdraw() {
    tx = textscroll::create(fon);
    tx->posx = 5;
    tx->posy = 5;
    tx->width = screen->w - 10;
    tx->height = screen->h - 10;
  }

  void say(string s) { tx->say(s); }
  void draw() {
    sdlutil::clearsurface(screen, BGCOLOR);
    tx->draw();
  }
  void screenresize() {
    tx->screenresize();
  }

  virtual ~txdraw() {
    tx->destroy();
  }
};

void smanage::promptupload(player * plr, string lmd5, 
			   solution * sol, string msg,
			   string name_,
			   bool speedrec) {

  string s;
  txdraw td;

  label message;
  message.text = msg;

  int IND = 2;

  textinput name;
  name.indent = IND;
  name.question = "Name:";
  name.input = name_;
  name.disabled = speedrec;
  name.explanation =
    "Name this solution, briefly.";
  
  toggle speed;
  speed.indent = IND;
  speed.disabled = speedrec;
  speed.checked = speedrec;
  speed.question = "Speed Record Only";
  speed.explanation =
    "Upload this solution as a speed record entry only.\n"
    "It will be deleted if someone beats it.";

  textbox desc(42, 7);
  desc.indent = IND;
  desc.question = "Description. " GREY "(optional)" POP;
  desc.explanation =
    speedrec?
    "If you want, you can describe your solution here.\n"
    "It's fine to upload a speed record without comment.":
    "Describe your solution here. This is inserted as a comment\n"
    "with the level. This is optional, but if the solution isn't\n"
    "interesting somehow, why are you uploading it?\n";

  vspace spacer((int)(fon->height * 1.5f));
  vspace spacer2((int)(fon->height * 1.5f));


  okay ok;
  ok.text = "Upload Solution";

  cancel can;
  can.text = "Cancel";
  
  ptrlist<menuitem> * l = 0;

  ptrlist<menuitem>::push(l, &can);
  ptrlist<menuitem>::push(l, &ok);
  ptrlist<menuitem>::push(l, &spacer);

  ptrlist<menuitem>::push(l, &speed);
  ptrlist<menuitem>::push(l, &desc);
  ptrlist<menuitem>::push(l, &name);
  ptrlist<menuitem>::push(l, &spacer2);
  ptrlist<menuitem>::push(l, &message);

  /* display menu */
  menu * mm = menu::create(0, "Upload solution?", l, false);
  resultkind res = mm->menuize();
  ptrlist<menuitem>::diminish(l);
  mm->destroy ();

  if (res == MR_OK) {

    http * hh = client::connect(plr, td.tx, &td);
    
    if (!hh) { 
      message::no(&td, "Couldn't connect!");
      return;
    }
    
    extent<http> eh(hh);

    string res;

    string solcont = sol->tostring();
    
    formalist * fl = 0;
    
    /* XXX seems necessary! but in aphasia cgi? */
    formalist::pusharg(fl, "dummy", "dummy");
    formalist::pusharg(fl, "id", itos(plr->webid));
    formalist::pusharg(fl, "seql", itos(plr->webseql));
    formalist::pusharg(fl, "seqh", itos(plr->webseqh));
    formalist::pusharg(fl, "md", md5::ascii(lmd5));
    formalist::pusharg(fl, "name", name.input);
    formalist::pusharg(fl, "speedonly", speed.checked?"1":"0");
    formalist::pusharg(fl, "desc", desc.get_text());
    formalist::pushfile(fl, "sol", "sol.esx", solcont);

    td.say("Uploading..");
    td.draw();


    string out;
    if (client::rpcput(hh, UPLOADSOL_RPC, fl, out)) {
      if (speedrec)
	message::quick(&td, GREEN "Success! the record is yours!" POP,
		       "OK", "", PICS THUMBICON POP);
      else
	message::quick(&td, GREEN "Success!" POP,
		       "OK", "", PICS THUMBICON POP);
    } else {
      message::no(&td, RED "Upload failed: " + 
		  out + POP);
    }

    formalist::diminish(fl);    
  }

}


void smreal::downloadsolutions(player * plr, smreal * sm, string lmd5) {
  string s;
  txdraw td;
  
  http * hh = client::connect(plr, td.tx, &td);

  if (!hh) { 
    message::no(&td, "Couldn't connect!");
    return;
  }

  extent<http> eh(hh);
  /* XXX register callback.. */


  httpresult hr = hh->get(ALLSOLS_URL + md5::ascii(lmd5), s);
  if (hr == HT_OK) {
    /* parse result. see protocol.txt */
    int nsols = stoi(util::getline(s));

    td.say("OK. Solutions on server: " GREEN + itos(nsols) + POP);

    /* get them! */
    for(int i = 0; i < nsols; i ++) {
      string line1 = util::getline(s);
      string author = util::getline(s);
      string moves = base64::decode(util::getline(s));
      
      /* this is the solution id, which we don't need */
      (void) stoi(util::chop(line1));
      int date = stoi(util::chop(line1));
      string name = util::losewhitel(line1);

      solution * s = solution::fromstring(moves);
      if (!s) {
	message::no(&td, "Bad solution on server!");
	return;
      }

      extent<solution> es(s);

      /* now check if we've got it */
      /* PERF each of the following things is O(n)
	 with bad constants, but we don't expect 
	 many solutions */
      for(int n = 0; n < sm->sel->number; n ++) {
	/* use string equality.
	   could be wrong since the rle-encoded
	   string for a solution is not unique.
	   (but then we just store two copies of
	   the same solution, no big deal) */
	if (moves == sm->sel->items[n].ns.sol->tostring()) {
	  /* toss it */
	  goto toss_it;
	} 
      }

      /* keep it */
      {
	int idx = sm->sel->number;
	sm->sel->resize(idx + 1);
	/* never the default */
	sm->sel->items[idx].def = false;
	sm->sel->items[idx].ns.name = name;
	sm->sel->items[idx].ns.sol = s;
	sm->sel->items[idx].ns.author = author;
	sm->sel->items[idx].ns.date = date;

	/* now this belongs to sm->sel */
	es.release();

      }
	
    toss_it:;
    }

    return;

  } else {
    message::no(&td, "Couldn't get solutions");
    return;
  }
    
}

void smanage::manage(player * plr, string lmd5, level * lev) {
  
  smreal * sm = smreal::create(plr, lmd5, lev);
  if (!sm) {
    message::bug(0, "Couldn't create solution manager!");
    return;
  }

  extent<smreal> es(sm);

  sm->sel->redraw ();

  SDL_Event event;
  
  while ( SDL_WaitEvent(&event) >= 0 ) {
    int key;

    switch(event.type) {
    case SDL_KEYDOWN: {
      key = event.key.keysym.sym;
      
      switch(key) {
      case SDLK_u:
	if (!(event.key.keysym.mod & KMOD_CTRL)) break;	
	if (!plr->webid) break;

	smanage::promptupload(plr, lmd5, 
			      sm->sel->items[sm->sel->selected].ns.sol,
			      "Please only upload interesting solutions.",
			      sm->sel->items[sm->sel->selected].ns.name,
			      false);

	sm->sel->redraw();

	continue;
      case SDLK_d:
	if (!(event.key.keysym.mod & KMOD_CTRL)) break;	
	/* get solutions from web */
	smreal::downloadsolutions(plr, sm, lmd5);

	sm->resort();
	sm->sel->redraw();
	
	continue;
      case SDLK_r:
	if (!(event.key.keysym.mod & KMOD_CTRL)) break;
	/* FALLTHROUGH */
      case SDLK_F2: {
	/* rename. */
	
	  prompt * pp = prompt::create();
	  extent<prompt> ep(pp);
	  pp->title = (string)"Solution name: ";
	  pp->below = sm;
	  pp->input = sm->sel->items[sm->sel->selected].ns.name;
	  
	  pp->posx = 30;
	  pp->posy = 120;
	  
	  sm->sel->items[sm->sel->selected].ns.name = pp->select();

	  /* XX resort? would have to track cursor */
	  sm->sel->redraw ();
	continue;
      }
      case SDLK_DELETE: ;
	/* shouldn't delete last solution */
	if (sm->sel->number > 1) {

	  int i = sm->sel->selected;

	  if (message::quick(sm,
			     "Really delete '" YELLOW + 
			     sm->sel->items[i].ns.name + POP "'?",
			     "Delete",
			     "Cancel")) {

	    if (i == 0) {
	      /* need to make something else the default */
	      sm->sel->items[1].def = true;
	    }

	    /* now remove this one by overwriting it with the
	       last one. first delete the sol since we own it */
	    sm->sel->items[i].ns.sol->destroy();
	    
	    /* might be overwriting self, but that's no problem */
	    sm->sel->items[i].ns = sm->sel->items[sm->sel->number - 1].ns;
	    sm->sel->number --;
	    sm->sel->selected = 0;
	  }
	} else message::no(sm, "Can't delete last solution!");

	sm->resort();
	sm->sel->redraw();
	continue;

      case SDLK_i:
	if (!(event.key.keysym.mod & KMOD_CTRL)) break;
      case SDLK_INSERT: ;
	/* just make default. this is easy */
	sm->sel->items[0].def = false;
	sm->sel->items[sm->sel->selected].def = true;
	sm->sel->selected = 0;
	sm->resort ();
	sm->sel->redraw ();
	continue;
      }
    }
    }
    
    /* key wasn't handled above */
    switch(sm->sel->doevent(event).type) {
    case nsel::PE_SELECTED:
      /* show it */
      message::quick(sm, "Sorry, solution playback not implemented yet.",
		     "OK", "", PICS XICON POP);
      sm->sel->redraw ();
      break;
    case nsel::PE_EXIT:
    case nsel::PE_CANCEL: {
      /* done. write changes back into player file */
      /* create solset list, preserving order */
      nslist * solset = 0;
      for(int i = sm->sel->number - 1;
	  i >= 0; 
	  i --) {
	solset = new nslist(new namedsolution(sm->sel->items[i].ns.sol,
					      sm->sel->items[i].ns.name,
					      sm->sel->items[i].ns.author,
					      sm->sel->items[i].ns.date),
			    solset);
      }
      
      plr->setsolutionset(lmd5, solset);
      plr->writefile();

      return;
    }
    case nsel::PE_NONE:
    default:
      /* ignore */
      break;
    }
  }
}

