
#include "SDL.h"
#include "SDL_image.h"
#include <math.h>
#include "edit.h"
#include "sdlutil.h"
#include "draw.h"

#include "escapex.h"
#include "play.h"
#include "prompt.h"

#include "extent.h"
#include "util.h"
#include "edit.h"

#include "load.h"
#include "md5.h"

#include "message.h"
#include "menu.h"
#include "chars.h"

#define EDITORBGCOLOR 0xFF111122
#define SELRECTCOLOR 0x76, 0x12, 0xAA
#define SELRECTCOLOR2 0xAA, 0x40, 0xFF

#define LEVYSKIP 12

#define XOFF 0
#define YOFF (TILEH * 2 + LEVYSKIP)

#define XW (screen->w - XOFF)
#define YH (screen->h - YOFF)

int edit_menuitem[] =
  { 0 /* skip - show foreground tile */,
    0 /* skip - layer normal/alt */,
    0 /* skip - changed/not */,
    TU_SAVE, TU_SAVEAS, TU_LOAD,
    TU_TITLE, TU_AUTHOR, TU_SIZE,
    TU_PLAYERSTART, TU_CLEAR,
    TU_PLAY, TU_RANDOM, 
    TU_RANDTYPE,
    TU_ERASE_BOT,
    TU_FIRST_BOT,
    TU_DALEK,
    TU_HUGBOT,
    TU_BROKEN,
  };

#define POS_CURRENT 0
#define POS_LAYER 1
#define POS_CHANGED 2
#define POS_RANDTYPE 13
#define POS_SAVE 3
#define POS_RANDOM 12
#define NUM_MENUITEMS 19


static bool ispanel(int t, int & ref) {
  if (t == T_PANEL) { ref = PANEL_REGULAR; return true; }
  if (t == T_BPANEL) { ref = PANEL_BLUE; return true; }
  if (t == T_GPANEL) { ref = PANEL_GREEN; return true; }
  if (t == T_RPANEL) { ref = PANEL_RED; return true; }
  return false;
}

static bool needsdest(int t) {
  int dummy;
  return (t == T_TRANSPORT || ispanel(t, dummy));

}

void editor::screenresize() {
  dr.width = XW;
  dr.height = YH;
  
  /* XXX not sure how to recalculate this ... */
  tmenuscroll = 0;
}

void editor::fullclear(tile t) {
  for(int x = 0; x < dr.lev->w; x ++) {
    for(int y = 0; y < dr.lev->h; y ++) {
      dr.lev->settile(x, y, t);
    }
  }
}

/* XXX limit to selection */
void editor::clear(tile bg, tile fg) {
  if (changed &&
      !message::quick(this,
		      "Clearing will destroy your unsaved changes.",
		      "Clear anyway",
		      "Don't clear")) {
    redraw();
    return;
  }

  /* don't allow fill with panels or transporters */
  if (needsdest(bg)) bg = T_FLOOR;
  if (needsdest(fg)) fg = T_BLUE;

  fullclear(bg);
  for(int x = 0; x < dr.lev->w; x ++) {
    dr.lev->settile(x, 0, fg);
    dr.lev->settile(x, dr.lev->h - 1, fg);
  }
  for(int y = 0; y < dr.lev->h; y ++) {
    dr.lev->settile(0, y, fg);
    dr.lev->settile(dr.lev->w - 1, y, fg);
  }
  
  changed = 0;
  redraw();
}

