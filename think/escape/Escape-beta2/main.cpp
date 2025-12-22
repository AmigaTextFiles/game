#include "level.h"
#include "sdlutil.h"

#include "util.h"
#include "escapex.h"
#include "font.h"
#include "load.h"
#include "extent.h"
#include "player.h"
#include "md5.h"
#include "prompt.h"
#include "draw.h"
#include "playerdb.h"
#include "message.h"

#include "edit.h"
#include "play.h"
#include "upgrade.h"
#include "update.h"
#include "mainmenu.h"
#include "registration.h"
#include "cleanup.h"
#include "prefs.h"
#include "dircache.h"

#include "handhold.h"
#include "animation.h"
#include "sound.h"

#define DEFAULT_DIR "."
#define PLAYERDB_FILE "players.esd"
#define SPLASH_FILE "splash.png"

SDL_Surface * screen;
string self;
/* XXX should be bools */
int network;
int audio;

/* for debugging, turn on noparachute */
// #define DEBUG_PARACHUTE 0
#define DEBUG_PARACHUTE SDL_INIT_NOPARACHUTE



int main (int argc, char ** argv) {

  /* change to location of binary. */
  if (argc > 0) {
    string wd = util::pathof(argv[0]);
    util::changedir(wd);

#   if WIN32
    /* on win32, the ".exe" may or may not
       be present. Also, the file may have
       been invoked in any CaSe. */

    self = util::lcase(util::fileof(argv[0]));

    self = util::ensureext(self, ".exe");

#   else
    self = util::fileof(argv[0]);
#   endif

  }

  /* set up md5 early */
  md5::init();

  /* clean up any stray files */
  cleanup::clean ();

  if (SDL_Init (SDL_INIT_VIDEO | 
                SDL_INIT_TIMER | 
		SDL_INIT_AUDIO | DEBUG_PARACHUTE) < 0) {

    /* try without audio */
    if (SDL_Init (SDL_INIT_VIDEO | 
		  SDL_INIT_TIMER | DEBUG_PARACHUTE) < 0) {
      
      printf("Unable to initialize SDL. (%s)\n", SDL_GetError());
      
      return 1;

    } else {
      audio = 0;
    }
  } else {
    audio = 1;
  }
  


  if(SDLNet_Init() == -1) {
    network = 0;
    printf("(debug) SDLNet_Init: %s\n", SDLNet_GetError());
  } else {
    network = 1;
  }

 
  sound::init ();

  SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, 
                      SDL_DEFAULT_REPEAT_INTERVAL);

  SDL_EnableUNICODE(1);

  /* set caption and icon */
  {
    SDL_WM_SetCaption("escape " VERSION, "");
    SDL_Surface * icon = IMG_Load("icon.png");
    if (icon) SDL_WM_SetIcon(icon, 0);
    /* XXX free icon? It's not clear where we
       can safely do this. */
  }

  screen = sdlutil::makescreen(STARTW, STARTH);

  if (!screen) {
    printf("Failed to create screen.\n");
    goto no_drawings;
  }

  /* draw splash while loading images. animation init
     takes some time! */

  {
    SDL_Surface * splash = sdlutil::imgload(SPLASH_FILE);
    if (splash) {
      SDL_Rect dst;
      dst.x = 2;
      dst.y = screen->h - (splash->h + 2);
      SDL_BlitSurface(splash, 0, screen, &dst);
      SDL_Flip(screen);

      SDL_FreeSurface(splash);
      
    }

  }

  /* XXX callback progress for ainit */
  if (!drawing::loadimages() || !animation::ainit()) {
    if (fon) message::bug(0, "Error loading graphics!");
    printf("Failed to load graphics.\n");
    goto no_drawings;
  }


# ifdef WIN32
  /* XXX this could display for unix and osx too, direct from the exec */
  /* Windows has some weird command line args stuff for an executable
     upgrading itself. See upgrade.cpp and replace.cpp for
     description. */ 

  if (argc == 2 &&
      !strcmp(argv[1], "-upgraded")) {

    message::quick(0, "Upgrade to version " VERSION " successful!",
                   "OK", "", PICS THUMBICON POP);

  }

# endif

  /* before we go to the player database, get rid of bad
     mousemotion events that the queue starts with. */
  sdlutil::eatevents(30, SDL_EVENTMASK(SDL_MOUSEMOTION));
  /* this may or may not be a good idea, now */
  SDL_WarpMouse((Uint16)(screen->w * 0.75f), 8);

  /* The "real" main loop. */
  /* XXX should put the following in some other function. */
  {
    playerdb * pdb;
    
    string pdbs = readfile(PLAYERDB_FILE);
    
    if (pdbs == "" || !(pdb = playerdb::fromstring(pdbs))) {

      pdb = playerdb::create();
      if (!pdb) {
        message::bug(0, "Error creating player database");
        goto oops;
      } else {
        writefile(PLAYERDB_FILE, pdb->tostring());
      }

      handhold::firsttime();

    } 

    player * plr = pdb->chooseplayer();

    /* XXX why write here? no change has occurred */
    writefile(PLAYERDB_FILE, pdb->tostring());

    pdb->destroy();

    if (!plr) goto oops;

    extent<player> ep(plr);


    /* selected player. now begin the game. */

    mainmenu * mm = mainmenu::create(plr);
    if (!mm) {
      message::bug(0, "Error creating main menu");
      goto oops;
    }

    extent<mainmenu> em(mm);

    while(1) {

      mainmenu::result r = mm->show();

      if (r == mainmenu::LOAD) {
        /* load and play levels */

        /* we stay in 'load' mode until
           the user hits escape on the load screen. */
        for(;;) {
          loadlevel * ll = 
	    loadlevel::create(plr, DEFAULT_DIR, true, false);
	  if (!ll) {
	    message::bug(0, "Error creating load screen");
	    break;
	  }
          string res = ll->selectlevel ();
	  
	  play::playrecord(res, plr);

	  ll->destroy ();

	  if (res == "") break;
        }

      } else if (r == mainmenu::EDIT) {
        /* edit a level */

        editor * ee = editor::create(plr);
        if (!ee) {
          message::bug(0, "Error creating upgrader");
          goto oops;
        }
        extent<editor> exe(ee);
        
        ee->edit();

      } else if (r == mainmenu::UPGRADE) {
        /* upgrade escape binaries and graphics */

        upgrader * uu = upgrader::create(plr);
        if (!uu) {
          message::bug(0, "Error creating upgrader");
          goto oops;
        }
        extent<upgrader> exu(uu);

        string msg;

        switch(uu->upgrade (msg)) {
        case UP_EXIT:
          /* force quit */
          goto done;
        default:
          break;
        }

      } else if (r == mainmenu::UPDATE) {
        /* update levels */

        updater * uu = updater::create(plr);
        if (!uu) {
          message::bug(0, "Error creating updater");
          goto oops;
        }
        extent<updater> exu(uu);

        string msg;

        uu->update (msg);

      } else if (r == mainmenu::REGISTER) {
        /* register player online */

        registration * rr = registration::create(plr);
        if (!rr) {
          message::bug(0, "Couldn't create registration object");
          goto oops;
        }
        
        extent<registration> exr(rr);

        rr->registrate();

      } else if (r == mainmenu::QUIT) {
        break;
      }

    }
  }
 done: ;

 oops: ;
  drawing::destroyimages();


 no_drawings: ;
  sound::shutdown();
  SDL_Quit();

  return 0;
}
