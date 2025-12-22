
#include "SDL.h"
#include "SDL_image.h"
#include <math.h>
#include "level.h"
#include "sdlutil.h"
#include "draw.h"

#include "escapex.h"
#include "play.h"

#include "extent.h"
#include "message.h"
#include "chars.h"
#include "util.h"
#include "dirindex.h"
#include "md5.h"
#include "prefs.h"
#include "prompt.h"

#include "aevent.h"
#include "animation.h"
#include "dirt.h"
#include "sound.h"
#include "optimize.h"

#define POSTDRAW ;

/* for observing frame by frame -- slooow */
// #define POSTDRAW SDL_Delay (300);

/* medium speed */
// #define POSTDRAW SDL_Delay (100);

struct preal : public play {

  bool waitenter();
  virtual void draw ();
  virtual void screenresize();

  virtual playresult doplay_save(player *, level *, solution *& saved);

  virtual ~preal ();

  /* debugging */
  int layer;
  
  drawing dr;
  /* current solution.
     Its lifetime is within a call to doplay_save.
     Don't call redraw when not inside a call to doplay_save! */
  solution * sol;

  static preal * create();
  void redraw ();

  void videoresize(SDL_ResizeEvent * eventp);

  virtual void destroy() {
    delete this;
  }
};

play::~play () {}
preal::~preal () {}

play * play::create () {
  return preal::create();
}

preal * preal::create() {
  preal * pr = new preal();
  pr->layer = 0;
  pr->dr.margin = 12;
  return pr;
}

/* XXX debug */
static int cycle = 0;
#ifndef __amigaos4__
SDL_Event dummy[256];
#else /* !__amigaos4__ */
SDL_Event os4dummy[256];
#endif /* !__amigaos4__ */


void preal :: draw() {
  dr.setscroll();

  /* clear back */
  sdlutil::clearsurface(screen, BGCOLOR);

  /* layer only for debugging. should
     be considered a "cheat" */
  dr.drawlev(layer);
  dr.drawextra();
  fon->draw(screen->w - (fon->width * 5), 2,
	    itos(sol->length));
}

void preal :: redraw () {
  draw();
  SDL_Flip(screen);
}

void preal:: screenresize () {
  dr.width = screen->w;
  dr.height = screen->h - dr.posy;
}

void preal::videoresize(SDL_ResizeEvent * eventp) {
  screen = sdlutil::makescreen(eventp->w, 
			       eventp->h);
  screenresize();
  redraw();
}

typedef ptrlist<aevent> elist;
typedef ptrlist<animation> alist;

/* XXX Should shut off keyrepeat, treat holding as continuous
   movement now */