void editor::draw() {

  /* check if we need to highlight a destination */
  int tx, ty;
  int sdx = -1, sdy = -1;
  if (dr.inmap(mousex, mousey, tx, ty)) {
    if (needsdest(layerat(tx, ty))) {
      dr.lev->getdest(tx, ty, sdx, sdy);
    }
  }

  sdlutil::clearsurface(screen, EDITORBGCOLOR);
  /* draw black for menu */
  { 
    SDL_Rect dst;
    dst.x = 0;
    dst.y = 0;
    dst.w = screen->w;
    dst.h = TILEH * 2;
    SDL_FillRect(screen, &dst, BGCOLOR);
  }

  int showw = (screen->w / TILEW) - 1;

  /* draw menu menu */

  /* could be showw + 1 */
  for(int j = 0; j < showw; j++) {

    if (j == POS_CURRENT) {
      dr.drawtile(j * TILEW, 0, current, 0);
    } else if (j == POS_LAYER) {
      drawing::drawtileu(j * TILEW, 0, layer?TU_LAYERALT:TU_LAYERNORMAL, 0);
    } else if (j == POS_CHANGED) {
      if (changed) drawing::drawtileu(j * TILEW, 0, TU_CHANGED, 0);
    } else if (j == POS_RANDTYPE) {
      drawing::drawtileu(j * TILEW, 0, TU_RANDTYPE, 0);
      fon->draw(j * TILEW + 14, 12, GREY + itos(randtype) + POP);
    } else if (j < NUM_MENUITEMS && edit_menuitem[j]) {
      drawing::drawtileu(j * TILEW, 0, edit_menuitem[j], 0);
    }
  }

  /* disable menu items where appropriate */

  if (filename == "") {
    drawing::drawtileu(POS_SAVE * TILEW, 0, TU_DISABLED, 0);
  }

  /* draw tile menu */
  int i;
  for(i = 0; i < showw; i++) {
    int tt = i + (showw * tmenuscroll);
    if (tt < NUM_TILES)
      dr.drawtile(i * TILEW, TILEH, tt, 0);
  }

  drawing::drawtileu(i * TILEW, TILEH, TU_TILESUD, 0);

  /* always point him down. */
  dr.drawlev(layer);
  /* ? */
  dr.drawextra();

  /* draw bot numbers */
  if (!dr.zoomfactor) {
    for(int b = 0; b < dr.lev->nbots; b++) {
      int bx, by;
      dr.lev->where(dr.lev->boti[b], bx, by);
      int bsx, bsy;
      if (dr.onscreen(bx, by, bsx, bsy)) {
	fon->draw(bsx + TILEW - fon->width, 
		  bsy + TILEH - fon->height,
		  YELLOW + itos(b + 1));
      }
    }
  }

  /* things that were previously warnings are now supported
     behavior. It might still be a good idea to warn about
     certain things? */
#if 0
  /* draw warnings */
  for(int wx = 0; wx < dr.lev->w; wx++)
    for(int wy = 0; wy < dr.lev->h; wy++) {
      int dummy;
      if (ispanel(layerat(wx, wy), dummy)) {

	int ddx, ddy;
	dr.lev->getdest(wx, wy, ddx, ddy);
	
	if ((ispanel(dr.lev->tileat(ddx, ddy), dummy) ||
	     ispanel(dr.lev->otileat(ddx, ddy), dummy)) &&
	    ((ddx == wx && (ddy == wy || ddy == (wy-1) || ddy == (wy+1))) ||
	     (ddy == wy && (ddx == wx || ddx == (wx-1) || ddx == (wx+1))))) {
	  /* WARNING: panel with self-destination or
	     destination of adjacent panel. */

	  dr.message = RED "Warning: " POP WHITE
	    "Panels should not target themselves or adjacent panels.";

	  int px, py;
	  if (dr.onscreen(wx, wy, px, py)) {
	    drawing::drawtileu(px, py, TU_WARNING, dr.zoomfactor);
	  }
	}
      }
    }
#endif

  /* draw destination, if it exists */
  {
    int px, py;
    if (sdx >= 0 && dr.onscreen(sdx, sdy, px, py)) {
      drawing::drawtileu(px, py, TU_TARGET, dr.zoomfactor);
    }
  }

  /* draw selection rectangle, if it exists */
  /* XXX this should allow the rectangle to be partially
     off-screen */
  if (selection.w > 0 &&
      selection.h > 0) {
    
    int px, py, pdx, pdy;
    if (dr.onscreen(selection.x, selection.y, px, py) &&
	dr.onscreen(selection.x + selection.w - 1,
		    selection.y + selection.h - 1,
		    pdx, pdy)) {
      
      pdx += (TILEW >> dr.zoomfactor) - 1;
      pdy += (TILEH >> dr.zoomfactor) - 1;

      sdlutil::drawline(screen, px, py, px, pdy, SELRECTCOLOR);
      sdlutil::drawline(screen, px, py, pdx, py, SELRECTCOLOR);
      sdlutil::drawline(screen, pdx, py, pdx, pdy, SELRECTCOLOR);
      sdlutil::drawline(screen, px, pdy, pdx, pdy, SELRECTCOLOR);


      sdlutil::drawline(screen, px + 1, py + 1, px + 1, pdy - 1, 
			SELRECTCOLOR2);
      sdlutil::drawline(screen, px + 1, py + 1, pdx - 1, py + 1, 
			SELRECTCOLOR2);
      sdlutil::drawline(screen, pdx - 1, py + 1, pdx - 1, pdy - 1, 
			SELRECTCOLOR2);
      sdlutil::drawline(screen, px + 1, pdy - 1, pdx - 1, pdy - 1, 
			SELRECTCOLOR2);

      

      sdlutil::drawline(screen, px + 2, py + 2, px + 2, pdy - 2, 
			SELRECTCOLOR);
      sdlutil::drawline(screen, px + 2, py + 2, pdx - 2, py + 2, 
			SELRECTCOLOR);
      sdlutil::drawline(screen, pdx - 2, py + 2, pdx - 2, pdy - 2, 
			SELRECTCOLOR);
      sdlutil::drawline(screen, px + 2, pdy - 2, pdx - 2, pdy - 2, 
			SELRECTCOLOR);


    }
  }
}

void editor::tmenurotate(int n) {

  tmenuscroll += n;

  int showw = (screen->w / TILEW) - 1;

  if (tmenuscroll * showw >= NUM_TILES) tmenuscroll = 0;

  /* largest possible */
  if (tmenuscroll < 0) { 
    int tt = 0;
    while ((tt * showw) < NUM_TILES) {
      tt ++;
    }
    tmenuscroll = tt - 1;
  }

  redraw();
}

