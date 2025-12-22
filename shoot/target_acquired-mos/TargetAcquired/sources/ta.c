/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

#include <SDL.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ta.h"
#include "scores.h"
#include "modern.h"
#include "game.h"

byte godlike, momentumconserved, speed;

char *speeds[9] = {
    "Comatose",
    "Pathetic",
    "Beginner",
    "Novice",
    "Normal",
    "Ace",
    "Insane",
    "Ridiculous",
    "Ludicrous"};

char *story[25] = {
    "Peace has reigned in the Galactic",
    "Federation for almost a century.",
    "However, the idyllic lives of two",
    "species were completely disrupted",
    "when the human ambassador was",
    "assassinated by the Entomorphs.  The",
    "only possible solution is a one-on-one",
    "trial by combat between one human and",
    "one Entomorph.",
    "",
    "Congratulations.  You've been selected",
    "to represent humanity.  Your superiors",
    "have provided you with the latest in",
    "starfighter technology: the X1723E",
    "StarBlazer.  It is the most",
    "maneuverable and best armed one-man",
    "craft in the Ten Thousand Worlds.",
    "",
    "And you\'ll need all the help you can",
    "get, because the Entomorphs are hive",
    "minds, and they\'ve sent an entire",
    "hive mind after you...",
    "",
    "The enemy fleet awaits.  The honor",
    "of humanity flies with you!"
};

char *endcredits[78] = {
    "The dark cosmos grows bright as",
    "the queen ships are destroyed.",
    "The entire hive mind, sensing the",
    "destruction of its core, self-destructs.",
    "In triumph, you return to Earth, and a",
    "hero's welcome.",
    " ",
    "Congratulations!  You have completed",
    "Target Acquired.",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    "T A R G E T   A C Q U I R E D",
    "Version 2.0",
    "_________________________________",
    " ",
    " ",
    "G A M E   D E S I G N",
    "__________________________",
    " ",
    "Michael C. Martin",
    " ",
    " ",
    "C O D I N G",
    "__________________",
    " ",
    "Michael C. Martin",
    "Brian Crabtree",
    " ",
    " ",
    "G R A P H I C S",
    "___________________",
    " ",
    "Rodney Reyes",
    "Justin Hammack",
    "Devin Lafontaine",
    " ",
    " ",
    "S P E C I A L   T H A N K S",
    "___________________________",
    " ",
    "One comes across a dilemma when porting a",
    "game from 7 years ago to this brave new",
    "world.  Plugging local (and now long-defunct)",
    "bulletin board systems seems kind of pointless,",
    "but those people were still the inspiration",
    "and the beta test crowd for the design.",
    " ",
    "So, a shout-out to the old '95 Kessel's Kantina",
    "crowd - you know who you are.",
    " ",
    "For the 2002 crowd, thanks go to the Nightstar",
    "regulars who provided testbed platforms for",
    "the portability tests.",
    " ",
    " ",
    "< T A R G E T   A C Q U I R E D >",
    " ",
    " ",
    "We regret to inform our vegetarian friends",
    "that some animals were indeed harmed during",
    "the creation of this game.",
    "(\"And EXTRA pepperoni!\")",
    " ",
    " ",
    "Target Acquired @ MCMVC, MMII Michael Martin.",
    "Distributed under the BSD license.",
    " ",
    "Graphics are all @ copyright MCMVC",
    "by their respective creators.",
};

int usage() {
    printf("Invalid commandline argument\n\n");
    printf("Use -f or --fullscreen to play in full screen mode\n");
    printf("Use -w or --window to play in windowed mode\n");
    return 1;
}

int main(int argc, char *argv[])
{
    int menu_selection=0;
    int done = 0;
#ifdef FULLSCREEN_DEFAULT
    int fullscreen = 1;
#else
    int fullscreen = 0;
#endif

    if (argc > 2) {
	exit(usage());
    }

    if (argc == 2) {
	if (!strcmp(argv[1], "--window")) {
	    fullscreen = 0;
	} else if (!strcmp(argv[1], "-w")) {
	    fullscreen = 0;
	} else if (!strcmp(argv[1], "--fullscreen")) {
	    fullscreen = 1;
	} else if (!strcmp(argv[1], "-f")) {
	    fullscreen = 1;
	} else {
	    exit(usage());
	}
    }

    init_SDL_layer(fullscreen);
    loadhiscores();

    momentumconserved = 1;
    speed = 4;

    while(!done) {
	godlike = 0;
	menu_selection = do_main_menu();
	switch(menu_selection) {
	case 1: // Run game
	    rungame();
	    break;
	case 4: // Credits
	    do_short_credits();
	    break;
	case 5: // High scores
	    displayhiscores();
	    break;
	case 6: // Briefing
	    do_briefing();
	    break;
	case 7: // Graphics Test
	    do_graphics_test();
	    break;
	case 8:
	    done = 1;
	    break;
	}
    }
			
    cleanup_SDL_layer();
    return 0;
}

void draw_short_credits(SDL_Surface *where)
{
    draw_graphic(GFX_Credits, 0, 0, where);
    cwriteXE(5, "T A R G E T   A C Q U I R E D", where);
    cwriteXE(130, "Coding by Michael Martin", where);
    cwriteXE(150, "and Brian Crabtree", where);
    cwriteXE(190, "SDL port by Michael Martin", where);
    cwriteXE(230, "Graphics by Rodney Reyes,", where);
    cwriteXE(250, "Justin Hammack, and Devin Lafontaine", where);
    cwriteXE(375,"Press any key to return", where);
}

void do_short_credits()
{
    int done = 0;
    while (!done) {
	SDL_Event event;
	while (SDL_PollEvent(&event)) {
	    if (event.type == SDL_KEYDOWN) {
		done = 1;
	    } else {
		handle_event_top(&event);
	    }
	}
	draw_short_credits(screen);
	SDL_Flip(screen);
    }
}

void do_briefing()
{
    scrollingtext text;
    text.length=25;
    text.lines=story;
    scroll_text(GFX_Briefing, &text, 100);
}

void do_long_credits()
{
    scrollingtext text;
    text.length=78;
    text.lines=endcredits;
    scroll_text(GFX_End_Credits, &text, 50);
}