playresult preal::doplay_save(player * plr, level * start, 
			      solution *& saved) {
  /* we never modify 'start' */
  dr.lev = start->clone();
  extent<level> ec(dr.lev);
  
  disamb * ctx = disamb::create(start);
  extent<disamb> edc(ctx);

  sol = solution::empty();
  solution * saved_sol;

  /* if a solution was passed in, use it. */
  if (!saved) {
    saved_sol = solution::empty();
  } else {
    saved_sol = saved->clone ();
  }

  extent<solution> ess(saved_sol);
  extent<solution> eso(sol); 

  dr.scrollx = 0;
  dr.scrolly = 0;
  dr.posx = 0;
  dr.posy = fon->height + 2;
  dr.width = screen->w;
  dr.height = screen->h - dr.posy;

  redraw();

  SDL_Event event;

  dr.message = "";

  /* XX avoid creating if animation is off? */
  dirt * dirty = dirt::create();
  extent<dirt> edi(dirty);

  bool pref_animate = 
    prefs::getbool(plr, PREF_ANIMATION_ENABLED);


  for(;;) {
    //  while ( SDL_WaitEvent(&event) >= 0 ) {
    SDL_Delay(1);

    while ( SDL_PollEvent(&event) ) {

      switch(event.type) {
      case SDL_QUIT: goto play_quit;
      case SDL_KEYDOWN:

	switch(event.key.keysym.sym) {
	case SDLK_ESCAPE:
	  goto play_quit;

	case SDLK_RETURN:
	  dr.lev->destroy();
	  sol->clear();
	  dr.lev = start->clone();
	  ec.replace(dr.lev);
	  redraw();
	  break;

	  /* debugging "cheats" */
	case SDLK_LEFTBRACKET:
	case SDLK_RIGHTBRACKET:
	  dr.zoomfactor += (event.key.keysym.sym == SDLK_LEFTBRACKET)? +1 : -1;
	  if (dr.zoomfactor < 0) dr.zoomfactor = 0;
	  if (dr.zoomfactor >= DRAW_NSIZES) dr.zoomfactor = DRAW_NSIZES - 1;

	  /* fix scrolls */
	  dr.makescrollreasonable();
	  redraw ();
	  break;

	case SDLK_y:
	  layer = !layer;
	  redraw();
	  break;

	case SDLK_s:
	  saved_sol->destroy();
	  saved_sol = sol->clone();
	  ess.replace(saved_sol);
	  break;

	case SDLK_i: {
	  /* import moves for solution
	     to different puzzle */
	  
	  prompt * pp = prompt::create();
	  extent<prompt> ep(pp);
	  pp->title = (string)PICS QICON POP 
	              " What solution? (give md5 of level) :";
	  pp->posx = 30;
	  pp->posy = 30;
	  pp->below = this;

	  string answer = pp->select();
	  string md;

	  if (md5::unascii(answer, md)) {
	    solution * that;
	    if ( (that = plr->getsol(md)) ) {
	      
	      sol->appends(that);
	      
	      dr.lev->play(that);

	      redraw();

	      /* XXX check dead, win conditions */
	      int dummy;
	      dir dummy2;
	      if (dr.lev->isdead(dummy, dummy, dummy2)) {
		message::no(this, "That kills you!!");
		goto play_quit;
	      }

	      if (dr.lev->iswon()) {
		message::no(this, "That wins!! " RED "(unimplemented)" POP);
		goto play_quit;
	      }


	    } else message::no(this, "Sorry, not solved!");
	  } else message::no(this, "Bad MD5");

	  redraw();

	  break;
	}

	  /* XXX should check that the player didn't
	     die when replaying this solution, although
	     that is currently an invariant (I believe).
	  */
	case SDLK_r:
	  dr.lev->destroy();
	  dr.lev = start->clone();
	  ec.replace(dr.lev);

	  sol->destroy();
	  sol = saved_sol->clone ();
	  eso.replace(sol);

	  dr.lev->play(sol);

	  redraw();
	  break;

	  /* XXX allow undo when dead (or won?), too */
	case SDLK_u:
	  dr.lev->destroy();
	  dr.lev = start->clone();
	  ec.replace(dr.lev);

	  /* just trim off last move (don't need
	     to change allocation) */
	  if (sol->length > 0) sol->length--;

	  dr.lev->play(sol);

	  redraw();
	  break;


	case SDLK_DOWN:
	case SDLK_UP:
	case SDLK_RIGHT:
	case SDLK_LEFT: {
#ifdef __amigaos4__
#if 1                                               /* delay key-repeat */
     static Uint32 last_move_time = 0;
     Uint32 tmp_time = SDL_GetTicks();
     if (tmp_time < (last_move_time + 200)) break;
     last_move_time = tmp_time;
#endif
#endif /* __amigaos4__ */

	  /* move */
	  dir d = DIR_UP;
	  switch(event.key.keysym.sym) {
	  case SDLK_DOWN: d = DIR_DOWN; break;
	  case SDLK_UP: d = DIR_UP; break;
	  case SDLK_RIGHT: d = DIR_RIGHT; break;
	  case SDLK_LEFT: d = DIR_LEFT; break;
	  default: ; /* impossible - lint */
	  }

	  elist * events = 0;
	  alist * anims = 0;
	  /* sprites are drawn on top of everything */
	  alist * sprites = 0;

	  bool moved;

	  /* if animation is on, and we're not zoomed out,
	     then animate! */
	  if (pref_animate &&
	      !dr.zoomfactor) {
	    /* clear guy from screen.
	       this is always drawn on top of
	       everything, so eagerly clearing
	       it here makes sense.

	       after we call move, clearsprites
	       is worthless to us, since the
	       underlying level will have changed. */
	    animation::clearsprites(dr);

	    moved = dr.lev->move_animate(d, ctx, events);
	  } else {
	    moved = dr.lev->move(d);
	  }

	  /* loop playing animations. */
	  cycle ++; // XXX debugging
	  /* printf("== start animation cycle %d ==\n", cycle); */
	  while(sprites || anims || events) {
	    unsigned int now = SDL_GetTicks();

	    /* are we animating? if so, trigger 
	       the next animation action. */
	    if (anims || sprites) {

	      /* spin-wait until something is ready to think.
		 this is the only reason we draw */
	      bool ready = false;
	      do {
		// printf("  %d Checked!\n", cycle);
#if 1
	                 SDL_PumpEvents();
#ifndef __amigaos4__
	              	  if (SDL_PeepEvents(dummy, 256, SDL_PEEKEVENT, SDL_EVENTMASK(SDL_KEYDOWN)))
#else /* !__amigaos4__ */
	         	     if (SDL_PeepEvents(os4dummy, 256, SDL_PEEKEVENT, SDL_EVENTMASK(SDL_KEYDOWN))) {
#endif /* !__amigaos4__ */
#else
	                 if (SDL_PollEvent(&dummy[0]))
#endif
		  // printf("  %d did short circuit\n", cycle);
		  /* key waiting. abort! */
		  /* empty the lists and be done */
		  while (events) delete elist::pop(events);
		  while (anims) delete alist::pop(anims);
		  while (sprites) delete alist::pop(sprites);

		  goto end_turn;
		}

		bool only_finales = true;

		{
		  for(alist * atmp = anims; atmp && !ready; 
		      atmp = atmp -> next) {
		    if (!atmp->head->finale) only_finales = false;
		    if (atmp->head->nexttick < now) {
		      ready = true;
		    }
		  }
		}

		{
		  for(alist * atmp = sprites; atmp && !ready; 
		      atmp = atmp -> next) {
		    if (!atmp->head->finale) only_finales = false;
		    if (atmp->head->nexttick < now) {
		      ready = true;
		    }
		  }
		}

		/* if there are only finales, then we are ready.
		   (they will do their death wail) */
		if (only_finales) {
		  ready = true;
		}

		/* if nothing is ready, then don't chew CPU */
		/* XXX PERF ever delay when animations are going? */
		if (!ready) SDL_Delay(0);
		now = SDL_GetTicks ();
	      } while (!ready);

	      /* 

	      the new regime is this:

	      in each loop,
	        - erase all animations.
		- if any animation is ready to
		  think, make it think.
		  (the animation may 'become'
		   a different animation at
		   this point; call its init
		   method)
		- draw all active animations.
		- draw all active sprites on
		  top of that.

	      */

		if (0)
		printf("   %d : %s\n", __LINE__,
#ifndef __amigaos4__
    	       SDL_PeepEvents(dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#else /* !__amigaos4__ */
    	       SDL_PeepEvents(os4dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#endif /* !__amigaos4__ */

	      animation::erase_anims(anims, dirty);
	      animation::erase_anims(sprites, dirty);

	      /* reflect dirty rectangles action */
	      dirty->clean();

	      bool remirror = false;

	      animation::think_anims(&anims, now, remirror);
	      animation::think_anims(&sprites, now, remirror, !anims);

	      /* might need to save new background */
	      if (remirror) dirty->mirror();

	      /* now draw everything, but only if
		 there is something left. */

	      /* printf("\n == draw cycle == \n"); */
	      if (anims || sprites) {
		animation::draw_anims(anims);
		animation::draw_anims(sprites);
		
		SDL_Flip(screen);

		POSTDRAW ;
		/* if (pref_debuganim) SDL_Delay(80); */
	      }

	      if (0)
	      printf("   %d : %s\n", __LINE__,
#ifndef __amigaos4__
    	     SDL_PeepEvents(dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#else /* !__amigaos4__ */
    	     SDL_PeepEvents(os4dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#endif /* !__amigaos4__ */

	    } else {
	      /* no? then we should have some events queued
		 up to deal with. */

	      if (0)
	      printf("   %d : %s\n", __LINE__,
#ifndef __amigaos4__
    	     SDL_PeepEvents(dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#else /* !__amigaos4__ */
    	     SDL_PeepEvents(os4dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#endif /* !__amigaos4__ */

	      if (events) {
		unsigned int s = events->head->serial;
		/* push all events with the same serial */
		while (events && events->head->serial == s) {
		  aevent * ee = elist::pop(events);
		  extentd<aevent> eh(ee);
		  animation::start(dr, anims, sprites, ee);
		  sound::start(ee);
		}

		/* XXX nasty that we need to know dir d here */
		/* obsolete due to event invt! */
		/* animation::static_sprites(dr, sprites, d); */


		if (anims || sprites) {

		  bool domirror = false;
		  domirror = animation::init_anims(anims, now) || domirror;
		  domirror = animation::init_anims(sprites, now) || domirror;
		  
		  /* PERF check return code to be more efficient */
		  dirty->mirror();
		}

		if (0)
		printf("   %d : %s\n", __LINE__,
#ifndef __amigaos4__
    	       SDL_PeepEvents(dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#else /* !__amigaos4__ */
    	       SDL_PeepEvents(os4dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#endif /* !__amigaos4__ */

	      }
	    }
	  }


	end_turn:;

	  /* now end turn */
	  if (moved) {
	    /* add to solution, ... */

	    sol->append(d);

	    dr.message = "";

	    int dummy;
	    dir dummy2;

	    if (dr.lev->isdead(dummy, dummy, dummy2)) {

	      dr.message = RED "You died!" POP;

	      redraw();

	      if (message::quickv(this,
				  screen->h - fon->height*8,
				  "You've died.",
				  "Try again",
				  "Quit", PICS SKULLICON)) {
		dr.message = "";
		dr.lev->destroy();
		sol->clear();
		dr.lev = start->clone();
		ec.replace(dr.lev);
		redraw();
	      } else {
		goto play_quit;
	      }

	    } else if (dr.lev->iswon ()) {

	      dr.message = GREEN "Solved!" POP;

	      redraw();
	      message::quickv(this,
			      screen->h - fon->height*8,
			      "You solved it!!",
			      "Continue", "", PICS THUMBICON);

	      eso.release();

	      if (saved) saved->destroy();
	      saved = saved_sol->clone();
	      return playresult::solved(sol);

	    };

	    redraw();
	  } else {
	    /* change facing anyway */
	    redraw();
	  }

	  if (0)
	  printf("   %d : %s\n", __LINE__,
#ifndef __amigaos4__
       SDL_PeepEvents(dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#else /* !__amigaos4__ */
       SDL_PeepEvents(os4dummy, 256, SDL_PEEKEVENT, 0xFFFFFFFF)?"success":"none");
#endif /* !__amigaos4__ */

	  break;
	}
	default:;
	}
	break;
      case SDL_VIDEORESIZE: {
	SDL_ResizeEvent * eventp = (SDL_ResizeEvent*)&event;
	videoresize(eventp);
	/* sync size of dirty buffer */
	dirty->matchscreen();
	break;
      }
      case SDL_VIDEOEXPOSE:
	redraw();
	break;
      default: break;
      }
      SDL_Delay(1);
    }
    
  }
 play_quit:
  
  if (saved) saved->destroy();
  saved = saved_sol->clone();
  return playresult::quit();

}

void play::playrecord(string res, player * plr, bool allowrate) {
  /* only prompt to rate if this is in a
     web collection */
  bool iscollection;
  {
    string idx = 
      util::pathof(res) + (string)DIRSEP WEBINDEXNAME;
    dirindex * di = dirindex::fromfile(idx);
    iscollection = di?(di->webcollection ()):false;
    if (di) di->destroy();
  }

  string ss = readfile(res);

  /* load canceled */
  if (ss == "") return;

  level * lev = level::fromstring(ss);

  if (lev) { 

    play * pla = play::create();
    extent<play> ep(pla);

    playresult res = pla->doplay(plr, lev);

    if (res.type == PR_ERROR || res.type == PR_EXIT) {
      lev->destroy();

      /* XXX should return something different */
      return;

    } else if (res.type == PR_QUIT) {
      /* back to level selection */
      lev->destroy();

      return;

    } else if (res.type == PR_SOLVED) {
      /* write solution, using file on disk 
	 (we have no reason to believe that our
	 tostring function will give us what is
	 on disk--despite what this code used
	 to indicate ;)) */
      string md5 = md5::hash(ss);

      bool firstsol = (bool)!plr->getsol(md5);

      solution * sol = res.u.sol;
      solution * opt;

      /* free 'sol', and init 'opt' */
      if (prefs::getbool(plr, PREF_OPTIMIZE_SOLUTIONS)) {
	level * check = level::fromstring(ss);
	if (check) {
	  opt = optimize::opt(check, sol);
	  check->destroy ();
	} else opt = sol->clone ();
      } else {
	opt = sol->clone ();
      }
      sol->destroy ();
      
      /* takes over 'opt' pointer */
      if (plr->putsol(md5, opt)) {
	plr->writefile();
      }

      if (allowrate &&
	  plr->webid &&
	  firstsol &&
	  iscollection &&
	  !plr->getrating(md5) &&
	  prefs::getbool(plr, PREF_ASKRATE)) {

	ratescreen * rs = ratescreen::create(plr, lev, md5);
	if (rs) {
	  extent<ratescreen> re(rs);
	  rs->setmessage(YELLOW
			 "Please rate this level." POP
			 GREY " (You can turn off this "
			 "automatic prompt from the preferences menu.)" POP);
		  
	  rs->rate();
	} else {
	  message::bug(0, "Couldn't create rate object!");
	}

      }
      lev->destroy();

      /* load again ... */
      return;
    } else {
      printf ("????\n");
      return ;
    }

  } else return;
}