void editor::settitle() {
  prompt * pp = prompt::create();
  extent<prompt> ep(pp);
  pp->title = (string)"Title for level: ";
  pp->below = this;
  pp->input = dr.lev->title;

  pp->posx = 30;
  pp->posy = 120;
		
  dr.lev->title = pp->select();

  changed = 1;
  redraw ();
}

void editor::setauthor() {
  prompt * pp = prompt::create();
  extent<prompt> ep(pp);
  pp->title = (string)"Author of level: ";
  pp->below = this;

  if (dr.lev->author == "")
    dr.lev->author = plr->name;
  pp->input = dr.lev->author;

  pp->posx = 30;
  pp->posy = 120;
		
  dr.lev->author = pp->select();

  changed = 1;
  redraw();
}

/* XXX warn if saving into managed directory */
void editor::saveas() {
  prompt * pp = prompt::create();
  extent<prompt> ep(pp);
  pp->title = (string)"Filename: ";
  pp->below = this;

  if (filename == "") pp->input = (string)EDIT_DIR + (string) DIRSEP;
  else                pp->input = filename;

  pp->posx = 30;
  pp->posy = 120;
		
  string nfn = pp->select();

  /* if cancelled, don't do anything */
  if (nfn == "") { 
    redraw();
    return;
  }

  filename = util::ensureext(nfn, ".esx");

  save();
}

void editor::playerstart() {
  clearselection();

  int x, y;
  
  if (getdest(x, y, "click to choose player start")) {
    if (!dr.lev->botat(x, y)) {
      dr.lev->guyx = x;
      dr.lev->guyy = y;
      changed = 1;
    } else {
      message::no(this, "Can't put player on bots");
    }
  }

  redraw();
}

/* XXX target selection? */
void editor::erasebot() {
  clearselection();
  
  int x, y;
  if (getdest(x, y, (string)"click on bot to erase")) {

    int i;
    if (dr.lev->botat(x, y, i)) {
      /* reduce number of bots and shift every one bigger
	 than this one down */
      dr.lev->nbots --;
      for(int m = i; m < dr.lev->nbots; m ++) {
	dr.lev->bott[m] = dr.lev->bott[m + 1];
	dr.lev->boti[m] = dr.lev->boti[m + 1];
	dr.lev->botd[m] = dr.lev->botd[m + 1];
      }
      /* not necessary to make arrays smaller. */

      changed = 1;
    } else dr.message = "No bot there!";
  }
  redraw ();
}

void editor::firstbot() {
  int x, y;
  if (getdest(x, y, (string)"click on bot to make #1")) {

    int i;
    if (dr.lev->botat(x, y, i)) {
      level * l = dr.lev->clone ();
      extent<level> el(l);
      
      dr.lev->bott[0] = l->bott[i];
      dr.lev->botd[0] = l->bott[i];
      dr.lev->boti[0] = l->boti[i];

      /* now copy rest */
      int r = 1;
      for(int b = 0; b < l->nbots; b++) {
	if (b != i) {
	  dr.lev->bott[r] = l->bott[b];
	  dr.lev->botd[r] = l->bott[b];
	  dr.lev->boti[r] = l->boti[b];
	  r ++;
	}
      }
    } else dr.message = "No bot there!";
  }
  redraw ();
}


void editor::placebot(bot b) {
  clearselection ();

  int x, y;
  
  if (dr.lev->nbots < LEVEL_MAX_ROBOTS) {

    int n = dr.lev->nbots + 1;
    if (getdest(x, y, (string)"click to place bot type " + itos((int)b))) {

      if (!(dr.lev->botat(x, y) || dr.lev->playerat(x, y))) {
	int * ni = (int*)malloc(sizeof(int) * n);
	bot * nt = (bot*)malloc(sizeof(bot) * n);
	
	for(int i = 0; i < dr.lev->nbots; i ++) {
	  ni[i] = dr.lev->boti[i];
	  nt[i] = dr.lev->bott[i];
	}
	
	
	ni[n - 1] = dr.lev->index(x, y);
	nt[n - 1] = b;
	free(dr.lev->boti);
	free(dr.lev->bott);
	dr.lev->boti = ni;
	dr.lev->bott = nt;
	dr.lev->nbots = n;
	
	/* need to update directions, too */
	free(dr.lev->botd);
	dr.lev->botd = (dir*)malloc(sizeof (dir) * n);
	for(int z = 0; z < n; z ++) dr.lev->botd[z] = DIR_DOWN;
	changed = 1;
      } else {
	message::no(this, "Can't put two bots in the same place, "
		    "or on the player!");
      }
    }

    redraw();
  } else {
    message::no(this, 
		"Maximum robots (" + itos(LEVEL_MAX_ROBOTS) + ") reached!");
    redraw();
  }
}

void editor::save() {
  clearselection ();

  fixup();

  if (filename != "") {

    string old = readfile(filename);

    string nstr = dr.lev->tostring();

    if (writefile(filename, nstr)) {
      dr.message = "wrote " + filename;
    } else {
      dr.message = RED "error writing to " + filename + POP;
      filename = "";
    }

    if (old != "") {
      /* if player has solution for the
	 level existing in the file that we're
	 overwriting, try it out on the new
	 file. (We may just be changing something
	 cosmetic!) */

      string omd5 = md5::hash(old);      

      string nmd5 = md5::hash(nstr);
      /* only try if level changed */
      if (omd5 != nmd5) {

	/* do not free */
	solution * sol = plr->getsol(omd5);

	if (sol && level::verify(dr.lev, sol)) {
	  /* It still works! */
	
	  plr->putsol(nmd5, sol->clone());
	  plr->writefile();

	  dr.message += " " YELLOW "(recovered solution)" POP;
	}
      }
    }     
    
    /* on success, we clear changed flag */
    changed = 0;

  } else {
    message::bug(this, 
		 "shouldn't be able to save with empty filename");
  }

  redraw();
}

/* XXX should warn if you load from a managed directory. */
/* target selection? */
void editor::load() {
  clearselection();

  loadlevel * ll = loadlevel::create(plr, EDIT_DIR, true, true);
  if (!ll) {
    message::quick(this, "Can't open load screen!", 
		   "Ut oh.", "", PICS XICON POP);
    redraw ();
    return ;
  }
  string res = ll->selectlevel();
  string ss = readfile(res);
  ll->destroy ();

  /* allow corrupted files */
  level * l = level::fromstring(ss, true);

  if (l) { 
    dr.lev->destroy();
    dr.lev = l;
    filename = res;
    dr.message = ((string)"loaded " + filename);

    fixup();
    changed = 0;
  } else {
    dr.message = ((string) RED "error loading " + res + POP);
  }
 
  redraw();
}

editor::~editor() {}

void editor::resize() {
  clearselection();

  string nw = itos(dr.lev->w);
  string nh = itos(dr.lev->h);

  textinput twidth;
  twidth.question = "Width";
  twidth.input = nw;
  twidth.explanation =
    "Width of the level in tiles.";

  textinput theight;
  theight.question = "Height";
  theight.input = nh;
  theight.explanation =
    "Height of the level in tiles.";

  okay ok;
  ok.text = "Change Size";
  
  ptrlist<menuitem> * l = 0;

  ptrlist<menuitem>::push(l, &ok);
  ptrlist<menuitem>::push(l, &theight);
  ptrlist<menuitem>::push(l, &twidth);

  menu * mm = menu::create(this, "Level Size", l, false);

  ptrlist<menuitem>::diminish(l);

  if (mm->menuize() == MR_OK) {
    int nnw = atoi(twidth.input.c_str());
    int nnh = atoi(theight.input.c_str());

    if (nnw > 0 && nnw <= LEVEL_MAX_WIDTH &&
	nnh > 0 && nnh <= LEVEL_MAX_HEIGHT &&
	(nnw * nnh <= LEVEL_MAX_AREA)) {
      dr.lev->resize(nnw, nnh);
      
      /* reset scroll position */
      dr.scrollx = 0;
      dr.scrolly = 0;
      
      changed = 1;
    } else {
      message::quick(this,
		     "Size too large/small", 
		     "Sorry", "");
      
    }
  } /* XXX else MR_QUIT */

  redraw();
}

void editor::edit(level * origlev) {
  
  if (origlev) {
    dr.lev = origlev->clone();
  } else {
    dr.lev = level::defboard(18, 10);
  }

  dr.scrollx = 0;
  dr.scrolly = 0;
  dr.posx = XOFF;
  dr.posy = YOFF;
  dr.width = XW;
  dr.height = YH;
  dr.margin = 12;

  clearselection();

  olddest = -1;

  mousex = 0;
  mousey = 0;
  changed = 0;

  SDL_Event event;

  dr.message = "";

  saved = solution::empty();

  fixup ();

  redraw ();

  for(;;) {
    //  while ( SDL_WaitEvent(&event) >= 0 ) {
    while ( SDL_PollEvent(&event) ) {

      switch(event.type) {

      case SDL_MOUSEMOTION: {
	/* some more efficient way to do this?? */
	/* we only need to redraw if something 
	   has changed like mousing over a tile
	   with a destination */

	SDL_MouseMotionEvent * e = (SDL_MouseMotionEvent*)&event;

	/* we do a lot of stuff here. set this flag if
	   we need to redraw at the end. */
	int yesdraw = 0;

	int omx = mousex;
	int omy = mousey;

	mousex = e->x;
	mousey = e->y;

	/* if mouse down, draw line of tiles.
	   don't do it if they need destinations. */
	int otx, oty;
	int ntx, nty;


	/* right mouse button ... */
	if ((e->state & SDL_BUTTON(SDL_BUTTON_RIGHT)) &&
	    selection.w > 0 &&
	    dr.inmap(mousex, mousey, ntx, nty)) {

	  /* change selection rectangle */
	  int nw = 1 + (ntx - selection.x);
	  int nh = 1 + (nty - selection.y);
	  
	  if (nw != selection.w ||
	      nh != selection.h) {

	    if (nw <= 0 || nh <= 0) { nw = nh = 0; }

	    selection.w = nw;
	    selection.h = nh;
	    redraw ();
	  }

	  /* left mouse button ... */
	  /* XXX if I start in the map, then I should
	     always draw to the edge, even if the end
	     is not in the map */
	} else if (!needsdest(current) &&
		   !donotdraw &&
		   e->state & SDL_BUTTON(SDL_BUTTON_LEFT) &&
		   dr.inmap(omx, omy, otx, oty) &&
		   dr.inmap(mousex, mousey, ntx, nty)) {

	  if (otx != ntx ||
	      oty != nty) {
	    /* draw line. */
	    line * sl = line::create(otx, oty, ntx, nty);
	    extent<line> el(sl);
	    
	    int cx = otx, cy = oty;
	    
	    do {
	      setlayer(cx, cy, current);

	    } while (sl->next(cx, cy));

	    changed = 1;
	    /* always draw */
	    yesdraw = 1;
	  } else {
	    /* draw pixel */
	    
	    if ((layer?(dr.lev->otileat(ntx, nty))
		 :(dr.lev->tileat(ntx, nty)))
		!= current) {
	      setlayer(ntx, nty, current);
	      yesdraw = 1;
	      changed = 1;
	    }

	  }
	}

	/* calculate the destination to draw,
	   if any. */
	int tx, ty;
	if (dr.inmap(mousex, mousey, tx, ty)) {
	  if (needsdest(layerat(tx, ty))) {
	    if (dr.lev->destat(tx, ty) != olddest) {
	      olddest = dr.lev->destat(tx, ty);
	      yesdraw = 1;
	    }
	    /* XXX unify with next case */
	  } else {
	    if (olddest != -1) {
	      olddest = -1;
	      yesdraw = 1;
	    } 
	  }
	} else {
	  if (olddest != -1) {
	    olddest = -1;
	    yesdraw = 1;
	  }
	}

	if (yesdraw) redraw();

	break;
      }
      case SDL_MOUSEBUTTONDOWN: {
	SDL_MouseButtonEvent * e = (SDL_MouseButtonEvent*)&event;

	/* any click in this state puts us in drawing mode. */
	donotdraw = false;

	if (e->button == SDL_BUTTON_MIDDLE) {

	  int tx, ty;
	  if (dr.inmap(e->x, e->y, 
		       tx, ty)) {
	    
	    current = layer?dr.lev->otileat(tx, ty):dr.lev->tileat(tx, ty);
	    
	    redraw();
	  }
	  
	} else if (e->button == SDL_BUTTON_RIGHT) {
	  /* Start drawing selection rectangle */
	  int tx, ty;
	  if (dr.inmap(e->x, e->y, tx, ty)) {
	    selection.x = tx;
	    selection.y = ty;
	    
	    selection.w = 1;
	    selection.h = 1;
	  } else selection.w = 0;
	  redraw ();

	} else if (e->button == SDL_BUTTON_LEFT) {

	  int showw = (screen->w / TILEW) - 1;

	  /* on tile menu? */
	  if (e->y >= TILEH &&
	      e->y < (2 * TILEH)) {

	    if (e->x >= (TILEW * showw) &&
		e->x < (TILEW * (showw + 1))) {
	      
	      if (e->y < TILEH + (TILEH >> 1))
		tmenurotate(-1);
	      else tmenurotate(1);

	    } else if (/* e->x always >= 0 && */
		       e->x < (showw * TILEW)) {
	      
	      int tt = (e->x / TILEW) + (tmenuscroll * showw);

	      if (tt >= 0 && tt < NUM_TILES) current = tt;

	      redraw();

	    } /* else nothing. */
	    


	  } else if (/* e->y always >= 0 && */
		     e->y < TILEH) {
	    /* menu */

	    int n = e->x / TILEW;

	    dr.message = itos(n);

	    redraw();

	    if (n < NUM_MENUITEMS) {
	      
	      /*
		TU_SAVE, TU_SAVEAS, TU_LOAD,
		TU_TITLE, TU_AUTHOR, TU_SIZE,
		TU_PLAYERSTART, TU_CLEAR,
		TU_PLAY, TU_RANDOM,
	      */

	      if (n == POS_LAYER) {
		layer = !layer;
		redraw ();
	      } else switch(edit_menuitem[n]) {

	      case TU_SIZE:
		resize();
		break;

	      case TU_PLAYERSTART:
		playerstart();
		break;

	      case TU_DALEK:
		placebot(B_DALEK);
		break;

	      case TU_HUGBOT:
		placebot(B_HUGBOT);
		break;

	      case TU_BROKEN:
		placebot(B_BROKEN);
		break;

	      case TU_ERASE_BOT:
		erasebot();
		break;

	      case TU_FIRST_BOT:
		firstbot();
		break;

	      case TU_LOAD:
		load();
		break;

	      case TU_AUTHOR:
		setauthor();
		break;

	      case TU_TITLE:
		settitle();
		break;

	      case TU_RANDOM:
		dorandom();
		break;
		
	      case TU_RANDTYPE:
		randtype ++;
		randtype %= NUM_RANDTYPES;
		dr.message = ainame(randtype);
		redraw();
		break;

	      case TU_SAVEAS:
		saveas();
		break;
		
	      case TU_SAVE:
		if (filename == "") saveas();
		else save();
		break;

	      case TU_PLAY: {
		/* XXX check result for 'exit' */
		fixup();

		play * pla = play::create();
		extent<play> ep(pla);
		
		/* playresult res = */ pla->doplay_save(plr, dr.lev, saved);

		redraw();
		break;
	      }
	      case TU_CLEAR:
		clear(T_FLOOR, (tile)current);
		break;
	      default: ;

	      }

	    } /* else outside menu */


	  } else {
	    int tx, ty;

	    clearselection();

	    if (dr.inmap(e->x, e->y, 
			 tx, ty)) {
	      /* drawing area */

	      setlayer(tx, ty, current);

	      if (needsdest(current)) {

		int xx, yy;
		if (getdest(xx, yy, "click to set destination")) {
		  dr.lev->setdest(tx, ty, xx, yy);
		} else {
		  setlayer(tx, ty, T_FLOOR);
		}
		olddest = dr.lev->destat(tx, ty);

	      }

	      changed = 1;
	      redraw();
	    }
	  }


	} else if (e->button == SDL_BUTTON_RIGHT) {
	  /* on tile menu? if so, rotate. */

	  if (e->y > TILEH &&
	      e->y <= (2 * TILEH)) {
	    tmenurotate(1);
	  }

	}
	
	break;
      }

      case SDL_QUIT: goto edit_quit;
      case SDL_KEYDOWN:
	switch(event.key.keysym.sym) {

	case SDLK_UP:
	case SDLK_DOWN:
	case SDLK_RIGHT:
	case SDLK_LEFT: {

	  dir d = DIR_NONE;
	  switch(event.key.keysym.sym) {
	  case SDLK_DOWN: d = DIR_DOWN; break;
	  case SDLK_UP: d = DIR_UP; break;
	  case SDLK_RIGHT: d = DIR_RIGHT; break;
	  case SDLK_LEFT: d = DIR_LEFT; break;
	  default: ; /* impossible - lint */
	  }

	  
	  if ((event.key.keysym.mod & KMOD_CTRL) &&
	      selection.w > 0) {

	    int dx, dy;
	    dirchange(d, dx, dy);

	    /* tx, ty are the start of the destination
	       of this block move */
	    int tx, ty;
	    /* but first check that the far corner will
	       also be on the screen */
	    if (!dr.lev->travel(selection.x + selection.w - 1, 
				selection.y + selection.h - 1, 
				d, tx, ty)) break;


	    if (dr.lev->travel(selection.x, selection.y, d,
			       tx, ty)) {
	      /* easier if we clone. */
	      level * cl = dr.lev->clone();
	      extent<level> ecl(cl);

	      /* then blank out the region */
	      {
		for(int y = selection.y; y < selection.y + selection.h; y++) {
		  for(int x = selection.x; x < selection.x + selection.w; x++) {
		    dr.lev->settile(x, y, T_FLOOR);
		    dr.lev->osettile(x, y, T_FLOOR);
		    dr.lev->setdest(x, y, 0, 0);
		    dr.lev->setflag(x, y, 0);
		  }
		}
	      }

	      for(int y = selection.y; y < selection.y + selection.h; y++)
		for(int x = selection.x; x < selection.x + selection.w; x++) {

		  /* copy all the parts */
		  dr.lev->settile(x + dx, y + dy,
				  cl->tileat(x, y));

		  dr.lev->osettile(x + dx, y + dy,
				   cl->otileat(x, y));

		  {
		  int ddx, ddy;
		  cl->where(cl->destat(x, y), ddx, ddy);

		  /* if the destination is inside the
		     thing we're moving, then preserve it */
		  if ((needsdest(cl->tileat(x, y)) ||
		       needsdest(cl->otileat(x, y))) && 
		      ddx >= selection.x &&
		      ddx < (selection.x + selection.w) &&
		      ddy >= selection.y &&
		      ddy < (selection.y + selection.h)) {

		    ddx += dx;
		    ddy += dy;
		    
		  }

		  /* anyway copy dest */
		  dr.lev->setdest(x + dx, y + dy, ddx, ddy);
		  }
		  
		  /* finally, flags */
		  dr.lev->setflag(x + dx, y + dy,
				  cl->flagat(x, y));

		}

	      /* move player, bots */
	      if (dr.lev->guyx >= selection.x &&
		  dr.lev->guyy >= selection.y &&
		  dr.lev->guyx < (selection.x + selection.w) &&
		  dr.lev->guyy < (selection.y + selection.h)) {
		dr.lev->guyx += dx;
		dr.lev->guyy += dy;

		/* if moving over bot (on edge), delete it */
		if (dr.lev->guyx < selection.x ||
		    dr.lev->guyy < selection.y ||
		    dr.lev->guyx >= (selection.x + selection.w) ||
		    dr.lev->guyy >= (selection.y + selection.h)) {
		  int bi;
		  if (dr.lev->botat(dr.lev->guyx, dr.lev->guyy, bi)) {
		    dr.lev->bott[bi] = B_DELETED;
		  }
		}

	      }

	      {
		for(int i = 0; i < dr.lev->nbots; i ++) {

		  int bx, by;
		  dr.lev->where(dr.lev->boti[i], bx, by);
		  if (bx >= selection.x &&
		      by >= selection.y &&
		      bx < (selection.x + selection.w) &&
		      by < (selection.y + selection.h)) {
		    bx += dx;
		    by += dy;

		    /* destroy any bot we're overwriting
		       (but not if it's in the selection, because
		       then it will move, too) */
		    int bi;
		    if (bx < selection.x ||
			by < selection.y ||
			bx >= (selection.x + selection.w) ||
			by >= (selection.y + selection.h)) {
		      
		      if (dr.lev->botat(bx, by, bi)) {
			/* overwrite bot */
			dr.lev->bott[bi] = B_DELETED;
		      } else if (dr.lev->playerat(bx, by)) {
			/* Delete self if trying to
			   overwrite player! */
			dr.lev->bott[i] = B_DELETED;
		      }
		    }
		  }
		    
		    /* move bot (even if deleted) */
		  dr.lev->boti[i] = dr.lev->index(bx, by);
		}
	      }

	      /* move selection with it, but don't change size */
	      selection.x = tx;
	      selection.y = ty;

	      fixup();
	    } /* would move stay on screen? */


	    redraw();
	  } else {

	    /* move scroll window */
    
	    int dx, dy;
	    dirchange(d, dx, dy);
	    dr.scrollx += dx;
	    dr.scrolly += dy;
	    
	    dr.makescrollreasonable();
	    
	    redraw();
	    
	  }
	}
	  break;

	case SDLK_ESCAPE:
	  if (changed) {
	    if (message::quick(this,
			       "Quitting will destroy your unsaved changes.",
			       "Quit anyway.",
			       "Don't quit.")) {
	      goto edit_quit;
	    } else {
	      redraw();
	    }
	  } else goto edit_quit;

	case SDLK_RETURN:
	  /* XXX center scroll on mouse */
	  break;

	case SDLK_r:
	  dorandom();
	  break;

	case SDLK_w:
	  randtype ++;
	  randtype %= NUM_RANDTYPES;
	  dr.message = ainame(randtype);
	  redraw();
	  break;

	case SDLK_z:
	  resize();
	  break;

	case SDLK_c:
	  clear(T_FLOOR, (tile)current);
	  break;

	case SDLK_e:
	  playerstart();
	  break;

	case SDLK_o:
	  erasebot();
	  break;

	case SDLK_f:
	  firstbot();
	  break;

	case SDLK_k:
	  placebot(B_DALEK);
	  break;

	case SDLK_h:
	  placebot(B_HUGBOT);
	  break;

	case SDLK_u:
	  setauthor();
	  break;

	case SDLK_d:
	  if (event.key.keysym.mod & KMOD_CTRL) {
	    clearselection();
	    redraw();
	  }
	  break;

	case SDLK_a:
	  if (event.key.keysym.mod & KMOD_CTRL) {
	    selection.x = 0;
	    selection.y = 0;
	    selection.w = dr.lev->w;
	    selection.h = dr.lev->h;
	    redraw();
	  } else {
	    saveas();
	  }
	  break;

	case SDLK_F2:
	case SDLK_t:
	  settitle();
	  break;

	case SDLK_s:
	  if (filename == "") saveas();
	  else save();
	  break;

	case SDLK_p: {
	  /* XXX make function: same code above */
	  /* XXX check result for 'exit' */
	  fixup();
	  
	  play * pla = play::create();
	  extent<play> ep(pla);
	  
	  /* playresult res = */ pla->doplay_save(plr, dr.lev, saved);

	  redraw();
	  break;
	}
	case SDLK_l:
	  load();
	  break;

	case SDLK_y:
	  layer = !layer;
	  redraw();
	  break;

	case SDLK_KP_MINUS:
	case SDLK_MINUS:
	case SDLK_PAGEUP:
	  tmenurotate(-1);
	  break;

	case SDLK_KP_PLUS:
	case SDLK_PLUS:
	case SDLK_EQUALS:
	case SDLK_PAGEDOWN:
	  tmenurotate(1);
	  break;
	  
	  /* zoom */
	case SDLK_LEFTBRACKET:
	case SDLK_RIGHTBRACKET:
	  dr.zoomfactor += (event.key.keysym.sym == SDLK_LEFTBRACKET)? +1 : -1;
	  if (dr.zoomfactor < 0) dr.zoomfactor = 0;
	  if (dr.zoomfactor >= DRAW_NSIZES) dr.zoomfactor = DRAW_NSIZES - 1;

	  /* scrolls? */
	  dr.makescrollreasonable();

	  redraw();
	  break;

	default:
	  break;
	}
	break;
      case SDL_VIDEORESIZE: {
	SDL_ResizeEvent * eventp = (SDL_ResizeEvent*)&event;
	screen = sdlutil::makescreen(eventp->w, 
				     eventp->h);

	screenresize();
	redraw ();
	break;
      }
      case SDL_VIDEOEXPOSE:
	redraw();
	break;
      default: break;
      }
    }
    
    SDL_Delay(25);
  }
 edit_quit:
  
  dr.lev->destroy();

  return;
}

bool editor::getdest(int & x, int & y, string msg) {
  clearselection ();

  SDL_Event event;

  dr.message = msg;

  draw();
  SDL_Flip(screen);

  for(;;) {
    while ( SDL_PollEvent(&event) ) {

      switch(event.type) {

      case SDL_MOUSEBUTTONDOWN: {
	SDL_MouseButtonEvent * e = (SDL_MouseButtonEvent*)&event;

	/* we don't want this click (and drag) to result in
	   drawing. */
	donotdraw = true;

	if (e->button == SDL_BUTTON_LEFT) {
	  
	  int tx, ty;
	  if (dr.inmap(e->x, e->y, 
		       tx, ty)) {

	    x = tx;
	    y = ty;

	    dr.message = itos(tx) + (string)", " + itos(ty);
	    return 1;
	  }
	  /* other clicks cancel */
	} else return 0;
	break;
      }

      case SDL_QUIT: return 0;
      case SDL_KEYDOWN:
	switch(event.key.keysym.sym) {
	  /* XXX need to support scrolling arrows here */
	case SDLK_ESCAPE:
	  return 0;
	default:
	  break;
	}
	break;
      case SDL_VIDEORESIZE: {
	SDL_ResizeEvent * eventp = (SDL_ResizeEvent*)&event;
	screen = sdlutil::makescreen(eventp->w, 
				     eventp->h);

	screenresize();
	draw ();
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
    
    SDL_Delay(25);
  }
  /* XXX unreachable */
  return 0;
}


/* fix various things before playing or saving. */
void editor::fixup () {

  /* XXX should fon->parens the texts */

  level * l = dr.lev;

  if (l->title == "") l->title = "Untitled";
  if (l->author == "") l->author = plr->name;
  if (l->author == "") l->author = "Anonymous";

  for(int i = 0; i < l->w * l->h; i ++) {

    /* always clear 'temp' flag. */
    l->flags[i] &= ~(TF_TEMP);

    /* make sure panel flag is set if tile is a panel.
       we have to also set the flag refinement: is it
       a regular, blue, green, or red panel?
    */
    /* first remove the flags no matter what. (we don't
       want to accumulate *extra* flags) */
    l->flags[i] &= ~(TF_HASPANEL | TF_RPANELL | TF_RPANELH);
    l->flags[i] &= ~(TF_OPANEL | TF_ROPANELL | TF_ROPANELH);

    /* restore them where appropriate */
    int ref;
    if (ispanel(l->tiles[i], ref)) {
      l->flags[i] |= TF_HASPANEL | 
	             ((ref & 1) * TF_RPANELL) |
	            (((ref & 2) >> 1) * TF_RPANELH);
    }

    if (ispanel(l->otiles[i], ref)) {
      l->flags[i] |= TF_OPANEL |
	             ((ref & 1) * TF_ROPANELL) |
	            (((ref & 2) >> 1) * TF_ROPANELH);
    }

    /* unset destination if not needed (makes
       smaller files because of longer runs) */
    if (!(needsdest(l->tiles[i]) ||
	  needsdest(l->otiles[i])))
      l->dests[i] = 0;

  }

  /* bots: remove deleted ones */
  {
    int bdi = 0;
    for(int bi = 0; bi < dr.lev->nbots; bi++) {
      if (dr.lev->bott[bi] >= 0 &&
	  dr.lev->bott[bi] < NUM_ROBOTS) {
	/* save bot */
	dr.lev->bott[bdi] = dr.lev->bott[bi];
	dr.lev->boti[bdi] = dr.lev->boti[bi];
	dr.lev->botd[bdi] = dr.lev->botd[bi];
	bdi ++;
      }
    }
    
    dr.lev->nbots = bdi;
  }
}

editor * editor::create(player * p) {

  editor * ee = new editor();

  ee->randtype = RT_MAZE;
  ee->plr = p;
  extent<editor> exe(ee);

  ee->current = T_BLUE;
  ee->layer = 0;
  ee->tmenuscroll = 0;
  
  ee->changed = 0;

  if (!ee->plr) return 0;

  exe.release();
  return ee;
}

